#include <network/networkHandler.h>
#include <game/system/allocator.h>
#include <game/graphics/renderCore.h>

// --------------------
// CONSTANTS
// --------------------

#define RUSH_DWC_PRODUCTID  11073
#define RUSH_DWC_GAME_NAME  "sonicrushads"
#define RUSH_DWC_SECRET_KEY "so70kL"

#define RUSH_RANKING_INITDATA "GJAUDfkWhyXycROchNeD0002662d00006beb00000004123f138fsonicrushads"

#define MATCHHANDLER_BUFFER_SIZE 0x800

#define CONNECTION_TIMEOUT_TIME 60000

#define DATATRANSFER_TIMEOUT_TIME 25000

#define LEADERBOARDS_TIMEOUT_TIME 300

// --------------------
// TYPES
// --------------------

typedef void *(*DWCAllocFunc)(size_t size);
typedef void (*DWCFreeFunc)(void *memory);

// TODO: temp struct to fix the issues with DWCFriendsMatchControl, it expects to be 0xDEC bytes, but the one atm is only 0xDE4 bytes
struct TEMP_DWCFriendsMatchControl
{
    DWCFriendsMatchControl control;
    u8 padding[0x8];
};

// --------------------
// VARIABLES
// --------------------

static u16 roomMaxPlayerCount;
static DWCAllocFunc memAlloc;
static Task *connectionManagerTask;
static DWCFreeFunc memFree;
static DWCAllocFunc unknownAlloc;
static Task *dataTransferManagerTask;
static Task *matchManagerTask;
static Task *iNetManagerTask;
static Task *leaderboardsManagerTask;
static Task *ndManagerTask;
static Task *storageManagerTask;
static DWCFreeFunc unknownFree;

static DWCInetControl dwcINetControl;

// TODO: uncomment proper struct when it is matched
// static DWCFriendsMatchControl dwcFriendsMatchControl;
static struct TEMP_DWCFriendsMatchControl dwcFriendsMatchControl;

// --------------------
// FUNCTION DECLS
// --------------------

// Network
static void *NetworkAlloc(DWCAllocType name, u32 size, int align);
static void NetworkFree(DWCAllocType name, void *ptr, u32 size);

// iNet
static void INetManager_Main(void);
static void INetManager_Destructor(Task *task);
static void INetManager_State_Init(INetManager *work);
static void INetManager_State_Connected(INetManager *work);
static void INetManager_State_Disconnected(INetManager *work);

// Matches
static MatchManager *GetMatchManagerWork(void);
static void InitMatchBuffers(MatchManager *work, size_t bufferSize, u32 maxPlayerCount);
static void ReleaseMatchBuffers(MatchManager *work);
static void MatchManager_Main(void);
static void MatchManager_Destructor(Task *task);
static void MatchLoginCallback(DWCError error, int profileID, void *param);
static void MatchBuddyFriendCallback(int index, void *param);
static void MatchServerUpdateCallback(DWCError error, BOOL isChanged, void *param);
static void MatchFriendStatusCallback(int index, u8 status, const char *statusString, void *param);
static void MatchDeleteFriendCallback(int deletedIndex, int srcIndex, void *param);
static void MatchManager_State_Idle(MatchManager *work);
static void MatchManager_State_LoggedIn(MatchManager *work);
static void MatchManager_State_ServerUpdate(MatchManager *work);
static void MatchManager_State_SeverUpdated(MatchManager *work);
static void MatchManager_State_Error(MatchManager *work);

// Connection
static void ConnectionManager_Main(void);
static void ConnectionManager_Destructor(Task *task);
static void ConnectionMatchedCallback(DWCError error, BOOL cancel, void *param);
static void ConnectionClosedCallback(DWCError error, BOOL isLocal, BOOL isServer, u8 aid, int index, void *param);
static void PrepareMatchMakingConnection(u8 roomMaxPlayerCount, u8 roomMinPlayerCount);
static void ConnectionManager_State_Connecting(ConnectionManager *work);
static void ConnectionManager_State_Connected(ConnectionManager *work);
static void ConnectionManager_State_ConnectionCancelled(ConnectionManager *work);
static void ConnectionManager_State_ConnectionError(ConnectionManager *work);

// Data Transfer
static DataTransferManager *GetDataTransferManagerWork(void);
static void DataTransferManager_Main(void);
static void DataTransferManager_Destructor(Task *task);
static void DataTransferUserRecvCallback(u8 aid, u8 *buffer, int size);
static void DataTransferUserRecvTimeoutCallback(u8 aid);
static BOOL DataTransferShouldSendBitmap(u8 frequency);

// Nd
static void NdCleanupCallback(void);
static NdManager *GetNdManagerWork(void);

// Leaderboards
static LeaderboardsManager *GetLeaderboardsManagerWork(void);
static BOOL LoadLeaderboardsScore(LeaderboardsManager *work, u32 category, DWCRnkRegion region);
static BOOL HandleRankError(DWCRnkError error);
static BOOL LoadLeaderboardRowTotal(LeaderboardsManager *work);
static BOOL LoadLeaderboardRowCount(LeaderboardsManager *work);
static BOOL LoadLeaderboardRows(LeaderboardsManager *work);
static void LeaderboardsManager_Main(void);
static void LeaderboardsManager_Destructor(Task *task);
static void LeaderboardsManager_State_Idle(LeaderboardsManager *work);
static void LeaderboardsManager_State_PutScoreSuccess(LeaderboardsManager *work);
static void LeaderboardsManager_State_ProcessRanks(LeaderboardsManager *work);
static void LeaderboardsManager_State_GetScoreSuccess(LeaderboardsManager *work);
static void LeaderboardsManager_State_ProcessPutScore(LeaderboardsManager *work);
static void LeaderboardsManager_State_Leaderboards_Ordered(LeaderboardsManager *work);
static void LeaderboardsManager_State_Leaderboards_TopList(LeaderboardsManager *work);
static void LeaderboardsManager_State_Leaderboards_Near(LeaderboardsManager *work);
static void LeaderboardsManager_State_Leaderboards_Friends(LeaderboardsManager *work);
static void LeaderboardsManager_State_Error(LeaderboardsManager *work);

