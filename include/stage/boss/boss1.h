#ifndef RUSH_BOSS1_H
#define RUSH_BOSS1_H

#include <stage/gameObject.h>
#include <game/graphics/paletteAnimation.h>
#include <game/stage/bossHelpers.h>
#include <stage/boss/bossFX.h>

// --------------------
// CONSTANTS
// --------------------

#define BOSS1_HIT_COMBO_MAX 5

#define BOSS1_DEACTIVATE_TIME   SECONDS_TO_FRAMES(10.0)
#define BOSS1_REACTIVATE_HEALTH (HUD_BOSS_HEALTH_MAX * 0.25)

// --------------------
// TYPES
// --------------------

typedef struct Boss1Stage_ Boss1Stage;
typedef struct Boss1_ Boss1;

// --------------------
// ENUMS
// --------------------

enum Boss1Phase_
{
    BOSS1_PHASE_1,
    BOSS1_PHASE_2,
    BOSS1_PHASE_3,
    BOSS1_PHASE_4,

    BOSS1_PHASE_COUNT,
};
typedef u16 Boss1Phase;

enum Boss1StageMesh
{
    BOSS1STAGE_MESH_STAGE_1,
    BOSS1STAGE_MESH_STAGE_2,
    BOSS1STAGE_MESH_SURFACE_FOREST,
    BOSS1STAGE_MESH_DROP_HOLE,
    BOSS1STAGE_MESH_CAVE,

    BOSS1STAGE_MESH_COUNT,
};

enum Boss1StagePart_
{
    BOSS1STAGE_PART_STAGE_1,
    BOSS1STAGE_PART_STAGE_2,
    BOSS1STAGE_PART_DROP_HOLE_1,
    BOSS1STAGE_PART_DROP_HOLE_2,
    BOSS1STAGE_PART_CAVE,

    BOSS1STAGE_PART_COUNT,
};
typedef u32 Boss1StagePart;

enum Boss1Action_
{
    BOSS1_ACTION_INIT,
    BOSS1_ACTION_IDLE,
    BOSS1_ACTION_BITE,
    BOSS1_ACTION_CHARGE,
    BOSS1_ACTION_HEADSLAM,
    BOSS1_ACTION_DAMAGE,
    BOSS1_ACTION_CHARGE_DAMAGE,
    BOSS1_ACTION_JUMP,
    BOSS1_ACTION_DROP,
    BOSS1_ACTION_DEACTIVATE,
    BOSS1_ACTION_CHARGE_DEACTIVATE,
    BOSS1_ACTION_DESTROY,
};
typedef u32 Boss1Action;

// --------------------
// STRUCTS
// --------------------

typedef struct Boss1AttackConfig_
{
    s32 *attackTable;
    u16 id;
    Boss1Phase phase;
} Boss1AttackConfig;

typedef struct Boss1BiteConfig_
{
    u16 duration1;
    u16 duration2;
    u16 duration3;
    u16 bite3Duration;
    fx32 animSpeed;
} Boss1BiteConfig;

typedef struct Boss1ChargeConfig_
{
    u16 duration;
    fx32 accel;
    fx32 topSpeed;
} Boss1ChargeConfig;

typedef struct Boss1HeadSlamConfig_
{
    u16 duration1;
    u16 duration2;
    u16 duration3;
    u16 idleDuration;
    fx32 animSpeed;
} Boss1HeadSlamConfig;

typedef struct Boss1StageDropControl_
{
    s32 state;
    s32 field_4;
    fx32 moveOffsetY;
    fx32 moveVelocity;
    s32 field_10;
    s32 field_14;
    Boss1StagePart meshParts[7];
    OBS_ACTION3D_NN_WORK aniStage[BOSS1STAGE_MESH_COUNT];
} Boss1StageDropControl;

typedef struct Boss1Unknown_
{
    fx32 unknown1;
    fx32 unknown2;
    s32 field_6A0;
} Boss1Unknown;

