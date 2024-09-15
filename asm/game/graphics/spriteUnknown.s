	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SpriteUnknown__Func_204C3CC
SpriteUnknown__Func_204C3CC: // 0x0204C3CC
	stmdb sp!, {r3, lr}
	cmp r1, #0
	ldrne r3, _0204C46C // =0x04001000
	ldrne r1, _0204C470 // =0x00300010
	ldrne r3, [r3]
	bne _0204C3F0
	mov r1, #0x4000000
	ldr r3, [r1]
	ldr r1, _0204C470 // =0x00300010
_0204C3F0:
	and ip, r3, r1
	ldr r3, _0204C474 // =0x00100010
	cmp ip, r3
	bgt _0204C410
	bge _0204C440
	cmp ip, #0x10
	beq _0204C434
	b _0204C464
_0204C410:
	add r1, r3, #0x100000
	cmp ip, r1
	bgt _0204C424
	beq _0204C44C
	b _0204C464
_0204C424:
	add r1, r3, #0x200000
	cmp ip, r1
	beq _0204C458
	b _0204C464
_0204C434:
	mov r1, r2
	bl Sprite__GetSpriteSize1FromAnim
	ldmia sp!, {r3, pc}
_0204C440:
	mov r1, r2
	bl Sprite__GetSpriteSize2FromAnim
	ldmia sp!, {r3, pc}
_0204C44C:
	mov r1, r2
	bl Sprite__GetSpriteSize3FromAnim
	ldmia sp!, {r3, pc}
_0204C458:
	mov r1, r2
	bl Sprite__GetSpriteSize4FromAnim
	ldmia sp!, {r3, pc}
_0204C464:
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0204C46C: .word 0x04001000
_0204C470: .word 0x00300010
_0204C474: .word 0x00100010
	arm_func_end SpriteUnknown__Func_204C3CC

	arm_func_start SpriteUnknown__GetSpriteSize
SpriteUnknown__GetSpriteSize: // 0x0204C478
	stmdb sp!, {r3, lr}
	cmp r1, #0
	ldrne r2, _0204C508 // =0x04001000
	ldrne r1, _0204C50C // =0x00300010
	ldrne r2, [r2]
	bne _0204C49C
	mov r1, #0x4000000
	ldr r2, [r1]
	ldr r1, _0204C50C // =0x00300010
_0204C49C:
	and r3, r2, r1
	ldr r2, _0204C510 // =0x00100010
	cmp r3, r2
	bgt _0204C4BC
	bge _0204C4E8
	cmp r3, #0x10
	beq _0204C4E0
	b _0204C500
_0204C4BC:
	add r1, r2, #0x100000
	cmp r3, r1
	bgt _0204C4D0
	beq _0204C4F0
	b _0204C500
_0204C4D0:
	add r1, r2, #0x200000
	cmp r3, r1
	beq _0204C4F8
	b _0204C500
_0204C4E0:
	bl Sprite__GetSpriteSize1
	ldmia sp!, {r3, pc}
_0204C4E8:
	bl Sprite__GetSpriteSize2
	ldmia sp!, {r3, pc}
_0204C4F0:
	bl Sprite__GetSpriteSize3
	ldmia sp!, {r3, pc}
_0204C4F8:
	bl Sprite__GetSpriteSize4
	ldmia sp!, {r3, pc}
_0204C500:
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0204C508: .word 0x04001000
_0204C50C: .word 0x00300010
_0204C510: .word 0x00100010
	arm_func_end SpriteUnknown__GetSpriteSize

	arm_func_start SpriteUnknown__Func_204C514
SpriteUnknown__Func_204C514: // 0x0204C514
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r1
	mov r5, r2
	mov r7, r0
	cmp r6, r5
	mov r4, #0
	bhi _0204C558
_0204C530:
	mov r0, r7
	mov r1, r6
	bl Sprite__GetSpriteSize1FromAnim
	cmp r4, r0
	movlo r4, r0
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	cmp r5, r0, lsr #16
	mov r6, r0, lsr #0x10
	bhs _0204C530
_0204C558:
	mov r0, r4
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SpriteUnknown__Func_204C514

	arm_func_start SpriteUnknown__Func_204C560
