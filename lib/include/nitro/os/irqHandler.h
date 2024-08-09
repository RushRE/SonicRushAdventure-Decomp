#ifndef NITRO_OS_IRQHANDLER_H
#define NITRO_OS_IRQHANDLER_H

#include <nitro/os/common/interrupt_shared.h>

#ifdef __cplusplus
extern "C" {
#endif

void OS_WaitIrq(BOOL clear, OSIrqMask irqFlags);

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_IRQHANDLER_H
