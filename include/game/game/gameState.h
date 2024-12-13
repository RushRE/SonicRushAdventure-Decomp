#ifndef RUSH2_GAMESTATE_H
#define RUSH2_GAMESTATE_H

#include <global.h>
#include <game/math/mtMath.h>
#include <seaMap/seaMapManager.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// ENUMS
// --------------------

enum GameMode_
{
    GAMEMODE_STORY,
    GAMEMODE_VS_BATTLE,
    GAMEMODE_TIMEATTACK,
    GAMEMODE_MISSION,
    GAMEMODE_DEMO,
};
typedef u32 GameMode;

enum GameFlags_
{
    GAME_FLAG_NONE = 0x00,

    GAME_FLAG_1                   = 0x1,    // ???
    GAME_FLAG_PLAYER_RESPAWNED    = 0x2,    // player has died & respawned
    GAME_FLAG_4                   = 0x4,    // ???
    GAME_FLAG_8                   = 0x8,    // ???
    GAME_FLAG_10                  = 0x10,   // ???
    GAME_FLAG_IS_VS_BATTLE        = 0x20,   // a vs battle is active
    GAME_FLAG_40                  = 0x40,   // ???
    GAME_FLAG_REPLAY_GHOST_ACTIVE = 0x80,   // replay ghost is active
    GAME_FLAG_100                 = 0x100,  // ???
    GAME_FLAG_HAS_TIME_OVER       = 0x200,  // player has got a timer over
    GAME_FLAG_ONLINE_ACTIVE       = 0x400,  // using online functionality via libDWC
    GAME_FLAG_PLAYER_RESTARTED    = 0x800,  // paused & restarted
    GAME_FLAG_REPLAY_STARTED      = 0x1000, // started replay playback
    GAME_FLAG_REPLAY_FINISHED     = 0x2000, // finished replay playback
};
typedef u32 GameFlags;

enum StageID_
{
    STAGE_NONE = -1,

    STAGE_Z11 = 0,
    STAGE_Z12,
    STAGE_TUTORIAL,
    STAGE_Z1B,
    STAGE_Z21,
    STAGE_Z22,
    STAGE_Z2B,
    STAGE_Z31,
    STAGE_Z32,
    STAGE_HIDDEN_ISLAND_1,
    STAGE_Z3B,
    STAGE_Z41,
    STAGE_Z42,
    STAGE_Z4B,
    STAGE_Z51,
    STAGE_Z52,
    STAGE_Z5B,
    STAGE_Z61,
    STAGE_Z62,
    STAGE_HIDDEN_ISLAND_2,
    STAGE_Z6B,
    STAGE_Z71,
    STAGE_Z72,
    STAGE_Z7B,
    STAGE_BOSS_FINAL,
    STAGE_HIDDEN_ISLAND_3,
    STAGE_HIDDEN_ISLAND_4,
    STAGE_HIDDEN_ISLAND_5,
    STAGE_HIDDEN_ISLAND_6,
    STAGE_HIDDEN_ISLAND_7,
    STAGE_HIDDEN_ISLAND_8,
    STAGE_HIDDEN_ISLAND_9,
    STAGE_HIDDEN_ISLAND_10,
    STAGE_HIDDEN_ISLAND_11,
    STAGE_HIDDEN_ISLAND_12,
    STAGE_HIDDEN_ISLAND_13,
    STAGE_HIDDEN_ISLAND_14,
    STAGE_HIDDEN_ISLAND_15,
    STAGE_HIDDEN_ISLAND_16,
    STAGE_HIDDEN_ISLAND_VS1,
    STAGE_HIDDEN_ISLAND_VS2,
    STAGE_HIDDEN_ISLAND_VS3,
    STAGE_HIDDEN_ISLAND_VS4,
    STAGE_HIDDEN_ISLAND_R1,
    STAGE_HIDDEN_ISLAND_R2,
    STAGE_HIDDEN_ISLAND_R3,

    STAGE_COUNT,
};
typedef u16 StageID;

