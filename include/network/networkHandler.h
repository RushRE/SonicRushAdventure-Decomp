#ifndef RUSH2_NETWORKHANDLER_H
#define RUSH2_NETWORKHANDLER_H

#include <global.h>
#include <game/system/task.h>

// --------------------
// CONSTANTS
// --------------------

#define MATCH_BUFFER_COUNT 0x20

#define LEADERBOARDS_RANK_COUNT 10

// --------------------
// ENUMS
// --------------------

enum INetManagerStatus_
{
    INETMANAGER_STATUS_INACTIVE,
    INETMANAGER_STATUS_IDLE,
    INETMANAGER_STATUS_CONNECTED,
    INETMANAGER_STATUS_DISCONNECTED,
};
typedef u32 INetManagerStatus;

enum MatchManagerStatus_
{
    MATCHMANAGER_STATUS_INACTIVE,
    MATCHMANAGER_STATUS_IDLE,
    MATCHMANAGER_STATUS_SERVER_UPDATED,
    MATCHMANAGER_STATUS_ERROR,
};
typedef u32 MatchManagerStatus;

enum ConnectionManagerStatus_
{
    CONNECTIONMANAGER_STATUS_INACTIVE,
    CONNECTIONMANAGER_STATUS_IDLE,
    CONNECTIONMANAGER_STATUS_CANCELLED,
    CONNECTIONMANAGER_STATUS_CONNECTED,
    CONNECTIONMANAGER_STATUS_ERROR,
};
typedef u32 ConnectionManagerStatus;

enum NdManagerStatus_
{
    NDMANAGER_STATUS_WORKING,
    NDMANAGER_STATUS_IDLE,
};
typedef u32 NdManagerStatus;

enum LeaderboardsManagerStatus_
{
    LEADERBOARDSMANAGER_STATUS_INACTIVE,
    LEADERBOARDSMANAGER_STATUS_IDLE,
    LEADERBOARDSMANAGER_STATUS_PUTTING_SCORE,
    LEADERBOARDSMANAGER_STATUS_LOADING_SCORES,
    LEADERBOARDSMANAGER_STATUS_CANCELLED,
    LEADERBOARDSMANAGER_STATUS_ERROR,
};
typedef u32 LeaderboardsManagerStatus;

enum DataTransferMode_
{
    DATATRANSFER_MODE_RELIABLE,
    DATATRANSFER_MODE_UNRELIABLE,
};
typedef u32 DataTransferMode;

// --------------------
// STRUCTS
// --------------------

struct DataTransferBufferHeader
{
    u32 unknown : 4;
    u32 size : 28;
};

typedef struct DataTransferBuffer_
{
    struct DataTransferBufferHeader header;
    u8 data[1]; // C-style variable array
} DataTransferBuffer;

typedef struct INetManager_
{
    void (*state)(struct INetManager_ *work);
    void (*onDisconnect)(void);
    INetManagerStatus status;
} INetManager;

typedef struct MatchManager_
{
    void (*state)(struct MatchManager_ *work);
    DWCUserData *userData;
    DWCAccFriendData *friendList;
    u16 friendCount;
    s16 field_E;
    s32 serverChanged;
    void (*onError)(DWCError error);
    MatchManagerStatus status;
    DWCFriendStatusCallback onFriendStatusChange;
    void *onFriendStatusChangeParam;
    DWCDeleteFriendListCallback onFriendDeleted;
    void *onFriendDeletedParam;
    DataTransferBuffer *sendBuffer;
    DataTransferBuffer *recieveBuffer[MATCH_BUFFER_COUNT];
    DataTransferBuffer *recieveBufferStorage[MATCH_BUFFER_COUNT];
    DataTransferBuffer *recvBuffer[MATCH_BUFFER_COUNT];
    size_t bufferSize;
} MatchManager;

typedef struct ConnectionManager_
{
    void (*state)(struct ConnectionManager_ *work);
    s32 field_4;
    u16 roomMinPlayerCount;
    u16 field_A;
    ConnectionManagerStatus status;
} ConnectionManager;

typedef struct DataTransferManager_
{
    DataTransferMode transferMode;
    size_t readyBufferSize;
    u32 bitmap;
} DataTransferManager;

typedef struct NdManager_
{
    void (*state)(struct NdManager_ *work);
    s32 field_4;
    s32 field_8;
    NdManagerStatus status;
} NdManager;

typedef struct LeaderboardsManager_
{
    void (*state)(struct LeaderboardsManager_ *work);
    LeaderboardsManagerStatus status;
    DWCUserData *profile;
    s32 timer;
    DWCRnkGetMode getMode;
    DWCRnkGetParam getParam;
    u32 rankTotal;
    u32 rankOrder;
    DWCRnkData rankDataList[LEADERBOARDS_RANK_COUNT];
    u32 rowCount;
} LeaderboardsManager;

// --------------------
// FUNCTIONS
// --------------------

// Network
s32 InitNetwork(s32 mode);

// iNet
void CreateINetManager(void);
void DestroyINetManager(BOOL noCleanup);
INetManagerStatus GetINetManagerStatus(void);

// Matches
void CreateMatchManager(DWCUserData *userData, DWCAccFriendData *friendList, u16 friendCount, const char16 *name);
void DestroyMatchManager(void);
void SetMatchFriendDeleteCallback(DWCDeleteFriendListCallback onFriendDeleted, void *param);
MatchManagerStatus GetMatchManagerStatus(void);

// Connection
void CreateConnectionManagerForAnybody(u8 roomMaxPlayerCount, u8 roomMinPlayerCount, u32 bufferSize, const char *addFilter, DWCEvalPlayerCallback evalPlayerCallback,
                                       void *evalParam);
void CreateConnectionManagerForFriends(u8 roomMaxPlayerCount, u8 roomMinPlayerCount, u32 bufferSize, DWCEvalPlayerCallback evalPlayerCallback, void *evalParam);
void DestroyConnectionManager(void);
ConnectionManagerStatus GetConnectionManagerStatus(void);

// Data Transfer
void CreateDataTransferManager(void);
void DestroyDataTransferManager(void);
void *GetDataTransferSendBuffer(void);
void *GetDataTransferRecieveBuffer(u32 id);
void ClearDataTransferSendBuffer(void);
void ClearDataTransferAllBuffers(void);
void SetDataTransferConfig(u32 bitmap, u32 readyBufferSize, DataTransferMode transferMode);
void SetDataTransferConfigEx(u32 bitmap, u32 readyBufferSize, DataTransferMode transferMode, u8 unknown);

// Storage
void DestroyStorageManager(void);

// Nd
void DestroyNdManager(void);

// Leaderboards
BOOL CreateLeaderboardsManager(DWCUserData *profile);
void DestroyLeaderboardsManager(void);
LeaderboardsManagerStatus GetLeaderboardsManagerStatus(void);
void PutScoreToLeaderboards(u32 category, DWCRnkRegion region, s32 score, void *data, u32 size);
BOOL LoadLeaderboardRanksTopList(u32 category, DWCRnkRegion region, BOOL unsorted, u32 since, u32 limit);
BOOL LoadLeaderboardRanksNear(u32 category, DWCRnkRegion region, BOOL unsorted, u32 since, u32 limit);
s32 GetLeaderboardsRankOrder(void);
u32 GetLeaderboardsRankCount(void);
DWCRnkData *GetLeaderboardsRankData(s32 id);

#endif // RUSH2_NETWORKHANDLER_H