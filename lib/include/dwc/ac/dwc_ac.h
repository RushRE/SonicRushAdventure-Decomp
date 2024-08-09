#ifndef DWC_AC_H
#define DWC_AC_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

enum
{
    DWC_AC_STATE_ERROR_FATAL = -10,
    DWC_AC_STATE_ERROR_START_UP,
    DWC_AC_STATE_ERROR_SOCKET_START,
    DWC_AC_STATE_ERROR_NETCHECK_CREATE,
    DWC_AC_STATE_ERROR_IRREGULAR,

    DWC_AC_STATE_NULL = 0,
    DWC_AC_STATE_SEARCH,
    DWC_AC_STATE_CONNECT,
    DWC_AC_STATE_TEST,
    DWC_AC_STATE_RETRY,
    DWC_AC_STATE_COMPLETE
};

enum
{
    DWC_AC_AP_TYPE_USER1,
    DWC_AC_AP_TYPE_USER2,
    DWC_AC_AP_TYPE_USER3,
    DWC_AC_AP_TYPE_USB,
    DWC_AC_AP_TYPE_SHOP,
    DWC_AC_AP_TYPE_FREESPOT,
    DWC_AC_AP_TYPE_WAYPORT,
    DWC_AC_AP_TYPE_NINTENDOWFC,
    DWC_AC_AP_TYPE_FALSE = 0xff
};

// --------------------
// STRUCTS
// --------------------

typedef struct tagDWCACApData
{
    u8 bssid[WM_SIZE_BSSID];
    u8 data[10];
} DWCACApData;

typedef struct tagDWCACOption
{
    u8 connectType;
    u8 skipNetCheck;
} DWCACOption;

typedef struct tagDWCACConfig
{
    void *(*alloc)(u32 name, s32 size);
    void (*free)(u32 name, void *ptr, s32 size);
    u8 dmaNo;
    u8 powerMode;
    DWCACOption option;
} DWCACConfig;

// --------------------
// FUNCTIONS
// --------------------

BOOL DWC_AC_Create(DWCACConfig *config);
int DWC_AC_Process(void);
int DWC_AC_GetStatus(void);
u8 DWC_AC_GetApType(void);
BOOL DWC_AC_GetApData(DWCACApData *apdata);
BOOL DWC_AC_Destroy(void);
void DWC_AC_SetSpecifyAp(const void *ssid, const void *wep, int wepMode);
BOOL DWC_AC_CheckWiFiStation(const void *ssid, u16 len);

#ifdef __cplusplus
}
#endif

#endif
