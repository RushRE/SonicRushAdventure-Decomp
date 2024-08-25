	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start EnemyCrab__Create
EnemyCrab__Create: // 0x02156ED8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	movs r7, r0
	mov r6, r1
	mov r5, r2
	beq _02156F04
	ldrb r0, [r7]
	cmp r0, #0xff
	ldreqb r0, [r7, #1]
	cmpeq r0, #0xff
	beq _02156F28
_02156F04:
	ldr r0, _0215707C // =gameState
	ldr r0, [r0, #0x18]
	cmp r0, #0
	bne _02156F28
	ldrh r0, [r7, #4]
	tst r0, #0x80
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
_02156F28:
	mov r0, #0x1500
	mov r2, #0
	str r0, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x384
	ldr r0, _02157080 // =StageTask_Main
	ldr r1, _02157084 // =GameObject__Destructor
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
	mov r2, #0x384
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	mvn r2, #3
	mov r0, r4
	str r2, [sp]
	sub r1, r2, #0x10
	sub r2, r2, #0x14
	mov r3, #0x14
	bl StageTask__SetHitbox
	ldr r1, [r4, #0x20]
	mov r0, #0xa
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x80
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x340]
	ldr r2, [r4, #0x44]
	ldrsb r1, [r1, #6]
	add r2, r2, r1, lsl #12
	str r2, [r4, #0x364]
	ldr r1, [r4, #0x340]
	ldrb r1, [r1, #8]
	add r1, r2, r1, lsl #12
	str r1, [r4, #0x36c]
	ldr r1, [r4, #0x340]
	ldrb r1, [r1, #9]
	mov r1, r1, lsl #0xc
	str r1, [r4, #0x374]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02157088 // =gameArchiveStage
	ldr r1, _0215708C // =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _02157090 // =_02188C24
	add r1, r4, #0x168
	ldr r2, [r2]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	mov r2, #0x2b
	bl ObjActionAllocSpritePalette
	mov r0, r4
	bl EnemyCrab__Action_Init
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215707C: .word gameState
_02157080: .word StageTask_Main
_02157084: .word GameObject__Destructor
_02157088: .word gameArchiveStage
_0215708C: .word 0x0000FFFF
_02157090: .word _02188C24
	arm_func_end EnemyCrab__Create

	arm_func_start EnemyCrab__Action_Init
EnemyCrab__Action_Init: // 0x02157094
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	mov r2, #0x87
	str r1, [sp]
	sub r1, r2, #0x88
	mov r4, r0
	str r2, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, r4
	mov r1, #0
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _021570EC // =EnemyCrab__State_21570F0
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021570EC: .word EnemyCrab__State_21570F0
	arm_func_end EnemyCrab__Action_Init

	arm_func_start EnemyCrab__State_21570F0
EnemyCrab__State_21570F0: // 0x021570F0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r0, [r4, #0x20]
	tst r0, #1
	mov r0, #0x3000
	rsbeq r0, r0, #0
	str r0, [r4, #0x98]
	ldr r0, [r4, #0x1c]
	bic r0, r0, #0x400
	str r0, [r4, #0x1c]
	tst r0, #4
	beq _02157158
	ldr r1, [r4, #0x44]
	mov r0, #0
	str r1, [r4, #0x378]
	str r0, [r4, #0x98]
	ldr r0, [r4, #0x20]
	eor r0, r0, #1
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x400
	str r0, [r4, #0x1c]
	b _02157214
_02157158:
	ldr r0, [r4, #0x364]
	ldr r1, [r4, #0x44]
	cmp r1, r0
	bge _02157188
	str r0, [r4, #0x44]
	str r0, [r4, #0x378]
	mov r0, #0
	str r0, [r4, #0x98]
	ldr r0, [r4, #0x20]
	eor r0, r0, #1
	str r0, [r4, #0x20]
	b _02157214
_02157188:
	ldr r0, [r4, #0x36c]
	cmp r1, r0
	ble _021571B4
	str r0, [r4, #0x44]
	str r0, [r4, #0x378]
	mov r0, #0
	str r0, [r4, #0x98]
	ldr r0, [r4, #0x20]
	eor r0, r0, #1
	str r0, [r4, #0x20]
	b _02157214
_021571B4:
	ldr r3, _0215724C // =_mt_math_rand
	ldr r0, _02157250 // =0x00196225
	ldr ip, [r3]
	ldr r1, _02157254 // =0x3C6EF35F
	ldr r2, _02157258 // =0x000007FF
	mla r1, ip, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	str r1, [r3]
	cmp r2, r0, lsr #16
	bls _02157214
	ldr r1, [r4, #0x44]
	ldr r0, [r4, #0x378]
	subs r2, r1, r0
	ldr r0, [r4, #0x374]
	rsbmi r2, r2, #0
	cmp r2, r0
	blt _02157214
	str r1, [r4, #0x378]
	mov r0, #0
	str r0, [r4, #0x98]
	ldr r0, [r4, #0x20]
	eor r0, r0, #1
	str r0, [r4, #0x20]
_02157214:
	ldr r0, [r4, #0x128]
	ldrh r0, [r0, #0xc]
	cmp r0, #1
	cmpne r0, #2
	cmpne r0, #3
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0x78
	ldmltia sp!, {r4, pc}
	mov r0, r4
	bl EnemyCrab__Action_Unknown
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215724C: .word _mt_math_rand
_02157250: .word 0x00196225
_02157254: .word 0x3C6EF35F
_02157258: .word 0x000007FF
	arm_func_end EnemyCrab__State_21570F0

	arm_func_start EnemyCrab__Action_Unknown
EnemyCrab__Action_Unknown: // 0x0215725C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #1
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x98]
	mov r1, #0
	str r0, [r4, #0x380]
	ldr r0, _02157288 // =EnemyCrab__State_215728C
	str r1, [r4, #0x98]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157288: .word EnemyCrab__State_215728C
	arm_func_end EnemyCrab__Action_Unknown

	arm_func_start EnemyCrab__State_215728C
EnemyCrab__State_215728C: // 0x0215728C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r0, [r4, #0x128]
	ldrh r1, [r0, #0xc]
	cmp r1, #1
	bne _02157308
	ldr r0, [r4, #0x20]
	tst r0, #8
	beq _02157308
	mov r0, r4
	mov r1, #2
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, #0x88
	orr r2, r1, #4
	str r2, [r4, #0x20]
	mov r2, #0
	str r2, [r4, #0x2c]
	str r2, [sp]
	sub r1, r0, #0x89
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02157308:
	cmp r1, #2
	bne _02157344
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	cmp r0, #0x78
	addlt sp, sp, #8
	str r0, [r4, #0x2c]
	ldmltia sp!, {r4, pc}
	mov r2, #0
	mov r0, r4
	mov r1, #3
	str r2, [r4, #0x2c]
	bl GameObject__SetAnimation
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02157344:
	cmp r1, #3
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x20]
	tst r0, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl EnemyCrab__Action_Init
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end EnemyCrab__State_215728C

	.data
	
_02188C24:
	.word aActAcEneCrabBa

aActAcEneCrabBa: // 0x02188C28
	.asciz "/act/ac_ene_crab.bac"
	.align 4