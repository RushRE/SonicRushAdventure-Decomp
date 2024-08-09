#ifndef DWC_UTIL_WIFIIDTOOL_H
#define DWC_UTIL_WIFIIDTOOL_H

#include <nitro.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    u64 uId;
    u64 notAttestedId;
    u32 flg;
} DWCAuthWiFiId;

// --------------------
// FUNCTIONS
// --------------------

void DWC_Auth_GetId(DWCAuthWiFiId *id);
BOOL DWC_Auth_CheckPseudoWiFiID(void);
BOOL DWC_Auth_CheckWiFiIDNeedCreate(void);

#ifdef __cplusplus
}
#endif

#endif // DWC_UTIL_WIFIIDTOOL_H_
