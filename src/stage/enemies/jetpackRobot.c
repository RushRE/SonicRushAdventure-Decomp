#include <stage/enemies/jetpackRobot.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/audio/spatialAudio.h>
#include <stage/effects/explosion.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_yMin   mapObject->top
#define mapObjectParam_yRange mapObject->height

// --------------------
// ENUMS
// --------------------

enum JetpackRobotObjectFlags
{
    JETPACKROBOT_OBJFLAG_NONE,

    JETPACKROBOT_OBJFLAG_TYPE_HOVER = (1 << 0),
    JETPACKROBOT_OBJFLAG_TYPE_MASK  = (JETPACKROBOT_OBJFLAG_TYPE_HOVER | 0x02),
};

enum JetpackRobotAnimID
{
    JETPACKROBOT_ANI_HOVER,
    JETPACKROBOT_ANI_MOVE_UP,
    JETPACKROBOT_ANI_MOVE_DOWN,
};

enum JetpackRobotMoveMode
{
    JETPACKROBOT_MOVE_HOVER,
    JETPACKROBOT_MOVE_UP,
    JETPACKROBOT_MOVE_DOWN,
};

// --------------------
// VARIABLES
// --------------------

static const char *spriteList[] = { "/act/ac_ene_prot_jet.bac" };

// --------------------
// FUNCTION DECLS
// --------------------

static void EnemyJetpackRobot_InitFlyRange(EnemyJetpackRobot *work);
static void EnemyJetpackRobot_OnInit_Hover(EnemyJetpackRobot *work);
static void EnemyJetpackRobot_OnInit_Move(EnemyJetpackRobot *work);
static void EnemyJetpackRobot_State_Hover(EnemyJetpackRobot *work);
static void EnemyJetpackRobot_State_Move(EnemyJetpackRobot *work);

// --------------------
// FUNCTIONS
// --------------------

EnemyJetpackRobot *CreateJetpackRobot(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (mapObject == NULL || (mapObject->x != MAPOBJECT_DESTROYED || mapObject->y != MAPOBJECT_DESTROYED))
    {
        if (gameState.difficulty == DIFFICULTY_EASY && (mapObject->flags & ENEMYCOMMON_OBJFLAG_DISABLED_ON_EASY) != 0)
            return NULL;
    }

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_SCOPE_2, EnemyJetpackRobot);
    if (task == HeapNull)
        return NULL;

    EnemyJetpackRobot *work = TaskGetWork(task, EnemyJetpackRobot);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    EnemyJetpackRobot_InitFlyRange(work);

    if ((mapObject->flags & JETPACKROBOT_OBJFLAG_TYPE_MASK) != 0)
    {
        if ((mapObject->flags & JETPACKROBOT_OBJFLAG_TYPE_MASK) == JETPACKROBOT_OBJFLAG_TYPE_HOVER)
        {
            work->type             = JETPACKROBOT_TYPE_HOVER;
            work->onInit           = EnemyJetpackRobot_OnInit_Hover;
            work->hover.animID     = JETPACKROBOT_ANI_HOVER;
            work->hover.angle      = FLOAT_DEG_TO_IDX(0.0);
            work->hover.angleSpeed = FLOAT_DEG_TO_IDX(5.625);
        }
    }
    else
    {
        work->type                 = JETPACKROBOT_TYPE_MOVE;
        work->onInit               = EnemyJetpackRobot_OnInit_Move;
        work->move.animUpID        = JETPACKROBOT_ANI_MOVE_UP;
        work->move.animDownID      = JETPACKROBOT_ANI_MOVE_DOWN;
        work->move.velocityUp      = FLOAT_TO_FX32(1.0);
        work->move.velocityDown    = FLOAT_TO_FX32(2.0);
        work->move.maxDistanceUp   = FLOAT_TO_FX32(5.0);
        work->move.maxDistanceDown = FLOAT_TO_FX32(20.0);
    }

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, spriteList[0], GetObjectDataWork(OBJDATAWORK_8), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, JETPACKROBOT_ANI_HOVER, 40);

    work->onInit(work);

    StageTask__InitSeqPlayer(&work->gameWork.objWork);

    return work;
}

void EnemyJetpackRobot_InitFlyRange(EnemyJetpackRobot *work)
{
    work->yMin = work->gameWork.objWork.position.y + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_yMin);
    work->yMax = work->yMin + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_yRange);
}

void EnemyJetpackRobot_OnInit_Hover(EnemyJetpackRobot *work)
{
    GameObject__SetAnimation(&work->gameWork, work->hover.animID);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyJetpackRobot_State_Hover);
}

void EnemyJetpackRobot_OnInit_Move(EnemyJetpackRobot *work)
{
    GameObject__SetAnimation(&work->gameWork, work->move.animUpID);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    work->gameWork.objWork.velocity.y = -work->move.velocityUp;
    work->gameWork.objWork.userWork   = JETPACKROBOT_MOVE_DOWN;

    SetTaskState(&work->gameWork.objWork, EnemyJetpackRobot_State_Move);
}

void EnemyJetpackRobot_State_Hover(EnemyJetpackRobot *work)
{
    work->gameWork.objWork.velocity.y = CosFX(work->hover.angle) >> 2;
    work->hover.angle += work->hover.angleSpeed;
}

void EnemyJetpackRobot_State_Move(EnemyJetpackRobot *work)
{
    if (work->gameWork.objWork.userWork == JETPACKROBOT_MOVE_DOWN)
    {
        if (work->gameWork.objWork.position.y < work->yMin)
        {
            work->gameWork.objWork.userWork = JETPACKROBOT_MOVE_UP;
        }
        else if (work->gameWork.objWork.position.y - work->yMin < work->move.maxDistanceUp)
        {
            if (work->gameWork.objWork.obj_2d->ani.work.animID != work->move.animDownID)
            {
                GameObject__SetAnimation(&work->gameWork, work->move.animDownID);
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            }

            work->gameWork.objWork.velocity.y = ObjSpdDownSet(work->gameWork.objWork.velocity.y, FLOAT_TO_FX32(0.03125));
            if (work->gameWork.objWork.velocity.y > -FLOAT_TO_FX32(0.25))
                work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(0.25);
        }
        else
        {
            work->gameWork.objWork.velocity.y = ObjSpdUpSet(work->gameWork.objWork.velocity.y, -FLOAT_TO_FX32(0.0625), work->move.velocityUp);
        }
    }
    else if (work->gameWork.objWork.userWork == JETPACKROBOT_MOVE_UP)
    {
        if (work->gameWork.objWork.position.y > work->yMax)
        {
            work->gameWork.objWork.userWork = JETPACKROBOT_MOVE_DOWN;
        }
        else if (work->yMax - work->gameWork.objWork.position.y < work->move.maxDistanceDown)
        {
            if (work->gameWork.objWork.obj_2d->ani.work.animID != work->move.animUpID)
            {
                GameObject__SetAnimation(&work->gameWork, work->move.animUpID);
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_STEAM_FLY);
            }

            work->gameWork.objWork.velocity.y = ObjSpdDownSet(work->gameWork.objWork.velocity.y, FLOAT_TO_FX32(0.1328125));
            if (work->gameWork.objWork.velocity.y < FLOAT_TO_FX32(0.25))
                work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.25);
        }
        else
        {
            work->gameWork.objWork.velocity.y = ObjSpdUpSet(work->gameWork.objWork.velocity.y, FLOAT_TO_FX32(0.03125), work->move.velocityDown);
        }
    }

    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
}
