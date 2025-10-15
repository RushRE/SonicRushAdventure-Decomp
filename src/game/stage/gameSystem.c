#include <game/stage/gameSystem.h>
#include <game/system/allocator.h>
#include <game/input/touchInput.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/drawState.h>
#include <game/audio/audioSystem.h>
#include <game/graphics/paletteQueue.h>
#include <game/graphics/mappingsQueue.h>
#include <game/graphics/pixelsQueue.h>
#include <game/system/sysEvent.h>
#include <game/stage/eventManager.h>
#include <game/input/replayRecorder.h>
#include <game/game/gameState.h>
#include <game/system/system.h>
#include <game/audio/spatialAudio.h>
#include <game/object/objectManager.h>
#include <stage/core/bgmManager.h>
#include <stage/player/starCombo.h>
#include <stage/core/titleCard.h>
#include <stage/core/ringManager.h>
#include <stage/core/hud.h>
#include <stage/core/pauseMenu.h>
#include <stage/core/ringBattleManager.h>
#include <game/graphics/drawFadeTask.h>
#include <game/graphics/screenShake.h>
#include <stage/core/demoPlayer.h>
#include <game/graphics/drawReqTask.h>
#include <stage/gameObject.h>
#include <stage/objects/playerSnowboard.h>
#include <game/save/saveGame.h>
#include <game/util/akUtil.h>
#include <game/math/mtMath.h>
#include <game/stage/bossArena.h>
#include <network/networkHandler.h>
#include <game/game/missionList.h>
#include <stage/core/decorationSys.h>
#include <game/network/wirelessManager.h>

// --------------------
// ENUMS/CONSTANTS
// --------------------

#define GAMEONLINESYS_NETWORK_TIMEOUT_TIME 1500

// --------------------
// FUNCTION DECLS
// --------------------

void InitSkipTitleCardEvent(void);
void InitZoneSysEvent(void);
void ExitTitleCardSysEvent(void);
void InitLoadStageEvent(void);
void InitZoneEvent(void);
void InitVSBattleEvent(void);
void InitStageMission(s32 id);

// GameDataRequest functions
void CreateGameDataRequest(GameDataLoadProc load_proc);
static void GameDataRequest_Main_TryLoadCommonAssets(void);
static void GameDataRequest_Main_AwaitLoadCommonAssets(void);
static void GameDataRequest_Main_TryLoadStage(void);
static void GameDataRequest_Main_AwaitLoadStageAssets(void);
static void GameDataRequest_Main_BuildArea(void);

static void InitStageCollision(void);
static void LoadGameMissionArchive(void);

static void InitStageBlendControl(void);
static void InitPlayerStatus(void);

static void CreateGameSystem(void);
static void CreateGameSystemEx(void);

static void ShutdownGameSystemTasks(void);

static void GameSystem_Main_Early(void);
static void GameSystem_Main_Late(void);

static void HandleNetworkError(void);

static void CreateReplayViewer(void);
static void ReplayViewer_Main(void);

// --------------------
// STRUCTS
// --------------------

typedef struct GameSysLateTask_
{
    BOOL forceActivatePauseMenu;
} GameSysLateTask;

// --------------------
// VARIABLES
// --------------------

Player *gPlayer;
void *gameArchiveMission;
MIProcessor mainMemProcessor;
static Task *gameDataTask;

Player *gPlayerList[PLAYER_COUNT];
OBS_DIFF_COLLISION stageCollision;
PlayerGameStatus playerGameStatus;

const struct MissionEntry missionList[ZONE_MISSION_COUNT] = {
    [MISSION_0] =
    {
        .stageID = STAGE_Z11,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 20, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 20, 00), .quota = 0 },
        },
    },

    [MISSION_1] =
    {
        .stageID = STAGE_Z11,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 100 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 100 },
        },
    },

    [MISSION_2] =
    {
        .stageID = STAGE_Z11,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
        },
    },

    [MISSION_3] =
    {
        .stageID = STAGE_Z11,
        .type = MISSION_TYPE_PERFORM_TRICKS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 30 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 30 },
        },
    },

    [MISSION_4] =
    {
        .stageID = STAGE_Z11,
        .type = MISSION_TYPE_PERFORM_COMBOS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 12 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 12 },
        },
    },

    [MISSION_5] =
    {
        .stageID = STAGE_Z12,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 20, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 20, 00), .quota = 0 },
        },
    },

    [MISSION_6] =
    {
        .stageID = STAGE_Z12,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 100 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 100 },
        },
    },

    [MISSION_7] =
    {
        .stageID = STAGE_Z12,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
        },
    },

    [MISSION_8] =
    {
        .stageID = STAGE_Z12,
        .type = MISSION_TYPE_DEFEAT_ENEMIES,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 8 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 8 },
        },
    },

    [MISSION_9] =
    {
        .stageID = STAGE_Z1B,
        .type = MISSION_TYPE_BOSS_REMATCH,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_10] =
    {
        .stageID = STAGE_Z1B,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    [MISSION_11] =
    {
        .stageID = STAGE_Z21,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 40, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 40, 00), .quota = 0 },
        },
    },

    [MISSION_12] =
    {
        .stageID = STAGE_Z21,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
        },
    },

    [MISSION_13] =
    {
        .stageID = STAGE_Z21,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
        },
    },

    [MISSION_14] =
    {
        .stageID = STAGE_Z21,
        .type = MISSION_TYPE_PERFORM_TRICKS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 30 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 30 },
        },
    },

    [MISSION_15] =
    {
        .stageID = STAGE_Z22,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 40, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 40, 00), .quota = 0 },
        },
    },

    [MISSION_16] =
    {
        .stageID = STAGE_Z22,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
        },
    },

    [MISSION_17] =
    {
        .stageID = STAGE_Z22,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 0 },
        },
    },

    [MISSION_18] =
    {
        .stageID = STAGE_Z22,
        .type = MISSION_TYPE_DEFEAT_ENEMIES,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 6 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 6 },
        },
    },

    [MISSION_19] =
    {
        .stageID = STAGE_Z2B,
        .type = MISSION_TYPE_BOSS_REMATCH,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_20] =
    {
        .stageID = STAGE_Z2B,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    [MISSION_21] =
    {
        .stageID = STAGE_Z31,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 50, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 50, 00), .quota = 0 },
        },
    },

    [MISSION_22] =
    {
        .stageID = STAGE_Z31,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
        },
    },

    [MISSION_23] =
    {
        .stageID = STAGE_Z31,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
        },
    },

    [MISSION_24] =
    {
        .stageID = STAGE_Z31,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    [MISSION_25] =
    {
        .stageID = STAGE_Z32,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 20, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 20, 00), .quota = 0 },
        },
    },

    [MISSION_26] =
    {
        .stageID = STAGE_Z32,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
        },
    },

    [MISSION_27] =
    {
        .stageID = STAGE_Z32,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
        },
    },

    [MISSION_28] =
    {
        .stageID = STAGE_Z32,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_29] =
    {
        .stageID = STAGE_Z3B,
        .type = MISSION_TYPE_BOSS_REMATCH,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_30] =
    {
        .stageID = STAGE_Z3B,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    [MISSION_31] =
    {
        .stageID = STAGE_Z41,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
        },
    },

    [MISSION_32] =
    {
        .stageID = STAGE_Z41,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 50 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 50 },
        },
    },

    [MISSION_33] =
    {
        .stageID = STAGE_Z41,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
        },
    },

    [MISSION_34] =
    {
        .stageID = STAGE_Z41,
        .type = MISSION_TYPE_DEFEAT_ENEMIES,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 10 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 10 },
        },
    },

    [MISSION_35] =
    {
        .stageID = STAGE_Z42,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 0 },
        },
    },

    [MISSION_36] =
    {
        .stageID = STAGE_Z42,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 50 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 50 },
        },
    },

    [MISSION_37] =
    {
        .stageID = STAGE_Z42,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
        },
    },

    [MISSION_38] =
    {
        .stageID = STAGE_Z42,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    [MISSION_39] =
    {
        .stageID = STAGE_Z4B,
        .type = MISSION_TYPE_BOSS_REMATCH,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_40] =
    {
        .stageID = STAGE_Z4B,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    [MISSION_41] =
    {
        .stageID = STAGE_Z51,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 0 },
        },
    },

    [MISSION_42] =
    {
        .stageID = STAGE_Z51,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 50 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 50 },
        },
    },

    [MISSION_43] =
    {
        .stageID = STAGE_Z51,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
        },
    },

    [MISSION_44] =
    {
        .stageID = STAGE_Z51,
        .type = MISSION_TYPE_PASS_FLAGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
        },
    },

    [MISSION_45] =
    {
        .stageID = STAGE_Z51,
        .type = MISSION_TYPE_PERFORM_TRICKS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 20 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 20 },
        },
    },

    [MISSION_46] =
    {
        .stageID = STAGE_Z52,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 50, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 50, 00), .quota = 0 },
        },
    },

    [MISSION_47] =
    {
        .stageID = STAGE_Z52,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 50 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 50 },
        },
    },

    [MISSION_48] =
    {
        .stageID = STAGE_Z52,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
        },
    },

    [MISSION_49] =
    {
        .stageID = STAGE_Z5B,
        .type = MISSION_TYPE_BOSS_REMATCH,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_50] =
    {
        .stageID = STAGE_Z5B,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    [MISSION_51] =
    {
        .stageID = STAGE_Z61,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 40, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 40, 00), .quota = 0 },
        },
    },

    [MISSION_52] =
    {
        .stageID = STAGE_Z61,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
        },
    },

    [MISSION_53] =
    {
        .stageID = STAGE_Z61,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 0 },
        },
    },

    [MISSION_54] =
    {
        .stageID = STAGE_Z61,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    [MISSION_55] =
    {
        .stageID = STAGE_Z62,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 0 },
        },
    },

    [MISSION_56] =
    {
        .stageID = STAGE_Z62,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 50 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 50 },
        },
    },

    [MISSION_57] =
    {
        .stageID = STAGE_Z62,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 0 },
        },
    },

    [MISSION_58] =
    {
        .stageID = STAGE_Z62,
        .type = MISSION_TYPE_DEFEAT_ENEMIES,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 10 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 10 },
        },
    },

    [MISSION_59] =
    {
        .stageID = STAGE_Z6B,
        .type = MISSION_TYPE_BOSS_REMATCH,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_60] =
    {
        .stageID = STAGE_Z6B,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    [MISSION_61] =
    {
        .stageID = STAGE_Z71,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 20, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 20, 00), .quota = 0 },
        },
    },

    [MISSION_62] =
    {
        .stageID = STAGE_Z71,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 20, 00), .quota = 100 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 20, 00), .quota = 100 },
        },
    },

    [MISSION_63] =
    {
        .stageID = STAGE_Z71,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
        },
    },

    [MISSION_64] =
    {
        .stageID = STAGE_Z71,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    [MISSION_65] =
    {
        .stageID = STAGE_Z72,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
        },
    },

    [MISSION_66] =
    {
        .stageID = STAGE_Z72,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 200 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 200 },
        },
    },

    [MISSION_67] =
    {
        .stageID = STAGE_Z72,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 0 },
        },
    },

    [MISSION_68] =
    {
        .stageID = STAGE_Z72,
        .type = MISSION_TYPE_PERFORM_TRICKS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 30 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 30 },
        },
    },

    [MISSION_69] =
    {
        .stageID = STAGE_Z7B,
        .type = MISSION_TYPE_BOSS_REMATCH,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_70] =
    {
        .stageID = STAGE_Z7B,
        .type = MISSION_TYPE_DEFEAT_RIVAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_71] =
    {
        .stageID = STAGE_BOSS_FINAL,
        .type = MISSION_TYPE_BOSS_REMATCH,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_72] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_3,
        .type = MISSION_TYPE_PERFORM_TRICKS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 20 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 20 },
        },
    },

    [MISSION_73] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_3,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 0 },
        },
    },

    [MISSION_74] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_4,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 50 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 50 },
        },
    },

    [MISSION_75] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_5,
        .type = MISSION_TYPE_DEFEAT_ENEMIES,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 50, 00), .quota = 16 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 50, 00), .quota = 16 },
        },
    },

    [MISSION_76] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_5,
        .type = MISSION_TYPE_PERFORM_COMBOS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 11 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 11 },
        },
    },

    [MISSION_77] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_6,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_78] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_6,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    [MISSION_79] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_7,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_80] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_7,
        .type = MISSION_TYPE_PERFORM_COMBOS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 20 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 20 },
        },
    },

    [MISSION_81] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_8,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_82] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_8,
        .type = MISSION_TYPE_PASS_FLAGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
        },
    },

    [MISSION_83] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_9,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_84] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_10,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_85] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_11,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_86] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_12,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_87] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_12,
        .type = MISSION_TYPE_PASS_FLAGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
        },
    },

    [MISSION_88] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_13,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_89] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_14,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_90] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_14,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 50, 00), .quota = 50 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 50, 00), .quota = 50 },
        },
    },

    [MISSION_91] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_15,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_92] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_15,
        .type = MISSION_TYPE_DEFEAT_ENEMIES,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 15 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 15 },
        },
    },

    [MISSION_93] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_16,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    [MISSION_94] =
    {
        .stageID = STAGE_HIDDEN_ISLAND_16,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
        },
    },

};

