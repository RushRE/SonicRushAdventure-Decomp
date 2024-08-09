	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailRival__Create
SailRival__Create: // 0x02187D8C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	movs r5, r2
	mov r6, r1
	mov r2, #0
	mov r7, r0
	cmpeq r6, #0
	orreq r0, r2, #2
	moveq r0, r0, lsl #0x10
	moveq r2, r0, lsr #0x10
	mov r0, #1
	str r0, [sp]
	mov r3, #0
	ldr r0, _02187EFC // =SailRival__Main
	ldr r1, _02187F00 // =SailRival__Destructor
	str r3, [sp, #4]
	mov r4, #0x34
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x34
	bl MIi_CpuClear16
	str r7, [r4, #0x1c]
	cmp r6, #0
	strne r6, [r4, #0x18]
	bne _02187E44
	cmp r5, #0
	beq _02187E44
	mov r0, r5
	mov r1, #0
	bl FSRequestFileSync
	str r0, [r4, #0x18]
	ldr r0, [r4]
	orr r0, r0, #1
	str r0, [r4]
_02187E44:
	mov r3, #0
	mov r0, r3
_02187E4C:
	ldr r2, [r4, #0x18]
	add r1, r2, r0, lsl #3
	ldrh r1, [r1, #4]
	cmp r1, #0
	bne _02187ECC
	cmp r3, #0
	beq _02187E84
	ldr r1, [r2, r0, lsl #3]
	str r1, [r4, #0x2c]
	ldr r1, [r4, #0x18]
	add r0, r1, r0, lsl #3
	ldrsh r0, [r0, #6]
	strh r0, [r4, #0x30]
	b _02187EF0
_02187E84:
	ldr r2, [r2, r0, lsl #3]
	add r1, r3, #1
	str r2, [r4, #0x24]
	ldr r2, [r4, #0x18]
	mov r1, r1, lsl #0x10
	add r2, r2, r0, lsl #3
	ldrsh r2, [r2, #6]
	mov r3, r1, lsr #0x10
	strh r2, [r4, #0x28]
	ldr r1, [r4, #0x24]
	cmp r1, #0
	beq _02187ECC
	str r1, [r4, #0x2c]
	ldrsh r1, [r4, #0x28]
	mov r0, #0
	strh r1, [r4, #0x30]
	str r0, [r4, #0x24]
	b _02187EF0
_02187ECC:
	ldr r1, [r4, #0x18]
	add r1, r1, r0, lsl #3
	ldrh r1, [r1, #4]
	cmp r1, #9
	beq _02187EF0
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	b _02187E4C
_02187EF0:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02187EFC: .word SailRival__Main
_02187F00: .word SailRival__Destructor
	arm_func_end SailRival__Create

	arm_func_start SailRival__Destructor
SailRival__Destructor: // 0x02187F04
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	ldr r1, [r0]
	tst r1, #1
	ldmeqia sp!, {r3, pc}
	ldr r0, [r0, #0x18]
	bl _FreeHEAP_USER
	ldmia sp!, {r3, pc}
	arm_func_end SailRival__Destructor

	arm_func_start SailRival__Main
SailRival__Main: // 0x02187F24
	stmdb sp!, {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldrsh r0, [r4, #0x14]
	ldr r2, [r4, #0x18]
	ldr r1, [r4, #0xc]
	cmp r0, #0
	add r5, r2, r1, lsl #3
	ldr r1, [r4, #0x1c]
	subne r0, r0, #1
	strneh r0, [r4, #0x14]
	ldr r0, [r1, #0x25c]
	ldr r6, [r4, #8]
	ldr r1, [r1, #0x10]
	sub r0, r0, r6
	add r0, r1, r0
	add r0, r6, r0
	str r0, [r4, #8]
	mov r2, #0
	str r2, [r4, #0x10]
	ldr ip, [r4, #0x2c]
	ldr r3, [r4, #8]
	cmp r3, ip
	bls _02187FE0
_02187F84:
	add r1, r5, r2, lsl #3
	ldrh r0, [r1, #4]
	cmp r0, #0
	bne _02187FC0
	ldr r0, [r5, r2, lsl #3]
	cmp r3, r0
	bhi _02187FD0
	str ip, [r4, #0x24]
	ldrsh r0, [r4, #0x30]
	strh r0, [r4, #0x28]
	ldr r0, [r5, r2, lsl #3]
	str r0, [r4, #0x2c]
	ldrsh r0, [r1, #6]
	strh r0, [r4, #0x30]
	b _02187FE0
_02187FC0:
	cmp r0, #9
	ldreqsh r0, [r4, #0x30]
	streqh r0, [r4, #0x28]
	beq _02187FE0
_02187FD0:
	add r0, r2, #1
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	b _02187F84
_02187FE0:
	ldrsh r1, [r4, #0x28]
	ldrsh r0, [r4, #0x30]
	cmp r1, r0
	streqh r1, [r4, #0x20]
	beq _02188034
	ldr r2, [r4, #0x24]
	ldr r0, [r4, #8]
	ldr r1, [r4, #0x2c]
	sub r0, r0, r2
	sub r1, r1, r2
	bl FX_Div
	ldrsh r3, [r4, #0x28]
	ldrsh r1, [r4, #0x30]
	sub r1, r1, r3
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, r3
	strh r0, [r4, #0x20]
_02188034:
	mov r0, #0
	mov r2, #1
_0218803C:
	ldr lr, [r5, r0, lsl #3]
	ldr r1, [r4, #8]
	cmp lr, r1
	bhi _021880AC
	add ip, r5, r0, lsl #3
	ldrh r3, [ip, #4]
	cmp r3, #0
	beq _0218809C
	cmp r6, lr
	bhi _0218809C
	cmp r1, lr
	bls _0218809C
	cmp r3, #9
	beq _021880AC
	ldr r1, [r4, #0x10]
	orr r1, r1, r2, lsl r3
	str r1, [r4, #0x10]
	ldrh r1, [ip, #4]
	cmp r1, #1
	ldreqsh r1, [ip, #6]
	streqh r1, [r4, #0x14]
	ldr r1, [r4, #0xc]
	add r1, r1, #1
	str r1, [r4, #0xc]
_0218809C:
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	b _0218803C
_021880AC:
	ldr r0, [r4, #4]
	add r0, r0, #1
	str r0, [r4, #4]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SailRival__Main
