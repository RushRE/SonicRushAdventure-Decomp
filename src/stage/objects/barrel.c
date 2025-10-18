#include <stage/objects/barrel.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/stage/gameSystem.h>
#include <game/audio/spatialAudio.h>
#include <stage/effects/battleBurst.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_dropDistance mapObject->left

// --------------------
// ENUMS
// --------------------

enum CrumblingFloorObjectFlags
{
    BARREL_OBJFLAG_NONE,

    BARREL_OBJFLAG_SPINNING    = 1 << 0,
    BARREL_OBJFLAG_HAS_CAPTURE = 1 << 1,
};

enum BarrelAnimID
{
    BARREL_ANI_EYES_WAKE,
    BARREL_ANI_EYES_SLEEP,
    BARREL_ANI_BARREL_OPEN,
    BARREL_ANI_BARREL_CLOSE,
    BARREL_ANI_CHAIN_NODE,
    BARREL_ANI_BARREL_SLEEP_NORMAL,
    BARREL_ANI_BARREL_SLEEP_HAUNTED,
    BARREL_ANI_EYES_IDLE,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void Barrel_Destructor(Task *task);
static void Barrel_Action_Sleep(Barrel *work);
static void Barrel_State_Sleeping(Barrel *work);
static void Barrel_Action_Open(Barrel *work);
static void Barrel_State_Open(Barrel *work);
static void Barrel_Action_Close(Barrel *work);
static void Barrel_State_Close(Barrel *work);
static void Barrel_Draw(void);
static void Barrel_OnDefend_DropTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Barrel_OnDefend_CaptureTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// VARIABLES
// --------------------

static const s8 offsetTable[] = { 0, 2, 2, -2, -2, -2, 0, -2, 2, 2, -2, 0, 2, 0, -2, -2 };

// --------------------
// FUNCTIONS
// --------------------

Barrel *CreateBarrel(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(Barrel_Destructor, TASK_FLAG_NONE, TASK_PAUSELEVEL_0, TASK_PRIORITY_UPDATE_LIST_START + 0x10F6, TASK_GROUP(2), Barrel);
    if (task == HeapNull)
        return NULL;

    Barrel *work = TaskGetWork(task, Barrel);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    u8 dropDistance = mapObjectParam_dropDistance;
    if (dropDistance > 42)
    {
        mapObjectParam_dropDistance = 42;
    }
    else if (mapObjectParam_dropDistance == 0)
    {
        mapObjectParam_dropDistance = 38;
    }
    work->dropDistance = mapObjectParam_dropDistance << 15;
	
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_barrel.bac", GetObjectDataWork(OBJDATAWORK_161), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 84);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_1);
    StageTask__SetAnimation(&work->gameWork.objWork, BARREL_ANI_BARREL_SLEEP_HAUNTED);

    AnimatorSpriteDS *aniChain = &work->aniChain;
    ObjAction2dBACLoad(aniChain, "/act/ac_gmk_barrel.bac", 1, GetObjectDataWork(OBJDATAWORK_161), gameArchiveStage);
    aniChain->work.cParam.palette = work->gameWork.animator.ani.work.cParam.palette;
    aniChain->cParam[0].palette = aniChain->cParam[1].palette = aniChain->work.cParam.palette;

    AnimatorSpriteDS__SetAnimation(aniChain, BARREL_ANI_CHAIN_NODE);
    StageTask__SetOAMOrder(&aniChain->work, SPRITE_ORDER_23);
    StageTask__SetOAMPriority(&aniChain->work, SPRITE_PRIORITY_1);

    AnimatorSpriteDS *aniEyes = &work->aniEyes;
    ObjAction2dBACLoad(aniEyes, "/act/ac_gmk_barrel.bac", 2, GetObjectDataWork(OBJDATAWORK_161), gameArchiveStage);
    aniEyes->work.cParam.palette = work->gameWork.animator.ani.work.cParam.palette;
    aniEyes->cParam[0].palette = aniEyes->cParam[1].palette = aniEyes->work.cParam.palette;

    AnimatorSpriteDS__SetAnimation(aniEyes, BARREL_ANI_EYES_WAKE);
    StageTask__SetOAMOrder(&aniEyes->work, SPRITE_ORDER_23);
    StageTask__SetOAMPriority(&aniEyes->work, SPRITE_PRIORITY_1);

    SetTaskOutFunc(&work->gameWork.objWork, Barrel_Draw);

    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, -64, -152, 64, FX32_TO_WHOLE(work->dropDistance) - 184);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], Barrel_OnDefend_DropTrigger);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect, -32, 20, 32, 56);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], Barrel_OnDefend_CaptureTrigger);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_NO_PARENT_OFFSET | OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect.pos.x = FX32_TO_WHOLE(work->gameWork.objWork.position.x);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect.pos.y = FX32_TO_WHOLE(work->gameWork.objWork.position.y) - 232;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect.pos.z = FX32_TO_WHOLE(work->gameWork.objWork.position.z);

    Barrel_Action_Sleep(work);

    work->gameWork.objWork.sequencePlayerPtr = AllocSndHandle();

    return work;
}

