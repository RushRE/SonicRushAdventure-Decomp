#ifndef RUSH_SAVEGAME_H
#define RUSH_SAVEGAME_H

#include <global.h>
#include <game/game/gameState.h>
#include <stage/player/player.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define SAVEGAME_MAX_NAME_LEN 8

#define SAVEGAME_MAX_FRIEND_COUNT 30

#define SAVEGAME_RING_MAX 999999

#define SAVEGAME_EMERALD_COUNT 7

#define SAVEGAME_MATERIAL_MAX  99
#define SAVEGAME_MATERIAL_NONE 0xFF

#define SAVEGAME_VSRECORD_MAX 9999

#define SAVEGAME_VS_SCORE_MIN 0
#define SAVEGAME_VS_SCORE_MAX 99999

// --------------------
// ENUMS
// --------------------

enum SaveErrorTypes_
{
    SAVE_ERROR_NONE,
    SAVE_ERROR_INVALID_FORMAT,
    SAVE_ERROR_CANT_LOAD,
};
typedef u32 SaveErrorTypes;

enum SaveBlocks
{
    SAVE_BLOCK_UNKNOWN,
    SAVE_BLOCK_SYSTEM,
    SAVE_BLOCK_STAGE,
    SAVE_BLOCK_CHART,
    SAVE_BLOCK_TIME_ATTACK,
    SAVE_BLOCK_VIKING_CUP,
    SAVE_BLOCK_VS_RECORDS,
    SAVE_BLOCK_ONLINE_PROFILE,
    SAVE_BLOCK_ONLINE_LEADERBOARDS,

    SAVE_BLOCK_COUNT,
};

enum SaveBlockFlags_
{
    SAVE_BLOCK_FLAG_UNKNOWN             = 1 << SAVE_BLOCK_UNKNOWN,
    SAVE_BLOCK_FLAG_SYSTEM              = 1 << SAVE_BLOCK_SYSTEM,
    SAVE_BLOCK_FLAG_STAGE               = 1 << SAVE_BLOCK_STAGE,
    SAVE_BLOCK_FLAG_CHART               = 1 << SAVE_BLOCK_CHART,
    SAVE_BLOCK_FLAG_TIME_ATTACK         = 1 << SAVE_BLOCK_TIME_ATTACK,
    SAVE_BLOCK_FLAG_VIKING_CUP          = 1 << SAVE_BLOCK_VIKING_CUP,
    SAVE_BLOCK_FLAG_VS_RECORDS          = 1 << SAVE_BLOCK_VS_RECORDS,
    SAVE_BLOCK_FLAG_ONLINE_PROFILE      = 1 << SAVE_BLOCK_ONLINE_PROFILE,
    SAVE_BLOCK_FLAG_ONLINE_LEADERBOARDS = 1 << SAVE_BLOCK_ONLINE_LEADERBOARDS,

    SAVE_BLOCK_FLAG_ALL = SAVE_BLOCK_FLAG_SYSTEM | SAVE_BLOCK_FLAG_STAGE | SAVE_BLOCK_FLAG_CHART | SAVE_BLOCK_FLAG_TIME_ATTACK | SAVE_BLOCK_FLAG_VIKING_CUP
                          | SAVE_BLOCK_FLAG_VS_RECORDS | SAVE_BLOCK_FLAG_ONLINE_PROFILE | SAVE_BLOCK_FLAG_ONLINE_LEADERBOARDS
};
typedef u32 SaveBlockFlags;

enum SaveProgressType_
{
    SAVE_PROGRESSTYPE_0,
    SAVE_PROGRESSTYPE_1,
    SAVE_PROGRESSTYPE_2,
    SAVE_PROGRESSTYPE_3,
    SAVE_PROGRESSTYPE_4,
    SAVE_PROGRESSTYPE_5,
    SAVE_PROGRESSTYPE_6,
    SAVE_PROGRESSTYPE_7,
    SAVE_PROGRESSTYPE_8,
    SAVE_PROGRESSTYPE_9,
    SAVE_PROGRESSTYPE_10,
    SAVE_PROGRESSTYPE_11,

