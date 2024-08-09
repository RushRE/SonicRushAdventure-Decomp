	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start OS_CheckHeap
OS_CheckHeap: // 0x037FD1D0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	mov r6, #0
	mov r5, r6
	mvn r4, #0
	bl OS_DisableInterrupts
	ldr r1, _037FD37C // =0x03808590
	ldr ip, [r1, r8, lsl #2]
	mov r1, r4
	cmp r7, r1
	ldreq r7, [ip]
	ldr r2, [ip, #0x10]
	cmp r2, #0
	beq _037FD36C
	cmp r7, #0
	blt _037FD36C
	ldr r1, [ip, #4]
	cmp r7, r1
	bge _037FD36C
	mov r1, #0xc
	mul r1, r7, r1
	add r3, r2, r1
	ldr r2, [r2, r1]
	cmp r2, #0
	blt _037FD36C
	ldr r1, [r3, #8]
	cmp r1, #0
	beq _037FD2B8
	ldr r7, [r1]
	cmp r7, #0
	bne _037FD36C
	b _037FD2B8
_037FD254:
	ldr r7, [ip, #8]
	cmp r7, r1
	bhi _037FD36C
	ldr r7, [ip, #0xc]
	cmp r1, r7
	bhs _037FD36C
	ands r7, r1, #0x1f
	bne _037FD36C
	ldr lr, [r1, #4]
	cmp lr, #0
	beq _037FD28C
	ldr r7, [lr]
	cmp r7, r1
	bne _037FD36C
_037FD28C:
	ldr r7, [r1, #8]
	cmp r7, #0x40
	blo _037FD36C
	ands r1, r7, #0x1f
	bne _037FD36C
	add r6, r6, r7
	cmp r6, #0
	ble _037FD36C
	cmp r6, r2
	bgt _037FD36C
	mov r1, lr
_037FD2B8:
	cmp r1, #0
	bne _037FD254
	ldr r1, [r3, #4]
	cmp r1, #0
	beq _037FD35C
	ldr r3, [r1]
	cmp r3, #0
	bne _037FD36C
	b _037FD35C
_037FD2DC:
	ldr r3, [ip, #8]
	cmp r3, r1
	bhi _037FD36C
	ldr r3, [ip, #0xc]
	cmp r1, r3
	bhs _037FD36C
	ands r3, r1, #0x1f
	bne _037FD36C
	ldr lr, [r1, #4]
	cmp lr, #0
	beq _037FD314
	ldr r3, [lr]
	cmp r3, r1
	bne _037FD36C
_037FD314:
	ldr r7, [r1, #8]
	cmp r7, #0x40
	blo _037FD36C
	ands r3, r7, #0x1f
	bne _037FD36C
	cmp lr, #0
	beq _037FD33C
	add r1, r1, r7
	cmp r1, lr
	bhs _037FD36C
_037FD33C:
	add r6, r6, r7
	sub r1, r7, #0x20
	add r5, r5, r1
	cmp r6, #0
	ble _037FD36C
	cmp r6, r2
	bgt _037FD36C
	mov r1, lr
_037FD35C:
	cmp r1, #0
	bne _037FD2DC
	cmp r6, r2
	moveq r4, r5
_037FD36C:
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_037FD37C: .word 0x03808590
	arm_func_end OS_CheckHeap

	arm_func_start OS_CreateHeap
OS_CreateHeap: // 0x037FD380
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r6, r1
	mov r5, r2
	bl OS_DisableInterrupts
	ldr r1, _037FD424 // =0x03808590
	ldr r7, [r1, r4, lsl #2]
	add r1, r6, #0x1f
	bic r6, r1, #0x1f
	bic r5, r5, #0x1f
	mov r4, #0
	ldr lr, [r7, #4]
	mov r1, #0xc
	b _037FD408
_037FD3BC:
	ldr r3, [r7, #0x10]
	mul r2, r4, r1
	add ip, r3, r2
	ldr r2, [r3, r2]
	cmp r2, #0
	bge _037FD404
	sub r1, r5, r6
	str r1, [ip]
	mov r2, #0
	str r2, [r6]
	str r2, [r6, #4]
	ldr r1, [ip]
	str r1, [r6, #8]
	str r6, [ip, #4]
	str r2, [ip, #8]
	bl OS_RestoreInterrupts
	mov r0, r4
	b _037FD418
_037FD404:
	add r4, r4, #1
_037FD408:
	cmp r4, lr
	blt _037FD3BC
	bl OS_RestoreInterrupts
	mvn r0, #0
_037FD418:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_037FD424: .word 0x03808590
	arm_func_end OS_CreateHeap

	arm_func_start OS_InitAlloc
OS_InitAlloc: // 0x037FD428
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r0
	mov r5, r1
	mov r4, r2
	mov r6, r3
	bl OS_DisableInterrupts
	ldr r1, _037FD4CC // =0x03808590
	str r5, [r1, r7, lsl #2]
	mov r2, #0xc
	mul r1, r6, r2
	add r3, r5, #0x14
	str r3, [r5, #0x10]
	str r6, [r5, #4]
	mov r8, #0
	mvn lr, #0
	mov ip, r8
	b _037FD48C
_037FD46C:
	ldr r6, [r5, #0x10]
	mul r3, r8, r2
	add r7, r6, r3
	str lr, [r6, r3]
	str ip, [r7, #8]
	ldr r3, [r7, #8]
	str r3, [r7, #4]
	add r8, r8, #1
_037FD48C:
	ldr r3, [r5, #4]
	cmp r8, r3
	blt _037FD46C
	mvn r2, #0
	str r2, [r5]
	ldr r2, [r5, #0x10]
	add r1, r2, r1
	add r1, r1, #0x1f
	bic r1, r1, #0x1f
	str r1, [r5, #8]
	bic r1, r4, #0x1f
	str r1, [r5, #0xc]
	bl OS_RestoreInterrupts
	ldr r0, [r5, #8]
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_037FD4CC: .word 0x03808590
	arm_func_end OS_InitAlloc

	arm_func_start OS_SetCurrentHeap
OS_SetCurrentHeap: // 0x037FD4D0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r5, r1
	bl OS_DisableInterrupts
	ldr r1, _037FD508 // =0x03808590
	ldr r1, [r1, r4, lsl #2]
	ldr r4, [r1]
	str r5, [r1]
	bl OS_RestoreInterrupts
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037FD508: .word 0x03808590
	arm_func_end OS_SetCurrentHeap

	arm_func_start OS_FreeToHeap
OS_FreeToHeap: // 0x037FD50C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r4, r1
	mov r6, r2
	bl OS_DisableInterrupts
	mov r5, r0
	ldr r0, _037FD57C // =0x03808590
	ldr r0, [r0, r7, lsl #2]
	cmp r4, #0
	ldrlt r4, [r0]
	sub r6, r6, #0x20
	ldr r1, [r0, #0x10]
	mov r0, #0xc
	mla r7, r4, r0, r1
	ldr r0, [r7, #8]
	mov r1, r6
	bl DLExtract
	str r0, [r7, #8]
	ldr r0, [r7, #4]
	mov r1, r6
	bl DLInsert
	str r0, [r7, #4]
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_037FD57C: .word 0x03808590
	arm_func_end OS_FreeToHeap

	arm_func_start OS_AllocFromHeap
OS_AllocFromHeap: // 0x037FD580
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	mov r5, r1
	mov r7, r2
	bl OS_DisableInterrupts
	mov r4, r0
	ldr r1, _037FD694 // =0x03808590
	ldr r1, [r1, r6, lsl #2]
	cmp r1, #0
	bne _037FD5B8
	bl OS_RestoreInterrupts
	mov r0, #0
	b _037FD688
_037FD5B8:
	cmp r5, #0
	ldrlt r5, [r1]
	ldr r1, [r1, #0x10]
	mov r0, #0xc
	mla r6, r5, r0, r1
	add r0, r7, #0x20
	add r0, r0, #0x1f
	bic r7, r0, #0x1f
	ldr r0, [r6, #4]
	mov r5, r0
	b _037FD5F4
_037FD5E4:
	ldr r1, [r5, #8]
	cmp r7, r1
	ble _037FD5FC
	ldr r5, [r5, #4]
_037FD5F4:
	cmp r5, #0
	bne _037FD5E4
_037FD5FC:
	cmp r5, #0
	bne _037FD614
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #0
	b _037FD688
_037FD614:
	ldr r1, [r5, #8]
	sub r1, r1, r7
	cmp r1, #0x40
	bhs _037FD634
	mov r1, r5
	bl DLExtract
	str r0, [r6, #4]
	b _037FD66C
_037FD634:
	str r7, [r5, #8]
	add r2, r5, r7
	str r1, [r2, #8]
	ldr r0, [r5]
	str r0, [r5, r7]
	ldr r0, [r5, #4]
	str r0, [r2, #4]
	ldr r0, [r2, #4]
	cmp r0, #0
	strne r2, [r0]
	ldr r0, [r2]
	cmp r0, #0
	strne r2, [r0, #4]
	streq r2, [r6, #4]
_037FD66C:
	ldr r0, [r6, #8]
	mov r1, r5
	bl DLAddFront
	str r0, [r6, #8]
	mov r0, r4
	bl OS_RestoreInterrupts
	add r0, r5, #0x20
_037FD688:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_037FD694: .word 0x03808590
	arm_func_end OS_AllocFromHeap

	arm_func_start DLInsert
DLInsert: // 0x037FD698
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov ip, r0
	mov lr, #0
	b _037FD6BC
_037FD6AC:
	cmp r1, ip
	bls _037FD6C4
	mov lr, ip
	ldr ip, [ip, #4]
_037FD6BC:
	cmp ip, #0
	bne _037FD6AC
_037FD6C4:
	str ip, [r1, #4]
	str lr, [r1]
	cmp ip, #0
	beq _037FD704
	str r1, [ip]
	ldr r3, [r1, #8]
	add r2, r1, r3
	cmp r2, ip
	bne _037FD704
	ldr r2, [ip, #8]
	add r2, r3, r2
	str r2, [r1, #8]
	ldr ip, [ip, #4]
	str ip, [r1, #4]
	cmp ip, #0
	strne r1, [ip]
_037FD704:
	cmp lr, #0
	beq _037FD73C
	str r1, [lr, #4]
	ldr r2, [lr, #8]
	add r3, lr, r2
	cmp r3, r1
	bne _037FD740
	ldr r1, [r1, #8]
	add r1, r2, r1
	str r1, [lr, #8]
	str ip, [lr, #4]
	cmp ip, #0
	strne lr, [ip]
	b _037FD740
_037FD73C:
	mov r0, r1
_037FD740:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end DLInsert

	arm_func_start DLExtract
DLExtract: // 0x037FD74C
	ldr r3, [r1, #4]
	cmp r3, #0
	ldrne r2, [r1]
	strne r2, [r3]
	ldr r2, [r1]
	cmp r2, #0
	ldreq r0, [r1, #4]
	ldrne r1, [r1, #4]
	strne r1, [r2, #4]
	bx lr
	arm_func_end DLExtract

	arm_func_start DLAddFront
DLAddFront: // 0x037FD774
	str r0, [r1, #4]
	mov r2, #0
	str r2, [r1]
	cmp r0, #0
	strne r1, [r0]
	mov r0, r1
	bx lr
	arm_func_end DLAddFront
