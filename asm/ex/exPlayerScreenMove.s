	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start ovl09_216E3F4
ovl09_216E3F4: // 0x0216E3F4
	ldr r0, _0216E3FC // =0x02177BAC
	bx lr
	.align 2, 0
_0216E3FC: .word 0x02177BAC
	arm_func_end ovl09_216E3F4

	arm_func_start ovl09_216E400
ovl09_216E400: // 0x0216E400
	ldr r1, _0216E40C // =0x02177BA0
	str r0, [r1]
	bx lr
	.align 2, 0
_0216E40C: .word 0x02177BA0
	arm_func_end ovl09_216E400

	arm_func_start exPlayerScreenMoveTask__Main
exPlayerScreenMoveTask__Main: // 0x0216E410
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _0216E448 // =0x02177BA0
	str r0, [r1, #8]
	bl ovl09_2161698
	str r0, [r4, #4]
	bl ovl09_21616A4
	str r0, [r4, #8]
	bl GetExTaskCurrent
	ldr r1, _0216E44C // =exPlayerScreenMoveTask__Main_216E478
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E448: .word 0x02177BA0
_0216E44C: .word exPlayerScreenMoveTask__Main_216E478
	arm_func_end exPlayerScreenMoveTask__Main

	arm_func_start exPlayerScreenMoveTask__Func8
exPlayerScreenMoveTask__Func8: // 0x0216E450
	ldr ip, _0216E458 // =GetExTaskWorkCurrent_
	bx ip
	.align 2, 0
_0216E458: .word GetExTaskWorkCurrent_
	arm_func_end exPlayerScreenMoveTask__Func8

	arm_func_start exPlayerScreenMoveTask__Destructor
exPlayerScreenMoveTask__Destructor: // 0x0216E45C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, _0216E474 // =0x02177BA0
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216E474: .word 0x02177BA0
	arm_func_end exPlayerScreenMoveTask__Destructor

	arm_func_start exPlayerScreenMoveTask__Main_216E478
exPlayerScreenMoveTask__Main_216E478: // 0x0216E478
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, _0216E4FC // =0x02177BA0
	ldr lr, [r0, #4]
	ldr r5, [r1]
	ldr r3, _0216E500 // =0x51EB851F
	ldr r2, [r5]
	ldrh ip, [lr, #0xa2]
	mov r1, r2, lsr #0x1f
	smull r2, r4, r3, r2
	add r4, r1, r4, asr #5
	mov r1, #0x32
	mul r3, r4, r1
	cmp ip, #1
	bne _0216E4C4
	cmp r5, #0
	strne r3, [lr, #0x70]
	ldrne r1, [r0, #4]
	strne r3, [r1, #0x7c]
_0216E4C4:
	ldr r2, [r0, #8]
	ldrh r1, [r2, #0xa2]
	cmp r1, #1
	bne _0216E4EC
	ldr r1, _0216E4FC // =0x02177BA0
	ldr r1, [r1]
	cmp r1, #0
	strne r3, [r2, #0x70]
	ldrne r0, [r0, #8]
	strne r3, [r0, #0x7c]
_0216E4EC:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216E4FC: .word 0x02177BA0
_0216E500: .word 0x51EB851F
	arm_func_end exPlayerScreenMoveTask__Main_216E478

	arm_func_start exPlayerScreenMoveTask__Create
exPlayerScreenMoveTask__Create: // 0x0216E504
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0xc
	ldr r0, _0216E55C // =aExplayerscreen
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0216E560 // =exPlayerScreenMoveTask__Main
	ldr r1, _0216E564 // =exPlayerScreenMoveTask__Destructor
	ldr r2, _0216E568 // =0x0000EFFD
	mov r3, #3
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r0, r4
	bl GetExTask
	ldr r1, _0216E56C // =exPlayerScreenMoveTask__Func8
	str r1, [r0, #8]
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E55C: .word aExplayerscreen
_0216E560: .word exPlayerScreenMoveTask__Main
_0216E564: .word exPlayerScreenMoveTask__Destructor
_0216E568: .word 0x0000EFFD
_0216E56C: .word exPlayerScreenMoveTask__Func8
	arm_func_end exPlayerScreenMoveTask__Create