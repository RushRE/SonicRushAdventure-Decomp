	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start exBossEffectFireTask__Func_2157A04
exBossEffectFireTask__Func_2157A04: // 0x02157A04
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _02157C90 // =0x02175FC4
	mov r4, r0
	str r4, [r1, #0x38]
	ldr r0, [r1, #0x8c]
	cmp r0, #0
	ldrne r0, [r1, #0x28]
	cmpne r0, #0
	beq _02157A80
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _02157C90 // =0x02175FC4
	ldr r1, [r1, #0x8c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _02157C90 // =0x02175FC4
	ldr r1, [r1, #0x28]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _02157C90 // =0x02175FC4
	ldr r1, [r1, #0x8c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02157A80:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, _02157C90 // =0x02175FC4
	ldrsh r0, [r0, #2]
	cmp r0, #0
	bne _02157B44
	mov r1, #0xd
	ldr r0, _02157C94 // =aExtraExBb_2
	sub r2, r1, #0xe
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _02157C90 // =0x02175FC4
	mov r0, r0, lsr #8
	str r0, [r1, #0x8c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02157C90 // =0x02175FC4
	mov r0, r5
	str r1, [r2, #0x34]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x25
	bl exSysTask__LoadExFile
	ldr r1, _02157C90 // =0x02175FC4
	mov r2, #0
	str r0, [r1, #0x114]
	mov r0, #0x26
	str r2, [r1, #0xf4]
	bl exSysTask__LoadExFile
	ldr r1, _02157C90 // =0x02175FC4
	mov r2, #1
	str r0, [r1, #0x118]
	mov r0, #0x27
	str r2, [r1, #0xf8]
	bl exSysTask__LoadExFile
	ldr r1, _02157C90 // =0x02175FC4
	mov r2, #3
	str r0, [r1, #0x11c]
	mov r0, #0x28
	str r2, [r1, #0xfc]
	bl exSysTask__LoadExFile
	ldr r1, _02157C90 // =0x02175FC4
	mov r2, #2
	str r0, [r1, #0x120]
	str r2, [r1, #0x100]
	ldr r0, [r1, #0x34]
	bl Asset3DSetup__Create
_02157B44:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _02157C90 // =0x02175FC4
	str r2, [sp]
	ldr r1, [r0, #0x34]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, _02157C98 // =0x021760B8
	ldr r5, _02157C9C // =0x021760D8
	mov r7, r8
_02157B7C:
	str r7, [sp]
	ldr r1, [r6, r8, lsl #2]
	ldr r2, [r5, r8, lsl #2]
	mov r3, r7
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #3
	blo _02157B7C
	ldr r0, _02157C90 // =0x02175FC4
	ldr r0, [r0, #0x34]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r2, _02157C90 // =0x02175FC4
	add r0, r4, #0x20
	ldr r1, [r2, #0x100]
	ldr r2, [r2, #0x120]
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	ldr r1, _02157C90 // =0x02175FC4
	add r0, r4, #0x300
	ldr r2, [r1, #0xf4]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0xf4]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_02157BF8:
	mov r0, r2, lsl r3
	tst r0, #0xf
	beq _02157C18
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02157C18:
	add r3, r3, #1
	cmp r3, #5
	blo _02157BF8
	mov r0, #0
	str r0, [r4, #0x358]
	mov ip, #0x1000
	str ip, [r4, #0x368]
	str ip, [r4, #0x36c]
	ldr r2, _02157CA0 // =0x0000BFF4
	str ip, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, _02157CA4 // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #1]
	add r2, r4, #0x350
	ldr r1, _02157C90 // =0x02175FC4
	orr r3, r3, #2
	strb r3, [r4, #1]
	str ip, [r4, #0xc]
	str ip, [r4, #0x10]
	str ip, [r4, #0x14]
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #2]
	add r2, r2, #1
	strh r2, [r1, #2]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02157C90: .word 0x02175FC4
_02157C94: .word aExtraExBb_2
_02157C98: .word 0x021760B8
_02157C9C: .word 0x021760D8
_02157CA0: .word 0x0000BFF4
_02157CA4: .word 0x00007FF8
	arm_func_end exBossEffectFireTask__Func_2157A04

	arm_func_start exBossEffectFireTask__Func_2157CA8
exBossEffectFireTask__Func_2157CA8: // 0x02157CA8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r9, #0
	ldr r7, _02157D70 // =0x021760B8
	ldr r6, _02157D74 // =0x021760D8
	mov r5, r0
	mov r4, r1
	mov r8, r9
_02157CC4:
	str r8, [sp]
	ldr r1, [r7, r9, lsl #2]
	ldr r2, [r6, r9, lsl #2]
	mov r3, r4
	add r0, r5, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #3
	blo _02157CC4
	ldr r0, _02157D78 // =0x02175FC4
	ldr r0, [r0, #0x34]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r0, _02157D78 // =0x02175FC4
	mov r3, r4
	ldr r1, [r0, #0x100]
	ldr r2, [r0, #0x120]
	add r0, r5, #0x20
	bl AnimatorMDL__SetAnimation
	ldr r1, _02157D78 // =0x02175FC4
	add r0, r5, #0x300
	ldr r2, [r1, #0xf4]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0xf4]
	mov r2, #1
	add r0, r5, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r5, #0x344]
_02157D40:
	mov r0, r2, lsl r3
	tst r0, #0xf
	beq _02157D60
	add r0, r5, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02157D60:
	add r3, r3, #1
	cmp r3, #5
	blo _02157D40
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02157D70: .word 0x021760B8
_02157D74: .word 0x021760D8
_02157D78: .word 0x02175FC4
	arm_func_end exBossEffectFireTask__Func_2157CA8

	arm_func_start exBossEffectFireTask__Func_2157D7C
exBossEffectFireTask__Func_2157D7C: // 0x02157D7C
	stmdb sp!, {r4, lr}
	ldr r1, _02157E30 // =0x02175FC4
	mov r4, r0
	ldrsh r0, [r1, #2]
	cmp r0, #1
	bgt _02157E14
	ldr r0, [r1, #0x34]
	cmp r0, #0
	beq _02157DA4
	bl NNS_G3dResDefaultRelease
_02157DA4:
	ldr r0, _02157E30 // =0x02175FC4
	ldr r0, [r0, #0x114]
	cmp r0, #0
	beq _02157DB8
	bl NNS_G3dResDefaultRelease
_02157DB8:
	ldr r0, _02157E30 // =0x02175FC4
	ldr r0, [r0, #0x118]
	cmp r0, #0
	beq _02157DCC
	bl NNS_G3dResDefaultRelease
_02157DCC:
	ldr r0, _02157E30 // =0x02175FC4
	ldr r0, [r0, #0x11c]
	cmp r0, #0
	beq _02157DE0
	bl NNS_G3dResDefaultRelease
_02157DE0:
	ldr r0, _02157E30 // =0x02175FC4
	ldr r0, [r0, #0x120]
	cmp r0, #0
	beq _02157DF4
	bl NNS_G3dResDefaultRelease
_02157DF4:
	ldr r0, _02157E30 // =0x02175FC4
	ldr r0, [r0, #0x34]
	cmp r0, #0
	beq _02157E08
	bl _FreeHEAP_USER
_02157E08:
	ldr r0, _02157E30 // =0x02175FC4
	mov r1, #0
	str r1, [r0, #0x34]
_02157E14:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _02157E30 // =0x02175FC4
	ldrsh r1, [r0, #2]
	sub r1, r1, #1
	strh r1, [r0, #2]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157E30: .word 0x02175FC4
	arm_func_end exBossEffectFireTask__Func_2157D7C

	arm_func_start exBossEffectFireTask__Main
exBossEffectFireTask__Main: // 0x02157E34
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02157EAC // =0x02175FC4
	str r0, [r1, #0x24]
	add r0, r4, #4
	bl exBossEffectFireTask__Func_2157A04
	add r0, r4, #0x390
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	mov r2, #1
	ldr r1, _02157EAC // =0x02175FC4
	mov r0, #0
	str r2, [r1, #0x20]
	str r0, [sp]
	mov r1, #0xbf
	str r1, [sp, #4]
	sub r1, r1, #0xc0
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _02157EB0 // =exBossEffectFireTask__Func_2157F18
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157EAC: .word 0x02175FC4
_02157EB0: .word exBossEffectFireTask__Func_2157F18
	arm_func_end exBossEffectFireTask__Main

	arm_func_start exBossEffectFireTask__Func8
exBossEffectFireTask__Func8: // 0x02157EB4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetFlag_2178650
	cmp r0, #0
	beq _02157ED4
	bl GetExTaskCurrent
	ldr r1, _02157EF0 // =ExTask_State_Destroy
	str r1, [r0]
_02157ED4:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	ldmneia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02157EF0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02157EF0: .word ExTask_State_Destroy
	arm_func_end exBossEffectFireTask__Func8

	arm_func_start exBossEffectFireTask__Destructor
exBossEffectFireTask__Destructor: // 0x02157EF4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #4
	bl exBossEffectFireTask__Func_2157D7C
	ldr r0, _02157F14 // =0x02175FC4
	mov r1, #0
	str r1, [r0, #0x24]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02157F14: .word 0x02175FC4
	arm_func_end exBossEffectFireTask__Destructor

	arm_func_start exBossEffectFireTask__Func_2157F18
exBossEffectFireTask__Func_2157F18: // 0x02157F18
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl ExBossSysAdminTask__GetSingleton
	cmp r0, #0
	bne _02157F48
	bl GetExTaskCurrent
	ldr r1, _02157FA0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02157F48:
	ldr r1, [r4, #0x4e0]
	add r0, r4, #4
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x35c]
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02157F84
	bl exBossEffectFireTask__Func_2157FA4
	ldmia sp!, {r4, pc}
_02157F84:
	add r0, r4, #4
	add r1, r4, #0x390
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157FA0: .word ExTask_State_Destroy
	arm_func_end exBossEffectFireTask__Func_2157F18

	arm_func_start exBossEffectFireTask__Func_2157FA4
exBossEffectFireTask__Func_2157FA4: // 0x02157FA4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	mov r1, #1
	bl exBossEffectFireTask__Func_2157CA8
	add r0, r4, #0x390
	bl exDrawReqTask__Func_2164218
	bl GetExTaskCurrent
	ldr r1, _02157FD8 // =exBossEffectFireTask__Func_2157FDC
	str r1, [r0]
	bl exBossEffectFireTask__Func_2157FDC
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157FD8: .word exBossEffectFireTask__Func_2157FDC
	arm_func_end exBossEffectFireTask__Func_2157FA4

	arm_func_start exBossEffectFireTask__Func_2157FDC
exBossEffectFireTask__Func_2157FDC: // 0x02157FDC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl ExBossSysAdminTask__GetSingleton
	cmp r0, #0
	bne _0215800C
	bl GetExTaskCurrent
	ldr r1, _02158064 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215800C:
	ldr r1, [r4, #0x4e0]
	ldr r0, _02158068 // =0x02175FC4
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x35c]
	ldr r0, [r0, #0x20]
	cmp r0, #0
	bne _02158048
	bl exBossEffectFireTask__Func_215806C
	ldmia sp!, {r4, pc}
_02158048:
	add r0, r4, #4
	add r1, r4, #0x390
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158064: .word ExTask_State_Destroy
_02158068: .word 0x02175FC4
	arm_func_end exBossEffectFireTask__Func_2157FDC

	arm_func_start exBossEffectFireTask__Func_215806C
exBossEffectFireTask__Func_215806C: // 0x0215806C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	mov r1, #2
	bl exBossEffectFireTask__Func_2157CA8
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _021580A0 // =exBossEffectFireTask__Func_21580A4
	str r1, [r0]
	bl exBossEffectFireTask__Func_21580A4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021580A0: .word exBossEffectFireTask__Func_21580A4
	arm_func_end exBossEffectFireTask__Func_215806C

	arm_func_start exBossEffectFireTask__Func_21580A4
exBossEffectFireTask__Func_21580A4: // 0x021580A4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl ExBossSysAdminTask__GetSingleton
	cmp r0, #0
	bne _021580D4
	bl GetExTaskCurrent
	ldr r1, _02158134 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021580D4:
	ldr r1, [r4, #0x4e0]
	add r0, r4, #4
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x35c]
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02158118
	bl GetExTaskCurrent
	ldr r1, _02158134 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02158118:
	add r0, r4, #4
	add r1, r4, #0x390
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158134: .word ExTask_State_Destroy
	arm_func_end exBossEffectFireTask__Func_21580A4

	arm_func_start exBossEffectFireTask__Create
exBossEffectFireTask__Create: // 0x02158138
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _021581AC // =0x000004E4
	str r4, [sp]
	ldr r0, _021581B0 // =aExbosseffectfi
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _021581B4 // =exBossEffectFireTask__Main
	ldr r1, _021581B8 // =exBossEffectFireTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, _021581AC // =0x000004E4
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x4e0]
	mov r0, r5
	bl GetExTask
	ldr r1, _021581BC // =exBossEffectFireTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021581AC: .word 0x000004E4
_021581B0: .word aExbosseffectfi
_021581B4: .word exBossEffectFireTask__Main
_021581B8: .word exBossEffectFireTask__Destructor
_021581BC: .word exBossEffectFireTask__Func8
	arm_func_end exBossEffectFireTask__Create

	.data
	
aExbosseffectfi: // 0x02174054
	.asciz "exBossEffectFireTask"