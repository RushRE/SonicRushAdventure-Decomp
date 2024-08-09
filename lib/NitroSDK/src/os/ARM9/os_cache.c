#include <nitro.h>
#include <nitro/code32.h>

#ifdef SDK_ARM9

// --------------------
// FUNCTIONS
// --------------------

asm void DC_InvalidateAll(void)
{
    // clang-format off
    mov r0, #0
	mcr p15, 0, r0, c7, c6, 0

	bx lr
    // clang-format on
}

asm void DC_StoreAll(void)
{
    // clang-format off
    mov r1, #0

@1:
	mov r0, #0

@2:
	orr r2, r1, r0
	mcr p15, 0, r2, c7, c10, 2
	add r0, r0, #HW_CACHE_LINE_SIZE
	cmp r0, #HW_DCACHE_SIZE/4
	blt @2
	add r1, r1, #1<<HW_C7_CACHE_SET_NO_SHIFT
	cmp r1, #0
	bne @1

	bx lr
    // clang-format on
}

asm void DC_FlushAll(void)
{
    // clang-format off
    mov ip, #0
	mov r1, #0

@1:
	mov r0, #0

@2:
	orr r2, r1, r0
	mcr p15, 0, ip, c7, c10, 4
	mcr p15, 0, r2, c7, c14, 2
	add r0, r0, #HW_CACHE_LINE_SIZE
	cmp r0, #HW_DCACHE_SIZE/4
	blt @2
	add r1, r1, #1<<HW_C7_CACHE_SET_NO_SHIFT
	cmp r1, #0
	bne @1

	bx lr
    // clang-format on
}

asm void DC_InvalidateRange(register void *startAddr, register u32 nBytes)
{
    // clang-format off
    add r1, r1, r0
	bic r0, r0, #HW_CACHE_LINE_SIZE - 1

@1:
	mcr p15, 0, r0, c7, c6, 1
	add r0, r0, #HW_CACHE_LINE_SIZE
	cmp r0, r1
	blt @1

	bx lr
    // clang-format on
}

asm void DC_StoreRange(register const void *startAddr, register u32 nBytes)
{
    // clang-format off
    add r1, r1, r0
	bic r0, r0, #HW_CACHE_LINE_SIZE - 1

@1:
	mcr p15, 0, r0, c7, c10, 1
	add r0, r0, #HW_CACHE_LINE_SIZE
	cmp r0, r1
	blt @1

	bx lr
    // clang-format on
}

asm void DC_FlushRange(register const void *startAddr, register u32 nBytes)
{
    // clang-format off
    mov ip, #0
	add r1, r1, r0
	bic r0, r0, #HW_CACHE_LINE_SIZE - 1

@1:
	mcr p15, 0, ip, c7, c10, 4
	mcr p15, 0, r0, c7, c14, 1
	add r0, r0, #HW_CACHE_LINE_SIZE
	cmp r0, r1
	blt @1

	bx lr
    // clang-format on
}

asm void DC_WaitWriteBufferEmpty(void)
{
    // clang-format off
    mov r0, #0
	mcr p15, 0, r0, c7, c10, 4

	bx lr
    // clang-format on
}

asm void IC_InvalidateAll(void)
{
    // clang-format off
    mov r0, #0
	mcr p15, 0, r0, c7, c5, 0
    
	bx lr
    // clang-format on
}

asm void IC_InvalidateRange(register void *startAddr, register u32 nBytes)
{
    // clang-format off
    add r1, r1, r0
	bic r0, r0, #HW_CACHE_LINE_SIZE - 1

@1:
	mcr p15, 0, r0, c7, c5, 1
	add r0, r0, #HW_CACHE_LINE_SIZE
	cmp r0, r1
	blt @1

	bx lr
    // clang-format on
}

#include <nitro/codereset.h>

#endif