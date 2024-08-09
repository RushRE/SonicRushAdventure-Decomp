	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start VSMenuBackground__UpdateMain
VSMenuBackground__UpdateMain: // 0x02167130
	mov r2, #0x4000000
	ldr r1, [r2]
	bic r1, r1, #0x1f00
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
	arm_func_end VSMenuBackground__UpdateMain

	arm_func_start VSMenuBackground__UpdateSub
VSMenuBackground__UpdateSub: // 0x02167148
	ldr r2, _02167160 // =0x04001000
	ldr r1, [r2]
	bic r1, r1, #0x1f00
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
	.align 2, 0
_02167160: .word 0x04001000
	arm_func_end VSMenuBackground__UpdateSub

