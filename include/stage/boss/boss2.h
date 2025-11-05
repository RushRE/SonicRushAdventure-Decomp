#ifndef RUSH_BOSS2_H
#define RUSH_BOSS2_H

#include <stage/gameObject.h>
#include <game/graphics/paletteAnimation.h>
#include <game/stage/bossHelpers.h>
#include <stage/boss/bossFX.h>

// --------------------
// CONSTANTS
// --------------------

#define BOSS2_STAGE_START 0x40000
#define BOSS2_STAGE_END 0x722543
#define BOSS2_STAGE_RADIUS 0x1187BC

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
    BOSS2_BALL_M,
    BOSS2_BALL_S,
    BOSS2_BALL_L,

    BOSS2_BALL_COUNT,
};
typedef s32 Boss2BallType;

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
    void (*state2)(struct Boss2Stage_ *work);
    s16 health;
    u32 dword39C;
    BossLight lightConfig;
    s32 field_3D4;
    AnimatorMDL aniStage[2];
} Boss2Stage;

typedef struct Boss2_
{
    GameObjectTask gameWork;

    Boss2Assets assets;
    Boss2Stage *stage;


    union
    {
        struct Boss2ActionAttack1
        {
            u8 data[12];
        } attack1;
        struct Boss2ActionAttack2
        {
            u8 data[12];
        } attack2;
        struct Boss2ActionAttack3
        {
            fx32 value;
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

    void (*state2)(struct Boss2_ *work);
    s32 attackType;
    OBS_RECT_WORK field_388;
    u16 field_3C8;
    u16 field_3CA;
    u16 angle;
    s16 field_3CE;
    s32 field_3D0;
    FXMatrix43 mtxBody[BOSS2_BALL_COUNT];
    FXMatrix43 mtxWeakPoint;
    s32 activeArmCount;
    fx32 bodyHeightA;
    fx32 bodyHeightB;
    s32 field_4A0;
    PaletteAnimator aniPalette[8];
    AnimatorMDL aniBody;
} Boss2;

typedef struct Boss2Bomb_
{
    GameObjectTask gameWork;

    Boss2Assets assets;
    Boss2Stage *stage;
    void (*state2)(struct Boss2Bomb_ *work);
    s32 field_378;
    s32 timer;
    BOOL field_380;
    fx32 moveSpeed;
    s16 field_388;
    s16 field_38A;
    s32 field_38C;
    OBS_RECT_WORK field_390;
    AnimatorMDL aniBomb;
} Boss2Bomb;

typedef struct Boss2Arm_
{
    GameObjectTask gameWork;
    Boss2Assets assets;
    Boss2Stage *stage;
    s32 field_374;
    s32 field_378;
    void (*state2)(struct Boss2Arm_ *work);
    s32 field_380;
    u32 type;
    FXMatrix43 mtxArmBall;
    s32 field_3B8;
    s32 field_3BC;
    u16 angle;
    s16 angleSpeed;
    s16 targetAngleSpeed;
    s16 word3C6;
    s32 field_3C8;
    AnimatorMDL animator;
} Boss2Arm;

typedef struct Boss2BallSpikeWorker_
{
    void (*state3)(struct Boss2Ball_ *work, struct Boss2BallSpikeWorker_ *worker);
    u32 type;
    BOOL disableSpikes;
    u16 spikeDuration;
    u16 vulnerableDuration;
    s32 timer;
    AnimatorMDL aniSpike;
} Boss2BallSpikeWorker;

typedef struct Boss2Ball_
{
    GameObjectTask gameWork;
    Boss2Assets assets;
    Boss2Stage *stage;
    void (*state2)(struct Boss2Ball_ *work);
    s32 field_378;
    u32 type;
    Boss2BallSpikeWorker spikeWorker;
    FXMatrix43 mtxBallCenter;
    OBS_RECT_WORK field_188[2];
    u16 field_208;
    s16 field_20A;
    s32 field_20C;
    s32 angleAccel;
    s32 targetAngleAccel;
    PaletteAnimator aniPalette;
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
    void (*state2)(struct Boss2Drop_ *work);
    s32 field_378;
    s32 field_37C;
    BOOL playedSteamSfx;
    AnimatorMDL aniDrop;
    BossFX3D *pendulumFallFX;
} Boss2Drop;

typedef struct Boss2Wave_
{
    GameObjectTask gameWork;
    AnimatorMDL aniWave;
} Boss2Wave;

// --------------------
// FUNCTIONS
// --------------------

Boss2Stage *Boss2Stage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss2 *Boss2__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss2Arm *Boss2Arm__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss2Drop *Boss2Drop__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss2Ball *Boss2Ball__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss2Bomb *Boss2Bomb__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss2Wave *Boss2Wave__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

void Boss2__DrawPlayer(void);
void Boss2__LoadAssets(Boss2Assets* assets);
Boss2Phase Boss2__GetBossPhase(Boss2Stage *work);
fx32 Boss2Stage__GetBaseDamageValue(Boss2Stage *work, s32 ballType);
fx32 Boss2Stage__GetDamageModifier(Boss2Stage *work, s32 ballType);
u16 Boss2Stage__GetImpactDamage(Boss2Stage *work, s32 ballType);
fx32 Boss2__GetHitFXScale(Boss2Stage *work, s32 ballType);
s16 Boss2__GetBallSpinSpeed(Boss2Stage *work, s32 ballType);
fx16 Boss2Stage__GetBallWeight(Boss2Stage *work, s32 ballType);
void Boss2Stage__GetBallConfig(Boss2Stage *work, s32 ballType, u16 *spikeDuration, u16 *vulnerableDuration);
u16 Boss2__Func_215C104(Boss2Stage *work);
u16 Boss2__Func_215C19C(Boss2Stage *work);
void Boss2__Func_215C240(Boss2Stage *work);
void Boss2Stage__Func_215C2CC(Boss2Stage *work);
void Boss2Stage__Func_215C5F8(Boss2Stage *work, VecFx32 *target0, VecFx32 *target1, VecFx32 *up);
void Boss2Stage__Func_215C66C(Boss2Stage *work, VecFx32 *target0, VecFx32 *target1, VecFx32 *up);
u16 Boss2Stage__Func_215C6E0(Boss2Stage *work, Boss2Ball **balls);
void Boss2Stage__HandleBossCamera(Boss2Stage *work);

void Boss2Stage__State_Active(Boss2Stage* work);
void Boss2Stage__Destructor(Task *task);
void Boss2Stage__Draw(void);
void Boss2__Collide(void);
void Boss2__OnDefend(OBS_RECT_WORK* rect1, OBS_RECT_WORK* rect2);
void Boss2Stage__State2_215C938(Boss2Stage* work);
void Boss2Stage__State2_215CD08(Boss2Stage* work);
void Boss2Stage__State2_215CE88(Boss2Stage* work);

void Boss2__State_Active(Boss2* work);
void Boss2__Destructor(Task *task);
void Boss2__Draw(void);
BOOL Boss2__Func_215D168(Boss2* work);
void Boss2__BodyACallback(NNSG3dRS *context, void *userData);
void Boss2__BodyBCallback(NNSG3dRS *context, void *userData);
void Boss2__SetupObject(Boss2* work);
void Boss2__Action_Attack1(Boss2* work);
void Boss2__Action_Attack2(Boss2* work);
void Boss2__Action_Attack3(Boss2* work);
void Boss2__Action_Die(Boss2* work);
void Boss2__State2_215D2E4(Boss2* work);
void Boss2__State2_215D2F0(Boss2* work);
void Boss2__State2_215D334(Boss2* work);
void Boss2__State2_215D4DC(Boss2* work);
void Boss2__State2_215D4EC(Boss2* work);
void Boss2__State2_215D544(Boss2* work);
void Boss2__State2_215D560(Boss2* work);
void Boss2__State2_215D5A0(Boss2* work);
void Boss2__State2_215D5DC(Boss2* work);
void Boss2__State2_215D5F4(Boss2* work);
void Boss2__State2_215D64C(Boss2* work);
void Boss2__State2_215D668(Boss2* work);
void Boss2__State2_215D6A8(Boss2* work);
void Boss2__State2_215D6CC(Boss2* work);
void Boss2__State2_215D71C(Boss2* work);
void Boss2__State2_215D790(Boss2* work);
void Boss2__State2_215D824(Boss2* work);
void Boss2__State2_215D840(Boss2* work);
void Boss2__State2_215D88C(Boss2* work);
void Boss2__State2_215D8A8(Boss2* work);
void Boss2__State2_215D914(Boss2* work);
void Boss2__State2_215D970(Boss2* work);
void Boss2__State2_215D9BC(Boss2* work);
void Boss2__State2_215DA44(Boss2* work);
void Boss2__State2_215DAB8(Boss2* work);

void Boss2__State2_215DAD4(Boss2* work);
void Boss2__State2_215DC20(Boss2* work);
void Boss2__State2_215DDD8(Boss2* work);
void Boss2__State2_215DE40(Boss2* work);
void Boss2__State2_215DF78(Boss2* work);
void Boss2__State2_215E050(Boss2* work);
void Boss2__State2_ShowResultsScreen(Boss2* work);

void Boss2Drop__State_Active(Boss2Drop *work);
void Boss2Drop__Destructor(Task *task);
void Boss2Drop__Draw(void);
void Boss2Drop__SetupObject(Boss2Drop *work);
void Boss2Drop__Func_215E208(Boss2Drop *work);
void Boss2Drop__State_Init(Boss2Drop *work);
void Boss2Drop__State_Attached(Boss2Drop *work);
void Boss2Drop__State2_215E3F4(Boss2Drop *work);
void Boss2Drop__State2_215E40C(Boss2Drop *work);
void Boss2Drop__State2_215E46C(Boss2Drop *work);
void Boss2Drop__State2_215E4CC(Boss2Drop *work);
void Boss2Drop__State2_215E564(Boss2Drop *work);
void Boss2Drop__State2_215E604(Boss2Drop *work);
void Boss2Drop__State2_215E6D8(Boss2Drop *work);
void Boss2Drop__State2_215E718(Boss2Drop *work);
void Boss2Drop__State2_215E754(Boss2Drop *work);
void Boss2Drop__State2_215E770(Boss2Drop *work);
void Boss2Drop__State2_215E7D8(Boss2Drop *work);
void Boss2Drop__State2_215E87C(Boss2Drop *work);
void Boss2Drop__State2_215E8C0(Boss2Drop *work);

void Boss2Arm__State_Active(Boss2Arm *work);
void Boss2Arm__Destructor(Task *task);
void Boss2Arm__Draw(void);
BOOL Boss2Arm__CheckCanDraw(Boss2Arm *work);
void Boss2Arm__SetupObject(Boss2Arm *work);
void Boss2Arm__Action_215EBC0(Boss2Arm *work);
void Boss2Arm__Func_215EBD8(Boss2Arm *work);
void Boss2Arm__Func_215EBF0(Boss2Arm *work, u16 angle, s16 angleSpeed);
void Boss2Arm__Func_215EC24(Boss2Arm *work);
void Boss2Arm__State2_215EC44(Boss2Arm *work);
void Boss2Arm__State2_215EC5C(Boss2Arm *work);
void Boss2Arm__State2_215ECD8(Boss2Arm *work);
void Boss2Arm__State2_215EDE4(Boss2Arm *work);
void Boss2Arm__State2_215EF50(Boss2Arm *work);
void Boss2Arm__State2_215F08C(Boss2Arm *work);
void Boss2Arm__State2_215F128(Boss2Arm *work);
void Boss2Arm__State2_215F204(Boss2Arm *work);
void Boss2Arm__State2_215F254(Boss2Arm *work);
void Boss2Arm__State2_215F258(Boss2Arm *work);
void Boss2Arm__State2_215F2C8(Boss2Arm *work);

void Boss2Ball__State_Active(Boss2Ball* work);
void Boss2Ball__Destructor(Task *task);
void Boss2Ball__Draw(void);
void Boss2Ball__Func_215F490(Boss2Ball *work);
void Boss2Ball__Collide(void);
void Boss2Ball__OnDefend(OBS_RECT_WORK* rect1, OBS_RECT_WORK* rect2);
void Boss2Ball__Func_215F890(Boss2Ball* work);
void Boss2Ball__SetupObject(Boss2Ball* work);
void Boss2Ball__Func_215F944(Boss2Ball* work);
void Boss2Ball__Action_Hit(Boss2Ball *work, s32 direction, fx32 force);
void Boss2Ball__Action_HitRecoil(Boss2Ball* work);
void Boss2Ball__State_215FAE0(Boss2Ball* work);
void Boss2Ball__State2_215FB14(Boss2Ball* work);
void Boss2Ball__State2_215FB78(Boss2Ball* work);
void Boss2Ball__State2_InitHit(Boss2Ball* work);
void Boss2Ball__State2_Hit(Boss2Ball* work);
void Boss2Ball__State2_215FF00(Boss2Ball* work);
void Boss2Ball__State2_215FFFC(Boss2Ball* work);
void Boss2Ball__EnableSpikes(Boss2BallSpikeWorker* worker);
void Boss2Ball__DisableSpikes(Boss2BallSpikeWorker* worker);
void Boss2Ball__Func_216009C(Boss2BallSpikeWorker* worker);
void Boss2Ball__Func_21600AC(Boss2BallSpikeWorker* worker);
void Boss2Ball__StateSpikes_21600BC(Boss2Ball* work, Boss2BallSpikeWorker* worker);
void Boss2Ball__StateSpikes_Blank(Boss2Ball* work, Boss2BallSpikeWorker* worker);
void Boss2Ball__StateSpikes_2160174(Boss2Ball* work, Boss2BallSpikeWorker* worker);
void Boss2Ball__StateSpikes_2160268(Boss2Ball* work, Boss2BallSpikeWorker* worker);
void Boss2Ball__StateSpikes_21602A4(Boss2Ball* work, Boss2BallSpikeWorker* worker);
void Boss2Ball__StateSpikes_2160354(Boss2Ball* work, Boss2BallSpikeWorker* worker);
void Boss2Ball__StateSpikes_2160420(Boss2Ball* work, Boss2BallSpikeWorker* worker);
void Boss2Ball__StateSpikes_216045C(Boss2Ball* work, Boss2BallSpikeWorker* worker);
void Boss2Ball__StateSpikes_216050C(Boss2Ball* work, Boss2BallSpikeWorker* worker);

Boss2Bomb* Boss2Bomb__Spawn(Boss2Stage *work, fx32 moveSpeed, BOOL flipped);
void Boss2Bomb__State_Active(Boss2Bomb* work);
void Boss2Bomb__Destructor(Task *task);
void Boss2Bomb__Draw(void);
void Boss2Bomb__Collide(void);
void Boss2Bomb__OnDefend_21606DC(OBS_RECT_WORK* rect1, OBS_RECT_WORK* rect2);
void Boss2Bomb__SetupObject(Boss2Bomb* work);
void Boss2Bomb__Func_216073C(Boss2Bomb* work);
void Boss2Bomb__State2_216075C(Boss2Bomb* work);
void Boss2Bomb__State2_2160774(Boss2Bomb* work);
void Boss2Bomb__State2_216078C(Boss2Bomb* work);
void Boss2Bomb__State2_21607AC(Boss2Bomb* work);
void Boss2Bomb__State2_21607C8(Boss2Bomb* work);
void Boss2Bomb__State2_EnterArena(Boss2Bomb* work);
void Boss2Bomb__State2_StartMoving(Boss2Bomb* work);
void Boss2Bomb__State2_Moving(Boss2Bomb* work);
void Boss2Bomb__State2_2160938(Boss2Bomb* work);
void Boss2Bomb__State2_21609A8(Boss2Bomb* work);

void Boss2Wave__State_Active(Boss2Wave* work);
void Boss2Wave__Destructor(Task *task);
void Boss2Wave__Draw(void);

#endif // RUSH_BOSS2_H