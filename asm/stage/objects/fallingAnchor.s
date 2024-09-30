	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start FallingAnchor__Create
FallingAnchor__Create: // 0x02180DE8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, _0218109C // =0x000010F6
	mov r7, r0
	str r3, [sp]
	mov r0, #2
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _021810A0 // =0x0000040C
	ldr r0, _021810A4 // =StageTask_Main
	ldr r1, _021810A8 // =FallingAnchor__Destructor
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
	ldr r2, _021810A0 // =0x0000040C
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	mov r0, #0xa6
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _021810AC // =gameArchiveStage
	mov r1, #0
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _021810B0 // =aActAcGmkAnchor_0
	bl ObjObjectAction2dBACLoad
	mov r0, #0xa7
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #0x1f
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, #0
	mov r2, #0x5c
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	add r5, r4, #0x364
	mov r0, #0xa6
	bl GetObjectFileWork
	mov r3, r0
	ldr r1, _021810AC // =gameArchiveStage
	mov r0, r5
	ldr r2, [r1, #0]
	ldr r1, _021810B0 // =aActAcGmkAnchor_0
	str r2, [sp]
	mov r2, #0x1f
	bl ObjAction2dBACLoad
	ldr r1, [r4, #0x128]
	mov r0, r5
	ldrh r2, [r1, #0x50]
	mov r1, #1
	strh r2, [r5, #0x50]
	strh r2, [r5, #0x92]
	strh r2, [r5, #0x90]
	ldr r2, [r5, #0x3c]
	orr r2, r2, #0x10
	str r2, [r5, #0x3c]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r5
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r5
	mov r1, #2
	bl StageTask__SetOAMPriority
	ldr r2, _021810B4 // =0x00000201
	add r0, r4, #0x200
	strh r2, [r0, #0x4c]
	rsb r5, r2, #0x17c
	mvn r1, #0x27
	add r0, r4, #0x218
	sub r2, r1, #0x7b
	mov r3, #0x28
	str r5, [sp]
	bl ObjRect__SetBox2D
	add r0, r4, #0x218
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	ldr r1, _021810B8 // =0x0000FFFF
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, [r4, #0x230]
	mvn r2, #0x84
	orr r0, r0, #0x820
	str r0, [r4, #0x230]
	str r2, [sp]
	add r1, r2, #0x61
	add r0, r4, #0x258
	sub r2, r2, #0x1e
	mov r3, #0x24
	bl ObjRect__SetBox2D
	add r0, r4, #0x258
	mov r1, #4
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	ldr r1, _021810B8 // =0x0000FFFF
	add r0, r4, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x270]
	mov r3, #0x20
	orr r1, r1, #0x820
	str r1, [r4, #0x270]
	mov r0, #0
	str r0, [r4, #0x13c]
	ldr r0, _021810BC // =StageTask__DefaultDiffData
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	mov r1, #0x50
	add r0, r4, #0x300
	strh r1, [r0, #8]
	strh r3, [r0, #0xa]
	sub r1, r3, #0x48
	add r0, r4, #0x200
	strh r1, [r0, #0xf0]
	sub r1, r3, #0xc6
	strh r1, [r0, #0xf2]
	sub r0, r3, #0xbb
	str r0, [sp]
	mov r0, r4
	sub r1, r3, #0x40
	sub r2, r3, #0xc3
	bl StageTask__SetHitbox
	ldr r1, [r4, #0x1c]
	mov r0, #0x200
	orr r1, r1, #0x2300
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	strh r0, [r4, #0x14]
	ldr r0, [r4, #0x48]
	ldr r1, _021810C0 // =FallingAnchor__State_21810F4
	str r0, [r4, #0x408]
	ldrsb r0, [r7, #6]
	cmp r0, #0
	strgt r0, [r4, #0x2c]
	ldr r0, _021810C4 // =FallingAnchor__Draw
	str r0, [r4, #0xfc]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0218109C: .word 0x000010F6
_021810A0: .word 0x0000040C
_021810A4: .word StageTask_Main
_021810A8: .word FallingAnchor__Destructor
_021810AC: .word gameArchiveStage
_021810B0: .word aActAcGmkAnchor_0
_021810B4: .word 0x00000201
_021810B8: .word 0x0000FFFF
_021810BC: .word StageTask__DefaultDiffData
_021810C0: .word FallingAnchor__State_21810F4
_021810C4: .word FallingAnchor__Draw
	arm_func_end FallingAnchor__Create

	arm_func_start FallingAnchor__Destructor
FallingAnchor__Destructor: // 0x021810C8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0xa6
	bl GetObjectFileWork
	add r1, r4, #0x364
	bl ObjAction2dBACRelease
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end FallingAnchor__Destructor

	arm_func_start FallingAnchor__State_21810F4
FallingAnchor__State_21810F4: // 0x021810F4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x28]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0218160C
_02181110: // jump table
	b _02181128 // case 0
	b _02181160 // case 1
	b _021811D8 // case 2
	b _021814CC // case 3
	b _0218155C // case 4
	b _021815C8 // case 5
_02181128:
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0
	bgt _0218160C
	ldr r1, [r4, #0x28]
	mov r0, #8
	add r1, r1, #1
	str r1, [r4, #0x28]
	ldr r1, [r4, #0x354]
	orr r1, r1, #1
	str r1, [r4, #0x354]
	str r0, [r4, #0x2c]
	b _0218160C
_02181160:
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0
	bgt _0218160C
	ldr r1, [r4, #0x354]
	mov r0, #0
	bic r1, r1, #1
	str r1, [r4, #0x354]
	ldr r2, [r4, #0x28]
	sub r1, r0, #1
	add r2, r2, #1
	str r2, [r4, #0x28]
	ldr r2, [r4, #0x1c]
	ldr r5, _02181680 // =0x0000011E
	bic r2, r2, #0x2100
	str r2, [r4, #0x1c]
	str r4, [r4, #0x234]
	ldr r3, [r4, #0x230]
	mov r2, r1
	bic r3, r3, #0x800
	str r3, [r4, #0x230]
	str r4, [r4, #0x274]
	ldr r6, [r4, #0x270]
	mov r3, r1
	bic r6, r6, #0x800
	str r6, [r4, #0x270]
	stmia sp, {r0, r5}
	bl PlaySfxEx
	b _0218160C
_021811D8:
	ldr r0, [r4, #0x9c]
	mov r1, #0x800
	mov r2, #0x8000
	bl ObjSpdUpSet
	str r0, [r4, #0x9c]
	ldr r1, [r4, #0x408]
	ldr r2, [r4, #0x48]
	add r1, r1, #0x200000
	add r0, r0, r2
	cmp r0, r1
	subgt r0, r1, r2
	strgt r0, [r4, #0x9c]
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r0, [r4, #0x1c]
	ands r2, r0, #1
	bne _02181234
	ldr r0, [r4, #0x408]
	ldr r1, [r4, #0x48]
	add r0, r0, #0x200000
	cmp r1, r0
	blt _0218160C
_02181234:
	cmp r2, #0
	beq _02181418
	ldr r3, _02181684 // =_mt_math_rand
	mov r2, #0x2000
	ldr r5, [r3, #0]
	ldr r0, _02181688 // =0x00196225
	ldr r1, _0218168C // =0x3C6EF35F
	rsb r2, r2, #0
	mla ip, r5, r0, r1
	mla r6, ip, r0, r1
	mla r5, r6, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r1, r0, #1
	mov r0, r6, lsr #0x10
	str r5, [r3]
	str r1, [sp]
	mov r0, r0, lsl #0x10
	mov lr, r0, lsr #0x10
	ldr r0, [r3, #0]
	ldr r1, [r4, #0x48]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr ip, [r4, #0x44]
	mov r6, r0, lsl #0x18
	sub r3, r2, #0x2000
	mov r5, lr, lsl #0x19
	sub r0, ip, #0x1a000
	sub r1, r1, #0x95000
	sub r2, r2, r6, lsr #20
	sub r3, r3, r5, lsr #21
	bl EffectSlingDust__Create
	ldr ip, _02181684 // =_mt_math_rand
	mov r0, #0
	ldr r1, _02181688 // =0x00196225
	ldr r5, [ip]
	ldr r2, _0218168C // =0x3C6EF35F
	sub r3, r0, #0x1800
	mla r6, r5, r1, r2
	mla r1, r6, r1, r2
	str r1, [ip]
	str r0, [sp]
	ldr r1, [ip]
	mov r5, r6, lsr #0x10
	mov r2, r1, lsr #0x10
	mov r1, r5, lsl #0x10
	mov r5, r1, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r1, r2, lsr #0x10
	mov r2, r1, lsl #0x18
	ldr lr, [r4, #0x48]
	ldr r6, [r4, #0x44]
	sub ip, r0, #0x4800
	mov r5, r5, lsl #0x19
	sub r2, r3, r2, lsr #20
	sub r0, r6, #0xc000
	sub r1, lr, #0x95000
	sub r3, ip, r5, lsr #21
	bl EffectSlingDust__Create
	ldr r2, _02181684 // =_mt_math_rand
	mov r3, #0x4800
	ldr ip, [r2]
	ldr r0, _02181688 // =0x00196225
	ldr r1, _0218168C // =0x3C6EF35F
	mov r5, #1
	mla lr, ip, r0, r1
	mla r0, lr, r0, r1
	str r0, [r2]
	str r5, [sp]
	ldr r0, [r2, #0]
	mov r2, lr, lsr #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsl #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r5, r0, lsr #0x10
	mov r0, r1, lsl #0x18
	ldr r2, [r4, #0x44]
	mov r1, r0, lsr #0x14
	add r0, r2, #0x19000
	add r2, r1, #0x1800
	mov r1, r5, lsl #0x19
	rsb r3, r3, #0
	ldr r5, [r4, #0x48]
	sub r3, r3, r1, lsr #21
	sub r1, r5, #0x95000
	bl EffectSlingDust__Create
	ldr r2, _02181684 // =_mt_math_rand
	mov r3, #0x4000
	ldr ip, [r2]
	ldr r0, _02181688 // =0x00196225
	ldr r1, _0218168C // =0x3C6EF35F
	rsb r3, r3, #0
	mla r5, ip, r0, r1
	mla ip, r5, r0, r1
	mla lr, ip, r0, r1
	mov r0, r5, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r1, r0, #1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	str lr, [r2]
	str r1, [sp]
	mov r0, r0, lsr #0x10
	mov ip, r0, lsl #0x19
	ldr r0, [r2, #0]
	ldr r1, [r4, #0x48]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x18
	mov r2, r0, lsr #0x14
	ldr lr, [r4, #0x44]
	sub r1, r1, #0x95000
	add r0, lr, #0xd000
	add r2, r2, #0x2000
	sub r3, r3, ip, lsr #21
	bl EffectSlingDust__Create
_02181418:
	ldr r0, [r4, #0x1c]
	mov r2, #0
	bic r0, r0, #0xf
	orr r0, r0, #0x100
	str r0, [r4, #0x1c]
	str r2, [r4, #0x9c]
	str r2, [r4, #0x234]
	ldr r1, [r4, #0x230]
	ldr r0, _02181690 // =mapCamera
	orr r1, r1, #0x800
	str r1, [r4, #0x230]
	str r2, [r4, #0x274]
	ldr r1, [r4, #0x270]
	orr r1, r1, #0x800
	str r1, [r4, #0x270]
	ldr r0, [r0, #0xe0]
	tst r0, #2
	bne _02181484
	ldr r0, _02181694 // =gPlayer
	ldr r1, [r4, #0x48]
	ldr r0, [r0, #0]
	sub r1, r1, #0x3d000
	ldr r0, [r0, #0x48]
	cmp r1, r0
	blt _02181484
	mov r0, #9
	bl ShakeScreen
_02181484:
	ldr r0, [r4, #0x28]
	ldr ip, _02181698 // =0x0000011F
	add r0, r0, #1
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x340]
	sub r1, ip, #0x120
	ldrsb r0, [r0, #7]
	mov r2, r1
	mov r3, r1
	mov r0, r0, lsl #2
	str r0, [r4, #0x2c]
	cmp r0, #0
	movle r0, #0x78
	strle r0, [r4, #0x2c]
	mov r0, #0
	stmia sp, {r0, ip}
	bl PlaySfxEx
	b _0218160C
_021814CC:
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0
	bgt _0218160C
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x340]
	ldrb r0, [r0, #9]
	cmp r0, #8
	movhi r0, #8
	mov r0, r0, lsl #9
	rsb r0, r0, #0
	sub r0, r0, #0x1800
	str r0, [r4, #0x9c]
	ldr r0, _02181690 // =mapCamera
	ldr r1, [r4, #0x48]
	ldrh r2, [r0, #0x6e]
	mov r0, r1, asr #0xc
	sub r0, r0, #0xa3
	cmp r2, r0
	bge _02181538
	ldr r1, [r4, #0x9c]
	mov r0, r1, asr #2
	add r0, r0, r1, asr #1
	str r0, [r4, #0x9c]
_02181538:
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	str r0, [sp]
	mov ip, #0x120
	str ip, [sp, #4]
	bl PlaySfxEx
	b _0218160C
_0218155C:
	ldr r2, [r4, #0x48]
	ldr r1, [r4, #0x9c]
	ldr r0, [r4, #0x408]
	add r1, r2, r1
	cmp r1, r0
	bgt _0218160C
	ldr r0, [r4, #0x1c]
	mov r1, #0
	orr r0, r0, #0x2000
	str r0, [r4, #0x1c]
	ldr r3, [r4, #0x48]
	mov r0, #8
	str r3, [r4, #0x90]
	ldr r2, [r4, #0x48]
	sub r2, r2, r3
	str r2, [r4, #0xc0]
	ldr r2, [r4, #0x408]
	str r2, [r4, #0x48]
	str r1, [r4, #0x9c]
	ldr r1, [r4, #0x28]
	add r1, r1, #1
	str r1, [r4, #0x28]
	ldr r1, [r4, #0x354]
	orr r1, r1, #1
	str r1, [r4, #0x354]
	str r0, [r4, #0x2c]
	b _0218160C
_021815C8:
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0
	bgt _0218160C
	ldr r1, [r4, #0x354]
	mov r0, #0
	bic r1, r1, #1
	str r1, [r4, #0x354]
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x340]
	ldrb r0, [r0, #8]
	mov r0, r0, lsl #2
	str r0, [r4, #0x2c]
	cmp r0, #0
	movle r0, #0x78
	strle r0, [r4, #0x2c]
_0218160C:
	ldr r0, [r4, #0x354]
	tst r0, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r3, _02181684 // =_mt_math_rand
	ldr r1, _02181688 // =0x00196225
	ldr r0, [r3, #0]
	ldr r2, _0218168C // =0x3C6EF35F
	mla ip, r0, r1, r2
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	sub r0, r0, #2
	str ip, [r3]
	mov r0, r0, lsl #0xc
	str r0, [r4, #0x50]
	ldr r0, [r3, #0]
	mla r1, r0, r1, r2
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	sub r0, r0, #2
	str r1, [r3]
	mov r0, r0, lsl #0xc
	str r0, [r4, #0x54]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02181680: .word 0x0000011E
_02181684: .word _mt_math_rand
_02181688: .word 0x00196225
_0218168C: .word 0x3C6EF35F
_02181690: .word mapCamera
_02181694: .word gPlayer
_02181698: .word 0x0000011F
	arm_func_end FallingAnchor__State_21810F4

	arm_func_start FallingAnchor__Draw
FallingAnchor__Draw: // 0x0218169C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x1c
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x20]
	ldr r0, _021817DC // =0x00027FFF
	str r1, [sp, #0xc]
	ldr r3, [r4, #0x48]
	ldr r2, [r4, #0x408]
	mov r1, #0x28000
	sub r2, r3, r2
	add r0, r2, r0
	bl FX_DivS32
	add r5, r0, #1
	ldr r3, [r4, #0x44]
	ldr r2, [r4, #0x50]
	sub r1, r5, #1
	mov r0, #0x28000
	add r2, r3, r2
	str r2, [sp, #0x10]
	ldr r2, [r4, #0x48]
	mul r0, r1, r0
	ldr r1, [r4, #0x54]
	sub r2, r2, #0xfd000
	add r1, r2, r1
	sub r0, r1, r0
	str r0, [sp, #0x14]
	cmp r5, #0
	ble _02181754
	add r8, sp, #0xc
	mov r7, #0
	add r6, sp, #0x10
_0218171C:
	str r8, [sp]
	str r7, [sp, #4]
	mov r1, r6
	mov r2, r7
	str r7, [sp, #8]
	add r0, r4, #0x364
	add r3, r4, #0x38
	bl StageTask__Draw2DEx
	ldr r0, [sp, #0x14]
	sub r5, r5, #1
	add r0, r0, #0x28000
	str r0, [sp, #0x14]
	cmp r5, #0
	bgt _0218171C
_02181754:
	ldr r1, [r4, #0x44]
	ldr r0, [r4, #0x50]
	mov r2, #0
	add r0, r1, r0
	str r0, [sp, #0x10]
	ldr r1, [r4, #0x48]
	ldr r0, [r4, #0x54]
	sub r1, r1, #0xfd000
	add r0, r1, r0
	str r0, [sp, #0x14]
	str r2, [sp, #0x18]
	ldr r1, [r4, #0x20]
	add r0, sp, #0xc
	str r1, [sp, #0xc]
	stmia sp, {r0, r2}
	str r2, [sp, #8]
	ldr r0, [r4, #0x128]
	add r1, sp, #0x10
	add r3, r4, #0x38
	bl StageTask__Draw2DEx
	ldr r1, [sp, #0xc]
	add r0, sp, #0xc
	orr r1, r1, #1
	str r1, [sp, #0xc]
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r2, [sp, #8]
	ldr r0, [r4, #0x128]
	add r1, sp, #0x10
	add r3, r4, #0x38
	bl StageTask__Draw2DEx
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021817DC: .word 0x00027FFF
	arm_func_end FallingAnchor__Draw

	.data
	
aActAcGmkAnchor_0: // 0x02189BC4
	.asciz "/act/ac_gmk_anchor_elv.bac"
	.align 4