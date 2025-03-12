#ifndef RUSH_SAILPLAYER_H
#define RUSH_SAILPLAYER_H

#include <stage/stageTask.h>
#include <game/object/objDraw.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <sail/sailManager.h>
#include <sail/sailCommonObjects.h>
#include <sail/sailRival.h>

// --------------------
// CONSTANTS
// --------------------

#define SAILPLAYER_HEALTH_MIN FLOAT_TO_FX32(0.0)
#define SAILPLAYER_HEALTH_MAX FLOAT_TO_FX32(256.0)

#define SAILPLAYER_BOOST_MIN           FLOAT_TO_FX32(0.0)
#define SAILPLAYER_BOOST_MAX           FLOAT_TO_FX32(288.0)
#define SAILPLAYER_BOOST_START         FLOAT_TO_FX32(96.0)
#define SAILPLAYER_BOOST_ACTIVATE_COST FLOAT_TO_FX32(10.0)
#define SAILPLAYER_BOOST_DRAIN_GROUND  FLOAT_TO_FX32(2.0)
#define SAILPLAYER_BOOST_DRAIN_AIR     FLOAT_TO_FX32(0.125)

#define SAILPLAYER_CHARGE_MIN                  FLOAT_TO_FX32(0.0)
#define SAILPLAYER_CHARGE_MAX                  FLOAT_TO_FX32(288.0)
#define SAILPLAYER_CHARGE_SPEED                FLOAT_TO_FX32(5.0)
#define SAILPLAYER_CHARGE_SPEED_UPGRADE        FLOAT_TO_FX32(5.0)
#define SAILPLAYER_CHARGE_POWERED_UP           FLOAT_TO_FX32(96.0)
#define SAILPLAYER_CHARGE_FULL_POWER           SAILPLAYER_CHARGE_MAX
#define SAILPLAYER_CHARGE_SFX_START_THRESHOLD  FLOAT_TO_FX32(0.0)
#define SAILPLAYER_CHARGE_SFX_CHARGE_THRESHOLD FLOAT_TO_FX32(30.0)

#define SAILPLAYER_MAX_RINGS 9999

#define SAILPLAYER_MAX_SCORE 99999999

#define SAILPLAYER_MAX_SCORE_COMBO 999

// --------------------
// ENUMS
// --------------------

enum SailPlayerUpgradeLevel_
{
    SAILPLAYER_UPGRADE_LEVEL_0,
    SAILPLAYER_UPGRADE_LEVEL_1,
    SAILPLAYER_UPGRADE_LEVEL_2,
};
typedef u16 SailPlayerUpgradeLevel;

enum SailPlayerAction_
{
    SAILPLAYER_ACTION_INVALID = -1,

    SAILPLAYER_ACTION_0 = 0,
    SAILPLAYER_ACTION_1,
    SAILPLAYER_ACTION_2,
    SAILPLAYER_ACTION_3,
    SAILPLAYER_ACTION_4,
    SAILPLAYER_ACTION_5,
    SAILPLAYER_ACTION_6,
    SAILPLAYER_ACTION_7,
    SAILPLAYER_ACTION_8,
    SAILPLAYER_ACTION_9,
    SAILPLAYER_ACTION_10,
    SAILPLAYER_ACTION_11,
    SAILPLAYER_ACTION_12,
    SAILPLAYER_ACTION_13,
    SAILPLAYER_ACTION_14,
    SAILPLAYER_ACTION_15,
    SAILPLAYER_ACTION_16,
    SAILPLAYER_ACTION_17,

    SAILPLAYER_ACTION_COUNT,
};
typedef u16 SailPlayerAction;

enum SailPlayerFlag_
{
    SAILPLAYER_FLAG_NONE = 0x00,

