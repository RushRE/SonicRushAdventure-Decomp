#include <game/network/wh.h>
#include <game/network/wfs.h>
#include <nitro/cht.h>

// --------------------
// ENUMS
// --------------------

enum MPFreq
{
    WH_MPFREQ_CONTIGUOUS,
    WH_MPFREQ_ONCE_PER_FRAME,
};

// --------------------
// VARIABLES
// --------------------

static u16 sConnectBitmap;
u16 gWHPacketSize;
static u16 sChannel;
static u16 sChildPacketSize;
static u16 sAutoConnectFlag;
static u16 sChannelBusyRatio;
static u16 sChannelIndex;
static u16 sChannelBitmap;
static u16 sMyAid;
static u16 sParentPacketSize;
u16 gWHMaxChildCount;
static WHConnectMode sConnectMode;
static WHJudgeAcceptFunc sJudgeAcceptFunc;
static WHChildWEPKeyGeneratorFunc sChildWEPKeyGenerator;
void *(*gWHAllocFunc)(u32 size);
static WMErrCode sErrCode;
static u32 sSendBufferSize;
static void (*sTraceFunc)(const char *, ...);
static u32 sRand;
static u32 sPictoCatchFlag;
static u32 sRecvBufferSize;
static WHParentWEPKeyGeneratorFunc sParentWEPKeyGenerator;
void (*gWHFreeFunc)(void *mem);
static WHStartScanCallbackFunc sScanCallback;
static WHReceiverFunc sReceiverFunc;
static WHSysState sSysState;

static u16 sWEPKey[20 / sizeof(u16)] ALIGN(0x20);
static WMScanParam sScanParam ALIGN(0x20);
static WMParentParam sParentParam ALIGN(0x20);
static WMBssDesc sBssDesc ALIGN(0x20);
static WMDataSet sDataSet ALIGN(0x20);
static WMDataSharingInfo sWMDataSharingInfo;
static WMKeySetBuf sWMKeySetBuf ALIGN(0x20);
static u8 sConnectionSsid[WM_SIZE_CHILD_SSID];
static u8 sSendBuffer[0x220 /*MATH_MAX(WH_PARENT_SEND_BUFFER_SIZE, WH_CHILD_SEND_BUFFER_SIZE)*/] ALIGN(0x20);
static u8 sRecvBuffer[0x480 /*MATH_MAX(WH_PARENT_RECV_BUFFER_SIZE, WH_CHILD_RECV_BUFFER_SIZE)*/] ALIGN(0x20);
static u8 sWmBuffer[WM_SYSTEM_BUF_SIZE] ALIGN(0x20);

// When matching, manually force the strings to appear in the desired order
#ifndef NON_MATCHING
/*
static const char aNA[]              = "N/A";
static const char WhSysstateIdle[]   = "WH_SYSSTATE_IDLE";
static const char WhSysstateBusy[]   = "WH_SYSSTATE_BUSY";
static const char WhSysstateStop[]   = "WH_SYSSTATE_STOP";
static const char WhSysstateErro[]   = "WH_SYSSTATE_ERROR";
static const char WmErrcodeFaile[]   = "WM_ERRCODE_FAILED";
static const char WmErrcodeSucce[]   = "WM_ERRCODE_SUCCESS";
static const char WmErrcodeNoDat[]   = "WM_ERRCODE_NO_DATA";
static const char WmErrcodeTimeo[]   = "WM_ERRCODE_TIMEOUT";
static const char WmStatecodeMpI[]   = "WM_STATECODE_MP_IND";
static const char WhErrcodeNoRad[]   = "WH_ERRCODE_NO_RADIO";
static const char WmErrcodeNoChi[]   = "WM_ERRCODE_NO_CHILD";
static const char WmErrcodeNoEnt[]   = "WM_ERRCODE_NO_ENTRY";
static const char WmErrcodeDcfTe[]   = "WM_ERRCODE_DCF_TEST";
static const char WmStatecodeDcf[]   = "WM_STATECODE_DCF_IND";
static const char WmStatecodeUnk[]   = "WM_STATECODE_UNKNOWN";
static const char WhSysstateScan[]   = "WH_SYSSTATE_SCANNING";
static const char WmErrcodeOpera[]   = "WM_ERRCODE_OPERATING";
static const char WmStatecodeMpS[]   = "WM_STATECODE_MP_START";
static const char WmErrcodeNoDat_0[] = "WM_ERRCODE_NO_DATASET";
static const char WmErrcodeFifoE[]   = "WM_ERRCODE_FIFO_ERROR";
static const char WmErrcodeWmDis[]   = "WM_ERRCODE_WM_DISABLE";
static const char WhSysstateConn[]   = "WH_SYSSTATE_CONNECTED";
static const char WmStatecodeMpe[]   = "WM_STATECODE_MPEND_IND";
static const char WmStatecodeMpa[]   = "WM_STATECODE_MPACK_IND";
static const char WmStatecodeDcf_0[] = "WM_STATECODE_DCF_START";
static const char WmStatecodePor[]   = "WM_STATECODE_PORT_SEND";
static const char WmStatecodePor_0[] = "WM_STATECODE_PORT_RECV";
static const char WmStatecodePor_1[] = "WM_STATECODE_PORT_INIT";
static const char WmErrcodeSendF[]   = "WM_ERRCODE_SEND_FAILED";
static const char WmErrcodeFlash[]   = "WM_ERRCODE_FLASH_ERROR";
static const char WhSysstateKeys[]   = "WH_SYSSTATE_KEYSHARING";
static const char WmStatecodeCon[]   = "WM_STATECODE_CONNECTED";
static const char WmStatecodeFif[]   = "WM_STATECODE_FIFO_ERROR";
static const char WhSysstateData[]   = "WH_SYSSTATE_DATASHARING";
static const char WhErrcodeDisco[]   = "WH_ERRCODE_DISCONNECTED";
static const char WmStatecodeSca[]   = "WM_STATECODE_SCAN_START";
static const char WmStatecodeBea[]   = "WM_STATECODE_BEACON_LOST";
static const char WmStatecodeBea_0[] = "WM_STATECODE_BEACON_RECV";
static const char WmStatecodeRea[]   = "WM_STATECODE_REASSOCIATE";
static const char WmStatecodeInf[]   = "WM_STATECODE_INFORMATION";
static const char WmErrcodeIlleg[]   = "WM_ERRCODE_ILLEGAL_STATE";
static const char WmErrcodeInval[]   = "WM_ERRCODE_INVALID_PARAM";
static const char WmErrcodeWlLen[]   = "WM_ERRCODE_WL_LENGTH_ERR";
static const char WhSysstateConn_0[] = "WH_SYSSTATE_CONNECT_FAIL";
static const char WmStatecodeBea_1[] = "WM_STATECODE_BEACON_SENT";
static const char WmStatecodeDis[]   = "WM_STATECODE_DISCONNECTED";
static const char WmStatecodeDis_0[] = "WM_STATECODE_DISASSOCIATE";
static const char WmStatecodeAut[]   = "WM_STATECODE_AUTHENTICATE";
static const char WmErrcodeOverM[]   = "WM_ERRCODE_OVER_MAX_ENTRY";
static const char WmStatecodePar[]   = "WM_STATECODE_PARENT_START";
static const char WmStatecodePar_0[] = "WM_STATECODE_PARENT_FOUND";
static const char WmErrcodeSendQ[]   = "WM_ERRCODE_SEND_QUEUE_FULL";
static const char WhSysstateMeas[]   = "WH_SYSSTATE_MEASURECHANNEL";
static const char WmStatecodeCon_0[] = "WM_STATECODE_CONNECT_START";
static const char WmErrcodeWlInv[]   = "WM_ERRCODE_WL_INVALID_PARAM";
static const char WhErrcodeParen[]   = "WH_ERRCODE_PARENT_NOT_FOUND";
static const char WmErrcodeInval_0[] = "WM_ERRCODE_INVALID_POLLBITMAP";
static const char WmStatecodePar_1[] = "WM_STATECODE_PARENT_NOT_FOUND";
static const char WmStatecodeDis_1[] = "WM_STATECODE_DISCONNECTED_FROM_MYSELF";

static const char aNA_0[] = "N/A";
static const char aS[]    = "%s -> ";
static const char aS_0[]  = "%s";
*/
#endif

NOT_DECOMPILED const char *WH__sStateNames[10];
NOT_DECOMPILED const char *WH__errnames[23];
NOT_DECOMPILED const char *WH__statenames[27];

NOT_DECOMPILED const char aNA[];
NOT_DECOMPILED const char aNA_0[];
NOT_DECOMPILED const char aS[];
NOT_DECOMPILED const char aS_0[];

