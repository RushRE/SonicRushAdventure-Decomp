	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start CARDi_IdentifyBackupCore
CARDi_IdentifyBackupCore: // 0x020EFFB0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _020F02B0 // =0x021500E0
	mov r5, r0
	ldr r4, [r1]
	mov r1, #0
	add r0, r4, #0x18
	mov r2, #0x48
	bl MI_CpuFill8
	cmp r5, #0
	str r5, [r4, #4]
	mov r0, #0x3f
	addeq sp, sp, #4
	str r0, [r4, #0x4c]
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	mov r0, r5, asr #8
	and r0, r0, #0xff
	mov r2, #1
	mov r3, r2, lsl r0
	and r1, r5, #0xff
	str r3, [r4, #0x18]
	mov r0, #0xff
	strb r0, [r4, #0x48]
	cmp r1, #1
	bne _020F00D0
	cmp r3, #0x200
	beq _020F0034
	cmp r3, #0x2000
	beq _020F0054
	cmp r3, #0x10000
	beq _020F0078
	b _020F0288
_020F0034:
	mov r0, #0x10
	str r0, [r4, #0x20]
	str r2, [r4, #0x24]
	mov r0, #5
	str r0, [r4, #0x28]
	mov r0, #0xf0
	strb r0, [r4, #0x48]
	b _020F0098
_020F0054:
	mov r0, #0x20
	str r0, [r4, #0x20]
	mov r0, #2
	str r0, [r4, #0x24]
	mov r0, #5
	str r0, [r4, #0x28]
	mov r0, #0
	strb r0, [r4, #0x48]
	b _020F0098
_020F0078:
	mov r0, #0x80
	str r0, [r4, #0x20]
	mov r0, #2
	str r0, [r4, #0x24]
	mov r0, #0xa
	str r0, [r4, #0x28]
	mov r0, #0
	strb r0, [r4, #0x48]
_020F0098:
	ldr r0, [r4, #0x20]
	add sp, sp, #4
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x4c]
	orr r0, r0, #0x40
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x4c]
	orr r0, r0, #0x100
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x4c]
	orr r0, r0, #0x200
	str r0, [r4, #0x4c]
	ldmia sp!, {r4, r5, lr}
	bx lr
_020F00D0:
	cmp r1, #2
	bne _020F0228
	cmp r3, #0x100000
	bhi _020F0108
	cmp r3, #0x100000
	bhs _020F0128
	cmp r3, #0x40000
	bhi _020F00FC
	cmp r3, #0x40000
	beq _020F0128
	b _020F0288
_020F00FC:
	cmp r3, #0x80000
	beq _020F0128
	b _020F0288
_020F0108:
	cmp r3, #0x200000
	bhi _020F011C
	cmp r3, #0x200000
	beq _020F0160
	b _020F0288
_020F011C:
	cmp r3, #0x800000
	beq _020F0198
	b _020F0288
_020F0128:
	mov r0, #0x19
	str r0, [r4, #0x2c]
	mov r1, #0x12c
	str r1, [r4, #0x30]
	ldr r0, _020F02B4 // =0x00001388
	str r1, [r4, #0x44]
	str r0, [r4, #0x3c]
	ldr r0, [r4, #0x4c]
	orr r0, r0, #0x80
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x4c]
	orr r0, r0, #0x400
	str r0, [r4, #0x4c]
	b _020F01CC
_020F0160:
	mov r1, #0x3e8
	ldr r0, _020F02B8 // =0x00000BB8
	str r1, [r4, #0x3c]
	ldr r1, _020F02BC // =0x00004268
	str r0, [r4, #0x40]
	ldr r0, _020F02C0 // =0x00009C40
	str r1, [r4, #0x34]
	str r0, [r4, #0x38]
	mov r0, #0
	strb r0, [r4, #0x48]
	ldr r0, [r4, #0x4c]
	orr r0, r0, #0x1000
	str r0, [r4, #0x4c]
	b _020F01CC
_020F0198:
	mov r1, #0x3e8
	ldr r0, _020F02B8 // =0x00000BB8
	str r1, [r4, #0x3c]
	ldr r1, _020F02C4 // =0x000109A0
	str r0, [r4, #0x40]
	ldr r0, _020F02C8 // =0x00027100
	str r1, [r4, #0x34]
	str r0, [r4, #0x38]
	mov r0, #0
	strb r0, [r4, #0x48]
	ldr r0, [r4, #0x4c]
	orr r0, r0, #0x1000
	str r0, [r4, #0x4c]
_020F01CC:
	mov r0, #0x10000
	str r0, [r4, #0x1c]
	mov r0, #0x100
	str r0, [r4, #0x20]
	mov r0, #3
	str r0, [r4, #0x24]
	mov r0, #5
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x4c]
	add sp, sp, #4
	orr r0, r0, #0x40
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x4c]
	orr r0, r0, #0x100
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x4c]
	orr r0, r0, #0x200
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x4c]
	orr r0, r0, #0x800
	str r0, [r4, #0x4c]
	ldmia sp!, {r4, r5, lr}
	bx lr
_020F0228:
	cmp r1, #3
	bne _020F0288
	cmp r3, #0x2000
	beq _020F0240
	cmp r3, #0x8000
	bne _020F0288
_020F0240:
	str r3, [r4, #0x20]
	str r3, [r4, #0x1c]
	mov r0, #2
	str r0, [r4, #0x24]
	mov r0, #0
	strb r0, [r4, #0x48]
	ldr r0, [r4, #0x4c]
	add sp, sp, #4
	orr r0, r0, #0x40
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x4c]
	orr r0, r0, #0x100
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x4c]
	orr r0, r0, #0x200
	str r0, [r4, #0x4c]
	ldmia sp!, {r4, r5, lr}
	bx lr
_020F0288:
	mov r1, #0
	str r1, [r4, #4]
	str r1, [r4, #0x18]
	ldr r0, _020F02B0 // =0x021500E0
	mov r1, #3
	ldr r0, [r0]
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020F02B0: .word 0x021500E0
_020F02B4: .word 0x00001388
_020F02B8: .word 0x00000BB8
_020F02BC: .word 0x00004268
_020F02C0: .word 0x00009C40
_020F02C4: .word 0x000109A0
_020F02C8: .word 0x00027100
	arm_func_end CARDi_IdentifyBackupCore

	arm_func_start CARD_IdentifyBackup
CARD_IdentifyBackup: // 0x020F02CC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, _020F0408 // =_version_NINTENDO_BACKUP
	ldr r7, _020F040C // =0x021500E0
	bl OSi_ReferSymbol
	cmp r5, #0
	bne _020F02F0
	bl OS_Terminate
_020F02F0:
	bl CARD_CheckEnabled
	bl OS_DisableInterrupts
	ldr r1, [r7, #0x114]
	mov r4, r0
	ands r0, r1, #4
	beq _020F0320
	add r6, r7, #0x10c
_020F030C:
	mov r0, r6
	bl OS_SleepThread
	ldr r0, [r7, #0x114]
	ands r0, r0, #4
	bne _020F030C
_020F0320:
	ldr r0, [r7, #0x114]
	mov r1, #0
	orr r0, r0, #4
	str r0, [r7, #0x114]
	str r1, [r7, #0x38]
	mov r0, r4
	str r1, [r7, #0x3c]
	bl OS_RestoreInterrupts
	mov r0, r5
	bl CARDi_IdentifyBackupCore
	ldr r0, _020F0410 // =OSi_ThreadInfo
	ldr r1, _020F040C // =0x021500E0
	ldr r2, [r0, #4]
	mov r0, r7
	str r2, [r1, #0x104]
	mov r1, #2
	mov r2, #1
	bl CARDi_Request
	ldr r0, [r7]
	mov r1, #0
	str r1, [r0, #0xc]
	ldr r0, [r7]
	add r1, r7, #0x120
	str r1, [r0, #0x10]
	ldr r1, [r7]
	mov r2, #1
	mov r0, r7
	str r2, [r1, #0x14]
	mov r1, #6
	bl CARDi_Request
	ldr r6, [r7, #0x38]
	ldr r5, [r7, #0x3c]
	bl OS_DisableInterrupts
	mov r4, r0
	ldr r1, [r7, #0x114]
	add r0, r7, #0x10c
	bic r1, r1, #0x4c
	str r1, [r7, #0x114]
	bl OS_WakeupThread
	ldr r0, [r7, #0x114]
	ands r0, r0, #0x10
	beq _020F03D0
	add r0, r7, #0x44
	bl OS_WakeupThreadDirect
_020F03D0:
	mov r0, r4
	bl OS_RestoreInterrupts
	cmp r6, #0
	beq _020F03E8
	mov r0, r5
	blx r6
_020F03E8:
	ldr r0, [r7]
	ldr r0, [r0]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020F0408: .word _version_NINTENDO_BACKUP
_020F040C: .word 0x021500E0
_020F0410: .word OSi_ThreadInfo
	arm_func_end CARD_IdentifyBackup