    SAVE_PROGRESSTYPE_COUNT,
};
typedef s32 SaveProgressType;

enum SaveProgress_
{
    SAVE_PROGRESS_0,  // fresh save
    SAVE_PROGRESS_1,  // cleared training
    SAVE_PROGRESS_2,  // built wave cyclone
    SAVE_PROGRESS_3,  // cleared plant kingdom act 1
    SAVE_PROGRESS_4,  // cleared plant kingdom act 2
    SAVE_PROGRESS_5,  // cleared plant kingdom boss
    SAVE_PROGRESS_6,  // cleared machine labyrinth act 1
    SAVE_PROGRESS_7,  // cleared machine labyrinth act 2
    SAVE_PROGRESS_8,  // cleared machine labyrinth boss
    SAVE_PROGRESS_9,  // built ocean tornado
    SAVE_PROGRESS_10, // visited ocean tornado dock
    SAVE_PROGRESS_11, // ???
    SAVE_PROGRESS_12, // ???
    SAVE_PROGRESS_13, // cleared hidden island 1
    SAVE_PROGRESS_14, // cleared coral cave act 1
    SAVE_PROGRESS_15, // cleared coral cave act 2
    SAVE_PROGRESS_16, // cleared coral cave boss
    SAVE_PROGRESS_17, // built radio tower
    SAVE_PROGRESS_18, // ???
    SAVE_PROGRESS_19, // cleared haunted ship act 1
    SAVE_PROGRESS_20, // cleared haunted ship act 2
    SAVE_PROGRESS_21, // cleared haunted ship boss
    SAVE_PROGRESS_22, // built aqua blast
    SAVE_PROGRESS_23, // visited aqua blast dock
    SAVE_PROGRESS_24, // blizzard peaks or sky babylon has yet to be cleared
    SAVE_PROGRESS_25, // cleared blizzard peaks and sky babylon
    SAVE_PROGRESS_26, // built deep typhoon
    SAVE_PROGRESS_27, // visited deep typhoon dock
    SAVE_PROGRESS_28, // ???
    SAVE_PROGRESS_29, // hunting for door puzzle keys
    SAVE_PROGRESS_30, // ???
    SAVE_PROGRESS_31, // collected all door puzzle keys
    SAVE_PROGRESS_32, // cleared door puzzle
    SAVE_PROGRESS_33, // cleared pirates island act 1
    SAVE_PROGRESS_34, // cleared pirates island act 2
    SAVE_PROGRESS_35, // cleared pirates island boss
    SAVE_PROGRESS_36, // cleared big swell boss
    SAVE_PROGRESS_37, // collected all emeralds
    SAVE_PROGRESS_38, // built magma hurricane
    SAVE_PROGRESS_39, // cleared deep core

    SAVE_PROGRESS_COUNT,
};
typedef s32 SaveProgress;

// Blizzard peaks progress
enum SaveProgressZone5_
{
    SAVE_ZONE5_PROGRESS_0, // ???
    SAVE_ZONE5_PROGRESS_1, // ???
    SAVE_ZONE5_PROGRESS_2, // cleared blizzard peaks act 1
    SAVE_ZONE5_PROGRESS_3, // cleared blizzard peaks act 2
    SAVE_ZONE5_PROGRESS_4, // cleared blizzard peaks boss

    SAVE_ZONE5_PROGRESS_COUNT,
};
typedef s32 SaveProgressZone5;

// Sky babylon progress
enum SaveProgressZone6_
{
    SAVE_ZONE6_PROGRESS_0, // ???
    SAVE_ZONE6_PROGRESS_1, // ???
    SAVE_ZONE6_PROGRESS_2, // ???
    SAVE_ZONE6_PROGRESS_3, // cleared hidden island 2
    SAVE_ZONE6_PROGRESS_4, // cleared sky babylon act 2
    SAVE_ZONE6_PROGRESS_5, // cleared sky babylon act 2
    SAVE_ZONE6_PROGRESS_6, // cleared sky babylon boss

