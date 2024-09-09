#include <stage/enemies/angler.h>
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

enum AnglerObjectFlags
{
    ANGLER_OBJFLAG_NONE,

    ANGLER_OBJFLAG_FLIPPED = (1 << 0),
};

enum AnglerFlags
{
    ANGLER_FLAG_NONE,

    ANGLER_FLAG_TURNING = (1 << 0),
};

enum AnglerAnimID
{
    ANGLER_ANI_MOVING,
    ANGLER_ANI_TURNING,
    ANGLER_ANI_SHOOTING,
    ANGLER_ANI_SHOT,
    ANGLER_ANI_START_CHARGE,
    ANGLER_ANI_CHARGE_ACTIVE,
    ANGLER_ANI_END_CHARGE,

    ANGLER_ANI_CHARGE_PALETTE,
};

// --------------------
// VARIABLES
// --------------------

static const char *spriteList[] = { "/act/ac_ene_angler.bac" };

// --------------------
// FUNCTION DECLS
// --------------------

static void EnemyAngler__Action_Init(EnemyAngler *work);
static void EnemyAngler_State_Moving(EnemyAngler *work);
static void EnemyAngler_OnDefend_Detect(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemyAngler_State_Shoot(EnemyAngler *work);
static void EnemyAnglerShot_State_Moving(EnemyAnglerShot *work);
static void EnemyAngler_State_ShootCooldown(EnemyAngler *work);

// --------------------
// FUNCTIONS
// --------------------

EnemyAngler *CreateAngler(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (mapObject == NULL || (mapObject->x != MAPOBJECT_DESTROYED || mapObject->y != MAPOBJECT_DESTROYED))
    {
        if (gameState.difficulty == DIFFICULTY_EASY && (mapObject->flags & ENEMYCOMMON_OBJFLAG_DISABLED_ON_EASY) != 0)
            return NULL;
    }

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_SCOPE_2, EnemyAngler);
    if (task == HeapNull)
        return NULL;

    EnemyAngler *work = TaskGetWork(task, EnemyAngler);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    switch (mapObject->id)
    {
        case MAPOBJECT_6:
            work->type = ANGLER_TYPE_SHOOT;
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;

            work->xMin = work->gameWork.objWork.position.x + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_xMin);
            work->xMax = work->xMin + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_xRange);

            ObjRect__SetBox2D(&work->colliderDetect.rect, -144, -76, -16, 52);
            ObjRect__SetAttackStat(&work->colliderDetect, 0, 0);
            ObjRect__SetDefenceStat(&work->colliderDetect, ~1, 0);
            ObjRect__SetGroupFlags(&work->colliderDetect, 2, 1);
            work->colliderDetect.flag |= OBS_RECT_WORK_FLAG_80 | OBS_RECT_WORK_FLAG_40;
            ObjRect__SetOnDefend(&work->colliderDetect, EnemyAngler_OnDefend_Detect);
            work->colliderDetect.parent = &work->gameWork.objWork;
            break;

        case MAPOBJECT_7:
            work->type = ANGLER_TYPE_CHARGE;
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;

            work->xMin = work->gameWork.objWork.position.x + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_xMin);
            work->xMax = work->xMin + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_xRange);
            break;
    }

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, spriteList[0], GetObjectDataWork(OBJDATAWORK_9), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    switch (mapObject->id)
    {
        case MAPOBJECT_6:
            ObjActionAllocSpritePalette(&work->gameWork.objWork, ANGLER_ANI_MOVING, 41);
            break;

        case MAPOBJECT_7:
            ObjActionAllocSpritePalette(&work->gameWork.objWork, ANGLER_ANI_CHARGE_PALETTE, 42);
            break;
    }

    if ((mapObject->flags & ANGLER_OBJFLAG_FLIPPED) != 0)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    EnemyAngler__Action_Init(work);

    StageTask__InitSeqPlayer(&work->gameWork.objWork);

    return work;
}

EnemyAnglerShot *CreateAnglerShot(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_SCOPE_2, EnemyAnglerShot);
    if (task == HeapNull)
        return NULL;

    EnemyAnglerShot *work = TaskGetWork(task, EnemyAnglerShot);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES | STAGE_TASK_MOVE_FLAG_IN_AIR;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, spriteList[0], GetObjectDataWork(OBJDATAWORK_9), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, ANGLER_ANI_MOVING, 41);
    GameObject__SetAnimation(&work->gameWork, ANGLER_ANI_SHOT);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyAnglerShot_State_Moving);

    return work;
}

