	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start Task__OVL06Unknown2179284__Create
Task__OVL06Unknown2179284__Create: // 0x02179284
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	bl SailManager__GetWork
	mov r2, #0x1000
	mov r5, r0
	mov r1, #0
	str r2, [sp]
	mov r3, #1
	str r3, [sp, #4]
	mov r4, #0x10
	ldr r0, _0217932C // =Task__OVL06Unknown2179284__Main
	mov r2, r1
	mov r3, #3
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	add r0, r4, #8
	bl CheckTaskPaused
	mov r1, #1
	cmp r0, #0
	ldrneh r0, [r4, #4]
	mov r2, r1
	mov r3, r1
	orrne r0, r0, #1
	strneh r0, [r4, #4]
	mov r0, #2
	bl DrawReqTask__Create
	ldrh r0, [r4, #4]
	orr r0, r0, #2
	strh r0, [r4, #4]
	ldr r0, [r5, #0x24]
	orr r0, r0, #0x10000000
	str r0, [r5, #0x24]
	bl SailPauseMessage__Create
	str r0, [r4, #0xc]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0217932C: .word Task__OVL06Unknown2179284__Main
	arm_func_end Task__OVL06Unknown2179284__Create

	arm_func_start Task__OVL06Unknown2179330__Create
Task__OVL06Unknown2179330__Create: // 0x02179330
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	bl SailManager__GetWork
	mov r2, #0x1000
	mov r5, r0
	mov r1, #0
	str r2, [sp]
	mov r3, #1
	str r3, [sp, #4]
	mov r4, #0x10
	ldr r0, _021793E8 // =Task__OVL06Unknown2179330__Main
	mov r2, r1
	mov r3, #3
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	add r0, r4, #8
	bl CheckTaskPaused
	mov r1, #1
	cmp r0, #0
	ldrneh r0, [r4, #4]
	mov r2, r1
	mov r3, r1
	orrne r0, r0, #1
	strneh r0, [r4, #4]
	mov r0, #2
	bl DrawReqTask__Create
	ldrh r1, [r4, #4]
	mov r0, #1
	orr r1, r1, #2
	strh r1, [r4, #4]
	bl SetPadReplayState
	mov r0, #1
	bl SetTouchReplayState
	ldr r0, [r5, #0x24]
	orr r0, r0, #0x10000000
	str r0, [r5, #0x24]
	bl SailArriveMessageOptionFail__Create
	str r0, [r4, #0xc]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_021793E8: .word Task__OVL06Unknown2179330__Main
	arm_func_end Task__OVL06Unknown2179330__Create

	arm_func_start Task__OVL06Unknown2179330__Main
Task__OVL06Unknown2179330__Main: // 0x021793EC
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SailManager__GetWork
	mov r5, r0
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _02179428
	ldr r1, [r0, #0x18]
	tst r1, #4
	beq _02179428
	bl SailMessageCommon__Func_21729F4
	strh r0, [r4, #6]
	mov r0, #0
	str r0, [r4, #0xc]
_02179428:
	ldrh r0, [r4, #4]
	tst r0, #2
	beq _0217945C
	mov r0, #1
	bl NNS_SndPlayerPauseAll
	mov r0, #0
	mov r2, r0
	mov r1, #0x62
	bl SailAudio__PlaySpatialSequence
	ldrh r0, [r4, #4]
	bic r0, r0, #2
	strh r0, [r4, #4]
	ldmia sp!, {r3, r4, r5, pc}
_0217945C:
	ldr r0, [r5, #0x24]
	tst r0, #0x10
	ldmneia sp!, {r3, r4, r5, pc}
	bl DrawReqTask__Enable
	ldrh r0, [r4, #4]
	tst r0, #1
	beq _0217948C
	ldrb r0, [r4, #8]
	mov r1, #1
	mov r2, r1
	mov r3, r1
	bl DrawReqTask__Create
_0217948C:
	ldr r0, _021794B8 // =defaultTrackPlayer
	mov r1, #0
	mov r2, #0x1e
	bl NNS_SndPlayerMoveVolume
	bl SailRetireEvent__CreateFadeOut
	mov r0, #2
	bl SetPadReplayState
	mov r0, #2
	bl SetTouchReplayState
	bl DestroyCurrentTask
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021794B8: .word defaultTrackPlayer
	arm_func_end Task__OVL06Unknown2179330__Main

	arm_func_start Task__OVL06Unknown2179284__Main
Task__OVL06Unknown2179284__Main: // 0x021794BC
	stmdb sp!, {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r6, _0217966C // =gameState
	bl SailManager__GetWork
	mov r5, r0
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _021794FC
	ldr r1, [r0, #0x18]
	tst r1, #4
	beq _021794FC
	bl SailMessageCommon__Func_21729F4
	strh r0, [r4, #6]
	mov r0, #0
	str r0, [r4, #0xc]
_021794FC:
	ldrh r0, [r4, #4]
	tst r0, #2
	beq _02179530
	mov r0, #1
	bl NNS_SndPlayerPauseAll
	mov r0, #0
	mov r2, r0
	mov r1, #0x62
	bl SailAudio__PlaySpatialSequence
	ldrh r0, [r4, #4]
	bic r0, r0, #2
	strh r0, [r4, #4]
	ldmia sp!, {r4, r5, r6, pc}
_02179530:
	ldr r0, [r5, #0x24]
	tst r0, #0x10
	ldmneia sp!, {r4, r5, r6, pc}
	bl DrawReqTask__Enable
	mov r0, #0
	bl NNS_SndPlayerPauseAll
	ldrh r0, [r4, #4]
	tst r0, #1
	beq _02179568
	ldrb r0, [r4, #8]
	mov r1, #1
	mov r2, r1
	mov r3, r1
	bl DrawReqTask__Create
_02179568:
	ldr r0, [r5, #0x24]
	orr r0, r0, #0x4000000
	str r0, [r5, #0x24]
	tst r0, #0x1000
	beq _0217958C
	ldrh r0, [r4, #4]
	tst r0, #0x2000
	orreq r0, r0, #0x10
	streqh r0, [r4, #4]
_0217958C:
	ldr r1, [r5, #0x24]
	ldr r0, _02179670 // =0x02004068
	tst r1, r0
	movne r0, #0
	strneh r0, [r4, #6]
	ldrsh r0, [r4, #6]
	cmp r0, #1
	beq _021795B8
	cmp r0, #2
	beq _02179638
	b _02179664
_021795B8:
	ldrh r0, [r5, #0x12]
	str r0, [r6, #0x70]
	ldrh r0, [r5, #0x14]
	str r0, [r6, #0x74]
	ldr r0, [r5, #0x18]
	str r0, [r6, #0x78]
	ldr r0, [r5, #0xc]
	str r0, [r6, #0xa4]
	ldrh r0, [r5, #0x10]
	strh r0, [r6, #0xb4]
	ldr r0, [r5, #0x24]
	tst r0, #0x100000
	ldrneh r0, [r6, #0xb4]
	addne r0, r0, #0xa
	strneh r0, [r6, #0xb4]
	ldr r0, [r5, #0xc]
	cmp r0, #0
	bne _02179604
	bl SailManager__GetWork
_02179604:
	add r0, r5, #0x500
	mov r1, #4
	strh r1, [r0, #0xd0]
	ldr r1, [r5, #0x24]
	ldr r0, _02179674 // =defaultTrackPlayer
	orr r1, r1, #8
	orr r3, r1, #0x8000
	mov r1, #0
	mov r2, #0x1e
	str r3, [r5, #0x24]
	bl NNS_SndPlayerMoveVolume
	bl SailRetireEvent__CreateFadeOut
	b _02179664
_02179638:
	bl MultibootManager__Func_2063C40
	add r0, r5, #0x500
	mov r1, #0
	strh r1, [r0, #0xd0]
	ldr r2, [r5, #0x24]
	ldr r0, _02179674 // =defaultTrackPlayer
	orr r3, r2, #8
	mov r2, #0x1e
	str r3, [r5, #0x24]
	bl NNS_SndPlayerMoveVolume
	bl SailRetireEvent__CreateFadeOut
_02179664:
	bl DestroyCurrentTask
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0217966C: .word gameState
_02179670: .word 0x02004068
_02179674: .word defaultTrackPlayer
	arm_func_end Task__OVL06Unknown2179284__Main
