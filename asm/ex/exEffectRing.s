	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start exEffectRingTask__Main
exEffectRingTask__Main: // 0x021683AC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _021683F0 // =0x02176590
	str r0, [r1, #8]
	ldr r0, [r4, #0xc]
	cmp r0, #0
	bne _021683DC
	bl GetExTaskCurrent
	ldr r1, _021683F4 // =ExTask_State_Destroy
	str r1, [r0]
_021683DC:
	bl GetExTaskCurrent
	ldr r1, _021683F8 // =ovl09_2168448
	str r1, [r0]
	bl ovl09_2168448
	ldmia sp!, {r4, pc}
	.align 2, 0
_021683F0: .word 0x02176590
_021683F4: .word ExTask_State_Destroy
_021683F8: .word ovl09_2168448
	arm_func_end exEffectRingTask__Main

	arm_func_start exEffectRingTask__Func8
exEffectRingTask__Func8: // 0x021683FC
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl ovl09_2172AE0
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02168420 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02168420: .word ExTask_State_Destroy
	arm_func_end exEffectRingTask__Func8

	arm_func_start exEffectRingTask__Destructor
exEffectRingTask__Destructor: // 0x02168424
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0x10
	bl ovl09_2168190
	ldr r0, _02168444 // =0x02176590
	mov r1, #0
	str r1, [r0, #8]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02168444: .word 0x02176590
	arm_func_end exEffectRingTask__Destructor

	arm_func_start ovl09_2168448
ovl09_2168448: // 0x02168448
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r1, [r4, #0x140]
	ldr r0, [r4, #4]
	sub r0, r1, r0
	str r0, [r4, #0x140]
	ldrb r0, [r4, #0x16]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _0216847C
	bl ovl09_21684DC
	ldmia sp!, {r4, pc}
_0216847C:
	ldr r1, [r4, #0x13c]
	cmp r1, #0x5a000
	bge _021684A4
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ldrgt r1, [r4, #0x140]
	addgt r0, r0, #0x32000
	cmpgt r1, r0
	bgt _021684B4
_021684A4:
	bl GetExTaskCurrent
	ldr r1, _021684D8 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021684B4:
	add r0, r4, #0x10
	add r1, r4, #0x160
	bl ovl09_2164034
	add r0, r4, #0x10
	bl ovl09_216AE78
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_021684D8: .word ExTask_State_Destroy
	arm_func_end ovl09_2168448

	arm_func_start ovl09_21684DC
ovl09_21684DC: // 0x021684DC
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exSysTask__GetStatus
	mov r5, r0
	mov r3, #0x27
	mov r0, #0
	sub r1, r3, #0x28
	stmia sp, {r0, r3}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldrh r1, [r5, #6]
	ldr r0, _0216855C // =0x000003E7
	cmp r1, r0
	addlo r0, r1, #1
	strloh r0, [r5, #6]
	ldrb r2, [r4, #0x16]
	add r0, r4, #0x10
	mov r1, #8
	bic r2, r2, #1
	strb r2, [r4, #0x16]
	bl ovl09_216810C
	add r0, r4, #0x160
	bl ovl09_21641F0
	bl GetExTaskCurrent
	ldr r1, _02168560 // =ovl09_2168564
	str r1, [r0]
	bl ovl09_2168564
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216855C: .word 0x000003E7
_02168560: .word ovl09_2168564
	arm_func_end ovl09_21684DC

	arm_func_start ovl09_2168564
ovl09_2168564: // 0x02168564
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r1, [r4, #0x140]
	ldr r0, [r4, #4]
	sub r0, r1, r0
	str r0, [r4, #0x140]
	ldrb r0, [r4, #0x161]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _021685A0
	bl GetExTaskCurrent
	ldr r1, _021685FC // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021685A0:
	ldr r1, [r4, #0x13c]
	cmp r1, #0x5a000
	bge _021685C8
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ldrgt r1, [r4, #0x140]
	addgt r0, r0, #0x32000
	cmpgt r1, r0
	bgt _021685D8
_021685C8:
	bl GetExTaskCurrent
	ldr r1, _021685FC // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021685D8:
	add r0, r4, #0x10
	bl ovl09_2163ADC
	add r0, r4, #0x10
	add r1, r4, #0x160
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_021685FC: .word ExTask_State_Destroy
	arm_func_end ovl09_2168564

	arm_func_start exEffectRingTask__Create
exEffectRingTask__Create: // 0x02168600
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x2b0
	str r1, [sp, #4]
	ldr r0, _021686E0 // =aExeffectringta
	ldr r1, _021686E4 // =exEffectRingTask__Destructor
	str r0, [sp, #8]
	ldr r0, _021686E8 // =exEffectRingTask__Main
	mov r2, #0x4000
	mov r3, #5
	str r4, [sp, #0xc]
	ldr r7, [sp, #0x2c]
	ldr r6, [sp, #0x38]
	ldr r5, [sp, #0x3c]
	bl ExTaskCreate_
	mov r8, r0
	bl GetExTaskWork_
	mov r1, r4
	mov r2, #0x2b0
	mov r4, r0
	bl MI_CpuFill8
	mov r0, r8
	bl GetExTask
	ldr r1, _021686EC // =exEffectRingTask__Func8
	str r1, [r0, #8]
	add r0, r4, #0x10
	bl ovl09_2168070
	cmp r0, #0
	moveq r0, #0
	streq r0, [r4, #0xc]
	addeq sp, sp, #0x10
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	addeq sp, sp, #0x10
	bxeq lr
	mov r2, #1
	add r0, r4, #0x160
	mov r1, #0xa800
	str r2, [r4, #0xc]
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x160
	bl exDrawReqTask__Func_2164218
	ldr r1, [sp, #0x28]
	ldr r0, [sp, #0x34]
	str r1, [r4, #0x13c]
	str r7, [r4, #0x140]
	stmia r4, {r0, r6}
	str r5, [r4, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_021686E0: .word aExeffectringta
_021686E4: .word exEffectRingTask__Destructor
_021686E8: .word exEffectRingTask__Main
_021686EC: .word exEffectRingTask__Func8
	arm_func_end exEffectRingTask__Create