#include <nitro.h>
#include <nitro/code32.h>

#ifdef SDK_ARM9

// --------------------
// FUNCTIONS
// --------------------

asm void OS_EnableICacheForProtectionRegion(register u32 flags)
{
    // clang-format off
    mrc p15, 0, r1, c2, c0, 1
    orr r1, r1, r0
    mcr p15, 0, r1, c2, c0, 1
    bx lr
    // clang-format on
}

asm void OS_DisableICacheForProtectionRegion(register u32 flags)
{
    // clang-format off
    mrc p15, 0, r1, c2, c0, 1
    bic r1, r1, r0
    mcr p15, 0, r1, c2, c0, 1
    bx lr
    // clang-format on
}

asm u32 OS_GetICacheEnableFlagsForProtectionRegion(void)
{
    // clang-format off
    mrc p15, 0, r0, c2, c0, 1
    bx lr
    // clang-format on
}

asm void OS_SetIPermissionsForProtectionRegion(register u32 setMask, register u32 flags)
{
    // clang-format off
    mrc p15, 0, r2, c5, c0, 3
    bic r2, r2, r0
    orr r2, r2, r1
    mcr p15, 0, r2, c5, c0, 3
    bx lr
    // clang-format on
}

asm u32 OS_GetIPermissionsForProtectionRegion(void)
{
    // clang-format off
    mrc p15, 0, r0, c5, c0, 3
    bx lr
    // clang-format on
}

asm void OS_EnableDCacheForProtectionRegion(register u32 flags)
{
    // clang-format off
    mrc p15, 0, r1, c2, c0, 0
    orr r1, r1, r0
    mcr p15, 0, r1, c2, c0, 0
    bx lr
    // clang-format on
}

asm void OS_DisableDCacheForProtectionRegion(register u32 flags)
{
    // clang-format off
    mrc p15, 0, r1, c2, c0, 0
    bic r1, r1, r0
    mcr p15, 0, r1, c2, c0, 0
    bx lr
    // clang-format on
}

asm u32 OS_GetDCacheEnableFlagsForProtectionRegion(register u32 flags)
{
    // clang-format off
    mrc p15, 0, r0, c2, c0, 0
    bx lr
    // clang-format on
}

asm void OS_SetDPermissionsForProtectionRegion(register u32 setMask, register u32 flags)
{
    // clang-format off
    mrc p15, 0, r2, c5, c0, 2
    bic r2, r2, r0
    orr r2, r2, r1
    mcr p15, 0, r2, c5, c0, 2
    bx  lr
    // clang-format on
}

asm u32 OS_GetDPermissionsForProtectionRegion(void)
{
    // clang-format off
    mrc p15, 0, r0, c5, c0, 2
    bx lr
    // clang-format on
}

asm void OS_EnableWriteBufferForProtectionRegion(register u32 flags)
{
    // clang-format off
    mrc p15, 0, r1, c3, c0, 0
    orr r1, r1, r0
    mcr p15, 0, r1, c3, c0, 0
    bx lr
    // clang-format on
}

asm void OS_DisableWriteBufferForProtectionRegion(register u32 flags)
{
    // clang-format off
    mrc p15, 0, r1, c3, c0, 0
    bic r1, r1, r0
    mcr p15, 0, r1, c3, c0, 0
    bx lr
    // clang-format on
}

asm u32 OS_GetWriteBufferEnableFlagsForProtectionRegion(register u32 flags)
{
    // clang-format off
    mrc p15, 0, r0, c3, c0, 0
    bx lr
    // clang-format on
}

asm void OS_SetProtectionRegion0(u32 param)
{
    // clang-format off
    mcr p15, 0, r0, c6, c0, 0
    bx lr
    // clang-format on
}

asm void OS_SetProtectionRegion1(u32 param)
{
    // clang-format off
    mcr p15, 0, r0, c6, c1, 0
    bx lr
    // clang-format on
}

asm void OS_SetProtectionRegion2(u32 param)
{
    // clang-format off
    mcr p15, 0, r0, c6, c2, 0
    bx lr
    // clang-format on
}

asm void OS_SetProtectionRegion3(u32 param)
{
    // clang-format off
    mcr p15, 0, r0, c6, c3, 0
    bx lr
    // clang-format on
}

asm void OS_SetProtectionRegion4(u32 param)
{
    // clang-format off
    mcr p15, 0, r0, c6, c4, 0
    bx lr
    // clang-format on
}

asm void OS_SetProtectionRegion5(u32 param)
{
    // clang-format off
    mcr p15, 0, r0, c6, c5, 0
    bx lr
    // clang-format on
}

asm void OS_SetProtectionRegion6(u32 param)
{
    // clang-format off
    mcr p15, 0, r0, c6, c6, 0
    bx lr
    // clang-format on
}

asm void OS_SetProtectionRegion7(u32 param)
{
    // clang-format off
    mcr p15, 0, r0, c6, c7, 0
    bx lr
    // clang-format on
}

asm u32 OS_GetProtectionRegion0(void)
{
    // clang-format off
    mrc p15, 0, r0, c6, c0, 0
    bx lr
    // clang-format on
}

asm u32 OS_GetProtectionRegion1(void)
{
    // clang-format off
    mrc p15, 0, r0, c6, c1, 0
    bx lr
    // clang-format on
}

asm u32 OS_GetProtectionRegion2(void)
{
    // clang-format off
    mrc p15, 0, r0, c6, c2, 0
    bx lr
    // clang-format on
}

asm u32 OS_GetProtectionRegion3(void)
{
    // clang-format off
    mrc p15, 0, r0, c6, c3, 0
    bx lr
    // clang-format on
}

asm u32 OS_GetProtectionRegion4(void)
{
    // clang-format off
    mrc p15, 0, r0, c6, c4, 0
    bx lr
    // clang-format on
}

asm u32 OS_GetProtectionRegion5(void)
{
    // clang-format off
    mrc p15, 0, r0, c6, c5, 0
    bx lr
    // clang-format on
}

asm u32 OS_GetProtectionRegion6(void)
{
    // clang-format off
    mrc p15, 0, r0, c6, c6, 0
    bx lr
    // clang-format on
}

asm u32 OS_GetProtectionRegion7(void)
{
    // clang-format off
    mrc p15, 0, r0, c6, c7, 0
    bx lr
    // clang-format on
}

#endif