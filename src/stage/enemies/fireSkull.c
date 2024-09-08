#include <stage/enemies/fireSkull.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>

// --------------------
// ENUMS
// --------------------

enum FireSkullFlags
{
    FIRESKULL_FLAG_NONE = 0x00,

    FIRESKULL_FLAG_TURNING      = 1 << 0,
    FIRESKULL_FLAG_FACING_RIGHT = 1 << 1,
};

enum FireSkullAnimID
{
    FIRESKULL_ANI_FLY,
    FIRESKULL_ANI_TURN,
    FIRESKULL_ANI_CLING,
    FIRESKULL_ANI_DISAPPEAR,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void EnemyFireSkull_Action_Init(EnemyFireSkull *work);
static void EnemyFireSkull_State_TryFindPlayer(EnemyFireSkull *work);
static void EnemyFireSkull_Action_FailedCatch(EnemyFireSkull *work);
static void EnemyFireSkull_State_FailedCatch(EnemyFireSkull *work);
static void EnemyFireSkull_Action_Cling(EnemyFireSkull *work);
static void EnemyFireSkull_State_PlayerCling(EnemyFireSkull *work);
static void EnemyFireSkull_Action_FlyAway(EnemyFireSkull *work);
static void EnemyFireSkull_State_FlyAway(EnemyFireSkull *work);
static void EnemyFireSkull_Action_Disappear(EnemyFireSkull *work);
static void EnemyFireSkull_State_Disappear(EnemyFireSkull *work);
static void EnemyFireSkull_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

EnemyFireSkull *CreateFireSkull(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (mapObject == NULL || (mapObject->x != MAPOBJECT_DESTROYED || mapObject->y != MAPOBJECT_DESTROYED))
    {
        if (gameState.difficulty == DIFFICULTY_EASY && (mapObject->flags & ENEMYCOMMON_OBJFLAG_DISABLED_ON_EASY) != 0)
            return NULL;
    }

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_SCOPE_2, EnemyFireSkull);
    if (task == HeapNull)
        return NULL;

    EnemyFireSkull *work = TaskGetWork(task, EnemyFireSkull);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_ene_skull_fire.bac", GetObjectDataWork(OBJDATAWORK_22), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, FIRESKULL_ANI_FLY, 114);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    ObjRect__SetAttackStat(&work->gameWork.colliders[1], 0, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[1], ~1, 0);
    ObjRect__SetOnDefend(&work->gameWork.colliders[1], EnemyFireSkull_OnDefend);
    work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_400;

    EnemyFireSkull_Action_Init(work);

    work->gameWork.objWork.sequencePlayerPtr = AllocSndHandle();

    return work;
}

void EnemyFireSkull_Action_Init(EnemyFireSkull *work)
{
    if ((gPlayer->playerFlag & PLAYER_FLAG_DEATH) != 0)
    {
        EnemyFireSkull_Action_FailedCatch(work);
        work->gameWork.objWork.userTimer = 0x7FFFFFFF;
    }
    else
    {
        if (work->gameWork.animator.ani.work.animID != FIRESKULL_ANI_FLY)
            GameObject__SetAnimation(&work->gameWork, FIRESKULL_ANI_FLY);

        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        SetTaskState(&work->gameWork.objWork, EnemyFireSkull_State_TryFindPlayer);
        work->gameWork.objWork.userTimer = 121;
        work->gameWork.objWork.userWork =
            FX_Atan2Idx(gPlayer->objWork.position.y - work->gameWork.objWork.position.y, gPlayer->objWork.position.x - work->gameWork.objWork.position.x);
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
        work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
        work->gameWork.objWork.groundVel  = FLOAT_TO_FX32(0.0);

        work->gameWork.objWork.userFlag--;
        EnemyFireSkull_State_TryFindPlayer(work);
    }
}