struct Boss1Stage_
{
    GameObjectTask gameWork;
    void *background;
    Boss1 *boss;
    void (*stageState)(Boss1Stage *work);
    u32 field_370;
    s16 health;
    u16 hitCount;
    u32 field_378;
    u32 field_37C;
    BossLight lightConfig;
    Boss1StageDropControl dropControl;
};

struct Boss1_
{
    GameObjectTask gameWork;
    void *background;
    Boss1Stage *stage;

    union
    {
        struct Boss1ActionIdle
        {
            u16 duration;
            u16 timer;
        } idle;

        struct Boss1ActionBite
        {
            s32 type;
            const Boss1BiteConfig *config;
            u16 unknownTimer;
            u16 timer;
            u16 direction;
            BOOL didCollide;
            s32 field_14;
            BOOL playedSfx;
            BOOL createdFX;
            s32 field_20;
            u16 bite3Timer;
        } bite;

        struct Boss1ActionCharge
        {
            const Boss1ChargeConfig *config;
            u16 timer;
            s32 direction;
            s32 field_C;
            VecFx32 startPos;
            VecFx32 endPos;
            u16 startAngle;
            u16 endAngle;
            s16 lerpPercent;
            u8 field_2E;
            u8 field_2F;
            s32 field_30;
            u8 field_34;
            u8 field_35;
            u8 field_36;
            u8 field_37;
        } charge;

        struct Boss1ActionHeadSlam
        {
            const Boss1HeadSlamConfig *config;
            u16 unknownTimer;
            u16 timer;
            BOOL finished;
            u16 idleTimer;
        } headSlam;

        struct Boss1ActionDamage
        {
            s32 type;
            u16 duration;
            u16 field_6;
            u16 timer;
        } damage;

        struct Boss1ActionChargeDamage
        {
            u16 duration;
            u16 timer;
        } chargeDamage;

        struct Boss1ActionJump
        {
            s32 field_0;
            VecFx32 startPos;
            VecFx32 endPos;
            u16 startAngle;
            u16 endAngle;
            s16 lerpPercent;
        } jump;

        struct Boss1ActionDrop
        {
            s16 lerpPercent;
            u16 smokeFXTimer;
            u16 timer;
        } drop;

        struct Boss1ActionDeactivate
        {
            u16 timer;
        } deactivate;

        struct Boss1ActionChargeDeactivate
        {
            s32 direction;
            u16 timer;
        } chargeDeactivate;

        struct Boss1ActionDestroyed
        {
            u16 brightnessTimer;
            u16 lightDimTimer;
            u16 unknown;
            u16 fadeOutTimer;
            u16 timer;
        } destroyed;
    } action;

    void (*bossState)(Boss1 *work);
    Boss1Action actionType;
    Boss1AttackConfig attackConfig;
    OBS_RECT_WORK bossColliders[10];
    FXMatrix43 mtxWeakPoint;
    FXMatrix43 mtxBodyNeck;
    s32 field_694;
    Boss1Unknown field_698;
    BOOL changedBossPhase;
    u32 field_6A8;
    s32 field_6AC;
    s32 field_6B0;
    s32 field_6B4;
    s32 field_6B8;
    u16 angle;
    u16 field_6BE;
    BOOL longNeckActive;
    u16 neckMtxLerpPercent;
    u16 paletteFlashTimer;
    s32 field_6C8;
    s32 field_6CC;
    PaletteAnimator aniPalette[24];
    OBS_ACTION3D_NN_WORK aniBossMain;
    s32 animID;
    OBS_ACTION3D_NN_WORK aniBossSub1;
    OBS_ACTION3D_NN_WORK aniBossSub2;
    s32 field_E48;
    NNSSndHandle *sndHandle[3];
};

// --------------------
// FUNCTIONS
// --------------------

Boss1Stage *Boss1Stage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);
Boss1 *Boss1__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type);

#endif // RUSH_BOSS1_H