void Barrel_Destructor(Task *task)
{
    Barrel *work = TaskGetWork(task, Barrel);

    ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_161), &work->aniChain);
    ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_161), &work->aniEyes);

    StopStageSfx(work->gameWork.objWork.sequencePlayerPtr);

    GameObject__Destructor(task);
}

void Barrel_Action_Sleep(Barrel *work)
{
    AnimatorSpriteDS__SetAnimation(&work->aniEyes, BARREL_ANI_EYES_WAKE);
    StageTask__SetAnimation(&work->gameWork.objWork, BARREL_ANI_BARREL_SLEEP_HAUNTED);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;

    work->gameWork.objWork.userTimer = (mtMathRand() + 60) & (128 - 1);

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = NULL;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

    SetTaskState(&work->gameWork.objWork, Barrel_State_Sleeping);
}

void Barrel_State_Sleeping(Barrel *work)
{
    if (work->aniEyes.work.animID == BARREL_ANI_EYES_WAKE)
    {
        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_PAUSED) != 0)
        {
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer <= 0)
            {
                work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_PAUSED;
                work->gameWork.objWork.userTimer = mtMathRandRepeat(128);
            }
        }
        else if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        {
            work->gameWork.objWork.userTimer--;

            work->gameWork.objWork.offset.x = offsetTable[(((playerGameStatus.stageTimer >> 1) & 0x7) * 2) + 0];
            work->gameWork.objWork.offset.y = offsetTable[(((playerGameStatus.stageTimer >> 1) & 0x7) * 2) + 1];

            if (work->gameWork.objWork.userTimer <= 0)
                AnimatorSpriteDS__SetAnimation(&work->aniEyes, BARREL_ANI_EYES_SLEEP);
        }
    }
    else
    {
        if ((work->aniEyes.work.flags & ANIMATOR_FLAG_DID_FINISH) != 0)
            Barrel_Action_Sleep(work);
    }
}

void Barrel_Action_Open(Barrel *work)
{
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = NULL;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

    work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_PAUSED;
    StageTask__SetAnimation(&work->gameWork.objWork, BARREL_ANI_BARREL_OPEN);

    work->gameWork.objWork.userWork = 0;
    work->barrelSpeed               = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.userFlag = 0;

    SetTaskState(&work->gameWork.objWork, Barrel_State_Open);
}

void Barrel_State_Open(Barrel *work)
{
    switch (work->gameWork.objWork.userWork)
    {
        case 0:
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;
                work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

                work->gameWork.objWork.userWork++;

                PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BARREL_DES);
                ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
            }
            break;

        case 1:
            work->barrelSpeed = ObjSpdUpSet(work->barrelSpeed, FLOAT_TO_FX32(0.1875), FLOAT_TO_FX32(15.0));
            work->barrelPos += work->barrelSpeed;

            ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

            if (work->barrelPos >= work->dropDistance)
            {
                work->barrelPos = work->dropDistance;
                Barrel_Action_Close(work);
            }
            break;
    }

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect.pos.x = FX32_TO_WHOLE(work->gameWork.objWork.position.x);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect.pos.y = FX32_TO_WHOLE((work->gameWork.objWork.position.y + work->barrelPos)) - 232;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect.pos.z = FX32_TO_WHOLE(work->gameWork.objWork.position.z);

    work->gameWork.objWork.prevPosition.x = work->gameWork.objWork.position.x;
    work->gameWork.objWork.prevPosition.y = work->gameWork.objWork.position.y + work->barrelPos - FLOAT_TO_FX32(232.0);
    work->gameWork.objWork.prevPosition.z = work->gameWork.objWork.position.z;
}

