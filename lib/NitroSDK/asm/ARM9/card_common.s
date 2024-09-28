	.include "asm/macros.inc"
	.include "global.inc"
	
	.section .version,4
	
	.public _version_NINTENDO_BACKUP
_version_NINTENDO_BACKUP: ; 0x02000C70
	.asciz "[SDK+NINTENDO:BACKUP]"

	.bss

.public CARDi_EnableFlag
CARDi_EnableFlag: // 0x0215007C
    .space 0x04

.public _02150080
_02150080: // 0x02150080
	.space 0x8C8

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
