#include <nitro.h>
#include <nitro/code32.h>

#ifdef SDK_ARM9

// --------------------
// FUNCTIONS
// --------------------

asm void OS_SetIPermissionsForProtectionRegion(register u32 setMask, register u32 flags)
{
// clang-format off
    mrc p15, 0, r2, c5, c0, 2
	bic r2, r2, r0
	orr r2, r2, r1
	mcr p15, 0, r2, c5, c0, 2

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

#endif