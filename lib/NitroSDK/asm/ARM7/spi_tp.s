	.include "asm/macros.inc"
	.include "global.inc"

	.public OS_IRQTable

	.text

	arm_func_start TP_ExecuteProcess
TP_ExecuteProcess: // 0x03804B74
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x10
	mov r10, r0
	ldr r1, [r10, #4]
	cmp r1, #2
	bhi _03804BA8
	cmp r1, #0
	beq _03804BC0
	cmp r1, #1
	beq _03804C88
	cmp r1, #2
	beq _03804D34
	b _03804D80
_03804BA8:
	cmp r1, #0x10
	bne _03804D80
	ldr r0, _03804D8C // =tpw
	ldr r0, [r0, #0x20]
	cmp r0, #2
	bne _03804D80
_03804BC0:
	bl OS_DisableInterrupts
	mov r4, r0
	mov r0, #0
	bl SPIi_CheckException
	cmp r0, #0
	bne _03804BF8
	mov r0, r4
	bl OS_RestoreInterrupts
	ldr r0, [r10, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #4
	bl SPIi_ReturnResult
	b _03804D80
_03804BF8:
	mov r0, #0
	bl SPIi_GetException
	mov r0, r4
	bl OS_RestoreInterrupts
	add r0, sp, #8
	ldr r1, _03804D8C // =tpw
	ldr r1, [r1, #0x24]
	add r2, sp, #4
	bl TP_ExecSampling
	add r0, sp, #8
	ldrh r1, [sp, #4]
	bl TP_AutoAdjustRange
	ldrh r1, [sp, #8]
	ldr r0, _03804D90 // =0x027FFFAA
	strh r1, [r0]
	ldrh r1, [sp, #0xa]
	ldr r0, _03804D94 // =0x027FFFAC
	strh r1, [r0]
	ldr r0, [r10, #4]
	cmp r0, #0
	bne _03804C60
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl SPIi_ReturnResult
	b _03804C7C
_03804C60:
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr r1, [r10, #8]
	and r1, r1, #0xff
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl SPIi_ReturnResult
_03804C7C:
	mov r0, #0
	bl SPIi_ReleaseException
	b _03804D80
_03804C88:
	ldr r7, _03804D8C // =tpw
	ldr r0, [r7, #0x20]
	cmp r0, #1
	bne _03804D20
	mov r9, #0
	ldr r8, _03804D98 // =0x00000107
	ldr r6, _03804D9C // =0x0380AB20
	mov r5, #0xa
	ldr r4, _03804DA0 // =TpVAlarmHandler
	b _03804CF0
_03804CB0:
	mul r0, r9, r8
	bl _u32_div_f
	ldr r1, [r10, #0xc]
	add r0, r1, r0
	mov r1, r8
	bl _u32_div_f
	add r2, r7, r9, lsl #1
	strh r1, [r2, #0xcc]
	str r9, [sp]
	mov r0, #0x28
	mla r0, r9, r0, r6
	ldrsh r1, [r2, #0xcc]
	mov r2, r5
	mov r3, r4
	bl OS_SetPeriodicVAlarm
	add r9, r9, #1
_03804CF0:
	ldr r1, [r10, #8]
	cmp r9, r1
	blo _03804CB0
	ldr r0, [r10, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl SPIi_ReturnResult
	mov r1, #2
	ldr r0, _03804D8C // =tpw
	str r1, [r0, #0x20]
	b _03804D80
_03804D20:
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #3
	bl SPIi_ReturnResult
	b _03804D80
_03804D34:
	ldr r0, _03804D8C // =tpw
	ldr r0, [r0, #0x20]
	cmp r0, #3
	bne _03804D70
	ldr r0, _03804DA4 // =0x54505641
	bl OS_CancelVAlarms
	ldr r0, [r10, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl SPIi_ReturnResult
	mov r1, #0
	ldr r0, _03804D8C // =tpw
	str r1, [r0, #0x20]
	b _03804D80
_03804D70:
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #3
	bl SPIi_ReturnResult
_03804D80:
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_03804D8C: .word tpw
_03804D90: .word 0x027FFFAA
_03804D94: .word 0x027FFFAC
_03804D98: .word 0x00000107
_03804D9C: .word 0x0380AB20
_03804DA0: .word TpVAlarmHandler
_03804DA4: .word 0x54505641
	arm_func_end TP_ExecuteProcess

	arm_func_start TP_AutoAdjustRange
TP_AutoAdjustRange: // 0x03804DA8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, [r0]
	mov r2, r0, lsl #7
	movs r2, r2, lsr #0x1f
	bne _03804DD8
	mov r1, #0
	ldr r0, _03804E90 // =invalid_cnt_3255
	strb r1, [r0]
	ldr r0, _03804E94 // =valid_cnt_3256
	strb r1, [r0]
	b _03804E84
_03804DD8:
	mov r0, r0, lsl #5
	movs r0, r0, lsr #0x1e
	beq _03804E28
	mov r2, #0
	ldr r0, _03804E94 // =valid_cnt_3256
	strb r2, [r0]
	ldr r0, _03804E90 // =invalid_cnt_3255
	ldrb r1, [r0]
	add r1, r1, #1
	strb r1, [r0]
	ldrb r1, [r0]
	cmp r1, #4
	blo _03804E84
	strb r2, [r0]
	ldr r0, _03804E98 // =tpw
	ldr r1, [r0, #0x24]
	cmp r1, #0x23
	addlt r1, r1, #1
	strlt r1, [r0, #0x24]
	b _03804E84
_03804E28:
	mov lr, #0
	ldr r3, _03804E90 // =invalid_cnt_3255
	strb lr, [r3]
	ldr r2, _03804E98 // =tpw
	ldr ip, [r2, #0x24]
	cmp r1, ip, asr #1
	ldrge r0, _03804E94 // =valid_cnt_3256
	strgeb lr, [r0]
	bge _03804E84
	ldr r0, _03804E94 // =valid_cnt_3256
	ldrb r1, [r0]
	add r1, r1, #1
	strb r1, [r0]
	ldrb r1, [r0]
	cmp r1, #4
	blo _03804E84
	strb lr, [r0]
	ldr r0, [r2, #0x28]
	cmp ip, r0
	subgt r0, ip, #1
	strgt r0, [r2, #0x24]
	movgt r0, #3
	strgtb r0, [r3]
_03804E84:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03804E90: .word invalid_cnt_3255
_03804E94: .word valid_cnt_3256
_03804E98: .word tpw
	arm_func_end TP_AutoAdjustRange

	arm_func_start TP_AnalyzeCommand
TP_AnalyzeCommand: // 0x03804E9C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ands r1, r0, #0x2000000
	beq _03804ECC
	mov r4, #0
	mov r3, r4
	ldr r1, _03805054 // =tpw
_03804EB8:
	mov r2, r4, lsl #1
	strh r3, [r1, r2]
	add r4, r4, #1
	cmp r4, #0x10
	blt _03804EB8
_03804ECC:
	and r1, r0, #0xf0000
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #1
	ldr r2, _03805054 // =tpw
	strh r0, [r2, r1]
	ands r0, r0, #0x1000000
	beq _03805048
	ldrh r1, [r2]
	and r0, r1, #0xff00
	mov r0, r0, lsl #8
	mov r4, r0, lsr #0x10
	cmp r4, #3
	addls pc, pc, r4, lsl #2
	b _0380503C
_03804F04: // jump table
	b _03804F28 // case 0
	b _03804F50 // case 1
	b _03804FEC // case 2
	b _03804F14 // case 3
_03804F14:
	and r0, r1, #0xff
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SetStability
	b _03805048
_03804F28:
	mov r0, #0
	mov r1, r4
	mov r2, r0
	bl SPIi_SetEntry
	cmp r0, #0
	bne _03805048
	mov r0, r4
	mov r1, #4
	bl SPIi_ReturnResult
	b _03805048
_03804F50:
	ldr r0, [r2, #0x20]
	cmp r0, #0
	beq _03804F6C
	mov r0, r4
	mov r1, #3
	bl SPIi_ReturnResult
	b _03805048
_03804F6C:
	and r0, r1, #0xff
	mov r0, r0, lsl #0x10
	movs r3, r0, lsr #0x10
	beq _03804F84
	cmp r3, #4
	bls _03804F94
_03804F84:
	mov r0, r4
	mov r1, #2
	bl SPIi_ReturnResult
	b _03805048
_03804F94:
	ldrh r1, [r2, #2]
	ldr r0, _03805058 // =0x00000107
	cmp r1, r0
	blo _03804FB4
	mov r0, r4
	mov r1, #2
	bl SPIi_ReturnResult
	b _03805048
_03804FB4:
	str r1, [sp]
	mov r0, #0
	mov r1, r4
	mov r2, #2
	bl SPIi_SetEntry
	cmp r0, #0
	movne r1, #1
	ldrne r0, _03805054 // =tpw
	strne r1, [r0, #0x20]
	bne _03805048
	mov r0, r4
	mov r1, #4
	bl SPIi_ReturnResult
	b _03805048
_03804FEC:
	ldr r0, [r2, #0x20]
	cmp r0, #2
	beq _03805008
	mov r0, r4
	mov r1, #3
	bl SPIi_ReturnResult
	b _03805048
_03805008:
	mov r0, #0
	mov r1, r4
	mov r2, r0
	bl SPIi_SetEntry
	cmp r0, #0
	movne r1, #3
	ldrne r0, _03805054 // =tpw
	strne r1, [r0, #0x20]
	bne _03805048
	mov r0, r4
	mov r1, #4
	bl SPIi_ReturnResult
	b _03805048
_0380503C:
	mov r0, r4
	mov r1, #1
	bl SPIi_ReturnResult
_03805048:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_03805054: .word tpw
_03805058: .word 0x00000107
	arm_func_end TP_AnalyzeCommand

	arm_func_start TP_Init
TP_Init: // 0x0380505C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r3, #0
	ldr r0, _03805150 // =tpw
	str r3, [r0, #0x20]
	mov r1, #0x14
	str r1, [r0, #0x24]
	str r1, [r0, #0x28]
	mov r2, r3
_0380507C:
	mov r1, r3, lsl #1
	strh r2, [r0, r1]
	add r3, r3, #1
	cmp r3, #0x10
	blt _0380507C
	bl OS_IsVAlarmAvailable
	cmp r0, #0
	bne _038050A0
	bl OS_InitVAlarm
_038050A0:
	mov r7, #0
	ldr r6, _03805154 // =0x0380AB20
	ldr r5, _03805158 // =0x54505641
	mov r4, #0x28
_038050B0:
	mla r8, r7, r4, r6
	mov r0, r8
	bl OS_CreateVAlarm
	mov r0, r8
	mov r1, r5
	bl OS_SetVAlarmTag
	add r7, r7, #1
	cmp r7, #4
	blt _038050B0
	ldr r1, _0380515C // =0x040001C0
_038050D8:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _038050D8
	ldr r0, _03805160 // =0x00008A01
	strh r0, [r1]
	mov r1, #0x84
	ldr r0, _03805164 // =0x040001C2
	strh r1, [r0]
	ldr r1, _0380515C // =0x040001C0
_038050FC:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _038050FC
	mov r1, #0
	ldr r0, _03805164 // =0x040001C2
	strh r1, [r0]
	ldr r1, _0380515C // =0x040001C0
_03805118:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _03805118
	ldr r0, _03805168 // =0x00008201
	strh r0, [r1]
	mov r1, #0
	ldr r0, _03805164 // =0x040001C2
	strh r1, [r0]
	ldr r1, _0380515C // =0x040001C0
_0380513C:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _0380513C
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_03805150: .word tpw
_03805154: .word 0x0380AB20
_03805158: .word 0x54505641
_0380515C: .word 0x040001C0
_03805160: .word 0x00008A01
_03805164: .word 0x040001C2
_03805168: .word 0x00008201
	arm_func_end TP_Init

	arm_func_start TP_ExecSampling
TP_ExecSampling: // 0x0380516C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	movs r6, r1
	mov r5, r2
	mov r0, #0
	strh r0, [r5]
	rsbmi r6, r6, #0
	bl TPi_DetectTouch
	movs r4, r0
	bne _038051E8
	ldr r1, [r7]
	mov r0, #0x1000
	rsb r0, r0, #0
	and r0, r1, r0
	str r0, [r7]
	ldr r1, [r7]
	ldr r0, _038053A0 // =0xFF000FFF
	and r0, r1, r0
	str r0, [r7]
	ldr r0, [r7]
	bic r0, r0, #0x1000000
	str r0, [r7]
	ldr r0, [r7]
	bic r0, r0, #0x6000000
	orr r0, r0, #0x6000000
	str r0, [r7]
	mov r1, #0
	ldr r0, _038053A4 // =last_touch_flg
	strh r1, [r0]
	b _03805394
_038051E8:
	add r0, sp, #0
	mov r1, r6
	mov r2, #0
	add r3, sp, #2
	bl TPi_DetectPos
	ldr r1, [r7]
	bic r1, r1, #0x6000000
	and r0, r0, #3
	orr r0, r1, r0, lsl #25
	str r0, [r7]
	ldr r1, [r7]
	mov r0, #0x1000
	rsb r0, r0, #0
	and r2, r1, r0
	ldrh r1, [sp]
	ldr r0, _038053A8 // =0x00000FFF
	and r0, r1, r0
	orr r0, r2, r0
	str r0, [r7]
	add r0, sp, #0
	mov r1, r6
	mov r2, #1
	add r3, sp, #4
	bl TPi_DetectPos
	cmp r0, #2
	bne _03805270
	ldr r0, [r7]
	bic r1, r0, #0x6000000
	mov r0, r0, lsl #5
	mov r0, r0, lsr #0x1e
	orr r0, r0, #2
	and r0, r0, #3
	orr r0, r1, r0, lsl #25
	str r0, [r7]
_03805270:
	ldr r1, [r7]
	ldr r0, _038053A0 // =0xFF000FFF
	and r2, r1, r0
	ldrh r1, [sp]
	ldr r0, _038053A8 // =0x00000FFF
	and r0, r1, r0
	orr r0, r2, r0, lsl #12
	str r0, [r7]
	ldr r0, _038053AC // =0x00008A01
	ldr r3, _038053B0 // =0x040001C0
	strh r0, [r3]
	mov r6, #0
	mov r2, r6
	ldr r1, _038053B4 // =0x040001C2
_038052A8:
	strh r2, [r1]
_038052AC:
	ldrh r0, [r3]
	ands r0, r0, #0x80
	bne _038052AC
	add r6, r6, #1
	cmp r6, #0xc
	blt _038052A8
	ldr r0, _038053B8 // =0x00008201
	strh r0, [r3]
	mov r1, #0
	ldr r0, _038053B4 // =0x040001C2
	strh r1, [r0]
	ldr r1, _038053B0 // =0x040001C0
_038052DC:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _038052DC
	cmp r4, #2
	ldreq r0, [r7]
	biceq r0, r0, #0x6000000
	orreq r0, r0, #0x6000000
	streq r0, [r7]
	bl TPi_DetectTouch
	cmp r0, #0
	beq _03805374
	cmp r0, #1
	beq _03805344
	cmp r0, #2
	bne _03805390
	ldr r0, [r7]
	orr r0, r0, #0x1000000
	str r0, [r7]
	ldr r0, [r7]
	bic r0, r0, #0x6000000
	orr r0, r0, #0x6000000
	str r0, [r7]
	mov r1, #0
	ldr r0, _038053A4 // =last_touch_flg
	strh r1, [r0]
	b _03805394
_03805344:
	ldr r0, [r7]
	orr r0, r0, #0x1000000
	str r0, [r7]
	mov r1, #1
	ldr r0, _038053A4 // =last_touch_flg
	strh r1, [r0]
	ldrh r0, [sp, #4]
	ldrh r1, [sp, #2]
	cmp r1, r0
	movlo r1, r0
	strh r1, [r5]
	b _03805394
_03805374:
	ldr r0, [r7]
	bic r0, r0, #0x1000000
	str r0, [r7]
	mov r1, #0
	ldr r0, _038053A4 // =last_touch_flg
	strh r1, [r0]
	b _03805394
_03805390:
	bl OS_Terminate
_03805394:
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_038053A0: .word 0xFF000FFF
_038053A4: .word last_touch_flg
_038053A8: .word 0x00000FFF
_038053AC: .word 0x00008A01
_038053B0: .word 0x040001C0
_038053B4: .word 0x040001C2
_038053B8: .word 0x00008201
	arm_func_end TP_ExecSampling

	arm_func_start TPi_DetectPos
TPi_DetectPos: // 0x038053BC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x18
	cmp r2, #0
	moveq r5, #0xd1
	moveq r6, #1
	movne r5, #0x91
	movne r6, #2
_038053D8:
	ldr r4, _038055A0 // =0x040001C0
	ldrh r2, [r4]
	ands r2, r2, #0x80
	bne _038053D8
	ldr r2, _038055A4 // =0x00008A01
	strh r2, [r4]
	and r5, r5, #0xff
	ldr r2, _038055A8 // =0x040001C2
	strh r5, [r2]
_038053FC:
	ldrh r2, [r4]
	ands r2, r2, #0x80
	bne _038053FC
	mov r7, #0
	ldr ip, _038055A0 // =0x040001C0
	ldr lr, _038055A8 // =0x040001C2
	add r2, sp, #0
	mov r4, r7
	ldr r9, _038055AC // =0x00007FF8
_03805420:
	strh r4, [lr]
_03805424:
	ldrh r8, [ip]
	ands r8, r8, #0x80
	bne _03805424
	ldrh r8, [lr]
	and r8, r8, #0xff
	mov r8, r8, lsl #0x10
	mov r8, r8, lsr #8
	str r8, [r2, r7, lsl #2]
	strh r5, [lr]
_03805448:
	ldrh r8, [ip]
	ands r8, r8, #0x80
	bne _03805448
	ldrh r8, [lr]
	and r8, r8, #0xff
	mov r8, r8, lsl #0x10
	ldr r10, [r2, r7, lsl #2]
	orr r8, r10, r8, lsr #16
	str r8, [r2, r7, lsl #2]
	ldr r8, [r2, r7, lsl #2]
	and r8, r8, r9
	mov r8, r8, asr #3
	str r8, [r2, r7, lsl #2]
	add r7, r7, #1
	cmp r7, #5
	blt _03805420
	ldr r2, _038055B0 // =0x00008201
	strh r2, [ip]
	mov r2, #0
	strh r2, [lr]
	ldr r4, _038055A0 // =0x040001C0
_0380549C:
	ldrh r2, [r4]
	ands r2, r2, #0x80
	bne _0380549C
	mov r8, #0
	mov r7, r8
	add r5, sp, #0
_038054B4:
	add r9, r7, #1
	ldr r4, [r5, r7, lsl #2]
	b _038054D8
_038054C0:
	ldr r2, [r5, r9, lsl #2]
	subs r2, r4, r2
	rsbmi r2, r2, #0
	cmp r2, r8
	movgt r8, r2
	add r9, r9, #1
_038054D8:
	cmp r9, #5
	blt _038054C0
	add r7, r7, #1
	cmp r7, #4
	blt _038054B4
	strh r8, [r3]
	mov r4, #0
	add r2, sp, #0
	b _03805570
_038054FC:
	add r3, r4, #1
	ldr r7, [r2, r4, lsl #2]
	b _03805564
_03805508:
	ldr r8, [r2, r3, lsl #2]
	subs r5, r7, r8
	rsbmi r5, r5, #0
	cmp r5, r1
	bgt _03805560
	add r9, r3, #1
	b _03805558
_03805524:
	ldr r5, [r2, r9, lsl #2]
	subs r10, r7, r5
	rsbmi r10, r10, #0
	cmp r10, r1
	bgt _03805554
	add r1, r8, r7, lsl #1
	add r1, r5, r1
	mov r1, r1, asr #2
	bic r1, r1, #7
	strh r1, [r0]
	mov r0, #0
	b _03805594
_03805554:
	add r9, r9, #1
_03805558:
	cmp r9, #5
	blt _03805524
_03805560:
	add r3, r3, #1
_03805564:
	cmp r3, #4
	blt _03805508
	add r4, r4, #1
_03805570:
	cmp r4, #3
	blt _038054FC
	ldr r2, [sp]
	ldr r1, [sp, #0x10]
	add r1, r2, r1
	mov r1, r1, asr #1
	bic r1, r1, #7
	strh r1, [r0]
	mov r0, r6
_03805594:
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_038055A0: .word 0x040001C0
_038055A4: .word 0x00008A01
_038055A8: .word 0x040001C2
_038055AC: .word 0x00007FF8
_038055B0: .word 0x00008201
	arm_func_end TPi_DetectPos

	arm_func_start TPi_DetectTouch
TPi_DetectTouch: // 0x038055B4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0x8000
	bl EXIi_SelectRcnt
	ldr r1, _038056F8 // =0x040001C0
_038055C8:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _038055C8
	ldr r0, _038056FC // =0x00008A01
	strh r0, [r1]
	mov r1, #0x84
	ldr r0, _03805700 // =0x040001C2
	strh r1, [r0]
	ldr r1, _038056F8 // =0x040001C0
_038055EC:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _038055EC
	mov r1, #0
	ldr r0, _03805700 // =0x040001C2
	strh r1, [r0]
	ldr r1, _038056F8 // =0x040001C0
_03805608:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _03805608
	ldr r0, _03805704 // =0x00008201
	strh r0, [r1]
	mov r1, #0
	ldr r0, _03805700 // =0x040001C2
	strh r1, [r0]
	ldr r1, _038056F8 // =0x040001C0
_0380562C:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _0380562C
	ldr r0, _03805708 // =last_touch_flg
	ldrh r0, [r0]
	cmp r0, #0
	bne _03805660
	ldr r0, _0380570C // =0x04000136
	ldrh r0, [r0]
	ands r0, r0, #0x40
	moveq r0, #1
	movne r0, #0
	b _038056EC
_03805660:
	ldr r0, _0380570C // =0x04000136
	ldrh r0, [r0]
	ands r0, r0, #0x40
	moveq r0, #1
	beq _038056EC
	ldr r0, _038056FC // =0x00008A01
	strh r0, [r1]
	mov r1, #0x84
	ldr r0, _03805700 // =0x040001C2
	strh r1, [r0]
	ldr r1, _038056F8 // =0x040001C0
_0380568C:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _0380568C
	mov r1, #0
	ldr r0, _03805700 // =0x040001C2
	strh r1, [r0]
	ldr r1, _038056F8 // =0x040001C0
_038056A8:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _038056A8
	ldr r0, _03805704 // =0x00008201
	strh r0, [r1]
	mov r1, #0
	ldr r0, _03805700 // =0x040001C2
	strh r1, [r0]
	ldr r1, _038056F8 // =0x040001C0
_038056CC:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _038056CC
	ldr r0, _0380570C // =0x04000136
	ldrh r0, [r0]
	ands r0, r0, #0x40
	movne r0, #0
	moveq r0, #2
_038056EC:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_038056F8: .word 0x040001C0
_038056FC: .word 0x00008A01
_03805700: .word 0x040001C2
_03805704: .word 0x00008201
_03805708: .word last_touch_flg
_0380570C: .word 0x04000136
	arm_func_end TPi_DetectTouch
