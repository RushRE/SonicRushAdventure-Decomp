#include <stage/enemies/ghost.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/audio/spatialAudio.h>
#include <stage/effects/explosion.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_xMin   mapObject->left
#define mapObjectParam_xRange mapObject->width

// --------------------
// CONSTANTS
// --------------------

#define ANGLER_SHOT_COUNT 2

// --------------------
// ENUMS
// --------------------

enum GhostObjectFlags
{
    GHOST_OBJFLAG_NONE,

    GHOST_OBJFLAG_FLIPPED = (1 << 0),
};

enum GhostFlags
{
    GHOST_FLAG_NONE,

    GHOST_FLAG_TURNING      = (1 << 0),
    GHOST_FLAG_USED_BOMB    = (1 << 1),
    GHOST_FLAG_BOMB_BOUNCED = (1 << 2),
};

enum GhostAnimID
{
    GHOST_ANI_MOVING,
    GHOST_ANI_ATTACKING,
    GHOST_ANI_TURNING,
    GHOST_ANI_MACHINE_MOVING,
    GHOST_ANI_MACHINE_TURNING,
    GHOST_ANI_BOMB,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void EnemyGhost_HandleVisibility(EnemyGhost *work);
static void EnemyGhost_Action_Move(EnemyGhost *work);
static void EnemyGhost_State_Moving(EnemyGhost *work);
static void EnemyGhost_OnDefend_Detect(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemyGhost_State_Attack(EnemyGhost *work);
static void EnemyGhost_State_AttackCooldown(EnemyGhost *work);
static void EnemyGhostBomb_State_Dropped(EnemyGhostBomb *work);
static void EnemyGhostBomb_State_Stopped(EnemyGhostBomb *work);
static void EnemyGhostBomb_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemyGhost_Draw(void);
static void EnemyGhost_Destructor(Task *task);

// --------------------
// FUNCTIONS
// --------------------

EnemyGhost *CreateGhost(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (mapObject == NULL || (mapObject->x != MAPOBJECT_DESTROYED || mapObject->y != MAPOBJECT_DESTROYED))
    {
        if (gameState.difficulty == DIFFICULTY_EASY && (mapObject->flags & ENEMYCOMMON_OBJFLAG_DISABLED_ON_EASY) != 0)
            return NULL;
    }

    Task *task = CreateStageTask(EnemyGhost_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_SCOPE_2, EnemyGhost);
    if (task == HeapNull)
        return NULL;

    EnemyGhost *work = TaskGetWork(task, EnemyGhost);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->machineDisplayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;

    if ((mapObject->flags & GHOST_OBJFLAG_FLIPPED) != 0)
    {
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        work->machineDisplayFlag |= DISPLAY_FLAG_FLIP_X;
    }

    SetTaskOutFunc(&work->gameWork.objWork, EnemyGhost_Draw);

    work->xMin = work->gameWork.objWork.position.x + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_xMin);
    work->xMax = work->xMin + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_xRange);

    ObjRect__SetBox2D(&work->collider.rect, -80, 0, 0, 128);
    ObjRect__SetAttackStat(&work->collider, 0, 0);
    ObjRect__SetDefenceStat(&work->collider, ~1, 0);
    ObjRect__SetGroupFlags(&work->collider, 2, 1);
    work->collider.flag |= OBS_RECT_WORK_FLAG_80 | OBS_RECT_WORK_FLAG_40;
    ObjRect__SetOnDefend(&work->collider, EnemyGhost_OnDefend_Detect);
    work->collider.parent = &work->gameWork.objWork;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->aniMachine, "/act/ac_ene_b_ghost.bac", GetObjectDataWork(OBJDATAWORK_11), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_ene_b_ghost.bac", GetObjectDataWork(OBJDATAWORK_11), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetOAMOrder(&work->aniMachine.ani.work, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetOAMPriority(&work->aniMachine.ani.work, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, GHOST_ANI_MOVING, 49);

