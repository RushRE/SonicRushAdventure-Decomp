	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailJetBird__Func_21834D8
SailJetBird__Func_21834D8: // 0x021834D8
	ldr r1, _021834E4 // =_0218C8C8
	ldrb r0, [r1, r0]
	bx lr
	.align 2, 0
_021834E4: .word _0218C8C8
	arm_func_end SailJetBird__Func_21834D8

	arm_func_start SailHoverEnemyHover1__Create
SailHoverEnemyHover1__Create: // 0x021834E8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x68
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _02183624 // =aSbSHover1Nsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #0x20000000
	str r1, [r4, #0x24]
	bl SailObject__Func_21646DC
	mov r0, r4
	mov r1, r6
	bl SailObject__InitFromMapObject
	ldr r1, _02183628 // =0x000005DC
	mov r0, #0xc000
	str r1, [r5, #0x118]
	str r0, [r5, #0x120]
	str r0, [r5, #0x11c]
	ldr r1, [r4, #0x24]
	mov r0, #5
	orr r1, r1, #2
	str r1, [r4, #0x24]
	str r0, [r5, #0x13c]
	ldr r0, [r6, #0x28]
	add r1, sp, #8
	cmp r0, #0
	strne r0, [r5, #0x13c]
	mov r3, #0
	mov r2, #0xc00
	mov r0, r4
	str r3, [sp, #8]
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	bl SailObject__Func_2165AF4
	mov r0, r4
	add r1, r5, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r4
	mov r3, r1
	mov r2, #0xe00
	bl SailObject__Func_21658D0
	mov r1, #0x800
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	ldr r0, [r6, #0x10]
	cmp r0, #0
	movlt r0, #0x5800
	subge r0, r1, #0x6000
	mov r1, #0x1000
	str r0, [r5, #0x170]
	rsb r1, r1, #0
	mov r0, r4
	str r1, [r5, #0x174]
	bl StageTask__InitSeqPlayer
	mov r0, r4
	bl SailHoverEnemyHover__SetupObject
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02183624: .word aSbSHover1Nsbmd_0
_02183628: .word 0x000005DC
	arm_func_end SailHoverEnemyHover1__Create

	arm_func_start SailHoverEnemyHover2__Create
SailHoverEnemyHover2__Create: // 0x0218362C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x69
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _02183768 // =aSbSHover2Nsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #0x20000000
	str r1, [r4, #0x24]
	bl SailObject__Func_21646DC
	mov r0, r4
	mov r1, r6
	bl SailObject__InitFromMapObject
	ldr r1, _0218376C // =0x00000708
	mov r0, #0x10000
	str r1, [r5, #0x118]
	str r0, [r5, #0x120]
	str r0, [r5, #0x11c]
	ldr r1, [r4, #0x24]
	mov r0, #3
	orr r1, r1, #2
	str r1, [r4, #0x24]
	str r0, [r5, #0x13c]
	ldr r0, [r6, #0x28]
	add r1, sp, #8
	cmp r0, #0
	strne r0, [r5, #0x13c]
	mov r3, #0
	mov r2, #0xc00
	mov r0, r4
	str r3, [sp, #8]
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	bl SailObject__Func_2165AF4
	mov r0, r4
	add r1, r5, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r4
	mov r3, r1
	mov r2, #0xe00
	bl SailObject__Func_21658D0
	mov r1, #0x800
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	ldr r0, [r6, #0x10]
	cmp r0, #0
	movlt r0, #0x5800
	subge r0, r1, #0x6000
	mov r1, #0x1000
	str r0, [r5, #0x170]
	rsb r1, r1, #0
	mov r0, r4
	str r1, [r5, #0x174]
	bl StageTask__InitSeqPlayer
	mov r0, r4
	bl SailHoverEnemyHover__SetupObject
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02183768: .word aSbSHover2Nsbmd_0
_0218376C: .word 0x00000708
	arm_func_end SailHoverEnemyHover2__Create

	arm_func_start SailHoverShell2__Create
SailHoverShell2__Create: // 0x02183770
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x90
	mov r9, r1
	mov r8, r2
	mov r7, r3
	ldr r6, [sp, #0xb4]
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x32
	bl GetObjectFileWork
	mov r10, r0
	bl SailManager__GetArchive
	mov r1, #0
	stmia sp, {r1, r10}
	str r0, [sp, #8]
	ldr r2, _02183A1C // =aSbShellBac_1
	mov r0, r4
	mov r3, r1
	bl ObjObjectAction3dBACLoad
	mov r0, #0x40
	bl GetObjectFileWork
	mov r1, #0
	mov r3, r0
	mov r0, r4
	mov r2, r1
	bl ObjObjectActionAllocTexture
	ldr r1, [r4, #0x134]
	mov r2, #0x1c
	ldr r0, [r1, #0xcc]
	mov r3, #7
	orr r0, r0, #0x18
	str r0, [r1, #0xcc]
	ldr r1, [r4, #0x134]
	mov r0, r4
	strb r2, [r1, #0xa]
	ldr r2, [r4, #0x134]
	mov r1, #1
	strb r3, [r2, #0xb]
	bl StageTask__SetAnimation
	mov r0, r4
	bl SailObject__Func_21646DC
	add ip, r4, #0x44
	ldmia r9, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	mov r3, #0x32
	str r3, [r5, #0x118]
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #1
	orr r1, r1, #0x800000
	str r1, [r4, #0x24]
	add r1, r5, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r4
	mov r2, #0x2c0
	mov r3, r1
	bl SailObject__Func_21658D0
	ldr r0, [r4, #0x144]
	mov r1, #0xb
	strh r1, [r0, #0x2e]
	mov r0, #0x24000
	str r0, [r5, #0x98]
	cmp r6, #0
	movne r0, #0x140
	strne r0, [r5, #0x50]
	mov r2, #0
	ldrh r0, [sp, #0xb0]
	sub r1, r7, #0x400
	str r2, [sp, #0x60]
	str r2, [sp, #0x64]
	str r1, [sp, #0x68]
	cmp r0, #0
	beq _021838F4
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _02183A20 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0x6c
	bl MTX_RotY33_
	add r0, sp, #0x60
	add r1, sp, #0x6c
	mov r2, r0
	bl MTX_MultVec33
_021838F4:
	ldr r0, _02183A24 // =_0218C8B0
	add r3, sp, #0x24
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldmia r9, {r0, r1, r2}
	add r7, sp, #0x18
	stmia r7, {r0, r1, r2}
	add r3, sp, #0xc
	ldmia r8, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	cmp r6, #1
	bne _0218393C
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x10]
	rsb r1, r1, #0
	rsb r0, r0, #0
	str r1, [sp, #0x1c]
	str r0, [sp, #0x10]
_0218393C:
	add r0, sp, #0x18
	add r1, sp, #0xc
	add r2, sp, #0x24
	add r3, sp, #0x30
	bl sub_2066A4C
	add r0, sp, #0x30
	add r1, sp, #0x6c
	bl MI_Copy36B
	add r0, sp, #0x60
	add r1, sp, #0x6c
	mov r2, r0
	bl MTX_MultVec33
	add r0, sp, #0x60
	add r3, r4, #0x98
	ldmia r0, {r0, r1, r2}
	cmp r6, #3
	stmia r3, {r0, r1, r2}
	bne _021839B0
	mov r0, #1
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x98]
	ldr r2, [r4, #0xa0]
	ldr r1, [r4, #0x9c]
	mov r0, r0, asr #4
	str r0, [r5, #0x10]
	mov r0, r1, asr #4
	str r0, [r5, #0x14]
	mov r0, r2, asr #4
	str r0, [r5, #0x18]
_021839B0:
	add r0, r6, #0xff
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	movls r0, #0x700
	ldr r5, [r4, #0x38]
	movhi r0, #0xa00
	umull r3, r2, r5, r0
	mov r1, #0
	mla r2, r5, r1, r2
	mov r1, r5, asr #0x1f
	mla r2, r1, r0, r2
	adds r3, r3, #0x800
	adc r0, r2, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	mov r0, r4
	str r1, [r4, #0x40]
	bl StageTask__InitSeqPlayer
	ldr r1, _02183A28 // =SailHoverShell2__State_2186B98
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0x90
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02183A1C: .word aSbShellBac_1
_02183A20: .word FX_SinCosTable_
_02183A24: .word _0218C8B0
_02183A28: .word SailHoverShell2__State_2186B98
	arm_func_end SailHoverShell2__Create

	arm_func_start SailHoverShell1__Create
SailHoverShell1__Create: // 0x02183A2C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r8, r1
	mov r7, r2
	mov r6, r3
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #0x32
	bl GetObjectFileWork
	mov r9, r0
	bl SailManager__GetArchive
	mov r1, #0
	stmia sp, {r1, r9}
	str r0, [sp, #8]
	ldr r2, _02183CBC // =aSbShellBac_1
	mov r0, r5
	mov r3, r1
	bl ObjObjectAction3dBACLoad
	mov r0, #0x3e
	bl GetObjectFileWork
	mov r1, #0
	mov r3, r0
	mov r0, r5
	mov r2, r1
	bl ObjObjectActionAllocTexture
	ldr r1, [r5, #0x134]
	mov r2, #0x1c
	ldr r0, [r1, #0xcc]
	mov r3, #7
	orr r0, r0, #0x18
	str r0, [r1, #0xcc]
	ldr r1, [r5, #0x134]
	mov r0, r5
	strb r2, [r1, #0xa]
	ldr r2, [r5, #0x134]
	mov r1, #1
	strb r3, [r2, #0xb]
	bl StageTask__SetAnimation
	mov r0, r5
	bl SailObject__Func_21646DC
	add ip, r5, #0x44
	ldmia r8, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	mov r3, #0xc8
	str r3, [r4, #0x118]
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #1
	orr r1, r1, #0x800000
	str r1, [r5, #0x24]
	add r1, r4, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r5
	mov r2, #0x600
	mov r3, r1
	bl SailObject__Func_21658D0
	ldr r0, [r5, #0x144]
	mov r1, #0xb
	strh r1, [r0, #0x2e]
	mov r0, #0x44000
	str r0, [r4, #0x98]
	ldr r0, [r5, #0x1c]
	cmp r6, #0
	orr r0, r0, #0x80
	str r0, [r5, #0x1c]
	beq _02183B74
	mov r1, #0x60
	mov r0, #0x2000
	str r1, [r5, #0xd8]
	str r0, [r5, #0xdc]
	sub r0, r0, #0x2600
	str r0, [r5, #0x9c]
	mov r4, #0x22
	b _02183B90
_02183B74:
	mov r1, #0x30
	mov r0, #0x1200
	str r1, [r5, #0xd8]
	str r0, [r5, #0xdc]
	sub r0, r0, #0x1780
	str r0, [r5, #0x9c]
	mov r4, #0x3c
_02183B90:
	ldr r3, [r8, #8]
	ldr r2, [r7, #8]
	ldr r1, [r8]
	ldr r0, [r7]
	sub r6, r3, r2
	sub r1, r1, r0
	smull r0, r2, r1, r1
	adds r3, r0, #0x800
	smull r1, r0, r6, r6
	adc r2, r2, #0
	adds r1, r1, #0x800
	mov r3, r3, lsr #0xc
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r3, r3, r2, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r3, r1
	bl FX_Sqrt
	mov r1, r4, lsl #0xc
	bl FX_Div
	ldr r6, [r7]
	ldr r3, [r8]
	mov r4, r0
	ldr r2, [r7, #8]
	ldr r1, [r8, #8]
	sub r0, r6, r3
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r3, r1, lsl #1
	mov r0, r0, lsl #1
	ldr r1, _02183CC0 // =FX_SinCosTable_
	mov r2, #0
	ldrsh r3, [r1, r3]
	ldrsh r0, [r1, r0]
	mov r1, #0xe00
	smull r7, r6, r4, r3
	smull r3, r0, r4, r0
	adds r7, r7, #0x800
	adc r4, r6, #0
	mov r6, r7, lsr #0xc
	orr r6, r6, r4, lsl #20
	str r6, [r5, #0x98]
	adds r3, r3, #0x800
	adc r0, r0, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r0, lsl #20
	str r3, [r5, #0xa0]
	ldr r4, [r5, #0x38]
	mov r0, r5
	mov r3, r4, asr #0x1f
	umull r7, r6, r4, r1
	mla r6, r4, r2, r6
	mla r6, r3, r1, r6
	adds r2, r7, #0x800
	adc r1, r6, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r5, #0x38]
	str r2, [r5, #0x3c]
	str r2, [r5, #0x40]
	bl StageTask__InitSeqPlayer
	ldr r0, [r5, #0x138]
	mov r1, #0x2a
	add r2, r5, #0x44
	bl SailAudio__PlaySpatialSequence
	ldr r1, _02183CC4 // =SailHoverShell1__State_2186C44
	mov r0, r5
	str r1, [r5, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02183CBC: .word aSbShellBac_1
_02183CC0: .word FX_SinCosTable_
_02183CC4: .word SailHoverShell1__State_2186C44
	arm_func_end SailHoverShell1__Create

	arm_func_start SailHoverBomber__Create
SailHoverBomber__Create: // 0x02183CC8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r6, r1
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #0x24
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	ldr r3, _02183E24 // =0x0000FFFF
	ldr r2, _02183E28 // =aSbBomberBac_0
	stmia sp, {r3, r7}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r5
	bl ObjObjectAction3dBACLoad
	ldr r0, [r5, #0x134]
	mov r1, #0x1c
	strb r1, [r0, #0xa]
	ldr r1, [r5, #0x134]
	mov r2, #7
	mov r0, r5
	strb r2, [r1, #0xb]
	bl SailObject__Func_21646DC
	add lr, r5, #0x44
	ldmia r6, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	mov ip, #0x10
	mov r3, #0xc8
	str ip, [r4, #0x13c]
	str r3, [r4, #0x118]
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #3
	orr r1, r1, #0x800000
	str r1, [r5, #0x24]
	add r1, r4, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r5
	mov r2, #0xa00
	mov r3, r1
	bl SailObject__Func_21658D0
	ldr r1, [r5, #0x144]
	mov r2, #0xb
	mov r0, #0x34000
	strh r2, [r1, #0x2e]
	str r0, [r4, #0x98]
	ldr r1, [r5, #0x1c]
	mov r0, #0x60
	orr r1, r1, #0x80
	str r1, [r5, #0x1c]
	str r0, [r5, #0xd8]
	mov r0, #0x2000
	str r0, [r5, #0xdc]
	mov r0, r5
	bl StageTask__InitSeqPlayer
	ldr r0, [r5, #0x138]
	mov r1, #0x2c
	add r2, r5, #0x44
	bl SailAudio__PlaySpatialSequence
	ldr r0, _02183E2C // =SailHoverShell1__State_2186C44
	mov r1, #0
	str r0, [r5, #0xf4]
	ldr r2, [r5, #0x38]
	mov r0, #0xf00
	umull r4, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	adds r2, r4, #0x800
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r5, #0x38]
	str r1, [r5, #0x3c]
	mov r0, r5
	str r1, [r5, #0x40]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02183E24: .word 0x0000FFFF
_02183E28: .word aSbBomberBac_0
_02183E2C: .word SailHoverShell1__State_2186C44
	arm_func_end SailHoverBomber__Create

	arm_func_start SailHoverBoat02__Create
SailHoverBoat02__Create: // 0x02183E30
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x6b
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _02183F54 // =aSbSBoat02Nsbmd_2
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #0x20000000
	str r1, [r4, #0x24]
	bl SailObject__Func_21646DC
	mov r0, r4
	mov r1, r6
	bl SailObject__InitFromMapObject
	mov r0, #0x7d0
	str r0, [r5, #0x118]
	mov r0, #0x14000
	str r0, [r5, #0x120]
	str r0, [r5, #0x11c]
	mov r0, #0
	str r0, [r5, #0x13c]
	ldr r0, [r6, #0x28]
	mov r2, #0x2000
	cmp r0, #0
	strne r0, [r5, #0x13c]
	ldr r0, [r4, #0x24]
	add r1, sp, #8
	orr r0, r0, #2
	str r0, [r4, #0x24]
	str r2, [r5, #0x124]
	mov r3, #0
	mov r2, #0x1000
	mov r0, r4
	str r3, [sp, #8]
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	bl SailObject__Func_2165AF4
	mov r0, r4
	add r1, r5, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r4
	mov r3, r1
	mov r2, #0x1100
	bl SailObject__Func_21658D0
	mov r1, #0x600
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	mov r0, r4
	str r1, [r4, #0x40]
	bl StageTask__InitSeqPlayer
	mov r0, r4
	bl SailHoverBoat02__SetupObject
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02183F54: .word aSbSBoat02Nsbmd_2
	arm_func_end SailHoverBoat02__Create

	arm_func_start SailHoverBoat01__Create
SailHoverBoat01__Create: // 0x02183F58
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r6, r0
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #0x6a
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _0218407C // =aSbSBoat01Nsbmd_1
	mov r0, r5
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #0x20000000
	str r1, [r5, #0x24]
	bl SailObject__Func_21646DC
	mov r0, r5
	mov r1, r6
	bl SailObject__InitFromMapObject
	ldr r1, _02184080 // =0x00001388
	mov r0, #0x48000
	str r1, [r4, #0x118]
	str r0, [r4, #0x120]
	str r0, [r4, #0x11c]
	ldr r1, [r5, #0x24]
	mov r0, #0x4000
	orr r1, r1, #2
	str r1, [r5, #0x24]
	str r0, [r4, #0x124]
	mov r0, #0
	str r0, [sp, #8]
	str r0, [sp, #0x10]
	mov r0, #0x1000
	str r0, [sp, #0xc]
	mov r0, r5
	add r1, sp, #8
	bl SailObject__Func_2165AF4
	mov r0, r5
	add r1, r4, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r5
	mov r2, #0x1300
	mov r3, r1
	bl SailObject__Func_21658D0
	mov r1, #0xa00
	str r1, [r5, #0x38]
	str r1, [r5, #0x3c]
	str r1, [r5, #0x40]
	ldr r0, [r6, #0x10]
	cmp r0, #0
	movlt r0, #0x5800
	subge r0, r1, #0x6200
	str r0, [r4, #0x170]
	mov r0, r5
	bl StageTask__InitSeqPlayer
	mov r0, r5
	bl SailHoverEnemyHover__SetupObject
	mov r0, r5
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0218407C: .word aSbSBoat01Nsbmd_1
_02184080: .word 0x00001388
	arm_func_end SailHoverBoat01__Create

	arm_func_start SpawnSailHoverTorpedo2
SpawnSailHoverTorpedo2: // 0x02184084
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x48
	add r3, sp, #0x3c
	mov r2, #0
	add r1, sp, #0x30
	mov r4, r0
	str r2, [r3]
	str r2, [r3, #4]
	str r2, [r3, #8]
	str r2, [r1]
	str r2, [r1, #4]
	str r2, [r1, #8]
	bl SailManager__GetWork
	ldr r5, [r4, #0x124]
	bl SailManager__GetWork
	ldr r3, [r0, #0x98]
	mov r2, #0
	sub r0, r2, #0x2000
	str r0, [sp, #0x40]
	str r2, [sp, #0x3c]
	str r2, [sp, #0x44]
	ldr r0, [r3, #0x44]
	ldr r1, [r5, #0x178]
	ldr r3, _02184198 // =FX_SinCosTable_
	sub r1, r1, r0
	rsb r0, r1, #0
	mov r0, r0, asr #3
	str r0, [sp, #0x34]
	str r2, [sp, #0x30]
	str r1, [sp, #0x38]
	ldrh r1, [r4, #0x32]
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r2, r1, #1
	mov r1, r1, lsl #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, sp, #0x3c
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
	add r0, sp, #0x3c
	add r1, r4, #0x44
	mov r2, r0
	bl VEC_Add
	add r0, sp, #0x30
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
	add r0, sp, #0x3c
	add r3, sp, #0x24
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r3
	mov r2, r3
	add r1, sp, #0x30
	bl VEC_Add
	mov r0, r4
	add r1, sp, #0x3c
	add r2, sp, #0x24
	mov r3, #0x700
	bl SailTorpedo2__Create
	add r0, sp, #0x3c
	bl EffectSailFlash__Create
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02184198: .word FX_SinCosTable_
	arm_func_end SpawnSailHoverTorpedo2

	arm_func_start SpawnSailHoverTorpedo1
SpawnSailHoverTorpedo1: // 0x0218419C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x6c
	add r4, sp, #0x60
	mov r3, #0
	add r2, sp, #0x54
	mov r7, r0
	mov r6, r1
	str r3, [r4]
	str r3, [r4, #4]
	str r3, [r4, #8]
	str r3, [r2]
	str r3, [r2, #4]
	str r3, [r2, #8]
	bl SailManager__GetWork
	mov r4, r0
	ldr r5, [r7, #0x124]
	bl SailManager__GetWork
	ldr r2, [r4, #0x24]
	ldr r1, [r0, #0x98]
	tst r2, #1
	addne sp, sp, #0x6c
	ldmneia sp!, {r4, r5, r6, r7, pc}
	mov r0, #0
	sub r2, r0, #0x800
	str r0, [sp, #0x60]
	str r2, [sp, #0x64]
	str r0, [sp, #0x68]
	ldr r3, [r5, #0x178]
	ldr r2, [r1, #0x44]
	cmp r6, #0
	sub r3, r3, r2
	rsb r2, r3, #0
	mov r2, r2, asr #3
	str r0, [sp, #0x54]
	str r2, [sp, #0x58]
	str r3, [sp, #0x5c]
	mov r4, #0x600
	beq _02184258
	ldr r2, [r5, #0x178]
	ldr r1, [r1, #0x44]
	mov r4, #0x800
	sub r2, r2, r1
	rsb r1, r2, #0
	mov r1, r1, asr #1
	str r0, [sp, #0x54]
	str r1, [sp, #0x58]
	str r2, [sp, #0x5c]
_02184258:
	ldrh r1, [r7, #0x32]
	ldr r3, _02184384 // =FX_SinCosTable_
	add r0, sp, #0x24
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r5, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r5]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	cmp r6, #0
	beq _021842CC
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _02184384 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0
	bl MTX_RotZ33_
	add r1, sp, #0x24
	add r0, sp, #0
	mov r2, r1
	bl MTX_Concat33
_021842CC:
	add r0, sp, #0x60
	add r1, sp, #0x24
	mov r2, r0
	bl MTX_MultVec33
	add r0, sp, #0x60
	add r1, r7, #0x44
	mov r2, r0
	bl VEC_Add
	add r0, sp, #0x54
	add r1, sp, #0x24
	mov r2, r0
	bl MTX_MultVec33
	add r0, sp, #0x60
	add r3, sp, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r3
	mov r2, r3
	add r1, sp, #0x54
	bl VEC_Add
	mov r0, r7
	mov r3, r4
	add r1, sp, #0x60
	add r2, sp, #0x48
	bl SailTorpedo2__Create
	cmp r0, #0
	addeq sp, sp, #0x6c
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r3, [r0, #0x38]
	mov r1, #0xd00
	mov r2, #0
	umull r5, r4, r3, r1
	mla r4, r3, r2, r4
	mov r2, r3, asr #0x1f
	mla r4, r2, r1, r4
	adds r3, r5, #0x800
	adc r1, r4, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x38]
	str r2, [r0, #0x3c]
	str r2, [r0, #0x40]
	add r0, sp, #0x60
	bl EffectSailFlash__Create
	add sp, sp, #0x6c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02184384: .word FX_SinCosTable_
	arm_func_end SpawnSailHoverTorpedo1

	arm_func_start SailHoverBob__Create
SailHoverBob__Create: // 0x02184388
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r6, r0
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #0x13
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _02184488 // =aSbBobNsbmd_1
	mov r0, r5
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, r5
	bl SailObject__Func_21646DC
	mov r0, r5
	mov r1, r6
	bl SailObject__InitFromMapObject
	ldr r1, [r4, #0x174]
	mov r0, #0x4000
	sub r1, r1, #0x1800
	str r1, [r4, #0x174]
	str r0, [r4, #0x120]
	str r0, [r4, #0x11c]
	mov r0, #0x190
	str r0, [r4, #0x118]
	ldr r1, [r5, #0x24]
	mov r0, #0xc00
	orr r1, r1, #2
	str r1, [r5, #0x24]
	str r0, [r4, #0x124]
	mov r0, #0x10
	str r0, [r4, #0x13c]
	mov r0, r5
	add r1, r4, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r5
	mov r2, #0xa80
	mov r3, r1
	bl SailObject__Func_21658D0
	mov r0, r5
	bl StageTask__InitSeqPlayer
	ldr r0, [r6, #0x10]
	cmp r0, #0
	ldr r0, [r4, #0x170]
	addlt r0, r0, #0x8000
	subge r0, r0, #0x8000
	str r0, [r4, #0x170]
	mov r0, r5
	bl SailHoverBob__SetupObject
	mov r0, r5
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02184488: .word aSbBobNsbmd_1
	arm_func_end SailHoverBob__Create

	arm_func_start SailHoverBobBird__Create
SailHoverBobBird__Create: // 0x0218448C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	mov r9, r0
	mov r10, #0xa80
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	ldr r1, [r9, #0x34]
	mov r5, r0
	tst r1, #4
	beq _021844F8
	mov r0, #0x13
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	str r6, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _0218479C // =aSbBobNsbmd_1
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	b _02184524
_021844F8:
	mov r0, #0x16
	bl GetObjectFileWork
	mov r6, r0
	bl SailManager__GetArchive
	str r6, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _021847A0 // =aSbBirdNsbmd_2
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
_02184524:
	mov r0, r4
	bl SailObject__Func_21646DC
	mov r0, r4
	mov r1, r9
	bl SailObject__InitFromMapObject
	ldr r0, [r5, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #0x20
	beq _02184644
	ldr r0, [r5, #0x174]
	mov r1, #0xe0000
	sub r0, r0, #0x1800
	str r0, [r5, #0x174]
	str r1, [r5, #0x120]
	ldr r0, _021847A4 // =0x00002328
	str r1, [r5, #0x11c]
	str r0, [r5, #0x118]
	ldr r2, [r4, #0x38]
	mov r0, #0x800
	mov r1, r2, asr #0x1f
	mov r1, r1, lsl #0xd
	adds r3, r0, r2, lsl #13
	orr r1, r1, r2, lsr #19
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	mov r0, #0x16
	mov r10, #0x1500
	bl GetObjectFileWork
	ldr r0, [r0]
	add r1, r5, #0x18c
	bl ObjDraw__PaletteTex__Init
	ldr r0, [r5, #0x194]
	ldr r7, [r5, #0x190]
	ldr r6, [r5, #0x18c]
	mov r8, #0
	bl NNS_G3dPlttGetRequiredSize
	movs r0, r0, lsr #1
	beq _02184610
_021845CC:
	mov r2, r8, lsl #1
	ldrh r1, [r7, r2]
	add r8, r8, #1
	and r3, r1, #0x1f
	and r0, r1, #0x7c00
	eor r3, r3, r0, asr #10
	eor r0, r3, r0, asr #10
	and r1, r1, #0x3e0
	eor r3, r3, r0
	bic r1, r1, #0x1f
	orr r1, r3, r1
	orr r0, r1, r0, lsl #10
	strh r0, [r6, r2]
	ldr r0, [r5, #0x194]
	bl NNS_G3dPlttGetRequiredSize
	cmp r8, r0, lsr #1
	blo _021845CC
_02184610:
	ldr r0, [r5, #0x194]
	bl NNS_G3dPlttGetRequiredSize
	mov r7, r0
	ldr r0, [r5, #0x194]
	mov r1, #0
	bl Asset3DSetup__GetTexPaletteLocation
	mov r1, r7, lsl #0xf
	mov r1, r1, lsr #0x10
	mov r3, r0
	mov r0, r6
	mov r2, #5
	bl QueueUncompressedPalette
	b _02184690
_02184644:
	ldr r0, [r9, #0x34]
	ldr r1, [r5, #0x174]
	tst r0, #4
	beq _02184674
	sub r1, r1, #0x1800
	mov r0, #0x4000
	str r1, [r5, #0x174]
	str r0, [r5, #0x120]
	str r0, [r5, #0x11c]
	mov r0, #0x190
	str r0, [r5, #0x118]
	b _02184690
_02184674:
	sub r1, r1, #0x1800
	mov r0, #0x800
	str r1, [r5, #0x174]
	str r0, [r5, #0x120]
	str r0, [r5, #0x11c]
	mov r0, #0xc8
	str r0, [r5, #0x118]
_02184690:
	mov r0, #5
	str r0, [r5, #0x13c]
	ldr r0, [r9, #0x28]
	mov r3, #0x800
	cmp r0, #0
	strne r0, [r5, #0x13c]
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #2
	str r1, [r4, #0x24]
	add r1, r5, #0x28
	mov r2, #0
	str r3, [r5, #0x124]
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r4
	mov r2, r10
	mov r3, r1
	bl SailObject__Func_21658D0
	mov r0, r4
	bl StageTask__InitSeqPlayer
	ldr r0, [r5, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #0x20
	beq _02184730
	mov r0, r4
	mov r1, #0
	bl StageTask__GetCollider
	ldrh r3, [r0, #0x32]
	mov r2, #0x40000
	mov r1, #0x14
	orr r3, r3, #4
	strh r3, [r0, #0x32]
	str r2, [r5, #0x98]
	strh r1, [r0, #0x2c]
	mov r0, r4
	bl SailHoverBobBird__SetupObject
	add sp, sp, #8
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02184730:
	ldrh r0, [r9, #0x30]
	sub r0, r0, #0x15
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _02184758
_02184744: // jump table
	b _02184758 // case 0
	b _02184764 // case 1
	b _02184770 // case 2
	b _0218477C // case 3
	b _02184788 // case 4
_02184758:
	mov r0, r4
	bl SailHoverBobBird__SetupObject0x1A
	b _02184790
_02184764:
	mov r0, r4
	bl SailHoverBobBird__SetupObject0x16
	b _02184790
_02184770:
	mov r0, r4
	bl SailHoverBobBird__SetupObject0x17
	b _02184790
_0218477C:
	mov r0, r4
	bl SailHoverBobBird__SetupObject0x18
	b _02184790
_02184788:
	mov r0, r4
	bl SailHoverBobBird__SetupObject0x19
_02184790:
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0218479C: .word aSbBobNsbmd_1
_021847A0: .word aSbBirdNsbmd_2
_021847A4: .word 0x00002328
	arm_func_end SailHoverBobBird__Create

	arm_func_start SailHoverBob__SetupObject
SailHoverBob__SetupObject: // 0x021847A8
	ldr r2, [r0, #0x20]
	ldr r1, _021847D0 // =SailHoverBob__State_21847D4
	orr r2, r2, #0x20
	orr r2, r2, #0x1000
	str r2, [r0, #0x20]
	ldr r2, [r0, #0x18]
	orr r2, r2, #0x12
	str r2, [r0, #0x18]
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_021847D0: .word SailHoverBob__State_21847D4
	arm_func_end SailHoverBob__SetupObject

	arm_func_start SailHoverBob__State_21847D4
SailHoverBob__State_21847D4: // 0x021847D4
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r5, [r4, #0x124]
	bl SailManager__GetWork
	add r1, r5, #0x100
	ldr r6, [r0, #0x98]
	ldrh r1, [r1, #0x6e]
	mov r0, r4
	strh r1, [r4, #0x32]
	bl SailObject__SetupAnimator3D
	mov r0, r4
	bl SailObject__Func_2166A2C
	ldr r1, [r5, #0x178]
	ldr r0, [r6, #0x44]
	sub r0, r1, r0
	cmp r0, #0xc000
	ldmgeia sp!, {r4, r5, r6, pc}
	mov r0, r4
	bl SailHoverEnemyHover__Func_2184C00
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SailHoverBob__State_21847D4

	arm_func_start SailHoverEnemyHover__SetupObject
SailHoverEnemyHover__SetupObject: // 0x02184824
	ldr r2, [r0, #0x20]
	ldr r1, _0218484C // =SailHoverEnemyHover__State_2184850
	orr r2, r2, #0x20
	orr r2, r2, #0x1000
	str r2, [r0, #0x20]
	ldr r2, [r0, #0x18]
	orr r2, r2, #0x12
	str r2, [r0, #0x18]
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_0218484C: .word SailHoverEnemyHover__State_2184850
	arm_func_end SailHoverEnemyHover__SetupObject

	arm_func_start SailHoverEnemyHover__State_2184850
SailHoverEnemyHover__State_2184850: // 0x02184850
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r5, [r4, #0x124]
	bl SailManager__GetWork
	add r1, r5, #0x100
	ldr r6, [r0, #0x98]
	ldrh r1, [r1, #0x6e]
	mov r0, r4
	strh r1, [r4, #0x32]
	bl SailObject__SetupAnimator3D
	mov r0, r4
	bl SailObject__Func_2166A2C
	ldr r1, [r5, #0x178]
	ldr r0, [r6, #0x44]
	sub r0, r1, r0
	cmp r0, #0x8000
	ldmgeia sp!, {r4, r5, r6, pc}
	ldr r0, [r5, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #0xf
	beq _021848B8
	cmp r0, #0x13
	mov r0, r4
	beq _021848C4
	bl SailHoverEnemyHover__Func_21848CC
	ldmia sp!, {r4, r5, r6, pc}
_021848B8:
	mov r0, r4
	bl SailHoverEnemyHover__Func_2184A7C
	ldmia sp!, {r4, r5, r6, pc}
_021848C4:
	bl SailHoverEnemyHover__Func_2186E10
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SailHoverEnemyHover__State_2184850

	arm_func_start SailHoverEnemyHover__Func_21848CC
SailHoverEnemyHover__Func_21848CC: // 0x021848CC
	ldr r1, [r0, #0x20]
	ldr ip, [r0, #0x124]
	bic r1, r1, #0x20
	bic r1, r1, #0x1000
	str r1, [r0, #0x20]
	ldr r1, [r0, #0x18]
	ldr r2, _02184910 // =SailHoverEnemyHover__State_2184914
	bic r1, r1, #0x10
	bic r1, r1, #2
	str r1, [r0, #0x18]
	ldr r3, [r0, #0x24]
	mov r1, #0x800
	orr r3, r3, #1
	str r3, [r0, #0x24]
	str r2, [r0, #0xf4]
	str r1, [ip, #0x184]
	bx lr
	.align 2, 0
_02184910: .word SailHoverEnemyHover__State_2184914
	arm_func_end SailHoverEnemyHover__Func_21848CC

	arm_func_start SailHoverEnemyHover__State_2184914
SailHoverEnemyHover__State_2184914: // 0x02184914
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r0, [r4, #0x164]
	ldr r1, _02184A74 // =FX_SinCosTable_
	ldr r0, [r0, #0x34]
	mov r5, #0x38
	tst r0, #8
	ldr r0, [r6, #0x28]
	movne r5, #0x20
	mov r0, r0, lsl #0x19
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r0, [r1, r0]
	mov r0, r0, asr #2
	str r0, [r4, #0x17c]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x10]
	cmp r0, #0
	ldrlt r0, [r4, #0x17c]
	rsblt r0, r0, #0
	strlt r0, [r4, #0x17c]
	ldr r0, [r6, #0x28]
	cmp r0, #8
	bls _021849E0
	cmp r0, #0x48
	bhs _021849E0
	ldr r0, [r4, #0x184]
	mov r1, #0x14
	bl ObjSpdDownSet
	str r0, [r4, #0x184]
	ldr r1, [r4, #0x164]
	ldr r0, [r1, #0x34]
	tst r0, #2
	ldreq r0, [r1, #0x28]
	cmpeq r0, #0
	beq _021849FC
	ldr r0, [r4, #0x128]
	cmp r0, #0
	ldreq r0, [r6, #0x28]
	cmpeq r0, r5
	bne _021849FC
	ldr r1, [r4, #0x13c]
	ldr r0, _02184A78 // =_0218C8C8
	ldrb r0, [r0, r1]
	str r0, [r4, #0x128]
	b _021849FC
_021849E0:
	cmp r0, #0x48
	blo _021849FC
	ldr r0, [r4, #0x184]
	mov r1, #0x48
	mov r2, #0xc00
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
_021849FC:
	ldr r0, [r4, #0x128]
	cmp r0, #0
	beq _02184A24
	mov r0, #0
	str r0, [r4, #0x17c]
	ldr r1, [r4, #0x128]
	mov r0, r6
	sub r1, r1, #1
	str r1, [r4, #0x128]
	bl SailHoverEnemyHover__Func_2187134
_02184A24:
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r6
	strh r1, [r6, #0x32]
	bl SailObject__SetupAnimator3D
	mov r0, r6
	bl SailObject__Func_2166D18
	mov r0, r6
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x128]
	cmp r0, #0
	ldreq r0, [r6, #0x28]
	addeq r0, r0, #1
	streq r0, [r6, #0x28]
	ldr r0, [r6, #0x28]
	cmp r0, #0xb2
	ldrhi r0, [r6, #0x18]
	orrhi r0, r0, #4
	strhi r0, [r6, #0x18]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02184A74: .word FX_SinCosTable_
_02184A78: .word _0218C8C8
	arm_func_end SailHoverEnemyHover__State_2184914

	arm_func_start SailHoverEnemyHover__Func_2184A7C
SailHoverEnemyHover__Func_2184A7C: // 0x02184A7C
	ldr r2, [r0, #0x20]
	ldr r1, [r0, #0x124]
	bic r2, r2, #0x20
	bic r2, r2, #0x1000
	str r2, [r0, #0x20]
	ldr r2, [r0, #0x18]
	ldr r3, _02184AE0 // =SailHoverEnemyHover__State_2184AE4
	bic r2, r2, #0x10
	bic r2, r2, #2
	str r2, [r0, #0x18]
	ldr ip, [r0, #0x24]
	mov r2, #0x800
	orr ip, ip, #1
	str ip, [r0, #0x24]
	str r3, [r0, #0xf4]
	str r2, [r1, #0x184]
	mov r0, #0x180
	str r0, [r1, #0x17c]
	ldr r0, [r1, #0x164]
	ldr r0, [r0, #0x10]
	cmp r0, #0
	ldrlt r0, [r1, #0x17c]
	rsblt r0, r0, #0
	strlt r0, [r1, #0x17c]
	bx lr
	.align 2, 0
_02184AE0: .word SailHoverEnemyHover__State_2184AE4
	arm_func_end SailHoverEnemyHover__Func_2184A7C

	arm_func_start SailHoverEnemyHover__State_2184AE4
SailHoverEnemyHover__State_2184AE4: // 0x02184AE4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r1, [r4, #0x164]
	ldr r2, _02184BF8 // =FX_SinCosTable_
	ldr r1, [r1, #0x34]
	mov r0, #0x40
	tst r1, #8
	ldr r1, [r6, #0x28]
	movne r0, #0x20
	mov r1, r1, lsl #0x18
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #1
	ldrsh r1, [r2, r1]
	mov r1, r1, asr #1
	str r1, [r4, #0x184]
	ldr r2, [r4, #0x164]
	ldr r5, [r4, #0x17c]
	ldr r1, [r2, #0x34]
	tst r1, #2
	ldreq r1, [r2, #0x28]
	cmpeq r1, #0
	beq _02184B7C
	ldr r1, [r4, #0x128]
	cmp r1, #0
	ldreq r1, [r6, #0x28]
	cmpeq r1, r0
	bne _02184B7C
	ldr r1, [r4, #0x13c]
	ldr r0, _02184BFC // =_0218C8C8
	ldrb r0, [r0, r1]
	str r0, [r4, #0x128]
_02184B7C:
	ldr r0, [r4, #0x128]
	cmp r0, #0
	beq _02184BA4
	mov r0, #0
	str r0, [r4, #0x17c]
	ldr r1, [r4, #0x128]
	mov r0, r6
	sub r1, r1, #1
	str r1, [r4, #0x128]
	bl SailHoverEnemyHover__Func_2187134
_02184BA4:
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r6
	strh r1, [r6, #0x32]
	bl SailObject__SetupAnimator3D
	mov r0, r6
	bl SailObject__Func_2166D18
	mov r0, r6
	bl SailObject__Func_2166A2C
	str r5, [r4, #0x17c]
	ldr r0, [r4, #0x128]
	cmp r0, #0
	ldreq r0, [r6, #0x28]
	addeq r0, r0, #1
	streq r0, [r6, #0x28]
	ldr r0, [r6, #0x28]
	cmp r0, #0x88
	ldrhi r0, [r6, #0x18]
	orrhi r0, r0, #4
	strhi r0, [r6, #0x18]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02184BF8: .word FX_SinCosTable_
_02184BFC: .word _0218C8C8
	arm_func_end SailHoverEnemyHover__State_2184AE4

	arm_func_start SailHoverEnemyHover__Func_2184C00
SailHoverEnemyHover__Func_2184C00: // 0x02184C00
	ldr r2, [r0, #0x20]
	ldr r1, _02184C38 // =SailHoverEnemyHover__State_2184C3C
	bic r2, r2, #0x20
	bic r2, r2, #0x1000
	str r2, [r0, #0x20]
	ldr r2, [r0, #0x18]
	bic r2, r2, #0x10
	bic r2, r2, #2
	str r2, [r0, #0x18]
	ldr r2, [r0, #0x24]
	orr r2, r2, #1
	str r2, [r0, #0x24]
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_02184C38: .word SailHoverEnemyHover__State_2184C3C
	arm_func_end SailHoverEnemyHover__Func_2184C00

	arm_func_start SailHoverEnemyHover__State_2184C3C
SailHoverEnemyHover__State_2184C3C: // 0x02184C3C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r1, [r6, #0x28]
	ldr r0, _02184DD0 // =FX_SinCosTable_
	mov r1, r1, lsl #0x18
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #1
	ldrsh r3, [r0, r1]
	mov r1, #0x2e0
	mov r2, #0
	umull ip, r5, r3, r1
	mla r5, r3, r2, r5
	mov r2, r3, asr #0x1f
	mla r5, r2, r1, r5
	adds ip, ip, #0x800
	adc r1, r5, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x17c]
	ldr r1, [r6, #0x28]
	mov r1, r1, lsl #0x18
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r0, [r0, r1]
	rsb r0, r0, #0
	mov r0, r0, asr #1
	str r0, [r4, #0x184]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x10]
	cmp r0, #0
	ldrlt r0, [r4, #0x17c]
	rsblt r0, r0, #0
	strlt r0, [r4, #0x17c]
	ldr r0, [r6, #0x28]
	ldr r5, [r4, #0x180]
	cmp r0, #0x14
	bls _02184D0C
	mov r0, r5
	mvn r1, #0x27
	mov r2, #0x400
	bl ObjSpdUpSet
	str r0, [r4, #0x180]
_02184D0C:
	ldr r1, [r4, #0x164]
	ldr r0, [r1, #0x34]
	tst r0, #2
	ldreq r0, [r1, #0x28]
	cmpeq r0, #0
	beq _02184D48
	ldr r0, [r4, #0x128]
	cmp r0, #0
	ldreq r0, [r6, #0x28]
	cmpeq r0, #0x2c
	bne _02184D48
	ldr r1, [r4, #0x13c]
	ldr r0, _02184DD4 // =_0218C8C8
	ldrb r0, [r0, r1]
	str r0, [r4, #0x128]
_02184D48:
	ldr r0, [r4, #0x128]
	cmp r0, #0
	beq _02184D78
	mov r0, #0
	str r0, [r4, #0x17c]
	str r0, [r4, #0x180]
	str r0, [r4, #0x184]
	ldr r1, [r4, #0x128]
	mov r0, r6
	sub r1, r1, #1
	str r1, [r4, #0x128]
	bl SailHoverEnemyHover__Func_2187134
_02184D78:
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r6
	strh r1, [r6, #0x32]
	bl SailObject__SetupAnimator3D
	mov r0, r6
	bl SailObject__Func_2166D18
	mov r0, r6
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x128]
	cmp r0, #0
	strne r5, [r4, #0x180]
	bne _02184DB8
	ldr r0, [r6, #0x28]
	add r0, r0, #1
	str r0, [r6, #0x28]
_02184DB8:
	ldr r0, [r6, #0x28]
	cmp r0, #0x88
	ldrhi r0, [r6, #0x18]
	orrhi r0, r0, #4
	strhi r0, [r6, #0x18]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02184DD0: .word FX_SinCosTable_
_02184DD4: .word _0218C8C8
	arm_func_end SailHoverEnemyHover__State_2184C3C

	arm_func_start SailHoverBobBird__SetupObject0x1A
SailHoverBobBird__SetupObject0x1A: // 0x02184DD8
	ldr r3, [r0, #0x124]
	mov r1, #0
	str r1, [r0, #0x28]
	sub r2, r1, #0x1000
	ldr r1, _02184E04 // =SailHoverBobBird__State_2184E08
	str r2, [r3, #0x184]
	str r1, [r0, #0xf4]
	ldr r1, [r0, #0x24]
	orr r1, r1, #1
	str r1, [r0, #0x24]
	bx lr
	.align 2, 0
_02184E04: .word SailHoverBobBird__State_2184E08
	arm_func_end SailHoverBobBird__SetupObject0x1A

	arm_func_start SailHoverBobBird__State_2184E08
SailHoverBobBird__State_2184E08: // 0x02184E08
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r0, [r4, #0x164]
	mov r5, #0x38
	ldr r0, [r0, #0x34]
	tst r0, #8
	ldr r0, [r4, #0x128]
	movne r5, #8
	cmp r0, #0x3a
	ble _02184EDC
	ldr r0, [r4, #0x184]
	mov r1, #0xcc
	mov r2, #0x1000
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x10]
	cmp r0, #0
	bge _02184E7C
	ldr r0, [r6, #0x28]
	add r0, r0, #0x400
	str r0, [r6, #0x28]
	cmp r0, #0x8000
	movhi r0, #0x8000
	strhi r0, [r6, #0x28]
	b _02184E98
_02184E7C:
	ldr r1, [r6, #0x28]
	mov r0, #0x8000
	sub r1, r1, #0x400
	rsb r0, r0, #0
	str r1, [r6, #0x28]
	cmp r1, r0
	strlo r0, [r6, #0x28]
_02184E98:
	ldr r0, [r6, #0x28]
	ldr r1, _02184FC4 // =FX_SinCosTable_
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r0, [r1, r0]
	mov r0, r0, asr #2
	str r0, [r4, #0x17c]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #1
	ldreq r0, [r4, #0x17c]
	moveq r0, r0, asr #1
	streq r0, [r4, #0x17c]
_02184EDC:
	ldr r1, [r4, #0x164]
	ldr r0, [r1, #0x34]
	tst r0, #2
	ldreq r0, [r1, #0x28]
	cmpeq r0, #0
	beq _02184F60
	ldr r0, [r4, #0x140]
	cmp r0, #0
	ldreq r0, [r4, #0x128]
	cmpeq r0, r5
	bne _02184F18
	ldr r1, [r4, #0x13c]
	ldr r0, _02184FC8 // =_0218C8C8
	ldrb r0, [r0, r1]
	str r0, [r4, #0x140]
_02184F18:
	ldr r0, [r4, #0x140]
	cmp r0, #0
	beq _02184F60
	add r0, r4, #0x17c
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x140]
	subs r0, r0, #1
	str r0, [r4, #0x140]
	beq _02184F54
	mov r0, #0
	str r0, [r4, #0x17c]
	str r0, [r4, #0x180]
	str r0, [r4, #0x184]
_02184F54:
	ldr r1, [r4, #0x140]
	mov r0, r6
	bl SailHoverEnemyHover__Func_2187134
_02184F60:
	add r0, r4, #0x100
	ldrh r2, [r0, #0x6e]
	ldr r1, [r6, #0x28]
	mov r0, r6
	add r1, r2, r1
	strh r1, [r6, #0x32]
	bl SailObject__SetupAnimator3D
	mov r0, r6
	bl SailObject__Func_2166D18
	mov r0, r6
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x140]
	cmp r0, #0
	bne _02184FAC
	ldr r0, [r4, #0x128]
	add sp, sp, #0xc
	add r0, r0, #1
	str r0, [r4, #0x128]
	ldmia sp!, {r3, r4, r5, r6, pc}
_02184FAC:
	add r0, sp, #0
	add r3, r4, #0x17c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02184FC4: .word FX_SinCosTable_
_02184FC8: .word _0218C8C8
	arm_func_end SailHoverBobBird__State_2184E08

	arm_func_start SailHoverBobBird__SetupObject0x16
SailHoverBobBird__SetupObject0x16: // 0x02184FCC
	ldr r3, [r0, #0x124]
	mov r1, #0
	str r1, [r0, #0x28]
	sub r2, r1, #0xd00
	ldr r1, _02184FF8 // =SailHoverBobBird__State_2184FFC
	str r2, [r3, #0x184]
	str r1, [r0, #0xf4]
	ldr r1, [r0, #0x24]
	orr r1, r1, #1
	str r1, [r0, #0x24]
	bx lr
	.align 2, 0
_02184FF8: .word SailHoverBobBird__State_2184FFC
	arm_func_end SailHoverBobBird__SetupObject0x16

	arm_func_start SailHoverBobBird__State_2184FFC
SailHoverBobBird__State_2184FFC: // 0x02184FFC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r1, [r4, #0x164]
	ldr r3, _02185184 // =FX_SinCosTable_
	ldr r1, [r1, #0x34]
	mov r0, #0x3c
	tst r1, #8
	ldr r1, [r4, #0x128]
	movne r0, #0xa
	mov r1, r1, lsl #0x1a
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r2, [r3, r1]
	mov r1, r2, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r1, [r3, r1]
	str r2, [r5, #0x28]
	str r1, [r4, #0x17c]
	ldr r1, [r4, #0x164]
	ldr r1, [r1, #0x34]
	tst r1, #1
	ldreq r1, [r4, #0x17c]
	moveq r1, r1, asr #1
	streq r1, [r4, #0x17c]
	ldr r1, [r4, #0x164]
	ldr r1, [r1, #0x10]
	cmp r1, #0
	ldrlt r1, [r4, #0x17c]
	rsblt r1, r1, #0
	strlt r1, [r4, #0x17c]
	ldr r2, [r4, #0x164]
	ldr r1, [r2, #0x34]
	tst r1, #2
	ldreq r1, [r2, #0x28]
	cmpeq r1, #0
	beq _02185120
	ldr r1, [r4, #0x140]
	cmp r1, #0
	ldreq r1, [r4, #0x128]
	cmpeq r1, r0
	bne _021850D8
	ldr r1, [r4, #0x13c]
	ldr r0, _02185188 // =_0218C8C8
	ldrb r0, [r0, r1]
	str r0, [r4, #0x140]
_021850D8:
	ldr r0, [r4, #0x140]
	cmp r0, #0
	beq _02185120
	add r0, r4, #0x17c
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x140]
	subs r0, r0, #1
	str r0, [r4, #0x140]
	beq _02185114
	mov r0, #0
	str r0, [r4, #0x17c]
	str r0, [r4, #0x180]
	str r0, [r4, #0x184]
_02185114:
	ldr r1, [r4, #0x140]
	mov r0, r5
	bl SailHoverEnemyHover__Func_2187134
_02185120:
	ldr r1, [r5, #0x28]
	add r0, r4, #0x100
	strh r1, [r5, #0x34]
	ldrh r1, [r0, #0x6e]
	mov r0, r5
	strh r1, [r5, #0x32]
	bl SailObject__SetupAnimator3D
	mov r0, r5
	bl SailObject__Func_2166D18
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x140]
	cmp r0, #0
	bne _0218516C
	ldr r0, [r4, #0x128]
	add sp, sp, #0xc
	add r0, r0, #1
	str r0, [r4, #0x128]
	ldmia sp!, {r4, r5, pc}
_0218516C:
	add r0, sp, #0
	add r3, r4, #0x17c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02185184: .word FX_SinCosTable_
_02185188: .word _0218C8C8
	arm_func_end SailHoverBobBird__State_2184FFC

	arm_func_start SailHoverBobBird__SetupObject0x17
SailHoverBobBird__SetupObject0x17: // 0x0218518C
	ldr r3, [r0, #0x124]
	mov r1, #0
	str r1, [r0, #0x28]
	sub r2, r1, #0xe00
	ldr r1, _021851B8 // =SailHoverBobBird__State_21851BC
	str r2, [r3, #0x184]
	str r1, [r0, #0xf4]
	ldr r1, [r0, #0x24]
	orr r1, r1, #1
	str r1, [r0, #0x24]
	bx lr
	.align 2, 0
_021851B8: .word SailHoverBobBird__State_21851BC
	arm_func_end SailHoverBobBird__SetupObject0x17

	arm_func_start SailHoverBobBird__State_21851BC
SailHoverBobBird__State_21851BC: // 0x021851BC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r2, [r4, #0x164]
	mov r0, #0x46
	ldr r1, [r2, #0x34]
	tst r1, #8
	ldr r1, [r4, #0x128]
	movne r0, #0xc
	cmp r1, #0x24
	ble _02185264
	ldr r1, [r2, #0x10]
	cmp r1, #0
	ble _02185218
	ldr r1, [r5, #0x28]
	add r1, r1, #0x80
	str r1, [r5, #0x28]
	cmp r1, #0x2000
	movhi r1, #0x2000
	strhi r1, [r5, #0x28]
	b _02185234
_02185218:
	ldr r2, [r5, #0x28]
	mov r1, #0x2000
	sub r2, r2, #0x80
	rsb r1, r1, #0
	str r2, [r5, #0x28]
	cmp r2, r1
	strlo r1, [r5, #0x28]
_02185234:
	ldr r1, [r5, #0x28]
	ldr r2, _0218534C // =FX_SinCosTable_
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r1, [r2, r1]
	rsb r1, r1, #0
	mov r1, r1, asr #1
	str r1, [r4, #0x17c]
_02185264:
	ldr r2, [r4, #0x164]
	ldr r1, [r2, #0x34]
	tst r1, #2
	ldreq r1, [r2, #0x28]
	cmpeq r1, #0
	beq _021852E8
	ldr r1, [r4, #0x140]
	cmp r1, #0
	ldreq r1, [r4, #0x128]
	cmpeq r1, r0
	bne _021852A0
	ldr r1, [r4, #0x13c]
	ldr r0, _02185350 // =_0218C8C8
	ldrb r0, [r0, r1]
	str r0, [r4, #0x140]
_021852A0:
	ldr r0, [r4, #0x140]
	cmp r0, #0
	beq _021852E8
	add r0, r4, #0x17c
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x140]
	subs r0, r0, #1
	str r0, [r4, #0x140]
	beq _021852DC
	mov r0, #0
	str r0, [r4, #0x17c]
	str r0, [r4, #0x180]
	str r0, [r4, #0x184]
_021852DC:
	ldr r1, [r4, #0x140]
	mov r0, r5
	bl SailHoverEnemyHover__Func_2187134
_021852E8:
	ldr r1, [r5, #0x28]
	add r0, r4, #0x100
	strh r1, [r5, #0x34]
	ldrh r1, [r0, #0x6e]
	mov r0, r5
	strh r1, [r5, #0x32]
	bl SailObject__SetupAnimator3D
	mov r0, r5
	bl SailObject__Func_2166D18
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x140]
	cmp r0, #0
	bne _02185334
	ldr r0, [r4, #0x128]
	add sp, sp, #0xc
	add r0, r0, #1
	str r0, [r4, #0x128]
	ldmia sp!, {r4, r5, pc}
_02185334:
	add r0, sp, #0
	add r3, r4, #0x17c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0218534C: .word FX_SinCosTable_
_02185350: .word _0218C8C8
	arm_func_end SailHoverBobBird__State_21851BC

	arm_func_start SailHoverBobBird__SetupObject0x18
SailHoverBobBird__SetupObject0x18: // 0x02185354
	mov r2, #0
	ldr r1, _02185374 // =SailHoverBobBird__State_2185378
	str r2, [r0, #0x28]
	str r1, [r0, #0xf4]
	ldr r1, [r0, #0x24]
	orr r1, r1, #1
	str r1, [r0, #0x24]
	bx lr
	.align 2, 0
_02185374: .word SailHoverBobBird__State_2185378
	arm_func_end SailHoverBobBird__SetupObject0x18

	arm_func_start SailHoverBobBird__State_2185378
SailHoverBobBird__State_2185378: // 0x02185378
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r2, [r4, #0x164]
	mov r1, #0x68
	ldr r0, [r2, #0x34]
	tst r0, #8
	ldr r0, [r4, #0x128]
	movne r1, #0x34
	cmp r0, #0x34
	ble _021853F0
	ldr r0, [r2, #0x10]
	cmp r0, #0
	bge _021853D4
	ldr r0, [r5, #0x28]
	add r0, r0, #0x400
	str r0, [r5, #0x28]
	cmp r0, #0x10000
	movhi r0, #0x10000
	strhi r0, [r5, #0x28]
	b _021853F0
_021853D4:
	ldr r2, [r5, #0x28]
	mov r0, #0x10000
	sub r2, r2, #0x400
	rsb r0, r0, #0
	str r2, [r5, #0x28]
	cmp r2, r0
	strlo r0, [r5, #0x28]
_021853F0:
	ldr r2, [r5, #0x28]
	ldr r0, _02185534 // =FX_SinCosTable_
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r2, [r0, r2]
	rsb r2, r2, #0
	str r2, [r4, #0x184]
	ldr r2, [r5, #0x28]
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r0, [r0, r2]
	mov r0, r0, asr #2
	str r0, [r4, #0x17c]
	ldr r2, [r4, #0x164]
	ldr r0, [r2, #0x34]
	tst r0, #2
	ldreq r0, [r2, #0x28]
	cmpeq r0, #0
	beq _021854D0
	ldr r0, [r4, #0x140]
	cmp r0, #0
	ldreq r0, [r4, #0x128]
	cmpeq r0, r1
	bne _02185488
	ldr r1, [r4, #0x13c]
	ldr r0, _02185538 // =_0218C8C8
	ldrb r0, [r0, r1]
	str r0, [r4, #0x140]
_02185488:
	ldr r0, [r4, #0x140]
	cmp r0, #0
	beq _021854D0
	add r0, r4, #0x17c
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x140]
	subs r0, r0, #1
	str r0, [r4, #0x140]
	beq _021854C4
	mov r0, #0
	str r0, [r4, #0x17c]
	str r0, [r4, #0x180]
	str r0, [r4, #0x184]
_021854C4:
	ldr r1, [r4, #0x140]
	mov r0, r5
	bl SailHoverEnemyHover__Func_2187134
_021854D0:
	add r0, r4, #0x100
	ldrh r2, [r0, #0x6e]
	ldr r1, [r5, #0x28]
	mov r0, r5
	add r1, r2, r1
	strh r1, [r5, #0x32]
	bl SailObject__SetupAnimator3D
	mov r0, r5
	bl SailObject__Func_2166D18
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x140]
	cmp r0, #0
	bne _0218551C
	ldr r0, [r4, #0x128]
	add sp, sp, #0xc
	add r0, r0, #1
	str r0, [r4, #0x128]
	ldmia sp!, {r4, r5, pc}
_0218551C:
	add r0, sp, #0
	add r3, r4, #0x17c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02185534: .word FX_SinCosTable_
_02185538: .word _0218C8C8
	arm_func_end SailHoverBobBird__State_2185378

	arm_func_start SailHoverBobBird__SetupObject0x19
SailHoverBobBird__SetupObject0x19: // 0x0218553C
	ldr r1, [r0, #0x124]
	mov r3, #0
	str r3, [r0, #0x28]
	ldr r2, [r1, #0x164]
	ldr r2, [r2, #0x34]
	tst r2, #0x10
	subne r2, r3, #0xa00
	subeq r2, r3, #0x1000
	str r2, [r1, #0x184]
	ldr r2, _021855EC // =SailHoverBobBird__State_21855F0
	str r2, [r0, #0xf4]
	ldr r2, [r0, #0x24]
	orr r2, r2, #1
	str r2, [r0, #0x24]
	ldr r2, [r1, #0x164]
	ldr r2, [r2, #0x10]
	cmp r2, #0
	ble _021855AC
	mov r2, #0x4000
	rsb r2, r2, #0
	str r2, [r0, #0x28]
	mov r2, #0xc800
	str r2, [r1, #0x170]
	ldr r2, [r1, #0x164]
	ldr r2, [r2, #0x34]
	tst r2, #0x10
	movne r2, #0x13800
	b _021855CC
_021855AC:
	mov r3, #0x4000
	str r3, [r0, #0x28]
	sub r2, r3, #0x10800
	str r2, [r1, #0x170]
	ldr r2, [r1, #0x164]
	ldr r2, [r2, #0x34]
	tst r2, #0x10
	subne r2, r3, #0x17800
_021855CC:
	strne r2, [r1, #0x170]
	ldr r1, [r0, #0x20]
	orr r1, r1, #0x20
	str r1, [r0, #0x20]
	ldr r1, [r0, #0x18]
	orr r1, r1, #0x12
	str r1, [r0, #0x18]
	bx lr
	.align 2, 0
_021855EC: .word SailHoverBobBird__State_21855F0
	arm_func_end SailHoverBobBird__SetupObject0x19

	arm_func_start SailHoverBobBird__State_21855F0
SailHoverBobBird__State_21855F0: // 0x021855F0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r1, [r4, #0x164]
	mov r0, #0x5a
	ldr r1, [r1, #0x34]
	tst r1, #8
	movne r0, #0x4e
	tst r1, #0x10
	addne r0, r0, #0x14
	movne r0, r0, lsl #0x10
	ldr r1, [r4, #0x128]
	movne r0, r0, lsr #0x10
	cmp r1, #0x34
	bne _02185670
	mvn r2, #0xff
	str r2, [r4, #0x184]
	ldr r1, [r4, #0x164]
	ldr r1, [r1, #0x10]
	cmp r1, #0
	subgt r1, r2, #0x500
	movle r1, #0x600
	str r1, [r4, #0x17c]
	ldr r1, [r5, #0x20]
	bic r1, r1, #0x20
	str r1, [r5, #0x20]
	ldr r1, [r5, #0x18]
	bic r1, r1, #0x10
	bic r1, r1, #2
	str r1, [r5, #0x18]
_02185670:
	ldr r2, [r4, #0x164]
	ldr r1, [r2, #0x34]
	tst r1, #2
	ldreq r1, [r2, #0x28]
	cmpeq r1, #0
	beq _021856F4
	ldr r1, [r4, #0x140]
	cmp r1, #0
	ldreq r1, [r4, #0x128]
	cmpeq r1, r0
	bne _021856AC
	ldr r1, [r4, #0x13c]
	ldr r0, _02185758 // =_0218C8C8
	ldrb r0, [r0, r1]
	str r0, [r4, #0x140]
_021856AC:
	ldr r0, [r4, #0x140]
	cmp r0, #0
	beq _021856F4
	add r0, r4, #0x17c
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x140]
	subs r0, r0, #1
	str r0, [r4, #0x140]
	beq _021856E8
	mov r0, #0
	str r0, [r4, #0x17c]
	str r0, [r4, #0x180]
	str r0, [r4, #0x184]
_021856E8:
	ldr r1, [r4, #0x140]
	mov r0, r5
	bl SailHoverEnemyHover__Func_2187134
_021856F4:
	add r0, r4, #0x100
	ldrh r2, [r0, #0x6e]
	ldr r1, [r5, #0x28]
	mov r0, r5
	add r1, r2, r1
	strh r1, [r5, #0x32]
	bl SailObject__SetupAnimator3D
	mov r0, r5
	bl SailObject__Func_2166D18
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x140]
	cmp r0, #0
	bne _02185740
	ldr r0, [r4, #0x128]
	add sp, sp, #0xc
	add r0, r0, #1
	str r0, [r4, #0x128]
	ldmia sp!, {r4, r5, pc}
_02185740:
	add r0, sp, #0
	add r3, r4, #0x17c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02185758: .word _0218C8C8
	arm_func_end SailHoverBobBird__State_21855F0

	arm_func_start SailHoverBobBird__SetupObject
SailHoverBobBird__SetupObject: // 0x0218575C
	ldr r3, [r0, #0x124]
	mov r1, #0
	str r1, [r0, #0x28]
	str r1, [r0, #0x2c]
	sub r2, r1, #0x1000
	ldr r1, _02185798 // =SailHoverBobBird__State_218579C
	str r2, [r3, #0x184]
	str r1, [r0, #0xf4]
	ldr r2, [r0, #0x24]
	add r1, r3, #0x100
	orr r2, r2, #1
	str r2, [r0, #0x24]
	ldrh r1, [r1, #0x6e]
	strh r1, [r0, #0x32]
	bx lr
	.align 2, 0
_02185798: .word SailHoverBobBird__State_218579C
	arm_func_end SailHoverBobBird__SetupObject

	arm_func_start SailHoverBobBird__State_218579C
SailHoverBobBird__State_218579C: // 0x0218579C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r0, [r5, #0x28]
	add r0, r0, #1
	str r0, [r5, #0x28]
	cmp r0, #0x1f
	bls _021857D0
	ldr r0, [r4, #0x184]
	mov r1, #0xa0
	bl ObjSpdDownSet
	str r0, [r4, #0x184]
_021857D0:
	mov r0, r5
	bl SailObject__SetupAnimator3D
	mov r0, r5
	bl SailObject__Func_2166D18
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x184]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl SailHoverBobBird__Func_2185800
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailHoverBobBird__State_218579C

	arm_func_start SailHoverBobBird__Func_2185800
SailHoverBobBird__Func_2185800: // 0x02185800
	ldr r3, [r0, #0x124]
	mov r1, #0x28
	str r1, [r0, #0x28]
	mov r2, #0
	str r2, [r3, #0x17c]
	str r2, [r3, #0x180]
	ldr r1, _02185828 // =SailHoverBobBird__State_218582C
	str r2, [r3, #0x184]
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_02185828: .word SailHoverBobBird__State_218582C
	arm_func_end SailHoverBobBird__Func_2185800

	arm_func_start SailHoverBobBird__State_218582C
SailHoverBobBird__State_218582C: // 0x0218582C
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	bl SailManager__GetWork
	mov r6, r0
	mov r0, r5
	bl SailObject__SetupAnimator3D
	mov r0, r5
	bl SailObject__Func_2166D18
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r6, #0x24]
	tst r0, #1
	beq _02185884
	ldr r1, [r5, #0x18]
	mov r0, #0x1000
	bic r1, r1, #0x10
	str r1, [r5, #0x18]
	rsb r0, r0, #0
	str r0, [r4, #0x184]
	ldmia sp!, {r4, r5, r6, pc}
_02185884:
	ldr r0, [r5, #0x28]
	cmp r0, #0
	bne _02185944
	ldr r2, _02185950 // =_mt_math_rand
	ldr r0, _02185954 // =0x00196225
	ldr r3, [r2]
	ldr r1, _02185958 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #7
	str r1, [r2]
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _021858E4
_021858C4: // jump table
	b _021858E4 // case 0
	b _021858F0 // case 1
	b _021858FC // case 2
	b _02185908 // case 3
	b _02185914 // case 4
	b _02185920 // case 5
	b _0218592C // case 6
	b _02185938 // case 7
_021858E4:
	mov r0, r5
	bl SailHoverBobBird__Func_2185B58
	ldmia sp!, {r4, r5, r6, pc}
_021858F0:
	mov r0, r5
	bl SailHoverBobBird__Func_2185D08
	ldmia sp!, {r4, r5, r6, pc}
_021858FC:
	mov r0, r5
	bl SailHoverBobBird__Func_2185F48
	ldmia sp!, {r4, r5, r6, pc}
_02185908:
	mov r0, r5
	bl SailHoverBobBird__Func_21861EC
	ldmia sp!, {r4, r5, r6, pc}
_02185914:
	mov r0, r5
	bl SailHoverBobBird__Func_2186290
	ldmia sp!, {r4, r5, r6, pc}
_02185920:
	mov r0, r5
	bl SailHoverBobBird__Func_21863EC
	ldmia sp!, {r4, r5, r6, pc}
_0218592C:
	mov r0, r5
	bl SailHoverBobBird__Func_21866A4
	ldmia sp!, {r4, r5, r6, pc}
_02185938:
	mov r0, r5
	bl SailHoverBobBird__Func_2186840
	ldmia sp!, {r4, r5, r6, pc}
_02185944:
	sub r0, r0, #1
	str r0, [r5, #0x28]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02185950: .word _mt_math_rand
_02185954: .word 0x00196225
_02185958: .word 0x3C6EF35F
	arm_func_end SailHoverBobBird__State_218582C

	arm_func_start SailHoverBobBird__Func_218595C
SailHoverBobBird__Func_218595C: // 0x0218595C
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r3, [r0, #0x98]
	mov r0, #0
	str r0, [r4, #0x17c]
	str r0, [r4, #0x180]
	str r0, [r4, #0x184]
	add r0, r4, #0x170
	ldr ip, _02185AB8 // =_mt_math_rand
	add r6, r4, #0x10
	ldmia r0, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	ldr r0, _02185ABC // =0x00196225
	ldr r6, [ip]
	ldr r2, _02185AC0 // =0x3C6EF35F
	ldr r1, _02185AC4 // =0x000007FE
	mla lr, r6, r0, r2
	mla r6, lr, r0, r2
	mov r2, r6, lsr #0x10
	mov r0, lr, lsr #0x10
	mov r2, r2, lsl #0x10
	mov lr, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	ldr r2, _02185AC8 // =0x00002BFF
	and r0, r1, r0, lsr #16
	str r6, [ip]
	sub r6, r2, r0
	tst lr, #1
	rsbne r6, r6, #0
	cmp r6, #0
	bge _021859F8
	ldr r1, [r4, #0x10]
	mov r0, #0x3c00
	add r1, r1, r6
	rsb r0, r0, #0
	cmp r1, r0
	rsblt r6, r6, #0
_021859F8:
	cmp r6, #0
	ldrgt r0, [r4, #0x10]
	ldr r2, _02185AB8 // =_mt_math_rand
	addgt r0, r0, r6
	cmpgt r0, #0x3c00
	ldr r0, [r4, #0x10]
	rsbgt r6, r6, #0
	add r0, r0, r6
	str r0, [r4, #0x10]
	ldr ip, [r2]
	ldr r0, _02185ABC // =0x00196225
	ldr r1, _02185AC0 // =0x3C6EF35F
	mla r1, ip, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	ands r0, r0, #3
	beq _02185A50
	cmp r0, #1
	beq _02185A80
	b _02185AA4
_02185A50:
	mov r0, #0x200
	rsb r0, r0, #0
	str r0, [r4, #0x184]
	ldr r0, [r3, #0x44]
	ldr r1, [r4, #0x178]
	add r0, r0, #0x1d000
	cmp r1, r0
	bgt _02185AA4
	ldr r0, [r4, #0x184]
	rsb r0, r0, #0
	str r0, [r4, #0x184]
	b _02185AA4
_02185A80:
	mov r0, #0x200
	str r0, [r4, #0x184]
	ldr r0, [r3, #0x44]
	ldr r1, [r4, #0x178]
	add r0, r0, #0x1f000
	cmp r1, r0
	ldrge r0, [r4, #0x184]
	rsbge r0, r0, #0
	strge r0, [r4, #0x184]
_02185AA4:
	mov r1, #0
	ldr r0, _02185ACC // =SailHoverBobBird__State_2185AD0
	str r1, [r4, #0x128]
	str r0, [r5, #0xf4]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02185AB8: .word _mt_math_rand
_02185ABC: .word 0x00196225
_02185AC0: .word 0x3C6EF35F
_02185AC4: .word 0x000007FE
_02185AC8: .word 0x00002BFF
_02185ACC: .word SailHoverBobBird__State_2185AD0
	arm_func_end SailHoverBobBird__Func_218595C

	arm_func_start SailHoverBobBird__State_2185AD0
SailHoverBobBird__State_2185AD0: // 0x02185AD0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	mov r0, #0xa0
	str r0, [sp]
	ldr r0, [r4, #0x170]
	ldr r1, [r4, #0x10]
	mov r2, #3
	mov r3, #0
	bl ObjShiftSet
	ldr r1, [r4, #0x170]
	subs r0, r0, r1
	str r0, [r4, #0x17c]
	moveq r0, #0
	streq r0, [r4, #0x184]
	ldr r1, [r4, #0x17c]
	mov r0, r5
	rsb r1, r1, #0
	mov r1, r1, lsl #2
	strh r1, [r5, #0x34]
	bl SailObject__SetupAnimator3D
	mov r0, r5
	bl SailObject__Func_2166D18
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x17c]
	cmp r0, #0
	ldreq r0, [r4, #0x184]
	cmpeq r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl SailHoverBobBird__Func_2185800
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailHoverBobBird__State_2185AD0

	arm_func_start SailHoverBobBird__Func_2185B58
SailHoverBobBird__Func_2185B58: // 0x02185B58
	stmdb sp!, {r3, lr}
	ldr r3, _02185BAC // =_mt_math_rand
	ldr r1, _02185BB0 // =0x00196225
	ldr ip, [r3]
	ldr r2, _02185BB4 // =0x3C6EF35F
	ldr lr, [r0, #0x124]
	mla r2, ip, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0x1f
	str r2, [r3]
	add r1, r1, #0x3c
	str r1, [r0, #0x28]
	mov r2, #0
	str r2, [lr, #0x17c]
	str r2, [lr, #0x180]
	ldr r1, _02185BB8 // =SailHoverBobBird__State_2185C2C
	str r2, [lr, #0x184]
	str r1, [r0, #0xf4]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02185BAC: .word _mt_math_rand
_02185BB0: .word 0x00196225
_02185BB4: .word 0x3C6EF35F
_02185BB8: .word SailHoverBobBird__State_2185C2C
	arm_func_end SailHoverBobBird__Func_2185B58

	arm_func_start SailHoverBobBird__Func_2185BBC
SailHoverBobBird__Func_2185BBC: // 0x02185BBC
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x18
	mov r7, r0
	ldr r4, [r7, #0x124]
	mov r6, r1
	add r1, sp, #0xc
	mov r5, r2
	bl SailObject__Func_2165A9C
	ldr r0, [r4, #0x15c]
	add r1, sp, #0
	bl SailObject__Func_2165A9C
	add r1, sp, #0xc
	add r0, r7, #0x44
	mov r2, r1
	bl VEC_Subtract
	ldr r0, [r4, #0x15c]
	add r1, sp, #0
	add r0, r0, #0x44
	mov r2, r1
	bl VEC_Subtract
	add r0, sp, #0xc
	ldmia r0, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	add r3, sp, #0
	ldmia r3, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SailHoverBobBird__Func_2185BBC

	arm_func_start SailHoverBobBird__State_2185C2C
SailHoverBobBird__State_2185C2C: // 0x02185C2C
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x20
	mov r4, r0
	bl SailManager__GetWork
	ldr r0, [r4, #0x28]
	tst r0, #7
	bne _02185CC8
	mov r3, #0x6000
	add r1, sp, #0x14
	add r2, sp, #8
	mov r0, r4
	str r3, [r4, #4]
	bl SailHoverBobBird__Func_2185BBC
	mov ip, #0
	str ip, [sp]
	add r1, sp, #0x14
	add r2, sp, #8
	mov r0, r4
	mov r3, #0xe00
	str ip, [sp, #4]
	bl SailHoverShell2__Create
	mov r3, #0x1a0
	str r3, [sp]
	mov ip, #0
	add r1, sp, #0x14
	add r2, sp, #8
	mov r0, r4
	mov r3, #0xdc0
	str ip, [sp, #4]
	bl SailHoverShell2__Create
	ldr r1, _02185D04 // =0x0000FE60
	mov r0, #0
	str r1, [sp]
	str r0, [sp, #4]
	add r1, sp, #0x14
	mov r0, r4
	add r2, sp, #8
	mov r3, #0xdc0
	bl SailHoverShell2__Create
_02185CC8:
	mov r0, r4
	bl SailObject__SetupAnimator3D
	mov r0, r4
	bl SailObject__Func_2166D18
	mov r0, r4
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x28]
	subs r0, r0, #1
	addne sp, sp, #0x20
	str r0, [r4, #0x28]
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl SailHoverBobBird__Func_218595C
	add sp, sp, #0x20
	ldmia sp!, {r4, pc}
	.align 2, 0
_02185D04: .word 0x0000FE60
	arm_func_end SailHoverBobBird__State_2185C2C

	arm_func_start SailHoverBobBird__Func_2185D08
SailHoverBobBird__Func_2185D08: // 0x02185D08
	stmdb sp!, {r4, lr}
	ldr r2, [r0, #0x124]
	mov r1, #0x80
	str r1, [r0, #0x28]
	mov r1, #0
	str r1, [r2, #0x17c]
	str r1, [r2, #0x180]
	ldr r3, _02185D7C // =SailHoverBobBird__State_2185D8C
	str r1, [r2, #0x184]
	str r3, [r0, #0xf4]
	ldr ip, _02185D80 // =_mt_math_rand
	str r1, [r2, #0x128]
	ldr r4, [ip]
	ldr r0, _02185D84 // =0x00196225
	ldr r3, _02185D88 // =0x3C6EF35F
	mov lr, #1
	mla r3, r4, r0, r3
	mov r0, r3, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r3, [ip]
	and r0, r0, #1
	str r0, [r2, #0x138]
	str lr, [r2, #0x13c]
	ldr r3, [r2, #0x11c]
	ldr r0, [r2, #0x120]
	cmp r3, r0, asr #1
	strlt r1, [r2, #0x13c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02185D7C: .word SailHoverBobBird__State_2185D8C
_02185D80: .word _mt_math_rand
_02185D84: .word 0x00196225
_02185D88: .word 0x3C6EF35F
	arm_func_end SailHoverBobBird__Func_2185D08

	arm_func_start SailHoverBobBird__State_2185D8C
SailHoverBobBird__State_2185D8C: // 0x02185D8C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x38
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r1, [r6, #0x28]
	ldr r5, [r0, #0x98]
	tst r1, #3
	bne _02185F0C
	mov r0, #0
	add r3, sp, #8
	str r0, [sp, #0x20]
	str r0, [sp, #0x24]
	str r0, [sp, #0x28]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	str r0, [sp, #0x1c]
	add r0, r4, #0x170
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r2, #0x6000
	add r1, sp, #0x2c
	mov r0, r6
	str r2, [r6, #4]
	bl SailObject__Func_2165A9C
	add r1, sp, #0x2c
	add r0, r6, #0x44
	mov r2, r1
	bl VEC_Subtract
	ldr r0, [r4, #0x15c]
	add r1, sp, #0x14
	bl SailObject__Func_2165A9C
	ldr r0, [r5, #0x44]
	str r0, [r4, #0x178]
	ldr r0, [r4, #0x138]
	cmp r0, #0
	ldr r0, [r4, #0x128]
	moveq r0, r0, lsl #0x1d
	moveq r0, r0, lsr #0x11
	rsbeq r0, r0, #0x3800
	beq _02185E3C
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x11
	sub r0, r0, #0x3800
_02185E3C:
	str r0, [r4, #0x170]
	add r1, sp, #0x20
	mov r0, r6
	bl SailObject__Func_2166C04
	add r0, sp, #0x20
	add r1, sp, #0x14
	mov r2, r0
	bl VEC_Subtract
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	add r1, sp, #0x2c
	add r2, sp, #0x20
	mov r0, r6
	mov r3, #0x1300
	bl SailHoverShell2__Create
	ldr r0, [r4, #0x13c]
	cmp r0, #0
	bne _02185EF0
	ldr r0, [r4, #0x138]
	cmp r0, #0
	ldr r0, [r4, #0x128]
	movne r0, r0, lsl #0x1d
	movne r0, r0, lsr #0x11
	rsbne r0, r0, #0x3800
	bne _02185EB0
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x11
	sub r0, r0, #0x3800
_02185EB0:
	str r0, [r4, #0x170]
	add r1, sp, #0x20
	mov r0, r6
	bl SailObject__Func_2166C04
	add r0, sp, #0x20
	add r1, sp, #0x14
	mov r2, r0
	bl VEC_Subtract
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	add r1, sp, #0x2c
	add r2, sp, #0x20
	mov r0, r6
	mov r3, #0x1300
	bl SailHoverShell2__Create
_02185EF0:
	add r0, sp, #8
	add r3, r4, #0x170
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x128]
	add r0, r0, #1
	str r0, [r4, #0x128]
_02185F0C:
	mov r0, r6
	bl SailObject__SetupAnimator3D
	mov r0, r6
	bl SailObject__Func_2166D18
	mov r0, r6
	bl SailObject__Func_2166A2C
	ldr r0, [r6, #0x28]
	subs r0, r0, #1
	addne sp, sp, #0x38
	str r0, [r6, #0x28]
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r6
	bl SailHoverBobBird__Func_218595C
	add sp, sp, #0x38
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SailHoverBobBird__State_2185D8C

	arm_func_start SailHoverBobBird__Func_2185F48
SailHoverBobBird__Func_2185F48: // 0x02185F48
	ldr r3, [r0, #0x124]
	mov r1, #0x10
	str r1, [r0, #0x28]
	mov r2, #0
	str r2, [r3, #0x17c]
	str r2, [r3, #0x180]
	ldr r1, _02185F9C // =SailHoverBobBird__State_2185FA0
	str r2, [r3, #0x184]
	str r1, [r0, #0xf4]
	str r2, [r3, #0x128]
	str r2, [r3, #0x138]
	str r2, [r3, #0x13c]
	ldr r2, [r3, #0x11c]
	ldr r1, [r3, #0x120]
	cmp r2, r1, asr #1
	bxge lr
	mov r1, #2
	str r1, [r3, #0x138]
	mov r1, #0x28
	str r1, [r0, #0x28]
	bx lr
	.align 2, 0
_02185F9C: .word SailHoverBobBird__State_2185FA0
	arm_func_end SailHoverBobBird__Func_2185F48

	arm_func_start SailHoverBobBird__State_2185FA0
SailHoverBobBird__State_2185FA0: // 0x02185FA0
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x20
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r0, [r4, #0x138]
	cmp r0, #0
	beq _02186030
	ldr r0, [r5, #0x28]
	cmp r0, #0x1e
	bne _02186010
	mov r0, #0
	str r0, [r4, #0x128]
	mov r0, #0x1200
	str r0, [r4, #0x13c]
	ldr r2, _021861E0 // =_mt_math_rand
	ldr r0, _021861E4 // =0x00196225
	ldr r3, [r2]
	ldr r1, _021861E8 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	ldrne r0, [r4, #0x13c]
	rsbne r0, r0, #0
	strne r0, [r4, #0x13c]
_02186010:
	ldr r0, [r5, #0x28]
	cmp r0, #0x12
	bne _02186030
	mov r0, #0
	str r0, [r4, #0x128]
	ldr r0, [r4, #0x13c]
	rsb r0, r0, #0
	str r0, [r4, #0x13c]
_02186030:
	ldr r0, [r5, #0x28]
	tst r0, #3
	bne _021861A4
	ldr r0, [r4, #0x128]
	cmp r0, #3
	bge _021861A4
	mov r3, #0x6000
	add r1, sp, #0x14
	add r2, sp, #8
	mov r0, r5
	str r3, [r5, #4]
	bl SailHoverBobBird__Func_2185BBC
	ldr r0, [r4, #0x128]
	cmp r0, #0
	beq _02186080
	cmp r0, #1
	beq _021860FC
	cmp r0, #2
	beq _02186168
	b _02186198
_02186080:
	ldr r1, [sp, #0x14]
	ldr r0, [r4, #0x13c]
	add r1, r1, #0x1000
	add r0, r1, r0
	str r0, [sp, #8]
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	add r1, sp, #0x14
	add r2, sp, #8
	mov r0, r5
	mov r3, #0x1200
	bl SailHoverShell2__Create
	ldr r1, [sp, #0x14]
	ldr r0, [r4, #0x13c]
	sub r1, r1, #0x1000
	add r0, r1, r0
	str r0, [sp, #8]
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	add r1, sp, #0x14
	add r2, sp, #8
	mov r0, r5
	mov r3, #0x1200
	bl SailHoverShell2__Create
	ldr r0, [r5, #0x138]
	add r2, r5, #0x44
	mov r1, #0x2a
	bl SailAudio__PlaySpatialSequence
	b _02186198
_021860FC:
	ldr r1, [sp, #0x14]
	ldr r0, [r4, #0x13c]
	add r1, r1, #0x800
	add r0, r1, r0
	str r0, [sp, #8]
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	add r1, sp, #0x14
	add r2, sp, #8
	mov r0, r5
	mov r3, #0x1600
	bl SailHoverShell2__Create
	ldr r1, [sp, #0x14]
	ldr r0, [r4, #0x13c]
	sub r1, r1, #0x800
	add r0, r1, r0
	str r0, [sp, #8]
	mov ip, #0
	str ip, [sp]
	add r1, sp, #0x14
	add r2, sp, #8
	mov r0, r5
	mov r3, #0x1600
	str ip, [sp, #4]
	bl SailHoverShell2__Create
	b _02186198
_02186168:
	ldr r1, [sp, #0x14]
	ldr r0, [r4, #0x13c]
	mov ip, #0
	add r0, r1, r0
	str r0, [sp, #8]
	str ip, [sp]
	add r1, sp, #0x14
	add r2, sp, #8
	mov r0, r5
	mov r3, #0x1b00
	str ip, [sp, #4]
	bl SailHoverShell2__Create
_02186198:
	ldr r0, [r4, #0x128]
	add r0, r0, #1
	str r0, [r4, #0x128]
_021861A4:
	mov r0, r5
	bl SailObject__SetupAnimator3D
	mov r0, r5
	bl SailObject__Func_2166D18
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r5, #0x28]
	subs r0, r0, #1
	addne sp, sp, #0x20
	str r0, [r5, #0x28]
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl SailHoverBobBird__Func_218595C
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021861E0: .word _mt_math_rand
_021861E4: .word 0x00196225
_021861E8: .word 0x3C6EF35F
	arm_func_end SailHoverBobBird__State_2185FA0

	arm_func_start SailHoverBobBird__Func_21861EC
SailHoverBobBird__Func_21861EC: // 0x021861EC
	ldr r3, [r0, #0x124]
	mov r1, #0x10
	str r1, [r0, #0x28]
	mov r2, #0
	str r2, [r3, #0x17c]
	str r2, [r3, #0x180]
	ldr r1, _0218622C // =SailHoverBobBird__State_2186230
	str r2, [r3, #0x184]
	str r1, [r0, #0xf4]
	str r2, [r3, #0x128]
	ldr r2, [r3, #0x11c]
	ldr r1, [r3, #0x120]
	cmp r2, r1, asr #1
	movlt r1, #0x20
	strlt r1, [r0, #0x28]
	bx lr
	.align 2, 0
_0218622C: .word SailHoverBobBird__State_2186230
	arm_func_end SailHoverBobBird__Func_21861EC

	arm_func_start SailHoverBobBird__State_2186230
SailHoverBobBird__State_2186230: // 0x02186230
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r0, [r4, #0x28]
	tst r0, #3
	bne _0218625C
	mov r2, #0x6000
	mov r0, r4
	mov r1, #0
	str r2, [r4, #4]
	bl SpawnSailHoverTorpedo1
_0218625C:
	mov r0, r4
	bl SailObject__SetupAnimator3D
	mov r0, r4
	bl SailObject__Func_2166D18
	mov r0, r4
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x28]
	subs r0, r0, #1
	str r0, [r4, #0x28]
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl SailHoverBobBird__Func_218595C
	ldmia sp!, {r4, pc}
	arm_func_end SailHoverBobBird__State_2186230

	arm_func_start SailHoverBobBird__Func_2186290
SailHoverBobBird__Func_2186290: // 0x02186290
	ldr r3, [r0, #0x124]
	mov r1, #0x10
	str r1, [r0, #0x28]
	mov r2, #0
	str r2, [r3, #0x17c]
	str r2, [r3, #0x180]
	ldr r1, _021862E4 // =SailHoverBobBird__State_21862E8
	str r2, [r3, #0x184]
	str r1, [r0, #0xf4]
	str r2, [r3, #0x128]
	str r2, [r3, #0x138]
	str r2, [r3, #0x13c]
	ldr r2, [r3, #0x11c]
	ldr r1, [r3, #0x120]
	cmp r2, r1, asr #1
	bxge lr
	mov r1, #1
	str r1, [r3, #0x138]
	mov r1, #0x20
	str r1, [r0, #0x28]
	bx lr
	.align 2, 0
_021862E4: .word SailHoverBobBird__State_21862E8
	arm_func_end SailHoverBobBird__Func_2186290

	arm_func_start SailHoverBobBird__State_21862E8
SailHoverBobBird__State_21862E8: // 0x021862E8
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r5, [r4, #0x124]
	bl SailManager__GetWork
	ldr r0, [r4, #0x28]
	cmp r0, #0x10
	cmpne r0, #0x20
	bne _021863B8
	mov r0, #0x6000
	str r0, [r4, #4]
	ldr r0, [r5, #0x138]
	mov r5, #0
	cmp r0, #0
	beq _0218638C
	ldr r0, [r4, #0x28]
	cmp r0, #0x20
	bne _0218635C
_0218632C:
	mov r0, r5, lsl #0xe
	add r0, r0, #1
	mov r1, r0, lsl #0x10
	mov r0, r4
	mov r1, r1, lsr #0x10
	bl SpawnSailHoverTorpedo1
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #4
	blo _0218632C
	b _021863B8
_0218635C:
	mov r0, r5, lsl #0xe
	add r0, r0, #0x2000
	mov r1, r0, lsl #0x10
	mov r0, r4
	mov r1, r1, lsr #0x10
	bl SpawnSailHoverTorpedo1
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #4
	blo _0218635C
	b _021863B8
_0218638C:
	mov r0, r5, lsl #0xd
	add r0, r0, #1
	mov r1, r0, lsl #0x10
	mov r0, r4
	mov r1, r1, lsr #0x10
	bl SpawnSailHoverTorpedo1
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #8
	blo _0218638C
_021863B8:
	mov r0, r4
	bl SailObject__SetupAnimator3D
	mov r0, r4
	bl SailObject__Func_2166D18
	mov r0, r4
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x28]
	subs r0, r0, #1
	str r0, [r4, #0x28]
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl SailHoverBobBird__Func_218595C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailHoverBobBird__State_21862E8

	arm_func_start SailHoverBobBird__Func_21863EC
SailHoverBobBird__Func_21863EC: // 0x021863EC
	ldr ip, [r0, #0x124]
	mov r1, #0x30
	str r1, [r0, #0x28]
	mov r2, #0
	str r2, [ip, #0x17c]
	str r2, [ip, #0x180]
	ldr r1, _02186434 // =SailHoverBobBird__State_2186438
	str r2, [ip, #0x184]
	str r1, [r0, #0xf4]
	str r2, [ip, #0x128]
	ldr r3, [ip, #0x120]
	ldr r2, [ip, #0x11c]
	mov r1, r3, asr #2
	add r1, r1, r3, asr #1
	cmp r2, r1
	movlt r1, #0x80
	strlt r1, [r0, #0x28]
	bx lr
	.align 2, 0
_02186434: .word SailHoverBobBird__State_2186438
	arm_func_end SailHoverBobBird__Func_21863EC

	arm_func_start SailHoverBobBird__State_2186438
SailHoverBobBird__State_2186438: // 0x02186438
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x38
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r1, [r6, #0x28]
	ldr r5, [r0, #0x98]
	tst r1, #0xf
	bne _02186658
	mov r0, #0
	add r3, sp, #8
	str r0, [sp, #0x20]
	str r0, [sp, #0x24]
	str r0, [sp, #0x28]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	str r0, [sp, #0x1c]
	add r0, r4, #0x170
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r2, #0x6000
	add r1, sp, #0x2c
	mov r0, r6
	str r2, [r6, #4]
	bl SailObject__Func_2165A9C
	add r1, sp, #0x2c
	add r0, r6, #0x44
	mov r2, r1
	bl VEC_Subtract
	ldr r0, [r4, #0x15c]
	add r1, sp, #0x14
	bl SailObject__Func_2165A9C
	ldr r1, [r5, #0x44]
	mov r0, #0
	str r1, [r4, #0x178]
	str r0, [r4, #0x170]
	ldr r0, [r4, #0x128]
	add r1, sp, #0x20
	tst r0, #1
	ldrne r0, [r4, #0x174]
	addne r0, r0, #0x1000
	strne r0, [r4, #0x174]
	mov r0, r6
	bl SailObject__Func_2166C04
	add r0, sp, #0x20
	add r1, sp, #0x14
	mov r2, r0
	bl VEC_Subtract
	ldr r0, [r4, #0x128]
	add r1, sp, #0x2c
	tst r0, #1
	add r2, sp, #0x20
	beq _02186594
	mov r3, #0x120
	str r3, [sp]
	mov r5, #2
	mov r0, r6
	mov r3, #0xb00
	str r5, [sp, #4]
	bl SailHoverShell2__Create
	ldr r3, _02186694 // =0x0000FEE0
	add r1, sp, #0x2c
	str r3, [sp]
	add r2, sp, #0x20
	mov r0, r6
	mov r3, #0xb00
	str r5, [sp, #4]
	bl SailHoverShell2__Create
	mov r3, #0x360
	str r3, [sp]
	mov r3, r5
	str r3, [sp, #4]
	add r1, sp, #0x2c
	add r2, sp, #0x20
	mov r0, r6
	mov r3, #0xae0
	bl SailHoverShell2__Create
	ldr r1, _02186698 // =0x0000FCA0
	mov r0, r5
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, r6
	add r1, sp, #0x2c
	add r2, sp, #0x20
	mov r3, #0xae0
	bl SailHoverShell2__Create
	b _0218663C
_02186594:
	mov r3, #0
	str r3, [sp]
	mov r5, #2
	mov r0, r6
	mov r3, #0xb00
	str r5, [sp, #4]
	bl SailHoverShell2__Create
	mov r3, #0x240
	str r3, [sp]
	add r1, sp, #0x2c
	add r2, sp, #0x20
	mov r0, r6
	mov r3, #0xae0
	str r5, [sp, #4]
	bl SailHoverShell2__Create
	ldr r3, _0218669C // =0x0000FDC0
	add r1, sp, #0x2c
	str r3, [sp]
	mov r3, r5
	str r3, [sp, #4]
	add r2, sp, #0x20
	mov r0, r6
	mov r3, #0xae0
	bl SailHoverShell2__Create
	mov r0, #0x480
	str r0, [sp]
	mov r0, r5
	str r0, [sp, #4]
	mov r0, r6
	add r1, sp, #0x2c
	add r2, sp, #0x20
	mov r3, #0xac0
	bl SailHoverShell2__Create
	ldr r1, _021866A0 // =0x0000FB80
	mov r0, r5
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, r6
	add r1, sp, #0x2c
	add r2, sp, #0x20
	mov r3, #0xac0
	bl SailHoverShell2__Create
_0218663C:
	add r0, sp, #8
	add r3, r4, #0x170
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x128]
	add r0, r0, #1
	str r0, [r4, #0x128]
_02186658:
	mov r0, r6
	bl SailObject__SetupAnimator3D
	mov r0, r6
	bl SailObject__Func_2166D18
	mov r0, r6
	bl SailObject__Func_2166A2C
	ldr r0, [r6, #0x28]
	subs r0, r0, #1
	addne sp, sp, #0x38
	str r0, [r6, #0x28]
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r6
	bl SailHoverBobBird__Func_218595C
	add sp, sp, #0x38
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02186694: .word 0x0000FEE0
_02186698: .word 0x0000FCA0
_0218669C: .word 0x0000FDC0
_021866A0: .word 0x0000FB80
	arm_func_end SailHoverBobBird__State_2186438

	arm_func_start SailHoverBobBird__Func_21866A4
SailHoverBobBird__Func_21866A4: // 0x021866A4
	ldr r3, [r0, #0x124]
	mov r1, #0x40
	str r1, [r0, #0x28]
	mov r2, #0
	str r2, [r3, #0x17c]
	str r2, [r3, #0x180]
	ldr r1, _021866F4 // =SailHoverBobBird__State_21866F8
	str r2, [r3, #0x184]
	str r1, [r0, #0xf4]
	str r2, [r3, #0x128]
	str r2, [r3, #0x138]
	ldr r2, [r3, #0x11c]
	ldr r1, [r3, #0x120]
	cmp r2, r1, asr #1
	bxge lr
	mov r1, #0x60
	str r1, [r0, #0x28]
	mov r0, #1
	str r0, [r3, #0x138]
	bx lr
	.align 2, 0
_021866F4: .word SailHoverBobBird__State_21866F8
	arm_func_end SailHoverBobBird__Func_21866A4

	arm_func_start SailHoverBobBird__State_21866F8
SailHoverBobBird__State_21866F8: // 0x021866F8
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x20
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r0, [r5, #0x28]
	tst r0, #0xf
	bne _021867FC
	mov r3, #0x6000
	add r1, sp, #0x14
	add r2, sp, #8
	mov r0, r5
	str r3, [r5, #4]
	bl SailHoverBobBird__Func_2185BBC
	mov r3, #0
	str r3, [sp]
	mov ip, #3
	add r1, sp, #0x14
	add r2, sp, #8
	mov r0, r5
	mov r3, #0x3b80
	str ip, [sp, #4]
	bl SailHoverShell2__Create
	mov r3, #0xc0
	str r3, [sp]
	mov r3, #3
	str r3, [sp, #4]
	add r1, sp, #0x14
	add r2, sp, #8
	mov r0, r5
	mov r3, #0x3b00
	bl SailHoverShell2__Create
	ldr r1, _02186838 // =0x0000FF40
	mov r0, #3
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, r5
	add r1, sp, #0x14
	add r2, sp, #8
	mov r3, #0x3b00
	bl SailHoverShell2__Create
	ldr r0, [r4, #0x138]
	cmp r0, #0
	beq _021867EC
	mov r3, #0x180
	str r3, [sp]
	mov r4, #3
	add r1, sp, #0x14
	add r2, sp, #8
	mov r0, r5
	mov r3, #0x3a00
	str r4, [sp, #4]
	bl SailHoverShell2__Create
	ldr r3, _0218683C // =0x0000FE80
	add r1, sp, #0x14
	str r3, [sp]
	add r2, sp, #8
	mov r0, r5
	mov r3, #0x3a00
	str r4, [sp, #4]
	bl SailHoverShell2__Create
_021867EC:
	ldr r0, [r5, #0x138]
	add r2, r5, #0x44
	mov r1, #0x2a
	bl SailAudio__PlaySpatialSequence
_021867FC:
	mov r0, r5
	bl SailObject__SetupAnimator3D
	mov r0, r5
	bl SailObject__Func_2166D18
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r5, #0x28]
	subs r0, r0, #1
	addne sp, sp, #0x20
	str r0, [r5, #0x28]
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl SailHoverBobBird__Func_218595C
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02186838: .word 0x0000FF40
_0218683C: .word 0x0000FE80
	arm_func_end SailHoverBobBird__State_21866F8

	arm_func_start SailHoverBobBird__Func_2186840
SailHoverBobBird__Func_2186840: // 0x02186840
	stmdb sp!, {r3, lr}
	ldr ip, [r0, #0x124]
	mov r2, #0
	str r2, [r0, #0x28]
	str r2, [ip, #0x17c]
	str r2, [ip, #0x180]
	ldr r1, _021868A8 // =SailHoverBobBird__State_21868AC
	str r2, [ip, #0x184]
	str r1, [r0, #0xf4]
	str r2, [ip, #0x128]
	str r2, [ip, #0x138]
	str r2, [ip, #0x13c]
	ldr r3, [ip, #0x120]
	ldr r2, [ip, #0x11c]
	mov r1, r3, asr #2
	add r1, r1, r3, asr #1
	cmp r2, r1
	movlt r1, #1
	strlt r1, [ip, #0x138]
	ldr r2, [r0, #0x18]
	mov r1, #0
	orr r2, r2, #0x10
	str r2, [r0, #0x18]
	bl StageTask__GetCollider
	bl ObjRect__HitAgain
	ldmia sp!, {r3, pc}
	.align 2, 0
_021868A8: .word SailHoverBobBird__State_21868AC
	arm_func_end SailHoverBobBird__Func_2186840

	arm_func_start SailHoverBobBird__State_21868AC
SailHoverBobBird__State_21868AC: // 0x021868AC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x38
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r1, [r4, #0x128]
	ldr r5, [r0, #0x98]
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _02186B38
_021868D4: // jump table
	b _021868E4 // case 0
	b _0218695C // case 1
	b _021869A8 // case 2
	b _02186B20 // case 3
_021868E4:
	ldr r0, [r6, #0x28]
	cmp r0, #0x10
	bhs _02186918
	ldr r0, [r4, #0x184]
	mov r1, #0x200
	mov r2, #0x1800
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
	ldr r0, [r6, #0x28]
	cmp r0, #0xf
	moveq r0, #0x8000
	streq r0, [r6, #4]
	b _0218694C
_02186918:
	cmp r0, #0x18
	bhs _02186934
	ldr r0, [r4, #0x184]
	mov r1, #0x300
	bl ObjSpdDownSet
	str r0, [r4, #0x184]
	b _0218694C
_02186934:
	add r0, r1, #1
	str r0, [r4, #0x128]
	ldr r0, [r6, #0x138]
	add r2, r6, #0x44
	mov r1, #0x6d
	bl SailAudio__PlaySpatialSequence
_0218694C:
	ldr r0, [r6, #0x28]
	add r0, r0, #1
	str r0, [r6, #0x28]
	b _02186B38
_0218695C:
	ldr r0, [r4, #0x138]
	cmp r0, #0
	movne r0, #0x5000
	moveq r0, #0x4000
	rsb r0, r0, #0
	str r0, [r4, #0x184]
	ldrh r0, [r6, #0x34]
	add r0, r0, #0x1000
	strh r0, [r6, #0x34]
	ldr r1, [r5, #0x44]
	ldr r0, [r4, #0x178]
	cmp r1, r0
	ble _02186B38
	mov r0, #0
	str r0, [r6, #0x28]
	ldr r0, [r4, #0x128]
	add r0, r0, #1
	str r0, [r4, #0x128]
	b _02186B38
_021869A8:
	mov r0, #0x1800
	str r0, [r4, #0x184]
	rsb r0, r0, #0
	strh r0, [r6, #0x30]
	mov r0, #0
	strh r0, [r6, #0x34]
	ldr r1, [r5, #0x44]
	ldr r0, [r4, #0x178]
	add r1, r1, #0x1b000
	cmp r1, r0
	ldrlt r0, [r4, #0x128]
	addlt r0, r0, #1
	strlt r0, [r4, #0x128]
	ldr r0, [r4, #0x138]
	cmp r0, #0
	beq _02186B38
	ldr r0, [r6, #0x28]
	add r0, r0, #1
	str r0, [r6, #0x28]
	cmp r0, #5
	bls _02186B38
	ldr r3, _02186B84 // =_mt_math_rand
	mov r8, #0
	ldr r2, [r3]
	ldr r0, _02186B88 // =0x00196225
	ldr r1, _02186B8C // =0x3C6EF35F
	str r8, [sp, #0x20]
	mla ip, r2, r0, r1
	mov r7, ip, lsr #0x10
	str r8, [sp, #0x24]
	str r8, [sp, #0x28]
	str r8, [sp, #0x14]
	str r8, [sp, #0x18]
	str r8, [sp, #0x1c]
	add r0, r4, #0x170
	ldmia r0, {r0, r1, r2}
	add r8, sp, #8
	stmia r8, {r0, r1, r2}
	str ip, [r3]
	mov r3, #0x6000
	ldr lr, _02186B90 // =0x000001FE
	mov r0, r7, lsl #0x10
	ldr r1, _02186B94 // =0x000004FF
	and r0, lr, r0, lsr #16
	sub r0, r1, r0
	mov r2, r0, lsl #0x10
	add r1, sp, #0x2c
	mov r0, r6
	str r3, [r6, #4]
	mov r7, r2, lsr #0x10
	bl SailObject__Func_2165A9C
	add r1, sp, #0x2c
	add r0, r6, #0x44
	mov r2, r1
	bl VEC_Subtract
	ldr r0, [r4, #0x15c]
	add r1, sp, #0x14
	bl SailObject__Func_2165A9C
	ldr r1, [r5, #0x44]
	mov r0, r6
	str r1, [r4, #0x178]
	add r1, sp, #0x20
	bl SailObject__Func_2166C04
	add r0, sp, #0x20
	add r1, sp, #0x14
	mov r2, r0
	bl VEC_Subtract
	str r7, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r6
	add r1, sp, #0x2c
	add r2, sp, #0x20
	mov r3, #0xdc0
	bl SailHoverShell2__Create
	rsb r0, r7, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r6
	add r1, sp, #0x2c
	add r2, sp, #0x20
	mov r3, #0xdc0
	bl SailHoverShell2__Create
	mov r0, r8
	add r3, r4, #0x170
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x13c]
	add r0, r0, #1
	str r0, [r4, #0x13c]
	b _02186B38
_02186B20:
	ldr r0, [r4, #0x184]
	mov r1, #0x200
	bl ObjSpdDownSet
	str r0, [r4, #0x184]
	rsb r0, r0, #0
	strh r0, [r6, #0x30]
_02186B38:
	mov r0, r6
	bl SailObject__SetupAnimator3D
	mov r0, r6
	bl SailObject__Func_2166D18
	mov r0, r6
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x128]
	cmp r0, #3
	ldreq r0, [r4, #0x184]
	cmpeq r0, #0
	addne sp, sp, #0x38
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, [r6, #0x18]
	mov r0, r6
	bic r1, r1, #0x10
	str r1, [r6, #0x18]
	bl SailHoverBobBird__Func_218595C
	add sp, sp, #0x38
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02186B84: .word _mt_math_rand
_02186B88: .word 0x00196225
_02186B8C: .word 0x3C6EF35F
_02186B90: .word 0x000001FE
_02186B94: .word 0x000004FF
	arm_func_end SailHoverBobBird__State_21868AC

	arm_func_start SailHoverShell2__State_2186B98
SailHoverShell2__State_2186B98: // 0x02186B98
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, [r4, #0x28]
	ldr r5, [r4, #0x124]
	cmp r0, #0
	beq _02186C04
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0x98]
	ldr r1, [r5, #0x10]
	mov r2, #3
	bl ObjShiftSet
	str r0, [r4, #0x98]
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0x9c]
	ldr r1, [r5, #0x14]
	mov r2, #3
	bl ObjShiftSet
	str r0, [r4, #0x9c]
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0xa0]
	ldr r1, [r5, #0x18]
	mov r2, #3
	bl ObjShiftSet
	str r0, [r4, #0xa0]
_02186C04:
	ldr r0, [r4, #0x9c]
	mov r1, #0
	cmp r0, #0
	ldrgt r0, [r4, #0x48]
	cmpgt r0, #0
	ldrgt r0, [r4, #0x18]
	orrgt r0, r0, #4
	strgt r0, [r4, #0x18]
	mov r0, r4
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #4
	strne r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailHoverShell2__State_2186B98

	arm_func_start SailHoverShell1__State_2186C44
SailHoverShell1__State_2186C44: // 0x02186C44
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x9c]
	cmp r0, #0
	ldrgt r0, [r4, #0x48]
	cmpgt r0, #0
	ble _02186CB0
	ldr r0, [r4, #0x24]
	add r2, r4, #0x44
	tst r0, #2
	ldr r0, [r4, #0x138]
	beq _02186C80
	mov r1, #9
	bl SailAudio__PlaySpatialSequence
	b _02186C88
_02186C80:
	mov r1, #0x1c
	bl SailAudio__PlaySpatialSequence
_02186C88:
	add r0, r4, #0x44
	bl EffectSailWater08__Create
	ldr r1, [r0, #0x24]
	orr r1, r1, #1
	str r1, [r0, #0x24]
	mov r0, #2
	bl ShakeScreen
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
_02186CB0:
	mov r0, r4
	mov r1, #0
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #4
	strne r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	arm_func_end SailHoverShell1__State_2186C44

	arm_func_start SailHoverBoat02__SetupObject
SailHoverBoat02__SetupObject: // 0x02186CD4
	ldr r1, _02186CE0 // =SailHoverBoat02__State_2186CE4
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_02186CE0: .word SailHoverBoat02__State_2186CE4
	arm_func_end SailHoverBoat02__SetupObject

	arm_func_start SailHoverBoat02__State_2186CE4
SailHoverBoat02__State_2186CE4: // 0x02186CE4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r1, [r4, #0x164]
	ldr r2, [r0, #0x98]
	ldr r0, [r1, #0x34]
	tst r0, #1
	movne r0, #0xb00
	moveq r0, #0x800
	str r0, [r4, #0x184]
	ldr r1, [r4, #0x178]
	ldr r0, [r2, #0x44]
	sub r0, r1, r0
	cmp r0, #0x51000
	movgt r0, #0
	strgt r0, [r4, #0x184]
	ldr r1, [r4, #0x178]
	ldr r0, [r2, #0x44]
	sub r0, r1, r0
	cmp r0, #0x10000
	ble _02186D7C
	ldr r1, [r4, #0x164]
	ldr r0, [r1, #0x34]
	tst r0, #2
	ldreq r0, [r1, #0x28]
	cmpeq r0, #0
	beq _02186D7C
	ldr r0, [r4, #0x128]
	cmp r0, #0
	ldreq r0, [r5, #0x28]
	cmpeq r0, #0x18
	bne _02186D7C
	ldr r1, [r4, #0x13c]
	ldr r0, _02186E0C // =_0218C8C8
	ldrb r0, [r0, r1]
	str r0, [r4, #0x128]
_02186D7C:
	ldr r0, [r4, #0x128]
	cmp r0, #0
	beq _02186DAC
	add r0, r4, #0x17c
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x128]
	mov r0, r5
	sub r1, r1, #1
	str r1, [r4, #0x128]
	bl SailHoverEnemyHover__Func_2187134
_02186DAC:
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r5
	add r1, r1, #0x8000
	strh r1, [r5, #0x32]
	bl SailObject__SetupAnimator3D
	mov r0, r5
	bl SailObject__Func_2166D18
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x128]
	cmp r0, #0
	bne _02186DF4
	ldr r0, [r5, #0x28]
	add sp, sp, #0xc
	add r0, r0, #1
	str r0, [r5, #0x28]
	ldmia sp!, {r4, r5, pc}
_02186DF4:
	add r0, sp, #0
	add r3, r4, #0x17c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02186E0C: .word _0218C8C8
	arm_func_end SailHoverBoat02__State_2186CE4

	arm_func_start SailHoverEnemyHover__Func_2186E10
SailHoverEnemyHover__Func_2186E10: // 0x02186E10
	ldr r1, [r0, #0x20]
	ldr ip, [r0, #0x124]
	bic r1, r1, #0x20
	bic r1, r1, #0x1000
	str r1, [r0, #0x20]
	ldr r1, [r0, #0x18]
	ldr r2, _02186E5C // =SailHoverEnemyHover__State_2186E60
	bic r1, r1, #0x10
	bic r1, r1, #2
	str r1, [r0, #0x18]
	ldr r3, [r0, #0x24]
	mov r1, #0x800
	orr r3, r3, #1
	str r3, [r0, #0x24]
	str r2, [r0, #0xf4]
	str r1, [ip, #0x184]
	ldr r0, [ip, #0x178]
	str r0, [ip, #0x138]
	bx lr
	.align 2, 0
_02186E5C: .word SailHoverEnemyHover__State_2186E60
	arm_func_end SailHoverEnemyHover__Func_2186E10

	arm_func_start SailHoverEnemyHover__State_2186E60
SailHoverEnemyHover__State_2186E60: // 0x02186E60
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r0, [r6, #0x28]
	ldr r1, _02186F6C // =FX_SinCosTable_
	mov r0, r0, lsl #0x19
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r0, [r1, r0]
	ldr r5, [r4, #0x170]
	mov r0, r0, asr #2
	str r0, [r4, #0x17c]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x10]
	cmp r0, #0
	ldrlt r0, [r4, #0x17c]
	rsblt r0, r0, #0
	strlt r0, [r4, #0x17c]
	ldr r0, [r6, #0x28]
	cmp r0, #8
	bls _02186EE0
	cmp r0, #0x48
	bhs _02186EE0
	ldr r0, [r4, #0x184]
	mov r1, #0x14
	bl ObjSpdDownSet
	str r0, [r4, #0x184]
	b _02186EFC
_02186EE0:
	cmp r0, #0x48
	blo _02186EFC
	ldr r0, [r4, #0x184]
	mov r1, #0x48
	mov r2, #0xc00
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
_02186EFC:
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r6
	strh r1, [r6, #0x32]
	bl SailObject__SetupAnimator3D
	mov r0, r6
	bl SailObject__Func_2166D18
	mov r0, r6
	bl SailObject__Func_2166A2C
	ldr r0, [r6, #0x28]
	add r0, r0, #1
	str r0, [r6, #0x28]
	cmp r0, #0x48
	ldmloia sp!, {r4, r5, r6, pc}
	ldr r0, [r4, #0x170]
	cmp r0, #0
	bgt _02186F48
	cmp r5, #0
	bgt _02186F58
_02186F48:
	cmp r0, #0
	ldmltia sp!, {r4, r5, r6, pc}
	cmp r5, #0
	ldmgeia sp!, {r4, r5, r6, pc}
_02186F58:
	mov r1, #0
	mov r0, r6
	str r1, [r4, #0x170]
	bl SailHoverEnemyHover__Func_2186F70
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02186F6C: .word FX_SinCosTable_
	arm_func_end SailHoverEnemyHover__State_2186E60

	arm_func_start SailHoverEnemyHover__Func_2186F70
SailHoverEnemyHover__Func_2186F70: // 0x02186F70
	ldr r2, _02186F84 // =SailHoverEnemyHover__State_2186F88
	mov r1, #0
	str r2, [r0, #0xf4]
	str r1, [r0, #0x28]
	bx lr
	.align 2, 0
_02186F84: .word SailHoverEnemyHover__State_2186F88
	arm_func_end SailHoverEnemyHover__Func_2186F70

	arm_func_start SailHoverEnemyHover__State_2186F88
SailHoverEnemyHover__State_2186F88: // 0x02186F88
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r0, [r5, #0x28]
	ldr r1, _02187120 // =FX_SinCosTable_
	mov r0, r0, lsl #0x19
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrsh r0, [r1, r0]
	mov r0, r0, asr #2
	str r0, [r4, #0x17c]
	ldr r0, [r5, #0x28]
	mov r0, r0, lsl #0x1a
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r0, [r1, r0]
	mov r0, r0, asr #2
	str r0, [r4, #0x184]
	ldr r0, [r4, #0x17c]
	rsb r0, r0, #0
	str r0, [r4, #0x17c]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x10]
	cmp r0, #0
	ldrlt r0, [r4, #0x17c]
	rsblt r0, r0, #0
	strlt r0, [r4, #0x17c]
	ldr r0, [r4, #0x128]
	cmp r0, #0
	bne _0218709C
	ldr r1, [r4, #0x164]
	ldr r0, [r1, #0x34]
	tst r0, #2
	ldreq r0, [r1, #0x28]
	cmpeq r0, #0
	beq _0218709C
	ldr r0, [r5, #0x28]
	tst r0, #0x1f
	bne _0218709C
	ldr r2, _02187124 // =_mt_math_rand
	ldr r0, _02187128 // =0x00196225
	ldr r3, [r2]
	ldr r1, _0218712C // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	and r0, r0, #0xf
	str r0, [r4, #0x13c]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #4
	ldrne r0, [r4, #0x13c]
	andne r0, r0, #7
	strne r0, [r4, #0x13c]
	ldr r1, [r4, #0x13c]
	ldr r0, _02187130 // =_0218C8C8
	ldrb r0, [r0, r1]
	str r0, [r4, #0x128]
_0218709C:
	ldr r0, [r4, #0x128]
	cmp r0, #0
	beq _021870C8
	sub r0, r0, #1
	str r0, [r4, #0x128]
	mov r0, #0
	str r0, [r4, #0x17c]
	str r0, [r4, #0x184]
	ldr r1, [r4, #0x128]
	mov r0, r5
	bl SailHoverEnemyHover__Func_2187134
_021870C8:
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r5
	strh r1, [r5, #0x32]
	bl SailObject__SetupAnimator3D
	mov r0, r5
	bl SailObject__Func_2166D18
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x128]
	cmp r0, #0
	ldreq r0, [r5, #0x28]
	addeq r0, r0, #1
	streq r0, [r5, #0x28]
	ldr r1, [r4, #0x178]
_02187104: // 0x02187104
	ldr r0, [r4, #0x138]
	sub r0, r1, r0
	cmp r0, #0x200000
	ldmleia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl SailHoverEnemyHover__Func_2187CC0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02187120: .word FX_SinCosTable_
_02187124: .word _mt_math_rand
_02187128: .word 0x00196225
_0218712C: .word 0x3C6EF35F
_02187130: .word _0218C8C8
	arm_func_end SailHoverEnemyHover__State_2186F88

	arm_func_start SailHoverEnemyHover__Func_2187134
SailHoverEnemyHover__Func_2187134: // 0x02187134
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x1a0
	mov r7, r0
	ldr r4, [r7, #0x124]
	mov r6, r1
	bl SailManager__GetWork
	ldr r1, [r4, #0x13c]
	ldr r5, [r0, #0x98]
	cmp r1, #0x11
	addls pc, pc, r1, lsl #2
	b _02187C98
_02187160: // jump table
	b _021871A8 // case 0
	b _02187200 // case 1
	b _0218748C // case 2
	b _02187554 // case 3
	b _02187578 // case 4
	b _021875A4 // case 5
	b _02187694 // case 6
	b _02187964 // case 7
	b _021872FC // case 8
	b _021874EC // case 9
	b _02187618 // case 10
	b _02187764 // case 11
	b _02187A90 // case 12
	b _02187BAC // case 13
	b _02187A90 // case 14
	b _02187BAC // case 15
	b _02187C78 // case 16
	b _0218783C // case 17
_021871A8:
	cmp r6, #8
	addne sp, sp, #0x1a0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, #0x4000
	str r0, [r7, #4]
	add r0, r7, #0x44
	add r3, sp, #0x194
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [sp, #0x198]
	mov r0, r7
	sub r1, r1, #0x1800
	str r1, [sp, #0x198]
	ldr r2, [r4, #0x15c]
	mov r1, r3
	add r2, r2, #0x44
	mov r3, #0
	bl SailHoverShell1__Create
	add r0, sp, #0x194
	bl EffectSailFlash__Create
	add sp, sp, #0x1a0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02187200:
	cmp r6, #0xc
	addne sp, sp, #0x1a0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, _02187CA0 // =_0218C8BC
	add r3, sp, #0x170
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #0x8000
	str r0, [r7, #4]
	add r0, r7, #0x44
	add r3, sp, #0x188
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [sp, #0x18c]
	ldr r3, _02187CA4 // =FX_SinCosTable_
	sub r0, r0, #0x1800
	str r0, [sp, #0x18c]
	ldrh r1, [r5, #0x34]
	add r0, sp, #0x14c
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r5, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r5]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, sp, #0x170
	add r1, sp, #0x14c
	mov r2, r0
	bl MTX_MultVec33
	ldr r0, [r4, #0x15c]
	add r3, sp, #0x17c
	add r0, r0, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r3
	mov r2, r3
	add r1, sp, #0x170
	bl VEC_Add
	mov r0, r7
	add r1, sp, #0x188
	add r2, sp, #0x17c
	mov r3, #0
	bl SailHoverShell1__Create
	ldr r0, [r4, #0x15c]
	add r3, sp, #0x17c
	add r0, r0, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r3
	mov r2, r3
	add r1, sp, #0x170
	bl VEC_Subtract
	mov r0, r7
	add r1, sp, #0x188
	add r2, sp, #0x17c
	mov r3, #0
	bl SailHoverShell1__Create
	add r0, sp, #0x188
	bl EffectSailFlash__Create
	add sp, sp, #0x1a0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_021872FC:
	cmp r6, #0x14
	addne sp, sp, #0x1a0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, _02187CA8 // =_0218C8A4
	add r3, sp, #0x128
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #0x8000
	str r0, [r7, #4]
	add r0, r7, #0x44
	add r3, sp, #0x140
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [sp, #0x144]
	ldr r3, _02187CA4 // =FX_SinCosTable_
	sub r0, r0, #0x1800
	str r0, [sp, #0x144]
	ldrh r1, [r5, #0x34]
	add r0, sp, #0x104
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r5, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r5]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, sp, #0x128
	add r1, sp, #0x104
	mov r2, r0
	bl MTX_MultVec33
	ldr r0, [r4, #0x15c]
	add r3, sp, #0x134
	add r0, r0, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r3
	mov r2, r3
	add r1, sp, #0x128
	bl VEC_Add
	mov r0, r7
	add r1, sp, #0x140
	add r2, sp, #0x134
	mov r3, #0
	bl SailHoverShell1__Create
	ldr r0, [r4, #0x15c]
	add r3, sp, #0x134
	add r0, r0, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r3
	mov r2, r3
	add r1, sp, #0x128
	bl VEC_Subtract
	mov r0, r7
	add r1, sp, #0x140
	add r2, sp, #0x134
	mov r3, #0
	bl SailHoverShell1__Create
	mov r0, #0
	str r0, [sp, #0x128]
	str r0, [sp, #0x12c]
	mov r0, #0x4000
	str r0, [sp, #0x130]
	add r0, sp, #0x128
	add r1, sp, #0x104
	mov r2, r0
	bl MTX_MultVec33
	ldr r0, [r4, #0x15c]
	add r3, sp, #0x134
	add r0, r0, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r1, sp, #0x128
	mov r0, r3
	mov r2, r3
	bl VEC_Add
	add r1, sp, #0x140
	add r2, sp, #0x134
	mov r0, r7
	mov r3, #0
	bl SailHoverShell1__Create
	ldr r0, [r4, #0x15c]
	add r3, sp, #0x134
	add r0, r0, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r1, sp, #0x128
	mov r0, r3
	mov r2, r3
	bl VEC_Subtract
	mov r0, r7
	add r1, sp, #0x140
	add r2, sp, #0x134
	mov r3, #0
	bl SailHoverShell1__Create
	add r0, sp, #0x140
	bl EffectSailFlash__Create
	add sp, sp, #0x1a0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0218748C:
	cmp r6, #0x10
	cmpne r6, #0x20
	cmpne r6, #0x30
	addne sp, sp, #0x1a0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, #0x4000
	str r0, [r7, #4]
	add r0, r7, #0x44
	add r3, sp, #0xf8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [sp, #0xfc]
	mov r0, r7
	sub r1, r1, #0x1800
	str r1, [sp, #0xfc]
	ldr r2, [r4, #0x15c]
	mov r1, r3
	add r2, r2, #0x44
	mov r3, #0
	bl SailHoverShell1__Create
	add r0, sp, #0xf8
	bl EffectSailFlash__Create
	add sp, sp, #0x1a0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_021874EC:
	cmp r6, #0x14
	cmpne r6, #0x24
	cmpne r6, #0x34
	cmpne r6, #0x44
	cmpne r6, #0x54
	addne sp, sp, #0x1a0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, #0x4000
	str r0, [r7, #4]
	add r0, r7, #0x44
	add r3, sp, #0xec
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [sp, #0xf0]
	mov r0, r7
	sub r1, r1, #0x1800
	str r1, [sp, #0xf0]
	ldr r2, [r4, #0x15c]
	mov r1, r3
	add r2, r2, #0x44
	mov r3, #0
	bl SailHoverShell1__Create
	add r0, sp, #0xec
	bl EffectSailFlash__Create
	add sp, sp, #0x1a0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02187554:
	cmp r6, #8
	addne sp, sp, #0x1a0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r1, #0x4000
	mov r0, r7
	str r1, [r7, #4]
	bl SpawnSailHoverTorpedo2
	add sp, sp, #0x1a0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02187578:
	cmp r6, #0x1e
	cmpne r6, #0x32
	cmpne r6, #0x46
	addne sp, sp, #0x1a0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r1, #0x4000
	mov r0, r7
	str r1, [r7, #4]
	bl SpawnSailHoverTorpedo2
	add sp, sp, #0x1a0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_021875A4:
	cmp r6, #2
	addne sp, sp, #0x1a0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r3, #0x4000
	add r1, sp, #0xe0
	add r2, sp, #0xd4
	mov r0, r7
	str r3, [r7, #4]
	bl SailHoverBobBird__Func_2185BBC
	ldr r0, [r4, #0x164]
	mov r3, #0x1300
	ldrh r0, [r0, #0x30]
	add r1, sp, #0xe0
	add r2, sp, #0xd4
	cmp r0, #0x15
	ldrlo r0, [sp, #0xe4]
	sublo r0, r0, #0x1000
	strlo r0, [sp, #0xe4]
	ldr r0, [r4, #0x164]
	mov r4, #0
	ldrh r0, [r0, #0x30]
	cmp r0, #0xb
	str r4, [sp]
	addeq r3, r3, #0x600
	mov r0, r7
	str r4, [sp, #4]
	bl SailHoverShell2__Create
	add sp, sp, #0x1a0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02187618:
	cmp r6, #2
	cmpne r6, #0x12
	cmpne r6, #0x22
	addne sp, sp, #0x1a0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r3, #0x8000
	add r1, sp, #0xc8
	add r2, sp, #0xbc
	mov r0, r7
	str r3, [r7, #4]
	bl SailHoverBobBird__Func_2185BBC
	ldr r0, [r4, #0x164]
	mov r3, #0x1300
	ldrh r0, [r0, #0x30]
	add r1, sp, #0xc8
	add r2, sp, #0xbc
	cmp r0, #0x15
	ldrlo r0, [sp, #0xcc]
	sublo r0, r0, #0x1000
	strlo r0, [sp, #0xcc]
	ldr r0, [r4, #0x164]
	mov r4, #0
	ldrh r0, [r0, #0x30]
	cmp r0, #0xb
	str r4, [sp]
	addeq r3, r3, #0x600
	mov r0, r7
	str r4, [sp, #4]
	bl SailHoverShell2__Create
	add sp, sp, #0x1a0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02187694:
	cmp r6, #0x10
	addne sp, sp, #0x1a0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r3, #0x6000
	add r1, sp, #0xb0
	add r2, sp, #0xa4
	mov r0, r7
	str r3, [r7, #4]
	bl SailHoverBobBird__Func_2185BBC
	ldr r0, [r4, #0x164]
	mov r5, #0
	ldrh r0, [r0, #0x30]
	mov r3, #0xe00
	add r1, sp, #0xb0
	cmp r0, #0x15
	ldrlo r0, [sp, #0xb4]
	add r2, sp, #0xa4
	sublo r0, r0, #0x1000
	strlo r0, [sp, #0xb4]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #0xb
	str r5, [sp]
	addeq r3, r3, #0x700
	mov r0, r7
	str r5, [sp, #4]
	bl SailHoverShell2__Create
	ldr r0, [r4, #0x164]
	mov r5, #0xdc0
	ldrh r0, [r0, #0x30]
	mov r4, #0x1a0
	add r1, sp, #0xb0
	cmp r0, #0xb
	addeq r5, r5, #0x700
	str r4, [sp]
	mov r4, #0
	add r2, sp, #0xa4
	mov r0, r7
	mov r3, r5
	str r4, [sp, #4]
	bl SailHoverShell2__Create
	ldr r4, _02187CAC // =0x0000FE60
	add r1, sp, #0xb0
	str r4, [sp]
	mov r4, #0
	add r2, sp, #0xa4
	mov r0, r7
	mov r3, r5
	str r4, [sp, #4]
	bl SailHoverShell2__Create
	add sp, sp, #0x1a0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02187764:
	cmp r6, #0x10
	cmpne r6, #0x30
	cmpne r6, #0x50
	addne sp, sp, #0x1a0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r3, #0x6000
	add r1, sp, #0x98
	add r2, sp, #0x8c
	mov r0, r7
	str r3, [r7, #4]
	bl SailHoverBobBird__Func_2185BBC
	ldr r0, [r4, #0x164]
	mov r5, #0
	ldrh r0, [r0, #0x30]
	mov r3, #0xe00
	add r1, sp, #0x98
	cmp r0, #0x15
	ldrlo r0, [sp, #0x9c]
	add r2, sp, #0x8c
	sublo r0, r0, #0x1000
	strlo r0, [sp, #0x9c]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #0xb
	str r5, [sp]
	addeq r3, r3, #0x700
	mov r0, r7
	str r5, [sp, #4]
	bl SailHoverShell2__Create
	ldr r0, [r4, #0x164]
	mov r5, #0xdc0
	ldrh r0, [r0, #0x30]
	mov r4, #0x1a0
	add r1, sp, #0x98
	cmp r0, #0xb
	addeq r5, r5, #0x700
	str r4, [sp]
	mov r4, #0
	add r2, sp, #0x8c
	mov r0, r7
	mov r3, r5
	str r4, [sp, #4]
	bl SailHoverShell2__Create
	ldr r4, _02187CAC // =0x0000FE60
	add r1, sp, #0x98
	str r4, [sp]
	mov r4, #0
	add r2, sp, #0x8c
	mov r0, r7
	mov r3, r5
	str r4, [sp, #4]
	bl SailHoverShell2__Create
	add sp, sp, #0x1a0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0218783C:
	cmp r6, #0x10
	addne sp, sp, #0x1a0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r3, #0x6000
	add r1, sp, #0x80
	add r2, sp, #0x74
	mov r0, r7
	str r3, [r7, #4]
	bl SailHoverBobBird__Func_2185BBC
	ldr r0, [r4, #0x164]
	mov r5, #0
	ldrh r0, [r0, #0x30]
	mov r3, #0xe00
	add r1, sp, #0x80
	cmp r0, #0x15
	ldrlo r0, [sp, #0x84]
	add r2, sp, #0x74
	sublo r0, r0, #0x1000
	strlo r0, [sp, #0x84]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #0xb
	str r5, [sp]
	addeq r3, r3, #0x700
	mov r0, r7
	str r5, [sp, #4]
	bl SailHoverShell2__Create
	ldr r0, [r4, #0x164]
	mov r5, #0xdc0
	ldrh r0, [r0, #0x30]
	mov r6, #0x280
	add r1, sp, #0x80
	cmp r0, #0xb
	addeq r5, r5, #0x700
	str r6, [sp]
	mov r6, #0
	add r2, sp, #0x74
	mov r0, r7
	mov r3, r5
	str r6, [sp, #4]
	bl SailHoverShell2__Create
	ldr r0, _02187CB0 // =0x0000FD80
	add r1, sp, #0x80
	str r0, [sp]
	add r2, sp, #0x74
	mov r0, r7
	mov r3, r5
	str r6, [sp, #4]
	bl SailHoverShell2__Create
	ldr r0, [r4, #0x164]
	mov r5, #0xd80
	ldrh r0, [r0, #0x30]
	mov r4, #0x500
	add r1, sp, #0x80
	cmp r0, #0xb
	addeq r5, r5, #0x700
	str r4, [sp]
	mov r4, #0
	add r2, sp, #0x74
	mov r0, r7
	mov r3, r5
	str r4, [sp, #4]
	bl SailHoverShell2__Create
	mov r4, #0xfb00
	str r4, [sp]
	mov r4, #0
	add r1, sp, #0x80
	add r2, sp, #0x74
	mov r0, r7
	mov r3, r5
	str r4, [sp, #4]
	bl SailHoverShell2__Create
	add sp, sp, #0x1a0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02187964:
	cmp r6, #0x5a
	addge sp, sp, #0x1a0
	ldmgeia sp!, {r3, r4, r5, r6, r7, pc}
	cmp r6, #0x18
	addle sp, sp, #0x1a0
	ldmleia sp!, {r3, r4, r5, r6, r7, pc}
	tst r6, #3
	addne sp, sp, #0x1a0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r2, #0x8000
	add r1, sp, #0x68
	mov r0, r7
	str r2, [r7, #4]
	bl SailObject__Func_2165A9C
	ldr r0, [r4, #0x15c]
	add r1, sp, #0x5c
	bl SailObject__Func_2165A9C
	add r1, sp, #0x68
	add r0, r7, #0x44
	mov r2, r1
	bl VEC_Subtract
	ldr r0, [r4, #0x15c]
	add r1, sp, #0x5c
	add r0, r0, #0x44
	mov r2, r1
	bl VEC_Subtract
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #0x13
	ldrlo r0, [sp, #0x60]
	sublo r0, r0, #0x3400
	strlo r0, [sp, #0x60]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #0x13
	ldreq r0, [sp, #0x60]
	subeq r0, r0, #0x2000
	streq r0, [sp, #0x60]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #0x15
	ldrhs r0, [sp, #0x60]
	subhs r0, r0, #0x1000
	strhs r0, [sp, #0x60]
	bhs _02187A24
	ldr r0, [sp, #0x6c]
	sub r0, r0, #0x1000
	str r0, [sp, #0x6c]
_02187A24:
	ldr r2, _02187CB4 // =_mt_math_rand
	ldr r0, _02187CB8 // =0x00196225
	ldr r5, [r2]
	ldr r1, _02187CBC // =0x3C6EF35F
	mov r3, #0x1300
	mla r0, r5, r0, r1
	str r0, [r2]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	ldr r1, [r4, #0x164]
	mov r0, r0, lsr #0x10
	and r0, r0, #0xfe
	ldrh r1, [r1, #0x30]
	rsb r0, r0, #0x7f
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	cmp r1, #0xb
	str r4, [sp]
	mov r4, #1
	addeq r3, r3, #0x600
	add r1, sp, #0x68
	add r2, sp, #0x5c
	mov r0, r7
	str r4, [sp, #4]
	bl SailHoverShell2__Create
	add sp, sp, #0x1a0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02187A90:
	cmp r6, #2
	cmpne r6, #6
	cmpne r6, #0xa
	cmpne r6, #0xe
	cmpne r6, #0x12
	addne sp, sp, #0x1a0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, #0
	add r3, sp, #0x2c
	str r0, [sp, #0x38]
	str r0, [sp, #0x3c]
	str r0, [sp, #0x40]
	str r0, [sp, #0x44]
	str r0, [sp, #0x48]
	str r0, [sp, #0x4c]
	add r0, r4, #0x170
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r2, #0x4000
	add r1, sp, #0x50
	mov r0, r7
	str r2, [r7, #4]
	bl SailObject__Func_2165A9C
	add r1, sp, #0x50
	add r0, r7, #0x44
	mov r2, r1
	bl VEC_Subtract
	ldr r0, [r4, #0x15c]
	add r1, sp, #0x44
	bl SailObject__Func_2165A9C
	ldr r1, [r5, #0x44]
	rsb r0, r6, #0xa
	str r1, [r4, #0x178]
	mov r0, r0, lsl #0xb
	str r0, [r4, #0x170]
	ldr r0, [r4, #0x13c]
	add r1, sp, #0x38
	cmp r0, #0xe
	ldreq r0, [r4, #0x170]
	rsbeq r0, r0, #0
	streq r0, [r4, #0x170]
	mov r0, r7
	bl SailObject__Func_2166C04
	add r0, sp, #0x38
	add r1, sp, #0x44
	mov r2, r0
	bl VEC_Subtract
	ldr r0, [r4, #0x164]
	add r3, r4, #0x170
	ldrh r0, [r0, #0x30]
	cmp r0, #0x15
	ldrlo r0, [sp, #0x54]
	sublo r0, r0, #0x1000
	strlo r0, [sp, #0x54]
	add r0, sp, #0x2c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x164]
	mov r3, #0x1300
	ldrh r0, [r0, #0x30]
	mov r4, #0
	add r1, sp, #0x50
	cmp r0, #0xb
	str r4, [sp]
	moveq r3, #0x4000
	add r2, sp, #0x38
	mov r0, r7
	str r4, [sp, #4]
	bl SailHoverShell2__Create
	add sp, sp, #0x1a0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02187BAC:
	cmp r6, #0x10
	cmpne r6, #0x20
	cmpne r6, #0x30
	cmpne r6, #0x40
	cmpne r6, #0x50
	addne sp, sp, #0x1a0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, #0
	add r3, sp, #8
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	str r0, [sp, #0x1c]
	add r0, r4, #0x170
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	rsb r0, r6, #0x30
	mov r1, #0x8000
	add r3, r0, r0, lsl #2
	add r6, sp, #0x20
	str r1, [r7, #4]
	add r0, r7, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	ldr r1, [sp, #0x24]
	mov r0, r3, lsl #6
	sub r1, r1, #0x1800
	str r1, [sp, #0x24]
	ldr r1, [r5, #0x44]
	str r1, [r4, #0x178]
	str r0, [r4, #0x170]
	ldr r0, [r4, #0x13c]
	add r1, sp, #0x14
	cmp r0, #0xf
	ldreq r0, [r4, #0x170]
	rsbeq r0, r0, #0
	streq r0, [r4, #0x170]
	mov r0, r7
	bl SailObject__Func_2166C04
	add r0, sp, #8
	add r3, r4, #0x170
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r1, sp, #0x20
	add r2, sp, #0x14
	mov r0, r7
	mov r3, #0
	bl SailHoverShell1__Create
	add r0, sp, #0x20
	bl EffectSailFlash__Create
	add sp, sp, #0x1a0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02187C78:
	cmp r6, #8
	addne sp, sp, #0x1a0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r2, #0x4000
	mov r0, r7
	add r1, r7, #0x44
	str r2, [r7, #4]
	bl SailHoverBomber__Create
_02187C98:
	add sp, sp, #0x1a0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02187CA0: .word _0218C8BC
_02187CA4: .word FX_SinCosTable_
_02187CA8: .word _0218C8A4
_02187CAC: .word 0x0000FE60
_02187CB0: .word 0x0000FD80
_02187CB4: .word _mt_math_rand
_02187CB8: .word 0x00196225
_02187CBC: .word 0x3C6EF35F
	arm_func_end SailHoverEnemyHover__Func_2187134

	arm_func_start SailHoverEnemyHover__Func_2187CC0
SailHoverEnemyHover__Func_2187CC0: // 0x02187CC0
	ldr r2, _02187CD4 // =SailHoverEnemyHover__State_2187CD8
	mov r1, #0
	str r2, [r0, #0xf4]
	str r1, [r0, #0x28]
	bx lr
	.align 2, 0
_02187CD4: .word SailHoverEnemyHover__State_2187CD8
	arm_func_end SailHoverEnemyHover__Func_2187CC0

	arm_func_start SailHoverEnemyHover__State_2187CD8
SailHoverEnemyHover__State_2187CD8: // 0x02187CD8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r0, [r5, #0x28]
	ldr r1, _02187D88 // =FX_SinCosTable_
	mov r0, r0, lsl #0x19
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrsh r0, [r1, r0]
	mov r1, #0x48
	mov r2, #0x800
	mov r0, r0, asr #2
	str r0, [r4, #0x17c]
	ldr r0, [r4, #0x184]
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
	ldr r0, [r4, #0x17c]
	rsb r0, r0, #0
	str r0, [r4, #0x17c]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x10]
	cmp r0, #0
	ldrlt r0, [r4, #0x17c]
	rsblt r0, r0, #0
	strlt r0, [r4, #0x17c]
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r5
	strh r1, [r5, #0x32]
	bl SailObject__SetupAnimator3D
	mov r0, r5
	bl SailObject__Func_2166D18
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r5, #0x28]
	add r0, r0, #1
	str r0, [r5, #0x28]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02187D88: .word FX_SinCosTable_
	arm_func_end SailHoverEnemyHover__State_2187CD8

	.rodata

_0218C8A4: // 0x0218C8A4
    .word 0x2000, 0, 0

_0218C8B0: // 0x0218C8B0
    .word 0, 0x1000, 0
	
_0218C8BC: // 0x0218C8BC
    .word 0x2000, 0, 0

_0218C8C8: // 0x0218C8C8
    .byte 0xC, 0x18, 0x40, 0xC, 0x50, 6, 0x24, 0x6E, 0x30, 0x60, 0x2A, 0x60, 0x28, 0x60, 0x28, 0x60, 0xC, 0x28

	.data

aSbSHover1Nsbmd_0: // 0x0218D700
	.asciz "sb_s_hover1.nsbmd"
    .align 4

aSbSHover2Nsbmd_0: // 0x0218D714
	.asciz "sb_s_hover2.nsbmd"
    .align 4

aSbShellBac_1: // 0x0218D728
	.asciz "sb_shell.bac"
    .align 4

aSbBomberBac_0: // 0x0218D738
	.asciz "sb_bomber.bac"
    .align 4

aSbSBoat02Nsbmd_2: // 0x0218D748
	.asciz "sb_s_boat02.nsbmd"
    .align 4

aSbSBoat01Nsbmd_1: // 0x0218D75C
	.asciz "sb_s_boat01.nsbmd"
    .align 4

aSbBobNsbmd_1: // 0x0218D770
	.asciz "sb_bob.nsbmd"
    .align 4

aSbBirdNsbmd_2: // 0x0218D780
	.asciz "sb_bird.nsbmd"
    .align 4