#include <game/network/wirelessManager.h>

// --------------------
// TYPES
// --------------------

typedef void (*WirelessManagerCallback)(void);

// --------------------
// ENUMS
// --------------------

enum WirelessManagerFlags_
{
    WIRELESSMANAGER_FLAGS_NONE = 0x00,

    WIRELESSMANAGER_FLAGS_1 = 1 << 0,
};
typedef s32 WirelessManagerFlags;

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
    s32 field_4;
    s32 status;
    s32 field_C;
    u16 channel;
    u16 tgid;
    u16 childBitmap;
    u8 field_16;
    u8 field_17;
    u16 field_18;
    u16 timer;
    s32 field_1C;
    size_t paramSize;
    s32 field_24;
    WirelessManager__Unknown entries[32];
    u16 entryCount;
    u16 field_192A;
    WirelessManager_Unknown2068724 unknownList[15];
    u16 field_1AEE;
    u16 field_1AF0;
    u16 field_1AF2;
    MBGameRegistry gameRegistry;
    s32 field_1B30;
    MBPChildInfo field_1B34[15];
    u16 field_1CF6[15];
} WirelessManager;

// --------------------
// VARIABLES
// --------------------

static u16 sTGIDSeed;
static u16 sUnknown;
static WirelessManagerCallback sTaskUnknown2068430Param;
static Task *sTaskSingleton;
static Task *sTaskUnknown2068430;
static BOOL sInitialized;
static WirelessManagerFlags sManagerFlags;

static void *sSendBufferQueue[16];
static u8 sGameSSID[WM_SIZE_CHILD_SSID] ATTRIBUTE_ALIGN(32);
extern u16 sWirelessManagerUserGameInfo[56];
extern s32 sWirelessManagerSendBuffer[128];
extern s32 sWirelessManagerUnknownBuffer[144];

NOT_DECOMPILED void *wfsi_task;

extern void *(*gMBPAllocFunc)(size_t size);
extern void (*gMBPFreeFunc)(void *ptr);

// --------------------
// FUNCTION DECLS
// --------------------

NOT_DECOMPILED WMErrCode WMi_CheckInitialized(void);

static u16 WirelessManager__GenerateTGID(u8 a1);
static u32 WirelessManager__GetEntryCount(void);
static WirelessManager__Unknown *WirelessManager__GetEntry(u16 id);
static void WirelessManager__RemoveEntry(u16 id);
static void Task__Unknown2068430__Create(WirelessManagerCallback callback);
static void WirelessManager__Func_2068484(void);
static void Task__Unknown2068430__Main(void);
static void Task__Unknown2068430__Destructor(Task *task);
static void WirelessManager__InitBuffers(u16 a1);
static void WirelessManager__Main1(void);
static void WirelessManager__Main3(void);
static void WirelessManager__Destructor(Task *task);
static BOOL WirelessManager__JudgeAcceptFunc(WMStartParentCallback *);
static void WirelessManager__Func_206877C(WMBssDesc *bssDesc, void *a2);
static void WirelessManager__Func_20688DC(WMBssDesc *bssDesc, void *a2);
static void WirelessManager__SendDataCB_2068944(BOOL result);
static void WirelessManager__ReceiverCB_2068948(u16 aid, u16 *data, u16 size);
static void WirelessManager__SendDataCB_206896C(BOOL result);
static void WirelessManager__ReceiverCB_2068970(u16 aid, u16 *data, u16 size);
static void WirelessManager__State_2068994(WirelessManager *work);
static void WirelessManager__State_20689B4(WirelessManager *work);
static void WirelessManager__State_2068A08(WirelessManager *work);
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
static void WirelessManager__State_2069024(WirelessManager *work);
static void WirelessManager__State_2069054(WirelessManager *work);
static void WirelessManager__State_20690E8(WirelessManager *work);
static void WirelessManager__State_2069190(WirelessManager *work);
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
static void WirelessManager__State_20696C4(WirelessManager *work);
static void WirelessManager__Func_2069794(void);
static void WirelessManager__Func_2069838(s32 a1);
static void Task__Unknown2067FA0__Main(void);
static void Task__Unknown2067FA0__Destructor(Task *task);
static void WirelessManager__State_20698CC(WirelessManager *work);
static void WirelessManager__State_20698E8(WirelessManager *work);
static void WirelessManager__State_2069914(WirelessManager *work);
static void WirelessManager__State_2069964(WirelessManager *work);
static void WirelessManager__State_2069B90(WirelessManager *work);

// --------------------
// FUNCTIONS
// --------------------