void Barrel_Action_Close(Barrel *work)
{
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = NULL;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

    StageTask__SetAnimation(&work->gameWork.objWork, BARREL_ANI_BARREL_CLOSE);

    SetTaskState(&work->gameWork.objWork, Barrel_State_Close);

    work->gameWork.objWork.userWork = 0;
    work->gameWork.flags &= ~BARREL_OBJFLAG_SPINNING;

    StopStageSfx(work->gameWork.objWork.sequencePlayerPtr);
}

void Barrel_State_Close(Barrel *work)
{
    Player *player = (Player *)work->gameWork.parent;

    if (player != NULL && CheckPlayerGimmickObj(player, work) == FALSE)
    {
        work->gameWork.parent = NULL;
        work->gameWork.flags &= ~BARREL_OBJFLAG_SPINNING;
        work->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
    }

    switch (work->gameWork.objWork.userWork)
    {
        case 0:
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                if (work->gameWork.parent != NULL)
                {
                    work->barrelSpeed = -FLOAT_TO_FX32(8.0);
                    work->gameWork.flags |= BARREL_OBJFLAG_HAS_CAPTURE;
                }
                else
                {
                    work->barrelSpeed = -FLOAT_TO_FX32(4.0);
                }

                work->gameWork.objWork.userWork++;

                if (work->barrelPos > 0)
                    PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BARREL_RISE);
            }
            break;

        case 1:
            ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

            work->barrelPos += work->barrelSpeed;
            if (work->barrelPos <= 0)
            {
                work->barrelPos                  = FLOAT_TO_FX32(0.0);
                work->gameWork.objWork.userTimer = 16;

                AnimatorSpriteDS__SetAnimation(&work->aniEyes, BARREL_ANI_EYES_SLEEP);
                StageTask__SetAnimation(&work->gameWork.objWork, BARREL_ANI_BARREL_SLEEP_HAUNTED);

                StopStageSfx(work->gameWork.objWork.sequencePlayerPtr);

                work->gameWork.objWork.userWork++;
            }
            break;

        case 2:
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer <= 0 && (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                if (work->gameWork.parent != NULL)
                {
                    work->gameWork.objWork.userWork++;
                }
                else
                {
                    Barrel_Action_Sleep(work);
                    return;
                }
            }
            else
            {
                work->gameWork.objWork.offset.x = offsetTable[(((playerGameStatus.stageTimer >> 1) & 0x7) * 2) + 0];
                work->gameWork.objWork.offset.y = offsetTable[(((playerGameStatus.stageTimer >> 1) & 0x7) * 2) + 1];
            }
            break;

        case 3:
            if (work->gameWork.parent == NULL)
            {
                Barrel_Action_Sleep(work);
                return;
            }
            break;

        case 4:
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                Barrel_Action_Close(work);
            break;
    }

    if (work->gameWork.parent != NULL)
    {
        if ((work->gameWork.parent->userWork & 2) != 0)
        {
            work->gameWork.parent = NULL;
            work->gameWork.flags &= ~BARREL_OBJFLAG_SPINNING;

            work->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
            work->gameWork.objWork.userFlag |= 1;
            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(4.0);
            work->gameWork.objWork.userWork   = 4;

            StageTask__SetAnimation(&work->gameWork.objWork, BARREL_ANI_BARREL_OPEN);
        }
        else if ((work->gameWork.parent->userWork & 1) != 0)
        {
            work->gameWork.objWork.userTimer = work->gameWork.parent->userTimer + 2;
            if ((work->gameWork.flags & BARREL_OBJFLAG_SPINNING) == 0)
                work->angleVelocity = work->gameWork.objWork.userTimer * 128;

            work->gameWork.flags |= BARREL_OBJFLAG_SPINNING;

            CreateEffectBattleBurst(work->gameWork.objWork.position.x + FX32_FROM_WHOLE(mtMathRandRange2(-15, 17)),
                                    work->gameWork.objWork.position.y + work->barrelPos + FX32_FROM_WHOLE(mtMathRandRange2(-215, -183)));

            if (mtMathRandRepeat(2) != 0)
            {
                CreateEffectBattleBurst(work->gameWork.objWork.position.x + FX32_FROM_WHOLE(mtMathRandRange2(-15, 17)),
                                        work->gameWork.objWork.position.y + work->barrelPos + FX32_FROM_WHOLE(mtMathRandRange2(-215, -183)));
            }

            PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DEST_OBJ);
        }

        if ((work->gameWork.flags & BARREL_OBJFLAG_SPINNING) != 0)
        {
            work->gameWork.objWork.dir.z += work->angleVelocity;

            if (work->gameWork.objWork.userTimer > 0)
            {
                if (work->angleVelocity >= 0)
                {
                    if ((s16)work->gameWork.objWork.dir.z >= 2 * work->angleVelocity)
                    {
                        work->angleVelocity = 128 * -work->gameWork.objWork.userTimer;
                        work->gameWork.objWork.userTimer--;
                    }
                }
                else
                {
                    if ((s16)work->gameWork.objWork.dir.z <= 2 * work->angleVelocity)
                    {
                        work->angleVelocity = 128 * work->gameWork.objWork.userTimer;
                        work->gameWork.objWork.userTimer--;
                    }
                }
            }
            else
            {
                if ((work->angleVelocity >= 0 && (s16)work->gameWork.objWork.dir.z >= 0) || (work->angleVelocity < 0 && (s16)work->gameWork.objWork.dir.z < 0))
                {
                    work->gameWork.flags &= ~BARREL_OBJFLAG_SPINNING;
                    work->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
                }
            }
        }
    }

    work->gameWork.objWork.prevPosition.x = work->gameWork.objWork.position.x;
    work->gameWork.objWork.prevPosition.y = work->gameWork.objWork.position.y + work->barrelPos - FLOAT_TO_FX32(232.0);
    work->gameWork.objWork.prevPosition.z = work->gameWork.objWork.position.z;
}