NOT_DECOMPILED const char aWhCallbackforw[];
NOT_DECOMPILED const char aStartparentNew[];
NOT_DECOMPILED const char aStartparentChi[];
NOT_DECOMPILED const char aStartparentChi_0[];
NOT_DECOMPILED const char aUnknownIndicat[];
NOT_DECOMPILED const char aWhStateinstart[];
NOT_DECOMPILED const char aWhStateinendpa[];
NOT_DECOMPILED const char aWhStateinendpa_0[];
NOT_DECOMPILED const char aRecvBufferSize[];
NOT_DECOMPILED const char aSendBufferSize[];
NOT_DECOMPILED const char aWfsInitchildCa[];
NOT_DECOMPILED const char aWhStateoutstar[];
NOT_DECOMPILED const char aPictochatParen[];
NOT_DECOMPILED const char aNotMyParentGgi[];
NOT_DECOMPILED const char aNotReceiveEntr[];
NOT_DECOMPILED const char aParentFind[];
NOT_DECOMPILED const char aWhStateoutends[];
NOT_DECOMPILED const char aWhStateoutsetc[];
NOT_DECOMPILED const char aWhStateinstart_0[];
NOT_DECOMPILED const char aConnectToParen[];
NOT_DECOMPILED const char aWhStateinstart_1[];
NOT_DECOMPILED const char aDisconnectedFr[];
NOT_DECOMPILED const char aUnknownStateDS[];
NOT_DECOMPILED const char aWhStateinstart_2[];
NOT_DECOMPILED const char aWhStateoutstar_0[];
NOT_DECOMPILED const char aWhStateinsetmp[];
NOT_DECOMPILED const char aChannelDBratio[];
NOT_DECOMPILED const char aDecidedChannel[];
NOT_DECOMPILED const char aWfsInitparentC[];
NOT_DECOMPILED const char aUnknownConnect[];
NOT_DECOMPILED const char aWmNotInitializ[];
NOT_DECOMPILED const char aWhStepdatashar[];
NOT_DECOMPILED const char aAlreadyWhSysst[];
NOT_DECOMPILED const char aWhFinalizeStat[];

// --------------------
// FUNCTIONS DECLS
// --------------------

static const char *WH_GetWMErrCodeName(WMErrCode code);
static const char *WH_GetWMStateCodeName(u32 state);

static void WH_ChangeSysState(WHSysState state);
static void WH_SetError(WMErrCode error);

static void *WH_Alloc(void *arg, size_t size, void *ptr);
static void Callback_WFS(WMCallback *arg);

static BOOL WH_StateInSetParentParam(void);
static void WH_StateOutSetParentParam(void *arg);
static BOOL WH_StateInSetParentWEPKey(void);
static void WH_StateOutSetParentWEPKey(void *arg);
static BOOL WH_StateInStartParent(void);
static void WH_StateOutStartParent(void *arg);
static BOOL WH_StateInStartParentMP(void);
static void WH_StateOutStartParentMP(void *arg);
static BOOL WH_StateInStartParentKeyShare(void);
static BOOL WH_StateInEndParentKeyShare(void);
static BOOL WH_StateInEndParentMP(void);
static void WH_StateOutEndParentMP(void *arg);
static BOOL WH_StateInEndParent(void);
static void WH_StateOutEndParent(void *arg);
static BOOL WH_StateInStartScan(void);
static void WH_StateOutStartScan(void *arg);
static BOOL WH_StateInEndScan(void);
static void WH_StateOutEndScan(void *arg);
static BOOL WH_StateInSetChildWEPKey(void);
static void WH_StateOutSetChildWEPKey(void *arg);
static BOOL WH_StateInStartChild(void);
static void WH_StateOutStartChild(void *arg);
static BOOL WH_StateInStartChildMP(void);
static void WH_StateOutStartChildMP(void *arg);
static BOOL WH_StateInStartChildKeyShare(void);
static BOOL WH_StateInEndChildKeyShare(void);
static BOOL WH_StateInEndChildMP(void);
static void WH_StateOutEndChildMP(void *arg);
static BOOL WH_StateInEndChild(void);
static void WH_StateOutEndChild(void *arg);
static BOOL WH_StateInReset(void);
static void WH_StateOutReset(void *arg);
static BOOL WH_StateInSetMPData(void *data, u16 dataSize, WHSendCallbackFunc callback);
static void WH_StateOutSetMPData(void *arg);
static void WH_PortReceiveCallback(void *arg);
static void WH_StateOutEnd(void *arg);

static BOOL WH_StateInMeasureChannel(u16 channel);
static void WH_StateOutMeasureChannel(void *arg);
static WMErrCode MeasureChannel(WMCallbackFunc func, u16 channel);
static s16 SelectChannel(u16 bitmap);

static void WH_IndicateHandler(void *arg);
static BOOL WH_StateInInitialize(void);
static void WH_StateOutInitialize(void *arg);

// --------------------
// MACROS
// --------------------

#define STRINGIFY(symbol) #symbol

#define WH_TRACE_CALL                                                                                                                                                              \
    if (sTraceFunc)                                                                                                                                                                \
    sTraceFunc

#define WH_ASSERT(expression) (void)((expression) || (OS_Terminate(), 0))

#define WH_RAND_INIT(x) (sRand = (u32)(x))
#define WH_RAND()       (sRand = sRand * 69069UL + 12345)

#define WH_MATH_MIN(a, b) (((a) < (b)) ? (a) : (b))
#define WH_MATH_MAX(a, b) (((a) > (b)) ? (a) : (b))

// --------------------
// FUNCTIONS
// --------------------

const char *WH_GetWMErrCodeName(WMErrCode code)
{
    /*
        static const char *errorCodeNames[] = {
            STRINGIFY(WM_ERRCODE_SUCCESS),            // Formatting Comment
            STRINGIFY(WM_ERRCODE_FAILED),             // Formatting Comment
            STRINGIFY(WM_ERRCODE_OPERATING),          // Formatting Comment
            STRINGIFY(WM_ERRCODE_ILLEGAL_STATE),      // Formatting Comment
            STRINGIFY(WM_ERRCODE_WM_DISABLE),         // Formatting Comment
            STRINGIFY(WM_ERRCODE_NO_DATASET),         // Formatting Comment
            STRINGIFY(WM_ERRCODE_INVALID_PARAM),      // Formatting Comment
            STRINGIFY(WM_ERRCODE_NO_CHILD),           // Formatting Comment
            STRINGIFY(WM_ERRCODE_FIFO_ERROR),         // Formatting Comment
            STRINGIFY(WM_ERRCODE_TIMEOUT),            // Formatting Comment
            STRINGIFY(WM_ERRCODE_SEND_QUEUE_FULL),    // Formatting Comment
            STRINGIFY(WM_ERRCODE_NO_ENTRY),           // Formatting Comment
            STRINGIFY(WM_ERRCODE_OVER_MAX_ENTRY),     // Formatting Comment
            STRINGIFY(WM_ERRCODE_INVALID_POLLBITMAP), // Formatting Comment
            STRINGIFY(WM_ERRCODE_NO_DATA),            // Formatting Comment
            STRINGIFY(WM_ERRCODE_SEND_FAILED),        // Formatting Comment
            STRINGIFY(WM_ERRCODE_DCF_TEST),           // Formatting Comment
            STRINGIFY(WM_ERRCODE_WL_INVALID_PARAM),   // Formatting Comment
            STRINGIFY(WM_ERRCODE_WL_LENGTH_ERR),      // Formatting Comment
            STRINGIFY(WM_ERRCODE_FLASH_ERROR),        // Formatting Comment
            STRINGIFY(WH_ERRCODE_DISCONNECTED),       // Formatting Comment
            STRINGIFY(WH_ERRCODE_PARENT_NOT_FOUND),   // Formatting Comment
            STRINGIFY(WH_ERRCODE_NO_RADIO),           // Formatting Comment
        };
    */

    if (WM_ERRCODE_SUCCESS <= code && code < ARRAY_COUNT(WH__errnames))
    {
        return WH__errnames[code];
    }
    else
    {
        return aNA_0;
    }
}

