	.include "asm/macros.inc"
	.include "global.inc"

	.public _ZTVN10__cxxabiv117__class_type_infoE
	.public _ZTVN10__cxxabiv120__si_class_type_infoE

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
	bl CPPHelpers__VEC_Set
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
	bl CPPHelpers__VEC_Set
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
	bl _ZdlPv
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
	bl CPPHelpers__VEC_Set
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
	bl CPPHelpers__VEC_Set
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

	arm_func_start Vi3dObject__ProcessAnimation
Vi3dObject__ProcessAnimation: // 0x02167ADC
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
	arm_func_end Vi3dObject__ProcessAnimation

	arm_func_start Vi3dObject__Draw
Vi3dObject__Draw: // 0x02167B98
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
	bl MTX_RotY33_
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
	bl MTX_RotX33_
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
	bl MTX_RotZ33_
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
	arm_func_end Vi3dObject__Draw

	arm_func_start ViShadow__Constructor
ViShadow__Constructor: // 0x02167D70
	ldr r2, _02167D9C // =_ZTV9CViShadow+0x08
	mov r1, #0
	str r2, [r0]
	str r1, [r0, #4]
	str r1, [r0, #8]
	str r1, [r0, #0xc]
	mov r1, #0x6000
	str r1, [r0, #0x10]
	mov r1, #0xf
	strh r1, [r0, #0x14]
	bx lr
	.align 2, 0
_02167D9C: .word _ZTV9CViShadow+0x08
	arm_func_end ViShadow__Constructor

	arm_func_start ViShadow__VTableFunc_2167DA0
ViShadow__VTableFunc_2167DA0: // 0x02167DA0
	stmdb sp!, {r4, lr}
	ldr r1, _02167DBC // =_ZTV9CViShadow+0x08
	mov r4, r0
	str r1, [r4]
	bl ViShadow__Func_2167E9C
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167DBC: .word _ZTV9CViShadow+0x08
	arm_func_end ViShadow__VTableFunc_2167DA0

	arm_func_start ViShadow__VTableFunc_2167DC0
ViShadow__VTableFunc_2167DC0: // 0x02167DC0
	stmdb sp!, {r4, lr}
	ldr r1, _02167DE4 // =_ZTV9CViShadow+0x08
	mov r4, r0
	str r1, [r4]
	bl ViShadow__Func_2167E9C
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167DE4: .word _ZTV9CViShadow+0x08
	arm_func_end ViShadow__VTableFunc_2167DC0

	arm_func_start ViShadow__LoadAssets
ViShadow__LoadAssets: // 0x02167DE8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r0
	bl ViShadow__Func_2167E9C
	ldr r0, _02167E98 // =aNarcViShadowLz
	mvn r1, #0
	bl BundleFileUnknown__LoadFile
	str r0, [r4, #4]
	mov r1, #0
	bl FileUnknown__GetAOUFileSize
	mov r8, r0
	ldr r0, [r4, #4]
	mov r1, #1
	bl FileUnknown__GetAOUFileSize
	mov r7, r0
	ldr r0, [r4, #4]
	mov r1, #0
	bl FileUnknown__GetAOUFile
	mov r6, r0
	ldr r0, [r4, #4]
	mov r1, #1
	bl FileUnknown__GetAOUFile
	mov r5, r0
	mov r0, r8
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r7, r7, lsr #1
	str r0, [r4, #8]
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl VRAMSystem__AllocPalette
	str r0, [r4, #0xc]
	ldr r3, [r4, #8]
	mov r1, r8
	mov r0, r6
	mov r2, #1
	bl QueueUncompressedPixels
	mov r1, r7, lsl #0x10
	ldr r3, [r4, #0xc]
	mov r0, r5
	mov r1, r1, lsr #0x10
	mov r2, #5
	bl QueueUncompressedPalette
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02167E98: .word aNarcViShadowLz
	arm_func_end ViShadow__LoadAssets

	arm_func_start ViShadow__Func_2167E9C
ViShadow__Func_2167E9C: // 0x02167E9C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _02167EBC
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #4]
_02167EBC:
	ldr r0, [r4, #8]
	tst r0, #0x80000000
	beq _02167ED4
	bl VRAMSystem__FreeTexture
	mov r0, #0
	str r0, [r4, #8]
_02167ED4:
	ldr r0, [r4, #0xc]
	tst r0, #0x80000000
	beq _02167EEC
	bl VRAMSystem__FreePalette
	mov r0, #0
	str r0, [r4, #0xc]
_02167EEC:
	mov r0, #0x6000
	str r0, [r4, #0x10]
	mov r0, #0xf
	strh r0, [r4, #0x14]
	ldmia sp!, {r4, pc}
	arm_func_end ViShadow__Func_2167E9C

	arm_func_start ViShadow__Func_2167F00
ViShadow__Func_2167F00: // 0x02167F00
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x7c
	mov r4, r1
	mov r5, r0
	mov r3, #2
	add r1, sp, #0x18
	mov r0, #0x10
	mov r2, #1
	str r3, [sp, #0x18]
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r2, r1
	mov r0, #0x11
	bl NNS_G3dGeBufferOP_N
	ldr r1, [r5, #0x10]
	mov r0, #0x1000
	str r0, [sp, #0x20]
	str r1, [sp, #0x1c]
	ldr r1, [r5, #0x10]
	add r0, sp, #0x1c
	str r1, [sp, #0x24]
	bl NNS_G3dGlbSetBaseScale
	add r0, sp, #0x28
	bl MTX_Identity33_
	ldr r1, _0216809C // =NNS_G3dGlb+0x000000BC
	add r0, sp, #0x28
	bl MI_Copy36B
	ldr r1, _021680A0 // =NNS_G3dGlb
	add r0, sp, #0x1c
	ldr r2, [r1, #0xfc]
	bic r2, r2, #0xa4
	str r2, [r1, #0xfc]
	ldr r2, [r4, #0]
	ldr r1, [r5, #0x10]
	sub r1, r2, r1, asr #1
	str r1, [sp, #0x1c]
	ldr r1, [r4, #4]
	add r1, r1, #0x400
	str r1, [sp, #0x20]
	ldr r2, [r4, #8]
	ldr r1, [r5, #0x10]
	sub r1, r2, r1, asr #1
	str r1, [sp, #0x24]
	bl NNS_G3dGlbSetBaseTrans
	bl NNS_G3dGlbFlushVP
	ldrh r2, [r5, #0x14]
	mov r0, #0x29
	add r1, sp, #0x14
	mov r2, r2, lsl #0x10
	orr r2, r2, #0xc0
	str r2, [sp, #0x14]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldr r2, [r5, #8]
	ldr r0, _021680A4 // =0x0007FFFF
	ldr r1, _021680A8 // =0x69B00000
	and r0, r2, r0
	orr r0, r1, r0, lsr #3
	str r0, [sp, #0x10]
	mov r0, #0x2a
	add r1, sp, #0x10
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldr r2, [r5, #0xc]
	ldr r1, _021680AC // =0x0001FFFF
	mov r0, #0x2b
	and r1, r2, r1
	mov r1, r1, lsr #3
	str r1, [sp, #0xc]
	add r1, sp, #0xc
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, #3
	str r0, [sp, #8]
	mov r0, #0x10
	add r1, sp, #8
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, sp, #0x4c
	bl MTX_Identity43_
	mov r3, #0x40000
	add r1, sp, #0x4c
	mov r0, #0x17
	mov r2, #0xc
	str r3, [sp, #0x4c]
	str r3, [sp, #0x5c]
	bl NNS_G3dGeBufferOP_N
	ldr r3, _021680B0 // =0x00007FFF
	add r1, sp, #4
	mov r0, #0x20
	mov r2, #1
	str r3, [sp, #4]
	bl NNS_G3dGeBufferOP_N
	ldr r0, _021680B4 // =0x02173158
	mov r1, #0x38
	bl NNS_G3dGeSendDL
	mov r2, #1
	add r1, sp, #0
	mov r0, #0x12
	str r2, [sp]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x7c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216809C: .word NNS_G3dGlb+0x000000BC
_021680A0: .word NNS_G3dGlb
_021680A4: .word 0x0007FFFF
_021680A8: .word 0x69B00000
_021680AC: .word 0x0001FFFF
_021680B0: .word 0x00007FFF
_021680B4: .word 0x02173158
	arm_func_end ViShadow__Func_2167F00

	arm_func_start ViShadow__Func_21680B8
ViShadow__Func_21680B8: // 0x021680B8
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r5, r1
	mov r6, r0
	cmp r5, #4
	addls pc, pc, r5, lsl #2
	b _0216810C
_021680D4: // jump table
	b _021680E8 // case 0
	b _021680F8 // case 1
	b _02168100 // case 2
	b _02168108 // case 3
	b _021680F0 // case 4
_021680E8:
	mov r0, #1
	b _0216810C
_021680F0:
	mov r0, #0x10
	b _0216810C
_021680F8:
	mov r0, #2
	b _0216810C
_02168100:
	mov r0, #4
	b _0216810C
_02168108:
	mov r0, #8
_0216810C:
	ldr r1, [sp, #0x18]
	mov lr, #0
	cmp r1, #0
	mov ip, #1
	beq _0216814C
_02168120:
	tst r0, ip, lsl lr
	beq _0216813C
	add r1, r6, lr, lsl #1
	add r1, r1, #0x100
	ldrh r4, [r1, #0xc]
	orr r4, r4, #2
	strh r4, [r1, #0xc]
_0216813C:
	add lr, lr, #1
	cmp lr, #5
	blo _02168120
	b _02168174
_0216814C:
	tst r0, ip, lsl lr
	beq _02168168
	add r1, r6, lr, lsl #1
	add r1, r1, #0x100
	ldrh r4, [r1, #0xc]
	bic r4, r4, #2
	strh r4, [r1, #0xc]
_02168168:
	add lr, lr, #1
	cmp lr, #5
	blo _0216814C
_02168174:
	ldr r1, [sp, #0x1c]
	mov lr, #0
	cmp r1, #0
	mov ip, #1
	beq _021681B4
_02168188:
	tst r0, ip, lsl lr
	beq _021681A4
	add r1, r6, lr, lsl #1
	add r1, r1, #0x100
	ldrh r4, [r1, #0xc]
	orr r4, r4, #4
	strh r4, [r1, #0xc]
_021681A4:
	add lr, lr, #1
	cmp lr, #5
	blo _02168188
	b _021681DC
_021681B4:
	tst r0, ip, lsl lr
	beq _021681D0
	add r1, r6, lr, lsl #1
	add r1, r1, #0x100
	ldrh r4, [r1, #0xc]
	bic r4, r4, #4
	strh r4, [r1, #0xc]
_021681D0:
	add lr, lr, #1
	cmp lr, #5
	blo _021681B4
_021681DC:
	add r0, r6, r5, lsl #2
	ldr r0, [r0, #0xe4]
	mov r4, #0
	cmp r0, #0
	ldrne r4, [r0, #0]
	ldr ip, [sp, #0x24]
	mov r0, r6
	mov r1, r5
	str ip, [sp]
	bl AnimatorMDL__SetAnimation
	ldr r0, [sp, #0x20]
	cmp r0, #0
	addne r0, r6, r5, lsl #2
	ldrne r1, [r0, #0xe4]
	cmpne r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r0, [r1, #8]
	ldrh r0, [r0, #4]
	cmp r4, r0, lsl #12
	movgt r4, #0
	str r4, [r1]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	arm_func_end ViShadow__Func_21680B8

	arm_func_start Vi3dArrow__Constructor
Vi3dArrow__Constructor: // 0x0216823C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ViDockNpc__Func_2167384
	ldr r0, _02168264 // =_ZTV10CVi3dArrow+0x08
	mov r1, #0
	str r0, [r4]
	str r1, [r4, #0x300]
	mov r0, r4
	str r1, [r4, #0x304]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02168264: .word _ZTV10CVi3dArrow+0x08
	arm_func_end Vi3dArrow__Constructor

	arm_func_start Vi3dArrow__VTableFunc_2168268
Vi3dArrow__VTableFunc_2168268: // 0x02168268
	stmdb sp!, {r4, lr}
	ldr r1, _0216828C // =_ZTV10CVi3dArrow+0x08
	mov r4, r0
	str r1, [r4]
	bl Vi3dArrow__Func_2168358
	mov r0, r4
	bl Vi3dObject__Func_216761C
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216828C: .word _ZTV10CVi3dArrow+0x08
	arm_func_end Vi3dArrow__VTableFunc_2168268

	arm_func_start Vi3dArrow__VTableFunc_2168290
Vi3dArrow__VTableFunc_2168290: // 0x02168290
	stmdb sp!, {r4, lr}
	ldr r1, _021682BC // =_ZTV10CVi3dArrow+0x08
	mov r4, r0
	str r1, [r4]
	bl Vi3dArrow__Func_2168358
	mov r0, r4
	bl Vi3dObject__Func_216761C
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021682BC: .word _ZTV10CVi3dArrow+0x08
	arm_func_end Vi3dArrow__VTableFunc_2168290

	arm_func_start Vi3dArrow__LoadAssets
Vi3dArrow__LoadAssets: // 0x021682C0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	bl Vi3dArrow__Func_2168358
	ldr r0, _02168350 // =aBbViNpcBb_0
	mov r1, #0x1c
	mov r2, #0
	bl BundleFileUnknown__LoadFileFromBundle
	str r0, [r4, #0x300]
	ldr r0, _02168350 // =aBbViNpcBb_0
	mov r1, #0x1d
	mov r2, #0
	bl BundleFileUnknown__LoadFileFromBundle
	str r0, [r4, #0x304]
	mov r2, #0
	str r2, [sp]
	ldr r1, [r4, #0x304]
	ldr r0, _02168354 // =0x0000FFFF
	stmib sp, {r1, r2}
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	ldr r1, [r4, #0x300]
	mov r0, r4
	mov r3, r2
	bl Vi3dObject__Func_216763C
	mov r1, #0
	str r1, [sp]
	mov r0, r4
	mov r2, #1
	mov r3, r1
	str r1, [sp, #4]
	bl Vi3dObject__Func_2167900
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02168350: .word aBbViNpcBb_0
_02168354: .word 0x0000FFFF
	arm_func_end Vi3dArrow__LoadAssets

	arm_func_start Vi3dArrow__Func_2168358
Vi3dArrow__Func_2168358: // 0x02168358
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl Vi3dObject__Func_21677C4
	ldr r0, [r4, #0x304]
	cmp r0, #0
	beq _0216837C
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x304]
_0216837C:
	ldr r0, [r4, #0x300]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x300]
	ldmia sp!, {r4, pc}
	arm_func_end Vi3dArrow__Func_2168358
	
	.data

.public _ZTI11CVi3dObject_1
_ZTI11CVi3dObject_1: // 0x021738A8
    .word _ZTVN10__cxxabiv117__class_type_infoE+8, _ZTS11CVi3dObject

.public _ZTI9CViShadow
_ZTI9CViShadow: // 0x021738B0
    .word _ZTVN10__cxxabiv117__class_type_infoE+8, _ZTS9CViShadow

.public _ZTI10CVi3dArrow
_ZTI10CVi3dArrow: // 0x021738B8
    .word _ZTVN10__cxxabiv120__si_class_type_infoE+8, _ZTS10CVi3dArrow, _ZTI11CVi3dObject

.public _ZTS9CViShadow
_ZTS9CViShadow: // 0x021738C4
	.asciz "9CViShadow"
	.align 4

.public _ZTS10CVi3dArrow
_ZTS10CVi3dArrow: // 0x021738D0
	.asciz "10CVi3dArrow"
	.align 4

.public _ZTV11CVi3dObject
_ZTV11CVi3dObject: // 0x021738E0
    .word 0, _ZTI11CVi3dObject
_021738E8: // 0x021738E8
    .word Vi3dObject__VTableFunc_21675D4, Vi3dObject__VTableFunc_21675F4

.public _ZTV10CVi3dArrow
_ZTV10CVi3dArrow: // 0x021738F0
    .word 0, _ZTI10CVi3dArrow
    .word Vi3dArrow__VTableFunc_2168268, Vi3dArrow__VTableFunc_2168290

.public _ZTV9CViShadow
_ZTV9CViShadow: // 0x02173900
    .word 0, _ZTI9CViShadow
    .word ViShadow__VTableFunc_2167DA0, ViShadow__VTableFunc_2167DC0

aNarcViShadowLz: // 0x02173910
	.asciz "narc/vi_shadow_lz7.narc"
	.align 4

aBbViNpcBb_0: // 0x02173928
	.asciz "bb/vi_npc.bb"
	.align 4
