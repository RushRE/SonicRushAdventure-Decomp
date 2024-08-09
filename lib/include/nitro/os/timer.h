#ifndef NITRO_OS_TIMER_H
#define NITRO_OS_TIMER_H

#include <nitro/os/common/timer_shared.h>
#include <nitro/types.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void OSi_SetTimerReserved(s32 timerNum);

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_TIMER_H
