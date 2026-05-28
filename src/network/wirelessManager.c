#include <game/network/wirelessManager.h>

// --------------------
// TYPES
// --------------------

typedef void (*WirelessManagerCallback)(void);

// --------------------
// CONSTANTS
// --------------------

#define NO_ROOM 0xFFFF

#define TGID_FLAG_UNKNOWN 0x8000

// --------------------
// ENUMS
// --------------------

enum WirelessManagerFlags_
{
    WIRELESSMANAGER_FLAGS_NONE = 0x00,

    WIRELESSMANAGER_FLAGS_1 = 1 << 0,
};
typedef s32 WirelessManagerFlags;

enum WirelessManagerError_
{
    WIRELESSMANAGER_ERROR_NONE,
    WIRELESSMANAGER_ERROR_CANT_MEASURE_CHANNEL,
    WIRELESSMANAGER_ERROR_CANT_CONNECT,
    WIRELESSMANAGER_ERROR_TIMEOUT,
};
typedef s32 WirelessManagerError;

// --------------------
// STRUCTS
// --------------------

typedef struct WirelessManager_SendPacket_
{
    u16 childBitmap;
    u16 flags;
} WirelessManager_SendPacket;

typedef struct WirelessManager_
{
    void (*state)(struct WirelessManager_ *work);
    WirelessManagerMode mode;
    WirelessManagerStatus status;
    WirelessManagerError error;
    u16 channel;
    u16 tgid;
    u16 childBitmap;
    u8 tgidSalt;
    u8 field_17;
    u16 field_18;
    u16 timer;
    s32 field_1C;
    size_t paramSize;
    s32 field_24;
    WirelessManagerRoomInfo availableRooms[32];
    u16 availableRoomCount;
    u16 currentRoom;
    WirelessManagerConnectableGuestInfo guestListWireless[15];
    u16 packetSize;
    u16 parentPacketSize;
    u16 childPacketSize;
    MBGameRegistry gameRegistry;
    WirelessManagerDownloadPlayFlags downloadPlayFlags;
    MBPChildInfo guestInfoListDownloadPlay[15];
    u16 guestUnkownListDownloadPlay[15];
} WirelessManager;

// --------------------
// VARIABLES
// --------------------

static u16 sTGIDSeed;
static u16 sUnknown;
static WirelessManagerCallback sWirelessUnkownCallback;
static Task *sTaskSingleton;
static Task *sWirelessUnkown;
static BOOL sInitialized;
static WirelessManagerFlags sManagerFlags;

static void *sReceiveBufferQueue[16];
static u8 sGameSSID[WM_SIZE_CHILD_SSID] ATTRIBUTE_ALIGN(32);
extern u16 sWirelessManagerUserGameInfo[56];
extern s32 sWirelessManagerSendBuffer[128];
extern s32 sWirelessManagerUnknownBuffer[144];

extern void *(*gWHAllocFunc)(u32 size);
extern void (*gWHFreeFunc)(void *mem);

extern void *(*gMBPAllocFunc)(size_t size);
extern void (*gMBPFreeFunc)(void *ptr);

// --------------------
// FUNCTION DECLS
// --------------------

NOT_DECOMPILED WMErrCode WMi_CheckInitialized(void);

static u16 WirelessManager__GenerateTGID(u8 salt);
static u32 WirelessManager__GetAvailableRoomCount_Internal(void);
static WirelessManagerRoomInfo *WirelessManager__GetAvailableRoom_Internal(u16 id);
static void WirelessManager__RemoveAvailableRoom_Internal(u16 id);
static void WirelessUnknown__Create(WirelessManagerCallback callback);
static void WirelessUnknown__Destroy(void);
static void WirelessUnknown__Main(void);
static void WirelessUnknown__Destructor(Task *task);
static void WirelessManager__InitBuffers(u16 size);
static void WirelessManager__Main1(void);
static void WirelessManager__Main3(void);
static void WirelessManager__Destructor(Task *task);
static BOOL WirelessManager__JudgeAcceptFunc(WMStartParentCallback *);
static void WirelessManager__ScanCallback_SearchRoomsWireless(WMBssDesc *bssDesc, void *arg);
static void WirelessManager__ChildScanCallback_20688DC(WMBssDesc *bssDesc, void *arg);
static void WirelessManager__SendDataCB_DownloadPlayGuest(BOOL result);
static void WirelessManager__ReceiverCB_2068948(u16 aid, u16 *data, u16 size);
static void WirelessManager__SendDataCB_WirelessGuest(BOOL result);
static void WirelessManager__ReceiverCB_2068970(u16 aid, u16 *data, u16 size);
static void WirelessManager__State_InitCreateRoom_DownloadPlay(WirelessManager *work);
static void WirelessManager__State_WaitIdleBeforeCreateRoom_DownloadPlay(WirelessManager *work);
static void WirelessManager__State_MeasureChannelForDownloadPlay(WirelessManager *work);
static void WirelessManager__State_2068A78(WirelessManager *work);
static void WirelessManager__State_2068ABC(WirelessManager *work);
static void WirelessManager__State_2068ADC(WirelessManager *work);
static void WirelessManager__State_2068B5C(WirelessManager *work);
static void WirelessManager__State_2068B7C(WirelessManager *work);
static void WirelessManager__State_2068BC4(WirelessManager *work);
static void WirelessManager__State_2068C74(WirelessManager *work);
static void WirelessManager__State_2068D94(WirelessManager *work);
static void WirelessManager__State_2068DD4(WirelessManager *work);
static void WirelessManager__State_2068E78(WirelessManager *work);
static void WirelessManager__State_2068FD8(WirelessManager *work);

static void WirelessManager__State_StartSearchRooms_Wireless(WirelessManager *work);
static void WirelessManager__State_WaitIdleBeforeSearchRooms_Wireless(WirelessManager *work);
static void WirelessManager__State_SearchingForRooms_Wireless(WirelessManager *work);
static void WirelessManager__State_ConnectedToRoom_Wireless(WirelessManager *work);
static void WirelessManager__State_20691D0(WirelessManager *work);
static void WirelessManager__State_20691F0(WirelessManager *work);
static void WirelessManager__State_2069278(WirelessManager *work);
static void WirelessManager__State_2069298(WirelessManager *work);
static void WirelessManager__State_20692D4(WirelessManager *work);
static void WirelessManager__State_20693BC(WirelessManager *work);
static void WirelessManager__State_2069498(WirelessManager *work);
static void WirelessManager__State_2069580(WirelessManager *work);
static void WirelessManager__State_206966C(WirelessManager *work);
static void WirelessManager__State_20696A0(WirelessManager *work);

static void WirelessManager__State_Error(WirelessManager *work);
static void WirelessManager__WirelessUnknownCallback(void);
static void WirelessManager__SetError(WirelessManagerError error);

static void WirelessManager__Main_CreateRoom_DownloadPlay(void);
static void WirelessManager__Destructor_DownloadPlay(Task *task);
static void WirelessManager__State_20698CC(WirelessManager *work);
static void WirelessManager__State_20698E8(WirelessManager *work);
static void WirelessManager__State_2069914(WirelessManager *work);
static void WirelessManager__State_LoadConnectedDownloadPlayGuests(WirelessManager *work);
static void WirelessManager__State_ConnectedToDownloadPlayGuests(WirelessManager *work);

// --------------------
// FUNCTIONS
// --------------------

