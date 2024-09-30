	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start SpringRopeBase__Create
SpringRopeBase__Create: // 0x0218620C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _02186318 // =StageTask_Main
	ldr r1, _0218631C // =GameObject__Destructor
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
	mov r4, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	mov r0, #0xa2
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02186320 // =gameArchiveStage
	mov r1, #0x10
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _02186324 // =aActAcGmkRopeCL
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x6a
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	ldr r0, [r4, #0x18]
	ldr r1, _02186328 // =SpringRopeBase__State_218632C
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r2, [r4, #0x1c]
	mov r0, r4
	orr r2, r2, #0x2100
	str r2, [r4, #0x1c]
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02186318: .word StageTask_Main
_0218631C: .word GameObject__Destructor
_02186320: .word gameArchiveStage
_02186324: .word aActAcGmkRopeCL
_02186328: .word SpringRopeBase__State_218632C
	arm_func_end SpringRopeBase__Create

	arm_func_start SpringRopeBase__State_218632C
SpringRopeBase__State_218632C: // 0x0218632C
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x11c]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldr r1, [r1, #0x354]
	tst r1, #1
	beq _02186354
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	ldmia sp!, {r3, pc}
_02186354:
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	ldmia sp!, {r3, pc}
	arm_func_end SpringRopeBase__State_218632C

	.data
	
aActAcGmkRopeCL: // 0x02189E24
	.asciz "/act/ac_gmk_rope_c_land.bac"
	.align 4