	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start FontWindowMWControl__Init
FontWindowMWControl__Init: // 0x0205A308
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl FontAnimatorCore__Init
	mov r0, #0
	str r0, [r4, #8]
	mov r1, #3
	str r1, [r4, #0xc]
	str r0, [r4, #0x20]
	add r1, r4, #0x34
	mov r2, #0x20
	str r0, [r4, #0x30]
	bl MIi_CpuClear32
	ldmia sp!, {r4, pc}
	arm_func_end FontWindowMWControl__Init

	arm_func_start FontWindowMWControl__Load
FontWindowMWControl__Load: // 0x0205A33C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r9, r0
	mov r8, r1
	mov r4, r2
	mov r7, r3
	ldr r6, [sp, #0x30]
	bl FontWindowMWControl__Release
	mov r0, r9
	mov r1, r8
	bl FontAnimatorCore__LoadFont
	str r4, [r9, #8]
	mov r0, #0
	str r0, [r9, #0xc]
	str r6, [r9, #0x10]
	strh r0, [r9, #0x14]
	strh r0, [r9, #0x16]
	ldrh r1, [sp, #0x28]
	ldrh r0, [sp, #0x2c]
	strh r1, [r9, #0x18]
	strh r0, [r9, #0x1a]
	ldrb r1, [sp, #0x34]
	ldrb r0, [sp, #0x38]
	strb r1, [r9, #0x1c]
	strb r0, [r9, #0x1d]
	ldrb r1, [sp, #0x3c]
	mov r0, r8
	strb r1, [r9, #0x1e]
	mov r1, r7
	strh r7, [r9, #0x2e]
	bl FontWindow__GetMWBackground
	ldr r1, _0205A4CC // =FontWindowMWControl__TileCounts
	mov r2, r7, lsl #1
	ldrh r1, [r1, r2]
	mov r4, r0
	mov r0, r1, lsl #5
	strh r1, [r9, #0x2c]
	bl _AllocHeadHEAP_USER
	ldr r2, _0205A4D0 // =FontWindowMWControl__WindowFuncs
	mov r1, r4
	ldr r2, [r2, r7, lsl #2]
	str r0, [r9, #0x30]
	blx r2
	cmp r6, #0
	ldrh r0, [r9, #0x2c]
	bne _0205A408
	mov r1, #0x4000000
	ldr r2, [r1, #0]
	ldr r1, _0205A4D4 // =0x00300010
	mov r4, #0x6400000
	b _0205A418
_0205A408:
	ldr r2, _0205A4D8 // =0x04001000
	ldr r1, _0205A4D4 // =0x00300010
	ldr r2, [r2, #0]
	mov r4, #0x6600000
_0205A418:
	and r2, r2, r1
	cmp r2, #0x10
	beq _0205A440
	ldr r1, _0205A4DC // =0x00100010
	cmp r2, r1
	beq _0205A448
	add r1, r1, #0x100000
	cmp r2, r1
	moveq r5, #2
	b _0205A44C
_0205A440:
	mov r5, #0
	b _0205A44C
_0205A448:
	mov r5, #1
_0205A44C:
	mov r1, r0, lsr r5
	mov r0, r6
	bl VRAMSystem__AllocSpriteVram
	str r0, [r9, #0x20]
	mov r0, #0
	str r0, [r9, #0x28]
	ldr r1, [r9, #0x20]
	mov r0, #4
	sub r2, r1, r4
	add r1, r5, #5
	mov r1, r2, lsr r1
	cmp r6, #0
	ldreq r4, _0205A4E0 // =0x05000200
	strh r1, [r9, #0x24]
	mov r0, r0, asr r5
	strh r0, [r9, #0x26]
	ldrb r2, [sp, #0x3c]
	ldrne r4, _0205A4E4 // =0x05000600
	mov r0, r8
	mov r1, r7
	add r4, r4, r2, lsl #5
	bl FontWindow__GetMWPaletteAnimation
	mov r2, #0
	mov r1, r0
	mov r3, r2
	add r0, r9, #0x34
	stmia sp, {r2, r4}
	bl InitPaletteAnimator
	mov r0, r9
	bl FontWindowMWControl__ApplyPaletteAnimFlags
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0205A4CC: .word FontWindowMWControl__TileCounts
_0205A4D0: .word FontWindowMWControl__WindowFuncs
_0205A4D4: .word 0x00300010
_0205A4D8: .word 0x04001000
_0205A4DC: .word 0x00100010
_0205A4E0: .word 0x05000200
_0205A4E4: .word 0x05000600
	arm_func_end FontWindowMWControl__Load
	
	arm_func_start FontWindowMWControl__Release
FontWindowMWControl__Release: // 0x0205A4E8
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x34
	bl ReleasePaletteAnimator
	ldr r1, [r4, #0x20]
	cmp r1, #0
	beq _0205A514
	ldr r0, [r4, #0x10]
	bl VRAMSystem__FreeSpriteVram
	mov r0, #0
	str r0, [r4, #0x20]
_0205A514:
	ldr r0, [r4, #0x30]
	cmp r0, #0
	beq _0205A52C
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x30]
_0205A52C:
	mov r0, r4
	bl FontAnimatorCore__Release
	mov r0, r4
	bl FontWindowMWControl__Init
	ldmia sp!, {r4, pc}
	arm_func_end FontWindowMWControl__Release

	arm_func_start FontWindowMWControl__SetPaletteAnim
FontWindowMWControl__SetPaletteAnim: // 0x0205A540
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0xc]
	mov r4, r1
	cmp r0, r4
	beq _0205A588
	cmp r4, #0
	beq _0205A56C
	cmp r4, #1
	beq _0205A57C
	b _0205A588
_0205A56C:
	add r0, r5, #0x34
	mov r1, #0
	bl SetPaletteAnimation
	b _0205A588
_0205A57C:
	add r0, r5, #0x34
	mov r1, #1
	bl SetPaletteAnimation
_0205A588:
	str r4, [r5, #0xc]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end FontWindowMWControl__SetPaletteAnim

	arm_func_start FontWindowMWControl__ValidatePaletteAnim
FontWindowMWControl__ValidatePaletteAnim: // 0x0205A590
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0xc]
	cmp r1, #0
	beq _0205A5AC
	cmp r1, #1
	beq _0205A5BC
	ldmia sp!, {r3, pc}
_0205A5AC:
	add r0, r0, #0x34
	mov r1, #0
	bl SetPaletteAnimation
	ldmia sp!, {r3, pc}
_0205A5BC:
	add r0, r0, #0x34
	mov r1, #1
	bl SetPaletteAnimation
	ldmia sp!, {r3, pc}
	arm_func_end FontWindowMWControl__ValidatePaletteAnim

	arm_func_start FontWindowMWControl__SetPosition
FontWindowMWControl__SetPosition: // 0x0205A5CC
	strh r1, [r0, #0x14]
	strh r2, [r0, #0x16]
	bx lr
	arm_func_end FontWindowMWControl__SetPosition

	arm_func_start FontWindowMWControl__SetOffset
FontWindowMWControl__SetOffset: // 0x0205A5D8
	strh r1, [r0, #0x18]
	strh r2, [r0, #0x1a]
	bx lr
	arm_func_end FontWindowMWControl__SetOffset

	arm_func_start FontWindowMWControl__GetOffset
FontWindowMWControl__GetOffset: // 0x0205A5E4
	cmp r1, #0
	ldrneh r3, [r0, #0x18]
	strneh r3, [r1]
	cmp r2, #0
	ldrneh r0, [r0, #0x1a]
	strneh r0, [r2]
	bx lr
	arm_func_end FontWindowMWControl__GetOffset

	arm_func_start FontWindowMWControl__Draw
FontWindowMWControl__Draw: // 0x0205A600
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl FontWindowMWControl__RenderPixels
	add r0, r4, #0x34
	bl AnimatePalette
	add r0, r4, #0x34
	bl DrawAnimatedPalette
	ldmia sp!, {r4, pc}
	arm_func_end FontWindowMWControl__Draw

	arm_func_start FontWindowMWControl__CallWindowFunc2
FontWindowMWControl__CallWindowFunc2: // 0x0205A620
	stmdb sp!, {r3, lr}
	ldrh r2, [r0, #0x2e]
	ldr r1, _0205A638 // =FontWindowMWControl__WindowFuncs2
	ldr r1, [r1, r2, lsl #2]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0205A638: .word FontWindowMWControl__WindowFuncs2
	arm_func_end FontWindowMWControl__CallWindowFunc2

	arm_func_start FontWindowMWControl__ApplyPaletteAnimFlags
FontWindowMWControl__ApplyPaletteAnimFlags: // 0x0205A63C
	ldr r2, [r0, #8]
	mov r1, #2
	tst r2, #1
	orrne r1, r1, #4
	movne r1, r1, lsl #0x10
	movne r1, r1, lsr #0x10
	tst r2, #4
	orrne r1, r1, #8
	movne r1, r1, lsl #0x10
	movne r1, r1, lsr #0x10
	strh r1, [r0, #0x34]
	bx lr
	arm_func_end FontWindowMWControl__ApplyPaletteAnimFlags

	arm_func_start FontWindowMWControl__WindowFunc_205A66C
FontWindowMWControl__WindowFunc_205A66C: // 0x0205A66C
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mov r6, r0
	mov r0, r5
	bl GetBackgroundPixels
	ldr r0, [r0, #0]
	mov r0, r0, lsr #8
	bl _AllocTailHEAP_USER
	mov r4, r0
	mov r0, r5
	bl GetBackgroundPixels
	mov r1, r4
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	mov r1, r6
	mov r2, #0x20
	bl MIi_CpuCopyFast
	mov r0, #0
	add r1, r6, #0x20
	mov r2, #0x60
	bl MIi_CpuClearFast
	add r0, r4, #0x20
	add r1, r6, #0x80
	mov r2, #0x20
	bl MIi_CpuCopyFast
	add r0, r4, #0x20
	add r1, r6, #0xa0
	mov r2, #0x20
	bl MIi_CpuCopyFast
	add r0, r6, #0x80
	add r1, r6, #0xc0
	mov r2, #0x40
	bl MIi_CpuCopyFast
	add r0, r4, #0x40
	add r1, r6, #0x100
	mov r2, #0x20
	bl MIi_CpuCopyFast
	add r0, r4, #0x40
	add r1, r6, #0x120
	mov r2, #0x20
	bl MIi_CpuCopyFast
	add r0, r6, #0x100
	add r1, r6, #0x140
	mov r2, #0x40
	bl MIi_CpuCopyFast
	mov r0, r4
	bl _FreeHEAP_USER
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end FontWindowMWControl__WindowFunc_205A66C

	arm_func_start FontWindowMWControl__WindowFunc_205A72C
FontWindowMWControl__WindowFunc_205A72C: // 0x0205A72C
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mov r6, r0
	mov r0, r5
	bl GetBackgroundPixels
	ldr r0, [r0, #0]
	mov r0, r0, lsr #8
	bl _AllocTailHEAP_USER
	mov r4, r0
	mov r0, r5
	bl GetBackgroundPixels
	mov r1, r4
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	mov r1, r6
	mov r2, #0x20
	bl MIi_CpuCopyFast
	mov r0, r4
	add r1, r6, #0x20
	mov r2, #0
	mov r3, #1
	bl BackgroundUnknown__Func_204CD20
	mov r0, #0
	add r1, r6, #0x40
	mov r2, #0x40
	bl MIi_CpuClearFast
	mov r0, r4
	add r1, r6, #0x80
	mov r2, #0x20
	bl MIi_CpuCopyFast
	mov r0, r4
	add r1, r6, #0xa0
	mov r2, #1
	mov r3, #0
	bl BackgroundUnknown__Func_204CD20
	mov r0, #0
	add r1, r6, #0xc0
	mov r2, #0x40
	bl MIi_CpuClearFast
	add r0, r4, #0x20
	add r1, r6, #0x100
	mov r2, #0x20
	bl MIi_CpuCopyFast
	add r0, r4, #0x20
	add r1, r6, #0x120
	mov r2, #0x20
	bl MIi_CpuCopyFast
	add r0, r6, #0x100
	add r1, r6, #0x140
	mov r2, #0x40
	bl MIi_CpuCopyFast
	mov r0, r4
	bl _FreeHEAP_USER
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end FontWindowMWControl__WindowFunc_205A72C

	arm_func_start FontWindowMWControl__WindowFunc_205A804
FontWindowMWControl__WindowFunc_205A804: // 0x0205A804
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mov r6, r0
	mov r0, r5
	bl GetBackgroundPixels
	ldr r0, [r0, #0]
	mov r0, r0, lsr #8
	bl _AllocTailHEAP_USER
	mov r4, r0
	mov r0, r5
	bl GetBackgroundPixels
	mov r1, r4
	bl RenderCore_CPUCopyCompressed
	add r0, r4, #0x20
	mov r1, r6
	mov r2, #0x20
	bl MIi_CpuCopyFast
	add r0, r4, #0x20
	add r1, r6, #0x20
	mov r2, #0
	mov r3, #1
	bl BackgroundUnknown__Func_204CD20
	mov r0, #0
	add r1, r6, #0x40
	mov r2, #0x40
	bl MIi_CpuClearFast
	add r0, r4, #0x20
	add r1, r6, #0x80
	mov r2, #0x20
	bl MIi_CpuCopyFast
	add r0, r4, #0x20
	add r1, r6, #0xa0
	mov r2, #1
	mov r3, #0
	bl BackgroundUnknown__Func_204CD20
	mov r0, #0
	add r1, r6, #0xc0
	mov r2, #0x40
	bl MIi_CpuClearFast
	add r0, r4, #0x20
	add r1, r6, #0x100
	mov r2, #0x20
	bl MIi_CpuCopyFast
	add r0, r4, #0x20
	add r1, r6, #0x120
	mov r2, #0x20
	bl MIi_CpuCopyFast
	add r0, r6, #0x100
	add r1, r6, #0x140
	mov r2, #0x40
	bl MIi_CpuCopyFast
	mov r0, r4
	bl _FreeHEAP_USER
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end FontWindowMWControl__WindowFunc_205A804

	arm_func_start FontWindowMWControl__RenderPixels
FontWindowMWControl__RenderPixels: // 0x0205A8DC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x28]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #8]
	tst r0, #2
	ldmneia sp!, {r4, pc}
	tst r0, #8
	ldrh r1, [r4, #0x2c]
	mov r2, #0
	ldr r0, [r4, #0x30]
	beq _0205A920
	ldr r3, [r4, #0x20]
	mov r1, r1, lsl #5
	bl LoadUncompressedPixels
	b _0205A92C
_0205A920:
	ldr r3, [r4, #0x20]
	mov r1, r1, lsl #5
	bl QueueUncompressedPixels
_0205A92C:
	mov r0, #1
	str r0, [r4, #0x28]
	ldmia sp!, {r4, pc}
	arm_func_end FontWindowMWControl__RenderPixels

	arm_func_start FontWindowMWControl__WindowFunc2_205A938
FontWindowMWControl__WindowFunc2_205A938: // 0x0205A938
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r10, r0
	ldrsh r4, [r10, #0x14]
	ldrsh r5, [r10, #0x16]
	ldrh r6, [r10, #0x18]
	sub r11, r4, #8
	sub r0, r5, #8
	mov r1, r11, lsl #0x10
	mov r2, r0, lsl #0x10
	str r0, [sp, #4]
	cmp r6, #8
	ldrh r7, [r10, #0x1a]
	mov r3, #0
	movlo r6, #8
	cmp r7, #8
	mov r0, r10
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	movlo r7, #8
	str r3, [sp]
	bl FontWindowMWControl__Func_205AA90
	ldr r0, [sp, #4]
	add r9, r4, r6
	mov r0, r0, lsl #0x10
	mov r1, r9, lsl #0x10
	mov r2, r0, asr #0x10
	mov r0, #0
	str r0, [sp]
	mov r1, r1, asr #0x10
	mov r0, r10
	mov r3, #1
	bl FontWindowMWControl__Func_205AA90
	add r8, r5, r7
	mov r0, #1
	mov r1, r11, lsl #0x10
	mov r2, r8, lsl #0x10
	str r0, [sp]
	mov r0, r10
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	mov r3, #0
	bl FontWindowMWControl__Func_205AA90
	mov r1, r9, lsl #0x10
	mov r2, r8, lsl #0x10
	mov r3, #1
	mov r0, r10
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	str r3, [sp]
	bl FontWindowMWControl__Func_205AA90
	ldr r0, [sp, #4]
	mov r1, r4
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	mov r0, #0
	str r0, [sp]
	mov r0, r10
	mov r3, r6
	bl FontWindowMWControl__Func_205AB14
	mov r0, r8, lsl #0x10
	mov r2, r0, asr #0x10
	mov r0, #1
	str r0, [sp]
	mov r1, r4
	mov r3, r6
	mov r0, r10
	bl FontWindowMWControl__Func_205AB14
	mov r0, r11, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, #0
	str r0, [sp]
	mov r0, r10
	mov r2, r5
	mov r3, r7
	bl FontWindowMWControl__Func_205AD4C
	mov r1, r9, lsl #0x10
	mov r4, #1
	mov r0, r10
	mov r1, r1, asr #0x10
	mov r2, r5
	mov r3, r7
	str r4, [sp]
	bl FontWindowMWControl__Func_205AD4C
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end FontWindowMWControl__WindowFunc2_205A938

	arm_func_start FontWindowMWControl__Func_205AA90
FontWindowMWControl__Func_205AA90: // 0x0205AA90
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r5, r0
	mov r8, r1
	ldrb r1, [r5, #0x1d]
	ldr r0, [r5, #0x10]
	ldrh r4, [r5, #0x24]
	mov r7, r2
	mov r6, r3
	bl OAMSystem__Alloc
	ldr r1, _0205AB0C // =0x000001FF
	and r2, r7, #0xff
	strh r2, [r0]
	and r1, r8, r1
	strh r1, [r0, #2]
	cmp r6, #0
	ldrneh r1, [r0, #2]
	orrne r1, r1, #0x1000
	strneh r1, [r0, #2]
	ldr r1, [sp, #0x18]
	cmp r1, #0
	ldrneh r1, [r0, #2]
	orrne r1, r1, #0x2000
	strneh r1, [r0, #2]
	ldr r1, _0205AB10 // =0x000003FF
	ldrb r2, [r5, #0x1c]
	and r1, r4, r1
	ldrb r3, [r5, #0x1e]
	orr r1, r1, r2, lsl #10
	orr r1, r1, r3, lsl #12
	strh r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0205AB0C: .word 0x000001FF
_0205AB10: .word 0x000003FF
	arm_func_end FontWindowMWControl__Func_205AA90

	arm_func_start FontWindowMWControl__Func_205AB14
FontWindowMWControl__Func_205AB14: // 0x0205AB14
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r10, r0
	ldrh r5, [r10, #0x24]
	ldrh r4, [r10, #0x26]
	ldr r0, [sp, #0x30]
	mov r9, r1
	add r1, r5, r4
	cmp r0, #0
	mov r0, r1, lsl #0x10
	str r2, [sp]
	mov r6, #0
	str r0, [sp, #4]
	orrne r0, r6, #0x2000
	movne r0, r0, lsl #0x10
	movne r6, r0, lsr #0x10
	ldrb r0, [r10, #0x1e]
	mov r8, r3
	ldrb r1, [r10, #0x1c]
	mov r0, r0, lsl #0xc
	cmp r8, #0x20
	orr r0, r0, r1, lsl #10
	mov r0, r0, lsl #0x10
	str r0, [sp, #8]
	blo _0205ABF0
	ldr r0, [sp]
	ldr r2, _0205AD44 // =0x000003FF
	and r3, r0, #0xff
	ldr r0, [sp, #4]
	orr r3, r3, #0x4000
	and r1, r2, r0, lsr #16
	ldr r0, [sp, #8]
	orr r7, r6, #0x4000
	orr r1, r1, r0, lsr #16
	mov r0, r3, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r5, r0, lsr #0x10
	mov r4, r1, lsr #0x10
	sub r11, r2, #0x200
_0205ABB0:
	ldrb r1, [r10, #0x1d]
	ldr r0, [r10, #0x10]
	bl OAMSystem__Alloc
	and r2, r9, r11
	sub r1, r8, #0x20
	orr r2, r2, r7
	mov r1, r1, lsl #0x10
	mov r8, r1, lsr #0x10
	strh r5, [r0]
	strh r2, [r0, #2]
	add r1, r9, #0x20
	strh r4, [r0, #4]
	mov r0, r1, lsl #0x10
	cmp r8, #0x20
	mov r9, r0, asr #0x10
	bhs _0205ABB0
_0205ABF0:
	cmp r8, #0x10
	blo _0205AC6C
	ldr r0, [sp]
	ldr r2, _0205AD44 // =0x000003FF
	and r3, r0, #0xff
	ldr r0, [sp, #4]
	orr r3, r3, #0x4000
	and r1, r2, r0, lsr #16
	ldr r0, [sp, #8]
	sub r7, r2, #0x200
	orr r1, r1, r0, lsr #16
	mov r0, r3, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r5, r0, lsr #0x10
	mov r4, r1, lsr #0x10
_0205AC2C:
	ldrb r1, [r10, #0x1d]
	ldr r0, [r10, #0x10]
	bl OAMSystem__Alloc
	and r3, r9, r7
	sub r1, r8, #0x10
	mov r1, r1, lsl #0x10
	add r2, r9, #0x10
	orr r3, r3, r6
	mov r8, r1, lsr #0x10
	mov r1, r2, lsl #0x10
	mov r9, r1, asr #0x10
	strh r5, [r0]
	strh r3, [r0, #2]
	strh r4, [r0, #4]
	cmp r8, #0x10
	bhs _0205AC2C
_0205AC6C:
	cmp r8, #8
	blo _0205ACE4
	ldr r0, [sp]
	ldr r2, _0205AD44 // =0x000003FF
	and r3, r0, #0xff
	ldr r0, [sp, #4]
	sub r7, r2, #0x200
	and r1, r2, r0, lsr #16
	ldr r0, [sp, #8]
	orr r1, r1, r0, lsr #16
	mov r0, r3, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r5, r0, lsr #0x10
	mov r4, r1, lsr #0x10
_0205ACA4:
	ldrb r1, [r10, #0x1d]
	ldr r0, [r10, #0x10]
	bl OAMSystem__Alloc
	and r3, r9, r7
	sub r1, r8, #8
	mov r1, r1, lsl #0x10
	add r2, r9, #8
	orr r3, r3, r6
	mov r8, r1, lsr #0x10
	mov r1, r2, lsl #0x10
	mov r9, r1, asr #0x10
	strh r5, [r0]
	strh r3, [r0, #2]
	strh r4, [r0, #4]
	cmp r8, #8
	bhs _0205ACA4
_0205ACE4:
	cmp r8, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	rsb r0, r8, #8
	sub r2, r9, r0
	ldrb r1, [r10, #0x1d]
	ldr r0, [r10, #0x10]
	mov r4, r2, lsl #0x10
	bl OAMSystem__Alloc
	ldr r1, [sp]
	ldr r2, _0205AD48 // =0x000001FF
	and r5, r1, #0xff
	and r3, r2, r4, asr #16
	ldr r1, [sp, #4]
	add r2, r2, #0x200
	and r2, r2, r1, lsr #16
	strh r5, [r0]
	orr r1, r3, r6
	strh r1, [r0, #2]
	ldr r1, [sp, #8]
	orr r1, r2, r1, lsr #16
	strh r1, [r0, #4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0205AD44: .word 0x000003FF
_0205AD48: .word 0x000001FF
	arm_func_end FontWindowMWControl__Func_205AB14

	arm_func_start FontWindowMWControl__Func_205AD4C
FontWindowMWControl__Func_205AD4C: // 0x0205AD4C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r7, r0
	ldrh r5, [r7, #0x24]
	ldrh r4, [r7, #0x26]
	ldr r0, [sp, #0x28]
	mov r6, r2
	str r1, [sp]
	add r1, r5, r4, lsl #1
	mov r4, #0
	cmp r0, #0
	orrne r0, r4, #0x1000
	movne r0, r0, lsl #0x10
	movne r4, r0, lsr #0x10
	ldrb r0, [r7, #0x1e]
	mov r8, r1, lsl #0x10
	mov r5, r3
	ldrb r1, [r7, #0x1c]
	mov r0, r0, lsl #0xc
	cmp r5, #0x20
	orr r0, r0, r1, lsl #10
	mov r11, r0, lsl #0x10
	blo _0205AE14
	ldr r1, _0205AF4C // =0x000001FF
	ldr r0, [sp]
	add r2, r1, #0x200
	and r1, r0, r1
	orr r3, r4, #0x4000
	and r0, r2, r8, lsr #16
	orr r2, r1, r3
	orr r1, r0, r11, lsr #16
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r10, r0, lsr #0x10
	mov r9, r1, lsr #0x10
_0205ADD4:
	ldrb r1, [r7, #0x1d]
	ldr r0, [r7, #0x10]
	bl OAMSystem__Alloc
	and r1, r6, #0xff
	orr r2, r1, #0x8000
	sub r1, r5, #0x20
	strh r2, [r0]
	mov r1, r1, lsl #0x10
	add r2, r6, #0x20
	strh r10, [r0, #2]
	mov r5, r1, lsr #0x10
	mov r1, r2, lsl #0x10
	strh r9, [r0, #4]
	cmp r5, #0x20
	mov r6, r1, asr #0x10
	bhs _0205ADD4
_0205AE14:
	cmp r5, #0x10
	blo _0205AE88
	ldr r1, _0205AF4C // =0x000001FF
	ldr r0, [sp]
	add r2, r1, #0x200
	and r1, r0, r1
	and r0, r2, r8, lsr #16
	orr r2, r1, r4
	orr r1, r0, r11, lsr #16
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r10, r0, lsr #0x10
	mov r9, r1, lsr #0x10
_0205AE48:
	ldrb r1, [r7, #0x1d]
	ldr r0, [r7, #0x10]
	bl OAMSystem__Alloc
	and r1, r6, #0xff
	orr r2, r1, #0x8000
	sub r1, r5, #0x10
	strh r2, [r0]
	mov r1, r1, lsl #0x10
	add r2, r6, #0x10
	strh r10, [r0, #2]
	mov r5, r1, lsr #0x10
	mov r1, r2, lsl #0x10
	strh r9, [r0, #4]
	cmp r5, #0x10
	mov r6, r1, asr #0x10
	bhs _0205AE48
_0205AE88:
	cmp r5, #8
	blo _0205AEF8
	ldr r1, _0205AF4C // =0x000001FF
	ldr r0, [sp]
	add r2, r1, #0x200
	and r1, r0, r1
	and r0, r2, r8, lsr #16
	orr r2, r1, r4
	orr r1, r0, r11, lsr #16
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r10, r0, lsr #0x10
	mov r9, r1, lsr #0x10
_0205AEBC:
	ldrb r1, [r7, #0x1d]
	ldr r0, [r7, #0x10]
	bl OAMSystem__Alloc
	and r2, r6, #0xff
	sub r1, r5, #8
	strh r2, [r0]
	mov r1, r1, lsl #0x10
	add r2, r6, #8
	strh r10, [r0, #2]
	mov r5, r1, lsr #0x10
	mov r1, r2, lsl #0x10
	strh r9, [r0, #4]
	cmp r5, #8
	mov r6, r1, asr #0x10
	bhs _0205AEBC
_0205AEF8:
	cmp r5, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	rsb r0, r5, #8
	sub r0, r6, r0
	mov r2, r0, lsl #0x10
	ldrb r1, [r7, #0x1d]
	ldr r0, [r7, #0x10]
	mov r6, r2, asr #0x10
	bl OAMSystem__Alloc
	ldr r2, _0205AF4C // =0x000001FF
	ldr r1, [sp]
	and r5, r6, #0xff
	and r3, r1, r2
	add r1, r2, #0x200
	and r1, r1, r8, lsr #16
	strh r5, [r0]
	orr r2, r3, r4
	strh r2, [r0, #2]
	orr r1, r1, r11, lsr #16
	strh r1, [r0, #4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0205AF4C: .word 0x000001FF
	arm_func_end FontWindowMWControl__Func_205AD4C

	arm_func_start FontWindowMWControl__WindowFunc2_205AF50
FontWindowMWControl__WindowFunc2_205AF50: // 0x0205AF50
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r10, r0
	ldrh r0, [r10, #0x18]
	mov r3, #0
	str r0, [sp, #4]
	ldrsh r4, [r10, #0x14]
	mov r0, r0
	cmp r0, #0x10
	ldrsh r5, [r10, #0x16]
	movlo r0, #0x10
	strlo r0, [sp, #4]
	ldrh r7, [r10, #0x1a]
	ldr r0, [sp, #4]
	cmp r7, #0x10
	movlo r7, #0x10
	add r1, r4, r0
	add r0, r5, r7
	sub r2, r1, #8
	sub r1, r0, #8
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	cmp r7, #0x10
	mov r9, r0, asr #0x10
	mov r6, r1, asr #0x10
	bne _0205B000
	mov r0, r10
	mov r1, r4
	mov r2, r5
	bl FontWindowMWControl__Func_205B250
	mov r0, r10
	mov r1, r9
	mov r2, r5
	mov r3, #1
	bl FontWindowMWControl__Func_205B250
	ldr r0, [sp, #4]
	add r2, r4, #8
	sub r1, r0, #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r4, r0, asr #0x10
	mov r0, r1, lsr #0x10
	str r0, [sp, #4]
	b _0205B170
_0205B000:
	ldr r0, [sp, #4]
	cmp r0, #0x10
	mov r0, r10
	bne _0205B04C
	mov r1, r4
	mov r2, r5
	bl FontWindowMWControl__Func_205B2E0
	mov r0, r10
	mov r1, r4
	mov r2, r6
	mov r3, #1
	bl FontWindowMWControl__Func_205B2E0
	add r0, r5, #8
	sub r1, r7, #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r5, r0, asr #0x10
	mov r7, r1, lsr #0x10
	b _0205B170
_0205B04C:
	mov r1, r4
	mov r2, r5
	str r3, [sp]
	bl FontWindowMWControl__Func_205B1B0
	mov r2, #0
	str r2, [sp]
	mov r0, r10
	mov r1, r9
	mov r2, r5
	mov r3, #1
	bl FontWindowMWControl__Func_205B1B0
	mov r0, #1
	str r0, [sp]
	mov r0, r10
	mov r1, r4
	mov r2, r6
	mov r3, #0
	bl FontWindowMWControl__Func_205B1B0
	mov r3, #1
	mov r0, r10
	mov r1, r9
	mov r2, r6
	str r3, [sp]
	bl FontWindowMWControl__Func_205B1B0
	add r8, r4, #8
	cmp r8, r9
	bge _0205B158
	mov r11, #1
_0205B0BC:
	sub r0, r9, r8
	cmp r0, #0x10
	blt _0205B110
	mov r0, #1
	mov r1, r8, lsl #0x10
	str r0, [sp]
	mov r0, r10
	mov r1, r1, asr #0x10
	mov r2, r5
	mov r3, #2
	bl FontWindowMWControl__SetSprite
	mov r0, #1
	mov r1, r8, lsl #0x10
	str r0, [sp]
	mov r0, r10
	mov r1, r1, asr #0x10
	mov r2, r6
	mov r3, #2
	bl FontWindowMWControl__SetSprite
	add r8, r8, #0x10
	b _0205B150
_0205B110:
	mov r1, r8, lsl #0x10
	mov r0, r10
	mov r1, r1, asr #0x10
	mov r2, r5
	mov r3, r11
	str r11, [sp]
	bl FontWindowMWControl__SetSprite
	mov r0, #1
	mov r1, r8, lsl #0x10
	str r0, [sp]
	mov r0, r10
	mov r1, r1, asr #0x10
	mov r2, r6
	mov r3, #1
	bl FontWindowMWControl__SetSprite
	add r8, r8, #8
_0205B150:
	cmp r8, r9
	blt _0205B0BC
_0205B158:
	add r0, r5, #8
	sub r1, r7, #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r5, r0, asr #0x10
	mov r7, r1, lsr #0x10
_0205B170:
	ldr r0, [sp, #4]
	cmp r0, #0
	cmpne r7, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r3, r0, lsl #0xd
	mov r1, r7, lsl #0xd
	mov r6, r1, lsr #0x10
	mov r0, r10
	mov r1, r4
	mov r2, r5
	mov r3, r3, lsr #0x10
	str r6, [sp]
	bl FontWindowMWControl__Func_205B37C
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end FontWindowMWControl__WindowFunc2_205AF50

	arm_func_start FontWindowMWControl__Func_205B1B0
FontWindowMWControl__Func_205B1B0: // 0x0205B1B0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r1
	mov r8, r0
	mov r6, r2
	mov r5, r3
	adds r0, r7, #8
	ldmmiia sp!, {r4, r5, r6, r7, r8, pc}
	adds r0, r6, #8
	ldmmiia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r7, #0x100
	cmplt r6, #0xc0
	ldmgeia sp!, {r4, r5, r6, r7, r8, pc}
	ldrb r1, [r8, #0x1d]
	ldr r0, [r8, #0x10]
	ldrh r4, [r8, #0x24]
	bl OAMSystem__Alloc
	ldr r1, _0205B248 // =0x000001FF
	and r2, r6, #0xff
	strh r2, [r0]
	and r1, r7, r1
	strh r1, [r0, #2]
	cmp r5, #0
	ldrneh r1, [r0, #2]
	orrne r1, r1, #0x1000
	strneh r1, [r0, #2]
	ldr r1, [sp, #0x18]
	cmp r1, #0
	ldrneh r1, [r0, #2]
	orrne r1, r1, #0x2000
	strneh r1, [r0, #2]
	ldr r1, _0205B24C // =0x000003FF
	ldrb r2, [r8, #0x1c]
	and r1, r4, r1
	ldrb r3, [r8, #0x1e]
	orr r1, r1, r2, lsl #10
	orr r1, r1, r3, lsl #12
	strh r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0205B248: .word 0x000001FF
_0205B24C: .word 0x000003FF
	arm_func_end FontWindowMWControl__Func_205B1B0

	arm_func_start FontWindowMWControl__Func_205B250
FontWindowMWControl__Func_205B250: // 0x0205B250
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r1
	mov r7, r0
	mov r8, r2
	mov r5, r3
	adds r0, r6, #8
	ldmmiia sp!, {r4, r5, r6, r7, r8, pc}
	adds r0, r8, #0x10
	ldmmiia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r6, #0x100
	cmplt r8, #0xc0
	ldmgeia sp!, {r4, r5, r6, r7, r8, pc}
	ldrb r1, [r7, #0x1d]
	ldr r0, [r7, #0x10]
	ldrh r4, [r7, #0x24]
	bl OAMSystem__Alloc
	and r2, r8, #0xff
	ldr r1, _0205B2D8 // =0x000001FF
	orr r2, r2, #0x8000
	strh r2, [r0]
	and r1, r6, r1
	strh r1, [r0, #2]
	cmp r5, #0
	ldrneh r1, [r0, #2]
	orrne r1, r1, #0x1000
	strneh r1, [r0, #2]
	ldr r1, _0205B2DC // =0x000003FF
	ldrb r2, [r7, #0x1c]
	and r1, r4, r1
	ldrb r3, [r7, #0x1e]
	orr r1, r1, r2, lsl #10
	orr r1, r1, r3, lsl #12
	strh r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0205B2D8: .word 0x000001FF
_0205B2DC: .word 0x000003FF
	arm_func_end FontWindowMWControl__Func_205B250

	arm_func_start FontWindowMWControl__Func_205B2E0
FontWindowMWControl__Func_205B2E0: // 0x0205B2E0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r1
	mov r7, r0
	mov r5, r2
	mov r4, r3
	adds r0, r6, #0x10
	ldmmiia sp!, {r4, r5, r6, r7, r8, pc}
	adds r0, r5, #8
	ldmmiia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r6, #0x100
	cmplt r5, #0xc0
	ldmgeia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r3, [r7, #0x24]
	ldrh r2, [r7, #0x26]
	ldrb r1, [r7, #0x1d]
	ldr r0, [r7, #0x10]
	add r2, r3, r2
	mov r8, r2, lsl #0x10
	bl OAMSystem__Alloc
	and r2, r5, #0xff
	ldr r1, _0205B374 // =0x000001FF
	orr r2, r2, #0x4000
	strh r2, [r0]
	and r1, r6, r1
	strh r1, [r0, #2]
	cmp r4, #0
	ldrneh r1, [r0, #2]
	orrne r1, r1, #0x2000
	strneh r1, [r0, #2]
	ldr r1, _0205B378 // =0x000003FF
	ldrb r2, [r7, #0x1c]
	and r1, r1, r8, lsr #16
	ldrb r3, [r7, #0x1e]
	orr r1, r1, r2, lsl #10
	orr r1, r1, r3, lsl #12
	strh r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0205B374: .word 0x000001FF
_0205B378: .word 0x000003FF
	arm_func_end FontWindowMWControl__Func_205B2E0

	arm_func_start FontWindowMWControl__Func_205B37C
FontWindowMWControl__Func_205B37C: // 0x0205B37C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r7, r3
	str r1, [sp, #4]
	mov r10, r0
	mov r11, r2
	tst r7, #1
	ldr r9, [sp, #0x40]
	beq _0205B43C
	ldr r1, [sp, #4]
	sub r0, r7, #1
	str r0, [sp, #0x14]
	add r0, r1, r0, lsl #3
	cmp r9, #0
	str r0, [sp, #0x18]
	mov r5, #0
	ble _0205B3FC
	mov r0, r0, lsl #0x10
	mov r6, r11
	mov r4, r0, asr #0x10
	mov r8, #2
_0205B3D0:
	mov r1, r6, lsl #0x10
	mov r2, r1, asr #0x10
	mov r0, r10
	mov r1, r4
	mov r3, #1
	str r8, [sp]
	bl FontWindowMWControl__SetSprite
	add r5, r5, #2
	cmp r5, r9
	add r6, r6, #0x10
	blt _0205B3D0
_0205B3FC:
	cmp r5, r9
	bge _0205B42C
	ldr r0, [sp, #0x18]
	add r2, r11, r5, lsl #3
	mov r1, r0, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, #1
	mov r0, r10
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	str r3, [sp]
	bl FontWindowMWControl__SetSprite
_0205B42C:
	ldr r0, [sp, #0x14]
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	b _0205B440
_0205B43C:
	mov r6, r7
_0205B440:
	tst r9, #1
	beq _0205B4E4
	sub r0, r9, #1
	str r0, [sp, #0x10]
	add r0, r11, r0, lsl #3
	cmp r7, #0
	str r0, [sp, #8]
	mov r5, #0
	ble _0205B4A0
	mov r0, r0, lsl #0x10
	ldr r4, [sp, #4]
	mov r8, r0, asr #0x10
_0205B470:
	mov r0, r4, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, #1
	str r0, [sp]
	mov r0, r10
	mov r2, r8
	mov r3, #2
	bl FontWindowMWControl__SetSprite
	add r5, r5, #2
	cmp r5, r7
	add r4, r4, #0x10
	blt _0205B470
_0205B4A0:
	ldr r0, [sp, #8]
	cmp r0, r9
	bge _0205B4D8
	ldr r0, [sp, #4]
	mov r3, #1
	add r0, r0, r5, lsl #3
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #8]
	mov r1, r1, asr #0x10
	mov r2, r0, lsl #0x10
	mov r0, r10
	mov r2, r2, asr #0x10
	str r3, [sp]
	bl FontWindowMWControl__SetSprite
_0205B4D8:
	ldr r0, [sp, #0x10]
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
_0205B4E4:
	mov r0, #0
	cmp r9, #0
	str r0, [sp, #0xc]
	addle sp, sp, #0x1c
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r5, #2
_0205B4FC:
	mov r8, #0
	cmp r6, #0
	ble _0205B540
	mov r0, r11, lsl #0x10
	ldr r7, [sp, #4]
	mov r4, r0, asr #0x10
_0205B514:
	mov r1, r7, lsl #0x10
	mov r0, r10
	mov r2, r4
	mov r1, r1, asr #0x10
	str r5, [sp]
	mov r3, r5
	bl FontWindowMWControl__SetSprite
	add r8, r8, #2
	cmp r8, r6
	add r7, r7, #0x10
	blt _0205B514
_0205B540:
	ldr r0, [sp, #0xc]
	add r11, r11, #0x10
	add r0, r0, #2
	str r0, [sp, #0xc]
	cmp r0, r9
	blt _0205B4FC
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end FontWindowMWControl__Func_205B37C

	arm_func_start FontWindowMWControl__SetSprite
FontWindowMWControl__SetSprite: // 0x0205B560
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r1
	mov r4, r3
	mov r7, r0
	mov r5, r2
	adds r0, r6, r4, lsl #3
	ldmmiia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r0, [sp, #0x18]
	adds r0, r5, r0, lsl #3
	ldmmiia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r6, #0x100
	cmplt r5, #0xc0
	ldmgeia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r3, [r7, #0x24]
	ldrh r2, [r7, #0x26]
	ldrb r1, [r7, #0x1d]
	ldr r0, [r7, #0x10]
	add r2, r3, r2, lsl #1
	mov r8, r2, lsl #0x10
	bl OAMSystem__Alloc
	ldr r1, _0205B630 // =0x000001FF
	and r2, r5, #0xff
	strh r2, [r0]
	and r1, r6, r1
	strh r1, [r0, #2]
	cmp r4, #2
	ldreqh r1, [sp, #0x18]
	cmpeq r1, #2
	bne _0205B5E4
	ldrh r1, [r0, #2]
	orr r1, r1, #0x4000
	strh r1, [r0, #2]
	b _0205B610
_0205B5E4:
	cmp r4, #2
	bne _0205B5FC
	ldrh r1, [r0, #0]
	orr r1, r1, #0x4000
	strh r1, [r0]
	b _0205B610
_0205B5FC:
	ldrh r1, [sp, #0x18]
	cmp r1, #2
	ldreqh r1, [r0, #0]
	orreq r1, r1, #0x8000
	streqh r1, [r0]
_0205B610:
	ldr r1, _0205B634 // =0x000003FF
	ldrb r2, [r7, #0x1c]
	and r1, r1, r8, lsr #16
	ldrb r3, [r7, #0x1e]
	orr r1, r1, r2, lsl #10
	orr r1, r1, r3, lsl #12
	strh r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0205B630: .word 0x000001FF
_0205B634: .word 0x000003FF
	arm_func_end FontWindowMWControl__SetSprite

	.rodata

FontWindowMWControl__TileCounts: // 0x02110500
	.hword 0xC, 0xC, 0xC, 0xC

FontWindowMWControl__WindowFuncs: // 0x02110508
	.word FontWindowMWControl__WindowFunc_205A66C, FontWindowMWControl__WindowFunc_205A72C
	.word FontWindowMWControl__WindowFunc_205A804, FontWindowMWControl__WindowFunc_205A804

FontWindowMWControl__WindowFuncs2: // 0x02110518
	.word FontWindowMWControl__WindowFunc2_205A938, FontWindowMWControl__WindowFunc2_205AF50
	.word FontWindowMWControl__WindowFunc2_205AF50, FontWindowMWControl__WindowFunc2_205AF50