// --------------------
// FUNCTIONS
// --------------------

s32 InitNetwork(s32 mode)
{
    static DWCAllocFunc allocFuncTable[] = {
        _AllocHeadHEAP_SYSTEM, _AllocTailHEAP_SYSTEM, _AllocHeadHEAP_USER, _AllocTailHEAP_USER, _AllocHeadHEAP_ITCM, _AllocTailHEAP_ITCM, _AllocHeadHEAP_DTCM, _AllocTailHEAP_DTCM,
    };

    static DWCFreeFunc freeFuncTable[] = {
        _FreeHEAP_SYSTEM, _FreeHEAP_SYSTEM, _FreeHEAP_USER, _FreeHEAP_USER, _FreeHEAP_ITCM, _FreeHEAP_ITCM, _FreeHEAP_DTCM, _FreeHEAP_DTCM,
    };

    DWCAllocFunc allocFunc = allocFuncTable[mode];
    DWCFreeFunc freeFunc   = freeFuncTable[mode];

    memAlloc     = allocFunc;
    memFree      = freeFunc;
    unknownAlloc = allocFunc;
    unknownFree  = freeFunc;

    void *dwcWork = HeapAllocHead(HEAP_SYSTEM, DWC_INIT_WORK_SIZE);
    s32 status    = DWC_Init(dwcWork);
    HeapFree(HEAP_SYSTEM, dwcWork);

    DWC_SetMemFunc(NetworkAlloc, NetworkFree);
    return status;
}

void CreateINetManager(void)
{
    Task *task      = TaskCreate(INetManager_Main, INetManager_Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, TASK_PAUSE_LOWEST,
                                 TASK_PRIORITY_UPDATE_LIST_START, TASK_GROUP_HIGHEST - 2, INetManager);
    iNetManagerTask = task;

    INetManager *work = TaskGetWork(task, INetManager);
    TaskInitWork16(work);

    work->state  = INetManager_State_Init;
    work->status = INETMANAGER_STATUS_IDLE;

    DWC_InitInetEx(&dwcINetControl, 2, 1, 20);
    DWC_SetAuthServer(DWC_CONNECTINET_AUTH_RELEASE);
    DWC_ConnectInetAsync();
}

void DestroyINetManager(BOOL noCleanup)
{
    switch (noCleanup)
    {
        case FALSE:
            switch (DWC_GetInetStatus())
            {
                case DWC_CONNECTINET_STATE_NOT_INITIALIZED:
                case DWC_CONNECTINET_STATE_IDLE:
                case DWC_CONNECTINET_STATE_FATAL_ERROR:
                    break;

                default:
                    DWC_ClearError();
                    DWC_CleanupInet();
                    break;
            }
            break;

        case TRUE:
            break;
    }

    if (iNetManagerTask == NULL)
        return;

    SetTaskFlags(iNetManagerTask, TASK_FLAG_NONE);
    DestroyTask(iNetManagerTask);
}

INetManagerStatus GetINetManagerStatus(void)
{
    if (iNetManagerTask == NULL)
        return INETMANAGER_STATUS_INACTIVE;

    INetManager *work = TaskGetWork(iNetManagerTask, INetManager);
    return work->status;
}

void CreateMatchManager(DWCUserData *userData, DWCAccFriendData *friendList, u16 friendCount, const char16 *name)
{
    Task *task       = TaskCreate(MatchManager_Main, MatchManager_Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, TASK_PAUSE_LOWEST,
                                  TASK_PRIORITY_UPDATE_LIST_START, TASK_GROUP_HIGHEST - 2, MatchManager);
    matchManagerTask = task;

    MatchManager *work = TaskGetWork(task, MatchManager);
    TaskInitWork16(work);

    work->state       = MatchManager_State_Idle;
    work->userData    = userData;
    work->friendList  = friendList;
    work->friendCount = friendCount;
    work->status      = MATCHMANAGER_STATUS_IDLE;

    DWC_InitFriendsMatch(&dwcFriendsMatchControl.control, work->userData, RUSH_DWC_PRODUCTID, RUSH_DWC_GAME_NAME, RUSH_DWC_SECRET_KEY, MATCHHANDLER_BUFFER_SIZE,
                         MATCHHANDLER_BUFFER_SIZE, work->friendList, work->friendCount);

    if (!DWC_LoginAsync(name, NULL, MatchLoginCallback, work))
    {
        work->status = MATCHMANAGER_STATUS_ERROR;
        work->state  = MatchManager_State_Error;
    }
}

void DestroyMatchManager(void)
{
    DWC_ShutdownFriendsMatch();
    if (matchManagerTask == NULL)
        return;

    DWC_CloseConnectionsAsync();

    OSIntrMode enabled = OS_DisableInterrupts();
    SetTaskFlags(matchManagerTask, 0);
    DestroyTask(matchManagerTask);
    OS_RestoreInterrupts(enabled);
}

void SetMatchFriendDeleteCallback(DWCDeleteFriendListCallback onFriendDeleted, void *param)
{
    if (matchManagerTask == NULL)
        return;

    GetMatchManagerWork()->onFriendDeleted      = onFriendDeleted;
    GetMatchManagerWork()->onFriendDeletedParam = param;
}

MatchManagerStatus GetMatchManagerStatus(void)
{
    if (matchManagerTask == NULL)
        return MATCHMANAGER_STATUS_INACTIVE;

    MatchManager *work = GetMatchManagerWork();
    return work->status;
}

