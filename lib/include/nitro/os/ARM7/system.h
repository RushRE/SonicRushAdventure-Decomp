#ifndef NITRO_OS_ARM7_SYSTEM_H
#define NITRO_OS_ARM7_SYSTEM_H

#include <nitro/os/systemCall.h>

#ifdef __cplusplus
extern "C" {
#endif

static inline void OS_Halt(void)
{
    SVC_Halt();
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_ARM7_SYSTEM_H
