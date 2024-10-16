	.include "asm/macros.inc"
	.include "global.inc"

    .text

	arm_func_start TalkHelpers__Func_2152DA0
TalkHelpers__Func_2152DA0: // 0x02152DA0
	stmdb sp!, {r4, lr}
	ldr r4, _02152DD0 // =gameState+0xDC
	mov r0, #0
	mov r1, r4
	mov r2, #0x64
	bl MIi_CpuClear32
	mov r0, #0xff
	mov r1, #0
	strb r1, [r4]
	strb r0, [r4, #1]
	strb r0, [r4, #2]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02152DD0: .word gameState+0xDC
	arm_func_end TalkHelpers__Func_2152DA0

	arm_func_start TalkHelpers__Func_2152DD4
TalkHelpers__Func_2152DD4: // 0x02152DD4
	ldr r1, _02152DE0 // =gameState
	strb r0, [r1, #0xdd]
	bx lr
	.align 2, 0
_02152DE0: .word gameState
	arm_func_end TalkHelpers__Func_2152DD4

	arm_func_start TalkHelpers__Func_2152DE4
TalkHelpers__Func_2152DE4: // 0x02152DE4
	ldr r0, _02152DF0 // =gameState
	ldrb r0, [r0, #0xdd]
	bx lr
	.align 2, 0
_02152DF0: .word gameState
	arm_func_end TalkHelpers__Func_2152DE4

	arm_func_start TalkHelpers__Func_2152DF4
TalkHelpers__Func_2152DF4: // 0x02152DF4
	ldr r1, _02152E00 // =gameState
	strb r0, [r1, #0xde]
	bx lr
	.align 2, 0
_02152E00: .word gameState
	arm_func_end TalkHelpers__Func_2152DF4

	arm_func_start TalkHelpers__Func_2152E04
TalkHelpers__Func_2152E04: // 0x02152E04
	ldr r0, _02152E10 // =gameState
	ldrb r0, [r0, #0xde]
	bx lr
	.align 2, 0
_02152E10: .word gameState
	arm_func_end TalkHelpers__Func_2152E04

	arm_func_start TalkHelpers__Func_2152E14
TalkHelpers__Func_2152E14: // 0x02152E14
	stmdb sp!, {r4, r5, r6, lr}
	ldr r3, _02152E68 // =gameState+0x000000E0
	mov r6, r0
	mov r5, r1
	mov r4, r2
	add r1, r3, r6, lsl #4
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear32
	ldr r0, _02152E68 // =gameState+0x000000E0
	ldr r2, _02152E6C // =gameState+0x000000EE
	mov ip, r6, lsl #4
	ldrh r1, [r2, ip]
	add r6, r0, r6, lsl #4
	ldr r3, _02152E70 // =gameState+0x000000EC
	orr r0, r1, #1
	strh r0, [r2, ip]
	ldmia r5, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	strh r4, [r3, ip]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02152E68: .word gameState+0x000000E0
_02152E6C: .word gameState+0x000000EE
_02152E70: .word gameState+0x000000EC
	arm_func_end TalkHelpers__Func_2152E14

	arm_func_start TalkHelpers__Func_2152E74
TalkHelpers__Func_2152E74: // 0x02152E74
	ldr r1, _02152E90 // =gameState+0x000000EE
	mov r0, r0, lsl #4
	ldrh r0, [r1, r0]
	tst r0, #1
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_02152E90: .word gameState+0x000000EE
	arm_func_end TalkHelpers__Func_2152E74

	arm_func_start TalkHelpers__GetPlayerInfo
TalkHelpers__GetPlayerInfo: // 0x02152E94
	ldr r1, _02152EA0 // =gameState+0x000000E0
	add r0, r1, r0, lsl #4
	bx lr
	.align 2, 0
_02152EA0: .word gameState+0x000000E0
	arm_func_end TalkHelpers__GetPlayerInfo

	arm_func_start TalkHelpers__Func_2152EA4
TalkHelpers__Func_2152EA4: // 0x02152EA4
	ldr r1, _02152EB4 // =gameState+0x000000EC
	mov r0, r0, lsl #4
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02152EB4: .word gameState+0x000000EC
	arm_func_end TalkHelpers__Func_2152EA4

	arm_func_start TalkHelpers__Func_2152EB8
TalkHelpers__Func_2152EB8: // 0x02152EB8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r2
	mov r2, #0x14
	mul r4, r0, r2
	ldr r0, _02152F10 // =gameState+0x000000F0
	mov r7, r1
	add r5, r0, r4
	mov r1, r5
	mov r0, #0
	bl MIi_CpuClear32
	ldr r1, _02152F14 // =gameState+0x000000FE
	ldr lr, _02152F18 // =gameState+0x000000FC
	ldrh r0, [r1, r4]
	ldr r3, _02152F1C // =gameState+0x00000100
	mvn ip, #0
	orr r0, r0, #1
	strh r0, [r1, r4]
	ldmia r7, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	strh r6, [lr, r4]
	str ip, [r3, r4]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02152F10: .word gameState+0x000000F0
_02152F14: .word gameState+0x000000FE
_02152F18: .word gameState+0x000000FC
_02152F1C: .word gameState+0x00000100
	arm_func_end TalkHelpers__Func_2152EB8

	arm_func_start TalkHelpers__Func_2152F20
TalkHelpers__Func_2152F20: // 0x02152F20
	mov r1, #0x14
	mul r1, r0, r1
	ldr r0, _02152F40 // =gameState+0x000000FE
	ldrh r0, [r0, r1]
	tst r0, #1
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_02152F40: .word gameState+0x000000FE
	arm_func_end TalkHelpers__Func_2152F20

	arm_func_start TalkHelpers__GetNpcInfo
TalkHelpers__GetNpcInfo: // 0x02152F44
	ldr r2, _02152F54 // =gameState+0x000000F0
	mov r1, #0x14
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_02152F54: .word gameState+0x000000F0
	arm_func_end TalkHelpers__GetNpcInfo

	arm_func_start TalkHelpers__Func_2152F58
TalkHelpers__Func_2152F58: // 0x02152F58
	mov r1, #0x14
	mul r1, r0, r1
	ldr r0, _02152F6C // =gameState+0x000000FC
	ldrh r0, [r0, r1]
	bx lr
	.align 2, 0
_02152F6C: .word gameState+0x000000FC
	arm_func_end TalkHelpers__Func_2152F58

	arm_func_start TalkHelpers__Func_2152F70
TalkHelpers__Func_2152F70: // 0x02152F70
	mov r1, #0x14
	mul r1, r0, r1
	ldr r0, _02152F84 // =gameState+0x00000100
	ldr r0, [r0, r1]
	bx lr
	.align 2, 0
_02152F84: .word gameState+0x00000100
	arm_func_end TalkHelpers__Func_2152F70

	arm_func_start TalkHelpers__Func_2152F88
TalkHelpers__Func_2152F88: // 0x02152F88
	ldr r0, _02152F94 // =gameState
	ldrb r0, [r0, #0xdc]
	bx lr
	.align 2, 0
_02152F94: .word gameState
	arm_func_end TalkHelpers__Func_2152F88

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

	arm_func_start TalkHelpers__Func_2152FB0
TalkHelpers__Func_2152FB0: // 0x02152FB0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r2
	mov r6, r0
	mov r5, r1
	mov r4, r3
	bl TalkHelpers__Func_2153064
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
	bl TalkHelpers__Func_21534E4
	ldr r0, [r6, #0]
	orr r0, r0, #0x20000
	str r0, [r6]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02153060: .word 0x0000FFFF
	arm_func_end TalkHelpers__Func_2152FB0

	arm_func_start TalkHelpers__Func_2153064
TalkHelpers__Func_2153064: // 0x02153064
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
	arm_func_end TalkHelpers__Func_2153064

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
	ldr r1, _02153320 // =0x02172420
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
_02153320: .word 0x02172420
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
	bl TalkHelpers__Func_21534E4
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

	arm_func_start TalkHelpers__Func_21534E4
TalkHelpers__Func_21534E4: // 0x021534E4
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
	arm_func_end TalkHelpers__Func_21534E4

	arm_func_start TalkHelpers__Func_215354C
TalkHelpers__Func_215354C: // 0x0215354C
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
	arm_func_end TalkHelpers__Func_215354C

	arm_func_start TalkHelpers__Func_2153614
TalkHelpers__Func_2153614: // 0x02153614
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
	arm_func_end TalkHelpers__Func_2153614

	arm_func_start TalkHelpers__Func_2153650
TalkHelpers__Func_2153650: // 0x02153650
	ldr r1, _02153660 // =0x021725E0
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02153660: .word 0x021725E0
	arm_func_end TalkHelpers__Func_2153650

	arm_func_start TalkHelpers__GetInteractionID_2
TalkHelpers__GetInteractionID_2: // 0x02153664
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl TalkHelpers__Func_2153700
	ldr r1, _02153684 // =_021734E8
	mov r0, r0, lsl #1
	ldr r1, [r1, r4, lsl #2]
	ldrh r0, [r1, r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02153684: .word _021734E8
	arm_func_end TalkHelpers__GetInteractionID_2

	arm_func_start TalkHelpers__GetInteractionID2
TalkHelpers__GetInteractionID2: // 0x02153688
	stmdb sp!, {r3, lr}
	ldr r1, _021536A8 // =_021733E0
	ldr r0, [r1, r0, lsl #2]
	cmp r0, #0
	ldreq r0, _021536AC // =0x0000FFFF
	ldmeqia sp!, {r3, pc}
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_021536A8: .word _021733E0
_021536AC: .word 0x0000FFFF
	arm_func_end TalkHelpers__GetInteractionID2

	arm_func_start TalkHelpers__GetInteractionID
TalkHelpers__GetInteractionID: // 0x021536B0
	stmdb sp!, {r3, lr}
	ldr r1, _021536D0 // =_02173438
	ldr r0, [r1, r0, lsl #2]
	cmp r0, #0
	ldreq r0, _021536D4 // =0x0000FFFF
	ldmeqia sp!, {r3, pc}
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_021536D0: .word _02173438
_021536D4: .word 0x0000FFFF
	arm_func_end TalkHelpers__GetInteractionID

	arm_func_start TalkHelpers__Func_21536D8
TalkHelpers__Func_21536D8: // 0x021536D8
	stmdb sp!, {r3, lr}
	ldr r1, _021536F8 // =_02173490
	ldr r0, [r1, r0, lsl #2]
	cmp r0, #0
	ldreq r0, _021536FC // =0x0000FFFF
	ldmeqia sp!, {r3, pc}
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_021536F8: .word _02173490
_021536FC: .word 0x0000FFFF
	arm_func_end TalkHelpers__Func_21536D8

	arm_func_start TalkHelpers__Func_2153700
TalkHelpers__Func_2153700: // 0x02153700
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	bl SaveGame__GetGameProgress
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	bl SaveGame__GetUnknownProgress1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	bl SaveGame__GetUnknownProgress2
	mov r0, r0, lsl #0x10
	cmp r4, #0x18
	mov r6, r0, lsr #0x10
	blo _02153744
	cmp r4, #0x18
	cmpeq r5, #1
	cmpeq r6, #1
	bne _02153750
_02153744:
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02153750:
	cmp r4, #0x18
	bne _021537AC
	cmp r7, #0x11
	cmpne r7, #0x13
	moveq r0, #0
	beq _02153784
	cmp r7, #0xf
	moveq r0, #1
	beq _02153784
	cmp r6, #4
	movlo r0, #1
	blo _02153784
	bl SaveGame__GetProgressFlags_0x1
_02153784:
	cmp r0, #0
	beq _0215379C
	add r0, r5, #0x17
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215379C:
	add r0, r6, #0x1a
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_021537AC:
	add r0, r4, #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end TalkHelpers__Func_2153700

	arm_func_start TalkHelpers__Func_21537BC
TalkHelpers__Func_21537BC: // 0x021537BC
	stmdb sp!, {r3, lr}
	bl SaveGame__GetGameProgress
	cmp r0, #0x10
	bgt _021537DC
	bge _021537FC
	cmp r0, #8
	beq _021537F4
	b _02153804
_021537DC:
	cmp r0, #0x19
	bgt _02153804
	cmp r0, #0x15
	blt _02153804
	cmpne r0, #0x19
	bne _02153804
_021537F4:
	mov r0, #0
	ldmia sp!, {r3, pc}
_021537FC:
	mov r0, #1
	ldmia sp!, {r3, pc}
_02153804:
	mov r0, #0
	mov r1, r0
	bl SaveGame__GetNextShipUpgrade
	cmp r0, #0
	movne r0, #0x23
	ldreq r0, _02153820 // =0x0000FFFF
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153820: .word 0x0000FFFF
	arm_func_end TalkHelpers__Func_21537BC

	arm_func_start DockHelpers__Func_2153824
DockHelpers__Func_2153824: // 0x02153824
	stmdb sp!, {r3, lr}
	bl MissionHelpers__GetUnlockedMissionCount
	cmp r0, #0
	movne r0, #0
	ldreq r0, _0215383C // =0x0000FFFF
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215383C: .word 0x0000FFFF
	arm_func_end DockHelpers__Func_2153824

	arm_func_start DockHelpers__Func_2153840
DockHelpers__Func_2153840: // 0x02153840
	mov r0, #0
	bx lr
	arm_func_end DockHelpers__Func_2153840

	arm_func_start DockHelpers__Func_2153848
DockHelpers__Func_2153848: // 0x02153848
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, #0
	mov r5, r4
	bl SaveGame__CheckProgress29
	cmp r0, #0
	movne r4, #1
	mov r6, #0
_02153864:
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__Func_205D520
	cmp r0, #0
	beq _02153890
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__GetBoughtInfo
	cmp r0, #0
	moveq r5, #1
	beq _0215389C
_02153890:
	add r6, r6, #1
	cmp r6, #3
	blt _02153864
_0215389C:
	cmp r4, #0
	cmpne r5, #0
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, pc}
	cmp r4, #0
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	cmp r5, #0
	movne r0, #1
	ldreq r0, _021538C8 // =0x0000FFFF
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021538C8: .word 0x0000FFFF
	arm_func_end DockHelpers__Func_2153848

	arm_func_start DockHelpers__Func_21538CC
DockHelpers__Func_21538CC: // 0x021538CC
	mov r0, #0
	bx lr
	arm_func_end DockHelpers__Func_21538CC

	arm_func_start DockHelpers__Func_21538D4
DockHelpers__Func_21538D4: // 0x021538D4
	mov r0, #0
	bx lr
	arm_func_end DockHelpers__Func_21538D4

	arm_func_start DockHelpers__Func_21538DC
DockHelpers__Func_21538DC: // 0x021538DC
	mov r0, #0
	bx lr
	arm_func_end DockHelpers__Func_21538DC

	arm_func_start DockHelpers__Func_21538E4
DockHelpers__Func_21538E4: // 0x021538E4
	ldr r0, _021538EC // =0x0000FFFF
	bx lr
	.align 2, 0
_021538EC: .word 0x0000FFFF
	arm_func_end DockHelpers__Func_21538E4

	arm_func_start DockHelpers__Func_21538F0
DockHelpers__Func_21538F0: // 0x021538F0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	ldr ip, _02153944 // =0x02172524
	ldr r1, _02153948 // =0x0217248C
	ldr r2, _0215394C // =0x02172592
	ldr r3, _02153950 // =0x02172468
	mov r0, #6
	str ip, [sp]
	bl MissionHelpers__Func_2153B18
	mov r4, r0
	cmp r4, #0x17
	bne _02153938
	mov r0, #0x54
	bl MissionHelpers__IsMissionBeaten
	cmp r0, #0
	addeq sp, sp, #4
	ldreq r0, _02153954 // =0x0000FFFF
	ldmeqia sp!, {r3, r4, pc}
_02153938:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02153944: .word 0x02172524
_02153948: .word 0x0217248C
_0215394C: .word 0x02172592
_02153950: .word 0x02172468
_02153954: .word 0x0000FFFF
	arm_func_end DockHelpers__Func_21538F0

	arm_func_start DockHelpers__Func_2153958
DockHelpers__Func_2153958: // 0x02153958
	stmdb sp!, {r3, lr}
	ldr ip, _0215397C // =0x02172480
	ldr r1, _02153980 // =0x0217243E
	ldr r2, _02153984 // =0x021724D4
	ldr r3, _02153988 // =0x02172438
	mov r0, #3
	str ip, [sp]
	bl MissionHelpers__Func_2153B18
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215397C: .word 0x02172480
_02153980: .word 0x0217243E
_02153984: .word 0x021724D4
_02153988: .word 0x02172438
	arm_func_end DockHelpers__Func_2153958

	arm_func_start DockHelpers__Func_215398C
DockHelpers__Func_215398C: // 0x0215398C
	stmdb sp!, {r3, lr}
	ldr ip, _021539B0 // =0x021724F8
	ldr r1, _021539B4 // =0x0217245E
	ldr r2, _021539B8 // =0x02172574
	ldr r3, _021539BC // =0x02172454
	mov r0, #5
	str ip, [sp]
	bl MissionHelpers__Func_2153B18
	ldmia sp!, {r3, pc}
	.align 2, 0
_021539B0: .word 0x021724F8
_021539B4: .word 0x0217245E
_021539B8: .word 0x02172574
_021539BC: .word 0x02172454
	arm_func_end DockHelpers__Func_215398C

	arm_func_start DockHelpers__Func_21539C0
DockHelpers__Func_21539C0: // 0x021539C0
	stmdb sp!, {r3, lr}
	ldr ip, _021539E4 // =0x0217253C
	ldr r1, _021539E8 // =DockHelpers__BlazeMissionIDs
	ldr r2, _021539EC // =0x021725B6
	ldr r3, _021539F0 // =0x02172498
	mov r0, #7
	str ip, [sp]
	bl MissionHelpers__Func_2153B18
	ldmia sp!, {r3, pc}
	.align 2, 0
_021539E4: .word 0x0217253C
_021539E8: .word DockHelpers__BlazeMissionIDs
_021539EC: .word 0x021725B6
_021539F0: .word 0x02172498
	arm_func_end DockHelpers__Func_21539C0

	arm_func_start DockHelpers__Func_21539F4
DockHelpers__Func_21539F4: // 0x021539F4
	stmdb sp!, {r3, lr}
	ldr ip, _02153A18 // =0x02172474
	ldr r1, _02153A1C // =0x02172432
	ldr r2, _02153A20 // =0x021724E6
	ldr r3, _02153A24 // =0x0217242C
	mov r0, #3
	str ip, [sp]
	bl MissionHelpers__Func_2153B18
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153A18: .word 0x02172474
_02153A1C: .word 0x02172432
_02153A20: .word 0x021724E6
_02153A24: .word 0x0217242C
	arm_func_end DockHelpers__Func_21539F4

	arm_func_start DockHelpers__Func_2153A28
DockHelpers__Func_2153A28: // 0x02153A28
	stmdb sp!, {r3, lr}
	ldr ip, _02153A4C // =0x021724B4
	ldr r1, _02153A50 // =0x0217244C
	ldr r2, _02153A54 // =0x0217250C
	ldr r3, _02153A58 // =0x02172444
	mov r0, #4
	str ip, [sp]
	bl MissionHelpers__Func_2153B18
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153A4C: .word 0x021724B4
_02153A50: .word 0x0217244C
_02153A54: .word 0x0217250C
_02153A58: .word 0x02172444
	arm_func_end DockHelpers__Func_2153A28

	.rodata

.public ovl05_02172420
ovl05_02172420: // 0x02172420
    .hword 0, 1, 2, 3, 4, 5
	
.public ovl05_0217242C
ovl05_0217242C: // 0x0217242C
    .hword 0xFFFF, 0xA, 0xC
	
.public ovl05_02172432
ovl05_02172432: // 0x02172432
    .hword 0x27, 0x58, 0x5B
	
.public ovl05_02172438
ovl05_02172438: // 0x02172438
    .hword 0xFFFF, 0xFFFF, 0xFFFF
	
.public ovl05_0217243E
ovl05_0217243E: // 0x0217243E
    .hword 9, 0x3B, 0x31
	
.public ovl05_02172444
ovl05_02172444: // 0x02172444
    .hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	
.public ovl05_0217244C
ovl05_0217244C: // 0x0217244C
    .hword 0x5F, 0x60, 0x61, 0x62
	
.public ovl05_02172454
ovl05_02172454: // 0x02172454
    .hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	
.public ovl05_0217245E
ovl05_0217245E: // 0x0217245E
    .hword 6, 0x10, 0x1A, 0x24, 0x2F
	
.public ovl05_02172468
ovl05_02172468: // 0x02172468
    .hword 6, 7, 4, 0xB, 0xD, 8
	
.public ovl05_02172474
ovl05_02172474: // 0x02172474
    .hword 7, 8, 0xA, 0xB, 0xD, 0xE
	
.public ovl05_02172480
ovl05_02172480: // 0x02172480
    .hword 0xA, 0xB, 0xD, 0xE, 0x10, 0x11
	
.public ovl05_0217248C
ovl05_0217248C: // 0x0217248C
    .hword 0x53, 0x54, 0x4F, 0x59, 0x5D, 0x55
	
.public ovl05_02172498
ovl05_02172498: // 0x02172498
    .hword 0xFFFF, 3, 0xFFFF, 9, 5, 0xFFFF, 0xFFFF
	
.public DockHelpers__BlazeMissionIDs
DockHelpers__BlazeMissionIDs: // 0x021724A6
	.hword 19, 77, 29, 86, 81, 69, 71
	
.public ovl05_021724B4
ovl05_021724B4: // 0x021724B4
    .hword 7, 8, 9, 0xA, 0xB, 0xC, 0xD, 0xE
	
.public ovl05_021724C4
ovl05_021724C4: // 0x021724C4
    .byte 36, 0, 37, 0, 38, 0, 39, 0, 40, 0, 41, 0, 42, 0, 43, 0

.public ovl05_021724D4
ovl05_021724D4: // 0x021724D4
    .hword 5, 0, 0
	.hword 0x1A, 4, 6
	.hword 0x23, 0, 0

.public ovl05_021724E6
ovl05_021724E6: // 0x021724E6
	.hword 0x18, 4, 0
	.hword 0x18, 0, 6
	.hword 0x23, 4, 6
	
.public ovl05_021724F8
ovl05_021724F8: // 0x021724F8
    .hword 5, 6, 7, 8, 9, 0xA, 0xB, 0xC, 0xD, 0xE
	
.public ovl05_0217250C
ovl05_0217250C: // 0x0217250C
    .hword 0x24, 4, 6
	.hword 0x24, 4, 6
	.hword 0x24, 4, 6
	.hword 0x24, 4, 6

.public ovl05_02172524
ovl05_02172524: // 0x02172524
    .hword 8, 9, 0xB, 0xC, 0xE, 0xF, 0x11, 0x12, 0x14, 0x15, 0x17, 0x18

.public ovl05_0217253C
ovl05_0217253C: // 0x0217253C
    .hword 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17

.public DockHelpers__PostGameMissionList2
DockHelpers__PostGameMissionList2: // 0x02172558
	.hword 2, 7, 13, 17, 23, 27, 33, 37, 43, 48, 53, 57, 63, 67
	
.public ovl05_02172574
ovl05_02172574: // 0x02172574
    .hword 0x15, 0, 0
	.hword 0x18, 4, 0
	.hword 0x18, 4, 6
	.hword 0x23, 4, 6
	.hword 0x24, 4, 6

.public ovl05_02172592
ovl05_02172592: // 0x02172592
    .hword 8, 0, 0
	.hword 9, 0, 0
	.hword 0x10, 0, 0
	.hword 0x18, 1, 6
	.hword 0x18, 1, 6
	.hword 0x1E, 4, 6

.public ovl05_021725B6
ovl05_021725B6: // 0x021725B6
    .hword 0x10, 0, 0
	.hword 0x15, 0, 0
	.hword 0x18, 4, 0
	.hword 0x18, 4, 6
	.hword 0x1E, 4, 6
	.hword 0x24, 4, 6
	.hword 0x24, 4, 6

.public TalkHelpers__MesssageControlList
TalkHelpers__MesssageControlList: // 0x021725E0
	.hword 0x00, 0x01, 0x02, 0x04
	.hword 0x05, 0x03, 0x05, 0xFFFF
	.hword 0xFFFF, 0x00, 0x01
	.hword 0x04, 0x08, 0x05, 0x06
	.hword 0x0A, 0x05, 0x07, 0x05
	.hword 0x07, 0x04, 0x09

.public ovl05_0217260C
ovl05_0217260C: // 0x0217260C
    .hword 0xFFFF, 1, 2, 3, 3, 4, 5, 5, 6, 7, 7, 7, 8, 8, 9, 9
	.hword 0xA, 0xB, 0xB, 0xC, 0xC, 0xD, 0xE, 0xF, 0xF, 0x10
	.hword 0x10, 0x11, 0xE, 0xE, 0x12, 0x12, 0x13, 0x14, 0x15
	.hword 0x15, 0x15, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16, 0x16
	.hword 0x17, 0x17, 0x17, 0x17

.public ovl05_0217266C
ovl05_0217266C: // 0x0217266C
    .hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0, 1, 1, 2, 2, 3, 4, 5, 5, 6, 6, 7
	.hword 5, 5, 8, 8, 9, 0xA, 0xB, 0xB, 0xB, 0xC, 0xC, 0xD, 0xD
	.hword 0xD, 0xD, 0xE, 0x10, 0x10, 0x10, 0x10

.public ovl05_021726CC
ovl05_021726CC: // 0x021726CC
    .hword 0xFFFF, 1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4
	.hword 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
	.hword 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7

.public ovl05_0217272C
ovl05_0217272C: // 0x0217272C
    .hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0, 1, 1, 2
	.hword 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4
	.hword 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 6, 6, 7, 7, 7, 7
	.hword 7, 9, 9, 9, 9

.public ovl05_0217278C
ovl05_0217278C: // 0x0217278C
    .hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 3, 3, 4, 4, 4, 4, 4, 4, 4
	.hword 4, 4, 5, 6, 6, 6, 7, 7, 7, 6, 6, 8, 8, 8, 8, 9, 9
	.hword 9, 0xA, 0xA, 0xB, 0xB, 0xB, 0xB, 0xB, 0xC, 0xC, 0xC
	.hword 0xC
.public ovl05_021727EC
ovl05_021727EC: // 0x021727EC
    .hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3
	.hword 2, 2, 4, 4, 4, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 9
	.hword 9, 9, 9

.public ovl05_0217284C
ovl05_0217284C: // 0x0217284C
    .hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0, 0, 0, 0, 0, 1, 1
	.hword 1, 2, 2, 2, 2, 3, 3, 4, 4, 4, 4, 4, 6, 6, 6, 6

.public ovl05_021728AC
ovl05_021728AC: // 0x021728AC
    .hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 2, 2, 2, 2, 2, 2, 2
	.hword 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3
	.hword 3, 3, 4, 4, 4, 4

.public ovl05_0217290C
ovl05_0217290C: // 0x0217290C
    .hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 1, 1, 1, 1

.public ovl05_0217296C
ovl05_0217296C: // 0x0217296C
    .hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
	.hword 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 1
	.hword 1, 1, 1, 1, 1, 2, 3, 3, 3, 4, 4, 5, 5, 5, 5, 5, 6
	.hword 6, 6, 6

.public ovl05_021729CC
ovl05_021729CC: // 0x021729CC
    .hword 65535, 9, 7, 10, 10, 11, 12, 12, 13, 14, 14, 15, 16
	.hword 16, 17, 17, 18, 19, 19, 20, 20, 21, 22, 22, 23, 24
	.hword 24, 25, 22, 22, 26, 26, 27, 28, 29, 29, 30, 31, 31
	.hword 32, 32, 32, 32, 33, 34, 34, 34, 34

	.data

.public _021733E0
_021733E0: // 0x021733E0
	.word TalkHelpers__Func_21537BC
	.word DockHelpers__Func_2153824
	.word 0
	.word 0
	.word DockHelpers__Func_2153848
	.word DockHelpers__Func_2153840
	.word DockHelpers__Func_2153848
	.word 0
	.word 0
	.word TalkHelpers__Func_21537BC
	.word DockHelpers__Func_2153824
	.word 0
	.word DockHelpers__Func_21538CC
	.word DockHelpers__Func_2153848
	.word 0
	.word DockHelpers__Func_21538DC
	.word DockHelpers__Func_2153848
	.word 0
	.word DockHelpers__Func_2153848
	.word 0
	.word 0
	.word DockHelpers__Func_21538D4

.public _02173438
_02173438: // 0x02173438
	.word MissionHelpers__Func_2153BF8
	.word 0
	.word 0
	.word MissionHelpers__Func_2153CEC
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word MissionHelpers__Func_2153CEC
	.word MissionHelpers__Func_2153D08
	.word 0
	.word 0
	.word 0
	.word 0
	.word MissionHelpers__Func_2153D2C
	.word 0
	.word MissionHelpers__Func_2153D2C
	.word MissionHelpers__Func_2153CEC
	.word 0

.public _02173490
_02173490: // 0x02173490
	.word 0
	.word DockHelpers__Func_21538E4
	.word 0
	.word DockHelpers__Func_2153958
	.word 0
	.word DockHelpers__Func_21538F0
	.word 0
	.word 0
	.word 0
	.word 0
	.word DockHelpers__Func_21538E4
	.word DockHelpers__Func_2153958
	.word DockHelpers__Func_215398C
	.word 0
	.word DockHelpers__Func_21539C0
	.word DockHelpers__Func_2153A28
	.word 0
	.word DockHelpers__Func_21539F4
	.word 0
	.word DockHelpers__Func_21539F4
	.word DockHelpers__Func_2153958
	.word MissionHelpers__Func_2153A5C

.public _021734E8
_021734E8: // 0x021734E8
	.word ovl05_021729CC
	.word ovl05_0217260C
	.word ovl05_0217266C
	.word ovl05_0217272C
	.word ovl05_0217278C
	.word ovl05_021726CC
	.word ovl05_0217278C
	.word 0
	.word 0
	.word ovl05_021729CC
	.word ovl05_0217260C
	.word ovl05_0217272C
	.word ovl05_021728AC
	.word ovl05_0217278C
	.word ovl05_021727EC
	.word ovl05_0217296C
	.word ovl05_0217278C
	.word ovl05_0217284C
	.word ovl05_0217278C
	.word ovl05_0217284C
	.word ovl05_0217272C
	.word ovl05_0217290C