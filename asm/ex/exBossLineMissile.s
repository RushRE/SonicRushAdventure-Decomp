	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

exBossLineNeedleTask__ActiveInstanceCount: // 0x02176188
	.space 0x02

exBossLineMissileTask__ActiveInstanceCount: // 0x0217618A
	.space 0x02

	.align 4

exBossLineMissileTask__FileTable: // 0x0217618C
    .space 0x04
	
exBossLineMissileTask__TaskSingleton: // 0x02176190
    .space 0x04
	
exBossLineMissileTask__unk_2176194: // 0x02176194
    .space 0x04
	
exBossLineMissileTask__dword_2176198: // 0x02176198
    .space 0x04
	
exBossLineMissileTask__AnimTable: // 0x0217619C
    .space 0x04

exBossLineNeedleTask__unk_21761A0: // 0x021761A0
    .space 0x04
	
exBossLineMissileTask__unk_21761A4: // 0x021761A4
    .space 0x04
	
exBossLineMissileTask__unk_21761A8: // 0x021761A8
    .space 0x04
	
exBossLineNeedleTask__TaskSingleton: // 0x021761AC
    .space 0x04
	
exBossLineNeedleTask__unk_21761B0: // 0x021761B0
    .space 0x04
	
exBossLineNeedleTask__unk_21761B4: // 0x021761B4
    .space 0x04
	
exBossLineNeedleTask__unk_21761B8: // 0x021761B8
    .space 0x04
	
exBossLineNeedleTask__AnimTable: // 0x021761BC
    .space 0x04

exBossLineNeedleTask__dword_21761C0: // 0x021761C0
    .space 0x04
	
exBossLineNeedleTask__FileTable: // 0x021761C4
    .space 0x04
	
exBossLineMissileTask__unk_21761C8: // 0x021761C8
    .space 0x04

	.text

	arm_func_start exBossSysAdminTask__Action_StartHomi0