    SAVE_ZONE6_PROGRESS_COUNT,
};
typedef s32 SaveProgressZone6;

enum SaveVsRecordType_
{
    SAVE_VSRECORD_WIN,
    SAVE_VSRECORD_LOSS,
    SAVE_VSRECORD_DRAW,

    SAVE_VSRECORD_COUNT,
};
typedef u32 SaveVsRecordType;

enum MaterialType_
{
    SAVE_MATERIAL_BLUE,
    SAVE_MATERIAL_IRON,
    SAVE_MATERIAL_GREEN,
    SAVE_MATERIAL_BRONZE,
    SAVE_MATERIAL_RED,
    SAVE_MATERIAL_SILVER,
    SAVE_MATERIAL_AQUA,
    SAVE_MATERIAL_GOLD,
    SAVE_MATERIAL_BLACK,

    SAVE_MATERIAL_COUNT,
};

enum SaveIslandState_
{
    SAVE_ISLAND_STATE_LOCKED,   // island is locked
    SAVE_ISLAND_STATE_UNLOCKED, // island is discovered, but not beaten
    SAVE_ISLAND_STATE_BEATEN,   // island has been cleared
};
typedef s32 SaveIslandState;

enum SaveIslandProgress
{
    SAVE_ISLAND_0,
    SAVE_ISLAND_1,
    SAVE_ISLAND_2,
    SAVE_ISLAND_3,
    SAVE_ISLAND_4,
    SAVE_ISLAND_5,
    SAVE_ISLAND_6,
    SAVE_ISLAND_7,
    SAVE_ISLAND_8,
    SAVE_ISLAND_9,
    SAVE_ISLAND_10,
    SAVE_ISLAND_11,
    SAVE_ISLAND_12,
    SAVE_ISLAND_13,

    SAVE_ISLAND_COUNT,
};

// --------------------
// STRUCTS
// --------------------

typedef struct SavePlayerName_
{
    char16 text[SAVEGAME_MAX_NAME_LEN];
} SavePlayerName;

typedef struct SaveRecordDate_
{
    u16 year : 7;
    u16 month : 4;
    u16 day : 5;
} SaveRecordDate;

typedef struct SaveRecordTime_
{
    u16 hour : 5;
    u16 minute : 6;
} SaveRecordTime;

typedef struct SaveGameProgress_
{
    u32 flags;
    u8 gameProgress;
    u8 zone5Progress;
    u8 zone6Progress;
    u8 islandProgress[5];
} SaveGameProgress;

struct SaveVikingCupRecord
{
    u32 records[5];
};

typedef struct SaveOnlineLeaderboardsRankEntry_
{
    SavePlayerName name;
    u16 time;
} SaveOnlineLeaderboardsRankEntry;

typedef struct SaveBlockSystem_
{
    SavePlayerName name;
    SaveGameProgress progress;
    u32 lastPlayedVsMode;
    u64 rankSeconds;
} SaveBlockSystem;

typedef struct SaveBlockStage_
{
    SaveGameProgress progress;

    u8 missionState[32];
    u8 missionAttemptState[16];

    // hidden island R1, R2 & R3 aren't counted
    struct SaveStageRecord
    {
        u32 rank : 2;
        u32 score : 30;
    } stageRecords[DIFFICULTY_COUNT][STAGE_COUNT - 3];

    u32 ringCount;

    struct
    {
        u32 difficulty : 2;
        u32 timeLimit : 1;
        u32 lives : 7;
    } status;

    u8 materialCount[SAVE_MATERIAL_COUNT];
} SaveBlockStage;

typedef struct SaveBlockChart_
{
    u32 map[(192 * 72) / (sizeof(u32) * 8)]; // each "pixel" is one bit => undiscovered/discovered
    u8 flags[8];
} SaveBlockChart;

