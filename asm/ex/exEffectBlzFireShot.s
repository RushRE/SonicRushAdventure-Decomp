	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start exEffectBlzFireShotTask__Main
exEffectBlzFireShotTask__Main: // 0x02166EB0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02166EF4 // =0x021764E8
	str r0, [r1, #0x3c]
	add r0, r4, #4
	bl exEffectBlzFireTask__LoadFireShotAssets
	add r0, r4, #0x390
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _02166EF8 // =exEffectBlzFireShotTask__Main_Charge
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166EF4: .word 0x021764E8
_02166EF8: .word exEffectBlzFireShotTask__Main_Charge
	arm_func_end exEffectBlzFireShotTask__Main

	arm_func_start exEffectBlzFireShotTask__Func8
exEffectBlzFireShotTask__Func8: // 0x02166EFC
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetFlag_2178650
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02166F20 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02166F20: .word ExTask_State_Destroy
	arm_func_end exEffectBlzFireShotTask__Func8

	arm_func_start exEffectBlzFireShotTask__Destructor
exEffectBlzFireShotTask__Destructor: // 0x02166F24
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #4
	bl exEffectBlzFireTask__ReleaseFireShotAssets
	ldr r0, _02166F44 // =0x021764E8
	mov r1, #0
	str r1, [r0, #0x3c]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02166F44: .word 0x021764E8
	arm_func_end exEffectBlzFireShotTask__Destructor

	arm_func_start exEffectBlzFireShotTask__Main_Charge
exEffectBlzFireShotTask__Main_Charge: // 0x02166F48
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	ldr r1, [r4, #0x4e0]
	add r0, r4, #4
	ldr r1, [r1, #0x350]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x354]
	add r1, r1, #0x5000
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x358]
	str r1, [r4, #0x35c]
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02166FA4
	bl GetExTaskCurrent
	ldr r1, _02166FC0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02166FA4:
	add r0, r4, #4
	add r1, r4, #0x390
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166FC0: .word ExTask_State_Destroy
	arm_func_end exEffectBlzFireShotTask__Main_Charge

	arm_func_start exEffectBlzFireShotTask__Create
exEffectBlzFireShotTask__Create: // 0x02166FC4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _02167040 // =0x000004E8
	str r4, [sp]
	mov r6, r0
	ldr r0, _02167044 // =aExeffectblzfir_0
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02167048 // =exEffectBlzFireShotTask__Main
	ldr r1, _0216704C // =exEffectBlzFireShotTask__Destructor
	mov r2, #0x2000
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, _02167040 // =0x000004E8
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	str r6, [r4, #0x4e0]
	bl GetCurrentTask
	str r0, [r4, #0x4e4]
	mov r0, r5
	bl GetExTask
	ldr r1, _02167050 // =exEffectBlzFireShotTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02167040: .word 0x000004E8
_02167044: .word aExeffectblzfir_0
_02167048: .word exEffectBlzFireShotTask__Main
_0216704C: .word exEffectBlzFireShotTask__Destructor
_02167050: .word exEffectBlzFireShotTask__Func8
	arm_func_end exEffectBlzFireShotTask__Create

	.data
	
aExeffectblzfir_0: // 0x02174590
	.asciz "exEffectBlzFireShotTask"