#ifndef RUSH_BOSS2_H
#define RUSH_BOSS2_H

#include <stage/gameObject.h>
#include <game/graphics/paletteAnimation.h>
#include <game/stage/bossHelpers.h>
#include <stage/boss/bossFX.h>

// --------------------
// CONSTANTS
// --------------------

#define BOSS2_STAGE_START  0x40000  // FLOAT_TO_FX32(64.0)
#define BOSS2_STAGE_END    0x722543 // FLOAT_TO_FX32(1826.32886)
#define BOSS2_STAGE_RADIUS 0x1187BC // FLOAT_TO_FX32(280.4834)

#define BOSS2_DEACTIVATE_TIME   SECONDS_TO_FRAMES(10.0)
#define BOSS2_REACTIVATE_HEALTH (HUD_BOSS_HEALTH_MAX * 0.3125)

// --------------------
// ENUMS
// --------------------

enum Boss2Phase_
{
    BOSS2_PHASE_1,
    BOSS2_PHASE_2,
    BOSS2_PHASE_3,
    BOSS2_PHASE_4,

    BOSS2_PHASE_COUNT,
};
typedef u16 Boss2Phase;

enum Boss2BallType_
{
    BOSS2_BALL_S, // Blue/Small
    BOSS2_BALL_M, // Yellow/Medium
    BOSS2_BALL_L, // Red/Large

    BOSS2_BALL_COUNT,
};
typedef u32 Boss2BallType;

enum Boss2Action_
{
    BOSS2_ACTION_INIT,
    BOSS2_ACTION_IDLE,
    BOSS2_ACTION_HIT,
    BOSS2_ACTION_DEACTIVATE,
    BOSS2_ACTION_DESTROYED,
};
typedef u32 Boss2Action;

enum Boss2ArmAction_
{
    BOSS2ARM_ACTION_INACTIVE,
    BOSS2ARM_ACTION_APPEAR,
    BOSS2ARM_ACTION_FETCH_BALL,
    BOSS2ARM_ACTION_ATTACH,
    BOSS2ARM_ACTION_DETATTACH,
};
typedef u32 Boss2ArmAction;

enum Boss2BallAction_
{
    BOSS2BALL_ACTION_INACTIVE,
    BOSS2BALL_ACTION_IDLE,
    BOSS2BALL_ACTION_HIT,
    BOSS2BALL_ACTION_HIT_RECOIL,
};
typedef u32 Boss2BallAction;

enum Boss2BallSpikesAction_
{
    BOSS2BALLSPIKES_ACTION_INACTIVE,
    BOSS2BALLSPIKES_ACTION_EXTENDED,
    BOSS2BALLSPIKES_ACTION_RETRACTING,
    BOSS2BALLSPIKES_ACTION_RETRACTED,
    BOSS2BALLSPIKES_ACTION_EXTENDING,
};
typedef u32 Boss2BallSpikesAction;

enum Boss2DropAction_
{
    BOSS2DROP_ACTION_ATTACHED,
    BOSS2DROP_ACTION_DROP,
};
typedef u32 Boss2DropAction;

enum Boss2BombAction_
{
    BOSS2BOMB_ACTION_FALL,
    BOSS2BOMB_ACTION_MOVING, // Unused. based on how actionStates are usually assigned, it's likely this.
    BOSS2BOMB_ACTION_DESTROY,
};
typedef u32 Boss2BombAction;

enum Boss2BallDirection_
{
    BOSS2BALL_DIR_BACKWARD,
    BOSS2BALL_DIR_FORWARD,
};
typedef s32 Boss2BallDirection;

// --------------------
// STRUCTS
// --------------------

typedef struct Boss2Assets_
{
    void *background;
    void *jointAnims;
    void *visAnims;
} Boss2Assets;

typedef struct Boss2Stage_
{
    GameObjectTask gameWork;

    Boss2Assets assets;
    struct Boss2_ *boss;
    struct Boss2Arm_ *arms[BOSS2_BALL_COUNT];
    struct Boss2Drop_ *drop;
    struct Boss2Ball_ *balls[BOSS2_BALL_COUNT];
    struct Boss2Bomb_ *bomb;
    void (*stageState)(struct Boss2Stage_ *work);
    s16 health;
    u32 groundHeight;
    BossLight lightConfig;
    BOOL hasCameraOverride;
    AnimatorMDL aniStage[2];
} Boss2Stage;

