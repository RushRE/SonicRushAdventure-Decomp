	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Object23__Create
Object23__Create: // 0x02160E88
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
	ldr r0, _02160FA8 // =StageTask_Main
	ldr r1, _02160FAC // =GameObject__Destructor
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
	ldrh r0, [r7, #4]
	mov r5, #0
	tst r0, #1
	beq _02160F3C
	add r0, r4, #0x218
	sub r1, r5, #0x10
	sub r2, r5, #8
	sub r3, r5, #4
	str r5, [sp]
	bl ObjRect__SetBox2D
	b _02160F54
_02160F3C:
	mov r1, #4
	add r0, r4, #0x218
	sub r2, r1, #0xc
	mov r3, #0x10
	str r5, [sp]
	bl ObjRect__SetBox2D
_02160F54:
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _02160FB0 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x230]
	ldr r0, _02160FB4 // =Object23__ppDef_2160FB8
	orr r1, r1, #0xc0
	str r1, [r4, #0x230]
	str r0, [r4, #0x23c]
	str r4, [r4, #0x234]
	ldr r1, [r4, #0x1c]
	mov r0, r4
	orr r1, r1, #0x120
	orr r1, r1, #0x2000
	str r1, [r4, #0x1c]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02160FA8: .word StageTask_Main
_02160FAC: .word GameObject__Destructor
_02160FB0: .word 0x0000FFFE
_02160FB4: .word Object23__ppDef_2160FB8
	arm_func_end Object23__Create

	arm_func_start Object23__ppDef_2160FB8
Object23__ppDef_2160FB8: // 0x02160FB8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r2, [r1, #0x1c]
	mov r1, #0
	ldr ip, [r2, #0x340]
	ldrh lr, [ip, #4]
	ldrh r4, [ip, #2]
	bic r3, lr, #0x80
	mov r3, r3, lsl #0x10
	cmp r4, #0x69
	mov r3, r3, lsr #0x10
	bne _02160FF4
	ldrsb r5, [ip, #6]
	orr r3, r3, r5, lsl #2
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
_02160FF4:
	ldr r0, [r0, #0x1c]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldrh r5, [r0]
	cmp r5, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r6, [r0, #0x648]
	ldr r7, [r0, #0xc8]
	ands r5, lr, #0x80
	movne r6, #0
	cmp r7, r6
	blt _0216102C
	tst lr, #1
	beq _02161040
_0216102C:
	rsb r6, r6, #0
	cmp r7, r6
	ldmgtia sp!, {r3, r4, r5, r6, r7, pc}
	tst lr, #1
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
_02161040:
	cmp r4, #0x69
	bne _02161060
	ldrsb r4, [ip, #7]
	orr r3, r3, #0x1000
	mov r3, r3, lsl #0x10
	cmp r4, #1
	mov r3, r3, lsr #0x10
	moveq r1, #1
_02161060:
	cmp r5, #0
	orrne r3, r3, #0x2000
	movne r3, r3, lsl #0x10
	movne r3, r3, lsr #0x10
	cmp r5, #0
	beq _021610B8
	add r1, r0, #0x500
	ldrsh r1, [r1, #0xd4]
	cmp r1, #0x1b
	blt _02161090
	cmp r1, #0x21
	ble _021610A0
_02161090:
	cmp r1, #0x54
	ldmltia sp!, {r3, r4, r5, r6, r7, pc}
	cmp r1, #0x59
	ldmgtia sp!, {r3, r4, r5, r6, r7, pc}
_021610A0:
	mov r1, #0
	str r1, [sp]
	ldr r1, [r2, #0x44]
	ldr r2, [r2, #0x48]
	bl Player__Gimmick_201BDC0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_021610B8:
	str r1, [sp]
	ldr r1, [r2, #0x44]
	ldr r2, [r2, #0x48]
	bl Player__Gimmick_201BDC0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end Object23__ppDef_2160FB8