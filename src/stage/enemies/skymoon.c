#include <stage/enemies/skymoon.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_xMin   mapObject->left
#define mapObjectParam_xRange mapObject->width

// --------------------
// ENUMS
// --------------------

enum SkymoonObjectFlags
{
    SKYMOON_OBJFLAG_NONE,

    SKYMOON_OBJFLAG_FLIPPED = (1 << 0),
};

enum SkymoonAnimID
{
    SKYMOON_ANI_IDLE,
    SKYMOON_ANI_ATTACK_START,
    SKYMOON_ANI_CHARGE_LASER,
    SKYMOON_ANI_LASER_SHOOT,
    SKYMOON_ANI_LASER_MOVE,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void EnemySkymoon_HandleColliderDelay(EnemySkymoon *work);
static void EnemySkymoon_Action_Init(EnemySkymoon *work);
static void EnemySkymoon_State_Idle(EnemySkymoon *work);
static void EnemySkymoon_Action_Move(EnemySkymoon *work);
static void EnemySkymoon_State_Moving(EnemySkymoon *work);
static void EnemySkymoon_Oscillate(EnemySkymoon *work);
static void EnemySkymoon_Acton_Attack(EnemySkymoon *work);
static void EnemySkymoon_State_Attacking(EnemySkymoon *work);
static void EnemySkymoon_OnDefend_Detect(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemySkymoonLaser_State_Active(EnemySkymoonLaser *work);

// --------------------
// FUNCTIONS
// --------------------

EnemySkymoon *CreateSkymoon(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (mapObject == NULL || (mapObject->x != MAPOBJECT_DESTROYED || mapObject->y != MAPOBJECT_DESTROYED))
    {
        if (gameState.difficulty == DIFFICULTY_EASY && (mapObject->flags & ENEMYCOMMON_OBJFLAG_DISABLED_ON_EASY) != 0)
            return NULL;
    }

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_SCOPE_2, EnemySkymoon);
    if (task == HeapNull)
        return NULL;

    EnemySkymoon *work = TaskGetWork(task, EnemySkymoon);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    if (mapObject->id == MAPOBJECT_23)
    {
        // Skymoon (no laser)
        ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_ene_skymoon.bac", GetObjectDataWork(OBJDATAWORK_23), gameArchiveStage,
                                 OBJ_DATA_GFX_AUTO);
        ObjActionAllocSpritePalette(&work->gameWork.objWork, SKYMOON_ANI_IDLE, 100);
    }
    else
    {
        // Skymoon (has laser)
        ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_ene_laser_skymoon.bac", GetObjectDataWork(OBJDATAWORK_24), gameArchiveStage,
                                 OBJ_DATA_GFX_AUTO);
        ObjActionAllocSpritePalette(&work->gameWork.objWork, SKYMOON_ANI_IDLE, 101);

        ObjRect__SetBox2D(&work->colliderDetect.rect, -192, 0, 192, 96);
        ObjRect__SetAttackStat(&work->colliderDetect, 0, 0);
        ObjRect__SetDefenceStat(&work->colliderDetect, ~1, 0);
        ObjRect__SetGroupFlags(&work->colliderDetect, 2, 1);
        work->colliderDetect.flag |= OBS_RECT_WORK_FLAG_80 | OBS_RECT_WORK_FLAG_40;
        ObjRect__SetOnDefend(&work->colliderDetect, EnemySkymoon_OnDefend_Detect);
        work->colliderDetect.parent = &work->gameWork.objWork;
    }

    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    if ((mapObject->flags & SKYMOON_OBJFLAG_FLIPPED) != 0)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    if (mapObjectParam_xRange != 0)
    {
        work->xMin = work->gameWork.objWork.position.x + FX32_FROM_WHOLE(mapObjectParam_xMin);
        work->xMax = work->xMin + FX32_FROM_WHOLE(mapObjectParam_xRange);
    }

    EnemySkymoon_Action_Init(work);

    return work;
}

EnemySkymoonLaser *CreateSkymoonLaser(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_SCOPE_2, EnemySkymoonLaser);
    if (task == HeapNull)
        return NULL;

    EnemySkymoonLaser *work = TaskGetWork(task, EnemySkymoonLaser);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_ene_laser_skymoon.bac", GetObjectDataWork(OBJDATAWORK_24), gameArchiveStage, 8);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, SKYMOON_ANI_LASER_SHOOT, 31);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    GameObject__SetAnimation(&work->gameWork, SKYMOON_ANI_LASER_SHOOT);

    if ((mapObject->flags & SKYMOON_OBJFLAG_FLIPPED) != 0)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    SetTaskState(&work->gameWork.objWork, EnemySkymoonLaser_State_Active);

    return work;
}

void EnemySkymoon_HandleColliderDelay(EnemySkymoon *work)
{
    if (work->timer != 0)
    {
        work->timer--;
        if (work->timer == 0)
            work->colliderDetect.flag |= OBS_RECT_WORK_FLAG_IS_ACTIVE;
    }
}

void EnemySkymoon_Action_Init(EnemySkymoon *work)
{
    if (work->xMin != 0)
    {
        EnemySkymoon_Action_Move(work);
    }
    else
    {
        if (work->gameWork.animator.ani.work.animID != SKYMOON_ANI_IDLE)
            GameObject__SetAnimation(&work->gameWork, SKYMOON_ANI_IDLE);

        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

        SetTaskState(&work->gameWork.objWork, EnemySkymoon_State_Idle);
    }
}

