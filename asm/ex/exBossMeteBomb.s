	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start exBossSysAdminTask__Action_StartLine0
exBossSysAdminTask__Action_StartLine0: // 0x0215BCCC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0x14
	bl exBossHelpers__SetAnimation
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_21641F0
	mov r0, #0
	sub r1, r0, #1
	str r0, [sp]
	mov r2, #0x104
	str r2, [sp, #4]
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	bl GetExTaskCurrent
	ldr r1, _0215BD28 // =exBossSysAdminTask__Main_Line0
	str r1, [r0]
	bl exBossSysAdminTask__Main_Line0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215BD28: .word exBossSysAdminTask__Main_Line0
	arm_func_end exBossSysAdminTask__Action_StartLine0

	arm_func_start exBossSysAdminTask__Main_Line0
exBossSysAdminTask__Main_Line0: // 0x0215BD2C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215BD58
	bl exBossSysAdminTask__Action_StartLine1
	ldmia sp!, {r4, pc}
_0215BD58:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_Line0

	arm_func_start exBossSysAdminTask__Action_StartLine1
exBossSysAdminTask__Action_StartLine1: // 0x0215BD7C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r5, r0
	add r0, r5, #0x6c
	mov r1, #0x15
	bl exBossHelpers__SetAnimation
	add r0, r5, #0x3f8
	bl exDrawReqTask__Func_21641F0
	mov r1, #0xcb
	mov r0, #0
	stmia sp, {r0, r1}
	sub r1, r1, #0xcc
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r4, _0215BE38 // =_mt_math_rand
	ldr r7, _0215BE3C // =0x00196225
	ldr r8, _0215BE40 // =0x3C6EF35F
	mov r6, #0
_0215BDCC:
	strh r6, [r5, #0x66]
	ldr r0, [r4, #0]
	mla r2, r0, r7, r8
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	str r2, [r4]
	adds r0, r1, r0, ror #31
	beq _0215BE00
	bl exBossLineMissileTask__Create
	b _0215BE04
_0215BE00:
	bl exBossLineNeedleTask__Create
_0215BE04:
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #6
	blo _0215BDCC
	mov r0, #0
	strh r0, [r5, #0x66]
	bl GetExTaskCurrent
	ldr r1, _0215BE44 // =exBossSysAdminTask__Main_Line1
	str r1, [r0]
	bl exBossSysAdminTask__Main_Line1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215BE38: .word _mt_math_rand
_0215BE3C: .word 0x00196225
_0215BE40: .word 0x3C6EF35F
_0215BE44: .word exBossSysAdminTask__Main_Line1
	arm_func_end exBossSysAdminTask__Action_StartLine1

	arm_func_start exBossSysAdminTask__Main_Line1
exBossSysAdminTask__Main_Line1: // 0x0215BE48
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215BE74
	bl exBossSysAdminTask__Action_StartLine2
	ldmia sp!, {r4, pc}
_0215BE74:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_Line1

	arm_func_start exBossSysAdminTask__Action_StartLine2
exBossSysAdminTask__Action_StartLine2: // 0x0215BE98
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0x16
	bl exBossHelpers__SetAnimation
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _0215BECC // =exBossSysAdminTask__Main_Line2
	str r1, [r0]
	bl exBossSysAdminTask__Main_Line2
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215BECC: .word exBossSysAdminTask__Main_Line2
	arm_func_end exBossSysAdminTask__Action_StartLine2

	arm_func_start exBossSysAdminTask__Main_Line2
exBossSysAdminTask__Main_Line2: // 0x0215BED0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215BF24
	ldrsh r0, [r4, #0x44]
	add r0, r0, #1
	strh r0, [r4, #0x44]
	ldrsh r0, [r4, #0x44]
	cmp r0, #3
	bge _0215BF14
	bl exBossSysAdminTask__Action_FinishLineAttack
	ldmia sp!, {r4, pc}
_0215BF14:
	mov r0, #0
	strh r0, [r4, #0x44]
	bl exBossSysAdminTask__Func_215BFF8
	ldmia sp!, {r4, pc}
_0215BF24:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_Line2

	arm_func_start exBossSysAdminTask__Action_FinishLineAttack
exBossSysAdminTask__Action_FinishLineAttack: // 0x0215BF48
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0
	bl exBossHelpers__SetAnimation
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_2164218
	mov r0, #0x3c
	strh r0, [r4, #0x58]
	bl GetExTaskCurrent
	ldr r1, _0215BF84 // =exBossSysAdminTask__Main_FinishLineAttack
	str r1, [r0]
	bl exBossSysAdminTask__Main_FinishLineAttack
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215BF84: .word exBossSysAdminTask__Main_FinishLineAttack
	arm_func_end exBossSysAdminTask__Action_FinishLineAttack

	arm_func_start exBossSysAdminTask__Main_FinishLineAttack
exBossSysAdminTask__Main_FinishLineAttack: // 0x0215BF88
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	bl exBossSysAdminTask__MoveRandom
	ldrsh r0, [r4, #0x58]
	cmp r0, #0
	bgt _0215BFCC
	mov r1, #0
	add r0, r4, #0x6c
	strh r1, [r4, #0x58]
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215BFD4
	bl exBossSysAdminTask__Action_StartLine0
	ldmia sp!, {r4, pc}
_0215BFCC:
	sub r0, r0, #1
	strh r0, [r4, #0x58]
_0215BFD4:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_FinishLineAttack

	arm_func_start exBossSysAdminTask__Func_215BFF8
exBossSysAdminTask__Func_215BFF8: // 0x0215BFF8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, [r0, #0x548]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exBossSysAdminTask__Func_215BFF8

	arm_func_start exBossMeteBombTask__Func_215C00C
exBossMeteBombTask__Func_215C00C: // 0x0215C00C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _0215C278 // =0x021761CC
	mov r4, r0
	str r4, [r1, #0x14]
	ldr r0, [r1, #0x58]
	cmp r0, #0
	ldrne r0, [r1, #0x24]
	cmpne r0, #0
	beq _0215C088
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _0215C278 // =0x021761CC
	ldr r1, [r1, #0x58]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _0215C278 // =0x021761CC
	ldr r1, [r1, #0x24]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _0215C278 // =0x021761CC
	ldr r1, [r1, #0x58]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_0215C088:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, _0215C278 // =0x021761CC
	ldrsh r0, [r0, #2]
	cmp r0, #0
	bne _0215C14C
	mov r1, #0x15
	ldr r0, _0215C27C // =aExtraExBb_5
	sub r2, r1, #0x16
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _0215C278 // =0x021761CC
	mov r0, r0, lsr #8
	str r0, [r1, #0x58]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _0215C278 // =0x021761CC
	mov r0, r5
	str r1, [r2, #0x4c]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x3c
	bl LoadExSystemFile
	ldr r1, _0215C278 // =0x021761CC
	mov r2, #0
	str r0, [r1, #0x90]
	mov r0, #0x3d
	str r2, [r1, #0x80]
	bl LoadExSystemFile
	ldr r1, _0215C278 // =0x021761CC
	mov r2, #1
	str r0, [r1, #0x94]
	mov r0, #0x3e
	str r2, [r1, #0x84]
	bl LoadExSystemFile
	ldr r1, _0215C278 // =0x021761CC
	mov r2, #3
	str r0, [r1, #0x98]
	mov r0, #0x3f
	str r2, [r1, #0x88]
	bl LoadExSystemFile
	ldr r1, _0215C278 // =0x021761CC
	mov r2, #4
	str r0, [r1, #0x9c]
	str r2, [r1, #0x8c]
	ldr r0, [r1, #0x4c]
	bl Asset3DSetup__Create
_0215C14C:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _0215C278 // =0x021761CC
	str r2, [sp]
	ldr r1, [r0, #0x4c]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, _0215C280 // =0x0217624C
	ldr r5, _0215C284 // =0x0217625C
	mov r7, r8
_0215C184:
	str r7, [sp]
	ldr r1, [r6, r8, lsl #2]
	ldr r2, [r5, r8, lsl #2]
	mov r3, r7
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #4
	blo _0215C184
	ldr r1, _0215C278 // =0x021761CC
	add r0, r4, #0x300
	ldr r2, [r1, #0x80]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x80]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_0215C1D8:
	mov r0, r2, lsl r3
	tst r0, #0x1b
	beq _0215C1F8
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215C1F8:
	add r3, r3, #1
	cmp r3, #5
	blo _0215C1D8
	mov ip, #0
	ldr r0, _0215C288 // =0x0000019A
	str ip, [r4, #0x358]
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r2, _0215C28C // =0x0000BFF4
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, _0215C290 // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #2]
	mov r1, #0x29
	add r2, r4, #0x350
	bic r3, r3, #1
	orr r3, r3, #1
	strb r3, [r4, #2]
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	str ip, [r4, #0x14]
	ldr r1, _0215C278 // =0x021761CC
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #2]
	add r2, r2, #1
	strh r2, [r1, #2]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215C278: .word 0x021761CC
_0215C27C: .word aExtraExBb_5
_0215C280: .word 0x0217624C
_0215C284: .word 0x0217625C
_0215C288: .word 0x0000019A
_0215C28C: .word 0x0000BFF4
_0215C290: .word 0x00007FF8
	arm_func_end exBossMeteBombTask__Func_215C00C

	arm_func_start exBossMeteBombTask__Func_215C294
exBossMeteBombTask__Func_215C294: // 0x0215C294
	stmdb sp!, {r4, lr}
	ldr r1, _0215C348 // =0x021761CC
	mov r4, r0
	ldrsh r0, [r1, #2]
	cmp r0, #1
	bgt _0215C32C
	ldr r0, [r1, #0x4c]
	cmp r0, #0
	beq _0215C2BC
	bl NNS_G3dResDefaultRelease
_0215C2BC:
	ldr r0, _0215C348 // =0x021761CC
	ldr r0, [r0, #0x90]
	cmp r0, #0
	beq _0215C2D0
	bl NNS_G3dResDefaultRelease
_0215C2D0:
	ldr r0, _0215C348 // =0x021761CC
	ldr r0, [r0, #0x94]
	cmp r0, #0
	beq _0215C2E4
	bl NNS_G3dResDefaultRelease
_0215C2E4:
	ldr r0, _0215C348 // =0x021761CC
	ldr r0, [r0, #0x98]
	cmp r0, #0
	beq _0215C2F8
	bl NNS_G3dResDefaultRelease
_0215C2F8:
	ldr r0, _0215C348 // =0x021761CC
	ldr r0, [r0, #0x9c]
	cmp r0, #0
	beq _0215C30C
	bl NNS_G3dResDefaultRelease
_0215C30C:
	ldr r0, _0215C348 // =0x021761CC
	ldr r0, [r0, #0x4c]
	cmp r0, #0
	beq _0215C320
	bl _FreeHEAP_USER
_0215C320:
	ldr r0, _0215C348 // =0x021761CC
	mov r1, #0
	str r1, [r0, #0x4c]
_0215C32C:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _0215C348 // =0x021761CC
	ldrsh r1, [r0, #2]
	sub r1, r1, #1
	strh r1, [r0, #2]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C348: .word 0x021761CC
	arm_func_end exBossMeteBombTask__Func_215C294

	arm_func_start exBossMeteBombTask__Main
exBossMeteBombTask__Main: // 0x0215C34C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _0215C464 // =0x021761CC
	str r0, [r1, #0x50]
	add r0, r4, #0x34
	bl exBossMeteBombTask__Func_215C00C
	add r0, r4, #0x3c0
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x3c0
	bl exDrawReqTask__Func_21641F0
	ldr r1, [r4, #4]
	mov r0, #0
	str r1, [r4, #0x384]
	ldr r1, [r4, #8]
	ldr r6, _0215C468 // =_mt_math_rand
	str r1, [r4, #0x388]
	str r0, [r4, #0x38c]
	ldr r1, [r6, #0]
	ldr r3, _0215C46C // =0x00196225
	ldr ip, _0215C470 // =0x3C6EF35F
	ldr r5, _0215C474 // =0x55555556
	mla r2, r1, r3, ip
	str r2, [r6]
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r1, lsr #0x1f
	rsb r1, r2, r1, lsl #31
	add r1, r2, r1, ror #31
	add r1, r1, #1
	strh r1, [r4, #0x2a]
	ldr r1, [r6, #0]
	mov lr, #3
	mla r2, r1, r3, ip
	str r2, [r6]
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	smull r2, r6, r5, r3
	add r6, r6, r3, lsr #31
	smull r2, r3, lr, r6
	rsb r6, r2, r1, lsr #16
	add r1, r6, #5
	strh r1, [r4, #0x30]
	rsb r1, lr, #0x7d0
	mov r2, #0x66
	str r2, [r4, #0x10]
	str r2, [r4, #0x14]
	str r2, [r4, #0x18]
	str r1, [r4, #0x1c]
	str r1, [r4, #0x20]
	str r0, [r4, #0x24]
	mov r1, #0x78
	strh r1, [r4]
	str r0, [sp]
	mov r1, #0xc2
	str r1, [sp, #4]
	sub r1, r1, #0xc3
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _0215C478 // =exBossMeteBombTask__Main_215C4C8
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215C464: .word 0x021761CC
_0215C468: .word _mt_math_rand
_0215C46C: .word 0x00196225
_0215C470: .word 0x3C6EF35F
_0215C474: .word 0x55555556
_0215C478: .word exBossMeteBombTask__Main_215C4C8
	arm_func_end exBossMeteBombTask__Main

	arm_func_start exBossMeteBombTask__Func8
exBossMeteBombTask__Func8: // 0x0215C47C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0215C4A0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215C4A0: .word ExTask_State_Destroy
	arm_func_end exBossMeteBombTask__Func8

	arm_func_start exBossMeteBombTask__Destructor
exBossMeteBombTask__Destructor: // 0x0215C4A4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0x34
	bl exBossMeteBombTask__Func_215C294
	ldr r0, _0215C4C4 // =0x021761CC
	mov r1, #0
	str r1, [r0, #0x50]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215C4C4: .word 0x021761CC
	arm_func_end exBossMeteBombTask__Destructor

	arm_func_start exBossMeteBombTask__Main_215C4C8
exBossMeteBombTask__Main_215C4C8: // 0x0215C4C8
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x34
	bl exDrawReqTask__Model__Animate
	mov r0, #0xf
	bl exDrawReqTask__Func_2164288
	ldr r2, [r4, #0x39c]
	ldr r1, [r4, #0x10]
	add r0, r4, #0x34
	add r1, r2, r1
	str r1, [r4, #0x39c]
	ldr r2, [r4, #0x3a0]
	ldr r1, [r4, #0x14]
	add r1, r2, r1
	str r1, [r4, #0x3a0]
	ldr r2, [r4, #0x3a4]
	ldr r1, [r4, #0x18]
	add r1, r2, r1
	str r1, [r4, #0x3a4]
	ldr r2, [r4, #0x40]
	ldr r1, [r4, #0x1c]
	add r1, r2, r1
	str r1, [r4, #0x40]
	ldr r2, [r4, #0x44]
	ldr r1, [r4, #0x20]
	add r1, r2, r1
	str r1, [r4, #0x44]
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215C554
	bl GetExTaskCurrent
	ldr r1, _0215C578 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215C554:
	add r0, r4, #0x34
	add r1, r4, #0x3c0
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x34
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C578: .word ExTask_State_Destroy
	arm_func_end exBossMeteBombTask__Main_215C4C8

	arm_func_start exBossMeteBombTask__Create
exBossMeteBombTask__Create: // 0x0215C57C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r5, #0
	mov r4, r0
	str r5, [sp]
	mov r1, #0x510
	str r1, [sp, #4]
	ldr r0, _0215C604 // =aExbossmetebomb
	ldr r1, _0215C608 // =exBossMeteBombTask__Destructor
	str r0, [sp, #8]
	ldr r0, _0215C60C // =exBossMeteBombTask__Main
	mov r2, #0x3100
	mov r3, #5
	str r5, [sp, #0xc]
	bl ExTaskCreate_
	mov r6, r0
	bl GetExTaskWork_
	mov r1, r5
	mov r2, #0x510
	mov r5, r0
	bl MI_CpuFill8
	ldr r1, [r4, #0]
	mov r0, r6
	str r1, [r5, #4]
	ldr r1, [r4, #4]
	str r1, [r5, #8]
	ldr r1, [r4, #8]
	str r1, [r5, #0xc]
	bl GetExTask
	ldr r1, _0215C610 // =exBossMeteBombTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215C604: .word aExbossmetebomb
_0215C608: .word exBossMeteBombTask__Destructor
_0215C60C: .word exBossMeteBombTask__Main
_0215C610: .word exBossMeteBombTask__Func8
	arm_func_end exBossMeteBombTask__Create

	.data
	
aExtraExBb_5: // 0x021742B8
	.asciz "/extra/ex.bb"
	.align 4
	
aExbossmetebomb: // 0x021742C8
	.asciz "exBossMeteBombTask"