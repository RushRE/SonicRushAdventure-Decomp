#include <stage/enemies/pirate.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/audio/spatialAudio.h>
#include <stage/effects/explosion.h>
#include <stage/effects/found.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_xMin   mapObject->left
#define mapObjectParam_xRange mapObject->width

// --------------------
// CONSTANTS
// --------------------

#define PIRATE_ANI_NONE 0xFFFF

// --------------------
// ENUMS
// --------------------

enum PirateObjectFlags
{
    PIRATE_OBJFLAG_NONE,

    PIRATE_OBJFLAG_FLIPPED = (1 << 0),
};

enum PirateFlags
{
    PIRATE_FLAG_NONE,

    PIRATE_FLAG_TURNING = (1 << 0),
};

enum KnifePirateAnimID
{
    KNIFEPIRATE_ANI_MOVE,
    KNIFEPIRATE_ANI_TURN,
    KNIFEPIRATE_ANI_DETECT,
    KNIFEPIRATE_ANI_ATTACK,
};

enum BazookaPirateAnimID
{
    BAZOOKAPIRATE_ANI_MOVE,
    BAZOOKAPIRATE_ANI_ATTACK,
    BAZOOKAPIRATE_ANI_DETECT,
    BAZOOKAPIRATE_ANI_TURN,
    BAZOOKAPIRATE_ANI_SHOT,
};

enum BallChainPirateAnimID
{
    BALLCHAINPIRATE_ANI_MOVE,
    BALLCHAINPIRATE_ANI_TURN,
    BALLCHAINPIRATE_ANI_DETECT,
    BALLCHAINPIRATE_ANI_ATTACK,
    BALLCHAINPIRATE_ANI_BALL,
    BALLCHAINPIRATE_ANI_CHAIN,
};

enum BombPirateAnimID
{
    BOMBPIRATE_ANI_MOVE,
    BOMBPIRATE_ANI_ATTACK,
    BOMBPIRATE_ANI_TURN,
    BOMBPIRATE_ANI_BOMB,
};

enum SkeletonPirateAnimID
{
    SKELETONPIRATE_ANI_MOVE,
    SKELETONPIRATE_ANI_TURN,
    SKELETONPIRATE_ANI_ATTACK,
    SKELETONPIRATE_ANI_BONE,
};

enum HoverBomberPirateAnimID
{
    HOVERBOMBERPIRATE_ANI_MOVE,
    HOVERBOMBERPIRATE_ANI_TURN,
    HOVERBOMBERPIRATE_ANI_DETECT,
    HOVERBOMBERPIRATE_ANI_ATTACK,
    HOVERBOMBERPIRATE_ANI_BOMB,
};

enum HoverGunnerPirateAnimID
{
    HOVERGUNNERPIRATE_ANI_MOVE,
    HOVERGUNNERPIRATE_ANI_TURN,
    HOVERGUNNERPIRATE_ANI_DETECT,
    HOVERGUNNERPIRATE_ANI_ATTACK,
    HOVERGUNNERPIRATE_ANI_SHOT,
};

// --------------------
// VARIABLES
// --------------------

static const u16 attackFrameTable[PIRATE_TYPE_COUNT] = {
    [PIRATE_TYPE_KNIFE] = 0,     [PIRATE_TYPE_BAZOOKA] = 7,     [PIRATE_TYPE_BALLCHAIN] = 5,   [PIRATE_TYPE_BOMB] = 6,
    [PIRATE_TYPE_SKELETON] = 13, [PIRATE_TYPE_HOVERBOMBER] = 5, [PIRATE_TYPE_HOVERGUNNER] = 7,
};

static const u16 spritePaletteIDList[PIRATE_TYPE_COUNT] = {
    [PIRATE_TYPE_KNIFE] = 75,    [PIRATE_TYPE_BAZOOKA] = 76,     [PIRATE_TYPE_BALLCHAIN] = 77,   [PIRATE_TYPE_BOMB] = 78,
    [PIRATE_TYPE_SKELETON] = 79, [PIRATE_TYPE_HOVERBOMBER] = 80, [PIRATE_TYPE_HOVERGUNNER] = 82,
};

static const s16 colliderActivateDelay[PIRATE_TYPE_COUNT] = {
    [PIRATE_TYPE_KNIFE] = 120,    [PIRATE_TYPE_BAZOOKA] = 120,     [PIRATE_TYPE_BALLCHAIN] = 120,   [PIRATE_TYPE_BOMB] = 120,
    [PIRATE_TYPE_SKELETON] = 120, [PIRATE_TYPE_HOVERBOMBER] = 120, [PIRATE_TYPE_HOVERGUNNER] = 120,
};

static const u32 dataWorkTable[PIRATE_TYPE_COUNT] = {
    [PIRATE_TYPE_KNIFE] = OBJDATAWORK_15,    [PIRATE_TYPE_BAZOOKA] = OBJDATAWORK_16,     [PIRATE_TYPE_BALLCHAIN] = OBJDATAWORK_17,   [PIRATE_TYPE_BOMB] = OBJDATAWORK_18,
    [PIRATE_TYPE_SKELETON] = OBJDATAWORK_19, [PIRATE_TYPE_HOVERBOMBER] = OBJDATAWORK_20, [PIRATE_TYPE_HOVERGUNNER] = OBJDATAWORK_21,
};

static const Vec2Fx32 ballOffsetTable[4] = {
    { FLOAT_TO_FX32(10.0), -FLOAT_TO_FX32(61.0) },
    { -FLOAT_TO_FX32(15.0), -FLOAT_TO_FX32(67.0) },
    { -FLOAT_TO_FX32(53.0), -FLOAT_TO_FX32(38.0) },
    { -FLOAT_TO_FX32(42.0), -FLOAT_TO_FX32(37.0) },
};

static const HitboxRect detectRange[PIRATE_TYPE_COUNT] = {
    [PIRATE_TYPE_KNIFE] = { -100, -64, 0, 0 },       [PIRATE_TYPE_BAZOOKA] = { -100, -64, 0, 0 },  [PIRATE_TYPE_BALLCHAIN] = { -128, -64, 0, 0 },
    [PIRATE_TYPE_BOMB] = { -100, -64, 0, 0 },        [PIRATE_TYPE_SKELETON] = { -100, -64, 0, 0 }, [PIRATE_TYPE_HOVERBOMBER] = { -73, 0, 23, 128 },
    [PIRATE_TYPE_HOVERGUNNER] = { -150, 0, 0, 128 },
};

static const Vec2Fx32 foundPosTable[PIRATE_TYPE_COUNT] = {
    [PIRATE_TYPE_KNIFE] = { FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(64.0) },       [PIRATE_TYPE_BAZOOKA] = { FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(64.0) },
    [PIRATE_TYPE_BALLCHAIN] = { FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(64.0) },   [PIRATE_TYPE_BOMB] = { FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(64.0) },
    [PIRATE_TYPE_SKELETON] = { FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(64.0) },    [PIRATE_TYPE_HOVERBOMBER] = { FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(64.0) },
    [PIRATE_TYPE_HOVERGUNNER] = { FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(64.0) },
};

static const Vec2Fx32 projectilePosTable[PIRATE_TYPE_COUNT] = {
    [PIRATE_TYPE_KNIFE] = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0) },          [PIRATE_TYPE_BAZOOKA] = { -FLOAT_TO_FX32(18.0), -FLOAT_TO_FX32(39.0) },
    [PIRATE_TYPE_BALLCHAIN] = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0) },      [PIRATE_TYPE_BOMB] = { -FLOAT_TO_FX32(20.0), -FLOAT_TO_FX32(50.0) },
    [PIRATE_TYPE_SKELETON] = { -FLOAT_TO_FX32(25.0), -FLOAT_TO_FX32(60.0) },   [PIRATE_TYPE_HOVERBOMBER] = { -FLOAT_TO_FX32(25.0), FLOAT_TO_FX32(17.0) },
    [PIRATE_TYPE_HOVERGUNNER] = { -FLOAT_TO_FX32(37.0), FLOAT_TO_FX32(17.0) },
};