    work->aniMachine.ani.cParam[0].palette = work->gameWork.objWork.obj_2d->ani.cParam[0].palette;
    work->aniMachine.ani.cParam[1].palette = work->gameWork.objWork.obj_2d->ani.cParam[1].palette;
    work->aniMachine.ani.work.palette      = work->gameWork.objWork.obj_2d->ani.work.palette;
    work->aniMachine.ani.work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;

    EnemyGhost_Action_Move(work);

    work->visibilityMode  = GHOST_VISIBILITY_OPAQUE;
    work->visibilityTimer = 0;

    StageTask__InitSeqPlayer(&work->gameWork.objWork);

    return work;
}

EnemyGhostBomb *CreateGhostBomb(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_SCOPE_2, EnemyGhostBomb);
    if (task == HeapNull)
        return NULL;

    EnemyGhostBomb *work = TaskGetWork(task, EnemyGhostBomb);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjRect__SetDefenceStat(work->gameWork.colliders, 1, 0x41);
    ObjRect__SetOnAttack(&work->gameWork.colliders[1], EnemyGhostBomb_OnHit);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_IN_AIR;

    StageTask__SetGravity(&work->gameWork.objWork, 0xA8, FLOAT_TO_FX32(15.0));
    StageTask__SetHitbox(&work->gameWork.objWork, -4, -3, 3, 4);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_ene_b_ghost.bac", GetObjectDataWork(OBJDATAWORK_11), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, GHOST_ANI_MOVING, 49);
    GameObject__SetAnimation(&work->gameWork, GHOST_ANI_BOMB);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    SetTaskState(&work->gameWork.objWork, EnemyGhostBomb_State_Dropped);

    StageTask__InitSeqPlayer(&work->gameWork.objWork);
    PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_FALL);
    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

    return work;
}

void EnemyGhost_HandleVisibility(EnemyGhost *work)
{
    AnimatorSpriteDS *ani = &work->gameWork.objWork.obj_2d->ani;

    if (work->visibilityTimer > 240)
    {
        work->visibilityMode  = GHOST_VISIBILITY_OPAQUE;
        work->visibilityTimer = 0;
    }
    else if (work->visibilityTimer > 225)
    {
        work->visibilityMode = GHOST_VISIBILITY_TRANSPARENT;
    }
    else if (work->visibilityTimer > 210)
    {
        work->visibilityMode = GHOST_VISIBILITY_FLASHING;
    }
    else if (work->visibilityTimer > 150)
    {
        work->visibilityMode = GHOST_VISIBILITY_INVISIBLE;
    }
    else if (work->visibilityTimer > 135)
    {
        work->visibilityMode = GHOST_VISIBILITY_FLASHING;
    }
    else if (work->visibilityTimer > 120)
    {
        work->visibilityMode = GHOST_VISIBILITY_TRANSPARENT;
    }
    else
    {
        work->visibilityMode = GHOST_VISIBILITY_OPAQUE;
    }

    work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_2;
    work->collider.flag &= ~OBS_RECT_WORK_FLAG_800;

    switch (work->visibilityMode)
    {
        case GHOST_VISIBILITY_OPAQUE:
            ani->work.spriteType = GX_OAM_MODE_NORMAL;
            work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
            work->aniMachine.ani.work.spriteType = GX_OAM_MODE_NORMAL;
            work->machineDisplayFlag &= ~DISPLAY_FLAG_NO_DRAW;
            break;

        case GHOST_VISIBILITY_TRANSPARENT:
            work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
            work->machineDisplayFlag &= ~DISPLAY_FLAG_NO_DRAW;
            ani->work.spriteType                 = GX_OAM_MODE_XLU;
            work->aniMachine.ani.work.spriteType = GX_OAM_MODE_XLU;
            work->collider.flag |= OBS_RECT_WORK_FLAG_800;
            break;

        case GHOST_VISIBILITY_FLASHING:
            if (ani->work.spriteType == GX_OAM_MODE_XLU)
            {
                ani->work.spriteType = GX_OAM_MODE_NORMAL;
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
                work->aniMachine.ani.work.spriteType = GX_OAM_MODE_NORMAL;
                work->machineDisplayFlag |= DISPLAY_FLAG_NO_DRAW;
            }
            else
            {
                ani->work.spriteType = GX_OAM_MODE_XLU;
                work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
                work->aniMachine.ani.work.spriteType = GX_OAM_MODE_XLU;
                work->machineDisplayFlag &= ~DISPLAY_FLAG_NO_DRAW;
            }

            work->collider.flag |= OBS_RECT_WORK_FLAG_800;
            break;

        case GHOST_VISIBILITY_INVISIBLE:
            ani->work.spriteType = GX_OAM_MODE_NORMAL;
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
            work->aniMachine.ani.work.spriteType = GX_OAM_MODE_NORMAL;
            work->machineDisplayFlag |= DISPLAY_FLAG_NO_DRAW;
            work->gameWork.objWork.flag |= STAGE_TASK_FLAG_2;
            work->collider.flag |= OBS_RECT_WORK_FLAG_800;
            break;
    }
}

