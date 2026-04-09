#include <game/save/saveGame.h>
#include <game/save/saveManager.h>
#include <game/system/sysEvent.h>
#include <game/file/cardBackup.h>
#include <game/graphics/renderCore.h>
#include <game/cutscene/script.h>
#include <menu/doorPuzzle.h>
#include <menu/credits.h>
#include <seaMap/seaMapManager.h>

// --------------------
// TYPES
// --------------------

typedef struct SaveGameNextAction_ SaveGameNextAction;

typedef void (*SaveUnknown1)(const SaveGameNextAction *state);
typedef void (*SaveUnknown2)(void);
typedef BOOL (*SaveProgressCheck)(s32 param);

// --------------------
// ENUMS
// --------------------

enum SaveProgressEvent
{
    SAVE_PROGRESSEVENT_START_CUTSCENE,
    SAVE_PROGRESSEVENT_START_TUTORIAL,
    SAVE_PROGRESSEVENT_START_SAIL_TRAINING,
    SAVE_PROGRESSEVENT_START_SAIL_JET_TRAINING,
    SAVE_PROGRESSEVENT_RETURN_TO_HUB,
    SAVE_PROGRESSEVENT_START_DOOR_PUZZLE,
    SAVE_PROGRESSEVENT_START_SEA_MAP_CUTSCENE,
    SAVE_PROGRESSEVENT_START_ISLAND_ARRIVAL,

    SAVE_PROGRESSEVENT_COUNT,

    SAVE_PROGRESSEVENT_NO_CHECK = SAVE_PROGRESSEVENT_COUNT + 1,
};

enum SaveSeaMapCutsceneType
{
    SAVE_SEAMAPCUTSCENE_CORAL_CAVE_APPEARS,
    SAVE_SEAMAPCUTSCENE_TO_SKY_BABYLON,
};

enum SaveStageClearExtraCheck
{
    SAVE_STAGECLEAR_EXTRACHECK_ANY_NONE,
    SAVE_STAGECLEAR_EXTRACHECK_ANY_ACT1,
    SAVE_STAGECLEAR_EXTRACHECK_ANY_ACT2,
    SAVE_STAGECLEAR_EXTRACHECK_ANY_ZONE_5ACT1,
    SAVE_STAGECLEAR_EXTRACHECK_ANY_ZONE_5ACT2,
    SAVE_STAGECLEAR_EXTRACHECK_ANY_ZONE_6ACT1,
    SAVE_STAGECLEAR_EXTRACHECK_ANY_ZONE_6ACT2,
};

// --------------------
// STRUCTS
// --------------------

struct SaveGameNextAction_
{
    u16 type;
    u16 progressCheckValue;
    u16 eventType;
    u16 eventParam;
    u16 nextSysEvent;
    u16 allowProgressIncrement;
};

typedef struct StageProgressCheck_
{
    u8 gameProgress;
    u8 zone5Progress;
    u8 zone6Progress;
    u8 extraCheck;
} StageProgressCheck;

// --------------------
// FUNCTION DECLS
// --------------------

static const SaveGameNextAction *SaveGame__GetNextActionFromProgress(void);
static void SaveGame_ProgressUpdateEvent_ReturnToHub(void);
static void SaveGame_ProgressUpdateEvent_SeaMapChartCourseMenu(void);
static void SaveGame_ProgressUpdateEvent_BeginSailing(void);
static void SaveGame_ProgressUpdateEvent_IslandArrival(void);
static void SaveGame_ProgressUpdateEvent_AdvanceStage(void);
static void SaveGame_ProgressUpdateEvent_StageClear(void);
static void SaveGame_ProgressUpdateEvent_BeginRivalRace(void);
static void SaveGame_ProgressUpdateEvent_FinishRivalRace(void);
static void SaveGame_ProgressUpdateEvent_ExPrologue(void);
static void SaveGame_ProgressUpdateEvent_ExEpilogue(void);
static void SaveGame_ProgressUpdateEvent_DoorPuzzleComplete(void);
static void SaveGame_ProgressUpdateEvent_NonStageIslandArrival(void);

static BOOL SaveGame_ProgressCheck_ReturnToHub(s32 param);
static BOOL SaveGame_ProgressCheck_SeaMapChartCourseMenu(s32 param);
static BOOL SaveGame_ProgressCheck_BeginSailing(s32 param);
static BOOL SaveGame_ProgressCheck_IslandArrival(s32 param);
static BOOL SaveGame_ProgressCheck_AdvanceStage(s32 param);
static BOOL SaveGame_ProgressCheck_StageClear(s32 param);
static BOOL SaveGame_ProgressCheck_BeginRivalRace(s32 param);
static BOOL SaveGame_ProgressCheck_FinishRivalRace(s32 param);
static BOOL SaveGame_ProgressCheck_ExPrologue(s32 param);
static BOOL SaveGame_ProgressCheck_ExEpilogue(s32 param);
static BOOL SaveGame_ProgressCheck_DoorPuzzleComplete(s32 param);
static BOOL SaveGame_ProgressCheck_NonStageIslandArrival(s32 param);

static void SaveGame_ProgressEvent_StartCutscene(const SaveGameNextAction *action);
static void SaveGame_ProgressEvent_StartTutorial(const SaveGameNextAction *action);
static void SaveGame_ProgressEvent_StartSailTraining(const SaveGameNextAction *action);
static void SaveGame_ProgressEvent_StartSailJetTraining(const SaveGameNextAction *action);
static void SaveGame_ProgressEvent_ReturnToHub(const SaveGameNextAction *action);
static void SaveGame_ProgressEvent_StartDoorPuzzle(const SaveGameNextAction *action);
static void SaveGame_ProgressEvent_StartSeaMapCutscene(const SaveGameNextAction *action);
static void SaveGame_ProgressEvent_StartIslandArrival(const SaveGameNextAction *action);

// --------------------
// VARIABLES
// --------------------

SaveGame saveGame;

// assert that the size is always the same as the final game
STATIC_ASSERT_MATCHING(sizeof(SaveGame) == 0x1A68, SAVE_GAME_DOES_NOT_MATCH)

static const u16 sZone5ProgressCounterList[SAVE_ZONE5_PROGRESS_COUNT] = {
    [SAVE_ZONE5_PROGRESS_0] = 0, // Formatting Comment
    [SAVE_ZONE5_PROGRESS_1] = 1, // Formatting Comment
    [SAVE_ZONE5_PROGRESS_2] = 1, // Formatting Comment
    [SAVE_ZONE5_PROGRESS_3] = 1, // Formatting Comment
    [SAVE_ZONE5_PROGRESS_4] = 0  // Formatting Comment
};

static const u16 sExEpilogueCutsceneList[5] = { CUTSCENE_EGG_WIZARD_DESTROYED, CUTSCENE_INVALID, CUTSCENE_EX_ENDING, CUTSCENE_INVALID, CUTSCENE_WE_WILL_MEET_AGAIN };

static const u16 sZone6ProgressCounterList[SAVE_ZONE6_PROGRESS_COUNT] = {
    [SAVE_ZONE6_PROGRESS_0] = 0, // Formatting Comment
    [SAVE_ZONE6_PROGRESS_1] = 1, // Formatting Comment
    [SAVE_ZONE6_PROGRESS_2] = 1, // Formatting Comment
    [SAVE_ZONE6_PROGRESS_3] = 4, // Formatting Comment
    [SAVE_ZONE6_PROGRESS_4] = 1, // Formatting Comment
    [SAVE_ZONE6_PROGRESS_5] = 1, // Formatting Comment
    [SAVE_ZONE6_PROGRESS_6] = 0  // Formatting Comment
};

static const u16 sExPrologueCutsceneList[] = { CUTSCENE_EX_PROLOGUE,
                                               CUTSCENE_EGGMANS_DOUBLE_APPEARANCE_3D,
                                               CUTSCENE_MAGMA_HURRICANE_COMPLETE,
                                               CUTSCENE_MAGMA_HURRICANE_LAUNCH,
                                               CUTSCENE_EGGMANS_THE_SOURCE_OF_POWER_3D,
                                               CUTSCENE_SONIC_AND_BLAZE_TRANSFORM,
                                               CUTSCENE_FINAL_BATTLE_EGG_WIZARD };

static const u16 sOptionalHiddenIslandStageList[SAVE_ISLAND_COUNT] = {
    [SAVE_ISLAND_HIDDEN_ISLAND_3]  = STAGE_HIDDEN_ISLAND_3,  // Formatting Comment
    [SAVE_ISLAND_HIDDEN_ISLAND_4]  = STAGE_HIDDEN_ISLAND_4,  // Formatting Comment
    [SAVE_ISLAND_HIDDEN_ISLAND_5]  = STAGE_HIDDEN_ISLAND_5,  // Formatting Comment
    [SAVE_ISLAND_HIDDEN_ISLAND_6]  = STAGE_HIDDEN_ISLAND_6,  // Formatting Comment
    [SAVE_ISLAND_HIDDEN_ISLAND_7]  = STAGE_HIDDEN_ISLAND_7,  // Formatting Comment
    [SAVE_ISLAND_HIDDEN_ISLAND_8]  = STAGE_HIDDEN_ISLAND_8,  // Formatting Comment
    [SAVE_ISLAND_HIDDEN_ISLAND_9]  = STAGE_HIDDEN_ISLAND_9,  // Formatting Comment
    [SAVE_ISLAND_HIDDEN_ISLAND_10] = STAGE_HIDDEN_ISLAND_10, // Formatting Comment
    [SAVE_ISLAND_HIDDEN_ISLAND_11] = STAGE_HIDDEN_ISLAND_11, // Formatting Comment
    [SAVE_ISLAND_HIDDEN_ISLAND_12] = STAGE_HIDDEN_ISLAND_12, // Formatting Comment
    [SAVE_ISLAND_HIDDEN_ISLAND_13] = STAGE_HIDDEN_ISLAND_13, // Formatting Comment
    [SAVE_ISLAND_HIDDEN_ISLAND_14] = STAGE_HIDDEN_ISLAND_14, // Formatting Comment
    [SAVE_ISLAND_HIDDEN_ISLAND_15] = STAGE_HIDDEN_ISLAND_15, // Formatting Comment
    [SAVE_ISLAND_HIDDEN_ISLAND_16] = STAGE_HIDDEN_ISLAND_16, // Formatting Comment
};

static const SaveUnknown1 sProgressEventList[SAVE_PROGRESSEVENT_COUNT] = {
    [SAVE_PROGRESSEVENT_START_CUTSCENE]          = SaveGame_ProgressEvent_StartCutscene,
    [SAVE_PROGRESSEVENT_START_TUTORIAL]          = SaveGame_ProgressEvent_StartTutorial,
    [SAVE_PROGRESSEVENT_START_SAIL_TRAINING]     = SaveGame_ProgressEvent_StartSailTraining,
    [SAVE_PROGRESSEVENT_START_SAIL_JET_TRAINING] = SaveGame_ProgressEvent_StartSailJetTraining,
    [SAVE_PROGRESSEVENT_RETURN_TO_HUB]           = SaveGame_ProgressEvent_ReturnToHub,
    [SAVE_PROGRESSEVENT_START_DOOR_PUZZLE]       = SaveGame_ProgressEvent_StartDoorPuzzle,
    [SAVE_PROGRESSEVENT_START_SEA_MAP_CUTSCENE]  = SaveGame_ProgressEvent_StartSeaMapCutscene,
    [SAVE_PROGRESSEVENT_START_ISLAND_ARRIVAL]    = SaveGame_ProgressEvent_StartIslandArrival,
};

