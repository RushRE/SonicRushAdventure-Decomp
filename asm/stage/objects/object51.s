	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Object51__Create
Object51__Create: // 0x0216BE64
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x14
	mov r3, #0x1800
	mov fp, r0
	mov r6, r1
	mov r4, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r5, _0216C2B4 // =0x00000ADC
	ldr r0, _0216C2B8 // =StageTask_Main
	ldr r1, _0216C2BC // =Stalactite__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r5, r0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r0, r5
	bl GetTaskWork_
	ldr r2, _0216C2B4 // =0x00000ADC
	mov r5, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r5
	mov r1, fp
	mov r2, r6
	mov r3, r4
	bl GameObject__InitFromObject
	add r0, r5, #0x254
	mov r1, #0x20
	str r1, [r5, #0xad8]
	add r2, r0, #0x400
	mov r1, #0
_0216BF00:
	add r0, r5, r1, lsl #2
	add r1, r1, #1
	str r2, [r0, #0xa54]
	cmp r1, #0x20
	add r2, r2, #0x20
	blt _0216BF00
	ldr r1, [r5, #0x1c]
	mov r0, #0x9f
	orr r1, r1, #0x2100
	str r1, [r5, #0x1c]
	bl GetObjectFileWork
	ldr r1, _0216C2C0 // =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, _0216C2C4 // =aActAcGmkStalac
	mov r0, r5
	str r1, [sp]
	mov r4, #0
	add r1, r5, #0x168
	str r4, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, #0xa0
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r5
	mov r1, #0x34
	bl ObjObjectActionAllocSprite
	mov r0, #0xa0
	bl GetObjectFileWork
	ldrh r0, [r0, #4]
	bic r0, r0, #0x8000
	cmp r0, #1
	ble _0216BF94
	ldr r1, [r5, #0x128]
	ldr r0, [r1, #0x3c]
	orr r0, r0, #8
	str r0, [r1, #0x3c]
_0216BF94:
	ldrh r0, [fp, #2]
	cmp r0, #0xa0
	mov r0, r5
	bne _0216BFB4
	mov r1, #0
	mov r2, #5
	bl ObjActionAllocSpritePalette
	b _0216BFC0
_0216BFB4:
	mov r1, #7
	mov r2, #0x2d
	bl ObjActionAllocSpritePalette
_0216BFC0:
	mov r0, r5
	mov r1, #0
	bl StageTask__SetAnimation
	mov r0, r5
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r5
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, #0x9f
	add r4, r5, #0x368
	bl GetObjectFileWork
	ldr r1, _0216C2C0 // =gameArchiveStage
	mov r3, r0
	ldr r2, [r1]
	ldr r1, _0216C2C4 // =aActAcGmkStalac
	str r2, [sp]
	mov r0, r4
	mov r2, #0x38
	bl ObjAction2dBACLoad
	ldr r1, [r5, #0x128]
	mov r0, r4
	ldrh r2, [r1, #0x50]
	mov r1, #1
	strh r2, [r4, #0x50]
	strh r2, [r4, #0x92]
	strh r2, [r4, #0x90]
	ldr r2, [r4, #0x3c]
	orr r2, r2, #0x10
	str r2, [r4, #0x3c]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetOAMPriority
	mov r0, #0xa4
	mov r7, #0x10
	bl GetObjectFileWork
	ldrh r0, [r0, #4]
	bics r0, r0, #0x8000
	mov r0, #0x9f
	orrne r7, r7, #8
	bl GetObjectFileWork
	add r1, r5, #0x68
	mov r6, r0
	add r8, r1, #0x400
	mov sl, #0
	mov sb, #0xa4
_0216C088:
	ldr r0, _0216C2C0 // =gameArchiveStage
	mov r2, #0
	ldr r1, [r0]
	mov r0, r8
	str r1, [sp]
	ldr r1, _0216C2C4 // =aActAcGmkStalac
	mov r3, r6
	bl ObjAction2dBACLoad
	add r1, sl, #4
	mov r1, r1, lsl #0x10
	ldr r0, [r6]
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize2FromAnim
	mov r4, r0
	mov r0, sb
	bl GetObjectFileWork
	mov r2, r0
	mov r1, r4
	mov r0, r8
	bl ObjActionAllocSpriteDS
	ldr r1, [r5, #0x128]
	mov r0, r8
	ldrh r2, [r1, #0x50]
	add r1, sl, #4
	mov r1, r1, lsl #0x10
	strh r2, [r8, #0x50]
	strh r2, [r8, #0x92]
	strh r2, [r8, #0x90]
	ldr r2, [r8, #0x3c]
	mov r1, r1, lsr #0x10
	orr r2, r2, r7
	str r2, [r8, #0x3c]
	bl AnimatorSpriteDS__SetAnimation
	mov r1, #0
	mov r0, r8
	mov r2, r1
	bl AnimatorSpriteDS__ProcessAnimation
	mov r0, r8
	mov r1, #0xc
	bl StageTask__SetOAMOrder
	mov r0, r8
	mov r1, #0
	bl StageTask__SetOAMPriority
	add sl, sl, #1
	add r8, r8, #0xa4
	add sb, sb, #2
	cmp sl, #3
	blt _0216C088
	ldrh r0, [fp, #2]
	cmp r0, #0xa0
	bne _0216C194
	mvn r4, #0x9d
	add r0, r5, #0x218
	add r1, r4, #0x60
	sub r2, r4, #0x30
	mov r3, #0x3e
	str r4, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r5, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _0216C2C8 // =0x0000FFFD
	add r0, r5, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	b _0216C1D0
_0216C194:
	mov r4, #0x98
	add r0, r5, #0x218
	sub r1, r4, #0xc0
	sub r2, r4, #0x100
	mov r3, #0x28
	str r4, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r5, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _0216C2CC // =0x0000FFFE
	add r0, r5, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
_0216C1D0:
	ldr r0, _0216C2D0 // =ovl00_216CB44
	str r5, [r5, #0x234]
	str r0, [r5, #0x23c]
	ldr r1, [r5, #0x230]
	mov r0, #0xab
	orr r1, r1, #0x400
	str r1, [r5, #0x230]
	bl GetObjectFileWork
	ldr r1, _0216C2C0 // =gameArchiveStage
	mov r2, r0
	ldr r3, [r1]
	ldr r1, _0216C2D4 // =aDfGmkStalactit
	mov r0, r5
	bl ObjObjectCollisionDifSet
	mov r4, #0x68
	str r5, [r5, #0x2d8]
	add r0, r5, #0x2d8
	strh r4, [r0, #0x30]
	strh r4, [r0, #0x32]
	sub r3, r4, #0xd0
	strh r3, [r0, #0x18]
	sub r2, r4, #0x168
	strh r2, [r0, #0x1a]
	str r5, [r5, #0x410]
	ldr r0, [r5, #0x2fc]
	add r1, r5, #0x410
	str r0, [r1, #0x24]
	strh r4, [r1, #0x30]
	strh r4, [r1, #0x32]
	strh r3, [r1, #0x18]
	strh r2, [r1, #0x1a]
	ldr r0, _0216C2D8 // =ovl00_216C9F4
	ldr r1, _0216C2DC // =ovl00_216CAC4
	str r0, [r5, #0xfc]
	ldr r0, _0216C2E0 // =ovl00_216C5D8
	str r1, [r5, #0x108]
	str r0, [r5, #0xf4]
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	ldrh r1, [fp, #2]
	add r0, r4, #0xd9
	sub r1, r1, #0xa0
	and r1, r1, #0xff
	str r1, [sp, #0x10]
	ldr r2, [r5, #0x48]
	ldr r1, [r5, #0x44]
	sub r2, r2, #0xa0000
	bl GameObject__SpawnObject
	str r0, [r5, #0x40c]
	cmp r0, #0
	strne r5, [r0, #0x11c]
	mov r0, r5
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_0216C2B4: .word 0x00000ADC
_0216C2B8: .word StageTask_Main
_0216C2BC: .word Stalactite__Destructor
_0216C2C0: .word gameArchiveStage
_0216C2C4: .word aActAcGmkStalac
_0216C2C8: .word 0x0000FFFD
_0216C2CC: .word 0x0000FFFE
_0216C2D0: .word ovl00_216CB44
_0216C2D4: .word aDfGmkStalactit
_0216C2D8: .word ovl00_216C9F4
_0216C2DC: .word ovl00_216CAC4
_0216C2E0: .word ovl00_216C5D8
	arm_func_end Object51__Create

	arm_func_start Object96__Create
Object96__Create: // 0x0216C2E4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r4, #0x1800
	mov r8, r0
	str r4, [sp]
	mov r0, #2
	mov r7, r1
	mov r6, r2
	str r0, [sp, #4]
	ldr r4, _0216C530 // =0x0000046C
	ldr r0, _0216C534 // =StageTask_Main
	ldr r1, _0216C538 // =GameObject__Destructor
	mov r2, #0
	mov r5, r3
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	mov r0, r4
	bl GetTaskWork_
	ldr r2, _0216C530 // =0x0000046C
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r8
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	ldr r1, [r4, #0xd8]
	mov r0, #0x9f
	add r1, r1, #0x100
	str r1, [r4, #0xd8]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x18]
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0216C53C // =gameArchiveStage
	mov r1, #0x42
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _0216C540 // =aActAcGmkStalac
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	cmp r5, #0
	mov r0, r4
	beq _0216C3E0
	mov r1, #7
	mov r2, #0x2d
	bl ObjActionAllocSpritePalette
	b _0216C3EC
_0216C3E0:
	mov r1, #0
	mov r2, #5
	bl ObjActionAllocSpritePalette
_0216C3EC:
	mov r0, r4
	mov r1, #3
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, #0xaa
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	ldr r1, _0216C544 // =aDfGmkStalactit_0
	ldr r3, _0216C53C // =gameArchiveStage
	ldr r3, [r3]
	bl ObjObjectCollisionDifSet
	str r4, [r4, #0x2d8]
	add r0, r4, #0x2d8
	mov r6, #0x28
	strh r6, [r0, #0x30]
	strh r6, [r0, #0x32]
	sub r3, r6, #0x50
	strh r3, [r0, #0x18]
	mov r2, #0x38
	strh r2, [r0, #0x1a]
	str r4, [r4, #0x364]
	add r1, r4, #0x364
	ldr r0, [r4, #0x2fc]
	add r5, r4, #0x3bc
	str r0, [r1, #0x24]
	strh r6, [r1, #0x30]
	strh r6, [r1, #0x32]
	strh r3, [r1, #0x18]
	strh r2, [r1, #0x1a]
	str r4, [r4, #0x3bc]
	ldr r3, _0216C548 // =StageTask__DefaultDiffData
	mov r2, #0x30
	str r3, [r5, #0x24]
	strh r2, [r5, #0x30]
	strh r2, [r5, #0x32]
	sub r0, r2, #0x60
	strh r0, [r5, #0x18]
	mov r1, #8
	strh r1, [r5, #0x1a]
	str r4, [r4, #0x414]
	add r0, r4, #0x14
	add r0, r0, #0x400
	str r3, [r0, #0x24]
	strh r2, [r0, #0x30]
	strh r2, [r0, #0x32]
	mov r2, #0
	strh r2, [r0, #0x18]
	strh r1, [r0, #0x1a]
	ldr r1, _0216C54C // =0x00000201
	add r0, r4, #0x200
	strh r1, [r0, #0x4c]
	mov r0, #0x56
	str r0, [sp]
	sub r1, r0, #0x80
	add r0, r4, #0x218
	mov r3, #0x2a
	bl ObjRect__SetBox2D
	add r0, r4, #0x218
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, _0216C550 // =0x0000FFFF
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x230]
	ldr r0, _0216C554 // =ovl00_216CE68
	orr r1, r1, #0x20
	str r1, [r4, #0x230]
	ldr r1, _0216C558 // =ovl00_216CCDC
	str r0, [r4, #0x108]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216C530: .word 0x0000046C
_0216C534: .word StageTask_Main
_0216C538: .word GameObject__Destructor
_0216C53C: .word gameArchiveStage
_0216C540: .word aActAcGmkStalac
_0216C544: .word aDfGmkStalactit_0
_0216C548: .word StageTask__DefaultDiffData
_0216C54C: .word 0x00000201
_0216C550: .word 0x0000FFFF
_0216C554: .word ovl00_216CE68
_0216C558: .word ovl00_216CCDC
	arm_func_end Object96__Create

	arm_func_start Stalactite__Destructor
Stalactite__Destructor: // 0x0216C55C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	mov r4, r0
	bl GetTaskWork_
	mov r5, r0
	mov r0, #0x9f
	bl GetObjectFileWork
	add r1, r5, #0x368
	bl ObjAction2dBACRelease
	add r0, r5, #0x68
	mov r7, #0
	add r8, r0, #0x400
	mov sb, #0xa4
	mov r6, r7
	mov r5, #0x9f
_0216C594:
	mov r0, sb
	bl GetObjectFileWork
	bl ObjActionReleaseSpriteDS
	str r6, [r8, #0x78]
	mov r0, r5
	str r6, [r8, #0x7c]
	bl GetObjectFileWork
	mov r1, r8
	bl ObjAction2dBACRelease
	add r7, r7, #1
	cmp r7, #3
	add r8, r8, #0xa4
	add sb, sb, #2
	blt _0216C594
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	arm_func_end Stalactite__Destructor

	arm_func_start ovl00_216C5D8
ovl00_216C5D8: // 0x0216C5D8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, lr}
	sub sp, sp, #0xc
	mov sl, r0
	ldr r1, [sl, #0x364]
	mov sb, #0
	cmp r1, #0
	beq _0216C5F8
	blx r1
_0216C5F8:
	ldr r8, [sl, #0xad4]
	cmp r8, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
	mov r6, #0
	mov r7, #0xf000
	mov r5, #0x100
	mov r4, r6
_0216C618:
	ldr r0, [r8, #0x14]
	cmp r0, #0xf000
	bge _0216C634
	add r0, r0, #0x2a0
	str r0, [r8, #0x14]
	cmp r0, #0xf000
	strgt r7, [r8, #0x14]
_0216C634:
	ldr r0, [r8, #0x10]
	mov r1, r0, asr #8
	bl ObjSpdDownSet
	str r0, [r8, #0x10]
	ldr r1, [r8, #4]
	mov r2, r5
	add r0, r1, r0
	str r0, [r8, #4]
	ldr r1, [r8, #8]
	ldr r0, [r8, #0x14]
	mov r3, r6
	add r0, r1, r0
	str r0, [r8, #8]
	str r6, [sp]
	str r6, [sp, #4]
	str r6, [sp, #8]
	ldmib r8, {r0, r1}
	bl StageTask__ViewOutCheck
	cmp r0, #0
	beq _0216C6B8
	ldr r1, [r8, #0x1c]
	cmp sb, #0
	strne r1, [sb, #0x1c]
	streq r1, [sl, #0xad4]
	str r4, [r8, #0x1c]
	ldr r0, [sl, #0xad8]
	add r0, sl, r0, lsl #2
	str r8, [r0, #0xa54]
	ldr r0, [sl, #0xad8]
	mov r8, r1
	add r0, r0, #1
	str r0, [sl, #0xad8]
	b _0216C6C0
_0216C6B8:
	mov sb, r8
	ldr r8, [r8, #0x1c]
_0216C6C0:
	cmp r8, #0
	bne _0216C618
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
	arm_func_end ovl00_216C5D8

	arm_func_start ovl00_216C6D0
ovl00_216C6D0: // 0x0216C6D0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r0, [r6, #0x2c]
	add r0, r0, #1
	str r0, [r6, #0x2c]
	cmp r0, #0x2d
	beq _0216C6FC
	cmp r0, #0x64
	beq _0216C70C
	b _0216C818
_0216C6FC:
	ldr r0, [r6, #0x24]
	orr r0, r0, #1
	str r0, [r6, #0x24]
	b _0216C818
_0216C70C:
	ldr r0, [r6, #0x24]
	mov r5, #0
	orr r0, r0, #2
	str r0, [r6, #0x24]
	ldr r1, [r6, #0x354]
	ldr r0, _0216C8FC // =ovl00_216C910
	orr r1, r1, #1
	str r1, [r6, #0x354]
	str r5, [r6, #0x2d8]
	ldr r1, [r6, #0x2f4]
	ldr r4, _0216C900 // =_02189478
	orr r1, r1, #0x100
	str r1, [r6, #0x2f4]
	str r5, [r6, #0x410]
	ldr r1, [r6, #0x42c]
	ldr sb, _0216C904 // =_mt_math_rand
	orr r1, r1, #0x100
	str r1, [r6, #0x42c]
	ldr r7, _0216C908 // =0x00196225
	ldr r8, _0216C90C // =0x3C6EF35F
	str r0, [r6, #0x364]
_0216C760:
	ldr r1, [sb]
	and r2, r5, #7
	mla r0, r1, r7, r8
	mla r1, r0, r7, r8
	mla r3, r1, r7, r8
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #3
	rsb r1, r1, #0
	str r3, [sb]
	mov r1, r1, lsl #0xc
	str r1, [sp]
	ldrb r1, [r4, r2]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	str r1, [sp, #4]
	ldr r1, [sb]
	mov r2, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	and r1, r2, #0x7f
	mov r0, r0, lsl #0x10
	ldr r2, [r6, #0x48]
	sub r3, r1, #0x40
	mov r0, r0, lsr #0x10
	ldr r1, [r6, #0x44]
	mov ip, r3, lsl #0xc
	sub r2, r2, #0xd0000
	mov lr, r0, lsl #0x1a
	mov r0, r6
	add r1, r1, r3, lsl #12
	add r2, r2, lr, lsr #14
	mov r3, ip, asr #4
	bl ovl00_216CC3C
	add r5, r5, #1
	cmp r5, #0x10
	blt _0216C760
	mov r4, #0x5f
	sub r1, r4, #0x60
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
_0216C818:
	ldr r0, [r6, #0x2c]
	cmp r0, #0x2d
	blt _0216C834
	tst r0, #1
	ldrne r0, [r6, #0x354]
	eorne r0, r0, #1
	strne r0, [r6, #0x354]
_0216C834:
	ldr r0, [r6, #0x28]
	sub r1, r0, #1
	mov r0, r1, lsl #0x10
	movs r0, r0, lsr #0x10
	addne sp, sp, #8
	str r1, [r6, #0x28]
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	ldr r2, _0216C904 // =_mt_math_rand
	ldr r0, _0216C908 // =0x00196225
	ldr r4, [r2]
	ldr r1, _0216C90C // =0x3C6EF35F
	mov r3, #0
	mla r5, r4, r0, r1
	mla r4, r5, r0, r1
	mla r1, r4, r0, r1
	mov r0, r5, lsr #0x10
	str r1, [r2]
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	ldr r0, _0216C900 // =_02189478
	str r3, [sp]
	and r1, r1, #7
	ldrb r1, [r0, r1]
	mov r0, r4, lsr #0x10
	mov r0, r0, lsl #0x10
	str r1, [sp, #4]
	ldr r1, [r2]
	ldr r2, [r6, #0x48]
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r7, r0, lsr #0x10
	and r0, r1, #0x7f
	sub r1, r0, #0x40
	ldr r5, [r6, #0x44]
	sub r4, r2, #0xd0000
	mov r2, r7, lsl #0x1a
	mov r0, r6
	add r1, r5, r1, lsl #12
	add r2, r4, r2, lsr #14
	bl ovl00_216CC3C
	ldr r0, [r6, #0x28]
	mov r0, r0, lsr #0x10
	sub r0, r0, #1
	cmp r0, #2
	movlo r0, #2
	orr r0, r0, r0, lsl #16
	str r0, [r6, #0x28]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_0216C8FC: .word ovl00_216C910
_0216C900: .word _02189478
_0216C904: .word _mt_math_rand
_0216C908: .word 0x00196225
_0216C90C: .word 0x3C6EF35F
	arm_func_end ovl00_216C6D0

	arm_func_start ovl00_216C910
ovl00_216C910: // 0x0216C910
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r5, [r6, #0x40c]
	ldr r0, [r5, #0x24]
	tst r0, #4
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	mov r4, #0
	ldr sl, _0216C9E4 // =_02189478
	ldr sb, _0216C9E8 // =_mt_math_rand
	ldr r7, _0216C9EC // =0x00196225
	ldr r8, _0216C9F0 // =0x3C6EF35F
	str r4, [r6, #0x364]
_0216C948:
	ldr r1, [sb]
	and r2, r4, #7
	mla r0, r1, r7, r8
	mla r1, r0, r7, r8
	mla r3, r1, r7, r8
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #7
	rsb r1, r1, #0
	str r3, [sb]
	mov r1, r1, lsl #0xc
	str r1, [sp]
	ldrb r1, [sl, r2]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	str r1, [sp, #4]
	ldr r1, [sb]
	mov r2, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	and r1, r2, #0x3f
	mov r0, r0, lsl #0x10
	ldr r2, [r5, #0x48]
	sub lr, r1, #0x20
	mov r0, r0, lsr #0x10
	ldr r1, [r5, #0x44]
	mov r3, lr, lsl #0xc
	add ip, r2, #0x3e000
	mov r2, r0, lsl #0x1c
	mov r0, r6
	add r1, r1, lr, lsl #12
	add r2, ip, r2, lsr #16
	mov r3, r3, asr #4
	bl ovl00_216CC3C
	add r4, r4, #1
	cmp r4, #0xa
	blt _0216C948
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	.align 2, 0
_0216C9E4: .word _02189478
_0216C9E8: .word _mt_math_rand
_0216C9EC: .word 0x00196225
_0216C9F0: .word 0x3C6EF35F
	arm_func_end ovl00_216C910

	arm_func_start ovl00_216C9F4
ovl00_216C9F4: // 0x0216C9F4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	sub sp, sp, #0x10
	bl GetCurrentTaskWork_
	mov r1, #0x100000
	mov r4, r0
	rsb r1, r1, #0
	str r1, [r4, #0x54]
	ldr r1, [r4, #0x354]
	tst r1, #1
	bne _0216CA24
	add r1, r4, #0x368
	bl StageTask__Draw2D
_0216CA24:
	ldr r1, [r4, #0x128]
	mov r0, r4
	bl StageTask__Draw2D
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #1
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x128]
	bl StageTask__Draw2D
	ldr r0, [r4, #0x20]
	bic r0, r0, #1
	str r0, [r4, #0x20]
	ldr r5, [r4, #0xad4]
	cmp r5, #0
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	add r0, r4, #0x68
	ldr r4, _0216CAC0 // =0x00010100
	add r7, r0, #0x400
	add sb, sp, #0xc
	mov r8, #0
	mov r6, #0xa4
_0216CA7C:
	ldrh r0, [r5, #2]
	mov r2, r8
	mov r3, r8
	orr r0, r0, r4
	str r0, [sp, #0xc]
	str sb, [sp]
	str r8, [sp, #4]
	str r8, [sp, #8]
	ldrh ip, [r5]
	add r1, r5, #4
	mla r0, ip, r6, r7
	bl StageTask__Draw2DEx
	ldr r5, [r5, #0x1c]
	cmp r5, #0
	bne _0216CA7C
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_0216CAC0: .word 0x00010100
	arm_func_end ovl00_216C9F4

	arm_func_start ovl00_216CAC4
ovl00_216CAC4: // 0x0216CAC4
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x18]
	tst r1, #0xc
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0x234]
	cmp r1, #0
	beq _0216CAF0
	add r1, r4, #0x218
	bl StageTask__HandleCollider
_0216CAF0:
	mov r0, r4
	bl StageTask__ViewCheck_Default
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x2d8]
	cmp r0, #0
	beq _0216CB14
	add r0, r4, #0x2d8
	bl ObjCollisionObjectRegist
_0216CB14:
	ldr r0, [r4, #0x410]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x20]
	add r0, r4, #0x410
	orr r1, r1, #1
	str r1, [r4, #0x20]
	bl ObjCollisionObjectRegist
	ldr r0, [r4, #0x20]
	bic r0, r0, #1
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}
	arm_func_end ovl00_216CAC4

	arm_func_start ovl00_216CB44
ovl00_216CB44: // 0x0216CB44
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	mov r6, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrh r0, [r5]
	cmp r0, #1
	ldrne r1, [r5, #0x11c]
	cmpne r1, #0
	beq _0216CB94
	ldrh r0, [r1]
	mov r5, r1
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, pc}
	mov r6, #1
_0216CB94:
	ldr r1, [r4, #0x18]
	add r0, r4, #0x368
	orr r2, r1, #2
	mov r1, #2
	str r2, [r4, #0x18]
	bl AnimatorSpriteDS__SetAnimation
	ldr r0, _0216CC34 // =ovl00_216C6D0
	mov r1, #0
	str r0, [r4, #0x364]
	ldr r0, _0216CC38 // =0x00100010
	str r1, [r4, #0x2c]
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0xa0
	bne _0216CC10
	mov r0, r5
	bl Player__Action_DestroyAttackRecoil
	ldr r0, [r5, #0x98]
	cmp r6, #0
	rsb r0, r0, #0
	str r0, [r5, #0x98]
	beq _0216CC10
	ldr r1, [r5, #0x98]
	mov r0, #0x63
	mov r1, r1, asr #2
	str r1, [r5, #0x98]
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x24]
	orr r0, r0, #1
	str r0, [r4, #0x24]
_0216CC10:
	mov r4, #0x5e
	sub r1, r4, #0x5f
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216CC34: .word ovl00_216C6D0
_0216CC38: .word 0x00100010
	arm_func_end ovl00_216CB44

	arm_func_start ovl00_216CC3C
ovl00_216CC3C: // 0x0216CC3C
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, [r0, #0xad8]
	cmp r4, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r4, _0216CCD0 // =_mt_math_rand
	ldr ip, _0216CCD4 // =0x00196225
	ldr r6, [r4]
	ldr lr, _0216CCD8 // =0x3C6EF35F
	ldrh r5, [sp, #0x14]
	mla ip, r6, ip, lr
	str ip, [r4]
	ldr r4, [r0, #0xad8]
	mov ip, ip, lsr #0x10
	sub r4, r4, #1
	str r4, [r0, #0xad8]
	add r4, r0, r4, lsl #2
	ldr r4, [r4, #0xa54]
	mov ip, ip, lsl #0x10
	strh r5, [r4]
	stmib r4, {r1, r2}
	mov r2, ip, lsr #0x10
	ldr r1, [sp, #0x10]
	str r3, [r4, #0x10]
	str r1, [r4, #0x14]
	tst r2, #2
	movne r1, #2
	moveq r1, #0
	tst r2, #1
	movne r2, #1
	moveq r2, #0
	orr r1, r2, r1
	strh r1, [r4, #2]
	ldr r1, [r0, #0xad4]
	cmp r1, #0
	strne r1, [r4, #0x1c]
	str r4, [r0, #0xad4]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216CCD0: .word _mt_math_rand
_0216CCD4: .word 0x00196225
_0216CCD8: .word 0x3C6EF35F
	arm_func_end ovl00_216CC3C

	arm_func_start ovl00_216CCDC
ovl00_216CCDC: // 0x0216CCDC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r3, [r4, #0x24]
	ldr r2, [r4, #0x11c]
	tst r3, #2
	bne _0216CD54
	ldr r1, [r2, #0x24]
	tst r1, #2
	beq _0216CD54
	orr r1, r3, #2
	str r1, [r4, #0x24]
	mov r2, #0
	str r2, [r4, #4]
	ldr r3, [r4, #0x1c]
	mov r1, #0x40
	bic r3, r3, #0x2100
	str r3, [r4, #0x1c]
	str r1, [sp]
	sub r1, r1, #0x60
	mov r3, #0x20
	bl StageTask__SetHitbox
	str r4, [r4, #0x234]
	ldr r1, [r4, #0x1c]
	ldr r0, _0216CDDC // =ovl00_216CDEC
	orr r1, r1, #0x80
	str r1, [r4, #0x1c]
	add sp, sp, #4
	str r0, [r4, #0xf4]
	ldmia sp!, {r3, r4, pc}
_0216CD54:
	tst r3, #1
	beq _0216CDC0
	ldr r3, _0216CDE0 // =_mt_math_rand
	ldr r1, _0216CDE4 // =0x00196225
	ldr r0, [r3]
	ldr r2, _0216CDE8 // =0x3C6EF35F
	add sp, sp, #4
	mla ip, r0, r1, r2
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	sub r0, r0, #2
	str ip, [r3]
	mov r0, r0, lsl #0xc
	str r0, [r4, #0x50]
	ldr r0, [r3]
	mla r1, r0, r1, r2
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	sub r0, r0, #2
	str r1, [r3]
	mov r0, r0, lsl #0xc
	str r0, [r4, #0x54]
	ldmia sp!, {r3, r4, pc}
_0216CDC0:
	ldr r0, [r2, #0x24]
	tst r0, #1
	ldrne r0, [r4, #0x24]
	orrne r0, r0, #1
	strne r0, [r4, #0x24]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0216CDDC: .word ovl00_216CDEC
_0216CDE0: .word _mt_math_rand
_0216CDE4: .word 0x00196225
_0216CDE8: .word 0x3C6EF35F
	arm_func_end ovl00_216CCDC

	arm_func_start ovl00_216CDEC
ovl00_216CDEC: // 0x0216CDEC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x1c]
	tst r0, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	orr r1, r0, #0x2100
	mov r0, #0
	str r1, [r4, #0x1c]
	str r0, [r4, #0xc4]
	str r0, [r4, #0xc0]
	str r0, [r4, #0xbc]
	mov r0, #4
	bl ShakeScreen
	ldr r0, [r4, #0x18]
	mov ip, #0x60
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r2, [r4, #0x24]
	sub r1, ip, #0x61
	orr r2, r2, #4
	str r2, [r4, #0x24]
	mov r0, #0
	str r0, [r4, #0xf4]
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl00_216CDEC

	arm_func_start ovl00_216CE68
ovl00_216CE68: // 0x0216CE68
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x18]
	tst r1, #0xc
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0x234]
	cmp r1, #0
	beq _0216CE94
	add r1, r4, #0x218
	bl StageTask__HandleCollider
_0216CE94:
	mov r0, r4
	bl StageTask__ViewCheck_Default
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x2d8
	bl ObjCollisionObjectRegist
	ldr r1, [r4, #0x20]
	add r0, r4, #0x364
	orr r1, r1, #1
	str r1, [r4, #0x20]
	bl ObjCollisionObjectRegist
	ldr r1, [r4, #0x20]
	add r0, r4, #0x3bc
	bic r1, r1, #1
	str r1, [r4, #0x20]
	bl ObjCollisionObjectRegist
	add r0, r4, #0x14
	add r0, r0, #0x400
	bl ObjCollisionObjectRegist
	ldmia sp!, {r4, pc}
	arm_func_end ovl00_216CE68

	.data
	
_02189478:
	.byte 0x00, 0x01, 0x02, 0x00, 0x01, 0x02, 0x00, 0x01

aActAcGmkStalac: // 0x02189480
	.asciz "/act/ac_gmk_stalactite.bac"
	.align 4
	
aDfGmkStalactit: // 0x0218949C
	.asciz "/df/gmk_stalactite_bottom.df"
	.align 4
	
aDfGmkStalactit_0: // 0x021894BC
	.asciz "/df/gmk_stalactite_drop.df"
	.align 4