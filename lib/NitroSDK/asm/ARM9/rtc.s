	.include "asm/macros.inc"
	.include "global.inc"

	.bss

rtcInitialized: // 0x02150054
    .space 2
	.align 4

rtcWork: // 0x02150058
    .space 0x24 // RTCWork

	.text
	
	arm_func_start RtcWaitBusy
RtcWaitBusy: // 0x020EEDFC
	ldr ip, _020EEE10 // =rtcWork
_020EEE00:
	ldr r0, [ip]
	cmp r0, #1
	beq _020EEE00
	bx lr
	.align 2, 0
_020EEE10: .word rtcWork
	arm_func_end RtcWaitBusy

	arm_func_start RtcGetResultCallback
RtcGetResultCallback: // 0x020EEE14
	ldr r1, _020EEE20 // =rtcWork
	str r0, [r1, #0x20]
	bx lr
	.align 2, 0
_020EEE20: .word rtcWork
	arm_func_end RtcGetResultCallback

	arm_func_start RtcBCD2HEX
RtcBCD2HEX: // 0x020EEE24
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, #0
	mov r3, r5
	mov r2, r5
_020EEE38:
	mov r1, r0, lsr r2
	and r1, r1, #0xf
	cmp r1, #0xa
	addhs sp, sp, #4
	movhs r0, #0
	ldmhsia sp!, {r4, r5, lr}
	bxhs lr
	add r3, r3, #1
	cmp r3, #8
	add r2, r2, #4
	blt _020EEE38
	mov ip, #0
	mov lr, ip
	mov r4, #1
	mov r2, #0xa
_020EEE74:
	mov r1, r0, lsr lr
	and r3, r1, #0xf
	mul r1, r4, r2
	mla r5, r4, r3, r5
	add ip, ip, #1
	mov r4, r1
	cmp ip, #8
	add lr, lr, #4
	blt _020EEE74
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end RtcBCD2HEX

	arm_func_start RtcCommonCallback
RtcCommonCallback: // 0x020EEEA8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	cmp r2, #0
	beq _020EEF18
	ldr r0, _020EF418 // =rtcWork
	ldr r2, _020EF418 // =rtcWork
	ldr r1, [r0, #0x18]
	ldr r4, [r2, #4]
	cmp r1, #0
	movne r1, #0
	strne r1, [r0, #0x18]
	ldr r0, _020EF418 // =rtcWork
	ldr r1, [r0]
	cmp r1, #0
	movne r1, #0
	strne r1, [r0]
	cmp r4, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldr r1, [r2, #0x10]
	mov r3, #0
	mov r0, #6
	str r3, [r2, #4]
	blx r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
_020EEF18:
	and r0, r1, #0x7f00
	mov r0, r0, lsr #8
	and r0, r0, #0xff
	cmp r0, #0x30
	and r2, r1, #0xff
	bne _020EEF58
	ldr r0, _020EF418 // =rtcWork
	ldr r0, [r0, #0x1c]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	blx r0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
_020EEF58:
	cmp r2, #0
	bne _020EF370
	ldr r0, _020EF418 // =rtcWork
	mov r5, #0
	ldr r1, [r0, #0x14]
	cmp r1, #0xf
	addls pc, pc, r1, lsl #2
	b _020EF35C
_020EEF78: // jump table
	b _020EEFB8 // case 0
	b _020EF00C // case 1
	b _020EF05C // case 2
	b _020EF3B8 // case 3
	b _020EF3B8 // case 4
	b _020EF3B8 // case 5
	b _020EF104 // case 6
	b _020EF134 // case 7
	b _020EF158 // case 8
	b _020EF1FC // case 9
	b _020EF2B0 // case 10
	b _020EF3B8 // case 11
	b _020EF3B8 // case 12
	b _020EF3B8 // case 13
	b _020EF3B8 // case 14
	b _020EF3B8 // case 15
_020EEFB8:
	ldr r1, _020EF41C // =0x027FFDE8
	ldr r4, [r0, #8]
	ldrb r0, [r1]
	bl RtcBCD2HEX
	ldr r1, _020EF41C // =0x027FFDE8
	str r0, [r4]
	ldr r0, [r1]
	mov r0, r0, lsl #0x13
	mov r0, r0, lsr #0x1b
	bl RtcBCD2HEX
	ldr r1, _020EF41C // =0x027FFDE8
	str r0, [r4, #4]
	ldr r0, [r1]
	mov r0, r0, lsl #0xa
	mov r0, r0, lsr #0x1a
	bl RtcBCD2HEX
	str r0, [r4, #8]
	mov r0, r4
	bl RTC_GetDayOfWeek
	str r0, [r4, #0xc]
	b _020EF3B8
_020EF00C:
	ldr r1, _020EF420 // =0x027FFDEC
	ldr r4, [r0, #8]
	ldr r0, [r1]
	mov r0, r0, lsl #0x1a
	mov r0, r0, lsr #0x1a
	bl RtcBCD2HEX
	ldr r1, _020EF420 // =0x027FFDEC
	str r0, [r4]
	ldr r0, [r1]
	mov r0, r0, lsl #0x11
	mov r0, r0, lsr #0x19
	bl RtcBCD2HEX
	ldr r1, _020EF420 // =0x027FFDEC
	str r0, [r4, #4]
	ldr r0, [r1]
	mov r0, r0, lsl #9
	mov r0, r0, lsr #0x19
	bl RtcBCD2HEX
	str r0, [r4, #8]
	b _020EF3B8
_020EF05C:
	ldr r1, _020EF41C // =0x027FFDE8
	ldr r4, [r0, #8]
	ldr r0, [r1]
	and r0, r0, #0xff
	bl RtcBCD2HEX
	ldr r1, _020EF41C // =0x027FFDE8
	str r0, [r4]
	ldr r0, [r1]
	mov r0, r0, lsl #0x13
	mov r0, r0, lsr #0x1b
	bl RtcBCD2HEX
	ldr r1, _020EF41C // =0x027FFDE8
	str r0, [r4, #4]
	ldr r0, [r1]
	mov r0, r0, lsl #0xa
	mov r0, r0, lsr #0x1a
	bl RtcBCD2HEX
	str r0, [r4, #8]
	mov r0, r4
	bl RTC_GetDayOfWeek
	ldr r1, _020EF420 // =0x027FFDEC
	str r0, [r4, #0xc]
	ldr r0, [r1]
	ldr r1, _020EF418 // =rtcWork
	mov r0, r0, lsl #0x1a
	mov r0, r0, lsr #0x1a
	ldr r4, [r1, #0xc]
	bl RtcBCD2HEX
	ldr r1, _020EF420 // =0x027FFDEC
	str r0, [r4]
	ldr r0, [r1]
	mov r0, r0, lsl #0x11
	mov r0, r0, lsr #0x19
	bl RtcBCD2HEX
	ldr r1, _020EF420 // =0x027FFDEC
	str r0, [r4, #4]
	ldr r0, [r1]
	mov r0, r0, lsl #9
	mov r0, r0, lsr #0x19
	bl RtcBCD2HEX
	str r0, [r4, #8]
	b _020EF3B8
_020EF104:
	ldr r1, _020EF424 // =0x027FFDEA
	ldr r2, [r0, #8]
	ldrh r0, [r1]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1c
	cmp r0, #4
	bne _020EF12C
	mov r0, #1
	str r0, [r2]
	b _020EF3B8
_020EF12C:
	str r5, [r2]
	b _020EF3B8
_020EF134:
	ldr r1, _020EF424 // =0x027FFDEA
	ldr r2, [r0, #8]
	ldrh r0, [r1]
	mov r0, r0, lsl #0x19
	movs r0, r0, lsr #0x1f
	movne r0, #1
	strne r0, [r2]
	streq r5, [r2]
	b _020EF3B8
_020EF158:
	ldr r1, _020EF420 // =0x027FFDEC
	ldr r4, [r0, #8]
	ldr r0, [r1]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1d
	str r0, [r4]
	ldr r0, [r1]
	mov r0, r0, lsl #0x12
	mov r0, r0, lsr #0x1a
	bl RtcBCD2HEX
	ldr r1, _020EF420 // =0x027FFDEC
	str r0, [r4, #4]
	ldr r0, [r1]
	mov r0, r0, lsl #9
	mov r0, r0, lsr #0x19
	bl RtcBCD2HEX
	str r0, [r4, #8]
	mov r1, r5
	ldr r0, _020EF420 // =0x027FFDEC
	str r1, [r4, #0xc]
	ldr r0, [r0]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	ldrne r0, [r4, #0xc]
	addne r0, r0, #1
	strne r0, [r4, #0xc]
	ldr r0, _020EF420 // =0x027FFDEC
	ldr r0, [r0]
	mov r0, r0, lsl #0x10
	movs r0, r0, lsr #0x1f
	ldrne r0, [r4, #0xc]
	addne r0, r0, #2
	strne r0, [r4, #0xc]
	ldr r0, _020EF420 // =0x027FFDEC
	ldr r0, [r0]
	mov r0, r0, lsl #8
	movs r0, r0, lsr #0x1f
	ldrne r0, [r4, #0xc]
	addne r0, r0, #4
	strne r0, [r4, #0xc]
	b _020EF3B8
_020EF1FC:
	ldr r3, [r0, #0x18]
	cmp r3, #0
	bne _020EF2A8
	ldr r1, [r0, #8]
	ldr r1, [r1]
	cmp r1, #1
	bne _020EF264
	ldr r2, _020EF424 // =0x027FFDEA
	ldrh r1, [r2]
	mov r1, r1, lsl #0x1c
	mov r1, r1, lsr #0x1c
	cmp r1, #4
	beq _020EF3B8
	add r1, r3, #1
	str r1, [r0, #0x18]
	ldrh r0, [r2]
	bic r0, r0, #0xf
	orr r0, r0, #4
	strh r0, [r2]
	bl RTCi_WriteRawStatus2Async
	cmp r0, #0
	moveq r1, r5
	ldreq r0, _020EF418 // =rtcWork
	moveq r5, #3
	streq r1, [r0, #0x18]
	b _020EF3B8
_020EF264:
	ldr r2, _020EF424 // =0x027FFDEA
	ldrh r1, [r2]
	mov r1, r1, lsl #0x1c
	movs r1, r1, lsr #0x1c
	beq _020EF3B8
	add r1, r3, #1
	str r1, [r0, #0x18]
	ldrh r0, [r2]
	bic r0, r0, #0xf
	strh r0, [r2]
	bl RTCi_WriteRawStatus2Async
	cmp r0, #0
	moveq r1, r5
	ldreq r0, _020EF418 // =rtcWork
	moveq r5, #3
	streq r1, [r0, #0x18]
	b _020EF3B8
_020EF2A8:
	str r5, [r0, #0x18]
	b _020EF3B8
_020EF2B0:
	ldr r3, [r0, #0x18]
	cmp r3, #0
	bne _020EF354
	ldr r1, [r0, #8]
	ldr r1, [r1]
	cmp r1, #1
	bne _020EF310
	ldr r2, _020EF424 // =0x027FFDEA
	ldrh r1, [r2]
	mov r1, r1, lsl #0x19
	movs r1, r1, lsr #0x1f
	bne _020EF3B8
	add r1, r3, #1
	str r1, [r0, #0x18]
	ldrh r0, [r2]
	orr r0, r0, #0x40
	strh r0, [r2]
	bl RTCi_WriteRawStatus2Async
	cmp r0, #0
	moveq r1, r5
	ldreq r0, _020EF418 // =rtcWork
	moveq r5, #3
	streq r1, [r0, #0x18]
	b _020EF3B8
_020EF310:
	ldr r2, _020EF424 // =0x027FFDEA
	ldrh r1, [r2]
	mov r1, r1, lsl #0x19
	movs r1, r1, lsr #0x1f
	beq _020EF3B8
	add r1, r3, #1
	str r1, [r0, #0x18]
	ldrh r0, [r2]
	bic r0, r0, #0x40
	strh r0, [r2]
	bl RTCi_WriteRawStatus2Async
	cmp r0, #0
	moveq r1, r5
	ldreq r0, _020EF418 // =rtcWork
	moveq r5, #3
	streq r1, [r0, #0x18]
	b _020EF3B8
_020EF354:
	str r5, [r0, #0x18]
	b _020EF3B8
_020EF35C:
	ldr r0, _020EF418 // =rtcWork
	mov r1, #0
	str r1, [r0, #0x18]
	mov r5, #4
	b _020EF3B8
_020EF370:
	ldr r0, _020EF418 // =rtcWork
	mov r1, #0
	str r1, [r0, #0x18]
	cmp r2, #4
	addls pc, pc, r2, lsl #2
	b _020EF3B4
_020EF388: // jump table
	b _020EF3B4 // case 0
	b _020EF39C // case 1
	b _020EF3A4 // case 2
	b _020EF3AC // case 3
	b _020EF3B4 // case 4
_020EF39C:
	mov r5, #4
	b _020EF3B8
_020EF3A4:
	mov r5, #5
	b _020EF3B8
_020EF3AC:
	mov r5, #1
	b _020EF3B8
_020EF3B4:
	mov r5, #6
_020EF3B8:
	ldr r0, _020EF418 // =rtcWork
	ldr r1, [r0, #0x18]
	cmp r1, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	ldr r2, _020EF418 // =rtcWork
	ldr r1, [r0]
	ldr r4, [r2, #4]
	cmp r1, #0
	movne r1, #0
	strne r1, [r0]
	cmp r4, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldr r1, [r2, #0x10]
	mov r3, #0
	mov r0, r5
	str r3, [r2, #4]
	blx r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020EF418: .word rtcWork
_020EF41C: .word 0x027FFDE8
_020EF420: .word 0x027FFDEC
_020EF424: .word 0x027FFDEA
	arm_func_end RtcCommonCallback

	arm_func_start RTC_GetDateTime
RTC_GetDateTime: // 0x020EF428
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _020EF464 // =RtcGetResultCallback
	mov r3, #0
	bl RTC_GetDateTimeAsync
	ldr r1, _020EF468 // =rtcWork
	cmp r0, #0
	str r0, [r1, #0x20]
	bne _020EF450
	bl RtcWaitBusy
_020EF450:
	ldr r0, _020EF468 // =rtcWork
	ldr r0, [r0, #0x20]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EF464: .word RtcGetResultCallback
_020EF468: .word rtcWork
	arm_func_end RTC_GetDateTime

	arm_func_start RTC_GetDateTimeAsync
RTC_GetDateTimeAsync: // 0x020EF46C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl OS_DisableInterrupts
	ldr r1, _020EF4F8 // =rtcWork
	ldr r2, [r1]
	cmp r2, #0
	beq _020EF4AC
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020EF4AC:
	mov r2, #1
	str r2, [r1]
	bl OS_RestoreInterrupts
	ldr r0, _020EF4F8 // =rtcWork
	mov r2, #2
	mov r1, #0
	str r2, [r0, #0x14]
	str r1, [r0, #0x18]
	str r7, [r0, #8]
	str r6, [r0, #0xc]
	str r5, [r0, #4]
	str r4, [r0, #0x10]
	bl RTCi_ReadRawDateTimeAsync
	cmp r0, #0
	movne r0, #0
	moveq r0, #3
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020EF4F8: .word rtcWork
	arm_func_end RTC_GetDateTimeAsync

	arm_func_start RTC_GetTime
RTC_GetTime: // 0x020EF4FC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020EF538 // =RtcGetResultCallback
	mov r2, #0
	bl RTC_GetTimeAsync
	ldr r1, _020EF53C // =rtcWork
	cmp r0, #0
	str r0, [r1, #0x20]
	bne _020EF524
	bl RtcWaitBusy
_020EF524:
	ldr r0, _020EF53C // =rtcWork
	ldr r0, [r0, #0x20]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EF538: .word RtcGetResultCallback
_020EF53C: .word rtcWork
	arm_func_end RTC_GetTime

	arm_func_start RTC_GetTimeAsync
RTC_GetTimeAsync: // 0x020EF540
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl OS_DisableInterrupts
	ldr r1, _020EF5B8 // =rtcWork
	ldr r2, [r1]
	cmp r2, #0
	beq _020EF574
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020EF574:
	mov r2, #1
	str r2, [r1]
	bl OS_RestoreInterrupts
	ldr r0, _020EF5B8 // =rtcWork
	mov r2, #1
	mov r1, #0
	str r2, [r0, #0x14]
	str r1, [r0, #0x18]
	str r6, [r0, #8]
	str r5, [r0, #4]
	str r4, [r0, #0x10]
	bl RTCi_ReadRawTimeAsync
	cmp r0, #0
	movne r0, #0
	moveq r0, #3
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020EF5B8: .word rtcWork
	arm_func_end RTC_GetTimeAsync

	arm_func_start RTC_GetDate
RTC_GetDate: // 0x020EF5BC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020EF5F8 // =RtcGetResultCallback
	mov r2, #0
	bl RTC_GetDateAsync
	ldr r1, _020EF5FC // =rtcWork
	cmp r0, #0
	str r0, [r1, #0x20]
	bne _020EF5E4
	bl RtcWaitBusy
_020EF5E4:
	ldr r0, _020EF5FC // =rtcWork
	ldr r0, [r0, #0x20]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EF5F8: .word RtcGetResultCallback
_020EF5FC: .word rtcWork
	arm_func_end RTC_GetDate

	arm_func_start RTC_GetDateAsync
RTC_GetDateAsync: // 0x020EF600
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl OS_DisableInterrupts
	ldr r1, _020EF674 // =rtcWork
	ldr r2, [r1]
	cmp r2, #0
	beq _020EF634
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020EF634:
	mov r2, #1
	str r2, [r1]
	bl OS_RestoreInterrupts
	ldr r0, _020EF674 // =rtcWork
	mov r1, #0
	str r1, [r0, #0x14]
	str r1, [r0, #0x18]
	str r6, [r0, #8]
	str r5, [r0, #4]
	str r4, [r0, #0x10]
	bl RTCi_ReadRawDateAsync
	cmp r0, #0
	movne r0, #0
	moveq r0, #3
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020EF674: .word rtcWork
	arm_func_end RTC_GetDateAsync

	arm_func_start RTC_Init
RTC_Init: // 0x020EF678
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _020EF6F4 // =rtcInitialized
	ldrh r0, [r1]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	ldr r0, _020EF6F8 // =rtcWork
	mov r2, #0
	mov r3, #1
	strh r3, [r1]
	str r2, [r0]
	str r2, [r0, #4]
	str r2, [r0, #0x1c]
	str r2, [r0, #8]
	str r2, [r0, #0xc]
	bl PXI_Init
	mov r5, #5
	mov r4, #1
_020EF6C8:
	mov r0, r5
	mov r1, r4
	bl PXI_IsCallbackReady
	cmp r0, #0
	beq _020EF6C8
	ldr r1, _020EF6FC // =RtcCommonCallback
	mov r0, #5
	bl PXI_SetFifoRecvCallback
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020EF6F4: .word rtcInitialized
_020EF6F8: .word rtcWork
_020EF6FC: .word RtcCommonCallback
	arm_func_end RTC_Init

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

	arm_func_start RTC_GetDayOfWeek
RTC_GetDayOfWeek: // 0x020EF774
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, [r0, #4]
	ldr r2, [r0]
	sub r3, r1, #2
	cmp r3, #1
	add lr, r2, #0x7d0
	ldr r4, _020EF838 // =0x51EB851F
	sublt lr, lr, #1
	ldr ip, [r0, #8]
	smull r0, r2, r4, lr
	addlt r3, r3, #0xc
	mov r1, #0x1a
	mul r0, r3, r1
	smull r1, r3, r4, lr
	ldr r5, _020EF83C // =0x66666667
	sub r0, r0, #2
	smull r4, r1, r5, r0
	mov r4, lr, lsr #0x1f
	mov r2, r2, asr #5
	mov r3, r3, asr #5
	add r3, r4, r3
	ldr r5, _020EF840 // =0x00000064
	add r2, r4, r2
	smull r2, r4, r5, r2
	sub r2, lr, r2
	mov r1, r1, asr #2
	mov r0, r0, lsr #0x1f
	add r1, r0, r1
	mov r4, r2, asr #1
	add r0, ip, r1
	add r1, r2, r4, lsr #30
	add r2, r2, r0
	mov r6, r3, asr #1
	add r0, r3, r6, lsr #30
	add r1, r2, r1, asr #2
	add r1, r1, r0, asr #2
	mov r0, #5
	mla r4, r3, r0, r1
	ldr r3, _020EF844 // =0x92492493
	mov r1, r4, lsr #0x1f
	smull r2, r0, r3, r4
	add r0, r4, r0
	mov r0, r0, asr #2
	ldr r2, _020EF848 // =0x00000007
	add r0, r1, r0
	smull r0, r1, r2, r0
	sub r0, r4, r0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020EF838: .word 0x51EB851F
_020EF83C: .word 0x66666667
_020EF840: .word 0x00000064
_020EF844: .word 0x92492493
_020EF848: .word 0x00000007
	arm_func_end RTC_GetDayOfWeek

	arm_func_start RTC_ConvertSecondToDateTime
RTC_ConvertSecondToDateTime: // 0x020EF84C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r2
	mov ip, #0
	mov r4, r3
	subs r2, r5, ip
	sbcs r2, r4, ip
	mov r7, r0
	mov r6, r1
	movlt r5, ip
	movlt r4, ip
	blt _020EF890
	ldr r1, _020EF8DC // =0xBC19137F
	subs r0, r1, r5
	sbcs r0, ip, r4
	movlt r5, r1
	movlt r4, ip
_020EF890:
	ldr r2, _020EF8E0 // =0x00015180
	mov r0, r5
	mov r1, r4
	mov r3, #0
	bl _ll_mod
	mov r1, r0
	mov r0, r6
	bl RTCi_ConvertSecondToTime
	ldr r2, _020EF8E0 // =0x00015180
	mov r0, r5
	mov r1, r4
	mov r3, #0
	bl _ll_div
	mov r1, r0
	mov r0, r7
	bl RTC_ConvertDayToDate
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020EF8DC: .word 0xBC19137F
_020EF8E0: .word 0x00015180
	arm_func_end RTC_ConvertSecondToDateTime

	arm_func_start RTCi_ConvertSecondToTime
RTCi_ConvertSecondToTime: // 0x020EF8E4
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, _020EF974 // =0x0001517F
	cmp r1, #0
	movlt r1, #0
	cmp r1, r2
	ldr ip, _020EF978 // =0x88888889
	movgt r1, r2
	smull r2, r3, ip, r1
	smull r2, lr, ip, r1
	ldr r5, _020EF97C // =0x91A2B3C5
	add r3, r1, r3
	smull r4, r2, r5, r1
	mov r5, r1, lsr #0x1f
	mov r3, r3, asr #5
	add r3, r5, r3
	smull r4, r6, ip, r3
	add lr, r1, lr
	mov lr, lr, asr #5
	add r6, r3, r6
	add r2, r1, r2
	ldr r4, _020EF980 // =0x0000003C
	add lr, r5, lr
	smull ip, lr, r4, lr
	sub lr, r1, ip
	mov r2, r2, asr #0xb
	mov r6, r6, asr #5
	mov r1, r3, lsr #0x1f
	add r6, r1, r6
	smull r1, ip, r4, r6
	str lr, [r0, #8]
	sub r6, r3, r1
	str r6, [r0, #4]
	add r2, r5, r2
	str r2, [r0]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020EF974: .word 0x0001517F
_020EF978: .word 0x88888889
_020EF97C: .word 0x91A2B3C5
_020EF980: .word 0x0000003C
	arm_func_end RTCi_ConvertSecondToTime

	arm_func_start RTC_ConvertDayToDate
RTC_ConvertDayToDate: // 0x020EF984
	stmdb sp!, {r4, lr}
	ldr r2, _020EFA8C // =0x00008EAC
	cmp r1, #0
	movlt r1, #0
	cmp r1, r2
	movgt r1, r2
	ldr r3, _020EFA90 // =0x92492493
	add lr, r1, #6
	smull r2, r4, r3, lr
	add r4, lr, r4
	mov r4, r4, asr #2
	mov r2, lr, lsr #0x1f
	ldr ip, _020EFA94 // =0x00000007
	add r4, r2, r4
	smull r2, r3, ip, r4
	sub r4, lr, r2
	ldr r2, _020EFA98 // =0x0000016D
	ldr r3, _020EFA9C // =0x0000016E
	str r4, [r0, #0xc]
	mov lr, #0
_020EF9D4:
	ands ip, lr, #3
	moveq ip, r3
	movne ip, r2
	mov r4, r1
	subs r1, r1, ip
	movmi r1, r4
	bmi _020EF9FC
	add lr, lr, #1
	cmp lr, #0x63
	blo _020EF9D4
_020EF9FC:
	ldr r2, _020EFA98 // =0x0000016D
	str lr, [r0]
	cmp r1, r2
	movgt r1, r2
	ands r2, lr, #3
	bne _020EFA44
	cmp r1, #0x3c
	bge _020EFA40
	cmp r1, #0x1f
	movlt r2, #1
	subge r1, r1, #0x1f
	movge r2, #2
	str r2, [r0, #4]
	add r1, r1, #1
	str r1, [r0, #8]
	ldmia sp!, {r4, lr}
	bx lr
_020EFA40:
	sub r1, r1, #1
_020EFA44:
	ldr r3, _020EFAA0 // _0211F984
	mov r4, #0xb
_020EFA4C:
	ldr r2, [r3, r4, lsl #2]
	mov ip, r4, lsl #2
	cmp r1, r2
	blt _020EFA7C
	add r2, r4, #1
	str r2, [r0, #4]
	ldr r2, [r3, ip]
	sub r1, r1, r2
	add r1, r1, #1
	str r1, [r0, #8]
	ldmia sp!, {r4, lr}
	bx lr
_020EFA7C:
	subs r4, r4, #1
	bpl _020EFA4C
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020EFA8C: .word 0x00008EAC
_020EFA90: .word 0x92492493
_020EFA94: .word 0x00000007
_020EFA98: .word 0x0000016D
_020EFA9C: .word 0x0000016E
_020EFAA0: .word _0211F984
	arm_func_end RTC_ConvertDayToDate

	arm_func_start RTC_ConvertDateTimeToSecond
RTC_ConvertDateTimeToSecond: // 0x020EFAA4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r1
	bl RTC_ConvertDateToDay
	mov r4, r0
	mvn r0, #0
	cmp r4, r0
	addeq sp, sp, #4
	moveq r1, r0
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	mov r0, r5
	bl RTCi_ConvertTimeToSecond
	mvn r2, #0
	cmp r0, r2
	moveq r1, r2
	beq _020EFB08
	ldr r1, _020EFB18 // =0x00015180
	mov r2, #0
	umull ip, r3, r4, r1
	mla r3, r4, r2, r3
	mov r2, r4, asr #0x1f
	mla r3, r2, r1, r3
	adds r2, r0, ip
	adc r1, r3, r0, asr #31
_020EFB08:
	mov r0, r2
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020EFB18: .word 0x00015180
	arm_func_end RTC_ConvertDateTimeToSecond

	arm_func_start RTCi_ConvertTimeToSecond
RTCi_ConvertTimeToSecond: // 0x020EFB1C
	ldr r3, [r0, #4]
	ldr r2, [r0]
	mov r1, #0x3c
	mla r3, r2, r1, r3
	ldr r0, [r0, #8]
	mla r0, r3, r1, r0
	bx lr
	arm_func_end RTCi_ConvertTimeToSecond

	arm_func_start RTC_ConvertDateToDay
RTC_ConvertDateToDay: // 0x020EFB38
	ldr r3, [r0]
	cmp r3, #0x64
	bhs _020EFB88
	ldr r2, [r0, #4]
	cmp r2, #1
	blo _020EFB88
	cmp r2, #0xc
	bhi _020EFB88
	ldr r1, [r0, #8]
	cmp r1, #1
	blo _020EFB88
	cmp r1, #0x1f
	bhi _020EFB88
	ldr r0, [r0, #0xc]
	cmp r0, #7
	bge _020EFB88
	cmp r2, #1
	blo _020EFB88
	cmp r2, #0xc
	bls _020EFB90
_020EFB88:
	mvn r0, #0
	bx lr
_020EFB90:
	ldr r0, _020EFBC4 // _0211F984 - 4 // TODO: make sure this matches later
	sub r1, r1, #1
	ldr r0, [r0, r2, lsl #2]
	cmp r2, #3
	add r2, r1, r0
	blo _020EFBB0
	ands r0, r3, #3
	addeq r2, r2, #1
_020EFBB0:
	ldr r0, _020EFBC8 // =0x0000016D
	add r1, r3, #3
	mla r0, r3, r0, r2
	add r0, r0, r1, lsr #2
	bx lr
	.align 2, 0
_020EFBC4: .word _0211F984 - 4 // TODO: make sure this matches later
_020EFBC8: .word 0x0000016D
	arm_func_end RTC_ConvertDateToDay

	.data

_0211F984: // 0x0211F984
    .word 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
