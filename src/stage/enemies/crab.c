#include <stage/enemies/crab.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/audio/spatialAudio.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_xMin        mapObject->left
#define mapObjectParam_xRange      mapObject->width
#define mapObjectParam_maxDistance mapObject->height

// --------------------
// ENUMS
// --------------------

enum CrabAnimID
{
    CRAB_ANI_MOVING,
    CRAB_ANI_BEGIN_ATTACK,
    CRAB_ANI_ATTACKING,
    CRAB_ANI_END_ATTACK,
};

// --------------------
// VARIABLES
// --------------------

static const char *spriteList[] = { "/act/ac_ene_crab.bac" };

// --------------------
// FUNCTION DECLS
// --------------------

static void EnemyCrab_Action_Move(EnemyCrab *work);
static void EnemyCrab_State_Moving(EnemyCrab *work);
static void EnemyCrab_Action_Attack(EnemyCrab *work);
static void EnemyCrab_State_Attacking(EnemyCrab *work);

// --------------------
// FUNCTIONS
// --------------------

EnemyCrab *CreateCrab(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (mapObject == NULL || (mapObject->x != MAPOBJECT_DESTROYED || mapObject->y != MAPOBJECT_DESTROYED))
    {
        if (gameState.difficulty == DIFFICULTY_EASY && (mapObject->flags & ENEMYCOMMON_OBJFLAG_DISABLED_ON_EASY) != 0)
            return NULL;
    }

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_SCOPE_2, EnemyCrab);
    if (task == HeapNull)
        return NULL;

    EnemyCrab *work = TaskGetWork(task, EnemyCrab);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    StageTask__SetHitbox(&work->gameWork.objWork, -20, -24, 20, -4);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

    work->xMin        = work->gameWork.objWork.position.x + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_xMin);
    work->xMax        = work->xMin + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_xRange);
    work->maxDistance = FX32_FROM_WHOLE(work->gameWork.mapObjectParam_maxDistance);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, spriteList[0], GetObjectDataWork(OBJDATAWORK_10), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, CRAB_ANI_MOVING, 43);

    EnemyCrab_Action_Move(work);

    StageTask__InitSeqPlayer(&work->gameWork.objWork);

    return work;
}

void EnemyCrab_Action_Move(EnemyCrab *work)
{
    PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_RAPID_MOVE);

    GameObject__SetAnimation(&work->gameWork, CRAB_ANI_MOVING);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyCrab_State_Moving);
}

void EnemyCrab_State_Moving(EnemyCrab *work)
{
    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        work->gameWork.objWork.velocity.x = -FLOAT_TO_FX32(3.0);
    else
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(3.0);

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
        else
        {
            if (work->gameWork.objWork.position.x > work->xMax)
            {
                work->startX = work->gameWork.objWork.position.x = work->xMax;

                work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
                work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
            }
            else
            {
                if (mtMathRand() < 0x7FF)
                {
                    fx32 distance = MATH_ABS(work->gameWork.objWork.position.x - work->startX);
                    if (distance >= work->maxDistance)
                    {
                        work->startX = work->gameWork.objWork.position.x;

                        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
                        work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
                    }
                }
            }
        }
    }

    if (work->gameWork.objWork.obj_2d->ani.work.animID != CRAB_ANI_BEGIN_ATTACK && work->gameWork.objWork.obj_2d->ani.work.animID != CRAB_ANI_ATTACKING
        && work->gameWork.objWork.obj_2d->ani.work.animID != CRAB_ANI_END_ATTACK)
    {
        work->gameWork.objWork.userTimer++;
        if (work->gameWork.objWork.userTimer >= 120)
            EnemyCrab_Action_Attack(work);
    }
}

void EnemyCrab_Action_Attack(EnemyCrab *work)
{
    GameObject__SetAnimation(&work->gameWork, CRAB_ANI_BEGIN_ATTACK);

    work->velocityStore               = work->gameWork.objWork.velocity.x;
    work->gameWork.objWork.velocity.x = 0;

    SetTaskState(&work->gameWork.objWork, EnemyCrab_State_Attacking);
}

void EnemyCrab_State_Attacking(EnemyCrab *work)
{
    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

    if (work->gameWork.objWork.obj_2d->ani.work.animID == CRAB_ANI_BEGIN_ATTACK && (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        GameObject__SetAnimation(&work->gameWork, CRAB_ANI_ATTACKING);
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        work->gameWork.objWork.userTimer = 0;
        PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_RAPID_ATTACK);
    }
    else if (work->gameWork.objWork.obj_2d->ani.work.animID == CRAB_ANI_ATTACKING)
    {
        work->gameWork.objWork.userTimer++;
        if (work->gameWork.objWork.userTimer >= 120)
        {
            work->gameWork.objWork.userTimer = 0;
            GameObject__SetAnimation(&work->gameWork, CRAB_ANI_END_ATTACK);
        }
    }
    else if (work->gameWork.objWork.obj_2d->ani.work.animID == CRAB_ANI_END_ATTACK && (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        EnemyCrab_Action_Move(work);
    }
}