void WirelessManager__InitAllocator(NetworkAllocMode whAllocMode, NetworkAllocMode mbpAllocMode)
{
    sTaskSingleton          = NULL;
    sWirelessUnkown         = NULL;
    sUnknown                = 0;
    sWirelessUnkownCallback = NULL;
    sManagerFlags           = WIRELESSMANAGER_FLAGS_NONE;

    switch (whAllocMode)
    {
        case NETWORK_ALLOC_MODE_HEAP_SYSTEM_HEAD:
            gWHAllocFunc = _AllocHeadHEAP_SYSTEM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_SYSTEM_TAIL:
            gWHAllocFunc = _AllocTailHEAP_SYSTEM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_USER_HEAD:
            gWHAllocFunc = _AllocHeadHEAP_USER;
            break;

        case NETWORK_ALLOC_MODE_HEAP_USER_TAIL:
            gWHAllocFunc = _AllocTailHEAP_USER;
            break;

        case NETWORK_ALLOC_MODE_HEAP_ITCM_HEAD:
            gWHAllocFunc = _AllocHeadHEAP_ITCM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_ITCM_TAIL:
            gWHAllocFunc = _AllocTailHEAP_ITCM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_DTCM_HEAD:
            gWHAllocFunc = _AllocHeadHEAP_DTCM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_DTCM_TAIL:
            gWHAllocFunc = _AllocTailHEAP_DTCM;
            break;
    }

    switch (whAllocMode)
    {
        case NETWORK_ALLOC_MODE_HEAP_SYSTEM_HEAD:
        case NETWORK_ALLOC_MODE_HEAP_SYSTEM_TAIL:
            gWHFreeFunc = _FreeHEAP_SYSTEM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_USER_HEAD:
        case NETWORK_ALLOC_MODE_HEAP_USER_TAIL:
            gWHFreeFunc = _FreeHEAP_USER;
            break;

        case NETWORK_ALLOC_MODE_HEAP_ITCM_HEAD:
        case NETWORK_ALLOC_MODE_HEAP_ITCM_TAIL:
            gWHFreeFunc = _FreeHEAP_ITCM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_DTCM_HEAD:
        case NETWORK_ALLOC_MODE_HEAP_DTCM_TAIL:
            gWHFreeFunc = _FreeHEAP_DTCM;
            break;
    }

    switch (mbpAllocMode)
    {
        case NETWORK_ALLOC_MODE_HEAP_SYSTEM_HEAD:
            gMBPAllocFunc = _AllocHeadHEAP_SYSTEM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_SYSTEM_TAIL:
            gMBPAllocFunc = _AllocTailHEAP_SYSTEM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_USER_HEAD:
            gMBPAllocFunc = _AllocHeadHEAP_USER;
            break;

        case NETWORK_ALLOC_MODE_HEAP_USER_TAIL:
            gMBPAllocFunc = _AllocTailHEAP_USER;
            break;

        case NETWORK_ALLOC_MODE_HEAP_ITCM_HEAD:
            gMBPAllocFunc = _AllocHeadHEAP_ITCM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_ITCM_TAIL:
            gMBPAllocFunc = _AllocTailHEAP_ITCM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_DTCM_HEAD:
            gMBPAllocFunc = _AllocHeadHEAP_DTCM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_DTCM_TAIL:
            gMBPAllocFunc = _AllocTailHEAP_DTCM;
            break;
    }

    switch (mbpAllocMode)
    {
        case NETWORK_ALLOC_MODE_HEAP_SYSTEM_HEAD:
        case NETWORK_ALLOC_MODE_HEAP_SYSTEM_TAIL:
            gMBPFreeFunc = _FreeHEAP_SYSTEM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_USER_HEAD:
        case NETWORK_ALLOC_MODE_HEAP_USER_TAIL:
            gMBPFreeFunc = _FreeHEAP_USER;
            break;

        case NETWORK_ALLOC_MODE_HEAP_ITCM_HEAD:
        case NETWORK_ALLOC_MODE_HEAP_ITCM_TAIL:
            gMBPFreeFunc = _FreeHEAP_ITCM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_DTCM_HEAD:
        case NETWORK_ALLOC_MODE_HEAP_DTCM_TAIL:
            gMBPFreeFunc = _FreeHEAP_DTCM;
            break;
    }
}

void WirelessManager__Create_CreateRoom_Wireless(u8 tgidSalt, u16 maxChildCount, u16 packetSize, void *param, u16 paramSize)
{
    Task *task     = TaskCreate(WirelessManager__Main1, WirelessManager__Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, 0,
                                TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(253), WirelessManager);
    sTaskSingleton = task;

    WirelessManager *work = TaskGetWork(task, WirelessManager);
    TaskInitWork16(work);

    work->state       = WirelessManager__State_InitCreateRoom_DownloadPlay;
    work->mode        = WIRELESSMANAGER_MODE_WIRELESS_GUEST;
    work->status      = WIRELESSMANAGER_STATUS_IDLE;
    work->tgidSalt    = tgidSalt;
    work->currentRoom = -1;
    work->packetSize  = packetSize;
    if (work->packetSize < sizeof(WirelessManager_SendPacket))
        work->packetSize = sizeof(WirelessManager_SendPacket);
    WH_SetMaxChildCount(maxChildCount);
    WH_SetPacketSize(sizeof(WirelessManager_SendPacket));
    WirelessManager__InitBuffers(sizeof(WirelessManager_SendPacket));
    WH_Initialize();
    WH_SetGgid(WIRELESSMANAGER_GGID_RUSH2);
    WH_SetJudgeAcceptFunc(WirelessManager__JudgeAcceptFunc);

    if (param != NULL && paramSize != 0)
    {
        work->paramSize = paramSize;
        MI_CpuCopy8(param, sWirelessManagerUserGameInfo, work->paramSize);
    }
}

#if defined(__MWERKS__)
#pragma push
#pragma optimization_level 2
#endif

void WirelessManager__Create1(WirelessManagerRoom_Wireless *room, s32 a2, u16 packetSize, void *param, u16 paramSize)
{
    Task *task     = TaskCreate(WirelessManager__Main3, WirelessManager__Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, 0,
                                TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(253), WirelessManager);
    sTaskSingleton = task;

    WirelessManager *work = TaskGetWork(task, WirelessManager);
    TaskInitWork16(work);

    work->state       = WirelessManager__State_2068DD4;
    work->mode        = WIRELESSMANAGER_MODE_WIRELESS_GUEST;
    work->status      = WIRELESSMANAGER_STATUS_2;
    work->channel     = room->channel;
    work->tgid        = room->tgid;
    work->tgidSalt    = 25;
    work->currentRoom = -1;
    work->packetSize  = packetSize;
    work->field_1C    = a2;

    if (work->packetSize < sizeof(WirelessManager_SendPacket))
        work->packetSize = sizeof(WirelessManager_SendPacket);

    for (u16 i = 0; i < room->bitmap; i++)
    {
        u32 bitmap = work->childBitmap;
        bitmap <<= 1;
        bitmap |= 1;
        work->childBitmap = bitmap;
    }

    WH_SetMaxChildCount(room->bitmap - 1);
    WH_SetPacketSize(work->packetSize);
    WirelessManager__InitBuffers(work->packetSize);
    WH_Initialize();
    WH_SetGgid(WIRELESSMANAGER_GGID_RUSH2);
    WH_SetJudgeAcceptFunc(WirelessManager__JudgeAcceptFunc);

    if (param != NULL && paramSize > 0)
    {
        work->paramSize = paramSize;
        MI_CpuCopy8(param, sWirelessManagerUserGameInfo, work->paramSize);
    }
}

#if defined(__MWERKS__)
#pragma pop
#endif

void WirelessManager__Create_SearchRooms_Wireless(u8 tgidSalt, u16 maxChildCount, u16 packetSize, void *param, u16 paramSize)
{
    Task *task     = TaskCreate(WirelessManager__Main1, WirelessManager__Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, 0,
                                TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(253), WirelessManager);
    sTaskSingleton = task;

    WirelessManager *work = TaskGetWork(task, WirelessManager);
    TaskInitWork16(work);

    work->state       = WirelessManager__State_StartSearchRooms_Wireless;
    work->mode        = WIRELESSMANAGER_MODE_WIRELESS_GUEST;
    work->status      = WIRELESSMANAGER_STATUS_4;
    work->tgidSalt    = tgidSalt;
    work->currentRoom = -1;
    work->packetSize  = packetSize;
    if (work->packetSize < sizeof(WirelessManager_SendPacket))
        work->packetSize = sizeof(WirelessManager_SendPacket);
    WH_SetMaxChildCount(maxChildCount);
    WH_SetPacketSize(sizeof(WirelessManager_SendPacket));
    WirelessManager__InitBuffers(sizeof(WirelessManager_SendPacket));
    WH_Initialize();
    WH_SetGgid(WIRELESSMANAGER_GGID_RUSH2);

    if (param != NULL && paramSize != 0)
        MI_CpuCopy8(param, sGameSSID, paramSize);
}

#if defined(__MWERKS__)
#pragma push
#pragma optimization_level 2
#endif

void WirelessManager__Create3(WirelessManagerRoom_DownloadPlay *room, u16 packetSize, void *param, u16 paramSize)
{
    Task *task     = TaskCreate(WirelessManager__Main3, WirelessManager__Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, 0,
                                TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(253), WirelessManager);
    sTaskSingleton = task;

    WirelessManager *work = TaskGetWork(task, WirelessManager);
    TaskInitWork16(work);

    work->state  = WirelessManager__State_2069498;
    work->mode   = WIRELESSMANAGER_MODE_WIRELESS_GUEST;
    work->status = WIRELESSMANAGER_STATUS_5;
    MI_CpuCopy8(room->bssID, work->availableRooms[0].bssDesc.bssid, sizeof(work->availableRooms[0].bssDesc.bssid));
    work->availableRooms[0].bssDesc.channel = room->channel;
    work->currentRoom                       = 0;
    work->tgidSalt                          = 25;
    work->packetSize                        = packetSize;

    if (work->packetSize < sizeof(WirelessManager_SendPacket))
        work->packetSize = sizeof(WirelessManager_SendPacket);

    for (u16 i = 0; i < room->bitmap; i++)
    {
        u32 bitmap = work->childBitmap;
        bitmap <<= 1;
        bitmap |= 1;
        work->childBitmap = bitmap;
    }

    WH_SetMaxChildCount(room->bitmap - 1);
    WH_SetPacketSize(work->packetSize);
    WirelessManager__InitBuffers(work->packetSize);
    WH_Initialize();
    WH_SetGgid(WIRELESSMANAGER_GGID_RUSH2);

    if (param != NULL && paramSize > 0)
        MI_CpuCopy8(param, sGameSSID, paramSize);
}

#if defined(__MWERKS__)
#pragma pop
#endif

