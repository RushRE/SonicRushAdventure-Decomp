	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start Unknown2056570__Init
Unknown2056570__Init: // 0x02056570
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x10
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r1, r6
	mov r0, #0
	mov r2, #0x30
	mov r7, r3
	bl MIi_CpuClear32
	str r7, [r6]
	ldrh r0, [sp, #0x28]
	str r5, [r6, #4]
	ldrh r1, [sp, #0x2c]
	strh r0, [r6, #8]
	ldrh r0, [sp, #0x30]
	strh r1, [r6, #0xa]
	ldrh r1, [sp, #0x34]
	strh r0, [r6, #0xc]
	mov r0, #0
	strh r1, [r6, #0xe]
	strh r4, [r6, #0x10]
	strb r0, [r6, #0x12]
	strb r0, [r6, #0x13]
	ldr r1, _0205666C // =0x0000FFFF
	ldr r0, [sp, #0x3c]
	strh r1, [r6, #0x14]
	strh r1, [r6, #0x16]
	strh r1, [r6, #0x18]
	strh r1, [r6, #0x1a]
	str r0, [r6, #0x1c]
	ldr r1, [sp, #0x40]
	ldr r0, [sp, #0x38]
	str r1, [r6, #0x20]
	str r0, [r6, #0x2c]
	add r2, sp, #0xa
	add r3, sp, #8
	mov r0, r5
	and r1, r4, #0xff
	bl GetVRAMCharacterConfig
	add r3, sp, #4
	str r3, [sp]
	mov r0, r5
	and r1, r4, #0xff
	add r2, sp, #0xc
	add r3, sp, #6
	bl GetVRAMTileConfig
	ldrh r0, [sp, #8]
	ldrh r1, [sp, #0xa]
	mov r0, r0, lsl #0xe
	add r0, r0, r1, lsl #16
	str r0, [r6, #0x28]
	ldrh r0, [sp, #4]
	ldrh r1, [sp, #6]
	mov r0, r0, lsl #0xb
	add r0, r0, r1, lsl #16
	str r0, [r6, #0x24]
	ldr r1, [r6, #0x20]
	ldr r0, [r6, #0x28]
	add r0, r1, r0
	str r0, [r6, #0x20]
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0205666C: .word 0x0000FFFF
	arm_func_end Unknown2056570__Init

	arm_func_start Unknown2056570__Func_2056670
Unknown2056570__Func_2056670: // 0x02056670
	ldr ip, _02056684 // =MIi_CpuClear32
	mov r1, r0
	mov r0, #0
	mov r2, #0x30
	bx ip
	.align 2, 0
_02056684: .word MIi_CpuClear32
	arm_func_end Unknown2056570__Func_2056670

	arm_func_start Unknown2056570__Func_2056688
Unknown2056570__Func_2056688: // 0x02056688
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	add r3, sp, #4
	mov r6, r0
	str r3, [sp]
	ldrh r7, [r6, #0x10]
	ldr r0, [r6, #4]
	mov r5, r1
	add r2, sp, #8
	and r1, r7, #0xff
	bl GetVRAMTileConfig
	ldr r0, [sp, #8]
	cmp r0, #0xd
	bgt _020566F4
	bge _02056718
	cmp r0, #3
	bgt _020566E8
	cmp r0, #0
	addge pc, pc, r0, lsl #2
	b _0205671C
_020566D8: // jump table
	b _02056710 // case 0
	b _02056718 // case 1
	b _02056710 // case 2
	b _02056718 // case 3
_020566E8:
	cmp r0, #0xc
	beq _02056710
	b _0205671C
_020566F4:
	cmp r0, #0xe
	bgt _02056704
	beq _02056710
	b _0205671C
_02056704:
	cmp r0, #0xf
	beq _02056718
	b _0205671C
_02056710:
	mov r4, #0
	b _0205671C
_02056718:
	mov r4, #1
_0205671C:
	ldr r0, [r6, #0x1c]
	cmp r0, #0
	beq _02056738
	cmp r0, #1
	beq _02056750
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_02056738:
	ldr r1, [r6, #0x20]
	ldr r0, [r6, #0x28]
	sub r0, r1, r0
	mov r0, r0, lsl #0xb
	mov r0, r0, lsr #0x10
	b _02056764
_02056750:
	ldr r1, [r6, #0x20]
	ldr r0, [r6, #0x28]
	sub r0, r1, r0
	mov r0, r0, lsl #0xa
	mov r0, r0, lsr #0x10
_02056764:
	orr r0, r0, r5, lsl #12
	strh r0, [sp, #4]
	ldr r0, [r6, #4]
	ldrh lr, [r6, #0xa]
	cmp r0, #0
	ldrh r0, [r6, #0xe]
	moveq r5, #0x6000000
	ldr r7, [r6, #0x24]
	movne r5, #0x6200000
	add r3, lr, r0
	cmp lr, r3
	ldrh r1, [r6, #8]
	ldrh r2, [r6, #0xc]
	add r5, r5, r7
	addge sp, sp, #0xc
	add r2, r1, r2
	ldmgeia sp!, {r4, r5, r6, r7, r8, r9, pc}
	mov r7, #0x400
	mov r8, #0x800
_020567B0:
	mov ip, r1
	cmp r1, r2
	bge _02056810
	mov r0, lr, lsl #0x1b
_020567C0:
	mov r6, ip, lsl #0x1b
	mov r6, r6, lsr #0x1a
	add r6, r6, r0, lsr #21
	cmp lr, #0x20
	add r9, r5, r6
	blt _020567E8
	cmp r4, #0
	movne r6, r8
	moveq r6, r7
	add r9, r9, r6, lsl #1
_020567E8:
	ldrh r6, [sp, #4]
	cmp ip, #0x20
	addge r9, r9, #0x800
	strh r6, [r9]
	ldrh r6, [sp, #4]
	add ip, ip, #1
	cmp ip, r2
	add r6, r6, #1
	strh r6, [sp, #4]
	blt _020567C0
_02056810:
	add lr, lr, #1
	cmp lr, r3
	blt _020567B0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end Unknown2056570__Func_2056688

	arm_func_start Unknown2056570__Func_2056824
Unknown2056570__Func_2056824: // 0x02056824
	ldrh r0, [r0, #0xc]
	bx lr
	arm_func_end Unknown2056570__Func_2056824

	arm_func_start Unknown2056570__Func_205682C
Unknown2056570__Func_205682C: // 0x0205682C
	ldrh r0, [r0, #0xe]
	bx lr
	arm_func_end Unknown2056570__Func_205682C

	arm_func_start Unknown2056570__Func_2056834
Unknown2056570__Func_2056834: // 0x02056834
	ldr r0, [r0, #0x2c]
	bx lr
	arm_func_end Unknown2056570__Func_2056834

	arm_func_start Unknown2056570__Func_205683C
Unknown2056570__Func_205683C: // 0x0205683C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	bl Unknown2056570__Func_2056C18
	ldr r1, [r4, #0x1c]
	ldrh r2, [r4, #0xc]
	cmp r1, #0
	moveq ip, #0x20
	movne ip, #0x40
	mul r2, ip, r2
	ldrh r3, [r4, #0xe]
	ldr r1, [r4, #0x2c]
	mul r2, r3, r2
	bl MIi_CpuClearFast
	ldrh r2, [r4, #0xe]
	mov r1, #0
	mov r0, r4
	sub r2, r2, #1
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	str r2, [sp]
	ldrh r3, [r4, #0xc]
	mov r2, r1
	sub r3, r3, #1
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	bl Unknown2056570__Func_2056958
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end Unknown2056570__Func_205683C

	arm_func_start Unknown2056570__Func_20568B0
Unknown2056570__Func_20568B0: // 0x020568B0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	str r2, [sp, #4]
	mov r10, r0
	str r3, [sp, #8]
	mov r11, r1
	bl Unknown2056570__Func_2056C18
	ldr r1, [r10, #0x1c]
	ldrh r2, [r10, #0xc]
	cmp r1, #0
	ldr r1, [sp, #8]
	mov r4, r0
	moveq r0, #0x20
	sub r1, r1, r11
	movne r0, #0x40
	add r1, r1, #1
	ldrh r9, [sp, #0x30]
	mul r5, r0, r2
	mul r6, r0, r1
	ldr r7, [sp, #4]
	mov r1, r7
	cmp r1, r9
	bgt _02056934
	mul r8, r0, r11
_02056910:
	ldr r1, [r10, #0x2c]
	mov r0, r4
	mla r1, r5, r7, r1
	mov r2, r6
	add r1, r1, r8
	bl MIi_CpuClearFast
	add r7, r7, #1
	cmp r7, r9
	ble _02056910
_02056934:
	ldrh r4, [sp, #0x30]
	ldr r2, [sp, #4]
	ldr r3, [sp, #8]
	mov r0, r10
	mov r1, r11
	str r4, [sp]
	bl Unknown2056570__Func_2056958
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end Unknown2056570__Func_20568B0

	arm_func_start Unknown2056570__Func_2056958
Unknown2056570__Func_2056958: // 0x02056958
	stmdb sp!, {r3, lr}
	ldrh lr, [r0, #0x14]
	ldr ip, _020569C0 // =0x0000FFFF
	cmp lr, ip
	bne _02056984
	strh r1, [r0, #0x14]
	strh r3, [r0, #0x18]
	ldrh r1, [sp, #8]
	strh r2, [r0, #0x16]
	strh r1, [r0, #0x1a]
	ldmia sp!, {r3, pc}
_02056984:
	cmp r1, lr
	strloh r1, [r0, #0x14]
	ldrh r1, [r0, #0x18]
	cmp r3, r1
	strhih r3, [r0, #0x18]
	ldrh r1, [r0, #0x16]
	cmp r2, r1
	strloh r2, [r0, #0x16]
	ldrh r2, [sp, #8]
	ldrh r1, [r0, #0x1a]
	cmp r2, r1
	strhih r2, [r0, #0x1a]
	mov r1, #0
	strb r1, [r0, #0x13]
	ldmia sp!, {r3, pc}
	.align 2, 0
_020569C0: .word 0x0000FFFF
	arm_func_end Unknown2056570__Func_2056958

	arm_func_start Unknown2056570__Func_20569C4
Unknown2056570__Func_20569C4: // 0x020569C4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	ldrh r1, [r8, #0x14]
	ldr r0, _02056A54 // =0x0000FFFF
	cmp r1, r0
	ldrneb r0, [r8, #0x13]
	cmpne r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r8, #0x1c]
	ldrh r2, [r8, #0xc]
	cmp r0, #0
	ldrh r0, [r8, #0x18]
	moveq r7, #0x20
	movne r7, #0x40
	sub r0, r0, r1
	add r1, r0, #1
	ldrh r6, [r8, #0x16]
	ldrh r0, [r8, #0x1a]
	mul r4, r7, r2
	mul r5, r7, r1
	cmp r6, r0
	bgt _02056A48
_02056A1C:
	ldrh r0, [r8, #0x14]
	ldr r2, [r8, #0x2c]
	mov r1, r5
	mul r0, r7, r0
	mla r0, r4, r6, r0
	add r0, r2, r0
	bl DC_StoreRange
	ldrh r0, [r8, #0x1a]
	add r6, r6, #1
	cmp r6, r0
	ble _02056A1C
_02056A48:
	mov r0, #1
	strb r0, [r8, #0x13]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02056A54: .word 0x0000FFFF
	arm_func_end Unknown2056570__Func_20569C4

	arm_func_start Unknown2056570__Func_2056A58
Unknown2056570__Func_2056A58: // 0x02056A58
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x1c]
	ldrh r1, [r4, #0xc]
	cmp r0, #0
	moveq r3, #0x20
	movne r3, #0x40
	mul r1, r3, r1
	ldrh r2, [r4, #0xe]
	ldr r0, [r4, #0x2c]
	mul r1, r2, r1
	bl DC_StoreRange
	mov r0, #1
	strb r0, [r4, #0x13]
	ldmia sp!, {r4, pc}
	arm_func_end Unknown2056570__Func_2056A58

	arm_func_start Unknown2056570__Func_2056A94
Unknown2056570__Func_2056A94: // 0x02056A94
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r10, r0
	ldrh r2, [r10, #0x14]
	ldr r1, _02056B88 // =0x0000FFFF
	cmp r2, r1
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrb r1, [r10, #0x13]
	cmp r1, #0
	bne _02056ABC
	bl Unknown2056570__Func_20569C4
_02056ABC:
	ldrh r2, [r10, #0x18]
	ldrh r1, [r10, #0x14]
	ldr r0, [r10, #0x1c]
	ldrh r3, [r10, #0xc]
	cmp r0, #0
	moveq r9, #0x20
	sub r1, r2, r1
	movne r9, #0x40
	ldr r0, [r10, #4]
	add r1, r1, #1
	cmp r0, #0
	mul r6, r9, r1
	moveq r7, #0x6000000
	mul r5, r9, r3
	ldrh r8, [r10, #0x16]
	ldrh r0, [r10, #0x1a]
	movne r7, #0x6200000
	ldr r1, [r10, #0x20]
	cmp r8, r0
	add r7, r7, r1
	bgt _02056B6C
	mov r11, #0
	mov r4, r11
_02056B18:
	ldrh r1, [r10, #0x14]
	ldr r0, [r10, #0]
	ldr ip, [r10, #0x2c]
	mul r1, r9, r1
	mla r3, r5, r8, r1
	tst r0, #1
	mov r1, r6
	beq _02056B4C
	add r0, ip, r3
	mov r2, r4
	add r3, r7, r3
	bl LoadUncompressedPixels
	b _02056B5C
_02056B4C:
	add r0, ip, r3
	mov r2, r11
	add r3, r7, r3
	bl QueueUncompressedPixels
_02056B5C:
	ldrh r0, [r10, #0x1a]
	add r8, r8, #1
	cmp r8, r0
	ble _02056B18
_02056B6C:
	ldr r0, _02056B88 // =0x0000FFFF
	strh r0, [r10, #0x1a]
	ldrh r0, [r10, #0x1a]
	strh r0, [r10, #0x18]
	strh r0, [r10, #0x16]
	strh r0, [r10, #0x14]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02056B88: .word 0x0000FFFF
	arm_func_end Unknown2056570__Func_2056A94

	arm_func_start Unknown2056570__Func_2056B8C
Unknown2056570__Func_2056B8C: // 0x02056B8C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl Unknown2056570__Func_2056A58
	ldr r0, [r4, #0x1c]
	ldrh r1, [r4, #0xc]
	cmp r0, #0
	moveq r3, #0x20
	movne r3, #0x40
	mul r1, r3, r1
	ldrh r2, [r4, #0xe]
	ldr r0, [r4, #4]
	cmp r0, #0
	mul r1, r2, r1
	moveq r3, #0x6000000
	ldr r0, [r4, #0]
	movne r3, #0x6200000
	tst r0, #1
	ldr r2, [r4, #0x20]
	ldr r0, [r4, #0x2c]
	beq _02056BEC
	add r3, r2, r3
	mov r2, #0
	bl LoadUncompressedPixels
	b _02056BF8
_02056BEC:
	add r3, r2, r3
	mov r2, #0
	bl QueueUncompressedPixels
_02056BF8:
	ldr r0, _02056C14 // =0x0000FFFF
	strh r0, [r4, #0x1a]
	ldrh r0, [r4, #0x1a]
	strh r0, [r4, #0x18]
	strh r0, [r4, #0x16]
	strh r0, [r4, #0x14]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02056C14: .word 0x0000FFFF
	arm_func_end Unknown2056570__Func_2056B8C

	arm_func_start Unknown2056570__Func_2056C18
Unknown2056570__Func_2056C18: // 0x02056C18
	ldr r1, [r0, #0x1c]
	cmp r1, #0
	beq _02056C30
	cmp r1, #1
	beq _02056C44
	b _02056C54
_02056C30:
	ldrb r0, [r0, #0x12]
	orr r0, r0, r0, lsl #4
	orr r0, r0, r0, lsl #8
	orr r0, r0, r0, lsl #16
	bx lr
_02056C44:
	ldrb r0, [r0, #0x12]
	orr r0, r0, r0, lsl #8
	orr r0, r0, r0, lsl #16
	bx lr
_02056C54:
	mov r0, #0
	bx lr
	arm_func_end Unknown2056570__Func_2056C18
