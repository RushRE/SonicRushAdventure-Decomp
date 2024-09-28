#include <nitro.h>

// --------------------
// CONSTANTS
// --------------------

#define OSi_TCM_REGION_SIZE_MASK HW_C9_TCMR_SIZE_MASK
#define OSi_TCM_REGION_BASE_MASK HW_C9_TCMR_BASE_MASK

// --------------------
// FUNCTIONS
// --------------------

asm void OS_EnableITCM(void)
{
    // clang-format off
    mrc p15, 0, r0, c1, c0, 0
    orr r0, r0, #HW_C1_ITCM_ENABLE
    mcr p15, 0, r0, c1, c0, 0
    bx lr
    // clang-format on
}

asm void OS_DisableITCM(void)
{
    // clang-format off
    mrc p15, 0, r0, c1, c0, 0
    bic r0, r0, #HW_C1_ITCM_ENABLE
    mcr p15, 0, r0, c1, c0, 0
    bx lr
    // clang-format on
}

asm void OS_SetITCMParam(register u32 param)
{
    // clang-format off
    and r0, r0, #HW_C9_TCMR_SIZE_MASK
    mcr p15, 0, r0, c9, c1, 1
    bx lr
    // clang-format on
}

asm u32 OS_GetITCMParam(void)
{
    // clang-format off
    mrc p15, 0, r0, c9, c1, 1
    and r0, r0, #HW_C9_TCMR_SIZE_MASK
    bx lr
    // clang-format on
}

asm void OS_EnableDTCM(void)
{
    // clang-format off
    mrc p15, 0, r0, c1, c0, 0
    orr r0, r0, #HW_C1_DTCM_ENABLE
    mcr p15, 0, r0, c1, c0, 0
    bx lr
    // clang-format on
}

asm void OS_DisableDTCM(void)
{
    // clang-format off
    mrc p15, 0, r0, c1, c0, 0
    bic r0, r0, #HW_C1_DTCM_ENABLE
    mcr p15, 0, r0, c1, c0, 0
    bx lr
    // clang-format on
}

asm void OS_SetDTCMParam(register u32 param)
{
    // clang-format off
    ldr r1, = HW_C9_TCMR_BASE_MASK | HW_C9_TCMR_SIZE_MASK
    and r0, r0, r1
    mcr p15, 0, r0, c9, c1, 0
    bx lr
    // clang-format on
}

asm u32 OS_GetDTCMParam(void)
{
    // clang-format off
    mrc p15, 0, r0, c9, c1, 0
    ldr r1, = HW_C9_TCMR_BASE_MASK | HW_C9_TCMR_SIZE_MASK
    and r0, r0, r1
    bx lr
    // clang-format on
}

asm void OS_SetDTCMAddress(register u32 address)
{
    // clang-format off
    mrc p15, 0, r2, c9, c1, 0
    and r2, r2, #OSi_TCM_REGION_SIZE_MASK
    ldr r1, = OSi_TCM_REGION_BASE_MASK
    and r0, r0, r1
    orr r0, r0, r2
    mcr p15, 0, r0, c9, c1, 0
    bx lr
    // clang-format on
}

asm u32 OS_GetDTCMAddress(void)
{
    // clang-format off
    mrc p15, 0, r0, c9, c1, 0
    ldr r1, = OSi_TCM_REGION_BASE_MASK
    and r0, r0, r1
    bx lr
    // clang-format on
}

#include <nitro/codereset.h>