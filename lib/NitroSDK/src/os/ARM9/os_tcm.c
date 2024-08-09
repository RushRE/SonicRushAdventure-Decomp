#include <nitro.h>
#include <nitro/code32.h>

#ifdef SDK_ARM9

asm void OS_GetDTCMAddress(void)
{
    // clang-format off
    mrc p15, 0, r0, c9, c1, 0
	ldr r1, =OSi_TCM_REGION_BASE_MASK
	and r0, r0, r1

	bx lr
    // clang-format on
}

#include <nitro/codereset.h>

#endif