void EnemyFireSkull_State_TryFindPlayer(EnemyFireSkull *work)
{
    work->gameWork.objWork.userFlag++;

    if ((gPlayer->playerFlag & PLAYER_FLAG_DEATH) != 0)
    {
        EnemyFireSkull_Action_FailedCatch(work);
        work->gameWork.objWork.userTimer = 0x7FFFFFFF;
    }
    else
    {
        work->gameWork.objWork.userTimer--;

        work->gameWork.objWork.groundVel = ObjSpdUpSet(work->gameWork.objWork.groundVel, FLOAT_TO_FX32(0.25), FLOAT_TO_FX32(3.0));

        fx32 distX = gPlayer->objWork.position.x - work->gameWork.objWork.position.x;
        work->gameWork.objWork.userWork =
            ObjRoopMove16((u16)work->gameWork.objWork.userWork, FX_Atan2Idx(gPlayer->objWork.position.y - work->gameWork.objWork.position.y, distX), FLOAT_DEG_TO_IDX(22.5));

        work->gameWork.objWork.velocity.x = MultiplyFX(work->gameWork.objWork.groundVel, CosFX((s32)(u16)work->gameWork.objWork.userWork));

        work->gameWork.objWork.velocity.y = MultiplyFX(work->gameWork.objWork.groundVel, SinFX((s32)(u16)work->gameWork.objWork.userWork));
        work->gameWork.objWork.velocity.y += MultiplyFX(FLOAT_TO_FX32(0.1875), SinFX((s32)(u16)(s32)(u16)(work->gameWork.objWork.userFlag << 10)));

        if ((work->gameWork.flags & FIRESKULL_FLAG_TURNING) != 0)
        {
            work->gameWork.objWork.velocity.x >>= 1;
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                work->gameWork.flags &= ~FIRESKULL_FLAG_TURNING;
                work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
                GameObject__SetAnimation(&work->gameWork, FIRESKULL_ANI_FLY);
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            }
        }
        else if ((distX < 0 && (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0) || (distX > 0 && (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0))
        {
            work->gameWork.flags |= FIRESKULL_FLAG_TURNING;
            GameObject__SetAnimation(&work->gameWork, FIRESKULL_ANI_TURN);
        }
        else
        {
            if (work->gameWork.objWork.userTimer <= 0)
                EnemyFireSkull_Action_FailedCatch(work);
        }
    }
}

void EnemyFireSkull_Action_FailedCatch(EnemyFireSkull *work)
{
    if (work->gameWork.animator.ani.work.animID != FIRESKULL_ANI_FLY)
        GameObject__SetAnimation(&work->gameWork, FIRESKULL_ANI_FLY);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyFireSkull_State_FailedCatch);

    work->gameWork.objWork.userTimer = 30;
}

void EnemyFireSkull_State_FailedCatch(EnemyFireSkull *work)
{
    work->gameWork.objWork.userFlag++;
    work->gameWork.objWork.userTimer--;

    work->gameWork.objWork.velocity.x = ObjSpdDownSet(work->gameWork.objWork.velocity.x, FLOAT_TO_FX32(0.25));
    work->gameWork.objWork.velocity.y = ObjSpdDownSet(work->gameWork.objWork.velocity.y, FLOAT_TO_FX32(0.25));
    work->gameWork.objWork.velocity.y += MultiplyFX(FLOAT_TO_FX32(0.1875), SinFX((s32)(u16)(s32)(u16)(work->gameWork.objWork.userFlag << 10)));

    if (work->gameWork.objWork.userTimer <= 0)
        EnemyFireSkull_Action_Init(work);
}

void EnemyFireSkull_Action_Cling(EnemyFireSkull *work)
{
    GameObject__SetAnimation(&work->gameWork, FIRESKULL_ANI_CLING);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_1);

    SetTaskState(&work->gameWork.objWork, EnemyFireSkull_State_PlayerCling);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    work->gameWork.objWork.velocity.x = work->gameWork.objWork.position.x - gPlayer->objWork.position.x;
    work->gameWork.objWork.velocity.y = work->gameWork.objWork.position.y - gPlayer->objWork.position.y;

    if (work->gameWork.objWork.velocity.x >= 0)
        work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
    else
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    work->gameWork.objWork.userTimer = 300;
    work->gameWork.objWork.userWork  = 0;
}

