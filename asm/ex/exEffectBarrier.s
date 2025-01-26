	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

exEffectBarrierHitTask__ActiveInstanceCount: // 0x02176484
	.space 0x02

exEffectBarrierTask__ActiveInstanceCount: // 0x02176486
	.space 0x02

exExEffectSonicBarrierTaMeTask__ActiveInstanceCount: // 0x02176488
	.space 0x02

	.align 4

exExEffectSonicBarrierTaMeTask__dword_217648C: // 0x0217648C
    .space 0x04
	
exEffectBarrierTask__unk_2176490: // 0x02176490
    .space 0x04
	
exEffectBarrierTask__unk_2176494: // 0x02176494
    .space 0x04

exEffectBarrierHitTask__unk_2176498: // 0x02176498
    .space 0x04
	
exExEffectSonicBarrierTaMeTask__dword_217649C: // 0x0217649C
    .space 0x04
	
exEffectBarrierHitTask__dword_21764A0: // 0x021764A0
    .space 0x04
	
exExEffectSonicBarrierTaMeTask__unk_21764A4: // 0x021764A4
    .space 0x04
	
exEffectBarrierHitTask__TaskSingleton: // 0x021764A8
    .space 0x04
	
exEffectBarrierTask__TaskSingleton: // 0x021764AC
    .space 0x04
	
exExEffectSonicBarrierTaMeTask__unk_21764B0: // 0x021764B0
    .space 0x04
	
exEffectBarrierTask__dword_21764B4: // 0x021764B4
    .space 0x04
	
exExEffectSonicBarrierTaMeTask__TaskSingleton: // 0x021764B8
    .space 0x04
	
exEffectBarrierHitTask__unk_21764BC: // 0x021764BC
    .space 0x04
	
exEffectBarrierHitTask__unk_21764C0: // 0x021764C0
    .space 0x04
	
exEffectBarrierHitTask__unk_21764C4: // 0x021764C4
    .space 0x04
	
exExEffectSonicBarrierTaMeTask__FileTable: // 0x021764C8
    .space 0x04 * 2
	
exEffectBarrierHitTask__AnimTable: // 0x021764D0
    .space 0x04 * 3
	
exEffectBarrierHitTask__FileTable: // 0x021764DC
    .space 0x04 * 3

	.text

	arm_func_start exEffectBarrierTask__Func_2164E1C
