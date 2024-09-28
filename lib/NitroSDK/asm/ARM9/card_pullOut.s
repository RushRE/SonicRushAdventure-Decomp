	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start CARDi_CheckPulledOut
CARDi_CheckPulledOut: // 0x020F114C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _020F11B0 // =0x027FFC10
	ldrh r1, [r1]
	cmp r1, #0
	ldreq r1, _020F11B4 // =0x027FF800
	ldrne r1, _020F11B8 // =0x027FFC00
	ldr r1, [r1]
	str r1, [sp]
	ldr r1, [sp]
	cmp r0, r1
	addeq sp, sp, #8
	ldmeqia sp!, {r4, lr}
	bxeq lr
	bl OS_DisableInterrupts
	mov r4, r0
	mov r0, #0xe
	mov r1, #0x11
	mov r2, #0
	bl CARDi_PulledOutCallback
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020F11B0: .word 0x027FFC10
_020F11B4: .word 0x027FF800
_020F11B8: .word 0x027FFC00
	arm_func_end CARDi_CheckPulledOut

	arm_func_start CARD_TerminateForPulledOut
CARD_TerminateForPulledOut: // 0x020F11BC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _020F122C // =0x027FFFA8
	mov r5, #1
	ldrh r0, [r0]
	and r0, r0, #0x8000
	movs r0, r0, asr #0xf
	beq _020F1208
	bl PM_ForceToPowerOff
	cmp r0, #4
	bne _020F1200
	ldr r4, _020F1230 // =0x000A3A47
_020F11EC:
	mov r0, r4
	bl OS_SpinWait
	bl PM_ForceToPowerOff
	cmp r0, #4
	beq _020F11EC
_020F1200:
	cmp r0, #0
	moveq r5, #0
_020F1208:
	cmp r5, #0
	beq _020F121C
	mov r0, #1
	mov r1, r0
	bl CARDi_SendtoPxi
_020F121C:
	bl OS_Terminate
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020F122C: .word 0x027FFFA8
_020F1230: .word 0x000A3A47
	arm_func_end CARD_TerminateForPulledOut

	arm_func_start CARD_IsPulledOut
CARD_IsPulledOut: // 0x020F1234
	ldr r0, _020F1240 // =0x02150940
	ldr r0, [r0]
	bx lr
	.align 2, 0
_020F1240: .word 0x02150940
	arm_func_end CARD_IsPulledOut

	arm_func_start CARD_SetPulledOutCallback
CARD_SetPulledOutCallback: // 0x020F1244
	ldr r1, _020F1250 // =0x02150944
	str r0, [r1]
	bx lr
	.align 2, 0
_020F1250: .word 0x02150944
	arm_func_end CARD_SetPulledOutCallback

	arm_func_start CARDi_PulledOutCallback
CARDi_PulledOutCallback: // 0x020F1254
	stmdb sp!, {lr}
	sub sp, sp, #4
	and r0, r1, #0x3f
	cmp r0, #0x11
	bne _020F12BC
	ldr r2, _020F12CC // =0x02150940
	ldr r0, [r2]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldr r1, _020F12D0 // =0x02150944
	mov r0, #1
	ldr r1, [r1]
	str r0, [r2]
	cmp r1, #0
	beq _020F129C
	blx r1
_020F129C:
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	bl CARD_TerminateForPulledOut
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020F12BC:
	bl OS_Terminate
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F12CC: .word 0x02150940
_020F12D0: .word 0x02150944
	arm_func_end CARDi_PulledOutCallback

	arm_func_start CARD_InitPulledOutCallback
CARD_InitPulledOutCallback: // 0x020F12D4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl PXI_Init
	ldr r1, _020F1304 // =CARDi_PulledOutCallback
	mov r0, #0xe
	bl PXI_SetFifoRecvCallback
	ldr r0, _020F1308 // =0x02150944
	mov r1, #0
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F1304: .word CARDi_PulledOutCallback
_020F1308: .word 0x02150944
	arm_func_end CARD_InitPulledOutCallback