static const SaveGameNextAction sSaveNextAction_Zone6Progress3[] = {
    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_HIDDEN_ISLAND_2,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_TO_SKY_BABYLON,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_HIDDEN_ISLAND_2,
      .eventType              = SAVE_PROGRESSEVENT_START_SEA_MAP_CUTSCENE,
      .eventParam             = SAVE_SEAMAPCUTSCENE_TO_SKY_BABYLON,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_HIDDEN_ISLAND_2,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_ARRIVAL_AT_SKY_BABYLON,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_HIDDEN_ISLAND_2,
      .eventType              = SAVE_PROGRESSEVENT_START_ISLAND_ARRIVAL,
      .eventParam             = STAGE_Z61,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress2[] = {
    { .type                   = SAVE_PROGRESSTYPE_SEAMAP_CHART_COURSE_MENU,
      .progressCheckValue     = 0,
      .eventType              = SAVE_PROGRESSEVENT_START_SAIL_TRAINING,
      .eventParam             = 0,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_BEGIN_SAILING,
      .progressCheckValue     = SHIP_JET,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_WAVE_CYCLONE_LAUNCH,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_BEGIN_SAILING,
      .progressCheckValue     = SHIP_JET,
      .eventType              = SAVE_PROGRESSEVENT_START_SAIL_JET_TRAINING,
      .eventParam             = 0,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z11,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_ARRIVAL_AT_PLANT_KINGDOM,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const u16 sGameProgressCounterList[SAVE_PROGRESS_COUNT] = {
    [SAVE_PROGRESS_0]  = 9, // Formatting Comment
    [SAVE_PROGRESS_1]  = 2, // Formatting Comment
    [SAVE_PROGRESS_2]  = 4, // Formatting Comment
    [SAVE_PROGRESS_3]  = 1, // Formatting Comment
    [SAVE_PROGRESS_4]  = 1, // Formatting Comment
    [SAVE_PROGRESS_5]  = 1, // Formatting Comment
    [SAVE_PROGRESS_6]  = 1, // Formatting Comment
    [SAVE_PROGRESS_7]  = 1, // Formatting Comment
    [SAVE_PROGRESS_8]  = 0, // Formatting Comment
    [SAVE_PROGRESS_9]  = 0, // Formatting Comment
    [SAVE_PROGRESS_10] = 1, // Formatting Comment
    [SAVE_PROGRESS_11] = 1, // Formatting Comment
    [SAVE_PROGRESS_12] = 1, // Formatting Comment
    [SAVE_PROGRESS_13] = 6, // Formatting Comment
    [SAVE_PROGRESS_14] = 2, // Formatting Comment
    [SAVE_PROGRESS_15] = 3, // Formatting Comment
    [SAVE_PROGRESS_16] = 0, // Formatting Comment
    [SAVE_PROGRESS_17] = 1, // Formatting Comment
    [SAVE_PROGRESS_18] = 1, // Formatting Comment
    [SAVE_PROGRESS_19] = 1, // Formatting Comment
    [SAVE_PROGRESS_20] = 2, // Formatting Comment
    [SAVE_PROGRESS_21] = 0, // Formatting Comment
    [SAVE_PROGRESS_22] = 0, // Formatting Comment
    [SAVE_PROGRESS_23] = 1, // Formatting Comment
    [SAVE_PROGRESS_24] = 0, // Formatting Comment
    [SAVE_PROGRESS_25] = 0, // Formatting Comment
    [SAVE_PROGRESS_26] = 1, // Formatting Comment
    [SAVE_PROGRESS_27] = 1, // Formatting Comment
    [SAVE_PROGRESS_28] = 2, // Formatting Comment
    [SAVE_PROGRESS_29] = 1, // Formatting Comment
    [SAVE_PROGRESS_30] = 0, // Formatting Comment
    [SAVE_PROGRESS_31] = 1, // Formatting Comment
    [SAVE_PROGRESS_32] = 4, // Formatting Comment
    [SAVE_PROGRESS_33] = 1, // Formatting Comment
    [SAVE_PROGRESS_34] = 4, // Formatting Comment
    [SAVE_PROGRESS_35] = 0, // Formatting Comment
    [SAVE_PROGRESS_36] = 0, // Formatting Comment
    [SAVE_PROGRESS_37] = 0, // Formatting Comment
    [SAVE_PROGRESS_38] = 0, // Formatting Comment
    [SAVE_PROGRESS_39] = 0, // Formatting Comment
};

static const u16 sLandedIslandStageTable[42] = {
    [SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND]   = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM]     = STAGE_Z11,
    [SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH] = STAGE_Z21,
    [SEAMAPMANAGER_DISCOVER_CORAL_CAVE]        = STAGE_Z31,
    [SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP]      = STAGE_Z41,
    [SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS]    = STAGE_Z51,
    [SEAMAPMANAGER_DISCOVER_SKY_BABYLON]       = STAGE_Z61,
    [SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND]    = STAGE_Z71,
    [SEAMAPMANAGER_DISCOVER_BIG_SWELL]         = STAGE_BOSS_FINAL,
    [SEAMAPMANAGER_DISCOVER_DEEP_CORE]         = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_1]   = STAGE_HIDDEN_ISLAND_1,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2]   = STAGE_HIDDEN_ISLAND_2,
    [SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND]     = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_13]                = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND]      = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_3]   = STAGE_HIDDEN_ISLAND_3,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_4]   = STAGE_HIDDEN_ISLAND_4,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_5]   = STAGE_HIDDEN_ISLAND_5,
    [SEAMAPMANAGER_DISCOVER_18]                = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_19]                = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_20]                = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_21]                = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_6]   = STAGE_HIDDEN_ISLAND_6,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_7]   = STAGE_HIDDEN_ISLAND_7,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_8]   = STAGE_HIDDEN_ISLAND_8,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_9]   = STAGE_HIDDEN_ISLAND_9,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_10]  = STAGE_HIDDEN_ISLAND_10,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_11]  = STAGE_HIDDEN_ISLAND_11,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_12]  = STAGE_HIDDEN_ISLAND_12,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_13]  = STAGE_HIDDEN_ISLAND_13,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_14]  = STAGE_HIDDEN_ISLAND_14,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_15]  = STAGE_HIDDEN_ISLAND_15,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_16]  = STAGE_HIDDEN_ISLAND_16,
    [SEAMAPMANAGER_DISCOVER_33]                = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_34]                = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_35]                = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_36]                = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_37]                = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_38]                = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_39]                = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_40]                = STAGE_NONE,
    [SEAMAPMANAGER_DISCOVER_41]                = STAGE_NONE,
};

static const u16 sZoneNextStageTable[STAGE_COUNT] = {
    [STAGE_Z11]               = STAGE_Z12,
    [STAGE_Z12]               = STAGE_Z1B,
    [STAGE_TUTORIAL]          = STAGE_TUTORIAL,
    [STAGE_Z1B]               = STAGE_Z1B,
    [STAGE_Z21]               = STAGE_Z22,
    [STAGE_Z22]               = STAGE_Z2B,
    [STAGE_Z2B]               = STAGE_Z2B,
    [STAGE_Z31]               = STAGE_Z32,
    [STAGE_Z32]               = STAGE_Z3B,
    [STAGE_HIDDEN_ISLAND_1]   = STAGE_HIDDEN_ISLAND_1,
    [STAGE_Z3B]               = STAGE_Z3B,
    [STAGE_Z41]               = STAGE_Z42,
    [STAGE_Z42]               = STAGE_Z4B,
    [STAGE_Z4B]               = STAGE_Z4B,
    [STAGE_Z51]               = STAGE_Z52,
    [STAGE_Z52]               = STAGE_Z5B,
    [STAGE_Z5B]               = STAGE_Z5B,
    [STAGE_Z61]               = STAGE_Z62,
    [STAGE_Z62]               = STAGE_Z6B,
    [STAGE_HIDDEN_ISLAND_2]   = STAGE_HIDDEN_ISLAND_2,
    [STAGE_Z6B]               = STAGE_Z6B,
    [STAGE_Z71]               = STAGE_Z72,
    [STAGE_Z72]               = STAGE_Z7B,
    [STAGE_Z7B]               = STAGE_Z7B,
    [STAGE_BOSS_FINAL]        = STAGE_BOSS_FINAL,
    [STAGE_HIDDEN_ISLAND_3]   = STAGE_HIDDEN_ISLAND_3,
    [STAGE_HIDDEN_ISLAND_4]   = STAGE_HIDDEN_ISLAND_4,
    [STAGE_HIDDEN_ISLAND_5]   = STAGE_HIDDEN_ISLAND_5,
    [STAGE_HIDDEN_ISLAND_6]   = STAGE_HIDDEN_ISLAND_6,
    [STAGE_HIDDEN_ISLAND_7]   = STAGE_HIDDEN_ISLAND_7,
    [STAGE_HIDDEN_ISLAND_8]   = STAGE_HIDDEN_ISLAND_8,
    [STAGE_HIDDEN_ISLAND_9]   = STAGE_HIDDEN_ISLAND_9,
    [STAGE_HIDDEN_ISLAND_10]  = STAGE_HIDDEN_ISLAND_10,
    [STAGE_HIDDEN_ISLAND_11]  = STAGE_HIDDEN_ISLAND_11,
    [STAGE_HIDDEN_ISLAND_12]  = STAGE_HIDDEN_ISLAND_12,
    [STAGE_HIDDEN_ISLAND_13]  = STAGE_HIDDEN_ISLAND_13,
    [STAGE_HIDDEN_ISLAND_14]  = STAGE_HIDDEN_ISLAND_14,
    [STAGE_HIDDEN_ISLAND_15]  = STAGE_HIDDEN_ISLAND_15,
    [STAGE_HIDDEN_ISLAND_16]  = STAGE_HIDDEN_ISLAND_16,
    [STAGE_HIDDEN_ISLAND_VS1] = STAGE_HIDDEN_ISLAND_VS1,
    [STAGE_HIDDEN_ISLAND_VS2] = STAGE_HIDDEN_ISLAND_VS2,
    [STAGE_HIDDEN_ISLAND_VS3] = STAGE_HIDDEN_ISLAND_VS3,
    [STAGE_HIDDEN_ISLAND_VS4] = STAGE_HIDDEN_ISLAND_VS4,
    [STAGE_HIDDEN_ISLAND_R1]  = STAGE_Z11,
    [STAGE_HIDDEN_ISLAND_R2]  = STAGE_Z11,
    [STAGE_HIDDEN_ISLAND_R3]  = STAGE_Z11,
};