void CreateConnectionManagerForAnybody(u8 maxPlayerCount, u8 minPlayerCount, u32 bufferSize, const char *addFilter, DWCEvalPlayerCallback evalPlayerCallback, void *evalParam)
{
    roomMaxPlayerCount = maxPlayerCount;
    InitMatchBuffers(GetMatchManagerWork(), bufferSize + sizeof(struct DataTransferBufferHeader), maxPlayerCount);

    Task *task            = TaskCreate(ConnectionManager_Main, ConnectionManager_Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, TASK_PAUSE_LOWEST,
                                       TASK_PRIORITY_UPDATE_LIST_START, TASK_GROUP_HIGHEST - 2, ConnectionManager);
    connectionManagerTask = task;

    ConnectionManager *work = TaskGetWork(task, ConnectionManager);
    TaskInitWork16(work);
    work->state              = ConnectionManager_State_Connecting;
    work->roomMinPlayerCount = minPlayerCount;
    work->status             = CONNECTIONMANAGER_STATUS_IDLE;

    DWC_ConnectToAnybodyAsync(maxPlayerCount, addFilter, ConnectionMatchedCallback, work, evalPlayerCallback, evalParam);
    DWC_SetConnectionClosedCallback(ConnectionClosedCallback, NULL);
    PrepareMatchMakingConnection(maxPlayerCount, minPlayerCount);
}

void CreateConnectionManagerForFriends(u8 maxPlayerCount, u8 minPlayerCount, u32 bufferSize, DWCEvalPlayerCallback evalPlayerCallback, void *evalParam)
{
    roomMaxPlayerCount = maxPlayerCount;
    InitMatchBuffers(GetMatchManagerWork(), bufferSize + sizeof(struct DataTransferBufferHeader), maxPlayerCount);

    Task *task            = TaskCreate(ConnectionManager_Main, ConnectionManager_Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, TASK_PAUSE_LOWEST,
                                       TASK_PRIORITY_UPDATE_LIST_START, TASK_GROUP_HIGHEST - 2, ConnectionManager);
    connectionManagerTask = task;

    ConnectionManager *work = TaskGetWork(task, ConnectionManager);
    TaskInitWork16(work);
    work->state              = ConnectionManager_State_Connecting;
    work->roomMinPlayerCount = minPlayerCount;
    work->status             = CONNECTIONMANAGER_STATUS_IDLE;

    DWC_ConnectToFriendsAsync(NULL, 0, maxPlayerCount, TRUE, ConnectionMatchedCallback, work, evalPlayerCallback, evalParam);
    DWC_SetConnectionClosedCallback(ConnectionClosedCallback, NULL);
    PrepareMatchMakingConnection(maxPlayerCount, minPlayerCount);
}

void DestroyConnectionManager(void)
{
    if (connectionManagerTask == NULL)
        return;

    SetTaskFlags(connectionManagerTask, 0);
    DestroyTask(connectionManagerTask);
}

ConnectionManagerStatus GetConnectionManagerStatus(void)
{
    if (connectionManagerTask == NULL)
        return CONNECTIONMANAGER_STATUS_INACTIVE;

    ConnectionManager *work = TaskGetWork(connectionManagerTask, ConnectionManager);
    return work->status;
}

void CreateDataTransferManager(void)
{
    MatchManager *manager = GetMatchManagerWork();
    UNUSED(manager);

    Task *task = TaskCreate(DataTransferManager_Main, DataTransferManager_Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, TASK_PAUSE_LOWEST,
                            TASK_PRIORITY_UPDATE_LIST_START, TASK_GROUP_HIGHEST - 2, DataTransferManager);
    dataTransferManagerTask = task;

    DataTransferManager *work = TaskGetWork(task, DataTransferManager);
    TaskInitWork16(work);

    ClearDataTransferSendBuffer();
    ClearDataTransferAllBuffers();
    DWC_SetUserRecvCallback(DataTransferUserRecvCallback);
    DWC_SetUserRecvTimeoutCallback(DataTransferUserRecvTimeoutCallback);

    for (u32 i = 0; i < roomMaxPlayerCount; i++)
    {
        DWC_SetRecvTimeoutTime(i, DATATRANSFER_TIMEOUT_TIME);
    }
}

void DestroyDataTransferManager(void)
{
    if (dataTransferManagerTask == NULL)
        return;

    SetTaskFlags(dataTransferManagerTask, 0);
    DestroyTask(dataTransferManagerTask);
}

void *GetDataTransferSendBuffer(void)
{
    return GetMatchManagerWork()->sendBuffer->data;
}

void *GetDataTransferRecieveBuffer(u32 id)
{
    return GetMatchManagerWork()->recieveBuffer[id]->data;
}

void ClearDataTransferSendBuffer(void)
{
    MatchManager *manager = GetMatchManagerWork();
    MI_CpuClear32(manager->sendBuffer, manager->bufferSize);
}

void ClearDataTransferAllBuffers(void)
{
    MatchManager *manager = GetMatchManagerWork();

    OSIntrMode enabled = OS_DisableInterrupts();
    for (u32 i = 0; i < roomMaxPlayerCount; i++)
    {
        MI_CpuClear32(manager->recieveBuffer[i], manager->bufferSize);
        MI_CpuClear32(manager->recieveBufferStorage[i], manager->bufferSize);
        MI_CpuClear32(manager->recvBuffer[i], manager->bufferSize);

        DC_StoreRange(manager->recvBuffer[i], manager->bufferSize);
    }
    OS_RestoreInterrupts(enabled);
}

