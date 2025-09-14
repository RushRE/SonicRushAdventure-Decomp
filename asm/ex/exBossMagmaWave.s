	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public exBossMagmaAttackTask__ActiveInstanceCount
exBossMagmaAttackTask__ActiveInstanceCount: // 0x02176284
	.space 0x02

.public exBossMagmeWaveTask__ActiveInstanceCount
exBossMagmeWaveTask__ActiveInstanceCount: // 0x02176286
	.space 0x02

	.align 4

.public exBossMagmeWaveTask__unk_2176288
exBossMagmeWaveTask__unk_2176288: // 0x02176288
    .space 0x04
	
.public exBossMagmeWaveTask__TaskSingleton
exBossMagmeWaveTask__TaskSingleton: // 0x0217628C
    .space 0x04
	
.public exBossMagmaAttackTask__TaskSingleton
exBossMagmaAttackTask__TaskSingleton: // 0x02176290
    .space 0x04
	
.public exBossMagmeWaveTask__dword_2176294
exBossMagmeWaveTask__dword_2176294: // 0x02176294
    .space 0x04
	
.public exBossMagmeWaveTask__unk_2176298
exBossMagmeWaveTask__unk_2176298: // 0x02176298
    .space 0x04
	
.public exBossMagmeWaveTask__unk_217629C
exBossMagmeWaveTask__unk_217629C: // 0x0217629C
    .space 0x04
	
.public exBossMagmeWaveTask__dword_21762A0
exBossMagmeWaveTask__dword_21762A0: // 0x021762A0
    .space 0x04
	
.public exBossMagmaAttackTask__dword_21762A4
exBossMagmaAttackTask__dword_21762A4: // 0x021762A4
    .space 0x04
	
.public exBossMagmaAttackTask__unk_21762A8
exBossMagmaAttackTask__unk_21762A8: // 0x021762A8
    .space 0x04
	
.public exBossMagmaAttackTask__unk_21762AC
exBossMagmaAttackTask__unk_21762AC: // 0x021762AC
    .space 0x04
	
.public exBossMagmaAttackTask__unk_21762B0
exBossMagmaAttackTask__unk_21762B0: // 0x021762B0
    .space 0x04
	
.public exBossMagmaAttackTask__unk_21762B4
exBossMagmaAttackTask__unk_21762B4: // 0x021762B4
    .space 0x04
	
.public exBossMagmaAttackTask__AnimTable
exBossMagmaAttackTask__AnimTable: // 0x021762B8
    .space 0x04 * 2
	
.public exBossMagmaAttackTask__FileTable
exBossMagmaAttackTask__FileTable: // 0x021762C0
    .space 0x04 * 2
	
.public exBossMagmeWaveTask__FileTable
exBossMagmeWaveTask__FileTable: // 0x021762C8
    .space 0x04 * 4
	