static const StageProgressCheck sStageProgressCheckList[STAGE_COUNT_NON_OPTIONAL] = {
    [STAGE_Z11] = { .gameProgress  = SAVE_PROGRESS_3,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_ACT1 },

    [STAGE_Z12] = { .gameProgress  = SAVE_PROGRESS_3,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_ACT2 },

    [STAGE_TUTORIAL] = { .gameProgress  = SAVE_PROGRESS_0,
                         .zone5Progress = SAVE_PROGRESS_INVALID,
                         .zone6Progress = SAVE_PROGRESS_INVALID,
                         .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_NONE },

    [STAGE_Z1B] = { .gameProgress  = SAVE_PROGRESS_4,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_NONE },

    [STAGE_Z21] = { .gameProgress  = SAVE_PROGRESS_6,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_ACT1 },

    [STAGE_Z22] = { .gameProgress  = SAVE_PROGRESS_6,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_ACT2 },

    [STAGE_Z2B] = { .gameProgress  = SAVE_PROGRESS_7,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_NONE },

    [STAGE_Z31] = { .gameProgress  = SAVE_PROGRESS_14,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_ACT1 },

    [STAGE_Z32] = { .gameProgress  = SAVE_PROGRESS_14,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_ACT2 },

    [STAGE_HIDDEN_ISLAND_1] = { .gameProgress  = SAVE_PROGRESS_13,
                                .zone5Progress = SAVE_PROGRESS_INVALID,
                                .zone6Progress = SAVE_PROGRESS_INVALID,
                                .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_NONE },

    [STAGE_Z3B] = { .gameProgress  = SAVE_PROGRESS_15,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_NONE },

    [STAGE_Z41] = { .gameProgress  = SAVE_PROGRESS_19,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_ACT1 },

    [STAGE_Z42] = { .gameProgress  = SAVE_PROGRESS_19,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_ACT2 },

    [STAGE_Z4B] = { .gameProgress  = SAVE_PROGRESS_20,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_NONE },

    [STAGE_Z51] = { .gameProgress  = SAVE_PROGRESS_INVALID,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_2,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_ZONE_5ACT1 },

    [STAGE_Z52] = { .gameProgress  = SAVE_PROGRESS_INVALID,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_2,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_ZONE_5ACT2 },

    [STAGE_Z5B] = { .gameProgress  = SAVE_PROGRESS_INVALID,
                    .zone5Progress = SAVE_ZONE5_PROGRESS_3,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_NONE },

    [STAGE_Z61] = { .gameProgress  = SAVE_PROGRESS_INVALID,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_4,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_ZONE_6ACT1 },

    [STAGE_Z62] = { .gameProgress  = SAVE_PROGRESS_INVALID,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_4,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_ZONE_6ACT2 },

    [STAGE_HIDDEN_ISLAND_2] = { .gameProgress  = SAVE_PROGRESS_INVALID,
                                .zone5Progress = SAVE_PROGRESS_INVALID,
                                .zone6Progress = SAVE_ZONE6_PROGRESS_3,
                                .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_NONE },

    [STAGE_Z6B] = { .gameProgress  = SAVE_PROGRESS_INVALID,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_ZONE6_PROGRESS_5,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_NONE },

    [STAGE_Z71] = { .gameProgress  = SAVE_PROGRESS_33,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_ACT1 },

    [STAGE_Z72] = { .gameProgress  = SAVE_PROGRESS_33,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_ACT2 },

    [STAGE_Z7B] = { .gameProgress  = SAVE_PROGRESS_34,
                    .zone5Progress = SAVE_PROGRESS_INVALID,
                    .zone6Progress = SAVE_PROGRESS_INVALID,
                    .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_NONE },

    [STAGE_BOSS_FINAL] = { .gameProgress  = SAVE_PROGRESS_35,
                           .zone5Progress = SAVE_PROGRESS_INVALID,
                           .zone6Progress = SAVE_PROGRESS_INVALID,
                           .extraCheck    = SAVE_STAGECLEAR_EXTRACHECK_ANY_NONE },
};

