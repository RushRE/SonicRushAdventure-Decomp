	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start FontAnimator__Init
FontAnimator__Init: // 0x02058448
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl FontAnimatorCore__Init
	mov r0, #0
	str r0, [r4, #8]
	strh r0, [r4, #0xc]
	strh r0, [r4, #0xe]
	strh r0, [r4, #0x10]
	strh r0, [r4, #0x12]
	mov r1, #0xa
	add r0, r4, #0x20
	str r1, [r4, #0x1c]
	bl MessageController__Init
	mov r1, #0
	str r1, [r4, #0x94]
	str r1, [r4, #0x98]
	mov r0, #3
	str r0, [r4, #0xa4]
	str r1, [r4, #0xb8]
	str r1, [r4, #0xbc]
	str r1, [r4, #0xc0]
	ldmia sp!, {r4, pc}
	arm_func_end FontAnimator__Init

	arm_func_start FontAnimator__LoadFont1
FontAnimator__LoadFont1: // 0x020584A0
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, lr}
	sub sp, sp, #0x10
	mov r4, r0
	mov r6, r1
	mov r7, r2
	mov r5, r3
	bl FontAnimator__Release
	mov r0, r4
	mov r1, r6
	bl FontAnimatorCore__LoadFont
	ldrh r3, [sp, #0x34]
	ldrh r1, [sp, #0x38]
	str r7, [r4, #8]
	add r2, r3, #3
	bic r2, r2, #3
	strh r2, [r4, #0x14]
	add r2, r1, #1
	bic r2, r2, #1
	strh r2, [r4, #0x16]
	ldrh r0, [sp, #0x30]
	strh r5, [r4, #0xc]
	strh r0, [r4, #0xe]
	strh r3, [r4, #0x10]
	strh r1, [r4, #0x12]
	mov r0, #2
	strh r0, [r4, #0x18]
	mov r0, #1
	strh r0, [r4, #0x1a]
	add r0, r4, #0x9c
	bl FontField_9C__Init
	mov r0, #1
	str r0, [r4, #0x1c]
	ldrh r1, [r4, #0x14]
	ldrh r0, [r4, #0x16]
	mul r0, r1, r0
	mov r5, r0, lsl #5
	mov r0, r5
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x94]
	ldr r1, [r4, #0x94]
	mov r2, r5
	mov r0, #0
	bl MIi_CpuClearFast
	mov r0, r6
	bl FontWindow__GetFont
	mov r1, r0
	add r0, r4, #0x20
	bl MessageController__SetFont
	ldrh r2, [r4, #0x18]
	mov r1, #0
	add r0, r4, #0x20
	str r2, [sp]
	ldrh r2, [r4, #0x1a]
	str r2, [sp, #4]
	str r1, [sp, #8]
	ldrh r2, [r4, #0x14]
	ldrh r3, [r4, #0x16]
	ldr r1, [r4, #0x94]
	bl MessageController__Setup
	mov r0, #0
	str r0, [r4, #0x98]
	str r0, [r4, #0xa4]
	ldr r0, [sp, #0x3c]
	ldrb r1, [sp, #0x40]
	str r0, [r4, #0xa8]
	ldrb r3, [sp, #0x44]
	strb r1, [r4, #0xac]
	add r2, sp, #0xe
	strb r3, [r4, #0xad]
	add r3, sp, #0xc
	bl GetVRAMCharacterConfig
	ldr r0, [sp, #0x3c]
	ldrh r1, [sp, #0xc]
	cmp r0, #0
	ldrh r2, [sp, #0xe]
	mov r0, r1, lsl #0xe
	add r0, r0, r2, lsl #16
	addeq r1, r0, #0x6000000
	addne r1, r0, #0x6200000
	ldr r0, [sp, #0x48]
	add r0, r1, r0, lsl #5
	str r0, [r4, #0xb0]
	ldrh r1, [r4, #0x10]
	ldrh r0, [r4, #0x12]
	mul r0, r1, r0
	mov r0, r0, lsl #1
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0xb4]
	ldrh r0, [r4, #0x12]
	ldrb r1, [sp, #0x44]
	ldr r2, [sp, #0x48]
	cmp r0, #0
	orr r0, r2, r1, lsl #12
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	mov r5, #0
	ble _020586C0
	mov r2, r5
	mov r3, r5
	mov ip, r5
_02058630:
	ldrh r0, [r4, #0x10]
	mov lr, ip
	cmp r0, #0
	ble _020586B0
_02058640:
	mov r7, r3
_02058644:
	mov r6, r2
	add sb, r5, r7
_0205864C:
	ldrh r1, [r4, #0x10]
	add r0, lr, r6
	cmp r0, r1
	ldrlth r0, [r4, #0x12]
	cmplt sb, r0
	bge _0205867C
	mul r0, r1, sb
	ldr sl, [r4, #0xb4]
	mov r1, r6, lsl #1
	add sl, sl, lr, lsl #1
	add r0, sl, r0, lsl #1
	strh r8, [r1, r0]
_0205867C:
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	add r6, r6, #1
	cmp r6, #4
	mov r8, r0, lsr #0x10
	blt _0205864C
	add r7, r7, #1
	cmp r7, #2
	blt _02058644
	ldrh r0, [r4, #0x10]
	add lr, lr, #4
	cmp lr, r0
	blt _02058640
_020586B0:
	ldrh r0, [r4, #0x12]
	add r5, r5, #2
	cmp r5, r0
	blt _02058630
_020586C0:
	ldr r1, _020586EC // =FontAnimator__DefaultThingCallback
	mov r2, r4
	add r0, r4, #0x20
	bl MessageController__SetCallback
	ldrh r1, [r4, #0x14]
	ldrh r0, [r4, #0x16]
	mul r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	.align 2, 0
_020586EC: .word FontAnimator__DefaultThingCallback
	arm_func_end FontAnimator__LoadFont1

	arm_func_start FontAnimator__LoadFont2
FontAnimator__LoadFont2: // 0x020586F0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r6, r0
	mov r5, r1
	mov r7, r2
	mov r4, r3
	bl FontAnimator__Release
	mov r0, r6
	mov r1, r5
	bl FontAnimatorCore__LoadFont
	ldrh r3, [sp, #0x24]
	ldrh r1, [sp, #0x28]
	str r7, [r6, #8]
	add r2, r3, #3
	bic r2, r2, #3
	strh r2, [r6, #0x14]
	add r2, r1, #1
	bic r2, r2, #1
	strh r2, [r6, #0x16]
	ldrh r0, [sp, #0x20]
	strh r4, [r6, #0xc]
	strh r0, [r6, #0xe]
	strh r3, [r6, #0x10]
	strh r1, [r6, #0x12]
	mov r0, #2
	strh r0, [r6, #0x18]
	mov r0, #1
	strh r0, [r6, #0x1a]
	add r0, r6, #0x9c
	bl FontField_9C__Init
	mov r0, #1
	str r0, [r6, #0x1c]
	ldrh r1, [r6, #0x14]
	ldrh r0, [r6, #0x16]
	mul r0, r1, r0
	mov r4, r0, lsl #5
	mov r0, r4
	bl _AllocHeadHEAP_USER
	str r0, [r6, #0x94]
	ldr r1, [r6, #0x94]
	mov r2, r4
	mov r0, #0
	bl MIi_CpuClearFast
	mov r0, r5
	bl FontWindow__GetFont
	mov r1, r0
	add r0, r6, #0x20
	bl MessageController__SetFont
	ldrh r2, [r6, #0x18]
	mov r1, #0
	add r0, r6, #0x20
	str r2, [sp]
	ldrh r2, [r6, #0x1a]
	str r2, [sp, #4]
	str r1, [sp, #8]
	ldrh r2, [r6, #0x14]
	ldrh r3, [r6, #0x16]
	ldr r1, [r6, #0x94]
	bl MessageController__Setup
	mov r2, #0
	ldr r1, [sp, #0x2c]
	str r2, [r6, #0x98]
	mov r0, #1
	str r0, [r6, #0xa4]
	str r1, [r6, #0xa8]
	strh r2, [r6, #0xac]
	cmp r1, #0
	ldrb r0, [sp, #0x30]
	strh r2, [r6, #0xae]
	ldrb r1, [sp, #0x34]
	strb r0, [r6, #0xb0]
	ldrb r0, [sp, #0x38]
	strb r1, [r6, #0xb1]
	strb r0, [r6, #0xb2]
	ldrh r2, [r6, #0x14]
	ldrh r0, [r6, #0x16]
	mul r1, r2, r0
	ldrne r2, _020588A8 // =0x04001000
	ldrne r0, _020588AC // =0x00300010
	ldrne r2, [r2]
	bne _02058840
	mov r0, #0x4000000
	ldr r2, [r0]
	ldr r0, _020588AC // =0x00300010
_02058840:
	and r3, r2, r0
	ldr r2, _020588B0 // =0x00100010
	cmp r3, r2
	bgt _0205885C
	bge _02058880
	cmp r3, #0x10
	b _02058884
_0205885C:
	add r0, r2, #0x100000
	cmp r3, r0
	bgt _02058870
	moveq r1, r1, lsr #2
	b _02058884
_02058870:
	add r0, r2, #0x200000
	cmp r3, r0
	moveq r1, r1, lsr #3
	b _02058884
_02058880:
	mov r1, r1, lsr #1
_02058884:
	ldr r0, [sp, #0x2c]
	bl VRAMSystem__AllocSpriteVram
	str r0, [r6, #0xb4]
	ldr r1, _020588B4 // =FontAnimator__DefaultThingCallback
	mov r2, r6
	add r0, r6, #0x20
	bl MessageController__SetCallback
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020588A8: .word 0x04001000
_020588AC: .word 0x00300010
_020588B0: .word 0x00100010
_020588B4: .word FontAnimator__DefaultThingCallback
	arm_func_end FontAnimator__LoadFont2

	arm_func_start FontAnimator__Release
FontAnimator__Release: // 0x020588B8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xa4]
	cmp r0, #0
	beq _020588D8
	cmp r0, #1
	beq _020588F4
	b _02058910
_020588D8:
	ldr r0, [r4, #0xb4]
	cmp r0, #0
	beq _02058910
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0xb4]
	b _02058910
_020588F4:
	ldr r1, [r4, #0xb4]
	cmp r1, #0
	beq _02058910
	ldr r0, [r4, #0xa8]
	bl VRAMSystem__FreeSpriteVram
	mov r0, #0
	str r0, [r4, #0xb4]
_02058910:
	add r0, r4, #0x20
	bl MessageController__InitFunc
	ldr r0, [r4, #0x94]
	cmp r0, #0
	beq _02058930
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x94]
_02058930:
	mov r0, r4
	bl FontAnimatorCore__Release
	mov r0, r4
	bl FontAnimator__Init
	ldmia sp!, {r4, pc}
	arm_func_end FontAnimator__Release

	arm_func_start FontAnimator__EnableFlags
FontAnimator__EnableFlags: // 0x02058944
	ldr r2, [r0, #8]
	orr r1, r2, r1
	str r1, [r0, #8]
	bx lr
	arm_func_end FontAnimator__EnableFlags

	arm_func_start FontAnimator__DisableFlags
FontAnimator__DisableFlags: // 0x02058954
	ldr r2, [r0, #8]
	mvn r1, r1
	and r1, r2, r1
	str r1, [r0, #8]
	bx lr
	arm_func_end FontAnimator__DisableFlags

	arm_func_start FontAnimator__LoadMPCFile
FontAnimator__LoadMPCFile: // 0x02058968
	ldr ip, _02058974 // =MessageController__LoadMPCFile
	add r0, r0, #0x20
	bx ip
	.align 2, 0
_02058974: .word MessageController__LoadMPCFile
	arm_func_end FontAnimator__LoadMPCFile

	arm_func_start FontAnimator__SetCallbackType
FontAnimator__SetCallbackType: // 0x02058978
	str r1, [r0, #0x1c]
	bx lr
	arm_func_end FontAnimator__SetCallbackType

	arm_func_start FontAnimator__InitStartPos
FontAnimator__InitStartPos: // 0x02058980
	stmdb sp!, {r3, lr}
	ldrh ip, [r0, #0x14]
	ldrh r3, [r0, #0x10]
	cmp r3, ip
	bhs _020589D0
	cmp r1, #1
	beq _020589A8
	cmp r1, #2
	beq _020589C0
	b _020589D0
_020589A8:
	sub r3, ip, r3
	mov r3, r3, lsl #3
	sub r2, r2, r3, asr #1
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
	b _020589D0
_020589C0:
	sub r3, ip, r3
	sub r2, r2, r3, lsl #3
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
_020589D0:
	add r0, r0, #0x20
	bl MessageController__InitStartPos
	ldmia sp!, {r3, pc}
	arm_func_end FontAnimator__InitStartPos

	arm_func_start FontAnimator__AdvanceLine
FontAnimator__AdvanceLine: // 0x020589DC
	ldr ip, _020589E8 // =MessageController__AdvanceLine
	add r0, r0, #0x20
	bx ip
	.align 2, 0
_020589E8: .word MessageController__AdvanceLine
	arm_func_end FontAnimator__AdvanceLine

	arm_func_start FontAnimator__AdvanceXPos
FontAnimator__AdvanceXPos: // 0x020589EC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	add r1, sp, #0
	add r0, r5, #0x20
	mov r2, #0
	bl MessageController__GetPosition
	ldrsh r1, [sp]
	add r0, r5, #0x20
	add r1, r1, r4
	mov r1, r1, lsl #0x10
	mov r1, r1, asr #0x10
	bl MessageController__SetPosX
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end FontAnimator__AdvanceXPos

	arm_func_start FontAnimator__GetMsgPosition
FontAnimator__GetMsgPosition: // 0x02058A24
	ldr ip, _02058A30 // =MessageController__GetPosition
	add r0, r0, #0x20
	bx ip
	.align 2, 0
_02058A30: .word MessageController__GetPosition
	arm_func_end FontAnimator__GetMsgPosition

	arm_func_start FontAnimator__SetCallback
FontAnimator__SetCallback: // 0x02058A34
	str r1, [r0, #0xb8]
	str r2, [r0, #0xbc]
	bx lr
	arm_func_end FontAnimator__SetCallback

	arm_func_start FontAnimator__SetMsgSequence
FontAnimator__SetMsgSequence: // 0x02058A40
	ldr ip, _02058A4C // =MessageController__SetSequence
	add r0, r0, #0x20
	bx ip
	.align 2, 0
_02058A4C: .word MessageController__SetSequence
	arm_func_end FontAnimator__SetMsgSequence

	arm_func_start FontAnimator__GetCurrentSequence
FontAnimator__GetCurrentSequence: // 0x02058A50
	ldr ip, _02058A5C // =MessageController__GetCurrentSequence
	add r0, r0, #0x20
	bx ip
	.align 2, 0
_02058A5C: .word MessageController__GetCurrentSequence
	arm_func_end FontAnimator__GetCurrentSequence

	arm_func_start FontAnimator__GetSequenceDialogCount
FontAnimator__GetSequenceDialogCount: // 0x02058A60
	ldr ip, _02058A6C // =MessageController__GetSequenceDialogCount
	add r0, r0, #0x20
	bx ip
	.align 2, 0
_02058A6C: .word MessageController__GetSequenceDialogCount
	arm_func_end FontAnimator__GetSequenceDialogCount

	arm_func_start FontAnimator__GetDialogLineCount
FontAnimator__GetDialogLineCount: // 0x02058A70
	ldr ip, _02058A7C // =MessageController__GetDialogLineCount
	add r0, r0, #0x20
	bx ip
	.align 2, 0
_02058A7C: .word MessageController__GetDialogLineCount
	arm_func_end FontAnimator__GetDialogLineCount

	arm_func_start FontAnimator__SetDialog
FontAnimator__SetDialog: // 0x02058A80
	ldr ip, _02058A8C // =MessageController__SetDialog
	add r0, r0, #0x20
	bx ip
	.align 2, 0
_02058A8C: .word MessageController__SetDialog
	arm_func_end FontAnimator__SetDialog

	arm_func_start FontAnimator__GetDialogID
FontAnimator__GetDialogID: // 0x02058A90
	ldr ip, _02058A9C // =MessageController__GetDialogID
	add r0, r0, #0x20
	bx ip
	.align 2, 0
_02058A9C: .word MessageController__GetDialogID
	arm_func_end FontAnimator__GetDialogID

	arm_func_start FontAnimator__LoadCharacters
FontAnimator__LoadCharacters: // 0x02058AA0
	ldr ip, _02058AAC // =MessageController__Func_2053EF4
	add r0, r0, #0x20
	bx ip
	.align 2, 0
_02058AAC: .word MessageController__Func_2053EF4
	arm_func_end FontAnimator__LoadCharacters

	arm_func_start FontAnimator__IsEndOfLine
FontAnimator__IsEndOfLine: // 0x02058AB0
	ldr ip, _02058ABC // =MessageController__Func_2054364
	add r0, r0, #0x20
	bx ip
	.align 2, 0
_02058ABC: .word MessageController__Func_2054364
	arm_func_end FontAnimator__IsEndOfLine

	arm_func_start FontAnimator__AdvanceDialog
FontAnimator__AdvanceDialog: // 0x02058AC0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x20
	bl MessageController__AdvanceDialog
	add r0, r4, #0x20
	bl MessageController__Func_2054308
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end FontAnimator__AdvanceDialog

	arm_func_start FontAnimator__IsLastDialog
FontAnimator__IsLastDialog: // 0x02058AE8
	ldr ip, _02058AF4 // =MessageController__Func_2054308
	add r0, r0, #0x20
	bx ip
	.align 2, 0
_02058AF4: .word MessageController__Func_2054308
	arm_func_end FontAnimator__IsLastDialog

	arm_func_start FontAnimator__ClearPixels
FontAnimator__ClearPixels: // 0x02058AF8
	ldr ip, _02058B04 // =MessageController__Func_205442C
	add r0, r0, #0x20
	bx ip
	.align 2, 0
_02058B04: .word MessageController__Func_205442C
	arm_func_end FontAnimator__ClearPixels

	arm_func_start FontAnimator__Draw
FontAnimator__Draw: // 0x02058B08
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x1c
	mov r7, r0
	add r0, r7, #0x20
	bl MessageController__Func_2054488
	mov r4, r0
	add r0, r7, #0x20
	bl MessageController__Func_20544B4
	mov r5, r0
	add r1, sp, #0x14
	add r2, sp, #0xc
	add r0, r7, #0x20
	bl MessageController__Func_20544E0
	cmp r4, #0
	beq _02058B90
	cmp r5, #0
	beq _02058BA0
	ldrh r1, [sp, #0xc]
	ldrh r0, [sp, #0x14]
	cmp r1, r0
	strloh r1, [sp, #0x14]
	ldrh r1, [sp, #0xe]
	ldrh r0, [sp, #0x16]
	cmp r1, r0
	strloh r1, [sp, #0x16]
	ldrh r1, [sp, #0x10]
	ldrh r0, [sp, #0x18]
	cmp r1, r0
	strhih r1, [sp, #0x18]
	ldrh r1, [sp, #0x12]
	ldrh r0, [sp, #0x1a]
	cmp r1, r0
	strhih r1, [sp, #0x1a]
	b _02058BA0
_02058B90:
	add r0, sp, #0xc
	add r1, sp, #0x14
	mov r2, #8
	bl MIi_CpuCopy32
_02058BA0:
	cmp r4, #0
	cmpeq r5, #0
	addne r5, sp, #0x14
	moveq r5, #0
	add r0, r7, #0x9c
	mov r1, r5
	mov r2, r0
	bl FontField_9C__Func_2059670
	ldr r0, [r7, #8]
	tst r0, #0x40
	bne _02058C44
	add r0, r7, #0x9c
	bl FontField_9C__IsInvalid
	cmp r0, #0
	movne r3, #0
	ldr r0, [r7, #0xa4]
	addeq r3, r7, #0x9c
	cmp r0, #0
	beq _02058BF8
	cmp r0, #1
	beq _02058C14
	b _02058C3C
_02058BF8:
	ldr r1, [r7, #0x94]
	mov r0, r7
	str r1, [sp]
	ldr r2, [r7, #8]
	add r1, r7, #0xa8
	bl FontAnimator__Apply0
	b _02058C3C
_02058C14:
	ldr r1, [r7, #0x94]
	mov r0, r7
	str r1, [sp]
	ldrh r2, [r7, #0xc]
	add r1, r7, #0xa8
	str r2, [sp, #4]
	ldrh r2, [r7, #0xe]
	str r2, [sp, #8]
	ldr r2, [r7, #8]
	bl FontAnimator__Apply1
_02058C3C:
	add r0, r7, #0x9c
	bl FontField_9C__Init
_02058C44:
	ldr r6, [r7, #0xc0]
	cmp r6, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r4, #0
_02058C58:
	add r0, r6, #8
	mov r1, r5
	mov r2, r0
	bl FontField_9C__Func_2059670
	ldr r0, [r6]
	tst r0, #0x40
	bne _02058CEC
	add r0, r6, #8
	bl FontField_9C__IsInvalid
	cmp r0, #0
	movne r3, r4
	ldr r0, [r6, #0x10]
	addeq r3, r6, #8
	cmp r0, #0
	beq _02058CA0
	cmp r0, #1
	beq _02058CBC
	b _02058CE4
_02058CA0:
	ldr r1, [r7, #0x94]
	mov r0, r7
	str r1, [sp]
	ldr r2, [r6]
	add r1, r6, #0x14
	bl FontAnimator__Apply0
	b _02058CE4
_02058CBC:
	ldr r1, [r7, #0x94]
	mov r0, r7
	str r1, [sp]
	ldrh r2, [r6, #4]
	add r1, r6, #0x14
	str r2, [sp, #4]
	ldrh r2, [r6, #6]
	str r2, [sp, #8]
	ldr r2, [r6]
	bl FontAnimator__Apply1
_02058CE4:
	add r0, r6, #8
	bl FontField_9C__Init
_02058CEC:
	ldr r6, [r6, #0x24]
	cmp r6, #0
	bne _02058C58
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end FontAnimator__Draw

	arm_func_start FontAnimator__LoadMappingsFunc
FontAnimator__LoadMappingsFunc: // 0x02058D00
	stmdb sp!, {r3, lr}
	ldrh r2, [r0, #0xe]
	add r1, r0, #0xa8
	str r2, [sp]
	ldrh r3, [r0, #0xc]
	ldr r2, [r0, #8]
	bl FontAnimator__LoadMappings
	ldmia sp!, {r3, pc}
	arm_func_end FontAnimator__LoadMappingsFunc

	arm_func_start FontAnimator__LoadPaletteFunc
FontAnimator__LoadPaletteFunc: // 0x02058D20
	ldr ip, _02058D30 // =FontAnimator__LoadPalette
	ldr r2, [r0, #8]
	add r1, r0, #0xa8
	bx ip
	.align 2, 0
_02058D30: .word FontAnimator__LoadPalette
	arm_func_end FontAnimator__LoadPaletteFunc

	arm_func_start FontAnimator__LoadPaletteFunc2
FontAnimator__LoadPaletteFunc2: // 0x02058D34
	ldr ip, _02058D44 // =FontAnimator__LoadPalette2
	ldr r2, [r0, #8]
	add r1, r0, #0xa8
	bx ip
	.align 2, 0
_02058D44: .word FontAnimator__LoadPalette2
	arm_func_end FontAnimator__LoadPaletteFunc2

	arm_func_start FontAnimator__Func_2058D48
FontAnimator__Func_2058D48: // 0x02058D48
	strh r1, [r0, #0xac]
	strh r2, [r0, #0xae]
	bx lr
	arm_func_end FontAnimator__Func_2058D48

	arm_func_start FontUnknown2058D78__Func_2058D54
FontUnknown2058D78__Func_2058D54: // 0x02058D54
	mov r2, #0
	str r2, [r0]
	strh r2, [r0, #4]
	strh r2, [r0, #6]
	mov r1, #3
	str r1, [r0, #0x10]
	str r2, [r0, #0x24]
	str r2, [r0, #0x28]
	bx lr
	arm_func_end FontUnknown2058D78__Func_2058D54

	arm_func_start FontUnknown2058D78__Init
FontUnknown2058D78__Init: // 0x02058D78
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	mov r4, r1
	mov r7, r2
	mov r6, r3
	bl FontUnknown2058D78__Release
	str r7, [r5]
	ldrh r1, [sp, #0x18]
	strh r6, [r5, #4]
	add r0, r5, #8
	strh r1, [r5, #6]
	bl FontField_9C__Init
	ldr r2, [sp, #0x1c]
	mov r0, #1
	str r0, [r5, #0x10]
	str r2, [r5, #0x14]
	mov r1, #0
	strh r1, [r5, #0x18]
	strh r1, [r5, #0x1a]
	ldrb r0, [sp, #0x20]
	ldrb r1, [sp, #0x24]
	cmp r2, #0
	strb r0, [r5, #0x1c]
	ldrb r0, [sp, #0x28]
	strb r1, [r5, #0x1d]
	strb r0, [r5, #0x1e]
	ldrh r2, [r4, #0x14]
	ldrh r0, [r4, #0x16]
	mul r1, r2, r0
	ldrne r2, _02058E68 // =0x04001000
	ldrne r0, _02058E6C // =0x00300010
	ldrne r2, [r2]
	bne _02058E08
	mov r0, #0x4000000
	ldr r2, [r0]
	ldr r0, _02058E6C // =0x00300010
_02058E08:
	and r3, r2, r0
	ldr r2, _02058E70 // =0x00100010
	cmp r3, r2
	bgt _02058E24
	bge _02058E48
	cmp r3, #0x10
	b _02058E4C
_02058E24:
	add r0, r2, #0x100000
	cmp r3, r0
	bgt _02058E38
	moveq r1, r1, lsr #2
	b _02058E4C
_02058E38:
	add r0, r2, #0x200000
	cmp r3, r0
	moveq r1, r1, lsr #3
	b _02058E4C
_02058E48:
	mov r1, r1, lsr #1
_02058E4C:
	ldr r0, [sp, #0x1c]
	bl VRAMSystem__AllocSpriteVram
	str r0, [r5, #0x20]
	mov r0, r4
	mov r1, r5
	bl FontAnimator__AddUnknown
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02058E68: .word 0x04001000
_02058E6C: .word 0x00300010
_02058E70: .word 0x00100010
	arm_func_end FontUnknown2058D78__Init

	arm_func_start FontUnknown2058D78__Release
FontUnknown2058D78__Release: // 0x02058E74
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x28]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r1
	mov r1, r4
	bl FontAnimator__RemoveUnknown
	ldr r0, [r4, #0x10]
	cmp r0, #0
	beq _02058EAC
	cmp r0, #1
	beq _02058EC8
	b _02058EE4
_02058EAC:
	ldr r0, [r4, #0x20]
	cmp r0, #0
	beq _02058EE4
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x20]
	b _02058EE4
_02058EC8:
	ldr r1, [r4, #0x20]
	cmp r1, #0
	beq _02058EE4
	ldr r0, [r4, #0x14]
	bl VRAMSystem__FreeSpriteVram
	mov r0, #0
	str r0, [r4, #0x20]
_02058EE4:
	mov r0, r4
	bl FontUnknown2058D78__Func_2058D54
	ldmia sp!, {r4, pc}
	arm_func_end FontUnknown2058D78__Release

	arm_func_start FontUnknown2058D78__EnableFlags
FontUnknown2058D78__EnableFlags: // 0x02058EF0
	ldr r2, [r0]
	orr r1, r2, r1
	str r1, [r0]
	bx lr
	arm_func_end FontUnknown2058D78__EnableFlags

	arm_func_start FontUnknown2058D78__DisableFlags
FontUnknown2058D78__DisableFlags: // 0x02058F00
	ldr r2, [r0]
	mvn r1, r1
	and r1, r2, r1
	str r1, [r0]
	bx lr
	arm_func_end FontUnknown2058D78__DisableFlags

	arm_func_start FontUnknown2058D78__LoadPalette2
FontUnknown2058D78__LoadPalette2: // 0x02058F14
	ldr ip, _02058F28 // =FontAnimator__LoadPalette2
	mov r1, r0
	ldr r0, [r1, #0x28]
	ldr r2, [r1], #0x14
	bx ip
	.align 2, 0
_02058F28: .word FontAnimator__LoadPalette2
	arm_func_end FontUnknown2058D78__LoadPalette2

	arm_func_start FontUnknown2058D78__Func_2058F2C
FontUnknown2058D78__Func_2058F2C: // 0x02058F2C
	strh r1, [r0, #0x18]
	strh r2, [r0, #0x1a]
	bx lr
	arm_func_end FontUnknown2058D78__Func_2058F2C

	arm_func_start FontAnimator__Apply0
FontAnimator__Apply0: // 0x02058F38
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #8
	str r0, [sp]
	str r1, [sp, #4]
	tst r2, #2
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	cmp r3, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldrh r1, [r3, #6]
	ldrh r4, [r3, #4]
	ldrh r5, [r3]
	ldrh r0, [r3, #2]
	add r3, r1, #0xf
	mov r6, r5, asr #5
	mov r1, r0, lsl #0xc
	add r4, r4, #0x1f
	mov r0, r4, lsl #0xb
	mov r5, r3, lsl #0xc
	mov sb, r1, lsr #0x10
	cmp sb, r5, lsr #16
	mov r4, r6, lsl #0x10
	addhs sp, sp, #8
	mov r0, r0, lsr #0x10
	ldmhsia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	sub r0, r0, r4, lsr #16
	cmp sb, r5, lsr #16
	mov r8, r0, lsl #8
	addhs sp, sp, #8
	ldmhsia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr fp, [sp, #0x30]
	and sl, r2, #0x10
_02058FBC:
	ldr r0, [sp]
	mov r1, r8
	ldrh r2, [r0, #0x14]
	ldr r0, [sp, #4]
	mov r2, r2, asr #2
	mul r3, r2, sb
	add r2, r3, r4, lsr #16
	ldr r0, [r0, #8]
	add r6, fp, r2, lsl #8
	add r7, r0, r2, lsl #8
	mov r0, r6
	bl DC_StoreRange
	cmp sl, #0
	mov r0, r6
	mov r2, #0
	mov r1, r8
	beq _0205900C
	mov r3, r7
	bl LoadUncompressedPixels
	b _02059014
_0205900C:
	mov r3, r7
	bl QueueUncompressedPixels
_02059014:
	add r0, sb, #1
	mov r0, r0, lsl #0x10
	mov sb, r0, lsr #0x10
	cmp sb, r5, lsr #16
	blo _02058FBC
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end FontAnimator__Apply0

	arm_func_start FontAnimator__Apply1
FontAnimator__Apply1: // 0x02059030
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x18
	mov sl, r0
	mov sb, r1
	tst r2, #2
	bne _02059118
	cmp r3, #0
	beq _02059118
	ldrh r4, [r3, #4]
	ldrh r1, [r3, #6]
	ldrh r0, [r3, #2]
	ldrh r5, [r3]
	add r4, r4, #0x1f
	add r3, r1, #0xf
	mov r1, r0, lsl #0xc
	mov r5, r5, asr #5
	mov r0, r4, lsl #0xb
	mov r4, r3, lsl #0xc
	mov r7, r1, lsr #0x10
	cmp r7, r4, lsr #16
	mov fp, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bhs _02059118
	sub r0, r0, fp, lsr #16
	cmp r7, r4, lsr #16
	mov r8, r0, lsl #8
	bhs _02059118
	ldr r0, [sp, #0x40]
	str r0, [sp, #4]
	and r0, r2, #0x10
	str r0, [sp]
_020590AC:
	ldrh r0, [sl, #0x14]
	ldr r2, [sb, #0xc]
	mov r1, r8
	mov r0, r0, asr #2
	mul r3, r0, r7
	add r3, r3, fp, lsr #16
	ldr r0, [sp, #4]
	add r6, r2, r3, lsl #8
	add r5, r0, r3, lsl #8
	mov r0, r5
	bl DC_StoreRange
	ldr r0, [sp]
	mov r2, #0
	cmp r0, #0
	mov r0, r5
	mov r1, r8
	beq _020590FC
	mov r3, r6
	bl LoadUncompressedPixels
	b _02059104
_020590FC:
	mov r3, r6
	bl QueueUncompressedPixels
_02059104:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, r4, lsr #16
	blo _020590AC
_02059118:
	ldr r0, [sb]
	ldr r8, [sp, #0x40]
	cmp r0, #0
	ldr r0, [sb, #0xc]
	bne _02059140
	mov r1, #0x4000000
	sub r0, r0, #0x6400000
	mov r0, r0, lsl #0xb
	ldr r2, [r1]
	b _02059150
_02059140:
	ldr r1, _020592B8 // =0x04001000
	sub r0, r0, #0x6600000
	ldr r2, [r1]
	mov r0, r0, lsl #0xb
_02059150:
	ldr r1, _020592BC // =0x00300010
	mov r7, r0, lsr #0x10
	and r1, r2, r1
	cmp r1, #0x10
	beq _02059184
	ldr r0, _020592C0 // =0x00100010
	cmp r1, r0
	beq _0205918C
	add r0, r0, #0x100000
	cmp r1, r0
	beq _02059194
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
_02059184:
	mov r2, #0
	b _02059198
_0205918C:
	mov r2, #1
	b _02059198
_02059194:
	mov r2, #2
_02059198:
	mov r3, r7, asr r2
	mov r0, #8
	mov r2, r0, asr r2
	ldrh r1, [sl, #0x16]
	mov r0, r3, lsl #0x10
	mov r7, r0, lsr #0x10
	mov r0, r2, lsl #0x10
	str r0, [sp, #0x14]
	mov r0, #0
	cmp r1, #0
	str r0, [sp, #0x10]
	addle sp, sp, #0x18
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldrh r0, [sp, #0x48]
	str r0, [sp, #0xc]
	ldrh r0, [sp, #0x44]
	str r0, [sp, #8]
_020591DC:
	ldrsh r2, [sb, #6]
	ldr r0, [sp, #0xc]
	ldrh r1, [sl, #0x14]
	add r0, r2, r0, lsl #3
	mov r0, r0, lsl #0x10
	mov r6, #0
	cmp r1, #0
	mov r0, r0, lsr #0x10
	ble _02059288
	and r0, r0, #0xff
	orr r0, r0, #0x4000
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	ldr r0, _020592C4 // =0x000001FF
	add fp, r0, #0x200
_02059218:
	ldr r0, [sp, #8]
	ldrsh r2, [sb, #4]
	add r1, r0, r6
	ldr r0, [sb]
	add r1, r2, r1, lsl #3
	mov r4, r1, lsl #0x10
	ldrb r1, [sb, #9]
	bl OAMSystem__Alloc
	ldr r1, _020592C4 // =0x000001FF
	strh r5, [r0]
	and r1, r1, r4, lsr #16
	orr r1, r1, #0x8000
	strh r1, [r0, #2]
	ldr r1, [sp, #0x14]
	and r2, r7, fp
	add r1, r7, r1, lsr #16
	mov r1, r1, lsl #0x10
	mov r7, r1, lsr #0x10
	ldrb r1, [sb, #8]
	ldrb r3, [sb, #0xa]
	add r6, r6, #4
	orr r1, r2, r1, lsl #10
	orr r1, r1, r3, lsl #12
	strh r1, [r0, #4]
	ldrh r0, [sl, #0x14]
	add r8, r8, #0x100
	cmp r6, r0
	blt _02059218
_02059288:
	ldr r0, [sp, #0x10]
	ldrh r1, [sl, #0x16]
	add r0, r0, #2
	str r0, [sp, #0x10]
	ldr r0, [sp, #0xc]
	add r0, r0, #2
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x10]
	cmp r0, r1
	blt _020591DC
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_020592B8: .word 0x04001000
_020592BC: .word 0x00300010
_020592C0: .word 0x00100010
_020592C4: .word 0x000001FF
	arm_func_end FontAnimator__Apply1

	arm_func_start FontAnimator__LoadMappings
FontAnimator__LoadMappings: // 0x020592C8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x28
	mov r7, r2
	tst r7, #4
	mov r6, r0
	mov r5, r1
	mov r4, r3
	addne sp, sp, #0x28
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	add r0, sp, #0x20
	str r0, [sp]
	ldrb r1, [r5, #4]
	ldr r0, [r5]
	add r2, sp, #0x24
	add r3, sp, #0x22
	bl GetVRAMTileConfig
	tst r7, #0x20
	ldrh r3, [r6, #0x10]
	mov r1, #0
	beq _02059360
	str r1, [sp]
	ldr ip, [sp, #0x24]
	ldrh r0, [sp, #0x40]
	str ip, [sp, #4]
	ldrh ip, [sp, #0x22]
	mov r2, r1
	str ip, [sp, #8]
	ldrh ip, [sp, #0x20]
	str ip, [sp, #0xc]
	str r4, [sp, #0x10]
	str r0, [sp, #0x14]
	str r3, [sp, #0x18]
	ldrh r0, [r6, #0x12]
	str r0, [sp, #0x1c]
	ldr r0, [r5, #0xc]
	bl Mappings__LoadUnknown
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02059360:
	str r1, [sp]
	ldr ip, [sp, #0x24]
	ldrh r0, [sp, #0x40]
	str ip, [sp, #4]
	ldrh ip, [sp, #0x22]
	mov r2, r1
	str ip, [sp, #8]
	ldrh ip, [sp, #0x20]
	str ip, [sp, #0xc]
	str r4, [sp, #0x10]
	str r0, [sp, #0x14]
	str r3, [sp, #0x18]
	ldrh r0, [r6, #0x12]
	str r0, [sp, #0x1c]
	ldr r0, [r5, #0xc]
	bl Mappings__ReadMappingsCompressed
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end FontAnimator__LoadMappings

	arm_func_start FontAnimator__LoadPalette
FontAnimator__LoadPalette: // 0x020593A8
	stmdb sp!, {r3, lr}
	tst r2, #1
	ldmneia sp!, {r3, pc}
	ldr r3, [r1]
	ldr r0, [r0, #0x1c]
	cmp r3, #0
	ldrb r3, [r1, #5]
	moveq ip, #0x5000000
	ldrne ip, _02059400 // =0x05000400
	ldr r1, _02059404 // =0x02110458
	mov r3, r3, lsl #5
	tst r2, #8
	add r2, r3, #2
	add r0, r1, r0, lsl #3
	add r3, ip, r2
	mov r1, #4
	mov r2, #0
	beq _020593F8
	bl LoadUncompressedPalette
	ldmia sp!, {r3, pc}
_020593F8:
	bl QueueUncompressedPalette
	ldmia sp!, {r3, pc}
	.align 2, 0
_02059400: .word 0x05000400
_02059404: .word FontAnimator__Palettes
	arm_func_end FontAnimator__LoadPalette

	arm_func_start FontAnimator__LoadPalette2
FontAnimator__LoadPalette2: // 0x02059408
	stmdb sp!, {r3, lr}
	tst r2, #1
	ldmneia sp!, {r3, pc}
	ldr r3, [r1]
	ldr r0, [r0, #0x1c]
	cmp r3, #0
	ldrb r3, [r1, #0xa]
	ldreq ip, _02059460 // =0x05000200
	ldr r1, _02059464 // =0x02110458
	ldrne ip, _02059468 // =0x05000600
	add r0, r1, r0, lsl #3
	mov r3, r3, lsl #5
	tst r2, #8
	add r2, r3, #2
	add r3, ip, r2
	mov r1, #4
	mov r2, #0
	beq _02059458
	bl LoadUncompressedPalette
	ldmia sp!, {r3, pc}
_02059458:
	bl QueueUncompressedPalette
	ldmia sp!, {r3, pc}
	.align 2, 0
_02059460: .word 0x05000200
_02059464: .word FontAnimator__Palettes
_02059468: .word 0x05000600
	arm_func_end FontAnimator__LoadPalette2

	arm_func_start FontAnimator__DefaultThingCallback
FontAnimator__DefaultThingCallback: // 0x0205946C
	stmdb sp!, {r3, lr}
	cmp r0, #9
	addls pc, pc, r0, lsl #2
	b _02059514
_0205947C: // jump table
	b _02059514 // case 0
	b _02059514 // case 1
	b _02059514 // case 2
	b _020594A4 // case 3
	b _020594B4 // case 4
	b _020594C4 // case 5
	b _020594D4 // case 6
	b _020594E4 // case 7
	b _020594F4 // case 8
	b _02059504 // case 9
_020594A4:
	mov r0, r2
	mov r1, #2
	bl MessageController__CallbackFunc
	ldmia sp!, {r3, pc}
_020594B4:
	mov r0, r2
	mov r1, #3
	bl MessageController__CallbackFunc
	ldmia sp!, {r3, pc}
_020594C4:
	mov r0, r2
	mov r1, #4
	bl MessageController__CallbackFunc
	ldmia sp!, {r3, pc}
_020594D4:
	mov r0, r2
	mov r1, #5
	bl MessageController__CallbackFunc
	ldmia sp!, {r3, pc}
_020594E4:
	mov r0, r2
	mov r1, #6
	bl MessageController__CallbackFunc
	ldmia sp!, {r3, pc}
_020594F4:
	mov r0, r2
	mov r1, #7
	bl MessageController__CallbackFunc
	ldmia sp!, {r3, pc}
_02059504:
	ldr r1, [r2, #0x1c]
	mov r0, r2
	bl MessageController__CallbackFunc
	ldmia sp!, {r3, pc}
_02059514:
	ldr r3, [r2, #0xb8]
	cmp r3, #0
	ldmeqia sp!, {r3, pc}
	mov r1, r2
	ldr r2, [r2, #0xbc]
	blx r3
	ldmia sp!, {r3, pc}
	arm_func_end FontAnimator__DefaultThingCallback

	arm_func_start MessageController__CallbackFunc
MessageController__CallbackFunc: // 0x02059530
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x1c]
	mov r4, r1
	cmp r0, r4
	add r0, r5, #0x20
	bne _02059558
	mov r1, #0
	bl MessageController__SetCallbackValue
	ldmia sp!, {r3, r4, r5, pc}
_02059558:
	mov r1, #5
	bl MessageController__SetCallbackValue
	ldr r0, [r5, #8]
	tst r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, [r5, #0xa4]
	cmp r1, #0
	ldr r1, [r5, #0xa8]
	bne _02059590
	cmp r1, #0
	moveq r2, #0x5000000
	ldrne r2, _020595D8 // =0x05000400
	ldrb r1, [r5, #0xad]
	b _020595A0
_02059590:
	cmp r1, #0
	ldreq r2, _020595DC // =0x05000200
	ldrb r1, [r5, #0xb2]
	ldrne r2, _020595E0 // =0x05000600
_020595A0:
	mov r1, r1, lsl #5
	add r1, r1, #2
	add r2, r2, r1
	ldr r1, _020595E4 // =0x02110458
	tst r0, #8
	add r0, r1, r4, lsl #3
	add r3, r2, #0xa
	mov r1, #4
	mov r2, #0
	beq _020595D0
	bl LoadUncompressedPalette
	ldmia sp!, {r3, r4, r5, pc}
_020595D0:
	bl QueueUncompressedPalette
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_020595D8: .word 0x05000400
_020595DC: .word 0x05000200
_020595E0: .word 0x05000600
_020595E4: .word FontAnimator__Palettes
	arm_func_end MessageController__CallbackFunc

	arm_func_start FontAnimator__AddUnknown
FontAnimator__AddUnknown: // 0x020595E8
	str r0, [r1, #0x28]
	ldr r2, [r0, #0xc0]
	add r0, r0, #0xc0
	cmp r2, #0
	beq _0205960C
_020595FC:
	add r0, r2, #0x24
	ldr r2, [r2, #0x24]
	cmp r2, #0
	bne _020595FC
_0205960C:
	str r1, [r0]
	mov r0, #0
	str r0, [r1, #0x24]
	bx lr
	arm_func_end FontAnimator__AddUnknown

	arm_func_start FontAnimator__RemoveUnknown
FontAnimator__RemoveUnknown: // 0x0205961C
	ldr r3, [r0, #0xc0]
	add r2, r0, #0xc0
	cmp r3, #0
	beq _0205964C
_0205962C:
	cmp r3, r1
	ldreq r0, [r1, #0x24]
	streq r0, [r2]
	beq _0205964C
	add r2, r3, #0x24
	ldr r3, [r3, #0x24]
	cmp r3, #0
	bne _0205962C
_0205964C:
	mov r0, #0
	str r0, [r1, #0x28]
	bx lr
	arm_func_end FontAnimator__RemoveUnknown

    .rodata

FontAnimator__Palettes: // 0x02110458
	.hword 0x3E74, 0x1D4C, 0, 0 // colors
	.hword 0x6BFF, 0x1A34, 0, 0 // colors
	.hword 0x209F, 0x17, 0, 0   // colors
	.hword 0x3E0, 0x3E0, 0, 0   // colors
	.hword 0x7C00, 0x7C00, 0, 0 // colors
	.hword 0x7F40, 0x5E00, 0, 0 // colors
	.hword 0x7DFF, 0x4013, 0, 0 // colors
	.hword 0x3FF, 0x234, 0, 0   // colors
	.hword 9, 0x2613, 0x533A, 0 // colors
