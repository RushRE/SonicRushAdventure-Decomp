#include <game/system/sysEvent.h>
#include <game/stage/gameSystem.h>
#include <game/game/gameState.h>
#include <game/save/saveGame.h>
#include <game/save/saveInitManager.h>
#include <game/graphics/renderCore.h>
#include <game/system/netConfig.h>
#include <stage/core/titleCard.h>
#include <stage/core/demoPlayer.h>
#include <game/stage/demoSystem.h>
#include <menu/splashScreen.h>
#include <cutscene/opening.h>
#include <ex/ex.h>
#include <sail/sailManager.h>
#include <cutscene/cutsceneScript.h>

// --------------------
// TEMP
// --------------------

// Note: function params not decompiled yet either! these are just here for the addresses!
NOT_DECOMPILED void TitleScreen__Init(void);
NOT_DECOMPILED void InitCreditsEvent(void);
NOT_DECOMPILED void TimeAttackMenu__Create(void);
NOT_DECOMPILED void StageClear__Create(void);
NOT_DECOMPILED void VSStageClear__Create(void);
NOT_DECOMPILED void StageClearEx__Create(void);
NOT_DECOMPILED void VSMenu__Create(void);
NOT_DECOMPILED void VSLobbyMenu__Create(void);
NOT_DECOMPILED void InitNetworkErrorMenu(void);
NOT_DECOMPILED void HubControl__ReturnToHub(void);
NOT_DECOMPILED void MainMenu__Create(void);
NOT_DECOMPILED void PlayerNameMenu__Create(void);
NOT_DECOMPILED void EmeraldCollectedScreen__Create(void);
NOT_DECOMPILED void CreateCorruptSaveWarning(void);
NOT_DECOMPILED void SeaMapUnknown__Create(void);
NOT_DECOMPILED void SeaMapCourseChangeView__Create(void);
NOT_DECOMPILED void SeaMapTraining__Create(void);
NOT_DECOMPILED void SeaMapCutscene__Create(void);
NOT_DECOMPILED void DeleteSaveDataMenu__Create(void);
NOT_DECOMPILED void SoundTest__Create(void);
NOT_DECOMPILED void DoorPuzzle__Init(void);
NOT_DECOMPILED void VikingCupMenu__Create(void);

// --------------------
// FUNC DECLS
// --------------------

extern void InitSkipTitleCardEvent(void);
extern void InitZoneSysEvent(void);
extern void ExitTitleCardSysEvent(void);
extern void InitLoadStageEvent(void);
extern void InitZoneEvent(void);
extern void InitVSBattleEvent(void);
extern void InitStageMission(s32 id);

static void SysEvent_Main(void);
static void SysEventChangeCallback(void);
static void DecideNextSysEvent(void);

// --------------------
// STRUCTS
// --------------------

struct SysEventControl
{
    Task *task;
    SysEventList eventList;
};

// --------------------
// VARIABLES
// --------------------

FS_EXTERN_OVERLAY(ZoneAct);
FS_EXTERN_OVERLAY(Boss1);
FS_EXTERN_OVERLAY(Boss2);
FS_EXTERN_OVERLAY(Menus1);
FS_EXTERN_OVERLAY(Menus2);
FS_EXTERN_OVERLAY(Hub);
FS_EXTERN_OVERLAY(Sail);
FS_EXTERN_OVERLAY(Cutscene);
FS_EXTERN_OVERLAY(DWCUtility);
FS_EXTERN_OVERLAY(ExBoss);

