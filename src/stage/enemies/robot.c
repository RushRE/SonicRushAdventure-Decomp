#include <stage/enemies/robot.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/audio/spatialAudio.h>
#include <stage/core/bgmManager.h>
#include <stage/effects/explosion.h>
#include <stage/effects/found.h>
#include <stage/effects/steamBlasterSmoke.h>
#include <stage/effects/steamBlasterSteam.h>
#include <stage/effects/waterSplash.h>
#include <stage/objects/tutorial.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_xMin   mapObject->left
#define mapObjectParam_xRange mapObject->width

// --------------------
// ENUMS
// --------------------

// --------------------
// VARIABLES
// --------------------

static const u16 spritePaletteIDList[ROBOT_TYPE_COUNT] = {
    [ROBOT_TYPE_TRICERATOPS] = 20, [ROBOT_TYPE_FLYING_FISH] = 21, [ROBOT_TYPE_PTERODACTYL] = 20, [ROBOT_TYPE_SPANNER_BOT] = 37, [ROBOT_TYPE_STEAM_BLASTER] = 36
};

static const u32 dataWorkList[ROBOT_TYPE_COUNT] = { [ROBOT_TYPE_TRICERATOPS]   = OBJDATAWORK_3,
                                                    [ROBOT_TYPE_FLYING_FISH]   = OBJDATAWORK_4,
                                                    [ROBOT_TYPE_PTERODACTYL]   = OBJDATAWORK_5,
                                                    [ROBOT_TYPE_SPANNER_BOT]   = OBJDATAWORK_6,
                                                    [ROBOT_TYPE_STEAM_BLASTER] = OBJDATAWORK_7 };

static const HitboxRect detectRange[ROBOT_TYPE_COUNT] = {
    [ROBOT_TYPE_TRICERATOPS] = { -138, -40, -10, -8 }, [ROBOT_TYPE_FLYING_FISH] = { -190, -72, -10, -8 },   [ROBOT_TYPE_PTERODACTYL] = { -100, 30, -20, 128 },
    [ROBOT_TYPE_SPANNER_BOT] = { -110, -72, -10, -8 }, [ROBOT_TYPE_STEAM_BLASTER] = { -110, -72, -10, -8 },
};

static s16 colliderActivateDelay[ROBOT_TYPE_COUNT] = {
    [ROBOT_TYPE_TRICERATOPS] = 120, [ROBOT_TYPE_FLYING_FISH] = 30, [ROBOT_TYPE_PTERODACTYL] = 60, [ROBOT_TYPE_SPANNER_BOT] = 240, [ROBOT_TYPE_STEAM_BLASTER] = 120
};

static const char *spriteList[ROBOT_TYPE_COUNT] = { [ROBOT_TYPE_TRICERATOPS]   = "/act/ac_ene_tri.bac",
                                                    [ROBOT_TYPE_FLYING_FISH]   = "/act/ac_ene_fly_fish.bac",
                                                    [ROBOT_TYPE_PTERODACTYL]   = "/act/ac_ene_ptera.bac",
                                                    [ROBOT_TYPE_SPANNER_BOT]   = "/act/ac_ene_prot_span.bac",
                                                    [ROBOT_TYPE_STEAM_BLASTER] = "/act/ac_ene_prot_damp.bac" };

// --------------------
// FUNCTION DECLS
// --------------------

// Helpers
static void EnemyRobot_InitMoveRange(EnemyRobot *work);
static void EnemyRobot_HandleColliderActivateTimer(EnemyRobot *work);

// Triceratops & SpannerBot
static void EnemyRobot_OnInit_Triceratops(EnemyRobot *work);
static void EnemyRobot_State_TriceratopsMove(EnemyRobot *work);

// Pterodactyl
static void EnemyRobot_OnInit_Pterodactyl(EnemyRobot *work);
static void EnemyRobot_State_PterodactylMove(EnemyRobot *work);

// FlyingFish
static void EnemyRobot_OnInit_FlyingFish(EnemyRobot *work);
static void EnemyRobot_State_FlyingFishIdle(EnemyRobot *work);

// Triceratops & SpannerBot
static void EnemyRobot_OnDetect_Triceratops(EnemyRobot *work);
static void EnemyRobot_State_TriceratopsChargeDelay(EnemyRobot *work);
static void EnemyRobot_State_TriceratopsCharge(EnemyRobot *work);
static void EnemyRobot_State_AttackCooldown(EnemyRobot *work);

