#include <nitro.h>
#include <nitro/code32.h>

asm void MIi_CpuClear16(register u16 data, register void *destp, register u32 size)
{
    // clang-format off
    mov r3, #0

@_01:
	cmp r3, r2
	strlth r0, [r1, r3]
	addlt r3, r3, #2
	blt @_01
	bx lr
    // clang-format on
}

asm void MIi_CpuCopy16(register const void *srcp, register void *destp, register u32 size)
{
    // clang-format off
    mov r12, #0
@_01:
	cmp r12, r2
	ldrlth r3, [r0, r12]
	strlth r3, [r1, r12]
	addlt r12, r12, #2
	blt @_01
	bx lr
    // clang-format on
}

asm void MIi_CpuClear32(register u32 data, register void *destp, register u32 size)
{
    // clang-format off
    add r12, r1, r2
@_01:
	cmp r1, r12
	stmltia r1!, {r0}
	blt @_01
	bx lr
    // clang-format on
}

asm void MIi_CpuCopy32(register const void *srcp, register void *destp, register u32 size)
{
    // clang-format off
    add r12, r1, r2

@_01:
	cmp r1, r12
	ldmltia r0!, {r2}
	stmltia r1!, {r2}
	blt @_01

	bx lr
    // clang-format on
}

asm void MIi_CpuSend32(register const void *srcp, volatile void *destp, u32 size)
{
    // clang-format off
    add r12, r0, r2

@_01:
	cmp r0, r12
	ldmltia r0!, {r2}
	strlt r2, [r1]
	blt @_01

	bx lr
    // clang-format on
}

asm void MIi_CpuClearFast(register u32 data, register void *destp, register u32 size)
{
    // clang-format off
    stmdb sp!, {r4, r5, r6, r7, r8, r9}
	add r9, r1, r2
	mov r12, r2, lsr #5
	add r12, r1, r12, lsl #5
	mov r2, r0
	mov r3, r2
	mov r4, r2
	mov r5, r2
	mov r6, r2
	mov r7, r2
	mov r8, r2

@_01:
	cmp r1, r12
	stmltia r1!, {r0, r2, r3, r4, r5, r6, r7, r8}
	blt @_01

@_02:
	cmp r1, r9
	stmltia r1!, {r0}
	blt @_02
	ldmia sp!, {r4, r5, r6, r7, r8, r9}

	bx lr
    // clang-format on
}

asm void MIi_CpuCopyFast(register const void *srcp, register void *destp, register u32 size)
{
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10}
	add r10, r1, r2
	mov r12, r2, lsr #5
	add r12, r1, r12, lsl #5

@_01:
	cmp r1, r12
	ldmltia r0!, {r2, r3, r4, r5, r6, r7, r8, r9}
	stmltia r1!, {r2, r3, r4, r5, r6, r7, r8, r9}
	blt @_01

@_02:
	cmp r1, r10
	ldmltia r0!, {r2}
	stmltia r1!, {r2}
	blt @_02
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10}

	bx lr
    // clang-format on
}

asm void MI_Copy32B(register const void *pSrc, register void *pDest)
{
    // clang-format off
	ldmia r0!, {r2, r3, r12}
	stmia r1!, {r2, r3, r12}
	ldmia r0!, {r2, r3, r12}
	stmia r1!, {r2, r3, r12}
	ldmia r0!, {r2, r3}
	stmia r1!, {r2, r3}

	bx lr
    // clang-format on
}

asm void MI_Copy36B(register const void *pSrc, register void *pDest)
{
    // clang-format off
	ldmia r0!, {r2, r3, r12}
	stmia r1!, {r2, r3, r12}
	ldmia r0!, {r2, r3, r12}
	stmia r1!, {r2, r3, r12}
	ldmia r0!, {r2, r3, r12}
	stmia r1!, {r2, r3, r12}

	bx lr
    // clang-format on
}

asm void MI_Copy48B(register const void *pSrc, register void *pDest)
{
    // clang-format off
	ldmia r0!, {r2, r3, r12}
	stmia r1!, {r2, r3, r12}
	ldmia r0!, {r2, r3, r12}
	stmia r1!, {r2, r3, r12}
	ldmia r0!, {r2, r3, r12}
	stmia r1!, {r2, r3, r12}
	ldmia r0!, {r2, r3, r12}
	stmia r1!, {r2, r3, r12}

	bx lr
    // clang-format on
}

