	.include "asm/macros.inc"
	.include "global.inc"

	.text
    
    arm_func_start Unknown2066510__LerpAngle
Unknown2066510__LerpAngle: // 0x02066510
	sub r3, r1, r0
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	cmp r3, #0x8000
	mullo r1, r3, r2
	addlo r0, r0, r1, asr #12
	movlo r0, r0, lsl #0x10
	movlo r0, r0, lsr #0x10
	bxlo lr
	sub r1, r0, r1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mul r2, r1, r2
	sub r0, r0, r2, asr #12
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bx lr
	arm_func_end Unknown2066510__LerpAngle

	arm_func_start Unknown2066510__LerpAngle2
Unknown2066510__LerpAngle2: // 0x02066554
	sub r3, r1, r0
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	cmp r3, #0x8000
	bhs _02066580
	cmp r2, r3
	addlo r0, r0, r2
	movlo r0, r0, lsl #0x10
	movlo r1, r0, lsr #0x10
	mov r0, r1
	bx lr
_02066580:
	sub r3, r0, r1
	mov r3, r3, lsl #0x10
	cmp r2, r3, lsr #16
	sublo r0, r0, r2
	movlo r0, r0, lsl #0x10
	movlo r1, r0, lsr #0x10
	mov r0, r1
	bx lr
	arm_func_end Unknown2066510__LerpAngle2

	arm_func_start Unknown2066510__LerpMtx43
Unknown2066510__LerpMtx43: // 0x020665A0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov lr, #0
	mov r4, r2, asr #0x1f
	mov r6, lr
	mov r5, #0x800