static const char *spriteList[PIRATE_TYPE_COUNT] = {
    [PIRATE_TYPE_KNIFE] = "/act/ac_ene_prt_knife.bac",       [PIRATE_TYPE_BAZOOKA] = "/act/ac_ene_prt_bazooka.bac", [PIRATE_TYPE_BALLCHAIN] = "/act/ac_ene_prt_hogun.bac",
    [PIRATE_TYPE_BOMB] = "/act/ac_ene_prt_bomb.bac",         [PIRATE_TYPE_SKELETON] = "/act/ac_ene_p_skeleton.bac", [PIRATE_TYPE_HOVERBOMBER] = "/act/ac_ene_hobar_bomb.bac",
    [PIRATE_TYPE_HOVERGUNNER] = "/act/ac_ene_hobar_gun.bac",
};

// --------------------
// FUNCTION DECLS
// --------------------

// Misc Common
static void EnemyPirate_InitMoveRange(EnemyPirate *work);
static void EnemyPirate_HandleColliderActivateTimer(EnemyPirate *work);

// BallChainPirateBall Management
static void EnemyBallChainPirateBall_Destructor(Task *task);
static GameObjectTask *EnemyPirate_InitBallChain(EnemyBallChainPirateBall *work);
static void EnemyBallChainPirateBall_State_Active(EnemyBallChainPirateBall *work);
static void EnemyBallChainPirateBall_Draw(void);

// Events
static void EnemyPirate_OnInit_Common(EnemyPirate *work);
static void EnemyPirate_State_CommonMove(EnemyPirate *work);
static void EnemyPirate_OnInit_BallChain(EnemyPirate *work);
static void EnemyPirate_OnInit_Hover(EnemyPirate *work);
static void EnemyPirate_State_CommonHover(EnemyPirate *work);
static void EnemyPirate_OnDetect_Common(EnemyPirate *work);

// Attack States
static void EnemyPirate_State_AttackDelay(EnemyPirate *work);
static void EnemyPirate_State_AttackCooldown(EnemyPirate *work);
static void EnemyPirate_State_KnifeAttack(EnemyPirate *work);
static void EnemyPirate_State_BazookaAttack(EnemyPirate *work);
static void EnemyPirate_State_BallChainAttack(EnemyPirate *work);

// Spawning
static GameObjectTask *EnemyPirate_SpawnProjectile(EnemyPirate *work);

// BazookaPirateShot
static void EnemyBazookaPirateShot_State_Init(EnemyBazookaPirateShot *work);
static void EnemyBazookaPirateShot_State_Active(EnemyBazookaPirateShot *work);

// BallChainPirateBall
static void EnemyBallChainPirateBall_StateBall_InitSwing(EnemyBallChainPirateBall *work);
static void EnemyBallChainPirateBall_StateBall_Swing(EnemyBallChainPirateBall *work);
static void EnemyBallChainPirateBall_StateBall_EmergencyRecall(EnemyBallChainPirateBall *work);
static void EnemyBallChainPirateBall_StateBall_InitThrow(EnemyBallChainPirateBall *work);
static void EnemyBallChainPirateBall_StateBall_Thrown(EnemyBallChainPirateBall *work);
static void EnemyBallChainPirateBall_StateBall_ThrownIdle(EnemyBallChainPirateBall *work);
static void EnemyBallChainPirateBall_StateBall_InitRecall(EnemyBallChainPirateBall *work);
static void EnemyBallChainPirateBall_StateBall_Recalling(EnemyBallChainPirateBall *work);

// BazookaPirateShot
static void EnemyBombPirateBomb_State_Init(EnemyBombPirateBomb *work);
static void EnemyBombPirateBomb_State_Active(EnemyBombPirateBomb *work);
static void EnemyBombPirateBomb_State_Explode(EnemyBombPirateBomb *work);

// SkeletonPirateBone
static void EnemySkeletonPirateBone_State_Init(EnemyBombPirateBomb *work);
static void EnemySkeletonPirateBone_State_Active(EnemySkeletonPirateBone *work);

// HoverBomberPirateBomb
static void EnemyHoverBomberPirateBomb_State_Init(EnemyHoverBomberPirateBomb *work);
static void EnemyHoverBomberPirateBomb_State_Active(EnemyHoverBomberPirateBomb *work);

// HoverGunnerPirateShot
static void EnemyHoverGunnerPirateShot_State_Init(EnemyHoverGunnerPirateShot *work);
static void EnemyHoverGunnerPirateShot_State_Active(EnemyHoverGunnerPirateShot *work);

