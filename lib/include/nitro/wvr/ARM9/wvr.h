#ifndef NITRO_WVR_ARM9_WVR_H
#define NITRO_WVR_ARM9_WVR_H

#ifdef __cplusplus
extern "C" {
#endif

#include <nitro/gx/gx_vramctrl.h>

// --------------------
// TYPES
// --------------------

typedef void (*WVRCallbackFunc)(void *arg, WVRResult result);

// --------------------
// FUNCTIONS
// --------------------

WVRResult WVR_StartUpAsync(GXVRamARM7 vram, WVRCallbackFunc callback, void *arg);
WVRResult WVR_TerminateAsync(WVRCallbackFunc callback, void *arg);

#ifdef __cplusplus
}
#endif

#endif // NITRO_WVR_ARM9_WVR_H