typedef struct SaveBlockTimeAttack_
{
    struct SaveTimeAttackRecord
    {
        u16 times[5];
    } records[CHARACTER_COUNT][STAGE_COUNT];

    struct
    {
        SaveRecordDate date;
        SaveRecordTime time;
    } recordDates[STAGE_COUNT];

    u16 recordBitfield[4];
    u16 unknownBitfield[14];
} SaveBlockTimeAttack;

typedef struct SaveBlockVikingCup_
{
    struct SaveVikingCupRecord jetski[2 + 7];
    struct SaveVikingCupRecord sailboat[2];
    struct SaveVikingCupRecord hovercraft[2];
    struct SaveVikingCupRecord submarine[2];
} SaveBlockVikingCup;

typedef struct SaveBlockVSRecords_
{
    struct
    {
        u16 race[SAVE_VSRECORD_COUNT];
        u16 ringBattle[SAVE_VSRECORD_COUNT];
    } wireless;

    struct
    {
        u16 race[SAVE_VSRECORD_COUNT];
        u16 ringBattle[SAVE_VSRECORD_COUNT];
    } network;
} SaveBlockVSRecords;

typedef struct SaveBlockOnlineProfile_
{
    DWCUserData userData;
    DWCFriendData friendList[SAVEGAME_MAX_FRIEND_COUNT];
    SaveRecordDate friendTimes[SAVEGAME_MAX_FRIEND_COUNT];
    SavePlayerName friendNames[SAVEGAME_MAX_FRIEND_COUNT];

    u32 score;
} SaveBlockOnlineProfile;

typedef struct SaveBlockOnlineLeaderboards_
{
    struct SaveOnlineLeaderboardsStageEntry
    {
        struct
        {
            u32 rankOrder : 24;
            u32 topRankFlag1 : 1;
            u32 topRankFlag2 : 1;
            u32 topRankFlag3 : 1;
            u32 nearRankFlag1 : 1;
            u32 nearRankFlag2 : 1;
            u32 nearRankFlag3 : 1;
            u32 nearRankFlag4 : 1;
            u32 nearRankFlag5 : 1;
        };
        SaveOnlineLeaderboardsRankEntry top3[3];
        SaveOnlineLeaderboardsRankEntry yourRanking[5];
        SaveRecordDate lastUpdatedDate;
        SaveRecordTime lastUpdatedTime;
    } entries[7 * 2]; // 7 main zones, 2 acts. Only those stages can be uploaded to leaderboards.
} SaveBlockOnlineLeaderboards;

typedef struct SaveGame_
{
    SaveBlockSystem system;
    SaveBlockStage stage;
    SaveBlockChart chart;
    SaveBlockTimeAttack timeAttack;
    SaveBlockVikingCup vikingCup;
    SaveBlockVSRecords vsRecords;
    SaveBlockOnlineProfile onlineProfile;
    SaveBlockOnlineLeaderboards leaderboards;
} SaveGame;

typedef struct SaveGameUnknown2119CCC_
{
    u16 type;
    u16 progressCheckValue;
    u16 table1Pos;
    u16 id;
    u16 nextSysEvent;
    u16 allowProgressIncrement;
} SaveGameNextAction;

// --------------------
// VARIABLES
// --------------------

extern SaveGame saveGame;

// --------------------
// FUNCTIONS
// --------------------

