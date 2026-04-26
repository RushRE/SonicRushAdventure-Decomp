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

const char* WH_GetWMErrCodeName(WMErrCode code);
const char* WH_GetWMStateCodeName(u32 state);
void WH_ChangeSysState(WHSysState state);
void WH_SetError(WMErrCode error);
void* WH_Alloc(s32 unknown, size_t size, void *ptr);
void WH_Free(WMStartParentCallback *context);
void WH_StateInSetParentParam(void);
void WH_StateOutSetParentParam(void *arg);
void WH_StateInSetParentWEPKey(void);
void WH_StateOutSetParentWEPKey(void *arg);
void WH_StateInStartParent(void);
void WH_StateOutStartParent(void *arg);
void WH_StateInStartParentMP(void);
void WH_StateOutStartParentMP(void *arg);
void WH_StateInStartParentKeyShare(void);
void WH_StateInEndParentKeyShare(void);
void WH_StateInEndParentMP(void);
void WH_StateOutEndParentMP(void *arg);
void WH_StateInEndParent(void);
void WH_StateOutEndParent(void *arg);
void WH_ChildConnectAuto(WHStartScanCallbackFunc callback, int mode, const u8 *macAddr, u16 channel);
void WH_StartScan(WHStartScanCallbackFunc callback, const u8 *macAddr, u16 channel);
void WH_StateInStartScan(void);
void WH_StateOutStartScan(void *arg);
void WH_EndScan(void);
void WH_StateInEndScan(void);
void WH_StateOutEndScan(void *arg);
void WH_StateInSetChildWEPKey(void);
void WH_StateOutSetChildWEPKey(void);
void WH_StateInStartChild(void);
void WH_StateOutStartChild(void *arg);
void WH_StateInStartChildMP(void);
void WH_StateOutStartChildMP(void *arg);
void WH_StateInStartChildKeyShare(void);
void WH_StateInEndChildKeyShare(void);
void WH_StateInEndChildMP(void);
void WH_StateOutEndChildMP(void *arg);
void WH_StateInEndChild(void);
void WH_StateOutEndChild(void *arg);
void WH_StateInReset(void);
void WH_StateOutReset(void *arg);
void WH_StateInSetMPData(void *data, u16 datasize, WHSendCallbackFunc callback);
void WH_StateOutSetMPData(void *arg);
void WH_PortReceiveCallback(void *arg);
void WH_StateOutEnd(void);
void WH_SetGgid(u32 ggid);
void WH_SetSsid(const void *ssid, u32 length);
void WH_SetUserGameInfo(u16 *userGameInfo, u16 length);
void WH_SetMaxChildCount(u16 count);
void WH_SetMinDataSize(u16 size);
void WH_SetMaxParentChildSize(u16 parentSize, u16 childSize);
u16 WH_GetConnectBitmap(void);
WHSysState WH_GetSystemState(void);
u32 WH_GetErrorCode(void);
BOOL WH_StartMeasureChannel(void);
void WH_StateInMeasureChannel(void);
void WH_StateOutMeasureChannel(void);
void WHi_MeasureChannel(void);
u16 WH_GetMeasureChannel(void);
void WHi_SelectChannel(void);
BOOL WH_Initialize(void);
void WH_IndicateHandler(void);
void WH_StateInInitialize(void);
void WH_StateOutInitialize(void);
void WH_ParentConnect(WHConnectMode mode, u16 tgid, u16 channel);
void WH_ChildConnect(WHConnectMode mode, WMBssDesc *bssDesc);
void WH_SetJudgeAcceptFunc(WHJudgeAcceptFunc func);
void WH_SetReceiver(WHReceiverFunc func);
void WH_SendData(void *data, u16 datasize, WHSendCallbackFunc callback);
const void* WH_GetSharedDataAdr(u16 aid);
BOOL WH_StepDS(void *data);
void WH_Reset(void);
void WH_Finalize(void);
BOOL WH_End(void);
u8 WH_GetCurrentAid(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_WH_H