void EnemySkymoon_State_Idle(EnemySkymoon *work)
{
    EnemySkymoon_Oscillate(work);

    if (work->gameWork.mapObject->id == MAPOBJECT_24)
    {
        EnemySkymoon_HandleColliderDelay(work);
        StageTask__HandleCollider(&work->gameWork.objWork, &work->colliderDetect);
    }
}

void EnemySkymoon_Action_Move(EnemySkymoon *work)
{
    if (work->gameWork.animator.ani.work.animID != SKYMOON_ANI_IDLE)
        GameObject__SetAnimation(&work->gameWork, SKYMOON_ANI_IDLE);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemySkymoon_State_Moving);
}

void EnemySkymoon_State_Moving(EnemySkymoon *work)
{
    EnemySkymoon_Oscillate(work);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
    {
        if (work->gameWork.objWork.position.x >= work->xMax)
        {
            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
        }
        else
        {
            work->gameWork.objWork.velocity.x = ObjSpdUpSet(work->gameWork.objWork.velocity.x, FLOAT_TO_FX32(0.125), FLOAT_TO_FX32(0.5));
        }
    }
    else
    {
        if (work->gameWork.objWork.position.x <= work->xMin)
        {
            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
        }
        else
        {
            work->gameWork.objWork.velocity.x = ObjSpdUpSet(work->gameWork.objWork.velocity.x, -FLOAT_TO_FX32(0.125), FLOAT_TO_FX32(0.5));
        }
    }

    if (work->gameWork.mapObject->id == MAPOBJECT_24)
    {
        EnemySkymoon_HandleColliderDelay(work);
        StageTask__HandleCollider(&work->gameWork.objWork, &work->colliderDetect);
    }
}

void EnemySkymoon_Oscillate(EnemySkymoon *work)
{
    work->angle += FLOAT_DEG_TO_IDX(1.40625);
    work->gameWork.objWork.velocity.y = MultiplyFX(SinFX(work->angle), FLOAT_TO_FX32(0.25));
}

void EnemySkymoon_Acton_Attack(EnemySkymoon *work)
{
    GameObject__SetAnimation(&work->gameWork, SKYMOON_ANI_ATTACK_START);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    SetTaskState(&work->gameWork.objWork, EnemySkymoon_State_Attacking);
    work->gameWork.objWork.userWork = 0;
}

void EnemySkymoon_State_Attacking(EnemySkymoon *work)
{
    switch (work->gameWork.objWork.userWork)
    {
        case 0:
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                work->gameWork.objWork.userWork++;
                work->gameWork.objWork.userTimer = 15;
                GameObject__SetAnimation(&work->gameWork, SKYMOON_ANI_CHARGE_LASER);

                u32 flags;
                if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    flags = SKYMOON_OBJFLAG_FLIPPED;
                else
                    flags = SKYMOON_OBJFLAG_NONE;

                fx32 offsetX;
                if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
                    offsetX = -FLOAT_TO_FX32(15.0);
                else
                    offsetX = FLOAT_TO_FX32(15.0);

                EnemySkymoonLaser *laser = SpawnStageObjectFlags(MAPOBJECT_349, work->gameWork.objWork.position.x + offsetX, work->gameWork.objWork.position.y - FLOAT_TO_FX32(1.0),
                                                                 EnemySkymoonLaser, flags);
            }
            break;

        case 1:
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer <= 0)
            {
                work->gameWork.objWork.userWork++;
                GameObject__SetAnimation(&work->gameWork, SKYMOON_ANI_ATTACK_START);
            }
            break;

        case 2:
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
                EnemySkymoon_Action_Init(work);
            }
            break;
    }
}

void EnemySkymoon_OnDefend_Detect(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    EnemySkymoon *enemy = (EnemySkymoon *)rect2->parent;
    Player *player      = (Player *)rect1->parent;

    if ((enemy->gameWork.objWork.flag & STAGE_TASK_FLAG_2) == 0 && enemy->gameWork.mapObject->id == MAPOBJECT_24)
    {
        u16 angle = FX_Atan2Idx(player->objWork.position.y - enemy->gameWork.objWork.position.y, player->objWork.position.x - enemy->gameWork.objWork.position.x);
        if (angle >= FLOAT_DEG_TO_IDX(29.9981689453125) && angle <= FLOAT_DEG_TO_IDX(149.996337890625))
        {
            enemy->timer = 120;
            enemy->colliderDetect.flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;

            if (angle <= FLOAT_DEG_TO_IDX(90.0))
                enemy->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            else
                enemy->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;

            EnemySkymoon_Acton_Attack(enemy);
        }
        else
        {
            ObjRect__FuncNoHit(rect1, rect2);
        }
    }
}

void EnemySkymoonLaser_State_Active(EnemySkymoonLaser *work)
{
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        GameObject__SetAnimation(&work->gameWork, SKYMOON_ANI_LASER_MOVE);

        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
            work->gameWork.objWork.velocity.x = -FLOAT_TO_FX32(2.0);
        else
            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(2.0);
        work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(2.0);

        work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

        SetTaskState(&work->gameWork.objWork, NULL);
    }
}