// OnHit events
static void EnemyBazookaPirateShot_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemyBombPirateBomb_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemySkeletonPirateBone_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemyHoverBomberPirateBomb_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// Detection events
static void EnemyPirate_OnDefend_DetectCommon(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void EnemyPirate_OnDefend_DetectHoverGunner(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// INLINE FUNCTIONS
// --------------------

FORCE_INCLUDE_ARRAY(u32, unknownTable, 4, { FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(77.0), -FLOAT_TO_FX32(53.0), -FLOAT_TO_FX32(57.0) })

// --------------------
// FUNCTIONS
// --------------------

EnemyPirate *CreatePirate(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (mapObject == NULL || (mapObject->x != MAPOBJECT_DESTROYED || mapObject->y != MAPOBJECT_DESTROYED))
    {
        if (gameState.difficulty == DIFFICULTY_EASY && (mapObject->flags & ENEMYCOMMON_OBJFLAG_DISABLED_ON_EASY) != 0)
            return NULL;
    }

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), EnemyPirate);
    if (task == HeapNull)
        return NULL;

    EnemyPirate *work = TaskGetWork(task, EnemyPirate);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    PirateType pirateType;
    switch (mapObject->id)
    {
        case MAPOBJECT_13:
            pirateType = PIRATE_TYPE_KNIFE;

            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_4000 | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
            EnemyPirate_InitMoveRange(work);

            work->onInit                     = EnemyPirate_OnInit_Common;
            work->move.common.aniMove        = KNIFEPIRATE_ANI_MOVE;
            work->move.common.aniTurn        = KNIFEPIRATE_ANI_TURN;
            work->move.common.aniDetect      = KNIFEPIRATE_ANI_DETECT;
            work->move.common.detectDelay    = 120;
            work->move.common.detectDuration = 0;
            work->move.common.moveSpeed      = FLOAT_TO_FX32(0.75);

            work->onDetect                  = EnemyPirate_OnDetect_Common;
            work->attack.common.anim        = KNIFEPIRATE_ANI_ATTACK;
            work->attack.common.attackState = EnemyPirate_State_KnifeAttack;
            break;

        case MAPOBJECT_14:
            pirateType = PIRATE_TYPE_BAZOOKA;

            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
            EnemyPirate_InitMoveRange(work);

            work->onInit                     = EnemyPirate_OnInit_Common;
            work->move.common.aniMove        = BAZOOKAPIRATE_ANI_MOVE;
            work->move.common.aniTurn        = BAZOOKAPIRATE_ANI_TURN;
            work->move.common.aniDetect      = BAZOOKAPIRATE_ANI_DETECT;
            work->move.common.detectDelay    = 120;
            work->move.common.detectDuration = 0;
            work->move.common.moveSpeed      = FLOAT_TO_FX32(0.9375);

            work->onDetect                  = EnemyPirate_OnDetect_Common;
            work->attack.common.anim        = BAZOOKAPIRATE_ANI_ATTACK;
            work->attack.common.attackState = EnemyPirate_State_BazookaAttack;
            break;

        case MAPOBJECT_15:
            pirateType = PIRATE_TYPE_BALLCHAIN;

            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES;

            work->gameWork.health = 2;
            work->gameWork.health -= work->gameWork.mapObject->param.health;
            EnemyPirate_InitMoveRange(work);

            work->onInit                = EnemyPirate_OnInit_BallChain;
            work->move.common.aniMove   = BALLCHAINPIRATE_ANI_MOVE;
            work->move.common.aniTurn   = BALLCHAINPIRATE_ANI_TURN;
            work->move.common.aniDetect = PIRATE_ANI_NONE;
            work->move.common.moveSpeed = FLOAT_TO_FX32(0.5);

            work->onDetect                     = EnemyPirate_OnDetect_Common;
            work->attack.ballChain.duration    = 15;
            work->attack.ballChain.anim        = BALLCHAINPIRATE_ANI_ATTACK;
            work->attack.ballChain.attackState = EnemyPirate_State_BallChainAttack;
            break;

        case MAPOBJECT_16:
            pirateType = PIRATE_TYPE_BOMB;

            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
            EnemyPirate_InitMoveRange(work);

            work->onInit                = EnemyPirate_OnInit_Common;
            work->move.common.aniMove   = BOMBPIRATE_ANI_MOVE;
            work->move.common.aniTurn   = BOMBPIRATE_ANI_TURN;
            work->move.common.aniDetect = PIRATE_ANI_NONE;
            work->move.common.moveSpeed = FLOAT_TO_FX32(0.75);

            work->onDetect                  = EnemyPirate_OnDetect_Common;
            work->attack.common.anim        = BOMBPIRATE_ANI_ATTACK;
            work->attack.common.attackState = EnemyPirate_State_BazookaAttack;
            break;

        case MAPOBJECT_17:
            pirateType = PIRATE_TYPE_SKELETON;

            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
            EnemyPirate_InitMoveRange(work);

            work->onInit                     = EnemyPirate_OnInit_Hover;
            work->move.common.aniMove        = SKELETONPIRATE_ANI_MOVE;
            work->move.common.aniTurn        = SKELETONPIRATE_ANI_TURN;
            work->move.common.aniDetect      = PIRATE_ANI_NONE;
            work->move.common.detectDelay    = 120;
            work->move.common.detectDuration = 0;
            work->move.common.hoverRadius    = FLOAT_TO_FX32(4.0);
            work->move.common.moveSpeed      = FLOAT_TO_FX32(0.75);

            work->onDetect                  = EnemyPirate_OnDetect_Common;
            work->attack.common.anim        = SKELETONPIRATE_ANI_ATTACK;
            work->attack.common.attackState = EnemyPirate_State_BazookaAttack;
            break;

        case MAPOBJECT_18:
            pirateType = PIRATE_TYPE_HOVERBOMBER;

            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_Y_COLLISION_CHECK | STAGE_TASK_MOVE_FLAG_DISABLE_X_COLLISION_CHECK
                                               | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
            EnemyPirate_InitMoveRange(work);

            work->onInit                     = EnemyPirate_OnInit_Hover;
            work->move.common.aniMove        = HOVERBOMBERPIRATE_ANI_MOVE;
            work->move.common.aniTurn        = HOVERBOMBERPIRATE_ANI_TURN;
            work->move.common.aniDetect      = HOVERBOMBERPIRATE_ANI_DETECT;
            work->move.common.detectDelay    = 120;
            work->move.common.detectDuration = 0;
            work->move.common.hoverRadius    = FLOAT_TO_FX32(4.0);
            work->move.common.moveSpeed      = FLOAT_TO_FX32(0.75);

            work->onDetect                  = EnemyPirate_OnDetect_Common;
            work->attack.common.anim        = HOVERBOMBERPIRATE_ANI_ATTACK;
            work->attack.common.attackState = EnemyPirate_State_BazookaAttack;
            break;

        case MAPOBJECT_19:
            pirateType = PIRATE_TYPE_HOVERGUNNER;

            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_Y_COLLISION_CHECK | STAGE_TASK_MOVE_FLAG_DISABLE_X_COLLISION_CHECK
                                               | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
            EnemyPirate_InitMoveRange(work);

            work->onInit                     = EnemyPirate_OnInit_Hover;
            work->move.common.aniMove        = HOVERGUNNERPIRATE_ANI_MOVE;
            work->move.common.aniTurn        = HOVERGUNNERPIRATE_ANI_TURN;
            work->move.common.aniDetect      = HOVERGUNNERPIRATE_ANI_DETECT;
            work->move.common.detectDelay    = 120;
            work->move.common.detectDuration = 0;
            work->move.common.hoverRadius    = FLOAT_TO_FX32(4.0);
            work->move.common.moveSpeed      = FLOAT_TO_FX32(0.75);

            work->onDetect                  = EnemyPirate_OnDetect_Common;
            work->attack.common.anim        = HOVERGUNNERPIRATE_ANI_ATTACK;
            work->attack.common.attackState = EnemyPirate_State_BazookaAttack;
            break;
    }

    work->type = pirateType;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, spriteList[pirateType], GetObjectDataWork(dataWorkTable[pirateType]), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, spritePaletteIDList[pirateType]);

    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT) == 0)
        StageTask__SetHitbox(&work->gameWork.objWork, -8, -10, 8, -2);

    ObjRect__SetBox2D(&work->colliderDetect.rect, detectRange[pirateType].left, detectRange[pirateType].top, detectRange[pirateType].right, detectRange[pirateType].bottom);
    ObjRect__SetAttackStat(&work->colliderDetect, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->colliderDetect, OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetGroupFlags(&work->colliderDetect, 2, 1);
    work->colliderDetect.flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR | OBS_RECT_WORK_FLAG_DISABLE_DEF_RESPONSE | OBS_RECT_WORK_FLAG_DISABLE_ATK_RESPONSE;

    if (pirateType == PIRATE_TYPE_HOVERGUNNER)
    {
        ObjRect__SetOnDefend(&work->colliderDetect, EnemyPirate_OnDefend_DetectHoverGunner);
        work->colliderDetect.flag &= ~OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    }
    else
    {
        ObjRect__SetOnDefend(&work->colliderDetect, EnemyPirate_OnDefend_DetectCommon);
    }
    work->colliderDetect.parent = &work->gameWork.objWork;

    if ((mapObject->flags & PIRATE_OBJFLAG_FLIPPED) != 0)
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    work->onInit(work);

    StageTask__InitSeqPlayer(&work->gameWork.objWork);

    return work;
}

EnemyBazookaPirateShot *CreateBazookaPirateShot(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), EnemyBazookaPirateShot);
    if (task == HeapNull)
        return NULL;

    EnemyBazookaPirateShot *work = TaskGetWork(task, EnemyBazookaPirateShot);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjRect__SetDefenceStat(work->gameWork.colliders, OBS_RECT_WORK_ATTR_BODY, OBS_RECT_DEFPOWER_DEFAULT + 2);
    ObjRect__SetOnAttack(&work->gameWork.colliders[1], EnemyBazookaPirateShot_OnHit);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES | STAGE_TASK_MOVE_FLAG_IN_AIR;

    StageTask__SetHitbox(&work->gameWork.objWork, -7, -7, 7, 7);
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, spriteList[PIRATE_TYPE_BAZOOKA], GetObjectDataWork(OBJDATAWORK_16), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, BAZOOKAPIRATE_ANI_MOVE, 76);
    GameObject__SetAnimation(&work->gameWork, BAZOOKAPIRATE_ANI_SHOT);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyBazookaPirateShot_State_Init);

    StageTask__InitSeqPlayer(&work->gameWork.objWork);

    return work;
}

