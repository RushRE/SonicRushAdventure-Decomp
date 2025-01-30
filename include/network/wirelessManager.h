#ifndef RUSH_WIRELESSHANDLER_H
#define RUSH_WIRELESSHANDLER_H

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

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED u16 whConfig_sChannelBusyRatio;
NOT_DECOMPILED u16 whConfig_sConnectBitmap;
NOT_DECOMPILED u16 whConfig_sChannelIndex;
NOT_DECOMPILED u16 whConfig_wmMaxParentSize;
NOT_DECOMPILED u16 whConfig_sMyAid;
NOT_DECOMPILED u16 whConfig_sChannel;
NOT_DECOMPILED u16 whConfig_wmMinDataSize;
NOT_DECOMPILED u16 whConfig_sChannelBitmap;
NOT_DECOMPILED u16 whConfig_wmMaxChildCount;
NOT_DECOMPILED u16 whConfig_sAutoConnectFlag;
NOT_DECOMPILED u16 whConfig_wmMaxChildSize;
NOT_DECOMPILED u32 whConfig_dword_2136418;
NOT_DECOMPILED WHSysState whConfig_sSysState;
NOT_DECOMPILED void *(*whConfig_whAllocFunc)(u32 size);
NOT_DECOMPILED void *whConfig_sReceiverFunc;
NOT_DECOMPILED u32 whConfig_sScanCallback;
NOT_DECOMPILED u32 whConfig_sConnectMode;
NOT_DECOMPILED u32 whConfig_sParentWEPKeyGenerator;
NOT_DECOMPILED u32 whConfig_sRecvBufferSize;
NOT_DECOMPILED u32 whConfig_sPictoCatchFlag;
NOT_DECOMPILED u32 whConfig_sRand;
NOT_DECOMPILED void (*whConfig_whFreeFunc)(void *mem);
NOT_DECOMPILED void (*whConfig_wh_trace)(char *, ...);
NOT_DECOMPILED u32 whConfig_sSendBufferSize;
NOT_DECOMPILED WMErrCode whConfig_sErrCode;
NOT_DECOMPILED void *whConfig_sJudgeAcceptFunc;
NOT_DECOMPILED u32 whConfig_dword_2136454;
NOT_DECOMPILED u32 whConfig_dword_2136458;
NOT_DECOMPILED u32 whConfig_dword_213645C;

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

#endif // RUSH_WIRELESSHANDLER_H