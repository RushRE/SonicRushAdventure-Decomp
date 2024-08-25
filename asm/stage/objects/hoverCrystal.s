	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start HoverCrystal__Create
HoverCrystal__Create: // 0x021826D8
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
	ldr r0, _02182884 // =StageTask_Main
	ldr r1, _02182888 // =GameObject__Destructor
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
	mov r0, #0xa0
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _0218288C // =gameArchiveStage
	mov r1, #8
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _02182890 // =aActAcGmkAirBac
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x61
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
	ldr r1, [r4, #0x20]
	add r0, r4, #0x218
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r4, [r4, #0x234]
	ldrsb r6, [r7, #7]
	ldrb r5, [r7, #9]
	ldrsb r1, [r7, #6]
	sub r2, r6, #0x60
	mov r3, r2, lsl #0x10
	add r2, r6, r5
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
	str r2, [sp]
	mov r2, r3, asr #0x10
	ldrb r3, [r7, #8]
	add r3, r1, r3
	mov r3, r3, lsl #0x10
	mov r3, r3, asr #0x10
	bl ObjRect__SetBox2D
	mov r1, #0
	add r0, r4, #0x218
	mov r2, r1
	bl ObjRect__SetAttackStat
	ldr r1, _02182894 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _02182898 // =HoverCrystal__OnDefend
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	orr r0, r0, #0xc0
	str r0, [r4, #0x230]
	ldr r0, [r4, #0x44]
	ldr r1, [r4, #0x48]
	bl Player__UseUpsideDownGravity
	cmp r0, #0
	ldrne r0, [r4, #0x20]
	ldr r1, _0218289C // =HoverCrystal__State_21828A0
	orrne r0, r0, #2
	strne r0, [r4, #0x20]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02182884: .word StageTask_Main
_02182888: .word GameObject__Destructor
_0218288C: .word gameArchiveStage
_02182890: .word aActAcGmkAirBac
_02182894: .word 0x0000FFFE
_02182898: .word HoverCrystal__OnDefend
_0218289C: .word HoverCrystal__State_21828A0
	arm_func_end HoverCrystal__Create

	arm_func_start HoverCrystal__State_21828A0
HoverCrystal__State_21828A0: // 0x021828A0
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	cmp r0, #0
	addgt sp, sp, #8
	str r0, [r4, #0x2c]
	ldmgtia sp!, {r3, r4, r5, pc}
	ldr r3, _021829AC // =_mt_math_rand
	ldr r0, _021829B0 // =0x00196225
	ldr r5, [r3]
	ldr r1, _021829B4 // =0x3C6EF35F
	mla r2, r5, r0, r1
	str r2, [r3]
	ldr ip, [r4, #0x340]
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov lr, r0, lsr #0x10
	ldr r0, [r4, #0x28]
	ldrsb r1, [ip, #7]
	ldr r3, [r4, #0x48]
	tst r0, #1
	add r1, r3, r1, lsl #12
	ldrneb r3, [ip, #9]
	ldr ip, _021829B4 // =0x3C6EF35F
	ldr r5, [r4, #0x44]
	subne r3, r3, #0xf
	addne r1, r1, r3, lsl #12
	ldr r3, _021829B0 // =0x00196225
	sub r5, r5, #0x10000
	mla r3, r2, r3, ip
	and lr, lr, #0x2f
	add r0, r5, lr, lsl #12
	ldr lr, _021829AC // =_mt_math_rand
	mov r2, r3, lsr #0x10
	str r3, [lr]
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
	mov ip, r3, lsl #0x1c
	ldr r2, [r4, #0x44]
	ldr r3, [r4, #0x48]
	sub r2, r2, r0
	add r1, r1, ip, lsr #16
	mov r2, r2, asr #0xa
	sub r3, r3, r1
	str r2, [sp]
	mov r3, r3, asr #0xa
	str r3, [sp, #4]
	bl EffectAirEffect__Create
	ldr r2, _021829AC // =_mt_math_rand
	ldr r0, _021829B0 // =0x00196225
	ldr r3, [r2]
	ldr r1, _021829B4 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	str r1, [r2]
	add r0, r0, #4
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021829AC: .word _mt_math_rand
_021829B0: .word 0x00196225
_021829B4: .word 0x3C6EF35F
	arm_func_end HoverCrystal__State_21828A0

	arm_func_start HoverCrystal__OnDefend
HoverCrystal__OnDefend: // 0x021829B8
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x34
	mov r6, r1
	ldr r4, [r6, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	addeq sp, sp, #0x34
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldrh r0, [r5]
	cmp r0, #1
	addne sp, sp, #0x34
	ldmneia sp!, {r3, r4, r5, r6, pc}
	mov r2, #0x10
	add r0, sp, #0x1c
	str r2, [sp]
	sub r1, r2, #0x16
	sub r2, r2, #0x20
	mov r3, #6
	bl ObjRect__SetBox2D
	ldr r0, [r5, #0x44]
	add lr, sp, #4
	mov r0, r0, asr #0xc
	str r0, [sp, #0x28]
	ldr r0, [r5, #0x48]
	mov ip, lr
	mov r0, r0, asr #0xc
	str r0, [sp, #0x2c]
	ldr r0, [r5, #0x4c]
	mov r0, r0, asr #0xc
	str r0, [sp, #0x30]
	ldmia r6!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	ldmia r6, {r0, r1}
	stmia lr, {r0, r1}
	ldr r1, [r4, #0x44]
	add r0, sp, #0x1c
	mov r1, r1, asr #0xc
	str r1, [sp, #0x10]
	ldr r2, [r4, #0x48]
	mov r1, ip
	mov r2, r2, asr #0xc
	str r2, [sp, #0x14]
	ldr r2, [r4, #0x4c]
	mov r2, r2, asr #0xc
	str r2, [sp, #0x18]
	bl ObjRect__RectCheck
	cmp r0, #0
	addeq sp, sp, #0x34
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r2, [r4, #0x340]
	ldr r0, [r4, #0x20]
	ldrsb r1, [r2, #7]
	tst r0, #2
	ldrb r0, [r2, #8]
	mov r3, r1, lsl #0xc
	ldrsb r1, [r2, #6]
	ldr ip, [r4, #0x44]
	rsbne r3, r3, #0
	add r0, r1, r0
	add r0, r0, #6
	add r0, ip, r0, lsl #12
	str r0, [sp]
	sub r2, r1, #6
	ldr r6, [r4, #0x48]
	mov r0, r5
	mov r1, r4
	add r2, ip, r2, lsl #12
	add r3, r6, r3
	bl Player__Gimmick_AirSwitch
	add sp, sp, #0x34
	ldmia sp!, {r3, r4, r5, r6, pc}
	arm_func_end HoverCrystal__OnDefend

	.data
	
aActAcGmkAirBac: // 0x02189C7C
	.asciz "/act/ac_gmk_air.bac"
	.align 4