	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start RtcSendPxiCommand
RtcSendPxiCommand: // 0x020EF700
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, r0, lsl #8
	and r1, r0, #0x7f00
	mov r0, #5
	mov r2, #0
	bl PXI_SendWordByFifo
	cmp r0, #0
	movge r0, #1
	movlt r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end RtcSendPxiCommand

	arm_func_start RTCi_WriteRawStatus2Async
RTCi_WriteRawStatus2Async: // 0x020EF734
	ldr ip, _020EF740 // =RtcSendPxiCommand
	mov r0, #0x27
	bx ip
	.align 2, 0
_020EF740: .word RtcSendPxiCommand
	arm_func_end RTCi_WriteRawStatus2Async

	arm_func_start RTCi_ReadRawTimeAsync
RTCi_ReadRawTimeAsync: // 0x020EF744
	ldr ip, _020EF750 // =RtcSendPxiCommand
	mov r0, #0x12
	bx ip
	.align 2, 0
_020EF750: .word RtcSendPxiCommand
	arm_func_end RTCi_ReadRawTimeAsync

	arm_func_start RTCi_ReadRawDateAsync
RTCi_ReadRawDateAsync: // 0x020EF754
	ldr ip, _020EF760 // =RtcSendPxiCommand
	mov r0, #0x11
	bx ip
	.align 2, 0
_020EF760: .word RtcSendPxiCommand
	arm_func_end RTCi_ReadRawDateAsync

	arm_func_start RTCi_ReadRawDateTimeAsync
RTCi_ReadRawDateTimeAsync: // 0x020EF764
	ldr ip, _020EF770 // =RtcSendPxiCommand
	mov r0, #0x10
	bx ip
	.align 2, 0
_020EF770: .word RtcSendPxiCommand
	arm_func_end RTCi_ReadRawDateTimeAsync
