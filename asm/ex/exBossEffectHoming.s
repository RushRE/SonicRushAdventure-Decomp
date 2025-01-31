	.include "asm/macros.inc"
	.include "global.inc"

	.bss

exBossEffectHomingTask__ActiveInstanceCount: // 0x02175FC4
	.space 0x02

exBossEffectFireTask__ActiveInstanceCount: // 0x02175FC6
    .space 0x02
	
exBossEffectShotTask__ActiveInstanceCount: // 0x02175FC8
    .space 0x02

exBossEffectHitTask__ActiveInstanceCount: // 0x02175FCA
    .space 0x02

exBossEffectFireBallTask__ActiveInstanceCount: // 0x02175FCC
    .space 0x02

exBossEffectFireBallShotTask__ActiveInstanceCount: // 0x02175FCE
    .space 0x02

	.align 4

exBossEffectHitTask__unk_2175FD0: // 0x02175FD0
    .space 0x04

exBossEffectHitTask__unk_2175FD4: // 0x02175FD4
    .space 0x04

exBossEffectFireBallShotTask__unk_2175FD8: // 0x02175FD8
    .space 0x04

exBossEffectHitTask__unk_2175FDC: // 0x02175FDC
    .space 0x04

exBossEffectShotTask__dword_2175FE0: // 0x02175FE0
    .space 0x04

exBossEffectShotTask__unk_2175FE4: // 0x02175FE4
    .space 0x04

exBossEffectFireTask__TaskSingleton: // 0x02175FE8
    .space 0x04

exBossEffectFireTask__unk_2175FEC: // 0x02175FEC
    .space 0x04

exBossEffectFireTask__unk_2175FF0: // 0x02175FF0
    .space 0x04
	
exBossEffectFireBallTask__dword_2175FF4: // 0x02175FF4
    .space 0x04

exBossEffectFireTask__Ptr_2175FF8: // 0x02175FF8
    .space 0x04

exBossEffectFireTask__unk_2175FFC: // 0x02175FFC
    .space 0x04

exBossEffectHitTask__unk_2176000: // 0x02176000
    .space 0x04

exBossEffectShotTask__unk_2176004: // 0x02176004
    .space 0x04

exBossEffectShotTask__TaskSingleton: // 0x02176008
    .space 0x04

exBossEffectShotTask__unk_217600C: // 0x0217600C
    .space 0x04

exBossEffectFireBallShotTask__unk_2176010: // 0x02176010
    .space 0x04

exBossEffectShotTask__unk_2176014: // 0x02176014
    .space 0x04

exBossEffectShotTask__unk_2176018: // 0x02176018
    .space 0x04

exBossEffectShotTask__dword_217601C: // 0x0217601C
    .space 0x04

exBossEffectHitTask__dword_2176020: // 0x02176020
    .space 0x04

exBossEffectHomingTask__unk_2176024: // 0x02176024
    .space 0x04

exBossEffectHomingTask__TaskSingleton: // 0x02176028
    .space 0x04

exBossEffectHomingTask__unk_217602C: // 0x0217602C
    .space 0x04

exBossEffectHomingTask__dword_2176030: // 0x02176030
    .space 0x04

exBossEffectHomingTask__unk_2176034: // 0x02176034
    .space 0x04

exBossEffectHomingTask__unk_2176038: // 0x02176038
    .space 0x04
	
exBossEffectHomingTask__unk_217603C: // 0x0217603C
    .space 0x04

exBossEffectHomingTask__dword_2176040: // 0x02176040
    .space 0x04

exBossEffectHomingTask__unk_2176044: // 0x02176044
    .space 0x04

exBossEffectFireBallTask__TaskSingleton: // 0x02176048
    .space 0x04

exBossEffectFireBallTask__unk_217604C: // 0x0217604C
    .space 0x04

exBossEffectFireTask__Value_2176050: // 0x02176050
    .space 0x04

exBossEffectHitTask__dword_2176054: // 0x02176054
    .space 0x04

exBossEffectFireBallTask__unk_2176058: // 0x02176058
    .space 0x04

exBossEffectFireBallTask__Ptr_217605C: // 0x0217605C
    .space 0x04

exBossEffectHitTask__TaskSingleton: // 0x02176060
    .space 0x04

exBossEffectFireBallTask__unk_2176064: // 0x02176064
    .space 0x04

exBossEffectFireBallShotTask__TaskSingleton: // 0x02176068
    .space 0x04

exBossEffectFireBallShotTask__unk_217606C: // 0x0217606C
    .space 0x04

exBossEffectFireBallShotTask__unk_2176070: // 0x02176070
    .space 0x04

exBossEffectFireBallShotTask__unk_2176074: // 0x02176074
    .space 0x04

exBossEffectFireBallShotTask__FileTable: // 0x02176078
    .space 0x04 * 2