const struct SysEvent sysEventList[SYSEVENT_COUNT] = {
    // SYSEVENT_NONE
    {
        .initFunc    = NULL,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = OVERLAY_NONE,
    },

    // SYSEVENT_SPLASH_SCREEN
    {
        .initFunc    = CreateSplashScreen,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_OPENING, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus2),
    },

    // SYSEVENT_OPENING
    {
        .initFunc    = CreateOpening,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_TITLE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus2),
    },

    // SYSEVENT_TITLE
    {
        .initFunc    = TitleScreen__Init,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_DEMO, SYSEVENT_UPDATE_PROGRESS, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus2),
    },

    // SYSEVENT_DEMO
    {
        .initFunc    = InitDemoEvent,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_ZONE_DEMO, SYSEVENT_SAILING, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus2),
    },

    // SYSEVENT_ZONE_DEMO
    {
        .initFunc    = InitZoneDemoEvent,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_LOAD_STAGE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = OVERLAY_NONE,
    },

    // SYSEVENT_CREDITS
    {
        .initFunc    = InitCreditsEvent,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_AUTOSAVE, SYSEVENT_UPDATE_PROGRESS, SYSEVENT_RETURN_TO_HUB, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Hub),
    },

    // SYSEVENT_7
    {
        .initFunc    = TimeAttackMenu__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_RETURN_TO_HUB, SYSEVENT_UPDATE_PROGRESS, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_LOAD_STAGE
    {
        .initFunc    = InitLoadStageEvent,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_ZONEACT, SYSEVENT_BOSS1, SYSEVENT_BOSS2, SYSEVENT_VSBATTLE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = OVERLAY_NONE,
    },

    // SYSEVENT_ZONEACT
    {
        .initFunc    = InitZoneEvent,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = InitZoneSysEvent,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_TITLECARD, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(ZoneAct),
    },

    // SYSEVENT_BOSS1
    {
        .initFunc    = InitZoneEvent,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = InitZoneSysEvent,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_TITLECARD, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Boss1),
    },

    // SYSEVENT_BOSS2
    {
        .initFunc    = InitZoneEvent,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = InitZoneSysEvent,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_TITLECARD, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Boss2),
    },

    // SYSEVENT_VSBATTLE
    {
        .initFunc    = InitVSBattleEvent,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = InitZoneSysEvent,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_TITLECARD, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(ZoneAct),
    },

    // SYSEVENT_TITLECARD
    {
        .initFunc    = TitleCard__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = ExitTitleCardSysEvent,
        .nextEvents  = { SYSEVENT_STAGE_ACTIVE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = OVERLAY_NONE,
    },

    // SYSEVENT_STAGE_ACTIVE
    {
        .initFunc    = InitSkipTitleCardEvent,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = ExitTitleCardSysEvent,
        .nextEvents  = { SYSEVENT_TITLECARD, SYSEVENT_STAGE_CLEAR, SYSEVENT_24, SYSEVENT_UPDATE_PROGRESS, SYSEVENT_TITLE, SYSEVENT_21, SYSEVENT_VS_STAGE_CLEAR,
                        SYSEVENT_SPLASH_SCREEN },
        .attribute   = 0,
        .overlay     = OVERLAY_NONE,
    },

    // SYSEVENT_STAGE_CLEAR
    {
        .initFunc    = StageClear__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = ExitStageClearSysEvent,
        .nextEvents  = { SYSEVENT_UPDATE_PROGRESS, SYSEVENT_24, SYSEVENT_22, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_VS_STAGE_CLEAR
    {
        .initFunc    = VSStageClear__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = ExitStageClearSysEvent,
        .nextEvents  = { SYSEVENT_VS_LOBBY_MENU, SYSEVENT_VS_MENU, SYSEVENT_NETWORK_ERROR_MENU, SYSEVENT_CORRUPT_SAVE_WARNING, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE,
                        SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_EXBOSS
    {
        .initFunc    = InitExBossEvent,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_UPDATE_PROGRESS, SYSEVENT_RETURN_TO_HUB, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(ExBoss),
    },

    // SYSEVENT_STAGE_CLEAR_EX
    {
        .initFunc    = StageClearEx__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_UPDATE_PROGRESS, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus2),
    },

    // SYSEVENT_19
    {
        .initFunc    = TimeAttackMenu__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_RETURN_TO_HUB, SYSEVENT_LOAD_STAGE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_20
    {
        .initFunc    = TimeAttackMenu__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_RETURN_TO_HUB, SYSEVENT_LOAD_STAGE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_21
    {
        .initFunc    = TimeAttackMenu__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_RETURN_TO_HUB, SYSEVENT_LOAD_STAGE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_22
    {
        .initFunc    = TimeAttackMenu__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_RETURN_TO_HUB, SYSEVENT_LOAD_STAGE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_VS_MENU
    {
        .initFunc    = VSMenu__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_RETURN_TO_HUB, SYSEVENT_VS_LOBBY_MENU, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_24
    {
        .initFunc    = TimeAttackMenu__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_RETURN_TO_HUB, SYSEVENT_LOAD_STAGE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_VS_LOBBY_MENU
    {
        .initFunc    = VSLobbyMenu__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_LOAD_STAGE, SYSEVENT_NETWORK_ERROR_MENU, SYSEVENT_CORRUPT_SAVE_WARNING, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE,
                        SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_NETWORK_ERROR_MENU
    {
        .initFunc    = InitNetworkErrorMenu,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_VS_MENU, SYSEVENT_24, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_SAILING
    {
        .initFunc    = InitSailingSysEvent,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_UPDATE_PROGRESS, SYSEVENT_UPDATE_PROGRESS, SYSEVENT_CHANGE_CHARTED_COURSE, SYSEVENT_UPDATE_PROGRESS, SYSEVENT_SAILING, SYSEVENT_TITLE,
                        SYSEVENT_SPLASH_SCREEN, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Sail),
    },

    // SYSEVENT_RETURN_TO_HUB
    {
        .initFunc    = HubControl__ReturnToHub,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Hub),
    },

    // SYSEVENT_MAIN_MENU
    {
        .initFunc    = MainMenu__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_TITLE, SYSEVENT_LOAD_STAGE, SYSEVENT_EXBOSS, SYSEVENT_RETURN_TO_HUB, SYSEVENT_UPDATE_PROGRESS, SYSEVENT_CORRUPT_SAVE_WARNING, SYSEVENT_NONE,
                        SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_PLAYER_NAME_MENU
    {
        .initFunc    = PlayerNameMenu__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_RETURN_TO_HUB, SYSEVENT_CORRUPT_SAVE_WARNING, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus2),
    },

    // SYSEVENT_EMERALD_COLLECTED
    {
        .initFunc    = EmeraldCollectedScreen__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus2),
    },

    // SYSEVENT_CORRUPT_SAVE_WARNING
    {
        .initFunc    = CreateCorruptSaveWarning,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_SPLASH_SCREEN, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = OVERLAY_NONE,
    },

    // SYSEVENT_NETCONFIG
    {
        .initFunc    = RunNetConfig,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(DWCUtility),
    },

    // SYSEVENT_CUTSCENE
    {
        .initFunc    = CutsceneAssetSystem__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Cutscene),
    },

    // SYSEVENT_SEAMAP_UNKNOWN
    {
        .initFunc    = SeaMapUnknown__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_UPDATE_PROGRESS, SYSEVENT_RETURN_TO_HUB, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_CHANGE_CHARTED_COURSE
    {
        .initFunc    = SeaMapCourseChangeView__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_SAILING, SYSEVENT_RETURN_TO_HUB, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_SEAMAP_TRAINING
    {
        .initFunc    = SeaMapTraining__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_UPDATE_PROGRESS, SYSEVENT_RETURN_TO_HUB, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_38
    {
        .initFunc    = SeaMapCutscene__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_UPDATE_PROGRESS, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_DELETE_SAVE_MENU
    {
        .initFunc    = DeleteSaveDataMenu__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_TITLE, SYSEVENT_RETURN_TO_HUB, SYSEVENT_CORRUPT_SAVE_WARNING, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus2),
    },

    // SYSEVENT_UPDATE_PROGRESS
    {
        .initFunc    = SaveGame__UpdateProgressEvent,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = OVERLAY_NONE,
    },

    // SYSEVENT_SOUND_TEST
    {
        .initFunc    = SoundTest__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_RETURN_TO_HUB, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus2),
    },

    // SYSEVENT_DOOR_PUZZLE
    {
        .initFunc    = DoorPuzzle__Init,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_UPDATE_PROGRESS, SYSEVENT_RETURN_TO_HUB, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus2),
    },

    // SYSEVENT_VIKING_CUP
    {
        .initFunc    = VikingCupMenu__Create,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_RETURN_TO_HUB, SYSEVENT_SAILING, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_SAVE_INIT
    {
        .initFunc    = CreateSaveInitManager,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_SPLASH_SCREEN, SYSEVENT_OPENING, SYSEVENT_CORRUPT_SAVE_WARNING, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus1),
    },

    // SYSEVENT_AUTOSAVE
    {
        .initFunc    = CreateAutoSavePopup,
        .exitFunc    = NULL,
        .resetFunc   = NULL,
        .initSysFunc = NULL,
        .exitSysFunc = NULL,
        .nextEvents  = { SYSEVENT_SPLASH_SCREEN, SYSEVENT_CORRUPT_SAVE_WARNING, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE, SYSEVENT_NONE },
        .attribute   = 0,
        .overlay     = FS_OVERLAY_ID(Menus2),
    },
};

struct SysEventControl sysEventWork;

// --------------------
// FUNCTIONS
// --------------------

void CreateSysEventEx(const struct SysEvent *eventList, u32 eventCount, u32 eventID, BOOL createTask, u16 priority, TaskScope scope)
{
    if (createTask)
        sysEventWork.task = TaskCreateNoWork(SysEvent_Main, NULL, TASK_FLAG_DISABLE_DESTROY | TASK_FLAG_INACTIVE, 0, priority, scope, "SysEvent");

    // Init sysEvent list
    SysEventList *list            = &sysEventWork.eventList;
    list->eventList               = NULL;
    list->eventListCount          = 0;
    list->currentEventData        = NULL;
    list->eventID_Opaque          = SYSEVENT_NONE;
    list->nextEventData           = NULL;
    list->requestedEventID_Opaque = SYSEVENT_NONE;
    list->status                  = SYSEVENT_STATUS_IDLE;

    // Properly setup sysEvent list
    sysEventWork.eventList.eventList        = eventList;
    sysEventWork.eventList.eventListCount   = eventCount;
    sysEventWork.eventList.currentEventData = eventList;
    sysEventWork.eventList.nextEventData    = NULL;
    sysEventWork.eventList.currentEventID   = SYSEVENT_NONE;
    sysEventWork.eventList.requestedEventID = SYSEVENT_NONE;
    sysEventWork.eventList.status           = SYSEVENT_STATUS_IDLE;

    RequestNewSysEventChange(eventID);
    NextSysEvent();
}

void SysEvent_Main(void)
{
    if (sysEventWork.eventList.status != SYSEVENT_STATUS_CHANGE_REQUESTED)
        return;

    const struct SysEvent *prevEvent = sysEventWork.eventList.currentEventData;

    if (prevEvent->exitFunc != NULL)
        prevEvent->exitFunc();

    if (prevEvent->exitSysFunc != NULL)
        prevEvent->exitSysFunc();

    sysEventWork.eventList.prevEventID    = sysEventWork.eventList.currentEventID;
    sysEventWork.eventList.currentEventID = sysEventWork.eventList.requestedEventID;

    const struct SysEvent *curEvent         = &sysEventWork.eventList.eventList[sysEventWork.eventList.requestedEventID];
    sysEventWork.eventList.currentEventData = curEvent;

    if (curEvent->overlay != OVERLAY_NONE)
    {
        sysEventWork.eventList.status = SYSEVENT_STATUS_CHANGE_FINISHED;
        RenderCore_ChangeOverlay(curEvent->overlay, SysEventChangeCallback);

        sysEventWork.eventList.requestedEventID = SYSEVENT_INVALID;
        if (curEvent->nextEvents[1] <= SYSEVENT_NONE)
        {
            sysEventWork.eventList.requestedEventID = curEvent->nextEvents[0];
            DecideNextSysEvent();
        }
    }
    else
    {
        sysEventWork.eventList.requestedEventID = SYSEVENT_INVALID;

        if (curEvent->nextEvents[1] <= SYSEVENT_NONE)
        {
            sysEventWork.eventList.requestedEventID = curEvent->nextEvents[0];
            DecideNextSysEvent();
        }

        SysEventChangeCallback();
    }
}

void SysEventChangeCallback(void)
{
    SysEventList *eventList      = &sysEventWork.eventList;
    const struct SysEvent *event = sysEventWork.eventList.currentEventData;

    eventList->status = SYSEVENT_STATUS_IDLE;

    if (event->initSysFunc != NULL)
        event->initSysFunc();

    if (event->initFunc != NULL)
        event->initFunc();
}

SysEventList *GetSysEventList(void)
{
    return &sysEventWork.eventList;
}

void RequestSysEventChange(s32 id)
{
    sysEventWork.eventList.requestedEventCase = id;
    RequestNewSysEventChange(sysEventWork.eventList.currentEventData->nextEvents[id]);
}

void RequestNewSysEventChange(s32 id)
{
    if (id <= SYSEVENT_NONE || (s32)sysEventWork.eventList.eventListCount <= id)
        return;

    sysEventWork.eventList.requestedEventID = id;
    DecideNextSysEvent();
}

void NextSysEvent(void)
{
    const struct SysEvent *event = sysEventWork.eventList.currentEventData;

    if (sysEventWork.eventList.requestedEventID < SYSEVENT_NONE)
        sysEventWork.eventList.requestedEventID = event->nextEvents[0];

    sysEventWork.eventList.status = SYSEVENT_STATUS_CHANGE_REQUESTED;
}

void DecideNextSysEvent(void)
{
    if (sysEventWork.eventList.requestedEventID < SYSEVENT_NONE)
        sysEventWork.eventList.requestedEventID = sysEventWork.eventList.currentEventData->nextEvents[0];

    sysEventWork.eventList.nextEventData = &sysEventWork.eventList.eventList[sysEventWork.eventList.requestedEventID];
}