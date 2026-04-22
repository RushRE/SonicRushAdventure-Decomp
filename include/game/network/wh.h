#ifndef RUSH_WH_H
#define RUSH_WH_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// TYPES
// --------------------

typedef void (*WHStartScanCallbackFunc)(WMBssDesc *bssDesc, void* a2);

typedef void (*WHSendCallbackFunc)(BOOL result);

typedef BOOL (*WHJudgeAcceptFunc)(WMStartParentCallback *);

typedef void (*WHReceiverFunc)(u16 aid, u16 *data, u16 size);

typedef u16 (*WHParentWEPKeyGeneratorFunc)(u16 *wepkey, const WMParentParam *parentParam);
typedef u16 (*WHChildWEPKeyGeneratorFunc)(u16 *wepkey, const WMBssDesc *bssDesc);

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
};
typedef u32 WHSysState;

enum WHConnectMode_
{
    WH_CONNECTMODE_MP_PARENT,
    WH_CONNECTMODE_MP_CHILD,
    WH_CONNECTMODE_KS_PARENT,
    WH_CONNECTMODE_KS_CHILD,
    WH_CONNECTMODE_DS_PARENT,
    WH_CONNECTMODE_DS_CHILD,
};
typedef u32 WHConnectMode;

enum WHErrCode_
{
    WH_ERRCODE_DISCONNECTED = WM_ERRCODE_MAX,
    WH_ERRCODE_PARENT_NOT_FOUND,
    WH_ERRCODE_NO_RADIO,
    WH_ERRCODE_LOST_PARENT,
    WH_ERRCODE_NOMORE_CHANNEL,
};
typedef u32 WHErrCode;

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

NOT_DECOMPILED void WH_GetWMErrCodeName(void);
NOT_DECOMPILED void WH_GetWMStateCodeName(void);
NOT_DECOMPILED void WH_ChangeSysState(void);
NOT_DECOMPILED void WH_SetError(void);
NOT_DECOMPILED void WH_Alloc(void);
NOT_DECOMPILED void WH_Free(void);
NOT_DECOMPILED void WH_StateInSetParentParam(void);
NOT_DECOMPILED void WH_StateOutSetParentParam(void *arg);
NOT_DECOMPILED void WH_StateInSetParentWEPKey(void);
NOT_DECOMPILED void WH_StateOutSetParentWEPKey(void *arg);
NOT_DECOMPILED void WH_StateInStartParent(void);
NOT_DECOMPILED void WH_StateOutStartParent(void *arg);
NOT_DECOMPILED void WH_StateInStartParentMP(void);
NOT_DECOMPILED void WH_StateOutStartParentMP(void *arg);
NOT_DECOMPILED void WH_StateInStartParentKeyShare(void);
NOT_DECOMPILED void WH_StateInEndParentKeyShare(void);
NOT_DECOMPILED void WH_StateInEndParentMP(void);
NOT_DECOMPILED void WH_StateOutEndParentMP(void *arg);
NOT_DECOMPILED void WH_StateInEndParent(void);
NOT_DECOMPILED void WH_StateOutEndParent(void *arg);
NOT_DECOMPILED void WH_ChildConnectAuto(WHStartScanCallbackFunc callback, int mode, const u8 *macAddr, u16 channel);
NOT_DECOMPILED void WH_StartScan(WHStartScanCallbackFunc callback, const u8 *macAddr, u16 channel);
NOT_DECOMPILED void WH_StateInStartScan(void);
NOT_DECOMPILED void WH_StateOutStartScan(void *arg);
NOT_DECOMPILED void WH_EndScan(void);
NOT_DECOMPILED void WH_StateInEndScan(void);
NOT_DECOMPILED void WH_StateOutEndScan(void *arg);
NOT_DECOMPILED void WH_StateInSetChildWEPKey(void);
NOT_DECOMPILED void WH_StateOutSetChildWEPKey(void);
NOT_DECOMPILED void WH_StateInStartChild(void);
NOT_DECOMPILED void WH_StateOutStartChild(void *arg);
NOT_DECOMPILED void WH_StateInStartChildMP(void);
NOT_DECOMPILED void WH_StateOutStartChildMP(void *arg);
NOT_DECOMPILED void WH_StateInStartChildKeyShare(void);
NOT_DECOMPILED void WH_StateInEndChildKeyShare(void);
NOT_DECOMPILED void WH_StateInEndChildMP(void);
NOT_DECOMPILED void WH_StateOutEndChildMP(void *arg);
NOT_DECOMPILED void WH_StateInEndChild(void);
NOT_DECOMPILED void WH_StateOutEndChild(void *arg);
NOT_DECOMPILED void WH_StateInReset(void);
NOT_DECOMPILED void WH_StateOutReset(void *arg);
NOT_DECOMPILED void WH_StateInSetMPData(void *data, u16 datasize, WHSendCallbackFunc callback);
NOT_DECOMPILED void WH_StateOutSetMPData(void *arg);
NOT_DECOMPILED void WH_PortReceiveCallback(void *arg);
NOT_DECOMPILED void WH_StateOutEnd(void);
NOT_DECOMPILED void WH_SetGgid(u32 ggid);
NOT_DECOMPILED void WH_SetSsid(const void *ssid, u32 length);
NOT_DECOMPILED void WH_SetUserGameInfo(u16 *userGameInfo, u16 length);
NOT_DECOMPILED void WH_SetMaxChildCount(u16 count);
NOT_DECOMPILED void WH_SetMinDataSize(u16 size);
NOT_DECOMPILED void WH_SetMaxParentChildSize(u16 parentSize, u16 childSize);
NOT_DECOMPILED u16 WH_GetConnectBitmap(void);
NOT_DECOMPILED WHSysState WH_GetSystemState(void);
NOT_DECOMPILED u32 WH_GetErrorCode(void);
NOT_DECOMPILED BOOL WH_StartMeasureChannel(void);
NOT_DECOMPILED void WH_StateInMeasureChannel(void);
NOT_DECOMPILED void WH_StateOutMeasureChannel(void);
NOT_DECOMPILED void WHi_MeasureChannel(void);
NOT_DECOMPILED u16 WH_GetMeasureChannel(void);
NOT_DECOMPILED void WHi_SelectChannel(void);
NOT_DECOMPILED BOOL WH_Initialize(void);
NOT_DECOMPILED void WH_IndicateHandler(void);
NOT_DECOMPILED void sub_206b700(void);
NOT_DECOMPILED void WH_StateInInitialize(void);
NOT_DECOMPILED void WH_StateOutInitialize(void);
NOT_DECOMPILED void WH_ParentConnect(WHConnectMode mode, u16 tgid, u16 channel);
NOT_DECOMPILED void WH_ChildConnect(WHConnectMode mode, WMBssDesc *bssDesc);
NOT_DECOMPILED void WH_SetJudgeAcceptFunc(WHJudgeAcceptFunc func);
NOT_DECOMPILED void WH_SetReceiver(WHReceiverFunc func);
NOT_DECOMPILED void WH_SendData(void *data, u16 datasize, WHSendCallbackFunc callback);
NOT_DECOMPILED const void* WH_GetSharedDataAdr(u16 aid);
NOT_DECOMPILED BOOL WH_StepDS(void *data);
NOT_DECOMPILED void WH_Reset(void);
NOT_DECOMPILED void WH_Finalize(void);
NOT_DECOMPILED BOOL WH_End(void);
NOT_DECOMPILED u8 WH_GetCurrentAid(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_WH_H