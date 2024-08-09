#ifndef DWC_UTIL_ALLOC_H
#define DWC_UTIL_ALLOC_H

#include <nitro.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// TYPES
// --------------------

typedef void *(*DWCAuthAlloc)(unsigned long name, long size);
typedef void (*DWCAuthFree)(unsigned long name, void *ptr, long size);

#ifdef __cplusplus
}
#endif

#endif // DWC_UTIL_ALLOC_H