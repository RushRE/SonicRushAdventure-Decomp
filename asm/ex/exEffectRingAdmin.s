	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

exEffectRingTask__ActiveInstanceCount: // 0x02176590
	.space 0x02

	.align 4
	
exEffectLoopRingTask__TaskSingleton2: // 0x02176594
    .space 0x04
	
exEffectRingTask__TaskSingleton: // 0x02176598
    .space 0x04
	
exEffectRingAdminTask__TaskSingleton: // 0x0217659C
    .space 0x04
	
exEffectLoopRingTask__TaskSingleton: // 0x021765A0
    .space 0x04
	
exEffectLoopRingTask__Animator: // 0x021765A4
    .space 0x104

	.text

	arm_func_start exEffectRingAdminTask__Main
exEffectRingAdminTask__Main: // 0x021686F0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02168764 // =exEffectRingTask__ActiveInstanceCount
	str r0, [r1, #0xc]
	bl exEffectLoopRingTask__Create
	bl exEffectRingAdminTask__InitValues
	mov r0, #0
	strh r0, [r4, #2]
	strh r0, [r4, #4]
	ldrb r2, [r4, #0]
	ldr r0, _02168768 // =exEffectRingAdmin__UnknownTable
	ldrh r1, [r4, #2]
	ldr r2, [r0, r2, lsl #2]
	mov r0, #0xc
	mla r0, r1, r0, r2
	add r3, r4, #8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldrb r1, [r4, #0]
	ldr r0, _0216876C // =0x021746FA
	mov r1, r1, lsl #1
	ldrh r0, [r0, r1]
	strh r0, [r4, #6]
	bl GetExTaskCurrent
	ldr r1, _02168770 // =exEffectRingAdminTask__Main_Active
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02168764: .word exEffectRingTask__ActiveInstanceCount
_02168768: .word exEffectRingAdmin__UnknownTable
_0216876C: .word 0x021746FA
_02168770: .word exEffectRingAdminTask__Main_Active
	arm_func_end exEffectRingAdminTask__Main

	arm_func_start exEffectRingAdminTask__Func8
exEffectRingAdminTask__Func8: // 0x02168774
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetFlag_2178650
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02168798 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02168798: .word ExTask_State_Destroy
	arm_func_end exEffectRingAdminTask__Func8

	arm_func_start exEffectRingAdminTask__Destructor
exEffectRingAdminTask__Destructor: // 0x0216879C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, _021687B4 // =exEffectRingTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0xc]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021687B4: .word exEffectRingTask__ActiveInstanceCount
	arm_func_end exEffectRingAdminTask__Destructor

	arm_func_start exEffectRingAdminTask__Main_Active
exEffectRingAdminTask__Main_Active: // 0x021687B8
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x20
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, pc}
	ldrsh r1, [r4, #8]
	sub r0, r1, #1
	strh r0, [r4, #8]
	cmp r1, #0
	bge _02168C74
	ldr r0, [r4, #0xc]
	mov r1, #0
	mov r2, #0x8c000
	str r1, [sp, #0x14]
	str r2, [sp, #0x18]
	str r1, [sp, #0x1c]
	str r1, [sp, #8]
	bl _fgr
	ldr r1, [r4, #0xc]
	ldr r0, _02168C8C // =0x45800000
	bls _02168830
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _0216883C
_02168830:
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_0216883C:
	bl _f_ftoi
	ldrb r1, [r4, #0x10]
	mov r2, #0
	str r0, [sp, #0xc]
	mov r0, r1, lsl #0x1f
	str r2, [sp, #0x10]
	movs r0, r0, lsr #0x1f
	beq _02168884
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x25800
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168884:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _021688BC
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x20800
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_021688BC:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	beq _021688F4
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x1b800
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_021688F4:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	beq _0216892C
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x16800
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_0216892C:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02168964
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x11800
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168964:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	beq _0216899C
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0xc800
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_0216899C:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x19
	movs r0, r0, lsr #0x1f
	beq _021689D4
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x7800
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_021689D4:
	ldrb r0, [r4, #0x10]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	beq _02168A0C
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x2800
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168A0C:
	ldrb r0, [r4, #0x11]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _02168A48
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x2800
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168A48:
	ldrb r0, [r4, #0x11]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _02168A84
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x7800
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168A84:
	ldrb r0, [r4, #0x11]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	beq _02168AC0
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0xc800
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168AC0:
	ldrb r0, [r4, #0x11]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	beq _02168AFC
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x11800
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168AFC:
	ldrb r0, [r4, #0x11]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02168B38
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x16800
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168B38:
	ldrb r0, [r4, #0x11]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	beq _02168B74
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x1b800
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168B74:
	ldrb r0, [r4, #0x11]
	mov r0, r0, lsl #0x19
	movs r0, r0, lsr #0x1f
	beq _02168BB0
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x20800
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168BB0:
	ldrb r0, [r4, #0x11]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	beq _02168BEC
	add r0, sp, #8
	sub r3, sp, #4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0x25800
	rsb r1, r1, #0
	ldr r3, [r3, #0]
	add r0, sp, #0x14
	str r1, [sp, #0x14]
	ldmia r0, {r0, r1, r2}
	bl exEffectRingTask__Create
_02168BEC:
	ldrh r0, [r4, #2]
	add r0, r0, #1
	strh r0, [r4, #2]
	ldrh ip, [r4, #2]
	ldrh r0, [r4, #6]
	cmp ip, r0
	bhs _02168C2C
	ldrb r2, [r4, #0]
	ldr r1, _02168C90 // =exEffectRingAdmin__UnknownTable
	mov r0, #0xc
	ldr r1, [r1, r2, lsl #2]
	add r3, r4, #8
	mla r0, ip, r0, r1
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	b _02168C74
_02168C2C:
	ldrh r0, [r4, #4]
	mov ip, #0
	ldr r1, _02168C90 // =exEffectRingAdmin__UnknownTable
	add r0, r0, #1
	strh r0, [r4, #4]
	strh ip, [r4, #2]
	ldrb r2, [r4, #0]
	mov r0, #0xc
	add r3, r4, #8
	ldr r1, [r1, r2, lsl #2]
	mla r0, ip, r0, r1
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldrb r1, [r4, #0]
	ldr r0, _02168C94 // =0x021746FA
	mov r1, r1, lsl #1
	ldrh r0, [r0, r1]
	strh r0, [r4, #6]
_02168C74:
	bl exEffectRingAdminTask__InitValues
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #0x20
	ldmia sp!, {r4, pc}
	.align 2, 0
_02168C8C: .word 0x45800000
_02168C90: .word exEffectRingAdmin__UnknownTable
_02168C94: .word 0x021746FA
	arm_func_end exEffectRingAdminTask__Main_Active

	arm_func_start exEffectRingAdminTask__InitValues
exEffectRingAdminTask__InitValues: // 0x02168C98
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	mov r5, #1
	bl exSysTask__GetStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _02168D20
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	b _02168D9C
_02168CCC: // jump table
	b _02168D9C // case 0
	b _02168CF8 // case 1
	b _02168CF8 // case 2
	b _02168D9C // case 3
	b _02168CF8 // case 4
	b _02168D9C // case 5
	b _02168CFC // case 6
	b _02168D00 // case 7
	b _02168D08 // case 8
	b _02168D10 // case 9
	b _02168D18 // case 10
_02168CF8:
	mov r5, #0
_02168CFC:
	b _02168D9C
_02168D00:
	mov r5, #2
	b _02168D9C
_02168D08:
	mov r5, #3
	b _02168D9C
_02168D10:
	mov r5, #4
	b _02168D9C
_02168D18:
	mov r5, #5
	b _02168D9C
_02168D20:
	bl exSysTask__GetStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _02168D9C
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	b _02168D9C
_02168D44: // jump table
	b _02168D9C // case 0
	b _02168D70 // case 1
	b _02168D70 // case 2
	b _02168D9C // case 3
	b _02168D70 // case 4
	b _02168D9C // case 5
	b _02168D78 // case 6
	b _02168D80 // case 7
	b _02168D88 // case 8
	b _02168D90 // case 9
	b _02168D98 // case 10
_02168D70:
	mov r5, #6
	b _02168D9C
_02168D78:
	mov r5, #7
	b _02168D9C
_02168D80:
	mov r5, #8
	b _02168D9C
_02168D88:
	mov r5, #9
	b _02168D9C
_02168D90:
	mov r5, #0xa
	b _02168D9C
_02168D98:
	mov r5, #0xb
_02168D9C:
	ldr r3, _02168DF8 // =exEffectRingAdmin__UnknownTable2
	ldrb r0, [r3, #0]
	cmp r0, r5
	beq _02168DF0
	mov r2, #0
	strb r5, [r4]
	strh r2, [r4, #2]
	ldrb r1, [r4, #0]
	ldr r0, _02168DFC // =exEffectRingAdmin__UnknownTable
	add ip, r4, #8
	ldr r1, [r0, r1, lsl #2]
	mov r0, #0xc
	mla r0, r2, r0, r1
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldrb r1, [r4, #0]
	ldr r0, _02168E00 // =0x021746FA
	strb r5, [r3]
	mov r1, r1, lsl #1
	ldrh r0, [r0, r1]
	strh r0, [r4, #6]
_02168DF0:
	strb r5, [r4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02168DF8: .word exEffectRingAdmin__UnknownTable2
_02168DFC: .word exEffectRingAdmin__UnknownTable
_02168E00: .word 0x021746FA
	arm_func_end exEffectRingAdminTask__InitValues

	arm_func_start exEffectRingAdminTask__Create
exEffectRingAdminTask__Create: // 0x02168E04
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x14
	ldr r0, _02168E68 // =aExeffectringad
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02168E6C // =exEffectRingAdminTask__Main
	ldr r1, _02168E70 // =exEffectRingAdminTask__Destructor
	mov r2, #0x4000
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r1, #0
	mov r2, #0x14
	bl MI_CpuFill8
	mov r0, r4
	bl GetExTask
	ldr r1, _02168E74 // =exEffectRingAdminTask__Func8
	str r1, [r0, #8]
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_02168E68: .word aExeffectringad
_02168E6C: .word exEffectRingAdminTask__Main
_02168E70: .word exEffectRingAdminTask__Destructor
_02168E74: .word exEffectRingAdminTask__Func8
	arm_func_end exEffectRingAdminTask__Create

	arm_func_start exEffectRingAdminTask__Destroy
exEffectRingAdminTask__Destroy: // 0x02168E78
	stmdb sp!, {r3, lr}
	ldr r0, _02168E9C // =exEffectRingTask__ActiveInstanceCount
	ldr r0, [r0, #0xc]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, _02168EA0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02168E9C: .word exEffectRingTask__ActiveInstanceCount
_02168EA0: .word ExTask_State_Destroy
	arm_func_end exEffectRingAdminTask__Destroy

	.data
	
exEffectRingAdmin__UnknownTable2: // 0x021746F8
	.hword 1, 0x44, 0x2E, 8, 0x2E, 8, 0x2E, 0x44, 0x2E, 0xB, 0x2E, 0xB, 0x2E
	.align 4

exEffectRingAdmin__UnknownTable: // 0x02174714
    .word _0217592C, _0217490C, _02174744, _02174B34, _021747A4, _02174D5C, _021755FC, _021751AC, _02174804, _021753D4, _02174888, _02174F84
	.align 4
    
_02174744: // 0x02174744
	.word 0x78
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x1E
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0xE10
	.float 1
	.word 0x0

_021747A4: // 0x021747A4
	.word 0x78
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x1E
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0xE10
	.float 1
	.word 0x0

_02174804: // 0x02174804
	.word 0x50
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x1E
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x1E
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0xE10
	.float 1
	.word 0x0

_02174888: // 0x02174888
	.word 0x50
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x1E
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x1E
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0xE10
	.float 1
	.word 0x0

_0217490C: // 0x0217490C
	.word 0x12C
	.float 1
	.word 0xC000

	.word 0x5
	.float 1
	.word 0xC000

	.word 0x5
	.float 1
	.word 0xC000

	.word 0x1E
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x10E
	.float 1
	.word 0x402

	.word 0x5
	.float 1
	.word 0x402

	.word 0x5
	.float 1
	.word 0x402

	.word 0xF0
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x168
	.float 1
	.word 0x100

	.word 0x5
	.float 1
	.word 0x100

	.word 0x5
	.float 1
	.word 0x100

	.word 0x3C
	.float 1
	.word 0x40

	.word 0x5
	.float 1
	.word 0x40

	.word 0x5
	.float 1
	.word 0x40

	.word 0x14A
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x12C
	.float 1
	.word 0xC000

	.word 0x5
	.float 1
	.word 0xC000

	.word 0x5
	.float 1
	.word 0xC000

	.word 0x3C
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x80

	.word 0x5
	.float 1
	.word 0x80

	.word 0x5
	.float 1
	.word 0x80

	.word 0x12C
	.float 1
	.word 0x800

	.word 0x5
	.float 1
	.word 0x800

	.word 0x5
	.float 1
	.word 0x800

	.word 0x12C
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x0

	.word 0x3C
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x14A
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x14A
	.float 1
	.word 0x4

	.word 0x5
	.float 1
	.word 0x4

	.word 0x5
	.float 1
	.word 0x4

_02174B34: // 0x02174B34
	.word 0x12C
	.float 1
	.word 0xC000

	.word 0x5
	.float 1
	.word 0xC000

	.word 0x5
	.float 1
	.word 0xC000

	.word 0x1E
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x10E
	.float 1
	.word 0x402

	.word 0x5
	.float 1
	.word 0x402

	.word 0x5
	.float 1
	.word 0x402

	.word 0xF0
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x168
	.float 1
	.word 0x100

	.word 0x5
	.float 1
	.word 0x100

	.word 0x5
	.float 1
	.word 0x100

	.word 0x3C
	.float 1
	.word 0x40

	.word 0x5
	.float 1
	.word 0x40

	.word 0x5
	.float 1
	.word 0x40

	.word 0x14A
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x12C
	.float 1
	.word 0xC000

	.word 0x5
	.float 1
	.word 0xC000

	.word 0x5
	.float 1
	.word 0xC000

	.word 0x3C
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x80

	.word 0x5
	.float 1
	.word 0x80

	.word 0x5
	.float 1
	.word 0x80

	.word 0x12C
	.float 1
	.word 0x800

	.word 0x5
	.float 1
	.word 0x800

	.word 0x5
	.float 1
	.word 0x800

	.word 0x12C
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x0

	.word 0x3C
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x14A
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x14A
	.float 1
	.word 0x4

	.word 0x5
	.float 1
	.word 0x4

	.word 0x5
	.float 1
	.word 0x4

_02174D5C: // 0x02174D5C
	.word 0x12C
	.float 1
	.word 0x4000

	.word 0x5
	.float 1
	.word 0x4000

	.word 0x5
	.float 1
	.word 0x4000

	.word 0x1E
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x10E
	.float 1
	.word 0x402

	.word 0x5
	.float 1
	.word 0x402

	.word 0x5
	.float 1
	.word 0x402

	.word 0xF0
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x168
	.float 1
	.word 0x100

	.word 0x5
	.float 1
	.word 0x100

	.word 0x5
	.float 1
	.word 0x100

	.word 0x3C
	.float 1
	.word 0x40

	.word 0x5
	.float 1
	.word 0x40

	.word 0x5
	.float 1
	.word 0x40

	.word 0x14A
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x12C
	.float 1
	.word 0x8000

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x3C
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x12C
	.float 1
	.word 0x800

	.word 0x5
	.float 1
	.word 0x800

	.word 0x5
	.float 1
	.word 0x800

	.word 0x12C
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x0

	.word 0x3C
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x0

	.word 0x14A
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x14A
	.float 1
	.word 0x4

	.word 0x5
	.float 1
	.word 0x4

	.word 0x5
	.float 1
	.word 0x4

_02174F84: // 0x02174F84
	.word 0x12C
	.float 1
	.word 0x4000

	.word 0x5
	.float 1
	.word 0x4000

	.word 0x5
	.float 1
	.word 0x4000

	.word 0x1E
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x10E
	.float 1
	.word 0x402

	.word 0x5
	.float 1
	.word 0x402

	.word 0x5
	.float 1
	.word 0x402

	.word 0xF0
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x168
	.float 1
	.word 0x100

	.word 0x5
	.float 1
	.word 0x100

	.word 0x5
	.float 1
	.word 0x100

	.word 0x3C
	.float 1
	.word 0x40

	.word 0x5
	.float 1
	.word 0x40

	.word 0x5
	.float 1
	.word 0x40

	.word 0x14A
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x12C
	.float 1
	.word 0x8000

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x3C
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x12C
	.float 1
	.word 0x800

	.word 0x5
	.float 1
	.word 0x800

	.word 0x5
	.float 1
	.word 0x800

	.word 0x12C
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x0

	.word 0x3C
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x0

	.word 0x14A
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x14A
	.float 1
	.word 0x4

	.word 0x5
	.float 1
	.word 0x4

	.word 0x5
	.float 1
	.word 0x4

_021751AC: // 0x021751AC
	.word 0x12C
	.float 1
	.word 0xC000

	.word 0x5
	.float 1
	.word 0xC000

	.word 0x5
	.float 1
	.word 0xC000

	.word 0x1E
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x10E
	.float 1
	.word 0x402

	.word 0x5
	.float 1
	.word 0x402

	.word 0x5
	.float 1
	.word 0x402

	.word 0xF0
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x168
	.float 1
	.word 0x100

	.word 0x5
	.float 1
	.word 0x100

	.word 0x5
	.float 1
	.word 0x100

	.word 0x3C
	.float 1
	.word 0x40

	.word 0x5
	.float 1
	.word 0x40

	.word 0x5
	.float 1
	.word 0x40

	.word 0x14A
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x12C
	.float 1
	.word 0xC000

	.word 0x5
	.float 1
	.word 0xC000

	.word 0x5
	.float 1
	.word 0xC000

	.word 0x3C
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x80

	.word 0x5
	.float 1
	.word 0x80

	.word 0x5
	.float 1
	.word 0x80

	.word 0x12C
	.float 1
	.word 0x800

	.word 0x5
	.float 1
	.word 0x800

	.word 0x5
	.float 1
	.word 0x800

	.word 0x12C
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x0

	.word 0x3C
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x14A
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x14A
	.float 1
	.word 0x4

	.word 0x5
	.float 1
	.word 0x4

	.word 0x5
	.float 1
	.word 0x4

_021753D4: // 0x021753D4
	.word 0x12C
	.float 1
	.word 0xC000

	.word 0x5
	.float 1
	.word 0xC000

	.word 0x5
	.float 1
	.word 0xC000

	.word 0x1E
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x10E
	.float 1
	.word 0x402

	.word 0x5
	.float 1
	.word 0x402

	.word 0x5
	.float 1
	.word 0x402

	.word 0xF0
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x168
	.float 1
	.word 0x100

	.word 0x5
	.float 1
	.word 0x100

	.word 0x5
	.float 1
	.word 0x100

	.word 0x3C
	.float 1
	.word 0x40

	.word 0x5
	.float 1
	.word 0x40

	.word 0x5
	.float 1
	.word 0x40

	.word 0x14A
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x12C
	.float 1
	.word 0xC000

	.word 0x5
	.float 1
	.word 0xC000

	.word 0x5
	.float 1
	.word 0xC000

	.word 0x3C
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x80

	.word 0x5
	.float 1
	.word 0x80

	.word 0x5
	.float 1
	.word 0x80

	.word 0x12C
	.float 1
	.word 0x800

	.word 0x5
	.float 1
	.word 0x800

	.word 0x5
	.float 1
	.word 0x800

	.word 0x12C
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x0

	.word 0x3C
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x14A
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x5
	.float 1
	.word 0x8

	.word 0x14A
	.float 1
	.word 0x4

	.word 0x5
	.float 1
	.word 0x4

	.word 0x5
	.float 1
	.word 0x4

_021755FC: // 0x021755FC
	.word 0x0
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x1E
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x2

	.word 0x5
	.float 1
	.word 0x2

	.word 0x5
	.float 1
	.word 0x2

	.word 0x1E
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x5
	.float 1
	.word 0x180

	.word 0x78
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x4

	.word 0x5
	.float 1
	.word 0x4

	.word 0x5
	.float 1
	.word 0x4

	.word 0x1E
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x3

	.word 0x5
	.float 1
	.word 0x3

	.word 0x5
	.float 1
	.word 0x3

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x200

	.word 0x5
	.float 1
	.word 0x200

	.word 0x5
	.float 1
	.word 0x200

	.word 0xF
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x3C
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x400

	.word 0x5
	.float 1
	.word 0x8400

	.word 0x5
	.float 1
	.word 0x8400

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x1E
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x1800

	.word 0x5
	.float 1
	.word 0x1800

	.word 0x5
	.float 1
	.word 0x1800

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0xE10
	.float 1
	.word 0x0

_0217592C: // 0x0217592C
	.word 0x0
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x5
	.float 1
	.word 0x20

	.word 0x1E
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x2

	.word 0x5
	.float 1
	.word 0x2

	.word 0x5
	.float 1
	.word 0x2

	.word 0x1E
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x80

	.word 0x5
	.float 1
	.word 0x80

	.word 0x5
	.float 1
	.word 0x80

	.word 0x78
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x1000

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x4

	.word 0x5
	.float 1
	.word 0x4

	.word 0x5
	.float 1
	.word 0x4

	.word 0x1E
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x3

	.word 0x5
	.float 1
	.word 0x3

	.word 0x5
	.float 1
	.word 0x3

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x200

	.word 0x5
	.float 1
	.word 0x200

	.word 0x5
	.float 1
	.word 0x200

	.word 0xF
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x3C
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x400

	.word 0x5
	.float 1
	.word 0x8400

	.word 0x5
	.float 1
	.word 0x8400

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x1E
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x5
	.float 1
	.word 0x8000

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x800

	.word 0x5
	.float 1
	.word 0x800

	.word 0x5
	.float 1
	.word 0x800

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x0

	.word 0x5
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0x5
	.float 1
	.word 0x10

	.word 0xE10
	.float 1
	.word 0x0
	.align 4
    
aExeffectloopri: // 0x02175C5C
	.asciz "exEffectLoopRingTask"
	.align 4
	
aExeffectringta: // 0x02175C74
	.asciz "exEffectRingTask"
	.align 4
	
aExeffectringad: // 0x02175C88
	.asciz "exEffectRingAdminTask"