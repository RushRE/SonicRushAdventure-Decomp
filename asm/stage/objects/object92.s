	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Object92__Create
Object92__Create: // 0x0215B4C8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r0, [r4, #0x1c]
	tst r0, #0xf
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #4
	strne r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	arm_func_end Object92__Create

	arm_func_start ovl00_215B4F4
ovl00_215B4F4: // 0x0215B4F4
	stmdb sp!, {r4, lr}
	mov r1, #0x150
	mov r2, #0xf000
	mov r4, r0
	bl StageTask__SetGravity
	mov r0, #0x4000
	strh r0, [r4, #0x34]
	mov r1, #0x3000
	ldr r0, _0215B524 // =ovl00_215B528
	str r1, [r4, #0xc8]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215B524: .word ovl00_215B528
	arm_func_end ovl00_215B4F4

	arm_func_start ovl00_215B528
ovl00_215B528: // 0x0215B528
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r1, [r4, #0x1c]
	tst r1, #0xf
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	ldr r2, [r4, #0x18]
	mov r1, #0
	orr r2, r2, #4
	str r2, [r4, #0x18]
	mvn r2, #0x1b
	str r2, [sp]
	mov r2, #0x1e
	str r2, [sp, #4]
	mov r2, #0x1c
	str r2, [sp, #8]
	mov r2, #7
	str r2, [sp, #0xc]
	mov ip, #2
	sub r2, r1, #0x10000
	sub r3, r1, #0x1e
	str ip, [sp, #0x10]
	bl CreateEffectHarmfulExplosion
	mov r2, #0
	mov r0, #0x80
	sub r1, r0, #0x81
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	arm_func_end ovl00_215B528

	arm_func_start ovl00_215B5C0
ovl00_215B5C0: // 0x0215B5C0
	mov r1, #0x3000
	str r1, [r0, #0xc8]
	ldr r1, [r0, #0x20]
	tst r1, #1
	movne r1, #0x2000
	moveq r1, #0x6000
	strh r1, [r0, #0x34]
	ldr r1, _0215B5E8 // =ovl00_215B5EC
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_0215B5E8: .word ovl00_215B5EC
	arm_func_end ovl00_215B5C0

	arm_func_start ovl00_215B5EC
ovl00_215B5EC: // 0x0215B5EC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r1, [r4, #0x1c]
	tst r1, #0xf
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	ldr r2, [r4, #0x18]
	mov r1, #0
	orr r2, r2, #4
	str r2, [r4, #0x18]
	mvn r2, #0x13
	str r2, [sp]
	mov r2, #0xe
	str r2, [sp, #4]
	mov r2, #0xb
	str r2, [sp, #8]
	mov r3, #7
	mov r2, r1
	str r3, [sp, #0xc]
	mov ip, #1
	sub r3, r1, #0x11
	str ip, [sp, #0x10]
	bl CreateEffectHarmfulExplosion
	mov r2, #0
	mov r0, #0x80
	sub r1, r0, #0x81
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	arm_func_end ovl00_215B5EC

	arm_func_start ovl00_215B684
ovl00_215B684: // 0x0215B684
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	ldr r4, [r0, #0x1c]
	mov r1, #0
	ldr r2, [r4, #0x18]
	mvn r0, #0x13
	orr r2, r2, #4
	str r2, [r4, #0x18]
	str r0, [sp]
	mov r0, #0xe
	str r0, [sp, #4]
	mov r0, #0xb
	str r0, [sp, #8]
	mov r3, #7
	mov r0, r4
	mov r2, r1
	str r3, [sp, #0xc]
	mov ip, #1
	sub r3, r1, #0x11
	str ip, [sp, #0x10]
	bl CreateEffectHarmfulExplosion
	mov r2, #0
	mov r0, #0x80
	sub r1, r0, #0x81
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	arm_func_end ovl00_215B684

	arm_func_start ovl00_215B710
ovl00_215B710: // 0x0215B710
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	ldr r4, [r0, #0x1c]
	mov r1, #0
	ldr r2, [r4, #0x18]
	mvn r0, #0x13
	orr r2, r2, #4
	str r2, [r4, #0x18]
	str r0, [sp]
	mov r0, #0xe
	str r0, [sp, #4]
	mov r0, #0xb
	str r0, [sp, #8]
	mov r3, #7
	mov r0, r4
	mov r2, r1
	str r3, [sp, #0xc]
	mov ip, #1
	sub r3, r1, #0x11
	str ip, [sp, #0x10]
	bl CreateEffectHarmfulExplosion
	mov r2, #0
	mov r0, #0x80
	sub r1, r0, #0x81
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	arm_func_end ovl00_215B710

	arm_func_start ovl00_215B79C
ovl00_215B79C: // 0x0215B79C
	ldr r1, [r0, #0x1c]
	ldr r0, [r1, #0x18]
	orr r0, r0, #4
	str r0, [r1, #0x18]
	bx lr
	arm_func_end ovl00_215B79C

	arm_func_start ovl00_215B7B0
ovl00_215B7B0: // 0x0215B7B0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	ldr r4, [r0, #0x1c]
	mov r1, #0
	ldr r2, [r4, #0x18]
	mvn r0, #0x1b
	orr r2, r2, #4
	str r2, [r4, #0x18]
	str r0, [sp]
	mov r0, #0x1e
	str r0, [sp, #4]
	mov r0, #0x1c
	str r0, [sp, #8]
	mov r3, #7
	mov r0, r4
	mov r2, r1
	str r3, [sp, #0xc]
	mov ip, #2
	sub r3, r1, #0x1e
	str ip, [sp, #0x10]
	bl CreateEffectHarmfulExplosion
	mov r2, #0
	mov r0, #0x80
	sub r1, r0, #0x81
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	arm_func_end ovl00_215B7B0

	arm_func_start ovl00_215B83C
ovl00_215B83C: // 0x0215B83C
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r1, #0x1c]
	ldr r4, [r0, #0x1c]
	ldr r0, [r5, #0x18]
	tst r0, #2
	ldmneia sp!, {r3, r4, r5, pc}
	add r0, r5, #0x300
	ldrh r2, [r0, #0xc6]
	ldr r1, _0215B8B8 // =0x0218828C
	ldr r0, _0215B8BC // =0x02188290
	ldr r1, [r1, r2, lsl #3]
	ldr r2, [r0, r2, lsl #3]
	mov r0, r5
	bl CreateEffectFound
	ldr r0, [r4, #0x44]
	add r1, r5, #0x300
	str r0, [r5, #0x3a4]
	ldr r0, [r4, #0x48]
	ldr r2, _0215B8C0 // =0x021881F8
	str r0, [r5, #0x3a8]
	ldr r3, [r5, #0x37c]
	mov r0, r5
	bic r3, r3, #4
	str r3, [r5, #0x37c]
	ldrh r3, [r1, #0xc6]
	mov r3, r3, lsl #1
	ldrsh r2, [r2, r3]
	strh r2, [r1, #0xc4]
	ldr r1, [r5, #0x3b0]
	blx r1
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215B8B8: .word 0x0218828C
_0215B8BC: .word 0x02188290
_0215B8C0: .word 0x021881F8
	arm_func_end ovl00_215B83C

	arm_func_start ovl00_215B8C4
ovl00_215B8C4: // 0x0215B8C4
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r1, #0x1c]
	ldr r4, [r0, #0x1c]
	ldr r0, [r5, #0x18]
	tst r0, #2
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r3, [r4, #0x48]
	ldr r0, [r5, #0x48]
	ldr r2, [r4, #0x44]
	ldr r1, [r5, #0x44]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	ldr r1, [r5, #0x20]
	tst r1, #1
	beq _0215B91C
	ldr r1, _0215B998 // =0x00001555
	cmp r0, r1
	ldmloia sp!, {r3, r4, r5, pc}
	cmp r0, r1, lsl #1
	bls _0215B934
	ldmia sp!, {r3, r4, r5, pc}
_0215B91C:
	ldr r1, _0215B99C // =0x00005555
	cmp r0, r1
	ldmloia sp!, {r3, r4, r5, pc}
	ldr r1, _0215B9A0 // =0x00006AAA
	cmp r0, r1
	ldmhiia sp!, {r3, r4, r5, pc}
_0215B934:
	add r0, r5, #0x300
	ldrh r2, [r0, #0xc6]
	ldr r1, _0215B9A4 // =0x0218828C
	ldr r0, _0215B9A8 // =0x02188290
	ldr r1, [r1, r2, lsl #3]
	ldr r2, [r0, r2, lsl #3]
	mov r0, r5
	bl CreateEffectFound
	ldr r0, [r4, #0x44]
	add r1, r5, #0x300
	str r0, [r5, #0x3a4]
	ldr r0, [r4, #0x48]
	ldr r2, _0215B9AC // =0x021881F8
	str r0, [r5, #0x3a8]
	ldr r3, [r5, #0x37c]
	mov r0, r5
	bic r3, r3, #4
	str r3, [r5, #0x37c]
	ldrh r3, [r1, #0xc6]
	mov r3, r3, lsl #1
	ldrsh r2, [r2, r3]
	strh r2, [r1, #0xc4]
	ldr r1, [r5, #0x3b0]
	blx r1
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215B998: .word 0x00001555
_0215B99C: .word 0x00005555
_0215B9A0: .word 0x00006AAA
_0215B9A4: .word 0x0218828C
_0215B9A8: .word 0x02188290
_0215B9AC: .word 0x021881F8
	arm_func_end ovl00_215B8C4