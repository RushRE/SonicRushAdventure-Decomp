	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

exDrawFadeTask__word_2176444: // 0x02176444
	.space 0x04

exDrawFadeTask__word_2176448: // 0x02176448
	.space 0x04

exDrawReqTask__word_217644C: // 0x0217644C
	.space 0x02

	.align 4

exDrawReqTask__unk_2176450: // 0x02176450
    .space 0x04
	
exDrawReqTask__dword_2176454: // 0x02176454
    .space 0x04
	
exDrawReqTask__Value_2176458: // 0x02176458
    .space 0x04
	
exDrawReqTask__dword_217645C: // 0x0217645C
    .space 0x04
	
exDrawReqTask__unk_2176460: // 0x02176460
    .space 0x04

	.text

	arm_func_start exDrawReqTask__Main
exDrawReqTask__Main: // 0x02163E28
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, _02163E68 // =0x00076200
	bl _AllocHeadHEAP_USER
	ldr r1, _02163E6C // =exDrawReqTask__word_217644C
	str r0, [r1, #0xc]
	bl exDrawReqTask__Func_21641C8
	ldr r0, [r4, #4]
	bl exDrawReqTask__InitUnknown2
	bl exDrawReqTask__InitUnknown3
	bl GetExTaskCurrent
	ldr r1, _02163E70 // =exDrawReqTask__Main_Process
	str r1, [r0]
	bl exDrawReqTask__Main_Process
	ldmia sp!, {r4, pc}
	.align 2, 0
_02163E68: .word 0x00076200
_02163E6C: .word exDrawReqTask__word_217644C
_02163E70: .word exDrawReqTask__Main_Process
	arm_func_end exDrawReqTask__Main

	arm_func_start exDrawReqTask__Func8
exDrawReqTask__Func8: // 0x02163E74
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02163E98 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02163E98: .word ExTask_State_Destroy
	arm_func_end exDrawReqTask__Func8

	arm_func_start exDrawReqTask__Destructor
exDrawReqTask__Destructor: // 0x02163E9C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, _02163EC0 // =exDrawReqTask__word_217644C
	ldr r0, [r0, #0xc]
	bl _FreeHEAP_USER
	ldr r0, _02163EC0 // =exDrawReqTask__word_217644C
	mov r1, #0
	str r1, [r0, #0xc]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02163EC0: .word exDrawReqTask__word_217644C
	arm_func_end exDrawReqTask__Destructor

	arm_func_start exDrawReqTask__Main_Process
exDrawReqTask__Main_Process: // 0x02163EC4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, _02163FB4 // =exDrawReqTask__word_217644C
	mov r4, r0
	ldr r1, [r1, #8]
	str r1, [r4, #4]
	cmp r1, #0
	beq _02163F74
_02163EE4:
	ldrh r0, [r1, #0]
	cmp r0, #0
	ldrneh r0, [r1, #2]
	cmpne r0, #0
	ldrne r0, [r1, #0xc]
	cmpne r0, #0
	ldrneh r0, [r1, #4]
	cmpne r0, #0
	beq _02163F74
	cmp r0, #2
	bne _02163F20
	add r0, r1, #0x38c
	add r0, r0, #0x400
	bl exDrawReqTask__Sprite2D__ProcessRequest
	b _02163F60
_02163F20:
	cmp r0, #1
	bne _02163F34
	add r0, r1, #0x10
	bl exDrawReqTask__Model__ProcessRequest
	b _02163F60
_02163F34:
	cmp r0, #3
	bne _02163F4C
	add r0, r1, #0xec
	add r0, r0, #0x400
	bl exDrawReqTask__Sprite3D__ProcessRequest
	b _02163F60
_02163F4C:
	cmp r0, #4
	bne _02163F60
	add r0, r1, #0x14
	add r0, r0, #0x800
	bl exDrawReqTask__Trail__ProcessRequest
_02163F60:
	ldr r0, [r4, #4]
	ldr r1, [r0, #8]
	str r1, [r4, #4]
	cmp r1, #0
	bne _02163EE4
_02163F74:
	bl exHitCheckTask__Func_216ADBC
	cmp r0, #0
	beq _02163F8C
	mov r0, #1
	bl EnableExTaskNoUpdate
	b _02163FA4
_02163F8C:
	mov r0, #0
	bl EnableExTaskNoUpdate
	ldr r0, [r4, #4]
	bl exDrawReqTask__InitUnknown2
	bl exDrawReqTask__Func_21641C8
	bl exPlayerHelpers__Func_2152CB4
_02163FA4:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02163FB4: .word exDrawReqTask__word_217644C
	arm_func_end exDrawReqTask__Main_Process

	arm_func_start exDrawReqTask__Create
exDrawReqTask__Create: // 0x02163FB8
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r0, #0
	str r0, [sp]
	mov r0, #8
	ldr r3, _02164020 // =aExdrawreqtask
	str r0, [sp, #4]
	ldr r0, _02164024 // =exDrawReqTask__Main
	ldr r1, _02164028 // =exDrawReqTask__Destructor
	ldr r2, _0216402C // =0x0000EFFE
	str r3, [sp, #8]
	mov r4, #1
	mov r3, #3
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r1, #0
	mov r2, #8
	bl MI_CpuFill8
	mov r0, r4
	bl GetExTask
	ldr r1, _02164030 // =exDrawReqTask__Func8
	str r1, [r0, #8]
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164020: .word aExdrawreqtask
_02164024: .word exDrawReqTask__Main
_02164028: .word exDrawReqTask__Destructor
_0216402C: .word 0x0000EFFE
_02164030: .word exDrawReqTask__Func8
	arm_func_end exDrawReqTask__Create

	arm_func_start exDrawReqTask__AddRequest
exDrawReqTask__AddRequest: // 0x02164034
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	bl CheckExStageFinished
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, _02164168 // =0x0217644C
	ldrh r1, [r0, #0]
	cmp r1, #0xa0
	ldmhsia sp!, {r4, r5, r6, r7, r8, pc}
	ldrb r1, [r7, #1]
	ldr r6, [r0, #4]
	ldr r4, [r0, #8]
	mov r0, r1, lsl #0x18
	mov r0, r0, lsr #0x1d
	strh r0, [r6, #4]
	ldrh r1, [r6, #4]
	mov r0, r8
	ldr r5, _0216416C // =0x02176454
	bl exHitCheckTask__DoArenaBoundsCheck
	ldrh r0, [r6, #4]
	cmp r0, #2
	bne _021640A8
	add r1, r6, #0x38c
	mov r0, r8
	add r1, r1, #0x400
	mov r2, #0x88
	bl MI_CpuCopy8
	b _02164100
_021640A8:
	cmp r0, #1
	bne _021640C4
	ldr r2, _02164170 // =0x000004DC
	mov r0, r8
	add r1, r6, #0x10
	bl MI_CpuCopy8
	b _02164100
_021640C4:
	cmp r0, #3
	bne _021640E4
	add r1, r6, #0xec
	mov r0, r8
	add r1, r1, #0x400
	mov r2, #0x2a0
	bl MI_CpuCopy8
	b _02164100
_021640E4:
	cmp r0, #4
	bne _02164100
	add r1, r6, #0x14
	mov r0, r8
	add r1, r1, #0x800
	mov r2, #0x3bc
	bl MI_CpuCopy8
_02164100:
	ldr r0, _02164168 // =0x0217644C
	cmp r4, #0
	ldrh r1, [r0, #0]
	add r1, r1, #1
	strh r1, [r0]
	ldrh r0, [r0, #0]
	strh r0, [r6]
	ldrh r0, [r7, #4]
	strh r0, [r6, #2]
	str r8, [r6, #0xc]
	beq _0216414C
	ldrh r1, [r6, #2]
_02164130:
	ldrh r0, [r4, #2]
	cmp r1, r0
	bhs _0216414C
	add r5, r4, #8
	ldr r4, [r4, #8]
	cmp r4, #0
	bne _02164130
_0216414C:
	str r6, [r5]
	ldr r0, _02164168 // =0x0217644C
	str r4, [r6, #8]
	ldr r1, [r0, #4]
	add r1, r1, #0xbd0
	str r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02164168: .word 0x0217644C
_0216416C: .word 0x02176454
_02164170: .word 0x000004DC
	arm_func_end exDrawReqTask__AddRequest

	arm_func_start exDrawReqTask__InitUnknown2
exDrawReqTask__InitUnknown2: // 0x02164174
	stmdb sp!, {r4, r5, r6, lr}
	ldr r5, _021641A8 // =0x0217644C
	mov r6, #0
	mov r4, #0xbd0
_02164184:
	ldr r0, [r5, #0xc]
	mla r0, r6, r4, r0
	bl exDrawReqTask__InitRequest
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0xa0
	blo _02164184
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021641A8: .word 0x0217644C
	arm_func_end exDrawReqTask__InitUnknown2

	arm_func_start exDrawReqTask__InitRequest
exDrawReqTask__InitRequest: // 0x021641AC
	mov r1, #0
	strh r1, [r0]
	strh r1, [r0, #2]
	strh r1, [r0, #4]
	str r1, [r0, #8]
	str r1, [r0, #0xc]
	bx lr
	arm_func_end exDrawReqTask__InitRequest

	arm_func_start exDrawReqTask__Func_21641C8
exDrawReqTask__Func_21641C8: // 0x021641C8
	ldr r0, _021641E4 // =0x0217644C
	mov r1, #0
	ldr r2, [r0, #0xc]
	str r2, [r0, #4]
	str r1, [r0, #8]
	strh r1, [r0]
	bx lr
	.align 2, 0
_021641E4: .word 0x0217644C
	arm_func_end exDrawReqTask__Func_21641C8

	arm_func_start exDrawReqTask__SetConfigPriority
exDrawReqTask__SetConfigPriority: // 0x021641E8
	strh r1, [r0, #4]
	bx lr
	arm_func_end exDrawReqTask__SetConfigPriority

	arm_func_start exDrawReqTask__Func_21641F0
exDrawReqTask__Func_21641F0: // 0x021641F0
	ldrb r1, [r0, #1]
	orr r2, r1, #4
	bic r3, r2, #2
	and r1, r3, #0xff
	bic r2, r1, #8
	and r1, r2, #0xff
	strb r3, [r0, #1]
	bic r1, r1, #0x10
	strb r1, [r0, #1]
	bx lr
	arm_func_end exDrawReqTask__Func_21641F0

	arm_func_start exDrawReqTask__Func_2164218
exDrawReqTask__Func_2164218: // 0x02164218
	ldrb r1, [r0, #1]
	orr r3, r1, #4
	bic r2, r3, #2
	and r1, r2, #0xff
	orr r1, r1, #8
	bic r1, r1, #0x10
	strb r1, [r0, #1]
	bx lr
	arm_func_end exDrawReqTask__Func_2164218

	arm_func_start exDrawReqTask__Func_2164238
exDrawReqTask__Func_2164238: // 0x02164238
	ldrb r1, [r0, #1]
	bic r2, r1, #4
	and r1, r2, #0xff
	orr r1, r1, #2
	bic r2, r1, #8
	strb r1, [r0, #1]
	and r1, r2, #0xff
	bic r1, r1, #0x10
	strb r1, [r0, #1]
	bx lr
	arm_func_end exDrawReqTask__Func_2164238

	arm_func_start exDrawReqTask__Func_2164260
exDrawReqTask__Func_2164260: // 0x02164260
	ldr r0, _02164268 // =0x0217645C
	bx lr
	.align 2, 0
_02164268: .word 0x0217645C
	arm_func_end exDrawReqTask__Func_2164260

	arm_func_start exDrawReqTask__InitUnknown3
exDrawReqTask__InitUnknown3: // 0x0216426C
	ldr ip, _02164280 // =MI_CpuFill8
	ldr r0, _02164284 // =0x0217645C
	mov r1, #0
	mov r2, #6
	bx ip
	.align 2, 0
_02164280: .word MI_CpuFill8
_02164284: .word 0x0217645C
	arm_func_end exDrawReqTask__InitUnknown3

	arm_func_start exDrawReqTask__Func_2164288
exDrawReqTask__Func_2164288: // 0x02164288
	stmdb sp!, {r4, lr}
	mov r4, r0
	cmp r4, #0xf
	movhi r0, #0
	ldmhiia sp!, {r4, pc}
	bl exDrawReqTask__Func_2164260
	ldrb r2, [r0, #0]
	mov r1, r4, lsl #0x1c
	bic r2, r2, #0xf0
	orr r1, r2, r1, lsr #24
	strb r1, [r0]
	mov r0, #1
	ldmia sp!, {r4, pc}
	arm_func_end exDrawReqTask__Func_2164288

	arm_func_start exDrawReqTask__Func_21642BC
exDrawReqTask__Func_21642BC: // 0x021642BC
	ldrb r2, [r0, #0]
	mov r1, r2, lsl #0x18
	movs r1, r1, lsr #0x1c
	moveq r0, #1
	bxeq lr
	add r1, r1, #0xff
	and r1, r1, #0xff
	bic r2, r2, #0xf0
	mov r1, r1, lsl #0x1c
	orr r1, r2, r1, lsr #24
	strb r1, [r0]
	mov r0, #0
	bx lr
	arm_func_end exDrawReqTask__Func_21642BC

	arm_func_start exDrawReqTask__Func_21642F0
exDrawReqTask__Func_21642F0: // 0x021642F0
	cmp r1, #7
	bxhi lr
	ldrb r2, [r0, #2]
	mov r1, r1, lsl #0x1d
	bic r2, r2, #0x1c
	orr r1, r2, r1, lsr #27
	strb r1, [r0, #2]
	bx lr
	arm_func_end exDrawReqTask__Func_21642F0

	.data
	
aExdrawreqtask: // 0x021743E0
	.asciz "exDrawReqTask"