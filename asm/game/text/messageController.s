	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start MessageController__Init
MessageController__Init: // 0x02053B8C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x74
	bl MIi_CpuClear32
	mov r1, #0
	ldr r0, _02053BCC // =0x0000FFFF
	str r1, [r4, #0x28]
	strh r0, [r4, #0xc]
	strh r0, [r4, #0xe]
	strh r0, [r4, #0x10]
	strh r0, [r4, #0x12]
	str r1, [r4, #0x64]
	str r1, [r4, #0x68]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02053BCC: .word 0x0000FFFF
	arm_func_end MessageController__Init

	arm_func_start MessageController__SetFont
MessageController__SetFont: // 0x02053BD0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl MessageController__InitFunc
	str r4, [r5, #0x68]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end MessageController__SetFont

	arm_func_start MessageController__LoadMPCFile
MessageController__LoadMPCFile: // 0x02053BE8
	str r1, [r0, #0x64]
	bx lr
	arm_func_end MessageController__LoadMPCFile

	arm_func_start MessageController__Setup
MessageController__Setup: // 0x02053BF0
	stmdb sp!, {r3, r4, r5, lr}
	ldrh r5, [sp, #0x14]
	mov r4, r0
	ldrh lr, [sp, #0x14]
	cmp r5, #0
	moveq r0, #0
	streqh r0, [sp, #0x10]
	mul r0, r2, r3
	ldrh r5, [sp, #0x10]
	mov ip, #1
	str r1, [r4, #0x34]
	mov r0, r0, lsl #5
	str r0, [r4, #0x38]
	strh r2, [r4, #0x3c]
	mov r1, ip, lsl r5
	mov r0, ip, lsl lr
	mul r0, r1, r0
	ldr r1, [sp, #0x18]
	strh r3, [r4, #0x3e]
	str r1, [r4, #0x40]
	strh r5, [r4, #0x44]
	strh lr, [r4, #0x46]
	mov r0, r0, lsl #5
	str r0, [r4, #0x48]
	ldrh r0, [r4, #0x44]
	rsb r1, ip, #0x10000
	add r0, r0, #3
	mov r0, ip, lsl r0
	strh r0, [r4, #0x4c]
	ldrh r0, [r4, #0x46]
	add r0, r0, #3
	mov r0, ip, lsl r0
	strh r0, [r4, #0x4e]
	ldrh r0, [r4, #0x44]
	add r0, r0, #3
	mov r0, r1, lsl r0
	strh r0, [r4, #0x50]
	ldrh r0, [r4, #0x46]
	add r0, r0, #3
	mov r0, r1, lsl r0
	strh r0, [r4, #0x52]
	ldrh r0, [r4, #0x44]
	mov r0, r2, asr r0
	strh r0, [r4, #0x54]
	ldrh r0, [r4, #0x4c]
	mov r0, r0, asr #3
	strh r0, [r4, #0x56]
	ldr r0, [r4, #0x68]
	bl FontFile__GetPixelHeight
	strh r0, [r4, #0x30]
	mov r1, #0
	mov r0, r4
	strh r1, [r4, #0x32]
	bl MessageController__GetSequenceCount
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	mov r1, #0
	bl MessageController__SetSequence
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end MessageController__Setup

	arm_func_start MessageController__AdvanceLine
MessageController__AdvanceLine: // 0x02053CE0
	strh r1, [r0, #0x2e]
	ldrsh r2, [r0, #0x2e]
	ldrsh r1, [r0, #6]
	ldrsh r3, [r0, #0xa]
	sub r1, r2, r1
	add r1, r3, r1
	strh r1, [r0, #0xa]
	ldrsh r1, [r0, #0x2e]
	strh r1, [r0, #6]
	bx lr
	arm_func_end MessageController__AdvanceLine

	arm_func_start MessageController__SetCallbackValue
MessageController__SetCallbackValue: // 0x02053D08
	strh r1, [r0, #0x32]
	bx lr
	arm_func_end MessageController__SetCallbackValue

	arm_func_start MessageController__InitStartPos
MessageController__InitStartPos: // 0x02053D10
	stmdb sp!, {r4, lr}
	mov r4, r0
	str r1, [r4, #0x28]
	strh r2, [r4, #0x2c]
	bl MessageController__GetLineWidth
	ldrh ip, [r4, #0x3c]
	mov r1, r0
	ldrsh r3, [r4, #0x2c]
	ldr r2, [r4, #0x28]
	mov r0, ip, lsl #3
	bl MessageController__GetStartPos
	ldrsh r1, [r4, #4]
	ldrsh r2, [r4, #8]
	sub r1, r0, r1
	add r1, r2, r1
	strh r1, [r4, #8]
	strh r0, [r4, #4]
	ldmia sp!, {r4, pc}
	arm_func_end MessageController__InitStartPos

	arm_func_start MessageController__SetClearPixelCallback
MessageController__SetClearPixelCallback: // 0x02053D58
	str r1, [r0, #0x58]
	str r2, [r0, #0x60]
	bx lr
	arm_func_end MessageController__SetClearPixelCallback

	arm_func_start MessageController__SetCallback
MessageController__SetCallback: // 0x02053D64
	str r1, [r0, #0x70]
	str r2, [r0, #0x6c]
	bx lr
	arm_func_end MessageController__SetCallback

	arm_func_start MessageController__InitFunc
MessageController__InitFunc: // 0x02053D70
	ldr ip, _02053D78 // =MessageController__Init
	bx ip
	.align 2, 0
_02053D78: .word MessageController__Init
	arm_func_end MessageController__InitFunc

	arm_func_start MessageController__GetSequenceCount
MessageController__GetSequenceCount: // 0x02053D7C
	stmdb sp!, {r3, lr}
	ldr r0, [r0, #0x64]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	bl MPC__GetUnknownCount
	ldmia sp!, {r3, pc}
	arm_func_end MessageController__GetSequenceCount

	arm_func_start MessageController__SetSequence
MessageController__SetSequence: // 0x02053D98
	ldr ip, _02053DA8 // =MessageController__SetDialog
	strh r1, [r0, #0xc]
	mov r1, #0
	bx ip
	.align 2, 0
_02053DA8: .word MessageController__SetDialog
	arm_func_end MessageController__SetSequence

	arm_func_start MessageController__GetCurrentSequence
MessageController__GetCurrentSequence: // 0x02053DAC
	stmdb sp!, {r4, lr}
	ldrh r4, [r0, #0xc]
	bl MessageController__GetSequenceCount
	cmp r4, r0
	ldrhs r4, _02053DC8 // =0x0000FFFF
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02053DC8: .word 0x0000FFFF
	arm_func_end MessageController__GetCurrentSequence

	arm_func_start MessageController__GetSequenceDialogCount
MessageController__GetSequenceDialogCount: // 0x02053DCC
	ldr ip, _02053DDC // =MPC__GetSequenceDialogCount
	ldrh r1, [r0, #0xc]
	ldr r0, [r0, #0x64]
	bx ip
	.align 2, 0
_02053DDC: .word MPC__GetSequenceDialogCount
	arm_func_end MessageController__GetSequenceDialogCount

	arm_func_start MessageController__SetDialog
MessageController__SetDialog: // 0x02053DE0
	stmdb sp!, {r4, lr}
	mov r4, r0
	strh r1, [r4, #0xe]
	ldrh r1, [r4, #0xc]
	ldrh r2, [r4, #0xe]
	ldr r0, [r4, #0x64]
	bl MPC__GetDisplayLineLength
	strh r0, [r4, #0x14]
	mov r0, r4
	mov r1, #0
	bl MessageController__SetLineID
	ldmia sp!, {r4, pc}
	arm_func_end MessageController__SetDialog

	arm_func_start MessageController__GetDialogID
MessageController__GetDialogID: // 0x02053E10
	ldrh r0, [r0, #0xe]
	bx lr
	arm_func_end MessageController__GetDialogID

	arm_func_start MessageController__GetDialogLineCount
MessageController__GetDialogLineCount: // 0x02053E18
	ldr ip, _02053E2C // =MPC__Func_20538B0
	ldrh r1, [r0, #0xc]
	ldrh r2, [r0, #0xe]
	ldr r0, [r0, #0x64]
	bx ip
	.align 2, 0
_02053E2C: .word MPC__Func_20538B0
	arm_func_end MessageController__GetDialogLineCount

	arm_func_start MessageController__SetLineID
MessageController__SetLineID: // 0x02053E30
	stmdb sp!, {r4, lr}
	mov r4, r0
	strh r1, [r4, #0x10]
	mov r0, #0
	strh r0, [r4, #0x12]
	ldrh r1, [r4, #0xc]
	ldrh r2, [r4, #0xe]
	ldrh r3, [r4, #0x10]
	ldr r0, [r4, #0x64]
	bl MPC__GetLineLength
	strh r0, [r4, #0x16]
	mov r0, r4
	bl MessageController__GetLineWidth
	ldrh r2, [r4, #0x3c]
	mov r1, r0
	ldrsh r3, [r4, #0x2c]
	mov r0, r2, lsl #3
	ldr r2, [r4, #0x28]
	bl MessageController__GetStartPos
	strh r0, [r4, #8]
	ldrsh r1, [r4, #8]
	mov r0, r4
	strh r1, [r4, #4]
	ldrsh r1, [r4, #0x2e]
	strh r1, [r4, #0xa]
	strh r1, [r4, #6]
	bl MessageController__Func_205442C
	ldmia sp!, {r4, pc}
	arm_func_end MessageController__SetLineID

	arm_func_start MessageController__GetLineWidth
MessageController__GetLineWidth: // 0x02053EA0
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x68]
	str r1, [sp]
	ldrh r1, [r0, #0xc]
	ldrh r2, [r0, #0xe]
	ldrh r3, [r0, #0x10]
	ldr r0, [r0, #0x64]
	bl MessageController__MPC__Func_2054524
	ldmia sp!, {r3, pc}
	arm_func_end MessageController__GetLineWidth

	arm_func_start MessageController__SetPosition
MessageController__SetPosition: // 0x02053EC4
	strh r1, [r0, #8]
	strh r2, [r0, #0xa]
	bx lr
	arm_func_end MessageController__SetPosition

	arm_func_start MessageController__SetPosX
MessageController__SetPosX: // 0x02053ED0
	strh r1, [r0, #8]
	bx lr
	arm_func_end MessageController__SetPosX

	arm_func_start MessageController__GetPosition
MessageController__GetPosition: // 0x02053ED8
	cmp r1, #0
	ldrnesh r3, [r0, #8]
	strneh r3, [r1]
	cmp r2, #0
	ldrnesh r0, [r0, #0xa]
	strneh r0, [r2]
	bx lr
	arm_func_end MessageController__GetPosition

	arm_func_start MessageController__Func_2053EF4
MessageController__Func_2053EF4: // 0x02053EF4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x10
	mov sl, r0
	movs r0, r1
	ldreq r0, _02054168 // =0x0000FFFF
	str r1, [sp, #8]
	streq r0, [sp, #8]
	ldr r0, [sl, #0x68]
	bl FontFile__GetPixelHeight
	ldrsh r6, [sl, #8]
	mov r7, r0
	ldr r0, [sp, #8]
	mov fp, r6
	cmp r0, #0
	mov r5, #0
	ble _02054140
	mov r0, r7, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0xc]
_02053F40:
	ldrh r0, [sl, #0x12]
	str r0, [sp]
	ldrh r1, [sl, #0xc]
	ldrh r2, [sl, #0xe]
	ldrh r3, [sl, #0x10]
	ldr r0, [sl, #0x64]
	bl MPC__GetCharacterFromOffset
	mov r4, r0
	ldr r0, [sl, #0x64]
	mov r1, r4
	bl MPC__CheckRegularCharacter
	cmp r0, #0
	bne _020540B0
	ldr r0, [sl, #0x64]
	mov r1, r4
	bl MPC__GetSpecialCharacter
	mov r8, r0
	ldr r0, [sl, #0x64]
	mov r1, r4
	bl MPC__ShouldRunCallback
	cmp r0, #0
	beq _02053FB4
	mov r0, sl
	mov r1, r8
	bl MessageController__RunCallback
	ldrh r0, [sl, #0x12]
	add r0, r0, #1
	strh r0, [sl, #0x12]
	b _02054134
_02053FB4:
	cmp r8, #0
	bne _02054068
	ldrh r0, [sl, #0x10]
	add r0, r0, #1
	strh r0, [sl, #0x10]
	ldrh r1, [sl, #0xc]
	ldrh r2, [sl, #0xe]
	ldrh r3, [sl, #0x10]
	ldr r0, [sl, #0x64]
	bl MPC__GetLineLength
	strh r0, [sl, #0x16]
	mov r0, #0
	strh r0, [sl, #0x12]
	ldr r0, [sp, #0xc]
	mov r1, fp
	str r0, [sp]
	ldrsh r3, [sl, #0xa]
	mov r0, sl
	mov r2, r6
	bl MessageController__Func_2054734
	mov r0, sl
	bl MessageController__Func_20546AC
	ldr r0, [sl, #0x68]
	str r0, [sp]
	ldrh r1, [sl, #0xc]
	ldrh r2, [sl, #0xe]
	ldrh r3, [sl, #0x10]
	ldr r0, [sl, #0x64]
	bl MessageController__MPC__Func_2054524
	mov r1, r0
	ldrh r0, [sl, #0x3c]
	ldrsh r3, [sl, #0x2c]
	ldr r2, [sl, #0x28]
	mov r0, r0, lsl #3
	bl MessageController__GetStartPos
	strh r0, [sl, #4]
	ldrsh r0, [sl, #4]
	strh r0, [sl, #8]
	ldrsh r1, [sl, #0xa]
	ldrh r0, [sl, #0x30]
	add r0, r1, r0
	strh r0, [sl, #0xa]
	ldrsh r6, [sl, #8]
	mov fp, r6
	b _02054134
_02054068:
	add r0, r8, #0xff
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _02054140
	ldr r0, [sp, #0xc]
	mov r1, fp
	str r0, [sp]
	ldrsh r3, [sl, #0xa]
	mov r0, sl
	mov r2, r6
	bl MessageController__Func_2054734
	mov r0, sl
	bl MessageController__Func_20546AC
	mov r6, #0
	mov fp, r6
	b _02054140
_020540B0:
	ldr r0, [sl, #0x68]
	mov r1, r4
	bl FontFile__GetCharXAdvance
	ldrsh r8, [sl, #8]
	ldrh r1, [sl, #0x3c]
	mov r6, r0
	cmp r8, r1, lsl #3
	ldrltsh sb, [sl, #0xa]
	ldrlth r0, [sl, #0x3e]
	cmplt sb, r0, lsl #3
	bge _02054114
	add r0, r8, r6
	cmp r0, #0
	addgt r0, sb, r7
	cmpgt r0, #0
	ble _02054114
	ldr r0, [sl, #0x68]
	mov r1, r4
	bl FontFile__GetPixels
	mov r1, r0
	mov r2, r8
	mov r3, sb
	mov r0, sl
	stmia sp, {r6, r7}
	bl MessageController__Draw
_02054114:
	ldrsh r0, [sl, #8]
	add r5, r5, #1
	add r0, r0, r6
	strh r0, [sl, #8]
	ldrh r0, [sl, #0x12]
	ldrsh r6, [sl, #8]
	add r0, r0, #1
	strh r0, [sl, #0x12]
_02054134:
	ldr r0, [sp, #8]
	cmp r5, r0
	blt _02053F40
_02054140:
	mov r0, r7, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp]
	ldrsh r3, [sl, #0xa]
	mov r0, sl
	mov r1, fp
	mov r2, r6
	bl MessageController__Func_2054734
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02054168: .word 0x0000FFFF
	arm_func_end MessageController__Func_2053EF4

	arm_func_start MessageController__Func_205416C
MessageController__Func_205416C: // 0x0205416C
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0xc
	mov sl, r0
	ldr r0, [sl, #0x68]
	movs fp, r1
	ldreq fp, _02054304 // =0x0000FFFF
	bl FontFile__GetPixelHeight
	ldrsh r6, [sl, #8]
	mov r7, r0
	cmp fp, #0
	str r6, [sp, #8]
	mov r5, #0
	ble _020542DC
_020541A0:
	ldrh r0, [sl, #0x12]
	str r0, [sp]
	ldrh r1, [sl, #0xc]
	ldrh r2, [sl, #0xe]
	ldrh r3, [sl, #0x10]
	ldr r0, [sl, #0x64]
	bl MPC__GetCharacterFromOffset
	mov r4, r0
	ldr r0, [sl, #0x64]
	mov r1, r4
	bl MPC__CheckRegularCharacter
	cmp r0, #0
	bne _02054250
	ldr r0, [sl, #0x64]
	mov r1, r4
	bl MPC__GetSpecialCharacter
	mov r8, r0
	ldr r0, [sl, #0x64]
	mov r1, r4
	bl MPC__ShouldRunCallback
	cmp r0, #0
	beq _02054214
	mov r0, sl
	mov r1, r8
	bl MessageController__RunCallback
	ldrh r0, [sl, #0x12]
	add r0, r0, #1
	strh r0, [sl, #0x12]
	b _020542D4
_02054214:
	cmp r8, #2
	bhi _020542DC
	mov r0, r7, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp]
	ldrsh r3, [sl, #0xa]
	ldr r1, [sp, #8]
	mov r0, sl
	mov r2, r6
	bl MessageController__Func_2054734
	mov r0, sl
	bl MessageController__Func_20546AC
	mov r6, #0
	str r6, [sp, #8]
	b _020542DC
_02054250:
	ldr r0, [sl, #0x68]
	mov r1, r4
	bl FontFile__GetCharXAdvance
	ldrsh r8, [sl, #8]
	ldrh r1, [sl, #0x3c]
	mov r6, r0
	cmp r8, r1, lsl #3
	ldrltsh sb, [sl, #0xa]
	ldrlth r0, [sl, #0x3e]
	cmplt sb, r0, lsl #3
	bge _020542B4
	add r0, r8, r6
	cmp r0, #0
	addgt r0, sb, r7
	cmpgt r0, #0
	ble _020542B4
	ldr r0, [sl, #0x68]
	mov r1, r4
	bl FontFile__GetPixels
	mov r1, r0
	mov r0, sl
	mov r2, r8
	mov r3, sb
	stmia sp, {r6, r7}
	bl MessageController__Draw
_020542B4:
	ldrsh r0, [sl, #8]
	add r5, r5, #1
	add r0, r0, r6
	strh r0, [sl, #8]
	ldrh r0, [sl, #0x12]
	ldrsh r6, [sl, #8]
	add r0, r0, #1
	strh r0, [sl, #0x12]
_020542D4:
	cmp r5, fp
	blt _020541A0
_020542DC:
	mov r0, r7, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp]
	ldrsh r3, [sl, #0xa]
	ldr r1, [sp, #8]
	mov r0, sl
	mov r2, r6
	bl MessageController__Func_2054734
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02054304: .word 0x0000FFFF
	arm_func_end MessageController__Func_205416C

	arm_func_start MessageController__Func_2054308
MessageController__Func_2054308: // 0x02054308
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r0, [r5, #0x12]
	str r0, [sp]
	ldrh r1, [r5, #0xc]
	ldrh r2, [r5, #0xe]
	ldrh r3, [r5, #0x10]
	ldr r0, [r5, #0x64]
	bl MPC__GetCharacterFromOffset
	mov r4, r0
	ldr r0, [r5, #0x64]
	mov r1, r4
	bl MPC__CheckUnknown1Alt
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x64]
	mov r1, r4
	bl MPC__GetSpecialCharacter
	cmp r0, #2
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end MessageController__Func_2054308

	arm_func_start MessageController__Func_2054364
MessageController__Func_2054364: // 0x02054364
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r0, [r5, #0x12]
	str r0, [sp]
	ldrh r1, [r5, #0xc]
	ldrh r2, [r5, #0xe]
	ldrh r3, [r5, #0x10]
	ldr r0, [r5, #0x64]
	bl MPC__GetCharacterFromOffset
	mov r4, r0
	ldr r0, [r5, #0x64]
	mov r1, r4
	bl MPC__CheckUnknown1Alt
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x64]
	mov r1, r4
	bl MPC__GetSpecialCharacter
	cmp r0, #1
	moveq r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	cmp r0, #2
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end MessageController__Func_2054364

	arm_func_start MessageController__AdvanceDialog
MessageController__AdvanceDialog: // 0x020543CC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r1, [r5, #0xe]
	add r4, r1, #1
	bl MessageController__GetSequenceDialogCount
	cmp r4, r0
	ldmgeia sp!, {r3, r4, r5, pc}
	mov r1, r4, lsl #0x10
	mov r0, r5
	mov r1, r1, lsr #0x10
	bl MessageController__SetDialog
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end MessageController__AdvanceDialog

	arm_func_start MessageController__AdvanceLineID
MessageController__AdvanceLineID: // 0x020543FC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r1, [r5, #0x10]
	add r4, r1, #1
	bl MessageController__GetDialogLineCount
	cmp r4, r0
	ldmgeia sp!, {r3, r4, r5, pc}
	mov r1, r4, lsl #0x10
	mov r0, r5
	mov r1, r1, lsr #0x10
	bl MessageController__SetLineID
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end MessageController__AdvanceLineID

	arm_func_start MessageController__Func_205442C
MessageController__Func_205442C: // 0x0205442C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x5c]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0x58]
	cmp r1, #0
	beq _02054458
	ldr r0, [r4, #0x60]
	blx r1
	b _02054468
_02054458:
	ldr r1, [r4, #0x34]
	ldr r2, [r4, #0x38]
	mov r0, #0
	bl MIi_CpuClearFast
_02054468:
	ldr r0, [r4, #0x34]
	ldr r1, [r4, #0x38]
	bl DC_StoreRange
	mov r1, #1
	mov r0, r4
	str r1, [r4, #0x5c]
	bl MessageController__Func_2054670
	ldmia sp!, {r4, pc}
	arm_func_end MessageController__Func_205442C

	arm_func_start MessageController__Func_2054488
MessageController__Func_2054488: // 0x02054488
	ldrh r2, [r0, #0x18]
	ldrh r1, [r0, #0x1c]
	cmp r2, r1
	movhs r0, #0
	bxhs lr
	ldrh r1, [r0, #0x1a]
	ldrh r0, [r0, #0x1e]
	cmp r1, r0
	movlo r0, #1
	movhs r0, #0
	bx lr
	arm_func_end MessageController__Func_2054488

	arm_func_start MessageController__Func_20544B4
MessageController__Func_20544B4: // 0x020544B4
	ldrh r2, [r0, #0x20]
	ldrh r1, [r0, #0x24]
	cmp r2, r1
	movhs r0, #0
	bxhs lr
	ldrh r1, [r0, #0x22]
	ldrh r0, [r0, #0x26]
	cmp r1, r0
	movlo r0, #1
	movhs r0, #0
	bx lr
	arm_func_end MessageController__Func_20544B4

	arm_func_start MessageController__Func_20544E0
MessageController__Func_20544E0: // 0x020544E0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r2
	cmp r1, #0
	beq _02054500
	add r0, r5, #0x18
	mov r2, #8
	bl MIi_CpuCopy32
_02054500:
	cmp r4, #0
	beq _02054518
	mov r1, r4
	add r0, r5, #0x20
	mov r2, #8
	bl MIi_CpuCopy32
_02054518:
	mov r0, r5
	bl MessageController__Func_2054644
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end MessageController__Func_20544E0

	arm_func_start MessageController__MPC__Func_2054524
MessageController__MPC__Func_2054524: // 0x02054524
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x38
	str r1, [sp, #0xc]
	str r2, [sp, #0x10]
	mov sl, r0
	str r3, [sp, #0x14]
	ldr sb, [sp, #0x60]
	bl MPC__GetLineLength
	mov r6, #0
	movs fp, r0
	mov r5, r6
	beq _020545E4
	add r4, sp, #0x18
_02054558:
	str r5, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	ldr r1, [sp, #0xc]
	ldr r2, [sp, #0x10]
	mov r0, sl
	str r4, [sp, #8]
	ldr r3, [sp, #0x14]
	bl MPC__GetText
	movs r7, r0
	mov r8, #0
	beq _020545D0
_02054588:
	mov r0, r8, lsl #1
	ldrh r1, [r4, r0]
	mov r0, sl
	bl MPC__CheckRegularCharacter
	cmp r0, #0
	beq _020545BC
	mov r0, r8, lsl #1
	ldrh r1, [r4, r0]
	mov r0, sb
	bl FontFile__GetCharXAdvance
	add r0, r6, r0
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
_020545BC:
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	cmp r7, r0, lsr #16
	mov r8, r0, lsr #0x10
	bhi _02054588
_020545D0:
	add r0, r5, #0x10
	mov r0, r0, lsl #0x10
	cmp fp, r0, lsr #16
	mov r5, r0, lsr #0x10
	bhi _02054558
_020545E4:
	mov r0, r6
	add sp, sp, #0x38
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end MessageController__MPC__Func_2054524

	arm_func_start MessageController__GetStartPos
MessageController__GetStartPos: // 0x020545F0
	cmp r2, #0
	beq _0205460C
	cmp r2, #1
	beq _02054614
	cmp r2, #2
	beq _02054628
	b _0205463C
_0205460C:
	mov r0, r3
	bx lr
_02054614:
	sub r0, r0, r1
	add r0, r3, r0, asr #1
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	bx lr
_02054628:
	sub r0, r0, r1
	add r0, r3, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	bx lr
_0205463C:
	mov r0, #0
	bx lr
	arm_func_end MessageController__GetStartPos

	arm_func_start MessageController__Func_2054644
MessageController__Func_2054644: // 0x02054644
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x18
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear32
	add r1, r4, #0x20
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear32
	ldmia sp!, {r4, pc}
	arm_func_end MessageController__Func_2054644

	arm_func_start MessageController__Func_2054670
MessageController__Func_2054670: // 0x02054670
	stmdb sp!, {r3, lr}
	mov ip, r0
	mov r0, #0
	strh r0, [ip, #0x18]
	strh r0, [ip, #0x1a]
	ldrh r3, [ip, #0x3c]
	add r1, ip, #0x20
	mov r2, #8
	mov r3, r3, lsl #3
	strh r3, [ip, #0x1c]
	ldrh r3, [ip, #0x3e]
	mov r3, r3, lsl #3
	strh r3, [ip, #0x1e]
	bl MIi_CpuClear32
	ldmia sp!, {r3, pc}
	arm_func_end MessageController__Func_2054670

	arm_func_start MessageController__Func_20546AC
MessageController__Func_20546AC: // 0x020546AC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r2, [r4, #0x18]
	ldrh r0, [r4, #0x1c]
	cmp r2, r0
	ldrneh r1, [r4, #0x1a]
	ldrneh r0, [r4, #0x1e]
	cmpne r1, r0
	bne _020546E4
	add r0, r4, #0x20
	add r1, r4, #0x18
	mov r2, #8
	bl MIi_CpuCopy16
	b _02054720
_020546E4:
	ldrh r0, [r4, #0x20]
	cmp r0, r2
	strloh r0, [r4, #0x18]
	ldrh r1, [r4, #0x24]
	ldrh r0, [r4, #0x1c]
	cmp r1, r0
	strhih r1, [r4, #0x1c]
	ldrh r1, [r4, #0x22]
	ldrh r0, [r4, #0x1a]
	cmp r1, r0
	strloh r1, [r4, #0x1a]
	ldrh r1, [r4, #0x26]
	ldrh r0, [r4, #0x1e]
	cmp r1, r0
	strhih r1, [r4, #0x1e]
_02054720:
	add r1, r4, #0x20
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear32
	ldmia sp!, {r4, pc}
	arm_func_end MessageController__Func_20546AC

	arm_func_start MessageController__Func_2054734
MessageController__Func_2054734: // 0x02054734
	stmdb sp!, {r3, r4, r5, lr}
	ldr ip, [sp, #0x10]
	cmp ip, #0
	ldmleia sp!, {r3, r4, r5, pc}
	cmp r1, r2
	movgt r4, r1
	movgt r1, r2
	movgt r2, r4
	ldrh r4, [r0, #0x3c]
	add lr, r3, ip
	cmp lr, #0
	mov r5, r4, lsl #3
	ldrh r4, [r0, #0x3e]
	ldmleia sp!, {r3, r4, r5, pc}
	cmp r3, r4, lsl #3
	ldmgeia sp!, {r3, r4, r5, pc}
	cmp r1, #0
	movlt r1, #0
	blt _0205478C
	cmp r1, r5
	movge r1, r5, lsl #0x10
	movge r1, r1, asr #0x10
_0205478C:
	cmp r2, #0
	movlt r2, #0
	blt _020547A4
	cmp r2, r5
	movge r2, r5, lsl #0x10
	movge r2, r2, asr #0x10
_020547A4:
	cmp r3, #0
	bge _020547C0
	add r3, ip, r3
	mov r3, r3, lsl #0x10
	mov ip, r3, asr #0x10
	mov r3, #0
	b _020547D0
_020547C0:
	cmp lr, r4, lsl #3
	rsbgt r4, r3, r4, lsl #3
	movgt ip, r4, lsl #0x10
	movgt ip, ip, asr #0x10
_020547D0:
	cmp r1, r2
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r5, [r0, #0x20]
	ldrh r4, [r0, #0x24]
	cmp r5, r4
	ldrneh r4, [r0, #0x22]
	ldrneh lr, [r0, #0x26]
	cmpne r4, lr
	bne _0205480C
	strh r1, [r0, #0x20]
	strh r2, [r0, #0x24]
	strh r3, [r0, #0x22]
	add r1, r3, ip
	strh r1, [r0, #0x26]
	b _0205483C
_0205480C:
	cmp r1, r5
	strlth r1, [r0, #0x20]
	ldrh r1, [r0, #0x24]
	cmp r2, r1
	strgth r2, [r0, #0x24]
	ldrh r1, [r0, #0x22]
	add r2, r3, ip
	cmp r3, r1
	strlth r3, [r0, #0x22]
	ldrh r1, [r0, #0x26]
	cmp r2, r1
	strgth r2, [r0, #0x26]
_0205483C:
	bl MessageController__Func_2054844
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end MessageController__Func_2054734

	arm_func_start MessageController__Func_2054844
MessageController__Func_2054844: // 0x02054844
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldrh lr, [r0, #0x1c]
	ldrh ip, [r0, #0x20]
	cmp ip, lr
	ldmhsia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r3, [r0, #0x18]
	ldrh r4, [r0, #0x24]
	cmp r4, r3
	ldmlsia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r7, [r0, #0x1e]
	ldrh r6, [r0, #0x22]
	cmp r6, r7
	ldmhsia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r5, [r0, #0x1a]
	ldrh r8, [r0, #0x26]
	cmp r8, r5
	ldmlsia sp!, {r4, r5, r6, r7, r8, pc}
	cmp ip, r3
	mov r1, #0
	blo _0205489C
	cmp r4, lr
	movls r1, #1
_0205489C:
	cmp r6, r5
	mov r2, #0
	blo _020548B0
	cmp r8, r7
	movls r2, #1
_020548B0:
	cmp r1, #0
	cmpne r2, #0
	beq _020548D0
	add r1, r0, #0x20
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear32
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020548D0:
	cmp r3, ip
	mov r3, #0
	bls _020548E4
	cmp lr, r4
	movlo r3, #1
_020548E4:
	cmp r5, r6
	mov ip, #0
	bls _020548F8
	cmp r7, r8
	movlo ip, #1
_020548F8:
	cmp r1, #0
	beq _02054914
	cmp ip, #0
	bne _02054914
	cmp r6, r5
	strloh r6, [r0, #0x26]
	strhsh r8, [r0, #0x22]
_02054914:
	cmp r2, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r3, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r2, [r0, #0x20]
	ldrh r1, [r0, #0x18]
	cmp r2, r1
	strloh r2, [r0, #0x24]
	ldrhsh r1, [r0, #0x24]
	strhsh r1, [r0, #0x20]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end MessageController__Func_2054844

	arm_func_start MessageController__RunCallback
MessageController__RunCallback: // 0x02054940
	stmdb sp!, {r3, lr}
	mov ip, r0
	ldr r3, [ip, #0x70]
	cmp r3, #0
	ldmeqia sp!, {r3, pc}
	ldr r2, [ip, #0x6c]
	mov r0, r1
	mov r1, ip
	blx r3
	ldmia sp!, {r3, pc}
	arm_func_end MessageController__RunCallback

	arm_func_start MessageController__Draw
MessageController__Draw: // 0x02054968
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x4c
	mov sl, r0
	ldr r0, [sl, #0x68]
	mov r4, #0
	str r4, [sp, #0x2c]
	str r3, [sp, #0x20]
	str r1, [sp, #0x1c]
	ldr r4, [sp, #0x2c]
	ldr r8, [sp, #0x70]
	ldr r1, [sp, #0x74]
	mov sb, r2
	str r1, [sp, #0x74]
	bl FontFile__GetPixelWidth
	ldrh r2, [sl, #0x3c]
	add r1, sb, r8
	ldrh r5, [sl, #0x3e]
	cmp r1, r2, lsl #3
	rsbgt r1, sb, r2, lsl #3
	movgt r1, r1, lsl #0x10
	movgt r8, r1, lsr #0x10
	ldr r3, [sp, #0x20]
	ldr r1, [sp, #0x74]
	add r1, r3, r1
	cmp r1, r5, lsl #3
	ble _020549E4
	mov r1, r3
	rsb r1, r1, r5, lsl #3
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r1, [sp, #0x74]
_020549E4:
	cmp sb, #0
	bge _02054A0C
	add r1, r8, sb
	rsb r3, sb, #0
	mov r1, r1, lsl #0x10
	mov r3, r3, lsl #0x10
	mov r8, r1, lsr #0x10
	mov r1, r3, lsr #0x10
	str r1, [sp, #0x2c]
	mov sb, #0
_02054A0C:
	ldr r1, [sp, #0x20]
	cmp r1, #0
	bge _02054A40
	ldr r3, [sp, #0x74]
	add r4, r3, r1
	rsb r3, r1, #0
	mov r1, r4, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r3, r3, lsl #0x10
	str r1, [sp, #0x74]
	mov r1, #0
	mov r4, r3, lsr #0x10
	str r1, [sp, #0x20]
_02054A40:
	ldrh r1, [sl, #0x46]
	cmp r1, #0
	beq _02054C34
	ldrh r3, [sl, #0x50]
	ldrh r2, [sl, #0x52]
	ldrh r6, [sl, #0x44]
	mvn r5, r3
	add r1, r1, #3
	str sb, [sp, #0x34]
	str r1, [sp, #0x3c]
	mov r1, r5, lsl #0x10
	str r8, [sp, #0x30]
	mvn r3, r2
	ldr r2, [sp, #0x74]
	str r1, [sp, #0x48]
	cmp r2, #0
	add r2, r6, #3
	mov r1, r3, lsl #0x10
	str r2, [sp, #0x38]
	str r1, [sp, #0x44]
	beq _02054CE8
	mov r0, r0, asr #3
	str r0, [sp, #0x28]
_02054A9C:
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x3c]
	ldrh r2, [sl, #0x4e]
	mov r0, r1, asr r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x44]
	ldr sb, [sp, #0x34]
	and r0, r1, r0, lsr #16
	mov r0, r0, lsl #0x10
	sub r1, r2, r0, lsr #16
	mov fp, r0, lsr #0x10
	mov r1, r1, lsl #0x10
	ldr r0, [sp, #0x74]
	mov r5, r1, lsr #0x10
	cmp r0, r1, lsr #16
	movls r5, r0
	ldr r0, [sp, #0x30]
	ldr r7, [sp, #0x2c]
	cmp r0, #0
	mov r8, r0
	beq _02054BF8
	ldr r0, [sp, #0x28]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x40]
_02054B08:
	ldr r0, [sp, #0x38]
	ldrh r1, [sl, #0x4c]
	mov r0, sb, asr r0
	mov lr, r0, lsl #0x10
	ldr r0, [sp, #0x48]
	ldr ip, [sl, #0x40]
	and r0, sb, r0, lsr #16
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	sub r0, r1, r0, lsr #16
	mov r0, r0, lsl #0x10
	cmp r8, r0, lsr #16
	mov r6, r0, lsr #0x10
	movls r6, r8
	cmp ip, #0
	ldrh r0, [sl, #0x54]
	ldr ip, [sp, #0x24]
	ldr r3, [sl, #0x34]
	mul ip, r0, ip
	ldr r1, [sl, #0x48]
	add r0, ip, lr, lsr #16
	str r6, [sp]
	mla r0, r1, r0, r3
	str r5, [sp, #4]
	beq _02054BA0
	str r0, [sp, #8]
	ldrh r3, [sl, #0x56]
	ldr r0, [sp, #0x1c]
	ldr r1, [sp, #0x40]
	str r3, [sp, #0xc]
	str r2, [sp, #0x10]
	str fp, [sp, #0x14]
	ldrh ip, [sl, #0x32]
	mov r2, r7
	mov r3, r4
	str ip, [sp, #0x18]
	bl BackgroundUnknown__Func_204CAE4
	b _02054BD0
_02054BA0:
	str r0, [sp, #8]
	ldrh r3, [sl, #0x56]
	ldr r0, [sp, #0x1c]
	ldr r1, [sp, #0x40]
	str r3, [sp, #0xc]
	str r2, [sp, #0x10]
	str fp, [sp, #0x14]
	ldrh ip, [sl, #0x32]
	mov r2, r7
	mov r3, r4
	str ip, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
_02054BD0:
	sub r0, r8, r6
	mov r0, r0, lsl #0x10
	movs r8, r0, lsr #0x10
	add r0, sb, r6
	mov r0, r0, lsl #0x10
	mov sb, r0, asr #0x10
	add r0, r7, r6
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	bne _02054B08
_02054BF8:
	ldr r0, [sp, #0x74]
	sub r0, r0, r5
	mov r0, r0, lsl #0x10
	movs r0, r0, lsr #0x10
	str r0, [sp, #0x74]
	ldr r0, [sp, #0x20]
	add r0, r0, r5
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x20]
	add r0, r4, r5
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	bne _02054A9C
	b _02054CE8
_02054C34:
	ldr r1, [sl, #0x40]
	cmp r1, #0
	str r8, [sp]
	beq _02054C98
	ldr r1, [sp, #0x74]
	mov r3, sb, lsl #0x10
	str r1, [sp, #4]
	ldr r1, [sl, #0x34]
	str r1, [sp, #8]
	ldr r1, [sp, #0x20]
	mov r1, r1, lsl #0x10
	str r2, [sp, #0xc]
	mov r2, r3, lsr #0x10
	str r2, [sp, #0x10]
	mov r1, r1, lsr #0x10
	str r1, [sp, #0x14]
	mov r1, r0, lsl #0xd
	ldrh r5, [sl, #0x32]
	ldr r2, [sp, #0x2c]
	ldr r0, [sp, #0x1c]
	mov r3, r4
	mov r1, r1, lsr #0x10
	str r5, [sp, #0x18]
	bl BackgroundUnknown__Func_204CAE4
	b _02054CE8
_02054C98:
	ldr r1, [sp, #0x74]
	mov r3, sb, lsl #0x10
	str r1, [sp, #4]
	ldr r1, [sl, #0x34]
	str r1, [sp, #8]
	ldr r1, [sp, #0x20]
	mov r1, r1, lsl #0x10
	str r2, [sp, #0xc]
	mov r2, r3, lsr #0x10
	str r2, [sp, #0x10]
	mov r1, r1, lsr #0x10
	str r1, [sp, #0x14]
	mov r1, r0, lsl #0xd
	ldrh r5, [sl, #0x32]
	ldr r2, [sp, #0x2c]
	ldr r0, [sp, #0x1c]
	mov r3, r4
	mov r1, r1, lsr #0x10
	str r5, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
_02054CE8:
	mov r0, #0
	str r0, [sl, #0x5c]
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end MessageController__Draw
