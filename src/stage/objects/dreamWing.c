#include <stage/objects/dreamWing.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <stage/effects/steam.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

// used in DreamWing
#define mapObjectParam_burstInterval mapObject->left

// used in DreamWingHangChain
#define mapObjectParam_size mapObject->height

// --------------------
// ENUMS
// --------------------

enum DreamWingFlags
{
    DREAMWING_FLAG_NONE,

    DREAMWING_FLAG_EXHAUST_ACTIVE = 1 << 0,
};

enum DreamWingObjectFlags
{
    DREAMWING_OBJFLAG_NONE,

    DREAMWING_OBJFLAG_FLIPPED = 1 << 0,
};

enum DreamWingAnimID
{
    DREAMWING_ANI_WING_IDLE,
    DREAMWING_ANI_WING_ATTACH,
    DREAMWING_ANI_WING_GLIDE,
    DREAMWING_ANI_CHAIN,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void DreamWing_State_AttachedToPlayer(DreamWing *work);
static void DreamWing_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

static void DreamWingHangChain_Draw(void);

// --------------------
// FUNCTIONS
// --------------------

DreamWing *CreateDreamWing(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = TaskCreate(StageTask_Main, GameObject__Destructor, TASK_FLAG_NONE, TASK_PAUSELEVEL_0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), DreamWing);
    if (task == HeapNull)
        return NULL;

    DreamWing *work = TaskGetWork(task, DreamWing);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_dream_wing.bac", GetObjectFileWork(OBJDATAWORK_184), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, DREAMWING_ANI_WING_IDLE, 32);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_1);
    StageTask__SetAnimation(&work->gameWork.objWork, DREAMWING_ANI_WING_IDLE);

    if ((mapObject->flags & DREAMWING_OBJFLAG_FLIPPED) != 0)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], DreamWing_OnDefend);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    work->gameWork.objWork.sequencePlayerPtr = AllocSndHandle();

    return work;
}

DreamWingHangChain *CreateDreamWingHangChain(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = TaskCreate(StageTask_Main, GameObject__Destructor, TASK_FLAG_NONE, TASK_PAUSELEVEL_0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), DreamWingHangChain);
    if (task == HeapNull)
        return NULL;

    DreamWingHangChain *work = TaskGetWork(task, DreamWingHangChain);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;

    if (work->gameWork.mapObjectParam_size <= 7)
        work->gameWork.objWork.userWork = 1;
    else
        work->gameWork.objWork.userWork = work->gameWork.mapObjectParam_size >> 3;

    if (work->gameWork.objWork.userWork > 16)
        work->gameWork.objWork.userWork = 16;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_dream_wing.bac", GetObjectFileWork(OBJDATAWORK_184), gameArchiveStage,
                             OBJ_DATA_GFX_NONE);

    ObjObjectActionAllocSprite(&work->gameWork.objWork, 1, GetObjectSpriteRef(OBJDATAWORK_185));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, DREAMWING_ANI_WING_IDLE, 32);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_22);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_1);
    StageTask__SetAnimation(&work->gameWork.objWork, DREAMWING_ANI_CHAIN);

    work->gameWork.objWork.collisionObj           = NULL;
    work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
    work->gameWork.collisionObject.work.width     = 16;
    work->gameWork.collisionObject.work.height    = 8 * work->gameWork.objWork.userWork;
    work->gameWork.collisionObject.work.ofst_x    = -4;
    work->gameWork.collisionObject.work.ofst_y    = -8 * work->gameWork.objWork.userWork + 4;
    if ((mapObject->flags & DREAMWING_OBJFLAG_FLIPPED) != 0)
        work->gameWork.collisionObject.work.ofst_x -= 8;

    SetTaskOutFunc(&work->gameWork.objWork, DreamWingHangChain_Draw);

    return work;
}