EnemyBallChainPirateBall *CreateBallChainPirateBall(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(EnemyBallChainPirateBall_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), EnemyBallChainPirateBall);
    if (task == HeapNull)
        return NULL;

    EnemyBallChainPirateBall *work = TaskGetWork(task, EnemyBallChainPirateBall);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjRect__SetDefenceStat(work->gameWork.colliders, OBS_RECT_WORK_ATTR_BODY, OBS_RECT_DEFPOWER_DEFAULT + 2);

    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES | STAGE_TASK_MOVE_FLAG_IN_AIR;

    StageTask__SetHitbox(&work->gameWork.objWork, -13, -13, 13, 13);
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, spriteList[PIRATE_TYPE_BALLCHAIN], GetObjectDataWork(OBJDATAWORK_17), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, BALLCHAINPIRATE_ANI_MOVE, 77);
    GameObject__SetAnimation(&work->gameWork, BALLCHAINPIRATE_ANI_BALL);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskOutFunc(&work->gameWork.objWork, EnemyBallChainPirateBall_Draw);
    SetTaskState(&work->gameWork.objWork, EnemyBallChainPirateBall_State_Active);

    work->stateBall = EnemyBallChainPirateBall_StateBall_InitSwing;

    return work;
}

EnemyBombPirateBomb *CreateBombPirateBomb(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), EnemyBombPirateBomb);
    if (task == HeapNull)
        return NULL;

    EnemyBombPirateBomb *work = TaskGetWork(task, EnemyBombPirateBomb);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjRect__SetDefenceStat(work->gameWork.colliders, OBS_RECT_WORK_ATTR_BODY, OBS_RECT_DEFPOWER_DEFAULT + 2);
    ObjRect__SetOnAttack(&work->gameWork.colliders[1], EnemyBombPirateBomb_OnHit);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES | STAGE_TASK_MOVE_FLAG_IN_AIR;

    StageTask__SetHitbox(&work->gameWork.objWork, -6, -6, 6, 6);
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, spriteList[PIRATE_TYPE_BOMB], GetObjectDataWork(OBJDATAWORK_18), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, BOMBPIRATE_ANI_MOVE, 78);
    GameObject__SetAnimation(&work->gameWork, BOMBPIRATE_ANI_BOMB);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyBombPirateBomb_State_Init);

    StageTask__InitSeqPlayer(&work->gameWork.objWork);

    return work;
}

EnemySkeletonPirateBone *CreateSkeletonPirateBone(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), EnemySkeletonPirateBone);
    if (task == HeapNull)
        return NULL;

    EnemySkeletonPirateBone *work = TaskGetWork(task, EnemySkeletonPirateBone);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjRect__SetDefenceStat(work->gameWork.colliders, OBS_RECT_WORK_ATTR_BODY, OBS_RECT_DEFPOWER_DEFAULT + 2);
    ObjRect__SetOnAttack(&work->gameWork.colliders[1], EnemySkeletonPirateBone_OnHit);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES | STAGE_TASK_MOVE_FLAG_IN_AIR;

    StageTask__SetHitbox(&work->gameWork.objWork, -3, -3, 3, 3);
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, spriteList[PIRATE_TYPE_SKELETON], GetObjectDataWork(OBJDATAWORK_19), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, SKELETONPIRATE_ANI_MOVE, 79);
    GameObject__SetAnimation(&work->gameWork, SKELETONPIRATE_ANI_BONE);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemySkeletonPirateBone_State_Init);

    StageTask__InitSeqPlayer(&work->gameWork.objWork);

    return work;
}

EnemyHoverBomberPirateBomb *CreateHoverBomberPirateBomb(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), EnemyHoverBomberPirateBomb);
    if (task == HeapNull)
        return NULL;

    EnemyHoverBomberPirateBomb *work = TaskGetWork(task, EnemyHoverBomberPirateBomb);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjRect__SetDefenceStat(work->gameWork.colliders, OBS_RECT_WORK_ATTR_BODY, OBS_RECT_DEFPOWER_DEFAULT + 2);
    ObjRect__SetOnAttack(&work->gameWork.colliders[1], EnemyHoverBomberPirateBomb_OnHit);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES | STAGE_TASK_MOVE_FLAG_IN_AIR;

    StageTask__SetHitbox(&work->gameWork.objWork, -8, -8, 8, 8);
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, spriteList[PIRATE_TYPE_HOVERBOMBER], GetObjectDataWork(OBJDATAWORK_20), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, HOVERBOMBERPIRATE_ANI_MOVE, 80);
    GameObject__SetAnimation(&work->gameWork, HOVERBOMBERPIRATE_ANI_BOMB);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyHoverBomberPirateBomb_State_Init);

    StageTask__InitSeqPlayer(&work->gameWork.objWork);

    return work;
}

EnemyHoverGunnerPirateShot *CreateHoverGunnerPirateShot(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1500, TASK_GROUP(2), EnemyHoverGunnerPirateShot);
    if (task == HeapNull)
        return NULL;

    EnemyHoverGunnerPirateShot *work = TaskGetWork(task, EnemyHoverGunnerPirateShot);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjRect__SetDefenceStat(work->gameWork.colliders, OBS_RECT_WORK_ATTR_BODY, OBS_RECT_DEFPOWER_DEFAULT + 2);
    ObjRect__SetOnAttack(&work->gameWork.colliders[1], EnemyBazookaPirateShot_OnHit);

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES | STAGE_TASK_MOVE_FLAG_IN_AIR;

    StageTask__SetHitbox(&work->gameWork.objWork, -4, -4, 4, 4);
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, spriteList[PIRATE_TYPE_HOVERGUNNER], GetObjectDataWork(OBJDATAWORK_21), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, HOVERGUNNERPIRATE_ANI_MOVE, 82);
    GameObject__SetAnimation(&work->gameWork, HOVERGUNNERPIRATE_ANI_SHOT);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyHoverGunnerPirateShot_State_Init);

    StageTask__InitSeqPlayer(&work->gameWork.objWork);

    return work;
}

void EnemyPirate_InitMoveRange(EnemyPirate *work)
{
    work->xMin = work->gameWork.objWork.position.x + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_xMin);
    work->xMax = work->xMin + FX32_FROM_WHOLE(work->gameWork.mapObjectParam_xRange);
}

void EnemyPirate_HandleColliderActivateTimer(EnemyPirate *work)
{
    if (work->colliderActivateTimer != 0)
    {
        work->colliderActivateTimer--;
        if (work->colliderActivateTimer == 0)
            work->colliderDetect.flag |= OBS_RECT_WORK_FLAG_ENABLED;
    }
}

void EnemyBallChainPirateBall_Destructor(Task *task)
{
    EnemyBallChainPirateBall *work = TaskGetWork(task, EnemyBallChainPirateBall);

    ObjObjectActionReleaseGfxRefs(&work->chainWork.objWork);

    if (work->chainWork.objWork.obj_2d->fileWork != NULL)
    {
        ObjDataRelease(work->chainWork.objWork.obj_2d->fileWork);
    }
    else
    {
        if (work->chainWork.objWork.obj_2d->ani.work.fileData != NULL && (work->chainWork.objWork.flag & STAGE_TASK_FLAG_DISABLE_OBJ_2D_RELEASE) == 0)
            HeapFree(HEAP_USER, work->chainWork.objWork.obj_2d->ani.work.fileData);
    }

    if ((work->chainWork.objWork.flag
         & (STAGE_TASK_FLAG_ALLOCATED_OBJ_2DIN3D | STAGE_TASK_FLAG_ALLOCATED_OBJ_2D | STAGE_TASK_FLAG_ALLOCATED_COLLIDERS | STAGE_TASK_FLAG_ALLOCATED_COLLISION_OBJ))
        != 0)
    {
        if ((work->chainWork.objWork.flag & STAGE_TASK_FLAG_ALLOCATED_OBJ_2D) != 0 && work->chainWork.objWork.obj_2d != NULL)
            HeapFree(HEAP_USER, work->chainWork.objWork.obj_2d);
    }

    GameObject__Destructor(task);
}