const char *WH_GetWMStateCodeName(u32 state)
{
    /*
        static const char *wmStateNames[] = {
            STRINGIFY(WM_STATECODE_PARENT_START),             // Formatting Comment
            "N/A",                                            // Formatting Comment
            STRINGIFY(WM_STATECODE_BEACON_SENT),              // Formatting Comment
            STRINGIFY(WM_STATECODE_SCAN_START),               // Formatting Comment
            STRINGIFY(WM_STATECODE_PARENT_NOT_FOUND),         // Formatting Comment
            STRINGIFY(WM_STATECODE_PARENT_FOUND),             // Formatting Comment
            STRINGIFY(WM_STATECODE_CONNECT_START),            // Formatting Comment
            STRINGIFY(WM_STATECODE_CONNECTED),                // Formatting Comment
            STRINGIFY(WM_STATECODE_BEACON_LOST),              // Formatting Comment
            STRINGIFY(WM_STATECODE_DISCONNECTED),             // Formatting Comment
            STRINGIFY(WM_STATECODE_MP_START),                 // Formatting Comment
            STRINGIFY(WM_STATECODE_MPEND_IND),                // Formatting Comment
            STRINGIFY(WM_STATECODE_MP_IND),                   // Formatting Comment
            STRINGIFY(WM_STATECODE_MPACK_IND),                // Formatting Comment
            STRINGIFY(WM_STATECODE_DCF_START),                // Formatting Comment
            STRINGIFY(WM_STATECODE_DCF_IND),                  // Formatting Comment
            STRINGIFY(WM_STATECODE_BEACON_RECV),              // Formatting Comment
            STRINGIFY(WM_STATECODE_DISASSOCIATE),             // Formatting Comment
            STRINGIFY(WM_STATECODE_REASSOCIATE),              // Formatting Comment
            STRINGIFY(WM_STATECODE_AUTHENTICATE),             // Formatting Comment
            STRINGIFY(WM_STATECODE_PORT_SEND),                // Formatting Comment
            STRINGIFY(WM_STATECODE_PORT_RECV),                // Formatting Comment
            STRINGIFY(WM_STATECODE_FIFO_ERROR),               // Formatting Comment
            STRINGIFY(WM_STATECODE_INFORMATION),              // Formatting Comment
            STRINGIFY(WM_STATECODE_UNKNOWN),                  // Formatting Comment
            STRINGIFY(WM_STATECODE_PORT_INIT),                // Formatting Comment
            STRINGIFY(WM_STATECODE_DISCONNECTED_FROM_MYSELF), // Formatting Comment
        };
    */

    if (state < ARRAY_COUNT(WH__statenames))
    {
        return WH__statenames[state];
    }
    else
    {
        return aNA_0;
    }
}

void WH_ChangeSysState(WHSysState state)
{
    /*
        static const char *sysStateNames[] = {
            STRINGIFY(WH_SYSSTATE_STOP),           // Formatting Comment
            STRINGIFY(WH_SYSSTATE_IDLE),           // Formatting Comment
            STRINGIFY(WH_SYSSTATE_SCANNING),       // Formatting Comment
            STRINGIFY(WH_SYSSTATE_BUSY),           // Formatting Comment
            STRINGIFY(WH_SYSSTATE_CONNECTED),      // Formatting Comment
            STRINGIFY(WH_SYSSTATE_DATASHARING),    // Formatting Comment
            STRINGIFY(WH_SYSSTATE_KEYSHARING),     // Formatting Comment
            STRINGIFY(WH_SYSSTATE_MEASURECHANNEL), // Formatting Comment
            STRINGIFY(WH_SYSSTATE_CONNECT_FAIL),   // Formatting Comment
            STRINGIFY(WH_SYSSTATE_ERROR),          // Formatting Comment
        };
    */

    WH_TRACE_CALL(aS, WH__sStateNames[sSysState]);
    sSysState = state;
    WH_TRACE_CALL(aS_0, WH__sStateNames[sSysState]);
}

void WH_SetError(WMErrCode error)
{
    if (sSysState == WH_SYSSTATE_ERROR || sSysState == WH_SYSSTATE_FATAL)
        return;

    sErrCode = error;
}

void *WH_Alloc(void *arg, size_t size, void *ptr)
{
    if (ptr == NULL)
        return gWHAllocFunc((size + 3) & ~3);

    gWHFreeFunc(ptr);
    return NULL;
}

void Callback_WFS(WMCallback *arg)
{
    switch (arg->apiid)
    {
        case WM_APIID_START_MP: {
            WMStartMPCallback *cb = (WMStartMPCallback *)arg;
            switch (cb->state)
            {
                case WM_STATECODE_MP_START:
                    WH_TRACE_CALL(aWhCallbackforw);

                    WFS_Start();
                    break;
            }
        }
        break;
    }
}

BOOL WH_StateInSetParentParam(void)
{
    WMErrCode result;

    WH_ChangeSysState(WH_SYSSTATE_BUSY);

    result = WM_SetParentParameter(WH_StateOutSetParentParam, &sParentParam);
    if (result != WM_ERRCODE_OPERATING)
    {
        WH_SetError(result);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return FALSE;
    }

    return TRUE;
}

void WH_StateOutSetParentParam(void *arg)
{
    WMCallback *cb = (WMCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_SetError((WMErrCode)cb->errcode);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return;
    }

    if (sParentWEPKeyGenerator != NULL)
    {
        if (!WH_StateInSetParentWEPKey())
            WH_ChangeSysState(WH_SYSSTATE_ERROR);
    }
    else
    {
        if (!WH_StateInStartParent())
            WH_ChangeSysState(WH_SYSSTATE_ERROR);
    }
}

BOOL WH_StateInSetParentWEPKey(void)
{
    u16 wepmode;
    WMErrCode result;

    WH_ChangeSysState(WH_SYSSTATE_BUSY);

    wepmode = (*sParentWEPKeyGenerator)(sWEPKey, &sParentParam);
    result  = WM_SetWEPKey(WH_StateOutSetParentWEPKey, wepmode, sWEPKey);
    if (result != WM_ERRCODE_OPERATING)
    {
        WH_SetError(result);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return FALSE;
    }

    return TRUE;
}

void WH_StateOutSetParentWEPKey(void *arg)
{
    WMCallback *cb = (WMCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_SetError((WMErrCode)cb->errcode);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return;
    }

    if (!WH_StateInStartParent())
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
}

BOOL WH_StateInStartParent(void)
{
    WMErrCode result;

    if ((sSysState == WH_SYSSTATE_CONNECTED) || (sSysState == WH_SYSSTATE_KEYSHARING) || (sSysState == WH_SYSSTATE_DATASHARING))
    {
        return TRUE;
    }

    result = WM_StartParent(WH_StateOutStartParent);

    if (result != WM_ERRCODE_OPERATING)
    {
        WH_SetError(result);
        return FALSE;
    }

    sMyAid         = 0;
    sConnectBitmap = WH_BITMAP_EMPTY;

    return TRUE;
}

void WH_StateOutStartParent(void *arg)
{
    WMStartParentCallback *cb = (WMStartParentCallback *)arg;
    const u16 targetBitmap    = (u16)(1 << cb->aid);

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_SetError((WMErrCode)cb->errcode);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return;
    }

    switch (cb->state)
    {
        case WM_STATECODE_BEACON_SENT:
            break;

        case WM_STATECODE_CONNECTED:
            WH_TRACE_CALL(aStartparentNew, cb->aid);

            if (sJudgeAcceptFunc != NULL)
            {
                if (!sJudgeAcceptFunc(cb))
                {
                    WMErrCode result;

                    result = WM_Disconnect(NULL, cb->aid);
                    if (result != WM_ERRCODE_OPERATING)
                    {
                        WH_SetError(result);
                        WH_ChangeSysState(WH_SYSSTATE_ERROR);
                    }
                    break;
                }
            }

            if (sConnectMode == WH_CONNECTMODE_UNKNOWN_PARENT || sConnectMode == WH_CONNECTMODE_UNKNOWN_CHILD)
                Callback_WFS(arg);

            sConnectBitmap |= targetBitmap;
            break;

        case WM_STATECODE_DISCONNECTED:
            WH_TRACE_CALL(aStartparentChi, cb->aid);
            sConnectBitmap &= ~targetBitmap;

            Callback_WFS(arg);
            break;

        case WM_STATECODE_DISCONNECTED_FROM_MYSELF:
            WH_TRACE_CALL(aStartparentChi_0, cb->aid);
            break;

        case WM_STATECODE_PARENT_START:
            if (!WH_StateInStartParentMP())
                WH_ChangeSysState(WH_SYSSTATE_ERROR);
            break;

        default:
            WH_TRACE_CALL(aUnknownIndicat, cb->state);
            break;
    }
}

BOOL WH_StateInStartParentMP(void)
{
    WMErrCode result;

    if (sSysState == WH_SYSSTATE_CONNECTED || (s32)sSysState == WH_SYSSTATE_KEYSHARING || sSysState == WH_SYSSTATE_DATASHARING)
        return TRUE;

    WH_ChangeSysState(WH_SYSSTATE_CONNECTED);
    result = WM_StartMP(WH_StateOutStartParentMP, (u16 *)sRecvBuffer, (u16)sRecvBufferSize, (u16 *)sSendBuffer, (u16)sSendBufferSize,
                        sParentParam.CS_Flag != 0 ? WH_MPFREQ_CONTIGUOUS : WH_MPFREQ_ONCE_PER_FRAME);

    if (result != WM_ERRCODE_OPERATING)
    {
        WH_SetError(result);
        return FALSE;
    }

    return TRUE;
}

