	.include "asm/macros.inc"
	.include "global.inc"

	.text
    
    arm_func_start FontDMAControl__Init
FontDMAControl__Init: // 0x02051AF8
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear32
	mov r0, #0xff
	strb r0, [r4, #4]
	strb r0, [r4, #5]
	strb r0, [r4, #6]
	ldmia sp!, {r4, pc}
	arm_func_end FontDMAControl__Init

	arm_func_start FontDMAControl__InitWithParams
FontDMAControl__InitWithParams: // 0x02051B24
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r3
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl FontDMAControl__Release
	cmp r8, #0
	beq _02051B58
	cmp r8, #1
	beq _02051B6C
	cmp r8, #2
	beq _02051B80
	b _02051B90
_02051B58:
	ldr r0, [r7, #0]
	mov r4, #0x300
	orr r0, r0, #1
	str r0, [r7]
	b _02051B90
_02051B6C:
	ldr r0, [r7, #0]
	mov r4, #0x300
	orr r0, r0, #2
	str r0, [r7]
	b _02051B90
_02051B80:
	ldr r0, [r7, #0]
	mov r4, #0x600
	orr r0, r0, #3
	str r0, [r7]
_02051B90:
	strb r6, [r7, #4]
	mov r0, r4
	strb r5, [r7, #5]
	bl _AllocHeadHEAP_SYSTEM
	str r0, [r7, #0xc]
	mov r1, r0
	mov r2, r4
	mov r0, #0
	bl MIi_CpuClearFast
	ldr r0, [r7, #0xc]
	str r0, [r7, #8]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end FontDMAControl__InitWithParams

	arm_func_start FontDMAControl__Release
FontDMAControl__Release: // 0x02051BC0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl FontDMAControl__Func_2051C90
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _02051BDC
	bl _FreeHEAP_SYSTEM
_02051BDC:
	mov r0, r4
	bl FontDMAControl__Init
	ldmia sp!, {r4, pc}
	arm_func_end FontDMAControl__Release

	arm_func_start FontDMAControl__Func_2051BE8
FontDMAControl__Func_2051BE8: // 0x02051BE8
	strb r1, [r0, #4]
	strb r2, [r0, #5]
	bx lr
	arm_func_end FontDMAControl__Func_2051BE8

	arm_func_start FontDMAControl__Func_2051BF4
FontDMAControl__Func_2051BF4: // 0x02051BF4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	mov r8, r0
	ldrb r2, [r8, #6]
	mov r7, r1
	cmp r2, r7
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl FontDMAControl__Func_2051C90
	ldr r0, [r8, #0]
	ldrb r3, [r8, #4]
	ldr r1, _02051C8C // =_0211032C
	ldrb r2, [r8, #5]
	add r1, r1, r3, lsl #4
	tst r0, #1
	ldr r3, [r1, r2, lsl #2]
	beq _02051C54
	ldr r4, [r8, #8]
	tst r0, #2
	movne r6, #4
	addne r5, r4, #0x300
	moveq r6, #2
	addeq r5, r4, #0x180
	b _02051C6C
_02051C54:
	tst r0, #2
	beq _02051C6C
	ldr r4, [r8, #8]
	add r3, r3, #2
	add r5, r4, #0x180
	mov r6, #2
_02051C6C:
	mov r0, r7
	mov r1, r4
	mov r2, r5
	str r6, [sp]
	bl RenderCore_PrepareDMA
	strb r7, [r8, #6]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02051C8C: .word _0211032C
	arm_func_end FontDMAControl__Func_2051BF4

	arm_func_start FontDMAControl__Func_2051C90
FontDMAControl__Func_2051C90: // 0x02051C90
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrb r0, [r4, #6]
	cmp r0, #4
	ldmhsia sp!, {r4, pc}
	bl RenderCore_StopDMA
	mov r0, #0xff
	strb r0, [r4, #6]
	ldmia sp!, {r4, pc}
	arm_func_end FontDMAControl__Func_2051C90

	arm_func_start FontDMAControl__PrepareSwapBuffer
FontDMAControl__PrepareSwapBuffer: // 0x02051CB4
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #8]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldrb r0, [r0, #6]
	cmp r0, #4
	ldmhsia sp!, {r3, pc}
	bl RenderCore_PrepareDMASwapBuffer
	ldmia sp!, {r3, pc}
	arm_func_end FontDMAControl__PrepareSwapBuffer

	arm_func_start FontDMAControl__Func_2051CD8
FontDMAControl__Func_2051CD8: // 0x02051CD8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r0, [r7, #8]
	mov r6, r1
	mov r5, r2
	mov r4, r3
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldrb r0, [r7, #6]
	cmp r0, #4
	ldmhsia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r1, [r7, #0]
	tst r1, #1
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	bl RenderCore_GetDMASrc
	ldr r1, [r7, #0]
	mov r3, r0
	tst r1, #2
	beq _02051D44
	cmp r6, r5
	add r0, r3, r6, lsl #2
	ldmgtia sp!, {r3, r4, r5, r6, r7, pc}
_02051D30:
	add r6, r6, #1
	cmp r6, r5
	strh r4, [r0], #4
	ble _02051D30
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02051D44:
	sub r0, r5, r6
	add r2, r0, #1
	mov r0, r4
	add r1, r3, r6, lsl #1
	mov r2, r2, lsl #1
	bl MIi_CpuClear16
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end FontDMAControl__Func_2051CD8

	arm_func_start FontDMAControl__Func_2051D60
FontDMAControl__Func_2051D60: // 0x02051D60
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r0, [r7, #8]
	mov r6, r1
	mov r5, r2
	mov r4, r3
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldrb r0, [r7, #6]
	cmp r0, #4
	ldmhsia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r1, [r7, #0]
	tst r1, #2
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	bl RenderCore_GetDMASrc
	ldr r1, [r7, #0]
	mov r3, r0
	tst r1, #1
	beq _02051DD4
	mov r0, r6, lsl #1
	add r0, r0, #1
	cmp r6, r5
	add r0, r3, r0, lsl #1
	ldmgtia sp!, {r3, r4, r5, r6, r7, pc}
_02051DC0:
	add r6, r6, #1
	cmp r6, r5
	strh r4, [r0], #4
	ble _02051DC0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02051DD4:
	sub r0, r5, r6
	add r2, r0, #1
	mov r0, r4
	add r1, r3, r6, lsl #1
	mov r2, r2, lsl #1
	bl MIi_CpuClear16
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end FontDMAControl__Func_2051D60

	arm_func_start FontDMAControl__Func_2051DF0
FontDMAControl__Func_2051DF0: // 0x02051DF0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	ldr r0, [r8, #8]
	mov r7, r1
	mov r6, r2
	mov r5, r3
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldrb r0, [r8, #6]
	cmp r0, #4
	ldmhsia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, [r8, #0]
	tst r1, #2
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	bl RenderCore_GetDMASrc
	ldrsh r2, [sp, #0x18]
	sub r1, r6, r7
	mov r4, r0
	sub r0, r2, r5
	add r0, r0, #1
	mov r0, r0, lsl #0xc
	add r1, r1, #1
	bl FX_DivS32
	ldr r1, [r8, #0]
	mov r3, r5, lsl #0xc
	tst r1, #1
	beq _02051E8C
	mov r1, r7, lsl #1
	add r1, r1, #1
	cmp r7, r6
	add r2, r4, r1, lsl #1
	ldmgtia sp!, {r4, r5, r6, r7, r8, pc}
_02051E70:
	rsb r1, r7, r3, asr #12
	add r7, r7, #1
	cmp r7, r6
	strh r1, [r2], #4
	add r3, r3, r0
	ble _02051E70
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02051E8C:
	cmp r7, r6
	add r2, r4, r7, lsl #1
	ldmgtia sp!, {r4, r5, r6, r7, r8, pc}
_02051E98:
	rsb r1, r7, r3, asr #12
	add r7, r7, #1
	cmp r7, r6
	strh r1, [r2], #2
	add r3, r3, r0
	ble _02051E98
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end FontDMAControl__Func_2051DF0

	arm_func_start FontDMAControl__Func_2051EB4
FontDMAControl__Func_2051EB4: // 0x02051EB4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r0, [r7, #8]
	mov r5, r1
	mov r4, r2
	mov r6, r3
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldrb r0, [r7, #6]
	cmp r0, #4
	ldmhsia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r1, [r7, #0]
	tst r1, #2
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	bl RenderCore_GetDMASrc
	sub r1, r6, r5
	ldr r2, [r7, #0]
	mov r1, r1, lsl #0x10
	tst r2, #1
	mov r2, r1, asr #0x10
	beq _02051F3C
	mov r1, r5, lsl #1
	add r1, r1, #1
	cmp r5, r4
	add r1, r0, r1, lsl #1
	ldmgtia sp!, {r3, r4, r5, r6, r7, pc}
_02051F1C:
	sub r0, r2, #1
	add r5, r5, #1
	mov r0, r0, lsl #0x10
	strh r2, [r1], #4
	cmp r5, r4
	mov r2, r0, asr #0x10
	ble _02051F1C
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02051F3C:
	cmp r5, r4
	add r1, r0, r5, lsl #1
	ldmgtia sp!, {r3, r4, r5, r6, r7, pc}
_02051F48:
	sub r0, r2, #1
	add r5, r5, #1
	mov r0, r0, lsl #0x10
	strh r2, [r1], #2
	cmp r5, r4
	mov r2, r0, asr #0x10
	ble _02051F48
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end FontDMAControl__Func_2051EB4

	arm_func_start FontDMAControl__Func_2051F68
FontDMAControl__Func_2051F68: // 0x02051F68
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	str r0, [sp]
	ldr r0, [r0, #8]
	ldr r11, [sp, #0x28]
	cmp r0, #0
	ldr r0, [sp, #0x30]
	ldr r7, [sp, #0x2c]
	str r0, [sp, #0x30]
	ldr r0, [sp, #0x38]
	ldr r6, [sp, #0x34]
	ldr r5, [sp, #0x3c]
	mov r10, r1
	mov r9, r2
	mov r8, r3
	str r0, [sp, #0x38]
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp]
	ldrb r0, [r0, #6]
	cmp r0, #4
	ldmhsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp]
	ldr r1, [r1, #0]
	tst r1, #1
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020520AC // =0x000FFFFF
	and r5, r5, r1
	bl RenderCore_GetDMASrc
	ldr r1, [sp]
	ldr r1, [r1, #0]
	tst r1, #2
	beq _02052038
	cmp r10, r9
	add r4, r0, r10, lsl #2
	bgt _02052088
_02051FF0:
	mov r1, r7
	mov r0, r5, asr #0xc
	bl FontDMAControl__Func_2052174
	add r0, r0, r8, asr #12
	strh r0, [r4]
	ldr r0, [sp, #0x30]
	add r5, r5, r6
	add r8, r8, r11
	adds r7, r7, r0
	bmi _02052088
	ldr r0, [sp, #0x38]
	add r10, r10, #1
	adds r6, r6, r0
	movmi r6, #0
	cmp r10, r9
	add r4, r4, #4
	ble _02051FF0
	b _02052088
_02052038:
	cmp r10, r9
	add r4, r0, r10, lsl #1
	bgt _02052088
_02052044:
	mov r1, r7
	mov r0, r5, asr #0xc
	bl FontDMAControl__Func_2052174
	add r0, r0, r8, asr #12
	strh r0, [r4]
	ldr r0, [sp, #0x30]
	add r5, r5, r6
	add r8, r8, r11
	adds r7, r7, r0
	bmi _02052088
	ldr r0, [sp, #0x38]
	adds r6, r6, r0
	bmi _02052088
	add r10, r10, #1
	cmp r10, r9
	add r4, r4, #2
	ble _02052044
_02052088:
	cmp r10, r9
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r3, r8, lsl #4
	ldr r0, [sp]
	mov r2, r9
	and r1, r10, #0xff
	mov r3, r3, lsr #0x10
	bl FontDMAControl__Func_2051CD8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020520AC: .word 0x000FFFFF
	arm_func_end FontDMAControl__Func_2051F68

	arm_func_start FontDMAControl__Func_20520B0
FontDMAControl__Func_20520B0: // 0x020520B0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr r5, [sp, #0x3c]
	ldr r4, _02052170 // =0x000FFFFF
	mov r10, r1
	and r5, r5, r4
	add r4, r0, r10, lsl #2
	ldr r0, [sp, #0x30]
	mov r9, r2
	str r0, [sp, #0x30]
	ldr r0, [sp, #0x38]
	mov r8, r3
	cmp r10, r9
	ldr r11, [sp, #0x28]
	ldr r7, [sp, #0x2c]
	ldr r6, [sp, #0x34]
	str r0, [sp, #0x38]
	bgt _02052144
_020520F4:
	mov r1, r7
	mov r0, r5, asr #0xc
	bl FontDMAControl__Func_2052174
	add r0, r0, r8, asr #12
	ldrh r1, [r4, #0]
	mov r0, r0, lsl #0x10
	add r5, r5, r6
	add r0, r1, r0, lsr #16
	strh r0, [r4]
	ldr r0, [sp, #0x30]
	add r8, r8, r11
	adds r7, r7, r0
	bmi _02052144
	ldr r0, [sp, #0x38]
	add r10, r10, #1
	adds r6, r6, r0
	movmi r6, #0
	cmp r10, r9
	add r4, r4, #4
	ble _020520F4
_02052144:
	cmp r10, r9
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r8, asr #0xc
	mov r0, r0, lsl #0x10
_02052154:
	ldrh r1, [r4, #0]
	add r10, r10, #1
	cmp r10, r9
	add r1, r1, r0, lsr #16
	strh r1, [r4], #4
	ble _02052154
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02052170: .word 0x000FFFFF
	arm_func_end FontDMAControl__Func_20520B0

	arm_func_start FontDMAControl__Func_2052174
FontDMAControl__Func_2052174: // 0x02052174
	and r2, r0, #0xff
	cmp r2, #0x80
	rsbge r2, r2, #0xff
	cmp r2, #0x40
	ldrlt r0, _020521B8 // =_0211034C
	ldrltb r0, [r0, r2]
	blt _020521A0
	ldr r0, _020521B8 // =_0211034C
	rsb r2, r2, #0x7f
	ldrb r0, [r0, r2]
	rsb r0, r0, #0x100
_020521A0:
	sub r2, r0, #0x80
	mov r0, r1, asr #8
	mul r0, r2, r0
	mov r0, r0, lsl #4
	mov r0, r0, asr #0x10
	bx lr
	.align 2, 0
_020521B8: .word _0211034C
	arm_func_end FontDMAControl__Func_2052174

	.rodata

_0211032C: // 0x0211032C
	.word 0x4000010
	.word 0x4000014
	.word 0x4000018
	.word 0x400001C
	.word 0x4001010
	.word 0x4001014
	.word 0x4001018
	.word 0x400101C

_0211034C: // 0x0211034C
	.byte 0, 0, 0, 0, 0, 0, 1, 1, 2, 3, 3, 4, 5, 6, 7, 8, 9
	.byte 0xB, 0xC, 0xD, 0xF, 0x11, 0x12, 0x14, 0x16, 0x17, 0x19
	.byte 0x1B, 0x1D, 0x1F, 0x21, 0x24, 0x26, 0x28, 0x2A, 0x2D
	.byte 0x2F, 0x32, 0x34, 0x37, 0x3A, 0x3C, 0x3F, 0x42, 0x45
	.byte 0x47, 0x4A, 0x4D, 0x50, 0x53, 0x56, 0x59, 0x5C, 0x5F
	.byte 0x62, 0x65, 0x68, 0x6C, 0x6F, 0x72, 0x75, 0x78, 0x7B
	.byte 0x7F
