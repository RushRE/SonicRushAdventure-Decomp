	.include "asm/macros.inc"
	.include "global.inc"

	.bss

Breakable__activeCount: // 0x0218A374
	.space 0x02

_0218A376: // 0x0218A376
	.space 0x02
	
	.text

	arm_func_start Breakable__Create
Breakable__Create: // 0x0215FC64
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _0215FE8C // =StageTask_Main
	ldr r1, _0215FE90 // =GameObject__Destructor
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
	mov r5, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r5
	mov r1, r8
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	mov r0, #0x36
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0215FE94 // =gameArchiveStage
	mov r1, #0
	ldr r2, [r0]
	mov r0, r5
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r5, #0x168
	ldr r2, _0215FE98 // =aActAcGmkBreakO_0
	bl ObjObjectAction2dBACLoad
	mov r0, #0x37
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r5
	ldr r1, _0215FE9C // =0x0000FFFF
	bl ObjObjectActionAllocSprite
	mov r0, r5
	mov r1, #0
	mov r2, #6
	bl ObjActionAllocSpritePalette
	mov r0, r5
	mov r1, #0x16
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r5
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	add r0, r5, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r5, #0x218
	mov r1, #1
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _0215FEA0 // =Breakable__OnDefend_215FEB8
	mov r1, #0
	str r0, [r5, #0x23c]
	ldr r2, [r5, #0x1c]
	ldr r0, _0215FEA4 // =StageTask__DefaultDiffData
	orr r2, r2, #0x2100
	str r2, [r5, #0x1c]
	str r1, [r5, #0x13c]
	str r5, [r5, #0x2d8]
	str r0, [r5, #0x2fc]
	bl GetCurrentZoneID
	cmp r0, #3
	bne _0215FDD4
	mov r1, #0x20
	add r0, r5, #0x300
	strh r1, [r0, #8]
	strh r1, [r0, #0xa]
	sub r1, r1, #0x30
	add r0, r5, #0x200
	strh r1, [r0, #0xf0]
	strh r1, [r0, #0xf2]
	b _0215FE60
_0215FDD4:
	ldr r0, _0215FEA8 // =gameState
	ldrh r0, [r0, #0x28]
	cmp r0, #2
	beq _0215FDF0
	bl GetCurrentZoneID
	cmp r0, #8
	bne _0215FE38
_0215FDF0:
	add r0, r5, #0x300
	mov r2, #0x20
	mov r1, #0x28
	strh r1, [r0, #8]
	strh r2, [r0, #0xa]
	sub r1, r2, #0x34
	add r0, r5, #0x200
	strh r1, [r0, #0xf0]
	sub r1, r2, #0x40
	ldr r2, _0215FEAC // =Breakable__activeCount
	strh r1, [r0, #0xf2]
	ldrh r3, [r2]
	ldr r1, _0215FEB0 // =Breakable__Destructor
	mov r0, r4
	add r3, r3, #1
	strh r3, [r2]
	bl SetTaskDestructorEvent
	b _0215FE60
_0215FE38:
	add r0, r5, #0x300
	mov r2, #0x20
	mov r1, #0x30
	strh r1, [r0, #8]
	strh r2, [r0, #0xa]
	sub r1, r2, #0x38
	add r0, r5, #0x200
	strh r1, [r0, #0xf0]
	sub r1, r2, #0x30
	strh r1, [r0, #0xf2]
_0215FE60:
	mov r0, r5
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r0, _0215FEA8 // =gameState
	ldrh r0, [r0, #0x28]
	cmp r0, #2
	ldreq r0, _0215FEB4 // =Breakable__State_Tutorial
	streq r0, [r5, #0xf4]
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215FE8C: .word StageTask_Main
_0215FE90: .word GameObject__Destructor
_0215FE94: .word gameArchiveStage
_0215FE98: .word aActAcGmkBreakO_0
_0215FE9C: .word 0x0000FFFF
_0215FEA0: .word Breakable__OnDefend_215FEB8
_0215FEA4: .word StageTask__DefaultDiffData
_0215FEA8: .word gameState
_0215FEAC: .word Breakable__activeCount
_0215FEB0: .word Breakable__Destructor
_0215FEB4: .word Breakable__State_Tutorial
	arm_func_end Breakable__Create

	arm_func_start Breakable__OnDefend_215FEB8
Breakable__OnDefend_215FEB8: // 0x0215FEB8
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r4, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r4, #0
	cmpne r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r1, [r0]
	cmp r1, #5
	bne _0215FF28
	ldr r1, [r0, #0x11c]
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r1]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #0x4000
	str r0, [r1, #8]
	ldr r0, [r4, #0x2f4]
	orr r0, r0, #0x100
	str r0, [r4, #0x2f4]
	ldr r0, [r1, #0x1c]
	bic r0, r0, #4
	str r0, [r1, #0x1c]
	b _0215FF54
_0215FF28:
	cmp r1, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, [r0, #0x1c]
	cmp r1, #0
	moveq r1, #1
	movne r1, #0
	tst r1, #0x10
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	bl Player__Action_DestroyAttackRecoil
_0215FF54:
	mov r0, #3
	bl ShakeScreen
	ldr r0, [r4, #0x18]
	mov r2, #0x3000
	orr r0, r0, #0xa
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x354]
	sub r3, r2, #0x5000
	orr r0, r0, #0x10000
	str r0, [r4, #0x354]
	ldr r0, [r4, #0x230]
	mov ip, #0
	orr r0, r0, #0x800
	str r0, [r4, #0x230]
	ldr r0, [r4, #0x270]
	orr r0, r0, #0x800
	str r0, [r4, #0x270]
	ldr r0, [r4, #0x2f4]
	orr r0, r0, #0x100
	str r0, [r4, #0x2f4]
	ldr r5, [r4, #0x44]
	ldr r4, [r4, #0x48]
	mov r0, r5
	mov r1, r4
	str ip, [sp]
	bl EffectBreakableObjDebris__Create
	mov r3, #0
	mov r0, r5
	mov r1, r4
	sub r2, r3, #0x2000
	str r3, [sp]
	sub r3, r3, #0x2800
	bl EffectBreakableObjDebris__Create
	mov r2, #0x3300
	mov r0, #1
	rsb r2, r2, #0
	str r0, [sp]
	mov r0, r5
	mov r1, r4
	add r3, r2, #0x500
	bl EffectBreakableObjDebris__Create
	mov r2, #1
	str r2, [sp]
	mov r2, #0x2400
	mov r0, r5
	mov r1, r4
	sub r3, r2, #0x5600
	bl EffectBreakableObjDebris__Create
	mov r0, #0
	str r0, [sp]
	mov r1, #0x43
	str r1, [sp, #4]
	sub r1, r1, #0x44
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, _02160054 // =gameState
	ldrh r0, [r0, #0x28]
	cmp r0, #2
	ldreq r0, _02160058 // =Breakable__activeCount
	moveq r1, #1
	streqh r1, [r0, #2]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02160054: .word gameState
_02160058: .word Breakable__activeCount
	arm_func_end Breakable__OnDefend_215FEB8

	arm_func_start Breakable__Destructor
Breakable__Destructor: // 0x0216005C
	ldr r1, _0216008C // =Breakable__activeCount
	ldr ip, _02160090 // =GameObject__Destructor
	ldrh r2, [r1]
	cmp r2, #0
	subne r2, r2, #1
	strneh r2, [r1]
	ldr r1, _0216008C // =Breakable__activeCount
	ldrh r2, [r1]
	cmp r2, #0
	moveq r2, #0
	streqh r2, [r1, #2]
	bx ip
	.align 2, 0
_0216008C: .word Breakable__activeCount
_02160090: .word GameObject__Destructor
	arm_func_end Breakable__Destructor

	arm_func_start Breakable__State_Tutorial
Breakable__State_Tutorial: // 0x02160094
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r1, _02160270 // =Breakable__activeCount
	mov r5, r0
	ldrh r0, [r1, #2]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, #3
	bl ShakeScreen
	ldr r0, [r5, #0x18]
	ldr r3, _02160274 // =_mt_math_rand
	orr r0, r0, #6
	str r0, [r5, #0x18]
	ldr r0, [r5, #0x354]
	mov ip, #0
	orr r0, r0, #0x10000
	str r0, [r5, #0x354]
	ldr r1, [r5, #0x230]
	ldr r0, _02160278 // =0x00196225
	orr r1, r1, #0x800
	str r1, [r5, #0x230]
	ldr r2, [r5, #0x270]
	ldr r1, _0216027C // =0x3C6EF35F
	orr r2, r2, #0x800
	str r2, [r5, #0x270]
	ldr r4, [r5, #0x2f4]
	sub r2, ip, #0x2000
	orr r4, r4, #0x100
	str r4, [r5, #0x2f4]
	ldr lr, [r3]
	ldr r4, [r5, #0x44]
	mla r6, lr, r0, r1
	mla r0, r6, r0, r1
	ldr r5, [r5, #0x48]
	str r0, [r3]
	str ip, [sp]
	ldr r0, [r3]
	mov r3, r6, lsr #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, lsl #0x10
	mov r0, r3, lsl #0x10
	mov r1, r1, lsr #0x10
	add lr, r1, #0x3000
	sub ip, r2, r0, lsr #16
	ldr r3, _02160280 // =0x000007FF
	mov r0, r4
	and r2, lr, r3
	mov r1, r5
	and r3, ip, r3
	bl EffectBreakableObjDebris__Create
	ldr r3, _02160274 // =_mt_math_rand
	ldr r1, _02160278 // =0x00196225
	ldr ip, [r3]
	ldr r2, _0216027C // =0x3C6EF35F
	mov r0, r4
	mla lr, ip, r1, r2
	mla r1, lr, r1, r2
	str r1, [r3]
	mov r1, lr, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #1
	str r1, [sp]
	ldr r1, [r3]
	mov r3, #0x2000
	mov r1, r1, lsr #0x10
	rsb r3, r3, #0
	mov r1, r1, lsl #0x10
	sub r1, r3, r1, lsr #16
	and r2, r1, r3, lsr #21
	sub r3, r3, #0x800
	mov r1, r5
	bl EffectBreakableObjDebris__Create
	ldr r3, _02160274 // =_mt_math_rand
	ldr r1, _02160278 // =0x00196225
	ldr ip, [r3]
	ldr r2, _0216027C // =0x3C6EF35F
	mov r0, r4
	mla r1, ip, r1, r2
	str r1, [r3]
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, #0x3300
	and r1, r1, #1
	rsb r2, r2, #0
	str r1, [sp]
	mov r1, r5
	add r3, r2, #0x500
	bl EffectBreakableObjDebris__Create
	ldr r3, _02160274 // =_mt_math_rand
	ldr r0, _02160278 // =0x00196225
	ldr ip, [r3]
	ldr r1, _0216027C // =0x3C6EF35F
	mov lr, #1
	mla r0, ip, r0, r1
	str r0, [r3]
	str lr, [sp]
	ldr r0, [r3]
	mov r2, #0x2400
	mov r0, r0, lsr #0x10
	sub r1, r2, #0x5600
	mov r0, r0, lsl #0x10
	sub ip, r1, r0, lsr #16
	rsb r3, lr, #0x800
	mov r0, r4
	mov r1, r5
	and r3, ip, r3
	bl EffectBreakableObjDebris__Create
	mov r4, #0x43
	sub r1, r4, #0x44
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02160270: .word Breakable__activeCount
_02160274: .word _mt_math_rand
_02160278: .word 0x00196225
_0216027C: .word 0x3C6EF35F
_02160280: .word 0x000007FF
	arm_func_end Breakable__State_Tutorial

	.data
	
aActAcGmkBreakO_0: // 0x02188EF4
	.asciz "/act/ac_gmk_break_obj.bac"
	.align 4