    SAILPLAYER_FLAG_BOOST          = 1 << 0,
    SAILPLAYER_FLAG_IS_HURT        = 1 << 1,
    SAILPLAYER_FLAG_4              = 1 << 2,
    SAILPLAYER_FLAG_8              = 1 << 3,
    SAILPLAYER_FLAG_10             = 1 << 4,
    SAILPLAYER_FLAG_20             = 1 << 5,
    SAILPLAYER_FLAG_40             = 1 << 6,
    SAILPLAYER_FLAG_80             = 1 << 7,
    SAILPLAYER_FLAG_100            = 1 << 8,
    SAILPLAYER_FLAG_200            = 1 << 9,
    SAILPLAYER_FLAG_400            = 1 << 10,
    SAILPLAYER_FLAG_800            = 1 << 11,
    SAILPLAYER_FLAG_1000           = 1 << 12,
    SAILPLAYER_FLAG_2000           = 1 << 13,
    SAILPLAYER_FLAG_USED_MAX_BOOST = 1 << 14,
    SAILPLAYER_FLAG_8000           = 1 << 15,
    SAILPLAYER_FLAG_10000          = 1 << 16,
    SAILPLAYER_FLAG_20000          = 1 << 17,
    SAILPLAYER_FLAG_40000          = 1 << 18,
    SAILPLAYER_FLAG_80000          = 1 << 19,
    SAILPLAYER_FLAG_100000         = 1 << 20,
    SAILPLAYER_FLAG_200000         = 1 << 21,
    SAILPLAYER_FLAG_400000         = 1 << 22,
    SAILPLAYER_FLAG_800000         = 1 << 23,
    SAILPLAYER_FLAG_1000000        = 1 << 24,
    SAILPLAYER_FLAG_2000000        = 1 << 25,
    SAILPLAYER_FLAG_4000000        = 1 << 26,
    SAILPLAYER_FLAG_8000000        = 1 << 27,
    SAILPLAYER_FLAG_10000000       = 1 << 28,
    SAILPLAYER_FLAG_SHIP_BOAT      = 1 << 29,
    SAILPLAYER_FLAG_SHIP_HOVER     = 1 << 30,
    SAILPLAYER_FLAG_SHIP_SUBMARINE = 1 << 31,
};
typedef u32 SailPlayerFlag;

// --------------------
// STRUCTS
// --------------------

typedef struct SailPlayer_
{
    u16 shipType;
    u16 isRival;
    VecFx32 collisionOffset;
    fx32 speed;
    u32 field_14;
    VecFx32 seaPos;
    Vec2Fx32 touchPos;
    s32 field_2C;
    SailColliderWork colliders[3];
    s32 field_198;
    s32 field_19C;
    s32 field_1A0;
    u32 rings;
    u32 score;
    u32 enemyDefeatCount;
    u8 field_1B0;
    u8 field_1B1;
    u8 field_1B2;
    u8 field_1B3;
    u8 field_1B4;
    u8 field_1B5;
    u8 field_1B6;
    u8 field_1B7;
    s32 health;
    s32 boost;
    SailPlayerAction action;
    s16 blinkTimer;
    u16 scoreComboCurrent;
    u16 scoreComboBest;
    u16 field_1C8;
    s16 seaAngle2;
    s16 field_1CC;
    SailPlayerUpgradeLevel upgradeLevel;
    s32 field_1D0;
    u32 dword1D4;
    u16 field_1D8;
    u16 field_1DA;
    s16 field_1DC;
    u16 field_1DE;
    u16 boostCooldownTimer;
    s16 trickFinishTimer;
    s16 missedRingCount;
    s16 field_1E6;
    s16 dashPanelTimer;
    s16 field_1EA;
    s16 field_1EC;
    s16 maxBoostTimer;
    s16 overSpdLimitTimer;
    u16 field_1F2;
    u16 rivalVoiceClipTimer;
    u16 field_1F6;
    u16 field_1F8;
    u16 field_1FA;
    fx32 chargeTimer;
    s32 field_200;
    s32 field_204;
    u16 field_208;
    u16 field_20A;
    u16 field_20C;
    u16 selectedWeapon;
    s32 healthChange;
    fx32 weaponAmmo[3];
    u32 weaponCooldown[3];
    u16 field_22C;
    u16 field_22E;
    TouchPos touchOn;
    TouchPos touchPrev;
    TouchPos touchPush;
    TouchStateFlags touchFlags;
    u16 btnPress;
    u16 btnRelease;
    u16 btnDown;
    u32 boostTapTimer;
    u32 field_248;
    u32 field_24C;
    SailRival *sailRival;
    VecFx32 racePos;
    s32 field_260;
    PaletteTexture paletteTex;
    u16 lightColor[3];
    void *shipSndHandles[2];
    NNSSndHandle *sndHandles[2];
} SailPlayer;

// --------------------
// FUNCTIONS
// --------------------

