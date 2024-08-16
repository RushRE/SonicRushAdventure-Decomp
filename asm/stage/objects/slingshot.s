	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Sling__Create
Sling__Create: // 0x0217F45C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	ldr r3, _0217F758 // =0x000010F6
	mov r7, r0
	str r3, [sp]
	mov r0, #2
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _0217F75C // =0x000004B8
	ldr r0, _0217F760 // =StageTask_Main
	ldr r1, _0217F764 // =Sling__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	ldr r2, _0217F75C // =0x000004B8
	mov r4, r0
	mov r1, #0
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
	ldr r0, _0217F768 // =gameArchiveStage
	mov r1, #0x30
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _0217F76C // =aActAcGmkSlingB
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	ldr r1, [r4, #0x1a4]
	mov r0, r4
	orr r1, r1, #0x200
	str r1, [r4, #0x1a4]
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
	mov r0, #0x9f
	add r5, r4, #0x364
	bl GetObjectFileWork
	ldr r1, _0217F768 // =gameArchiveStage
	mov r3, r0
	ldr r2, [r1]
	ldr r1, _0217F76C // =aActAcGmkSlingB
	str r2, [sp]
	mov r0, r5
	mov r2, #0x24
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
	add r1, r4, #8
	mov r0, #0x9f
	add r5, r1, #0x400
	bl GetObjectFileWork
	ldr r1, _0217F768 // =gameArchiveStage
	mov r3, r0
	ldr r2, [r1]
	ldr r1, _0217F76C // =aActAcGmkSlingB
	str r2, [sp]
	mov r0, r5
	mov r2, #0x14
	bl ObjAction2dBACLoad
	ldr r1, [r4, #0x128]
	mov r0, r5
	ldrh r2, [r1, #0x50]
	mov r1, #2
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
	mov r3, #0
	str r4, [r4, #0x234]
	str r3, [sp]
	add r0, r4, #0x218
	sub r1, r3, #0x98
	sub r2, r3, #0x20
	sub r3, r3, #0x78
	bl ObjRect__SetBox2D
	mov r1, #0
	add r0, r4, #0x218
	mov r2, r1
	bl ObjRect__SetAttackStat
	ldr r1, _0217F770 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _0217F774 // =ovl00_217FB60
	mov r2, #0xf400
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	orr r0, r0, #0x400
	str r0, [r4, #0x230]
	strh r2, [r4, #0x34]
	ldrh r0, [r7, #2]
	cmp r0, #0xd4
	movne r0, #0xa000
	bne _0217F6C0
	ldr r1, [r4, #0x20]
	sub r0, r2, #0x19400
	orr r1, r1, #1
	str r1, [r4, #0x20]
_0217F6C0:
	str r0, [r4, #0x98]
	ldr r0, [r4, #0x340]
	ldrsb r0, [r0, #6]
	cmp r0, #0
	movlt r0, #0
	blt _0217F6E0
	cmp r0, #8
	movgt r0, #8
_0217F6E0:
	mov r0, r0, lsl #0xc
	rsb r0, r0, #0
	sub r1, r0, #0x4000
	mov r0, r4
	str r1, [r4, #0x9c]
	bl ovl00_217FA38
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	str r3, [sp, #0x10]
	ldr r1, [r4, #0x44]
	ldr r2, [r4, #0x48]
	ldr r0, _0217F778 // =0x0000014A
	bl GameObject__SpawnObject
	cmp r0, #0
	beq _0217F73C
	str r4, [r0, #0x11c]
	ldr r1, [r4, #0x2c]
	str r1, [r0, #0x44]
	ldr r1, [r4, #0x28]
	str r1, [r0, #0x48]
_0217F73C:
	ldr r0, _0217F77C // =ovl00_217FBF0
	ldr r1, _0217F780 // =ovl00_217F98C
	str r0, [r4, #0xfc]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0217F758: .word 0x000010F6
_0217F75C: .word 0x000004B8
_0217F760: .word StageTask_Main
_0217F764: .word Sling__Destructor
_0217F768: .word gameArchiveStage
_0217F76C: .word aActAcGmkSlingB
_0217F770: .word 0x0000FFFE
_0217F774: .word ovl00_217FB60
_0217F778: .word 0x0000014A
_0217F77C: .word ovl00_217FBF0
_0217F780: .word ovl00_217F98C
	arm_func_end Sling__Create

	arm_func_start SlingRock__Create
SlingRock__Create: // 0x0217F784
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
	ldr r0, _0217F930 // =StageTask_Main
	ldr r1, _0217F934 // =GameObject__Destructor
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
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0217F938 // =gameArchiveStage
	mov r1, #8
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _0217F93C // =aActAcGmkSlingB
	bl ObjObjectAction2dBACLoad
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
	mov r1, #3
	bl StageTask__SetAnimation
	ldr r1, _0217F940 // =0x00000201
	add r0, r4, #0x200
	strh r1, [r0, #0x4c]
	mov r3, #0x14
	str r3, [sp]
	add r0, r4, #0x218
	sub r1, r3, #0x28
	mov r2, r1
	bl ObjRect__SetBox2D
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, _0217F944 // =0x0000FFFF
	mov r2, #0xff
	bl ObjRect__SetDefenceStat
	mov r0, #0
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	ldr r1, _0217F940 // =0x00000201
	orr r0, r0, #0x820
	str r0, [r4, #0x230]
	add r0, r4, #0x200
	strh r1, [r0, #0x8c]
	mov r3, #0x14
	str r3, [sp]
	add r0, r4, #0x258
	sub r1, r3, #0x28
	mov r2, r1
	bl ObjRect__SetBox2D
	ldr r0, [r4, #0x270]
	ldr r1, _0217F948 // =ovl00_217FD20
	orr r0, r0, #0x820
	str r0, [r4, #0x270]
	ldr r2, [r4, #0x18]
	mov r0, r4
	orr r2, r2, #0x10
	str r2, [r4, #0x18]
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0217F930: .word StageTask_Main
_0217F934: .word GameObject__Destructor
_0217F938: .word gameArchiveStage
_0217F93C: .word aActAcGmkSlingB
_0217F940: .word 0x00000201
_0217F944: .word 0x0000FFFF
_0217F948: .word ovl00_217FD20
	arm_func_end SlingRock__Create

	arm_func_start Sling__Destructor
Sling__Destructor: // 0x0217F94C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x9f
	bl GetObjectFileWork
	add r1, r4, #0x364
	bl ObjAction2dBACRelease
	mov r0, #0x9f
	bl GetObjectFileWork
	add r1, r4, #8
	add r1, r1, #0x400
	bl ObjAction2dBACRelease
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end Sling__Destructor

	arm_func_start ovl00_217F98C
ovl00_217F98C: // 0x0217F98C
	ldr r1, [r0, #0x35c]
	ldr ip, _0217F9AC // =ovl00_217FA38
	cmp r1, #0
	ldrne r1, [r1, #0x6d8]
	cmpne r1, r0
	movne r1, #0
	strne r1, [r0, #0x35c]
	bx ip
	.align 2, 0
_0217F9AC: .word ovl00_217FA38
	arm_func_end ovl00_217F98C

	arm_func_start ovl00_217F9B0
ovl00_217F9B0: // 0x0217F9B0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x35c]
	cmp r0, #0
	ldrne r0, [r0, #0x6d8]
	cmpne r0, r4
	movne r0, #0
	strne r0, [r4, #0x35c]
	add r0, r4, #0x400
	ldrsh r1, [r0, #0xb4]
	sub r1, r1, #0x40
	strh r1, [r0, #0xb4]
	ldrsh r1, [r0, #0xb4]
	cmp r1, #0x300
	movlt r1, #0x300
	strlth r1, [r0, #0xb4]
	add r1, r4, #0x400
	ldrsh r2, [r1, #0xb4]
	ldrh r0, [r4, #0x34]
	mov r1, #0x4000
	bl AkMath__Func_2002D28
	strh r0, [r4, #0x34]
	mov r0, r4
	bl ovl00_217FA38
	ldrh r0, [r4, #0x34]
	cmp r0, #0x4000
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0x24]
	ldr r0, _0217FA34 // =ovl00_217F98C
	orr r1, r1, #1
	str r1, [r4, #0x24]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217FA34: .word ovl00_217F98C
	arm_func_end ovl00_217F9B0

	arm_func_start ovl00_217FA38
ovl00_217FA38: // 0x0217FA38
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	mov r5, r0
	ldr r0, [r5, #0x20]
	tst r0, #1
	beq _0217FA80
	ldrh r0, [r5, #0x34]
	mov r3, #0x1d000
	rsb r3, r3, #0
	rsb r0, r0, #0
	mov r0, r0, lsl #0x10
	mov r2, #0x84000
	mov r1, #0x94000
	str r3, [sp, #0x18]
	str r2, [sp, #0x10]
	str r1, [sp, #8]
	mov r4, r0, lsr #0x10
	b _0217FA9C
_0217FA80:
	ldrh r4, [r5, #0x34]
	mov r2, #0x1d000
	sub r1, r2, #0xa1000
	sub r0, r2, #0xb1000
	str r2, [sp, #0x18]
	str r1, [sp, #0x10]
	str r0, [sp, #8]
_0217FA9C:
	str r4, [sp]
	ldr r0, [sp, #0x18]
	add r2, sp, #0x18
	add r3, sp, #0x14
	mov r1, #0
	bl AkMath__Func_2002C98
	ldr r1, [sp, #0x14]
	mov r0, #0x44000
	sub r1, r1, #0x48000
	rsb r0, r0, #0
	cmp r1, r0
	str r1, [sp, #0x14]
	ldrle r0, [sp, #0x18]
	mov r1, #0x8000
	strle r0, [r5, #0x4ac]
	ldrle r0, [sp, #0x14]
	add r2, sp, #0x10
	str r0, [r5, #0x4b0]
	str r4, [sp]
	ldr r0, [sp, #0x10]
	add r3, sp, #0xc
	rsb r1, r1, #0
	bl AkMath__Func_2002C98
	ldr r1, [r5, #0x44]
	ldr r0, [sp, #0x10]
	add r2, sp, #8
	add r0, r1, r0
	str r0, [r5, #0x2c]
	ldr r1, [r5, #0x48]
	ldr r0, [sp, #0xc]
	add r3, sp, #4
	add r0, r1, r0
	sub r0, r0, #0x48000
	str r0, [r5, #0x28]
	str r4, [sp]
	ldr r0, [sp, #8]
	mov r1, #0x4000
	bl AkMath__Func_2002C98
	ldr r1, [r5, #0x44]
	ldr r0, [sp, #8]
	add r0, r1, r0
	str r0, [r5, #0x8c]
	ldr r1, [r5, #0x48]
	ldr r0, [sp, #4]
	add r0, r1, r0
	sub r0, r0, #0x48000
	str r0, [r5, #0x90]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}
	arm_func_end ovl00_217FA38

	arm_func_start ovl00_217FB60
ovl00_217FB60: // 0x0217FB60
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r4, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r4, #0
	cmpne r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldrh r1, [r0]
	cmp r1, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	mov r1, #0
	str r1, [r4, #0x234]
	ldr r2, [r4, #0x230]
	mov r1, r4
	orr r2, r2, #0x800
	str r2, [r4, #0x230]
	str r0, [r4, #0x35c]
	bl Player__Func_202379C
	mov r0, #0
	add r2, r4, #0x400
	mov ip, #0x500
	ldr r3, _0217FBE8 // =ovl00_217F9B0
	strh ip, [r2, #0xb4]
	sub r1, r0, #1
	str r3, [r4, #0xf4]
	ldr r4, _0217FBEC // =0x0000011A
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217FBE8: .word ovl00_217F9B0
_0217FBEC: .word 0x0000011A
	arm_func_end ovl00_217FB60

	arm_func_start ovl00_217FBF0
ovl00_217FBF0: // 0x0217FBF0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x24
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x20]
	add r0, sp, #0x14
	orr r1, r1, #0x100
	bic r1, r1, #1
	str r1, [sp, #0x14]
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r2, [sp, #8]
	add r0, r4, #0x364
	add r1, r4, #0x44
	add r3, r4, #0x38
	bl StageTask__Draw2DEx
	ldr r1, [sp, #0x14]
	add r0, sp, #0x14
	orr r1, r1, #1
	str r1, [sp, #0x14]
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r2, [sp, #8]
	add r0, r4, #0x364
	add r1, r4, #0x44
	add r3, r4, #0x38
	bl StageTask__Draw2DEx
	ldr r0, [r4, #0x20]
	mov r2, #0
	orr r0, r0, #0x100
	str r0, [sp, #0x14]
	ldr r3, [r4, #0x44]
	ldr r0, [r4, #0x4ac]
	add r1, sp, #0x14
	add r0, r3, r0
	str r0, [sp, #0x18]
	add r0, r4, #8
	ldr ip, [r4, #0x48]
	ldr r3, [r4, #0x4b0]
	add r0, r0, #0x400
	add r3, ip, r3
	str r3, [sp, #0x1c]
	str r2, [sp, #0x20]
	stmia sp, {r1, r2}
	str r2, [sp, #8]
	add r1, sp, #0x18
	add r3, r4, #0x38
	bl StageTask__Draw2DEx
	ldr r1, [r4, #0x44]
	mov r0, #0
	str r1, [sp, #0x18]
	ldr r1, [r4, #0x48]
	add r2, sp, #0xc
	strh r0, [sp, #0xe]
	strh r0, [sp, #0xc]
	sub r0, r1, #0x48000
	str r0, [sp, #0x1c]
	ldr r0, [r4, #0x20]
	add r1, sp, #0x18
	tst r0, #1
	ldrh r0, [r4, #0x34]
	add r3, r4, #0x38
	rsbne r0, r0, #0
	strneh r0, [sp, #0x10]
	streqh r0, [sp, #0x10]
	add r0, r4, #0x20
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [r4, #0x128]
	bl StageTask__Draw2DEx
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, pc}
	arm_func_end ovl00_217FBF0

	arm_func_start ovl00_217FD20
ovl00_217FD20: // 0x0217FD20
	ldr r1, [r0, #0x11c]
	cmp r1, #0
	bxeq lr
	ldr r2, [r0, #0x44]
	str r2, [r0, #0x8c]
	ldr r2, [r0, #0x48]
	str r2, [r0, #0x90]
	ldr r2, [r1, #0x2c]
	str r2, [r0, #0x44]
	ldr r2, [r1, #0x28]
	str r2, [r0, #0x48]
	ldr r3, [r0, #0x44]
	ldr r2, [r0, #0x8c]
	sub r2, r3, r2
	str r2, [r0, #0xbc]
	ldr r3, [r0, #0x48]
	ldr r2, [r0, #0x90]
	sub r2, r3, r2
	str r2, [r0, #0xc0]
	ldr r2, [r1, #0x24]
	tst r2, #1
	bxeq lr
	ldr r3, _0217FE60 // =ovl00_217FE64
	mov r2, #0
	str r3, [r0, #0xf4]
	str r2, [r0, #0x11c]
	ldr r2, [r0, #0x1c]
	bic r2, r2, #0x2100
	orr r2, r2, #0x80
	str r2, [r0, #0x1c]
	ldr r2, [r0, #0x20]
	bic r2, r2, #0x100
	str r2, [r0, #0x20]
	ldr r2, [r0, #0x18]
	bic r2, r2, #0x10
	str r2, [r0, #0x18]
	ldr r2, [r1, #0x98]
	str r2, [r0, #0x98]
	ldr r2, [r1, #0x9c]
	str r2, [r0, #0x9c]
	ldr r2, [r1, #0x35c]
	cmp r2, #0
	beq _0217FE2C
	ldr r2, [r2, #0x5d8]
	tst r2, #0x80
	beq _0217FE04
	ldr ip, [r1, #0x98]
	ldr r3, [r0, #0x98]
	mov r2, ip, asr #4
	add r2, r2, ip, asr #3
	add r2, r3, r2
	str r2, [r0, #0x98]
	ldr r2, [r0, #0x9c]
	ldr r1, [r1, #0x9c]
	add r1, r2, r1, asr #4
	str r1, [r0, #0x9c]
	b _0217FE2C
_0217FE04:
	tst r2, #0x100
	beq _0217FE2C
	ldr r3, [r0, #0x98]
	ldr r2, [r1, #0x98]
	add r2, r3, r2, asr #4
	str r2, [r0, #0x98]
	ldr r2, [r0, #0x9c]
	ldr r1, [r1, #0x9c]
	add r1, r2, r1, asr #4
	str r1, [r0, #0x9c]
_0217FE2C:
	str r0, [r0, #0x234]
	ldr r2, [r0, #0x230]
	mov r1, #0
	bic r2, r2, #0x800
	orr r2, r2, #4
	str r2, [r0, #0x230]
	str r0, [r0, #0x274]
	ldr r2, [r0, #0x270]
	bic r2, r2, #0x800
	orr r2, r2, #4
	str r2, [r0, #0x270]
	str r1, [r0, #0x2d8]
	bx lr
	.align 2, 0
_0217FE60: .word ovl00_217FE64
	arm_func_end ovl00_217FD20

	arm_func_start ovl00_217FE64
ovl00_217FE64: // 0x0217FE64
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	ldrh r1, [r4, #0x34]
	ldr r0, [r4, #0x98]
	add r0, r1, r0, asr #4
	strh r0, [r4, #0x34]
	ldr r0, [r4, #0x1c]
	tst r0, #0xf
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x18]
	mov lr, #0
	orr r0, r0, #4
	ldr r3, _0217FFF8 // =_mt_math_rand
	str r0, [r4, #0x18]
	ldr r5, [r3]
	ldr r0, _0217FFFC // =0x00196225
	ldr r1, _02180000 // =0x3C6EF35F
	sub r2, lr, #0x2000
	mla ip, r5, r0, r1
	mla r0, ip, r0, r1
	str r0, [r3]
	str lr, [sp]
	ldr r0, [r3]
	mov r3, ip, lsr #0x10
	mov r1, r0, lsr #0x10
	mov r0, r3, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	mov ip, r0, lsl #0x19
	mov r5, r3, lsl #0x19
	sub r3, lr, #0x3000
	ldr r0, [r4, #0x44]
	ldr r1, [r4, #0x48]
	sub r2, r2, ip, lsr #21
	sub r3, r3, r5, lsr #21
	bl EffectSlingDust__Create
	ldr r2, _0217FFF8 // =_mt_math_rand
	ldr r0, _0217FFFC // =0x00196225
	ldr r5, [r2]
	ldr r1, _02180000 // =0x3C6EF35F
	mov r3, #1
	mla ip, r5, r0, r1
	mla r0, ip, r0, r1
	str r0, [r2]
	str r3, [sp]
	ldr r0, [r2]
	mov r2, ip, lsr #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsl #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r5, r0, lsr #0x10
	mov r0, r1, lsl #0x19
	mov r3, #0x4000
	mov r2, r0, lsr #0x15
	mov r5, r5, lsl #0x19
	rsb r3, r3, #0
	ldr r0, [r4, #0x44]
	ldr r1, [r4, #0x48]
	add r2, r2, #0x2000
	sub r3, r3, r5, lsr #21
	bl EffectSlingDust__Create
	ldr r3, _0217FFF8 // =_mt_math_rand
	mov r2, #0x4000
	ldr lr, [r3]
	ldr r0, _0217FFFC // =0x00196225
	ldr r1, _02180000 // =0x3C6EF35F
	mov ip, #1
	mla r5, lr, r0, r1
	mla r0, r5, r0, r1
	str r0, [r3]
	str ip, [sp]
	ldr r0, [r3]
	mov r3, r5, lsr #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsl #0x10
	mov r0, r3, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r3, r0, lsr #0x10
	mov r0, r1, lsl #0x19
	mov ip, r0, lsr #0x15
	mov r0, r3, lsl #0x19
	rsb r2, r2, #0
	sub r3, r2, r0, lsr #21
	ldr r0, [r4, #0x44]
	ldr r1, [r4, #0x48]
	rsb r2, ip, #0x400
	bl EffectSlingDust__Create
	mov r0, #0
	str r0, [sp]
	mov r1, #0x43
	str r1, [sp, #4]
	sub r1, r1, #0x44
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217FFF8: .word _mt_math_rand
_0217FFFC: .word 0x00196225
_02180000: .word 0x3C6EF35F
	arm_func_end ovl00_217FE64

	.data
	
aActAcGmkSlingB: // 0x02189B6C
	.asciz "/act/ac_gmk_sling.bac"
	.align 4