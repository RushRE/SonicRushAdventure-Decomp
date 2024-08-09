#ifndef NITRO_WVR_H
#define NITRO_WVR_H

#ifdef __cplusplus
extern "C" {
#endif

#include <nitro/wvr/common/wvr_common.h>

#ifdef SDK_ARM9
#include <nitro/wvr/ARM9/wvr.h>
#else // SDK_ARM7
// #include <nitro/wvr/ARM7/wvr_sp.h>
#endif

#ifdef __cplusplus
}
#endif

#endif // NITRO_WVR_H