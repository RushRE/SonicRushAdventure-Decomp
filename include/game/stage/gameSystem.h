#ifndef RUSH_GAMESYSTEM_H
#define RUSH_GAMESYSTEM_H

#include <global.h>
#include <game/system/task.h>
#include <game/input/padInput.h>
#include <game/object/objCollision.h>
#include <game/object/objPacket.h>
#include <game/file/fsRequest.h>
#include <stage/player/player.h>
#include <game/stage/stageAssets.h>

// --------------------
// CONSTANTS
// --------------------

#define GAMESYSTEM_SENDPACKET_LIST_SIZE 0x10

// --------------------
// ENUMS
// --------------------

enum PlayerGameStatusFlags_
{
    PLAYERGAMESTATUS_FLAG_NONE = 0x00,

    PLAYERGAMESTATUS_FLAG_FREEZE_TIME                    = 0x01,
    PLAYERGAMESTATUS_FLAG_PLAYER_DIED                    = 0x02,
    PLAYERGAMESTATUS_FLAG_CAN_CHANGE_EVENT               = 0x04,
    PLAYERGAMESTATUS_FLAG_NEEDS_DATATRANSFER_CONFIG_INIT = 0x08,
    PLAYERGAMESTATUS_FLAG_NO_MORE_STAGEFINISHEVENTS      = 0x10,
    PLAYERGAMESTATUS_FLAG_FADE_IS_ACTIVE                 = 0x20,
    PLAYERGAMESTATUS_FLAG_STAGESCOREEVENT_ACTIVE         = 0x40,
    PLAYERGAMESTATUS_FLAG_DISABLE_PLAYER_INPUTS          = 0x80,
    PLAYERGAMESTATUS_FLAG_NETWORK_ERROR                  = 0x100,
    PLAYERGAMESTATUS_FLAG_STAGEFINISHEVENT_SENT          = 0x200,
    PLAYERGAMESTATUS_FLAG_STAGESCOREEVENT_SENT           = 0x400,
};
typedef u32 PlayerGameStatusFlags;

enum GameDataLoadProc_
{
    GAMEDATA_LOADPROC_NONE   = 0,
    GAMEDATA_LOADPROC_COMMON = 1 << 0,
    GAMEDATA_LOADPROC_STAGE  = 1 << 1,
    GAMEDATA_LOADPROC_ALL    = GAMEDATA_LOADPROC_COMMON | GAMEDATA_LOADPROC_STAGE,
};
typedef u32 GameDataLoadProc;

enum StageStartType_
{
    STAGESTART_STARTPLATFORM,
    STAGESTART_GROUND,
    STAGESTART_FADEIN,
};
typedef u32 StageStartType;

enum GamePacketType_
{
    GAMEPACKET_INVALID,
    GAMEPACKET_PLAYER,
    GAMEPACKET_INTERACTABLE,
    GAMEPACKET_UNKNOWN,
    GAMEPACKET_RINGCOUNT,
    GAMEPACKET_STAGESCORE,
    GAMEPACKET_STAGEFINISH,
};
typedef u32 GamePacketType;

// --------------------
// STRUCTS
// --------------------

struct MissionEntry
{
    u8 stageID;
    u8 type;

    struct
    {
        u32 timeLimit;
        u32 quota;
    } config[2];
};

typedef struct GameDataRequest_
{
    s32 load_proc;
} GameDataRequest;

typedef struct PlayerGameStatus_
{
    PlayerGameStatusFlags flags;
    Task *gameOnlineSysTask;
    Task *gameOfflineSysTask;
    u32 stageTimer;
    u32 trickBonus;
    u32 speedBonus;
    u32 speedBonusCount;
    u32 ringBonus;
    u32 field_20;
    u8 lives;
    u8 recallCheckpointID;
    u32 recallTime;
    Vec2Fx32 spawnPosition;
    u16 recallWaterLevel;
    PadInputState input;
    u16 field_88[2];
    u16 field_8C[2];
    u16 networkErrorTimer;
    u16 stageScoreEventTimer;
    u16 stageFinishEventTimer;
    union
    {
        s16 rings;
        u32 time;
    } vsStageScore[2];
    GameObjectSendPacket *sendPacketList;
    u32 sendPacketCount;
    s32 playerLapCounter[PLAYER_COUNT];
    s32 playerTargetLaps[PLAYER_COUNT];
    s32 lapMarkerPos;

    struct PlayerMissionStatus
    {
        s32 stageTimeLimit;
        s32 quotaTarget;
        s16 quota;
        s16 passedFlagID;
        s16 enemyDefeatCount;
        s16 totalStarCount;
    } missionStatus;
} PlayerGameStatus;

// --------------------
// VARIABLES
// --------------------

extern MIProcessor mainMemProcessor;
extern void *gameArchiveMission;
extern Player *gPlayer;
extern Player *gPlayerList[PLAYER_COUNT];
extern OBS_DIFF_COLLISION stageCollision;
extern PlayerGameStatus playerGameStatus;

extern OBS_DATA_WORK bossAssetFiles[16];

// --------------------
// FUNCTIONS
// --------------------

void ReleaseGameSystem(void);
void FlushGameSystem(u8 flags);
void ReleaseGameState(void);
void InitGameSystemForStage(void);
void SetupDisplayForZone(BOOL resetTexPaletteBuffers);
void SetupDisplayForBoss(BOOL resetTexPaletteBuffers);

BOOL IsBossStage(void);
s32 GetCurrentZoneID(void);
BOOL CheckStageUsesLaps(void);
StageStartType GetStageStartType(void);
BOOL IsSnowboardStage(void);
BOOL IsSnowboardActive(void);
s32 GetVSBattlePosition(Player *player);
void SendPacketForStageScoreEvent(void);
void SendPacketForStageFinishEvent(void);
GameObjectSendPacket *RequestNextSendPacket(void);

#endif // RUSH_GAMESYSTEM_H