void WirelessManager__Func_206789C(s32 a1)
{
    BOOL isLooping = TRUE;
    u32 errorRetryCount;

    switch (a1)
    {
        case 0:
            errorRetryCount = 0;
            WirelessUnknown__Destroy();
            if (WMi_CheckInitialized() == WM_ERRCODE_SUCCESS)
                WH_SetReceiver(NULL);

            do
            {
                switch (WH_GetSystemState())
                {
                    case WH_SYSSTATE_IDLE:
                        WH_End();
                        break;

                    case WH_SYSSTATE_STOP:
                        isLooping = FALSE;
                        break;

                    case WH_SYSSTATE_BUSY:
                        break;

                    case WH_SYSSTATE_ERROR:
                        errorRetryCount++;
                        if (errorRetryCount <= 3)
                        {
                            WH_Reset();
                            break;
                        }
                        // fallthrough

                    case WH_SYSSTATE_FATAL:
                        isLooping = FALSE;
                        break;

                    case WH_SYSSTATE_SCANNING:
                    case WH_SYSSTATE_CONNECTED:
                    case WH_SYSSTATE_DATASHARING:
                    case WH_SYSSTATE_KEYSHARING:
                    case WH_SYSSTATE_MEASURECHANNEL:
                    case WH_SYSSTATE_CONNECT_FAIL:
                    default:
                        WH_Finalize();
                        break;
                }
            } while (isLooping);

            WirelessManager__ClearSendBuffer();
            WirelessManager__ClearUnknownBuffer();
            break;

        case 1:
            if (WMi_CheckInitialized() == WM_ERRCODE_SUCCESS)
                WH_SetReceiver(NULL);
            break;
    }

    if (sTaskSingleton != NULL)
    {
        SetTaskFlags(sTaskSingleton, TASK_FLAG_NONE);
        DestroyTask(sTaskSingleton);
        sTaskSingleton = NULL;
    }
}

s32 WirelessManager__GetAvailableRoomCount(void)
{
    return WirelessManager__GetAvailableRoomCount_Internal();
}

WirelessManagerRoomInfo *WirelessManager__GetAvailableRoom(u16 id)
{
    return WirelessManager__GetAvailableRoom_Internal(id);
}

void WirelessManager__RemoveAvailableRoom(u16 id)
{
    WirelessManager__RemoveAvailableRoom_Internal(id);
}

void WirelessManager__SetCurrentRoom(u16 id)
{
    if (WirelessManager__GetStatus() == WIRELESSMANAGER_STATUS_4)
    {
        if (WH_GetSystemState() == WH_SYSSTATE_SCANNING)
            WH_EndScan();

        if (id < WirelessManager__GetAvailableRoomCount_Internal())
        {
            WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

            work->currentRoom = id;
        }
    }
}

WirelessManagerConnectableGuestInfo *WirelessManager__GetConnectedGuest_Wireless(s32 id)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    return &work->guestListWireless[id - 1];
}

void WirelessManager__GetCurrentRoomConnection_Wireless(WirelessManagerRoom_Wireless *room)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    room->channel = work->channel;
    room->bitmap  = WirelessManager__GetChildCount();
    room->tgid    = (work->tgid + 1) | TGID_FLAG_UNKNOWN;
}

void WirelessManager__GetCurrentRoomConnection_DownloadPlay(WirelessManagerRoom_DownloadPlay *room)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    room->channel = work->availableRooms[work->currentRoom].bssDesc.channel;
    room->bitmap  = WirelessManager__GetChildCount();
    MI_CpuCopy8(work->availableRooms[work->currentRoom].bssDesc.bssid, room->bssID, sizeof(room->bssID));
}

void WirelessManager__Func_2067AE8(BOOL enabled)
{
    if (enabled)
        sManagerFlags |= WIRELESSMANAGER_FLAGS_1;
    else
        sManagerFlags &= ~WIRELESSMANAGER_FLAGS_1;
}

void *WirelessManager__GetSendBuffer(void)
{
    return sWirelessManagerSendBuffer;
}

void *WirelessManager__GetReceiveBuffer(u32 id)
{
    return sReceiveBufferQueue[id];
}

void WirelessManager__ClearSendBuffer(void)
{
    MI_CpuClear32(sWirelessManagerSendBuffer, sizeof(sWirelessManagerSendBuffer));
}

void WirelessManager__ClearUnknownBuffer(void)
{
    MI_CpuClear32(sWirelessManagerUnknownBuffer, sizeof(sWirelessManagerUnknownBuffer));
}

#if defined(__MWERKS__)
#pragma push
#pragma optimization_level 2
#endif

void WirelessManager__Create4(WirelessManagerRoom_Wireless *a1, s32 a2, u16 parentPacketSize, u16 childPacketSize, void *param, u16 paramSize)
{
    Task *task     = TaskCreate(WirelessManager__Main3, WirelessManager__Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, 0,
                                TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(253), WirelessManager);
    sTaskSingleton = task;

    WirelessManager *work = TaskGetWork(task, WirelessManager);
    TaskInitWork16(work);

    work->state            = WirelessManager__State_2068DD4;
    work->mode             = WIRELESSMANAGER_MODE_DOWNLOAD_PLAY_GUEST;
    work->status           = WIRELESSMANAGER_STATUS_2;
    work->channel          = a1->channel;
    work->tgid             = a1->tgid;
    work->tgidSalt         = 25;
    work->currentRoom      = NO_ROOM;
    work->parentPacketSize = parentPacketSize;
    work->childPacketSize  = childPacketSize;
    work->field_1C         = a2;

    for (u16 i = 0; i < a1->bitmap; i++)
    {
        u32 bitmap = work->childBitmap;
        bitmap <<= 1;
        bitmap |= 1;
        work->childBitmap = bitmap;
    }

    WH_SetMaxChildCount(a1->bitmap - 1);
    WH_Initialize();
    WH_SetGgid(WIRELESSMANAGER_GGID_RUSH2);
    WH_SetJudgeAcceptFunc(WirelessManager__JudgeAcceptFunc);

    if (param != NULL && paramSize > 0)
    {
        work->paramSize = paramSize;
        MI_CpuCopy8(param, sWirelessManagerUserGameInfo, work->paramSize);
    }
}

#if defined(__MWERKS__)
#pragma pop
#endif

#if defined(__MWERKS__)
#pragma push
#pragma optimization_level 2
#endif

void WirelessManager__Create5(WirelessManagerRoom_DownloadPlay *a1, u16 parentPacketSize, u16 childPacketSize, void *param, u16 paramSize)
{
    Task *task     = TaskCreate(WirelessManager__Main3, WirelessManager__Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, 0,
                                TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(253), WirelessManager);
    sTaskSingleton = task;

    WirelessManager *work = TaskGetWork(task, WirelessManager);
    TaskInitWork16(work);

    work->state  = WirelessManager__State_2069498;
    work->mode   = WIRELESSMANAGER_MODE_DOWNLOAD_PLAY_GUEST;
    work->status = WIRELESSMANAGER_STATUS_4;
    MI_CpuCopy8(a1->bssID, work->availableRooms[0].bssDesc.bssid, sizeof(work->availableRooms[0].bssDesc.bssid));
    work->availableRooms[0].bssDesc.channel = a1->channel;
    work->currentRoom                       = 0;
    work->tgidSalt                          = 25;
    work->parentPacketSize                  = parentPacketSize;
    work->childPacketSize                   = childPacketSize;

    for (u16 i = 0; i < a1->bitmap; i++)
    {
        u32 bitmap = work->childBitmap;
        bitmap <<= 1;
        bitmap |= 1;
        work->childBitmap = bitmap;
    }

    WH_SetMaxChildCount(a1->bitmap - 1);
    WH_Initialize();
    WH_SetGgid(WIRELESSMANAGER_GGID_RUSH2);

    if (param != NULL && paramSize > 0)
        MI_CpuCopy8(param, sGameSSID, paramSize);
}

#if defined(__MWERKS__)
#pragma pop
#endif

void WirelessManager__Func_2067DF4(s32 a1)
{
    BOOL isLooping = TRUE;
    u32 errorRetryCount;

    switch (a1)
    {
        case 0:
            errorRetryCount = 0;
            WirelessUnknown__Destroy();
            WFS_End();
            if (WMi_CheckInitialized() == WM_ERRCODE_SUCCESS)
                WH_SetReceiver(NULL);

            do
            {
                switch (WH_GetSystemState())
                {
                    case WH_SYSSTATE_IDLE:
                        WH_End();
                        break;

                    case WH_SYSSTATE_STOP:
                        isLooping = FALSE;
                        break;

                    case WH_SYSSTATE_BUSY:
                        break;

                    case WH_SYSSTATE_ERROR:
                    case WH_SYSSTATE_FATAL:
                        errorRetryCount++;
                        if (errorRetryCount <= 3)
                        {
                            WH_Reset();
                            break;
                        }
                        else
                        {
                            isLooping = FALSE;
                        }
                        break;

                    case WH_SYSSTATE_SCANNING:
                    case WH_SYSSTATE_CONNECTED:
                    case WH_SYSSTATE_DATASHARING:
                    case WH_SYSSTATE_KEYSHARING:
                    case WH_SYSSTATE_MEASURECHANNEL:
                    case WH_SYSSTATE_CONNECT_FAIL:
                    default:
                        WH_Finalize();
                        break;
                }
            } while (isLooping);

            WirelessManager__ClearSendBuffer();
            WirelessManager__ClearUnknownBuffer();
            break;

        case 1:
            if (WMi_CheckInitialized() == WM_ERRCODE_SUCCESS)
                WH_SetReceiver(NULL);
            break;
    }

    if (sTaskSingleton != NULL)
    {
        SetTaskFlags(sTaskSingleton, TASK_FLAG_NONE);
        DestroyTask(sTaskSingleton);
        sTaskSingleton = NULL;
    }
}

