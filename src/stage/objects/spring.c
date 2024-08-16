#include <stage/objects/spring.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <stage/player/starCombo.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_power mapObject->left

// --------------------
// ENUMS
// --------------------

enum SpringObjectFlags
{
    SPRING_OBJFLAG_NONE,

    SPRING_OBJFLAG_APPEAR_ON_USE   = 1 << 0,
    SPRING_OBJFLAG_OFFSET_PLAYER_Y = 1 << 1,
    SPRING_OBJFLAG_HIDDEN          = 1 << 2,
    SPRING_OBJFLAG_NO_COMBO        = 1 << 6,
};

enum SpringAnimIDs
{
    SPRING_ANI_VERTICAL,
    SPRING_ANI_VERTICAL_ACTIVATED,
    SPRING_ANI_HORIZONTAL,
    SPRING_ANI_HORIZONTAL_ACTIVATED,
    SPRING_ANI_DIAGONAL,
    SPRING_ANI_DIAGONAL_ACTIVATED,
    SPRING_ANI_DIAGONAL_HIDDEN,
    SPRING_ANI_DIAGONAL_HIDDEN_ACTIVATED,

    // generic names
    SPRING_ANI_IDLE      = SPRING_ANI_VERTICAL,
    SPRING_ANI_ACTIVATED = SPRING_ANI_VERTICAL_ACTIVATED,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void Spring_Action_Idle(Spring *spring);
static void Spring_State_Idle(Spring *work);
static void Spring_Action_Activate(Spring *spring);
static void Spring_State_Activated(Spring *work);
static void Spring_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

Spring *CreateSpring(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, Spring);
    if (task == HeapNull)
        return NULL;

    Spring *work = TaskGetWork(task, Spring);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_spring.bac", GetObjectFileWork(OBJDATAWORK_27), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 2);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    ObjRect__SetAttackStat(&work->gameWork.colliders[0], 0, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], ~1, 0);
    work->gameWork.colliders[0].onDefend = Spring_OnDefend;
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    u16 id = mapObject->id;
    if (id == MAPOBJECT_68 || id == MAPOBJECT_73 || id == MAPOBJECT_74)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;

    if (id == MAPOBJECT_69 || id == MAPOBJECT_71 || id == MAPOBJECT_73 || id == MAPOBJECT_75)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    // TODO: can this be turned into a switch statement?
    
    // default anim is SPRING_ANI_VERTICAL
    if ((u32)id <= MAPOBJECT_76)
    {
        if ((u32)id >= MAPOBJECT_75) // MAPOBJECT_75 & MAPOBJECT_76
        {
            work->gameWork.objWork.userWork = SPRING_ANI_DIAGONAL_HIDDEN;
        }
        else if ((u32)id >= MAPOBJECT_71) // MAPOBJECT_71, MAPOBJECT_72, MAPOBJECT_73, MAPOBJECT_74
        {
            work->gameWork.objWork.userWork = SPRING_ANI_DIAGONAL;
        }
        else if ((u32)id >= MAPOBJECT_69) // MAPOBJECT_69 & MAPOBJECT_70
        {
            work->gameWork.objWork.userWork = SPRING_ANI_HORIZONTAL;
        }
    }

    Spring_Action_Idle(work);
    return work;
}

void Spring_Action_Idle(Spring *work)
{
    StageTask__SetAnimation(&work->gameWork.objWork, work->gameWork.objWork.userWork + SPRING_ANI_IDLE);
    SetTaskState(&work->gameWork.objWork, Spring_State_Idle);

    if ((work->gameWork.mapObject->flags & (SPRING_OBJFLAG_APPEAR_ON_USE | SPRING_OBJFLAG_HIDDEN)) != 0)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;

    if ((work->gameWork.mapObject->flags & SPRING_OBJFLAG_NO_COMBO) != 0)
        work->gameWork.mapObject->param.tensionPenalty = 0;
}

void Spring_State_Idle(Spring *work)
{
    if (work->gameWork.mapObject->id == MAPOBJECT_335)
    {
        GameObjectTask *parent = (GameObjectTask *)work->gameWork.objWork.parentObj;
        if (parent != NULL)
        {
            if ((parent->flags & 1) != 0)
                StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_1);
            else
                StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
        }
    }
}

void Spring_Action_Activate(Spring *spring)
{
    StageTask__SetAnimation(&spring->gameWork.objWork, spring->gameWork.objWork.userWork + SPRING_ANI_ACTIVATED);
    SetTaskState(&spring->gameWork.objWork, Spring_State_Activated);

    if ((spring->gameWork.mapObject->flags & SPRING_OBJFLAG_HIDDEN) != 0)
        spring->gameWork.objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;
    else
        spring->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_NO_DRAW;

    StageTask__SetAnimatorPriority(&spring->gameWork.objWork, SPRITE_PRIORITY_2);
}

void Spring_State_Activated(Spring *work)
{
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        work->gameWork.colliders[0].flag &= ~(OBS_RECT_WORK_FLAG_40000 | OBS_RECT_WORK_FLAG_20000 | OBS_RECT_WORK_FLAG_100);
        Spring_Action_Idle(work);
    }
}

void Spring_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Spring *spring = (Spring *)rect2->parent;
    Player *player = (Player *)rect1->parent;

    if (spring == NULL)
        return;

    if (player == NULL || player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if ((player->objWork.position.z & ~0x3FF) != (spring->gameWork.objWork.position.z & ~0x3FF))
        return;

    Spring_Action_Activate(spring);

    MapObject *mapObject = spring->gameWork.mapObject;
    u16 id               = mapObject->id;
    s32 power            = mapObjectParam_power;

    if (id == MAPOBJECT_69 || id == MAPOBJECT_70)
    {
        power = MTM_MATH_CLIP(power, 0, 5);
    }

    fx32 velX = FLOAT_TO_FX32(7.5);
    velX += (FLOAT_TO_FX32(1.5) * power);

    fx32 velY = -velX;

    if (id <= MAPOBJECT_68 || id > MAPOBJECT_76)
    {
        velX = 0;
    }
    else if (id <= MAPOBJECT_70)
    {
        velY = 0;
    }

    if (id >= MAPOBJECT_71 && id <= MAPOBJECT_76)
    {
        velX = (0xB5 * velX) >> 8;
        velY = (0xB5 * velY) >> 8;
    }

    if ((spring->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
        velY = -velY;

    u16 value = (id + (u16)-MAPOBJECT_69);
    if ((spring->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        velX = -velX;

    if (value <= 1 && (mapObject->flags & SPRING_OBJFLAG_OFFSET_PLAYER_Y) == 0)
        player->objWork.position.y = spring->gameWork.objWork.position.y + FLOAT_TO_FX32(2.0);

    Player__Action_Spring(player, velX, velY);

    if (spring->gameWork.mapObject->id == MAPOBJECT_335)
    {
        GameObjectTask *gimmickObj = (GameObjectTask *)spring->gameWork.objWork.parentObj;
        if (gimmickObj != NULL)
            Player__Action_AllowTrickCombos(player, gimmickObj);
    }
    else
    {
        Player__Action_AllowTrickCombos(player, &spring->gameWork);
    }

    if ((spring->gameWork.mapObject->flags & SPRING_OBJFLAG_NO_COMBO) != 0)
    {
        player->starComboCount = 0;
        StarCombo__FailCombo(player);
    }
}
