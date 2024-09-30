	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SeaMapCollision__GetCollisionAtPoint
SeaMapCollision__GetCollisionAtPoint: // 0x0204A55C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x190]
	mov r1, r5
	mov r2, r4
	bl SeaMapCollision__GetCollision
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapCollision__GetCollisionAtPoint

	arm_func_start SeaMapCollision__Collide
SeaMapCollision__Collide: // 0x0204A580
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r4, r2
	mov r6, r0
	mov r5, r1
	bl SeaMapManager__GetWork
	cmp r4, #0
	ldr r4, [r0, #0x190]
	beq _0204A5D4
	add r2, sp, #2
	add r3, sp, #0
	mov r0, r6
	mov r1, r5
	bl SeaMapManager__Func_2043BEC
	ldrh r0, [sp, #2]
	ldrh r1, [sp]
	bl SeaMapManager__GetMapPixel
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r3, r4, r5, r6, pc}
_0204A5D4:
	mov r1, r6, lsl #0xd
	mov r2, r5, lsl #0xd
	mov r0, r4
	mov r1, r1, lsr #0x10
	mov r2, r2, lsr #0x10
	bl SeaMapCollision__GetCollision
	ldr r2, _0204A60C // =SeaMapCollision__CollideTable
	and r3, r6, #7
	ldr r2, [r2, r0, lsl #2]
	and r1, r5, #7
	mov r0, r3
	blx r2
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0204A60C: .word SeaMapCollision__CollideTable
	arm_func_end SeaMapCollision__Collide

	arm_func_start SeaMapCollision__HandleCollisions
SeaMapCollision__HandleCollisions: // 0x0204A610
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	str r0, [sp]
	str r1, [sp, #4]
	mov r7, r2
	mov r6, r3
	ldr r5, [sp, #0x4c]
	ldr r11, [sp, #0x48]
	ldr r4, [sp, #0x50]
	bl SeaMapManager__GetWork
	ldr r0, [sp]
	sub r2, r0, r7
	ldr r0, [sp, #4]
	sub r1, r0, r6
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	movs r0, r0, asr #0x10
	rsbmi r0, r0, #0
	mov r1, r1, asr #0x10
	mov r0, r0, lsl #0x10
	cmp r1, #0
	rsblt r1, r1, #0
	strh r7, [r5]
	mov r9, r0, lsr #0x10
	mov r8, r1, lsl #0x10
	strh r6, [r4]
	cmp r9, r8, lsr #16
	bls _0204A770
	ldr r0, [sp, #4]
	cmp r6, r0
	movlo r0, #1
	strlo r0, [sp, #0x10]
	mvnhs r0, #0
	strhs r0, [sp, #0x10]
	ldr r0, [sp]
	cmp r7, r0
	bhs _0204A6B4
	mov r0, #1
	mov r1, r7
	str r0, [sp, #0x1c]
	b _0204A6C4
_0204A6B4:
	mov r1, r0
	str r7, [sp]
	mvn r0, #0
	str r0, [sp, #0x1c]
_0204A6C4:
	add r0, r1, #1
	mov r1, r0, lsl #0x10
	ldr r0, [sp]
	mov r10, #0
	cmp r0, r1, lsr #16
	mov r0, r1, lsr #0x10
	str r0, [sp, #0x14]
	blo _0204A85C
_0204A6E4:
	ldr r0, [sp, #0x1c]
	add r1, r10, r8, lsr #16
	add r0, r7, r0
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	mov r0, r1, lsl #0x10
	cmp r9, r0, lsr #16
	mov r10, r0, lsr #0x10
	bhi _0204A724
	ldr r0, [sp, #0x10]
	sub r2, r10, r9
	add r1, r6, r0
	mov r0, r2, lsl #0x10
	mov r10, r0, lsr #0x10
	mov r0, r1, lsl #0x10
	mov r6, r0, lsr #0x10
_0204A724:
	mov r0, r7
	mov r1, r6
	mov r2, r11
	bl SeaMapCollision__Collide
	cmp r0, #0
	addne sp, sp, #0x20
	movne r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0x14]
	strh r7, [r5]
	add r0, r0, #1
	strh r6, [r4]
	mov r1, r0, lsl #0x10
	ldr r0, [sp]
	cmp r0, r1, lsr #16
	mov r0, r1, lsr #0x10
	str r0, [sp, #0x14]
	bhs _0204A6E4
	b _0204A85C
_0204A770:
	ldr r0, [sp]
	cmp r7, r0
	movlo r0, #1
	strlo r0, [sp, #0xc]
	mvnhs r0, #0
	strhs r0, [sp, #0xc]
	ldr r0, [sp, #4]
	cmp r6, r0
	bhs _0204A7A4
	mov r0, #1
	mov r1, r6
	str r0, [sp, #0x18]
	b _0204A7B4
_0204A7A4:
	mov r1, r0
	str r6, [sp, #4]
	mvn r0, #0
	str r0, [sp, #0x18]
_0204A7B4:
	add r0, r1, #1
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #4]
	mov r10, #0
	cmp r0, r1, lsr #16
	mov r0, r1, lsr #0x10
	str r0, [sp, #8]
	blo _0204A85C
_0204A7D4:
	ldr r0, [sp, #0x18]
	add r1, r10, r9
	add r0, r6, r0
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	mov r0, r1, lsl #0x10
	mov r10, r0, lsr #0x10
	cmp r10, r8, lsr #16
	blo _0204A814
	ldr r0, [sp, #0xc]
	sub r2, r10, r8, lsr #16
	add r1, r7, r0
	mov r0, r2, lsl #0x10
	mov r10, r0, lsr #0x10
	mov r0, r1, lsl #0x10
	mov r7, r0, lsr #0x10
_0204A814:
	mov r0, r7
	mov r1, r6
	mov r2, r11
	bl SeaMapCollision__Collide
	cmp r0, #0
	addne sp, sp, #0x20
	movne r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #8]
	strh r7, [r5]
	add r0, r0, #1
	strh r6, [r4]
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #4]
	cmp r0, r1, lsr #16
	mov r0, r1, lsr #0x10
	str r0, [sp, #8]
	bhs _0204A7D4
_0204A85C:
	mov r0, #0
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end SeaMapCollision__HandleCollisions

	arm_func_start SeaMapCollision__UpdateMapCollision
SeaMapCollision__UpdateMapCollision: // 0x0204A868
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x70
	bl SeaMapManager__GetWork
	ldr r7, [r0, #0x190]
	ldr r6, _0204A904 // =_0211021C
	add r5, sp, #0
	mov r4, #7
_0204A884:
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	subs r4, r4, #1
	bne _0204A884
	mov r9, #0
	mov r11, r9
	add r6, sp, #0
	mov r4, #0x1c
_0204A8A4:
	mla r10, r9, r4, r6
	add r0, r9, #0x2e
	mov r0, r0, lsl #0x10
	mov r8, r11
	mov r5, r0, lsr #0x10
_0204A8B8:
	add r0, r8, #0xb
	mov r1, r0, lsl #0x10
	ldr r3, [r10, r8, lsl #2]
	mov r0, r7
	mov r2, r5
	mov r1, r1, lsr #0x10
	bl SeaMapManager__SetMapCollision
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #7
	blo _0204A8B8
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #4
	blo _0204A8A4
	add sp, sp, #0x70
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0204A904: .word _0211021C
	arm_func_end SeaMapCollision__UpdateMapCollision

	arm_func_start SeaMapCollision__GetCollision
SeaMapCollision__GetCollision: // 0x0204A908
	ldrh r3, [r0, #0]
	add ip, r0, #4
	tst r1, #1
	mov r0, r3, asr #1
	mul r0, r2, r0
	add r0, r0, r1, asr #1
	ldrb r0, [ip, r0]
	movne r0, r0, lsl #0x18
	moveq r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1c
	bx lr
	arm_func_end SeaMapCollision__GetCollision

	arm_func_start SeaMapManager__SetMapCollision
SeaMapManager__SetMapCollision: // 0x0204A934
	ldrh ip, [r0], #4
	tst r1, #1
	mov ip, ip, asr #1
	mul ip, r2, ip
	add ip, ip, r1, asr #1
	ldrb r2, [r0, ip]
	and r1, r3, #0xff
	beq _0204A968
	mov r1, r1, lsl #0x1c
	bic r2, r2, #0xf0
	orr r1, r2, r1, lsr #24
	strb r1, [r0, ip]
	bx lr
_0204A968:
	and r1, r1, #0xf
	bic r2, r2, #0xf
	orr r1, r2, r1
	strb r1, [r0, ip]
	bx lr
	arm_func_end SeaMapManager__SetMapCollision

	arm_func_start SeaMapCollision__CollideFunc_6
SeaMapCollision__CollideFunc_6: // 0x0204A97C
	mov r0, #0
	bx lr
	arm_func_end SeaMapCollision__CollideFunc_6

	arm_func_start SeaMapCollision__CollideFunc_0
SeaMapCollision__CollideFunc_0: // 0x0204A984
	mov r0, #0
	bx lr
	arm_func_end SeaMapCollision__CollideFunc_0

	arm_func_start SeaMapCollision__CollideFunc_1
SeaMapCollision__CollideFunc_1: // 0x0204A98C
	mov r0, #1
	bx lr
	arm_func_end SeaMapCollision__CollideFunc_1

	arm_func_start SeaMapCollision__CollideFunc_2
SeaMapCollision__CollideFunc_2: // 0x0204A994
	rsb r0, r0, #7
	and r0, r0, #0xff
	cmp r1, r0
	movhs r0, #1
	movlo r0, #0
	bx lr
	arm_func_end SeaMapCollision__CollideFunc_2

	arm_func_start SeaMapCollision__CollideFunc_3
SeaMapCollision__CollideFunc_3: // 0x0204A9AC
	cmp r1, r0
	movhs r0, #1
	movlo r0, #0
	bx lr
	arm_func_end SeaMapCollision__CollideFunc_3

	arm_func_start SeaMapCollision__CollideFunc_4
SeaMapCollision__CollideFunc_4: // 0x0204A9BC
	rsb r0, r0, #7
	and r0, r0, #0xff
	cmp r1, r0
	movls r0, #1
	movhi r0, #0
	bx lr
	arm_func_end SeaMapCollision__CollideFunc_4

	arm_func_start SeaMapCollision__CollideFunc_5
SeaMapCollision__CollideFunc_5: // 0x0204A9D4
	cmp r1, r0
	movls r0, #1
	movhi r0, #0
	bx lr
	arm_func_end SeaMapCollision__CollideFunc_5

	.rodata 

SeaMapCollision__CollideTable: // 0x021101DC
	.word SeaMapCollision__CollideFunc_0
	.word SeaMapCollision__CollideFunc_1
	.word SeaMapCollision__CollideFunc_2
	.word SeaMapCollision__CollideFunc_3
	.word SeaMapCollision__CollideFunc_4
	.word SeaMapCollision__CollideFunc_5
	.word SeaMapCollision__CollideFunc_6
	.word SeaMapCollision__CollideFunc_6
	.word SeaMapCollision__CollideFunc_6
	.word SeaMapCollision__CollideFunc_6
	.word SeaMapCollision__CollideFunc_6
	.word SeaMapCollision__CollideFunc_6
	.word SeaMapCollision__CollideFunc_6
	.word SeaMapCollision__CollideFunc_6
	.word SeaMapCollision__CollideFunc_6
	.word SeaMapCollision__CollideFunc_6

_0211021C: // 0x0211021C
	.word 0, 2, 1, 1, 1, 3, 0, 2, 1, 1, 1, 1, 1, 3, 1, 1, 1
	.word 1, 1, 1, 1, 5, 1, 1, 1, 1, 1, 4