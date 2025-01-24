	.include "asm/macros.inc"
	.include "global.inc"

	.bss

exBossMagmaAttackTask__ActiveInstanceCount: // 0x02176284
	.space 0x02

exBossMagmeWaveTask__ActiveInstanceCount: // 0x02176286
	.space 0x02

	.align 4

exBossMagmeWaveTask__unk_2176288: // 0x02176288
    .space 0x04
	
exBossMagmeWaveTask__TaskSingleton: // 0x0217628C
    .space 0x04
	
exBossMagmaAttackTask__TaskSingleton: // 0x02176290
    .space 0x04
	
exBossMagmeWaveTask__dword_2176294: // 0x02176294
    .space 0x04
	
exBossMagmeWaveTask__unk_2176298: // 0x02176298
    .space 0x04
	
exBossMagmeWaveTask__unk_217629C: // 0x0217629C
    .space 0x04
	
exBossMagmeWaveTask__dword_21762A0: // 0x021762A0
    .space 0x04
	
exBossMagmaAttackTask__dword_21762A4: // 0x021762A4
    .space 0x04
	
exBossMagmaAttackTask__unk_21762A8: // 0x021762A8
    .space 0x04
	
exBossMagmaAttackTask__unk_21762AC: // 0x021762AC
    .space 0x04
	
exBossMagmaAttackTask__unk_21762B0: // 0x021762B0
    .space 0x04
	
exBossMagmaAttackTask__unk_21762B4: // 0x021762B4
    .space 0x04
	
exBossMagmaAttackTask__AnimTable: // 0x021762B8
    .space 0x04 * 2
	
exBossMagmaAttackTask__FileTable: // 0x021762C0
    .space 0x04 * 2
	
exBossMagmeWaveTask__FileTable: // 0x021762C8
    .space 0x04 * 4
	
exBossMagmeWaveTask__AnimationTable: // 0x021762D8
    .space 0x04 * 4
	
	.text

	arm_func_start exBossMagmaAttackTask__Func_215FB1C
