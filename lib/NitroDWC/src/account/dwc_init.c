#include <nitro.h>

#include <dwc/bm/dwc_bm_init.h>
#include <dwc/bm/util_wifiidtool.h>
#include <dwc/base/dwc_report.h>
#include <dwc/base/dwc_init.h>

#include <dwc/version.h>

// --------------------
// VERSION
// --------------------

#include <nitro/version_begin.h>
static char id_string[] = SDK_MIDDLEWARE_STRING("NINTENDO", DWC_VERSION_STRING);
#include <nitro/version_end.h>

// --------------------
// FUNCTION DECLS
// --------------------

extern BOOL DWCi_AUTH_MakeWiFiID(void *work);

// --------------------
// FUNCTIONS
// --------------------

int DWC_Init(void *work)
{
    int ret;
    BOOL created = FALSE;

    SDK_USING_MIDDLEWARE(id_string);

    ret = DWC_BM_Init(work);

    if (DWC_Auth_CheckWiFiIDNeedCreate())
    {
        (void)DWCi_AUTH_MakeWiFiID(work);
        created = TRUE;
    }

    if (ret < 0)
    {
        if (created)
        {
            return DWC_INIT_RESULT_DESTROY_USERID;
        }
        else
        {
            return DWC_INIT_RESULT_DESTROY_OTHER_SETTING;
        }
    }
    else if (created)
    {
        return DWC_INIT_RESULT_CREATE_USERID;
    }

    return DWC_INIT_RESULT_NOERROR;
}

u64 DWC_GetAuthenticatedUserId(void)
{
    DWCAuthWiFiId wifiid;

    DWC_Auth_GetId(&wifiid);
    return wifiid.uId;
}