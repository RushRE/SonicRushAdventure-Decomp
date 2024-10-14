	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start FakeCredits__Create
FakeCredits__Create: // 0x021562A8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r0, #2
	mov r1, #0
	bl ovl05_2154520
	mov r0, #0x2000
	mov r2, #0
	str r0, [sp]
	ldr r4, _02156310 // =0x00000BBC
	ldr r0, _02156314 // =FakeCredits__Main
	ldr r1, _02156318 // =FakeCredits__Destructor
	mov r3, r2
	stmib sp, {r2, r4}
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02156310 // =0x00000BBC
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear16
	mov r1, #2
	mov r0, r4
	str r1, [r4, #0xc]
	bl TextCutscene__LoadAssets
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02156310: .word 0x00000BBC
_02156314: .word FakeCredits__Main
_02156318: .word FakeCredits__Destructor
	arm_func_end FakeCredits__Create

	arm_func_start FakeCredits__Destructor
FakeCredits__Destructor: // 0x0215631C
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl ovl05_2155138
	mov r0, r4
	bl ovl05_21549A4
	ldmia sp!, {r4, pc}
	arm_func_end FakeCredits__Destructor

	arm_func_start FakeCredits__Main
FakeCredits__Main: // 0x02156338
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0xc]
	bl ovl05_2154AE4
	mov r0, r4
	bl ovl05_2155034
	mov r0, #2
	mov r1, #0x800
	bl CreateDrawFadeTask
	ldr r0, _0215636C // =FakeCredits__Main_2156370
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215636C: .word FakeCredits__Main_2156370
	arm_func_end FakeCredits__Main

	arm_func_start FakeCredits__Main_2156370
FakeCredits__Main_2156370: // 0x02156370
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, _0215639C // =FakeCredits__Main_21563A0
	mov r1, #0x168
	str r1, [r4, #0x34]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215639C: .word FakeCredits__Main_21563A0
	arm_func_end FakeCredits__Main_2156370

	arm_func_start FakeCredits__Main_21563A0
FakeCredits__Main_21563A0: // 0x021563A0
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x34]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0x34]
	ldmneia sp!, {r3, pc}
	mov r0, #4
	mov r1, #0x800
	bl CreateDrawFadeTask
	ldr r0, _021563D4 // =FakeCredits__Main_21563D8
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_021563D4: .word FakeCredits__Main_21563D8
	arm_func_end FakeCredits__Main_21563A0

	arm_func_start FakeCredits__Main_21563D8
FakeCredits__Main_21563D8: // 0x021563D8
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl DestroyDrawFadeTask
	ldr r0, _021563FC // =FakeCredits__Main_2156400
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_021563FC: .word FakeCredits__Main_2156400
	arm_func_end FakeCredits__Main_21563D8

	arm_func_start FakeCredits__Main_2156400
FakeCredits__Main_2156400: // 0x02156400
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	mov r1, #0x3c
	str r1, [r0, #0x34]
	ldr r0, _0215641C // =FakeCredits__Main_2156420
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215641C: .word FakeCredits__Main_2156420
	arm_func_end FakeCredits__Main_2156400

	arm_func_start FakeCredits__Main_2156420
FakeCredits__Main_2156420: // 0x02156420
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x34]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0x34]
	ldmneia sp!, {r3, pc}
	mov r0, #0
	bl ovl05_21551D8
	bl ovl05_2155188
	ldmia sp!, {r3, pc}
	arm_func_end FakeCredits__Main_2156420
