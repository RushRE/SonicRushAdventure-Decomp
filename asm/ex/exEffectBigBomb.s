	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start exEffectBigBombTask__Func_2164310
exEffectBigBombTask__Func_2164310: // 0x02164310
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r0
	bl exDrawReqTask__InitSprite3D
	ldr r0, _0216440C // =0x02176464
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _02164340
	mov r0, #0
	bl exSysTask__LoadExFile
	ldr r1, _0216440C // =0x02176464
	str r0, [r1, #0x14]
_02164340:
	ldr r0, _0216440C // =0x02176464
	mov r1, #1
	ldr r0, [r0, #0x14]
	bl Sprite__GetTextureSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocTexture
	ldr r1, _0216440C // =0x02176464
	mov r5, r0
	ldr r0, [r1, #0x14]
	mov r1, #1
	bl Sprite__GetPaletteSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #4
	stmia sp, {r1, r5}
	str r0, [sp, #8]
	ldr r2, _0216440C // =0x02176464
	add r0, r4, #0x20
	ldr r2, [r2, #0x14]
	mov r1, #0
	mov r3, #0xb
	bl AnimatorSprite3D__Init
	ldr r0, [r4, #0x114]
	mov r3, #0
	orr r0, r0, #0x800
	str r0, [r4, #0x114]
	strb r3, [r4]
	ldrb r2, [r4, #5]
	mov r1, #0x46000
	mov r0, #0x800
	bic r2, r2, #1
	orr r2, r2, #1
	strb r2, [r4, #5]
	str r1, [r4, #0x134]
	str r0, [r4, #0x138]
	str r0, [r4, #0x13c]
	str r0, [r4, #0x140]
	ldrb r2, [r4, #0x150]
	ldr r0, _0216440C // =0x02176464
	add r1, r4, #0x12c
	bic r2, r2, #3
	strb r2, [r4, #0x150]
	str r3, [r4, #0xc]
	str r3, [r4, #0x10]
	str r3, [r4, #0x14]
	str r1, [r4, #0x18]
	ldrsh r1, [r0, #0]
	add r1, r1, #1
	strh r1, [r0]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216440C: .word 0x02176464
	arm_func_end exEffectBigBombTask__Func_2164310

	arm_func_start exEffectBigBombTask__Destroy_2164410
exEffectBigBombTask__Destroy_2164410: // 0x02164410
	stmdb sp!, {r3, lr}
	add r0, r0, #0x20
	bl AnimatorSprite3D__Release
	ldr r0, _02164430 // =0x02176464
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02164430: .word 0x02176464
	arm_func_end exEffectBigBombTask__Destroy_2164410

	arm_func_start exEffectBigBombTask__Main
exEffectBigBombTask__Main: // 0x02164434
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02164494 // =0x02176464
	str r0, [r1, #0x10]
	add r0, r4, #0xc
	bl exEffectBigBombTask__Func_2164310
	add r0, r4, #0x15c
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x15c
	bl exDrawReqTask__Func_21641F0
	ldr r0, [r4, #0]
	str r0, [r4, #0x138]
	ldr r0, [r4, #4]
	str r0, [r4, #0x13c]
	ldr r0, [r4, #8]
	str r0, [r4, #0x140]
	bl GetExTaskCurrent
	ldr r1, _02164498 // =exEffectBigBombTask__Func_21644E8
	str r1, [r0]
	bl exEffectBigBombTask__Func_21644E8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164494: .word 0x02176464
_02164498: .word exEffectBigBombTask__Func_21644E8
	arm_func_end exEffectBigBombTask__Main

	arm_func_start exEffectBigBombTask__Func8
exEffectBigBombTask__Func8: // 0x0216449C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetFlag_2178650
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _021644C0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021644C0: .word ExTask_State_Destroy
	arm_func_end exEffectBigBombTask__Func8

	arm_func_start exEffectBigBombTask__Destructor
exEffectBigBombTask__Destructor: // 0x021644C4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0xc
	bl exEffectBigBombTask__Destroy_2164410
	ldr r0, _021644E4 // =0x02176464
	mov r1, #0
	str r1, [r0, #0x10]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021644E4: .word 0x02176464
	arm_func_end exEffectBigBombTask__Destructor

	arm_func_start exEffectBigBombTask__Func_21644E8
exEffectBigBombTask__Func_21644E8: // 0x021644E8
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0xc
	bl exDrawReqTask__Sprite3D__Animate
	add r0, r4, #0xc
	bl exDrawReqTask__Sprite3D__IsAnimFinished
	cmp r0, #0
	beq _0216451C
	bl GetExTaskCurrent
	ldr r1, _02164538 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0216451C:
	add r0, r4, #0xc
	add r1, r4, #0x15c
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164538: .word ExTask_State_Destroy
	arm_func_end exEffectBigBombTask__Func_21644E8

	arm_func_start exEffectBigBombTask__Create
exEffectBigBombTask__Create: // 0x0216453C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r5, #0
	mov r4, r0
	str r5, [sp]
	mov r1, #0x2ac
	str r1, [sp, #4]
	ldr r0, _021645C4 // =aExeffectbigbom
	ldr r1, _021645C8 // =exEffectBigBombTask__Destructor
	str r0, [sp, #8]
	ldr r0, _021645CC // =exEffectBigBombTask__Main
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
	ldr r1, _021645D0 // =exEffectBigBombTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021645C4: .word aExeffectbigbom
_021645C8: .word exEffectBigBombTask__Destructor
_021645CC: .word exEffectBigBombTask__Main
_021645D0: .word exEffectBigBombTask__Func8
	arm_func_end exEffectBigBombTask__Create

	.data
	
aExeffectbigbom: // 0x021743F0
	.asciz "exEffectBigBombTask"