// Pterodactyl
static void EnemyRobot_OnDetect_Pterodactyl(EnemyRobot *work);
static void EnemyRobot_State_PterodactylPrepareAttack(EnemyRobot *work);
static void EnemyRobot_State_PterodactylAttack(EnemyRobot *work);

// FlyingFish
static void EnemyRobot_OnDetect_FlyingFish(EnemyRobot *work);
static void EnemyRobot_State_FlyingFishAttack(EnemyRobot *work);

// SteamBlaster
static void EnemyRobot_OnDetect_SteamBlaster(EnemyRobot *work);
static void EnemyRobot_State_SteamBlasterPrepareAttack(EnemyRobot *work);
static void EnemyRobot_State_SteamBlasterAttack(EnemyRobot *work);

// Common
static void EnemyRobot_OnDefend_Hurtbox(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemyRobot_OnDefend_Detector(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemyRobot_OnDefend_TutorialEnemy(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemyRobot_PlayAttackSfx(EnemyRobot *work);

// --------------------
// FUNCTIONS
// --------------------

EnemyRobot *CreateRobot(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (mapObject == NULL || (mapObject->x != MAPOBJECT_DESTROYED || mapObject->y != MAPOBJECT_DESTROYED))
    {
        if (gameState.difficulty == DIFFICULTY_EASY && (mapObject->flags & ENEMYCOMMON_OBJFLAG_DISABLED_ON_EASY) != 0)
            return NULL;
    }

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_SCOPE_2, EnemyRobot);
    if (task == HeapNull)
        return NULL;

    EnemyRobot *work = TaskGetWork(task, EnemyRobot);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    RobotType robotType;
    switch (mapObject->id)
    {
        case MAPOBJECT_0:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
            robotType = ROBOT_TYPE_TRICERATOPS;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
            EnemyRobot_InitMoveRange(work);

            work->onInit = EnemyRobot_OnInit_Triceratops;

            work->gfx.common.aniMove   = ROBOT_TYPE_TRICERATOPS;
            work->gfx.common.aniTurn   = 1;
            work->gfx.common.aniDetect = -1;
            work->gfx.common.moveSpeed = FLOAT_TO_FX32(0.75);

            work->onDetect = EnemyRobot_OnDetect_Triceratops;

            work->unknown.common.accel          = FLOAT_TO_FX32(0.125);
            work->unknown.common.targetSpeed    = FLOAT_TO_FX32(4.0);
            work->unknown.common.chargeDelay    = 10;
            work->unknown.common.chargeCooldown = 10;
            work->unknown.common.aniAttack      = 2;

            if ((mapObject->flags & 0x40) != 0)
            {
                work->gameWork.colliders[0].onDefend = EnemyRobot_OnDefend_TutorialEnemy;
                work->gameWork.objWork.moveFlag =
                    work->gameWork.objWork.moveFlag & (StageTaskMoveFlags)~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
            }
            break;

        case MAPOBJECT_1:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
            robotType = ROBOT_TYPE_FLYING_FISH;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

            if ((mapObject->flags & 1) != 0)
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

            work->onInit   = EnemyRobot_OnInit_FlyingFish;
            work->onDetect = EnemyRobot_OnDetect_FlyingFish;
            break;

        case MAPOBJECT_2:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
            robotType = ROBOT_TYPE_PTERODACTYL;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
            EnemyRobot_InitMoveRange(work);

            work->onInit                     = EnemyRobot_OnInit_Pterodactyl;
            work->gfx.pterodactyl.aniMove    = 0;
            work->gfx.pterodactyl.aniTurn    = 4;
            work->gfx.pterodactyl.moveSpeed  = FLOAT_TO_FX32(0.75);
            work->gfx.pterodactyl.jumpRadius = FLOAT_TO_FX32(1.5);
            work->gfx.pterodactyl.angleSpeed = FLOAT_DEG_TO_IDX(4.21875);

            work->onDetect = EnemyRobot_OnDetect_Pterodactyl;
            break;

        case MAPOBJECT_3:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
            robotType = ROBOT_TYPE_SPANNER_BOT;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
            EnemyRobot_InitMoveRange(work);

            work->onInit                    = EnemyRobot_OnInit_Triceratops;
            work->gfx.common.aniMove        = 0;
            work->gfx.common.aniTurn        = 1;
            work->gfx.common.aniDetect      = 2;
            work->gfx.common.detectDelay    = 120;
            work->gfx.common.detectDuration = 0;
            work->gfx.common.moveSpeed      = FLOAT_TO_FX32(0.75);

            work->onDetect = EnemyRobot_OnDetect_Triceratops;
            work->gameWork.flags |= 0x8000;
            work->unknown.common.aniAttack = robotType;
            break;

        case MAPOBJECT_4:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
            robotType = ROBOT_TYPE_STEAM_BLASTER;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
            EnemyRobot_InitMoveRange(work);

            work->onInit                    = EnemyRobot_OnInit_Triceratops;
            work->gfx.common.aniMove        = 0;
            work->gfx.common.aniTurn        = 5;
            work->gfx.common.aniDetect      = 1;
            work->gfx.common.detectDelay    = 240;
            work->gfx.common.detectDuration = 0;
            work->gfx.common.moveSpeed      = FLOAT_TO_FX32(0.75);

            work->onDetect = EnemyRobot_OnDetect_SteamBlaster;

            ObjRect__SetAttackStat(&work->gameWork.colliders[2], 0, 0);
            ObjRect__SetDefenceStat(&work->gameWork.colliders[2], ~1, 0);
            ObjRect__SetGroupFlags(&work->gameWork.colliders[2], 2, 1);
            work->gameWork.colliders[2].flag |= OBS_RECT_WORK_FLAG_400;
            ObjRect__SetOnDefend(&work->gameWork.colliders[2], EnemyRobot_OnDefend_Hurtbox);
            EffectSteamBlasterSmoke__Create(&work->gameWork.objWork);
            break;
    }

    work->type = robotType;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, spriteList[robotType], GetObjectDataWork(dataWorkList[robotType]), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, spritePaletteIDList[robotType]);

    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT) == 0)
        StageTask__SetHitbox(&work->gameWork.objWork, -8, -10, 8, -2);

    ObjRect__SetBox2D(&work->colliderDetect.rect, detectRange[robotType].left, detectRange[robotType].top, detectRange[robotType].right, detectRange[robotType].bottom);
    ObjRect__SetAttackStat(&work->colliderDetect, 0, 0);
    ObjRect__SetDefenceStat(&work->colliderDetect, ~1, 0);
    ObjRect__SetGroupFlags(&work->colliderDetect, 2, 1);
    work->colliderDetect.flag |= OBS_RECT_WORK_FLAG_400 | OBS_RECT_WORK_FLAG_80 | OBS_RECT_WORK_FLAG_40;
    ObjRect__SetOnDefend(&work->colliderDetect, EnemyRobot_OnDefend_Detector);
    work->colliderDetect.parent = &work->gameWork.objWork;

    work->onInit(work);
    StageTask__InitSeqPlayer(&work->gameWork.objWork);

    return work;
}

