	.include "asm/macros.inc"
	.include "global.inc"

    .text

	arm_func_start viMessageController__SetCtrlFile
viMessageController__SetCtrlFile: // 0x02152B80
	ldr r2, _02152B94 // =0x0000FFFF
	str r1, [r0]
	strh r2, [r0, #4]
	strh r2, [r0, #6]
	bx lr
	.align 2, 0
_02152B94: .word 0x0000FFFF
	arm_func_end viMessageController__SetCtrlFile

	arm_func_start viMessageController__GetMPCFile
viMessageController__GetMPCFile: // 0x02152B98
	ldr r0, [r0, #0]
	ldrh r0, [r0, #4]
	bx lr
	arm_func_end viMessageController__GetMPCFile

	arm_func_start viMessageController__SetInteractionID
viMessageController__SetInteractionID: // 0x02152BA4
	ldr r2, _02152BB4 // =0x0000FFFF
	strh r1, [r0, #4]
	strh r2, [r0, #6]
	bx lr
	.align 2, 0
_02152BB4: .word 0x0000FFFF
	arm_func_end viMessageController__SetInteractionID

	arm_func_start viMessageController__GetPageCount
viMessageController__GetPageCount: // 0x02152BB8
	ldr r2, [r0, #0]
	ldrh r0, [r0, #4]
	ldr r1, [r2, #0xc]
	mov r3, #0
	add r1, r2, r1
	add r2, r1, r0, lsl #3
	ldr r0, _02152BFC // =0x0000FFFF
_02152BD4:
	mov r1, r3, lsl #1
	ldrh r1, [r2, r1]
	cmp r1, r0
	beq _02152BF0
	add r3, r3, #1
	cmp r3, #4
	blt _02152BD4
_02152BF0:
	mov r0, r3, lsl #0x10
	mov r0, r0, lsr #0x10
	bx lr
	.align 2, 0
_02152BFC: .word 0x0000FFFF
	arm_func_end viMessageController__GetPageCount

	arm_func_start viMessageController__SetPageID
viMessageController__SetPageID: // 0x02152C00
	stmdb sp!, {r3, lr}
	ldr lr, [r0]
	ldrh r3, [r0, #4]
	ldr ip, [lr, #0xc]
	mov r2, r1, lsl #1
	add r1, lr, ip
	add r1, r1, r3, lsl #3
	ldrh r1, [r2, r1]
	strh r1, [r0, #6]
	ldmia sp!, {r3, pc}
	arm_func_end viMessageController__SetPageID

	arm_func_start viMessageController__HasName
viMessageController__HasName: // 0x02152C28
	ldr ip, [r0]
	ldrh r1, [r0, #6]
	ldr r3, [ip, #0x10]
	ldr r0, _02152C54 // =0x0000FFFF
	mov r2, r1, lsl #4
	add r1, ip, r3
	ldrh r1, [r2, r1]
	cmp r1, r0
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_02152C54: .word 0x0000FFFF
	arm_func_end viMessageController__HasName

	arm_func_start viMessageController__GetNameAnim
viMessageController__GetNameAnim: // 0x02152C58
	ldr r3, [r0, #0]
	ldrh r0, [r0, #6]
	ldr r2, [r3, #0x10]
	mov r1, r0, lsl #4
	add r0, r3, r2
	ldrh r0, [r1, r0]
	bx lr
	arm_func_end viMessageController__GetNameAnim

	arm_func_start viMessageController__GetPageSequence
viMessageController__GetPageSequence: // 0x02152C74
	ldr r2, [r0, #0]
	ldrh r1, [r0, #6]
	ldr r0, [r2, #0x10]
	add r0, r2, r0
	add r0, r0, r1, lsl #4
	ldrh r0, [r0, #2]
	bx lr
	arm_func_end viMessageController__GetPageSequence

	arm_func_start viMessageController__IsDialogIDValid
viMessageController__IsDialogIDValid: // 0x02152C90
	ldr r3, [r0, #0]
	ldrh r2, [r0, #6]
	ldr r1, [r3, #0x10]
	ldr r0, _02152CBC // =0x0000FFFF
	add r1, r3, r1
	add r1, r1, r2, lsl #4
	ldrh r1, [r1, #4]
	cmp r1, r0
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_02152CBC: .word 0x0000FFFF
	arm_func_end viMessageController__IsDialogIDValid

	arm_func_start viMessageController__GetDialogID
viMessageController__GetDialogID: // 0x02152CC0
	ldr r2, [r0, #0]
	ldrh r1, [r0, #6]
	ldr r0, [r2, #0x10]
	add r0, r2, r0
	add r0, r0, r1, lsl #4
	ldrh r0, [r0, #4]
	bx lr
	arm_func_end viMessageController__GetDialogID

	arm_func_start viMessageController__IsDialogIDValid_2
viMessageController__IsDialogIDValid_2: // 0x02152CDC
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr ip, [r5]
	ldrh r2, [r5, #6]
	ldr r3, [ip, #0x10]
	mov r4, r1
	add r1, ip, r3
	add r1, r1, r2, lsl #4
	add r6, r1, #8
	bl viMessageController__IsDialogIDValid
	cmp r0, #0
	ldreqh r0, [r6, #0]
	movne r0, r4, lsl #1
	ldrneh r0, [r6, r0]
	strh r0, [r5, #6]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end viMessageController__IsDialogIDValid_2

	arm_func_start viMessageController__Entry3Enabled2
viMessageController__Entry3Enabled2: // 0x02152D1C
	ldrh r1, [r0, #6]
	ldr r0, _02152D40 // =0x0000FFFF
	cmp r1, r0
	moveq r0, #0
	bxeq lr
	cmp r1, #0x8000
	movhs r0, #1
	movlo r0, #0
	bx lr
	.align 2, 0
_02152D40: .word 0x0000FFFF
	arm_func_end viMessageController__Entry3Enabled2

	arm_func_start viMessageController__GetEntry3ValueFromID
viMessageController__GetEntry3ValueFromID: // 0x02152D44
	ldrh r1, [r0, #6]
	ldr r3, [r0, #0]
	sub r0, r1, #0x8000
	ldr r2, [r3, #0x14]
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0xe
	add r0, r3, r2
	ldrh r0, [r1, r0]
	bx lr
	arm_func_end viMessageController__GetEntry3ValueFromID

	arm_func_start viMessageController__GetEntry3Value2
viMessageController__GetEntry3Value2: // 0x02152D68
	ldr r2, [r0, #0]
	ldrh r0, [r0, #6]
	ldr r1, [r2, #0x14]
	sub r0, r0, #0x8000
	mov r0, r0, lsl #0x10
	add r1, r2, r1
	add r0, r1, r0, lsr #14
	ldrh r0, [r0, #2]
	bx lr
	arm_func_end viMessageController__GetEntry3Value2

	arm_func_start viMessageController__Entry3Enabled
viMessageController__Entry3Enabled: // 0x02152D8C
	ldrh r0, [r0, #6]
	cmp r0, #0x8000
	movhs r0, #1
	movlo r0, #0
	bx lr
	arm_func_end viMessageController__Entry3Enabled