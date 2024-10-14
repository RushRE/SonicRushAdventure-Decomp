	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
_02134448: // 0x02134448
    .space 0x02
	
_0213444A: // 0x0213444A
    .space 0x02

	.text

	arm_func_start BackgroundUnknown__Func_204CA00
BackgroundUnknown__Func_204CA00: // 0x0204CA00
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	add r2, sp, #8
	add r3, sp, #0xa
	mov r6, r0
	mov r5, r1
	bl GetVRAMCharacterConfig
	ldrh r0, [sp, #0xa]
	ldr r2, _0204CA88 // =VRAMSystem__VRAM_BG
	ldrh r1, [sp, #8]
	mov r0, r0, lsl #0xe
	ldr r4, [r2, r6, lsl #2]
	add r0, r0, r1, lsl #16
	add r1, r4, r0
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	add r0, sp, #6
	str r0, [sp]
	add r2, sp, #0xc
	add r3, sp, #4
	mov r0, r6
	mov r1, r5
	bl GetVRAMTileConfig
	ldrh r1, [sp, #6]
	ldrh r2, [sp, #4]
	mov r0, #0
	mov r1, r1, lsl #0xb
	add r1, r1, r2, lsl #16
	add r1, r4, r1
	mov r2, #0x800
	bl MIi_CpuClearFast
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0204CA88: .word VRAMSystem__VRAM_BG
	arm_func_end BackgroundUnknown__Func_204CA00

	arm_func_start BackgroundUnknown__CopyPixels
BackgroundUnknown__CopyPixels: // 0x0204CA8C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x1c
	ldr ip, _0204CAE0 // =_02134448
	mov lr, #0
	strh lr, [ip]
	ldrh r4, [sp, #0x28]
	ldrh lr, [sp, #0x2c]
	ldr ip, [sp, #0x30]
	stmia sp, {r4, lr}
	str ip, [sp, #8]
	ldrh lr, [sp, #0x34]
	ldrh ip, [sp, #0x38]
	str lr, [sp, #0xc]
	str ip, [sp, #0x10]
	ldrh lr, [sp, #0x3c]
	ldrh ip, [sp, #0x40]
	str lr, [sp, #0x14]
	str ip, [sp, #0x18]
	bl BackgroundUnknown__Func_204CE44
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0204CAE0: .word _02134448
	arm_func_end BackgroundUnknown__CopyPixels

	arm_func_start BackgroundUnknown__Func_204CAE4
BackgroundUnknown__Func_204CAE4: // 0x0204CAE4
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x1c
	mov lr, #0
	ldr ip, _0204CB3C // =_02134448
	orr lr, lr, #1
	strh lr, [ip]
	ldrh r4, [sp, #0x28]
	ldrh lr, [sp, #0x2c]
	ldr ip, [sp, #0x30]
	stmia sp, {r4, lr}
	str ip, [sp, #8]
	ldrh lr, [sp, #0x34]
	ldrh ip, [sp, #0x38]
	str lr, [sp, #0xc]
	str ip, [sp, #0x10]
	ldrh lr, [sp, #0x3c]
	ldrh ip, [sp, #0x40]
	str lr, [sp, #0x14]
	str ip, [sp, #0x18]
	bl BackgroundUnknown__Func_204CE44
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0204CB3C: .word _02134448
	arm_func_end BackgroundUnknown__Func_204CAE4

	arm_func_start BackgroundUnknown__Func_204CB40
BackgroundUnknown__Func_204CB40: // 0x0204CB40
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x1c
	ldr ip, _0204CB94 // =_02134448
	mov lr, #0
	strh lr, [ip]
	ldrh r4, [sp, #0x28]
	ldrh lr, [sp, #0x2c]
	ldr ip, [sp, #0x30]
	stmia sp, {r4, lr}
	str ip, [sp, #8]
	ldrh lr, [sp, #0x34]
	ldrh ip, [sp, #0x38]
	str lr, [sp, #0xc]
	str ip, [sp, #0x10]
	ldrh lr, [sp, #0x3c]
	ldrh ip, [sp, #0x40]
	str lr, [sp, #0x14]
	str ip, [sp, #0x18]
	bl BackgroundUnknown__Func_204EB0C
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0204CB94: .word _02134448
	arm_func_end BackgroundUnknown__Func_204CB40

	arm_func_start BackgroundUnknown__Func_204CB98
BackgroundUnknown__Func_204CB98: // 0x0204CB98
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x1c
	mov lr, #0
	ldr ip, _0204CBF0 // =_02134448
	orr lr, lr, #1
	strh lr, [ip]
	ldrh r4, [sp, #0x28]
	ldrh lr, [sp, #0x2c]
	ldr ip, [sp, #0x30]
	stmia sp, {r4, lr}
	str ip, [sp, #8]
	ldrh lr, [sp, #0x34]
	ldrh ip, [sp, #0x38]
	str lr, [sp, #0xc]
	str ip, [sp, #0x10]
	ldrh lr, [sp, #0x3c]
	ldrh ip, [sp, #0x40]
	str lr, [sp, #0x14]
	str ip, [sp, #0x18]
	bl BackgroundUnknown__Func_204EB0C
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0204CBF0: .word _02134448
	arm_func_end BackgroundUnknown__Func_204CB98

	arm_func_start BackgroundUnknown__Func_204CBF4
BackgroundUnknown__Func_204CBF4: // 0x0204CBF4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	ldrh r4, [sp, #0x28]
	mov r9, r1
	mov r8, r2
	add r4, r8, r4
	mov r2, r8, asr #3
	mov r7, r3
	ldrh r1, [sp, #0x2c]
	mov r10, r0
	cmp r2, r4, asr #3
	mov r5, r4, asr #3
	mov r4, #0
	add r1, r7, r1
	mov r0, r7, asr #3
	orreq r4, r4, #1
	cmp r0, r1, asr #3
	mov r6, r1, asr #3
	ldrh r1, [sp, #0x28]
	ldr r0, _0204CD1C // =_0211031C
	orreq r4, r4, #2
	ldr lr, [r0, r4, lsl #2]
	str r1, [sp]
	ldrh ip, [sp, #0x2c]
	mov r0, r10
	mov r1, r9
	mov r2, r8
	mov r3, r7
	str ip, [sp, #4]
	blx lr
	cmp r4, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r0, r8, #7
	add r1, r7, #7
	mov r2, r5, lsl #0x10
	mov r1, r1, lsl #0xd
	mov r0, r0, lsl #0xd
	mov r2, r2, lsr #0x10
	cmp r2, r0, lsr #16
	mov r5, r1, lsr #0x10
	addls sp, sp, #8
	mov r0, r0, lsr #0x10
	ldmlsia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	sub r1, r2, r0
	mov r2, r6, lsl #0x10
	mov r1, r1, lsl #0x10
	cmp r5, r2, lsr #16
	mov r3, r1, lsr #0x10
	addhs sp, sp, #8
	mov r1, r2, lsr #0x10
	ldmhsia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r4, r9, lsl #5
	mla r2, r4, r5, r10
	sub r1, r1, r5
	mov r1, r1, lsl #0x10
	mov r5, r1, lsr #0x10
	cmp r5, #0
	mov r8, r3, lsl #5
	add r7, r2, r0, lsl #5
	mov r9, #0
	addle sp, sp, #8
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r6, r9
_0204CCF4:
	mov r0, r6
	mov r1, r7
	mov r2, r8
	bl MIi_CpuClearFast
	add r9, r9, #1
	cmp r9, r5
	add r7, r7, r4
	blt _0204CCF4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0204CD1C: .word _0211031C
	arm_func_end BackgroundUnknown__Func_204CBF4

	arm_func_start BackgroundUnknown__Func_204CD20
BackgroundUnknown__Func_204CD20: // 0x0204CD20
	stmdb sp!, {r3, r4, r5, lr}
	tst r2, r3
	beq _0204CD8C
	mov r3, #0x1c
	mov ip, #0
_0204CD34:
	ldr r2, [r0, r3]
	sub r3, r3, #4
	mov lr, r2, lsl #0x1c
	and r4, r2, #0xf0
	and r5, r2, #0xf00
	orr r4, lr, r4, lsl #20
	and lr, r2, #0xf000
	orr r4, r4, r5, lsl #12
	and r5, r2, #0xf0000
	orr r4, r4, lr, lsl #4
	and lr, r2, #0xf00000
	orr r4, r4, r5, lsr #4
	and r5, r2, #0xf000000
	orr r4, r4, lr, lsr #12
	and lr, r2, #0xf0000000
	orr r2, r4, r5, lsr #20
	orr r2, r2, lr, lsr #28
	str r2, [r1, ip]
	add ip, ip, #4
	cmp ip, #0x20
	blt _0204CD34
	ldmia sp!, {r3, r4, r5, pc}
_0204CD8C:
	cmp r2, #0
	beq _0204CDEC
	mov r3, #0
_0204CD98:
	ldr r2, [r0, r3]
	mov lr, r2, lsl #0x1c
	and ip, r2, #0xf0
	and r4, r2, #0xf00
	orr ip, lr, ip, lsl #20
	and lr, r2, #0xf000
	orr r4, ip, r4, lsl #12
	and ip, r2, #0xf0000
	orr r4, r4, lr, lsl #4
	and lr, r2, #0xf00000
	orr r4, r4, ip, lsr #4
	and ip, r2, #0xf000000
	orr r4, r4, lr, lsr #12
	and lr, r2, #0xf0000000
	orr r2, r4, ip, lsr #20
	orr r2, r2, lr, lsr #28
	str r2, [r1, r3]
	add r3, r3, #4
	cmp r3, #0x20
	blt _0204CD98
	ldmia sp!, {r3, r4, r5, pc}
_0204CDEC:
	cmp r3, #0
	beq _0204CE38
	ldr r2, [r0, #0x1c]
	str r2, [r1]
	ldr r2, [r0, #0x18]
	str r2, [r1, #4]
	ldr r2, [r0, #0x14]
	str r2, [r1, #8]
	ldr r2, [r0, #0x10]
	str r2, [r1, #0xc]
	ldr r2, [r0, #0xc]
	str r2, [r1, #0x10]
	ldr r2, [r0, #8]
	str r2, [r1, #0x14]
	ldr r2, [r0, #4]
	str r2, [r1, #0x18]
	ldr r0, [r0, #0]
	str r0, [r1, #0x1c]
	ldmia sp!, {r3, r4, r5, pc}
_0204CE38:
	mov r2, #0x20
	bl MIi_CpuCopyFast
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BackgroundUnknown__Func_204CD20

	arm_func_start BackgroundUnknown__Func_204CE44
BackgroundUnknown__Func_204CE44: // 0x0204CE44
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x30
	ldrh ip, [sp, #0x70]
	ldr r5, [sp, #0x68]
	mov r10, r2
	ldr r9, [sp, #0x58]
	ldr r8, [sp, #0x5c]
	ldr r6, [sp, #0x64]
	ldr r4, [sp, #0x6c]
	ldr r7, _0204D2B4 // =_02134448
	and r11, r10, #7
	strh ip, [r7, #2]
	and lr, r5, #7
	cmp r11, lr
	str r0, [sp, #0x18]
	str r1, [sp, #0x1c]
	mov r11, r3
	ldr r7, [sp, #0x60]
	bne _0204D1A0
	tst r10, #1
	beq _0204CEDC
	str r8, [sp]
	str r7, [sp, #4]
	str r6, [sp, #8]
	str r5, [sp, #0xc]
	str r4, [sp, #0x10]
	bl BackgroundUnknown__Func_204E9B0
	add r0, r10, #1
	add r1, r5, #1
	sub r2, r9, #1
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	movs r9, r2, lsr #0x10
	mov r10, r0, lsr #0x10
	mov r5, r1, lsr #0x10
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204CEDC:
	and r0, r10, #7
	cmp r0, #0
	ble _0204CF50
	rsb r0, r0, #8
	str r0, [sp, #0x20]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	stmia sp, {r0, r8}
	str r7, [sp, #8]
	str r6, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x18]
	mov r2, r10
	mov r3, r11
	str r4, [sp, #0x14]
	bl BackgroundUnknown__Func_204D424
	ldr r0, [sp, #0x20]
	add r1, r5, r0
	sub r2, r9, r0
	add r3, r10, r0
	mov r0, r3, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	movs r9, r2, lsr #0x10
	mov r10, r0, lsr #0x10
	mov r5, r1, lsr #0x10
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204CF50:
	tst r9, #1
	beq _0204CFB0
	add r0, r5, r9
	str r8, [sp]
	sub r0, r0, #1
	str r7, [sp, #4]
	mov r0, r0, lsl #0x10
	add r1, r10, r9
	sub r1, r1, #1
	mov r2, r1, lsl #0x10
	str r6, [sp, #8]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x18]
	mov r3, r11
	mov r2, r2, lsr #0x10
	str r4, [sp, #0x10]
	bl BackgroundUnknown__Func_204E9B0
	sub r0, r9, #1
	mov r0, r0, lsl #0x10
	movs r9, r0, lsr #0x10
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204CFB0:
	and r0, r9, #7
	str r0, [sp, #0x24]
	cmp r0, #0
	ble _0204D02C
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	stmia sp, {r0, r8}
	ldr r0, [sp, #0x24]
	add r1, r5, r9
	sub r0, r1, r0
	mov r1, r0, lsl #0x10
	str r7, [sp, #8]
	ldr r0, [sp, #0x24]
	add r2, r10, r9
	sub r0, r2, r0
	mov r2, r0, lsl #0x10
	str r6, [sp, #0xc]
	mov r0, r1, lsr #0x10
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x18]
	mov r2, r2, lsr #0x10
	mov r3, r11
	str r4, [sp, #0x14]
	bl BackgroundUnknown__Func_204D424
	ldr r0, [sp, #0x24]
	sub r0, r9, r0
	mov r0, r0, lsl #0x10
	movs r9, r0, lsr #0x10
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204D02C:
	ldr r0, _0204D2B4 // =_02134448
	ldrh r1, [r0, #0]
	tst r1, #1
	ldreqh r0, [r0, #2]
	cmpeq r0, #0
	andeq r1, r11, #7
	andeq r0, r4, #7
	cmpeq r1, r0
	bne _0204D16C
	cmp r1, #0
	ble _0204D0C0
	rsb r0, r1, #8
	str r0, [sp, #0x28]
	mov r0, r0, lsl #0x10
	str r9, [sp]
	mov r0, r0, lsr #0x10
	stmib sp, {r0, r7}
	str r6, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x18]
	mov r2, r10
	mov r3, r11
	str r4, [sp, #0x14]
	bl BackgroundUnknown__Func_204D394
	ldr r0, [sp, #0x28]
	add r1, r4, r0
	sub r2, r8, r0
	add r3, r11, r0
	mov r0, r3, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	movs r8, r2, lsr #0x10
	mov r11, r0, lsr #0x10
	mov r4, r1, lsr #0x10
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204D0C0:
	and r0, r8, #7
	str r0, [sp, #0x2c]
	cmp r0, #0
	ble _0204D138
	mov r0, r0, lsl #0x10
	str r9, [sp]
	mov r0, r0, lsr #0x10
	stmib sp, {r0, r7}
	str r6, [sp, #0xc]
	ldr r0, [sp, #0x2c]
	add r2, r4, r8
	add r1, r11, r8
	sub r2, r2, r0
	sub r0, r1, r0
	mov r1, r2, lsl #0x10
	mov r2, r0, lsl #0x10
	mov r3, r2, lsr #0x10
	mov r1, r1, lsr #0x10
	str r5, [sp, #0x10]
	str r1, [sp, #0x14]
	ldr r0, [sp, #0x18]
	ldr r1, [sp, #0x1c]
	mov r2, r10
	bl BackgroundUnknown__Func_204D394
	ldr r0, [sp, #0x2c]
	sub r0, r8, r0
	mov r0, r0, lsl #0x10
	movs r8, r0, lsr #0x10
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204D138:
	str r9, [sp]
	str r8, [sp, #4]
	str r7, [sp, #8]
	str r6, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x18]
	mov r2, r10
	mov r3, r11
	str r4, [sp, #0x14]
	bl BackgroundUnknown__Func_204D2B8
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204D16C:
	str r9, [sp]
	str r8, [sp, #4]
	str r7, [sp, #8]
	str r6, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x18]
	mov r2, r10
	mov r3, r11
	str r4, [sp, #0x14]
	bl BackgroundUnknown__Func_204D394
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204D1A0:
	and lr, r10, #1
	and ip, r5, #1
	cmp lr, ip
	bne _0204D290
	cmp lr, #0
	beq _0204D1FC
	str r8, [sp]
	str r7, [sp, #4]
	str r6, [sp, #8]
	str r5, [sp, #0xc]
	str r4, [sp, #0x10]
	bl BackgroundUnknown__Func_204E9B0
	add r0, r10, #1
	add r1, r5, #1
	sub r2, r9, #1
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	movs r9, r2, lsr #0x10
	mov r10, r0, lsr #0x10
	mov r5, r1, lsr #0x10
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204D1FC:
	tst r9, #1
	beq _0204D25C
	add r0, r5, r9
	str r8, [sp]
	sub r0, r0, #1
	str r7, [sp, #4]
	mov r0, r0, lsl #0x10
	add r1, r10, r9
	sub r1, r1, #1
	mov r2, r1, lsl #0x10
	str r6, [sp, #8]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x18]
	mov r3, r11
	mov r2, r2, lsr #0x10
	str r4, [sp, #0x10]
	bl BackgroundUnknown__Func_204E9B0
	sub r0, r9, #1
	mov r0, r0, lsl #0x10
	movs r9, r0, lsr #0x10
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204D25C:
	str r9, [sp]
	str r8, [sp, #4]
	str r7, [sp, #8]
	str r6, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x18]
	mov r2, r10
	mov r3, r11
	str r4, [sp, #0x14]
	bl BackgroundUnknown__Func_204D424
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204D290:
	str r9, [sp]
	str r8, [sp, #4]
	str r7, [sp, #8]
	str r6, [sp, #0xc]
	str r5, [sp, #0x10]
	str r4, [sp, #0x14]
	bl BackgroundUnknown__Func_204DDE8
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0204D2B4: .word _02134448
	arm_func_end BackgroundUnknown__Func_204CE44

	arm_func_start BackgroundUnknown__Func_204D2B8
BackgroundUnknown__Func_204D2B8: // 0x0204D2B8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	ldrh r4, [sp, #0x34]
	ldrh r6, [sp, #0x40]
	mov r10, r3
	mov r4, r4, asr #3
	strh r4, [sp, #0x34]
	ldrh r4, [sp, #0x3c]
	ldrh r7, [sp, #0x34]
	mov r9, r6, asr #3
	ldrh r5, [sp, #0x30]
	mov r9, r9, lsl #5
	mov r3, r10, lsl #0xd
	mov r6, r5, asr #3
	ldr r8, [sp, #0x44]
	mov r6, r6, lsl #5
	mov r5, r8, lsl #0xd
	strh r9, [sp, #0x40]
	mov r8, r5, lsr #0x10
	mov r2, r2, asr #3
	str r0, [sp]
	mov r0, r2, lsl #0x15
	ldr r9, [sp, #0x38]
	strh r6, [sp, #0x30]
	cmp r7, #0
	str r0, [sp, #8]
	mov r11, r1, lsl #5
	mov r4, r4, lsl #5
	mov r10, r3, lsr #0x10
	mov r5, #0
	addle sp, sp, #0xc
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r0, [sp, #0x30]
	ldrh r6, [sp, #0x40]
	str r0, [sp, #4]
_0204D344:
	mul r2, r11, r10
	mla r1, r4, r8, r6
	ldr r0, [sp, #8]
	add r1, r9, r1
	add r3, r2, r0, lsr #16
	ldr r0, [sp]
	ldr r2, [sp, #4]
	add r0, r0, r3
	bl MIi_CpuCopyFast
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	add r5, r5, #1
	add r1, r8, #1
	mov r10, r0, lsr #0x10
	mov r0, r1, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r5, r7
	blt _0204D344
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end BackgroundUnknown__Func_204D2B8

	arm_func_start BackgroundUnknown__Func_204D394
BackgroundUnknown__Func_204D394: // 0x0204D394
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	ldrh r6, [sp, #0x48]
	str r1, [sp, #0x18]
	str r3, [sp, #0x1c]
	ldr r9, [sp, #0x4c]
	ldr r8, [sp, #0x50]
	ldr r7, [sp, #0x54]
	ldr r11, [sp, #0x5c]
	str r0, [sp, #0x14]
	cmp r6, #0
	mov r10, r2
	mov r4, #0
	addle sp, sp, #0x20
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r5, [sp, #0x58]
_0204D3D4:
	str r9, [sp]
	str r8, [sp, #4]
	mov r0, r5, lsl #0x10
	str r7, [sp, #8]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	ldr r1, [sp, #0x18]
	mov r2, r10, lsl #0x10
	str r11, [sp, #0x10]
	ldr r0, [sp, #0x14]
	ldr r3, [sp, #0x1c]
	mov r2, r2, lsr #0x10
	bl BackgroundUnknown__Func_204E0AC
	add r4, r4, #8
	cmp r4, r6
	add r5, r5, #8
	add r10, r10, #8
	blt _0204D3D4
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end BackgroundUnknown__Func_204D394

	arm_func_start BackgroundUnknown__Func_204D424
BackgroundUnknown__Func_204D424: // 0x0204D424
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x58
	str r2, [sp, #0x14]
	mov r9, r0
	mov r0, r2
	mov r10, r1
	ands r1, r0, #7
	ldr r8, [sp, #0x84]
	ldr r6, [sp, #0x8c]
	ldr r0, [sp, #0x90]
	mov r11, r3
	str r0, [sp, #0x90]
	moveq r0, #0
	streq r0, [sp, #0x18]
	rsbne r0, r1, #8
	strne r0, [sp, #0x18]
	ldrh r0, [sp, #0x80]
	ldr r1, [sp, #0x18]
	ldr r7, [sp, #0x88]
	ldr r5, [sp, #0x94]
	cmp r1, r0
	blt _0204D48C
	mov r1, #0
	str r0, [sp, #0x18]
	str r1, [sp, #0x50]
	b _0204D4A4
_0204D48C:
	sub r1, r0, r1
	bic r2, r1, #7
	ldr r1, [sp, #0x18]
	add r1, r1, r2
	sub r1, r0, r1
	str r1, [sp, #0x50]
_0204D4A4:
	ldr r1, [sp, #0x90]
	ands r1, r1, #7
	moveq r1, #0
	rsbne r1, r1, #8
	cmp r1, r0
	blt _0204D4D4
	mov r1, #0
	str r1, [sp, #0x4c]
	mov r1, r0
	ldr r0, [sp, #0x4c]
	str r0, [sp, #0x48]
	b _0204D4EC
_0204D4D4:
	sub r2, r0, r1
	bic r2, r2, #7
	str r2, [sp, #0x4c]
	add r2, r1, r2
	sub r0, r0, r2
	str r0, [sp, #0x48]
_0204D4EC:
	cmp r1, #2
	mov r4, #0
	beq _0204D50C
	cmp r1, #4
	beq _0204D550
	cmp r1, #6
	beq _0204D620
	b _0204D77C
_0204D50C:
	str r8, [sp]
	str r7, [sp, #4]
	str r6, [sp, #8]
	ldr r0, [sp, #0x90]
	mov r1, r10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r2, [sp, #0x14]
	mov r0, r9
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r11
	bl BackgroundUnknown__Func_204E734
	add r4, r4, #2
	b _0204D77C
_0204D550:
	ldr r0, [sp, #0x18]
	str r8, [sp]
	cmp r0, #2
	str r7, [sp, #4]
	bne _0204D5E4
	str r6, [sp, #8]
	ldr r0, [sp, #0x90]
	mov r1, r10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r2, [sp, #0x14]
	mov r0, r9
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r11
	bl BackgroundUnknown__Func_204E734
	str r8, [sp]
	str r7, [sp, #4]
	str r6, [sp, #8]
	ldr r0, [sp, #0x90]
	mov r1, r10
	add r0, r0, #2
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r2, [sp, #0x14]
	mov r0, r9
	add r2, r2, #2
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r11
	bl BackgroundUnknown__Func_204E734
	add r4, r4, #4
	b _0204D77C
_0204D5E4:
	str r6, [sp, #8]
	ldr r0, [sp, #0x90]
	mov r1, r10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r2, [sp, #0x14]
	mov r0, r9
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r11
	bl BackgroundUnknown__Func_204E508
	add r4, r4, #4
	b _0204D77C
_0204D620:
	ldr r0, [sp, #0x18]
	cmp r0, #2
	bne _0204D6B4
	str r8, [sp]
	str r7, [sp, #4]
	str r6, [sp, #8]
	ldr r0, [sp, #0x90]
	mov r1, r10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r2, [sp, #0x14]
	mov r0, r9
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r11
	bl BackgroundUnknown__Func_204E734
	str r8, [sp]
	str r7, [sp, #4]
	str r6, [sp, #8]
	ldr r0, [sp, #0x90]
	mov r1, r10
	add r0, r0, #2
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r2, [sp, #0x14]
	mov r0, r9
	add r2, r2, #2
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r11
	bl BackgroundUnknown__Func_204E508
	add r4, r4, #6
	b _0204D77C
_0204D6B4:
	str r8, [sp]
	cmp r0, #4
	str r7, [sp, #4]
	bne _0204D744
	str r6, [sp, #8]
	ldr r0, [sp, #0x90]
	mov r1, r10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r2, [sp, #0x14]
	mov r0, r9
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r11
	bl BackgroundUnknown__Func_204E508
	str r8, [sp]
	str r7, [sp, #4]
	str r6, [sp, #8]
	ldr r0, [sp, #0x90]
	mov r1, r10
	add r0, r0, #4
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r2, [sp, #0x14]
	mov r0, r9
	add r2, r2, #4
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r11
	bl BackgroundUnknown__Func_204E734
	add r4, r4, #6
	b _0204D77C
_0204D744:
	str r6, [sp, #8]
	ldr r0, [sp, #0x90]
	mov r1, r10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r2, [sp, #0x14]
	mov r0, r9
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r11
	bl BackgroundUnknown__Func_204E2F8
	add r4, r4, #6
_0204D77C:
	ldr r0, [sp, #0x18]
	cmp r0, r4
	subge r0, r0, r4
	sublt r0, r4, r0
	rsblt r0, r0, #8
	cmp r0, #6
	addls pc, pc, r0, lsl #2
	b _0204DB0C
_0204D79C: // jump table
	b _0204D7B8 // case 0
	b _0204DB0C // case 1
	b _0204D858 // case 2
	b _0204DB0C // case 3
	b _0204D940 // case 4
	b _0204DB0C // case 5
	b _0204DA28 // case 6
_0204D7B8:
	ldr r0, [sp, #0x4c]
	cmp r0, #0
	mov r0, #0
	str r0, [sp, #0x54]
	ble _0204DB0C
	ldr r0, [sp, #0x90]
	add r0, r0, r4
	str r0, [sp, #0x2c]
	ldr r0, [sp, #0x14]
	add r0, r0, r4
	str r0, [sp, #0x28]
_0204D7E4:
	ldr r0, [sp, #0x2c]
	str r8, [sp]
	ldr r2, [sp, #0x28]
	str r7, [sp, #4]
	mov r0, r0, lsl #0x10
	mov r2, r2, lsl #0x10
	str r6, [sp, #8]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	mov r0, r9
	mov r1, r10
	mov r2, r2, lsr #0x10
	mov r3, r11
	str r5, [sp, #0x10]
	bl BackgroundUnknown__Func_204E0AC
	ldr r0, [sp, #0x2c]
	add r4, r4, #8
	add r0, r0, #8
	str r0, [sp, #0x2c]
	ldr r0, [sp, #0x28]
	add r0, r0, #8
	str r0, [sp, #0x28]
	ldr r0, [sp, #0x54]
	add r1, r0, #8
	ldr r0, [sp, #0x4c]
	str r1, [sp, #0x54]
	cmp r1, r0
	blt _0204D7E4
	b _0204DB0C
_0204D858:
	ldr r0, [sp, #0x4c]
	cmp r0, #0
	mov r0, #0
	str r0, [sp, #0x1c]
	ble _0204DB0C
	ldr r0, [sp, #0x90]
	add r0, r0, r4
	str r0, [sp, #0x34]
	ldr r0, [sp, #0x14]
	add r0, r0, r4
	str r0, [sp, #0x30]
_0204D884:
	ldr r0, [sp, #0x34]
	str r8, [sp]
	str r7, [sp, #4]
	mov r0, r0, lsl #0x10
	ldr r2, [sp, #0x30]
	str r6, [sp, #8]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	mov r2, r2, lsl #0x10
	str r5, [sp, #0x10]
	mov r0, r9
	mov r1, r10
	mov r2, r2, lsr #0x10
	mov r3, r11
	bl BackgroundUnknown__Func_204E734
	str r8, [sp]
	str r7, [sp, #4]
	str r6, [sp, #8]
	ldr r0, [sp, #0x90]
	add r1, r4, #2
	add r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x14]
	mov r3, r11
	add r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r9
	mov r1, r10
	str r5, [sp, #0x10]
	bl BackgroundUnknown__Func_204E2F8
	ldr r0, [sp, #0x34]
	add r4, r4, #8
	add r0, r0, #8
	str r0, [sp, #0x34]
	ldr r0, [sp, #0x30]
	add r0, r0, #8
	str r0, [sp, #0x30]
	ldr r0, [sp, #0x1c]
	add r1, r0, #8
	ldr r0, [sp, #0x4c]
	str r1, [sp, #0x1c]
	cmp r1, r0
	blt _0204D884
	b _0204DB0C
_0204D940:
	ldr r0, [sp, #0x4c]
	cmp r0, #0
	mov r0, #0
	str r0, [sp, #0x20]
	ble _0204DB0C
	ldr r0, [sp, #0x90]
	add r0, r0, r4
	str r0, [sp, #0x3c]
	ldr r0, [sp, #0x14]
	add r0, r0, r4
	str r0, [sp, #0x38]
_0204D96C:
	ldr r0, [sp, #0x3c]
	str r8, [sp]
	str r7, [sp, #4]
	mov r0, r0, lsl #0x10
	ldr r2, [sp, #0x38]
	str r6, [sp, #8]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	mov r2, r2, lsl #0x10
	str r5, [sp, #0x10]
	mov r0, r9
	mov r1, r10
	mov r2, r2, lsr #0x10
	mov r3, r11
	bl BackgroundUnknown__Func_204E508
	str r8, [sp]
	str r7, [sp, #4]
	str r6, [sp, #8]
	ldr r0, [sp, #0x90]
	add r1, r4, #4
	add r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x14]
	mov r3, r11
	add r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r9
	mov r1, r10
	str r5, [sp, #0x10]
	bl BackgroundUnknown__Func_204E508
	ldr r0, [sp, #0x3c]
	add r4, r4, #8
	add r0, r0, #8
	str r0, [sp, #0x3c]
	ldr r0, [sp, #0x38]
	add r0, r0, #8
	str r0, [sp, #0x38]
	ldr r0, [sp, #0x20]
	add r1, r0, #8
	ldr r0, [sp, #0x4c]
	str r1, [sp, #0x20]
	cmp r1, r0
	blt _0204D96C
	b _0204DB0C
_0204DA28:
	ldr r0, [sp, #0x4c]
	cmp r0, #0
	mov r0, #0
	str r0, [sp, #0x24]
	ble _0204DB0C
	ldr r0, [sp, #0x90]
	add r0, r0, r4
	str r0, [sp, #0x44]
	ldr r0, [sp, #0x14]
	add r0, r0, r4
	str r0, [sp, #0x40]
_0204DA54:
	ldr r0, [sp, #0x44]
	str r8, [sp]
	str r7, [sp, #4]
	mov r0, r0, lsl #0x10
	ldr r2, [sp, #0x40]
	str r6, [sp, #8]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	mov r2, r2, lsl #0x10
	str r5, [sp, #0x10]
	mov r0, r9
	mov r1, r10
	mov r2, r2, lsr #0x10
	mov r3, r11
	bl BackgroundUnknown__Func_204E2F8
	str r8, [sp]
	str r7, [sp, #4]
	str r6, [sp, #8]
	ldr r0, [sp, #0x90]
	add r1, r4, #6
	add r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x14]
	mov r3, r11
	add r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r9
	mov r1, r10
	str r5, [sp, #0x10]
	bl BackgroundUnknown__Func_204E734
	ldr r0, [sp, #0x44]
	add r4, r4, #8
	add r0, r0, #8
	str r0, [sp, #0x44]
	ldr r0, [sp, #0x40]
	add r0, r0, #8
	str r0, [sp, #0x40]
	ldr r0, [sp, #0x24]
	add r1, r0, #8
	ldr r0, [sp, #0x4c]
	str r1, [sp, #0x24]
	cmp r1, r0
	blt _0204DA54
_0204DB0C:
	ldr r0, [sp, #0x48]
	cmp r0, #2
	beq _0204DB30
	cmp r0, #4
	beq _0204DB7C
	cmp r0, #6
	beq _0204DC64
	add sp, sp, #0x58
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204DB30:
	str r8, [sp]
	ldr r0, [sp, #0x90]
	mov r3, r11
	add r0, r0, r4
	str r7, [sp, #4]
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #0x14]
	add r0, r0, r4
	mov r2, r0, lsl #0x10
	mov r0, r1, lsr #0x10
	str r6, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, r9
	mov r1, r10
	mov r2, r2, lsr #0x10
	str r5, [sp, #0x10]
	bl BackgroundUnknown__Func_204E734
	add sp, sp, #0x58
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204DB7C:
	ldr r0, [sp, #0x50]
	str r8, [sp]
	cmp r0, #2
	bne _0204DC1C
	ldr r0, [sp, #0x90]
	mov r3, r11
	add r0, r0, r4
	str r7, [sp, #4]
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #0x14]
	add r0, r0, r4
	mov r2, r0, lsl #0x10
	mov r0, r1, lsr #0x10
	str r6, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, r9
	mov r1, r10
	mov r2, r2, lsr #0x10
	str r5, [sp, #0x10]
	bl BackgroundUnknown__Func_204E734
	str r8, [sp]
	ldr r0, [sp, #0x90]
	add r2, r4, #2
	add r0, r0, r2
	str r7, [sp, #4]
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #0x14]
	mov r3, r11
	add r0, r0, r2
	mov r2, r0, lsl #0x10
	mov r0, r1, lsr #0x10
	str r6, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, r9
	mov r1, r10
	mov r2, r2, lsr #0x10
	str r5, [sp, #0x10]
	bl BackgroundUnknown__Func_204E734
	add sp, sp, #0x58
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204DC1C:
	ldr r0, [sp, #0x90]
	mov r3, r11
	add r0, r0, r4
	str r7, [sp, #4]
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #0x14]
	add r0, r0, r4
	mov r2, r0, lsl #0x10
	mov r0, r1, lsr #0x10
	str r6, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, r9
	mov r1, r10
	mov r2, r2, lsr #0x10
	str r5, [sp, #0x10]
	bl BackgroundUnknown__Func_204E508
	add sp, sp, #0x58
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204DC64:
	ldr r0, [sp, #0x50]
	cmp r0, #2
	bne _0204DD04
	str r8, [sp]
	ldr r0, [sp, #0x90]
	mov r3, r11
	add r0, r0, r4
	str r7, [sp, #4]
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #0x14]
	add r0, r0, r4
	mov r2, r0, lsl #0x10
	mov r0, r1, lsr #0x10
	str r6, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, r9
	mov r1, r10
	mov r2, r2, lsr #0x10
	str r5, [sp, #0x10]
	bl BackgroundUnknown__Func_204E508
	str r8, [sp]
	ldr r0, [sp, #0x90]
	add r2, r4, #4
	add r0, r0, r2
	str r7, [sp, #4]
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #0x14]
	mov r3, r11
	add r0, r0, r2
	mov r2, r0, lsl #0x10
	mov r0, r1, lsr #0x10
	str r6, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, r9
	mov r1, r10
	mov r2, r2, lsr #0x10
	str r5, [sp, #0x10]
	bl BackgroundUnknown__Func_204E734
	add sp, sp, #0x58
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204DD04:
	cmp r0, #4
	str r8, [sp]
	bne _0204DDA0
	ldr r0, [sp, #0x90]
	mov r3, r11
	add r0, r0, r4
	str r7, [sp, #4]
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #0x14]
	add r0, r0, r4
	mov r2, r0, lsl #0x10
	mov r0, r1, lsr #0x10
	str r6, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, r9
	mov r1, r10
	mov r2, r2, lsr #0x10
	str r5, [sp, #0x10]
	bl BackgroundUnknown__Func_204E734
	str r8, [sp]
	ldr r0, [sp, #0x90]
	add r2, r4, #2
	add r0, r0, r2
	str r7, [sp, #4]
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #0x14]
	mov r3, r11
	add r0, r0, r2
	mov r2, r0, lsl #0x10
	mov r0, r1, lsr #0x10
	str r6, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, r9
	mov r1, r10
	mov r2, r2, lsr #0x10
	str r5, [sp, #0x10]
	bl BackgroundUnknown__Func_204E508
	add sp, sp, #0x58
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204DDA0:
	ldr r0, [sp, #0x90]
	mov r3, r11
	add r0, r0, r4
	str r7, [sp, #4]
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #0x14]
	add r0, r0, r4
	mov r2, r0, lsl #0x10
	mov r0, r1, lsr #0x10
	str r6, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, r9
	mov r1, r10
	mov r2, r2, lsr #0x10
	str r5, [sp, #0x10]
	bl BackgroundUnknown__Func_204E2F8
	add sp, sp, #0x58
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end BackgroundUnknown__Func_204D424

	arm_func_start BackgroundUnknown__Func_204DDE8
BackgroundUnknown__Func_204DDE8: // 0x0204DDE8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x30
	ldr r4, _0204E0A8 // =_02134448
	ldrh r5, [sp, #0x64]
	ldrh r4, [r4, #2]
	mov r1, r1, lsl #5
	str r1, [sp, #0x28]
	mov r1, r5, lsl #5
	str r1, [sp, #0x24]
	cmp r4, #0
	bne _0204DF50
	ldrh r1, [sp, #0x5c]
	str r1, [sp, #8]
	mov r1, #0
	str r1, [sp, #0x2c]
	ldr r1, [sp, #8]
	cmp r1, #0
	addle sp, sp, #0x30
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r1, [sp, #0x6c]
	ldr r9, [sp, #0x60]
	str r1, [sp, #0x14]
	ldrh r1, [sp, #0x68]
	str r1, [sp, #0x10]
	ldrh r1, [sp, #0x58]
	str r1, [sp, #0xc]
_0204DE50:
	ldr r1, [sp, #0xc]
	mov r7, #0
	cmp r1, #0
	ble _0204DF20
	ldr r1, [sp, #0x14]
	mov r5, r3, asr #3
	mov r4, r1, asr #3
	ldr r1, [sp, #0x24]
	mov r6, r3, lsl #0x1d
	mul r11, r1, r4
	ldr r1, [sp, #0x28]
	mul r5, r1, r5
	ldr r1, [sp, #0x14]
	mov lr, r1, lsl #0x1d
_0204DE88:
	add r1, r2, r7
	and r4, r1, #4
	mov r4, r4, asr #1
	add r8, r4, r6, lsr #27
	mov r4, r1, asr #3
	add r4, r5, r4, lsl #5
	add r4, r8, r4
	mov r1, r1, lsl #0x1e
	ldrh r4, [r0, r4]
	mov r1, r1, lsr #0x1c
	mov r1, r4, asr r1
	and r8, r1, #0xf
	ldr r1, _0204E0A8 // =_02134448
	ldrh r1, [r1, #0]
	tst r1, #1
	beq _0204DED0
	cmp r8, #0
	beq _0204DF10
_0204DED0:
	ldr r1, [sp, #0x10]
	add r10, r1, r7
	and r1, r10, #4
	mov r1, r1, asr #1
	mov r4, r10, asr #3
	add r1, r1, lr, lsr #27
	add r4, r11, r4, lsl #5
	add r4, r1, r4
	mov r1, r10, lsl #0x1e
	mov ip, r1, lsr #0x1c
	mov r10, #0xf
	ldrh r1, [r9, r4]
	mvn r10, r10, lsl ip
	and r1, r1, r10
	orr r1, r1, r8, lsl ip
	strh r1, [r9, r4]
_0204DF10:
	ldr r1, [sp, #0xc]
	add r7, r7, #1
	cmp r7, r1
	blt _0204DE88
_0204DF20:
	ldr r1, [sp, #0x2c]
	add r3, r3, #1
	add r4, r1, #1
	ldr r1, [sp, #8]
	str r4, [sp, #0x2c]
	cmp r4, r1
	ldr r1, [sp, #0x14]
	add r1, r1, #1
	str r1, [sp, #0x14]
	blt _0204DE50
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204DF50:
	ldrh r1, [sp, #0x5c]
	str r1, [sp, #4]
	mov r1, #0
	str r1, [sp]
	ldr r1, [sp, #4]
	cmp r1, #0
	addle sp, sp, #0x30
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r1, [sp, #0x6c]
	ldr r9, [sp, #0x60]
	str r1, [sp, #0x20]
	ldrh r1, [sp, #0x68]
	str r1, [sp, #0x1c]
	ldrh r1, [sp, #0x58]
	str r1, [sp, #0x18]
_0204DF8C:
	ldr r1, [sp, #0x18]
	mov r10, #0
	cmp r1, #0
	ble _0204E078
	ldr r1, [sp, #0x20]
	mov r5, r3, asr #3
	mov r4, r1, asr #3
	ldr r1, [sp, #0x24]
	mov r8, r3, lsl #0x1d
	mul lr, r1, r4
	ldr r1, [sp, #0x28]
	mul r7, r1, r5
	ldr r1, [sp, #0x20]
	mov r5, r1, lsl #0x1d
_0204DFC4:
	add r1, r2, r10
	and r4, r1, #4
	mov r4, r4, asr #1
	add r6, r4, r8, lsr #27
	mov r4, r1, asr #3
	add r4, r7, r4, lsl #5
	add r4, r6, r4
	mov r1, r1, lsl #0x1e
	ldrh r4, [r0, r4]
	mov r1, r1, lsr #0x1c
	mov r1, r4, asr r1
	and r11, r1, #0xf
	ldr r1, _0204E0A8 // =_02134448
	ldrh r1, [r1, #0]
	tst r1, #1
	beq _0204E00C
	cmp r11, #0
	beq _0204E068
_0204E00C:
	cmp r11, #0
	beq _0204E028
	ldr r1, _0204E0A8 // =_02134448
	ldrh r1, [r1, #2]
	add r1, r11, r1
	mov r1, r1, lsl #0x10
	mov r11, r1, lsr #0x10
_0204E028:
	ldr r1, [sp, #0x1c]
	mov ip, #0xf
	add r4, r1, r10
	and r1, r4, #4
	mov r1, r1, asr #1
	mov r6, r4, asr #3
	add r1, r1, r5, lsr #27
	add r6, lr, r6, lsl #5
	add r6, r1, r6
	mov r1, r4, lsl #0x1e
	mov r4, r1, lsr #0x1c
	ldrh r1, [r9, r6]
	mvn ip, ip, lsl r4
	and r1, r1, ip
	orr r1, r1, r11, lsl r4
	strh r1, [r9, r6]
_0204E068:
	ldr r1, [sp, #0x18]
	add r10, r10, #1
	cmp r10, r1
	blt _0204DFC4
_0204E078:
	ldr r1, [sp]
	add r3, r3, #1
	add r4, r1, #1
	ldr r1, [sp, #4]
	str r4, [sp]
	cmp r4, r1
	ldr r1, [sp, #0x20]
	add r1, r1, #1
	str r1, [sp, #0x20]
	blt _0204DF8C
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0204E0A8: .word _02134448
	arm_func_end BackgroundUnknown__Func_204DDE8

	arm_func_start BackgroundUnknown__Func_204E0AC
BackgroundUnknown__Func_204E0AC: // 0x0204E0AC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	ldr r4, _0204E2F4 // =_02134448
	str r0, [sp]
	ldrh r6, [r4, #0]
	mov r0, r1, lsl #5
	str r0, [sp, #0x14]
	mov r0, r2, asr #3
	ldrh r7, [sp, #0x50]
	ldrh r5, [sp, #0x54]
	str r0, [sp, #0x18]
	str r3, [sp, #4]
	mov r0, r5, asr #3
	tst r6, #1
	str r0, [sp, #0x1c]
	ldreqh r0, [r4, #2]
	mov r11, r7, lsl #5
	cmpeq r0, #0
	bne _0204E198
	ldrh r8, [sp, #0x48]
	mov r4, #0
	cmp r8, #0
	addle sp, sp, #0x20
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r6, [sp, #0x58]
	ldr r7, [sp, #0x4c]
_0204E114:
	ldr r0, [sp, #4]
	add r3, r6, r4
	add r0, r0, r4
	mov r5, r0, asr #3
	and r2, r0, #7
	ldr r0, [sp, #0x14]
	mov r1, r3, asr #3
	mul r5, r0, r5
	ldr r0, [sp, #0x18]
	and r3, r3, #7
	add r0, r5, r0, lsl #5
	mul r5, r11, r1
	ldr r1, [sp, #0x1c]
	add r0, r0, r2, lsl #2
	add r1, r5, r1, lsl #5
	add r1, r1, r3, lsl #2
	rsb r2, r2, #8
	sub r5, r8, r4
	cmp r2, r5
	movlt r5, r2
	rsb r2, r3, #8
	cmp r2, r5
	movlt r5, r2
	ldr r2, [sp]
	add r1, r7, r1
	add r0, r2, r0
	mov r2, r5, lsl #2
	bl MIi_CpuCopy32
	add r4, r4, r5
	cmp r4, r8
	blt _0204E114
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204E198:
	ldrh r4, [sp, #0x48]
	mov r5, #0
	cmp r4, #0
	addle sp, sp, #0x20
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r0, [sp, #0x58]
	ldr r1, _0204E2F4 // =_02134448
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x4c]
	ldrh lr, [r1, #2]
	str r0, [sp, #0xc]
	and r0, r6, #1
	str r0, [sp, #8]
_0204E1CC:
	ldr r0, [sp, #4]
	sub r8, r4, r5
	add r1, r0, r5
	ldr r0, [sp, #0x10]
	mov r2, r1, asr #3
	add r3, r0, r5
	and r0, r1, #7
	ldr r1, [sp, #0x14]
	mul r2, r1, r2
	ldr r1, [sp, #0x18]
	add r1, r2, r1, lsl #5
	add r2, r1, r0, lsl #2
	ldr r1, [sp]
	add r6, r1, r2
	rsb r2, r0, #8
	cmp r2, r8
	movlt r8, r2
	mov r1, r3, asr #3
	and r0, r3, #7
	mul r3, r11, r1
	ldr r1, [sp, #0x1c]
	mov r2, #0
	add r1, r3, r1, lsl #5
	add r3, r1, r0, lsl #2
	rsb r0, r0, #8
	ldr r1, [sp, #0xc]
	cmp r0, r8
	movlt r8, r0
	ldr r0, [sp, #8]
	add r7, r1, r3
	cmp r0, #0
	beq _0204E2A4
	cmp r8, #0
	ble _0204E2E0
	mov r0, #0xf
	mov r1, r2
_0204E25C:
	ldr r10, [r6, r2, lsl #2]
	ldr ip, [r7, r2, lsl #2]
	mov r3, r1
_0204E268:
	tst r10, r0, lsl r3
	addne r10, r10, lr, lsl r3
	bne _0204E284
	mvn r9, r0, lsl r3
	and r10, r10, r9
	and r9, ip, r0, lsl r3
	orr r10, r10, r9
_0204E284:
	add r3, r3, #4
	cmp r3, #0x20
	blt _0204E268
	str r10, [r7, r2, lsl #2]
	add r2, r2, #1
	cmp r2, r8
	blt _0204E25C
	b _0204E2E0
_0204E2A4:
	cmp r8, #0
	ble _0204E2E0
	mov r0, #0xf
	mov r1, r2
_0204E2B4:
	ldr r3, [r6, r2, lsl #2]
	mov r9, r1
_0204E2BC:
	tst r3, r0, lsl r9
	addne r3, r3, lr, lsl r9
	add r9, r9, #4
	cmp r9, #0x20
	blt _0204E2BC
	str r3, [r7, r2, lsl #2]
	add r2, r2, #1
	cmp r2, r8
	blt _0204E2B4
_0204E2E0:
	add r5, r5, r8
	cmp r5, r4
	blt _0204E1CC
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0204E2F4: .word _02134448
	arm_func_end BackgroundUnknown__Func_204E0AC

	arm_func_start BackgroundUnknown__Func_204E2F8
BackgroundUnknown__Func_204E2F8: // 0x0204E2F8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	ldr r6, _0204E504 // =_02134448
	ldrh r7, [sp, #0x4c]
	ldrh r5, [r6, #0]
	mov r1, r1, lsl #5
	ldrh r9, [sp, #0x48]
	str r1, [sp, #0x14]
	tst r5, #1
	mov r1, r9, lsl #5
	str r1, [sp, #0x10]
	mov r1, r7, asr #3
	str r1, [sp, #0x18]
	ldreqh r1, [r6, #2]
	mov r8, r2, lsl #0x1d
	mov r4, r7, lsl #0x1d
	mov r11, r2, asr #3
	mov lr, r8, lsr #0x1b
	mov r4, r4, lsr #0x1b
	cmpeq r1, #0
	bne _0204E3DC
	ldrh r9, [sp, #0x40]
	mov r6, #0
	cmp r9, #0
	addle sp, sp, #0x1c
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mvn r1, #0xff000000
	ldrh r7, [sp, #0x50]
	mvn ip, r1, lsl r4
	ldr r8, [sp, #0x44]
_0204E370:
	ldr r1, [sp, #0x14]
	mov r2, r3, asr #3
	mul r2, r1, r2
	add r1, r2, r11, lsl #5
	mov r2, r3, lsl #0x1d
	add r1, r1, r2, lsr #27
	ldr r1, [r0, r1]
	add r6, r6, #1
	mov r1, r1, lsr lr
	bic r5, r1, #0xff000000
	ldr r10, [sp, #0x10]
	mov r1, r7, asr #3
	mul r1, r10, r1
	ldr r10, [sp, #0x18]
	mov r2, r7, lsl #0x1d
	add r1, r1, r10, lsl #5
	add r1, r1, r2, lsr #27
	ldr r2, [r8, r1]
	add r3, r3, #1
	and r2, r2, ip
	orr r2, r2, r5, lsl r4
	str r2, [r8, r1]
	add r7, r7, #1
	cmp r6, r9
	blt _0204E370
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204E3DC:
	ldrh r1, [sp, #0x40]
	str r1, [sp, #4]
	mov r1, #0
	str r1, [sp]
	ldr r1, [sp, #4]
	cmp r1, #0
	addle sp, sp, #0x1c
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r2, _0204E504 // =_02134448
	and r1, r5, #1
	mvn r7, #0xff000000
	str r1, [sp, #0xc]
	mvn r1, r7, lsl r4
	ldrh r6, [sp, #0x50]
	ldrh r8, [r2, #2]
	ldr r7, [sp, #0x44]
	str r1, [sp, #8]
_0204E420:
	ldr r1, [sp, #0xc]
	mov r2, r3, asr #3
	cmp r1, #0
	ldr r1, [sp, #0x14]
	mov r5, r3, lsl #0x1d
	mul r2, r1, r2
	add r1, r2, r11, lsl #5
	add r1, r1, r5, lsr #27
	ldr r2, [r0, r1]
	mov r5, r6, asr #3
	mov r2, r2, lsr lr
	bic r10, r2, #0xff000000
	ldr r2, [sp, #0x10]
	mov r1, r6, lsl #0x1d
	mul r5, r2, r5
	ldr r2, [sp, #0x18]
	add r2, r5, r2, lsl #5
	add r2, r2, r1, lsr #27
	beq _0204E4AC
	ldr r1, [r7, r2]
	mov ip, #0
	mov r1, r1, lsr r4
	bic r5, r1, #0xff000000
	mov r1, #0xf
_0204E480:
	tst r10, r1, lsl ip
	addne r10, r10, r8, lsl ip
	bne _0204E49C
	mvn r9, r1, lsl ip
	and r10, r10, r9
	and r9, r5, r1, lsl ip
	orr r10, r10, r9
_0204E49C:
	add ip, ip, #4
	cmp ip, #0x18
	blt _0204E480
	b _0204E4C8
_0204E4AC:
	mov r5, #0
	mov r1, #0xf
_0204E4B4:
	tst r10, r1, lsl r5
	addne r10, r10, r8, lsl r5
	add r5, r5, #4
	cmp r5, #0x18
	blt _0204E4B4
_0204E4C8:
	ldr r5, [r7, r2]
	ldr r1, [sp, #8]
	add r3, r3, #1
	and r1, r5, r1
	orr r1, r1, r10, lsl r4
	str r1, [r7, r2]
	ldr r1, [sp]
	add r6, r6, #1
	add r2, r1, #1
	ldr r1, [sp, #4]
	str r2, [sp]
	cmp r2, r1
	blt _0204E420
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0204E504: .word _02134448
	arm_func_end BackgroundUnknown__Func_204E2F8

	arm_func_start BackgroundUnknown__Func_204E508
BackgroundUnknown__Func_204E508: // 0x0204E508
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	ldrh r9, [sp, #0x50]
	ldr r5, _0204E72C // =_02134448
	ldrh r7, [sp, #0x54]
	mov r1, r1, lsl #5
	ldrh r4, [r5, #0]
	str r1, [sp, #0x14]
	mov r1, r9, lsl #5
	str r1, [sp, #0x10]
	mov r1, r2, asr #3
	str r1, [sp, #0x18]
	mov r1, r7, asr #3
	mov r8, r2, lsl #0x1d
	mov r6, r7, lsl #0x1d
	tst r4, #1
	str r1, [sp, #0x1c]
	ldreqh r1, [r5, #2]
	mov r11, r8, lsr #0x1b
	mov r6, r6, lsr #0x1b
	cmpeq r1, #0
	bne _0204E5F8
	ldrh r10, [sp, #0x48]
	mov r5, #0
	cmp r10, #0
	addle sp, sp, #0x20
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _0204E730 // =0x0000FFFF
	ldrh r7, [sp, #0x58]
	mvn r9, r1, lsl r6
	ldr r8, [sp, #0x4c]
_0204E584:
	ldr r1, [sp, #0x14]
	mov r2, r3, asr #3
	mul r2, r1, r2
	ldr r1, [sp, #0x18]
	add r5, r5, #1
	add r1, r2, r1, lsl #5
	mov r2, r3, lsl #0x1d
	add r1, r1, r2, lsr #27
	ldr r1, [r0, r1]
	ldr ip, [sp, #0x10]
	mov r1, r1, lsr r11
	mov r1, r1, lsl #0x10
	mov r4, r1, lsr #0x10
	mov r1, r7, asr #3
	mul r1, ip, r1
	ldr ip, [sp, #0x1c]
	mov r2, r7, lsl #0x1d
	add r1, r1, ip, lsl #5
	add r1, r1, r2, lsr #27
	ldr r2, [r8, r1]
	add r3, r3, #1
	and r2, r2, r9
	orr r2, r2, r4, lsl r6
	str r2, [r8, r1]
	add r7, r7, #1
	cmp r5, r10
	blt _0204E584
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204E5F8:
	ldrh r1, [sp, #0x48]
	str r1, [sp, #4]
	mov r1, #0
	str r1, [sp]
	ldr r1, [sp, #4]
	cmp r1, #0
	addle sp, sp, #0x20
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r2, _0204E72C // =_02134448
	and r1, r4, #1
	ldr r5, _0204E730 // =0x0000FFFF
	str r1, [sp, #0xc]
	mvn r1, r5, lsl r6
	ldrh r7, [sp, #0x58]
	ldrh r9, [r2, #2]
	ldr r8, [sp, #0x4c]
	str r1, [sp, #8]
_0204E63C:
	ldr r1, [sp, #0xc]
	mov r2, r3, asr #3
	cmp r1, #0
	ldr r1, [sp, #0x14]
	mov r4, r3, lsl #0x1d
	mul r2, r1, r2
	ldr r1, [sp, #0x18]
	add r1, r2, r1, lsl #5
	add r1, r1, r4, lsr #27
	ldr r2, [r0, r1]
	mov r4, r7, asr #3
	mov r2, r2, lsr r11
	mov r2, r2, lsl #0x10
	mov r10, r2, lsr #0x10
	ldr r2, [sp, #0x10]
	mov r1, r7, lsl #0x1d
	mul r4, r2, r4
	ldr r2, [sp, #0x1c]
	add r2, r4, r2, lsl #5
	add r4, r2, r1, lsr #27
	beq _0204E6D4
	ldr r1, [r8, r4]
	mov r5, #0
	mov r1, r1, lsr r6
	mov r1, r1, lsl #0x10
	mov ip, #0xf
_0204E6A4:
	tst r10, ip, lsl r5
	mov lr, ip, lsl r5
	addne r10, r10, r9, lsl r5
	bne _0204E6C4
	mvn r2, lr
	and r2, r10, r2
	and r10, lr, r1, lsr #16
	orr r10, r2, r10
_0204E6C4:
	add r5, r5, #4
	cmp r5, #0x10
	blt _0204E6A4
	b _0204E6F0
_0204E6D4:
	mov r2, #0
	mov r1, #0xf
_0204E6DC:
	tst r10, r1, lsl r2
	addne r10, r10, r9, lsl r2
	add r2, r2, #4
	cmp r2, #0x10
	blt _0204E6DC
_0204E6F0:
	ldr r2, [r8, r4]
	ldr r1, [sp, #8]
	add r3, r3, #1
	and r1, r2, r1
	orr r1, r1, r10, lsl r6
	str r1, [r8, r4]
	ldr r1, [sp]
	add r7, r7, #1
	add r2, r1, #1
	ldr r1, [sp, #4]
	str r2, [sp]
	cmp r2, r1
	blt _0204E63C
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0204E72C: .word _02134448
_0204E730: .word 0x0000FFFF
	arm_func_end BackgroundUnknown__Func_204E508

	arm_func_start BackgroundUnknown__Func_204E734
BackgroundUnknown__Func_204E734: // 0x0204E734
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	ldrh r9, [sp, #0x50]
	mov r1, r1, lsl #5
	ldr r4, _0204E9AC // =_02134448
	ldrh r6, [sp, #0x54]
	str r1, [sp, #0x10]
	mov r1, r9, lsl #5
	str r1, [sp, #0xc]
	mov r1, r2, asr #3
	ldrh r7, [r4, #0]
	str r1, [sp, #0x14]
	and r1, r2, #4
	str r1, [sp, #0x18]
	mov r1, r6, asr #3
	str r1, [sp, #0x1c]
	and r1, r6, #4
	mov r8, r2, lsl #0x1e
	mov r5, r6, lsl #0x1e
	tst r7, #1
	str r1, [sp, #0x20]
	ldreqh r1, [r4, #2]
	mov r11, r8, lsr #0x1c
	mov r6, r5, lsr #0x1c
	cmpeq r1, #0
	bne _0204E848
	ldrh r7, [sp, #0x48]
	mov r1, #0
	cmp r7, #0
	addle sp, sp, #0x24
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r4, #0xff
	mvn r5, r4, lsl r6
	ldrh r2, [sp, #0x58]
	ldr r4, [sp, #0x4c]
_0204E7C0:
	mov r8, r3, lsl #0x1d
	mov r9, r8, lsr #0x1b
	ldr r8, [sp, #0x18]
	mov r10, r3, asr #3
	add r8, r9, r8, asr #1
	ldr r9, [sp, #0x10]
	add r1, r1, #1
	mul r10, r9, r10
	ldr r9, [sp, #0x14]
	ldr ip, [sp, #0xc]
	add r9, r10, r9, lsl #5
	add r8, r8, r9
	ldrh r10, [r0, r8]
	mov r8, r2, lsl #0x1d
	mov r9, r8, lsr #0x1b
	mov r8, r10, asr r11
	and r10, r8, #0xff
	ldr r8, [sp, #0x20]
	add r3, r3, #1
	add r9, r9, r8, asr #1
	mov r8, r2, asr #3
	mul r8, ip, r8
	ldr ip, [sp, #0x1c]
	add r2, r2, #1
	add r8, r8, ip, lsl #5
	add r8, r9, r8
	ldrh r9, [r4, r8]
	cmp r1, r7
	and r9, r9, r5
	orr r9, r9, r10, lsl r6
	strh r9, [r4, r8]
	blt _0204E7C0
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204E848:
	ldrh r1, [sp, #0x48]
	str r1, [sp, #4]
	mov r1, #0
	str r1, [sp]
	ldr r1, [sp, #4]
	cmp r1, #0
	addle sp, sp, #0x24
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r1, #0xff
	mvn r1, r1, lsl r6
	ldrh r7, [sp, #0x58]
	ldr r8, [sp, #0x4c]
	str r1, [sp, #8]
_0204E87C:
	mov r1, r3, lsl #0x1d
	mov r2, r1, lsr #0x1b
	ldr r1, [sp, #0x18]
	mov r5, #0
	add r4, r2, r1, asr #1
	ldr r1, [sp, #0x10]
	mov r2, r3, asr #3
	mul r2, r1, r2
	ldr r1, [sp, #0x14]
	add r1, r2, r1, lsl #5
	add r1, r4, r1
	ldrh r4, [r0, r1]
	mov r1, r7, lsl #0x1d
	mov r2, r1, lsr #0x1b
	mov r1, r4, asr r11
	and r10, r1, #0xff
	ldr r1, [sp, #0x20]
	add r4, r2, r1, asr #1
	ldr r1, [sp, #0xc]
	mov r2, r7, asr #3
	mul r2, r1, r2
	ldr r1, [sp, #0x1c]
	add r1, r2, r1, lsl #5
	add r4, r4, r1
	ldr r1, _0204E9AC // =_02134448
	ldrh r2, [r1, #0]
	tst r2, #1
	beq _0204E944
	ldrh r9, [r1, #2]
	ldrh r1, [r8, r4]
	mov lr, #0xf
	mov r1, r1, asr r6
	and r1, r1, #0xff
	mov r1, r1, lsl #0x10
_0204E904:
	mov r2, lr, lsl r5
	mov r2, r2, lsl #0x10
	tst r10, r2, lsr #16
	mov ip, r2, lsr #0x10
	addne r2, r10, r9, lsl r5
	bne _0204E92C
	mvn r2, ip
	and r2, r10, r2
	and r10, ip, r1, lsr #16
	orr r2, r2, r10
_0204E92C:
	mov r2, r2, lsl #0x10
	add r5, r5, #4
	mov r10, r2, lsr #0x10
	cmp r5, #8
	blt _0204E904
	b _0204E970
_0204E944:
	ldrh r2, [r1, #2]
	mov r1, #0xf
_0204E94C:
	mov r9, r1, lsl r5
	mov r9, r9, lsl #0x10
	tst r10, r9, lsr #16
	addne r9, r10, r2, lsl r5
	movne r9, r9, lsl #0x10
	add r5, r5, #4
	movne r10, r9, lsr #0x10
	cmp r5, #8
	blt _0204E94C
_0204E970:
	ldrh r2, [r8, r4]
	ldr r1, [sp, #8]
	add r3, r3, #1
	and r1, r2, r1
	orr r1, r1, r10, lsl r6
	strh r1, [r8, r4]
	ldr r1, [sp]
	add r7, r7, #1
	add r2, r1, #1
	ldr r1, [sp, #4]
	str r2, [sp]
	cmp r2, r1
	blt _0204E87C
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0204E9AC: .word _02134448
	arm_func_end BackgroundUnknown__Func_204E734

	arm_func_start BackgroundUnknown__Func_204E9B0
BackgroundUnknown__Func_204E9B0: // 0x0204E9B0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	ldrh r8, [sp, #0x48]
	ldrh r4, [sp, #0x40]
	mov r1, r1, lsl #5
	str r1, [sp, #8]
	mov r1, r8, lsl #5
	str r4, [sp]
	ldrh r5, [sp, #0x4c]
	str r1, [sp, #4]
	mov r1, r2, asr #3
	ldr r6, [sp]
	str r1, [sp, #0xc]
	mov r1, r5, asr #3
	mov r4, r5, lsl #0x1e
	str r1, [sp, #0x10]
	and r1, r5, #4
	mov r7, r2, lsl #0x1e
	cmp r6, #0
	str r1, [sp, #0x14]
	and r11, r2, #4
	mov r4, r4, lsr #0x1c
	addle sp, sp, #0x18
	mov lr, r7, lsr #0x1c
	mov ip, #0
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r1, #0xf
	ldrh r5, [sp, #0x50]
	mvn r7, r1, lsl r4
	ldr r6, [sp, #0x44]
_0204EA28:
	ldr r2, [sp, #8]
	mov r8, r3, asr #3
	mul r8, r2, r8
	mov r1, r3, lsl #0x1d
	ldr r2, [sp, #0xc]
	mov r1, r1, lsr #0x1b
	add r1, r1, r11, asr #1
	add r2, r8, r2, lsl #5
	add r1, r1, r2
	ldrh r8, [r0, r1]
	mov r1, r5, lsl #0x1d
	mov r2, r1, lsr #0x1b
	mov r1, r8, asr lr
	and r1, r1, #0xf
	mov r1, r1, lsl #0x10
	movs r9, r1, lsr #0x10
	ldr r1, [sp, #0x14]
	ldr r8, [sp, #4]
	add r2, r2, r1, asr #1
	mov r1, r5, asr #3
	mul r1, r8, r1
	ldr r8, [sp, #0x10]
	add r1, r1, r8, lsl #5
	add r2, r2, r1
	ldrh r8, [r6, r2]
	mov r1, r8, asr r4
	and r1, r1, #0xf
	beq _0204EAB0
	ldr r1, _0204EB04 // =_02134448
	ldrh r1, [r1, #2]
	add r1, r9, r1
	mov r1, r1, lsl #0x10
	mov r9, r1, lsr #0x10
	b _0204EAD8
_0204EAB0:
	ldr r10, _0204EB04 // =_02134448
	ldrh r10, [r10, #0]
	tst r10, #1
	beq _0204EAD8
	and r10, r1, #0xf
	ldr r1, _0204EB08 // =0x0000FFF0
	and r1, r9, r1
	orr r1, r1, r10
	mov r1, r1, lsl #0x10
	mov r9, r1, lsr #0x10
_0204EAD8:
	and r1, r8, r7
	orr r1, r1, r9, lsl r4
	strh r1, [r6, r2]
	ldr r1, [sp]
	add ip, ip, #1
	add r3, r3, #1
	add r5, r5, #1
	cmp ip, r1
	blt _0204EA28
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0204EB04: .word _02134448
_0204EB08: .word 0x0000FFF0
	arm_func_end BackgroundUnknown__Func_204E9B0

	arm_func_start BackgroundUnknown__Func_204EB0C
BackgroundUnknown__Func_204EB0C: // 0x0204EB0C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x28
	ldr r5, [sp, #0x60]
	mov r10, r2
	str r2, [sp, #0x20]
	ldrh r7, [sp, #0x68]
	ldr r9, [sp, #0x50]
	and r11, r10, #7
	and r10, r5, #7
	cmp r11, r10
	ldr r8, [sp, #0x54]
	ldr r6, [sp, #0x5c]
	ldr r4, [sp, #0x64]
	ldr ip, _0204EDC4 // =_02134448
	str r0, [sp, #0x18]
	strh r7, [ip, #2]
	str r1, [sp, #0x1c]
	mov r10, r3
	ldr r7, [sp, #0x58]
	bne _0204EDA0
	cmp r11, #0
	ble _0204EBC8
	rsb r11, r11, #8
	str r11, [sp, #0x24]
	mov r11, r11, lsl #0x10
	mov r11, r11, lsr #0x10
	str r11, [sp]
	str r8, [sp, #4]
	str r7, [sp, #8]
	str r6, [sp, #0xc]
	str r5, [sp, #0x10]
	str r4, [sp, #0x14]
	bl BackgroundUnknown__Func_204EF34
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x20]
	sub r2, r9, r0
	add r3, r1, r0
	add r1, r5, r0
	mov r0, r3, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x20]
	movs r9, r2, lsr #0x10
	mov r5, r1, lsr #0x10
	addeq sp, sp, #0x28
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204EBC8:
	and r11, r9, #7
	cmp r11, #0
	ble _0204EC3C
	mov r0, r11, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp]
	add r0, r5, r9
	str r8, [sp, #4]
	sub r2, r0, r11
	ldr r0, [sp, #0x20]
	mov r3, r10
	add r1, r0, r9
	str r7, [sp, #8]
	mov r0, r2, lsl #0x10
	sub r1, r1, r11
	mov r2, r1, lsl #0x10
	str r6, [sp, #0xc]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x18]
	mov r2, r2, lsr #0x10
	str r4, [sp, #0x14]
	bl BackgroundUnknown__Func_204EF34
	sub r0, r9, r11
	mov r0, r0, lsl #0x10
	movs r9, r0, lsr #0x10
	addeq sp, sp, #0x28
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204EC3C:
	ldr r0, _0204EDC4 // =_02134448
	ldrh r1, [r0, #0]
	tst r1, #1
	ldreqh r0, [r0, #2]
	cmpeq r0, #0
	andeq r1, r10, #7
	andeq r0, r4, #7
	cmpeq r1, r0
	bne _0204ED6C
	cmp r1, #0
	ble _0204ECC8
	rsb r11, r1, #8
	mov r0, r11, lsl #0x10
	str r9, [sp]
	mov r0, r0, lsr #0x10
	stmib sp, {r0, r7}
	str r6, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r0, [sp, #0x18]
	ldr r1, [sp, #0x1c]
	ldr r2, [sp, #0x20]
	mov r3, r10
	str r4, [sp, #0x14]
	bl BackgroundUnknown__Func_204EEA4
	add r0, r10, r11
	add r1, r4, r11
	sub r2, r8, r11
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	movs r8, r2, lsr #0x10
	mov r10, r0, lsr #0x10
	mov r4, r1, lsr #0x10
	addeq sp, sp, #0x28
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204ECC8:
	and r11, r8, #7
	cmp r11, #0
	ble _0204ED38
	mov r0, r11, lsl #0x10
	str r9, [sp]
	mov r0, r0, lsr #0x10
	str r0, [sp, #4]
	add r1, r4, r8
	str r7, [sp, #8]
	sub r1, r1, r11
	add r0, r10, r8
	str r6, [sp, #0xc]
	mov r1, r1, lsl #0x10
	sub r0, r0, r11
	mov r2, r0, lsl #0x10
	mov r1, r1, lsr #0x10
	str r5, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r3, r2, lsr #0x10
	ldr r0, [sp, #0x18]
	ldr r1, [sp, #0x1c]
	ldr r2, [sp, #0x20]
	bl BackgroundUnknown__Func_204EEA4
	sub r0, r8, r11
	mov r0, r0, lsl #0x10
	movs r8, r0, lsr #0x10
	addeq sp, sp, #0x28
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204ED38:
	str r9, [sp]
	str r8, [sp, #4]
	str r7, [sp, #8]
	str r6, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r0, [sp, #0x18]
	ldr r1, [sp, #0x1c]
	ldr r2, [sp, #0x20]
	mov r3, r10
	str r4, [sp, #0x14]
	bl BackgroundUnknown__Func_204EDC8
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204ED6C:
	str r9, [sp]
	str r8, [sp, #4]
	str r7, [sp, #8]
	str r6, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r0, [sp, #0x18]
	ldr r1, [sp, #0x1c]
	ldr r2, [sp, #0x20]
	mov r3, r10
	str r4, [sp, #0x14]
	bl BackgroundUnknown__Func_204EEA4
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204EDA0:
	str r9, [sp]
	str r8, [sp, #4]
	str r7, [sp, #8]
	str r6, [sp, #0xc]
	str r5, [sp, #0x10]
	str r4, [sp, #0x14]
	bl BackgroundUnknown__Func_204EF34
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0204EDC4: .word _02134448
	arm_func_end BackgroundUnknown__Func_204EB0C

	arm_func_start BackgroundUnknown__Func_204EDC8
BackgroundUnknown__Func_204EDC8: // 0x0204EDC8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	ldrh r4, [sp, #0x34]
	ldrh r6, [sp, #0x40]
	mov r10, r3
	mov r4, r4, asr #3
	strh r4, [sp, #0x34]
	ldrh r4, [sp, #0x3c]
	ldrh r7, [sp, #0x34]
	mov r9, r6, asr #3
	ldrh r5, [sp, #0x30]
	mov r9, r9, lsl #6
	mov r3, r10, lsl #0xd
	mov r6, r5, asr #3
	ldr r8, [sp, #0x44]
	mov r6, r6, lsl #6
	mov r5, r8, lsl #0xd
	strh r9, [sp, #0x40]
	mov r8, r5, lsr #0x10
	mov r2, r2, asr #3
	str r0, [sp]
	mov r0, r2, lsl #0x16
	ldr r9, [sp, #0x38]
	strh r6, [sp, #0x30]
	cmp r7, #0
	str r0, [sp, #8]
	mov r11, r1, lsl #6
	mov r4, r4, lsl #6
	mov r10, r3, lsr #0x10
	mov r5, #0
	addle sp, sp, #0xc
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r0, [sp, #0x30]
	ldrh r6, [sp, #0x40]
	str r0, [sp, #4]
_0204EE54:
	mul r2, r11, r10
	mla r1, r4, r8, r6
	ldr r0, [sp, #8]
	add r1, r9, r1
	add r3, r2, r0, lsr #16
	ldr r0, [sp]
	ldr r2, [sp, #4]
	add r0, r0, r3
	bl MIi_CpuCopyFast
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	add r5, r5, #1
	add r1, r8, #1
	mov r10, r0, lsr #0x10
	mov r0, r1, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r5, r7
	blt _0204EE54
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end BackgroundUnknown__Func_204EDC8

	arm_func_start BackgroundUnknown__Func_204EEA4
BackgroundUnknown__Func_204EEA4: // 0x0204EEA4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	ldrh r6, [sp, #0x48]
	str r1, [sp, #0x18]
	str r3, [sp, #0x1c]
	ldr r9, [sp, #0x4c]
	ldr r8, [sp, #0x50]
	ldr r7, [sp, #0x54]
	ldr r11, [sp, #0x5c]
	str r0, [sp, #0x14]
	cmp r6, #0
	mov r10, r2
	mov r4, #0
	addle sp, sp, #0x20
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r5, [sp, #0x58]
_0204EEE4:
	str r9, [sp]
	str r8, [sp, #4]
	mov r0, r5, lsl #0x10
	str r7, [sp, #8]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	ldr r1, [sp, #0x18]
	mov r2, r10, lsl #0x10
	str r11, [sp, #0x10]
	ldr r0, [sp, #0x14]
	ldr r3, [sp, #0x1c]
	mov r2, r2, lsr #0x10
	bl BackgroundUnknown__Func_204F3FC
	add r4, r4, #8
	cmp r4, r6
	add r5, r5, #8
	add r10, r10, #8
	blt _0204EEE4
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end BackgroundUnknown__Func_204EEA4

	arm_func_start BackgroundUnknown__Func_204EF34
BackgroundUnknown__Func_204EF34: // 0x0204EF34
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x5c
	mov r10, r0
	mov r0, r2
	ands r0, r0, #7
	moveq r0, #0
	streq r0, [sp, #0x20]
	rsbne r0, r0, #8
	str r2, [sp, #0x18]
	strne r0, [sp, #0x20]
	mov r9, r1
	ldrh r0, [sp, #0x80]
	ldr r1, [sp, #0x20]
	mov r11, r3
	ldr r8, [sp, #0x84]
	ldr r7, [sp, #0x88]
	ldr r6, [sp, #0x8c]
	ldr r5, [sp, #0x94]
	cmp r1, r0
	blt _0204EF94
	mov r1, #0
	str r0, [sp, #0x20]
	str r1, [sp, #0x4c]
	b _0204EFAC
_0204EF94:
	sub r1, r0, r1
	bic r2, r1, #7
	ldr r1, [sp, #0x20]
	add r1, r1, r2
	sub r1, r0, r1
	str r1, [sp, #0x4c]
_0204EFAC:
	ldrh r1, [sp, #0x90]
	ands r1, r1, #7
	moveq r1, #0
	streq r1, [sp, #0x1c]
	rsbne r1, r1, #8
	strne r1, [sp, #0x1c]
	ldr r1, [sp, #0x1c]
	cmp r1, r0
	blt _0204EFE8
	mov r1, #0
	str r0, [sp, #0x1c]
	mov r0, r1
	str r1, [sp, #0x48]
	str r0, [sp, #0x44]
	b _0204F004
_0204EFE8:
	sub r1, r0, r1
	bic r1, r1, #7
	ldr r2, [sp, #0x1c]
	str r1, [sp, #0x48]
	add r1, r2, r1
	sub r0, r0, r1
	str r0, [sp, #0x44]
_0204F004:
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x20]
	mov r4, #0
	cmp r1, r0
	bgt _0204F068
	ldrh r0, [sp, #0x90]
	mov r3, r11
	str r0, [sp, #0x28]
	mov r0, r1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	stmia sp, {r0, r8}
	str r7, [sp, #8]
	ldr r0, [sp, #0x28]
	str r6, [sp, #0xc]
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	ldr r2, [sp, #0x18]
	mov r0, r10
	mov r2, r2, lsl #0x10
	mov r1, r9
	mov r2, r2, lsr #0x10
	bl BackgroundUnknown__Func_204F6CC
	ldr r0, [sp, #0x1c]
	b _0204F11C
_0204F068:
	ldrh r0, [sp, #0x90]
	mov r1, r9
	mov r3, r11
	str r0, [sp, #0x28]
	ldr r0, [sp, #0x20]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	stmia sp, {r0, r8}
	str r7, [sp, #8]
	ldr r0, [sp, #0x28]
	str r6, [sp, #0xc]
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	ldr r2, [sp, #0x18]
	mov r0, r10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	bl BackgroundUnknown__Func_204F6CC
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x20]
	mov r3, r11
	sub r0, r1, r0
	str r0, [sp, #0x30]
	ldr r0, [sp, #0x20]
	mov r1, r9
	add r4, r4, r0
	ldr r0, [sp, #0x30]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	stmia sp, {r0, r8}
	ldr r0, [sp, #0x28]
	str r7, [sp, #8]
	add r0, r0, r4
	mov r0, r0, lsl #0x10
	str r6, [sp, #0xc]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	ldr r2, [sp, #0x18]
	mov r0, r10
	add r2, r2, r4
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	bl BackgroundUnknown__Func_204F6CC
	ldr r0, [sp, #0x30]
_0204F11C:
	add r4, r4, r0
	ldr r0, [sp, #0x20]
	cmp r0, r4
	subge r0, r0, r4
	strge r0, [sp, #0x3c]
	sublt r0, r4, r0
	rsblt r0, r0, #8
	strlt r0, [sp, #0x3c]
	ldr r0, [sp, #0x3c]
	cmp r0, #0
	bne _0204F1E8
	ldr r0, [sp, #0x48]
	cmp r0, #0
	mov r0, #0
	str r0, [sp, #0x50]
	ble _0204F2E0
	ldr r0, [sp, #0x28]
	add r0, r0, r4
	str r0, [sp, #0x38]
	ldr r0, [sp, #0x18]
	add r0, r0, r4
	str r0, [sp, #0x34]
_0204F174:
	ldr r0, [sp, #0x38]
	str r8, [sp]
	ldr r2, [sp, #0x34]
	str r7, [sp, #4]
	mov r0, r0, lsl #0x10
	mov r2, r2, lsl #0x10
	str r6, [sp, #8]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	mov r0, r10
	mov r1, r9
	mov r2, r2, lsr #0x10
	mov r3, r11
	str r5, [sp, #0x10]
	bl BackgroundUnknown__Func_204F3FC
	ldr r0, [sp, #0x38]
	add r4, r4, #8
	add r0, r0, #8
	str r0, [sp, #0x38]
	ldr r0, [sp, #0x34]
	add r0, r0, #8
	str r0, [sp, #0x34]
	ldr r0, [sp, #0x50]
	add r1, r0, #8
	ldr r0, [sp, #0x48]
	str r1, [sp, #0x50]
	cmp r1, r0
	blt _0204F174
	b _0204F2E0
_0204F1E8:
	ldr r0, [sp, #0x48]
	cmp r0, #0
	ldr r0, [sp, #0x3c]
	rsb r0, r0, #8
	str r0, [sp, #0x40]
	mov r0, #0
	str r0, [sp, #0x24]
	ble _0204F2E0
	ldr r0, [sp, #0x3c]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x54]
	ldr r0, [sp, #0x40]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x58]
_0204F228:
	ldr r0, [sp, #0x54]
	mov r1, r9
	stmia sp, {r0, r8}
	ldr r0, [sp, #0x28]
	str r7, [sp, #8]
	add r0, r0, r4
	mov r0, r0, lsl #0x10
	str r6, [sp, #0xc]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	ldr r2, [sp, #0x18]
	mov r0, r10
	add r2, r2, r4
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r11
	bl BackgroundUnknown__Func_204F6CC
	ldr r0, [sp, #0x58]
	mov r1, r9
	stmia sp, {r0, r8}
	ldr r0, [sp, #0x3c]
	str r7, [sp, #8]
	add r4, r4, r0
	ldr r0, [sp, #0x28]
	str r6, [sp, #0xc]
	add r0, r0, r4
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	ldr r2, [sp, #0x18]
	mov r0, r10
	add r2, r2, r4
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r11
	bl BackgroundUnknown__Func_204F6CC
	ldr r0, [sp, #0x40]
	add r4, r4, r0
	ldr r0, [sp, #0x24]
	add r1, r0, #8
	ldr r0, [sp, #0x48]
	str r1, [sp, #0x24]
	cmp r1, r0
	blt _0204F228
_0204F2E0:
	ldr r1, [sp, #0x44]
	ldr r0, [sp, #0x4c]
	cmp r1, r0
	bgt _0204F348
	mov r0, r1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	stmia sp, {r0, r8}
	ldr r0, [sp, #0x28]
	str r7, [sp, #8]
	add r0, r0, r4
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #0x18]
	mov r3, r11
	add r0, r0, r4
	mov r2, r0, lsl #0x10
	mov r0, r1, lsr #0x10
	str r6, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, r10
	mov r1, r9
	mov r2, r2, lsr #0x10
	str r5, [sp, #0x14]
	bl BackgroundUnknown__Func_204F6CC
	add sp, sp, #0x5c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204F348:
	sub r0, r1, r0
	str r0, [sp, #0x2c]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	stmia sp, {r0, r8}
	ldr r0, [sp, #0x28]
	str r7, [sp, #8]
	add r0, r0, r4
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #0x18]
	mov r1, r1, lsr #0x10
	add r0, r0, r4
	mov r0, r0, lsl #0x10
	str r6, [sp, #0xc]
	str r1, [sp, #0x10]
	mov r2, r0, lsr #0x10
	mov r0, r10
	mov r1, r9
	mov r3, r11
	str r5, [sp, #0x14]
	bl BackgroundUnknown__Func_204F6CC
	ldr r1, [sp, #0x4c]
	ldr r0, [sp, #0x2c]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	stmia sp, {r1, r8}
	ldr r1, [sp, #0x28]
	add r0, r4, r0
	add r1, r1, r0
	str r7, [sp, #8]
	mov r2, r1, lsl #0x10
	ldr r1, [sp, #0x18]
	mov r3, r11
	add r0, r1, r0
	mov r4, r0, lsl #0x10
	mov r0, r2, lsr #0x10
	str r6, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, r10
	mov r1, r9
	mov r2, r4, lsr #0x10
	str r5, [sp, #0x14]
	bl BackgroundUnknown__Func_204F6CC
	add sp, sp, #0x5c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end BackgroundUnknown__Func_204EF34

	arm_func_start BackgroundUnknown__Func_204F3FC
BackgroundUnknown__Func_204F3FC: // 0x0204F3FC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x28
	ldr r5, _0204F6C8 // =_02134448
	ldrh r7, [sp, #0x58]
	ldrh r4, [r5, #0]
	str r0, [sp]
	mov r0, r1, lsl #6
	str r0, [sp, #0x1c]
	mov r0, r7, lsl #6
	str r0, [sp, #0x18]
	mov r0, r2, asr #3
	ldrh r6, [sp, #0x5c]
	str r0, [sp, #0x20]
	str r3, [sp, #4]
	mov r0, r6, asr #3
	tst r4, #1
	str r0, [sp, #0x24]
	ldreqh r0, [r5, #2]
	cmpeq r0, #0
	bne _0204F4F0
	ldrh r8, [sp, #0x50]
	mov r4, #0
	cmp r8, #0
	addle sp, sp, #0x28
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r6, [sp, #0x60]
	ldr r7, [sp, #0x54]
_0204F468:
	ldr r0, [sp, #4]
	add r2, r6, r4
	add r0, r0, r4
	mov r3, r0, asr #3
	and r1, r0, #7
	ldr r0, [sp, #0x1c]
	mov r5, r2, asr #3
	mul r3, r0, r3
	ldr r0, [sp, #0x20]
	and r2, r2, #7
	add r0, r3, r0, lsl #6
	ldr r3, [sp, #0x18]
	add r0, r0, r1, lsl #3
	mul r5, r3, r5
	ldr r3, [sp, #0x24]
	rsb r1, r1, #8
	add r3, r5, r3, lsl #6
	sub r5, r8, r4
	cmp r1, r5
	movlt r5, r1
	rsb r1, r2, #8
	cmp r1, r5
	movlt r5, r1
	ldr r1, [sp]
	add r3, r3, r2, lsl #3
	add r0, r1, r0
	add r1, r7, r3
	mov r2, r5, lsl #3
	bl MIi_CpuCopy32
	add r4, r4, r5
	cmp r4, r8
	blt _0204F468
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204F4F0:
	ldrh r0, [sp, #0x50]
	mov r1, #0
	str r0, [sp, #8]
	cmp r0, #0
	addle sp, sp, #0x28
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r0, [sp, #0x60]
	ldr r2, _0204F6C8 // =_02134448
	str r0, [sp, #0x14]
	ldrh r0, [r2, #2]
	ldr r2, [sp, #0x54]
	str r2, [sp, #0x10]
	and r2, r4, #1
	str r2, [sp, #0xc]
_0204F528:
	ldr r2, [sp, #4]
	add r4, r2, r1
	ldr r2, [sp, #0x14]
	and r5, r4, #7
	add r3, r2, r1
	ldr r2, [sp, #0x1c]
	mov r4, r4, asr #3
	mul r4, r2, r4
	ldr r2, [sp, #0x20]
	rsb r6, r5, #8
	add r2, r4, r2, lsl #6
	add r4, r2, r5, lsl #3
	ldr r2, [sp]
	mov r5, r3, asr #3
	add r2, r2, r4
	and r4, r3, #7
	ldr r3, [sp, #0x18]
	mul r5, r3, r5
	ldr r3, [sp, #0x24]
	add r3, r5, r3, lsl #6
	add r5, r3, r4, lsl #3
	ldr r3, [sp, #0x10]
	rsb r4, r4, #8
	add r3, r3, r5
	ldr r5, [sp, #8]
	sub ip, r5, r1
	cmp r6, ip
	movlt ip, r6
	cmp r4, ip
	movlt ip, r4
	ldr r4, [sp, #0xc]
	mov ip, ip, lsl #1
	cmp r4, #0
	beq _0204F640
	cmp ip, #0
	mov r7, #0
	ble _0204F6B0
	mov r5, #0xff
	mov r4, r5
	mov r11, r7
	mov r6, r7
_0204F5CC:
	ldr r9, [r2, r7, lsl #2]
	ldr r10, [r3, r7, lsl #2]
	mov r8, r6
_0204F5D8:
	tst r9, r5, lsl r8
	addne r9, r9, r0, lsl r8
	andeq lr, r10, r5, lsl r8
	add r8, r8, #8
	orreq r9, r9, lr
	cmp r8, #0x20
	blt _0204F5D8
	str r9, [r3, r7, lsl #2]
	add r8, r2, r7, lsl #2
	add r9, r3, r7, lsl #2
	ldr r8, [r8, #4]
	ldr r9, [r9, #4]
	mov r10, r11
_0204F60C:
	tst r8, r4, lsl r10
	addne r8, r8, r0, lsl r10
	andeq lr, r9, r4, lsl r10
	add r10, r10, #8
	orreq r8, r8, lr
	cmp r10, #0x20
	blt _0204F60C
	add r9, r3, r7, lsl #2
	str r8, [r9, #4]
	add r7, r7, #2
	cmp r7, ip
	blt _0204F5CC
	b _0204F6B0
_0204F640:
	cmp ip, #0
	mov r9, #0
	ble _0204F6B0
	mov r7, #0xff
	mov r5, r7
	mov r6, r9
	mov r8, r9
_0204F65C:
	ldr r4, [r2, r9, lsl #2]
	mov r10, r8
_0204F664:
	tst r4, r7, lsl r10
	addne r4, r4, r0, lsl r10
	add r10, r10, #8
	cmp r10, #0x20
	blt _0204F664
	str r4, [r3, r9, lsl #2]
	add r4, r2, r9, lsl #2
	ldr r10, [r4, #4]
	mov r4, r6
_0204F688:
	tst r10, r5, lsl r4
	addne r10, r10, r0, lsl r4
	add r4, r4, #8
	cmp r4, #0x20
	blt _0204F688
	add r4, r3, r9, lsl #2
	str r10, [r4, #4]
	add r9, r9, #2
	cmp r9, ip
	blt _0204F65C
_0204F6B0:
	ldr r2, [sp, #8]
	add r1, r1, ip, asr #1
	cmp r1, r2
	blt _0204F528
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0204F6C8: .word _02134448
	arm_func_end BackgroundUnknown__Func_204F3FC

	arm_func_start BackgroundUnknown__Func_204F6CC
BackgroundUnknown__Func_204F6CC: // 0x0204F6CC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x38
	ldrh r7, [sp, #0x60]
	cmp r7, #8
	bne _0204F714
	ldrh r6, [sp, #0x64]
	ldr r5, [sp, #0x68]
	ldrh r4, [sp, #0x6c]
	str r6, [sp]
	str r5, [sp, #4]
	str r4, [sp, #8]
	ldrh r5, [sp, #0x70]
	ldrh r4, [sp, #0x74]
	str r5, [sp, #0xc]
	str r4, [sp, #0x10]
	bl BackgroundUnknown__Func_204F3FC
	add sp, sp, #0x38
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204F714:
	ldr r4, _0204F960 // =_02134448
	ldrh r5, [sp, #0x6c]
	ldrh r9, [r4, #0]
	ldrh r6, [sp, #0x70]
	mov lr, r5, lsl #6
	tst r9, #1
	mov r11, r2, asr #3
	and r5, r2, #7
	ldreqh r2, [r4, #2]
	mov ip, r1, lsl #6
	mov r1, r6, asr #3
	str r1, [sp, #0x24]
	and r1, r6, #7
	cmpeq r2, #0
	bne _0204F828
	ldrh r8, [sp, #0x64]
	mov r2, #0
	cmp r8, #0
	addle sp, sp, #0x38
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r9, sp, #0x30
	add r5, r9, r5
	ldr r9, [sp, #0x68]
	add r6, sp, #0x28
	ldrh r4, [sp, #0x74]
	str r9, [sp, #0x18]
	add r6, r6, r1
_0204F780:
	mov r1, r3, asr #3
	mul r1, ip, r1
	add r1, r1, r11, lsl #6
	mov r9, r3, lsl #0x1d
	add r1, r1, r9, lsr #26
	ldr r9, [r0, r1]
	add r10, r0, r1
	str r9, [sp, #0x30]
	ldr r10, [r10, #4]
	mov r9, r4, asr #3
	str r10, [sp, #0x34]
	mul r10, lr, r9
	ldr r9, [sp, #0x24]
	mov r1, r4, lsl #0x1d
	add r9, r10, r9, lsl #6
	add r10, r9, r1, lsr #26
	ldr r1, [sp, #0x18]
	ldr r9, [sp, #0x18]
	add r1, r1, r10
	ldr r10, [r9, r10]
	ldr r9, [r1, #4]
	str r10, [sp, #0x28]
	cmp r7, #0
	str r9, [sp, #0x2c]
	mov r10, #0
	ble _0204F7FC
_0204F7E8:
	ldrb r9, [r5, r10]
	strb r9, [r6, r10]
	add r10, r10, #1
	cmp r10, r7
	blt _0204F7E8
_0204F7FC:
	ldr r10, [sp, #0x28]
	ldr r9, [sp, #0x2c]
	str r10, [r1]
	str r9, [r1, #4]
	add r2, r2, #1
	cmp r2, r8
	add r3, r3, #1
	add r4, r4, #1
	blt _0204F780
	add sp, sp, #0x38
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204F828:
	ldrh r2, [sp, #0x64]
	mov r8, #0
	str r2, [sp, #0x14]
	cmp r2, #0
	addle sp, sp, #0x38
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r6, sp, #0x28
	add r2, sp, #0x30
	add r6, r6, r1
	and r1, r9, #1
	add r4, r2, r5
	ldr r7, _0204F960 // =_02134448
	str r1, [sp, #0x1c]
	ldrh r5, [r7, #2]
	ldr r1, [sp, #0x68]
	ldrh r2, [sp, #0x74]
	ldrh r7, [sp, #0x60]
	str r1, [sp, #0x20]
_0204F870:
	mov r9, r3, asr #3
	mul r9, ip, r9
	ldr r1, [sp, #0x1c]
	add r9, r9, r11, lsl #6
	cmp r1, #0
	mov r1, r3, lsl #0x1d
	add r1, r9, r1, lsr #26
	ldr r9, [r0, r1]
	add r10, r0, r1
	str r9, [sp, #0x30]
	ldr r10, [r10, #4]
	mov r9, r2, asr #3
	str r10, [sp, #0x34]
	mul r10, lr, r9
	ldr r9, [sp, #0x24]
	mov r1, r2, lsl #0x1d
	add r9, r10, r9, lsl #6
	add r10, r9, r1, lsr #26
	ldr r1, [sp, #0x20]
	ldr r9, [sp, #0x20]
	add r1, r1, r10
	ldr r10, [r9, r10]
	ldr r9, [r1, #4]
	str r10, [sp, #0x28]
	str r9, [sp, #0x2c]
	beq _0204F904
	cmp r7, #0
	mov r9, #0
	ble _0204F930
_0204F8E4:
	ldrb r10, [r4, r9]
	cmp r10, #0
	addne r10, r10, r5
	strneb r10, [r6, r9]
	add r9, r9, #1
	cmp r9, r7
	blt _0204F8E4
	b _0204F930
_0204F904:
	cmp r7, #0
	mov r10, #0
	ble _0204F930
_0204F910:
	ldrb r9, [r4, r10]
	cmp r9, #0
	addne r9, r9, r5
	andne r9, r9, #0xff
	strb r9, [r6, r10]
	add r10, r10, #1
	cmp r10, r7
	blt _0204F910
_0204F930:
	ldr r10, [sp, #0x28]
	ldr r9, [sp, #0x2c]
	str r10, [r1]
	str r9, [r1, #4]
	ldr r1, [sp, #0x14]
	add r8, r8, #1
	add r3, r3, #1
	add r2, r2, #1
	cmp r8, r1
	blt _0204F870
	add sp, sp, #0x38
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0204F960: .word _02134448
	arm_func_end BackgroundUnknown__Func_204F6CC

	arm_func_start BackgroundUnknown__Func_204F964
BackgroundUnknown__Func_204F964: // 0x0204F964
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	and r4, r2, #7
	mov r4, r4, lsl #0x10
	movs r7, r4, lsr #0x10
	str r0, [sp]
	rsbne r0, r7, #8
	movne r0, r0, lsl #0x10
	movne r7, r0, lsr #0x10
	and r0, r3, #7
	mov r0, r0, lsl #0x10
	movs r11, r0, lsr #0x10
	rsbne r0, r11, #8
	movne r0, r0, lsl #0x10
	movne r11, r0, lsr #0x10
	ldrh r8, [sp, #0x48]
	ldrh r0, [sp, #0x4c]
	mov r4, r2, lsl #0xd
	add r6, r2, r8
	add r5, r3, r0
	and r9, r5, #7
	and r2, r6, #7
	str r2, [sp, #4]
	mov r2, r2, lsl #0x10
	add r2, r7, r2, lsr #16
	sub r8, r8, r2
	mov r10, r9, lsl #0x10
	add r2, r11, r10, lsr #16
	sub r0, r0, r2
	mov r8, r8, lsl #0xd
	mov r2, r3, lsl #0xd
	mov r0, r0, lsl #0xd
	mov r10, r8, lsr #0x10
	mov r8, r0, lsr #0x10
	mov r0, r4, lsr #0x10
	str r0, [sp, #0x18]
	mov r0, r2, lsr #0x10
	mov r3, r6, lsl #0xd
	str r0, [sp, #0x14]
	mov r0, r3, lsr #0x10
	mov r5, r5, lsl #0xd
	str r0, [sp, #0x10]
	mov r0, r5, lsr #0x10
	cmp r11, #0
	str r0, [sp, #0xc]
	mov r5, r1, lsl #5
	beq _0204FB24
	ldr r1, [sp, #0x14]
	ldr r0, [sp]
	cmp r7, #0
	mla r1, r5, r1, r0
	ldr r0, [sp, #0x18]
	add r4, r1, r0, lsl #5
	beq _0204FA8C
	rsb r0, r7, #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	rsb r0, r0, #8
	mov r2, r0, lsl #2
	rsb r0, r11, #8
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #8
	mvn r3, #0
	bhs _0204FA88
_0204FA68:
	ldr r1, [r4, r6, lsl #2]
	add r0, r6, #1
	and r1, r1, r3, lsr r2
	str r1, [r4, r6, lsl #2]
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #8
	blo _0204FA68
_0204FA88:
	add r4, r4, #0x20
_0204FA8C:
	cmp r10, #0
	mov r6, #0
	ble _0204FAD8
	rsb r0, r11, #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x1c]
	rsb r0, r0, #8
	mov r0, r0, lsl #2
	str r0, [sp, #8]
_0204FAB4:
	ldr r1, [sp, #0x1c]
	ldr r2, [sp, #8]
	mov r0, #0
	add r1, r4, r1, lsl #2
	bl MIi_CpuClear32
	add r6, r6, #1
	add r4, r4, #0x20
	cmp r6, r10
	blt _0204FAB4
_0204FAD8:
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _0204FB24
	rsb r0, r11, #8
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	ldr r0, [sp, #4]
	cmp r2, #8
	mvn r1, #0
	mov r0, r0, lsl #2
	bhs _0204FB24
_0204FB04:
	ldr r6, [r4, r2, lsl #2]
	add r3, r2, #1
	and r6, r6, r1, lsl r0
	str r6, [r4, r2, lsl #2]
	mov r2, r3, lsl #0x10
	mov r2, r2, lsr #0x10
	cmp r2, #8
	blo _0204FB04
_0204FB24:
	cmp r8, #0
	beq _0204FCA4
	cmp r7, #0
	beq _0204FBEC
	ldr r1, [sp, #0x14]
	ldr r0, [sp]
	cmp r11, #0
	mla r1, r5, r1, r0
	ldr r0, [sp, #0x18]
	mov r3, #0
	add r2, r1, r0, lsl #5
	addne r2, r2, r5
	cmp r8, #0
	ble _0204FBEC
	cmp r8, #0
	sub r1, r3, #1
	rsb r0, r7, #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	rsb r0, r0, #8
	mov r0, r0, lsl #2
	ble _0204FBEC
_0204FB7C:
	ldr r4, [r2, #0]
	add r3, r3, #1
	and r4, r4, r1, lsr r0
	str r4, [r2]
	cmp r3, r8
	ldr r4, [r2, #4]
	and r4, r4, r1, lsr r0
	str r4, [r2, #4]
	ldr r4, [r2, #8]
	and r4, r4, r1, lsr r0
	str r4, [r2, #8]
	ldr r4, [r2, #0xc]
	and r4, r4, r1, lsr r0
	str r4, [r2, #0xc]
	ldr r4, [r2, #0x10]
	and r4, r4, r1, lsr r0
	str r4, [r2, #0x10]
	ldr r4, [r2, #0x14]
	and r4, r4, r1, lsr r0
	str r4, [r2, #0x14]
	ldr r4, [r2, #0x18]
	and r4, r4, r1, lsr r0
	str r4, [r2, #0x18]
	ldr r4, [r2, #0x1c]
	and r4, r4, r1, lsr r0
	str r4, [r2, #0x1c]
	add r2, r2, r5
	blt _0204FB7C
_0204FBEC:
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _0204FCA4
	ldr r1, [sp, #0x14]
	ldr r0, [sp]
	cmp r11, #0
	mla r1, r5, r1, r0
	ldr r0, [sp, #0x10]
	mov r3, #0
	add r2, r1, r0, lsl #5
	addne r2, r2, r5
	cmp r8, #0
	ble _0204FCA4
	ldr r0, [sp, #4]
	cmp r8, #0
	sub r1, r3, #1
	mov r0, r0, lsl #2
	ble _0204FCA4
_0204FC34:
	ldr r4, [r2, #0]
	add r3, r3, #1
	and r4, r4, r1, lsl r0
	str r4, [r2]
	cmp r3, r8
	ldr r4, [r2, #4]
	and r4, r4, r1, lsl r0
	str r4, [r2, #4]
	ldr r4, [r2, #8]
	and r4, r4, r1, lsl r0
	str r4, [r2, #8]
	ldr r4, [r2, #0xc]
	and r4, r4, r1, lsl r0
	str r4, [r2, #0xc]
	ldr r4, [r2, #0x10]
	and r4, r4, r1, lsl r0
	str r4, [r2, #0x10]
	ldr r4, [r2, #0x14]
	and r4, r4, r1, lsl r0
	str r4, [r2, #0x14]
	ldr r4, [r2, #0x18]
	and r4, r4, r1, lsl r0
	str r4, [r2, #0x18]
	ldr r4, [r2, #0x1c]
	and r4, r4, r1, lsl r0
	str r4, [r2, #0x1c]
	add r2, r2, r5
	blt _0204FC34
_0204FCA4:
	cmp r9, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp, #0xc]
	ldr r0, [sp]
	cmp r7, #0
	mla r1, r5, r1, r0
	ldr r0, [sp, #0x18]
	add r4, r1, r0, lsl #5
	beq _0204FD14
	rsb r0, r7, #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	rsb r0, r0, #8
	cmp r9, #0
	mov r2, r0, lsl #2
	mvn r3, #0
	mov r5, #0
	bls _0204FD10
_0204FCF0:
	ldr r1, [r4, r5, lsl #2]
	add r0, r5, #1
	and r1, r1, r3, lsr r2
	mov r0, r0, lsl #0x10
	str r1, [r4, r5, lsl #2]
	cmp r9, r0, lsr #16
	mov r5, r0, lsr #0x10
	bhi _0204FCF0
_0204FD10:
	add r4, r4, #0x20
_0204FD14:
	cmp r10, #0
	mov r7, #0
	ble _0204FD48
	mov r6, r9, lsl #2
	mov r5, r7
_0204FD28:
	mov r0, r5
	mov r1, r4
	mov r2, r6
	bl MIi_CpuClear32
	add r7, r7, #1
	cmp r7, r10
	add r4, r4, #0x20
	blt _0204FD28
_0204FD48:
	ldr r0, [sp, #4]
	cmp r0, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r9, #0
	mvn r3, #0
	mov r5, #0
	addls sp, sp, #0x20
	mov r2, r0, lsl #2
	ldmlsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204FD70:
	ldr r1, [r4, r5, lsl #2]
	add r0, r5, #1
	and r1, r1, r3, lsl r2
	mov r0, r0, lsl #0x10
	str r1, [r4, r5, lsl #2]
	cmp r9, r0, lsr #16
	mov r5, r0, lsr #0x10
	bhi _0204FD70
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end BackgroundUnknown__Func_204F964

	arm_func_start BackgroundUnknown__Func_204FD98
BackgroundUnknown__Func_204FD98: // 0x0204FD98
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	and r4, r3, #7
	ldrh r8, [sp, #0x34]
	mov r4, r4, lsl #0x10
	movs r4, r4, lsr #0x10
	rsbne r4, r4, #8
	add r7, r3, r8
	movne r4, r4, lsl #0x10
	mov r5, r3, lsl #0xd
	movne r4, r4, lsr #0x10
	mov r6, r5, lsr #0x10
	mov ip, r1, lsl #5
	and r11, r7, #7
	mov r1, r11, lsl #0x10
	add r1, r4, r1, lsr #16
	sub r3, r8, r1
	mov r1, r2, lsl #0xd
	mov r1, r1, lsr #0x10
	mla r6, ip, r6, r0
	mov r5, r7, lsl #0xd
	str r1, [sp, #4]
	mov r1, r5, lsr #0x10
	str r1, [sp]
	ldr r1, [sp, #4]
	mov r3, r3, lsl #0xd
	cmp r4, #0
	mov r7, r3, lsr #0x10
	add r1, r6, r1, lsl #5
	beq _0204FE9C
	ldrh r6, [sp, #0x30]
	and r5, r2, #7
	mov r3, r5, lsl #0x10
	add r3, r6, r3, lsr #16
	rsb r8, r4, #8
	mov r6, r8, lsl #0x10
	mov r3, r3, lsl #0x10
	mov r8, r5, lsl #2
	mov r9, #0xf
	mov r8, r9, lsl r8
	cmp r5, r3, lsr #16
	mov r6, r6, lsr #0x10
	mvn r9, #0
	bhs _0204FE68
_0204FE48:
	mvn r10, r8
	and r9, r9, r10
	add r5, r5, #1
	mov r5, r5, lsl #0x10
	mov r5, r5, lsr #0x10
	cmp r5, r3, lsr #16
	mov r8, r8, lsl #4
	blo _0204FE48
_0204FE68:
	add r3, r6, r4
	mov r4, r3, lsl #0x10
	cmp r6, r4, lsr #16
	bhs _0204FE98
_0204FE78:
	ldr r5, [r1, r6, lsl #2]
	add r3, r6, #1
	and r5, r5, r9
	mov r3, r3, lsl #0x10
	str r5, [r1, r6, lsl #2]
	mov r6, r3, lsr #0x10
	cmp r6, r4, lsr #16
	blo _0204FE78
_0204FE98:
	add r1, r1, ip
_0204FE9C:
	cmp r7, #0
	beq _0204FF70
	cmp r7, #0
	mov r3, #0
	ble _0204FF70
	ldrh r6, [sp, #0x30]
	and r5, r2, #7
_0204FEB8:
	mov r4, r5, lsl #0x10
	mov lr, r4, lsr #0x10
	add r4, r6, r4, lsr #16
	mov r8, r4, lsl #0x10
	mov r9, lr, lsl #2
	cmp lr, r8, lsr #16
	mvn r4, #0
	mov r10, #0xf
	mov r10, r10, lsl r9
	bhs _0204FF00
_0204FEE0:
	mvn r9, r10
	and r4, r4, r9
	add r9, lr, #1
	mov r9, r9, lsl #0x10
	mov lr, r9, lsr #0x10
	cmp lr, r8, lsr #16
	mov r10, r10, lsl #4
	blo _0204FEE0
_0204FF00:
	ldr r8, [r1, #0]
	add r3, r3, #1
	and r8, r8, r4
	str r8, [r1]
	ldr r8, [r1, #4]
	cmp r3, r7
	and r8, r8, r4
	str r8, [r1, #4]
	ldr r8, [r1, #8]
	and r8, r8, r4
	str r8, [r1, #8]
	ldr r8, [r1, #0xc]
	and r8, r8, r4
	str r8, [r1, #0xc]
	ldr r8, [r1, #0x10]
	and r8, r8, r4
	str r8, [r1, #0x10]
	ldr r8, [r1, #0x14]
	and r8, r8, r4
	str r8, [r1, #0x14]
	ldr r8, [r1, #0x18]
	and r8, r8, r4
	str r8, [r1, #0x18]
	ldr r8, [r1, #0x1c]
	and r4, r8, r4
	str r4, [r1, #0x1c]
	add r1, r1, ip
	blt _0204FEB8
_0204FF70:
	cmp r11, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp]
	ldrh r3, [sp, #0x30]
	mla r7, ip, r1, r0
	and r0, r2, #7
	mov r2, r0, lsl #0x10
	add r2, r3, r2, lsr #16
	mov r4, r2, lsl #0x10
	ldr r2, [sp, #4]
	mov r1, #0
	add r3, r7, r2, lsl #5
	mov r5, r0, lsl #2
	mov r6, #0xf
	cmp r0, r4, lsr #16
	sub r2, r1, #1
	mov r6, r6, lsl r5
	bhs _0204FFDC
_0204FFBC:
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mvn r5, r6
	mov r0, r0, lsr #0x10
	cmp r0, r4, lsr #16
	and r2, r2, r5
	mov r6, r6, lsl #4
	blo _0204FFBC
_0204FFDC:
	mov r0, r11, lsl #0x10
	movs r5, r0, lsr #0x10
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204FFEC:
	ldr r4, [r3, r1, lsl #2]
	add r0, r1, #1
	and r4, r4, r2
	mov r0, r0, lsl #0x10
	str r4, [r3, r1, lsl #2]
	cmp r5, r0, lsr #16
	mov r1, r0, lsr #0x10
	bhi _0204FFEC
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end BackgroundUnknown__Func_204FD98

	arm_func_start BackgroundUnknown__Func_2050014
BackgroundUnknown__Func_2050014: // 0x02050014
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	and r4, r2, #7
	ldrh r6, [sp, #0x28]
	mov r4, r4, lsl #0x10
	mov r10, r3
	movs r3, r4, lsr #0x10
	rsbne r3, r3, #8
	mov r5, r1, lsl #5
	add r1, r2, r6
	movne r3, r3, lsl #0x10
	and r11, r1, #7
	movne r3, r3, lsr #0x10
	mov r4, r10, lsl #0xd
	mov r1, r11, lsl #0x10
	add r1, r3, r1, lsr #16
	sub r1, r6, r1
	mov r1, r1, lsl #0xd
	mov r4, r4, lsr #0x10
	mov r6, r2, asr #3
	mla r2, r5, r4, r0
	mov r0, r6, lsl #0x10
	cmp r3, #0
	mov r9, r1, lsr #0x10
	add r6, r2, r0, lsr #11
	beq _02050100
	rsb r0, r3, #8
	mov r1, r0, lsl #0x10
	add r2, r3, r1, lsr #16
	mov r0, r1, lsr #0x10
	mov r3, r2, lsl #0x10
	mov r2, r0, lsl #2
	mov r4, #0xf
	mov r5, r4, lsl r2
	and r1, r10, #7
	cmp r0, r3, lsr #16
	mvn r2, #0
	bhs _020500C8
_020500A8:
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mvn r4, r5
	mov r0, r0, lsr #0x10
	cmp r0, r3, lsr #16
	and r2, r2, r4
	mov r5, r5, lsl #4
	blo _020500A8
_020500C8:
	ldrh r0, [sp, #0x2c]
	add r0, r1, r0
	mov r3, r0, lsl #0x10
	cmp r1, r3, lsr #16
	bhs _020500FC
_020500DC:
	ldr r4, [r6, r1, lsl #2]
	add r0, r1, #1
	and r4, r4, r2
	mov r0, r0, lsl #0x10
	str r4, [r6, r1, lsl #2]
	mov r1, r0, lsr #0x10
	cmp r1, r3, lsr #16
	blo _020500DC
_020500FC:
	add r6, r6, #0x20
_02050100:
	cmp r9, #0
	beq _02050144
	cmp r9, #0
	mov r7, #0
	ble _02050144
	ldrh r0, [sp, #0x2c]
	and r5, r10, #7
	mov r4, r7
	mov r8, r0, lsl #2
_02050124:
	mov r0, r4
	mov r2, r8
	add r1, r6, r5, lsl #2
	bl MIi_CpuClear32
	add r7, r7, #1
	cmp r7, r9
	add r6, r6, #0x20
	blt _02050124
_02050144:
	cmp r11, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r2, r11, lsl #0x10
	mov r3, #0
	and r0, r10, #7
	sub r1, r3, #1
	movs r4, r2, lsr #0x10
	mov r5, #0xf
	beq _02050188
_02050168:
	add r2, r3, #1
	mvn r3, r5
	mov r2, r2, lsl #0x10
	cmp r4, r2, lsr #16
	and r1, r1, r3
	mov r3, r2, lsr #0x10
	mov r5, r5, lsl #4
	bhi _02050168
_02050188:
	ldrh r2, [sp, #0x2c]
	add r2, r0, r2
	mov r3, r2, lsl #0x10
	cmp r0, r3, lsr #16
	ldmhsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0205019C:
	ldr r4, [r6, r0, lsl #2]
	add r2, r0, #1
	and r4, r4, r1
	mov r2, r2, lsl #0x10
	str r4, [r6, r0, lsl #2]
	mov r0, r2, lsr #0x10
	cmp r0, r3, lsr #16
	blo _0205019C
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end BackgroundUnknown__Func_2050014

	arm_func_start BackgroundUnknown__Func_20501C0
BackgroundUnknown__Func_20501C0: // 0x020501C0
	stmdb sp!, {r3, r4, r5, lr}
	mov ip, r1, lsl #5
	mov r1, r3, asr #3
	mla r4, ip, r1, r0
	and r1, r2, #7
	mov r5, r2, asr #3
	and r2, r3, #7
	ldrh r3, [sp, #0x10]
	mov r0, r1, lsl #0x10
	mov lr, r1, lsl #2
	add r0, r3, r0, lsr #16
	mov ip, r0, lsl #0x10
	mov r3, #0xf
	add r0, r4, r5, lsl #5
	mov r4, r3, lsl lr
	cmp r1, ip, lsr #16
	mvn r3, #0
	bhs _02050228
_02050208:
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mvn lr, r4
	mov r1, r1, lsr #0x10
	cmp r1, ip, lsr #16
	and r3, r3, lr
	mov r4, r4, lsl #4
	blo _02050208
_02050228:
	ldrh r1, [sp, #0x14]
	add r1, r2, r1
	mov ip, r1, lsl #0x10
	cmp r2, ip, lsr #16
	ldmhsia sp!, {r3, r4, r5, pc}
_0205023C:
	ldr lr, [r0, r2, lsl #2]
	add r1, r2, #1
	and lr, lr, r3
	mov r1, r1, lsl #0x10
	str lr, [r0, r2, lsl #2]
	mov r2, r1, lsr #0x10
	cmp r2, ip, lsr #16
	blo _0205023C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BackgroundUnknown__Func_20501C0

	arm_func_start BackgroundUnknown__Func_2050260
BackgroundUnknown__Func_2050260: // 0x02050260
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	and r4, r2, #7
	mov r4, r4, lsl #0x10
	str r0, [sp]
	movs r0, r4, lsr #0x10
	str r0, [sp, #4]
	beq _02050290
	rsb r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #4]
_02050290:
	and r0, r3, #7
	mov r0, r0, lsl #0x10
	movs r0, r0, lsr #0x10
	str r0, [sp, #8]
	beq _020502B4
	rsb r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #8]
_020502B4:
	ldrh r8, [sp, #0x48]
	ldrh r0, [sp, #0x4c]
	mov r4, r2, lsl #0xd
	add r6, r2, r8
	and r7, r6, #7
	ldr r2, [sp, #4]
	mov r10, r7, lsl #0x10
	add r5, r3, r0
	and r9, r5, #7
	add r2, r2, r10, lsr #16
	sub r8, r8, r2
	mov r8, r8, lsl #0xd
	ldr r2, [sp, #8]
	mov r11, r9, lsl #0x10
	add r2, r2, r11, lsr #16
	sub r0, r0, r2
	mov r2, r3, lsl #0xd
	mov r3, r6, lsl #0xd
	ldr r6, [sp, #8]
	mov r0, r0, lsl #0xd
	mov r10, r8, lsr #0x10
	mov r8, r0, lsr #0x10
	mov r0, r4, lsr #0x10
	str r0, [sp, #0x1c]
	mov r0, r2, lsr #0x10
	str r0, [sp, #0x18]
	mov r0, r3, lsr #0x10
	mov r5, r5, lsl #0xd
	str r0, [sp, #0x14]
	mov r0, r5, lsr #0x10
	cmp r6, #0
	str r0, [sp, #0x10]
	mov r4, r1, lsl #6
	beq _020504BC
	ldr r1, [sp, #0x18]
	ldr r0, [sp]
	mla r1, r4, r1, r0
	ldr r0, [sp, #0x1c]
	add r6, r1, r0, lsl #6
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _020503F0
	ldr r0, [sp, #8]
	mov r3, r6
	rsb r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	ldr r0, [sp, #4]
	rsb r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #4
	movlo r2, #0
	blo _0205039C
	sub r0, r0, #4
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, #4
_0205039C:
	rsb r0, r0, #4
	mov r1, r0, lsl #3
	rsb r0, r2, #4
	mov r0, r0, lsl #3
	cmp r5, #8
	mvn r2, #0
	add r3, r3, r5, lsl #3
	bhs _020503EC
_020503BC:
	ldr r11, [r3, #0]
	add r5, r5, #1
	and r11, r11, r2, lsr r1
	str r11, [r3]
	mov r5, r5, lsl #0x10
	mov r5, r5, lsr #0x10
	cmp r5, #8
	ldr r11, [r3, #4]
	and r11, r11, r2, lsr r0
	str r11, [r3, #4]
	add r3, r3, #8
	blo _020503BC
_020503EC:
	add r6, r6, #0x40
_020503F0:
	cmp r10, #0
	mov r5, #0
	ble _0205043C
	ldr r0, [sp, #8]
	rsb r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	rsb r0, r1, #8
	mov r0, r0, lsl #3
	str r0, [sp, #0xc]
	mov r11, r1, lsl #1
_0205041C:
	ldr r2, [sp, #0xc]
	mov r0, #0
	add r1, r6, r11, lsl #2
	bl MIi_CpuClear32
	add r5, r5, #1
	add r6, r6, #0x40
	cmp r5, r10
	blt _0205041C
_0205043C:
	cmp r7, #0
	beq _020504BC
	ldr r0, [sp, #8]
	cmp r7, #4
	rsb r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	movlo r1, r7
	movlo r0, #0
	blo _02050474
	mov r1, #4
	sub r0, r7, #4
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
_02050474:
	mov r1, r1, lsl #3
	mov r0, r0, lsl #3
	cmp r3, #8
	mvn r2, #0
	add r6, r6, r3, lsl #3
	bhs _020504BC
_0205048C:
	ldr r5, [r6, #0]
	add r3, r3, #1
	and r5, r5, r2, lsl r1
	str r5, [r6]
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	cmp r3, #8
	ldr r5, [r6, #4]
	and r5, r5, r2, lsl r0
	str r5, [r6, #4]
	add r6, r6, #8
	blo _0205048C
_020504BC:
	cmp r8, #0
	beq _02050764
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _02050620
	ldr r1, [sp, #0x18]
	ldr r0, [sp]
	mov r11, #0
	mla r1, r4, r1, r0
	ldr r0, [sp, #0x1c]
	add r6, r1, r0, lsl #6
	ldr r0, [sp, #8]
	cmp r0, #0
	addne r6, r6, r4
	cmp r8, #0
	ble _02050620
	ldr r0, [sp, #4]
	mov lr, r11
	rsb r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	sub r0, r5, #4
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	mvn r1, #0
_02050520:
	cmp r5, #4
	movlo r2, r5
	movhs r2, #4
	rsb r2, r2, #4
	movlo r0, lr
	mov r2, r2, lsl #3
	movhs r0, r3
	mov r2, r1, lsr r2
	rsb r0, r0, #4
	mov r0, r0, lsl #3
	cmp r2, r1
	beq _020505B0
	ldr ip, [r6]
	and ip, ip, r2
	str ip, [r6]
	ldr ip, [r6, #8]
	and ip, ip, r2
	str ip, [r6, #8]
	ldr ip, [r6, #0x10]
	and ip, ip, r2
	str ip, [r6, #0x10]
	ldr ip, [r6, #0x18]
	and ip, ip, r2
	str ip, [r6, #0x18]
	ldr ip, [r6, #0x20]
	and ip, ip, r2
	str ip, [r6, #0x20]
	ldr ip, [r6, #0x28]
	and ip, ip, r2
	str ip, [r6, #0x28]
	ldr ip, [r6, #0x30]
	and ip, ip, r2
	str ip, [r6, #0x30]
	ldr ip, [r6, #0x38]
	and r2, ip, r2
	str r2, [r6, #0x38]
_020505B0:
	ldr r2, [r6, #4]
	add r11, r11, #1
	and r2, r2, r1, lsr r0
	str r2, [r6, #4]
	cmp r11, r8
	ldr r2, [r6, #0xc]
	and r2, r2, r1, lsr r0
	str r2, [r6, #0xc]
	ldr r2, [r6, #0x14]
	and r2, r2, r1, lsr r0
	str r2, [r6, #0x14]
	ldr r2, [r6, #0x1c]
	and r2, r2, r1, lsr r0
	str r2, [r6, #0x1c]
	ldr r2, [r6, #0x24]
	and r2, r2, r1, lsr r0
	str r2, [r6, #0x24]
	ldr r2, [r6, #0x2c]
	and r2, r2, r1, lsr r0
	str r2, [r6, #0x2c]
	ldr r2, [r6, #0x34]
	and r2, r2, r1, lsr r0
	str r2, [r6, #0x34]
	ldr r2, [r6, #0x3c]
	and r0, r2, r1, lsr r0
	str r0, [r6, #0x3c]
	add r6, r6, r4
	blt _02050520
_02050620:
	cmp r7, #0
	beq _02050764
	ldr r1, [sp, #0x18]
	ldr r0, [sp]
	mov r11, #0
	mla r1, r4, r1, r0
	ldr r0, [sp, #8]
	cmp r0, #0
	ldr r0, [sp, #0x14]
	add r6, r1, r0, lsl #6
	addne r6, r6, r4
	cmp r8, #0
	ble _02050764
	sub r0, r7, #4
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	mov lr, #4
	mov r5, r11
	mvn r2, #0
_0205066C:
	cmp r7, #4
	movlo r1, r7
	movhs r1, lr
	ldr ip, [r6]
	mov r1, r1, lsl #3
	and ip, ip, r2, lsl r1
	str ip, [r6]
	ldr ip, [r6, #8]
	movlo r0, r5
	and ip, ip, r2, lsl r1
	str ip, [r6, #8]
	ldr ip, [r6, #0x10]
	movhs r0, r3
	and ip, ip, r2, lsl r1
	str ip, [r6, #0x10]
	ldr ip, [r6, #0x18]
	mov r0, r0, lsl #3
	and ip, ip, r2, lsl r1
	str ip, [r6, #0x18]
	ldr ip, [r6, #0x20]
	mov r0, r2, lsl r0
	and ip, ip, r2, lsl r1
	str ip, [r6, #0x20]
	ldr ip, [r6, #0x28]
	cmp r0, r2
	and ip, ip, r2, lsl r1
	str ip, [r6, #0x28]
	ldr ip, [r6, #0x30]
	and ip, ip, r2, lsl r1
	str ip, [r6, #0x30]
	ldr ip, [r6, #0x38]
	and r1, ip, r2, lsl r1
	str r1, [r6, #0x38]
	beq _02050754
	ldr r1, [r6, #4]
	and r1, r1, r0
	str r1, [r6, #4]
	ldr r1, [r6, #0xc]
	and r1, r1, r0
	str r1, [r6, #0xc]
	ldr r1, [r6, #0x14]
	and r1, r1, r0
	str r1, [r6, #0x14]
	ldr r1, [r6, #0x1c]
	and r1, r1, r0
	str r1, [r6, #0x1c]
	ldr r1, [r6, #0x24]
	and r1, r1, r0
	str r1, [r6, #0x24]
	ldr r1, [r6, #0x2c]
	and r1, r1, r0
	str r1, [r6, #0x2c]
	ldr r1, [r6, #0x34]
	and r1, r1, r0
	str r1, [r6, #0x34]
	ldr r1, [r6, #0x3c]
	and r0, r1, r0
	str r0, [r6, #0x3c]
_02050754:
	add r6, r6, r4
	add r11, r11, #1
	cmp r11, r8
	blt _0205066C
_02050764:
	cmp r9, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp, #0x10]
	ldr r0, [sp]
	mla r1, r4, r1, r0
	ldr r0, [sp, #4]
	cmp r0, #0
	ldr r0, [sp, #0x1c]
	add r4, r1, r0, lsl #6
	beq _02050810
	ldr r0, [sp, #4]
	mov r5, r9
	rsb r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	cmp r1, #4
	mov r3, r4
	movlo r0, #0
	blo _020507C4
	sub r0, r1, #4
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #4
_020507C4:
	rsb r1, r1, #4
	rsb r0, r0, #4
	cmp r9, #0
	mov r1, r1, lsl #3
	mov r0, r0, lsl #3
	mvn r2, #0
	beq _0205080C
_020507E0:
	ldr r6, [r3, #0]
	sub r5, r5, #1
	and r6, r6, r2, lsr r1
	str r6, [r3]
	ldr r6, [r3, #4]
	mov r5, r5, lsl #0x10
	and r6, r6, r2, lsr r0
	str r6, [r3, #4]
	add r3, r3, #8
	movs r5, r5, lsr #0x10
	bne _020507E0
_0205080C:
	add r4, r4, #0x40
_02050810:
	cmp r10, #0
	mov r8, #0
	ble _02050844
	mov r6, r9, lsl #3
	mov r5, r8
_02050824:
	mov r0, r5
	mov r1, r4
	mov r2, r6
	bl MIi_CpuClear32
	add r8, r8, #1
	cmp r8, r10
	add r4, r4, #0x40
	blt _02050824
_02050844:
	cmp r7, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r7, #4
	movlo r0, #0
	blo _0205086C
	sub r0, r7, #4
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r7, #4
_0205086C:
	cmp r9, #0
	mov r3, r7, lsl #3
	mvn r5, #0
	addeq sp, sp, #0x20
	mov r2, r0, lsl #3
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02050884:
	ldr r1, [r4, #0]
	sub r0, r9, #1
	and r1, r1, r5, lsl r3
	str r1, [r4]
	ldr r1, [r4, #4]
	mov r0, r0, lsl #0x10
	and r1, r1, r5, lsl r2
	str r1, [r4, #4]
	add r4, r4, #8
	movs r9, r0, lsr #0x10
	bne _02050884
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end BackgroundUnknown__Func_2050260

	arm_func_start BackgroundUnknown__Func_20508B8
BackgroundUnknown__Func_20508B8: // 0x020508B8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	and r4, r3, #7
	mov r4, r4, lsl #0x10
	movs lr, r4, lsr #0x10
	rsbne r4, lr, #8
	movne r4, r4, lsl #0x10
	movne lr, r4, lsr #0x10
	ldrh r4, [sp, #0x34]
	mov r5, r3, lsl #0xd
	mov ip, r1, lsl #6
	mov r6, r5, lsr #0x10
	add r1, r3, r4
	and r3, r1, #7
	str r3, [sp]
	mov r3, r3, lsl #0x10
	add r3, lr, r3, lsr #16
	sub r3, r4, r3
	mov r3, r3, lsl #0xd
	mla r6, ip, r6, r0
	mov r5, r2, lsl #0xd
	mov r4, r1, lsl #0xd
	mov r1, r5, lsr #0x10
	str r1, [sp, #8]
	mov r1, r4, lsr #0x10
	str r1, [sp, #4]
	ldr r1, [sp, #8]
	cmp lr, #0
	mov r8, r3, lsr #0x10
	add r1, r6, r1, lsl #6
	beq _02050A8C
	ldrh r6, [sp, #0x30]
	and r3, r2, #7
	rsb r4, lr, #8
	mov r5, r3, lsl #0x10
	mov r4, r4, lsl #0x10
	add r5, r6, r5, lsr #16
	mov r9, r4, lsr #0x10
	mov r4, r5, lsl #0x10
	mvn r7, #0
	mov r6, r7
	mov r4, r4, lsr #0x10
	cmp r3, #4
	add r5, r1, r9, lsl #3
	mov r11, #0xff
	bhs _02050A04
	mov r10, r3, lsl #3
	cmp r4, #4
	mov r10, r11, lsl r10
	blo _020509D8
	cmp r3, #4
	bhs _020509A8
_02050988:
	mvn r11, r10
	and r7, r7, r11
	add r3, r3, #1
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	cmp r3, #4
	mov r10, r10, lsl #8
	blo _02050988
_020509A8:
	cmp r3, r4
	mov r11, #0xff
	bhs _02050A48
_020509B4:
	mvn r10, r11
	and r6, r6, r10
	add r3, r3, #1
	mov r3, r3, lsl #0x10
	cmp r4, r3, lsr #16
	mov r3, r3, lsr #0x10
	mov r11, r11, lsl #8
	bhi _020509B4
	b _02050A48
_020509D8:
	cmp r3, r4
	bhs _02050A48
_020509E0:
	mvn r11, r10
	and r7, r7, r11
	add r3, r3, #1
	mov r3, r3, lsl #0x10
	cmp r4, r3, lsr #16
	mov r3, r3, lsr #0x10
	mov r10, r10, lsl #8
	bhi _020509E0
	b _02050A48
_02050A04:
	sub r3, r3, #4
	mov r3, r3, lsl #0x10
	sub r4, r4, #4
	mov r3, r3, lsr #0x10
	mov r4, r4, lsl #0x10
	mov r10, r3, lsl #3
	cmp r3, r4, lsr #16
	mov r11, r11, lsl r10
	bhs _02050A48
_02050A28:
	mvn r10, r11
	and r6, r6, r10
	add r3, r3, #1
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	cmp r3, r4, lsr #16
	mov r11, r11, lsl #8
	blo _02050A28
_02050A48:
	add r3, r9, lr
	mov r4, r3, lsl #0x10
	cmp r9, r4, lsr #16
	bhs _02050A88
_02050A58:
	ldr r10, [r5, #0]
	add r3, r9, #1
	and r9, r10, r7
	str r9, [r5]
	mov r3, r3, lsl #0x10
	mov r9, r3, lsr #0x10
	cmp r9, r4, lsr #16
	ldr r3, [r5, #4]
	and r3, r3, r6
	str r3, [r5, #4]
	add r5, r5, #8
	blo _02050A58
_02050A88:
	add r1, r1, ip
_02050A8C:
	cmp r8, #0
	beq _02050C90
	cmp r8, #0
	mov r3, #0
	ble _02050C90
	ldrh r7, [sp, #0x30]
	and r11, r2, #7
_02050AA8:
	mov r4, r11, lsl #0x10
	add r5, r7, r4, lsr #16
	mov lr, r4, lsr #0x10
	mov r4, r5, lsl #0x10
	mvn r6, #0
	mov r4, r4, lsr #0x10
	cmp lr, #4
	mov r5, r6
	mov r10, #0xff
	bhs _02050B64
	mov r9, lr, lsl #3
	cmp r4, #4
	mov r9, r10, lsl r9
	blo _02050B38
	cmp lr, #4
	bhs _02050B08
_02050AE8:
	mvn r10, r9
	and r6, r6, r10
	add r10, lr, #1
	mov r10, r10, lsl #0x10
	mov lr, r10, lsr #0x10
	cmp lr, #4
	mov r9, r9, lsl #8
	blo _02050AE8
_02050B08:
	cmp lr, r4
	mov r10, #0xff
	bhs _02050BA8
_02050B14:
	mvn r9, r10
	and r5, r5, r9
	add r9, lr, #1
	mov r9, r9, lsl #0x10
	cmp r4, r9, lsr #16
	mov lr, r9, lsr #0x10
	mov r10, r10, lsl #8
	bhi _02050B14
	b _02050BA8
_02050B38:
	cmp lr, r4
	bhs _02050BA8
_02050B40:
	mvn r10, r9
	and r6, r6, r10
	add r10, lr, #1
	mov r10, r10, lsl #0x10
	cmp r4, r10, lsr #16
	mov lr, r10, lsr #0x10
	mov r9, r9, lsl #8
	bhi _02050B40
	b _02050BA8
_02050B64:
	sub r9, lr, #4
	mov r9, r9, lsl #0x10
	sub r4, r4, #4
	mov lr, r9, lsr #0x10
	mov r4, r4, lsl #0x10
	mov r9, lr, lsl #3
	cmp lr, r4, lsr #16
	mov r10, r10, lsl r9
	bhs _02050BA8
_02050B88:
	mvn r9, r10
	and r5, r5, r9
	add r9, lr, #1
	mov r9, r9, lsl #0x10
	mov lr, r9, lsr #0x10
	cmp lr, r4, lsr #16
	mov r10, r10, lsl #8
	blo _02050B88
_02050BA8:
	mvn r4, #0
	cmp r6, r4
	beq _02050C14
	ldr r4, [r1, #0]
	and r4, r4, r6
	str r4, [r1]
	ldr r4, [r1, #8]
	and r4, r4, r6
	str r4, [r1, #8]
	ldr r4, [r1, #0x10]
	and r4, r4, r6
	str r4, [r1, #0x10]
	ldr r4, [r1, #0x18]
	and r4, r4, r6
	str r4, [r1, #0x18]
	ldr r4, [r1, #0x20]
	and r4, r4, r6
	str r4, [r1, #0x20]
	ldr r4, [r1, #0x28]
	and r4, r4, r6
	str r4, [r1, #0x28]
	ldr r4, [r1, #0x30]
	and r4, r4, r6
	str r4, [r1, #0x30]
	ldr r4, [r1, #0x38]
	and r4, r4, r6
	str r4, [r1, #0x38]
_02050C14:
	mvn r4, #0
	cmp r5, r4
	beq _02050C80
	ldr r4, [r1, #4]
	and r4, r4, r5
	str r4, [r1, #4]
	ldr r4, [r1, #0xc]
	and r4, r4, r5
	str r4, [r1, #0xc]
	ldr r4, [r1, #0x14]
	and r4, r4, r5
	str r4, [r1, #0x14]
	ldr r4, [r1, #0x1c]
	and r4, r4, r5
	str r4, [r1, #0x1c]
	ldr r4, [r1, #0x24]
	and r4, r4, r5
	str r4, [r1, #0x24]
	ldr r4, [r1, #0x2c]
	and r4, r4, r5
	str r4, [r1, #0x2c]
	ldr r4, [r1, #0x34]
	and r4, r4, r5
	str r4, [r1, #0x34]
	ldr r4, [r1, #0x3c]
	and r4, r4, r5
	str r4, [r1, #0x3c]
_02050C80:
	add r3, r3, #1
	cmp r3, r8
	add r1, r1, ip
	blt _02050AA8
_02050C90:
	ldr r1, [sp]
	cmp r1, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp, #4]
	ldrh r3, [sp, #0x30]
	mla r7, ip, r1, r0
	and r0, r2, #7
	mov r2, r0, lsl #0x10
	add r2, r3, r2, lsr #16
	mov r1, #0
	mov r6, r2, lsl #0x10
	ldr r2, [sp, #8]
	sub r5, r1, #1
	add r3, r7, r2, lsl #6
	mov r4, r5
	cmp r0, #4
	mov r2, r6, lsr #0x10
	mov r7, #0xff
	bhs _02050D74
	mov r6, r0, lsl #3
	cmp r2, #4
	mov r7, r7, lsl r6
	blo _02050D48
	cmp r0, #4
	bhs _02050D18
_02050CF8:
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mvn r6, r7
	mov r0, r0, lsr #0x10
	cmp r0, #4
	and r5, r5, r6
	mov r7, r7, lsl #8
	blo _02050CF8
_02050D18:
	cmp r0, r2
	mov r7, #0xff
	bhs _02050DB8
_02050D24:
	add r0, r0, #1
	mvn r6, r7
	mov r0, r0, lsl #0x10
	cmp r2, r0, lsr #16
	and r4, r4, r6
	mov r0, r0, lsr #0x10
	mov r7, r7, lsl #8
	bhi _02050D24
	b _02050DB8
_02050D48:
	cmp r0, r2
	bhs _02050DB8
_02050D50:
	add r0, r0, #1
	mvn r6, r7
	mov r0, r0, lsl #0x10
	cmp r2, r0, lsr #16
	and r5, r5, r6
	mov r0, r0, lsr #0x10
	mov r7, r7, lsl #8
	bhi _02050D50
	b _02050DB8
_02050D74:
	sub r0, r0, #4
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	sub r2, r2, #4
	mov r2, r2, lsl #0x10
	mov r6, r0, lsl #3
	cmp r0, r2, lsr #16
	mov r7, r7, lsl r6
	bhs _02050DB8
_02050D98:
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mvn r6, r7
	mov r0, r0, lsr #0x10
	cmp r0, r2, lsr #16
	and r4, r4, r6
	mov r7, r7, lsl #8
	blo _02050D98
_02050DB8:
	ldr r0, [sp]
	mov r0, r0, lsl #0x10
	movs r6, r0, lsr #0x10
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02050DCC:
	ldr r2, [r3, #0]
	add r0, r1, #1
	and r1, r2, r5
	str r1, [r3]
	ldr r1, [r3, #4]
	mov r0, r0, lsl #0x10
	and r1, r1, r4
	str r1, [r3, #4]
	cmp r6, r0, lsr #16
	add r3, r3, #8
	mov r1, r0, lsr #0x10
	bhi _02050DCC
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end BackgroundUnknown__Func_20508B8

	arm_func_start BackgroundUnknown__Func_2050E04
BackgroundUnknown__Func_2050E04: // 0x02050E04
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	and r4, r2, #7
	ldrh r6, [sp, #0x28]
	mov r4, r4, lsl #0x10
	mov r10, r3
	movs r3, r4, lsr #0x10
	rsbne r3, r3, #8
	mov r5, r1, lsl #6
	add r1, r2, r6
	movne r3, r3, lsl #0x10
	and r11, r1, #7
	movne r3, r3, lsr #0x10
	mov r4, r10, lsl #0xd
	mov r1, r11, lsl #0x10
	add r1, r3, r1, lsr #16
	sub r1, r6, r1
	mov r1, r1, lsl #0xd
	mov r4, r4, lsr #0x10
	mov r6, r2, asr #3
	mla r2, r5, r4, r0
	mov r0, r6, lsl #0x10
	cmp r3, #0
	mov r9, r1, lsr #0x10
	add r6, r2, r0, lsr #10
	beq _02050FBC
	rsb r0, r3, #8
	mov r0, r0, lsl #0x10
	add r1, r3, r0, lsr #16
	and r7, r10, #7
	mov r0, r0, lsr #0x10
	mov r1, r1, lsl #0x10
	mvn r5, #0
	mov r4, r5
	cmp r0, #4
	add r2, r6, r7, lsl #3
	mov r1, r1, lsr #0x10
	mov r8, #0xff
	bhs _02050F30
	mov r3, r0, lsl #3
	cmp r1, #4
	mov r3, r8, lsl r3
	blo _02050F04
	cmp r0, #4
	bhs _02050ED4
_02050EB4:
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mvn r8, r3
	mov r0, r0, lsr #0x10
	cmp r0, #4
	and r5, r5, r8
	mov r3, r3, lsl #8
	blo _02050EB4
_02050ED4:
	cmp r0, r1
	mov r3, #0xff
	bhs _02050F74
_02050EE0:
	add r0, r0, #1
	mvn r8, r3
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	and r4, r4, r8
	mov r0, r0, lsr #0x10
	mov r3, r3, lsl #8
	bhi _02050EE0
	b _02050F74
_02050F04:
	cmp r0, r1
	bhs _02050F74
_02050F0C:
	add r0, r0, #1
	mvn r8, r3
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	and r5, r5, r8
	mov r0, r0, lsr #0x10
	mov r3, r3, lsl #8
	bhi _02050F0C
	b _02050F74
_02050F30:
	sub r0, r0, #4
	mov r0, r0, lsl #0x10
	sub r1, r1, #4
	mov r0, r0, lsr #0x10
	mov r3, r1, lsl #0x10
	mov r1, r0, lsl #3
	cmp r0, r3, lsr #16
	mov r1, r8, lsl r1
	bhs _02050F74
_02050F54:
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mvn r8, r1
	mov r0, r0, lsr #0x10
	cmp r0, r3, lsr #16
	and r4, r4, r8
	mov r1, r1, lsl #8
	blo _02050F54
_02050F74:
	ldrh r0, [sp, #0x2c]
	add r0, r7, r0
	mov r1, r0, lsl #0x10
	cmp r7, r1, lsr #16
	bhs _02050FB8
_02050F88:
	ldr r3, [r2, #0]
	add r0, r7, #1
	and r3, r3, r5
	str r3, [r2]
	ldr r3, [r2, #4]
	mov r0, r0, lsl #0x10
	and r3, r3, r4
	mov r7, r0, lsr #0x10
	str r3, [r2, #4]
	cmp r7, r1, lsr #16
	add r2, r2, #8
	blo _02050F88
_02050FB8:
	add r6, r6, #0x40
_02050FBC:
	cmp r9, #0
	beq _02051008
	cmp r9, #0
	mov r7, #0
	ble _02051008
	ldrh r1, [sp, #0x2c]
	and r0, r10, #7
	mov r0, r0, lsl #0x10
	mov r8, r1, lsl #3
	mov r5, r0, lsr #0xf
	mov r4, r7
_02050FE8:
	mov r0, r4
	mov r2, r8
	add r1, r6, r5, lsl #2
	bl MIi_CpuClear32
	add r7, r7, #1
	cmp r7, r9
	add r6, r6, #0x40
	blt _02050FE8
_02051008:
	cmp r11, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r11, lsl #0x10
	mov r5, #0
	and r4, r10, #7
	sub r3, r5, #1
	mov r0, r0, lsr #0x10
	mov r2, r3
	cmp r0, #4
	add r1, r6, r4, lsl #3
	mov r7, #0xff
	blo _02051088
_02051038:
	add r5, r5, #1
	mov r5, r5, lsl #0x10
	mvn r6, r7
	mov r5, r5, lsr #0x10
	cmp r5, #4
	and r3, r3, r6
	mov r7, r7, lsl #8
	blo _02051038
	cmp r5, r0
	mov r7, #0xff
	bhs _020510B0
_02051064:
	add r5, r5, #1
	mvn r6, r7
	mov r5, r5, lsl #0x10
	cmp r0, r5, lsr #16
	and r2, r2, r6
	mov r5, r5, lsr #0x10
	mov r7, r7, lsl #8
	bhi _02051064
	b _020510B0
_02051088:
	cmp r0, #0
	bls _020510B0
_02051090:
	add r5, r5, #1
	mvn r6, r7
	mov r5, r5, lsl #0x10
	cmp r0, r5, lsr #16
	and r3, r3, r6
	mov r5, r5, lsr #0x10
	mov r7, r7, lsl #8
	bhi _02051090
_020510B0:
	ldrh r0, [sp, #0x2c]
	add r0, r4, r0
	mov r5, r0, lsl #0x10
	cmp r4, r5, lsr #16
	ldmhsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020510C4:
	ldr r6, [r1, #0]
	add r0, r4, #1
	and r4, r6, r3
	str r4, [r1]
	ldr r4, [r1, #4]
	mov r0, r0, lsl #0x10
	and r6, r4, r2
	mov r4, r0, lsr #0x10
	str r6, [r1, #4]
	cmp r4, r5, lsr #16
	add r1, r1, #8
	blo _020510C4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end BackgroundUnknown__Func_2050E04

	arm_func_start BackgroundUnknown__Func_20510F8
BackgroundUnknown__Func_20510F8: // 0x020510F8
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r1, lsl #6
	mov r1, r3, asr #3
	mla r5, r4, r1, r0
	and r0, r2, #7
	and lr, r3, #7
	mov r3, r2, asr #3
	ldrh r2, [sp, #0x10]
	mov r1, r0, lsl #0x10
	mvn ip, #0
	add r1, r2, r1, lsr #16
	add r2, r5, r3, lsl #6
	mov r1, r1, lsl #0x10
	mov r3, ip
	cmp r0, #4
	add r2, r2, lr, lsl #3
	mov r1, r1, lsr #0x10
	mov r5, #0xff
	bhs _020511D8
	mov r4, r0, lsl #3
	cmp r1, #4
	mov r5, r5, lsl r4
	blo _020511AC
	cmp r0, #4
	bhs _0205117C
_0205115C:
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mvn r4, r5
	mov r0, r0, lsr #0x10
	cmp r0, #4
	and ip, ip, r4
	mov r5, r5, lsl #8
	blo _0205115C
_0205117C:
	cmp r0, r1
	mov r5, #0xff
	bhs _0205121C
_02051188:
	add r0, r0, #1
	mvn r4, r5
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	and r3, r3, r4
	mov r0, r0, lsr #0x10
	mov r5, r5, lsl #8
	bhi _02051188
	b _0205121C
_020511AC:
	cmp r0, r1
	bhs _0205121C
_020511B4:
	add r0, r0, #1
	mvn r4, r5
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	and ip, ip, r4
	mov r0, r0, lsr #0x10
	mov r5, r5, lsl #8
	bhi _020511B4
	b _0205121C
_020511D8:
	sub r0, r0, #4
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	sub r1, r1, #4
	mov r1, r1, lsl #0x10
	mov r4, r0, lsl #3
	cmp r0, r1, lsr #16
	mov r5, r5, lsl r4
	bhs _0205121C
_020511FC:
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mvn r4, r5
	mov r0, r0, lsr #0x10
	cmp r0, r1, lsr #16
	and r3, r3, r4
	mov r5, r5, lsl #8
	blo _020511FC
_0205121C:
	ldrh r0, [sp, #0x14]
	add r0, lr, r0
	mov r1, r0, lsl #0x10
	cmp lr, r1, lsr #16
	ldmhsia sp!, {r3, r4, r5, pc}
_02051230:
	ldr r4, [r2, #0]
	add r0, lr, #1
	and r4, r4, ip
	str r4, [r2]
	ldr lr, [r2, #4]
	mov r0, r0, lsl #0x10
	and r4, lr, r3
	mov lr, r0, lsr #0x10
	str r4, [r2, #4]
	cmp lr, r1, lsr #16
	add r2, r2, #8
	blo _02051230
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BackgroundUnknown__Func_20510F8

	.rodata

_0211030C: // 0x0211030C
	.byte 0x60, 2, 5, 2, 0xB8, 8, 5, 2, 4, 0xE, 5, 2, 0xF8, 0x10
	.byte 5, 2

_0211031C: // 0x0211031C
	.word BackgroundUnknown__Func_204F964
	.word BackgroundUnknown__Func_204FD98
	.word BackgroundUnknown__Func_2050014
	.word BackgroundUnknown__Func_20501C0