exBossEffectHitTask__FileTable: // 0x02176080
    .space 0x04 * 2

exBossEffectShotTask__AnimTable: // 0x02176088
    .space 0x04 * 2

exBossEffectShotTask__FileTable: // 0x02176090
    .space 0x04 * 2

exBossEffectFireBallShotTask__AnimTable: // 0x02176098
    .space 0x04 * 2

exBossEffectHitTask__AnimTable: // 0x021760A0
    .space 0x04 * 2

exBossEffectHomingTask__FileTable: // 0x021760A8
    .space 0x04 * 4

exBossEffectFireTask__AnimTable: // 0x021760B8
    .space 0x04 * 4

exBossEffectFireBallTask__AnimTable: // 0x021760C8
    .space 0x04 * 4

exBossEffectFireTask__FileTable: // 0x021760D8
    .space 0x04 * 4

exBossEffectFireBallTask__FileTable: // 0x021760E8
    .space 0x04 * 4

exBossEffectHomingTask__AnimTable: // 0x021760F8
    .space 0x04 * 4
	
	.text

	arm_func_start exBossEffectHomingTask__Func_2156D6C
exBossEffectHomingTask__Func_2156D6C: // 0x02156D6C
	ldr r0, _02156D7C // =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x80]
	bx lr
	.align 2, 0
_02156D7C: .word exBossEffectHomingTask__ActiveInstanceCount
	arm_func_end exBossEffectHomingTask__Func_2156D6C

	arm_func_start exBossEffectHomingTask__Func_2156D80
