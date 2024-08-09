#ifndef DWC_CORE_H
#define DWC_CORE_H

#ifdef __cplusplus
extern "C" {
#endif

#include <dwc/base/dwc_connectinet.h>
#include <dwc/base/dwc_error.h>
#include <dwc/base/dwc_init.h>
#include <dwc/base/dwc_memfunc.h>
#include <dwc/base/dwc_nasfunc.h>
#include <dwc/base/dwc_report.h>

#ifndef NITRODWC_NOGS
#include <dwc/base/dwc_account.h>
#include <dwc/base/dwc_base_gamespy.h>
#include <dwc/base/dwc_common.h>
#include <dwc/base/dwc_friend.h>
#include <dwc/base/dwc_ghttp.h>
#include <dwc/base/dwc_login.h>
#include <dwc/base/dwc_match.h>
#include <dwc/base/dwc_transport.h>
#include <dwc/base/dwc_main.h>
#endif

#ifdef __cplusplus
}
#endif

#endif // DWC_CORE_H
