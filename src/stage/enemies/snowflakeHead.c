#include <stage/enemies/snowflakeHead.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/audio/spatialAudio.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_xMin   mapObject->left
#define mapObjectParam_yMin   mapObject->top
#define mapObjectParam_xRange mapObject->width
#define mapObjectParam_yRange mapObject->height

// --------------------
// ENUMS
// --------------------

enum SnowflakeHeadObjectFlags
{
    SNOWFLAKEHEAD_OBJFLAG_NONE,

    SNOWFLAKEHEAD_OBJFLAG_TYPE_MASK = 0x07,
};

enum SnowflakeHeadAnimID
{
    SNOWFLAKEHEAD_ANI_MOVING,
    SNOWFLAKEHEAD_ANI_ATTACKING,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void EnemySnowflakeHead_Action_Init(EnemySnowflakeHead *work);
static void EnemySnowflakeHead_State_Moving_H(EnemySnowflakeHead *work);
static void EnemySnowflakeHead_State_Moving_V(EnemySnowflakeHead *work);
static void EnemySnowflakeHead_State_Idle(EnemySnowflakeHead *work);
static void EnemySnowflakeHead_HandleAttackTimer(EnemySnowflakeHead *work);
static void EnemySnowflakeHead_State_Attacking(EnemySnowflakeHead *work);

// --------------------
// FUNCTIONS
// --------------------

EnemySnowflakeHead *CreateSnowflakeHead(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (mapObject == NULL || (mapObject->x != MAPOBJECT_DESTROYED || mapObject->y != MAPOBJECT_DESTROYED))
    {
        if (gameState.difficulty == DIFFICULTY_EASY && (mapObject->flags & ENEMYCOMMON_OBJFLAG_DISABLED_ON_EASY) != 0)
            return NULL;
    }

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_SCOPE_2, EnemySnowflakeHead);
    if (task == HeapNull)
        return NULL;

    EnemySnowflakeHead *work = TaskGetWork(task, EnemySnowflakeHead);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    switch (mapObject->flags & SNOWFLAKEHEAD_OBJFLAG_TYPE_MASK)
    {
        case 0:
            work->type = SNOWFLAKEHEAD_TYPE_IDLE;
            break;

        case 1:
            work->type = SNOWFLAKEHEAD_TYPE_MOVING_RIGHT;
            break;

        case 2:
            work->type = SNOWFLAKEHEAD_TYPE_MOVING_LEFT;
            break;

        case 3:
            work->type = SNOWFLAKEHEAD_TYPE_MOVING_UP;
            break;

        case 4:
            work->type = SNOWFLAKEHEAD_TYPE_MOVING_DOWN;
            break;
    }

    switch (work->type)
    {
        case SNOWFLAKEHEAD_TYPE_MOVING_RIGHT:
        case SNOWFLAKEHEAD_TYPE_MOVING_LEFT:
            work->xMin = work->gameWork.objWork.position.x + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_xMin);
            work->xMax = work->xMin + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_xRange);
            break;

        case SNOWFLAKEHEAD_TYPE_MOVING_UP:
        case SNOWFLAKEHEAD_TYPE_MOVING_DOWN:
            work->yMin = work->gameWork.objWork.position.y + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_yMin);
            work->yMax = work->yMin + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_yRange);
            break;
    }
	
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_ene_q_head.bac", GetObjectDataWork(OBJDATAWORK_12), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, SNOWFLAKEHEAD_ANI_MOVING, 53);

    EnemySnowflakeHead_Action_Init(work);

    StageTask__InitSeqPlayer(&work->gameWork.objWork);

    return work;
}

void EnemySnowflakeHead_Action_Init(EnemySnowflakeHead *work)
{
    GameObject__SetAnimation(&work->gameWork, SNOWFLAKEHEAD_ANI_MOVING);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    switch (work->type)
    {
        case SNOWFLAKEHEAD_TYPE_IDLE:
            SetTaskState(&work->gameWork.objWork, EnemySnowflakeHead_State_Idle);
            break;

        case SNOWFLAKEHEAD_TYPE_MOVING_RIGHT:
        case SNOWFLAKEHEAD_TYPE_MOVING_LEFT:
            SetTaskState(&work->gameWork.objWork, EnemySnowflakeHead_State_Moving_H);
            break;

        case SNOWFLAKEHEAD_TYPE_MOVING_UP:
        case SNOWFLAKEHEAD_TYPE_MOVING_DOWN:
            SetTaskState(&work->gameWork.objWork, EnemySnowflakeHead_State_Moving_V);
            break;
    }
}

void EnemySnowflakeHead_State_Moving_H(EnemySnowflakeHead *work)
{
    if (work->gameWork.objWork.position.x < work->xMin)
    {
        work->gameWork.objWork.position.x = work->xMin;
        work->type                        = SNOWFLAKEHEAD_TYPE_MOVING_RIGHT;
    }
    else if (work->gameWork.objWork.position.x > work->xMax)
    {
        work->gameWork.objWork.position.x = work->xMax;
        work->type                        = SNOWFLAKEHEAD_TYPE_MOVING_LEFT;
    }

    if (work->type == SNOWFLAKEHEAD_TYPE_MOVING_RIGHT)
    {
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.75);
        work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
    }
    else if (work->type == SNOWFLAKEHEAD_TYPE_MOVING_LEFT)
    {
        work->gameWork.objWork.velocity.x = -FLOAT_TO_FX32(0.75);
        work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
    }

    EnemySnowflakeHead_HandleAttackTimer(work);
}

void EnemySnowflakeHead_State_Moving_V(EnemySnowflakeHead *work)
{
    if (work->gameWork.objWork.position.y < work->yMin)
    {
        work->gameWork.objWork.position.y = work->yMin;
        work->type                        = SNOWFLAKEHEAD_TYPE_MOVING_DOWN;
    }
    else if (work->gameWork.objWork.position.y > work->yMax)
    {
        work->gameWork.objWork.position.y = work->yMax;
        work->type                        = SNOWFLAKEHEAD_TYPE_MOVING_UP;
    }

    if (work->type == SNOWFLAKEHEAD_TYPE_MOVING_UP)
    {
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
        work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(0.75);
    }
    else if (work->type == SNOWFLAKEHEAD_TYPE_MOVING_DOWN)
    {
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
        work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.75);
    }

    EnemySnowflakeHead_HandleAttackTimer(work);
}

void EnemySnowflakeHead_State_Idle(EnemySnowflakeHead *work)
{
    work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);

    EnemySnowflakeHead_HandleAttackTimer(work);
}

void EnemySnowflakeHead_HandleAttackTimer(EnemySnowflakeHead *work)
{
    work->timer++;
    if (work->timer > 120)
    {
        work->timer = 0;

        PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_CRYSTAL_HEAD);
        ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
        work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);

        SetTaskState(&work->gameWork.objWork, EnemySnowflakeHead_State_Attacking);

        GameObject__SetAnimation(&work->gameWork, SNOWFLAKEHEAD_ANI_ATTACKING);
        ObjRect__SetDefenceStat(work->gameWork.colliders, 1, 0x41);
    }
}

void EnemySnowflakeHead_State_Attacking(EnemySnowflakeHead *work)
{
    if (work->gameWork.animator.ani.work.animFrameIndex == 18)
        ObjRect__SetDefenceStat(work->gameWork.colliders, 1, 0x3F);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        EnemySnowflakeHead_Action_Init(work);
}