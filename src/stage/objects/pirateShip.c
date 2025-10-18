#include <stage/objects/pirateShip.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/stage/gameSystem.h>
#include <stage/effects/pirateShipCannonBlast.h>
#include <stage/effects/explosion.h>
#include <stage/effects/groundExplosion.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_distanceUnits    mapObject->top   // 1 = 100 pixels
#define mapObjectParam_distanceSubUnits mapObject->width // 1 = 1 pixel

// --------------------
// ENUMS
// --------------------

enum PirateShipFlags
{
    PIRATESHIP_FLAG_NONE,

    PIRATESHIP_FLAG_MOVING_LEFT = 1 << 0,
};

// --------------------
// VARIABLES
// --------------------

static s16 cannonBallShootIntervalTable[] = { 25, 15, 20, 15, 25, 5, 10, 20, 5, 15, 25, 20, 10, 25, 20, 15 };
static s16 cannonBallSpawnPosTable[]      = { 0, -41, -37, -34, -21, -38, 39, -34, 0, -41, -37, -34, 22, -39, 39, -34 };
static s16 cannonBallVelocityXTable[]     = { 56, -88, 108, -56, 72, -76, 64, -64, 80, -80, 96, -72, 48, -60, 88, -48 };

NOT_DECOMPILED void *aActAcGmkPirate_0;

// --------------------
// FUNCTION DECLS
// --------------------

static void PirateShip_State_Appear(PirateShip *work);
static void PirateShip_State_Active(PirateShip *work);
static void PirateShip_State_Disappear(PirateShip *work);
static void PirateShip_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static fx32 PirateShip_GetPlayerVelocity(Player *player);

