	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start Task__Unknown204BE48__Create
Task__Unknown204BE48__Create: // 0x0204BE48
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	ldrh r5, [sp, #0x44]
	ldrb r4, [sp, #0x48]
	mov r6, r3
	mov r9, r0
	mov r8, r1
	str r5, [sp]
	mov r7, r2
	ldrb r3, [sp, #0x40]
	ldr r0, _0204BEFC // =Task__Unknown204BE48__Main
	ldr r1, _0204BF00 // =Task__Unknown204BE48__Destructor
	str r4, [sp, #4]
	mov r4, #0x28
	mov r2, #0
	str r4, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x28
	bl MIi_CpuClear16
	str r9, [r4]
	strh r8, [r4, #0xc]
	str r7, [r4, #4]
	ldr r1, [sp, #0x30]
	str r6, [r4, #8]
	ldrh r0, [sp, #0x28]
	str r1, [r4, #0x18]
	ldrh r1, [sp, #0x2c]
	strh r0, [r4, #0xe]
	ldrsh r0, [sp, #0x34]
	strh r1, [r4, #0x12]
	ldr r1, [sp, #0x38]
	strh r0, [r4, #0x1c]
	ldr r0, [sp, #0x3c]
	str r1, [r4, #0x20]
	str r0, [r4, #0x24]
	mov r1, #0x1000
	mov r0, r5
	strh r1, [r4, #0x14]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0204BEFC: .word Task__Unknown204BE48__Main
_0204BF00: .word Task__Unknown204BE48__Destructor
	arm_func_end Task__Unknown204BE48__Create

	arm_func_start Task__Unknown204BE48__Func_204BF04
Task__Unknown204BE48__Func_204BF04: // 0x0204BF04
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r1
	mov r4, r2
	bl GetTaskWork_
	str r5, [r0, #0x20]
	str r4, [r0, #0x24]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end Task__Unknown204BE48__Func_204BF04

	arm_func_start Task__Unknown204BE48__Func_204BF20
Task__Unknown204BE48__Func_204BF20: // 0x0204BF20
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	bx lr
_0204BF2C: // jump table
	bx lr // case 0
	bx lr // case 1
	bx lr // case 2
	bx lr // case 3
	b _0204BF44 // case 4
	bx lr // case 5
_0204BF44:
	cmp r2, #0
	movne r0, #0
	strne r0, [r2]
	bx lr
	arm_func_end Task__Unknown204BE48__Func_204BF20

	arm_func_start Task__Unknown204BE48__LerpValue
Task__Unknown204BE48__LerpValue: // 0x0204BF54
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	mov r5, r1
	mov r0, r2
	mov r1, r3
	bl Task__Unknown204BE48__GetPercent
	sub r1, r5, r4
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r4, r1
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end Task__Unknown204BE48__LerpValue

	arm_func_start Task__Unknown204BE48__LerpVec2
Task__Unknown204BE48__LerpVec2: // 0x0204BF8C
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	ldrsh r1, [sp, #0x10]
	mov r6, r0
	mov r4, r2
	mov r0, r3
	bl Task__Unknown204BE48__GetPercent
	ldr ip, [r5]
	ldr r1, [r4, #0]
	sub r1, r1, ip
	smull r3, r2, r1, r0
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, ip, r2
	str r1, [r6]
	ldr r3, [r5, #4]
	ldr r1, [r4, #4]
	sub r1, r1, r3
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r3, r1
	str r0, [r6, #4]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end Task__Unknown204BE48__LerpVec2

	arm_func_start Task__Unknown204BE48__LerpVec3
Task__Unknown204BE48__LerpVec3: // 0x0204BFFC
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	ldrsh r1, [sp, #0x10]
	mov r6, r0
	mov r4, r2
	mov r0, r3
	bl Task__Unknown204BE48__GetPercent
	ldr ip, [r5]
	ldr r1, [r4, #0]
	sub r1, r1, ip
	smull r3, r2, r1, r0
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, ip, r2
	str r1, [r6]
	ldr ip, [r5, #4]
	ldr r1, [r4, #4]
	sub r1, r1, ip
	smull r3, r2, r1, r0
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, ip, r2
	str r1, [r6, #4]
	ldr r3, [r5, #8]
	ldr r1, [r4, #8]
	sub r1, r1, r3
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r3, r1
	str r0, [r6, #8]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end Task__Unknown204BE48__LerpVec3

	arm_func_start Task__Unknown204BE48__Rand
Task__Unknown204BE48__Rand: // 0x0204C094
	stmdb sp!, {r3, r4, r5, lr}
	ldr ip, _0204C0F4 // =_mt_math_rand
	ldr r3, _0204C0F8 // =0x0000FFC0
	ldr r4, [ip]
	ldr r0, _0204C0FC // =0x00196225
	ldr r1, _0204C100 // =0x3C6EF35F
	add r2, r3, #0x30
	mla lr, r4, r0, r1
	mla r4, lr, r0, r1
	mla r5, r4, r0, r1
	mov r0, lr, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r4, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r4, r5, lsr #0x10
	and lr, r3, r0, lsr #16
	mov r0, r4, lsl #0x10
	and r2, r2, r1, lsr #16
	mov r1, lr, lsl #4
	and r3, r3, r0, lsr #16
	orr r0, r1, r2, lsl #16
	str r5, [ip]
	orr r0, r0, r3, lsr #6
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0204C0F4: .word _mt_math_rand
_0204C0F8: .word 0x0000FFC0
_0204C0FC: .word 0x00196225
_0204C100: .word 0x3C6EF35F
	arm_func_end Task__Unknown204BE48__Rand

	arm_func_start Task__Unknown204BE48__Func_204C104
Task__Unknown204BE48__Func_204C104: // 0x0204C104
	ldr r1, _0204C130 // =0x41C64E6D
	mov ip, r0, lsl #0x10
	mul r1, r0, r1
	add r1, r1, #0x39
	ldr r2, _0204C134 // =0x000343FD
	ldr r3, _0204C138 // =0x00269EC3
	orr r0, ip, r0, lsr #16
	mla r2, r0, r2, r3
	add r0, r1, #0x3000
	eor r0, r0, r2
	bx lr
	.align 2, 0
_0204C130: .word 0x41C64E6D
_0204C134: .word 0x000343FD
_0204C138: .word 0x00269EC3
	arm_func_end Task__Unknown204BE48__Func_204C104

	arm_func_start Task__Unknown204BE48__Main
Task__Unknown204BE48__Main: // 0x0204C13C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r5, [r4, #0x20]
	ldr r6, [r4, #0x24]
	cmp r5, #0
	beq _0204C168
	mov r1, r4
	mov r2, r6
	mov r0, #0
	blx r5
_0204C168:
	ldrh r2, [r4, #0x10]
	ldrh r1, [r4, #0x12]
	cmp r1, r2
	bhi _0204C1B0
	cmp r5, #0
	beq _0204C190
	mov r1, r4
	mov r2, r6
	mov r0, #3
	blx r5
_0204C190:
	bl DestroyCurrentTask
	cmp r5, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r2, r6
	mov r0, #5
	mov r1, #0
	blx r5
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0204C1B0:
	ldr r0, [r4, #0]
	cmp r0, #0
	ldrne r7, [r4, #0x18]
	cmpne r7, #0
	beq _0204C224
	mov r0, r2, lsl #0xc
	bl _s32_div_f
	mov r2, r0, lsl #0x10
	ldrsh r3, [r4, #0x1c]
	mov r2, r2, asr #0x10
	ldmib r4, {r0, r1}
	blx r7
	ldrsh r1, [r4, #0xc]
	cmp r1, #4
	addls pc, pc, r1, lsl #2
	b _0204C224
_0204C1F0: // jump table
	b _0204C224 // case 0
	b _0204C21C // case 1
	b _0204C204 // case 2
	b _0204C224 // case 3
	b _0204C210 // case 4
_0204C204:
	ldr r1, [r4, #0]
	strh r0, [r1]
	b _0204C224
_0204C210:
	ldr r1, [r4, #0]
	str r0, [r1]
	b _0204C224
_0204C21C:
	ldr r1, [r4, #0]
	strb r0, [r1]
_0204C224:
	cmp r5, #0
	beq _0204C23C
	mov r1, r4
	mov r2, r6
	mov r0, #1
	blx r5
_0204C23C:
	ldrsh r1, [r4, #0x16]
	ldrsh r0, [r4, #0x14]
	add r0, r1, r0
	strh r0, [r4, #0x16]
	ldrsh r0, [r4, #0x16]
	cmp r0, #0x1000
	blt _0204C28C
_0204C258:
	ldrsh r0, [r4, #0x16]
	sub r0, r0, #0x1000
	strh r0, [r4, #0x16]
	ldrh r0, [r4, #0xe]
	cmp r0, #0
	subne r0, r0, #1
	strneh r0, [r4, #0xe]
	ldreqh r0, [r4, #0x10]
	addeq r0, r0, #1
	streqh r0, [r4, #0x10]
	ldrsh r0, [r4, #0x16]
	cmp r0, #0x1000
	bge _0204C258
_0204C28C:
	cmp r5, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r1, r4
	mov r2, r6
	mov r0, #2
	blx r5
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end Task__Unknown204BE48__Main

	arm_func_start Task__Unknown204BE48__Destructor
Task__Unknown204BE48__Destructor: // 0x0204C2A8
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	mov r1, r0
	ldr r2, [r1, #0]
	cmp r2, #0
	beq _0204C2E0
	ldrsh r0, [r1, #0xc]
	cmp r0, #2
	ldreq r0, [r1, #8]
	streqh r0, [r2]
	beq _0204C2E0
	cmp r0, #4
	ldreq r0, [r1, #8]
	streq r0, [r2]
_0204C2E0:
	ldr r3, [r1, #0x20]
	cmp r3, #0
	ldmeqia sp!, {r3, pc}
	ldr r2, [r1, #0x24]
	mov r0, #4
	blx r3
	ldmia sp!, {r3, pc}
	arm_func_end Task__Unknown204BE48__Destructor

	arm_func_start Task__Unknown204BE48__GetPercent
Task__Unknown204BE48__GetPercent: // 0x0204C2FC
	cmp r0, #0
	ble _0204C30C
	cmp r0, #0x1000
	blt _0204C324
_0204C30C:
	cmp r0, #0
	movlt r0, #0
	bxlt lr
	cmp r0, #0x1000
	movgt r0, #0x1000
	bx lr
_0204C324:
	cmp r1, #0
	ble _0204C340
	rsb r0, r0, #0x1000
	mul r2, r0, r0
	mov r3, r2, asr #0xc
	mov ip, #1
	b _0204C35C
_0204C340:
	bxge lr
	mul r2, r0, r0
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r3, r2, asr #0xc
	mov r1, r1, asr #0x10
	mov ip, #0
_0204C35C:
	cmp r1, #0x1000
	ble _0204C388
_0204C364:
	mul r2, r3, r3
	sub r0, r1, #0x1000
	mov r0, r0, lsl #0x10
	mov r1, r0, asr #0x10
	mov r2, r2, lsl #4
	mov r0, r3
	cmp r1, #0x1000
	mov r3, r2, asr #0x10
	bgt _0204C364
_0204C388:
	sub r2, r3, r0
	smull r3, r1, r2, r1
	cmp ip, #0
	beq _0204C3B4
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r0, r0, r2
	rsb r0, r0, #0x1000
	bx lr
_0204C3B4:
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r0, r0, r2
	bx lr
	arm_func_end Task__Unknown204BE48__GetPercent