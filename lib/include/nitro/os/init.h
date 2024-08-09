#ifndef NITRO_OS_INIT_H
#define NITRO_OS_INIT_H

#include <nitro/types.h>
#include <nitro/hw/consts.h>
#include <nitro/os/system.h>
#include <nitro/os/arena.h>
#include <nitro/os/alloc.h>
#include <nitro/os/reset.h>
#include <nitro/os/terminate_proc.h>
#include <nitro/os/spinLock.h>
#include <nitro/os/context.h>
#include <nitro/os/interrupt.h>
#include <nitro/os/irqTable.h>
#include <nitro/os/timer.h>
#include <nitro/os/tick.h>
#include <nitro/os/message.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void OS_Init(void);

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_INIT_H
