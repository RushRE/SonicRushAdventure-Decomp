#ifndef RUSH_HUD_H
#define RUSH_HUD_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/vramSystem.h>
#include <stage/player/player.h>

// --------------------
// CONSTANTS
// --------------------

#define HUD_BOSS_HEALTH_MIN 0x000
#define HUD_BOSS_HEALTH_MAX 0x400

// --------------------
// ENUMS
// --------------------

enum HUDFlags_
{
    HUD_FLAG_VISIBLE               = 1 << 0,
    HUD_FLAG_TENSION_GAUGE_VISIBLE = 1 << 1,
    HUD_FLAG_4                     = 1 << 2,
    HUD_FLAG_TENSION_MAX_ENABLED   = 1 << 3,
    HUD_FLAG_TENSION_MAX_ACTIVE    = 1 << 4,
    HUD_FLAG_20                    = 1 << 5,
    HUD_FLAG_40                    = 1 << 6,
    HUD_FLAG_80                    = 1 << 7,
    HUD_FLAG_USE_SCREEN_B          = 1 << 8,
};
typedef u32 HUDFlags;

enum HUDAnimatorID
{
    HUD_ANIMATOR_RINGICON,
    HUD_ANIMATOR_TIME_TEXT,
    HUD_ANIMATOR_TENSION_STAR,
    HUD_ANIMATOR_TENSION_PEDESTAL,
    HUD_ANIMATOR_TENSION_x4_HIGH,
    HUD_ANIMATOR_TENSION_x4_LOW,
    HUD_ANIMATOR_TENSION_x1_HIGH,
    HUD_ANIMATOR_TENSION_x1_LOW,
    HUD_ANIMATOR_TIME_COLON,
    HUD_ANIMATOR_TIME_COLON2,

    HUD_ANIMATOR_PLAYER_ICON,
    HUD_ANIMATOR_RING_PANEL,
    HUD_ANIMATOR_PLAYER_BORDER,
    HUD_ANIMATOR_PLAYER_BORDER2,
    HUD_ANIMATOR_VS_POSITION,

    HUD_ANIMATOR_COUNT_TOTAL,
    HUD_ANIMATOR_COUNT_MAIN = HUD_ANIMATOR_PLAYER_ICON,
};

enum HUDDigitID
{
    HUD_DIGIT_0,
    HUD_DIGIT_1,
    HUD_DIGIT_2,
    HUD_DIGIT_3,
    HUD_DIGIT_4,
    HUD_DIGIT_5,
    HUD_DIGIT_6,
    HUD_DIGIT_7,
    HUD_DIGIT_8,
    HUD_DIGIT_9,

    // Used for GetHUDTimeNumAnimator
    HUD_DIGIT_COLON,
    HUD_DIGIT_COLON2,
};

enum HUDAnimID
{
    HUD_ANI_0,
    HUD_ANI_1,
    HUD_ANI_2,
    HUD_ANI_3,
    HUD_ANI_4,
    HUD_ANI_5,
    HUD_ANI_6,
    HUD_ANI_7,
    HUD_ANI_8,
    HUD_ANI_9,
    HUD_ANI_10,
    HUD_ANI_11,
    HUD_ANI_12,
    HUD_ANI_13,
    HUD_ANI_14,
    HUD_ANI_15,
    HUD_ANI_16,
    HUD_ANI_17,
    HUD_ANI_18,
    HUD_ANI_19,
    HUD_ANI_20,
    HUD_ANI_21,
    HUD_ANI_22,
    HUD_ANI_23,
    HUD_ANI_24,
    HUD_ANI_25,
    HUD_ANI_26,
    HUD_ANI_27,
    HUD_ANI_28,
    HUD_ANI_29,
    HUD_ANI_30,
    HUD_ANI_31,
    HUD_ANI_32,
    HUD_ANI_33,
    HUD_ANI_34,
    HUD_ANI_35,
    HUD_ANI_36,
    HUD_ANI_37,
    HUD_ANI_38,
};

enum HUDContAnimID
{
    HUD_CONTANI_0,
    HUD_CONTANI_1,
    HUD_CONTANI_2,
    HUD_CONTANI_3,
    HUD_CONTANI_4,
    HUD_CONTANI_5,
    HUD_CONTANI_6,
    HUD_CONTANI_7,
    HUD_CONTANI_8,
    HUD_CONTANI_9,
    HUD_CONTANI_10,
    HUD_CONTANI_11,
    HUD_CONTANI_12,
    HUD_CONTANI_13,
    HUD_CONTANI_14,
    HUD_CONTANI_15,
    HUD_CONTANI_16,
    HUD_CONTANI_17,
    HUD_CONTANI_18,
    HUD_CONTANI_19,
    HUD_CONTANI_20,
    HUD_CONTANI_21,
    HUD_CONTANI_22,
    HUD_CONTANI_23,
    HUD_CONTANI_24,
    HUD_CONTANI_25,
    HUD_CONTANI_26,
    HUD_CONTANI_27,
    HUD_CONTANI_28,
    HUD_CONTANI_29,
    HUD_CONTANI_30,
    HUD_CONTANI_31,
    HUD_CONTANI_32,
    HUD_CONTANI_33,
};

