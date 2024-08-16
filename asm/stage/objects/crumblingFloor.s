	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start CrumblingFloor__Create
CrumblingFloor__Create: // 0x02183614
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	ldr r3, _021838C4 // =0x000010F6
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _021838C8 // =StageTask_Main
	ldr r1, _021838CC // =GameObject__Destructor
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
	mov r4, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldrh r0, [r7, #2]
	cmp r0, #0xe7
	movne r1, #1
	ldr r0, [r4, #0x1c]
	moveq r1, #0
	orr r2, r0, #0x2100
	mov r1, r1, lsl #0x10
	mov r0, #0xa2
	str r2, [r4, #0x1c]
	mov r5, r1, lsr #0x10
	bl GetObjectFileWork
	ldr r1, _021838D0 // =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, _021838D4 // =aActAcGmkBFallF
	str r1, [sp]
	mov r6, #0
	mov r0, r4
	add r1, r4, #0x168
	str r6, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r5, lsl #1
	add r0, r0, #0xa3
	bl GetObjectFileWork
	mov r2, r0
	ldr r1, _021838D8 // =0x02188770
	mov r3, r5, lsl #1
	ldrh r1, [r1, r3]
	mov r0, r4
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, r6
	mov r2, #6
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r1, r5, lsl #0x10
	mov r0, r4
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	add r0, r5, #0xa7
	bl GetObjectFileWork
	ldr r1, _021838DC // =_02189CA8
	ldr r3, _021838D0 // =gameArchiveStage
	mov r2, r0
	ldr r1, [r1, r5, lsl #2]
	ldr r3, [r3]
	mov r0, r4
	bl ObjObjectCollisionDifSet
	ldrh r0, [r7, #2]
	cmp r0, #0xe7
	beq _0218379C
	mov r0, #0xa9
	bl GetObjectFileWork
	ldr r1, _021838D0 // =gameArchiveStage
	mov r2, r0
	ldr r3, [r1]
	ldr r1, _021838E0 // =aDfGmkBFallFloo
	mov r0, r4
	bl ObjObjectCollisionDirSet
_0218379C:
	str r4, [r4, #0x2d8]
	add r0, r4, #0x300
	mov r2, #0x40
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	ldrh r0, [r7, #2]
	cmp r0, #0xe8
	bne _021837D4
	sub r1, r2, #0x50
	add r0, r4, #0x200
	strh r1, [r0, #0xf0]
	sub r1, r2, #0x60
	strh r1, [r0, #0xf2]
	b _02183808
_021837D4:
	cmp r0, #0xe9
	bne _021837F4
	sub r1, r2, #0x50
	add r0, r4, #0x200
	strh r1, [r0, #0xf0]
	sub r1, r2, #0x60
	strh r1, [r0, #0xf2]
	b _02183808
_021837F4:
	sub r1, r2, #0x60
	add r0, r4, #0x200
	strh r1, [r0, #0xf0]
	mov r1, #0
	strh r1, [r0, #0xf2]
_02183808:
	ldrh r0, [r7, #2]
	cmp r0, #0xe9
	bne _0218382C
	ldr r0, [r4, #0x20]
	orr r0, r0, #1
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x2f4]
	orr r0, r0, #8
	str r0, [r4, #0x2f4]
_0218382C:
	ldrsb r0, [r7, #6]
	cmp r0, #0
	moveq r0, #0xf
	str r0, [r4, #0x2c]
	ldrh r1, [r7, #4]
	tst r1, #1
	beq _021838B0
	ldrh r0, [r7, #2]
	mov r3, #0
	cmp r0, #0xe9
	ldreq r0, _021838E4 // =0x0000014D
	beq _02183874
	cmp r0, #0xe8
	ldreq r0, _021838E8 // =0x0000014E
	beq _02183874
	tst r1, #2
	mov r0, #0x5f
	movne r3, #1
_02183874:
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	str r1, [sp, #0x10]
	ldr r1, [r4, #0x44]
	ldr r2, [r4, #0x48]
	bl GameObject__SpawnObject
	cmp r0, #0
	beq _021838B0
	str r4, [r0, #0x11c]
	ldr r1, [r0, #0x18]
	orr r1, r1, #0x10
	str r1, [r0, #0x18]
_021838B0:
	ldr r1, _021838EC // =ovl00_21838F0
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_021838C4: .word 0x000010F6
_021838C8: .word StageTask_Main
_021838CC: .word GameObject__Destructor
_021838D0: .word gameArchiveStage
_021838D4: .word aActAcGmkBFallF
_021838D8: .word 0x02188770
_021838DC: .word _02189CA8
_021838E0: .word aDfGmkBFallFloo
_021838E4: .word 0x0000014D
_021838E8: .word 0x0000014E
_021838EC: .word ovl00_21838F0
	arm_func_end CrumblingFloor__Create

	arm_func_start ovl00_21838F0
ovl00_21838F0: // 0x021838F0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r2, [r4, #0x13c]
	ldr r1, [r2, #4]
	cmp r1, #0
	beq _02183920
	ldrh r0, [r1]
	cmp r0, #1
	ldreq r0, [r1, #0x114]
	cmpeq r0, r4
	beq _02183940
_02183920:
	ldr r1, [r2, #8]
	cmp r1, #0
	beq _0218394C
	ldrh r0, [r1]
	cmp r0, #1
	ldreq r0, [r1, #0x118]
	cmpeq r0, r4
	bne _0218394C
_02183940:
	ldr r0, [r4, #0x354]
	orr r0, r0, #1
	str r0, [r4, #0x354]
_0218394C:
	ldr r0, [r4, #0x1c]
	tst r0, #0x80
	ldr r0, [r4, #0x354]
	beq _021839C8
	tst r0, #1
	bne _021839B4
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0
	bgt _021839B4
	ldr r0, [r4, #0x2f4]
	orr r0, r0, #0x100
	str r0, [r4, #0x2f4]
	ldr r0, [r4, #0x2c]
	tst r0, #2
	ldr r0, [r4, #0x20]
	bicne r0, r0, #0x20
	orreq r0, r0, #0x20
	str r0, [r4, #0x20]
	ldr r1, [r4, #0x2c]
	mvn r0, #0xb
	cmp r1, r0
	ldrle r0, [r4, #0x20]
	orrle r0, r0, #4
	strle r0, [r4, #0x20]
_021839B4:
	ldr r0, [r4, #0x354]
	add sp, sp, #8
	bic r0, r0, #1
	str r0, [r4, #0x354]
	ldmia sp!, {r4, pc}
_021839C8:
	tst r0, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	cmp r0, #0
	addgt sp, sp, #8
	str r0, [r4, #0x2c]
	ldmgtia sp!, {r4, pc}
	ldr r1, [r4, #0x1c]
	mov r0, #8
	orr r1, r1, #0x80
	bic r1, r1, #0x2000
	str r1, [r4, #0x1c]
	bl ShakeScreen
	mov r1, #0
	mov r0, r4
	mov r2, r1
	mov r3, #2
	bl CreateEffectExplosion
	mov ip, #0x6a
	sub r1, ip, #0x6b
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	mov r0, #8
	str r0, [r4, #0x2c]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl00_21838F0

	.data
	
_02189CA8:
	.word aDfGmkBFallFloo_0
	.word aDfGmkBFallFloo_1

aDfGmkBFallFloo_1: // 0x02189CB0
	.asciz "/df/gmk_b_fall_floor_up.df"
	.align 4
	
aDfGmkBFallFloo_0: // 0x02189CCC
	.asciz "/df/gmk_b_fall_floor_flat.df"
	.align 4
	
aActAcGmkBFallF: // 0x02189CEC
	.asciz "/act/ac_gmk_b_fall_floor.bac"
	.align 4
	
aDfGmkBFallFloo: // 0x02189D0C
	.asciz "/df/gmk_b_fall_floor_up.di"
	.align 4