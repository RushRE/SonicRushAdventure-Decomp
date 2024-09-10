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
// CONSTANTS
// --------------------

#define ROBOT_ANI_NONE 0xFFFF

// --------------------
// ENUMS
// --------------------

enum RobotObjectFlags
{
    ROBOT_OBJFLAG_NONE,

    ROBOT_OBJFLAG_FLIPPED  = (1 << 0), // used for FlyingFish
    ROBOT_OBJFLAG_TUTORIAL = (1 << 6), // used for Triceratops
};

enum RobotFlags
{
    ROBOT_FLAG_NONE,

    ROBOT_FLAG_TURNING      = (1 << 0),
    ROBOT_FLAG_HAS_ATTACKED = (1 << 15),
};

enum TriceratopsAnimID
{
    TRICERATOPS_ANI_MOVE,
    TRICERATOPS_ANI_TURN,
    TRICERATOPS_ANI_ATTACK,
};

enum PterodactylAnimID
{
    PTERODACTYL_ANI_MOVE,
    PTERODACTYL_ANI_PREPARE_ATTACK,
    PTERODACTYL_ANI_ATTACKING,
    PTERODACTYL_ANI_FINISH_ATTACK,
    PTERODACTYL_ANI_TURN,
};

enum FlyingFishAnimID
{
    FLYINGFISH_ANI_RISE,
    FLYINGFISH_ANI_FALL,
};

enum SpannerBotAnimID
{
    SPANNERBOT_ANI_MOVE,
    SPANNERBOT_ANI_TURN,
    SPANNERBOT_ANI_DETECT,
    SPANNERBOT_ANI_ATTACK,
};

enum FlyingFishAttackState
{
    FLYINGFISH_ATTACK_RISE,
    FLYINGFISH_ATTACK_FALL,
    FLYINGFISH_ATTACK_RESET,
};

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
static void EnemyRobot_OnInit_Common(EnemyRobot *work);
static void EnemyRobot_State_TriceratopsMove(EnemyRobot *work);

// Pterodactyl
static void EnemyRobot_OnInit_Pterodactyl(EnemyRobot *work);
static void EnemyRobot_State_PterodactylMove(EnemyRobot *work);

// FlyingFish
static void EnemyRobot_OnInit_FlyingFish(EnemyRobot *work);
static void EnemyRobot_State_FlyingFishIdle(EnemyRobot *work);

