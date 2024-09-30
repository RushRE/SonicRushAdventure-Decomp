	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWC_Auth_CheckWiFiIDNeedCreate
DWC_Auth_CheckWiFiIDNeedCreate: // 0x0208E650
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	add r0, sp, #0
	bl DWCi_BM_GetWiFiInfo
	ldr r2, [sp, #8]
	ldr r1, [sp, #0xc]
	mov r0, #0
	cmp r1, r0
	cmpeq r2, r0
	bne _0208E694
	ldr r1, [sp, #4]
	ldr r2, [sp]
	cmp r1, r0
	cmpeq r2, r0
	addeq sp, sp, #0x14
	moveq r0, #1
	ldmeqia sp!, {pc}
_0208E694:
	mov r0, #0
	add sp, sp, #0x14
	ldmia sp!, {pc}
	arm_func_end DWC_Auth_CheckWiFiIDNeedCreate

	arm_func_start DWC_Auth_GetId
DWC_Auth_GetId: // 0x0208E6A0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r4, r0
	add r0, sp, #0
	bl DWCi_BM_GetWiFiInfo
	add r0, sp, #0
	ldmia r0, {r2, r3}
	stmia r4, {r2, r3}
	add r1, sp, #8
	add r0, r4, #8
	ldmia r1, {r2, r3}
	stmia r0, {r2, r3}
	ldr r2, [sp]
	ldr r1, [sp, #4]
	mov r0, #0
	cmp r1, r0
	cmpeq r2, r0
	streq r0, [r4, #0x10]
	movne r0, #1
	strne r0, [r4, #0x10]
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
	arm_func_end DWC_Auth_GetId

	arm_func_start DWCi_AUTH_RemakeWiFiID
DWCi_AUTH_RemakeWiFiID: // 0x0208E6F8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x28
	add r2, sp, #0
	mov r1, #0
	strb r1, [r2]
	strb r1, [r2, #1]
	strb r1, [r2, #2]
	strb r1, [r2, #3]
	strb r1, [r2, #4]
	mov r5, r0
	strb r1, [r2, #5]
	bl DWCi_BM_GetWiFiInfo
	bl RTC_Init
	add r0, sp, #8
	bl RTC_GetDate
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r0, sp, #0x18
	bl RTC_GetTime
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r0, sp, #8
	add r1, sp, #0x18
	bl RTC_ConvertDateTimeToSecond
	mov r4, r0
	mov r0, #0
	subs r2, r4, r0
	sbcs r2, r1, r0
	addlt sp, sp, #0x28
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	bl OS_IsTickAvailable
	cmp r0, #0
	beq _0208E794
	ldr r0, _0208E888 // =OS_GetTick
	adds r4, r4, r0
_0208E794:
	add r0, sp, #0
	bl OS_GetMacAddress
	ldrb r1, [sp]
	ldr r6, _0208E88C // =0x5D588B65
	ldr r7, _0208E890 // =0x00269EC3
	ldrb r0, [sp, #1]
	mla r9, r4, r6, r7
	mov r1, r1, lsl #0x10
	orr r1, r1, r0, lsl #8
	ldrb r2, [sp, #2]
	ldr r0, _0208E894 // =0x000009BF
	ldrb r8, [sp, #3]
	orr r1, r2, r1
	cmp r1, r0
	movne r1, #1
	mov r2, r9, lsr #0x10
	mov r0, #0x3e8
	mul r3, r2, r0
	mov r2, r3, lsr #0x10
	mov r3, r8, lsl #0x10
	ldrb r4, [sp, #4]
	ldrb r0, [sp, #5]
	mov r8, #0
	orr r10, r3, r4, lsl #8
	strh r2, [r5, #0x10]
	str r8, [r5, #8]
	str r8, [r5, #0xc]
	moveq r1, #0
	ldr r2, [r5, #0xc]
	ldr r3, [r5, #8]
	cmp r2, r8
	cmpeq r3, r8
	and r4, r1, #0xff
	orr r10, r0, r10
	bne _0208E87C
_0208E820:
	mla r9, r6, r9, r7
	b _0208E82C
_0208E828:
	mla r9, r6, r9, r7
_0208E82C:
	cmp r9, #0
	beq _0208E828
	ldrh r1, [r5, #0x12]
	mov r0, r9, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r1, r0
	beq _0208E828
	strh r0, [r5, #0x12]
	ldrh r0, [r5, #0x12]
	mov r1, r10
	mov r2, r4
	mov r3, r8
	bl DWCi_Util_WiFiId_scrambleUid
	str r0, [r5, #8]
	str r1, [r5, #0xc]
	ldr r0, [r5, #0xc]
	ldr r1, [r5, #8]
	cmp r0, r8
	cmpeq r1, r8
	beq _0208E820
_0208E87C:
	mov r0, #1
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0208E888: .word OS_GetTick
_0208E88C: .word 0x5D588B65
_0208E890: .word 0x00269EC3
_0208E894: .word 0x000009BF
	arm_func_end DWCi_AUTH_RemakeWiFiID

	arm_func_start DWCi_AUTH_UpDateWiFiID
DWCi_AUTH_UpDateWiFiID: // 0x0208E898
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r5, r0
	add r0, sp, #0
	mov r4, r1
	bl DWCi_BM_GetWiFiInfo
	add ip, r5, #8
	ldmia ip, {r2, r3}
	stmia r5, {r2, r3}
	add r1, sp, #8
	ldmia r1, {r2, r3}
	mov r0, r5
	mov r1, r4
	stmia ip, {r2, r3}
	bl DWCi_BM_SetWiFiInfo
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWCi_AUTH_UpDateWiFiID

	arm_func_start DWCi_AUTH_MakeWiFiID
DWCi_AUTH_MakeWiFiID: // 0x0208E8E8
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r4, r0
	add r0, sp, #0
	bl DWCi_AUTH_GetNewWiFiInfo
	cmp r0, #0
	addeq sp, sp, #0x18
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, sp, #0
	mov r1, r4
	bl DWCi_BM_SetWiFiInfo
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
	arm_func_end DWCi_AUTH_MakeWiFiID

	arm_func_start DWCi_AUTH_GetNewWiFiInfo
DWCi_AUTH_GetNewWiFiInfo: // 0x0208E92C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x28
	mov r8, r0
	bl DWCi_BM_GetWiFiInfo
	bl RTC_Init
	add r0, sp, #8
	bl RTC_GetDate
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r0, sp, #0x18
	bl RTC_GetTime
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r0, sp, #8
	add r1, sp, #0x18
	bl RTC_ConvertDateTimeToSecond
	mov r4, r0
	mov r0, #0
	subs r2, r4, r0
	sbcs r2, r1, r0
	addlt sp, sp, #0x28
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	bl OS_IsTickAvailable
	cmp r0, #0
	beq _0208E9A8
	ldr r0, _0208EB00 // =OS_GetTick
	adds r4, r4, r0
_0208E9A8:
	add r0, sp, #0
	bl OS_GetMacAddress
	ldrb r1, [sp]
	ldr r9, _0208EB04 // =0x5D588B65
	ldr r10, _0208EB08 // =0x00269EC3
	ldrb r0, [sp, #1]
	mla r5, r4, r9, r10
	mov r1, r1, lsl #0x10
	orr r1, r1, r0, lsl #8
	ldrb r2, [sp, #2]
	ldr r0, _0208EB0C // =0x000009BF
	ldrb r6, [sp, #3]
	orr r1, r2, r1
	cmp r1, r0
	movne r1, #1
	moveq r1, #0
	mov r2, r5, lsr #0x10
	mov r0, #0x3e8
	mul r3, r2, r0
	mov r2, r3, lsr #0x10
	ldrb r0, [sp, #5]
	ldrb r4, [sp, #4]
	mov r3, r6, lsl #0x10
	and r7, r1, #0xff
	orr r3, r3, r4, lsl #8
	strh r2, [r8, #0x10]
	mov r4, #0
	str r4, [r8]
	str r4, [r8, #4]
	ldrh r2, [r8, #0x12]
	orr r6, r0, r3
	cmp r2, #0
	bne _0208EA98
	str r4, [r8, #8]
	str r4, [r8, #0xc]
	ldr r0, [r8, #0xc]
	ldr r1, [r8, #8]
	cmp r0, r4
	cmpeq r1, r4
	bne _0208EAF4
_0208EA48:
	mul r0, r5, r9
	adds r5, r0, r10
	bne _0208EA60
_0208EA54:
	mul r0, r5, r9
	adds r5, r0, r10
	beq _0208EA54
_0208EA60:
	strh r5, [r8, #0x12]
	ldrh r0, [r8, #0x12]
	mov r1, r6
	mov r2, r7
	mov r3, r4
	bl DWCi_Util_WiFiId_scrambleUid
	str r0, [r8, #8]
	str r1, [r8, #0xc]
	ldr r0, [r8, #0xc]
	ldr r1, [r8, #8]
	cmp r0, r4
	cmpeq r1, #0
	beq _0208EA48
	b _0208EAF4
_0208EA98:
	str r4, [r8, #8]
	str r4, [r8, #0xc]
	ldr r0, [r8, #0xc]
	ldr r1, [r8, #8]
	cmp r0, r4
	cmpeq r1, r4
	bne _0208EAF4
	add r5, r8, #0x12
_0208EAB8:
	ldrh r0, [r5, #0]
	mov r1, r6
	mov r2, r7
	add r0, r0, #1
	strh r0, [r5]
	ldrh r0, [r8, #0x12]
	mov r3, r4
	bl DWCi_Util_WiFiId_scrambleUid
	str r0, [r8, #8]
	str r1, [r8, #0xc]
	ldr r0, [r8, #0xc]
	ldr r1, [r8, #8]
	cmp r0, r4
	cmpeq r1, r4
	beq _0208EAB8
_0208EAF4:
	mov r0, #1
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0208EB00: .word OS_GetTick
_0208EB04: .word 0x5D588B65
_0208EB08: .word 0x00269EC3
_0208EB0C: .word 0x000009BF
	arm_func_end DWCi_AUTH_GetNewWiFiInfo

	arm_func_start DWCi_Util_WiFiId_scrambleUid
DWCi_Util_WiFiId_scrambleUid: // 0x0208EB10
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov lr, #0
	and ip, lr, #0
	mvn r5, #0xff000000
	ldr r4, _0208EC90 // =0x0000FFFF
	and r2, r2, #1
	mov r6, ip, lsl #2
	and r3, r3, #3
	and r5, r1, r5
	orr r1, r3, r2, lsl #2
	orr r6, r6, r2, lsr #30
	mov r7, ip, lsl #3
	and r2, r0, r4
	orr r0, r1, r5, lsl #3
	orr r1, r0, r2, lsl #27
	mov r3, ip, lsl #0x1b
	orr r3, r3, r2, lsr #5
	orr r7, r7, r5, lsr #29
	orr r0, ip, r6
	orr r0, r7, r0
	orr r0, r3, r0
	add r2, sp, #0
	str r1, [sp]
	str r0, [sp, #4]
_0208EB74:
	ldrb r0, [r2, #0]
	add lr, lr, #1
	cmp lr, #6
	eor r0, r0, #0xd6
	strb r0, [r2], #1
	blt _0208EB74
	ldr r2, _0208EC94 // =0x02112624
	add r5, sp, #0
	mov r4, #0
_0208EB98:
	ldrb r3, [r5, #0]
	add r4, r4, #1
	cmp r4, #5
	mov r0, r3, asr #4
	and r1, r0, #0xf
	and r0, r3, #0xf
	ldrb r1, [r2, r1]
	ldrb r0, [r2, r0]
	orr r0, r0, r1, lsl #4
	strb r0, [r5], #1
	blt _0208EB98
	add r0, sp, #0
	add r1, sp, #8
	mov r2, #8
	bl MI_CpuCopy8
	ldr r4, _0208EC98 // =0x0211261C
	add r5, sp, #8
	mov r3, #0
	add r1, sp, #0
_0208EBE4:
	ldrb r2, [r5, #0]
	ldrb r0, [r4, #0]
	add r3, r3, #1
	cmp r3, #5
	strb r2, [r1, r0]
	add r5, r5, #1
	add r4, r4, #1
	blt _0208EBE4
	ldrb r2, [sp, #5]
	mov r0, #0
	ldr r3, [sp]
	and r2, r2, #7
	strb r0, [sp, #7]
	strb r0, [sp, #6]
	strb r2, [sp, #5]
	ldr r2, [sp, #4]
	mov r4, r3, lsl #1
	mov r2, r2, lsl #1
	orr r2, r2, r3, lsr #31
	str r2, [sp, #4]
	ldrb r2, [sp, #5]
	str r4, [sp]
	ldrb r3, [sp]
	mov r2, r2, asr #3
	and r2, r2, #1
	orr r2, r3, r2
	strb r2, [sp]
_0208EC50:
	ldrb r2, [r1, #0]
	add r0, r0, #1
	cmp r0, #6
	eor r2, r2, #0x67
	strb r2, [r1], #1
	blt _0208EC50
	ldrb r0, [sp, #5]
	mov r1, #0
	strb r1, [sp, #7]
	and r0, r0, #7
	strb r1, [sp, #6]
	strb r0, [sp, #5]
	ldr r0, [sp]
	ldr r1, [sp, #4]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0208EC90: .word 0x0000FFFF
_0208EC94: .word 0x02112624
_0208EC98: .word 0x0211261C
	arm_func_end DWCi_Util_WiFiId_scrambleUid
