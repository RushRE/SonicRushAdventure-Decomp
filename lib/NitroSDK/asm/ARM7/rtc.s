	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start RtcBCD2HEX
RtcBCD2HEX: // 0x027F694C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov lr, #0
	mov r2, lr
	b _027F697C
_027F6960:
	mov r1, r2, lsl #2
	mov r1, r0, lsr r1
	and r1, r1, #0xf
	cmp r1, #0xa
	movhs r0, #0
	bhs _027F69B8
	add r2, r2, #1
_027F697C:
	cmp r2, #8
	blt _027F6960
	mov r3, #0
	mov ip, #1
	mov r2, #0xa
_027F6990:
	mov r1, r3, lsl #2
	mov r1, r0, lsr r1
	and r1, r1, #0xf
	mla lr, ip, r1, lr
	add r3, r3, #1
	mul r1, ip, r2
	mov ip, r1
	cmp r3, #8
	blt _027F6990
	mov r0, lr
_027F69B8:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end RtcBCD2HEX

	arm_func_start RtcGetDayOfWeek
RtcGetDayOfWeek: // 0x027F69C4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	mov r6, r2
	sub r0, r7, #1
	cmp r0, #1
	subls r8, r8, #1
	addls r7, r7, #0xc
	mov r0, r8
	mov r1, #0x190
	bl _u32_div_f
	mov r5, r0
	mov r0, r8
	mov r1, #0x64
	bl _u32_div_f
	mov r4, r0
	mov r0, #0xd
	mul r0, r7, r0
	add r0, r0, #8
	mov r1, #5
	bl _u32_div_f
	add r1, r8, r8, lsr #2
	sub r1, r1, r4
	add r1, r5, r1
	add r0, r1, r0
	add r0, r6, r0
	mov r1, #7
	bl _u32_div_f
	mov r0, r1
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end RtcGetDayOfWeek

	arm_func_start RtcInitialize