void EnemyGhost_Action_Move(EnemyGhost *work)
{
    PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOMB_GHOST);
    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

    work->machineDisplayFlag &= ~DISPLAY_FLAG_DID_FINISH;
    work->machineDisplayFlag &= ~DISPLAY_FLAG_DISABLE_LOOPING;

    if (work->aniMachine.ani.work.fileData != NULL)
        AnimatorSpriteDS__SetAnimation(&work->aniMachine.ani, GHOST_ANI_MACHINE_MOVING);

    GameObject__SetAnimation(&work->gameWork, GHOST_ANI_MOVING);

    work->machineDisplayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    work->gameWork.flags &= ~GHOST_FLAG_USED_BOMB;

    SetTaskState(&work->gameWork.objWork, EnemyGhost_State_Moving);
}

void EnemyGhost_State_Moving(EnemyGhost *work)
{
    BOOL shouldTurn = FALSE;

    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

    work->visibilityTimer++;
    EnemyGhost_HandleVisibility(work);

    work->angle += FLOAT_DEG_TO_IDX(2.8125);
    work->gameWork.objWork.velocity.y = CosFX(work->angle) >> 2;

    if ((work->gameWork.flags & GHOST_FLAG_TURNING) != 0)
    {
        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) == 0)
            return;

        work->gameWork.flags &= ~GHOST_FLAG_TURNING;
        work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
        work->machineDisplayFlag ^= DISPLAY_FLAG_FLIP_X;
        EnemyGhost_Action_Move(work);
        work->collider.flag |= OBS_RECT_WORK_FLAG_IS_ACTIVE;
    }

    work->gameWork.objWork.userWork++;
    if (work->gameWork.objWork.userWork >= 60)
    {
        work->collider.flag |= OBS_RECT_WORK_FLAG_IS_ACTIVE;
        work->gameWork.objWork.userWork = 0;
    }

    StageTask__HandleCollider(&work->gameWork.objWork, &work->collider);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        work->gameWork.objWork.velocity.x = -FLOAT_TO_FX32(0.75);
    else
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.75);

    if (work->gameWork.objWork.position.x < work->xMin)
    {
        work->gameWork.objWork.position.x = work->xMin;
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
        shouldTurn                        = TRUE;
    }
    else if (work->gameWork.objWork.position.x > work->xMax)
    {
        work->gameWork.objWork.position.x = work->xMax;
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
        shouldTurn                        = TRUE;
    }

    if (shouldTurn)
    {
        work->machineDisplayFlag &= ~DISPLAY_FLAG_DID_FINISH;
        work->machineDisplayFlag &= ~DISPLAY_FLAG_DISABLE_LOOPING;

        if (work->aniMachine.ani.work.fileData != NULL)
            AnimatorSpriteDS__SetAnimation(&work->aniMachine.ani, GHOST_ANI_MACHINE_TURNING);

        GameObject__SetAnimation(&work->gameWork, GHOST_ANI_TURNING);

        work->collider.flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);

        work->gameWork.flags |= GHOST_FLAG_TURNING;
    }
}