exBossMagmaAttackTask__Func_215FB1C: // 0x0215FB1C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _0215FD4C // =exBossMagmaAttackTask__ActiveInstanceCount
	mov r4, r0
	str r4, [r1, #0x24]
	ldr r0, [r1, #0x2c]
	cmp r0, #0
	ldrne r0, [r1, #0x28]
	cmpne r0, #0
	beq _0215FB98
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _0215FD4C // =exBossMagmaAttackTask__ActiveInstanceCount
	ldr r1, [r1, #0x2c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _0215FD4C // =exBossMagmaAttackTask__ActiveInstanceCount
	ldr r1, [r1, #0x28]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _0215FD4C // =exBossMagmaAttackTask__ActiveInstanceCount
	ldr r1, [r1, #0x2c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_0215FB98:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, _0215FD4C // =exBossMagmaAttackTask__ActiveInstanceCount
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _0215FC2C
	mov r1, #0xf
	ldr r0, _0215FD50 // =aExtraExBb_6
	sub r2, r1, #0x10
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _0215FD4C // =exBossMagmaAttackTask__ActiveInstanceCount
	mov r0, r0, lsr #8
	str r0, [r1, #0x2c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _0215FD4C // =exBossMagmaAttackTask__ActiveInstanceCount
	mov r0, r5
	str r1, [r2, #0x20]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x2d
	bl exSysTask__LoadExFile
	ldr r1, _0215FD4C // =exBossMagmaAttackTask__ActiveInstanceCount
	mov r2, #0
	str r0, [r1, #0x3c]
	mov r0, #0x2e
	str r2, [r1, #0x34]
	bl exSysTask__LoadExFile
	ldr r1, _0215FD4C // =exBossMagmaAttackTask__ActiveInstanceCount
	mov r2, #3
	str r0, [r1, #0x40]
	str r2, [r1, #0x38]
	ldr r0, [r1, #0x20]
	bl Asset3DSetup__Create
_0215FC2C:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _0215FD4C // =exBossMagmaAttackTask__ActiveInstanceCount
	str r2, [sp]
	ldr r1, [r0, #0x20]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, _0215FD54 // =exBossMagmaAttackTask__AnimTable
	ldr r5, _0215FD58 // =exBossMagmaAttackTask__FileTable
	mov r7, r8
_0215FC64:
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
	blo _0215FC64
	ldr r1, _0215FD4C // =exBossMagmaAttackTask__ActiveInstanceCount
	add r0, r4, #0x300
	ldr r2, [r1, #0x34]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x34]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_0215FCB8:
	mov r0, r2, lsl r3
	tst r0, #9
	beq _0215FCD8
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215FCD8:
	add r3, r3, #1
	cmp r3, #5
	blo _0215FCB8
	mov ip, #0
	str ip, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r1, _0215FD5C // =0x00003FFC
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #2]
	mov r1, #0x5000
	add r2, r4, #0x350
	orr r3, r3, #0x10
	strb r3, [r4, #2]
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	str ip, [r4, #0x14]
	ldr r1, _0215FD4C // =exBossMagmaAttackTask__ActiveInstanceCount
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #0]
	add r2, r2, #1
	strh r2, [r1]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215FD4C: .word exBossMagmaAttackTask__ActiveInstanceCount
_0215FD50: .word aExtraExBb_6
_0215FD54: .word exBossMagmaAttackTask__AnimTable
_0215FD58: .word exBossMagmaAttackTask__FileTable
_0215FD5C: .word 0x00003FFC
	arm_func_end exBossMagmaAttackTask__Func_215FB1C

	arm_func_start exBossMagmaAttackTask__Func_215FD60
exBossMagmaAttackTask__Func_215FD60: // 0x0215FD60
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r9, #0
	ldr r7, _0215FE00 // =exBossMagmaAttackTask__AnimTable
	ldr r6, _0215FE04 // =exBossMagmaAttackTask__FileTable
	mov r5, r0
	mov r4, r1
	mov r8, r9
_0215FD7C:
	str r8, [sp]
	ldr r1, [r7, r9, lsl #2]
	ldr r2, [r6, r9, lsl #2]
	mov r3, r4
	add r0, r5, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #2
	blo _0215FD7C
	ldr r1, _0215FE08 // =exBossMagmaAttackTask__ActiveInstanceCount
	add r0, r5, #0x300
	ldr r2, [r1, #0x34]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x34]
	mov r2, #1
	add r0, r5, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r5, #0x344]
_0215FDD0:
	mov r0, r2, lsl r3
	tst r0, #9
	beq _0215FDF0
	add r0, r5, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215FDF0:
	add r3, r3, #1
	cmp r3, #5
	blo _0215FDD0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0215FE00: .word exBossMagmaAttackTask__AnimTable
_0215FE04: .word exBossMagmaAttackTask__FileTable
_0215FE08: .word exBossMagmaAttackTask__ActiveInstanceCount
	arm_func_end exBossMagmaAttackTask__Func_215FD60

	arm_func_start exBossMagmaAttackTask__Destroy_215FE0C
exBossMagmaAttackTask__Destroy_215FE0C: // 0x0215FE0C
	stmdb sp!, {r4, lr}
	ldr r1, _0215FE98 // =exBossMagmaAttackTask__ActiveInstanceCount
	mov r4, r0
	ldrsh r0, [r1, #0]
	cmp r0, #1
	bgt _0215FE7C
	ldr r0, [r1, #0x20]
	cmp r0, #0
	beq _0215FE34
	bl NNS_G3dResDefaultRelease
_0215FE34:
	ldr r0, _0215FE98 // =exBossMagmaAttackTask__ActiveInstanceCount
	ldr r0, [r0, #0x3c]
	cmp r0, #0
	beq _0215FE48
	bl NNS_G3dResDefaultRelease
_0215FE48:
	ldr r0, _0215FE98 // =exBossMagmaAttackTask__ActiveInstanceCount
	ldr r0, [r0, #0x40]
	cmp r0, #0
	beq _0215FE5C
	bl NNS_G3dResDefaultRelease
_0215FE5C:
	ldr r0, _0215FE98 // =exBossMagmaAttackTask__ActiveInstanceCount
	ldr r0, [r0, #0x20]
	cmp r0, #0
	beq _0215FE70
	bl _FreeHEAP_USER
_0215FE70:
	ldr r0, _0215FE98 // =exBossMagmaAttackTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x20]
_0215FE7C:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _0215FE98 // =exBossMagmaAttackTask__ActiveInstanceCount
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215FE98: .word exBossMagmaAttackTask__ActiveInstanceCount
	arm_func_end exBossMagmaAttackTask__Destroy_215FE0C

	arm_func_start exBossMagmaAttackTask__Main
exBossMagmaAttackTask__Main: // 0x0215FE9C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _0215FF08 // =exBossMagmaAttackTask__ActiveInstanceCount
	str r0, [r1, #0xc]
	add r0, r4, #0x14
	bl exBossMagmaAttackTask__Func_215FB1C
	add r0, r4, #0x3a0
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x3a0
	bl exDrawReqTask__Func_2164218
	ldr r0, [r4, #0x10]
	mov r1, #0
	ldr r2, [r0, #0x3ec]
	mov r0, #0x3000
	str r2, [r4, #0x364]
	ldr r2, [r4, #0x10]
	ldr r2, [r2, #0x3f0]
	str r2, [r4, #0x368]
	str r1, [r4, #0x36c]
	str r0, [r4, #8]
	bl GetExTaskCurrent
	ldr r1, _0215FF0C // =exBossMagmaAttackTask__Main_215FF5C
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215FF08: .word exBossMagmaAttackTask__ActiveInstanceCount
_0215FF0C: .word exBossMagmaAttackTask__Main_215FF5C
	arm_func_end exBossMagmaAttackTask__Main

	arm_func_start exBossMagmaAttackTask__Func8
exBossMagmaAttackTask__Func8: // 0x0215FF10
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetFlag_2178650
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0215FF34 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215FF34: .word ExTask_State_Destroy
	arm_func_end exBossMagmaAttackTask__Func8

	arm_func_start exBossMagmaAttackTask__Destructor
exBossMagmaAttackTask__Destructor: // 0x0215FF38
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0x14
	bl exBossMagmaAttackTask__Destroy_215FE0C
	ldr r0, _0215FF58 // =exBossMagmaAttackTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0xc]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215FF58: .word exBossMagmaAttackTask__ActiveInstanceCount
	arm_func_end exBossMagmaAttackTask__Destructor

	arm_func_start exBossMagmaAttackTask__Main_215FF5C
exBossMagmaAttackTask__Main_215FF5C: // 0x0215FF5C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x14
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x14
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215FF88
	bl exBossMagmaAttackTask__Func_215FFFC
	ldmia sp!, {r4, pc}
_0215FF88:
	ldr r1, [r4, #0x368]
	ldr r0, [r4, #8]
	sub r0, r1, r0
	str r0, [r4, #0x368]
	ldr r1, [r4, #0x364]
	cmp r1, #0x5a000
	bge _0215FFCC
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _0215FFCC
	ldr r1, [r4, #0x368]
	cmp r1, #0xc8000
	bge _0215FFCC
	add r0, r0, #0x1e000
	cmp r1, r0
	bgt _0215FFDC
_0215FFCC:
	bl GetExTaskCurrent
	ldr r1, _0215FFF8 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215FFDC:
	add r0, r4, #0x14
	add r1, r4, #0x3a0
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215FFF8: .word ExTask_State_Destroy
	arm_func_end exBossMagmaAttackTask__Main_215FF5C

	arm_func_start exBossMagmaAttackTask__Func_215FFFC
exBossMagmaAttackTask__Func_215FFFC: // 0x0215FFFC
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x14
	mov r1, #1
	bl exBossMagmaAttackTask__Func_215FD60
	add r0, r4, #0x3a0
	bl exDrawReqTask__Func_2164218
	mov r0, #0x3000
	ldr lr, _02160080 // =_mt_math_rand
	str r0, [r4, #8]
	ldr r2, [lr]
	ldr r0, _02160084 // =0x00196225
	ldr r1, _02160088 // =0x3C6EF35F
	ldr ip, _0216008C // =0x66666667
	mla r0, r2, r0, r1
	mov r1, r0, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r2, r3, lsr #0x1f
	smull r3, r5, ip, r3
	add r5, r2, r5, asr #1
	mov ip, #5
	smull r2, r3, ip, r5
	rsb r5, r2, r1, lsr #16
	str r0, [lr]
	add r0, r5, #5
	strh r0, [r4]
	bl GetExTaskCurrent
	ldr r1, _02160090 // =exBossMagmaAttackTask__Main_2160094
	str r1, [r0]
	bl exBossMagmaAttackTask__Main_2160094
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02160080: .word _mt_math_rand
_02160084: .word 0x00196225
_02160088: .word 0x3C6EF35F
_0216008C: .word 0x66666667
_02160090: .word exBossMagmaAttackTask__Main_2160094
	arm_func_end exBossMagmaAttackTask__Func_215FFFC

	arm_func_start exBossMagmaAttackTask__Main_2160094
exBossMagmaAttackTask__Main_2160094: // 0x02160094
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x14
	bl exDrawReqTask__Model__Animate
	ldr r1, [r4, #0x368]
	ldr r0, [r4, #8]
	sub r0, r1, r0
	str r0, [r4, #0x368]
	ldrsh r0, [r4, #0]
	cmp r0, #0
	bgt _021600EC
	mov r1, #0
	add r0, r4, #0x3a0
	strh r1, [r4]
	bl exDrawReqTask__Func_21641F0
	add r0, r4, #0x14
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _021600F4
	bl exBossMagmaAttackTask__Func_2160160
	ldmia sp!, {r4, pc}
_021600EC:
	sub r0, r0, #1
	strh r0, [r4]
_021600F4:
	ldr r1, [r4, #0x364]
	cmp r1, #0x5a000
	bge _02160128
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _02160128
	ldr r1, [r4, #0x368]
	cmp r1, #0xc8000
	bge _02160128
	add r0, r0, #0x1e000
	cmp r1, r0
	bgt _02160138
_02160128:
	bl GetExTaskCurrent
	ldr r1, _0216015C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02160138:
	add r0, r4, #0x14
	add r1, r4, #0x3a0
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x14
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216015C: .word ExTask_State_Destroy
	arm_func_end exBossMagmaAttackTask__Main_2160094

	arm_func_start exBossMagmaAttackTask__Func_2160160
exBossMagmaAttackTask__Func_2160160: // 0x02160160
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x14
	mov r1, #2
	bl exBossMagmaAttackTask__Func_215FD60
	add r0, r4, #0x3a0
	bl exDrawReqTask__Func_21641F0
	add r0, r4, #0x3a0
	bl exDrawReqTask__Func_21641F0
	mov r0, #0x3000
	str r0, [r4, #8]
	bl GetExTaskCurrent
	ldr r1, _021601A4 // =exBossMagmaAttackTask__Main_21601A8
	str r1, [r0]
	bl exBossMagmaAttackTask__Main_21601A8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021601A4: .word exBossMagmaAttackTask__Main_21601A8
	arm_func_end exBossMagmaAttackTask__Func_2160160

	arm_func_start exBossMagmaAttackTask__Main_21601A8
exBossMagmaAttackTask__Main_21601A8: // 0x021601A8
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x14
	bl exDrawReqTask__Model__Animate
	ldr r2, [r4, #0x368]
	ldr r1, [r4, #8]
	add r0, r4, #0x14
	sub r1, r2, r1
	str r1, [r4, #0x368]
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _021601EC
	bl GetExTaskCurrent
	ldr r1, _0216024C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021601EC:
	ldr r1, [r4, #0x364]
	cmp r1, #0x5a000
	bge _02160220
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _02160220
	ldr r1, [r4, #0x368]
	cmp r1, #0xc8000
	bge _02160220
	add r0, r0, #0x1e000
	cmp r1, r0
	bgt _02160230
_02160220:
	bl GetExTaskCurrent
	ldr r1, _0216024C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02160230:
	add r0, r4, #0x14
	add r1, r4, #0x3a0
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216024C: .word ExTask_State_Destroy
	arm_func_end exBossMagmaAttackTask__Main_21601A8

	arm_func_start exBossMagmaAttackTask__Create
exBossMagmaAttackTask__Create: // 0x02160250
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x4f0
	ldr r0, _021602C4 // =aExbossmagmaatt
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _021602C8 // =exBossMagmaAttackTask__Main
	ldr r1, _021602CC // =exBossMagmaAttackTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x4f0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x10]
	mov r0, r5
	bl GetExTask
	ldr r1, _021602D0 // =exBossMagmaAttackTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021602C4: .word aExbossmagmaatt
_021602C8: .word exBossMagmaAttackTask__Main
_021602CC: .word exBossMagmaAttackTask__Destructor
_021602D0: .word exBossMagmaAttackTask__Func8
	arm_func_end exBossMagmaAttackTask__Create

	.data

aExtraExBb_6: // 0x02174394
	.asciz "/extra/ex.bb"
	.align 4
	
aExbossmagmaatt: // 0x021743A4
	.asciz "exBossMagmaAttackTask"