	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public exBossSysAdminTask__ActiveInstanceCount
exBossSysAdminTask__ActiveInstanceCount: // 0x02175F54
	.space 0x02

.public exBossSysAdminTask__dword_2175F58
exBossSysAdminTask__dword_2175F58: // 0x02175F58
	.space 0x04

.public exBossSysAdminTask__File_2175F5C
exBossSysAdminTask__File_2175F5C: // 0x02175F5C
	.space 0x04

.public exBossSysAdminTask__unk_2175F60
exBossSysAdminTask__unk_2175F60: // 0x02175F60
	.space 0x04

.public exBossSysAdminTask__FileTable
exBossSysAdminTask__FileTable: // 0x02175F64
	.space 0x04 * 15

.public exBossSysAdminTask__unk_2175FA0
exBossSysAdminTask__unk_2175FA0: // 0x02175FA0
	.space 0x04
	
	.text

	arm_func_start exBossSysAdminTask__LoadAssets
exBossSysAdminTask__LoadAssets: // 0x02154030
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	ldr r1, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	mov r10, r0
	str r10, [r1, #0xc]
	bl InitExDrawRequestModel
	ldr r0, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _021540DC
	ldr r0, _0215435C // =aExtraExBb_0
	mov r1, #2
	mov r2, #0
	bl ReadFileFromBundle
	mov r4, r0
	ldr r0, [r4, #0]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	mov r0, r4
	str r1, [r2, #4]
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	mov r0, #1
	bl LoadExSystemFile
	ldr r1, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r0, [r1, #8]
	ldr r0, [r1, #4]
	bl NNS_G3dResDefaultSetup
	ldr r0, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	ldr r4, [r0, #4]
	mov r0, r4
	bl Asset3DSetup__GetTexSize
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	mov r0, r4
	str r1, [r2, #4]
	bl Asset3DSetup__GetTexture
	mov r0, r4
	bl _FreeHEAP_USER
_021540DC:
	add r0, r10, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r2, [sp]
	ldr r1, [r0, #4]
	mov r3, r2
	add r0, r10, #0x20
	bl AnimatorMDL__SetResource
	mov r0, #4
	strb r0, [r10, #0x2a]
	mov r4, #3
	ldr r1, _02154360 // =exBossSysAdminTask__BossRenderCallback
	add r0, r10, #0xb0
	mov r2, #0
	mov r3, #6
	str r4, [sp]
	bl NNS_G3dRenderObjSetCallBack
	mov r1, #0
	ldr r2, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r1, [sp]
	ldr r2, [r2, #8]
	add r0, r10, #0x20
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	add r0, r10, #0x300
	mov r3, #0
	strh r3, [r0, #0x48]
	ldr r0, [r10, #0x104]
	mov r2, #1
	str r0, [r10, #0x344]
_0215415C:
	mov r0, r2, lsl r3
	tst r0, #1
	beq _0215417C
	add r0, r10, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215417C:
	add r3, r3, #1
	cmp r3, #5
	blo _0215415C
	mov r0, #9
	bl LoadExSystemFile
	ldr r1, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r0, [r1, #0x10]
	mov r0, #0xa
	bl LoadExSystemFile
	ldr r1, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r0, [r1, #0x14]
	mov r0, #0xb
	bl LoadExSystemFile
	ldr r1, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r0, [r1, #0x18]
	mov r0, #0xc
	bl LoadExSystemFile
	ldr r1, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r0, [r1, #0x1c]
	mov r0, #0xd
	bl LoadExSystemFile
	ldr r1, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r0, [r1, #0x20]
	mov r0, #0xe
	bl LoadExSystemFile
	ldr r1, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r0, [r1, #0x24]
	mov r0, #0xf
	bl LoadExSystemFile
	ldr r1, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r0, [r1, #0x28]
	mov r0, #0x10
	bl LoadExSystemFile
	ldr r1, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r0, [r1, #0x2c]
	mov r0, #0x11
	bl LoadExSystemFile
	ldr r1, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r0, [r1, #0x30]
	mov r0, #0x12
	bl LoadExSystemFile
	ldr r1, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r0, [r1, #0x34]
	mov r0, #0x13
	bl LoadExSystemFile
	ldr r1, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r0, [r1, #0x38]
	mov r0, #0x14
	bl LoadExSystemFile
	ldr r1, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r0, [r1, #0x3c]
	mov r0, #0x15
	bl LoadExSystemFile
	ldr r1, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r0, [r1, #0x40]
	mov r0, #0x16
	bl LoadExSystemFile
	ldr r1, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	str r0, [r1, #0x44]
	mov r0, #0x17
	bl LoadExSystemFile
	ldr r4, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	mov r8, #0
	ldr r7, _02154364 // =_02173F4C
	ldr r5, _02154368 // =0x02175F64
	str r0, [r4, #0x48]
	add r9, r10, #0x164
	mov r6, #5
	mov r11, r8
_02154290:
	ldr r0, [r4, #4]
	bl NNS_G3dGetTex
	ldr r1, [r7, r8, lsl #2]
	bl Asset3DSetup__PaletteFromName
	str r6, [sp]
	str r0, [sp, #4]
	ldr r1, [r5, r8, lsl #2]
	mov r0, r9
	mov r2, r11
	mov r3, #2
	bl InitPaletteAnimator
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, asr #0x10
	add r9, r9, #0x20
	cmp r8, #0xf
	blt _02154290
	mov r0, #0x1000
	str r0, [r10, #0x368]
	str r0, [r10, #0x36c]
	ldr r1, _0215436C // =0x00003FFC
	str r0, [r10, #0x370]
	add r0, r10, #0x300
	strh r1, [r0, #0x4a]
	mov r0, #1
	strb r0, [r10]
	ldrb r2, [r10, #1]
	mov r1, #0
	mov r0, #0xc000
	bic r2, r2, #1
	orr r2, r2, #1
	strb r2, [r10, #1]
	str r1, [r10, #0x35c]
	str r1, [r10, #0x360]
	str r1, [r10, #0x364]
	str r0, [r10, #0xc]
	str r0, [r10, #0x10]
	str r1, [r10, #0x14]
	add r0, r10, #0x35c
	str r0, [r10, #0x18]
	ldrb r1, [r10, #0x38c]
	ldr r0, _02154358 // =exBossSysAdminTask__ActiveInstanceCount
	bic r1, r1, #3
	orr r1, r1, #2
	strb r1, [r10, #0x38c]
	ldrsh r1, [r0, #0]
	add r1, r1, #1
	strh r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02154358: .word exBossSysAdminTask__ActiveInstanceCount
_0215435C: .word aExtraExBb_0
_02154360: .word exBossSysAdminTask__BossRenderCallback
_02154364: .word _02173F4C
_02154368: .word 0x02175F64
_0215436C: .word 0x00003FFC
	arm_func_end exBossSysAdminTask__LoadAssets

	arm_func_start exBossSysAdminTask__SetAnimation
exBossSysAdminTask__SetAnimation: // 0x02154370
	stmdb sp!, {r3, lr}
	ldr r2, _0215438C // =exBossSysAdminTask__ActiveInstanceCount
	str r1, [sp]
	ldmib r2, {r1, r3}
	mov r2, #0
	bl exPlayerHelpers__SetAnimationInternal
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215438C: .word exBossSysAdminTask__ActiveInstanceCount
	arm_func_end exBossSysAdminTask__SetAnimation

	arm_func_start exBossSysAdminTask__Func_2154390
exBossSysAdminTask__Func_2154390: // 0x02154390
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _02154418 // =exBossSysAdminTask__ActiveInstanceCount
	mov r4, r0
	ldrsh r0, [r1, #0]
	cmp r0, #1
	bgt _021543D4
	ldr r0, [r1, #4]
	cmp r0, #0
	beq _021543B8
	bl NNS_G3dResDefaultRelease
_021543B8:
	ldr r1, _02154418 // =exBossSysAdminTask__ActiveInstanceCount
	ldr r0, [r1, #4]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r1, #4]
	beq _021543D4
	bl _FreeHEAP_USER
_021543D4:
	add r6, r4, #0x164
	mov r5, #0
_021543DC:
	mov r0, r6
	bl ReleasePaletteAnimator
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, asr #0x10
	cmp r5, #0xf
	add r6, r6, #0x20
	blt _021543DC
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _02154418 // =exBossSysAdminTask__ActiveInstanceCount
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02154418: .word exBossSysAdminTask__ActiveInstanceCount
	arm_func_end exBossSysAdminTask__Func_2154390

	arm_func_start exBossSysAdminTask__GetBossAssets
exBossSysAdminTask__GetBossAssets: // 0x0215441C
	ldr r0, _02154428 // =exBossSysAdminTask__ActiveInstanceCount
	ldr r0, [r0, #0xc]
	bx lr
	.align 2, 0
_02154428: .word exBossSysAdminTask__ActiveInstanceCount
	arm_func_end exBossSysAdminTask__GetBossAssets

	arm_func_start exBossSysAdminTask__BossRenderCallback
exBossSysAdminTask__BossRenderCallback: // 0x0215442C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #4]
	ldr r1, _021544D4 // =aEffect
	ldr r0, [r0, #4]
	add r0, r0, #0x40
	bl NNS_G3dGetResDictIdxByName
	ldr r1, [r4, #8]
	tst r1, #0x10
	ldrneb r1, [r4, #0xae]
	mvneq r1, #0
	cmp r0, r1
	bne _02154484
	mov r3, #0x1e
	add r1, sp, #4
	mov r0, #0x13
	mov r2, #1
	str r3, [sp, #4]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02154484:
	ldr r0, [r4, #4]
	ldr r1, _021544D8 // =aChest
	ldr r0, [r0, #4]
	add r0, r0, #0x40
	bl NNS_G3dGetResDictIdxByName
	ldr r1, [r4, #8]
	tst r1, #0x10
	ldrneb r1, [r4, #0xae]
	mvneq r1, #0
	cmp r0, r1
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	mov r3, #0x1d
	add r1, sp, #0
	mov r0, #0x13
	mov r2, #1
	str r3, [sp]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021544D4: .word aEffect
_021544D8: .word aChest
	arm_func_end exBossSysAdminTask__BossRenderCallback

	arm_func_start exBossSysAdminTask__Action_StartDmg0
exBossSysAdminTask__Action_StartDmg0: // 0x021544DC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0x17
	bl exBossSysAdminTask__SetAnimation
	add r0, r4, #0x3f8
	bl SetExDrawRequestAnimStopOnFinish
	bl GetExTaskCurrent
	ldr r1, _02154510 // =exBossSysAdminTask__Main_Dmg0
	str r1, [r0]
	bl exBossSysAdminTask__Main_Dmg0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02154510: .word exBossSysAdminTask__Main_Dmg0
	arm_func_end exBossSysAdminTask__Action_StartDmg0

	arm_func_start exBossSysAdminTask__Main_Dmg0
exBossSysAdminTask__Main_Dmg0: // 0x02154514
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl AnimateExDrawRequestModel
	add r0, r4, #0x6c
	bl IsExDrawRequestModelAnimFinished
	cmp r0, #0
	beq _02154540
	bl exBossSysAdminTask__Action_StartDmg1
	ldmia sp!, {r4, pc}
_02154540:
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl AddExDrawRequest
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_Dmg0

	arm_func_start exBossSysAdminTask__Action_StartDmg1
exBossSysAdminTask__Action_StartDmg1: // 0x02154550
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0x18
	bl exBossSysAdminTask__SetAnimation
	add r0, r4, #0x3f8
	bl SetExDrawRequestAnimStopOnFinish
	bl GetExTaskCurrent
	ldr r1, _02154584 // =exBossSysAdminTask__Main_Dmg1
	str r1, [r0]
	bl exBossSysAdminTask__Main_Dmg1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02154584: .word exBossSysAdminTask__Main_Dmg1
	arm_func_end exBossSysAdminTask__Action_StartDmg1

	arm_func_start exBossSysAdminTask__Main_Dmg1
exBossSysAdminTask__Main_Dmg1: // 0x02154588
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl AnimateExDrawRequestModel
	add r0, r4, #0x6c
	bl IsExDrawRequestModelAnimFinished
	cmp r0, #0
	beq _021545B4
	bl exBossSysAdminTask__Action_FinishDmg
	ldmia sp!, {r4, pc}
_021545B4:
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl AddExDrawRequest
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_Dmg1

	arm_func_start exBossSysAdminTask__Action_FinishDmg
exBossSysAdminTask__Action_FinishDmg: // 0x021545C4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrb r1, [r0, #0x72]
	bic r2, r1, #1
	and r1, r2, #0xff
	bic r1, r1, #2
	strb r1, [r0, #0x72]
	ldr r0, [r0, #0x548]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exBossSysAdminTask__Action_FinishDmg

	arm_func_start exBossSysAdminTask__Action_StartBDmg0
exBossSysAdminTask__Action_StartBDmg0: // 0x021545EC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0x19
	bl exBossSysAdminTask__SetAnimation
	add r0, r4, #0x3f8
	bl SetExDrawRequestAnimStopOnFinish
	mov r0, #1
	bl exBossSysAdminTask__SetBossFleeing
	bl GetExTaskCurrent
	ldr r1, _02154628 // =exBossSysAdminTask__Main_BDmg0
	str r1, [r0]
	bl exBossSysAdminTask__Main_BDmg0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02154628: .word exBossSysAdminTask__Main_BDmg0
	arm_func_end exBossSysAdminTask__Action_StartBDmg0

	arm_func_start exBossSysAdminTask__Main_BDmg0
exBossSysAdminTask__Main_BDmg0: // 0x0215462C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl AnimateExDrawRequestModel
	add r0, r4, #0x6c
	bl IsExDrawRequestModelAnimFinished
	cmp r0, #0
	beq _02154658
	bl exBossSysAdminTask__Func_2154668
	ldmia sp!, {r4, pc}
_02154658:
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl AddExDrawRequest
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_BDmg0

	arm_func_start exBossSysAdminTask__Func_2154668
exBossSysAdminTask__Func_2154668: // 0x02154668
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #0xc8000
	str r1, [r0, #0x3c0]
	bl GetExTaskCurrent
	ldr r1, _0215468C // =exBossSysAdminTask__Func_2154690
	str r1, [r0]
	bl exBossSysAdminTask__Func_2154690
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215468C: .word exBossSysAdminTask__Func_2154690
	arm_func_end exBossSysAdminTask__Func_2154668

	arm_func_start exBossSysAdminTask__Func_2154690
exBossSysAdminTask__Func_2154690: // 0x02154690
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exBossSysAdminTask__IsBossFleeing
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl exBossSysAdminTask__Func_21546AC
	ldmia sp!, {r3, pc}
	arm_func_end exBossSysAdminTask__Func_2154690

	arm_func_start exBossSysAdminTask__Func_21546AC
exBossSysAdminTask__Func_21546AC: // 0x021546AC
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, _021546C8 // =exBossSysAdminTask__Func_21546CC
	str r1, [r0]
	bl exBossSysAdminTask__Func_21546CC
	ldmia sp!, {r3, pc}
	.align 2, 0
_021546C8: .word exBossSysAdminTask__Func_21546CC
	arm_func_end exBossSysAdminTask__Func_21546AC

	arm_func_start exBossSysAdminTask__Func_21546CC
exBossSysAdminTask__Func_21546CC: // 0x021546CC
	stmdb sp!, {r4, r5, r6, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl AnimateExDrawRequestModel
	bl HandleExBossMovement
	bl GetExBossWork
	ldrsh r2, [r0, #0x64]
	ldr r1, _02154754 // =0x55555556
	smull r0, r3, r1, r2
	add r3, r3, r2, lsr #31
	mov r5, r3, lsl #0x11
	mov r6, r5, asr #0x10
	bl GetExBossWork
	ldrsh r0, [r0, #0x62]
	cmp r0, r5, asr #16
	bge _02154724
	bl GetExBossWork
	ldrsh r1, [r0, #0x62]
	add r1, r1, #1
	strh r1, [r0, #0x62]
	b _02154744
_02154724:
	bl GetExBossWork
	add r1, r6, #1
	strh r1, [r0, #0x62]
	ldr r0, [r4, #0x3c0]
	cmp r0, #0x64000
	bgt _02154744
	bl exBossSysAdminTask__Func_2154758
	ldmia sp!, {r4, r5, r6, pc}
_02154744:
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl AddExDrawRequest
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02154754: .word 0x55555556
	arm_func_end exBossSysAdminTask__Func_21546CC

	arm_func_start exBossSysAdminTask__Func_2154758
exBossSysAdminTask__Func_2154758: // 0x02154758
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrb r0, [r4, #0x72]
	bic r1, r0, #1
	and r0, r1, #0xff
	bic r0, r0, #2
	strb r0, [r4, #0x72]
	bl GetExSystemStatus
	mov r1, #8
	strb r1, [r0, #3]
	ldrb r0, [r4, #2]
	orr r0, r0, #0x40
	strb r0, [r4, #2]
	ldr r0, [r4, #0x548]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Func_2154758

	arm_func_start exBossSysAdminTask__Action_StartBDmg1_Last
exBossSysAdminTask__Action_StartBDmg1_Last: // 0x0215479C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0x1a
	bl exBossSysAdminTask__SetAnimation
	add r0, r4, #0x3f8
	bl SetExDrawRequestAnimStopOnFinish
	mov r0, #1
	bl exBossSysAdminTask__SetBossFleeing
	bl GetExTaskCurrent
	ldr r1, _021547D8 // =exBossSysAdminTask__Main_BDmg1_Last
	str r1, [r0]
	bl exBossSysAdminTask__Main_BDmg1_Last
	ldmia sp!, {r4, pc}
	.align 2, 0
_021547D8: .word exBossSysAdminTask__Main_BDmg1_Last
	arm_func_end exBossSysAdminTask__Action_StartBDmg1_Last

	arm_func_start exBossSysAdminTask__Main_BDmg1_Last
exBossSysAdminTask__Main_BDmg1_Last: // 0x021547DC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl AnimateExDrawRequestModel
	add r0, r4, #0x6c
	bl IsExDrawRequestModelAnimFinished
	cmp r0, #0
	beq _02154808
	bl exBossSysAdminTask__Func_2154818
	ldmia sp!, {r4, pc}
_02154808:
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl AddExDrawRequest
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_BDmg1_Last

	arm_func_start exBossSysAdminTask__Func_2154818
exBossSysAdminTask__Func_2154818: // 0x02154818
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #0xc8000
	str r1, [r0, #0x3c0]
	mov r0, #0
	sub r1, r0, #1
	mov ip, #0x17
	mov r2, r1
	mov r3, r1
	str ip, [sp]
	bl PlayTrack
	bl GetExTaskCurrent
	ldr r1, _02154858 // =exBossSysAdminTask__Func_215485C
	str r1, [r0]
	bl exBossSysAdminTask__Func_215485C
	ldmia sp!, {r3, pc}
	.align 2, 0
_02154858: .word exBossSysAdminTask__Func_215485C
	arm_func_end exBossSysAdminTask__Func_2154818

	arm_func_start exBossSysAdminTask__Func_215485C
exBossSysAdminTask__Func_215485C: // 0x0215485C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exBossSysAdminTask__IsBossFleeing
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl exBossSysAdminTask__Func_2154878
	ldmia sp!, {r3, pc}
	arm_func_end exBossSysAdminTask__Func_215485C

	arm_func_start exBossSysAdminTask__Func_2154878
exBossSysAdminTask__Func_2154878: // 0x02154878
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, _02154894 // =exBossSysAdminTask__Func_2154898
	str r1, [r0]
	bl exBossSysAdminTask__Func_2154898
	ldmia sp!, {r3, pc}
	.align 2, 0
_02154894: .word exBossSysAdminTask__Func_2154898
	arm_func_end exBossSysAdminTask__Func_2154878

	arm_func_start exBossSysAdminTask__Func_2154898
exBossSysAdminTask__Func_2154898: // 0x02154898
	stmdb sp!, {r4, r5, r6, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl AnimateExDrawRequestModel
	bl HandleExBossMovement
	bl GetExBossWork
	ldrsh r2, [r0, #0x64]
	ldr r1, _02154920 // =0x55555556
	smull r0, r3, r1, r2
	add r3, r3, r2, lsr #31
	mov r5, r3, lsl #0x10
	mov r6, r5, asr #0x10
	bl GetExBossWork
	ldrsh r0, [r0, #0x62]
	cmp r0, r5, asr #16
	bge _021548F0
	bl GetExBossWork
	ldrsh r1, [r0, #0x62]
	add r1, r1, #1
	strh r1, [r0, #0x62]
	b _02154910
_021548F0:
	bl GetExBossWork
	add r1, r6, #1
	strh r1, [r0, #0x62]
	ldr r0, [r4, #0x3c0]
	cmp r0, #0x64000
	bgt _02154910
	bl exBossSysAdminTask__Func_2154924
	ldmia sp!, {r4, r5, r6, pc}
_02154910:
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl AddExDrawRequest
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02154920: .word 0x55555556
	arm_func_end exBossSysAdminTask__Func_2154898

	arm_func_start exBossSysAdminTask__Func_2154924
exBossSysAdminTask__Func_2154924: // 0x02154924
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrb r0, [r4, #0x72]
	bic r1, r0, #1
	and r0, r1, #0xff
	bic r0, r0, #2
	strb r0, [r4, #0x72]
	bl GetExSystemStatus
	mov r1, #0xa
	strb r1, [r0, #3]
	ldrb r0, [r4, #2]
	orr r0, r0, #0x80
	strb r0, [r4, #2]
	ldr r0, [r4, #0x548]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Func_2154924

	arm_func_start exBossSysAdminTask__Action_StartBDmg1_First
exBossSysAdminTask__Action_StartBDmg1_First: // 0x02154968
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0x1a
	bl exBossSysAdminTask__SetAnimation
	add r0, r4, #0x3f8
	bl SetExDrawRequestAnimStopOnFinish
	mov r0, #1
	bl exBossSysAdminTask__SetBossFleeing
	bl GetExTaskCurrent
	ldr r1, _021549A4 // =exBossSysAdminTask__Main_BDmg1_First
	str r1, [r0]
	bl exBossSysAdminTask__Main_BDmg1_First
	ldmia sp!, {r4, pc}
	.align 2, 0
_021549A4: .word exBossSysAdminTask__Main_BDmg1_First
	arm_func_end exBossSysAdminTask__Action_StartBDmg1_First

	arm_func_start exBossSysAdminTask__Main_BDmg1_First
exBossSysAdminTask__Main_BDmg1_First: // 0x021549A8
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl AnimateExDrawRequestModel
	add r0, r4, #0x6c
	bl IsExDrawRequestModelAnimFinished
	cmp r0, #0
	beq _021549D4
	bl exBossSysAdminTask__Action_21549E4
	ldmia sp!, {r4, pc}
_021549D4:
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl AddExDrawRequest
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_BDmg1_First

	arm_func_start exBossSysAdminTask__Action_21549E4
exBossSysAdminTask__Action_21549E4: // 0x021549E4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, _02154A00 // =exBossSysAdminTask__Func_2154A04
	str r1, [r0]
	bl exBossSysAdminTask__Func_2154A04
	ldmia sp!, {r3, pc}
	.align 2, 0
_02154A00: .word exBossSysAdminTask__Func_2154A04
	arm_func_end exBossSysAdminTask__Action_21549E4

	arm_func_start exBossSysAdminTask__Func_2154A04
exBossSysAdminTask__Func_2154A04: // 0x02154A04
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exBossSysAdminTask__IsBossFleeing
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl exBossSysAdminTask__Func_2154A20
	ldmia sp!, {r3, pc}
	arm_func_end exBossSysAdminTask__Func_2154A04

	arm_func_start exBossSysAdminTask__Func_2154A20
exBossSysAdminTask__Func_2154A20: // 0x02154A20
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #0xc8000
	str r1, [r0, #0x3c0]
	bl GetExTaskCurrent
	ldr r1, _02154A44 // =exBossSysAdminTask__Func_2154A48
	str r1, [r0]
	bl exBossSysAdminTask__Func_2154A48
	ldmia sp!, {r3, pc}
	.align 2, 0
_02154A44: .word exBossSysAdminTask__Func_2154A48
	arm_func_end exBossSysAdminTask__Func_2154A20

	arm_func_start exBossSysAdminTask__Func_2154A48
exBossSysAdminTask__Func_2154A48: // 0x02154A48
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl AnimateExDrawRequestModel
	bl HandleExBossMovement
	ldr r0, [r4, #0x3c0]
	cmp r0, #0x64000
	bgt _02154A74
	bl exBossSysAdminTask__Func_2154AD0
	ldmia sp!, {r4, pc}
_02154A74:
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02154AC0
	ldrb r1, [r4, #0]
	mov r0, r1, lsl #0x1b
	movs r0, r0, lsr #0x1f
	add r0, r0, #1
	and r0, r0, #0xff
	bic r1, r1, #0x10
	mov r0, r0, lsl #0x1f
	orr r0, r1, r0, lsr #27
	strb r0, [r4]
	add r0, r4, #0x3f8
	beq _02154AB8
	mov r1, #4
	bl SetExDrawLightType
	b _02154AC0
_02154AB8:
	mov r1, #7
	bl SetExDrawLightType
_02154AC0:
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl AddExDrawRequest
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Func_2154A48

	arm_func_start exBossSysAdminTask__Func_2154AD0
exBossSysAdminTask__Func_2154AD0: // 0x02154AD0
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #1
	strh r1, [r0, #0x58]
	bl GetExTaskCurrent
	ldr r1, _02154AF4 // =exBossSysAdminTask__Func_2154AF8
	str r1, [r0]
	bl exBossSysAdminTask__Func_2154AF8
	ldmia sp!, {r3, pc}
	.align 2, 0
_02154AF4: .word exBossSysAdminTask__Func_2154AF8
	arm_func_end exBossSysAdminTask__Func_2154AD0

	arm_func_start exBossSysAdminTask__Func_2154AF8
exBossSysAdminTask__Func_2154AF8: // 0x02154AF8
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl AnimateExDrawRequestModel
	ldrsh r0, [r4, #0x58]
	cmp r0, #0
	bgt _02154B28
	mov r0, #0
	strh r0, [r4, #0x58]
	bl exBossSysAdminTask__Func_2154B8C
	ldmia sp!, {r4, pc}
_02154B28:
	sub r0, r0, #1
	strh r0, [r4, #0x58]
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02154B7C
	ldrb r1, [r4, #0]
	mov r0, r1, lsl #0x1b
	movs r0, r0, lsr #0x1f
	add r0, r0, #1
	and r0, r0, #0xff
	bic r1, r1, #0x10
	mov r0, r0, lsl #0x1f
	orr r0, r1, r0, lsr #27
	strb r0, [r4]
	add r0, r4, #0x3f8
	beq _02154B74
	mov r1, #4
	bl SetExDrawLightType
	b _02154B7C
_02154B74:
	mov r1, #7
	bl SetExDrawLightType
_02154B7C:
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl AddExDrawRequest
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Func_2154AF8

	arm_func_start exBossSysAdminTask__Func_2154B8C
exBossSysAdminTask__Func_2154B8C: // 0x02154B8C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExSystemStatus
	mov r1, #2
	strb r1, [r0, #1]
	bl GetExTaskCurrent
	ldr r1, _02154BB4 // =exBossSysAdminTask__Func_2154BB8
	str r1, [r0]
	bl exBossSysAdminTask__Func_2154BB8
	ldmia sp!, {r3, pc}
	.align 2, 0
_02154BB4: .word exBossSysAdminTask__Func_2154BB8
	arm_func_end exBossSysAdminTask__Func_2154B8C

	arm_func_start exBossSysAdminTask__Func_2154BB8
exBossSysAdminTask__Func_2154BB8: // 0x02154BB8
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl AnimateExDrawRequestModel
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02154C18
	ldrb r1, [r4, #0]
	mov r0, r1, lsl #0x1b
	movs r0, r0, lsr #0x1f
	add r0, r0, #1
	and r0, r0, #0xff
	bic r1, r1, #0x10
	mov r0, r0, lsl #0x1f
	orr r0, r1, r0, lsr #27
	strb r0, [r4]
	add r0, r4, #0x3f8
	beq _02154C10
	mov r1, #4
	bl SetExDrawLightType
	b _02154C18
_02154C10:
	mov r1, #7
	bl SetExDrawLightType
_02154C18:
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl AddExDrawRequest
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Func_2154BB8

	arm_func_start exBossSysAdminTask__IsBossFleeing
exBossSysAdminTask__IsBossFleeing: // 0x02154C28
	ldr r0, _02154C34 // =0x02175FA0
	ldr r0, [r0, #0]
	bx lr
	.align 2, 0
_02154C34: .word 0x02175FA0
	arm_func_end exBossSysAdminTask__IsBossFleeing

	arm_func_start exBossSysAdminTask__SetBossFleeing
exBossSysAdminTask__SetBossFleeing: // 0x02154C38
	ldr r1, _02154C44 // =0x02175FA0
	str r0, [r1]
	bx lr
	.align 2, 0
_02154C44: .word 0x02175FA0
	arm_func_end exBossSysAdminTask__SetBossFleeing
	
	.rodata

// NNSG3dResName aEffect
.public aEffect
aEffect: // 0x02173E20
	.asciz "effect"
	.align 4
	.word 0x00, 0x00
	.align 4

// NNSG3dResName aChest
.public aChest
aChest: // 0x02173E30
	.asciz "chest"
	.align 4
	.word 0x00, 0x00
	.align 4

	.data

aExBlPl: // 0x02173E84
	.asciz "ex_bl_pl"
	.align 4
	
aExArmPl: // 0x02173E90
	.asciz "ex_arm_pl"
	.align 4

aExEyePl: // 0x02173E9C
	.asciz "ex_eye_pl"
	.align 4
	
aExSetuPl: // 0x02173EA8
	.asciz "ex_setu_pl"
	.align 4
	
aExSidePl: // 0x02173EB4
	.asciz "ex_side_pl"
	.align 4
	
aExBackPl: // 0x02173EC0
	.asciz "ex_back_pl"
	.align 4
	
aExTunoPl: // 0x02173ECC
	.asciz "ex_tuno_pl"
	.align 4
	
aExHandPl: // 0x02173ED8
	.asciz "ex_hand_pl"
	.align 4
	
aExMagaPl: // 0x02173EE4
	.asciz "ex_maga_pl"
	.align 4
	
aExPipePl: // 0x02173EF0
	.asciz "ex_pipe_pl"
	.align 4
	
aExStomacPl: // 0x02173EFC
	.asciz "ex_stomac_pl"
	.align 4
	
aExEnginePl: // 0x02173F0C
	.asciz "ex_engine_pl"
	.align 4
	
aExArmTopPl: // 0x02173F1C
	.asciz "ex_arm_top_pl"
	.align 4
	
aExTueTopPl: // 0x02173F2C
	.asciz "ex_tue_top_pl"
	.align 4
	
aExUnderBPl: // 0x02173F3C
	.asciz "ex_under_b_pl"
	.align 4

_02173F4C:
	.word aExArmPl            // "ex_arm_pl"
	.word aExArmTopPl         // "ex_arm_top_pl"
	.word aExBackPl           // "ex_back_pl"
	.word aExBlPl             // "ex_bl_pl"
	.word aExEnginePl         // "ex_engine_pl"
	.word aExEyePl            // "ex_eye_pl"
	.word aExHandPl           // "ex_hand_pl"
	.word aExMagaPl           // "ex_maga_pl"
	.word aExPipePl           // "ex_pipe_pl"
	.word aExSetuPl           // "ex_setu_pl"
	.word aExSidePl           // "ex_side_pl"
	.word aExStomacPl         // "ex_stomac_pl"
	.word aExTueTopPl         // "ex_tue_top_pl"
	.word aExTunoPl           // "ex_tuno_pl"
	.word aExUnderBPl         // "ex_under_b_pl"

aExtraExBb_0: // 0x02173F88
	.asciz "/extra/ex.bb"