asm void MI_Copy64B(register const void *pSrc, register void *pDest)
{
    // clang-format off
	ldmia r0!, {r2, r3, r12}
	stmia r1!, {r2, r3, r12}
	ldmia r0!, {r2, r3, r12}
	stmia r1!, {r2, r3, r12}
	ldmia r0!, {r2, r3, r12}
	stmia r1!, {r2, r3, r12}
	ldmia r0!, {r2, r3, r12}
	stmia r1!, {r2, r3, r12}
	ldmia r0, {r0, r2, r3, r12}
	stmia r1!, {r0, r2, r3, r12}

	bx lr
    // clang-format on
}

asm void MI_CpuFill8(register void *dstp, register u8 data, register u32 size)
{
    // clang-format off
	cmp r2, #0
	bxeq lr
	tst r0, #1
	beq @_01
	ldrh r12, [r0, #-1]
	and r12, r12, #0xff
	orr r3, r12, r1, lsl #8
	strh r3, [r0, #-1]
	add r0, r0, #1
	subs r2, r2, #1
	bxeq lr

@_01:
	cmp r2, #2
	blo @_05
	orr r1, r1, r1, lsl #8
	tst r0, #2
	beq @_02
	strh r1, [r0], #2
	subs r2, r2, #2
	bxeq lr

@_02:
	orr r1, r1, r1, lsl #16
	bics r3, r2, #3
	beq @_04
	sub r2, r2, r3
	add r12, r3, r0

@_03:
	str r1, [r0], #4
	cmp r0, r12
	blo @_03

@_04:
	tst r2, #2
	strneh r1, [r0], #2

@_05:
	tst r2, #1
	bxeq lr
	ldrh r3, [r0, #0]
	and r3, r3, #0xff00
	and r1, r1, #0xff
	orr r1, r1, r3
	strh r1, [r0]
	bx lr
    // clang-format on
}

asm void MI_CpuCopy8(register const void *srcp, register void *dstp, register u32 size)
{
    // clang-format off
	cmp r2, #0
	bxeq lr
	tst r1, #1
	beq @_01
	ldrh r12, [r1, #-1]
	and r12, r12, #0xff
	tst r0, #1
	ldrneh r3, [r0, #-1]
	movne r3, r3, lsr #8
	ldreqh r3, [r0, #0]
	orr r3, r12, r3, lsl #8
	strh r3, [r1, #-1]
	add r0, r0, #1
	add r1, r1, #1
	subs r2, r2, #1
	bxeq lr

@_01:
	eor r12, r1, r0
	tst r12, #1
	beq @_04
	bic r0, r0, #1
	ldrh r12, [r0], #2
	mov r3, r12, lsr #8
	subs r2, r2, #2
	blo @_03

@_02:
	ldrh r12, [r0], #2
	orr r12, r3, r12, lsl #8
	strh r12, [r1], #2
	mov r3, r12, lsr #0x10
	subs r2, r2, #2
	bhs @_02

@_03:
	tst r2, #1
	bxeq lr
	ldrh r12, [r1, #0]
	and r12, r12, #0xff00
	orr r12, r12, r3
	strh r12, [r1]
	bx lr

@_04:
	tst r12, #2
	beq @_06
	bics r3, r2, #1
	beq @_10
	sub r2, r2, r3
	add r12, r3, r1

@_05:
	ldrh r3, [r0], #2
	strh r3, [r1], #2
	cmp r1, r12
	blo @_05
	b @_10

@_06:
	cmp r2, #2
	blo @_10
	tst r1, #2
	beq @_07
	ldrh r3, [r0], #2
	strh r3, [r1], #2
	subs r2, r2, #2
	bxeq lr

@_07:
	bics r3, r2, #3
	beq @_09
	sub r2, r2, r3
	add r12, r3, r1

@_08:
	ldr r3, [r0], #4
	str r3, [r1], #4
	cmp r1, r12
	blo @_08

@_09:
	tst r2, #2
	ldrneh r3, [r0], #2
	strneh r3, [r1], #2

@_10:
	tst r2, #1
	bxeq lr
	ldrh r2, [r1, #0]
	ldrh r0, [r0, #0]
	and r2, r2, #0xff00
	and r0, r0, #0xff
	orr r0, r2, r0
	strh r0, [r1]
	bx lr
    // clang-format on
}

#include <nitro/code16.h>

asm void MI_Zero36B(register void *pDest)
{
    // clang-format off
    mov r1, #0
	mov r2, #0
	mov r3, #0
	stmia r0!, {r1, r2, r3}
	stmia r0!, {r1, r2, r3}
	stmia r0!, {r1, r2, r3}

	bx lr
    // clang-format on
}

#include <nitro/codereset.h>