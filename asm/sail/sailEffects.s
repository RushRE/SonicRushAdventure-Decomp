	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start EffectSailWaterSprayFront__Create
EffectSailWaterSprayFront__Create: // 0x021607C8
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, _02160938 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #3
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	str r6, [sp]
	str r0, [sp, #4]
	mov r0, r4
	mov r1, #0
	ldr r2, _0216093C // =aSbWater00Nsbmd_0
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #4
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02160940 // =aSbWater00Nsbca
	bl ObjAction3dNNMotionLoad
	mov r0, #5
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02160944 // =aSbWater00Nsbtp
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	ldr r6, [r4, #0x12c]
	ldr r0, [r6, #0x144]
	bl NNS_G3dGetTex
	str r0, [sp]
	mov r0, r6
	ldr r2, [r6, #0x150]
	mov r1, #2
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	bl SailObject_InitCommon
	ldr r1, _02160948 // =EffectSailWaterSprayFront__State_216433C
	mov r0, r4
	str r1, [r4, #0xf4]
	mov r1, r5
	mov r2, #0
	bl StageTask__SetParent
	ldr r0, [r5, #0x124]
	ldrh r0, [r0, #0]
	cmp r0, #0
	beq _021608F0
	cmp r0, #1
	beq _02160910
	cmp r0, #2
	bne _0216092C
_021608F0:
	mov r0, #0x400
	rsb r0, r0, #0
	str r0, [r4, #0x6c]
	mov r0, #0x1800
	str r0, [r4, #0x70]
	mov r0, #0x400
	str r0, [r4, #0x2c]
	b _0216092C
_02160910:
	mov r0, #0x400
	rsb r0, r0, #0
	str r0, [r4, #0x6c]
	mov r0, #0x9c00
	str r0, [r4, #0x70]
	mov r0, #0x400
	str r0, [r4, #0x2c]
_0216092C:
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02160938: .word 0x00001010
_0216093C: .word aSbWater00Nsbmd_0
_02160940: .word aSbWater00Nsbca
_02160944: .word aSbWater00Nsbtp
_02160948: .word EffectSailWaterSprayFront__State_216433C
	arm_func_end EffectSailWaterSprayFront__Create

	arm_func_start EffectSailWaterSprayBack__Create
EffectSailWaterSprayBack__Create: // 0x0216094C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, _02160AD0 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #6
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	str r6, [sp]
	str r0, [sp, #4]
	mov r0, r4
	mov r1, #0
	ldr r2, _02160AD4 // =aSbWater01Nsbmd_0
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #7
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02160AD8 // =aSbWater01Nsbca
	bl ObjAction3dNNMotionLoad
	mov r0, #8
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02160ADC // =aSbWater01Nsbta
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	ldr r0, [r4, #0x12c]
	mov r3, #0
	str r3, [sp]
	mov r1, #3
	ldr r2, [r0, #0x154]
	bl AnimatorMDL__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	bl SailObject_InitCommon
	ldr r1, _02160AE0 // =EffectSailWaterSprayFront__State_216433C
	mov r0, r4
	str r1, [r4, #0xf4]
	mov r1, r5
	mov r2, #0
	bl StageTask__SetParent
	ldr r0, [r5, #0x124]
	ldrh r0, [r0, #0]
	cmp r0, #0
	beq _02160A68
	cmp r0, #1
	beq _02160A94
	cmp r0, #2
	bne _02160AC4
_02160A68:
	mov r0, #0x400
	rsb r0, r0, #0
	str r0, [r4, #0x6c]
	sub r0, r0, #0xc00
	str r0, [r4, #0x70]
	mov r0, #0x400
	str r0, [r4, #0x2c]
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	b _02160AC4
_02160A94:
	mov r1, #0x3a00
	rsb r1, r1, #0
	str r1, [r4, #0x68]
	add r0, r1, #0x3600
	str r0, [r4, #0x6c]
	sub r0, r1, #0x5c00
	str r0, [r4, #0x70]
	mov r0, #0x400
	str r0, [r4, #0x2c]
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
_02160AC4:
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02160AD0: .word 0x00001010
_02160AD4: .word aSbWater01Nsbmd_0
_02160AD8: .word aSbWater01Nsbca
_02160ADC: .word aSbWater01Nsbta
_02160AE0: .word EffectSailWaterSprayFront__State_216433C
	arm_func_end EffectSailWaterSprayBack__Create

	arm_func_start EffectSailSubmarineWater__Create
EffectSailSubmarineWater__Create: // 0x02160AE4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, _02160C28 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #6
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	str r6, [sp]
	str r0, [sp, #4]
	mov r0, r4
	mov r1, #0
	ldr r2, _02160C2C // =aSbSubWaterNsbm_0
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #7
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02160C30 // =aSbSubWaterNsbc
	bl ObjAction3dNNMotionLoad
	mov r0, #8
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02160C34 // =aSbSubWaterNsbt
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	ldr r0, [r4, #0x12c]
	mov r3, #0
	str r3, [sp]
	mov r1, #3
	ldr r2, [r0, #0x154]
	bl AnimatorMDL__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	bl SailObject_InitCommon
	ldr r1, _02160C38 // =EffectSailSubmarineWater__State_2164474
	mov r0, r4
	str r1, [r4, #0xf4]
	mov r1, r5
	mov r2, #0
	bl StageTask__SetParent
	ldr r0, [r5, #0x124]
	ldrh r0, [r0, #0]
	cmp r0, #3
	bne _02160C1C
	mov r1, #0x1400
	rsb r1, r1, #0
	mov r0, #0x2e00
	str r1, [r4, #0x68]
	str r0, [r4, #0x6c]
	sub r0, r0, #0xc000
	str r0, [r4, #0x70]
	mov r0, #0x500
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
_02160C1C:
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02160C28: .word 0x00001010
_02160C2C: .word aSbSubWaterNsbm_0
_02160C30: .word aSbSubWaterNsbc
_02160C34: .word aSbSubWaterNsbt
_02160C38: .word EffectSailSubmarineWater__State_2164474
	arm_func_end EffectSailSubmarineWater__Create

	arm_func_start EffectSailSubmarineWater2__Create
EffectSailSubmarineWater2__Create: // 0x02160C3C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, _02160D90 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #6
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	str r6, [sp]
	str r0, [sp, #4]
	mov r0, r4
	mov r1, #0
	ldr r2, _02160D94 // =aSbSubWaterNsbm_0
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #7
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02160D98 // =aSbSubWaterNsbc
	bl ObjAction3dNNMotionLoad
	mov r0, #8
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02160D9C // =aSbSubWaterNsbt
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	ldr r0, [r4, #0x12c]
	mov r3, #0
	str r3, [sp]
	mov r1, #3
	ldr r2, [r0, #0x154]
	bl AnimatorMDL__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	bl SailObject_InitCommon
	ldr r1, _02160DA0 // =EffectSailSubmarineWater2__State_21644D8
	mov r0, r4
	str r1, [r4, #0xf4]
	mov r1, r5
	mov r2, #0
	bl StageTask__SetParent
	ldr r1, [r4, #0x12c]
	ldr r0, [r5, #0x12c]
	add r5, r1, #0x24
	add ip, r0, #0x24
	ldmia ip!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia ip!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldr r1, [ip]
	mov r0, #0
	str r1, [r5]
	str r0, [r4, #0x68]
	str r0, [r4, #0x6c]
	str r0, [r4, #0x70]
	mov r0, #0x400
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	mov r1, #0x800
	mov r0, r4
	str r1, [r4, #0x40]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02160D90: .word 0x00001010
_02160D94: .word aSbSubWaterNsbm_0
_02160D98: .word aSbSubWaterNsbc
_02160D9C: .word aSbSubWaterNsbt
_02160DA0: .word EffectSailSubmarineWater2__State_21644D8
	arm_func_end EffectSailSubmarineWater2__Create

	arm_func_start EffectSailWaterSplash__Create
EffectSailWaterSplash__Create: // 0x02160DA4
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, _02160E44 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0xc
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, _02160E48 // =0x0000FFFF
	ldr r2, _02160E4C // =aSbWaterBac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x134]
	mov r1, #0x1d
	strb r1, [r0, #0xa]
	ldr r1, [r4, #0x134]
	mov r2, #7
	mov r0, r4
	strb r2, [r1, #0xb]
	bl SailObject_InitCommon
	ldr r1, _02160E50 // =EffectSailWaterSplash__State_21644E4
	mov r0, #0x40
	str r1, [r4, #0xf4]
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	add r3, r4, #0x44
	ldmia r5, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02160E44: .word 0x00001010
_02160E48: .word 0x0000FFFF
_02160E4C: .word aSbWaterBac
_02160E50: .word EffectSailWaterSplash__State_21644E4
	arm_func_end EffectSailWaterSplash__Create

	arm_func_start EffectSailHit__Create
EffectSailHit__Create: // 0x02160E54
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, _02160EF0 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x19
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, _02160EF4 // =0x0000FFFF
	ldr r2, _02160EF8 // =aSbHitBac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x134]
	mov r1, #0x1c
	strb r1, [r0, #0xa]
	ldr r1, [r4, #0x134]
	mov r2, #7
	mov r0, r4
	strb r2, [r1, #0xb]
	bl SailObject_InitCommon
	add ip, r4, #0x44
	ldmia r5, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r3, _02160EFC // =EffectSailWaterSplash__State_21644E4
	mov r0, r4
	str r3, [r4, #0xf4]
	ldr r1, [r4, #0x24]
	orr r1, r1, #1
	str r1, [r4, #0x24]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02160EF0: .word 0x00001010
_02160EF4: .word 0x0000FFFF
_02160EF8: .word aSbHitBac
_02160EFC: .word EffectSailWaterSplash__State_21644E4
	arm_func_end EffectSailHit__Create

	arm_func_start EffectSailGuard__Create
EffectSailGuard__Create: // 0x02160F00
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, _02160FCC // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x1a
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, _02160FD0 // =0x0000FFFF
	ldr r2, _02160FD4 // =aSbGuardBac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x134]
	mov r1, #0x1c
	strb r1, [r0, #0xa]
	ldr r1, [r4, #0x134]
	mov r2, #7
	mov r0, r4
	strb r2, [r1, #0xb]
	bl SailObject_InitCommon
	add lr, r4, #0x44
	ldmia r5, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	ldr ip, _02160FD8 // =EffectSailWaterSplash__State_21644E4
	mov r3, #0x800
	str ip, [r4, #0xf4]
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #1
	str r1, [r4, #0x24]
	ldr r2, [r4, #0x38]
	adds r1, r3, r2, lsl #13
	mov r3, r1, lsr #0xc
	mov r1, r2, asr #0x1f
	mov r1, r1, lsl #0xd
	orr r1, r1, r2, lsr #19
	adc r1, r1, #0
	orr r3, r3, r1, lsl #20
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	str r3, [r4, #0x40]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02160FCC: .word 0x00001010
_02160FD0: .word 0x0000FFFF
_02160FD4: .word aSbGuardBac
_02160FD8: .word EffectSailWaterSplash__State_21644E4
	arm_func_end EffectSailGuard__Create

	arm_func_start EffectCreateSailBomb
EffectCreateSailBomb: // 0x02160FDC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r7, r0
	bl SailManager__GetWork
	ldr r5, [r0, #0xa0]
	ldr r0, _02161174 // =0x00001010
	mov r1, #1
	mov r6, #5
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x18
	bl GetObjectFileWork
	mov r8, r0
	bl SailManager__GetArchive
	ldr r3, _02161178 // =0x0000FFFF
	ldr r2, _0216117C // =aSbBombBac
	stmia sp, {r3, r8}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x134]
	mov r1, #0x1d
	strb r1, [r0, #0xa]
	ldr r1, [r4, #0x134]
	mov r2, #7
	mov r0, r4
	strb r2, [r1, #0xb]
	bl SailObject_InitCommon
	add r3, r4, #0x44
	ldmia r7, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	bl SailManager__GetShipType
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02161084
_02161074: // jump table
	b _02161084 // case 0
	b _021610A4 // case 1
	b _02161094 // case 2
	b _021610B4 // case 3
_02161084:
	ldr r0, [r4, #0x48]
	sub r0, r0, #0x400
	str r0, [r4, #0x48]
	b _02161160
_02161094:
	ldr r0, [r4, #0x48]
	sub r0, r0, #0x800
	str r0, [r4, #0x48]
	b _02161160
_021610A4:
	ldr r0, [r4, #0x48]
	sub r0, r0, #0x2000
	str r0, [r4, #0x48]
	b _02161160
_021610B4:
	ldr r0, [r4, #0x48]
	ldr ip, _02161180 // =_obj_disp_rand
	sub r0, r0, #0x400
	str r0, [r4, #0x48]
	ldr r0, [ip]
	ldr r3, _02161184 // =0x00196225
	ldr r7, _02161188 // =0x3C6EF35F
	ldr r1, _0216118C // =0x000001FE
	mla lr, r0, r3, r7
	mov r0, lr, lsr #0x10
	mov r0, r0, lsl #0x10
	mvn r2, #0xa0
	and r0, r1, r0, lsr #16
	str lr, [ip]
	sub r0, r2, r0
	str r0, [r4, #0x9c]
	ldr r0, [ip]
	add r1, r2, #0xa0
	mla r2, r0, r3, r7
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x3e
	str r2, [ip]
	sub r0, r1, r0
	str r0, [r4, #0xa8]
	ldrh r0, [r5, #0x40]
	mov r5, #0
	cmp r0, #4
	movhi r6, #2
	cmp r0, #6
	movhi r6, #1
	cmp r0, #8
	movhi r6, #0
	cmp r6, #0
	bls _02161160
_02161144:
	add r0, r4, #0x44
	bl EffectSailBomb2__Create
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	cmp r6, r0, lsr #16
	mov r5, r0, lsr #0x10
	bhi _02161144
_02161160:
	ldr r1, _02161190 // =EffectSailWaterSplash__State_21644E4
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02161174: .word 0x00001010
_02161178: .word 0x0000FFFF
_0216117C: .word aSbBombBac
_02161180: .word _obj_disp_rand
_02161184: .word 0x00196225
_02161188: .word 0x3C6EF35F
_0216118C: .word 0x000001FE
_02161190: .word EffectSailWaterSplash__State_21644E4
	arm_func_end EffectCreateSailBomb

	arm_func_start EffectSailBomb2__Create
EffectSailBomb2__Create: // 0x02161194
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, _0216135C // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x18
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, _02161360 // =0x0000FFFF
	ldr r2, _02161364 // =aSbBombBac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x134]
	mov r1, #0x1d
	strb r1, [r0, #0xa]
	ldr r1, [r4, #0x134]
	mov r2, #7
	strb r2, [r1, #0xb]
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimation
	mov r0, r4
	bl SailObject_InitCommon
	add r7, r4, #0x44
	ldmia r5, {r0, r1, r2}
	stmia r7, {r0, r1, r2}
	ldr r0, [r4, #0x24]
	ldr r6, _02161368 // =0x00007FFE
	orr r0, r0, #1
	ldr lr, _0216136C // =_obj_disp_rand
	str r0, [r4, #0x24]
	ldr r3, _02161370 // =0x00196225
	ldr ip, _02161374 // =0x3C6EF35F
	ldr r0, [lr]
	sub r1, r6, #0x4000
	mla r2, r0, r3, ip
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	str r2, [lr]
	and r0, r6, r0, lsr #16
	ldr r2, [r4, #0x44]
	rsb r0, r0, r6, lsr #1
	add r0, r2, r0
	str r0, [r4, #0x44]
	ldr r0, [lr]
	mla r2, r0, r3, ip
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	and r0, r1, r0, lsr #16
	str r2, [lr]
	ldr r1, [r4, #0x48]
	rsb r0, r0, r6, lsr #2
	add r0, r1, r0
	str r0, [r4, #0x48]
	ldr r0, [lr]
	mla r1, r0, r3, ip
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	str r1, [lr]
	and r0, r6, r0, lsr #16
	ldr r1, [r4, #0x4c]
	rsb r0, r0, r6, lsr #1
	add r0, r1, r0
	str r0, [r4, #0x4c]
	ldr r0, [lr]
	mla r1, r0, r3, ip
	str r1, [lr]
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	sub r1, r6, #0x7e00
	and r0, r1, r0, lsr #16
	mvn r1, #0
	sub r0, r1, r0
	str r0, [r4, #0x9c]
	ldr r0, [lr]
	ldr r2, _02161378 // =EffectSailWaterSplash__State_21644E4
	mla r5, r0, r3, ip
	mov r0, r5, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x3e
	str r5, [lr]
	sub r0, r1, r0
	str r0, [r4, #0xa8]
	ldr r1, [lr]
	mov r0, r4
	mla r5, r1, r3, ip
	mov r1, r5, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0xfe
	str r5, [lr]
	rsb r1, r1, #0x7f
	str r1, [r4, #0x98]
	ldr r1, [lr]
	mla r3, r1, r3, ip
	mov r1, r3, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0xfe
	str r3, [lr]
	rsb r1, r1, #0x7f
	str r1, [r4, #0xa0]
	str r2, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216135C: .word 0x00001010
_02161360: .word 0x0000FFFF
_02161364: .word aSbBombBac
_02161368: .word 0x00007FFE
_0216136C: .word _obj_disp_rand
_02161370: .word 0x00196225
_02161374: .word 0x3C6EF35F
_02161378: .word EffectSailWaterSplash__State_21644E4
	arm_func_end EffectSailBomb2__Create

	arm_func_start EffectSailFire__Create
EffectSailFire__Create: // 0x0216137C
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, _02161438 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x54
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r1, #0
	stmia sp, {r1, r6}
	str r0, [sp, #8]
	ldr r2, _0216143C // =aSbFireBac_0
	mov r0, r4
	mov r3, r1
	bl ObjObjectAction3dBACLoad
	mov r0, #0x6b
	bl GetObjectFileWork
	mov r1, #0
	mov r3, r0
	mov r0, r4
	mov r2, r1
	bl ObjObjectActionAllocTexture
	ldr r1, [r4, #0x134]
	mov r3, #0x1c
	ldr r0, [r1, #0xcc]
	mov r2, #7
	orr r0, r0, #0x18
	str r0, [r1, #0xcc]
	ldr r1, [r4, #0x134]
	mov r0, r4
	strb r3, [r1, #0xa]
	ldr r1, [r4, #0x134]
	strb r2, [r1, #0xb]
	bl SailObject_InitCommon
	add ip, r4, #0x44
	ldmia r5, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r3, _02161440 // =EffectSailWaterSplash__State_21644E4
	mov r0, r4
	str r3, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02161438: .word 0x00001010
_0216143C: .word aSbFireBac_0
_02161440: .word EffectSailWaterSplash__State_21644E4
	arm_func_end EffectSailFire__Create

	arm_func_start EffectSailSmoke__Create
EffectSailSmoke__Create: // 0x02161444
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, _021614D4 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x1b
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, _021614D8 // =0x0000FFFF
	ldr r2, _021614DC // =aSbSmokeBac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x134]
	mov r1, #0x1d
	strb r1, [r0, #0xa]
	ldr r1, [r4, #0x134]
	mov r2, #7
	mov r0, r4
	strb r2, [r1, #0xb]
	bl SailObject_InitCommon
	add ip, r4, #0x44
	ldmia r5, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r3, _021614E0 // =EffectSailWaterSplash__State_21644E4
	mov r0, r4
	str r3, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_021614D4: .word 0x00001010
_021614D8: .word 0x0000FFFF
_021614DC: .word aSbSmokeBac
_021614E0: .word EffectSailWaterSplash__State_21644E4
	arm_func_end EffectSailSmoke__Create

	arm_func_start EffectUnknown21614E4__Create
EffectUnknown21614E4__Create: // 0x021614E4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r2, #0x1000
	mov r1, #0
	mov r5, r0
	str r2, [sp]
	mov r4, #1
	ldr r0, _02161540 // =EffectUnknown21614E4__Main
	mov r2, r1
	mov r3, r1
	str r4, [sp, #4]
	mov r4, #8
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear16
	str r5, [r4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02161540: .word EffectUnknown21614E4__Main
	arm_func_end EffectUnknown21614E4__Create

	arm_func_start EffectUnknown2161544__Create
EffectUnknown2161544__Create: // 0x02161544
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r2, #0x1000
	mov r6, r0
	mov r5, r1
	mov r1, #0
	str r2, [sp]
	mov r4, #1
	str r4, [sp, #4]
	mov r4, #0x14
	ldr r0, _021615C4 // =EffectUnknown2161544__Main
	mov r2, r1
	mov r3, r1
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x14
	bl MIi_CpuClear16
	cmp r5, #0
	addeq sp, sp, #0xc
	str r6, [r4]
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r0, [r4, #0]
	mov r1, r5
	add r0, r0, #0x44
	add r2, r4, #4
	bl VEC_Subtract
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_021615C4: .word EffectUnknown2161544__Main
	arm_func_end EffectUnknown2161544__Create

	arm_func_start EffectUnknown21615C8__Create
EffectUnknown21615C8__Create: // 0x021615C8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r2, #0x1000
	mov r5, r0
	mov r1, #0
	str r2, [sp]
	mov r3, #1
	ldr r0, _02161634 // =EffectUnknown21615C8__Main
	mov r2, r1
	str r3, [sp, #4]
	mov r4, #4
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #4
	bl MIi_CpuClear16
	str r5, [r4]
	mov r1, #1
	mov r2, r1
	mov r0, #0
	mov r3, r1
	bl BeginSysPause
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02161634: .word EffectUnknown21615C8__Main
	arm_func_end EffectUnknown21615C8__Create

	arm_func_start EffectUnknown2161638__Create
EffectUnknown2161638__Create: // 0x02161638
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r2, #0x1000
	mov r1, #0
	mov r5, r0
	str r2, [sp]
	mov r4, #1
	ldr r0, _02161694 // =EffectUnknown2161638__Main
	mov r2, r1
	mov r3, r1
	str r4, [sp, #4]
	mov r4, #0x160
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x160
	bl MIi_CpuClear16
	str r5, [r4, #4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02161694: .word EffectUnknown2161638__Main
	arm_func_end EffectUnknown2161638__Create

	arm_func_start EffectSailBoost__Create
EffectSailBoost__Create: // 0x02161698
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r0, _021617F0 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x57
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	str r5, [sp]
	str r0, [sp, #4]
	mov r0, r4
	mov r1, #0
	ldr r2, _021617F4 // =aSbBoost01Nsbmd_0
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #0x58
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	mov r3, r5
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _021617F8 // =aSbBoost01Nsbca
	bl ObjAction3dNNMotionLoad
	mov r0, #0x59
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	mov r3, r5
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _021617FC // =aSbBoost01Nsbta
	bl ObjAction3dNNMotionLoad
	mov r0, #0x5a
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	mov r3, r5
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02161800 // =aSbBoost01Nsbva
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	ldr r0, [r4, #0x12c]
	mov r3, #0
	str r3, [sp]
	mov r1, #3
	ldr r2, [r0, #0x154]
	bl AnimatorMDL__SetAnimation
	ldr r0, [r4, #0x12c]
	mov r3, #0
	str r3, [sp]
	ldr r2, [r0, #0x158]
	mov r1, #4
	bl AnimatorMDL__SetAnimation
	mov r0, r4
	bl SailObject_InitCommon
	ldr r2, _02161804 // =EffectSailBoost__State_2163A5C
	mov r0, r4
	str r2, [r4, #0xf4]
	mov r1, r6
	mov r2, #0
	bl StageTask__SetParent
	ldr r0, [r6, #0x124]
	ldrh r0, [r0, #0]
	cmp r0, #0
	cmpne r0, #2
	moveq r0, #0
	streq r0, [r4, #0x6c]
	streq r0, [r4, #0x70]
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021617F0: .word 0x00001010
_021617F4: .word aSbBoost01Nsbmd_0
_021617F8: .word aSbBoost01Nsbca
_021617FC: .word aSbBoost01Nsbta
_02161800: .word aSbBoost01Nsbva
_02161804: .word EffectSailBoost__State_2163A5C
	arm_func_end EffectSailBoost__Create

	arm_func_start EffectSailBoost02__Create
EffectSailBoost02__Create: // 0x02161808
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, _02161944 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x5b
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	str r6, [sp]
	str r0, [sp, #4]
	mov r0, r4
	mov r1, #0
	ldr r2, _02161948 // =aSbBoost02Nsbmd_0
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #0x5c
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _0216194C // =aSbBoost02Nsbca
	bl ObjAction3dNNMotionLoad
	mov r0, #0x5d
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02161950 // =aSbBoost02Nsbtp
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	ldr r6, [r4, #0x12c]
	ldr r0, [r6, #0x144]
	bl NNS_G3dGetTex
	str r0, [sp]
	mov r0, r6
	ldr r2, [r6, #0x150]
	mov r1, #2
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	bl SailObject_InitCommon
	ldr r1, _02161954 // =EffectSailBoost__State_2163A5C
	mov r0, r4
	str r1, [r4, #0xf4]
	mov r1, r5
	mov r2, #0
	bl StageTask__SetParent
	ldr r0, [r5, #0x124]
	ldrh r0, [r0, #0]
	cmp r0, #0
	cmpne r0, #2
	bne _02161938
	mov r0, #0x400
	rsb r0, r0, #0
	str r0, [r4, #0x6c]
	mov r0, #0x1800
	str r0, [r4, #0x70]
_02161938:
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02161944: .word 0x00001010
_02161948: .word aSbBoost02Nsbmd_0
_0216194C: .word aSbBoost02Nsbca
_02161950: .word aSbBoost02Nsbtp
_02161954: .word EffectSailBoost__State_2163A5C
	arm_func_end EffectSailBoost02__Create

	arm_func_start EffectSailCircle__Create
EffectSailCircle__Create: // 0x02161958
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r0, _02161B00 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #0x5e
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	str r0, [sp, #4]
	mov r0, r5
	mov r1, #0
	ldr r2, _02161B04 // =aSbCircleNsbmd_0
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #0x5f
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	mov r3, r7
	str r0, [sp]
	mov r0, r5
	mov r1, #0
	ldr r2, _02161B08 // =aSbCircleNsbca
	bl ObjAction3dNNMotionLoad
	mov r0, #0x60
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	mov r3, r7
	str r0, [sp]
	mov r0, r5
	mov r1, #0
	ldr r2, _02161B0C // =aSbCircleNsbma
	bl ObjAction3dNNMotionLoad
	ldr r0, [r5, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	ldr r0, [r5, #0x12c]
	mov r3, #0
	str r3, [sp]
	mov r1, #1
	ldr r2, [r0, #0x14c]
	bl AnimatorMDL__SetAnimation
	mov r0, r5
	mov r1, #0x2000
	bl SailObject_SetAnimSpeed
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	mov r0, r5
	bl SailObject_InitCommon
	ldr r1, [r5, #0x18]
	ldr r0, _02161B10 // =EffectSailCircle__State_2163AC4
	orr r1, r1, #0x10
	str r1, [r5, #0x18]
	str r0, [r5, #0xf4]
	add r0, r6, #0x44
	add r3, r5, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #0
	str r0, [r5, #0x48]
	ldr r1, [r5, #0x1c]
	mov r0, r5
	orr r1, r1, #0x2000
	str r1, [r5, #0x1c]
	ldrh r1, [r6, #0x32]
	strh r1, [r5, #0x32]
	bl SailObject_ApplyRotation
	mov r0, r5
	add r1, r4, #0x28
	mov r2, #1
	bl SailObject_InitColliderForCommon
	mov r0, r5
	mov r1, #1
	mov r2, #0x1e00
	mov r3, #0
	bl SailObject_InitColliderBox
	ldrh r2, [r4, #0x9c]
	mov r0, r5
	mov r1, #1
	orr r2, r2, #0x100
	strh r2, [r4, #0x9c]
	ldr r3, [r5, #0x148]
	ldr r2, [r3, #0x18]
	orr r2, r2, #0x80
	str r2, [r3, #0x18]
	bl StageTask__GetCollider
	mov r1, #0x14
	strh r1, [r0, #0x2c]
	mov r0, r5
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02161B00: .word 0x00001010
_02161B04: .word aSbCircleNsbmd_0
_02161B08: .word aSbCircleNsbca
_02161B0C: .word aSbCircleNsbma
_02161B10: .word EffectSailCircle__State_2163AC4
	arm_func_end EffectSailCircle__Create

	arm_func_start EffectSailTrick__Create
EffectSailTrick__Create: // 0x02161B14
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, _02161BAC // =0x00000FF6
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x53
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, _02161BB0 // =0x0000FFFF
	ldr r2, _02161BB4 // =aSbTrickBac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, #0xf
	bl StageTask__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _02161BB8 // =EffectSailTrick__State_2163A3C
	orr r1, r1, #0x20000
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	add lr, r4, #0x44
	ldmia r5, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	mov ip, #1
	mov r3, #0x8000
	str ip, [r4, #0x4c]
	str r3, [r4, #4]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02161BAC: .word 0x00000FF6
_02161BB0: .word 0x0000FFFF
_02161BB4: .word aSbTrickBac
_02161BB8: .word EffectSailTrick__State_2163A3C
	arm_func_end EffectSailTrick__Create

	arm_func_start SailJetHUDCross__Create
SailJetHUDCross__Create: // 0x02161BBC
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, _02161C50 // =0x00000FF6
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x70
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r1, #0x10
	stmia sp, {r1, r6}
	str r0, [sp, #8]
	ldr r2, _02161C54 // =aSbJetLogoFixBa_0
	mov r0, r4
	mov r1, #0
	mov r3, #0x4a0
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _02161C58 // =EffectSailTrick__State_2163A3C
	orr r1, r1, #0x20000
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	add ip, r4, #0x44
	ldmia r5, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	mov r3, #1
	str r3, [r4, #0x4c]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02161C50: .word 0x00000FF6
_02161C54: .word aSbJetLogoFixBa_0
_02161C58: .word EffectSailTrick__State_2163A3C
	arm_func_end SailJetHUDCross__Create

	arm_func_start EffectSailWaterSplash2__Create
EffectSailWaterSplash2__Create: // 0x02161C5C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r0, _02161D74 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #9
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	str r5, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _02161D78 // =aSbWater02Nsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #0xa
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	str r0, [sp]
	ldr r2, _02161D7C // =aSbWater02Nsbca
	mov r3, r5
	mov r0, r4
	mov r1, #0
	bl ObjAction3dNNMotionLoad
	mov r0, #0xb
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	str r0, [sp]
	ldr r2, _02161D80 // =aSbWater02Nsbta
	mov r3, r5
	mov r0, r4
	mov r1, #0
	bl ObjAction3dNNMotionLoad
	mov r1, #0
	ldr r0, [r4, #0x12c]
	mov r3, r1
	str r1, [sp]
	ldr r2, [r0, #0x148]
	bl AnimatorMDL__SetAnimation
	ldr r0, [r4, #0x12c]
	mov r3, #0
	str r3, [sp]
	ldr r2, [r0, #0x154]
	mov r1, #3
	bl AnimatorMDL__SetAnimation
	mov r0, r4
	bl SailObject_InitCommon
	ldr r1, _02161D84 // =EffectSailWaterSplash2__State_21639F0
	mov r0, r4
	str r1, [r4, #0xf4]
	mov r1, r6
	mov r2, #0
	bl StageTask__SetParent
	ldr r0, [r6, #0x124]
	ldrh r0, [r0, #0]
	cmp r0, #0
	cmpne r0, #2
	moveq r0, #0x400
	rsbeq r0, r0, #0
	streq r0, [r4, #0x6c]
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02161D74: .word 0x00001010
_02161D78: .word aSbWater02Nsbmd_0
_02161D7C: .word aSbWater02Nsbca
_02161D80: .word aSbWater02Nsbta
_02161D84: .word EffectSailWaterSplash2__State_21639F0
	arm_func_end EffectSailWaterSplash2__Create

	arm_func_start EffectSailTrick2__Create
EffectSailTrick2__Create: // 0x02161D88
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r5, r0
	mov r7, r1
	ldr r0, _02161EA8 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x54
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	str r6, [sp]
	str r0, [sp, #4]
	mov r0, r4
	mov r1, #0
	ldr r2, _02161EAC // =aSbTrickNsbmd_0
	mov r3, r7
	bl ObjAction3dNNModelLoad
	mov r0, #0x55
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02161EB0 // =aSbTrickNsbca
	bl ObjAction3dNNMotionLoad
	mov r0, #0x56
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02161EB4 // =aSbTrickNsbtp
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r7
	bl AnimatorMDL__SetAnimation
	ldr r6, [r4, #0x12c]
	ldr r0, [r6, #0x144]
	bl NNS_G3dGetTex
	mov r3, r7
	str r0, [sp]
	mov r0, r6
	ldr r2, [r6, #0x150]
	mov r1, #2
	bl AnimatorMDL__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	bl SailObject_InitCommon
	ldr r1, _02161EB8 // =EffectSailTrick2__State_2163920
	mov r0, r4
	str r1, [r4, #0xf4]
	mov r1, r5
	mov r2, #0
	bl StageTask__SetParent
	ldr r1, [r5, #0x28]
	mov r0, r4
	str r1, [r4, #0x28]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02161EA8: .word 0x00001010
_02161EAC: .word aSbTrickNsbmd_0
_02161EB0: .word aSbTrickNsbca
_02161EB4: .word aSbTrickNsbtp
_02161EB8: .word EffectSailTrick2__State_2163920
	arm_func_end EffectSailTrick2__Create

	arm_func_start EffectSailTrick4__Create
EffectSailTrick4__Create: // 0x02161EBC
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, _02162000 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x54
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	str r6, [sp]
	str r0, [sp, #4]
	mov r0, r4
	mov r1, #0
	ldr r2, _02162004 // =aSbTrickNsbmd_0
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #0x55
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02162008 // =aSbTrickNsbca
	bl ObjAction3dNNMotionLoad
	mov r0, #0x56
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _0216200C // =aSbTrickNsbtp
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	ldr r6, [r4, #0x12c]
	ldr r0, [r6, #0x144]
	bl NNS_G3dGetTex
	str r0, [sp]
	mov r0, r6
	ldr r2, [r6, #0x150]
	mov r1, #2
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	mov r0, r4
	mov r1, #0x2000
	bl SailObject_SetAnimSpeed
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	bl SailObject_InitCommon
	ldr r2, _02162010 // =EffectSailTrick4__State_216397C
	mov r0, r4
	str r2, [r4, #0xf4]
	mov r1, r5
	mov r2, #0
	bl StageTask__SetParent
	ldr r0, [r5, #0x124]
	add r0, r0, #0x100
	ldrh r1, [r0, #0xc0]
	str r1, [r4, #0x28]
	ldrh r0, [r0, #0xc0]
	cmp r0, #0x10
	moveq r0, #0x1000
	rsbeq r0, r0, #0
	streq r0, [r4, #0x38]
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02162000: .word 0x00001010
_02162004: .word aSbTrickNsbmd_0
_02162008: .word aSbTrickNsbca
_0216200C: .word aSbTrickNsbtp
_02162010: .word EffectSailTrick4__State_216397C
	arm_func_end EffectSailTrick4__Create

	arm_func_start SailPlayerWeaponBullet__Create
SailPlayerWeaponBullet__Create: // 0x02162014
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x20
	mov r9, r0
	mov r8, r1
	ldr r0, _0216215C // =0x00001010
	mov r1, #1
	mov r7, r2
	ldr r6, [r9, #0x124]
	bl CreateStageTaskEx_
	mov r4, r0
	mov r1, #2
	bl StageTask__SetType
	mov r0, r4
	bl StageTask__InitSeqPlayer
	ldr r0, [r4, #0x138]
	mov r1, #0x17
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	ldr r1, _02162160 // =SailPlayerWeaponBullet__State_21636B0
	mov r0, r4
	str r1, [r4, #0xf4]
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	add r3, r4, #0x44
	ldmia r8, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x48]
	mov r0, r4
	rsb r1, r1, #0
	str r1, [r4, #0x48]
	ldr r2, [r4, #0x18]
	add r1, r5, #0x28
	orr r2, r2, #0x10
	str r2, [r4, #0x18]
	mov r2, #1
	bl SailObject_InitColliderForCommon
	mov r1, #0
	mov r0, r7
	str r1, [sp, #0x14]
	str r1, [sp, #0x18]
	str r1, [sp, #0x1c]
	mov r1, r8
	add r2, sp, #8
	bl VEC_Subtract
	add r1, sp, #8
	str r1, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r4
	mov r1, #1
	mov r2, #0x1000
	add r3, sp, #0x14
	bl SailObject_InitColliderLine
	ldrh r2, [r5, #0x9c]
	mov r1, #0x4000
	add r0, r6, #0x100
	orr r2, r2, #0x11
	strh r2, [r5, #0x9c]
	str r1, [r5, #0x98]
	ldrh r0, [r0, #0xce]
	mov r1, r9
	mov r2, #0
	cmp r0, #0
	ldrne r0, [r5, #0x98]
	addne r0, r0, r0, asr #1
	strne r0, [r5, #0x98]
	add r0, r6, #0x100
	ldrh r0, [r0, #0xce]
	cmp r0, #2
	ldrhs r0, [r5, #0x98]
	movhs r0, r0, lsl #1
	strhs r0, [r5, #0x98]
	mov r0, r4
	bl StageTask__SetParent
	mov r0, r8
	add r1, r5, #0x7c
	add r2, r5, #0x10
	bl SailPlayerWeaponFlame__Func_2162400
	mov r0, r4
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0216215C: .word 0x00001010
_02162160: .word SailPlayerWeaponBullet__State_21636B0
	arm_func_end SailPlayerWeaponBullet__Create

	arm_func_start EffectSailShell__Create
EffectSailShell__Create: // 0x02162164
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r9, r0
	mov r8, r1
	ldr r0, _021623F0 // =0x00001010
	mov r1, #1
	mov r7, r2
	ldr r6, [r9, #0x124]
	bl CreateStageTaskEx_
	mov r5, r0
	mov r1, #2
	bl StageTask__SetType
	mov r0, r5
	bl StageTask__InitSeqPlayer
	ldr r0, [r5, #0x138]
	mov r1, #0x1b
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	mov r0, #0x32
	bl GetObjectFileWork
	mov r4, r0
	bl SailManager__GetArchive
	mov r1, #0
	stmia sp, {r1, r4}
	str r0, [sp, #8]
	ldr r2, _021623F4 // =aSbShellBac_0
	mov r0, r5
	mov r3, r1
	bl ObjObjectAction3dBACLoad
	mov r0, #0x3e
	bl GetObjectFileWork
	mov r1, #0
	mov r3, r0
	mov r0, r5
	mov r2, r1
	bl ObjObjectActionAllocTexture
	ldr r1, [r5, #0x134]
	mov r3, #0x1c
	ldr r0, [r1, #0xcc]
	mov r2, #7
	orr r0, r0, #0x18
	str r0, [r1, #0xcc]
	ldr r1, [r5, #0x134]
	mov r0, r5
	strb r3, [r1, #0xa]
	ldr r1, [r5, #0x134]
	strb r2, [r1, #0xb]
	bl SailObject_InitCommon
	ldr r1, _021623F8 // =EffectSailShell__State_2163870
	mov r0, r5
	str r1, [r5, #0xf4]
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	add r3, r5, #0x44
	ldmia r8, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r5, #0x18]
	mov r0, r5
	orr r1, r1, #0x10
	str r1, [r5, #0x18]
	add r1, r4, #0x28
	mov r2, #1
	bl SailObject_InitColliderForCommon
	mov r0, r5
	mov r1, #1
	mov r2, #0x1800
	mov r3, #0
	bl SailObject_InitColliderBox
	mov r0, #0x20000
	str r0, [r4, #0x98]
	ldrh r1, [r4, #0x9c]
	add r0, r6, #0x100
	mov r2, #0
	orr r1, r1, #0x8000
	strh r1, [r4, #0x9c]
	ldrh r0, [r0, #0xce]
	mov r1, r9
	cmp r0, #0
	ldrne r0, [r4, #0x98]
	addne r0, r0, r0, asr #1
	strne r0, [r4, #0x98]
	mov r0, r5
	bl StageTask__SetParent
	ldr r1, [r5, #0x1c]
	mov r0, #0x240
	orr r1, r1, #0x80
	str r1, [r5, #0x1c]
	str r0, [r5, #0xd8]
	mov r0, #0x3000
	str r0, [r5, #0xdc]
	ldr r1, [r8, #0]
	ldr r0, [r7, #0]
	ldr r3, [r8, #8]
	ldr r2, [r7, #8]
	sub r1, r1, r0
	sub r4, r3, r2
	smull r0, r2, r1, r1
	adds r3, r0, #0x800
	smull r1, r0, r4, r4
	adc r2, r2, #0
	adds r1, r1, #0x800
	mov r3, r3, lsr #0xc
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r3, r3, r2, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r3, r1
	bl FX_Sqrt
	mov r1, #0xf000
	bl FX_Div
	mov r4, r0
	cmp r4, #0x6000
	ldr r3, [r7, #0]
	ldr r0, [r8, #0]
	ldr r2, [r7, #8]
	ldr r1, [r8, #8]
	sub r0, r3, r0
	sub r1, r2, r1
	movgt r4, #0x6000
	bl FX_Atan2Idx
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r2, r0, lsl #1
	add r0, r2, #1
	ldr r1, _021623FC // =FX_SinCosTable_
	mov r2, r2, lsl #1
	ldrsh r2, [r1, r2]
	mov r0, r0, lsl #1
	ldrsh r1, [r1, r0]
	smull r2, r3, r4, r2
	adds r6, r2, #0x800
	smull r2, r1, r4, r1
	adc r3, r3, #0
	adds r2, r2, #0x800
	mov r4, r6, lsr #0xc
	orr r4, r4, r3, lsl #20
	mov r0, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r4, [r5, #0x98]
	str r2, [r5, #0xa0]
	sub r0, r0, #0x1400
	str r0, [r5, #0x9c]
	ldr r2, [r5, #0x38]
	mov r0, #0xa00
	umull r4, r3, r2, r0
	mov r1, #0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r4, r4, #0x800
	adc r0, r3, #0
	mov r1, r4, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r5, #0x38]
	str r1, [r5, #0x3c]
	mov r0, r5
	str r1, [r5, #0x40]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_021623F0: .word 0x00001010
_021623F4: .word aSbShellBac_0
_021623F8: .word EffectSailShell__State_2163870
_021623FC: .word FX_SinCosTable_
	arm_func_end EffectSailShell__Create

	arm_func_start SailPlayerWeaponFlame__Func_2162400
SailPlayerWeaponFlame__Func_2162400: // 0x02162400
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x30
	ldr r7, _0216249C // =_0218BC40
	add r3, sp, #0xc
	add lr, sp, #0x18
	mov ip, #0
	mov r6, r0
	mov r5, r1
	mov r4, r2
	ldmia r7, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r2, sp, #0
	mov r0, lr
	mov r1, r6
	str ip, [lr]
	str ip, [lr, #4]
	str ip, [lr, #8]
	bl VEC_Subtract
	add r0, sp, #0
	add r1, sp, #0xc
	bl VEC_DotProduct
	mov r7, r0
	mov r0, r5
	add r1, sp, #0xc
	bl VEC_DotProduct
	movs r1, r0
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, r7
	bl FX_Div
	add r3, sp, #0x24
	mov r1, r5
	mov r2, r6
	bl VEC_MultAdd
	add r0, sp, #0x24
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216249C: .word _0218BC40
	arm_func_end SailPlayerWeaponFlame__Func_2162400

	arm_func_start SailPlayerWeaponFlame__Create
SailPlayerWeaponFlame__Create: // 0x021624A0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r9, r0
	mov r8, r1
	ldr r0, _021625BC // =0x00001010
	mov r1, #1
	mov r7, r2
	ldr r6, [r9, #0x124]
	bl CreateStageTaskEx_
	mov r5, r0
	mov r1, #2
	bl StageTask__SetType
	mov r0, r5
	bl StageTask__InitSeqPlayer
	ldr r0, [r5, #0x138]
	mov r1, #0x1e
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	ldr r1, _021625C0 // =SailObject_Last_Default
	ldr r0, _021625C4 // =SailPlayerWeaponFlame__State_216356C
	str r1, [r5, #0x10c]
	str r0, [r5, #0xf4]
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, r7
	mov r1, r8
	add r2, sp, #0
	bl VEC_Subtract
	add r0, sp, #0
	mov r1, r0
	bl VEC_Normalize
	mov r0, r8
	add r1, sp, #0
	add r2, r5, #0x44
	bl SailPlayerWeaponFlame__Func_2162400
	mov r0, r5
	add r1, r4, #0x28
	mov r2, #1
	bl SailObject_InitColliderForCommon
	mov r0, r5
	mov r1, #1
	mov r2, #0x2c00
	mov r3, #0
	bl SailObject_InitColliderBox
	mov r1, #0x4800
	str r1, [r4, #0x98]
	ldrh r1, [r4, #0x9c]
	add r0, r6, #0x100
	mov r2, #0
	orr r1, r1, #4
	orr r1, r1, #0x800
	strh r1, [r4, #0x9c]
	ldrh r1, [r4, #0x9c]
	orr r1, r1, #0x400
	strh r1, [r4, #0x9c]
	ldrh r1, [r4, #0x9c]
	orr r1, r1, #0x40
	strh r1, [r4, #0x9c]
	ldrh r0, [r0, #0xce]
	mov r1, r9
	cmp r0, #0
	ldrne r0, [r4, #0x98]
	addne r0, r0, r0, asr #1
	strne r0, [r4, #0x98]
	mov r0, r5
	bl StageTask__SetParent
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_021625BC: .word 0x00001010
_021625C0: .word SailObject_Last_Default
_021625C4: .word SailPlayerWeaponFlame__State_216356C
	arm_func_end SailPlayerWeaponFlame__Create

	arm_func_start SailExplosionHazard__Create
SailExplosionHazard__Create: // 0x021625C8
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, _02162674 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	ldr r0, _02162678 // =SailObject_Last_Default
	ldr r2, _0216267C // =SailExplosionHazard__State_2163538
	str r0, [r4, #0x10c]
	mov r0, r4
	mov r1, #0x1a0
	str r2, [r4, #0xf4]
	bl StageTask__AllocateWorker
	mov r5, r0
	add r3, r4, #0x44
	ldmia r6, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r4
	add r1, r5, #0x28
	mov r2, #1
	bl SailObject_InitColliderForCommon
	mov r0, r4
	mov r1, #1
	mov r2, #0x8000
	mov r3, #0
	bl SailObject_InitColliderBox
	mov r0, #0x168000
	str r0, [r5, #0x98]
	ldrh r0, [r5, #0x9c]
	orr r0, r0, #0x400
	strh r0, [r5, #0x9c]
	ldr r0, [r4, #0x18]
	orr r0, r0, #2
	str r0, [r4, #0x18]
	bl SailManager__GetWork
	ldr r1, [r0, #0x70]
	mov r0, r4
	mov r2, #0
	bl StageTask__SetParent
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02162674: .word 0x00001010
_02162678: .word SailObject_Last_Default
_0216267C: .word SailExplosionHazard__State_2163538
	arm_func_end SailExplosionHazard__Create

	arm_func_start SailPlayerWeaponTorpedo__Create
SailPlayerWeaponTorpedo__Create: // 0x02162680
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _02162708 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	ldr r1, _0216270C // =SailPlayerWeaponTorpedo__State_2163798
	mov r0, r4
	str r1, [r4, #0xf4]
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r2, r0
	ldr r1, [r4, #0x18]
	mov r0, r4
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	add r1, r2, #0x28
	mov r2, #1
	bl SailObject_InitColliderForCommon
	mov r0, r4
	mov r1, #1
	bl StageTask__GetCollider
	mov r1, r5
	mov r2, #0
	strh r2, [r0, #0x30]
	strh r2, [r0, #0x2c]
	mov r3, #0xa
	strh r3, [r0, #0x2e]
	mov r0, r4
	bl StageTask__SetParent
	mov r0, r4
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02162708: .word 0x00001010
_0216270C: .word SailPlayerWeaponTorpedo__State_2163798
	arm_func_end SailPlayerWeaponTorpedo__Create

	arm_func_start EffectSailWater08__Create
EffectSailWater08__Create: // 0x02162710
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, _021627A0 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0xd
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, _021627A4 // =0x0000FFFF
	ldr r2, _021627A8 // =aSbWater08Bac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x134]
	mov r1, #0x1c
	strb r1, [r0, #0xa]
	ldr r1, [r4, #0x134]
	mov r2, #7
	mov r0, r4
	strb r2, [r1, #0xb]
	bl SailObject_InitCommon
	add ip, r4, #0x44
	ldmia r5, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r3, _021627AC // =EffectSailWater08__State_21644FC
	mov r0, r4
	str r3, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_021627A0: .word 0x00001010
_021627A4: .word 0x0000FFFF
_021627A8: .word aSbWater08Bac
_021627AC: .word EffectSailWater08__State_21644FC
	arm_func_end EffectSailWater08__Create

	arm_func_start EffectSailWater05__Create
EffectSailWater05__Create: // 0x021627B0
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, _02162840 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0xe
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, _02162844 // =0x0000FFFF
	ldr r2, _02162848 // =aSbWater05Bac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x134]
	mov r1, #0x1c
	strb r1, [r0, #0xa]
	ldr r1, [r4, #0x134]
	mov r2, #7
	mov r0, r4
	strb r2, [r1, #0xb]
	bl SailObject_InitCommon
	add ip, r4, #0x44
	ldmia r5, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r3, _0216284C // =EffectSailWater08__State_21644FC
	mov r0, r4
	str r3, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02162840: .word 0x00001010
_02162844: .word 0x0000FFFF
_02162848: .word aSbWater05Bac
_0216284C: .word EffectSailWater08__State_21644FC
	arm_func_end EffectSailWater05__Create

	arm_func_start EffectSailWater06__Create
EffectSailWater06__Create: // 0x02162850
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, _02162910 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0xf
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, _02162914 // =0x0000FFFF
	ldr r2, _02162918 // =aSbWater06Bac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x134]
	mov r1, #0x1d
	strb r1, [r0, #0xa]
	ldr r1, [r4, #0x134]
	mov r2, #7
	mov r0, r4
	strb r2, [r1, #0xb]
	bl SailObject_InitCommon
	add lr, r4, #0x44
	ldmia r5, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	ldr ip, _0216291C // =EffectSailWater08__State_21644FC
	mov r3, #0x800
	str ip, [r4, #0xf4]
	ldr r2, [r4, #0x38]
	mov r0, r4
	adds r1, r3, r2, lsl #11
	mov r3, r1, lsr #0xc
	mov r1, r2, asr #0x1f
	mov r1, r1, lsl #0xb
	orr r1, r1, r2, lsr #21
	adc r1, r1, #0
	orr r3, r3, r1, lsl #20
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	str r3, [r4, #0x40]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02162910: .word 0x00001010
_02162914: .word 0x0000FFFF
_02162918: .word aSbWater06Bac
_0216291C: .word EffectSailWater08__State_21644FC
	arm_func_end EffectSailWater06__Create

	arm_func_start EffectSailWater07__Create
EffectSailWater07__Create: // 0x02162920
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, _021629B0 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x10
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, _021629B4 // =0x0000FFFF
	ldr r2, _021629B8 // =aSbWater07Bac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x134]
	mov r1, #0x1c
	strb r1, [r0, #0xa]
	ldr r1, [r4, #0x134]
	mov r2, #7
	mov r0, r4
	strb r2, [r1, #0xb]
	bl SailObject_InitCommon
	add ip, r4, #0x44
	ldmia r5, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r3, _021629BC // =EffectSailWater08__State_21644FC
	mov r0, r4
	str r3, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_021629B0: .word 0x00001010
_021629B4: .word 0x0000FFFF
_021629B8: .word aSbWater07Bac
_021629BC: .word EffectSailWater08__State_21644FC
	arm_func_end EffectSailWater07__Create

	arm_func_start EffectSailFlash__Create
EffectSailFlash__Create: // 0x021629C0
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, _02162A50 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x11
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	ldr r3, _02162A54 // =0x0000FFFF
	ldr r2, _02162A58 // =aSbFlashBac
	stmia sp, {r3, r6}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x134]
	mov r1, #0x1c
	strb r1, [r0, #0xa]
	ldr r1, [r4, #0x134]
	mov r2, #7
	mov r0, r4
	strb r2, [r1, #0xb]
	bl SailObject_InitCommon
	add ip, r4, #0x44
	ldmia r5, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r3, _02162A5C // =EffectSailWater08__State_21644FC
	mov r0, r4
	str r3, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02162A50: .word 0x00001010
_02162A54: .word 0x0000FFFF
_02162A58: .word aSbFlashBac
_02162A5C: .word EffectSailWater08__State_21644FC
	arm_func_end EffectSailFlash__Create

	arm_func_start EffectSailFlash2__Create
EffectSailFlash2__Create: // 0x02162A60
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r8, r0
	mov r7, r1
	mov r6, r2
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	mov r5, #0
	cmp r0, #0
	ldrne r5, [r0, #0x124]
	ldr r0, _02162CCC // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x5e
	bl GetObjectFileWork
	mov r9, r0
	bl SailManager__GetArchive
	str r9, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _02162CD0 // =aSbFlashNsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #0x5f
	bl GetObjectFileWork
	mov r9, r0
	bl SailManager__GetArchive
	str r0, [sp]
	ldr r2, _02162CD4 // =aSbFlashNsbca
	mov r3, r9
	mov r0, r4
	mov r1, #0
	bl ObjAction3dNNMotionLoad
	mov r0, #0x60
	bl GetObjectFileWork
	mov r9, r0
	bl SailManager__GetArchive
	str r0, [sp]
	ldr r2, _02162CD8 // =aSbFlashNsbva
	mov r3, r9
	mov r0, r4
	mov r1, #0
	bl ObjAction3dNNMotionLoad
	mov r0, #0x61
	bl GetObjectFileWork
	mov r9, r0
	bl SailManager__GetArchive
	str r0, [sp]
	ldr r2, _02162CDC // =aSbFlashNsbma
	mov r3, r9
	mov r0, r4
	mov r1, #0
	bl ObjAction3dNNMotionLoad
	mov r0, #0x62
	bl GetObjectFileWork
	mov r9, r0
	bl SailManager__GetArchive
	str r0, [sp]
	ldr r2, _02162CE0 // =aSbFlashNsbtp
	mov r3, r9
	mov r0, r4
	mov r1, #0
	bl ObjAction3dNNMotionLoad
	mov r1, #0
	ldr r0, [r4, #0x12c]
	mov r3, r1
	str r1, [sp]
	ldr r2, [r0, #0x148]
	bl AnimatorMDL__SetAnimation
	ldr r0, [r4, #0x12c]
	mov r3, #0
	str r3, [sp]
	ldr r2, [r0, #0x14c]
	mov r1, #1
	bl AnimatorMDL__SetAnimation
	ldr r0, [r4, #0x12c]
	mov r3, #0
	str r3, [sp]
	ldr r2, [r0, #0x158]
	mov r1, #4
	bl AnimatorMDL__SetAnimation
	ldr r9, [r4, #0x12c]
	ldr r0, [r9, #0x144]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r2, [r9, #0x150]
	mov r0, r9
	mov r1, #2
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #0x20000000
	str r1, [r4, #0x24]
	bl SailObject_InitCommon
	mov r0, #0x4000
	cmp r7, #0
	str r0, [r4, #0x2c]
	ldrne r0, [r4, #0x2c]
	add r3, r4, #0x44
	addne r0, r0, #0x8000
	strne r0, [r4, #0x2c]
	ldr r0, [r4, #0x2c]
	cmp r5, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [r4, #0x2c]
	ldmia r8, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	beq _02162CB8
	add r0, r5, #0x100
	cmp r6, #0
	ldrsh r0, [r0, #0xca]
	mov r1, #0
	bne _02162C7C
	cmp r0, #0
	rsblt r0, r0, #0
	rsb r0, r0, #0x4000
	mov r2, r0, asr #3
	mov r0, #0x1200
	umull r5, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r2, r5, #0x800
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	rsb r0, r1, #0xb00
	str r0, [r4, #0x40]
	b _02162CB8
_02162C7C:
	cmp r0, #0
	rsblt r0, r0, #0
	rsb r0, r0, #0x4000
	mov r2, r0, asr #3
	mov r0, #0x1400
	umull r5, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r2, r5, #0x800
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	rsb r0, r1, #0x1000
	str r0, [r4, #0x40]
_02162CB8:
	ldr r1, _02162CE4 // =EffectSailFlash2__State_2164534
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02162CCC: .word 0x00001010
_02162CD0: .word aSbFlashNsbmd_0
_02162CD4: .word aSbFlashNsbca
_02162CD8: .word aSbFlashNsbva
_02162CDC: .word aSbFlashNsbma
_02162CE0: .word aSbFlashNsbtp
_02162CE4: .word EffectSailFlash2__State_2164534
	arm_func_end EffectSailFlash2__Create

	arm_func_start EffectSailBazooka__Create
EffectSailBazooka__Create: // 0x02162CE8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r6, r0
	mov r5, r1
	bl SailManager__GetWork
	ldr r0, _02162E74 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x63
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	str r0, [sp, #4]
	mov r0, r4
	mov r1, #0
	ldr r2, _02162E78 // =aSbBazookaNsbmd_0
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #0x64
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	mov r3, r7
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02162E7C // =aSbBazookaNsbca
	bl ObjAction3dNNMotionLoad
	mov r0, #0x65
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	mov r3, r7
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02162E80 // =aSbBazookaNsbva
	bl ObjAction3dNNMotionLoad
	mov r0, #0x66
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	mov r3, r7
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02162E84 // =aSbBazookaNsbtp
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	ldr r0, [r4, #0x12c]
	mov r3, #0
	str r3, [sp]
	mov r1, #4
	ldr r2, [r0, #0x158]
	bl AnimatorMDL__SetAnimation
	ldr r7, [r4, #0x12c]
	ldr r0, [r7, #0x144]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r2, [r7, #0x150]
	mov r0, r7
	mov r1, #2
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	mov r0, r4
	bl SailObject_InitCommon
	mov r0, #0x4000
	str r0, [r4, #0x2c]
	cmp r5, #0
	ldrne r0, [r4, #0x2c]
	mov r1, #0x4000
	addne r0, r0, #0x8000
	strne r0, [r4, #0x2c]
	ldr r0, [r4, #0x2c]
	add r3, r4, #0x44
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [r4, #0x2c]
	strh r1, [r4, #0x30]
	ldmia r6, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #0x800
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	ldr r1, _02162E88 // =EffectSailBazooka__State_2164574
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02162E74: .word 0x00001010
_02162E78: .word aSbBazookaNsbmd_0
_02162E7C: .word aSbBazookaNsbca
_02162E80: .word aSbBazookaNsbva
_02162E84: .word aSbBazookaNsbtp
_02162E88: .word EffectSailBazooka__State_2164574
	arm_func_end EffectSailBazooka__Create

	arm_func_start EffectEffectSailBullet2__Create
EffectEffectSailBullet2__Create: // 0x02162E8C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	mov r8, #0xc00
	mov r10, r0
	mov r9, r1
	add r0, r8, #0x410
	mov r1, #1
	ldr r11, [r10, #0x124]
	mov r6, #0x1000
	mov r7, #0x4000
	bl CreateStageTaskEx_
	mov r4, r0
	mov r1, #2
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, r4
	bl StageTask__InitSeqPlayer
	cmp r9, #0x60000
	movlt r0, #0
	blt _02162EF4
	cmp r9, #0x120000
	movlt r0, #1
	movge r0, #2
_02162EF4:
	cmp r0, #1
	beq _02162F98
	cmp r0, #2
	beq _02163038
	mov r0, #0x73
	bl GetObjectFileWork
	mov r9, r0
	bl SailManager__GetArchive
	str r9, [sp]
	str r0, [sp, #4]
	mov r0, r4
	mov r1, #0
	ldr r2, _021633E0 // =aSbBullet1Nsbmd_0
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #0x74
	bl GetObjectFileWork
	mov r9, r0
	bl SailManager__GetArchive
	mov r3, r9
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _021633E4 // =aSbBullet1Nsbca
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, #1
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x138]
	mov r1, #0x71
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	b _021630D4
_02162F98:
	mov r0, #0x75
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	str r6, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _021633E8 // =aSbBullet2Nsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #0x76
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _021633EC // =aSbBullet2Nsbca
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	ldr r0, [r4, #0x20]
	mov r6, #0x4000
	orr r0, r0, #4
	str r0, [r4, #0x20]
	mov r7, #0x5000
	mov r8, #0x9000
	mov r0, #4
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x138]
	mov r1, #0x72
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
	b _021630D4
_02163038:
	mov r0, #0x77
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	str r6, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _021633F0 // =aSbBullet3Nsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #0x78
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	mov r3, r6
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _021633F4 // =aSbBullet3Nsbca
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _021633F8 // =0x0000FFFF
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0x28]
	mov r6, #0x8000
	mov r7, #0x6000
	mov r8, #0x10000
	ldr r0, [r4, #0x138]
	mov r1, #0x73
	mov r2, #0
	bl SailAudio__PlaySpatialSequence
_021630D4:
	add r0, r11, #0x100
	ldrh r0, [r0, #0xce]
	cmp r0, #2
	mov r0, r4
	addhs r8, r8, r8, asr #1
	bl SailObject_InitCommon
	add r0, r10, #0x44
	add r3, r4, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x48]
	mov r0, r4
	sub r1, r1, #0x800
	str r1, [r4, #0x48]
	ldr r2, [r4, #0x24]
	add r1, r5, #0x28
	orr r2, r2, #1
	str r2, [r4, #0x24]
	str r6, [r4, #0x38]
	str r6, [r4, #0x3c]
	mov r2, #1
	str r6, [r4, #0x40]
	bl SailObject_InitColliderForCommon
	mov r2, r7
	mov r0, r4
	mov r1, #1
	mov r3, #0
	bl SailObject_InitColliderBox
	mov r0, #0xc00
	str r0, [r5, #0x58]
	ldrh r2, [r5, #0x9c]
	mov r0, r4
	mov r1, r10
	orr r2, r2, #0x400
	strh r2, [r5, #0x9c]
	ldrh r3, [r5, #0x9c]
	mov r2, #0
	orr r3, r3, #0x800
	strh r3, [r5, #0x9c]
	ldrh r3, [r5, #0x9c]
	orr r3, r3, #0x10
	strh r3, [r5, #0x9c]
	str r8, [r5, #0x98]
	bl StageTask__SetParent
	bl SailManager__GetWork
	ldr r3, [r0, #0x98]
	mov r1, #0xa00
	ldrh r6, [r3, #0x34]
	ldr r0, _021633FC // =FX_SinCosTable_
	mvn r2, #0
	mov r6, r6, asr #4
	mov r6, r6, lsl #2
	ldrsh r8, [r0, r6]
	rsb r1, r1, #0
	mov r6, #0x4c00
	umull r11, r9, r8, r1
	mla r9, r8, r2, r9
	mov r7, r8, asr #0x1f
	adds r8, r11, #0x800
	mla r9, r7, r1, r9
	adc r7, r9, #0
	mov r8, r8, lsr #0xc
	orr r8, r8, r7, lsl #20
	str r8, [sp, #0x14]
	ldrh r7, [r3, #0x34]
	ldr ip, _02163400 // =0x00000F5E
	mov r7, r7, asr #4
	mov r7, r7, lsl #1
	add r7, r7, #1
	mov r7, r7, lsl #1
	ldrsh r7, [r0, r7]
	umull r9, r8, r7, r1
	mla r8, r7, r2, r8
	mov r0, r7, asr #0x1f
	mla r8, r0, r1, r8
	adds r1, r9, #0x800
	adc r0, r8, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0x1c]
	str r6, [r5, #0x184]
	ldr r2, [r10, #0x4c]
	ldr r0, [sp, #0x1c]
	ldr r1, [r10, #0x44]
	sub r2, r2, r0
	ldr r0, [sp, #0x14]
	ldr r6, _02163404 // =0x0000065D
	subs r1, r1, r0
	rsbmi r1, r1, #0
	cmp r2, #0
	rsblt r2, r2, #0
	cmp r1, r2
	mov r7, #0
	ble _02163294
	umull r0, r11, r1, ip
	mla r11, r1, r7, r11
	umull r9, r8, r2, r6
	mla r8, r2, r7, r8
	mov r1, r1, asr #0x1f
	mov r2, r2, asr #0x1f
	adds r0, r0, #0x800
	mla r11, r1, ip, r11
	adc r11, r11, #0
	adds r1, r9, #0x800
	mla r8, r2, r6, r8
	mov r0, r0, lsr #0xc
	adc r2, r8, #0
	mov r1, r1, lsr #0xc
	orr r0, r0, r11, lsl #20
	orr r1, r1, r2, lsl #20
	add r1, r0, r1
	b _021632D8
_02163294:
	umull r0, r11, r2, ip
	mla r11, r2, r7, r11
	umull r9, r8, r1, r6
	mla r8, r1, r7, r8
	mov r2, r2, asr #0x1f
	mov r1, r1, asr #0x1f
	adds r0, r0, #0x800
	mla r11, r2, ip, r11
	adc r11, r11, #0
	adds r2, r9, #0x800
	mla r8, r1, r6, r8
	mov r0, r0, lsr #0xc
	adc r1, r8, #0
	mov r2, r2, lsr #0xc
	orr r0, r0, r11, lsl #20
	orr r2, r2, r1, lsl #20
	add r1, r0, r2
_021632D8:
	mov r0, #0x800
	str r1, [r5, #0x170]
	rsb r0, r0, #0
	str r0, [r5, #0x174]
	ldr r0, [r3, #0x44]
	mov r7, #0
	sub r0, r0, #0x1000
	str r0, [r5, #0x178]
	add r6, sp, #0x14
	str r7, [sp, #8]
	str r7, [sp, #0xc]
	str r7, [sp, #0x10]
	add r0, r10, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	str r7, [sp, #0x18]
	ldrh r0, [r3, #0x34]
	ldr r2, _021633FC // =FX_SinCosTable_
	mov r7, #0x800
	rsb r0, r0, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrsh r8, [r2, r0]
	mov r0, r6
	add r1, sp, #8
	mov r6, r8, asr #0x1f
	mov r6, r6, lsl #0xc
	adds r9, r7, r8, lsl #12
	orr r6, r6, r8, lsr #20
	adc r6, r6, #0
	mov r8, r9, lsr #0xc
	orr r8, r8, r6, lsl #20
	str r8, [sp, #8]
	ldrh r3, [r3, #0x34]
	rsb r3, r3, #0
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, asr #4
	mov r3, r3, lsl #2
	ldrsh r3, [r2, r3]
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #0xc
	adds r6, r7, r3, lsl #12
	orr r2, r2, r3, lsr #20
	adc r2, r2, #0
	mov r3, r6, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [sp, #0x10]
	bl VEC_DotProduct
	cmp r0, #0
	ldrlt r0, [r5, #0x170]
	ldr r1, _02163408 // =EffectEffectSailBullet2__State_21645E0
	rsblt r0, r0, #0
	strlt r0, [r5, #0x170]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021633E0: .word aSbBullet1Nsbmd_0
_021633E4: .word aSbBullet1Nsbca
_021633E8: .word aSbBullet2Nsbmd_0
_021633EC: .word aSbBullet2Nsbca
_021633F0: .word aSbBullet3Nsbmd_0
_021633F4: .word aSbBullet3Nsbca
_021633F8: .word 0x0000FFFF
_021633FC: .word FX_SinCosTable_
_02163400: .word 0x00000F5E
_02163404: .word 0x0000065D
_02163408: .word EffectEffectSailBullet2__State_21645E0
	arm_func_end EffectEffectSailBullet2__Create

	arm_func_start EffectSailWater09__Create
EffectSailWater09__Create: // 0x0216340C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r0, _02163524 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r1, #2
	mov r4, r0
	bl StageTask__SetType
	mov r0, #0x6d
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	str r5, [sp]
	str r0, [sp, #4]
	mov r0, r4
	mov r1, #0
	ldr r2, _02163528 // =aSbWater09Nsbmd_0
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, #0x6e
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	mov r3, r5
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _0216352C // =aSbWater09Nsbca
	bl ObjAction3dNNMotionLoad
	mov r0, #0x6f
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	mov r3, r5
	str r0, [sp]
	mov r0, r4
	mov r1, #0
	ldr r2, _02163530 // =aSbWater09Nsbta
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	ldr r0, [r4, #0x12c]
	mov r3, #0
	str r3, [sp]
	mov r1, #3
	ldr r2, [r0, #0x154]
	bl AnimatorMDL__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	bl SailObject_InitCommon
	mov r1, r6
	mov r0, r4
	mov r2, #0
	bl StageTask__SetParent
	mov r0, #0x300
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	ldr r1, _02163534 // =EffectSailWater09__State_2164690
	str r0, [r4, #0x40]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02163524: .word 0x00001010
_02163528: .word aSbWater09Nsbmd_0
_0216352C: .word aSbWater09Nsbca
_02163530: .word aSbWater09Nsbta
_02163534: .word EffectSailWater09__State_2164690
	arm_func_end EffectSailWater09__Create

	arm_func_start SailExplosionHazard__State_2163538
SailExplosionHazard__State_2163538: // 0x02163538
	ldr r1, [r0, #0x2c]
	cmp r1, #2
	ldreq r1, [r0, #0x18]
	biceq r1, r1, #2
	streq r1, [r0, #0x18]
	ldr r1, [r0, #0x2c]
	add r1, r1, #1
	str r1, [r0, #0x2c]
	cmp r1, #4
	ldrgt r1, [r0, #0x18]
	orrgt r1, r1, #4
	strgt r1, [r0, #0x18]
	bx lr
	arm_func_end SailExplosionHazard__State_2163538

	arm_func_start SailPlayerWeaponFlame__State_216356C
SailPlayerWeaponFlame__State_216356C: // 0x0216356C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x24
	mov r4, r0
	bl SailManager__GetWork
	ldr r1, [r4, #0x11c]
	ldr r0, [r0, #0x98]
	cmp r1, #0
	bne _021635A0
	ldr r0, [r4, #0x18]
	add sp, sp, #0x24
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, pc}
_021635A0:
	ldrsh r0, [r0, #0x38]
	cmp r0, #0
	beq _021635F4
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _021636AC // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0
	bl MTX_RotY33_
	add r0, r4, #0x44
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
_021635F4:
	ldr r0, [r4, #0x2c]
	cmp r0, #0x45
	bge _02163648
	tst r0, #0xf
	bne _02163648
	add r0, r4, #0x44
	bl EffectSailFire__Create
	ldr r3, [r0, #0x38]
	mov r1, #0xc00
	umull lr, ip, r3, r1
	mov r2, #0
	adds lr, lr, #0x800
	mla ip, r3, r2, ip
	mov r2, r3, asr #0x1f
	mla ip, r2, r1, ip
	adc r1, ip, #0
	mov r2, lr, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x38]
	str r2, [r0, #0x3c]
	str r2, [r0, #0x40]
_02163648:
	ldr r0, [r4, #0x2c]
	tst r0, #7
	bne _02163674
	mov r0, r4
	mov r1, #1
	bl StageTask__GetCollider
	ldr r1, [r0, #0x18]
	bic r1, r1, #0x200
	str r1, [r0, #0x18]
	mov r0, r4
	bl SailManager__AddPlayerWeaponTask
_02163674:
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	bne _02163688
	mov r0, r4
	bl SailManager__AddPlayerWeaponTask
_02163688:
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0x4f
	ldrgt r0, [r4, #0x18]
	orrgt r0, r0, #4
	strgt r0, [r4, #0x18]
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021636AC: .word FX_SinCosTable_
	arm_func_end SailPlayerWeaponFlame__State_216356C

	arm_func_start SailPlayerWeaponBullet__State_21636B0
SailPlayerWeaponBullet__State_21636B0: // 0x021636B0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r2, [r6, #0x11c]
	ldr r4, [r6, #0x124]
	cmp r2, #0
	beq _021636D4
	ldr r1, [r6, #0x18]
	tst r1, #2
	beq _021636E4
_021636D4:
	ldr r0, [r6, #0x18]
	orr r0, r0, #4
	str r0, [r6, #0x18]
	ldmia sp!, {r4, r5, r6, pc}
_021636E4:
	ldr r1, [r6, #0x2c]
	ldr r5, [r2, #0x124]
	cmp r1, #0
	bne _021636F8
	bl SailManager__AddPlayerWeaponTask
_021636F8:
	ldr r0, [r6, #0x2c]
	add r0, r0, #1
	str r0, [r6, #0x2c]
	cmp r0, #1
	ldmleia sp!, {r4, r5, r6, pc}
	mov r0, r6
	mov r1, #1
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	bne _02163788
	ldr r0, [r6, #0x138]
	add r2, r4, #0x10
	mov r1, #0x18
	bl SailAudio__PlaySpatialSequence
	ldr r0, [r6, #0x24]
	tst r0, #0x10
	addeq r0, r5, #0x100
	moveq r1, #0
	streqh r1, [r0, #0xc4]
	add r0, r4, #0x10
	bl EffectSailWater07__Create
	ldr r3, [r0, #0x38]
	mov r1, #0xc00
	umull r5, r4, r3, r1
	mov r2, #0
	mla r4, r3, r2, r4
	mov r2, r3, asr #0x1f
	mla r4, r2, r1, r4
	adds r5, r5, #0x800
	adc r1, r4, #0
	mov r2, r5, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x38]
	str r2, [r0, #0x3c]
	str r2, [r0, #0x40]
_02163788:
	ldr r0, [r6, #0x18]
	orr r0, r0, #4
	str r0, [r6, #0x18]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SailPlayerWeaponBullet__State_21636B0

	arm_func_start SailPlayerWeaponTorpedo__State_2163798
SailPlayerWeaponTorpedo__State_2163798: // 0x02163798
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x38
	mov r4, r0
	ldr r0, [r4, #0x11c]
	cmp r0, #0
	bne _021637C4
	ldr r0, [r4, #0x18]
	add sp, sp, #0x38
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
_021637C4:
	ldr r0, [r0, #0x124]
	add r1, r0, #0x200
	ldrh r0, [r1, #0x3c]
	tst r0, #1
	bne _021637EC
	ldr r0, [r4, #0x18]
	add sp, sp, #0x38
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
_021637EC:
	ldrh r0, [r1, #0x30]
	ldrh r1, [r1, #0x32]
	add r2, sp, #0x2c
	add r3, sp, #0x20
	bl NNS_G3dScrPosToWorldLine
	add ip, sp, #0x2c
	add r3, r4, #0x44
	ldmia ip, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x48]
	add r0, sp, #0x20
	rsb r3, r1, #0
	str r3, [r4, #0x48]
	mov r3, #0
	add r2, sp, #8
	mov r1, ip
	str r3, [sp, #0x14]
	str r3, [sp, #0x18]
	str r3, [sp, #0x1c]
	bl VEC_Subtract
	add r0, sp, #8
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	add r3, sp, #0x14
	mov r0, r4
	mov r1, #1
	mov r2, #0x1000
	bl SailObject_InitColliderLine
	mov r0, r4
	bl SailManager__AddPlayerWeaponTask
	add sp, sp, #0x38
	ldmia sp!, {r4, pc}
	arm_func_end SailPlayerWeaponTorpedo__State_2163798

	arm_func_start EffectSailShell__State_2163870
EffectSailShell__State_2163870: // 0x02163870
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r2, [r4, #0x11c]
	cmp r2, #0
	beq _02163890
	ldr r1, [r4, #0x18]
	tst r1, #2
	beq _021638A0
_02163890:
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_021638A0:
	ldr r5, [r2, #0x124]
	bl SailManager__AddPlayerWeaponTask
	mov r0, r4
	mov r1, #1
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	bne _02163910
	ldr r0, [r4, #0x48]
	cmp r0, #0
	ldmleia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x138]
	add r2, r4, #0x44
	mov r1, #0x1c
	bl SailAudio__PlaySpatialSequence
	ldr r0, [r4, #0x24]
	tst r0, #0x10
	addeq r0, r5, #0x100
	moveq r1, #0
	streqh r1, [r0, #0xc4]
	mov r0, #0
	str r0, [r4, #0x48]
	add r0, r4, #0x44
	bl EffectSailWater08__Create
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_02163910:
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end EffectSailShell__State_2163870

	arm_func_start EffectSailTrick2__State_2163920
EffectSailTrick2__State_2163920: // 0x02163920
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r5, [r4, #0x11c]
	cmp r5, #0
	bne _02163944
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_02163944:
	bl SailObject_HandleParentFollow
	mov r0, r4
	bl SailObject_ApplyRotation
	ldr r1, [r4, #0x28]
	ldr r0, [r5, #0x28]
	cmp r1, r0
	bne _0216396C
	ldr r0, [r5, #0x1c]
	tst r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
_0216396C:
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end EffectSailTrick2__State_2163920

	arm_func_start EffectSailTrick4__State_216397C
EffectSailTrick4__State_216397C: // 0x0216397C
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r1, [r4, #0x11c]
	cmp r1, #0
	bne _021639A0
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_021639A0:
	ldr r5, [r1, #0x124]
	bl SailObject_HandleParentFollow
	mov r0, r4
	bl SailObject_ApplyRotation
	add r0, r5, #0x100
	ldrsh r1, [r0, #0xf8]
	cmp r1, #0
	bne _021639D0
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_021639D0:
	ldrh r0, [r0, #0xc0]
	ldr r1, [r4, #0x28]
	cmp r1, r0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end EffectSailTrick4__State_216397C

	arm_func_start EffectSailWaterSplash2__State_21639F0
EffectSailWaterSplash2__State_21639F0: // 0x021639F0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x20]
	tst r0, #8
	ldrne r0, [r5, #0x18]
	orrne r0, r0, #4
	strne r0, [r5, #0x18]
	ldr r4, [r5, #0x11c]
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl SailObject_HandleParentFollow
	mov r0, r5
	bl SailObject_ApplyRotation
	ldr r0, [r4, #0x1c]
	tst r0, #1
	moveq r0, #0
	streq r0, [r5, #0x11c]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end EffectSailWaterSplash2__State_21639F0

	arm_func_start EffectSailTrick__State_2163A3C
EffectSailTrick__State_2163A3C: // 0x02163A3C
	ldr r1, [r0, #0x2c]
	add r1, r1, #1
	str r1, [r0, #0x2c]
	cmp r1, #0x18
	ldrgt r1, [r0, #0x18]
	orrgt r1, r1, #4
	strgt r1, [r0, #0x18]
	bx lr
	arm_func_end EffectSailTrick__State_2163A3C

	arm_func_start EffectSailBoost__State_2163A5C
EffectSailBoost__State_2163A5C: // 0x02163A5C
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r5, [r4, #0x11c]
	cmp r5, #0
	bne _02163A80
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_02163A80:
	bl SailObject_HandleParentFollow
	mov r0, r4
	bl SailObject_ApplyRotation
	ldr r0, [r4, #0x20]
	tst r0, #4
	beq _02163AB0
	ldr r0, [r5, #0x24]
	tst r0, #1
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #4
	streq r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_02163AB0:
	tst r0, #8
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #4
	strne r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end EffectSailBoost__State_2163A5C

	arm_func_start EffectSailCircle__State_2163AC4
EffectSailCircle__State_2163AC4: // 0x02163AC4
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4, #0x148]
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #2
	strne r0, [r4, #0x18]
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _02163B10
	ldr r0, [r4, #0x20]
	add sp, sp, #4
	tst r0, #8
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #4
	strne r0, [r4, #0x18]
	ldmia sp!, {r3, r4, pc}
_02163B10:
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	cmp r0, #0x3c
	addle sp, sp, #4
	str r0, [r4, #0x2c]
	ldmleia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x12c]
	mov r3, #0
	str r3, [sp]
	ldr r1, [r0, #0x144]
	mov r2, #1
	bl AnimatorMDL__SetResource
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, #1
	bl AnimatorMDL__SetAnimation
	mov r1, #1
	ldr r0, [r4, #0x12c]
	mov r2, #0
	str r2, [sp]
	ldr r2, [r0, #0x14c]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, #1
	bic r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0x28]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end EffectSailCircle__State_2163AC4

	arm_func_start EffectUnknown2161638__Main
EffectUnknown2161638__Main: // 0x02163B90
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x7c
	bl GetCurrentTaskWork_
	ldr r1, _02163F64 // =_0218BC4C
	mov r5, r0
	add r3, sp, #0x64
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, sp, #0x70
	mov r8, #0
	str r8, [r0]
	str r8, [r0, #4]
	str r8, [r0, #8]
	bl SailManager__GetWork
	ldr r1, [r0, #0x98]
	add r0, sp, #0x40
	ldrh r6, [r1, #0x34]
	ldrsh r1, [r1, #0x38]
	add r1, r6, r1, lsl #2
	mov r1, r1, lsl #0x10
	mov r4, r1, lsr #0x10
	bl MTX_Identity33_
	add r0, sp, #0x64
	bl NNS_G3dGlbSetBaseScale
	ldr r1, _02163F68 // =NNS_G3dGlb+0x000000BC
	add r0, sp, #0x40
	bl MI_Copy36B
	ldr r1, _02163F6C // =NNS_G3dGlb
	add r0, sp, #0x70
	ldr r2, [r1, #0xfc]
	bic r2, r2, #0xa4
	str r2, [r1, #0xfc]
	bl NNS_G3dGlbSetBaseTrans
	bl NNS_G3dGlbFlushP
	mov r0, #0x20000000
	str r0, [sp, #0xc]
	mov r0, #0x2a
	add r1, sp, #0xc
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	rsb r0, r6, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r2, r0, lsl #1
	add r0, r1, #1
	mov r3, r1, lsl #1
	mov r1, r0, lsl #1
	ldr r4, _02163F70 // =FX_SinCosTable_
	mvn r0, #0
	str r0, [sp, #8]
	mov r0, #0x800
	ldrsh r10, [r4, r3]
	ldrsh r7, [r4, r1]
	sub r0, r0, #0x1800
	mov r1, #0x96000
	str r0, [sp, #0x20]
	rsb r1, r1, #0
	ldr r0, [sp, #8]
	umull ip, r11, r10, r1
	mla r11, r10, r0, r11
	mov r9, r10, asr #0x1f
	mla r11, r9, r1, r11
	adds r9, ip, #0x800
	adc r0, r11, #0
	mov r9, r9, lsr #0xc
	orr r9, r9, r0, lsl #20
	str r9, [sp, #0x1c]
	ldr r0, [sp, #8]
	umull r10, r9, r7, r1
	mla r9, r7, r0, r9
	mov r3, r7, asr #0x1f
	mla r9, r3, r1, r9
	adds r1, r10, #0x800
	add lr, r2, #1
	adc r0, r9, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	mov r0, lr, lsl #1
	str r0, [sp]
	mov r0, r2, lsl #1
	mov r6, r8
	str r1, [sp, #0x24]
	str r0, [sp, #4]
_02163CF8:
	add r7, r5, r6
	ldrb r0, [r7, #0x20]
	cmp r0, #0
	bne _02163DD0
	ldr r0, [r5, #4]
	cmp r0, #0
	beq _02163EEC
	ldrsh r0, [r5, #0]
	mov r0, r0, asr #1
	cmp r0, r6, asr #2
	bne _02163EEC
	ldr r0, _02163F74 // =_obj_disp_rand
	ldr r2, _02163F78 // =0x00196225
	ldr r3, [r0, #0]
	ldr r1, _02163F7C // =0x3C6EF35F
	add r0, r5, r6, lsl #1
	mla r2, r3, r2, r1
	ldr r1, _02163F74 // =_obj_disp_rand
	str r2, [r1]
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	ldrsh r3, [r4, r1]
	add r2, r4, r2, lsl #1
	mov r1, r3, asr #0x1f
	mov r9, r1, lsl #0xd
_02163D7C:
	mov r1, #0x800
	orr r9, r9, r3, lsr #19
	adds r3, r1, r3, lsl #13
	adc r1, r9, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r1, lsl #20
	strh r3, [r0, #0x60]
	ldrsh r2, [r2, #2]
	mov r1, r2, asr #0x1f
	mov r3, r1, lsl #0xd
	mov r1, #0x800
	orr r3, r3, r2, lsr #19
	adds r2, r1, r2, lsl #13
	adc r1, r3, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, r2, #0x2800
	strh r1, [r0, #0xe0]
	mov r0, #0x70
	strb r0, [r7, #0x20]
	b _02163EEC
_02163DD0:
	add r1, r5, r6, lsl #1
	ldrsh r0, [r1, #0x60]
	ldrsh r3, [r1, #0xe0]
	ldr r1, [sp]
	ldrsh r2, [r4, r1]
	ldr r1, [sp, #4]
	str r3, [sp, #0x14]
	ldrsh r1, [r4, r1]
	smull r8, r3, r0, r2
	smull r2, r1, r0, r1
	mov r0, #0x800
	adds r8, r8, r0
	mov r0, #0
	adc r0, r3, r0
	mov r3, r8, lsr #0xc
	orr r3, r3, r0, lsl #20
	mov r0, #0x800
	adds r2, r2, r0
	mov r0, #0
	adc r0, r1, r0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0x18]
	str r3, [sp, #0x10]
	add r0, sp, #0x10
	add r1, sp, #0x1c
	add r2, sp, #0x34
	bl VEC_Subtract
	ldrb r2, [r7, #0x20]
	add r0, sp, #0x28
	add r1, sp, #0x10
	add r2, r2, #3
	strb r2, [r7, #0x20]
	ldr r3, [sp, #0x34]
	and r2, r2, #0xff
	ldr r10, [sp, #0x1c]
	add r2, r2, #6
	mov r11, r3, asr #7
	mla r2, r11, r2, r10
	str r2, [sp, #0x10]
	ldrb r3, [r7, #0x20]
	ldr r2, [sp, #0x38]
	ldr r8, [sp, #0x20]
	mov r9, r2, asr #7
	add r3, r3, #6
	mla r3, r9, r3, r8
	str r3, [sp, #0x14]
	ldrb r3, [r7, #0x20]
	ldr r2, [sp, #0x3c]
	ldr ip, [sp, #0x24]
	mov lr, r2, asr #7
	add r3, r3, #6
	mla r3, lr, r3, ip
	str r3, [sp, #0x18]
	ldrb r3, [r7, #0x20]
	ldr r2, [sp, #8]
	mla r3, r11, r3, r10
	str r3, [sp, #0x28]
	ldrb r3, [r7, #0x20]
	add r2, r2, #0x8000
	mla r3, r9, r3, r8
	str r3, [sp, #0x2c]
	ldrb r3, [r7, #0x20]
	mla r3, lr, r3, ip
	str r3, [sp, #0x30]
	bl Unknown2066510__Func_2066C24
	ldrb r0, [r7, #0x20]
	mov r8, #1
	cmp r0, #0x90
	movhs r0, #0
	strhsb r0, [r7, #0x20]
_02163EEC:
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0x40
	blo _02163CF8
	ldrsh r0, [r5, #0]
	add r0, r0, #1
	strh r0, [r5]
	ldrsh r0, [r5, #0]
	cmp r0, #0x10
	movge r0, #0
	strgeh r0, [r5]
	ldr r0, [r5, #4]
	cmp r0, #0
	beq _02163F4C
	ldr r0, [r0, #0x24]
	tst r0, #1
	addne sp, sp, #0x7c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	tst r0, #0x80
	moveq r0, #0
	add sp, sp, #0x7c
	streq r0, [r5, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02163F4C:
	cmp r8, #0
	addne sp, sp, #0x7c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl DestroyCurrentTask
	add sp, sp, #0x7c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02163F64: .word _0218BC4C
_02163F68: .word NNS_G3dGlb+0x000000BC
_02163F6C: .word NNS_G3dGlb
_02163F70: .word FX_SinCosTable_
_02163F74: .word _obj_disp_rand
_02163F78: .word 0x00196225
_02163F7C: .word 0x3C6EF35F
	arm_func_end EffectUnknown2161638__Main

	arm_func_start EffectUnknown21615C8__Main
EffectUnknown21615C8__Main: // 0x02163F80
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0]
	sub r1, r1, #1
	str r1, [r0]
	cmp r1, #0
	ldmgtia sp!, {r3, pc}
	bl EndSysPause
	bl DestroyCurrentTask
	ldmia sp!, {r3, pc}
	arm_func_end EffectUnknown21615C8__Main

	arm_func_start EffectUnknown21614E4__Main
EffectUnknown21614E4__Main: // 0x02163FA8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0]
	ldrh r5, [r4, #4]
	add r0, r0, #0x44
	bl EffectSailSmoke__Create
	mov r2, r5, lsl #0xd
	mov r1, #0
	cmp r2, #0x10000
	addge r1, r1, #0x1000
	movge r1, r1, lsl #0x10
	movge r1, r1, lsr #0x10
	add r1, r1, r2
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r6, r1, lsl #1
	mov ip, #0x260
	ldr r3, _02164134 // =FX_SinCosTable_
	mov r1, r6, lsl #1
	ldrsh r2, [r3, r1]
	rsb ip, ip, #0
	add r1, r6, #1
	umull r7, r5, r2, ip
	mvn lr, #0
	mov r1, r1, lsl #1
	ldrsh r6, [r3, r1]
	adds r7, r7, #0x800
	mla r5, r2, lr, r5
	mov r1, r2, asr #0x1f
	mla r5, r1, ip, r5
	umull r2, r1, r6, ip
	adc r5, r5, #0
	mov r7, r7, lsr #0xc
	orr r7, r7, r5, lsl #20
	mla r1, r6, lr, r1
	str r7, [r0, #0x9c]
	ldr r5, [r4, #0]
	mov lr, r6, asr #0x1f
	ldrh r5, [r5, #0x32]
	adds r2, r2, #0x800
	mla r1, lr, ip, r1
	mov r5, r5, asr #4
	mov r5, r5, lsl #1
	add r5, r5, #1
	mov r5, r5, lsl #1
	ldrsh ip, [r3, r5]
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	smull r5, r1, r2, ip
	adds r5, r5, #0x800
	adc r1, r1, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r1, lsl #20
	str r5, [r0, #0x98]
	ldr ip, [r4]
	ldr r1, _02164138 // =0x00005294
	ldrh ip, [ip, #0x32]
	mov ip, ip, asr #4
	mov ip, ip, lsl #2
	ldrsh r3, [r3, ip]
	smull ip, r3, r2, r3
	adds ip, ip, #0x800
	adc r2, r3, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [r0, #0xa0]
	ldr r2, [r0, #0x98]
	rsb r2, r2, #0
	mov r2, r2, asr #5
	str r2, [r0, #0xa4]
	ldr r2, [r0, #0x9c]
	rsb r2, r2, #0
	mov r2, r2, asr #5
	str r2, [r0, #0xa8]
	ldr r2, [r0, #0xa0]
	rsb r2, r2, #0
	mov r2, r2, asr #5
	str r2, [r0, #0xac]
	ldr r2, [r0, #0x24]
	orr r2, r2, #1
	str r2, [r0, #0x24]
	bl SailObject_SetSpriteColor
	ldrh r0, [r4, #4]
	add r0, r0, #1
	strh r0, [r4, #4]
	ldrh r0, [r4, #4]
	cmp r0, #0x10
	bhs _0216412C
	ldr r0, [r4, #0]
	ldr r0, [r0, #0x18]
	tst r0, #4
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
_0216412C:
	bl DestroyCurrentTask
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02164134: .word FX_SinCosTable_
_02164138: .word 0x00005294
	arm_func_end EffectUnknown21614E4__Main

	arm_func_start EffectUnknown2161544__Main
EffectUnknown2161544__Main: // 0x0216413C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SailManager__GetWork
	ldrh r1, [r4, #0x10]
	mov r5, r0
	add r0, r1, #1
	strh r0, [r4, #0x10]
	ldrh r0, [r4, #0x10]
	cmp r0, #0x40
	bhi _0216417C
	ldr r0, [r4, #0]
	ldr r1, [r0, #0x18]
	tst r1, #4
	beq _02164188
_0216417C:
	bl DestroyCurrentTask
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_02164188:
	bl SailPlayer__HasRetired
	cmp r0, #0
	beq _021641A4
	ldrh r0, [r4, #0x10]
	cmp r0, #0x40
	moveq r0, #0x20
	streqh r0, [r4, #0x10]
_021641A4:
	ldrh r0, [r4, #0x10]
	cmp r0, #0x20
	blo _021641C0
	tst r0, #7
	beq _021641CC
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_021641C0:
	tst r0, #3
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
_021641CC:
	ldr r0, [r4, #0]
	add r2, sp, #0
	add r0, r0, #0x44
	add r1, r4, #4
	bl VEC_Subtract
	add r0, sp, #0
	bl EffectSailSmoke__Create
	ldr r1, _02164320 // =_obj_disp_rand
	ldr r6, _02164324 // =0x00196225
	ldr r2, [r1, #0]
	ldr r7, _02164328 // =0x3C6EF35F
	ldr r3, _0216432C // =0x000001FE
	mla lr, r2, r6, r7
	mov r2, lr, lsr #0x10
	mov r2, r2, lsl #0x10
	mvn ip, #0x3c0
	and r2, r3, r2, lsr #16
	str lr, [r1]
	mov r4, r0
	sub r2, ip, r2
	str r2, [r4, #0x9c]
	ldr r3, [r1, #0]
	rsb lr, ip, #0x3d
	mla r2, r3, r6, r7
	mov r3, r2, lsr #0x10
	mov r3, r3, lsl #0x10
	and lr, lr, r3, lsr #16
	add r3, ip, #0x5c0
	str r2, [r1]
	sub r2, r3, lr
	str r2, [r4, #0x98]
	ldr r2, [r1, #0]
	rsb r3, ip, #0x3d
	mla r6, r2, r6, r7
	mov r2, r6, lsr #0x10
	mov r2, r2, lsl #0x10
	and r3, r3, r2, lsr #16
	add r2, ip, #0x5c0
	str r6, [r1]
	sub r1, r2, r3
	str r1, [r4, #0xa0]
	ldr r2, [r4, #0x98]
	ldr r1, _02164330 // =0x00005294
	rsb r2, r2, #0
	mov r2, r2, asr #5
	str r2, [r4, #0xa4]
	ldr r2, [r4, #0x9c]
	mov r2, r2, asr #5
	str r2, [r4, #0xa8]
	ldr r2, [r4, #0xa0]
	rsb r2, r2, #0
	mov r2, r2, asr #5
	str r2, [r4, #0xac]
	ldr r3, [r4, #0xa4]
	ldr r2, [r5, #0x34]
	sub r2, r3, r2, asr #8
	str r2, [r4, #0xa4]
	ldr r3, [r4, #0xac]
	ldr r2, [r5, #0x3c]
	sub r2, r3, r2, asr #8
	str r2, [r4, #0xac]
	bl SailObject_SetSpriteColor
	ldr r3, _02164320 // =_obj_disp_rand
	ldr r0, _02164324 // =0x00196225
	ldr r5, [r3, #0]
	mov r1, r7
	mla r1, r5, r0, r1
	mov r0, r1, lsr #0x10
	str r1, [r3]
	ldr r2, _02164334 // =0x000003FE
	mov r0, r0, lsl #0x10
	and r0, r2, r0, lsr #16
	ldr r1, _02164338 // =0x00000DFF
	ldr r2, [r4, #0x38]
	sub r0, r1, r0
	smull r1, r0, r2, r0
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02164320: .word _obj_disp_rand
_02164324: .word 0x00196225
_02164328: .word 0x3C6EF35F
_0216432C: .word 0x000001FE
_02164330: .word 0x00005294
_02164334: .word 0x000003FE
_02164338: .word 0x00000DFF
	arm_func_end EffectUnknown2161544__Main

	arm_func_start EffectSailWaterSprayFront__State_216433C
EffectSailWaterSprayFront__State_216433C: // 0x0216433C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl SailManager__GetWork
	ldr r5, [r6, #0x11c]
	ldr r0, [r6, #0x20]
	ldr r4, [r5, #0x124]
	ldr r1, [r5, #0x98]
	ldr r2, [r4, #0x10]
	ldr r3, [r5, #0xa0]
	orr r1, r2, r1
	bic r0, r0, #0x20
	str r0, [r6, #0x20]
	orrs r0, r3, r1
	beq _02164380
	ldr r0, [r5, #0x1c]
	tst r0, #0x10
	beq _02164390
_02164380:
	ldr r0, [r6, #0x20]
	orr r0, r0, #0x20
	str r0, [r6, #0x20]
	ldmia sp!, {r4, r5, r6, pc}
_02164390:
	bl SailManager__GetShipType
	cmp r0, #0
	beq _021643A8
	bl SailManager__GetShipType
	cmp r0, #2
	bne _02164450
_021643A8:
	ldr r1, [r4, #0x10]
	cmp r1, #0
	rsblt r0, r1, #0
	movge r0, r1
	cmp r1, #0
	bne _021643DC
	ldr r0, [r5, #0xc4]
	ldr r1, [r5, #0xbc]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	add r0, r1, r0
_021643DC:
	mov r1, r0, lsl #0x10
	ldr r3, [r6, #0x2c]
	mov r1, r1, asr #0x10
	smull r2, r1, r3, r1
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	mov r1, r3, asr #1
	cmp r2, r3, asr #1
	movlt r2, r1
	str r2, [r6, #0x3c]
	ldr r1, [r6, #0x2c]
	cmp r2, r1
	movlt r2, r1
	str r2, [r6, #0x38]
	str r2, [r6, #0x40]
	cmp r0, #0x3e0
	bge _0216443C
	ldr r2, [r6, #0x12c]
	mov r1, r0, asr #5
	ldr r0, [r2, #0x94]
	bl NNS_G3dMdlSetMdlAlphaAll
	b _02164460
_0216443C:
	ldr r0, [r6, #0x12c]
	mov r1, #0x1f
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlAlphaAll
	b _02164460
_02164450:
	ldr r0, [r6, #0x2c]
	str r0, [r6, #0x38]
	str r0, [r6, #0x3c]
	str r0, [r6, #0x40]
_02164460:
	mov r0, r6
	bl SailObject_HandleParentFollow
	mov r0, r6
	bl SailObject_ApplyRotation
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end EffectSailWaterSprayFront__State_216433C

	arm_func_start EffectSailSubmarineWater__State_2164474
EffectSailSubmarineWater__State_2164474: // 0x02164474
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r0, [r0, #0x24]
	ldr r1, [r4, #0x11c]
	tst r0, #1
	ldr r0, [r4, #0x20]
	orrne r0, r0, #0x20
	orrne r0, r0, #0x1000
	biceq r0, r0, #0x20
	biceq r0, r0, #0x1000
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x68]
	cmp r0, #0
	bge _021644C4
	ldr r0, [r1, #0x24]
	tst r0, #0x1000
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #0x20
	strne r0, [r4, #0x20]
_021644C4:
	mov r0, r4
	bl SailObject_HandleParentFollow
	mov r0, r4
	bl SailObject_ApplyRotation
	ldmia sp!, {r4, pc}
	arm_func_end EffectSailSubmarineWater__State_2164474

	arm_func_start EffectSailSubmarineWater2__State_21644D8
EffectSailSubmarineWater2__State_21644D8: // 0x021644D8
	ldr ip, _021644E0 // =SailObject_HandleParentFollow
	bx ip
	.align 2, 0
_021644E0: .word SailObject_HandleParentFollow
	arm_func_end EffectSailSubmarineWater2__State_21644D8

	arm_func_start EffectSailWaterSplash__State_21644E4
EffectSailWaterSplash__State_21644E4: // 0x021644E4
	ldr r1, [r0, #0x20]
	tst r1, #8
	ldrne r1, [r0, #0x18]
	orrne r1, r1, #4
	strne r1, [r0, #0x18]
	bx lr
	arm_func_end EffectSailWaterSplash__State_21644E4

	arm_func_start EffectSailWater08__State_21644FC
EffectSailWater08__State_21644FC: // 0x021644FC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x20]
	tst r0, #8
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #4
	strne r0, [r4, #0x18]
	ldr r0, _02164530 // =0x00007FFF
	bl SailObject_ApplyFogBrightness
	mov r1, r0
	mov r0, r4
	bl SailObject_SetSpriteColor
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164530: .word 0x00007FFF
	arm_func_end EffectSailWater08__State_21644FC

	arm_func_start EffectSailFlash2__State_2164534
EffectSailFlash2__State_2164534: // 0x02164534
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r0, [r0, #0x98]
	ldr r1, [r4, #0x2c]
	ldrh r2, [r0, #0x34]
	mov r0, r4
	sub r1, r2, r1
	strh r1, [r4, #0x32]
	bl SailObject_ApplyRotation
	ldr r0, [r4, #0x20]
	tst r0, #8
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #4
	strne r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	arm_func_end EffectSailFlash2__State_2164534

	arm_func_start EffectSailBazooka__State_2164574
EffectSailBazooka__State_2164574: // 0x02164574
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r5, [r0, #0x98]
	bl SailManager__GetWork
	ldr r2, [r0, #0x70]
	ldrh r1, [r5, #0x34]
	ldr r0, [r4, #0x2c]
	ldr r2, [r2, #0x124]
	sub r0, r1, r0
	strh r0, [r4, #0x32]
	add r0, r2, #0x100
	ldrsh r0, [r0, #0xca]
	ldrh r2, [r4, #0x32]
	cmp r0, #0
	rsblt r0, r0, #0
	rsb r1, r0, #0x4000
	add r1, r2, r1, asr #3
	mov r0, r4
	strh r1, [r4, #0x32]
	bl SailObject_ApplyRotation
	ldr r0, [r4, #0x20]
	tst r0, #8
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #4
	strne r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end EffectSailBazooka__State_2164574

	arm_func_start EffectEffectSailBullet2__State_21645E0
EffectEffectSailBullet2__State_21645E0: // 0x021645E0
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r5, [r4, #0x124]
	bl SailObject_HandleVoyageVelocity
	add r0, r5, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r4
	add r1, r1, #0x8000
	strh r1, [r4, #0x32]
	bl SailObject_ApplyRotation
	mov r0, r4
	mov r1, #1
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	beq _02164670
	ldr r0, [r4, #0x28]
	cmp r0, #0x64
	bhs _02164670
	sub r0, r0, #1
	str r0, [r4, #0x28]
	mov r0, #0x10
	str r0, [sp]
	mov r1, #0
	ldr r0, [r4, #0x38]
	mov r3, r1
	mov r2, #1
	bl ObjShiftSet
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	ldr r0, [r4, #0x28]
	cmp r0, #0
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #4
	streq r0, [r4, #0x18]
_02164670:
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0x12
	ldrgt r0, [r4, #0x18]
	orrgt r0, r0, #4
	strgt r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end EffectEffectSailBullet2__State_21645E0

	arm_func_start EffectSailWater09__State_2164690
EffectSailWater09__State_2164690: // 0x02164690
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r0, [r4, #0x20]
	ldr r1, [r4, #0x11c]
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	ldr r0, [r1, #0x1c]
	tst r0, #0x10
	beq _021646C8
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x20
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}
_021646C8:
	mov r0, r4
	bl SailObject_HandleParentFollow
	mov r0, r4
	bl SailObject_ApplyRotation
	ldmia sp!, {r4, pc}
	arm_func_end EffectSailWater09__State_2164690

	.rodata

_0218BC40: // 0x0218BC40
    .word 0, 0x1000, 0

_0218BC4C: // 0x0218BC4C
    .word 0x1000, 0x1000, 0x1000

	.data
aSbWater00Nsbmd_0: // 0x0218CEA8
	.asciz "sb_water00.nsbmd"
	.align 4

aSbWater00Nsbca: // 0x0218CEBC
	.asciz "sb_water00.nsbca"
	.align 4

aSbWater00Nsbtp: // 0x0218CED0
	.asciz "sb_water00.nsbtp"
	.align 4

aSbWater01Nsbmd_0: // 0x0218CEE4
	.asciz "sb_water01.nsbmd"
	.align 4

aSbWater01Nsbca: // 0x0218CEF8
	.asciz "sb_water01.nsbca"
	.align 4

aSbWater01Nsbta: // 0x0218CF0C
	.asciz "sb_water01.nsbta"
	.align 4

aSbSubWaterNsbm_0: // 0x0218CF20
	.asciz "sb_sub_water.nsbmd"
	.align 4

aSbSubWaterNsbc: // 0x0218CF34
	.asciz "sb_sub_water.nsbca"
	.align 4

aSbSubWaterNsbt: // 0x0218CF48
	.asciz "sb_sub_water.nsbta"
	.align 4

aSbWaterBac: // 0x0218CF5C
	.asciz "sb_water.bac"
	.align 4

aSbHitBac: // 0x0218CF6C
	.asciz "sb_hit.bac"
	.align 4

aSbGuardBac: // 0x0218CF78
	.asciz "sb_guard.bac"
	.align 4

aSbBombBac: // 0x0218CF88
	.asciz "sb_bomb.bac"
	.align 4

aSbFireBac_0: // 0x0218CF94
	.asciz "sb_fire.bac"
	.align 4

aSbSmokeBac: // 0x0218CFA0
	.asciz "sb_smoke.bac"
	.align 4

aSbBoost01Nsbmd_0: // 0x0218CFB0
	.asciz "sb_boost01.nsbmd"
	.align 4

aSbBoost01Nsbca: // 0x0218CFC4
	.asciz "sb_boost01.nsbca"
	.align 4

aSbBoost01Nsbta: // 0x0218CFD8
	.asciz "sb_boost01.nsbta"
	.align 4

aSbBoost01Nsbva: // 0x0218CFEC
	.asciz "sb_boost01.nsbva"
	.align 4

aSbBoost02Nsbmd_0: // 0x0218D000
	.asciz "sb_boost02.nsbmd"
	.align 4

aSbBoost02Nsbca: // 0x0218D014
	.asciz "sb_boost02.nsbca"
	.align 4

aSbBoost02Nsbtp: // 0x0218D028
	.asciz "sb_boost02.nsbtp"
	.align 4

aSbCircleNsbmd_0: // 0x0218D03C
	.asciz "sb_circle.nsbmd"
	.align 4

aSbCircleNsbca: // 0x0218D04C
	.asciz "sb_circle.nsbca"
	.align 4

aSbCircleNsbma: // 0x0218D05C
	.asciz "sb_circle.nsbma"
	.align 4

aSbTrickBac: // 0x0218D06C
	.asciz "sb_trick.bac"
	.align 4

aSbJetLogoFixBa_0: // 0x0218D07C
	.asciz "sb_jet_logo_fix.bac"
	.align 4

aSbWater02Nsbmd_0: // 0x0218D090
	.asciz "sb_water02.nsbmd"
	.align 4

aSbWater02Nsbca: // 0x0218D0A4
	.asciz "sb_water02.nsbca"
	.align 4

aSbWater02Nsbta: // 0x0218D0B8
	.asciz "sb_water02.nsbta"
	.align 4

aSbTrickNsbmd_0: // 0x0218D0CC
	.asciz "sb_trick.nsbmd"
	.align 4

aSbTrickNsbca: // 0x0218D0DC
	.asciz "sb_trick.nsbca"
	.align 4

aSbTrickNsbtp: // 0x0218D0EC
	.asciz "sb_trick.nsbtp"
	.align 4

aSbShellBac_0: // 0x0218D0FC
	.asciz "sb_shell.bac"
	.align 4

aSbWater08Bac: // 0x0218D10C
	.asciz "sb_water08.bac"
	.align 4

aSbWater05Bac: // 0x0218D11C
	.asciz "sb_water05.bac"
	.align 4

aSbWater06Bac: // 0x0218D12C
	.asciz "sb_water06.bac"
	.align 4

aSbWater07Bac: // 0x0218D13C
	.asciz "sb_water07.bac"
	.align 4

aSbFlashBac: // 0x0218D14C
	.asciz "sb_flash.bac"
	.align 4

aSbFlashNsbmd_0: // 0x0218D15C
	.asciz "sb_flash.nsbmd"
	.align 4

aSbFlashNsbca: // 0x0218D16C
	.asciz "sb_flash.nsbca"
	.align 4

aSbFlashNsbva: // 0x0218D17C
	.asciz "sb_flash.nsbva"
	.align 4

aSbFlashNsbma: // 0x0218D18C
	.asciz "sb_flash.nsbma"
	.align 4

aSbFlashNsbtp: // 0x0218D19C
	.asciz "sb_flash.nsbtp"
	.align 4

aSbBazookaNsbmd_0: // 0x0218D1AC
	.asciz "sb_bazooka.nsbmd"
	.align 4

aSbBazookaNsbca: // 0x0218D1C0
	.asciz "sb_bazooka.nsbca"
    .align 4

aSbBazookaNsbva: // 0x0218D1D4
	.asciz "sb_bazooka.nsbva"
    .align 4

aSbBazookaNsbtp: // 0x0218D1E8
	.asciz "sb_bazooka.nsbtp"
    .align 4

aSbBullet1Nsbmd_0: // 0x0218D1FC
	.asciz "sb_bullet1.nsbmd"
    .align 4

aSbBullet1Nsbca: // 0x0218D210
	.asciz "sb_bullet1.nsbca"
    .align 4

aSbBullet2Nsbmd_0: // 0x0218D224
	.asciz "sb_bullet2.nsbmd"
    .align 4

aSbBullet2Nsbca: // 0x0218D238
	.asciz "sb_bullet2.nsbca"
    .align 4

aSbBullet3Nsbmd_0: // 0x0218D24C
	.asciz "sb_bullet3.nsbmd"
    .align 4

aSbBullet3Nsbca: // 0x0218D260
	.asciz "sb_bullet3.nsbca"
    .align 4

aSbWater09Nsbmd_0: // 0x0218D274
	.asciz "sb_water09.nsbmd"
    .align 4

aSbWater09Nsbca: // 0x0218D288
	.asciz "sb_water09.nsbca"
    .align 4

aSbWater09Nsbta: // 0x0218D29C
	.asciz "sb_water09.nsbta"
    .align 4