void EnemyAngler__Action_Init(EnemyAngler *work)
{
    GameObject__SetAnimation(&work->gameWork, ANGLER_ANI_MOVING);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyAngler_State_Moving);
}

void EnemyAngler_State_Moving(EnemyAngler *work)
{
    BOOL shouldTurn = FALSE;

    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

    if ((work->gameWork.flags & ANGLER_FLAG_TURNING) != 0)
    {
        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) == 0)
            return;

        work->gameWork.flags &= ~ANGLER_FLAG_TURNING;
        work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
        GameObject__SetAnimation(&work->gameWork, ANGLER_ANI_MOVING);
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        work->colliderDetect.flag |= OBS_RECT_WORK_FLAG_IS_ACTIVE;
    }

    work->gameWork.objWork.userWork++;
    if (work->gameWork.objWork.userWork >= 120)
    {
        work->colliderDetect.flag |= OBS_RECT_WORK_FLAG_IS_ACTIVE;
        work->gameWork.objWork.userWork = 0;
    }

    StageTask__HandleCollider(&work->gameWork.objWork, &work->colliderDetect);

    if (work->type == ANGLER_TYPE_CHARGE)
    {
        if (work->gameWork.objWork.obj_2d->ani.work.animID != ANGLER_ANI_START_CHARGE && work->gameWork.objWork.obj_2d->ani.work.animID != ANGLER_ANI_CHARGE_ACTIVE
            && work->gameWork.objWork.obj_2d->ani.work.animID != ANGLER_ANI_END_CHARGE)
        {
            work->gameWork.objWork.userTimer++;
            if (work->gameWork.objWork.userTimer >= 120)
                GameObject__SetAnimation(&work->gameWork, ANGLER_ANI_START_CHARGE);
        }
        else
        {
            if (work->gameWork.objWork.obj_2d->ani.work.animID == ANGLER_ANI_START_CHARGE && (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                GameObject__SetAnimation(&work->gameWork, ANGLER_ANI_CHARGE_ACTIVE);
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                work->gameWork.objWork.userTimer = 180;
                PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BARRIER_ANGLER);
            }
            else if (work->gameWork.objWork.obj_2d->ani.work.animID == ANGLER_ANI_CHARGE_ACTIVE)
            {
                work->gameWork.objWork.userTimer--;
                if (work->gameWork.objWork.userTimer <= 0)
                {
                    work->gameWork.objWork.userTimer = 0;
                    GameObject__SetAnimation(&work->gameWork, ANGLER_ANI_END_CHARGE);
                }
            }
            else if (work->gameWork.objWork.obj_2d->ani.work.animID == ANGLER_ANI_END_CHARGE && (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                GameObject__SetAnimation(&work->gameWork, ANGLER_ANI_MOVING);
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            }
        }
    }

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        work->gameWork.objWork.velocity.x = -FLOAT_TO_FX32(0.75);
    else
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.75);

    if (work->gameWork.objWork.position.x < work->xMin)
    {
        work->gameWork.objWork.position.x = work->xMin;
        shouldTurn                        = TRUE;
    }
    else if (work->gameWork.objWork.position.x > work->xMax)
    {
        work->gameWork.objWork.position.x = work->xMax;
        shouldTurn                        = TRUE;
    }

    if (shouldTurn)
    {
        if (work->gameWork.objWork.obj_2d->ani.work.animID == ANGLER_ANI_CHARGE_ACTIVE)
        {
            GameObject__SetAnimation(&work->gameWork, ANGLER_ANI_END_CHARGE);
            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
        }
        else if (work->gameWork.objWork.obj_2d->ani.work.animID != ANGLER_ANI_END_CHARGE || (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        {
            GameObject__SetAnimation(&work->gameWork, ANGLER_ANI_TURNING);
            work->colliderDetect.flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;
            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
            work->gameWork.flags |= ANGLER_FLAG_TURNING;
        }
    }
}

void EnemyAngler_OnDefend_Detect(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    EnemyAngler *enemy = (EnemyAngler *)rect2->parent;

    enemy->velocityStore               = enemy->gameWork.objWork.velocity.x;
    enemy->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);

    enemy->shotCount = ANGLER_SHOT_COUNT;
    GameObject__SetAnimation(&enemy->gameWork, ANGLER_ANI_SHOOTING);

    SetTaskState(&enemy->gameWork.objWork, EnemyAngler_State_Shoot);

    enemy->targetPos.x = rect1->parent->position.x;
    enemy->targetPos.y = rect1->parent->position.y;
}

