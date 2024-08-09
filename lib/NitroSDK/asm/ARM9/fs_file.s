	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start FSi_SendCommand
FSi_SendCommand: // 0x020EAD1C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r6, [r7, #8]
	mov r2, #1
	str r1, [r7, #0x10]
	mov r0, #2
	str r0, [r7, #0x14]
	ldr r0, [r7, #0xc]
	mov r5, r2, lsl r1
	orr r0, r0, #1
	str r0, [r7, #0xc]
	bl OS_DisableInterrupts
	ldr r1, [r6, #0x1c]
	mov r4, r0
	ands r0, r1, #0x80
	beq _020EAD84
	mov r0, r7
	mov r1, #3
	bl FSi_ReleaseCommand
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020EAD84:
	ands r0, r5, #0x1fc
	ldrne r0, [r7, #0xc]
	add r2, r6, #0x20
	orrne r0, r0, #4
	strne r0, [r7, #0xc]
	ldr r1, [r7]
	ldr r0, [r7, #4]
	cmp r1, #0
	strne r0, [r1, #4]
	cmp r0, #0
	strne r1, [r0]
	ldr r0, [r2, #4]
	cmp r0, #0
	beq _020EADCC
_020EADBC:
	mov r2, r0
	ldr r0, [r0, #4]
	cmp r0, #0
	bne _020EADBC
_020EADCC:
	str r7, [r2, #4]
	str r2, [r7]
	mov r1, #0
	str r1, [r7, #4]
	ldr r0, [r6, #0x1c]
	ands r0, r0, #8
	movne r1, #1
	cmp r1, #0
	bne _020EAE78
	ldr r0, [r6, #0x1c]
	ands r0, r0, #0x10
	bne _020EAE78
	ldr r1, [r6, #0x1c]
	mov r0, r4
	orr r1, r1, #0x10
	str r1, [r6, #0x1c]
	bl OS_RestoreInterrupts
	ldr r0, [r6, #0x58]
	ands r0, r0, #0x200
	beq _020EAE2C
	ldr r2, [r6, #0x54]
	mov r0, r7
	mov r1, #9
	blx r2
_020EAE2C:
	bl OS_DisableInterrupts
	ldr r1, [r7, #0xc]
	orr r1, r1, #0x40
	str r1, [r7, #0xc]
	ldr r1, [r7, #0xc]
	ands r1, r1, #4
	movne r1, #1
	moveq r1, #0
	cmp r1, #0
	bne _020EAE70
	bl OS_RestoreInterrupts
	mov r0, r7
	bl FSi_ExecuteAsyncCommand
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020EAE70:
	bl OS_RestoreInterrupts
	b _020EAEC4
_020EAE78:
	ldr r0, [r7, #0xc]
	ands r0, r0, #4
	movne r0, #1
	moveq r0, #0
	cmp r0, #0
	bne _020EAEA8
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020EAEA8:
	add r0, r7, #0x18
	bl OS_SleepThread
	ldr r0, [r7, #0xc]
	ands r0, r0, #0x40
	beq _020EAEA8
	mov r0, r4
	bl OS_RestoreInterrupts
_020EAEC4:
	mov r0, r7
	bl FSi_ExecuteSyncCommand
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end FSi_SendCommand

	arm_func_start FSi_ExecuteSyncCommand
FSi_ExecuteSyncCommand: // 0x020EAED8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x10]
	bl FSi_TranslateCommand
	mov r1, r0
	mov r0, r4
	bl FSi_ReleaseCommand
	ldr r0, [r4, #8]
	bl FSi_NextCommand
	cmp r0, #0
	beq _020EAF08
	bl FSi_ExecuteAsyncCommand
_020EAF08:
	ldr r0, [r4, #0x14]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end FSi_ExecuteSyncCommand

	arm_func_start FSi_ExecuteAsyncCommand
FSi_ExecuteAsyncCommand: // 0x020EAF20
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	movs r6, r0
	ldr r5, [r6, #8]
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	mov r7, #0
	mov r8, #1
_020EAF3C:
	bl OS_DisableInterrupts
	ldr r1, [r6, #0xc]
	mov r4, r0
	orr r0, r1, #0x40
	str r0, [r6, #0xc]
	ldr r0, [r6, #0xc]
	ands r0, r0, #4
	movne r0, r8
	moveq r0, r7
	cmp r0, #0
	beq _020EAF80
	add r0, r6, #0x18
	bl OS_WakeupThread
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020EAF80:
	ldr r1, [r6, #0xc]
	mov r0, r4
	orr r1, r1, #8
	str r1, [r6, #0xc]
	bl OS_RestoreInterrupts
	ldr r1, [r6, #0x10]
	mov r0, r6
	bl FSi_TranslateCommand
	cmp r0, #6
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	mov r0, r5
	bl FSi_NextCommand
	movs r6, r0
	bne _020EAF3C
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end FSi_ExecuteAsyncCommand

	arm_func_start FSi_NextCommand
FSi_NextCommand: // 0x020EAFC4
	stmdb sp!, {r4, r5, r6, r7, r8, sb, lr}
	sub sp, sp, #0x4c
	mov r6, r0
	bl OS_DisableInterrupts
	ldr r1, [r6, #0x1c]
	mov r5, r0
	ands r0, r1, #0x20
	beq _020EB04C
	ldr r0, [r6, #0x1c]
	bic r0, r0, #0x20
	str r0, [r6, #0x1c]
	ldr r0, [r6, #0x24]
	cmp r0, #0
	beq _020EB04C
	mov r8, #0
	mov sb, #1
	mov r7, #3
_020EB008:
	ldr r1, [r0, #0xc]
	ldr r4, [r0, #4]
	ands r1, r1, #2
	movne r1, sb
	moveq r1, r8
	cmp r1, #0
	beq _020EB040
	ldr r1, [r6, #0x24]
	cmp r1, r0
	mov r1, r7
	streq r4, [r6, #0x24]
	bl FSi_ReleaseCommand
	cmp r4, #0
	ldreq r4, [r6, #0x24]
_020EB040:
	mov r0, r4
	cmp r4, #0
	bne _020EB008
_020EB04C:
	ldr r0, [r6, #0x1c]
	ands r0, r0, #0x40
	bne _020EB138
	ldr r0, [r6, #0x1c]
	ands r0, r0, #8
	movne r0, #1
	moveq r0, #0
	cmp r0, #0
	bne _020EB138
	ldr r4, [r6, #0x24]
	cmp r4, #0
	beq _020EB138
	ldr r0, [r6, #0x1c]
	ands r0, r0, #0x10
	movne r0, #1
	moveq r0, #0
	cmp r0, #0
	moveq r7, #1
	movne r7, #0
	cmp r7, #0
	ldrne r0, [r6, #0x1c]
	orrne r0, r0, #0x10
	strne r0, [r6, #0x1c]
	mov r0, r5
	bl OS_RestoreInterrupts
	cmp r7, #0
	beq _020EB0D4
	ldr r0, [r6, #0x58]
	ands r0, r0, #0x200
	beq _020EB0D4
	ldr r2, [r6, #0x54]
	mov r0, r4
	mov r1, #9
	blx r2
_020EB0D4:
	bl OS_DisableInterrupts
	ldr r1, [r4, #0xc]
	mov r5, r0
	orr r0, r1, #0x40
	str r0, [r4, #0xc]
	ldr r0, [r4, #0xc]
	ands r0, r0, #4
	movne r0, #1
	moveq r0, #0
	cmp r0, #0
	beq _020EB120
	add r0, r4, #0x18
	bl OS_WakeupThread
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #0x4c
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, sb, lr}
	bx lr
_020EB120:
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #0x4c
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, sb, lr}
	bx lr
_020EB138:
	ldr r0, [r6, #0x1c]
	ands r0, r0, #0x10
	beq _020EB178
	ldr r0, [r6, #0x1c]
	bic r0, r0, #0x10
	str r0, [r6, #0x1c]
	ldr r0, [r6, #0x58]
	ands r0, r0, #0x400
	beq _020EB178
	add r0, sp, #0
	bl FS_InitFile
	str r6, [sp, #8]
	ldr r2, [r6, #0x54]
	add r0, sp, #0
	mov r1, #0xa
	blx r2
_020EB178:
	ldr r0, [r6, #0x1c]
	ands r0, r0, #0x40
	beq _020EB1A4
	ldr r1, [r6, #0x1c]
	add r0, r6, #0x14
	bic r1, r1, #0x40
	str r1, [r6, #0x1c]
	ldr r1, [r6, #0x1c]
	orr r1, r1, #8
	str r1, [r6, #0x1c]
	bl OS_WakeupThread
_020EB1A4:
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, #0
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, r6, r7, r8, sb, lr}
	bx lr
	arm_func_end FSi_NextCommand

	arm_func_start FSi_ReadMemoryCore
FSi_ReadMemoryCore: // 0x020EB1BC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, r2
	mov r2, r3
	bl MI_CpuCopy8
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end FSi_ReadMemoryCore

	arm_func_start FSi_WriteMemCallback
FSi_WriteMemCallback: // 0x020EB1E0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr ip, [r0, #0x28]
	mov r0, r1
	add r1, ip, r2
	mov r2, r3
	bl MI_CpuCopy8
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end FSi_WriteMemCallback

	arm_func_start FSi_ReadMemCallback
FSi_ReadMemCallback: // 0x020EB20C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, [r0, #0x28]
	add r0, r0, r2
	mov r2, r3
	bl MI_CpuCopy8
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end FSi_ReadMemCallback

	arm_func_start FSi_GetPackedName
FSi_GetPackedName: // 0x020EB234
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r1, #3
	mov lr, #0
	bgt _020EB288
	mov ip, lr
	cmp r1, #0
	ble _020EB288
	mov r3, lr
_020EB258:
	ldrb r2, [r0, ip]
	cmp r2, #0
	beq _020EB288
	sub r2, r2, #0x41
	cmp r2, #0x19
	addls r2, r2, #0x61
	addhi r2, r2, #0x41
	add ip, ip, #1
	orr lr, lr, r2, lsl r3
	cmp ip, r1
	add r3, r3, #8
	blt _020EB258
_020EB288:
	mov r0, lr
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end FSi_GetPackedName

	arm_func_start FS_ChangeDir
FS_ChangeDir: // 0x020EB298
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x58
	mov r4, r0
	add r0, sp, #0xc
	bl FS_InitFile
	add r0, sp, #0xc
	add r3, sp, #0
	mov r1, r4
	mov r2, #0
	bl FSi_FindPath
	cmp r0, #0
	moveq r0, #0
	addne r0, sp, #0
	ldrne r3, _020EB2E8 // =current_dir_pos
	ldmneia r0, {r0, r1, r2}
	stmneia r3, {r0, r1, r2}
	movne r0, #1
	add sp, sp, #0x58
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020EB2E8: .word current_dir_pos
	arm_func_end FS_ChangeDir

	arm_func_start FS_SeekFile
FS_SeekFile: // 0x020EB2EC
	cmp r2, #0
	beq _020EB308
	cmp r2, #1
	beq _020EB314
	cmp r2, #2
	beq _020EB320
	b _020EB32C
_020EB308:
	ldr r2, [r0, #0x24]
	add r1, r1, r2
	b _020EB334
_020EB314:
	ldr r2, [r0, #0x2c]
	add r1, r1, r2
	b _020EB334
_020EB320:
	ldr r2, [r0, #0x28]
	add r1, r1, r2
	b _020EB334
_020EB32C:
	mov r0, #0
	bx lr
_020EB334:
	ldr r2, [r0, #0x24]
	cmp r1, r2
	movlt r1, r2
	ldr r2, [r0, #0x28]
	cmp r1, r2
	movgt r1, r2
	str r1, [r0, #0x2c]
	mov r0, #1
	bx lr
	arm_func_end FS_SeekFile

	arm_func_start FS_ReadFile
FS_ReadFile: // 0x020EB358
	ldr ip, _020EB364 // =FSi_ReadFileCore
	mov r3, #0
	bx ip
	.align 2, 0
_020EB364: .word FSi_ReadFileCore
	arm_func_end FS_ReadFile

	arm_func_start FS_ReadFileAsync
FS_ReadFileAsync: // 0x020EB368
	ldr ip, _020EB374 // =FSi_ReadFileCore
	mov r3, #1
	bx ip
	.align 2, 0
_020EB374: .word FSi_ReadFileCore
	arm_func_end FS_ReadFileAsync

	arm_func_start FS_CancelFile
FS_CancelFile: // 0x020EB378
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r1, [r4, #0xc]
	ands r1, r1, #1
	movne r1, #1
	moveq r1, #0
	cmp r1, #0
	beq _020EB3B8
	ldr r1, [r4, #0xc]
	orr r1, r1, #2
	str r1, [r4, #0xc]
	ldr r2, [r4, #8]
	ldr r1, [r2, #0x1c]
	orr r1, r1, #0x20
	str r1, [r2, #0x1c]
_020EB3B8:
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end FS_CancelFile

	arm_func_start FS_WaitAsync
FS_WaitAsync: // 0x020EB3C4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	mov r5, #0
	bl OS_DisableInterrupts
	ldr r1, [r6, #0xc]
	mov r4, r0
	ands r0, r1, #1
	movne r0, #1
	moveq r0, r5
	cmp r0, #0
	beq _020EB454
	ldr r0, [r6, #0xc]
	ands r0, r0, #0x44
	moveq r5, #1
	movne r5, #0
	cmp r5, #0
	beq _020EB434
	ldr r0, [r6, #0xc]
	orr r0, r0, #4
	str r0, [r6, #0xc]
	add r7, r6, #0x18
_020EB41C:
	mov r0, r7
	bl OS_SleepThread
	ldr r0, [r6, #0xc]
	ands r0, r0, #0x40
	beq _020EB41C
	b _020EB454
_020EB434:
	add r0, r6, #0x18
	bl OS_SleepThread
	ldr r0, [r6, #0xc]
	ands r0, r0, #1
	movne r0, #1
	moveq r0, #0
	cmp r0, #0
	bne _020EB434
_020EB454:
	mov r0, r4
	bl OS_RestoreInterrupts
	cmp r5, #0
	beq _020EB478
	mov r0, r6
	bl FSi_ExecuteSyncCommand
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020EB478:
	ldr r0, [r6, #0x14]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end FS_WaitAsync

	arm_func_start FS_CloseFile
FS_CloseFile: // 0x020EB494
	stmdb sp!, {r4, lr}
	mov r1, #8
	mov r4, r0
	bl FSi_SendCommand
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	mov r0, #0
	str r0, [r4, #8]
	mov r0, #0xe
	str r0, [r4, #0x10]
	ldr r1, [r4, #0xc]
	mov r0, #1
	bic r1, r1, #0x30
	str r1, [r4, #0xc]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end FS_CloseFile

	arm_func_start FS_OpenFile
FS_OpenFile: // 0x020EB4DC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, sp, #0
	bl FS_ConvertPathToFileID
	cmp r0, #0
	beq _020EB51C
	add r1, sp, #0
	mov r0, r4
	ldmia r1, {r1, r2}
	bl FS_OpenFileFast
	cmp r0, #0
	addne sp, sp, #8
	movne r0, #1
	ldmneia sp!, {r4, lr}
	bxne lr
_020EB51C:
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end FS_OpenFile

	arm_func_start FS_OpenFileFast
FS_OpenFileFast: // 0x020EB52C
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, lr}
	ldr r1, [sp, #0xc]
	mov r4, r0
	cmp r1, #0
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	addeq sp, sp, #0x10
	bxeq lr
	str r1, [r4, #8]
	ldr r3, [sp, #0xc]
	ldr r2, [sp, #0x10]
	mov r1, #6
	str r3, [r4, #0x30]
	str r2, [r4, #0x34]
	bl FSi_SendCommand
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	addeq sp, sp, #0x10
	bxeq lr
	ldr r1, [r4, #0xc]
	mov r0, #1
	orr r1, r1, #0x10
	str r1, [r4, #0xc]
	ldr r1, [r4, #0xc]
	bic r1, r1, #0x20
	str r1, [r4, #0xc]
	ldmia sp!, {r4, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end FS_OpenFileFast

	arm_func_start FS_OpenFileDirect
FS_OpenFileDirect: // 0x020EB5A8
	stmdb sp!, {r4, lr}
	mov r4, r0
	str r1, [r4, #8]
	ldr ip, [sp, #8]
	mov r1, #7
	str ip, [r4, #0x38]
	str r2, [r4, #0x30]
	str r3, [r4, #0x34]
	bl FSi_SendCommand
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r1, [r4, #0xc]
	mov r0, #1
	orr r1, r1, #0x10
	str r1, [r4, #0xc]
	ldr r1, [r4, #0xc]
	bic r1, r1, #0x20
	str r1, [r4, #0xc]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end FS_OpenFileDirect

	arm_func_start FS_ConvertPathToFileID
FS_ConvertPathToFileID: // 0x020EB600
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x4c
	mov r5, r0
	add r0, sp, #0
	mov r4, r1
	bl FS_InitFile
	add r0, sp, #0
	mov r1, r4
	mov r2, r5
	mov r3, #0
	bl FSi_FindPath
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end FS_ConvertPathToFileID

	arm_func_start FSi_ReadFileCore
FSi_ReadFileCore: // 0x020EB644
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r4, [r7, #0x2c]
	ldr r0, [r7, #0x28]
	mov r6, r2
	str r1, [r7, #0x30]
	sub r0, r0, r4
	cmp r6, r0
	movgt r6, r0
	cmp r6, #0
	movlt r6, #0
	str r2, [r7, #0x34]
	mov r5, r3
	str r6, [r7, #0x38]
	cmp r5, #0
	ldreq r0, [r7, #0xc]
	mov r1, #0
	orreq r0, r0, #4
	streq r0, [r7, #0xc]
	mov r0, r7
	bl FSi_SendCommand
	cmp r5, #0
	bne _020EB6BC
	mov r0, r7
	bl FS_WaitAsync
	cmp r0, #0
	ldrne r0, [r7, #0x2c]
	subne r6, r0, r4
	mvneq r6, #0
_020EB6BC:
	mov r0, r6
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end FSi_ReadFileCore

	arm_func_start FSi_FindPath
FSi_FindPath: // 0x020EB6CC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r7, r1
	ldrb r1, [r7]
	mov r8, r0
	mov r6, r2
	mov r5, r3
	cmp r1, #0x2f
	beq _020EB6F8
	cmp r1, #0x5c
	bne _020EB71C
_020EB6F8:
	ldr r0, _020EB828 // =current_dir_pos
	mov r1, #0
	ldr r0, [r0]
	strh r1, [sp, #4]
	str r0, [sp]
	str r1, [sp, #8]
	strh r1, [sp, #6]
	add r7, r7, #1
	b _020EB7D8
_020EB71C:
	ldr r0, _020EB828 // =current_dir_pos
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r4, #0
_020EB730:
	ldrb r0, [r7, r4]
	cmp r0, #0
	beq _020EB7D8
	cmp r0, #0x2f
	beq _020EB7D8
	cmp r0, #0x5c
	beq _020EB7D8
	cmp r0, #0x3a
	bne _020EB7CC
	mov r0, r7
	mov r1, r4
	bl FS_FindArchive
	cmp r0, #0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	ldr r1, [r0, #0x1c]
	ands r1, r1, #2
	movne r1, #1
	moveq r1, #0
	cmp r1, #0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #8]
	strh r1, [sp, #6]
	strh r1, [sp, #4]
	add r0, r4, #1
	ldrb r0, [r7, r0]!
	cmp r0, #0x2f
	beq _020EB7C4
	cmp r0, #0x5c
	bne _020EB7D8
_020EB7C4:
	add r7, r7, #1
	b _020EB7D8
_020EB7CC:
	add r4, r4, #1
	cmp r4, #3
	ble _020EB730
_020EB7D8:
	ldr r1, [sp]
	add r0, sp, #0
	str r1, [r8, #8]
	str r7, [r8, #0x3c]
	add r3, r8, #0x30
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	cmp r5, #0
	movne r0, #1
	strne r0, [r8, #0x40]
	strne r5, [r8, #0x44]
	moveq r0, #0
	streq r0, [r8, #0x40]
	mov r0, r8
	mov r1, #4
	streq r6, [r8, #0x44]
	bl FSi_SendCommand
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020EB828: .word current_dir_pos
	arm_func_end FSi_FindPath

	arm_func_start FS_InitFile
FS_InitFile: // 0x020EB82C
	mov r3, #0
	str r3, [r0]
	ldr r2, [r0]
	mov r1, #0xe
	str r2, [r0, #4]
	str r3, [r0, #0x1c]
	ldr r2, [r0, #0x1c]
	str r2, [r0, #0x18]
	str r3, [r0, #8]
	str r1, [r0, #0x10]
	str r3, [r0, #0xc]
	bx lr
	arm_func_end FS_InitFile

	arm_func_start FS_Init
FS_Init: // 0x020EB85C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020EB894 // =FS_is_init
	ldr r2, [r1]
	cmp r2, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	mov r2, #1
	str r2, [r1]
	bl FSi_InitRom
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020EB894: .word FS_is_init
	arm_func_end FS_Init