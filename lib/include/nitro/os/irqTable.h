#ifndef NITRO_OS_IRQTABLE_H
#define NITRO_OS_IRQTABLE_H

#include <nitro/hw/mmap.h>
#include <nitro/os/interrupt.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void OS_IrqDummy(void);

// OS_IrqHandler.c
void OS_IrqHandler(void);
void OS_IrqHandler_ThreadSwitch(void);

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_IRQTABLE_H
