	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start IceBlock__Create
IceBlock__Create: // 0x0216AC7C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, _0216AE34 // =gameState
	mov r7, r0
	ldr r0, [r3, #0x14]
	mov r6, r1
	mov r5, r2
	cmp r0, #1
	bne _0216ACC0
	ldrh r0, [r7, #4]
	tst r0, #1
	beq _0216ACC0
	mov r0, #0xff
	strb r0, [r7]
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_0216ACC0:
	mov r0, #0x1800
	mov r2, #0
	str r0, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _0216AE38 // =StageTask_Main
	ldr r1, _0216AE3C // =GameObject__Destructor
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
	mov r0, #0xaf
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0216AE40 // =gameArchiveStage
	mov r1, #0
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _0216AE44 // =aActAcGmkIceBlo_0
	bl ObjObjectAction2dBACLoad
	mov r0, #0xb0
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #8
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, #0
	mov r2, #0x23
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
	add r0, r4, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, _0216AE48 // =0x0000FFFD
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _0216AE4C // =ovl00_216AE54
	mov r1, #0
	str r0, [r4, #0x23c]
	ldr r2, [r4, #0x230]
	ldr r0, _0216AE50 // =StageTask__DefaultDiffData
	orr r2, r2, #0x400
	str r2, [r4, #0x230]
	str r1, [r4, #0x13c]
	str r4, [r4, #0x2d8]
	str r0, [r4, #0x2fc]
	mov r1, #0x20
	add r0, r4, #0x300
	strh r1, [r0, #8]
	strh r1, [r0, #0xa]
	sub r2, r1, #0x30
	sub r1, r1, #0x40
	add r0, r4, #0x200
	strh r2, [r0, #0xf0]
	strh r1, [r0, #0xf2]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216AE34: .word gameState
_0216AE38: .word StageTask_Main
_0216AE3C: .word GameObject__Destructor
_0216AE40: .word gameArchiveStage
_0216AE44: .word aActAcGmkIceBlo_0
_0216AE48: .word 0x0000FFFD
_0216AE4C: .word ovl00_216AE54
_0216AE50: .word StageTask__DefaultDiffData
	arm_func_end IceBlock__Create

	arm_func_start ovl00_216AE54
ovl00_216AE54: // 0x0216AE54
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r4, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r4, #0
	cmpne r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrh r1, [r0]
	cmp r1, #5
	bne _0216AEB0
	ldr r1, [r0, #0x11c]
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrh r0, [r1]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, [r1, #0x1c]
	bic r0, r0, #4
	str r0, [r1, #0x1c]
	b _0216AEDC
_0216AEB0:
	cmp r1, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, [r0, #0x1c]
	cmp r1, #0
	moveq r1, #1
	movne r1, #0
	tst r1, #0x10
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, pc}
	bl Player__Action_DestroyAttackRecoil
_0216AEDC:
	ldr r0, [r4, #0x18]
	mov ip, #0x2e00
	orr r0, r0, #0xa
	str r0, [r4, #0x18]
	ldr r1, [r4, #0x230]
	mov r0, #0
	orr r1, r1, #0x800
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x2f4]
	rsb ip, ip, #0
	orr r1, r1, #0x100
	str r1, [r4, #0x2f4]
	ldr r5, [r4, #0x44]
	ldr r6, [r4, #0x48]
	mov r1, r5
	mov r2, r6
	sub r3, r0, #0x3300
	str ip, [sp]
	bl EffectIceBlockDebris__Create
	mov r4, #0x2800
	rsb r4, r4, #0
	mov r1, r5
	mov r2, r6
	add r3, r4, #0x800
	mov r0, #1
	str r4, [sp]
	bl EffectIceBlockDebris__Create
	mov r0, #0x2000
	rsb r0, r0, #0
	str r0, [sp]
	mov r1, r5
	mov r0, #2
	mov r2, r6
	mov r3, #0x3000
	bl EffectIceBlockDebris__Create
	mov r0, #0x3200
	rsb r0, r0, #0
	str r0, [sp]
	mov r1, r5
	mov r2, r6
	mov r0, #3
	mov r3, #0x2400
	bl EffectIceBlockDebris__Create
	mov r0, #0
	str r0, [sp]
	mov r1, #0x54
	str r1, [sp, #4]
	sub r1, r1, #0x55
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl00_216AE54

	.data
	
aActAcGmkIceBlo_0: // 0x021893F8
	.asciz "/act/ac_gmk_ice_block.bac"
	.align 4