SpriteUnknown__Func_204C560: // 0x0204C560
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r1
	add r6, r6, #4
	mov r5, #0
	ldr r2, [r6, #-4]
	sub r1, r5, #1
	mov r7, r0
	cmp r2, r1
	beq _0204C5B0
	mvn r4, #0
_0204C588:
	mov r1, r2, lsl #0x10
	mov r0, r7
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize1FromAnim
	add r6, r6, #4
	cmp r5, r0
	ldr r2, [r6, #-4]
	movlo r5, r0
	cmp r2, r4
	bne _0204C588
_0204C5B0:
	mov r0, r5
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SpriteUnknown__Func_204C560

	arm_func_start SpriteUnknown__Func_204C5B8
SpriteUnknown__Func_204C5B8: // 0x0204C5B8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r1
	mov r5, r2
	mov r7, r0
	cmp r6, r5
	mov r4, #0
	bhi _0204C5FC
_0204C5D4:
	mov r0, r7
	mov r1, r6
	bl Sprite__GetSpriteSize2FromAnim
	cmp r4, r0
	movlo r4, r0
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	cmp r5, r0, lsr #16
	mov r6, r0, lsr #0x10
	bhs _0204C5D4
_0204C5FC:
	mov r0, r4
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SpriteUnknown__Func_204C5B8

	arm_func_start SpriteUnknown__Func_204C604
SpriteUnknown__Func_204C604: // 0x0204C604
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r1
	add r6, r6, #4
	mov r5, #0
	ldr r2, [r6, #-4]
	sub r1, r5, #1
	mov r7, r0
	cmp r2, r1
	beq _0204C654
	mvn r4, #0
_0204C62C:
	mov r1, r2, lsl #0x10
	mov r0, r7
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize2FromAnim
	add r6, r6, #4
	cmp r5, r0
	ldr r2, [r6, #-4]
	movlo r5, r0
	cmp r2, r4
	bne _0204C62C
_0204C654:
	mov r0, r5
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SpriteUnknown__Func_204C604

	arm_func_start SpriteUnknown__Func_204C65C
SpriteUnknown__Func_204C65C: // 0x0204C65C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r1
	mov r5, r2
	mov r7, r0
	cmp r6, r5
	mov r4, #0
	bhi _0204C6A0
_0204C678:
	mov r0, r7
	mov r1, r6
	bl Sprite__GetSpriteSize3FromAnim
	cmp r4, r0
	movlo r4, r0
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	cmp r5, r0, lsr #16
	mov r6, r0, lsr #0x10
	bhs _0204C678
_0204C6A0:
	mov r0, r4
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SpriteUnknown__Func_204C65C

	arm_func_start SpriteUnknown__Func_204C6A8
SpriteUnknown__Func_204C6A8: // 0x0204C6A8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r1
	add r6, r6, #4
	mov r5, #0
	ldr r2, [r6, #-4]
	sub r1, r5, #1
	mov r7, r0
	cmp r2, r1
	beq _0204C6F8
	mvn r4, #0
_0204C6D0:
	mov r1, r2, lsl #0x10
	mov r0, r7
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize3FromAnim
	add r6, r6, #4
	cmp r5, r0
	ldr r2, [r6, #-4]
	movlo r5, r0
	cmp r2, r4
	bne _0204C6D0
_0204C6F8:
	mov r0, r5
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SpriteUnknown__Func_204C6A8

	arm_func_start SpriteUnknown__Func_204C700
SpriteUnknown__Func_204C700: // 0x0204C700
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r1
	mov r5, r2
	mov r7, r0
	cmp r6, r5
	mov r4, #0
	bhi _0204C744
_0204C71C:
	mov r0, r7
	mov r1, r6
	bl Sprite__GetSpriteSize4FromAnim
	cmp r4, r0
	movlo r4, r0
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	cmp r5, r0, lsr #16
	mov r6, r0, lsr #0x10
	bhs _0204C71C
_0204C744:
	mov r0, r4
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SpriteUnknown__Func_204C700

	arm_func_start SpriteUnknown__Func_204C74C
SpriteUnknown__Func_204C74C: // 0x0204C74C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r1
	add r6, r6, #4
	mov r5, #0
	ldr r2, [r6, #-4]
	sub r1, r5, #1
	mov r7, r0
	cmp r2, r1
	beq _0204C79C
	mvn r4, #0
_0204C774:
	mov r1, r2, lsl #0x10
	mov r0, r7
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize4FromAnim
	add r6, r6, #4
	cmp r5, r0
	ldr r2, [r6, #-4]
	movlo r5, r0
	cmp r2, r4
	bne _0204C774
_0204C79C:
	mov r0, r5
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SpriteUnknown__Func_204C74C

	arm_func_start SpriteUnknown__Func_204C7A4
SpriteUnknown__Func_204C7A4: // 0x0204C7A4
	stmdb sp!, {r3, lr}
	cmp r1, #0
	ldrne ip, _0204C854 // =0x04001000
	ldrne r1, _0204C858 // =0x00300010
	ldrne ip, [ip]
	bne _0204C7C8
	mov r1, #0x4000000
	ldr ip, [r1]
	ldr r1, _0204C858 // =0x00300010
_0204C7C8:
	and lr, ip, r1
	ldr ip, _0204C85C // =0x00100010
	cmp lr, ip
	bgt _0204C7E8
	bge _0204C81C
	cmp lr, #0x10
	beq _0204C80C
	b _0204C84C
_0204C7E8:
	add r1, ip, #0x100000
	cmp lr, r1
	bgt _0204C7FC
	beq _0204C82C
	b _0204C84C
_0204C7FC:
	add r1, ip, #0x200000
	cmp lr, r1
	beq _0204C83C
	b _0204C84C
_0204C80C:
	mov r1, r2
	mov r2, r3
	bl SpriteUnknown__Func_204C514
	ldmia sp!, {r3, pc}
_0204C81C:
	mov r1, r2
	mov r2, r3
	bl SpriteUnknown__Func_204C5B8
	ldmia sp!, {r3, pc}
_0204C82C:
	mov r1, r2
	mov r2, r3
	bl SpriteUnknown__Func_204C65C
	ldmia sp!, {r3, pc}
_0204C83C:
	mov r1, r2
	mov r2, r3
	bl SpriteUnknown__Func_204C700
	ldmia sp!, {r3, pc}
_0204C84C:
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0204C854: .word 0x04001000
_0204C858: .word 0x00300010
_0204C85C: .word 0x00100010
	arm_func_end SpriteUnknown__Func_204C7A4

	arm_func_start SpriteUnknown__Func_204C860
SpriteUnknown__Func_204C860: // 0x0204C860
	stmdb sp!, {r3, lr}
	cmp r1, #0
	ldrne r3, _0204C900 // =0x04001000
	ldrne r1, _0204C904 // =0x00300010
	ldrne r3, [r3]
	bne _0204C884
	mov r1, #0x4000000
	ldr r3, [r1]
	ldr r1, _0204C904 // =0x00300010
_0204C884:
	and ip, r3, r1
	ldr r3, _0204C908 // =0x00100010
	cmp ip, r3
	bgt _0204C8A4
	bge _0204C8D4
	cmp ip, #0x10
	beq _0204C8C8
	b _0204C8F8
_0204C8A4:
	add r1, r3, #0x100000
	cmp ip, r1
	bgt _0204C8B8
	beq _0204C8E0
	b _0204C8F8
_0204C8B8:
	add r1, r3, #0x200000
	cmp ip, r1
	beq _0204C8EC
	b _0204C8F8
_0204C8C8:
	mov r1, r2
	bl SpriteUnknown__Func_204C560
	ldmia sp!, {r3, pc}
_0204C8D4:
	mov r1, r2
	bl SpriteUnknown__Func_204C604
	ldmia sp!, {r3, pc}
_0204C8E0:
	mov r1, r2
	bl SpriteUnknown__Func_204C6A8
	ldmia sp!, {r3, pc}
_0204C8EC:
	mov r1, r2
	bl SpriteUnknown__Func_204C74C
	ldmia sp!, {r3, pc}
_0204C8F8:
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0204C900: .word 0x04001000
_0204C904: .word 0x00300010
_0204C908: .word 0x00100010
	arm_func_end SpriteUnknown__Func_204C860

	arm_func_start SpriteUnknown__Func_204C90C
SpriteUnknown__Func_204C90C: // 0x0204C90C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x1c
	mov r6, r1
	mov r5, r2
	mov r7, r0
	mov r0, r6
	mov r1, r5
	mov r4, r3
	ldr r9, [sp, #0x38]
	bl Sprite__GetFormatFromAnim
	cmp r0, #1
	beq _0204C994
	cmp r9, #1
	ldrne r8, _0204C9F8 // =0x05000200
	ldr r1, [sp, #0x3c]
	mov r0, r9
	ldreq r8, _0204C9FC // =0x05000600
	bl VRAMSystem__AllocSpriteVram
	str r9, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldrb r0, [sp, #0x44]
	str r8, [sp, #0x10]
	ldrb ip, [sp, #0x48]
	str r0, [sp, #0x14]
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	str ip, [sp, #0x18]
	bl AnimatorSprite__Init
	b _0204C9E8
_0204C994:
	ldr r1, [sp, #0x3c]
	cmp r9, #1
	movne r8, #2
	mov r0, r9
	moveq r8, #4
	bl VRAMSystem__AllocSpriteVram
	str r9, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r8, [sp, #0xc]
	str r1, [sp, #0x10]
	ldrb r0, [sp, #0x44]
	ldrb ip, [sp, #0x48]
	mov r1, r6
	str r0, [sp, #0x14]
	mov r0, r7
	mov r2, r5
	mov r3, r4
	str ip, [sp, #0x18]
	bl AnimatorSprite__Init
_0204C9E8:
	ldrb r0, [sp, #0x40]
	strh r0, [r7, #0x50]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0204C9F8: .word 0x05000200
_0204C9FC: .word 0x05000600
	arm_func_end SpriteUnknown__Func_204C90C
