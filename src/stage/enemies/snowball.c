#include <stage/enemies/snowball.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/audio/spatialAudio.h>
#include <stage/effects/found.h>
#include <stage/effects/explosion.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_xMin   mapObject->left
#define mapObjectParam_xRange mapObject->width

// --------------------
// ENUMS
// --------------------

enum SnowballObjectFlags
{
    SNOWBALL_OBJFLAG_NONE,

    SNOWBALL_OBJFLAG_FLIPPED = (1 << 0),
};

enum SnowballFlags
{
    SNOWBALL_FLAG_NONE,

    SNOWBALL_FLAG_FIRED_SHOT = (1 << 0),
};

enum SnowballAnimID
{
    SNOWBALL_ANI_SNOWBALL_IDLE,
    SNOWBALL_ANI_SNOWBALL_OPEN,
    SNOWBALL_ANI_SNOWBALL_BREAK,
    SNOWBALL_ANI_BODY_IDLE,
    SNOWBALL_ANI_BODY_MOVE,
    SNOWBALL_ANI_SHOT,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void EnemySnowball_SetupRange(EnemySnowball *work);
static void EnemySnowball_Action_Init(EnemySnowball *work, MapObject *mapObject, fx32 x, fx32 y);
static void EnemySnowball_Action_Expose(EnemySnowball *work, MapObject *mapObject, fx32 x, fx32 y);
static void EnemySnowball_Action_InitState(EnemySnowball *work);
static void EnemySnowball_State_HidingSnowball(EnemySnowball *work);
static void EnemySnowball_State_ExposedMoving(EnemySnowball *work);
static void EnemySnowball_OnDefend_Snowball(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemySnowball_State_DestroySnowball(EnemySnowball *work);
static void EnemySnowball_OnDefend_Detect(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemySnowball_State_DetectedPlayer(EnemySnowball *work);
static void EnemySnowballShot_State_Moving(EnemySnowballShot *work);

// --------------------
// FUNCTIONS
// --------------------

EnemySnowball *CreateSnowball(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (mapObject == NULL || (mapObject->x != MAPOBJECT_DESTROYED || mapObject->y != MAPOBJECT_DESTROYED))
    {
        if (gameState.difficulty == DIFFICULTY_EASY && (mapObject->flags & ENEMYCOMMON_OBJFLAG_DISABLED_ON_EASY) != 0)
            return NULL;
    }

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), EnemySnowball);
    if (task == HeapNull)
        return NULL;

    EnemySnowball *work = TaskGetWork(task, EnemySnowball);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->exposedOnDefendFunc = work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].onDefend;
    EnemySnowball_Action_Init(work, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_ene_snowball.bac", GetObjectDataWork(OBJDATAWORK_13), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, SNOWBALL_ANI_SNOWBALL_IDLE, 55);

    EnemySnowball_Action_InitState(work);

    StageTask__InitSeqPlayer(&work->gameWork.objWork);

    return work;
}

EnemySnowballShot *CreateSnowballShot(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), EnemySnowballShot);
    if (task == HeapNull)
        return NULL;

    EnemySnowballShot *work = TaskGetWork(task, EnemySnowballShot);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES | STAGE_TASK_MOVE_FLAG_IN_AIR;
    work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS;

    StageTask__SetHitbox(&work->gameWork.objWork, 3, 3, -3, -3);
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_ene_snowball.bac", GetObjectDataWork(OBJDATAWORK_13), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, SNOWBALL_ANI_SHOT, 75);
    GameObject__SetAnimation(&work->gameWork, SNOWBALL_ANI_SHOT);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemySnowballShot_State_Moving);

    return work;
}

void EnemySnowball_SetupRange(EnemySnowball *work)
{
    work->xMin = work->gameWork.objWork.position.x + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_xMin);
    work->xMax = work->xMin + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_xRange);
}

void EnemySnowball_Action_Init(EnemySnowball *work, MapObject *mapObject, fx32 x, fx32 y)
{
    work->isExposed = FALSE;

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

    if ((mapObject->flags & SNOWBALL_OBJFLAG_FLIPPED) != 0)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    EnemySnowball_SetupRange(work);

    ObjRect__SetBox2D(&work->colliderDetect.rect, -120, -60, 0, 60);
    ObjRect__SetAttackStat(&work->colliderDetect, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->colliderDetect, OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);

    ObjRect__SetGroupFlags(&work->colliderDetect, 2, 1);
    work->colliderDetect.flag |= OBS_RECT_WORK_FLAG_DISABLE_DEF_RESPONSE | OBS_RECT_WORK_FLAG_DISABLE_ATK_RESPONSE;
    ObjRect__SetOnDefend(&work->colliderDetect, EnemySnowball_OnDefend_Detect);
    work->colliderDetect.parent = &work->gameWork.objWork;

    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], EnemySnowball_OnDefend_Snowball);
}

void EnemySnowball_Action_Expose(EnemySnowball *work, MapObject *mapObject, fx32 x, fx32 y)
{
    work->isExposed = TRUE;

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    work->colliderDetect.flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], work->exposedOnDefendFunc);
}

