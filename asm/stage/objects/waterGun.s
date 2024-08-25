	.include "asm/macros.inc"
	.include "global.inc"

	.bss

_0218A3CC: // 0x0218A3CC
	.space 0x04 * 3
	
Task__Unknown2184B2C__Singleton: // 0x0218A3D8
	.space 0x04 * 2 // Task*[2]
	
	.text

	arm_func_start WaterGun__Create
WaterGun__Create: // 0x02183A44
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, _02183C3C // =0x000010F6
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _02183C40 // =StageTask_Main
	ldr r1, _02183C44 // =WaterGun__Destructor
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
	ldr r0, _02183C48 // =gameArchiveStage
	mov r1, #0x31
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _02183C4C // =aActAcGmkWaterG
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x5f
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x16
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldrh r0, [r7, #2]
	cmp r0, #0xeb
	ldreq r0, [r4, #0x20]
	orreq r0, r0, #1
	streq r0, [r4, #0x20]
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _02183C50 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _02183C54 // =WaterGun__OnDefend
	mov r3, #8
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	ldr r2, _02183C58 // =0x00000201
	orr r0, r0, #0x400
	str r0, [r4, #0x230]
	add r0, r4, #0x200
	strh r2, [r0, #0x8c]
	sub r1, r3, #0x10
	mov r2, r1
	add r0, r4, #0x258
	str r3, [sp]
	bl ObjRect__SetBox2D
	add r0, r4, #0x258
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	ldr r1, _02183C5C // =0x0000FFFF
	add r0, r4, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x270]
	mov r0, #0xc1
	orr r1, r1, #0x20
	str r1, [r4, #0x270]
	bl GetObjectFileWork
	ldr r3, _02183C48 // =gameArchiveStage
	mov r2, r0
	ldr r1, _02183C60 // =aDfGmkWaterGrai
	ldr r3, [r3]
	mov r0, r4
	bl ObjObjectCollisionDifSet
	str r4, [r4, #0x2d8]
	mov r1, #0x70
	add r0, r4, #0x300
	strh r1, [r0, #8]
	mov r1, #0x40
	strh r1, [r0, #0xa]
	sub r2, r1, #0x60
	add r0, r4, #0x200
	sub r1, r1, #0x80
	strh r2, [r0, #0xf0]
	strh r1, [r0, #0xf2]
	ldrsb r0, [r7, #6]
	bl WaterGrindRail__Create
	bl AllocSndHandle
	str r0, [r4, #0x138]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02183C3C: .word 0x000010F6
_02183C40: .word StageTask_Main
_02183C44: .word WaterGun__Destructor
_02183C48: .word gameArchiveStage
_02183C4C: .word aActAcGmkWaterG
_02183C50: .word 0x0000FFFE
_02183C54: .word WaterGun__OnDefend
_02183C58: .word 0x00000201
_02183C5C: .word 0x0000FFFF
_02183C60: .word aDfGmkWaterGrai
	arm_func_end WaterGun__Create

	arm_func_start WaterGrindTrigger__Create
WaterGrindTrigger__Create: // 0x02183C64
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, _02183DE0 // =0x00001801
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _02183DE4 // =StageTask_Main
	ldr r1, _02183DE8 // =WaterGun__Destructor
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
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x120
	orr r0, r0, #0x1000
	str r0, [r4, #0x20]
	ldrh r0, [r7, #2]
	cmp r0, #0xed
	cmpne r0, #0xef
	cmpne r0, #0xf7
	cmpne r0, #0xf9
	cmpne r0, #0xfb
	ldreq r0, [r4, #0x20]
	orreq r0, r0, #1
	streq r0, [r4, #0x20]
	ldrh r0, [r7, #2]
	cmp r0, #0xef
	bhi _02183DB0
	add r0, r0, #0x314
	add r0, r0, #0xfc00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	movhi r3, #0x30
	subhi r5, r3, #0x39
	mvnhi r2, #0x2f
	bhi _02183D68
	mvn r2, #0x17
	mov r3, #0x20
	mov r5, #8
_02183D68:
	add r0, r4, #0x218
	mov r1, #0
	str r5, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _02183DEC // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _02183DF0 // =WaterGrindTrigger__OnDefend
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	orr r0, r0, #0xc0
	bic r0, r0, #4
	str r0, [r4, #0x230]
_02183DB0:
	ldr r0, [r4, #0x18]
	ldr r1, _02183DF4 // =WaterGrindTrigger__State_218477C
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r0, _02183DF8 // =WaterGrindTrigger__Draw
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldrsb r0, [r7, #6]
	bl WaterGrindRail__Create
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02183DE0: .word 0x00001801
_02183DE4: .word StageTask_Main
_02183DE8: .word WaterGun__Destructor
_02183DEC: .word 0x0000FFFE
_02183DF0: .word WaterGrindTrigger__OnDefend
_02183DF4: .word WaterGrindTrigger__State_218477C
_02183DF8: .word WaterGrindTrigger__Draw
	arm_func_end WaterGrindTrigger__Create

	arm_func_start WaterGun__Destructor
WaterGun__Destructor: // 0x02183DFC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x340]
	ldrsb r0, [r0, #6]
	bl WaterGrindRail__Func_2184D34
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	add r0, r0, #0x16
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _02183EAC
	ldr r0, [r4, #0x138]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	ldr r1, [r4, #0xf4]
	ldr r0, _02183EB8 // =WaterGun__State_2184248
	cmp r1, r0
	ldrne r0, _02183EBC // =WaterGun__State_21842A8
	cmpne r1, r0
	bne _02183EAC
	ldr r1, [r4, #0x340]
	ldr r0, _02183EC0 // =_0218A3CC
	ldrsb r1, [r1, #6]
	mov r3, #1
	ldr r2, [r0, #8]
	mvn r1, r3, lsl r1
	and r1, r2, r1
	str r1, [r0, #8]
	ldr r1, [r4, #0x340]
	ldr r2, [r0, #4]
	ldrsb r1, [r1, #6]
	mvn r1, r3, lsl r1
	and r1, r2, r1
	str r1, [r0, #4]
	ldr r1, [r4, #0x340]
	ldr r2, [r0]
	ldrsb r1, [r1, #6]
	mvn r1, r3, lsl r1
	and r1, r2, r1
	str r1, [r0]
_02183EAC:
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02183EB8: .word WaterGun__State_2184248
_02183EBC: .word WaterGun__State_21842A8
_02183EC0: .word _0218A3CC
	arm_func_end WaterGun__Destructor

	arm_func_start WaterGun__State_2183EC4
WaterGun__State_2183EC4: // 0x02183EC4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r2, [r4, #0x35c]
	ldr r1, [r2, #0x6d8]
	cmp r1, r4
	beq _02183F18
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r1, [r4, #0x18]
	mov r0, #0
	bic r1, r1, #0x12
	str r1, [r4, #0x18]
	str r4, [r4, #0x234]
	ldr r1, [r4, #0x230]
	add sp, sp, #8
	bic r1, r1, #0x800
	str r1, [r4, #0x230]
	str r0, [r4, #0xf4]
	str r0, [r4, #0x35c]
	ldmia sp!, {r4, pc}
_02183F18:
	add r1, r2, #0x700
	ldrh r1, [r1, #0x22]
	tst r1, #3
	beq _02183F9C
	mov ip, #0
	ldr r1, _0218409C // =WaterGun__State_21840B4
	str ip, [r4, #0x2c]
	str r1, [r4, #0xf4]
	ldr r0, _021840A0 // =WaterGun__Draw
	sub r1, ip, #1
	str r0, [r4, #0xfc]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x40
	str r0, [r4, #0x20]
	str r4, [r4, #0x274]
	ldr r2, [r4, #0x270]
	mov r0, #0x11c
	bic r2, r2, #0x800
	str r2, [r4, #0x270]
	ldr r3, [r4, #0x354]
	mov r2, r1
	bic r3, r3, #1
	str r3, [r4, #0x354]
	str ip, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02183F9C:
	ldr r1, [r4, #0x2c]
	add r1, r1, #1
	str r1, [r4, #0x2c]
	tst r1, #0x1f
	bne _02184010
	tst r1, #0x20
	beq _02183FCC
	mov r1, #1
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x24]
	orr r0, r0, #2
	b _02183FDC
_02183FCC:
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x24]
	bic r0, r0, #2
_02183FDC:
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x354]
	ldr ip, _021840A4 // =0x0000011B
	orr r0, r0, #1
	sub r1, ip, #0x11c
	str r0, [r4, #0x354]
	mov r0, #8
	str r0, [r4, #0x28]
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
_02184010:
	ldr r0, [r4, #0x354]
	tst r0, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r3, _021840A8 // =_mt_math_rand
	ldr r1, _021840AC // =0x00196225
	ldr r0, [r3]
	ldr r2, _021840B0 // =0x3C6EF35F
	mla ip, r0, r1, r2
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	sub r0, r0, #1
	str ip, [r3]
	mov r0, r0, lsl #0xc
	str r0, [r4, #0x50]
	ldr r0, [r3]
	mla r1, r0, r1, r2
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	sub r0, r0, #1
	str r1, [r3]
	mov r0, r0, lsl #0xc
	str r0, [r4, #0x54]
	ldr r0, [r4, #0x28]
	subs r0, r0, #1
	str r0, [r4, #0x28]
	ldreq r0, [r4, #0x354]
	biceq r0, r0, #1
	streq r0, [r4, #0x354]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0218409C: .word WaterGun__State_21840B4
_021840A0: .word WaterGun__Draw
_021840A4: .word 0x0000011B
_021840A8: .word _mt_math_rand
_021840AC: .word 0x00196225
_021840B0: .word 0x3C6EF35F
	arm_func_end WaterGun__State_2183EC4

	arm_func_start WaterGun__State_21840B4
WaterGun__State_21840B4: // 0x021840B4
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, [r4, #0x2c]
	add r0, r0, #0x10000
	str r0, [r4, #0x2c]
	cmp r0, #0xc0000
	blt _02184228
	ldr r1, [r4, #0x340]
	ldr r0, _02184234 // =_0218A3CC
	ldrsb r1, [r1, #6]
	ldr r2, [r0, #8]
	mov r3, #1
	orr r1, r2, r3, lsl r1
	str r1, [r0, #8]
	ldr r1, [r4, #0x340]
	ldr r2, [r0, #4]
	ldrsb r1, [r1, #6]
	mvn r1, r3, lsl r1
	and r2, r2, r1
	str r2, [r0, #4]
	ldr r1, [r4, #0x128]
	ldrh r1, [r1, #0xc]
	cmp r1, #1
	bne _02184124
	ldr r1, [r4, #0x340]
	ldrsb r1, [r1, #6]
	orr r1, r2, r3, lsl r1
	str r1, [r0, #4]
_02184124:
	ldr r1, [r4, #0x340]
	ldr r0, _02184234 // =_0218A3CC
	ldrsb r1, [r1, #6]
	ldr r3, [r0]
	mov r2, #1
	orr r1, r3, r2, lsl r1
	str r1, [r0]
	ldr r0, [r4, #0x340]
	ldrb r1, [r0, #9]
	ldrb r0, [r0, #8]
	add r0, r1, r0
	movs r0, r0, lsl #1
	str r0, [r4, #0x2c]
	moveq r0, #0x384
	streq r0, [r4, #0x2c]
	ldr r0, [r4, #0x128]
	ldr r1, [r4, #0x13c]
	ldrh r0, [r0, #0xc]
	cmp r0, #0
	bne _021841B4
	ldr r5, [r1, #0x58]
	mov r0, #0xc1
	bl GetObjectFileWork
	cmp r5, r0
	beq _021841F0
	mov r0, r5
	bl ObjDataRelease
	mov r0, #0xc1
	bl GetObjectFileWork
	ldr r1, _02184238 // =gameArchiveStage
	mov r2, r0
	ldr r3, [r1]
	ldr r1, _0218423C // =aDfGmkWaterGrai
	mov r0, r4
	bl ObjObjectCollisionDifSet
	b _021841F0
_021841B4:
	ldr r5, [r1, #0x58]
	mov r0, #0xc2
	bl GetObjectFileWork
	cmp r5, r0
	beq _021841F0
	mov r0, r5
	bl ObjDataRelease
	mov r0, #0xc2
	bl GetObjectFileWork
	ldr r1, _02184238 // =gameArchiveStage
	mov r2, r0
	ldr r3, [r1]
	ldr r1, _02184240 // =aDfGmkWaterGrai_0
	mov r0, r4
	bl ObjObjectCollisionDifSet
_021841F0:
	mov r2, #0
	str r2, [r4, #0x274]
	ldr r1, [r4, #0x270]
	ldr r0, _02184244 // =WaterGun__State_2184248
	orr r1, r1, #0x800
	str r1, [r4, #0x270]
	str r0, [r4, #0xf4]
	str r2, [r4, #0xfc]
	ldr r0, [r4, #0x20]
	bic r0, r0, #0x40
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x24]
	orr r0, r0, #1
	str r0, [r4, #0x24]
_02184228:
	mov r0, r4
	bl WaterGun__Func_218448C
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02184234: .word _0218A3CC
_02184238: .word gameArchiveStage
_0218423C: .word aDfGmkWaterGrai
_02184240: .word aDfGmkWaterGrai_0
_02184244: .word WaterGun__State_2184248
	arm_func_end WaterGun__State_21840B4

	arm_func_start WaterGun__State_2184248
WaterGun__State_2184248: // 0x02184248
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WaterGun__Func_218448C
	ldr r0, [r4, #0x2c]
	subs r0, r0, #1
	str r0, [r4, #0x2c]
	bne _0218427C
	mov r0, r4
	bl WaterGun__State_21842A8
	ldr r0, [r4, #0x138]
	mov r1, #0xf
	bl NNS_SndPlayerStopSeq
	ldmia sp!, {r4, pc}
_0218427C:
	cmp r0, #0x3c
	ldmgeia sp!, {r4, pc}
	ldr r1, [r4, #0x340]
	ldr r0, _021842A4 // =_0218A3CC
	ldrsb r1, [r1, #6]
	ldr r3, [r0]
	mov r2, #1
	eor r1, r3, r2, lsl r1
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021842A4: .word _0218A3CC
	arm_func_end WaterGun__State_2184248

	arm_func_start WaterGun__State_21842A8
WaterGun__State_21842A8: // 0x021842A8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x340]
	ldrsb r0, [r0, #6]
	bl WaterGrindRail__GetAnimator
	ldr r1, [r4, #0x340]
	ldr r0, _021843CC // =_0218A3CC
	ldrsb r1, [r1, #6]
	mov r3, #1
	ldr r2, [r0, #8]
	mvn r1, r3, lsl r1
	and r1, r2, r1
	str r1, [r0, #8]
	ldr r1, [r4, #0x340]
	ldr r2, [r0, #4]
	ldrsb r1, [r1, #6]
	mvn r1, r3, lsl r1
	and r1, r2, r1
	str r1, [r0, #4]
	ldr r1, [r4, #0x340]
	ldr r2, [r0]
	ldrsb r1, [r1, #6]
	mvn r1, r3, lsl r1
	and r1, r2, r1
	str r1, [r0]
	ldr r0, [r4, #0x128]
	ldrh r0, [r0, #0xc]
	cmp r0, #0
	beq _0218439C
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x13c]
	ldr r0, [r0, #0x58]
	bl ObjDataRelease
	mov r0, #0xc1
	bl GetObjectFileWork
	ldr r1, _021843D0 // =gameArchiveStage
	mov r2, r0
	ldr r3, [r1]
	ldr r1, _021843D4 // =aDfGmkWaterGrai
	mov r0, r4
	bl ObjObjectCollisionDifSet
	mov r0, #0
	ldr r1, _021843D8 // =0x0000011B
	str r0, [sp]
	str r1, [sp, #4]
	sub r1, r1, #0x11c
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, _021843DC // =defaultSfxPlayer
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r1, _021843E0 // =WaterGun__State_21843E4
	mov r0, #4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	str r0, [r4, #0x28]
	ldmia sp!, {r4, pc}
_0218439C:
	ldr r1, [r4, #0x18]
	mov r0, #0
	bic r1, r1, #0x10
	str r1, [r4, #0x18]
	str r4, [r4, #0x234]
	ldr r1, [r4, #0x230]
	bic r1, r1, #0x800
	str r1, [r4, #0x230]
	str r0, [r4, #0xf4]
	str r0, [r4, #0x35c]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021843CC: .word _0218A3CC
_021843D0: .word gameArchiveStage
_021843D4: .word aDfGmkWaterGrai
_021843D8: .word 0x0000011B
_021843DC: .word defaultSfxPlayer
_021843E0: .word WaterGun__State_21843E4
	arm_func_end WaterGun__State_21842A8

	arm_func_start WaterGun__State_21843E4
WaterGun__State_21843E4: // 0x021843E4
	stmdb sp!, {r3, lr}
	ldr ip, _02184480 // =_mt_math_rand
	ldr r2, _02184484 // =0x00196225
	ldr r1, [ip]
	ldr r3, _02184488 // =0x3C6EF35F
	mla lr, r1, r2, r3
	mov r1, lr, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #3
	sub r1, r1, #1
	str lr, [ip]
	mov r1, r1, lsl #0xc
	str r1, [r0, #0x50]
	ldr r1, [ip]
	mla r2, r1, r2, r3
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #3
	sub r1, r1, #1
	str r2, [ip]
	mov r1, r1, lsl #0xc
	str r1, [r0, #0x54]
	ldr r1, [r0, #0x28]
	subs r1, r1, #1
	str r1, [r0, #0x28]
	ldmneia sp!, {r3, pc}
	ldr r2, [r0, #0x18]
	mov r1, #0
	bic r2, r2, #0x10
	str r2, [r0, #0x18]
	str r0, [r0, #0x234]
	ldr r2, [r0, #0x230]
	bic r2, r2, #0x800
	str r2, [r0, #0x230]
	str r1, [r0, #0xf4]
	str r1, [r0, #0x35c]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02184480: .word _mt_math_rand
_02184484: .word 0x00196225
_02184488: .word 0x3C6EF35F
	arm_func_end WaterGun__State_21843E4

	arm_func_start WaterGun__Func_218448C
WaterGun__Func_218448C: // 0x0218448C
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov lr, r0
	add r0, lr, #0x44
	ldr r3, _021844E4 // =gPlayer
	add ip, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r1, [r3]
	ldr r0, [sp]
	ldr r1, [r1, #0x44]
	cmp r1, r0
	blt _021844D0
	add r0, r0, #0x200000
	cmp r1, r0
	strle r1, [sp]
	strgt r0, [sp]
_021844D0:
	ldr r0, [lr, #0x138]
	add r1, sp, #0
	bl ProcessSpatialSfx
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_021844E4: .word gPlayer
	arm_func_end WaterGun__Func_218448C

	arm_func_start WaterGun__Draw
WaterGun__Draw: // 0x021844E8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x28
	mov r0, #0
	str r0, [sp, #0xc]
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x128]
	ldrh r0, [r0, #0xc]
	cmp r0, #0
	ldr r0, [r4, #0x20]
	bne _02184558
	tst r0, #1
	mov r0, #0x50000
	streq r0, [sp, #0x10]
	moveq r8, #0x20000
	beq _02184534
	rsb r0, r0, #0
	str r0, [sp, #0x10]
	add r8, r0, #0x30000
_02184534:
	ldr r0, [r4, #0x340]
	mov fp, #0x18000
	ldrsb r0, [r0, #6]
	rsb fp, fp, #0
	mov sb, #0
	mov r6, #0x20000
	bl WaterGrindRail__GetAnimator
	mov r5, r0
	b _02184598
_02184558:
	tst r0, #1
	mov r0, #0x48000
	streq r0, [sp, #0x10]
	moveq r8, #0x30000
	beq _02184578
	rsb r0, r0, #0
	str r0, [sp, #0x10]
	add r8, r0, #0x18000
_02184578:
	ldr r0, [r4, #0x340]
	mov fp, #0x39000
	ldrsb r0, [r0, #6]
	rsb fp, fp, #0
	add sb, fp, #0x29000
	mov r6, #0x30000
	bl WaterGrindRail__GetAnimator
	add r5, r0, #0xa4
_02184598:
	ldr r0, [r4, #0x2c]
	mov r1, r6, asr #0xc
	mov r0, r0, asr #0xc
	bl FX_DivS32
	mov r7, r0
	mul r0, r7, r6
	ldr r1, [r4, #0x2c]
	subs sl, r1, r0
	beq _021845F4
	ldr r0, [r4, #0x20]
	sub sl, r6, sl
	tst r0, #1
	rsbeq sl, sl, #0
	mov r0, sl
	mov r1, r8
	add r7, r7, #1
	bl FX_Div
	smull r1, r0, sb, r0
	adds r2, r1, #0x800
	adc r1, r0, #0
	mov r0, r2, lsr #0xc
	orr r0, r0, r1, lsl #20
	str r0, [sp, #0xc]
_021845F4:
	ldr r0, [r4, #0x20]
	mov r6, #0
	and r0, r0, #1
	orr r0, r0, #0x1100
	str r0, [sp, #0x18]
	ldr r1, [r4, #0x44]
	ldr r0, [sp, #0x10]
	cmp r7, #0
	add r0, r1, r0
	add r0, sl, r0
	str r0, [sp, #0x1c]
	ldr r0, [r4, #0x48]
	add r1, r0, fp
	ldr r0, [sp, #0xc]
	str r6, [sp, #0x24]
	add r0, r0, r1
	str r0, [sp, #0x20]
	ldr r0, [r5, #0x3c]
	str r0, [sp, #0x14]
	ble _0218468C
	add sl, sp, #0x18
	mov fp, r6
_0218464C:
	stmia sp, {sl, fp}
	mov r0, r5
	add r1, sp, #0x1c
	mov r2, fp
	str fp, [sp, #8]
	add r3, r4, #0x38
	bl StageTask__Draw2DEx
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x20]
	add r1, r1, r8
	add r0, r0, sb
	add r6, r6, #1
	str r1, [sp, #0x1c]
	str r0, [sp, #0x20]
	cmp r6, r7
	blt _0218464C
_0218468C:
	ldr r2, [sp, #0x1c]
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x14]
	str r0, [r5, #0x3c]
	ldr r0, [r4, #0x44]
	sub r0, r2, r0
	mov r0, r0, asr #0xc
	str r0, [r4, #0x264]
	ldr r0, [r4, #0x48]
	sub r0, r1, r0
	mov r0, r0, asr #0xc
	str r0, [r4, #0x268]
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end WaterGun__Draw

	arm_func_start WaterGun__OnDefend
WaterGun__OnDefend: // 0x021846C4
	stmdb sp!, {r3, lr}
	ldr r2, [r1, #0x1c]
	ldr r3, [r0, #0x1c]
	cmp r2, #0
	cmpne r3, #0
	ldmeqia sp!, {r3, pc}
	ldrh ip, [r3]
	cmp ip, #1
	ldmneia sp!, {r3, pc}
	ldr ip, [r3, #0x114]
	cmp ip, r2
	beq _0218472C
	ldr ip, [r3, #0x1c]
	tst ip, #1
	beq _0218472C
	ldr ip, [r3, #0x20]
	ands lr, ip, #1
	beq _02184718
	ldr ip, [r2, #0x20]
	tst ip, #1
	bne _02184734
_02184718:
	cmp lr, #0
	bne _0218472C
	ldr ip, [r2, #0x20]
	tst ip, #1
	beq _02184734
_0218472C:
	bl ObjRect__FuncNoHit
	ldmia sp!, {r3, pc}
_02184734:
	str r3, [r2, #0x35c]
	ldr r0, [r2, #0x18]
	mov r1, #0
	orr r0, r0, #0x10
	str r0, [r2, #0x18]
	str r1, [r2, #0x234]
	ldr r0, [r2, #0x230]
	ldr ip, _02184778 // =WaterGun__State_2183EC4
	orr r0, r0, #0x800
	str r0, [r2, #0x230]
	str r1, [r2, #0x2c]
	str r1, [r2, #0x24]
	mov r0, r3
	mov r1, r2
	str ip, [r2, #0xf4]
	bl Player__Gimmick_20246FC
	ldmia sp!, {r3, pc}
	.align 2, 0
_02184778: .word WaterGun__State_2183EC4
	arm_func_end WaterGun__OnDefend

	arm_func_start WaterGrindTrigger__State_218477C
WaterGrindTrigger__State_218477C: // 0x0218477C
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x340]
	ldr r2, _0218487C // =_0218A3CC
	ldrsb ip, [r1, #6]
	ldr r3, [r2, #8]
	mov lr, #1
	tst r3, lr, lsl ip
	ldmeqia sp!, {r3, pc}
	ldr r2, [r2, #4]
	tst r2, lr, lsl ip
	ldrh r2, [r1, #2]
	beq _021847F8
	cmp r2, #0xec
	cmpne r2, #0xed
	ldmeqia sp!, {r3, pc}
	add r3, r2, #0xa
	add r3, r3, #0xff00
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	cmp r3, #1
	ldmlsia sp!, {r3, pc}
	add r3, r2, #6
	add r3, r3, #0xff00
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	cmp r3, #1
	bhi _02184840
	ldrh r1, [r1, #4]
	tst r1, #1
	bne _02184840
	ldmia sp!, {r3, pc}
_021847F8:
	cmp r2, #0xee
	cmpne r2, #0xef
	ldmeqia sp!, {r3, pc}
	add r3, r2, #0x308
	add r3, r3, #0xfc00
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	cmp r3, #1
	ldmlsia sp!, {r3, pc}
	add r3, r2, #6
	add r3, r3, #0xff00
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	cmp r3, #1
	bhi _02184840
	ldrh r1, [r1, #4]
	tst r1, #1
	ldmneia sp!, {r3, pc}
_02184840:
	cmp r2, #0xef
	bhi _02184864
	str r0, [r0, #0x234]
	ldr r1, [r0, #0x230]
	orr r1, r1, #4
	str r1, [r0, #0x230]
	ldr r1, [r0, #0x18]
	bic r1, r1, #2
	str r1, [r0, #0x18]
_02184864:
	ldr r2, [r0, #0x20]
	mov r1, #0
	bic r2, r2, #0x20
	str r2, [r0, #0x20]
	str r1, [r0, #0xf4]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0218487C: .word _0218A3CC
	arm_func_end WaterGrindTrigger__State_218477C

	arm_func_start WaterGrindTrigger__Draw
WaterGrindTrigger__Draw: // 0x02184880
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x340]
	ldr r0, _021849B0 // =_0218A3CC
	ldrsb r3, [r1, #6]
	ldr r1, [r0, #8]
	mov r2, #1
	tst r1, r2, lsl r3
	bne _021848E8
	mov r0, #0
	str r0, [r4, #0x234]
	ldr r1, [r4, #0x230]
	ldr r0, _021849B4 // =WaterGrindTrigger__State_218477C
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x18]
	add sp, sp, #0xc
	orr r1, r1, #2
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x20
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	ldmia sp!, {r3, r4, r5, r6, pc}
_021848E8:
	ldr r0, [r0]
	tst r0, r2, lsl r3
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	mov r0, r3, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WaterGrindRail__GetAnimator
	ldr r1, [r4, #0x340]
	mov r5, r0
	ldrh r0, [r1, #2]
	sub r0, r0, #0xec
	cmp r0, #0xf
	addls pc, pc, r0, lsl #2
	b _0218497C
_02184920: // jump table
	b _0218497C // case 0
	b _0218497C // case 1
	b _02184960 // case 2
	b _02184960 // case 3
	b _0218497C // case 4
	b _0218497C // case 5
	b _0218497C // case 6
	b _0218497C // case 7
	b _0218497C // case 8
	b _0218497C // case 9
	b _02184970 // case 10
	b _02184970 // case 11
	b _02184978 // case 12
	b _02184978 // case 13
	b _02184968 // case 14
	b _02184968 // case 15
_02184960:
	add r5, r5, #0xa4
	b _0218497C
_02184968:
	add r5, r5, #0x148
	b _0218497C
_02184970:
	add r5, r5, #0x1ec
	b _0218497C
_02184978:
	add r5, r5, #0x290
_0218497C:
	ldr r6, [r5, #0x3c]
	add r0, r4, #0x20
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r0, r5
	add r1, r4, #0x44
	add r3, r4, #0x38
	str r2, [sp, #8]
	bl StageTask__Draw2DEx
	str r6, [r5, #0x3c]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_021849B0: .word _0218A3CC
_021849B4: .word WaterGrindTrigger__State_218477C
	arm_func_end WaterGrindTrigger__Draw

	arm_func_start WaterGrindTrigger__OnDefend
WaterGrindTrigger__OnDefend: // 0x021849B8
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x18]
	bic r0, r0, #1
	str r0, [r5, #0x18]
	ldr r0, [r5, #0x5dc]
	orr r0, r0, #0x10000
	str r0, [r5, #0x5dc]
	ldr r0, [r4, #0x340]
	ldrb r1, [r5, #0x710]
	ldrh r0, [r0, #4]
	bic r1, r1, #0x80
	add r0, r0, #1
	cmp r1, r0
	beq _02184AA0
	add r0, r5, #0x500
	ldrsh r0, [r0, #0xd4]
	cmp r0, #0x1b
	blt _02184A28
	cmp r0, #0x21
	ble _02184AA0
_02184A28:
	ldr r0, [r5, #0x1c]
	tst r0, #1
	beq _02184AA0
	ldrb r0, [r5, #0x711]
	tst r0, #2
	bne _02184AA0
	orr r0, r0, #3
	strb r0, [r5, #0x711]
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #4]
	and r0, r0, #0x3f
	add r0, r0, #1
	strb r0, [r5, #0x710]
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	sub r0, r0, #0xec
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02184A84
_02184A74: // jump table
	b _02184A84 // case 0
	b _02184A8C // case 1
	b _02184A84 // case 2
	b _02184A8C // case 3
_02184A84:
	ldr r1, [r5, #0x604]
	b _02184A94
_02184A8C:
	ldr r0, [r5, #0x604]
	rsb r1, r0, #0
_02184A94:
	mov r0, r5
	mov r2, #0
	bl Player__UseDashPanel
_02184AA0:
	ldr r0, [r5, #0x5dc]
	orr r0, r0, #4
	str r0, [r5, #0x5dc]
	ldr r0, [r5, #0x1c]
	tst r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	sub r0, r0, #0xec
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02184AE0
_02184AD0: // jump table
	b _02184AE0 // case 0
	b _02184B04 // case 1
	b _02184AE0 // case 2
	b _02184B04 // case 3
_02184AE0:
	ldr r0, [r5, #0xc8]
	cmp r0, #0x2000
	ldmgeia sp!, {r3, r4, r5, pc}
	mov r0, #0x2000
	str r0, [r5, #0xc8]
	ldr r0, [r5, #0x20]
	bic r0, r0, #1
	str r0, [r5, #0x20]
	ldmia sp!, {r3, r4, r5, pc}
_02184B04:
	mov r0, #0x2000
	ldr r1, [r5, #0xc8]
	rsb r0, r0, #0
	cmp r1, r0
	ldmleia sp!, {r3, r4, r5, pc}
	str r0, [r5, #0xc8]
	ldr r0, [r5, #0x20]
	orr r0, r0, #1
	str r0, [r5, #0x20]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end WaterGrindTrigger__OnDefend

	arm_func_start WaterGrindRail__Create
WaterGrindRail__Create: // 0x02184B2C
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0xc
	ldr r1, _02184D14 // =Task__Unknown2184B2C__Singleton
	mov r4, r0
	ldr r0, [r1, r4, lsl #2]
	cmp r0, #0
	beq _02184B68
	bl GetTaskWork_
	add r1, r0, #0x400
	ldrh r2, [r1, #0x9e]
	add sp, sp, #0xc
	add r0, r0, #0x168
	add r2, r2, #1
	strh r2, [r1, #0x9e]
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_02184B68:
	ldr r0, _02184D18 // =0x000010F6
	mov r2, #0
	str r0, [sp]
	mov r5, #2
	str r5, [sp, #4]
	mov r5, #0x4a0
	ldr r0, _02184D1C // =StageTask_Main
	ldr r1, _02184D20 // =WaterGrindRail__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r5, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr r1, _02184D14 // =Task__Unknown2184B2C__Singleton
	mov r0, r5
	str r5, [r1, r4, lsl #2]
	bl GetTaskWork_
	mov r1, #0
	mov r2, #0x4a0
	mov sl, r0
	bl MI_CpuFill8
	mov r0, #0xa
	mul r0, r4, r0
	add r8, r0, #0xad
	mov r1, #4
	strh r1, [sl]
	add r0, sl, #0x400
	strh r4, [r0, #0x9c]
	ldrh r1, [r0, #0x9e]
	ldr r7, _02184D24 // =_02189D28
	ldr r4, _02184D28 // =gameArchiveStage
	add r1, r1, #1
	strh r1, [r0, #0x9e]
	ldr r0, [sl, #0x1c]
	add r6, sl, #0x168
	orr r0, r0, #0x2100
	str r0, [sl, #0x1c]
	ldr r0, [sl, #0x20]
	add sb, r8, #1
	orr r0, r0, #0x20
	mov r5, #0
	str r0, [sl, #0x20]
	mov fp, #0xac
_02184C28:
	mov r0, fp
	bl GetObjectFileWork
	ldr r1, [r4]
	mov r3, r0
	str r1, [sp]
	ldr r1, _02184D2C // =aActAcGmkWaterG
	mov r0, r6
	mov r2, #0
	bl ObjAction2dBACLoad
	mov r0, r8
	bl GetObjectFileWork
	ldrb r2, [r7]
	mov r1, #0
	bl ObjActionAllocSprite
	str r0, [r6, #0x78]
	mov r0, sb
	bl GetObjectFileWork
	ldrb r2, [r7], #1
	mov r1, #1
	bl ObjActionAllocSprite
	add r1, r5, #2
	str r0, [r6, #0x7c]
	mov r1, r1, lsl #0x10
	ldr r0, [r6, #0x14]
	mov r1, r1, lsr #0x10
	mov r2, #0x5d
	bl ObjDrawAllocSpritePalette
	strh r0, [r6, #0x50]
	ldrh r2, [r6, #0x50]
	add r1, r5, #2
	mov r1, r1, lsl #0x10
	strh r2, [r6, #0x92]
	strh r2, [r6, #0x90]
	ldr r2, [r6, #0x3c]
	mov r0, r6
	orr r2, r2, #0x14
	mov r1, r1, lsr #0x10
	str r2, [r6, #0x3c]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r6
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r6
	mov r1, #2
	bl StageTask__SetOAMPriority
	add r5, r5, #1
	add r8, r8, #2
	add sb, sb, #2
	cmp r5, #5
	add r6, r6, #0xa4
	blt _02184C28
	add r0, sl, #0x2b0
	mov r1, #0x16
	bl StageTask__SetOAMOrder
	ldr r1, _02184D30 // =WaterGrindRail__Draw
	add r0, sl, #0x168
	str r1, [sl, #0xfc]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02184D14: .word Task__Unknown2184B2C__Singleton
_02184D18: .word 0x000010F6
_02184D1C: .word StageTask_Main
_02184D20: .word WaterGrindRail__Destructor
_02184D24: .word _02189D28
_02184D28: .word gameArchiveStage
_02184D2C: .word aActAcGmkWaterG
_02184D30: .word WaterGrindRail__Draw
	arm_func_end WaterGrindRail__Create

	arm_func_start WaterGrindRail__Func_2184D34
WaterGrindRail__Func_2184D34: // 0x02184D34
	stmdb sp!, {r3, lr}
	ldr r1, _02184D7C // =Task__Unknown2184B2C__Singleton
	ldr r0, [r1, r0, lsl #2]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetTaskWork_
	add r1, r0, #0x400
	ldrh r2, [r1, #0x9e]
	sub r2, r2, #1
	strh r2, [r1, #0x9e]
	ldrh r1, [r1, #0x9e]
	cmp r1, #0
	ldmneia sp!, {r3, pc}
	ldr r1, [r0, #0x18]
	orr r1, r1, #8
	str r1, [r0, #0x18]
	bl WaterGrindRail__Func_2184DB8
	ldmia sp!, {r3, pc}
	.align 2, 0
_02184D7C: .word Task__Unknown2184B2C__Singleton
	arm_func_end WaterGrindRail__Func_2184D34

	arm_func_start WaterGrindRail__Destructor
WaterGrindRail__Destructor: // 0x02184D80
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	add r1, r0, #0x400
	ldrh r2, [r1, #0x9c]
	ldr r1, _02184DB4 // =Task__Unknown2184B2C__Singleton
	ldr r1, [r1, r2, lsl #2]
	cmp r1, r4
	bne _02184DA8
	bl WaterGrindRail__Func_2184DB8
_02184DA8:
	mov r0, r4
	bl StageTask_Destructor
	ldmia sp!, {r4, pc}
	.align 2, 0
_02184DB4: .word Task__Unknown2184B2C__Singleton
	arm_func_end WaterGrindRail__Destructor

	arm_func_start WaterGrindRail__Func_2184DB8
WaterGrindRail__Func_2184DB8: // 0x02184DB8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	mov r5, r0
	add r0, r5, #0x400
	ldrh r1, [r0, #0x9c]
	mov r0, #0xa
	mov r8, #0
	mul r0, r1, r0
	add r4, r5, #0x168
	add sb, r0, #0xad
	mov r7, r8
	mov r6, #0xac
_02184DE4:
	ldrh r0, [r4, #0x50]
	and r0, r0, #0xff
	bl ObjDrawReleaseSpritePalette
	mov r0, sb
	bl GetObjectFileWork
	bl ObjActionReleaseSpriteDS
	str r7, [r4, #0x78]
	mov r0, r6
	str r7, [r4, #0x7c]
	bl GetObjectFileWork
	mov r1, r4
	bl ObjAction2dBACRelease
	add r8, r8, #1
	cmp r8, #5
	add sb, sb, #2
	add r4, r4, #0xa4
	blt _02184DE4
	add r0, r5, #0x400
	ldrh r1, [r0, #0x9c]
	ldr r0, _02184E40 // =Task__Unknown2184B2C__Singleton
	mov r2, #0
	str r2, [r0, r1, lsl #2]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_02184E40: .word Task__Unknown2184B2C__Singleton
	arm_func_end WaterGrindRail__Func_2184DB8

	arm_func_start WaterGrindRail__GetAnimator
WaterGrindRail__GetAnimator: // 0x02184E44
	stmdb sp!, {r3, lr}
	ldr r1, _02184E6C // =Task__Unknown2184B2C__Singleton
	mov r2, #0
	ldr r0, [r1, r0, lsl #2]
	cmp r0, #0
	beq _02184E64
	bl GetTaskWork_
	add r2, r0, #0x168
_02184E64:
	mov r0, r2
	ldmia sp!, {r3, pc}
	.align 2, 0
_02184E6C: .word Task__Unknown2184B2C__Singleton
	arm_func_end WaterGrindRail__GetAnimator

	arm_func_start WaterGrindRail__Draw
WaterGrindRail__Draw: // 0x02184E70
	stmdb sp!, {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r5, #0
	add r6, r0, #0x168
	mov r4, r5
_02184E84:
	mov r0, r6
	mov r1, r4
	mov r2, r4
	bl AnimatorSpriteDS__ProcessAnimation
	add r5, r5, #1
	cmp r5, #5
	add r6, r6, #0xa4
	blt _02184E84
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end WaterGrindRail__Draw

	.data
	
_02189D28:
	.byte 0x08, 0x11, 0x10, 0x33, 0x31, 0x00, 0x00, 0x00

aActAcGmkWaterG: // 0x02189D30
	.asciz "/act/ac_gmk_water_graind.bac"
	.align 4
	
aDfGmkWaterGrai: // 0x02189D50
	.asciz "/df/gmk_water_graind_gun00.df"
	.align 4
	
aDfGmkWaterGrai_0: // 0x02189D70
	.asciz "/df/gmk_water_graind_gun01.df"
	.align 4