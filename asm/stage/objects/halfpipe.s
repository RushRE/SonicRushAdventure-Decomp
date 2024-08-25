	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Halfpipe__Create
Halfpipe__Create: // 0x0216AFB0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r8, r0
	ldrh r5, [r8, #2]
	mov r0, #0x1800
	mov r7, r1
	mov r6, r2
	mov r2, #0
	str r0, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _0216B1EC // =StageTask_Main
	ldr r1, _0216B1F0 // =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #8]
	sub r5, r5, #0x91
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
	mov r4, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r8
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xba
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	mov r6, r0
	ldr r0, _0216B1F4 // =gameArchiveStage
	mov r1, #0
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, _0216B1F8 // =aActAcGmkHalfPi
	mov r3, r6
	bl ObjObjectAction2dBACLoad
	ldr r0, [r6]
	mov r1, r5, lsl #0x10
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize2FromAnim
	mov r6, r0
	mov r0, r5, lsl #1
	add r0, r0, #0xbb
	bl GetObjectFileWork
	mov r1, r6
	mov r2, r0
	mov r0, r4
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, #0
	mov r2, #0x3c
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	mov r0, r5, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r4
	bl StageTask__SetAnimation
	mov r2, #1
	ldr r1, [r4, #0x128]
	add r0, r4, #0x218
	str r2, [r1, #0x58]
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, _0216B1FC // =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _0216B200 // =Halfpipe__OnDefend_216B208
	add r0, r4, #0x258
	str r1, [r4, #0x23c]
	ldr r2, [r4, #0x230]
	mov r1, #0
	orr r2, r2, #0x400
	str r2, [r4, #0x230]
	mov r2, r1
	bl ObjRect__SetAttackStat
	ldr r1, _0216B1FC // =0x0000FFFE
	add r0, r4, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _0216B204 // =Halfpipe__OnDefend_216B2A0
	mov r1, #0
	str r0, [r4, #0x27c]
	ldrh r0, [r8, #2]
	cmp r0, #0x93
	mov r0, #0x40
	beq _0216B1C0
	str r4, [r4, #0x234]
	mov r3, #0x100
	str r0, [sp]
	stmib sp, {r1, r3}
	sub r2, r3, #0x180
	add r0, r4, #0x218
	sub r3, r3, #0x200
	bl ObjRect__SetBox3D
	ldrh r0, [r8, #2]
	cmp r0, #0x91
	bne _0216B1E0
	str r4, [r4, #0x274]
	mov r5, #0x100
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	add r0, r4, #0x258
	sub r1, r5, #0x140
	sub r2, r5, #0x300
	sub r3, r5, #0x200
	str r5, [sp, #8]
	bl ObjRect__SetBox3D
	b _0216B1E0
_0216B1C0:
	mov r5, #0x100
	str r4, [r4, #0x274]
	str r0, [sp]
	add r0, r4, #0x258
	sub r2, r5, #0x300
	sub r3, r5, #0x200
	stmib sp, {r1, r5}
	bl ObjRect__SetBox3D
_0216B1E0:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216B1EC: .word StageTask_Main
_0216B1F0: .word GameObject__Destructor
_0216B1F4: .word gameArchiveStage
_0216B1F8: .word aActAcGmkHalfPi
_0216B1FC: .word 0x0000FFFE
_0216B200: .word Halfpipe__OnDefend_216B208
_0216B204: .word Halfpipe__OnDefend_216B2A0
	arm_func_end Halfpipe__Create

	arm_func_start Halfpipe__OnDefend_216B208
Halfpipe__OnDefend_216B208: // 0x0216B208
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	mov r2, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r3, [r5]
	cmp r3, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r3, [r5, #0x1c]
	tst r3, #1
	beq _0216B248
	ldr r3, [r5, #0x114]
	cmp r3, #0
	beq _0216B250
_0216B248:
	bl ObjRect__FuncNoHit
	ldmia sp!, {r3, r4, r5, pc}
_0216B250:
	ldr r1, [r4, #0x340]
	ldrh r0, [r1, #2]
	cmp r0, #0x91
	bne _0216B270
	ldrh r0, [r1, #4]
	tst r0, #1
	movne r2, #1
	b _0216B284
_0216B270:
	cmp r0, #0x93
	bne _0216B284
	ldrh r0, [r1, #4]
	tst r0, #1
	moveq r2, #1
_0216B284:
	mov r0, r5
	mov r1, r4
	bl Player__Gimmick_202047C
	mov r0, r5
	mov r1, r4
	bl Player__Action_AllowTrickCombos
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end Halfpipe__OnDefend_216B208

	arm_func_start Halfpipe__OnDefend_216B2A0
Halfpipe__OnDefend_216B2A0: // 0x0216B2A0
	stmdb sp!, {r3, lr}
	ldr r3, [r1, #0x1c]
	ldr ip, [r0, #0x1c]
	cmp r3, #0
	cmpne ip, #0
	ldmeqia sp!, {r3, pc}
	ldrh r2, [ip]
	cmp r2, #1
	ldmneia sp!, {r3, pc}
	ldr r2, [r3, #0x340]
	ldrh r3, [r2, #2]
	cmp r3, #0x91
	bne _0216B2E0
	ldr r2, [ip, #0xc8]
	cmp r2, #0
	bgt _0216B2F4
_0216B2E0:
	cmp r3, #0x93
	bne _0216B2FC
	ldr r2, [ip, #0xc8]
	cmp r2, #0
	bge _0216B2FC
_0216B2F4:
	bl ObjRect__FuncNoHit
	ldmia sp!, {r3, pc}
_0216B2FC:
	mov r0, ip
	bl Player__Func_20210D0
	ldmia sp!, {r3, pc}
	arm_func_end Halfpipe__OnDefend_216B2A0

	.data
	
aActAcGmkHalfPi: // 0x02189414
	.asciz "/act/ac_gmk_half_pipe.bac"
	.align 4