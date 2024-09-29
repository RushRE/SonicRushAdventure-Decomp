	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start sub_20CCC00
sub_20CCC00: // 0x020CCC00
	ldr ip, _020CCC08 // =DGT_Hash1GetDigest_R
	bx ip
	.align 2, 0
_020CCC08: .word DGT_Hash1GetDigest_R
	arm_func_end sub_20CCC00

	arm_func_start sub_20CCC0C
sub_20CCC0C: // 0x020CCC0C
	ldr ip, _020CCC14 // =DGT_Hash1SetSource
	bx ip
	.align 2, 0
_020CCC14: .word DGT_Hash1SetSource
	arm_func_end sub_20CCC0C

	arm_func_start sub_20CCC18
sub_20CCC18: // 0x020CCC18
	ldr ip, _020CCC20 // =DGT_Hash1Reset
	bx ip
	.align 2, 0
_020CCC20: .word DGT_Hash1Reset
	arm_func_end sub_20CCC18