	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start FontAniHeader__Func_2054CF8
FontAniHeader__Func_2054CF8: // 0x02054CF8
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x38
	bl MIi_CpuClear32
	mov r0, #2
	str r0, [r4, #0x10]
	mov r0, #3
	str r0, [r4, #0x14]
	ldmia sp!, {r4, pc}
	arm_func_end FontAniHeader__Func_2054CF8

	arm_func_start FontAniHeader__Unknown__Func_2054D24
FontAniHeader__Unknown__Func_2054D24: // 0x02054D24
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r7, r3
	bl FontAniHeader__Unknown__Release
	ldrsh r1, [sp, #0x18]
	str r7, [r6]
	ldrsh r0, [sp, #0x1c]
	strh r1, [r6, #4]
	ldrh r1, [sp, #0x20]
	strh r0, [r6, #6]
	ldrh r0, [sp, #0x24]
	strh r1, [r6, #8]
	ldr r1, [sp, #0x28]
	strh r0, [r6, #0xa]
	str r4, [r6, #0xc]
	str r5, [r6, #0x10]
	mov r2, #0
	str r2, [r6, #0x14]
	ldrh r0, [sp, #0x2c]
	str r1, [r6, #0x18]
	ldrh r1, [sp, #0x30]
	strh r0, [r6, #0x1c]
	ldrh r0, [sp, #0x34]
	strh r1, [r6, #0x1e]
	ldrh r1, [sp, #0x38]
	strh r0, [r6, #0x20]
	mov r0, r6
	strh r2, [r6, #0x22]
	bl FontAniHeader__Unknown__Func_2055D08
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end FontAniHeader__Unknown__Func_2054D24

	arm_func_start FontWindowAnimator__Unknown__Load2
FontWindowAnimator__Unknown__Load2: // 0x02054DA4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r7, r3
	bl FontAniHeader__Unknown__Release
	ldrsh r0, [sp, #0x18]
	str r7, [r6]
	ldrsh r1, [sp, #0x1c]
	strh r0, [r6, #4]
	ldrh r0, [sp, #0x20]
	strh r1, [r6, #6]
	ldrh r1, [sp, #0x24]
	strh r0, [r6, #8]
	ldr r0, [sp, #0x28]
	strh r1, [r6, #0xa]
	str r4, [r6, #0xc]
	str r5, [r6, #0x10]
	mov r1, #1
	str r1, [r6, #0x14]
	str r0, [r6, #0x18]
	mov r2, #0
	strh r2, [r6, #0x1c]
	ldrb r1, [sp, #0x2c]
	strh r2, [r6, #0x1e]
	ldrb r0, [sp, #0x30]
	strb r1, [r6, #0x20]
	ldrh r1, [sp, #0x34]
	strb r0, [r6, #0x21]
	mov r0, #0x50
	strb r1, [r6, #0x22]
	strh r2, [r6, #0x24]
	strh r0, [r6, #0x26]
	mov r0, #0xa00
	bl _AllocHeadHEAP_USER
	mov r1, r4
	str r0, [r6, #0x28]
	bl FontWindowAnimator__Unknown__InitDynamicBG
	ldr r0, [sp, #0x28]
	mov r1, #0x50
	cmp r0, #0
	ldrne r2, _02054EB8 // =0x04001000
	ldrne r0, _02054EBC // =0x00300010
	ldrne r2, [r2]
	bne _02054E64
	mov r0, #0x4000000
	ldr r2, [r0]
	ldr r0, _02054EBC // =0x00300010
_02054E64:
	and r2, r2, r0
	cmp r2, #0x10
	beq _02054E90
	ldr r0, _02054EC0 // =0x00100010
	cmp r2, r0
	beq _02054E8C
	add r0, r0, #0x100000
	cmp r2, r0
	moveq r1, r1, lsr #2
	b _02054E90
_02054E8C:
	mov r1, r1, lsr #1
_02054E90:
	ldr r0, [sp, #0x28]
	bl VRAMSystem__AllocSpriteVram
	str r0, [r6, #0x2c]
	mov r0, #0x1000
	strh r0, [r6, #0x30]
	strh r0, [r6, #0x32]
	mov r0, #0
	strh r0, [r6, #0x34]
	strh r0, [r6, #0x36]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02054EB8: .word 0x04001000
_02054EBC: .word 0x00300010
_02054EC0: .word 0x00100010
	arm_func_end FontWindowAnimator__Unknown__Load2

	arm_func_start FontAniHeader__Unknown__Release
FontAniHeader__Unknown__Release: // 0x02054EC4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x14]
	cmp r0, #0
	beq _02054EE4
	cmp r0, #1
	beq _02054F00
	b _02054F34
_02054EE4:
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	beq _02054F34
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x2c]
	b _02054F34
_02054F00:
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _02054F18
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x28]
_02054F18:
	ldr r1, [r4, #0x2c]
	cmp r1, #0
	beq _02054F34
	ldr r0, [r4, #0x18]
	bl VRAMSystem__FreeSpriteVram
	mov r0, #0
	str r0, [r4, #0x2c]
_02054F34:
	mov r0, r4
	bl FontAniHeader__Func_2054CF8
	ldmia sp!, {r4, pc}
	arm_func_end FontAniHeader__Unknown__Release

	arm_func_start FontWindowAnimator__Unknown__Func_2054F40
FontWindowAnimator__Unknown__Func_2054F40: // 0x02054F40
	stmdb sp!, {r3, lr}
	ldr r3, [r0, #0x14]
	ldr r1, _02054F60 // =_0211996C
	ldr r2, [r0, #0x10]
	add r1, r1, r3, lsl #2
	ldr r1, [r1, r2, lsl #2]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_02054F60: .word _0211996C
	arm_func_end FontWindowAnimator__Unknown__Func_2054F40

	arm_func_start FontWindowAnimator__Unknown__Func_2054F64
FontWindowAnimator__Unknown__Func_2054F64: // 0x02054F64
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r3, [r4, #0x14]
	ldr r1, _02054FA4 // =_0211996C
	ldr r2, [r4, #0x10]
	add r1, r1, r3, lsl #2
	ldr r1, [r1, r2, lsl #2]
	blx r1
	ldr r2, [r4, #0x14]
	ldr r0, _02054FA8 // =_02119974
	ldr r1, [r4, #0x10]
	add r0, r0, r2, lsl #2
	ldr r1, [r0, r1, lsl #2]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02054FA4: .word _0211996C
_02054FA8: .word _02119974
	arm_func_end FontWindowAnimator__Unknown__Func_2054F64

	arm_func_start FontWindowAnimator__Unknown__Func_2054FAC
FontWindowAnimator__Unknown__Func_2054FAC: // 0x02054FAC
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x28
	add r1, sp, #0x20
	mov r4, r0
	str r1, [sp]
	ldrh r1, [r4, #0x1c]
	ldr r0, [r4, #0x18]
	add r2, sp, #0x24
	add r3, sp, #0x22
	and r1, r1, #0xff
	bl GetVRAMTileConfig
	ldr r0, [r4]
	ldrh ip, [r4, #0x2a]
	ldrh r3, [r4, #0x28]
	tst r0, #0x20
	mov r1, #0
	mul r0, r3, ip
	str r1, [sp]
	beq _0205503C
	ldr lr, [sp, #0x24]
	mov r2, r1
	str lr, [sp, #4]
	ldrh lr, [sp, #0x22]
	str lr, [sp, #8]
	ldrh lr, [sp, #0x20]
	str lr, [sp, #0xc]
	ldrh lr, [r4, #0x24]
	str lr, [sp, #0x10]
	ldrh lr, [r4, #0x26]
	str lr, [sp, #0x14]
	str r3, [sp, #0x18]
	str ip, [sp, #0x1c]
	ldr ip, [r4, #0x2c]
	add r0, ip, r0, lsl #1
	bl Mappings__LoadUnknown
	b _0205507C
_0205503C:
	ldr lr, [sp, #0x24]
	mov r2, r1
	str lr, [sp, #4]
	ldrh lr, [sp, #0x22]
	str lr, [sp, #8]
	ldrh lr, [sp, #0x20]
	str lr, [sp, #0xc]
	ldrh lr, [r4, #0x24]
	str lr, [sp, #0x10]
	ldrh lr, [r4, #0x26]
	str lr, [sp, #0x14]
	str r3, [sp, #0x18]
	str ip, [sp, #0x1c]
	ldr ip, [r4, #0x2c]
	add r0, ip, r0, lsl #1
	bl Mappings__ReadMappingsCompressed
_0205507C:
	ldrh r0, [r4, #0x22]
	bic r0, r0, #4
	strh r0, [r4, #0x22]
	add sp, sp, #0x28
	ldmia sp!, {r4, pc}
	arm_func_end FontWindowAnimator__Unknown__Func_2054FAC

	arm_func_start FontWindowAnimator__Unknown__Func_2055090
FontWindowAnimator__Unknown__Func_2055090: // 0x02055090
	strh r1, [r0, #0x1c]
	strh r2, [r0, #0x1e]
	bx lr
	arm_func_end FontWindowAnimator__Unknown__Func_2055090

	arm_func_start FontWindowAnimator__Unknown__Func_205509C
FontWindowAnimator__Unknown__Func_205509C: // 0x0205509C
	stmdb sp!, {r4, lr}
	ldrsh lr, [sp, #8]
	mul r4, r3, r1
	mul ip, lr, r2
	strh r1, [r0, #0x30]
	strh r2, [r0, #0x32]
	sub r1, r3, r4, asr #12
	strh r1, [r0, #0x34]
	sub r1, lr, ip, asr #12
	strh r1, [r0, #0x36]
	ldmia sp!, {r4, pc}
	arm_func_end FontWindowAnimator__Unknown__Func_205509C

	arm_func_start FontWindowAnimator__Unknown__DrawMappings
FontWindowAnimator__Unknown__DrawMappings: // 0x020550C8
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x28
	mov r6, r0
	ldrh r0, [r6, #0x22]
	tst r0, #1
	bne _0205513C
	ldr r0, [r6]
	tst r0, #1
	bne _0205513C
	ldr r0, [r6, #0xc]
	bl GetBackgroundPalette
	cmp r0, #0
	beq _02055130
	ldr r1, [r6, #0x18]
	ldrh r2, [r6, #0x1e]
	cmp r1, #0
	moveq r3, #0x5000000
	ldrne r3, _020552C4 // =0x05000400
	ldr r1, [r6]
	add r2, r3, r2, lsl #5
	tst r1, #8
	mov r1, #0
	beq _0205512C
	bl LoadCompressedPalette
	b _02055130
_0205512C:
	bl QueueCompressedPalette
_02055130:
	ldrh r0, [r6, #0x22]
	orr r0, r0, #1
	strh r0, [r6, #0x22]
_0205513C:
	ldrh r0, [r6, #0x22]
	tst r0, #2
	bne _020551D4
	ldr r0, [r6]
	tst r0, #2
	bne _020551D4
	ldr r0, [r6, #0xc]
	bl GetBackgroundPixels
	movs r4, r0
	beq _020551C8
	ldr r0, [r6, #0x18]
	ldrh r1, [r6, #0x1c]
	cmp r0, #0
	moveq r5, #0x6000000
	ldr r0, [r6, #0x18]
	add r2, sp, #0x22
	add r3, sp, #0x20
	and r1, r1, #0xff
	movne r5, #0x6200000
	bl GetVRAMCharacterConfig
	ldrh r1, [sp, #0x20]
	ldr r0, [r6]
	ldrh r3, [sp, #0x22]
	mov r2, r1, lsl #0xe
	tst r0, #0x10
	add r2, r2, r3, lsl #16
	ldrh r1, [r6, #0x20]
	add r2, r5, r2
	mov r0, r4
	add r2, r2, r1, lsl #5
	mov r1, #0
	beq _020551C4
	bl LoadCompressedPixels
	b _020551C8
_020551C4:
	bl QueueCompressedPixels
_020551C8:
	ldrh r0, [r6, #0x22]
	orr r0, r0, #2
	strh r0, [r6, #0x22]
_020551D4:
	ldrh r0, [r6, #0x22]
	tst r0, #4
	addne sp, sp, #0x28
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, [r6]
	tst r0, #4
	addne sp, sp, #0x28
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, sp, #0x20
	str r0, [sp]
	ldrh r1, [r6, #0x1c]
	ldr r0, [r6, #0x18]
	add r2, sp, #0x24
	add r3, sp, #0x22
	and r1, r1, #0xff
	bl GetVRAMTileConfig
	ldr r0, [r6]
	mov r1, #0
	tst r0, #0x20
	ldrh r3, [r6, #0x28]
	mov r2, r1
	beq _02055270
	str r1, [sp]
	ldr r0, [sp, #0x24]
	str r0, [sp, #4]
	ldrh r0, [sp, #0x22]
	str r0, [sp, #8]
	ldrh r0, [sp, #0x20]
	str r0, [sp, #0xc]
	ldrh r0, [r6, #0x24]
	str r0, [sp, #0x10]
	ldrh r0, [r6, #0x26]
	str r0, [sp, #0x14]
	str r3, [sp, #0x18]
	ldrh r0, [r6, #0x2a]
	str r0, [sp, #0x1c]
	ldr r0, [r6, #0x2c]
	bl Mappings__LoadUnknown
	b _020552B0
_02055270:
	str r1, [sp]
	ldr r0, [sp, #0x24]
	str r0, [sp, #4]
	ldrh r0, [sp, #0x22]
	str r0, [sp, #8]
	ldrh r0, [sp, #0x20]
	str r0, [sp, #0xc]
	ldrh r0, [r6, #0x24]
	str r0, [sp, #0x10]
	ldrh r0, [r6, #0x26]
	str r0, [sp, #0x14]
	str r3, [sp, #0x18]
	ldrh r0, [r6, #0x2a]
	str r0, [sp, #0x1c]
	ldr r0, [r6, #0x2c]
	bl Mappings__ReadMappingsCompressed
_020552B0:
	ldrh r0, [r6, #0x22]
	orr r0, r0, #4
	strh r0, [r6, #0x22]
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020552C4: .word 0x05000400
	arm_func_end FontWindowAnimator__Unknown__DrawMappings

	arm_func_start FontWindowAnimator__Unknown__DrawRaw
FontWindowAnimator__Unknown__DrawRaw: // 0x020552C8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #0x24]
	tst r0, #1
	bne _02055338
	ldr r0, [r4]
	tst r0, #1
	bne _02055338
	ldr r0, [r4, #0xc]
	bl GetBackgroundPalette
	cmp r0, #0
	beq _0205532C
	ldr r1, [r4, #0x18]
	ldrb r2, [r4, #0x22]
	cmp r1, #0
	ldreq r3, _02055390 // =0x05000200
	ldr r1, [r4]
	ldrne r3, _02055394 // =0x05000600
	tst r1, #8
	add r2, r3, r2, lsl #5
	mov r1, #0
	beq _02055328
	bl LoadCompressedPalette
	b _0205532C
_02055328:
	bl QueueCompressedPalette
_0205532C:
	ldrh r0, [r4, #0x24]
	orr r0, r0, #1
	strh r0, [r4, #0x24]
_02055338:
	ldrh r0, [r4, #0x24]
	tst r0, #2
	ldmneia sp!, {r4, pc}
	ldr r0, [r4]
	tst r0, #2
	ldmneia sp!, {r4, pc}
	tst r0, #0x10
	ldrh r1, [r4, #0x26]
	mov r2, #0
	ldr r0, [r4, #0x28]
	beq _02055374
	ldr r3, [r4, #0x2c]
	mov r1, r1, lsl #5
	bl LoadUncompressedPixels
	b _02055380
_02055374:
	ldr r3, [r4, #0x2c]
	mov r1, r1, lsl #5
	bl QueueUncompressedPixels
_02055380:
	ldrh r0, [r4, #0x24]
	orr r0, r0, #2
	strh r0, [r4, #0x24]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02055390: .word 0x05000200
_02055394: .word 0x05000600
	arm_func_end FontWindowAnimator__Unknown__DrawRaw

	arm_func_start FontWindowAnimator__Unknown__Func_2055398
FontWindowAnimator__Unknown__Func_2055398: // 0x02055398
	bx lr
	arm_func_end FontWindowAnimator__Unknown__Func_2055398

	arm_func_start FontWindowAnimator__Unknown__DrawDynamic2
FontWindowAnimator__Unknown__DrawDynamic2: // 0x0205539C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x34
	mov r4, r0
	ldrsh r0, [r4, #0x30]
	cmp r0, #0
	ldrnesh r1, [r4, #0x32]
	cmpne r1, #0
	addeq sp, sp, #0x34
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldr r2, [r4, #0x18]
	cmp r2, #0
	ldr r2, [r4, #0x2c]
	bne _020553E4
	mov r5, #0x4000000
	sub r2, r2, #0x6400000
	mov r3, r2, lsl #0xb
	ldr r5, [r5]
	b _020553F4
_020553E4:
	ldr r5, _02055560 // =0x04001000
	sub r2, r2, #0x6600000
	ldr r5, [r5]
	mov r3, r2, lsl #0xb
_020553F4:
	ldr r2, _02055564 // =0x00300010
	mov r7, r3, lsr #0x10
	and r3, r5, r2
	cmp r3, #0x10
	beq _02055428
	ldr r2, _02055568 // =0x00100010
	cmp r3, r2
	beq _02055430
	add r2, r2, #0x100000
	cmp r3, r2
	beq _02055440
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_02055428:
	mov r6, #2
	b _0205544C
_02055430:
	mov r2, r7, lsl #0xf
	mov r7, r2, lsr #0x10
	mov r6, #1
	b _0205544C
_02055440:
	mov r2, r7, lsl #0xe
	mov r7, r2, lsr #0x10
	mov r6, #0
_0205544C:
	ldrsh r8, [r4, #4]
	ldrsh r5, [r4, #0x1c]
	ldrsh r3, [r4, #6]
	ldrsh r2, [r4, #0x1e]
	add r8, r5, r8, lsl #3
	ldrsh r9, [r4, #0x34]
	ldrsh r5, [r4, #0x36]
	add r2, r2, r3, lsl #3
	cmp r0, #0x1000
	add r3, r5, r2
	add r8, r9, r8
	mov r2, r8, lsl #0x10
	mov r3, r3, lsl #0x10
	cmpeq r1, #0x1000
	mov r8, r2, asr #0x10
	mov r9, r3, asr #0x10
	ldreq r5, _0205556C // =0x0000FFFF
	beq _02055508
	add r0, r1, #0x80
	bl FX_Inv
	ldrsh r1, [r4, #0x30]
	mov r5, r0
	add r0, r1, #0x80
	bl FX_Inv
	mov r1, r0
	add r0, sp, #0x24
	mov r2, r5
	blx MTX_Scale22_
	ldr r0, [r4, #0x18]
	add r1, sp, #0x24
	bl OAMSystem__AddAffineSprite
	mov r5, r0
	ldr r0, [r4, #0x18]
	bl OAMSystem__GetList1
	ldr r1, [sp, #0x24]
	add r0, r0, r5, lsl #5
	mov r1, r1, asr #4
	strh r1, [r0, #6]
	ldr r1, [sp, #0x28]
	mov r1, r1, asr #4
	strh r1, [r0, #0xe]
	ldr r1, [sp, #0x2c]
	mov r1, r1, asr #4
	strh r1, [r0, #0x16]
	ldr r1, [sp, #0x30]
	mov r1, r1, asr #4
	strh r1, [r0, #0x1e]
_02055508:
	ldrh r0, [r4, #0xa]
	mov r1, r8
	mov r2, r9
	str r0, [sp]
	ldrb r0, [r4, #0x20]
	str r0, [sp, #4]
	ldrb r0, [r4, #0x21]
	str r0, [sp, #8]
	ldrb r0, [r4, #0x22]
	str r0, [sp, #0xc]
	str r7, [sp, #0x10]
	str r6, [sp, #0x14]
	str r5, [sp, #0x18]
	ldrsh r0, [r4, #0x30]
	str r0, [sp, #0x1c]
	ldrsh r0, [r4, #0x32]
	str r0, [sp, #0x20]
	ldrh r3, [r4, #8]
	ldr r0, [r4, #0x18]
	bl FontWindowAnimator__Unknown__DrawDynamic
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02055560: .word 0x04001000
_02055564: .word 0x00300010
_02055568: .word 0x00100010
_0205556C: .word 0x0000FFFF
	arm_func_end FontWindowAnimator__Unknown__DrawDynamic2

	arm_func_start FontWindowAnimator__Unknown__DrawDynamic
FontWindowAnimator__Unknown__DrawDynamic: // 0x02055570
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x84
	ldr r9, [sp, #0xac]
	ldr r4, [sp, #0xb0]
	mov r5, #1
	str r4, [sp, #0xb0]
	ldr r4, [sp, #0xb4]
	mov r10, r1
	str r4, [sp, #0xb4]
	ldr r8, [sp, #0xc0]
	ldr r7, [sp, #0xc4]
	ldr r11, [sp, #0xc8]
	str r0, [sp, #0x28]
	str r9, [sp]
	ldr r4, [sp, #0xb0]
	str r4, [sp, #4]
	ldr r4, [sp, #0xb4]
	str r4, [sp, #8]
	str r5, [sp, #0xc]
	str r5, [sp, #0x10]
	str r8, [sp, #0x14]
	str r2, [sp, #0x2c]
	str r10, [sp, #0x18]
	ldr r4, [sp, #0x2c]
	str r4, [sp, #0x1c]
	ldrh r4, [sp, #0xb8]
	str r7, [sp, #0x20]
	str r3, [sp, #0x30]
	str r11, [sp, #0x24]
	mov r3, r4
	str r4, [sp, #0x5c]
	bl FontWindowAnimator__Unknown__AllocSprite
	str r9, [sp]
	ldr r0, [sp, #0xb0]
	mov r3, #1
	str r0, [sp, #4]
	ldr r0, [sp, #0xb4]
	mov r2, r4
	str r0, [sp, #8]
	ldr r0, [sp, #0x30]
	sub r0, r0, #2
	add r5, r10, r0, lsl #3
	mov r0, r5, lsl #0x10
	mov r1, r0, asr #0x10
	ldrh r0, [sp, #0xbc]
	str r3, [sp, #0xc]
	str r3, [sp, #0x10]
	str r0, [sp, #0x58]
	add r0, r2, r3, lsl r0
	str r8, [sp, #0x14]
	mov r0, r0, lsl #0x10
	str r10, [sp, #0x18]
	mov r3, r0, lsr #0x10
	ldr r0, [sp, #0x2c]
	str r0, [sp, #0x1c]
	str r7, [sp, #0x20]
	str r11, [sp, #0x24]
	ldr r0, [sp, #0x28]
	ldr r2, [sp, #0x2c]
	bl FontWindowAnimator__Unknown__AllocSprite
	str r9, [sp]
	ldr r0, [sp, #0xb0]
	ldrh r4, [sp, #0xa8]
	str r0, [sp, #4]
	ldr r0, [sp, #0xb4]
	ldr r6, [sp, #0x5c]
	str r0, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	str r8, [sp, #0x14]
	str r10, [sp, #0x18]
	ldr r0, [sp, #0x2c]
	ldr r3, [sp, #0x58]
	str r0, [sp, #0x1c]
	str r7, [sp, #0x20]
	str r11, [sp, #0x24]
	mov ip, #2
	add r3, r6, ip, lsl r3
	mov r3, r3, lsl #0x10
	ldr r0, [sp, #0x2c]
	sub r1, r4, #2
	add r0, r0, r1, lsl #3
	str r0, [sp, #0x54]
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	ldr r0, [sp, #0x28]
	mov r1, r10
	mov r3, r3, lsr #0x10
	bl FontWindowAnimator__Unknown__AllocSprite
	str r9, [sp]
	ldr r0, [sp, #0xb0]
	ldr r2, [sp, #0x54]
	str r0, [sp, #4]
	ldr r0, [sp, #0xb4]
	mov r1, r5, lsl #0x10
	str r0, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	str r8, [sp, #0x14]
	str r10, [sp, #0x18]
	ldr r0, [sp, #0x2c]
	mov r2, r2, lsl #0x10
	str r0, [sp, #0x1c]
	str r7, [sp, #0x20]
	ldr r6, [sp, #0x5c]
	ldr r3, [sp, #0x58]
	mov ip, #3
	add r3, r6, ip, lsl r3
	mov r3, r3, lsl #0x10
	ldr r0, [sp, #0x28]
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	mov r3, r3, lsr #0x10
	str r11, [sp, #0x24]
	bl FontWindowAnimator__Unknown__AllocSprite
	sub r0, r4, #4
	str r0, [sp, #0x50]
	mov r0, r0, lsl #0x10
	mov r4, r0, asr #0x10
	ldr r0, [sp, #0x2c]
	cmp r4, #0
	add r0, r0, #0x10
	str r0, [sp, #0x4c]
	mov r0, r0, lsl #0x10
	mov r6, r0, asr #0x10
	ble _020558AC
	mov r0, r5, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x48]
	cmp r4, #0
	ble _020558AC
	ldr r1, [sp, #0x5c]
	ldr r0, [sp, #0x58]
	mov r2, #4
	add r3, r1, r2, lsl r0
	mov r2, #6
	add r1, r1, r2, lsl r0
	mov r0, r3, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x78]
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x7c]
_020557B4:
	cmp r4, #4
	blt _020557CC
	mov r0, #2
	mov r5, #4
	str r0, [sp, #0x70]
	b _020557EC
_020557CC:
	cmp r4, #2
	movlt r0, #0
	movlt r5, #1
	strlt r0, [sp, #0x70]
	blt _020557EC
	mov r0, #1
	mov r5, #2
	str r0, [sp, #0x70]
_020557EC:
	str r9, [sp]
	ldr r0, [sp, #0xb0]
	ldr r3, [sp, #0x78]
	str r0, [sp, #4]
	ldr r0, [sp, #0xb4]
	mov r1, r10
	str r0, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x70]
	mov r2, r6
	str r0, [sp, #0x10]
	str r8, [sp, #0x14]
	str r10, [sp, #0x18]
	ldr r0, [sp, #0x2c]
	str r0, [sp, #0x1c]
	str r7, [sp, #0x20]
	ldr r0, [sp, #0x28]
	str r11, [sp, #0x24]
	bl FontWindowAnimator__Unknown__AllocSprite
	str r9, [sp]
	ldr r0, [sp, #0xb0]
	ldr r3, [sp, #0x7c]
	str r0, [sp, #4]
	ldr r0, [sp, #0xb4]
	mov r2, r6
	str r0, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x70]
	str r0, [sp, #0x10]
	str r8, [sp, #0x14]
	str r10, [sp, #0x18]
	ldr r0, [sp, #0x2c]
	str r0, [sp, #0x1c]
	str r7, [sp, #0x20]
	str r11, [sp, #0x24]
	ldr r0, [sp, #0x28]
	ldr r1, [sp, #0x48]
	bl FontWindowAnimator__Unknown__AllocSprite
	sub r0, r4, r5
	mov r0, r0, lsl #0x10
	mov r4, r0, asr #0x10
	add r0, r6, r5, lsl #3
	mov r0, r0, lsl #0x10
	mov r6, r0, asr #0x10
	cmp r4, #0
	bgt _020557B4
_020558AC:
	ldr r0, [sp, #0x30]
	sub r0, r0, #4
	mov r0, r0, lsl #0x10
	mov r4, r0, asr #0x10
	add r0, r10, #0x10
	mov r0, r0, lsl #0x10
	cmp r4, #0
	mov r6, r0, asr #0x10
	ble _02055A2C
	ldr r0, [sp, #0x54]
	cmp r4, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x40]
	ble _02055A2C
_020558E8:
	cmp r4, #4
	blt _0205590C
	mov r0, #2
	str r0, [sp, #0x74]
	mov r1, #0xe
	mov r5, #4
	mov r0, #0xa
	str r1, [sp, #0x6c]
	b _02055948
_0205590C:
	cmp r4, #2
	blt _02055930
	mov r0, #1
	str r0, [sp, #0x74]
	mov r1, #0xd
	mov r5, #2
	mov r0, #9
	str r1, [sp, #0x6c]
	b _02055948
_02055930:
	mov r5, #1
	mov r0, r5
	str r0, [sp, #0x74]
	mov r1, #0xc
	mov r0, #8
	str r1, [sp, #0x6c]
_02055948:
	ldr r2, [sp, #0x5c]
	ldr r1, [sp, #0x58]
	str r9, [sp]
	add r0, r2, r0, lsl r1
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	ldr r0, [sp, #0xb0]
	mov r1, r6
	str r0, [sp, #4]
	ldr r0, [sp, #0xb4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x74]
	str r0, [sp, #0xc]
	mov r0, #1
	str r0, [sp, #0x10]
	str r8, [sp, #0x14]
	str r10, [sp, #0x18]
	ldr r0, [sp, #0x2c]
	str r0, [sp, #0x1c]
	str r7, [sp, #0x20]
	str r11, [sp, #0x24]
	ldr r0, [sp, #0x28]
	ldr r2, [sp, #0x2c]
	bl FontWindowAnimator__Unknown__AllocSprite
	ldr r1, [sp, #0x6c]
	ldr r2, [sp, #0x5c]
	ldr r0, [sp, #0x58]
	str r9, [sp]
	add r0, r2, r1, lsl r0
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	ldr r0, [sp, #0xb0]
	mov r1, r6
	str r0, [sp, #4]
	ldr r0, [sp, #0xb4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x74]
	str r0, [sp, #0xc]
	mov r0, #1
	str r0, [sp, #0x10]
	str r8, [sp, #0x14]
	str r10, [sp, #0x18]
	ldr r0, [sp, #0x2c]
	str r0, [sp, #0x1c]
	str r7, [sp, #0x20]
	str r11, [sp, #0x24]
	ldr r0, [sp, #0x28]
	ldr r2, [sp, #0x40]
	bl FontWindowAnimator__Unknown__AllocSprite
	sub r0, r4, r5
	mov r0, r0, lsl #0x10
	mov r4, r0, asr #0x10
	add r0, r6, r5, lsl #3
	mov r0, r0, lsl #0x10
	mov r6, r0, asr #0x10
	cmp r4, #0
	bgt _020558E8
_02055A2C:
	ldr r0, [sp, #0x50]
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x3c]
	ldr r0, [sp, #0x4c]
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x44]
	ldr r0, [sp, #0x3c]
	cmp r0, #0
	addle sp, sp, #0x84
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0x30]
	ldr r1, [sp, #0x5c]
	sub r0, r0, #4
	str r0, [sp, #0x68]
	add r0, r10, #0x10
	str r0, [sp, #0x64]
	ldr r0, [sp, #0x58]
	mov r2, #0x10
	add r0, r1, r2, lsl r0
	str r0, [sp, #0x60]
_02055A84:
	ldr r0, [sp, #0x3c]
	cmp r0, #4
	blt _02055AA4
	mov r0, #4
	str r0, [sp, #0x38]
	mov r0, #2
	str r0, [sp, #0x34]
	b _02055AD0
_02055AA4:
	cmp r0, #2
	blt _02055AC0
	mov r0, #2
	str r0, [sp, #0x38]
	mov r0, #1
	str r0, [sp, #0x34]
	b _02055AD0
_02055AC0:
	mov r0, #1
	str r0, [sp, #0x38]
	mov r0, #0
	str r0, [sp, #0x34]
_02055AD0:
	ldr r0, [sp, #0x68]
	mov r0, r0, lsl #0x10
	mov r5, r0, asr #0x10
	ldr r0, [sp, #0x64]
	cmp r5, #0
	mov r0, r0, lsl #0x10
	mov r4, r0, asr #0x10
	ble _02055B90
	ldr r0, [sp, #0x60]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x80]
_02055B00:
	cmp r5, #4
	movge r6, #4
	movge r1, #2
	bge _02055B24
	cmp r5, #2
	movge r6, #2
	movge r1, #1
	movlt r6, #1
	movlt r1, #0
_02055B24:
	str r9, [sp]
	ldr r0, [sp, #0xb0]
	ldr r3, [sp, #0x80]
	str r0, [sp, #4]
	ldr r0, [sp, #0xb4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, [sp, #0x34]
	mov r1, r4
	str r0, [sp, #0x10]
	str r8, [sp, #0x14]
	str r10, [sp, #0x18]
	ldr r0, [sp, #0x2c]
	str r0, [sp, #0x1c]
	str r7, [sp, #0x20]
	str r11, [sp, #0x24]
	ldr r0, [sp, #0x28]
	ldr r2, [sp, #0x44]
	bl FontWindowAnimator__Unknown__AllocSprite
	sub r0, r5, r6
	mov r0, r0, lsl #0x10
	mov r5, r0, asr #0x10
	add r0, r4, r6, lsl #3
	mov r0, r0, lsl #0x10
	mov r4, r0, asr #0x10
	cmp r5, #0
	bgt _02055B00
_02055B90:
	ldr r1, [sp, #0x3c]
	ldr r0, [sp, #0x38]
	sub r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x3c]
	ldr r1, [sp, #0x44]
	ldr r0, [sp, #0x38]
	add r0, r1, r0, lsl #3
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x44]
	ldr r0, [sp, #0x3c]
	cmp r0, #0
	bgt _02055A84
	add sp, sp, #0x84
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end FontWindowAnimator__Unknown__DrawDynamic

	arm_func_start FontWindowAnimator__Unknown__AllocSprite
FontWindowAnimator__Unknown__AllocSprite: // 0x02055BD4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldrh r5, [sp, #0x34]
	ldr r4, _02055CF4 // =0x0000FFFF
	mov r8, r1
	mov r7, r2
	mov r6, r3
	cmp r5, r4
	ldr r5, [sp, #0x2c]
	ldr r4, [sp, #0x30]
	beq _02055C60
	ldr r3, _02055CF8 // =_021103E6
	mov r2, r5, lsl #1
	mov r1, r4, lsl #1
	ldrsh ip, [sp, #0x38]
	ldrh r9, [r3, r2]
	ldrsh r2, [sp, #0x3c]
	ldrh lr, [r3, r1]
	ldrsh r3, [sp, #0x40]
	ldrsh r1, [sp, #0x44]
	mov r9, r9, lsl #0xf
	sub r8, r8, ip
	add r8, r8, r9, lsr #16
	mul r8, r3, r8
	add r3, ip, r8, asr #12
	sub r3, r3, r9, lsr #16
	mov r3, r3, lsl #0x10
	mov r8, lr, lsl #0xf
	sub r7, r7, r2
	add r7, r7, r8, lsr #16
	mul r7, r1, r7
	add r1, r2, r7, asr #12
	sub r1, r1, r8, lsr #16
	mov r1, r1, lsl #0x10
	mov r8, r3, asr #0x10
	mov r7, r1, asr #0x10
_02055C60:
	cmp r5, r4
	moveq r9, #0
	beq _02055C74
	movhi r9, #0x4000
	movls r9, #0x8000
_02055C74:
	ldrb r1, [sp, #0x24]
	bl OAMSystem__Alloc
	ldr r2, _02055CFC // =0x000001FF
	ldr r3, _02055D00 // =_021103EE
	and r1, r7, #0xff
	orr r1, r1, r9
	mov r4, r4, lsl #1
	add r3, r3, r5, lsl #3
	ldrh r4, [r4, r3]
	and r5, r8, r2
	ldrh r3, [sp, #0x34]
	add r2, r2, #0xfe00
	strh r1, [r0]
	orr r1, r5, r4
	strh r1, [r0, #2]
	cmp r3, r2
	beq _02055CD4
	ldrh r2, [r0]
	mov r1, r3, lsl #0x19
	orr r2, r2, #0x100
	strh r2, [r0]
	ldrh r2, [r0, #2]
	orr r1, r2, r1, lsr #16
	strh r1, [r0, #2]
_02055CD4:
	ldr r1, _02055D04 // =0x000003FF
	ldrb r2, [sp, #0x20]
	and r1, r6, r1
	ldrh r3, [sp, #0x28]
	orr r1, r1, r2, lsl #10
	orr r1, r1, r3, lsl #12
	strh r1, [r0, #4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02055CF4: .word 0x0000FFFF
_02055CF8: .word _021103E6
_02055CFC: .word 0x000001FF
_02055D00: .word _021103EE
_02055D04: .word 0x000003FF
	arm_func_end FontWindowAnimator__Unknown__AllocSprite

	arm_func_start FontAniHeader__Unknown__Func_2055D08
FontAniHeader__Unknown__Func_2055D08: // 0x02055D08
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x28
	add r2, sp, #0x20
	str r2, [sp]
	mov r5, r0
	ldrh r4, [r5, #0x1c]
	add r2, sp, #0x24
	add r3, sp, #0x22
	str r1, [sp, #4]
	ldr r0, [r5, #0x18]
	and r1, r4, #0xff
	bl GetVRAMTileConfig
	ldrsh r0, [r5, #6]
	ldrsh r4, [r5, #4]
	str r0, [sp, #0xc]
	ldrsh r0, [r5, #8]
	cmp r4, #0
	str r0, [sp, #0x14]
	ldrsh r0, [r5, #0xa]
	str r0, [sp, #0x1c]
	bge _02055D74
	ldr r0, [sp, #0x14]
	add r0, r0, r4
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x14]
	mov r4, #0
_02055D74:
	ldr r0, [sp, #0xc]
	cmp r0, #0
	bge _02055D9C
	ldr r1, [sp, #0x1c]
	add r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x1c]
	mov r0, #0
	str r0, [sp, #0xc]
_02055D9C:
	ldr r0, [sp, #0x14]
	add r0, r4, r0
	cmp r0, #0x20
	ble _02055DBC
	rsb r0, r4, #0x20
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x14]
_02055DBC:
	ldr r1, [sp, #0xc]
	ldr r0, [sp, #0x1c]
	add r0, r1, r0
	cmp r0, #0x18
	ble _02055DE4
	mov r0, r1
	rsb r0, r0, #0x18
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp, #0x1c]
_02055DE4:
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x1c]
	mul r0, r1, r0
	str r0, [sp, #8]
	mov r0, r0, lsl #2
	bl _AllocHeadHEAP_USER
	ldr r1, [sp, #0x1c]
	ldr r2, [sp, #0xc]
	str r0, [r5, #0x2c]
	add r1, r2, r1
	str r1, [sp, #0x10]
	mov r1, r2
	ldr r0, [sp, #0x10]
	str r1, [sp, #0x18]
	cmp r1, r0
	bge _02055F2C
	ldr r0, [sp, #0x14]
	add r9, r4, r0
_02055E2C:
	ldrsh r1, [r5, #6]
	ldr r0, [sp, #0x18]
	subs r2, r0, r1
	moveq r2, #0
	beq _02055E70
	ldrh r1, [r5, #0xa]
	sub r0, r1, #1
	cmp r2, r0
	moveq r2, #4
	beq _02055E70
	cmp r2, #1
	moveq r2, #1
	beq _02055E70
	sub r0, r1, #2
	cmp r2, r0
	moveq r2, #3
	movne r2, #2
_02055E70:
	mov r8, r4
	cmp r4, r9
	bge _02055F14
	ldr r1, [sp, #0x18]
	ldr r0, [sp, #0xc]
	add r10, r2, r2, lsl #2
	sub r1, r1, r0
	ldr r0, [sp, #0x14]
	mov r11, #1
	mul r7, r0, r1
	mov lr, #4
	mov r6, #0
_02055EA0:
	ldrsh r0, [r5, #4]
	subs r2, r8, r0
	moveq r0, r6
	beq _02055EE0
	ldrh r1, [r5, #8]
	sub r0, r1, #1
	cmp r2, r0
	moveq r0, lr
	beq _02055EE0
	cmp r2, #1
	moveq r0, r11
	beq _02055EE0
	sub r0, r1, #2
	cmp r2, r0
	moveq r0, #3
	movne r0, #2
_02055EE0:
	add r2, r0, r10
	ldrh ip, [r5, #0x1e]
	ldrh r3, [r5, #0x20]
	ldr r1, [r5, #0x2c]
	sub r0, r8, r4
	add r2, r3, r2
	orr r2, r2, ip, lsl #12
	mov r3, r0, lsl #1
	add r0, r1, r7, lsl #1
	strh r2, [r3, r0]
	add r8, r8, #1
	cmp r8, r9
	blt _02055EA0
_02055F14:
	ldr r0, [sp, #0x18]
	add r1, r0, #1
	ldr r0, [sp, #0x10]
	str r1, [sp, #0x18]
	cmp r1, r0
	blt _02055E2C
_02055F2C:
	ldr r0, [sp, #8]
	ldrh r1, [r5, #0x1e]
	mov r2, r0, lsl #1
	ldr r0, [sp, #4]
	ldr r3, [r5, #0x2c]
	orr r0, r0, r1, lsl #12
	ldr r1, [sp, #8]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add r1, r3, r1, lsl #1
	bl MIi_CpuClear16
	ldr r0, [sp, #0xc]
	strh r4, [r5, #0x24]
	strh r0, [r5, #0x26]
	ldr r0, [sp, #0x14]
	strh r0, [r5, #0x28]
	ldr r0, [sp, #0x1c]
	strh r0, [r5, #0x2a]
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end FontAniHeader__Unknown__Func_2055D08

	arm_func_start FontWindowAnimator__Unknown__InitDynamicBG
FontWindowAnimator__Unknown__InitDynamicBG: // 0x02055F7C
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x1c
	mov r6, r1
	mov r5, r0
	mov r0, r6
	bl GetBackgroundPixels
	ldr r0, [r0]
	mov r0, r0, lsr #8
	bl _AllocTailHEAP_USER
	mov r4, r0
	mov r0, r6
	bl GetBackgroundPixels
	mov r1, r4
	bl RenderCore_CPUCopyCompressed
	mov r0, #0x10
	str r0, [sp]
	stmib sp, {r0, r5}
	mov r0, #2
	str r0, [sp, #0xc]
	mov r2, #0
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r0, r4
	mov r1, #5
	mov r3, r2
	str r2, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
	mov r0, #0x10
	str r0, [sp]
	str r0, [sp, #4]
	add r0, r5, #0x80
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r3, #0
	str r3, [sp, #0x10]
	str r3, [sp, #0x14]
	mov r0, r4
	mov r1, #5
	mov r2, #0x18
	str r3, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
	mov r0, #0x10
	str r0, [sp]
	str r0, [sp, #4]
	add r0, r5, #0x100
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r2, #0
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r0, r4
	mov r1, #5
	mov r3, #0x18
	str r2, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
	mov r0, #0x10
	str r0, [sp]
	str r0, [sp, #4]
	add r0, r5, #0x180
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r2, #0x18
	str r0, [sp, #0x18]
	mov r0, r4
	mov r1, #5
	mov r3, r2
	bl BackgroundUnknown__CopyPixels
	mov r3, #0x10
	str r3, [sp]
	mov r0, #8
	str r0, [sp, #4]
	add r0, r5, #0x200
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r2, #0
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r0, r4
	mov r1, #5
	str r2, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
	add r0, r5, #0x200
	add r1, r5, #0x240
	mov r2, #0x40
	bl MIi_CpuCopyFast
	add r0, r5, #0x200
	add r1, r5, #0x280
	mov r2, #0x80
	bl MIi_CpuCopyFast
	mov r3, #0x10
	str r3, [sp]
	mov r0, #8
	str r0, [sp, #4]
	add r0, r5, #0x300
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r4
	mov r1, #5
	mov r2, #0x18
	bl BackgroundUnknown__CopyPixels
	add r0, r5, #0x300
	add r1, r5, #0x340
	mov r2, #0x40
	bl MIi_CpuCopyFast
	add r0, r5, #0x300
	add r1, r5, #0x380
	mov r2, #0x80
	bl MIi_CpuCopyFast
	mov r0, #0
	add r1, r5, #0x400
	mov r2, #0x80
	bl MIi_CpuClearFast
	mov r0, #8
	str r0, [sp]
	mov r2, #0x10
	str r2, [sp, #4]
	add r0, r5, #0x400
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r3, #0
	str r3, [sp, #0x10]
	str r3, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, r4
	mov r1, #5
	bl BackgroundUnknown__CopyPixels
	mov r0, #8
	str r0, [sp]
	mov r2, #0x10
	str r2, [sp, #4]
	add r0, r5, #0x480
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r3, #0
	str r3, [sp, #0x10]
	str r3, [sp, #0x14]
	mov r0, r4
	mov r1, #5
	str r3, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
	mov r1, #8
	str r1, [sp]
	mov r2, #0x10
	str r2, [sp, #4]
	add r0, r5, #0x480
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	mov r3, #0
	str r3, [sp, #0x14]
	mov r0, r4
	mov r1, #5
	str r3, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
	mov r0, #8
	str r0, [sp]
	mov r2, #0x10
	str r2, [sp, #4]
	add r0, r5, #0x500
	str r0, [sp, #8]
	mov r0, #4
	str r0, [sp, #0xc]
	mov r3, #0
	str r3, [sp, #0x10]
	str r3, [sp, #0x14]
	mov r0, r4
	mov r1, #5
	str r3, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
	mov r1, #8
	str r1, [sp]
	mov r2, #0x10
	str r2, [sp, #4]
	add r0, r5, #0x500
	str r0, [sp, #8]
	mov r0, #4
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	mov r3, #0
	str r3, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, r4
	mov r1, #5
	bl BackgroundUnknown__CopyPixels
	mov r0, #8
	str r0, [sp]
	mov r2, #0x10
	str r2, [sp, #4]
	add r0, r5, #0x500
	str r0, [sp, #8]
	mov r0, #4
	str r0, [sp, #0xc]
	str r2, [sp, #0x10]
	mov r3, #0
	str r3, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, r4
	mov r1, #5
	bl BackgroundUnknown__CopyPixels
	mov r0, #8
	str r0, [sp]
	mov r2, #0x10
	str r2, [sp, #4]
	add r0, r5, #0x500
	str r0, [sp, #8]
	mov r0, #4
	str r0, [sp, #0xc]
	mov r0, #0x18
	str r0, [sp, #0x10]
	mov r3, #0
	str r3, [sp, #0x14]
	mov r0, r4
	mov r1, #5
	str r3, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
	add r1, r5, #0x600
	mov r0, #0
	mov r2, #0x80
	bl MIi_CpuClearFast
	mov r0, #8
	str r0, [sp]
	mov r2, #0x10
	str r2, [sp, #4]
	add r0, r5, #0x600
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r3, #0
	str r3, [sp, #0x10]
	str r3, [sp, #0x14]
	mov r0, r4
	mov r1, #5
	str r3, [sp, #0x18]
	mov r3, #0x18
	bl BackgroundUnknown__CopyPixels
	mov r0, #8
	str r0, [sp]
	mov r2, #0x10
	str r2, [sp, #4]
	add r0, r5, #0x680
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r4
	mov r1, #5
	mov r3, #0x18
	bl BackgroundUnknown__CopyPixels
	mov r1, #8
	str r1, [sp]
	mov r2, #0x10
	str r2, [sp, #4]
	add r0, r5, #0x680
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r4
	mov r1, #5
	mov r3, #0x18
	bl BackgroundUnknown__CopyPixels
	mov r0, #8
	str r0, [sp]
	mov r2, #0x10
	str r2, [sp, #4]
	add r0, r5, #0x700
	str r0, [sp, #8]
	mov r0, #4
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r4
	mov r1, #5
	mov r3, #0x18
	bl BackgroundUnknown__CopyPixels
	mov r1, #8
	str r1, [sp]
	mov r2, #0x10
	str r2, [sp, #4]
	add r0, r5, #0x700
	str r0, [sp, #8]
	mov r0, #4
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	mov ip, #0
	str ip, [sp, #0x14]
	mov r0, r4
	mov r1, #5
	mov r3, #0x18
	str ip, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
	mov r0, #8
	str r0, [sp]
	mov r2, #0x10
	str r2, [sp, #4]
	add r0, r5, #0x700
	str r0, [sp, #8]
	mov r0, #4
	str r0, [sp, #0xc]
	str r2, [sp, #0x10]
	mov ip, #0
	str ip, [sp, #0x14]
	mov r0, r4
	mov r1, #5
	mov r3, #0x18
	str ip, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
	mov r0, #8
	str r0, [sp]
	mov r2, #0x10
	str r2, [sp, #4]
	add r0, r5, #0x700
	str r0, [sp, #8]
	mov r0, #4
	str r0, [sp, #0xc]
	mov r3, #0x18
	str r3, [sp, #0x10]
	mov r1, #0
	str r1, [sp, #0x14]
	str r1, [sp, #0x18]
	mov r0, r4
	mov r1, #5
	bl BackgroundUnknown__CopyPixels
	mov r0, #8
	mov r2, #0x10
	add r5, r5, #0x800
	str r0, [sp]
	stmib sp, {r0, r5}
	mov r0, #1
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r4
	mov r1, #5
	mov r3, r2
	bl BackgroundUnknown__CopyPixels
	mov r0, r5
	add r1, r5, #0x20
	mov r2, #0x20
	bl MIi_CpuCopyFast
	mov r0, r5
	add r1, r5, #0x40
	mov r2, #0x40
	bl MIi_CpuCopyFast
	mov r0, r5
	add r1, r5, #0x80
	mov r2, #0x80
	bl MIi_CpuCopyFast
	mov r0, r5
	add r1, r5, #0x100
	mov r2, #0x100
	bl MIi_CpuCopyFast
	mov r0, r4
	bl _FreeHEAP_USER
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, pc}
	arm_func_end FontWindowAnimator__Unknown__InitDynamicBG

    .rodata

_021103CC: // 0x021103CC
	.hword 6, 8, 0xC, 0xA, 9, 0x10, 0xE, 4, 3, 2, 1, 0, 0xD

_021103E6: // _021103E6
    .hword 8, 0x10, 0x20, 0x40

_021103EE: // 0x021103EE
    .hword 0, 0, 0x4000, 0xFFFF, 0, 0x4000, 0x8000, 0xFFFF, 0x4000
	.hword 0x8000, 0x8000, 0xC000, 0xFFFF, 0xFFFF, 0xC000, 0xC000
	.align 4

	.data

_0211996C: // 0x0211996C
	.word FontWindowAnimator__Unknown__DrawMappings, FontWindowAnimator__Unknown__DrawRaw

_02119974: // 0x02119974
	.word FontWindowAnimator__Unknown__Func_2055398, FontWindowAnimator__Unknown__DrawDynamic2