void SetDataTransferConfig(u32 bitmap, u32 readyBufferSize, DataTransferMode transferMode)
{
    u8 unknown;
    if (transferMode == DATATRANSFER_MODE_RELIABLE)
        unknown = 12;
    else
        unknown = 4;

    SetDataTransferConfigEx(bitmap, readyBufferSize, transferMode, unknown);
}

void SetDataTransferConfigEx(u32 bitmap, u32 readyBufferSize, DataTransferMode transferMode, u8 unknown)
{
    DataTransferManager *work = GetDataTransferManagerWork();

    work->bitmap          = bitmap;
    work->readyBufferSize = readyBufferSize;
    work->transferMode    = transferMode;

    DataTransferBuffer *buffer = (DataTransferBuffer *)((struct DataTransferBufferHeader *)GetDataTransferSendBuffer() - 1);

    buffer->header.unknown = unknown;
}

void DestroyStorageManager(void)
{
    DWC_LogoutFromStorageServer();

    if (storageManagerTask == NULL)
        return;

    SetTaskFlags(storageManagerTask, 0);
    DestroyTask(storageManagerTask);
}

void DestroyNdManager(void)
{
    if (ndManagerTask == NULL)
        return;

    DWC_NdCleanupAsync(NdCleanupCallback);

    while (GetNdManagerWork()->status == NDMANAGER_STATUS_WORKING)
    {
        OS_WaitVBlankIntr();
    }

    SetTaskFlags(ndManagerTask, 0);
    DestroyTask(ndManagerTask);
}

BOOL CreateLeaderboardsManager(DWCUserData *profile)
{
    if (!DWC_CheckHasProfile(profile))
        return FALSE;

    Task *task = TaskCreate(LeaderboardsManager_Main, LeaderboardsManager_Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, TASK_PAUSE_LOWEST,
                            TASK_PRIORITY_UPDATE_LIST_START, TASK_GROUP_HIGHEST - 2, LeaderboardsManager);
    leaderboardsManagerTask = task;

    LeaderboardsManager *work = TaskGetWork(task, LeaderboardsManager);
    TaskInitWork16(work);
    work->state   = LeaderboardsManager_State_Idle;
    work->status  = LEADERBOARDSMANAGER_STATUS_IDLE;
    work->profile = profile;
    work->getMode = (DWCRnkGetMode)-1;

    switch (DWC_RnkInitialize(RUSH_RANKING_INITDATA, profile))
    {
        case DWC_RNK_IN_ERROR:
        case DWC_RNK_ERROR_INVALID_PARAMETER:
        case DWC_RNK_ERROR_INIT_INVALID_USERDATA:
        default:
            SetTaskFlags(leaderboardsManagerTask, 0);
            DestroyTask(leaderboardsManagerTask);
            return FALSE;

        case DWC_RNK_SUCCESS:
        case DWC_RNK_ERROR_INIT_INVALID_INITDATASIZE:
        case DWC_RNK_ERROR_INIT_INVALID_INITDATA:
            return TRUE;
    }
}

void DestroyLeaderboardsManager(void)
{
    DWC_RnkShutdown();

    if (leaderboardsManagerTask == NULL)
        return;

    SetTaskFlags(leaderboardsManagerTask, 0);
    DestroyTask(leaderboardsManagerTask);
}

LeaderboardsManagerStatus GetLeaderboardsManagerStatus(void)
{
    if (leaderboardsManagerTask == NULL)
        return LEADERBOARDSMANAGER_STATUS_INACTIVE;

    LeaderboardsManager *work = GetLeaderboardsManagerWork();
    return work->status;
}

void PutScoreToLeaderboards(u32 category, DWCRnkRegion region, s32 score, void *data, u32 size)
{
    LeaderboardsManager *work = GetLeaderboardsManagerWork();
    if (data == NULL)
        size = 0;

    work->rankTotal = 0;
    work->rankOrder = DWC_RNK_ORDER_ASC;
    work->getMode   = (DWCRnkGetMode)-1;

    if (DWC_RnkPutScoreAsync(category, region, score, data, size) == DWC_RNK_SUCCESS)
    {
        work->status = LEADERBOARDSMANAGER_STATUS_PUTTING_SCORE;
        work->state  = LeaderboardsManager_State_PutScoreSuccess;
    }
    else
    {
        work->status = LEADERBOARDSMANAGER_STATUS_ERROR;
        work->state  = LeaderboardsManager_State_Error;
    }
}

BOOL LoadLeaderboardRanksTopList(u32 category, DWCRnkRegion region, BOOL unsorted, u32 since, u32 limit)
{
    LeaderboardsManager *work = GetLeaderboardsManagerWork();

    MI_CpuClear16(&work->getParam, sizeof(work->getParam));
    work->getParam.size          = sizeof(work->getParam.toplist);
    work->getParam.toplist.sort  = unsorted == FALSE;
    work->getParam.toplist.since = since;
    work->getParam.toplist.limit = limit;
    work->getMode                = DWC_RNK_GET_MODE_TOPLIST;

    return LoadLeaderboardsScore(work, category, region);
}

BOOL LoadLeaderboardRanksNear(u32 category, DWCRnkRegion region, BOOL unsorted, u32 since, u32 limit)
{
    LeaderboardsManager *work = GetLeaderboardsManagerWork();

    MI_CpuClear16(&work->getParam, sizeof(work->getParam));
    work->getParam.size       = sizeof(work->getParam.near);
    work->getParam.near.sort  = unsorted == FALSE;
    work->getParam.near.since = since;
    work->getParam.near.limit = limit;
    work->getMode             = DWC_RNK_GET_MODE_NEAR;

    return LoadLeaderboardsScore(work, category, region);
}

