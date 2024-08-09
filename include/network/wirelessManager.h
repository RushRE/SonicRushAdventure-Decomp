#ifndef RUSH2_WIRELESSHANDLER_H
#define RUSH2_WIRELESSHANDLER_H

#include <global.h>
#include <game/system/task.h>

// --------------------
// ENUMS
// --------------------

enum WHSysState_
{
    WH_SYSSTATE_STOP,
    WH_SYSSTATE_IDLE,
    WH_SYSSTATE_SCANNING,
    WH_SYSSTATE_BUSY,
    WH_SYSSTATE_CONNECTED,
    WH_SYSSTATE_DATASHARING,
    WH_SYSSTATE_KEYSHARING,
    WH_SYSSTATE_MEASURECHANNEL,
    WH_SYSSTATE_CONNECT_FAIL,
    WH_SYSSTATE_ERROR,
    WH_SYSSTATE_FATAL,
    WH_SYSSTATE_NUM,
};
typedef u32 WHSysState;

enum WFSState_
{
    WFS_STATE_STOP,
    WFS_STATE_IDLE,
    WFS_STATE_READY,
    WFS_STATE_ERROR,
};
typedef u32 WFSState;

// --------------------
// STRUCTS
// --------------------

typedef struct WHConfig_
{
    u16 sChannelBusyRatio;
    u16 sConnectBitmap;
    u16 sChannelIndex;
    u16 wmMaxParentSize;
    u16 sMyAid;
    u16 sChannel;
    u16 wmMinDataSize;
    u16 sChannelBitmap;
    u16 wmMaxChildCount;
    u16 sAutoConnectFlag;
    u16 wmMaxChildSize;
    u32 dword_2136418;
    WHSysState sSysState;
    void *(*whAllocFunc)(u32 size);
    void *sReceiverFunc;
    u32 sScanCallback;
    u32 sConnectMode;
    u32 sParentWEPKeyGenerator;
    u32 sRecvBufferSize;
    u32 sPictoCatchFlag;
    u32 sRand;
    void (*whFreeFunc)(void *mem);
    void (*wh_trace)(char *, ...);
    u32 sSendBufferSize;
    WMErrCode sErrCode;
    void *sJudgeAcceptFunc;
} WHConfig;

// --------------------
// VARIABLES
// --------------------

extern WHConfig whConfig;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void WirelessManager__ClearSendBuffer(void);
NOT_DECOMPILED u8 WH_GetCurrentAid(void);
NOT_DECOMPILED void *WirelessManager__GetSendBuffer(void);
NOT_DECOMPILED void *WirelessManager__GetRecieveBuffer(u32 id);

NOT_DECOMPILED u32 WirelessManager__Func_2068284(u32 bitmap);
NOT_DECOMPILED u32 WirelessManager__Func_2068234(void);
NOT_DECOMPILED s32 WirelessManager__GetField8(void);

NOT_DECOMPILED u32 WFS_Func_206D9B4(void);
NOT_DECOMPILED s32 WFS_GetStatus(void);
NOT_DECOMPILED u32 WH_GetConnectBitmap(void);

NOT_DECOMPILED WMLinkLevel WirelessManager__GetLinkLevel(void);

#endif // RUSH2_WIRELESSHANDLER_H