static const u32 objDataSizeForZone[ZONE_COUNT] = {
    [ZONE_PLANT_KINGDOM] = 183, [ZONE_MACHINE_LABYRINTH] = 192, [ZONE_CORAL_CAVE] = 202, [ZONE_HAUNTED_SHIP] = 173, [ZONE_BLIZZARD_PEAKS] = 205,
    [ZONE_SKY_BABYLON] = 178,   [ZONE_PIRATES_ISLAND] = 195,    [ZONE_BIG_SWELL] = 159,  [ZONE_HIDDEN_ISLAND] = 164
};

static BOOL bossStageTable[STAGE_COUNT] = { [STAGE_Z11]               = FALSE,
                                            [STAGE_Z12]               = FALSE,
                                            [STAGE_TUTORIAL]          = FALSE,
                                            [STAGE_Z1B]               = TRUE,
                                            [STAGE_Z21]               = FALSE,
                                            [STAGE_Z22]               = FALSE,
                                            [STAGE_Z2B]               = TRUE,
                                            [STAGE_Z31]               = FALSE,
                                            [STAGE_Z32]               = FALSE,
                                            [STAGE_HIDDEN_ISLAND_1]   = FALSE,
                                            [STAGE_Z3B]               = TRUE,
                                            [STAGE_Z41]               = FALSE,
                                            [STAGE_Z42]               = FALSE,
                                            [STAGE_Z4B]               = TRUE,
                                            [STAGE_Z51]               = FALSE,
                                            [STAGE_Z52]               = FALSE,
                                            [STAGE_Z5B]               = TRUE,
                                            [STAGE_Z61]               = FALSE,
                                            [STAGE_Z62]               = FALSE,
                                            [STAGE_HIDDEN_ISLAND_2]   = FALSE,
                                            [STAGE_Z6B]               = TRUE,
                                            [STAGE_Z71]               = FALSE,
                                            [STAGE_Z72]               = FALSE,
                                            [STAGE_Z7B]               = TRUE,
                                            [STAGE_BOSS_FINAL]        = TRUE,
                                            [STAGE_HIDDEN_ISLAND_3]   = FALSE,
                                            [STAGE_HIDDEN_ISLAND_4]   = FALSE,
                                            [STAGE_HIDDEN_ISLAND_5]   = FALSE,
                                            [STAGE_HIDDEN_ISLAND_6]   = FALSE,
                                            [STAGE_HIDDEN_ISLAND_7]   = FALSE,
                                            [STAGE_HIDDEN_ISLAND_8]   = FALSE,
                                            [STAGE_HIDDEN_ISLAND_9]   = FALSE,
                                            [STAGE_HIDDEN_ISLAND_10]  = FALSE,
                                            [STAGE_HIDDEN_ISLAND_11]  = FALSE,
                                            [STAGE_HIDDEN_ISLAND_12]  = FALSE,
                                            [STAGE_HIDDEN_ISLAND_13]  = FALSE,
                                            [STAGE_HIDDEN_ISLAND_14]  = FALSE,
                                            [STAGE_HIDDEN_ISLAND_15]  = FALSE,
                                            [STAGE_HIDDEN_ISLAND_16]  = FALSE,
                                            [STAGE_HIDDEN_ISLAND_VS1] = FALSE,
                                            [STAGE_HIDDEN_ISLAND_VS2] = FALSE,
                                            [STAGE_HIDDEN_ISLAND_VS3] = FALSE,
                                            [STAGE_HIDDEN_ISLAND_VS4] = FALSE,
                                            [STAGE_HIDDEN_ISLAND_R1]  = FALSE,
                                            [STAGE_HIDDEN_ISLAND_R2]  = FALSE,
                                            [STAGE_HIDDEN_ISLAND_R3]  = FALSE };

static u32 zoneIDForStageID[STAGE_COUNT] = { [STAGE_Z11]               = ZONE_PLANT_KINGDOM,
                                             [STAGE_Z12]               = ZONE_PLANT_KINGDOM,
                                             [STAGE_TUTORIAL]          = ZONE_PLANT_KINGDOM,
                                             [STAGE_Z1B]               = ZONE_PLANT_KINGDOM,
                                             [STAGE_Z21]               = ZONE_MACHINE_LABYRINTH,
                                             [STAGE_Z22]               = ZONE_MACHINE_LABYRINTH,
                                             [STAGE_Z2B]               = ZONE_MACHINE_LABYRINTH,
                                             [STAGE_Z31]               = ZONE_CORAL_CAVE,
                                             [STAGE_Z32]               = ZONE_CORAL_CAVE,
                                             [STAGE_HIDDEN_ISLAND_1]   = ZONE_HIDDEN_ISLAND,
                                             [STAGE_Z3B]               = ZONE_CORAL_CAVE,
                                             [STAGE_Z41]               = ZONE_HAUNTED_SHIP,
                                             [STAGE_Z42]               = ZONE_HAUNTED_SHIP,
                                             [STAGE_Z4B]               = ZONE_HAUNTED_SHIP,
                                             [STAGE_Z51]               = ZONE_BLIZZARD_PEAKS,
                                             [STAGE_Z52]               = ZONE_BLIZZARD_PEAKS,
                                             [STAGE_Z5B]               = ZONE_BLIZZARD_PEAKS,
                                             [STAGE_Z61]               = ZONE_SKY_BABYLON,
                                             [STAGE_Z62]               = ZONE_SKY_BABYLON,
                                             [STAGE_HIDDEN_ISLAND_2]   = ZONE_HIDDEN_ISLAND,
                                             [STAGE_Z6B]               = ZONE_SKY_BABYLON,
                                             [STAGE_Z71]               = ZONE_PIRATES_ISLAND,
                                             [STAGE_Z72]               = ZONE_PIRATES_ISLAND,
                                             [STAGE_Z7B]               = ZONE_PIRATES_ISLAND,
                                             [STAGE_BOSS_FINAL]        = ZONE_BIG_SWELL,
                                             [STAGE_HIDDEN_ISLAND_3]   = ZONE_HIDDEN_ISLAND,
                                             [STAGE_HIDDEN_ISLAND_4]   = ZONE_CORAL_CAVE,
                                             [STAGE_HIDDEN_ISLAND_5]   = ZONE_HIDDEN_ISLAND,
                                             [STAGE_HIDDEN_ISLAND_6]   = ZONE_PLANT_KINGDOM,
                                             [STAGE_HIDDEN_ISLAND_7]   = ZONE_PLANT_KINGDOM,
                                             [STAGE_HIDDEN_ISLAND_8]   = ZONE_CORAL_CAVE,
                                             [STAGE_HIDDEN_ISLAND_9]   = ZONE_MACHINE_LABYRINTH,
                                             [STAGE_HIDDEN_ISLAND_10]  = ZONE_MACHINE_LABYRINTH,
                                             [STAGE_HIDDEN_ISLAND_11]  = ZONE_CORAL_CAVE,
                                             [STAGE_HIDDEN_ISLAND_12]  = ZONE_BLIZZARD_PEAKS,
                                             [STAGE_HIDDEN_ISLAND_13]  = ZONE_BLIZZARD_PEAKS,
                                             [STAGE_HIDDEN_ISLAND_14]  = ZONE_HIDDEN_ISLAND,
                                             [STAGE_HIDDEN_ISLAND_15]  = ZONE_HAUNTED_SHIP,
                                             [STAGE_HIDDEN_ISLAND_16]  = ZONE_HIDDEN_ISLAND,
                                             [STAGE_HIDDEN_ISLAND_VS1] = ZONE_PLANT_KINGDOM,
                                             [STAGE_HIDDEN_ISLAND_VS2] = ZONE_MACHINE_LABYRINTH,
                                             [STAGE_HIDDEN_ISLAND_VS3] = ZONE_CORAL_CAVE,
                                             [STAGE_HIDDEN_ISLAND_VS4] = ZONE_HAUNTED_SHIP,
                                             [STAGE_HIDDEN_ISLAND_R1]  = ZONE_HIDDEN_ISLAND,
                                             [STAGE_HIDDEN_ISLAND_R2]  = ZONE_HIDDEN_ISLAND,
                                             [STAGE_HIDDEN_ISLAND_R3]  = ZONE_HIDDEN_ISLAND };

