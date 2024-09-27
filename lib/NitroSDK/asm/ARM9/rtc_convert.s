	.include "asm/macros.inc"
	.include "global.inc"

	.text

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
	ldr r3, _020EFAA0 // sDayOfYear
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
_020EFAA0: .word sDayOfYear
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
	ldr r0, _020EFBC4 // sDayOfYear - 4 // TODO: make sure this matches later
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
_020EFBC4: .word sDayOfYear - 4 // TODO: make sure this matches later
_020EFBC8: .word 0x0000016D
	arm_func_end RTC_ConvertDateToDay

	.data

.public sDayOfYear
sDayOfYear: // 0x0211F984
    .word 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