enum HUDMissionAnimID
{
    HUD_MSNANI_SLASH,
    HUD_MSNANI_FLAG_ICON,
    HUD_MSNANI_RING_ICON,
};

enum WifiStatusHUDAnimators
{
    WIFISTATUSHUD_ANIMATOR_LINKLEVEL,
    WIFISTATUSHUD_ANIMATOR_BORDER,

    WIFISTATUSHUD_ANIMATOR_COUNT,
};

enum RaceProgressHUDAnimators
{
    RACEPROGRESSHUD_ANIMATOR_START,
    RACEPROGRESSHUD_ANIMATOR_GOAL,
    RACEPROGRESSHUD_ANIMATOR_COURSE,
    RACEPROGRESSHUD_ANIMATOR_P1_ICON,
    RACEPROGRESSHUD_ANIMATOR_P2_ICON,

    RACEPROGRESSHUD_ANIMATOR_COUNT,
};

enum PassFlagMissionHUDAnimators
{
    PASSFLAGSHUD_ANIMATOR_SLASH,
    PASSFLAGSHUD_ANIMATOR_FLAG,

    PASSFLAGSHUD_ANIMATOR_COUNT,
};

// --------------------
// STRUCTS
// --------------------

typedef struct BossGaugeHUD_
{
    BOOL loaded;
    BOOL visible;
    void *spritePtr;
    void *vramPixels[13];
    Vec2Fx16 position;
    s32 targetHealth;
    s32 displayHealth[3];
    s32 prevDisplayHealth[3];
    u32 activeHealthbar;
    u32 segmentAnimID[26];
    AnimatorSprite animator;
} BossGaugeHUD;

typedef struct HUD_
{
    BOOL loadedSprites;
    HUDFlags flags;
    AnimatorSpriteDS animators[HUD_ANIMATOR_COUNT_TOTAL];
    AnimatorSpriteDS digitsAnimator;
    AnimatorSpriteDS lifeNumAnimator;
    VRAMPixelKey vramPixels[21][2]; // digitVRAMPixels
    s16 targetTension;
    s16 currentTension;
    s16 currentTensionPos;
    s16 lastTensionPos;
    s16 tensionChangeTimer;
    fx32 nextTensionScale;
    fx32 tensionScale[4];
    s16 tensionGaugeShakeTimer;
    s16 tensionGaugeShakeDuration;
    s16 tensionGaugeX;
    s16 tensionGaugeY;
    BossGaugeHUD bossManager;
} HUD;

typedef struct CheckpointTimeHUD_
{
    s32 timer;
    u32 time;
    u16 minutes;
    u16 seconds;
    u16 centiseconds;
} CheckpointTimeHUD;

typedef struct LapTimeHUD_
{
    u16 minutes[5];
    u16 seconds[5];
    u16 milliseconds[5];
} LapTimeHUD;

typedef struct WifiStatusHUD_
{
    AnimatorSpriteDS animators[WIFISTATUSHUD_ANIMATOR_COUNT];
    WMLinkLevel lastLinkLevel;
    BOOL useDWC;
    u16 animID;
} ConnectionStatusHUD;

typedef struct TargetIndicatorHUD_
{
    AnimatorSprite animator;
    StageTask *target;
} TargetIndicatorHUD;

typedef struct RaceIconsHUD_
{
    AnimatorSprite animators[RACEPROGRESSHUD_ANIMATOR_COUNT];
} RaceProgressHUD;

typedef struct PassFlagMissionHUD_
{
    AnimatorSpriteDS animators[PASSFLAGSHUD_ANIMATOR_COUNT];
} PassFlagMissionHUD;

typedef struct CollectRingsMissionHUD_
{
    AnimatorSpriteDS animator;
} CollectRingsMissionHUD;

typedef struct DefeatEnemiesHUD_
{
    AnimatorSpriteDS animator;
} GenericQuotaMissionHUD;

typedef struct TimeAttackReplayHUD_
{
    AnimatorSprite animator;
} TimeAttackReplayHUD;

// --------------------
// FUNCTIONS
// --------------------

// HUD
void CreateHUD(BOOL forStage);
BOOL LoadHUDAssets(void);
void SetHUDVisible(BOOL enabled);
AnimatorSpriteDS *GetHUDTimeNumAnimator(u16 number, BOOL useAltPalette);
AnimatorSpriteDS *GetHUDLifeNumAnimator(u16 number, BOOL useAltPalette);
void UpdateTensionGaugeHUD(s32 tension, BOOL calledFromPlayer);
void EnableHUDTensionMaxEffect(BOOL enabled);
void SetHUDActiveScreen(GraphicsEngine engine);
GraphicsEngine GetHUDActiveScreen(void);
void UpdateBossHealthHUD(s32 health);
void SetBossHealthbarPosition(fx16 x, fx16 y);
void SetActiveBossHealthbar(s32 id);

// HUD components
void CreateCheckpointTimeHUD(u32 time);
void CreateLapTimeHUD(void);
void AddLapTimeToHUD(u32 id, u32 time);
void CreateConnectionStatusHUD(BOOL useDWC);
void CreateTargetIndicatorHUD(StageTask *parent);
void CreateRaceProgressHUD(s32 characterID);

#endif // RUSH_HUD_H