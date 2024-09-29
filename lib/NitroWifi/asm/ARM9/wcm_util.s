	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start WCMi_ShelterRssi
WCMi_ShelterRssi: // 0x020CCA2C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _020CCAA4 // =0x0214721C
	ands r1, r0, #2
	ldrb ip, [r2]
	movne r0, r0, asr #2
	andne lr, r0, #0xff
	moveq r0, r0, asr #2
	addeq r0, r0, #0x19
	andeq lr, r0, #0xff
	mov r1, ip, lsr #0x1f
	rsb r0, r1, ip, lsl #28
	cmp ip, #0x10
	ldr r3, _020CCAA8 // =0x02147220
	add r0, r1, r0, ror #28
	strb lr, [r3, r0]
	addlo r0, ip, #1
	strlob r0, [r2]
	addlo sp, sp, #4
	ldmloia sp!, {lr}
	bxlo lr
	add r0, ip, #1
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #28
	add r0, r1, r0, ror #28
	add r0, r0, #0x10
	strb r0, [r2]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CCAA4: .word 0x0214721C
_020CCAA8: .word 0x02147220
	arm_func_end WCMi_ShelterRssi

	arm_func_start WcmGetLinkLevel
WcmGetLinkLevel: // 0x020CCAAC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl WCMi_GetRssiAverage
	mov r1, #0
	cmp r0, #0x1c
	movhs r1, #3
	bhs _020CCADC
	cmp r0, #0x16
	movhs r1, #2
	bhs _020CCADC
	cmp r0, #0x10
	movhs r1, #1
_020CCADC:
	mov r0, r1
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end WcmGetLinkLevel

	arm_func_start WCMi_GetRssiAverage
WCMi_GetRssiAverage: // 0x020CCAEC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020CCB7C // =0x0214721C
	mov r0, #0
	ldrb r1, [r1]
	cmp r1, #0x10
	bls _020CCB38
	ldr r2, _020CCB80 // =0x02147220
	mov r3, r0
_020CCB10:
	ldrb r1, [r2]
	add r3, r3, #1
	cmp r3, #0x10
	add r0, r0, r1
	add r2, r2, #1
	blt _020CCB10
	mov r1, r0, asr #3
	add r0, r0, r1, lsr #28
	mov r0, r0, asr #4
	b _020CCB6C
_020CCB38:
	cmp r1, #0
	beq _020CCB6C
	mov r3, r0
	cmp r1, #0
	ble _020CCB68
	ldr ip, _020CCB80 // =0x02147220
_020CCB50:
	ldrb r2, [ip]
	add r3, r3, #1
	cmp r3, r1
	add r0, r0, r2
	add ip, ip, #1
	blt _020CCB50
_020CCB68:
	bl _s32_div_f
_020CCB6C:
	and r0, r0, #0xff
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CCB7C: .word 0x0214721C
_020CCB80: .word 0x02147220
	arm_func_end WCMi_GetRssiAverage

	arm_func_start WCM_GetLinkLevel
WCM_GetLinkLevel: // 0x020CCB84
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl OS_DisableInterrupts
	mov r5, r0
	bl WCMi_GetSystemWork
	cmp r0, #0
	mov r4, #0
	beq _020CCBBC
	add r0, r0, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #9
	bne _020CCBBC
	bl WcmGetLinkLevel
	mov r4, r0
_020CCBBC:
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WCM_GetLinkLevel

	arm_func_start WCM_CompareBssID
WCM_CompareBssID: // 0x020CCBD4
	mov ip, #0
_020CCBD8:
	ldrb r3, [r0, ip]
	ldrb r2, [r1, ip]
	cmp r3, r2
	movne r0, #0
	bxne lr
	add ip, ip, #1
	cmp ip, #6
	blt _020CCBD8
	mov r0, #1
	bx lr
	arm_func_end WCM_CompareBssID