void WirelessManager__InitAllocator(NetworkAllocMode whAllocMode, NetworkAllocMode mbpAllocMode)
{
    sTaskSingleton           = NULL;
    sTaskUnknown2068430      = NULL;
    sUnknown                 = 0;
    sTaskUnknown2068430Param = NULL;
    sManagerFlags            = WIRELESSMANAGER_FLAGS_NONE;

    switch (whAllocMode)
    {
        case NETWORK_ALLOC_MODE_HEAP_SYSTEM_HEAD:
            whConfig_whAllocFunc = _AllocHeadHEAP_SYSTEM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_SYSTEM_TAIL:
            whConfig_whAllocFunc = _AllocTailHEAP_SYSTEM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_USER_HEAD:
            whConfig_whAllocFunc = _AllocHeadHEAP_USER;
            break;

        case NETWORK_ALLOC_MODE_HEAP_USER_TAIL:
            whConfig_whAllocFunc = _AllocTailHEAP_USER;
            break;

        case NETWORK_ALLOC_MODE_HEAP_ITCM_HEAD:
            whConfig_whAllocFunc = _AllocHeadHEAP_ITCM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_ITCM_TAIL:
            whConfig_whAllocFunc = _AllocTailHEAP_ITCM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_DTCM_HEAD:
            whConfig_whAllocFunc = _AllocHeadHEAP_DTCM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_DTCM_TAIL:
            whConfig_whAllocFunc = _AllocTailHEAP_DTCM;
            break;
    }

    switch (whAllocMode)
    {
        case NETWORK_ALLOC_MODE_HEAP_SYSTEM_HEAD:
        case NETWORK_ALLOC_MODE_HEAP_SYSTEM_TAIL:
            whConfig_whFreeFunc = _FreeHEAP_SYSTEM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_USER_HEAD:
        case NETWORK_ALLOC_MODE_HEAP_USER_TAIL:
            whConfig_whFreeFunc = _FreeHEAP_USER;
            break;

        case NETWORK_ALLOC_MODE_HEAP_ITCM_HEAD:
        case NETWORK_ALLOC_MODE_HEAP_ITCM_TAIL:
            whConfig_whFreeFunc = _FreeHEAP_ITCM;
            break;

        case NETWORK_ALLOC_MODE_HEAP_DTCM_HEAD:
        case NETWORK_ALLOC_MODE_HEAP_DTCM_TAIL:
            whConfig_whFreeFunc = _FreeHEAP_DTCM;
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

void WirelessManager__Create(u8 a1, u16 a2, u16 a3, void *param, u16 paramSize)
{
    Task *task     = TaskCreate(WirelessManager__Main1, WirelessManager__Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, 0,
                                TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(253), WirelessManager);
    sTaskSingleton = task;

    WirelessManager *work = TaskGetWork(task, WirelessManager);
    TaskInitWork16(work);

    work->state      = WirelessManager__State_2068994;
    work->field_4    = 1;
    work->status     = 1;
    work->field_16   = a1;
    work->field_192A = -1;
    work->field_1AEE = a3;
    if (work->field_1AEE < 4)
        work->field_1AEE = 4;
    WH_SetMaxChildCount(a2);
    WH_SetMinDataSize(4);
    WirelessManager__InitBuffers(4);
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

void WirelessManager__Create1(WirelessManager_Unknown2068160 *a1, s32 a2, u16 a3, void *param, u16 paramSize)
{
    Task *task     = TaskCreate(WirelessManager__Main3, WirelessManager__Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, 0,
                                TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(253), WirelessManager);
    sTaskSingleton = task;

    WirelessManager *work = TaskGetWork(task, WirelessManager);
    TaskInitWork16(work);

    work->state      = WirelessManager__State_2068DD4;
    work->field_4    = 1;
    work->status     = 2;
    work->channel    = a1->channel;
    work->tgid       = a1->tgid;
    work->field_16   = 25;
    work->field_192A = -1;
    work->field_1AEE = a3;
    work->field_1C   = a2;

    if (work->field_1AEE < 4)
        work->field_1AEE = 4;

    for (u16 i = 0; i < a1->bitmap; i++)
    {
        u32 bitmap = work->childBitmap;
        bitmap <<= 1;
        bitmap |= 1;
        work->childBitmap = bitmap;
    }

    WH_SetMaxChildCount(a1->bitmap - 1);
    WH_SetMinDataSize(work->field_1AEE);
    WirelessManager__InitBuffers(work->field_1AEE);
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

void WirelessManager__Create2(u8 a1, u16 a2, u16 a3, void *param, u16 paramSize)
{
    Task *task     = TaskCreate(WirelessManager__Main1, WirelessManager__Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, 0,
                                TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(253), WirelessManager);
    sTaskSingleton = task;

    WirelessManager *work = TaskGetWork(task, WirelessManager);
    TaskInitWork16(work);

    work->state      = WirelessManager__State_2069024;
    work->field_4    = 1;
    work->status     = 4;
    work->field_16   = a1;
    work->field_192A = -1;
    work->field_1AEE = a3;
    if (work->field_1AEE < 4)
        work->field_1AEE = 4;
    WH_SetMaxChildCount(a2);
    WH_SetMinDataSize(4);
    WirelessManager__InitBuffers(4);
    WH_Initialize();
    WH_SetGgid(WIRELESSMANAGER_GGID_RUSH2);

    if (param != NULL && paramSize != 0)
        MI_CpuCopy8(param, sGameSSID, paramSize);
}

#if defined(__MWERKS__)
#pragma push
#pragma optimization_level 2
#endif

void WirelessManager__Create3(WirelessManager_Unknown2067A88 *a1, u16 a3, void *param, u16 paramSize)
{
    Task *task     = TaskCreate(WirelessManager__Main3, WirelessManager__Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, 0,
                                TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(253), WirelessManager);
    sTaskSingleton = task;

    WirelessManager *work = TaskGetWork(task, WirelessManager);
    TaskInitWork16(work);

    work->state   = WirelessManager__State_2069498;
    work->field_4 = 1;
    work->status  = 5;
    MI_CpuCopy8(a1->bssID, work->entries[0].bssDesc.bssid, sizeof(work->entries[0].bssDesc.bssid));
    work->entries[0].bssDesc.channel = a1->channel;
    work->field_192A                 = 0;
    work->field_16                   = 25;
    work->field_1AEE                 = a3;

    if (work->field_1AEE < 4)
        work->field_1AEE = 4;

    for (u16 i = 0; i < a1->bitmap; i++)
    {
        u32 bitmap = work->childBitmap;
        bitmap <<= 1;
        bitmap |= 1;
        work->childBitmap = bitmap;
    }

    WH_SetMaxChildCount(a1->bitmap - 1);
    WH_SetMinDataSize(work->field_1AEE);
    WirelessManager__InitBuffers(work->field_1AEE);
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
    u32 loopCount;

    switch (a1)
    {
        case 0:
            loopCount = 0;
            WirelessManager__Func_2068484();
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
                        loopCount++;
                        if (loopCount <= 3)
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

s32 WirelessManager__GetEntryCount2(void)
{
    return WirelessManager__GetEntryCount();
}

WirelessManager__Unknown *WirelessManager__GetEntry2(u16 id)
{
    return WirelessManager__GetEntry(id);
}

void WirelessManager__RemoveEntry2(u16 id)
{
    WirelessManager__RemoveEntry(id);
}

void WirelessManager__Func_20679CC(u16 id)
{
    if (WirelessManager__GetStatus() == 4)
    {
        if (WH_GetSystemState() == WH_SYSSTATE_SCANNING)
            WH_EndScan();

        if (id < WirelessManager__GetEntryCount())
        {
            WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

            work->field_192A = id;
        }
    }
}

WirelessManager_Unknown2068724 *WirelessManager__Func_2067A18(s32 id)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    return &work->unknownList[id - 1];
}

void WirelessManager__Func_2067A48(WirelessManager_Unknown2068160 *unknown)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    unknown->channel = work->channel;
    unknown->bitmap  = WirelessManager__GetChildCount();
    unknown->tgid    = (work->tgid + 1) | 0x8000;
}

void WirelessManager__Func_2067A88(WirelessManager_Unknown2067A88 *unknown)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    unknown->channel = work->entries[work->field_192A].bssDesc.channel;
    unknown->bitmap  = WirelessManager__GetChildCount();
    MI_CpuCopy8(work->entries[work->field_192A].bssDesc.bssid, unknown->bssID, sizeof(unknown->bssID));
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
    return sSendBufferQueue[id];
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

void WirelessManager__Create4(WirelessManager_Unknown2068160 *a1, s32 a2, u16 a3, u16 a4, void *param, u16 paramSize)
{
    Task *task     = TaskCreate(WirelessManager__Main3, WirelessManager__Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, 0,
                                TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(253), WirelessManager);
    sTaskSingleton = task;

    WirelessManager *work = TaskGetWork(task, WirelessManager);
    TaskInitWork16(work);

    work->state      = WirelessManager__State_2068DD4;
    work->field_4    = 2;
    work->status     = 2;
    work->channel    = a1->channel;
    work->tgid       = a1->tgid;
    work->field_16   = 25;
    work->field_192A = 0xFFFF;
    work->field_1AF0 = a3;
    work->field_1AF2 = a4;
    work->field_1C   = a2;

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

void WirelessManager__Create5(WirelessManager_Unknown2067A88 *a1, u16 a2, u16 a3, void *param, u16 paramSize)
{
    Task *task     = TaskCreate(WirelessManager__Main3, WirelessManager__Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, 0,
                                TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(253), WirelessManager);
    sTaskSingleton = task;

    WirelessManager *work = TaskGetWork(task, WirelessManager);
    TaskInitWork16(work);

    work->state   = WirelessManager__State_2069498;
    work->field_4 = 2;
    work->status  = 4;
    MI_CpuCopy8(a1->bssID, work->entries[0].bssDesc.bssid, sizeof(work->entries[0].bssDesc.bssid));
    work->entries[0].bssDesc.channel = a1->channel;
    work->field_192A                 = 0;
    work->field_16                   = 25;
    work->field_1AF0                 = a2;
    work->field_1AF2                 = a3;

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
    u32 loopCount;

    switch (a1)
    {
        case 0:
            loopCount = 0;
            WirelessManager__Func_2068484();
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
                        loopCount++;
                        if (loopCount <= 3)
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

void WirelessManager__Func_2067F00(WirelessManager_Unknown2068160 *unknown)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    unknown->channel = work->channel;
    unknown->bitmap  = WirelessManager__GetChildCount();
    unknown->tgid    = (work->tgid + 1) | 0x8000;
}

void WirelessManager__Func_2067F40(WirelessManager_Unknown2067A88 *unknown)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    unknown->channel = work->entries[work->field_192A].bssDesc.channel;
    unknown->bitmap  = WirelessManager__GetChildCount();
    MI_CpuCopy8(work->entries[work->field_192A].bssDesc.bssid, unknown->bssID, sizeof(unknown->bssID));
}

void WirelessManager__Create6(MBGameRegistry *gameRegistry, s32 a2)
{
    Task *task     = TaskCreate(Task__Unknown2067FA0__Main, Task__Unknown2067FA0__Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, 0,
                                TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(253), WirelessManager);
    sTaskSingleton = task;

    WirelessManager *work = TaskGetWork(task, WirelessManager);
    TaskInitWork16(work);

    work->state   = WirelessManager__State_2068994;
    work->field_4 = 3;
    work->status  = 1;
    MI_CpuCopy16(gameRegistry, &work->gameRegistry, sizeof(work->gameRegistry));
    work->field_1B30        = a2;
    work->gameRegistry.ggid = WIRELESSMANAGER_GGID_RUSH2;

    WH_Initialize();
    WH_SetGgid(WIRELESSMANAGER_GGID_RUSH2);
}

void WirelessManager__Func_2068060(void)
{
    BOOL isLooping = TRUE;
    u32 loopCount;

    if (WH_GetSystemState() != WH_SYSSTATE_STOP)
    {
        loopCount = 0;

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
                    loopCount++;
                    if (loopCount <= 3)
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

void WirelessManager__Func_2068160(WirelessManager_Unknown2068160 *unknown)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    unknown->channel = work->channel;
    unknown->bitmap  = WirelessManager__GetChildCount();
    unknown->tgid    = (work->tgid + 1) | 0x8000;
}

MBPChildInfo *WirelessManager__GetChildInfo(s32 id)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    return &work->field_1B34[id - 1];
}

void WirelessManager__Func_20681D0(void)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    if (work->status == 2)
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

u32 WirelessManager__GetField4(void)
{
    if (sTaskSingleton == NULL)
        return 0;

    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    return work->field_4;
}

s32 WirelessManager__GetStatus(void)
{
    if (sTaskSingleton == NULL)
        return 0;

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

u16 WirelessManager__GenerateTGID(u8 a1)
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

    return ((a1 & 0x1F) << 0) | ((sTGIDSeed & 0x3FF) << 5);
}

u32 WirelessManager__GetEntryCount(void)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    return work->entryCount;
}

WirelessManager__Unknown *WirelessManager__GetEntry(u16 id)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    return &work->entries[id];
}

NONMATCH_FUNC void WirelessManager__RemoveEntry(u16 id)
{
    // https://decomp.me/scratch/eKTAv -> 93.38%
#ifdef NON_MATCHING
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    u16 i;
    for (i = id + 1; work->entryCount > i; i++)
    {
        MI_CpuCopy16(&work->entries[i], &work->entries[i - 1], sizeof(work->entries[i]));
    }

    work->entryCount--;
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

void Task__Unknown2068430__Create(WirelessManagerCallback callback)
{
    sTaskUnknown2068430 = TaskCreateNoWork(Task__Unknown2068430__Main, Task__Unknown2068430__Destructor, TASK_FLAG_DISABLE_EXTERNAL_DESTROY | TASK_FLAG_IGNORE_PAUSELEVEL, 0,
                                           TASK_PRIORITY_RENDER_LIST_START + 0x00, TASK_GROUP(253), "Unknown2068430");

    sTaskUnknown2068430Param = callback;
}

void WirelessManager__Func_2068484(void)
{
    if (sTaskUnknown2068430 != NULL)
    {
        SetTaskFlags(sTaskUnknown2068430, TASK_FLAG_NONE);
        DestroyTask(sTaskUnknown2068430);
    }
}

#if defined(__MWERKS__)
#pragma optimize_for_size on
#endif
void Task__Unknown2068430__Main(void)
{
    if (WH_GetSystemState() == WH_SYSSTATE_DATASHARING)
    {
        u16 prevConnectBitmap = WH_GetConnectBitmap();

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
                    if (sTaskUnknown2068430Param)
                        sTaskUnknown2068430Param();
                    sTaskUnknown2068430Param = NULL;

                    WirelessManager__Func_2069838(2);
                    return;
                }
                OS_WaitVBlankIntr();
            }

            if (WH_GetCurrentAid() == 0 && WH_GetConnectBitmap() < prevConnectBitmap)
            {
                if (sTaskUnknown2068430Param)
                    sTaskUnknown2068430Param();
                sTaskUnknown2068430Param = NULL;

                WirelessManager__Func_2069838(2);
            }
        }

        for (u16 i = 0; i < whConfig_wmMaxChildCount + 1; i++)
        {
            const void *addr = WH_GetSharedDataAdr(i);
            if (addr)
                MI_CpuCopy8(addr, sSendBufferQueue[i], whConfig_wmMinDataSize);
            else
                MI_CpuClear8(sSendBufferQueue[i], whConfig_wmMinDataSize);
        }
    }
}

#if defined(__MWERKS__)
#pragma optimize_for_size off
#endif

void Task__Unknown2068430__Destructor(Task *task)
{
    sTaskUnknown2068430 = NULL;
}

#if defined(__MWERKS__)
#pragma push
#pragma optimization_level 2
#endif

void WirelessManager__InitBuffers(u16 size)
{
    WirelessManager__ClearSendBuffer();
    WirelessManager__ClearUnknownBuffer();

    MI_CpuClear32(sSendBufferQueue, sizeof(sSendBufferQueue));

    u16 i;
    u16 step = (size + 3) & ~3;
    u8 *ptr  = (u8 *)sWirelessManagerUnknownBuffer;
    for (i = 0; i < 16; i++)
    {
        sSendBufferQueue[i] = ptr;
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
        WirelessManager__Func_2069838(3);
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
        WirelessManager__Func_2069838(3);
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

    WirelessManager_Unknown2068724 *unknown = &work->unknownList[param->aid - 1];
    MI_CpuCopy8(param->macAddress, unknown->macAddress, sizeof(unknown->macAddress));
    MI_CpuCopy8(param->ssid, &unknown->ssid, sizeof(unknown->ssid));

    return TRUE;
}

void WirelessManager__Func_206877C(WMBssDesc *pBssDesc, void *a2)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    WirelessManager__Unknown *entryList = work->entries;
    if ((pBssDesc->gameInfo.gameNameCount_attribute & 2) == 0)
    {
        u32 count = work->entryCount;
        if (count < ARRAY_COUNT(work->entries) && (pBssDesc->gameInfo.tgid & 0x1F) == work->field_16)
        {
            u16 i;
            if ((pBssDesc->gameInfo.tgid & 0x8000) != 0)
            {
                for (i = 0; i < count; i++)
                {
                    if (memcmp(entryList[i].bssDesc.bssid, pBssDesc->bssid, sizeof(pBssDesc->bssid)) == 0)
                    {
                        WirelessManager__RemoveEntry(i);
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
                        entryList[i].field_C0 = 0;
                        entryList[i].field_C4 = *(u16 *)(a2 + 18);
                        return;
                    }
                }

                MI_CpuCopy32(pBssDesc, &entryList[i].bssDesc, sizeof(entryList[i].bssDesc));
                entryList[i].field_C0 = 0;
                entryList[i].field_C4 = *(u16 *)(a2 + 18);
                work->entryCount++;
            }
        }
    }
}

void WirelessManager__Func_20688DC(WMBssDesc *bssDesc, void *a2)
{
    WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

    if ((bssDesc->gameInfo.gameNameCount_attribute & 2) == 0 && work->entryCount == 0)
    {
        MI_CpuCopy32(bssDesc, &work->entries[0].bssDesc, sizeof(work->entries[0].bssDesc));
        work->entries[0].field_C0 = 0;
        work->entries[0].field_C4 = *(u16 *)(a2 + 18); // TODO: what is this
        work->entryCount          = 1;
    }
}

void WirelessManager__SendDataCB_2068944(BOOL result)
{
    // Do nothing
}

void WirelessManager__ReceiverCB_2068948(u16 aid, u16 *data, u16 size)
{
    if (size == 4)
        ((u16 *)&sWirelessManagerUnknownBuffer)[1] |= 1 << aid; // TODO: what is this
}

void WirelessManager__SendDataCB_206896C(BOOL result)
{
    // Do nothing
}

NONMATCH_FUNC void WirelessManager__ReceiverCB_2068970(u16 aid, u16 *data, u16 size)
{
    // https://decomp.me/scratch/bJK0b -> 96.67%
#ifdef NON_MATCHING
    if (size == 4)
    {
        ((u16 *)&sWirelessManagerUnknownBuffer)[0] = data[0]; // TODO: what is this
        ((u16 *)&sWirelessManagerUnknownBuffer)[1] = data[1]; // TODO: what is this
    }
#else
    // clang-format off
	cmp r2, #4
	bxne lr
	ldrh r2, [r1, #0]
	ldrh r1, [r1, #2]
	ldr r0, =sWirelessManagerUnknownBuffer
	strh r2, [r0]
	strh r1, [r0, #2]
	bx lr

// clang-format on
#endif
}

void WirelessManager__State_2068994(WirelessManager *work)
{
    work->status = 1;
    work->timer  = 0;

    work->state = WirelessManager__State_20689B4;
}

void WirelessManager__State_20689B4(WirelessManager *work)
{
    if (WH_GetSystemState() == WH_SYSSTATE_IDLE)
    {
        WH_SetUserGameInfo(sWirelessManagerUserGameInfo, sizeof(sWirelessManagerUserGameInfo));

        if (WH_StartMeasureChannel() == FALSE)
        {
            WirelessManager__Func_2069838(1);
        }
        else
        {
            work->timer = 0;
            work->state = WirelessManager__State_2068A08;
        }
    }
}

void WirelessManager__State_2068A08(WirelessManager *work)
{
    if (WH_GetSystemState() == WH_SYSSTATE_MEASURECHANNEL)
    {
        // Yep
        work->channel = 0;
        if (work->channel == 0)
            work->channel = WH_GetMeasureChannel();

        if (work->field_4 == 3)
        {
            work->state = WirelessManager__State_20698CC;
        }
        else
        {
            work->tgid = WirelessManager__GenerateTGID(work->field_16);
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
        Task__Unknown2068430__Create(WirelessManager__Func_2069794);
        WirelessManager__Func_2067AE8(TRUE);

        work->timer = 0;
        work->state = WirelessManager__State_2068ABC;
    }
}

void WirelessManager__State_2068ABC(WirelessManager *work)
{
    work->status = 1;
    work->timer  = 0;

    work->state = WirelessManager__State_2068ADC;
}

void WirelessManager__State_2068ADC(WirelessManager *work)
{
    WirelessManager_SendPacket *sendPacket = (WirelessManager_SendPacket *)WirelessManager__GetSendBuffer();
    sendPacket->childBitmap                = WH_GetConnectBitmap();

    if (WirelessManager__GetChildCount() > 1)
    {
        work->status = 2;
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
        work->status = 1;
    }

    work->field_17 = 0;
    work->timer    = 0;
}

void WirelessManager__State_2068B5C(WirelessManager *work)
{
    work->status = 2;
    work->timer  = 0;

    work->state = WirelessManager__State_2068B7C;
}

void WirelessManager__State_2068B7C(WirelessManager *work)
{
    if ((WH_GetConnectBitmap() & ~1) == 0)
    {
        WirelessManager_SendPacket *sendPacket = (WirelessManager_SendPacket *)WirelessManager__GetSendBuffer();
        MI_CpuClear32(sendPacket, sizeof(*sendPacket));

        WirelessManager__Func_2068484();
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

        work->tgid |= 0x8000;

        WHConnectMode connectMode;
        switch (work->field_4)
        {
            case 1:
                connectMode = WH_CONNECTMODE_DS_PARENT;
                Task__Unknown2068430__Create(WirelessManager__Func_2069794);
                WH_SetMinDataSize(work->field_1AEE);
                WirelessManager__InitBuffers(work->field_1AEE);
                break;

            case 2:
                connectMode = 6; // TODO: 6?
                WH_SetMaxParentChildSize(work->field_1AF0, work->field_1AF2);
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
    switch (work->field_4)
    {
        case 1:
            bitmap = WH_GetConnectBitmap();
            break;

        case 2:
            bitmap = WFS_GetCurrentBitmap();
            break;
    }

    if (WirelessManager__GetBitmapUserCount(work->childBitmap) == WirelessManager__GetBitmapUserCount(bitmap))
    {
        WirelessManager_SendPacket *sendPacket;
        switch (work->field_4)
        {
            case 1:
                sendPacket              = (WirelessManager_SendPacket *)WirelessManager__GetSendBuffer();
                sendPacket->childBitmap = bitmap;
                sendPacket->flags |= 2;

                work->field_18 = 5;
                work->timer    = 0;
                work->state    = WirelessManager__State_206966C;
                break;

            case 2:
                sendPacket = (WirelessManager_SendPacket *)WirelessManager__GetSendBuffer();
                if (WFS_GetStatus() == WFS_STATE_READY)
                {
                    MI_CpuClear32(sWirelessManagerUnknownBuffer, sizeof(sWirelessManagerUnknownBuffer));
                    WH_SetReceiver(WirelessManager__ReceiverCB_2068948);

                    sendPacket->childBitmap = bitmap;
                    sendPacket->flags       = 1;

                    DC_StoreRange(sendPacket, sizeof(*sendPacket));
                    WH_SendData(sendPacket, sizeof(*sendPacket), WirelessManager__SendDataCB_2068944);
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
        switch (work->field_4)
        {
            case 1:
                connectMode = WH_CONNECTMODE_DS_PARENT;
                Task__Unknown2068430__Create(WirelessManager__Func_2069794);
                WH_SetMinDataSize(work->field_1AEE);
                WirelessManager__InitBuffers(work->field_1AEE);
                break;

            case 2:
                connectMode = 6; // TODO: 6?
                WH_SetMaxParentChildSize(work->field_1AF0, work->field_1AF2);
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
    switch (work->field_4)
    {
        case 1:
            bitmap = WH_GetConnectBitmap();
            break;

        case 2:
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
        switch (work->field_4)
        {
            case 1:
                sendPacket              = (WirelessManager_SendPacket *)WirelessManager__GetSendBuffer();
                sendPacket->childBitmap = bitmap;
                sendPacket->flags |= 2;

                work->field_18 = 5;
                work->timer    = 0;
                work->state    = WirelessManager__State_206966C;
                break;

            case 2:
                sendPacket = (WirelessManager_SendPacket *)WirelessManager__GetSendBuffer();
                if (WFS_GetStatus() == WFS_STATE_READY)
                {
                    MI_CpuClear32(sWirelessManagerUnknownBuffer, sizeof(sWirelessManagerUnknownBuffer));
                    WH_SetReceiver(WirelessManager__ReceiverCB_2068948);

                    sendPacket->childBitmap = bitmap;
                    sendPacket->flags |= 1;

                    DC_StoreRange(sendPacket, sizeof(*sendPacket));
                    WH_SendData(sendPacket, sizeof(*sendPacket), WirelessManager__SendDataCB_2068944);
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

void WirelessManager__State_2069024(WirelessManager *work)
{
    work->status     = 4;
    work->field_192A = 0xFFFF;
    work->timer      = 0;
    work->state      = WirelessManager__State_2069054;
}

void WirelessManager__State_2069054(WirelessManager *work)
{
    if (WH_GetSystemState() == WH_SYSSTATE_IDLE)
    {
        u8 macAddr[6] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };

        WH_SetSsid(sGameSSID, sizeof(sGameSSID));
        WH_StartScan(WirelessManager__Func_206877C, macAddr, 0);

        work->timer = 0;
        work->state = WirelessManager__State_20690E8;
    }
}

void WirelessManager__State_20690E8(WirelessManager *work)
{
    for (u16 i = 0; i < work->entryCount; i++)
    {
        work->entries[i].field_C0++;
    }

    if (WH_GetSystemState() == WH_SYSSTATE_IDLE)
    {
        if (work->field_192A != 0xFFFF)
        {
            work->tgid = work->entries[work->field_192A].bssDesc.gameInfo.tgid;
            WH_ChildConnect(5, &work->entries[work->field_192A].bssDesc); // TODO: 5?
            work->state = WirelessManager__State_2069190;
        }
    }

    work->timer = 0;
}

void WirelessManager__State_2069190(WirelessManager *work)
{
    if (WH_GetSystemState() == WH_SYSSTATE_DATASHARING)
    {
        Task__Unknown2068430__Create(WirelessManager__Func_2069794);
        WirelessManager__Func_2067AE8(TRUE);

        work->timer = 0;
        work->state = WirelessManager__State_20691D0;
    }
}

void WirelessManager__State_20691D0(WirelessManager *work)
{
    work->status = 5;
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
            WirelessManager__Func_2069838(2);
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
    work->status = 5;
    work->timer  = 0;

    work->state = WirelessManager__State_2069298;
}

void WirelessManager__State_2069298(WirelessManager *work)
{
    WirelessManager_SendPacket *sendBuffer = (WirelessManager_SendPacket *)WirelessManager__GetSendBuffer();
    MI_CpuClear32(sendBuffer, sizeof(*sendBuffer));

    WirelessManager__Func_2068484();
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
            WirelessManager__Unknown *entry = &work->entries[work->field_192A];

            WHConnectMode connectMode;
            switch (work->field_4)
            {
                case 1:
                    connectMode = 5;
                    WH_SetMinDataSize(work->field_1AEE);
                    WirelessManager__InitBuffers(work->field_1AEE);
                    Task__Unknown2068430__Create(WirelessManager__Func_2069794);
                    break;

                case 2:
                    connectMode = 7; // TODO: 7?
                    WH_SetMaxParentChildSize(work->field_1AF0, work->field_1AF2);
                    MI_CpuClear32(sWirelessManagerUnknownBuffer, sizeof(sWirelessManagerUnknownBuffer));
                    WH_SetReceiver(WirelessManager__ReceiverCB_2068970);
                    break;
            }

            WH_ChildConnectAuto(WirelessManager__Func_20688DC, connectMode, entry->bssDesc.bssid, entry->bssDesc.channel);
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
            WirelessManager__Func_2069838(2);
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
                WH_SendData(sendPacket, sizeof(*sendPacket), WirelessManager__SendDataCB_206896C);
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
            WirelessManager__Unknown *entry = &work->entries[work->field_192A];

            WHConnectMode connectMode;
            switch (work->field_4)
            {
                case 1:
                    connectMode = 5;
                    Task__Unknown2068430__Create(WirelessManager__Func_2069794);
                    WH_SetMinDataSize(work->field_1AEE);
                    WirelessManager__InitBuffers(work->field_1AEE);
                    break;

                case 2:
                    connectMode = 7; // TODO: 7?
                    WH_SetMaxParentChildSize(work->field_1AF0, work->field_1AF2);
                    MI_CpuClear32(sWirelessManagerUnknownBuffer, sizeof(sWirelessManagerUnknownBuffer));
                    WH_SetReceiver(WirelessManager__ReceiverCB_2068970);
                    break;
            }

            WH_ChildConnectAuto(WirelessManager__Func_20688DC, connectMode, entry->bssDesc.bssid, entry->bssDesc.channel);
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
            WirelessManager__Func_2069838(2);
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
                WH_SendData(sendPacket, sizeof(*sendPacket), WirelessManager__SendDataCB_206896C);
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
    WirelessManager__InitBuffers(work->field_1AEE);

    work->timer = 0;
    work->state = WirelessManager__State_20696A0;
}

void WirelessManager__State_20696A0(WirelessManager *work)
{
    if (work->field_18 != 0)
        work->field_18--;
    else
        work->status = 6;

    work->timer = 0;
}

void WirelessManager__State_20696C4(WirelessManager *work)
{
    BOOL isLooping;
    u32 loopCount;

    if (work->status != 7)
    {
        work->status = 7;

        isLooping = TRUE;
        loopCount = 0;
        WirelessManager__Func_2068484();
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
                    loopCount++;
                    if (loopCount <= 3)
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

void WirelessManager__Func_2069794(void)
{
    BOOL isLooping;
    u32 loopCount;

    WirelessManager__Func_2068484();

    loopCount = 0;
    isLooping = TRUE;

    sTaskUnknown2068430Param = NULL;

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
                loopCount++;
                if (loopCount <= 3)
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

    WirelessManager__Func_2069838(2);
}

void WirelessManager__Func_2069838(s32 a1)
{
    if (sTaskSingleton != NULL)
    {
        WirelessManager *work = TaskGetWork(sTaskSingleton, WirelessManager);

        work->field_C = a1;
        work->state   = WirelessManager__State_20696C4;
    }
}

void Task__Unknown2067FA0__Main(void)
{
    WirelessManager *work = TaskGetWorkCurrent(WirelessManager);

    if (work->timer == SECONDS_TO_FRAMES(4.0))
    {
        work->timer++;
        WirelessManager__Func_2069838(3);
    }
    else if (work->timer < SECONDS_TO_FRAMES(4.0))
    {
        work->timer++;
    }

    work->state(work);
    work->field_17 = 0;
}

void Task__Unknown2067FA0__Destructor(Task *task)
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
    MI_CpuClear16(&work->field_1CF6, sizeof(work->field_1CF6));

    work->state = WirelessManager__State_2069964;
    work->state(work);
}

void WirelessManager__State_2069964(WirelessManager *work)
{
    u16 prevBitmap = work->childBitmap;
    work->childBitmap =
        MBP_GetChildBmp(MBP_BMPTYPE_ENTRY) | MBP_GetChildBmp(MBP_BMPTYPE_DOWNLOADING) | MBP_GetChildBmp(MBP_BMPTYPE_BOOTABLE) | MBP_GetChildBmp(MBP_BMPTYPE_REBOOT) | 1;

    MI_CpuClear16(work->field_1B34, sizeof(work->field_1B34));
    for (u16 i = 1; i <= 15; i++)
    {
        const MBPChildInfo *info = MBP_GetChildInfo(i);
        if (info)
        {
            work->field_1B34[i - 1] = *info;
        }
        else
        {
            work->field_1CF6[i - 1] = 0;
        }
    }

    work->status = 1;
    switch (MBP_GetState())
    {
        case MBP_STATE_IDLE:
            work->timer = 0;
            MBP_Start(&work->gameRegistry, work->channel);
            break;

        case MBP_STATE_ENTRY:
            if ((work->childBitmap & ~1) != 0)
            {
                work->status = 2;
                if (work->field_17)
                    MBP_StartDownloadAll();
            }
            work->field_18 = 0;
            work->timer    = 0;
            break;

        case MBP_STATE_DATASENDING:
            work->status = 3;
            if (work->childBitmap == 1)
            {
                work->timer   = SECONDS_TO_FRAMES(4.0);
                work->status  = 7;
                work->field_C = 2;
            }
            else if ((work->field_1B30 & 1) != 0 && prevBitmap != work->childBitmap)
            {
                work->timer   = SECONDS_TO_FRAMES(4.0);
                work->status  = 7;
                work->field_C = 2;
            }
            else
            {
                if (MBP_IsBootableAll())
                    MBP_StartRebootAll();
                work->timer = 0;
            }
            break;

        case MBP_STATE_REBOOTING:
            work->status = 3;
            work->timer  = 0;
            break;

        case MBP_STATE_COMPLETE:
            work->status = 6;
            work->timer  = 0;
            work->state  = WirelessManager__State_2069B90;
            break;

        case MBP_STATE_ERROR:
            work->status  = 7;
            work->field_C = 3;
            MBP_Cancel();
            break;
    }
}

void WirelessManager__State_2069B90(WirelessManager *work)
{
    work->timer = 0;
}