enum ZoneID_
{
    ZONE_PLANT_KINGDOM,
    ZONE_MACHINE_LABYRINTH,
    ZONE_CORAL_CAVE,
    ZONE_HAUNTED_SHIP,
    ZONE_BLIZZARD_PEAKS,
    ZONE_SKY_BABYLON,
    ZONE_PIRATES_ISLAND,
    ZONE_BIG_SWELL,
    ZONE_HIDDEN_ISLAND,

    ZONE_COUNT,
};
typedef u32 ZoneID;

enum MissionType_
{
    MISSION_TYPE_0, // Unused?
    MISSION_TYPE_TRAINING,
    MISSION_TYPE_2, // Unused?
    MISSION_TYPE_3, // Unused?
    MISSION_TYPE_COLLECT_RINGS,
    MISSION_TYPE_PERFORM_COMBOS,
    MISSION_TYPE_REACH_GOAL,
    MISSION_TYPE_7, // Unused?
    MISSION_TYPE_REACH_GOAL_TIME_LIMIT,
    MISSION_TYPE_PASS_FLAGS,
    MISSION_TYPE_FIND_MEDAL,
    MISSION_TYPE_REACH_GOAL_DEFEAT_BOSS_1RING,
    MISSION_TYPE_DEFEAT_ENEMIES,
    MISSION_TYPE_PERFORM_TRICKS,
    MISSION_TYPE_DEFEAT_RIVAL,
    MISSION_TYPE_BOSS_REMATCH,
};
typedef u32 MissionType;

enum MissionState_
{
    MISSION_STATE_LOCKED,    // mission is locked
    MISSION_STATE_UNLOCKED,  // mission is unlocked
    MISSION_STATE_BEATEN,    // mission has been beaten, but the reward hasn't been claimed
    MISSION_STATE_COMPLETED, // mission has been beaten and the reward's been claimed
};
typedef u8 MissionState;

enum GameDifficulty_
{
    DIFFICULTY_EASY,
    DIFFICULTY_NORMAL,

    DIFFICULTY_COUNT
};
typedef s32 GameDifficulty;

enum GameSaveErrorTypes_
{
    GAMESAVE_ERROR_CANT_READ,
    GAMESAVE_ERROR_CANT_SAVE,
    GAMESAVE_ERROR_CORRUPT,
};
typedef u32 GameSaveErrorTypes;

enum VSBattleType_
{
    VSBATTLE_RACE,
    VSBATTLE_RINGS,
};
typedef u32 VSBattleType;

// --------------------
// STRUCTS
// --------------------

struct GameSaveInfo
{
    s32 field_40;
    s32 field_44;
    s32 unknown1;
    u16 unknown2;
    u16 flags;
    u8 chaosEmeraldID;
    u8 solEmeraldID;
    u16 field_52;
    u16 field_54;
    u16 field_56;
};

struct GameCutsceneState
{
    u32 cutsceneID;
    s16 nextSysEvent;
    BOOL canSkip;
    u32 field_C;
};

struct GameTalkUnknown1
{
    VecFx32 translation;
    u16 rotationY;
    s16 field_E;
};

struct GameTalkUnknown2
{
    VecFx32 translation;
    u16 field_C;
    u16 flags;
    int field_10;
};

struct GameTalkState
{
    u8 field_DC;
    u8 field_DD;
    u8 field_DE;
    u8 field_DF;
    struct GameTalkUnknown1 field_E0[1];
    struct GameTalkUnknown2 field_14[4];
};

