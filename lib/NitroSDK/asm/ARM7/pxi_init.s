	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start PXI_Init
PXI_Init: // 0x037FE9C0
	ldr ip, _037FE9C8 // =PXI_InitFifo
	bx ip
	.align 2, 0
_037FE9C8: .word PXI_InitFifo
	arm_func_end PXI_Init