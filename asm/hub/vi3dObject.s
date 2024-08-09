	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start Vi3dObject__Constructor
Vi3dObject__Constructor: // 0x021674AC
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r4, r0
	ldr r1, _021675CC // =0x021738E8
	add r0, r4, #8
	str r1, [r4]
	bl CPPHelpers__Func_2085EE8
	add r0, r4, #0x14
	bl CPPHelpers__Func_2085EE8
	add r0, r4, #0x20
	bl CPPHelpers__Func_2085EE8
	add r0, r4, #0x2c
	bl CPPHelpers__Func_2085EE8
	mov r1, #0
	add r0, sp, #0xc
	mov r2, r1
	mov r3, r1
	str r1, [r4, #4]
	bl CPPHelpers__Func_2085EEC
	add r0, r4, #8
	add r1, sp, #0xc
	bl CPPHelpers__Func_2085FA8
	add r0, r4, #0x14
	add r1, r4, #8
	bl CPPHelpers__Func_2085FA8
	mov r1, #0x1000
	add r0, sp, #0
	mov r2, r1
	mov r3, r1
	bl CPPHelpers__Func_2085EEC
	add r0, r4, #0x20
	add r1, sp, #0
	bl CPPHelpers__Func_2085FA8
	add r0, r4, #0x2c
	add r1, r4, #0x20
	bl CPPHelpers__Func_2085FA8
	mov r1, #0
	strh r1, [r4, #0x38]
	strh r1, [r4, #0x3a]
	ldrh r3, [r4, #0x38]
	ldr r2, _021675D0 // =0x0000FFFF
	add r0, r4, #0x100
	strh r3, [r4, #0x3c]
	strh r1, [r4, #0x3e]
	strh r1, [r4, #0x40]
	strh r1, [r4, #0x42]
	strh r2, [r0, #0x88]
	strh r2, [r0, #0x8a]
	strh r2, [r0, #0x8c]
	strh r2, [r0, #0x8e]
	strh r2, [r0, #0x90]
	strh r2, [r0, #0x92]
	add r0, r4, #0x200
	strh r2, [r0, #0xd8]
	strh r2, [r0, #0xda]
	str r1, [r4, #0x2dc]
	str r1, [r4, #0x2e0]
	str r1, [r4, #0x2e4]
	str r1, [r4, #0x2e8]
	str r1, [r4, #0x2ec]
	str r1, [r4, #0x2f0]
	str r1, [r4, #0x2f4]
	str r1, [r4, #0x2f8]
	add r0, r4, #0x44
	str r1, [r4, #0x2fc]
	bl AnimatorMDL__Init
	add r0, r4, #0x194
	mov r1, #0
	bl AnimatorMDL__Init
	mov r0, r4
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
	.align 2, 0
_021675CC: .word 0x021738E8
_021675D0: .word 0x0000FFFF
	arm_func_end Vi3dObject__Constructor

	arm_func_start Vi3dObject__VTableFunc_21675D4
Vi3dObject__VTableFunc_21675D4: // 0x021675D4
	stmdb sp!, {r4, lr}
	ldr r1, _021675F0 // =0x021738E8
	mov r4, r0
	str r1, [r4]
	bl Vi3dObject__Func_21677C4
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021675F0: .word 0x021738E8
	arm_func_end Vi3dObject__VTableFunc_21675D4

	arm_func_start Vi3dObject__VTableFunc_21675F4
Vi3dObject__VTableFunc_21675F4: // 0x021675F4
	stmdb sp!, {r4, lr}
	ldr r1, _02167618 // =0x021738E8
	mov r4, r0
	str r1, [r4]
	bl Vi3dObject__Func_21677C4
	mov r0, r4
	bl CPPHelpers__Free
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167618: .word 0x021738E8
	arm_func_end Vi3dObject__VTableFunc_21675F4

	arm_func_start Vi3dObject__Func_216761C
Vi3dObject__Func_216761C: // 0x0216761C
	stmdb sp!, {r4, lr}
	ldr r1, _02167638 // =0x021738E8
	mov r4, r0
	str r1, [r4]
	bl Vi3dObject__Func_21677C4
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167638: .word 0x021738E8
	arm_func_end Vi3dObject__Func_216761C

	arm_func_start Vi3dObject__Func_216763C
Vi3dObject__Func_216763C: // 0x0216763C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	mov r7, r1
	mov r6, r2
	mov r4, r3
	bl Vi3dObject__Func_21677C4
	mov r0, #0
	str r0, [r5, #0x2dc]
	add r0, r5, #0x100
	strh r6, [r0, #0x88]
	ldr r0, [sp, #0x1c]
	str r7, [r5, #0x2e0]
	str r0, [r5, #0x2e4]
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x24]
	str r1, [r5, #0x2e8]
	str r0, [r5, #0x2ec]
	ldr r1, [sp, #0x28]
	ldr r0, [sp, #0x2c]
	str r1, [r5, #0x2f0]
	str r0, [r5, #0x2f4]
	ldr r0, [sp, #0x18]
	str r4, [r5, #0x2f8]
	str r0, [r5, #0x2fc]
	ldrh r1, [sp, #0x30]
	add r0, r5, #0x200
	strh r1, [r0, #0xd8]
	ldr r0, [r5, #0x2e0]
	bl NNS_G3dResDefaultSetup
	ldr r1, [r5, #0x2fc]
	add r0, r5, #0x100
	str r1, [sp]
	ldrh r2, [r0, #0x88]
	ldr r1, [r5, #0x2e0]
	ldr r3, [r5, #0x2f8]
	add r0, r5, #0x44
	bl AnimatorMDL__SetResource
	add r0, r5, #0x200
	ldrh r2, [r0, #0xd8]
	ldr r0, _02167700 // =0x0000FFFF
	cmp r2, r0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r1, [r5, #0x2fc]
	add r0, r5, #0x194
	str r1, [sp]
	ldr r1, [r5, #0x2e0]
	ldr r3, [r5, #0x2f8]
	bl AnimatorMDL__SetResource
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02167700: .word 0x0000FFFF
	arm_func_end Vi3dObject__Func_216763C

	arm_func_start Vi3dObject__Func_2167704
Vi3dObject__Func_2167704: // 0x02167704
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	mov r5, r1
	mov r7, r2
	mov r4, r3
	bl Vi3dObject__Func_21677C4
	mov r0, #1
	str r0, [r6, #0x2dc]
	add r2, r6, #0x100
	strh r7, [r2, #0x88]
	ldr r0, [r5, #0x2e0]
	ldr ip, [sp, #0x18]
	str r0, [r6, #0x2e0]
	ldr r0, [r5, #0x2e4]
	ldrh r3, [sp, #0x1c]
	str r0, [r6, #0x2e4]
	ldr r0, [r5, #0x2e8]
	add r1, r6, #0x200
	str r0, [r6, #0x2e8]
	ldr lr, [r5, #0x2ec]
	add r0, r6, #0x44
	str lr, [r6, #0x2ec]
	ldr lr, [r5, #0x2f0]
	str lr, [r6, #0x2f0]
	ldr r5, [r5, #0x2f4]
	str r5, [r6, #0x2f4]
	str r4, [r6, #0x2f8]
	str ip, [r6, #0x2fc]
	strh r3, [r1, #0xd8]
	ldr r1, [r6, #0x2fc]
	str r1, [sp]
	ldrh r2, [r2, #0x88]
	ldr r1, [r6, #0x2e0]
	ldr r3, [r6, #0x2f8]
	bl AnimatorMDL__SetResource
	add r0, r6, #0x200
	ldrh r2, [r0, #0xd8]
	ldr r0, _021677C0 // =0x0000FFFF
	cmp r2, r0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r1, [r6, #0x2fc]
	add r0, r6, #0x194
	str r1, [sp]
	ldr r1, [r6, #0x2e0]
	ldr r3, [r6, #0x2f8]
	bl AnimatorMDL__SetResource
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021677C0: .word 0x0000FFFF
	arm_func_end Vi3dObject__Func_2167704

	arm_func_start Vi3dObject__Func_21677C4
Vi3dObject__Func_21677C4: // 0x021677C4
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r4, r0
	add r0, r4, #0x44
	bl AnimatorMDL__Release
	add r0, r4, #0x44
	mov r1, #0
	bl AnimatorMDL__Init
	add r0, r4, #0x200
	ldrh r1, [r0, #0xd8]
	ldr r0, _021678FC // =0x0000FFFF
	cmp r1, r0
	beq _0216780C
	add r0, r4, #0x194
	bl AnimatorMDL__Release
	add r0, r4, #0x194
	mov r1, #0
	bl AnimatorMDL__Init
_0216780C:
	ldr r0, [r4, #0x2e0]
	cmp r0, #0
	beq _02167828
	ldr r1, [r4, #0x2dc]
	cmp r1, #0
	bne _02167828
	bl NNS_G3dResDefaultRelease
_02167828:
	mov r1, #0
	add r0, sp, #0xc
	mov r2, r1
	mov r3, r1
	str r1, [r4, #4]
	bl CPPHelpers__Func_2085EEC
	add r1, sp, #0xc
	add r0, r4, #8
	bl CPPHelpers__Func_2085FA8
	add r0, r4, #0x14
	add r1, r4, #8
	bl CPPHelpers__Func_2085FA8
	mov r1, #0x1000
	add r0, sp, #0
	mov r2, r1
	mov r3, r1
	bl CPPHelpers__Func_2085EEC
	add r0, r4, #0x20
	add r1, sp, #0
	bl CPPHelpers__Func_2085FA8
	add r0, r4, #0x2c
	add r1, r4, #0x20
	bl CPPHelpers__Func_2085FA8
	mov r3, #0
	strh r3, [r4, #0x38]
	strh r3, [r4, #0x3a]
	ldrh r2, [r4, #0x38]
	ldr r1, _021678FC // =0x0000FFFF
	add r0, r4, #0x100
	strh r2, [r4, #0x3c]
	strh r3, [r4, #0x3e]
	strh r3, [r4, #0x40]
	strh r3, [r4, #0x42]
	strh r1, [r0, #0x88]
	strh r1, [r0, #0x8a]
	strh r1, [r0, #0x8c]
	strh r1, [r0, #0x8e]
	strh r1, [r0, #0x90]
	strh r1, [r0, #0x92]
	add r0, r4, #0x200
	strh r1, [r0, #0xd8]
	strh r1, [r0, #0xda]
	str r3, [r4, #0x2dc]
	str r3, [r4, #0x2e0]
	str r3, [r4, #0x2e4]
	str r3, [r4, #0x2e8]
	str r3, [r4, #0x2ec]
	str r3, [r4, #0x2f0]
	str r3, [r4, #0x2f4]
	str r3, [r4, #0x2f8]
	str r3, [r4, #0x2fc]
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
	.align 2, 0
_021678FC: .word 0x0000FFFF
	arm_func_end Vi3dObject__Func_21677C4

	arm_func_start Vi3dObject__Func_2167900
Vi3dObject__Func_2167900: // 0x02167900
	stmdb sp!, {r3, lr}
	sub sp, sp, #0x10
	ldr ip, [sp, #0x1c]
	cmp ip, #0
	addeq ip, r0, #0x100
	ldreqh ip, [ip, #0x8a]
	cmpeq ip, r1
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, pc}
	add ip, r0, #0x100
	strh r1, [ip, #0x8a]
	ldr r1, [sp, #0x18]
	stmia sp, {r2, r3}
	str r1, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	ldr r2, [r0, #0x2e4]
	ldrh r3, [ip, #0x8a]
	add r0, r0, #0x44
	bl ViShadow__Func_21680B8
	add sp, sp, #0x10
	ldmia sp!, {r3, pc}
	arm_func_end Vi3dObject__Func_2167900

	arm_func_start Vi3dObject__Func_2167958
Vi3dObject__Func_2167958: // 0x02167958
	stmdb sp!, {r3, lr}
	sub sp, sp, #0x10
	ldr ip, [sp, #0x1c]
	cmp ip, #0
	addeq ip, r0, #0x200
	ldreqh ip, [ip, #0xda]
	cmpeq ip, r1
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, pc}
	add ip, r0, #0x200
	strh r1, [ip, #0xda]
	ldr r1, [sp, #0x18]
	stmia sp, {r2, r3}
	str r1, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	ldr r2, [r0, #0x2e4]
	ldrh r3, [ip, #0xda]
	add r0, r0, #0x194
	bl ViShadow__Func_21680B8
	add sp, sp, #0x10
	ldmia sp!, {r3, pc}
	arm_func_end Vi3dObject__Func_2167958

	arm_func_start Vi3dObject__Func_21679B0
Vi3dObject__Func_21679B0: // 0x021679B0
	stmdb sp!, {r3, lr}
	sub sp, sp, #0x10
	ldr ip, [sp, #0x1c]
	cmp ip, #0
	addeq ip, r0, #0x100
	ldreqh ip, [ip, #0x8e]
	cmpeq ip, r1
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, pc}
	add ip, r0, #0x100
	strh r1, [ip, #0x8e]
	ldr r1, [sp, #0x18]
	stmia sp, {r2, r3}
	str r1, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	ldr r2, [r0, #0x2ec]
	ldrh r3, [ip, #0x8e]
	add r0, r0, #0x44
	mov r1, #1
	bl ViShadow__Func_21680B8
	add sp, sp, #0x10
	ldmia sp!, {r3, pc}
	arm_func_end Vi3dObject__Func_21679B0

	arm_func_start Vi3dObject__Func_2167A0C
Vi3dObject__Func_2167A0C: // 0x02167A0C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	ldr ip, [sp, #0x24]
	mov r4, r0
	cmp ip, #0
	addeq r0, r4, #0x100
	ldreqh r0, [r0, #0x90]
	mov r6, r2
	mov r5, r3
	cmpeq r0, r1
	addeq sp, sp, #0x10
	ldmeqia sp!, {r4, r5, r6, pc}
	add r0, r4, #0x100
	strh r1, [r0, #0x90]
	ldr r0, [r4, #0x2e0]
	bl NNS_G3dGetTex
	str r6, [sp]
	ldr r1, [sp, #0x20]
	str r5, [sp, #4]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	add r0, r4, #0x100
	ldrh r3, [r0, #0x90]
	ldr r2, [r4, #0x2f0]
	add r0, r4, #0x44
	mov r1, #2
	bl ViShadow__Func_21680B8
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end Vi3dObject__Func_2167A0C

	arm_func_start Vi3dObject__Func_2167A80
Vi3dObject__Func_2167A80: // 0x02167A80
	stmdb sp!, {r3, lr}
	sub sp, sp, #0x10
	ldr ip, [sp, #0x1c]
	cmp ip, #0
	addeq ip, r0, #0x100
	ldreqh ip, [ip, #0x92]
	cmpeq ip, r1
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, pc}
	add ip, r0, #0x100
	strh r1, [ip, #0x92]
	ldr r1, [sp, #0x18]
	stmia sp, {r2, r3}
	str r1, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	ldr r2, [r0, #0x2f4]
	ldrh r3, [ip, #0x92]
	add r0, r0, #0x44
	mov r1, #3
	bl ViShadow__Func_21680B8
	add sp, sp, #0x10
	ldmia sp!, {r3, pc}
	arm_func_end Vi3dObject__Func_2167A80

	arm_func_start Vi3dObject__Func_2167ADC
Vi3dObject__Func_2167ADC: // 0x02167ADC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #4]
	tst r0, #1
	beq _02167B64
	ldrh r1, [r4, #0x3a]
	ldrh r0, [r4, #0x38]
	cmp r0, r1
	beq _02167B6C
	add r2, r0, #0x10000
	add r1, r1, #0x10000
	cmp r2, r1
	bge _02167B20
	sub r0, r1, r2
	cmp r0, #0x8000
	subge r1, r1, #0x10000
	b _02167B2C
_02167B20:
	sub r0, r2, r1
	cmp r0, #0x8000
	subge r2, r2, #0x10000
_02167B2C:
	cmp r1, r2
	bge _02167B48
	ldrh r0, [r4, #0x3e]
	add r1, r1, r0
	cmp r1, r2
	movgt r1, r2
	b _02167B5C
_02167B48:
	ble _02167B5C
	ldrh r0, [r4, #0x3e]
	sub r1, r1, r0
	cmp r1, r2
	movlt r1, r2
_02167B5C:
	strh r1, [r4, #0x3a]
	b _02167B6C
_02167B64:
	ldrh r0, [r4, #0x38]
	strh r0, [r4, #0x3a]
_02167B6C:
	add r0, r4, #0x44
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #0x200
	ldrh r1, [r0, #0xd8]
	ldr r0, _02167B94 // =0x0000FFFF
	cmp r1, r0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x194
	bl AnimatorMDL__ProcessAnimation
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167B94: .word 0x0000FFFF
	arm_func_end Vi3dObject__Func_2167ADC

	arm_func_start Vi3dObject__Func_2167B98
Vi3dObject__Func_2167B98: // 0x02167B98
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x48
	mov r4, r0
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x14]
	ldr r3, _02167D68 // =FX_SinCosTable_
	add r0, r1, r0
	str r0, [r4, #0x8c]
	ldr r2, [r4, #0xc]
	ldr r1, [r4, #0x18]
	add r0, r4, #0x68
	add r1, r2, r1
	str r1, [r4, #0x90]
	ldr r2, [r4, #0x10]
	ldr r1, [r4, #0x1c]
	add r1, r2, r1
	str r1, [r4, #0x94]
	ldr r2, [r4, #0x20]
	ldr r1, [r4, #0x2c]
	smull ip, r1, r2, r1
	adds r2, ip, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x5c]
	ldr r2, [r4, #0x24]
	ldr r1, [r4, #0x30]
	smull ip, r1, r2, r1
	adds r2, ip, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x60]
	ldr r2, [r4, #0x28]
	ldr r1, [r4, #0x34]
	smull ip, r1, r2, r1
	adds r2, ip, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x64]
	ldrh r2, [r4, #0x3a]
	ldrh r1, [r4, #0x3c]
	add r1, r2, r1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	blx MTX_RotY33_
	ldrh r0, [r4, #0x40]
	cmp r0, #0
	beq _02167CB4
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _02167D68 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0x24
	blx MTX_RotX33_
	add r0, r4, #0x68
	add r1, sp, #0x24
	mov r2, r0
	bl MTX_Concat33
_02167CB4:
	ldrh r0, [r4, #0x42]
	cmp r0, #0
	beq _02167CF8
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _02167D68 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0
	blx MTX_RotZ33_
	add r0, r4, #0x68
	add r1, sp, #0
	mov r2, r0
	bl MTX_Concat33
_02167CF8:
	add r0, r4, #0x44
	bl AnimatorMDL__Draw
	add r0, r4, #0x200
	ldrh r1, [r0, #0xd8]
	ldr r0, _02167D6C // =0x0000FFFF
	cmp r1, r0
	addeq sp, sp, #0x48
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x8c]
	add r0, r4, #0x68
	str r1, [r4, #0x1dc]
	ldr r2, [r4, #0x90]
	add r1, r4, #0x1b8
	str r2, [r4, #0x1e0]
	ldr r3, [r4, #0x94]
	mov r2, #0x24
	str r3, [r4, #0x1e4]
	ldr r3, [r4, #0x5c]
	str r3, [r4, #0x1ac]
	ldr r3, [r4, #0x60]
	str r3, [r4, #0x1b0]
	ldr r3, [r4, #0x64]
	str r3, [r4, #0x1b4]
	bl MIi_CpuCopy16
	add r0, r4, #0x194
	bl AnimatorMDL__Draw
	add sp, sp, #0x48
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167D68: .word FX_SinCosTable_
_02167D6C: .word 0x0000FFFF
	arm_func_end Vi3dObject__Func_2167B98
