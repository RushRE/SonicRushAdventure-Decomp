	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start SpringRopeSpring__Create
SpringRopeSpring__Create: // 0x0218604C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _02186168 // =StageTask_Main
	ldr r1, _0218616C // =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	mov r0, #0xa1
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02186170 // =gameArchiveStage
	mov r1, #8
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _02186174 // =aActAcGmkRopeCS
	bl ObjObjectAction2dBACLoad
	ldr r3, [r4, #0x128]
	mov r0, r4
	ldr r2, [r3, #0x3c]
	mov r1, #0
	orr r2, r2, #0x200
	str r2, [r3, #0x3c]
	mov r2, #2
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	ldr r0, [r4, #0x18]
	ldr r1, _02186178 // =ovl00_218617C
	orr r0, r0, #0x12
	str r0, [r4, #0x18]
	ldr r2, [r4, #0x1c]
	mov r0, r4
	orr r2, r2, #0x2100
	str r2, [r4, #0x1c]
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02186168: .word StageTask_Main
_0218616C: .word GameObject__Destructor
_02186170: .word gameArchiveStage
_02186174: .word aActAcGmkRopeCS
_02186178: .word ovl00_218617C
	arm_func_end SpringRopeSpring__Create

	arm_func_start ovl00_218617C
ovl00_218617C: // 0x0218617C
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x11c]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldr r1, [r1, #0x18]
	tst r1, #2
	ldmeqia sp!, {r3, pc}
	bl ovl00_21861A0
	ldmia sp!, {r3, pc}
	arm_func_end ovl00_218617C

	arm_func_start ovl00_21861A0
ovl00_21861A0: // 0x021861A0
	ldr r2, _021861C0 // =ovl00_21861C4
	mov r1, #0x1400
	str r2, [r0, #0xf4]
	mov r2, #0x8000
	str r2, [r0, #4]
	str r1, [r0, #0x3c]
	str r1, [r0, #0x38]
	bx lr
	.align 2, 0
_021861C0: .word ovl00_21861C4
	arm_func_end ovl00_21861A0

	arm_func_start ovl00_21861C4
ovl00_21861C4: // 0x021861C4
	ldr r1, [r0, #0x38]
	cmp r1, #0x1000
	subgt r1, r1, #0x200
	strgt r1, [r0, #0x38]
	strgt r1, [r0, #0x3c]
	ldr r1, [r0, #0x11c]
	cmp r1, #0
	bxeq lr
	ldr r1, [r1, #0x18]
	tst r1, #2
	bxne lr
	mov r2, #0x1000
	str r2, [r0, #0x3c]
	ldr r1, _02186208 // =ovl00_218617C
	str r2, [r0, #0x38]
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_02186208: .word ovl00_218617C
	arm_func_end ovl00_21861C4

	.data
	
	
aActAcGmkRopeCS: // 0x02189E04
	.asciz "/act/ac_gmk_rope_c_spring.bac"
	.align 4