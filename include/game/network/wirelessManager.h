#ifndef RUSH_WIRELESSMANAGER_H
#define RUSH_WIRELESSMANAGER_H

#include <global.h>
#include <game/network/wh.h>
#include <game/network/wfs.h>
#include <game/network/mbp.h>

#ifdef __cplusplus
extern "C"
{
#endif

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

NOT_DECOMPILED void WirelessManager__InitAllocator(void);
NOT_DECOMPILED void WirelessManager__Create(void);
NOT_DECOMPILED void Task__Unknown20674C4__Create(void);
NOT_DECOMPILED void WirelessManager__Create2(void);
NOT_DECOMPILED void WirelessManager__Create3(void);
NOT_DECOMPILED void MultibootManager__Func_206789C(s32 a1);
NOT_DECOMPILED void MultibootManager__Func_20679A8(void);
NOT_DECOMPILED void MultibootManager__Func_20679B4(void);
NOT_DECOMPILED void MultibootManager__Func_20679C0(void);
NOT_DECOMPILED void MultibootManager__Func_20679CC(void);
NOT_DECOMPILED void MultibootManager__Func_2067A18(void);
NOT_DECOMPILED void MultibootManager__Func_2067A48(void);
NOT_DECOMPILED void MultibootManager__Func_2067A88(void);
NOT_DECOMPILED void MultibootManager__Func_2067AE8(void);
NOT_DECOMPILED void *WirelessManager__GetSendBuffer(void);
NOT_DECOMPILED void *WirelessManager__GetRecieveBuffer(u32 id);
NOT_DECOMPILED void WirelessManager__ClearSendBuffer(void);
NOT_DECOMPILED void MultibootManager__Func_2067B50(void);
NOT_DECOMPILED void WirelessManager__Create4(void);
NOT_DECOMPILED void WirelessManager__Create5(void);
NOT_DECOMPILED void WirelessManager__Func_2067DF4(void);
NOT_DECOMPILED void WirelessManager__Func_2067F00(void);
NOT_DECOMPILED void WirelessManager__Func_2067F40(void);
NOT_DECOMPILED void Task__Unknown2067FA0__Create(void);
NOT_DECOMPILED void WirelessManager__Func_2068060(void);
NOT_DECOMPILED void WirelessManager__Func_2068160(void);
NOT_DECOMPILED void WirelessManager__Func_20681A0(void);
NOT_DECOMPILED void WirelessManager__Func_20681D0(void);
NOT_DECOMPILED void WirelessManager__Func_20681F8(void);
NOT_DECOMPILED void WirelessManager__Func_2068214(void);
NOT_DECOMPILED u32 WirelessManager__Func_2068234(void);
NOT_DECOMPILED s32 WirelessManager__GetField8(void);
NOT_DECOMPILED u32 WirelessManager__Func_2068284(u32 bitmap);
NOT_DECOMPILED WMLinkLevel WirelessManager__GetLinkLevel(void);
NOT_DECOMPILED void WirelessManager__StartMBP(void);
NOT_DECOMPILED void WirelessManager__Func_2068360(void);
NOT_DECOMPILED void WirelessManager__Func_2068380(void);
NOT_DECOMPILED void WirelessManager__Func_20683A8(void);
NOT_DECOMPILED void Task__Unknown2068430__Create(void);
NOT_DECOMPILED void WirelessManager__Func_2068484(void);
NOT_DECOMPILED void Task__Unknown2068430__Main(void);
NOT_DECOMPILED void Task__Unknown2068430__Destructor(void);
NOT_DECOMPILED void WirelessManager__Func_2068614(void);
NOT_DECOMPILED void WirelessManager__Main1(void);
NOT_DECOMPILED void WirelessManager__Main3(void);
NOT_DECOMPILED void WirelessManager__Destructor(void);
NOT_DECOMPILED void WirelessManager__JudgeAcceptFunc(void);
NOT_DECOMPILED void WirelessManager__Func_206877C(void);
NOT_DECOMPILED void WirelessManager__Func_20688DC(void);
NOT_DECOMPILED void WirelessManager__SendDataCB_2068944(void);
NOT_DECOMPILED void WirelessManager__ReceiverCB_2068948(void);
NOT_DECOMPILED void WirelessManager__SendDataCB_206896C(void);
NOT_DECOMPILED void WirelessManager__ReceiverCB_2068970(void);
NOT_DECOMPILED void WirelessManager__State_2068994(void);
NOT_DECOMPILED void WirelessManager__State_20689B4(void);
NOT_DECOMPILED void WirelessManager__State_2068A08(void);
NOT_DECOMPILED void WirelessManager__State_2068A78(void);
NOT_DECOMPILED void WirelessManager__State_2068ABC(void);
NOT_DECOMPILED void WirelessManager__State_2068ADC(void);
NOT_DECOMPILED void WirelessManager__State_2068B5C(void);
NOT_DECOMPILED void WirelessManager__State_2068B7C(void);
NOT_DECOMPILED void WirelessManager__State_2068BC4(void);
NOT_DECOMPILED void WirelessManager__State_2068C74(void);
NOT_DECOMPILED void WirelessManager__State_2068D94(void);
NOT_DECOMPILED void WirelessManager__State_2068DD4(void);
NOT_DECOMPILED void WirelessManager__State_2068E78(void);
NOT_DECOMPILED void WirelessManager__State_2068FD8(void);
NOT_DECOMPILED void WirelessManager__State_2069024(void);
NOT_DECOMPILED void WirelessManager__State_2069054(void);
NOT_DECOMPILED void WirelessManager__State_20690E8(void);
NOT_DECOMPILED void WirelessManager__State_2069190(void);
NOT_DECOMPILED void WirelessManager__State_20691D0(void);
NOT_DECOMPILED void WirelessManager__State_20691F0(void);
NOT_DECOMPILED void WirelessManager__State_2069278(void);
NOT_DECOMPILED void WirelessManager__State_2069298(void);
NOT_DECOMPILED void WirelessManager__State_20692D4(void);
NOT_DECOMPILED void WirelessManager__State_20693BC(void);
NOT_DECOMPILED void WirelessManager__State_2069498(void);
NOT_DECOMPILED void WirelessManager__State_2069580(void);
NOT_DECOMPILED void WirelessManager__State_206966C(void);
NOT_DECOMPILED void WirelessManager__State_20696A0(void);
NOT_DECOMPILED void WirelessManager__State_20696C4(void);
NOT_DECOMPILED void WirelessManager__Func_2069794(void);
NOT_DECOMPILED void MultibootManager__Func_2069838(void);
NOT_DECOMPILED void Task__Unknown2067FA0__Main(void);
NOT_DECOMPILED void Task__Unknown2067FA0__Destructor(void);
NOT_DECOMPILED void WirelessManager__State_20698CC(void);
NOT_DECOMPILED void WirelessManager__State_20698E8(void);
NOT_DECOMPILED void WirelessManager__State_2069914(void);
NOT_DECOMPILED void WirelessManager__State_2069964(void);
NOT_DECOMPILED void WirelessManager__State_2069B90(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_WIRELESSMANAGER_H
