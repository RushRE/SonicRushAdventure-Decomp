#include <nitro.h>
#include <nitro/code32.h>

// --------------------
// FUNCTIONS
// --------------------

asm void MI_UncompressLZ8(register const void *srcp, register void *destp)
{
    // clang-format off
    stmdb sp!, {r4, r5, r6, lr}
	ldr r5, [r0], #4
	mov r2, r5, lsr #8

@01:
	cmp r2, #0
	ble @06
	ldrb lr, [r0], #1
	mov r4, #8

@02:
	subs r4, r4, #1
	blt @01
	tst lr, #0x80
	bne @03
	ldrb r6, [r0], #1
	swpb r6, r6, [r1]
	add r1, r1, #1
	sub r2, r2, #1
	b @05

@03:
	ldrb r5, [r0, #0]
	mov r6, #3
	add r3, r6, r5, asr #4
	ldrb r6, [r0], #1
	and r5, r6, #0xf
	mov ip, r5, lsl #8
	ldrb r6, [r0], #1
	orr r5, r6, ip
	add ip, r5, #1
	sub r2, r2, r3

@04:
	ldrb r5, [r1, -ip]
	swpb r5, r5, [r1]
	add r1, r1, #1
	subs r3, r3, #1
	bgt @04

@05:
	cmp r2, #0
	movgt lr, lr, lsl #1
	bgt @02
	b @01

@06:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
    // clang-format on
}

asm void MI_UncompressLZ16(register const void *srcp, register void *destp)
{
    // clang-format off
    stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r3, #0
	ldr r8, [r0], #4
	mov r10, r8, lsr #8
	mov r2, #0

@07:
	cmp r10, #0
	ble @12
	ldrb r6, [r0], #1
	mov r7, #8

@08:
	subs r7, r7, #1
	blt @07
	tst r6, #0x80
	bne @09
	ldrb r9, [r0], #1
	orr r3, r3, r9, lsl r2
	sub r10, r10, #1
	eors r2, r2, #8
	streqh r3, [r1], #2
	moveq r3, #0
	b @11

@09:
	ldrb r9, [r0, #0]
	mov r8, #3
	add r5, r8, r9, asr #4
	ldrb r9, [r0], #1
	and r8, r9, #0xf
	mov r4, r8, lsl #8
	ldrb r9, [r0], #1
	orr r8, r9, r4
	add r4, r8, #1
	rsb r8, r2, #8
	and r9, r4, #1
	eor lr, r8, r9, lsl #3
	sub r10, r10, r5

@10:
	eor lr, lr, #8
	rsb r8, r2, #8
	add r8, r4, r8, lsr #3
	mov r8, r8, lsr #1
	mov r8, r8, lsl #1
	ldrh r9, [r1, -r8]
	mov r8, #0xff
	and r8, r9, r8, lsl lr
	mov r8, r8, asr lr
	orr r3, r3, r8, lsl r2
	eors r2, r2, #8
	streqh r3, [r1], #2
	moveq r3, #0
	subs r5, r5, #1
	bgt @10

@11:
	cmp r10, #0
	movgt r6, r6, lsl #1
	bgt @08
	b @07

@12:
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
    // clang-format on
}

asm void MI_UncompressHuffman(register const void *srcp, register void *destp)
{
    // clang-format off
    stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	add r2, r0, #4
	add r7, r2, #1
	ldrb r10, [r0, #0]
	and r4, r10, #0xf
	mov r3, #0
	mov lr, #0
	and r10, r4, #7
	add r11, r10, #4
	str r11, [sp]
	ldr r10, [r0, #0]
	mov ip, r10, lsr #8
	ldrb r10, [r2, #0]
	add r10, r10, #1
	add r0, r2, r10, lsl #1
	mov r2, r7

@13:
	cmp ip, #0
	ble @16
	mov r8, #0x20
	ldr r5, [r0], #4

@14:
	subs r8, r8, #1
	blt @13
	mov r10, #1
	and r9, r10, r5, lsr #31
	ldrb r6, [r2, #0]
	mov r6, r6, lsl r9
	mov r10, r2, lsr #1
	mov r10, r10, lsl #1
	ldrb r11, [r2, #0]
	and r11, r11, #0x3f
	add r11, r11, #1
	add r10, r10, r11, lsl #1
	add r2, r10, r9
	tst r6, #0x80
	beq @15
	mov r3, r3, lsr r4
	ldrb r10, [r2, #0]
	rsb r11, r4, #0x20
	orr r3, r3, r10, lsl r11
	mov r2, r7
	add lr, lr, #1
	ldr r11, [sp]
	cmp lr, r11
	streq r3, [r1], #4
	subeq ip, ip, #4
	moveq lr, #0

@15:
	cmp ip, #0
	movgt r5, r5, lsl #1
	bgt @14
	b @13

@16:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
    // clang-format on
}

asm void MI_UncompressRL8(register const void *srcp, register void *destp)
{
    // clang-format off
    stmdb sp!, {r4, r5, r7}
	ldmia r0!, {r3}
	mov r7, r3, lsr #8

@17:
	cmp r7, #0
	ble @21
	ldrb r4, [r0], #1
	ands r2, r4, #0x7f
	tst r4, #0x80
	bne @19
	add r2, r2, #1
	sub r7, r7, r2

@18:
	ldrb r3, [r0], #1
	swpb r3, r3, [r1]
	add r1, r1, #1
	subs r2, r2, #1
	bgt @18
	b @17

@19:
	add r2, r2, #3
	sub r7, r7, r2
	ldrb r5, [r0], #1

@20:
	swpb r4, r5, [r1]
	add r1, r1, #1
	subs r2, r2, #1
	bgt @20
	b @17

@21:
	ldmia sp!, {r4, r5, r7}
	bx lr
    // clang-format on
}

#include <nitro/code16.h>

asm void MI_UncompressRL16(register const void *srcp, register void *destp)
{
    // clang-format off
    push {r4, r5, r6, r7}
	sub sp, #0xc
	mov r7, #0
	ldmia r0!, {r3}
	lsr r5, r3, #8
	mov r4, #0
    
@22:
	cmp r5, #0
	ble @28
	ldrb r3, [r0, #0]
	str r3, [sp, #4]
	add r0, #1
	ldr r3, [sp, #4]
	lsl r2, r3, #0x19
	lsr r2, r2, #0x19
	ldr r6, [sp, #4]
	lsr r3, r6, #8
	bhs @25
	add r2, #1
	sub r5, r5, r2

@23:
	ldrb r6, [r0, #0]
	lsl r6, r4
	orr r7, r6
	add r0, #1
	mov r3, #8
	eor r4, r3
	bne @24
	strh r7, [r1]
	add r1, #2
	mov r7, #0

@24:
	sub r2, r2, #1
	bgt @23
	b @22

@25:
	add r2, #3
	sub r5, r5, r2
	ldrb r6, [r0, #0]
	str r6, [sp, #8]
	add r0, #1

@26:
	ldr r6, [sp, #8]
	lsl r6, r4
	orr r7, r6
	mov r3, #8
	eor r4, r3
	bne @27
	strh r7, [r1]
	add r1, #2
	mov r7, #0

@27:
	sub r2, r2, #1
	bgt @26
	b @22

@28:
	add sp, #0xc
	pop {r4, r5, r6, r7}
	bx lr
    // clang-format on
}

#include <nitro/code32.h>

asm void MI_UnfilterDiff8(register const void *srcp, register void *destp)
{
    // clang-format off
    stmdb sp!, {r4}
	ldmia r0, {r2}
	mov r3, #0
	and r4, r2, #0xf
	mov r2, r2, lsr #8
	cmp r4, #1
	bne @30
	add r0, r0, #3
	sub r1, r1, #1

@29:
	ldrb r4, [r0, #1]!
	subs r2, r2, #1
	add r3, r3, r4
	strb r3, [r1, #1]!
	bgt @29
	b @32

@30:
	add r0, r0, #2
	sub r1, r1, #2

@31:
	ldrh r4, [r0, #2]!
	subs r2, r2, #2
	add r3, r3, r4
	strh r3, [r1, #2]!
	bgt @31

@32:
	ldmia sp!, {r4}
	bx lr
    // clang-format on
}

asm void MI_UnfilterDiff16(register const void *srcp, register void *destp)
{
    // clang-format off
    stmdb sp!, {r4, r5}
	ldmia r0, {r2}
	mov r3, #0
	and r4, r2, #0xf
	mov r2, r2, lsr #8
	cmp r4, #1
	bne @34
	add r0, r0, #2
	sub r1, r1, #2

@33:
	ldrh r4, [r0, #2]!
	sub r2, r2, #2
	add r3, r3, r4
	and r5, r3, #0xff
	add r3, r3, r4, lsr #8
	add r5, r5, r3, lsl #8
	strh r5, [r1, #2]!
	cmp r2, #1
	bgt @33
	bne @36
	ldrh r4, [r0, #2]!
	add r3, r3, r4
	and r5, r3, #0xff
	strh r5, [r1, #2]!
	b @36

@34:
	add r0, r0, #2
	sub r1, r1, #2

@35:
	ldrh r4, [r0, #2]!
	subs r2, r2, #2
	add r3, r3, r4
	strh r3, [r1, #2]!
	bgt @35

@36:
	ldmia sp!, {r4, r5}
	bx lr
    // clang-format on
}

#include <nitro/codereset.h>