u16 _02133988[4];
u16 _02133990[6];

// --------------------
// FUNCTIONS
// --------------------

void InitSkipTitleCardEvent(void)
{
    // Nothin'
}

void InitZoneSysEvent(void)
{
    mainMemProcessor = MI_GetMainMemoryPriority();
    if (gameState.gameMode == GAMEMODE_VS_BATTLE && (gameState.gameFlag & GAME_FLAG_USE_WIFI) != 0)
    {
        if (mainMemProcessor != MI_PROCESSOR_ARM9)
            MI_SetMainMemoryPriority(MI_PROCESSOR_ARM9);
    }
    else
    {
        if (mainMemProcessor != MI_PROCESSOR_ARM7)
            MI_SetMainMemoryPriority(MI_PROCESSOR_ARM7);
    }

    switch (gameState.gameMode)
    {
        case GAMEMODE_STORY:
        case GAMEMODE_MISSION:
            gameState.difficulty = saveGame.stage.status.difficulty;
            break;

        default:
            gameState.difficulty = DIFFICULTY_NORMAL;
            break;
    }
}

void ExitTitleCardSysEvent(void)
{
    SysEventList *list = GetSysEventList();

    if ((list->currentEventID != SYSEVENT_TITLECARD || list->requestedEventID != SYSEVENT_STAGE_ACTIVE) && mainMemProcessor != MI_GetMainMemoryPriority())
        MI_SetMainMemoryPriority(mainMemProcessor);
}

void InitLoadStageEvent(void)
{
    ChangeEventForStageStart();
    NextSysEvent();
}

void InitZoneEvent(void)
{
    GameState *state = GetGameState();

    state->gameFlag &= ~(GAME_FLAG_USE_WIFI | GAME_FLAG_IS_VS_BATTLE | GAME_FLAG_10);

    InitPlayerStatus();
    SetSpatialAudioDropoffRate(FLOAT_TO_FX32(340.0));
    SetSpatialAudioDistanceThreshold(FLOAT_TO_FX32(40.0));

    if (state->gameMode == GAMEMODE_TIMEATTACK)
    {
        if (state->playerGhostRead == NULL)
        {
            state->playerGhostRead = HeapAllocHead(HEAP_USER, PLAYER_REPLAY_MAX_TIME * sizeof(PlayerGhostFrame));
            MI_CpuClear16(state->playerGhostRead, PLAYER_REPLAY_MAX_TIME * sizeof(PlayerGhostFrame));
        }

        if (state->playerGhostWrite == NULL)
        {
            state->playerGhostWrite = HeapAllocHead(HEAP_USER, PLAYER_REPLAY_MAX_TIME * sizeof(PlayerGhostFrame));
            MI_CpuClear16(state->playerGhostWrite, PLAYER_REPLAY_MAX_TIME * sizeof(PlayerGhostFrame));
        }

        if (state->replayKeyBuffer == NULL)
        {
            state->replayKeyBuffer = HeapAllocHead(HEAP_USER, sizeof(u32) + (2559 * sizeof(KeyDataPadFrame)));
            MI_CpuClear16(state->replayKeyBuffer, sizeof(u32) + (2559 * sizeof(KeyDataPadFrame)));
            state->replayRecordStageID = STAGE_NONE;
        }
    }
    else if (state->gameMode == GAMEMODE_MISSION)
    {
        playerGameStatus.missionStatus.stageTimeLimit = state->missionConfig.stage.timeLimit;
        playerGameStatus.missionStatus.quotaTarget    = mtMathRand();

        switch ((s32)state->missionType)
        {
            case MISSION_TYPE_COLLECT_RINGS:
                playerGameStatus.missionStatus.quota = state->missionConfig.stage.quota;
                break;

            case MISSION_TYPE_DEFEAT_ENEMIES:
                playerGameStatus.missionStatus.quota = state->missionConfig.stage.quota;
                break;

            case MISSION_TYPE_PERFORM_COMBOS:
                playerGameStatus.missionStatus.quota = state->missionConfig.stage.quota;
                break;

            case MISSION_TYPE_PERFORM_TRICKS:
                playerGameStatus.missionStatus.quota = state->missionConfig.stage.quota;
                break;
        }
    }
    else if (state->gameMode == GAMEMODE_DEMO)
    {
        GetDemoSpawnPosition(&playerGameStatus.spawnPosition.x, &playerGameStatus.spawnPosition.y);
    }

    CreateGameDataRequest(GAMEDATA_LOADPROC_ALL);
}

void InitVSBattleEvent(void)
{
    InitPlayerStatus();

    gameState.gameFlag |= GAME_FLAG_IS_VS_BATTLE;

    GameDataLoadProc load_proc = (gameState.gameFlag & GAME_FLAG_10) != 0 ? GAMEDATA_LOADPROC_NONE : GAMEDATA_LOADPROC_ALL;
    CreateGameDataRequest(load_proc);
}

void InitStageMission(s32 id)
{
    gameState.gameFlag                      = GAME_FLAG_NONE;
    gameState.gameMode                      = GAMEMODE_MISSION;
    gameState.clearedMission                = FALSE;
    gameState.stageID                       = missionList[id].stageID;
    gameState.missionType                   = missionList[id].type;
    gameState.missionConfig.stage.timeLimit = missionList[id].config[gameState.difficulty].timeLimit;
    gameState.missionConfig.stage.quota     = missionList[id].config[gameState.difficulty].quota;
}

void CreateGameDataRequest(GameDataLoadProc load_proc)
{
    if (load_proc != GAMEDATA_LOADPROC_NONE)
        gameDataTask = TaskCreate(GameDataRequest_Main_TryLoadCommonAssets, NULL, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1000, TASK_GROUP(3), GameDataRequest);
    else
        gameDataTask = TaskCreate(GameDataRequest_Main_BuildArea, NULL, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1000, TASK_GROUP(3), GameDataRequest);

    TaskGetWork(gameDataTask, GameDataRequest)->load_proc = load_proc;
}

void ReleaseGameSystem(void)
{
    ClearPixelsQueue();
    Mappings__ClearQueue();
    ClearPaletteQueue();
    ReleaseStageBGM();
    ShutdownGameSystemTasks();
    SetPadReplayState(REPLAY_MODE_FORCE_QUIT);
    StarCombo__Destroy();
    BossArena__Destroy();

    if (Camera3D__GetTask() != NULL)
    {
        Camera3D__Destroy();
        if ((gameState.gameFlag & (GAME_FLAG_PLAYER_RESPAWNED | GAME_FLAG_PLAYER_RESTARTED)) == 0)
            SetupDisplayForZone(FALSE);
    }

    ReleaseStageArea();
    ReleaseStageCommonAssets();

    if (playerGameStatus.sendPacketList != NULL)
    {
        HeapFree(HEAP_USER, playerGameStatus.sendPacketList);
        playerGameStatus.sendPacketList = NULL;
    }
}

void FlushGameSystem(u8 flags)
{
    if ((flags & GAMEDATA_LOADPROC_STAGE) != 0)
        FlushStageArea();

    if ((flags & GAMEDATA_LOADPROC_COMMON) != 0)
    {
        ReleaseStageCommonArchives();
        VRAMSystem__InitTextureBuffer();
        VRAMSystem__InitPaletteBuffer();
    }

    if (gameArchiveMission != NULL)
    {
        HeapFree(HEAP_USER, gameArchiveMission);
        gameArchiveMission = NULL;
    }

    ReleaseAudioSystem();
    ReleaseTouchInput();
}