exEffectBarrierTask__Func_2164E1C: // 0x02164E1C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r0
	bl exDrawReqTask__InitSprite3D
	ldr r0, _02164F20 // =exEffectBarrierHitTask__ActiveInstanceCount
	ldrsh r0, [r0, #2]
	cmp r0, #0
	bne _02164E4C
	mov r0, #0
	bl LoadExSystemFile
	ldr r1, _02164F20 // =exEffectBarrierHitTask__ActiveInstanceCount
	str r0, [r1, #0x30]
_02164E4C:
	ldr r0, _02164F20 // =exEffectBarrierHitTask__ActiveInstanceCount
	mov r1, #1
	ldr r0, [r0, #0x30]
	bl Sprite__GetTextureSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocTexture
	ldr r1, _02164F20 // =exEffectBarrierHitTask__ActiveInstanceCount
	mov r5, r0
	ldr r0, [r1, #0x30]
	mov r1, #1
	bl Sprite__GetPaletteSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #4
	stmia sp, {r1, r5}
	str r0, [sp, #8]
	ldr r2, _02164F20 // =exEffectBarrierHitTask__ActiveInstanceCount
	mov r1, #0
	ldr r2, [r2, #0x30]
	add r0, r4, #0x20
	mov r3, r1
	bl AnimatorSprite3D__Init
	ldr r1, [r4, #0x114]
	mov r0, #2
	orr r1, r1, #0x800
	str r1, [r4, #0x114]
	strb r0, [r4]
	ldrb r2, [r4, #3]
	mov r1, #0x46000
	mov r0, #0x500
	orr r2, r2, #0x80
	strb r2, [r4, #3]
	str r1, [r4, #0x134]
	str r0, [r4, #0x138]
	str r0, [r4, #0x13c]
	mov r0, #0x1000
	str r0, [r4, #0x140]
	ldrb r2, [r4, #0x150]
	mov r1, #0x6400
	add r0, r4, #0x12c
	bic r2, r2, #3
	orr r2, r2, #1
	strb r2, [r4, #0x150]
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	str r1, [r4, #0x14]
	str r0, [r4, #0x18]
	ldr r0, _02164F20 // =exEffectBarrierHitTask__ActiveInstanceCount
	ldrsh r1, [r0, #2]
	add r1, r1, #1
	strh r1, [r0, #2]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02164F20: .word exEffectBarrierHitTask__ActiveInstanceCount
	arm_func_end exEffectBarrierTask__Func_2164E1C

	arm_func_start exEffectBarrierTask__Func_2164F24
exEffectBarrierTask__Func_2164F24: // 0x02164F24
	ldr ip, _02164F34 // =AnimatorSprite__SetAnimation
	strh r1, [r0, #0x1c]
	add r0, r0, #0xb0
	bx ip
	.align 2, 0
_02164F34: .word AnimatorSprite__SetAnimation
	arm_func_end exEffectBarrierTask__Func_2164F24

	arm_func_start exEffectBarrierTask__Destroy_2164F38
exEffectBarrierTask__Destroy_2164F38: // 0x02164F38
	stmdb sp!, {r3, lr}
	add r0, r0, #0x20
	bl AnimatorSprite3D__Release
	ldr r0, _02164F58 // =exEffectBarrierHitTask__ActiveInstanceCount
	ldrsh r1, [r0, #2]
	sub r1, r1, #1
	strh r1, [r0, #2]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02164F58: .word exEffectBarrierHitTask__ActiveInstanceCount
	arm_func_end exEffectBarrierTask__Destroy_2164F38

	arm_func_start exEffectBarrierTask__Main
exEffectBarrierTask__Main: // 0x02164F5C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02165020 // =exEffectBarrierHitTask__ActiveInstanceCount
	str r0, [r1, #0x28]
	add r0, r4, #8
	bl exEffectBarrierTask__Func_2164E1C
	add r0, r4, #0x158
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x158
	bl exDrawReqTask__Func_21641F0
	ldrsh r0, [r4, #0]
	strh r0, [r4, #0x10]
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _02164FD4
	ldr r0, [r4, #0x2a8]
	ldrsh r0, [r0, #8]
	cmp r0, #0x12
	bne _02165008
	mov r0, #0x780
	str r0, [r4, #0x140]
	str r0, [r4, #0x144]
	mov r0, #0x9600
	str r0, [r4, #0x14]
	str r0, [r4, #0x18]
	b _02165008
_02164FD4:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	ldreq r0, [r4, #0x2a8]
	ldreqsh r0, [r0, #8]
	cmpeq r0, #0x15
	bne _02165008
	mov r0, #0x780
	str r0, [r4, #0x140]
	str r0, [r4, #0x144]
	mov r0, #0x9600
	str r0, [r4, #0x14]
	str r0, [r4, #0x18]
_02165008:
	mov r0, #0
	strh r0, [r4, #2]
	bl GetExTaskCurrent
	ldr r1, _02165024 // =exEffectBarrierTask__Main_2165074
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165020: .word exEffectBarrierHitTask__ActiveInstanceCount
_02165024: .word exEffectBarrierTask__Main_2165074
	arm_func_end exEffectBarrierTask__Main

	arm_func_start exEffectBarrierTask__Func8
exEffectBarrierTask__Func8: // 0x02165028
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExSystemFlag_2178650
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0216504C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216504C: .word ExTask_State_Destroy
	arm_func_end exEffectBarrierTask__Func8

	arm_func_start exEffectBarrierTask__Destructor
exEffectBarrierTask__Destructor: // 0x02165050
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #8
	bl exEffectBarrierTask__Destroy_2164F38
	ldr r0, _02165070 // =exEffectBarrierHitTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x28]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02165070: .word exEffectBarrierHitTask__ActiveInstanceCount
	arm_func_end exEffectBarrierTask__Destructor

	arm_func_start exEffectBarrierTask__Main_2165074
exEffectBarrierTask__Main_2165074: // 0x02165074
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #8
	mov r1, #1
	bl exEffectBarrierTask__Func_2164F24
	add r0, r4, #0x158
	bl exDrawReqTask__Func_21641F0
	ldr r0, _021650CC // =exEffectBarrierHitTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0xc]
	ldr r0, [r4, #0x2a8]
	ldr r0, [r0, #0x350]
	str r0, [r4, #0x134]
	ldr r0, [r4, #0x2a8]
	ldr r0, [r0, #0x354]
	str r0, [r4, #0x138]
	bl GetExTaskCurrent
	ldr r1, _021650D0 // =exEffectBarrierTask__Main_21650D4
	str r1, [r0]
	bl exEffectBarrierTask__Main_21650D4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021650CC: .word exEffectBarrierHitTask__ActiveInstanceCount
_021650D0: .word exEffectBarrierTask__Main_21650D4
	arm_func_end exEffectBarrierTask__Main_2165074

	arm_func_start exEffectBarrierTask__Main_21650D4
exEffectBarrierTask__Main_21650D4: // 0x021650D4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #8
	bl exDrawReqTask__Sprite3D__Animate
	ldrb r0, [r4, #0xe]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _02165108
	add r0, r4, #0x134
	bl exEffectBarrierHitTask__Create
	bl exEffectBarrierTask__Func_2165150
	ldmia sp!, {r4, pc}
_02165108:
	add r0, r4, #8
	bl exDrawReqTask__Sprite3D__IsAnimFinished
	cmp r0, #0
	beq _02165128
	bl GetExTaskCurrent
	ldr r1, _0216514C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02165128:
	add r0, r4, #8
	add r1, r4, #0x158
	bl exDrawReqTask__AddRequest
	add r0, r4, #8
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216514C: .word ExTask_State_Destroy
	arm_func_end exEffectBarrierTask__Main_21650D4

	arm_func_start exEffectBarrierTask__Func_2165150
exEffectBarrierTask__Func_2165150: // 0x02165150
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _02165218
	ldr r0, [r4, #0x2a8]
	ldrsh r0, [r0, #8]
	cmp r0, #0x12
	bne _021651F8
	mov r0, #0x680
	str r0, [r4, #0x140]
	str r0, [r4, #0x144]
	mov r0, #0x8200
	str r0, [r4, #0x14]
	str r0, [r4, #0x18]
	bl GetExTaskCurrent
	mov r1, #5
	strh r1, [r0, #0x1c]
	ldr r0, [r4, #0x2ac]
	bl GetExTask
	mov r1, #5
	strh r1, [r0, #0x1c]
	ldr r3, [r4, #0x2a8]
	mov ip, #0x10
	ldrb r2, [r3, #0x38c]
	sub r1, ip, #0x11
	mov r0, #0
	bic r2, r2, #0xf0
	orr r2, r2, #0x50
	strb r2, [r3, #0x38c]
	ldrb lr, [r4, #0x158]
	mov r2, r1
	mov r3, r1
	bic lr, lr, #0xf0
	orr lr, lr, #0x50
	strb lr, [r4, #0x158]
	stmia sp, {r0, ip}
	bl PlaySfxEx
	b _021652CC
_021651F8:
	mov ip, #0xf
	sub r1, ip, #0x10
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	b _021652CC
_02165218:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _021652CC
	ldr r0, [r4, #0x2a8]
	ldrsh r0, [r0, #8]
	cmp r0, #0x15
	bne _021652B0
	mov r0, #0x680
	str r0, [r4, #0x140]
	str r0, [r4, #0x144]
	mov r0, #0x8200
	str r0, [r4, #0x14]
	str r0, [r4, #0x18]
	bl GetExTaskCurrent
	mov r1, #5
	strh r1, [r0, #0x1c]
	ldr r0, [r4, #0x2ac]
	bl GetExTask
	mov r1, #5
	strh r1, [r0, #0x1c]
	ldr r3, [r4, #0x2a8]
	mov ip, #0x10
	ldrb r2, [r3, #0x38c]
	sub r1, ip, #0x11
	mov r0, #0
	bic r2, r2, #0xf0
	orr r2, r2, #0x50
	strb r2, [r3, #0x38c]
	ldrb lr, [r4, #0x158]
	mov r2, r1
	mov r3, r1
	bic lr, lr, #0xf0
	orr lr, lr, #0x50
	strb lr, [r4, #0x158]
	stmia sp, {r0, ip}
	bl PlaySfxEx
	b _021652CC
_021652B0:
	mov ip, #0xf
	sub r1, ip, #0x10
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
_021652CC:
	add r0, r4, #8
	mov r1, #2
	bl exEffectBarrierTask__Func_2164F24
	add r0, r4, #0x158
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _021652F8 // =exEffectBarrierTask__Main_21652FC
	str r1, [r0]
	bl exEffectBarrierTask__Main_21652FC
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021652F8: .word exEffectBarrierTask__Main_21652FC
	arm_func_end exEffectBarrierTask__Func_2165150

	arm_func_start exEffectBarrierTask__Main_21652FC
exEffectBarrierTask__Main_21652FC: // 0x021652FC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #8
	bl exDrawReqTask__Sprite3D__Animate
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _02165344
	ldr r1, [r4, #0x2a8]
	ldrsh r0, [r1, #8]
	cmp r0, #0x12
	bne _02165370
	add r0, r1, #0x38c
	bl exDrawReqTask__Func_21642BC
	add r0, r4, #0x158
	bl exDrawReqTask__Func_21642BC
	b _02165370
_02165344:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	ldreq r1, [r4, #0x2a8]
	ldreqsh r0, [r1, #8]
	cmpeq r0, #0x15
	bne _02165370
	add r0, r1, #0x38c
	bl exDrawReqTask__Func_21642BC
	add r0, r4, #0x158
	bl exDrawReqTask__Func_21642BC
_02165370:
	add r0, r4, #8
	bl exDrawReqTask__Sprite3D__IsAnimFinished
	cmp r0, #0
	beq _021653AC
	ldr r1, [r4, #0x2a8]
	ldrb r0, [r1, #0x38c]
	bic r0, r0, #0xf0
	strb r0, [r1, #0x38c]
	ldrb r0, [r4, #0x158]
	bic r0, r0, #0xf0
	strb r0, [r4, #0x158]
	bl GetExTaskCurrent
	ldr r1, _021653C8 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021653AC:
	add r0, r4, #8
	add r1, r4, #0x158
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_021653C8: .word ExTask_State_Destroy
	arm_func_end exEffectBarrierTask__Main_21652FC

	arm_func_start exEffectBarrierTask__DelayCallback
exEffectBarrierTask__DelayCallback: // 0x021653CC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #0x2a8]
	add r0, r0, #0x38c
	bl exDrawReqTask__Func_21642BC
	add r0, r4, #0x158
	bl exDrawReqTask__Func_21642BC
	add r0, r4, #8
	add r1, r4, #0x158
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exEffectBarrierTask__DelayCallback

	arm_func_start exEffectBarrierTask__Create
exEffectBarrierTask__Create: // 0x02165408
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	ldr r1, _021654BC // =exEffectBarrierHitTask__ActiveInstanceCount
	mov r5, r0
	ldr r0, [r1, #0xc]
	cmp r0, #0
	addne sp, sp, #0x10
	ldmneia sp!, {r4, r5, r6, pc}
	mov r4, #0
	str r4, [sp]
	mov r1, #0x2b0
	ldr r0, _021654C0 // =aExeffectbarrie_0
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _021654C4 // =exEffectBarrierTask__Main
	ldr r1, _021654C8 // =exEffectBarrierTask__Destructor
	mov r2, #0x2000
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	ldr r1, _021654BC // =exEffectBarrierHitTask__ActiveInstanceCount
	mov r2, #1
	mov r4, r0
	str r2, [r1, #0xc]
	bl GetExTaskWork_
	mov r6, r0
	mov r1, #0
	mov r2, #0x2b0
	bl MI_CpuFill8
	str r5, [r6, #0x2a8]
	bl GetCurrentTask
	str r0, [r6, #0x2ac]
	ldr r1, [r6, #0x2a8]
	mov r0, r4
	ldrsh r1, [r1, #8]
	strh r1, [r6]
	bl GetExTask
	ldr r1, _021654CC // =exEffectBarrierTask__Func8
	str r1, [r0, #8]
	mov r0, r4
	bl GetExTask
	ldr r1, _021654D0 // =exEffectBarrierTask__DelayCallback
	str r1, [r0, #0x10]
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021654BC: .word exEffectBarrierHitTask__ActiveInstanceCount
_021654C0: .word aExeffectbarrie_0
_021654C4: .word exEffectBarrierTask__Main
_021654C8: .word exEffectBarrierTask__Destructor
_021654CC: .word exEffectBarrierTask__Func8
_021654D0: .word exEffectBarrierTask__DelayCallback
	arm_func_end exEffectBarrierTask__Create