.public exBossMagmeWaveTask__AnimationTable
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
	bl LoadExSystemFile
	ldr r1, _0215FD4C // =exBossMagmaAttackTask__ActiveInstanceCount
	mov r2, #0
	str r0, [r1, #0x3c]
	mov r0, #0x2e
	str r2, [r1, #0x34]
	bl LoadExSystemFile
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
	bl CheckExStageFinished
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
	bl exHitCheckTask_AddHitCheck
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

	arm_func_start exBossMagmeWaveTask__Main_21602D4
exBossMagmeWaveTask__Main_21602D4: // 0x021602D4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _02160530 // =0x02176284
	mov r4, r0
	str r4, [r1, #0x14]
	ldr r0, [r1, #0x10]
	cmp r0, #0
	ldrne r0, [r1, #4]
	cmpne r0, #0
	beq _02160350
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _02160530 // =0x02176284
	ldr r1, [r1, #0x10]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _02160530 // =0x02176284
	ldr r1, [r1, #4]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _02160530 // =0x02176284
	ldr r1, [r1, #0x10]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02160350:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, _02160530 // =0x02176284
	ldrsh r0, [r0, #2]
	cmp r0, #0
	bne _02160414
	mov r1, #0x10
	ldr r0, _02160534 // =aExtraExBb_6
	sub r2, r1, #0x11
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _02160530 // =0x02176284
	mov r0, r0, lsr #8
	str r0, [r1, #0x10]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02160530 // =0x02176284
	mov r0, r5
	str r1, [r2, #0x1c]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x2f
	bl LoadExSystemFile
	ldr r1, _02160530 // =0x02176284
	mov r2, #0
	str r0, [r1, #0x44]
	mov r0, #0x30
	str r2, [r1, #0x54]
	bl LoadExSystemFile
	ldr r1, _02160530 // =0x02176284
	mov r2, #1
	str r0, [r1, #0x48]
	mov r0, #0x31
	str r2, [r1, #0x58]
	bl LoadExSystemFile
	ldr r1, _02160530 // =0x02176284
	mov r2, #3
	str r0, [r1, #0x4c]
	mov r0, #0x32
	str r2, [r1, #0x5c]
	bl LoadExSystemFile
	ldr r1, _02160530 // =0x02176284
	mov r2, #4
	str r0, [r1, #0x50]
	str r2, [r1, #0x60]
	ldr r0, [r1, #0x1c]
	bl Asset3DSetup__Create
_02160414:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _02160530 // =0x02176284
	str r2, [sp]
	ldr r1, [r0, #0x1c]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, _02160538 // =exBossMagmeWaveTask__AnimationTable
	ldr r5, _0216053C // =exBossMagmeWaveTask__FileTable
	mov r7, r8
_0216044C:
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
	blo _0216044C
	ldr r1, _02160530 // =0x02176284
	add r0, r4, #0x300
	ldr r2, [r1, #0x54]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x54]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_021604A0:
	mov r0, r2, lsl r3
	tst r0, #0x1b
	beq _021604C0
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_021604C0:
	add r3, r3, #1
	cmp r3, #5
	blo _021604A0
	mov ip, #0
	str ip, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r1, _02160540 // =0x00003FFC
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #2]
	add r2, r4, #0x350
	ldr r1, _02160530 // =0x02176284
	orr r3, r3, #8
	strb r3, [r4, #2]
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
_02160530: .word 0x02176284
_02160534: .word aExtraExBb_6
_02160538: .word exBossMagmeWaveTask__AnimationTable
_0216053C: .word exBossMagmeWaveTask__FileTable
_02160540: .word 0x00003FFC
	arm_func_end exBossMagmeWaveTask__Main_21602D4

	arm_func_start exBossMagmeWaveTask__Func_2160544
exBossMagmeWaveTask__Func_2160544: // 0x02160544
	stmdb sp!, {r4, lr}
	ldr r1, _021605F8 // =0x02176284
	mov r4, r0
	ldrsh r0, [r1, #2]
	cmp r0, #1
	bgt _021605DC
	ldr r0, [r1, #0x1c]
	cmp r0, #0
	beq _0216056C
	bl NNS_G3dResDefaultRelease
_0216056C:
	ldr r0, _021605F8 // =0x02176284
	ldr r0, [r0, #0x44]
	cmp r0, #0
	beq _02160580
	bl NNS_G3dResDefaultRelease
_02160580:
	ldr r0, _021605F8 // =0x02176284
	ldr r0, [r0, #0x48]
	cmp r0, #0
	beq _02160594
	bl NNS_G3dResDefaultRelease
_02160594:
	ldr r0, _021605F8 // =0x02176284
	ldr r0, [r0, #0x4c]
	cmp r0, #0
	beq _021605A8
	bl NNS_G3dResDefaultRelease
_021605A8:
	ldr r0, _021605F8 // =0x02176284
	ldr r0, [r0, #0x50]
	cmp r0, #0
	beq _021605BC
	bl NNS_G3dResDefaultRelease
_021605BC:
	ldr r0, _021605F8 // =0x02176284
	ldr r0, [r0, #0x1c]
	cmp r0, #0
	beq _021605D0
	bl _FreeHEAP_USER
_021605D0:
	ldr r0, _021605F8 // =0x02176284
	mov r1, #0
	str r1, [r0, #0x1c]
_021605DC:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _021605F8 // =0x02176284
	ldrsh r1, [r0, #2]
	sub r1, r1, #1
	strh r1, [r0, #2]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021605F8: .word 0x02176284
	arm_func_end exBossMagmeWaveTask__Func_2160544

	arm_func_start exBossMagmeWaveTask__Main
exBossMagmeWaveTask__Main: // 0x021605FC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02160660 // =0x02176284
	str r0, [r1, #8]
	add r0, r4, #0x14
	bl exBossMagmeWaveTask__Main_21602D4
	add r0, r4, #0x3a0
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x3a0
	bl exDrawReqTask__Func_21641F0
	ldr r1, [r4, #0x10]
	mov r0, #0
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x364]
	ldr r1, [r4, #0x10]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x368]
	str r0, [r4, #0x36c]
	bl GetExTaskCurrent
	ldr r1, _02160664 // =exBossMagmeWaveTask__Main_21606B4
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160660: .word 0x02176284
_02160664: .word exBossMagmeWaveTask__Main_21606B4
	arm_func_end exBossMagmeWaveTask__Main

	arm_func_start exBossMagmeWaveTask__Func8
exBossMagmeWaveTask__Func8: // 0x02160668
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0216068C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216068C: .word ExTask_State_Destroy
	arm_func_end exBossMagmeWaveTask__Func8

	arm_func_start exBossMagmeWaveTask__Destructor
exBossMagmeWaveTask__Destructor: // 0x02160690
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0x14
	bl exBossMagmeWaveTask__Func_2160544
	ldr r0, _021606B0 // =0x02176284
	mov r1, #0
	str r1, [r0, #8]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021606B0: .word 0x02176284
	arm_func_end exBossMagmeWaveTask__Destructor

	arm_func_start exBossMagmeWaveTask__Main_21606B4
exBossMagmeWaveTask__Main_21606B4: // 0x021606B4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x14
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x14
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _021606E8
	bl GetExTaskCurrent
	ldr r1, _02160704 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021606E8:
	add r0, r4, #0x14
	add r1, r4, #0x3a0
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160704: .word ExTask_State_Destroy
	arm_func_end exBossMagmeWaveTask__Main_21606B4

	arm_func_start exBossMagmeWaveTask__Create
exBossMagmeWaveTask__Create: // 0x02160708
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x4f0
	ldr r0, _0216077C // =aExbossmagmewav
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02160780 // =exBossMagmeWaveTask__Main
	ldr r1, _02160784 // =exBossMagmeWaveTask__Destructor
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
	ldr r1, _02160788 // =exBossMagmeWaveTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216077C: .word aExbossmagmewav
_02160780: .word exBossMagmeWaveTask__Main
_02160784: .word exBossMagmeWaveTask__Destructor
_02160788: .word exBossMagmeWaveTask__Func8
	arm_func_end exBossMagmeWaveTask__Create

	arm_func_start exBossSysAdminTask__Action_StartWave0
exBossSysAdminTask__Action_StartWave0: // 0x0216078C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0xf
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
	ldr r1, _021607E8 // =exBossSysAdminTask__Main_Wave0
	str r1, [r0]
	bl exBossSysAdminTask__Main_Wave0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021607E8: .word exBossSysAdminTask__Main_Wave0
	arm_func_end exBossSysAdminTask__Action_StartWave0

	arm_func_start exBossSysAdminTask__Main_Wave0
exBossSysAdminTask__Main_Wave0: // 0x021607EC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02160818
	bl exBossSysAdminTask__Action_StartWave1
	ldmia sp!, {r4, pc}
_02160818:
	add r0, r4, #0x6c
	bl exHitCheckTask_AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_Wave0

	arm_func_start exBossSysAdminTask__Action_StartWave1
exBossSysAdminTask__Action_StartWave1: // 0x0216083C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0x10
	bl exBossHelpers__SetAnimation
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _02160870 // =exBossSysAdminTask__Main_Wave1
	str r1, [r0]
	bl exBossSysAdminTask__Main_Wave1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160870: .word exBossSysAdminTask__Main_Wave1
	arm_func_end exBossSysAdminTask__Action_StartWave1

	arm_func_start exBossSysAdminTask__Main_Wave1
exBossSysAdminTask__Main_Wave1: // 0x02160874
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _021608A0
	bl exBossSysAdminTask__Action_StartWave2
	ldmia sp!, {r4, pc}
_021608A0:
	add r0, r4, #0x6c
	bl exHitCheckTask_AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_Wave1

	arm_func_start exBossSysAdminTask__Action_StartWave2
exBossSysAdminTask__Action_StartWave2: // 0x021608C4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0x11
	bl exBossHelpers__SetAnimation
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_21641F0
	mov r0, #0
	str r0, [r4, #0x30]
	bl GetExTaskCurrent
	ldr r1, _02160900 // =exBossSysAdminTask__Main_StartWave2
	str r1, [r0]
	bl exBossSysAdminTask__Main_StartWave2
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160900: .word exBossSysAdminTask__Main_StartWave2
	arm_func_end exBossSysAdminTask__Action_StartWave2

	arm_func_start exBossSysAdminTask__Main_StartWave2
exBossSysAdminTask__Main_StartWave2: // 0x02160904
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	ldr r0, [r4, #0x3c0]
	cmp r0, #0x78000
	ldrle r0, [r4, #0x30]
	cmple r0, #0x14000
	bgt _0216094C
	add r0, r0, #0xcd
	add r0, r0, #0xc00
	str r0, [r4, #0x30]
	ldr r0, [r4, #0x3c0]
	add r0, r0, #0xcd
	add r0, r0, #0xc00
	str r0, [r4, #0x3c0]
_0216094C:
	ldr r0, [r4, #0x3b0]
	ldr r0, [r0, #0]
	cmp r0, #0xf000
	blt _02160990
	mov r4, #0xc9
	sub r1, r4, #0xca
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _021609D4 // =exBossSysAdminTask__Main_ProcessWave2
	str r1, [r0]
	bl exBossSysAdminTask__Main_ProcessWave2
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02160990:
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _021609AC
	bl exBossSysAdminTask__Action_StartWave3
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_021609AC:
	add r0, r4, #0x6c
	bl exHitCheckTask_AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021609D4: .word exBossSysAdminTask__Main_ProcessWave2
	arm_func_end exBossSysAdminTask__Main_StartWave2

	arm_func_start exBossSysAdminTask__Main_ProcessWave2
exBossSysAdminTask__Main_ProcessWave2: // 0x021609D8
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	ldr r0, [r4, #0x3c0]
	cmp r0, #0x78000
	ldrle r0, [r4, #0x30]
	cmple r0, #0x14000
	bgt _02160A1C
	add r0, r0, #0xcd
	add r0, r0, #0xc00
	str r0, [r4, #0x30]
	ldr r0, [r4, #0x3c0]
	add r0, r0, #0xcd
	add r0, r0, #0xc00
	str r0, [r4, #0x3c0]
_02160A1C:
	ldr r0, [r4, #0x3b0]
	ldr r0, [r0, #0]
	cmp r0, #0x25000
	blt _02160A44
	bl exBossMagmeWaveTask__Create
	bl GetExTaskCurrent
	ldr r1, _02160A80 // =exBossSysAdminTask__Main_FinishWave2
	str r1, [r0]
	bl exBossSysAdminTask__Main_FinishWave2
	ldmia sp!, {r4, pc}
_02160A44:
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02160A5C
	bl exBossSysAdminTask__Action_StartWave3
	ldmia sp!, {r4, pc}
_02160A5C:
	add r0, r4, #0x6c
	bl exHitCheckTask_AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160A80: .word exBossSysAdminTask__Main_FinishWave2
	arm_func_end exBossSysAdminTask__Main_ProcessWave2

	arm_func_start exBossSysAdminTask__Main_FinishWave2
exBossSysAdminTask__Main_FinishWave2: // 0x02160A84
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02160AB0
	bl exBossSysAdminTask__Action_StartWave3
	ldmia sp!, {r4, pc}
_02160AB0:
	add r0, r4, #0x6c
	bl exHitCheckTask_AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_FinishWave2

	arm_func_start exBossSysAdminTask__Action_StartWave3
exBossSysAdminTask__Action_StartWave3: // 0x02160AD4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, _02160CA8 // =_mt_math_rand
	ldr r2, _02160CAC // =0x00196225
	ldr r5, [r1, #0]
	ldr r3, _02160CB0 // =0x3C6EF35F
	mov r4, r0
	mla r0, r5, r2, r3
	mla r2, r0, r2, r3
	mov r3, r0, lsr #0x10
	mov r0, r2, lsr #0x10
	mov r3, r3, lsl #0x10
	mov ip, r0, lsl #0x10
	mov r5, r3, lsr #0x10
	mov lr, ip, lsr #0x10
	ldr r8, _02160CB4 // =0x51EB851F
	mov r0, r5, lsr #0x1f
	smull r6, r5, r8, r5
	mov r7, lr, lsr #0x1f
	smull lr, r6, r8, lr
	add r5, r0, r5, asr #5
	mov lr, #0x64
	add r6, r7, r6, asr #5
	smull r5, r0, lr, r5
	smull r6, r0, lr, r6
	add r0, r4, #0x6c
	str r2, [r1]
	mov r1, #0x12
	rsb r5, r5, r3, lsr #16
	rsb r6, r6, ip, lsr #16
	bl exBossHelpers__SetAnimation
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_2164218
	cmp r5, #0x14
	bge _02160B70
	cmp r5, #0
	movge r0, #0xb4
	strgeh r0, [r4, #0x56]
	bge _02160B9C
_02160B70:
	cmp r5, #0x14
	blt _02160B88
	cmp r5, #0x46
	movlt r0, #0x12c
	strlth r0, [r4, #0x56]
	blt _02160B9C
_02160B88:
	cmp r5, #0x46
	blt _02160B9C
	cmp r5, #0x64
	movle r0, #0x1e0
	strleh r0, [r4, #0x56]
_02160B9C:
	cmp r6, #0x32
	bge _02160BC0
	cmp r5, #0
	blt _02160BC0
	ldr r0, [r4, #0x3bc]
	str r0, [r4, #0x14]
	ldr r0, [r4, #0x3bc]
	str r0, [r4, #0x20]
	b _02160C0C
_02160BC0:
	cmp r6, #0x32
	blt _02160BE8
	cmp r6, #0x50
	bge _02160BE8
	mov r0, #0xc800
	rsb r0, r0, #0
	str r0, [r4, #0x14]
	mov r0, #0xc800
	str r0, [r4, #0x20]
	b _02160C0C
_02160BE8:
	cmp r6, #0x50
	blt _02160C0C
	cmp r6, #0x64
	bgt _02160C0C
	mov r0, #0x19000
	rsb r0, r0, #0
	str r0, [r4, #0x14]
	mov r0, #0x19000
	str r0, [r4, #0x20]
_02160C0C:
	mov r6, #0
	str r6, [r4, #0x48]
	str r6, [r4, #0x4c]
	ldr r2, _02160CA8 // =_mt_math_rand
	str r6, [r4, #0x50]
	ldr r3, [r2, #0]
	ldr r0, _02160CAC // =0x00196225
	ldr r1, _02160CB0 // =0x3C6EF35F
	mla r5, r3, r0, r1
	mov r0, r5, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	adds r0, r1, r0, ror #31
	str r5, [r2]
	strne r6, [r4, #0xc]
	moveq r0, #1
	streq r0, [r4, #0xc]
	ldr r2, _02160CA8 // =_mt_math_rand
	ldr r0, _02160CAC // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02160CB0 // =0x3C6EF35F
	mla r5, r3, r0, r1
	mov r0, r5, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #31
	adds r0, r1, r0, ror #31
	movne r0, #0
	str r5, [r2]
	moveq r0, #1
	str r0, [r4, #0x10]
	bl GetExTaskCurrent
	ldr r1, _02160CB8 // =exBossSysAdminTask__Main_Wave3
	str r1, [r0]
	bl exBossSysAdminTask__Main_Wave3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02160CA8: .word _mt_math_rand
_02160CAC: .word 0x00196225
_02160CB0: .word 0x3C6EF35F
_02160CB4: .word 0x51EB851F
_02160CB8: .word exBossSysAdminTask__Main_Wave3
	arm_func_end exBossSysAdminTask__Action_StartWave3

	arm_func_start exBossSysAdminTask__Main_Wave3
exBossSysAdminTask__Main_Wave3: // 0x02160CBC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	ldr r0, [r4, #0x10]
	cmp r0, #0
	beq _02160CE8
	bl exBossSysAdminTask__WaveMoveL
	b _02160CEC
_02160CE8:
	bl exBossSysAdminTask__WaveMoveR
_02160CEC:
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _02160D00
	bl exBossSysAdminTask__WaveAngleMoveL
	b _02160D04
_02160D00:
	bl exBossSysAdminTask__WaveAngleMoveR
_02160D04:
	ldr r3, [r4, #0x48]
	ldr r0, [r4, #0x3bc]
	ldr r2, [r4, #0x3c0]
	ldr r1, [r4, #0x4c]
	sub r0, r3, r0
	sub r1, r2, r1
	bl exPlayerHelpers__Func_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0xb8]
	ldrsh r0, [r4, #0x56]
	cmp r0, #0
	bgt _02160D60
	mov r1, #0
	add r0, r4, #0x3f8
	strh r1, [r4, #0x56]
	bl exDrawReqTask__Func_21641F0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02160DAC
	bl exBossSysAdminTask__Action_StartWave4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02160D60:
	sub r0, r0, #1
	strh r0, [r4, #0x56]
	ldrsh ip, [r4, #0x56]
	ldr r3, _02160DD4 // =0x2AAAAAAB
	mov r2, #0xc
	mov r0, ip, lsr #0x1f
	smull r1, lr, r3, ip
	add lr, r0, lr, asr #1
	smull r0, r1, r2, lr
	subs lr, ip, r0
	bne _02160DAC
	mov ip, #0xca
	sub r1, ip, #0xcb
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	bl exBossMagmaAttackTask__Create
_02160DAC:
	add r0, r4, #0x6c
	bl exHitCheckTask_AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160DD4: .word 0x2AAAAAAB
	arm_func_end exBossSysAdminTask__Main_Wave3

	arm_func_start exBossSysAdminTask__WaveAngleMoveL
exBossSysAdminTask__WaveAngleMoveL: // 0x02160DD8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #0x5a000
	ldr r2, [r0, #0x48]
	rsb r1, r1, #0
	cmp r2, r1
	movle r1, #0
	strle r1, [r0, #0xc]
	subgt r1, r2, #0x4000
	strgt r1, [r0, #0x48]
	ldmia sp!, {r3, pc}
	arm_func_end exBossSysAdminTask__WaveAngleMoveL

	arm_func_start exBossSysAdminTask__WaveAngleMoveR
exBossSysAdminTask__WaveAngleMoveR: // 0x02160E04
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, [r0, #0x48]
	cmp r1, #0x5a000
	movge r1, #1
	strge r1, [r0, #0xc]
	addlt r1, r1, #0x4000
	strlt r1, [r0, #0x48]
	ldmia sp!, {r3, pc}
	arm_func_end exBossSysAdminTask__WaveAngleMoveR

	arm_func_start exBossSysAdminTask__WaveMoveL
exBossSysAdminTask__WaveMoveL: // 0x02160E28
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r2, [r0, #0x3bc]
	ldr r1, [r0, #0x14]
	cmp r2, r1
	movle r1, #0
	strle r1, [r0, #0x10]
	subgt r1, r2, #0x800
	strgt r1, [r0, #0x3bc]
	ldmia sp!, {r3, pc}
	arm_func_end exBossSysAdminTask__WaveMoveL

	arm_func_start exBossSysAdminTask__WaveMoveR
exBossSysAdminTask__WaveMoveR: // 0x02160E50
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r2, [r0, #0x3bc]
	ldr r1, [r0, #0x20]
	cmp r2, r1
	movge r1, #1
	strge r1, [r0, #0x10]
	addlt r1, r2, #0x800
	strlt r1, [r0, #0x3bc]
	ldmia sp!, {r3, pc}
	arm_func_end exBossSysAdminTask__WaveMoveR

	arm_func_start exBossSysAdminTask__Action_StartWave4
exBossSysAdminTask__Action_StartWave4: // 0x02160E78
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0x13
	bl exBossHelpers__SetAnimation
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _02160EAC // =exBossSysAdminTask__Main_Wave4
	str r1, [r0]
	bl exBossSysAdminTask__Main_Wave4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160EAC: .word exBossSysAdminTask__Main_Wave4
	arm_func_end exBossSysAdminTask__Action_StartWave4

	arm_func_start exBossSysAdminTask__Main_Wave4
exBossSysAdminTask__Main_Wave4: // 0x02160EB0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	ldr lr, [r4, #0x48]
	ldr r0, _02160F88 // =0x0000019A
	rsb r2, lr, #0
	umull ip, r3, r2, r0
	mov r1, #0
	mla r3, r2, r1, r3
	mov r2, r2, asr #0x1f
	mla r3, r2, r0, r3
	adds ip, ip, #0x800
	adc r2, r3, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, lr, r3
	str r2, [r4, #0x48]
	ldr lr, [r4, #0x4c]
	rsb r2, lr, #0
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r1, ip, #0x800
	adc r0, r3, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r2, lr, r1
	str r2, [r4, #0x4c]
	ldr r1, [r4, #0x48]
	ldr r0, [r4, #0x3bc]
	sub r0, r1, r0
	ldr r1, [r4, #0x3c0]
	sub r1, r1, r2
	bl exPlayerHelpers__Func_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0xb8]
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02160F64
	bl exBossSysAdminTask__Main_FinishWaveAttack
	ldmia sp!, {r4, pc}
_02160F64:
	add r0, r4, #0x6c
	bl exHitCheckTask_AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160F88: .word 0x0000019A
	arm_func_end exBossSysAdminTask__Main_Wave4

	arm_func_start exBossSysAdminTask__Main_FinishWaveAttack
exBossSysAdminTask__Main_FinishWaveAttack: // 0x02160F8C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, [r0, #0x548]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exBossSysAdminTask__Main_FinishWaveAttack


	.data

aExtraExBb_6: // 0x02174394
	.asciz "/extra/ex.bb"
	.align 4
	
aExbossmagmaatt: // 0x021743A4
	.asciz "exBossMagmaAttackTask"
	.align 4
	
aExbossmagmewav: // 0x021743BC
	.asciz "exBossMagmeWaveTask"
	.align 4