void WirelessManager__GetCurrentRoomConnection_Wireless2(WirelessManagerRoom_Wireless *room)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    room->channel = work->channel;
    room->bitmap  = WirelessManager__GetChildCount();
    room->tgid    = (work->tgid + 1) | TGID_FLAG_UNKNOWN;
}

void WirelessManager__GetCurrentRoomConnection_DownloadPlay2(WirelessManagerRoom_DownloadPlay *room)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    room->channel = work->availableRooms[work->currentRoom].bssDesc.channel;
    room->bitmap  = WirelessManager__GetChildCount();
    MI_CpuCopy8(work->availableRooms[work->currentRoom].bssDesc.bssid, room->bssID, sizeof(room->bssID));
}

void WirelessManager__Create_CreateRoom_DownloadPlay(MBGameRegistry *gameRegistry, WirelessManagerDownloadPlayFlags flags)
{
    Task *task     = TaskCreate(WirelessManager__Main_CreateRoom_DownloadPlay, WirelessManager__Destructor_DownloadPlay,
                                TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, 0, TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(253), WirelessManager);
    sTaskSingleton = task;

    WirelessManager *work = TaskGetWork(task, WirelessManager);
    TaskInitWork16(work);

    work->state  = WirelessManager__State_InitCreateRoom_DownloadPlay;
    work->mode   = WIRELESSMANAGER_MODE_DOWNLOAD_PLAY_HOST;
    work->status = WIRELESSMANAGER_STATUS_IDLE;
    MI_CpuCopy16(gameRegistry, &work->gameRegistry, sizeof(work->gameRegistry));
    work->downloadPlayFlags = flags;
    work->gameRegistry.ggid = WIRELESSMANAGER_GGID_RUSH2;

    WH_Initialize();
    WH_SetGgid(WIRELESSMANAGER_GGID_RUSH2);
}

void WirelessManager__Func_2068060(void)
{
    BOOL isLooping = TRUE;
    u32 errorRetryCount;

    if (WH_GetSystemState() != WH_SYSSTATE_STOP)
    {
        errorRetryCount = 0;

        do
        {
            switch (WH_GetSystemState())
            {
                case WH_SYSSTATE_IDLE:
                    WH_End();
                    break;

                case WH_SYSSTATE_STOP:
                    isLooping = FALSE;
                    break;

                case WH_SYSSTATE_BUSY:
                    break;

                case WH_SYSSTATE_ERROR:
                case WH_SYSSTATE_FATAL:
                    errorRetryCount++;
                    if (errorRetryCount <= 3)
                    {
                        WH_Reset();
                        break;
                    }
                    else
                    {
                        isLooping = FALSE;
                    }
                    break;

                case WH_SYSSTATE_SCANNING:
                case WH_SYSSTATE_CONNECTED:
                case WH_SYSSTATE_DATASHARING:
                case WH_SYSSTATE_KEYSHARING:
                case WH_SYSSTATE_MEASURECHANNEL:
                case WH_SYSSTATE_CONNECT_FAIL:
                default:
                    WH_Finalize();
                    break;
            }
        } while (isLooping);
    }
    else
    {
        do
        {
            switch (MBP_GetState())
            {
                case MBP_STATE_STOP:
                case MBP_STATE_COMPLETE:
                    isLooping = FALSE;
                    break;

                case MBP_STATE_CANCEL:
                    break;

                default:
                    MBP_Cancel();
                    break;
            }
        } while (isLooping);
    }

    if (sTaskSingleton != NULL)
    {
        SetTaskFlags(sTaskSingleton, TASK_FLAG_NONE);
        DestroyTask(sTaskSingleton);
        sTaskSingleton = NULL;
    }
}

void WirelessManager__GetCurrentRoomConnection_Wireless3(WirelessManagerRoom_Wireless *room)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    room->channel = work->channel;
    room->bitmap  = WirelessManager__GetChildCount();
    room->tgid    = (work->tgid + 1) | TGID_FLAG_UNKNOWN;
}

MBPChildInfo *WirelessManager__GetConnectedGuest_DownloadPlay(s32 id)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    return &work->guestInfoListDownloadPlay[id - 1];
}

void WirelessManager__Func_20681D0(void)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    if (work->status == WIRELESSMANAGER_STATUS_2)
        work->field_17 = 1;
}

u32 WirelessManager__GetChildBitmap(void)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    return work->childBitmap;
}

u32 WirelessManager__GetChildCount(void)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    return WirelessManager__GetBitmapUserCount(work->childBitmap);
}

WirelessManagerMode WirelessManager__GetMode(void)
{
    if (sTaskSingleton == NULL)
        return WIRELESSMANAGER_MODE_INVALID;

    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    return work->mode;
}

s32 WirelessManager__GetStatus(void)
{
    if (sTaskSingleton == NULL)
        return WIRELESSMANAGER_STATUS_INACTIVE;

    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    return work->status;
}

u16 WirelessManager__GetBitmapUserCount(u16 bitmap)
{
    u16 i = 0;
    while (bitmap != 0)
    {
        if ((bitmap & 1) != 0)
            i++;

        bitmap >>= 1;
    }

    return i;
}

WMLinkLevel WirelessManager__GetLinkLevel(void)
{
    if (WMi_CheckInitialized())
        return WM_LINK_LEVEL_0;

    return WM_GetLinkLevel();
}

u16 WirelessManager__GenerateTGID(u8 salt)
{
    if (sInitialized == FALSE)
    {
        sInitialized = TRUE;

        RTCTime time;
        RTC_GetTime(&time);
        sTGIDSeed = ((time.second & 0x3F) << 0) | ((time.minute & 0xF) << 6);
    }
    else
    {
        sTGIDSeed = (sTGIDSeed + 1) & 0x3FF;
    }

    return ((salt & 0x1F) << 0) | ((sTGIDSeed & 0x3FF) << 5);
}

u32 WirelessManager__GetAvailableRoomCount_Internal(void)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    return work->availableRoomCount;
}

WirelessManagerRoomInfo *WirelessManager__GetAvailableRoom_Internal(u16 id)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    return &work->availableRooms[id];
}

