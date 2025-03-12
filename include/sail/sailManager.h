#ifndef RUSH_SAILMANAGER_H
#define RUSH_SAILMANAGER_H

#include <game/system/task.h>
#include <game/game/gameState.h>
#include <game/text/fontAnimator.h>
#include <game/text/fontWindowAnimator.h>
#include <game/text/fontWindowMWControl.h>
#include <game/input/touchField.h>

#include <sail/sailSea.h>
#include <sail/sailVoyageManager.h>
#include <sail/sailRingManager.h>
#include <sail/sailEventManager.h>
#include <sail/sailHUD.h>
#include <sail/sailCamera.h>

// --------------------
// ENUMS
// --------------------

enum SailManagerFlags_
{
    SAILMANAGER_FLAG_NONE = 0x00,

    SAILMANAGER_FLAG_1                          = 1 << 0,
    SAILMANAGER_FLAG_2                          = 1 << 1,
    SAILMANAGER_FLAG_4                          = 1 << 2,
    SAILMANAGER_FLAG_8                          = 1 << 3,
    SAILMANAGER_FLAG_10                         = 1 << 4,
    SAILMANAGER_FLAG_20                         = 1 << 5,
    SAILMANAGER_FLAG_40                         = 1 << 6,
    SAILMANAGER_FLAG_80                         = 1 << 7,
    SAILMANAGER_FLAG_100                        = 1 << 8,
    SAILMANAGER_FLAG_200                        = 1 << 9,
    SAILMANAGER_FLAG_400                        = 1 << 10,
    SAILMANAGER_FLAG_800                        = 1 << 11,
    SAILMANAGER_FLAG_FREEZE_DAYTIME_TIMER         = 1 << 12,
    SAILMANAGER_FLAG_2000                       = 1 << 13,
    SAILMANAGER_FLAG_4000                       = 1 << 14,
    SAILMANAGER_FLAG_8000                       = 1 << 15,
    SAILMANAGER_FLAG_10000                      = 1 << 16,
    SAILMANAGER_FLAG_20000                      = 1 << 17,
    SAILMANAGER_FLAG_40000                      = 1 << 18,
    SAILMANAGER_FLAG_80000                      = 1 << 19,
    SAILMANAGER_FLAG_100000                     = 1 << 20,
    SAILMANAGER_FLAG_200000                     = 1 << 21,
    SAILMANAGER_FLAG_400000                     = 1 << 22,
    SAILMANAGER_FLAG_800000                     = 1 << 23,
    SAILMANAGER_FLAG_PLAYED_RING_SFX_THIS_FRAME = 1 << 24,
    SAILMANAGER_FLAG_2000000                    = 1 << 25,
    SAILMANAGER_FLAG_DISABLE_BTN_PRESS          = 1 << 26,
    SAILMANAGER_FLAG_REPLAY_ACTIVE              = 1 << 27,
    SAILMANAGER_FLAG_10000000                   = 1 << 28,
    SAILMANAGER_FLAG_20000000                   = 1 << 29,
    SAILMANAGER_FLAG_40000000                   = 1 << 30,
    SAILMANAGER_FLAG_80000000                   = 1 << 31,
};
typedef u32 SailManagerFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct SailManager_
{
    ShipType shipType;
    u32 targetIslandID;
    s32 field_8;
    BOOL isRivalRace;
    u16 rivalRaceID;
    u16 missionType;
    u16 missionID;
    u32 missionQuota;
    u32 timer;
    u32 stageTimer;
    SailManagerFlags flags;
    u16 raceRank;
    u16 field_2A;
    s32 field_2C;
    u16 field_30;
    u16 field_32;
    VecFx32 velocity;
    VecFx32 initialVelocity;
    s32 daytimeTimer;
    s32 cloudyness;
    s32 field_54;
    u16 field_58;
    u16 cloudType;
    u16 prevCloudType;
    u16 field_5E;
    u16 field_60;
    u16 field_62;
    VecFx32 skyBrightness;
    StageTask *sailPlayer;
    StageTask *weaponTaskList[6];
    StageTask *rivalJohnny;
    u16 weaponTaskCount;
    SailSea *sea;
    SailVoyageManager *voyageManager;
    SailRingManager *ringManager;
    SailEventManager *eventManager;
    SailHUD *hud;
    SailCamera *camera;
    TouchField touchField;
    FontWindow fontWindow;
    FontWindowAnimator fontWindow1;
    FontWindowAnimator fontWindow2;
    FontAnimator fontAnimator1;
    FontWindowAnimator fontWindow3;
    FontAnimator fontAnimator2;
    FontWindowMWControl fontWindowMW;
    FontUnknown2058D78 fontUnknown;
    FontWindowAnimator fontWindow4;
    FontAnimator fontAnimator3;
    s16 nextEvent;
    u8 *fontFile;
    void *archive;
    u32 field_5DC;
} SailManager;

// --------------------
// VARIABLES
// --------------------

extern u8 const shipShiftUnknown[SHIP_COUNT];

// --------------------
// FUNCTIONS
// --------------------

void InitSailingSysEvent(void);

SailManager *SailManager__GetWork(void);
void SailManager__AddPlayerWeaponTask(StageTask *work);
ShipType SailManager__GetShipType(void);
void *SailManager__GetArchive(void);
SailManager *SailManager__Create(void);
void SailManager__Destructor(Task *task);
void SailManager__Main(void);

#endif // !RUSH_SAILMANAGER_H