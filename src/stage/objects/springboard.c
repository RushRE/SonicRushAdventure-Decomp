#include <stage/objects/springboard.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED u32 springboard_distanceTable[3];

// --------------------
// ENUMS
// --------------------

enum SpringboardObjectFlags
{
    SPRINGBOARD_OBJFLAG_NONE,

    SPRING_OBJFLAG_TYPE_MASK = (1 << 0) | (1 << 1),
    SPRING_OBJFLAG_FLIP_X    = 1 << 2,
};

// this enum doubles as the type list
enum SpringboardAnimIDs
{
    SPRINGBOARD_ANI_MILD,
    SPRINGBOARD_ANI_STEEP,
    SPRINGBOARD_ANI_STEEP_ALT,
};

// --------------------
// VARIABLES
// --------------------

static const Vec2Fx32 velocityTable[9] = {
    { FLOAT_TO_FX32(0.5), -FLOAT_TO_FX32(0.5) },   { FLOAT_TO_FX32(1.0), -FLOAT_TO_FX32(0.5) },   { FLOAT_TO_FX32(1.0), -FLOAT_TO_FX32(0.75) },
    { FLOAT_TO_FX32(0.5), -FLOAT_TO_FX32(0.75) },  { FLOAT_TO_FX32(0.75), -FLOAT_TO_FX32(0.75) }, { FLOAT_TO_FX32(0.75), -FLOAT_TO_FX32(1.0) },
    { FLOAT_TO_FX32(0.375), -FLOAT_TO_FX32(1.0) }, { FLOAT_TO_FX32(0.625), -FLOAT_TO_FX32(1.0) }, { FLOAT_TO_FX32(0.625), -FLOAT_TO_FX32(1.125) },
};

static const char *heightMaskPaths[3] = { "/df/gmk_jump30.df", "/df/gmk_jump45.df", "/df/gmk_jump45.df" };

// --------------------
// FUNCTION DECLS
// --------------------

static void Springboard_State_Active(Springboard *work);
static void Springboard_LaunchPlayer(Springboard *springboard, Player *player);

// --------------------
// FUNCTIONS
// --------------------

Springboard *CreateSpringboard(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), Springboard);
    if (task == HeapNull)
        return NULL;

    Springboard *work = TaskGetWork(task, Springboard);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_jump_stand.bac", GetObjectFileWork(OBJDATAWORK_50), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, SPRINGBOARD_ANI_MILD, 2);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    if ((work->gameWork.mapObject->flags & SPRING_OBJFLAG_FLIP_X) == 0)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    u32 springboardType = mapObject->flags & SPRING_OBJFLAG_TYPE_MASK;
    ObjObjectCollisionDifSet(&work->gameWork.objWork, heightMaskPaths[springboardType], GetObjectFileWork(springboardType + OBJDATAWORK_51), gameArchiveStage);
    work->gameWork.collisionObject.work.parent = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.width  = 48;
    work->gameWork.collisionObject.work.height = 32;
    work->gameWork.collisionObject.work.ofst_x = -24;
    work->gameWork.collisionObject.work.ofst_y = -20;

    StageTask__SetAnimation(&work->gameWork.objWork, work->gameWork.mapObject->flags & SPRING_OBJFLAG_TYPE_MASK);
    SetTaskState(&work->gameWork.objWork, Springboard_State_Active);

    if (Player__UseUpsideDownGravity(work->gameWork.objWork.position.x, work->gameWork.objWork.position.y))
    {
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
        work->gameWork.objWork.fallDir = FLOAT_DEG_TO_IDX(180.0);
    }

    return work;
}

void Springboard_State_Active(Springboard *work)
{
    Player *player = (Player *)work->gameWork.collisionObject.work.riderObj;
    if (player != NULL)
    {
        if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
            Springboard_LaunchPlayer(work, player);
    }
}

void Springboard_LaunchPlayer(Springboard *springboard, Player *player)
{
    fx32 groundVel = player->objWork.groundVel;

    fx32 distanceTable[] = { FLOAT_TO_FX32(24.0), FLOAT_TO_FX32(20.0), FLOAT_TO_FX32(12.0) };

    fx32 velocity   = groundVel;
    u32 displayFlag = springboard->gameWork.objWork.displayFlag;

    if ((displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
        velocity = -groundVel;

    if (springboard->gameWork.objWork.userWork != 0)
    {
        if ((velocity >= player->spdThresholdRun && (displayFlag & DISPLAY_FLAG_FLIP_X) != 0) || (velocity <= -player->spdThresholdRun && (displayFlag & DISPLAY_FLAG_FLIP_X) == 0))
        {
            u32 type = springboard->gameWork.mapObject->flags & SPRING_OBJFLAG_TYPE_MASK;

            if ((springboard->gameWork.objWork.position.x + distanceTable[type] < player->objWork.position.x && (displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                || (springboard->gameWork.objWork.position.x - distanceTable[type] > player->objWork.position.x && (displayFlag & DISPLAY_FLAG_FLIP_X) == 0))
            {
                Player__Action_SpringboardLaunch(player, groundVel + velocityTable[3 * type].x, velocityTable[3 * type].y - player->jumpForce);
                Player__Action_AllowTrickCombos(player, &springboard->gameWork);
            }
            else
            {
				// ??? sure?
                velocity = type;
				
                if (((springboard->gameWork.objWork.position.x - FLOAT_TO_FX32(4.0) < player->objWork.position.x && (displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                     || (springboard->gameWork.objWork.position.x + FLOAT_TO_FX32(4.0) > player->objWork.position.x && (displayFlag & DISPLAY_FLAG_FLIP_X) == 0))
                    && (player->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
                {
                    Player__Action_SpringboardLaunch(player, groundVel + velocityTable[3 * velocity + 1].x, velocityTable[3 * velocity + 1].y - player->jumpForce);
                    Player__Action_AllowTrickCombos(player, &springboard->gameWork);
                    Player__Action_RainbowDashRing(player);
                }
            }
        }
    }

    springboard->gameWork.objWork.userWork = player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
}