exBossEffectHomingTask__Func_2156D80: // 0x02156D80
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _0215700C // =exBossEffectHomingTask__ActiveInstanceCount
	mov r4, r0
	str r4, [r1, #0x70]
	ldr r0, [r1, #0x7c]
	cmp r0, #0
	ldrne r0, [r1, #0x68]
	cmpne r0, #0
	beq _02156DFC
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _0215700C // =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x7c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _0215700C // =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x68]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _0215700C // =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x7c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02156DFC:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, _0215700C // =exBossEffectHomingTask__ActiveInstanceCount
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _02156EC0
	mov r1, #0xe
	ldr r0, _02157010 // =aExtraExBb_2
	sub r2, r1, #0xf
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _0215700C // =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, r0, lsr #8
	str r0, [r1, #0x7c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _0215700C // =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, r5
	str r1, [r2, #0x6c]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x29
	bl LoadExSystemFile
	ldr r1, _0215700C // =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #0
	str r0, [r1, #0xe4]
	mov r0, #0x2a
	str r2, [r1, #0x134]
	bl LoadExSystemFile
	ldr r1, _0215700C // =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #1
	str r0, [r1, #0xe8]
	mov r0, #0x2b
	str r2, [r1, #0x138]
	bl LoadExSystemFile
	ldr r1, _0215700C // =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #3
	str r0, [r1, #0xec]
	mov r0, #0x2c
	str r2, [r1, #0x13c]
	bl LoadExSystemFile
	ldr r1, _0215700C // =exBossEffectHomingTask__ActiveInstanceCount
	mov r2, #2
	str r0, [r1, #0xf0]
	str r2, [r1, #0x140]
	ldr r0, [r1, #0x6c]
	bl Asset3DSetup__Create
_02156EC0:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _0215700C // =exBossEffectHomingTask__ActiveInstanceCount
	str r2, [sp]
	ldr r1, [r0, #0x6c]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, _02157014 // =0x021760F8
	ldr r5, _02157018 // =0x021760A8
	mov r7, r8
_02156EF8:
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
	blo _02156EF8
	ldr r0, _0215700C // =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x6c]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r2, _0215700C // =exBossEffectHomingTask__ActiveInstanceCount
	add r0, r4, #0x20
	ldr r1, [r2, #0x140]
	ldr r2, [r2, #0xf0]
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	ldr r1, _0215700C // =exBossEffectHomingTask__ActiveInstanceCount
	add r0, r4, #0x300
	ldr r2, [r1, #0x134]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x134]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_02156F74:
	mov r0, r2, lsl r3
	tst r0, #0xf
	beq _02156F94
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02156F94:
	add r3, r3, #1
	cmp r3, #5
	blo _02156F74
	mov r0, #0
	str r0, [r4, #0x358]
	mov ip, #0x1000
	str ip, [r4, #0x368]
	str ip, [r4, #0x36c]
	ldr r2, _0215701C // =0x0000BFF4
	str ip, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, _02157020 // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #1]
	add r2, r4, #0x350
	ldr r1, _0215700C // =exBossEffectHomingTask__ActiveInstanceCount
	orr r3, r3, #8
	strb r3, [r4, #1]
	str ip, [r4, #0xc]
	str ip, [r4, #0x10]
	str ip, [r4, #0x14]
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #0]
	add r2, r2, #1
	strh r2, [r1]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215700C: .word exBossEffectHomingTask__ActiveInstanceCount
_02157010: .word aExtraExBb_2
_02157014: .word 0x021760F8
_02157018: .word 0x021760A8
_0215701C: .word 0x0000BFF4
_02157020: .word 0x00007FF8
	arm_func_end exBossEffectHomingTask__Func_2156D80

	arm_func_start exBossEffectHomingTask__Func_2157024
exBossEffectHomingTask__Func_2157024: // 0x02157024
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r9, #0
	ldr r7, _021570EC // =0x021760F8
	ldr r6, _021570F0 // =0x021760A8
	mov r5, r0
	mov r4, r1
	mov r8, r9
_02157040:
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
	blo _02157040
	ldr r0, _021570F4 // =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x6c]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r0, _021570F4 // =exBossEffectHomingTask__ActiveInstanceCount
	mov r3, r4
	ldr r1, [r0, #0x140]
	ldr r2, [r0, #0xf0]
	add r0, r5, #0x20
	bl AnimatorMDL__SetAnimation
	ldr r1, _021570F4 // =exBossEffectHomingTask__ActiveInstanceCount
	add r0, r5, #0x300
	ldr r2, [r1, #0x134]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x134]
	mov r2, #1
	add r0, r5, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r5, #0x344]
_021570BC:
	mov r0, r2, lsl r3
	tst r0, #0xf
	beq _021570DC
	add r0, r5, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_021570DC:
	add r3, r3, #1
	cmp r3, #5
	blo _021570BC
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_021570EC: .word 0x021760F8
_021570F0: .word 0x021760A8
_021570F4: .word exBossEffectHomingTask__ActiveInstanceCount
	arm_func_end exBossEffectHomingTask__Func_2157024

	arm_func_start exBossEffectHomingTask__Destroy_21570F8
exBossEffectHomingTask__Destroy_21570F8: // 0x021570F8
	stmdb sp!, {r4, lr}
	ldr r1, _021571AC // =exBossEffectHomingTask__ActiveInstanceCount
	mov r4, r0
	ldrsh r0, [r1, #0]
	cmp r0, #1
	bgt _02157190
	ldr r0, [r1, #0x6c]
	cmp r0, #0
	beq _02157120
	bl NNS_G3dResDefaultRelease
_02157120:
	ldr r0, _021571AC // =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0xe4]
	cmp r0, #0
	beq _02157134
	bl NNS_G3dResDefaultRelease
_02157134:
	ldr r0, _021571AC // =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0xe8]
	cmp r0, #0
	beq _02157148
	bl NNS_G3dResDefaultRelease
_02157148:
	ldr r0, _021571AC // =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0xec]
	cmp r0, #0
	beq _0215715C
	bl NNS_G3dResDefaultRelease
_0215715C:
	ldr r0, _021571AC // =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0xf0]
	cmp r0, #0
	beq _02157170
	bl NNS_G3dResDefaultRelease
_02157170:
	ldr r0, _021571AC // =exBossEffectHomingTask__ActiveInstanceCount
	ldr r0, [r0, #0x6c]
	cmp r0, #0
	beq _02157184
	bl _FreeHEAP_USER
_02157184:
	ldr r0, _021571AC // =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x6c]
_02157190:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _021571AC // =exBossEffectHomingTask__ActiveInstanceCount
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021571AC: .word exBossEffectHomingTask__ActiveInstanceCount
	arm_func_end exBossEffectHomingTask__Destroy_21570F8

	arm_func_start exBossEffectHomingTask__Main
exBossEffectHomingTask__Main: // 0x021571B0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02157228 // =exBossEffectHomingTask__ActiveInstanceCount
	str r0, [r1, #0x64]
	add r0, r4, #4
	bl exBossEffectHomingTask__Func_2156D80
	add r0, r4, #0x390
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	mov r2, #1
	ldr r1, _02157228 // =exBossEffectHomingTask__ActiveInstanceCount
	mov r0, #0
	str r2, [r1, #0x60]
	str r0, [sp]
	mov r1, #0xc4
	str r1, [sp, #4]
	sub r1, r1, #0xc5
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _0215722C // =exBossEffectHomingTask__Func_2157294
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157228: .word exBossEffectHomingTask__ActiveInstanceCount
_0215722C: .word exBossEffectHomingTask__Func_2157294
	arm_func_end exBossEffectHomingTask__Main

	arm_func_start exBossEffectHomingTask__Func8
exBossEffectHomingTask__Func8: // 0x02157230
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	beq _02157250
	bl GetExTaskCurrent
	ldr r1, _0215726C // =ExTask_State_Destroy
	str r1, [r0]
_02157250:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	ldmneia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0215726C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215726C: .word ExTask_State_Destroy
	arm_func_end exBossEffectHomingTask__Func8

	arm_func_start exBossEffectHomingTask__Destructor
exBossEffectHomingTask__Destructor: // 0x02157270
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #4
	bl exBossEffectHomingTask__Destroy_21570F8
	ldr r0, _02157290 // =exBossEffectHomingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x64]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02157290: .word exBossEffectHomingTask__ActiveInstanceCount
	arm_func_end exBossEffectHomingTask__Destructor

	arm_func_start exBossEffectHomingTask__Func_2157294
exBossEffectHomingTask__Func_2157294: // 0x02157294
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl GetExBossTask
	cmp r0, #0
	bne _021572C4
	bl GetExTaskCurrent
	ldr r1, _0215731C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021572C4:
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
	beq _02157300
	bl exBossEffectHomingTask__Func_2157320
	ldmia sp!, {r4, pc}
_02157300:
	add r0, r4, #4
	add r1, r4, #0x390
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215731C: .word ExTask_State_Destroy
	arm_func_end exBossEffectHomingTask__Func_2157294

	arm_func_start exBossEffectHomingTask__Func_2157320
exBossEffectHomingTask__Func_2157320: // 0x02157320
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	mov r1, #1
	bl exBossEffectHomingTask__Func_2157024
	add r0, r4, #0x390
	bl exDrawReqTask__Func_2164218
	bl GetExTaskCurrent
	ldr r1, _02157354 // =exBossEffectHomingTask__Func_2157358
	str r1, [r0]
	bl exBossEffectHomingTask__Func_2157358
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157354: .word exBossEffectHomingTask__Func_2157358
	arm_func_end exBossEffectHomingTask__Func_2157320

	arm_func_start exBossEffectHomingTask__Func_2157358
exBossEffectHomingTask__Func_2157358: // 0x02157358
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl GetExBossTask
	cmp r0, #0
	bne _02157388
	bl GetExTaskCurrent
	ldr r1, _021573E0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02157388:
	ldr r1, [r4, #0x4e0]
	ldr r0, _021573E4 // =exBossEffectHomingTask__ActiveInstanceCount
	ldr r1, [r1, #0x3ec]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f0]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x3f4]
	str r1, [r4, #0x35c]
	ldr r0, [r0, #0x60]
	cmp r0, #0
	bne _021573C4
	bl exBossEffectHomingTask__Func_21573E8
	ldmia sp!, {r4, pc}
_021573C4:
	add r0, r4, #4
	add r1, r4, #0x390
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_021573E0: .word ExTask_State_Destroy
_021573E4: .word exBossEffectHomingTask__ActiveInstanceCount
	arm_func_end exBossEffectHomingTask__Func_2157358

	arm_func_start exBossEffectHomingTask__Func_21573E8
exBossEffectHomingTask__Func_21573E8: // 0x021573E8
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	mov r1, #2
	bl exBossEffectHomingTask__Func_2157024
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _0215741C // =exBossEffectHomingTask__Func_2157420
	str r1, [r0]
	bl exBossEffectHomingTask__Func_2157420
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215741C: .word exBossEffectHomingTask__Func_2157420
	arm_func_end exBossEffectHomingTask__Func_21573E8

	arm_func_start exBossEffectHomingTask__Func_2157420
exBossEffectHomingTask__Func_2157420: // 0x02157420
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	bl GetExBossTask
	cmp r0, #0
	bne _02157450
	bl GetExTaskCurrent
	ldr r1, _021574B0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02157450:
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
	beq _02157494
	bl GetExTaskCurrent
	ldr r1, _021574B0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02157494:
	add r0, r4, #4
	add r1, r4, #0x390
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_021574B0: .word ExTask_State_Destroy
	arm_func_end exBossEffectHomingTask__Func_2157420

	arm_func_start exBossEffectHomingTask__Create
exBossEffectHomingTask__Create: // 0x021574B4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _02157528 // =0x000004E4
	str r4, [sp]
	ldr r0, _0215752C // =aExbosseffectho
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02157530 // =exBossEffectHomingTask__Main
	ldr r1, _02157534 // =exBossEffectHomingTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, _02157528 // =0x000004E4
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x4e0]
	mov r0, r5
	bl GetExTask
	ldr r1, _02157538 // =exBossEffectHomingTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02157528: .word 0x000004E4
_0215752C: .word aExbosseffectho
_02157530: .word exBossEffectHomingTask__Main
_02157534: .word exBossEffectHomingTask__Destructor
_02157538: .word exBossEffectHomingTask__Func8
	arm_func_end exBossEffectHomingTask__Create

	.data
	
aExbosseffectho: // 0x02174024
	.asciz "exBossEffectHomingTask"