// Triceratops & SpannerBot
static void EnemyRobot_OnDetect_Common(EnemyRobot *work);
static void EnemyRobot_State_CommonAttackDelay(EnemyRobot *work);
static void EnemyRobot_State_CommonAttack(EnemyRobot *work);
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
static void EnemyRobot_OnDefend_Steam(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemyRobot_OnDefend_Detector(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemyRobot_OnDefend_TutorialEnemy(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemyRobot_PlayAttackSfx(EnemyRobot *work);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE BOOL CheckPterodactylOutOfBounds(EnemyRobot *work, struct EnemyRobotPterodactylAttackConfig *attack)
{
    u32 flipX = (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X);

    return (flipX != 0 && work->gameWork.objWork.position.x <= attack->startPos.x) || (flipX == 0 && work->gameWork.objWork.position.x >= attack->startPos.x);
}

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

            work->onInit = EnemyRobot_OnInit_Common;

            work->move.common.aniMove   = TRICERATOPS_ANI_MOVE;
            work->move.common.aniTurn   = TRICERATOPS_ANI_TURN;
            work->move.common.aniDetect = ROBOT_ANI_NONE;
            work->move.common.moveSpeed = FLOAT_TO_FX32(0.75);

            work->onDetect = EnemyRobot_OnDetect_Common;

            work->attack.common.accel          = FLOAT_TO_FX32(0.125);
            work->attack.common.targetSpeed    = FLOAT_TO_FX32(4.0);
            work->attack.common.chargeDelay    = 10;
            work->attack.common.chargeCooldown = 10;
            work->attack.common.aniAttack      = TRICERATOPS_ANI_ATTACK;

            if ((mapObject->flags & ROBOT_OBJFLAG_TUTORIAL) != 0)
            {
                work->gameWork.colliders[0].onDefend = EnemyRobot_OnDefend_TutorialEnemy;
                work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
                work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
            }
            break;

        case MAPOBJECT_1:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
            robotType = ROBOT_TYPE_FLYING_FISH;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

            if ((mapObject->flags & ROBOT_OBJFLAG_FLIPPED) != 0)
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

            work->onInit   = EnemyRobot_OnInit_FlyingFish;
            work->onDetect = EnemyRobot_OnDetect_FlyingFish;
            break;

        case MAPOBJECT_2:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
            robotType = ROBOT_TYPE_PTERODACTYL;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
            EnemyRobot_InitMoveRange(work);

            work->onInit                      = EnemyRobot_OnInit_Pterodactyl;
            work->move.pterodactyl.aniMove    = PTERODACTYL_ANI_MOVE;
            work->move.pterodactyl.aniTurn    = PTERODACTYL_ANI_TURN;
            work->move.pterodactyl.moveSpeed  = FLOAT_TO_FX32(0.75);
            work->move.pterodactyl.jumpRadius = FLOAT_TO_FX32(1.5);
            work->move.pterodactyl.angleSpeed = FLOAT_DEG_TO_IDX(4.21875);

            work->onDetect = EnemyRobot_OnDetect_Pterodactyl;
            break;

        case MAPOBJECT_3:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
            robotType = ROBOT_TYPE_SPANNER_BOT;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
            EnemyRobot_InitMoveRange(work);

            work->onInit                     = EnemyRobot_OnInit_Common;
            work->move.common.aniMove        = SPANNERBOT_ANI_MOVE;
            work->move.common.aniTurn        = SPANNERBOT_ANI_TURN;
            work->move.common.aniDetect      = SPANNERBOT_ANI_DETECT;
            work->move.common.detectDelay    = 120;
            work->move.common.detectDuration = 0;
            work->move.common.moveSpeed      = FLOAT_TO_FX32(0.75);

            work->onDetect = EnemyRobot_OnDetect_Common;
            work->gameWork.flags |= ROBOT_FLAG_HAS_ATTACKED;
            work->attack.common.aniAttack = SPANNERBOT_ANI_ATTACK;
            break;

        case MAPOBJECT_4:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
            robotType = ROBOT_TYPE_STEAM_BLASTER;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
            EnemyRobot_InitMoveRange(work);

            work->onInit                     = EnemyRobot_OnInit_Common;
            work->move.common.aniMove        = STEAMBLASTER_ANI_MOVE;
            work->move.common.aniTurn        = STEAMBLASTER_ANI_TURN;
            work->move.common.aniDetect      = STEAMBLASTER_ANI_DETECT;
            work->move.common.detectDelay    = 240;
            work->move.common.detectDuration = 0;
            work->move.common.moveSpeed      = FLOAT_TO_FX32(0.75);

            work->onDetect = EnemyRobot_OnDetect_SteamBlaster;

            ObjRect__SetAttackStat(&work->gameWork.colliders[2], 0, 0);
            ObjRect__SetDefenceStat(&work->gameWork.colliders[2], ~1, 0);
            ObjRect__SetGroupFlags(&work->gameWork.colliders[2], 2, 1);
            work->gameWork.colliders[2].flag |= OBS_RECT_WORK_FLAG_400;
            ObjRect__SetOnDefend(&work->gameWork.colliders[2], EnemyRobot_OnDefend_Steam);
            CreateEffectSteamBlasterSmoke(&work->gameWork.objWork);
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

void EnemyRobot_OnInit_Common(EnemyRobot *work)
{
    GameObject__SetAnimation(&work->gameWork, work->move.common.aniMove);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyRobot_State_TriceratopsMove);
    work->gameWork.objWork.userTimer = 0;

    if (work->gameWork.mapObject->id == MAPOBJECT_0)
    {
        PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TANK_MOVE);
        ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
    }
}

void EnemyRobot_State_TriceratopsMove(EnemyRobot *work)
{
    struct EnemyRobotCommonMoveConfig *move = &work->move.common;

    BOOL shouldTurn = FALSE;

    if ((work->gameWork.flags & ROBOT_FLAG_TURNING) != 0)
    {
        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) == 0)
            return;

        work->gameWork.flags &= ~ROBOT_FLAG_TURNING;
        work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
        GameObject__SetAnimation(&work->gameWork, move->aniMove);
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    }

    EnemyRobot_HandleColliderActivateTimer(work);
    StageTask__HandleCollider(&work->gameWork.objWork, &work->colliderDetect);

    if (move->aniDetect != ROBOT_ANI_NONE)
    {
        if (work->gameWork.objWork.obj_2d->ani.work.animID != move->aniDetect)
        {
            work->gameWork.objWork.userTimer++;
            if (work->gameWork.objWork.userTimer >= move->detectDelay)
            {
                work->gameWork.objWork.groundVel = FLOAT_TO_FX32(0.0);
                GameObject__SetAnimation(&work->gameWork, move->aniDetect);
                if (move->detectDuration)
                {
                    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                    work->gameWork.objWork.userTimer = move->detectDuration;
                }
                return;
            }
        }
        else
        {
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_LOOPING) != 0)
            {
                work->gameWork.objWork.userTimer--;
                if (work->gameWork.objWork.userTimer > 0)
                    return;

                work->gameWork.objWork.userTimer = 0;
                GameObject__SetAnimation(&work->gameWork, move->aniMove);
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            }
            else
            {
                if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) == 0)
                    return;

                work->gameWork.objWork.userTimer = 0;
                GameObject__SetAnimation(&work->gameWork, move->aniMove);
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            }
        }
    }

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        work->gameWork.objWork.groundVel = -move->moveSpeed;
    else
        work->gameWork.objWork.groundVel = move->moveSpeed;

    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) != 0)
        shouldTurn = TRUE;

    if (work->gameWork.objWork.position.x < work->xMin)
    {
        work->gameWork.objWork.position.x = work->xMin;
        shouldTurn                        = TRUE;
    }
    else if (work->gameWork.objWork.position.x > work->xMax)
    {
        work->gameWork.objWork.position.x = work->xMax;
        shouldTurn                        = TRUE;
    }

    if (shouldTurn)
    {
        if (move->aniTurn != ROBOT_ANI_NONE)
        {
            GameObject__SetAnimation(&work->gameWork, move->aniTurn);
            work->gameWork.objWork.groundVel = FLOAT_TO_FX32(0.0);
            work->gameWork.flags |= ROBOT_FLAG_TURNING;
        }
        else
        {
            work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
        }
    }
}

