	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start RingTruck3D__Create
RingTruck3D__Create: // 0x0216FBDC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r5, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _0216FCF4 // =0x00000474
	ldr r0, _0216FCF8 // =StageTask_Main
	ldr r1, _0216FCFC // =GameObject__Destructor
	mov r3, r2
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
	ldr r2, _0216FCF4 // =0x00000474
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	mov r3, #4
	ldr r0, [r4, #0x1c]
	ldr r1, _0216FD00 // =RingTruck3D__Draw_216FD0C
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	ldr r2, [r4, #0x18]
	mov r0, #8
	orr r2, r2, #0x10
	str r2, [r4, #0x18]
	str r1, [r4, #0xfc]
	str r4, [r4, #0x234]
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	add r0, r4, #0x218
	str r3, [sp, #8]
	sub r1, r3, #0xc
	sub r2, r3, #0x14
	sub r3, r3, #8
	bl ObjRect__SetBox3D
	add r0, r4, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, _0216FD04 // =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x230]
	ldr r0, _0216FD08 // =RingTruck3D__OnDefend_216FDE8
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	str r0, [r4, #0x23c]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216FCF4: .word 0x00000474
_0216FCF8: .word StageTask_Main
_0216FCFC: .word GameObject__Destructor
_0216FD00: .word RingTruck3D__Draw_216FD0C
_0216FD04: .word 0x0000FFFE
_0216FD08: .word RingTruck3D__OnDefend_216FDE8
	arm_func_end RingTruck3D__Create

	arm_func_start RingTruck3D__Draw_216FD0C
RingTruck3D__Draw_216FD0C: // 0x0216FD0C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r3, [r4, #0x11c]
	cmp r3, #0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	ldr r0, [r3, #0x18]
	tst r0, #0xc
	addne sp, sp, #0x14
	ldmneia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x354]
	tst r0, #1
	beq _0216FD9C
	mov r1, #0x100
	str r1, [sp, #0x10]
	add r0, sp, #0x10
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	add r0, r4, #0x370
	add r1, r4, #0x44
	add r3, r4, #0x38
	bl StageTask__Draw3DEx
	ldr r0, [sp, #0x10]
	tst r0, #0x40000000
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x18]
	add sp, sp, #0x14
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, pc}
_0216FD9C:
	cmp r3, #0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	ldr r1, _0216FDE4 // =0x00001104
	add r0, sp, #0x10
	str r1, [sp, #0x10]
	str r0, [sp]
	add r0, r3, #0x78
	mov r2, #0
	str r2, [sp, #4]
	str r2, [sp, #8]
	add r0, r0, #0xc00
	add r1, r4, #0x44
	add r3, r4, #0x38
	str r2, [sp, #0xc]
	bl StageTask__Draw3DEx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0216FDE4: .word 0x00001104
	arm_func_end RingTruck3D__Draw_216FD0C

	arm_func_start RingTruck3D__OnDefend_216FDE8
RingTruck3D__OnDefend_216FDE8: // 0x0216FDE8
	stmdb sp!, {r4, lr}
	ldr r4, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r4, #0
	ldmeqia sp!, {r4, pc}
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldrh r1, [r0]
	cmp r1, #1
	ldreqb r1, [r0, #0x5d1]
	cmpeq r1, #0
	ldmneia sp!, {r4, pc}
	mov r1, #1
	bl Player__GiveRings
	ldr r1, [r4, #0x354]
	mov r0, #0
	orr r1, r1, #1
	str r1, [r4, #0x354]
	str r0, [r4, #0x234]
	ldmia sp!, {r4, pc}
	arm_func_end RingTruck3D__OnDefend_216FDE8