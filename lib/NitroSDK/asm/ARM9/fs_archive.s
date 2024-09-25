	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
.public arc_list
arc_list: // 0x0214FF08
    .space 0x04

.public current_dir_pos
current_dir_pos: // current_dir_pos
    .space 0x0C // FSDirPos

.public FS_is_init
FS_is_init: // 0x0214FF18
    .space 0x04

.public fsi_card_lock_id
fsi_card_lock_id: // 0x0214FF1C
    .space 0x04

.public fsi_default_dma_no
fsi_default_dma_no: // 0x0214FF20
    .space 0x04

.public fsi_ovt9
fsi_ovt9: // 0x0214FF24
    .space 0x08 // CARDRomRegion

.public fsi_ovt7
fsi_ovt7: // 0x0214FF2C
    .space 0x08 // CARDRomRegion

.public fs_rom_archive
fs_rom_archive: // 0x0214FF34
    .space 0x5C // FSArchive

	.text

	arm_func_start FS_NotifyArchiveAsyncEnd
FS_NotifyArchiveAsyncEnd: // 0x020EA68C
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r0, [r4, #0x1c]
	mov r6, r1
	ands r0, r0, #0x100
	beq _020EA6D8
	ldr r2, [r4, #0x1c]
	ldr r0, [r4, #0x24]
	bic r2, r2, #0x100
	str r2, [r4, #0x1c]
	bl FSi_ReleaseCommand
	mov r0, r4
	bl FSi_NextCommand
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	bl FSi_ExecuteAsyncCommand
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020EA6D8:
	ldr r5, [r4, #0x24]
	bl OS_DisableInterrupts
	str r6, [r5, #0x14]
	ldr r1, [r4, #0x1c]
	mov r5, r0
	bic r1, r1, #0x200
	add r0, r4, #0xc
	str r1, [r4, #0x1c]
	bl OS_WakeupThread
	mov r0, r5
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end FS_NotifyArchiveAsyncEnd

	arm_func_start FS_SetArchiveProc
FS_SetArchiveProc: // 0x020EA70C
	cmp r2, #0
	moveq r1, #0
	beq _020EA720
	cmp r1, #0
	moveq r2, #0
_020EA720:
	str r1, [r0, #0x54]
	str r2, [r0, #0x58]
	bx lr
	arm_func_end FS_SetArchiveProc

	arm_func_start FS_ResumeArchive
FS_ResumeArchive: // 0x020EA72C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r6, #0
	bl OS_DisableInterrupts
	ldr r1, [r4, #0x1c]
	mov r5, r0
	ands r0, r1, #8
	movne r0, #1
	moveq r0, r6
	cmp r0, #0
	moveq r7, #1
	movne r7, #0
	cmp r7, #0
	bne _020EA780
	ldr r1, [r4, #0x1c]
	mov r0, r4
	bic r1, r1, #8
	str r1, [r4, #0x1c]
	bl FSi_NextCommand
	mov r6, r0
_020EA780:
	mov r0, r5
	bl OS_RestoreInterrupts
	cmp r6, #0
	beq _020EA798
	mov r0, r6
	bl FSi_ExecuteAsyncCommand
_020EA798:
	mov r0, r7
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end FS_ResumeArchive

	arm_func_start FS_SuspendArchive
FS_SuspendArchive: // 0x020EA7A8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	bl OS_DisableInterrupts
	ldr r1, [r6, #0x1c]
	mov r4, r0
	ands r0, r1, #8
	movne r0, #1
	moveq r0, #0
	cmp r0, #0
	moveq r5, #1
	movne r5, #0
	cmp r5, #0
	beq _020EA820
	ldr r0, [r6, #0x1c]
	ands r0, r0, #0x10
	beq _020EA814
	ldr r0, [r6, #0x1c]
	orr r0, r0, #0x40
	str r0, [r6, #0x1c]
	add r7, r6, #0x14
_020EA7FC:
	mov r0, r7
	bl OS_SleepThread
	ldr r0, [r6, #0x1c]
	ands r0, r0, #0x40
	bne _020EA7FC
	b _020EA820
_020EA814:
	ldr r0, [r6, #0x1c]
	orr r0, r0, #8
	str r0, [r6, #0x1c]
_020EA820:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end FS_SuspendArchive

	arm_func_start FS_UnloadArchiveTables
FS_UnloadArchiveTables: // 0x020EA838
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, [r5, #0x1c]
	mov r4, #0
	ands r0, r0, #2
	movne r0, #1
	moveq r0, r4
	cmp r0, #0
	beq _020EA8C0
	mov r0, r5
	bl FS_SuspendArchive
	ldr r1, [r5, #0x1c]
	ands r1, r1, #4
	movne r1, #1
	moveq r1, #0
	cmp r1, #0
	beq _020EA8B0
	ldr r2, [r5, #0x1c]
	mov r1, #0
	bic r2, r2, #4
	str r2, [r5, #0x1c]
	ldr r4, [r5, #0x44]
	str r1, [r5, #0x44]
	ldr r1, [r5, #0x3c]
	str r1, [r5, #0x2c]
	ldr r1, [r5, #0x40]
	str r1, [r5, #0x34]
	ldr r1, [r5, #0x48]
	str r1, [r5, #0x50]
_020EA8B0:
	cmp r0, #0
	beq _020EA8C0
	mov r0, r5
	bl FS_ResumeArchive
_020EA8C0:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end FS_UnloadArchiveTables

	arm_func_start FS_LoadArchiveTables
FS_LoadArchiveTables: // 0x020EA8D0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x4c
	mov r7, r0
	ldr r3, [r7, #0x30]
	ldr r0, [r7, #0x38]
	mov r6, r1
	add r0, r3, r0
	add r0, r0, #0x20
	add r0, r0, #0x1f
	bic r5, r0, #0x1f
	cmp r5, r2
	bhi _020EA9E8
	add r1, r6, #0x1f
	add r0, sp, #4
	bic r4, r1, #0x1f
	bl FS_InitFile
	ldr r2, [r7, #0x2c]
	mvn r0, #0
	str r0, [sp]
	ldr r3, [r7, #0x30]
	add r0, sp, #4
	mov r1, r7
	add r3, r2, r3
	bl FS_OpenFileDirect
	cmp r0, #0
	beq _020EA968
	ldr r2, [r7, #0x30]
	add r0, sp, #4
	mov r1, r4
	bl FS_ReadFile
	cmp r0, #0
	bge _020EA960
	ldr r2, [r7, #0x30]
	mov r0, r4
	mov r1, #0
	bl MI_CpuFill8
_020EA960:
	add r0, sp, #4
	bl FS_CloseFile
_020EA968:
	str r4, [r7, #0x2c]
	ldr ip, [r7, #0x30]
	ldr r2, [r7, #0x34]
	mvn r0, #0
	str r0, [sp]
	ldr r3, [r7, #0x38]
	add r0, sp, #4
	mov r1, r7
	add r3, r2, r3
	add r4, r4, ip
	bl FS_OpenFileDirect
	cmp r0, #0
	beq _020EA9CC
	ldr r2, [r7, #0x38]
	add r0, sp, #4
	mov r1, r4
	bl FS_ReadFile
	cmp r0, #0
	bge _020EA9C4
	ldr r2, [r7, #0x38]
	mov r0, r4
	mov r1, #0
	bl MI_CpuFill8
_020EA9C4:
	add r0, sp, #4
	bl FS_CloseFile
_020EA9CC:
	str r4, [r7, #0x34]
	ldr r0, _020EA9F8 // =FSi_ReadMemoryCore
	str r6, [r7, #0x44]
	str r0, [r7, #0x50]
	ldr r0, [r7, #0x1c]
	orr r0, r0, #4
	str r0, [r7, #0x1c]
_020EA9E8:
	mov r0, r5
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020EA9F8: .word FSi_ReadMemoryCore
	arm_func_end FS_LoadArchiveTables

	arm_func_start FS_UnloadArchive
FS_UnloadArchive: // 0x020EA9FC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r1, [r5, #0x1c]
	mov r4, r0
	ands r0, r1, #2
	movne r0, #1
	moveq r0, #0
	cmp r0, #0
	beq _020EAAB0
	mov r0, r5
	ldr r1, [r5, #0x1c]
	bl FS_SuspendArchive
	ldr r1, [r5, #0x1c]
	mov r7, r0
	orr r0, r1, #0x80
	str r0, [r5, #0x1c]
	ldr r0, [r5, #0x24]
	cmp r0, #0
	beq _020EAA68
	mov r6, #3
_020EAA50:
	ldr r8, [r0, #4]
	mov r1, r6
	bl FSi_ReleaseCommand
	mov r0, r8
	cmp r8, #0
	bne _020EAA50
_020EAA68:
	mov r0, #0
	str r0, [r5, #0x24]
	cmp r7, #0
	beq _020EAA80
	mov r0, r5
	bl FS_ResumeArchive
_020EAA80:
	mov r0, #0
	str r0, [r5, #0x28]
	str r0, [r5, #0x2c]
	str r0, [r5, #0x30]
	str r0, [r5, #0x34]
	str r0, [r5, #0x38]
	str r0, [r5, #0x40]
	ldr r0, [r5, #0x40]
	str r0, [r5, #0x3c]
	ldr r0, [r5, #0x1c]
	bic r0, r0, #0xa2
	str r0, [r5, #0x1c]
_020EAAB0:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end FS_UnloadArchive

	arm_func_start FS_LoadArchive
FS_LoadArchive: // 0x020EAAC4
	str r1, [r0, #0x28]
	str r3, [r0, #0x30]
	str r2, [r0, #0x3c]
	ldr r1, [r0, #0x3c]
	ldr r2, [sp, #4]
	str r1, [r0, #0x2c]
	str r2, [r0, #0x38]
	ldr r1, [sp]
	ldr r2, [sp, #8]
	str r1, [r0, #0x40]
	ldr r1, [r0, #0x40]
	cmp r2, #0
	str r1, [r0, #0x34]
	ldreq r2, _020EAB34 // =FSi_ReadMemCallback
	ldr r1, [sp, #0xc]
	str r2, [r0, #0x48]
	cmp r1, #0
	ldreq r1, _020EAB38 // =FSi_WriteMemCallback
	str r1, [r0, #0x4c]
	ldr r2, [r0, #0x48]
	mov r1, #0
	str r2, [r0, #0x50]
	str r1, [r0, #0x44]
	ldr r1, [r0, #0x1c]
	orr r1, r1, #2
	str r1, [r0, #0x1c]
	mov r0, #1
	bx lr
	.align 2, 0
_020EAB34: .word FSi_ReadMemCallback
_020EAB38: .word FSi_WriteMemCallback
	arm_func_end FS_LoadArchive

	arm_func_start FS_ReleaseArchiveName
FS_ReleaseArchiveName: // 0x020EAB3C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4]
	cmp r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	bl OS_DisableInterrupts
	ldr r2, [r4, #4]
	mov r3, #0
	cmp r2, #0
	ldrne r1, [r4, #8]
	strne r1, [r2, #8]
	ldr r2, [r4, #8]
	cmp r2, #0
	ldrne r1, [r4, #4]
	strne r1, [r2, #4]
	str r3, [r4]
	str r3, [r4, #8]
	ldr r1, [r4, #8]
	ldr r2, _020EABCC // =current_dir_pos
	str r1, [r4, #4]
	ldr r1, [r4, #0x1c]
	bic r1, r1, #1
	str r1, [r4, #0x1c]
	ldr r1, [r2]
	cmp r1, r4
	bne _020EABC0
	ldr r1, _020EABD0 // =arc_list
	str r3, [r2, #8]
	ldr r1, [r1]
	strh r3, [r2, #6]
	str r1, [r2]
	strh r3, [r2, #4]
_020EABC0:
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020EABCC: .word current_dir_pos
_020EABD0: .word arc_list
	arm_func_end FS_ReleaseArchiveName

	arm_func_start FS_RegisterArchiveName
FS_RegisterArchiveName: // 0x020EABD4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r1
	mov r5, r2
	mov r7, r0
	mov r8, #0
	bl OS_DisableInterrupts
	mov r4, r0
	mov r0, r6
	mov r1, r5
	bl FS_FindArchive
	cmp r0, #0
	bne _020EAC78
	ldr r1, _020EAC8C // =arc_list
	ldr r2, [r1]
	cmp r2, #0
	bne _020EAC34
	ldr r0, _020EAC90 // =current_dir_pos
	mov r2, r8
	str r7, [r1]
	str r7, [r0]
	str r2, [r0, #8]
	strh r2, [r0, #6]
	strh r2, [r0, #4]
	b _020EAC58
_020EAC34:
	ldr r0, [r2, #4]
	cmp r0, #0
	beq _020EAC50
_020EAC40:
	mov r2, r0
	ldr r0, [r0, #4]
	cmp r0, #0
	bne _020EAC40
_020EAC50:
	str r7, [r2, #4]
	str r2, [r7, #8]
_020EAC58:
	mov r0, r6
	mov r1, r5
	bl FSi_GetPackedName
	str r0, [r7]
	ldr r0, [r7, #0x1c]
	mov r8, #1
	orr r0, r0, #1
	str r0, [r7, #0x1c]
_020EAC78:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, r8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020EAC8C: .word arc_list
_020EAC90: .word current_dir_pos
	arm_func_end FS_RegisterArchiveName

	arm_func_start FS_FindArchive
FS_FindArchive: // 0x020EAC94
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl FSi_GetPackedName
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r1, _020EACE0 // =arc_list
	ldr r4, [r1]
	b _020EACB8
_020EACB4:
	ldr r4, [r4, #4]
_020EACB8:
	cmp r4, #0
	beq _020EACCC
	ldr r1, [r4]
	cmp r1, r5
	bne _020EACB4
_020EACCC:
	bl OS_RestoreInterrupts
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020EACE0: .word arc_list
	arm_func_end FS_FindArchive

	arm_func_start FS_InitArchive
FS_InitArchive: // 0x020EACE4
	stmdb sp!, {r4, lr}
	mov r1, #0
	mov r2, #0x5c
	mov r4, r0
	bl MI_CpuFill8
	mov r1, #0
	str r1, [r4, #0x10]
	ldr r0, [r4, #0x10]
	str r0, [r4, #0xc]
	str r1, [r4, #0x18]
	ldr r0, [r4, #0x18]
	str r0, [r4, #0x14]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end FS_InitArchive