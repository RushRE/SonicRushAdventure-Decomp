	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start NNS_G2dArrangeOBJ1D
NNS_G2dArrangeOBJ1D: // 0x020CDF54
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x3c
	mov r7, r0
	mov r0, r1
	cmp r0, #8
	ldr r0, [sp, #0x60]
	str r1, [sp, #0x10]
	str r0, [sp, #0x60]
	ldr r0, [sp, #0x6c]
	str r2, [sp, #0x14]
	str r0, [sp, #0x6c]
	ldrlt r0, [sp, #0x10]
	mov r11, r3
	ldr r6, [sp, #0x64]
	ldr r5, [sp, #0x68]
	movge r2, #3
	clzlt r0, r0
	rsblt r2, r0, #0x1f
	ldr r0, [sp, #0x14]
	cmp r0, #8
	ldrlt r0, [sp, #0x14]
	movge r1, #3
	clzlt r0, r0
	rsblt r1, r0, #0x1f
	ldr r0, _020CE274 // =objs
	mvn r3, #0
	add r1, r0, r1, lsl #3
	add r0, r1, r2, lsl #1
	ldrb r4, [r1, r2, lsl #1]
	ldrb r1, [r0, #1]
	ldr r2, [sp, #0x14]
	cmp r6, #0
	str r1, [sp, #0x18]
	ldr r1, [sp, #0x10]
	and r1, r1, r3, lsl r4
	str r1, [sp, #0x1c]
	ldr r1, [sp, #0x18]
	and r1, r2, r3, lsl r1
	str r1, [sp, #0x20]
	moveq r1, #1
	streq r1, [sp, #0x24]
	movne r1, #2
	strne r1, [sp, #0x24]
	mov r1, #0
	str r1, [sp, #0x28]
	bl OBJSizeToShape
	ldr r1, [sp, #0x10]
	ldr r2, [sp, #0x14]
	mov r10, r1, asr r4
	ldr r1, [sp, #0x18]
	mov r1, r2, asr r1
	str r1, [sp, #0x2c]
	ldr r1, [sp, #0x24]
	mov r2, r1, lsl r4
	ldr r1, [sp, #0x18]
	mov r2, r2, lsl r1
	ldr r1, [sp, #0x6c]
	mov r9, r2, asr r1
	mov r1, #0
	str r1, [sp, #0x30]
	str r1, [sp, #0x34]
	b _020CE0EC
_020CE04C:
	ldr r2, [sp, #0x30]
	ldr r1, [sp, #0x18]
	ldr r8, [sp, #0x34]
	mov r2, r2, lsl r1
	ldr r1, [sp, #0x60]
	add lr, r1, r2, lsl #3
	b _020CE0D8
_020CE068:
	mov r1, r8, lsl r4
	add r2, r11, r1, lsl #3
	ldr r1, _020CE278 // =0x000001FF
	ldr r3, [r7]
	and ip, r2, r1
	ldr r1, _020CE27C // =0xFE00FF00
	and r2, lr, #0xff
	and r1, r3, r1
	orr r1, r1, r2
	orr r1, r1, ip, lsl #16
	str r1, [r7]
	ldr r3, [r7]
	ldr r1, _020CE280 // =0x3FFF3FFF
	mov r2, #0x400
	and r1, r3, r1
	orr r1, r1, r0
	str r1, [r7]
	rsb r1, r2, #0
	ldrh r2, [r7, #4]
	add r8, r8, #1
	and r1, r2, r1
	orr r1, r1, r5
	strh r1, [r7, #4]
	ldr r1, [r7]
	add r5, r5, r9
	bic r1, r1, #0x2000
	orr r1, r1, r6, lsl #13
	str r1, [r7], #8
_020CE0D8:
	cmp r8, r10
	blt _020CE068
	ldr r1, [sp, #0x30]
	add r1, r1, #1
	str r1, [sp, #0x30]
_020CE0EC:
	ldr r2, [sp, #0x30]
	ldr r1, [sp, #0x2c]
	cmp r2, r1
	blt _020CE04C
	ldr r0, [sp, #0x28]
	mla r0, r10, r1, r0
	str r0, [sp, #0x28]
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x10]
	cmp r1, r0
	bhs _020CE17C
	ldr r0, [sp, #0x60]
	ldr r1, [sp, #0x10]
	str r0, [sp]
	ldr r0, [sp, #0x1c]
	str r6, [sp, #4]
	sub r4, r1, r0
	ldr r1, [sp, #0x6c]
	str r5, [sp, #8]
	str r1, [sp, #0xc]
	ldr r1, [sp, #0x1c]
	ldr r2, [sp, #0x20]
	add r3, r11, r1, lsl #3
	mov r0, r7
	mov r1, r4
	bl NNS_G2dArrangeOBJ1D
	ldr r1, [sp, #0x24]
	add r7, r7, r0, lsl #3
	mul r2, r1, r4
	ldr r1, [sp, #0x20]
	mul r2, r1, r2
	ldr r1, [sp, #0x6c]
	add r5, r5, r2, lsr r1
	ldr r1, [sp, #0x28]
	add r0, r1, r0
	str r0, [sp, #0x28]
_020CE17C:
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x14]
	cmp r1, r0
	bhs _020CE1F4
	ldr r1, [sp, #0x60]
	ldr r0, [sp, #0x20]
	mov r3, r11
	add r0, r1, r0, lsl #3
	str r0, [sp]
	str r6, [sp, #4]
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x20]
	str r5, [sp, #8]
	sub r4, r1, r0
	ldr r1, [sp, #0x6c]
	mov r0, r7
	str r1, [sp, #0xc]
	ldr r1, [sp, #0x1c]
	mov r2, r4
	bl NNS_G2dArrangeOBJ1D
	ldr r2, [sp, #0x24]
	ldr r1, [sp, #0x1c]
	add r7, r7, r0, lsl #3
	mul r1, r2, r1
	mul r2, r4, r1
	ldr r1, [sp, #0x6c]
	add r5, r5, r2, lsr r1
	ldr r1, [sp, #0x28]
	add r0, r1, r0
	str r0, [sp, #0x28]
_020CE1F4:
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x10]
	cmp r1, r0
	bhs _020CE268
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x14]
	cmp r1, r0
	bhs _020CE268
	ldr r1, [sp, #0x60]
	ldr r0, [sp, #0x20]
	ldr r2, [sp, #0x10]
	add r0, r1, r0, lsl #3
	ldr r1, [sp, #0x1c]
	ldr r3, [sp, #0x14]
	str r0, [sp]
	sub r1, r2, r1
	ldr r2, [sp, #0x20]
	str r6, [sp, #4]
	sub r2, r3, r2
	ldr r3, [sp, #0x1c]
	ldr r4, [sp, #0x6c]
	str r5, [sp, #8]
	mov r0, r7
	add r3, r11, r3, lsl #3
	str r4, [sp, #0xc]
	bl NNS_G2dArrangeOBJ1D
	ldr r1, [sp, #0x28]
	add r0, r1, r0
	str r0, [sp, #0x28]
_020CE268:
	ldr r0, [sp, #0x28]
	add sp, sp, #0x3c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020CE274: .word objs
_020CE278: .word 0x000001FF
_020CE27C: .word 0xFE00FF00
_020CE280: .word 0x3FFF3FFF
	arm_func_end NNS_G2dArrangeOBJ1D

	arm_func_start NNSi_G2dCalcRequiredOBJ
NNSi_G2dCalcRequiredOBJ: // 0x020CE284
	stmdb sp!, {r4, r5, r6, lr}
	mov r3, r0, lsr #3
	mov r6, r1, lsr #3
	mul ip, r3, r6
	and r2, r0, #4
	and lr, r0, #2
	and r0, r0, #1
	add r4, r0, lr, lsr #1
	mov r5, r2, lsr #2
	and r0, r1, #4
	add lr, ip, #0
	add ip, r5, r4, lsl #1
	mla ip, r6, ip, lr
	and lr, r1, #2
	and r1, r1, #1
	add lr, r1, lr, lsr #1
	mov r1, r0, lsr #2
	add r1, r1, lr, lsl #1
	mla ip, r3, r1, ip
	add r1, r4, r2, lsr #2
	add r0, lr, r0, lsr #2
	mla r0, r1, r0, ip
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNSi_G2dCalcRequiredOBJ

	arm_func_start NNS_G2dMapScrToChar256x16Pltt
NNS_G2dMapScrToChar256x16Pltt: // 0x020CE2E0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr ip, [sp, #0x1c]
	ldr r8, [sp, #0x18]
	mov ip, ip, lsl #0x1c
	mov r4, ip, lsr #0x10
	mov r6, #0
	cmp r2, #0
	ldmleia sp!, {r4, r5, r6, r7, r8, pc}
	mov lr, r3, lsl #1
	mov ip, r6
_020CE308:
	mov r5, r0
	mov r7, ip
	cmp r1, #0
	ble _020CE330
_020CE318:
	orr r3, r4, r8
	add r7, r7, #1
	cmp r7, r1
	add r8, r8, #1
	strh r3, [r5], #2
	blt _020CE318
_020CE330:
	add r6, r6, #1
	cmp r6, r2
	add r0, r0, lr
	blt _020CE308
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end NNS_G2dMapScrToChar256x16Pltt

	arm_func_start NNS_G2dMapScrToCharText
NNS_G2dMapScrToCharText: // 0x020CE344
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r5, [sp, #0x24]
	ldr lr, [sp, #0x20]
	cmp r5, #0x20
	ldr ip, [sp, #0x28]
	bgt _020CE384
	mla r4, r5, lr, r3
	ldr lr, [sp, #0x2c]
	str ip, [sp]
	mov r3, r5
	add r0, r0, r4, lsl #1
	str lr, [sp, #4]
	bl NNS_G2dMapScrToChar256x16Pltt
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020CE384:
	ldr r4, [sp, #0x2c]
	add r7, lr, r2
	mov r2, r4, lsl #0x1c
	cmp lr, r7
	add r8, r3, r1
	mov r4, r2, lsr #0x10
	addge sp, sp, #8
	ldmgeia sp!, {r4, r5, r6, r7, r8, pc}
_020CE3A4:
	cmp lr, #0x20
	movlt r1, lr
	addge r1, lr, #0x20
	mov r6, r3
	cmp r3, r8
	add r5, r0, r1, lsl #6
	bge _020CE3E8
_020CE3C0:
	cmp r6, #0x20
	movlt r1, r6
	addge r1, r6, #0x3e0
	orr r2, r4, ip
	mov r1, r1, lsl #1
	add r6, r6, #1
	strh r2, [r5, r1]
	cmp r6, r8
	add ip, ip, #1
	blt _020CE3C0
_020CE3E8:
	add lr, lr, #1
	cmp lr, r7
	blt _020CE3A4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end NNS_G2dMapScrToCharText

	arm_func_start NNS_G2dCharCanvasInitForOBJ1D
NNS_G2dCharCanvasInitForOBJ1D: // 0x020CE3FC
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x18
	cmp r2, #8
	movlt r4, r2
	movge ip, #3
	clzlt r4, r4
	rsblt ip, r4, #0x1f
	cmp r3, #8
	movlt r4, r3
	movge r6, #3
	clzlt r4, r4
	rsblt r6, r4, #0x1f
	ldr r4, _020CE47C // =objs
	ldr r5, [sp, #0x28]
	add r4, r4, r6, lsl #3
	ldrb r6, [r4, ip, lsl #1]
	add ip, r4, ip, lsl #1
	ldr r4, _020CE480 // =DrawGlyph1D
	strb r6, [sp, #0x14]
	ldrb r6, [ip, #1]
	ldr lr, _020CE484 // =ClearContinuous
	ldr ip, _020CE488 // =ClearArea1D
	strb r6, [sp, #0x15]
	str r5, [sp]
	str r4, [sp, #4]
	str lr, [sp, #8]
	str ip, [sp, #0xc]
	ldr ip, [sp, #0x14]
	str ip, [sp, #0x10]
	bl InitCharCanvas
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020CE47C: .word objs
_020CE480: .word DrawGlyph1D
_020CE484: .word ClearContinuous
_020CE488: .word ClearArea1D
	arm_func_end NNS_G2dCharCanvasInitForOBJ1D

	arm_func_start NNS_G2dCharCanvasInitForBG
NNS_G2dCharCanvasInitForBG: // 0x020CE48C
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	ldr lr, [sp, #0x18]
	ldr ip, _020CE4C4 // =DrawGlyphLine
	str lr, [sp]
	ldr lr, _020CE4C8 // =ClearContinuous
	str ip, [sp, #4]
	ldr ip, _020CE4CC // =ClearAreaLine
	str lr, [sp, #8]
	str ip, [sp, #0xc]
	str r2, [sp, #0x10]
	bl InitCharCanvas
	add sp, sp, #0x14
	ldmia sp!, {pc}
	.align 2, 0
_020CE4C4: .word DrawGlyphLine
_020CE4C8: .word ClearContinuous
_020CE4CC: .word ClearAreaLine
	arm_func_end NNS_G2dCharCanvasInitForBG

	arm_func_start NNS_G2dCharCanvasDrawChar
NNS_G2dCharCanvasDrawChar: // 0x020CE4D0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r7, r1
	ldrh r1, [sp, #0x2c]
	mov r8, r0
	mov r0, r7
	mov r6, r2
	mov r5, r3
	bl NNS_G2dFontFindGlyphIndex
	ldr r1, _020CE588 // =0x0000FFFF
	mov r4, r0
	cmp r4, r1
	ldreq r0, [r7]
	ldreqh r4, [r0, #2]
	mov r0, r7
	mov r1, r4
	bl NNS_G2dFontGetCharWidthsFromIndex
	str r0, [sp, #8]
	ldr r0, [r7]
	ldr r2, [sp, #0x28]
	ldr r0, [r0, #8]
	add r1, sp, #8
	ldrh r3, [r0, #2]
	add ip, r0, #8
	mov r0, r8
	mla r3, r4, r3, ip
	str r3, [sp, #0xc]
	str r2, [sp]
	str r1, [sp, #4]
	ldr r1, [sp, #8]
	ldr r4, [r8, #0x14]
	ldrsb r2, [r1]
	mov r1, r7
	mov r3, r5
	add r2, r6, r2
	blx r4
	ldrh r0, [r7, #8]
	cmp r0, #0
	ldrne r0, [sp, #8]
	ldrnesb r1, [r0]
	ldrneb r0, [r0, #1]
	addne r0, r1, r0
	ldreq r0, [sp, #8]
	ldreqsb r0, [r0, #2]
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020CE588: .word 0x0000FFFF
	arm_func_end NNS_G2dCharCanvasDrawChar

	arm_func_start InitCharCanvas
InitCharCanvas: // 0x020CE58C
	str r2, [r0, #4]
	ldr r2, [sp]
	str r3, [r0, #8]
	strb r2, [r0, #0xc]
	ldr r2, [sp, #4]
	str r1, [r0]
	ldr r1, [sp, #8]
	str r2, [r0, #0x14]
	ldr r2, [sp, #0xc]
	str r1, [r0, #0x18]
	ldr r1, [sp, #0x10]
	str r2, [r0, #0x1c]
	str r1, [r0, #0x10]
	bx lr
	arm_func_end InitCharCanvas

	arm_func_start ClearArea1D
ClearArea1D: // 0x020CE5C4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x54
	ldrb r4, [r0, #0xc]
	mov r10, r2
	str r1, [sp, #0xc]
	str r4, [sp, #0x44]
	ldr r1, [sp, #0x44]
	ldr r4, [sp, #0x78]
	cmp r1, #4
	add r1, r10, r4
	str r1, [sp, #0x1c]
	ldr r2, [sp, #0x7c]
	mov r1, r3
	add r1, r1, r2
	str r1, [sp, #0x20]
	ldrne r1, [sp, #0xc]
	str r3, [sp, #0x10]
	orrne r1, r1, r1, lsl #8
	orrne r1, r1, r1, lsl #16
	strne r1, [sp, #0xc]
	bne _020CE62C
	ldr r1, [sp, #0xc]
	orr r1, r1, r1, lsl #4
	orr r1, r1, r1, lsl #8
	orr r1, r1, r1, lsl #16
	str r1, [sp, #0xc]
_020CE62C:
	bic r1, r10, #7
	str r1, [sp, #0x30]
	ldr r1, [sp, #0x10]
	ldr r2, [r0, #0x10]
	bic r1, r1, #7
	str r1, [sp, #0x14]
	ldr r1, [sp, #0x44]
	str r2, [sp, #0x4c]
	mov r3, r1, lsl #6
	mov r2, r3, asr #2
	ldr r1, [sp, #0x20]
	add r3, r3, r2, lsr #29
	ldr r2, [sp, #0x1c]
	add r6, r1, #7
	add r2, r2, #7
	bic r5, r2, #7
	bic r2, r6, #7
	ldr r1, [sp, #0x30]
	str r2, [sp, #0x24]
	mov r2, r3, asr #3
	str r2, [sp, #0x48]
	mov r4, r1, asr #2
	ldr r2, [sp, #0x30]
	ldr r1, [sp, #0x14]
	add r2, r2, r4, lsr #29
	mov r2, r2, asr #3
	str r2, [sp, #0x2c]
	ldr r2, [sp, #0x14]
	mov r1, r1, asr #2
	add r1, r2, r1, lsr #29
	mov r6, r1, asr #3
	ldr r1, [sp, #0x24]
	cmp r2, r1
	ldr r1, [r0, #4]
	str r1, [sp, #0x40]
	ldr r1, [r0, #8]
	ldr r0, [r0]
	str r1, [sp, #0x3c]
	str r0, [sp, #0x28]
	ldrb r0, [sp, #0x4c]
	str r0, [sp, #0x38]
	ldrb r0, [sp, #0x4d]
	str r0, [sp, #0x34]
	addge sp, sp, #0x54
	ldmgeia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r4, #0
	mov r11, #8
_020CE6E8:
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x10]
	ldr r7, [sp, #0x2c]
	cmp r1, r0
	movlt r1, r0
	ldrlt r0, [sp, #0x14]
	sublt r9, r1, r0
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x14]
	movge r9, r4
	sub r0, r1, r0
	cmp r0, #8
	movgt r0, r11
	sub r0, r0, r9
	str r0, [sp, #0x18]
	ldr r0, [sp, #0x30]
	cmp r0, r5
	mov r8, r0
	bge _020CE7B4
_020CE734:
	ldr r0, [sp, #0x38]
	ldr r2, [sp, #0x40]
	str r0, [sp]
	ldr r0, [sp, #0x34]
	ldr r3, [sp, #0x3c]
	str r0, [sp, #4]
	mov r0, r7
	mov r1, r6
	bl GetCharIndex1D
	ldr r2, [sp, #0x1c]
	cmp r8, r10
	sublt r1, r10, r8
	sub r2, r2, r8
	movge r1, r4
	cmp r2, #8
	movgt r2, r11
	sub r3, r2, r1
	ldr r2, [sp, #0x18]
	ldr ip, [sp, #0x48]
	str r2, [sp]
	ldr r2, [sp, #0xc]
	str r2, [sp, #4]
	ldr r2, [sp, #0x44]
	str r2, [sp, #8]
	ldr r2, [sp, #0x28]
	mla r0, ip, r0, r2
	mov r2, r9
	bl ClearChar
	add r8, r8, #8
	add r7, r7, #1
	cmp r8, r5
	blt _020CE734
_020CE7B4:
	ldr r0, [sp, #0x14]
	add r6, r6, #1
	add r1, r0, #8
	ldr r0, [sp, #0x24]
	str r1, [sp, #0x14]
	cmp r1, r0
	blt _020CE6E8
	add sp, sp, #0x54
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end ClearArea1D

	arm_func_start ClearAreaLine
ClearAreaLine: // 0x020CE7D8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x3c
	ldrb r4, [r0, #0xc]
	mov r10, r2
	str r1, [sp, #0xc]
	str r4, [sp, #0x2c]
	ldr r1, [sp, #0x2c]
	ldr r4, [sp, #0x60]
	cmp r1, #4
	add r1, r10, r4
	str r1, [sp, #0x18]
	ldr r2, [sp, #0x64]
	mov r1, r3
	add r1, r1, r2
	str r1, [sp, #0x1c]
	ldrne r1, [sp, #0xc]
	str r3, [sp, #0x10]
	orrne r1, r1, r1, lsl #8
	orrne r1, r1, r1, lsl #16
	strne r1, [sp, #0xc]
	bne _020CE840
	ldr r1, [sp, #0xc]
	orr r1, r1, r1, lsl #4
	orr r1, r1, r1, lsl #8
	orr r1, r1, r1, lsl #16
	str r1, [sp, #0xc]
_020CE840:
	ldr r1, [sp, #0x10]
	bic r1, r1, #7
	mov r2, r1, asr #2
	str r1, [sp, #0x14]
	add r1, r1, r2, lsr #29
	ldr r2, [r0, #0x10]
	mov r3, r1, asr #3
	mul r1, r3, r2
	bic r3, r10, #7
	str r3, [sp, #0x28]
	ldr r3, [sp, #0x2c]
	mov r6, r3, lsl #6
	ldr r3, [sp, #0x28]
	mov r4, r6, asr #2
	mov r5, r3, asr #2
	add r5, r3, r5, lsr #29
	add r4, r6, r4, lsr #29
	mov r3, r4, asr #3
	str r3, [sp, #0x30]
	ldr r3, [sp, #0x1c]
	add r1, r1, r5, asr #3
	add r4, r3, #7
	ldr r3, [r0]
	ldr r0, [sp, #0x18]
	add r5, r0, #7
	ldr r0, [sp, #0x30]
	bic r7, r5, #7
	mla r1, r0, r1, r3
	bic r0, r4, #7
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x30]
	str r1, [sp, #0x24]
	mul r0, r2, r0
	str r0, [sp, #0x34]
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x20]
	cmp r1, r0
	addge sp, sp, #0x3c
	ldmgeia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r5, #0
	mov r4, #8
_020CE8E4:
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x10]
	ldr r6, [sp, #0x24]
	cmp r1, r0
	movlt r1, r0
	ldrlt r0, [sp, #0x14]
	sublt r9, r1, r0
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x14]
	movge r9, r5
	sub r0, r1, r0
	cmp r0, #8
	movgt r0, r4
	sub r11, r0, r9
	ldr r0, [sp, #0x28]
	cmp r0, r7
	mov r8, r0
	bge _020CE980
_020CE92C:
	ldr r0, [sp, #0x18]
	cmp r8, r10
	sublt r1, r10, r8
	sub r0, r0, r8
	movge r1, r5
	cmp r0, #8
	movgt r0, r4
	sub r3, r0, r1
	ldr r0, [sp, #0xc]
	str r11, [sp]
	str r0, [sp, #4]
	ldr r0, [sp, #0x2c]
	mov r2, r9
	str r0, [sp, #8]
	mov r0, r6
	bl ClearChar
	ldr r0, [sp, #0x30]
	add r8, r8, #8
	add r6, r6, r0
	cmp r8, r7
	blt _020CE92C
_020CE980:
	ldr r1, [sp, #0x24]
	ldr r0, [sp, #0x34]
	add r0, r1, r0
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x14]
	add r1, r0, #8
	ldr r0, [sp, #0x20]
	str r1, [sp, #0x14]
	cmp r1, r0
	blt _020CE8E4
	add sp, sp, #0x3c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end ClearAreaLine

	arm_func_start ClearContinuous
ClearContinuous: // 0x020CE9B0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r3, r0
	ldrb r2, [r3, #0xc]
	ldr ip, [r3, #4]
	cmp r2, #4
	orreq r0, r1, r1, lsl #4
	orreq r0, r0, r0, lsl #8
	orreq r1, r0, r0, lsl #16
	orrne r0, r1, r1, lsl #8
	orrne r1, r0, r0, lsl #16
	ldr r0, [r3, #8]
	mov r2, r2, lsl #6
	mul lr, ip, r0
	mov r0, r2, asr #2
	add r0, r2, r0, lsr #29
	mov r2, r0, asr #3
	mov r0, r1
	mul r2, lr, r2
	ldr r1, [r3]
	bl MIi_CpuClearFast
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ClearContinuous

	arm_func_start DrawGlyph1D
DrawGlyph1D: // 0x020CEA0C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x4c
	ldr r7, [sp, #0x74]
	ldrb r5, [r0, #0xc]
	ldr r6, [r1]
	ldr r4, [r7]
	ldr r9, [r6, #8]
	mov r8, r5, lsl #6
	ldrb r4, [r4, #1]
	mov r5, r8, asr #2
	add r5, r8, r5, lsr #29
	ldrb r9, [r9, #1]
	ldr r8, [r0, #4]
	ldr r6, [r0, #8]
	str r2, [sp, #8]
	str r3, [sp, #0xc]
	cmp r4, #0
	mov r5, r5, asr #3
	addeq sp, sp, #0x4c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	adds r3, r2, r4
	addmi sp, sp, #0x4c
	ldmmiia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r2, [sp, #0xc]
	adds r2, r2, r9
	addmi sp, sp, #0x4c
	ldmmiia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r10, [sp, #8]
	add r3, r3, #7
	cmp r10, #0
	movle r10, #0
	strle r10, [sp, #0x10]
	movgt r10, r10, lsr #3
	strgt r10, [sp, #0x10]
	ldr r10, [sp, #0xc]
	add r2, r2, #7
	cmp r10, #0
	movle r10, #0
	mov r11, r2, lsr #3
	mov r3, r3, lsr #3
	movgt r10, r10, lsr #3
	cmp r3, r8
	movhs r3, r8
	cmp r11, r6
	ldr r2, [sp, #0x10]
	movhs r11, r6
	subs r8, r3, r2
	addmi sp, sp, #0x4c
	sub r3, r11, r10
	ldmmiia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r3, #0
	addlt sp, sp, #0x4c
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r2, [sp, #8]
	ldr r6, [r0]
	cmp r2, #0
	andge r2, r2, #7
	strge r2, [sp, #8]
	ldr r2, [sp, #0xc]
	ldr r11, [sp, #8]
	cmp r2, #0
	andge r2, r2, #7
	strge r2, [sp, #0xc]
	sub r8, r11, r8, lsl #3
	ldr r11, [sp, #0xc]
	ldr r2, [sp, #0x70]
	sub r3, r11, r3, lsl #3
	str r3, [sp, #0x14]
	ldr r3, [r7, #4]
	sub r2, r2, #1
	str r3, [sp, #0x28]
	str r2, [sp, #0x48]
	str r9, [sp, #0x38]
	str r4, [sp, #0x34]
	ldr r4, [r1]
	ldr r2, [sp, #0x14]
	mov r3, r11
	cmp r3, r2
	ldr r2, [r4, #8]
	ldrb r3, [r2, #6]
	str r3, [sp, #0x40]
	ldrb r2, [r0, #0xc]
	str r2, [sp, #0x44]
	ldr r1, [r1]
	ldr r1, [r1, #8]
	ldrb r1, [r1]
	mul r1, r3, r1
	str r1, [sp, #0x3c]
	ldr r1, [r0, #0x10]
	str r1, [sp, #0x20]
	ldr r1, [r0, #4]
	ldr r0, [r0, #8]
	ldrb r11, [sp, #0x20]
	ldrb r4, [sp, #0x21]
	str r1, [sp, #0x1c]
	str r0, [sp, #0x18]
	addle sp, sp, #0x4c
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020CEB94:
	ldr r0, [sp, #0xc]
	ldr r7, [sp, #0x10]
	str r0, [sp, #0x30]
	ldr r0, [sp, #8]
	cmp r0, r8
	mov r9, r0
	ble _020CEBF0
_020CEBB0:
	ldr r2, [sp, #0x1c]
	str r11, [sp]
	ldr r3, [sp, #0x18]
	mov r0, r7
	mov r1, r10
	str r4, [sp, #4]
	bl GetCharIndex1D
	mla r1, r0, r5, r6
	add r0, sp, #0x24
	str r9, [sp, #0x2c]
	str r1, [sp, #0x24]
	bl LetterChar
	sub r9, r9, #8
	add r7, r7, #1
	cmp r9, r8
	bgt _020CEBB0
_020CEBF0:
	ldr r0, [sp, #0xc]
	add r10, r10, #1
	sub r1, r0, #8
	ldr r0, [sp, #0x14]
	str r1, [sp, #0xc]
	cmp r1, r0
	bgt _020CEB94
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end DrawGlyph1D

	arm_func_start DrawGlyphLine
DrawGlyphLine: // 0x020CEC14
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2c
	ldr r4, [sp, #0x54]
	ldrb r5, [r0, #0xc]
	str r4, [sp, #0x54]
	ldr r4, [r4]
	ldr r6, [r1]
	mov r7, r5, lsl #6
	ldrb r4, [r4, #1]
	mov r5, r7, asr #2
	add r5, r7, r5, lsr #29
	cmp r4, #0
	ldr r6, [r6, #8]
	mov r9, r3
	ldr r8, [r0, #4]
	ldr r7, [r0, #8]
	mov r10, r2
	mov r5, r5, asr #3
	addeq sp, sp, #0x2c
	ldr lr, [r0]
	ldrb r3, [r6, #1]
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	adds r6, r10, r4
	addmi sp, sp, #0x2c
	ldmmiia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	adds r2, r9, r3
	addmi sp, sp, #0x2c
	ldmmiia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r10, #0
	movle r11, #0
	add r6, r6, #7
	movgt r11, r10, lsr #3
	cmp r9, #0
	movle ip, #0
	add r2, r2, #7
	mov r6, r6, lsr #3
	movgt ip, r9, lsr #3
	cmp r6, r8
	movhs r6, r8
	mov r2, r2, lsr #3
	cmp r2, r7
	movhs r2, r7
	subs r7, r6, r11
	addmi sp, sp, #0x2c
	sub r2, r2, ip
	ldmmiia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r2, #0
	addlt sp, sp, #0x2c
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r6, [r0, #0x10]
	cmp r10, #0
	sub r8, r6, r7
	mul r8, r5, r8
	mla r11, r6, ip, r11
	andge r10, r10, #7
	str r8, [sp]
	ldr r8, [sp, #0x54]
	mla r6, r5, r11, lr
	ldr ip, [r8, #4]
	ldr r11, [sp, #0x50]
	cmp r9, #0
	sub r8, r11, #1
	andge r9, r9, #7
	sub r11, r9, r2, lsl #3
	str ip, [sp, #8]
	str r4, [sp, #0x14]
	str r8, [sp, #0x28]
	str r3, [sp, #0x18]
	ldr r3, [r1]
	cmp r9, r11
	ldr r2, [r3, #8]
	sub r7, r10, r7, lsl #3
	ldrb r2, [r2, #6]
	str r2, [sp, #0x20]
	ldrb r0, [r0, #0xc]
	str r0, [sp, #0x24]
	ldr r0, [r1]
	ldr r0, [r0, #8]
	ldrb r0, [r0]
	mul r0, r2, r0
	str r0, [sp, #0x1c]
	addle sp, sp, #0x2c
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r4, sp, #4
_020CED64:
	mov r8, r10
	str r9, [sp, #0x10]
	cmp r10, r7
	ble _020CED94
_020CED74:
	mov r0, r4
	str r6, [sp, #4]
	str r8, [sp, #0xc]
	bl LetterChar
	sub r8, r8, #8
	cmp r8, r7
	add r6, r6, r5
	bgt _020CED74
_020CED94:
	ldr r0, [sp]
	sub r9, r9, #8
	cmp r9, r11
	add r6, r6, r0
	bgt _020CED64
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end DrawGlyphLine

	arm_func_start LetterChar
LetterChar: // 0x020CEDB0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x34
	ldr r5, [r0, #8]
	ldr r4, [r0, #0xc]
	cmp r5, #0
	strge r5, [sp]
	movlt r1, #0
	strlt r1, [sp]
	ldr r1, [r0, #0x10]
	cmp r4, #0
	add r10, r5, r1
	ldr r1, [r0, #0x14]
	movge r2, r4
	movlt r2, #0
	cmp r10, #8
	add r3, r4, r1
	movge r10, #8
	cmp r3, #8
	movge r3, #8
	cmp r4, #0
	movgt r4, #0
	cmp r5, #0
	ldr r8, [r0, #0x20]
	movgt r5, #0
	rsb r1, r4, #0
	mul r7, r10, r8
	ldr r6, [r0, #0x1c]
	rsb r4, r5, #0
	mul r9, r6, r4
	ldr r4, [r0, #0x18]
	mov r10, r7
	str r4, [sp, #8]
	ldr r4, [sp]
	cmp r8, #4
	mul r5, r4, r8
	ldr r4, [sp, #8]
	str r5, [sp]
	mla r11, r1, r4, r9
	ldr r1, [r0, #4]
	str r1, [sp, #4]
	bne _020CEF28
	ldr r1, [r0]
	ldr r7, [r0, #0x24]
	add r0, r1, r2, lsl #2
	str r0, [sp, #0xc]
	add r0, r1, r3, lsl #2
	ldr r1, [sp, #0xc]
	str r0, [sp, #0x10]
	cmp r1, r0
	addhs sp, sp, #0x34
	ldmhsia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, #0
	add r9, sp, #0x24
	mov r4, #0xf
	str r0, [sp, #0x1c]
_020CEE8C:
	ldr r0, [sp, #0xc]
	mov r1, r11, lsr #0x1f
	ldr r5, [r0]
	ldr r0, [sp, #4]
	rsb r2, r1, r11, lsl #29
	add r0, r0, r11, lsr #3
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x1c]
	add r1, r1, r2, ror #29
	strb r0, [sp, #0x28]
	strb r0, [sp, #0x29]
	mov r0, r9
	bl NNSi_G2dBitReaderRead
	ldr r8, [sp]
	mov r0, r8
	cmp r0, r10
	bhs _020CEEFC
_020CEED0:
	mov r0, r9
	mov r1, r6
	bl NNSi_G2dBitReaderRead
	cmp r0, #0
	mvnne r1, r4, lsl r8
	addne r0, r7, r0
	andne r1, r5, r1
	orrne r5, r1, r0, lsl r8
	add r8, r8, #4
	cmp r8, r10
	blo _020CEED0
_020CEEFC:
	ldr r0, [sp, #0xc]
	add r1, r0, #4
	str r5, [r0]
	ldr r0, [sp, #0x10]
	str r1, [sp, #0xc]
	cmp r1, r0
	ldr r0, [sp, #8]
	add r11, r11, r0
	blo _020CEE8C
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020CEF28:
	ldr r1, [r0]
	ldr r9, [r0, #0x24]
	add r0, r1, r2, lsl #3
	str r0, [sp, #0x14]
	add r0, r1, r3, lsl #3
	ldr r1, [sp, #0x14]
	str r0, [sp, #0x18]
	cmp r1, r0
	addhs sp, sp, #0x34
	ldmhsia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, #0
	mov r4, #0xff
	str r0, [sp, #0x20]
_020CEF5C:
	mov r1, r11, lsr #0x1f
	rsb r0, r1, r11, lsl #29
	add r1, r1, r0, ror #29
	ldr r0, [sp, #0x14]
	ldr r8, [r0]
	ldr r7, [r0, #4]
	ldr r0, [sp, #4]
	add r0, r0, r11, lsr #3
	str r0, [sp, #0x2c]
	ldr r0, [sp, #0x20]
	strb r0, [sp, #0x30]
	strb r0, [sp, #0x31]
	add r0, sp, #0x2c
	bl NNSi_G2dBitReaderRead
	ldr r0, [sp]
	cmp r0, r10
	mov r5, r0
	bhs _020CEFEC
_020CEFA4:
	add r0, sp, #0x2c
	mov r1, r6
	bl NNSi_G2dBitReaderRead
	cmp r0, #0
	beq _020CEFE0
	cmp r5, #0x20
	mvnlo r1, r4, lsl r5
	addlo r0, r9, r0
	andlo r1, r8, r1
	orrlo r8, r1, r0, lsl r5
	subhs r2, r5, #0x20
	mvnhs r1, r4, lsl r2
	addhs r0, r9, r0
	andhs r1, r7, r1
	orrhs r7, r1, r0, lsl r2
_020CEFE0:
	add r5, r5, #8
	cmp r5, r10
	blo _020CEFA4
_020CEFEC:
	ldr r0, [sp, #0x14]
	str r8, [r0]
	add r1, r0, #8
	str r7, [r0, #4]
	ldr r0, [sp, #0x18]
	str r1, [sp, #0x14]
	cmp r1, r0
	ldr r0, [sp, #8]
	add r11, r11, r0
	blo _020CEF5C
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end LetterChar

	arm_func_start ClearChar
ClearChar: // 0x020CF01C
	stmdb sp!, {r4, r5, r6, lr}
	mov lr, r0
	cmp r3, #8
	ldr r0, [sp, #0x14]
	bne _020CF050
	ldr r4, [sp, #0x10]
	cmp r4, #8
	bne _020CF050
	ldr r2, [sp, #0x18]
	mov r1, lr
	mov r2, r2, lsl #3
	bl MIi_CpuClearFast
	ldmia sp!, {r4, r5, r6, pc}
_020CF050:
	ldr r4, [sp, #0x18]
	cmp r4, #4
	bne _020CF0B0
	mov r5, r1, lsl #2
	add r4, r5, r3, lsl #2
	mvn r3, #0
	rsb r4, r4, #0x20
	mov r3, r3, lsr r5
	add r1, r4, r1, lsl #2
	mov r3, r3, lsl r1
	ldr r1, [sp, #0x10]
	add r5, lr, r2, lsl #2
	add r2, r5, r1, lsl #2
	and r6, r0, r3, lsr r4
	cmp r5, r2
	mvn r1, r3, lsr r4
	ldmhsia sp!, {r4, r5, r6, pc}
_020CF094:
	ldr r0, [r5]
	and r0, r0, r1
	orr r0, r6, r0
	str r0, [r5], #4
	cmp r5, r2
	blo _020CF094
	ldmia sp!, {r4, r5, r6, pc}
_020CF0B0:
	mov ip, r1, lsl #3
	add r1, ip, r3, lsl #3
	rsb r1, r1, #0x40
	mvn r3, #0
	cmp r1, #0x20
	mov r5, r3, lsr ip
	subhs r4, r1, #0x20
	addhs r3, ip, r4
	movhs r3, r5, lsl r3
	movhs r3, r3, lsr r4
	movlo r3, r5, lsl ip
	mvn r4, #0
	add r5, lr, r2, lsl #3
	cmp ip, #0x20
	mov r4, r4, lsl r1
	subhs ip, ip, #0x20
	addhs r1, ip, r1
	movhs r1, r4, lsr r1
	movhs r6, r1, lsl ip
	movlo r6, r4, lsr r1
	ldr r1, [sp, #0x10]
	and lr, r0, r3
	add r4, r5, r1, lsl #3
	cmp r5, r4
	and ip, r0, r6
	mvn r2, r3
	mvn r1, r6
	ldmhsia sp!, {r4, r5, r6, pc}
_020CF120:
	ldr r0, [r5]
	and r0, r0, r2
	orr r0, lr, r0
	str r0, [r5]
	ldr r0, [r5, #4]
	and r0, r0, r1
	orr r0, ip, r0
	str r0, [r5, #4]
	add r5, r5, #8
	cmp r5, r4
	blo _020CF120
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ClearChar

	arm_func_start OBJSizeToShape
OBJSizeToShape: // 0x020CF150
	ldrb r3, [r0, #1]
	ldr r2, _020CF168 // =shape
	ldrb r1, [r0]
	add r0, r2, r3, lsl #4
	ldr r0, [r0, r1, lsl #2]
	bx lr
	.align 2, 0
_020CF168: .word shape
	arm_func_end OBJSizeToShape

	arm_func_start GetCharIndex1D
GetCharIndex1D: // 0x020CF16C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r11, _020CF268 // =objs
	mov r9, #0
	mov r10, #3
	mvn r7, #0
_020CF184:
	ldr r4, [sp, #0x2c]
	ldr r6, [sp, #0x28]
	and ip, r3, r7, lsl r4
	cmp ip, r1
	mov r8, r7, lsl r6
	mov r5, r7, lsl r4
	and lr, r2, r7, lsl r6
	bhi _020CF1D4
	mla r9, r2, ip, r9
	cmp lr, r0
	movhi r2, lr
	subhi r1, r1, ip
	subhi r3, r3, ip
	bhi _020CF21C
	sub r3, r3, ip
	mla r9, lr, r3, r9
	sub r0, r0, lr
	sub r1, r1, ip
	sub r2, r2, lr
	b _020CF21C
_020CF1D4:
	cmp lr, r0
	mlals r9, lr, ip, r9
	mvn r3, r5
	movls r3, ip
	subls r0, r0, lr
	subls r2, r2, lr
	bls _020CF21C
	and r2, r1, r5
	mla r5, lr, r2, r9
	and r2, r0, r8
	and r1, r1, r3
	add r2, r5, r2, lsl r4
	mvn r3, r8
	add r1, r2, r1, lsl r6
	and r0, r0, r3
	add sp, sp, #4
	add r0, r1, r0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020CF21C:
	cmp r2, #8
	movlt r4, r2
	movge r5, r10
	clzlt r4, r4
	rsblt r5, r4, #0x1f
	cmp r3, #8
	movge r4, r10
	movlt r4, r3
	clzlt r4, r4
	rsblt r4, r4, #0x1f
	add r4, r11, r4, lsl #3
	add r6, r4, r5, lsl #1
	ldrb r5, [r4, r5, lsl #1]
	ldrb r4, [r6, #1]
	str r5, [sp, #0x28]
	str r4, [sp, #0x2c]
	b _020CF184
_020CF260:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020CF268: .word objs
	arm_func_end GetCharIndex1D

	.rodata

objs: // 0x021127C4
    .byte 0, 0
    .byte 1, 0
    .byte 2, 0
    .byte 2, 0
    .byte 0, 1
    .byte 1, 1
    .byte 2, 1
    .byte 2, 1
    .byte 0, 2
    .byte 1, 2
    .byte 2, 2
    .byte 3, 2
    .byte 0, 2
    .byte 1, 2
    .byte 2, 3
    .byte 3, 3

shape: // 0x021127E4       
    .word 0x00000000, 0x00004000 // GX_OAM_SHAPE_8x8, GX_OAM_SHAPE_16x8
    .word 0x40004000, 0x00000000 // GX_OAM_SHAPE_32x8, GX_OAM_SHAPE_8x8
    .word 0x00008000, 0x40000000 // GX_OAM_SHAPE_8x16, GX_OAM_SHAPE_16x16
    .word 0x80004000, 0x00000000 // GX_OAM_SHAPE_32x16, GX_OAM_SHAPE_8x8
    .word 0x40008000, 0x80008000 // GX_OAM_SHAPE_8x32, GX_OAM_SHAPE_16x32
    .word 0x80000000, 0xC0004000 // GX_OAM_SHAPE_32x32, GX_OAM_SHAPE_64x32
    .word 0x00000000, 0x00000000 // GX_OAM_SHAPE_8x8, GX_OAM_SHAPE_8x8
    .word 0xC0008000, 0xC0000000 // GX_OAM_SHAPE_32x64, GX_OAM_SHAPE_64x64