s32 GetLeaderboardsRankOrder(void)
{
    LeaderboardsManager *work = GetLeaderboardsManagerWork();

    switch (work->getMode)
    {
        case DWC_RNK_GET_MODE_ORDER:
            return work->rankOrder;

        case DWC_RNK_GET_MODE_TOPLIST:
            return DWC_RNK_ORDER_ASC;

        case DWC_RNK_GET_MODE_NEAR:
        case DWC_RNK_GET_MODE_FRIENDS:
            if (work->rowCount)
            {
                if (work->rankDataList[0].score == 0 && work->rankDataList[0].region == -1)
                    return DWC_RNK_ORDER_ASC;
                else
                    return work->rankDataList[0].order;
            }
            else
            {
                return DWC_RNK_ORDER_ASC;
            }

        default:
            return DWC_RNK_ORDER_ASC;
    }
}

u32 GetLeaderboardsRankCount(void)
{
    return GetLeaderboardsManagerWork()->rowCount;
}

DWCRnkData *GetLeaderboardsRankData(s32 id)
{
    return &GetLeaderboardsManagerWork()->rankDataList[id];
}

void *NetworkAlloc(DWCAllocType name, u32 size, int align)
{
    return memAlloc(size);
}

void NetworkFree(DWCAllocType name, void *ptr, u32 size)
{
    if (ptr != NULL)
        memFree(ptr);
}

void INetManager_Main(void)
{
    INetManager *work = TaskGetWorkCurrent(INetManager);
    work->state(work);
}

void INetManager_Destructor(Task *task)
{
    iNetManagerTask = NULL;
}

void INetManager_State_Init(INetManager *work)
{
    DWC_ProcessInet();

    if (DWC_CheckInet())
    {
        switch (DWC_GetInetStatus())
        {
            case DWC_CONNECTINET_STATE_CONNECTED:
                work->status = INETMANAGER_STATUS_CONNECTED;
                work->state  = INetManager_State_Connected;
                break;

            default:
                work->status = INETMANAGER_STATUS_DISCONNECTED;
                work->state  = INetManager_State_Disconnected;
                break;
        }
    }
}

void INetManager_State_Connected(INetManager *work)
{
    switch (DWC_GetInetStatus())
    {
        case DWC_CONNECTINET_STATE_DISCONNECTED:
        case DWC_CONNECTINET_STATE_ERROR:
        case DWC_CONNECTINET_STATE_FATAL_ERROR:
            work->status = INETMANAGER_STATUS_DISCONNECTED;

            if (work->onDisconnect != NULL)
                work->onDisconnect();

            work->state = INetManager_State_Disconnected;
            break;

        case DWC_CONNECTINET_STATE_NOT_INITIALIZED:
        case DWC_CONNECTINET_STATE_IDLE:
        case DWC_CONNECTINET_STATE_OPERATING:
        case DWC_CONNECTINET_STATE_OPERATED:
        case DWC_CONNECTINET_STATE_CONNECTED:
        case DWC_CONNECTINET_STATE_DISCONNECTING:
        default:
            break;
    }
}

void INetManager_State_Disconnected(INetManager *work)
{
    // Do Nothing.
}

MatchManager *GetMatchManagerWork(void)
{
    return TaskGetWork(matchManagerTask, MatchManager);
}

void InitMatchBuffers(MatchManager *work, size_t bufferSize, u32 maxPlayerCount)
{
    ReleaseMatchBuffers(work);

    // align buffer size to 0x4 bytes
    bufferSize = (bufferSize + 3) & ~3;

    if (bufferSize == 0)
        return;

    work->bufferSize = bufferSize;
    work->sendBuffer = memAlloc(bufferSize);

    for (u16 i = 0; i < maxPlayerCount; i++)
    {
        work->recieveBuffer[i]        = memAlloc(bufferSize);
        work->recieveBufferStorage[i] = memAlloc(bufferSize);
        work->recvBuffer[i]           = memAlloc(bufferSize);

        DWC_SetRecvBuffer(i, work->recvBuffer[i], bufferSize);
    }

    ClearDataTransferSendBuffer();
    ClearDataTransferAllBuffers();
}

void ReleaseMatchBuffers(MatchManager *work)
{
    if (work->bufferSize == 0)
        return;

    memFree(work->sendBuffer);
    work->sendBuffer = 0;

    for (u16 i = 0; i < MATCH_BUFFER_COUNT; i++)
    {
        if (work->recieveBuffer[i] != NULL)
        {
            memFree(work->recieveBuffer[i]);
            memFree(work->recieveBufferStorage[i]);
            memFree(work->recvBuffer[i]);

            work->recieveBuffer[i]        = NULL;
            work->recieveBufferStorage[i] = NULL;
            work->recvBuffer[i]           = NULL;
        }
    }

    work->bufferSize = 0;
}

void MatchManager_Main(void)
{
    int errorCode;
    MatchManager *work = TaskGetWork(matchManagerTask, MatchManager);

    DWC_ProcessFriendsMatch();

    if (MatchManager_State_Error != work->state && DWC_GetLastError(&errorCode) != DWC_ERROR_NONE)
    {
        work->status = MATCHMANAGER_STATUS_ERROR;
        work->state  = MatchManager_State_Error;

        void (*onError)(DWCError error) = work->onError;
        work->onError                   = NULL;
        if (onError)
            onError(DWC_ERROR_NONE);
    }
    else
    {
        work->state(work);
    }
}

void MatchManager_Destructor(Task *task)
{
    MatchManager *work = TaskGetWork(matchManagerTask, MatchManager);
    ReleaseMatchBuffers(work);

    matchManagerTask = NULL;
}

void MatchLoginCallback(DWCError error, int profileID, void *param)
{
    MatchManager *work = (MatchManager *)param;

    if (error == DWC_ERROR_NONE)
    {
        work->state = MatchManager_State_LoggedIn;
    }
    else
    {
        work->status = MATCHMANAGER_STATUS_ERROR;
        work->state  = MatchManager_State_Error;
    }
}

