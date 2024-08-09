	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start ItemBox3D__Create
ItemBox3D__Create: // 0x0216FE38
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r4, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r5, _02170074 // =0x00000578
	ldr r0, _02170078 // =StageTask_Main
	ldr r1, _0217007C // =ItemBox3D__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r5, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	mov r0, r5
	bl GetTaskWork_
	ldr r2, _02170074 // =0x00000578
	mov r5, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r5
	mov r1, r7
	mov r2, r6
	mov r3, r4
	bl GameObject__InitFromObject
	ldr r1, [r5, #0x1c]
	mov r0, #0xbe
	orr r1, r1, #0x2100
	str r1, [r5, #0x1c]
	ldr r1, [r5, #0x20]
	orr r1, r1, #0x100
	str r1, [r5, #0x20]
	ldr r1, [r5, #0x18]
	orr r1, r1, #0x10
	str r1, [r5, #0x18]
	bl GetObjectFileWork
	ldr r2, _02170080 // =gameArchiveStage
	ldr r1, _02170084 // =aActAcItmBox3dB
	ldr r2, [r2]
	bl ObjDataLoad
	mov r4, r0
	mov r0, #0x200
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r6, r0
	mov r0, #0x10
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #0x840
	stmia sp, {r1, r6}
	mov r1, #0
	str r0, [sp, #8]
	add r0, r5, #0x370
	mov r2, r4
	mov r3, r1
	bl AnimatorSprite3D__Init
	mov r0, #0x1d
	strb r0, [r5, #0x37a]
	mov r0, #7
	strb r0, [r5, #0x37b]
	ldr r1, [r5, #0x464]
	add r0, r5, #0x370
	orr r1, r1, #0x8000
	str r1, [r5, #0x464]
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, [r5, #0x43c]
	mov r1, #0
	orr r0, r0, #0x10
	str r0, [r5, #0x43c]
	mov r0, #0x80
	add r6, r5, #0x74
	bl VRAMSystem__AllocTexture
	mov r8, r0
	mov r0, #0x10
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #0x840
	stmia sp, {r1, r8}
	str r0, [sp, #8]
	ldrsb r1, [r7, #6]
	mov r2, r4
	add r0, r6, #0x400
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r1, #0
	bl AnimatorSprite3D__Init
	mov r0, #0x1d
	strb r0, [r6, #0x40a]
	mov r0, #7
	strb r0, [r6, #0x40b]
	ldr r0, [r6, #0x4f4]
	mov r1, #0
	orr r0, r0, #0x8000
	str r0, [r6, #0x4f4]
	mov r2, r1
	add r0, r6, #0x400
	bl AnimatorSprite3D__ProcessAnimation
	ldr r1, [r6, #0x4cc]
	mov r3, #4
	orr r1, r1, #0x10
	str r1, [r6, #0x4cc]
	ldr r0, _02170088 // =ItemBox3D__Draw
	sub r1, r3, #0x11
	str r0, [r5, #0xfc]
	str r5, [r5, #0x234]
	mov r0, #0xd
	str r0, [sp]
	mov r0, #0xc
	stmib sp, {r0, r3}
	sub r2, r3, #0x12
	add r0, r5, #0x218
	sub r3, r3, #8
	bl ObjRect__SetBox3D
	mov r1, #0
	add r0, r5, #0x218
	mov r2, r1
	bl ObjRect__SetAttackStat
	ldr r1, _0217008C // =0x0000FFFE
	add r0, r5, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, [r5, #0x230]
	ldr r0, _02170090 // =ItemBox3D__ppDef_21701EC
	orr r1, r1, #0x400
	str r1, [r5, #0x230]
	str r0, [r5, #0x23c]
	ldr r1, _02170094 // =ItemBox3D__State_21700D4
	mov r0, r5
	str r1, [r5, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02170074: .word 0x00000578
_02170078: .word StageTask_Main
_0217007C: .word ItemBox3D__Destructor
_02170080: .word gameArchiveStage
_02170084: .word aActAcItmBox3dB
_02170088: .word ItemBox3D__Draw
_0217008C: .word 0x0000FFFE
_02170090: .word ItemBox3D__ppDef_21701EC
_02170094: .word ItemBox3D__State_21700D4
	arm_func_end ItemBox3D__Create

	arm_func_start ItemBox3D__Destructor
ItemBox3D__Destructor: // 0x02170098
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x370
	bl AnimatorSprite3D__Release
	add r0, r4, #0x74
	add r0, r0, #0x400
	bl AnimatorSprite3D__Release
	mov r0, #0xbe
	bl GetObjectFileWork
	bl ObjDataRelease
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ItemBox3D__Destructor

	arm_func_start ItemBox3D__State_21700D4
ItemBox3D__State_21700D4: // 0x021700D4
	ldr r1, [r0, #0x28]
	ldr r2, _02170114 // =FX_SinCosTable_
	add r3, r1, #0x400
	mov r1, r3, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r2, [r2, r1]
	mov r1, #0x61
	str r3, [r0, #0x28]
	smulbb r1, r2, r1
	mov r1, r1, asr #4
	str r1, [r0, #0x54]
	bx lr
	.align 2, 0
_02170114: .word FX_SinCosTable_
	arm_func_end ItemBox3D__State_21700D4

	arm_func_start ItemBox3D__Draw
ItemBox3D__Draw: // 0x02170118
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x20
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x11c]
	ldr r0, [r4, #0x20]
	cmp r1, #0
	str r0, [sp, #0x10]
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, pc}
	ldr r0, [r1, #0x18]
	tst r0, #0xc
	addne sp, sp, #0x20
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x44
	add r3, sp, #0x14
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r2, [sp, #0x14]
	ldr r0, [r4, #0x50]
	ldr r1, [sp, #0x18]
	add r0, r2, r0
	str r0, [sp, #0x14]
	ldr r0, [r4, #0x54]
	ldr r2, [sp, #0x1c]
	add r0, r1, r0
	str r0, [sp, #0x18]
	ldr r1, [r4, #0x58]
	add r0, r4, #0x20
	add r1, r2, r1
	str r1, [sp, #0x1c]
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r2, [sp, #8]
	mov r1, r3
	add r0, r4, #0x370
	add r3, r4, #0x38
	str r2, [sp, #0xc]
	bl StageTask__Draw3DEx
	add r1, sp, #0x10
	str r1, [sp]
	mov r2, #0
	add r0, r4, #0x74
	str r2, [sp, #4]
	str r2, [sp, #8]
	add r1, sp, #0x14
	add r0, r0, #0x400
	add r3, r4, #0x38
	str r2, [sp, #0xc]
	bl StageTask__Draw3DEx
	add sp, sp, #0x20
	ldmia sp!, {r4, pc}
	arm_func_end ItemBox3D__Draw

	arm_func_start ItemBox3D__ppDef_21701EC
ItemBox3D__ppDef_21701EC: // 0x021701EC
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	cmp r5, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5]
	cmp r0, #1
	ldreqb r0, [r5, #0x5d1]
	cmpeq r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	mov ip, #0x29
	sub r1, ip, #0x2a
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	mov r1, #0
	mov r0, r4
	mov r2, r1
	mov r3, #1
	bl CreateEffectExplosion
	ldr r1, [r4, #0x340]
	mov r0, r4
	ldrsb r2, [r1, #6]
	mov r1, r5
	bl BreakItemBox
	ldr r0, [r4, #0x340]
	ldrsb r0, [r0, #6]
	bl CreateItemBoxReward
	ldr r0, [r4, #0x18]
	orr r0, r0, #0xa
	str r0, [r4, #0x18]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ItemBox3D__ppDef_21701EC

	.data
	
aActAcItmBox3dB: // 0x021896A4
	.asciz "/act/ac_itm_box3d.bac"
	.align 4