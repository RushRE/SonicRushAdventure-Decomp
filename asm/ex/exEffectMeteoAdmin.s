	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

exEffectMeteoTask__ActiveInstanceCount: // 0x02176550
	.space 0x02

exEffectMeteoTask__unk_2176552: // 0x02176552
	.space 0x02

	.align 4

exEffectMeteoTask__unk_2176554: // 0x02176554
    .space 0x04
	
exEffectMeteoTask__dword_2176558: // 0x02176558
    .space 0x04
	
exEffectMeteoAdminTask__TaskSingleton: // 0x0217655C
    .space 0x04
	
exEffectMeteoTask__dword_2176560: // 0x02176560
    .space 0x04
	
exEffectMeteoTask__unk_2176564: // 0x02176564
    .space 0x04
	
exEffectMeteoTask__unk_2176568: // 0x02176568
    .space 0x04

exEffectMeteoTask__unk_217656C: // 0x0217656C
    .space 0x04
	
exEffectMeteoTask__unk_2176570: // 0x02176570
    .space 0x04
	
exEffectMeteoTask__unk_2176574: // 0x02176574
    .space 0x04

exEffectMeteoTask__unk_2176578: // 0x02176578
    .space 0x04
	
exEffectMeteoTask__dword_217657C: // 0x0217657C
    .space 0x04
	
exEffectMeteoTask__AnimTable: // 0x02176580
    .space 0x04 * 2
	
exEffectMeteoTask__FileTable: // 0x02176588
    .space 0x04 * 2

	.text

	arm_func_start exEffectMeteoAdminTask__Main