void ReleaseGameState(void)
{
    GameState *state = GetGameState();

    if (state->playerGhostRead != NULL)
    {
        HeapFree(HEAP_USER, state->playerGhostRead);
        state->playerGhostRead = NULL;
    }

    if (state->playerGhostWrite != NULL)
    {
        HeapFree(HEAP_USER, state->playerGhostWrite);
        state->playerGhostWrite = NULL;
    }

    if (state->replayKeyBuffer != NULL)
    {
        HeapFree(HEAP_USER, state->replayKeyBuffer);
        state->replayKeyBuffer = NULL;
    }

    state->replayStageID     = 0;
    state->replayCharacterID = 0;
    state->replayStageTimer  = 0;
}

void InitGameSystemForStage(void)
{
    GameState *state = GetGameState();

    InitPadInput(&playerGameStatus.input, NULL, NULL);
    if (state->gameMode == GAMEMODE_DEMO)
    {
        CreateReplayRecorderPadEx(REPLAYRECORDER_TYPE_PLAY_FILE, &playerGameStatus.input, GetCurrentDemoPath(), 0, 0, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x10FF);
        CreateDemoPlayer();
        CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS | DRAW_FADE_TASK_FLAG_FADE_TO_BLACK, FLOAT_TO_FX32(0.5));
    }
    else if (state->gameMode == GAMEMODE_TIMEATTACK)
    {
        ReplayRecorderType type;
        u16 priority;

        if ((state->gameFlag & GAME_FLAG_REPLAY_STARTED) != 0)
        {
            type     = REPLAYRECORDER_TYPE_PLAY_MEMORY;
            priority = TASK_PRIORITY_UPDATE_LIST_START + 0x10FF;
        }
        else
        {
            type                       = REPLAYRECORDER_TYPE_RECORD;
            state->replayRecordStageID = STAGE_NONE;
            priority                   = TASK_PRIORITY_UPDATE_LIST_START + 0x1101;
        }

        CreateReplayRecorderPadEx(type, &playerGameStatus.input, 0, state->replayKeyBuffer, sizeof(KeyDataHeader) + (2559 * sizeof(KeyDataPadFrame)), 0, priority);
    }

    if ((state->gameFlag & (GAME_FLAG_PLAYER_RESPAWNED | GAME_FLAG_PLAYER_RESTARTED)) != 0)
        CreateGameSystemEx();
    else
        CreateGameSystem();
}

void SetupDisplayForZone(BOOL resetTexPaletteBuffers)
{
    GX_SetPower(GX_POWER_ALL);
    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    GX_DisableBankForBG();
    GX_DisableBankForOBJ();
    GX_DisableBankForBGExtPltt();
    GX_DisableBankForOBJExtPltt();
    GX_DisableBankForTex();
    GX_DisableBankForTexPltt();
    GX_DisableBankForClearImage();
    GX_DisableBankForSubBG();
    GX_DisableBankForSubOBJ();
    GX_DisableBankForSubBGExtPltt();
    GX_DisableBankForSubOBJExtPltt();
    GX_DisableBankForARM7();
    GX_DisableBankForLCDC();

    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_64_E, GX_OBJVRAMMODE_CHAR_1D_64K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x400);
    VRAMSystem__InitSpriteBuffer(FALSE);
    VRAMSystem__SetupBGBank(GX_VRAM_BG_128_B);
    VRAMSystem__SetupBGExtPalBank(GX_VRAM_BGEXTPLTT_23_G);
    VRAMSystem__SetupTextureBank(GX_VRAM_TEX_0_A);
    VRAMSystem__SetupTexturePalBank(GX_VRAM_TEXPLTT_0_F);
    if (!resetTexPaletteBuffers)
    {
        VRAMSystem__InitTextureBuffer();
        VRAMSystem__InitPaletteBuffer();
    }
    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_5, GX_BG0_AS_3D);
    GX_SetBGScrOffset(GX_BGSCROFFSET_0x00000);
    GX_SetBGCharOffset(GX_BGCHAROFFSET_0x00000);

    renderCoreSwapBuffer.sortMode   = GX_SORTMODE_AUTO;
    renderCoreSwapBuffer.bufferMode = GX_BUFFERMODE_W;

    G3X_SetShading(GX_SHADING_TOON);
    G3X_AntiAlias(TRUE);
    G3X_AlphaTest(FALSE, 0);
    G3X_AlphaBlend(TRUE);
    G3X_EdgeMarking(TRUE);
    G3X_SetClearColor(GX_RGB_888(0x00, 0x00, 0x00), GX_COLOR_FROM_888(0x00), 0x7FFF, 0, FALSE);

    G3_SwapBuffers(renderCoreSwapBuffer.sortMode, renderCoreSwapBuffer.bufferMode);
    G3_ViewPort(0, 0, HW_LCD_WIDTH - 1, HW_LCD_HEIGHT - 1);

    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_512x512, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x4000, GX_BG_CHARBASE_0x08000, GX_BG_EXTPLTT_23);
    G2_SetBG2Control256x16Pltt(GX_BG_SCRSIZE_256x16PLTT_512x512, GX_BG_AREAOVER_XLU, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x10000);
    G2_SetBG3Control256x16Pltt(GX_BG_SCRSIZE_256x16PLTT_512x512, GX_BG_AREAOVER_XLU, GX_BG_SCRBASE_0x2000, GX_BG_CHARBASE_0x10000);

    G2_SetBG0Priority(1);
    G2_SetBG1Priority(3);
    G2_SetBG2Priority(0);
    G2_SetBG3Priority(2);

    GX_SetMasterBrightness(renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_WHITE);

    GX_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1 | GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3 | GX_PLANEMASK_OBJ);
    renderCoreGFXControlA.blendManager.blendControl.effect = BLENDTYPE_NONE;

    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_128_D, GX_OBJVRAMMODE_CHAR_1D_64K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x400);
    VRAMSystem__InitSpriteBuffer(TRUE);
    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_128_C);
    VRAMSystem__SetupSubBGExtPalBank(GX_VRAM_SUB_BGEXTPLTT_0123_H);
    GXS_SetGraphicsMode(GX_BGMODE_5);

    G2S_SetBG0Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x6000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_23);
    G2S_SetBG1Control(GX_BG_SCRSIZE_TEXT_512x512, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x4000, GX_BG_CHARBASE_0x08000, GX_BG_EXTPLTT_23);
    G2S_SetBG2Control256x16Pltt(GX_BG_SCRSIZE_256x16PLTT_512x512, GX_BG_AREAOVER_XLU, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x10000);
    G2S_SetBG3Control256x16Pltt(GX_BG_SCRSIZE_256x16PLTT_512x512, GX_BG_AREAOVER_XLU, GX_BG_SCRBASE_0x2000, GX_BG_CHARBASE_0x10000);

    G2S_SetBG0Priority(0);
    G2S_SetBG1Priority(3);
    G2S_SetBG2Priority(0);
    G2S_SetBG3Priority(2);

    GXS_SetMasterBrightness(renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_WHITE);

    GXS_SetVisiblePlane(GX_PLANEMASK_BG1 | GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3 | GX_PLANEMASK_OBJ);
    renderCoreGFXControlB.blendManager.blendControl.effect = BLENDTYPE_NONE;
}

void SetupDisplayForBoss(BOOL resetTexPaletteBuffers)
{
    GX_SetPower(GX_POWER_ALL);
    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    VRAMSystem__Reset();
    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_16_G, GX_OBJVRAMMODE_CHAR_1D_64K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x100);
    VRAMSystem__InitSpriteBuffer(FALSE);
    VRAMSystem__SetupBGBank(GX_VRAM_BG_64_E);
    VRAMSystem__SetupTextureBank(GX_VRAM_TEX_01_AB);
    VRAMSystem__SetupTexturePalBank(GX_VRAM_TEXPLTT_0_F);
    if (!resetTexPaletteBuffers)
    {
        VRAMSystem__InitTextureBuffer();
        VRAMSystem__InitPaletteBuffer();
    }

    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_3, GX_BG0_AS_3D);
    GX_SetBGScrOffset(GX_BGSCROFFSET_0x00000);
    GX_SetBGCharOffset(GX_BGCHAROFFSET_0x00000);

    renderCoreSwapBuffer.sortMode   = GX_SORTMODE_AUTO;
    renderCoreSwapBuffer.bufferMode = GX_BUFFERMODE_W;

    G3X_SetShading(GX_SHADING_TOON);
    G3X_AntiAlias(TRUE);
    G3X_AlphaTest(FALSE, 0);
    G3X_AlphaBlend(TRUE);
    G3X_EdgeMarking(TRUE);
    G3X_SetClearColor(GX_RGB_888(0x00, 0x00, 0x00), GX_COLOR_FROM_888(0x00), 0x7FFF, 0, FALSE);

    G3_SwapBuffers(renderCoreSwapBuffer.sortMode, renderCoreSwapBuffer.bufferMode);
    G3_ViewPort(0, 0, HW_LCD_WIDTH - 1, HW_LCD_HEIGHT - 1);

    G2_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1000, GX_BG_CHARBASE_0x0c000);

    G2_SetBG0Priority(1);
    G2_SetBG1Priority(3);
    G2_SetBG2Priority(0);
    G2_SetBG3Priority(2);

    GX_SetMasterBrightness(renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_WHITE);
    GX_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_OBJ);
    renderCoreGFXControlA.blendManager.blendControl.effect = BLENDTYPE_NONE;

    GXS_SetMasterBrightness(renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_WHITE);
    renderCoreGFXControlB.blendManager.blendControl.effect = BLENDTYPE_NONE;
}