void MatchBuddyFriendCallback(int index, void *param)
{
    MatchManager *work = (MatchManager *)param;

    work->serverChanged = TRUE;
}

void MatchServerUpdateCallback(DWCError error, BOOL isChanged, void *param)
{
    MatchManager *work = (MatchManager *)param;

    if (error == DWC_ERROR_NONE)
    {
        if (isChanged)
            work->serverChanged = TRUE;

        work->status = MATCHMANAGER_STATUS_SERVER_UPDATED;
        work->state  = MatchManager_State_SeverUpdated;
    }
    else
    {
        work->status = MATCHMANAGER_STATUS_ERROR;
        work->state  = MatchManager_State_Error;
    }
}

void MatchFriendStatusCallback(int index, u8 status, const char *statusString, void *param)
{
    MatchManager *work = (MatchManager *)param;

    if (work->onFriendStatusChange != NULL)
        work->onFriendStatusChange(index, status, statusString, work->onFriendStatusChangeParam);
}

void MatchDeleteFriendCallback(int deletedIndex, int srcIndex, void *param)
{
    MatchManager *work = (MatchManager *)param;

    work->serverChanged = TRUE;

    if (work->onFriendDeleted != NULL)
        work->onFriendDeleted(deletedIndex, srcIndex, work->onFriendDeletedParam);
}

void MatchManager_State_Idle(MatchManager *work)
{
    // Do Nothing.
}

void MatchManager_State_LoggedIn(MatchManager *work)
{
    DWC_SetBuddyFriendCallback(MatchBuddyFriendCallback, work);

    if (DWC_UpdateServersAsync(NULL, MatchServerUpdateCallback, work, MatchFriendStatusCallback, work, MatchDeleteFriendCallback, work))
    {
        work->state = MatchManager_State_ServerUpdate;
    }
    else
    {
        work->status = MATCHMANAGER_STATUS_ERROR;
        work->state  = MatchManager_State_Error;
    }
}

void MatchManager_State_ServerUpdate(MatchManager *work)
{
    // Do Nothing.
}

void MatchManager_State_SeverUpdated(MatchManager *work)
{
    // Do Nothing.
}

void MatchManager_State_Error(MatchManager *work)
{
    // Do Nothing.
}

void ConnectionManager_Main(void)
{
    ConnectionManager *work = TaskGetWorkCurrent(ConnectionManager);
    work->state(work);
}

void ConnectionManager_Destructor(Task *task)
{
    connectionManagerTask = NULL;
}

void ConnectionMatchedCallback(DWCError error, BOOL cancel, void *param)
{
    ConnectionManager *work = (ConnectionManager *)param;

    if (error == DWC_ERROR_NONE)
    {
        if (cancel)
        {
            work->status = CONNECTIONMANAGER_STATUS_CANCELLED;
            work->state  = ConnectionManager_State_ConnectionCancelled;
        }
        else
        {
            work->status = CONNECTIONMANAGER_STATUS_CONNECTED;
            work->state  = ConnectionManager_State_Connected;
        }
    }
    else
    {
        work->status = CONNECTIONMANAGER_STATUS_ERROR;
        work->state  = ConnectionManager_State_ConnectionError;
    }
}

void ConnectionClosedCallback(DWCError error, BOOL isLocal, BOOL isServer, u8 aid, int index, void *param)
{
    // Do nothing.
}

void PrepareMatchMakingConnection(u8 maxPlayerCount, u8 minPlayerCount)
{
    DWCMatchOptMinComplete option;
    MI_CpuClear8(&option, sizeof(option));

    if (minPlayerCount == maxPlayerCount)
    {
        option.valid = FALSE;
    }
    else
    {
        option.valid = TRUE;
    }

    option.minEntry = minPlayerCount;
    option.timeout  = CONNECTION_TIMEOUT_TIME;

    DWC_SetMatchingOption(DWC_MATCH_OPTION_MIN_COMPLETE, &option, sizeof(option));
}

void ConnectionManager_State_Connecting(ConnectionManager *work)
{
    // Do nothing.
}

void ConnectionManager_State_Connected(ConnectionManager *work)
{
    // Do nothing.
}

void ConnectionManager_State_ConnectionCancelled(ConnectionManager *work)
{
    // Do nothing.
}

void ConnectionManager_State_ConnectionError(ConnectionManager *work)
{
    // Do nothing.
}

DataTransferManager *GetDataTransferManagerWork(void)
{
    return TaskGetWork(dataTransferManagerTask, DataTransferManager);
}

