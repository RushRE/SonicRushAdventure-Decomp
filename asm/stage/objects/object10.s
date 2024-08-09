	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Object10__Create
Object10__Create: // 0x0215B9B0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	movs r7, r0
	mov r6, r1
	mov r5, r2
	beq _0215B9DC
	ldrb r0, [r7]
	cmp r0, #0xff
	ldreqb r0, [r7, #1]
	cmpeq r0, #0xff
	beq _0215BA00
_0215B9DC:
	ldr r0, _0215BB28 // =gameState
	ldr r0, [r0, #0x18]
	cmp r0, #0
	bne _0215BA00
	ldrh r0, [r7, #4]
	tst r0, #0x80
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
_0215BA00:
	mov r0, #0x1500
	mov r2, #0
	str r0, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _0215BB2C // =StageTask_Main
	ldr r1, _0215BB30 // =GameObject__Destructor
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
	mov r0, #0x16
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0215BB34 // =gameArchiveStage
	ldr r1, _0215BB38 // =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _0215BB3C // =aActAcEneSkullF
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	mov r2, #0x72
	bl ObjActionAllocSpritePalette
	ldr r1, [r4, #0x1c]
	add r0, r4, #0x258
	orr r1, r1, #0x100
	str r1, [r4, #0x1c]
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x258
	ldr r1, _0215BB40 // =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _0215BB44 // =ovl00_215C33C
	mov r0, r4
	str r1, [r4, #0x27c]
	ldr r1, [r4, #0x270]
	orr r1, r1, #0x400
	str r1, [r4, #0x270]
	bl ovl00_215BB48
	bl AllocSndHandle
	str r0, [r4, #0x138]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215BB28: .word gameState
_0215BB2C: .word StageTask_Main
_0215BB30: .word GameObject__Destructor
_0215BB34: .word gameArchiveStage
_0215BB38: .word 0x0000FFFF
_0215BB3C: .word aActAcEneSkullF
_0215BB40: .word 0x0000FFFE
_0215BB44: .word ovl00_215C33C
	arm_func_end Object10__Create

	arm_func_start ovl00_215BB48
ovl00_215BB48: // 0x0215BB48
	stmdb sp!, {r4, lr}
	ldr r1, _0215BBF8 // =gPlayer
	mov r4, r0
	ldr r1, [r1]
	ldr r1, [r1, #0x5d8]
	tst r1, #0x400
	beq _0215BB74
	bl ovl00_215BE2C
	mvn r0, #0x80000000
	str r0, [r4, #0x2c]
	ldmia sp!, {r4, pc}
_0215BB74:
	add r1, r4, #0x100
	ldrh r1, [r1, #0x74]
	cmp r1, #0
	beq _0215BB8C
	mov r1, #0
	bl GameObject__SetAnimation
_0215BB8C:
	ldr r1, [r4, #0x20]
	ldr r0, _0215BBFC // =ovl00_215BC00
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	mov r0, #0x79
	str r0, [r4, #0x2c]
	ldr r0, _0215BBF8 // =gPlayer
	ldr r3, [r4, #0x48]
	ldr r2, [r0]
	ldr r1, [r4, #0x44]
	ldr r0, [r2, #0x48]
	ldr r2, [r2, #0x44]
	sub r0, r0, r3
	sub r1, r2, r1
	bl FX_Atan2Idx
	str r0, [r4, #0x28]
	mov r0, #0
	str r0, [r4, #0x98]
	str r0, [r4, #0x9c]
	str r0, [r4, #0xc8]
	ldr r1, [r4, #0x24]
	mov r0, r4
	sub r1, r1, #1
	str r1, [r4, #0x24]
	bl ovl00_215BC00
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215BBF8: .word gPlayer
_0215BBFC: .word ovl00_215BC00
	arm_func_end ovl00_215BB48

	arm_func_start ovl00_215BC00
ovl00_215BC00: // 0x0215BC00
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r2, [r5, #0x24]
	ldr r1, _0215BE24 // =gPlayer
	add r2, r2, #1
	str r2, [r5, #0x24]
	ldr r1, [r1]
	ldr r1, [r1, #0x5d8]
	tst r1, #0x400
	beq _0215BC38
	bl ovl00_215BE2C
	mvn r0, #0x80000000
	str r0, [r5, #0x2c]
	ldmia sp!, {r4, r5, r6, pc}
_0215BC38:
	ldr r0, [r5, #0x2c]
	mov r1, #0x400
	sub r0, r0, #1
	str r0, [r5, #0x2c]
	ldr r0, [r5, #0xc8]
	mov r2, #0x3000
	bl ObjSpdUpSet
	str r0, [r5, #0xc8]
	ldr r0, _0215BE24 // =gPlayer
	ldr r1, [r5, #0x44]
	ldr r2, [r0]
	ldr r0, [r5, #0x48]
	ldr r3, [r2, #0x44]
	ldr r2, [r2, #0x48]
	sub r4, r3, r1
	mov r1, r4
	sub r0, r2, r0
	bl FX_Atan2Idx
	ldr r2, [r5, #0x28]
	mov r1, r0
	mov r0, r2, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r2, #0x1000
	bl ObjRoopMove16
	mov r1, r0, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	str r0, [r5, #0x28]
	add r1, r1, #1
	mov r0, r1, lsl #1
	ldr r2, _0215BE28 // =FX_SinCosTable_
	ldr r3, [r5, #0xc8]
	ldrsh r0, [r2, r0]
	mov r1, #0
	mov ip, #0x300
	smull r6, r0, r3, r0
	adds r3, r6, #0x800
	adc r0, r0, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r0, lsl #20
	str r3, [r5, #0x98]
	ldr r3, [r5, #0x28]
	ldr r0, [r5, #0xc8]
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, asr #4
	mov r3, r3, lsl #2
	ldrsh r3, [r2, r3]
	smull r6, r3, r0, r3
	adds r0, r6, #0x800
	adc r3, r3, #0
	mov r0, r0, lsr #0xc
	orr r0, r0, r3, lsl #20
	str r0, [r5, #0x9c]
	ldr r3, [r5, #0x24]
	mov r3, r3, lsl #0x1a
	mov r3, r3, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, asr #4
	mov r3, r3, lsl #2
	ldrsh r3, [r2, r3]
	umull r6, lr, r3, ip
	mla lr, r3, r1, lr
	mov r2, r3, asr #0x1f
	adds r3, r6, #0x800
	mla lr, r2, ip, lr
	adc r2, lr, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r0, r0, r3
	str r0, [r5, #0x9c]
	ldr r0, [r5, #0x354]
	tst r0, #1
	beq _0215BDC8
	ldr r0, [r5, #0x98]
	mov r0, r0, asr #1
	str r0, [r5, #0x98]
	ldr r0, [r5, #0x20]
	tst r0, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r2, [r5, #0x354]
	mov r0, r5
	bic r2, r2, #1
	str r2, [r5, #0x354]
	ldr r2, [r5, #0x20]
	eor r2, r2, #1
	str r2, [r5, #0x20]
	bl GameObject__SetAnimation
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	ldmia sp!, {r4, r5, r6, pc}
_0215BDC8:
	cmp r4, #0
	bge _0215BDDC
	ldr r0, [r5, #0x20]
	tst r0, #1
	bne _0215BDF0
_0215BDDC:
	cmp r4, #0
	ble _0215BE0C
	ldr r0, [r5, #0x20]
	tst r0, #1
	bne _0215BE0C
_0215BDF0:
	ldr r1, [r5, #0x354]
	mov r0, r5
	orr r2, r1, #1
	mov r1, #1
	str r2, [r5, #0x354]
	bl GameObject__SetAnimation
	ldmia sp!, {r4, r5, r6, pc}
_0215BE0C:
	ldr r0, [r5, #0x2c]
	cmp r0, #0
	ldmgtia sp!, {r4, r5, r6, pc}
	mov r0, r5
	bl ovl00_215BE2C
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215BE24: .word gPlayer
_0215BE28: .word FX_SinCosTable_
	arm_func_end ovl00_215BC00

	arm_func_start ovl00_215BE2C
ovl00_215BE2C: // 0x0215BE2C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x100
	ldrh r1, [r1, #0x74]
	cmp r1, #0
	beq _0215BE4C
	mov r1, #0
	bl GameObject__SetAnimation
_0215BE4C:
	ldr r1, [r4, #0x20]
	ldr r0, _0215BE6C // =ovl00_215BE70
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	mov r0, #0x1e
	str r0, [r4, #0x2c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215BE6C: .word ovl00_215BE70
	arm_func_end ovl00_215BE2C

	arm_func_start ovl00_215BE70
ovl00_215BE70: // 0x0215BE70
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x24]
	mov r1, #0x400
	add r0, r0, #1
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x98]
	bl ObjSpdDownSet
	str r0, [r4, #0x98]
	ldr r0, [r4, #0x9c]
	mov r1, #0x400
	bl ObjSpdDownSet
	str r0, [r4, #0x9c]
	ldr r1, [r4, #0x24]
	ldr r2, _0215BF24 // =FX_SinCosTable_
	mov r1, r1, lsl #0x1a
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r3, [r2, r1]
	mov r1, #0x300
	mov r2, #0
	umull lr, ip, r3, r1
	mla ip, r3, r2, ip
	mov r2, r3, asr #0x1f
	mla ip, r2, r1, ip
	adds lr, lr, #0x800
	adc r1, ip, #0
	mov r2, lr, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r0, r0, r2
	str r0, [r4, #0x9c]
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	ldmgtia sp!, {r4, pc}
	mov r0, r4
	bl ovl00_215BB48
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215BF24: .word FX_SinCosTable_
	arm_func_end ovl00_215BE70

	arm_func_start ovl00_215BF28
ovl00_215BF28: // 0x0215BF28
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #2
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r2, r1, #4
	mov r1, #1
	str r2, [r4, #0x20]
	bl StageTask__SetAnimatorPriority
	ldr r1, _0215BFBC // =ovl00_215BFC4
	ldr r0, _0215BFC0 // =gPlayer
	str r1, [r4, #0xf4]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x2000
	str r1, [r4, #0x1c]
	ldr r1, [r0]
	ldr r2, [r4, #0x44]
	ldr r1, [r1, #0x44]
	sub r1, r2, r1
	str r1, [r4, #0x98]
	ldr r0, [r0]
	ldr r1, [r4, #0x48]
	ldr r0, [r0, #0x48]
	sub r0, r1, r0
	str r0, [r4, #0x9c]
	ldr r0, [r4, #0x98]
	cmp r0, #0
	ldr r0, [r4, #0x20]
	bicge r0, r0, #1
	orrlt r0, r0, #1
	str r0, [r4, #0x20]
	mov r0, #0x12c
	str r0, [r4, #0x2c]
	mov r0, #0
	str r0, [r4, #0x28]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215BFBC: .word ovl00_215BFC4
_0215BFC0: .word gPlayer
	arm_func_end ovl00_215BF28

	arm_func_start ovl00_215BFC4
ovl00_215BFC4: // 0x0215BFC4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0x24]
	ldr r1, _0215C144 // =gPlayer
	add r2, r2, #1
	str r2, [r4, #0x24]
	ldr r2, [r1]
	ldr r1, [r2, #0x5d8]
	tst r1, #0x400
	beq _0215C014
	ldr r1, [r4, #0x1c]
	bic r1, r1, #0x2000
	str r1, [r4, #0x1c]
	bl ovl00_215BE2C
	mvn r0, #0x80000000
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x138]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	ldmia sp!, {r4, pc}
_0215C014:
	mov r0, r2
	bl Player__ApplyVelocityShift
	add r0, r4, #0x44
	add r3, r4, #0x8c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, _0215C144 // =gPlayer
	ldr r1, [r4, #0x98]
	ldr r2, [r0]
	ldr r2, [r2, #0x44]
	add r1, r2, r1
	str r1, [r4, #0x44]
	ldr r2, [r0]
	ldr r1, [r4, #0x9c]
	ldr r2, [r2, #0x48]
	add r1, r2, r1
	str r1, [r4, #0x48]
	ldr r1, [r4, #0x2c]
	sub r1, r1, #1
	str r1, [r4, #0x2c]
	cmp r1, #0
	bgt _0215C090
	ldr r1, [r4, #0x1c]
	mov r0, r4
	bic r1, r1, #0x2000
	str r1, [r4, #0x1c]
	bl ovl00_215C148
	ldr r0, [r4, #0x138]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	b _0215C100
_0215C090:
	ldr r0, [r0]
	ldr r0, [r0, #0x20]
	ands r1, r0, #1
	bne _0215C0AC
	ldr r0, [r4, #0x354]
	tst r0, #2
	bne _0215C0C0
_0215C0AC:
	cmp r1, #0
	beq _0215C0CC
	ldr r0, [r4, #0x354]
	tst r0, #2
	bne _0215C0CC
_0215C0C0:
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
_0215C0CC:
	ldr r0, [r4, #0x28]
	cmp r0, #0xa
	bhs _0215C0EC
	ldr r0, _0215C144 // =gPlayer
	ldr r0, [r0]
	ldr r0, [r0, #0x5d8]
	tst r0, #0x80
	beq _0215C100
_0215C0EC:
	ldr r1, [r4, #0x1c]
	mov r0, r4
	bic r1, r1, #0x2000
	str r1, [r4, #0x1c]
	bl ovl00_215C2E8
_0215C100:
	ldr r0, _0215C144 // =gPlayer
	ldr r0, [r0]
	ldr r0, [r0, #0x20]
	tst r0, #1
	ldr r0, [r4, #0x354]
	orrne r0, r0, #2
	biceq r0, r0, #2
	str r0, [r4, #0x354]
	ldr r1, [r4, #0x44]
	ldr r0, [r4, #0x8c]
	sub r0, r1, r0
	str r0, [r4, #0xbc]
	ldr r1, [r4, #0x48]
	ldr r0, [r4, #0x90]
	sub r0, r1, r0
	str r0, [r4, #0xc0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C144: .word gPlayer
	arm_func_end ovl00_215BFC4

	arm_func_start ovl00_215C148
ovl00_215C148: // 0x0215C148
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x100
	ldrh r1, [r1, #0x74]
	cmp r1, #0
	beq _0215C168
	mov r1, #0
	bl GameObject__SetAnimation
_0215C168:
	ldr r1, [r4, #0x20]
	ldr r0, _0215C1D8 // =ovl00_215C1E0
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	mov r1, #0x78
	ldr r0, _0215C1DC // =playerGameStatus
	str r1, [r4, #0x2c]
	ldr r0, [r0, #0xc]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x13
	add r0, r0, #0xc000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x20]
	tst r0, #1
	bne _0215C1C4
	ldr r0, [r4, #0x28]
	sub r0, r0, #0x4000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [r4, #0x28]
_0215C1C4:
	mov r0, #0
	str r0, [r4, #0x98]
	str r0, [r4, #0x9c]
	str r0, [r4, #0xc8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C1D8: .word ovl00_215C1E0
_0215C1DC: .word playerGameStatus
	arm_func_end ovl00_215C148

	arm_func_start ovl00_215C1E0
ovl00_215C1E0: // 0x0215C1E0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x24]
	mov r1, #0x400
	add r0, r0, #1
	str r0, [r4, #0x24]
	ldr r0, [r4, #0xc8]
	mov r2, #0x3000
	bl ObjSpdUpSet
	str r0, [r4, #0xc8]
	ldr r2, [r4, #0x28]
	ldr r1, _0215C2E4 // =FX_SinCosTable_
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r2, [r1, r2]
	mov ip, #0
	smull r3, r2, r0, r2
	adds r3, r3, #0x800
	adc r0, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [r4, #0x98]
	ldr r0, [r4, #0x28]
	ldr r2, [r4, #0xc8]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r0, [r1, r0]
	mov r3, #0x300
	smull lr, r0, r2, r0
	adds lr, lr, #0x800
	adc r2, r0, #0
	mov r0, lr, lsr #0xc
	orr r0, r0, r2, lsl #20
	str r0, [r4, #0x9c]
	ldr r2, [r4, #0x24]
	mov r2, r2, lsl #0x1a
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r1, [r1, r2]
	umull lr, r2, r1, r3
	mla r2, r1, ip, r2
	mov r1, r1, asr #0x1f
	mla r2, r1, r3, r2
	adds lr, lr, #0x800
	adc r1, r2, #0
	mov r2, lr, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r0, r0, r2
	str r0, [r4, #0x9c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C2E4: .word FX_SinCosTable_
	arm_func_end ovl00_215C1E0

	arm_func_start ovl00_215C2E8
ovl00_215C2E8: // 0x0215C2E8
	stmdb sp!, {r4, lr}
	mov r1, #3
	mov r4, r0
	bl GameObject__SetAnimation
	ldr r1, _0215C320 // =ovl00_215C324
	mov r0, #0
	str r1, [r4, #0xf4]
	str r0, [r4, #0x98]
	sub r0, r0, #0x1000
	str r0, [r4, #0x9c]
	ldr r0, [r4, #0x354]
	orr r0, r0, #0x10000
	str r0, [r4, #0x354]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C320: .word ovl00_215C324
	arm_func_end ovl00_215C2E8

	arm_func_start ovl00_215C324
ovl00_215C324: // 0x0215C324
	ldr r1, [r0, #0x20]
	tst r1, #8
	ldrne r1, [r0, #0x18]
	orrne r1, r1, #4
	strne r1, [r0, #0x18]
	bx lr
	arm_func_end ovl00_215C324

	arm_func_start ovl00_215C33C
ovl00_215C33C: // 0x0215C33C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	ldr r2, [r4, #0x18]
	tst r2, #2
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldrh r2, [r5]
	cmp r2, #1
	ldreqb r2, [r5, #0x5d1]
	cmpeq r2, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	add r2, r5, #0x700
	ldrsh r2, [r2, #4]
	cmp r2, #3
	blt _0215C390
	bl ObjRect__FuncNoHit
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_0215C390:
	ldr r0, [r4, #0x230]
	mov r2, #0
	orr r0, r0, #0x800
	str r0, [r4, #0x230]
	str r2, [r4, #0x234]
	ldr r1, [r4, #0x270]
	mov r0, r4
	orr r1, r1, #0x800
	str r1, [r4, #0x270]
	str r2, [r4, #0x274]
	bl ovl00_215BF28
	mov r0, r5
	bl Player__ApplyVelocityShift
	mov r2, #0
	mov r0, #0x8b
	sub r1, r0, #0x8c
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl00_215C33C

	.data

aActAcEneSkullF: // 0x02188D84
	.asciz "/act/ac_ene_skull_fire.bac"
	.align 4