void InitStageBlendControl(void)
{
    s32 i;

    BlendController *blendManager = &VRAMSystem__GFXControl[0]->blendManager;
    for (i = 0; i < 2; i++)
    {
        blendManager->blendControl.value = 0x00;

        blendManager->blendControl.effect = BLENDTYPE_ALPHA;

        blendManager->blendControl.plane2_BG0 = TRUE;
        blendManager->blendControl.plane2_BG1 = TRUE;
        blendManager->blendControl.plane2_BG2 = TRUE;
        blendManager->blendControl.plane2_BG3 = TRUE;

        switch (gameState.characterID[0])
        {
            case CHARACTER_SONIC:
                blendManager->blendAlpha.value = REG_G2_BLDALPHA_FIELD(0xE, 0xC);
                break;

            case CHARACTER_BLAZE:
                blendManager->blendAlpha.value = REG_G2_BLDALPHA_FIELD(0x7, 0x9);
                break;
        }

        blendManager = &VRAMSystem__GFXControl[1]->blendManager;
    }
}

void InitPlayerStatus(void)
{
    GameState *state = GetGameState();

    if ((state->gameFlag & GAME_FLAG_RECALL_ACTIVE) == 0)
    {
        MI_CpuClear16(&playerGameStatus, sizeof(playerGameStatus));

        playerGameStatus.sendPacketTicks[PLAYER_CONTROL_P2] = 0xFFFF;
        playerGameStatus.receivedPacketTicks[PLAYER_CONTROL_P2] = 0xFFFF;
        InitPadInput(&playerGameStatus.input, NULL, NULL);

        if (state->gameMode == GAMEMODE_DEMO || gmCheckReplayActive())
            playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_DISABLE_PLAYER_INPUTS;

        if ((state->gameFlag & GAME_FLAG_USE_WIFI) != 0)
        {
            ObjSendPacket *packetWork = ObjPacket__QueueSendPacket(NULL, GAMEPACKET_UNKNOWN, 3, 0);
            if (packetWork != NULL)
                packetWork->header.param = playerGameStatus.sendPacketTicks[PLAYER_CONTROL_P1];
        }

        state->gameFlag &= ~(GAME_FLAG_PLAYER_RESPAWNED | GAME_FLAG_REPLAY_GHOST_ACTIVE | GAME_FLAG_100 | GAME_FLAG_HAS_TIME_OVER | GAME_FLAG_PLAYER_RESTARTED);
        state->vsBattleResult = 0;
        if (state->gameMode == GAMEMODE_DEMO)
            playerGameStatus.lives = PLAYER_STARTING_LIVES;
        else
            playerGameStatus.lives = saveGame.stage.status.lives;
    }

    BOOL resetTexPaletteBuffers = (state->gameFlag & GAME_FLAG_10) != 0;
    if (!IsBossStage())
        SetupDisplayForZone(resetTexPaletteBuffers);
    else
        SetupDisplayForBoss(resetTexPaletteBuffers);

    InitSpatialAudioConfig();
    MapSys__Init();
    EventManager__Init();
    ResetTouchInput();
}

void GameDataRequest_Main_TryLoadCommonAssets(void)
{
    GameDataRequest *work = TaskGetWorkCurrent(GameDataRequest);

    InitGameDataLoadContext(GAMEDATA_FILEREQ_MODE_0);
    if ((work->load_proc & GAMEDATA_LOADPROC_COMMON) != 0)
        SetCurrentTaskMainEvent(GameDataRequest_Main_AwaitLoadCommonAssets);
    else
        SetCurrentTaskMainEvent(GameDataRequest_Main_TryLoadStage);
}

void GameDataRequest_Main_AwaitLoadCommonAssets(void)
{
    if (LoadStageCommonAssets() == GAMEDATA_FILEREQ_STATUS_COMPLETE)
        SetCurrentTaskMainEvent(GameDataRequest_Main_TryLoadStage);
}

void GameDataRequest_Main_TryLoadStage(void)
{
    GameDataRequest *work = TaskGetWorkCurrent(GameDataRequest);

    InitGameDataLoadContext(GAMEDATA_FILEREQ_MODE_0);
    if ((work->load_proc & GAMEDATA_LOADPROC_STAGE) != 0)
    {
        SetCurrentTaskMainEvent(GameDataRequest_Main_AwaitLoadStageAssets);
    }
    else
    {
        SetCurrentTaskMainEvent(GameDataRequest_Main_BuildArea);
        LoadGameMissionArchive();
    }
}

void GameDataRequest_Main_AwaitLoadStageAssets(void)
{
    if (LoadStageAssets() == GAMEDATA_FILEREQ_STATUS_COMPLETE)
    {
        SetCurrentTaskMainEvent(GameDataRequest_Main_BuildArea);
        LoadGameMissionArchive();
    }
}

void GameDataRequest_Main_BuildArea(void)
{
    BuildStageCommonAssets();
    BuildStageArea();
    DestroyCurrentTask();
    NextSysEvent();
}

void InitStageCollision(void)
{
    stageCollision.diffCollision = mapSysFiles.collisionHeightMasks;
    stageCollision.dirCollision  = mapSysFiles.collisionAngles;
    stageCollision.mapBlockset   = mapSysFiles.blockset;
    stageCollision.mapLayout[0]  = mapSysFiles.mapLayout[0]->blocks;
    stageCollision.mapLayout[1]  = mapSysFiles.mapLayout[1]->blocks;
    stageCollision.attrCollision = mapSysFiles.collisionAttributes;
    stageCollision.blockWidth    = mapSysFiles.mapLayout[0]->width;
    stageCollision.blockHeight   = mapSysFiles.mapLayout[0]->height;

    stageCollision.left   = 0;
    stageCollision.top    = 0;
    stageCollision.right  = stageCollision.blockWidth << 6;
    stageCollision.bottom = stageCollision.blockHeight << 6;

    ObjSetDiffCollision(&stageCollision);
}

void LoadGameMissionArchive(void)
{
    if (gameState.gameMode == GAMEMODE_MISSION || gmCheckRaceStage() || gmCheckReplayActive())
        gameArchiveMission = FSRequestFileSync("/narc/gm_mission.narc", FSREQ_AUTO_ALLOC_HEAD);
}

void CreateGameSystem(void)
{
    Player **playerList;
    GameState *state = GetGameState();

    playerGameStatus.taskEarly = TaskCreateNoWork(GameSystem_Main_Early, NULL, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1000, TASK_GROUP(3), "GameSysEarlyTask");
    playerGameStatus.taskLate  = TaskCreate(GameSystem_Main_Late, NULL, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x8000, TASK_GROUP(3), GameSysLateTask);

    GameSysLateTask *work = TaskGetWork(playerGameStatus.taskLate, GameSysLateTask);
    TaskInitWork16(work);

    if ((state->gameFlag & GAME_FLAG_IS_VS_BATTLE) == 0 && (state->gameFlag & GAME_FLAG_PLAYER_RESPAWNED) != 0)
        playerGameStatus.stageTimer = playerGameStatus.recallTime;

    if (state->gameMode == GAMEMODE_TIMEATTACK)
    {
        if ((state->gameFlag & GAME_FLAG_REPLAY_STARTED) != 0)
        {
            playerGameStatus.flags &= PLAYERGAMESTATUS_FLAG_DISABLE_PLAYER_INPUTS;
            CreateReplayViewer();
        }
        else
        {
            playerGameStatus.flags = PLAYERGAMESTATUS_FLAG_NONE;
        }

        playerGameStatus.stageTimer          = 0;
        playerGameStatus.trickBonus          = 0;
        playerGameStatus.speedBonus          = 0;
        playerGameStatus.speedBonusCount     = 0;
        playerGameStatus.ringBonus           = 0;
        playerGameStatus.clearStateFlag      = 0;
        playerGameStatus.lives               = PLAYER_TIMEATTACK_LIVES;
        playerGameStatus.recallCheckpointID  = 0;
        playerGameStatus.recallTime          = 0;
        playerGameStatus.playerLapCounter[0] = playerGameStatus.playerLapCounter[1] = 0;
        playerGameStatus.playerTargetLaps[0] = playerGameStatus.playerTargetLaps[1] = 0;
    }
    else
    {
        if (gmCheckRingBattle())
            CreateRingBattleManager();
    }

    InitStageLightConfig();
    InitStageEdgeConfig();
    CreateObjectManager();

    if ((gameState.gameFlag & GAME_FLAG_USE_WIFI) != 0)
        ObjPacket__Init(NULL, OBJPACKET_MODE_WIFI, 0x108);
    else
        ObjPacket__Init(NULL, OBJPACKET_MODE_WIRELESS, whConfig_wmMinDataSize);

    AllocObjectFileWork(objDataSizeForZone[GetCurrentZoneID()]);

    g_obj.flag       = OBJECTMANAGER_FLAG_USE_DIFF_COLLISIONS | OBJECTMANAGER_FLAG_ALLOW_RECT_COLLISIONS | OBJECTMANAGER_FLAG_ENABLE_CAMERA;
    g_obj.depth      = 128;
    g_obj.spriteMode = 1;

    if (IsBossStage())
        g_obj.flag |= OBJECTMANAGER_FLAG_80000;

    ObjDrawSetManagedRows(3, 16);
    EventManager__Create();
    EventManager__CreateEventEnforce();
    MapSys__Create();
    InitStageCollision();

    if (IsBossStage())
    {
        g_obj.flag |= OBJECTMANAGER_FLAG_ENABLE_FULL_3D;
        g_obj.flag &= ~OBJECTMANAGER_FLAG_ENABLE_CAMERA;
    }

    MI_CpuClear16(gPlayerList, sizeof(gPlayerList));

    if ((state->gameFlag & GAME_FLAG_IS_VS_BATTLE) != 0)
    {
        u16 aid;
        if ((state->gameFlag & GAME_FLAG_USE_WIFI) != 0)
        {
            CreateConnectionStatusHUD(TRUE);
            aid = DWC_GetMyAID();
        }
        else
        {
            CreateConnectionStatusHUD(FALSE);
            aid = WH_GetCurrentAid();
        }

        Player *player = Player__Create(state->characterID[0], ObjPacket__GetAIDIndex(aid));

        gPlayer        = player;
        gPlayerList[0] = player;

        s16 id     = 1;
        playerList = gPlayerList;
        for (s32 p = 0; p < 2; p++)
        {
            if (p != aid)
            {
                playerList[id] = Player__Create(state->characterID[id + 1], ObjPacket__GetAIDIndex(p));

                Animator3D__Process(&playerList[id]->aniPlayerModel.ani.work);

                if ((playerList[id]->playerFlag & PLAYER_FLAG_TAIL_IS_ACTIVE) != 0)
                {
                    Animator3D__Process(&playerList[id]->aniTailModel.ani.work);
                }

                id++;
            }
        }

        CreateTargetIndicatorHUD(&gPlayerList[1]->objWork);

        if (!gmCheckRaceStage() && gameState.vsBattleType == VSBATTLE_RACE)
            CreateRaceProgressHUD(gPlayer->characterID);
    }
    else
    {
        gPlayerList[0] = gPlayer = Player__Create(state->characterID[0], 0);

        state->gameFlag &= ~GAME_FLAG_REPLAY_GHOST_ACTIVE;

        if ((state->gameMode == GAMEMODE_TIMEATTACK && state->replayStageID == state->stageID) && state->replayStageTimer != 0 && (state->gameFlag & GAME_FLAG_REPLAY_STARTED) == 0
            && !IsBossStage())
        {
            state->gameFlag |= GAME_FLAG_REPLAY_GHOST_ACTIVE;
            gPlayerList[1] = Player__Create(state->replayCharacterID, 1);
        }
    }

    if (IsSnowboardActive())
    {
        SpawnLostPlayerSnowboard(0);
        Player__Action_EnableSnowboard(gPlayer, 1);
    }

    gPlayer->playerFlag |= PLAYER_FLAG_DISABLE_INPUT_READ;

    CreateRingManager();
    CreateHUD(IsBossStage() == FALSE);
    SetHUDVisible(TRUE);

    if (gmCheckRaceStage())
        CreateLapTimeHUD();

    if (!IsBossStage())
        StarCombo__SpawnConfetti();

    if (!IsBossStage())
        DecorationSys__Create();

    BossArena__Create(IsBossStage() ? BOSSARENA_TYPE_3 : BOSSARENA_TYPE_0, TASK_PRIORITY_UPDATE_LIST_START + 0x10A0);
    g_obj.cameraConfig = BossArena__GetCameraConfig2(BossArena__GetCamera(0));

    playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_PLAYER_DIED;

    InitStageBlendControl();

    InitStageBGM();
    StartStageBGM(FALSE);

    if ((state->gameFlag & GAME_FLAG_RECALL_ACTIVE) != 0)
        state->gameFlag &= ~GAME_FLAG_RECALL_ACTIVE;

    if ((state->gameFlag & GAME_FLAG_IS_VS_BATTLE) != 0 && playerGameStatus.sendPacketList == NULL)
    {
        playerGameStatus.sendPacketList = HeapAllocHead(HEAP_USER, GAMESYSTEM_SENDPACKET_LIST_SIZE * sizeof(GameObjectSendPacket));
        MI_CpuClear8(playerGameStatus.sendPacketList, GAMESYSTEM_SENDPACKET_LIST_SIZE * sizeof(GameObjectSendPacket));
        playerGameStatus.sendPacketCount = 0;
    }
}

