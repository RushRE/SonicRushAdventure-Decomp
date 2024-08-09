	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start sub_2076D90
sub_2076D90: // 0x02076D90
	ldr ip, _02076D9C // =sub_2076DA0
	ldr r1, [r0, #0x140]
	bx ip
	.align 2, 0
_02076D9C: .word sub_2076DA0
	arm_func_end sub_2076D90

	arm_func_start sub_2076DA0
sub_2076DA0: // 0x02076DA0
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r1
	ldr r1, [r4, #0x10]
	mov r5, r0
	tst r1, #0x400
	beq _02076DE8
	bic r0, r1, #0x30
	str r0, [r4, #0x10]
	ldr r0, [r5, #0x20]
	tst r0, #1
	ldrne r0, [r4, #0x10]
	orrne r0, r0, #0x20
	strne r0, [r4, #0x10]
	ldr r0, [r5, #0x20]
	tst r0, #2
	ldrne r0, [r4, #0x10]
	orrne r0, r0, #0x10
	strne r0, [r4, #0x10]
_02076DE8:
	ldr r0, [r4, #0x38]
	cmp r0, #0
	beq _02076E00
	mov r0, r5
	mov r1, r4
	bl sub_20773A0
_02076E00:
	ldr r0, [r4, #0x34]
	cmp r0, #0
	beq _02076E18
	mov r0, r5
	mov r1, r4
	bl sub_20778C0
_02076E18:
	ldr r0, [r4, #0x3c]
	cmp r0, #0
	beq _02076E30
	mov r0, r5
	mov r1, r4
	bl sub_20779AC
_02076E30:
	ldr r0, [r4, #0x40]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	mov r1, r4
	bl sub_2077A80
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end sub_2076DA0

	arm_func_start ObjExWork__Init
ObjExWork__Init: // 0x02076E4C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r3, #0
	mvn r2, #0
_02076E5C:
	add r0, r3, #1
	mov r0, r0, lsl #0x10
	mov r1, r3, lsl #1
	mov r3, r0, lsr #0x10
	strh r2, [r4, r1]
	cmp r3, #4
	blo _02076E5C
	add r0, r4, #8
	mov r1, #0
	mov r2, #8
	bl MI_CpuFill8
	add r0, r4, #0x14
	mov r1, #0
	mov r2, #0xc
	bl MI_CpuFill8
	ldr r0, [r4, #0x10]
	bic r0, r0, #0xf
	bic r0, r0, #0x40
	str r0, [r4, #0x10]
	ldmia sp!, {r4, pc}
	arm_func_end ObjExWork__Init

	arm_func_start ObjExWork__Release
ObjExWork__Release: // 0x02076EAC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, #0
_02076EB8:
	add r0, r5, r4, lsl #2
	ldr r0, [r0, #0x44]
	cmp r0, #0
	beq _02076ECC
	bl ObjDataRelease
_02076ECC:
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	cmp r4, #4
	blo _02076EB8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ObjExWork__Release

	arm_func_start sub_2076EE4
sub_2076EE4: // 0x02076EE4
	str r1, [r0, #0x38]
	bx lr
	arm_func_end sub_2076EE4