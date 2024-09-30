	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start FontField_9C__Init
FontField_9C__Init: // 0x02059658
	ldr ip, _0205966C // =MIi_CpuClear16
	mov r1, r0
	mov r0, #0
	mov r2, #8
	bx ip
	.align 2, 0
_0205966C: .word MIi_CpuClear16
	arm_func_end FontField_9C__Init

	arm_func_start FontField_9C__Func_2059670
FontField_9C__Func_2059670: // 0x02059670
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	movs r6, r0
	mov r5, r1
	mov r4, r2
	beq _02059714
	bl FontField_9C__IsInvalid
	cmp r0, #0
	bne _02059714
	cmp r5, #0
	beq _02059700
	mov r0, r5
	bl FontField_9C__IsInvalid
	cmp r0, #0
	bne _02059700
	ldrh r1, [r5, #0]
	ldrh r0, [r6, #0]
	cmp r0, r1
	strloh r0, [sp]
	strhsh r1, [sp]
	ldrh r1, [r5, #2]
	ldrh r0, [r6, #2]
	cmp r0, r1
	strloh r0, [sp, #2]
	strhsh r1, [sp, #2]
	ldrh r1, [r5, #4]
	ldrh r0, [r6, #4]
	cmp r0, r1
	strhih r0, [sp, #4]
	strlsh r1, [sp, #4]
	ldrh r1, [r5, #6]
	ldrh r0, [r6, #6]
	cmp r0, r1
	strhih r0, [sp, #6]
	strlsh r1, [sp, #6]
	b _02059748
_02059700:
	add r1, sp, #0
	mov r0, r6
	mov r2, #8
	bl MIi_CpuCopy16
	b _02059748
_02059714:
	cmp r5, #0
	beq _02059740
	mov r0, r5
	bl FontField_9C__IsInvalid
	cmp r0, #0
	bne _02059740
	add r1, sp, #0
	mov r0, r5
	mov r2, #8
	bl MIi_CpuCopy16
	b _02059748
_02059740:
	add r0, sp, #0
	bl FontField_9C__Init
_02059748:
	add r0, sp, #0
	mov r1, r4
	mov r2, #8
	bl MIi_CpuCopy16
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end FontField_9C__Func_2059670

	arm_func_start FontField_9C__IsInvalid
FontField_9C__IsInvalid: // 0x02059760
	ldrh r2, [r0, #0]
	ldrh r1, [r0, #4]
	cmp r2, r1
	ldrloh r1, [r0, #2]
	ldrloh r0, [r0, #6]
	cmplo r1, r0
	movhs r0, #1
	movlo r0, #0
	bx lr
	arm_func_end FontField_9C__IsInvalid