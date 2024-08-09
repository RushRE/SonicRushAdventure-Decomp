	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start OS_Terminate
OS_Terminate: // 0x037FE638
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0
	bl CTRDG_VibPulseEdgeUpdate
_037FE648:
	bl OS_DisableInterrupts
	bl SVC_Halt_ARM
	b _037FE648
	arm_func_end OS_Terminate