RtcInitialize: // 0x027F6A40
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	add r0, sp, #0
	bl RTC_ReadStatus1
	add r0, sp, #2
	bl RTC_ReadStatus2
	ldrh r0, [sp]
	mov r1, r0, lsl #0x18
	movs r1, r1, lsr #0x1f
	bne _027F6A84
	mov r0, r0, lsl #0x19
	movs r0, r0, lsr #0x1f
	bne _027F6A84
	ldrh r0, [sp, #2]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	beq _027F6A9C
_027F6A84:
	ldrh r0, [sp]
	bic r0, r0, #1
	orr r0, r0, #1
	strh r0, [sp]
	add r0, sp, #0
	bl RTC_WriteStatus1
_027F6A9C:
	ldrh r0, [sp]
	mov r1, r0, lsl #0x1b
	movs r1, r1, lsr #0x1f
	bne _027F6AB8
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	beq _027F6AD8
_027F6AB8:
	ldrh r0, [sp, #2]
	bic r0, r0, #0xf
	strh r0, [sp, #2]
	ldrh r0, [sp, #2]
	bic r0, r0, #0x40
	strh r0, [sp, #2]
	add r0, sp, #2
	bl RTC_WriteStatus2
_027F6AD8:
	ldr r0, _027F6B70 // =0x027FFDE8
	bl RTC_ReadDateTime
	ldr r0, _027F6B70 // =0x027FFDE8
	ldrb r0, [r0]
	bl RtcBCD2HEX
	mov r4, r0
	ldr r0, _027F6B70 // =0x027FFDE8
	ldr r0, [r0]
	mov r0, r0, lsl #0x13
	mov r0, r0, lsr #0x1b
	bl RtcBCD2HEX
	mov r5, r0
	ldr r0, _027F6B70 // =0x027FFDE8
	ldr r0, [r0]
	mov r0, r0, lsl #0xa
	mov r0, r0, lsr #0x1a
	bl RtcBCD2HEX
	mov r2, r0
	add r0, r4, #0x7d0
	mov r1, r5
	bl RtcGetDayOfWeek
	ldr r2, _027F6B70 // =0x027FFDE8
	ldr r1, [r2]
	mov r3, r1, lsl #5
	mov r3, r3, lsr #0x1d
	cmp r3, r0
	beq _027F6B5C
	bic r1, r1, #0x7000000
	and r0, r0, #7
	orr r0, r1, r0, lsl #24
	str r0, [r2]
	mov r0, r2
	bl RTC_WriteDateTime
_027F6B5C:
	mov r0, #1
	bl RTC_SetHourFormat
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027F6B70: .word 0x027FFDE8
	arm_func_end RtcInitialize

	arm_func_start RtcAlarmIntr
RtcAlarmIntr: // 0x027F6B74
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	add r0, sp, #0
	bl RTC_ReadStatus1
	ldrh r0, [sp]
	mov r1, r0, lsl #0x1b
	movs r1, r1, lsr #0x1f
	bne _027F6BA0
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	beq _027F6BF8
_027F6BA0:
	add r0, sp, #2
	bl RTC_ReadStatus2
	mov r4, #0
	ldrh r0, [sp]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	orrne r4, r4, #1
	ldrneh r0, [sp, #2]
	bicne r0, r0, #0xf
	strneh r0, [sp, #2]
	ldrh r0, [sp]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	orrne r4, r4, #2
	ldrneh r0, [sp, #2]
	bicne r0, r0, #0x40
	strneh r0, [sp, #2]
	add r0, sp, #2
	bl RTC_WriteStatus2
	mov r0, #0x30
	mov r1, r4
	bl RtcReturnResult
_027F6BF8:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RtcAlarmIntr

	arm_func_start RtcThread
RtcThread: // 0x027F6C04
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x4c
	ldr r6, _027F70B4 // =0x027FFDE8
	add r5, r6, #4
	mov r7, #0
	ldr sb, _027F70B8 // =0x027F9A08
	mov r8, #1
	mov r0, #0x10
	str r0, [sp]
	mov r0, #0x11
	str r0, [sp, #4]
	mov r0, #0x12
	str r0, [sp, #8]
	mov sl, #0x13
	mov r4, #2
	mov fp, #0x14
	mov r0, #0x15
	str r0, [sp, #0xc]
	mov r0, #0x16
	str r0, [sp, #0x10]
	mov r0, #0x17
	str r0, [sp, #0x14]
	mov r0, #0x18
	str r0, [sp, #0x18]
	mov r0, #0x19
	str r0, [sp, #0x1c]
	mov r0, #0x20
	str r0, [sp, #0x20]
	mov r0, #0x21
	str r0, [sp, #0x24]
	mov r0, #0x22
	str r0, [sp, #0x28]
	mov r0, #0x23
	str r0, [sp, #0x2c]
	mov r0, #0x24
	str r0, [sp, #0x30]
	mov r0, #0x25
	str r0, [sp, #0x34]
	mov r0, #0x26
	str r0, [sp, #0x38]
	mov r0, #0x27
	str r0, [sp, #0x3c]
	mov r0, #0x28
	str r0, [sp, #0x40]
	mov r0, #0x29
	str r0, [sp, #0x44]
_027F6CBC:
	mov r0, sb
	add r1, sp, #0x48
	mov r2, r8
	bl OS_ReceiveMessage
	ldr r0, _027F70BC // =0x027F9B08
	ldrh r0, [r0, #0xd8]
	cmp r0, #0x29
	addls pc, pc, r0, lsl #2
	b _027F70A4
_027F6CE0: // jump table
	b _027F6D88 // case 0
	b _027F6DA0 // case 1
	b _027F70A4 // case 2
	b _027F70A4 // case 3
	b _027F70A4 // case 4
	b _027F70A4 // case 5
	b _027F70A4 // case 6
	b _027F70A4 // case 7
	b _027F70A4 // case 8
	b _027F70A4 // case 9
	b _027F70A4 // case 10
	b _027F70A4 // case 11
	b _027F70A4 // case 12
	b _027F70A4 // case 13
	b _027F70A4 // case 14
	b _027F70A4 // case 15
	b _027F6DC4 // case 16
	b _027F6DE0 // case 17
	b _027F6DFC // case 18
	b _027F6E18 // case 19
	b _027F6E50 // case 20
	b _027F6E88 // case 21
	b _027F6EC0 // case 22
	b _027F6EDC // case 23
	b _027F6EF8 // case 24
	b _027F6F14 // case 25
	b _027F70A4 // case 26
	b _027F70A4 // case 27
	b _027F70A4 // case 28
	b _027F70A4 // case 29
	b _027F70A4 // case 30
	b _027F70A4 // case 31
	b _027F6F30 // case 32
	b _027F6F4C // case 33
	b _027F6F70 // case 34
	b _027F6F8C // case 35
	b _027F6FC4 // case 36
	b _027F6FFC // case 37
	b _027F7034 // case 38
	b _027F7050 // case 39
	b _027F706C // case 40
	b _027F7088 // case 41
_027F6D88:
	bl RTC_Reset
	str r7, [sb, #0x1d4]
	mov r0, r7
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6DA0:
	ldrh r0, [r6]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1f
	bl RTC_SetHourFormat
	str r7, [sb, #0x1d4]
	mov r0, r8
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6DC4:
	mov r0, r6
	bl RTC_ReadDateTime
	str r7, [sb, #0x1d4]
	ldr r0, [sp]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6DE0:
	mov r0, r6
	bl RTC_ReadDate
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #4]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6DFC:
	add r0, r6, #4
	bl RTC_ReadTime
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #8]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6E18:
	mov r0, r5
	bl RTC_ReadPulse
	cmp r0, #0
	bne _027F6E3C
	str r7, [sb, #0x1d4]
	mov r0, sl
	mov r1, r4
	bl RtcReturnResult
	b _027F6CBC
_027F6E3C:
	str r7, [sb, #0x1d4]
	mov r0, sl
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6E50:
	mov r0, r5
	bl RTC_ReadAlarm1
	cmp r0, #0
	bne _027F6E74
	str r7, [sb, #0x1d4]
	mov r0, fp
	mov r1, r4
	bl RtcReturnResult
	b _027F6CBC
_027F6E74:
	str r7, [sb, #0x1d4]
	mov r0, fp
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6E88:
	mov r0, r5
	bl RTC_ReadAlarm2
	cmp r0, #0
	bne _027F6EAC
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0xc]
	mov r1, r4
	bl RtcReturnResult
	b _027F6CBC
_027F6EAC:
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0xc]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6EC0:
	mov r0, r6
	bl RTC_ReadStatus1
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x10]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6EDC:
	add r0, r6, #2
	bl RTC_ReadStatus2
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x14]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6EF8:
	add r0, r6, #4
	bl RTC_ReadAdjust
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x18]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6F14:
	add r0, r6, #4
	bl RTC_ReadFree
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x1c]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6F30:
	mov r0, r6
	bl RTC_WriteDateTime
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x20]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6F4C:
	add r0, r6, #4
	bl RTC_ReadTime
	mov r0, r6
	bl RTC_WriteDateTime
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x24]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6F70:
	add r0, r6, #4
	bl RTC_WriteTime
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x28]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6F8C:
	mov r0, r5
	bl RTC_WritePulse
	cmp r0, #0
	bne _027F6FB0
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x2c]
	mov r1, r4
	bl RtcReturnResult
	b _027F6CBC
_027F6FB0:
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x2c]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6FC4:
	mov r0, r5
	bl RTC_WriteAlarm1
	cmp r0, #0
	bne _027F6FE8
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x30]
	mov r1, r4
	bl RtcReturnResult
	b _027F6CBC
_027F6FE8:
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x30]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F6FFC:
	mov r0, r5
	bl RTC_WriteAlarm2
	cmp r0, #0
	bne _027F7020
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x34]
	mov r1, r4
	bl RtcReturnResult
	b _027F6CBC
_027F7020:
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x34]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F7034:
	mov r0, r6
	bl RTC_WriteStatus1
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x38]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F7050:
	add r0, r6, #2
	bl RTC_WriteStatus2
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x3c]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F706C:
	add r0, r6, #4
	bl RTC_WriteAdjust
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x40]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F7088:
	add r0, r6, #4
	bl RTC_WriteFree
	str r7, [sb, #0x1d4]
	ldr r0, [sp, #0x44]
	mov r1, r7
	bl RtcReturnResult
	b _027F6CBC
_027F70A4:
	str r7, [sb, #0x1d4]
	mov r1, r8
	bl RtcReturnResult
	b _027F6CBC
	.align 2, 0
_027F70B4: .word 0x027FFDE8
_027F70B8: .word 0x027F9A08
_027F70BC: .word 0x027F9B08
	arm_func_end RtcThread

	arm_func_start RtcReturnResult
RtcReturnResult: // 0x027F70C0
	stmdb sp!, {r4, r5, r6, lr}
	mov r0, r0, lsl #8
	and r0, r0, #0x7f00
	orr r2, r0, #0x8000
	and r0, r1, #0xff
	orr r6, r2, r0
	mov r5, #5
	mov r4, #0
_027F70E0:
	mov r0, r5
	mov r1, r6
	mov r2, r4
	bl PXI_SendWordByFifo
	cmp r0, #0
	blt _027F70E0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end RtcReturnResult

	arm_func_start RtcCommonCallback
RtcCommonCallback: // 0x027F7100
	stmdb sp!, {r4, lr}
	cmp r2, #0
	bne _027F722C
	and r0, r1, #0x7f00
	mov r0, r0, lsl #8
	mov r4, r0, lsr #0x10
	cmp r4, #0x29
	addls pc, pc, r4, lsl #2
	b _027F7220
_027F7124: // jump table
	b _027F71CC // case 0
	b _027F71CC // case 1
	b _027F7220 // case 2
	b _027F7220 // case 3
	b _027F7220 // case 4
	b _027F7220 // case 5
	b _027F7220 // case 6
	b _027F7220 // case 7
	b _027F7220 // case 8
	b _027F7220 // case 9
	b _027F7220 // case 10
	b _027F7220 // case 11
	b _027F7220 // case 12
	b _027F7220 // case 13
	b _027F7220 // case 14
	b _027F7220 // case 15
	b _027F71CC // case 16
	b _027F71CC // case 17
	b _027F71CC // case 18
	b _027F71CC // case 19
	b _027F71CC // case 20
	b _027F71CC // case 21
	b _027F71CC // case 22
	b _027F71CC // case 23
	b _027F71CC // case 24
	b _027F71CC // case 25
	b _027F7220 // case 26
	b _027F7220 // case 27
	b _027F7220 // case 28
	b _027F7220 // case 29
	b _027F7220 // case 30
	b _027F7220 // case 31
	b _027F7220 // case 32
	b _027F7220 // case 33
	b _027F7220 // case 34
	b _027F71CC // case 35
	b _027F71CC // case 36
	b _027F71CC // case 37
	b _027F71CC // case 38
	b _027F71CC // case 39
	b _027F71CC // case 40
	b _027F71CC // case 41
_027F71CC:
	ldr r0, _027F7234 // =0x027F9A08
	ldr r1, [r0, #0x1d4]
	cmp r1, #0
	beq _027F71EC
	mov r0, r4
	mov r1, #3
	bl RtcReturnResult
	b _027F722C
_027F71EC:
	mov r1, #1
	str r1, [r0, #0x1d4]
	ldr r1, _027F7238 // =0x027F9B08
	strh r4, [r1, #0xd8]
	mov r1, #0
	mov r2, r1
	bl OS_SendMessage
	cmp r0, #0
	bne _027F722C
	mov r0, r4
	mov r1, #4
	bl RtcReturnResult
	b _027F722C
_027F7220:
	mov r0, r4
	mov r1, #1
	bl RtcReturnResult
_027F722C:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027F7234: .word 0x027F9A08
_027F7238: .word 0x027F9B08
	arm_func_end RtcCommonCallback

	arm_func_start RTC_Init
RTC_Init: // 0x027F723C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, _027F7310 // =0x027F9A04
	ldrh r1, [r0]
	cmp r1, #0
	bne _027F7304
	mov r1, #1
	strh r1, [r0]
	ldr r0, _027F7314 // =0x027F9A08
	str r1, [r0, #0x1d4]
	bl RtcInitialize
	mov r1, #0
	ldr r0, _027F7314 // =0x027F9A08
	str r1, [r0, #0x1d4]
	bl PXI_Init
	mov r0, #5
	ldr r1, _027F7318 // =RtcCommonCallback
	bl PXI_SetFifoRecvCallback
	ldr r0, _027F7314 // =0x027F9A08
	ldr r1, _027F731C // =0x027F9A28
	mov r2, #4
	bl OS_InitMessageQueue
	mov r0, #0x100
	str r0, [sp]
	str r4, [sp, #4]
	ldr r0, _027F7320 // =0x027F9A38
	ldr r1, _027F7324 // =RtcThread
	mov r2, #0
	ldr r3, _027F7328 // =0x027F9BDC
	bl OS_CreateThread
	ldr r0, _027F7320 // =0x027F9A38
	bl OS_WakeupThreadDirect
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	mov r0, #0x40
	mov r1, #0
	bl EXIi_SetBitRcnt0L
	mov r0, #0x100
	mov r1, r0
	bl EXIi_SetBitRcnt0L
	bl OS_DisableInterrupts
	mov r4, r0
	mov r0, #0x80
	ldr r1, _027F732C // =RtcAlarmIntr
	bl OS_SetIrqFunction
	mov r0, #0x80
	bl OS_EnableIrqMask
	mov r0, r4
	bl OS_RestoreInterrupts
_027F7304:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027F7310: .word 0x027F9A04
_027F7314: .word 0x027F9A08
_027F7318: .word RtcCommonCallback
_027F731C: .word 0x027F9A28
_027F7320: .word 0x027F9A38
_027F7324: .word RtcThread
_027F7328: .word 0x027F9BDC
_027F732C: .word RtcAlarmIntr
	arm_func_end RTC_Init

	arm_func_start RTC_Func_27F7330
RTC_Func_27F7330: // 0x027F7330
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl RTCi_GpioStart
	mov r0, r7
	mov r1, r6
	bl RTCi_GpioSendCommand
	cmp r7, #6
	beq _027F7378
	cmp r7, #0x86
	bne _027F7384
	mov r0, r5
	mov r1, r4
	bl RTCi_GpioReceiveData
	b _027F7384
_027F7378:
	mov r0, r5
	mov r1, r4
	bl RTCi_GpioSendData
_027F7384:
	bl RTCi_GpioEnd
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end RTC_Func_27F7330

	arm_func_start RTC_Func_27F7394
RTC_Func_27F7394: // 0x027F7394
	ldr r2, [r0]
	mov r1, r2, lsl #0x12
	mov r3, r1, lsr #0x1a
	cmp r3, #0x23
	addls pc, pc, r3, lsl #2
	b _027F7490
_027F73AC: // jump table
	b _027F743C // case 0
	b _027F743C // case 1
	b _027F743C // case 2
	b _027F743C // case 3
	b _027F743C // case 4
	b _027F743C // case 5
	b _027F743C // case 6
	b _027F743C // case 7
	b _027F7460 // case 8
	b _027F7460 // case 9
	b _027F7490 // case 10
	b _027F7490 // case 11
	b _027F7490 // case 12
	b _027F7490 // case 13
	b _027F7490 // case 14
	b _027F7490 // case 15
	b _027F743C // case 16
	b _027F743C // case 17
	b _027F7484 // case 18
	b _027F7484 // case 19
	b _027F7484 // case 20
	b _027F7484 // case 21
	b _027F7484 // case 22
	b _027F7484 // case 23
	b _027F7484 // case 24
	b _027F7484 // case 25
	b _027F7490 // case 26
	b _027F7490 // case 27
	b _027F7490 // case 28
	b _027F7490 // case 29
	b _027F7490 // case 30
	b _027F7490 // case 31
	b _027F7484 // case 32
	b _027F7484 // case 33
	b _027F7484 // case 34
	b _027F7484 // case 35
_027F743C:
	mov r1, r2, lsl #0x11
	movs r1, r1, lsr #0x1f
	bxeq lr
	bic r2, r2, #0x3f00
	add r1, r3, #0x12
	and r1, r1, #0x3f
	orr r1, r2, r1, lsl #8
	str r1, [r0]
	bx lr
_027F7460:
	mov r1, r2, lsl #0x11
	movs r1, r1, lsr #0x1f
	bxeq lr
	bic r2, r2, #0x3f00
	add r1, r3, #0x18
	and r1, r1, #0x3f
	orr r1, r2, r1, lsl #8
	str r1, [r0]
	bx lr
_027F7484:
	orr r1, r2, #0x4000
	str r1, [r0]
	bx lr
_027F7490:
	ldr r1, [r0]
	bic r1, r1, #0x4000
	str r1, [r0]
	ldr r1, [r0]
	bic r1, r1, #0x3f00
	str r1, [r0]
	bx lr
	arm_func_end RTC_Func_27F7394

	arm_func_start RTC_Func_27F74AC
RTC_Func_27F74AC: // 0x027F74AC
	ldr r1, [r0]
	mov r2, r1, lsl #0x12
	mov r2, r2, lsr #0x1a
	cmp r2, #0x23
	addls pc, pc, r2, lsl #2
	b _027F75B8
_027F74C4: // jump table
	b _027F7554 // case 0
	b _027F7554 // case 1
	b _027F7554 // case 2
	b _027F7554 // case 3
	b _027F7554 // case 4
	b _027F7554 // case 5
	b _027F7554 // case 6
	b _027F7554 // case 7
	b _027F7554 // case 8
	b _027F7554 // case 9
	b _027F75B8 // case 10
	b _027F75B8 // case 11
	b _027F75B8 // case 12
	b _027F75B8 // case 13
	b _027F75B8 // case 14
	b _027F75B8 // case 15
	b _027F7554 // case 16
	b _027F7554 // case 17
	b _027F7560 // case 18
	b _027F7560 // case 19
	b _027F7560 // case 20
	b _027F7560 // case 21
	b _027F7560 // case 22
	b _027F7560 // case 23
	b _027F7560 // case 24
	b _027F7560 // case 25
	b _027F75B8 // case 26
	b _027F75B8 // case 27
	b _027F75B8 // case 28
	b _027F75B8 // case 29
	b _027F75B8 // case 30
	b _027F75B8 // case 31
	b _027F758C // case 32
	b _027F758C // case 33
	b _027F7560 // case 34
	b _027F7560 // case 35
_027F7554:
	bic r1, r1, #0x4000
	str r1, [r0]
	bx lr
_027F7560:
	orr r1, r1, #0x4000
	str r1, [r0]
	ldr r1, [r0]
	bic r2, r1, #0x3f00
	mov r1, r1, lsl #0x12
	mov r1, r1, lsr #0x1a
	sub r1, r1, #0x12
	and r1, r1, #0x3f
	orr r1, r2, r1, lsl #8
	str r1, [r0]
	bx lr
_027F758C:
	orr r1, r1, #0x4000
	str r1, [r0]
	ldr r1, [r0]
	bic r2, r1, #0x3f00
	mov r1, r1, lsl #0x12
	mov r1, r1, lsr #0x1a
	sub r1, r1, #0x18
	and r1, r1, #0x3f
	orr r1, r2, r1, lsl #8
	str r1, [r0]
	bx lr
_027F75B8:
	ldr r1, [r0]
	bic r1, r1, #0x4000
	str r1, [r0]
	ldr r1, [r0]
	bic r1, r1, #0x3f00
	str r1, [r0]
	bx lr
	arm_func_end RTC_Func_27F74AC

	arm_func_start RTC_WriteFree
RTC_WriteFree: // 0x027F75D4
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	mov r0, #6
	mov r1, #0x70
	mov r2, r4
	mov r3, #1
	bl RTC_Func_27F7330
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_WriteFree

	arm_func_start RTC_ReadFree
RTC_ReadFree: // 0x027F7600
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	mov r0, #0x86
	mov r1, #0x70
	mov r2, r4
	mov r3, #1
	bl RTC_Func_27F7330
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_ReadFree

	arm_func_start RTC_WriteAdjust
RTC_WriteAdjust: // 0x027F762C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	mov r0, #6
	mov r1, #0x30
	mov r2, r4
	mov r3, #1
	bl RTC_Func_27F7330
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_WriteAdjust

	arm_func_start RTC_ReadAdjust
RTC_ReadAdjust: // 0x027F7658
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	mov r0, #0x86
	mov r1, #0x30
	mov r2, r4
	mov r3, #1
	bl RTC_Func_27F7330
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_ReadAdjust

	arm_func_start RTC_WriteStatus2
RTC_WriteStatus2: // 0x027F7684
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	mov r0, #6
	mov r1, #0x40
	mov r2, r4
	mov r3, #1
	bl RTC_Func_27F7330
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_WriteStatus2

	arm_func_start RTC_ReadStatus2
RTC_ReadStatus2: // 0x027F76B0
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	mov r0, #0x86
	mov r1, #0x40
	mov r2, r4
	mov r3, #1
	bl RTC_Func_27F7330
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_ReadStatus2

	arm_func_start RTC_WriteStatus1
RTC_WriteStatus1: // 0x027F76DC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	mov r0, #6
	mov r1, #0
	mov r2, r4
	mov r3, #1
	bl RTC_Func_27F7330
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_WriteStatus1

	arm_func_start RTC_ReadStatus1
RTC_ReadStatus1: // 0x027F7708
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	mov r0, #0x86
	mov r1, #0
	mov r2, r4
	mov r3, #1
	bl RTC_Func_27F7330
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_ReadStatus1

	arm_func_start RTC_WriteAlarm2
RTC_WriteAlarm2: // 0x027F7734
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, sp, #0
	bl RTC_ReadStatus2
	ldrh r0, [sp]
	mov r0, r0, lsl #0x19
	movs r0, r0, lsr #0x1f
	moveq r0, #0
	beq _027F7774
	mov r0, #6
	mov r1, #0x50
	mov r2, r4
	mov r3, #3
	bl RTC_Func_27F7330
	mov r0, #1
_027F7774:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_WriteAlarm2

	arm_func_start RTC_ReadAlarm2
RTC_ReadAlarm2: // 0x027F7780
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, sp, #0
	bl RTC_ReadStatus2
	ldrh r0, [sp]
	mov r0, r0, lsl #0x19
	movs r0, r0, lsr #0x1f
	moveq r0, #0
	beq _027F77C0
	mov r0, #0x86
	mov r1, #0x50
	mov r2, r4
	mov r3, #3
	bl RTC_Func_27F7330
	mov r0, #1
_027F77C0:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_ReadAlarm2

	arm_func_start RTC_WriteAlarm1
RTC_WriteAlarm1: // 0x027F77CC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, sp, #0
	bl RTC_ReadStatus2
	ldrh r0, [sp]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1c
	cmp r0, #4
	movne r0, #0
	bne _027F7810
	mov r0, #6
	mov r1, #0x10
	mov r2, r4
	mov r3, #3
	bl RTC_Func_27F7330
	mov r0, #1
_027F7810:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_WriteAlarm1

	arm_func_start RTC_ReadAlarm1
RTC_ReadAlarm1: // 0x027F781C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, sp, #0
	bl RTC_ReadStatus2
	ldrh r0, [sp]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1c
	cmp r0, #4
	movne r0, #0
	bne _027F7860
	mov r0, #0x86
	mov r1, #0x10
	mov r2, r4
	mov r3, #3
	bl RTC_Func_27F7330
	mov r0, #1
_027F7860:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_ReadAlarm1

	arm_func_start RTC_WritePulse
RTC_WritePulse: // 0x027F786C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, sp, #0
	bl RTC_ReadStatus2
	ldrh r0, [sp]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1c
	and r0, r0, #0xb
	cmp r0, #1
	movne r0, #0
	bne _027F78B4
	mov r0, #6
	mov r1, #0x10
	mov r2, r4
	mov r3, #1
	bl RTC_Func_27F7330
	mov r0, #1
_027F78B4:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_WritePulse

	arm_func_start RTC_ReadPulse
RTC_ReadPulse: // 0x027F78C0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, sp, #0
	bl RTC_ReadStatus2
	ldrh r0, [sp]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1c
	and r0, r0, #0xb
	cmp r0, #1
	movne r0, #0
	bne _027F7908
	mov r0, #0x86
	mov r1, #0x10
	mov r2, r4
	mov r3, #1
	bl RTC_Func_27F7330
	mov r0, #1
_027F7908:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_ReadPulse

	arm_func_start RTC_WriteTime
RTC_WriteTime: // 0x027F7914
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	mov r0, #6
	mov r1, #0x60
	mov r2, r4
	mov r3, #3
	bl RTC_Func_27F7330
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_WriteTime

	arm_func_start RTC_ReadTime
RTC_ReadTime: // 0x027F7940
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	mov r0, #0x86
	mov r1, #0x60
	mov r2, r4
	mov r3, #3
	bl RTC_Func_27F7330
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_ReadTime

	arm_func_start RTC_ReadDate
RTC_ReadDate: // 0x027F796C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	mov r0, #0x86
	mov r1, #0x20
	mov r2, r4
	mov r3, #4
	bl RTC_Func_27F7330
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_ReadDate

	arm_func_start RTC_WriteDateTime
RTC_WriteDateTime: // 0x027F7998
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	mov r0, #6
	mov r1, #0x20
	mov r2, r4
	mov r3, #7
	bl RTC_Func_27F7330
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_WriteDateTime

	arm_func_start RTC_ReadDateTime
RTC_ReadDateTime: // 0x027F79C4
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	mov r0, #0x86
	mov r1, #0x20
	mov r2, r4
	mov r3, #7
	bl RTC_Func_27F7330
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end RTC_ReadDateTime

	arm_func_start RTC_SetHourFormat
RTC_SetHourFormat: // 0x027F79F0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r0
	and r5, r4, #1
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bne _027F7AE4
	add r0, sp, #0
	bl RTC_ReadStatus1
	ldrh r1, [sp]
	mov r0, r1, lsl #0x1e
	mov r2, r0, lsr #0x1f
	mov r0, r5, lsl #0x10
	cmp r2, r0, lsr #16
	beq _027F7AE4
	and r4, r4, #1
	bic r1, r1, #2
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #1
	orr r0, r1, r0, lsl #1
	strh r0, [sp]
	add r0, sp, #0
	bl RTC_WriteStatus1
	mov r0, #0x86
	mov r1, #0x10
	add r2, sp, #4
	mov r3, #3
	bl RTC_Func_27F7330
	mov r0, r4, lsl #0x10
	movs r0, r0, lsr #0x10
	bne _027F7A80
	add r0, sp, #4
	bl RTC_Func_27F74AC
	b _027F7A88
_027F7A80:
	add r0, sp, #4
	bl RTC_Func_27F7394
_027F7A88:
	mov r0, #6
	mov r1, #0x10
	add r2, sp, #4
	mov r3, #3
	bl RTC_Func_27F7330
	mov r0, #0x86
	mov r1, #0x50
	add r2, sp, #4
	mov r3, #3
	bl RTC_Func_27F7330
	mov r0, r5, lsl #0x10
	movs r0, r0, lsr #0x10
	bne _027F7AC8
	add r0, sp, #4
	bl RTC_Func_27F74AC
	b _027F7AD0
_027F7AC8:
	add r0, sp, #4
	bl RTC_Func_27F7394
_027F7AD0:
	mov r0, #6
	mov r1, #0x50
	add r2, sp, #4
	mov r3, #3
	bl RTC_Func_27F7330
_027F7AE4:
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end RTC_SetHourFormat

	arm_func_start RTC_Reset
RTC_Reset: // 0x027F7AF0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	ldrh r0, [sp]
	bic r0, r0, #1
	orr r0, r0, #1
	strh r0, [sp]
	mov r0, #6
	mov r1, #0
	add r2, sp, #0
	mov r3, #1
	bl RTC_Func_27F7330
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end RTC_Reset

	arm_func_start RTCi_GpioStart
RTCi_GpioStart: // 0x027F7B30
	mov ip, #0x4000000
	add ip, ip, #0x138
	ldrh r0, [ip]
	bic r0, r0, #0x77
	orr r0, r0, #0x72
	strh r0, [ip]
	mov r3, #2
_027F7B4C:
	subs r3, r3, #1
	bne _027F7B4C
	bic r0, r0, #4
	orr r0, r0, #4
	strh r0, [ip]
	mov r3, #2
_027F7B64:
	subs r3, r3, #1
	bne _027F7B64
	bx lr
	arm_func_end RTCi_GpioStart

	arm_func_start RTCi_GpioEnd
RTCi_GpioEnd: // 0x027F7B70
	mov ip, #0x4000000
	add ip, ip, #0x138
	mov r3, #2
_027F7B7C:
	subs r3, r3, #1
	bne _027F7B7C
	ldrh r0, [ip]
	bic r0, r0, #4
	orr r0, r0, #0
	strh r0, [ip]
	mov r3, #2
_027F7B98:
	subs r3, r3, #1
	bne _027F7B98
	bx lr
	arm_func_end RTCi_GpioEnd

	arm_func_start RTCi_GpioSendCommand
RTCi_GpioSendCommand: // 0x027F7BA4
	mov ip, #0x4000000
	add ip, ip, #0x138
	orr r1, r0, r1
	ldrh r0, [ip]
	bic r0, r0, #0x77
	orr r0, r0, #0x74
	mov r2, #0
_027F7BC0:
	bic r0, r0, #3
	orr r0, r0, #0
	mov r3, #1
	tst r3, r1, lsr r2
	movne r3, #1
	moveq r3, #0
	orr r0, r0, r3
	strh r0, [ip]
	mov r3, #9
_027F7BE4:
	subs r3, r3, #1
	bne _027F7BE4
	bic r0, r0, #2
	orr r0, r0, #2
	strh r0, [ip]
	mov r3, #9
_027F7BFC:
	subs r3, r3, #1
	bne _027F7BFC
	add r2, r2, #1
	cmp r2, #8
	bne _027F7BC0
	bx lr
	arm_func_end RTCi_GpioSendCommand

	arm_func_start RTCi_GpioSendData
RTCi_GpioSendData: // 0x027F7C14
	mov ip, #0x4000000
	add ip, ip, #0x138
_027F7C1C:
	stmdb sp!, {r0, r1}
	tst r0, #1
	ldreqh r1, [r0]
	ldrneh r1, [r0, #-1]
	movne r1, r1, lsr #8
	ldrh r0, [ip]
	bic r0, r0, #0x77
	orr r0, r0, #0x74
	mov r2, #0
_027F7C40:
	bic r0, r0, #3
	orr r0, r0, #0
	mov r3, #1
	tst r3, r1, lsr r2
	movne r3, #1
	moveq r3, #0
	orr r0, r0, r3
	strh r0, [ip]
	mov r3, #9
_027F7C64:
	subs r3, r3, #1
	bne _027F7C64
	bic r0, r0, #2
	orr r0, r0, #2
	strh r0, [ip]
	mov r3, #9
_027F7C7C:
	subs r3, r3, #1
	bne _027F7C7C
	add r2, r2, #1
	cmp r2, #8
	bne _027F7C40
	ldmia sp!, {r0, r1}
	add r0, r0, #1
	subs r1, r1, #1
	bne _027F7C1C
	bx lr
	arm_func_end RTCi_GpioSendData

	arm_func_start RTCi_GpioReceiveData
RTCi_GpioReceiveData: // 0x027F7CA4
	mov ip, #0x4000000
	add ip, ip, #0x138
_027F7CAC:
	stmdb sp!, {r0, r1}
	ldrh r0, [ip]
	bic r0, r0, #0x77
	orr r0, r0, #0x64
	mov r2, #0
	mov r1, #0
_027F7CC4:
	bic r0, r0, #3
	orr r0, r0, #0
	strh r0, [ip]
	mov r3, #9
_027F7CD4:
	subs r3, r3, #1
	bne _027F7CD4
	ldrh r0, [ip]
	and r3, r0, #1
	cmp r3, #1
	moveq r3, #0x80
	movne r3, #0
	orr r2, r3, r2, lsr #1
	bic r0, r0, #2
	orr r0, r0, #2
	strh r0, [ip]
	mov r3, #9
_027F7D04:
	subs r3, r3, #1
	bne _027F7D04
	add r1, r1, #1
	cmp r1, #8
	bne _027F7CC4
	ldmia sp!, {r0, r1}
	tst r0, #1
	beq _027F7D3C
	ldrh r3, [r0, #-1]
	bic r3, r3, #0xff00
	mov r2, r2, lsl #8
	orr r3, r2, r3
	strh r3, [r0, #-1]
	b _027F7D4C
_027F7D3C:
	ldrh r3, [r0]
	bic r3, r3, #0xff
	orr r3, r3, r2
	strh r3, [r0]
_027F7D4C:
	add r0, r0, #1
	subs r1, r1, #1
	bne _027F7CAC
	bx lr
	arm_func_end RTCi_GpioReceiveData
