	.include "asm/macros.inc"
	.include "global.inc"

.public _ZN15CViDockNpcGroupD1Ev

	.bss
	
ViDock__TaskSingleton: // 0x02173A54
	.space 0x04

	.text

	arm_func_start ViDock__Create
ViDock__Create: // 0x0215DA6C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r4, _0215DB10 // =0x00001030
	mov r2, #0
	ldr r0, _0215DB14 // =ViDock__Main
	ldr r1, _0215DB18 // =ViDock__Destructor
	mov r3, r2
	str r4, [sp]
	mov r4, #0x10
	str r4, [sp, #4]
	bl ViDock__CreateInternal
	ldr r1, _0215DB1C // =ViDock__TaskSingleton
	str r0, [r1]
	bl GetTaskWork_
	mov r4, r0
	mov r2, #8
	add r0, r4, #0x32c
	strh r2, [r4]
	mov r1, #4
	strh r1, [r4, #2]
	str r2, [r4, #4]
	mov r3, #0
	str r3, [r4, #8]
	str r3, [r4, #0xc]
	mov r1, #1
	str r1, [r4, #0x10]
	add r2, r4, #0x1000
	mov r1, #0xc
	str r1, [r2, #0x460]
	str r3, [r2, #0x464]
	str r3, [r2, #0x468]
	str r3, [r2, #0x470]
	str r3, [r2, #0xb24]
	add r0, r0, #0x1800
	mov r1, #0x1000
	str r3, [r2, #0xb28]
	bl InitThreadWorker
	mov r0, r4
	bl ViDock__Func_215E678
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215DB10: .word 0x00001030
_0215DB14: .word ViDock__Main
_0215DB18: .word ViDock__Destructor
_0215DB1C: .word ViDock__TaskSingleton
	arm_func_end ViDock__Create

	arm_func_start ViDock__CreateInternal
ViDock__CreateInternal: // 0x0215DB20
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldrh lr, [sp, #0x18]
	ldrb ip, [sp, #0x1c]
	ldr r4, _0215DB98 // =0x00001BF8
	str lr, [sp]
	str ip, [sp, #4]
	str r4, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	bl GetTaskWork_
	mov r1, r0
	mov r0, r4
	bl _ZnwmPv
	movs r4, r0
	beq _0215DB8C
	add r0, r4, #0xf8
	bl ViDockBack__Constructor
	add r0, r4, #0x1f8
	add r0, r0, #0xc00
	bl _ZN13CViDockPlayerC1Ev
	add r0, r4, #0x130
	add r0, r0, #0x1000
	bl _ZN15CViDockNpcGroupC1Ev
	add r0, r4, #0x48
	add r0, r0, #0x1400
	bl _ZN9CViShadowC1Ev
_0215DB8C:
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0215DB98: .word 0x00001BF8
	arm_func_end ViDock__CreateInternal

	arm_func_start ViDock__Func_215DB9C
ViDock__Func_215DB9C: // 0x0215DB9C
	stmdb sp!, {r3, lr}
	ldr r0, _0215DBC4 // =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl DestroyTask
	ldr r0, _0215DBC4 // =ViDock__TaskSingleton
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DBC4: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215DB9C

	arm_func_start ViDock__Func_215DBC8
ViDock__Func_215DBC8: // 0x0215DBC8
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _0215DC78 // =ViDock__TaskSingleton
	mov r5, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r4, r0
	bl ViDock__Func_215EF3C
	mov r0, r4
	bl ViDock__Func_215EE58
	mov r0, r4
	bl ViDock__Func_215EC44
	mov r0, r4
	bl ViDock__Func_215EAF4
	mov r0, r4
	bl ViDock__Func_215EA7C
	strh r5, [r4]
	mov r0, #0
	strh r0, [r4, #2]
	str r5, [r4, #4]
	mov r0, r4
	mov r1, #8
	bl ViDock__Func_215E754
	mov r0, r4
	mov r1, #0
	bl ViDock__Func_215E9F4
	mov r0, r4
	bl ViDock__Func_215EA8C
	mov r0, r4
	bl ViDock__Func_215EB04
	ldrh r0, [r4, #0]
	bl DockHelpers__Func_2152970
	ldrh r2, [r0, #0x34]
	add r0, r4, #0x1400
	mov r1, #0
	strh r2, [r0, #0x5c]
	add r0, r4, #0x1000
	str r1, [r0, #0xb24]
	add r0, r4, #0x18
	bl ViMapIcon__Func_2163A7C
	ldr r0, _0215DC78 // =ViDock__TaskSingleton
	ldr r1, _0215DC7C // =ViDock__Func_215F9CC
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215DC78: .word ViDock__TaskSingleton
_0215DC7C: .word ViDock__Func_215F9CC
	arm_func_end ViDock__Func_215DBC8

	arm_func_start ViDock__Func_215DC80
ViDock__Func_215DC80: // 0x0215DC80
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, _0215DCF4 // =ViDock__TaskSingleton
	mov r6, r0
	ldr r0, [r2, #0]
	mov r5, r1
	bl GetTaskWork_
	mov r4, r0
	bl ViDock__Func_215DEF4
	cmp r5, #7
	movge r5, r6
	strh r5, [r4]
	add r0, r4, #0x32c
	str r6, [r4, #4]
	mov r3, #0
	strh r3, [r4, #2]
	add ip, r4, #0x1000
	str r3, [ip, #0xb24]
	mov lr, #1
	ldr r1, _0215DCF8 // =ViDock__Func_215FFF4
	mov r2, r4
	add r0, r0, #0x1800
	mov r3, #0x18
	str lr, [ip, #0xb28]
	bl CreateThreadWorker
	ldr r0, _0215DCF4 // =ViDock__TaskSingleton
	ldr r1, _0215DCFC // =ViDock__Func_215FFC0
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215DCF4: .word ViDock__TaskSingleton
_0215DCF8: .word ViDock__Func_215FFF4
_0215DCFC: .word ViDock__Func_215FFC0
	arm_func_end ViDock__Func_215DC80

	arm_func_start ViDock__Func_215DD00
ViDock__Func_215DD00: // 0x0215DD00
	stmdb sp!, {r3, lr}
	ldr r0, _0215DD28 // =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r0, r0, #0x1000
	ldr r0, [r0, #0xb28]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DD28: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215DD00

	arm_func_start ViDock__Func_215DD2C
ViDock__Func_215DD2C: // 0x0215DD2C
	stmdb sp!, {r3, lr}
	ldr r0, _0215DD5C // =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r0, r0, #0x18
	mov r1, #0
	bl ViMapIcon__Func_2163A7C
	ldr r0, _0215DD5C // =ViDock__TaskSingleton
	ldr r1, _0215DD60 // =ViDock__Func_215F9CC
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DD5C: .word ViDock__TaskSingleton
_0215DD60: .word ViDock__Func_215F9CC
	arm_func_end ViDock__Func_215DD2C

	arm_func_start ViDock__Func_215DD64
ViDock__Func_215DD64: // 0x0215DD64
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, _0215DE34 // =ViDock__TaskSingleton
	mov r6, r0
	ldr r0, [r2, #0]
	mov r5, r1
	bl GetTaskWork_
	mov r4, r0
	bl ViDock__Func_215EF3C
	mov r0, r4
	bl ViDock__Func_215EE58
	mov r0, r4
	bl ViDock__Func_215EC44
	mov r0, r4
	bl ViDock__Func_215EAF4
	mov r0, r4
	bl ViDock__Func_215EA7C
	strh r6, [r4]
	cmp r5, #0
	mov r0, #1
	strh r0, [r4, #2]
	mov r0, #8
	str r0, [r4, #4]
	mov r1, #0
	add r0, r4, #0x1000
	str r1, [r0, #0xb24]
	bne _0215DDDC
	mov r0, r4
	bl ViDock__Func_215E9F4
	mov r0, r4
	bl ViDock__Func_215EA8C
_0215DDDC:
	ldrh r0, [r4, #0]
	bl DockHelpers__Func_2152970
	ldrh r3, [r0, #0x34]
	add r2, r4, #0x1400
	add r0, r4, #0x18
	mov r1, #1
	strh r3, [r2, #0x5c]
	bl ViMapIcon__Func_2163A7C
	cmp r5, #0
	beq _0215DE20
	ldr r0, _0215DE34 // =ViDock__TaskSingleton
	ldr r1, _0215DE38 // =ViDock__Func_215FE00
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	mov r0, #0
	str r0, [r4, #0xc]
	ldmia sp!, {r4, r5, r6, pc}
_0215DE20:
	ldr r0, _0215DE34 // =ViDock__TaskSingleton
	ldr r1, _0215DE3C // =ViDock__Func_215F998
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215DE34: .word ViDock__TaskSingleton
_0215DE38: .word ViDock__Func_215FE00
_0215DE3C: .word ViDock__Func_215F998
	arm_func_end ViDock__Func_215DD64

	arm_func_start ViDock__Func_215DE40
ViDock__Func_215DE40: // 0x0215DE40
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _0215DEEC // =ViDock__TaskSingleton
	mov r5, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r4, r0
	bl ViDock__Func_215EF3C
	mov r0, r4
	bl ViDock__Func_215EE58
	mov r0, r4
	bl ViDock__Func_215EC44
	mov r0, r4
	bl ViDock__Func_215EAF4
	mov r0, r4
	bl ViDock__Func_215EA7C
	strh r5, [r4]
	mov r0, #2
	strh r0, [r4, #2]
	mov r0, #8
	str r0, [r4, #4]
	mov r0, r4
	mov r2, #0
	add r1, r4, #0x1000
	str r2, [r1, #0xb24]
	bl ViDock__Func_215EA8C
	mov r0, r4
	mov r1, #1
	bl ViDock__Func_215E9F4
	mov r1, #0
	add r0, r4, #0x1500
	strh r1, [r0, #0xb8]
	mov r0, r4
	bl ViDock__Func_215ED0C
	mov r0, r4
	bl ViDock__Func_215EEA0
	add r0, r4, #0x18
	mov r1, #2
	bl ViMapIcon__Func_2163A7C
	ldr r0, _0215DEEC // =ViDock__TaskSingleton
	ldr r1, _0215DEF0 // =ViDock__Func_215FE68
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215DEEC: .word ViDock__TaskSingleton
_0215DEF0: .word ViDock__Func_215FE68
	arm_func_end ViDock__Func_215DE40

	arm_func_start ViDock__Func_215DEF4
ViDock__Func_215DEF4: // 0x0215DEF4
	stmdb sp!, {r4, lr}
	ldr r0, _0215DF60 // =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	add r1, r4, #0x1000
	mov r2, #0
	str r2, [r1, #0xb24]
	bl ViDock__Func_215EF3C
	mov r0, r4
	bl ViDock__Func_215EE58
	mov r0, r4
	bl ViDock__Func_215EC44
	mov r0, r4
	bl ViDock__Func_215EAF4
	mov r0, r4
	bl ViDock__Func_215EA7C
	mov r1, #8
	strh r1, [r4]
	mov r0, #4
	strh r0, [r4, #2]
	ldr r0, _0215DF60 // =ViDock__TaskSingleton
	str r1, [r4, #4]
	ldr r0, [r0, #0]
	mov r1, #0
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215DF60: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215DEF4

	arm_func_start ViDock__Func_215DF64
ViDock__Func_215DF64: // 0x0215DF64
	stmdb sp!, {r4, lr}
	ldr r1, _0215DF80 // =ViDock__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	str r4, [r0, #8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215DF80: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215DF64

	arm_func_start ViDock__Func_215DF84
ViDock__Func_215DF84: // 0x0215DF84
	stmdb sp!, {r3, lr}
	ldr r0, _0215DF9C // =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	bl ViDock__Func_215EE7C
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DF9C: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215DF84

	arm_func_start ViDock__Func_215DFA0
ViDock__Func_215DFA0: // 0x0215DFA0
	stmdb sp!, {r4, lr}
	ldr r0, _0215DFE0 // =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x14]
	cmp r0, #0
	movne r0, #0
	ldmneia sp!, {r4, pc}
	add r0, r4, #0xe00
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	add r0, r4, #0xf8
	ldmia r1, {r1, r2, r3}
	bl ViDockBack__Func_2164B9C
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215DFE0: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215DFA0

	arm_func_start ViDock__Func_215DFE4
ViDock__Func_215DFE4: // 0x0215DFE4
	stmdb sp!, {r3, lr}
	ldr r0, _0215DFFC // =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #4]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DFFC: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215DFE4

	arm_func_start ViDock__Func_215E000
ViDock__Func_215E000: // 0x0215E000
	stmdb sp!, {r3, lr}
	ldr r0, _0215E028 // =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r0, r0, #0x1000
	ldr r0, [r0, #0x460]
	cmp r0, #0xb
	movlt r0, #1
	movge r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215E028: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215E000

	arm_func_start ViDock__Func_215E02C
ViDock__Func_215E02C: // 0x0215E02C
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, _0215E068 // =ViDock__TaskSingleton
	mov r5, r0
	ldr r0, [r2, #0]
	mov r4, r1
	bl GetTaskWork_
	cmp r5, #0
	addne r1, r0, #0x1000
	ldrne r1, [r1, #0x460]
	strne r1, [r5]
	cmp r4, #0
	addne r0, r0, #0x1000
	ldrne r0, [r0, #0x464]
	strne r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215E068: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215E02C

	arm_func_start ViDock__Func_215E06C
ViDock__Func_215E06C: // 0x0215E06C
	stmdb sp!, {r3, lr}
	ldr r0, _0215E094 // =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r0, r0, #0x1000
	ldr r0, [r0, #0x468]
	cmp r0, #0
	ldrne r0, [r0, #0x30c]
	moveq r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215E094: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215E06C

	arm_func_start ViDock__Func_215E098
ViDock__Func_215E098: // 0x0215E098
	stmdb sp!, {r3, lr}
	ldr r0, _0215E0C8 // =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r0, r0, #0x1000
	ldr r1, [r0, #0x468]
	cmp r1, #0
	ldrne r0, [r1, #0x30c]
	cmpne r0, #0
	subne r0, r0, #1
	strne r0, [r1, #0x30c]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215E0C8: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215E098

	arm_func_start ViDock__Func_215E0CC
ViDock__Func_215E0CC: // 0x0215E0CC
	stmdb sp!, {r3, lr}
	ldr r0, _0215E100 // =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	cmp r0, #0
	moveq r0, #0x17
	ldmeqia sp!, {r3, pc}
	bl GetTaskWork_
	add r0, r0, #0x1000
	ldr r0, [r0, #0x468]
	cmp r0, #0
	moveq r0, #0x17
	ldrne r0, [r0, #0x300]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215E100: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215E0CC

	arm_func_start ViDock__Func_215E104
ViDock__Func_215E104: // 0x0215E104
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _0215E174 // =ViDock__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r1, r4, lsl #0x10
	mov r5, r0
	mov r0, r1, lsr #0x10
	bl DockHelpers__GetNpcConfig
	add r1, r5, #0x1000
	ldr r1, [r1, #0x138]
	ldrh r6, [r0, #0]
	cmp r1, #0
	moveq r1, #0
	cmp r1, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	add r4, r5, #0x130
_0215E148:
	add r0, r1, #0x300
	ldrh r0, [r0, #0x12]
	cmp r6, r0
	addeq r0, r5, #0x1000
	streq r1, [r0, #0x468]
	ldmeqia sp!, {r4, r5, r6, pc}
	add r0, r4, #0x1000
	bl _ZN15CViDockNpcGroup10GetNextNpcEP10CViDockNpc
	movs r1, r0
	bne _0215E148
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215E174: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215E104

	arm_func_start ViDock__Func_215E178
ViDock__Func_215E178: // 0x0215E178
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x48
	ldr r0, _0215E334 // =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x1f8
	add r2, r4, #0x1000
	mov r1, #1
	str r1, [r2, #0x470]
	mov r1, #0
	add r0, r0, #0xc00
	str r1, [r2, #0x474]
	bl ViDockPlayer__Func_2166B80
	add r0, r4, #0x1000
	ldr r0, [r0, #0x468]
	cmp r0, #0
	beq _0215E31C
	add r0, r4, #0xe00
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	add r0, sp, #0x3c
	bl CPPHelpers__VEC_SetFromVec_2
	add r0, r4, #0x1000
	ldr r0, [r0, #0x468]
	add r0, r0, #8
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	add r0, sp, #0x30
	bl CPPHelpers__VEC_SetFromVec_2
	add r0, sp, #0x24
	bl CPPHelpers__Func_2085EE8
	add r0, sp, #0x18
	bl CPPHelpers__Func_2085EE8
	add r0, sp, #0xc
	add r1, sp, #0x3c
	add r2, sp, #0x30
	bl CPPHelpers__VEC_Subtract_Alt
	add r0, sp, #0xc
	bl CPPHelpers__VEC_Normalize
	mov r1, r0
	add r0, sp, #0x24
	bl CPPHelpers__Func_2085FA8
	ldr r0, [sp, #0x2c]
	bl Math__Func_207B1A4
	mov r5, r0
	ldr r0, [sp, #0x24]
	cmp r0, #0
	movlt r0, #1
	movge r0, #0
	cmp r0, #0
	rsbne r0, r5, #0x10000
	movne r0, r0, lsl #0x10
	movne r5, r0, lsr #0x10
	add r0, r4, #0x1000
	ldr r0, [r0, #0x468]
	mov r1, r5
	bl ViDockNpc__SetState1
	ldr r1, _0215E338 // =0xFFFF8001
	add r0, r4, #0x1f8
	add r1, r5, r1
	mov r1, r1, lsl #0x10
	add r0, r0, #0xc00
	mov r1, r1, lsr #0x10
	mov r2, #0
	bl ViDockPlayer__Func_21667A8
	add r0, sp, #0
	add r1, sp, #0x30
	add r2, sp, #0x3c
	bl CPPHelpers__VEC_Subtract_Alt
	add r0, sp, #0x18
	add r1, sp, #0
	bl CPPHelpers__Func_2085FA8
	ldr r2, [sp, #0x18]
	ldr r1, [sp, #0x1c]
	mov r2, r2, asr #1
	mov r1, r1, asr #1
	str r1, [sp, #0x28]
	ldr r0, [sp, #0x20]
	str r2, [sp, #0x24]
	mov r2, r0, asr #1
	add r0, sp, #0x24
	add r1, sp, #0x3c
	str r2, [sp, #0x2c]
	bl CPPHelpers__VEC_Add_Alt
	add r0, sp, #0x18
	bl CPPHelpers__VEC_Normalize
	add r0, sp, #0x24
	bl CPPHelpers__Func_2085F98
	ldr r2, [r0, #0]
	add r1, r4, #0x1000
	str r2, [r1, #0x478]
	ldr r2, [r0, #4]
	str r2, [r1, #0x47c]
	ldr r2, [r0, #8]
	add r0, sp, #0x18
	str r2, [r1, #0x480]
	bl CPPHelpers__Func_2085F98
	ldr r2, [r0, #0]
	add r1, r4, #0x1000
	str r2, [r1, #0x484]
	ldr r2, [r0, #4]
	str r2, [r1, #0x488]
	ldr r0, [r0, #8]
	str r0, [r1, #0x48c]
_0215E31C:
	ldr r0, _0215E334 // =ViDock__TaskSingleton
	ldr r1, _0215E33C // =ViDock__Func_215FD48
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215E334: .word ViDock__TaskSingleton
_0215E338: .word 0xFFFF8001
_0215E33C: .word ViDock__Func_215FD48
	arm_func_end ViDock__Func_215E178

	arm_func_start ViDock__Func_215E340
ViDock__Func_215E340: // 0x0215E340
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r2, _0215E40C // =ViDock__TaskSingleton
	mov r6, r0
	ldr r0, [r2, #0]
	mov r5, r1
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x1000
	ldr r1, [r0, #0x470]
	cmp r1, #0
	ldrne r0, [r0, #0x468]
	cmpne r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrh r0, [r4, #2]
	cmp r0, #0
	bne _0215E3B0
	ldrh r0, [r4, #0]
	cmp r0, #7
	bhs _0215E3B0
	bl DockHelpers__Func_2152970
	ldr r0, [r0, #0x3c]
	cmp r0, #0
	bne _0215E3B4
_0215E3B0:
	mov r6, #0
_0215E3B4:
	cmp r6, #0
	beq _0215E3F0
	ldrh r0, [r4, #0]
	bl DockHelpers__Func_2152970
	ldrsh r0, [r0, #0x40]
	add r1, r4, #0x78
	add r2, r4, #0x84
	str r0, [sp]
	add r0, r4, #0x18
	add r1, r1, #0x1400
	add r3, r2, #0x1400
	mov r2, #0x20
	str r5, [sp, #4]
	bl ViMapIcon__Func_2163AA0
	b _0215E3FC
_0215E3F0:
	add r0, r4, #0x18
	mov r1, #0x20
	bl ViMapIcon__Func_2163C3C
_0215E3FC:
	add r0, r4, #0x1000
	str r6, [r0, #0x474]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215E40C: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215E340

	arm_func_start ViDock__Func_215E410
ViDock__Func_215E410: // 0x0215E410
	stmdb sp!, {r4, lr}
	ldr r0, _0215E498 // =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x1000
	mov r1, #0
	str r1, [r0, #0x470]
	ldr r0, [r0, #0x468]
	cmp r0, #0
	beq _0215E45C
	bl ViDockNpc__SetState2
	add r0, r4, #0x1000
	ldr r0, [r0, #0x474]
	cmp r0, #0
	beq _0215E45C
	add r0, r4, #0x18
	mov r1, #0x20
	bl ViMapIcon__Func_2163C3C
_0215E45C:
	add r2, r4, #0x1000
	mov r1, #0xc
	add r0, r4, #0x1f8
	str r1, [r2, #0x460]
	mov r3, #0
	str r3, [r2, #0x464]
	add r0, r0, #0xc00
	mov r1, #1
	str r3, [r2, #0x468]
	bl ViDockPlayer__Func_2166B80
	ldr r0, _0215E498 // =ViDock__TaskSingleton
	ldr r1, _0215E49C // =ViDock__Func_215F9CC
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E498: .word ViDock__TaskSingleton
_0215E49C: .word ViDock__Func_215F9CC
	arm_func_end ViDock__Func_215E410

	arm_func_start ViDock__Func_215E4A0
ViDock__Func_215E4A0: // 0x0215E4A0
	stmdb sp!, {r3, lr}
	ldr r0, _0215E4B8 // =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0xc]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215E4B8: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215E4A0

	arm_func_start ViDock__Func_215E4BC
ViDock__Func_215E4BC: // 0x0215E4BC
	stmdb sp!, {r4, lr}
	ldr r1, _0215E4D8 // =ViDock__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	str r4, [r0, #0x10]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E4D8: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215E4BC

	arm_func_start ViDock__Func_215E4DC
ViDock__Func_215E4DC: // 0x0215E4DC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r0, _0215E574 // =ViDock__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r5, r0
	add r0, r5, #0xe00
	ldrh r4, [r0, #0x32]
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	mov r2, r4
	mov r0, #0
	bl TalkHelpers__Func_2152E14
	add r0, r5, #0x1000
	ldr r4, [r0, #0x138]
	mov r6, #0
	cmp r4, #0
	moveq r4, #0
	cmp r4, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	add r5, r5, #0x130
_0215E52C:
	ldrh r7, [r4, #0x3a]
	ldr r8, [r4, #0x30c]
	add r0, r4, #8
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	mov r0, r6
	mov r2, r7
	mov r3, r8
	bl TalkHelpers__Func_2152EB8
	mov r1, r4
	add r0, r5, #0x1000
	bl _ZN15CViDockNpcGroup10GetNextNpcEP10CViDockNpc
	add r1, r6, #1
	movs r4, r0
	mov r0, r1, lsl #0x10
	mov r6, r0, lsr #0x10
	bne _0215E52C
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215E574: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215E4DC

	arm_func_start ViDock__Func_215E578
ViDock__Func_215E578: // 0x0215E578
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r1, _0215E654 // =ViDock__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r5, r0
	mov r0, #0
	bl TalkHelpers__Func_2152E74
	cmp r0, #0
	beq _0215E5CC
	mov r0, #0
	bl TalkHelpers__GetPlayerInfo
	mov r1, r0
	add r0, r5, #0xe00
	bl CPPHelpers__VEC_Copy_Alt
	mov r0, #0
	bl TalkHelpers__Func_2152EA4
	add r1, r5, #0xe00
	strh r0, [r1, #0x30]
	ldrh r0, [r1, #0x30]
	strh r0, [r1, #0x32]
_0215E5CC:
	add r0, r5, #0x1000
	ldr r7, [r0, #0x138]
	mov r6, #0
	cmp r7, #0
	moveq r7, #0
	cmp r7, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	add r5, r5, #0x130
_0215E5EC:
	mov r0, r6
	bl TalkHelpers__Func_2152F20
	cmp r0, #0
	beq _0215E630
	mov r0, r6
	bl TalkHelpers__GetNpcInfo
	mov r1, r0
	add r0, r7, #8
	bl CPPHelpers__VEC_Copy_Alt
	cmp r4, #0
	beq _0215E624
	mov r0, r6
	bl TalkHelpers__Func_2152F58
	strh r0, [r7, #0x38]
_0215E624:
	mov r0, r6
	bl TalkHelpers__Func_2152F70
	str r0, [r7, #0x30c]
_0215E630:
	mov r1, r7
	add r0, r5, #0x1000
	bl _ZN15CViDockNpcGroup10GetNextNpcEP10CViDockNpc
	add r1, r6, #1
	movs r7, r0
	mov r0, r1, lsl #0x10
	mov r6, r0, lsr #0x10
	bne _0215E5EC
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215E654: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215E578

	arm_func_start ViDock__Func_215E658
ViDock__Func_215E658: // 0x0215E658
	stmdb sp!, {r4, lr}
	ldr r1, _0215E674 // =ViDock__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	str r4, [r0, #0x14]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E674: .word ViDock__TaskSingleton
	arm_func_end ViDock__Func_215E658

	arm_func_start ViDock__Func_215E678
ViDock__Func_215E678: // 0x0215E678
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #8
	bl ViDock__Func_215E754
	mov r0, r4
	mov r1, #0
	bl ViDock__Func_215E9F4
	mov r0, r4
	bl ViDock__Func_215EA8C
	mov r0, r4
	bl ViDock__Func_215EB04
	add r0, r4, #0x48
	add r0, r0, #0x1400
	bl _ZN9CViShadow10LoadAssetsEv
	add r0, r4, #0x490
	add r0, r0, #0x1000
	bl FontWindowAnimator__Init
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	bl FontAnimator__Init
	add r0, r4, #0x1000
	mov r1, #0
	str r1, [r0, #0x46c]
	mov r0, #1
	str r0, [r4, #0xc]
	str r1, [r4, #0x14]
	ldmia sp!, {r4, pc}
	arm_func_end ViDock__Func_215E678

	arm_func_start ViDock__Func_215E6E4
ViDock__Func_215E6E4: // 0x0215E6E4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x32c
	add r0, r0, #0x1800
	bl ReleaseThreadWorker
	add r0, r4, #0x48
	add r1, r4, #0x1000
	mov r2, #0
	add r0, r0, #0x1400
	str r2, [r1, #0xb28]
	bl _ZN9CViShadow12Func_2167E9CEv
	mov r0, r4
	bl ViDock__Func_215EF3C
	mov r0, r4
	bl ViDock__Func_215EE58
	mov r0, r4
	bl ViDock__Func_215EC44
	mov r0, r4
	bl ViDock__Func_215EAF4
	mov r0, r4
	bl ViDock__Func_215EA7C
	mov r0, r4
	bl ViDock__Func_215E81C
	add r0, r4, #0x1000
	mov r1, #0
	str r1, [r0, #0x46c]
	str r1, [r4, #0xc]
	ldmia sp!, {r4, pc}
	arm_func_end ViDock__Func_215E6E4

	arm_func_start ViDock__Func_215E754
ViDock__Func_215E754: // 0x0215E754
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, r0
	add r0, r4, #0x1f8
	add r0, r0, #0xc00
	mov r5, r1
	bl ViDockPlayer__LoadAssets
	ldrh r0, [r4, #0]
	cmp r0, #7
	addhs sp, sp, #0x10
	ldmhsia sp!, {r3, r4, r5, pc}
	ldrh r1, [r4, #2]
	cmp r1, #0
	bne _0215E7A0
	add r1, sp, #4
	add r2, sp, #0
	mov r3, r5
	bl ViDockBack__Func_2164C20
	b _0215E7B4
_0215E7A0:
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #8]
	str r0, [sp, #4]
	strh r0, [sp]
_0215E7B4:
	add r1, sp, #4
	add r0, r4, #0xe00
	bl CPPHelpers__VEC_Copy_Alt
	add r0, r4, #0x1f8
	ldrh r1, [sp]
	add r0, r0, #0xc00
	mov r2, #1
	bl ViDockPlayer__Func_21667A8
	ldrh r0, [r4, #0]
	bl DockHelpers__Func_2152970
	ldrsh r2, [r0, #0x40]
	add r0, r4, #0x218
	add r1, sp, #4
	str r2, [sp, #0xc]
	str r2, [sp, #8]
	str r2, [sp, #4]
	add r0, r0, #0xc00
	bl CPPHelpers__VEC_Copy_Alt
	ldrh r0, [r4, #0]
	bl DockHelpers__Func_2152970
	add r2, r4, #0x1f8
	ldr r1, [r0, #0x38]
	add r0, r2, #0xc00
	bl ViDockPlayer__Func_2166B90
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViDock__Func_215E754

	arm_func_start ViDock__Func_215E81C
ViDock__Func_215E81C: // 0x0215E81C
	ldr ip, _0215E82C // =ViDockPlayer__Func_2166748
	add r0, r0, #0x1f8
	add r0, r0, #0xc00
	bx ip
	.align 2, 0
_0215E82C: .word ViDockPlayer__Func_2166748
	arm_func_end ViDock__Func_215E81C

	arm_func_start ViDock__Func_215E830
ViDock__Func_215E830: // 0x0215E830
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x18
	mov r9, r0
	ldr r0, [r9, #8]
	cmp r0, #0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r4, #0
	mov r5, r4
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0215E874
	ldr r0, _0215E9EC // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	movne r0, #1
	bne _0215E878
_0215E874:
	mov r0, #0
_0215E878:
	cmp r0, #0
	beq _0215E93C
	bl _ZN10HubControl12Func_2157178Ev
	cmp r0, #0
	beq _0215E93C
	add r0, sp, #0xc
	bl CPPHelpers__Func_2085EE8
	ldr r1, _0215E9EC // =touchInput
	add r0, r9, #0xe00
	ldrh r7, [r1, #0x14]
	ldrh r8, [r1, #0x16]
	bl CPPHelpers__Func_2085F9C
	add r1, sp, #8
	add r2, sp, #4
	bl NNS_G3dWorldPosToScrPos
	ldr r1, [sp, #8]
	ldr r0, [sp, #4]
	sub r1, r7, r1
	movs r2, r1, lsl #0xc
	sub r0, r8, r0
	mov r1, r0, lsl #0xc
	mov r0, #0
	str r2, [sp, #0xc]
	rsbmi r2, r2, #0
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	cmp r2, #0x40000
	bgt _0215E8FC
	ldr r0, [sp, #0x10]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x30000
	ble _0215E900
_0215E8FC:
	mov r5, #1
_0215E900:
	add r0, sp, #0
	add r1, sp, #0xc
	bl CPPHelpers__VEC_Magnitude
	add r0, sp, #0
	ldr r0, [r0, #0]
	mov r0, r0, asr #0xc
	cmp r0, #4
	blt _0215E93C
	add r0, sp, #0xc
	bl CPPHelpers__VEC_Normalize
	ldr r0, [sp, #0xc]
	ldr r1, [sp, #0x10]
	bl FX_Atan2Idx
	mov r6, r0
	mov r4, #1
_0215E93C:
	cmp r4, #0
	bne _0215E9C0
	ldr r0, _0215E9F0 // =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x40
	beq _0215E970
	tst r0, #0x20
	movne r6, #0xa000
	bne _0215E9AC
	tst r0, #0x10
	movne r6, #0x6000
	moveq r6, #0x8000
	b _0215E9AC
_0215E970:
	tst r0, #0x80
	beq _0215E994
	tst r0, #0x20
	movne r6, #0xe000
	bne _0215E9AC
	tst r0, #0x10
	movne r6, #0x2000
	moveq r6, #0
	b _0215E9AC
_0215E994:
	tst r0, #0x20
	movne r6, #0xc000
	bne _0215E9AC
	tst r0, #0x10
	movne r6, #0x4000
	mvneq r6, #0
_0215E9AC:
	cmp r6, #0
	blt _0215E9C0
	mov r4, #1
	tst r0, #2
	movne r5, r4
_0215E9C0:
	cmp r4, #0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	add r0, r9, #0x1f8
	mov r1, r6, lsl #0x10
	mov r2, r5
	add r0, r0, #0xc00
	mov r1, r1, lsr #0x10
	bl ViDockPlayer__Func_21667BC
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0215E9EC: .word touchInput
_0215E9F0: .word padInput
	arm_func_end ViDock__Func_215E830

	arm_func_start ViDock__Func_215E9F4
ViDock__Func_215E9F4: // 0x0215E9F4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r0, [r5, #2]
	mov r4, r1
	mov r1, #9
	cmp r0, #0
	beq _0215EA24
	cmp r0, #1
	beq _0215EA3C
	cmp r0, #2
	beq _0215EA54
	b _0215EA68
_0215EA24:
	ldrh r0, [r5, #0]
	cmp r0, #7
	bhs _0215EA68
	bl DockHelpers__Func_2152970
	ldr r1, [r0, #0]
	b _0215EA68
_0215EA3C:
	ldrh r0, [r5, #0]
	cmp r0, #8
	bhs _0215EA68
	bl DockHelpers__Func_2152984
	ldr r1, [r0, #0]
	b _0215EA68
_0215EA54:
	ldrh r0, [r5, #0]
	cmp r0, #5
	bhs _0215EA68
	bl DockHelpers__Func_2152994
	ldr r1, [r0, #0]
_0215EA68:
	mov r3, r4
	add r0, r5, #0xf8
	mov r2, #0
	bl ViDockBack__LoadAssets
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViDock__Func_215E9F4

	arm_func_start ViDock__Func_215EA7C
ViDock__Func_215EA7C: // 0x0215EA7C
	ldr ip, _0215EA88 // =ViDockBack__Func_2164968
	add r0, r0, #0xf8
	bx ip
	.align 2, 0
_0215EA88: .word ViDockBack__Func_2164968
	arm_func_end ViDock__Func_215EA7C

	arm_func_start ViDock__Func_215EA8C
ViDock__Func_215EA8C: // 0x0215EA8C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	mov r1, #9
	cmp r0, #1
	bne _0215EAC0
	ldrh r0, [r4, #0]
	cmp r0, #8
	bhs _0215EAB8
	bl DockHelpers__Func_2152984
	ldr r1, [r0, #0]
_0215EAB8:
	mov r2, #1
	b _0215EAE8
_0215EAC0:
	cmp r0, #2
	moveq r1, #0
	moveq r2, #2
	beq _0215EAE8
	ldrh r0, [r4, #0]
	cmp r0, #7
	bhs _0215EAE4
	bl DockHelpers__Func_2152970
	ldr r1, [r0, #0]
_0215EAE4:
	mov r2, #0
_0215EAE8:
	add r0, r4, #0x18
	bl ViMapIcon__Func_21639A4
	ldmia sp!, {r4, pc}
	arm_func_end ViDock__Func_215EA8C

	arm_func_start ViDock__Func_215EAF4
ViDock__Func_215EAF4: // 0x0215EAF4
	ldr ip, _0215EB00 // =ViMapIcon__Func_2163A50
	add r0, r0, #0x18
	bx ip
	.align 2, 0
_0215EB00: .word ViMapIcon__Func_2163A50
	arm_func_end ViDock__Func_215EAF4

	arm_func_start ViDock__Func_215EB04
ViDock__Func_215EB04: // 0x0215EB04
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	mov r10, r0
	ldrh r1, [r10, #0]
	cmp r1, #7
	bhs _0215EC28
	ldr r0, _0215EC3C // =ovl05_02172EBC
	mov r1, r1, lsl #1
	ldrh r11, [r0, r1]
	ldr r0, _0215EC40 // =ovl05_02172ECA
	mov r4, #0
	ldrh r0, [r0, r1]
	cmp r11, #0
	str r0, [sp, #4]
	ble _0215EC28
	add r0, r10, #0x130
	str r0, [sp, #8]
_0215EB48:
	ldr r0, [sp, #4]
	add r5, r0, r4
	mov r0, r5
	bl _ZN10HubControl12Func_215B850El
	cmp r0, #0
	beq _0215EC1C
	mov r0, r5
	bl _ZN10HubControl12Func_215B858El
	cmp r0, #0
	beq _0215EC1C
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bl DockHelpers__GetNpcConfig
	mov r6, r0
	ldr r0, [r6, #8]
	blx r0
	mov r7, r0
	ldr r0, [sp, #8]
	add r0, r0, #0x1000
	bl _ZN15CViDockNpcGroup6AddNpcEv
	ldrsh r1, [r6, #4]
	ldrsh r3, [r6, #6]
	mov r8, r0
	sub r0, r5, #7
	cmp r0, #1
	movhi r9, #1
	add r0, sp, #0xc
	mov r2, #0
	mov r1, r1, lsl #0xc
	mov r3, r3, lsl #0xc
	movls r9, #0
	bl CPPHelpers__VEC_Set
	add r0, sp, #0xc
	bl CPPHelpers__Func_2085F98
	str r9, [sp]
	mov r2, r0
	ldrh r3, [r6, #2]
	mov r1, r5
	mov r0, r8
	bl ViDockNpc__LoadAssets
	ldrh r0, [r10, #0]
	bl DockHelpers__Func_2152970
	ldrsh r2, [r0, #0x40]
	add r0, r8, #0x20
	add r1, sp, #0x18
	str r2, [sp, #0x20]
	str r2, [sp, #0x1c]
	str r2, [sp, #0x18]
	bl CPPHelpers__VEC_Copy_Alt
	ldrh r1, [r7, #2]
	ldrh r0, [r7, #0]
	str r0, [r8, #0x304]
	str r1, [r8, #0x308]
_0215EC1C:
	add r4, r4, #1
	cmp r4, r11
	blt _0215EB48
_0215EC28:
	add r0, r10, #0x130
	add r0, r0, #0x1000
	bl _ZN15CViDockNpcGroup10LoadAssetsEv
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215EC3C: .word ovl05_02172EBC
_0215EC40: .word ovl05_02172ECA
	arm_func_end ViDock__Func_215EB04

	arm_func_start ViDock__Func_215EC44
ViDock__Func_215EC44: // 0x0215EC44
	ldr ip, _0215EC54 // =_ZN15CViDockNpcGroup12ClearNpcListEv
	add r0, r0, #0x130
	add r0, r0, #0x1000
	bx ip
	.align 2, 0
_0215EC54: .word _ZN15CViDockNpcGroup12ClearNpcListEv
	arm_func_end ViDock__Func_215EC44

	arm_func_start ViDock__Func_215EC58
ViDock__Func_215EC58: // 0x0215EC58
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x38
	ldrh r4, [r0, #0]
	cmp r4, #7
	addhs sp, sp, #0x38
	movhs r0, #0
	ldmhsia sp!, {r4, r5, r6, pc}
	ldr r6, _0215ED08 // =ovl05_02172ED8
	add r5, sp, #0
	mov r4, #0xe
_0215EC80:
	ldrh lr, [r6]
	ldrh ip, [r6, #2]
	add r6, r6, #4
	strh lr, [r5]
	strh ip, [r5, #2]
	add r5, r5, #4
	subs r4, r4, #1
	bne _0215EC80
	ldrh ip, [r0]
	add lr, sp, #0
	mov r0, ip, lsl #3
	ldrsh r0, [lr, r0]
	add ip, lr, ip, lsl #3
	add r0, r3, r0
	cmp r1, r0
	blt _0215ECFC
	ldrsh r0, [ip, #4]
	add r0, r3, r0
	cmp r1, r0
	bgt _0215ECFC
	ldrsh r0, [ip, #2]
	ldr r1, [sp, #0x48]
	add r0, r1, r0
	cmp r2, r0
	blt _0215ECFC
	ldrsh r0, [ip, #6]
	add r0, r1, r0
	cmp r2, r0
	addle sp, sp, #0x38
	movle r0, #1
	ldmleia sp!, {r4, r5, r6, pc}
_0215ECFC:
	mov r0, #0
	add sp, sp, #0x38
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215ED08: .word ovl05_02172ED8
	arm_func_end ViDock__Func_215EC58

	arm_func_start ViDock__Func_215ED0C
ViDock__Func_215ED0C: // 0x0215ED0C
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x24
	mov r4, r0
	bl _ZN10HubControl17GetFileFrom_ViMsgEv
	mov r1, #0xd
	bl FileUnknown__GetAOUFile
	mov r5, r0
	bl _ZN10HubControl10GetField54Ev
	mov r1, r0
	mov r0, #0x13
	str r0, [sp]
	mov r0, #0x1e
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	mov r3, #1
	bl FontAnimator__LoadFont2
	add r0, r4, #0xf4
	mov r1, r5
	add r0, r0, #0x1400
	bl FontAnimator__LoadMPCFile
	ldrh r0, [r4, #0]
	bl DockHelpers__Func_2152994
	ldrh r1, [r0, #0x12]
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	bl FontAnimator__SetMsgSequence
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	bl FontAnimator__LoadPaletteFunc2
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	mov r1, #0
	bl FontAnimator__GetDialogLineCount
	cmp r0, #1
	movne r5, #0x12
	movne r6, #6
	bne _0215EDEC
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	mov r1, #0x10
	bl FontAnimator__AdvanceLine
	mov r5, #0x14
	mov r6, #4
_0215EDEC:
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	mov r1, #0
	bl FontAnimator__LoadCharacters
	bl _ZN10HubControl10GetField54Ev
	mov r2, #0
	mov r1, #2
	stmia sp, {r1, r2, r5}
	mov r1, #0x20
	str r1, [sp, #0xc]
	str r6, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r1, r0
	str r2, [sp, #0x18]
	mov lr, #1
	add ip, r4, #0x490
	str lr, [sp, #0x1c]
	mov r0, #5
	str r0, [sp, #0x20]
	mov r3, r2
	add r0, ip, #0x1000
	bl FontWindowAnimator__Load2
	add r0, r4, #0x490
	add r0, r0, #0x1000
	bl FontWindowAnimator__Func_20599B4
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, r5, r6, pc}
	arm_func_end ViDock__Func_215ED0C

	arm_func_start ViDock__Func_215EE58
ViDock__Func_215EE58: // 0x0215EE58
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x490
	add r0, r0, #0x1000
	bl FontWindowAnimator__Release
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	bl FontAnimator__Release
	ldmia sp!, {r4, pc}
	arm_func_end ViDock__Func_215EE58

	arm_func_start ViDock__Func_215EE7C
ViDock__Func_215EE7C: // 0x0215EE7C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xf4
	add r0, r0, #0x1400
	bl FontAnimator__Draw
	add r0, r4, #0x490
	add r0, r0, #0x1000
	bl FontWindowAnimator__Draw
	ldmia sp!, {r4, pc}
	arm_func_end ViDock__Func_215EE7C

	arm_func_start ViDock__Func_215EEA0
ViDock__Func_215EEA0: // 0x0215EEA0
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r0, #0x10000
	mov r1, #0x10
	bl FX_DivS32
	mov r3, #0
	ldr r5, _0215EF38 // =FX_SinCosTable_
	mov r1, r3
	mov r2, r4
	mov ip, r0, lsl #0x10
_0215EEC8:
	mov r0, r3, asr #4
	mov r6, r0, lsl #1
	add r0, r5, r6, lsl #1
	ldrsh lr, [r0, #2]
	add r0, r2, #0x1000
	add r3, r3, ip, lsr #16
	str lr, [r0, #0x5bc]
	mov lr, r6, lsl #1
	ldrsh lr, [r5, lr]
	mov r3, r3, lsl #0x10
	add r1, r1, #1
	str lr, [r0, #0x5c0]
	cmp r1, #0x10
	mov r3, r3, lsr #0x10
	add r2, r2, #0xc
	blt _0215EEC8
	add r2, r4, #0x1600
	mov r3, #0
	mov r0, #0x1000
	mov r1, #6
	strh r3, [r2, #0x7c]
	bl FX_DivS32
	add r1, r4, #0x1600
	strh r0, [r1, #0x7e]
	add r0, r4, #0x1000
	mov r1, #0
	str r1, [r0, #0x680]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215EF38: .word FX_SinCosTable_
	arm_func_end ViDock__Func_215EEA0

	arm_func_start ViDock__Func_215EF3C
ViDock__Func_215EF3C: // 0x0215EF3C
	bx lr
	arm_func_end ViDock__Func_215EF3C

	arm_func_start ViDock__Func_215EF40
ViDock__Func_215EF40: // 0x0215EF40
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	mov r4, r0
	add r1, r4, #0x1600
	mov r0, #0
	strh r0, [r1, #0x84]
	ldrsh r3, [r1, #0x7c]
	mov r2, #1
_0215EF60:
	add r0, r4, r2, lsl #1
	add r0, r0, #0x1600
	strh r3, [r0, #0x84]
	ldrsh r0, [r1, #0x7e]
	add r2, r2, #1
	cmp r2, #7
	add r0, r3, r0
	mov r0, r0, lsl #0x10
	mov r3, r0, asr #0x10
	blt _0215EF60
	add r0, r4, #0x1600
	mov r1, #0x1000
	strh r1, [r0, #0x92]
	ldr r7, _0215F198 // =ovl05_02172EB4
	mov r0, #1
	add r1, r4, #0x1000
_0215EFA0:
	ldr r3, [r1, #0x680]
	add r2, r4, r0, lsl #1
	add r3, r3, r0
	mov r3, r3, lsl #0x1e
	mov r3, r3, lsr #0x1d
	ldrh r3, [r7, r3]
	add r2, r2, #0x1600
	add r0, r0, #1
	strh r3, [r2, #0x94]
	cmp r0, #7
	blt _0215EFA0
	add r0, r4, #0x1600
	ldrsh r2, [r0, #0x90]
	add r0, r4, #0x1000
	ldr r1, [r0, #0x680]
	rsb r0, r2, #0x1000
	mov r0, r0, lsl #0x10
	and r1, r1, #3
	cmp r1, #3
	mov r7, r0, asr #0x10
	addls pc, pc, r1, lsl #2
	b _0215F034
_0215EFF8: // jump table
	b _0215F008 // case 0
	b _0215F014 // case 1
	b _0215F020 // case 2
	b _0215F02C // case 3
_0215F008:
	ldr r5, _0215F19C // =0x00007BF7
	ldr r6, _0215F1A0 // =0x00006FE0
	b _0215F034
_0215F014:
	ldr r5, _0215F1A0 // =0x00006FE0
	ldr r6, _0215F19C // =0x00007BF7
	b _0215F034
_0215F020:
	ldr r5, _0215F19C // =0x00007BF7
	ldr r6, _0215F1A4 // =0x00007FFF
	b _0215F034
_0215F02C:
	ldr r5, _0215F1A4 // =0x00007FFF
	ldr r6, _0215F19C // =0x00007BF7
_0215F034:
	add r0, r4, #0x1600
	ldrsh r2, [r0, #0x7e]
	mov r0, r5
	mov r1, r6
	mov r3, r7
	bl Unknown2051334__Func_20516EC
	add r1, r4, #0x1600
	strh r0, [r1, #0x94]
	add r0, r4, #0x1000
	ldr r0, [r0, #0x680]
	add r0, r0, #7
	and r0, r0, #3
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0215F0AC
_0215F070: // jump table
	b _0215F080 // case 0
	b _0215F08C // case 1
	b _0215F098 // case 2
	b _0215F0A4 // case 3
_0215F080:
	ldr r5, _0215F19C // =0x00007BF7
	ldr r6, _0215F1A0 // =0x00006FE0
	b _0215F0AC
_0215F08C:
	ldr r5, _0215F1A0 // =0x00006FE0
	ldr r6, _0215F19C // =0x00007BF7
	b _0215F0AC
_0215F098:
	ldr r5, _0215F19C // =0x00007BF7
	ldr r6, _0215F1A4 // =0x00007FFF
	b _0215F0AC
_0215F0A4:
	ldr r5, _0215F1A4 // =0x00007FFF
	ldr r6, _0215F19C // =0x00007BF7
_0215F0AC:
	add r0, r4, #0x1600
	ldrsh r2, [r0, #0x7e]
	mov r0, r5
	mov r1, r6
	mov r3, r7
	bl Unknown2051334__Func_20516EC
	add r1, r4, #0x1600
	strh r0, [r1, #0xa2]
	ldrsh r2, [r1, #0x7c]
	add r0, r4, #0x27c
	add r3, r0, #0x1400
	add r0, r2, #0x20
	strh r0, [r1, #0x7c]
	ldrsh r2, [r1, #0x7e]
	ldrsh r0, [r1, #0x7c]
	cmp r0, r2
	blt _0215F10C
	ldrsh r1, [r3, #0]
	add r0, r4, #0x1000
	sub r1, r1, r2
	strh r1, [r3]
	ldr r1, [r0, #0x680]
	add r1, r1, #3
	str r1, [r0, #0x680]
_0215F10C:
	add r0, r4, #0x2a4
	add r1, r4, #0x1bc
	add r11, r0, #0x1400
	mov r0, #0
	add r9, r1, #0x1400
	str r0, [sp]
	add r7, sp, #4
	mov r6, r0
	mov r5, r0
_0215F130:
	mov r8, #0
	mov r10, r11
_0215F138:
	add r0, r4, r8, lsl #1
	str r6, [r7]
	str r6, [r7, #4]
	str r6, [r7, #8]
	add r0, r0, #0x1600
	ldrsh r3, [r0, #0x86]
	mov r0, r10
	mov r1, r7
	mov r2, r9
	bl Unknown2051334__Func_20514DC
	add r8, r8, #1
	str r5, [r10, #8]
	cmp r8, #6
	add r10, r10, #0xc
	blt _0215F138
	ldr r0, [sp]
	add r11, r11, #0x48
	add r0, r0, #1
	str r0, [sp]
	cmp r0, #0x10
	add r9, r9, #0xc
	blt _0215F130
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215F198: .word ovl05_02172EB4
_0215F19C: .word 0x00007BF7
_0215F1A0: .word 0x00006FE0
_0215F1A4: .word 0x00007FFF
	arm_func_end ViDock__Func_215EF40

	arm_func_start ViDock__Func_215F1A8
ViDock__Func_215F1A8: // 0x0215F1A8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xa0
	mov r5, #0
	mov r10, r0
	sub r4, r5, #0x400000
	mov r3, #0x400000
	mov r2, #0x300000
	mov r1, #0x1000
	add r0, sp, #0x64
	str r5, [sp, #0x94]
	str r5, [sp, #0x98]
	str r4, [sp, #0x9c]
	str r3, [sp, #0x88]
	str r2, [sp, #0x8c]
	str r1, [sp, #0x90]
	bl MTX_Identity33_
	add r0, sp, #0x94
	bl NNS_G3dGlbSetBaseTrans
	add r0, sp, #0x88
	bl NNS_G3dGlbSetBaseScale
	ldr r1, _0215F6BC // =NNS_G3dGlb+0x000000BC
	add r0, sp, #0x64
	bl MI_Copy36B
	ldr r0, _0215F6C0 // =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	bic r1, r1, #0xa4
	str r1, [r0, #0xfc]
	bl NNS_G3dGlbFlushWVP
	ldr r1, _0215F6C4 // =0x001F00C0
	mov r0, #0x29
	str r1, [sp, #0x60]
	add r1, sp, #0x60
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, #0x20000000
	str r0, [sp, #0x5c]
	mov r0, #0x2a
	add r1, sp, #0x5c
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, r5
	str r0, [sp, #0x58]
	mov r0, #0x2b
	add r1, sp, #0x58
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, #2
	str r0, [sp, #0x54]
	mov r0, #0x10
	add r1, sp, #0x54
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r1, r5
	mov r0, #0x11
	mov r2, r1
	bl NNS_G3dGeBufferOP_N
	mov r0, r5
	str r0, [sp, #4]
	str r10, [sp]
	mov r8, r10
_0215F298:
	mov r3, #2
	add r1, sp, #0x50
	mov r0, #0x40
	mov r2, #1
	str r3, [sp, #0x50]
	bl NNS_G3dGeBufferOP_N
	add r0, r10, #0x1600
	ldrsh r2, [r0, #0x84]
	ldrsh r1, [r0, #0x86]
	cmp r2, r1
	bge _0215F2F4
	ldrh r3, [r0, #0x94]
	add r1, sp, #0x4c
	mov r0, #0x20
	mov r2, #1
	str r3, [sp, #0x4c]
	bl NNS_G3dGeBufferOP_N
	mov r3, #0
	add r1, sp, #0x48
	mov r0, #0x25
	mov r2, #1
	str r3, [sp, #0x48]
	bl NNS_G3dGeBufferOP_N
_0215F2F4:
	ldr r9, [sp]
	mov r7, #0
	mov r6, #0x20
	add r5, sp, #0x44
	mov r4, #1
	mov r11, #0x25
_0215F30C:
	add r0, r10, r7, lsl #1
	add r0, r0, #0x1600
	ldrh r2, [r0, #0x96]
	mov r0, r6
	mov r1, r5
	str r2, [sp, #0x44]
	mov r2, r4
	bl NNS_G3dGeBufferOP_N
	add r0, r9, #0x1000
	ldr r1, [r0, #0x6a8]
	ldr r2, [r0, #0x6a4]
	mov r1, r1, lsl #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, asr #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r0, r1, r0, lsr #16
	str r0, [sp, #0x40]
	mov r0, r11
	add r1, sp, #0x40
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, r9, #0x1000
	ldr r1, [r0, #0x6f0]
	ldr r2, [r0, #0x6ec]
	mov r1, r1, lsl #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, asr #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r0, r1, r0, lsr #16
	str r0, [sp, #0x3c]
	mov r0, #0x25
	add r1, sp, #0x3c
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r7, r7, #1
	add r9, r9, #0xc
	cmp r7, #6
	blt _0215F30C
	add r0, r10, #0x1600
	ldrsh r2, [r0, #0x90]
	ldrsh r1, [r0, #0x92]
	cmp r2, r1
	bge _0215F478
	ldrh r3, [r0, #0xa2]
	add r1, sp, #0x38
	mov r0, #0x20
	mov r2, #1
	str r3, [sp, #0x38]
	bl NNS_G3dGeBufferOP_N
	add r0, r8, #0x1000
	ldr r1, [r0, #0x5c0]
	ldr r2, [r0, #0x5bc]
	mov r0, r1, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r3, r1, r0, lsr #16
	add r1, sp, #0x34
	mov r0, #0x25
	mov r2, #1
	str r3, [sp, #0x34]
	bl NNS_G3dGeBufferOP_N
	add r0, r8, #0x1000
	ldr r1, [r0, #0x5cc]
	ldr r2, [r0, #0x5c8]
	mov r0, r1, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r3, r1, r0, lsr #16
	add r1, sp, #0x30
	mov r0, #0x25
	mov r2, #1
	str r3, [sp, #0x30]
	bl NNS_G3dGeBufferOP_N
_0215F478:
	mov r1, #0
	mov r2, r1
	mov r0, #0x41
	bl NNS_G3dGeBufferOP_N
	ldr r0, [sp, #4]
	add r8, r8, #0xc
	add r0, r0, #1
	str r0, [sp, #4]
	cmp r0, #0xf
	ldr r0, [sp]
	add r0, r0, #0x48
	str r0, [sp]
	blt _0215F298
	mov r3, #2
	add r1, sp, #0x2c
	mov r0, #0x40
	mov r2, #1
	str r3, [sp, #0x2c]
	bl NNS_G3dGeBufferOP_N
	add r0, r10, #0x1600
	ldrsh r2, [r0, #0x84]
	ldrsh r1, [r0, #0x86]
	cmp r2, r1
	bge _0215F508
	ldrh r3, [r0, #0x94]
	add r1, sp, #0x28
	mov r0, #0x20
	mov r2, #1
	str r3, [sp, #0x28]
	bl NNS_G3dGeBufferOP_N
	mov r3, #0
	add r1, sp, #0x24
	mov r0, #0x25
	mov r2, #1
	str r3, [sp, #0x24]
	bl NNS_G3dGeBufferOP_N
_0215F508:
	mov r8, r10
	mov r9, #0
	mov r7, #0x20
	add r6, sp, #0x20
	mov r5, #1
	mov r4, #0x25
	add r11, sp, #0x1c
_0215F524:
	add r0, r10, r9, lsl #1
	add r0, r0, #0x1600
	ldrh r2, [r0, #0x96]
	mov r0, r7
	mov r1, r6
	str r2, [sp, #0x20]
	mov r2, r5
	bl NNS_G3dGeBufferOP_N
	add r0, r8, #0x1000
	ldr r1, [r0, #0xae0]
	ldr r2, [r0, #0xadc]
	mov r1, r1, lsl #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, asr #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r0, r1, r0, lsr #16
	str r0, [sp, #0x1c]
	mov r0, r4
	mov r1, r11
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, r8, #0x1000
	ldr r1, [r0, #0x6a8]
	ldr r2, [r0, #0x6a4]
	mov r1, r1, lsl #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, asr #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r0, r1, r0, lsr #16
	str r0, [sp, #0x18]
	mov r0, #0x25
	add r1, sp, #0x18
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r9, r9, #1
	add r8, r8, #0xc
	cmp r9, #6
	blt _0215F524
	add r0, r10, #0x1600
	ldrsh r2, [r0, #0x90]
	ldrsh r1, [r0, #0x92]
	cmp r2, r1
	bge _0215F690
	ldrh r3, [r0, #0xa2]
	add r1, sp, #0x14
	mov r0, #0x20
	mov r2, #1
	str r3, [sp, #0x14]
	bl NNS_G3dGeBufferOP_N
	add r0, r10, #0x1000
	ldr r1, [r0, #0x674]
	ldr r2, [r0, #0x670]
	mov r0, r1, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r3, r1, r0, lsr #16
	add r1, sp, #0x10
	mov r0, #0x25
	mov r2, #1
	str r3, [sp, #0x10]
	bl NNS_G3dGeBufferOP_N
	add r0, r10, #0x1000
	ldr r1, [r0, #0x5c0]
	ldr r2, [r0, #0x5bc]
	mov r0, r1, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r0, r0, asr #0x10
	mov r1, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r3, r1, r0, lsr #16
	add r1, sp, #0xc
	mov r0, #0x25
	mov r2, #1
	str r3, [sp, #0xc]
	bl NNS_G3dGeBufferOP_N
_0215F690:
	mov r1, #0
	mov r2, r1
	mov r0, #0x41
	bl NNS_G3dGeBufferOP_N
	mov r2, #1
	add r1, sp, #8
	mov r0, #0x12
	str r2, [sp, #8]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0xa0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215F6BC: .word NNS_G3dGlb+0x000000BC
_0215F6C0: .word NNS_G3dGlb
_0215F6C4: .word 0x001F00C0
	arm_func_end ViDock__Func_215F1A8

	arm_func_start ViDock__Func_215F6C8
ViDock__Func_215F6C8: // 0x0215F6C8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	mov r10, r0
	ldrh r0, [r10, #2]
	mov r11, r1
	str r2, [sp, #4]
	add r0, r0, #0xff
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	mov r4, r3
	movls r5, #0
	bls _0215F728
	ldrh r0, [r10, #0]
	cmp r0, #7
	movhs r5, #0
	bhs _0215F728
	bl DockHelpers__Func_2152970
	ldr r0, [r0, #0]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl DockHelpers__GetDockBackInfo
	ldrh r5, [r0, #0x18]
_0215F728:
	mov r3, #2
	add r1, sp, #0xc
	mov r0, #0x10
	mov r2, #1
	str r3, [sp, #0xc]
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r2, r1
	mov r0, #0x11
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r2, r1
	mov r0, #0x15
	bl NNS_G3dGeBufferOP_N
	add r0, r10, #0x18
	bl ViMapIcon__Func_2163EBC
	cmp r4, #0
	beq _0215F784
	mov r2, #0
	mov r1, r5
	mov r3, r2
	add r0, r10, #0xf8
	bl ViDockBack__Func_2164AB4
_0215F784:
	ldrh r0, [r10, #0]
	bl DockHelpers__Func_2152970
	ldr r1, [sp, #4]
	ldrsh r7, [r0, #0x40]
	cmp r1, #0
	beq _0215F838
	add r0, r10, #0x1000
	ldr r9, [r0, #0x138]
	cmp r9, #0
	moveq r9, #0
	cmp r9, #0
	beq _0215F838
	mov r0, #0x5000
	umull r3, r2, r7, r0
	mov r1, #0
	mla r2, r7, r1, r2
	mov r1, r7, asr #0x1f
	adds r3, r3, #0x800
	mla r2, r1, r0, r2
	adc r0, r2, #0
	mov r8, r3, lsr #0xc
	cmp r9, #0
	orr r8, r8, r0, lsl #20
	beq _0215F838
	add r4, r10, #0x48
	add r5, r10, #0x130
_0215F7EC:
	add r0, r9, #8
	bl CPPHelpers__Func_2085F9C
	mov r6, r0
	add r0, r9, #8
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r6, #8]
	mov r2, r8
	str r1, [sp]
	ldr r3, [r0, #0]
	add r0, r10, #0xf8
	add r1, r4, #0x1400
	bl ViDockBack__Func_2164BF4
	mov r0, r9
	bl _ZN11CVi3dObject4DrawEv
	add r0, r5, #0x1000
	mov r1, r9
	bl _ZN15CViDockNpcGroup10GetNextNpcEP10CViDockNpc
	movs r9, r0
	bne _0215F7EC
_0215F838:
	cmp r11, #0
	beq _0215F8A4
	add r0, r10, #0xe00
	bl CPPHelpers__Func_2085F9C
	mov r4, r0
	add r0, r10, #0xe00
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r4, #8]
	mov r2, #0x5000
	mov r4, #0
	umull r8, r6, r7, r2
	str r1, [sp]
	ldr r3, [r0, #0]
	add r1, r10, #0x48
	mla r6, r7, r4, r6
	mov r5, r7, asr #0x1f
	mla r6, r5, r2, r6
	adds r2, r8, #0x800
	adc r4, r6, #0
	mov r2, r2, lsr #0xc
	add r0, r10, #0xf8
	add r1, r1, #0x1400
	orr r2, r2, r4, lsl #20
	bl ViDockBack__Func_2164BF4
	add r0, r10, #0x1f8
	add r0, r0, #0xc00
	bl _ZN11CVi3dObject4DrawEv
_0215F8A4:
	ldr r0, [sp, #4]
	cmp r0, #0
	cmpne r11, #0
	beq _0215F8CC
	add r0, r10, #0xe00
	bl CPPHelpers__Func_2085F9C
	add r2, r10, #0x130
	mov r1, r0
	add r0, r2, #0x1000
	bl _ZN15CViDockNpcGroup4DrawEP7VecFx32
_0215F8CC:
	mov r2, #1
	add r1, sp, #8
	mov r0, #0x12
	str r2, [sp, #8]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end ViDock__Func_215F6C8

	arm_func_start ViDock__Func_215F8E8
ViDock__Func_215F8E8: // 0x0215F8E8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	ldreqh r0, [r4, #0]
	cmpeq r0, #6
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x1000
	ldr r1, [r0, #0xb24]
	cmp r1, #0x8c
	bne _0215F920
	mov r0, #7
	bl PlayHubSfx
	b _0215F92C
_0215F920:
	cmp r1, #0
	moveq r1, #0xc8
	streq r1, [r0, #0xb24]
_0215F92C:
	add r0, r4, #0x1000
	ldr r1, [r0, #0xb24]
	sub r1, r1, #1
	str r1, [r0, #0xb24]
	ldmia sp!, {r4, pc}
	arm_func_end ViDock__Func_215F8E8

	arm_func_start ViDock__Main
ViDock__Main: // 0x0215F940
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0xe00
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	add r0, r4, #0x18
	bl ViMapIcon__Func_2163A84
	add r0, r4, #0x18
	bl ViMapIcon__Func_2163C80
	add r0, r4, #0x1f8
	add r0, r0, #0xc00
	mov r1, #0x1000
	bl ViDockPlayer__Func_21667D4
	add r0, r4, #0xf8
	bl ViDockBack__Func_21649DC
	mov r0, r4
	mov r1, #1
	mov r2, r1
	mov r3, r1
	bl ViDock__Func_215F6C8
	ldmia sp!, {r4, pc}
	arm_func_end ViDock__Main

	arm_func_start ViDock__Func_215F998
ViDock__Func_215F998: // 0x0215F998
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x18
	bl ViMapIcon__Func_2163C80
	add r0, r4, #0xf8
	bl ViDockBack__Func_21649DC
	mov r1, #0
	mov r0, r4
	mov r2, r1
	mov r3, #1
	bl ViDock__Func_215F6C8
	ldmia sp!, {r4, pc}
	arm_func_end ViDock__Func_215F998

	arm_func_start ViDock__Func_215F9CC
ViDock__Func_215F9CC: // 0x0215F9CC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x30
	bl GetCurrentTaskWork_
	mov r7, r0
	ldrh r0, [r7, #0]
	bl DockHelpers__Func_2152970
	mov r4, r0
	mov r0, r7
	bl ViDock__Func_215E830
	ldrh r0, [r7, #0]
	bl DockHelpers__Func_2152970
	ldrsh r1, [r0, #0x40]
	add r0, r7, #0x1f8
	add r0, r0, #0xc00
	bl ViDockPlayer__Func_21667D4
	add r0, r7, #0xe00
	bl CPPHelpers__Func_2085F9C
	mov r5, r0
	add r0, r7, #0x1f8
	add r0, r0, #0xc00
	bl ViDockPlayer__Func_21667A0
	add r3, sp, #0x20
	mov r1, r0
	str r3, [sp]
	add r0, sp, #0x1c
	str r0, [sp, #4]
	add r3, sp, #0x18
	str r3, [sp, #8]
	mov r2, r5
	add r0, r7, #0xf8
	add r3, sp, #0x24
	bl ViDockBack__Func_2164B58
	add r1, sp, #0x24
	ldmia r1, {r1, r2, r3}
	add r0, r7, #0xf8
	bl ViDockBack__Func_2164BC8
	str r0, [sp, #0x28]
	add r0, r7, #0xe00
	add r1, sp, #0x24
	bl CPPHelpers__VEC_Copy_Alt
	ldr r0, [sp, #0x20]
	cmp r0, #0
	beq _0215FAAC
	ldr r0, _0215FD40 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	bne _0215FA9C
	add r0, r7, #0x1000
	ldr r0, [r0, #0x46c]
	cmp r0, #0
	movne r0, #0
	strne r0, [sp, #0x20]
_0215FA9C:
	add r0, r7, #0x1000
	mov r1, #1
	str r1, [r0, #0x46c]
	b _0215FAB8
_0215FAAC:
	add r0, r7, #0x1000
	mov r1, #0
	str r1, [r0, #0x46c]
_0215FAB8:
	ldr r0, [sp, #0x1c]
	cmp r0, #0
	movne r0, #1
	strne r0, [sp, #0x20]
	add r0, r7, #0xe00
	bl CPPHelpers__Func_2085F9C
	add r1, r7, #0x1f8
	mov r6, r0
	add r0, r1, #0xc00
	bl ViDockPlayer__Func_21667A0
	mov r5, r0
	ldrh r0, [r7, #0]
	bl DockHelpers__Func_2152970
	ldrsh r3, [r0, #0x40]
	add r0, r7, #0x130
	mov r1, r5
	str r3, [sp]
	mov r2, r6
	add r0, r0, #0x1000
	add r3, sp, #0x24
	bl _ZN15CViDockNpcGroup12Func_2168608EP7VecFx32S1_S1_l
	cmp r0, #0
	beq _0215FB20
	add r1, sp, #0x24
	add r0, r7, #0xe00
	bl CPPHelpers__VEC_Copy_Alt
_0215FB20:
	add r0, r7, #0xf8
	bl ViDockBack__Func_21649DC
	add r0, r7, #0x130
	add r0, r0, #0x1000
	bl _ZN15CViDockNpcGroup7AnimateEv
	add r0, r7, #0xe00
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r0, #0]
	str r1, [sp, #0x24]
	ldr r1, [r0, #4]
	str r1, [sp, #0x28]
	ldr r0, [r0, #8]
	str r0, [sp, #0x2c]
	ldrh r0, [r7, #0]
	cmp r0, #7
	bhs _0215FB70
	add r0, sp, #0x24
	add r1, r4, #8
	mov r2, r0
	bl VEC_Add
_0215FB70:
	add r1, sp, #0x24
	add r0, r7, #0x18
	bl ViMapIcon__Func_2163A84
	add r0, r7, #0x18
	bl ViMapIcon__Func_2163C80
	mov r0, r7
	bl ViDock__Func_215F8E8
	mov r1, #1
	mov r0, r7
	mov r2, r1
	mov r3, r1
	bl ViDock__Func_215F6C8
	add r0, r7, #0x1000
	mov r1, #0xc
	str r1, [r0, #0x460]
	mov r1, #0
	str r1, [r0, #0x464]
	str r1, [r0, #0x468]
	ldr r1, [sp, #0x20]
	cmp r1, #0
	beq _0215FBDC
	mov r1, #1
	str r1, [r0, #0x460]
	ldrh r1, [r7, #0]
	add sp, sp, #0x30
	str r1, [r0, #0x464]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0215FBDC:
	ldr r1, [sp, #0x18]
	cmp r1, #8
	ldrneh r0, [r7, #0]
	cmpne r1, r0
	addne sp, sp, #0x30
	strne r1, [r7, #4]
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r9, #0
	mov r8, r9
	add r4, r7, #0x1f8
	add r5, r7, #0x130
	add r11, r7, #0xe00
_0215FC0C:
	add r0, r4, #0xc00
	ldrh r10, [r11, #0x32]
	bl ViDockPlayer__Func_21667A0
	mov r6, r0
	ldrh r0, [r7, #0]
	bl DockHelpers__Func_2152970
	add r3, sp, #0x14
	stmia sp, {r3, r8}
	ldrsh r3, [r0, #0x40]
	mov r1, r6
	mov r2, r10
	add r0, r5, #0x1000
	bl _ZN15CViDockNpcGroup12Func_2168674EP7VecFx32llPiP10CViDockNpc
	movs r8, r0
	beq _0215FCF0
	ldr r0, [sp, #0x14]
	cmp r0, #0
	beq _0215FC64
	ldr r0, _0215FD40 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	movne r9, #1
_0215FC64:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0215FC84
	ldr r0, _0215FD44 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	movne r0, #1
	bne _0215FC88
_0215FC84:
	mov r0, #0
_0215FC88:
	cmp r0, #0
	beq _0215FCE0
	bl _ZN10HubControl12Func_2157178Ev
	cmp r0, #0
	beq _0215FCE0
	ldr r0, _0215FD44 // =touchInput
	ldrh r6, [r0, #0x1c]
	ldrh r10, [r0, #0x1e]
	add r0, r8, #8
	bl CPPHelpers__Func_2085F9C
	add r1, sp, #0x10
	add r2, sp, #0xc
	bl NNS_G3dWorldPosToScrPos
	ldr r3, [sp, #0xc]
	mov r1, r6
	str r3, [sp]
	ldr r3, [sp, #0x10]
	mov r2, r10
	mov r0, r7
	bl ViDock__Func_215EC58
	cmp r0, #0
	movne r9, #1
_0215FCE0:
	cmp r9, #0
	bne _0215FCF0
	cmp r8, #0
	bne _0215FC0C
_0215FCF0:
	cmp r9, #0
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r7, #0x460
	adds r0, r0, #0x1000
	ldrne r1, [r8, #0x304]
	addne r0, r7, #0x1000
	strne r1, [r0, #0x460]
	add r0, r7, #0x64
	adds r0, r0, #0x1400
	ldrne r1, [r8, #0x308]
	addne r0, r7, #0x1000
	strne r1, [r0, #0x464]
	ldr r1, [r8, #0x30c]
	add r0, r7, #0x1000
	add r1, r1, #1
	str r1, [r8, #0x30c]
	str r8, [r0, #0x468]
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215FD40: .word padInput
_0215FD44: .word touchInput
	arm_func_end ViDock__Func_215F9CC

	arm_func_start ViDock__Func_215FD48
ViDock__Func_215FD48: // 0x0215FD48
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	bl GetCurrentTaskWork_
	mov r4, r0
	ldrh r0, [r4, #0]
	bl DockHelpers__Func_2152970
	ldr r1, [r4, #0x10]
	mov r5, r0
	cmp r1, #0
	beq _0215FD8C
	add r0, r4, #0x1f8
	add r0, r0, #0xc00
	mov r1, #0x1000
	bl ViDockPlayer__Func_21667D4
	add r0, r4, #0x130
	add r0, r0, #0x1000
	bl _ZN15CViDockNpcGroup7AnimateEv
_0215FD8C:
	add r0, r4, #0xf8
	bl ViDockBack__Func_21649DC
	add r0, r4, #0xe00
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r0, #0]
	str r1, [sp]
	ldr r1, [r0, #4]
	str r1, [sp, #4]
	ldr r0, [r0, #8]
	str r0, [sp, #8]
	ldrh r0, [r4, #0]
	cmp r0, #7
	bhs _0215FDD0
	add r0, sp, #0
	add r1, r5, #8
	mov r2, r0
	bl VEC_Add
_0215FDD0:
	add r1, sp, #0
	add r0, r4, #0x18
	bl ViMapIcon__Func_2163A84
	add r0, r4, #0x18
	bl ViMapIcon__Func_2163C80
	ldr r1, [r4, #0x10]
	mov r0, r4
	mov r2, r1
	mov r3, #1
	bl ViDock__Func_215F6C8
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end ViDock__Func_215FD48

	arm_func_start ViDock__Func_215FE00
ViDock__Func_215FE00: // 0x0215FE00
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl ViDock__Func_215EA8C
	ldrh r0, [r4, #0]
	bl DockHelpers__Func_2152984
	ldr r1, [r0, #0]
	add r0, r4, #0xf8
	bl ViDockBack__Func_2164918
	ldr r0, _0215FE30 // =ViDock__Func_215FE34
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215FE30: .word ViDock__Func_215FE34
	arm_func_end ViDock__Func_215FE00

	arm_func_start ViDock__Func_215FE34
ViDock__Func_215FE34: // 0x0215FE34
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0xf8
	bl ViDockBack__Func_2164954
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, _0215FE64 // =ViDock__Func_215F998
	bl SetCurrentTaskMainEvent
	mov r0, #1
	str r0, [r4, #0xc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215FE64: .word ViDock__Func_215F998
	arm_func_end ViDock__Func_215FE34

	arm_func_start ViDock__Func_215FE68
ViDock__Func_215FE68: // 0x0215FE68
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	bl GetCurrentTaskWork_
	mov r5, r0
	ldrh r0, [r5, #0]
	bl DockHelpers__Func_2152994
	mov r4, r0
	add r0, r5, #0x18
	bl ViMapIcon__Func_2163C80
	add r0, r5, #0xf8
	bl ViDockBack__Func_21649DC
	mov r0, r5
	bl ViDock__Func_215EF40
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0x10
	add r1, sp, #4
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r0, #0x11
	mov r2, r1
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r0, #0x15
	mov r2, r1
	bl NNS_G3dGeBufferOP_N
	add r0, r5, #0x18
	bl ViMapIcon__Func_2163EBC
	mov r0, r5
	bl ViDock__Func_215F1A8
	ldr r1, [r4, #0xc]
	add r0, r5, #0xf8
	bl ViDockBack__Func_2164A38
	ldr r1, [r4, #8]
	add r0, r5, #0xf8
	bl ViDockBack__Func_2164A8C
	add r1, r5, #0x1500
	ldrh r2, [r4, #0x10]
	ldrh r1, [r1, #0xb8]
	add r0, r5, #0xf8
	mov r3, #0
	bl ViDockBack__Func_2164AB4
	mov r2, #1
	mov r0, #0x12
	add r1, sp, #0
	str r2, [sp]
	bl NNS_G3dGeBufferOP_N
	add r0, r5, #0x1500
	ldrh r1, [r0, #0xb8]
	add r1, r1, #0x100
	strh r1, [r0, #0xb8]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViDock__Func_215FE68

	arm_func_start ViDock__Destructor
ViDock__Destructor: // 0x0215FF40
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	bl ViDock__Func_215E6E4
	mov r0, r4
	bl ViDock__Func_215FF6C
	ldr r0, _0215FF68 // =ViDock__TaskSingleton
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215FF68: .word ViDock__TaskSingleton
	arm_func_end ViDock__Destructor

	arm_func_start ViDock__Func_215FF6C
ViDock__Func_215FF6C: // 0x0215FF6C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x10]
	cmp r4, #0
	beq _0215FFB4
	add r0, r4, #0x48
	add r0, r0, #0x1400
	bl _ZN9CViShadowD0Ev
	add r0, r4, #0x130
	add r0, r0, #0x1000
	bl _ZN15CViDockNpcGroupD1Ev
	add r0, r4, #0x1f8
	add r0, r0, #0xc00
	bl _ZN13CViDockPlayerD0Ev
	add r0, r4, #0xf8
	bl ViDockBack__VTableFunc_21644C0
	mov r0, r4
	bl _ZdlPv
_0215FFB4:
	mov r0, #0
	str r0, [r5, #0x10]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViDock__Func_215FF6C

	arm_func_start ViDock__Func_215FFC0
ViDock__Func_215FFC0: // 0x0215FFC0
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x32c
	add r0, r0, #0x1800
	bl IsThreadWorkerFinished
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r1, r4, #0x1000
	mov r0, #0
	str r0, [r1, #0xb28]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	arm_func_end ViDock__Func_215FFC0

	arm_func_start ViDock__Func_215FFF4
ViDock__Func_215FFF4: // 0x0215FFF4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r1, [r4, #0]
	ldr r2, [r4, #4]
	strh r2, [r4]
	bl ViDock__Func_215E754
	mov r0, r4
	mov r1, #0
	bl ViDock__Func_215E9F4
	mov r0, r4
	bl ViDock__Func_215EA8C
	mov r0, r4
	bl ViDock__Func_215EB04
	ldrh r0, [r4, #0]
	bl DockHelpers__Func_2152970
	ldrh r1, [r0, #0x34]
	add r0, r4, #0x1400
	strh r1, [r0, #0x5c]
	ldmia sp!, {r4, pc}
	arm_func_end ViDock__Func_215FFF4
	
	.rodata

.public ovl05_02172EB4
ovl05_02172EB4: // 0x02172EB4
    .byte 224, 111, 247, 123, 255, 127, 247, 123
	
.public ovl05_02172EBC
ovl05_02172EBC: // 0x02172EBC
    .hword 5, 4, 4, 3, 2, 2, 2
	
.public ovl05_02172ECA
ovl05_02172ECA: // 0x02172ECA
    .hword 0, 5, 9, 0xD, 0x10, 0x12, 0x14
	
.public ovl05_02172ED8
ovl05_02172ED8: // 0x02172ED8
    .hword 0xFFF0, 0xFFE0
	.hword 0x10, 8
	.hword 0xFFF0, 0xFFE0
	.hword 0x10, 8
	.hword 0xFFF0, 0xFFE0
	.hword 0x10, 8
	.hword 0xFFF4, 0xFFE8
	.hword 0xC, 4
	.hword 0xFFF4, 0xFFE8
	.hword 0xC, 4
	.hword 0xFFF4, 0xFFE8
	.hword 0xC, 4
	.hword 0xFFF4, 0xFFE8
	.hword 0xC, 4
	.hword 0x32, 0x10
	.hword 8, 0
	.hword 0x64, 0