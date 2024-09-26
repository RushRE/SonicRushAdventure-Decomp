	.include "asm/macros.inc"
	.include "global.inc"

	.text
	
	arm_func_start OSi_SetTimerReserved
OSi_SetTimerReserved: // 0x037FD790
	ldr r1, _037FD7A8 // =OSi_TimerReserved
	ldrh r3, [r1]
	mov r2, #1
	orr r0, r3, r2, lsl r0
	strh r0, [r1]
	bx lr
	.align 2, 0
_037FD7A8: .word OSi_TimerReserved
	arm_func_end OSi_SetTimerReserved