#ifndef DWC_LOGIN_H
#define DWC_LOGIN_H

#include "dwc/auth/dwc_auth.h"

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define DWC_LOGIN_AUTH_TIMEOUT      (10 * 1000)
#define DWC_LOGIN_GPCONNECT_TIMEOUT (60 * 1000)

// --------------------
// TYPES
// --------------------

typedef void (*DWCLoginCallback)(DWCError error, int profileID, void *param);

// --------------------
// ENUMS
// --------------------

typedef enum
{
    DWC_LOGIN_STATE_INIT = 0,
    DWC_LOGIN_STATE_REMOTE_AUTH,
    DWC_LOGIN_STATE_CONNECTING,
    DWC_LOGIN_STATE_GPGETINFO,
    DWC_LOGIN_STATE_GPSETINFO,
    DWC_LOGIN_STATE_CONNECTED,
    DWC_LOGIN_STATE_NUM
} DWCLoginState;

// --------------------
// STRUCTS
// --------------------

typedef struct DWCstLoginControl
{
    GPConnection *pGpObj;
    DWCLoginState state;
    int productID;
    u32 gamecode;

    const u16 *playerName;
    DWCLoginCallback callback;
    void *param;

    DWCUserData *userdata;

    void *bmwork;
    void *http;
    OSTick startTick;
    u32 connectFlag;
    OSTick connectTick;

    DWCAccLoginId tempLoginId;

    char authToken[GP_AUTHTOKEN_LEN];
    char partnerChallenge[GP_PARTNERCHALLENGE_LEN];

    char username[DWC_ACC_USERNAME_STRING_BUFSIZE];
} DWCLoginControl;

// --------------------
// FUNCTIONS
// --------------------

void DWCi_LoginInit(DWCLoginControl *logcnt, DWCUserData *userdata, GPConnection *pGpObj, int productID, u32 gamecode, const u16 *playerName, DWCLoginCallback callback,
                                       void *param);
void DWCi_LoginAsync(void);
void DWCi_LoginProcess(void);
DWCAccUserData *DWCi_GetUserData(void);
void DWCi_StopLogin(DWCError error, int errorCode);
void DWCi_ShutdownLogin(void);
BOOL DWCi_CheckLogin(void);
BOOL DWCi_GetAuthInfo(char **authToken, char **partnerChallenge);

#ifdef __cplusplus
}
#endif

#endif // DWC_LOGIN_H