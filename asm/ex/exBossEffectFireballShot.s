	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start exBossEffectFireBallShotTask__Func_21560E0
exBossEffectFireBallShotTask__Func_21560E0: // 0x021560E0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _02156314 // =0x02175FC4
	mov r4, r0
	str r4, [r1, #0x14]
	ldr r0, [r1, #0x4c]
	cmp r0, #0
	ldrne r0, [r1, #0xa8]
	cmpne r0, #0
	beq _0215615C
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _02156314 // =0x02175FC4
	ldr r1, [r1, #0x4c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _02156314 // =0x02175FC4
	ldr r1, [r1, #0xa8]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _02156314 // =0x02175FC4
	ldr r1, [r1, #0x4c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_0215615C:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, _02156314 // =0x02175FC4
	ldrsh r0, [r0, #0xa]
	cmp r0, #0
	bne _021561F0
	mov r1, #0x20
	ldr r0, _02156318 // =aExtraExBb_2
	sub r2, r1, #0x21
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _02156314 // =0x02175FC4
	mov r0, r0, lsr #8
	str r0, [r1, #0x4c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02156314 // =0x02175FC4
	mov r0, r5
	str r1, [r2, #0xac]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x55
	bl LoadExSystemFile
	ldr r1, _02156314 // =0x02175FC4
	mov r2, #0
	str r0, [r1, #0xb4]
	mov r0, #0x56
	str r2, [r1, #0xd4]
	bl LoadExSystemFile
	ldr r1, _02156314 // =0x02175FC4
	mov r2, #4
	str r0, [r1, #0xb8]
	str r2, [r1, #0xd8]
	ldr r0, [r1, #0xac]
	bl Asset3DSetup__Create
_021561F0:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _02156314 // =0x02175FC4
	str r2, [sp]
	ldr r1, [r0, #0xac]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, _0215631C // =0x02176098
	ldr r5, _02156320 // =0x02176078
	mov r7, r8
_02156228:
	str r7, [sp]
	ldr r1, [r6, r8, lsl #2]
	ldr r2, [r5, r8, lsl #2]
	mov r3, r7
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #2
	blo _02156228
	ldr r1, _02156314 // =0x02175FC4
	add r0, r4, #0x300
	ldr r2, [r1, #0xd4]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0xd4]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_0215627C:
	mov r0, r2, lsl r3
	tst r0, #0x11
	beq _0215629C
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215629C:
	add r3, r3, #1
	cmp r3, #5
	blo _0215627C
	mov r0, #0
	str r0, [r4, #0x358]
	mov ip, #0x1000
	str ip, [r4, #0x368]
	str ip, [r4, #0x36c]
	ldr r2, _02156324 // =0x0000BFF4
	str ip, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, _02156328 // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #1]
	add r2, r4, #0x350
	ldr r1, _02156314 // =0x02175FC4
	orr r3, r3, #0x10
	strb r3, [r4, #1]
	str ip, [r4, #0xc]
	str ip, [r4, #0x10]
	str ip, [r4, #0x14]
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #0xa]
	add r2, r2, #1
	strh r2, [r1, #0xa]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02156314: .word 0x02175FC4
_02156318: .word aExtraExBb_2
_0215631C: .word 0x02176098
_02156320: .word 0x02176078
_02156324: .word 0x0000BFF4
_02156328: .word 0x00007FF8
	arm_func_end exBossEffectFireBallShotTask__Func_21560E0

	arm_func_start exBossEffectFireBallShotTask__Func_215632C
exBossEffectFireBallShotTask__Func_215632C: // 0x0215632C
	stmdb sp!, {r4, lr}
	ldr r1, _021563B8 // =0x02175FC4
	mov r4, r0
	ldrsh r0, [r1, #0xa]
	cmp r0, #1
	bgt _0215639C
	ldr r0, [r1, #0xac]
	cmp r0, #0
	beq _02156354
	bl NNS_G3dResDefaultRelease
_02156354:
	ldr r0, _021563B8 // =0x02175FC4
	ldr r0, [r0, #0xb4]
	cmp r0, #0
	beq _02156368
	bl NNS_G3dResDefaultRelease
_02156368:
	ldr r0, _021563B8 // =0x02175FC4
	ldr r0, [r0, #0xb8]
	cmp r0, #0
	beq _0215637C
	bl NNS_G3dResDefaultRelease
_0215637C:
	ldr r0, _021563B8 // =0x02175FC4
	ldr r0, [r0, #0xac]
	cmp r0, #0
	beq _02156390
	bl _FreeHEAP_USER
_02156390:
	ldr r0, _021563B8 // =0x02175FC4
	mov r1, #0
	str r1, [r0, #0xac]
_0215639C:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _021563B8 // =0x02175FC4
	ldrsh r1, [r0, #0xa]
	sub r1, r1, #1
	strh r1, [r0, #0xa]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021563B8: .word 0x02175FC4
	arm_func_end exBossEffectFireBallShotTask__Func_215632C

	arm_func_start exBossEffectFireBallShotTask__Main
exBossEffectFireBallShotTask__Main: // 0x021563BC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02156430 // =0x02175FC4
	str r0, [r1, #0xa4]
	add r0, r4, #4
	bl exBossEffectFireBallShotTask__Func_21560E0
	add r0, r4, #0x390
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	ldr r1, [r4, #0x4e0]
	ldr r0, _02156430 // =0x02175FC4
	ldr r2, [r1, #0x3ec]
	mov r1, #1
	str r2, [r4, #0x354]
	ldr r2, [r4, #0x4e0]
	ldr r2, [r2, #0x3f0]
	str r2, [r4, #0x358]
	ldr r2, [r4, #0x4e0]
	ldr r2, [r2, #0x3f4]
	str r2, [r4, #0x35c]
	str r1, [r0, #0xa0]
	bl GetExTaskCurrent
	ldr r1, _02156434 // =exBossEffectFireBallShotTask__Func_215649C
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156430: .word 0x02175FC4
_02156434: .word exBossEffectFireBallShotTask__Func_215649C
	arm_func_end exBossEffectFireBallShotTask__Main

	arm_func_start exBossEffectFireBallShotTask__Func8
exBossEffectFireBallShotTask__Func8: // 0x02156438
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExSystemFlag_2178650
	cmp r0, #0
	beq _02156458
	bl GetExTaskCurrent
	ldr r1, _02156474 // =ExTask_State_Destroy
	str r1, [r0]
_02156458:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	ldmneia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02156474 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156474: .word ExTask_State_Destroy
	arm_func_end exBossEffectFireBallShotTask__Func8

	arm_func_start exBossEffectFireBallShotTask__Destructor
exBossEffectFireBallShotTask__Destructor: // 0x02156478
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #4
	bl exBossEffectFireBallShotTask__Func_215632C
	ldr r0, _02156498 // =0x02175FC4
	mov r1, #0
	str r1, [r0, #0xa4]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156498: .word 0x02175FC4
	arm_func_end exBossEffectFireBallShotTask__Destructor

	arm_func_start exBossEffectFireBallShotTask__Func_215649C
exBossEffectFireBallShotTask__Func_215649C: // 0x0215649C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl exBossSysAdminTask__GetSingleton
	cmp r0, #0
	bne _021564CC
	bl GetExTaskCurrent
	ldr r1, _02156508 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021564CC:
	add r0, r4, #4
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _021564EC
	bl GetExTaskCurrent
	ldr r1, _02156508 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021564EC:
	add r0, r4, #4
	add r1, r4, #0x390
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156508: .word ExTask_State_Destroy
	arm_func_end exBossEffectFireBallShotTask__Func_215649C

	arm_func_start exBossEffectFireBallShotTask__Create
exBossEffectFireBallShotTask__Create: // 0x0215650C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _02156580 // =0x000004E4
	str r4, [sp]
	ldr r0, _02156584 // =aExbosseffectfi_0
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02156588 // =exBossEffectFireBallShotTask__Main
	ldr r1, _0215658C // =exBossEffectFireBallShotTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, _02156580 // =0x000004E4
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x4e0]
	mov r0, r5
	bl GetExTask
	ldr r1, _02156590 // =exBossEffectFireBallShotTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02156580: .word 0x000004E4
_02156584: .word aExbosseffectfi_0
_02156588: .word exBossEffectFireBallShotTask__Main
_0215658C: .word exBossEffectFireBallShotTask__Destructor
_02156590: .word exBossEffectFireBallShotTask__Func8
	arm_func_end exBossEffectFireBallShotTask__Create

	arm_func_start exBossEffectFireBallTask__Func_2156594
exBossEffectFireBallTask__Func_2156594: // 0x02156594
	ldr r0, _021565A4 // =0x02175FC4
	mov r1, #0
	str r1, [r0, #0xa0]
	bx lr
	.align 2, 0
_021565A4: .word 0x02175FC4
	arm_func_end exBossEffectFireBallTask__Func_2156594

	.data

aExbosseffectfi_0: // 0x02173FE8
	.asciz "exBossEffectFireBallShotTask"