void EnemyGhost_OnDefend_Detect(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
	UNUSED(rect1);
    EnemyGhost *enemy = (EnemyGhost *)rect2->parent;

    enemy->velocityStore               = enemy->gameWork.objWork.velocity.x;
    enemy->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);

    GameObject__SetAnimation(&enemy->gameWork, GHOST_ANI_ATTACKING);

    SetTaskState(&enemy->gameWork.objWork, EnemyGhost_State_Attack);

    enemy->targetPos.x = rect1->parent->position.x;
    enemy->targetPos.y = rect1->parent->position.y;
}

void EnemyGhost_State_Attack(EnemyGhost *work)
{
    EnemyGhost_HandleVisibility(work);

    work->angle += FLOAT_DEG_TO_IDX(2.8125);
    work->gameWork.objWork.velocity.y = CosFX(work->angle) >> 2;

    if (work->gameWork.objWork.obj_2d->ani.work.animID == GHOST_ANI_ATTACKING)
    {
        if (work->gameWork.objWork.obj_2d->ani.work.animFrameIndex == 7)
        {
            if ((work->gameWork.flags & GHOST_FLAG_USED_BOMB) == 0)
            {
                work->gameWork.flags |= GHOST_FLAG_USED_BOMB;

                fx32 bombX;
                if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    bombX = work->gameWork.objWork.position.x + FLOAT_TO_FX32(20.0);
                else
                    bombX = work->gameWork.objWork.position.x - FLOAT_TO_FX32(20.0);

                EnemyGhostBomb *bomb = SpawnStageObject(MAPOBJECT_340, bombX, work->gameWork.objWork.position.y + FLOAT_TO_FX32(10.0), EnemyGhostBomb);

                bomb->gameWork.objWork.velocity.x = bomb->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
                bomb->gameWork.objWork.groundVel                                      = FLOAT_TO_FX32(0.0);

                if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
                {
                    bomb->gameWork.objWork.velocity.x = -FLOAT_TO_FX32(1.0);
                }
                else
                {
                    bomb->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                    bomb->gameWork.objWork.velocity.x = FLOAT_TO_FX32(1.0);
                }
                bomb->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(0.25);
            }
        }

        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        {
            SetTaskState(&work->gameWork.objWork, EnemyGhost_State_AttackCooldown);

            work->gameWork.objWork.userWork = 0;
            GameObject__SetAnimation(&work->gameWork, GHOST_ANI_MOVING);

            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            work->collider.flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;
        }
    }
}

void EnemyGhost_State_AttackCooldown(EnemyGhost *work)
{
    work->visibilityTimer++;
    EnemyGhost_HandleVisibility(work);

    work->angle += FLOAT_DEG_TO_IDX(2.8125);
    work->gameWork.objWork.velocity.y = CosFX(work->angle) >> 2;

    work->gameWork.objWork.userTimer++;
    if (work->gameWork.objWork.userTimer >= 0)
    {
        EnemyGhost_Action_Move(work);
        work->gameWork.objWork.userTimer = 0;
    }

    work->gameWork.objWork.userWork++;
    if (work->gameWork.objWork.userTimer >= 60)
    {
        work->collider.flag |= OBS_RECT_WORK_FLAG_IS_ACTIVE;
        work->gameWork.objWork.userWork = 0;
        work->gameWork.flags &= ~GHOST_FLAG_USED_BOMB;
    }
}

void EnemyGhostBomb_State_Dropped(EnemyGhostBomb *work)
{
    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY) != 0)
    {
        if ((work->gameWork.flags & GHOST_FLAG_BOMB_BOUNCED) != 0)
        {
            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.userTimer  = 0;

            SetTaskState(&work->gameWork.objWork, EnemyGhostBomb_State_Stopped);
        }
        else
        {
            work->gameWork.flags |= GHOST_FLAG_BOMB_BOUNCED;
            work->gameWork.objWork.velocity.x >>= 1;
            work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(0.5);
        }
    }
}

