	.include "asm/macros.inc"
	.include "global.inc"
	
	.section .version,4
	
	.public _version_NINTENDO_BACKUP
_version_NINTENDO_BACKUP: ; 0x02000C70
	.asciz "[SDK+NINTENDO:BACKUP]"

	.bss

CARDi_EnableFlag: // 0x0215007C
    .space 0x04

.public _02150080
_02150080:
	.space 0x28E0

	.text

	arm_func_start CARD_GetRomHeader
CARD_GetRomHeader: // 0x020EFBCC
	ldr r0, _020EFBD4 // =0x027FFA80
	bx lr
	.align 2, 0
_020EFBD4: .word 0x027FFA80
	arm_func_end CARD_GetRomHeader

	arm_func_start CARD_UnlockBackup
CARD_UnlockBackup: // 0x020EFBD8
	ldr ip, _020EFBE4 // =CARDi_UnlockResource
	mov r1, #2
	bx ip
	.align 2, 0
_020EFBE4: .word CARDi_UnlockResource
	arm_func_end CARD_UnlockBackup

	arm_func_start CARD_LockBackup
CARD_LockBackup: // 0x020EFBE8
	ldr ip, _020EFBF4 // =CARDi_LockResource
	mov r1, #2
	bx ip
	.align 2, 0
_020EFBF4: .word CARDi_LockResource
	arm_func_end CARD_LockBackup

	arm_func_start CARD_UnlockRom
CARD_UnlockRom: // 0x020EFBF8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl OS_UnlockCard
	mov r0, r4
	mov r1, #1
	bl CARDi_UnlockResource
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end CARD_UnlockRom

	arm_func_start CARD_LockRom
CARD_LockRom: // 0x020EFC18
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #1
	bl CARDi_LockResource
	mov r0, r4
	bl OS_LockCard
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end CARD_LockRom

	arm_func_start CARD_SetThreadPriority
