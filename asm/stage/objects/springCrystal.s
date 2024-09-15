	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start SpringCrystal__Create
SpringCrystal__Create: // 0x0216CEE4
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
	ldr r0, _0216D1B4 // =StageTask_Main
	ldr r1, _0216D1B8 // =GameObject__Destructor
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
	mov r0, #0xac
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0216D1BC // =gameArchiveStage
	ldr r1, _0216D1C0 // =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _0216D1C4 // =aActAcGmkSprgCr
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x30
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	ldrh r0, [r7, #2]
	sub r0, r0, #0xa2
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0216CFF4
_0216CFE4: // jump table
	b _0216D000 // case 0
	b _0216CFF4 // case 1
	b _0216D098 // case 2
	b _0216D08C // case 3
_0216CFF4:
	ldr r0, [r4, #0x20]
	orr r0, r0, #2
	str r0, [r4, #0x20]
_0216D000:
	mov r5, #0
	mov r3, r5
	str r5, [r4, #0x28]
	sub r6, r5, #0x18
	add r0, r4, #0x218
	sub r1, r5, #0x32
	sub r2, r5, #0x40
	str r6, [sp]
	bl ObjRect__SetBox2D
	mov r1, r5
	mvn r6, #0x17
	add r0, r4, #0x258
	sub r2, r1, #0x40
	mov r3, #0x32
	str r6, [sp]
	bl ObjRect__SetBox2D
	mov r0, #0xc8
	bl GetObjectFileWork
	ldr r3, _0216D1BC // =gameArchiveStage
	mov r2, r0
	ldr r1, _0216D1C8 // =aDfGmkSprgCryst
	ldr r3, [r3]
	mov r0, r4
	bl ObjObjectCollisionDifSet
	mov r1, #0x60
	add r0, r4, #0x300
	strh r1, [r0, #8]
	mov r1, #0x40
	strh r1, [r0, #0xa]
	sub r2, r1, #0x70
	add r0, r4, #0x200
	sub r1, r1, #0x80
	strh r2, [r0, #0xf0]
	strh r1, [r0, #0xf2]
	b _0216D120
_0216D08C:
	ldr r0, [r4, #0x20]
	orr r0, r0, #1
	str r0, [r4, #0x20]
_0216D098:
	mov r6, #0
	mov r5, #2
	str r5, [r4, #0x28]
	add r0, r4, #0x218
	sub r1, r6, #0x40
	sub r2, r6, #0x32
	sub r3, r6, #0x18
	str r6, [sp]
	bl ObjRect__SetBox2D
	mov r6, #0x32
	mov r2, #0
	add r0, r4, #0x258
	sub r1, r6, #0x72
	sub r3, r2, #0x18
	str r6, [sp]
	bl ObjRect__SetBox2D
	mov r0, #0xc9
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	ldr r1, _0216D1CC // =aDfGmkSprgCryst_0
	ldr r3, _0216D1BC // =gameArchiveStage
	ldr r3, [r3]
	bl ObjObjectCollisionDifSet
	mov r1, #0x40
	add r0, r4, #0x300
	strh r1, [r0, #8]
	mov r1, #0x60
	strh r1, [r0, #0xa]
	sub r2, r1, #0xa0
	sub r1, r1, #0x90
	add r0, r4, #0x200
	strh r2, [r0, #0xf0]
	strh r1, [r0, #0xf2]
_0216D120:
	mov r0, r4
	mov r1, r5
	bl StageTask__SetAnimation
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	str r4, [r4, #0x234]
	bl ObjRect__SetAttackStat
	ldr r1, _0216D1D0 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _0216D1D4 // =SpringCrystal__OnDefend_216D27C
	mov r1, #0
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	mov r2, r1
	orr r0, r0, #0x400
	str r0, [r4, #0x230]
	add r0, r4, #0x258
	str r4, [r4, #0x274]
	bl ObjRect__SetAttackStat
	ldr r1, _0216D1D0 // =0x0000FFFE
	add r0, r4, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _0216D1D8 // =SpringCrystal__OnDefend_216D28C
	ldr r1, _0216D1DC // =SpringCrystal__Draw
	str r0, [r4, #0x27c]
	ldr r2, [r4, #0x270]
	mov r0, r4
	orr r2, r2, #0x400
	str r2, [r4, #0x270]
	str r4, [r4, #0x2d8]
	str r1, [r4, #0xfc]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216D1B4: .word StageTask_Main
_0216D1B8: .word GameObject__Destructor
_0216D1BC: .word gameArchiveStage
_0216D1C0: .word 0x0000FFFF
_0216D1C4: .word aActAcGmkSprgCr
_0216D1C8: .word aDfGmkSprgCryst
_0216D1CC: .word aDfGmkSprgCryst_0
_0216D1D0: .word 0x0000FFFE
_0216D1D4: .word SpringCrystal__OnDefend_216D27C
_0216D1D8: .word SpringCrystal__OnDefend_216D28C
_0216D1DC: .word SpringCrystal__Draw
	arm_func_end SpringCrystal__Create

	arm_func_start SpringCrystal__State_216D1E0
SpringCrystal__State_216D1E0: // 0x0216D1E0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x20]
	tst r1, #8
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x28]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r1, [r4, #0x230]
	mov r0, #0
	bic r1, r1, #0x100
	str r1, [r4, #0x230]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	arm_func_end SpringCrystal__State_216D1E0

	arm_func_start SpringCrystal__Draw
SpringCrystal__Draw: // 0x0216D21C
	stmdb sp!, {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x340]
	ldr r1, [r4, #0x20]
	ldrh r0, [r0, #2]
	orr r1, r1, #0x10
	add r0, r0, #0x5e
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	orrls r5, r1, #1
	orrhi r5, r1, #2
	ldr r1, [r4, #0x128]
	mov r0, r4
	bl StageTask__Draw2D
	ldr r6, [r4, #0x20]
	mov r0, r4
	str r5, [r4, #0x20]
	ldr r1, [r4, #0x128]
	bl StageTask__Draw2D
	str r6, [r4, #0x20]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SpringCrystal__Draw

	arm_func_start SpringCrystal__OnDefend_216D27C
SpringCrystal__OnDefend_216D27C: // 0x0216D27C
	ldr ip, _0216D288 // =SpringCrystal__OnDefend_216D29C
	mov r2, #0
	bx ip
	.align 2, 0
_0216D288: .word SpringCrystal__OnDefend_216D29C
	arm_func_end SpringCrystal__OnDefend_216D27C

	arm_func_start SpringCrystal__OnDefend_216D28C
SpringCrystal__OnDefend_216D28C: // 0x0216D28C
	ldr ip, _0216D298 // =SpringCrystal__OnDefend_216D29C
	mov r2, #1
	bx ip
	.align 2, 0
_0216D298: .word SpringCrystal__OnDefend_216D29C
	arm_func_end SpringCrystal__OnDefend_216D28C

	arm_func_start SpringCrystal__OnDefend_216D29C
SpringCrystal__OnDefend_216D29C: // 0x0216D29C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x50
	ldr r4, [r1, #0x1c]
	str r1, [sp, #0xc]
	str r2, [sp, #0x10]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	str r0, [sp, #8]
	cmpne r5, #0
	addeq sp, sp, #0x50
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r0, [r5]
	cmp r0, #1
	addne sp, sp, #0x50
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r4, #0x340]
	ldr r8, [r5, #0x44]
	ldrh r2, [r0, #2]
	ldr r0, [r5, #0x48]
	ldr r9, [r4, #0x44]
	cmp r2, #0xa2
	ldr r10, [r4, #0x48]
	beq _0216D3FC
	cmp r2, #0xa3
	mov r1, #0
	beq _0216D318
	cmp r2, #0xa4
	beq _0216D344
	cmp r2, #0xa5
	beq _0216D36C
	b _0216D390
_0216D318:
	mov r2, #0x1a000
	str r1, [sp, #0x14]
	mov r1, r2
	mov r11, #0x2a000
	sub r1, r1, #0x34000
	str r1, [sp, #0x18]
	str r2, [sp, #0x1c]
	mov r6, r11
	mov r1, #0x8000
	mov r7, #1
	b _0216D390
_0216D344:
	mov r1, #0x4000
	sub r2, r1, #0x2e000
	mov r6, #0x1a000
	str r2, [sp, #0x18]
	str r2, [sp, #0x1c]
	mov r2, #1
	sub r11, r6, #0x34000
	str r2, [sp, #0x14]
	mov r7, #3
	b _0216D390
_0216D36C:
	mov r2, #0x2a000
	mov r6, #0x1a000
	str r1, [sp, #0x14]
	mov r1, r2
	str r1, [sp, #0x1c]
	str r2, [sp, #0x18]
	sub r11, r6, #0x34000
	mov r1, #0xc000
	mov r7, #2
_0216D390:
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	sub r2, r8, r9
	mov r8, r1, lsl #1
	sub r0, r0, r10
	str r0, [sp, #0x24]
	mov r0, #0
	str r0, [sp, #0x28]
	add r1, r1, #1
	str r2, [sp, #0x20]
	ldr r3, _0216D594 // =FX_SinCosTable_
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r8]
	ldrsh r2, [r3, r2]
	add r0, sp, #0x2c
	blx MTX_RotZ33_
	add r0, sp, #0x20
	add r1, sp, #0x2c
	mov r2, r0
	bl MTX_MultVec33
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x24]
	add r8, r1, r9
	add r0, r0, r10
	b _0216D420
_0216D3FC:
	mov r1, #0x1a000
	sub r11, r1, #0x44000
	str r1, [sp, #0x1c]
	sub r1, r1, #0x34000
	str r1, [sp, #0x18]
	mov r1, #2
	mov r6, r11
	str r1, [sp, #0x14]
	mov r7, #3
_0216D420:
	sub r1, r10, #0x40000
	cmp r0, r1
	movle r1, #0x14000
	ble _0216D460
	sub r1, r10, #0x18000
	cmp r0, r1
	movge r1, #0x46000
	bge _0216D460
	sub r0, r10, r0
	sub r0, r0, #0x18000
	rsb r1, r0, #0x28000
	mov r0, #0x32
	mul r0, r1, r0
	mov r1, #0x28000
	bl FX_Div
	add r1, r0, #0x14000
_0216D460:
	cmp r9, r8
	blt _0216D488
	sub r0, r9, r8
	cmp r0, r1
	ble _0216D4A8
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	bl ObjRect__FuncNoHit
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0216D488:
	sub r0, r8, r9
	cmp r0, r1
	ble _0216D4A8
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	bl ObjRect__FuncNoHit
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0216D4A8:
	ldr r1, [r4, #0x28]
	mov r0, r4
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r3, [r4, #0x340]
	ldr r1, _0216D598 // =_021894D8
	ldrh r2, [r3, #2]
	ldr r0, _0216D59C // =0x021894DC
	ldrsb r3, [r3, #6]
	sub r8, r2, #0xa2
	add r2, r1, r8, lsl #4
	add r1, r0, r8, lsl #4
	ldr r0, [sp, #0x10]
	ldr r8, [r2, r0, lsl #3]
	ldr r2, [r1, r0, lsl #3]
	cmp r8, #0
	addge r1, r8, r3, lsl #11
	sublt r1, r8, r3, lsl #11
	cmp r2, #0
	addge r2, r2, r3, lsl #11
	sublt r2, r2, r3, lsl #11
	mov r0, r5
	bl Player__Func_2021204
	mov r0, r5
	mov r1, r4
	bl Player__Action_AllowTrickCombos
	ldr r0, [sp, #0x14]
	str r6, [sp]
	str r0, [sp, #4]
	ldr r3, [sp, #0x1c]
	mov r0, r4
	mov r1, #0x10
	mov r2, #2
	bl EffectTruckSparkles__Create
	str r11, [sp]
	ldr r3, [sp, #0x18]
	mov r0, r4
	mov r1, #0x10
	mov r2, #2
	str r7, [sp, #4]
	bl EffectTruckSparkles__Create
	ldr r1, _0216D5A0 // =SpringCrystal__State_216D1E0
	mov r0, #0
	str r1, [r4, #0xf4]
	mov r1, #0x5d
	mov r2, r0
	bl NNS_SndPlayerStopSeqBySeqArcIdx
	mov r0, #0
	str r0, [sp]
	mov r1, #0x5d
	str r1, [sp, #4]
	sub r1, r1, #0x5e
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216D594: .word FX_SinCosTable_
_0216D598: .word _021894D8
_0216D59C: .word 0x021894DC
_0216D5A0: .word SpringCrystal__State_216D1E0
	arm_func_end SpringCrystal__OnDefend_216D29C

	.data
	
_021894D8:
	.byte 0x80, 0xB5, 0xFF, 0xFF, 0x80, 0xB5, 0xFF, 0xFF
	.byte 0x80, 0x4A, 0x00, 0x00, 0x80, 0xB5, 0xFF, 0xFF, 0x80, 0xB5, 0xFF, 0xFF, 0x80, 0x4A, 0x00, 0x00
	.byte 0x80, 0x4A, 0x00, 0x00, 0x80, 0x4A, 0x00, 0x00, 0x80, 0xB5, 0xFF, 0xFF, 0x80, 0xB5, 0xFF, 0xFF
	.byte 0x80, 0xB5, 0xFF, 0xFF, 0x80, 0x4A, 0x00, 0x00, 0x80, 0x4A, 0x00, 0x00, 0x80, 0xB5, 0xFF, 0xFF
	.byte 0x80, 0x4A, 0x00, 0x00, 0x80, 0x4A, 0x00, 0x00

aActAcGmkSprgCr: // 0x02189518
	.asciz "/act/ac_gmk_sprg_crystal.bac"
	.align 4
	
aDfGmkSprgCryst: // 0x02189538
	.asciz "/df/gmk_sprg_crystal_v.df"
	.align 4
	
aDfGmkSprgCryst_0: // 0x02189554
	.asciz "/df/gmk_sprg_crystal_h.df"
	.align 4