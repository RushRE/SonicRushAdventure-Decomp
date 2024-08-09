
#include <nitro.h>

#ifdef SDK_ARM9

// --------------------
// FUNCTIONS
// --------------------

#include <nitro/code32.h>

asm void CP_SaveContext(register CPContext *context)
{
    // clang-format off
    ldr r1, =REG_DIV_NUMER_ADDR
	stmdb sp!, {r4}
	ldmia r1, {r2, r3, r4, r12}
	stmia r0!, {r2, r3, r4, r12}
	ldrh r12, [r1, #REG_DIVCNT_OFFSET - REG_DIV_NUMER_OFFSET]

	add r1, r1, #REG_SQRT_PARAM_OFFSET - REG_DIV_NUMER_OFFSET
	ldmia r1, {r2, r3}
	stmia r0!, {r2, r3}

	and r12, r12, #REG_CP_DIVCNT_MODE_MASK
	ldrh r2, [r1, #REG_SQRTCNT_OFFSET - REG_SQRT_PARAM_OFFSET]
	strh r12, [r0]
	and r2, r2, #REG_CP_SQRTCNT_MODE_MASK
	strh r2, [r0, #2]
	ldmia sp!, {r4}

	bx lr
    // clang-format on
}

asm void CPi_RestoreContext(register const CPContext *context)
{
    // clang-format off
    stmdb sp!, {r4}
	ldr r1, =REG_DIV_NUMER_ADDR
	ldmia r0, {r2, r3, r4, ip}
	stmia r1, {r2, r3, r4, ip}
	ldrh r2, [r0, #CPContext.div_mode]
	ldrh r3, [r0, #CPContext.sqrt_mode]

	strh r2, [r1, #REG_DIVCNT_OFFSET  - REG_DIV_NUMER_OFFSET]
	strh r3, [r1, #REG_SQRTCNT_OFFSET - REG_DIV_NUMER_OFFSET]

	add r0, r0, #CPContext.sqrt
	add r1, r1, #REG_SQRT_PARAM_OFFSET - REG_DIV_NUMER_OFFSET

	ldmia r0, {r2, r3}
	stmia r1, {r2, r3}
	ldmia sp!, {r4}
    
	bx lr
    // clang-format on
}

#include <nitro/codereset.h>

#endif