void EnemyRobot_OnInit_Pterodactyl(EnemyRobot *work)
{
    GameObject__SetAnimation(&work->gameWork, work->move.pterodactyl.aniMove);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyRobot_State_PterodactylMove);
}

void EnemyRobot_State_PterodactylMove(EnemyRobot *work)
{
    struct EnemyRobotPterodactylMoveConfig *move = &work->move.pterodactyl;

    BOOL shouldTurn = FALSE;

    if ((work->gameWork.flags & ROBOT_FLAG_TURNING) != 0)
    {
        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) == 0)
            return;

        work->gameWork.flags &= ~ROBOT_FLAG_TURNING;
        work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
        GameObject__SetAnimation(&work->gameWork, move->aniMove);
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    }

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        work->gameWork.objWork.groundVel = -move->moveSpeed;
    else
        work->gameWork.objWork.groundVel = move->moveSpeed;

    move->angle += move->angleSpeed;
    work->gameWork.objWork.velocity.y = MultiplyFX(SinFX(move->angle), move->jumpRadius);

    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) != 0)
        shouldTurn = TRUE;

    if (work->gameWork.objWork.position.x < work->xMin)
    {
        work->gameWork.objWork.position.x = work->xMin;
        shouldTurn                        = TRUE;
    }
    else if (work->gameWork.objWork.position.x > work->xMax)
    {
        work->gameWork.objWork.position.x = work->xMax;
        shouldTurn                        = TRUE;
    }

    if (shouldTurn)
    {
        if (move->aniTurn != ROBOT_ANI_NONE)
        {
            GameObject__SetAnimation(&work->gameWork, move->aniTurn);
            work->gameWork.objWork.groundVel  = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
            work->gameWork.flags |= ROBOT_FLAG_TURNING;
        }
        else
        {
            work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
        }
    }

    EnemyRobot_HandleColliderActivateTimer(work);
    StageTask__HandleCollider(&work->gameWork.objWork, &work->colliderDetect);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BUTERA_FLUTTER);
        ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
    }
}