CARD_SetThreadPriority: // 0x020EFC38
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r6, _020EFC7C // =0x021500E0
	mov r7, r0
	bl OS_DisableInterrupts
	ldr r5, [r6, #0x108]
	mov r4, r0
	str r7, [r6, #0x108]
	ldr r1, [r6, #0x108]
	add r0, r6, #0x44
	bl OS_SetThreadPriority
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020EFC7C: .word 0x021500E0
	arm_func_end CARD_SetThreadPriority

	arm_func_start CARDi_WaitAsync
CARDi_WaitAsync: // 0x020EFC80
	stmdb sp!, {r4, r5, r6, lr}
	ldr r6, _020EFCD8 // =0x021500E0
	bl OS_DisableInterrupts
	ldr r1, [r6, #0x114]
	mov r5, r0
	ands r0, r1, #4
	beq _020EFCB4
	add r4, r6, #0x10c
_020EFCA0:
	mov r0, r4
	bl OS_SleepThread
	ldr r0, [r6, #0x114]
	ands r0, r0, #4
	bne _020EFCA0
_020EFCB4:
	mov r0, r5
	bl OS_RestoreInterrupts
	ldr r0, [r6]
	ldr r0, [r0]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020EFCD8: .word 0x021500E0
	arm_func_end CARDi_WaitAsync

	arm_func_start CARD_Enable
CARD_Enable: // 0x020EFCDC
	ldr r1, _020EFCE8 // =CARDi_EnableFlag
	str r0, [r1]
	bx lr
	.align 2, 0
_020EFCE8: .word CARDi_EnableFlag
	arm_func_end CARD_Enable

	arm_func_start CARD_CheckEnabled
CARD_CheckEnabled: // 0x020EFCEC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl CARD_IsEnabled
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	bl OS_Terminate
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end CARD_CheckEnabled

	arm_func_start CARD_IsEnabled
CARD_IsEnabled: // 0x020EFD18
	ldr r0, _020EFD24 // =CARDi_EnableFlag
	ldr r0, [r0]
	bx lr
	.align 2, 0
_020EFD24: .word CARDi_EnableFlag
	arm_func_end CARD_IsEnabled

	arm_func_start CARDi_InitCommon
CARDi_InitCommon: // 0x020EFD28
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r4, _020EFE08 // =0x021500E0
	ldr r1, _020EFE0C // =_02150080
	mvn r2, #2
	mov r0, #0
	str r2, [r4, #8]
	mov r2, #0x60
	str r0, [r4, #0xc]
	str r0, [r4, #0x18]
	str r1, [r4]
	bl MIi_CpuClearFast
	ldr r0, _020EFE0C // =_02150080
	mov r1, #0x60
	bl DC_FlushRange
	ldr r0, _020EFE10 // =0x027FFC40
	ldrh r0, [r0]
	cmp r0, #2
	beq _020EFD84
	ldr r0, _020EFE14 // =0x027FFE00
	ldr r1, _020EFE18 // =0x027FFA80
	mov r2, #0x160
	bl MI_CpuCopy8
_020EFD84:
	mov r2, #0
	str r2, [r4, #0x14]
	ldr r0, [r4, #0x14]
	mov r1, #4
	str r0, [r4, #0x10]
	str r2, [r4, #0x110]
	ldr r3, [r4, #0x110]
	mov r0, #0x400
	str r3, [r4, #0x10c]
	str r1, [r4, #0x108]
	str r0, [sp]
	ldr ip, [r4, #0x108]
	ldr r1, _020EFE1C // =CARDi_TaskThread
	ldr r3, _020EFE20 // =0x02150700
	add r0, r4, #0x44
	str ip, [sp, #4]
	bl OS_CreateThread
	add r0, r4, #0x44
	bl OS_WakeupThreadDirect
	ldr r1, _020EFE24 // =CARDi_OnFifoRecv
	mov r0, #0xb
	bl PXI_SetFifoRecvCallback
	ldr r0, _020EFE10 // =0x027FFC40
	ldrh r0, [r0]
	cmp r0, #2
	addeq sp, sp, #8
	ldmeqia sp!, {r4, lr}
	bxeq lr
	mov r0, #1
	bl CARD_Enable
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020EFE08: .word 0x021500E0
_020EFE0C: .word _02150080
_020EFE10: .word 0x027FFC40
_020EFE14: .word 0x027FFE00
_020EFE18: .word 0x027FFA80
_020EFE1C: .word CARDi_TaskThread
_020EFE20: .word 0x02150700
_020EFE24: .word CARDi_OnFifoRecv
	arm_func_end CARDi_InitCommon

	arm_func_start CARDi_UnlockResource
CARDi_UnlockResource: // 0x020EFE28
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r5, _020EFEC8 // =0x021500E0
	mov r7, r0
	mov r6, r1
	bl OS_DisableInterrupts
	mov r1, r5
	mov r4, r0
	ldr r0, [r1, #8]
	cmp r0, r7
	bne _020EFE60
	ldr r0, [r5, #0xc]
	cmp r0, #0
	bne _020EFE68
_020EFE60:
	bl OS_Terminate
	b _020EFEA8
_020EFE68:
	ldr r0, [r5, #0x18]
	cmp r0, r6
	beq _020EFE78
	bl OS_Terminate
_020EFE78:
	ldr r0, [r5, #0xc]
	sub r0, r0, #1
	str r0, [r5, #0xc]
	ldr r0, [r5, #0xc]
	cmp r0, #0
	bne _020EFEA8
	mvn r0, #2
	str r0, [r5, #8]
	mov r1, #0
	add r0, r5, #0x10
	str r1, [r5, #0x18]
	bl OS_WakeupThread
_020EFEA8:
	ldr r1, [r5]
	mov r2, #0
	mov r0, r4
	str r2, [r1]
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020EFEC8: .word 0x021500E0
	arm_func_end CARDi_UnlockResource

	arm_func_start CARDi_LockResource
CARDi_LockResource: // 0x020EFECC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	ldr r5, _020EFF64 // =0x021500E0
	mov r7, r0
	mov r6, r1
	bl OS_DisableInterrupts
	ldr r1, [r5, #8]
	mov r4, r0
	cmp r1, r7
	bne _020EFF08
	ldr r0, [r5, #0x18]
	cmp r0, r6
	beq _020EFF38
	bl OS_Terminate
	b _020EFF38
_020EFF08:
	ldr r0, [r5, #8]
	mvn r8, #2
	cmp r0, r8
	beq _020EFF30
	add r9, r5, #0x10
_020EFF1C:
	mov r0, r9
	bl OS_SleepThread
	ldr r0, [r5, #8]
	cmp r0, r8
	bne _020EFF1C
_020EFF30:
	str r7, [r5, #8]
	str r6, [r5, #0x18]
_020EFF38:
	ldr r1, [r5, #0xc]
	mov r0, r4
	add r1, r1, #1
	str r1, [r5, #0xc]
	ldr r1, [r5]
	mov r2, #0
	str r2, [r1]
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020EFF64: .word 0x021500E0
	arm_func_end CARDi_LockResource

	arm_func_start CARDi_SetTask
CARDi_SetTask: // 0x020EFF68
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r4, _020EFFAC // =0x021500E0
	mov r5, r0
	ldr r1, [r4, #0x108]
	add r0, r4, #0x44
	bl OS_SetThreadPriority
	add r0, r4, #0x44
	str r0, [r4, #0x104]
	str r5, [r4, #0x40]
	ldr r1, [r4, #0x114]
	orr r1, r1, #8
	str r1, [r4, #0x114]
	bl OS_WakeupThreadDirect
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020EFFAC: .word 0x021500E0
	arm_func_end CARDi_SetTask

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

	arm_func_start CARDi_GetRomAccessor
CARDi_GetRomAccessor: // 0x020F072C
	ldr r0, _020F0734 // =CARDi_ReadCard
	bx lr
	.align 2, 0
_020F0734: .word CARDi_ReadCard
	arm_func_end CARDi_GetRomAccessor

	arm_func_start CARD_WaitRomAsync
CARD_WaitRomAsync: // 0x020F0738
	ldr ip, _020F0740 // =CARDi_WaitAsync
	bx ip
	.align 2, 0
_020F0740: .word CARDi_WaitAsync
	arm_func_end CARD_WaitRomAsync

	arm_func_start CARD_Init
CARD_Init: // 0x020F0744
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr ip, _020F07BC // =0x021500E0
	ldr r0, [ip, #0x114]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	mov r0, #1
	str r0, [ip, #0x114]
	mov r3, #0
	str r3, [ip, #0x24]
	ldr r0, [ip, #0x24]
	mvn r1, #0
	str r0, [ip, #0x20]
	ldr r2, [ip, #0x20]
	ldr r0, _020F07C0 // =0x02150700
	str r2, [ip, #0x1c]
	str r1, [ip, #0x28]
	str r3, [ip, #0x38]
	str r3, [ip, #0x3c]
	str r3, [r0]
	bl CARDi_InitCommon
	bl CARDi_GetRomAccessor
	ldr r1, _020F07C4 // =0x02150720
	str r0, [r1]
	bl CARD_InitPulledOutCallback
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F07BC: .word 0x021500E0
_020F07C0: .word 0x02150700
_020F07C4: .word 0x02150720
	arm_func_end CARD_Init

	arm_func_start CARDi_ReadRom
CARDi_ReadRom: // 0x020F07C8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r6, _020F08DC // =0x021500E0
	mov r10, r0
	mov r9, r1
	mov r8, r2
	mov r7, r3
	ldr r11, _020F08E0 // =0x02150720
	bl CARD_CheckEnabled
	bl OS_DisableInterrupts
	ldr r1, [r6, #0x114]
	mov r5, r0
	ands r0, r1, #4
	beq _020F0818
	add r4, r6, #0x10c
_020F0804:
	mov r0, r4
	bl OS_SleepThread
	ldr r0, [r6, #0x114]
	ands r0, r0, #4
	bne _020F0804
_020F0818:
	ldr r1, [r6, #0x114]
	ldr r0, [sp, #0x28]
	orr r1, r1, #4
	str r1, [r6, #0x114]
	ldr r1, [sp, #0x2c]
	str r0, [r6, #0x38]
	mov r0, r5
	str r1, [r6, #0x3c]
	bl OS_RestoreInterrupts
	ldr r0, _020F08E4 // =0x02150700
	str r10, [r6, #0x28]
	ldr r0, [r0]
	cmp r10, #3
	add r0, r9, r0
	str r0, [r6, #0x1c]
	str r8, [r6, #0x20]
	str r7, [r6, #0x24]
	bhi _020F0868
	mov r0, r10
	bl MI_StopDma
_020F0868:
	mov r0, r11
	bl CARDi_TryReadCardDma
	cmp r0, #0
	beq _020F089C
	ldr r0, [sp, #0x30]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	bl CARD_WaitRomAsync
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F089C:
	ldr r0, [sp, #0x30]
	cmp r0, #0
	beq _020F08BC
	ldr r0, _020F08E8 // =CARDi_ReadRomSyncCore
	bl CARDi_SetTask
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F08BC:
	ldr r1, _020F08EC // =OSi_ThreadInfo
	mov r0, r6
	ldr r1, [r1, #4]
	str r1, [r6, #0x104]
	bl CARDi_ReadRomSyncCore
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020F08DC: .word 0x021500E0
_020F08E0: .word 0x02150720
_020F08E4: .word 0x02150700
_020F08E8: .word CARDi_ReadRomSyncCore
_020F08EC: .word OSi_ThreadInfo
	arm_func_end CARDi_ReadRom

	arm_func_start CARDi_ReadRomSyncCore
CARDi_ReadRomSyncCore: // 0x020F08F0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r4, _020F0994 // =0x02150720
	mov r0, r4
	bl CARDi_ReadFromCache
	cmp r0, #0
	beq _020F0918
	ldr r1, [r4]
	mov r0, r4
	blx r1
_020F0918:
	ldr r7, _020F0998 // =0x021500E0
	bl CARDi_ReadRomIDCore
	bl CARDi_CheckPulledOut
	ldr r0, [r7]
	mov r1, #0
	str r1, [r0]
	ldr r6, [r7, #0x38]
	ldr r5, [r7, #0x3c]
	bl OS_DisableInterrupts
	ldr r1, [r7, #0x114]
	mov r4, r0
	bic r0, r1, #0x4c
	str r0, [r7, #0x114]
	add r0, r7, #0x10c
	bl OS_WakeupThread
	ldr r0, [r7, #0x114]
	ands r0, r0, #0x10
	beq _020F0968
	add r0, r7, #0x44
	bl OS_WakeupThreadDirect
_020F0968:
	mov r0, r4
	bl OS_RestoreInterrupts
	cmp r6, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r0, r5
	blx r6
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020F0994: .word 0x02150720
_020F0998: .word 0x021500E0
	arm_func_end CARDi_ReadRomSyncCore

	arm_func_start CARDi_ReadRomIDCore
CARDi_ReadRomIDCore: // 0x020F099C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0xb8000000
	mov r1, #0
	bl CARDi_SetRomOp
	ldr r1, _020F09F8 // _0211F9B4
	mov r0, #0x2000
	ldr r1, [r1]
	rsb r0, r0, #0
	ldr r2, [r1, #0x60]
	ldr r1, _020F09FC // =0x040001A4
	bic r2, r2, #0x7000000
	orr r2, r2, #0xa7000000
	and r0, r2, r0
	str r0, [r1]
_020F09D8:
	ldr r0, [r1]
	ands r0, r0, #0x800000
	beq _020F09D8
	ldr r0, _020F0A00 // =0x04100010
	ldr r0, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F09F8: .word _0211F9B4
_020F09FC: .word 0x040001A4
_020F0A00: .word 0x04100010
	arm_func_end CARDi_ReadRomIDCore

	arm_func_start CARDi_ReadCard
CARDi_ReadCard: // 0x020F0A04
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	ldr r9, _020F0AF8 // =0x021500E0
	add r7, r10, #0x20
	ldr r5, _020F0AFC // =0x04100010
	ldr r6, _020F0B00 // =0x040001A4
	mov r11, #0
	mov r0, #0x200
	rsb r4, r0, #0
_020F0A2C:
	ldr r0, [r9, #0x1c]
	and r1, r0, r4
	cmp r1, r0
	bne _020F0A54
	ldr r8, [r9, #0x20]
	ands r0, r8, #3
	bne _020F0A54
	ldr r0, [r9, #0x24]
	cmp r0, #0x200
	bhs _020F0A5C
_020F0A54:
	mov r8, r7
	str r1, [r10, #8]
_020F0A5C:
	mov r0, r1, lsr #8
	orr r0, r0, #0xb7000000
	mov r1, r1, lsl #0x18
	bl CARDi_SetRomOp
	ldr r1, [r10, #4]
	mov r0, r11
	str r1, [r6]
_020F0A78:
	ldr r2, [r6]
	ands r1, r2, #0x800000
	beq _020F0A94
	ldr r1, [r5]
	cmp r0, #0x200
	strlo r1, [r8, r0, lsl #2]
	addlo r0, r0, #1
_020F0A94:
	ands r1, r2, #0x80000000
	bne _020F0A78
	ldr r0, [r9, #0x20]
	cmp r8, r0
	bne _020F0ADC
	ldr r2, [r9, #0x1c]
	ldr r1, [r9, #0x20]
	ldr r0, [r9, #0x24]
	add r2, r2, #0x200
	add r1, r1, #0x200
	subs r0, r0, #0x200
	str r2, [r9, #0x1c]
	str r1, [r9, #0x20]
	str r0, [r9, #0x24]
	bne _020F0A2C
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F0ADC:
	mov r0, r10
	bl CARDi_ReadFromCache
	cmp r0, #0
	bne _020F0A2C
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020F0AF8: .word 0x021500E0
_020F0AFC: .word 0x04100010
_020F0B00: .word 0x040001A4
	arm_func_end CARDi_ReadCard

	arm_func_start CARDi_TryReadCardDma
CARDi_TryReadCardDma: // 0x020F0B04
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r11, _020F0C64 // =0x021500E0
	mov r7, #0
	ldr r9, [r11, #0x20]
	mov r10, r0
	mov r6, r7
	mov r5, r7
	mov r1, r7
	ands r4, r9, #0x1f
	ldr r8, [r11, #0x24]
	bne _020F0B40
	ldr r0, [r11, #0x28]
	cmp r0, #3
	movls r1, #1
_020F0B40:
	cmp r1, #0
	beq _020F0B94
	bl OS_GetDTCMAddress
	ldr r1, _020F0C68 // =objDiffAttrSet
	add r2, r9, r8
	cmp r2, r1
	mov r3, #1
	mov r1, #0
	bls _020F0B6C
	cmp r9, #0x2000000
	movlo r1, r3
_020F0B6C:
	cmp r1, #0
	bne _020F0B8C
	cmp r0, r2
	bhs _020F0B88
	add r0, r0, #0x4000
	cmp r0, r9
	bhi _020F0B8C
_020F0B88:
	mov r3, #0
_020F0B8C:
	cmp r3, #0
	moveq r5, #1
_020F0B94:
	cmp r5, #0
	beq _020F0BB0
	ldr r1, [r11, #0x1c]
	ldr r0, _020F0C6C // =0x000001FF
	orr r1, r1, r8
	ands r0, r1, r0
	moveq r6, #1
_020F0BB0:
	cmp r6, #0
	beq _020F0BC0
	cmp r8, #0
	movne r7, #1
_020F0BC0:
	ldr r0, _020F0C70 // _0211F9B4
	cmp r7, #0
	ldr r0, [r0]
	ldr r0, [r0, #0x60]
	bic r0, r0, #0x7000000
	orr r0, r0, #0xa1000000
	str r0, [r10, #4]
	beq _020F0C54
	bl OS_DisableInterrupts
	mov r5, r0
	mov r0, r9
	mov r1, r8
	bl IC_InvalidateRange
	cmp r4, #0
	beq _020F0C1C
	sub r9, r9, r4
	mov r0, r9
	mov r1, #0x20
	bl DC_StoreRange
	add r0, r9, r8
	mov r1, #0x20
	bl DC_StoreRange
	add r8, r8, #0x20
_020F0C1C:
	mov r0, r9
	mov r1, r8
	bl DC_InvalidateRange
	bl DC_WaitWriteBufferEmpty
	ldr r1, _020F0C74 // =CARDi_OnReadCard
	mov r0, #0x80000
	bl OS_SetIrqFunction
	mov r0, #0x80000
	bl OS_ResetRequestIrqMask
	mov r0, #0x80000
	bl OS_EnableIrqMask
	mov r0, r5
	bl OS_RestoreInterrupts
	bl CARDi_SetCardDma
_020F0C54:
	mov r0, r7
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020F0C64: .word 0x021500E0
_020F0C68: .word objDiffAttrSet
_020F0C6C: .word 0x000001FF
_020F0C70: .word _0211F9B4
_020F0C74: .word CARDi_OnReadCard
	arm_func_end CARDi_TryReadCardDma

	arm_func_start CARDi_OnReadCard
CARDi_OnReadCard: // 0x020F0C78
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r0, _020F0D54 // =0x021500E0
	ldr r0, [r0, #0x28]
	bl MI_StopDma
	ldr r0, _020F0D54 // =0x021500E0
	ldr r3, [r0, #0x1c]
	ldr r2, [r0, #0x20]
	ldr r1, [r0, #0x24]
	add r3, r3, #0x200
	add r2, r2, #0x200
	subs r1, r1, #0x200
	str r3, [r0, #0x1c]
	str r2, [r0, #0x20]
	str r1, [r0, #0x24]
	bne _020F0D44
	mov r0, #0x80000
	bl OS_DisableIrqMask
	mov r0, #0x80000
	bl OS_ResetRequestIrqMask
	ldr r7, _020F0D54 // =0x021500E0
	bl CARDi_ReadRomIDCore
	bl CARDi_CheckPulledOut
	ldr r0, [r7]
	mov r1, #0
	str r1, [r0]
	ldr r6, [r7, #0x38]
	ldr r5, [r7, #0x3c]
	bl OS_DisableInterrupts
	ldr r1, [r7, #0x114]
	mov r4, r0
	bic r0, r1, #0x4c
	str r0, [r7, #0x114]
	add r0, r7, #0x10c
	bl OS_WakeupThread
	ldr r0, [r7, #0x114]
	ands r0, r0, #0x10
	beq _020F0D18
	add r0, r7, #0x44
	bl OS_WakeupThreadDirect
_020F0D18:
	mov r0, r4
	bl OS_RestoreInterrupts
	cmp r6, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r0, r5
	blx r6
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020F0D44:
	bl CARDi_SetCardDma
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020F0D54: .word 0x021500E0
	arm_func_end CARDi_OnReadCard

	arm_func_start CARDi_SetCardDma
CARDi_SetCardDma: // 0x020F0D58
	stmdb sp!, {r4, lr}
	ldr r4, _020F0DA0 // =0x021500E0
	ldr r1, _020F0DA4 // =0x04100010
	ldr r0, [r4, #0x28]
	ldr r2, [r4, #0x20]
	mov r3, #0x200
	bl MIi_CardDmaCopy32
	ldr r1, [r4, #0x1c]
	mov r0, r1, lsr #8
	orr r0, r0, #0xb7000000
	mov r1, r1, lsl #0x18
	bl CARDi_SetRomOp
	ldr r0, _020F0DA8 // =0x02150720
	ldr r1, _020F0DAC // =0x040001A4
	ldr r0, [r0, #4]
	str r0, [r1]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020F0DA0: .word 0x021500E0
_020F0DA4: .word 0x04100010
_020F0DA8: .word 0x02150720
_020F0DAC: .word 0x040001A4
	arm_func_end CARDi_SetCardDma

	arm_func_start CARDi_SetRomOp
CARDi_SetRomOp: // 0x020F0DB0
	ldr r3, _020F0E28 // =0x040001A4
_020F0DB4:
	ldr r2, [r3]
	ands r2, r2, #0x80000000
	bne _020F0DB4
	ldr r3, _020F0E2C // =0x040001A1
	mov ip, #0xc0
	ldr r2, _020F0E30 // =0x040001A8
	strb ip, [r3]
	mov ip, r0, lsr #0x18
	ldr r3, _020F0E34 // =0x040001A9
	strb ip, [r2]
	mov ip, r0, lsr #0x10
	ldr r2, _020F0E38 // =0x040001AA
	strb ip, [r3]
	mov ip, r0, lsr #8
	ldr r3, _020F0E3C // =0x040001AB
	strb ip, [r2]
	ldr r2, _020F0E40 // =0x040001AC
	strb r0, [r3]
	mov r3, r1, lsr #0x18
	ldr r0, _020F0E44 // =0x040001AD
	strb r3, [r2]
	mov r3, r1, lsr #0x10
	ldr r2, _020F0E48 // =0x040001AE
	strb r3, [r0]
	mov r3, r1, lsr #8
	ldr r0, _020F0E4C // =0x040001AF
	strb r3, [r2]
	strb r1, [r0]
	bx lr
	.align 2, 0
_020F0E28: .word 0x040001A4
_020F0E2C: .word 0x040001A1
_020F0E30: .word 0x040001A8
_020F0E34: .word 0x040001A9
_020F0E38: .word 0x040001AA
_020F0E3C: .word 0x040001AB
_020F0E40: .word 0x040001AC
_020F0E44: .word 0x040001AD
_020F0E48: .word 0x040001AE
_020F0E4C: .word 0x040001AF
	arm_func_end CARDi_SetRomOp

	arm_func_start CARDi_ReadFromCache
CARDi_ReadFromCache: // 0x020F0E50
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r5, _020F0EE4 // =0x021500E0
	mov r1, #0x200
	ldr r3, [r5, #0x1c]
	rsb r1, r1, #0
	ldr r2, [r0, #8]
	and r3, r3, r1
	cmp r3, r2
	bne _020F0EC8
	ldr r2, [r5, #0x1c]
	ldr r1, [r5, #0x24]
	sub r3, r2, r3
	rsb r4, r3, #0x200
	cmp r4, r1
	movhi r4, r1
	add r0, r0, #0x20
	ldr r1, [r5, #0x20]
	mov r2, r4
	add r0, r0, r3
	bl MI_CpuCopy8
	ldr r0, [r5, #0x1c]
	add r0, r0, r4
	str r0, [r5, #0x1c]
	ldr r0, [r5, #0x20]
	add r0, r0, r4
	str r0, [r5, #0x20]
	ldr r0, [r5, #0x24]
	sub r0, r0, r4
	str r0, [r5, #0x24]
_020F0EC8:
	ldr r0, [r5, #0x24]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020F0EE4: .word 0x021500E0
	arm_func_end CARDi_ReadFromCache

	arm_func_start CARDi_Request
CARDi_Request: // 0x020F0EE8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r6, r0
	ldr r0, [r6, #0x114]
	mov r5, r1
	mov r4, r2
	ands r0, r0, #2
	bne _020F0F60
	ldr r1, [r6, #0x114]
	mov r0, #0xb
	orr r2, r1, #2
	mov r1, #1
	str r2, [r6, #0x114]
	bl PXI_IsCallbackReady
	cmp r0, #0
	bne _020F0F50
	mov r9, #0x64
	mov r8, #0xb
	mov r7, #1
_020F0F34:
	mov r0, r9
	bl OS_SpinWait
	mov r0, r8
	mov r1, r7
	bl PXI_IsCallbackReady
	cmp r0, #0
	beq _020F0F34
_020F0F50:
	mov r0, r6
	mov r1, #0
	mov r2, #1
	bl CARDi_Request
_020F0F60:
	ldr r0, [r6]
	mov r1, #0x60
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	mov r9, #0xb
	mov r8, #1
	mov r7, #0
	mov r11, #0x60
_020F0F80:
	str r5, [r6, #4]
	ldr r0, [r6, #0x114]
	orr r0, r0, #0x20
	str r0, [r6, #0x114]
_020F0F90:
	mov r0, r9
	mov r1, r5
	mov r2, r8
	bl PXI_SendWordByFifo
	cmp r0, #0
	blt _020F0F90
	cmp r5, #0
	bne _020F0FCC
	ldr r10, [r6]
_020F0FB4:
	mov r0, r9
	mov r1, r10
	mov r2, r8
	bl PXI_SendWordByFifo
	cmp r0, #0
	blt _020F0FB4
_020F0FCC:
	bl OS_DisableInterrupts
	ldr r1, [r6, #0x114]
	mov r10, r0
	ands r0, r1, #0x20
	beq _020F0FF4
_020F0FE0:
	mov r0, r7
	bl OS_SleepThread
	ldr r0, [r6, #0x114]
	ands r0, r0, #0x20
	bne _020F0FE0
_020F0FF4:
	mov r0, r10
	bl OS_RestoreInterrupts
	ldr r0, [r6]
	mov r1, r11
	bl DC_InvalidateRange
	ldr r0, [r6]
	ldr r0, [r0]
	cmp r0, #4
	bne _020F1024
	sub r4, r4, #1
	cmp r4, #0
	bgt _020F0F80
_020F1024:
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	arm_func_end CARDi_Request

	arm_func_start CARDi_TaskThread
CARDi_TaskThread: // 0x020F103C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r5, _020F1094 // =0x021500E0
	mov r6, #0
	add r7, r5, #0x44
_020F1050:
	bl OS_DisableInterrupts
	ldr r1, [r5, #0x114]
	mov r4, r0
	ands r0, r1, #8
	bne _020F107C
_020F1064:
	mov r0, r6
	str r7, [r5, #0x104]
	bl OS_SleepThread
	ldr r0, [r5, #0x114]
	ands r0, r0, #8
	beq _020F1064
_020F107C:
	mov r0, r4
	bl OS_RestoreInterrupts
	ldr r1, [r5, #0x40]
	mov r0, r5
	blx r1
	b _020F1050
	.align 2, 0
_020F1094: .word 0x021500E0
	arm_func_end CARDi_TaskThread

	arm_func_start CARDi_OnFifoRecv
CARDi_OnFifoRecv: // 0x020F1098
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0xb
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	cmp r2, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	ldr r1, _020F10E4 // =0x021500E0
	ldr r0, [r1, #0x114]
	bic r0, r0, #0x20
	str r0, [r1, #0x114]
	ldr r0, [r1, #0x104]
	bl OS_WakeupThreadDirect
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F10E4: .word 0x021500E0
	arm_func_end CARDi_OnFifoRecv

	arm_func_start CARDi_SendtoPxi
CARDi_SendtoPxi: // 0x020F10E8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r1, r7
	mov r0, #0xe
	mov r2, #0
	bl PXI_SendWordByFifo
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r5, #0xe
	mov r4, #0
_020F1120:
	mov r0, r6
	blx SVC_WaitByLoop
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl PXI_SendWordByFifo
	cmp r0, #0
	bne _020F1120
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end CARDi_SendtoPxi

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

	.data

_0211F9B4: // 0x0211F9B4
    .word 0x27FFE00