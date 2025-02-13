	.include "asm/macros.inc"
	.include "global.inc"

    .text

	arm_func_start TalkHelpers__Func_2152F98
TalkHelpers__Func_2152F98: // 0x02152F98
	ldr ip, _02152FAC // =MIi_CpuClear32
	mov r1, r0
	mov r0, #0
	mov r2, #0x24
	bx ip
	.align 2, 0
_02152FAC: .word MIi_CpuClear32
	arm_func_end TalkHelpers__Func_2152F98

	arm_func_start TalkHelpersUnknown__Init
TalkHelpersUnknown__Init: // 0x02152FB0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r2
	mov r6, r0
	mov r5, r1
	mov r4, r3
	bl TalkHelpersUnknown__Release
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [r6]
	mov r2, #0
	str r2, [r6, #4]
	strh r2, [r6, #8]
	strh r2, [r6, #0xa]
	mov r0, #0x1000
	strh r0, [r6, #0xc]
	strh r0, [r6, #0xe]
	ldrh r1, [sp, #0x18]
	strh r4, [r6, #0x10]
	ldr r0, _02153060 // =0x0000FFFF
	strh r1, [r6, #0x12]
	strh r0, [r6, #0x14]
	str r2, [r6, #0x18]
	str r2, [r6, #0x1c]
	str r5, [r6, #0x20]
	mov r0, #0x800
	bl _AllocHeadHEAP_USER
	str r0, [r6, #0x18]
	mov r0, #0x20
	bl _AllocHeadHEAP_USER
	str r0, [r6, #0x1c]
	ldrh r1, [sp, #0x1c]
	ldr r0, [r6, #0x18]
	bl TalkHelpers__Func_2153388
	ldr r0, [r6, #0]
	orr r0, r0, #0x10000
	str r0, [r6]
	ldr r0, [r6, #0x1c]
	ldr r1, [r6, #0x20]
	ldrsh r2, [r6, #0xe]
	bl TalkHelpersUnknown2__Func_21534E4
	ldr r0, [r6, #0]
	orr r0, r0, #0x20000
	str r0, [r6]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02153060: .word 0x0000FFFF
	arm_func_end TalkHelpersUnknown__Init

	arm_func_start TalkHelpersUnknown__Release
TalkHelpersUnknown__Release: // 0x02153064
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	beq _02153084
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x1c]
_02153084:
	ldr r0, [r4, #0x18]
	cmp r0, #0
	beq _0215309C
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x18]
_0215309C:
	mov r0, r4
	bl TalkHelpers__Func_2152F98
	ldmia sp!, {r4, pc}
	arm_func_end TalkHelpersUnknown__Release

	arm_func_start TalkHelpers__Func_21530A8
TalkHelpers__Func_21530A8: // 0x021530A8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x34
	mov r7, r0
	ldr r0, [r7, #4]
	mov r1, #6
	mov r4, #0
	bl FX_DivS32
	mov r1, #6
	bl FX_ModS32
	ldr r1, _02153320 // =ovl05_02172420
	mov r0, r0, lsl #1
	ldrh r5, [r1, r0]
	ldrh r0, [r7, #0x14]
	cmp r5, r0
	strneh r5, [r7, #0x14]
	ldrh r0, [r7, #0x12]
	movne r4, #1
	ldrh r1, [r7, #0x10]
	cmp r0, #2
	ldrne r0, _02153324 // =VRAMSystem__GFXControl
	ldrne r0, [r0, r1, lsl #2]
	addne r6, r0, #0x40
	bne _02153110
	ldr r0, _02153324 // =VRAMSystem__GFXControl
	ldr r0, [r0, r1, lsl #2]
	add r6, r0, #0x28
_02153110:
	ldrsh r1, [r7, #0xc]
	mov r0, r6
	mov r2, r1
	bl MTX_Scale22_
	mov r0, #0x20
	strh r0, [r6, #0x10]
	strh r0, [r6, #0x12]
	ldrsh r1, [r6, #0x10]
	ldrsh r0, [r7, #8]
	cmp r4, #0
	sub r0, r1, r0
	strh r0, [r6, #0x14]
	ldrsh r1, [r6, #0x12]
	ldrsh r0, [r7, #0xa]
	sub r0, r1, r0
	strh r0, [r6, #0x16]
	beq _021531DC
	ldr r0, [r7, #0]
	tst r0, #1
	bne _021531DC
	ldrh r1, [r7, #0x12]
	ldrh r0, [r7, #0x10]
	add r2, sp, #0x22
	add r3, sp, #0x20
	and r1, r1, #0xff
	bl GetVRAMCharacterConfig
	ldrh r0, [sp, #0x20]
	ldrh r3, [r7, #0x10]
	ldr r2, _02153328 // =VRAMSystem__VRAM_BG
	ldrh r1, [sp, #0x22]
	mov r0, r0, lsl #0xe
	ldr r2, [r2, r3, lsl #2]
	add r1, r0, r1, lsl #16
	ldr r0, [r7, #0x20]
	add r4, r2, r1
	bl GetBackgroundPixels
	ldr r1, [r7, #0]
	add r0, r0, #4
	tst r1, #8
	add r0, r0, r5, lsl #10
	add r3, r4, #0x40
	mov r1, #0x400
	mov r2, #0
	beq _021531C8
	bl LoadUncompressedPixels
	b _021531CC
_021531C8:
	bl QueueUncompressedPixels
_021531CC:
	mov r1, r4
	mov r0, #0
	mov r2, #0x40
	bl MIi_CpuClear32
_021531DC:
	ldr r0, [r7, #0]
	tst r0, #0x10000
	beq _021532A4
	tst r0, #2
	bne _021532A4
	add r0, sp, #0x24
	str r0, [sp]
	ldrh r1, [r7, #0x12]
	ldrh r0, [r7, #0x10]
	add r2, sp, #0x30
	add r3, sp, #0x26
	and r1, r1, #0xff
	bl GetVRAMTileConfig
	ldr r0, [r7, #0]
	mov r1, #0
	tst r0, #0x10
	mov r0, #1
	str r0, [sp]
	mov r3, #0x20
	beq _02153264
	ldr r0, [sp, #0x30]
	mov r2, r1
	str r0, [sp, #4]
	ldrh r0, [sp, #0x26]
	str r0, [sp, #8]
	ldrh r0, [sp, #0x24]
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	str r3, [sp, #0x18]
	str r3, [sp, #0x1c]
	ldr r0, [r7, #0x18]
	bl Mappings__LoadUnknown
	b _02153298
_02153264:
	ldr r0, [sp, #0x30]
	mov r2, r1
	str r0, [sp, #4]
	ldrh r0, [sp, #0x26]
	str r0, [sp, #8]
	ldrh r0, [sp, #0x24]
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	str r3, [sp, #0x18]
	str r3, [sp, #0x1c]
	ldr r0, [r7, #0x18]
	bl Mappings__ReadMappingsCompressed
_02153298:
	ldr r0, [r7, #0]
	bic r0, r0, #0x10000
	str r0, [r7]
_021532A4:
	ldr r0, [r7, #0]
	tst r0, #0x20000
	beq _0215330C
	tst r0, #4
	bne _0215330C
	ldrh r1, [r7, #0x12]
	ldrh r0, [r7, #0x10]
	add r2, sp, #0x2c
	add r3, sp, #0x28
	and r1, r1, #0xff
	bl GetVRAMPaletteConfig
	ldr r0, [r7, #0]
	mov r1, #0x10
	tst r0, #0x20
	ldr r0, [r7, #0x1c]
	beq _021532F4
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x28]
	bl LoadUncompressedPalette
	b _02153300
_021532F4:
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x28]
	bl QueueUncompressedPalette
_02153300:
	ldr r0, [r7, #0]
	bic r0, r0, #0x20000
	str r0, [r7]
_0215330C:
	ldr r0, [r7, #4]
	add r0, r0, #1
	str r0, [r7, #4]
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02153320: .word ovl05_02172420
_02153324: .word VRAMSystem__GFXControl
_02153328: .word VRAMSystem__VRAM_BG
	arm_func_end TalkHelpers__Func_21530A8

	arm_func_start TalkHelpers__Func_215332C
TalkHelpers__Func_215332C: // 0x0215332C
	strh r1, [r0, #8]
	strh r2, [r0, #0xa]
	bx lr
	arm_func_end TalkHelpers__Func_215332C

	arm_func_start TalkHelpers__Func_2153338
TalkHelpers__Func_2153338: // 0x02153338
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, r1
	bl FX_Inv
	strh r0, [r4, #0xc]
	ldmia sp!, {r4, pc}
	arm_func_end TalkHelpers__Func_2153338

	arm_func_start TalkHelpers__Func_2153350
TalkHelpers__Func_2153350: // 0x02153350
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrsh r0, [r4, #0xe]
	cmp r0, r1
	ldmeqia sp!, {r4, pc}
	strh r1, [r4, #0xe]
	ldrsh r2, [r4, #0xe]
	ldr r0, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	bl TalkHelpersUnknown2__Func_21534E4
	ldr r0, [r4, #0]
	orr r0, r0, #0x20000
	str r0, [r4]
	ldmia sp!, {r4, pc}
	arm_func_end TalkHelpers__Func_2153350

	arm_func_start TalkHelpers__Func_2153388
TalkHelpers__Func_2153388: // 0x02153388
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r4, r0
	mov r5, r1
	mov r1, r4
	mov r0, #0
	mov r2, #0x800
	bl MIi_CpuClearFast
	mov r2, r5, lsl #0xc
	mov r5, #0
	orr r0, r2, #0x800
	orr r1, r2, #0xc00
	orr r3, r2, #0x400
	mov r9, r4
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r3, lsl #0x10
	mov r10, #1
	mov ip, r5
	mov lr, r5
_021533D8:
	mov r8, r10, lsl #0x10
	mov r7, r9
	mov r6, lr
	mov r8, r8, lsr #0x10
_021533E8:
	add r11, r8, #1
	mov r11, r11, lsl #0x10
	orr r8, r8, r2, lsr #16
	strh r8, [r7], #2
	mov r8, r11, lsr #0x10
	add r6, r6, #1
	cmp r6, #4
	blt _021533E8
	add r6, r5, #1
	mov r7, r6, lsl #0x12
	mov r8, ip
	add r6, r9, #8
	mov r7, r7, lsr #0x10
_0215341C:
	sub r11, r7, #1
	mov r11, r11, lsl #0x10
	orr r7, r7, r3, lsr #16
	strh r7, [r6], #2
	mov r7, r11, lsr #0x10
	add r8, r8, #1
	cmp r8, #4
	blt _0215341C
	add r5, r5, #1
	cmp r5, #4
	add r9, r9, #0x40
	add r10, r10, #4
	blt _021533D8
	mov r3, #0
	mov r7, r3
	mov r2, r3
_0215345C:
	rsb r5, r3, #3
	mov r5, r5, lsl #2
	add r6, r3, #4
	add r5, r5, #1
	add r8, r4, r6, lsl #6
	mov r5, r5, lsl #0x10
	mov r9, r8
	mov r10, r2
	mov r6, r5, lsr #0x10
_02153480:
	add r5, r6, #1
	orr r6, r6, r0, lsr #16
	mov r5, r5, lsl #0x10
	add r10, r10, #1
	cmp r10, #4
	strh r6, [r9], #2
	mov r6, r5, lsr #0x10
	blt _02153480
	rsb r5, r3, #4
	mov r5, r5, lsl #0x12
	mov r9, r7
	add r8, r8, #8
	mov r6, r5, lsr #0x10
_021534B4:
	sub r5, r6, #1
	orr r6, r6, r1, lsr #16
	mov r5, r5, lsl #0x10
	add r9, r9, #1
	cmp r9, #4
	strh r6, [r8], #2
	mov r6, r5, lsr #0x10
	blt _021534B4
	add r3, r3, #1
	cmp r3, #4
	blt _0215345C
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end TalkHelpers__Func_2153388

	.rodata

.public ovl05_02172420
ovl05_02172420: // 0x02172420
    .hword 0, 1, 2, 3, 4, 5