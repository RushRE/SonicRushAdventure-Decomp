	.include "asm/macros.inc"
	.include "global.inc"

	.text
	
	arm_func_start MATH_CountPopulation
MATH_CountPopulation: // 0x03804560
	ldr r1, _03804598 // =0x55555555
	and r1, r1, r0, lsr #1
	sub r2, r0, r1
	ldr r0, _0380459C // =0x33333333
	and r1, r2, r0
	and r0, r0, r2, lsr #2
	add r0, r1, r0
	add r1, r0, r0, lsr #4
	ldr r0, _038045A0 // =0x0F0F0F0F
	and r0, r1, r0
	add r0, r0, r0, lsr #8
	add r0, r0, r0, lsr #16
	and r0, r0, #0xff
	bx lr
	.align 2, 0
_03804598: .word 0x55555555
_0380459C: .word 0x33333333
_038045A0: .word 0x0F0F0F0F
	arm_func_end MATH_CountPopulation