void EnemyRobot_OnInit_FlyingFish(EnemyRobot *work)
{
    GameObject__SetAnimation(&work->gameWork, FLYINGFISH_ANI_RISE);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyRobot_State_FlyingFishIdle);
}

void EnemyRobot_State_FlyingFishIdle(EnemyRobot *work)
{
    EnemyRobot_HandleColliderActivateTimer(work);
    StageTask__HandleCollider(&work->gameWork.objWork, &work->colliderDetect);
}

void EnemyRobot_OnDetect_Common(EnemyRobot *work)
{
    work->gameWork.objWork.groundVel = FLOAT_TO_FX32(0.0);

    struct EnemyRobotCommonAttackConfig *attack = &work->attack.common;

    if (attack->chargeDelay != 0)
    {
        work->gameWork.objWork.userTimer = attack->chargeDelay;
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
        SetTaskState(&work->gameWork.objWork, EnemyRobot_State_CommonAttackDelay);
    }
    else
    {
        GameObject__SetAnimation(&work->gameWork, attack->aniAttack);

        if ((work->gameWork.flags & ROBOT_FLAG_HAS_ATTACKED) == 0)
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

        SetTaskState(&work->gameWork.objWork, EnemyRobot_State_CommonAttack);

        EnemyRobot_PlayAttackSfx(work);
    }
}

void EnemyRobot_State_CommonAttackDelay(EnemyRobot *work)
{
    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer == 0)
    {
        work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_PAUSED;
        GameObject__SetAnimation(&work->gameWork, work->attack.common.aniAttack);

        if ((work->gameWork.flags & ROBOT_FLAG_HAS_ATTACKED) == 0)
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

        SetTaskState(&work->gameWork.objWork, EnemyRobot_State_CommonAttack);

        EnemyRobot_PlayAttackSfx(work);
    }
}

void EnemyRobot_State_CommonAttack(EnemyRobot *work)
{
    struct EnemyRobotCommonAttackConfig *attack = &work->attack.common;

    BOOL isDone = FALSE;

    if ((work->gameWork.flags & ROBOT_FLAG_HAS_ATTACKED) == 0)
    {
        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            work->gameWork.objWork.groundVel = ObjSpdUpSet(work->gameWork.objWork.groundVel, attack->accel, attack->targetSpeed);
        else
            work->gameWork.objWork.groundVel = ObjSpdUpSet(work->gameWork.objWork.groundVel, -attack->accel, attack->targetSpeed);

        if (work->gameWork.objWork.position.x < work->xMin)
        {
            work->gameWork.objWork.position.x = work->xMin;
            isDone                            = TRUE;
        }
        else if (work->gameWork.objWork.position.x > work->xMax)
        {
            work->gameWork.objWork.position.x = work->xMax;
            isDone                            = TRUE;
        }
    }
    else
    {
        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        {
            isDone = TRUE;
        }
    }

    if (isDone)
    {
        if (attack->chargeCooldown != 0)
        {
            work->gameWork.objWork.groundVel = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.userTimer = attack->chargeCooldown;

            SetTaskState(&work->gameWork.objWork, EnemyRobot_State_AttackCooldown);
        }
        else
        {
            work->onInit(work);
        }
    }
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

    work->attack.pterodactyl.startPos.x = work->gameWork.objWork.position.x;
    work->attack.pterodactyl.startPos.y = work->gameWork.objWork.position.y;

    work->gameWork.flags &= ~ROBOT_FLAG_HAS_ATTACKED;
    work->gameWork.objWork.groundVel = -FLOAT_TO_FX32(3.0);

    GameObject__SetAnimation(&work->gameWork, PTERODACTYL_ANI_PREPARE_ATTACK);

    SetTaskState(&work->gameWork.objWork, EnemyRobot_State_PterodactylPrepareAttack);
}

