	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start PirateShip__Create
PirateShip__Create: // 0x0217A018
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
	mov r4, #0x378
	ldr r0, _0217A1A4 // =StageTask_Main
	ldr r1, _0217A1A8 // =GameObject__Destructor
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
	mov r2, #0x378
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xa2
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x20
	str r1, [r4, #0x20]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0217A1AC // =gameArchiveStage
	mov r1, #0x77
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _0217A1B0 // =aActAcGmkPirate_0
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x57
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #3
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	str r4, [r4, #0x234]
	mov r1, #0
	str r1, [sp]
	add r0, r4, #0x218
	sub r2, r1, #0x200
	mov r3, #0x40
	bl ObjRect__SetBox2D
	add r0, r4, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, _0217A1B4 // =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _0217A1B8 // =PirateShip__OnDefend_217A7E0
	mov r0, #0x64
	str r1, [r4, #0x23c]
	ldr r1, [r4, #0x230]
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x44]
	sub r1, r1, #0x20000
	str r1, [r4, #0x368]
	ldr r3, [r4, #0x44]
	ldrb r2, [r7, #8]
	ldrsb r1, [r7, #7]
	mla r0, r1, r0, r2
	add r0, r3, r0, lsl #12
	add r0, r0, #0x20000
	str r0, [r4, #0x36c]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0217A1A4: .word StageTask_Main
_0217A1A8: .word GameObject__Destructor
_0217A1AC: .word gameArchiveStage
_0217A1B0: .word aActAcGmkPirate_0
_0217A1B4: .word 0x0000FFFE
_0217A1B8: .word PirateShip__OnDefend_217A7E0
	arm_func_end PirateShip__Create

	arm_func_start PirateShipCannonBall__Create
PirateShipCannonBall__Create: // 0x0217A1BC
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
	ldr r0, _0217A340 // =StageTask_Main
	ldr r1, _0217A344 // =GameObject__Destructor
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
	ldr r1, [r4, #0x1c]
	mov r0, #0xa2
	orr r1, r1, #0x780
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0217A348 // =gameArchiveStage
	mov r1, #0
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _0217A34C // =aActAcGmkPirate_0
	bl ObjObjectAction2dBACLoad
	mov r0, #0xa3
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #8
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, #2
	mov r2, #0x53
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimation
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0x41
	bl ObjRect__SetDefenceStat
	ldr r0, _0217A350 // =PirateShipCannonBall__OnHit
	mov r1, #0xd
	str r0, [r4, #0x278]
	ldr r2, [r4, #0x270]
	mov r0, r4
	orr r2, r2, #0x20
	str r2, [r4, #0x270]
	str r1, [sp]
	sub r1, r1, #0x11
	mov r2, #7
	mov r3, #4
	bl StageTask__SetHitbox
	ldr r1, [r4, #0x1c]
	mov r0, #0x40000
	orr r1, r1, #0x100
	str r1, [r4, #0x1c]
	str r0, [r4, #0x4c]
	mov r0, #0x200
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	ldr r1, _0217A354 // =PirateShipCannonBall__State_217A90C
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0217A340: .word StageTask_Main
_0217A344: .word GameObject__Destructor
_0217A348: .word gameArchiveStage
_0217A34C: .word aActAcGmkPirate_0
_0217A350: .word PirateShipCannonBall__OnHit
_0217A354: .word PirateShipCannonBall__State_217A90C
	arm_func_end PirateShipCannonBall__Create

	arm_func_start PirateShip__State_217A358
PirateShip__State_217A358: // 0x0217A358
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x35c]
	mov r0, r4
	bl PirateShip__GetPlayerVelocity
	movs r5, r0
	ldr r1, [r4, #0x44]
	ldr r0, [r6, #0x368]
	movmi r5, #0
	cmp r1, r0
	blt _0217A390
	ldr r0, [r6, #0x36c]
	cmp r1, r0
	ble _0217A3A8
_0217A390:
	ldr r1, [r6, #0x370]
	ldr r0, _0217A434 // =PirateShip__State_217A714
	add r1, r1, r5
	str r1, [r6, #0x370]
	str r0, [r6, #0xf4]
	ldmia sp!, {r4, r5, r6, pc}
_0217A3A8:
	ldrb r2, [r4, #0x5d3]
	mov r0, #0x70
	ldr r1, _0217A438 // =mapCamera+0x00000004
	smulbb r0, r2, r0
	ldr r0, [r1, r0]
	ldr r1, [r6, #0x44]
	add r0, r0, #0xfe0
	add r0, r0, #0x7f000
	cmp r1, r0
	blt _0217A408
	mov r0, r4
	bl PirateShip__GetPlayerVelocity
	ldr r2, [r6, #0x370]
	mov r1, #0
	add r0, r2, r0
	str r0, [r6, #0x98]
	ldr r0, _0217A43C // =playerGameStatus
	str r1, [r6, #0x2c]
	ldr r1, [r0, #0xc]
	ldr r0, _0217A440 // =PirateShip__State_217A444
	and r1, r1, #0xf
	str r1, [r6, #0x28]
	str r0, [r6, #0xf4]
	ldmia sp!, {r4, r5, r6, pc}
_0217A408:
	ldr r0, [r6, #0x370]
	mov r1, #0x100
	bl ObjSpdDownSet
	str r0, [r6, #0x370]
	cmp r0, #0x2000
	movlt r0, #0x2000
	strlt r0, [r6, #0x370]
	ldr r0, [r6, #0x370]
	add r0, r5, r0
	str r0, [r6, #0x98]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0217A434: .word PirateShip__State_217A714
_0217A438: .word mapCamera+0x00000004
_0217A43C: .word playerGameStatus
_0217A440: .word PirateShip__State_217A444
	arm_func_end PirateShip__State_217A358

	arm_func_start PirateShip__State_217A444
PirateShip__State_217A444: // 0x0217A444
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x14
	mov r9, r0
	ldr r4, [r9, #0x35c]
	mov r0, r4
	bl PirateShip__GetPlayerVelocity
	ldr r2, [r4, #0x44]
	ldr r1, [r9, #0x368]
	mov r5, r0
	cmp r2, r1
	blt _0217A47C
	ldr r0, [r9, #0x36c]
	cmp r2, r0
	ble _0217A498
_0217A47C:
	ldr r1, [r9, #0x370]
	ldr r0, _0217A6F8 // =PirateShip__State_217A714
	add r1, r1, r5
	str r1, [r9, #0x370]
	add sp, sp, #0x14
	str r0, [r9, #0xf4]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_0217A498:
	ldrb r2, [r4, #0x5d3]
	mov r1, #0x70
	ldr r0, _0217A6FC // =mapCamera+0x00000004
	smulbb r2, r2, r1
	ldr r0, [r0, r2]
	ldr r3, [r9, #0x44]
	add r2, r0, #0x80000
	add r0, r2, #0x20000
	cmp r0, r3
	bge _0217A4E4
	ldr r0, [r9, #0x370]
	sub r1, r1, #0x1f0
	mov r2, #0x2800
	bl ObjSpdUpSet
	str r0, [r9, #0x370]
	ldr r0, [r9, #0x354]
	orr r0, r0, #1
	str r0, [r9, #0x354]
	b _0217A5CC
_0217A4E4:
	sub r0, r2, #0x20000
	cmp r0, r3
	ble _0217A514
	ldr r0, [r9, #0x370]
	mov r1, #0x180
	mov r2, #0x2800
	bl ObjSpdUpSet
	str r0, [r9, #0x370]
	ldr r0, [r9, #0x354]
	bic r0, r0, #1
	str r0, [r9, #0x354]
	b _0217A5CC
_0217A514:
	ldr r0, [r9, #0x354]
	ands r0, r0, #1
	bne _0217A560
	cmp r2, r3
	bge _0217A560
	ldr r0, [r9, #0x370]
	mov r1, #0x180
	cmp r0, #0
	blt _0217A550
	bl ObjSpdDownSet
	str r0, [r9, #0x370]
	cmp r0, #0x1800
	movlt r0, #0x1800
	strlt r0, [r9, #0x370]
	b _0217A5CC
_0217A550:
	mov r2, #0x2800
	bl ObjSpdUpSet
	str r0, [r9, #0x370]
	b _0217A5CC
_0217A560:
	cmp r0, #0
	beq _0217A5B0
	cmp r2, r3
	ble _0217A5B0
	ldr r0, [r9, #0x370]
	mov r1, #0x180
	cmp r0, #0
	bge _0217A59C
	bl ObjSpdDownSet
	mov r1, #0x1800
	rsb r1, r1, #0
	str r0, [r9, #0x370]
	cmp r0, r1
	strgt r1, [r9, #0x370]
	b _0217A5CC
_0217A59C:
	rsb r1, r1, #0
	mov r2, #0x2800
	bl ObjSpdUpSet
	str r0, [r9, #0x370]
	b _0217A5CC
_0217A5B0:
	cmp r0, #0
	mov r1, #0x180
	ldr r0, [r9, #0x370]
	subne r1, r1, #0x300
	mov r2, #0x2800
	bl ObjSpdUpSet
	str r0, [r9, #0x370]
_0217A5CC:
	ldr r0, [r9, #0x370]
	add r0, r5, r0
	str r0, [r9, #0x98]
	ldr r0, [r9, #0x2c]
	sub r0, r0, #1
	cmp r0, #0
	addgt sp, sp, #0x14
	str r0, [r9, #0x2c]
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [r9, #0x28]
	ldr r1, _0217A700 // =_02189904
	mov r0, r0, lsl #0x1d
	mov r2, r0, lsr #0x1b
	ldr r0, _0217A704 // =0x02189906
	ldrsh r7, [r1, r2]
	ldrsh r6, [r0, r2]
	mov r3, #0
	ldr r0, _0217A708 // =0x00000147
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	str r3, [sp, #0x10]
	ldr r1, [r9, #0x44]
	ldr r2, [r9, #0x48]
	add r1, r1, r7, lsl #12
	add r2, r2, r6, lsl #12
	mov r7, r7, lsl #0xc
	mov r8, r6, lsl #0xc
	bl GameObject__SpawnObject
	movs r6, r0
	beq _0217A6A0
	mov r0, #0x8800
	str r5, [r6, #0x98]
	rsb r0, r0, #0
	str r0, [r6, #0x9c]
	ldr r0, [r9, #0x44]
	ldr r1, [r4, #0x44]
	add r0, r0, r7
	cmp r5, #0
	sub r0, r1, r0
	beq _0217A68C
	ldr r2, [r9, #0x28]
	ldr r1, _0217A70C // =0x02189944
	mov r2, r2, lsl #0x1c
	mov r2, r2, lsr #0x1b
	ldrsh r1, [r1, r2]
	add r0, r0, r1, lsl #12
_0217A68C:
	mov r1, #0x6a
	bl FX_DivS32
	ldr r1, [r6, #0x98]
	add r0, r1, r0
	str r0, [r6, #0x98]
_0217A6A0:
	mov r0, r9
	mov r1, r7
	mov r2, r8
	bl PirateShipCannonBlast__Create
	mov r4, #0x71
	sub r1, r4, #0x72
	mov r0, #0
	stmia sp, {r0, r4}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r1, [r9, #0x28]
	ldr r0, _0217A710 // =0x02189924
	mov r1, r1, lsl #1
	ldrsh r0, [r0, r1]
	str r0, [r9, #0x2c]
	ldr r0, [r9, #0x28]
	add r0, r0, #1
	and r0, r0, #0xf
	str r0, [r9, #0x28]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0217A6F8: .word PirateShip__State_217A714
_0217A6FC: .word mapCamera+0x00000004
_0217A700: .word _02189904
_0217A704: .word 0x02189906
_0217A708: .word 0x00000147
_0217A70C: .word 0x02189944
_0217A710: .word 0x02189924
	arm_func_end PirateShip__State_217A444

	arm_func_start PirateShip__State_217A714
PirateShip__State_217A714: // 0x0217A714
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r5, [r4, #0x35c]
	ldr r1, [r4, #0x368]
	ldr r2, [r5, #0x44]
	cmp r2, r1
	blt _0217A74C
	ldr r1, [r4, #0x36c]
	cmp r2, r1
	bgt _0217A74C
	ldr r1, _0217A7D8 // =PirateShip__State_217A358
	str r1, [r4, #0xf4]
	bl PirateShip__State_217A358
	ldmia sp!, {r3, r4, r5, pc}
_0217A74C:
	ldr r0, [r4, #0x370]
	mov r1, #0x200
	mov r2, #0x11000
	bl ObjSpdUpSet
	str r0, [r4, #0x370]
	str r0, [r4, #0x98]
	ldrb r2, [r5, #0x5d3]
	mov r0, #0x70
	ldr r1, _0217A7DC // =mapCamera+0x00000004
	smulbb r0, r2, r0
	ldr r1, [r1, r0]
	ldr r0, [r4, #0x44]
	add r1, r1, #0x160000
	cmp r1, r0
	ldmgeia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x18]
	mov r1, #0
	bic r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x20
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x2000
	str r0, [r4, #0x1c]
	str r4, [r4, #0x234]
	ldr r0, [r4, #0x230]
	bic r0, r0, #0x800
	str r0, [r4, #0x230]
	str r1, [r4, #0x98]
	ldr r0, [r4, #0x364]
	str r0, [r4, #0x8c]
	str r0, [r4, #0x44]
	str r1, [r4, #0xf4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217A7D8: .word PirateShip__State_217A358
_0217A7DC: .word mapCamera+0x00000004
	arm_func_end PirateShip__State_217A714

	arm_func_start PirateShip__OnDefend_217A7E0
PirateShip__OnDefend_217A7E0: // 0x0217A7E0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r1
	mov r7, r0
	ldr r4, [r6, #0x1c]
	ldr r5, [r7, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, r5
	bl PirateShip__GetPlayerVelocity
	cmp r0, #0
	bge _0217A82C
	mov r0, r7
	mov r1, r6
	bl ObjRect__FuncNoHit
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0217A82C:
	ldr r1, [r4, #0x18]
	add r3, r0, #0x6000
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x20]
	mov r2, #0
	bic r0, r1, #0x20
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x1c]
	mov r1, #0x6000
	bic r0, r0, #0x2000
	str r0, [r4, #0x1c]
	ldr ip, [r4, #0x354]
	mov r0, #0x70
	bic ip, ip, #1
	str ip, [r4, #0x354]
	str r2, [r4, #0x234]
	ldr ip, [r4, #0x230]
	ldr r2, _0217A8B8 // =mapCamera+0x00000004
	orr ip, ip, #0x800
	str ip, [r4, #0x230]
	str r5, [r4, #0x35c]
	str r3, [r4, #0x98]
	str r1, [r4, #0x370]
	ldr r3, [r4, #0x44]
	ldr r1, _0217A8BC // =PirateShip__State_217A358
	str r3, [r4, #0x364]
	ldrb r3, [r5, #0x5d3]
	smulbb r0, r3, r0
	ldr r0, [r2, r0]
	sub r0, r0, #0x60000
	str r0, [r4, #0x44]
	str r0, [r4, #0x8c]
	str r1, [r4, #0xf4]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0217A8B8: .word mapCamera+0x00000004
_0217A8BC: .word PirateShip__State_217A358
	arm_func_end PirateShip__OnDefend_217A7E0

	arm_func_start PirateShip__GetPlayerVelocity
PirateShip__GetPlayerVelocity: // 0x0217A8C0
	ldr r1, [r0, #0x1c]
	tst r1, #0x8000
	ldrne r0, [r0, #0x98]
	bxne lr
	ldrh r2, [r0, #0x34]
	ldr r1, _0217A908 // =FX_SinCosTable_
	ldr r3, [r0, #0xc8]
	mov r0, r2, asr #4
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrsh r0, [r1, r0]
	smull r1, r0, r3, r0
	adds r2, r1, #0x800
	adc r1, r0, #0
	mov r0, r2, lsr #0xc
	orr r0, r0, r1, lsl #20
	bx lr
	.align 2, 0
_0217A908: .word FX_SinCosTable_
	arm_func_end PirateShip__GetPlayerVelocity

	arm_func_start PirateShipCannonBall__State_217A90C
PirateShipCannonBall__State_217A90C: // 0x0217A90C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x4c]
	mov r1, #0
	subs r0, r0, #0xe00
	str r0, [r4, #0x4c]
	movmi r0, #0
	strmi r0, [r4, #0x4c]
	ldr r2, [r4, #0x4c]
	mov r0, #0x38
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r2, ip, #0x800
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	rsb r0, r1, #0x1000
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	ldr r0, [r4, #0x9c]
	cmp r0, #0
	ldrgt r0, [r4, #0x1c]
	bicgt r0, r0, #0x100
	strgt r0, [r4, #0x1c]
	ldr r0, [r4, #0x1c]
	tst r0, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0
	mov r2, #0xe000
	bl CreateEffectGroundExplosion
	ldr r0, [r4, #0x18]
	mov ip, #0x72
	sub r1, ip, #0x73
	orr r0, r0, #4
	str r0, [r4, #0x18]
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end PirateShipCannonBall__State_217A90C

	arm_func_start PirateShipCannonBall__OnHit
PirateShipCannonBall__OnHit: // 0x0217A9C8
	stmdb sp!, {r4, lr}
	ldr r4, [r0, #0x1c]
	ldr r0, [r1, #0x1c]
	cmp r4, #0
	cmpne r0, #0
	ldmeqia sp!, {r4, pc}
	ldrh r0, [r0, #0]
	cmp r0, #1
	ldmneia sp!, {r4, pc}
	mov r1, #0
	mov r0, r4
	mov r2, r1
	mov r3, #2
	bl CreateEffectExplosion
	ldr r0, [r4, #0x18]
	orr r0, r0, #8
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	arm_func_end PirateShipCannonBall__OnHit

	.data
	
_02189904:
	.byte 0x00, 0x00, 0xD7, 0xFF, 0xDB, 0xFF, 0xDE, 0xFF, 0xEB, 0xFF, 0xDA, 0xFF
	.byte 0x27, 0x00, 0xDE, 0xFF, 0x00, 0x00, 0xD7, 0xFF, 0xDB, 0xFF, 0xDE, 0xFF, 0x16, 0x00, 0xD9, 0xFF
	.byte 0x27, 0x00, 0xDE, 0xFF, 0x19, 0x00, 0x0F, 0x00, 0x14, 0x00, 0x0F, 0x00, 0x19, 0x00, 0x05, 0x00
	.byte 0x0A, 0x00, 0x14, 0x00, 0x05, 0x00, 0x0F, 0x00, 0x19, 0x00, 0x14, 0x00, 0x0A, 0x00, 0x19, 0x00
	.byte 0x14, 0x00, 0x0F, 0x00, 0x38, 0x00, 0xA8, 0xFF, 0x6C, 0x00, 0xC8, 0xFF, 0x48, 0x00, 0xB4, 0xFF
	.byte 0x40, 0x00, 0xC0, 0xFF, 0x50, 0x00, 0xB0, 0xFF, 0x60, 0x00, 0xB8, 0xFF, 0x30, 0x00, 0xC4, 0xFF
	.byte 0x58, 0x00, 0xD0, 0xFF

aActAcGmkPirate_0: // 0x02189964
	.asciz "/act/ac_gmk_pirate_ship.bac"
	.align 4