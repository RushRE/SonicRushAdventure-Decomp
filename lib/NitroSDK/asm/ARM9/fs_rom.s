	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start FS_CreateFileFromRom
FS_CreateFileFromRom: // 0x020EB898
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov lr, r1
	mov r3, r2
	ldr ip, _020EB8CC // =0x0000FFFF
	ldr r1, _020EB8D0 // =fs_rom_archive
	mov r2, lr
	add r3, lr, r3
	str ip, [sp]
	bl FS_OpenFileDirect
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EB8CC: .word 0x0000FFFF
_020EB8D0: .word fs_rom_archive
	arm_func_end FS_CreateFileFromRom

	arm_func_start FS_TryLoadTable
FS_TryLoadTable: // 0x020EB8D4
	ldr ip, _020EB8EC // =FS_LoadArchiveTables
	mov r3, r0
	mov r2, r1
	ldr r0, _020EB8F0 // =fs_rom_archive
	mov r1, r3
	bx ip
	.align 2, 0
_020EB8EC: .word FS_LoadArchiveTables
_020EB8F0: .word fs_rom_archive
	arm_func_end FS_TryLoadTable

	arm_func_start FS_SetDefaultDMA
FS_SetDefaultDMA: // 0x020EB8F4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl OS_DisableInterrupts
	mov r5, r0
	ldr r1, _020EB940 // =fsi_default_dma_no
	ldr r0, _020EB944 // =fs_rom_archive
	ldr r4, [r1]
	bl FS_SuspendArchive
	ldr r1, _020EB940 // =fsi_default_dma_no
	cmp r0, #0
	str r6, [r1]
	beq _020EB92C
	ldr r0, _020EB944 // =fs_rom_archive
	bl FS_ResumeArchive
_020EB92C:
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020EB940: .word fsi_default_dma_no
_020EB944: .word fs_rom_archive
	arm_func_end FS_SetDefaultDMA

	arm_func_start FSi_InitRom
