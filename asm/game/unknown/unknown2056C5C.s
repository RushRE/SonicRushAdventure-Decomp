	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start Unknown2056C5C__Init
Unknown2056C5C__Init: // 0x02056C5C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x40
	bl MIi_CpuClear32
	mov r0, #0x1000
	strh r0, [r4, #0xc]
	strh r0, [r4, #0xe]
	ldmia sp!, {r4, pc}
	arm_func_end Unknown2056C5C__Init

	arm_func_start Unknown2056C5C__Func_2056C84
Unknown2056C5C__Func_2056C84: // 0x02056C84
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	mov r7, r1
	mov r5, r2
	mov r4, r3
	bl Unknown2056C5C__Release
	strh r7, [r6]
	mov r0, #0
	strh r0, [r6, #2]
	cmp r4, #0
	ldrneh r0, [r6, #2]
	ldrh r3, [sp, #0x1c]
	ldrh r2, [sp, #0x20]
	orrne r0, r0, #4
	strneh r0, [r6, #2]
	ldr r0, [sp, #0x18]
	str r5, [r6, #0x14]
	str r0, [r6, #0x1c]
	ldr r0, [sp, #0x24]
	strh r3, [r6, #0x18]
	mov r1, #0
	strh r2, [r6, #0x1a]
	str r1, [r6, #0x20]
	cmp r0, #0
	bne _02056D18
	mul r0, r3, r2
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	cmp r4, #0
	movne r0, r1, lsl #0x11
	movne r1, r0, lsr #0x10
	mov r0, r5
	bl Unknown2056C5C__GetSpriteSize
	mov r1, r0
	mov r0, r5
	bl VRAMSystem__AllocSpriteVram
	str r0, [sp, #0x24]
_02056D18:
	ldr r1, [sp, #0x24]
	ldr r0, [sp, #0x28]
	str r1, [r6, #0x24]
	str r0, [r6, #0x28]
	cmp r4, #0
	beq _02056D58
	ldr r1, [sp, #0x30]
	ldr r0, _02056D8C // =0x05000200
	cmp r1, r0
	bhs _02056D58
	cmp r5, #0
	moveq r0, #2
	streq r0, [r6, #0x2c]
	movne r0, #4
	strne r0, [r6, #0x2c]
	b _02056D60
_02056D58:
	mov r0, #0
	str r0, [r6, #0x2c]
_02056D60:
	ldr r1, [sp, #0x30]
	ldrh r0, [sp, #0x2c]
	str r1, [r6, #0x30]
	mov r1, #0
	strh r1, [r6, #0x34]
	strh r1, [r6, #0x36]
	strh r0, [r6, #0x38]
	strb r1, [r6, #0x3a]
	strb r1, [r6, #0x3b]
	str r1, [r6, #0x3c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02056D8C: .word 0x05000200
	arm_func_end Unknown2056C5C__Func_2056C84

	arm_func_start Unknown2056C5C__Release
Unknown2056C5C__Release: // 0x02056D90
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4]
	tst r0, #0x40
	ldrne r0, [r4, #0x1c]
	cmpne r0, #0
	beq _02056DB8
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x1c]
_02056DB8:
	ldrh r0, [r4]
	tst r0, #0x80
	ldrne r1, [r4, #0x24]
	cmpne r1, #0
	beq _02056DDC
	ldr r0, [r4, #0x14]
	bl VRAMSystem__FreeSpriteVram
	mov r0, #0
	str r0, [r4, #0x24]
_02056DDC:
	ldrh r0, [r4]
	tst r0, #0x100
	ldrne r0, [r4, #0x28]
	cmpne r0, #0
	beq _02056DFC
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x28]
_02056DFC:
	mov r0, r4
	bl Unknown2056C5C__Init
	ldmia sp!, {r4, pc}
	arm_func_end Unknown2056C5C__Release

	arm_func_start Unknown2056C5C__Func_2056E08
Unknown2056C5C__Func_2056E08: // 0x02056E08
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldrh r3, [r4, #2]
	tst r3, #1
	bne _02056EB4
	ldrh ip, [r4]
	tst ip, #1
	bne _02056EA8
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	beq _02056EA8
	ldrh r2, [r4, #0x18]
	ldrh r1, [r4, #0x1a]
	tst r3, #4
	mul r1, r2, r1
	mov r5, r1, lsl #5
	movne r5, r5, lsl #1
	tst ip, #4
	beq _02056E74
	mov r1, r5
	bl DC_StoreRange
	ldr r0, [r4, #0x1c]
	ldr r2, [r4, #0x20]
	ldr r3, [r4, #0x24]
	mov r1, r5
	bl LoadUncompressedPixels
	b _02056EA8
_02056E74:
	tst ip, #0x10
	beq _02056E8C
	ldr r1, [r4, #0x24]
	mov r2, r5
	bl MIi_CpuCopyFast
	b _02056EA8
_02056E8C:
	mov r1, r5
	bl DC_StoreRange
	ldr r0, [r4, #0x1c]
	ldr r2, [r4, #0x20]
	ldr r3, [r4, #0x24]
	mov r1, r5
	bl QueueUncompressedPixels
_02056EA8:
	ldrh r0, [r4, #2]
	orr r0, r0, #1
	strh r0, [r4, #2]
_02056EB4:
	ldrh r3, [r4, #2]
	tst r3, #2
	ldmneia sp!, {r3, r4, r5, pc}
	ldrh ip, [r4]
	tst ip, #2
	bne _02056F68
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _02056F68
	ldrh r1, [r4, #0x36]
	ldr r2, [r4, #0x30]
	tst r3, #4
	add r2, r2, r1, lsl #1
	ldrh r1, [r4, #0x34]
	addne r5, r2, r1, lsl #9
	addeq r5, r2, r1, lsl #5
	tst ip, #8
	beq _02056F20
	ldrh r1, [r4, #0x38]
	mov r1, r1, lsl #1
	bl DC_StoreRange
	ldrh r1, [r4, #0x38]
	ldr r0, [r4, #0x28]
	ldr r2, [r4, #0x2c]
	mov r3, r5
	bl LoadUncompressedPalette
	b _02056F68
_02056F20:
	tst ip, #0x20
	beq _02056F48
	ldr r1, [r4, #0x2c]
	cmp r1, #0
	beq _02056F68
	ldrh r2, [r4, #0x38]
	mov r1, r5
	mov r2, r2, lsl #1
	bl MIi_CpuCopy16
	b _02056F68
_02056F48:
	ldrh r1, [r4, #0x38]
	mov r1, r1, lsl #1
	bl DC_StoreRange
	ldrh r1, [r4, #0x38]
	ldr r0, [r4, #0x28]
	ldr r2, [r4, #0x2c]
	mov r3, r5
	bl QueueUncompressedPalette
_02056F68:
	ldrh r0, [r4, #2]
	orr r0, r0, #2
	strh r0, [r4, #2]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end Unknown2056C5C__Func_2056E08

	arm_func_start Unknown2056C5C__Func_2056F78
Unknown2056C5C__Func_2056F78: // 0x02056F78
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r3, [r4, #0x10]
	cmp r3, #0
	ldreqsh r1, [r4, #0xc]
	cmpeq r1, #0x1000
	ldreqsh r1, [r4, #0xe]
	cmpeq r1, #0x1000
	beq _02056FD0
	ldrsh r1, [r4, #0xc]
	ldrsh r2, [r4, #0xe]
	ldr r0, [r4, #0x14]
	bl Unknown2056C5C__AddAffineSprite
	mov r1, r0
	ldr r2, _02056FD8 // =0x0000FFFF
	mov r0, r4
	cmp r1, r2
	bne _02056FC8
	bl Unknown2056C5C__AddSprite1
	ldmia sp!, {r4, pc}
_02056FC8:
	bl Unknown2056C5C__AddSprite2
	ldmia sp!, {r4, pc}
_02056FD0:
	bl Unknown2056C5C__AddSprite1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02056FD8: .word 0x0000FFFF
	arm_func_end Unknown2056C5C__Func_2056F78

	arm_func_start Unknown2056FDC__Init
Unknown2056FDC__Init: // 0x02056FDC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x48
	bl MIi_CpuClear32
	mov r0, #0x1000
	strh r0, [r4, #0xc]
	strh r0, [r4, #0xe]
	ldmia sp!, {r4, pc}
	arm_func_end Unknown2056FDC__Init

	arm_func_start Unknown2056FDC__Func_2057004
Unknown2056FDC__Func_2057004: // 0x02057004
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x40
	ldr r8, [sp, #0x68]
	ldr r4, [sp, #0x74]
	mov sl, r0
	str r4, [sp, #0x74]
	str r1, [sp, #0x1c]
	mov fp, r2
	mov sb, r3
	bl Unknown2056FDC__Release
	mov r0, #0x1c0
	strh r0, [sl]
	mov r0, #0
	ldrh r1, [sp, #0x6c]
	strh r0, [sl, #2]
	cmp fp, #0
	ldrneh r0, [sl, #2]
	add r1, r1, #3
	mov r1, r1, lsl #0xe
	orrne r0, r0, #4
	strneh r0, [sl, #2]
	add r0, r8, #3
	mov r0, r0, asr #2
	str r0, [sp, #0x20]
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	mul r0, r2, r0
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x1c]
	cmp fp, #0
	str r0, [sl, #0x14]
	mov r0, #0x200
	str r0, [sp, #0x34]
	movne r0, r0, lsl #1
	strne r0, [sp, #0x34]
	ldr r1, [sp, #0x34]
	ldr r0, [sp, #0x24]
	mul r0, r1, r0
	str r0, [sl, #0x1c]
	bl _AllocHeadHEAP_USER
	str r0, [sl, #0x18]
	mov r1, r0
	ldr r2, [sl, #0x1c]
	mov r0, #0
	bl MIi_CpuClearFast
	ldrh r0, [sp, #0x6c]
	str r0, [sp, #0x28]
	mov r0, #0
	str r0, [sp, #0x38]
	ldr r0, [sp, #0x28]
	cmp r0, #0
	ble _02057210
	ldr r6, [sp, #0x38]
	mov r0, r6
	str r0, [sp, #0x30]
_020570E4:
	cmp r8, #0
	mov r5, #0
	ble _020571EC
	ldr r1, [sp, #0x28]
	ldr r0, [sp, #0x38]
	mov r7, r5
	sub r0, r1, r0
	str r0, [sp, #0x2c]
	mov r0, r0, lsl #3
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x3c]
	ldr r0, [sp, #0x30]
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
_02057120:
	sub r0, r8, r5
	cmp r0, #4
	movge r1, #0x20
	movlt r0, r0, lsl #0x13
	movlt r1, r0, lsr #0x10
	ldr r0, [sp, #0x2c]
	str r1, [sp]
	cmp r0, #4
	movge r0, #0x20
	ldrlt r0, [sp, #0x3c]
	cmp fp, #0
	str r0, [sp, #4]
	beq _02057198
	ldr r1, [sl, #0x18]
	mov r0, r6, lsl #0x10
	str r1, [sp, #8]
	mov r1, r0, lsr #0x10
	mov r0, #4
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r2, r7, lsl #0x10
	str r0, [sp, #0x18]
	mov r0, sb
	mov r1, r8
	mov r2, r2, lsr #0x10
	mov r3, r4
	bl BackgroundUnknown__Func_204CB40
	b _020571D8
_02057198:
	ldr r1, [sl, #0x18]
	mov r0, r6, lsl #0x10
	str r1, [sp, #8]
	mov r1, r0, lsr #0x10
	mov r0, #4
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r2, r7, lsl #0x10
	str r0, [sp, #0x18]
	mov r0, sb
	mov r1, r8
	mov r2, r2, lsr #0x10
	mov r3, r4
	bl BackgroundUnknown__CopyPixels
_020571D8:
	add r6, r6, #0x20
	add r7, r7, #0x20
	add r5, r5, #4
	cmp r5, r8
	blt _02057120
_020571EC:
	ldr r0, [sp, #0x38]
	add r1, r0, #4
	ldr r0, [sp, #0x28]
	str r1, [sp, #0x38]
	cmp r1, r0
	ldr r0, [sp, #0x30]
	add r0, r0, #0x20
	str r0, [sp, #0x30]
	blt _020570E4
_02057210:
	ldr r0, [sp, #0x34]
	mov r2, #0
	mov r1, r0, lsl #0xb
	ldr r0, [sp, #0x1c]
	mov r1, r1, lsr #0x10
	str r2, [sl, #0x20]
	bl Unknown2056C5C__GetSpriteSize
	ldr r1, [sp, #0x24]
	mul r1, r0, r1
	mov r1, r1, lsl #0x10
	ldr r0, [sp, #0x1c]
	mov r1, r1, lsr #0x10
	bl VRAMSystem__AllocSpriteVram
	str r0, [sl, #0x24]
	cmp fp, #0
	beq _0205725C
	mov r0, #0x200
	bl _AllocHeadHEAP_USER
	b _02057264
_0205725C:
	mov r0, #0x20
	bl _AllocHeadHEAP_USER
_02057264:
	str r0, [sl, #0x28]
	ldr r2, [sp, #0x74]
	ldr r0, [sp, #0x70]
	ldr r1, [sl, #0x28]
	mov r2, r2, lsl #1
	bl MIi_CpuCopy16
	cmp fp, #0
	beq _020572B8
	ldr r0, [sp, #0x1c]
	cmp r0, #0
	bne _020572A4
	mov r0, #2
	str r0, [sl, #0x2c]
	mov r0, #0
	str r0, [sl, #0x30]
	b _020572D4
_020572A4:
	mov r0, #4
	str r0, [sl, #0x2c]
	mov r0, #0
	str r0, [sl, #0x30]
	b _020572D4
_020572B8:
	mov r0, #0
	str r0, [sl, #0x2c]
	ldr r0, [sp, #0x1c]
	cmp r0, #0
	ldreq r0, _020573A0 // =0x05000200
	ldrne r0, _020573A4 // =0x05000600
	str r0, [sl, #0x30]
_020572D4:
	mov r1, #0
	strh r1, [sl, #0x36]
	ldr r0, [sp, #0x74]
	strh r0, [sl, #0x38]
	strb r1, [sl, #0x3a]
	strb r1, [sl, #0x3b]
	ldr r0, [sp, #0x24]
	str r1, [sl, #0x3c]
	strh r0, [sl, #0x40]
	ldr r0, [sp, #0x20]
	strh r0, [sl, #0x42]
	ldr r0, [sp, #0x24]
	mov r0, r0, lsl #6
	bl _AllocHeadHEAP_SYSTEM
	str r0, [sl, #0x44]
	ldr r0, [sp, #0x24]
	mov r6, #0
	cmp r0, #0
	addle sp, sp, #0x40
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r7, r6
	mov r5, r6
	mov r4, #4
_02057330:
	ldr r0, [sl, #0x44]
	add r0, r0, r7
	bl Unknown2056C5C__Init
	str r5, [sp]
	str r4, [sp, #4]
	str r4, [sp, #8]
	ldr r2, [sl, #0x24]
	ldr r0, [sp, #0x34]
	mov r1, r5
	mla r2, r0, r6, r2
	str r2, [sp, #0xc]
	str r5, [sp, #0x10]
	ldr r0, [sp, #0x74]
	ldr r2, [sp, #0x1c]
	str r0, [sp, #0x14]
	ldr r0, [sl, #0x30]
	mov r3, fp
	str r0, [sp, #0x18]
	ldr r0, [sl, #0x44]
	add r0, r0, r7
	bl Unknown2056C5C__Func_2056C84
	ldr r0, [sp, #0x24]
	add r6, r6, #1
	add r7, r7, #0x40
	cmp r6, r0
	blt _02057330
	add sp, sp, #0x40
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_020573A0: .word 0x05000200
_020573A4: .word 0x05000600
	arm_func_end Unknown2056FDC__Func_2057004

	arm_func_start Unknown2056FDC__Release
Unknown2056FDC__Release: // 0x020573A8
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldrh r0, [r4, #0x40]
	subs r5, r0, #1
	bmi _020573D8
	mov r6, r5, lsl #6
_020573C0:
	ldr r0, [r4, #0x44]
	add r0, r0, r6
	bl Unknown2056C5C__Release
	sub r6, r6, #0x40
	subs r5, r5, #1
	bpl _020573C0
_020573D8:
	ldr r0, [r4, #0x44]
	cmp r0, #0
	beq _020573F0
	bl _FreeHEAP_SYSTEM
	mov r0, #0
	str r0, [r4, #0x44]
_020573F0:
	ldrh r0, [r4]
	tst r0, #0x40
	ldrne r0, [r4, #0x18]
	cmpne r0, #0
	beq _02057410
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x18]
_02057410:
	ldrh r0, [r4]
	tst r0, #0x80
	ldrne r1, [r4, #0x24]
	cmpne r1, #0
	beq _02057434
	ldr r0, [r4, #0x14]
	bl VRAMSystem__FreeSpriteVram
	mov r0, #0
	str r0, [r4, #0x24]
_02057434:
	ldrh r0, [r4]
	tst r0, #0x100
	ldrne r0, [r4, #0x28]
	cmpne r0, #0
	beq _02057454
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x28]
_02057454:
	mov r0, r4
	bl Unknown2056FDC__Init
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end Unknown2056FDC__Release

	arm_func_start Unknown2056FDC__Func_2057460
Unknown2056FDC__Func_2057460: // 0x02057460
	cmp r1, #0
	ldrneh r1, [r0, #2]
	bicne r1, r1, #1
	strneh r1, [r0, #2]
	cmp r2, #0
	ldrneh r1, [r0, #2]
	bicne r1, r1, #2
	strneh r1, [r0, #2]
	bx lr
	arm_func_end Unknown2056FDC__Func_2057460

	arm_func_start Unknown2056FDC__Func_2057484
Unknown2056FDC__Func_2057484: // 0x02057484
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	tst r0, #1
	bne _0205751C
	ldrh r1, [r4]
	tst r1, #1
	bne _02057510
	ldr r0, [r4, #0x18]
	cmp r0, #0
	beq _02057510
	tst r1, #4
	ldr r5, [r4, #0x1c]
	beq _020574DC
	mov r1, r5
	bl DC_StoreRange
	ldr r0, [r4, #0x18]
	ldr r2, [r4, #0x20]
	ldr r3, [r4, #0x24]
	mov r1, r5
	bl LoadUncompressedPixels
	b _02057510
_020574DC:
	tst r1, #0x10
	beq _020574F4
	ldr r1, [r4, #0x24]
	mov r2, r5
	bl MIi_CpuCopyFast
	b _02057510
_020574F4:
	mov r1, r5
	bl DC_StoreRange
	ldr r0, [r4, #0x18]
	ldr r2, [r4, #0x20]
	ldr r3, [r4, #0x24]
	mov r1, r5
	bl QueueUncompressedPixels
_02057510:
	ldrh r0, [r4, #2]
	orr r0, r0, #1
	strh r0, [r4, #2]
_0205751C:
	ldrh r3, [r4, #2]
	tst r3, #2
	bne _020575DC
	ldrh r6, [r4]
	tst r6, #2
	bne _020575D0
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _020575D0
	ldrh r1, [r4, #0x36]
	ldr r2, [r4, #0x30]
	tst r3, #4
	add r2, r2, r1, lsl #1
	ldrh r1, [r4, #0x34]
	addne r5, r2, r1, lsl #9
	addeq r5, r2, r1, lsl #5
	tst r6, #8
	beq _02057588
	ldrh r1, [r4, #0x38]
	mov r1, r1, lsl #1
	bl DC_StoreRange
	ldrh r1, [r4, #0x38]
	ldr r0, [r4, #0x28]
	ldr r2, [r4, #0x2c]
	mov r3, r5
	bl LoadUncompressedPalette
	b _020575D0
_02057588:
	tst r6, #0x20
	beq _020575B0
	ldr r1, [r4, #0x2c]
	cmp r1, #0
	beq _020575D0
	ldrh r2, [r4, #0x38]
	mov r1, r5
	mov r2, r2, lsl #1
	bl MIi_CpuCopy16
	b _020575D0
_020575B0:
	ldrh r1, [r4, #0x38]
	mov r1, r1, lsl #1
	bl DC_StoreRange
	ldrh r1, [r4, #0x38]
	ldr r0, [r4, #0x28]
	ldr r2, [r4, #0x2c]
	mov r3, r5
	bl QueueUncompressedPalette
_020575D0:
	ldrh r0, [r4, #2]
	orr r0, r0, #2
	strh r0, [r4, #2]
_020575DC:
	ldrh r0, [r4, #0x40]
	mov r5, #0
	cmp r0, #0
	ldmleia sp!, {r4, r5, r6, pc}
	mov r6, r5
_020575F0:
	ldr r0, [r4, #0x44]
	add r0, r0, r6
	bl Unknown2056C5C__Func_2056E08
	ldrh r0, [r4, #0x40]
	add r5, r5, #1
	add r6, r6, #0x40
	cmp r5, r0
	blt _020575F0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end Unknown2056FDC__Func_2057484

	arm_func_start Unknown2056FDC__Func_2057614
Unknown2056FDC__Func_2057614: // 0x02057614
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	mov sl, r0
	ldrsh r1, [sl, #6]
	ldrsh r0, [sl, #0xa]
	ldrh r3, [sl, #0x10]
	ldrsh r4, [sl, #4]
	ldrsh r2, [sl, #8]
	sub r0, r1, r0
	cmp r3, #0
	sub r2, r4, r2
	mov r4, r0, lsl #0x10
	ldreqsh r0, [sl, #0xc]
	mov fp, r2, lsl #0x10
	cmpeq r0, #0x1000
	ldreqsh r0, [sl, #0xe]
	cmpeq r0, #0x1000
	ldreq r8, _02057778 // =0x0000FFFF
	beq _02057670
	ldrsh r1, [sl, #0xc]
	ldrsh r2, [sl, #0xe]
	ldr r0, [sl, #0x14]
	bl Unknown2056C5C__AddAffineSprite
	mov r8, r0
_02057670:
	ldrh r0, [sl, #0x40]
	mov r6, #0
	mov r5, r6
	mov r7, r6
	cmp r0, #0
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov sb, r6
_0205768C:
	ldrh r1, [sl]
	mov r0, r5, lsl #5
	ldr r2, [sl, #0x44]
	and r1, r1, #0x600
	strh r1, [r2, sb]
	ldrsh r1, [sl, #4]
	add r2, r2, sb
	mov r3, r6, lsl #5
	strh r1, [r2, #4]
	ldrsh r1, [sl, #6]
	add r0, r0, fp, asr #16
	add r3, r3, r4, asr #16
	strh r1, [r2, #6]
	ldrsh ip, [sl, #4]
	ldr r1, _02057778 // =0x0000FFFF
	sub r0, ip, r0
	strh r0, [r2, #8]
	ldrsh r0, [sl, #6]
	cmp r8, r1
	sub r0, r0, r3
	strh r0, [r2, #0xa]
	ldrsh r0, [sl, #0xc]
	strh r0, [r2, #0xc]
	ldrsh r0, [sl, #0xe]
	strh r0, [r2, #0xe]
	ldrh r0, [sl, #0x10]
	strh r0, [r2, #0x10]
	ldrh r0, [sl, #0x34]
	strh r0, [r2, #0x34]
	ldrb r0, [sl, #0x3a]
	strb r0, [r2, #0x3a]
	ldrb r0, [sl, #0x3b]
	strb r0, [r2, #0x3b]
	ldr r0, [sl, #0x3c]
	str r0, [r2, #0x3c]
	ldr r0, [sl, #0x44]
	beq _02057730
	mov r1, r8
	add r0, r0, sb
	bl Unknown2056C5C__AddSprite2
	b _02057738
_02057730:
	add r0, r0, sb
	bl Unknown2056C5C__Func_2056F78
_02057738:
	ldrh r1, [sl, #0x42]
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r5, r0, lsr #0x10
	bhi _02057760
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r5, #0
	mov r6, r0, lsr #0x10
_02057760:
	ldrh r0, [sl, #0x40]
	add r7, r7, #1
	add sb, sb, #0x40
	cmp r7, r0
	blt _0205768C
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02057778: .word 0x0000FFFF
	arm_func_end Unknown2056FDC__Func_2057614

	arm_func_start Unknown2056C5C__AllocSprite
Unknown2056C5C__AllocSprite: // 0x0205777C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	ldrh r1, [sp, #0x24]
	mov r5, r2
	mov r4, r3
	bl OAMSystem__Alloc
	ldr r1, [sp, #0x34]
	mov r3, #0
	mov r2, r1, lsl #0xa
	strh r3, [r0, #4]
	and r2, r2, #0xc00
	strh r3, [r0, #2]
	ldr r1, [sp, #0x30]
	orr r2, r2, #0
	strh r2, [r0]
	cmp r1, #0
	ldrneh r1, [r0]
	ldr r3, _02057924 // =_02110410
	ldr r2, _02057928 // =_02110430
	orrne r1, r1, #0x1000
	strneh r1, [r0]
	ldr r1, [sp, #0x14]
	add r3, r3, r4, lsl #3
	cmp r1, #0
	ldrneh r1, [r0]
	add r2, r2, r4, lsl #3
	orrne r1, r1, #0x2000
	strneh r1, [r0]
	ldrh r1, [sp, #0x10]
	ldrh lr, [r0]
	mov ip, r1, lsl #1
	ldrh r3, [ip, r3]
	ldrh r2, [ip, r2]
	ldrh ip, [sp, #0x18]
	mov r3, r3, lsl #0xe
	and r3, r3, #0xc000
	orr r3, lr, r3
	strh r3, [r0]
	mov r2, r2, lsl #0xe
	ldrh r3, [r0, #2]
	and r2, r2, #0xc000
	orr r2, r3, r2
	strh r2, [r0, #2]
	ldr r2, _0205792C // =0x000003FF
	ldrh r3, [sp, #0x20]
	ldrh lr, [r0, #4]
	and r2, ip, r2
	mov r3, r3, lsl #0xa
	orr r2, lr, r2
	strh r2, [r0, #4]
	ldrh r2, [sp, #0x1c]
	and ip, r3, #0xc00
	ldrh lr, [r0, #4]
	mov r3, r2, lsl #0xc
	and r3, r3, #0xf000
	orr r2, lr, ip
	strh r2, [r0, #4]
	ldr r2, [sp, #0x38]
	ldrh ip, [r0, #4]
	cmp r2, #0
	orr r2, ip, r3
	strh r2, [r0, #4]
	beq _020578D4
	ldrh r3, [r0]
	ldr r2, [sp, #0x40]
	orr r3, r3, #0x100
	strh r3, [r0]
	cmp r2, #0
	beq _020578B8
	mov r2, #4
	ldrh ip, [r0]
	sub r3, r6, r2, lsl r4
	sub r2, r5, r2, lsl r1
	orr r4, ip, #0x200
	mov r1, r3, lsl #0x10
	mov r2, r2, lsl #0x10
	strh r4, [r0]
	mov r6, r1, lsr #0x10
	mov r5, r2, lsr #0x10
_020578B8:
	ldrh r1, [sp, #0x3c]
	ldrh r2, [r0, #2]
	and r1, r1, #0x3e00
	mov r1, r1, lsl #0x10
	orr r1, r2, r1, lsr #7
	strh r1, [r0, #2]
	b _020578FC
_020578D4:
	ldr r1, [sp, #0x28]
	cmp r1, #0
	ldrneh r1, [r0, #2]
	orrne r1, r1, #0x1000
	strneh r1, [r0, #2]
	ldr r1, [sp, #0x2c]
	cmp r1, #0
	ldrneh r1, [r0, #2]
	orrne r1, r1, #0x2000
	strneh r1, [r0, #2]
_020578FC:
	ldrh r3, [r0]
	and r2, r5, #0xff
	ldr r1, _02057930 // =0x000001FF
	orr r2, r3, r2
	strh r2, [r0]
	ldrh r2, [r0, #2]
	and r1, r6, r1
	orr r1, r2, r1
	strh r1, [r0, #2]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02057924: .word _02110410
_02057928: .word _02110430
_0205792C: .word 0x000003FF
_02057930: .word 0x000001FF
	arm_func_end Unknown2056C5C__AllocSprite

	arm_func_start Unknown2056C5C__AddSprite1
Unknown2056C5C__AddSprite1: // 0x02057934
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x34
	mov r6, r0
	ldrh r0, [r6, #0x18]
	mov r4, #0
	mov r5, r4
	cmp r0, #8
	addls pc, pc, r0, lsl #2
	b _02057994
_02057958: // jump table
	b _02057994 // case 0
	b _0205797C // case 1
	b _02057980 // case 2
	b _02057994 // case 3
	b _02057988 // case 4
	b _02057994 // case 5
	b _02057994 // case 6
	b _02057994 // case 7
	b _02057990 // case 8
_0205797C:
	b _02057994
_02057980:
	mov r4, #1
	b _02057994
_02057988:
	mov r4, #2
	b _02057994
_02057990:
	mov r4, #3
_02057994:
	ldrh r0, [r6, #0x1a]
	cmp r0, #8
	addls pc, pc, r0, lsl #2
	b _020579E4
_020579A4: // jump table
	b _020579E4 // case 0
	b _020579C8 // case 1
	b _020579D0 // case 2
	b _020579E4 // case 3
	b _020579D8 // case 4
	b _020579E4 // case 5
	b _020579E4 // case 6
	b _020579E4 // case 7
	b _020579E0 // case 8
_020579C8:
	mov r5, #0
	b _020579E4
_020579D0:
	mov r5, #1
	b _020579E4
_020579D8:
	mov r5, #2
	b _020579E4
_020579E0:
	mov r5, #3
_020579E4:
	ldr r0, [r6, #0x14]
	ldr r1, [r6, #0x24]
	cmp r0, #0
	bne _02057A0C
	sub r1, r1, #0x6400000
	mov r1, r1, lsl #0xb
	mov r0, #0
	mov r1, r1, lsr #0x10
	bl Unknown2056C5C__GetSpriteSize
	b _02057A20
_02057A0C:
	sub r1, r1, #0x6600000
	mov r1, r1, lsl #0xb
	mov r0, #1
	mov r1, r1, lsr #0x10
	bl Unknown2056C5C__GetSpriteSize
_02057A20:
	str r5, [sp]
	ldrh r2, [r6, #2]
	mov r1, #0
	mov r3, r4
	and r2, r2, #4
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldrh r0, [r6, #0x34]
	str r0, [sp, #0xc]
	ldrb r0, [r6, #0x3a]
	str r0, [sp, #0x10]
	ldrb r0, [r6, #0x3b]
	str r0, [sp, #0x14]
	str r1, [sp, #0x18]
	str r1, [sp, #0x1c]
	ldrh r0, [r6]
	and r0, r0, #0x400
	str r0, [sp, #0x20]
	ldr r0, [r6, #0x3c]
	str r0, [sp, #0x24]
	str r1, [sp, #0x28]
	str r1, [sp, #0x2c]
	str r1, [sp, #0x30]
	ldrsh r4, [r6, #4]
	ldrsh r1, [r6, #8]
	ldrsh r2, [r6, #6]
	ldrsh r0, [r6, #0xa]
	sub r1, r4, r1
	mov r1, r1, lsl #0x10
	sub r0, r2, r0
	mov r2, r0, lsl #0x10
	ldr r0, [r6, #0x14]
	mov r1, r1, lsr #0x10
	mov r2, r2, lsr #0x10
	bl Unknown2056C5C__AllocSprite
	add sp, sp, #0x34
	ldmia sp!, {r3, r4, r5, r6, pc}
	arm_func_end Unknown2056C5C__AddSprite1

	arm_func_start Unknown2056C5C__AddSprite2
Unknown2056C5C__AddSprite2: // 0x02057AB4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x38
	mov r6, r0
	ldrh r0, [r6, #0x18]
	mov r4, #0
	mov r5, r4
	str r1, [sp, #0x34]
	cmp r0, #8
	addls pc, pc, r0, lsl #2
	b _02057B18
_02057ADC: // jump table
	b _02057B18 // case 0
	b _02057B00 // case 1
	b _02057B04 // case 2
	b _02057B18 // case 3
	b _02057B0C // case 4
	b _02057B18 // case 5
	b _02057B18 // case 6
	b _02057B18 // case 7
	b _02057B14 // case 8
_02057B00:
	b _02057B18
_02057B04:
	mov r4, #1
	b _02057B18
_02057B0C:
	mov r4, #2
	b _02057B18
_02057B14:
	mov r4, #3
_02057B18:
	ldrh r0, [r6, #0x1a]
	cmp r0, #8
	addls pc, pc, r0, lsl #2
	b _02057B68
_02057B28: // jump table
	b _02057B68 // case 0
	b _02057B4C // case 1
	b _02057B54 // case 2
	b _02057B68 // case 3
	b _02057B5C // case 4
	b _02057B68 // case 5
	b _02057B68 // case 6
	b _02057B68 // case 7
	b _02057B64 // case 8
_02057B4C:
	mov r5, #0
	b _02057B68
_02057B54:
	mov r5, #1
	b _02057B68
_02057B5C:
	mov r5, #2
	b _02057B68
_02057B64:
	mov r5, #3
_02057B68:
	ldr r0, [r6, #0x14]
	ldr r1, [r6, #0x24]
	cmp r0, #0
	bne _02057B90
	sub r1, r1, #0x6400000
	mov r1, r1, lsl #0xb
	mov r0, #0
	mov r1, r1, lsr #0x10
	bl Unknown2056C5C__GetSpriteSize
	b _02057BA4
_02057B90:
	sub r1, r1, #0x6600000
	mov r1, r1, lsl #0xb
	mov r0, #1
	mov r1, r1, lsr #0x10
	bl Unknown2056C5C__GetSpriteSize
_02057BA4:
	ldrsh r2, [r6, #0xa]
	mov lr, #4
	ldrsh r1, [r6, #0xe]
	rsb r2, r2, lr, lsl r5
	mul r8, r2, r1
	ldrsh r3, [r6, #8]
	ldrh r1, [r6, #0x10]
	ldrsh r2, [r6, #0xc]
	rsb r3, r3, lr, lsl r4
	mul r7, r3, r2
	cmp r1, #0
	beq _02057C5C
	mov r1, r1, asr #4
	mov r3, r1, lsl #1
	ldr r2, _02057D18 // =FX_SinCosTable_
	mov r1, r3, lsl #1
	ldrsh ip, [r2, r1]
	add r1, r3, #1
	mov r1, r1, lsl #1
	mov r3, ip, asr #0x1f
	ldrsh r2, [r2, r1]
	umull fp, sb, r8, ip
	smull r1, sl, r7, ip
	adds r1, r1, #0x800
	adc sl, sl, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, sl, lsl #20
	mla sb, r8, r3, sb
	mov r3, r8, asr #0x1f
	mla sb, r3, ip, sb
	smull sl, r3, r8, r2
	adds r8, sl, #0x800
	adc r3, r3, #0
	mov r8, r8, lsr #0xc
	orr r8, r8, r3, lsl #20
	add r8, r1, r8
	smull r2, r1, r7, r2
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r3, r2, lsr #0xc
	orr r3, r3, r1, lsl #20
	adds r2, fp, #0x800
	adc r1, sb, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	sub r7, r3, r2
_02057C5C:
	ldrsh r2, [r6, #4]
	ldrsh r1, [r6, #6]
	ldrh r3, [r6]
	add r2, r2, r7, asr #12
	add r1, r1, r8, asr #12
	sub r7, r2, lr, lsl r4
	sub r2, r1, lr, lsl r5
	mov r1, r7, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r2, lsr #0x10
	ands r7, r3, #0x200
	beq _02057CA8
	sub r1, r1, lr, lsl r4
	sub r2, r2, lr, lsl r5
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r2, lsr #0x10
_02057CA8:
	str r5, [sp]
	ldrh sb, [r6, #2]
	and r5, r3, #0x400
	mov r8, #0
	and r3, sb, #4
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldrh sb, [r6, #0x34]
	mov r3, r4
	mov r0, #1
	str sb, [sp, #0xc]
	ldrb r4, [r6, #0x3a]
	str r4, [sp, #0x10]
	ldrb r4, [r6, #0x3b]
	str r4, [sp, #0x14]
	str r8, [sp, #0x18]
	str r8, [sp, #0x1c]
	str r5, [sp, #0x20]
	ldr r4, [r6, #0x3c]
	str r4, [sp, #0x24]
	str r0, [sp, #0x28]
	ldr r0, [sp, #0x34]
	str r0, [sp, #0x2c]
	str r7, [sp, #0x30]
	ldr r0, [r6, #0x14]
	bl Unknown2056C5C__AllocSprite
	add sp, sp, #0x38
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02057D18: .word FX_SinCosTable_
	arm_func_end Unknown2056C5C__AddSprite2

	arm_func_start Unknown2056C5C__GetSpriteSize
Unknown2056C5C__GetSpriteSize: // 0x02057D1C
	cmp r0, #0
	ldrne r2, _02057D94 // =0x04001000
	ldrne r0, _02057D98 // =0x00300010
	ldrne r2, [r2]
	bne _02057D3C
	mov r0, #0x4000000
	ldr r2, [r0]
	ldr r0, _02057D98 // =0x00300010
_02057D3C:
	and r3, r2, r0
	ldr r2, _02057D9C // =0x00100010
	cmp r3, r2
	bgt _02057D58
	bge _02057D84
	cmp r3, #0x10
	b _02057D8C
_02057D58:
	add r0, r2, #0x100000
	cmp r3, r0
	bgt _02057D70
	moveq r0, r1, lsl #0xe
	moveq r1, r0, lsr #0x10
	b _02057D8C
_02057D70:
	add r0, r2, #0x200000
	cmp r3, r0
	moveq r0, r1, lsl #0xd
	moveq r1, r0, lsr #0x10
	b _02057D8C
_02057D84:
	mov r0, r1, lsl #0xf
	mov r1, r0, lsr #0x10
_02057D8C:
	mov r0, r1
	bx lr
	.align 2, 0
_02057D94: .word 0x04001000
_02057D98: .word 0x00300010
_02057D9C: .word 0x00100010
	arm_func_end Unknown2056C5C__GetSpriteSize

	arm_func_start Unknown2056C5C__AddAffineSprite
Unknown2056C5C__AddAffineSprite: // 0x02057DA0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x20
	movs r6, r3
	mov r7, r1
	addne r2, r2, #0x90
	addne r7, r7, #0x90
	addeq r2, r2, #0x80
	mov r5, r0
	addeq r7, r7, #0x80
	mov r0, r2
	bl FX_Inv
	mov r4, r0
	mov r0, r7
	bl FX_Inv
	mov r1, r0
	add r0, sp, #0x10
	mov r2, r4
	blx MTX_Scale22_
	mov r0, r6, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _02057E84 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0
	blx MTX_Rot22_
	add r0, sp, #0x10
	add r1, sp, #0
	mov r2, r0
	bl MTX_Concat22
	mov r0, r5
	add r1, sp, #0x10
	bl OAMSystem__AddAffineSprite
	mov r4, r0
	ldr r0, _02057E88 // =0x0000FFFF
	cmp r4, r0
	beq _02057E78
	mov r0, r5
	bl OAMSystem__GetList1
	ldr r1, [sp, #0x10]
	add r2, r0, r4, lsl #5
	mov r0, r1, asr #4
	strh r0, [r2, #6]
	ldr r0, [sp, #0x14]
	mov r0, r0, asr #4
	strh r0, [r2, #0xe]
	ldr r0, [sp, #0x18]
	mov r0, r0, asr #4
	strh r0, [r2, #0x16]
	ldr r0, [sp, #0x1c]
	mov r0, r0, asr #4
	strh r0, [r2, #0x1e]
_02057E78:
	mov r0, r4
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02057E84: .word FX_SinCosTable_
_02057E88: .word 0x0000FFFF
	arm_func_end Unknown2056C5C__AddAffineSprite

    .rodata

_02110410: // 0x02110410
	.word 0x20000
	.hword 0x02, 0xFFFF
	
	.word 0x1
	.hword 0x02, 0xFFFF
	
	.word 0x10001
	.hword 0x00, 0x02
	
	.word 0xFFFFFFFF
	.hword 0x01, 0x00

_02110430: // 0x02110430
	.word 0x00
	.hword 0x01, 0xFFFF
	
	.word 0x10000
	.hword 0x02, 0xFFFF
	
	.word 0x20001
	.hword 0x02, 0x03
	
	.word 0xFFFFFFFF
	.hword 0x03, 0x03
	
	.word 0x100
	.hword 0x100, 0x00