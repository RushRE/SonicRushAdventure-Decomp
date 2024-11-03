	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailExitEvent__Create
SailExitEvent__Create: // 0x0218B368
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov r0, #2
	mov r1, #0
	str r0, [sp]
	mov r0, #4
	str r0, [sp, #4]
	ldr r0, _0218B3A0 // =SailExitEvent__Main
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0218B3A0: .word SailExitEvent__Main
	arm_func_end SailExitEvent__Create

	arm_func_start SailExitEvent__Main
SailExitEvent__Main: // 0x0218B3A4
	stmdb sp!, {r4, lr}
	ldr r4, _0218B3FC // =gameState
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x9c]
	bic r0, r0, #1
	str r0, [r4, #0x9c]
	bl MultibootManager__Func_2063C40
	mov r4, #0
_0218B3CC:
	mov r0, r4
	bl DestroyTaskGroup
	add r0, r4, #1
	and r4, r0, #0xff
	cmp r4, #6
	blo _0218B3CC
	mov r0, #5
	bl SetPadReplayState
	mov r0, #5
	bl SetTouchReplayState
	bl NextSysEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_0218B3FC: .word gameState
	arm_func_end SailExitEvent__Main

	arm_func_start SailExitEvent__Func_218B400
SailExitEvent__Func_218B400: // 0x0218B400
	ldr r0, _0218B418 // =SeaMapView__sVars+0x00000004
	ldr r0, [r0, #0]
	cmp r0, #5
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_0218B418: .word SeaMapView__sVars+0x00000004
	arm_func_end SailExitEvent__Func_218B400