void SaveGame__UpdateProgressEvent(void);
void SaveGame__SetProgressType(s32 type);
SaveProgress SaveGame__GetGameProgress(void);
void SaveGame__SetGameProgress(SaveProgress progress);
u8 SaveGame__GetProgressCounter(void);
s32 SaveGame__GetZone5Progress(void);
void SaveGame__SetZone5Progress(s32 progress);
s32 SaveGame__GetZone6Progress(void);
void SaveGame__SetZone6Progress(s32 progress);
void SaveGame__IncrementUnknown2ForUnknown(void);
BOOL SaveGame__HasDoorPuzzlePiece(u16 id);
void SaveGame__GetPuzzlePiece(u16 id);
void SaveGame__UpdateProgressForZone5Zone6Cleared(void);
void SaveGame__UpdateProgressForAllDoorPuzzleKeysCollected(void);
void SaveGame__UpdateProgressForDockFirstVisited(u32 type);
BOOL SaveGame__CheckCollectedAllEmeraldsEvent(void);
void SaveGame__SetMissionStatus(u16 id, MissionState status);
MissionState SaveGame__GetMissionStatus(u16 id);
void SaveGame__SetMissionAttempted(u16 id, BOOL attempted);
BOOL SaveGame__GetMissionAttempted(u16 id);
u16 SaveGame__GetSystemGameProgress(void);
void SaveGame__GsExit(u16 value);
void SaveGame__UnlockShip(u16 shipID, u16 shipLevel);
BOOL SaveGame__GetNextShipUpgrade(u16 *ship, u16 *level);
BOOL SaveGame__Func_205BEDC(void);
void SaveGame__Block1__SetFlags1_0x80000(void);
BOOL SaveGame__Func_205BF24(void);
void SaveGame__SetDoneFirstShipVoyage(s32 id);
BOOL SaveGame__HasDoneFirstShipVoyage(s32 id);
void SaveGame__SaveClearCallback_Stage(SaveGame *save, SaveBlockFlags blockFlags);
void SaveGame__UpdateProgress(void);
SaveGameNextAction *SaveGame__GetNextActionFromProgress(void);
void SaveGame__UpdateProgress2_Type0(void);
void SaveGame__UpdateProgress2_Type1(void);
void SaveGame__UpdateProgress2_Type2(void);
void SaveGame__UpdateProgress2_Type3(void);
void SaveGame__UpdateProgress2_Type4(void);
void SaveGame__UpdateProgress2_Type5(void);
void SaveGame__UpdateProgress2_Type6(void);
void SaveGame__UpdateProgress2_Type7(void);
void SaveGame__UpdateProgress2_Type8(void);
void SaveGame__UpdateProgress2_Type9(void);
void SaveGame__UpdateProgress2_Type10(void);
void SaveGame__UpdateProgress2_Type11(void);

BOOL SaveGame__ProgressCheck_Type0(s32 id);
BOOL SaveGame__ProgressCheck_Type1(s32 id);
BOOL SaveGame__ProgressCheck_Type2(s32 id);
BOOL SaveGame__ProgressCheck_Type3(s32 id);
BOOL SaveGame__ProgressCheck_Type4(s32 id);
BOOL SaveGame__ProgressCheck_Type5(s32 id);
BOOL SaveGame__ProgressCheck_Type6(s32 id);
BOOL SaveGame__ProgressCheck_Type7(s32 id);
BOOL SaveGame__ProgressCheck_Type8(s32 id);
BOOL SaveGame__ProgressCheck_Type9(s32 id);
BOOL SaveGame__ProgressCheck_Type10(s32 id);
BOOL SaveGame__ProgressCheck_Type11(s32 id);

void SaveGame__UpdateProgress1_Func_205CB60(SaveGameNextAction *action);
void SaveGame__UpdateProgress1_Func_205CBC4(SaveGameNextAction *action);
void SaveGame__UpdateProgress1_Func_205CBD0(SaveGameNextAction *action);
void SaveGame__UpdateProgress1_Func_205CBDC(SaveGameNextAction *action);
void SaveGame__UpdateProgress1_Func_205CBE8(SaveGameNextAction *action);
void SaveGame__UpdateProgress1_Func_205CBF4(SaveGameNextAction *action);
void SaveGame__UpdateProgress1_Func_205CC04(SaveGameNextAction *action);
void SaveGame__UpdateProgress1_Func_205CC3C(SaveGameNextAction *action);

