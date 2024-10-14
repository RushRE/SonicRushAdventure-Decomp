	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailSeaMapView__Create
SailSeaMapView__Create: // 0x0218B41C
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r3, _0218B548 // =0x0213417C
	mov r5, #5
	str r5, [r3]
	ldr r2, _0218B54C // =0x02134180
	mov r4, #0
	ldr r1, _0218B550 // =VRAMSystem__GFXControl
	str r4, [r2]
	ldr r6, [r1, #4]
	mov r5, r0
	mov r0, #1
	ldrsh r4, [r6, #0x58]
	mov r1, r5
	mov r2, r0
	bl SeaMapManager__Create
	strh r4, [r6, #0x58]
	bl SeaMapManager__Func_2043D08
	mov r0, #0xff
	str r0, [sp]
	ldr r3, _0218B554 // =0x000007CC
	mov r2, #0
	stmib sp, {r2, r3}
	ldr r0, _0218B558 // =SailSeaMapView__Main
	ldr r1, _0218B55C // =SailSeaMapView__Destructor
	mov r3, r2
	bl TaskCreate_
	ldr r1, _0218B560 // =SeaMapView__sVars
	str r0, [r1]
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _0218B554 // =0x000007CC
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r2, r5
	mov r0, r4
	mov r1, #1
	mov r3, #0
	bl SeaMapView__InitView
	bl SeaMapManager__Func_20444E8
	bl SeaMapView__Func_203F8D4
	ldr r0, _0218B564 // =SailSeaMapView__State_218B940
	str r0, [r4, #0x7b8]
	bl SeaMapManager__GetStartNode
	mov r1, r0
	ldrh r0, [r1, #8]
	add r2, r4, #0x3c4
	add r3, r4, #0x3c8
	ldrh r1, [r1, #0xa]
	add r2, r2, #0x400
	add r3, r3, #0x400
	bl SeaMapManager__Func_2043B44
	ldr r1, _0218B568 // =SailSeaMapView__ButtonStates
	mov r0, r4
	bl SeaMapView__EnableMultipleButtons
	bl SeaMapEventManager__Create
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	ldr r1, [r4, #0x7c4]
	ldr r2, [r4, #0x7c8]
	mov r1, r1, lsl #4
	mov r2, r2, lsl #4
	mov r0, #9
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	bl SeaMapEventManager__CreateObject
	str r0, [r4, #0x7b4]
	ldr r0, [r4, #0x7c4]
	ldr r1, [r4, #0x7c8]
	bl SeaMapView__Func_203DCE0
	bl SeaMapUnknown204AB60__Func_204AB60
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0218B548: .word 0x0213417C
_0218B54C: .word 0x02134180
_0218B550: .word VRAMSystem__GFXControl
_0218B554: .word 0x000007CC
_0218B558: .word SailSeaMapView__Main
_0218B55C: .word SailSeaMapView__Destructor
_0218B560: .word SeaMapView__sVars
_0218B564: .word SailSeaMapView__State_218B940
_0218B568: .word SailSeaMapView__ButtonStates
	arm_func_end SailSeaMapView__Create

	arm_func_start SailSeaMapView__Func_218B56C
SailSeaMapView__Func_218B56C: // 0x0218B56C
	stmdb sp!, {r3, lr}
	ldr r0, _0218B588 // =SeaMapView__sVars
	ldr r0, [r0, #0]
	bl DestroyTask
	bl SeaMapEventManager__Destroy
	bl SeaMapManager__Destroy
	ldmia sp!, {r3, pc}
	.align 2, 0
_0218B588: .word SeaMapView__sVars
	arm_func_end SailSeaMapView__Func_218B56C

	arm_func_start SailSeaMapView__GetPosition
SailSeaMapView__GetPosition: // 0x0218B58C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl SailSeaMapView__GetWork
	cmp r5, #0
	ldrne r1, [r0, #0x7c4]
	strne r1, [r5]
	cmp r4, #0
	ldrne r0, [r0, #0x7c8]
	strne r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSeaMapView__GetPosition

	arm_func_start SailSeaMapView__GetWork
SailSeaMapView__GetWork: // 0x0218B5B8
	ldr r0, _0218B5C8 // =SeaMapView__sVars
	ldr ip, _0218B5CC // =GetTaskWork_
	ldr r0, [r0, #0]
	bx ip
	.align 2, 0
_0218B5C8: .word SeaMapView__sVars
_0218B5CC: .word GetTaskWork_
	arm_func_end SailSeaMapView__GetWork

	arm_func_start SailSeaMapView__GetVoyageCompetionPercent
SailSeaMapView__GetVoyageCompetionPercent: // 0x0218B5D0
	stmdb sp!, {r3, lr}
	bl SailManager__GetWork
	ldr r0, [r0, #0x98]
	ldr r0, [r0, #0x54]
	ldmia sp!, {r3, pc}
	arm_func_end SailSeaMapView__GetVoyageCompetionPercent

	arm_func_start SailSeaMapView__GetNodesFromPercent
SailSeaMapView__GetNodesFromPercent: // 0x0218B5E4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r10, r0
	mov r9, r1
	mov r8, r2
	mov r7, r3
	mov r6, #0
	bl SeaMapManager__GetStartNode
	mov r4, r0
	bl SeaMapManager__GetNextNode
	movs r5, r0
	beq _0218B634
_0218B610:
	ldr r1, [r5, #0xc]
	cmp r10, r1
	ble _0218B634
	mov r0, r5
	mov r4, r5
	sub r10, r10, r1
	bl SeaMapManager__GetNextNode
	movs r5, r0
	bne _0218B610
_0218B634:
	cmp r5, #0
	bne _0218B664
	ldrh r1, [r4, #8]
	mov r0, r4
	mov r5, r4
	strh r1, [r9]
	ldrh r1, [r4, #0xa]
	strh r1, [r8]
	bl SeaMapManager__GetPrevNode
	mov r4, r0
	mov r6, #1
	b _0218B6D8
_0218B664:
	ldr r1, [r5, #0xc]
	mov r0, r10
	bl FX_Div
	ldrh r2, [r5, #8]
	mov r1, r0, lsl #0x10
	ldrh r0, [r4, #8]
	mov r2, r2, lsl #0xc
	mov r1, r1, asr #0x10
	sub r2, r2, r0, lsl #12
	smull r10, r3, r2, r1
	adds r10, r10, #0x800
	adc r2, r3, #0
	mov r3, r10, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r0, r3, r0, lsl #12
	mov r0, r0, asr #0xc
	strh r0, [r9]
	ldrh r2, [r5, #0xa]
	ldrh r0, [r4, #0xa]
	mov r2, r2, lsl #0xc
	sub r2, r2, r0, lsl #12
	smull r3, r1, r2, r1
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r0, r2, r0, lsl #12
	mov r0, r0, asr #0xc
	strh r0, [r8]
_0218B6D8:
	ldr r0, [sp, #0x20]
	str r4, [r7]
	str r5, [r0]
	cmp r6, #0
	movne r0, #4
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end SailSeaMapView__GetNodesFromPercent

	arm_func_start SailSeaMapView__Main
SailSeaMapView__Main: // 0x0218B6F4
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x7b8]
	blx r1
	mov r0, r4
	bl SailSeaMapView__Func_218B8E0
	mov r0, r4
	bl SailSeaMapView__HandleProgress
	mov r0, r4
	bl SailSeaMapView__Func_218B75C
	ldmia sp!, {r4, pc}
	arm_func_end SailSeaMapView__Main

	arm_func_start SailSeaMapView__Destructor
SailSeaMapView__Destructor: // 0x0218B724
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl SeaMapUnknown204AB60__Func_204ABB0
	mov r0, r4
	bl SeaMapView__ReleaseAssets
	ldr r1, _0218B754 // =0x0213417C
	mov r2, #0
	ldr r0, _0218B758 // =SeaMapView__sVars
	str r2, [r1]
	str r2, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0218B754: .word 0x0213417C
_0218B758: .word SeaMapView__sVars
	arm_func_end SailSeaMapView__Destructor

	arm_func_start SailSeaMapView__Func_218B75C
SailSeaMapView__Func_218B75C: // 0x0218B75C
	ldr ip, _0218B764 // =SeaMapView__Func_203F770
	bx ip
	.align 2, 0
_0218B764: .word SeaMapView__Func_203F770
	arm_func_end SailSeaMapView__Func_218B75C

	arm_func_start SailSeaMapView__HandleProgress
SailSeaMapView__HandleProgress: // 0x0218B768
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r0, [r4, #0x7c0]
	cmp r0, #0
	ldrne r5, [r4, #0x7bc]
	bne _0218B78C
	bl SailSeaMapView__GetVoyageCompetionPercent
	mov r5, r0
_0218B78C:
	add ip, sp, #0xc
	add r1, sp, #8
	add r2, sp, #0xa
	add r3, sp, #0x10
	mov r0, r5
	str ip, [sp]
	bl SailSeaMapView__GetNodesFromPercent
	cmp r0, #0
	beq _0218B7C4
	cmp r0, #3
	beq _0218B7CC
	cmp r0, #4
	beq _0218B7E8
	b _0218B804
_0218B7C4:
	str r5, [r4, #0x7bc]
	b _0218B804
_0218B7CC:
	mov r1, #0
	mov r3, #1
	mov r2, r1
	mov r0, #3
	str r3, [r4, #0x7c0]
	bl SeaMapUnknown204A9E4__RunCallbacks
	b _0218B804
_0218B7E8:
	mov r1, #0
	mov r2, r1
	str r5, [r4, #0x7bc]
	mov r3, #1
	mov r0, #4
	str r3, [r4, #0x7c0]
	bl SeaMapUnknown204A9E4__RunCallbacks
_0218B804:
	ldrh r0, [sp, #8]
	add r2, r4, #0x3c4
	add r3, r4, #0x3c8
	ldrh r1, [sp, #0xa]
	add r2, r2, #0x400
	add r3, r3, #0x400
	bl SeaMapManager__Func_2043B44
	ldrh r0, [sp, #8]
	ldrh r1, [sp, #0xa]
	add r2, sp, #4
	add r3, sp, #6
	bl SeaMapManager__Func_2043B0C
	mov r2, #3
	ldrh r0, [sp, #4]
	ldrh r1, [sp, #6]
	mov r3, r2
	bl SeaMapManager__Func_20442C8
	mov r0, #1
	bl SeaMapManager__EnableDrawFlags
	ldr r1, [r4, #0x7c4]
	ldr r0, [r4, #0x7b4]
	mov r1, r1, asr #0xc
	strh r1, [r0, #0xc]
	ldr r1, [r4, #0x7c8]
	ldr r0, [r4, #0x7b4]
	mov r1, r1, asr #0xc
	strh r1, [r0, #0xe]
	ldr r0, [sp, #0x10]
	ldr r1, [sp, #0xc]
	bl SailSeaMapView__GetNodeAngle
	cmp r0, #0x4000
	blo _0218B8A0
	cmp r0, #0xc000
	bhs _0218B8A0
	ldr r0, [r4, #0x7b4]
	mov r1, #1
	bl SeaMapEventManager__Func_2047064
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
_0218B8A0:
	ldr r0, [r4, #0x7b4]
	mov r1, #0
	bl SeaMapEventManager__Func_2047064
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	arm_func_end SailSeaMapView__HandleProgress

	arm_func_start SailSeaMapView__GetNodeAngle
SailSeaMapView__GetNodeAngle: // 0x0218B8B4
	stmdb sp!, {r3, lr}
	ldrh ip, [r1, #0xa]
	ldrh r2, [r1, #8]
	ldrh r1, [r0, #8]
	ldrh r3, [r0, #0xa]
	sub r1, r2, r1
	sub r0, ip, r3
	mov r0, r0, lsl #0xc
	mov r1, r1, lsl #0xc
	bl FX_Atan2Idx
	ldmia sp!, {r3, pc}
	arm_func_end SailSeaMapView__GetNodeAngle

	arm_func_start SailSeaMapView__Func_218B8E0
SailSeaMapView__Func_218B8E0: // 0x0218B8E0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4, #0x7c4]
	ldr r1, [r4, #0x7c8]
	add r2, sp, #0
	add r3, sp, #2
	bl SeaMapManager__Func_2043A04
	ldrsh r0, [sp]
	cmp r0, #0x40
	blt _0218B92C
	cmp r0, #0xc0
	bgt _0218B92C
	ldrsh r0, [sp, #2]
	cmp r0, #0x30
	blt _0218B92C
	cmp r0, #0x90
	addle sp, sp, #4
	ldmleia sp!, {r3, r4, pc}
_0218B92C:
	ldr r0, [r4, #0x7c4]
	ldr r1, [r4, #0x7c8]
	bl SeaMapView__Func_203DCE0
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end SailSeaMapView__Func_218B8E0

	arm_func_start SailSeaMapView__State_218B940
SailSeaMapView__State_218B940: // 0x0218B940
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapView__FadeToBlack
	cmp r0, #0
	ldrne r0, _0218B95C // =SailSeaMapView__State_218B960
	strne r0, [r4, #0x7b8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0218B95C: .word SailSeaMapView__State_218B960
	arm_func_end SailSeaMapView__State_218B940

	arm_func_start SailSeaMapView__State_218B960
SailSeaMapView__State_218B960: // 0x0218B960
	stmdb sp!, {r4, lr}
	ldr r1, _0218B984 // =SailSeaMapView__ButtonStates
	mov r4, r0
	bl SeaMapView__EnableMultipleButtons
	ldr r1, _0218B988 // =SailSeaMapView__State_218B98C
	mov r0, r4
	str r1, [r4, #0x7b8]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_0218B984: .word SailSeaMapView__ButtonStates
_0218B988: .word SailSeaMapView__State_218B98C
	arm_func_end SailSeaMapView__State_218B960

	arm_func_start SailSeaMapView__State_218B98C
SailSeaMapView__State_218B98C: // 0x0218B98C
	bx lr
	arm_func_end SailSeaMapView__State_218B98C

	.rodata

SailSeaMapView__ButtonStates: // 0x0218C91C
	.word 0, 0, 0, 0, 0, 0, 0, 0