exEffectMeteoAdminTask__Main: // 0x02167B48
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02167BB8 // =exEffectMeteoTask__ActiveInstanceCount
	str r0, [r1, #0xc]
	bl exEffectMeteoAdminTask__Func_2167F04
	mov r0, #0
	strh r0, [r4, #2]
	strh r0, [r4, #4]
	ldrh r2, [r4, #0]
	ldr r0, _02167BBC // =_021745AC
	ldrh r1, [r4, #2]
	ldr r2, [r0, r2, lsl #2]
	mov r0, #0xc
	mla r0, r1, r0, r2
	add r3, r4, #8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldrh r1, [r4, #0]
	ldr r0, _02167BC0 // =_021745A8
	mov r1, r1, lsl #1
	ldrh r0, [r0, r1]
	strh r0, [r4, #6]
	bl GetExTaskCurrent
	ldr r1, _02167BC4 // =exEffectMeteoAdminTask__Main_Active
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167BB8: .word exEffectMeteoTask__ActiveInstanceCount
_02167BBC: .word _021745AC
_02167BC0: .word _021745A8
_02167BC4: .word exEffectMeteoAdminTask__Main_Active
	arm_func_end exEffectMeteoAdminTask__Main

	arm_func_start exEffectMeteoAdminTask__Func8
exEffectMeteoAdminTask__Func8: // 0x02167BC8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExSystemFlag_2178650
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02167BEC // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02167BEC: .word ExTask_State_Destroy
	arm_func_end exEffectMeteoAdminTask__Func8

	arm_func_start exEffectMeteoAdminTask__Destructor
exEffectMeteoAdminTask__Destructor: // 0x02167BF0
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, _02167C08 // =exEffectMeteoTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0xc]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02167C08: .word exEffectMeteoTask__ActiveInstanceCount
	arm_func_end exEffectMeteoAdminTask__Destructor

	arm_func_start exEffectMeteoAdminTask__Main_Active
exEffectMeteoAdminTask__Main_Active: // 0x02167C0C
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x20
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, pc}
	ldrsh r1, [r4, #8]
	sub r0, r1, #1
	strh r0, [r4, #8]
	cmp r1, #0
	bge _02167EE4
	ldr r0, [r4, #0xc]
	mov r1, #0
	mov r2, #0xbe000
	str r1, [sp, #0x14]
	str r2, [sp, #0x18]
	str r1, [sp, #0x1c]
	str r1, [sp, #8]
	bl _fgr
	ldr r1, [r4, #0xc]
	ldr r0, _02167EFC // =0x45800000
	bls _02167C84
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02167C90
_02167C84:
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02167C90:
	bl _f_ftoi
	ldrb r1, [r4, #0x10]
	mov r2, #0
	str r0, [sp, #0xc]
	mov r0, r1, lsl #0x1f
	str r2, [sp, #0x10]
	movs r0, r0, lsr #0x1f
	beq _02167CD8
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x28000
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectMeteoTask__Create
_02167CD8:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _02167D10
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x1e000
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectMeteoTask__Create
_02167D10:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	beq _02167D48
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x14000
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectMeteoTask__Create
_02167D48:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	beq _02167D80
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0xa000
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectMeteoTask__Create
_02167D80:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02167DBC
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0xa000
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectMeteoTask__Create
_02167DBC:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	beq _02167DF8
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x14000
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectMeteoTask__Create
_02167DF8:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x19
	movs r0, r0, lsr #0x1f
	beq _02167E34
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x1e000
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectMeteoTask__Create
_02167E34:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	beq _02167E70
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x28000
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectMeteoTask__Create
_02167E70:
	ldrh r0, [r4, #2]
	add r0, r0, #1
	strh r0, [r4, #2]
	ldrh ip, [r4, #2]
	ldrh r0, [r4, #6]
	cmp ip, r0
	bhs _02167EB0
	ldrh r2, [r4, #0]
	ldr r1, _02167F00 // =_021745AC
	mov r0, #0xc
	ldr r1, [r1, r2, lsl #2]
	add r3, r4, #8
	mla r0, ip, r0, r1
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	b _02167EE4
_02167EB0:
	ldrh r0, [r4, #4]
	mov ip, #0
	ldr r1, _02167F00 // =_021745AC
	add r0, r0, #1
	strh r0, [r4, #4]
	strh ip, [r4, #2]
	ldrh r2, [r4, #0]
	mov r0, #0xc
	add r3, r4, #8
	ldr r1, [r1, r2, lsl #2]
	mla r0, ip, r0, r1
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
_02167EE4:
	bl exEffectMeteoAdminTask__Func_2167F04
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #0x20
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167EFC: .word 0x45800000
_02167F00: .word _021745AC
	arm_func_end exEffectMeteoAdminTask__Main_Active

	arm_func_start exEffectMeteoAdminTask__Func_2167F04
exEffectMeteoAdminTask__Func_2167F04: // 0x02167F04
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	mov r5, #0
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _02167F78
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	b _02167FCC
_02167F38: // jump table
	b _02167FCC // case 0
	b _02167F64 // case 1
	b _02167F64 // case 2
	b _02167FCC // case 3
	b _02167F64 // case 4
	b _02167FCC // case 5
	b _02167F68 // case 6
	b _02167FCC // case 7
	b _02167F68 // case 8
	b _02167FCC // case 9
	b _02167F68 // case 10
_02167F64:
	b _02167FCC
_02167F68:
	bl GetExTaskCurrent
	ldr r1, _02167FD4 // =ExTask_State_Destroy
	str r1, [r0]
	b _02167FCC
_02167F78:
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	b _02167FCC
_02167F8C: // jump table
	b _02167FCC // case 0
	b _02167FB8 // case 1
	b _02167FB8 // case 2
	b _02167FCC // case 3
	b _02167FB8 // case 4
	b _02167FCC // case 5
	b _02167FC0 // case 6
	b _02167FCC // case 7
	b _02167FC0 // case 8
	b _02167FCC // case 9
	b _02167FC0 // case 10
_02167FB8:
	mov r5, #1
	b _02167FCC
_02167FC0:
	bl GetExTaskCurrent
	ldr r1, _02167FD4 // =ExTask_State_Destroy
	str r1, [r0]
_02167FCC:
	strh r5, [r4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02167FD4: .word ExTask_State_Destroy
	arm_func_end exEffectMeteoAdminTask__Func_2167F04

	arm_func_start exEffectMeteoAdminTask__Create
exEffectMeteoAdminTask__Create: // 0x02167FD8
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x14
	ldr r0, _02168034 // =aExeffectmeteoa
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02168038 // =exEffectMeteoAdminTask__Main
	ldr r1, _0216803C // =exEffectMeteoAdminTask__Destructor
	mov r2, #0x4000
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r0, r4
	bl GetExTask
	ldr r1, _02168040 // =exEffectMeteoAdminTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_02168034: .word aExeffectmeteoa
_02168038: .word exEffectMeteoAdminTask__Main
_0216803C: .word exEffectMeteoAdminTask__Destructor
_02168040: .word exEffectMeteoAdminTask__Func8
	arm_func_end exEffectMeteoAdminTask__Create

	arm_func_start exEffectMeteoAdminTask__Destroy
exEffectMeteoAdminTask__Destroy: // 0x02168044
	stmdb sp!, {r3, lr}
	ldr r0, _02168068 // =exEffectMeteoTask__ActiveInstanceCount
	ldr r0, [r0, #0xc]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, _0216806C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02168068: .word exEffectMeteoTask__ActiveInstanceCount
_0216806C: .word ExTask_State_Destroy
	arm_func_end exEffectMeteoAdminTask__Destroy

	.data

_021745A8:
	.word 0xB000B
    
_021745AC:
    .word _021745B4, _02174638
    
_021745B4:
    .byte 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F, 0x08, 0x00, 0x00, 0x00
	.byte 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F, 0x10, 0x00, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x40, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F
	.byte 0x40, 0x00, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F, 0x80, 0x00, 0x00, 0x00
	.byte 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F, 0x44, 0x00, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x40, 0x3F, 0x20, 0x00, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F
	.byte 0x00, 0x00, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F, 0x40, 0x00, 0x00, 0x00
	.byte 0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F, 0x01, 0x00, 0x00, 0x00, 0x1E, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x40, 0x3F, 0x00, 0x00, 0x00, 0x00
    
_02174638:
    .byte 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F
	.byte 0x08, 0x00, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F, 0x10, 0x00, 0x00, 0x00
	.byte 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x40, 0x3F, 0x40, 0x00, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F
	.byte 0x80, 0x00, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F, 0x44, 0x00, 0x00, 0x00
	.byte 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F, 0x20, 0x00, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x40, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F
	.byte 0x40, 0x00, 0x00, 0x00, 0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F, 0x01, 0x00, 0x00, 0x00
	.byte 0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x3F, 0x00, 0x00, 0x00, 0x00

aExtraExBb_9: // 0x021746BC
	.asciz "/extra/ex.bb"
	.align 4
	
aExeffectmeteot: // 0x021746CC
	.asciz "exEffectMeteoTask"
	.align 4
	
aExeffectmeteoa: // 0x021746E0
	.asciz "exEffectMeteoAdminTask"