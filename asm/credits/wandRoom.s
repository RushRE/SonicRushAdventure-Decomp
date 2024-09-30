	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start WandRoom__Create
WandRoom__Create: // 0x021566A4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r1, #0x3000
	mov r5, r0
	mov r2, #0
	str r1, [sp]
	mov r4, #1
	ldr r0, _02156708 // =WandRoom__Main
	ldr r1, _0215670C // =WandRoom__Destructor
	mov r3, r2
	str r4, [sp, #4]
	mov r4, #0x148
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x148
	bl MIi_CpuClear16
	mov r0, r4
	str r5, [r4]
	bl ovl05_21549EC
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02156708: .word WandRoom__Main
_0215670C: .word WandRoom__Destructor
	arm_func_end WandRoom__Create

	arm_func_start WandRoom__Destructor
WandRoom__Destructor: // 0x02156710
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	bl ovl05_2154ABC
	ldmia sp!, {r3, pc}
	arm_func_end WandRoom__Destructor

	arm_func_start WandRoom__Main
WandRoom__Main: // 0x02156720
	ldr ip, _0215672C // =SetCurrentTaskMainEvent
	ldr r0, _02156730 // =Task__OV05Unknown21566A4__Main_2156734
	bx ip
	.align 2, 0
_0215672C: .word SetCurrentTaskMainEvent
_02156730: .word Task__OV05Unknown21566A4__Main_2156734
	arm_func_end WandRoom__Main

	arm_func_start Task__OV05Unknown21566A4__Main_2156734
Task__OV05Unknown21566A4__Main_2156734: // 0x02156734
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #4
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #4
	bl AnimatorMDL__Draw
	ldr r0, [r4, #0]
	ldr r0, [r0, #0x14]
	tst r0, #2
	ldmeqia sp!, {r4, pc}
	mov r3, #0
	mov r2, #1
_02156768:
	mov r0, r2, lsl r3
	tst r0, #8
	beq _02156788
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x10]
	bic r1, r1, #1
	strh r1, [r0, #0x10]
_02156788:
	add r3, r3, #1
	cmp r3, #5
	blo _02156768
	ldr r0, _021567A0 // =Task__OV05Unknown21566A4__Main_21567A4
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_021567A0: .word Task__OV05Unknown21566A4__Main_21567A4
	arm_func_end Task__OV05Unknown21566A4__Main_2156734

	arm_func_start Task__OV05Unknown21566A4__Main_21567A4
Task__OV05Unknown21566A4__Main_21567A4: // 0x021567A4
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #4
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #4
	bl AnimatorMDL__Draw
	ldmia sp!, {r4, pc}
	arm_func_end Task__OV05Unknown21566A4__Main_21567A4