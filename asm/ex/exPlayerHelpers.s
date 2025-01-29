	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start exPlayerHelpers__Func_2152960
exPlayerHelpers__Func_2152960: // 0x02152960
	cmp r0, #0
	moveq r0, #0
	bxeq lr
	cmp r1, #0
	moveq r0, #0
	bxeq lr
	cmp r3, #0
	movle r0, #0
	bxle lr
	cmp r2, #0
	movle r0, #0
	bxle lr
	str r1, [r0]
	strh r2, [r0, #4]
	strh r3, [r0, #0x14]
	mov r2, #0
	strh r2, [r0, #0x16]
	ldr r2, [r1, #0]
	str r2, [r0, #0x24]
	ldr r2, [r1, #4]
	str r2, [r0, #0x28]
	ldr r1, [r1, #8]
	str r1, [r0, #0x2c]
	mov r0, #1
	bx lr
	arm_func_end exPlayerHelpers__Func_2152960

	arm_func_start exPlayerHelpers__Func_21529C4
exPlayerHelpers__Func_21529C4: // 0x021529C4
	stmdb sp!, {r3, r4, r5, lr}
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x1000
	bge _02152A6C
	mov r1, #0x3000
	umull ip, r4, r0, r1
	mov r2, #0
	mla r4, r0, r2, r4
	mov r3, r0, asr #0x1f
	mla r4, r3, r1, r4
	adds r5, ip, #0x800
	mov r1, #0x6000
	umull lr, ip, r0, r1
	mla ip, r0, r2, ip
	adc r2, r4, #0
	mov r4, r5, lsr #0xc
	orr r4, r4, r2, lsl #20
	smull r5, r2, r4, r0
	adds r4, r5, #0x800
	adc r2, r2, #0
	mov r4, r4, lsr #0xc
	orr r4, r4, r2, lsl #20
	smull r5, r2, r4, r0
	adds r4, r5, #0x800
	adc r2, r2, #0
	mov r4, r4, lsr #0xc
	mla ip, r3, r1, ip
	adds lr, lr, #0x800
	adc r3, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r3, lsl #20
	smull r3, r0, ip, r0
	adds r3, r3, #0x800
	adc r0, r0, #0
	mov r3, r3, lsr #0xc
	orr r4, r4, r2, lsl #20
	orr r3, r3, r0, lsl #20
	sub r0, r4, r3
	add r0, r0, #0x4000
	bl FX_Div
	ldmia sp!, {r3, r4, r5, pc}
_02152A6C:
	cmp r0, #0x2000
	movge r0, #0
	ldmgeia sp!, {r3, r4, r5, pc}
	sub r3, r0, #0x2000
	rsb r0, r3, #0
	smull r2, r1, r0, r3
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	smull r2, r0, r1, r3
	adds r2, r2, #0x800
	adc r1, r0, #0
	mov r0, r2, lsr #0xc
	orr r0, r0, r1, lsl #20
	mov r1, #0x6000
	bl FX_Div
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end exPlayerHelpers__Func_21529C4

	arm_func_start exPlayerHelpers__Func_2152AB4
exPlayerHelpers__Func_2152AB4: // 0x02152AB4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r10, r0
	ldrsh r1, [r10, #0x14]
	ldrsh r5, [r10, #0x16]
	ldrsh r0, [r10, #4]
	cmp r5, r1
	blt _02152B20
	mov r1, #0xc
	sub r0, r0, #1
	mul r2, r0, r1
	ldr r3, [r10, #0]
	mov r0, #1
	ldr r2, [r3, r2]
	str r2, [r10, #8]
	ldrsh r2, [r10, #4]
	ldr r4, [r10, #0]
	sub r3, r2, #1
	mla r2, r3, r1, r4
	ldr r2, [r2, #4]
	str r2, [r10, #0xc]
	ldrsh r2, [r10, #4]
	ldr r3, [r10, #0]
	sub r2, r2, #1
	mla r1, r2, r1, r3
	ldr r1, [r1, #8]
	str r1, [r10, #0x10]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02152B20:
	add r0, r0, #1
	mov r0, r0, lsl #0xc
	bl _s32_div_f
	mov r1, r5
	mul r3, r0, r5
	mov r4, #0
	add r0, r1, #1
	strh r0, [r10, #0x16]
	ldrsh r2, [r10, #4]
	sub r0, r4, #2
	mov r5, r4
	add r1, r2, #1
	mov r6, r4
	cmp r1, r0
	mov r7, r0
	blt _02152BD4
	sub r9, r4, #0x2000
	sub r11, r3, #0x1000
_02152B68:
	mov r8, r7
	cmp r7, #0
	movlt r8, #0
	sub r0, r2, #1
	cmp r7, r0
	movgt r8, r0
	sub r0, r11, r9
	bl exPlayerHelpers__Func_21529C4
	mov r1, #0xc
	mul r3, r8, r1
	ldr r8, [r10, #0]
	ldrsh r2, [r10, #4]
	add r1, r8, r3
	ldr r8, [r8, r3]
	ldr r3, [r1, #4]
	ldr r1, [r1, #8]
	mul r8, r0, r8
	mul r3, r0, r3
	mul r1, r0, r1
	add r7, r7, #1
	add r0, r2, #1
	add r4, r4, r8, asr #12
	add r5, r5, r3, asr #12
	add r9, r9, #0x1000
	add r6, r6, r1, asr #12
	cmp r7, r0
	ble _02152B68
_02152BD4:
	add r0, r4, #1
	str r0, [r10, #8]
	add r0, r5, #1
	str r0, [r10, #0xc]
	add r0, r6, #1
	str r0, [r10, #0x10]
	ldr r2, [r10, #8]
	ldr r1, [r10, #0x24]
	mov r0, #0
	sub r1, r2, r1
	str r1, [r10, #0x18]
	ldr r2, [r10, #0xc]
	ldr r1, [r10, #0x28]
	sub r1, r2, r1
	str r1, [r10, #0x1c]
	ldr r2, [r10, #0x10]
	ldr r1, [r10, #0x2c]
	sub r1, r2, r1
	str r1, [r10, #0x20]
	ldr r1, [r10, #8]
	str r1, [r10, #0x24]
	ldr r1, [r10, #0xc]
	str r1, [r10, #0x28]
	ldr r1, [r10, #0x10]
	str r1, [r10, #0x2c]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end exPlayerHelpers__Func_2152AB4

	arm_func_start exPlayerHelpers__SetAnimationInternal
exPlayerHelpers__SetAnimationInternal: // 0x02152C3C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldrh r2, [sp, #0x10]
	mov r4, r0
	mov r1, #0
	strh r2, [r4, #0x1c]
	str r1, [sp]
	mov r2, r3
	ldrh r3, [r4, #0x1c]
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r4, #0x300
	mov r3, #0
	strh r3, [r0, #0x48]
	ldr r0, [r4, #0x104]
	mov r2, #1
	str r0, [r4, #0x344]
_02152C80:
	mov r0, r2, lsl r3
	tst r0, #1
	beq _02152CA0
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02152CA0:
	add r3, r3, #1
	cmp r3, #5
	blo _02152C80
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end exPlayerHelpers__SetAnimationInternal

	arm_func_start exPlayerHelpers__Func_2152CB4
exPlayerHelpers__Func_2152CB4: // 0x02152CB4
	stmdb sp!, {lr}
	sub sp, sp, #0x3c
	ldr r0, _02152D1C // =_02173E14
	add r3, sp, #0x24
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r2, sp, #0x30
	mov r1, #0
	add r0, sp, #0
	str r1, [r2]
	str r1, [r2, #4]
	str r1, [r2, #8]
	bl MTX_Identity33_
	add r0, sp, #0x24
	bl NNS_G3dGlbSetBaseScale
	ldr r1, _02152D20 // =NNS_G3dGlb+0x000000BC
	add r0, sp, #0
	bl MI_Copy36B
	ldr r1, _02152D24 // =NNS_G3dGlb
	add r0, sp, #0x30
	ldr r2, [r1, #0xfc]
	bic r2, r2, #0xa4
	str r2, [r1, #0xfc]
	bl NNS_G3dGlbSetBaseTrans
	add sp, sp, #0x3c
	ldmia sp!, {pc}
	.align 2, 0
_02152D1C: .word _02173E14
_02152D20: .word NNS_G3dGlb+0x000000BC
_02152D24: .word NNS_G3dGlb
	arm_func_end exPlayerHelpers__Func_2152CB4

	arm_func_start exPlayerHelpers__Func_2152D28
exPlayerHelpers__Func_2152D28: // 0x02152D28
	cmp r3, #0
	beq _02152D44
	cmp r3, #1
	beq _02152D90
	cmp r3, #2
	beq _02152DDC
	bx lr
_02152D44:
	ldrh r1, [r1, #0]
	cmp r1, #1
	beq _02152D5C
	cmp r1, #2
	beq _02152D74
	bx lr
_02152D5C:
	ldrh r3, [r0, #0]
	ldrh r2, [r2, #0]
	mov r1, #0xb6
	mla r1, r2, r1, r3
	strh r1, [r0]
	bx lr
_02152D74:
	ldrh r2, [r2, #0]
	mov r1, #0xb6
	ldrh r3, [r0, #0]
	mul r1, r2, r1
	sub r1, r3, r1
	strh r1, [r0]
	bx lr
_02152D90:
	ldrh r1, [r1, #2]
	cmp r1, #1
	beq _02152DA8
	cmp r1, #2
	beq _02152DC0
	bx lr
_02152DA8:
	ldrh r3, [r0, #2]
	ldrh r2, [r2, #2]
	mov r1, #0xb6
	mla r1, r2, r1, r3
	strh r1, [r0, #2]
	bx lr
_02152DC0:
	ldrh r2, [r2, #2]
	mov r1, #0xb6
	ldrh r3, [r0, #2]
	mul r1, r2, r1
	sub r1, r3, r1
	strh r1, [r0, #2]
	bx lr
_02152DDC:
	ldrh r1, [r1, #4]
	cmp r1, #1
	beq _02152DF4
	cmp r1, #2
	beq _02152E0C
	bx lr
_02152DF4:
	ldrh r3, [r0, #4]
	ldrh r2, [r2, #4]
	mov r1, #0xb6
	mla r1, r2, r1, r3
	strh r1, [r0, #4]
	bx lr
_02152E0C:
	ldrh r2, [r2, #4]
	mov r1, #0xb6
	ldrh r3, [r0, #4]
	mul r1, r2, r1
	sub r1, r3, r1
	strh r1, [r0, #4]
	bx lr
	arm_func_end exPlayerHelpers__Func_2152D28

	arm_func_start exPlayerHelpers__Func_2152E28
exPlayerHelpers__Func_2152E28: // 0x02152E28
	stmdb sp!, {r3, lr}
	bl FX_Atan2
	bl _f_itof
	ldr r1, _02152E94 // =0x45800000
	bl _fdiv
	ldr r1, _02152E98 // =0x43340000
	bl _f_mul
	ldr r1, _02152E9C // =0x40490E56
	bl _fdiv
	ldr r1, _02152EA0 // =0x43B40000
	bl _fadd
	bl _f_ftou
	ldr r3, _02152EA4 // =0xB60B60B7
	mov r1, r0, lsr #0x1f
	smull r2, ip, r3, r0
	add ip, r0, ip
	add ip, r1, ip, asr #8
	mov r3, #0x168
	smull r1, r2, r3, ip
	sub ip, r0, r1
	mov r0, ip, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, #0xb6
	mul r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, pc}
	.align 2, 0
_02152E94: .word 0x45800000
_02152E98: .word 0x43340000
_02152E9C: .word 0x40490E56
_02152EA0: .word 0x43B40000
_02152EA4: .word 0xB60B60B7
	arm_func_end exPlayerHelpers__Func_2152E28

	arm_func_start ovl09_2152EA8
ovl09_2152EA8: // 0x02152EA8
	stmdb sp!, {r4, r5, r6, lr}
	ldrh r5, [sp, #0x10]
	ldr r4, _02152FAC // =0xB40B40B5
	mov r6, r2
	smull r2, ip, r4, r5
	add ip, r5, ip
	mov r2, r5, lsr #0x1f
	add ip, r2, ip, asr #7
	mov r2, ip, lsl #0x10
	mov r5, r3
	mov r4, r2, asr #0x10
	bl exPlayerHelpers__Func_2152E28
	ldr r3, _02152FAC // =0xB40B40B5
	ldrsh r1, [r5, #0]
	smull r2, ip, r3, r0
	add ip, r0, ip
	mov r2, r0, lsr #0x1f
	add ip, r2, ip, asr #7
	mov r2, ip, lsl #0x10
	sub r3, r1, #0xb4
	cmp r3, r2, asr #16
	mov r3, r2, asr #0x10
	ble _02152F1C
	add r3, r3, #0x168
	add r2, r0, #0x10000
	mov r0, r3, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r0, asr #0x10
	mov r0, r2, lsr #0x10
_02152F1C:
	add r2, r1, #0xb4
	cmp r2, r3
	bge _02152F40
	sub r3, r3, #0x168
	sub r2, r0, #0x10000
	mov r0, r3, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r0, asr #0x10
	mov r0, r2, lsr #0x10
_02152F40:
	sub r1, r1, r3
	mov r1, r1, lsl #0x10
	cmp r4, r1, asr #16
	mov r2, r1, asr #0x10
	bge _02152F74
	ldrh r1, [r6, #2]
	ldrh r0, [sp, #0x10]
	sub r0, r1, r0
	strh r0, [r6, #2]
	ldrsh r0, [r5, #0]
	sub r0, r0, r4
	strh r0, [r5]
	b _02152FA4
_02152F74:
	rsb r1, r4, #0
	cmp r2, r1
	strgeh r0, [r6, #2]
	strgeh r3, [r5]
	bge _02152FA4
	ldrh r1, [r6, #2]
	ldrh r0, [sp, #0x10]
	add r0, r1, r0
	strh r0, [r6, #2]
	ldrsh r0, [r5, #0]
	add r0, r0, r4
	strh r0, [r5]
_02152FA4:
	ldrh r0, [r6, #2]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02152FAC: .word 0xB40B40B5
	arm_func_end ovl09_2152EA8

	arm_func_start exPlayerHelpers__Func_2152FB0
exPlayerHelpers__Func_2152FB0: // 0x02152FB0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r3
	mov r7, r0
	mov r6, r1
	mov r0, r8
	mov r1, #0
	mov r5, r2
	ldr r4, [sp, #0x18]
	bl _fgr
	ldr r0, _021530F8 // =0x45800000
	mov r1, r8
	bls _02152FF4
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02153000
_02152FF4:
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02153000:
	bl _f_ftoi
	str r0, [r7, #0x18]
	ldr r2, [r6, #8]
	ldr r0, [r5, #8]
	ldr r1, [r7, #0x18]
	sub r0, r2, r0
	bl FX_Div
	mov r1, r0, asr #0x1f
	mov r2, r1, lsl #0xd
	mov r1, #0x800
	orr r2, r2, r0, lsr #19
	adds r0, r1, r0, lsl #13
	adc r1, r2, #0
	mov r0, r0, lsr #0xc
	orr r0, r0, r1, lsl #20
	bl FX_Sqrt
	str r0, [r7]
	str r0, [r7, #4]
	str r0, [r7, #8]
	ldr r2, [r5, #0]
	ldr r0, [r6, #0]
	ldr r1, [r7, #0]
	sub r0, r2, r0
	bl FX_Div
	str r0, [r7, #0xc]
	ldr r2, [r5, #4]
	ldr r0, [r6, #4]
	ldr r1, [r7, #4]
	sub r0, r2, r0
	bl FX_Div
	str r0, [r7, #0x10]
	ldr r2, [r5, #8]
	ldr r0, [r6, #8]
	ldr r1, [r7, #8]
	sub r0, r2, r0
	bl FX_Div
	str r0, [r7, #8]
	mov r1, #0
	mov r0, r4
	str r1, [r7, #0x14]
	bl _fneq
	beq _021530EC
	mov r0, r4
	mov r1, #0
	bl _fgr
	ldr r0, _021530F8 // =0x45800000
	mov r1, r4
	bls _021530D4
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021530E0
_021530D4:
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021530E0:
	bl _f_ftoi
	str r0, [r7, #0x1c]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_021530EC:
	mov r0, #0x1000
	str r0, [r7, #0x1c]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021530F8: .word 0x45800000
	arm_func_end exPlayerHelpers__Func_2152FB0

	arm_func_start exPlayerHelpers__Func_21530FC
exPlayerHelpers__Func_21530FC: // 0x021530FC
	stmdb sp!, {r3, lr}
	cmp r2, #0
	ldreq r2, [r0, #8]
	beq _02153130
	ldr r3, [r0, #0x18]
	ldr r2, [r0, #0x1c]
	ldr lr, [r0, #0x14]
	smull ip, r2, r3, r2
	adds r3, ip, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	sub r2, lr, r3
_02153130:
	str r2, [r0, #0x14]
	ldr r3, [r1, #0]
	ldr r2, [r0, #0xc]
	add r2, r3, r2
	str r2, [r1]
	ldr r3, [r1, #4]
	ldr r2, [r0, #0x10]
	add r2, r3, r2
	str r2, [r1, #4]
	ldr r3, [r1, #8]
	ldr r2, [r0, #0x14]
	add r2, r3, r2
	str r2, [r1, #8]
	ldr r0, [r0, #0x14]
	cmp r0, #0
	movle r0, #1
	movgt r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end exPlayerHelpers__Func_21530FC

	.rodata

_02173E14:
	.word 0x1000, 0x1000, 0x1000