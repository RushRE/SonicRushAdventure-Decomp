#ifndef NITROWIFI_WCM_H
#define NITROWIFI_WCM_H

#ifdef __cplusplus
extern "C" {
#endif

#include <nitro/types.h>
#include <nitro/wm.h>

// --------------------
// CONSTANTS
// --------------------

#define WCM_WORK_SIZE 8960

#define WCM_RESULT_SUCCESS        0
#define WCM_RESULT_FAILURE        1
#define WCM_RESULT_PROGRESS       2
#define WCM_RESULT_ACCEPT         3
#define WCM_RESULT_REJECT         4
#define WCM_RESULT_WMDISABLE      5
#define WCM_RESULT_NOT_ENOUGH_MEM 6
#define WCM_RESULT_FATAL_ERROR    7

#define WCM_PHASE_NULL           0
#define WCM_PHASE_WAIT           1
#define WCM_PHASE_WAIT_TO_IDLE   2
#define WCM_PHASE_IDLE           3
#define WCM_PHASE_IDLE_TO_WAIT   4
#define WCM_PHASE_IDLE_TO_SEARCH 5
#define WCM_PHASE_SEARCH         6
#define WCM_PHASE_SEARCH_TO_IDLE 7
#define WCM_PHASE_IDLE_TO_DCF    8
#define WCM_PHASE_DCF            9
#define WCM_PHASE_DCF_TO_IDLE    10
#define WCM_PHASE_FATAL_ERROR    11
#define WCM_PHASE_IRREGULAR      12
#define WCM_PHASE_TERMINATING    13

#define WCM_NOTIFY_COMMON        0
#define WCM_NOTIFY_STARTUP       1
#define WCM_NOTIFY_CLEANUP       2
#define WCM_NOTIFY_BEGIN_SEARCH  3
#define WCM_NOTIFY_END_SEARCH    4
#define WCM_NOTIFY_CONNECT       5
#define WCM_NOTIFY_DISCONNECT    6
#define WCM_NOTIFY_FOUND_AP      7
#define WCM_NOTIFY_SEARCH_AROUND 8
#define WCM_NOTIFY_TERMINATE     9

#define WCM_APLIST_UNLOCK 0
#define WCM_APLIST_LOCK   1

#define WCM_APLIST_MODE_IGNORE   0
#define WCM_APLIST_MODE_EXCHANGE 1

#define WCM_WEPMODE_NONE 0
#define WCM_WEPMODE_40   1
#define WCM_WEPMODE_104  2
#define WCM_WEPMODE_128  3

#define WCM_CAM_LIFETIME         80
#define WCM_BSSID_SIZE           WM_SIZE_BSSID
#define WCM_ESSID_SIZE           WM_SIZE_SSID
#define WCM_APLIST_SIZE          192
#define WCM_APLIST_EX_SIZE       16
#define WCM_APLIST_BLOCK_SIZE    (WCM_APLIST_EX_SIZE + WCM_APLIST_SIZE)
#define WCM_WEP_SIZE             WM_SIZE_WEPKEY
#define WCM_WEP_EX_SIZE          (1 + 1 + 14)
#define WCM_WEP_STRUCT_SIZE      (WCM_WEP_SIZE + WCM_WEP_EX_SIZE)
#define WCM_DCF_RECV_EXCESS_SIZE (sizeof(WMDcfRecvBuf) - 4)
#define WCM_DCF_SEND_EXCESS_SIZE 0
#define WCM_DCF_RECV_SIZE        (WM_DCF_MAX_SIZE + WCM_DCF_RECV_EXCESS_SIZE)
#define WCM_DCF_RECV_BUF_SIZE    (WCM_ROUNDUP32(WCM_DCF_RECV_SIZE))
#define WCM_DCF_SEND_BUF_SIZE    (WCM_ROUNDUP32(WM_DCF_MAX_SIZE))
#define WCM_ETC_BUF_SIZE         108
#define WCM_ADDITIONAL_RATESET   0x0003
#define WCM_CAMOUFLAGE_RATESET   0x0024

#define WCM_AID_MIN 1
#define WCM_AID_MAX 2007

#define WCM_BSSID_ANY ((void *)WCM_Bssid_Any)
#define WCM_ESSID_ANY ((void *)WCM_Essid_Any)

#define WCM_OPTION_TEST_CHANNEL   0x00008000
#define WCM_OPTION_FILTER_CHANNEL 0x00003ffe
#define WCM_OPTION_MASK_CHANNEL   (WCM_OPTION_TEST_CHANNEL | WCM_OPTION_FILTER_CHANNEL)
#define WCM_OPTION_CHANNEL_1      (WCM_OPTION_TEST_CHANNEL | 0x00000002)
#define WCM_OPTION_CHANNEL_2      (WCM_OPTION_TEST_CHANNEL | 0x00000004)
#define WCM_OPTION_CHANNEL_3      (WCM_OPTION_TEST_CHANNEL | 0x00000008)
#define WCM_OPTION_CHANNEL_4      (WCM_OPTION_TEST_CHANNEL | 0x00000010)
#define WCM_OPTION_CHANNEL_5      (WCM_OPTION_TEST_CHANNEL | 0x00000020)
#define WCM_OPTION_CHANNEL_6      (WCM_OPTION_TEST_CHANNEL | 0x00000040)
#define WCM_OPTION_CHANNEL_7      (WCM_OPTION_TEST_CHANNEL | 0x00000080)
#define WCM_OPTION_CHANNEL_8      (WCM_OPTION_TEST_CHANNEL | 0x00000100)
#define WCM_OPTION_CHANNEL_9      (WCM_OPTION_TEST_CHANNEL | 0x00000200)
#define WCM_OPTION_CHANNEL_10     (WCM_OPTION_TEST_CHANNEL | 0x00000400)
#define WCM_OPTION_CHANNEL_11     (WCM_OPTION_TEST_CHANNEL | 0x00000800)
#define WCM_OPTION_CHANNEL_12     (WCM_OPTION_TEST_CHANNEL | 0x00001000)
#define WCM_OPTION_CHANNEL_13     (WCM_OPTION_TEST_CHANNEL | 0x00002000)
#define WCM_OPTION_CHANNEL_ALL    (WCM_OPTION_TEST_CHANNEL | WCM_OPTION_FILTER_CHANNEL)
#define WCM_OPTION_CHANNEL_RDC    (WCM_OPTION_CHANNEL_1 | WCM_OPTION_CHANNEL_7 | WCM_OPTION_CHANNEL_13)

#define WCM_OPTION_TEST_POWER   0x00020000
#define WCM_OPTION_FILTER_POWER 0x00010000
#define WCM_OPTION_MASK_POWER   (WCM_OPTION_TEST_POWER | WCM_OPTION_FILTER_POWER)
#define WCM_OPTION_POWER_SAVE   (WCM_OPTION_TEST_POWER | 0x00000000)
#define WCM_OPTION_POWER_ACTIVE (WCM_OPTION_TEST_POWER | 0x00010000)

#define WCM_OPTION_TEST_AUTH       0x00080000
#define WCM_OPTION_FILTER_AUTH     0x00040000
#define WCM_OPTION_MASK_AUTH       (WCM_OPTION_TEST_AUTH | WCM_OPTION_FILTER_AUTH)
#define WCM_OPTION_AUTH_OPENSYSTEM (WCM_OPTION_TEST_AUTH | 0x00000000)
#define WCM_OPTION_AUTH_SHAREDKEY  (WCM_OPTION_TEST_AUTH | 0x00040000)

#define WCM_OPTION_TEST_SCANTYPE    0x00200000
#define WCM_OPTION_FILTER_SCANTYPE  0x00100000
#define WCM_OPTION_MASK_SCANTYPE    (WCM_OPTION_TEST_SCANTYPE | WCM_OPTION_FILTER_SCANTYPE)
#define WCM_OPTION_SCANTYPE_PASSIVE (WCM_OPTION_TEST_SCANTYPE | 0x00000000)
#define WCM_OPTION_SCANTYPE_ACTIVE  (WCM_OPTION_TEST_SCANTYPE | 0x00100000)

#define WCM_OPTION_TEST_ROUNDSCAN   0x00800000
#define WCM_OPTION_FILTER_ROUNDSCAN 0x00400000
#define WCM_OPTION_MASK_ROUNDSCAN   (WCM_OPTION_TEST_ROUNDSCAN | WCM_OPTION_FILTER_ROUNDSCAN)
#define WCM_OPTION_ROUNDSCAN_IGNORE (WCM_OPTION_TEST_ROUNDSCAN | 0x00000000)
#define WCM_OPTION_ROUNDSCAN_NOTIFY (WCM_OPTION_TEST_ROUNDSCAN | 0x00400000)

#define WCM_ROUNDUP32(_x_)   (((_x_) + 0x01f) & ~(0x01f))
#define WCM_ROUNDDOWN32(_x_) ((_x_) & ~(0x01f))
#define WCM_ROUNDUP4(_x_)    (((_x_) + 0x03) & ~(0x03))
#define WCM_ROUNDDOWN4(_x_)  ((_x_) & ~(0x03))

// --------------------
// VARIABLES
// --------------------

extern const u8 WCM_Bssid_Any[WCM_BSSID_SIZE];
extern const u8 WCM_Essid_Any[WCM_ESSID_SIZE];

// --------------------
// STRUCTS
// --------------------

typedef struct WCMConfig
{
    s32 dmano;
    void *pbdbuffer;
    s32 nbdbuffer;
    s32 nbdmode;
} WCMConfig;

typedef union WCMNoticeParameter
{
    s32 n;
    void *p;
} WCMNoticeParameter;

typedef struct WCMNotice
{
    s16 notify;
    s16 result;
    WCMNoticeParameter parameter[3];
} WCMNotice;

typedef struct WCMWepDesc
{
    u8 mode;
    u8 keyId;
    u8 key[WM_SIZE_WEPKEY];
} WCMWepDesc;

// --------------------
// TYPES
// --------------------

typedef void (*WCMNotify)(WCMNotice *arg);

// --------------------
// FUNCTIONS
// --------------------

s32 WCM_Init(void *buf, s32 len);
s32 WCM_Finish(void);

s32 WCM_StartupAsync(WCMConfig *config, WCMNotify notify);
s32 WCM_CleanupAsync(void);

s32 WCM_SearchAsync(void *bssid, void *essid, u32 option);
s32 WCM_BeginSearchAsync(void *bssid, void *essid, u32 option);
s32 WCM_EndSearchAsync(void);

s32 WCM_ConnectAsync(void *bssDesc, void *wepDesc, u32 option);
s32 WCM_DisconnectAsync(void);

s32 WCM_TerminateAsync(void);

s32 WCM_GetPhase(void);
u32 WCM_UpdateOption(u32 option);
void WCM_SetChannelScanTime(u16 msec);

s32 WCM_LockApList(s32 lock);
void WCM_ClearApList(void);
s32 WCM_CountApList(void);

WMBssDesc *WCM_PointApList(s32 index);
WMLinkLevel WCM_PointApListLinkLevel(s32 index);

BOOL WCM_CompareBssID(u8 *a, u8 *b);
WMLinkLevel WCM_GetLinkLevel(void);

BOOL WCM_IsInfrastructureNetwork(WMBssDesc *bssDesc);
BOOL WCM_IsAdhocNetwork(WMBssDesc *bssDesc);
BOOL WCM_IsPrivacyNetwork(WMBssDesc *bssDesc);
BOOL WCM_IsShortPreambleNetwork(WMBssDesc *bssDesc);
BOOL WCM_IsLongPreambleNetwork(WMBssDesc *bssDesc);
BOOL WCM_IsEssidHidden(WMBssDesc *bssDesc);

#ifdef __cplusplus
}
#endif

#endif // NITROWIFI_WCM_H