	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start exBossEffectShotTask__Func_215753C
exBossEffectShotTask__Func_215753C: // 0x0215753C
	ldr r0, _0215754C // =0x02175FC4
	mov r1, #0
	str r1, [r0, #0x60]
	bx lr
	.align 2, 0
_0215754C: .word 0x02175FC4
	arm_func_end exBossEffectShotTask__Func_215753C

	arm_func_start exBossEffectShotTask__Func_2157550
exBossEffectShotTask__Func_2157550: // 0x02157550
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _02157784 // =0x02175FC4
	mov r4, r0
	str r4, [r1, #0x54]
	ldr r0, [r1, #0x1c]
	cmp r0, #0
	ldrne r0, [r1, #0x48]
	cmpne r0, #0
	beq _021575CC
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _02157784 // =0x02175FC4
	ldr r1, [r1, #0x1c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _02157784 // =0x02175FC4
	ldr r1, [r1, #0x48]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _02157784 // =0x02175FC4
	ldr r1, [r1, #0x1c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_021575CC:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, _02157784 // =0x02175FC4
	ldrsh r0, [r0, #4]
	cmp r0, #0
	bne _02157660
	mov r1, #0x13
	ldr r0, _02157788 // =aExtraExBb_2
	sub r2, r1, #0x14
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _02157784 // =0x02175FC4
	mov r0, r0, lsr #8
	str r0, [r1, #0x1c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02157784 // =0x02175FC4
	mov r0, r5
	str r1, [r2, #0x58]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x39
	bl LoadExSystemFile
	ldr r1, _02157784 // =0x02175FC4
	mov r2, #0
	str r0, [r1, #0xcc]
	mov r0, #0x3a
	str r2, [r1, #0xc4]
	bl LoadExSystemFile
	ldr r1, _02157784 // =0x02175FC4
	mov r2, #4
	str r0, [r1, #0xd0]
	str r2, [r1, #0xc8]
	ldr r0, [r1, #0x58]
	bl Asset3DSetup__Create
_02157660:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _02157784 // =0x02175FC4
	str r2, [sp]
	ldr r1, [r0, #0x58]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, _0215778C // =0x02176088
	ldr r5, _02157790 // =0x02176090
	mov r7, r8
_02157698:
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
	blo _02157698
	ldr r1, _02157784 // =0x02175FC4
	add r0, r4, #0x300
	ldr r2, [r1, #0xc4]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0xc4]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_021576EC:
	mov r0, r2, lsl r3
	tst r0, #0x11
	beq _0215770C
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215770C:
	add r3, r3, #1
	cmp r3, #5
	blo _021576EC
	mov r0, #0
	str r0, [r4, #0x358]
	mov ip, #0x1000
	str ip, [r4, #0x368]
	str ip, [r4, #0x36c]
	ldr r2, _02157794 // =0x0000BFF4
	str ip, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, _02157798 // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #1]
	add r2, r4, #0x350
	ldr r1, _02157784 // =0x02175FC4
	orr r3, r3, #4
	strb r3, [r4, #1]
	str ip, [r4, #0xc]
	str ip, [r4, #0x10]
	str ip, [r4, #0x14]
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #4]
	add r2, r2, #1
	strh r2, [r1, #4]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02157784: .word 0x02175FC4
_02157788: .word aExtraExBb_2
_0215778C: .word 0x02176088
_02157790: .word 0x02176090
_02157794: .word 0x0000BFF4
_02157798: .word 0x00007FF8
	arm_func_end exBossEffectShotTask__Func_2157550

	arm_func_start exBossEffectShotTask__Func_215779C
exBossEffectShotTask__Func_215779C: // 0x0215779C
	stmdb sp!, {r4, lr}
	ldr r1, _02157828 // =0x02175FC4
	mov r4, r0
	ldrsh r0, [r1, #4]
	cmp r0, #1
	bgt _0215780C
	ldr r0, [r1, #0x58]
	cmp r0, #0
	beq _021577C4
	bl NNS_G3dResDefaultRelease
_021577C4:
	ldr r0, _02157828 // =0x02175FC4
	ldr r0, [r0, #0xcc]
	cmp r0, #0
	beq _021577D8
	bl NNS_G3dResDefaultRelease
_021577D8:
	ldr r0, _02157828 // =0x02175FC4
	ldr r0, [r0, #0xd0]
	cmp r0, #0
	beq _021577EC
	bl NNS_G3dResDefaultRelease
_021577EC:
	ldr r0, _02157828 // =0x02175FC4
	ldr r0, [r0, #0x58]
	cmp r0, #0
	beq _02157800
	bl _FreeHEAP_USER
_02157800:
	ldr r0, _02157828 // =0x02175FC4
	mov r1, #0
	str r1, [r0, #0x58]
_0215780C:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _02157828 // =0x02175FC4
	ldrsh r1, [r0, #4]
	sub r1, r1, #1
	strh r1, [r0, #4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157828: .word 0x02175FC4
	arm_func_end exBossEffectShotTask__Func_215779C

	arm_func_start exBossEffectShotTask__Main
exBossEffectShotTask__Main: // 0x0215782C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _021578A0 // =0x02175FC4
	str r0, [r1, #0x44]
	add r0, r4, #4
	bl exBossEffectShotTask__Func_2157550
	add r0, r4, #0x390
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	ldr r1, [r4, #0x4e0]
	ldr r0, _021578A0 // =0x02175FC4
	ldr r2, [r1, #0x3ec]
	mov r1, #1
	str r2, [r4, #0x354]
	ldr r2, [r4, #0x4e0]
	ldr r2, [r2, #0x3f0]
	str r2, [r4, #0x358]
	ldr r2, [r4, #0x4e0]
	ldr r2, [r2, #0x3f4]
	str r2, [r4, #0x35c]
	str r1, [r0, #0x40]
	bl GetExTaskCurrent
	ldr r1, _021578A4 // =exBossEffectShotTask__Func_215790C
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021578A0: .word 0x02175FC4
_021578A4: .word exBossEffectShotTask__Func_215790C
	arm_func_end exBossEffectShotTask__Main

	arm_func_start exBossEffectShotTask__Func8
exBossEffectShotTask__Func8: // 0x021578A8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExSystemFlag_2178650
	cmp r0, #0
	beq _021578C8
	bl GetExTaskCurrent
	ldr r1, _021578E4 // =ExTask_State_Destroy
	str r1, [r0]
_021578C8:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	ldmneia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _021578E4 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021578E4: .word ExTask_State_Destroy
	arm_func_end exBossEffectShotTask__Func8

	arm_func_start exBossEffectShotTask__Destructor
exBossEffectShotTask__Destructor: // 0x021578E8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #4
	bl exBossEffectShotTask__Func_215779C
	ldr r0, _02157908 // =0x02175FC4
	mov r1, #0
	str r1, [r0, #0x44]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02157908: .word 0x02175FC4
	arm_func_end exBossEffectShotTask__Destructor

	arm_func_start exBossEffectShotTask__Func_215790C
exBossEffectShotTask__Func_215790C: // 0x0215790C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl ExBossSysAdminTask__GetSingleton
	cmp r0, #0
	bne _0215793C
	bl GetExTaskCurrent
	ldr r1, _02157978 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215793C:
	add r0, r4, #4
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215795C
	bl GetExTaskCurrent
	ldr r1, _02157978 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215795C:
	add r0, r4, #4
	add r1, r4, #0x390
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157978: .word ExTask_State_Destroy
	arm_func_end exBossEffectShotTask__Func_215790C

	arm_func_start exBossEffectShotTask__Create
exBossEffectShotTask__Create: // 0x0215797C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _021579F0 // =0x000004E4
	str r4, [sp]
	ldr r0, _021579F4 // =aExbosseffectsh
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _021579F8 // =exBossEffectShotTask__Main
	ldr r1, _021579FC // =exBossEffectShotTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, _021579F0 // =0x000004E4
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x4e0]
	mov r0, r5
	bl GetExTask
	ldr r1, _02157A00 // =exBossEffectShotTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021579F0: .word 0x000004E4
_021579F4: .word aExbosseffectsh
_021579F8: .word exBossEffectShotTask__Main
_021579FC: .word exBossEffectShotTask__Destructor
_02157A00: .word exBossEffectShotTask__Func8
	arm_func_end exBossEffectShotTask__Create

	.data
	
aExbosseffectsh: // 0x0217403C
	.asciz "exBossEffectShotTask"