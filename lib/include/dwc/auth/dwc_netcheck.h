#ifndef DWC_NETCHECK_H
#define DWC_NETCHECK_H

#include "dwc_auth.h"

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// ENUMS
// --------------------

typedef enum
{
    DWCNETCHECK_E_NOERR,

    DWCNETCHECK_E_HTTPINITERR,
    DWCNETCHECK_E_HTTPPARSEERR,
    DWCNETCHECK_E_HTTPERR,
    DWCNETCHECK_E_MEMERR,
    DWCNETCHECK_E_AUTHINITERR,
    DWCNETCHECK_E_AUTHERR,
    DWCNETCHECK_E_302TWICE,
    DWCNETCHECK_E_CANTADDPOSTITEM,
    DWCNETCHECK_E_NASPARSEERR,

    DWCNETCHECK_E_NETUNAVAIL,
    DWCNETCHECK_E_NETAVAIL,

    DWCNETCHECK_E_MAX
} DWCNetcheckError;

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    DWCAuthAlloc alloc;
    DWCAuthFree free;

    void *bmworkarea;
} DWCNetcheckParam;

// --------------------
// FUNCTIONS
// --------------------

DWCNetcheckError DWC_Netcheck_Create(DWCNetcheckParam *param);
void DWC_Netcheck_Destroy(void);
void DWC_Netcheck_Abort(void);
void DWC_Netcheck_Join(void);
DWCNetcheckError DWC_Netcheck_GetError(void);
int DWC_Netcheck_GetReturnCode(void);
void DWC_Netcheck_SetCustomBlacklist(const char *url);
void DWC_Netcheck_SetAllow302(BOOL allow302);

#ifdef __cplusplus
}
#endif

#endif // DWC_NETCHECK_H