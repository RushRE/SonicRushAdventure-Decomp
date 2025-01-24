	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

exEffectBigBombTask__ActiveInstanceCount: // 0x02176464
	.space 0x02

exEffectBigBombTask__unk_217644C: // 0x02176466
	.space 0x02

exEffectBiriBiriTask__ActiveInstanceCount: // 0x02176468
	.space 0x02

	.align 4

exEffectBiriBiriTask__FileTable: // 0x0217646C
    .space 0x04
	
exEffectBiriBiriTask__unk_2176470: // 0x02176470
    .space 0x04
	
exEffectBigBombTask__TaskSingleton: // 0x02176474
    .space 0x04
	
exEffectBigBombTask__unk_2176478: // 0x02176478
    .space 0x04
	
exEffectBigBombTask__unk_217647C: // 0x0217647C
    .space 0x04
	
exEffectBiriBiriTask__TaskSingleton: // 0x02176480
    .space 0x04

	.text

	arm_func_start exEffectBiriBiriTask__Func_21645D4
exEffectBiriBiriTask__Func_21645D4: // 0x021645D4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r0
	bl exDrawReqTask__InitSprite3D
	ldr r0, _021646D0 // =exEffectBigBombTask__ActiveInstanceCount
	ldrsh r0, [r0, #4]
	cmp r0, #0
	bne _02164604
	mov r0, #0
	bl exSysTask__LoadExFile
	ldr r1, _021646D0 // =exEffectBigBombTask__ActiveInstanceCount
	str r0, [r1, #8]
_02164604:
	ldr r0, _021646D0 // =exEffectBigBombTask__ActiveInstanceCount
	mov r1, #1
	ldr r0, [r0, #8]
	bl Sprite__GetTextureSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocTexture
	ldr r1, _021646D0 // =exEffectBigBombTask__ActiveInstanceCount
	mov r5, r0
	ldr r0, [r1, #8]
	mov r1, #1
	bl Sprite__GetPaletteSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #4
	stmia sp, {r1, r5}
	str r0, [sp, #8]
	ldr r2, _021646D0 // =exEffectBigBombTask__ActiveInstanceCount
	add r0, r4, #0x20
	ldr r2, [r2, #8]
	mov r1, #0
	mov r3, #3
	bl AnimatorSprite3D__Init
	ldr r0, [r4, #0x114]
	mov r3, #0
	orr r0, r0, #0x800
	str r0, [r4, #0x114]
	strb r3, [r4]
	ldrb r2, [r4, #5]
	mov r1, #0x46000
	ldr r0, _021646D4 // =0x000004CD
	bic r2, r2, #1
	orr r2, r2, #1
	strb r2, [r4, #5]
	str r1, [r4, #0x134]
	str r0, [r4, #0x138]
	str r0, [r4, #0x13c]
	str r0, [r4, #0x140]
	ldrb r2, [r4, #0x150]
	ldr r0, _021646D0 // =exEffectBigBombTask__ActiveInstanceCount
	add r1, r4, #0x12c
	bic r2, r2, #3
	strb r2, [r4, #0x150]
	str r3, [r4, #0xc]
	str r3, [r4, #0x10]
	str r3, [r4, #0x14]
	str r1, [r4, #0x18]
	ldrsh r1, [r0, #4]
	add r1, r1, #1
	strh r1, [r0, #4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_021646D0: .word exEffectBigBombTask__ActiveInstanceCount
_021646D4: .word 0x000004CD
	arm_func_end exEffectBiriBiriTask__Func_21645D4

	arm_func_start exEffectBiriBiriTask__Func_21646D8
exEffectBiriBiriTask__Func_21646D8: // 0x021646D8
	ldr ip, _021646E8 // =AnimatorSprite__SetAnimation
	strh r1, [r0, #0x1c]
	add r0, r0, #0xb0
	bx ip
	.align 2, 0
_021646E8: .word AnimatorSprite__SetAnimation
	arm_func_end exEffectBiriBiriTask__Func_21646D8

	arm_func_start exEffectBiriBiriTask__Destroy_21646EC
exEffectBiriBiriTask__Destroy_21646EC: // 0x021646EC
	stmdb sp!, {r3, lr}
	add r0, r0, #0x20
	bl AnimatorSprite3D__Release
	ldr r0, _0216470C // =exEffectBigBombTask__ActiveInstanceCount
	ldrsh r1, [r0, #4]
	sub r1, r1, #1
	strh r1, [r0, #4]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216470C: .word exEffectBigBombTask__ActiveInstanceCount
	arm_func_end exEffectBiriBiriTask__Destroy_21646EC

	arm_func_start exEffectBiriBiriTask__Main
exEffectBiriBiriTask__Main: // 0x02164710
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02164774 // =exEffectBigBombTask__ActiveInstanceCount
	str r0, [r1, #0x1c]
	add r0, r4, #0xc
	bl exEffectBiriBiriTask__Func_21645D4
	add r0, r4, #0x15c
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x15c
	bl exDrawReqTask__Func_2164218
	ldr r0, [r4, #0]
	str r0, [r4, #0x138]
	ldr r0, [r4, #4]
	str r0, [r4, #0x13c]
	ldr r0, [r4, #8]
	sub r0, r0, #0x5000
	str r0, [r4, #0x140]
	bl GetExTaskCurrent
	ldr r1, _02164778 // =exEffectBiriBiriTask__Main_21647C8
	str r1, [r0]
	bl exEffectBiriBiriTask__Main_21647C8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164774: .word exEffectBigBombTask__ActiveInstanceCount
_02164778: .word exEffectBiriBiriTask__Main_21647C8
	arm_func_end exEffectBiriBiriTask__Main

	arm_func_start exEffectBiriBiriTask__Func8
exEffectBiriBiriTask__Func8: // 0x0216477C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetFlag_2178650
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _021647A0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021647A0: .word ExTask_State_Destroy
	arm_func_end exEffectBiriBiriTask__Func8

	arm_func_start exEffectBiriBiriTask__Destructor
exEffectBiriBiriTask__Destructor: // 0x021647A4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0xc
	bl exEffectBiriBiriTask__Destroy_21646EC
	ldr r0, _021647C4 // =exEffectBigBombTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x1c]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021647C4: .word exEffectBigBombTask__ActiveInstanceCount
	arm_func_end exEffectBiriBiriTask__Destructor

	arm_func_start exEffectBiriBiriTask__Main_21647C8
exEffectBiriBiriTask__Main_21647C8: // 0x021647C8
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0xc
	bl exDrawReqTask__Sprite3D__Animate
	bl exPlayerAdminTask__GetUnknown2
	ldrsh r0, [r0, #0x3c]
	cmp r0, #0
	bgt _021647F4
	bl exEffectBiriBiriTask__Func_2164810
	ldmia sp!, {r4, pc}
_021647F4:
	add r0, r4, #0xc
	add r1, r4, #0x15c
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exEffectBiriBiriTask__Main_21647C8

	arm_func_start exEffectBiriBiriTask__Func_2164810
exEffectBiriBiriTask__Func_2164810: // 0x02164810
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0xc
	mov r1, #4
	bl exEffectBiriBiriTask__Func_21646D8
	add r0, r4, #0x15c
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _02164844 // =exEffectBiriBiriTask__Main_2164848
	str r1, [r0]
	bl exEffectBiriBiriTask__Main_2164848
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164844: .word exEffectBiriBiriTask__Main_2164848
	arm_func_end exEffectBiriBiriTask__Func_2164810

	arm_func_start exEffectBiriBiriTask__Main_2164848
exEffectBiriBiriTask__Main_2164848: // 0x02164848
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0xc
	bl exDrawReqTask__Sprite3D__Animate
	add r0, r4, #0xc
	bl exDrawReqTask__Sprite3D__IsAnimFinished
	cmp r0, #0
	beq _0216487C
	bl GetExTaskCurrent
	ldr r1, _02164898 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0216487C:
	add r0, r4, #0xc
	add r1, r4, #0x15c
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164898: .word ExTask_State_Destroy
	arm_func_end exEffectBiriBiriTask__Main_2164848

	arm_func_start exEffectBiriBiriTask__Create
exEffectBiriBiriTask__Create: // 0x0216489C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	ldr r1, _0216493C // =exEffectBigBombTask__ActiveInstanceCount
	mov r4, r0
	ldr r0, [r1, #0x1c]
	cmp r0, #0
	addne sp, sp, #0x10
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	mov r5, #0
	str r5, [sp]
	mov r1, #0x2ac
	str r1, [sp, #4]
	ldr r0, _02164940 // =aExeffectbiribi
	ldr r1, _02164944 // =exEffectBiriBiriTask__Destructor
	str r0, [sp, #8]
	ldr r0, _02164948 // =exEffectBiriBiriTask__Main
	mov r2, #0x2000
	mov r3, #3
	str r5, [sp, #0xc]
	bl ExTaskCreate_
	mov r6, r0
	bl GetExTaskWork_
	mov r1, r5
	mov r2, #0x2ac
	mov r5, r0
	bl MI_CpuFill8
	ldr r1, [r4, #0]
	mov r0, r6
	str r1, [r5]
	ldr r1, [r4, #4]
	str r1, [r5, #4]
	ldr r1, [r4, #8]
	str r1, [r5, #8]
	bl GetExTask
	ldr r1, _0216494C // =exEffectBiriBiriTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216493C: .word exEffectBigBombTask__ActiveInstanceCount
_02164940: .word aExeffectbiribi
_02164944: .word exEffectBiriBiriTask__Destructor
_02164948: .word exEffectBiriBiriTask__Main
_0216494C: .word exEffectBiriBiriTask__Func8
	arm_func_end exEffectBiriBiriTask__Create

	.data

aExeffectbiribi: // 0x02174404
	.asciz "exEffectBiriBiriTask"