NONMATCH_FUNC void WirelessManager__RemoveAvailableRoom_Internal(u16 id)
{
    // https://decomp.me/scratch/eKTAv -> 93.38%
#ifdef NON_MATCHING
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    u16 i;
    for (i = id + 1; work->availableRoomCount > i; i++)
    {
        MI_CpuCopy16(&work->availableRooms[i], &work->availableRooms[i - 1], sizeof(work->availableRooms[i]));
    }

    work->availableRoomCount--;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldr r1, =sTGIDSeed
	mov r5, r0
	ldr r0, [r1, #0x14]
	bl GetTaskWork_
	mov r6, r0
	add r4, r6, #0x1900
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	ldrh r1, [r4, #0x28]
	add r7, r6, #0x28
	mov r8, r0, lsr #0x10
	cmp r1, r0, lsr #16
	bls _02068418
	mov r5, #0xc8
	mov r9, r5
	mov r10, r5
_020683EC:
	sub r2, r8, #1
	mla r0, r8, r9, r7
	mla r1, r2, r10, r7
	mov r2, r5
	bl MIi_CpuCopy16
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	ldrh r1, [r4, #0x28]
	mov r8, r0, lsr #0x10
	cmp r1, r0, lsr #16
	bhi _020683EC
_02068418:
	add r0, r6, #0x1900
	ldrh r1, [r0, #0x28]
	sub r1, r1, #1
	strh r1, [r0, #0x28]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

void WirelessUnknown__Create(WirelessManagerCallback callback)
{
    sWirelessUnkown = TaskCreateNoWork(WirelessUnknown__Main, WirelessUnknown__Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, 0,
                                       TASK_PRIORITY_RENDER_LIST_START + 0x00, TASK_GROUP(253), "WirelessUnknown");

    sWirelessUnkownCallback = callback;
}

void WirelessUnknown__Destroy(void)
{
    if (sWirelessUnkown != NULL)
    {
        SetTaskFlags(sWirelessUnkown, TASK_FLAG_NONE);
        DestroyTask(sWirelessUnkown);
    }
}

#if defined(__MWERKS__)
#pragma optimize_for_size on
#endif
void WirelessUnknown__Main(void)
{
    if (WH_GetSystemState() == WH_SYSSTATE_DATASHARING)
    {
        u16 prevConnectBitmap = WH_GetBitmap();

        DC_StoreRange(sWirelessManagerSendBuffer, sizeof(sWirelessManagerSendBuffer));
        if ((sManagerFlags & WIRELESSMANAGER_FLAGS_1) != 0)
        {
            WH_StepDS(sWirelessManagerSendBuffer);
        }
        else
        {
            while (WH_StepDS(sWirelessManagerSendBuffer) == FALSE)
            {
                if (WH_GetErrorCode() != WM_ERRCODE_NO_KEYSET)
                {
                    if (sWirelessUnkownCallback)
                        sWirelessUnkownCallback();
                    sWirelessUnkownCallback = NULL;

                    WirelessManager__SetError(WIRELESSMANAGER_ERROR_CANT_CONNECT);
                    return;
                }
                OS_WaitVBlankIntr();
            }

            if (WH_GetCurrentAid() == 0 && WH_GetBitmap() < prevConnectBitmap)
            {
                if (sWirelessUnkownCallback)
                    sWirelessUnkownCallback();
                sWirelessUnkownCallback = NULL;

                WirelessManager__SetError(WIRELESSMANAGER_ERROR_CANT_CONNECT);
            }
        }

        for (u16 i = 0; i < gWHMaxChildCount + 1; i++)
        {
            const void *addr = WH_GetSharedDataAdr(i);
            if (addr)
                MI_CpuCopy8(addr, sReceiveBufferQueue[i], gWHPacketSize);
            else
                MI_CpuClear8(sReceiveBufferQueue[i], gWHPacketSize);
        }
    }
}

#if defined(__MWERKS__)
#pragma optimize_for_size off
#endif

void WirelessUnknown__Destructor(Task *task)
{
    sWirelessUnkown = NULL;
}

#if defined(__MWERKS__)
#pragma push
#pragma optimization_level 2
#endif

void WirelessManager__InitBuffers(u16 size)
{
    WirelessManager__ClearSendBuffer();
    WirelessManager__ClearUnknownBuffer();

    MI_CpuClear32(sReceiveBufferQueue, sizeof(sReceiveBufferQueue));

    u16 i;
    u16 step = (size + 3) & ~3;
    u8 *ptr  = (u8 *)sWirelessManagerUnknownBuffer;
    for (i = 0; i < 16; i++)
    {
        sReceiveBufferQueue[i] = ptr;
        ptr += step;
    }
}

#if defined(__MWERKS__)
#pragma pop
#endif

void WirelessManager__Main1(void)
{
    WirelessManager *work = TaskGetWorkCurrent(WirelessManager);

    WirelessManager_SendPacket *sendPacket = (WirelessManager_SendPacket *)WirelessManager__GetReceiveBuffer(0);
    work->childBitmap                      = sendPacket->childBitmap;

    if (work->timer == SECONDS_TO_FRAMES(4.0))
    {
        work->timer++;
        WirelessManager__SetError(WIRELESSMANAGER_ERROR_TIMEOUT);
    }
    else if (work->timer < SECONDS_TO_FRAMES(4.0))
    {
        work->timer++;
    }

    work->state(work);
}

void WirelessManager__Main3(void)
{
    WirelessManager *work = TaskGetWorkCurrent(WirelessManager);

    if (work->timer == SECONDS_TO_FRAMES(8.0))
    {
        work->timer++;
        WirelessManager__SetError(WIRELESSMANAGER_ERROR_TIMEOUT);
    }
    else if (work->timer < SECONDS_TO_FRAMES(8.0))
    {
        work->timer++;
    }

    work->state(work);
}

void WirelessManager__Destructor(Task *task)
{
    sTaskSingleton = NULL;
}

BOOL WirelessManager__JudgeAcceptFunc(WMStartParentCallback *param)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    WirelessManagerConnectableGuestInfo *guest = &work->guestListWireless[param->aid - 1];
    MI_CpuCopy8(param->macAddress, guest->macAddress, sizeof(guest->macAddress));
    MI_CpuCopy8(param->ssid, &guest->ssid, sizeof(guest->ssid));

    return TRUE;
}

void WirelessManager__ScanCallback_SearchRoomsWireless(WMBssDesc *pBssDesc, void *arg)
{
    WMstartScanCallback *cb = (WMstartScanCallback *)arg;

    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    WirelessManagerRoomInfo *entryList = work->availableRooms;
    if ((pBssDesc->gameInfo.attribute & WM_ATTR_FLAG_MB) == 0)
    {
        u32 count = work->availableRoomCount;
        if (count < ARRAY_COUNT(work->availableRooms) && (pBssDesc->gameInfo.tgid & 0x1F) == work->tgidSalt)
        {
            u16 i;
            if ((pBssDesc->gameInfo.tgid & TGID_FLAG_UNKNOWN) != 0)
            {
                for (i = 0; i < count; i++)
                {
                    if (memcmp(entryList[i].bssDesc.bssid, pBssDesc->bssid, sizeof(pBssDesc->bssid)) == 0)
                    {
                        WirelessManager__RemoveAvailableRoom_Internal(i);
                        return;
                    }
                }
            }
            else
            {
                for (i = 0; i < count; i++)
                {
                    if (memcmp(entryList[i].bssDesc.bssid, pBssDesc->bssid, sizeof(pBssDesc->bssid)) == 0)
                    {
                        MI_CpuCopy32(pBssDesc, &entryList[i].bssDesc, sizeof(entryList[i].bssDesc));
                        entryList[i].timer     = 0;
                        entryList[i].linkLevel = cb->linkLevel;
                        return;
                    }
                }

                MI_CpuCopy32(pBssDesc, &entryList[i].bssDesc, sizeof(entryList[i].bssDesc));
                entryList[i].timer     = 0;
                entryList[i].linkLevel = cb->linkLevel;
                work->availableRoomCount++;
            }
        }
    }
}

void WirelessManager__ChildScanCallback_20688DC(WMBssDesc *bssDesc, void *arg)
{
    WMstartScanCallback *cb = (WMstartScanCallback *)arg;
    WirelessManager *work   = TaskGetWork(sTaskSingleton, WirelessManager);

    if ((bssDesc->gameInfo.attribute & WM_ATTR_FLAG_MB) == 0 && work->availableRoomCount == 0)
    {
        MI_CpuCopy32(bssDesc, &work->availableRooms[0].bssDesc, sizeof(work->availableRooms[0].bssDesc));
        work->availableRooms[0].timer     = 0;
        work->availableRooms[0].linkLevel = cb->linkLevel;
        work->availableRoomCount          = 1;
    }
}

void WirelessManager__SendDataCB_DownloadPlayGuest(BOOL result)
{
    // Do nothing
}

void WirelessManager__ReceiverCB_2068948(u16 aid, u16 *data, u16 size)
{
    if (size == sizeof(WirelessManager_SendPacket))
        ((WirelessManager_SendPacket *)sWirelessManagerUnknownBuffer)->flags |= 1 << aid;
}

void WirelessManager__SendDataCB_WirelessGuest(BOOL result)
{
    // Do nothing
}

void WirelessManager__ReceiverCB_2068970(u16 aid, u16 *data, u16 size)
{
    if (size == sizeof(WirelessManager_SendPacket))
        *((WirelessManager_SendPacket *)sWirelessManagerUnknownBuffer) = *((WirelessManager_SendPacket *)data);
}

void WirelessManager__State_InitCreateRoom_DownloadPlay(WirelessManager *work)
{
    work->status = WIRELESSMANAGER_STATUS_IDLE;
    work->timer  = 0;

    work->state = WirelessManager__State_WaitIdleBeforeCreateRoom_DownloadPlay;
}

void WirelessManager__State_WaitIdleBeforeCreateRoom_DownloadPlay(WirelessManager *work)
{
    if (WH_GetSystemState() == WH_SYSSTATE_IDLE)
    {
        WH_SetUserGameInfo(sWirelessManagerUserGameInfo, sizeof(sWirelessManagerUserGameInfo));

        if (WH_StartMeasureChannel() == FALSE)
        {
            WirelessManager__SetError(WIRELESSMANAGER_ERROR_CANT_MEASURE_CHANNEL);
        }
        else
        {
            work->timer = 0;
            work->state = WirelessManager__State_MeasureChannelForDownloadPlay;
        }
    }
}

void WirelessManager__State_MeasureChannelForDownloadPlay(WirelessManager *work)
{
    if (WH_GetSystemState() == WH_SYSSTATE_MEASURECHANNEL)
    {
        // Yep
        work->channel = 0;
        if (work->channel == 0)
            work->channel = WH_GetMeasureChannel();

        if (work->mode == WIRELESSMANAGER_MODE_DOWNLOAD_PLAY_HOST)
        {
            work->state = WirelessManager__State_20698CC;
        }
        else
        {
            work->tgid = WirelessManager__GenerateTGID(work->tgidSalt);
            WH_ParentConnect(WH_CONNECTMODE_DS_PARENT, work->tgid, work->channel);
            work->state = WirelessManager__State_2068A78;
        }

        work->timer = 0;
    }
}

void WirelessManager__State_2068A78(WirelessManager *work)
{
    WHSysState state = WH_GetSystemState();
    UNUSED(state);

    if (WH_GetSystemState() == WH_SYSSTATE_DATASHARING)
    {
        WirelessUnknown__Create(WirelessManager__WirelessUnknownCallback);
        WirelessManager__Func_2067AE8(TRUE);

        work->timer = 0;
        work->state = WirelessManager__State_2068ABC;
    }
}

void WirelessManager__State_2068ABC(WirelessManager *work)
{
    work->status = WIRELESSMANAGER_STATUS_IDLE;
    work->timer  = 0;

    work->state = WirelessManager__State_2068ADC;
}

void WirelessManager__State_2068ADC(WirelessManager *work)
{
    WirelessManager_SendPacket *sendPacket = (WirelessManager_SendPacket *)WirelessManager__GetSendBuffer();
    sendPacket->childBitmap                = WH_GetBitmap();

    if (WirelessManager__GetChildCount() > 1)
    {
        work->status = WIRELESSMANAGER_STATUS_2;
        if (work->field_17)
        {
            sendPacket->flags |= 1;
            work->field_18 = 0;
            work->state    = WirelessManager__State_2068B5C;
            SetCurrentTaskMainEvent(WirelessManager__Main3);
        }
    }
    else
    {
        work->status = WIRELESSMANAGER_STATUS_IDLE;
    }

    work->field_17 = 0;
    work->timer    = 0;
}

void WirelessManager__State_2068B5C(WirelessManager *work)
{
    work->status = WIRELESSMANAGER_STATUS_2;
    work->timer  = 0;

    work->state = WirelessManager__State_2068B7C;
}

void WirelessManager__State_2068B7C(WirelessManager *work)
{
    if ((WH_GetBitmap() & ~1) == 0)
    {
        WirelessManager_SendPacket *sendPacket = (WirelessManager_SendPacket *)WirelessManager__GetSendBuffer();
        MI_CpuClear32(sendPacket, sizeof(*sendPacket));

        WirelessUnknown__Destroy();
        WH_Finalize();

        work->timer = 0;
        work->state = WirelessManager__State_2068BC4;
    }
}

void WirelessManager__State_2068BC4(WirelessManager *work)
{
    if (WH_GetSystemState() == WH_SYSSTATE_IDLE)
    {
        WH_SetUserGameInfo(sWirelessManagerUserGameInfo, sizeof(sWirelessManagerUserGameInfo));

        work->tgid |= TGID_FLAG_UNKNOWN;

        WHConnectMode connectMode;
        switch (work->mode)
        {
            case WIRELESSMANAGER_MODE_WIRELESS_GUEST:
                connectMode = WH_CONNECTMODE_DS_PARENT;
                WirelessUnknown__Create(WirelessManager__WirelessUnknownCallback);
                WH_SetPacketSize(work->packetSize);
                WirelessManager__InitBuffers(work->packetSize);
                break;

            case WIRELESSMANAGER_MODE_DOWNLOAD_PLAY_GUEST:
                connectMode = WH_CONNECTMODE_UNKNOWN_PARENT;
                WH_SetMaxParentChildSize(work->parentPacketSize, work->childPacketSize);
                break;
        }

        WH_ParentConnect(connectMode, work->tgid, work->channel);

        work->timer = 0;
        work->state = WirelessManager__State_2068C74;
    }
}

void WirelessManager__State_2068C74(WirelessManager *work)
{
    u16 bitmap;
    switch (work->mode)
    {
        case WIRELESSMANAGER_MODE_WIRELESS_GUEST:
            bitmap = WH_GetBitmap();
            break;

        case WIRELESSMANAGER_MODE_DOWNLOAD_PLAY_GUEST:
            bitmap = WFS_GetCurrentBitmap();
            break;
    }

    if (WirelessManager__GetBitmapUserCount(work->childBitmap) == WirelessManager__GetBitmapUserCount(bitmap))
    {
        WirelessManager_SendPacket *sendPacket;
        switch (work->mode)
        {
            case WIRELESSMANAGER_MODE_WIRELESS_GUEST:
                sendPacket              = (WirelessManager_SendPacket *)WirelessManager__GetSendBuffer();
                sendPacket->childBitmap = bitmap;
                sendPacket->flags |= 2;

                work->field_18 = 5;
                work->timer    = 0;
                work->state    = WirelessManager__State_206966C;
                break;

            case WIRELESSMANAGER_MODE_DOWNLOAD_PLAY_GUEST:
                sendPacket = (WirelessManager_SendPacket *)WirelessManager__GetSendBuffer();
                if (WFS_GetStatus() == WFS_STATE_READY)
                {
                    MI_CpuClear32(sWirelessManagerUnknownBuffer, sizeof(sWirelessManagerUnknownBuffer));
                    WH_SetReceiver(WirelessManager__ReceiverCB_2068948);

                    sendPacket->childBitmap = bitmap;
                    sendPacket->flags       = 1;

                    DC_StoreRange(sendPacket, sizeof(*sendPacket));
                    WH_SendData(sendPacket, sizeof(*sendPacket), WirelessManager__SendDataCB_DownloadPlayGuest);
                    WFS_EnableSync(bitmap);

                    work->timer = 0;
                    work->state = WirelessManager__State_2068D94;
                }
                break;
        }
    }
}

void WirelessManager__State_2068D94(WirelessManager *work)
{
    WirelessManager_SendPacket *sendPacket1 = (WirelessManager_SendPacket *)sWirelessManagerSendBuffer;
    WirelessManager_SendPacket *sendPacket2 = (WirelessManager_SendPacket *)sWirelessManagerUnknownBuffer;

    if (sendPacket1->childBitmap == (sendPacket2->flags | 1))
    {
        work->field_18 = 0;
        work->timer    = 0;
        work->state    = WirelessManager__State_206966C;
    }
}

void WirelessManager__State_2068DD4(WirelessManager *work)
{
    if (WH_GetSystemState() == WH_SYSSTATE_IDLE)
    {
        WH_SetUserGameInfo(sWirelessManagerUserGameInfo, sizeof(sWirelessManagerUserGameInfo));

        WHConnectMode connectMode;
        switch (work->mode)
        {
            case WIRELESSMANAGER_MODE_WIRELESS_GUEST:
                connectMode = WH_CONNECTMODE_DS_PARENT;
                WirelessUnknown__Create(WirelessManager__WirelessUnknownCallback);
                WH_SetPacketSize(work->packetSize);
                WirelessManager__InitBuffers(work->packetSize);
                break;

            case WIRELESSMANAGER_MODE_DOWNLOAD_PLAY_GUEST:
                connectMode = WH_CONNECTMODE_UNKNOWN_PARENT;
                WH_SetMaxParentChildSize(work->parentPacketSize, work->childPacketSize);
                break;
        }

        WH_ParentConnect(connectMode, work->tgid, work->channel);

        work->timer = 0;
        work->state = WirelessManager__State_2068E78;
    }
}

void WirelessManager__State_2068E78(WirelessManager *work)
{
    BOOL flag = FALSE;

    u16 bitmap;
    switch (work->mode)
    {
        case WIRELESSMANAGER_MODE_WIRELESS_GUEST:
            bitmap = WH_GetBitmap();
            break;

        case WIRELESSMANAGER_MODE_DOWNLOAD_PLAY_GUEST:
            bitmap = WFS_GetCurrentBitmap();
            break;
    }

    if ((work->field_1C & 1) != 0)
    {
        if (WirelessManager__GetBitmapUserCount(bitmap) >= 2 && work->timer >= (SECONDS_TO_FRAMES(8.0) - 1))
            flag = TRUE;
    }

    if (WirelessManager__GetBitmapUserCount(work->childBitmap) == WirelessManager__GetBitmapUserCount(bitmap))
        flag = TRUE;

    if (flag)
    {
        work->childBitmap = bitmap;

        WirelessManager_SendPacket *sendPacket;
        switch (work->mode)
        {
            case WIRELESSMANAGER_MODE_WIRELESS_GUEST:
                sendPacket              = (WirelessManager_SendPacket *)WirelessManager__GetSendBuffer();
                sendPacket->childBitmap = bitmap;
                sendPacket->flags |= 2;

                work->field_18 = 5;
                work->timer    = 0;
                work->state    = WirelessManager__State_206966C;
                break;

            case WIRELESSMANAGER_MODE_DOWNLOAD_PLAY_GUEST:
                sendPacket = (WirelessManager_SendPacket *)WirelessManager__GetSendBuffer();
                if (WFS_GetStatus() == WFS_STATE_READY)
                {
                    MI_CpuClear32(sWirelessManagerUnknownBuffer, sizeof(sWirelessManagerUnknownBuffer));
                    WH_SetReceiver(WirelessManager__ReceiverCB_2068948);

                    sendPacket->childBitmap = bitmap;
                    sendPacket->flags |= 1;

                    DC_StoreRange(sendPacket, sizeof(*sendPacket));
                    WH_SendData(sendPacket, sizeof(*sendPacket), WirelessManager__SendDataCB_DownloadPlayGuest);
                    WFS_EnableSync(bitmap);

                    work->timer = 0;
                    work->state = WirelessManager__State_2068FD8;
                }
                break;
        }
    }
}

void WirelessManager__State_2068FD8(WirelessManager *work)
{
    WirelessManager_SendPacket *sendPacket1 = (WirelessManager_SendPacket *)sWirelessManagerSendBuffer;
    WirelessManager_SendPacket *sendPacket2 = (WirelessManager_SendPacket *)sWirelessManagerUnknownBuffer;

    BOOL condition = FALSE;
    if (sendPacket1->childBitmap == (sendPacket2->flags | 1))
        condition = TRUE;

    if (condition)
    {
        work->field_18 = 0;
        work->timer    = 0;
        work->state    = WirelessManager__State_206966C;
    }
}

void WirelessManager__State_StartSearchRooms_Wireless(WirelessManager *work)
{
    work->status      = WIRELESSMANAGER_STATUS_4;
    work->currentRoom = NO_ROOM;
    work->timer       = 0;
    work->state       = WirelessManager__State_WaitIdleBeforeSearchRooms_Wireless;
}

void WirelessManager__State_WaitIdleBeforeSearchRooms_Wireless(WirelessManager *work)
{
    if (WH_GetSystemState() == WH_SYSSTATE_IDLE)
    {
        u8 macAddr[6] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };

        WH_SetSsid(sGameSSID, sizeof(sGameSSID));
        WH_StartScan(WirelessManager__ScanCallback_SearchRoomsWireless, macAddr, 0);

        work->timer = 0;
        work->state = WirelessManager__State_SearchingForRooms_Wireless;
    }
}

void WirelessManager__State_SearchingForRooms_Wireless(WirelessManager *work)
{
    for (u16 i = 0; i < work->availableRoomCount; i++)
    {
        work->availableRooms[i].timer++;
    }

    if (WH_GetSystemState() == WH_SYSSTATE_IDLE)
    {
        if (work->currentRoom != NO_ROOM)
        {
            work->tgid = work->availableRooms[work->currentRoom].bssDesc.gameInfo.tgid;
            WH_ChildConnect(WH_CONNECTMODE_DS_CHILD, &work->availableRooms[work->currentRoom].bssDesc);
            work->state = WirelessManager__State_ConnectedToRoom_Wireless;
        }
    }

    work->timer = 0;
}

void WirelessManager__State_ConnectedToRoom_Wireless(WirelessManager *work)
{
    if (WH_GetSystemState() == WH_SYSSTATE_DATASHARING)
    {
        WirelessUnknown__Create(WirelessManager__WirelessUnknownCallback);
        WirelessManager__Func_2067AE8(TRUE);

        work->timer = 0;
        work->state = WirelessManager__State_20691D0;
    }
}

void WirelessManager__State_20691D0(WirelessManager *work)
{
    work->status = WIRELESSMANAGER_STATUS_5;
    work->timer  = 0;

    work->state = WirelessManager__State_20691F0;
}

void WirelessManager__State_20691F0(WirelessManager *work)
{
    switch (WH_GetSystemState())
    {
        case WH_SYSSTATE_CONNECT_FAIL:
        case WH_SYSSTATE_ERROR:
        case WH_SYSSTATE_FATAL:
            WirelessManager__SetError(WIRELESSMANAGER_ERROR_CANT_CONNECT);
            break;

        case WH_SYSSTATE_DATASHARING:
            WirelessManager_SendPacket *sendPacket = (WirelessManager_SendPacket *)WirelessManager__GetReceiveBuffer(0);
            if ((sendPacket->flags & 1) != 0)
            {
                SetCurrentTaskMainEvent(WirelessManager__Main3);
                work->state = WirelessManager__State_2069278;
            }
            work->timer = 0;
            break;
    }
}

void WirelessManager__State_2069278(WirelessManager *work)
{
    work->status = WIRELESSMANAGER_STATUS_5;
    work->timer  = 0;

    work->state = WirelessManager__State_2069298;
}

void WirelessManager__State_2069298(WirelessManager *work)
{
    WirelessManager_SendPacket *sendBuffer = (WirelessManager_SendPacket *)WirelessManager__GetSendBuffer();
    MI_CpuClear32(sendBuffer, sizeof(*sendBuffer));

    WirelessUnknown__Destroy();
    WH_Finalize();

    work->timer = 0;
    work->state = WirelessManager__State_20692D4;
}

void WirelessManager__State_20692D4(WirelessManager *work)
{
    if (WH_GetSystemState() == WH_SYSSTATE_IDLE)
    {
        work->timer = 0;

        if (work->field_18 >= 10)
        {
            WirelessManagerRoomInfo *entry = &work->availableRooms[work->currentRoom];

            WHConnectMode connectMode;
            switch (work->mode)
            {
                case WIRELESSMANAGER_MODE_WIRELESS_GUEST:
                    connectMode = WH_CONNECTMODE_DS_CHILD;
                    WH_SetPacketSize(work->packetSize);
                    WirelessManager__InitBuffers(work->packetSize);
                    WirelessUnknown__Create(WirelessManager__WirelessUnknownCallback);
                    break;

                case WIRELESSMANAGER_MODE_DOWNLOAD_PLAY_GUEST:
                    connectMode = WH_CONNECTMODE_UNKNOWN_CHILD;
                    WH_SetMaxParentChildSize(work->parentPacketSize, work->childPacketSize);
                    MI_CpuClear32(sWirelessManagerUnknownBuffer, sizeof(sWirelessManagerUnknownBuffer));
                    WH_SetReceiver(WirelessManager__ReceiverCB_2068970);
                    break;
            }

            WH_ChildConnectAuto(WirelessManager__ChildScanCallback_20688DC, connectMode, entry->bssDesc.bssid, entry->bssDesc.channel);
            work->state = WirelessManager__State_20693BC;
        }
        else
        {
            work->field_18++;
        }
    }
}

void WirelessManager__State_20693BC(WirelessManager *work)
{
    WirelessManager_SendPacket *sendPacket;

    switch (WH_GetSystemState())
    {
        case WH_SYSSTATE_CONNECT_FAIL:
        case WH_SYSSTATE_ERROR:
        case WH_SYSSTATE_FATAL:
            WirelessManager__SetError(WIRELESSMANAGER_ERROR_CANT_CONNECT);
            break;

        case WH_SYSSTATE_DATASHARING:
            sendPacket = (WirelessManager_SendPacket *)WirelessManager__GetReceiveBuffer(0);
            if ((sendPacket->flags & 2) != 0)
            {
                work->field_18 = 4;
                work->timer    = 0;
                work->state    = WirelessManager__State_206966C;
            }
            break;

        case WH_SYSSTATE_CONNECTED:
            sendPacket = (WirelessManager_SendPacket *)sWirelessManagerUnknownBuffer;
            if (WFS_GetStatus() == WFS_STATE_READY && (sendPacket->flags & 1) != 0)
            {
                WH_SendData(sendPacket, sizeof(*sendPacket), WirelessManager__SendDataCB_WirelessGuest);
                WH_SetReceiver(0);
                work->field_18 = 4;
                work->timer    = 0;
                work->state    = WirelessManager__State_206966C;
            }
            break;
    }
}

void WirelessManager__State_2069498(WirelessManager *work)
{
    if (WH_GetSystemState() == WH_SYSSTATE_IDLE)
    {
        work->timer = 0;

        if (work->field_18 >= 10)
        {
            WirelessManagerRoomInfo *entry = &work->availableRooms[work->currentRoom];

            WHConnectMode connectMode;
            switch (work->mode)
            {
                case WIRELESSMANAGER_MODE_WIRELESS_GUEST:
                    connectMode = WH_CONNECTMODE_DS_CHILD;
                    WirelessUnknown__Create(WirelessManager__WirelessUnknownCallback);
                    WH_SetPacketSize(work->packetSize);
                    WirelessManager__InitBuffers(work->packetSize);
                    break;

                case WIRELESSMANAGER_MODE_DOWNLOAD_PLAY_GUEST:
                    connectMode = WH_CONNECTMODE_UNKNOWN_CHILD;
                    WH_SetMaxParentChildSize(work->parentPacketSize, work->childPacketSize);
                    MI_CpuClear32(sWirelessManagerUnknownBuffer, sizeof(sWirelessManagerUnknownBuffer));
                    WH_SetReceiver(WirelessManager__ReceiverCB_2068970);
                    break;
            }

            WH_ChildConnectAuto(WirelessManager__ChildScanCallback_20688DC, connectMode, entry->bssDesc.bssid, entry->bssDesc.channel);
            work->state = WirelessManager__State_2069580;
        }
        else
        {
            work->field_18++;
        }
    }
}

void WirelessManager__State_2069580(WirelessManager *work)
{
    WirelessManager_SendPacket *sendPacket;

    switch (WH_GetSystemState())
    {
        case WH_SYSSTATE_CONNECT_FAIL:
        case WH_SYSSTATE_ERROR:
        case WH_SYSSTATE_FATAL:
            WirelessManager__SetError(WIRELESSMANAGER_ERROR_CANT_CONNECT);
            break;

        case WH_SYSSTATE_DATASHARING:
            sendPacket = (WirelessManager_SendPacket *)WirelessManager__GetReceiveBuffer(0);
            if ((sendPacket->flags & 2) != 0)
            {
                work->childBitmap = sendPacket->childBitmap;
                work->field_18    = 4;
                work->timer       = 0;
                work->state       = WirelessManager__State_206966C;
            }
            break;

        case WH_SYSSTATE_CONNECTED:
            sendPacket = (WirelessManager_SendPacket *)sWirelessManagerUnknownBuffer;
            if (WFS_GetStatus() == WFS_STATE_READY && (sendPacket->flags & 1) != 0)
            {
                WH_SendData(sendPacket, sizeof(*sendPacket), WirelessManager__SendDataCB_WirelessGuest);
                WH_SetReceiver(0);
                work->childBitmap = sendPacket->childBitmap;
                work->field_18    = 4;
                work->timer       = 0;
                work->state       = WirelessManager__State_206966C;
            }
            break;
    }
}

void WirelessManager__State_206966C(WirelessManager *work)
{
    WirelessManager__Func_2067AE8(FALSE);
    WirelessManager__InitBuffers(work->packetSize);

    work->timer = 0;
    work->state = WirelessManager__State_20696A0;
}

void WirelessManager__State_20696A0(WirelessManager *work)
{
    if (work->field_18 != 0)
        work->field_18--;
    else
        work->status = WIRELESSMANAGER_STATUS_MBP_COMPLETE;

    work->timer = 0;
}

void WirelessManager__State_Error(WirelessManager *work)
{
    BOOL isLooping;
    u32 errorRetryCount;

    if (work->status != WIRELESSMANAGER_STATUS_ERROR)
    {
        work->status = WIRELESSMANAGER_STATUS_ERROR;

        isLooping       = TRUE;
        errorRetryCount = 0;
        WirelessUnknown__Destroy();
        WFS_End();
        if (WMi_CheckInitialized() == WM_ERRCODE_SUCCESS)
            WH_SetReceiver(NULL);

        do
        {
            switch (WH_GetSystemState())
            {
                case WH_SYSSTATE_IDLE:
                    WH_End();
                    break;

                case WH_SYSSTATE_STOP:
                    isLooping = FALSE;
                    break;

                case WH_SYSSTATE_BUSY:
                    break;

                case WH_SYSSTATE_ERROR:
                    errorRetryCount++;
                    if (errorRetryCount <= 3)
                    {
                        WH_Reset();
                        break;
                    }
                    // fallthrough

                case WH_SYSSTATE_FATAL:
                    isLooping = FALSE;
                    break;

                case WH_SYSSTATE_SCANNING:
                case WH_SYSSTATE_CONNECTED:
                case WH_SYSSTATE_DATASHARING:
                case WH_SYSSTATE_KEYSHARING:
                case WH_SYSSTATE_MEASURECHANNEL:
                case WH_SYSSTATE_CONNECT_FAIL:
                default:
                    WH_Finalize();
                    break;
            }
        } while (isLooping);

        WirelessManager__ClearSendBuffer();
        WirelessManager__ClearUnknownBuffer();
    }
    work->timer = 0;
}

void WirelessManager__WirelessUnknownCallback(void)
{
    BOOL isLooping;
    u32 errorRetryCount;

    WirelessUnknown__Destroy();

    errorRetryCount = 0;
    isLooping       = TRUE;

    sWirelessUnkownCallback = NULL;

    do
    {
        switch (WH_GetSystemState())
        {
            case WH_SYSSTATE_IDLE:
                WH_End();
                break;

            case WH_SYSSTATE_STOP:
                isLooping = FALSE;
                break;

            case WH_SYSSTATE_BUSY:
                break;

            case WH_SYSSTATE_ERROR:
                errorRetryCount++;
                if (errorRetryCount <= 3)
                {
                    WH_Reset();
                    break;
                }
                // fallthrough

            case WH_SYSSTATE_FATAL:
                isLooping = FALSE;
                break;

            case WH_SYSSTATE_SCANNING:
            case WH_SYSSTATE_CONNECTED:
            case WH_SYSSTATE_DATASHARING:
            case WH_SYSSTATE_KEYSHARING:
            case WH_SYSSTATE_MEASURECHANNEL:
            case WH_SYSSTATE_CONNECT_FAIL:
            default:
                WH_Finalize();
                break;
        }
    } while (isLooping);

    WirelessManager__SetError(WIRELESSMANAGER_ERROR_CANT_CONNECT);
}

void WirelessManager__SetError(WirelessManagerError error)
{
    if (sTaskSingleton != NULL)
    {
        WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

        work->error = error;
        work->state = WirelessManager__State_Error;
    }
}

void WirelessManager__Main_CreateRoom_DownloadPlay(void)
{
    WirelessManager *work = TaskGetWorkCurrent(WirelessManager);

    if (work->timer == SECONDS_TO_FRAMES(4.0))
    {
        work->timer++;
        WirelessManager__SetError(WIRELESSMANAGER_ERROR_TIMEOUT);
    }
    else if (work->timer < SECONDS_TO_FRAMES(4.0))
    {
        work->timer++;
    }

    work->state(work);
    work->field_17 = 0;
}

void WirelessManager__Destructor_DownloadPlay(Task *task)
{
    sTaskSingleton = NULL;
}

void WirelessManager__State_20698CC(WirelessManager *work)
{
    WH_End();

    work->state = WirelessManager__State_20698E8;
}

void WirelessManager__State_20698E8(WirelessManager *work)
{
    if (WH_GetSystemState() == WH_SYSSTATE_STOP)
    {
        work->timer = 0;
        work->state = WirelessManager__State_2069914;
    }
}

void WirelessManager__State_2069914(WirelessManager *work)
{
    work->tgid = WirelessManager__GenerateTGID(24);

    MBP_Init(work->gameRegistry.ggid, work->tgid);
    MI_CpuClear16(&work->guestUnkownListDownloadPlay, sizeof(work->guestUnkownListDownloadPlay));

    work->state = WirelessManager__State_LoadConnectedDownloadPlayGuests;
    work->state(work);
}

void WirelessManager__State_LoadConnectedDownloadPlayGuests(WirelessManager *work)
{
    u16 prevBitmap = work->childBitmap;
    work->childBitmap =
        MBP_GetChildBmp(MBP_BMPTYPE_ENTRY) | MBP_GetChildBmp(MBP_BMPTYPE_DOWNLOADING) | MBP_GetChildBmp(MBP_BMPTYPE_BOOTABLE) | MBP_GetChildBmp(MBP_BMPTYPE_REBOOT) | 1;

    MI_CpuClear16(work->guestInfoListDownloadPlay, sizeof(work->guestInfoListDownloadPlay));
    for (u16 i = 1; i <= 15; i++)
    {
        const MBPChildInfo *info = MBP_GetChildInfo(i);
        if (info)
        {
            work->guestInfoListDownloadPlay[i - 1] = *info;
        }
        else
        {
            work->guestUnkownListDownloadPlay[i - 1] = 0;
        }
    }

    work->status = WIRELESSMANAGER_STATUS_IDLE;
    switch (MBP_GetState())
    {
        case MBP_STATE_IDLE:
            work->timer = 0;
            MBP_Start(&work->gameRegistry, work->channel);
            break;

        case MBP_STATE_ENTRY:
            if ((work->childBitmap & ~1) != 0)
            {
                work->status = WIRELESSMANAGER_STATUS_2;
                if (work->field_17)
                    MBP_StartDownloadAll();
            }
            work->field_18 = 0;
            work->timer    = 0;
            break;

        case MBP_STATE_DATASENDING:
            work->status = WIRELESSMANAGER_STATUS_3;
            if (work->childBitmap == 1)
            {
                work->timer  = SECONDS_TO_FRAMES(4.0);
                work->status = WIRELESSMANAGER_STATUS_ERROR;
                work->error  = WIRELESSMANAGER_ERROR_CANT_CONNECT;
            }
            else if ((work->downloadPlayFlags & WIRELESSMANAGER_DOWNLOADPLAY_FLAGS_NO_JOIN_AFTER_CONNECTED) != 0 && prevBitmap != work->childBitmap)
            {
                work->timer  = SECONDS_TO_FRAMES(4.0);
                work->status = WIRELESSMANAGER_STATUS_ERROR;
                work->error  = WIRELESSMANAGER_ERROR_CANT_CONNECT;
            }
            else
            {
                if (MBP_IsBootableAll())
                    MBP_StartRebootAll();
                work->timer = 0;
            }
            break;

        case MBP_STATE_REBOOTING:
            work->status = WIRELESSMANAGER_STATUS_3;
            work->timer  = 0;
            break;

        case MBP_STATE_COMPLETE:
            work->status = WIRELESSMANAGER_STATUS_MBP_COMPLETE;
            work->timer  = 0;
            work->state  = WirelessManager__State_ConnectedToDownloadPlayGuests;
            break;

        case MBP_STATE_ERROR:
            work->status = WIRELESSMANAGER_STATUS_ERROR;
            work->error  = WIRELESSMANAGER_ERROR_TIMEOUT;
            MBP_Cancel();
            break;
    }
}

void WirelessManager__State_ConnectedToDownloadPlayGuests(WirelessManager *work)
{
    work->timer = 0;
}