typedef struct GameState_
{
    s32 field_0;
    u32 characterID[2];
    s32 nextDemoCharacterID;
    GameFlags gameFlag;
    GameMode gameMode;
    GameDifficulty difficulty;
    s32 vsBattleResult;
    VSBattleType vsBattleType;
    s32 field_24;
    StageID stageID;
    s16 field_2A;
    s32 field_2C;
    s32 field_30;
    Vec2Fx32 recallPosition;
    s16 recallRingExtraLife;
    s16 recallRings;
    s16 recallShield;
    s16 recallTension;
    u32 recallTime;
    u32 replayCharacterID;
    u32 replayStageTimer;
    struct PlayerGhostFrame_ *playerGhostRead;
    struct PlayerGhostFrame_ *playerGhostWrite;
    u16 replayStageID;
    s16 replayRecordStageID;
    u32 replayRecordCharacterID;
    void *replayKeyBuffer;
    u32 replayRecordStageTimer;
    u16 titleDemoID;
    u16 curDemoID;
    u16 nextDemoID;
    MissionType missionType;
    s32 missionTimeLimit;
    u32 missionQuota;
    BOOL missionFlag;
    s32 field_80;
    SeaMapManagerNodeList seaMapNodeList;
    u32 sailUnknownFlags;
    ShipType sailShipType;
    u32 sailVsJohnny;
    u32 sailUnknown1;
    u32 sailStoredShipHealth;
    u32 sailUnknown3;
    u16 sailVsJohnnyID;
    u16 sailUnknown4;
    u32 sailStoredShipType;
    void *sailPadReplayData;
    void *sailTouchReplayData;
    u32 vikingCupID;
    u32 sailRandSeed;
    struct GameCutsceneState cutscene;
    struct GameTalkState talk;
    struct GameSaveInfo saveFile;
    u32 doorPuzzleEvent;
    u32 creditsMode;
    int lastDWCError;
    BOOL displayDWCErrorCode;
    GameSaveErrorTypes lastSaveError;
} GameState;

// --------------------
// VARIABLES
// --------------------

extern GameState gameState;

// --------------------
// FUNCTIONS
// --------------------

void ChangeEventForStageStart(void);
void ChangeEventForStageFinish(BOOL flag);
void ChangeEventForPauseMenuAction(BOOL isRestart);
void ResetGameState(void);
void ExitStageClearSysEvent(void);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE BOOL gmCheckGameMode(GameMode mode)
{
    return gameState.gameMode == mode;
}

RUSH_INLINE BOOL gmCheckRaceBattle(void)
{
    return gmCheckGameMode(GAMEMODE_VS_BATTLE) && gameState.vsBattleType == VSBATTLE_RACE;
}

RUSH_INLINE BOOL gmCheckRingBattle(void)
{
    return gmCheckGameMode(GAMEMODE_VS_BATTLE) && gameState.vsBattleType == VSBATTLE_RINGS;
}

RUSH_INLINE BOOL gmCheckReplayActive(void)
{
    return gmCheckGameMode(GAMEMODE_TIMEATTACK) && (gameState.gameFlag & GAME_FLAG_REPLAY_STARTED) != 0;
}

RUSH_INLINE BOOL gmCheckReplayFinished(void)
{
    return gmCheckGameMode(GAMEMODE_TIMEATTACK)
           && (gameState.gameFlag & (GAME_FLAG_REPLAY_FINISHED | GAME_FLAG_REPLAY_STARTED)) == (GAME_FLAG_REPLAY_FINISHED | GAME_FLAG_REPLAY_STARTED);
}

RUSH_INLINE BOOL gmCheckMissionType(MissionType type)
{
    return gameState.gameMode == GAMEMODE_MISSION && gameState.missionType == type;
}

RUSH_INLINE BOOL gmCheckStage(StageID stage)
{
    return gameState.stageID == stage;
}

RUSH_INLINE BOOL gmCheckRaceStage(void)
{
    BOOL isRaceStage = FALSE;
    if (gameState.stageID >= STAGE_HIDDEN_ISLAND_R1 && gameState.stageID <= STAGE_HIDDEN_ISLAND_R3)
        isRaceStage = TRUE;

    return isRaceStage;
}

RUSH_INLINE GameState *GetGameState(void)
{
    return &gameState;
}

RUSH_INLINE BOOL gmCheckFlag(u32 flag)
{
    return (gameState.gameFlag & flag) != 0;
}

RUSH_INLINE BOOL gmCheckVsBattleFlag(void)
{
    return gmCheckFlag(GAME_FLAG_IS_VS_BATTLE);
}

#ifdef __cplusplus
}
#endif

#endif // RUSH2_GAMESTATE_H
