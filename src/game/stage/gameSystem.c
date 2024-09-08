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
#include <network/wirelessManager.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void MultibootManager__Func_206789C(s32 a1);
NOT_DECOMPILED void DecorationSys__Create(void);

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

static void GameOnlineSystem_Main(void);
static void GameOfflineSystem_Main(void);

static void HandleNetworkError(void);

static void CreateReplayViewer(void);
static void ReplayViewer_Main(void);

// --------------------
// STRUCTS
// --------------------

typedef struct GameOfflineSysTask_
{
    u32 field_0;
} GameOfflineSysTask;

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

const struct MissionEntry missionList[] = {
    {
        .stageID = STAGE_Z11,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 20, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 20, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z11,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 100 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 100 },
        },
    },

    {
        .stageID = STAGE_Z11,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z11,
        .type = MISSION_TYPE_PERFORM_TRICKS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 30 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 30 },
        },
    },

    {
        .stageID = STAGE_Z11,
        .type = MISSION_TYPE_PERFORM_COMBOS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 12 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 12 },
        },
    },

    {
        .stageID = STAGE_Z12,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 20, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 20, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z12,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 100 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 100 },
        },
    },

    {
        .stageID = STAGE_Z12,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z12,
        .type = MISSION_TYPE_DEFEAT_ENEMIES,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 8 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 8 },
        },
    },

    {
        .stageID = STAGE_Z1B,
        .type = MISSION_TYPE_BOSS_REMATCH,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z1B,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    {
        .stageID = STAGE_Z21,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 40, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 40, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z21,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
        },
    },

    {
        .stageID = STAGE_Z21,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z21,
        .type = MISSION_TYPE_PERFORM_TRICKS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 30 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 30 },
        },
    },

    {
        .stageID = STAGE_Z22,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 40, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 40, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z22,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
        },
    },

    {
        .stageID = STAGE_Z22,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z22,
        .type = MISSION_TYPE_DEFEAT_ENEMIES,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 6 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 6 },
        },
    },

    {
        .stageID = STAGE_Z2B,
        .type = MISSION_TYPE_BOSS_REMATCH,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z2B,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    {
        .stageID = STAGE_Z31,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 50, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 50, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z31,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
        },
    },

    {
        .stageID = STAGE_Z31,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z31,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    {
        .stageID = STAGE_Z32,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 20, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 20, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z32,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
        },
    },

    {
        .stageID = STAGE_Z32,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z32,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z3B,
        .type = MISSION_TYPE_BOSS_REMATCH,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z3B,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    {
        .stageID = STAGE_Z41,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z41,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 50 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 50 },
        },
    },

    {
        .stageID = STAGE_Z41,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z41,
        .type = MISSION_TYPE_DEFEAT_ENEMIES,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 10 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 10 },
        },
    },

    {
        .stageID = STAGE_Z42,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z42,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 50 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 50 },
        },
    },

    {
        .stageID = STAGE_Z42,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z42,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    {
        .stageID = STAGE_Z4B,
        .type = MISSION_TYPE_BOSS_REMATCH,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z4B,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    {
        .stageID = STAGE_Z51,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z51,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 50 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 30, 00), .quota = 50 },
        },
    },

    {
        .stageID = STAGE_Z51,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z51,
        .type = MISSION_TYPE_PASS_FLAGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z51,
        .type = MISSION_TYPE_PERFORM_TRICKS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 20 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 20 },
        },
    },

    {
        .stageID = STAGE_Z52,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 50, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 50, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z52,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 50 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 50 },
        },
    },

    {
        .stageID = STAGE_Z52,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z5B,
        .type = MISSION_TYPE_BOSS_REMATCH,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z5B,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    {
        .stageID = STAGE_Z61,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 40, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 40, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z61,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 100 },
        },
    },

    {
        .stageID = STAGE_Z61,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z61,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    {
        .stageID = STAGE_Z62,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z62,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 50 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 00, 00), .quota = 50 },
        },
    },

    {
        .stageID = STAGE_Z62,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z62,
        .type = MISSION_TYPE_DEFEAT_ENEMIES,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 10 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 10 },
        },
    },

    {
        .stageID = STAGE_Z6B,
        .type = MISSION_TYPE_BOSS_REMATCH,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z6B,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    {
        .stageID = STAGE_Z71,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 20, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 20, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z71,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 20, 00), .quota = 100 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 20, 00), .quota = 100 },
        },
    },

    {
        .stageID = STAGE_Z71,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z71,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    {
        .stageID = STAGE_Z72,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z72,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 200 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(2, 30, 00), .quota = 200 },
        },
    },

    {
        .stageID = STAGE_Z72,
        .type = MISSION_TYPE_FIND_MEDAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z72,
        .type = MISSION_TYPE_PERFORM_TRICKS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 30 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(3, 00, 00), .quota = 30 },
        },
    },

    {
        .stageID = STAGE_Z7B,
        .type = MISSION_TYPE_BOSS_REMATCH,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_Z7B,
        .type = MISSION_TYPE_DEFEAT_RIVAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_BOSS_FINAL,
        .type = MISSION_TYPE_BOSS_REMATCH,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_3,
        .type = MISSION_TYPE_PERFORM_TRICKS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 20 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 20 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_3,
        .type = MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_4,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 50 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 50 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_5,
        .type = MISSION_TYPE_DEFEAT_ENEMIES,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 50, 00), .quota = 16 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 50, 00), .quota = 16 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_5,
        .type = MISSION_TYPE_PERFORM_COMBOS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 11 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 40, 00), .quota = 11 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_6,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_6,
        .type = MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 1 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_7,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_7,
        .type = MISSION_TYPE_PERFORM_COMBOS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 20 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 20 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_8,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_8,
        .type = MISSION_TYPE_PASS_FLAGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_9,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_10,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_11,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_12,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_12,
        .type = MISSION_TYPE_PASS_FLAGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(1, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_13,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_14,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_14,
        .type = MISSION_TYPE_COLLECT_RINGS,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 50, 00), .quota = 50 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 50, 00), .quota = 50 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_15,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_15,
        .type = MISSION_TYPE_DEFEAT_ENEMIES,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 15 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 30, 00), .quota = 15 },
        },
    },

    {
        .stageID = STAGE_HIDDEN_ISLAND_16,
        .type = MISSION_TYPE_REACH_GOAL,
        .config =
        {
            [DIFFICULTY_EASY] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
            [DIFFICULTY_NORMAL] = { .timeLimit = AKUTIL_TIME_TO_FRAMES(0, 00, 00), .quota = 0 },
        },
    },

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