static void PirateShipCannonBall_State_Active(PirateShipCannonBall *work);
static void PirateShipCannonBall_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC PirateShip *CreatePirateShip(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // should match, just waiting on 'aActAcGmkPirate_0' to be decompiled!
#ifdef NON_MATCHING
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), PirateShip);
    if (task == HeapNull)
        return NULL;

    PirateShip *work = TaskGetWork(task, PirateShip);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_pirate_ship.bac", GetObjectDataWork(OBJDATAWORK_162), gameArchiveStage, 119);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, PIRATESHIP_ANI_SHIP, 87);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_3);
    StageTask__SetAnimation(&work->gameWork.objWork, PIRATESHIP_ANI_SHIP);

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, 0, -512, 64, 0);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], PirateShip_OnDefend);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    work->startPos = work->gameWork.objWork.position.x - FLOAT_TO_FX32(32.0);
    work->endPos   = work->gameWork.objWork.position.x + FX32_FROM_WHOLE((mapObjectParam_distanceSubUnits + 100 * mapObjectParam_distanceUnits)) + FLOAT_TO_FX32(32.0);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x378
	ldr r0, =StageTask_Main
	ldr r1, =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x378
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xa2
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x20
	str r1, [r4, #0x20]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	mov r1, #0x77
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, =aActAcGmkPirate_0
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x57
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #3
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	str r4, [r4, #0x234]
	mov r1, #0
	str r1, [sp]
	add r0, r4, #0x218
	sub r2, r1, #0x200
	mov r3, #0x40
	bl ObjRect__SetBox2D
	add r0, r4, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, =PirateShip_OnDefend
	mov r0, #0x64
	str r1, [r4, #0x23c]
	ldr r1, [r4, #0x230]
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x44]
	sub r1, r1, #0x20000
	str r1, [r4, #0x368]
	ldr r3, [r4, #0x44]
	ldrb r2, [r7, #8]
	ldrsb r1, [r7, #7]
	mla r0, r1, r0, r2
	add r0, r3, r0, lsl #12
	add r0, r0, #0x20000
	str r0, [r4, #0x36c]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC PirateShipCannonBall *CreatePirateShipCannonBall(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    // https://decomp.me/scratch/YuFeZ -> 97.96%
    // issue with return instruction?
#ifdef NON_MATCHING
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), PirateShipCannonBall);
    if (task == HeapNull)
        return NULL;

    PirateShipCannonBall *work = TaskGetWork(task, PirateShipCannonBall);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_X_COLLISION_CHECK;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_pirate_ship.bac", GetObjectDataWork(OBJDATAWORK_162), gameArchiveStage,
                             OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 8, GetObjectSpriteRef(OBJDATAWORK_163));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, PIRATESHIP_ANI_CANNONBALL, 83);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, PIRATESHIP_ANI_CANNONBALL);
    ObjRect__SetDefenceStat(work->gameWork.colliders, OBS_RECT_WORK_ATTR_BODY, OBS_RECT_DEFPOWER_DEFAULT + 2);
    ObjRect__SetOnAttack(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], PirateShipCannonBall_OnHit);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_ALLOW_MULTI_ATK_PER_FRAME;

    StageTask__SetHitbox(&work->gameWork.objWork, -4, 7, 4, 13);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.position.z = FLOAT_TO_FX32(64.0);
    work->gameWork.objWork.scale.x    = FLOAT_TO_FX32(0.125);
    work->gameWork.objWork.scale.y    = FLOAT_TO_FX32(0.125);

    SetTaskState(&work->gameWork.objWork, PirateShipCannonBall_State_Active);

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, =StageTask_Main
	ldr r1, =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xa2
	orr r1, r1, #0x780
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	mov r1, #0
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, =aActAcGmkPirate_0
	bl ObjObjectAction2dBACLoad
	mov r0, #0xa3
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #8
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, #2
	mov r2, #0x53
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimation
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0x41
	bl ObjRect__SetDefenceStat
	ldr r0, =PirateShipCannonBall_OnHit
	mov r1, #0xd
	str r0, [r4, #0x278]
	ldr r2, [r4, #0x270]
	mov r0, r4
	orr r2, r2, #0x20
	str r2, [r4, #0x270]
	str r1, [sp]
	sub r1, r1, #0x11
	mov r2, #7
	mov r3, #4
	bl StageTask__SetHitbox
	ldr r1, [r4, #0x1c]
	mov r0, #0x40000
	orr r1, r1, #0x100
	str r1, [r4, #0x1c]
	str r0, [r4, #0x4c]
	mov r0, #0x200
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	ldr r1, =PirateShipCannonBall_State_Active
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void PirateShip_State_Appear(PirateShip *work)
{
    Player *player = (Player *)work->gameWork.parent;

    fx32 velocity = PirateShip_GetPlayerVelocity(player);
    if (velocity < FLOAT_TO_FX32(0.0))
        velocity = FLOAT_TO_FX32(0.0);

    if (player->objWork.position.x < work->startPos || player->objWork.position.x > work->endPos)
    {
        work->speed += velocity;
        SetTaskState(&work->gameWork.objWork, PirateShip_State_Disappear);
    }
    else
    {
        if (work->gameWork.objWork.position.x >= mapCamera.camera[player->cameraID].disp_pos.x + FLOAT_TO_FX32(127.9921875))
        {
            work->gameWork.objWork.velocity.x = work->speed + PirateShip_GetPlayerVelocity(player);
            work->gameWork.objWork.userTimer  = 0;
            work->gameWork.objWork.userWork   = playerGameStatus.stageTimer & 0xF;
            SetTaskState(&work->gameWork.objWork, PirateShip_State_Active);
        }
        else
        {
            work->speed = ObjSpdDownSet(work->speed, FLOAT_TO_FX32(0.0625));
            if (work->speed < FLOAT_TO_FX32(2.0))
                work->speed = FLOAT_TO_FX32(2.0);
            work->gameWork.objWork.velocity.x = velocity + work->speed;
        }
    }
}

void PirateShip_State_Active(PirateShip *work)
{
    Player *player = (Player *)work->gameWork.parent;

    fx32 velocity = PirateShip_GetPlayerVelocity(player);
    if (player->objWork.position.x < work->startPos || player->objWork.position.x > work->endPos)
    {
        work->speed += velocity;
        SetTaskState(&work->gameWork.objWork, PirateShip_State_Disappear);
        return;
    }

    fx32 targetPos = mapCamera.camera[player->cameraID].disp_pos.x + FLOAT_TO_FX32(HW_LCD_CENTER_X);
    fx32 shipPos   = work->gameWork.objWork.position.x;

    if (targetPos + FLOAT_TO_FX32(32.0) < shipPos)
    {
        work->speed = ObjSpdUpSet(work->speed, -FLOAT_TO_FX32(0.09375), FLOAT_TO_FX32(2.5));
        work->gameWork.flags |= PIRATESHIP_FLAG_MOVING_LEFT;
    }
    else
    {
        if (targetPos - FLOAT_TO_FX32(32.0) > shipPos)
        {
            work->speed = ObjSpdUpSet(work->speed, FLOAT_TO_FX32(0.09375), FLOAT_TO_FX32(2.5));
            work->gameWork.flags &= ~PIRATESHIP_FLAG_MOVING_LEFT;
        }
        else
        {
            if ((work->gameWork.flags & PIRATESHIP_FLAG_MOVING_LEFT) == 0 && targetPos < shipPos)
            {
                if (work->speed >= FLOAT_TO_FX32(0.0))
                {
                    work->speed = ObjSpdDownSet(work->speed, FLOAT_TO_FX32(0.09375));
                    if (work->speed < FLOAT_TO_FX32(1.5))
                        work->speed = FLOAT_TO_FX32(1.5);
                }
                else
                {
                    work->speed = ObjSpdUpSet(work->speed, FLOAT_TO_FX32(0.09375), FLOAT_TO_FX32(2.5));
                }
            }
            else
            {
                if ((work->gameWork.flags & PIRATESHIP_FLAG_MOVING_LEFT) != 0 && targetPos > shipPos)
                {
                    if (work->speed < FLOAT_TO_FX32(0.0))
                    {
                        work->speed = ObjSpdDownSet(work->speed, FLOAT_TO_FX32(0.09375));
                        if (work->speed > -FLOAT_TO_FX32(1.5))
                            work->speed = -FLOAT_TO_FX32(1.5);
                    }
                    else
                    {
                        work->speed = ObjSpdUpSet(work->speed, -FLOAT_TO_FX32(0.09375), FLOAT_TO_FX32(2.5));
                    }
                }
                else
                {
                    fx32 step = FLOAT_TO_FX32(0.09375);
                    if ((work->gameWork.flags & PIRATESHIP_FLAG_MOVING_LEFT) != 0)
                        step = -FLOAT_TO_FX32(0.09375);

                    work->speed = ObjSpdUpSet(work->speed, step, FLOAT_TO_FX32(2.5));
                }
            }
        }
    }

    work->gameWork.objWork.velocity.x = velocity + work->speed;

    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer <= 0)
    {
        PirateShipCannonBall *cannonBall;

        fx32 spawnOffsetX = FX32_FROM_WHOLE(cannonBallSpawnPosTable[((2 * work->gameWork.objWork.userWork) & 0xF) + 0]);
        fx32 spawnOffsetY = FX32_FROM_WHOLE(cannonBallSpawnPosTable[((2 * work->gameWork.objWork.userWork) & 0xF) + 1]);

        fx32 spawnX = work->gameWork.objWork.position.x + spawnOffsetX;
        fx32 spawnY = work->gameWork.objWork.position.y + spawnOffsetY;
        cannonBall  = SpawnStageObject(MAPOBJECT_327, spawnX, spawnY, PirateShipCannonBall);

        if (cannonBall != NULL)
        {
            cannonBall->gameWork.objWork.velocity.x = velocity;
            cannonBall->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(8.5);

            fx32 speed = player->objWork.position.x - (work->gameWork.objWork.position.x + spawnOffsetX);
            if (velocity != FLOAT_TO_FX32(0.0))
                speed += FX32_FROM_WHOLE(cannonBallVelocityXTable[work->gameWork.objWork.userWork & 0xF]);
            cannonBall->gameWork.objWork.velocity.x += FX_DivS32(speed, FLOAT_TO_FX32(0.026));
        }

        PirateShipCannonBlast__Create(&work->gameWork.objWork, spawnOffsetX, spawnOffsetY);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_PIRATE_FIRE);
        work->gameWork.objWork.userTimer = cannonBallShootIntervalTable[work->gameWork.objWork.userWork];
        work->gameWork.objWork.userWork  = (work->gameWork.objWork.userWork + 1) & 0xF;
    }
}

void PirateShip_State_Disappear(PirateShip *work)
{
    Player *player = (Player *)work->gameWork.parent;

    if (player->objWork.position.x >= work->startPos && player->objWork.position.x <= work->endPos)
    {
        SetTaskState(&work->gameWork.objWork, PirateShip_State_Appear);
        PirateShip_State_Appear(work);
    }
    else
    {
        work->speed                       = ObjSpdUpSet(work->speed, FLOAT_TO_FX32(0.125), FLOAT_TO_FX32(17.0));
        work->gameWork.objWork.velocity.x = work->speed;

        if (mapCamera.camera[player->cameraID].disp_pos.x + FLOAT_TO_FX32(HW_LCD_WIDTH + 96.0f) < work->gameWork.objWork.position.x)
        {
            work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

            work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
            work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);

            work->gameWork.objWork.prevPosition.x = work->originPos;
            work->gameWork.objWork.position.x     = work->gameWork.objWork.prevPosition.x;

            SetTaskState(&work->gameWork.objWork, NULL);
        }
    }
}

void PirateShip_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    PirateShip *pirateShip = (PirateShip *)rect2->parent;
    Player *player         = (Player *)rect1->parent;

    if (pirateShip == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    fx32 velocity = PirateShip_GetPlayerVelocity(player);
    if (velocity < 0)
    {
        ObjRect__FuncNoHit(rect1, rect2);
    }
    else
    {
        pirateShip->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
        pirateShip->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
        pirateShip->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
        pirateShip->gameWork.flags &= ~PIRATESHIP_FLAG_MOVING_LEFT;

        pirateShip->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = NULL;
        pirateShip->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

        pirateShip->gameWork.parent                 = &player->objWork;
        pirateShip->gameWork.objWork.velocity.x     = velocity + FLOAT_TO_FX32(6.0);
        pirateShip->speed                           = FLOAT_TO_FX32(6.0);
        pirateShip->originPos                       = pirateShip->gameWork.objWork.position.x;
        pirateShip->gameWork.objWork.position.x     = mapCamera.camera[player->cameraID].disp_pos.x - FLOAT_TO_FX32(96.0);
        pirateShip->gameWork.objWork.prevPosition.x = pirateShip->gameWork.objWork.position.x;

        SetTaskState(&pirateShip->gameWork.objWork, PirateShip_State_Appear);
    }
}

fx32 PirateShip_GetPlayerVelocity(Player *player)
{
    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES) != 0)
        return player->objWork.velocity.x;
    else
        return MultiplyFX(player->objWork.groundVel, CosFX(player->objWork.dir.z));
}

void PirateShipCannonBall_State_Active(PirateShipCannonBall *work)
{
    work->gameWork.objWork.position.z -= FLOAT_TO_FX32(0.875);
    if (work->gameWork.objWork.position.z < FLOAT_TO_FX32(0.0))
        work->gameWork.objWork.position.z = FLOAT_TO_FX32(0.0);

    fx32 zScale                    = MultiplyFX(work->gameWork.objWork.position.z, 56);
    work->gameWork.objWork.scale.x = FLOAT_TO_FX32(1.0) - zScale;
    work->gameWork.objWork.scale.y = FLOAT_TO_FX32(1.0) - zScale;

    if (work->gameWork.objWork.velocity.y > FLOAT_TO_FX32(0.0))
        work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
    {
        CreateEffectGroundExplosion(&work->gameWork.objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(14.0));
        DestroyStageTask(&work->gameWork.objWork);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SE_PIRATE_IMPACT);
    }
}

void PirateShipCannonBall_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    PirateShipCannonBall *cannonBall = (PirateShipCannonBall *)rect1->parent;
    Player *player                   = (Player *)rect2->parent;

    if (cannonBall == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    CreateEffectExplosion(&cannonBall->gameWork.objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), EXPLOSION_BIG);
    QueueDestroyStageTask(&cannonBall->gameWork.objWork);
}
