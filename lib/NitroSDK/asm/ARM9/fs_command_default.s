	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start FSi_CloseFileCommand
FSi_CloseFileCommand: // 0x020E9C60
	mov r0, #0
	bx lr
	arm_func_end FSi_CloseFileCommand

	arm_func_start FSi_OpenFileDirectCommand
FSi_OpenFileDirectCommand: // 0x020E9C68
	ldr r1, [r0, #0x30]
	str r1, [r0, #0x24]
	ldr r1, [r0, #0x30]
	str r1, [r0, #0x2c]
	ldr r1, [r0, #0x34]
	str r1, [r0, #0x28]
	ldr r1, [r0, #0x38]
	str r1, [r0, #0x20]
	mov r0, #0
	bx lr
	arm_func_end FSi_OpenFileDirectCommand

	arm_func_start FSi_OpenFileFastCommand
FSi_OpenFileFastCommand: // 0x020E9C90
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r5, r0
	ldr r1, [r5, #8]
	ldr r4, [r5, #0x34]
	ldr r0, [r1, #0x30]
	mov r2, r4, lsl #3
	cmp r2, r0
	addhs sp, sp, #0x14
	movhs r0, #1
	ldmhsia sp!, {r4, r5, lr}
	bxhs lr
	str r1, [sp, #8]
	ldr r1, [r1, #0x2c]
	add r0, sp, #8
	add r3, r1, r2
	add r1, sp, #0
	mov r2, #8
	str r3, [sp, #0xc]
	bl FSi_ReadTable
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	ldr r1, [sp]
	mov r0, r5
	str r1, [r5, #0x30]
	ldr r2, [sp, #4]
	mov r1, #7
	str r2, [r5, #0x34]
	str r4, [r5, #0x38]
	bl FSi_TranslateCommand
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end FSi_OpenFileFastCommand

	arm_func_start FSi_GetPathCommand
FSi_GetPathCommand: // 0x020E9D1C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xe4
	mov r4, r0
	ldr r1, [r4, #8]
	add r0, sp, #0x98
	add r11, r4, #0x30
	str r1, [sp]
	bl FS_InitFile
	ldr r0, [r4, #8]
	str r0, [sp, #0xa0]
	ldr r0, [r4, #0xc]
	ands r0, r0, #0x20
	movne r0, #1
	moveq r0, #0
	cmp r0, #0
	ldrneh r5, [r4, #0x24]
	movne r4, #0x10000
	bne _020E9E08
	ldrh r0, [r11, #8]
	ldr r4, [r4, #0x20]
	cmp r0, #0
	ldrneh r5, [r11, #0xa]
	bne _020E9E08
	mov r10, #0
	mov r9, r10
	mov r5, #0x10000
	add r8, sp, #0x98
	mov r6, #3
	mov r7, #1
_020E9D90:
	mov r0, r8
	mov r1, r10
	bl FSi_SeekDirDirect
	add r2, sp, #4
	cmp r10, #0
	mov r0, r8
	mov r1, r6
	ldreq r9, [sp, #0xc4]
	str r2, [sp, #0xc8]
	str r7, [sp, #0xcc]
	bl FSi_TranslateCommand
	cmp r0, #0
	bne _020E9DF4
_020E9DC4:
	ldr r0, [sp, #0x10]
	cmp r0, #0
	bne _020E9DE0
	ldr r0, [sp, #8]
	cmp r0, r4
	ldreqh r5, [sp, #0xbc]
	beq _020E9DF4
_020E9DE0:
	mov r0, r8
	mov r1, r6
	bl FSi_TranslateCommand
	cmp r0, #0
	beq _020E9DC4
_020E9DF4:
	cmp r5, #0x10000
	bne _020E9E08
	add r10, r10, #1
	cmp r10, r9
	blo _020E9D90
_020E9E08:
	cmp r5, #0x10000
	moveq r0, #0
	streqh r0, [r11, #8]
	addeq sp, sp, #0xe4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	ldrh r0, [r11, #8]
	cmp r0, #0
	bne _020E9F04
	ldr r0, [sp]
	mov r1, #0
	ldr r0, [r0]
	cmp r0, #0xff
	addls r9, r1, #1
	bls _020E9E54
	cmp r0, #0xff00
	addls r9, r1, #2
	addhi r9, r1, #3
_020E9E54:
	cmp r4, #0x10000
	ldrne r0, [sp, #0x14]
	add r9, r9, #2
	addne r9, r9, r0
	mov r10, r5
	cmp r5, #0
	beq _020E9EF8
	add r0, sp, #0x98
	mov r1, r5
	bl FSi_SeekDirDirect
	add r8, sp, #0x98
	mov r6, #3
	mov r7, #1
_020E9E88:
	ldr r1, [sp, #0xc4]
	mov r0, r8
	bl FSi_SeekDirDirect
	add r2, sp, #4
	mov r0, r8
	mov r1, r6
	str r2, [sp, #0xc8]
	str r7, [sp, #0xcc]
	bl FSi_TranslateCommand
	cmp r0, #0
	bne _020E9EEC
_020E9EB4:
	ldr r0, [sp, #0x10]
	cmp r0, #0
	beq _020E9ED8
	ldrh r0, [sp, #8]
	cmp r0, r10
	ldreq r0, [sp, #0x14]
	addeq r0, r0, #1
	addeq r9, r9, r0
	beq _020E9EEC
_020E9ED8:
	mov r0, r8
	mov r1, r6
	bl FSi_TranslateCommand
	cmp r0, #0
	beq _020E9EB4
_020E9EEC:
	ldrh r10, [sp, #0xbc]
	cmp r10, #0
	bne _020E9E88
_020E9EF8:
	add r0, r9, #1
	strh r0, [r11, #8]
	strh r5, [r11, #0xa]
_020E9F04:
	ldr r7, [r11]
	cmp r7, #0
	addeq sp, sp, #0xe4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	ldrh r6, [r11, #8]
	ldr r0, [r11, #4]
	cmp r0, r6
	addlo sp, sp, #0xe4
	movlo r0, #1
	ldmloia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxlo lr
	ldr r0, [sp]
	mov r9, #0
	ldr r0, [r0]
	cmp r0, #0xff
	movls r8, #1
	bls _020E9F5C
	cmp r0, #0xff00
	movls r8, #2
	movhi r8, #3
_020E9F5C:
	ldr r0, [sp]
	mov r1, r7
	mov r2, r8
	bl MI_CpuCopy8
	add r1, r9, r8
	ldr r0, _020EA0D8 // =_0211F790
	add r1, r7, r1
	mov r2, #2
	bl MI_CpuCopy8
	add r0, sp, #0x98
	mov r1, r5
	bl FSi_SeekDirDirect
	cmp r4, #0x10000
	beq _020EA010
	add r3, sp, #4
	mov r2, #0
	add r0, sp, #0x98
	mov r1, #3
	str r3, [sp, #0xc8]
	str r2, [sp, #0xcc]
	bl FSi_TranslateCommand
	cmp r0, #0
	bne _020E9FEC
	add r9, sp, #0x98
	mov r8, #3
_020E9FC0:
	ldr r0, [sp, #0x10]
	cmp r0, #0
	bne _020E9FD8
	ldr r0, [sp, #8]
	cmp r0, r4
	beq _020E9FEC
_020E9FD8:
	mov r0, r9
	mov r1, r8
	bl FSi_TranslateCommand
	cmp r0, #0
	beq _020E9FC0
_020E9FEC:
	ldr r0, [sp, #0x14]
	add r1, r7, r6
	add r4, r0, #1
	add r0, sp, #0x18
	mov r2, r4
	sub r1, r1, r4
	bl MI_CpuCopy8
	sub r6, r6, r4
	b _020EA020
_020EA010:
	add r0, r7, r6
	mov r1, #0
	strb r1, [r0, #-1]
	sub r6, r6, #1
_020EA020:
	cmp r5, #0
	beq _020EA0C8
	add r10, sp, #0x98
	add r11, sp, #4
	mov r4, #3
	mov r9, #0
	mov r8, #0x2f
_020EA03C:
	ldr r1, [sp, #0xc4]
	mov r0, r10
	bl FSi_SeekDirDirect
	add r2, r7, r6
	mov r0, r10
	mov r1, r4
	str r11, [sp, #0xc8]
	str r9, [sp, #0xcc]
	strb r8, [r2, #-1]
	sub r6, r6, #1
	bl FSi_TranslateCommand
	cmp r0, #0
	bne _020EA0BC
_020EA070:
	ldr r0, [sp, #0x10]
	cmp r0, #0
	beq _020EA0A8
	ldrh r0, [sp, #8]
	cmp r0, r5
	bne _020EA0A8
	ldr r5, [sp, #0x14]
	add r1, r7, r6
	add r0, sp, #0x18
	mov r2, r5
	sub r1, r1, r5
	bl MI_CpuCopy8
	sub r6, r6, r5
	b _020EA0BC
_020EA0A8:
	mov r0, r10
	mov r1, r4
	bl FSi_TranslateCommand
	cmp r0, #0
	beq _020EA070
_020EA0BC:
	ldrh r5, [sp, #0xbc]
	cmp r5, #0
	bne _020EA03C
_020EA0C8:
	mov r0, #0
	add sp, sp, #0xe4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020EA0D8: .word _0211F790
	arm_func_end FSi_GetPathCommand

	arm_func_start FSi_FindPathCommand
FSi_FindPathCommand: // 0x020EA0DC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x9c
	mov r10, r0
	ldr r2, [r10, #0x40]
	ldr r9, [r10, #0x3c]
	mov r1, #2
	str r2, [sp]
	bl FSi_TranslateCommand
	ldrb r1, [r9]
	cmp r1, #0
	beq _020EA2CC
	mov r0, #2
	add r11, sp, #0x1c
	mov r4, #3
	mov r5, #1
	mov r6, #0
	str r0, [sp, #4]
_020EA120:
	mov r7, r6
	b _020EA12C
_020EA128:
	add r7, r7, #1
_020EA12C:
	ldrb r8, [r9, r7]
	mov r0, r6
	cmp r8, #0
	beq _020EA14C
	cmp r8, #0x2f
	beq _020EA14C
	cmp r8, #0x5c
	movne r0, r5
_020EA14C:
	cmp r0, #0
	bne _020EA128
	cmp r8, #0
	bne _020EA168
	ldr r0, [sp]
	cmp r0, #0
	beq _020EA16C
_020EA168:
	mov r8, r5
_020EA16C:
	cmp r7, #0
	addeq sp, sp, #0x9c
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	cmp r1, #0x2e
	bne _020EA1D8
	cmp r7, #1
	addeq r9, r9, #1
	beq _020EA2B0
	ldrb r0, [r9, #1]
	cmp r7, #2
	moveq r1, r5
	movne r1, r6
	cmp r0, #0x2e
	moveq r0, r5
	movne r0, r6
	ands r0, r1, r0
	beq _020EA1D8
	ldrh r0, [r10, #0x24]
	cmp r0, #0
	beq _020EA1D0
	ldr r1, [r10, #0x2c]
	mov r0, r10
	bl FSi_SeekDirDirect
_020EA1D0:
	add r9, r9, #2
	b _020EA2B0
_020EA1D8:
	cmp r7, #0x7f
	addgt sp, sp, #0x9c
	movgt r0, #1
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxgt lr
	add r0, sp, #8
	str r0, [r10, #0x30]
	str r6, [r10, #0x34]
_020EA1F8:
	mov r0, r10
	mov r1, r4
	bl FSi_TranslateCommand
	cmp r0, #0
	addne sp, sp, #0x9c
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	ldr r0, [sp, #0x14]
	cmp r8, r0
	bne _020EA1F8
	ldr r0, [sp, #0x18]
	cmp r7, r0
	bne _020EA1F8
	mov r0, r9
	mov r1, r11
	mov r2, r7
	bl FSi_StrNICmp
	cmp r0, #0
	bne _020EA1F8
	cmp r8, #0
	beq _020EA274
	add r0, sp, #8
	add r3, r10, #0x30
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [sp, #4]
	mov r0, r10
	add r9, r9, r7
	bl FSi_TranslateCommand
	b _020EA2B0
_020EA274:
	ldr r0, [sp]
	cmp r0, #0
	addne sp, sp, #0x9c
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	ldr r3, [r10, #0x44]
	ldr r2, [sp, #8]
	ldr r1, [sp, #0xc]
	add sp, sp, #0x9c
	str r2, [r3]
	str r1, [r3, #4]
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020EA2B0:
	ldrb r0, [r9]
	cmp r0, #0
	movne r0, r5
	moveq r0, r6
	ldrb r1, [r9, r0]!
	cmp r1, #0
	bne _020EA120
_020EA2CC:
	ldr r0, [sp]
	cmp r0, #0
	moveq r0, #1
	addne r0, r10, #0x20
	ldrne r3, [r10, #0x44]
	ldmneia r0, {r0, r1, r2}
	stmneia r3, {r0, r1, r2}
	movne r0, #0
	add sp, sp, #0x9c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	arm_func_end FSi_FindPathCommand

	arm_func_start FSi_ReadDirCommand
FSi_ReadDirCommand: // 0x020EA2F8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r4, [r5, #0x30]
	ldr r1, [r5, #8]
	add r0, sp, #4
	str r1, [sp, #4]
	ldr r3, [r5, #0x28]
	add r1, sp, #0
	mov r2, #1
	str r3, [sp, #8]
	bl FSi_ReadTable
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	ldrb r1, [sp]
	and r2, r1, #0x7f
	mov r1, r1, asr #7
	str r2, [r4, #0x10]
	and r1, r1, #1
	str r1, [r4, #0xc]
	ldr r2, [r4, #0x10]
	cmp r2, #0
	addeq sp, sp, #0xc
	moveq r0, #1
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldr r1, [r5, #0x34]
	cmp r1, #0
	bne _020EA3A4
	add r0, sp, #4
	add r1, r4, #0x14
	bl FSi_ReadTable
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	ldr r1, [r4, #0x10]
	mov r2, #0
	add r1, r4, r1
	strb r2, [r1, #0x14]
	b _020EA3B0
_020EA3A4:
	ldr r1, [sp, #8]
	add r1, r1, r2
	str r1, [sp, #8]
_020EA3B0:
	ldr r1, [r4, #0xc]
	cmp r1, #0
	beq _020EA404
	add r0, sp, #4
	add r1, sp, #2
	mov r2, #2
	bl FSi_ReadTable
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	ldr r2, [r5, #8]
	ldr r1, _020EA434 // =0x00000FFF
	str r2, [r4]
	ldrh r3, [sp, #2]
	mov r2, #0
	and r1, r3, r1
	strh r1, [r4, #4]
	strh r2, [r4, #6]
	str r2, [r4, #8]
	b _020EA420
_020EA404:
	ldr r1, [r5, #8]
	str r1, [r4]
	ldrh r1, [r5, #0x26]
	str r1, [r4, #4]
	ldrh r1, [r5, #0x26]
	add r1, r1, #1
	strh r1, [r5, #0x26]
_020EA420:
	ldr r1, [sp, #8]
	str r1, [r5, #0x28]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020EA434: .word 0x00000FFF
	arm_func_end FSi_ReadDirCommand

	arm_func_start FSi_SeekDirCommand
FSi_SeekDirCommand: // 0x020EA438
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r6, r0
	ldr r5, [r6, #8]
	add r4, r6, #0x30
	str r5, [sp, #8]
	ldrh r1, [r4, #4]
	ldr r2, [r5, #0x34]
	add r0, sp, #8
	add r3, r2, r1, lsl #3
	add r1, sp, #0
	mov r2, #8
	str r3, [sp, #0xc]
	bl FSi_ReadTable
	movs r3, r0
	bne _020EA4C4
	add ip, r6, #0x20
	ldmia r4, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldrh r0, [r4, #6]
	cmp r0, #0
	bne _020EA4B4
	ldr r0, [r4, #8]
	cmp r0, #0
	bne _020EA4B4
	ldrh r0, [sp, #4]
	strh r0, [r6, #0x26]
	ldr r1, [r5, #0x34]
	ldr r0, [sp]
	add r0, r1, r0
	str r0, [r6, #0x28]
_020EA4B4:
	ldrh r1, [sp, #6]
	ldr r0, _020EA4D4 // =0x00000FFF
	and r0, r1, r0
	str r0, [r6, #0x2c]
_020EA4C4:
	mov r0, r3
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020EA4D4: .word 0x00000FFF
	arm_func_end FSi_SeekDirCommand

	arm_func_start FSi_WriteFileCommand
FSi_WriteFileCommand: // 0x020EA4D8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, [r0, #0x2c]
	ldr r3, [r0, #0x38]
	ldr lr, [r0, #8]
	ldr r1, [r0, #0x30]
	add ip, r2, r3
	str ip, [r0, #0x2c]
	ldr ip, [lr, #0x4c]
	mov r0, lr
	blx ip
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end FSi_WriteFileCommand

	arm_func_start FSi_ReadFileCommand
FSi_ReadFileCommand: // 0x020EA510
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, [r0, #0x2c]
	ldr r3, [r0, #0x38]
	ldr lr, [r0, #8]
	ldr r1, [r0, #0x30]
	add ip, r2, r3
	str ip, [r0, #0x2c]
	ldr ip, [lr, #0x48]
	mov r0, lr
	blx ip
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end FSi_ReadFileCommand

	arm_func_start FSi_SeekDirDirect
FSi_SeekDirDirect: // 0x020EA548
	ldr r3, [r0, #0xc]
	mov r2, #0
	orr r3, r3, #4
	str r3, [r0, #0xc]
	ldr r3, [r0, #8]
	ldr ip, _020EA578 // =FSi_TranslateCommand
	str r3, [r0, #0x30]
	str r2, [r0, #0x38]
	strh r2, [r0, #0x36]
	strh r1, [r0, #0x34]
	mov r1, #2
	bx ip
	.align 2, 0
_020EA578: .word FSi_TranslateCommand
	arm_func_end FSi_SeekDirDirect

	arm_func_start FSi_ReadTable
FSi_ReadTable: // 0x020EA57C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r0
	ldr r5, [r7]
	mov r6, r2
	ldr r2, [r5, #0x1c]
	mov r0, r5
	orr r2, r2, #0x200
	str r2, [r5, #0x1c]
	ldr r2, [r7, #4]
	ldr r4, [r5, #0x50]
	mov r3, r6
	blx r4
	cmp r0, #0
	beq _020EA5C8
	cmp r0, #1
	beq _020EA5C8
	cmp r0, #6
	beq _020EA5D8
	b _020EA614
_020EA5C8:
	ldr r1, [r5, #0x1c]
	bic r1, r1, #0x200
	str r1, [r5, #0x1c]
	b _020EA614
_020EA5D8:
	bl OS_DisableInterrupts
	ldr r1, [r5, #0x1c]
	mov r4, r0
	ands r0, r1, #0x200
	beq _020EA604
	add r8, r5, #0xc
_020EA5F0:
	mov r0, r8
	bl OS_SleepThread
	ldr r0, [r5, #0x1c]
	ands r0, r0, #0x200
	bne _020EA5F0
_020EA604:
	mov r0, r4
	bl OS_RestoreInterrupts
	ldr r0, [r5, #0x24]
	ldr r0, [r0, #0x14]
_020EA614:
	ldr r1, [r7, #4]
	add r1, r1, r6
	str r1, [r7, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end FSi_ReadTable

	arm_func_start FSi_StrNICmp
FSi_StrNICmp: // 0x020EA628
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r2, #0
	mov lr, #0
	bls _020EA67C
_020EA63C:
	ldrb ip, [r0, lr]
	ldrb r3, [r1, lr]
	sub ip, ip, #0x41
	cmp ip, #0x19
	sub r3, r3, #0x41
	addls ip, ip, #0x20
	cmp r3, #0x19
	addls r3, r3, #0x20
	cmp ip, r3
	addne sp, sp, #4
	subne r0, ip, r3
	ldmneia sp!, {lr}
	bxne lr
	add lr, lr, #1
	cmp lr, r2
	blo _020EA63C
_020EA67C:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end FSi_StrNICmp

	.data
	
_0211F790: // 0x0211F790
	.byte 0x3A, 0x2F, 0, 0