void SaveGame__ChangeEvent(s32 sysEvent);
void SaveGame__RestartEvent(void);
void SaveGame__StartCutscene(u16 cutsceneID, s32 nextEvent, BOOL flag);
void SaveGame__StartTutorial(void);
void SaveGame__StartEvent37(void);
void SaveGame__StartSailJetTraining(void);
void SaveGame__StartHubMenu(void);
void SaveGame__StartSeaMapUnknown(void);
void SaveGame__StartSailing(void);
void SaveGame__StartStoryMode(void);
void SaveGame__StartSailRivalRace(void);
void SaveGame__StartExBoss(void);
void SaveGame__StartDoorPuzzle(BOOL flag);
void SaveGame__StartStageSelect(void);
void SaveGame__StartEmeraldCollected(void);
void SaveGame__IncrementGameProgress(void);
void SaveGame__IncrementUnknownProgress1(void);
void SaveGame__IncrementUnknownProgress2(void);
void SaveGame__IncrementProgressCounter(void);
void SaveGame__ResetProgressCounter(void);
s32 SaveGame__GetProgressType(void);
BOOL SaveGame__GetStateFlag(u16 id);
void SaveGame__EnableStateFlags(u16 mask);
void SaveGame__DisableStateFlags(u16 mask);
void SaveGame__ApplySystemProgress(void);
void SaveGame__SetProgressFlags_0x100(void);
void SaveGame__SetProgressFlags_0x200(void);
void SaveGame__SetProgressFlags_0x400(void);
void SaveGame__RemoveProgressFlags_0x100(void);
void SaveGame__RemoveProgressFlags_0x200(void);
void SaveGame__RemoveProgressFlags_0x400(void);
BOOL SaveGame__Func_205D150(s32 stageID);
BOOL SaveGame__IsShipUnlocked(ShipType ship);
BOOL SaveGame__BlazeUnlocked(void);
BOOL SaveGame__CheckZoneBeaten(s32 id);
BOOL SaveGame__HasBeatenTutorial(void);
BOOL SaveGame__GetProgressFlags_0x1(void);
BOOL SaveGame__CheckProgress12(void);
BOOL SaveGame__CheckProgressZone5OrZone6NotClear(void);
BOOL SaveGame__CheckProgress30(void);
BOOL SaveGame__CheckProgress15(void);
BOOL SaveGame__CheckProgressForShip(u32 id);
BOOL SaveGame__GetProgressFlags_0x10(void);
void SaveGame__SetProgressFlags_0x10(void);
BOOL SaveGame__CanBuyDecoration(u16 id);
BOOL SaveGame__GetBoughtDecoration(u16 id);
void SaveGame__SetBoughtDecoration(u16 id);
BOOL SaveGame__GetProgressFlags_0x100000(u32 id);
void SaveGame__SetProgressFlags_0x100000(u32 id);
BOOL SaveGame__CheckProgressIsHuntingForClues(void);
BOOL SaveGame__CanBuyInfoHint(void);
void SaveGame__BuyInfoHint(void);
BOOL SaveGame__CheckProgressIsAllEmeraldsCollected(void);
s32 SaveGame__Func_205D65C(s32 a1);
s32 SaveGame__Func_205D758(s32 a1);
ShipLevel SaveGame__GetShipUpgradeStatus(u16 id);
ShipLevel SaveGame__GetShipUpgradeStatus_(u16 id, u32 flags);
BOOL SaveGame__InitSaveSize(void);
void SaveGame__ClearData(SaveGame *work, SaveBlockFlags flags);
SaveErrorTypes SaveGame__SaveData(SaveGame *work, SaveBlockFlags flags);
SaveErrorTypes SaveGame__SaveData2(SaveGame *work);
SaveErrorTypes SaveGame__LoadData(SaveGame *work, u32 *corruptFlags, u32 *otherFlags);
SaveErrorTypes SaveGame__LoadData2(u32 flags);
void SaveGame__SaveClearCallback_Common(SaveGame *save, SaveBlockFlags blockFlags);
void SaveGame__SaveSaveCallback_OnlineProfile(SaveGame *save, SaveBlockFlags blockFlags);
void SaveGame__SaveLoadCallback_Unknown(SaveGame *save);
size_t SaveGame__GetPlayerNameLength(SaveBlockSystem *work);
void SaveGame__SetPlayerName(SavePlayerName *name, char16 *text, size_t len);
SaveIslandState SaveGame__GetIslandProgress(SaveGameProgress *progress, s32 id);
void SaveGame__SetIslandProgress(SaveGameProgress *progress, s32 id, SaveIslandState state);
void SaveGame__GiveRings(SaveBlockStage *work, s32 amount);
BOOL SaveGame__HasChaosEmerald(SaveBlockChart *work, u8 id);
void SaveGame__SetChaosEmeraldCollected(SaveBlockChart *work, u8 id);
u32 SaveGame__GetChaosEmeraldCount(SaveBlockChart *work);
BOOL SaveGame__HasSolEmerald(SaveBlockStage *work, u8 id);
u32 SaveGame__GetSolEmeraldCount(SaveBlockStage *work);
void SaveGame__SetSolEmeraldCollected(SaveBlockStage *work, u8 id);
BOOL SaveGame__HasMaterial(SaveBlockStage *work, u32 type);
void SaveGame__GiveMaterial(SaveBlockStage *work, u32 type, s32 amount);
void SaveGame__UseMaterial(SaveBlockStage *work, u32 type, s32 amount);
u32 SaveGame__GetMaterialCount(SaveBlockStage *work, u32 type);
u32 SaveGame__GetTimeAttackRecord(SaveBlockTimeAttack *work, u32 character, u32 stage, u32 rank);
u8 SaveGame__AddTimeAttackRecord(SaveBlockTimeAttack *work, u8 character, s32 stage, u16 record);
void SaveGame__AddTimeAttackUnknown(SaveBlockTimeAttack *work, s32 stage, u32 trickBonus, u32 ringBonus);
void SaveGame__DeleteOnlineProfile_KeepFriends(SaveGame *save);
BOOL SaveGame__IsValidFriend(u16 id);
u16 SaveGame__GetFriendCount(void);
void SaveGame__AddFriendViaKey(u64 friendKey);
u16 SaveGame__FindFriendViaKey(u64 friendKey);
void SaveGame__AddFriend(DWCFriendData *friendData);
u16 SaveGame__GetFriendIndex(DWCFriendData *friendData);
void SaveGame__DeleteFriend(s32 id);
void SaveGame__MoveFriendToFront(u16 id);
u16 SaveGame__GetFriendAddedYear(u16 id);
u16 SaveGame__GetFriendAddedMonth(u16 id);
u16 SaveGame__GetFriendAddedDay(u16 id);
BOOL SaveGame__IsFriendNameAString(u16 id);
u64 SaveGame__GetFriendKeyFromName(u16 id);
SavePlayerName *SaveGame__GetFriendName(u16 id);
void SaveGame__SetFrontFriendName(SavePlayerName *name);
BOOL SaveGame__RefreshFriendList(void);
void SaveGame__DeleteFriendCallback(int deletedIndex, int srcIndex, void *param);
void SaveGame__SetNameToFriendKey(SavePlayerName *name, u64 friendKey);
u64 SaveGame__GetFriendKeyFromName_Internal(SavePlayerName *name);
void SaveGame__SetFriendName(u16 id, SavePlayerName *name);
u16 SaveGame__AddWirelessRaceRecord(SaveVsRecordType matchResult);
u16 SaveGame__AddWirelessRingBattleRecord(SaveVsRecordType matchResult);
u16 SaveGame__AddNetworkRaceRecord(SaveVsRecordType matchResult);
u16 SaveGame__AddNetworkRingBattleRecord(SaveVsRecordType matchResult);
u16 SaveGame__GetWirelessRaceRecord(SaveVsRecordType type);
u16 SaveGame__GetWirelessRingBattleRecord(SaveVsRecordType type);
u16 SaveGame__GetNetworkRaceRecord(SaveVsRecordType type);
u16 SaveGame__GetNetworkRingBattleRecord(SaveVsRecordType type);
u32 SaveGame__GetOnlineScore_(void);
void SaveGame__UpdateTimeForRecord(SaveBlockTimeAttack *work, u32 stage);
s64 SaveGame__GetTimeFromTimeAttackRecord(u32 stage);
u16 SaveGame__Block4__GetLastUsedCharacter(s32 stage);
u32 SaveGame__SetVikingCupJetskiRecord(u32 actID, u32 time);
u32 SaveGame__SetVikingCupSailboatRecord(u32 actID, u32 score);
u32 SaveGame__SetVikingCupHovercraftRecord(u32 actID, u32 score);
u32 SaveGame__SetVikingCupSubmarineRecord(u32 actID, u32 score);
u32 SaveGame__GetVikingCupJetskiRecord(u32 actID, u32 rank);
u32 SaveGame__GetVikingCupSailboatRecord(u32 actID, u32 rank);
u32 SaveGame__GetVikingCupHovercraftRecord(u32 actID, u32 rank);
u32 SaveGame__GetVikingCupSubmarineRecord(u32 actID, u32 rank);
void SaveGame__SaveLeaderboardRankOrder(s32 stage, u32 order);
void SaveGame__SaveLeaderboardRank_Top(s32 stage, u16 rank, char16 *name, size_t nameLength, u16 time, s32 flag);
void SaveGame__SaveLeaderboardRank_Near(s32 stage, u16 rank, char16 *name, size_t nameLength, u16 time, s32 flag);
void SaveGame__SetLeaderboardLastUpdatedTime(u32 stage);
BOOL SaveGame__CheckLeaderboardHasRecords(u32 stage);
u32 SaveGame__GetLeaderboardRankOrder(u32 stage);
SaveOnlineLeaderboardsRankEntry *SaveGame__GetLeaderboardsEntry_Top(s32 stage, u16 rank);
u16 SaveGame__GetLeaderboardsNameLen_Top(s32 stage, u16 rank);
u16 SaveGame__GetLeaderboardsTime_Top(s32 stage, u16 rank);
u16 SaveGame__GetLeaderboardRankFlag_Top(s32 stage, u16 rank);
SaveOnlineLeaderboardsRankEntry *SaveGame__GetLeaderboardsEntry_Near(s32 stage, u16 rank);
u16 SaveGame__GetLeaderboardsNameLen_Near(s32 stage, u16 rank);
u16 SaveGame__GetLeaderboardsTime_Near(s32 stage, u16 rank);
u16 SaveGame__GetLeaderboardRankFlag_Near(s32 stage, u16 rank);
s64 SaveGame__GetLeaderboardLastUpdatedTime(u32 stage);
u32 SaveGame__GetOnlineScore(void);
void SaveGame__UpdateOnlineScore(SaveVsRecordType matchResult, s32 opponentScore);
u32 SaveGame__GetStageScore(u32 stageID);
u32 SaveGame__GetStageRank(u32 stageID);
BOOL SaveGame__UpdateStageRecord(u32 stageID, u32 score, u32 rank);
void SaveGame__SetLastPlayedVsMode(BOOL isVsRace);
BOOL SaveGame__GetLastPlayedVsMode(void);
void SaveGame__SetNoLastPlayedVsMode(void);
void SaveGame__DisconnectLoseVsMatch(void);
BOOL SaveGame__HandlePlayerVsDisconnect(void);
BOOL SaveGame__Func_2060458(void);
BOOL SaveGame__Func_206047C(s32 a1);
u16 SaveGame__SetVikingCupScoreRecord(struct SaveVikingCupRecord *records, u32 score);
u16 SaveGame__SetVikingCupTimeRecord(struct SaveVikingCupRecord *records, u32 time);
BOOL SaveGame__CheckStageAllowDifficulties(u32 stageID);

#ifdef __cplusplus
}
#endif

#endif // RUSH_SAVEGAME_H