void EnemyRobot_State_PterodactylPrepareAttack(EnemyRobot *work)
{
    work->gameWork.objWork.groundVel = ObjSpdDownSet(work->gameWork.objWork.groundVel, FLOAT_TO_FX32(0.125));

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        GameObject__SetAnimation(&work->gameWork, PTERODACTYL_ANI_ATTACKING);
        SetTaskState(&work->gameWork.objWork, EnemyRobot_State_PterodactylAttack);
        PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BUTERA_PECK);
    }
}

void EnemyRobot_State_PterodactylAttack(EnemyRobot *work)
{
    struct EnemyRobotPterodactylAttackConfig *attack = &work->attack.pterodactyl;

    BOOL isDone = FALSE;

    if ((work->gameWork.flags & ROBOT_FLAG_HAS_ATTACKED) != 0)
    {
        if (work->gameWork.objWork.position.y <= attack->startPos.y && CheckPterodactylOutOfBounds(work, attack))
        {
            work->gameWork.objWork.groundVel = FLOAT_TO_FX32(0.0);
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                isDone = TRUE;
        }
        else
        {
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                work->gameWork.objWork.groundVel = FLOAT_TO_FX32(3.0);
            else
                work->gameWork.objWork.groundVel = ObjSpdDownSet(work->gameWork.objWork.groundVel, FLOAT_TO_FX32(0.1));
        }
    }
    else
    {
        if (work->gameWork.objWork.position.y >= work->detectPlayerPos.y
            && ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0 && work->gameWork.objWork.position.x >= work->detectPlayerPos.x
                || (work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0 && work->gameWork.objWork.position.x <= work->detectPlayerPos.x))
        {
            isDone = TRUE;
        }

        work->gameWork.objWork.groundVel = ObjSpdUpSet(work->gameWork.objWork.groundVel, FLOAT_TO_FX32(0.25), FLOAT_TO_FX32(6.0));
    }

    if (isDone)
    {
        if ((work->gameWork.flags & ROBOT_FLAG_HAS_ATTACKED) != 0)
        {
            work->gameWork.objWork.position.x = attack->startPos.x;
            work->gameWork.objWork.position.y = attack->startPos.y;

            work->gameWork.objWork.groundVel = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.dir.z     = FLOAT_DEG_TO_IDX(0.0);
            work->gameWork.objWork.userTimer = 10;
            GameObject__SetAnimation(&work->gameWork, PTERODACTYL_ANI_MOVE);
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;

            SetTaskState(&work->gameWork.objWork, EnemyRobot_State_AttackCooldown);
        }
        else
        {
            work->gameWork.objWork.groundVel = FLOAT_TO_FX32(3.0);
            work->gameWork.objWork.dir.z += FLOAT_DEG_TO_IDX(180.0);
            work->gameWork.objWork.hitstopTimer = FLOAT_TO_FX32(8.0);
            work->gameWork.flags |= ROBOT_FLAG_HAS_ATTACKED;

            GameObject__SetAnimation(&work->gameWork, PTERODACTYL_ANI_FINISH_ATTACK);
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        }
    }
}

void EnemyRobot_OnDetect_FlyingFish(EnemyRobot *work)
{
    work->gameWork.objWork.groundVel = FLOAT_TO_FX32(0.0);

    work->gameWork.objWork.userWork  = 0;
    work->gameWork.objWork.userTimer = 3;

    SetTaskState(&work->gameWork.objWork, EnemyRobot_State_FlyingFishAttack);
}