static const u32 objDataSizeForZone[ZONE_COUNT] = { 183, 192, 202, 173, 205, 178, 195, 159, 164 };

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
    if (gameState.gameMode == GAMEMODE_VS_BATTLE && (gameState.gameFlag & GAME_FLAG_ONLINE_ACTIVE) != 0)
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

    state->gameFlag &= ~(GAME_FLAG_ONLINE_ACTIVE | GAME_FLAG_IS_VS_BATTLE | GAME_FLAG_10);

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
        playerGameStatus.missionStatus.stageTimeLimit = state->missionTimeLimit;
        playerGameStatus.missionStatus.quotaTarget    = mtMathRand();

        switch ((s32)state->missionType)
        {
            case MISSION_TYPE_COLLECT_RINGS:
                playerGameStatus.missionStatus.quota = state->missionQuota;
                break;

            case MISSION_TYPE_DEFEAT_ENEMIES:
                playerGameStatus.missionStatus.quota = state->missionQuota;
                break;

            case MISSION_TYPE_PERFORM_COMBOS:
                playerGameStatus.missionStatus.quota = state->missionQuota;
                break;

            case MISSION_TYPE_PERFORM_TRICKS:
                playerGameStatus.missionStatus.quota = state->missionQuota;
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
    gameState.gameFlag         = GAME_FLAG_NONE;
    gameState.gameMode         = GAMEMODE_MISSION;
    gameState.missionFlag      = FALSE;
    gameState.stageID          = missionList[id].stageID;
    gameState.missionType      = missionList[id].type;
    gameState.missionTimeLimit = missionList[id].config[gameState.difficulty].timeLimit;
    gameState.missionQuota     = missionList[id].config[gameState.difficulty].quota;
}

