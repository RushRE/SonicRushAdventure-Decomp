	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start FSi_TranslateCommand
FSi_TranslateCommand: // 0x020E9A80
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	ldr r0, [r8, #0xc]
	mov r7, r1
	mov r1, #1
	ldr r5, [r8, #8]
	mov r4, r1, lsl r7
	ands r0, r0, #4
	moveq r1, #0
	cmp r1, #0
	ldrne r0, [r5, #0x1c]
	orrne r0, r0, #0x200
	strne r0, [r5, #0x1c]
	ldreq r0, [r5, #0x1c]
	orreq r0, r0, #0x100
	streq r0, [r5, #0x1c]
	ldr r0, [r5, #0x58]
	ands r0, r0, r4
	beq _020E9B30
	ldr r2, [r5, #0x54]
	mov r0, r8
	mov r1, r7
	blx r2
	mov r6, r0
	cmp r6, #8
	addls pc, pc, r6, lsl #2
	b _020E9B34
_020E9AEC: // jump table
	b _020E9B10 // case 0
	b _020E9B10 // case 1
	b _020E9B34 // case 2
	b _020E9B34 // case 3
	b _020E9B10 // case 4
	b _020E9B34 // case 5
	b _020E9B34 // case 6
	b _020E9B34 // case 7
	b _020E9B18 // case 8
_020E9B10:
	str r6, [r8, #0x14]
	b _020E9B34
_020E9B18:
	ldr r1, [r5, #0x58]
	mvn r0, r4
	and r0, r1, r0
	str r0, [r5, #0x58]
	mov r6, #7
	b _020E9B34
_020E9B30:
	mov r6, #7
_020E9B34:
	cmp r6, #7
	bne _020E9B50
	ldr r1, _020E9BF8 // =_02116F9C
	mov r0, r8
	ldr r1, [r1, r7, lsl #2]
	blx r1
	mov r6, r0
_020E9B50:
	cmp r6, #6
	bne _020E9BAC
	ldr r0, [r8, #0xc]
	ands r0, r0, #4
	movne r0, #1
	moveq r0, #0
	cmp r0, #0
	beq _020E9BEC
	bl OS_DisableInterrupts
	ldr r1, [r5, #0x1c]
	mov r4, r0
	ands r0, r1, #0x200
	beq _020E9B9C
	add r6, r5, #0xc
_020E9B88:
	mov r0, r6
	bl OS_SleepThread
	ldr r0, [r5, #0x1c]
	ands r0, r0, #0x200
	bne _020E9B88
_020E9B9C:
	mov r0, r4
	ldr r6, [r8, #0x14]
	bl OS_RestoreInterrupts
	b _020E9BEC
_020E9BAC:
	ldr r0, [r8, #0xc]
	ands r0, r0, #4
	movne r0, #1
	moveq r0, #0
	cmp r0, #0
	ldrne r0, [r5, #0x1c]
	bicne r0, r0, #0x200
	strne r0, [r5, #0x1c]
	strne r6, [r8, #0x14]
	bne _020E9BEC
	ldr r1, [r5, #0x1c]
	mov r0, r8
	bic r2, r1, #0x100
	mov r1, r6
	str r2, [r5, #0x1c]
	bl FSi_ReleaseCommand
_020E9BEC:
	mov r0, r6
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020E9BF8: .word _02116F9C
	arm_func_end FSi_TranslateCommand

	arm_func_start FSi_ReleaseCommand
FSi_ReleaseCommand: // 0x020E9BFC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl OS_DisableInterrupts
	ldr r1, [r6]
	mov r4, r0
	ldr r0, [r6, #4]
	cmp r1, #0
	strne r0, [r1, #4]
	cmp r0, #0
	strne r1, [r0]
	mov r0, #0
	str r0, [r6]
	ldr r1, [r6]
	add r0, r6, #0x18
	str r1, [r6, #4]
	ldr r1, [r6, #0xc]
	bic r1, r1, #0x4f
	str r1, [r6, #0xc]
	str r5, [r6, #0x14]
	bl OS_WakeupThread
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end FSi_ReleaseCommand

    .rodata

_02116F9C: // 0x02116F9C
	.word FSi_ReadFileCommand
	.word FSi_WriteFileCommand
	.word FSi_SeekDirCommand
	.word FSi_ReadDirCommand
	.word FSi_FindPathCommand
	.word FSi_GetPathCommand
	.word FSi_OpenFileFastCommand
	.word FSi_OpenFileDirectCommand
	.word FSi_CloseFileCommand