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

typedef void (*WHStartScanCallbackFunc)(WMBssDesc *bssDesc, void *a2);

typedef void (*WHSendCallbackFunc)(BOOL result);

typedef BOOL (*WHJudgeAcceptFunc)(WMStartParentCallback *);

typedef void (*WHReceiverFunc)(u16 aid, u16 *data, u16 size);

typedef u16 (*WHParentWEPKeyGeneratorFunc)(u16 *wepkey, const WMParentParam *parentParam);
typedef u16 (*WHChildWEPKeyGeneratorFunc)(u16 *wepkey, const WMBssDesc *bssDesc);

// --------------------
// CONSTANTS
// --------------------

#define WH_DMA_NO          2
#define WH_CHILD_MAX       15
#define WH_DS_DATA_SIZE    12
#define WH_PARENT_MAX_SIZE (WH_DS_DATA_SIZE * (1 + WH_CHILD_MAX) + 4)
#define WH_CHILD_MAX_SIZE  (WH_DS_DATA_SIZE)
#define WH_DATA_PORT       14
#define WH_DATA_PRIO       WM_PRIORITY_NORMAL
#define WH_DS_PORT         13

#define WH_PARENT_RECV_BUFFER_SIZE WM_SIZE_MP_PARENT_RECEIVE_BUFFER(WH_CHILD_MAX_SIZE, WH_CHILD_MAX, FALSE)
#define WH_PARENT_SEND_BUFFER_SIZE WM_SIZE_MP_PARENT_SEND_BUFFER(WH_PARENT_MAX_SIZE, FALSE)

#define WH_CHILD_RECV_BUFFER_SIZE WM_SIZE_MP_CHILD_RECEIVE_BUFFER(WH_PARENT_MAX_SIZE, FALSE)
#define WH_CHILD_SEND_BUFFER_SIZE WM_SIZE_MP_CHILD_SEND_BUFFER(WH_CHILD_MAX_SIZE, FALSE)

#define WH_BITMAP_EMPTY 1

#define WH_MP_FREQUENCY 1

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
    WH_CONNECTMODE_UNKNOWN_PARENT,
    WH_CONNECTMODE_UNKNOWN_CHILD,
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

extern u16 gWHPacketSize;
extern u16 gWHMaxChildCount;

// --------------------
// FUNCTIONS
// --------------------

BOOL WH_ChildConnectAuto(WHStartScanCallbackFunc callback, WHConnectMode mode, const u8 *macAddr, u16 channel);
BOOL WH_StartScan(WHStartScanCallbackFunc callback, const u8 *macAddr, u16 channel);
BOOL WH_EndScan(void);
void WH_SetGgid(u32 ggid);
void WH_SetSsid(const void *ssid, u32 length);
void WH_SetUserGameInfo(u16 *userGameInfo, u16 length);
void WH_SetMaxChildCount(u16 count);
void WH_SetPacketSize(u16 size);
void WH_SetMaxParentChildSize(u16 parentSize, u16 childSize);
u16 WH_GetConnectBitmap(void);
WHSysState WH_GetSystemState(void);
u32 WH_GetErrorCode(void);
BOOL WH_StartMeasureChannel(void);
u16 WH_GetMeasureChannel(void);
BOOL WH_Initialize(void);
BOOL WH_ParentConnect(WHConnectMode mode, u16 tgid, u16 channel);
BOOL WH_ChildConnect(WHConnectMode mode, WMBssDesc *bssDesc);
void WH_SetJudgeAcceptFunc(WHJudgeAcceptFunc func);
void WH_SetReceiver(WHReceiverFunc func);
void WH_SendData(void *data, u16 dataSize, WHSendCallbackFunc callback);
const void *WH_GetSharedDataAdr(u16 aid);
BOOL WH_StepDS(void *data);
void WH_Reset(void);
void WH_Finalize(void);
BOOL WH_End(void);
u16 WH_GetCurrentAid(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_WH_H