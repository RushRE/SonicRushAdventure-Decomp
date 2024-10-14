	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start ExStageCreditsNotification__Create
ExStageCreditsNotification__Create: // 0x0215644C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r0, #0
	mov r1, #1
	bl ovl05_2154520
	mov r0, #0x2000
	mov r2, #0
	str r0, [sp]
	ldr r4, _021564BC // =0x00000BBC
	ldr r0, _021564C0 // =ExStageCreditsNotification__Main
	ldr r1, _021564C4 // =ExStageCreditsNotification__Destructor
	mov r3, r2
	stmib sp, {r2, r4}
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _021564BC // =0x00000BBC
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear16
	mov r1, #3
	mov r0, r4
	str r1, [r4, #0xc]
	bl TextCutscene__LoadAssets
	mov r0, #0x1a
	bl LoadSysSound
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021564BC: .word 0x00000BBC
_021564C0: .word ExStageCreditsNotification__Main
_021564C4: .word ExStageCreditsNotification__Destructor
	arm_func_end ExStageCreditsNotification__Create

	arm_func_start ExStageCreditsNotification__Destructor
ExStageCreditsNotification__Destructor: // 0x021564C8
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl ReleaseSysSound
	mov r0, r4
	bl ovl05_21549A4
	ldmia sp!, {r4, pc}
	arm_func_end ExStageCreditsNotification__Destructor

	arm_func_start ExStageCreditsNotification__Main
ExStageCreditsNotification__Main: // 0x021564E4
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	mov r1, #2
	bl CreditsNotification__Create
	ldr r0, _02156500 // =ExStageCreditsNotification__Main_2156504
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156500: .word ExStageCreditsNotification__Main_2156504
	arm_func_end ExStageCreditsNotification__Main

	arm_func_start ExStageCreditsNotification__Main_2156504
ExStageCreditsNotification__Main_2156504: // 0x02156504
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r0, [r0, #0x14]
	tst r0, #0x40
	ldmeqia sp!, {r3, pc}
	ldr r0, _02156524 // =ExStageCreditsNotification__Main_2156528
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156524: .word ExStageCreditsNotification__Main_2156528
	arm_func_end ExStageCreditsNotification__Main_2156504

	arm_func_start ExStageCreditsNotification__Main_2156528
ExStageCreditsNotification__Main_2156528: // 0x02156528
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	mov r1, #0x14
	str r1, [r0, #0x34]
	ldr r0, _02156544 // =ExStageCreditsNotification__Main_2156548
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156544: .word ExStageCreditsNotification__Main_2156548
	arm_func_end ExStageCreditsNotification__Main_2156528

	arm_func_start ExStageCreditsNotification__Main_2156548
ExStageCreditsNotification__Main_2156548: // 0x02156548
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x34]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0x34]
	ldmneia sp!, {r3, pc}
	mov r0, #2
	bl ovl05_21551D8
	bl ovl05_2155188
	ldmia sp!, {r3, pc}
	arm_func_end ExStageCreditsNotification__Main_2156548