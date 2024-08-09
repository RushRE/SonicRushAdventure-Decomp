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

void OSi_IrqCallback(s32 index);

void OSi_IrqDma0(void);
void OSi_IrqDma1(void);
void OSi_IrqDma2(void);
void OSi_IrqDma3(void);

void OSi_IrqTimer0(void);
void OSi_IrqTimer1(void);
void OSi_IrqTimer2(void);
void OSi_IrqTimer3(void);

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_IRQTABLE_H