void DreamWing_State_AttachedToPlayer(DreamWing *work)
{
    if (work->gameWork.animator.ani.work.animID == DREAMWING_ANI_WING_ATTACH && (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        StageTask__SetAnimation(&work->gameWork.objWork, DREAMWING_ANI_WING_GLIDE);
        StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    }

    Player *player = (Player *)work->gameWork.parent;
    if (player != NULL && CheckPlayerGimmickObj(player, work))
    {
        work->gameWork.objWork.prevPosition.x = work->gameWork.objWork.position.x;
        work->gameWork.objWork.prevPosition.y = work->gameWork.objWork.position.y;

        work->gameWork.objWork.position.x = player->objWork.position.x;
        work->gameWork.objWork.position.y = player->objWork.position.y - FLOAT_TO_FX32(16.0);

        work->gameWork.objWork.move.x = work->gameWork.objWork.position.x - work->gameWork.objWork.prevPosition.x;
        work->gameWork.objWork.move.y = work->gameWork.objWork.position.y - work->gameWork.objWork.prevPosition.y;

        if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY) == 0)
        {
            work->gameWork.objWork.velocity.x = player->objWork.velocity.x;
            work->gameWork.objWork.velocity.y = player->objWork.velocity.y;
        }

		// spawn a large
        if (work->playerBurstCount < player->objWork.userWork)
        {
            fx32 offsetX = -FLOAT_TO_FX32(18.0);

            work->playerBurstCount = player->objWork.userWork;
            work->gameWork.flags |= DREAMWING_FLAG_EXHAUST_ACTIVE;
            work->burstSteamPuffTimer = 0;

            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                offsetX = -offsetX;

            EffectSteamEffect__Create(EFFECTSTEAM_TYPE_SMALL, work->gameWork.objWork.position.x + offsetX, work->gameWork.objWork.position.y, -work->gameWork.objWork.move.x >> 2,
                                      -work->gameWork.objWork.move.y >> 2, FLOAT_TO_FX32(16.0));

            StopStageSfx(work->gameWork.objWork.sequencePlayerPtr);
            PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DREAM_FLY);
        }

        if ((work->gameWork.flags & DREAMWING_FLAG_EXHAUST_ACTIVE) != 0)
        {
            if ((player->objWork.userFlag & DREAMWING_PLAYERFLAG_EXHAUST_ACTIVE) == 0)
            {
                work->gameWork.flags &= ~DREAMWING_FLAG_EXHAUST_ACTIVE;
            }
            else
            {
                work->burstSteamPuffTimer++;
                if ((work->burstSteamPuffTimer & 3) == 0)
                {
                    fx32 offsetX = -FLOAT_TO_FX32(18.0);
                    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                        offsetX = -offsetX;

                    EffectSteamEffect__Create(EFFECTSTEAM_TYPE_LARGE, work->gameWork.objWork.position.x + offsetX, work->gameWork.objWork.position.y, -work->gameWork.objWork.move.x >> 2,
                                              -work->gameWork.objWork.move.y >> 2, FLOAT_TO_FX32(16.0));
                }
            }
        }
    }
    else
    {
        if (player != NULL)
        {
            work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
            work->gameWork.parent = NULL;
        }

        if (work->gameWork.animator.ani.work.animID == DREAMWING_ANI_WING_GLIDE)
            SetTaskState(&work->gameWork.objWork, NULL);
    }
}

void DreamWing_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    DreamWing *dreamWing = (DreamWing *)rect2->parent;
    Player *player       = (Player *)rect1->parent;

    if (dreamWing == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER || !CheckIsPlayer1(player))
        return;

    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0
        || ((dreamWing->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0 && player->objWork.move.x < FLOAT_TO_FX32(0.0))
        || ((dreamWing->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0 && player->objWork.move.x > FLOAT_TO_FX32(0.0))
        || (player->objWork.move.x == FLOAT_TO_FX32(0.0)
            && (((dreamWing->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0 && (player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                || ((dreamWing->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0 && (player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0))))
    {
        ObjRect__FuncNoHit(rect1, rect2);
    }
    else
    {
        dreamWing->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

        dreamWing->gameWork.parent = &player->objWork;

        u16 angle = player->objWork.dir.z;
        if (((dreamWing->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0 && angle != FLOAT_DEG_TO_IDX(0.0) && angle <= FLOAT_DEG_TO_IDX(180.0))
            || ((dreamWing->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0 && angle > FLOAT_DEG_TO_IDX(180.0)))
            angle = FLOAT_DEG_TO_IDX(0.0);

        if ((dreamWing->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            angle += FLOAT_DEG_TO_IDX(180.0);

        fx32 speed = ClampS32(MATH_ABS(player->objWork.groundVel) + MATH_ABS(player->objWork.velocity.x), FLOAT_TO_FX32(3.0), FLOAT_TO_FX32(9.0));

        dreamWing->gameWork.objWork.velocity.x = MultiplyFX(speed, CosFX((s32)(u16)angle));
        dreamWing->gameWork.objWork.velocity.y = MultiplyFX(speed, SinFX((s32)(u16)angle));

        StageTask__SetAnimation(&dreamWing->gameWork.objWork, DREAMWING_ANI_WING_ATTACH);
        SetTaskState(&dreamWing->gameWork.objWork, DreamWing_State_AttachedToPlayer);

        Player__Action_DreamWing(player, &dreamWing->gameWork, dreamWing->gameWork.objWork.velocity.x, dreamWing->gameWork.objWork.velocity.y,
                                 4 * dreamWing->gameWork.mapObjectParam_burstInterval + 10);
    }
}

void DreamWingHangChain_Draw(void)
{
    s32 i;

    DreamWingHangChain *work = TaskGetWorkCurrent(DreamWingHangChain);

    AnimatorSpriteDS *animator = &work->gameWork.objWork.obj_2d->ani;

    VecFx32 position = work->gameWork.objWork.position;

    for (i = work->gameWork.objWork.userWork; i > 0; i--)
    {
        StageTask__Draw2DEx(animator, &position, NULL, NULL, &work->gameWork.objWork.displayFlag, NULL, NULL);
        position.y -= FLOAT_TO_FX32(8.0);
    }
}