void EnemyGhostBomb_State_Stopped(EnemyGhostBomb *work)
{
    work->gameWork.objWork.userTimer++;
    if (work->gameWork.objWork.userTimer >= 60)
    {
        DestroyStageTask(&work->gameWork.objWork);
        CreateEffectHarmfulExplosion(&work->gameWork.objWork, 0, 0, -17, -20, 14, 11, 7, EXPLOSION_ITEMBOX);
        PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOMB);
        ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
    }
}

void EnemyGhostBomb_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    EnemyGhostBomb *bomb = (EnemyGhostBomb *)rect1->parent;
	UNUSED(rect2);

    DestroyStageTask(&bomb->gameWork.objWork);

    CreateEffectHarmfulExplosion(&bomb->gameWork.objWork, 0, 0, -17, -20, 14, 11, 7, EXPLOSION_ITEMBOX);

    PlayHandleStageSfx(bomb->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOMB);
    ProcessSpatialSfx(bomb->gameWork.objWork.sequencePlayerPtr, &bomb->gameWork.objWork.position);
}

void EnemyGhost_Draw(void)
{
    EnemyGhost *work = TaskGetWorkCurrent(EnemyGhost);

    if (work->gameWork.objWork.obj_2d != NULL && work->gameWork.objWork.obj_2d->ani.work.fileData != NULL)
    {
        // Draw ghost body
        StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);

        u32 displayFlag = work->gameWork.objWork.displayFlag;

        work->aniMachine.ani.work.flags &= ~(ANIMATOR_FLAG_FLIP_Y | ANIMATOR_FLAG_FLIP_X | ANIMATOR_FLAG_DISABLE_LOOPING);
        work->machineDisplayFlag &= ~DISPLAY_FLAG_DID_FINISH;

        // Draw ghost machine
        work->gameWork.objWork.displayFlag = work->machineDisplayFlag;
        StageTask__Draw2D(&work->gameWork.objWork, &work->aniMachine.ani);

        work->machineDisplayFlag           = work->gameWork.objWork.displayFlag;
        work->gameWork.objWork.displayFlag = displayFlag;

        if ((work->gameWork.flags & GAMEOBJECT_FLAG_ALLOW_RESPAWN) != 0)
        {
            work->gameWork.objWork.obj_2d->ani.work.spriteType = GX_OAM_MODE_NORMAL;
            work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
            work->aniMachine.ani.work.spriteType = GX_OAM_MODE_NORMAL;
            work->machineDisplayFlag &= ~DISPLAY_FLAG_NO_DRAW;
        }
    }
}

void EnemyGhost_Destructor(Task *task)
{
    EnemyGhost *work = TaskGetWork(task, EnemyGhost);

    if (work->aniMachine.spriteRef != NULL)
    {
        ObjActionReleaseSprite(&work->aniMachine.spriteRef->engineRef[0], FALSE);
        ObjActionReleaseSprite(&work->aniMachine.spriteRef->engineRef[1], TRUE);
        work->aniMachine.ani.vramPixels[0] = NULL;
        work->aniMachine.ani.vramPixels[1] = NULL;
    }
    else
    {
        if (work->aniMachine.ani.vramPixels[0] != NULL)
            VRAMSystem__FreeSpriteVram(FALSE, work->aniMachine.ani.vramPixels[0]);
        work->aniMachine.ani.vramPixels[0] = NULL;

        if (work->aniMachine.ani.vramPixels[1] != NULL)
            VRAMSystem__FreeSpriteVram(TRUE, work->aniMachine.ani.vramPixels[1]);
        work->aniMachine.ani.vramPixels[1] = NULL;
    }

    if (work->aniMachine.fileWork != NULL)
    {
        ObjDataRelease(work->aniMachine.fileWork);
    }
    else if (work->aniMachine.ani.work.fileData != NULL && (work->gameWork.objWork.flag & STAGE_TASK_FLAG_DISABLE_OBJ_2D_RELEASE) == 0)
    {
        work->aniMachine.ani.work.fileData = NULL;
    }

    GameObject__Destructor(task);
}