void Barrel_Draw(void)
{
    Barrel *work = TaskGetWorkCurrent(Barrel);

    u32 displayFlag = work->gameWork.objWork.displayFlag;
    if ((work->gameWork.flags & BARREL_OBJFLAG_SPINNING) == 0)
        displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;

    VecFx32 position;
    position.x = work->gameWork.objWork.position.x + work->gameWork.objWork.offset.x;
    position.y = work->gameWork.objWork.position.y + work->barrelPos - FLOAT_TO_FX32(232.0) + work->gameWork.objWork.offset.y;
    position.z = work->gameWork.objWork.position.z;

    if (work->gameWork.objWork.dir.z != FLOAT_DEG_TO_IDX(0.0))
    {
        work->gameWork.objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
        work->aniEyes.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    }
    else
    {
        work->gameWork.objWork.obj_2d->ani.work.flags &= ~ANIMATOR_FLAG_ENABLE_SCALE;
        work->aniEyes.work.flags &= ~ANIMATOR_FLAG_ENABLE_SCALE;
    }

    if (work->gameWork.objWork.obj_2d->ani.work.animID == BARREL_ANI_BARREL_SLEEP_HAUNTED
        && (work->aniEyes.work.animID != BARREL_ANI_EYES_SLEEP || (work->aniEyes.work.flags & ANIMATOR_FLAG_DID_FINISH) == 0))
    {
        StageTask__Draw2DEx(&work->aniEyes, &position, &work->gameWork.objWork.dir, NULL, &work->gameWork.objWork.displayFlag, NULL, NULL);
    }

    StageTask__Draw2DEx(&work->gameWork.objWork.obj_2d->ani, &position, &work->gameWork.objWork.dir, NULL, &work->gameWork.objWork.displayFlag, NULL, NULL);

    s32 chainCount = ((work->barrelPos + FLOAT_TO_FX32(16.0)) >> 15) + 1;

    position.x = work->gameWork.objWork.position.x;
    position.y = work->gameWork.objWork.position.y - FLOAT_TO_FX32(248.0);

    for (s32 c = chainCount; c != 0; c--)
    {
        StageTask__Draw2DEx(&work->aniChain, &position, NULL, NULL, &displayFlag, NULL, NULL);
        position.y += FLOAT_TO_FX32(8.0);
    }
}

void Barrel_OnDefend_DropTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Barrel *barrel = (Barrel *)rect2->parent;
    Player *player = (Player *)rect1->parent;

    if (barrel == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    Barrel_Action_Open(barrel);
}

void Barrel_OnDefend_CaptureTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Barrel *barrel = (Barrel *)rect2->parent;
    Player *player = (Player *)rect1->parent;

    if (barrel == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if (barrel->gameWork.parent != &player->objWork)
    {
        barrel->gameWork.parent = &player->objWork;
        Barrel_Action_Close(barrel);

        barrel->gameWork.flags &= ~BARREL_OBJFLAG_HAS_CAPTURE;
        Player__Action_BarrelGrab(player, &barrel->gameWork);
    }
}