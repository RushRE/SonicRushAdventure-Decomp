	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
.public exGameSystemTask__singleton
exGameSystemTask__singleton: // 0x0217741C
	.space 0x04
	
	.text

	arm_func_start exGameSystemTask__Main
exGameSystemTask__Main: // 0x0216AAA4
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r2, _0216AB14 // =exGameSystemTask__singleton
	mov r1, #0
	str r0, [r2]
	mov r0, r4
	mov r2, #0x10
	bl MI_CpuFill8
	bl exSysTask__GetStatus
	str r0, [r4, #0xc]
	bl exStageTask__CreateEx
	bl exPlayerAdminTask__Create
	bl exBossSysAdminTask__Create
	mov r0, #0x16
	str r0, [sp]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlayTrack
	bl GetExTaskCurrent
	ldr r1, _0216AB18 // =exGameSystemTask__Main_216AB78
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0216AB14: .word exGameSystemTask__singleton
_0216AB18: .word exGameSystemTask__Main_216AB78
	arm_func_end exGameSystemTask__Main

	arm_func_start exGameSystemTask__Func8
exGameSystemTask__Func8: // 0x0216AB1C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrh r1, [r0, #2]
	add r1, r1, #1
	strh r1, [r0, #2]
	ldrh r1, [r0, #2]
	cmp r1, #0
	ldreqh r1, [r0, #0]
	addeq r1, r1, #1
	streqh r1, [r0]
	ldmia sp!, {r3, pc}
	arm_func_end exGameSystemTask__Func8

	arm_func_start exGameSystemTask__Destructor
exGameSystemTask__Destructor: // 0x0216AB48
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exEffectRingAdminTask__Destroy
	bl ExBossSysAdminTask__Destroy
	bl exPlayerAdminTask__Destroy_2171730
	bl exStageTask__Destroy
	bl exEffectMeteoAdminTask__Destroy_2168044
	ldr r0, _0216AB74 // =exGameSystemTask__singleton
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216AB74: .word exGameSystemTask__singleton
	arm_func_end exGameSystemTask__Destructor

	arm_func_start exGameSystemTask__Main_216AB78
exGameSystemTask__Main_216AB78: // 0x0216AB78
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #4
	bne _0216AB98
	bl exGameSystemTask__Action_216ABA8
	ldmia sp!, {r3, pc}
_0216AB98:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exGameSystemTask__Main_216AB78

	arm_func_start exGameSystemTask__Action_216ABA8
exGameSystemTask__Action_216ABA8: // 0x0216ABA8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, _0216ABD0 // =exGameSystemTask__Main_216ABD4
	str r1, [r0]
	bl exGameSystemTask__Main_216ABD4
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216ABD0: .word exGameSystemTask__Main_216ABD4
	arm_func_end exGameSystemTask__Action_216ABA8

	arm_func_start exGameSystemTask__Main_216ABD4
exGameSystemTask__Main_216ABD4: // 0x0216ABD4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl ExBossSysAdminTask__Func_215DF1C
	cmp r0, #0
	bne _0216ABF0
	bl exGameSystemTask__Action_216AC00
	ldmia sp!, {r3, pc}
_0216ABF0:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exGameSystemTask__Main_216ABD4

	arm_func_start exGameSystemTask__Action_216AC00
exGameSystemTask__Action_216AC00: // 0x0216AC00
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exEffectMeteoAdminTask__Create
	bl exEffectRingAdminTask__Create
	mov r0, #0x384
	strh r0, [r4, #4]
	bl GetExTaskCurrent
	ldr r1, _0216AC30 // =exGameSystemTask__Main_216AC34
	str r1, [r0]
	bl exGameSystemTask__Main_216AC34
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216AC30: .word exGameSystemTask__Main_216AC34
	arm_func_end exGameSystemTask__Action_216AC00

	arm_func_start exGameSystemTask__Main_216AC34
exGameSystemTask__Main_216AC34: // 0x0216AC34
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrh r2, [r0, #4]
	sub r1, r2, #1
	strh r1, [r0, #4]
	cmp r2, #0
	bne _0216AC58
	bl exGameSystemTask__Action_216AC68
	ldmia sp!, {r3, pc}
_0216AC58:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exGameSystemTask__Main_216AC34

	arm_func_start exGameSystemTask__Action_216AC68
exGameSystemTask__Action_216AC68: // 0x0216AC68
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exEffectMeteoAdminTask__Destroy_2168044
	mov r1, #0
	mov r0, #1
	strh r1, [r4, #4]
	bl ExBossSysAdminTask__Func_215DF2C
	bl GetExTaskCurrent
	ldr r1, _0216AC9C // =exGameSystemTask__Main_216ACA0
	str r1, [r0]
	bl exGameSystemTask__Main_216ACA0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216AC9C: .word exGameSystemTask__Main_216ACA0
	arm_func_end exGameSystemTask__Action_216AC68

	arm_func_start exGameSystemTask__Main_216ACA0
exGameSystemTask__Main_216ACA0: // 0x0216ACA0
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xa
	bne _0216ACC0
	bl exGameSystemTask__Action_216ACD0
	ldmia sp!, {r3, pc}
_0216ACC0:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exGameSystemTask__Main_216ACA0

	arm_func_start exGameSystemTask__Action_216ACD0
exGameSystemTask__Action_216ACD0: // 0x0216ACD0
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, _0216ACEC // =exGameSystemTask__Main_216ACF0
	str r1, [r0]
	bl exGameSystemTask__Main_216ACF0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216ACEC: .word exGameSystemTask__Main_216ACF0
	arm_func_end exGameSystemTask__Action_216ACD0

	arm_func_start exGameSystemTask__Main_216ACF0
exGameSystemTask__Main_216ACF0: // 0x0216ACF0
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exGameSystemTask__Main_216ACF0

	arm_func_start exGameSystemTask__Create
exGameSystemTask__Create: // 0x0216AD08
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x10
	ldr r0, _0216AD60 // =aExgamesystemta
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0216AD64 // =exGameSystemTask__Main
	ldr r1, _0216AD68 // =exGameSystemTask__Destructor
	mov r2, #0x1000
	mov r3, #1
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r0, r4
	bl GetExTask
	ldr r1, _0216AD6C // =exGameSystemTask__Func8
	str r1, [r0, #8]
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216AD60: .word aExgamesystemta
_0216AD64: .word exGameSystemTask__Main
_0216AD68: .word exGameSystemTask__Destructor
_0216AD6C: .word exGameSystemTask__Func8
	arm_func_end exGameSystemTask__Create

	arm_func_start exGameSystemTask__Destroy
exGameSystemTask__Destroy: // 0x0216AD70
	stmdb sp!, {r3, lr}
	ldr r0, _0216AD94 // =exGameSystemTask__singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, _0216AD98 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216AD94: .word exGameSystemTask__singleton
_0216AD98: .word ExTask_State_Destroy
	arm_func_end exGameSystemTask__Destroy

	.data
	
aExgamesystemta: // 0x02175D60
	.asciz "exGameSystemTask"