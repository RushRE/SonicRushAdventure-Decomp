
#include <stage/enemies/glider.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_left   mapObject->left
#define mapObjectParam_top    mapObject->top
#define mapObjectParam_width  mapObject->width
#define mapObjectParam_height mapObject->height

// --------------------
// ENUMS
// --------------------

enum EnemyGliderObjectFlags
{
    GLIDER_OBJFLAG_NONE,

    GLIDER_OBJFLAG_WEIGHT_MASK = (1 << 0) | (1 << 1) | (1 << 2),

    GLIDER_OBJFLAG_FROM_LEFT = 1 << 4,
};

enum EnemyGliderAnimID
{
    GLIDER_ANI_GLIDE,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void EnemyGlider_Action_Init(EnemyGlider *work);
static void EnemyGlider_State_Idle(EnemyGlider *work);
static void EnemyGlider_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemyGlider_State_Gliding(EnemyGlider *work);

// --------------------
// FUNCTIONS
// --------------------

EnemyGlider *CreateGlider(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (mapObject == NULL || (mapObject->x != MAPOBJECT_DESTROYED || mapObject->y != MAPOBJECT_DESTROYED))
    {
        if (gameState.difficulty == DIFFICULTY_EASY && (mapObject->flags & ENEMYCOMMON_OBJFLAG_DISABLED_ON_EASY) != 0)
            return NULL;
    }

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_SCOPE_2, EnemyGlider);
    if (task == HeapNull)
        return NULL;

    EnemyGlider *work = TaskGetWork(task, EnemyGlider);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    ObjRect__SetBox2D(&work->collider.rect, work->gameWork.mapObjectParam_left, work->gameWork.mapObjectParam_top,
                      work->gameWork.mapObjectParam_left + work->gameWork.mapObjectParam_width, work->gameWork.mapObjectParam_top + work->gameWork.mapObjectParam_height);
    ObjRect__SetAttackStat(&work->collider, 0, 0);
    ObjRect__SetDefenceStat(&work->collider, ~1, 0);
    ObjRect__SetGroupFlags(&work->collider, 2, 1);
    work->collider.flag |= OBS_RECT_WORK_FLAG_80 | OBS_RECT_WORK_FLAG_40;
    ObjRect__SetOnDefend(&work->collider, EnemyGlider_OnDefend);
    work->collider.parent = &work->gameWork.objWork;

    switch (mapObject->flags & GLIDER_OBJFLAG_WEIGHT_MASK)
    {
        case 0:
            work->gravityStrength = FLOAT_TO_FX32(0.0);
            break;

        case 1:
            work->gravityStrength = FLOAT_TO_FX32(0.04296875);
            break;

        case 2:
            work->gravityStrength = FLOAT_TO_FX32(0.0859375);
            break;

        case 3:
            work->gravityStrength = FLOAT_TO_FX32(0.171875);
            break;

        case 4:
            work->gravityStrength = FLOAT_TO_FX32(0.34375);
            break;

        case 5:
            work->gravityStrength = FLOAT_TO_FX32(0.6875);
            break;

        case 6:
            work->gravityStrength = FLOAT_TO_FX32(1.375);
            break;

        case 7:
            work->gravityStrength = FLOAT_TO_FX32(2.75);
            break;
    }

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_ene_glider.bac", GetObjectFileWork(OBJDATAWORK_14), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, GLIDER_ANI_GLIDE, 59);
    EnemyGlider_Action_Init(work);

    return work;
}

void EnemyGlider_Action_Init(EnemyGlider *work)
{
    GameObject__SetAnimation(&work->gameWork, GLIDER_ANI_GLIDE);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW | DISPLAY_FLAG_DISABLE_LOOPING;
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_800;
    work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_800;
    work->gameWork.colliders[2].flag |= OBS_RECT_WORK_FLAG_800;

    SetTaskState(&work->gameWork.objWork, EnemyGlider_State_Idle);
}

void EnemyGlider_State_Idle(EnemyGlider *work)
{
    StageTask__HandleCollider(&work->gameWork.objWork, &work->collider);
}

void EnemyGlider_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    EnemyGlider *enemy = (EnemyGlider *)rect2->parent;

    if ((enemy->gameWork.mapObject->flags & GLIDER_OBJFLAG_FROM_LEFT) != 0)
        enemy->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    if ((enemy->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        enemy->gameWork.objWork.position.x = mapCamera.camera[0].disp_pos.x - FLOAT_TO_FX32(30.0);
    else
        enemy->gameWork.objWork.position.x = mapCamera.camera[0].disp_pos.x + FLOAT_TO_FX32(HW_LCD_WIDTH + 30.0);

    enemy->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;
    enemy->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_800;
    enemy->gameWork.colliders[1].flag &= ~OBS_RECT_WORK_FLAG_800;
    enemy->gameWork.colliders[2].flag &= ~OBS_RECT_WORK_FLAG_800;
    enemy->collider.flag |= OBS_RECT_WORK_FLAG_800;

    SetTaskState(&enemy->gameWork.objWork, EnemyGlider_State_Gliding);
}

void EnemyGlider_State_Gliding(EnemyGlider *work)
{
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        work->gameWork.objWork.velocity.x = -FLOAT_TO_FX32(2.75);
    else
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(2.75);

    work->gameWork.objWork.velocity.y = work->gravityStrength;
}