void EnemyAngler_State_Shoot(EnemyAngler *work)
{
    if (work->gameWork.objWork.obj_2d->ani.work.animID == ANGLER_ANI_SHOOTING)
    {
        if ((work->gameWork.objWork.obj_2d->ani.work.animFrameIndex == 10 && work->shotCount == ANGLER_SHOT_COUNT) || (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        {
            fx32 shotX;
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                shotX = work->gameWork.objWork.position.x + FLOAT_TO_FX32(17.0);
            else
                shotX = work->gameWork.objWork.position.x - FLOAT_TO_FX32(17.0);

            EnemyAnglerShot *shot = SpawnStageObject(MAPOBJECT_339, shotX, work->gameWork.objWork.position.y - FLOAT_TO_FX32(20.0), EnemyAnglerShot);

            if (work->shotCount == ANGLER_SHOT_COUNT)
            {
                PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ELEC_DENGEKI);
                ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
            }
            work->shotCount--;

            shot->gameWork.objWork.velocity.x = shot->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
            shot->gameWork.objWork.groundVel                                      = FLOAT_TO_FX32(0.0);

            shot->gameWork.objWork.dir.z = FX_Atan2Idx(work->targetPos.y - shot->gameWork.objWork.position.y, work->targetPos.x - shot->gameWork.objWork.position.x);

            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            {
                if ((s32)shot->gameWork.objWork.dir.z < FLOAT_DEG_TO_IDX(299.9981689453125) && (s32)shot->gameWork.objWork.dir.z > FLOAT_DEG_TO_IDX(180.0))
                {
                    shot->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(299.9981689453125);
                }
                else if ((s32)shot->gameWork.objWork.dir.z > FLOAT_DEG_TO_IDX(59.996337890625) && (s32)shot->gameWork.objWork.dir.z <= FLOAT_DEG_TO_IDX(180.0))
                {
                    shot->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(59.996337890625);
                }
            }
            else
            {
                if ((s32)shot->gameWork.objWork.dir.z > FLOAT_DEG_TO_IDX(239.996337890625))
                {
                    shot->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(239.996337890625);
                }
                else if ((s32)shot->gameWork.objWork.dir.z < FLOAT_DEG_TO_IDX(119.9981689453125))
                {
                    shot->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(119.9981689453125);
                }
            }

            shot->gameWork.objWork.groundVel = FLOAT_TO_FX32(3.0);
        }

        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        {
            SetTaskState(&work->gameWork.objWork, EnemyAngler_State_ShootCooldown);
            work->gameWork.objWork.userWork = 0;
            GameObject__SetAnimation(&work->gameWork, ANGLER_ANI_MOVING);
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            work->colliderDetect.flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;
        }
    }
}

void EnemyAnglerShot_State_Moving(EnemyAnglerShot *work)
{
    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY) != 0)
    {
        DestroyStageTask(&work->gameWork.objWork);
        CreateEffectExplosion(&work->gameWork.objWork, 0, 0, EXPLOSION_ITEMBOX);
    }
}

void EnemyAngler_State_ShootCooldown(EnemyAngler *work)
{
    work->gameWork.objWork.userTimer++;
    if (work->gameWork.objWork.userTimer >= 30)
    {
        EnemyAngler__Action_Init(work);
        work->shotCount                  = ANGLER_SHOT_COUNT;
        work->gameWork.objWork.userTimer = 0;
    }

    work->gameWork.objWork.userWork++;
    if (work->gameWork.objWork.userTimer >= 120)
    {
        work->colliderDetect.flag |= OBS_RECT_WORK_FLAG_IS_ACTIVE;
        work->gameWork.objWork.userWork = 0;
    }
}