FSi_InitRom: // 0x020EB948
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	ldr r1, _020EBAAC // =fsi_default_dma_no
	str r0, [r1]
	bl OS_GetLockID
	ldr r3, _020EBAB0 // =fsi_card_lock_id
	ldr r2, _020EBAB4 // =fsi_ovt9
	mov ip, #0
	ldr r1, _020EBAB8 // =fsi_ovt7
	str r0, [r3]
	str ip, [r2]
	str ip, [r2, #4]
	str ip, [r1]
	str ip, [r1, #4]
	bl CARD_Init
	ldr r0, _020EBABC // =fs_rom_archive
	bl FS_InitArchive
	ldr r0, _020EBABC // =fs_rom_archive
	ldr r1, _020EBAC0 // =aRom
	mov r2, #3
	bl FS_RegisterArchiveName
	ldr r0, _020EBAC4 // =0x027FFC40
	ldrh r0, [r0]
	cmp r0, #2
	bne _020EBA10
	ldr ip, _020EBAB4 // =fsi_ovt9
	mvn r2, #0
	ldr r3, _020EBAB8 // =fsi_ovt7
	mov lr, #0
	ldr r0, _020EBABC // =fs_rom_archive
	ldr r1, _020EBAC8 // =FSi_EmptyArchiveProc
	str r2, [ip]
	str lr, [ip, #4]
	str r2, [r3]
	str lr, [r3, #4]
	bl FS_SetArchiveProc
	mov r1, #0
	str r1, [sp]
	ldr r0, _020EBACC // =FSi_ReadDummyCallback
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr ip, _020EBAD0 // =FSi_WriteDummyCallback
	ldr r0, _020EBABC // =fs_rom_archive
	mov r2, r1
	mov r3, r1
	str ip, [sp, #0xc]
	bl FS_LoadArchive
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, lr}
	bx lr
_020EBA10:
	ldr r5, _020EBAD4 // =0x027FFE40
	ldr r0, _020EBABC // =fs_rom_archive
	ldr r1, _020EBAD8 // =FSi_RomArchiveProc
	ldr r2, _020EBADC // =0x00000602
	ldr r4, _020EBAE0 // =0x027FFE48
	bl FS_SetArchiveProc
	ldr r1, [r5]
	mvn r0, #0
	cmp r1, r0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	cmp r1, #0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldr r2, [r4]
	cmp r2, r0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	cmp r2, #0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	str r1, [sp]
	ldr r0, [r5, #4]
	ldr r1, _020EBAE4 // =FSi_ReadRomCallback
	str r0, [sp, #4]
	ldr r0, _020EBAD0 // =FSi_WriteDummyCallback
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	ldr r3, [r4, #4]
	ldr r0, _020EBABC // =fs_rom_archive
	mov r1, #0
	bl FS_LoadArchive
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020EBAAC: .word fsi_default_dma_no
_020EBAB0: .word fsi_card_lock_id
_020EBAB4: .word fsi_ovt9
_020EBAB8: .word fsi_ovt7
_020EBABC: .word fs_rom_archive
_020EBAC0: .word aRom
_020EBAC4: .word 0x027FFC40
_020EBAC8: .word FSi_EmptyArchiveProc
_020EBACC: .word FSi_ReadDummyCallback
_020EBAD0: .word FSi_WriteDummyCallback
_020EBAD4: .word 0x027FFE40
_020EBAD8: .word FSi_RomArchiveProc
_020EBADC: .word 0x00000602
_020EBAE0: .word 0x027FFE48
_020EBAE4: .word FSi_ReadRomCallback
	arm_func_end FSi_InitRom

	arm_func_start FSi_EmptyArchiveProc
FSi_EmptyArchiveProc: // 0x020EBAE8
	mov r0, #4
	bx lr
	arm_func_end FSi_EmptyArchiveProc

	arm_func_start FSi_ReadDummyCallback
FSi_ReadDummyCallback: // 0x020EBAF0
	mov r0, #1
	bx lr
	arm_func_end FSi_ReadDummyCallback

	arm_func_start FSi_RomArchiveProc
FSi_RomArchiveProc: // 0x020EBAF8
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r1, #1
	beq _020EBB64
	cmp r1, #9
	beq _020EBB1C
	cmp r1, #0xa
	beq _020EBB40
	b _020EBB74
_020EBB1C:
	ldr r0, _020EBB84 // =fsi_card_lock_id
	ldr r0, [r0]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl CARD_LockRom
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {lr}
	bx lr
_020EBB40:
	ldr r0, _020EBB84 // =fsi_card_lock_id
	ldr r0, [r0]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl CARD_UnlockRom
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {lr}
	bx lr
_020EBB64:
	add sp, sp, #4
	mov r0, #4
	ldmia sp!, {lr}
	bx lr
_020EBB74:
	mov r0, #8
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EBB84: .word fsi_card_lock_id
	arm_func_end FSi_RomArchiveProc

	arm_func_start FSi_WriteDummyCallback
FSi_WriteDummyCallback: // 0x020EBB88
	mov r0, #1
	bx lr
	arm_func_end FSi_WriteDummyCallback

	arm_func_start FSi_ReadRomCallback
FSi_ReadRomCallback: // 0x020EBB90
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr ip, _020EBBD4 // =FSi_OnRomReadDone
	mov lr, r1
	str ip, [sp]
	str r0, [sp, #4]
	mov r1, #1
	ldr r0, _020EBBD8 // =fsi_default_dma_no
	str r1, [sp, #8]
	mov r1, r2
	ldr r0, [r0]
	mov r2, lr
	bl CARDi_ReadRom
	mov r0, #6
	add sp, sp, #0xc
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EBBD4: .word FSi_OnRomReadDone
_020EBBD8: .word fsi_default_dma_no
	arm_func_end FSi_ReadRomCallback

	arm_func_start FSi_OnRomReadDone
FSi_OnRomReadDone: // 0x020EBBDC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl CARD_IsPulledOut
	cmp r0, #0
	movne r1, #5
	moveq r1, #0
	mov r0, r4
	bl FS_NotifyArchiveAsyncEnd
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end FSi_OnRomReadDone

	.data

aRom: // 0x0211F794
	.asciz "rom"