GameObjectTask *EnemyPirate_InitBallChain(EnemyBallChainPirateBall *work)
{
    GameObjectTask *chainWork = &work->chainWork;

    chainWork->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
    chainWork->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MAP_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_Y_COLLISION_CHECK | STAGE_TASK_MOVE_FLAG_DISABLE_X_COLLISION_CHECK
                                   | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    GameObject__InitFromObject(chainWork, work->gameWork.mapObject, 0, 0);
    ObjObjectAction2dBACLoad(&chainWork->objWork, &chainWork->animator, spriteList[PIRATE_TYPE_BALLCHAIN], GetObjectDataWork(OBJDATAWORK_17), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&chainWork->objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&chainWork->objWork, SPRITE_PRIORITY_2);
    ObjActionAllocSpritePalette(&chainWork->objWork, BALLCHAINPIRATE_ANI_MOVE, 77);
    StageTask__SetAnimation(&chainWork->objWork, BALLCHAINPIRATE_ANI_CHAIN);

    chainWork->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    return chainWork;
}

void EnemyBallChainPirateBall_State_Active(EnemyBallChainPirateBall *work)
{
    EnemyPirate *parent = (EnemyPirate *)work->gameWork.objWork.parentObj;

    work->gameWork.objWork.displayFlag &= ~(DISPLAY_FLAG_DISABLE_DRAW | DISPLAY_FLAG_FLIP_Y | DISPLAY_FLAG_FLIP_X);
    work->gameWork.objWork.displayFlag |= work->gameWork.objWork.parentObj->displayFlag & (DISPLAY_FLAG_DISABLE_DRAW | DISPLAY_FLAG_FLIP_Y | DISPLAY_FLAG_FLIP_X);

    work->chainWork.objWork.displayFlag &= ~(DISPLAY_FLAG_DISABLE_DRAW | DISPLAY_FLAG_FLIP_Y | DISPLAY_FLAG_FLIP_X);
    work->chainWork.objWork.displayFlag |= work->gameWork.objWork.parentObj->displayFlag & (DISPLAY_FLAG_DISABLE_DRAW | DISPLAY_FLAG_FLIP_Y | DISPLAY_FLAG_FLIP_X);

    if (parent->gameWork.blinkTimer != 0)
    {
        work->gameWork.colliders[0].defPower = OBS_RECT_DEFPOWER_INVINCIBLE;
        work->gameWork.colliders[1].hitPower = OBS_RECT_HITPOWER_VULNERABLE;
    }
    else
    {
        work->gameWork.colliders[0].defPower = OBS_RECT_DEFPOWER_DEFAULT;
        work->gameWork.colliders[1].hitPower = OBS_RECT_HITPOWER_DEFAULT;
    }

    if (work->stateBall != NULL)
        work->stateBall(work);
}

void EnemyBallChainPirateBall_Draw(void)
{
    EnemyBallChainPirateBall *work = TaskGetWorkCurrent(EnemyBallChainPirateBall);

    StageTask__Draw(&work->gameWork.objWork);

    s32 i;
    fx32 originX, originY;

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        originX = work->gameWork.objWork.parentObj->position.x - work->offset.x;
    else
        originX = work->gameWork.objWork.parentObj->position.x + work->offset.x;
    originY = work->gameWork.objWork.parentObj->position.y + work->offset.y;

    fx32 parentX                       = work->gameWork.objWork.position.x;
    fx32 parentY                       = work->gameWork.objWork.position.y;
    work->chainWork.objWork.position.x = originX;
    work->chainWork.objWork.position.y = originY;

    fx32 moveX = (originX - parentX) >> 3;
    fx32 moveY = (originY - parentY) >> 3;

    i = 0;
    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_HAS_GRAVITY) == 0)
    {
        fx32 x = 0;
        fx32 y = 0;
        for (; i < 8; i++)
        {
            work->chainWork.objWork.position.x = originX - x;
            work->chainWork.objWork.position.y = originY - y;
            StageTask__Draw(&work->chainWork.objWork);

            x += moveX;
            y += moveY;
        }
    }
    else
    {
        fx32 x = 0;
        fx32 y = 0;
        for (; i < 8; i++)
        {
            work->chainWork.objWork.position.x = originX - x;
            work->chainWork.objWork.position.y = originY - MultiplyFX(8 * moveY, SinFX((s32)(u16)y));
            StageTask__Draw(&work->chainWork.objWork);

            x += moveX;
            y += FLOAT_TO_FX32(0.5);
        }
    }
}

void EnemyPirate_OnInit_Common(EnemyPirate *work)
{
    GameObject__SetAnimation(&work->gameWork, work->move.common.aniMove);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyPirate_State_CommonMove);
    work->gameWork.objWork.userTimer = 0;
}

void EnemyPirate_State_CommonMove(EnemyPirate *work)
{
    struct EnemyPirateMoveConfigCommon *move = &work->move.common;

    BOOL shouldTurn = FALSE;

    if ((work->gameWork.flags & PIRATE_FLAG_TURNING) != 0)
    {
        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) == 0)
            return;

        work->gameWork.flags &= ~PIRATE_FLAG_TURNING;
        work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
        GameObject__SetAnimation(&work->gameWork, move->aniMove);
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    }
    else if (work->type == PIRATE_TYPE_BOMB)
    {
        if (work->gameWork.objWork.obj_2d->ani.work.animFrameIndex == 1)
        {
            if (!work->thrownBomb)
            {
                PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BARREL);
                work->thrownBomb = TRUE;
            }
        }
        else
        {
            work->thrownBomb = FALSE;
        }
    }

    EnemyPirate_HandleColliderActivateTimer(work);
    StageTask__HandleCollider(&work->gameWork.objWork, &work->colliderDetect);

    if (move->aniDetect != PIRATE_ANI_NONE)
    {
        if (work->gameWork.objWork.obj_2d->ani.work.animID != move->aniDetect)
        {
            work->gameWork.objWork.userTimer++;
            if (work->gameWork.objWork.userTimer >= move->detectDelay)
            {
                work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
                GameObject__SetAnimation(&work->gameWork, move->aniDetect);

                if (move->detectDuration != 0)
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
        work->gameWork.objWork.velocity.x = -move->moveSpeed;
    else
        work->gameWork.objWork.velocity.x = move->moveSpeed;

    work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_X_COLLISION_CHECK;

    if ((work->gameWork.objWork.moveFlag & (STAGE_TASK_MOVE_FLAG_TOUCHING_RWALL | STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL)) != 0)
    {
        shouldTurn = TRUE;
        work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_X_COLLISION_CHECK;
    }

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
        if (move->aniTurn != PIRATE_ANI_NONE)
        {
            GameObject__SetAnimation(&work->gameWork, move->aniTurn);
            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
            work->gameWork.flags |= PIRATE_FLAG_TURNING;
        }
        else
        {
            work->gameWork.objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
        }
    }

    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
}

void EnemyPirate_OnInit_BallChain(EnemyPirate *work)
{
    EnemyPirate_OnInit_Common(work);

    if (work->attack.ballChain.ball != NULL)
    {
        work->attack.ballChain.ball->stateBall = EnemyBallChainPirateBall_StateBall_InitSwing;
    }
    else
    {
        EnemyBallChainPirateBall *ball = (EnemyBallChainPirateBall *)EnemyPirate_SpawnProjectile(work);
        StageTask__SetParent(&ball->gameWork.objWork, &work->gameWork.objWork, STAGE_TASK_FLAG_IS_CHILD_OBJ);
        work->attack.ballChain.ball = ball;

        work->attack.ballChain.ball->gameWork.objWork.parentOffset.x = FLOAT_TO_FX32(0.0);
        ball->gameWork.objWork.parentOffset.y                        = -FLOAT_TO_FX32(77.0);
        EnemyPirate_InitBallChain(ball);
    }
}

void EnemyPirate_OnInit_Hover(EnemyPirate *work)
{
    GameObject__SetAnimation(&work->gameWork, work->move.common.aniMove);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, EnemyPirate_State_CommonHover);
    work->gameWork.objWork.userTimer = 0;
}

void EnemyPirate_State_CommonHover(EnemyPirate *work)
{
    EnemyPirate_State_CommonMove(work);

    work->gameWork.objWork.offset.y = MultiplyFX(work->move.common.hoverRadius, SinFX(work->move.common.hoverAngle));
    work->move.common.hoverAngle += FLOAT_DEG_TO_IDX(5.0);
}

