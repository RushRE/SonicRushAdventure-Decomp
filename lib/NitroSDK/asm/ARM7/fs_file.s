	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start FS_Init
FS_Init: // 0x03803324
	ldr ip, _0380332C // =CARD_Init
	bx ip
	.align 2, 0
_0380332C: .word CARD_Init
	arm_func_end FS_Init