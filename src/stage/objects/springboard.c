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

// NOTE: this needs to be here to ensure matching variable order until 'springboard_distanceTable' is decompiled
#ifndef NON_MATCHING
static const char *_TEMP = "/df/gmk_jump45.df";
#endif

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
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, Springboard);
    if (task == HeapNull)
        return NULL;

    Springboard *work = TaskGetWork(task, Springboard);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_jump_stand.bac", GetObjectFileWork(OBJDATAWORK_50), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, SPRINGBOARD_ANI_MILD, 2);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_2;

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

NONMATCH_FUNC void Springboard_LaunchPlayer(Springboard *springboard, Player *player)
{
    // https://decomp.me/scratch/krDV0 -> 98.01%
    // register issue around 'displayFlag = springboard->gameWork.objWork.displayFlag;' (should use R2 but uses R12/IP instead)
#ifdef NON_MATCHING
    fx32 velocity;
    u32 displayFlag;
    fx32 groundVel;
    fx32 springboardX;
    fx32 playerX;
    u32 type;

    groundVel = player->objWork.groundVel;

    fx32 distanceTable[] = { FLOAT_TO_FX32(24.0), FLOAT_TO_FX32(20.0), FLOAT_TO_FX32(12.0) };

    displayFlag = springboard->gameWork.objWork.displayFlag;
    velocity    = player->objWork.groundVel;
    if ((displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
        velocity = -groundVel;

    if (springboard->gameWork.objWork.userWork != 0)
    {
        if ((velocity >= player->spdThresholdRun && (displayFlag & DISPLAY_FLAG_FLIP_X) != 0) || (velocity <= -player->spdThresholdRun && (displayFlag & DISPLAY_FLAG_FLIP_X) == 0))
        {
            springboardX = springboard->gameWork.objWork.position.x;
            playerX      = player->objWork.position.x;
            type         = springboard->gameWork.mapObject->flags & SPRING_OBJFLAG_TYPE_MASK;

            if ((springboardX + distanceTable[type] < playerX && (displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
                && (springboardX - distanceTable[type] > playerX && (displayFlag & DISPLAY_FLAG_FLIP_X) == 0))
            {
                Player__Action_SpringboardLaunch(player, groundVel + velocityTable[3 * type].x, velocityTable[3 * type].y - player->jumpForce);
                Player__Action_AllowTrickCombos(player, &springboard->gameWork);
            }
            else
            {
                if ((springboardX - FLOAT_TO_FX32(4.0) < playerX && (displayFlag & DISPLAY_FLAG_FLIP_X) != 0
                     || springboardX + FLOAT_TO_FX32(4.0) > playerX && (displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
                    && (player->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
                {
                    Player__Action_SpringboardLaunch(player, groundVel + velocityTable[3 * type + 1].x, velocityTable[3 * type + 1].y - player->jumpForce);
                    Player__Action_AllowTrickCombos(player, &springboard->gameWork);
                    Player__Action_RainbowDashRing(player);
                }
            }
        }
    }

    springboard->gameWork.objWork.userWork = player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r4, r1
	ldr r3, [r4, #0xc8]
	ldr r1, =springboard_distanceTable
	mov r5, r0
	add ip, sp, #0
	ldmia r1, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r2, [r5, #0x20]
	ldr r0, [r5, #0x28]
	mov r1, r3
	tst r2, #2
	rsbne r1, r3, #0
	cmp r0, #0
	beq _0215F400
	ldr ip, [r4, #0x648]
	cmp r1, ip
	blt _0215F2F4
	ands r0, r2, #1
	bne _0215F308
_0215F2F4:
	rsb r0, ip, #0
	cmp r1, r0
	bgt _0215F400
	ands r0, r2, #1
	bne _0215F400
_0215F308:
	ldr r1, [r5, #0x340]
	add ip, sp, #0
	ldrh r2, [r1, #4]
	ldr r6, [r5, #0x44]
	ldr r1, [r4, #0x44]
	and r2, r2, #3
	ldr lr, [ip, r2, lsl #2]
	add ip, r6, lr
	cmp ip, r1
	bge _0215F338
	cmp r0, #0
	bne _0215F34C
_0215F338:
	sub ip, r6, lr
	cmp ip, r1
	ble _0215F388
	cmp r0, #0
	bne _0215F388
_0215F34C:
	mov r0, #0x18
	mul ip, r2, r0
	ldr r1, =velocityTable
	ldr r0, =0x0218834C
	ldr r1, [r1, ip]
	ldr ip, [r0, ip]
	ldr r2, [r4, #0x634]
	mov r0, r4
	add r1, r3, r1
	sub r2, ip, r2
	bl Player__Action_SpringboardLaunch
	mov r0, r4
	mov r1, r5
	bl Player__Action_AllowTrickCombos
	b _0215F400
_0215F388:
	sub ip, r6, #0x4000
	cmp ip, r1
	bge _0215F39C
	cmp r0, #0
	bne _0215F3B0
_0215F39C:
	add ip, r6, #0x4000
	cmp ip, r1
	ble _0215F400
	cmp r0, #0
	bne _0215F400
_0215F3B0:
	add r0, r4, #0x700
	ldrh r0, [r0, #0x22]
	tst r0, #3
	beq _0215F400
	mov r0, #0x18
	mul ip, r2, r0
	ldr r1, =0x02188350
	ldr r0, =0x02188354
	ldr r1, [r1, ip]
	ldr ip, [r0, ip]
	ldr r2, [r4, #0x634]
	mov r0, r4
	add r1, r3, r1
	sub r2, ip, r2
	bl Player__Action_SpringboardLaunch
	mov r0, r4
	mov r1, r5
	bl Player__Action_AllowTrickCombos
	mov r0, r4
	bl Player__Action_RainbowDashRing
_0215F400:
	ldr r0, [r4, #0x1c]
	and r0, r0, #1
	str r0, [r5, #0x28]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
// clang-format on
#endif
}
