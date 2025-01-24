	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start exEffectBarrierHitTask__Func_2164950
exEffectBarrierHitTask__Func_2164950: // 0x02164950
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _02164BB4 // =0x02176484
	mov r4, r0
	str r4, [r1, #0x14]
	ldr r0, [r1, #0x3c]
	cmp r0, #0
	ldrne r0, [r1, #0x38]
	cmpne r0, #0
	beq _021649CC
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _02164BB4 // =0x02176484
	ldr r1, [r1, #0x3c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _02164BB4 // =0x02176484
	ldr r1, [r1, #0x38]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _02164BB4 // =0x02176484
	ldr r1, [r1, #0x3c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_021649CC:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, _02164BB4 // =0x02176484
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _02164A78
	mov r1, #0xa
	ldr r0, _02164BB8 // =aExtraExBb_7
	sub r2, r1, #0xb
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _02164BB4 // =0x02176484
	mov r0, r0, lsr #8
	str r0, [r1, #0x3c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02164BB4 // =0x02176484
	mov r0, r5
	str r1, [r2, #0x1c]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x20
	bl exSysTask__LoadExFile
	ldr r1, _02164BB4 // =0x02176484
	mov r2, #0
	str r0, [r1, #0x58]
	mov r0, #0x21
	str r2, [r1, #0x4c]
	bl exSysTask__LoadExFile
	ldr r1, _02164BB4 // =0x02176484
	mov r2, #1
	str r0, [r1, #0x5c]
	mov r0, #0x22
	str r2, [r1, #0x50]
	bl exSysTask__LoadExFile
	ldr r1, _02164BB4 // =0x02176484
	mov r2, #4
	str r0, [r1, #0x60]
	str r2, [r1, #0x54]
	ldr r0, [r1, #0x1c]
	bl Asset3DSetup__Create
_02164A78:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _02164BB4 // =0x02176484
	str r2, [sp]
	ldr r1, [r0, #0x1c]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, _02164BBC // =0x021764D0
	ldr r5, _02164BC0 // =0x021764DC
	mov r7, r8
_02164AB0:
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
	blo _02164AB0
	ldr r1, _02164BB4 // =0x02176484
	add r0, r4, #0x300
	ldr r2, [r1, #0x50]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x50]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_02164B04:
	mov r0, r2, lsl r3
	tst r0, #0x13
	beq _02164B24
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02164B24:
	add r3, r3, #1
	cmp r3, #5
	blo _02164B04
	mov r0, #0x3c000
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r2, _02164BC4 // =0x0000BFF4
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, _02164BC8 // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r3, #0
	strb r3, [r4]
	ldrb r2, [r4, #5]
	add r0, r4, #0x350
	ldr r1, _02164BB4 // =0x02176484
	bic r2, r2, #1
	orr r2, r2, #1
	strb r2, [r4, #5]
	str r3, [r4, #0xc]
	str r3, [r4, #0x10]
	str r3, [r4, #0x14]
	str r0, [r4, #0x18]
	ldrb r2, [r4, #0x38c]
	mov r0, #1
	bic r2, r2, #3
	orr r2, r2, #1
	strb r2, [r4, #0x38c]
	ldrsh r2, [r1, #0]
	add r2, r2, #1
	strh r2, [r1]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02164BB4: .word 0x02176484
_02164BB8: .word aExtraExBb_7
_02164BBC: .word 0x021764D0
_02164BC0: .word 0x021764DC
_02164BC4: .word 0x0000BFF4
_02164BC8: .word 0x00007FF8
	arm_func_end exEffectBarrierHitTask__Func_2164950

	arm_func_start exEffectBarrierHitTask__Destroy_2164BCC
exEffectBarrierHitTask__Destroy_2164BCC: // 0x02164BCC
	stmdb sp!, {r4, lr}
	ldr r1, _02164C6C // =0x02176484
	mov r4, r0
	ldrsh r0, [r1, #0]
	cmp r0, #1
	bgt _02164C50
	ldr r0, [r1, #0x1c]
	cmp r0, #0
	beq _02164BF4
	bl NNS_G3dResDefaultRelease
_02164BF4:
	ldr r0, _02164C6C // =0x02176484
	ldr r0, [r0, #0x58]
	cmp r0, #0
	beq _02164C08
	bl NNS_G3dResDefaultRelease
_02164C08:
	ldr r0, _02164C6C // =0x02176484
	ldr r0, [r0, #0x5c]
	cmp r0, #0
	beq _02164C1C
	bl NNS_G3dResDefaultRelease
_02164C1C:
	ldr r0, _02164C6C // =0x02176484
	ldr r0, [r0, #0x60]
	cmp r0, #0
	beq _02164C30
	bl NNS_G3dResDefaultRelease
_02164C30:
	ldr r0, _02164C6C // =0x02176484
	ldr r0, [r0, #0x1c]
	cmp r0, #0
	beq _02164C44
	bl _FreeHEAP_USER
_02164C44:
	ldr r0, _02164C6C // =0x02176484
	mov r1, #0
	str r1, [r0, #0x1c]
_02164C50:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _02164C6C // =0x02176484
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164C6C: .word 0x02176484
	arm_func_end exEffectBarrierHitTask__Destroy_2164BCC

	arm_func_start exEffectBarrierHitTask__Main
exEffectBarrierHitTask__Main: // 0x02164C70
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02164CB4 // =0x02176484
	str r0, [r1, #0x24]
	add r0, r4, #0x10
	bl exEffectBarrierHitTask__Func_2164950
	add r0, r4, #0x39c
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x39c
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _02164CB8 // =exEffectBarrierHitTask__Main_2164D08
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164CB4: .word 0x02176484
_02164CB8: .word exEffectBarrierHitTask__Main_2164D08
	arm_func_end exEffectBarrierHitTask__Main

	arm_func_start exEffectBarrierHitTask__Func8
exEffectBarrierHitTask__Func8: // 0x02164CBC
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetFlag_2178650
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02164CE0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02164CE0: .word ExTask_State_Destroy
	arm_func_end exEffectBarrierHitTask__Func8

	arm_func_start exEffectBarrierHitTask__Destructor
exEffectBarrierHitTask__Destructor: // 0x02164CE4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0x10
	bl exEffectBarrierHitTask__Destroy_2164BCC
	ldr r0, _02164D04 // =0x02176484
	mov r1, #0
	str r1, [r0, #0x24]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02164D04: .word 0x02176484
	arm_func_end exEffectBarrierHitTask__Destructor

	arm_func_start exEffectBarrierHitTask__Main_2164D08
exEffectBarrierHitTask__Main_2164D08: // 0x02164D08
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x10
	bl exDrawReqTask__Model__Animate
	ldr r1, [r4, #4]
	add r0, r4, #0x10
	str r1, [r4, #0x360]
	ldr r1, [r4, #8]
	str r1, [r4, #0x364]
	ldr r1, [r4, #0xc]
	str r1, [r4, #0x368]
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02164D54
	bl GetExTaskCurrent
	ldr r1, _02164D70 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02164D54:
	add r0, r4, #0x10
	add r1, r4, #0x39c
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164D70: .word ExTask_State_Destroy
	arm_func_end exEffectBarrierHitTask__Main_2164D08

	arm_func_start exEffectBarrierHitTask__Create
exEffectBarrierHitTask__Create: // 0x02164D74
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	movs r4, r0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r5, #0
	ldr r1, _02164E08 // =0x000004EC
	str r5, [sp]
	str r1, [sp, #4]
	ldr r0, _02164E0C // =aExeffectbarrie
	ldr r1, _02164E10 // =exEffectBarrierHitTask__Destructor
	str r0, [sp, #8]
	ldr r0, _02164E14 // =exEffectBarrierHitTask__Main
	mov r2, #0x2000
	mov r3, #5
	str r5, [sp, #0xc]
	bl ExTaskCreate_
	mov r6, r0
	bl GetExTaskWork_
	mov r1, r5
	ldr r2, _02164E08 // =0x000004EC
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
	ldr r1, _02164E18 // =exEffectBarrierHitTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02164E08: .word 0x000004EC
_02164E0C: .word aExeffectbarrie
_02164E10: .word exEffectBarrierHitTask__Destructor
_02164E14: .word exEffectBarrierHitTask__Main
_02164E18: .word exEffectBarrierHitTask__Func8
	arm_func_end exEffectBarrierHitTask__Create