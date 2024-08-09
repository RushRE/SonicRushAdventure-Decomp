#ifndef NITRO_WM_H
#define NITRO_WM_H

#ifdef __cplusplus
extern "C" {
#endif

#include <nitro/wm/common/wm.h>

#ifdef SDK_ARM7
// #include <nitro/wm/ARM7/wm_sp.h>
#else // SDK_ARM9
#include <nitro/wm/ARM9/wm_api.h>
#endif

#ifdef __cplusplus
}
#endif

#endif // NITRO_WM_H