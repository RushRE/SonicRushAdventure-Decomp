#include <nitro.h>
#include <nitro/code32.h>

#ifdef SDK_ARM9

// --------------------
// FUNCTIONS
// --------------------

asm void OS_EnableProtectionUnit(void)
{
    // clang-format off
    mrc p15, 0, r0, c1, c0, 0
	orr r0, r0, #HW_C1_PROTECT_UNIT_ENABLE
	mcr p15, 0, r0, c1, c0, 0

	bx lr
    // clang-format on
}

asm void OS_DisableProtectionUnit(void)
{
    // clang-format off
    mrc p15, 0, r0, c1, c0, 0
	bic r0, r0, #HW_C1_PROTECT_UNIT_ENABLE
	mcr p15, 0, r0, c1, c0, 0

	bx lr
    // clang-format on
}

#include <nitro/codereset.h>

#endif