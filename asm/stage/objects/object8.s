	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Object8__Create
Object8__Create: // 0x02158D54
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	movs r7, r0
	mov r6, r1
	mov r5, r2
	beq _02158D80
	ldrb r0, [r7]
	cmp r0, #0xff
	ldreqb r0, [r7, #1]
	cmpeq r0, #0xff
	beq _02158DA4
_02158D80:
	ldr r0, _02158FA8 // =gameState
	ldr r0, [r0, #0x18]
	cmp r0, #0
	bne _02158DA4
	ldrh r0, [r7, #4]
	tst r0, #0x80
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
_02158DA4:
	mov r0, #0x1500
	mov r2, #0
	str r0, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x3a8
	ldr r0, _02158FAC // =StageTask_Main
	ldr r1, _02158FB0 // =GameObject__Destructor
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
	mov r2, #0x3a8
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x20]
	add r0, r4, #0x364
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x300
	str r1, [r4, #0x1c]
	ldr r5, [r4, #0x340]
	ldrsb r2, [r5, #7]
	ldrb r3, [r5, #9]
	ldrsb r1, [r5, #6]
	add r3, r2, r3
	mov r3, r3, lsl #0x10
	mov r3, r3, asr #0x10
	str r3, [sp]
	ldrb r3, [r5, #8]
	add r3, r1, r3
	mov r3, r3, lsl #0x10
	mov r3, r3, asr #0x10
	bl ObjRect__SetBox2D
	mov r1, #0
	add r0, r4, #0x364
	mov r2, r1
	bl ObjRect__SetAttackStat
	ldr r1, _02158FB4 // =0x0000FFFE
	add r0, r4, #0x364
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _02158FB8 // =0x00000102
	add r0, r4, #0x300
	strh r1, [r0, #0x98]
	ldr r1, [r4, #0x37c]
	ldr r0, _02158FBC // =Object8__Func_215902C
	orr r1, r1, #0xc0
	str r1, [r4, #0x37c]
	str r0, [r4, #0x388]
	str r4, [r4, #0x380]
	ldrh r0, [r7, #4]
	and r0, r0, #7
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _02158F3C
_02158EC0: // jump table
	b _02158EE0 // case 0
	b _02158EEC // case 1
	b _02158EF8 // case 2
	b _02158F04 // case 3
	b _02158F10 // case 4
	b _02158F1C // case 5
	b _02158F28 // case 6
	b _02158F34 // case 7
_02158EE0:
	mov r0, #0
	str r0, [r4, #0x3a4]
	b _02158F3C
_02158EEC:
	mov r0, #0xb0
	str r0, [r4, #0x3a4]
	b _02158F3C
_02158EF8:
	mov r0, #0x160
	str r0, [r4, #0x3a4]
	b _02158F3C
_02158F04:
	mov r0, #0x2c0
	str r0, [r4, #0x3a4]
	b _02158F3C
_02158F10:
	mov r0, #0x580
	str r0, [r4, #0x3a4]
	b _02158F3C
_02158F1C:
	mov r0, #0xb00
	str r0, [r4, #0x3a4]
	b _02158F3C
_02158F28:
	mov r0, #0x1600
	str r0, [r4, #0x3a4]
	b _02158F3C
_02158F34:
	mov r0, #0x2c00
	str r0, [r4, #0x3a4]
_02158F3C:
	mov r0, #0xe
	bl GetObjectFileWork
	ldr r1, _02158FC0 // =gameArchiveStage
	mov r3, r0
	ldr r0, [r1]
	ldr r5, _02158FC4 // =0x0000FFFF
	str r0, [sp]
	ldr r2, _02158FC8 // =aActAcEneGlider
	mov r0, r4
	add r1, r4, #0x168
	str r5, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	mov r2, #0x3b
	bl ObjActionAllocSpritePalette
	mov r0, r4
	bl Object8__Func_2158FCC
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02158FA8: .word gameState
_02158FAC: .word StageTask_Main
_02158FB0: .word GameObject__Destructor
_02158FB4: .word 0x0000FFFE
_02158FB8: .word 0x00000102
_02158FBC: .word Object8__Func_215902C
_02158FC0: .word gameArchiveStage
_02158FC4: .word 0x0000FFFF
_02158FC8: .word aActAcEneGlider
	arm_func_end Object8__Create

	arm_func_start Object8__Func_2158FCC
Object8__Func_2158FCC: // 0x02158FCC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _02159018 // =Object8__State_215901C
	orr r1, r1, #0x24
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x230]
	orr r1, r1, #0x800
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	orr r1, r1, #0x800
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	orr r1, r1, #0x800
	str r1, [r4, #0x2b0]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02159018: .word Object8__State_215901C
	arm_func_end Object8__Func_2158FCC

	arm_func_start Object8__State_215901C
Object8__State_215901C: // 0x0215901C
	ldr ip, _02159028 // =StageTask__HandleCollider
	add r1, r0, #0x364
	bx ip
	.align 2, 0
_02159028: .word StageTask__HandleCollider
	arm_func_end Object8__State_215901C

	arm_func_start Object8__Func_215902C
Object8__Func_215902C: // 0x0215902C
	ldr r0, [r1, #0x1c]
	ldr r1, [r0, #0x340]
	ldrh r1, [r1, #4]
	tst r1, #0x10
	ldrne r1, [r0, #0x20]
	orrne r1, r1, #1
	strne r1, [r0, #0x20]
	ldr r1, [r0, #0x20]
	tst r1, #1
	beq _02159064
	ldr r1, _021590C0 // =mapCamera
	ldr r1, [r1, #4]
	sub r1, r1, #0x1e000
	b _02159074
_02159064:
	ldr r1, _021590C0 // =mapCamera
	ldr r1, [r1, #4]
	add r1, r1, #0x1e000
	add r1, r1, #0x100000
_02159074:
	str r1, [r0, #0x44]
	ldr r2, [r0, #0x20]
	ldr r1, _021590C4 // =Object8__State_21590C8
	bic r2, r2, #0x20
	str r2, [r0, #0x20]
	ldr r2, [r0, #0x230]
	bic r2, r2, #0x800
	str r2, [r0, #0x230]
	ldr r2, [r0, #0x270]
	bic r2, r2, #0x800
	str r2, [r0, #0x270]
	ldr r2, [r0, #0x2b0]
	bic r2, r2, #0x800
	str r2, [r0, #0x2b0]
	ldr r2, [r0, #0x37c]
	orr r2, r2, #0x800
	str r2, [r0, #0x37c]
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_021590C0: .word mapCamera
_021590C4: .word Object8__State_21590C8
	arm_func_end Object8__Func_215902C

	arm_func_start Object8__State_21590C8
Object8__State_21590C8: // 0x021590C8
	ldr r1, [r0, #0x20]
	tst r1, #1
	mov r1, #0x2c00
	rsbeq r1, r1, #0
	str r1, [r0, #0x98]
	ldr r1, [r0, #0x3a4]
	str r1, [r0, #0x9c]
	bx lr
	arm_func_end Object8__State_21590C8

	.data
	
aActAcEneGlider: // 0x02188C8C
	.asciz "/act/ac_ene_glider.bac"
	.align 4