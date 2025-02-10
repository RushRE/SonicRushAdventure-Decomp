	.include "asm/macros.inc"
	.include "global.inc"

    .text

	arm_func_start TalkHelpersUnknown2__Func_21534E4
TalkHelpersUnknown2__Func_21534E4: // 0x021534E4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r9, r0
	mov r0, r1
	mov r8, r2
	bl GetBackgroundPalette
	mov r7, #0
	add r6, r0, #4
	mov r5, r7
	mov r4, #0x1000
_02153508:
	mov r0, r7, lsl #1
	ldrh r0, [r6, r0]
	mov r1, r5
	mov r2, r4
	mov r0, r0, lsl #0x1b
	mov r3, r8
	mov r0, r0, lsr #0xf
	bl Unknown2051334__Func_20516B8
	mov r2, r0, asr #0xc
	orr r1, r2, r2, lsl #5
	mov r0, r7, lsl #1
	orr r1, r1, r2, lsl #10
	add r7, r7, #1
	strh r1, [r9, r0]
	cmp r7, #0x10
	blt _02153508
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end TalkHelpersUnknown2__Func_21534E4

	arm_func_start TalkHelpersUnknown2__Func_215354C
TalkHelpersUnknown2__Func_215354C: // 0x0215354C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r8, r0
	mov r7, r2
	mov r6, r3
	str r1, [r8]
	add r1, sp, #8
	str r1, [sp]
	add r2, sp, #0xc
	add r3, sp, #0xa
	mov r0, r7
	and r1, r6, #0xff
	bl GetVRAMTileConfig
	ldrh r0, [sp, #8]
	ldr r2, _0215360C // =VRAMSystem__VRAM_BG
	ldrh r5, [sp, #0x28]
	mov r1, r0, lsl #0xb
	ldrh r3, [sp, #0xa]
	ldr r4, [r2, r7, lsl #2]
	mov r0, r5, lsl #0x1c
	add r1, r1, r3, lsl #16
	mov r0, r0, lsr #0x10
	mov r2, #0x800
	add r1, r4, r1
	bl MIi_CpuClear32
	and r1, r6, #0xff
	mov r0, r7
	add r2, sp, #6
	add r3, sp, #4
	bl GetVRAMCharacterConfig
	ldrh r1, [sp, #4]
	ldrh r3, [sp, #6]
	ldr r0, _02153610 // =0x11111111
	mov r1, r1, lsl #0xe
	add r1, r1, r3, lsl #16
	mov r2, #0x20
	add r1, r4, r1
	bl MIi_CpuClear32
	mov r0, r5, lsl #5
	add r0, r0, #2
	str r0, [r8, #4]
	ldr r0, [r8, #4]
	cmp r7, #0
	addne r0, r0, #0x400
	add r0, r0, #0x5000000
	str r0, [r8, #4]
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215360C: .word VRAMSystem__VRAM_BG
_02153610: .word 0x11111111
	arm_func_end TalkHelpersUnknown2__Func_215354C

	arm_func_start TalkHelpersUnknown2__Func_2153614
TalkHelpersUnknown2__Func_2153614: // 0x02153614
	stmdb sp!, {r3, lr}
	strh r1, [r0, #8]
	ldr r1, [r0, #0]
	tst r1, #1
	ldmneia sp!, {r3, pc}
	tst r1, #2
	ldr r3, [r0, #4]
	mov r1, #1
	add r0, r0, #8
	mov r2, #0
	beq _02153648
	bl LoadUncompressedPalette
	ldmia sp!, {r3, pc}
_02153648:
	bl QueueUncompressedPalette
	ldmia sp!, {r3, pc}
	arm_func_end TalkHelpersUnknown2__Func_2153614