_020665B4:
	ldr ip, [r0, lr, lsl #2]
	ldr r7, [r1, lr, lsl #2]
	sub r7, r7, ip
	umull r9, r8, r7, r2
	mla r8, r7, r4, r8
	mov r7, r7, asr #0x1f
	adds r9, r9, r5
	mla r8, r7, r2, r8
	adc r7, r8, r6
	mov r8, r9, lsr #0xc
	orr r8, r8, r7, lsl #20
	add r7, ip, r8
	str r7, [r3, lr, lsl #2]
	add lr, lr, #1
	cmp lr, #0xc
	blt _020665B4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end Unknown2066510__LerpMtx43

	arm_func_start Unknown2066510__NormalizeScale
Unknown2066510__NormalizeScale: // 0x020665F8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl VEC_Mag
	bl FX_Inv
	ldr r1, [r5, #0]
	smull r3, r2, r1, r0
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4]
	ldr r1, [r5, #4]
	smull r3, r2, r1, r0
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #4]
	ldr r1, [r5, #8]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	add r0, r5, #0xc
	bl VEC_Mag
	bl FX_Inv
	ldr r1, [r5, #0xc]
	smull r3, r2, r1, r0
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0xc]
	ldr r1, [r5, #0x10]
	smull r3, r2, r1, r0
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x10]
	ldr r1, [r5, #0x14]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x14]
	add r0, r5, #0x18
	bl VEC_Mag
	bl FX_Inv
	ldr r1, [r5, #0x18]
	smull r3, r2, r1, r0
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x18]
	ldr r1, [r5, #0x1c]
	smull r3, r2, r1, r0
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x1c]
	ldr r1, [r5, #0x20]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x20]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end Unknown2066510__NormalizeScale

	arm_func_start Unknown2066510__Func_2066724
Unknown2066510__Func_2066724: // 0x02066724
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x24]
	mov r5, r1
	str r4, [r3]
	ldr r1, [r6, #0x28]
	mov r4, r2
	str r1, [r3, #4]
	ldr r1, [r6, #0x2c]
	str r1, [r3, #8]
	bl VEC_Mag
	str r0, [r5]
	add r0, r6, #0xc
	bl VEC_Mag
	str r0, [r5, #4]
	add r0, r6, #0x18
	bl VEC_Mag
	str r0, [r5, #8]
	mov r0, r6
	mov r1, r4
	bl MI_Copy36B
	ldr r0, [r5, #0]
	bl FX_Inv
	ldr r1, [r4, #0]
	smull r3, r2, r1, r0
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4]
	ldr r1, [r4, #4]
	smull r3, r2, r1, r0
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #4]
	ldr r1, [r4, #8]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	ldr r0, [r5, #4]
	bl FX_Inv
	ldr r1, [r4, #0xc]
	smull r3, r2, r1, r0
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0xc]
	ldr r1, [r4, #0x10]
	smull r3, r2, r1, r0
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x10]
	ldr r1, [r4, #0x14]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x14]
	ldr r0, [r5, #8]
	bl FX_Inv
	mov r1, r0, asr #0x1f
	ldr r2, [r4, #0x18]
	mov r3, #0
	smull ip, r5, r2, r0
	adds ip, ip, #0x800
	adc r2, r5, #0
	mov r5, ip, lsr #0xc
	orr r5, r5, r2, lsl #20
	str r5, [r4, #0x18]
	mov r2, #0x800
	ldr r5, [r4, #0x1c]
	smull lr, ip, r5, r0
	adds lr, lr, #0x800
	adc r5, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r5, lsl #20
	str ip, [r4, #0x1c]
	ldr r5, [r4, #0x20]
	umull lr, ip, r5, r0
	mla ip, r5, r1, ip
	mov r1, r5, asr #0x1f
	adds r2, lr, r2
	mla ip, r1, r0, ip
	adc r0, ip, r3
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x20]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end Unknown2066510__Func_2066724

	arm_func_start Unknown2066510__Func_20668A8
Unknown2066510__Func_20668A8: // 0x020668A8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r8, r1, lsl #1
	mov r7, r0
	mov r6, r2
	add r0, r8, #1
	mov ip, r0, lsl #1
	ldr r4, _02066A48 // =FX_SinCosTable_
	add r2, sp, #0
	mov r0, r6
	mov r1, r7
	mov r5, r3
	ldrsh r4, [r4, ip]
	bl VEC_CrossProduct
	mov r0, r7
	mov r1, r6
	bl VEC_DotProduct
	ldr r1, [r6, #0]
	ldr r3, [r7, #0]
	smull lr, ip, r1, r4
	adds r1, lr, #0x800
	mov r2, r8, lsl #1
	adc r8, ip, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r8, lsl #20
	smull ip, r8, r3, r0
	adds ip, ip, #0x800
	adc r3, r8, #0
	mov r8, ip, lsr #0xc
	orr r8, r8, r3, lsl #20
	rsb r3, r4, #0x1000
	smull lr, ip, r8, r3
	adds lr, lr, #0x800
	adc r8, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r8, lsl #20
	add r1, r1, ip
	ldr ip, _02066A48 // =FX_SinCosTable_
	ldr r8, [sp]
	ldrsh r2, [ip, r2]
	smull lr, ip, r8, r2
	adds lr, lr, #0x800
	adc r8, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r8, lsl #20
	sub r1, r1, ip
	str r1, [r5]
	ldr r1, [r6, #4]
	ldr r8, [r7, #4]
	smull lr, ip, r1, r4
	adds r1, lr, #0x800
	adc ip, ip, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, ip, lsl #20
	smull lr, ip, r8, r0
	adds lr, lr, #0x800
	adc r8, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r8, lsl #20
	smull lr, r8, ip, r3
	adds ip, lr, #0x800
	adc r8, r8, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r8, lsl #20
	ldr r8, [sp, #4]
	add r1, r1, ip
	smull lr, ip, r8, r2
	adds lr, lr, #0x800
	adc r8, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r8, lsl #20
	sub r1, r1, ip
	str r1, [r5, #4]
	ldr r6, [r6, #8]
	ldr r1, [r7, #8]
	smull r8, r7, r6, r4
	smull r6, r4, r1, r0
	adds r0, r8, #0x800
	adc r1, r7, #0
	mov r0, r0, lsr #0xc
	adds r6, r6, #0x800
	orr r0, r0, r1, lsl #20
	adc r1, r4, #0
	mov r4, r6, lsr #0xc
	orr r4, r4, r1, lsl #20
	smull r3, r1, r4, r3
	adds r3, r3, #0x800
	adc r1, r1, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r1, lsl #20
	add r3, r0, r3
	ldr r0, [sp, #8]
	smull r2, r1, r0, r2
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	sub r0, r3, r1
	str r0, [r5, #8]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02066A48: .word FX_SinCosTable_
	arm_func_end Unknown2066510__Func_20668A8

	arm_func_start Unknown2066510__LookAt
Unknown2066510__LookAt: // 0x02066A4C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r0, r1
	mov r4, r3
	mov r5, r2
	mov r1, r6
	add r2, r4, #0x18
	bl VEC_Subtract
	add r0, r4, #0x18
	mov r1, r0
	bl VEC_Normalize
	mov r0, r5
	mov r2, r4
	add r1, r4, #0x18
	bl VEC_CrossProduct
	mov r0, r4
	mov r1, r4
	bl VEC_Normalize
	add r0, r4, #0x18
	mov r1, r4
	add r2, r4, #0xc
	bl VEC_CrossProduct
	ldr r0, [r6, #0]
	str r0, [r4, #0x24]
	ldr r0, [r6, #4]
	str r0, [r4, #0x28]
	ldr r0, [r6, #8]
	str r0, [r4, #0x2c]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end Unknown2066510__LookAt

	arm_func_start Unknown2066510__Func_2066AC0
Unknown2066510__Func_2066AC0: // 0x02066AC0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x30
	mov r7, r0
	mov r6, r1
	mov r0, r6
	mov r1, r7
	mov r4, r2
	mov r5, r3
	bl VEC_DotProduct
	ldr r1, _02066B8C // =0x00000FFB
	cmp r0, r1
	bgt _02066B18
	mov r1, r4, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r4, r1, lsl #1
	add r2, r4, #1
	ldr r1, _02066B90 // =FX_SinCosTable_
	mov r2, r2, lsl #1
	ldrsh r8, [r1, r2]
	cmp r8, r0
	bgt _02066B2C
_02066B18:
	add sp, sp, #0x30
	ldmia r6, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02066B2C:
	add r2, sp, #0x24
	mov r0, r7
	mov r1, r6
	bl VEC_CrossProduct
	add r0, sp, #0x24
	mov r1, r0
	bl VEC_Normalize
	ldr r0, _02066B90 // =FX_SinCosTable_
	mov r1, r4, lsl #1
	ldrsh r2, [r0, r1]
	add r0, sp, #0
	add r1, sp, #0x24
	mov r3, r8
	bl MTX_RotAxis33
	add r1, sp, #0
	mov r0, r7
	mov r2, r5
	bl MTX_MultVec33
	mov r0, r5
	mov r1, r5
	bl VEC_Normalize
	mov r0, #0
	add sp, sp, #0x30
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02066B8C: .word 0x00000FFB
_02066B90: .word FX_SinCosTable_
	arm_func_end Unknown2066510__Func_2066AC0

	arm_func_start Unknown2066510__Func_2066B94
Unknown2066510__Func_2066B94: // 0x02066B94
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r5, r2
	mov r6, r1
	mov r1, r5
	mov r7, r0
	mov r4, r3
	bl VEC_DotProduct
	mov r1, r6, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r2, r1, #1
	ldr r1, _02066C20 // =FX_SinCosTable_
	mov r2, r2, lsl #1
	ldrsh r1, [r1, r2]
	cmp r0, r1
	ldmgeia r5, {r0, r1, r2}
	addge sp, sp, #0xc
	stmgeia r4, {r0, r1, r2}
	ldmgeia sp!, {r4, r5, r6, r7, pc}
	add r2, sp, #0
	mov r0, r7
	mov r1, r5
	bl VEC_CrossProduct
	add r0, sp, #0
	mov r1, r0
	bl VEC_Normalize
	add r0, sp, #0
	mov r1, r6
	mov r2, r7
	mov r3, r4
	bl Unknown2066510__Func_20668A8
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02066C20: .word FX_SinCosTable_
	arm_func_end Unknown2066510__Func_2066B94

	arm_func_start Unknown2066510__Func_2066C24
Unknown2066510__Func_2066C24: // 0x02066C24
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x40
	mov r5, r1
	mov r6, r0
	mov r4, r2
	mov r2, #1
	add r1, sp, #0xc
	mov r0, #0x10
	str r2, [sp, #0xc]
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r2, r1
	mov r0, #0x11
	bl NNS_G3dGeBufferOP_N
	add r0, sp, #0x10
	bl MTX_Identity43_
	ldr r2, [r5, #0]
	ldr r1, [r6, #0]
	mov r0, #0x19
	sub r1, r2, r1
	str r1, [sp, #0x10]
	ldr r3, [r5, #4]
	ldr r2, [r6, #4]
	add r1, sp, #0x10
	sub r2, r3, r2
	str r2, [sp, #0x20]
	ldr r5, [r5, #8]
	ldr r3, [r6, #8]
	mov r2, #0xc
	sub r3, r5, r3
	str r3, [sp, #0x30]
	ldr r3, [r6, #0]
	str r3, [sp, #0x34]
	ldr r3, [r6, #4]
	str r3, [sp, #0x38]
	ldr r3, [r6, #8]
	str r3, [sp, #0x3c]
	bl NNS_G3dGeBufferOP_N
	ldr r1, _02066D10 // =0x001F00C0
	mov r0, #0x29
	str r1, [sp, #8]
	add r1, sp, #8
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, #0x20
	add r1, sp, #4
	mov r2, #1
	str r4, [sp, #4]
	bl NNS_G3dGeBufferOP_N
	ldr r0, _02066D14 // =_021116A8
	mov r1, #0x18
	bl NNS_G3dGeSendDL
	mov r2, #1
	mov r0, #0x12
	add r1, sp, #0
	str r2, [sp]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x40
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02066D10: .word 0x001F00C0
_02066D14: .word _021116A8
	arm_func_end Unknown2066510__Func_2066C24

	arm_func_start Unknown2066510__Func_2066D18
Unknown2066510__Func_2066D18: // 0x02066D18
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	mov r5, r3
	mov r8, r0
	mov r0, r5
	mov r7, r1
	mov r6, r2
	bl MTX_Identity33_
	mov r4, #0x1000
	ldmia r8, {r0, r1, r2}
	add ip, sp, #0xc
	stmia ip, {r0, r1, r2}
	add r11, sp, #0x18
	ldmia ip, {r0, r1, r2}
	cmp r7, #1
	mov r9, r4
	str r4, [sp]
	add r3, r8, #0xc
	mov r10, #1
	stmia r11, {r0, r1, r2}
	bls _02066DE4
_02066D6C:
	ldr r1, [r3, #0]
	ldr r0, [sp, #0x18]
	cmp r0, r1
	strgt r1, [sp, #0x18]
	bgt _02066D8C
	ldr r0, [sp, #0xc]
	cmp r0, r1
	strlt r1, [sp, #0xc]
_02066D8C:
	ldr r1, [r3, #4]
	ldr r0, [sp, #0x1c]
	cmp r0, r1
	strgt r1, [sp, #0x1c]
	bgt _02066DAC
	ldr r0, [sp, #0x10]
	cmp r0, r1
	strlt r1, [sp, #0x10]
_02066DAC:
	ldr r1, [r3, #8]
	ldr r0, [sp, #0x20]
	cmp r0, r1
	strgt r1, [sp, #0x20]
	bgt _02066DCC
	ldr r0, [sp, #0x14]
	cmp r0, r1
	strlt r1, [sp, #0x14]
_02066DCC:
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	cmp r7, r0, lsr #16
	mov r10, r0, lsr #0x10
	add r3, r3, #0xc
	bhi _02066D6C
_02066DE4:
	ldr r1, [sp, #0xc]
	ldr r0, [sp, #0x18]
	ldr ip, [sp, #0x1c]
	ldr r3, [sp, #0x10]
	sub r2, r1, r0
	add r10, r0, r1
	add r11, ip, r3
	sub r3, r3, ip
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x14]
	mov ip, r10, asr #1
	str r3, [sp, #8]
	add r3, r1, r0
	sub r10, r0, r1
	str ip, [r5, #0x24]
	mov r0, r11, asr #1
	str r0, [r5, #0x28]
	mov r0, r3, asr #1
	str r0, [r5, #0x2c]
	cmp r2, #0x10000
	blt _02066E48
	mov r0, r2, asr #3
	str r0, [r5]
	bl FX_Inv
	str r0, [sp]
_02066E48:
	ldr r0, [sp, #8]
	cmp r0, #0x10000
	blt _02066E64
	mov r0, r0, asr #3
	str r0, [r5, #0x10]
	bl FX_Inv
	mov r9, r0
_02066E64:
	cmp r10, #0x10000
	blt _02066E7C
	mov r0, r10, asr #3
	str r0, [r5, #0x20]
	bl FX_Inv
	mov r4, r0
_02066E7C:
	cmp r7, #0
	addls sp, sp, #0x24
	mov r2, #0
	ldmlsia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp]
	mov r11, r9, asr #0x1f
	mov r0, r0, asr #0x1f
	str r0, [sp, #4]
	mov r1, r4, asr #0x1f
_02066EA0:
	ldr r0, [sp]
	ldr r3, [r8, #0]
	cmp r0, #0x1000
	ldr r0, [r5, #0x24]
	sub r0, r3, r0
	beq _02066EE8
	ldr r3, [sp]
	mov ip, r0, asr #0x1f
	umull r10, lr, r0, r3
	ldr r3, [sp, #4]
	adds r10, r10, #0x800
	mla lr, r0, r3, lr
	ldr r0, [sp]
	mla lr, ip, r0, lr
	mov r0, #0
	adc r3, lr, r0
	mov r0, r10, lsr #0xc
	orr r0, r0, r3, lsl #20
_02066EE8:
	strh r0, [r6]
	cmp r9, #0x1000
	ldr r3, [r8, #4]
	ldr r0, [r5, #0x28]
	sub r10, r3, r0
	beq _02066F24
	umull lr, ip, r10, r9
	mla ip, r10, r11, ip
	mov r3, r10, asr #0x1f
	mov r0, #0x800
	adds r0, lr, r0
	mla ip, r3, r9, ip
	adc r3, ip, #0
	mov r10, r0, lsr #0xc
	orr r10, r10, r3, lsl #20
_02066F24:
	strh r10, [r6, #2]
	cmp r4, #0x1000
	ldr r3, [r8, #8]
	ldr r0, [r5, #0x2c]
	sub r10, r3, r0
	beq _02066F60
	umull lr, ip, r10, r4
	mla ip, r10, r1, ip
	mov r3, r10, asr #0x1f
	mov r0, #0x800
	adds r0, lr, r0
	mla ip, r3, r4, ip
	adc r3, ip, #0
	mov r10, r0, lsr #0xc
	orr r10, r10, r3, lsl #20
_02066F60:
	strh r10, [r6, #4]
	add r0, r2, #1
	mov r0, r0, lsl #0x10
	cmp r7, r0, lsr #16
	mov r2, r0, lsr #0x10
	add r8, r8, #0xc
	add r6, r6, #6
	bhi _02066EA0
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end Unknown2066510__Func_2066D18

	arm_func_start Unknown2066510__Func_2066F88
Unknown2066510__Func_2066F88: // 0x02066F88
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, r1
	mov r4, r2
	mov r1, r5
	bl VEC_Subtract
	mov r0, r4
	mov r1, r4
	bl VEC_Normalize
	mov r0, r4
	mov r1, r5
	bl VEC_DotProduct
	mov r2, r5
	rsb r0, r0, #0
	mov r1, r4
	add r3, r4, #0xc
	bl VEC_MultAdd
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end Unknown2066510__Func_2066F88

	arm_func_start Unknown2066510__Func_2066FD0
Unknown2066510__Func_2066FD0: // 0x02066FD0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x18
	mov r5, r2
	mov r7, r0
	add r2, sp, #0xc
	mov r0, r5
	mov r4, r3
	mov r6, r1
	bl VEC_Subtract
	add r2, sp, #0
	mov r0, r4
	mov r1, r5
	bl VEC_Subtract
	add r0, sp, #0xc
	add r1, sp, #0
	mov r2, r7
	bl VEC_CrossProduct
	mov r0, r7
	mov r1, r7
	bl VEC_Normalize
	mov r1, r6
	mov r0, r7
	bl VEC_DotProduct
	rsb r0, r0, #0
	str r0, [r7, #0xc]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end Unknown2066510__Func_2066FD0

	arm_func_start Unknown2066510__Func_206703C
Unknown2066510__Func_206703C: // 0x0206703C
	stmdb sp!, {r4, r5, r6, lr}
	mov r3, r0
	mov ip, r1
	mov lr, r2
	ldmia ip, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r4, [ip, #8]
	ldr r2, [lr, #8]
	ldr r0, [lr]
	smull r2, r5, r4, r2
	adds r6, r2, #0x800
	ldmia ip, {r1, ip}
	ldr r2, [lr, #4]
	smull lr, r4, r1, r0
	adc r0, r5, #0
	adds r5, lr, #0x800
	mov r1, r6, lsr #0xc
	smull lr, r2, ip, r2
	adc r4, r4, #0
	adds ip, lr, #0x800
	mov r5, r5, lsr #0xc
	adc r2, r2, #0
	mov ip, ip, lsr #0xc
	orr r5, r5, r4, lsl #20
	orr ip, ip, r2, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r5, ip
	add r0, r1, r0
	str r0, [r3, #0xc]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end Unknown2066510__Func_206703C

	arm_func_start Unknown2066510__Func_20670B4
Unknown2066510__Func_20670B4: // 0x020670B4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl VEC_DotProduct
	ldr r1, [r4, #0xc]
	add r0, r1, r0
	ldmia sp!, {r4, pc}
	arm_func_end Unknown2066510__Func_20670B4

	arm_func_start Unknown2066510__Func_20670CC
Unknown2066510__Func_20670CC: // 0x020670CC
	stmdb sp!, {r3, lr}
	mov r2, r0
	mov r0, r1
	mov r1, r2
	bl VEC_DotProduct
	mov r0, r0, lsl #0x10
	movs r0, r0, asr #0x10
	rsbmi r0, r0, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	ldmia sp!, {r3, pc}
	arm_func_end Unknown2066510__Func_20670CC

	arm_func_start Unknown2066510__Func_20670F8
Unknown2066510__Func_20670F8: // 0x020670F8
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mov r6, r0
	add r1, r5, #0xc
	mov r4, r2
	bl VEC_DotProduct
	ldr r2, [r6, #0xc]
	mov r1, r5
	mov r3, r4
	sub r0, r2, r0
	add r2, r5, #0xc
	bl VEC_MultAdd
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end Unknown2066510__Func_20670F8

	.rodata

_021116A8: // 0x021116A8
    .byte 0x40, 0x24, 0x24, 0x24, 0, 0, 0, 0, 0, 0, 0, 0, 0x40, 0, 1, 4, 0, 0, 0, 0, 0x41, 0, 0, 0