void CreateGameSystemEx(void)
{
    gameState.gameFlag &= ~GAME_FLAG_PLAYER_RESTARTED;

    if (!IsBossStage())
        SetupDisplayForZone(TRUE);
    else
        SetupDisplayForBoss(TRUE);

    BuildStageCommonAssets();
    BuildStageArea();
    CreateGameSystem();
}

void ShutdownGameSystemTasks(void)
{
    for (u8 i = TASK_GROUP(1); i < TASK_GROUP(6); i++)
    {
        DestroyTaskGroup(i);
    }
}

void GameSystem_Main_Early(void)
{
    GameState *state = GetGameState();

    NNS_SndCaptureStopReverb(0);
    NNS_SndCaptureStopEffect();
    NNS_SndCaptureStopSampling();
    NNS_SndCaptureStopOutputEffect();
    NNS_SndUpdateDriverInfo();

    if ((state->gameFlag & GAME_FLAG_IS_VS_BATTLE) != 0)
    {
        if ((gameState.gameFlag & GAME_FLAG_USE_WIFI) != 0)
        {
            if (DWC_UpdateConnection() || DWC_GetNumConnectionHost() != 2 || DWC_GetLastError(NULL))
                playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_NETWORK_ERROR;
        }
        else if (WirelessManager__GetField8() == 7)
        {
            playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_NETWORK_ERROR;
        }

        if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_NETWORK_ERROR) != 0)
        {
            HandleNetworkError();
            return;
        }

        if ((state->gameFlag & GAME_FLAG_USE_WIFI) != 0)
        {
            ObjPacket__PrepareReceivedPackets();

            if (gPlayerList[PLAYER_CONTROL_P2] != NULL)
            {
                ObjReceivePacket *packet = ObjPacket__GetNextReceivedPacket(GAMEPACKET_UNKNOWN, gPlayerList[PLAYER_CONTROL_P2]->aidIndex);
                if (packet != NULL)
                {
                    if (playerGameStatus.receivedPacketTicks[PLAYER_CONTROL_P2] < packet->header.param || (playerGameStatus.receivedPacketTicks[PLAYER_CONTROL_P2] > 32168 && packet->header.param < 600))
                    {
                        playerGameStatus.receivedPacketTicks[PLAYER_CONTROL_P2] = packet->header.param;
                        playerGameStatus.sendPacketTicks[PLAYER_CONTROL_P2] = packet->header.param;
                    }
                    else
                    {
                        playerGameStatus.sendPacketTicks[PLAYER_CONTROL_P2]++;
                    }
                }
                else
                {
                    playerGameStatus.sendPacketTicks[PLAYER_CONTROL_P2] = 0xFFFF;
                }
            }
        }

        ObjPacket__PrepareReceivedPackets();

        ObjReceivePacket *ringPacket = ObjPacket__GetNextReceivedPacket(GAMEPACKET_RINGCOUNT, gPlayerList[PLAYER_CONTROL_P2]->aidIndex);
        if (ringPacket != NULL)
            gPlayerList[PLAYER_CONTROL_P2]->rings = ringPacket->header.param;

        if ((gPlayer->playerFlag & PLAYER_FLAG_FINISHED_STAGE) != 0)
        {
            if ((playerGameStatus.stageScoreEventTimer & 0x3F) == 0)
                SendPacketForStageScoreEvent();

            playerGameStatus.stageScoreEventTimer++;
        }

        if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_STAGEFINISHEVENT_SENT) != 0)
        {
            if ((playerGameStatus.stageFinishEventTimer & 0x3F) == 0)
                SendPacketForStageFinishEvent();

            playerGameStatus.stageFinishEventTimer++;
        }

        if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_STAGESCOREEVENT_ACTIVE) == 0)
        {
            ObjPacket__PrepareReceivedPackets();

            s32 *opponentStageScore = ObjPacket__GetNextReceivedPacketData(GAMEPACKET_STAGESCORE, gPlayerList[PLAYER_CONTROL_P2]->aidIndex);
            if (opponentStageScore != NULL)
            {
                playerGameStatus.vsGoalPacket[PLAYER_CONTROL_P2].time = opponentStageScore[0];
                playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_STAGESCOREEVENT_ACTIVE;

                if ((gPlayer->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0)
                {
                    if (state->vsBattleType == VSBATTLE_RACE)
                    {
                        if (playerGameStatus.vsGoalPacket[PLAYER_CONTROL_P2].time >= AKUTIL_TIME_TO_FRAMES(10, 00, 00))
                        {
                            if (playerGameStatus.stageTimer < AKUTIL_TIME_TO_FRAMES(9, 47, 49))
                            {
                                playerGameStatus.stageTimer = AKUTIL_TIME_TO_FRAMES(10, 00, 00);
                                Player__Action_FinishMission(gPlayer, NULL);
                                playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_FREEZE_TIME;
                                CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(0.5));
                                playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_FADE_IS_ACTIVE;
                                FadeOutStageBGM(32);
                            }
                        }
                        else
                        {
                            Player__Action_FinishMission(gPlayer, NULL);
                            playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_FREEZE_TIME;
                        }
                    }
                    else
                    {
                        if (playerGameStatus.stageTimer < AKUTIL_TIME_TO_FRAMES(1, 47, 50))
                        {
                            playerGameStatus.stageTimer = AKUTIL_TIME_TO_FRAMES(2, 00, 00);
                            Player__Action_FinishMission(gPlayer, NULL);
                            playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_FREEZE_TIME;
                            CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED | DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS, FLOAT_TO_FX32(0.5));
                            playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_FADE_IS_ACTIVE;
                            FadeOutStageBGM(32);
                        }
                    }
                }
            }
        }

        if ((gPlayer->playerFlag & PLAYER_FLAG_FINISHED_STAGE) != 0 && (playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_NO_MORE_STAGEFINISHEVENTS) == 0)
        {
            ObjPacket__PrepareReceivedPackets();

            ObjReceivePacket *stageClearPacket = ObjPacket__GetNextReceivedPacket(GAMEPACKET_STAGEFINISH, gPlayerList[PLAYER_CONTROL_P2]->aidIndex);
            if (stageClearPacket != NULL)
            {
                if (stageClearPacket->header.param == 0 && (playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FADE_IS_ACTIVE) == 0)
                {
                    CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED | DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS, FLOAT_TO_FX32(1.0));
                    playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_FADE_IS_ACTIVE;
                    FadeOutStageBGM(16);
                }
            }
        }

        GameObject__ProcessReceivedPackets_ItemBox();
    }

    if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FADE_IS_ACTIVE) != 0)
    {
        if (IsDrawFadeTaskFinished())
            playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_CAN_CHANGE_EVENT;
    }
}