void DataTransferManager_Main(void)
{
    DataTransferManager *work = TaskGetWorkCurrent(DataTransferManager);
    MatchManager *manager     = TaskGetWork(matchManagerTask, MatchManager);

    if (GetMatchManagerStatus() != MATCHMANAGER_STATUS_SERVER_UPDATED)
        return;

    u32 i;
    OSIntrMode enabled;
    u32 myAID;

    myAID   = DWC_GetMyAID();
    enabled = OS_DisableInterrupts();

    for (i = 0; i < roomMaxPlayerCount; i++)
    {
        if (i == myAID)
        {
            if (work->readyBufferSize && (work->bitmap & (1 << myAID)) != 0)
            {
                MI_CpuCopy32(manager->sendBuffer, manager->recieveBuffer[i], manager->bufferSize);
            }
        }
        else
        {
            MI_CpuCopy32(manager->recieveBufferStorage[i], manager->recieveBuffer[i], manager->bufferSize);
            manager->recieveBufferStorage[i]->header.unknown = 0;
        }
    }
    OS_RestoreInterrupts(enabled);

    if (work->readyBufferSize != 0)
    {
        u32 changedBitmap     = work->bitmap & (DWC_GetAIDBitmap() & ~(1 << DWC_GetMyAID()));
        size_t size           = work->readyBufferSize;
        work->readyBufferSize = 0;

        if (work->transferMode == DATATRANSFER_MODE_RELIABLE)
        {
            u32 changedBitmap2 = changedBitmap;

            while (TRUE)
            {
                for (i = 0; i < roomMaxPlayerCount; i++)
                {
                    if ((changedBitmap2 & (1 << i)) != 0)
                    {
                        if (DWC_IsSendableReliable(i) && DWC_SendReliable(i, manager->sendBuffer, size + sizeof(struct DataTransferBufferHeader)))
                        {
                            changedBitmap2 &= ~(1 << i);
                            DWC_SetRecvTimeoutTime(i, 0);
                        }
                    }
                    else if ((changedBitmap & (1 << i)) != 0 && DataTransferShouldSendBitmap(i))
                    {
                        DWC_SendReliable(i, manager->sendBuffer, sizeof(struct DataTransferBufferHeader));
                    }
                }
                changedBitmap2 &= DWC_GetAIDBitmap();

                if (!changedBitmap2)
                    break;

                OS_ClearIrqCheckFlag(OS_IE_V_BLANK);
                OS_WaitVBlankIntr();
                MatchManager_Main();
            }

            for (i = 0; i < roomMaxPlayerCount; i++)
            {
                DWC_SetRecvTimeoutTime(i, DATATRANSFER_TIMEOUT_TIME);
            }
        }
        else
        {
            DWC_SendUnreliableBitmap(changedBitmap, manager->sendBuffer, size + sizeof(struct DataTransferBufferHeader));
            work->readyBufferSize = 0;
        }
    }
}

void DataTransferManager_Destructor(Task *task)
{
    DataTransferManager *work = TaskGetWork(task, DataTransferManager);
    UNUSED(work);

    dataTransferManagerTask = NULL;
}

void DataTransferUserRecvCallback(u8 aid, u8 *buffer, int size)
{
    if (matchManagerTask == NULL)
        return;

    if (size <= sizeof(struct DataTransferBufferHeader))
        return;

    if (roomMaxPlayerCount <= aid)
        return;

    MatchManager *manager = TaskGetWork(matchManagerTask, MatchManager);

    DataTransferBuffer *newBuffer = (DataTransferBuffer *)buffer;
    DataTransferBuffer *oldBuffer = manager->recieveBufferStorage[aid];

    if (oldBuffer->header.unknown <= newBuffer->header.unknown)
        MI_CpuCopy8(newBuffer, oldBuffer, size);
}

void DataTransferUserRecvTimeoutCallback(u8 aid)
{
    DWC_CloseConnectionHard(aid);
}

BOOL DataTransferShouldSendBitmap(u8 frequency)
{
    return (RenderCore_GetDMARenderCount() & 0x3F) == 2 * frequency;
}

void NdCleanupCallback(void)
{
    NdManager *work = TaskGetWork(ndManagerTask, NdManager);
    work->status    = NDMANAGER_STATUS_IDLE;
}

NdManager *GetNdManagerWork(void)
{
    return TaskGetWork(ndManagerTask, NdManager);
}

LeaderboardsManager *GetLeaderboardsManagerWork(void)
{
    return TaskGetWork(leaderboardsManagerTask, LeaderboardsManager);
}

BOOL LoadLeaderboardsScore(LeaderboardsManager *work, u32 category, DWCRnkRegion region)
{
    if (DWC_RnkGetScoreAsync(work->getMode, category, region, &work->getParam) == DWC_RNK_SUCCESS)
    {
        work->status = LEADERBOARDSMANAGER_STATUS_LOADING_SCORES;
        work->state  = LeaderboardsManager_State_GetScoreSuccess;
        return TRUE;
    }
    else
    {
        work->status = LEADERBOARDSMANAGER_STATUS_ERROR;
        work->state  = LeaderboardsManager_State_Error;
        return FALSE;
    }
}

BOOL HandleRankError(DWCRnkError error)
{
    return error == DWC_RNK_SUCCESS;
}

BOOL LoadLeaderboardRowTotal(LeaderboardsManager *work)
{
    return HandleRankError(DWC_RnkResGetTotal(&work->rankTotal));
}

BOOL LoadLeaderboardRowCount(LeaderboardsManager *work)
{
    return HandleRankError(DWC_RnkResGetRowCount(&work->rowCount));
}

BOOL LoadLeaderboardRows(LeaderboardsManager *work)
{
    if (!LoadLeaderboardRowCount(work))
        return FALSE;

    s32 id = 0;
    if (work->rowCount > LEADERBOARDS_RANK_COUNT)
        work->rowCount = LEADERBOARDS_RANK_COUNT;

    for (; id < work->rowCount; id++)
    {
        if (!HandleRankError(DWC_RnkResGetRow(&work->rankDataList[id], id)))
        {
            return FALSE;
        }
    }

    return TRUE;
}

void LeaderboardsManager_Main(void)
{
    LeaderboardsManager *work = TaskGetWorkCurrent(LeaderboardsManager);
    work->state(work);
}

void LeaderboardsManager_Destructor(Task *task)
{
    LeaderboardsManager *work = TaskGetWork(task, LeaderboardsManager);
    UNUSED(work);

    leaderboardsManagerTask = NULL;
}

void LeaderboardsManager_State_Idle(LeaderboardsManager *work)
{
    // Do nothing.
}

void LeaderboardsManager_State_PutScoreSuccess(LeaderboardsManager *work)
{
    work->timer = LEADERBOARDS_TIMEOUT_TIME;

    work->state = LeaderboardsManager_State_ProcessRanks;
    work->state(work);
}