void EnemyPirate_OnDetect_Common(EnemyPirate *work)
{
    work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);

    struct EnemyPirateAttackConfigCommon *attack = &work->attack.common;

    if (attack->duration != 0)
    {
        work->gameWork.objWork.userTimer = attack->duration;
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;

        SetTaskState(&work->gameWork.objWork, EnemyPirate_State_AttackDelay);
    }
    else
    {
        GameObject__SetAnimation(&work->gameWork, attack->anim);
        SetTaskState(&work->gameWork.objWork, attack->attackState);
    }
}

void EnemyPirate_State_AttackDelay(EnemyPirate *work)
{
    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer == 0)
    {
        work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_PAUSED;
        GameObject__SetAnimation(&work->gameWork, work->attack.common.anim);

        SetTaskState(&work->gameWork.objWork, work->attack.common.attackState);
    }
}

void EnemyPirate_State_AttackCooldown(EnemyPirate *work)
{
    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer == 0)
    {
        work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_PAUSED;
        work->onInit(work);
    }
}

void EnemyPirate_State_KnifeAttack(EnemyPirate *work)
{
    struct EnemyPirateAttackConfigCommon *attack = &work->attack.common;

    BOOL check = FALSE;
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        check = TRUE;

    if (check)
    {
        if (attack->cooldown != 0)
        {
            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.userTimer  = attack->cooldown;

            SetTaskState(&work->gameWork.objWork, EnemyPirate_State_AttackCooldown);
        }
        else
        {
            work->onInit(work);
        }
    }
}

void EnemyPirate_State_BazookaAttack(EnemyPirate *work)
{
    struct EnemyPirateAttackConfigCommon *attack = &work->attack.common;

    BOOL isDone = FALSE;

    if (work->gameWork.objWork.obj_2d->ani.work.animFrameIndex == attackFrameTable[work->type] && work->didAttack == FALSE)
    {
        EnemyPirate_SpawnProjectile(work);
        work->didAttack = TRUE;
    }

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        isDone          = TRUE;
        work->didAttack = FALSE;
    }

    if (isDone)
    {
        if (attack->cooldown != 0)
        {
            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.userTimer  = attack->cooldown;

            SetTaskState(&work->gameWork.objWork, EnemyPirate_State_AttackCooldown);
        }
        else
        {
            work->onInit(work);
        }
    }
}

void EnemyPirate_State_BallChainAttack(EnemyPirate *work)
{
    struct EnemyPirateAttackConfigBallChain *attack = &work->attack.ballChain;

    BOOL isDone = FALSE;

    if (work->gameWork.objWork.obj_2d->ani.work.animID == BALLCHAINPIRATE_ANI_ATTACK)
    {
        s32 id;
        switch (work->gameWork.objWork.obj_2d->ani.work.animFrameIndex)
        {
            case 1:
                id = 0;
                break;

            case 4:
                id = 1;
                break;

            case 5:
                id = 2;
                break;

            case 6:
                id = 3;
                break;

            case 7:
                id = 0;
                break;

            default:
                id = 4;
                break;
        }

        if (id != 4)
        {
            attack->ball->offset.x = ballOffsetTable[id].x;
            attack->ball->offset.y = ballOffsetTable[id].y;
        }
    }

    if (work->gameWork.objWork.obj_2d->ani.work.animFrameIndex == attackFrameTable[work->type] && work->didAttack == FALSE)
    {
        attack->ball->stateBall = EnemyBallChainPirateBall_StateBall_InitThrow;
        work->didAttack         = TRUE;
    }

    if (work->gameWork.objWork.obj_2d->ani.work.animFrameIndex == 6)
        attack->ball->stateBall = EnemyBallChainPirateBall_StateBall_InitRecall;

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        work->didAttack = FALSE;
        isDone          = TRUE;
    }

    if (isDone)
    {
        if (attack->cooldown != 0)
        {
            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
            work->gameWork.objWork.userTimer  = attack->cooldown;

            SetTaskState(&work->gameWork.objWork, EnemyPirate_State_AttackCooldown);
        }
        else
        {
            work->onInit(work);
        }
    }
}

GameObjectTask *EnemyPirate_SpawnProjectile(EnemyPirate *work)
{
    fx32 x;
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        x = work->gameWork.objWork.position.x - projectilePosTable[work->type].x;
    else
        x = work->gameWork.objWork.position.x + projectilePosTable[work->type].x;
    fx32 y = work->gameWork.objWork.position.y + projectilePosTable[work->type].y;

    s32 id;
    switch (work->type)
    {
        case PIRATE_TYPE_BAZOOKA:
            PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SHOT2);
            ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
            id = MAPOBJECT_342;
            break;

        case PIRATE_TYPE_BALLCHAIN:
            id = MAPOBJECT_343;
            break;

        case PIRATE_TYPE_BOMB:
            id = MAPOBJECT_344;
            break;

        case PIRATE_TYPE_SKELETON:
            id = MAPOBJECT_345;
            break;

        case PIRATE_TYPE_HOVERBOMBER:
            id = MAPOBJECT_346;
            break;

        case PIRATE_TYPE_HOVERGUNNER:
            id = MAPOBJECT_347;
            break;
    }

    GameObjectTask *shot = SpawnStageObject(id, x, y, GameObjectTask);

    shot->objWork.velocity.x = shot->objWork.velocity.y = FLOAT_TO_FX32(0.0);
    shot->objWork.groundVel                             = FLOAT_TO_FX32(0.0);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        shot->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
    else
        shot->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;

    return shot;
}

void EnemyBazookaPirateShot_State_Init(EnemyBazookaPirateShot *work)
{
    work->gameWork.objWork.groundVel = FLOAT_TO_FX32(3.0);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        work->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
    else
        work->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(180.0);

    SetTaskState(&work->gameWork.objWork, EnemyBazookaPirateShot_State_Active);
}

void EnemyBazookaPirateShot_State_Active(EnemyBazookaPirateShot *work)
{
    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY) != 0)
    {
        work->gameWork.objWork.flag |= DISPLAY_FLAG_DISABLE_LOOPING;

        CreateEffectExplosionHazard(&work->gameWork.objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), -17, -20, 14, 11, 7, EXPLOSION_SMALL);

        PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOMB);
        ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
    }
}

void EnemyBallChainPirateBall_StateBall_InitSwing(EnemyBallChainPirateBall *work)
{
    work->stateBall = EnemyBallChainPirateBall_StateBall_Swing;
    work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

    work->gameWork.objWork.velocity.x = work->gameWork.objWork.velocity.y = work->gameWork.objWork.velocity.z = FLOAT_TO_FX32(0.0);

    work->swingAngle = FLOAT_DEG_TO_IDX(0.0);

    if (work->gameWork.objWork.position.y <= work->gameWork.objWork.parentObj->position.y - FLOAT_TO_FX32(77.0))
    {
        work->stateBall = EnemyBallChainPirateBall_StateBall_Swing;
        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_IS_CHILD_OBJ;
        work->stateBall(work);
    }
    else
    {
        work->stateBall = EnemyBallChainPirateBall_StateBall_EmergencyRecall;
    }

    work->offset.x = FLOAT_TO_FX32(10.0);
    work->offset.y = -FLOAT_TO_FX32(61.0);
}