typedef struct Boss2_
{
    GameObjectTask gameWork;

    Boss2Assets assets;
    Boss2Stage *stage;

    union
    {
        struct Boss2ActionAttack3
        {
            fx32 radius;
        } attack3;

        struct Boss2ActionDestroyed
        {
            u16 brightnessTimer;
            u16 lightDimTimer;
            u16 unknown;
            u16 fadeOutTimer;
            u16 timer;
        } destroyed;
    } action;

    void (*bossState)(struct Boss2_ *work);
    Boss2Action actionState;
    OBS_RECT_WORK worldCollider;
    u16 dropActionTimer;
    u16 bombSpawnTimer;
    u16 angle;
    BOOL tryLookAtPlayer;
    FXMatrix43 mtxBody[BOSS2_BALL_COUNT];
    FXMatrix43 mtxWeakPoint;
    s32 activeArmCount;
    fx32 bodyMiddlePos;
    fx32 bodyBottomPos;
    BOOL prevCanDraw;
    PaletteAnimator aniPalette[8];
    AnimatorMDL aniBody;
} Boss2;

typedef struct Boss2Arm_
{
    GameObjectTask gameWork;
    Boss2Assets assets;
    Boss2Stage *stage;
    fx32 radius;
    s32 unused;
    void (*armState)(struct Boss2Arm_ *work);
    Boss2ArmAction actionState;
    Boss2BallType type;
    FXMatrix43 mtxArmBall;
    BOOL isAttached;
    BOOL isRotating;
    u16 angle;
    s16 angleVelocity;
    s16 targetAngleVelocity;
    s16 maxAngleVelocity;
    BOOL prevCanDraw;
    AnimatorMDL animator;
} Boss2Arm;

typedef struct Boss2BallSpikeWorker_
{
    void (*spikeState)(struct Boss2Ball_ *work, struct Boss2BallSpikeWorker_ *worker);
    Boss2BallSpikesAction actionState;
    BOOL disableSpikes;
    u16 spikeDuration;
    u16 vulnerableDuration;
    u32 timer;
    AnimatorMDL aniSpike;
} Boss2BallSpikeWorker;

typedef struct Boss2Ball_
{
    GameObjectTask gameWork;
    Boss2Assets assets;
    Boss2Stage *stage;
    void (*ballState)(struct Boss2Ball_ *work);
    Boss2BallAction actionState;
    Boss2BallType type;
    Boss2BallSpikeWorker spikeWorker;
    FXMatrix43 mtxBallCenter;
    OBS_RECT_WORK worldCollider[2];
    u16 invincibleTimer;
    Boss2BallDirection direction;
    fx32 hitImpactForce;
    fx32 hitVelocity;
    PaletteAnimator aniPalette[1];
    AnimatorMDL aniBall;
    AnimatorMDL aniBallD;
    AnimatorMDL aniBallM;
    NNSSndHandle *sndHandle;
} Boss2Ball;

typedef struct Boss2Drop_
{
    GameObjectTask gameWork;
    Boss2Assets assets;
    Boss2Stage *stage;
    void (*dropState)(struct Boss2Drop_ *work);
    Boss2DropAction actionState;
    BOOL isAttached;
    BOOL playedSteamSfx;
    AnimatorMDL aniDrop;
    BossFX3D *pendulumFallFX;
} Boss2Drop;

typedef struct Boss2Bomb_
{
    GameObjectTask gameWork;

    Boss2Assets assets;
    Boss2Stage *stage;
    void (*bombState)(struct Boss2Bomb_ *work);
    Boss2BombAction actionState;
    s32 timer;
    BOOL disableBossStageWrap;
    fx32 moveSpeed;
    s16 angle;
    fx32 radius;
    OBS_RECT_WORK worldCollider;
    AnimatorMDL aniBomb;
} Boss2Bomb;

typedef struct Boss2Wave_
{
    GameObjectTask gameWork;
    AnimatorMDL aniWave;
} Boss2Wave;

// --------------------
// FUNCTIONS
// --------------------

Boss2Stage *CreateBoss2Stage(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss2 *CreateBoss2(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss2Arm *CreateBoss2Arm(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss2Drop *CreateBoss2Drop(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss2Ball *CreateBoss2Ball(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss2Bomb *CreateBoss2Bomb(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss2Wave *CreateBoss2Wave(MapObject *mapObject, fx32 x, fx32 y, s32 type);

#endif // RUSH_BOSS2_H