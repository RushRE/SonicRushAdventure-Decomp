	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start FireFloor__Create
FireFloor__Create: // 0x021822BC
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
	ldr r0, _02182430 // =StageTask_Main
	ldr r1, _02182434 // =GameObject__Destructor
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
	mov r0, #0x9f
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02182438 // =gameArchiveStage
	ldr r1, _0218243C // =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _02182440 // =aActAcGmkFirefl
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x53
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	ldrh r0, [r7, #2]
	add r0, r0, #0xf20
	add r0, r0, #0xf000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	mov r0, r4
	bhi _021823EC
	mov r1, #0
	bl StageTask__SetAnimation
	ldrh r0, [r7, #2]
	cmp r0, #0xe1
	bne _02182408
	ldr r0, [r4, #0x20]
	orr r0, r0, #2
	str r0, [r4, #0x20]
	b _02182408
_021823EC:
	mov r1, #3
	bl StageTask__SetAnimation
	ldrh r0, [r7, #2]
	cmp r0, #0xe2
	ldreq r0, [r4, #0x20]
	orreq r0, r0, #1
	streq r0, [r4, #0x20]
_02182408:
	ldr r1, [r4, #0x20]
	ldr r0, _02182444 // =ovl00_218263C
	orr r1, r1, #4
	str r1, [r4, #0x20]
	ldr r1, _02182448 // =ovl00_218244C
	str r0, [r4, #0x278]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02182430: .word StageTask_Main
_02182434: .word GameObject__Destructor
_02182438: .word gameArchiveStage
_0218243C: .word 0x0000FFFF
_02182440: .word aActAcGmkFirefl
_02182444: .word ovl00_218263C
_02182448: .word ovl00_218244C
	arm_func_end FireFloor__Create

	arm_func_start ovl00_218244C
ovl00_218244C: // 0x0218244C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x20]
	tst r1, #8
	beq _02182498
	ldr r1, [r4, #0x128]
	ldrh r1, [r1, #0xc]
	cmp r1, #1
	bne _0218247C
	mov r1, #0
	bl StageTask__SetAnimation
	b _0218248C
_0218247C:
	cmp r1, #4
	bne _0218248C
	mov r1, #3
	bl StageTask__SetAnimation
_0218248C:
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
_02182498:
	ldr r0, _02182624 // =gPlayer
	ldr r1, [r4, #0x340]
	ldr lr, [r0]
	ldrh r1, [r1, #2]
	ldrb r2, [lr, #0x5d0]
	mov r0, #0
	cmp r2, #1
	beq _021824C4
	ldr r2, [lr, #0x5d8]
	tst r2, #0x80
	beq _021824CC
_021824C4:
	mov r2, #1
	b _021824D0
_021824CC:
	mov r2, r0
_021824D0:
	cmp r2, #0
	beq _02182510
	ldr ip, [r4, #0x44]
	ldr r3, [lr, #0x44]
	sub r2, ip, #0x40000
	cmp r2, r3
	addle r2, ip, #0x40000
	cmple r3, r2
	bgt _02182510
	ldr ip, [r4, #0x48]
	ldr r3, [lr, #0x48]
	sub r2, ip, #0x40000
	cmp r2, r3
	addle r2, ip, #0x40000
	cmple r3, r2
	movle r0, #1
_02182510:
	add r1, r1, #0xf20
	add r1, r1, #0xf000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r1, #1
	addls r1, r4, #0x3c
	addhi r1, r4, #0x38
	cmp r0, #0
	beq _021825A0
	ldr r0, [r4, #0x128]
	ldrh r0, [r0, #0xc]
	cmp r0, #0
	cmpne r0, #3
	bne _021825A0
	ldr r0, [r1]
	cmp r0, #0x400
	ble _02182568
	sub r0, r0, #0x200
	str r0, [r1]
	cmp r0, #0x400
	movlt r0, #0x400
	strlt r0, [r1]
_02182568:
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x258
	bl ObjRect__SetAttackStat
	ldr r1, _02182628 // =0x0000FFFE
	add r0, r4, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _0218262C // =ovl00_2182690
	str r0, [r4, #0x27c]
	ldr r0, [r4, #0x270]
	orr r0, r0, #0x400
	str r0, [r4, #0x270]
	b _021825F8
_021825A0:
	ldr r0, [r1]
	cmp r0, #0x1000
	bge _021825C0
	add r0, r0, #0x200
	str r0, [r1]
	cmp r0, #0x1000
	movgt r0, #0x1000
	strgt r0, [r1]
_021825C0:
	add r0, r4, #0x200
	mov r1, #2
	strh r1, [r0, #0x88]
	mov r2, #0x40
	ldr r1, _02182630 // =0x0000FFFF
	strh r2, [r0, #0x84]
	strh r1, [r0, #0x8a]
	mov r2, #0xff
	ldr r1, _02182634 // =ovl00_218263C
	strh r2, [r0, #0x86]
	str r1, [r4, #0x27c]
	ldr r0, [r4, #0x270]
	bic r0, r0, #0x400
	str r0, [r4, #0x270]
_021825F8:
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	subs r0, r0, #1
	str r0, [r4, #0x2c]
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0x270]
	ldr r0, _02182638 // =0xFFFBFCFF
	and r0, r1, r0
	str r0, [r4, #0x270]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02182624: .word gPlayer
_02182628: .word 0x0000FFFE
_0218262C: .word ovl00_2182690
_02182630: .word 0x0000FFFF
_02182634: .word ovl00_218263C
_02182638: .word 0xFFFBFCFF
	arm_func_end ovl00_218244C

	arm_func_start ovl00_218263C
ovl00_218263C: // 0x0218263C
	stmdb sp!, {r3, lr}
	ldr r0, [r0, #0x1c]
	ldr r1, [r1, #0x1c]
	cmp r0, #0
	cmpne r1, #0
	ldmeqia sp!, {r3, pc}
	ldrh r1, [r1]
	cmp r1, #1
	ldmneia sp!, {r3, pc}
	ldr r1, [r0, #0x128]
	ldrh r1, [r1, #0xc]
	cmp r1, #0
	bne _0218267C
	mov r1, #1
	bl StageTask__SetAnimation
	ldmia sp!, {r3, pc}
_0218267C:
	cmp r1, #3
	ldmneia sp!, {r3, pc}
	mov r1, #4
	bl StageTask__SetAnimation
	ldmia sp!, {r3, pc}
	arm_func_end ovl00_218263C

	arm_func_start ovl00_2182690
ovl00_2182690: // 0x02182690
	stmdb sp!, {r3, lr}
	ldr ip, [r1, #0x1c]
	ldr r3, [r0, #0x1c]
	cmp ip, #0
	cmpne r3, #0
	ldmeqia sp!, {r3, pc}
	ldrh r2, [r3]
	cmp r2, #1
	ldmneia sp!, {r3, pc}
	ldr r2, [r3, #0xbc]
	cmp r2, #0
	ldreq r2, [r3, #0xc0]
	cmpeq r2, #0
	movne r0, #5
	strne r0, [ip, #0x2c]
	ldmneia sp!, {r3, pc}
	bl ObjRect__FuncNoHit
	ldmia sp!, {r3, pc}
	arm_func_end ovl00_2182690

	.data
	
aActAcGmkFirefl: // 0x02189C60
	.asciz "/act/ac_gmk_firefloor.bac"
	.align 4