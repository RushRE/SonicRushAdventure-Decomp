#ifndef NITRO_OS_TICK_H
#define NITRO_OS_TICK_H

#include <nitro/os/common/tick_shared.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// VARIABLES
// --------------------

extern vu64 OSi_TickCounter;

// --------------------
// FUNCTIONS
// --------------------

void OS_InitTick(void);
BOOL OS_IsTickAvailable(void);
OSTick OS_GetTick(void);
u16 OS_GetTickLo(void);

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_TICK_H