void EnemyBallChainPirateBall_StateBall_Swing(EnemyBallChainPirateBall *work)
{
    EnemyPirate *parent = (EnemyPirate *)work->gameWork.objWork.parentObj;

    work->swingAngle += FLOAT_DEG_TO_IDX(10.0);
    if (work->swingAngle > FLOAT_DEG_TO_IDX(10.0))
    {
        if (!work->playedSwingSfx)
        {
            PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_HAMMER);
            work->playedSwingSfx = TRUE;
        }
    }
    else
    {
        work->playedSwingSfx = FALSE;
    }

    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        work->gameWork.objWork.parentOffset.x = MultiplyFX(SinFX(work->swingAngle), FLOAT_TO_FX32(60.0));
    else
        work->gameWork.objWork.parentOffset.x = -MultiplyFX(SinFX(work->swingAngle), FLOAT_TO_FX32(60.0));

    if ((parent->gameWork.flags & PIRATE_FLAG_TURNING) != 0 && (parent->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        work->gameWork.objWork.parentOffset.x = -work->gameWork.objWork.parentOffset.x;

    work->gameWork.objWork.parentOffset.y = -FLOAT_TO_FX32(77.0);
}

void EnemyBallChainPirateBall_StateBall_EmergencyRecall(EnemyBallChainPirateBall *work)
{
    fx32 x, y;
    EnemyPirate *parent = (EnemyPirate *)work->gameWork.objWork.parentObj;

    x = parent->gameWork.objWork.position.x;
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        x -= FLOAT_TO_FX32(60.0);
    else
        x += FLOAT_TO_FX32(60.0);
    y = parent->gameWork.objWork.position.y - FLOAT_TO_FX32(77.0);

    work->gameWork.objWork.position.x = (s32)(x + MultiplyFX(FLOAT_TO_FX32(7.0), work->gameWork.objWork.position.x)) >> 3;
    work->gameWork.objWork.position.y = (s32)(y + MultiplyFX(FLOAT_TO_FX32(7.0), work->gameWork.objWork.position.y)) >> 3;

    if (MATH_ABS(work->gameWork.objWork.position.y - y) <= FLOAT_TO_FX32(5.0))
    {
        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_IS_CHILD_OBJ;

        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            work->swingAngle = FLOAT_DEG_TO_IDX(90.0);
        else
            work->swingAngle = -FLOAT_DEG_TO_IDX(90.0);

        work->stateBall = EnemyBallChainPirateBall_StateBall_Swing;
        work->stateBall(work);
    }
}

void EnemyBallChainPirateBall_StateBall_InitThrow(EnemyBallChainPirateBall *work)
{
    work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_IS_CHILD_OBJ;

    work->gameWork.objWork.parentOffset.x = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.parentOffset.y = FLOAT_TO_FX32(0.0);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        work->gameWork.objWork.position.x = work->gameWork.objWork.parentObj->position.x + FLOAT_TO_FX32(53.0);
    else
        work->gameWork.objWork.position.x = work->gameWork.objWork.parentObj->position.x - FLOAT_TO_FX32(53.0);
    work->gameWork.objWork.position.y = work->gameWork.objWork.parentObj->position.y - FLOAT_TO_FX32(57.0);

    StageTask__SetGravity(&work->gameWork.objWork, FLOAT_TO_FX32(0.08203125), FLOAT_TO_FX32(15.0));
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_20000000 | STAGE_TASK_MOVE_FLAG_4000;

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        work->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(15.0);
    else
        work->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(165.0);

    work->gameWork.objWork.velocity.x = work->gameWork.objWork.velocity.y = work->gameWork.objWork.velocity.z = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.groundVel                                                                          = FLOAT_TO_FX32(5.0);
    work->bounceCount                                                                                         = 0;

    PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_HAMMER);
    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

    work->stateBall = EnemyBallChainPirateBall_StateBall_Thrown;
}

void EnemyBallChainPirateBall_StateBall_Thrown(EnemyBallChainPirateBall *work)
{
    if (MATH_ABS(work->gameWork.objWork.parentObj->position.x - work->gameWork.objWork.position.x) >= FLOAT_TO_FX32(130.0))
    {
        if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        {
            work->gameWork.objWork.groundVel >>= 2;
            work->gameWork.objWork.position.x = work->gameWork.objWork.parentObj->position.x + FLOAT_TO_FX32(130.0);
            work->gameWork.objWork.dir.z      = -FLOAT_DEG_TO_IDX(180.0) - (s16)work->gameWork.objWork.dir.z;
        }
        else if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        {
            work->gameWork.objWork.groundVel >>= 2;
            work->gameWork.objWork.position.x = work->gameWork.objWork.parentObj->position.x - FLOAT_TO_FX32(130.0);
            work->gameWork.objWork.dir.z      = -FLOAT_DEG_TO_IDX(180.0) - (s16)work->gameWork.objWork.dir.z;
        }
    }

    if (work->bounceTimer != 0)
    {
        work->bounceTimer--;
    }
    else
    {
        if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY) != 0)
        {
            if (work->bounceCount >= 1)
            {
                work->gameWork.objWork.groundVel = FLOAT_TO_FX32(0.0);
                PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_THROW_HAMMER);
                work->stateBall = EnemyBallChainPirateBall_StateBall_ThrownIdle;
            }
            else
            {
                work->bounceCount++;
                work->bounceTimer = 5;
                work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_IN_AIR;
                PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_THROW_HAMMER);

                work->gameWork.objWork.velocity.x = work->gameWork.objWork.velocity.y = work->gameWork.objWork.velocity.z = FLOAT_TO_FX32(0.0);
                work->gameWork.objWork.groundVel >>= 2;

                if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    work->gameWork.objWork.dir.z = -FLOAT_DEG_TO_IDX(160.0048828125);
                else
                    work->gameWork.objWork.dir.z = -FLOAT_DEG_TO_IDX(20.0006103515625);
            }
        }

        ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
    }
}

void EnemyBallChainPirateBall_StateBall_ThrownIdle(EnemyBallChainPirateBall *work)
{
    EnemyPirate *parent = (EnemyPirate *)work->gameWork.objWork.parentObj;

    if ((parent->gameWork.flags & GAMEOBJECT_FLAG_ALLOW_RESPAWN) != 0)
        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_IS_CHILD_OBJ;
}

void EnemyBallChainPirateBall_StateBall_InitRecall(EnemyBallChainPirateBall *work)
{
    work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

    work->gameWork.objWork.velocity.x = work->gameWork.objWork.velocity.y = work->gameWork.objWork.velocity.z = FLOAT_TO_FX32(0.0);

    work->stateBall = EnemyBallChainPirateBall_StateBall_Recalling;
}

void EnemyBallChainPirateBall_StateBall_Recalling(EnemyBallChainPirateBall *work)
{
    fx32 x, y;
    EnemyPirate *parent = (EnemyPirate *)work->gameWork.objWork.parentObj;

    x = parent->gameWork.objWork.position.x;
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        x -= FLOAT_TO_FX32(60.0);
    else
        x += FLOAT_TO_FX32(60.0);
    y = parent->gameWork.objWork.position.y - FLOAT_TO_FX32(77.0);

    if (MATH_ABS(work->gameWork.objWork.position.y - y) > FLOAT_TO_FX32(5.0))
    {
        work->gameWork.objWork.position.x = (x + 7 * work->gameWork.objWork.position.x) >> 3;
        work->gameWork.objWork.position.y = (y + 7 * work->gameWork.objWork.position.y) >> 3;
    }
}

void EnemyBombPirateBomb_State_Init(EnemyBombPirateBomb *work)
{
    StageTask__SetGravity(&work->gameWork.objWork, FLOAT_TO_FX32(0.08203125), FLOAT_TO_FX32(15.0));

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_20000000 | STAGE_TASK_MOVE_FLAG_4000;

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        work->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(300.0);
    else
        work->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(240.0);

    work->gameWork.objWork.groundVel = FLOAT_TO_FX32(2.0);

    work->bounceCount = 0;

    PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_THROW_BARREL);
    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

    SetTaskState(&work->gameWork.objWork, EnemyBombPirateBomb_State_Active);
}