void GameSystem_Main_Late(void)
{
    GameState *state      = GetGameState();
    GameSysLateTask *work = TaskGetWorkCurrent(GameSysLateTask);

    UpdateTensionGaugeHUD(gPlayer->tension >> 4, FALSE);

    if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) != 0)
        playerGameStatus.stageTimer++;

    if ((g_obj.flag & OBJECTMANAGER_FLAG_ENABLE_FULL_3D) == 0)
    {
        fx32 offsetX = GetScreenShakeOffsetX();
        fx32 offsetY = GetScreenShakeOffsetY();
        SetObjOffset(FX32_TO_WHOLE(offsetX), FX32_TO_WHOLE(offsetY));
        mapCamera.camera[0].offset.x = -FX32_TO_WHOLE(GetScreenShakeOffsetX());
        mapCamera.camera[0].offset.y = -FX32_TO_WHOLE(GetScreenShakeOffsetY());

        mapCamera.camera[1].offset.x = mapCamera.camera[0].offset.x;
        mapCamera.camera[1].offset.y = mapCamera.camera[0].offset.y;
    }

    if ((state->gameFlag & GAME_FLAG_IS_VS_BATTLE) != 0)
    {
        GameObject__ProcessReceivedPackets_Unknown();

        if ((GetSystemFrameCounter() & 0x3F) == 0)
        {
            ObjSendPacket *ringPacket = ObjPacket__QueueSendPacket(NULL, GAMEPACKET_RINGCOUNT, 1, 0);
            if (ringPacket != NULL)
                ringPacket->header.param = gPlayer->rings;
        }

        if ((state->gameFlag & GAME_FLAG_USE_WIFI) == 0)
        {
            ObjPacket__WriteToSendBuffer();
            playerGameStatus.sendPacketCount = 0;
        }
        else
        {
            if (FX_ModS32(playerGameStatus.sendPacketTicks[PLAYER_CONTROL_P1] & ~0x80000000, 4) == 3)
            {
                BOOL sendFlag = ObjPacket__WriteToSendBuffer();
                if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_NEEDS_DATATRANSFER_CONFIG_INIT) != 0)
                {
                    SetDataTransferConfig(DWC_GetAIDBitmap(), 0x108, FALSE);
                    if (!sendFlag)
                        playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_NEEDS_DATATRANSFER_CONFIG_INIT;
                }
                else
                {
                    SetDataTransferConfig(DWC_GetAIDBitmap(), 0x108, TRUE);
                }

                ObjSendPacket *unknownPacket = ObjPacket__QueueSendPacket(NULL, GAMEPACKET_UNKNOWN, 3, 0);
                if (unknownPacket != NULL)
                    unknownPacket->header.param = (playerGameStatus.sendPacketTicks[PLAYER_CONTROL_P1] + 1) & 0x7FFF;

                playerGameStatus.sendPacketCount = 0;
            }
        }

        playerGameStatus.sendPacketTicks[PLAYER_CONTROL_P1] = (playerGameStatus.sendPacketTicks[PLAYER_CONTROL_P1] + 1) & 0x7FFF;
    }

    if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_CAN_CHANGE_EVENT) != 0)
    {
        if (state->gameMode == GAMEMODE_VS_BATTLE && (playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_STAGESCOREEVENT_ACTIVE) == 0)
        {
            playerGameStatus.networkErrorTimer++;
            if (playerGameStatus.networkErrorTimer >= GAMEONLINESYS_NETWORK_TIMEOUT_TIME)
                playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_NETWORK_ERROR;

            return;
        }

        state->gameFlag &= ~(GAME_FLAG_PLAYER_RESPAWNED | GAME_FLAG_PLAYER_RESTARTED);

        if (state->gameMode == GAMEMODE_VS_BATTLE)
        {
            if (state->vsBattleType == VSBATTLE_RINGS)
            {
                if (playerGameStatus.vsGoalPacket[0].rings > playerGameStatus.vsGoalPacket[1].rings)
                {
                    state->vsBattleResult = 1;
                }
                else if (playerGameStatus.vsGoalPacket[0].rings < playerGameStatus.vsGoalPacket[1].rings)
                {
                    state->vsBattleResult = 2;
                }
                else
                {
                    state->vsBattleResult = 3;
                }
            }
            else
            {
                if (playerGameStatus.vsGoalPacket[0].time < playerGameStatus.vsGoalPacket[1].time)
                {
                    state->vsBattleResult = 1;
                }
                else if (playerGameStatus.vsGoalPacket[0].time > playerGameStatus.vsGoalPacket[1].time)
                {
                    state->vsBattleResult = 2;
                }
                else
                {
                    state->vsBattleResult = 3;
                }
            }
        }
        else if (state->gameMode == GAMEMODE_TIMEATTACK)
        {
            if (playerGameStatus.speedBonusCount != 0)
                playerGameStatus.speedBonus = FX_DivS32(playerGameStatus.speedBonus, playerGameStatus.speedBonusCount);

            playerGameStatus.ringBonus = gPlayer->rings;
            if ((state->gameFlag & GAME_FLAG_REPLAY_STARTED) == 0)
            {
                if (state->replayStageTimer != 0 && state->replayStageID == state->stageID)
                {
                    if (state->replayStageTimer > playerGameStatus.stageTimer)
                    {
                        state->replayCharacterID = state->characterID[0];
                        state->replayStageTimer  = playerGameStatus.stageTimer;
                        MI_CpuCopy16(state->playerGhostWrite, state->playerGhostRead, PLAYER_REPLAY_MAX_TIME * sizeof(PlayerGhostFrame));
                    }
                }
                else
                {
                    state->replayCharacterID = state->characterID[0];
                    state->replayStageID     = state->stageID;
                    state->replayStageTimer  = playerGameStatus.stageTimer;
                    MI_CpuCopy16(state->playerGhostWrite, state->playerGhostRead, PLAYER_REPLAY_MAX_TIME * sizeof(PlayerGhostFrame));
                }
            }

            if (GetPadReplayState() == REPLAY_MODE_RECORD)
            {
                state->replayRecordCharacterID = state->characterID[0];
                state->replayRecordStageID     = state->stageID;
                state->replayRecordStageTimer  = playerGameStatus.stageTimer;
            }
            else if (GetPadReplayState() == REPLAY_MODE_PLAYBACK)
            {
                if (playerGameStatus.stageTimer != state->replayRecordStageTimer)
                    gameState.gameFlag |= GAME_FLAG_REPLAY_FINISHED;

                playerGameStatus.stageTimer = state->replayRecordStageTimer;
            }

            SetPadReplayState(REPLAY_MODE_FORCE_QUIT);
        }
        else if (state->gameMode == GAMEMODE_MISSION)
        {
            gameState.clearedMission = TRUE;
        }
        else if (state->gameMode == GAMEMODE_DEMO)
        {
            SetPadReplayState(REPLAY_MODE_FORCE_QUIT);
        }
        else
        {
            if (playerGameStatus.speedBonusCount != 0)
                playerGameStatus.speedBonus = FX_DivS32(playerGameStatus.speedBonus, playerGameStatus.speedBonusCount);

            playerGameStatus.ringBonus  = gPlayer->rings;
            saveGame.stage.status.lives = playerGameStatus.lives;
        }

        ChangeEventForStageFinish(FALSE);
        ReleaseGameSystem();

        if (state->gameMode == GAMEMODE_DEMO || gmCheckReplayFinished())
            FlushGameSystem(GAMEDATA_LOADPROC_ALL);
        else
            FlushGameSystem(GAMEDATA_LOADPROC_STAGE);

        NextSysEvent();
        return;
    }

    if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_PLAYER_DIED) != 0)
    {
        BOOL willRestartStage;
        if (state->gameMode == GAMEMODE_TIMEATTACK || state->gameMode == GAMEMODE_MISSION || state->gameMode == GAMEMODE_DEMO || playerGameStatus.lives == 0)
        {
            willRestartStage = FALSE;
            state->gameFlag &= ~(GAME_FLAG_PLAYER_RESPAWNED | GAME_FLAG_PLAYER_RESTARTED);
            ReleaseGameSystem();
            FlushGameSystem(GAMEDATA_LOADPROC_ALL);

            switch (state->gameMode)
            {
                case GAMEMODE_STORY:
                    saveGame.stage.status.lives = PLAYER_STARTING_LIVES;
                    break;

                default:
                    if (state->gameMode == GAMEMODE_DEMO)
                        SetPadReplayState(REPLAY_MODE_FORCE_QUIT);
                    break;
            }
        }
        else
        {
            playerGameStatus.lives--;
            saveGame.stage.status.lives = playerGameStatus.lives;
            playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_FREEZE_TIME;
            state->gameFlag |= GAME_FLAG_PLAYER_RESPAWNED;
            willRestartStage = TRUE;
            ReleaseGameSystem();
        }

        ChangeEventForStageFinish(willRestartStage);
        NextSysEvent();
        playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_PLAYER_DIED;
    }
    else
    {
        if ((padInput.btnPress & PAD_BUTTON_START) != 0 || work->forceActivatePauseMenu)
        {
            // buffer pause menu activation if the start button is pressed and the menu doesn't open
            work->forceActivatePauseMenu = TRUE;

            if (IsBossStage())
            {
                GraphicsEngine engine    = Camera3D__UseEngineA() ? GRAPHICS_ENGINE_A : GRAPHICS_ENGINE_B;
                GraphicsEngine hudEngine = GetHUDActiveScreen();

                if (hudEngine == engine)
                {
                    work->forceActivatePauseMenu = FALSE;
                    TryOpenPauseMenu(); // spawns pause menu
                }
            }
            else
            {
                work->forceActivatePauseMenu = FALSE;
                TryOpenPauseMenu();
            }
        }
    }
}

