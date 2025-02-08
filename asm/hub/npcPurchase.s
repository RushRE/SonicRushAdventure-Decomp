	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start NpcPurchase__Init
NpcPurchase__Init: // 0x0216E330
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	add r0, r4, #8
	str r1, [r4]
	bl FontWindowAnimator__Init
	add r1, r4, #0x6c
	mov r0, #0
	mov r2, #0x64
	bl MIi_CpuClear16
	add r1, r4, #0xd0
	mov r0, #0
	mov r2, #0x64
	bl MIi_CpuClear16
	add r1, r4, #0x134
	mov r0, #0
	mov r2, #0x7d0
	bl MIi_CpuClear16
	add r0, r4, #0x104
	add r1, r0, #0x800
	mov r0, #0
	mov r2, #0x200
	bl MIi_CpuClear32
	ldmia sp!, {r4, pc}
	arm_func_end NpcPurchase__Init

	arm_func_start NpcPurchase__Load
NpcPurchase__Load: // 0x0216E390
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x40
	ldr r9, [sp, #0x70]
	mov r10, r0
	str r1, [sp, #0x28]
	str r2, [sp, #0x2c]
	str r3, [sp, #0x30]
	bl NpcPurchase__Release
	ldr r0, [sp, #0x28]
	ldr r1, _0216E870 // =0x00300010
	strh r0, [r10, #4]
	ldr r0, _0216E874 // =0x04001000
	strh r9, [r10, #6]
	ldr r2, [r0, #0]
	sub r0, r1, #0x200000
	and r2, r2, r1
	cmp r2, r0
	bgt _0216E3F0
	bge _0216E42C
	cmp r2, #0x10
	ldreq r0, _0216E878 // =Sprite__GetSpriteSize1FromAnim
	ldreq r11, _0216E87C // =Sprite__GetSpriteSize1
	streq r0, [sp, #0x3c]
	b _0216E438
_0216E3F0:
	sub r0, r1, #0x100000
	cmp r2, r0
	bgt _0216E404
	beq _0216E41C
	b _0216E438
_0216E404:
	cmp r2, r1
	bne _0216E438
	ldr r0, _0216E880 // =Sprite__GetSpriteSize4FromAnim
	ldr r11, _0216E884 // =Sprite__GetSpriteSize4
	str r0, [sp, #0x3c]
	b _0216E438
_0216E41C:
	ldr r0, _0216E888 // =Sprite__GetSpriteSize3FromAnim
	ldr r11, _0216E88C // =Sprite__GetSpriteSize3
	str r0, [sp, #0x3c]
	b _0216E438
_0216E42C:
	ldr r0, _0216E890 // =Sprite__GetSpriteSize2FromAnim
	ldr r11, _0216E894 // =Sprite__GetSpriteSize2
	str r0, [sp, #0x3c]
_0216E438:
	mov r0, #8
	bl _ZN10HubControl17GetFileFrom_ViActEt
	blx r11
	add r0, r10, #0x104
	mov r5, #0
	mov r7, r5
	add r8, r0, #0x800
	mov r6, #0x10
_0216E458:
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ViMap__Func_215C98C
	mov r1, r5, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r4, r0
	bl AnimatorSprite__SetAnimation
	mov r0, #0
	str r0, [r4, #0x48]
	str r8, [r4, #0x4c]
	strb r0, [r4, #0x56]
	mov r0, #1
	strb r0, [r4, #0x57]
	cmp r5, #5
	movlt r0, #0x72
	strlth r6, [r4, #8]
	subge r0, r7, #0xa4
	strgeh r0, [r4, #8]
	movge r0, #0x96
	strh r0, [r4, #0xa]
	cmp r5, #0
	movne r0, #0x10
	strne r0, [r4, #0x3c]
	strneh r9, [r4, #0x50]
	bne _0216E4C8
	mov r0, #0
	str r0, [r4, #0x3c]
	strh r0, [r4, #0x50]
_0216E4C8:
	add r6, r6, #0x24
	add r7, r7, #0x24
	add r5, r5, #1
	cmp r5, #9
	blt _0216E458
	mov r0, #2
	bl _ZN10HubControl17GetFileFrom_ViActEt
	mov r4, r0
	blx r11
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r2, #1
	str r2, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r3, _0216E898 // =0x05000600
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	mov r0, #2
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r1, r4
	add r0, r10, #0x6c
	mov r3, r2
	bl AnimatorSprite__Init
	ldrh r0, [sp, #0x6c]
	str r0, [sp, #0x34]
	ldr r1, [sp, #0x34]
	mov r0, #3
	strh r1, [r10, #0xbc]
	bl _ZN10HubControl17GetFileFrom_ViActEt
	ldr r2, [sp, #0x3c]
	mov r1, #0
	mov r5, r0
	blx r2
	mov r1, r0
	mov r0, #1
	add r4, r10, #0xd0
	bl VRAMSystem__AllocSpriteVram
	mov r1, r5
	mov r5, #1
	str r5, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r3, _0216E898 // =0x05000600
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r0, r4
	mov r3, r2
	str r5, [sp, #0x18]
	bl AnimatorSprite__Init
	mov r0, #0xa0
	strh r0, [r4, #8]
	mov r0, #0x90
	strh r0, [r4, #0xa]
	ldr r0, [sp, #0x34]
	add r0, r0, #1
	strh r0, [r4, #0x50]
	mov r0, #0xa
	bl _ZN10HubControl17GetFileFrom_ViActEt
	mov r7, r0
	blx r11
	mov r8, r0
	ldr r0, [sp, #0x34]
	mov r9, #0
	add r0, r0, #2
	mov r0, r0, lsl #0x10
	mov r11, r5
	add r6, r10, #0x134
	mov r4, r0, lsr #0x10
	mov r5, r9
_0216E5F4:
	mov r0, #1
	mov r1, r8
	bl VRAMSystem__AllocSpriteVram
	str r11, [sp]
	str r5, [sp, #4]
	str r0, [sp, #8]
	mov r2, r9, lsl #0x10
	ldr r0, _0216E898 // =0x05000600
	str r5, [sp, #0xc]
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	mov r0, r6
	mov r1, r7
	mov r2, r2, lsr #0x10
	mov r3, r5
	str r5, [sp, #0x18]
	bl AnimatorSprite__Init
	add r9, r9, #1
	strh r4, [r6, #0x50]
	add r6, r6, #0x64
	cmp r9, #0xa
	blt _0216E5F4
	add r0, r10, #0x134
	add r6, r0, #0x3e8
	ldr r0, [sp, #0x34]
	mov r9, #0xa
	add r0, r0, #3
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	mov r11, #1
	mov r5, #0
_0216E670:
	mov r0, #1
	mov r1, r8
	bl VRAMSystem__AllocSpriteVram
	str r11, [sp]
	str r5, [sp, #4]
	str r0, [sp, #8]
	mov r2, r9, lsl #0x10
	ldr r0, _0216E898 // =0x05000600
	str r5, [sp, #0xc]
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	mov r0, r6
	mov r1, r7
	mov r2, r2, lsr #0x10
	mov r3, r5
	str r5, [sp, #0x18]
	bl AnimatorSprite__Init
	add r9, r9, #1
	strh r4, [r6, #0x50]
	add r6, r6, #0x64
	cmp r9, #0x14
	blt _0216E670
	add r0, r10, #8
	bl FontWindowAnimator__Init
	bl _ZN10HubControl10GetField54Ev
	ldr r1, [sp, #0x28]
	mov r4, #1
	and r3, r1, #0xff
	mov r1, r0
	mov r2, #0
	str r4, [sp]
	str r2, [sp, #4]
	mov r0, #0xd
	str r0, [sp, #8]
	mov r0, #0x1a
	str r0, [sp, #0xc]
	mov r0, #0xb
	str r0, [sp, #0x10]
	str r4, [sp, #0x14]
	ldrh r4, [sp, #0x68]
	str r3, [sp, #0x18]
	add r0, r10, #8
	and r4, r4, #0xff
	str r4, [sp, #0x1c]
	ldr r4, [sp, #0x2c]
	mov r3, r2
	str r4, [sp, #0x20]
	ldr r4, [sp, #0x30]
	str r4, [sp, #0x24]
	bl FontWindowAnimator__Load1
	add r0, r10, #0x304
	add r0, r0, #0x800
	str r0, [sp, #0x38]
	mov r9, #0
_0216E748:
	mov r0, r9, lsl #0x10
	mov r0, r0, lsr #0x10
	bl NpcPurchase__HasMaterial
	cmp r0, #0
	bne _0216E770
	ldr r0, _0216E89C // =0x0000FFFF
	ldr r1, [sp, #0x38]
	mov r2, #4
	bl MIi_CpuClear16
	b _0216E7FC
_0216E770:
	mov r0, r9, lsl #0x10
	mov r0, r0, lsr #0x10
	bl NpcPurchase__GetMaterialCount
	mov r8, r0
	mov r11, #0xa
	cmp r8, #0x63
	ldr r5, _0216E89C // =0x0000FFFF
	movgt r8, #0x63
	mov r7, #1
	add r6, r10, r9, lsl #2
	mov r4, r11
_0216E79C:
	mov r0, r8
	mov r1, r11
	bl FX_DivS32
	mul r2, r0, r4
	add r1, r6, r7, lsl #1
	sub r2, r8, r2
	add r1, r1, #0xb00
	mov r8, r0
	strh r2, [r1, #4]
	cmp r7, #1
	bge _0216E7D4
	ldrh r0, [r1, #4]
	cmp r0, #0
	streqh r5, [r1, #4]
_0216E7D4:
	subs r7, r7, #1
	bpl _0216E79C
	add r0, r10, r9, lsl #2
	add r0, r0, #0xb00
	ldrh r2, [r0, #6]
	ldr r1, _0216E89C // =0x0000FFFF
	cmp r2, r1
	ldreqh r2, [r0, #4]
	streqh r2, [r0, #6]
	streqh r1, [r0, #4]
_0216E7FC:
	ldr r0, [sp, #0x38]
	add r9, r9, #1
	add r0, r0, #4
	cmp r9, #9
	str r0, [sp, #0x38]
	blt _0216E748
	bl NpcPurchase__GetRingCount
	mov r4, #0xa
	ldr r1, _0216E8A0 // =0x000F423F
	mov r5, r0
	cmp r5, r1
	movgt r5, r1
	mov r6, #5
	mov r7, r4
_0216E834:
	mov r0, r5
	mov r1, r4
	bl FX_DivS32
	mul r2, r0, r7
	add r1, r10, r6, lsl #1
	sub r2, r5, r2
	add r1, r1, #0xb00
	mov r5, r0
	strh r2, [r1, #0x28]
	subs r6, r6, #1
	bpl _0216E834
	mov r0, #1
	str r0, [r10]
	add sp, sp, #0x40
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216E870: .word 0x00300010
_0216E874: .word 0x04001000
_0216E878: .word Sprite__GetSpriteSize1FromAnim
_0216E87C: .word Sprite__GetSpriteSize1
_0216E880: .word Sprite__GetSpriteSize4FromAnim
_0216E884: .word Sprite__GetSpriteSize4
_0216E888: .word Sprite__GetSpriteSize3FromAnim
_0216E88C: .word Sprite__GetSpriteSize3
_0216E890: .word Sprite__GetSpriteSize2FromAnim
_0216E894: .word Sprite__GetSpriteSize2
_0216E898: .word 0x05000600
_0216E89C: .word 0x0000FFFF
_0216E8A0: .word 0x000F423F
	arm_func_end NpcPurchase__Load

	arm_func_start NpcPurchase__Release
NpcPurchase__Release: // 0x0216E8A4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	add r0, r6, #8
	bl FontWindowAnimator__Release
	add r0, r6, #0xd0
	bl AnimatorSprite__Release
	add r5, r6, #0x134
	mov r4, #0
_0216E8C4:
	mov r0, r5
	bl AnimatorSprite__Release
	add r4, r4, #1
	cmp r4, #0x14
	add r5, r5, #0x64
	blt _0216E8C4
	add r0, r6, #0x6c
	bl AnimatorSprite__Release
	mov r0, #0
	str r0, [r6]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NpcPurchase__Release

	arm_func_start NpcPurchase__Process
NpcPurchase__Process: // 0x0216E8F0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	ldr r1, _0216EC40 // =ovl05_021731B4
	mov r10, r0
	ldrh r4, [r1, #0]
	ldrh r3, [r1, #2]
	ldrh r2, [r1, #4]
	ldrh r1, [r1, #6]
	ldr r0, [r10, #0]
	strh r4, [sp, #0xc]
	strh r3, [sp, #0xe]
	strh r2, [sp, #8]
	strh r1, [sp, #0xa]
	cmp r0, #3
	bne _0216EAB8
	add r0, r10, #8
	bl FontWindowAnimator__Draw
	ldrsh r0, [sp, #0xc]
	ldrsh r11, [sp, #0xe]
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
_0216E948:
	ldr r0, [sp, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ViMap__Func_215C98C
	bl AnimatorSprite__DrawFrame
	ldr r0, [sp, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ViMap__Func_215C98C
	ldrsh r1, [r0, #8]
	ldr r0, [sp, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	strh r1, [r10, #0x74]
	bl ViMap__Func_215C98C
	ldrsh r1, [r0, #0xa]
	add r0, r10, #0x6c
	strh r1, [r10, #0x76]
	bl AnimatorSprite__DrawFrame
	ldr r0, [sp, #4]
	ldr r9, [sp]
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	ldr r0, [sp, #4]
	mov r8, #0
	add r5, r10, #0x134
	add r6, r10, r0, lsl #2
_0216E9B4:
	add r0, r6, r8, lsl #1
	add r0, r0, #0xb00
	ldrh r1, [r0, #4]
	ldr r0, _0216EC44 // =0x0000FFFF
	cmp r1, r0
	beq _0216EA14
	mov r0, #0x64
	mla r7, r1, r0, r5
	mov r0, r4
	bl ViMap__Func_215C98C
	ldrsh r1, [r0, #8]
	mov r0, r4
	strh r1, [r7, #8]
	bl ViMap__Func_215C98C
	ldrsh r1, [r0, #0xa]
	mov r0, r7
	strh r1, [r7, #0xa]
	ldrsh r1, [r7, #8]
	add r1, r1, r9
	strh r1, [r7, #8]
	ldrsh r1, [r7, #0xa]
	add r1, r1, r11
	strh r1, [r7, #0xa]
	bl AnimatorSprite__DrawFrame
_0216EA14:
	add r8, r8, #1
	cmp r8, #2
	add r9, r9, #8
	blt _0216E9B4
	ldr r0, [sp, #4]
	add r0, r0, #1
	str r0, [sp, #4]
	cmp r0, #9
	blt _0216E948
	add r0, r10, #0xd0
	bl AnimatorSprite__DrawFrame
	ldrsh r6, [sp, #8]
	ldrsh r7, [sp, #0xa]
	ldr r4, _0216EC44 // =0x0000FFFF
	mov r8, #0
	add r5, r10, #0x134
	mov r9, #0x64
_0216EA58:
	add r0, r10, r8, lsl #1
	add r0, r0, #0xb00
	ldrh r0, [r0, #0x28]
	cmp r0, r4
	beq _0216EAA0
	add r1, r0, #0xa
	mla r0, r1, r9, r5
	ldrsh r1, [r10, #0xd8]
	strh r1, [r0, #8]
	ldrsh r1, [r10, #0xda]
	strh r1, [r0, #0xa]
	ldrsh r1, [r0, #8]
	add r1, r1, r6
	strh r1, [r0, #8]
	ldrsh r1, [r0, #0xa]
	add r1, r1, r7
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
_0216EAA0:
	add r8, r8, #1
	cmp r8, #6
	add r6, r6, #9
	blt _0216EA58
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0216EAB8:
	cmp r0, #2
	bne _0216EBAC
	add r0, r10, #8
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r10, #8
	bl FontWindowAnimator__Draw
	add r0, r10, #8
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r10, #8
	bl FontWindowAnimator__SetWindowOpen
	mov r1, #0
	mov r2, r1
	add r0, r10, #0x6c
	bl AnimatorSprite__ProcessAnimation
	mov r6, #0
	add r5, r10, #0x134
	mov r4, r6
_0216EB08:
	mov r0, r5
	mov r1, r4
	mov r2, r4
	bl AnimatorSprite__ProcessAnimation
	add r6, r6, #1
	cmp r6, #0x14
	add r5, r5, #0x64
	blt _0216EB08
	mov r1, #0
	mov r2, r1
	add r0, r10, #0xd0
	bl AnimatorSprite__ProcessAnimation
	add r0, r10, #0x104
	ldr r5, _0216EC48 // =0x00003DEF
	add r6, r0, #0x800
	mov r7, #0
	mov r4, #0x20
_0216EB4C:
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	bl NpcPurchase__HasMaterial
	cmp r0, #0
	bne _0216EB70
	mov r0, r5
	mov r1, r6
	mov r2, r4
	bl MIi_CpuClear16
_0216EB70:
	add r7, r7, #1
	cmp r7, #9
	add r6, r6, #0x20
	blt _0216EB4C
	ldrh r1, [r10, #6]
	add r0, r10, #0x104
	add r0, r0, #0x800
	mov r3, r1, lsl #9
	mov r1, #0x100
	mov r2, #4
	bl QueueUncompressedPalette
	mov r0, #3
	add sp, sp, #0x10
	str r0, [r10]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0216EBAC:
	cmp r0, #4
	bne _0216EC1C
	add r0, r10, #8
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r10, #8
	bl FontWindowAnimator__Draw
	add r0, r10, #8
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r4, _0216EC4C // =0x04001000
	ldrh r0, [r10, #4]
	ldr r3, [r4, #0]
	mov r1, #1
	ldr r2, [r4, #0]
	mvn r0, r1, lsl r0
	and r3, r3, #0x1f00
	bic r1, r2, #0x1f00
	and r0, r0, r3, lsr #8
	orr r1, r1, r0, lsl #8
	add r0, r10, #8
	str r1, [r4]
	bl FontWindowAnimator__SetWindowClosed
	mov r0, #5
	add sp, sp, #0x10
	str r0, [r10]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0216EC1C:
	cmp r0, #5
	addne sp, sp, #0x10
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r10, #8
	bl FontWindowAnimator__SetWindowOpen
	mov r0, #1
	str r0, [r10]
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216EC40: .word ovl05_021731B4
_0216EC44: .word 0x0000FFFF
_0216EC48: .word 0x00003DEF
_0216EC4C: .word 0x04001000
	arm_func_end NpcPurchase__Process

	arm_func_start NpcPurchase__ProcessGraphics
NpcPurchase__ProcessGraphics: // 0x0216EC50
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r4, r0
	add r0, r4, #8
	bl FontWindowAnimator__Func_20599B4
	ldr r5, _0216ED0C // =0x04001000
	ldrh r0, [r4, #4]
	ldr r3, [r5, #0]
	mov r1, #1
	ldr r2, [r5, #0]
	mov r0, r1, lsl r0
	and r3, r3, #0x1f00
	orr r0, r0, r3, lsr #8
	bic r2, r2, #0x1f00
	orr r0, r2, r0, lsl #8
	str r0, [r5]
	mov r3, #0
	add r0, r4, #8
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #8
	bl FontWindowAnimator__StartAnimating
	mov r6, #0
	mov r5, r6
_0216ECB4:
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ViMap__Func_215C98C
	mov r1, r5
	mov r2, r5
	bl AnimatorSprite__ProcessAnimation
	add r6, r6, #1
	cmp r6, #9
	blt _0216ECB4
	mov r0, #0
	bl ViMap__Func_215C98C
	ldr r1, [r0, #0x3c]
	orr r1, r1, #0x10
	str r1, [r0, #0x3c]
	mov r0, #0
	bl ViMap__Func_215C98C
	ldrh r2, [r4, #6]
	mov r1, #2
	strh r2, [r0, #0x50]
	str r1, [r4]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0216ED0C: .word 0x04001000
	arm_func_end NpcPurchase__ProcessGraphics

	arm_func_start NpcPurchase__Func_216ED10
NpcPurchase__Func_216ED10: // 0x0216ED10
	ldr r0, [r0, #0]
	cmp r0, #3
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end NpcPurchase__Func_216ED10

	arm_func_start NpcPurchase__Func_216ED24
NpcPurchase__Func_216ED24: // 0x0216ED24
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r3, #0
	add r0, r4, #8
	mov r1, #4
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #8
	bl FontWindowAnimator__StartAnimating
	mov r0, #4
	str r0, [r4]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end NpcPurchase__Func_216ED24

	arm_func_start NpcPurchase__Func_216ED60
NpcPurchase__Func_216ED60: // 0x0216ED60
	ldr r0, [r0, #0]
	cmp r0, #1
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end NpcPurchase__Func_216ED60

	arm_func_start NpcPurchase__HasMaterial
NpcPurchase__HasMaterial: // 0x0216ED74
	stmdb sp!, {r3, lr}
	mov r1, r0
	cmp r1, #9
	movhs r0, #0
	ldmhsia sp!, {r3, pc}
	ldr r0, _0216ED94 // =saveGame+0x00000028
	bl SaveGame__HasMaterial
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216ED94: .word saveGame+0x00000028
	arm_func_end NpcPurchase__HasMaterial

	arm_func_start NpcPurchase__GetMaterialCount
NpcPurchase__GetMaterialCount: // 0x0216ED98
	stmdb sp!, {r3, lr}
	mov r1, r0
	cmp r1, #9
	movhs r0, #0
	ldmhsia sp!, {r3, pc}
	ldr r0, _0216EDB8 // =saveGame+0x00000028
	bl SaveGame__GetMaterialCount
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216EDB8: .word saveGame+0x00000028
	arm_func_end NpcPurchase__GetMaterialCount

	arm_func_start NpcPurchase__GetRingCount
NpcPurchase__GetRingCount: // 0x0216EDBC
	ldr r0, _0216EDC8 // =saveGame
	ldr r0, [r0, #0x1bc]
	bx lr
	.align 2, 0
_0216EDC8: .word saveGame
	arm_func_end NpcPurchase__GetRingCount

	.rodata

.public ovl05_021731B4
ovl05_021731B4: // 0x021731B4
    .hword 0x10, 0x10, 0x1A, 0xC, 0x28, 0xB8, 0x28C0, 0x14B