void EnemyRobot_InitMoveRange(EnemyRobot *work)
{
    work->xMin = work->gameWork.objWork.position.x + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_xMin);
    work->xMax = work->xMin + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_xRange);
}

void EnemyRobot_HandleColliderActivateTimer(EnemyRobot *work)
{
    if (work->colliderActivateTimer != 0)
    {
        work->colliderActivateTimer--;
        if (work->colliderActivateTimer == 0)
            work->colliderDetect.flag |= OBS_RECT_WORK_FLAG_IS_ACTIVE;
    }
}

void EnemyRobot_OnInit_Triceratops(EnemyRobot *work)
{
    GameObject__SetAnimation(&work->gameWork, work->gfx.common.aniMove);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyRobot_State_TriceratopsMove);
    work->gameWork.objWork.userTimer = 0;

    if (work->gameWork.mapObject->id == MAPOBJECT_0)
    {
        PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TANK_MOVE);
        ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
    }
}

NONMATCH_FUNC void EnemyRobot_State_TriceratopsMove(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r2, [r6, #0x354]
	add r4, r6, #0x3c8
	tst r2, #1
	mov r5, #0
	beq _021554A0
	ldr r1, [r6, #0x20]
	tst r1, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	bic r1, r2, #1
	str r1, [r6, #0x354]
	ldr r1, [r6, #0x20]
	eor r1, r1, #1
	str r1, [r6, #0x20]
	ldrh r1, [r4]
	bl GameObject__SetAnimation
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
_021554A0:
	mov r0, r6
	bl EnemyRobot_HandleColliderActivateTimer
	mov r0, r6
	add r1, r6, #0x364
	bl StageTask__HandleCollider
	ldrh r1, [r4, #4]
	ldr r0, =0x0000FFFF
	cmp r1, r0
	beq _02155590
	ldr r0, [r6, #0x128]
	ldrh r0, [r0, #0xc]
	cmp r0, r1
	beq _02155524
	ldr r0, [r6, #0x2c]
	add r1, r0, #1
	str r1, [r6, #0x2c]
	ldrsh r0, [r4, #6]
	cmp r1, r0
	blt _02155590
	mov r0, #0
	str r0, [r6, #0xc8]
	ldrh r1, [r4, #4]
	mov r0, r6
	bl GameObject__SetAnimation
	ldrsh r0, [r4, #8]
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
	ldrsh r0, [r4, #8]
	str r0, [r6, #0x2c]
	ldmia sp!, {r4, r5, r6, pc}
_02155524:
	ldr r0, [r6, #0x20]
	tst r0, #4
	beq _02155568
	ldr r0, [r6, #0x2c]
	sub r0, r0, #1
	str r0, [r6, #0x2c]
	cmp r0, #0
	ldmgtia sp!, {r4, r5, r6, pc}
	mov r0, #0
	str r0, [r6, #0x2c]
	ldrh r1, [r4]
	mov r0, r6
	bl GameObject__SetAnimation
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
	b _02155590
_02155568:
	tst r0, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, #0
	str r0, [r6, #0x2c]
	ldrh r1, [r4]
	mov r0, r6
	bl GameObject__SetAnimation
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
_02155590:
	ldr r0, [r6, #0x20]
	tst r0, #1
	ldr r0, [r4, #0xc]
	rsbeq r0, r0, #0
	str r0, [r6, #0xc8]
	ldr r0, [r6, #0x1c]
	ldr r1, [r6, #0x44]
	tst r0, #4
	ldr r0, [r6, #0x3b4]
	movne r5, #1
	cmp r1, r0
	strlt r0, [r6, #0x44]
	movlt r5, #1
	blt _021555D8
	ldr r0, [r6, #0x3bc]
	cmp r1, r0
	strgt r0, [r6, #0x44]
	movgt r5, #1
_021555D8:
	cmp r5, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrh r1, [r4, #2]
	ldr r0, =0x0000FFFF
	cmp r1, r0
	ldreq r0, [r6, #0x20]
	eoreq r0, r0, #1
	streq r0, [r6, #0x20]
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, r6
	bl GameObject__SetAnimation
	mov r0, #0
	str r0, [r6, #0xc8]
	ldr r0, [r6, #0x354]
	orr r0, r0, #1
	str r0, [r6, #0x354]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

void EnemyRobot_OnInit_Pterodactyl(EnemyRobot *work)
{
    GameObject__SetAnimation(&work->gameWork, work->gfx.common.aniMove);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyRobot_State_PterodactylMove);
}

NONMATCH_FUNC void EnemyRobot_State_PterodactylMove(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r2, [r6, #0x354]
	add r4, r6, #0x3c8
	tst r2, #1
	mov r5, #0
	beq _021556A8
	ldr r1, [r6, #0x20]
	tst r1, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	bic r1, r2, #1
	str r1, [r6, #0x354]
	ldr r1, [r6, #0x20]
	eor r1, r1, #1
	str r1, [r6, #0x20]
	ldrh r1, [r4]
	bl GameObject__SetAnimation
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
_021556A8:
	ldr r0, [r6, #0x20]
	ldr r1, =FX_SinCosTable_
	tst r0, #1
	ldr r0, [r4, #4]
	rsbeq r0, r0, #0
	str r0, [r6, #0xc8]
	ldrh r2, [r4, #0xe]
	ldrh r0, [r4, #0xc]
	add r0, r2, r0
	strh r0, [r4, #0xe]
	ldrh r2, [r4, #0xe]
	ldr r0, [r4, #8]
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r1, [r1, r2]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r6, #0x9c]
	ldr r0, [r6, #0x1c]
	ldr r1, [r6, #0x44]
	tst r0, #4
	ldr r0, [r6, #0x3b4]
	movne r5, #1
	cmp r1, r0
	strlt r0, [r6, #0x44]
	movlt r5, #1
	blt _02155730
	ldr r0, [r6, #0x3bc]
	cmp r1, r0
	strgt r0, [r6, #0x44]
	movgt r5, #1
_02155730:
	cmp r5, #0
	beq _02155774
	ldrh r1, [r4, #2]
	ldr r0, =0x0000FFFF
	cmp r1, r0
	ldreq r0, [r6, #0x20]
	eoreq r0, r0, #1
	streq r0, [r6, #0x20]
	beq _02155774
	mov r0, r6
	bl GameObject__SetAnimation
	mov r0, #0
	str r0, [r6, #0xc8]
	str r0, [r6, #0x9c]
	ldr r0, [r6, #0x354]
	orr r0, r0, #1
	str r0, [r6, #0x354]
_02155774:
	mov r0, r6
	bl EnemyRobot_HandleColliderActivateTimer
	mov r0, r6
	add r1, r6, #0x364
	bl StageTask__HandleCollider
	ldr r0, [r6, #0x20]
	tst r0, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r1, #0
	mov r0, #0x75
	str r1, [sp]
	sub r1, r0, #0x76
	str r0, [sp, #4]
	ldr r0, [r6, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r6, #0x138]
	add r1, r6, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

void EnemyRobot_OnInit_FlyingFish(EnemyRobot *work)
{
    GameObject__SetAnimation(&work->gameWork, 0);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyRobot_State_FlyingFishIdle);
}

void EnemyRobot_State_FlyingFishIdle(EnemyRobot *work)
{
    EnemyRobot_HandleColliderActivateTimer(work);
    StageTask__HandleCollider(&work->gameWork.objWork, &work->colliderDetect);
}

void EnemyRobot_OnDetect_Triceratops(EnemyRobot *work)
{
    work->gameWork.objWork.groundVel = FLOAT_TO_FX32(0.0);

    struct EnemyRobotTriceratopsUnknown *config = &work->unknown.common;

    if (config->chargeDelay != 0)
    {
        work->gameWork.objWork.userTimer = config->chargeDelay;
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
        SetTaskState(&work->gameWork.objWork, EnemyRobot_State_TriceratopsChargeDelay);
    }
    else
    {
        GameObject__SetAnimation(&work->gameWork, config->aniAttack);

        if ((work->gameWork.flags & 0x8000) == 0)
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

        SetTaskState(&work->gameWork.objWork, EnemyRobot_State_TriceratopsCharge);

        EnemyRobot_PlayAttackSfx(work);
    }
}

void EnemyRobot_State_TriceratopsChargeDelay(EnemyRobot *work)
{
    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer == 0)
    {
        work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_PAUSED;
        GameObject__SetAnimation(&work->gameWork, work->unknown.common.aniAttack);

        if ((work->gameWork.flags & 0x8000) == 0)
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

        SetTaskState(&work->gameWork.objWork, EnemyRobot_State_TriceratopsCharge);

        EnemyRobot_PlayAttackSfx(work);
    }
}

NONMATCH_FUNC void EnemyRobot_State_TriceratopsCharge(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #0x354]
	add r4, r6, #0x3d8
	tst r0, #0x8000
	mov r5, #0
	ldr r0, [r6, #0x20]
	bne _02155960
	tst r0, #1
	ldr r0, [r6, #0xc8]
	ldmib r4, {r1, r2}
	beq _02155928
	bl ObjSpdUpSet
	b _02155930
_02155928:
	rsb r1, r1, #0
	bl ObjSpdUpSet
_02155930:
	str r0, [r6, #0xc8]
	ldr r0, [r6, #0x3b4]
	ldr r1, [r6, #0x44]
	cmp r1, r0
	strlt r0, [r6, #0x44]
	movlt r5, #1
	blt _02155968
	ldr r0, [r6, #0x3bc]
	cmp r1, r0
	strgt r0, [r6, #0x44]
	movgt r5, #1
	b _02155968
_02155960:
	tst r0, #8
	movne r5, #1
_02155968:
	cmp r5, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrsh r0, [r4, #0xe]
	cmp r0, #0
	beq _02155998
	mov r0, #0
	str r0, [r6, #0xc8]
	ldrsh r1, [r4, #0xe]
	ldr r0, =EnemyRobot_State_AttackCooldown
	str r1, [r6, #0x2c]
	str r0, [r6, #0xf4]
	ldmia sp!, {r4, r5, r6, pc}
_02155998:
	ldr r1, [r6, #0x3ac]
	mov r0, r6
	blx r1
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

void EnemyRobot_State_AttackCooldown(EnemyRobot *work)
{
    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer == 0)
    {
        work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_PAUSED;
        work->onInit(work);
    }
}

void EnemyRobot_OnDetect_Pterodactyl(EnemyRobot *work)
{
    work->gameWork.objWork.velocity.x = work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.groundVel                                      = FLOAT_TO_FX32(0.0);

    work->gameWork.objWork.dir.z = FX_Atan2Idx(work->detectPlayerPos.y - work->gameWork.objWork.position.y, work->detectPlayerPos.x - work->gameWork.objWork.position.x);

    work->unknown.pterodactyl.startPos.x = work->gameWork.objWork.position.x;
    work->unknown.pterodactyl.startPos.y = work->gameWork.objWork.position.y;

    work->gameWork.flags &= ~0x8000;
    work->gameWork.objWork.groundVel = -FLOAT_TO_FX32(3.0);

    GameObject__SetAnimation(&work->gameWork, 1);

    SetTaskState(&work->gameWork.objWork, EnemyRobot_State_PterodactylPrepareAttack);
}

void EnemyRobot_State_PterodactylPrepareAttack(EnemyRobot *work)
{
    work->gameWork.objWork.groundVel = ObjSpdDownSet(work->gameWork.objWork.groundVel, FLOAT_TO_FX32(0.125));

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        GameObject__SetAnimation(&work->gameWork, 2);
        SetTaskState(&work->gameWork.objWork, EnemyRobot_State_PterodactylAttack);
        PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BUTERA_PECK);
    }
}

NONMATCH_FUNC void EnemyRobot_State_PterodactylAttack(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x354]
	mov r4, #0
	tst r0, #0x8000
	ldr r1, [r5, #0x48]
	beq _02155B60
	ldr r0, [r5, #0x3dc]
	cmp r1, r0
	bgt _02155B38
	ldr r0, [r5, #0x20]
	ands r2, r0, #1
	beq _02155B08
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x3d8]
	cmp r1, r0
	ble _02155B20
_02155B08:
	cmp r2, #0
	bne _02155B38
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x3d8]
	cmp r1, r0
	blt _02155B38
_02155B20:
	mov r0, #0
	str r0, [r5, #0xc8]
	ldr r0, [r5, #0x20]
	tst r0, #8
	movne r4, #1
	b _02155BB8
_02155B38:
	ldr r0, [r5, #0x20]
	tst r0, #8
	movne r0, #0x3000
	strne r0, [r5, #0xc8]
	bne _02155BB8
	ldr r0, [r5, #0xc8]
	ldr r1, =0x00000199
	bl ObjSpdDownSet
	str r0, [r5, #0xc8]
	b _02155BB8
_02155B60:
	ldr r0, [r5, #0x3a8]
	cmp r1, r0
	blt _02155BA4
	ldr r0, [r5, #0x20]
	ands r2, r0, #1
	beq _02155B88
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x3a4]
	cmp r1, r0
	bge _02155BA0
_02155B88:
	cmp r2, #0
	bne _02155BA4
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x3a4]
	cmp r1, r0
	bgt _02155BA4
_02155BA0:
	mov r4, #1
_02155BA4:
	ldr r0, [r5, #0xc8]
	mov r1, #0x400
	mov r2, #0x6000
	bl ObjSpdUpSet
	str r0, [r5, #0xc8]
_02155BB8:
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x354]
	tst r0, #0x8000
	beq _02155C10
	ldr r0, [r5, #0x3d8]
	mov r1, #0
	str r0, [r5, #0x44]
	ldr r0, [r5, #0x3dc]
	mov r2, #0xa
	str r0, [r5, #0x48]
	str r1, [r5, #0xc8]
	strh r1, [r5, #0x34]
	mov r0, r5
	str r2, [r5, #0x2c]
	bl GameObject__SetAnimation
	ldr r1, [r5, #0x20]
	ldr r0, =EnemyRobot_State_AttackCooldown
	orr r1, r1, #0x10
	str r1, [r5, #0x20]
	str r0, [r5, #0xf4]
	ldmia sp!, {r3, r4, r5, pc}
_02155C10:
	mov r0, #0x3000
	str r0, [r5, #0xc8]
	ldrh r2, [r5, #0x34]
	mov r1, #0x8000
	mov r0, r5
	add r2, r2, #0x8000
	strh r2, [r5, #0x34]
	str r1, [r5, #8]
	ldr r2, [r5, #0x354]
	mov r1, #3
	orr r2, r2, #0x8000
	str r2, [r5, #0x354]
	bl GameObject__SetAnimation
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void EnemyRobot_OnDetect_FlyingFish(EnemyRobot *work)
{
    work->gameWork.objWork.groundVel = FLOAT_TO_FX32(0.0);

    work->gameWork.objWork.userWork  = 0;
    work->gameWork.objWork.userTimer = 3;

    SetTaskState(&work->gameWork.objWork, EnemyRobot_State_FlyingFishAttack);
}

NONMATCH_FUNC void EnemyRobot_State_FlyingFishAttack(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0x28]
	cmp r2, #0
	beq _02155CA8
	cmp r2, #1
	beq _02155D18
	cmp r2, #2
	beq _02155DD0
	ldmia sp!, {r4, pc}
_02155CA8:
	mov r1, #0x3000
	str r1, [r4, #0x9c]
	ldr r1, [r4, #0x2c]
	subs r1, r1, #1
	str r1, [r4, #0x2c]
	ldmneia sp!, {r4, pc}
	ldr r2, [r4, #0x28]
	mov r1, #0
	add r2, r2, #1
	str r2, [r4, #0x28]
	str r1, [r4, #0x98]
	sub r1, r1, #0x6000
	str r1, [r4, #0x9c]
	ldr r2, [r4, #0x1c]
	mov r1, #1
	orr r2, r2, #0x80
	str r2, [r4, #0x1c]
	bl GameObject__SetAnimation
	ldr r0, =mapCamera
	mov r1, #0
	ldrh r3, [r0, #0x6e]
	mov r0, r4
	mov r2, r1
	bl CreateEffectWaterSplash
	ldr r0, [r4, #0x354]
	orr r0, r0, #0x8000
	str r0, [r4, #0x354]
	ldmia sp!, {r4, pc}
_02155D18:
	ldr r0, [r4, #0x9c]
	cmp r0, #0
	ldmleia sp!, {r4, pc}
	ldr r0, [r4, #0x34c]
	ldr r1, [r4, #0x48]
	add r0, r0, #0x10000
	cmp r1, r0
	blt _02155D90
	add r0, r2, #1
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x20]
	mov r1, #0x2800
	eor r0, r0, #1
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x1c]
	rsb r1, r1, #0
	bic r0, r0, #0x80
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x20]
	tst r0, #1
	mov r0, #0x800
	rsbeq r0, r0, #0
	str r0, [r4, #0x98]
	str r1, [r4, #0x9c]
	mov r0, r4
	mov r1, #0
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
_02155D90:
	ldr r0, [r4, #0x354]
	tst r0, #0x8000
	ldmeqia sp!, {r4, pc}
	ldr r0, =mapCamera
	ldr r1, [r4, #0x48]
	ldrh r3, [r0, #0x6e]
	cmp r1, r3, lsl #12
	ldmltia sp!, {r4, pc}
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl CreateEffectWaterSplash
	ldr r0, [r4, #0x354]
	bic r0, r0, #0x8000
	str r0, [r4, #0x354]
	ldmia sp!, {r4, pc}
_02155DD0:
	ldr r2, [r4, #0x34c]
	ldr r1, [r4, #0x48]
	cmp r1, r2
	ldmgtia sp!, {r4, pc}
	mov r1, #0
	str r2, [r4, #0x48]
	str r1, [r4, #0x9c]
	str r1, [r4, #0x98]
	ldr r1, [r4, #0x3ac]
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void EnemyRobot_OnDetect_SteamBlaster(EnemyRobot *work)
{
    work->gameWork.objWork.velocity.x = work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.groundVel                                      = FLOAT_TO_FX32(0.0);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
    CreateEffectFound(&work->gameWork.objWork, FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(64.0));
    work->gameWork.objWork.userTimer = 12;

    SetTaskState(&work->gameWork.objWork, EnemyRobot_State_SteamBlasterPrepareAttack);
}

void EnemyRobot_State_SteamBlasterPrepareAttack(EnemyRobot *work)
{
    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer == 0)
    {
        work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_PAUSED;
        GameObject__SetAnimation(&work->gameWork, 2);

        SetTaskState(&work->gameWork.objWork, EnemyRobot_State_SteamBlasterAttack);
    }
}

NONMATCH_FUNC void EnemyRobot_State_SteamBlasterAttack(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x128]
	ldrh r1, [r1, #0xc]
	cmp r1, #2
	beq _02155EA8
	cmp r1, #3
	beq _02155F4C
	b _02155FD0
_02155EA8:
	ldr r1, [r4, #0x20]
	tst r1, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #3
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, #0x78
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0x2c]
	mov r1, #0
	str r4, [r4, #0x2b4]
	ldr r0, [r4, #0x2b0]
	mov r2, r1
	orr r0, r0, #4
	str r0, [r4, #0x2b0]
	mov r3, r1
	add r0, r4, #0x298
	str r1, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0x21000
	rsb r1, r1, #0
	mov r0, r4
	add r2, r1, #0x2000
	mov r3, #0x78
	bl EffectSteamBlasterSteam__Create
	mov r0, #0
	str r0, [sp]
	mov r0, #0x83
	sub r1, r0, #0x84
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02155F4C:
	ldr r1, [r4, #0x2c]
	subs r1, r1, #1
	str r1, [r4, #0x2c]
	beq _02155FAC
	rsb r1, r1, #0x78
	mov r0, #0xc
	mul r2, r1, r0
	mvn r3, #0xf
	cmp r2, #0x48
	movgt r2, #0x48
	sub r0, r3, #0x11
	sub r0, r0, r2
	mov r1, r0, lsl #0x10
	str r3, [sp]
	sub r2, r3, #0x18
	add r0, r4, #0x298
	mov r1, r1, asr #0x10
	sub r3, r3, #0x11
	bl ObjRect__SetBox2D
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02155FAC:
	mov r1, #4
	bl GameObject__SetAnimation
	mov r0, #0
	str r0, [r4, #0x2b4]
	ldr r0, [r4, #0x138]
	mov r1, #0x20
	bl NNS_SndPlayerStopSeq
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02155FD0:
	ldr r1, [r4, #0x20]
	tst r1, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x3ac]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void EnemyRobot_OnDefend_Hurtbox(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    EnemyRobot *robot = (EnemyRobot *)rect2->parent;
    Player *player    = (Player *)rect1->parent;

    if (robot == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
    {
        ObjRect__FuncNoHit(rect1, rect2);
    }
    else
    {
        fx32 y                             = robot->gameWork.objWork.position.y;
        robot->gameWork.objWork.position.y = player->objWork.position.y;

        fx32 velX;
        if ((robot->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
            velX = -FLOAT_TO_FX32(5.0);
        else
            velX = FLOAT_TO_FX32(5.0);

        Player__Action_PopSteam(player, &robot->gameWork, velX, -FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(96.0), 0);

        robot->gameWork.objWork.position.y = y;
    }
}

void EnemyRobot_OnDefend_Detector(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    EnemyRobot *robot = (EnemyRobot *)rect2->parent;
    Player *player    = (Player *)rect1->parent;

    if ((robot->gameWork.objWork.flag & STAGE_TASK_FLAG_2) == 0)
    {
        robot->detectPlayerPos.x = player->objWork.position.x;
        robot->detectPlayerPos.y = player->objWork.position.y;
        robot->colliderDetect.flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;
        robot->colliderActivateTimer = colliderActivateDelay[robot->type];
        robot->onDetect(robot);
    }
}

void EnemyRobot_OnDefend_TutorialEnemy(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SetTutorialEnemyDestroy();
    GameObject__OnDefend_Enemy(rect1, rect2);
}

void EnemyRobot_PlayAttackSfx(EnemyRobot *work)
{
    switch (work->gameWork.mapObject->id)
    {
        case MAPOBJECT_0:
            PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TANK_ACCEL);
            ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
            break;

        case MAPOBJECT_3:
            CreateManagedSfx(SND_ZONE_SEQARC_GAME_SE, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SPANNER,
                             MANAGEDSFX_FLAG_DESTROY_WITH_PARENT | MANAGEDSFX_FLAG_HAS_PARENT | MANAGEDSFX_FLAG_HAS_DELAY | MANAGEDSFX_FLAG_HAS_DURATION, &work->gameWork.objWork,
                             240, 48);
            break;
    }
}