exBossSysAdminTask__Action_StartHomi0: // 0x0215A708
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #9
	bl exBossHelpers__SetAnimation
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_21641F0
	bl exBossEffectHomingTask__Create
	mov r0, #0
	str r0, [sp]
	mov r1, #0x104
	str r1, [sp, #4]
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	bl GetExTaskCurrent
	ldr r1, _0215A768 // =exBossSysAdminTask__Main_StartHomi0
	str r1, [r0]
	bl exBossSysAdminTask__Main_StartHomi0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215A768: .word exBossSysAdminTask__Main_StartHomi0
	arm_func_end exBossSysAdminTask__Action_StartHomi0

	arm_func_start exBossSysAdminTask__Main_StartHomi0
exBossSysAdminTask__Main_StartHomi0: // 0x0215A76C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	ldr r0, [r4, #0x3b0]
	ldr r0, [r0, #0]
	cmp r0, #0x1e000
	blt _0215A7C8
	mov ip, #0xc9
	sub r1, ip, #0xca
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _0215A7F0 // =exBossSysAdminTask__Main_FinishHomi0
	str r1, [r0]
	bl exBossSysAdminTask__Main_FinishHomi0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215A7C8:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215A7F0: .word exBossSysAdminTask__Main_FinishHomi0
	arm_func_end exBossSysAdminTask__Main_StartHomi0

	arm_func_start exBossSysAdminTask__Main_FinishHomi0
exBossSysAdminTask__Main_FinishHomi0: // 0x0215A7F4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215A820
	bl exBossSysAdminTask__Action_StartHomi1
	ldmia sp!, {r4, pc}
_0215A820:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_FinishHomi0

	arm_func_start exBossSysAdminTask__Action_StartHomi1
exBossSysAdminTask__Action_StartHomi1: // 0x0215A844
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0xa
	bl exBossHelpers__SetAnimation
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _0215A878 // =exBossSysAdminTask__Main_StartHomi1
	str r1, [r0]
	bl exBossSysAdminTask__Main_StartHomi1
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215A878: .word exBossSysAdminTask__Main_StartHomi1
	arm_func_end exBossSysAdminTask__Action_StartHomi1

	arm_func_start exBossSysAdminTask__Main_StartHomi1
exBossSysAdminTask__Main_StartHomi1: // 0x0215A87C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	ldr r0, [r4, #0x3b0]
	ldr r0, [r0, #0]
	cmp r0, #0xa000
	blt _0215A8FC
	mov r5, #0
_0215A8A8:
	strh r5, [r4, #0x66]
	bl exBossHomingLaserTask__Create
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #6
	blo _0215A8A8
	mov ip, #0xc5
	sub r1, ip, #0xc6
	mov r0, #0
	strh r0, [r4, #0x66]
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _0215A940 // =exBossSysAdminTask__Main_FinishHomi1
	str r1, [r0]
	bl exBossSysAdminTask__Main_FinishHomi1
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_0215A8FC:
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215A918
	bl exBossSysAdminTask__Action_StartHomi2
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_0215A918:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215A940: .word exBossSysAdminTask__Main_FinishHomi1
	arm_func_end exBossSysAdminTask__Main_StartHomi1

	arm_func_start exBossSysAdminTask__Main_FinishHomi1
exBossSysAdminTask__Main_FinishHomi1: // 0x0215A944
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215A970
	bl exBossSysAdminTask__Action_StartHomi2
	ldmia sp!, {r4, pc}
_0215A970:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_FinishHomi1

	arm_func_start exBossSysAdminTask__Action_StartHomi2
exBossSysAdminTask__Action_StartHomi2: // 0x0215A994
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exBossEffectShotTask__Func_215753C
	add r0, r4, #0x6c
	mov r1, #0xb
	bl exBossHelpers__SetAnimation
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _0215A9CC // =exBossSysAdminTask__Main_StartHomi2
	str r1, [r0]
	bl exBossSysAdminTask__Main_StartHomi2
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215A9CC: .word exBossSysAdminTask__Main_StartHomi2
	arm_func_end exBossSysAdminTask__Action_StartHomi2

	arm_func_start exBossSysAdminTask__Main_StartHomi2
exBossSysAdminTask__Main_StartHomi2: // 0x0215A9D0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215A9FC
	bl exBossSysAdminTask__Action_FinishHomingAttack
	ldmia sp!, {r4, pc}
_0215A9FC:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_StartHomi2

	arm_func_start exBossSysAdminTask__Action_FinishHomingAttack
exBossSysAdminTask__Action_FinishHomingAttack: // 0x0215AA20
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, [r0, #0x548]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exBossSysAdminTask__Action_FinishHomingAttack

	arm_func_start exBossLineNeedleTask__Func_215AA34
exBossLineNeedleTask__Func_215AA34: // 0x0215AA34
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _0215AC3C // =exBossLineNeedleTask__ActiveInstanceCount
	mov r4, r0
	str r4, [r1, #0x18]
	ldr r0, [r1, #0x2c]
	cmp r0, #0
	ldrne r0, [r1, #0x28]
	cmpne r0, #0
	beq _0215AAA0
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _0215AC3C // =exBossLineNeedleTask__ActiveInstanceCount
	ldr r1, [r1, #0x2c]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _0215AC3C // =exBossLineNeedleTask__ActiveInstanceCount
	ldr r1, [r1, #0x28]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _0215AC3C // =exBossLineNeedleTask__ActiveInstanceCount
	ldr r1, [r1, #0x2c]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
_0215AAA0:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, _0215AC3C // =exBossLineNeedleTask__ActiveInstanceCount
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _0215AB1C
	mov r1, #0x19
	ldr r0, _0215AC40 // =aExtraExBb_4
	sub r2, r1, #0x1a
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _0215AC3C // =exBossLineNeedleTask__ActiveInstanceCount
	mov r0, r0, lsr #8
	str r0, [r1, #0x2c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _0215AC3C // =exBossLineNeedleTask__ActiveInstanceCount
	mov r0, r5
	str r1, [r2, #0x38]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x44
	bl LoadExSystemFile
	ldr r1, _0215AC3C // =exBossLineNeedleTask__ActiveInstanceCount
	mov r2, #2
	str r0, [r1, #0x3c]
	str r2, [r1, #0x34]
	ldr r0, [r1, #0x38]
	bl Asset3DSetup__Create
_0215AB1C:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _0215AC3C // =exBossLineNeedleTask__ActiveInstanceCount
	str r2, [sp]
	ldr r1, [r0, #0x38]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	ldr r0, _0215AC3C // =exBossLineNeedleTask__ActiveInstanceCount
	ldr r0, [r0, #0x38]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r2, _0215AC3C // =exBossLineNeedleTask__ActiveInstanceCount
	add r0, r4, #0x20
	ldr r1, [r2, #0x34]
	ldr r2, [r2, #0x3c]
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	ldr r1, _0215AC3C // =exBossLineNeedleTask__ActiveInstanceCount
	add r0, r4, #0x300
	ldr r2, [r1, #0x34]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x34]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_0215AB94:
	mov r0, r2, lsl r3
	tst r0, #4
	beq _0215ABB4
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215ABB4:
	add r3, r3, #1
	cmp r3, #5
	blo _0215AB94
	mov r0, #0
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r1, _0215AC44 // =0x00003FFC
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
	ldrb r1, [r4, #0x38c]
	mov r0, #1
	mov r3, #0x6000
	bic r1, r1, #3
	orr r1, r1, #2
	strb r1, [r4, #0x38c]
	strb r0, [r4]
	ldrb ip, [r4, #3]
	mov r1, #0x10000
	add r2, r4, #0x350
	bic ip, ip, #1
	orr ip, ip, #1
	strb ip, [r4, #3]
	str r3, [r4, #0xc]
	str r1, [r4, #0x10]
	str r3, [r4, #0x14]
	ldr r1, _0215AC3C // =exBossLineNeedleTask__ActiveInstanceCount
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #0]
	add r2, r2, #1
	strh r2, [r1]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215AC3C: .word exBossLineNeedleTask__ActiveInstanceCount
_0215AC40: .word aExtraExBb_4
_0215AC44: .word 0x00003FFC
	arm_func_end exBossLineNeedleTask__Func_215AA34

	arm_func_start exBossLineNeedleTask__Func_215AC48
exBossLineNeedleTask__Func_215AC48: // 0x0215AC48
	stmdb sp!, {r4, lr}
	ldr r1, _0215ACC0 // =exBossLineNeedleTask__ActiveInstanceCount
	mov r4, r0
	ldrsh r0, [r1, #0]
	cmp r0, #1
	bgt _0215ACA4
	ldr r0, [r1, #0x38]
	cmp r0, #0
	beq _0215AC70
	bl NNS_G3dResDefaultRelease
_0215AC70:
	ldr r0, _0215ACC0 // =exBossLineNeedleTask__ActiveInstanceCount
	ldr r0, [r0, #0x3c]
	cmp r0, #0
	beq _0215AC84
	bl NNS_G3dResDefaultRelease
_0215AC84:
	ldr r0, _0215ACC0 // =exBossLineNeedleTask__ActiveInstanceCount
	ldr r0, [r0, #0x38]
	cmp r0, #0
	beq _0215AC98
	bl _FreeHEAP_USER
_0215AC98:
	ldr r0, _0215ACC0 // =exBossLineNeedleTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x38]
_0215ACA4:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _0215ACC0 // =exBossLineNeedleTask__ActiveInstanceCount
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215ACC0: .word exBossLineNeedleTask__ActiveInstanceCount
	arm_func_end exBossLineNeedleTask__Func_215AC48

	arm_func_start exBossLineNeedleTask__Main
exBossLineNeedleTask__Main: // 0x0215ACC4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _0215AE44 // =exBossLineNeedleTask__ActiveInstanceCount
	str r0, [r1, #0x24]
	add r0, r4, #0x24
	bl exBossLineNeedleTask__Func_215AA34
	add r0, r4, #0x3b0
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x3b0
	bl exDrawReqTask__Func_2164218
	mov r5, #0x48
	ldr r1, _0215AE48 // =0x021740C8
	mov ip, #0
	mov lr, #0xc
	mov r6, r5
	mov r7, r5
_0215AD10:
	ldrh r2, [r4, #0]
	mul r3, ip, lr
	mla r0, r2, r5, r1
	ldr r2, [r4, #0x20]
	ldr r0, [r3, r0]
	ldr r8, [r2, #0x3bc]
	add r2, r4, r3
	add r0, r8, r0
	str r0, [r2, #0x530]
	ldrh r9, [r4, #0]
	ldr r0, [r4, #0x20]
	add ip, ip, #1
	mla r8, r9, r6, r1
	add r8, r3, r8
	ldr r9, [r0, #0x3c0]
	ldr r0, [r8, #4]
	mov ip, ip, lsl #0x10
	add r0, r9, r0
	str r0, [r2, #0x534]
	ldrh r9, [r4, #0]
	ldr r0, [r4, #0x20]
	mov ip, ip, lsr #0x10
	mla r8, r9, r7, r1
	add r3, r3, r8
	ldr r8, [r0, #0x3c4]
	ldr r0, [r3, #8]
	cmp ip, #6
	add r0, r8, r0
	str r0, [r2, #0x538]
	blo _0215AD10
	ldr r0, [r4, #0x530]
	ldr r5, _0215AE4C // =_mt_math_rand
	str r0, [r4, #0x374]
	ldr r1, [r4, #0x530]
	ldr r0, _0215AE50 // =0x00196225
	str r1, [r4, #0x378]
	ldr r2, [r4, #0x530]
	ldr r1, _0215AE54 // =0x3C6EF35F
	str r2, [r4, #0x37c]
	ldr r2, [r5, #0]
	ldr r3, _0215AE58 // =0x88888889
	mla r0, r2, r0, r1
	mov r1, r0, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r6, r1, lsr #0x10
	smull r2, r7, r3, r6
	add r7, r7, r1, lsr #16
	mov r2, r6, lsr #0x1f
	add r7, r2, r7, asr #4
	mov ip, #0x1e
	smull r2, r3, ip, r7
	rsb r7, r2, r1, lsr #16
	add r1, r7, #0x3c
	mov r2, r1, lsl #0x10
	str r0, [r5]
	mov r3, r2, asr #0x10
	add r0, r4, #0x500
	add r1, r4, #0x530
	mov r2, #6
	bl exPlayerHelpers__Func_2152960
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	moveq r0, #9
	streqh r0, [r4, #0x2e]
	beq _0215AE2C
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	moveq r0, #0xc
	streqh r0, [r4, #0x2e]
_0215AE2C:
	mov r0, #3
	strh r0, [r4, #0x1c]
	bl GetExTaskCurrent
	ldr r1, _0215AE5C // =exBossLineNeedleTask__Main_215AEAC
	str r1, [r0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0215AE44: .word exBossLineNeedleTask__ActiveInstanceCount
_0215AE48: .word 0x021740C8
_0215AE4C: .word _mt_math_rand
_0215AE50: .word 0x00196225
_0215AE54: .word 0x3C6EF35F
_0215AE58: .word 0x88888889
_0215AE5C: .word exBossLineNeedleTask__Main_215AEAC
	arm_func_end exBossLineNeedleTask__Main

	arm_func_start exBossLineNeedleTask__Func8
exBossLineNeedleTask__Func8: // 0x0215AE60
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0215AE84 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215AE84: .word ExTask_State_Destroy
	arm_func_end exBossLineNeedleTask__Func8

	arm_func_start exBossLineNeedleTask__Destructor
exBossLineNeedleTask__Destructor: // 0x0215AE88
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0x24
	bl exBossLineNeedleTask__Func_215AC48
	ldr r0, _0215AEA8 // =exBossLineNeedleTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x24]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215AEA8: .word exBossLineNeedleTask__ActiveInstanceCount
	arm_func_end exBossLineNeedleTask__Destructor

	arm_func_start exBossLineNeedleTask__Main_215AEAC
exBossLineNeedleTask__Main_215AEAC: // 0x0215AEAC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x24
	bl exDrawReqTask__Model__Animate
	ldrb r0, [r4, #0x2a]
	mov r1, r0, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _0215AF34
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _0215AF24
	ldrsh r1, [r4, #0x2e]
	ldrsh r0, [r4, #0x2c]
	sub r0, r1, r0
	strh r0, [r4, #0x2e]
	ldrsh r0, [r4, #0x2e]
	cmp r0, #0
	bgt _0215AF10
	add r0, r4, #0x374
	bl exEffectBigBombTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215AFE0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215AF10:
	mov r0, #0
	strh r0, [r4, #0x2c]
	ldrb r0, [r4, #0x2a]
	bic r0, r0, #2
	strb r0, [r4, #0x2a]
_0215AF24:
	ldrb r0, [r4, #0x2a]
	bic r0, r0, #1
	strb r0, [r4, #0x2a]
	b _0215AF50
_0215AF34:
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _0215AF50
	bl GetExTaskCurrent
	ldr r1, _0215AFE0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215AF50:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	bne _0215AF74
	add r0, r4, #0x374
	bl exEffectBigBombTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215AFE0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215AF74:
	add r0, r4, #0x500
	bl exPlayerHelpers__Func_2152AB4
	cmp r0, #0
	beq _0215AF8C
	bl exBossLineMissileTask__Func_215AFE4
	ldmia sp!, {r4, pc}
_0215AF8C:
	ldr r1, [r4, #0x508]
	add r0, r4, #0x24
	str r1, [r4, #0x374]
	ldr r2, [r4, #0x50c]
	add r1, r4, #0x3b0
	str r2, [r4, #0x378]
	ldr r2, [r4, #0x510]
	str r2, [r4, #0x37c]
	ldr r2, [r4, #0x518]
	str r2, [r4, #4]
	ldr r2, [r4, #0x51c]
	str r2, [r4, #8]
	ldr r2, [r4, #0x520]
	str r2, [r4, #0xc]
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x24
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215AFE0: .word ExTask_State_Destroy
	arm_func_end exBossLineNeedleTask__Main_215AEAC

	arm_func_start exBossLineMissileTask__Func_215AFE4
exBossLineMissileTask__Func_215AFE4: // 0x0215AFE4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, _0215B000 // =exBossLineMissileTask__Func_215B004
	str r1, [r0]
	bl exBossLineMissileTask__Func_215B004
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215B000: .word exBossLineMissileTask__Func_215B004
	arm_func_end exBossLineMissileTask__Func_215AFE4

	arm_func_start exBossLineMissileTask__Func_215B004
exBossLineMissileTask__Func_215B004: // 0x0215B004
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x24
	bl exDrawReqTask__Model__Animate
	ldrb r0, [r4, #0x2a]
	mov r1, r0, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _0215B08C
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _0215B07C
	ldrsh r1, [r4, #0x2e]
	ldrsh r0, [r4, #0x2c]
	sub r0, r1, r0
	strh r0, [r4, #0x2e]
	ldrsh r0, [r4, #0x2e]
	cmp r0, #0
	bgt _0215B068
	add r0, r4, #0x374
	bl exEffectBigBombTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215B160 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215B068:
	mov r0, #0
	strh r0, [r4, #0x2c]
	ldrb r0, [r4, #0x2a]
	bic r0, r0, #2
	strb r0, [r4, #0x2a]
_0215B07C:
	ldrb r0, [r4, #0x2a]
	bic r0, r0, #1
	strb r0, [r4, #0x2a]
	b _0215B0A8
_0215B08C:
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _0215B0A8
	bl GetExTaskCurrent
	ldr r1, _0215B160 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215B0A8:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	bne _0215B0CC
	add r0, r4, #0x374
	bl exEffectBigBombTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215B160 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215B0CC:
	ldr r0, [r4, #8]
	sub r0, r0, #0x80
	str r0, [r4, #8]
	ldr r1, [r4, #0x374]
	ldr r0, [r4, #4]
	add r0, r1, r0
	str r0, [r4, #0x374]
	ldr r1, [r4, #0x378]
	ldr r0, [r4, #8]
	add r0, r1, r0
	str r0, [r4, #0x378]
	ldr r1, [r4, #0x374]
	cmp r1, #0x5a000
	bge _0215B12C
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _0215B12C
	ldr r1, [r4, #0x378]
	cmp r1, #0xc8000
	bge _0215B12C
	add r0, r0, #0x1e000
	cmp r1, r0
	bgt _0215B13C
_0215B12C:
	bl GetExTaskCurrent
	ldr r1, _0215B160 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215B13C:
	add r0, r4, #0x24
	add r1, r4, #0x3b0
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x24
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215B160: .word ExTask_State_Destroy
	arm_func_end exBossLineMissileTask__Func_215B004

	arm_func_start exBossLineNeedleTask__Create
exBossLineNeedleTask__Create: // 0x0215B164
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _0215B1E0 // =0x00000578
	str r4, [sp]
	str r1, [sp, #4]
	ldr r0, _0215B1E4 // =aExbosslineneed
	ldr r1, _0215B1E8 // =exBossLineNeedleTask__Destructor
	str r0, [sp, #8]
	ldr r0, _0215B1EC // =exBossLineNeedleTask__Main
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, _0215B1E0 // =0x00000578
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x20]
	ldrh r1, [r0, #0x66]
	mov r0, r5
	strh r1, [r4]
	bl GetExTask
	ldr r1, _0215B1F0 // =exBossLineNeedleTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215B1E0: .word 0x00000578
_0215B1E4: .word aExbosslineneed
_0215B1E8: .word exBossLineNeedleTask__Destructor
_0215B1EC: .word exBossLineNeedleTask__Main
_0215B1F0: .word exBossLineNeedleTask__Func8
	arm_func_end exBossLineNeedleTask__Create

	arm_func_start exBossLineMissileTask__Func_215B1F4
exBossLineMissileTask__Func_215B1F4: // 0x0215B1F4
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _0215B3F8 // =exBossLineNeedleTask__ActiveInstanceCount
	mov r4, r0
	str r4, [r1, #0x40]
	ldr r0, [r1, #0x10]
	cmp r0, #0
	ldrne r0, [r1, #0xc]
	cmpne r0, #0
	beq _0215B260
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _0215B3F8 // =exBossLineNeedleTask__ActiveInstanceCount
	ldr r1, [r1, #0x10]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _0215B3F8 // =exBossLineNeedleTask__ActiveInstanceCount
	ldr r1, [r1, #0xc]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _0215B3F8 // =exBossLineNeedleTask__ActiveInstanceCount
	ldr r1, [r1, #0x10]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
_0215B260:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, _0215B3F8 // =exBossLineNeedleTask__ActiveInstanceCount
	ldrsh r0, [r0, #2]
	cmp r0, #0
	bne _0215B2DC
	mov r1, #0x18
	ldr r0, _0215B3FC // =aExtraExBb_4
	sub r2, r1, #0x19
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _0215B3F8 // =exBossLineNeedleTask__ActiveInstanceCount
	mov r0, r0, lsr #8
	str r0, [r1, #0x10]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _0215B3F8 // =exBossLineNeedleTask__ActiveInstanceCount
	mov r0, r5
	str r1, [r2, #0x1c]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x43
	bl LoadExSystemFile
	ldr r1, _0215B3F8 // =exBossLineNeedleTask__ActiveInstanceCount
	mov r2, #2
	str r0, [r1, #4]
	str r2, [r1, #0x14]
	ldr r0, [r1, #0x1c]
	bl Asset3DSetup__Create
_0215B2DC:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _0215B3F8 // =exBossLineNeedleTask__ActiveInstanceCount
	str r2, [sp]
	ldr r1, [r0, #0x1c]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	ldr r0, _0215B3F8 // =exBossLineNeedleTask__ActiveInstanceCount
	ldr r0, [r0, #0x1c]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r2, _0215B3F8 // =exBossLineNeedleTask__ActiveInstanceCount
	add r0, r4, #0x20
	ldr r1, [r2, #0x14]
	ldr r2, [r2, #4]
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	ldr r1, _0215B3F8 // =exBossLineNeedleTask__ActiveInstanceCount
	add r0, r4, #0x300
	ldr r2, [r1, #0x14]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x14]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_0215B354:
	mov r0, r2, lsl r3
	tst r0, #4
	beq _0215B374
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215B374:
	add r3, r3, #1
	cmp r3, #5
	blo _0215B354
	mov r0, #0
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	str r0, [r4, #0x370]
	ldrb r2, [r4, #0x38c]
	ldr r1, _0215B400 // =0x00003FFC
	add r0, r4, #0x300
	bic r2, r2, #3
	orr r2, r2, #2
	strb r2, [r4, #0x38c]
	strh r1, [r0, #0x4a]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #2]
	mov r2, #0x6000
	mov r1, #0x10000
	orr r3, r3, #0x80
	strb r3, [r4, #2]
	str r2, [r4, #0xc]
	str r1, [r4, #0x10]
	str r2, [r4, #0x14]
	add r2, r4, #0x350
	ldr r1, _0215B3F8 // =exBossLineNeedleTask__ActiveInstanceCount
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #2]
	add r2, r2, #1
	strh r2, [r1, #2]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215B3F8: .word exBossLineNeedleTask__ActiveInstanceCount
_0215B3FC: .word aExtraExBb_4
_0215B400: .word 0x00003FFC
	arm_func_end exBossLineMissileTask__Func_215B1F4

	arm_func_start exBossLineMissileTask__Func_215B404
exBossLineMissileTask__Func_215B404: // 0x0215B404
	stmdb sp!, {r4, lr}
	ldr r1, _0215B47C // =exBossLineNeedleTask__ActiveInstanceCount
	mov r4, r0
	ldrsh r0, [r1, #2]
	cmp r0, #1
	bgt _0215B460
	ldr r0, [r1, #0x1c]
	cmp r0, #0
	beq _0215B42C
	bl NNS_G3dResDefaultRelease
_0215B42C:
	ldr r0, _0215B47C // =exBossLineNeedleTask__ActiveInstanceCount
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _0215B440
	bl NNS_G3dResDefaultRelease
_0215B440:
	ldr r0, _0215B47C // =exBossLineNeedleTask__ActiveInstanceCount
	ldr r0, [r0, #0x1c]
	cmp r0, #0
	beq _0215B454
	bl _FreeHEAP_USER
_0215B454:
	ldr r0, _0215B47C // =exBossLineNeedleTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x1c]
_0215B460:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _0215B47C // =exBossLineNeedleTask__ActiveInstanceCount
	ldrsh r1, [r0, #2]
	sub r1, r1, #1
	strh r1, [r0, #2]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215B47C: .word exBossLineNeedleTask__ActiveInstanceCount
	arm_func_end exBossLineMissileTask__Func_215B404

	arm_func_start exBossLineMissileTask__Main
exBossLineMissileTask__Main: // 0x0215B480
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _0215B600 // =exBossLineNeedleTask__ActiveInstanceCount
	str r0, [r1, #8]
	add r0, r4, #0x2c
	bl exBossLineMissileTask__Func_215B1F4
	add r0, r4, #0x3b8
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x3b8
	bl exDrawReqTask__Func_2164218
	mov r6, #0x48
	ldr r1, _0215B604 // =0x021740C8
	mov ip, #0
	mov r5, #0xc
	mov lr, r6
	mov r7, r6
_0215B4CC:
	ldrh r2, [r4, #0]
	mul r3, ip, r5
	mla r0, r2, r6, r1
	ldr r2, [r4, #0x28]
	ldr r0, [r3, r0]
	ldr r8, [r2, #0x3bc]
	add r2, r4, r3
	add r0, r8, r0
	str r0, [r2, #0x538]
	ldrh r9, [r4, #0]
	ldr r0, [r4, #0x28]
	add ip, ip, #1
	mla r8, r9, lr, r1
	add r8, r3, r8
	ldr r9, [r0, #0x3c0]
	ldr r0, [r8, #4]
	mov ip, ip, lsl #0x10
	add r0, r9, r0
	str r0, [r2, #0x53c]
	ldrh r9, [r4, #0]
	ldr r0, [r4, #0x28]
	mov ip, ip, lsr #0x10
	mla r8, r9, r7, r1
	add r3, r3, r8
	ldr r8, [r0, #0x3c4]
	ldr r0, [r3, #8]
	cmp ip, #6
	add r0, r8, r0
	str r0, [r2, #0x540]
	blo _0215B4CC
	ldr r0, [r4, #0x538]
	ldr r2, _0215B608 // =0x3C6EF35F
	str r0, [r4, #0x37c]
	ldr r0, [r4, #0x538]
	ldr r6, _0215B60C // =0x88888889
	str r0, [r4, #0x380]
	ldr r1, [r4, #0x538]
	ldr r0, _0215B610 // =_mt_math_rand
	str r1, [r4, #0x384]
	ldr r5, [r0, #0]
	ldr r1, _0215B614 // =0x00196225
	add r3, r4, #0x108
	mla r1, r5, r1, r2
	mov r2, r1, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r7, r2, lsr #0x10
	smull r5, lr, r6, r7
	add lr, lr, r2, lsr #16
	mov r5, r7, lsr #0x1f
	add lr, r5, lr, asr #4
	mov r6, #0x1e
	smull lr, r5, r6, lr
	rsb lr, lr, r2, lsr #16
	add r2, lr, #0x3c
	str r1, [r0]
	add ip, r4, #0x138
	mov r2, r2, lsl #0x10
	add r0, r3, #0x400
	mov r3, r2, asr #0x10
	add r1, ip, #0x400
	mov r2, #6
	bl exPlayerHelpers__Func_2152960
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	moveq r0, #9
	streqh r0, [r4, #0x36]
	beq _0215B5F0
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	moveq r0, #0xc
	streqh r0, [r4, #0x36]
_0215B5F0:
	bl GetExTaskCurrent
	ldr r1, _0215B618 // =exBossLineMissileTask__Main_215B668
	str r1, [r0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0215B600: .word exBossLineNeedleTask__ActiveInstanceCount
_0215B604: .word 0x021740C8
_0215B608: .word 0x3C6EF35F
_0215B60C: .word 0x88888889
_0215B610: .word _mt_math_rand
_0215B614: .word 0x00196225
_0215B618: .word exBossLineMissileTask__Main_215B668
	arm_func_end exBossLineMissileTask__Main

	arm_func_start exBossLineMissileTask__Func8
exBossLineMissileTask__Func8: // 0x0215B61C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0215B640 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215B640: .word ExTask_State_Destroy
	arm_func_end exBossLineMissileTask__Func8

	arm_func_start exBossLineMissileTask__Destructor
exBossLineMissileTask__Destructor: // 0x0215B644
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0x2c
	bl exBossLineMissileTask__Func_215B404
	ldr r0, _0215B664 // =exBossLineNeedleTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #8]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215B664: .word exBossLineNeedleTask__ActiveInstanceCount
	arm_func_end exBossLineMissileTask__Destructor

	arm_func_start exBossLineMissileTask__Main_215B668
exBossLineMissileTask__Main_215B668: // 0x0215B668
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x2c
	bl exDrawReqTask__Model__Animate
	ldrb r1, [r4, #0x32]
	mov r0, r1, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _0215B704
	ldrb r0, [r4, #0x2c]
	cmp r0, #2
	bne _0215B6A0
	bl exBossLineMissileTask__Func_215B998
	ldmia sp!, {r4, pc}
_0215B6A0:
	mov r0, r1, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _0215B6F4
	ldrsh r1, [r4, #0x36]
	ldrsh r0, [r4, #0x34]
	sub r0, r1, r0
	strh r0, [r4, #0x36]
	ldrsh r0, [r4, #0x36]
	cmp r0, #0
	bgt _0215B6E0
	add r0, r4, #0x37c
	bl exEffectBigBombTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215B7BC // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215B6E0:
	mov r0, #0
	strh r0, [r4, #0x34]
	ldrb r0, [r4, #0x32]
	bic r0, r0, #2
	strb r0, [r4, #0x32]
_0215B6F4:
	ldrb r0, [r4, #0x32]
	bic r0, r0, #1
	strb r0, [r4, #0x32]
	b _0215B728
_0215B704:
	mov r0, r1, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _0215B728
	add r0, r4, #0x37c
	bl exEffectBigBombTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215B7BC // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215B728:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	bne _0215B74C
	add r0, r4, #0x37c
	bl exEffectBigBombTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215B7BC // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215B74C:
	add r0, r4, #0x108
	add r0, r0, #0x400
	bl exPlayerHelpers__Func_2152AB4
	cmp r0, #0
	beq _0215B768
	bl exBossLineMissileTask__Func_215B7C0
	ldmia sp!, {r4, pc}
_0215B768:
	ldr r1, [r4, #0x510]
	add r0, r4, #0x2c
	str r1, [r4, #0x37c]
	ldr r2, [r4, #0x514]
	add r1, r4, #0x3b8
	str r2, [r4, #0x380]
	ldr r2, [r4, #0x518]
	str r2, [r4, #0x384]
	ldr r2, [r4, #0x520]
	str r2, [r4, #4]
	ldr r2, [r4, #0x524]
	str r2, [r4, #8]
	ldr r2, [r4, #0x528]
	str r2, [r4, #0xc]
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x2c
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215B7BC: .word ExTask_State_Destroy
	arm_func_end exBossLineMissileTask__Main_215B668

	arm_func_start exBossLineMissileTask__Func_215B7C0
exBossLineMissileTask__Func_215B7C0: // 0x0215B7C0
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov ip, #0xcc
	sub r1, ip, #0xcd
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _0215B800 // =exBossLineMissileTask__Func_215B804
	str r1, [r0]
	bl exBossLineMissileTask__Func_215B804
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215B800: .word exBossLineMissileTask__Func_215B804
	arm_func_end exBossLineMissileTask__Func_215B7C0

	arm_func_start exBossLineMissileTask__Func_215B804
exBossLineMissileTask__Func_215B804: // 0x0215B804
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x2c
	bl exDrawReqTask__Model__Animate
	ldrb r1, [r4, #0x32]
	mov r0, r1, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _0215B8A0
	ldrb r0, [r4, #0x2c]
	cmp r0, #2
	bne _0215B83C
	bl exBossLineMissileTask__Func_215B998
	ldmia sp!, {r4, pc}
_0215B83C:
	mov r0, r1, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _0215B890
	ldrsh r1, [r4, #0x36]
	ldrsh r0, [r4, #0x34]
	sub r0, r1, r0
	strh r0, [r4, #0x36]
	ldrsh r0, [r4, #0x36]
	cmp r0, #0
	bgt _0215B87C
	add r0, r4, #0x37c
	bl exEffectBigBombTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215B994 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215B87C:
	mov r0, #0
	strh r0, [r4, #0x34]
	ldrb r0, [r4, #0x32]
	bic r0, r0, #2
	strb r0, [r4, #0x32]
_0215B890:
	ldrb r0, [r4, #0x32]
	bic r0, r0, #1
	strb r0, [r4, #0x32]
	b _0215B8C4
_0215B8A0:
	mov r0, r1, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _0215B8C4
	add r0, r4, #0x37c
	bl exEffectBigBombTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215B994 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215B8C4:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	bne _0215B8E8
	add r0, r4, #0x37c
	bl exEffectBigBombTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215B994 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215B8E8:
	ldr r0, [r4, #8]
	sub r0, r0, #0x80
	str r0, [r4, #8]
	ldr r1, [r4, #0x37c]
	ldr r0, [r4, #4]
	add r0, r1, r0
	str r0, [r4, #0x37c]
	ldr r1, [r4, #0x380]
	ldr r0, [r4, #8]
	add r0, r1, r0
	str r0, [r4, #0x380]
	cmp r0, #0x14000
	bgt _0215B92C
	ldrb r0, [r4, #0x3b8]
	bic r0, r0, #3
	orr r0, r0, #1
	strb r0, [r4, #0x3b8]
_0215B92C:
	ldr r1, [r4, #0x37c]
	cmp r1, #0x5a000
	bge _0215B960
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _0215B960
	ldr r1, [r4, #0x380]
	cmp r1, #0xc8000
	bge _0215B960
	add r0, r0, #0x1e000
	cmp r1, r0
	bgt _0215B970
_0215B960:
	bl GetExTaskCurrent
	ldr r1, _0215B994 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215B970:
	add r0, r4, #0x2c
	add r1, r4, #0x3b8
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x2c
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215B994: .word ExTask_State_Destroy
	arm_func_end exBossLineMissileTask__Func_215B804

	arm_func_start exBossLineMissileTask__Func_215B998
exBossLineMissileTask__Func_215B998: // 0x0215B998
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrb r1, [r4, #0x32]
	mov r0, #0
	bic r1, r1, #1
	strb r1, [r4, #0x32]
	ldrb r1, [r4, #0x30]
	orr r1, r1, #2
	strb r1, [r4, #0x30]
	str r0, [r4, #4]
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _0215BA34
	ldrsh r0, [r4, #0x34]
	mov r1, #0x2000
	cmp r0, #6
	bne _0215BA0C
	mov r0, #0x4000
	bl FX_Div
	ldr r1, [r4, #8]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _0215BAA0
_0215BA0C:
	mov r0, #0x6000
	bl FX_Div
	ldr r1, [r4, #8]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _0215BAA0
_0215BA34:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _0215BAA0
	ldrsh r0, [r4, #0x34]
	mov r1, #0x2000
	cmp r0, #7
	bne _0215BA7C
	mov r0, #0x4000
	bl FX_Div
	ldr r1, [r4, #8]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	b _0215BAA0
_0215BA7C:
	mov r0, #0x6000
	bl FX_Div
	ldr r1, [r4, #8]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
_0215BAA0:
	ldr r1, [r4, #8]
	mov r0, #0
	rsb r1, r1, #0
	str r1, [r4, #8]
	ldr r2, _0215BB30 // =0x0000BFF4
	str r0, [r4, #0xc]
	add r1, r4, #0x300
	strh r2, [r1, #0x76]
	strh r0, [r1, #0x78]
	strh r0, [r1, #0x7a]
	mov r2, #0x6000
	str r2, [r4, #0x38]
	mov r1, #0x8000
	str r1, [r4, #0x3c]
	str r2, [r4, #0x40]
	ldr r1, _0215BB34 // =0x00001554
	ldr r3, _0215BB38 // =_mt_math_rand
	strh r1, [r4, #0x20]
	ldr ip, [r3]
	ldr r1, _0215BB3C // =0x00196225
	ldr r2, _0215BB40 // =0x3C6EF35F
	mla lr, ip, r1, r2
	mov r1, lr, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r1, lsr #0x1f
	rsb r1, r2, r1, lsl #31
	adds r1, r2, r1, ror #31
	str lr, [r3]
	movne r0, #1
	str r0, [r4, #0x24]
	bl GetExTaskCurrent
	ldr r1, _0215BB44 // =exBossLineMissileTask__Func_215BB48
	str r1, [r0]
	bl exBossLineMissileTask__Func_215BB48
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215BB30: .word 0x0000BFF4
_0215BB34: .word 0x00001554
_0215BB38: .word _mt_math_rand
_0215BB3C: .word 0x00196225
_0215BB40: .word 0x3C6EF35F
_0215BB44: .word exBossLineMissileTask__Func_215BB48
	arm_func_end exBossLineMissileTask__Func_215B998

	arm_func_start exBossLineMissileTask__Func_215BB48
exBossLineMissileTask__Func_215BB48: // 0x0215BB48
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x2c
	bl exDrawReqTask__Model__Animate
	ldrb r0, [r4, #0x32]
	mov r1, r0, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _0215BB7C
	bl GetExTaskCurrent
	ldr r1, _0215BC3C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215BB7C:
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _0215BB98
	bl GetExTaskCurrent
	ldr r1, _0215BC3C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215BB98:
	ldr r0, [r4, #0x24]
	cmp r0, #0
	add r0, r4, #0x300
	ldreqh r2, [r0, #0x78]
	ldreqh r1, [r4, #0x20]
	subeq r1, r2, r1
	beq _0215BBC0
	ldrh r2, [r0, #0x78]
	ldrh r1, [r4, #0x20]
	add r1, r2, r1
_0215BBC0:
	strh r1, [r0, #0x78]
	ldr r1, [r4, #0x380]
	ldr r0, [r4, #8]
	add r0, r1, r0
	str r0, [r4, #0x380]
	ldr r1, [r4, #0x37c]
	cmp r1, #0x5a000
	bge _0215BC08
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _0215BC08
	ldr r1, [r4, #0x380]
	cmp r1, #0xc8000
	bge _0215BC08
	add r0, r0, #0x1e000
	cmp r1, r0
	bgt _0215BC18
_0215BC08:
	bl GetExTaskCurrent
	ldr r1, _0215BC3C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215BC18:
	add r0, r4, #0x2c
	add r1, r4, #0x3b8
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x2c
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215BC3C: .word ExTask_State_Destroy
	arm_func_end exBossLineMissileTask__Func_215BB48

	arm_func_start exBossLineMissileTask__Create
exBossLineMissileTask__Create: // 0x0215BC40
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x580
	str r1, [sp, #4]
	ldr r0, _0215BCBC // =aExbosslinemiss
	ldr r1, _0215BCC0 // =exBossLineMissileTask__Destructor
	str r0, [sp, #8]
	ldr r0, _0215BCC4 // =exBossLineMissileTask__Main
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x580
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x28]
	ldrh r1, [r0, #0x66]
	mov r0, r5
	strh r1, [r4]
	bl GetExTask
	ldr r1, _0215BCC8 // =exBossLineMissileTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215BCBC: .word aExbosslinemiss
_0215BCC0: .word exBossLineMissileTask__Destructor
_0215BCC4: .word exBossLineMissileTask__Main
_0215BCC8: .word exBossLineMissileTask__Func8
	arm_func_end exBossLineMissileTask__Create

	.data
	
_021740C8:
	.word 0, 0x19000, 0x32000, 0xFFFDAE66, 0x1E000, 0x46000
	.word 0xFFFDACCD, 0x23000, 0x82000, 0xFFFDAB33, 0xFFFBA000
	.word 0x82000, 0xFFFDA99A, 0xFFFE2000, 0x32000, 0xFFFDA800
	.word 0xFFFCE000, 0x3C000, 0, 0x19000, 0x32000, 0xFFFE9E66
	.word 0x23000, 0x3C000, 0xFFFE9CCD, 0x23000, 0x82000, 0xFFFE9B33
	.word 0xFFFBA000, 0x82000, 0xFFFE999A, 0xFFFE2000, 0x32000
	.word 0xFFFE9800, 0xFFFCE000, 0x3C000, 0, 0x19000, 0x32000
	.word 0xFFFF8E66, 0x23000, 0x3C000, 0xFFFF8CCD, 0x23000
	.word 0x82000, 0xFFFF8B33, 0xFFFBA000, 0x82000, 0xFFFF899A
	.word 0xFFFE2000, 0x32000, 0xFFFF8800, 0xFFFCE000, 0x3C000
	.word 0, 0x19000, 0x32000, 0x719A, 0x23000, 0x3C000, 0x7333
	.word 0x23000, 0x82000, 0x74CD, 0xFFFBA000, 0x82000, 0x7666
	.word 0xFFFE2000, 0x32000, 0x7800, 0xFFFCE000, 0x3C000, 0
	.word 0x19000, 0x32000, 0x1619A, 0x23000, 0x3C000, 0x16333
	.word 0x23000, 0x82000, 0x164CD, 0xFFFBA000, 0x82000, 0x16666
	.word 0xFFFE2000, 0x32000, 0x16800, 0xFFFCE000, 0x3C000
	.word 0, 0x19000, 0x32000, 0x2519A, 0x23000, 0x3C000, 0x25333
	.word 0x23000, 0x82000, 0x254CD, 0xFFFBA000, 0x82000, 0x25666
	.word 0xFFFE2000, 0x32000, 0x25800, 0xFFFCE000, 0x3C000

aExtraExBb_4: // 0x02174278
	.asciz "/extra/ex.bb"
	.align 4
	
aExbosslineneed: // 0x02174288
	.asciz "exBossLineNeedleTask"
	.align 4
	
aExbosslinemiss: // 0x021742A0
	.asciz "exBossLineMissileTask"