void EnemyRobot_State_FlyingFishAttack(EnemyRobot *work)
{
    switch (work->gameWork.objWork.userWork)
    {
        case FLYINGFISH_ATTACK_RISE:
            work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(3.0);

            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer == 0)
            {
                work->gameWork.objWork.userWork++;
                work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
                work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(6.0);
                work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
                GameObject__SetAnimation(&work->gameWork, FLYINGFISH_ANI_FALL);
                CreateEffectWaterSplash(&work->gameWork.objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), mapCamera.camera[0].waterLevel);
                work->gameWork.flags |= ROBOT_FLAG_HAS_ATTACKED;
            }
            break;

        case FLYINGFISH_ATTACK_FALL:
            if (work->gameWork.objWork.velocity.y > 0)
            {
                if (work->gameWork.objWork.position.y >= work->gameWork.originPos.y + FLOAT_TO_FX32(16.0))
                {
                    work->gameWork.objWork.userWork++;
                    work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
                    work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

                    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
                        work->gameWork.objWork.velocity.x = -FLOAT_TO_FX32(0.5);
                    else
                        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.5);
                    work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(2.5);

                    GameObject__SetAnimation(&work->gameWork, FLYINGFISH_ANI_RISE);
                    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                }

                if ((work->gameWork.flags & ROBOT_FLAG_HAS_ATTACKED) != 0 && work->gameWork.objWork.position.y >= FX32_FROM_WHOLE(mapCamera.camera[0].waterLevel))
                {
                    CreateEffectWaterSplash(&work->gameWork.objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), mapCamera.camera[0].waterLevel);
                    work->gameWork.flags &= ~ROBOT_FLAG_HAS_ATTACKED;
                }
            }
            break;

        case FLYINGFISH_ATTACK_RESET:
            if (work->gameWork.objWork.position.y <= work->gameWork.originPos.y)
            {
                work->gameWork.objWork.position.y = work->gameWork.originPos.y;

                work->gameWork.objWork.velocity.x = work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);

                work->onInit(work);
            }
            break;
    }
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
        GameObject__SetAnimation(&work->gameWork, STEAMBLASTER_ANI_PREPARE_ATTACK);

        SetTaskState(&work->gameWork.objWork, EnemyRobot_State_SteamBlasterAttack);
    }
}

void EnemyRobot_State_SteamBlasterAttack(EnemyRobot *work)
{
    switch (work->gameWork.objWork.obj_2d->ani.work.animID)
    {
        case STEAMBLASTER_ANI_PREPARE_ATTACK:
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                GameObject__SetAnimation(&work->gameWork, STEAMBLASTER_ANI_ATTACKING);

                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
                work->gameWork.objWork.userTimer = 120;

                work->gameWork.colliders[2].parent = &work->gameWork.objWork;
                work->gameWork.colliders[2].flag |= OBS_RECT_WORK_FLAG_IS_ACTIVE;
                ObjRect__SetBox2D(&work->gameWork.colliders[2].rect, 0, 0, 0, 0);

                CreateEffectSteamBlasterSteam(&work->gameWork.objWork, -FLOAT_TO_FX32(33.0), -FLOAT_TO_FX32(31.0), 120);
                PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_STEAM_ATTACK);
                ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
            }
            break;

        case STEAMBLASTER_ANI_ATTACKING:
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer != 0)
            {
                s32 size = 12 * (120 - work->gameWork.objWork.userTimer);
                if (size > 72)
                    size = 72;

                ObjRect__SetBox2D(&work->gameWork.colliders[2].rect, -33 - size, -40, -33, -16);
                ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
            }
            else
            {
                GameObject__SetAnimation(&work->gameWork, STEAMBLASTER_ANI_FINISH_ATTACK);
                work->gameWork.colliders[2].parent = NULL;
                FadeOutStageSfx(work->gameWork.objWork.sequencePlayerPtr, 32);
            }
            break;

            // case STEAMBLASTER_ANI_FINISH_ATTACK:
        default:
            if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
            {
                work->onInit(work);
            }
            break;
    }
}

void EnemyRobot_OnDefend_Steam(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
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

    if ((robot->gameWork.objWork.flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) == 0)
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