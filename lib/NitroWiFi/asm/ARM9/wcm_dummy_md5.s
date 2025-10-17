	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start MD5Final
MD5Final: // 0x020CCC00
	ldr ip, _020CCC08 // =DGT_Hash1GetDigest_R
	bx ip
	.align 2, 0
_020CCC08: .word DGT_Hash1GetDigest_R
	arm_func_end MD5Final

	arm_func_start MD5Update
MD5Update: // 0x020CCC0C
	ldr ip, _020CCC14 // =DGT_Hash1SetSource
	bx ip
	.align 2, 0
_020CCC14: .word DGT_Hash1SetSource
	arm_func_end MD5Update

	arm_func_start MD5Init
MD5Init: // 0x020CCC18
	ldr ip, _020CCC20 // =DGT_Hash1Reset
	bx ip
	.align 2, 0
_020CCC20: .word DGT_Hash1Reset
	arm_func_end MD5Init