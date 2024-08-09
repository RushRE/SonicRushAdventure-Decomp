	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start NitroSpMain
NitroSpMain: // 0x037F8468
	stmdb sp!, {r4, lr}
	bl OS_Init
	bl OS_InitThread
	bl sub_37F8228
	bl PXI_Init
	bl sub_37F83B0
	mov r4, r0
	mov r0, #6
	bl SND_Init
	bl PAD_InitXYButton
	mov r0, #1
	ldr r1, _037F8520 // =VBlankIntr
	bl OS_SetIrqFunction
	mov r0, #1
	bl OS_EnableIrqMask
	ldr r1, _037F8524 // =0x04000004
	ldrh r0, [r1]
	ldrh r0, [r1]
	orr r0, r0, #8
	strh r0, [r1]
	ldr r1, _037F8528 // =0x04000208
	ldrh r0, [r1]
	mov r0, #1
	strh r0, [r1]
	bl OS_EnableInterrupts
	mvn r0, #0
	bl FS_Init
	mov r0, #0xf
	bl CARD_SetThreadPriority
	mov r0, #0xc
	bl RTC_Init
	mov r0, r4
	bl WVR_Init
	mov r0, #2
	bl SPI_Init
	mov r4, #0
_037F84F8:
	bl SVC_Halt_ARM
	bl OS_IsResetOccurred
	cmp r0, #0
	beq _037F8514
	mov r0, r4
	bl CTRDG_VibPulseEdgeUpdate
	bl OS_ResetSystem
_037F8514:
	bl CTRDG_CheckPullOut_Polling
	bl CARD_CheckPullOut_Polling
	b _037F84F8
	.align 2, 0
_037F8520: .word VBlankIntr
_037F8524: .word 0x04000004
_037F8528: .word 0x04000208
	arm_func_end NitroSpMain

	arm_func_start SVC_Halt_ARM
SVC_Halt_ARM: // 0x037F852C
	ldr ip, _037F8534 // =SVC_Halt
	bx ip
	.align 2, 0
_037F8534: .word SVC_Halt
	arm_func_end SVC_Halt_ARM