void EnemySnowball_Action_InitState(EnemySnowball *work)
{
    if (work->isExposed == FALSE)
    {
        GameObject__SetAnimation(&work->gameWork, SNOWBALL_ANI_SNOWBALL_IDLE);
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

        SetTaskState(&work->gameWork.objWork, EnemySnowball_State_HidingSnowball);
    }
    else if (work->isExposed == TRUE)
    {
        GameObject__SetAnimation(&work->gameWork, SNOWBALL_ANI_BODY_MOVE);
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

        SetTaskState(&work->gameWork.objWork, EnemySnowball_State_ExposedMoving);
    }

    work->gameWork.flags &= ~SNOWBALL_FLAG_FIRED_SHOT;
}

void EnemySnowball_State_HidingSnowball(EnemySnowball *work)
{
    work->gameWork.objWork.userWork++;
    if (work->gameWork.objWork.userWork >= 120)
    {
        work->colliderDetect.flag |= OBS_RECT_WORK_FLAG_ENABLED;
        work->gameWork.objWork.userWork = 0;
    }

    StageTask__HandleCollider(&work->gameWork.objWork, &work->colliderDetect);
}

void EnemySnowball_State_ExposedMoving(EnemySnowball *work)
{
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        work->gameWork.objWork.velocity.x = -FLOAT_TO_FX32(0.75);
    else
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.75);

    work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_X_COLLISION_CHECK;
    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) != 0)
    {
        work->startX                      = work->gameWork.objWork.position.x;
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);

        work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
        work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_X_COLLISION_CHECK;
    }
    else
    {
        if (work->gameWork.objWork.position.x < work->xMin)
        {
            work->startX = work->gameWork.objWork.position.x = work->xMin;

            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
        }
        else if (work->gameWork.objWork.position.x > work->xMax)
        {
            work->startX = work->gameWork.objWork.position.x = work->xMax;

            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
        }
    }
}

void EnemySnowball_OnDefend_Snowball(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    EnemySnowball *enemy = (EnemySnowball *)rect2->parent;

    if ((u8)GameObject__BadnikBreak(rect1, rect2, GAMEOBJECT_PACKET_OBJ_COLLISION_1) == BADNIKBREAKRESULT_DESTROYED_PLAYER)
    {
        // BUG(?): should this be using "PlayHandleStageSfx"?
        // not using the handle means the spatial sfx can't be processed!

        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ZAKO_DOWN);
        ProcessSpatialSfx(enemy->gameWork.objWork.sequencePlayerPtr, &enemy->gameWork.objWork.position);

        GameObject__SetAnimation(&enemy->gameWork, SNOWBALL_ANI_SNOWBALL_BREAK);

        SetTaskState(&enemy->gameWork.objWork, EnemySnowball_State_DestroySnowball);
    }
}

void EnemySnowball_State_DestroySnowball(EnemySnowball *work)
{
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        EnemySnowball_Action_Expose(work, work->gameWork.mapObject, work->gameWork.objWork.position.x, work->gameWork.objWork.position.y);
        EnemySnowball_Action_InitState(work);
    }
}

void EnemySnowball_OnDefend_Detect(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    EnemySnowball *enemy = (EnemySnowball *)rect2->parent;

    CreateEffectFound(&enemy->gameWork.objWork, FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(53.0));

    SetTaskState(&enemy->gameWork.objWork, EnemySnowball_State_DetectedPlayer);

    enemy->gameWork.objWork.userWork  = 0;
    enemy->gameWork.objWork.userTimer = 0;
}

void EnemySnowball_State_DetectedPlayer(EnemySnowball *work)
{
    if (work->gameWork.objWork.obj_2d->ani.work.animID != SNOWBALL_ANI_SNOWBALL_OPEN)
    {
        work->gameWork.objWork.userTimer++;
        if (work->gameWork.objWork.userTimer <= 30)
            return;

        PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SNOW_BALL);
        ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
        GameObject__SetAnimation(&work->gameWork, SNOWBALL_ANI_SNOWBALL_OPEN);
        work->gameWork.objWork.userTimer = 0;
    }

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_PAUSED) == 0 && work->gameWork.objWork.obj_2d->ani.work.animID == SNOWBALL_ANI_SNOWBALL_OPEN
        && work->gameWork.objWork.obj_2d->ani.work.animFrameIndex >= 7)
    {
        work->gameWork.objWork.userWork++;
        if (work->gameWork.objWork.userWork >= 30 && (work->gameWork.flags & SNOWBALL_FLAG_FIRED_SHOT) == 0)
        {
            PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SHOT);
            ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

            work->colliderDetect.flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
            work->gameWork.objWork.userWork = 0;
            work->gameWork.flags |= SNOWBALL_FLAG_FIRED_SHOT;

            fx32 shotX;
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                shotX = work->gameWork.objWork.position.x + FLOAT_TO_FX32(4.0);
            else
                shotX = work->gameWork.objWork.position.x - FLOAT_TO_FX32(4.0);

            EnemySnowballShot *shot = SpawnStageObject(MAPOBJECT_341, shotX, work->gameWork.objWork.position.y - FLOAT_TO_FX32(24.0), EnemySnowballShot);

            shot->gameWork.objWork.velocity.x = shot->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);

            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                shot->gameWork.objWork.velocity.x = FLOAT_TO_FX32(2.0);
            else
                shot->gameWork.objWork.velocity.x = -FLOAT_TO_FX32(2.0);
        }
    }

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        EnemySnowball_Action_InitState(work);
}

void EnemySnowballShot_State_Moving(EnemySnowballShot *work)
{
    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY) != 0)
    {
        DestroyStageTask(&work->gameWork.objWork);
        CreateEffectExplosion(&work->gameWork.objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), EXPLOSION_SMALL);
    }
}