void EnemyFireSkull_State_PlayerCling(EnemyFireSkull *work)
{
    work->gameWork.objWork.userFlag++;

    if ((gPlayer->playerFlag & PLAYER_FLAG_DEATH) != 0)
    {
        work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
        EnemyFireSkull_Action_FailedCatch(work);
        work->gameWork.objWork.userTimer = 0x7FFFFFFF;
        StopStageSfx(work->gameWork.objWork.sequencePlayerPtr);
    }
    else
    {
        Player__ApplyClingWeight(gPlayer);

        work->gameWork.objWork.prevPosition = work->gameWork.objWork.position;

        work->gameWork.objWork.position.x = gPlayer->objWork.position.x + work->gameWork.objWork.velocity.x;
        work->gameWork.objWork.position.y = gPlayer->objWork.position.y + work->gameWork.objWork.velocity.y;

        work->gameWork.objWork.userTimer--;
        if (work->gameWork.objWork.userTimer <= 0)
        {
            work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
            EnemyFireSkull_Action_FlyAway(work);
            StopStageSfx(work->gameWork.objWork.sequencePlayerPtr);
        }
        else
        {
            if ((gPlayer->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0 && (work->gameWork.flags & FIRESKULL_FLAG_FACING_RIGHT) != 0
                || (gPlayer->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0 && (work->gameWork.flags & FIRESKULL_FLAG_FACING_RIGHT) == 0)
                work->gameWork.objWork.userWork++;

            if (work->gameWork.objWork.userWork >= 10 || (gPlayer->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
            {
                work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
                EnemyFireSkull_Action_Disappear(work);
            }
        }

        if ((gPlayer->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            work->gameWork.flags |= FIRESKULL_FLAG_FACING_RIGHT;
        else
            work->gameWork.flags &= ~FIRESKULL_FLAG_FACING_RIGHT;

        work->gameWork.objWork.move.x = work->gameWork.objWork.position.x - work->gameWork.objWork.prevPosition.x;
        work->gameWork.objWork.move.y = work->gameWork.objWork.position.y - work->gameWork.objWork.prevPosition.y;
    }
}

void EnemyFireSkull_Action_FlyAway(EnemyFireSkull *work)
{
    if (work->gameWork.animator.ani.work.animID != FIRESKULL_ANI_FLY)
        GameObject__SetAnimation(&work->gameWork, FIRESKULL_ANI_FLY);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    SetTaskState(&work->gameWork.objWork, EnemyFireSkull_State_FlyAway);

    work->gameWork.objWork.userTimer = 120;
    work->gameWork.objWork.userWork  = (u16)(((playerGameStatus.stageTimer << 0x1B) >> 0x13) + FLOAT_DEG_TO_IDX(270.0));
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        work->gameWork.objWork.userWork = (u16)(work->gameWork.objWork.userWork - FLOAT_DEG_TO_IDX(90.0));

    work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.groundVel  = FLOAT_TO_FX32(0.0);
}

void EnemyFireSkull_State_FlyAway(EnemyFireSkull *work)
{
    work->gameWork.objWork.userFlag++;

    work->gameWork.objWork.groundVel  = ObjSpdUpSet(work->gameWork.objWork.groundVel, FLOAT_TO_FX32(0.25), FLOAT_TO_FX32(3.0));
    work->gameWork.objWork.velocity.x = MultiplyFX(work->gameWork.objWork.groundVel, CosFX((s32)(u16)work->gameWork.objWork.userWork));

    work->gameWork.objWork.velocity.y = MultiplyFX(work->gameWork.objWork.groundVel, SinFX((s32)(u16)work->gameWork.objWork.userWork));
    work->gameWork.objWork.velocity.y += MultiplyFX(FLOAT_TO_FX32(0.1875), SinFX((s32)(u16)(s32)(u16)(work->gameWork.objWork.userFlag << 10)));
}

void EnemyFireSkull_Action_Disappear(EnemyFireSkull *work)
{
    GameObject__SetAnimation(&work->gameWork, FIRESKULL_ANI_DISAPPEAR);

    SetTaskState(&work->gameWork.objWork, EnemyFireSkull_State_Disappear);
    work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(1.0);

    work->gameWork.flags |= GAMEOBJECT_FLAG_ALLOW_RESPAWN;
}

void EnemyFireSkull_State_Disappear(EnemyFireSkull *work)
{
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        DestroyStageTask(&work->gameWork.objWork);
}

void EnemyFireSkull_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    EnemyFireSkull *enemy = (EnemyFireSkull *)rect2->parent;
    Player *player        = (Player *)rect1->parent;

    if ((enemy->gameWork.objWork.flag & STAGE_TASK_FLAG_2) != 0)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER || !CheckIsPlayer1(player))
        return;

    if (player->clingWeight >= PLAYER_CLINGWEIGHT_MAX)
    {
        ObjRect__FuncNoHit(rect1, rect2);
    }
    else
    {
        enemy->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_800;
        enemy->gameWork.colliders[0].parent = NULL;

        enemy->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_800;
        enemy->gameWork.colliders[1].parent = NULL;

        EnemyFireSkull_Action_Cling(enemy);
        Player__ApplyClingWeight(player);
        PlayHandleStageSfx(enemy->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SCULL_FIRE);
    }
}
