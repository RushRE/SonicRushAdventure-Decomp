#ifndef NITRO_CTRDG_H
#define NITRO_CTRDG_H

#include <nitro/ctrdg/common/ctrdg_common.h>

#ifdef SDK_ARM7
#include <nitro/ctrdg/ARM7/vibrate.h>
#endif // SDK_ARM7

#ifdef __cplusplus
extern "C" {
#endif

void CTRDG_Init(void);

#ifdef __cplusplus
}
#endif

#endif // NITRO_CTRDG_H
