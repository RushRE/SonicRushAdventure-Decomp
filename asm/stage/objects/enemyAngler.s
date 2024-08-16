	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start EnemyAngler__Create
EnemyAngler__Create: // 0x021565D0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	movs r7, r0
	mov r6, r1
	mov r5, r2
	beq _021565FC
	ldrb r0, [r7]
	cmp r0, #0xff
	ldreqb r0, [r7, #1]
	cmpeq r0, #0xff
	beq _02156620
_021565FC:
	ldr r0, _02156840 // =gameState
	ldr r0, [r0, #0x18]
	cmp r0, #0
	bne _02156620
	ldrh r0, [r7, #4]
	tst r0, #0x80
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
_02156620:
	mov r0, #0x1500
	mov r2, #0
	str r0, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x3c8
	ldr r0, _02156844 // =StageTask_Main
	ldr r1, _02156848 // =GameObject__Destructor
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
	mov r2, #0x3c8
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldrh r0, [r7, #2]
	cmp r0, #6
	beq _021566AC
	cmp r0, #7
	beq _0215674C
	b _02156788
_021566AC:
	add r0, r4, #0x300
	mov r1, #0
	strh r1, [r0, #0xc4]
	ldr r0, [r4, #0x20]
	mov r5, #0x34
	orr r0, r0, #0x100
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x340]
	ldr r3, [r4, #0x44]
	ldrsb r2, [r0, #6]
	add r0, r4, #0x364
	sub r1, r5, #0xc4
	add ip, r3, r2, lsl #12
	str ip, [r4, #0x3b4]
	ldr r2, [r4, #0x340]
	sub r3, r5, #0x44
	ldrb r6, [r2, #8]
	sub r2, r5, #0x80
	add r6, ip, r6, lsl #12
	str r6, [r4, #0x3bc]
	str r5, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x364
	bl ObjRect__SetAttackStat
	ldr r1, _0215684C // =0x0000FFFE
	add r0, r4, #0x364
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _02156850 // =0x00000102
	add r0, r4, #0x300
	strh r1, [r0, #0x98]
	ldr r1, [r4, #0x37c]
	ldr r0, _02156854 // =ovl00_2156C3C
	orr r1, r1, #0xc0
	str r1, [r4, #0x37c]
	str r0, [r4, #0x388]
	str r4, [r4, #0x380]
	b _02156788
_0215674C:
	add r0, r4, #0x300
	mov r1, #1
	strh r1, [r0, #0xc4]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x100
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x340]
	ldr r1, [r4, #0x44]
	ldrsb r0, [r0, #6]
	add r1, r1, r0, lsl #12
	str r1, [r4, #0x3b4]
	ldr r0, [r4, #0x340]
	ldrb r0, [r0, #8]
	add r0, r1, r0, lsl #12
	str r0, [r4, #0x3bc]
_02156788:
	mov r0, #9
	bl GetObjectFileWork
	ldr r1, _02156858 // =gameArchiveStage
	ldr r2, _0215685C // =0x0000FFFF
	ldr r3, [r1]
	ldr r1, _02156860 // =_02188C08
	str r3, [sp]
	str r2, [sp, #4]
	mov r3, r0
	ldr r2, [r1]
	mov r0, r4
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	ldrh r0, [r7, #2]
	cmp r0, #6
	beq _021567EC
	cmp r0, #7
	beq _02156800
	b _02156810
_021567EC:
	mov r0, r4
	mov r1, #0
	mov r2, #0x29
	bl ObjActionAllocSpritePalette
	b _02156810
_02156800:
	mov r0, r4
	mov r1, #7
	mov r2, #0x2a
	bl ObjActionAllocSpritePalette
_02156810:
	ldrh r0, [r7, #4]
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	mov r0, r4
	bl ovl00_21569A4
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02156840: .word gameState
_02156844: .word StageTask_Main
_02156848: .word GameObject__Destructor
_0215684C: .word 0x0000FFFE
_02156850: .word 0x00000102
_02156854: .word ovl00_2156C3C
_02156858: .word gameArchiveStage
_0215685C: .word 0x0000FFFF
_02156860: .word _02188C08
	arm_func_end EnemyAngler__Create

	arm_func_start EnemyAnglerShot__Create
EnemyAnglerShot__Create: // 0x02156864
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _0215698C // =StageTask_Main
	ldr r1, _02156990 // =GameObject__Destructor
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
	ldr r1, [r4, #0x20]
	mov r0, #9
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x50
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02156994 // =gameArchiveStage
	ldr r1, _02156998 // =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _0215699C // =_02188C08
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
	mov r2, #0x29
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #3
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _021569A0 // =ovl00_2156E48
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215698C: .word StageTask_Main
_02156990: .word GameObject__Destructor
_02156994: .word gameArchiveStage
_02156998: .word 0x0000FFFF
_0215699C: .word _02188C08
_021569A0: .word ovl00_2156E48
	arm_func_end EnemyAnglerShot__Create

	arm_func_start ovl00_21569A4
ovl00_21569A4: // 0x021569A4
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, _021569CC // =ovl00_21569D0
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021569CC: .word ovl00_21569D0
	arm_func_end ovl00_21569A4

	arm_func_start ovl00_21569D0
ovl00_21569D0: // 0x021569D0
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, [r5, #0x138]
	add r1, r5, #0x44
	mov r4, #0
	bl ProcessSpatialSfx
	ldr r1, [r5, #0x354]
	tst r1, #1
	beq _02156A40
	ldr r0, [r5, #0x20]
	tst r0, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	bic r0, r1, #1
	str r0, [r5, #0x354]
	ldr r1, [r5, #0x20]
	mov r0, r5
	eor r1, r1, #1
	str r1, [r5, #0x20]
	mov r1, r4
	bl GameObject__SetAnimation
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	ldr r0, [r5, #0x37c]
	orr r0, r0, #4
	str r0, [r5, #0x37c]
_02156A40:
	ldr r0, [r5, #0x28]
	add r0, r0, #1
	str r0, [r5, #0x28]
	cmp r0, #0x78
	blo _02156A68
	ldr r1, [r5, #0x37c]
	mov r0, #0
	orr r1, r1, #4
	str r1, [r5, #0x37c]
	str r0, [r5, #0x28]
_02156A68:
	mov r0, r5
	add r1, r5, #0x364
	bl StageTask__HandleCollider
	add r0, r5, #0x300
	ldrh r0, [r0, #0xc4]
	cmp r0, #1
	bne _02156B7C
	ldr r0, [r5, #0x128]
	ldrh r1, [r0, #0xc]
	cmp r1, #4
	cmpne r1, #5
	cmpne r1, #6
	beq _02156AC0
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #0x78
	blt _02156B7C
	mov r0, r5
	mov r1, #4
	bl GameObject__SetAnimation
	b _02156B7C
_02156AC0:
	cmp r1, #4
	bne _02156B1C
	ldr r0, [r5, #0x20]
	tst r0, #8
	beq _02156B1C
	mov r0, r5
	mov r1, #5
	bl GameObject__SetAnimation
	ldr r1, [r5, #0x20]
	mov r0, #0x85
	orr r2, r1, #4
	sub r1, r0, #0x86
	str r2, [r5, #0x20]
	mov r2, #0xb4
	str r2, [r5, #0x2c]
	mov r2, #0
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r5, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _02156B7C
_02156B1C:
	cmp r1, #5
	bne _02156B50
	ldr r0, [r5, #0x2c]
	sub r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #0
	bgt _02156B7C
	mov r2, #0
	mov r0, r5
	mov r1, #6
	str r2, [r5, #0x2c]
	bl GameObject__SetAnimation
	b _02156B7C
_02156B50:
	cmp r1, #6
	bne _02156B7C
	ldr r0, [r5, #0x20]
	tst r0, #8
	beq _02156B7C
	mov r0, r5
	mov r1, #0
	bl GameObject__SetAnimation
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
_02156B7C:
	ldr r0, [r5, #0x20]
	tst r0, #1
	mov r0, #0xc00
	rsbeq r0, r0, #0
	str r0, [r5, #0x98]
	ldr r0, [r5, #0x3b4]
	ldr r1, [r5, #0x44]
	cmp r1, r0
	strlt r0, [r5, #0x44]
	movlt r4, #1
	blt _02156BB8
	ldr r0, [r5, #0x3bc]
	cmp r1, r0
	strgt r0, [r5, #0x44]
	movgt r4, #1
_02156BB8:
	cmp r4, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x128]
	ldrh r0, [r0, #0xc]
	cmp r0, #5
	bne _02156BF0
	mov r0, r5
	mov r1, #6
	bl GameObject__SetAnimation
	mov r0, #0
	add sp, sp, #8
	str r0, [r5, #0x98]
	ldmia sp!, {r3, r4, r5, pc}
_02156BF0:
	cmp r0, #6
	bne _02156C08
	ldr r0, [r5, #0x20]
	tst r0, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
_02156C08:
	mov r0, r5
	mov r1, #1
	bl GameObject__SetAnimation
	ldr r1, [r5, #0x37c]
	mov r0, #0
	bic r1, r1, #4
	str r1, [r5, #0x37c]
	str r0, [r5, #0x98]
	ldr r0, [r5, #0x354]
	orr r0, r0, #1
	str r0, [r5, #0x354]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl00_21569D0

	arm_func_start ovl00_2156C3C
ovl00_2156C3C: // 0x02156C3C
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	mov r5, r0
	ldr r0, [r4, #0x98]
	mov r1, #0
	str r0, [r4, #0x3ac]
	mov r0, r4
	str r1, [r4, #0x98]
	mov r1, #2
	strb r1, [r4, #0x3b0]
	bl GameObject__SetAnimation
	ldr r0, _02156C8C // =ovl00_2156C90
	str r0, [r4, #0xf4]
	ldr r0, [r5, #0x1c]
	ldr r0, [r0, #0x44]
	str r0, [r4, #0x3a4]
	ldr r0, [r5, #0x1c]
	ldr r0, [r0, #0x48]
	str r0, [r4, #0x3a8]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02156C8C: .word ovl00_2156C90
	arm_func_end ovl00_2156C3C

	arm_func_start ovl00_2156C90
ovl00_2156C90: // 0x02156C90
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r5, r0
	ldr r1, [r5, #0x128]
	ldrh r0, [r1, #0xc]
	cmp r0, #2
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, pc}
	ldrh r0, [r1, #0xe]
	cmp r0, #0xa
	ldreqb r0, [r5, #0x3b0]
	cmpeq r0, #2
	beq _02156CD0
	ldr r0, [r5, #0x20]
	tst r0, #8
	beq _02156DEC
_02156CD0:
	ldr r0, [r5, #0x20]
	mov r3, #0
	tst r0, #1
	ldr r0, [r5, #0x44]
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	str r3, [sp, #0x10]
	addne r1, r0, #0x11000
	ldr r2, [r5, #0x48]
	subeq r1, r0, #0x11000
	ldr r0, _02156E34 // =0x00000153
	sub r2, r2, #0x14000
	bl GameObject__SpawnObject
	ldrb r1, [r5, #0x3b0]
	mov r4, r0
	cmp r1, #2
	bne _02156D4C
	mov r1, #0
	mov r0, #0x86
	str r1, [sp]
	sub r1, r0, #0x87
	str r0, [sp, #4]
	ldr r0, [r5, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r5, #0x138]
	add r1, r5, #0x44
	bl ProcessSpatialSfx
_02156D4C:
	ldrb r1, [r5, #0x3b0]
	mov r0, #0
	sub r1, r1, #1
	strb r1, [r5, #0x3b0]
	str r0, [r4, #0x9c]
	str r0, [r4, #0x98]
	str r0, [r4, #0xc8]
	ldr r3, [r5, #0x3a8]
	ldr r0, [r4, #0x48]
	ldr r2, [r5, #0x3a4]
	ldr r1, [r4, #0x44]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	strh r0, [r4, #0x34]
	ldr r0, [r5, #0x20]
	ldrh r1, [r4, #0x34]
	tst r0, #1
	beq _02156DC8
	ldr r0, _02156E38 // =0x0000D555
	cmp r1, r0
	bge _02156DB0
	cmp r1, #0x8000
	strgth r0, [r4, #0x34]
	bgt _02156DE4
_02156DB0:
	ldr r0, _02156E3C // =0x00002AAA
	cmp r1, r0
	ble _02156DE4
	cmp r1, #0x8000
	strleh r0, [r4, #0x34]
	b _02156DE4
_02156DC8:
	ldr r0, _02156E40 // =0x0000AAAA
	cmp r1, r0
	strgth r0, [r4, #0x34]
	bgt _02156DE4
	cmp r1, r0, lsr #1
	movlt r0, r0, lsr #1
	strlth r0, [r4, #0x34]
_02156DE4:
	mov r0, #0x3000
	str r0, [r4, #0xc8]
_02156DEC:
	ldr r0, [r5, #0x20]
	tst r0, #8
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, _02156E44 // =ovl00_2156E78
	mov r1, #0
	str r0, [r5, #0xf4]
	mov r0, r5
	str r1, [r5, #0x28]
	bl GameObject__SetAnimation
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	ldr r0, [r5, #0x37c]
	bic r0, r0, #4
	str r0, [r5, #0x37c]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02156E34: .word 0x00000153
_02156E38: .word 0x0000D555
_02156E3C: .word 0x00002AAA
_02156E40: .word 0x0000AAAA
_02156E44: .word ovl00_2156E78
	arm_func_end ovl00_2156C90

	arm_func_start ovl00_2156E48
ovl00_2156E48: // 0x02156E48
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x1c]
	tst r1, #0xf
	ldmeqia sp!, {r3, pc}
	ldr r2, [r0, #0x18]
	mov r1, #0
	orr ip, r2, #4
	mov r2, r1
	mov r3, #1
	str ip, [r0, #0x18]
	bl CreateEffectExplosion
	ldmia sp!, {r3, pc}
	arm_func_end ovl00_2156E48

	arm_func_start ovl00_2156E78
ovl00_2156E78: // 0x02156E78
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x2c]
	add r1, r1, #1
	str r1, [r4, #0x2c]
	cmp r1, #0x1e
	blt _02156EA8
	bl ovl00_21569A4
	mov r0, #2
	strb r0, [r4, #0x3b0]
	mov r0, #0
	str r0, [r4, #0x2c]
_02156EA8:
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x2c]
	cmp r0, #0x78
	ldmltia sp!, {r4, pc}
	ldr r1, [r4, #0x37c]
	mov r0, #0
	orr r1, r1, #4
	str r1, [r4, #0x37c]
	str r0, [r4, #0x28]
	ldmia sp!, {r4, pc}
	arm_func_end ovl00_2156E78

	.data
	
_02188C08:
	.word aActAcEneAngler

aActAcEneAngler: // 0x02188C0C
	.asciz "/act/ac_ene_angler.bac"
	.align 4