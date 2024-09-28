#ifndef NITRO_OS_ARM9_TCM_H
#define NITRO_OS_ARM9_TCM_H

#include <nitro/hw/mmap.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// FUNCTIONS
// --------------------

void OS_EnableITCM(void);
void OS_DisableITCM(void);

void OS_SetITCMParam(u32 param);
u32 OS_GetITCMParam(void);

void OS_EnableDTCM(void);
void OS_DisableDTCM(void);

void OS_SetDTCMParam(u32 param);
u32 OS_GetDTCMParam(void);

void OS_SetDTCMAddress(u32 address);
u32 OS_GetDTCMAddress(void);

// --------------------
// INLINE FUNCTIONS
// --------------------

static inline u32 OS_GetITCMAddress(void)
{
    return (u32)HW_ITCM;
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_OS_ARM9_TCM_H
