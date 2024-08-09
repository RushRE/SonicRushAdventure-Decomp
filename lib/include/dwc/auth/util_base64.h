#ifndef DWC_UTIL_BASE64_H
#define DWC_UTIL_BASE64_H

#include <nitro.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

int DWC_Auth_Base64Encode(const char *src, const unsigned long srclen, char *dst, const unsigned long dstlen);
int DWC_Auth_Base64Decode(const char *src, const unsigned long srclen, char *dst, const unsigned long dstlen);

#ifdef __cplusplus
}
#endif

#endif // DWC_UTIL_BASE64_H