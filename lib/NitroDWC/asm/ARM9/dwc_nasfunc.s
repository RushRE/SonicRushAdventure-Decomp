	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWC_GetDateTime
DWC_GetDateTime: // 0x0208F390
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r2, _0208F45C // =0x0214397C
	mov r5, r0
	ldr r2, [r2]
	mov r4, r1
	cmp r2, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	bl RTC_GetDate
	cmp r0, #0
	bne _0208F3D4
	mov r0, r4
	bl RTC_GetTime
	cmp r0, #0
	beq _0208F3E0
_0208F3D4:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_0208F3E0:
	mov r0, r5
	mov r1, r4
	bl RTC_ConvertDateTimeToSecond
	mvn r2, #0
	cmp r1, r2
	cmpeq r0, r2
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	ldr r2, _0208F460 // =0x02143980
	mov ip, #0
	ldr lr, [r2]
	ldr r3, [r2, #4]
	subs r2, r0, lr
	sbc r3, r1, r3
	subs r0, r2, ip
	sbcs r0, r3, ip
	blt _0208F438
	ldr r0, _0208F464 // =0xBC19137F
	subs r0, r0, r2
	sbcs r0, ip, r3
	bge _0208F444
_0208F438:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_0208F444:
	mov r0, r5
	mov r1, r4
	bl RTC_ConvertSecondToDateTime
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0208F45C: .word 0x0214397C
_0208F460: .word 0x02143980
_0208F464: .word 0xBC19137F
	arm_func_end DWC_GetDateTime

	arm_func_start DWC_GetIngamesnCheckResult
DWC_GetIngamesnCheckResult: // 0x0208F468
	ldr r0, _0208F474 // =0x021438E4
	ldr r0, [r0]
	bx lr
	.align 2, 0
_0208F474: .word 0x021438E4
	arm_func_end DWC_GetIngamesnCheckResult