static const SaveGameNextAction sSaveNextAction_Progress3[] = {
    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z1B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_GHOST_REX_APPOACHES,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Zone6Progress2[] = {
    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_HIDDEN_ISLAND_2,
      .eventType              = SAVE_PROGRESSEVENT_NO_CHECK,
      .eventParam             = 0,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Zone6Progress1[] = {
    { .type                   = SAVE_PROGRESSTYPE_NON_STAGE_ISLAND_ARRIVAL,
      .progressCheckValue     = SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_DAIKUN_DISCOVERED,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress6[] = {
    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z2B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_IMPOSING_GHOST_PENDULUM,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress27[] = {
    { .type                   = SAVE_PROGRESSTYPE_BEGIN_SAILING,
      .progressCheckValue     = SHIP_SUBMARINE,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_DEEP_TYPHOON_LAUNCH,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress10[] = {
    { .type                   = SAVE_PROGRESSTYPE_BEGIN_SAILING,
      .progressCheckValue     = SHIP_BOAT,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_OCEAN_TORNADO_LAUNCH,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress4[] = {
    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_Z1B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_FOUND_GREEN_MATERIAL,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress34[] = {
    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_Z7B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_AFTER_THEM,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_Z7B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_ARRIVAL_AT_BIG_SWELL,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_Z7B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_DUEL_WITH_GHOST_TITAN,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_Z7B,
      .eventType              = SAVE_PROGRESSEVENT_START_ISLAND_ARRIVAL,
      .eventParam             = STAGE_BOSS_FINAL,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress0[] = {
    { .type                   = SAVE_PROGRESSTYPE_NO_CHECK,
      .progressCheckValue     = 0,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_OPENING,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_NO_CHECK,
      .progressCheckValue     = 0,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_MARINE_APPEARS,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_NO_CHECK,
      .progressCheckValue     = 0,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_ENCOUNTER,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_NO_CHECK,
      .progressCheckValue     = 0,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_RICKETY_SHIP_LAUNCH,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_NO_CHECK,
      .progressCheckValue     = 0,
      .eventType              = SAVE_PROGRESSEVENT_RETURN_TO_HUB,
      .eventParam             = 0,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_NO_CHECK,
      .progressCheckValue     = 0,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_GET_THE_MATERIAL,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_NO_CHECK,
      .progressCheckValue     = 0,
      .eventType              = SAVE_PROGRESSEVENT_START_TUTORIAL,
      .eventParam             = 0,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_NO_CHECK,
      .progressCheckValue     = 0,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_FOUND_MATERIAL,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_NO_CHECK,
      .progressCheckValue     = 0,
      .eventType              = SAVE_PROGRESSEVENT_RETURN_TO_HUB,
      .eventParam             = 0,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = FALSE },
};

static const SaveGameNextAction sSaveNextAction_Progress14[] = {
    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z3B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_WHISKER_APPEARS_3D,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z3B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_REUNION_3D,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveUnknown2 sProgressUpdateEventList[SAVE_PROGRESSTYPE_COUNT] = {
    [SAVE_PROGRESSTYPE_RETURN_TO_HUB]            = SaveGame_ProgressUpdateEvent_ReturnToHub,
    [SAVE_PROGRESSTYPE_SEAMAP_CHART_COURSE_MENU] = SaveGame_ProgressUpdateEvent_SeaMapChartCourseMenu,
    [SAVE_PROGRESSTYPE_BEGIN_SAILING]            = SaveGame_ProgressUpdateEvent_BeginSailing,
    [SAVE_PROGRESSTYPE_ISLAND_ARRIVAL]           = SaveGame_ProgressUpdateEvent_IslandArrival,
    [SAVE_PROGRESSTYPE_ADVANCE_STAGE]            = SaveGame_ProgressUpdateEvent_AdvanceStage,
    [SAVE_PROGRESSTYPE_STAGE_CLEAR]              = SaveGame_ProgressUpdateEvent_StageClear,
    [SAVE_PROGRESSTYPE_BEGIN_RIVAL_RACE]         = SaveGame_ProgressUpdateEvent_BeginRivalRace,
    [SAVE_PROGRESSTYPE_FINISH_RIVAL_RACE]        = SaveGame_ProgressUpdateEvent_FinishRivalRace,
    [SAVE_PROGRESSTYPE_EX_PROLOGUE]              = SaveGame_ProgressUpdateEvent_ExPrologue,
    [SAVE_PROGRESSTYPE_EX_EPILOGUE]              = SaveGame_ProgressUpdateEvent_ExEpilogue,
    [SAVE_PROGRESSTYPE_DOOR_PUZZLE_COMPLETE]     = SaveGame_ProgressUpdateEvent_DoorPuzzleComplete,
    [SAVE_PROGRESSTYPE_NON_STAGE_ISLAND_ARRIVAL] = SaveGame_ProgressUpdateEvent_NonStageIslandArrival,
};

static const SaveGameNextAction sSaveNextAction_Progress17[] = {
    { .type                   = SAVE_PROGRESSTYPE_NON_STAGE_ISLAND_ARRIVAL,
      .progressCheckValue     = SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_KYLOK_FOUND,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress18[] = {
    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z41,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_ARRIVAL_AT_HAUNTED_SHIP,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress19[] = {
    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z4B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_HAIR_RAISING_GHOST_PIRATE,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress23[] = {
    { .type                   = SAVE_PROGRESSTYPE_BEGIN_SAILING,
      .progressCheckValue     = SHIP_HOVER,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_AQUA_BLAST_LAUNCH,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress29[] = {
    { .type                   = SAVE_PROGRESSTYPE_RETURN_TO_HUB,
      .progressCheckValue     = TRUE,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_COLLECTED_THE_CLUES,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress5[] = {
    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z21,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_ARRIVAL_AT_MACHINE_LABYRINTH,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress33[] = {
    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z7B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_CLASH_WITH_WHISKER_AND_JOHNNY,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress12[] = {
    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_HIDDEN_ISLAND_1,
      .eventType              = SAVE_PROGRESSEVENT_NO_CHECK,
      .eventParam             = 0,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress13[] = {
    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_HIDDEN_ISLAND_1,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_CORAL_CAVE_SURFACES_PART1,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_HIDDEN_ISLAND_1,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_CORAL_CAVE_APPEARS,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_HIDDEN_ISLAND_1,
      .eventType              = SAVE_PROGRESSEVENT_START_SEA_MAP_CUTSCENE,
      .eventParam             = SAVE_SEAMAPCUTSCENE_CORAL_CAVE_APPEARS,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_HIDDEN_ISLAND_1,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_CORAL_CAVE_SURFACES_PART2,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_HIDDEN_ISLAND_1,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_ARRIVAL_AT_CORAL_CAVE,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_HIDDEN_ISLAND_1,
      .eventType              = SAVE_PROGRESSEVENT_START_ISLAND_ARRIVAL,
      .eventParam             = STAGE_Z31,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress1[] = {
    { .type                   = SAVE_PROGRESSTYPE_RETURN_TO_HUB,
      .progressCheckValue     = FALSE,
      .eventType              = SAVE_PROGRESSEVENT_RETURN_TO_HUB,
      .eventParam             = 0,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = FALSE },

    { .type                   = SAVE_PROGRESSTYPE_RETURN_TO_HUB,
      .progressCheckValue     = FALSE,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_WAVE_CYCLONE_COMPLETE,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress15[] = {
    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_Z3B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_THIS_IS_BLAZES_WORLD,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_Z3B,
      .eventType              = SAVE_PROGRESSEVENT_RETURN_TO_HUB,
      .eventParam             = 0,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_RETURN_TO_HUB,
      .progressCheckValue     = FALSE,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_BUILDING_A_RADIO_TOWER,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress7[] = {
    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_Z2B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_FOUND_BRONZE_MATERIAL,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Zone6Progress5[] = {
    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_Z6B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_LEGENDARY_ANCIENT_RUINS_2,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Zone5Progress1[] = {
    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z51,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_ARRIVAL_AT_BLIZZARD_PEAKS,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress20[] = {
    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_Z4B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = 0x22,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_Z4B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_HOVER_WHAT_BOAT,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Zone5Progress3[] = {
    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_Z5B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_LEGENDARY_ANCIENT_RUINS_1,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress11[] = {
    { .type                   = SAVE_PROGRESSTYPE_BEGIN_RIVAL_RACE,
      .progressCheckValue     = 0,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_JOHNNY_APPEARS,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress28[] = {
    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z71,
      .eventType              = SAVE_PROGRESSEVENT_START_DOOR_PUZZLE,
      .eventParam             = 0,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_RETURN_TO_HUB,
      .progressCheckValue     = FALSE,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_PIRATES_ISLAND_DISCOVERED,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Zone6Progress4[] = {
    { .type                   = SAVE_PROGRESSTYPE_STAGE_CLEAR,
      .progressCheckValue     = STAGE_Z62,
      .eventType              = SAVE_PROGRESSEVENT_NO_CHECK,
      .eventParam             = 0,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Zone5Progress2[] = {
    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z5B,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_FREEZING_GHOST_WHALE,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress32[] = {
    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z71,
      .eventType              = SAVE_PROGRESSEVENT_START_DOOR_PUZZLE,
      .eventParam             = 1,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = FALSE },

    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z71,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_ARRIVAL_AT_PIRATES_ISLAND_ENTRANCE,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z71,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_ARRIVAL_AT_PIRATES_ISLAND_DOOR,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },

    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z71,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_ARRIVAL_AT_PIRATES_ISLAND_ARRIVAL,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveGameNextAction sSaveNextAction_Progress31[] = {
    { .type                   = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL,
      .progressCheckValue     = STAGE_Z71,
      .eventType              = SAVE_PROGRESSEVENT_START_CUTSCENE,
      .eventParam             = CUTSCENE_INVADING_PIRATES_ISLAND,
      .nextSysEvent           = SYSEVENT_NONE,
      .allowProgressIncrement = TRUE },
};

static const SaveProgressCheck sProgressCheckTable[] = {
    [SAVE_PROGRESSTYPE_RETURN_TO_HUB]            = SaveGame_ProgressCheck_ReturnToHub,
    [SAVE_PROGRESSTYPE_SEAMAP_CHART_COURSE_MENU] = SaveGame_ProgressCheck_SeaMapChartCourseMenu,
    [SAVE_PROGRESSTYPE_BEGIN_SAILING]            = SaveGame_ProgressCheck_BeginSailing,
    [SAVE_PROGRESSTYPE_ISLAND_ARRIVAL]           = SaveGame_ProgressCheck_IslandArrival,
    [SAVE_PROGRESSTYPE_ADVANCE_STAGE]            = SaveGame_ProgressCheck_AdvanceStage,
    [SAVE_PROGRESSTYPE_STAGE_CLEAR]              = SaveGame_ProgressCheck_StageClear,
    [SAVE_PROGRESSTYPE_BEGIN_RIVAL_RACE]         = SaveGame_ProgressCheck_BeginRivalRace,
    [SAVE_PROGRESSTYPE_FINISH_RIVAL_RACE]        = SaveGame_ProgressCheck_FinishRivalRace,
    [SAVE_PROGRESSTYPE_EX_PROLOGUE]              = SaveGame_ProgressCheck_ExPrologue,
    [SAVE_PROGRESSTYPE_EX_EPILOGUE]              = SaveGame_ProgressCheck_ExEpilogue,
    [SAVE_PROGRESSTYPE_DOOR_PUZZLE_COMPLETE]     = SaveGame_ProgressCheck_DoorPuzzleComplete,
    [SAVE_PROGRESSTYPE_NON_STAGE_ISLAND_ARRIVAL] = SaveGame_ProgressCheck_NonStageIslandArrival,
};

static const SaveGameNextAction *sGameProgressUnknown[SAVE_PROGRESS_COUNT] = {
    [SAVE_PROGRESS_0]  = sSaveNextAction_Progress0,  // Formatting Comment
    [SAVE_PROGRESS_1]  = sSaveNextAction_Progress1,  // Formatting Comment
    [SAVE_PROGRESS_2]  = sSaveNextAction_Progress2,  // Formatting Comment
    [SAVE_PROGRESS_3]  = sSaveNextAction_Progress3,  // Formatting Comment
    [SAVE_PROGRESS_4]  = sSaveNextAction_Progress4,  // Formatting Comment
    [SAVE_PROGRESS_5]  = sSaveNextAction_Progress5,  // Formatting Comment
    [SAVE_PROGRESS_6]  = sSaveNextAction_Progress6,  // Formatting Comment
    [SAVE_PROGRESS_7]  = sSaveNextAction_Progress7,  // Formatting Comment
    [SAVE_PROGRESS_8]  = NULL,                       // Formatting Comment
    [SAVE_PROGRESS_9]  = NULL,                       // Formatting Comment
    [SAVE_PROGRESS_10] = sSaveNextAction_Progress10, // Formatting Comment
    [SAVE_PROGRESS_11] = sSaveNextAction_Progress11, // Formatting Comment
    [SAVE_PROGRESS_12] = sSaveNextAction_Progress12, // Formatting Comment
    [SAVE_PROGRESS_13] = sSaveNextAction_Progress13, // Formatting Comment
    [SAVE_PROGRESS_14] = sSaveNextAction_Progress14, // Formatting Comment
    [SAVE_PROGRESS_15] = sSaveNextAction_Progress15, // Formatting Comment
    [SAVE_PROGRESS_16] = NULL,                       // Formatting Comment
    [SAVE_PROGRESS_17] = sSaveNextAction_Progress17, // Formatting Comment
    [SAVE_PROGRESS_18] = sSaveNextAction_Progress18, // Formatting Comment
    [SAVE_PROGRESS_19] = sSaveNextAction_Progress19, // Formatting Comment
    [SAVE_PROGRESS_20] = sSaveNextAction_Progress20, // Formatting Comment
    [SAVE_PROGRESS_21] = NULL,                       // Formatting Comment
    [SAVE_PROGRESS_22] = NULL,                       // Formatting Comment
    [SAVE_PROGRESS_23] = sSaveNextAction_Progress23, // Formatting Comment
    [SAVE_PROGRESS_24] = NULL,                       // Formatting Comment
    [SAVE_PROGRESS_25] = NULL,                       // Formatting Comment
    [SAVE_PROGRESS_26] = NULL,                       // Formatting Comment
    [SAVE_PROGRESS_27] = sSaveNextAction_Progress27, // Formatting Comment
    [SAVE_PROGRESS_28] = sSaveNextAction_Progress28, // Formatting Comment
    [SAVE_PROGRESS_29] = sSaveNextAction_Progress29, // Formatting Comment
    [SAVE_PROGRESS_30] = NULL,                       // Formatting Comment
    [SAVE_PROGRESS_31] = sSaveNextAction_Progress31, // Formatting Comment
    [SAVE_PROGRESS_32] = sSaveNextAction_Progress32, // Formatting Comment
    [SAVE_PROGRESS_33] = sSaveNextAction_Progress33, // Formatting Comment
    [SAVE_PROGRESS_34] = sSaveNextAction_Progress34, // Formatting Comment
    [SAVE_PROGRESS_35] = NULL,                       // Formatting Comment
    [SAVE_PROGRESS_36] = NULL,                       // Formatting Comment
    [SAVE_PROGRESS_37] = NULL,                       // Formatting Comment
    [SAVE_PROGRESS_38] = NULL,                       // Formatting Comment
    [SAVE_PROGRESS_39] = NULL,                       // Formatting Comment
};

static const SaveGameNextAction *sZone5ProgressUnknown[SAVE_ZONE5_PROGRESS_COUNT] = {
    [SAVE_ZONE5_PROGRESS_0] = NULL,                           // Formatting Comment
    [SAVE_ZONE5_PROGRESS_1] = sSaveNextAction_Zone5Progress1, // Formatting Comment
    [SAVE_ZONE5_PROGRESS_2] = sSaveNextAction_Zone5Progress2, // Formatting Comment
    [SAVE_ZONE5_PROGRESS_3] = sSaveNextAction_Zone5Progress3, // Formatting Comment
    [SAVE_ZONE5_PROGRESS_4] = NULL                            // Formatting Comment
};

static const SaveGameNextAction *sZone6ProgressUnknown[SAVE_ZONE6_PROGRESS_COUNT] = {
    [SAVE_ZONE6_PROGRESS_0] = NULL,                           // Formatting Comment
    [SAVE_ZONE6_PROGRESS_1] = sSaveNextAction_Zone6Progress1, // Formatting Comment
    [SAVE_ZONE6_PROGRESS_2] = sSaveNextAction_Zone6Progress2, // Formatting Comment
    [SAVE_ZONE6_PROGRESS_3] = sSaveNextAction_Zone6Progress3, // Formatting Comment
    [SAVE_ZONE6_PROGRESS_4] = sSaveNextAction_Zone6Progress4, // Formatting Comment
    [SAVE_ZONE6_PROGRESS_5] = sSaveNextAction_Zone6Progress5, // Formatting Comment
    [SAVE_ZONE6_PROGRESS_6] = NULL                            // Formatting Comment
};

// --------------------
// FUNCTIONS
// --------------------

void SaveGame__UpdateProgressEvent(void)
{
    SaveGame__UpdateProgress();
}

void SaveGame__SetProgressType(s32 type)
{
    gameState.saveFile.progressType = type;
}

SaveProgress SaveGame__GetGameProgress(void)
{
    return saveGame.stage.progress.gameProgress;
}

void SaveGame__SetGameProgress(SaveProgress progress)
{
    saveGame.stage.progress.gameProgress = progress;
    gameState.saveFile.progressCounter   = 0;

    if (progress < SAVE_PROGRESS_24)
    {
        saveGame.stage.progress.zone5Progress = SAVE_ZONE5_PROGRESS_0;
        saveGame.stage.progress.zone6Progress = SAVE_ZONE6_PROGRESS_0;
    }
    else if (progress >= SAVE_PROGRESS_25)
    {
        saveGame.stage.progress.zone5Progress = SAVE_ZONE5_PROGRESS_4;
        saveGame.stage.progress.zone6Progress = SAVE_ZONE6_PROGRESS_6;
    }
    else
    {
        if (saveGame.stage.progress.zone5Progress == SAVE_ZONE5_PROGRESS_0)
            saveGame.stage.progress.zone5Progress = SAVE_ZONE5_PROGRESS_1;

        if (saveGame.stage.progress.zone6Progress == SAVE_ZONE6_PROGRESS_0)
            saveGame.stage.progress.zone6Progress = SAVE_ZONE6_PROGRESS_1;
    }

    if (progress < SAVE_PROGRESS_29)
    {
        saveGame.stage.progress.flags &= ~(SAVE_PROGRESSFLAG_HAS_DOOR_PUZZLE_PIECE_1 | SAVE_PROGRESSFLAG_HAS_DOOR_PUZZLE_PIECE_2 | SAVE_PROGRESSFLAG_HAS_DOOR_PUZZLE_PIECE_3);
    }
    else if (progress >= SAVE_PROGRESS_30)
    {
        saveGame.stage.progress.flags |= (SAVE_PROGRESSFLAG_HAS_DOOR_PUZZLE_PIECE_1 | SAVE_PROGRESSFLAG_HAS_DOOR_PUZZLE_PIECE_2 | SAVE_PROGRESSFLAG_HAS_DOOR_PUZZLE_PIECE_3);
    }

    if (progress <= SAVE_PROGRESS_17)
        saveGame.stage.progress.flags &= ~SAVE_PROGRESSFLAG_UNLOCKED_MOVIE_LIST;

    SaveGame__RemoveProgressFlags_ZoneAct1Clear();
    SaveGame__RemoveProgressFlags_Zone5Act1Clear();
    SaveGame__RemoveProgressFlags_Zone6Act1Clear();

    if (progress >= SAVE_PROGRESS_2)
        saveGame.stage.progress.flags |= SAVE_PROGRESSFLAG_HAS_SAVED;
    else
        saveGame.stage.progress.flags &= ~SAVE_PROGRESSFLAG_HAS_SAVED;

    saveGame.stage.progress.flags &= ~(SAVE_PROGRESSFLAG_BOUGHT_HINT_1 | SAVE_PROGRESSFLAG_BOUGHT_HINT_2 | SAVE_PROGRESSFLAG_BOUGHT_HINT_3);

    SaveGame__ApplySystemProgress();
}

u8 SaveGame__GetProgressCounter(void)
{
    return gameState.saveFile.progressCounter;
}

SaveProgressZone5 SaveGame__GetZone5Progress(void)
{
    return saveGame.stage.progress.zone5Progress;
}

void SaveGame__SetZone5Progress(SaveProgressZone5 progress)
{
    saveGame.stage.progress.zone5Progress = progress;
    gameState.saveFile.progressCounter    = 0;
    saveGame.stage.progress.flags &= ~SAVE_PROGRESSFLAG_INCREMENTED_ZONE6_PROGRESS;

    SaveGame__RemoveProgressFlags_Zone5Act1Clear();
    SaveGame__ApplySystemProgress();
}

SaveProgressZone6 SaveGame__GetZone6Progress(void)
{
    return saveGame.stage.progress.zone6Progress;
}

void SaveGame__SetZone6Progress(SaveProgressZone6 progress)
{
    saveGame.stage.progress.zone6Progress = progress;
    gameState.saveFile.progressCounter    = 0;
    saveGame.stage.progress.flags |= SAVE_PROGRESSFLAG_INCREMENTED_ZONE6_PROGRESS;

    SaveGame__RemoveProgressFlags_Zone6Act1Clear();
    SaveGame__ApplySystemProgress();
}

void SaveGame__IncrementUnknown2ForUnknown(void)
{
    gameState.saveFile.progressCounter++;
}

BOOL SaveGame__HasDoorPuzzlePiece(u16 id)
{
    return (saveGame.stage.progress.flags & (SAVE_PROGRESSFLAG_HAS_DOOR_PUZZLE_PIECE_1 << id)) != 0;
}

void SaveGame__GetPuzzlePiece(u16 id)
{
    saveGame.stage.progress.flags |= (SAVE_PROGRESSFLAG_HAS_DOOR_PUZZLE_PIECE_1 << id);
    SaveGame__ApplySystemProgress();
}

void SaveGame__UpdateProgressForZone5Zone6Cleared(void)
{
    SaveGame__SetGameProgress(SAVE_PROGRESS_25);
}

void SaveGame__UpdateProgressForAllDoorPuzzleKeysCollected(void)
{
    SaveGame__SetGameProgress(SAVE_PROGRESS_31);
}

void SaveGame__UpdateProgressForDockFirstVisited(u32 type)
{
    switch (type)
    {
        case SHIP_BOAT - 1:
            SaveGame__SetGameProgress(SAVE_PROGRESS_10);
            break;

        case SHIP_HOVER - 1:
            SaveGame__SetGameProgress(SAVE_PROGRESS_23);
            break;

        case SHIP_SUBMARINE - 1:
            SaveGame__SetGameProgress(SAVE_PROGRESS_27);
            break;
    }
}

BOOL SaveGame__CheckCollectedAllEmeraldsEvent(void)
{
    SaveBlockChart *chartSave = &saveGame.chart;
    SaveBlockStage *stageSave = &saveGame.stage;

    if (SaveGame__GetGameProgress() != SAVE_PROGRESS_36)
        return FALSE;

    if (SaveGame__GetChaosEmeraldCount(chartSave) >= 7 && SaveGame__GetSolEmeraldCount(stageSave) >= 7)
    {
        SaveGame__SetGameProgress(SAVE_PROGRESS_37);
        return TRUE;
    }

    return FALSE;
}

void SaveGame__SetMissionStatus(u16 id, MissionState status)
{
    u32 state = saveGame.stage.missionState[id / 4];
    u32 shift = (id % 4) << 1;

    state &= ~(MISSION_STATE_COMPLETED << shift);
    saveGame.stage.missionState[id / 4] = state | (status << shift);
}

MissionState SaveGame__GetMissionStatus(u16 id)
{
    return (saveGame.stage.missionState[id / 4] >> ((id % 4) << 1)) & 3;
}

void SaveGame__SetMissionAttempted(u16 id, BOOL attempted)
{
    u32 shift = (id % 8);
    if (attempted)
        saveGame.stage.missionAttemptState[id / 8] |= (1 << shift);
    else
        saveGame.stage.missionAttemptState[id / 8] &= ~(1 << shift);
}

BOOL SaveGame__GetMissionAttempted(u16 id)
{
    return (saveGame.stage.missionAttemptState[id / 8] & (1 << (id % 8))) != 0;
}

u16 SaveGame__GetSystemGameProgress(void)
{
    return saveGame.system.progress.gameProgress;
}

void SaveGame__GsExit(u16 value)
{
    gameState.saveFile.field_52 = value;
}

void SaveGame__UnlockShip(u16 shipID, u16 shipLevel)
{
    u32 id = SAVE_PROGRESSFLAG_UPGRADED_SHIP_LV1_JET << (2 * shipID) << (shipLevel - 1);

    SaveGameProgress *progress = &saveGame.stage.progress;

    if (shipLevel == SHIP_LEVEL_2 && (progress->flags & (id >> 1)) == 0)
        progress->flags |= id >> 1;

    progress->flags |= id;

    SaveGame__ApplySystemProgress();
}

BOOL SaveGame__GetNextShipUpgrade(u16 *ship, u16 *level)
{
    if (SaveGame__GetGameProgress() < SAVE_PROGRESS_36)
        return FALSE;

    if (SaveGame__GetShipUpgradeStatus(SHIP_SUBMARINE) >= 2)
        return FALSE;

    if (SaveGame__GetShipUpgradeStatus(SHIP_SUBMARINE) == 0)
    {
        for (s32 id = 0; id < SHIP_COUNT; id++)
        {
            if (SaveGame__GetShipUpgradeStatus(id) == SHIP_LEVEL_0)
            {
                if (ship != NULL)
                    *ship = id;

                if (level != NULL)
                    *level = SHIP_LEVEL_1;

                return TRUE;
            }
        }
    }
    else
    {
        for (s32 id = 0; id < SHIP_COUNT; id++)
        {
            if (SaveGame__GetShipUpgradeStatus(id) == SHIP_LEVEL_1)
            {
                if (ship != NULL)
                    *ship = id;

                if (level != NULL)
                    *level = SHIP_LEVEL_2;

                return TRUE;
            }
        }
    }

    return FALSE;
}

BOOL SaveGame__Func_205BEDC(void)
{
    if (!SaveGame__GetStateFlag(2))
        return FALSE;

    SaveGame__DisableStateFlags(2);
    return TRUE;
}

void SaveGame_SetPlayerHasSavedFlag(void)
{
    saveGame.stage.progress.flags |= SAVE_PROGRESSFLAG_HAS_SAVED;
    SaveGame__ApplySystemProgress();
}

BOOL SaveGame_CheckPlayerHasSavedFlag(void)
{
    if (saveGame.stage.progress.gameProgress >= SAVE_PROGRESS_2)
        return TRUE;

    if (saveGame.stage.progress.gameProgress < SAVE_PROGRESS_1)
        return FALSE;

    return (saveGame.system.progress.flags & SAVE_PROGRESSFLAG_HAS_SAVED) != 0;
}

void SaveGame__SetDoneFirstShipVoyage(s32 id)
{
    SaveGame__EnableStateFlags(4 << id);
}

BOOL SaveGame__HasDoneFirstShipVoyage(s32 id)
{
    if (id == SHIP_JET)
        return TRUE;

    return SaveGame__GetStateFlag(4 << id);
}

void SaveGame__ClearCallback_Stage(SaveGame *save, SaveBlockFlags blockFlags)
{
    if ((blockFlags & SAVE_BLOCK_FLAG_STAGE) == 0)
        return;

    save->stage.status.difficulty = DIFFICULTY_EASY;
    save->stage.status.timeLimit  = FALSE;
    save->stage.status.lives      = PLAYER_STARTING_LIVES;
}

void SaveGame__UpdateProgress(void)
{
    const SaveGameNextAction *state = SaveGame__GetNextActionFromProgress();
    if (state != NULL && state->eventType < SAVE_PROGRESSEVENT_COUNT)
    {
        sProgressEventList[state->eventType](state);
    }
    else
    {
        sProgressUpdateEventList[SaveGame__GetProgressType()]();
    }
}

const SaveGameNextAction *SaveGame__GetNextActionFromProgress(void)
{
    const SaveGameNextAction *config;

    u16 gameProgress;
    u16 zone5Progress;
    u16 zone6Progress;
    u16 progressCounter;
    u16 progressType;

    gameProgress  = SaveGame__GetGameProgress();
    zone5Progress = SaveGame__GetZone5Progress();
    zone6Progress = SaveGame__GetZone6Progress();

    progressCounter = SaveGame__GetProgressCounter();
    progressType    = SaveGame__GetProgressType();

    if (progressType == SAVE_PROGRESSTYPE_ADVANCE_STAGE)
        progressType = SAVE_PROGRESSTYPE_ISLAND_ARRIVAL;

    if (progressType == SAVE_PROGRESSTYPE_STAGE_CLEAR)
    {
        if (SaveGame__CanStageClearIncrementProgress(gameState.stageID))
        {
            SaveGame__GsExit(0);
        }
    }
    else if (progressType == SAVE_PROGRESSTYPE_EX_EPILOGUE)
    {
        if (SaveGame__GetGameProgress() < SAVE_PROGRESS_39)
        {
            SaveGame__GsExit(0);
        }
    }

    config = NULL;
    u16 count;
    switch (gameProgress)
    {
        default:
            count = sGameProgressCounterList[gameProgress];
            if (progressCounter < count)
            {
                config = sGameProgressUnknown[gameProgress];

                if (config != NULL)
                {
                    config += progressCounter;

                    if (config->type < SAVE_PROGRESSTYPE_COUNT && (config->type != progressType || sProgressCheckTable[progressType](config->progressCheckValue) == FALSE))
                    {
                        config = NULL;
                    }
                    else
                    {
                        if (config->allowProgressIncrement)
                        {
                            if (progressCounter + 1 < count)
                            {
                                SaveGame__IncrementProgressCounter();
                            }
                            else
                            {
                                SaveGame__IncrementGameProgress();
                                SaveGame__ResetProgressCounter();
                            }
                        }

                        SaveGame__GsExit(0);
                    }
                }
                break;
            }
            else
            {
                config = NULL;
            }
            // fallthrough

        case SAVE_PROGRESS_24:
            // this was probably an inlined function
            if (0 == NULL)
            {
                count = sZone5ProgressCounterList[zone5Progress];

                if (progressCounter < count)
                {
                    config = sZone5ProgressUnknown[zone5Progress];

                    if (config != NULL)
                    {
                        config += progressCounter;

                        if (config->type < SAVE_PROGRESSTYPE_COUNT && (config->type != progressType || !sProgressCheckTable[progressType](config->progressCheckValue)))
                        {
                            config = NULL;
                        }
                        else
                        {
                            if (config->allowProgressIncrement)
                            {
                                if (progressCounter + 1 < count)
                                {
                                    SaveGame__IncrementProgressCounter();
                                }
                                else
                                {
                                    SaveGame__IncrementZone5Progress();
                                    SaveGame__ResetProgressCounter();
                                }
                            }

                            SaveGame__GsExit(0);
                        }
                    }
                }
            }

            if (config == NULL)
            {
                count = sZone6ProgressCounterList[zone6Progress];

                if (progressCounter < count)
                {
                    config = sZone6ProgressUnknown[zone6Progress];
                    if (config != NULL)
                    {
                        config += progressCounter;

                        if (config->type < SAVE_PROGRESSTYPE_COUNT && (config->type != progressType || !sProgressCheckTable[progressType](config->progressCheckValue)))
                        {
                            config = NULL;
                        }
                        else
                        {
                            if (config->allowProgressIncrement)
                            {
                                if (progressCounter + 1 < count)
                                {
                                    SaveGame__IncrementProgressCounter();
                                }
                                else
                                {
                                    SaveGame__IncrementZone6Progress();
                                    SaveGame__ResetProgressCounter();
                                }
                            }

                            SaveGame__GsExit(0);
                        }
                    }
                }
            }
            break;
    }

    return config;
}

void SaveGame_ProgressUpdateEvent_ReturnToHub(void)
{
    SaveGame__ChangeEvent(SYSEVENT_RETURN_TO_HUB);
}

void SaveGame_ProgressUpdateEvent_SeaMapChartCourseMenu(void)
{
    SaveGame__StartSeaMapChartCourseMenu();
}

void SaveGame_ProgressUpdateEvent_BeginSailing(void)
{
    if (SaveGame__GetStateFlag(1) || gameState.sailUnknown1 != 0)
    {
        SaveGame__DisableStateFlags(1);
        SaveGame__StartSailing();
    }
    else
    {
        u16 cutscene;
        switch (gameState.sailShipType)
        {
            case SHIP_JET:
                cutscene = CUTSCENE_WAVE_CYCLONE_LAUNCH;
                break;

            case SHIP_BOAT:
                cutscene = CUTSCENE_OCEAN_TORNADO_LAUNCH;
                break;

            case SHIP_HOVER:
                cutscene = CUTSCENE_AQUA_BLAST_LAUNCH;
                break;

            case SHIP_SUBMARINE:
                cutscene = CUTSCENE_DEEP_TYPHOON_LAUNCH;
                break;

            default:
                cutscene = CUTSCENE_NONE;
                break;
        }

        SaveGame__SetProgressType(SAVE_PROGRESSTYPE_BEGIN_SAILING);
        SaveGame__EnableStateFlags(1);
        SaveGame__StartCutscene(cutscene, SYSEVENT_UPDATE_PROGRESS, TRUE);
    }
}

void SaveGame_ProgressUpdateEvent_IslandArrival(void)
{
    if (gameState.stageID == STAGE_Z71 && SaveGame__GetGameProgress() < SAVE_PROGRESS_33)
    {
        SaveGame__StartDoorPuzzle(TRUE);
    }
    else
    {
        gameState.characterID[0] = CHARACTER_SONIC;

        if (SaveGame__BlazeUnlocked())
            SaveGame__StartStageSelect();
        else
            SaveGame__StartStoryMode();
    }
}

void SaveGame_ProgressUpdateEvent_AdvanceStage(void)
{
    SaveGame__StartStoryMode();
}

void SaveGame_ProgressUpdateEvent_StageClear(void)
{
    u32 stageID = gameState.stageID;
    if (stageID == STAGE_Z11)
    {
        if (SaveGame__GetGameProgress() == SAVE_PROGRESS_3)
            SaveGame__SetProgressFlags_ZoneAct1Clear();
    }
    else if (stageID == STAGE_Z21)
    {
        if (SaveGame__GetGameProgress() == SAVE_PROGRESS_6)
            SaveGame__SetProgressFlags_ZoneAct1Clear();
    }
    else if (stageID == STAGE_Z31)
    {
        if (SaveGame__GetGameProgress() == SAVE_PROGRESS_14)
            SaveGame__SetProgressFlags_ZoneAct1Clear();
    }
    else if (stageID == STAGE_Z41)
    {
        if (SaveGame__GetGameProgress() == SAVE_PROGRESS_19)
            SaveGame__SetProgressFlags_ZoneAct1Clear();
    }
    else if (stageID == STAGE_Z51)
    {
        if (SaveGame__GetZone5Progress() == SAVE_ZONE5_PROGRESS_2)
            SaveGame__SetProgressFlags_Zone5Act1Clear();
    }
    else if (stageID == STAGE_Z61)
    {
        if (SaveGame__GetZone6Progress() == SAVE_ZONE6_PROGRESS_4)
            SaveGame__SetProgressFlags_Zone6Act1Clear();
    }
    else if (stageID == STAGE_Z71)
    {
        if (SaveGame__GetGameProgress() == SAVE_PROGRESS_33)
            SaveGame__SetProgressFlags_ZoneAct1Clear();
    }

    for (s32 s = 0; s < SAVE_ISLAND_COUNT; s++)
    {
        if (stageID == sOptionalHiddenIslandStageList[s] && SaveGame__GetIslandProgress(&saveGame.stage.progress, s) < SAVE_ISLAND_STATE_BEATEN)
        {
            SaveGame__SetIslandProgress(&saveGame.stage.progress, s, SAVE_ISLAND_STATE_BEATEN);
            break;
        }
    }

    SaveGame__ApplySystemProgress();

    if (gameState.saveFile.field_52 == 1)
    {
        gameState.saveFile.field_54 = 1;
        SaveGame__ChangeEvent(SYSEVENT_MAIN_MENU);
    }
    else
    {
        u32 nextStage = sZoneNextStageTable[stageID];
        if (stageID != nextStage)
        {
            // next stage (act) lined up, so advance to the next stage.
            gameState.stageID = nextStage;
            SaveGame__SetProgressType(SAVE_PROGRESSTYPE_ADVANCE_STAGE);
        }
        else if (stageID == STAGE_BOSS_FINAL)
        {
            static const u16 cutsceneIDList[] = { CUTSCENE_GHOST_TITANS_IMPACT, CUTSCENE_ENDING, CUTSCENE_INVALID };

            u16 cutsceneID = cutsceneIDList[SaveGame__GetProgressCounter()];
            SaveGame__IncrementUnknown2ForUnknown();
            if (SaveGame__GetProgressCounter() >= 3)
            {
                SaveGame__ResetProgressCounter();
                if (SaveGame__GetGameProgress() <= SAVE_PROGRESS_35)
                    SaveGame__SetGameProgress(SAVE_PROGRESS_36);
            }

            if (cutsceneID != CUTSCENE_INVALID)
            {
                BOOL canSkip                    = SaveGame__GetGameProgress() >= SAVE_PROGRESS_36 ? TRUE : FALSE;
                struct GameCutsceneState *state = &gameState.cutscene;

                state->nextSysEvent = SYSEVENT_UPDATE_PROGRESS;
                state->canSkip      = canSkip;
                state->cutsceneID   = cutsceneID;
                SaveGame__ChangeEvent(SYSEVENT_CUTSCENE);
            }
            else
            {
                gameState.creditsMode = CREDITS_MODE_FINAL_BOSS;
                SaveGame__ChangeEvent(SYSEVENT_CREDITS);
            }

            return;
        }
        else
        {
            if (stageID == STAGE_HIDDEN_ISLAND_3)
            {
                if (SaveGame__GetGameProgress() < SAVE_PROGRESS_29)
                {
                    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_RETURN_TO_HUB);
                    SaveGame__StartCutscene(CUTSCENE_MYSTERIOUS_MARKER_NO_1, SYSEVENT_UPDATE_PROGRESS, TRUE);
                    return;
                }
                else
                {
                    if (!SaveGame__HasDoorPuzzlePiece(0))
                    {
                        SaveGame__GetPuzzlePiece(0);
                        SaveGame__SetProgressType(SAVE_PROGRESSTYPE_RETURN_TO_HUB);
                        SaveGame__StartCutscene(CUTSCENE_CLUE_NO_1, SYSEVENT_UPDATE_PROGRESS, TRUE);
                        return;
                    }
                }
            }
            else if (stageID == STAGE_HIDDEN_ISLAND_4)
            {
                if (SaveGame__GetGameProgress() < SAVE_PROGRESS_29)
                {
                    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_RETURN_TO_HUB);
                    SaveGame__StartCutscene(CUTSCENE_MYSTERIOUS_MARKER_NO_2, SYSEVENT_UPDATE_PROGRESS, TRUE);
                    return;
                }

                if (!SaveGame__HasDoorPuzzlePiece(1))
                {
                    SaveGame__GetPuzzlePiece(1);
                    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_RETURN_TO_HUB);
                    SaveGame__StartCutscene(CUTSCENE_CLUE_NO_2, SYSEVENT_UPDATE_PROGRESS, TRUE);
                    return;
                }
            }
            else if (stageID == STAGE_HIDDEN_ISLAND_5)
            {
                if (SaveGame__GetGameProgress() < SAVE_PROGRESS_29)
                {
                    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_RETURN_TO_HUB);
                    SaveGame__StartCutscene(CUTSCENE_MYSTERIOUS_MARKER_NO_1, SYSEVENT_UPDATE_PROGRESS, TRUE);
                    return;
                }
                else
                {
                    if (!SaveGame__HasDoorPuzzlePiece(2))
                    {
                        SaveGame__GetPuzzlePiece(2);
                        SaveGame__SetProgressType(SAVE_PROGRESSTYPE_RETURN_TO_HUB);
                        SaveGame__StartCutscene(CUTSCENE_CLUE_NO_3, SYSEVENT_UPDATE_PROGRESS, TRUE);
                        return;
                    }
                }
            }

            SaveGame__SetProgressType(SAVE_PROGRESSTYPE_RETURN_TO_HUB);
        }

        SaveGame__RestartEvent();
    }
}

void SaveGame_ProgressUpdateEvent_BeginRivalRace(void)
{
    gameState.saveFile.chaosEmeraldID = -1;
    gameState.saveFile.solEmeraldID   = -1;
    SaveGame__StartSailRivalRace();
}

void SaveGame_ProgressUpdateEvent_FinishRivalRace(void)
{
    gameState.sailShipType = gameState.sailStoredShipType;

    u8 emerald = gameState.saveFile.chaosEmeraldID;
    if (emerald < 7 && SaveGame__HasChaosEmerald(&saveGame.chart, emerald) == FALSE)
    {
        SaveGame__SetChaosEmeraldCollected(&saveGame.chart, emerald);
        gameState.saveFile.solEmeraldID = -1;
        SaveGame__StartEmeraldCollected();
    }
    else
    {
        SaveGame__StartSailing();
    }
}

void SaveGame_ProgressUpdateEvent_ExPrologue(void)
{
    if (SaveGame__GetProgressCounter() >= 7)
    {
        SaveGame__ResetProgressCounter();
        if (SaveGame__GetGameProgress() <= SAVE_PROGRESS_37)
            SaveGame__SetGameProgress(SAVE_PROGRESS_38);
        SaveGame__StartExBoss();
    }
    else
    {
        u16 cutscene = sExPrologueCutsceneList[SaveGame__GetProgressCounter()];
        SaveGame__IncrementUnknown2ForUnknown();
        SaveGame__StartCutscene(cutscene, SYSEVENT_UPDATE_PROGRESS, SaveGame__GetGameProgress() >= SAVE_PROGRESS_38);
    }
}

void SaveGame_ProgressUpdateEvent_ExEpilogue(void)
{
    if (gameState.saveFile.field_52 == 1)
    {
        if (SaveGame__GetProgressCounter() == 0)
        {
            SaveGame__IncrementUnknown2ForUnknown();
            SaveGame__ChangeEvent(SYSEVENT_STAGE_CLEAR_EX);
        }
        else
        {
            SaveGame__ResetProgressCounter();
            gameState.saveFile.field_54 = 1;
            SaveGame__ChangeEvent(SYSEVENT_MAIN_MENU);
        }
    }
    else
    {
        if (SaveGame__GetProgressCounter() >= 5)
        {
            SaveGame__ResetProgressCounter();

            if (SaveGame__GetGameProgress() <= SAVE_PROGRESS_38)
                SaveGame__SetGameProgress(SAVE_PROGRESS_39);

            gameState.creditsMode = CREDITS_MODE_EXTRA_BOSS_STAGE_SELECT;
            SaveGame__ChangeEvent(SYSEVENT_CREDITS);
        }
        else
        {
            u32 id       = SaveGame__GetProgressCounter();
            u16 cutscene = sExEpilogueCutsceneList[id];

            SaveGame__IncrementUnknown2ForUnknown();

            if (cutscene != CUTSCENE_INVALID)
            {
                BOOL canSkip;
                if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_39)
                    canSkip = TRUE;
                else
                    canSkip = FALSE;

                struct GameCutsceneState *cutsceneState = &gameState.cutscene;
                cutsceneState->nextSysEvent             = SYSEVENT_UPDATE_PROGRESS;
                cutsceneState->canSkip                  = canSkip;
                cutsceneState->cutsceneID               = cutscene;

                SaveGame__ChangeEvent(SYSEVENT_CUTSCENE);
            }
            else
            {
                if (id == 1)
                {
                    SaveGame__ChangeEvent(SYSEVENT_STAGE_CLEAR_EX);
                }
                else
                {
                    gameState.creditsMode = CREDITS_MODE_EXTRA_BOSS;
                    SaveGame__ChangeEvent(SYSEVENT_CREDITS);
                }
            }
        }
    }
}

void SaveGame_ProgressUpdateEvent_DoorPuzzleComplete(void)
{
    SaveGame__IncrementUnknown2ForUnknown();
    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_ISLAND_ARRIVAL);
    SaveGame__RestartEvent();
}

void SaveGame_ProgressUpdateEvent_NonStageIslandArrival(void)
{
    u16 stage = sLandedIslandStageTable[gameState.landedIslandID];

    if (gameState.landedIslandID == SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND && SaveGame__GetGameProgress() < SAVE_PROGRESS_17)
    {
        SaveGame__SetProgressType(SAVE_PROGRESSTYPE_RETURN_TO_HUB);
        SaveGame__StartCutscene(CUTSCENE_KYLOK_ISLAND_EMPTY, SYSEVENT_UPDATE_PROGRESS, TRUE);
    }
    else if (gameState.landedIslandID == SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND && SaveGame__GetGameProgress() > SAVE_PROGRESS_17)
    {
        SaveGame__SetProgressType(SAVE_PROGRESSTYPE_RETURN_TO_HUB);
        SaveGame__StartCutscene(CUTSCENE_DAIKUN_ISLAND_EMPTY, SYSEVENT_UPDATE_PROGRESS, TRUE);
    }
    else if (gameState.landedIslandID == SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND && SaveGame__GetZone6Progress() > SAVE_ZONE6_PROGRESS_1)
    {
        SaveGame__SetProgressType(SAVE_PROGRESSTYPE_RETURN_TO_HUB);
        SaveGame__StartCutscene(CUTSCENE_DAIKUN_ISLAND_EMPTY, SYSEVENT_UPDATE_PROGRESS, TRUE);
    }
    else
    {
        for (s32 i = 0; i < SAVE_ISLAND_COUNT; i++)
        {
            if (stage == sOptionalHiddenIslandStageList[i] && SaveGame__GetIslandProgress(&saveGame.stage.progress, i) < SAVE_ISLAND_STATE_UNLOCKED)
            {
                SaveGame__SetIslandProgress(&saveGame.stage.progress, i, SAVE_ISLAND_STATE_UNLOCKED);
                SaveGame__ApplySystemProgress();
                break;
            }
        }

        if (stage < STAGE_COUNT)
        {
            gameState.stageID = stage;
            SaveGame__SetProgressType(SAVE_PROGRESSTYPE_ISLAND_ARRIVAL);
            SaveGame__RestartEvent();
        }
        else
        {
            SaveGame__SetProgressType(SAVE_PROGRESSTYPE_RETURN_TO_HUB);
            SaveGame__RestartEvent();
        }
    }
}

BOOL SaveGame_ProgressCheck_ReturnToHub(s32 param)
{
    if (param == TRUE)
    {
        if (!SaveGame__HasDoorPuzzlePiece(0))
            return FALSE;

        if (!SaveGame__HasDoorPuzzlePiece(1))
            return FALSE;

        if (!SaveGame__HasDoorPuzzlePiece(2))
            return FALSE;
    }

    return TRUE;
}

BOOL SaveGame_ProgressCheck_SeaMapChartCourseMenu(s32 param)
{
    return TRUE;
}

BOOL SaveGame_ProgressCheck_BeginSailing(s32 param)
{
    return param == gameState.sailShipType;
}

BOOL SaveGame_ProgressCheck_IslandArrival(s32 param)
{
    return param == gameState.stageID;
}

BOOL SaveGame_ProgressCheck_AdvanceStage(s32 param)
{
    return FALSE;
}

BOOL SaveGame_ProgressCheck_StageClear(s32 param)
{
    return param == gameState.stageID;
}

BOOL SaveGame_ProgressCheck_BeginRivalRace(s32 param)
{
    return TRUE;
}

BOOL SaveGame_ProgressCheck_FinishRivalRace(s32 param)
{
    return TRUE;
}

BOOL SaveGame_ProgressCheck_ExPrologue(s32 param)
{
    return TRUE;
}

BOOL SaveGame_ProgressCheck_ExEpilogue(s32 param)
{
    return TRUE;
}

BOOL SaveGame_ProgressCheck_DoorPuzzleComplete(s32 param)
{
    return TRUE;
}

BOOL SaveGame_ProgressCheck_NonStageIslandArrival(s32 param)
{
    return param == gameState.landedIslandID;
}

void SaveGame_ProgressEvent_StartCutscene(const SaveGameNextAction *action)
{
    u16 cutscene = action->eventParam;

    if (cutscene == CUTSCENE_LEGENDARY_ANCIENT_RUINS_1)
    {
        if (SaveGame__GetZone6Progress() == SAVE_ZONE6_PROGRESS_6)
            cutscene = CUTSCENE_PIRATE_HIDEOUT_IN_DEPTHS_1;
    }
    else if (cutscene == CUTSCENE_LEGENDARY_ANCIENT_RUINS_2)
    {
        if (SaveGame__GetZone5Progress() != SAVE_ZONE5_PROGRESS_4)
            cutscene = CUTSCENE_PIRATE_HIDEOUT_IN_DEPTHS_2;
    }
    else
    {
        if (cutscene == CUTSCENE_KYLOK_FOUND || cutscene == CUTSCENE_DAIKUN_DISCOVERED)
            SaveGame__SetProgressType(SAVE_PROGRESSTYPE_RETURN_TO_HUB);
    }

    SaveGame__StartCutscene(cutscene, action->nextSysEvent, FALSE);
}

void SaveGame_ProgressEvent_StartTutorial(const SaveGameNextAction *action)
{
    SaveGame__StartTutorial();
}

void SaveGame_ProgressEvent_StartSailTraining(const SaveGameNextAction *action)
{
    SaveGame__StartSailTraining();
}

void SaveGame_ProgressEvent_StartSailJetTraining(const SaveGameNextAction *action)
{
    SaveGame__StartSailJetTraining();
}

void SaveGame_ProgressEvent_ReturnToHub(const SaveGameNextAction *action)
{
    SaveGame__StartHubMenu();
}

void SaveGame_ProgressEvent_StartDoorPuzzle(const SaveGameNextAction *action)
{
    SaveGame__StartDoorPuzzle(action->eventParam);
}

void SaveGame_ProgressEvent_StartSeaMapCutscene(const SaveGameNextAction *action)
{
    if (action->eventParam == SAVE_SEAMAPCUTSCENE_CORAL_CAVE_APPEARS)
        SeaMapManager__SetUnknown1(0);
    else
        SeaMapManager__SetUnknown1(1);

    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_STAGE_CLEAR);
    SaveGame__ChangeEvent(SYSEVENT_SEAMAPCUTSCENE);
}

void SaveGame_ProgressEvent_StartIslandArrival(const SaveGameNextAction *action)
{
    if (action->eventParam == STAGE_BOSS_FINAL)
        SaveGame__EnableStateFlags(2);

    gameState.stageID = action->eventParam;
    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_ISLAND_ARRIVAL);
    SaveGame__RestartEvent();
}

void SaveGame__ChangeEvent(s32 sysEvent)
{
    RequestNewSysEventChange((s16)sysEvent);
    NextSysEvent();
}

void SaveGame__RestartEvent(void)
{
    SaveGame__ChangeEvent((u16)GetSysEventManager()->currentEventID);
}

void SaveGame__StartCutscene(u16 cutsceneID, s32 nextEvent, BOOL flag)
{
    u16 cutsceneIDList[] = { CUTSCENE_OCEAN_TORNADO_LAUNCH, CUTSCENE_AQUA_BLAST_LAUNCH, CUTSCENE_DEEP_TYPHOON_LAUNCH };

    if (nextEvent == SYSEVENT_NONE)
        nextEvent = (u16)GetSysEventManager()->currentEventID;

    struct GameCutsceneState *state = &gameState.cutscene;
    state->nextSysEvent             = nextEvent;
    state->cutsceneID               = cutsceneID;
    state->canSkip                  = TRUE;

    for (u32 i = 0; i < 3; i++)
    {
        if (cutsceneID == cutsceneIDList[i])
        {
            SaveGame__EnableStateFlags(1);
            break;
        }
    }

    SaveGame__ChangeEvent(SYSEVENT_CUTSCENE);
}

void SaveGame__StartTutorial(void)
{
    gameState.characterID[0] = CHARACTER_SONIC;
    gameState.gameMode       = GAMEMODE_STORY;
    gameState.stageID        = STAGE_TUTORIAL;

    SaveGame__ChangeEvent(SYSEVENT_LOAD_STAGE);
}

void SaveGame__StartSailTraining(void)
{
    SaveGame__ChangeEvent(SYSEVENT_SEAMAP_TRAINING);
}

void SaveGame__StartSailJetTraining(void)
{
    gameState.missionType                 = MISSION_TYPE_TRAINING;
    gameState.missionConfig.sail.courseID = 1;
    gameState.missionConfig.sail.unknown  = 1;
    gameState.sailShipType                = SHIP_JET;

    SaveGame__ChangeEvent(SYSEVENT_SAILING);
}

void SaveGame__StartHubMenu(void)
{
    SaveGame__ChangeEvent(SYSEVENT_RETURN_TO_HUB);
}

void SaveGame__StartSeaMapChartCourseMenu(void)
{
    SaveGame__ChangeEvent(SYSEVENT_SEAMAP_CHART_COURSE_MENU);
}

void SaveGame__StartSailing(void)
{
    SaveGame__ChangeEvent(SYSEVENT_SAILING);
}

void SaveGame__StartStoryMode(void)
{
    gameState.gameMode = GAMEMODE_STORY;

    SaveGame__ChangeEvent(SYSEVENT_LOAD_STAGE);
}

void SaveGame__StartSailRivalRace(void)
{
    gameState.sailStoredShipType = gameState.sailShipType;
    gameState.sailShipType       = SHIP_JET;

    SaveGame__ChangeEvent(SYSEVENT_SAILING);
}

void SaveGame__StartExBoss(void)
{
    SaveGame__ChangeEvent(SYSEVENT_EXBOSS);
}

void SaveGame__StartDoorPuzzle(BOOL flag)
{
    if (flag == FALSE)
    {
        gameState.doorPuzzleEvent = DOORPUZZLE_EVENT_DISCOVERY;
    }
    else
    {
        if (SaveGame__GetGameProgress() <= SAVE_PROGRESS_31)
            gameState.doorPuzzleEvent = DOORPUZZLE_EVENT_NO_ACCESS;
        else
            gameState.doorPuzzleEvent = DOORPUZZLE_EVENT_HAVE_KEYS;
    }

    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_DOOR_PUZZLE_COMPLETE);
    SaveGame__ChangeEvent(SYSEVENT_DOOR_PUZZLE);
}

void SaveGame__StartStageSelect(void)
{
    gameState.gameMode = GAMEMODE_STORY;

    SaveGame__ChangeEvent(SYSEVENT_7);
}

void SaveGame__StartEmeraldCollected(void)
{
    SaveGame__SetProgressType(SAVE_PROGRESSTYPE_FINISH_RIVAL_RACE);
    SaveGame__ChangeEvent(SYSEVENT_EMERALD_COLLECTED);
}

void SaveGame__IncrementGameProgress(void)
{
    SaveGame__SetGameProgress(saveGame.stage.progress.gameProgress + 1);
}

void SaveGame__IncrementZone5Progress(void)
{
    SaveGame__SetZone5Progress(saveGame.stage.progress.zone5Progress + 1);
}

void SaveGame__IncrementZone6Progress(void)
{
    SaveGame__SetZone6Progress(saveGame.stage.progress.zone6Progress + 1);
}

void SaveGame__IncrementProgressCounter(void)
{
    gameState.saveFile.progressCounter++;
}

void SaveGame__ResetProgressCounter(void)
{
    gameState.saveFile.progressCounter = 0;
}

s32 SaveGame__GetProgressType(void)
{
    return gameState.saveFile.progressType;
}

BOOL SaveGame__GetStateFlag(u16 id)
{
    return (id & gameState.saveFile.flags) != 0;
}

void SaveGame__EnableStateFlags(u16 mask)
{
    gameState.saveFile.flags |= mask;
}

void SaveGame__DisableStateFlags(u16 mask)
{
    gameState.saveFile.flags &= ~mask;
}

void SaveGame__ApplySystemProgress(void)
{
    SaveGameProgress *stageProgress  = &saveGame.stage.progress;
    SaveGameProgress *systemProgress = &saveGame.system.progress;

    if (systemProgress->gameProgress < stageProgress->gameProgress)
    {
        systemProgress->gameProgress = stageProgress->gameProgress;

        if ((stageProgress->flags & SAVE_PROGRESSFLAG_ANY_ACT1_CLEAR) != 0)
            systemProgress->flags |= SAVE_PROGRESSFLAG_ANY_ACT1_CLEAR;
        else
            systemProgress->flags &= ~SAVE_PROGRESSFLAG_ANY_ACT1_CLEAR;
    }
    else
    {
        if (systemProgress->gameProgress == stageProgress->gameProgress && (stageProgress->flags & SAVE_PROGRESSFLAG_ANY_ACT1_CLEAR) != 0)
            systemProgress->flags |= SAVE_PROGRESSFLAG_ANY_ACT1_CLEAR;
    }

    if (systemProgress->zone5Progress <= stageProgress->zone5Progress)
    {
        systemProgress->zone5Progress = stageProgress->zone5Progress;

        if (stageProgress->zone5Progress == SAVE_ZONE5_PROGRESS_2 && (stageProgress->flags & SAVE_PROGRESSFLAG_ZONE5_ACT1_CLEAR) != 0)
            systemProgress->flags |= SAVE_PROGRESSFLAG_ZONE5_ACT1_CLEAR;
    }

    if (systemProgress->zone6Progress <= stageProgress->zone6Progress)
    {
        systemProgress->zone6Progress = stageProgress->zone6Progress;

        if (stageProgress->zone6Progress == SAVE_ZONE6_PROGRESS_4 && (stageProgress->flags & SAVE_PROGRESSFLAG_ZONE6_ACT1_CLEAR) != 0)
            systemProgress->flags |= SAVE_PROGRESSFLAG_ZONE6_ACT1_CLEAR;
    }

    systemProgress->flags |= stageProgress->flags
                             & ~(SAVE_PROGRESSFLAG_INCREMENTED_ZONE6_PROGRESS
                                 | (SAVE_PROGRESSFLAG_ANY_ACT1_CLEAR | SAVE_PROGRESSFLAG_ZONE5_ACT1_CLEAR | SAVE_PROGRESSFLAG_ZONE6_ACT1_CLEAR) | (0xFFF << 20));

    for (s32 i = 0; i < SAVE_ISLAND_COUNT; i++)
    {
        s32 islandProgress = SaveGame__GetIslandProgress(stageProgress, i);
        if (SaveGame__GetIslandProgress(systemProgress, i) < islandProgress)
            SaveGame__SetIslandProgress(systemProgress, i, islandProgress);
    }
}

void SaveGame__SetProgressFlags_ZoneAct1Clear(void)
{
    saveGame.stage.progress.flags |= SAVE_PROGRESSFLAG_ANY_ACT1_CLEAR;
}

void SaveGame__SetProgressFlags_Zone5Act1Clear(void)
{
    saveGame.stage.progress.flags |= SAVE_PROGRESSFLAG_ZONE5_ACT1_CLEAR;
}

void SaveGame__SetProgressFlags_Zone6Act1Clear(void)
{
    saveGame.stage.progress.flags |= SAVE_PROGRESSFLAG_ZONE6_ACT1_CLEAR;
}

void SaveGame__RemoveProgressFlags_ZoneAct1Clear(void)
{
    saveGame.stage.progress.flags &= ~SAVE_PROGRESSFLAG_ANY_ACT1_CLEAR;
}

void SaveGame__RemoveProgressFlags_Zone5Act1Clear(void)
{
    saveGame.stage.progress.flags &= ~SAVE_PROGRESSFLAG_ZONE5_ACT1_CLEAR;
}

void SaveGame__RemoveProgressFlags_Zone6Act1Clear(void)
{
    saveGame.stage.progress.flags &= ~SAVE_PROGRESSFLAG_ZONE6_ACT1_CLEAR;
}

BOOL SaveGame__CanStageClearIncrementProgress(s32 stageID)
{
    u8 gameProgress  = SaveGame__GetGameProgress();
    u8 zone5Progress = SaveGame__GetZone5Progress();
    u8 zone6Progress = SaveGame__GetZone6Progress();

    BOOL zoneAct1Clear;
    if ((saveGame.stage.progress.flags & SAVE_PROGRESSFLAG_ANY_ACT1_CLEAR) != 0)
        zoneAct1Clear = TRUE;
    else
        zoneAct1Clear = FALSE;

    BOOL zone5Act1Clear;
    if ((saveGame.stage.progress.flags & SAVE_PROGRESSFLAG_ZONE5_ACT1_CLEAR) != 0)
        zone5Act1Clear = TRUE;
    else
        zone5Act1Clear = FALSE;

    BOOL zone6Act1Clear;
    if ((saveGame.stage.progress.flags & SAVE_PROGRESSFLAG_ZONE6_ACT1_CLEAR) != 0)
        zone6Act1Clear = TRUE;
    else
        zone6Act1Clear = FALSE;

    BOOL result = FALSE;
    if (stageID <= STAGE_BOSS_FINAL)
    {
        const StageProgressCheck *progressCheck = &sStageProgressCheckList[stageID];

        if (progressCheck->gameProgress != SAVE_PROGRESS_INVALID && progressCheck->gameProgress != gameProgress)
        {
            return FALSE;
        }

        if (progressCheck->zone5Progress != SAVE_PROGRESS_INVALID && progressCheck->zone5Progress != zone5Progress)
        {
            return FALSE;
        }

        if (progressCheck->zone6Progress != SAVE_PROGRESS_INVALID && progressCheck->zone6Progress != zone6Progress)
        {
            return FALSE;
        }

        switch (progressCheck->extraCheck)
        {
            case SAVE_STAGECLEAR_EXTRACHECK_ANY_ACT1:
                if (zoneAct1Clear)
                    return FALSE;
                break;

            case SAVE_STAGECLEAR_EXTRACHECK_ANY_ACT2:
                if (!zoneAct1Clear)
                    return FALSE;
                break;

            case SAVE_STAGECLEAR_EXTRACHECK_ANY_ZONE_5ACT1:
                if (zone5Act1Clear)
                    return FALSE;
                break;

            case SAVE_STAGECLEAR_EXTRACHECK_ANY_ZONE_5ACT2:
                if (!zone5Act1Clear)
                    return FALSE;
                break;

            case SAVE_STAGECLEAR_EXTRACHECK_ANY_ZONE_6ACT1:
                if (zone6Act1Clear)
                    return FALSE;
                break;

            case SAVE_STAGECLEAR_EXTRACHECK_ANY_ZONE_6ACT2:
                if (!zone6Act1Clear)
                    return FALSE;
                break;
        }

        return TRUE;
    }
    else
    {
        if (stageID <= STAGE_HIDDEN_ISLAND_5)
            return SaveGame__HasDoorPuzzlePiece(stageID - STAGE_HIDDEN_ISLAND_3) == FALSE;
        else
            return FALSE;
    }
}