#ifndef NITRO_OS_RESET_H
#define NITRO_OS_RESET_H

#include <nitro/types.h>
#include <nitro/pxi/fifo.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void OS_InitReset(void);
BOOL OS_IsResetOccurred(void);
void MicCommonCallback(PXIFifoTag tag, u32 data, BOOL err);
void OSi_SendToPxi(u16 data);

#ifdef SDK_ARM9
void OS_ResetSystem(u32 parameter);

static inline u32 OS_GetResetParameter(void)
{
    return *(u32 *)HW_RESET_PARAMETER_BUF;
}
#else
void OS_ResetSystem(void);
#endif

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_RESET_H
