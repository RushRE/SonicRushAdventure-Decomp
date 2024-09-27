	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public rtcInitialized
rtcInitialized: // 0x02150054
    .space 2
	.align 4

.public rtcWork
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
