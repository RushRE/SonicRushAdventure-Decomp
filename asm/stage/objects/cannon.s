	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
	.public CannonPath__dword_218A394
CannonPath__dword_218A394: // 0x0218A394
	.space 0x04 * 3
	
	.text

	arm_func_start CannonField__Create
CannonField__Create: // 0x0217AA10
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r6, r0
	mov r5, r1
	mov r4, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r7, _0217ABD4 // =0x000005EC
	ldr r0, _0217ABD8 // =StageTask_Main
	ldr r1, _0217ABDC // =CannonField__Destructor
	mov r3, r2
	str r7, [sp, #8]
	bl TaskCreate_
	mov r7, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r7, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, r7
	bl GetTaskWork_
	ldr r2, _0217ABD4 // =0x000005EC
	mov r7, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	ldr r1, [r7, #0x1c]
	mov r0, #0xa5
	orr r1, r1, #0x2100
	str r1, [r7, #0x1c]
	bl GetObjectFileWork
	ldr r2, _0217ABE0 // =gameArchiveStage
	ldr r1, _0217ABE4 // =aModGmkCannonNs
	ldr r2, [r2, #0]
	bl ObjDataLoad
	mov r8, #0
	mov r10, r0
	add r9, r7, #0x364
	mov r6, r8
	mov r5, r8
	ldr r4, _0217ABE8 // =0x000034CC
	b _0217AB14
_0217AAD8:
	mov r0, r9
	mov r1, r6
	bl AnimatorMDL__Init
	mov r2, r8, lsl #0x10
	mov r0, r9
	mov r1, r10
	mov r2, r2, lsr #0x10
	str r5, [sp]
	mov r3, r5
	bl AnimatorMDL__SetResource
	str r4, [r9, #0x18]
	str r4, [r9, #0x1c]
	str r4, [r9, #0x20]
	add r8, r8, #1
	add r9, r9, #0x144
_0217AB14:
	cmp r8, #2
	blt _0217AAD8
	ldr r0, [r7, #0x20]
	mvn r4, #0x37
	orr r0, r0, #0x300
	str r0, [r7, #0x20]
	mov r0, #0x2000
	strh r0, [r7, #0x32]
	str r7, [r7, #0x234]
	add r0, r7, #0x218
	add r1, r4, #0x18
	sub r2, r4, #0x28
	mov r3, #0x20
	str r4, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r7, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _0217ABEC // =0x0000FFFE
	add r0, r7, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	mov r2, #0x50
	ldr r0, _0217ABF0 // =CannonField__OnDefend
	mov r1, #0
	str r0, [r7, #0x23c]
	ldr r3, [r7, #0x230]
	ldr r0, _0217ABF4 // =StageTask__DefaultDiffData
	orr r3, r3, #0x400
	str r3, [r7, #0x230]
	str r1, [r7, #0x13c]
	str r7, [r7, #0x2d8]
	str r0, [r7, #0x2fc]
	add r0, r7, #0x300
	mov r1, #0x28
	strh r1, [r0, #8]
	strh r2, [r0, #0xa]
	sub r1, r2, #0x60
	add r0, r7, #0x200
	strh r1, [r0, #0xf0]
	sub r2, r2, #0x9a
	ldr r1, _0217ABF8 // =CannonField__Draw
	strh r2, [r0, #0xf2]
	mov r0, r7
	str r1, [r7, #0xfc]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0217ABD4: .word 0x000005EC
_0217ABD8: .word StageTask_Main
_0217ABDC: .word CannonField__Destructor
_0217ABE0: .word gameArchiveStage
_0217ABE4: .word aModGmkCannonNs
_0217ABE8: .word 0x000034CC
_0217ABEC: .word 0x0000FFFE
_0217ABF0: .word CannonField__OnDefend
_0217ABF4: .word StageTask__DefaultDiffData
_0217ABF8: .word CannonField__Draw
	arm_func_end CannonField__Create

	arm_func_start Cannon__Create
Cannon__Create: // 0x0217ABFC
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
	mov r4, #0x590
	ldr r0, _0217AD6C // =StageTask_Main
	ldr r1, _0217AD70 // =GameObject__Destructor
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
	mov r2, #0x590
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xa5
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	str r0, [sp]
	ldr r1, _0217AD74 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	add r1, r4, #0x364
	str r2, [sp, #4]
	ldr r2, _0217AD78 // =aModGmkCannonNs
	mov r3, #2
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x20]
	ldr r0, _0217AD7C // =0x000025A3
	orr r1, r1, #0x200
	str r1, [r4, #0x20]
	str r0, [r4, #0x37c]
	str r0, [r4, #0x380]
	str r0, [r4, #0x384]
	mov r0, #0
	str r0, [r4, #0x13c]
	str r4, [r4, #0x2d8]
	add r3, r4, #0x2d8
	ldr r7, _0217AD80 // =StageTask__DefaultDiffData
	mov r1, #0x180
	str r7, [r3, #0x24]
	strh r1, [r3, #0x30]
	mov r6, #8
	strh r6, [r3, #0x32]
	sub r2, r6, #0xc8
	strh r2, [r3, #0x18]
	strh r0, [r3, #0x1a]
	str r4, [r4, #0x4e0]
	add r1, r4, #0x4e0
	str r7, [r1, #0x24]
	mov r5, #0x10
	strh r5, [r1, #0x30]
	mov r3, #0x78
	strh r3, [r1, #0x32]
	strh r2, [r1, #0x18]
	strh r6, [r1, #0x1a]
	str r4, [r4, #0x538]
	add r1, r4, #0x138
	add r2, r1, #0x400
	str r7, [r2, #0x24]
	strh r5, [r2, #0x30]
	strh r3, [r2, #0x32]
	mov r1, #0xb0
	strh r1, [r2, #0x18]
	strh r6, [r2, #0x1a]
	ldr r2, _0217AD84 // =Cannon__State_217B7A8
	ldr r1, _0217AD88 // =Cannon__Collide
	str r2, [r4, #0xf4]
	str r1, [r4, #0x108]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0217AD6C: .word StageTask_Main
_0217AD70: .word GameObject__Destructor
_0217AD74: .word gameArchiveStage
_0217AD78: .word aModGmkCannonNs
_0217AD7C: .word 0x000025A3
_0217AD80: .word StageTask__DefaultDiffData
_0217AD84: .word Cannon__State_217B7A8
_0217AD88: .word Cannon__Collide
	arm_func_end Cannon__Create

	arm_func_start CannonPath__Create
CannonPath__Create: // 0x0217AD8C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, _0217AEA4 // =0x000010F6
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x3a8
	ldr r0, _0217AEA8 // =StageTask_Main
	ldr r1, _0217AEAC // =CannonPath__Destructor
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
	mov r2, #0x3a8
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r0, [r4, #0x1c]
	ldr r1, _0217AEB0 // =CannonPath__State_217B868
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	ldr r2, [r4, #0x20]
	ldr r0, _0217AEB4 // =CannonPath__dword_218A394
	orr r2, r2, #0x20
	str r2, [r4, #0x20]
	str r1, [r4, #0xf4]
	mov r1, #0
	str r1, [r0, #4]
	str r1, [r0]
	str r1, [r0, #8]
	ldrsb r0, [r7, #7]
	ldr r1, _0217AEB8 // =0x000016C1
	mov r0, r0, lsl #0x12
	sub r0, r0, #0x80000
	str r0, [r4, #0x378]
	cmp r0, #0x40000
	movlt r0, #0x40000
	strlt r0, [r4, #0x378]
	ldr r0, [r4, #0x378]
	str r0, [r4, #0x37c]
	ldr r0, [r4, #0x378]
	add r0, r0, #0x80000
	str r0, [r4, #0x378]
	ldr r0, [r4, #0x37c]
	bl FX_Div
	ldrsb r2, [r7, #6]
	mov r1, r0
	mov r0, r2, lsl #0x12
	bl FX_Div
	str r0, [r4, #0x38c]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0217AEA4: .word 0x000010F6
_0217AEA8: .word StageTask_Main
_0217AEAC: .word CannonPath__Destructor
_0217AEB0: .word CannonPath__State_217B868
_0217AEB4: .word CannonPath__dword_218A394
_0217AEB8: .word 0x000016C1
	arm_func_end CannonPath__Create

	arm_func_start CannonPath__GetOffsetZ
CannonPath__GetOffsetZ: // 0x0217AEBC
	ldr r0, _0217AEC8 // =CannonPath__dword_218A394
	ldr r0, [r0, #4]
	bx lr
	.align 2, 0
_0217AEC8: .word CannonPath__dword_218A394
	arm_func_end CannonPath__GetOffsetZ

	.data
	
aModGmkCannonNs: // 0x02189980
	.asciz "/mod/gmk_cannon.nsbmd"
	.align 4