NONMATCH_FUNC void WH_StateOutStartParentMP(void *arg)
{
    // https://decomp.me/scratch/HVtH1 -> 81.53%
#ifdef NON_MATCHING
    WMstartMPCallback *cb = (WMstartMPCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_SetError((WMErrCode)cb->errcode);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return;
    }

    switch (cb->state)
    {
        case WM_STATECODE_MP_START:
            if (sConnectMode == WH_CONNECTMODE_KS_PARENT)
            {
                if (sSysState == WH_SYSSTATE_CONNECTED)
                {
                    if (!WH_StateInStartParentKeyShare())
                    {
                        WH_TRACE_CALL(aWhStateinstart);
                        WH_ChangeSysState(WH_SYSSTATE_ERROR);
                    }
                    return;
                }
                else if (sSysState == WH_SYSSTATE_KEYSHARING)
                {
                    return;
                }
            }
            else if (sConnectMode == WH_CONNECTMODE_DS_PARENT)
            {
                WMErrCode result;

                u16 aidBitmap = ((1 << (gWHMaxChildCount + 1)) - 1);
                result        = WM_StartDataSharing(&sWMDataSharingInfo, WH_DS_PORT, aidBitmap, gWHPacketSize, TRUE);

                if (result != WM_ERRCODE_SUCCESS)
                {
                    WH_SetError(result);
                    WH_ChangeSysState(WH_SYSSTATE_ERROR);
                    return;
                }
                WH_ChangeSysState(WH_SYSSTATE_DATASHARING);
                return;
            }
            else if (sConnectMode == WH_CONNECTMODE_UNKNOWN_PARENT)
            {
                Callback_WFS(arg);
            }
            else if (sConnectMode == WH_CONNECTMODE_UNKNOWN_CHILD)
            {
                Callback_WFS(arg);
            }

            WH_ChangeSysState(WH_SYSSTATE_CONNECTED);
            break;

        case WM_STATECODE_MPEND_IND:
            break;

        case WM_STATECODE_MP_IND:
        case WM_STATECODE_MPACK_IND:

        default:
            WH_TRACE_CALL(aUnknownIndicat, cb->state);
            break;
    }
#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r1, [r0, #2]
	cmp r1, #0
	beq _0206A0F4
	mov r0, r1
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A0F4:
	ldrh r1, [r0, #4]
	sub r1, r1, #0xa
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _0206A1F4
_0206A108: // jump table
	b _0206A118 // case 0
	ldmia sp!, {r3, pc} // case 1
	b _0206A1F4 // case 2
	b _0206A1F4 // case 3
_0206A118:
	ldr r2, =sChannelBusyRatio
	ldr r1, [r2, #0x2c]
	cmp r1, #2
	bne _0206A170
	ldr r0, [r2, #0x1c]
	cmp r0, #4
	bne _0206A164
	bl WH_StateInStartParentKeyShare
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, =sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A158
	ldr r0, =aWhStateinstart
	blx r1
_0206A158:
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A164:
	cmp r0, #6
	bne _0206A1E8
	ldmia sp!, {r3, pc}
_0206A170:
	cmp r1, #4
	bne _0206A1CC
	ldrh r1, [r2, #0x10]
	mov r3, #1
	ldr r0, =sWMDataSharingInfo
	add r1, r1, #1
	mov r1, r3, lsl r1
	str r3, [sp]
	sub r1, r1, #1
	mov r1, r1, lsl #0x10
	ldrh r3, [r2, #0xc]
	mov r2, r1, lsr #0x10
	mov r1, #0xd
	bl WM_StartDataSharing
	cmp r0, #0
	beq _0206A1C0
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A1C0:
	mov r0, #5
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A1CC:
	cmp r1, #6
	bne _0206A1DC
	bl Callback_WFS
	b _0206A1E8
_0206A1DC:
	cmp r1, #7
	bne _0206A1E8
	bl Callback_WFS
_0206A1E8:
	mov r0, #4
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A1F4:
	ldr r1, =sChannelBusyRatio
	ldr r2, [r1, #0x44]
	cmp r2, #0
	ldmeqia sp!, {r3, pc}
	ldrh r1, [r0, #4]
	ldr r0, =aUnknownIndicat
	blx r2
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

BOOL WH_StateInStartParentKeyShare(void)
{
    WMErrCode result;
    WH_ChangeSysState(WH_SYSSTATE_KEYSHARING);

    result = WM_StartKeySharing(&sWMKeySetBuf, WH_DS_PORT);

    if (result != WM_ERRCODE_SUCCESS)
    {
        WH_SetError(result);
        return FALSE;
    }

    return TRUE;
}

BOOL WH_StateInEndParentKeyShare(void)
{
    WMErrCode result;

    result = WM_EndKeySharing(&sWMKeySetBuf);

    if (result != WM_ERRCODE_SUCCESS)
    {
        WH_SetError(result);
        return FALSE;
    }

    if (!WH_StateInEndParentMP())
    {
        WH_TRACE_CALL(aWhStateinendpa);
        WH_Reset();
        return FALSE;
    }

    return TRUE;
}

BOOL WH_StateInEndParentMP(void)
{
    WMErrCode result;

    WH_ChangeSysState(WH_SYSSTATE_BUSY);

    result = WM_EndMP(WH_StateOutEndParentMP);
    if (result != WM_ERRCODE_OPERATING)
    {
        WH_SetError(result);
        return FALSE;
    }

    return TRUE;
}

void WH_StateOutEndParentMP(void *arg)
{
    WMCallback *cb = (WMCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_SetError((WMErrCode)cb->errcode);
        WH_Reset();
        return;
    }

    if (!WH_StateInEndParent())
    {
        WH_TRACE_CALL(aWhStateinendpa_0);
        WH_Reset();
        return;
    }
}

BOOL WH_StateInEndParent(void)
{
    WMErrCode result;

    result = WM_EndParent(WH_StateOutEndParent);
    if (result != WM_ERRCODE_OPERATING)
    {
        WH_SetError(result);
        return FALSE;
    }

    return TRUE;
}

void WH_StateOutEndParent(void *arg)
{
    WMCallback *cb = (WMCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_SetError((WMErrCode)cb->errcode);
        return;
    }

    WH_ChangeSysState(WH_SYSSTATE_IDLE);
}

BOOL WH_ChildConnectAuto(WHStartScanCallbackFunc callback, WHConnectMode mode, const u8 *macAddr, u16 channel)
{
    if (mode == WH_CONNECTMODE_UNKNOWN_CHILD)
    {
        sSendBufferSize = WH_MATH_MAX((sParentPacketSize + 35) & ~0x1F, (sChildPacketSize + 33) & ~0x1F);

        sRecvBufferSize = WH_MATH_MAX(2 * (((sChildPacketSize + 14) * gWHMaxChildCount + 41) & ~0x1F), 2 * ((sParentPacketSize + 85) & ~0x1F));
    }
    else
    {
        sRecvBufferSize = 2 * ((gWHPacketSize * (gWHMaxChildCount + 1) + 89) & ~0x1F);
        sSendBufferSize = (gWHPacketSize + 33) & ~0x1F;
    }

    WH_TRACE_CALL(aRecvBufferSize, sRecvBufferSize);
    WH_TRACE_CALL(aSendBufferSize, sSendBufferSize);

    WH_ChangeSysState(WH_SYSSTATE_SCANNING);

    sBssDesc.channel               = 1;
    *(u16 *)(&sScanParam.bssid[4]) = *(u16 *)(macAddr + 4);
    *(u16 *)(&sScanParam.bssid[2]) = *(u16 *)(macAddr + 2);
    *(u16 *)(&sScanParam.bssid[0]) = *(u16 *)(macAddr + 0);

    sConnectMode = mode;

    sScanCallback      = callback;
    sChannelIndex      = channel;
    sScanParam.channel = 0;
    sAutoConnectFlag   = TRUE;

    if (mode == WH_CONNECTMODE_UNKNOWN_CHILD)
    {
        WH_TRACE_CALL(aWfsInitchildCa);
        WFS_InitChild(1, NULL, WH_Alloc, NULL);
        WFS_SetDebugMode(TRUE);
    }

    if (!WH_StateInStartScan())
    {
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return FALSE;
    }

    return TRUE;
}

BOOL WH_StartScan(WHStartScanCallbackFunc callback, const u8 *macAddr, u16 channel)
{
    WH_ASSERT(sSysState == WH_SYSSTATE_IDLE);

    WH_ChangeSysState(WH_SYSSTATE_SCANNING);

    sScanCallback      = callback;
    sChannelIndex      = channel;
    sScanParam.channel = 0;
    sAutoConnectFlag   = FALSE;

    *(u16 *)(&sScanParam.bssid[4]) = *(u16 *)(macAddr + 4);
    *(u16 *)(&sScanParam.bssid[2]) = *(u16 *)(macAddr + 2);
    *(u16 *)(&sScanParam.bssid[0]) = *(u16 *)(macAddr);

    if (!WH_StateInStartScan())
    {
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return FALSE;
    }

    return TRUE;
}

BOOL WH_StateInStartScan(void)
{
    WMErrCode result;
    u16 chanpat;

    WH_ASSERT(sSysState == WH_SYSSTATE_SCANNING);

    chanpat = WM_GetAllowedChannel();

    if (chanpat == 0x8000)
    {
        WH_SetError(WM_ERRCODE_ILLEGAL_STATE);
        return FALSE;
    }

    if (chanpat == 0)
    {
        WH_SetError((WMErrCode)WH_ERRCODE_NO_RADIO);
        return FALSE;
    }

    if (sChannelIndex == 0)
    {
        while (TRUE)
        {
            sScanParam.channel++;
            if (sScanParam.channel > 16)
            {
                sScanParam.channel = 1;
            }

            if (chanpat & (0x0001 << (sScanParam.channel - 1)))
            {
                break;
            }
        }
    }
    else
    {
        sScanParam.channel = (u16)sChannelIndex;
    }

    sScanParam.maxChannelTime = WM_GetDispersionScanPeriod();
    sScanParam.scanBuf        = &sBssDesc;
    result                    = WM_StartScan(WH_StateOutStartScan, &sScanParam);

    if (result != WM_ERRCODE_OPERATING)
    {
        WH_SetError(result);
        return FALSE;
    }

    return TRUE;
}

void WH_StateOutStartScan(void *arg)
{
    WMstartScanCallback *cb = (WMstartScanCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_SetError((WMErrCode)cb->errcode);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return;
    }

    if (sSysState != WH_SYSSTATE_SCANNING)
    {
        sAutoConnectFlag = FALSE;

        if (!WH_StateInEndScan())
            WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return;
    }

    switch (cb->state)
    {
        case WM_STATECODE_SCAN_START:
            return;

        case WM_STATECODE_PARENT_NOT_FOUND:
            break;

        case WM_STATECODE_PARENT_FOUND:
            WH_TRACE_CALL(aWhStateoutstar, cb->macAddress[0], cb->macAddress[1], cb->macAddress[2], cb->macAddress[3], cb->macAddress[4], cb->macAddress[5]);

            DC_InvalidateRange(&sBssDesc, sizeof(WMbssDesc));

            if (sPictoCatchFlag)
            {
                if (CHT_IsPictochatParent(&sBssDesc))
                {
                    WH_TRACE_CALL(aPictochatParen);

                    if (sScanCallback != NULL)
                        sScanCallback(&sBssDesc, arg);
                    break;
                }
            }

            if ((!WM_IsValidGameInfo(&cb->gameInfo, cb->gameInfoLength)) || cb->gameInfo.ggid != sParentParam.ggid)
            {
                WH_TRACE_CALL(aNotMyParentGgi);
                break;
            }

            if ((cb->gameInfo.gameNameCount_attribute & (WM_ATTR_FLAG_ENTRY | WM_ATTR_FLAG_MB)) != WM_ATTR_FLAG_ENTRY)
            {
                WH_TRACE_CALL(aNotReceiveEntr);
                break;
            }

            WH_TRACE_CALL(aParentFind);

            if (sScanCallback != NULL)
                sScanCallback(&sBssDesc, arg);

            if (sAutoConnectFlag)
            {
                if (!WH_StateInEndScan())
                    WH_ChangeSysState(WH_SYSSTATE_ERROR);
                return;
            }
            break;
    }

    if (!WH_StateInStartScan())
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
}

BOOL WH_EndScan(void)
{
    if (sSysState != WH_SYSSTATE_SCANNING)
        return FALSE;

    sAutoConnectFlag = FALSE;
    WH_ChangeSysState(WH_SYSSTATE_BUSY);
    return TRUE;
}

BOOL WH_StateInEndScan(void)
{
    WMErrCode result;

    result = WM_EndScan(WH_StateOutEndScan);
    if (result != WM_ERRCODE_OPERATING)
    {
        WH_SetError(result);
        return FALSE;
    }

    return TRUE;
}

void WH_StateOutEndScan(void *arg)
{
    WMCallback *cb = (WMCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_SetError((WMErrCode)cb->errcode);
        return;
    }

    WH_ChangeSysState(WH_SYSSTATE_IDLE);

    if (!sAutoConnectFlag)
        return;

    if (sChildWEPKeyGenerator != NULL)
    {
        if (!WH_StateInSetChildWEPKey())
        {
            WH_ChangeSysState(WH_SYSSTATE_ERROR);
        }
    }
    else
    {
        if (!WH_StateInStartChild())
        {
            WH_TRACE_CALL(aWhStateoutends);
            WH_ChangeSysState(WH_SYSSTATE_ERROR);
        }
    }
}

BOOL WH_StateInSetChildWEPKey(void)
{
    u16 wepmode;
    WMErrCode result;

    WH_ChangeSysState(WH_SYSSTATE_BUSY);

    wepmode = (*sChildWEPKeyGenerator)(sWEPKey, &sBssDesc);
    result  = WM_SetWEPKey(WH_StateOutSetChildWEPKey, wepmode, sWEPKey);
    if (result != WM_ERRCODE_OPERATING)
    {
        WH_SetError(result);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return FALSE;
    }

    return TRUE;
}

void WH_StateOutSetChildWEPKey(void *arg)
{
    WMCallback *cb = (WMCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_SetError((WMErrCode)cb->errcode);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return;
    }

    if (!WH_StateInStartChild())
    {
        WH_TRACE_CALL(aWhStateoutsetc);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
    }
}

BOOL WH_StateInStartChild(void)
{
    WMErrCode result;

    if (sSysState == WH_SYSSTATE_CONNECTED || (s32)sSysState == WH_SYSSTATE_KEYSHARING || sSysState == WH_SYSSTATE_DATASHARING)
    {
        WH_TRACE_CALL(aWhStateinstart_0);
        return TRUE;
    }

    WH_ChangeSysState(WH_SYSSTATE_BUSY);

    result = WM_StartConnectEx(WH_StateOutStartChild, &sBssDesc, sConnectionSsid, TRUE, (u16)(sChildWEPKeyGenerator ? WM_AUTHMODE_SHARED_KEY : WM_AUTHMODE_OPEN_SYSTEM));
    if (result != WM_ERRCODE_OPERATING)
    {
        WH_SetError(result);
        return FALSE;
    }

    return TRUE;
}

void WH_StateOutStartChild(void *arg)
{
    WMStartConnectCallback *cb = (WMStartConnectCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_SetError((WMErrCode)cb->errcode);

        if (cb->errcode == WM_ERRCODE_OVER_MAX_ENTRY)
        {
            WH_ChangeSysState(WH_SYSSTATE_ERROR);
            return;
        }
        else if (cb->errcode == WM_ERRCODE_NO_ENTRY)
        {
            WH_ChangeSysState(WH_SYSSTATE_ERROR);
            return;
        }
        else if (cb->errcode == WM_ERRCODE_FAILED)
        {
            WH_ChangeSysState(WH_SYSSTATE_CONNECT_FAIL);
            return;
        }
        else
        {
            WH_ChangeSysState(WH_SYSSTATE_ERROR);
        }
        return;
    }

    if (cb->state == WM_STATECODE_BEACON_LOST)
        return;

    if (cb->state == WM_STATECODE_CONNECTED)
    {
        WH_TRACE_CALL(aConnectToParen);

        WH_ChangeSysState(WH_SYSSTATE_CONNECTED);

        if (!WH_StateInStartChildMP())
        {
            WH_TRACE_CALL(aWhStateinstart_1);
            WH_ChangeSysState(WH_SYSSTATE_BUSY);
            return;
        }

        sMyAid = cb->aid;
        return;
    }
    else if (cb->state == WM_STATECODE_CONNECT_START)
    {
        return;
    }
    else if (cb->state == WM_STATECODE_DISCONNECTED)
    {
        if (sConnectMode == WH_CONNECTMODE_UNKNOWN_CHILD)
            WFS_End();

        WH_TRACE_CALL(aDisconnectedFr);

        WH_SetError((WMErrCode)WH_ERRCODE_DISCONNECTED);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return;
    }
    else if (cb->state == WM_STATECODE_DISCONNECTED_FROM_MYSELF)
    {
        if (sConnectMode == WH_CONNECTMODE_UNKNOWN_CHILD)
            WFS_End();
        return;
    }

    WH_TRACE_CALL(aUnknownStateDS, cb->state, WH_GetWMStateCodeName(cb->state));
    WH_ChangeSysState(WH_SYSSTATE_ERROR);
}

BOOL WH_StateInStartChildMP(void)
{
    WMErrCode result;

    result = WM_StartMP(WH_StateOutStartChildMP, (u16 *)sRecvBuffer, (u16)sRecvBufferSize, (u16 *)sSendBuffer, (u16)sSendBufferSize, WH_MP_FREQUENCY);

    if (result != WM_ERRCODE_OPERATING)
    {
        WH_SetError(result);
        return FALSE;
    }

    return TRUE;
}

NONMATCH_FUNC void WH_StateOutStartChildMP(void *arg)
{
    // https://decomp.me/scratch/alzmn -> 89.79%
#ifdef NON_MATCHING
    WMstartMPCallback *cb = (WMstartMPCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        if (cb->errcode == WM_ERRCODE_SEND_FAILED)
            return;
        else if (cb->errcode == WM_ERRCODE_TIMEOUT)
            return;
        else if (cb->errcode == WM_ERRCODE_INVALID_POLLBITMAP)
            return;

        WH_SetError((WMErrCode)cb->errcode);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return;
    }

    switch (cb->state)
    {
        case WM_STATECODE_MP_START:
            if (sConnectMode == WH_CONNECTMODE_KS_CHILD)
            {
                if (sSysState == WH_SYSSTATE_KEYSHARING)
                    return;

                if (sSysState == WH_SYSSTATE_CONNECTED)
                {
                    if (!WH_StateInStartChildKeyShare())
                    {
                        WH_TRACE_CALL(aWhStateinstart_2);
                        WH_Finalize();
                    }
                    return;
                }
            }
            else if (sConnectMode == WH_CONNECTMODE_DS_CHILD)
            {
                WMErrCode result;
                u16 aidBitmap;

                aidBitmap = (u16)((1 << (gWHMaxChildCount + 1)) - 1);
                result    = WM_StartDataSharing(&sWMDataSharingInfo, WH_DS_PORT, aidBitmap, gWHPacketSize, TRUE);
                if (result != WM_ERRCODE_SUCCESS)
                {
                    WH_SetError(result);
                    WH_Finalize();
                    return;
                }

                WH_TRACE_CALL(aWhStateoutstar_0);
                WH_ChangeSysState(WH_SYSSTATE_DATASHARING);
                return;
            }
            else if (sConnectMode == WH_CONNECTMODE_UNKNOWN_CHILD)
            {
                Callback_WFS(arg);
            }

            WH_ChangeSysState(WH_SYSSTATE_CONNECTED);
            break;

        case WM_STATECODE_MP_IND:
            break;

        case WM_STATECODE_MPACK_IND:
            break;

        case WM_STATECODE_MPEND_IND:
            // fallthrough

        default:
            WH_TRACE_CALL(aUnknownIndicat, cb->state);
            break;
    }
#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldrh r1, [r0, #2]
	cmp r1, #0
	beq _0206AD44
	cmp r1, #0xf
	cmpne r1, #9
	cmpne r1, #0xd
	ldmeqia sp!, {r3, pc}
	mov r0, r1
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206AD44:
	ldrh r1, [r0, #4]
	sub r1, r1, #0xa
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _0206AE40
_0206AD58: // jump table
	b _0206AD68 // case 0
	b _0206AE40 // case 1
	ldmia sp!, {r3, pc} // case 2
	ldmia sp!, {r3, pc} // case 3
_0206AD68:
	ldr r2, =sChannelBusyRatio
	ldr r1, [r2, #0x2c]
	cmp r1, #3
	bne _0206ADB8
	ldr r0, [r2, #0x1c]
	cmp r0, #6
	ldmeqia sp!, {r3, pc}
	cmp r0, #4
	bne _0206AE34
	bl WH_StateInStartChildKeyShare
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, =sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206ADB0
	ldr r0, =aWhStateinstart_2
	blx r1
_0206ADB0:
	bl WH_Finalize
	ldmia sp!, {r3, pc}
_0206ADB8:
	cmp r1, #5
	bne _0206AE28
	ldrh r1, [r2, #0x10]
	mov r3, #1
	ldr r0, =sWMDataSharingInfo
	add r1, r1, #1
	mov r1, r3, lsl r1
	str r3, [sp]
	sub r1, r1, #1
	mov r1, r1, lsl #0x10
	ldrh r3, [r2, #0xc]
	mov r2, r1, lsr #0x10
	mov r1, #0xd
	bl WM_StartDataSharing
	cmp r0, #0
	beq _0206AE04
	bl WH_SetError
	bl WH_Finalize
	ldmia sp!, {r3, pc}
_0206AE04:
	ldr r0, =sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206AE1C
	ldr r0, =aWhStateoutstar_0
	blx r1
_0206AE1C:
	mov r0, #5
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206AE28:
	cmp r1, #7
	bne _0206AE34
	bl Callback_WFS
_0206AE34:
	mov r0, #4
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206AE40:
	ldr r1, =sChannelBusyRatio
	ldr r2, [r1, #0x44]
	cmp r2, #0
	ldmeqia sp!, {r3, pc}
	ldrh r1, [r0, #4]
	ldr r0, =aUnknownIndicat
	blx r2
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

BOOL WH_StateInStartChildKeyShare(void)
{
    WMErrCode result;

    if (sSysState == WH_SYSSTATE_KEYSHARING)
        return TRUE;

    if (sSysState != WH_SYSSTATE_CONNECTED)
        return FALSE;

    WH_ChangeSysState(WH_SYSSTATE_KEYSHARING);
    result = WM_StartKeySharing(&sWMKeySetBuf, WH_DS_PORT);

    if (result != WM_ERRCODE_SUCCESS)
    {
        WH_SetError(result);
        return FALSE;
    }

    return TRUE;
}

BOOL WH_StateInEndChildKeyShare(void)
{
    WMErrCode result;

    if (sSysState != WH_SYSSTATE_KEYSHARING)
        return FALSE;

    WH_ChangeSysState(WH_SYSSTATE_BUSY);
    result = WM_EndKeySharing(&sWMKeySetBuf);

    if (result != WM_ERRCODE_SUCCESS)
    {
        WH_SetError(result);
        return FALSE;
    }

    if (!WH_StateInEndChildMP())
        return FALSE;

    return TRUE;
}

BOOL WH_StateInEndChildMP(void)
{
    WMErrCode result;

    WH_ChangeSysState(WH_SYSSTATE_BUSY);

    result = WM_EndMP(WH_StateOutEndChildMP);
    if (result != WM_ERRCODE_OPERATING)
    {
        WH_SetError(result);
        return FALSE;
    }

    return TRUE;
}

void WH_StateOutEndChildMP(void *arg)
{
    WMCallback *cb = (WMCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_SetError((WMErrCode)cb->errcode);
        WH_Finalize();
        return;
    }

    if (!WH_StateInEndChild())
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
}

BOOL WH_StateInEndChild(void)
{
    WMErrCode result;

    WH_ChangeSysState(WH_SYSSTATE_BUSY);

    result = WM_Disconnect(WH_StateOutEndChild, 0);
    if (result != WM_ERRCODE_OPERATING)
    {
        WH_SetError(result);
        WH_Reset();
        return FALSE;
    }

    return TRUE;
}

void WH_StateOutEndChild(void *arg)
{
    WMCallback *cb = (WMCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_SetError((WMErrCode)cb->errcode);
        return;
    }

    WH_ChangeSysState(WH_SYSSTATE_IDLE);
}

BOOL WH_StateInReset(void)
{
    WMErrCode result;

    WH_ChangeSysState(WH_SYSSTATE_BUSY);

    result = WM_Reset(WH_StateOutReset);
    if (result != WM_ERRCODE_OPERATING)
    {
        WH_SetError(result);
        return FALSE;
    }

    return TRUE;
}

void WH_StateOutReset(void *arg)
{
    WMCallback *cb = (WMCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        WH_SetError((WMErrCode)cb->errcode);
    }
    else
    {
        if (sConnectMode == WH_CONNECTMODE_UNKNOWN_PARENT || sConnectMode == WH_CONNECTMODE_UNKNOWN_CHILD)
            Callback_WFS(arg);

        WH_ChangeSysState(WH_SYSSTATE_IDLE);
    }
}

BOOL WH_StateInSetMPData(void *data, u16 dataSize, WHSendCallbackFunc callback)
{
    WMErrCode result;

    DC_FlushRange(sSendBuffer, (u32)sSendBufferSize);

    result = WM_SetMPDataToPortEx(WH_StateOutSetMPData, (void *)callback, data, dataSize, 0xFFFF, WH_DATA_PORT, WH_DATA_PRIO);
    if (result != WM_ERRCODE_OPERATING)
    {
        WH_TRACE_CALL(aWhStateinsetmp, WH_GetWMErrCodeName(result));
        return FALSE;
    }

    return TRUE;
}

void WH_StateOutSetMPData(void *arg)
{
    WMPortSendCallback *cb = (WMPortSendCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS && cb->errcode != WM_ERRCODE_SEND_FAILED)
    {
        WH_SetError((WMErrCode)cb->errcode);
        return;
    }

    if (cb->arg != NULL)
    {
        WHSendCallbackFunc callback = (WHSendCallbackFunc)cb->arg;

        (*callback)(cb->errcode == WM_ERRCODE_SUCCESS);
    }

    if (sConnectMode == WH_CONNECTMODE_UNKNOWN_PARENT || sConnectMode == WH_CONNECTMODE_UNKNOWN_CHILD)
        Callback_WFS(arg);
}

void WH_PortReceiveCallback(void *arg)
{
    WMPortRecvCallback *cb = (WMPortRecvCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_SetError((WMErrCode)cb->errcode);
    }
    else if (sReceiverFunc != NULL)
    {
        if (cb->state == WM_STATECODE_PORT_INIT)
        {
        }
        if (cb->state == WM_STATECODE_PORT_RECV)
        {
            (*sReceiverFunc)(cb->aid, cb->data, cb->length);
        }
        else if (cb->state == WM_STATECODE_DISCONNECTED)
        {
            (*sReceiverFunc)(cb->aid, NULL, 0);
        }
        else if (cb->state == WM_STATECODE_DISCONNECTED_FROM_MYSELF)
        {
        }
        else if (cb->state == WM_STATECODE_CONNECTED)
        {
        }
    }
}

void WH_StateOutEnd(void *arg)
{
    WMCallback *cb = (WMCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_ChangeSysState(WH_SYSSTATE_FATAL);
        return;
    }

    WH_ChangeSysState(WH_SYSSTATE_STOP);
}

void WH_SetGgid(u32 ggid)
{
    sParentParam.ggid = ggid;
}

void WH_SetSsid(const void *ssid, u32 length)
{
    length = (u32)MATH_MIN(length, WM_SIZE_CHILD_SSID);

    MI_CpuCopy8(ssid, sConnectionSsid, length);
    MI_CpuClear8(sConnectionSsid + length, (u32)(WM_SIZE_CHILD_SSID - length));
}

void WH_SetUserGameInfo(u16 *userGameInfo, u16 length)
{
    sParentParam.userGameInfo       = userGameInfo;
    sParentParam.userGameInfoLength = length;
}

void WH_SetMaxChildCount(u16 count)
{
    gWHMaxChildCount = count;
}

void WH_SetPacketSize(u16 size)
{
    gWHPacketSize = size;
}

void WH_SetMaxParentChildSize(u16 parentSize, u16 childSize)
{
    sParentPacketSize = parentSize;
    sChildPacketSize  = childSize;
}

u16 WH_GetBitmap(void)
{
    return sConnectBitmap;
}

WHSysState WH_GetSystemState(void)
{
    return sSysState;
}

u32 WH_GetErrorCode(void)
{
    return sErrCode;
}

BOOL WH_StartMeasureChannel(void)
{
#define MAX_RATIO 100

    u32 result;
    u8 macAddr[6];

    OS_GetMacAddress(macAddr);
    WH_RAND_INIT(OS_GetVBlankCount() + *(u16 *)&macAddr[0] + *(u16 *)&macAddr[2] + *(u16 *)&macAddr[4]);
    WH_RAND();

    sChannel          = 0;
    sChannelBusyRatio = MAX_RATIO + 1;

    WH_ChangeSysState(WH_SYSSTATE_BUSY);

    result = WH_StateInMeasureChannel(1);

    if (result == WH_ERRCODE_NOMORE_CHANNEL)
    {
        WH_SetError((WMErrCode)WH_ERRCODE_NOMORE_CHANNEL);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return FALSE;
    }

    if (result != WM_ERRCODE_OPERATING)
    {
        WH_SetError((WMErrCode)result);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return FALSE;
    }

    return TRUE;

#undef MAX_RATIO
}

BOOL WH_StateInMeasureChannel(u16 channel)
{
    u16 allowedChannel;
    u16 result;

    allowedChannel = WM_GetAllowedChannel();

    if (allowedChannel == 0x8000)
    {
        WH_SetError((WMErrCode)WM_ERRCODE_ILLEGAL_STATE);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return WM_ERRCODE_ILLEGAL_STATE;
    }

    if (allowedChannel == 0)
    {
        WH_SetError((WMErrCode)WH_ERRCODE_NO_RADIO);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return WH_ERRCODE_NOMORE_CHANNEL;
    }

    while (((1 << (channel - 1)) & allowedChannel) == 0)
    {
        channel++;
        if (channel > 16)
            return WH_ERRCODE_NOMORE_CHANNEL;
    }

    result = MeasureChannel(WH_StateOutMeasureChannel, channel);
    if (result != WM_ERRCODE_OPERATING)
        return result;

    return result;
}

void WH_StateOutMeasureChannel(void *arg)
{
    u32 result;
    u16 channel;
    WMMeasureChannelCallback *cb = (WMMeasureChannelCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_SetError((WMErrCode)cb->errcode);
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return;
    }

    WH_TRACE_CALL(aChannelDBratio, cb->channel, cb->ccaBusyRatio);

    channel = cb->channel;

    if (sChannelBusyRatio > cb->ccaBusyRatio)
    {
        sChannelBusyRatio = cb->ccaBusyRatio;
        sChannelBitmap    = (u16)(1 << (channel - 1));
    }
    else if (sChannelBusyRatio == cb->ccaBusyRatio)
    {
        sChannelBitmap |= 1 << (channel - 1);
    }

    result = WH_StateInMeasureChannel(++channel);

    if (result == WH_ERRCODE_NOMORE_CHANNEL)
    {
        WH_ChangeSysState(WH_SYSSTATE_MEASURECHANNEL);
        return;
    }

    if (result != WM_ERRCODE_OPERATING)
    {
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        return;
    }
}

WMErrCode MeasureChannel(WMCallbackFunc func, u16 channel)
{
#define WH_MEASURE_TIME         30
#define WH_MEASURE_CS_OR_ED     3
#define WH_MEASURE_ED_THRESHOLD 17

    return WM_MeasureChannel(func, WH_MEASURE_CS_OR_ED, WH_MEASURE_ED_THRESHOLD, channel, WH_MEASURE_TIME);

#undef WH_MEASURE_TIME
#undef WH_MEASURE_CS_OR_ED
#undef WH_MEASURE_ED_THRESHOLD
}

u16 WH_GetMeasureChannel(void)
{
    WH_ASSERT(sSysState == WH_SYSSTATE_MEASURECHANNEL);

    WH_ChangeSysState(WH_SYSSTATE_IDLE);

    sChannel = (u16)SelectChannel(sChannelBitmap);
    WH_TRACE_CALL(aDecidedChannel, sChannel);

    return sChannel;
}

s16 SelectChannel(u16 bitmap)
{
    s16 i;
    s16 channel = 0;
    u16 num     = 0;
    u16 select;

    for (i = 0; i < 16; i++)
    {
        if (bitmap & (1 << i))
        {
            channel = (s16)(i + 1);
            num++;
        }
    }

    if (num <= 1)
        return channel;

    select = (u16)(((WH_RAND() & 0xFF) * num) / 0x100);

    channel = 1;

    for (i = 0; i < 16; i++)
    {
        if (bitmap & 1)
        {
            if (select == 0)
                return (s16)(i + 1);

            select--;
        }
        bitmap >>= 1;
    }

    return 0;
}

BOOL WH_Initialize(void)
{
    sRecvBufferSize = 0;
    sSendBufferSize = 0;

    sReceiverFunc  = NULL;
    sMyAid         = 0;
    sConnectBitmap = WH_BITMAP_EMPTY;
    sErrCode       = WM_ERRCODE_SUCCESS;

    sParentParam.userGameInfo       = NULL;
    sParentParam.userGameInfoLength = 0;

    MI_CpuClear8(sConnectionSsid, sizeof(sConnectionSsid));
    sJudgeAcceptFunc = NULL;

    MI_CpuClear8(&sWMDataSharingInfo, sizeof(sWMDataSharingInfo));
    MI_CpuClear8(&sDataSet, sizeof(sDataSet));
    MI_CpuClear8(&sWMKeySetBuf, sizeof(sWMKeySetBuf));

    if (!WH_StateInInitialize())
        return FALSE;

    return TRUE;
}

void WH_IndicateHandler(void *arg)
{
    WMindCallback *cb = (WMindCallback *)arg;

    if (cb->errcode == WM_ERRCODE_FIFO_ERROR)
    {
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        OS_Terminate();
    }
}

BOOL WH_StateInInitialize(void)
{
    WMErrCode result;

    WH_ChangeSysState(WH_SYSSTATE_BUSY);
    result = WM_Initialize(&sWmBuffer, WH_StateOutInitialize, WH_DMA_NO);

    if (result != WM_ERRCODE_OPERATING)
    {
        WH_SetError(result);
        WH_ChangeSysState(WH_SYSSTATE_FATAL);
        return FALSE;
    }

    return TRUE;
}

void WH_StateOutInitialize(void *arg)
{
    WMErrCode result;
    WMCallback *cb = (WMCallback *)arg;

    if (cb->errcode != WM_ERRCODE_SUCCESS)
    {
        WH_SetError((WMErrCode)cb->errcode);
        WH_ChangeSysState(WH_SYSSTATE_FATAL);
        return;
    }

    result = WM_SetIndCallback(WH_IndicateHandler);
    if (result != WM_ERRCODE_SUCCESS)
    {
        WH_SetError(result);
        WH_ChangeSysState(WH_SYSSTATE_FATAL);
        return;
    }

    WH_ChangeSysState(WH_SYSSTATE_IDLE);
}

BOOL WH_ParentConnect(WHConnectMode mode, u16 tgid, u16 channel)
{
    WH_ASSERT(sSysState == WH_SYSSTATE_IDLE);

    if (mode == WH_CONNECTMODE_UNKNOWN_PARENT)
    {
        sSendBufferSize = WH_MATH_MAX((sParentPacketSize + 35) & ~0x1F, (sChildPacketSize + 33) & ~0x1F);

        sRecvBufferSize = WH_MATH_MAX(2 * (((sChildPacketSize + 14) * gWHMaxChildCount + 41) & ~0x1F), 2 * ((sParentPacketSize + 85) & ~0x1F));
    }
    else
    {
        sRecvBufferSize = 2 * (((gWHPacketSize + 14) * gWHMaxChildCount + 41) & ~0x1F);
        sSendBufferSize = (gWHPacketSize * (gWHMaxChildCount + 1) + 39) & ~0x1F;
    }

    WH_TRACE_CALL(aRecvBufferSize, sRecvBufferSize);
    WH_TRACE_CALL(aSendBufferSize, sSendBufferSize);

    sConnectMode = mode;
    WH_ChangeSysState(WH_SYSSTATE_BUSY);

    sParentParam.tgid         = tgid;
    sParentParam.channel      = channel;
    sParentParam.beaconPeriod = WM_GetDispersionBeaconPeriod();
    if (mode == WH_CONNECTMODE_UNKNOWN_PARENT)
    {
        sParentParam.parentMaxSize = sParentPacketSize;
        sParentParam.childMaxSize  = sChildPacketSize;
    }
    else
    {
        sParentParam.parentMaxSize = gWHPacketSize * (gWHMaxChildCount + 1) + 4;
        sParentParam.childMaxSize  = gWHPacketSize;
    }
    sParentParam.maxEntry      = gWHMaxChildCount;
    sParentParam.CS_Flag       = mode == WH_CONNECTMODE_UNKNOWN_PARENT;
    sParentParam.multiBootFlag = 0;
    sParentParam.entryFlag     = 1;
    sParentParam.KS_Flag       = (u16)((mode == WH_CONNECTMODE_KS_PARENT) ? 1 : 0);

    switch (mode)
    {
        case WH_CONNECTMODE_UNKNOWN_PARENT:
            WH_TRACE_CALL(aWfsInitparentC);

            WFS_InitParent(1, 0, WH_Alloc, 0, sParentPacketSize, 0, 1);
            WFS_SetDebugMode(TRUE);
            WFS_EnableSync(FALSE);
            // fallthrough

        case WH_CONNECTMODE_MP_PARENT:
        case WH_CONNECTMODE_KS_PARENT:
        case WH_CONNECTMODE_DS_PARENT:
            return WH_StateInSetParentParam();

        default:
            break;
    }

    WH_TRACE_CALL(aUnknownConnect, mode);
    return FALSE;
}

BOOL WH_ChildConnect(WHConnectMode mode, WMBssDesc *bssDesc)
{
    WH_ASSERT(sSysState == WH_SYSSTATE_IDLE);

    if (mode == WH_CONNECTMODE_UNKNOWN_CHILD)
    {
        sSendBufferSize = WH_MATH_MAX((sParentPacketSize + 35) & ~0x1F, (sChildPacketSize + 33) & ~0x1F);

        sRecvBufferSize = WH_MATH_MAX(2 * (((sChildPacketSize + 14) * gWHMaxChildCount + 41) & ~0x1F), 2 * ((sParentPacketSize + 85) & ~0x1F));
    }
    else
    {
        sRecvBufferSize = 2 * ((gWHPacketSize * (gWHMaxChildCount + 1) + 89) & ~0x1F);
        sSendBufferSize = (gWHPacketSize + 33) & ~0x1F;
    }

    WH_TRACE_CALL(aRecvBufferSize, sRecvBufferSize);
    WH_TRACE_CALL(aSendBufferSize, sSendBufferSize);

    sConnectMode = mode;
    WH_ChangeSysState(WH_SYSSTATE_BUSY);

    switch (mode)
    {
        case WH_CONNECTMODE_UNKNOWN_CHILD:
            WH_TRACE_CALL(aWfsInitchildCa);

            WFS_InitChild(1, NULL, WH_Alloc, NULL);
            WFS_SetDebugMode(1);
            // fallthrough

        case WH_CONNECTMODE_MP_CHILD:
        case WH_CONNECTMODE_KS_CHILD:
        case WH_CONNECTMODE_DS_CHILD:
            MI_CpuCopy8(bssDesc, &sBssDesc, sizeof(sBssDesc));
            DC_FlushRange(&sBssDesc, sizeof(sBssDesc));
            DC_WaitWriteBufferEmpty();

            if (sChildWEPKeyGenerator != NULL)
                return WH_StateInSetChildWEPKey();
            else
                return WH_StateInStartChild();
        default:
            break;
    }

    WH_TRACE_CALL(aUnknownConnect, mode);
    return FALSE;
}

void WH_SetJudgeAcceptFunc(WHJudgeAcceptFunc func)
{
    sJudgeAcceptFunc = func;
}

void WH_SetReceiver(WHReceiverFunc func)
{
    sReceiverFunc = func;

    if (WM_SetPortCallback(WH_DATA_PORT, WH_PortReceiveCallback, NULL) != WM_ERRCODE_SUCCESS)
    {
        WH_ChangeSysState(WH_SYSSTATE_ERROR);
        WH_TRACE_CALL(aWmNotInitializ);
    }
}

void WH_SendData(void *data, u16 dataSize, WHSendCallbackFunc callback)
{
    WH_StateInSetMPData(data, dataSize, callback);
}

const void *WH_GetSharedDataAdr(u16 aid)
{
    return WM_GetSharedDataAddress(&sWMDataSharingInfo, &sDataSet, aid);
}

BOOL WH_StepDS(void *data)
{
    WMErrCode result;

    result = WM_StepDataSharing(&sWMDataSharingInfo, (u16 *)data, &sDataSet);

    if (result == WM_ERRCODE_NO_CHILD)
        return TRUE;

    if (result == WM_ERRCODE_NO_DATASET)
    {
        WH_TRACE_CALL(aWhStepdatashar);
        WH_SetError(result);
        return FALSE;
    }

    if (result != WM_ERRCODE_SUCCESS)
    {
        WH_SetError(result);
        return FALSE;
    }

    return TRUE;
}

void WH_Reset(void)
{
    WMErrCode result;

    WFS_End();

    if (sSysState == WH_SYSSTATE_DATASHARING)
    {
        result = WM_EndDataSharing(&sWMDataSharingInfo);
        if (result != WM_ERRCODE_SUCCESS)
        {
            WH_SetError(result);
        }
    }

    if (!WH_StateInReset())
        WH_ChangeSysState(WH_SYSSTATE_FATAL);
}

void WH_Finalize(void)
{
    if (sSysState == WH_SYSSTATE_IDLE)
    {
        WH_TRACE_CALL(aAlreadyWhSysst);
        return;
    }

    WH_TRACE_CALL(aWhFinalizeStat, sSysState);

    if (sSysState == WH_SYSSTATE_SCANNING)
    {
        if (!WH_EndScan())
            WH_Reset();
        return;
    }

    if ((sSysState != WH_SYSSTATE_KEYSHARING) && (sSysState != WH_SYSSTATE_DATASHARING) && (sSysState != WH_SYSSTATE_CONNECTED))
    {
        WH_ChangeSysState(WH_SYSSTATE_BUSY);
        WH_Reset();
        return;
    }

    WH_ChangeSysState(WH_SYSSTATE_BUSY);

    switch (sConnectMode)
    {
        case WH_CONNECTMODE_KS_CHILD:
            if (!WH_StateInEndChildKeyShare())
                WH_Reset();
            break;

        case WH_CONNECTMODE_UNKNOWN_CHILD:
            WFS_End();
            // fallthrough

        case WH_CONNECTMODE_DS_CHILD:
            if (WM_EndDataSharing(&sWMDataSharingInfo) != WM_ERRCODE_SUCCESS)
            {
                WH_Reset();
                break;
            }
            // fallthrough

        case WH_CONNECTMODE_MP_CHILD:
            if (!WH_StateInEndChildMP())
                WH_Reset();
            break;

        case WH_CONNECTMODE_KS_PARENT:
            if (!WH_StateInEndParentKeyShare())
                WH_Reset();
            break;

        case WH_CONNECTMODE_UNKNOWN_PARENT:
            WFS_End();
            // fallthrough

        case WH_CONNECTMODE_DS_PARENT:
            if (WM_EndDataSharing(&sWMDataSharingInfo) != WM_ERRCODE_SUCCESS)
            {
                WH_Reset();
                break;
            }
            // fallthrough

        case WH_CONNECTMODE_MP_PARENT:
            if (!WH_StateInEndParentMP())
                WH_Reset();
            break;
    }
}

BOOL WH_End(void)
{
    WH_ASSERT(sSysState == WH_SYSSTATE_IDLE);

    WH_ChangeSysState(WH_SYSSTATE_BUSY);

    if (WM_End(WH_StateOutEnd) != WM_ERRCODE_OPERATING)
    {
        WH_ChangeSysState(WH_SYSSTATE_ERROR);

        return FALSE;
    }

    return TRUE;
}

u16 WH_GetCurrentAid(void)
{
    return sMyAid;
}