void CreateGameDataRequest(GameDataLoadProc load_proc)
{
    if (load_proc != GAMEDATA_LOADPROC_NONE)
        gameDataTask = TaskCreate(GameDataRequest_Main_TryLoadCommonAssets, NULL, TASK_FLAG_NONE, 0, 0x1000, TASK_SCOPE_3, GameDataRequest);
    else
        gameDataTask = TaskCreate(GameDataRequest_Main_BuildArea, NULL, TASK_FLAG_NONE, 0, 0x1000, TASK_SCOPE_3, GameDataRequest);

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

    if ((state->gameFlag & GAME_FLAG_40) == 0)
    {
        MI_CpuClear16(&playerGameStatus, sizeof(playerGameStatus));

        playerGameStatus.field_88[1] = 0xFFFF;
        playerGameStatus.field_8C[1] = 0xFFFF;
        InitPadInput(&playerGameStatus.input, NULL, NULL);

        if (state->gameMode == GAMEMODE_DEMO || gmCheckReplayActive())
            playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_DISABLE_PLAYER_INPUTS;

        if ((state->gameFlag & GAME_FLAG_ONLINE_ACTIVE) != 0)
        {
            ObjSendPacket *packetWork = ObjPacket__SendPacket(NULL, GAMEPACKET_UNKNOWN, 3, 0);
            if (packetWork != NULL)
                packetWork->header.param = playerGameStatus.field_88[0];
        }

        state->gameFlag &= ~(GAME_FLAG_PLAYER_RESPAWNED | GAME_FLAG_REPLAY_GHOST_ACTIVE | GAME_FLAG_100 | GAME_FLAG_HAS_TIME_OVER | GAME_FLAG_PLAYER_RESTARTED);
        state->vsBattleResult = 0;
        if (state->gameMode == GAMEMODE_DEMO)
            playerGameStatus.lives = 2;
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
    stageCollision.diffCollision = MapSys__files.collisionHeightMasks;
    stageCollision.dirCollision  = MapSys__files.collisionAngles;
    stageCollision.mapBlockset   = MapSys__files.blockset;
    stageCollision.mapLayout[0]  = MapSys__files.mapLayout[0]->blocks;
    stageCollision.mapLayout[1]  = MapSys__files.mapLayout[1]->blocks;
    stageCollision.attrCollision = MapSys__files.collisionAttributes;
    stageCollision.blockWidth    = MapSys__files.mapLayout[0]->width;
    stageCollision.blockHeight   = MapSys__files.mapLayout[0]->height;

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

NONMATCH_FUNC void CreateGameSystem(void)
{
    // https://decomp.me/scratch/p7aRj -> 95.53%
    // func should match when all other funcs are done, assuming Player__Create's 'characterID' param is a u32 or s32 type! (https://decomp.me/scratch/yxIlf)
#ifdef NON_MATCHING
    GameState *state = GetGameState();

    playerGameStatus.gameOnlineSysTask = TaskCreateNoWork(GameOnlineSystem_Main, NULL, TASK_FLAG_NONE, 0, 0x1000, TASK_SCOPE_3, "GameOnlineSysTask");

    playerGameStatus.gameOfflineSysTask = TaskCreate(GameOfflineSystem_Main, NULL, TASK_FLAG_NONE, 0, 0x8000, TASK_SCOPE_3, GameOfflineSysTask);
    GameOfflineSysTask *work            = TaskGetWork(playerGameStatus.gameOfflineSysTask, GameOfflineSysTask);
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
            playerGameStatus.flags = 0;
        }

        playerGameStatus.stageTimer          = 0;
        playerGameStatus.trickBonus          = 0;
        playerGameStatus.speedBonus          = 0;
        playerGameStatus.speedBonusCount     = 0;
        playerGameStatus.ringBonus           = 0;
        playerGameStatus.field_20            = 0;
        playerGameStatus.lives               = 1;
        playerGameStatus.recallCheckpointID  = 0;
        playerGameStatus.recallTime          = 0;
        playerGameStatus.playerLapCounter[1] = 0;
        playerGameStatus.playerLapCounter[0] = 0;
        playerGameStatus.playerTargetLaps[1] = 0;
        playerGameStatus.playerTargetLaps[0] = 0;
    }
    else
    {
        if (gmCheckRingBattle())
            CreateRingBattleManager();
    }

    InitStageLightConfig();
    InitStageEdgeConfig();
    CreateObjectManager();

    if ((gameState.gameFlag & GAME_FLAG_ONLINE_ACTIVE) != 0)
        ObjPacket__Init(0, OBJPACKET_MODE_WIFI, 0x108);
    else
        ObjPacket__Init(0, OBJPACKET_MODE_WIRELESS, whConfig.wmMinDataSize);

    AllocObjectFileWork(objDataSizeForZone[GetCurrentZoneID()]);

    g_obj.flag       = OBJECTMANAGER_FLAG_20 | OBJECTMANAGER_FLAG_40 | OBJECTMANAGER_FLAG_8;
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
        g_obj.flag = (g_obj.flag | OBJECTMANAGER_FLAG_200) & ~OBJECTMANAGER_FLAG_8;

    MI_CpuClear16(gPlayerList, sizeof(gPlayerList));

    if ((state->gameFlag & GAME_FLAG_IS_VS_BATTLE) != 0)
    {
        u16 aid;
        if ((state->gameFlag & GAME_FLAG_ONLINE_ACTIVE) != 0)
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

        u16 id = 1;
        for (s32 p = 0; p < 2; p++)
        {
            if (p != aid)
            {
                gPlayerList[id] = Player__Create(state->characterID[id + 1], ObjPacket__GetAIDIndex(p));

                Animator3D__Process(&gPlayerList[id]->obj_3dWork.ani.work);

                if ((gPlayerList[id]->playerFlag & PLAYER_FLAG_TAIL_IS_ACTIVE) != 0)
                {
                    Animator3D__Process(&gPlayerList[id]->tailAnimator.work);
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

        if ((state->gameMode == GAMEMODE_TIMEATTACK && state->replayStageID == state->stageID) && state->replayStageTimer && (state->gameFlag & GAME_FLAG_REPLAY_STARTED) == 0
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
    SetHUDVisible(1);

    if (gmCheckRaceStage())
        CreateLapTimeHUD();

    if (!IsBossStage())
        StarCombo__SpawnConfetti();

    if (!IsBossStage())
        DecorationSys__Create();

    BossArena__Create(IsBossStage() ? 3 : 0, 0x10A0);

    g_obj.cameraConfig = BossArena__GetCameraConfig2(BossArena__GetCamera(0));
    playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_PLAYER_DIED;
    InitStageBlendControl();
    InitStageBGM();
    StartStageBGM(0);

    if ((state->gameFlag & GAME_FLAG_40) != 0)
        state->gameFlag &= ~GAME_FLAG_40;

    if ((state->gameFlag & GAME_FLAG_IS_VS_BATTLE) != 0 && !playerGameStatus.sendPacketList)
    {
        playerGameStatus.sendPacketList = HeapAllocHead(HEAP_USER, GAMESYSTEM_SENDPACKET_LIST_SIZE * sizeof(GameObjectSendPacket));
        MI_CpuClear8(playerGameStatus.sendPacketList, GAMESYSTEM_SENDPACKET_LIST_SIZE * sizeof(GameObjectSendPacket));
        playerGameStatus.sendPacketCount = 0;
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0xc
	mov r0, #0x1000
	str r0, [sp]
	mov r1, #0
	mov r0, #3
	str r0, [sp, #4]
	ldr r0, =GameOnlineSystem_Main
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	ldr r7, =gameState
	bl TaskCreate_
	ldr r2, =mainMemProcessor
	mov r3, #0x8000
	str r0, [r2, #0x48]
	mov r1, #0
	str r3, [sp]
	mov r4, #3
	str r4, [sp, #4]
	mov r4, #4
	ldr r0, =GameOfflineSystem_Main
	mov r2, r1
	mov r3, r1
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, =mainMemProcessor
	str r0, [r1, #0x4c]
	bl GetTaskWork_
	mov r1, r0
	mov r0, #0
	mov r2, r4
	bl MIi_CpuClear16
	mov r0, r7
	ldr r0, [r0, #0x10]
	tst r0, #0x20
	bne _02003F10
	ldr r0, [r7, #0x10]
	tst r0, #2
	ldrne r0, =mainMemProcessor
	ldrne r1, [r0, #0x6c]
	strne r1, [r0, #0x50]
_02003F10:
	ldr r0, [r7, #0x14]
	cmp r0, #2
	bne _02003F8C
	ldr r0, [r7, #0x10]
	tst r0, #0x1000
	ldreq r0, =mainMemProcessor
	moveq r1, #0
	streq r1, [r0, #0x44]
	beq _02003F48
	ldr r0, =mainMemProcessor
	ldr r1, [r0, #0x44]
	and r1, r1, #0x80
	str r1, [r0, #0x44]
	bl CreateReplayViewer
_02003F48:
	ldr r0, =mainMemProcessor
	mov r2, #0
	str r2, [r0, #0x50]
	str r2, [r0, #0x54]
	str r2, [r0, #0x58]
	str r2, [r0, #0x5c]
	str r2, [r0, #0x60]
	str r2, [r0, #0x64]
	mov r1, #1
	strb r1, [r0, #0x68]
	strb r2, [r0, #0x69]
	str r2, [r0, #0x6c]
	str r2, [r0, #0xf0]
	str r2, [r0, #0xec]
	str r2, [r0, #0xf8]
	str r2, [r0, #0xf4]
	b _02003FA8
_02003F8C:
	ldr r0, =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #1
	ldreq r0, [r0, #0x20]
	cmpeq r0, #1
	bne _02003FA8
	bl CreateRingBattleManager
_02003FA8:
	bl InitStageLightConfig
	bl InitStageEdgeConfig
	bl CreateObjectManager
	ldr r0, =gameState
	ldr r0, [r0, #0x10]
	tst r0, #0x400
	mov r0, #0
	beq _02003FD8
	mov r1, #1
	mov r2, #0x108
	bl ObjPacket__Init
	b _02003FE8
_02003FD8:
	ldr r1, =0x0213640C
	ldrh r2, [r1]
	mov r1, r0
	bl ObjPacket__Init
_02003FE8:
	bl GetCurrentZoneID
	ldr r1, =objDataSizeForZone
	ldr r0, [r1, r0, lsl #2]
	bl AllocObjectFileWork
	ldr r0, =g_obj
	mov r1, #0x68
	str r1, [r0, #0x28]
	mov r1, #0x80
	str r1, [r0, #0x1c]
	mov r1, #1
	strh r1, [r0, #0x5e]
	bl IsBossStage
	cmp r0, #0
	beq _02004030
	ldr r0, =g_obj
	ldr r1, [r0, #0x28]
	orr r1, r1, #0x80000
	str r1, [r0, #0x28]
_02004030:
	mov r0, #3
	mov r1, #0x10
	bl ObjDrawSetManagedRows
	bl EventManager__Create
	bl EventManager__CreateEventEnforce
	bl MapSys__Create
	bl InitStageCollision
	bl IsBossStage
	cmp r0, #0
	beq _0200406C
	ldr r0, =g_obj
	ldr r1, [r0, #0x28]
	orr r1, r1, #0x200
	bic r1, r1, #8
	str r1, [r0, #0x28]
_0200406C:
	ldr r1, =gPlayerList
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear16
	ldr r0, [r7, #0x10]
	tst r0, #0x20
	beq _02004214
	tst r0, #0x400
	beq _020040A0
	mov r0, #1
	bl CreateConnectionStatusHUD
	bl DWC_GetMyAID
	b _020040AC
_020040A0:
	mov r0, #0
	bl CreateConnectionStatusHUD
	bl WH_GetCurrentAid
_020040AC:
	mov r9, r0
	mov r0, r9
	bl ObjPacket__GetAIDIndex
	mov r1, r0
	ldr r0, [r7, #4]
	bl Player__Create
	mov r8, #0
	ldr r1, =mainMemProcessor
	ldr r6, =gPlayerList
	str r0, [r1, #0xc]
	str r0, [r1, #0x10]
	mov r10, #1
	mov r5, r8
	mov r4, r8
_020040E4:
	cmp r8, r9
	beq _020041B8
	mov r0, r8, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ObjPacket__GetAIDIndex
	add r2, r7, r10, lsl #2
	mov r1, r0
	ldr r0, [r2, #8]
	bl Player__Create
	str r0, [r6, r10, lsl #2]
	ldr r1, [r0, #0x168]
	cmp r1, #1
	beq _0200412C
	cmp r1, #2
	beq _02004138
	cmp r1, #3
	beq _02004144
	b _02004154
_0200412C:
	add r0, r0, #0x168
	bl AnimatorMDL__ProcessAnimation
	b _02004154
_02004138:
	add r0, r0, #0x168
	bl AnimatorShape3D__ProcessAnimation
	b _02004154
_02004144:
	mov r1, r5
	mov r2, r5
	add r0, r0, #0x168
	bl AnimatorSprite3D__ProcessAnimation
_02004154:
	ldr r3, [r6, r10, lsl #2]
	ldr r0, [r3, #0x5d8]
	tst r0, #0x200
	beq _020041AC
	ldr r0, [r3, #0x2e4]
	cmp r0, #1
	beq _02004184
	cmp r0, #2
	beq _02004190
	cmp r0, #3
	beq _0200419C
	b _020041AC
_02004184:
	add r0, r3, #0x2e4
	bl AnimatorMDL__ProcessAnimation
	b _020041AC
_02004190:
	add r0, r3, #0x2e4
	bl AnimatorShape3D__ProcessAnimation
	b _020041AC
_0200419C:
	mov r1, r4
	mov r2, r4
	add r0, r3, #0x2e4
	bl AnimatorSprite3D__ProcessAnimation
_020041AC:
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	mov r10, r0, asr #0x10
_020041B8:
	add r8, r8, #1
	cmp r8, #2
	blt _020040E4
	ldr r0, =mainMemProcessor
	ldr r0, [r0, #0x14]
	bl CreateTargetIndicatorHUD
	ldr r0, =gameState
	mov r1, #0
	ldrh r0, [r0, #0x28]
	cmp r0, #0x2b
	blo _020041EC
	cmp r0, #0x2d
	movls r1, #1
_020041EC:
	cmp r1, #0
	ldreq r0, =gameState
	ldreq r0, [r0, #0x20]
	cmpeq r0, #0
	bne _02004290
	ldr r0, =mainMemProcessor
	ldr r0, [r0, #0xc]
	ldrb r0, [r0, #0x5d0]
	bl CreateRaceProgressHUD
	b _02004290
_02004214:
	ldr r0, [r7, #4]
	mov r1, #0
	bl Player__Create
	ldr r1, =mainMemProcessor
	str r0, [r1, #0xc]
	str r0, [r1, #0x10]
	ldr r1, [r7, #0x10]
	ldr r0, [r7, #0x14]
	bic r2, r1, #0x80
	cmp r0, #2
	ldreqh r1, [r7, #0x58]
	ldreqh r0, [r7, #0x28]
	str r2, [r7, #0x10]
	cmpeq r1, r0
	bne _02004290
	ldr r0, [r7, #0x4c]
	cmp r0, #0
	beq _02004290
	tst r2, #0x1000
	bne _02004290
	bl IsBossStage
	cmp r0, #0
	bne _02004290
	ldr r1, [r7, #0x10]
	ldr r0, [r7, #0x48]
	orr r2, r1, #0x80
	mov r1, #1
	str r2, [r7, #0x10]
	bl Player__Create
	ldr r1, =mainMemProcessor
	str r0, [r1, #0x14]
_02004290:
	bl IsSnowboardActive
	cmp r0, #0
	beq _020042B4
	mov r0, #0
	bl SpawnLostPlayerSnowboard
	ldr r0, =mainMemProcessor
	mov r1, #1
	ldr r0, [r0, #0xc]
	bl Player__Action_EnableSnowboard
_020042B4:
	ldr r0, =mainMemProcessor
	ldr r1, [r0, #0xc]
	ldr r0, [r1, #0x5d8]
	orr r0, r0, #0x200000
	str r0, [r1, #0x5d8]
	bl CreateRingManager
	bl IsBossStage
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bl CreateHUD
	mov r0, #1
	bl SetHUDVisible
	ldr r0, =gameState
	mov r1, #0
	ldrh r0, [r0, #0x28]
	cmp r0, #0x2b
	blo _02004304
	cmp r0, #0x2d
	movls r1, #1
_02004304:
	cmp r1, #0
	beq _02004310
	bl CreateLapTimeHUD
_02004310:
	bl IsBossStage
	cmp r0, #0
	bne _02004320
	bl StarCombo__SpawnConfetti
_02004320:
	bl IsBossStage
	cmp r0, #0
	bne _02004330
	bl DecorationSys__Create
_02004330:
	bl IsBossStage
	cmp r0, #0
	movne r0, #3
	ldr r1, =0x000010A0
	moveq r0, #0
	bl BossArena__Create
	mov r0, #0
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	ldr r2, =g_obj
	ldr r1, =mainMemProcessor
	str r0, [r2, #0x3c]
	ldr r0, [r1, #0x44]
	bic r0, r0, #2
	str r0, [r1, #0x44]
	bl InitStageBlendControl
	bl InitStageBGM
	mov r0, #0
	bl StartStageBGM
	ldr r0, [r7, #0x10]
	tst r0, #0x40
	bicne r0, r0, #0x40
	strne r0, [r7, #0x10]
	ldr r0, [r7, #0x10]
	tst r0, #0x20
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r0, =mainMemProcessor
	ldr r0, [r0, #0xe4]
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, #0x40
	bl _AllocHeadHEAP_USER
	ldr r3, =mainMemProcessor
	mov r1, #0
	mov r2, #0x40
	str r0, [r3, #0xe4]
	bl MI_CpuFill8
	ldr r0, =mainMemProcessor
	mov r1, #0
	str r1, [r0, #0xe8]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
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
    for (u8 i = TASK_SCOPE_1; i < 6; i++)
    {
        ClearTaskScope(i);
    }
}

void GameOnlineSystem_Main(void)
{
    GameState *state = GetGameState();

    NNS_SndCaptureStopReverb(0);
    NNS_SndCaptureStopEffect();
    NNS_SndCaptureStopSampling();
    NNS_SndCaptureStopOutputEffect();
    NNS_SndUpdateDriverInfo();

    if ((state->gameFlag & GAME_FLAG_IS_VS_BATTLE) != 0)
    {
        if ((gameState.gameFlag & GAME_FLAG_ONLINE_ACTIVE) != 0)
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

        if ((state->gameFlag & GAME_FLAG_ONLINE_ACTIVE) != 0)
        {
            ObjPacket__Func_2074DB4();

            if (gPlayerList[1] != NULL)
            {
                ObjRecievePacket *packet = ObjPacket__GetRecievedPacket(GAMEPACKET_UNKNOWN, gPlayerList[1]->aidIndex);
                if (packet != NULL)
                {
                    if (playerGameStatus.field_8C[1] < packet->header.param || (playerGameStatus.field_8C[1] > 32168 && packet->header.param < 600))
                    {
                        playerGameStatus.field_8C[1] = packet->header.param;
                        playerGameStatus.field_88[1] = packet->header.param;
                    }
                    else
                    {
                        playerGameStatus.field_88[1]++;
                    }
                }
                else
                {
                    playerGameStatus.field_88[1] = 0xFFFF;
                }
            }
        }

        ObjPacket__Func_2074DB4();

        ObjRecievePacket *ringPacket = ObjPacket__GetRecievedPacket(GAMEPACKET_RINGCOUNT, gPlayerList[1]->aidIndex);
        if (ringPacket != NULL)
            gPlayerList[1]->rings = ringPacket->header.param;

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
            ObjPacket__Func_2074DB4();

            s32 *opponentStageScore = ObjPacket__GetRecievedPacketData(GAMEPACKET_STAGESCORE, gPlayerList[1]->aidIndex);
            if (opponentStageScore != NULL)
            {
                playerGameStatus.vsStageScore[1].time = opponentStageScore[0];
                playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_STAGESCOREEVENT_ACTIVE;

                if ((gPlayer->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0)
                {
                    if (state->vsBattleType == VSBATTLE_RACE)
                    {
                        if (playerGameStatus.vsStageScore[1].time >= AKUTIL_TIME_TO_FRAMES(10, 00, 00))
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
            ObjPacket__Func_2074DB4();

            ObjRecievePacket *stageClearPacket = ObjPacket__GetRecievedPacket(GAMEPACKET_STAGEFINISH, gPlayerList[1]->aidIndex);
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

        GameObject__ProcessRecievedPackets_ItemBox();
    }

    if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FADE_IS_ACTIVE) != 0)
    {
        if (IsDrawFadeTaskFinished())
            playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_CAN_CHANGE_EVENT;
    }
}

NONMATCH_FUNC void GameOfflineSystem_Main(void)
{
    // https://decomp.me/scratch/UuCp5 -> 98.14%
#ifdef NON_MATCHING
    GameState *state         = GetGameState();
    GameOfflineSysTask *work = TaskGetWorkCurrent(GameOfflineSysTask);
    UpdateTensionGaugeHUD(gPlayer->tension >> 4, FALSE);

    if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) != 0)
        playerGameStatus.stageTimer++;

    if ((g_obj.flag & OBJECTMANAGER_FLAG_200) == 0)
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
        GameObject__ProcessRecievedPackets_Unknown();

        if ((GetSystemFrameCounter() & 0x3F) == 0)
        {
            ObjSendPacket *ringPacket = ObjPacket__SendPacket(NULL, GAMEPACKET_RINGCOUNT, 1, 0);
            if (ringPacket != NULL)
                ringPacket->header.param = gPlayer->rings;
        }

        if ((state->gameFlag & GAME_FLAG_ONLINE_ACTIVE) == 0)
        {
            ObjPacket__FillSendDataBuffer();
            playerGameStatus.sendPacketCount = 0;
        }
        else
        {
            if (FX_ModS32(playerGameStatus.field_88[0] & ~0x80000000, 4) == 3)
            {
                BOOL sendFlag = ObjPacket__FillSendDataBuffer();
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

                ObjSendPacket *unknownPacket = ObjPacket__SendPacket(NULL, GAMEPACKET_UNKNOWN, 3, 0);
                if (unknownPacket != NULL)
                    unknownPacket->header.param = (playerGameStatus.field_88[0] + 1) & 0x7FFF;

                playerGameStatus.sendPacketCount = 0;
            }
        }

        playerGameStatus.field_88[0] = (playerGameStatus.field_88[0] + 1) & 0x7FFF;
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
                if (playerGameStatus.vsStageScore[0].rings > playerGameStatus.vsStageScore[1].rings)
                {
                    state->vsBattleResult = 1;
                }
                else if (playerGameStatus.vsStageScore[0].rings < playerGameStatus.vsStageScore[1].rings)
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
                if (playerGameStatus.vsStageScore[0].time < playerGameStatus.vsStageScore[1].time)
                {
                    state->vsBattleResult = 1;
                }
                else if (playerGameStatus.vsStageScore[0].time > playerGameStatus.vsStageScore[1].time)
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
            gameState.missionFlag = TRUE;
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
        BOOL flag;
        if (state->gameMode == GAMEMODE_TIMEATTACK || state->gameMode == GAMEMODE_MISSION || state->gameMode == GAMEMODE_DEMO || playerGameStatus.lives == 0)
        {
            flag = FALSE;
            state->gameFlag &= ~(GAME_FLAG_PLAYER_RESPAWNED | GAME_FLAG_PLAYER_RESTARTED);
            ReleaseGameSystem();
            FlushGameSystem(GAMEDATA_LOADPROC_ALL);

            switch (state->gameMode)
            {
                case GAMEMODE_STORY:
                    saveGame.stage.status.lives = 2;
                    break;

                default:
                    if (state->gameMode == GAMEMODE_DEMO)
                        SetPadReplayState(5);
                    break;
            }
        }
        else
        {
            playerGameStatus.lives--;
            saveGame.stage.status.lives = playerGameStatus.lives;
            playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_FREEZE_TIME;
            state->gameFlag |= GAME_FLAG_PLAYER_RESPAWNED;
            flag = TRUE;
            ReleaseGameSystem();
        }

        ChangeEventForStageFinish(flag);
        NextSysEvent();
        playerGameStatus.flags &= ~PLAYERGAMESTATUS_FLAG_PLAYER_DIED;
    }
    else
    {
        if ((padInput.btnPress & PAD_BUTTON_START) != 0 || work->field_0 != 0)
        {
            work->field_0 = 1;
            if (IsBossStage())
            {
                GraphicsEngine engine = Camera3D__UseEngineA() ? GRAPHICS_ENGINE_A : GRAPHICS_ENGINE_B;

                if (GetHUDActiveScreen() == engine)
                {
                    work->field_0 = 0;
                    TryOpenPauseMenu(); // spawns pause menu
                }
            }
            else
            {
                work->field_0 = 0;
                TryOpenPauseMenu();
            }
        }
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, =gameState
	bl GetCurrentTaskWork_
	ldr r1, =mainMemProcessor
	mov r5, r0
	ldr r0, [r1, #0xc]
	mov r1, #0
	add r0, r0, #0x500
	ldrsh r0, [r0, #0xf8]
	mov r0, r0, asr #4
	bl UpdateTensionGaugeHUD
	ldr r0, =mainMemProcessor
	ldr r1, [r0, #0x44]
	tst r1, #1
	ldrne r1, [r0, #0x50]
	addne r1, r1, #1
	strne r1, [r0, #0x50]
	ldr r0, =g_obj
	ldr r0, [r0, #0x28]
	tst r0, #0x200
	bne _020048F0
	bl GetScreenShakeOffsetX
	mov r6, r0
	bl GetScreenShakeOffsetY
	mov r1, r6, lsl #4
	mov r2, r0, lsl #4
	mov r0, r1, asr #0x10
	mov r1, r2, asr #0x10
	bl SetObjOffset
	bl GetScreenShakeOffsetX
	mov r1, r0, asr #0xc
	ldr r0, =mapCamera
	rsb r1, r1, #0
	strh r1, [r0, #0x1c]
	bl GetScreenShakeOffsetY
	mov r1, r0, asr #0xc
	ldr r0, =mapCamera
	rsb r1, r1, #0
	strh r1, [r0, #0x1e]
	ldrsh r1, [r0, #0x1c]
	strh r1, [r0, #0x8c]
	ldrsh r1, [r0, #0x1e]
	strh r1, [r0, #0x8e]
_020048F0:
	ldr r0, [r4, #0x10]
	tst r0, #0x20
	beq _02004A24
	bl GameObject__ProcessRecievedPackets_Unknown
	bl GetSystemFrameCounter
	tst r0, #0x3f
	bne _0200493C
	mov r0, #0
	mov r3, r0
	mov r1, #4
	mov r2, #1
	bl ObjPacket__SendPacket
	cmp r0, #0
	beq _0200493C
	ldr r1, =mainMemProcessor
	ldr r1, [r1, #0xc]
	add r1, r1, #0x600
	ldrsh r1, [r1, #0x7e]
	strh r1, [r0, #2]
_0200493C:
	ldr r0, [r4, #0x10]
	tst r0, #0x400
	bne _0200495C
	bl ObjPacket__FillSendDataBuffer
	ldr r0, =mainMemProcessor
	mov r1, #0
	str r1, [r0, #0xe8]
	b _02004A0C
_0200495C:
	ldr r0, =mainMemProcessor
	mov r1, #4
	ldrh r0, [r0, #0xcc]
	bic r0, r0, #0x80000000
	bl FX_ModS32
	cmp r0, #3
	bne _02004A0C
	bl ObjPacket__FillSendDataBuffer
	ldr r1, =mainMemProcessor
	mov r6, r0
	ldr r0, [r1, #0x44]
	tst r0, #8
	beq _020049BC
	bl DWC_GetAIDBitmap
	mov r1, #0x108
	mov r2, #0
	bl SetDataTransferConfig
	cmp r6, #0
	bne _020049CC
	ldr r0, =mainMemProcessor
	ldr r1, [r0, #0x44]
	bic r1, r1, #8
	str r1, [r0, #0x44]
	b _020049CC
_020049BC:
	bl DWC_GetAIDBitmap
	mov r1, #0x108
	mov r2, #1
	bl SetDataTransferConfig
_020049CC:
	mov r0, #0
	mov r1, #3
	mov r2, r1
	mov r3, r0
	bl ObjPacket__SendPacket
	cmp r0, #0
	beq _02004A00
	ldr r2, =mainMemProcessor
	ldr r1, =0x00007FFF
	ldrh r2, [r2, #0xcc]
	add r2, r2, #1
	and r1, r2, r1
	strh r1, [r0, #2]
_02004A00:
	ldr r0, =mainMemProcessor
	mov r1, #0
	str r1, [r0, #0xe8]
_02004A0C:
	ldr r1, =mainMemProcessor
	ldr r0, =0x00007FFF
	ldrh r2, [r1, #0xcc]
	add r2, r2, #1
	and r0, r2, r0
	strh r0, [r1, #0xcc]
_02004A24:
	ldr r2, =mainMemProcessor
	ldr r0, [r2, #0x44]
	tst r0, #4
	beq _02004CF0
	ldr r1, [r4, #0x14]
	cmp r1, #1
	bne _02004A6C
	tst r0, #0x40
	bne _02004A6C
	ldrh r3, [r2, #0xd4]
	ldr r1, =0x000005DC
	add r3, r3, #1
	strh r3, [r2, #0xd4]
	ldrh r3, [r2, #0xd4]
	cmp r3, r1
	orrhs r0, r0, #0x100
	strhs r0, [r2, #0x44]
	ldmia sp!, {r4, r5, r6, pc}
_02004A6C:
	ldr r2, [r4, #0x10]
	ldr r0, =0xFFFFF7FD
	ldr r1, [r4, #0x14]
	and r0, r2, r0
	str r0, [r4, #0x10]
	cmp r1, #1
	bne _02004AF4
	ldr r0, [r4, #0x20]
	cmp r0, #1
	bne _02004AC4
	ldr r0, =mainMemProcessor
	ldrsh r1, [r0, #0xe0]
	ldrsh r0, [r0, #0xdc]
	cmp r0, r1
	movgt r0, #1
	strgt r0, [r4, #0x1c]
	bgt _02004CA0
	movlt r0, #2
	strlt r0, [r4, #0x1c]
	movge r0, #3
	strge r0, [r4, #0x1c]
	b _02004CA0
_02004AC4:
	ldr r0, =mainMemProcessor
	ldr r1, [r0, #0xe0]
	ldr r0, [r0, #0xdc]
	cmp r0, r1
	movlo r0, #1
	strlo r0, [r4, #0x1c]
	blo _02004CA0
	movhi r0, #2
	strhi r0, [r4, #0x1c]
	movls r0, #3
	strls r0, [r4, #0x1c]
	b _02004CA0
_02004AF4:
	cmp r1, #2
	bne _02004C24
	ldr r0, =mainMemProcessor
	ldr r1, [r0, #0x5c]
	cmp r1, #0
	beq _02004B1C
	ldr r0, [r0, #0x58]
	bl FX_DivS32
	ldr r1, =mainMemProcessor
	str r0, [r1, #0x58]
_02004B1C:
	ldr r1, =mainMemProcessor
	ldr r0, [r1, #0xc]
	add r0, r0, #0x600
	ldrsh r0, [r0, #0x7e]
	str r0, [r1, #0x60]
	ldr r0, [r4, #0x10]
	tst r0, #0x1000
	bne _02004BB0
	ldr r3, [r4, #0x4c]
	cmp r3, #0
	beq _02004B84
	ldrh r2, [r4, #0x58]
	ldrh r0, [r4, #0x28]
	cmp r2, r0
	bne _02004B84
	ldr r5, [r1, #0x50]
	cmp r3, r5
	bls _02004BB0
	ldr r3, [r4, #4]
	ldr r0, [r4, #0x54]
	ldr r1, [r4, #0x50]
	ldr r2, =0x00003138
	str r3, [r4, #0x48]
	str r5, [r4, #0x4c]
	bl MIi_CpuCopy16
	b _02004BB0
_02004B84:
	ldr r0, =mainMemProcessor
	ldrh r5, [r4, #0x28]
	ldr ip, [r4, #4]
	ldr r3, [r0, #0x50]
	ldr r0, [r4, #0x54]
	ldr r1, [r4, #0x50]
	ldr r2, =0x00003138
	str ip, [r4, #0x48]
	strh r5, [r4, #0x58]
	str r3, [r4, #0x4c]
	bl MIi_CpuCopy16
_02004BB0:
	bl GetPadReplayState
	cmp r0, #3
	bne _02004BDC
	ldr r0, =mainMemProcessor
	ldrh r1, [r4, #0x28]
	ldr r2, [r4, #4]
	ldr r0, [r0, #0x50]
	str r2, [r4, #0x5c]
	strh r1, [r4, #0x5a]
	str r0, [r4, #0x64]
	b _02004C18
_02004BDC:
	bl GetPadReplayState
	cmp r0, #2
	bne _02004C18
	ldr r0, =mainMemProcessor
	ldr r1, [r4, #0x64]
	ldr r0, [r0, #0x50]
	cmp r0, r1
	beq _02004C0C
	ldr r0, =gameState
	ldr r1, [r0, #0x10]
	orr r1, r1, #0x2000
	str r1, [r0, #0x10]
_02004C0C:
	ldr r1, [r4, #0x64]
	ldr r0, =mainMemProcessor
	str r1, [r0, #0x50]
_02004C18:
	mov r0, #5
	bl SetPadReplayState
	b _02004CA0
_02004C24:
	cmp r1, #3
	bne _02004C3C
	ldr r0, =gameState
	mov r1, #1
	str r1, [r0, #0x7c]
	b _02004CA0
_02004C3C:
	cmp r1, #4
	bne _02004C50
	mov r0, #5
	bl SetPadReplayState
	b _02004CA0
_02004C50:
	ldr r0, =mainMemProcessor
	ldr r1, [r0, #0x5c]
	cmp r1, #0
	beq _02004C70
	ldr r0, [r0, #0x58]
	bl FX_DivS32
	ldr r1, =mainMemProcessor
	str r0, [r1, #0x58]
_02004C70:
	ldr r2, =mainMemProcessor
	ldr r1, =saveGame
	ldr r0, [r2, #0xc]
	add r0, r0, #0x600
	ldrsh r0, [r0, #0x7e]
	str r0, [r2, #0x60]
	ldrb r0, [r2, #0x68]
	ldr r2, [r1, #0x1c0]
	bic r2, r2, #0x3f8
	mov r0, r0, lsl #0x19
	orr r0, r2, r0, lsr #22
	str r0, [r1, #0x1c0]
_02004CA0:
	mov r0, #0
	bl ChangeEventForStageFinish
	bl ReleaseGameSystem
	ldr r0, [r4, #0x14]
	cmp r0, #4
	beq _02004CD4
	ldr r0, =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #2
	ldreq r0, [r0, #0x10]
	andeq r0, r0, #0x3000
	cmpeq r0, #0x3000
	bne _02004CE0
_02004CD4:
	mov r0, #3
	bl FlushGameSystem
	b _02004CE8
_02004CE0:
	mov r0, #2
	bl FlushGameSystem
_02004CE8:
	bl NextSysEvent
	ldmia sp!, {r4, r5, r6, pc}
_02004CF0:
	tst r0, #2
	beq _02004DCC
	ldr r1, [r4, #0x14]
	cmp r1, #2
	cmpne r1, #3
	cmpne r1, #4
	ldrneb r3, [r2, #0x68]
	cmpne r3, #0
	bne _02004D6C
	ldr r1, [r4, #0x10]
	ldr r0, =0xFFFFF7FD
	mov r5, #0
	and r0, r1, r0
	str r0, [r4, #0x10]
	bl ReleaseGameSystem
	mov r0, #3
	bl FlushGameSystem
	ldr r0, [r4, #0x14]
	cmp r0, #0
	bne _02004D58
	ldr r0, =saveGame
	ldr r1, [r0, #0x1c0]
	bic r1, r1, #0x3f8
	orr r1, r1, #0x10
	str r1, [r0, #0x1c0]
	b _02004DAC
_02004D58:
	cmp r0, #4
	bne _02004DAC
	mov r0, #5
	bl SetPadReplayState
	b _02004DAC
_02004D6C:
	ldr r1, =saveGame
	sub lr, r3, #1
	ldr ip, [r1, #0x1c0]
	and r5, lr, #0xff
	ldr r3, [r4, #0x10]
	bic ip, ip, #0x3f8
	mov r5, r5, lsl #0x19
	orr r5, ip, r5, lsr #22
	orr r3, r3, #2
	strb lr, [r2, #0x68]
	bic r0, r0, #1
	str r5, [r1, #0x1c0]
	str r0, [r2, #0x44]
	str r3, [r4, #0x10]
	mov r5, #1
	bl ReleaseGameSystem
_02004DAC:
	mov r0, r5
	bl ChangeEventForStageFinish
	bl NextSysEvent
	ldr r0, =mainMemProcessor
	ldr r1, [r0, #0x44]
	bic r1, r1, #2
	str r1, [r0, #0x44]
	ldmia sp!, {r4, r5, r6, pc}
_02004DCC:
	ldr r0, =padInput
	ldrh r0, [r0, #4]
	tst r0, #8
	ldreq r0, [r5]
	cmpeq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, #1
	str r0, [r5]
	bl IsBossStage
	cmp r0, #0
	beq _02004E24
	bl Camera3D__UseEngineA
	cmp r0, #0
	movne r4, #0
	moveq r4, #1
	bl GetHUDActiveScreen
	cmp r0, r4
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, #0
	str r0, [r5]
	bl TryOpenPauseMenu
	ldmia sp!, {r4, r5, r6, pc}
_02004E24:
	mov r0, #0
	str r0, [r5]
	bl TryOpenPauseMenu
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
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
    if ((gameState.stageID == STAGE_Z51 && gPlayer->objWork.position.x < FLOAT_TO_FX32(26300)) || gameState.stageID == STAGE_HIDDEN_ISLAND_12)
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
                playerGameStatus.vsStageScore[0].rings = gPlayer->rings;
            }
            else
            {
                playerGameStatus.vsStageScore[0].time = playerGameStatus.stageTimer;

                if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_STAGESCOREEVENT_ACTIVE) != 0 && playerGameStatus.stageTimer <= AKUTIL_TIME_TO_FRAMES(9, 59, 99))
                {
                    playerGameStatus.vsStageScore[0].time = AKUTIL_TIME_TO_FRAMES(9, 59, 99);
                }
                else if (playerGameStatus.vsStageScore[0].time > AKUTIL_TIME_TO_FRAMES(10, 00, 00))
                {
                    playerGameStatus.vsStageScore[0].time = AKUTIL_TIME_TO_FRAMES(10, 00, 00);
                }
            }

            playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_STAGESCOREEVENT_SENT;
        }

        ObjPacket__SendPacket(&playerGameStatus.vsStageScore[0], GAMEPACKET_STAGESCORE, 3, (u16)sizeof(playerGameStatus.vsStageScore[0]));

        if ((gameState.gameFlag & GAME_FLAG_ONLINE_ACTIVE) != 0)
            playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_NEEDS_DATATRANSFER_CONFIG_INIT;
    }
}

void SendPacketForStageFinishEvent(void)
{
    if (gmCheckVsBattleFlag() == FALSE)
        return;

    ObjSendPacket *packetWork = ObjPacket__SendPacket(NULL, GAMEPACKET_STAGEFINISH, 3, 0);
    if (packetWork != NULL)
    {
        packetWork->header.param = 0;
        if ((gameState.gameFlag & GAME_FLAG_ONLINE_ACTIVE) != 0)
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

    if ((gameState.gameFlag & GAME_FLAG_ONLINE_ACTIVE) != 0)
    {
        gameState.displayDWCErrorCode = TRUE;
        DWC_GetLastErrorEx(&gameState.lastDWCError, &errorType);
        DWC_CloseConnectionsAsync();
        DestroyDataTransferManager();
        DestroyConnectionManager();

        if (DWC_UpdateConnection() || (errorType != DWC_ETYPE_NO_ERROR && errorType != DWC_ETYPE_LIGHT && errorType != DWC_ETYPE_SHOW_ERROR && errorType != DWC_ETYPE_SHUTDOWN_FM))
        {
            DestroyMatchManager();
            DestroyINetManager(0);
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
    TaskCreateNoWork(ReplayViewer_Main, 0, TASK_FLAG_NONE, 0, 0xFFF, TASK_SCOPE_3, "ReplayViewer");
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
