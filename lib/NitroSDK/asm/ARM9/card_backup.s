	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start CARD_GetBackupSectorSize
CARD_GetBackupSectorSize: // 0x020F0414
	ldr r0, _020F0424 // =0x021500E0
	ldr r0, [r0]
	ldr r0, [r0, #0x1c]
	bx lr
	.align 2, 0
_020F0424: .word 0x021500E0
	arm_func_end CARD_GetBackupSectorSize

	arm_func_start CARD_GetBackupTotalSize
CARD_GetBackupTotalSize: // 0x020F0428
	ldr r0, _020F0438 // =0x021500E0
	ldr r0, [r0]
	ldr r0, [r0, #0x18]
	bx lr
	.align 2, 0
_020F0438: .word 0x021500E0
	arm_func_end CARD_GetBackupTotalSize

	arm_func_start CARDi_RequestStreamCommand
CARDi_RequestStreamCommand: // 0x020F043C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r10, r0
	ldr r6, _020F0520 // =0x021500E0
	ldr r0, _020F0524 // =_version_NINTENDO_BACKUP
	mov r9, r1
	mov r8, r2
	mov r7, r3
	bl OSi_ReferSymbol
	bl OS_DisableInterrupts
	ldr r1, [r6, #0x114]
	mov r5, r0
	ands r0, r1, #4
	beq _020F0488
	add r4, r6, #0x10c
_020F0474:
	mov r0, r4
	bl OS_SleepThread
	ldr r0, [r6, #0x114]
	ands r0, r0, #4
	bne _020F0474
_020F0488:
	ldr r0, [r6, #0x114]
	ldr r1, [sp, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x114]
	str r7, [r6, #0x38]
	mov r0, r5
	str r1, [r6, #0x3c]
	bl OS_RestoreInterrupts
	str r10, [r6, #0x1c]
	str r9, [r6, #0x20]
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	str r8, [r6, #0x24]
	ldr r2, [sp, #0x2c]
	str r1, [r6, #0x2c]
	ldr r1, [sp, #0x30]
	str r2, [r6, #0x30]
	str r1, [r6, #0x34]
	cmp r0, #0
	beq _020F04EC
	ldr r0, _020F0528 // =CARDi_RequestStreamCommandCore
	bl CARDi_SetTask
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
_020F04EC:
	ldr r0, _020F052C // =OSi_ThreadInfo
	ldr r1, _020F0520 // =0x021500E0
	ldr r2, [r0, #4]
	mov r0, r6
	str r2, [r1, #0x104]
	bl CARDi_RequestStreamCommandCore
	ldr r0, [r6]
	ldr r0, [r0]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_020F0520: .word 0x021500E0
_020F0524: .word _version_NINTENDO_BACKUP
_020F0528: .word CARDi_RequestStreamCommandCore
_020F052C: .word OSi_ThreadInfo
	arm_func_end CARDi_RequestStreamCommand

	arm_func_start CARDi_RequestStreamCommandCore
CARDi_RequestStreamCommandCore: // 0x020F0530
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r9, r0
	ldr r8, [r9, #0x2c]
	ldr r0, _020F0728 // =_version_NINTENDO_BACKUP
	ldr r7, [r9, #0x34]
	ldr r10, [r9, #0x30]
	mov r6, #0x100
	bl OSi_ReferSymbol
	cmp r8, #0xb
	bne _020F0564
	bl CARD_GetBackupSectorSize
	mov r6, r0
_020F0564:
	mov r0, #1
	add r4, r9, #0x120
	mov r11, #9
	str r0, [sp]
_020F0574:
	ldr r5, [r9, #0x24]
	ldr r0, [r9]
	cmp r6, r5
	movlo r5, r6
	str r5, [r0, #0x14]
	ldr r0, [r9, #0x114]
	ands r0, r0, #0x40
	beq _020F05B0
	ldr r0, [r9, #0x114]
	mov r1, #7
	bic r0, r0, #0x40
	str r0, [r9, #0x114]
	ldr r0, [r9]
	str r1, [r0]
	b _020F06C4
_020F05B0:
	cmp r7, #3
	addls pc, pc, r7, lsl #2
	b _020F0640
_020F05BC: // jump table
	b _020F05CC // case 0
	b _020F05F0 // case 1
	b _020F05F0 // case 2
	b _020F0628 // case 3
_020F05CC:
	mov r1, r5
	add r0, r9, #0x120
	bl DC_InvalidateRange
	ldr r1, [r9, #0x1c]
	ldr r0, [r9]
	str r1, [r0, #0xc]
	ldr r0, [r9]
	str r4, [r0, #0x10]
	b _020F0640
_020F05F0:
	ldr r0, [r9, #0x1c]
	mov r1, r4
	mov r2, r5
	bl MI_CpuCopy8
	mov r1, r5
	add r0, r9, #0x120
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	ldr r0, [r9]
	str r4, [r0, #0xc]
	ldr r1, [r9, #0x20]
	ldr r0, [r9]
	str r1, [r0, #0x10]
	b _020F0640
_020F0628:
	ldr r1, [r9, #0x1c]
	ldr r0, [r9]
	str r1, [r0, #0xc]
	ldr r1, [r9, #0x20]
	ldr r0, [r9]
	str r1, [r0, #0x10]
_020F0640:
	mov r0, r9
	mov r1, r8
	mov r2, r10
	bl CARDi_Request
	cmp r0, #0
	beq _020F06C4
	cmp r7, #2
	bne _020F067C
	ldr r2, [sp]
	mov r0, r9
	mov r1, r11
	bl CARDi_Request
	cmp r0, #0
	bne _020F0694
	b _020F06C4
_020F067C:
	cmp r7, #0
	bne _020F0694
	ldr r1, [r9, #0x20]
	mov r2, r5
	add r0, r9, #0x120
	bl MI_CpuCopy8
_020F0694:
	ldr r0, [r9, #0x1c]
	add r0, r0, r5
	str r0, [r9, #0x1c]
	ldr r0, [r9, #0x20]
	add r0, r0, r5
	str r0, [r9, #0x20]
	ldr r0, [r9, #0x24]
	sub r0, r0, r5
	str r0, [r9, #0x24]
	ldr r0, [r9, #0x24]
	cmp r0, #0
	bne _020F0574
_020F06C4:
	ldr r6, [r9, #0x38]
	ldr r5, [r9, #0x3c]
	bl OS_DisableInterrupts
	ldr r1, [r9, #0x114]
	mov r4, r0
	bic r0, r1, #0x4c
	str r0, [r9, #0x114]
	add r0, r9, #0x10c
	bl OS_WakeupThread
	ldr r0, [r9, #0x114]
	ands r0, r0, #0x10
	beq _020F06FC
	add r0, r9, #0x44
	bl OS_WakeupThreadDirect
_020F06FC:
	mov r0, r4
	bl OS_RestoreInterrupts
	cmp r6, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	mov r0, r5
	blx r6
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020F0728: .word _version_NINTENDO_BACKUP
	arm_func_end CARDi_RequestStreamCommandCore
