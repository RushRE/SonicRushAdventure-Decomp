	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Object17__Create
Object17__Create: // 0x02162E20
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x10
	mov r7, r0
	ldrh r8, [r7, #2]
	mov r0, #0x1800
	mov r6, r1
	str r0, [sp]
	mov r0, #2
	mov r4, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r5, _02163100 // =0x00000474
	ldr r0, _02163104 // =StageTask_Main
	str r5, [sp, #8]
	ldr r1, _02163108 // =GameObject__Destructor
	mov r3, r2
	sub r5, r8, #0x51
	bl TaskCreate_
	mov r8, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r8, r0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r0, r8
	bl GetTaskWork_
	ldr r2, _02163100 // =0x00000474
	mov sb, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, sb
	mov r1, r7
	mov r2, r6
	mov r3, r4
	bl GameObject__InitFromObject
	ldrh r0, [r7, #2]
	cmp r0, #0x51
	add r0, sb, #0x400
	bne _02162ED8
	mov r1, #1
	strh r1, [r0, #0x64]
	mov r0, #0x100
	str r0, [sp, #0xc]
	mov r4, #0
	b _02162F04
_02162ED8:
	mov r1, #4
	strh r1, [r0, #0x64]
	ldrh r1, [r7, #2]
	mov r0, #0
	mov r4, #0x200
	str r0, [sp, #0xc]
	cmp r1, #0x52
	moveq r0, #0xe000
	streqh r0, [sb, #0x34]
	movne r0, #0x2000
	strneh r0, [sb, #0x34]
_02162F04:
	add r0, r5, #0xad
	bl GetObjectFileWork
	ldr r1, _0216310C // =_02188FEC
	ldr r3, _02163110 // =gameArchiveStage
	mov r2, r0
	ldr r1, [r1, r5, lsl #2]
	ldr r3, [r3]
	mov r0, sb
	bl ObjObjectCollisionDifSet
	ldr r0, _02163114 // =0x021883FC
	mov r1, r5, lsl #2
	ldrh r3, [r0, r1]
	ldr r2, _02163118 // =0x021883FE
	str sb, [sb, #0x2d8]
	add r0, sb, #0x300
	ldrh r6, [r2, r1]
	strh r3, [r0, #8]
	ldr r3, _0216311C // =0x021883F0
	strh r6, [r0, #0xa]
	ldrsh r6, [r3, r1]
	ldr r3, _02163120 // =0x021883F2
	add r2, sb, #0x200
	ldrsh r1, [r3, r1]
	strh r6, [r2, #0xf0]
	mov r0, #0xa6
	strh r1, [r2, #0xf2]
	ldr r1, [sb, #0x2f4]
	orr r1, r1, #0x20
	str r1, [sb, #0x2f4]
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, _02163110 // =gameArchiveStage
	mov r1, #0
	ldr r2, [r0]
	mov r0, sb
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, _02163124 // =aActAcGmkFlipmu_0
	add r1, sb, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, #0xa7
	bl GetObjectFileWork
	mov r2, r0
	mov r0, sb
	mov r1, #0x30
	bl ObjObjectActionAllocSprite
	mov r0, sb
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r0, [sb, #0x1a4]
	orr r0, r0, r4
	str r0, [sb, #0x1a4]
	ldrh r0, [r7, #4]
	tst r0, #1
	mov r0, sb
	beq _02162FF4
	mov r1, #4
	mov r2, #0x1d
	bl ObjActionAllocSpritePalette
	b _02163000
_02162FF4:
	mov r1, #0
	mov r2, #0xe
	bl ObjActionAllocSpritePalette
_02163000:
	mov r0, sb
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, sb
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	add r4, sb, #0x400
	ldrsh r0, [r4, #0x64]
	mov r8, #0
	cmp r0, #0
	ble _021630BC
	ldr r0, _02163128 // =0x02188408
	ldr fp, _0216312C // =0x0000FFFE
	add r7, r0, r5, lsl #5
	ldr r6, _02163130 // =0x00000102
	ldr r5, _02163134 // =ovl00_216335C
	add sl, sb, #0x364
_02163044:
	mov r1, #0
	mov r0, sl
	mov r2, r1
	bl ObjRect__SetAttackStat
	mov r0, sl
	mov r1, fp
	mov r2, #0
	bl ObjRect__SetDefenceStat
	add r3, r7, r8, lsl #3
	ldrsh r1, [r3, #6]
	mov r2, r8, lsl #3
	mov r0, sl
	str r1, [sp]
	ldrsh r1, [r2, r7]
	ldrsh r2, [r3, #2]
	ldrsh r3, [r3, #4]
	bl ObjRect__SetBox2D
	add r1, sb, r8, lsl #6
	add r0, r1, #0x300
	strh r6, [r0, #0x98]
	str sb, [r1, #0x380]
	str r5, [r1, #0x388]
	ldr r0, [r1, #0x37c]
	add r8, r8, #1
	orr r0, r0, #0x400
	str r0, [r1, #0x37c]
	ldrsh r0, [r4, #0x64]
	add sl, sl, #0x40
	cmp r8, r0
	blt _02163044
_021630BC:
	ldr r1, [sb, #0x1c]
	ldr r0, [sp, #0xc]
	orr r1, r1, #0x2100
	str r1, [sb, #0x1c]
	ldr r2, [sb, #0x20]
	orr r0, r0, #0x10
	orr r0, r2, r0
	str r0, [sb, #0x20]
	ldr r1, _02163138 // =nullovl00_105
	ldr r0, _0216313C // =ovl00_2163284
	str r1, [sb, #0xf4]
	str r0, [sb, #0xfc]
	ldr r1, _02163140 // =ovl00_2163298
	mov r0, sb
	str r1, [sb, #0x108]
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02163100: .word 0x00000474
_02163104: .word StageTask_Main
_02163108: .word GameObject__Destructor
_0216310C: .word _02188FEC
_02163110: .word gameArchiveStage
_02163114: .word 0x021883FC
_02163118: .word 0x021883FE
_0216311C: .word 0x021883F0
_02163120: .word 0x021883F2
_02163124: .word aActAcGmkFlipmu_0
_02163128: .word 0x02188408
_0216312C: .word 0x0000FFFE
_02163130: .word 0x00000102
_02163134: .word ovl00_216335C
_02163138: .word nullovl00_105
_0216313C: .word ovl00_2163284
_02163140: .word ovl00_2163298
	arm_func_end Object17__Create

	arm_func_start nullovl00_105
nullovl00_105: // 0x02163144
	bx lr
	arm_func_end nullovl00_105

	arm_func_start ovl00_2163148
ovl00_2163148: // 0x02163148
	ldr r1, _0216316C // =ovl00_2163174
	mov r2, #0
	str r1, [r0, #0xf4]
	ldr r1, _02163170 // =0x00000333
	str r2, [r0, #0x468]
	str r1, [r0, #0x46c]
	mov r1, #0x10000
	str r1, [r0, #0x470]
	bx lr
	.align 2, 0
_0216316C: .word ovl00_2163174
_02163170: .word 0x00000333
	arm_func_end ovl00_2163148

	arm_func_start ovl00_2163174
ovl00_2163174: // 0x02163174
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r2, [r0, #0x468]
	ldr r1, [r0, #0x46c]
	add r1, r2, r1
	str r1, [r0, #0x468]
	ldr r1, [r0, #0x46c]
	cmp r1, #0
	ldr r1, [r0, #0x468]
	blt _021631B8
	cmp r1, #0x1000
	blt _02163200
	mov r1, #0x1000
	str r1, [r0, #0x468]
	ldr r1, [r0, #0x46c]
	rsb r1, r1, #0
	str r1, [r0, #0x46c]
	b _02163200
_021631B8:
	cmp r1, #0
	bgt _02163200
	mov r1, #0
	str r1, [r0, #0x468]
	ldr r1, [r0, #0x46c]
	rsb r1, r1, #0
	str r1, [r0, #0x46c]
	ldr r1, [r0, #0x470]
	mov r1, r1, asr #1
	str r1, [r0, #0x470]
	cmp r1, #0x1000
	bge _02163200
	ldr r1, _02163280 // =nullovl00_105
	str r1, [r0, #0xf4]
	ldr r1, [r0, #0x18]
	bic r1, r1, #2
	str r1, [r0, #0x18]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02163200:
	ldr r1, [r0, #0x468]
	ldr r2, [r0, #0x470]
	mov r1, r1, lsl #0x10
	mov lr, r1, asr #0x10
	mov r1, #0
	mov ip, lr, asr #0x1f
	mov r3, #1
	mov r5, r1
	mov r4, #0x800
_02163224:
	sub r6, r2, r1
	umull r8, r7, r6, lr
	mla r7, r6, ip, r7
	mov r6, r6, asr #0x1f
	mla r7, r6, lr, r7
	adds r8, r8, r4
	adc r6, r7, r5
	mov r7, r8, lsr #0xc
	orr r7, r7, r6, lsl #20
	cmp r3, #0
	add r1, r1, r7
	sub r3, r3, #1
	bne _02163224
	str r1, [r0, #0x54]
	ldr r2, [r0, #0x340]
	ldrh r2, [r2, #2]
	cmp r2, #0x52
	streq r1, [r0, #0x50]
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r2, #0x53
	rsbeq r1, r1, #0
	streq r1, [r0, #0x50]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02163280: .word nullovl00_105
	arm_func_end ovl00_2163174

	arm_func_start ovl00_2163284
ovl00_2163284: // 0x02163284
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x128]
	bl StageTask__Draw2D
	ldmia sp!, {r3, pc}
	arm_func_end ovl00_2163284

	arm_func_start ovl00_2163298
ovl00_2163298: // 0x02163298
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	bl GetCurrentTaskWork_
	mov r5, r0
	ldr r0, [r5, #0x18]
	add r4, r5, #0x364
	tst r0, #0xc
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, pc}
	ldr r0, _02163358 // =g_obj
	ldr r0, [r0, #0x28]
	tst r0, #0x40
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r0, [r5, #0x2d8]
	cmp r0, #0
	beq _0216330C
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	ldr r0, [r5, #0x44]
	ldr r1, [r5, #0x48]
	mov r2, #0x20
	bl StageTask__ViewOutCheck
	cmp r0, #0
	bne _0216330C
	add r0, r5, #0x2d8
	bl ObjCollisionObjectRegist
_0216330C:
	ldr r0, [r5, #0x18]
	tst r0, #2
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, pc}
	add r5, r5, #0x400
	ldrsh r0, [r5, #0x64]
	mov r6, #0
	cmp r0, #0
	addle sp, sp, #0xc
	ldmleia sp!, {r3, r4, r5, r6, pc}
_02163334:
	mov r0, r4
	bl ObjRect__Register
	ldrsh r0, [r5, #0x64]
	add r6, r6, #1
	add r4, r4, #0x40
	cmp r6, r0
	blt _02163334
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02163358: .word g_obj
	arm_func_end ovl00_2163298

	arm_func_start ovl00_216335C
ovl00_216335C: // 0x0216335C
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0xc
	ldr r6, [r1, #0x1c]
	ldr r4, [r0, #0x1c]
	cmp r6, #0
	cmpne r4, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldrh r0, [r4]
	cmp r0, #1
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr r0, [r6, #0x18]
	ldr r5, [r6, #0x340]
	orr r1, r0, #2
	mov r0, r6
	str r1, [r6, #0x18]
	bl ovl00_2163148
	ldrh r0, [r5, #2]
	mov r1, #0x5800
	cmp r0, #0x51
	beq _021633C0
	cmp r0, #0x52
	subeq r1, r1, #0xb000
	b _021633C4
_021633C0:
	mov r1, #0
_021633C4:
	ldrsb r3, [r5, #6]
	mov r2, #0x5800
	mov r0, r4
	rsb r2, r2, #0
	bl Player__Action_MushroomBounce
	mov r0, r4
	mov r1, r6
	bl Player__Action_AllowTrickCombos
	ldr r1, [r6, #0x340]
	mov r0, #0x24
	ldrh r3, [r1, #2]
	ldr r2, _021634E8 // =0x02188468
	ldr r1, _021634EC // =0x0218846C
	sub r3, r3, #0x51
	mul r5, r3, r0
	ldr r7, _021634F0 // =0x02188488
	ldr r8, _021634F4 // =0x0218848A
	ldr fp, _021634F8 // =0x02188478
	ldrh sb, [r7, r5]
	ldr sl, _021634FC // =0x0218847C
	add r0, r2, r5
	ldr r3, [r2, r5]
	ldr r7, [fp, r5]
	ldr r4, [r6, #0x44]
	ldr r2, [r6, #0x48]
	ldrh r6, [r8, r5]
	ldr r8, [sl, r5]
	ldr r1, [r1, r5]
	ldr r5, [r0, #8]
	str r6, [sp, #8]
	str r5, [sp, #4]
	ldr r5, [r0, #0xc]
	ldr fp, [r0, #0x18]
	str r5, [sp]
	add r5, r4, r3
	ldr sl, [r0, #0x1c]
	add r6, r2, r1
	mov r4, #0
_0216345C:
	ldr r0, _02163500 // =_mt_math_rand
	ldr r1, _02163504 // =0x00196225
	ldr r3, [r0]
	ldr r0, _02163508 // =0x3C6EF35F
	ldr ip, _02163504 // =0x00196225
	mla r1, r3, r1, r0
	ldr r3, _02163508 // =0x3C6EF35F
	mov r0, r1, lsr #0x10
	mla r3, r1, ip, r3
	ldr r1, [sp, #8]
	mov r0, r0, lsl #0x10
	and r0, r1, r0, lsr #16
	sub r0, r0, sb, asr #1
	add r1, r6, r0, lsl #12
	ldr r0, _02163500 // =_mt_math_rand
	mov r2, r7
	str r3, [r0]
	mov r0, r3, lsr #0x10
	mov r0, r0, lsl #0x10
	and r0, sb, r0, lsr #16
	sub r0, r0, sb, asr #1
	add r0, r5, r0, lsl #12
	mov r3, r8
	bl EffectFlipMushPuff__Create
	ldr r0, [sp, #4]
	add r4, r4, #1
	add r5, r5, r0
	ldr r0, [sp]
	add r7, r7, fp
	add r6, r6, r0
	add r8, r8, sl
	cmp r4, #5
	blt _0216345C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_021634E8: .word 0x02188468
_021634EC: .word 0x0218846C
_021634F0: .word 0x02188488
_021634F4: .word 0x0218848A
_021634F8: .word 0x02188478
_021634FC: .word 0x0218847C
_02163500: .word _mt_math_rand
_02163504: .word 0x00196225
_02163508: .word 0x3C6EF35F
	arm_func_end ovl00_216335C

	.data
	
_02188FEC:
	.word aDfGmkFlipmushU
	.word aDfGmkFlipmushU_0
	.word aDfGmkFlipmushU_1

aDfGmkFlipmushU: // 0x02188FF8
	.asciz "/df/gmk_flipmush_u.df"
	.align 4
	
aDfGmkFlipmushU_1: // 0x02189010
	.asciz "/df/gmk_flipmush_ur.df"
	.align 4
	
aDfGmkFlipmushU_0: // 0x02189028
	.asciz "/df/gmk_flipmush_ul.df"
	.align 4
	
aActAcGmkFlipmu_0: // 0x02189040
	.asciz "/act/ac_gmk_flipmush.bac"
	.align 4