void EnemyBombPirateBomb_State_Active(EnemyBombPirateBomb *work)
{
    if (work->bounceTimer != 0)
    {
        work->bounceTimer--;
    }
    else
    {
        if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY) != 0)
        {
            if (work->bounceCount >= 3)
            {
                if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    work->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
                else
                    work->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(180.0);

                work->gameWork.objWork.groundVel = MATH_ABS(work->gameWork.objWork.move.x);
                work->gameWork.objWork.userTimer = 60;

                SetTaskState(&work->gameWork.objWork, EnemyBombPirateBomb_State_Explode);
            }
            else
            {
                work->bounceCount++;
                work->bounceTimer = 5;
                work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_IN_AIR;

                work->gameWork.objWork.velocity.x = work->gameWork.objWork.velocity.y = work->gameWork.objWork.velocity.z = FLOAT_TO_FX32(0.0);

                work->gameWork.objWork.groundVel -= work->gameWork.objWork.groundVel >> 3;
                if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    work->gameWork.objWork.dir.z = -FLOAT_DEG_TO_IDX(45.0);
                else
                    work->gameWork.objWork.dir.z = -FLOAT_DEG_TO_IDX(135.0);
            }
        }

        ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
    }
}

void EnemyBombPirateBomb_State_Explode(EnemyBombPirateBomb *work)
{
    if (work->gameWork.objWork.userTimer != 0)
        work->gameWork.objWork.userTimer--;

    if (work->gameWork.objWork.userTimer == 0)
    {
        DestroyStageTask(&work->gameWork.objWork);

        CreateEffectExplosionHazard(&work->gameWork.objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), -17, -20, 14, 11, 7, EXPLOSION_SMALL);
        PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOMB);
        ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
    }
}

void EnemySkeletonPirateBone_State_Init(EnemyBombPirateBomb *work)
{
    StageTask__SetGravity(&work->gameWork.objWork, FLOAT_TO_FX32(0.08203125), FLOAT_TO_FX32(15.0));
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_4000;

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        work->gameWork.objWork.dir.z = -FLOAT_DEG_TO_IDX(70.0048828125);
    else
        work->gameWork.objWork.dir.z = -FLOAT_DEG_TO_IDX(110.0006103515625);

    work->gameWork.objWork.groundVel = FLOAT_TO_FX32(3.0);

    // Bug Note #1: this writes into invalid memory!
    // This function was likely based on "EnemyBombPirateBomb_State_Init", and at some point they forgot to update the task type
    // meaning the compiler didn't pick up that this variable shouldn't exist!!
    work->bounceCount = 0;

    PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_PARABOLA);
    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

    SetTaskState(&work->gameWork.objWork, EnemySkeletonPirateBone_State_Active);
}

void EnemySkeletonPirateBone_State_Active(EnemySkeletonPirateBone *work)
{
    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY) != 0)
        DestroyStageTask(&work->gameWork.objWork);
}

void EnemyHoverBomberPirateBomb_State_Init(EnemyHoverBomberPirateBomb *work)
{
    StageTask__SetGravity(&work->gameWork.objWork, FLOAT_TO_FX32(0.08203125), FLOAT_TO_FX32(15.0));

    work->gameWork.objWork.dir.z     = FLOAT_DEG_TO_IDX(90.0);
    work->gameWork.objWork.groundVel = FLOAT_TO_FX32(3.0);

    SetTaskState(&work->gameWork.objWork, EnemyHoverBomberPirateBomb_State_Active);
}

void EnemyHoverBomberPirateBomb_State_Active(EnemyHoverBomberPirateBomb *work)
{
    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY) != 0)
    {
        DestroyStageTask(&work->gameWork.objWork);

        CreateEffectExplosionHazard(&work->gameWork.objWork, FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(16.0), -30, -28, 30, 28, 7, EXPLOSION_BIG);
        PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOMB);
        ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
    }
}

void EnemyHoverGunnerPirateShot_State_Init(EnemyHoverGunnerPirateShot *work)
{
    work->gameWork.objWork.groundVel = FLOAT_TO_FX32(3.0);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        work->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(45.0);
    else
        work->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(135.0);

    SetTaskState(&work->gameWork.objWork, EnemyHoverGunnerPirateShot_State_Active);
}

void EnemyHoverGunnerPirateShot_State_Active(EnemyHoverGunnerPirateShot *work)
{
    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY) != 0)
    {
        DestroyStageTask(&work->gameWork.objWork);

        CreateEffectExplosionHazard(&work->gameWork.objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), -17, -20, 14, 11, 7, EXPLOSION_SMALL);
        PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOMB);
        ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
    }
}

void EnemyBazookaPirateShot_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    EnemyBazookaPirateShot *shot = (EnemyBazookaPirateShot *)rect1->parent;
    UNUSED(rect2);

    DestroyStageTask(&shot->gameWork.objWork);

    CreateEffectExplosionHazard(&shot->gameWork.objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), -17, -20, 14, 11, 7, EXPLOSION_SMALL);

    PlayHandleStageSfx(shot->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOMB);
    ProcessSpatialSfx(shot->gameWork.objWork.sequencePlayerPtr, &shot->gameWork.objWork.position);
}

void EnemyBombPirateBomb_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    EnemyBombPirateBomb *bomb = (EnemyBombPirateBomb *)rect1->parent;
    UNUSED(rect2);

    DestroyStageTask(&bomb->gameWork.objWork);

    CreateEffectExplosionHazard(&bomb->gameWork.objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), -17, -20, 14, 11, 7, EXPLOSION_SMALL);

    PlayHandleStageSfx(bomb->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOMB);
    ProcessSpatialSfx(bomb->gameWork.objWork.sequencePlayerPtr, &bomb->gameWork.objWork.position);
}

void EnemySkeletonPirateBone_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    EnemySkeletonPirateBone *bone = (EnemySkeletonPirateBone *)rect1->parent;
    UNUSED(rect2);

    DestroyStageTask(&bone->gameWork.objWork);
}

void EnemyHoverBomberPirateBomb_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    EnemyHoverBomberPirateBomb *bomb = (EnemyHoverBomberPirateBomb *)rect1->parent;
    UNUSED(rect2);

    DestroyStageTask(&bomb->gameWork.objWork);

    CreateEffectExplosionHazard(&bomb->gameWork.objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), -30, -28, 30, 28, 7, EXPLOSION_BIG);

    PlayHandleStageSfx(bomb->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BOMB);
    ProcessSpatialSfx(bomb->gameWork.objWork.sequencePlayerPtr, &bomb->gameWork.objWork.position);
}

void EnemyPirate_OnDefend_DetectCommon(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Player *player      = (Player *)rect1->parent;
    EnemyPirate *pirate = (EnemyPirate *)rect2->parent;

    if ((pirate->gameWork.objWork.flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) != 0)
        return;

    CreateEffectFound(&pirate->gameWork.objWork, foundPosTable[pirate->type].x, foundPosTable[pirate->type].y);
    pirate->detectPlayerPos.x = player->objWork.position.x;
    pirate->detectPlayerPos.y = player->objWork.position.y;
    pirate->colliderDetect.flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
    pirate->colliderActivateTimer = colliderActivateDelay[pirate->type];
    pirate->onDetect(pirate);
}

void EnemyPirate_OnDefend_DetectHoverGunner(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Player *player      = (Player *)rect1->parent;
    EnemyPirate *pirate = (EnemyPirate *)rect2->parent;

    if ((pirate->gameWork.objWork.flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) != 0)
        return;

    u16 angle = FX_Atan2Idx(player->objWork.position.y - pirate->gameWork.objWork.position.y, player->objWork.position.x - pirate->gameWork.objWork.position.x);

    if ((pirate->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
    {
        if (angle < FLOAT_DEG_TO_IDX(30.0) || angle > FLOAT_DEG_TO_IDX(60.0))
            return;
    }
    else
    {
        if (angle < FLOAT_DEG_TO_IDX(120.0) || angle > FLOAT_DEG_TO_IDX(150.0))
            return;
    }

    CreateEffectFound(&pirate->gameWork.objWork, foundPosTable[pirate->type].x, foundPosTable[pirate->type].y);
    pirate->detectPlayerPos.x = player->objWork.position.x;
    pirate->detectPlayerPos.y = player->objWork.position.y;
    pirate->colliderDetect.flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
    pirate->colliderActivateTimer = colliderActivateDelay[pirate->type];
    pirate->onDetect(pirate);
}
