	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start GrabTree__Create
GrabTree__Create: // 0x0216B308
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, _0216B580 // =0x000010F6
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x4e0
	ldr r0, _0216B584 // =StageTask_Main
	ldr r1, _0216B588 // =GameObject__Destructor
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
	mov r2, #0x4e0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xb4
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x11
	orr r1, r1, #0x200
	str r1, [r4, #0x20]
	bl GetObjectFileWork
	str r0, [sp]
	ldr r1, _0216B58C // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1]
	add r1, r4, #0x364
	str r2, [sp, #4]
	ldr r2, _0216B590 // =aModGmkGstTreeN
	mov r3, #0
	bl ObjAction3dNNModelLoad
	mov r0, #0xb5
	bl GetObjectFileWork
	mov r3, r0
	ldr r1, _0216B58C // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1]
	add r1, r4, #0x364
	str r2, [sp]
	ldr r2, _0216B594 // =aModGmkGstTreeN_0
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [sp]
	ldr r2, [r0, #0x148]
	mov r3, r1
	bl AnimatorMDL__SetAnimation
	mov r0, #0xb6
	bl GetObjectFileWork
	mov r3, r0
	ldr r1, _0216B58C // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1]
	add r1, r4, #0x364
	str r2, [sp]
	ldr r2, _0216B598 // =aModGmkGstTreeN_1
	bl ObjAction3dNNMotionLoad
	ldr r0, [r4, #0x12c]
	mov r3, #0
	str r3, [sp]
	mov r1, #4
	ldr r2, [r0, #0x158]
	bl AnimatorMDL__SetAnimation
	ldr r0, _0216B59C // =0x000034CC
	str r0, [r4, #0x37c]
	str r0, [r4, #0x380]
	str r0, [r4, #0x384]
	ldr r1, _0216B5A0 // =GrabTree__RenderCallback_216B5B4
	mov r5, #3
	add r0, r4, #0x3f4
	mov r2, #0
	mov r3, #6
	str r5, [sp]
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0x10
	sub r1, r3, #0x20
	mov r2, r1
	add r0, r4, #0x218
	str r3, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _0216B5A4 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _0216B5A8 // =GrabTree__OnDefend_216BAB4
	mov r5, #0x80
	str r0, [r4, #0x23c]
	ldr r1, [r4, #0x230]
	add r0, r4, #0x258
	orr r1, r1, #0x1400
	str r1, [r4, #0x230]
	ldr r2, [r4, #0x44]
	sub r1, r5, #0x100
	mov r2, r2, asr #0xc
	str r2, [r4, #0x224]
	ldr r3, [r4, #0x48]
	sub r2, r5, #0xc0
	mov r3, r3, asr #0xc
	str r3, [r4, #0x228]
	ldr r6, [r4, #0x4c]
	mov r3, #0x100
	mov r6, r6, asr #0xc
	str r6, [r4, #0x22c]
	str r4, [r4, #0x274]
	str r5, [sp]
	bl ObjRect__SetBox2D
	add r0, r4, #0x258
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x258
	ldr r1, _0216B5A4 // =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _0216B5AC // =GrabTree__OnDefend_216BA1C
	ldr r1, _0216B5B0 // =GrabTree__Draw
	str r0, [r4, #0x27c]
	ldr r2, [r4, #0x270]
	mov r0, r4
	orr r2, r2, #0x1400
	str r2, [r4, #0x270]
	ldr r2, [r4, #0x44]
	mov r2, r2, asr #0xc
	str r2, [r4, #0x264]
	ldr r2, [r4, #0x48]
	mov r2, r2, asr #0xc
	str r2, [r4, #0x268]
	ldr r2, [r4, #0x4c]
	mov r2, r2, asr #0xc
	str r2, [r4, #0x26c]
	str r1, [r4, #0xfc]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216B580: .word 0x000010F6
_0216B584: .word StageTask_Main
_0216B588: .word GameObject__Destructor
_0216B58C: .word gameArchiveStage
_0216B590: .word aModGmkGstTreeN
_0216B594: .word aModGmkGstTreeN_0
_0216B598: .word aModGmkGstTreeN_1
_0216B59C: .word 0x000034CC
_0216B5A0: .word GrabTree__RenderCallback_216B5B4
_0216B5A4: .word 0x0000FFFE
_0216B5A8: .word GrabTree__OnDefend_216BAB4
_0216B5AC: .word GrabTree__OnDefend_216BA1C
_0216B5B0: .word GrabTree__Draw
	arm_func_end GrabTree__Create

	arm_func_start GrabTree__RenderCallback_216B5B4
GrabTree__RenderCallback_216B5B4: // 0x0216B5B4
	stmdb sp!, {r4, lr}
	ldr r2, _0216B5DC // =aTree03
	mov r1, #0x1e
	mov r4, r0
	bl AkMath__Func_2002C40
	cmp r0, #0
	movne r0, #0
	strne r0, [r4, #0x24]
	strneb r0, [r4, #0x92]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B5DC: .word aTree03
	arm_func_end GrabTree__RenderCallback_216B5B4

	arm_func_start GrabTree__State_216B5E0
GrabTree__State_216B5E0: // 0x0216B5E0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x8c]
	ldr r4, [r5, #0x12c]
	mov r0, r0, asr #0xc
	str r0, [r5, #0x224]
	ldr r0, [r5, #0x90]
	mov r0, r0, asr #0xc
	str r0, [r5, #0x228]
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #0x32
	bne _0216B66C
	mov r1, #0
	str r1, [r5, #0x234]
	ldr r2, [r5, #0x230]
	add r0, r4, #0x100
	orr r2, r2, #0x800
	str r2, [r5, #0x230]
	ldrh ip, [r0, #0xc]
	mov r2, #0x66
	mov r3, r1
	orr ip, ip, #4
	strh ip, [r0, #0xc]
	strh r2, [r0, #0x30]
	str r1, [r4, #0x118]
	ldr r0, [r5, #0x12c]
	str r1, [sp]
	ldr r2, [r0, #0x148]
	bl AnimatorMDL__SetAnimation
	ldr r0, [r5, #0x354]
	orr r0, r0, #1
	str r0, [r5, #0x354]
	b _0216B688
_0216B66C:
	cmp r0, #0x46
	bne _0216B688
	ldr r0, [r5, #0x354]
	tst r0, #1
	ldrne r0, [r5, #0x20]
	orrne r0, r0, #0x200
	strne r0, [r5, #0x20]
_0216B688:
	ldr r0, [r5, #0x354]
	tst r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r4, #0x100
	ldrh r1, [r0, #0xc]
	tst r1, #0x4000
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r2, [r5, #0x20]
	mov r1, #0
	orr r2, r2, #0x10
	str r2, [r5, #0x20]
	ldr r3, [r5, #0x354]
	mov r2, #0x800
	bic r3, r3, #1
	str r3, [r5, #0x354]
	ldrh ip, [r0, #0xc]
	mov r3, r1
	orr ip, ip, #4
	strh ip, [r0, #0xc]
	strh r2, [r0, #0x30]
	ldr r0, [r5, #0x12c]
	str r1, [sp]
	ldr r2, [r0, #0x148]
	bl AnimatorMDL__SetAnimation
	ldr r0, [r5, #0x12c]
	mov r3, #0
	str r3, [sp]
	ldr r2, [r0, #0x158]
	mov r1, #4
	bl AnimatorMDL__SetAnimation
	mov r0, #0x1000
	str r0, [r4, #0x118]
	mov r2, #0
	str r2, [r5, #0x234]
	ldr r1, [r5, #0x230]
	ldr r0, _0216B72C // =GrabTree__State_216B730
	orr r1, r1, #0x800
	str r1, [r5, #0x230]
	str r2, [r5, #0x2c]
	str r0, [r5, #0xf4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216B72C: .word GrabTree__State_216B730
	arm_func_end GrabTree__State_216B5E0

	arm_func_start GrabTree__State_216B730
GrabTree__State_216B730: // 0x0216B730
	ldr r1, [r0, #0x2c]
	add r1, r1, #1
	str r1, [r0, #0x2c]
	cmp r1, #0x3c
	bxlt lr
	str r0, [r0, #0x274]
	ldr r2, [r0, #0x270]
	mov r1, #0
	bic r2, r2, #0x800
	str r2, [r0, #0x270]
	str r1, [r0, #0xf4]
	bx lr
	arm_func_end GrabTree__State_216B730

	arm_func_start GrabTree__State_216B760
GrabTree__State_216B760: // 0x0216B760
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr ip, [r4, #0x12c]
	ldr r0, [ip, #0xe4]
	ldr r0, [r0]
	cmp r0, #0x91000
	blt _0216B7B8
	ldr r0, [r4, #0x24]
	tst r0, #1
	bne _0216B7B8
	orr r1, r0, #1
	mov r0, #0x8000
	str r1, [r4, #0x24]
	str r0, [r4, #0x98]
	sub r0, r0, #0x10000
	str r0, [r4, #0x9c]
	ldr r0, [r4, #0x12c]
	add r0, r0, #0x90
	bl NNS_G3dRenderObjResetCallBack
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
_0216B7B8:
	ldr r0, [r4, #0x20]
	tst r0, #8
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, pc}
	add r0, ip, #0x100
	ldrh r3, [r0, #0xc]
	mov r1, #0
	mov r2, #0x88
	orr r3, r3, #4
	strh r3, [r0, #0xc]
	strh r2, [r0, #0x30]
	str r1, [ip, #0x118]
	ldr r0, [r4, #0x12c]
	mov r3, r1
	str r1, [sp]
	ldr r2, [r0, #0x148]
	bl AnimatorMDL__SetAnimation
	ldr r0, [r4, #0x12c]
	mov r3, #0
	str r3, [sp]
	ldr r2, [r0, #0x158]
	mov r1, #4
	bl AnimatorMDL__SetAnimation
	mov r1, #0
	ldr r0, _0216B82C // =GrabTree__State_216B830
	str r1, [r4, #0x2c]
	str r0, [r4, #0xf4]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0216B82C: .word GrabTree__State_216B830
	arm_func_end GrabTree__State_216B760

	arm_func_start GrabTree__State_216B830
GrabTree__State_216B830: // 0x0216B830
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x2c]
	ldr r4, [r5, #0x12c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #0xa
	ldreq r0, [r5, #0x20]
	orreq r0, r0, #0x200
	streq r0, [r5, #0x20]
	add r0, r4, #0x100
	ldrh r1, [r0, #0xc]
	tst r1, #0x4000
	ldmeqia sp!, {r3, r4, r5, pc}
	orr r1, r1, #4
	strh r1, [r0, #0xc]
	mov r1, #0x800
	strh r1, [r0, #0x30]
	mov r1, #0
	ldr r0, [r5, #0x12c]
	mov r3, r1
	str r1, [sp]
	ldr r2, [r0, #0x148]
	bl AnimatorMDL__SetAnimation
	ldr r0, [r5, #0x12c]
	mov r3, #0
	str r3, [sp]
	ldr r2, [r0, #0x158]
	mov r1, #4
	bl AnimatorMDL__SetAnimation
	mov r0, #0x1000
	str r0, [r4, #0x118]
	ldr r1, [r5, #0x20]
	mov r0, #3
	orr r1, r1, #0x10
	str r1, [r5, #0x20]
	ldr r2, [r5, #0x24]
	ldr r1, _0216B900 // =GrabTree__RenderCallback_216B5B4
	bic r2, r2, #1
	str r2, [r5, #0x24]
	str r0, [sp]
	add r0, r4, #0x90
	mov r2, #0
	mov r3, #6
	bl NNS_G3dRenderObjSetCallBack
	str r5, [r5, #0x274]
	ldr r1, [r5, #0x270]
	mov r0, #0
	bic r1, r1, #0x800
	str r1, [r5, #0x270]
	str r0, [r5, #0xf4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216B900: .word GrabTree__RenderCallback_216B5B4
	arm_func_end GrabTree__State_216B830

	arm_func_start GrabTree__Draw
GrabTree__Draw: // 0x0216B904
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x70
	bl GetCurrentTaskWork_
	mov r5, r0
	bl StageTask__Draw
	mov r3, #2
	add r1, sp, #4
	mov r0, #0x10
	mov r2, #1
	str r3, [sp, #4]
	bl NNS_G3dGeBufferOP_N
	mov r3, #0x1e
	add r1, sp, #0
	mov r0, #0x14
	mov r2, #1
	str r3, [sp]
	bl NNS_G3dGeBufferOP_N
	add r0, sp, #0x40
	add r1, sp, #0x1c
	bl NNS_G3dGetCurrentMtx
	ldr r0, _0216BA18 // =g_obj
	ldr r2, [r0, #0x40]
	cmp r2, #0
	beq _0216B974
	add r0, sp, #0xc
	add r1, sp, #8
	blx r2
	b _0216B984
_0216B974:
	ldr r1, [r0, #0x2c]
	str r1, [sp, #0xc]
	ldr r0, [r0, #0x30]
	str r0, [sp, #8]
_0216B984:
	mov r0, #0
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	mov ip, #0
	mov r4, r0
	add r0, sp, #0x10
	mov r3, #0x38000
	add r1, sp, #0x1c
	mov r2, r0
	str ip, [sp, #0x10]
	str r3, [sp, #0x14]
	str ip, [sp, #0x18]
	bl MTX_MultVec33
	ldr r1, [sp, #0xc]
	ldr r0, [sp, #0x64]
	ldr r2, [r4, #0x20]
	add r0, r1, r0
	ldr r1, [sp, #0x10]
	add r0, r2, r0
	add r0, r1, r0
	str r0, [r5, #0x8c]
	ldr r2, [sp, #8]
	ldr r0, [sp, #0x68]
	ldr r1, [r4, #0x24]
	sub r2, r2, r0
	ldr r0, [sp, #0x14]
	sub r1, r2, r1
	sub r0, r1, r0
	str r0, [r5, #0x90]
	ldr r1, [sp, #0x6c]
	ldr r0, [r4, #0x28]
	ldr r2, [sp, #0x18]
	add r0, r1, r0
	add r0, r2, r0
	str r0, [r5, #0x94]
	add sp, sp, #0x70
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216BA18: .word g_obj
	arm_func_end GrabTree__Draw

	arm_func_start GrabTree__OnDefend_216BA1C
GrabTree__OnDefend_216BA1C: // 0x0216BA1C
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr r2, [r1, #0x1c]
	ldr r1, [r0, #0x1c]
	cmp r2, #0
	cmpne r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, pc}
	ldrh r0, [r1]
	cmp r0, #1
	ldreqb r0, [r1, #0x5d1]
	cmpeq r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, pc}
	mov r0, #0
	str r0, [r2, #0x274]
	ldr r1, [r2, #0x270]
	mov ip, #0x4e
	orr r1, r1, #0x800
	str r1, [r2, #0x270]
	ldr r3, [r2, #0x20]
	sub r1, ip, #0x4f
	bic r3, r3, #0x210
	str r3, [r2, #0x20]
	str r2, [r2, #0x234]
	ldr lr, [r2, #0x230]
	ldr r3, _0216BAB0 // =GrabTree__State_216B5E0
	bic lr, lr, #0x800
	str lr, [r2, #0x230]
	str r3, [r2, #0xf4]
	str r0, [r2, #0x2c]
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216BAB0: .word GrabTree__State_216B5E0
	arm_func_end GrabTree__OnDefend_216BA1C

	arm_func_start GrabTree__OnDefend_216BAB4
GrabTree__OnDefend_216BAB4: // 0x0216BAB4
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5]
	cmp r0, #1
	ldreqb r0, [r5, #0x5d1]
	cmpeq r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	mov r1, r4
	str r5, [r4, #0x35c]
	bl Player__Func_2021188
	mov r0, r5
	mov r1, r4
	bl Player__Action_AllowTrickCombos
	mov r2, #0
	str r2, [r4, #0x234]
	ldr r1, [r4, #0x230]
	ldr r0, _0216BB20 // =GrabTree__State_216B760
	orr r1, r1, #0x800
	str r1, [r4, #0x230]
	str r0, [r4, #0xf4]
	str r2, [r4, #0x2c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216BB20: .word GrabTree__State_216B760
	arm_func_end GrabTree__OnDefend_216BAB4

	.rodata
	
aTree03: // 0x0218858C
	.asciz "tree_03"
	
_02188594:
	.word 0x00, 0x00

	.data
	
aModGmkGstTreeN: // 0x02189430
	.asciz "/mod/gmk_gst_tree.nsbmd"
	.align 4
	
aModGmkGstTreeN_0: // 0x02189448
	.asciz "/mod/gmk_gst_tree.nsbca"
	.align 4
	
aModGmkGstTreeN_1: // 0x02189460
	.asciz "/mod/gmk_gst_tree.nsbva"
	.align 4