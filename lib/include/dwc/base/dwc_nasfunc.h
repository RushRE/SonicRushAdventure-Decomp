#ifndef DWC_NASFUNC_H
#define DWC_NASFUNC_H

#include "dwc/auth/dwc_auth.h"
#include "dwc/auth/dwc_svl.h"

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// ENUMS
// --------------------

typedef enum
{
    DWC_INGAMESN_NOT_CHECKED = DWC_AUTH_INGAMESN_NOT_CHECKED,
    DWC_INGAMESN_VALID       = DWC_AUTH_INGAMESN_VALID,
    DWC_INGAMESN_INVALID     = DWC_AUTH_INGAMESN_INVALID
} DWCIngamesnCheckResult;

typedef enum
{
    DWC_NASLOGIN_STATE_DIRTY = 0,
    DWC_NASLOGIN_STATE_IDLE,
    DWC_NASLOGIN_STATE_HTTP,
    DWC_NASLOGIN_STATE_SUCCESS,
    DWC_NASLOGIN_STATE_ERROR,
    DWC_NASLOGIN_STATE_CANCELED,
    DWC_NASLOGIN_STATE_MAX
} DWCNasLoginState;

// --------------------
// FUNCTIONS
// --------------------

DWCIngamesnCheckResult DWC_GetIngamesnCheckResult(void);
BOOL DWC_GetDateTime(RTCDate *date, RTCTime *time);

BOOL DWC_SVLGetTokenAsync(char *svl, DWCSvlResult *result);
DWCSvlState DWC_SVLProcess(void);
void DWC_SVLAbort(void);

BOOL DWC_NASLoginAsync(void);
DWCNasLoginState DWC_NASLoginProcess(void);
void DWC_NASLoginAbort(void);

#ifdef __cplusplus
}
#endif

#endif // DWC_NASFUNC_H
