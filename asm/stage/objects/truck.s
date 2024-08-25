	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Truck__Create
Truck__Create: // 0x0216F3C4
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
	ldr r0, _0216F560 // =StageTask_Main
	ldr r1, _0216F564 // =GameObject__Destructor
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
	ldr r1, [r4, #0x1c]
	mov r0, #0xb4
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0216F568 // =gameArchiveStage
	mov r1, #0x1a
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _0216F56C // =aActAcGmkTruckB_0
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x39
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #4
	bl StageTask__SetAnimation
	str r4, [r4, #0x234]
	ldr r1, _0216F570 // =0x00000201
	add r0, r4, #0x200
	strh r1, [r0, #0x4c]
	mov r2, #0
	str r2, [sp]
	add r0, r4, #0x218
	sub r1, r2, #0x20
	sub r2, r2, #0x40
	mov r3, #8
	bl ObjRect__SetBox2D
	add r0, r4, #0x218
	mov r1, #0x10
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, _0216F574 // =0x0000FFFF
	mov r2, #0xff
	bl ObjRect__SetDefenceStat
	mov r2, #0
	str r2, [r4, #0x23c]
	ldr r1, [r4, #0x230]
	ldr r0, _0216F578 // =StageTask__DefaultDiffData
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	str r2, [r4, #0x13c]
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	mov r1, #0x10
	add r0, r4, #0x300
	strh r1, [r0, #8]
	mov r2, #0x20
	strh r2, [r0, #0xa]
	sub r0, r2, #0x28
	add r1, r4, #0x200
	strh r0, [r1, #0xf0]
	sub r2, r2, #0x40
	mov r0, r4
	strh r2, [r1, #0xf2]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216F560: .word StageTask_Main
_0216F564: .word GameObject__Destructor
_0216F568: .word gameArchiveStage
_0216F56C: .word aActAcGmkTruckB_0
_0216F570: .word 0x00000201
_0216F574: .word 0x0000FFFF
_0216F578: .word StageTask__DefaultDiffData
	arm_func_end Truck__Create

	arm_func_start Truck3D__Func_216F57C
Truck3D__Func_216F57C: // 0x0216F57C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0xad
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0xf4]
	ldr r0, _0216F610 // =Truck3D__State_2171064
	cmp r1, r0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x354]
	tst r0, #2
	ldmneia sp!, {r4, pc}
	orr r0, r0, #2
	bic r0, r0, #8
	str r0, [r4, #0x354]
	ldr r1, [r4, #0x18]
	ldr r0, _0216F614 // =Truck3D__State_2171368
	bic r2, r1, #1
	str r2, [r4, #0x18]
	mov r1, #0
	str r0, [r4, #0xf4]
	add r0, r4, #0x284
	str r1, [r4, #0x28]
	sub r3, r1, #0x80000001
	str r3, [r4, #0xe80]
	ldr r2, _0216F618 // =0x00002EA4
	sub ip, r1, #1
	add r3, r4, #0x3d00
	add r0, r0, #0xc00
	strh ip, [r3, #0x36]
	bl MI_CpuFill8
	add r0, r4, #0x3d00
	mov r1, #0x8000
	strh r1, [r0, #0x32]
	strh r1, [r0, #0x1e]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216F610: .word Truck3D__State_2171064
_0216F614: .word Truck3D__State_2171368
_0216F618: .word 0x00002EA4
	arm_func_end Truck3D__Func_216F57C