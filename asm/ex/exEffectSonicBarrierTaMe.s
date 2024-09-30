	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start ovl09_21654D4
ovl09_21654D4: // 0x021654D4
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _021656E8 // =0x02176484
	mov r4, r0
	str r4, [r1, #0x2c]
	ldr r0, [r1, #8]
	cmp r0, #0
	ldrne r0, [r1, #0x20]
	cmpne r0, #0
	beq _02165540
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _021656E8 // =0x02176484
	ldr r1, [r1, #8]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _021656E8 // =0x02176484
	ldr r1, [r1, #0x20]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _021656E8 // =0x02176484
	ldr r1, [r1, #8]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
_02165540:
	mov r0, r4
	bl ovl09_2161CB0
	ldr r0, _021656E8 // =0x02176484
	ldrsh r0, [r0, #4]
	cmp r0, #0
	bne _021655C4
	mov r1, #0x1e
	ldr r0, _021656EC // =aExtraExBb_7
	sub r2, r1, #0x1f
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _021656E8 // =0x02176484
	mov r0, r0, lsr #8
	str r0, [r1, #8]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _021656E8 // =0x02176484
	mov r0, r5
	str r1, [r2, #0x18]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x4f
	bl ovl09_21733D4
	ldr r1, _021656E8 // =0x02176484
	str r0, [r1, #0x44]
	mov r0, #0x50
	bl ovl09_21733D4
	ldr r1, _021656E8 // =0x02176484
	str r0, [r1, #0x48]
	ldr r0, [r1, #0x18]
	bl Asset3DSetup__Create
_021655C4:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _021656E8 // =0x02176484
	str r2, [sp]
	ldr r1, [r0, #0x18]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r1, #0
	ldr r0, _021656E8 // =0x02176484
	str r1, [sp]
	ldr r2, [r0, #0x44]
	mov r3, r1
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	mov r3, #0
	ldr r2, _021656E8 // =0x02176484
	str r3, [sp]
	ldr r2, [r2, #0x48]
	add r0, r4, #0x20
	mov r1, #4
	bl AnimatorMDL__SetAnimation
	add r0, r4, #0x300
	mov r3, #0
	strh r3, [r0, #0x48]
	ldr r0, [r4, #0x104]
	mov r2, #1
	str r0, [r4, #0x344]
_0216563C:
	mov r0, r2, lsl r3
	tst r0, #0x11
	beq _0216565C
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0216565C:
	add r3, r3, #1
	cmp r3, #5
	blo _0216563C
	mov r0, #0x46000
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r2, _021656F0 // =0x0000BFF4
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, _021656F4 // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r3, #0
	strb r3, [r4]
	ldrb r2, [r4, #5]
	add r0, r4, #0x350
	ldr r1, _021656E8 // =0x02176484
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
	ldrsh r2, [r1, #4]
	add r2, r2, #1
	strh r2, [r1, #4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021656E8: .word 0x02176484
_021656EC: .word aExtraExBb_7
_021656F0: .word 0x0000BFF4
_021656F4: .word 0x00007FF8
	arm_func_end ovl09_21654D4

	arm_func_start ovl09_21656F8
ovl09_21656F8: // 0x021656F8
	stmdb sp!, {r4, lr}
	ldr r1, _02165784 // =0x02176484
	mov r4, r0
	ldrsh r0, [r1, #4]
	cmp r0, #1
	bgt _02165768
	ldr r0, [r1, #0x18]
	cmp r0, #0
	beq _02165720
	bl NNS_G3dResDefaultRelease
_02165720:
	ldr r0, _02165784 // =0x02176484
	ldr r0, [r0, #0x44]
	cmp r0, #0
	beq _02165734
	bl NNS_G3dResDefaultRelease
_02165734:
	ldr r0, _02165784 // =0x02176484
	ldr r0, [r0, #0x48]
	cmp r0, #0
	beq _02165748
	bl NNS_G3dResDefaultRelease
_02165748:
	ldr r0, _02165784 // =0x02176484
	ldr r0, [r0, #0x18]
	cmp r0, #0
	beq _0216575C
	bl _FreeHEAP_USER
_0216575C:
	ldr r0, _02165784 // =0x02176484
	mov r1, #0
	str r1, [r0, #0x18]
_02165768:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _02165784 // =0x02176484
	ldrsh r1, [r0, #4]
	sub r1, r1, #1
	strh r1, [r0, #4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165784: .word 0x02176484
	arm_func_end ovl09_21656F8

	arm_func_start exExEffectSonicBarrierTaMeTask__Main
exExEffectSonicBarrierTaMeTask__Main: // 0x02165788
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02165808 // =0x02176484
	str r0, [r1, #0x34]
	add r0, r4, #8
	bl ovl09_21654D4
	add r0, r4, #0x394
	mov r1, #0xa800
	bl ovl09_21641E8
	add r0, r4, #0x394
	bl ovl09_2164218
	mov r0, #0x1000
	str r0, [r4]
	bl AllocSndHandle
	str r0, [r4, #4]
	mov r0, #0
	str r0, [sp]
	mov r1, #0x20
	str r1, [sp, #4]
	ldr r0, [r4, #4]
	sub r1, r1, #0x21
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _0216580C // =ovl09_2165874
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165808: .word 0x02176484
_0216580C: .word ovl09_2165874
	arm_func_end exExEffectSonicBarrierTaMeTask__Main

	arm_func_start exExEffectSonicBarrierTaMeTask__Func8
exExEffectSonicBarrierTaMeTask__Func8: // 0x02165810
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl ovl09_2172AE0
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02165834 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02165834: .word ExTask_State_Destroy
	arm_func_end exExEffectSonicBarrierTaMeTask__Func8

	arm_func_start exExEffectSonicBarrierTaMeTask__Destructor
exExEffectSonicBarrierTaMeTask__Destructor: // 0x02165838
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #4]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	ldr r0, [r4, #4]
	bl FreeSndHandle
	add r0, r4, #8
	bl ovl09_21656F8
	ldr r0, _02165870 // =0x02176484
	mov r1, #0
	str r1, [r0, #0x34]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165870: .word 0x02176484
	arm_func_end exExEffectSonicBarrierTaMeTask__Destructor

	arm_func_start ovl09_2165874
ovl09_2165874: // 0x02165874
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #8
	bl ovl09_2162164
	bl ovl09_216E3F4
	ldrsh r0, [r0, #0x44]
	cmp r0, #0
	beq _021659DC
	ldr r0, _02165A44 // =_0217441C
	mov r1, #0
	ldr r0, [r0, #0x30]
	bl _fgr
	ldr r0, _02165A48 // =0x45800000
	bls _021658CC
	ldr r1, _02165A44 // =_0217441C
	ldr r1, [r1, #0x30]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021658E0
_021658CC:
	ldr r1, _02165A44 // =_0217441C
	ldr r1, [r1, #0x30]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021658E0:
	bl _f_ftoi
	ldr r1, [r4, #0]
	cmp r1, r0
	blt _02165944
	ldr r0, _02165A44 // =_0217441C
	mov r1, #0
	ldr r0, [r0, #0x30]
	bl _fgr
	ldr r0, _02165A48 // =0x45800000
	bls _02165924
	ldr r1, _02165A44 // =_0217441C
	ldr r1, [r1, #0x30]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02165938
_02165924:
	ldr r1, _02165A44 // =_0217441C
	ldr r1, [r1, #0x30]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02165938:
	bl _f_ftoi
	str r0, [r4]
	b _021659EC
_02165944:
	ldr r1, _02165A44 // =_0217441C
	ldr r0, [r1, #0x30]
	ldr r1, [r1, #0]
	bl _f_sub
	ldr r1, _02165A4C // =0x42F00000
	bl _fdiv
	mov r1, #0
	bl _fgr
	bls _0216599C
	ldr r1, _02165A44 // =_0217441C
	ldr r0, [r1, #0x30]
	ldr r1, [r1, #0]
	bl _f_sub
	ldr r1, _02165A4C // =0x42F00000
	bl _fdiv
	mov r1, r0
	ldr r0, _02165A48 // =0x45800000
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021659C8
_0216599C:
	ldr r1, _02165A44 // =_0217441C
	ldr r0, [r1, #0x30]
	ldr r1, [r1, #0]
	bl _f_sub
	ldr r1, _02165A4C // =0x42F00000
	bl _fdiv
	mov r1, r0
	ldr r0, _02165A48 // =0x45800000
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021659C8:
	bl _f_ftoi
	ldr r1, [r4, #0]
	add r0, r1, r0
	str r0, [r4]
	b _021659EC
_021659DC:
	bl GetExTaskCurrent
	ldr r1, _02165A50 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021659EC:
	ldr r1, [r4, #0x4e4]
	add r0, r4, #8
	ldr r2, [r1, #0x350]
	add r1, r4, #0x394
	str r2, [r4, #0x358]
	ldr r2, [r4, #0x4e4]
	ldr r2, [r2, #0x354]
	str r2, [r4, #0x35c]
	ldr r2, [r4, #0x4e4]
	ldr r2, [r2, #0x358]
	str r2, [r4, #0x360]
	ldr r2, [r4, #0]
	str r2, [r4, #0x370]
	ldr r2, [r4, #0]
	str r2, [r4, #0x374]
	ldr r2, [r4, #0]
	str r2, [r4, #0x378]
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165A44: .word 0x0217441C
_02165A48: .word 0x45800000
_02165A4C: .word 0x42F00000
_02165A50: .word ExTask_State_Destroy
	arm_func_end ovl09_2165874

	arm_func_start exExEffectSonicBarrierTaMeTask__Create
exExEffectSonicBarrierTaMeTask__Create: // 0x02165A54
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _02165AD0 // =0x000004EC
	str r4, [sp]
	mov r6, r0
	ldr r0, _02165AD4 // =aExexeffectsoni
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02165AD8 // =exExEffectSonicBarrierTaMeTask__Main
	ldr r1, _02165ADC // =exExEffectSonicBarrierTaMeTask__Destructor
	mov r2, #0x2000
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, _02165AD0 // =0x000004EC
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	str r6, [r4, #0x4e4]
	bl GetCurrentTask
	str r0, [r4, #0x4e8]
	mov r0, r5
	bl GetExTask
	ldr r1, _02165AE0 // =exExEffectSonicBarrierTaMeTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02165AD0: .word 0x000004EC
_02165AD4: .word aExexeffectsoni
_02165AD8: .word exExEffectSonicBarrierTaMeTask__Main
_02165ADC: .word exExEffectSonicBarrierTaMeTask__Destructor
_02165AE0: .word exExEffectSonicBarrierTaMeTask__Func8
	arm_func_end exExEffectSonicBarrierTaMeTask__Create

	.data
	
_0217441C:
	.float 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 2.5, 2.5, 2.5, 0.0, 0.0, 0.0, 2.5, 2.5, 2.5, 0.0, 0.0, 0.0

aExtraExBb_7: // 0x02174464
	.asciz "/extra/ex.bb"
	.align 4
	
aExeffectbarrie: // 0x02174474
	.asciz "exEffectBarrierHitTask"
	.align 4
	
aExeffectbarrie_0: // 0x0217448C
	.asciz "exEffectBarrierTask"

aExexeffectsoni: // 0x021744A0
	.asciz "exExEffectSonicBarrierTaMeTask"