void LeaderboardsManager_State_ProcessRanks(LeaderboardsManager *work)
{
    switch (DWC_RnkProcess())
    {
        case DWC_RNK_SUCCESS:
            work->timer--;
            if (work->timer < 0)
            {
                switch (DWC_RnkCancelProcess())
                {
                    case DWC_RNK_SUCCESS:
                    case DWC_RNK_ERROR_CANCEL_NOTASK:
                        work->status = LEADERBOARDSMANAGER_STATUS_CANCELLED;
                        break;

                    default:
                        work->status = LEADERBOARDSMANAGER_STATUS_ERROR;
                        break;
                }

                work->state = LeaderboardsManager_State_Error;
            }
            break;

        case DWC_RNK_PROCESS_NOTASK:
            if (DWC_RnkGetState() == DWC_RNK_STATE_COMPLETED)
            {
                work->status = LEADERBOARDSMANAGER_STATUS_IDLE;
                work->state  = LeaderboardsManager_State_Idle;
            }
            else
            {
                work->status = LEADERBOARDSMANAGER_STATUS_ERROR;
                work->state  = LeaderboardsManager_State_Error;
            }
            break;

        case DWC_RNK_IN_ERROR:
            work->status = LEADERBOARDSMANAGER_STATUS_ERROR;
            work->state  = LeaderboardsManager_State_Error;
            break;
    }
}

void LeaderboardsManager_State_GetScoreSuccess(LeaderboardsManager *work)
{
    work->timer = LEADERBOARDS_TIMEOUT_TIME;

    work->state = LeaderboardsManager_State_ProcessPutScore;
    work->state(work);
}

void LeaderboardsManager_State_ProcessPutScore(LeaderboardsManager *work)
{
    switch (DWC_RnkProcess())
    {
        case DWC_RNK_SUCCESS:
            work->timer--;
            if (work->timer < 0)
            {
                switch (DWC_RnkCancelProcess())
                {
                    case DWC_RNK_SUCCESS:
                    case DWC_RNK_ERROR_CANCEL_NOTASK:
                        work->status = LEADERBOARDSMANAGER_STATUS_CANCELLED;
                        break;

                    default:
                        work->status = LEADERBOARDSMANAGER_STATUS_ERROR;
                        break;
                }

                work->state = LeaderboardsManager_State_Error;
            }
            break;

        case DWC_RNK_PROCESS_NOTASK:
            if (DWC_RnkGetState() == DWC_RNK_STATE_COMPLETED)
            {
                switch (work->getMode)
                {
                    case DWC_RNK_GET_MODE_ORDER:
                        work->state = LeaderboardsManager_State_Leaderboards_Ordered;
                        break;

                    case DWC_RNK_GET_MODE_TOPLIST:
                        work->state = LeaderboardsManager_State_Leaderboards_TopList;
                        break;

                    case DWC_RNK_GET_MODE_NEAR:
                        work->state = LeaderboardsManager_State_Leaderboards_Near;
                        break;

                    case DWC_RNK_GET_MODE_FRIENDS:
                        work->state = LeaderboardsManager_State_Leaderboards_Friends;
                        break;

                    default:
                        break;
                }

                work->state(work);
            }
            else
            {
                work->status = LEADERBOARDSMANAGER_STATUS_ERROR;
                work->state  = LeaderboardsManager_State_Error;
            }
            break;

        case DWC_RNK_IN_ERROR:
            work->status = LEADERBOARDSMANAGER_STATUS_ERROR;
            work->state  = LeaderboardsManager_State_Error;
            break;
    }
}

void LeaderboardsManager_State_Leaderboards_Ordered(LeaderboardsManager *work)
{
    if (LoadLeaderboardRowTotal(work) && HandleRankError(DWC_RnkResGetOrder(&work->rankOrder)))
    {
        if (work->rankOrder == -1)
            work->rankOrder = DWC_RNK_ORDER_ASC;

        work->status = LEADERBOARDSMANAGER_STATUS_IDLE;
        work->state  = LeaderboardsManager_State_Idle;
    }
    else
    {
        work->status = LEADERBOARDSMANAGER_STATUS_ERROR;
        work->state  = LeaderboardsManager_State_Error;
    }
}

void LeaderboardsManager_State_Leaderboards_TopList(LeaderboardsManager *work)
{
    if (LoadLeaderboardRowTotal(work) && LoadLeaderboardRows(work))
    {
        work->status = LEADERBOARDSMANAGER_STATUS_IDLE;
        work->state  = LeaderboardsManager_State_Idle;
    }
    else
    {
        work->status = LEADERBOARDSMANAGER_STATUS_ERROR;
        work->state  = LeaderboardsManager_State_Error;
    }
}

void LeaderboardsManager_State_Leaderboards_Near(LeaderboardsManager *work)
{
    if (LoadLeaderboardRowTotal(work) && LoadLeaderboardRows(work))
    {
        work->status = LEADERBOARDSMANAGER_STATUS_IDLE;
        work->state  = LeaderboardsManager_State_Idle;
    }
    else
    {
        work->status = LEADERBOARDSMANAGER_STATUS_ERROR;
        work->state  = LeaderboardsManager_State_Error;
    }
}

void LeaderboardsManager_State_Leaderboards_Friends(LeaderboardsManager *work)
{
    if (LoadLeaderboardRowTotal(work) && (work->rankTotal++, LoadLeaderboardRows(work)))
    {
        work->status = LEADERBOARDSMANAGER_STATUS_IDLE;
        work->state  = LeaderboardsManager_State_Idle;
    }
    else
    {
        work->status = LEADERBOARDSMANAGER_STATUS_ERROR;
        work->state  = LeaderboardsManager_State_Error;
    }
}

void LeaderboardsManager_State_Error(LeaderboardsManager *work)
{
    // Do nothing
}