BOOL IsBossStage(void)
{
    return bossStageTable[gameState.stageID] == TRUE;
}

s32 GetCurrentZoneID(void)
{
    return zoneIDForStageID[gameState.stageID];
}

BOOL CheckStageUsesLaps(void)
{
    switch (gameState.stageID)
    {
        case STAGE_HIDDEN_ISLAND_VS2:
        case STAGE_HIDDEN_ISLAND_R1:
        case STAGE_HIDDEN_ISLAND_R2:
        case STAGE_HIDDEN_ISLAND_R3:
            return TRUE;

        default:
            return FALSE;
    }
}

StageStartType GetStageStartType(void)
{
    GameState *state = GetGameState();

    if (state->stageID == STAGE_TUTORIAL || state->gameMode == GAMEMODE_DEMO && HasDemoSpawnPos())
        return STAGESTART_FADEIN; // fade in

    if (IsBossStage() || (state->gameFlag & GAME_FLAG_PLAYER_RESPAWNED) != 0 || state->gameMode == GAMEMODE_MISSION
        || (state->stageID >= STAGE_HIDDEN_ISLAND_3 && state->stageID <= STAGE_HIDDEN_ISLAND_VS4)
        || (state->stageID == STAGE_HIDDEN_ISLAND_1 || state->stageID == STAGE_HIDDEN_ISLAND_2) || (gmCheckRingBattle()) || gmCheckRaceStage())
        return STAGESTART_GROUND; // spawn on the ground

    return STAGESTART_STARTPLATFORM; // spawn a start platform and use that
}

BOOL IsSnowboardStage(void)
{
    if (gameState.stageID == STAGE_Z51 || gameState.stageID == STAGE_HIDDEN_ISLAND_12)
        return TRUE;

    return FALSE;
}

BOOL IsSnowboardActive(void)
{
    if ((gameState.stageID == STAGE_Z51 && gPlayer->objWork.position.x < FLOAT_TO_FX32(26300.0)) || gameState.stageID == STAGE_HIDDEN_ISLAND_12)
    {
        return TRUE;
    }

    return FALSE;
}

s32 GetVSBattlePosition(Player *player)
{
    s32 rank = -1;

    if (gameState.gameMode == GAMEMODE_VS_BATTLE)
    {
        s16 playerID = player->controlID;
        s16 rivalID  = playerID ^ 1;

        if (gameState.vsBattleType == VSBATTLE_RACE)
        {
            if (gmCheckRaceStage())
            {
                if (playerGameStatus.playerLapCounter[playerID] > playerGameStatus.playerLapCounter[rivalID])
                {
                    rank = 0;
                }
                else if (playerGameStatus.playerLapCounter[playerID] < playerGameStatus.playerLapCounter[rivalID])
                {
                    rank = 1;
                }
                else
                {
                    if (gameState.stageID != STAGE_HIDDEN_ISLAND_R2)
                    {
                        s32 playerX = gPlayerList[playerID]->objWork.position.x;
                        s32 rivalX  = gPlayerList[rivalID]->objWork.position.x;
                        if (playerX < playerGameStatus.lapMarkerPos && rivalX >= playerGameStatus.lapMarkerPos)
                        {
                            rank = 0;
                        }
                        else if (playerX >= playerGameStatus.lapMarkerPos && rivalX < playerGameStatus.lapMarkerPos)
                        {
                            rank = 1;
                        }
                        else
                        {
                            if (playerX > rivalX)
                                rank = 0;
                            else if (playerX < rivalX)
                                rank = 1;
                        }
                    }
                }
            }
            else
            {
                if (gPlayerList[playerID]->objWork.position.x > gPlayerList[rivalID]->objWork.position.x)
                    rank = 0;
                else if (gPlayerList[playerID]->objWork.position.x < gPlayerList[rivalID]->objWork.position.x)
                    rank = 1;
            }
        }
        else
        {
            if (gPlayerList[playerID]->rings > gPlayerList[rivalID]->rings)
                rank = 0;
            else if (gPlayerList[playerID]->rings < gPlayerList[rivalID]->rings)
                rank = 1;
        }
    }

    return rank;
}

void SendPacketForStageScoreEvent(void)
{
    if (gmCheckVsBattleFlag())
    {
        if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_STAGESCOREEVENT_SENT) == 0)
        {
            if (gameState.vsBattleType == VSBATTLE_RINGS)
            {
                playerGameStatus.vsGoalPacket[0].rings = gPlayer->rings;
            }
            else
            {
                playerGameStatus.vsGoalPacket[0].time = playerGameStatus.stageTimer;

                if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_STAGESCOREEVENT_ACTIVE) != 0 && playerGameStatus.stageTimer <= AKUTIL_TIME_TO_FRAMES(9, 59, 99))
                {
                    playerGameStatus.vsGoalPacket[0].time = AKUTIL_TIME_TO_FRAMES(9, 59, 99);
                }
                else if (playerGameStatus.vsGoalPacket[0].time > AKUTIL_TIME_TO_FRAMES(10, 00, 00))
                {
                    playerGameStatus.vsGoalPacket[0].time = AKUTIL_TIME_TO_FRAMES(10, 00, 00);
                }
            }

            playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_STAGESCOREEVENT_SENT;
        }

        ObjPacket__QueueSendPacket(&playerGameStatus.vsGoalPacket[0], GAMEPACKET_STAGESCORE, 3, (u16)sizeof(playerGameStatus.vsGoalPacket[0]));

        if ((gameState.gameFlag & GAME_FLAG_USE_WIFI) != 0)
            playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_NEEDS_DATATRANSFER_CONFIG_INIT;
    }
}

void SendPacketForStageFinishEvent(void)
{
    if (gmCheckVsBattleFlag() == FALSE)
        return;

    ObjSendPacket *packetWork = ObjPacket__QueueSendPacket(NULL, GAMEPACKET_STAGEFINISH, 3, 0);
    if (packetWork != NULL)
    {
        packetWork->header.param = 0;
        if ((gameState.gameFlag & GAME_FLAG_USE_WIFI) != 0)
            playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_NEEDS_DATATRANSFER_CONFIG_INIT;
    }

    playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_STAGEFINISHEVENT_SENT;
}

GameObjectSendPacket *RequestNextSendPacket(void)
{
    GameObjectSendPacket *packet = NULL;

    if (playerGameStatus.sendPacketList != NULL)
    {
        if (playerGameStatus.sendPacketCount < GAMESYSTEM_SENDPACKET_LIST_SIZE)
        {
            packet = &playerGameStatus.sendPacketList[playerGameStatus.sendPacketCount++];
        }
    }

    return packet;
}

void HandleNetworkError(void)
{
    DWCErrorType errorType;

    renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_BLACK;
    renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_BLACK;
    GX_SetMasterBrightness(RENDERCORE_BRIGHTNESS_BLACK);
    GXS_SetMasterBrightness(RENDERCORE_BRIGHTNESS_BLACK);

    ReleaseGameSystem();
    FlushGameSystem(GAMEDATA_LOADPROC_ALL);

    if ((gameState.gameFlag & GAME_FLAG_USE_WIFI) != 0)
    {
        gameState.displayDWCErrorCode = TRUE;
        DWC_GetLastErrorEx(&gameState.lastDWCError, &errorType);
        DWC_CloseConnectionsAsync();
        DestroyDataTransferManager();
        DestroyConnectionManager();

        if (DWC_UpdateConnection() || (errorType != DWC_ETYPE_NO_ERROR && errorType != DWC_ETYPE_LIGHT && errorType != DWC_ETYPE_SHOW_ERROR && errorType != DWC_ETYPE_SHUTDOWN_FM))
        {
            DestroyMatchManager();
            DestroyINetManager(FALSE);
            RenderCore_SetNextFoldMode(FOLD_TOGGLE_SLEEP);
            RenderCore_DisableSoftReset(FALSE);
        }
        else
        {
            DWC_ClearError();
        }
    }
    else
    {
        gameState.displayDWCErrorCode = FALSE;
        MultibootManager__Func_206789C(0);
        RenderCore_SetNextFoldMode(FOLD_TOGGLE_SLEEP);
        RenderCore_DisableSoftReset(FALSE);
    }

    RequestNewSysEventChange(SYSEVENT_NETWORK_ERROR_MENU);
    NextSysEvent();
}

void CreateReplayViewer(void)
{
    TaskCreateNoWork(ReplayViewer_Main, 0, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0xFFF, TASK_GROUP(3), "ReplayViewer");
    gameState.gameFlag &= ~GAME_FLAG_REPLAY_FINISHED;
}

void ReplayViewer_Main(void)
{
    if ((gPlayer->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0 && IsDrawFadeTaskFinished() && GetSysEventList()->currentEventID != SYSEVENT_TITLECARD
        && (GetPadReplayState() == REPLAY_MODE_FINISHED || (padInput.btnPress & (PAD_BUTTON_A | PAD_BUTTON_B | PAD_BUTTON_START | PAD_BUTTON_X | PAD_BUTTON_Y)) != 0))
    {
        CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_REVERSE_BRIGHTNESS | DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(2.0));
        playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_FADE_IS_ACTIVE;
        FadeOutStageBGM(8);
        DestroyCurrentTask();
    }
}
