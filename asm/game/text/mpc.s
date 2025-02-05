	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start MPC__GetSequenceCount
MPC__GetSequenceCount: // 0x02053810
	ldrh r0, [r0, #0xa]
	bx lr
	arm_func_end MPC__GetSequenceCount

	arm_func_start MPC__GetSequenceDialogCount
MPC__GetSequenceDialogCount: // 0x02053818
	ldr r2, [r0, #0x10]
	mov r1, r1, lsl #3
	add r0, r0, r2
	ldrh r0, [r1, r0]
	bx lr
	arm_func_end MPC__GetSequenceDialogCount

	arm_func_start MPC__GetDisplayLineLength
MPC__GetDisplayLineLength: // 0x0205382C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r10, r0
	ldr r0, [r10, #0x10]
	ldr r3, [r10, #0x14]
	mov r9, r1
	add r0, r10, r0
	add r0, r0, r9, lsl #3
	ldrh r0, [r0, #2]
	mov r8, r2
	mov r7, #0
	add r0, r8, r0
	mov r0, r0, lsl #0x10
	add r5, r10, r3
	mov r4, r0, lsr #0xe
	ldrh r0, [r5, r4]
	mov r6, r7
	cmp r0, #0
	ble _020538A8
_02053874:
	mov r3, r6, lsl #0x10
	mov r0, r10
	mov r1, r9
	mov r2, r8
	mov r3, r3, lsr #0x10
	bl MPC__GetLineLength
	add r0, r7, r0
	mov r0, r0, lsl #0x10
	ldrh r1, [r5, r4]
	add r6, r6, #1
	mov r7, r0, lsr #0x10
	cmp r6, r1
	blt _02053874
_020538A8:
	mov r0, r7
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end MPC__GetDisplayLineLength

	arm_func_start MPC__GetDialogLineCount
MPC__GetDialogLineCount: // 0x020538B0
	ldr r3, [r0, #0x10]
	ldr ip, [r0, #0x14]
	add r3, r0, r3
	add r1, r3, r1, lsl #3
	ldrh r3, [r1, #2]
	add r1, r0, ip
	add r0, r2, r3
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0xe
	ldrh r0, [r0, r1]
	bx lr
	arm_func_end MPC__GetDialogLineCount

	arm_func_start MPC__GetLineLength
MPC__GetLineLength: // 0x020538DC
	stmdb sp!, {r4, lr}
	ldr ip, [r0, #0x10]
	ldr lr, [r0, #0x14]
	add ip, r0, ip
	add r1, ip, r1, lsl #3
	ldrh r1, [r1, #2]
	ldr r4, [r0, #0x18]
	add ip, r0, lr
	add r1, r2, r1
	mov r1, r1, lsl #0x10
	add r1, ip, r1, lsr #14
	ldrh r2, [r1, #2]
	add r1, r0, r4
	add r0, r3, r2
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0xe
	ldrh r0, [r0, r1]
	ldmia sp!, {r4, pc}
	arm_func_end MPC__GetLineLength

	arm_func_start MPC__GetCharacterFromOffset
MPC__GetCharacterFromOffset: // 0x02053924
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r0, #0x10]
	ldr r4, [r0, #0x14]
	add r5, r0, r5
	add lr, r5, r1, lsl #3
	ldrh r1, [lr, #2]
	ldr r5, [r0, #0x18]
	ldr ip, [r0, #0x1c]
	add r1, r1, r2
	add r2, r0, r4
	mov r1, r1, lsl #0x10
	add r1, r2, r1, lsr #14
	ldrh r2, [r1, #2]
	add r4, r0, r5
	ldrh r1, [sp, #0x10]
	add r2, r2, r3
	mov r2, r2, lsl #0x10
	add r2, r4, r2, lsr #14
	ldrh r3, [r2, #2]
	ldr r4, [lr, #4]
	ldrh r2, [r0, #8]
	add r3, r4, r3
	add r0, r0, ip
	add r1, r1, r3
	bl MPC__GetCharacter
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end MPC__GetCharacterFromOffset

	arm_func_start MPC__GetText
MPC__GetText: // 0x0205398C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	ldr r5, [sp, #0x24]
	bl MPC__GetLineLength
	ldrh ip, [sp, #0x20]
	add r1, ip, r5
	cmp r1, r0
	subgt r0, r0, ip
	movgt r0, r0, lsl #0x10
	ldr r1, [r4, #0x10]
	movgt r5, r0, lsr #0x10
	ldr r0, [sp, #0x28]
	add r1, r4, r1
	str r0, [sp]
	add r2, r1, r8, lsl #3
	ldrh r1, [r2, #2]
	ldr r3, [r4, #0x14]
	ldr r0, [r4, #0x18]
	add r1, r1, r7
	mov r1, r1, lsl #0x10
	add r3, r4, r3
	add r1, r3, r1, lsr #14
	ldrh r7, [r1, #2]
	add r3, r4, r0
	ldr r1, [r4, #0x1c]
	add r0, r7, r6
	mov r0, r0, lsl #0x10
	add r0, r3, r0, lsr #14
	ldr r3, [r2, #4]
	ldrh r0, [r0, #2]
	ldrh r2, [r4, #8]
	add r6, r3, r0
	add r0, r4, r1
	mov r3, r5
	add r1, ip, r6
	bl MPC__GetCharacters
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	arm_func_end MPC__GetText

	arm_func_start MPC__IsSpecialCharacter
MPC__IsSpecialCharacter: // 0x02053A38
	ldrh r0, [r0, #4]
	cmp r1, r0
	movls r0, #0
	bxls lr
	add r0, r0, #3
	cmp r1, r0
	movle r0, #1
	movgt r0, #0
	bx lr
	arm_func_end MPC__IsSpecialCharacter

	arm_func_start MPC__ShouldRunCallback
MPC__ShouldRunCallback: // 0x02053A5C
	ldrh r0, [r0, #4]
	add r0, r0, #3
	cmp r1, r0
	movgt r0, #1
	movle r0, #0
	bx lr
	arm_func_end MPC__ShouldRunCallback

	arm_func_start MPC__CheckRegularCharacter
MPC__CheckRegularCharacter: // 0x02053A74
	ldrh r0, [r0, #4]
	cmp r1, r0
	movls r0, #1
	movhi r0, #0
	bx lr
	arm_func_end MPC__CheckRegularCharacter

	arm_func_start MPC__GetSpecialCharacter
MPC__GetSpecialCharacter: // 0x02053A88
	ldrh r0, [r0, #4]
	add r0, r0, #1
	sub r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bx lr
	arm_func_end MPC__GetSpecialCharacter

	arm_func_start MPC__GetCharacter
MPC__GetCharacter: // 0x02053AA0
	stmdb sp!, {r3, r4, r5, lr}
	mul r1, r2, r1
	mov r5, r1, asr #5
	and r4, r1, #0x1f
	rsb r1, r4, #0x20
	sub ip, r2, r1
	ldr r1, _02053AFC // =MPC__decodeShiftTable
	sub r3, r2, #1
	ldr lr, [r0, r5, lsl #2]
	ldr r1, [r1, r3, lsl #2]
	cmp ip, #0
	add r3, r0, r5, lsl #2
	and r4, r1, lr, lsr r4
	ble _02053AF0
	ldr r0, _02053B00 // =0x02110388
	ldr r3, [r3, #4]
	ldr r1, [r0, ip, lsl #2]
	sub r0, r2, ip
	and r1, r3, r1
	orr r4, r4, r1, lsl r0
_02053AF0:
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02053AFC: .word MPC__decodeShiftTable
_02053B00: .word 0x02110388
	arm_func_end MPC__GetCharacter

	arm_func_start MPC__GetCharacters
MPC__GetCharacters: // 0x02053B04
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mul r4, r2, r1
	mov r1, r4, asr #5
	and lr, r4, #0x1f
	ldr r6, [sp, #0x20]
	mov r4, #0
	cmp r3, #0
	add r1, r0, r1, lsl #2
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r0, _02053B88 // =MPC__decodeShiftTable
	sub r5, r2, #1
	ldr r5, [r0, r5, lsl #2]
_02053B34:
	ldr r8, [r1, #0]
	rsb r7, lr, #0x20
	and ip, r5, r8, lsr lr
	sub lr, r2, r7
	cmp lr, #0
	ble _02053B68
	add r7, r0, lr, lsl #2
	ldr r9, [r1, #4]!
	ldr r8, [r7, #-4]
	sub r7, r2, lr
	and r8, r9, r8
	orr ip, ip, r8, lsl r7
	b _02053B70
_02053B68:
	addeq r1, r1, #4
	addne lr, lr, #0x20
_02053B70:
	mov r7, r4, lsl #1
	add r4, r4, #1
	strh ip, [r6, r7]
	cmp r4, r3
	blt _02053B34
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02053B88: .word MPC__decodeShiftTable
	arm_func_end MPC__GetCharacters

    .rodata
	
.public MPC__decodeShiftTable
MPC__decodeShiftTable: // 0x0211038C
	.word 1, 3, 7, 0xF, 0x1F, 0x3F, 0x7F, 0xFF, 0x1FF, 0x3FF
	.word 0x7FF, 0xFFF, 0x1FFF, 0x3FFF, 0x7FFF, 0xFFFF
