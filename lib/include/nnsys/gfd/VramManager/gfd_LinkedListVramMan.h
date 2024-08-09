#ifndef NNS_GFD_LINKEDLISTVRAMMAN_H
#define NNS_GFD_LINKEDLISTVRAMMAN_H

#include <nitro.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// TYPES
// --------------------

typedef void (*NNSGfdLnkDumpCallBack)(u32 addr, u32 szByte, void *pUserData);

#ifdef __cplusplus
}
#endif

#endif // NNS_GFD_LINKEDLISTVRAMMAN_H