StageTask *SailPlayer__Create(u16 shipType, BOOL isRival);
void SailPlayer__ColliderFunc_JetHover(StageTask *work, s32 id);
void SailPlayer__ColliderFunc_SailerSub(StageTask *work, s32 id);
void SailPlayer__ColliderFunc(StageTask *work, s32 id);
void SailPlayer__RemoveHealth(StageTask *player, s32 amount);
void SailPlayer__GiveBoost(StageTask *player, s32 amount);
BOOL SailPlayer__HasRetired(StageTask *player);
void SailPlayer__ReachedGoal(StageTask *player);
void SailPlayer__Action_BeginVoyage(StageTask *player);
void SailPlayer__State_BeginVoyage(StageTask *work);
void SailPlayer__Action_ReachedGoal(StageTask *player);
void SailPlayer__State_ReachedGoal(StageTask *work);
void SailPlayer__Gimmick_DashPanel(StageTask *player, s16 a2, s16 timer);
void SailPlayer__ChangeAction(StageTask *player, SailPlayerAction action);
void SailPlayer__Destructor(Task *task);
void SailPlayer__Action_Boost(StageTask *player);
void SailPlayer__Action_StopBoost(StageTask *player);
void SailPlayer__Action_215A350(StageTask *player);
void SailPlayer__Func_215A41C(StageTask *player);
void SailPlayer__Action_RecoverJetHover(StageTask *player);
void SailPlayer__State_RecoverJetHover(StageTask *work);
void SailPlayer__Gimmick_JumpRamp(StageTask *player);
void SailPlayer__State_JumpRamp(StageTask *work);
BOOL SailPlayer__CheckInWater(StageTask *player);
void SailPlayer__Func_215AB10(SailColliderWork *rect1, SailColliderWork *rect2);
void SailPlayer__OnDefend_JetHover(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void SailPlayer__Action_HurtJetHover2(StageTask *player);
void SailPlayer__State_HurtJetHover1(StageTask *work);
void SailPlayer__Action_HurtJetHover1(StageTask *player);
void SailPlayer__State_HurtJetHover2(StageTask *work);
void SailPlayer__Action_RetireJetHover(StageTask *player);
void SailPlayer__State_RetireJetHover(StageTask *work);
void SailPlayer__Action_RivalReachedGoal(StageTask *player);
void SailPlayer__State_RivalReachedGoal(StageTask *work);
void SailPlayer__Action_RecoverBoat(StageTask *player);
void SailPlayer__State_RecoverBoat(StageTask *work);
void SailPlayer__OnDefend_Boat(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void SailPlayer__Action_SmallHurtBoat(StageTask *player);
void SailPlayer__Action_BigHurtBoat(StageTask *player);
void SailPlayer__State_HurtBoat(StageTask *work);
void SailPlayer__Action_RetireBoat(StageTask *player);
void SailPlayer__State_215B618(StageTask *work);
void SailPlayer__Func_215B6B8(StageTask *player);
void SailPlayer__Action_RecoverSubmarine(StageTask *player);
void SailPlayer__State_RecoverSubmarine(StageTask *work);
void SailPlayer__OnDefend_Submarine(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
void SailPlayer__Action_HurtSubmarine(StageTask *player);
void SailPlayer__State_HurtSubmarine(StageTask *work);
void SailPlayer__Action_RetireSubmarine(StageTask *player);
void SailPlayer__State_RetireSubmarine(StageTask *work);
void SailPlayer__Func_215BAF0(StageTask *work);
void SailPlayer__Func_215BD3C(StageTask *work);
void SailPlayer__Func_215BFEC(StageTask *work);
void SailPlayer__HandleTimers(StageTask *work);
void SailPlayer__HandleJetControl(StageTask *work);
void SailPlayer__HandleBoatControl(StageTask *work);
void SailPlayer__HandleHoverControl2(StageTask *work);
void SailPlayer__HandleHoverControl1(StageTask *work);
void SailPlayer__HandleSubmarineControl(StageTask *work);
void SailPlayer__In_Default(void);
void SailPlayer__ReadInputs(StageTask *work);
void SailPlayer__HandleJetSfx(StageTask *work);
void SailPlayer__HandleBoatSfx(StageTask *work);
void SailPlayer__HandleBoatWeaponTimers(StageTask *work);
void SailPlayer__HandleHoverSfx(StageTask *work);
void SailPlayer__HandleSubmarineSfx(StageTask *work);
void SailPlayer__Last_Default(void);
void SailPlayer__BoatRenderCallback(NNSG3dRS *rs);
void SailPlayer__Func_215F154(StageTask *work);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE void SailPlayer__AddHealth(StageTask *player, s32 amount)
{
    SailPlayer__RemoveHealth(player, -amount);
}

#endif // !RUSH_SAILPLAYER_H