#ifndef DWC_CONNECTINET_H
#define DWC_CONNECTINET_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define DWC_SIZE_SPOTINFO 9

// --------------------
// TYPES
// --------------------

typedef void *(*DWCACAlloc)(u32 name, s32 size);
typedef void (*DWCACFree)(u32 name, void *ptr, s32 size);

// --------------------
// ENUMS
// --------------------

typedef enum
{
    DWC_CONNECTINET_STATE_NOT_INITIALIZED = 0,
    DWC_CONNECTINET_STATE_IDLE,
    DWC_CONNECTINET_STATE_OPERATING,
    DWC_CONNECTINET_STATE_OPERATED,
    DWC_CONNECTINET_STATE_CONNECTED,
    DWC_CONNECTINET_STATE_DISCONNECTING,
    DWC_CONNECTINET_STATE_DISCONNECTED,
    DWC_CONNECTINET_STATE_ERROR,
    DWC_CONNECTINET_STATE_FATAL_ERROR,

    DWC_CONNECTINET_STATE_LAST
} DWCInetResult;

typedef enum
{
    DWC_CONNECTINET_AUTH_TEST,
    DWC_CONNECTINET_AUTH_DEVELOP,
    DWC_CONNECTINET_AUTH_RELEASE,
    DWC_CONNECTINET_AUTH_LAST
} DWCInetAuthType;

typedef enum
{
    DWC_APINFO_AREA_JPN = 0,
    DWC_APINFO_AREA_USA,
    DWC_APINFO_AREA_EUR,
    DWC_APINFO_AREA_AUS,
    DWC_APINFO_AREA_UNKNOWN = 0xff
} DWCApInfoArea;

typedef enum
{
    DWC_APINFO_TYPE_USER0 = 0,
    DWC_APINFO_TYPE_USER1,
    DWC_APINFO_TYPE_USER2,
    DWC_APINFO_TYPE_USB,
    DWC_APINFO_TYPE_SHOP,
    DWC_APINFO_TYPE_FREESPOT,
    DWC_APINFO_TYPE_WAYPORT,
    DWC_APINFO_TYPE_OTHER,
    DWC_APINFO_TYPE_FALSE = 0xff
} DWCApInfoType;

// --------------------
// STRUCTS
// --------------------

typedef struct DWCstInetControl
{
    volatile int ac_state;
    u16 state;
    u16 online;
    u16 dmaNo;
    u16 powerMode;
} DWCInetControl;

typedef struct DWCstApInfo
{
    DWCApInfoType aptype;
    DWCApInfoArea area;
    char spotinfo[DWC_SIZE_SPOTINFO + 1];
    char essid[WM_SIZE_SSID + 1];
    u8 bssid[WM_SIZE_BSSID];
} DWCApInfo;

// --------------------
// FUNCTIONS
// --------------------

BOOL DWC_GetApInfo(DWCApInfo *apinfo);
void DWC_EnableHotspot(void);
BOOL DWC_CheckWiFiStation(const void *ssid, u16 len);

void DWC_InitInetEx(DWCInetControl *inetCntl, u16 dmaNo, u16 powerMode, u16 ssl_priority);
void DWC_InitInet(DWCInetControl *inetCntl);
void DWC_SetAuthServer(DWCInetAuthType type);

void DWC_ConnectInetAsync(void);
void DWC_DebugConnectInetAsync(const void *ssid, const void *wep, int wepMode);

BOOL DWC_CheckInet(void);

void DWC_ProcessInet(void);

DWCInetResult DWC_GetInetStatus(void);

void DWC_CleanupInet(void);
BOOL DWC_CleanupInetAsync(void);

BOOL DWCi_CheckDisconnected(void);
WMLinkLevel DWC_GetLinkLevel(void);
int DWC_GetUdpPacketDropNum(void);

void DWC_ForceShutdown(void);
BOOL DWC_UpdateConnection(void);

#ifdef __cplusplus
}
#endif

#endif // DWC_CONNECTINET_H