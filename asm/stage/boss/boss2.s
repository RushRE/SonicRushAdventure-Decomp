	.include "asm/macros.inc"
	.include "global.inc"

.public BossArena__explosionFXSpawnTime

	.bss

_0217AF80: // 0x0217AF80
	.space 0x04

_0217AF84: // 0x0217AF84
	.space 0x04

	.text

	arm_func_start Boss2Stage__Create
Boss2Stage__Create: // 0x0215AECC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, lr}
	sub sp, sp, #0x7c
	mov r3, #0x1500
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r2, #0
	str r3, [sp]
	mov r7, #2
	str r7, [sp, #4]
	mov r7, #0x660
	ldr r0, _0215B1B0 // =StageTask_Main
	ldr r1, _0215B1B4 // =ovl01_215C7B0
	mov r3, r2
	str r7, [sp, #8]
	bl TaskCreate_
	ldr r1, _0215B1B8 // =_0217AF80
	str r0, [r1, #4]
	bl GetTaskWork_
	mov sb, r0
	mov r0, #0
	mov r1, sb
	mov r2, r7
	bl MIi_CpuClear16
	mov r1, r6
	mov r0, sb
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	ldr r1, _0215B1BC // =ovl01_215C788
	ldr r0, _0215B1C0 // =ovl01_215C840
	str r1, [sb, #0xf4]
	str r0, [sb, #0xfc]
	ldr r0, [sb, #0x18]
	mov r1, #0x400
	orr r0, r0, #0x12
	str r0, [sb, #0x18]
	ldr r2, [sb, #0x1c]
	add r0, sb, #0x300
	orr r2, r2, #0xa300
	str r2, [sb, #0x1c]
	strh r1, [r0, #0x98]
	rsb r6, r4, #0
	ldr r1, _0215B1C4 // =ovl01_215C938
	str r6, [sb, #0x39c]
	add r0, sb, #0x364
	str r1, [sb, #0x394]
	bl ovl01_215BEE8
	add r0, sb, #0x3a0
	bl BossHelpers__Light__Init
	bl BossHelpers__Model__InitSystem
	add r0, sb, #0x3d8
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r1, _0215B1C8 // =bossAssetFiles
	str r2, [sp]
	ldr r1, [r1, #0x30]
	add r0, sb, #0x3d8
	mov r3, r2
	bl AnimatorMDL__SetResource
	mov r1, #0
	str r1, [sb, #0x420]
	str r6, [sb, #0x424]
	add r0, sb, #0x11c
	add r6, r0, #0x400
	ldr r2, _0215B1CC // =0x000034CC
	str r1, [sb, #0x428]
	str r2, [sb, #0x3f0]
	str r2, [sb, #0x3f4]
	mov r0, r6
	str r2, [sb, #0x3f8]
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r1, _0215B1C8 // =bossAssetFiles
	str r2, [sp]
	ldr r1, [r1, #0x38]
	mov r0, r6
	mov r3, r2
	bl AnimatorMDL__SetResource
	add r0, sb, #0x420
	add r3, r6, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, sb, #0x3f0
	add r3, r6, #0x18
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	ldr r0, _0215B1D0 // =0x00000116
	mov r1, r5
	mov r2, r4
	str r3, [sp, #0x10]
	bl GameObject__SpawnObject
	str r0, [sb, #0x370]
	str sb, [r0, #0x370]
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	mov r0, #0x118
	mov r1, r5
	mov r2, r4
	str r3, [sp, #0x10]
	bl GameObject__SpawnObject
	mov sl, #0
	str r0, [sb, #0x380]
	ldr r7, _0215B1D4 // =0x00000117
	str sb, [r0, #0x370]
	mov r8, sl
	mov r6, sl
_0215B09C:
	str r8, [sp]
	str r8, [sp, #4]
	str r8, [sp, #8]
	mov r0, r7
	mov r1, r5
	mov r2, r4
	mov r3, r8
	str r8, [sp, #0xc]
	and ip, sl, #0xff
	str ip, [sp, #0x10]
	bl GameObject__SpawnObject
	add r1, sb, sl, lsl #2
	str r0, [r1, #0x374]
	str sb, [r0, #0x370]
	str r6, [sp]
	str r6, [sp, #4]
	str r6, [sp, #8]
	str r6, [sp, #0xc]
	and r0, sl, #0xff
	str r0, [sp, #0x10]
	mov r1, r5
	mov r2, r4
	mov r3, r6
	add r0, r7, #2
	bl GameObject__SpawnObject
	add r1, sb, sl, lsl #2
	add sl, sl, #1
	str r0, [r1, #0x384]
	str sb, [r0, #0x370]
	cmp sl, #3
	blt _0215B09C
	ldr r2, _0215B1D8 // =_mt_math_rand
	ldr r0, _0215B1DC // =0x00196225
	ldr r3, [r2]
	ldr r1, _0215B1E0 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	mvnne r2, #0
	ldr r0, [sb, #0x374]
	moveq r2, #1
	mov r1, #0
	bl ovl01_215EBF0
	ldr r0, [sb, #0x384]
	bl ovl01_215F944
	ldr r0, [sb, #0x384]
	add r0, r0, #0x380
	bl ovl01_216009C
	ldr r1, _0215B1E4 // =gameArchiveStage
	add r0, sp, #0x14
	ldr r2, [r1]
	ldr r1, _0215B1E8 // =_0217A7FC
	bl NNS_FndMountArchive
	add r0, sp, #0x14
	mov r1, #0x1f
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultSetup
	add r0, sp, #0x14
	bl NNS_FndUnmountArchive
	bl InitSpatialAudioConfig
	ldr r1, _0215B1EC // =renderCoreSwapBuffer
	mov r2, #1
	mov r0, sb
	str r2, [r1, #4]
	add sp, sp, #0x7c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
	.align 2, 0
_0215B1B0: .word StageTask_Main
_0215B1B4: .word ovl01_215C7B0
_0215B1B8: .word _0217AF80
_0215B1BC: .word ovl01_215C788
_0215B1C0: .word ovl01_215C840
_0215B1C4: .word ovl01_215C938
_0215B1C8: .word bossAssetFiles
_0215B1CC: .word 0x000034CC
_0215B1D0: .word 0x00000116
_0215B1D4: .word 0x00000117
_0215B1D8: .word _mt_math_rand
_0215B1DC: .word 0x00196225
_0215B1E0: .word 0x3C6EF35F
_0215B1E4: .word gameArchiveStage
_0215B1E8: .word _0217A7FC
_0215B1EC: .word renderCoreSwapBuffer
	arm_func_end Boss2Stage__Create

	arm_func_start Boss2__Create
Boss2__Create: // 0x0215B1F0
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x74
	mov r1, #0x1500
	mov r6, r0
	str r1, [sp]
	mov r0, #2
	mov r5, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _0215B474 // =0x000006E8
	ldr r0, _0215B478 // =StageTask_Main
	ldr r1, _0215B47C // =ovl01_215D020
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r8, r0
	mov r2, r4
	mov r1, r8
	mov r0, #0
	bl MIi_CpuClear16
	ldr r3, _0215B480 // =0xFFDB7000
	mov r1, r6
	mov r0, r8
	mov r2, #0
	add r3, r5, r3
	bl GameObject__InitFromObject
	ldr r1, _0215B484 // =ovl01_215CF58
	ldr r0, _0215B488 // =ovl01_215D06C
	str r1, [r8, #0xf4]
	str r0, [r8, #0xfc]
	ldr r0, _0215B48C // =ovl01_215C880
	mov r2, #0
	str r0, [r8, #0x108]
	ldr r1, [r8, #0x18]
	mov r0, #0xbc00
	orr r1, r1, #0x10
	str r1, [r8, #0x18]
	ldr r3, [r8, #0x1c]
	ldr r1, _0215B490 // =0x00003120
	orr r3, r3, #0x8300
	str r3, [r8, #0x1c]
	str r2, [r8, #0x494]
	str r0, [r8, #0x498]
	str r0, [r8, #0x49c]
	add r0, r8, #0x300
	strh r1, [r0, #0xcc]
	add r0, r8, #0x364
	bl ovl01_215BEE8
	mov r1, #0
	add r0, r8, #0x218
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r8, #0x218
	mov r1, #2
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r3, #8
	sub r1, r3, #0x10
	add r0, r8, #0x218
	mov r2, r1
	str r3, [sp]
	bl ObjRect__SetBox2D
	ldr r0, _0215B494 // =ovl01_215C8F4
	str r8, [r8, #0x234]
	str r0, [r8, #0x23c]
	ldr r1, [r8, #0x230]
	add r4, r8, #0x1a4
	bic r1, r1, #4
	str r1, [r8, #0x230]
	add r0, r4, #0x400
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _0215B498 // =bossAssetFiles
	str r2, [sp]
	ldr r1, [r0]
	mov r3, r2
	add r0, r4, #0x400
	bl AnimatorMDL__SetResource
	ldr r1, _0215B49C // =0x000034CC
	mov r0, #4
	str r1, [r4, #0x418]
	str r1, [r4, #0x41c]
	str r1, [r4, #0x420]
	strb r0, [r4, #0x40a]
	mov r5, #3
	ldr r1, _0215B4A0 // =BossHelpers__Model__RenderCallback
	add r0, r4, #0x490
	mov r2, #0
	mov r3, #6
	str r5, [sp]
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0x494]
	ldr r1, _0215B4A4 // =aBody
	mov r2, #0x1e
	bl BossHelpers__Model__Init
	str r8, [sp]
	ldr r0, [r4, #0x494]
	ldr r1, _0215B4A8 // =aBodyA
	ldr r3, _0215B4AC // =ovl01_215D1B4
	mov r2, #0x1d
	bl BossHelpers__Model__Init
	str r8, [sp]
	ldr r0, [r4, #0x494]
	ldr r1, _0215B4B0 // =aBodyB
	ldr r3, _0215B4B4 // =ovl01_215D1FC
	mov r2, #0x1c
	bl BossHelpers__Model__Init
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0x494]
	ldr r1, _0215B4B8 // =aWeak_0
	mov r2, #0x1b
	bl BossHelpers__Model__Init
	ldr r2, _0215B4BC // =gameArchiveStage
	ldr r1, _0215B4C0 // =_0217A7FC
	ldr r2, [r2]
	add r0, sp, #0xc
	bl NNS_FndMountArchive
	add r0, r8, #0xa4
	ldr r6, _0215B4C4 // =_0217A798
	ldr r4, _0215B498 // =bossAssetFiles
	mov sb, #0
	add sl, r0, #0x400
	add fp, sp, #0xc
	mov r5, #5
_0215B3F4:
	mov r0, fp
	add r1, sb, #0xc
	bl NNS_FndGetArchiveFileByIndex
	mov r7, r0
	ldr r0, [r4]
	bl NNS_G3dGetTex
	ldr r1, [r6, sb, lsl #2]
	bl Asset3DSetup__PaletteFromName
	str r5, [sp]
	mov r2, #0
	str r0, [sp, #4]
	mov r1, r7
	mov r0, sl
	mov r3, r2
	bl InitPaletteAnimator
	add sb, sb, #1
	add sl, sl, #0x20
	cmp sb, #8
	blt _0215B3F4
	add r0, r8, #0xa4
	mov r2, #0
	mov r3, r2
	add r0, r0, #0x400
	mov r1, #8
	bl BossHelpers__Palette__Func_2038BAC
	add r0, sp, #0xc
	bl NNS_FndUnmountArchive
	mov r0, r8
	bl ovl01_215D244
	mov r0, r8
	add sp, sp, #0x74
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_0215B474: .word 0x000006E8
_0215B478: .word StageTask_Main
_0215B47C: .word ovl01_215D020
_0215B480: .word 0xFFDB7000
_0215B484: .word ovl01_215CF58
_0215B488: .word ovl01_215D06C
_0215B48C: .word ovl01_215C880
_0215B490: .word 0x00003120
_0215B494: .word ovl01_215C8F4
_0215B498: .word bossAssetFiles
_0215B49C: .word 0x000034CC
_0215B4A0: .word BossHelpers__Model__RenderCallback
_0215B4A4: .word aBody
_0215B4A8: .word aBodyA
_0215B4AC: .word ovl01_215D1B4
_0215B4B0: .word aBodyB
_0215B4B4: .word ovl01_215D1FC
_0215B4B8: .word aWeak_0
_0215B4BC: .word gameArchiveStage
_0215B4C0: .word _0217A7FC
_0215B4C4: .word _0217A798
	arm_func_end Boss2__Create

	arm_func_start Boss2Arm__Create
Boss2Arm__Create: // 0x0215B4C8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r4, #0x1500
	mov r8, r0
	mov r7, r1
	mov r6, r2
	str r4, [sp]
	mov r4, #2
	ldr r0, _0215B620 // =StageTask_Main
	ldr r1, _0215B624 // =ovl01_215EADC
	mov r2, #0
	mov r5, r3
	mov r3, r2
	str r4, [sp, #4]
	mov r4, #0x510
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x510
	bl MIi_CpuClear16
	mov r1, r8
	mov r2, r7
	mov r3, r6
	mov r0, r4
	bl GameObject__InitFromObject
	ldr r1, _0215B628 // =ovl01_215E8DC
	ldr r0, _0215B62C // =ovl01_215EAFC
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r1, [r4, #0x18]
	mov r0, #0x400
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	ldr r2, [r4, #0x1c]
	add r1, r4, #0x300
	orr r2, r2, #0x8300
	str r2, [r4, #0x1c]
	str r5, [r4, #0x384]
	strh r0, [r1, #0xc6]
	mov r3, r5, lsl #1
	ldr r2, _0215B630 // =_02179D14
	add r0, r4, #0x364
	ldrsh r2, [r2, r3]
	strh r2, [r1, #0xc4]
	bl ovl01_215BEE8
	add r5, r4, #0x3cc
	mov r0, r5
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	str r2, [sp]
	mov r0, r5
	ldr r1, _0215B634 // =bossAssetFiles
	mov r3, r2
	ldr r1, [r1, #8]
	bl AnimatorMDL__SetResource
	mov r2, #0
	str r2, [r5, #0x48]
	str r2, [r5, #0x4c]
	str r2, [r5, #0x50]
	ldr r1, _0215B638 // =0x000034CC
	mov r0, #4
	str r1, [r5, #0x18]
	str r1, [r5, #0x1c]
	str r1, [r5, #0x20]
	strb r0, [r5, #0xa]
	mov r0, #3
	str r0, [sp]
	add r0, r5, #0x90
	ldr r1, _0215B63C // =BossHelpers__Model__RenderCallback
	mov r3, #6
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	ldr r0, [r5, #0x94]
	ldr r1, _0215B640 // =aArmBall
	mov r2, #0x1e
	bl BossHelpers__Model__Init
	mov r0, r4
	bl ovl01_215EBA8
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215B620: .word StageTask_Main
_0215B624: .word ovl01_215EADC
_0215B628: .word ovl01_215E8DC
_0215B62C: .word ovl01_215EAFC
_0215B630: .word _02179D14
_0215B634: .word bossAssetFiles
_0215B638: .word 0x000034CC
_0215B63C: .word BossHelpers__Model__RenderCallback
_0215B640: .word aArmBall
	arm_func_end Boss2Arm__Create

	arm_func_start Boss2Drop__Create
Boss2Drop__Create: // 0x0215B644
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r0, #2
	ldr r4, _0215B744 // =0x000004CC
	str r0, [sp, #4]
	ldr r0, _0215B748 // =StageTask_Main
	ldr r1, _0215B74C // =ovl01_215E128
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	ldr r2, _0215B744 // =0x000004CC
	bl MIi_CpuClear16
	mov r1, r7
	mov r2, r6
	mov r3, r5
	mov r0, r4
	bl GameObject__InitFromObject
	mov r0, #0x40000
	str r0, [r4, #0xdc]
	ldr r1, _0215B750 // =ovl01_215E118
	ldr r0, _0215B754 // =ovl01_215E148
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r1, [r4, #0x18]
	add r0, r4, #0x364
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x8300
	str r1, [r4, #0x1c]
	bl ovl01_215BEE8
	add r0, r4, #0x384
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	str r2, [sp]
	add r0, r4, #0x384
	ldr r1, _0215B758 // =bossAssetFiles
	mov r3, r2
	ldr r1, [r1, #0x10]
	bl AnimatorMDL__SetResource
	mov r0, #0
	str r0, [r4, #0x3cc]
	str r0, [r4, #0x3d0]
	str r0, [r4, #0x3d4]
	ldr r1, _0215B75C // =0x000034CC
	mov r0, r4
	str r1, [r4, #0x39c]
	str r1, [r4, #0x3a0]
	str r1, [r4, #0x3a4]
	bl ovl01_215E1E8
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215B744: .word 0x000004CC
_0215B748: .word StageTask_Main
_0215B74C: .word ovl01_215E128
_0215B750: .word ovl01_215E118
_0215B754: .word ovl01_215E148
_0215B758: .word bossAssetFiles
_0215B75C: .word 0x000034CC
	arm_func_end Boss2Drop__Create

	arm_func_start Boss2Ball__Create
Boss2Ball__Create: // 0x0215B760
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xa4
	mov r6, #0x1500
	mov r7, r0
	str r6, [sp]
	mov r0, #2
	mov r5, r1
	mov r4, r2
	str r0, [sp, #4]
	ldr r6, _0215BB2C // =0x00000988
	ldr r0, _0215BB30 // =StageTask_Main
	ldr r1, _0215BB34 // =ovl01_215F3A8
	mov r2, #0
	mov r8, r3
	mov r3, r2
	str r6, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r6, r0
	ldr r2, _0215BB2C // =0x00000988
	mov r0, #0
	mov r1, r6
	bl MIi_CpuClear16
	mov r1, r7
	mov r2, r5
	mov r3, r4
	mov r0, r6
	bl GameObject__InitFromObject
	ldr r1, _0215BB38 // =ovl01_215F368
	ldr r0, _0215BB3C // =ovl01_215F400
	str r1, [r6, #0xf4]
	str r0, [r6, #0xfc]
	ldr r0, _0215BB40 // =ovl01_215F54C
	str r0, [r6, #0x108]
	ldr r0, [r6, #0x18]
	orr r0, r0, #0x10
	str r0, [r6, #0x18]
	ldr r0, [r6, #0x1c]
	orr r0, r0, #0xa300
	str r0, [r6, #0x1c]
	bl AllocSndHandle
	str r0, [r6, #0x984]
	str r8, [r6, #0x37c]
	mov r0, #3
	str r0, [r6, #0x384]
	ldr r1, _0215BB44 // =ovl01_2160354
	add r0, r6, #0x380
	str r1, [r6, #0x380]
	bl ovl01_2160090
	add r0, r6, #0x364
	bl ovl01_215BEE8
	ldr r4, _0215BB48 // =_02179CE4
	add r3, sp, #0x24
	mov r2, #6
_0215B838:
	ldrh r1, [r4]
	ldrh r0, [r4, #2]
	add r4, r4, #4
	strh r1, [r3]
	strh r0, [r3, #2]
	add r3, r3, #4
	subs r2, r2, #1
	bne _0215B838
	add r5, sp, #0x24
	add r0, r6, #0x218
	mov r1, #2
	mov r2, #0
	mov r4, r8, lsl #3
	add r7, r5, r8, lsl #3
	bl ObjRect__SetAttackStat
	mov r1, #0
	mov r2, r1
	add r0, r6, #0x218
	bl ObjRect__SetDefenceStat
	ldrsh r1, [r7, #6]
	add r0, r6, #0x218
	str r1, [sp]
	ldrsh r1, [r5, r4]
	ldrsh r2, [r7, #2]
	ldrsh r3, [r7, #4]
	bl ObjRect__SetBox2D
	ldr r1, _0215BB4C // =ovl01_215F614
	str r6, [r6, #0x234]
	str r1, [r6, #0x23c]
	ldr r2, [r6, #0x230]
	add r0, r6, #0x258
	orr r2, r2, #0x80
	bic r2, r2, #4
	str r2, [r6, #0x230]
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	add r0, r6, #0x258
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldrsh r1, [r7, #6]
	add r0, r6, #0x258
	str r1, [sp]
	ldrsh r1, [r5, r4]
	ldrsh r2, [r7, #2]
	ldrsh r3, [r7, #4]
	bl ObjRect__SetBox2D
	str r6, [r6, #0x274]
	ldr r0, [r6, #0x270]
	add r4, r6, #0x1b8
	bic r0, r0, #4
	str r0, [r6, #0x270]
	add r0, r4, #0x400
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #0
	ldr r1, _0215BB50 // =bossAssetFiles
	str r3, [sp]
	ldr r1, [r1, #0x18]
	add r0, r4, #0x400
	mov r2, r8
	bl AnimatorMDL__SetResource
	mov r5, #0
	str r5, [r4, #0x448]
	str r5, [r4, #0x44c]
	ldr r0, _0215BB54 // =0x000034CC
	str r5, [r4, #0x450]
	str r0, [r4, #0x418]
	str r0, [r4, #0x41c]
	str r0, [r4, #0x420]
	ldr r0, _0215BB58 // =_02179C80
	add r3, sp, #0x18
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #4
	mov r2, r5
	strb r0, [r4, #0x40a]
	mov r5, #3
	ldr r1, _0215BB5C // =BossHelpers__Model__RenderCallback
	add r0, r4, #0x490
	mov r3, #6
	str r5, [sp]
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	add r1, sp, #0x18
	ldr r0, [r4, #0x494]
	ldr r1, [r1, r8, lsl #2]
	mov r2, #0x1e
	bl BossHelpers__Model__Init
	add r0, r6, #0x394
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #0
	ldr r1, _0215BB50 // =bossAssetFiles
	str r3, [sp]
	ldr r1, [r1, #0x20]
	add r0, r6, #0x394
	mov r2, r8
	bl AnimatorMDL__SetResource
	mov r4, #0
	str r4, [r6, #0x3dc]
	str r4, [r6, #0x3e0]
	str r4, [r6, #0x3e4]
	mov r0, #0x1000
	str r0, [r6, #0x3ac]
	str r0, [r6, #0x3b0]
	str r0, [r6, #0x3b4]
	ldr r0, _0215BB60 // =_02179C8C
	add r3, sp, #0xc
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r5, r6, #0x2fc
	mov r1, r4
	add r0, r5, #0x400
	bl AnimatorMDL__Init
	mov r3, r4
	ldr r1, _0215BB50 // =bossAssetFiles
	str r3, [sp]
	ldr r1, [r1, #0x18]
	add r0, r5, #0x400
	mov r2, #3
	bl AnimatorMDL__SetResource
	mov r1, r4
	str r1, [r5, #0x448]
	str r1, [r5, #0x44c]
	str r1, [r5, #0x450]
	add r0, sp, #0xc
	ldr r4, [r0, r8, lsl #2]
	ldr r2, _0215BB64 // =0x00149FB0
	str r4, [r5, #0x418]
	str r2, [r5, #0x41c]
	add r0, r6, #0x840
	str r4, [r5, #0x420]
	bl AnimatorMDL__Init
	mov r3, #0
	ldr r1, _0215BB50 // =bossAssetFiles
	str r3, [sp]
	ldr r1, [r1, #0x18]
	add r0, r6, #0x840
	mov r2, #4
	bl AnimatorMDL__SetResource
	mov r0, #0
	strb r0, [r6, #0x84a]
	str r0, [r6, #0x888]
	str r0, [r6, #0x88c]
	str r0, [r6, #0x890]
	ldr r0, _0215BB64 // =0x00149FB0
	str r4, [r6, #0x858]
	str r0, [r6, #0x85c]
	ldr r0, _0215BB68 // =gameArchiveStage
	str r4, [r6, #0x860]
	ldr r2, [r0]
	ldr r1, _0215BB6C // =_0217A7FC
	add r0, sp, #0x3c
	bl NNS_FndMountArchive
	add r0, sp, #0x3c
	add r1, r8, #9
	bl NNS_FndGetArchiveFileByIndex
	ldr r1, _0215BB50 // =bossAssetFiles
	mov r4, r0
	ldr r0, [r1, #0x18]
	bl NNS_G3dGetTex
	ldr r1, _0215BB70 // =_0217A78C
	ldr r1, [r1, r8, lsl #2]
	bl Asset3DSetup__PaletteFromName
	mov r2, #5
	str r2, [sp]
	str r0, [sp, #4]
	add r0, r6, #0x198
	mov r1, r4
	add r0, r0, #0x400
	mov r2, #0
	mov r3, #2
	bl InitPaletteAnimator
	add r0, r6, #0x198
	mov r2, #0
	add r0, r0, #0x400
	mov r1, #1
	mov r3, r2
	bl BossHelpers__Palette__Func_2038BAC
	add r0, sp, #0x3c
	bl NNS_FndUnmountArchive
	mov r0, r6
	bl ovl01_215F924
	mov r0, r6
	add sp, sp, #0xa4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215BB2C: .word 0x00000988
_0215BB30: .word StageTask_Main
_0215BB34: .word ovl01_215F3A8
_0215BB38: .word ovl01_215F368
_0215BB3C: .word ovl01_215F400
_0215BB40: .word ovl01_215F54C
_0215BB44: .word ovl01_2160354
_0215BB48: .word _02179CE4
_0215BB4C: .word ovl01_215F614
_0215BB50: .word bossAssetFiles
_0215BB54: .word 0x000034CC
_0215BB58: .word _02179C80
_0215BB5C: .word BossHelpers__Model__RenderCallback
_0215BB60: .word _02179C8C
_0215BB64: .word 0x00149FB0
_0215BB68: .word gameArchiveStage
_0215BB6C: .word _0217A7FC
_0215BB70: .word _0217A78C
	arm_func_end Boss2Ball__Create

	arm_func_start Boss2Bomb__Create
Boss2Bomb__Create: // 0x0215BB74
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r0, #2
	ldr r4, _0215BCE0 // =0x00000514
	str r0, [sp, #4]
	ldr r0, _0215BCE4 // =StageTask_Main
	ldr r1, _0215BCE8 // =ovl01_21605C0
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	ldr r2, _0215BCE0 // =0x00000514
	bl MIi_CpuClear16
	mov r1, r7
	mov r2, r6
	mov r3, r5
	mov r0, r4
	bl GameObject__InitFromObject
	mov r0, #0x40000
	str r0, [r4, #0xdc]
	ldr r1, _0215BCEC // =ovl01_21605B0
	ldr r0, _0215BCF0 // =ovl01_21605E0
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r1, _0215BCF4 // =ovl01_2160664
	add r0, r4, #0x364
	str r1, [r4, #0x108]
	ldr r1, [r4, #0x18]
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x280
	orr r1, r1, #0x8000
	str r1, [r4, #0x1c]
	bl ovl01_215BEE8
	mov r2, #0
	str r2, [sp]
	mov r0, r4
	sub r1, r2, #8
	sub r2, r2, #0x14
	mov r3, #8
	bl StageTask__SetHitbox
	add r0, r4, #0x218
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	mov r2, #0
	str r2, [sp]
	add r0, r4, #0x218
	sub r1, r2, #0xf
	sub r2, r2, #0x18
	mov r3, #0xf
	bl ObjRect__SetBox2D
	str r4, [r4, #0x234]
	ldr r0, _0215BCF8 // =ovl01_21606DC
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	bic r0, r0, #4
	str r0, [r4, #0x230]
	add r0, r4, #0x3d0
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _0215BCFC // =bossAssetFiles
	str r2, [sp]
	ldr r1, [r0, #0x28]
	mov r3, r2
	add r0, r4, #0x3d0
	bl AnimatorMDL__SetResource
	ldr r1, _0215BD00 // =0x000034CC
	mov r0, r4
	str r1, [r4, #0x3e8]
	str r1, [r4, #0x3ec]
	str r1, [r4, #0x3f0]
	bl ovl01_216071C
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215BCE0: .word 0x00000514
_0215BCE4: .word StageTask_Main
_0215BCE8: .word ovl01_21605C0
_0215BCEC: .word ovl01_21605B0
_0215BCF0: .word ovl01_21605E0
_0215BCF4: .word ovl01_2160664
_0215BCF8: .word ovl01_21606DC
_0215BCFC: .word bossAssetFiles
_0215BD00: .word 0x000034CC
	arm_func_end Boss2Bomb__Create

	arm_func_start Boss2Wave__Create
Boss2Wave__Create: // 0x0215BD04
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x74
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _0215BE84 // =0x000004A8
	ldr r0, _0215BE88 // =StageTask_Main
	ldr r1, _0215BE8C // =ovl01_2160A24
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _0215BE84 // =0x000004A8
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r1, r7
	mov r2, r6
	mov r0, r4
	mov r3, r5
	bl GameObject__InitFromObject
	mov r0, #0x40000
	str r0, [r4, #0xdc]
	ldr r1, _0215BE90 // =ovl01_21609AC
	ldr r0, _0215BE94 // =ovl01_2160A44
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r1, [r4, #0x18]
	add r0, sp, #0xc
	orr r1, r1, #0x12
	str r1, [r4, #0x18]
	ldr r2, [r4, #0x1c]
	ldr r1, _0215BE98 // =_0217A7FC
	orr r2, r2, #0x8300
	str r2, [r4, #0x1c]
	ldr r2, _0215BE9C // =gameArchiveStage
	ldr r2, [r2]
	bl NNS_FndMountArchive
	add r0, r4, #0x364
	mov r1, #0
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #0x1f
	bl NNS_FndGetArchiveFileByIndex
	mov r2, #0
	mov r1, r0
	add r0, r4, #0x364
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	add r0, sp, #0xc
	mov r1, #0x20
	bl NNS_FndGetArchiveFileByIndex
	mov r1, #0
	mov r2, r0
	add r0, r4, #0x364
	mov r3, r1
	str r1, [sp]
	bl AnimatorMDL__SetAnimation
	add r0, sp, #0xc
	mov r1, #0x21
	bl NNS_FndGetArchiveFileByIndex
	mov r2, r0
	mov r3, #0
	add r0, r4, #0x364
	mov r1, #1
	str r3, [sp]
	bl AnimatorMDL__SetAnimation
	add r0, sp, #0xc
	mov r1, #0x22
	bl NNS_FndGetArchiveFileByIndex
	mov r2, r0
	mov r3, #0
	add r0, r4, #0x364
	mov r1, #4
	str r3, [sp]
	bl AnimatorMDL__SetAnimation
	rsb r1, r5, #0
	str r1, [r4, #0x3b0]
	ldr r0, _0215BEA0 // =0x000034CC
	ldr r1, _0215BEA4 // =0x00000666
	str r0, [r4, #0x37c]
	str r0, [r4, #0x380]
	str r0, [r4, #0x384]
	add r0, sp, #0xc
	str r1, [r4, #0x47c]
	bl NNS_FndUnmountArchive
	mov r0, r4
	add sp, sp, #0x74
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215BE84: .word 0x000004A8
_0215BE88: .word StageTask_Main
_0215BE8C: .word ovl01_2160A24
_0215BE90: .word ovl01_21609AC
_0215BE94: .word ovl01_2160A44
_0215BE98: .word _0217A7FC
_0215BE9C: .word gameArchiveStage
_0215BEA0: .word 0x000034CC
_0215BEA4: .word 0x00000666
	arm_func_end Boss2Wave__Create

	arm_func_start ovl01_215BEA8
ovl01_215BEA8: // 0x0215BEA8
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x20]
	tst r1, #0x20
	ldmneia sp!, {r3, pc}
	ldr r2, _0215BEDC // =0x00722543
	ldr r3, _0215BEE0 // =0x001187BC
	mov r1, #0x40000
	bl BossHelpers__Arena__Func_2038EBC
	ldr r0, _0215BEE4 // =_0217AF80
	ldr r0, [r0]
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215BEDC: .word 0x00722543
_0215BEE0: .word 0x001187BC
_0215BEE4: .word _0217AF80
	arm_func_end ovl01_215BEA8

	arm_func_start ovl01_215BEE8
ovl01_215BEE8: // 0x0215BEE8
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x68
	mov r4, r0
	bl MapFarSys__GetAsset
	str r0, [r4]
	ldr r1, _0215BF40 // =gameArchiveStage
	add r0, sp, #0
	ldr r2, [r1]
	ldr r1, _0215BF44 // =_0217A7FC
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #7
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #4]
	add r0, sp, #0
	mov r1, #8
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #8]
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	add sp, sp, #0x68
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215BF40: .word gameArchiveStage
_0215BF44: .word _0217A7FC
	arm_func_end ovl01_215BEE8

	arm_func_start ovl01_215BF48
ovl01_215BF48: // 0x0215BF48
	add r0, r0, #0x300
	ldrsh r3, [r0, #0x98]
	ldr r2, _0215BF80 // =_02179C6A
	mov r0, #0
_0215BF58:
	mov r1, r0, lsl #1
	ldrsh r1, [r2, r1]
	cmp r1, r3
	bxlt lr
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #3
	blo _0215BF58
	bx lr
	.align 2, 0
_0215BF80: .word _02179C6A
	arm_func_end ovl01_215BF48

	arm_func_start ovl01_215BF84
ovl01_215BF84: // 0x0215BF84
	ldr r0, _0215BF98 // =gameState
	ldr r1, _0215BF9C // =_02179C78
	ldr r0, [r0, #0x18]
	ldr r0, [r1, r0, lsl #2]
	bx lr
	.align 2, 0
_0215BF98: .word gameState
_0215BF9C: .word _02179C78
	arm_func_end ovl01_215BF84

	arm_func_start ovl01_215BFA0
ovl01_215BFA0: // 0x0215BFA0
	stmdb sp!, {r4, lr}
	mov r4, r1
	bl ovl01_215BF48
	ldr r2, _0215BFC4 // =_02179CFC
	mov r1, #6
	mla r1, r0, r1, r2
	mov r0, r4, lsl #1
	ldrh r0, [r0, r1]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215BFC4: .word _02179CFC
	arm_func_end ovl01_215BFA0

	arm_func_start ovl01_215BFC8
ovl01_215BFC8: // 0x0215BFC8
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl ovl01_215BF84
	mov r4, r0
	mov r0, r6
	mov r1, r5
	bl ovl01_215BFA0
	mul r0, r4, r0
	mov r0, r0, lsl #4
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl01_215BFC8

	arm_func_start ovl01_215BFF8
ovl01_215BFF8: // 0x0215BFF8
	ldr r0, _0215C004 // =_02179CA4
	ldr r0, [r0, r1, lsl #2]
	bx lr
	.align 2, 0
_0215C004: .word _02179CA4
	arm_func_end ovl01_215BFF8

	arm_func_start ovl01_215C008
ovl01_215C008: // 0x0215C008
	stmdb sp!, {r4, lr}
	ldr r2, _0215C054 // =gameState
	mov r4, r1
	ldr r1, [r2, #0x14]
	cmp r1, #3
	ldreq r1, [r2, #0x70]
	cmpeq r1, #0xf
	bne _0215C038
	ldr r0, _0215C058 // =_02179D26
	mov r1, r4, lsl #1
	ldrsh r0, [r0, r1]
	ldmia sp!, {r4, pc}
_0215C038:
	bl ovl01_215BF48
	ldr r2, _0215C05C // =_02179D14
	mov r1, #6
	mla r1, r0, r1, r2
	mov r0, r4, lsl #1
	ldrsh r0, [r0, r1]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C054: .word gameState
_0215C058: .word _02179D26
_0215C05C: .word _02179D14
	arm_func_end ovl01_215C008

	arm_func_start ovl01_215C060
ovl01_215C060: // 0x0215C060
	ldr r0, _0215C094 // =gameState
	ldr r2, [r0, #0x14]
	cmp r2, #3
	ldreq r0, [r0, #0x70]
	cmpeq r0, #0xf
	ldrne r0, _0215C098 // =_02179C64
	movne r1, r1, lsl #1
	ldrnesh r0, [r0, r1]
	bxne lr
	ldr r0, _0215C09C // =_02179C70
	mov r1, r1, lsl #1
	ldrsh r0, [r0, r1]
	bx lr
	.align 2, 0
_0215C094: .word gameState
_0215C098: .word _02179C64
_0215C09C: .word _02179C70
	arm_func_end ovl01_215C060

	arm_func_start ovl01_215C0A0
ovl01_215C0A0: // 0x0215C0A0
	stmdb sp!, {r4, r5, r6, lr}
	ldr ip, _0215C0F8 // =gameState
	mov r6, r1
	ldr r1, [ip, #0x14]
	mov r5, r2
	cmp r1, #3
	ldreq r1, [ip, #0x70]
	mov r4, r3
	cmpeq r1, #0xf
	ldreq r0, _0215C0FC // =_02179D90
	addeq r1, r0, r6, lsl #2
	beq _0215C0E4
	bl ovl01_215BF48
	ldr r2, _0215C100 // =_02179D6C
	mov r1, #0xc
	mla r1, r0, r1, r2
	add r1, r1, r6, lsl #2
_0215C0E4:
	ldrh r0, [r1]
	strh r0, [r5]
	ldrh r0, [r1, #2]
	strh r0, [r4]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215C0F8: .word gameState
_0215C0FC: .word _02179D90
_0215C100: .word _02179D6C
	arm_func_end ovl01_215C0A0

	arm_func_start ovl01_215C104
ovl01_215C104: // 0x0215C104
	stmdb sp!, {r4, lr}
	ldr r1, _0215C188 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r2, [r1, #0x70]
	cmpeq r2, #0xf
	bne _0215C134
	ldr r0, [r1, #0x18]
	ldr r1, _0215C18C // =_02179D2C
	add r0, r1, r0, lsl #4
	add r4, r0, #0xc
	b _0215C14C
_0215C134:
	bl ovl01_215BF48
	ldr r1, _0215C188 // =gameState
	ldr r2, _0215C18C // =_02179D2C
	ldr r1, [r1, #0x18]
	add r1, r2, r1, lsl #4
	add r4, r1, r0, lsl #2
_0215C14C:
	ldr r2, _0215C190 // =_mt_math_rand
	ldr r0, _0215C194 // =0x00196225
	ldr ip, [r2]
	ldr r1, _0215C198 // =0x3C6EF35F
	ldrh r3, [r4, #2]
	mla lr, ip, r0, r1
	mov r0, lr, lsr #0x10
	mov r0, r0, lsl #0x10
	ldrh r1, [r4]
	and r0, r3, r0, lsr #16
	str lr, [r2]
	add r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C188: .word gameState
_0215C18C: .word _02179D2C
_0215C190: .word _mt_math_rand
_0215C194: .word 0x00196225
_0215C198: .word 0x3C6EF35F
	arm_func_end ovl01_215C104

	arm_func_start ovl01_215C19C
ovl01_215C19C: // 0x0215C19C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl01_215BF48
	ldr r0, _0215C22C // =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #3
	ldreq r1, [r0, #0x70]
	cmpeq r1, #0xf
	bne _0215C1D4
	ldr r0, [r0, #0x18]
	ldr r1, _0215C230 // =_02179D4C
	add r0, r1, r0, lsl #4
	add r4, r0, #0xc
	b _0215C1F0
_0215C1D4:
	mov r0, r4
	bl ovl01_215BF48
	ldr r1, _0215C22C // =gameState
	ldr r2, _0215C230 // =_02179D4C
	ldr r1, [r1, #0x18]
	add r1, r2, r1, lsl #4
	add r4, r1, r0, lsl #2
_0215C1F0:
	ldr r2, _0215C234 // =_mt_math_rand
	ldr r0, _0215C238 // =0x00196225
	ldr ip, [r2]
	ldr r1, _0215C23C // =0x3C6EF35F
	ldrh r3, [r4, #2]
	mla lr, ip, r0, r1
	mov r0, lr, lsr #0x10
	mov r0, r0, lsl #0x10
	ldrh r1, [r4]
	and r0, r3, r0, lsr #16
	str lr, [r2]
	add r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C22C: .word gameState
_0215C230: .word _02179D4C
_0215C234: .word _mt_math_rand
_0215C238: .word 0x00196225
_0215C23C: .word 0x3C6EF35F
	arm_func_end ovl01_215C19C

	arm_func_start ovl01_215C240
ovl01_215C240: // 0x0215C240
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r1, [r4, #0x370]
	add r1, r1, #0x300
	ldrh r1, [r1, #0xc8]
	cmp r1, #0
	bne _0215C26C
	bl ovl01_215C104
	ldr r1, [r4, #0x370]
	add r1, r1, #0x300
	strh r0, [r1, #0xc8]
_0215C26C:
	ldr r0, [r4, #0x370]
	add r0, r0, #0x300
	ldrh r0, [r0, #0xca]
	cmp r0, #0
	bne _0215C294
	mov r0, r4
	bl ovl01_215C19C
	ldr r1, [r4, #0x370]
	add r1, r1, #0x300
	strh r0, [r1, #0xca]
_0215C294:
	mov r5, #0
_0215C298:
	add r0, r4, r5, lsl #2
	ldr r1, [r0, #0x374]
	mov r0, r4
	ldr r1, [r1, #0x384]
	bl ovl01_215C008
	add r1, r4, r5, lsl #2
	ldr r1, [r1, #0x374]
	add r5, r5, #1
	add r1, r1, #0x300
	strh r0, [r1, #0xc4]
	cmp r5, #3
	blt _0215C298
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_215C240

	arm_func_start ovl01_215C2CC
ovl01_215C2CC: // 0x0215C2CC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0xb8
	mov r5, r0
	mov r0, #0
	bl BossArena__GetCamera
	ldr r1, _0215C5E4 // =gPlayer
	mov r4, r0
	ldr r0, [r1]
	ldr r2, _0215C5E8 // =0x00722543
	ldr r0, [r0, #0x44]
	mov r1, #0x40000
	bl BossHelpers__Arena__Func_2038DCC
	mov r1, r0
	mov r0, r4
	bl BossArena__SetAngleTarget
	mov r0, #0
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	mov r4, r0
	add r1, sp, #0x4c
	mov r0, r5
	bl ovl01_215C6E0
	movs r6, r0
	beq _0215C548
	mov r2, #0
	str r2, [sp, #0x58]
	str r2, [sp, #0x5c]
	str r2, [sp, #0x60]
	cmp r6, #0
	bls _0215C390
	add r1, sp, #0x4c
_0215C348:
	ldr r0, [r1, r2, lsl #2]
	add r2, r2, #1
	ldr r7, [sp, #0x58]
	ldr r3, [r0, #0x4fc]
	mov r2, r2, lsl #0x10
	add r3, r7, r3
	str r3, [sp, #0x58]
	ldr r8, [sp, #0x5c]
	ldr r7, [r0, #0x500]
	ldr r3, [sp, #0x60]
	add r7, r8, r7
	str r7, [sp, #0x5c]
	ldr r0, [r0, #0x504]
	cmp r6, r2, lsr #16
	add r0, r3, r0
	str r0, [sp, #0x60]
	mov r2, r2, lsr #0x10
	bhi _0215C348
_0215C390:
	ldr r0, [sp, #0x58]
	mov r1, r6
	bl FX_DivS32
	str r0, [sp, #0x58]
	ldr r0, [sp, #0x5c]
	mov r1, r6
	bl FX_DivS32
	str r0, [sp, #0x5c]
	ldr r0, [sp, #0x60]
	mov r1, r6
	bl FX_DivS32
	str r0, [sp, #0x60]
	ldr sl, [r4, #0x2c]
	ldr r1, [sp, #0x58]
	ldr r3, _0215C5EC // =0x000004CC
	sub r7, r1, sl
	mov ip, #0
	umull sb, r8, r7, r3
	mla r8, r7, ip, r8
	mov r6, r7, asr #0x1f
	adds r7, sb, #0x800
	mla r8, r6, r3, r8
	adc r6, r8, #0
	mov r7, r7, lsr #0xc
	orr r7, r7, r6, lsl #20
	add r6, sl, r7
	str r6, [sp, #0x58]
	ldr lr, [sp, #0x5c]
	ldr r6, [r4, #0x30]
	mov fp, #0xcc
	sub r8, lr, r6
	umull sl, sb, r8, fp
	mla sb, r8, ip, sb
	mov r7, r8, asr #0x1f
	adds r8, sl, #0x800
	mla sb, r7, fp, sb
	adc r7, sb, #0
	mov r8, r8, lsr #0xc
	orr r8, r8, r7, lsl #20
	add r6, r6, r8
	str r6, [sp, #0x5c]
	ldr r6, [r4, #0x34]
	add r1, r4, #0x20
	sub r8, r0, r6
	umull sl, sb, r8, r3
	mla sb, r8, ip, sb
	mov r7, r8, asr #0x1f
	mla sb, r7, r3, sb
	adds r7, sl, #0x800
	adc r3, sb, #0
	mov r7, r7, lsr #0xc
	orr r7, r7, r3, lsl #20
	add r3, r6, r7
	add r2, sp, #0x40
	add r0, r4, #0x2c
	str r3, [sp, #0x60]
	bl VEC_Subtract
	add r0, sp, #0x58
	add r1, r4, #0x20
	add r2, sp, #0x34
	bl VEC_Subtract
	add r0, sp, #0x34
	add r1, sp, #0x28
	bl VEC_Normalize
	add r0, sp, #0x34
	add r1, sp, #0x40
	add r2, sp, #0x1c
	bl VEC_Subtract
	add r0, sp, #0x1c
	bl VEC_Mag
	ldr r2, _0215C5EC // =0x000004CC
	ldr r8, [sp, #0x58]
	ldr r1, [sp, #0x34]
	mov r6, #0
	sub r1, r8, r1
	umull sl, r8, r0, r2
	mla r8, r0, r6, r8
	mov sb, r0, asr #0x1f
	mla r8, sb, r2, r8
	adds r2, sl, #0x800
	ldr r7, [sp, #0x28]
	adc r0, r8, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	smull r8, r0, r7, r2
	adds r7, r8, #0x800
	adc r0, r0, #0
	mov r7, r7, lsr #0xc
	orr r7, r7, r0, lsl #20
	sub r0, r1, r7
	mov r3, #0x800
	str r0, [sp, #0x64]
	mov sb, r2, asr #0x1f
	ldr r1, [sp, #0x30]
	ldr r0, [sp, #0x5c]
	umull r8, r7, r1, r2
	mla r7, r1, sb, r7
	mov r1, r1, asr #0x1f
	adds r3, r8, r3
	mla r7, r1, r2, r7
	ldr sb, [sp, #0x60]
	ldr r8, [sp, #0x3c]
	adc r1, r7, r6
	mov r2, r3, lsr #0xc
	sub r3, sb, r8
	orr r2, r2, r1, lsl #20
	sub r1, r3, r2
	str r0, [sp, #0x68]
	str r1, [sp, #0x6c]
	b _0215C568
_0215C548:
	add r0, r4, #0x20
	ldmia r0, {r0, r1, r2}
	add r7, sp, #0x64
	add r3, sp, #0x58
	add r6, r4, #0x2c
	stmia r7, {r0, r1, r2}
	ldmia r6, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
_0215C568:
	ldr r1, _0215C5F0 // =0x00001555
	add r0, sp, #0xac
	str r1, [sp]
	str r0, [sp, #4]
	add r1, sp, #0xa0
	str r1, [sp, #8]
	add r0, sp, #0x94
	str r0, [sp, #0xc]
	add r1, sp, #0x88
	str r1, [sp, #0x10]
	add r0, sp, #0x7c
	str r0, [sp, #0x14]
	add r6, sp, #0x70
	ldr r3, _0215C5F4 // =0x0015E000
	add r0, sp, #0x64
	add r1, sp, #0x58
	add r2, r4, #0x38
	str r6, [sp, #0x18]
	bl BossArena__Func_2039AD4
	add r1, sp, #0xac
	add r2, sp, #0xa0
	add r3, sp, #0x94
	mov r0, r5
	bl ovl01_215C5F8
	add r1, sp, #0x88
	add r2, sp, #0x7c
	mov r3, r6
	mov r0, r5
	bl ovl01_215C66C
	add sp, sp, #0xb8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_0215C5E4: .word gPlayer
_0215C5E8: .word 0x00722543
_0215C5EC: .word 0x000004CC
_0215C5F0: .word 0x00001555
_0215C5F4: .word 0x0015E000
	arm_func_end ovl01_215C2CC

	arm_func_start ovl01_215C5F8
ovl01_215C5F8: // 0x0215C5F8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r0, #1
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #0
	bl BossArena__SetCameraType
	mov r1, r5
	mov r0, r4
	bl BossArena__SetUpVector
	mov r0, r4
	ldmia r6, {r1, r2, r3}
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	ldmia r7, {r1, r2, r3}
	bl BossArena__SetTracker0TargetPos
	ldr r1, _0215C664 // =0x00000199
	ldr r2, _0215C668 // =0x000004CC
	mov r0, r4
	bl BossArena__SetTracker1Speed
	ldr r1, _0215C664 // =0x00000199
	ldr r2, _0215C668 // =0x000004CC
	mov r0, r4
	bl BossArena__SetTracker0Speed
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215C664: .word 0x00000199
_0215C668: .word 0x000004CC
	arm_func_end ovl01_215C5F8

	arm_func_start ovl01_215C66C
ovl01_215C66C: // 0x0215C66C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r0, #2
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #0
	bl BossArena__SetCameraType
	mov r1, r5
	mov r0, r4
	bl BossArena__SetUpVector
	mov r0, r4
	ldmia r6, {r1, r2, r3}
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	ldmia r7, {r1, r2, r3}
	bl BossArena__SetTracker0TargetPos
	ldr r1, _0215C6D8 // =0x00000199
	ldr r2, _0215C6DC // =0x000004CC
	mov r0, r4
	bl BossArena__SetTracker1Speed
	ldr r1, _0215C6D8 // =0x00000199
	ldr r2, _0215C6DC // =0x000004CC
	mov r0, r4
	bl BossArena__SetTracker0Speed
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215C6D8: .word 0x00000199
_0215C6DC: .word 0x000004CC
	arm_func_end ovl01_215C66C

	arm_func_start ovl01_215C6E0
ovl01_215C6E0: // 0x0215C6E0
	stmdb sp!, {r3, lr}
	mov lr, #0
	mov ip, lr
_0215C6EC:
	add r2, r0, ip, lsl #2
	ldr r3, [r2, #0x384]
	ldr r2, [r3, #0x378]
	cmp r2, #2
	bne _0215C71C
	ldr r2, [r3, #0x590]
	cmp r2, #0x6000
	ble _0215C71C
	add r2, lr, #1
	mov r2, r2, lsl #0x10
	str r3, [r1, lr, lsl #2]
	mov lr, r2, lsr #0x10
_0215C71C:
	add ip, ip, #1
	cmp ip, #3
	blt _0215C6EC
	mov r0, lr
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_215C6E0

	arm_func_start ovl01_215C730
ovl01_215C730: // 0x0215C730
	stmdb sp!, {lr}
	sub sp, sp, #0x34
	mov r0, #1
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	mov r2, r0
	add ip, sp, #4
	add r0, r2, #0x20
	add r1, r2, #0x38
	add r2, r2, #0x2c
	mov r3, #0
	str ip, [sp]
	bl G3i_LookAt_
	add r0, sp, #4
	bl InitSpatialAudioMatrix
	ldr r0, _0215C784 // =gPlayer
	ldr r0, [r0]
	add r0, r0, #0x1b0
	bl SetSpatialAudioOriginPosition
	add sp, sp, #0x34
	ldmia sp!, {pc}
	.align 2, 0
_0215C784: .word gPlayer
	arm_func_end ovl01_215C730

	arm_func_start ovl01_215C788
ovl01_215C788: // 0x0215C788
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3a0
	bl BossHelpers__Light__Func_203954C
	mov r0, r4
	bl ovl01_215C730
	ldr r1, [r4, #0x394]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_215C788

	arm_func_start ovl01_215C7B0
ovl01_215C7B0: // 0x0215C7B0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x68
	mov r6, r0
	bl GetTaskWork_
	add r5, r0, #0x3d8
	mov r4, #0
_0215C7C8:
	mov r0, r5
	bl AnimatorMDL__Release
	add r4, r4, #1
	cmp r4, #2
	add r5, r5, #0x144
	blt _0215C7C8
	ldr r1, _0215C830 // =gameArchiveStage
	add r0, sp, #0
	ldr r2, [r1]
	ldr r1, _0215C834 // =_0217A7FC
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #0x1f
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultRelease
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	ldr r2, _0215C838 // =renderCoreSwapBuffer
	mov r3, #0
	ldr r1, _0215C83C // =_0217AF80
	mov r0, r6
	str r3, [r2, #4]
	str r3, [r1, #4]
	bl GameObject__Destructor
	add sp, sp, #0x68
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215C830: .word gameArchiveStage
_0215C834: .word _0217A7FC
_0215C838: .word renderCoreSwapBuffer
_0215C83C: .word _0217AF80
	arm_func_end ovl01_215C7B0

	arm_func_start ovl01_215C840
ovl01_215C840: // 0x0215C840
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x3a0
	bl BossHelpers__Light__SetLights2
	add r0, r4, #0x3d8
	bl AnimatorMDL__Draw
	add r0, r4, #0x11c
	add r0, r0, #0x400
	bl AnimatorMDL__Draw
	add r0, r4, #0x3a0
	bl BossHelpers__Light__SetLights1
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_215C840

	arm_func_start ovl01_215C880
ovl01_215C880: // 0x0215C880
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	bl GetCurrentTaskWork_
	mov r1, r0
	ldr r0, [r1, #0x18]
	tst r0, #0xc
	addne sp, sp, #8
	ldmneia sp!, {r3, pc}
	tst r0, #2
	addne sp, sp, #8
	ldmneia sp!, {r3, pc}
	ldr r0, [r1, #0x230]
	tst r0, #4
	addeq sp, sp, #8
	ldmeqia sp!, {r3, pc}
	ldr r0, _0215C8EC // =0x00722543
	add r2, r1, #0x88
	ldr ip, _0215C8F0 // =0x001187BC
	str r0, [sp]
	add r0, r1, #0x218
	add r1, r1, #0x388
	add r2, r2, #0x400
	mov r3, #0x40000
	str ip, [sp, #4]
	bl BossHelpers__Collision__Func_203919C
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215C8EC: .word 0x00722543
_0215C8F0: .word 0x001187BC
	arm_func_end ovl01_215C880

	arm_func_start ovl01_215C8F4
ovl01_215C8F4: // 0x0215C8F4
	stmdb sp!, {r4, lr}
	ldr r0, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r0]
	cmp r0, #1
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x370]
	mov r1, #0
	add r0, r0, #0x300
	strh r1, [r0, #0x98]
	ldr r0, [r4, #0x370]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0x98]
	bl UpdateBossHealthHUD
	mov r0, r4
	bl ovl01_215D2C4
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_215C8F4

	arm_func_start ovl01_215C938
ovl01_215C938: // 0x0215C938
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x2c
	ldr r1, _0215CCE0 // =_02179C98
	add r3, sp, #0x20
	mov r5, r0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r1, sp, #0
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClear16
	ldr r4, _0215CCE4 // =0x00001555
	mov r3, #0x1000
	sub r1, r3, #0x334
	mov r2, #0xa00000
	mov r0, #4
	str r3, [sp, #4]
	strh r4, [sp]
	str r2, [sp, #8]
	str r4, [sp, #0xc]
	str r1, [sp, #0x10]
	bl BossArena__SetType
	mov r0, #0
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #1
	bl BossArena__SetCameraType
	mov r0, r4
	add r1, sp, #0
	bl BossArena__SetCameraConfig
	ldr r1, _0215CCE8 // =gPlayer
	mov r0, r4
	ldr r1, [r1]
	mov r2, #0
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	ldr r2, [r5, #0x39c]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	add r2, r2, #0x118000
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r4
	mov r1, #1
	bl BossArena__SetTracker1UseObj3D
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	mov r1, #0xfa000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	bl BossArena__ApplyAmplitudeXZTarget
	mov r1, #0x1e000
	mov r0, r4
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	bl BossArena__ApplyAmplitudeYTarget
	ldr r0, _0215CCE8 // =gPlayer
	ldr r2, _0215CCEC // =0x00722543
	ldr r0, [r0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__Func_2038DCC
	mov r1, r0
	mov r0, r4
	bl BossArena__SetAngleTarget
	mov r0, r4
	bl BossArena__ApplyAngleTarget
	bl BossArena__Func_20397E4
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	bl BossArena__UpdateTracker0TargetPos
	mov r0, r5
	bl ovl01_215C2CC
	bl BossArena__Func_20397E4
	mov r0, r5
	bl ovl01_215C2CC
	mov r0, #1
	bl BossArena__GetCamera
	mov r4, r0
	add r1, sp, #0
	bl BossArena__SetCameraConfig
	mov r0, r4
	add r1, sp, #0x20
	bl BossArena__SetUpVector
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	bl BossArena__UpdateTracker0TargetPos
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	add r1, sp, #0
	bl BossArena__SetCameraConfig
	mov r0, r4
	add r1, sp, #0x20
	bl BossArena__SetUpVector
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	bl BossArena__UpdateTracker0TargetPos
	ldr r2, _0215CCF0 // =0x0400000A
	mov r0, #2
	ldrh r1, [r2]
	and r1, r1, #0x43
	orr r1, r1, #4
	orr r1, r1, #0x6000
	strh r1, [r2]
	bl BossArena__SetUnknown2Type
	bl BossArena__GetField4A8
	ldr r2, [r5, #0x364]
	mov r1, #1
	str r2, [r0, #4]
	strb r1, [r0, #0x14]
	mov r1, #0
	strh r1, [r0, #0x2c]
	strh r1, [r0, #0x2e]
	ldr r0, [r5, #0x364]
	bl GetBackgroundPixels
	ldr r2, _0215CCF4 // =VRAMSystem__VRAM_BG
	mov r1, #0
	ldr r2, [r2]
	add r2, r2, #0x4000
	bl LoadCompressedPixels
	ldr r0, [r5, #0x364]
	bl GetBackgroundPalette
	ldr r2, _0215CCF8 // =VRAMSystem__VRAM_PALETTE_BG
	mov r1, #0
	ldr r2, [r2]
	bl LoadCompressedPalette
	mov r0, #0
	sub r1, r0, #0xa0
	bl BossArena__Func_2039A94
	mov r2, #0x4000000
	ldr r0, [r2]
	and r0, r0, #0x1f00
	mov r0, r0, lsr #8
	ldr r1, [r2]
	orr r0, r0, #2
	bic r1, r1, #0x1f00
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bl Camera3D__Create
	bl Camera3D__GetWork
	mov r4, r0
	bl Camera3D__GetWork
	mov r1, #0
	strh r1, [r0, #0x7c]
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	ldr r3, _0215CCFC // =ovl01_215BEA8
	bic r1, r1, #1
	orr r1, r1, #1
	strh r1, [r0, #0x7c]
	ldrh r1, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r1, r1, lsl #0x1f
	mov r1, r1, lsr #0x1f
	bic r2, r2, #1
	and r1, r1, #1
	orr r1, r2, r1
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	orr r1, r1, #0x200
	strh r1, [r0, #0x7c]
	ldrh r1, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r1, r1, lsl #0x16
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x200
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #22
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	orr r1, r1, #0x400
	strh r1, [r0, #0x7c]
	ldrh r1, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r1, r1, lsl #0x15
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x400
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #21
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	orr r1, r1, #0x800
	strh r1, [r0, #0x7c]
	ldrh r1, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r1, r1, lsl #0x14
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x800
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #20
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	ldr r2, _0215CCE8 // =gPlayer
	orr r1, r1, #0x1000
	strh r1, [r0, #0x7c]
	ldrh r0, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	mov r0, r0, lsl #0x13
	mov r0, r0, lsr #0x1f
	bic r1, r1, #0x1000
	mov r0, r0, lsl #0x1f
	orr r0, r1, r0, lsr #19
	strh r0, [r4, #0x20]
	ldr ip, [r2]
	ldr r1, _0215CD00 // =_0217AF80
	ldr r4, [ip, #0xfc]
	add r0, r5, #0x300
	str r4, [r1]
	str r3, [ip, #0xfc]
	ldr r2, [r2]
	ldr r1, [r2, #0x20]
	orr r1, r1, #0x2000
	str r1, [r2, #0x20]
	ldrsh r0, [r0, #0x98]
	bl UpdateBossHealthHUD
	mov r0, #1
	bl SetHUDActiveScreen
	ldr r0, _0215CD04 // =ovl01_215CD08
	str r0, [r5, #0x394]
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0215CCE0: .word _02179C98
_0215CCE4: .word 0x00001555
_0215CCE8: .word gPlayer
_0215CCEC: .word 0x00722543
_0215CCF0: .word 0x0400000A
_0215CCF4: .word VRAMSystem__VRAM_BG
_0215CCF8: .word VRAMSystem__VRAM_PALETTE_BG
_0215CCFC: .word ovl01_215BEA8
_0215CD00: .word _0217AF80
_0215CD04: .word ovl01_215CD08
	arm_func_end ovl01_215C938

	arm_func_start ovl01_215CD08
ovl01_215CD08: // 0x0215CD08
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r1, _0215CE78 // =_02179CB0
	add r3, sp, #0
	mov r4, r0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #4
	bl BossArena__SetType
	mov r0, #0
	bl BossArena__GetCamera
	mov r1, #1
	mov r5, r0
	bl BossArena__SetCameraType
	ldr r1, _0215CE7C // =gPlayer
	mov r0, r5
	ldr r1, [r1]
	mov r2, #0
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	ldr r2, [r4, #0x39c]
	mov r1, #0
	mov r0, r5
	mov r3, r1
	add r2, r2, #0x118000
	bl BossArena__SetTracker1TargetPos
	mov r0, r5
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r5
	mov r1, #1
	bl BossArena__SetTracker1UseObj3D
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	mov r1, #0xfa000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r5
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r5
	bl BossArena__ApplyAmplitudeXZTarget
	mov r1, #0x1e000
	mov r0, r5
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r5
	bl BossArena__ApplyAmplitudeYTarget
	ldr r0, _0215CE7C // =gPlayer
	ldr r2, _0215CE80 // =0x00722543
	ldr r0, [r0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__Func_2038DCC
	mov r1, r0
	mov r0, r5
	bl BossArena__SetAngleTarget
	mov r0, r5
	bl BossArena__ApplyAngleTarget
	bl BossArena__Func_20397E4
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	mov r0, r4
	bl ovl01_215C2CC
	bl BossArena__Func_20397E4
	mov r0, r4
	bl ovl01_215C2CC
	mov r0, #1
	bl BossArena__GetCamera
	mov r5, r0
	add r1, sp, #0
	bl BossArena__SetUpVector
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	mov r0, #2
	bl BossArena__GetCamera
	add r1, sp, #0
	mov r5, r0
	bl BossArena__SetUpVector
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	ldr r0, _0215CE84 // =ovl01_215CE88
	str r0, [r4, #0x394]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0215CE78: .word _02179CB0
_0215CE7C: .word gPlayer
_0215CE80: .word 0x00722543
_0215CE84: .word ovl01_215CE88
	arm_func_end ovl01_215CD08

	arm_func_start ovl01_215CE88
ovl01_215CE88: // 0x0215CE88
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, [r0, #0x3d4]
	cmp r1, #0
	bne _0215CE9C
	bl ovl01_215C2CC
_0215CE9C:
	bl GetScreenShakeOffsetY
	mov r4, r0
	bl GetScreenShakeOffsetX
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, r5, asr #0x1f
	mov r1, r1, lsl #0xc
	orr r1, r1, r5, lsr #20
	mov r3, #0
	mov r2, #0x800
	adds ip, r2, r5, lsl #12
	adc r5, r1, #0
	mov r1, ip, lsr #0xc
	orr r1, r1, r5, lsl #20
	adds r2, r2, r4, lsl #12
	mov r2, r2, lsr #0xc
	mov r5, r4, asr #0x1f
	mov r5, r5, lsl #0xc
	orr r5, r5, r4, lsr #20
	adc r4, r5, #0
	orr r2, r2, r4, lsl #20
	bl BossArena__SetNextPos
	bl GetScreenShakeOffsetY
	mov r4, r0
	bl GetScreenShakeOffsetX
	mov r5, r0
	mov r0, #2
	bl BossArena__GetCamera
	mov r1, r5, asr #0x1f
	mov r1, r1, lsl #0xc
	orr r1, r1, r5, lsr #20
	mov r3, #0
	mov r2, #0x800
	adds lr, r2, r5, lsl #12
	adc ip, r1, #0
	mov r1, lr, lsr #0xc
	orr r1, r1, ip, lsl #20
	adds r2, r2, r4, lsl #12
	mov r2, r2, lsr #0xc
	mov ip, r4, asr #0x1f
	mov ip, ip, lsl #0xc
	orr ip, ip, r4, lsr #20
	adc r4, ip, #0
	orr r2, r2, r4, lsl #20
	bl BossArena__SetNextPos
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_215CE88

	arm_func_start ovl01_215CF58
ovl01_215CF58: // 0x0215CF58
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x494]
	cmp r1, #0
	beq _0215CF7C
	cmp r1, #1
	beq _0215CFB4
	cmp r1, #2
	beq _0215CFE4
	b _0215D014
_0215CF7C:
	ldr r1, [r0, #0x49c]
	cmp r1, #0xbc00
	bge _0215CF98
	add r1, r1, #0xcc
	add r1, r1, #0x400
	str r1, [r0, #0x49c]
	b _0215D014
_0215CF98:
	ldr r1, [r0, #0x498]
	cmp r1, #0xbc00
	bge _0215D014
	add r1, r1, #0xcc
	add r1, r1, #0x400
	str r1, [r0, #0x498]
	b _0215D014
_0215CFB4:
	ldr r1, [r0, #0x498]
	cmp r1, #0
	subgt r1, r1, #0xcc
	subgt r1, r1, #0x400
	strgt r1, [r0, #0x498]
	ldr r1, [r0, #0x49c]
	cmp r1, #0xbc00
	bge _0215D014
	add r1, r1, #0xcc
	add r1, r1, #0x400
	str r1, [r0, #0x49c]
	b _0215D014
_0215CFE4:
	ldr r1, [r0, #0x498]
	cmp r1, #0
	ble _0215D000
	sub r1, r1, #0xcc
	sub r1, r1, #0x400
	str r1, [r0, #0x498]
	b _0215D014
_0215D000:
	ldr r1, [r0, #0x49c]
	cmp r1, #0
	subgt r1, r1, #0xcc
	subgt r1, r1, #0x400
	strgt r1, [r0, #0x49c]
_0215D014:
	ldr r1, [r0, #0x380]
	blx r1
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_215CF58

	arm_func_start ovl01_215D020
ovl01_215D020: // 0x0215D020
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x1a4
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	add r0, r4, #0xa4
	add r5, r0, #0x400
	mov r4, #0
_0215D048:
	mov r0, r5
	bl ReleasePaletteAnimator
	add r4, r4, #1
	cmp r4, #8
	add r5, r5, #0x20
	blt _0215D048
	mov r0, r6
	bl GameObject__Destructor
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl01_215D020

	arm_func_start ovl01_215D06C
ovl01_215D06C: // 0x0215D06C
	stmdb sp!, {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	ldr r1, [r5, #0x20]
	tst r1, #0x20
	ldmneia sp!, {r4, r5, r6, pc}
	bl ovl01_215D168
	add r1, r5, #0x1a4
	ldr r3, [r5, #0x48]
	ldr r4, [r5, #0x4c]
	ldr r2, [r5, #0x44]
	add r6, r1, #0x400
	str r2, [r6, #0x48]
	rsb r1, r3, #0
	str r1, [r6, #0x4c]
	str r4, [r6, #0x50]
	add r1, r5, #0x300
	ldrh r1, [r1, #0xcc]
	mov r4, r0
	ldr r2, _0215D164 // =FX_SinCosTable_
	mov r0, r1, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r6, #0x24
	blx MTX_RotY33_
	mov r0, r6
	bl AnimatorMDL__ProcessAnimation
	cmp r4, #0
	beq _0215D134
	mov r0, r6
	bl AnimatorMDL__Draw
	add r1, r5, #0x3d4
	mov r0, #0x1e
	bl BossHelpers__Model__SetMatrixMode
	add r0, r5, #4
	add r1, r0, #0x400
	mov r0, #0x1d
	bl BossHelpers__Model__SetMatrixMode
	add r0, r5, #0x34
	add r1, r0, #0x400
	mov r0, #0x1c
	bl BossHelpers__Model__SetMatrixMode
	add r0, r5, #0x64
	add r1, r0, #0x400
	mov r0, #0x1b
	bl BossHelpers__Model__SetMatrixMode
_0215D134:
	add r0, r5, #0xa4
	add r5, r0, #0x400
	mov r4, #0
_0215D140:
	mov r0, r5
	bl AnimatePalette
	mov r0, r5
	bl DrawAnimatedPalette
	add r4, r4, #1
	cmp r4, #8
	add r5, r5, #0x20
	blt _0215D140
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215D164: .word FX_SinCosTable_
	arm_func_end ovl01_215D06C

	arm_func_start ovl01_215D168
ovl01_215D168: // 0x0215D168
	stmdb sp!, {r4, lr}
	ldr r1, [r0, #0x4a0]
	mov r4, #0
	cmp r1, #0
	beq _0215D1A4
	ldr r0, [r0, #0x384]
	cmp r0, #3
	cmpne r0, #4
	bne _0215D194
	mov r4, #1
	b _0215D1AC
_0215D194:
	bl Camera3D__UseEngineA
	cmp r0, #0
	movne r4, #1
	b _0215D1AC
_0215D1A4:
	mov r4, #1
	str r4, [r0, #0x4a0]
_0215D1AC:
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_215D168

	arm_func_start ovl01_215D1B4
ovl01_215D1B4: // 0x0215D1B4
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr ip, [r1, #0x498]
	cmp ip, #0
	movlt ip, #0
	blt _0215D1D4
	cmp ip, #0xbc00
	movgt ip, #0xbc00
_0215D1D4:
	mov r3, #0
	add r1, sp, #0
	mov r0, #0x1c
	mov r2, #3
	str r3, [sp]
	str ip, [sp, #4]
	str r3, [sp, #8]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end ovl01_215D1B4

	arm_func_start ovl01_215D1FC
ovl01_215D1FC: // 0x0215D1FC
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr ip, [r1, #0x49c]
	cmp ip, #0
	movlt ip, #0
	blt _0215D21C
	cmp ip, #0xbc00
	movgt ip, #0xbc00
_0215D21C:
	mov r3, #0
	add r1, sp, #0
	mov r0, #0x1c
	mov r2, #3
	str r3, [sp]
	str ip, [sp, #4]
	str r3, [sp, #8]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end ovl01_215D1FC

	arm_func_start ovl01_215D244
ovl01_215D244: // 0x0215D244
	stmdb sp!, {r3, lr}
	mov r2, #0
	ldr r1, _0215D260 // =ovl01_215D2E4
	str r2, [r0, #0x384]
	str r1, [r0, #0x380]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215D260: .word ovl01_215D2E4
	arm_func_end ovl01_215D244

	arm_func_start ovl01_215D264
ovl01_215D264: // 0x0215D264
	stmdb sp!, {r3, lr}
	mov r2, #1
	ldr r1, _0215D280 // =ovl01_215D2F0
	str r2, [r0, #0x384]
	str r1, [r0, #0x380]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215D280: .word ovl01_215D2F0
	arm_func_end ovl01_215D264

	arm_func_start ovl01_215D284
ovl01_215D284: // 0x0215D284
	stmdb sp!, {r3, lr}
	mov r2, #2
	ldr r1, _0215D2A0 // =ovl01_215D4DC
	str r2, [r0, #0x384]
	str r1, [r0, #0x380]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215D2A0: .word ovl01_215D4DC
	arm_func_end ovl01_215D284

	arm_func_start ovl01_215D2A4
ovl01_215D2A4: // 0x0215D2A4
	stmdb sp!, {r3, lr}
	mov r2, #3
	ldr r1, _0215D2C0 // =ovl01_215D5DC
	str r2, [r0, #0x384]
	str r1, [r0, #0x380]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215D2C0: .word ovl01_215D5DC
	arm_func_end ovl01_215D2A4

	arm_func_start ovl01_215D2C4
ovl01_215D2C4: // 0x0215D2C4
	stmdb sp!, {r3, lr}
	mov r2, #4
	ldr r1, _0215D2E0 // =ovl01_215DAD4
	str r2, [r0, #0x384]
	str r1, [r0, #0x380]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215D2E0: .word ovl01_215DAD4
	arm_func_end ovl01_215D2C4

	arm_func_start ovl01_215D2E4
ovl01_215D2E4: // 0x0215D2E4
	ldr ip, _0215D2EC // =ovl01_215D264
	bx ip
	.align 2, 0
_0215D2EC: .word ovl01_215D264
	arm_func_end ovl01_215D2E4

	arm_func_start ovl01_215D2F0
ovl01_215D2F0: // 0x0215D2F0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0x1a4
	ldr r2, [r4, #0x368]
	mov r3, r1
	add r0, r0, #0x400
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _0215D330 // =ovl01_215D334
	str r0, [r4, #0x380]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D330: .word ovl01_215D334
	arm_func_end ovl01_215D2F0

	arm_func_start ovl01_215D334
ovl01_215D334: // 0x0215D334
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _0215D4C4 // =gPlayer
	mov r4, r0
	ldr r0, [r1]
	ldr r2, _0215D4C8 // =0x00722543
	ldr r0, [r0, #0x44]
	mov r1, #0x40000
	bl BossHelpers__Arena__Func_2038DCC
	mov r1, r0
	add r2, r4, #0x300
	ldrsh r0, [r2, #0xcc]
	mov r5, r1, lsl #0x10
	sub r0, r0, r5, asr #16
	mov r0, r0, lsl #0x10
	movs r0, r0, asr #0x10
	rsbmi r0, r0, #0
	cmp r0, #0x2000
	movgt r0, #1
	strgt r0, [r4, #0x3d0]
	ldr r0, [r4, #0x3d0]
	cmp r0, #0
	beq _0215D3C8
	add r0, r4, #0x300
	ldrh r0, [r0, #0xcc]
	mov r2, #0x60
	bl BossHelpers__Math__Func_2039264
	add r1, r4, #0x300
	strh r0, [r1, #0xcc]
	ldrsh r0, [r1, #0xcc]
	sub r0, r0, r5, asr #16
	mov r0, r0, lsl #0x10
	movs r1, r0, asr #0x10
	ldr r0, _0215D4CC // =0x0000038E
	rsbmi r1, r1, #0
	cmp r1, r0
	movlt r0, #0
	strlt r0, [r4, #0x3d0]
_0215D3C8:
	add r0, r4, #0x300
	ldrh r2, [r0, #0xc8]
	cmp r2, #0
	beq _0215D41C
	ldr r1, [r4, #0x370]
	ldr r1, [r1, #0x380]
	ldr r1, [r1, #0x378]
	cmp r1, #0
	bne _0215D41C
	sub r1, r2, #1
	strh r1, [r0, #0xc8]
	ldrh r0, [r0, #0xc8]
	cmp r0, #0
	bne _0215D41C
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x380]
	bl ovl01_215E208
	ldr r0, [r4, #0x370]
	bl ovl01_215C104
	add r1, r4, #0x300
	strh r0, [r1, #0xc8]
_0215D41C:
	add r0, r4, #0x300
	ldrh r3, [r0, #0xca]
	cmp r3, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r2, [r4, #0x370]
	ldr r1, [r2, #0x390]
	cmp r1, #0
	ldreq r1, [r2, #0x380]
	ldreq r1, [r1, #0x378]
	cmpeq r1, #0
	ldmneia sp!, {r3, r4, r5, pc}
	sub r1, r3, #1
	strh r1, [r0, #0xca]
	ldrh r0, [r0, #0xca]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r2, _0215D4D0 // =_mt_math_rand
	ldr r0, _0215D4D4 // =0x00196225
	ldr r3, [r2]
	ldr r1, _0215D4D8 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	movne r2, #1
	ldr r0, [r4, #0x370]
	moveq r2, #0
	mov r1, #0x1800
	bl ovl01_2160528
	ldr r0, [r4, #0x370]
	bl ovl01_215C19C
	add r1, r4, #0x300
	strh r0, [r1, #0xca]
	ldrh r0, [r1, #0xc8]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	cmp r0, #0x78
	addlo r0, r0, #0x78
	strloh r0, [r1, #0xc8]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215D4C4: .word gPlayer
_0215D4C8: .word 0x00722543
_0215D4CC: .word 0x0000038E
_0215D4D0: .word _mt_math_rand
_0215D4D4: .word 0x00196225
_0215D4D8: .word 0x3C6EF35F
	arm_func_end ovl01_215D334

	arm_func_start ovl01_215D4DC
ovl01_215D4DC: // 0x0215D4DC
	ldr r1, _0215D4E8 // =ovl01_215D4EC
	str r1, [r0, #0x380]
	bx lr
	.align 2, 0
_0215D4E8: .word ovl01_215D4EC
	arm_func_end ovl01_215D4DC

	arm_func_start ovl01_215D4EC
ovl01_215D4EC: // 0x0215D4EC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1a4
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x18
	bl BossHelpers__Animation__Func_2038BF0
	add r0, r4, #0xa4
	mov r2, #1
	mov r3, r2
	add r0, r0, #0x400
	mov r1, #8
	bl BossHelpers__Palette__Func_2038BAC
	ldr r0, _0215D540 // =ovl01_215D544
	str r0, [r4, #0x380]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D540: .word ovl01_215D544
	arm_func_end ovl01_215D4EC

	arm_func_start ovl01_215D544
ovl01_215D544: // 0x0215D544
	add r1, r0, #0x600
	ldrh r1, [r1, #0xb0]
	tst r1, #0x8000
	ldrne r1, _0215D55C // =ovl01_215D560
	strne r1, [r0, #0x380]
	bx lr
	.align 2, 0
_0215D55C: .word ovl01_215D560
	arm_func_end ovl01_215D544

	arm_func_start ovl01_215D560
ovl01_215D560: // 0x0215D560
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1a4
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x19
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _0215D59C // =ovl01_215D5A0
	str r0, [r4, #0x380]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D59C: .word ovl01_215D5A0
	arm_func_end ovl01_215D560

	arm_func_start ovl01_215D5A0
ovl01_215D5A0: // 0x0215D5A0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x600
	ldrh r0, [r0, #0xb0]
	tst r0, #0x8000
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0xa4
	mov r2, #0
	mov r3, r2
	add r0, r0, #0x400
	mov r1, #8
	bl BossHelpers__Palette__Func_2038BAC
	mov r0, r4
	bl ovl01_215D264
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_215D5A0

	arm_func_start ovl01_215D5DC
ovl01_215D5DC: // 0x0215D5DC
	mov r2, #0
	ldr r1, _0215D5F0 // =ovl01_215D5F4
	str r2, [r0, #0x374]
	str r1, [r0, #0x380]
	bx lr
	.align 2, 0
_0215D5F0: .word ovl01_215D5F4
	arm_func_end ovl01_215D5DC

	arm_func_start ovl01_215D5F4
ovl01_215D5F4: // 0x0215D5F4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1a4
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x18
	bl BossHelpers__Animation__Func_2038BF0
	add r0, r4, #0xa4
	mov r2, #1
	mov r3, r2
	add r0, r0, #0x400
	mov r1, #8
	bl BossHelpers__Palette__Func_2038BAC
	ldr r0, _0215D648 // =ovl01_215D64C
	str r0, [r4, #0x380]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D648: .word ovl01_215D64C
	arm_func_end ovl01_215D5F4

	arm_func_start ovl01_215D64C
ovl01_215D64C: // 0x0215D64C
	add r1, r0, #0x600
	ldrh r1, [r1, #0xb0]
	tst r1, #0x8000
	ldrne r1, _0215D664 // =ovl01_215D668
	strne r1, [r0, #0x380]
	bx lr
	.align 2, 0
_0215D664: .word ovl01_215D668
	arm_func_end ovl01_215D64C

	arm_func_start ovl01_215D668
ovl01_215D668: // 0x0215D668
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1a4
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x1a
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _0215D6A4 // =ovl01_215D6A8
	str r0, [r4, #0x380]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D6A4: .word ovl01_215D6A8
	arm_func_end ovl01_215D668

	arm_func_start ovl01_215D6A8
ovl01_215D6A8: // 0x0215D6A8
	mov r1, #0x4000
	str r1, [r0, #0x9c]
	add r1, r0, #0x600
	ldrh r1, [r1, #0xb0]
	tst r1, #0x8000
	ldrne r1, _0215D6C8 // =ovl01_215D6CC
	strne r1, [r0, #0x380]
	bx lr
	.align 2, 0
_0215D6C8: .word ovl01_215D6CC
	arm_func_end ovl01_215D6A8

	arm_func_start ovl01_215D6CC
ovl01_215D6CC: // 0x0215D6CC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x494]
	add r0, r4, #0x1a4
	str r1, [r4, #0x28]
	mov r1, #0
	str r1, [r4, #0x494]
	str r1, [sp]
	mov r2, #1
	str r2, [sp, #4]
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x1b
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _0215D718 // =ovl01_215D71C
	str r0, [r4, #0x380]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D718: .word ovl01_215D71C
	arm_func_end ovl01_215D6CC

	arm_func_start ovl01_215D71C
ovl01_215D71C: // 0x0215D71C
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r2, [r4, #0x370]
	ldr r1, [r4, #0x374]
	mov r0, #0x46000
	add r1, r1, #0x2800
	ldr r2, [r2, #0x39c]
	rsb r0, r0, #0
	sub r5, r0, r2
	cmp r1, #0x78000
	str r1, [r4, #0x374]
	movgt r0, #0x78000
	strgt r0, [r4, #0x374]
	add r0, r4, #0x300
	ldrh r0, [r0, #0xcc]
	ldr r1, [r4, #0x374]
	add r2, r4, #0x44
	add r3, r4, #0x4c
	bl BossHelpers__Arena__Func_2038D24
	ldr r0, [r4, #0x48]
	cmp r0, r5
	ldmltia sp!, {r3, r4, r5, pc}
	mov r0, #0
	str r0, [r4, #0x9c]
	ldr r0, _0215D78C // =ovl01_215D790
	str r5, [r4, #0x48]
	str r0, [r4, #0x380]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215D78C: .word ovl01_215D790
	arm_func_end ovl01_215D71C

	arm_func_start ovl01_215D790
ovl01_215D790: // 0x0215D790
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1a4
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x1c
	bl BossHelpers__Animation__Func_2038BF0
	add r0, r4, #0xa4
	mov r2, #0
	mov r3, r2
	add r0, r0, #0x400
	mov r1, #8
	bl BossHelpers__Palette__Func_2038BAC
	mov r0, #0xa000
	mov r1, #0x3000
	mov r2, #0xe3
	bl ShakeScreenEx
	mov r0, #0
	str r0, [sp]
	mov r1, #0x9d
	str r1, [sp, #4]
	sub r1, r1, #0x9e
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r1, [r4, #0x230]
	ldr r0, _0215D820 // =ovl01_215D824
	orr r1, r1, #4
	str r1, [r4, #0x230]
	str r0, [r4, #0x380]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D820: .word ovl01_215D824
	arm_func_end ovl01_215D790

	arm_func_start ovl01_215D824
ovl01_215D824: // 0x0215D824
	add r1, r0, #0x600
	ldrh r1, [r1, #0xb0]
	tst r1, #0x8000
	ldrne r1, _0215D83C // =ovl01_215D840
	strne r1, [r0, #0x380]
	bx lr
	.align 2, 0
_0215D83C: .word ovl01_215D840
	arm_func_end ovl01_215D824

	arm_func_start ovl01_215D840
ovl01_215D840: // 0x0215D840
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0x1a4
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x1d
	bl BossHelpers__Animation__Func_2038BF0
	mov r1, #0x258
	ldr r0, _0215D888 // =ovl01_215D88C
	str r1, [r4, #0x2c]
	str r0, [r4, #0x380]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D888: .word ovl01_215D88C
	arm_func_end ovl01_215D840

	arm_func_start ovl01_215D88C
ovl01_215D88C: // 0x0215D88C
	ldr r1, [r0, #0x2c]
	subs r1, r1, #1
	str r1, [r0, #0x2c]
	ldreq r1, _0215D8A4 // =ovl01_215D8A8
	streq r1, [r0, #0x380]
	bx lr
	.align 2, 0
_0215D8A4: .word ovl01_215D8A8
	arm_func_end ovl01_215D88C

	arm_func_start ovl01_215D8A8
ovl01_215D8A8: // 0x0215D8A8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1a4
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x1e
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, [r4, #0x230]
	mov r1, #0x140
	bic r0, r0, #4
	str r0, [r4, #0x230]
	ldr r0, [r4, #0x370]
	add r0, r0, #0x300
	strh r1, [r0, #0x98]
	ldr r0, [r4, #0x370]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0x98]
	bl UpdateBossHealthHUD
	ldr r0, _0215D910 // =ovl01_215D914
	str r0, [r4, #0x380]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D910: .word ovl01_215D914
	arm_func_end ovl01_215D8A8

	arm_func_start ovl01_215D914
ovl01_215D914: // 0x0215D914
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x374]
	add r2, r4, #0x44
	subs r0, r0, #0x2800
	str r0, [r4, #0x374]
	movmi r0, #0
	strmi r0, [r4, #0x374]
	add r0, r4, #0x300
	ldrh r0, [r0, #0xcc]
	ldr r1, [r4, #0x374]
	add r3, r4, #0x4c
	bl BossHelpers__Arena__Func_2038D24
	mov r0, #0x8000
	rsb r0, r0, #0
	str r0, [r4, #0x9c]
	add r0, r4, #0x600
	ldrh r0, [r0, #0xb0]
	tst r0, #0x8000
	ldrne r0, _0215D96C // =ovl01_215D970
	strne r0, [r4, #0x380]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D96C: .word ovl01_215D970
	arm_func_end ovl01_215D914

	arm_func_start ovl01_215D970
ovl01_215D970: // 0x0215D970
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	mov r4, r0
	add r0, r4, #0x1a4
	str r1, [sp]
	mov r2, #1
	str r2, [sp, #4]
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x1f
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, _0215D9B8 // =ovl01_215D9BC
	mov r0, r4
	str r1, [r4, #0x380]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D9B8: .word ovl01_215D9BC
	arm_func_end ovl01_215D970

	arm_func_start ovl01_215D9BC
ovl01_215D9BC: // 0x0215D9BC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r1, [r5, #0x370]
	ldr r0, [r5, #0x374]
	ldr r2, [r1, #0x48]
	subs r1, r0, #0x2800
	ldr r0, _0215DA3C // =0xFFDB7000
	str r1, [r5, #0x374]
	add r4, r2, r0
	movmi r0, #0
	strmi r0, [r5, #0x374]
	add r0, r5, #0x300
	ldrh r0, [r0, #0xcc]
	ldr r1, [r5, #0x374]
	add r2, r5, #0x44
	add r3, r5, #0x4c
	bl BossHelpers__Arena__Func_2038D24
	mov r0, #0x8000
	rsb r0, r0, #0
	str r0, [r5, #0x9c]
	ldr r0, [r5, #0x48]
	cmp r0, r4
	ldmgtia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x374]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #0
	str r0, [r5, #0x9c]
	ldr r0, _0215DA40 // =ovl01_215DA44
	str r4, [r5, #0x48]
	str r0, [r5, #0x380]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215DA3C: .word 0xFFDB7000
_0215DA40: .word ovl01_215DA44
	arm_func_end ovl01_215D9BC

	arm_func_start ovl01_215DA44
ovl01_215DA44: // 0x0215DA44
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x28]
	mov r5, #0
	str r0, [r4, #0x494]
	cmp r0, #0
	blt _0215DA84
_0215DA64:
	ldr r0, [r4, #0x370]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x374]
	bl ovl01_215EBD8
	ldr r0, [r4, #0x494]
	add r5, r5, #1
	cmp r5, r0
	ble _0215DA64
_0215DA84:
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x1a4
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x20
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _0215DAB4 // =ovl01_215DAB8
	str r0, [r4, #0x380]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215DAB4: .word ovl01_215DAB8
	arm_func_end ovl01_215DA44

	arm_func_start ovl01_215DAB8
ovl01_215DAB8: // 0x0215DAB8
	stmdb sp!, {r3, lr}
	add r1, r0, #0x600
	ldrh r1, [r1, #0xb0]
	tst r1, #0x8000
	ldmeqia sp!, {r3, pc}
	bl ovl01_215D264
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_215DAB8

	arm_func_start ovl01_215DAD4
ovl01_215DAD4: // 0x0215DAD4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	add r4, r6, #0x374
	mov r1, r4
	mov r0, #0
	mov r2, #0xa
	bl MIi_CpuClear16
	ldr r1, [r6, #0x230]
	ldr r0, _0215DC10 // =playerGameStatus
	bic r1, r1, #4
	str r1, [r6, #0x230]
	ldr r1, [r0]
	bic r1, r1, #1
	str r1, [r0]
	bl StopStageBGM
	ldr r0, _0215DC14 // =gPlayer
	ldr r0, [r0]
	bl Player__Action_Blank
	ldr r0, _0215DC14 // =gPlayer
	mov r1, #0x12
	ldr r3, [r0]
	ldr r2, [r3, #0x1c]
	orr r2, r2, #0x10
	str r2, [r3, #0x1c]
	ldr r0, [r0]
	bl Player__ChangeAction
	ldr r1, _0215DC14 // =gPlayer
	mov r2, #0
	ldr r0, [r1]
	add r0, r0, #0x600
	strh r2, [r0, #0x82]
	ldr r0, [r1]
	bl BossHelpers__Player__LockControl
	mov r0, #0
	str r0, [r6, #0x6bc]
	bl EnableObjectManagerFlag2
	ldr r0, [r6, #0x18]
	mov r5, #0
	orr r0, r0, #0x20
	str r0, [r6, #0x18]
	ldr r1, [r6, #0x370]
	ldr r0, [r1, #0x18]
	orr r0, r0, #0x20
	str r0, [r1, #0x18]
_0215DB88:
	ldr r0, [r6, #0x370]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x374]
	bl ovl01_215EBA8
	add r5, r5, #1
	cmp r5, #3
	blt _0215DB88
	ldr r2, _0215DC18 // =0x000002AA
	mov r0, #0x5000
	mov r1, #0x3000
	bl ShakeScreenEx
	ldr r1, _0215DC14 // =gPlayer
	mov r3, #0x10000
	ldr r2, [r1]
	mov r0, #0
	str r3, [r2, #4]
	ldr r3, [r1]
	ldr r1, [r3, #0x1b0]
	ldr r2, [r3, #0x1b4]
	ldr r3, [r3, #0x1b8]
	bl BossFX__CreatePendulumExplode2
	mov r3, #0x94
	sub r1, r3, #0x95
	mov r0, #0
	stmia sp, {r0, r3}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r1, #0
	ldr r0, _0215DC1C // =ovl01_215DC20
	strh r1, [r4, #8]
	str r0, [r6, #0x380]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215DC10: .word playerGameStatus
_0215DC14: .word gPlayer
_0215DC18: .word 0x000002AA
_0215DC1C: .word ovl01_215DC20
	arm_func_end ovl01_215DAD4

	arm_func_start ovl01_215DC20
ovl01_215DC20: // 0x0215DC20
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x18
	mov r5, r0
	add r4, r5, #0x374
	bl Camera3D__GetWork
	ldrh r0, [r4, #8]
	add r0, r0, #1
	strh r0, [r4, #8]
	ldrh r0, [r4, #8]
	cmp r0, #0x5a
	addne sp, sp, #0x18
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r0, #2
	bl BossArena__GetCamera
	ldr r2, [r5, #0x370]
	mov r3, #1
	str r3, [r2, #0x3d4]
	ldr r1, _0215DDC4 // =gPlayer
	add r3, sp, #0xc
	ldr r1, [r1]
	mov r4, r0
	add r1, r1, #0x1b0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r2, [sp, #0xc]
	ldr r0, [sp, #0x14]
	mov r3, r2, asr #1
	mov r6, r0, asr #1
	mov r1, #0
	str r3, [sp, #0xc]
	mov r0, r4
	mov r2, r1
	mov r3, r1
	str r6, [sp, #0x14]
	bl BossArena__SetTracker1TargetWork
	ldr r1, [sp, #0xc]
	ldr r2, [sp, #0x10]
	ldr r3, [sp, #0x14]
	mov r0, r4
	bl BossArena__SetTracker1TargetPos
	ldr r0, _0215DDC4 // =gPlayer
	add r3, sp, #0
	ldr r6, [r0]
	add r0, r6, #0x1b0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r6, #0x44]
	ldr r2, _0215DDC8 // =0x00722543
	mov r1, #0x40000
	bl BossHelpers__Arena__Func_2038DCC
	ldr r1, _0215DDCC // =0xFFFFD556
	mov fp, #0
	add r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	mov r3, r0, lsl #1
	ldr r1, _0215DDD0 // =FX_SinCosTable_
	add r0, r0, #1
	ldrsh r7, [r1, r3]
	mov r3, #0xb4000
	mov r0, r0, lsl #1
	ldrsh lr, [r1, r0]
	umull sb, r8, r7, r3
	ldr r2, [sp, #4]
	mla r8, r7, fp, r8
	mov r1, r7, asr #0x1f
	adds r7, sb, #0x800
	mla r8, r1, r3, r8
	add r2, r2, #0x32000
	ldr sl, [sp]
	adc r1, r8, #0
	mov r7, r7, lsr #0xc
	orr r7, r7, r1, lsl #20
	add r1, sl, r7
	umull r8, r7, lr, r3
	mla r7, lr, fp, r7
	mov ip, lr, asr #0x1f
	mla r7, ip, r3, r7
	adds r8, r8, #0x800
	adc r3, r7, #0
	mov r7, r8, lsr #0xc
	ldr r6, [sp, #8]
	orr r7, r7, r3, lsl #20
	add r3, r6, r7
	mov r0, r4
	str r2, [sp, #4]
	str r1, [sp]
	str r3, [sp, #8]
	bl BossArena__SetTracker0TargetPos
	mov r1, #0xcc
	mov r0, r4
	mov r2, r1
	bl BossArena__SetTracker1Speed
	mov r1, #0xcc
	mov r0, r4
	mov r2, r1
	bl BossArena__SetTracker0Speed
	ldr r0, _0215DDD4 // =ovl01_215DDD8
	str r0, [r5, #0x380]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_0215DDC4: .word gPlayer
_0215DDC8: .word 0x00722543
_0215DDCC: .word 0xFFFFD556
_0215DDD0: .word FX_SinCosTable_
_0215DDD4: .word ovl01_215DDD8
	arm_func_end ovl01_215DC20

	arm_func_start ovl01_215DDD8
ovl01_215DDD8: // 0x0215DDD8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl Camera3D__GetWork
	mov r4, r0
	add r1, r4, #0x20
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	ldrh r1, [r4, #0x20]
	add r0, r5, #0x300
	mov r2, #0
	bic r1, r1, #0xc0
	orr r1, r1, #0xc0
	strh r1, [r4, #0x20]
	ldrh r3, [r4, #0x20]
	ldr r1, _0215DE3C // =ovl01_215DE40
	bic r3, r3, #1
	orr r3, r3, #1
	strh r3, [r4, #0x20]
	ldrh r3, [r4, #0x20]
	orr r3, r3, #0x1e
	strh r3, [r4, #0x20]
	strh r2, [r0, #0x7c]
	str r1, [r5, #0x380]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215DE3C: .word ovl01_215DE40
	arm_func_end ovl01_215DDD8

	arm_func_start ovl01_215DE40
ovl01_215DE40: // 0x0215DE40
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #8
	mov sl, r0
	ldr r4, [sl, #0x370]
	add r8, sl, #0x374
	bl Camera3D__GetWork
	add r1, r4, #0x300
	ldrsh r3, [r1, #0xd0]
	mvn r2, #0xf
	cmp r3, r2
	beq _0215DE98
	ldrh r2, [r8, #2]
	add r2, r2, #1
	strh r2, [r8, #2]
	ldrh r2, [r8, #2]
	cmp r2, #1
	bls _0215DE98
	mov r2, #0
	strh r2, [r8, #2]
	ldrsh r2, [r1, #0xd0]
	sub r2, r2, #1
	strh r2, [r1, #0xd0]
_0215DE98:
	ldrh r1, [r0, #0x24]
	cmp r1, #0x10
	bhs _0215DED0
	ldrh r1, [r8]
	add r1, r1, #1
	strh r1, [r8]
	ldrh r1, [r8]
	cmp r1, #2
	bls _0215DED0
	mov r1, #0
	strh r1, [r8]
	ldrh r1, [r0, #0x24]
	add r1, r1, #1
	strh r1, [r0, #0x24]
_0215DED0:
	mov sb, #0
	ldr r7, _0215DF70 // =BossArena__explosionFXSpawnTime
	mov r6, sb
	mov fp, sb
	mov r5, #0xcd
	mvn r4, #0
_0215DEE8:
	ldrh r1, [r8, #8]
	ldr r0, [r7, sb, lsl #2]
	cmp r1, r0
	bne _0215DF44
	ldr r1, [sl, #0x488]
	ldr r2, [sl, #0x48c]
	ldr r3, [sl, #0x490]
	mov r0, r6
	bl BossFX__CreatePendulumExplode0
	str fp, [sp]
	mov r0, fp
	mov r1, r4
	mov r2, r4
	mov r3, r4
	str r5, [sp, #4]
	bl PlaySfxEx
	add r0, r4, #0x204
	mov r1, #0x2000
	bl CreateDrawFadeTask
	mov r0, #0x3000
	mov r1, r0
	mov r2, #0x600
	bl ShakeScreenEx
_0215DF44:
	add sb, sb, #1
	cmp sb, #3
	blt _0215DEE8
	ldrh r1, [r8, #8]
	add r0, r1, #1
	strh r0, [r8, #8]
	cmp r1, #0xf0
	ldrhi r0, _0215DF74 // =ovl01_215DF78
	strhi r0, [sl, #0x380]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_0215DF70: .word BossArena__explosionFXSpawnTime
_0215DF74: .word ovl01_215DF78
	arm_func_end ovl01_215DE40

	arm_func_start ovl01_215DF78
ovl01_215DF78: // 0x0215DF78
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr lr, [r4, #0x488]
	ldr r2, _0215E044 // =0x00000B33
	ldr r3, [r4, #0x490]
	umull r6, r5, lr, r2
	mov r0, #0
	mla r5, lr, r0, r5
	umull r1, ip, r3, r2
	mla ip, r3, r0, ip
	mov lr, lr, asr #0x1f
	mov r3, r3, asr #0x1f
	mla r5, lr, r2, r5
	mla ip, r3, r2, ip
	adds r6, r6, #0x800
	adc r5, r5, r0
	adds lr, r1, #0x800
	mov r1, r6, lsr #0xc
	adc ip, ip, r0
	mov r3, lr, lsr #0xc
	ldr r2, [r4, #0x48c]
	orr r1, r1, r5, lsl #20
	orr r3, r3, ip, lsl #20
	bl BossFX__CreatePendulumExplode1
	mov r1, #0x3000
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	ldr r2, _0215E048 // =0x00000555
	str r1, [r0, #0x40]
	str r2, [r0, #0x280]
	mov r0, #0xa000
	mov r2, #0xe3
	bl ShakeScreenEx
	mov r0, #0
	str r0, [sp]
	mov r1, #0x8d
	str r1, [sp, #4]
	sub r1, r1, #0x8e
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r1, #0
	add r0, r4, #0x300
	strh r1, [r0, #0x7c]
	ldr r1, _0215E04C // =ovl01_215E050
	mov r0, r4
	str r1, [r4, #0x380]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215E044: .word 0x00000B33
_0215E048: .word 0x00000555
_0215E04C: .word ovl01_215E050
	arm_func_end ovl01_215DF78

	arm_func_start ovl01_215E050
ovl01_215E050: // 0x0215E050
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r6, [r5, #0x370]
	add r4, r5, #0x374
	bl Camera3D__GetWork
	add r3, r6, #0x300
	ldrsh ip, [r3, #0xd0]
	mov r1, #0
	mov r2, r1
	cmp ip, #0
	addne ip, ip, #1
	strneh ip, [r3, #0xd0]
	ldrsh r3, [r0, #0x58]
	moveq r1, #1
	cmp r3, #0x10
	bge _0215E0D8
	ldrh r3, [r4, #8]
	cmp r3, #0xb4
	bls _0215E0DC
	ldrh r3, [r4, #6]
	add r3, r3, #1
	strh r3, [r4, #6]
	ldrh r3, [r4, #6]
	cmp r3, #3
	bls _0215E0DC
	ldrsh ip, [r0, #0x58]
	mov r3, #0
	add ip, ip, #1
	strh ip, [r0, #0x58]
	ldrsh ip, [r0, #0xb4]
	add ip, ip, #1
	strh ip, [r0, #0xb4]
	strh r3, [r4, #6]
	b _0215E0DC
_0215E0D8:
	mov r2, #1
_0215E0DC:
	ldrh r0, [r4, #8]
	cmp r1, #0
	cmpne r2, #0
	add r0, r0, #1
	strh r0, [r4, #8]
	ldrne r0, _0215E0FC // =ovl01_215E100
	strne r0, [r5, #0x380]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215E0FC: .word ovl01_215E100
	arm_func_end ovl01_215E050

	arm_func_start ovl01_215E100
ovl01_215E100: // 0x0215E100
	ldr r0, _0215E114 // =playerGameStatus
	ldr r1, [r0]
	orr r1, r1, #4
	str r1, [r0]
	bx lr
	.align 2, 0
_0215E114: .word playerGameStatus
	arm_func_end ovl01_215E100

	arm_func_start ovl01_215E118
ovl01_215E118: // 0x0215E118
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x374]
	blx r1
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_215E118

	arm_func_start ovl01_215E128
ovl01_215E128: // 0x0215E128
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	add r0, r0, #0x384
	bl AnimatorMDL__Release
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_215E128

	arm_func_start ovl01_215E148
ovl01_215E148: // 0x0215E148
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x370]
	ldr r0, [r4, #0x20]
	ldr r2, [r1, #0x370]
	tst r0, #0x20
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x37c]
	cmp r0, #0
	ldreq r0, [r4, #0x1c]
	biceq r0, r0, #0x2000
	streq r0, [r4, #0x1c]
	beq _0215E1B8
	ldr r1, [r4, #0x1c]
	mov r0, #0
	orr r1, r1, #0x2000
	str r1, [r4, #0x1c]
	ldr r1, [r2, #0x458]
	str r1, [r4, #0x44]
	ldr r1, [r2, #0x45c]
	rsb r1, r1, #0
	str r1, [r4, #0x48]
	ldr r1, [r2, #0x460]
	str r1, [r4, #0x4c]
	str r0, [r4, #0x98]
	str r0, [r4, #0x9c]
	str r0, [r4, #0xa0]
_0215E1B8:
	ldr r1, [r4, #0x48]
	ldr r2, [r4, #0x4c]
	ldr r0, [r4, #0x44]
	rsb r1, r1, #0
	str r0, [r4, #0x3cc]
	str r1, [r4, #0x3d0]
	add r0, r4, #0x384
	str r2, [r4, #0x3d4]
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #0x384
	bl AnimatorMDL__Draw
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_215E148

	arm_func_start ovl01_215E1E8
ovl01_215E1E8: // 0x0215E1E8
	stmdb sp!, {r3, lr}
	mov r2, #0
	ldr r1, _0215E204 // =ovl01_215E230
	str r2, [r0, #0x378]
	str r1, [r0, #0x374]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215E204: .word ovl01_215E230
	arm_func_end ovl01_215E1E8

	arm_func_start ovl01_215E208
ovl01_215E208: // 0x0215E208
	stmdb sp!, {r3, lr}
	mov r2, #1
	str r2, [r0, #0x378]
	mov r2, #0
	ldr r1, _0215E22C // =ovl01_215E3F4
	str r2, [r0, #0x380]
	str r1, [r0, #0x374]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215E22C: .word ovl01_215E3F4
	arm_func_end ovl01_215E208

	arm_func_start ovl01_215E230
ovl01_215E230: // 0x0215E230
	mov r2, #1
	ldr r1, _0215E244 // =ovl01_215E248
	str r2, [r0, #0x37c]
	str r1, [r0, #0x374]
	bx lr
	.align 2, 0
_0215E244: .word ovl01_215E248
	arm_func_end ovl01_215E230

	arm_func_start ovl01_215E248
ovl01_215E248: // 0x0215E248
	stmdb sp!, {r3, r4, r5, lr}
	mov ip, r0
	ldr r0, [ip, #0x370]
	add r4, ip, #0x3a8
	ldr r0, [r0, #0x370]
	ldr lr, _0215E3F0 // =0x000004D9
	add r0, r0, #0x34
	add r5, r0, #0x400
	ldmia r5!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r5!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldr r1, [r5]
	mov r0, #0
	str r1, [r4]
	ldr r1, [ip, #0x3a8]
	umull r3, r2, r1, lr
	adds r3, r3, #0x800
	mla r2, r1, r0, r2
	mov r1, r1, asr #0x1f
	mla r2, r1, lr, r2
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [ip, #0x3a8]
	ldr r2, [ip, #0x3ac]
	umull r1, r3, r2, lr
	adds r1, r1, #0x800
	mov r4, r1, lsr #0xc
	mov r1, r2, asr #0x1f
	mla r3, r2, r0, r3
	mla r3, r1, lr, r3
	adc r1, r3, #0
	orr r4, r4, r1, lsl #20
	str r4, [ip, #0x3ac]
	ldr r2, [ip, #0x3b0]
	mov r1, r2, asr #0x1f
	umull r4, r3, r2, lr
	mla r3, r2, r0, r3
	mla r3, r1, lr, r3
	adds r2, r4, #0x800
	adc r1, r3, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [ip, #0x3b0]
	ldr r2, [ip, #0x3b4]
	mov r1, r2, asr #0x1f
	umull r4, r3, r2, lr
	mla r3, r2, r0, r3
	mla r3, r1, lr, r3
	adds r2, r4, #0x800
	adc r1, r3, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [ip, #0x3b4]
	ldr r2, [ip, #0x3b8]
	mov r1, r2, asr #0x1f
	umull r4, r3, r2, lr
	mla r3, r2, r0, r3
	mla r3, r1, lr, r3
	adds r2, r4, #0x800
	adc r1, r3, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [ip, #0x3b8]
	ldr r2, [ip, #0x3bc]
	mov r1, r2, asr #0x1f
	umull r4, r3, r2, lr
	mla r3, r2, r0, r3
	mla r3, r1, lr, r3
	adds r2, r4, #0x800
	adc r1, r3, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [ip, #0x3bc]
	ldr r2, [ip, #0x3c0]
	mov r1, r2, asr #0x1f
	umull r4, r3, r2, lr
	mla r3, r2, r0, r3
	mla r3, r1, lr, r3
	adds r2, r4, #0x800
	adc r1, r3, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [ip, #0x3c0]
	ldr r2, [ip, #0x3c4]
	mov r1, r2, asr #0x1f
	umull r4, r3, r2, lr
	mla r3, r2, r0, r3
	mla r3, r1, lr, r3
	adds r2, r4, #0x800
	adc r1, r3, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [ip, #0x3c4]
	ldr r2, [ip, #0x3c8]
	mov r1, r2, asr #0x1f
	umull r4, r3, r2, lr
	mla r3, r2, r0, r3
	mla r3, r1, lr, r3
	adds r1, r4, #0x800
	adc r0, r3, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [ip, #0x3c8]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215E3F0: .word 0x000004D9
	arm_func_end ovl01_215E248

	arm_func_start ovl01_215E3F4
ovl01_215E3F4: // 0x0215E3F4
	mov r2, #1
	ldr r1, _0215E408 // =ovl01_215E40C
	str r2, [r0, #0x37c]
	str r1, [r0, #0x374]
	bx lr
	.align 2, 0
_0215E408: .word ovl01_215E40C
	arm_func_end ovl01_215E3F4

	arm_func_start ovl01_215E40C
ovl01_215E40C: // 0x0215E40C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	ldr r2, [r4, #0x368]
	add r0, r4, #0x384
	mov r3, #7
	bl BossHelpers__Animation__Func_2038BF0
	mov ip, #0x9e
	sub r1, ip, #0x9f
	mov r0, #0x3c
	str r0, [r4, #0x2c]
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	ldr r0, _0215E468 // =ovl01_215E46C
	str r0, [r4, #0x374]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E468: .word ovl01_215E46C
	arm_func_end ovl01_215E40C

	arm_func_start ovl01_215E46C
ovl01_215E46C: // 0x0215E46C
	ldr r1, [r0, #0x370]
	mvn r2, #7
	add r1, r1, #0x300
	ldrsh r3, [r1, #0xd0]
	cmp r3, r2
	blt _0215E494
	ldr r2, [r0, #0x2c]
	tst r2, #1
	subeq r2, r3, #1
	streqh r2, [r1, #0xd0]
_0215E494:
	ldr r1, [r0, #0x2c]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0x2c]
	add r1, r0, #0x400
	ldrh r1, [r1, #0x90]
	tst r1, #0x8000
	bxeq lr
	ldr r1, [r0, #0x2c]
	cmp r1, #0
	ldreq r1, _0215E4C8 // =ovl01_215E4CC
	streq r1, [r0, #0x374]
	bx lr
	.align 2, 0
_0215E4C8: .word ovl01_215E4CC
	arm_func_end ovl01_215E46C

	arm_func_start ovl01_215E4CC
ovl01_215E4CC: // 0x0215E4CC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x3d0]
	ldr r1, [r4, #0x3cc]
	sub r2, r0, #0x32000
	ldr r3, [r4, #0x3d4]
	mov r0, #0
	bl BossFX__CreatePendulumDrop
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	rsb r2, r0, #0
	ldr r3, [r4, #0x4c]
	mov r0, #0
	bl BossFX__CreatePendulumFall
	str r0, [r4, #0x4c8]
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r2, [r4, #0x368]
	add r0, r4, #0x384
	mov r3, #9
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, [r4, #0x1c]
	ldr r1, _0215E560 // =ovl01_215E564
	orr r0, r0, #0x80
	str r0, [r4, #0x1c]
	mov r0, #0x20000
	str r0, [r4, #0x9c]
	mov r0, #0
	str r0, [r4, #0x37c]
	mov r0, r4
	str r1, [r4, #0x374]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E560: .word ovl01_215E564
	arm_func_end ovl01_215E4CC

	arm_func_start ovl01_215E564
ovl01_215E564: // 0x0215E564
	stmdb sp!, {r4, lr}
	ldr r1, _0215E5FC // =_0217AF80
	mov r4, r0
	ldr r0, [r1, #4]
	bl GetTaskWork_
	ldr r1, [r0, #0x39c]
	ldr r0, [r4, #0x48]
	rsb r1, r1, #0
	sub r1, r1, #0x78000
	cmp r1, r0
	bgt _0215E5CC
	ldr r0, [r4, #0x1c]
	mov r2, #0
	bic r0, r0, #0x80
	str r0, [r4, #0x1c]
	str r2, [r4, #0x9c]
	str r1, [r4, #0x48]
	ldr r1, [r4, #0x4c8]
	cmp r1, #0
	beq _0215E5C4
	ldr r0, [r1, #0x18]
	orr r0, r0, #8
	str r0, [r1, #0x18]
	str r2, [r4, #0x4c8]
_0215E5C4:
	ldr r0, _0215E600 // =ovl01_215E604
	str r0, [r4, #0x374]
_0215E5CC:
	ldr r1, [r4, #0x4c8]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x44
	add r3, r1, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x4c8]
	ldr r0, [r1, #0x48]
	sub r0, r0, #0x32000
	str r0, [r1, #0x48]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E5FC: .word _0217AF80
_0215E600: .word ovl01_215E604
	arm_func_end ovl01_215E564

	arm_func_start ovl01_215E604
ovl01_215E604: // 0x0215E604
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	ldr r2, [r4, #0x368]
	add r0, r4, #0x384
	mov r3, #0xb
	bl BossHelpers__Animation__Func_2038BF0
	mov r0, #0x78
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x380]
	cmp r0, #0
	bne _0215E6A4
	ldr r0, [r4, #0x370]
	ldr r1, [r4, #0x3cc]
	ldr r2, [r0, #0x39c]
	ldr r3, [r4, #0x3d4]
	mov r0, #0
	bl BossFX__CreatePendulumSmoke
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	str r1, [sp, #0x10]
	ldr r0, [r4, #0x370]
	sub r2, r1, #0x5000
	ldr ip, [r0, #0x39c]
	ldr r0, _0215E6D0 // =0x0000011B
	mov r3, r1
	sub r2, r2, ip
	bl GameObject__SpawnObject
	mov r0, #0x5000
	mov r1, #0x3000
	mov r2, #0xaa
	bl ShakeScreenEx
	mov r0, #1
	str r0, [r4, #0x380]
_0215E6A4:
	mov ip, #0x9e
	sub r1, ip, #0x9f
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	ldr r0, _0215E6D4 // =ovl01_215E6D8
	str r0, [r4, #0x374]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0215E6D0: .word 0x0000011B
_0215E6D4: .word ovl01_215E6D8
	arm_func_end ovl01_215E604

	arm_func_start ovl01_215E6D8
ovl01_215E6D8: // 0x0215E6D8
	ldr r1, [r0, #0x370]
	add r1, r1, #0x300
	ldrsh r3, [r1, #0xd0]
	cmp r3, #0
	beq _0215E6FC
	ldr r2, [r0, #0x2c]
	tst r2, #1
	addeq r2, r3, #1
	streqh r2, [r1, #0xd0]
_0215E6FC:
	ldr r1, [r0, #0x2c]
	subs r1, r1, #1
	str r1, [r0, #0x2c]
	ldreq r1, _0215E714 // =ovl01_215E718
	streq r1, [r0, #0x374]
	bx lr
	.align 2, 0
_0215E714: .word ovl01_215E718
	arm_func_end ovl01_215E6D8

	arm_func_start ovl01_215E718
ovl01_215E718: // 0x0215E718
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	ldr r2, [r4, #0x368]
	add r0, r4, #0x384
	mov r3, #0xd
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _0215E750 // =ovl01_215E754
	str r0, [r4, #0x374]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E750: .word ovl01_215E754
	arm_func_end ovl01_215E718

	arm_func_start ovl01_215E754
ovl01_215E754: // 0x0215E754
	add r1, r0, #0x400
	ldrh r1, [r1, #0x90]
	tst r1, #0x8000
	ldrne r1, _0215E76C // =ovl01_215E770
	strne r1, [r0, #0x374]
	bx lr
	.align 2, 0
_0215E76C: .word ovl01_215E770
	arm_func_end ovl01_215E754

	arm_func_start ovl01_215E770
ovl01_215E770: // 0x0215E770
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x370]
	ldr r0, [r0, #0x384]
	cmp r0, #1
	cmpne r0, #2
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r2, [r4, #0x368]
	add r0, r4, #0x384
	mov r3, #0xf
	bl BossHelpers__Animation__Func_2038BF0
	mov r1, #0xa000
	rsb r1, r1, #0
	ldr r0, _0215E7D4 // =ovl01_215E7D8
	str r1, [r4, #0x9c]
	str r0, [r4, #0x374]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E7D4: .word ovl01_215E7D8
	arm_func_end ovl01_215E770

	arm_func_start ovl01_215E7D8
ovl01_215E7D8: // 0x0215E7D8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x370]
	ldr r2, [r0, #0x370]
	ldr r0, [r2, #0x384]
	cmp r0, #1
	cmpne r0, #2
	beq _0215E840
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r2, [r4, #0x368]
	add r0, r4, #0x384
	mov r3, #9
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, [r4, #0x1c]
	mov r1, #0
	orr r0, r0, #0x80
	str r0, [r4, #0x1c]
	ldr r0, _0215E874 // =ovl01_215E564
	str r1, [r4, #0x9c]
	add sp, sp, #8
	str r0, [r4, #0x374]
	ldmia sp!, {r4, pc}
_0215E840:
	ldr r1, [r4, #0x48]
	ldr r0, [r2, #0x45c]
	cmp r1, r0
	addgt sp, sp, #8
	ldmgtia sp!, {r4, pc}
	ldr r0, [r2, #0x48]
	mov r1, #0
	str r0, [r4, #0x48]
	ldr r0, _0215E878 // =ovl01_215E87C
	str r1, [r4, #0x9c]
	str r0, [r4, #0x374]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E874: .word ovl01_215E564
_0215E878: .word ovl01_215E87C
	arm_func_end ovl01_215E7D8

	arm_func_start ovl01_215E87C
ovl01_215E87C: // 0x0215E87C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	ldr r2, [r4, #0x368]
	add r0, r4, #0x384
	mov r3, #0x11
	bl BossHelpers__Animation__Func_2038BF0
	mov r1, #1
	ldr r0, _0215E8BC // =ovl01_215E8C0
	str r1, [r4, #0x37c]
	str r0, [r4, #0x374]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E8BC: .word ovl01_215E8C0
	arm_func_end ovl01_215E87C

	arm_func_start ovl01_215E8C0
ovl01_215E8C0: // 0x0215E8C0
	stmdb sp!, {r3, lr}
	add r1, r0, #0x400
	ldrh r1, [r1, #0x90]
	tst r1, #0x8000
	ldmeqia sp!, {r3, pc}
	bl ovl01_215E1E8
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_215E8C0

	arm_func_start ovl01_215E8DC
ovl01_215E8DC: // 0x0215E8DC
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r0, [r5, #0x3b8]
	cmp r0, #0
	beq _0215EAAC
	ldr r1, [r5, #0x370]
	ldr r0, [r5, #0x3bc]
	ldr r4, [r1, #0x370]
	cmp r0, #0
	beq _0215EA58
	add r0, r5, #0x300
	ldrsh r1, [r0, #0xc6]
	ldrsh r0, [r0, #0xc2]
	rsb r2, r1, #0
	cmp r0, r2
	blt _0215E928
	cmp r0, r1
	movle r1, r0
	mov r2, r1
_0215E928:
	add r3, r5, #0x300
	strh r2, [r3, #0xc2]
	ldrsh r0, [r3, #0xc2]
	cmp r0, #0
	ble _0215E9BC
	ldrsh r1, [r3, #0xc4]
	cmp r0, r1
	bge _0215E980
	sub r6, r1, r0
	mov r1, #0x7a
	umull lr, ip, r6, r1
	mov r2, #0
	mla ip, r6, r2, ip
	mov r2, r6, asr #0x1f
	adds r6, lr, #0x800
	mla ip, r2, r1, ip
	adc r1, ip, #0
	mov r2, r6, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r0, r0, r2
	strh r0, [r3, #0xc2]
	b _0215EA44
_0215E980:
	ble _0215EA44
	sub r6, r0, r1
	mov r1, #0x7a
	umull lr, ip, r6, r1
	mov r2, #0
	mla ip, r6, r2, ip
	mov r2, r6, asr #0x1f
	adds r6, lr, #0x800
	mla ip, r2, r1, ip
	adc r1, ip, #0
	mov r2, r6, lsr #0xc
	orr r2, r2, r1, lsl #20
	sub r0, r0, r2
	strh r0, [r3, #0xc2]
	b _0215EA44
_0215E9BC:
	bge _0215EA44
	ldrsh r2, [r3, #0xc4]
	rsb r1, r2, #0
	cmp r0, r1
	bge _0215EA0C
	add r1, r2, r0
	rsb r6, r1, #0
	mov r1, #0x7a
	umull lr, ip, r6, r1
	mov r2, #0
	mla ip, r6, r2, ip
	mov r2, r6, asr #0x1f
	adds r6, lr, #0x800
	mla ip, r2, r1, ip
	adc r1, ip, #0
	mov r2, r6, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r0, r0, r2
	strh r0, [r3, #0xc2]
	b _0215EA44
_0215EA0C:
	ble _0215EA44
	add ip, r0, r2
	mov r1, #0x7a
	umull r6, lr, ip, r1
	mov r2, #0
	mla lr, ip, r2, lr
	mov r2, ip, asr #0x1f
	adds r6, r6, #0x800
	mla lr, r2, r1, lr
	adc r1, lr, #0
	mov r2, r6, lsr #0xc
	orr r2, r2, r1, lsl #20
	sub r0, r0, r2
	strh r0, [r3, #0xc2]
_0215EA44:
	add r0, r5, #0x300
	ldrh r2, [r0, #0xc0]
	ldrsh r1, [r0, #0xc2]
	add r1, r2, r1
	strh r1, [r0, #0xc0]
_0215EA58:
	add r0, r5, #0x300
	ldrh r1, [r0, #0xc0]
	ldr r3, _0215EAD8 // =FX_SinCosTable_
	add r0, r5, #0x3f0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	blx MTX_RotY33_
	ldr r2, [r5, #0x384]
	mov r0, #0x30
	mla r1, r2, r0, r4
	add r0, r5, #0x14
	add r1, r1, #0x3f8
	add r3, r0, #0x400
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	b _0215EAC8
_0215EAAC:
	ldr r1, [r5, #0x48]
	ldr r2, [r5, #0x4c]
	ldr r0, [r5, #0x44]
	rsb r1, r1, #0
	str r0, [r5, #0x414]
	str r1, [r5, #0x418]
	str r2, [r5, #0x41c]
_0215EAC8:
	ldr r1, [r5, #0x37c]
	mov r0, r5
	blx r1
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215EAD8: .word FX_SinCosTable_
	arm_func_end ovl01_215E8DC

	arm_func_start ovl01_215EADC
ovl01_215EADC: // 0x0215EADC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	add r0, r0, #0x3cc
	bl AnimatorMDL__Release
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_215EADC

	arm_func_start ovl01_215EAFC
ovl01_215EAFC: // 0x0215EAFC
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	ldr r1, [r5, #0x20]
	tst r1, #0x20
	ldmneia sp!, {r3, r4, r5, pc}
	bl ovl01_215EB44
	mov r4, r0
	add r0, r5, #0x3cc
	bl AnimatorMDL__ProcessAnimation
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r5, #0x3cc
	bl AnimatorMDL__Draw
	add r1, r5, #0x388
	mov r0, #0x1e
	bl BossHelpers__Model__SetMatrixMode
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_215EAFC

	arm_func_start ovl01_215EB44
ovl01_215EB44: // 0x0215EB44
	stmdb sp!, {r4, lr}
	ldr r1, [r0, #0x3c8]
	mov r4, #0
	cmp r1, #0
	beq _0215EB98
	ldr r0, [r0, #0x380]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _0215EB88
_0215EB68: // jump table
	b _0215EB7C // case 0
	b _0215EB80 // case 1
	b _0215EB80 // case 2
	b _0215EB88 // case 3
	b _0215EB80 // case 4
_0215EB7C:
	b _0215EBA0
_0215EB80:
	mov r4, #1
	b _0215EBA0
_0215EB88:
	bl Camera3D__UseEngineA
	cmp r0, #0
	movne r4, #1
	b _0215EBA0
_0215EB98:
	mov r4, #1
	str r4, [r0, #0x3c8]
_0215EBA0:
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_215EB44

	arm_func_start ovl01_215EBA8
ovl01_215EBA8: // 0x0215EBA8
	mov r2, #0
	ldr r1, _0215EBBC // =ovl01_215EC44
	str r2, [r0, #0x380]
	str r1, [r0, #0x37c]
	bx lr
	.align 2, 0
_0215EBBC: .word ovl01_215EC44
	arm_func_end ovl01_215EBA8

	arm_func_start ovl01_215EBC0
ovl01_215EBC0: // 0x0215EBC0
	mov r2, #1
	ldr r1, _0215EBD4 // =ovl01_215EC5C
	str r2, [r0, #0x380]
	str r1, [r0, #0x37c]
	bx lr
	.align 2, 0
_0215EBD4: .word ovl01_215EC5C
	arm_func_end ovl01_215EBC0

	arm_func_start ovl01_215EBD8
ovl01_215EBD8: // 0x0215EBD8
	mov r2, #2
	ldr r1, _0215EBEC // =ovl01_215EF50
	str r2, [r0, #0x380]
	str r1, [r0, #0x37c]
	bx lr
	.align 2, 0
_0215EBEC: .word ovl01_215EF50
	arm_func_end ovl01_215EBD8

	arm_func_start ovl01_215EBF0
ovl01_215EBF0: // 0x0215EBF0
	stmdb sp!, {r3, lr}
	mov r3, #3
	str r3, [r0, #0x380]
	mov r3, #1
	str r3, [r0, #0x3bc]
	add r3, r0, #0x300
	strh r1, [r3, #0xc0]
	ldr ip, _0215EC20 // =ovl01_215F204
	strh r2, [r3, #0xc2]
	str ip, [r0, #0x37c]
	blx ip
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215EC20: .word ovl01_215F204
	arm_func_end ovl01_215EBF0

	arm_func_start ovl01_215EC24
ovl01_215EC24: // 0x0215EC24
	stmdb sp!, {r3, lr}
	mov r2, #4
	ldr r1, _0215EC40 // =ovl01_215F258
	str r2, [r0, #0x380]
	str r1, [r0, #0x37c]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215EC40: .word ovl01_215F258
	arm_func_end ovl01_215EC24

	arm_func_start ovl01_215EC44
ovl01_215EC44: // 0x0215EC44
	mov r1, #0
	str r1, [r0, #0x3bc]
	ldr r1, [r0, #0x20]
	orr r1, r1, #0x20
	str r1, [r0, #0x20]
	bx lr
	arm_func_end ovl01_215EC44

	arm_func_start ovl01_215EC5C
ovl01_215EC5C: // 0x0215EC5C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0
	str r0, [r4, #0x3b8]
	ldr r1, [r4, #0x1c]
	ldr r0, _0215ECC8 // =gPlayer
	bic r1, r1, #0x80
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	ldr r2, _0215ECCC // =0x00722543
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	ldr r0, [r0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__Func_2038DCC
	ldr r1, _0215ECD0 // =0xFFFFB556
	add r2, r4, #0x300
	add r0, r0, r1
	strh r0, [r2, #0xc0]
	mov r0, #0x800
	strh r0, [r2, #0xc2]
	mov r1, #0x1f4000
	ldr r0, _0215ECD4 // =ovl01_215ECD8
	str r1, [r4, #0x374]
	str r0, [r4, #0x37c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215ECC8: .word gPlayer
_0215ECCC: .word 0x00722543
_0215ECD0: .word 0xFFFFB556
_0215ECD4: .word ovl01_215ECD8
	arm_func_end ovl01_215EC5C

	arm_func_start ovl01_215ECD8
ovl01_215ECD8: // 0x0215ECD8
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x24
	mov r6, r0
	ldr r1, [r6, #0x370]
	ldr r0, [r6, #0x374]
	ldr r4, [r1, #0x370]
	sub r0, r0, #0x2000
	str r0, [r6, #0x374]
	cmp r0, #0xfa000
	movlt r0, #0xfa000
	strlt r0, [r6, #0x374]
	add r0, r6, #0x300
	mov r5, #0
	ldrh r0, [r0, #0xc0]
	ldr r1, [r6, #0x374]
	add r2, r6, #0x44
	add r3, r6, #0x4c
	movlt r5, #1
	bl BossHelpers__Arena__Func_2038D24
	ldr r1, [r6, #0x384]
	mov r0, #0x30
	mla r0, r1, r0, r4
	ldr r1, [r0, #0x3fc]
	add r0, r6, #0x300
	rsb r1, r1, #0
	str r1, [r6, #0x48]
	ldrsh r1, [r0, #0xc2]
	add r3, r6, #0x300
	sub r1, r1, #0x10
	strh r1, [r0, #0xc2]
	ldrsh r1, [r0, #0xc2]
	cmp r1, #0x300
	movlt r1, #0x300
	strlth r1, [r0, #0xc2]
	ldr r0, _0215EDD8 // =FX_SinCosTable_+0x3800
	ldrh ip, [r3, #0xc0]
	ldrsh r4, [r3, #0xc2]
	ldrsh r1, [r0, #0xe0]
	ldrsh r2, [r0, #0xe2]
	add r4, ip, r4
	add r0, r6, #0x3f0
	strh r4, [r3, #0xc0]
	blx MTX_RotX33_
	add r0, r6, #0x300
	ldrh r1, [r0, #0xc0]
	ldr r3, _0215EDDC // =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	blx MTX_RotY33_
	add r0, r6, #0x3f0
	add r1, sp, #0
	mov r2, r0
	bl MTX_Concat33
	cmp r5, #0
	ldrne r0, _0215EDE0 // =ovl01_215EDE4
	strne r0, [r6, #0x37c]
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0215EDD8: .word FX_SinCosTable_+0x3800
_0215EDDC: .word FX_SinCosTable_
_0215EDE0: .word ovl01_215EDE4
	arm_func_end ovl01_215ECD8

	arm_func_start ovl01_215EDE4
ovl01_215EDE4: // 0x0215EDE4
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x24
	mov r4, r0
	ldr r1, [r4, #0x374]
	ldr r0, _0215EF44 // =0x001C2000
	add r1, r1, #0x2000
	str r1, [r4, #0x374]
	cmp r1, r0
	strgt r0, [r4, #0x374]
	add r0, r4, #0x300
	ldrh r0, [r0, #0xc0]
	ldr r1, [r4, #0x374]
	add r2, r4, #0x44
	add r3, r4, #0x4c
	bl BossHelpers__Arena__Func_2038D24
	ldr r0, [r4, #0x9c]
	ldr r2, _0215EF48 // =FX_SinCosTable_+0x3800
	add r0, r0, #0x99
	add r0, r0, #0x100
	str r0, [r4, #0x9c]
	cmp r0, #0x8000
	movgt r0, #0x8000
	strgt r0, [r4, #0x9c]
	add r0, r4, #0x300
	ldrsh r1, [r0, #0xc2]
	add r1, r1, #8
	strh r1, [r0, #0xc2]
	ldrsh r1, [r0, #0xc2]
	cmp r1, #0x400
	movgt r1, #0x400
	strgth r1, [r0, #0xc2]
	add r0, r4, #0x300
	ldrsh r1, [r2, #0xe0]
	ldrh ip, [r0, #0xc0]
	ldrsh r3, [r0, #0xc2]
	ldrsh r2, [r2, #0xe2]
	add r3, ip, r3
	strh r3, [r0, #0xc0]
	add r0, r4, #0x3f0
	blx MTX_RotX33_
	ldr r0, [r4, #0x9c]
	mov r1, #0x5000
	bl FX_Div
	rsb r0, r0, #0
	mov r0, r0, lsl #0xf
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _0215EF4C // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0
	blx MTX_RotZ33_
	add r0, r4, #0x3f0
	add r1, sp, #0
	mov r2, r0
	bl MTX_Concat33
	add r0, r4, #0x300
	ldrh r1, [r0, #0xc0]
	ldr r3, _0215EF4C // =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	blx MTX_RotY33_
	add r0, r4, #0x3f0
	add r1, sp, #0
	mov r2, r0
	bl MTX_Concat33
	ldr r0, [r4, #0x48]
	cmp r0, #0x320000
	addle sp, sp, #0x24
	ldmleia sp!, {r3, r4, pc}
	mov r1, #0x320000
	mov r0, r4
	str r1, [r4, #0x48]
	bl ovl01_215EBD8
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0215EF44: .word 0x001C2000
_0215EF48: .word FX_SinCosTable_+0x3800
_0215EF4C: .word FX_SinCosTable_
	arm_func_end ovl01_215EDE4

	arm_func_start ovl01_215EF50
ovl01_215EF50: // 0x0215EF50
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	ldr r2, [r5, #0x370]
	ldr r1, [r5, #0x384]
	mov r0, #0
	add r1, r2, r1, lsl #2
	ldr r4, [r1, #0x384]
	mov ip, #0x3e8000
	str r0, [r5, #0x3b8]
	ldr r0, [r5, #0x1c]
	ldr r6, _0215F06C // =_mt_math_rand
	bic r0, r0, #0x80
	str r0, [r5, #0x1c]
	ldr r1, [r5, #0x20]
	ldr r0, _0215F070 // =0x00196225
	bic r1, r1, #0x20
	str r1, [r5, #0x20]
	ldr r3, [r5, #0x370]
	ldr r2, [r5, #0x384]
	ldr r1, _0215F074 // =0x3C6EF35F
	add r2, r3, r2, lsl #2
	ldr r7, [r2, #0x384]
	ldr r3, _0215F078 // =gPlayer
	ldr lr, [r7, #0x20]
	ldr r2, _0215F07C // =0x00722543
	bic lr, lr, #0x20
	str lr, [r7, #0x20]
	str ip, [r5, #0x48]
	ldr ip, [r6]
	ldr r3, [r3]
	mla r0, ip, r0, r1
	str r0, [r6]
	mov r6, r0, lsr #0x10
	ldr r0, [r3, #0x44]
	mov r1, #0x40000
	mov r6, r6, lsl #0x10
	bl BossHelpers__Arena__Func_2038DCC
	ldr r1, _0215F080 // =0x00003FFF
	add r2, r0, #0x6000
	and r0, r1, r6, lsr #16
	add r1, r2, r0
	add r0, r5, #0x300
	strh r1, [r0, #0xc0]
	mov r1, #0x190000
	str r1, [r5, #0x374]
	ldrh r1, [r0, #0xc0]
	ldr r3, _0215F084 // =FX_SinCosTable_
	add r0, r5, #0x3f0
	sub r1, r1, #0x4000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r6, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r6]
	ldrsh r2, [r3, r2]
	blx MTX_RotY33_
	mov r0, r4
	bl ovl01_215FB14
	add r0, r4, #0x380
	bl ovl01_21600AC
	ldr r1, [r4, #0x18]
	ldr r0, _0215F088 // =ovl01_215F08C
	orr r1, r1, #2
	str r1, [r4, #0x18]
	str r0, [r5, #0x37c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215F06C: .word _mt_math_rand
_0215F070: .word 0x00196225
_0215F074: .word 0x3C6EF35F
_0215F078: .word gPlayer
_0215F07C: .word 0x00722543
_0215F080: .word 0x00003FFF
_0215F084: .word FX_SinCosTable_
_0215F088: .word ovl01_215F08C
	arm_func_end ovl01_215EF50

	arm_func_start ovl01_215F08C
ovl01_215F08C: // 0x0215F08C
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	add r0, r5, #0x300
	ldrh r0, [r0, #0xc0]
	ldr r4, [r5, #0x370]
	ldr r1, [r5, #0x374]
	ldr r6, [r4, #0x370]
	add r2, r5, #0x44
	add r3, r5, #0x4c
	mov r4, #0
	bl BossHelpers__Arena__Func_2038D24
	ldr r1, [r5, #0x384]
	mov r0, #0x30
	mla r0, r1, r0, r6
	ldr r1, [r0, #0x3fc]
	ldr r2, [r5, #0x48]
	ldr r0, _0215F120 // =0x00000199
	add r2, r2, r1
	umull ip, r3, r2, r0
	mov r1, r4
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds ip, ip, #0x800
	adc r0, r3, #0
	mov r1, ip, lsr #0xc
	orr r1, r1, r0, lsl #20
	cmp r1, #0x8000
	movgt r1, #0x8000
	cmp r1, #0x28
	movlt r4, #1
	rsb r0, r1, #0
	str r0, [r5, #0x9c]
	cmp r4, #0
	ldrne r0, _0215F124 // =ovl01_215F128
	strne r0, [r5, #0x37c]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215F120: .word 0x00000199
_0215F124: .word ovl01_215F128
	arm_func_end ovl01_215F08C

	arm_func_start ovl01_215F128
ovl01_215F128: // 0x0215F128
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x374]
	mov r5, #0
	subs r0, r0, #0xa000
	str r0, [r4, #0x374]
	strmi r5, [r4, #0x374]
	add r0, r4, #0x300
	ldrh r0, [r0, #0xc0]
	ldr r1, [r4, #0x374]
	movmi r5, #1
	add r2, r4, #0x44
	add r3, r4, #0x4c
	bl BossHelpers__Arena__Func_2038D24
	cmp r5, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r1, [r4, #0x370]
	ldr r0, [r4, #0x384]
	add r0, r1, r0, lsl #2
	ldr r0, [r0, #0x384]
	add r0, r0, #0x380
	bl ovl01_216009C
	mov ip, #0x9c
	sub r1, ip, #0x9d
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	ldr r2, _0215F1F8 // =_mt_math_rand
	ldr r0, _0215F1FC // =0x00196225
	ldr r3, [r2]
	ldr r1, _0215F200 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	str r1, [r2]
	add r0, r4, #0x300
	ldrh r1, [r0, #0xc0]
	movne r2, #1
	mvneq r2, #0
	sub r1, r1, #0x4000
	mov r1, r1, lsl #0x10
	mov r0, r4
	mov r1, r1, lsr #0x10
	bl ovl01_215EBF0
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215F1F8: .word _mt_math_rand
_0215F1FC: .word 0x00196225
_0215F200: .word 0x3C6EF35F
	arm_func_end ovl01_215F128

	arm_func_start ovl01_215F204
ovl01_215F204: // 0x0215F204
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	add r0, r4, #0x300
	mov r1, #0x400
	strh r1, [r0, #0xc6]
	mov r0, #1
	str r0, [r4, #0x3b8]
	ldr r1, [r4, #0x370]
	ldr r0, [r4, #0x384]
	add r0, r1, r0, lsl #2
	ldr r5, [r0, #0x384]
	add r0, r5, #0x380
	bl ovl01_2160084
	ldr r1, [r5, #0x18]
	ldr r0, _0215F250 // =ovl01_215F254
	bic r1, r1, #2
	str r1, [r5, #0x18]
	str r0, [r4, #0x37c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215F250: .word ovl01_215F254
	arm_func_end ovl01_215F204

	arm_func_start ovl01_215F254
ovl01_215F254: // 0x0215F254
	bx lr
	arm_func_end ovl01_215F254

	arm_func_start ovl01_215F258
ovl01_215F258: // 0x0215F258
	mov ip, #0
	str ip, [r0, #0x374]
	str ip, [r0, #0x3b8]
	ldr r1, [r0, #0x414]
	sub r2, ip, #0x5000
	str r1, [r0, #0x44]
	ldr r3, [r0, #0x418]
	ldr r1, _0215F2C4 // =ovl01_215F2C8
	rsb r3, r3, #0
	str r3, [r0, #0x48]
	ldr r3, [r0, #0x41c]
	str r3, [r0, #0x4c]
	ldr r3, [r0, #0x1c]
	orr r3, r3, #0x80
	str r3, [r0, #0x1c]
	str r2, [r0, #0x9c]
	str ip, [r0, #0x98]
	str ip, [r0, #0xa0]
	ldr r3, [r0, #0x370]
	ldr r2, [r0, #0x384]
	add r2, r3, r2, lsl #2
	ldr r3, [r2, #0x384]
	ldr r2, [r3, #0x18]
	orr r2, r2, #2
	str r2, [r3, #0x18]
	str r1, [r0, #0x37c]
	bx lr
	.align 2, 0
_0215F2C4: .word ovl01_215F2C8
	arm_func_end ovl01_215F258

	arm_func_start ovl01_215F2C8
ovl01_215F2C8: // 0x0215F2C8
	mov r3, r0
	ldr r1, [r3, #0x374]
	ldr r0, _0215F35C // =0x001187BC
	add r1, r1, #0x2000
	cmp r1, r0
	str r1, [r3, #0x374]
	ldrle r1, [r3, #0x48]
	ldrle r0, _0215F360 // =0x005DC000
	cmple r1, r0
	ble _0215F334
	ldr r1, _0215F35C // =0x001187BC
	ldr r0, _0215F360 // =0x005DC000
	str r1, [r3, #0x374]
	ldr r1, [r3, #0x20]
	orr r1, r1, #0x20
	str r1, [r3, #0x20]
	ldr r2, [r3, #0x370]
	ldr r1, [r3, #0x384]
	add r1, r2, r1, lsl #2
	ldr r2, [r1, #0x384]
	ldr r1, [r2, #0x20]
	orr r1, r1, #0x20
	str r1, [r2, #0x20]
	str r0, [r3, #0x48]
	ldr r0, [r3, #0x1c]
	bic r0, r0, #0x80
	str r0, [r3, #0x1c]
_0215F334:
	add r0, r3, #0x300
	ldrh r0, [r0, #0xc0]
	ldr ip, _0215F364 // =BossHelpers__Arena__Func_2038D24
	ldr r1, [r3, #0x374]
	add r0, r0, #0x4000
	mov r0, r0, lsl #0x10
	add r2, r3, #0x44
	mov r0, r0, lsr #0x10
	add r3, r3, #0x4c
	bx ip
	.align 2, 0
_0215F35C: .word 0x001187BC
_0215F360: .word 0x005DC000
_0215F364: .word BossHelpers__Arena__Func_2038D24
	arm_func_end ovl01_215F2C8

	arm_func_start ovl01_215F368
ovl01_215F368: // 0x0215F368
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r3, r4, #0x8e
	ldr r0, [r4, #0x370]
	ldr r1, [r4, #0x37c]
	add r2, r4, #0x38c
	add r3, r3, #0x300
	bl ovl01_215C0A0
	ldr r1, [r4, #0x374]
	mov r0, r4
	blx r1
	ldr r2, [r4, #0x380]
	mov r0, r4
	add r1, r4, #0x380
	blx r2
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_215F368

	arm_func_start ovl01_215F3A8
ovl01_215F3A8: // 0x0215F3A8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x1b8
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	add r0, r4, #0x2fc
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	add r0, r4, #0x840
	bl AnimatorMDL__Release
	add r0, r4, #0x394
	bl AnimatorMDL__Release
	add r0, r4, #0x198
	add r0, r0, #0x400
	bl ReleasePaletteAnimator
	ldr r0, [r4, #0x984]
	bl FreeSndHandle
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_215F3A8

	arm_func_start ovl01_215F400
ovl01_215F400: // 0x0215F400
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	ldr r0, [r5, #0x20]
	tst r0, #0x20
	ldmneia sp!, {r3, r4, r5, pc}
	add r4, r5, #0x1b8
	add r0, r4, #0x400
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #0x400
	bl AnimatorMDL__Draw
	add r0, r5, #0xd8
	add r1, r0, #0x400
	mov r0, #0x1e
	bl BossHelpers__Model__SetMatrixMode
	add r0, r5, #0xd8
	add ip, r0, #0x400
	add r4, r5, #0x3b8
	ldmia ip!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia ip!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia ip, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	add r0, r5, #0x394
	bl AnimatorMDL__ProcessAnimation
	add r0, r5, #0x394
	bl AnimatorMDL__Draw
	mov r0, r5
	bl ovl01_215F490
	add r4, r5, #0x198
	add r0, r4, #0x400
	bl AnimatePalette
	add r0, r4, #0x400
	bl DrawAnimatedPalette
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_215F400

	arm_func_start ovl01_215F490
ovl01_215F490: // 0x0215F490
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x18
	mov r5, r0
	add r0, r5, #0x2fc
	ldr r1, _0215F540 // =_02179CC8
	add r4, r0, #0x400
	add ip, sp, #0xc
	ldmia r1, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	add r3, r5, #0xfc
	add r0, r3, #0x400
	add r3, r4, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x48]
	ldr r2, _0215F544 // =0x00722543
	str r1, [sp]
	ldr ip, [r4, #0x50]
	ldr r3, _0215F548 // =0x001187BC
	add r0, sp, #8
	mov r1, #0x40000
	str ip, [sp, #4]
	bl BossHelpers__Arena__Func_2038D88
	add r0, r4, #0x48
	str r0, [sp]
	add r0, r4, #0x50
	str r0, [sp, #4]
	ldr r0, [sp, #8]
	ldr r2, _0215F544 // =0x00722543
	ldr r3, _0215F548 // =0x001187BC
	mov r1, #0x40000
	bl BossHelpers__Arena__Func_2038CDC
	ldr r2, [r5, #0x37c]
	add r1, sp, #0xc
	ldr r3, [r4, #0x4c]
	ldr r1, [r1, r2, lsl #2]
	mov r0, r4
	sub r1, r3, r1
	str r1, [r4, #0x4c]
	bl AnimatorMDL__Draw
	add r0, r5, #0x840
	bl AnimatorMDL__Draw
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215F540: .word _02179CC8
_0215F544: .word 0x00722543
_0215F548: .word 0x001187BC
	arm_func_end ovl01_215F490

	arm_func_start ovl01_215F54C
ovl01_215F54C: // 0x0215F54C
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, lr}
	sub sp, sp, #8
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x18]
	tst r1, #0xc
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	tst r1, #2
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	add r1, r0, #0x500
	ldrh r2, [r1, #0x88]
	cmp r2, #0
	subne r0, r2, #1
	strneh r0, [r1, #0x88]
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	add r1, r0, #0x108
	ldr sl, _0215F60C // =0x00722543
	ldr sb, _0215F610 // =0x001187BC
	add r5, r0, #0x218
	add r6, r1, #0x400
	mov r4, #0
	add r7, r0, #0xfc
	mov r8, #0x40000
_0215F5B0:
	ldr r0, [r5, #0x18]
	bic r0, r0, #0x800
	str r0, [r5, #0x18]
	ldr r0, [r6, #0x18]
	bic r0, r0, #0x800
	str r0, [r6, #0x18]
	ldr r0, [r5, #0x18]
	tst r0, #4
	beq _0215F5F0
	str sl, [sp]
	mov r0, r5
	mov r1, r6
	mov r3, r8
	add r2, r7, #0x400
	str sb, [sp, #4]
	bl BossHelpers__Collision__Func_203919C
_0215F5F0:
	add r4, r4, #1
	cmp r4, #2
	add r5, r5, #0x40
	add r6, r6, #0x40
	blt _0215F5B0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, pc}
	.align 2, 0
_0215F60C: .word 0x00722543
_0215F610: .word 0x001187BC
	arm_func_end ovl01_215F54C

	arm_func_start ovl01_215F614
ovl01_215F614: // 0x0215F614
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, lr}
	sub sp, sp, #0x1c
	mov r8, r0
	ldr r5, [r8, #0x1c]
	mov r7, r1
	ldrh r0, [r5]
	ldr r4, [r7, #0x1c]
	cmp r0, #1
	addne sp, sp, #0x1c
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
	ldr r0, [r5, #0x1c]
	tst r0, #1
	addne sp, sp, #0x1c
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
	ldr r1, [r4, #0x4fc]
	ldr r2, _0215F888 // =0x00722543
	str r1, [sp]
	ldr r1, [r4, #0x504]
	ldr r3, _0215F88C // =0x001187BC
	str r1, [sp, #4]
	add r0, sp, #8
	mov r1, #0x40000
	bl BossHelpers__Arena__Func_2038D88
	ldr r0, [r4, #0x500]
	rsb r0, r0, #0
	str r0, [sp, #0xc]
	ldr r0, [r4, #0x590]
	cmp r0, #0x4000
	ldrgt r6, [r4, #0x58c]
	bgt _0215F6C8
	ldr r0, [r5, #0x98]
	cmp r0, #0
	rsblt r1, r0, #0
	movge r1, r0
	cmp r1, #0x80
	ble _0215F6B4
	cmp r0, #0
	movle r6, #1
	movgt r6, #0
	b _0215F6C8
_0215F6B4:
	ldr r1, [sp, #8]
	ldr r0, [r5, #0x44]
	cmp r1, r0
	movlt r6, #1
	movge r6, #0
_0215F6C8:
	cmp r6, #0
	ldr sl, [r5, #0x98]
	beq _0215F6E0
	cmp sl, #0
	movgt sl, #0
	b _0215F6E8
_0215F6E0:
	cmp sl, #0
	movlt sl, #0
_0215F6E8:
	ldr r0, [r5, #0x9c]
	mov r1, #0xb50
	cmp r0, #0
	movgt r0, #0
	cmp sl, #0
	rsblt sl, sl, #0
	cmp r0, #0
	rsblt r0, r0, #0
	umull sb, lr, sl, r1
	mov r2, #0
	mla lr, sl, r2, lr
	umull ip, r3, r0, r1
	mla r3, r0, r2, r3
	mov sl, sl, asr #0x1f
	mov r0, r0, asr #0x1f
	adds sb, sb, #0x800
	mla lr, sl, r1, lr
	adc sl, lr, #0
	adds r2, ip, #0x800
	mla r3, r0, r1, r3
	mov sb, sb, lsr #0xc
	adc r0, r3, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	orr sb, sb, sl, lsl #20
	sub r0, r1, #0x1d
	add sb, sb, r2
	cmp sb, r0
	movlt sb, r0
	ldr r0, [r4, #0x370]
	ldr r1, [r4, #0x37c]
	bl ovl01_215C060
	smull r1, r0, sb, r0
	adds r1, r1, #0x800
	adc r3, r0, #0
	mov r2, r1, lsr #0xc
	mov r0, r4
	mov r1, r6
	orr r2, r2, r3, lsl #20
	bl ovl01_215F964
	ldr r0, [r5, #0x48]
	ldr sb, [sp, #0xc]
	cmp sb, r0
	bge _0215F7B8
	ldrsh r3, [r7, #8]
	ldrsh r2, [r8, #2]
	mov r1, #0x1000
	add r3, sb, r3, lsl #12
	add r0, r0, r2, lsl #12
	sub r0, r3, r0
	str r0, [r5, #0xb4]
	b _0215F7D8
_0215F7B8:
	ldrsh r3, [r7, #2]
	ldrsh r2, [r8, #8]
	mov r1, #0x4000
	add r3, sb, r3, lsl #12
	add r0, r0, r2, lsl #12
	sub r0, r3, r0
	str r0, [r5, #0xb4]
	rsb r1, r1, #0
_0215F7D8:
	mov r0, #0x8000
	str r1, [r5, #0x9c]
	cmp r6, #0
	rsbeq r0, r0, #0
	str r0, [r5, #0x98]
	add r1, sp, #0x10
	str r1, [sp]
	add r0, sp, #0x18
	str r0, [sp, #4]
	ldr r0, [r5, #0x44]
	ldr r2, _0215F888 // =0x00722543
	ldr r3, _0215F88C // =0x001187BC
	mov r1, #0x40000
	bl BossHelpers__Arena__Func_2038CDC
	ldr r0, [r5, #0x48]
	ldr r1, [sp, #0x10]
	rsb r2, r0, #0
	ldr r3, [sp, #0x18]
	mov r0, #0
	str r2, [sp, #0x14]
	bl BossFX__CreateHitB
	mov r5, #0x9c
	sub r1, r5, #0x9d
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlaySfxEx
	add r0, r4, #0x500
	mov r1, #4
	strh r1, [r0, #0x88]
	mov r2, #0
_0215F858:
	add r1, r4, r2, lsl #6
	ldr r0, [r1, #0x230]
	add r2, r2, #1
	orr r0, r0, #0x800
	str r0, [r1, #0x230]
	ldr r0, [r1, #0x520]
	cmp r2, #2
	orr r0, r0, #0x800
	str r0, [r1, #0x520]
	blt _0215F858
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
	.align 2, 0
_0215F888: .word 0x00722543
_0215F88C: .word 0x001187BC
	arm_func_end ovl01_215F614

	arm_func_start ovl01_215F890
ovl01_215F890: // 0x0215F890
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r2, [r6, #0x370]
	ldr r1, [r6, #0x37c]
	add r0, r6, #0x1dc
	add r1, r2, r1, lsl #2
	ldr r4, [r1, #0x374]
	add r5, r0, #0x400
	add lr, r4, #0x388
	ldmia lr!, {r0, r1, r2, r3}
	mov ip, r5
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r0, [lr]
	mov r2, #0
	str r0, [ip]
	str r2, [r5, #0xc]
	mov r0, #0x1000
	str r0, [r5, #0x10]
	str r2, [r5, #0x14]
	mov r0, r5
	add r1, r5, #0xc
	add r2, r5, #0x18
	bl VEC_CrossProduct
	add r0, r5, #0x18
	mov r1, r0
	bl VEC_Normalize
	add r0, r5, #0xc
	add r1, r5, #0x18
	mov r2, r5
	bl VEC_CrossProduct
	add r0, r4, #0x3ac
	add r3, r6, #0x600
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl01_215F890

	arm_func_start ovl01_215F924
ovl01_215F924: // 0x0215F924
	stmdb sp!, {r3, lr}
	mov r2, #0
	ldr r1, _0215F940 // =ovl01_215FAE0
	str r2, [r0, #0x378]
	str r1, [r0, #0x374]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215F940: .word ovl01_215FAE0
	arm_func_end ovl01_215F924

	arm_func_start ovl01_215F944
ovl01_215F944: // 0x0215F944
	stmdb sp!, {r3, lr}
	mov r2, #1
	ldr r1, _0215F960 // =ovl01_215FB14
	str r2, [r0, #0x378]
	str r1, [r0, #0x374]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215F960: .word ovl01_215FB14
	arm_func_end ovl01_215F944

	arm_func_start ovl01_215F964
ovl01_215F964: // 0x0215F964
	stmdb sp!, {r4, lr}
	ldr ip, [r0, #0x370]
	ldr r4, [r0, #0x37c]
	mov r3, #2
	add r4, ip, r4, lsl #2
	ldr lr, [r4, #0x374]
	str r3, [r0, #0x378]
	str r1, [r0, #0x58c]
	ldr r3, [lr, #0x3bc]
	cmp r3, #0
	mov r3, #0
	beq _0215FA6C
	cmp r1, #0
	beq _0215F9E4
	add ip, lr, #0x300
	ldrsh r4, [ip, #0xc2]
	cmp r4, #0
	ble _0215F9E4
	ldrsh r1, [ip, #0xc4]
	cmp r4, r1
	ble _0215FA38
	sub r4, r4, r1
	mov r1, #0x64000
	umull lr, ip, r4, r1
	mla ip, r4, r3, ip
	mov r4, r4, asr #0x1f
	mla ip, r4, r1, ip
	adds r4, lr, #0x800
	adc r1, ip, r3
	mov r3, r4, lsr #0xc
	orr r3, r3, r1, lsl #20
	b _0215FA38
_0215F9E4:
	cmp r1, #0
	bne _0215FA38
	add r1, lr, #0x300
	ldrsh ip, [r1, #0xc2]
	cmp ip, #0
	ldrltsh r4, [r1, #0xc4]
	rsblt r1, r4, #0
	cmplt ip, r1
	bge _0215FA38
	add r1, r4, ip
	rsb r4, r1, #0
	mov r1, #0x64000
	umull lr, ip, r4, r1
	mov r3, #0
	mla ip, r4, r3, ip
	mov r3, r4, asr #0x1f
	adds r4, lr, #0x800
	mla ip, r3, r1, ip
	adc r1, ip, #0
	mov r3, r4, lsr #0xc
	orr r3, r3, r1, lsl #20
_0215FA38:
	ldr r1, _0215FAAC // =0x00000CCC
	mov ip, #0
	umull lr, r4, r3, r1
	mla r4, r3, ip, r4
	mov r3, r3, asr #0x1f
	adds ip, lr, #0x800
	mla r4, r3, r1, r4
	adc r1, r4, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r1, lsl #20
	add r1, r2, r3
	str r1, [r0, #0x590]
	b _0215FA9C
_0215FA6C:
	ldr ip, [r0, #0x590]
	ldr r1, _0215FAAC // =0x00000CCC
	umull r4, lr, ip, r1
	mla lr, ip, r3, lr
	mov r3, ip, asr #0x1f
	mla lr, r3, r1, lr
	adds r4, r4, #0x800
	adc r1, lr, #0
	mov r3, r4, lsr #0xc
	orr r3, r3, r1, lsl #20
	add r1, r3, r2
	str r1, [r0, #0x590]
_0215FA9C:
	ldr r1, _0215FAB0 // =ovl01_215FB84
	str r1, [r0, #0x374]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215FAAC: .word 0x00000CCC
_0215FAB0: .word ovl01_215FB84
	arm_func_end ovl01_215F964

	arm_func_start ovl01_215FAB4
ovl01_215FAB4: // 0x0215FAB4
	stmdb sp!, {r3, lr}
	mov r2, #3
	str r2, [r0, #0x378]
	mov r2, #0
	str r2, [r0, #0x590]
	ldr r1, _0215FADC // =ovl01_215FF00
	str r2, [r0, #0x594]
	str r1, [r0, #0x374]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215FADC: .word ovl01_215FF00
	arm_func_end ovl01_215FAB4

	arm_func_start ovl01_215FAE0
ovl01_215FAE0: // 0x0215FAE0
	mov r1, #0x3e8000
	rsb r1, r1, #0
	str r1, [r0, #0x48]
	ldr r1, [r0, #0x20]
	ldr ip, _0215FB10 // =ovl01_2160090
	orr r1, r1, #0x20
	str r1, [r0, #0x20]
	ldr r1, [r0, #0x18]
	orr r1, r1, #2
	str r1, [r0, #0x18]
	add r0, r0, #0x380
	bx ip
	.align 2, 0
_0215FB10: .word ovl01_2160090
	arm_func_end ovl01_215FAE0

	arm_func_start ovl01_215FB14
ovl01_215FB14: // 0x0215FB14
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x20]
	add r0, r4, #0x1b8
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldr r3, [r4, #0x37c]
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	add r3, r3, #3
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x18]
	add r0, r4, #0x380
	bic r1, r1, #2
	str r1, [r4, #0x18]
	bl ovl01_2160084
	ldr r0, _0215FB74 // =ovl01_215FB78
	str r0, [r4, #0x374]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215FB74: .word ovl01_215FB78
	arm_func_end ovl01_215FB14

	arm_func_start ovl01_215FB78
ovl01_215FB78: // 0x0215FB78
	ldr ip, _0215FB80 // =ovl01_215F890
	bx ip
	.align 2, 0
_0215FB80: .word ovl01_215F890
	arm_func_end ovl01_215FB78

	arm_func_start ovl01_215FB84
ovl01_215FB84: // 0x0215FB84
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r2, [r4, #0x370]
	ldr r1, [r4, #0x37c]
	ldr r0, [r4, #0x20]
	add r1, r2, r1, lsl #2
	ldr r2, [r1, #0x374]
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	mov r1, #0
	add r0, r4, #0x380
	str r1, [r2, #0x3bc]
	bl ovl01_216009C
	add r0, r4, #0x380
	bl ovl01_2160090
	ldr r0, [r4, #0x590]
	mov r1, #0
	str r0, [r4, #0x594]
	ldr r0, [r4, #0x58c]
	cmp r0, #0
	str r1, [sp]
	str r1, [sp, #4]
	movne ip, #0x28
	add r0, r4, #0x1b8
	ldr r3, [r4, #0x37c]
	moveq ip, #0x2e
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	add r3, ip, r3
	bl BossHelpers__Animation__Func_2038BF0
	mov r1, #0
	ldr r0, _0215FC18 // =ovl01_215FC1C
	str r1, [r4, #0x6d0]
	str r0, [r4, #0x374]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215FC18: .word ovl01_215FC1C
	arm_func_end ovl01_215FB84

	arm_func_start ovl01_215FC1C
ovl01_215FC1C: // 0x0215FC1C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r7, r0
	mov r1, #0x6000
	ldr r0, [r7, #0x594]
	rsb r1, r1, #0
	cmp r0, r1
	ldr r0, [r7, #0x69c]
	strlt r1, [r7, #0x594]
	ldr r2, [r0]
	ldr r1, [r7, #0x594]
	add r1, r2, r1
	str r1, [r0]
	ldr r1, [r7, #0x594]
	sub r1, r1, #0x66
	sub r1, r1, #0x200
	str r1, [r7, #0x594]
	ldr r2, [r0]
	cmp r2, #0
	bgt _0215FD24
	ldr r3, [r7, #0x370]
	ldr r1, [r7, #0x37c]
	mov r2, #0
	add r1, r3, r1, lsl #2
	ldr r3, [r1, #0x374]
	mov r1, #1
	str r2, [r0]
	str r1, [r3, #0x3bc]
	add r0, r3, #0x300
	ldrsh r0, [r0, #0xc2]
	add r2, r3, #0x300
	mov r1, #0
	cmp r0, #0
	rsblt r0, r0, #0
	strh r0, [r2, #0xc2]
	ldr r3, [r7, #0x590]
	mov r0, #0x28
	umull r5, r4, r3, r0
	mla r4, r3, r1, r4
	mov r1, r3, asr #0x1f
	mla r4, r1, r0, r4
	adds r3, r5, #0x800
	mov r1, r3, lsr #0xc
	adc r0, r4, #0
	orr r1, r1, r0, lsl #20
	ldrsh r3, [r2, #0xc2]
	mov r0, r1, lsl #0x10
	add r0, r3, r0, asr #16
	strh r0, [r2, #0xc2]
	ldr r0, [r7, #0x58c]
	cmp r0, #0
	ldreqsh r0, [r2, #0xc2]
	rsbeq r0, r0, #0
	streqh r0, [r2, #0xc2]
	mov r0, #0
	str r0, [r7, #0x590]
	mov r0, #0x1000
	str r0, [r7, #0x6d0]
	ldr r1, [r7, #0x594]
	mov r0, r7
	cmp r1, #0
	rsblt r1, r1, #0
	str r1, [r7, #0x590]
	bl ovl01_215F944
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215FD24:
	ldr r1, [r0, #8]
	sub r0, r2, #1
	ldrh r1, [r1, #4]
	cmp r0, r1, lsl #12
	blt _0215FEEC
	ldr r4, [r7, #0x370]
	mov r0, r4
	bl ovl01_215BF48
	mov r5, r0
	ldr r1, [r7, #0x37c]
	mov r0, r4
	bl ovl01_215BFC8
	ldr r1, [r7, #0x370]
	add r1, r1, #0x300
	ldrsh r2, [r1, #0x98]
	sub r2, r2, r0
	mov r0, r4
	strh r2, [r1, #0x98]
	bl ovl01_215BF48
	ldr r2, _0215FEFC // =_02179CD4
	mov r6, r0
	ldr r1, [r2, r6, lsl #2]
	ldr r0, [r2, r5, lsl #2]
	cmp r0, r1
	bge _0215FDAC
	ldr r0, [r7, #0x370]
	ldr r0, [r0, #0x370]
	str r1, [r0, #0x494]
	ldr r0, [r7, #0x370]
	add r0, r0, r1, lsl #2
	ldr r0, [r0, #0x374]
	bl ovl01_215EBC0
	mov r0, r4
	bl ovl01_215C240
_0215FDAC:
	cmp r5, r6
	beq _0215FDC4
	cmp r6, #3
	blo _0215FDC4
	mov r0, #1
	bl ChangeBossBGMVariant
_0215FDC4:
	ldr r1, [r7, #0x370]
	add r0, r1, #0x300
	ldrsh r0, [r0, #0x98]
	cmp r0, #0
	ble _0215FE14
	mov r0, #0x1000
	str r0, [r7, #0x6d0]
	ldr r0, [r7, #0x370]
	ldr r0, [r0, #0x370]
	bl ovl01_215D284
	mov r0, r7
	bl ovl01_215FAB4
	mov r3, #0x8c
	sub r1, r3, #0x8d
	mov r0, #0
	stmia sp, {r0, r3}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _0215FEA8
_0215FE14:
	ldr r0, [r1, #0x370]
	ldr r0, [r0, #0x384]
	cmp r0, #3
	beq _0215FEA0
	mov r0, r4
	bl ovl01_215BF48
	ldr r1, _0215FEFC // =_02179CD4
	mov r5, #0
	ldr r0, [r1, r0, lsl #2]
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	movs r6, r0, lsr #0x10
	beq _0215FE6C
_0215FE48:
	ldr r0, [r7, #0x370]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x374]
	bl ovl01_215EC24
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	cmp r6, r0, lsr #16
	mov r5, r0, lsr #0x10
	bhi _0215FE48
_0215FE6C:
	ldr r0, [r7, #0x370]
	ldr r0, [r0, #0x370]
	bl ovl01_215D2A4
	mov r5, #0xce
	sub r1, r5, #0xcf
	add r0, r4, #0x300
	mov r2, #1
	strh r2, [r0, #0x98]
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r5}
	bl PlaySfxEx
_0215FEA0:
	mov r0, r7
	bl ovl01_215FAB4
_0215FEA8:
	add r0, r4, #0x300
	ldrsh r0, [r0, #0x98]
	bl UpdateBossHealthHUD
	ldr r1, [r7, #0x4fc]
	ldr r2, [r7, #0x500]
	ldr r3, [r7, #0x504]
	mov r0, #0
	bl BossFX__CreateHitA
	mov r5, r0
	ldr r1, [r7, #0x37c]
	mov r0, r4
	bl ovl01_215BFF8
	str r0, [r5, #0x38]
	str r0, [r5, #0x3c]
	add sp, sp, #8
	str r0, [r5, #0x40]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0215FEEC:
	mov r0, r7
	bl ovl01_215F890
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215FEFC: .word _02179CD4
	arm_func_end ovl01_215FC1C

	arm_func_start ovl01_215FF00
ovl01_215FF00: // 0x0215FF00
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r2, [r5, #0x370]
	ldr r1, [r5, #0x37c]
	ldr r0, [r5, #0x18]
	add r1, r2, r1, lsl #2
	ldr r4, [r1, #0x374]
	orr r1, r0, #2
	add r0, r5, #0x380
	str r1, [r5, #0x18]
	bl ovl01_216009C
	add r0, r5, #0x380
	bl ovl01_2160090
	mov r0, #1
	str r0, [r4, #0x3bc]
	ldr r2, _0215FFEC // =_mt_math_rand
	ldr r0, _0215FFF0 // =0x00196225
	ldr r3, [r2]
	ldr r1, _0215FFF4 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	str r1, [r2]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	mov r1, #0x800
	rsbeq r1, r1, #0
	add r0, r4, #0x300
	strh r1, [r0, #0xc2]
	ldr r2, _0215FFEC // =_mt_math_rand
	ldr r0, _0215FFF0 // =0x00196225
	ldr r3, [r2]
	ldr r1, _0215FFF4 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0xf
	str r1, [r2]
	add r0, r0, #0x1e
	str r0, [r5, #0x2c]
	ldr r0, [r5, #0x58c]
	mov r1, #0
	cmp r0, #0
	str r1, [sp]
	str r1, [sp, #4]
	movne r4, #0x2b
	add r0, r5, #0x1b8
	ldr r3, [r5, #0x37c]
	moveq r4, #0x31
	ldr r2, [r5, #0x368]
	add r0, r0, #0x400
	add r3, r4, r3
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _0215FFF8 // =ovl01_215FFFC
	str r0, [r5, #0x374]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215FFEC: .word _mt_math_rand
_0215FFF0: .word 0x00196225
_0215FFF4: .word 0x3C6EF35F
_0215FFF8: .word ovl01_215FFFC
	arm_func_end ovl01_215FF00

	arm_func_start ovl01_215FFFC
ovl01_215FFFC: // 0x0215FFFC
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r2, [r4, #0x370]
	ldr r1, [r4, #0x37c]
	add r1, r2, r1, lsl #2
	ldr r5, [r1, #0x374]
	bl ovl01_215F890
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	ble _02160050
	sub r0, r0, #1
	str r0, [r4, #0x2c]
	add r0, r5, #0x300
	mov r1, #0x800
	strh r1, [r0, #0xc6]
	ldrsh r0, [r0, #0xc2]
	cmp r0, #0
	suble r1, r1, #0x1000
	add r0, r5, #0x300
	strh r1, [r0, #0xc2]
	b _0216005C
_02160050:
	add r0, r5, #0x300
	mov r1, #0x400
	strh r1, [r0, #0xc6]
_0216005C:
	add r0, r4, #0x600
	ldrh r0, [r0, #0xc4]
	tst r0, #0x8000
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl ovl01_215F944
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_215FFFC

	arm_func_start ovl01_2160084
ovl01_2160084: // 0x02160084
	mov r1, #0
	str r1, [r0, #8]
	bx lr
	arm_func_end ovl01_2160084

	arm_func_start ovl01_2160090
ovl01_2160090: // 0x02160090
	mov r1, #1
	str r1, [r0, #8]
	bx lr
	arm_func_end ovl01_2160090

	arm_func_start ovl01_216009C
ovl01_216009C: // 0x0216009C
	ldr r1, _021600A8 // =ovl01_2160354
	str r1, [r0]
	bx lr
	.align 2, 0
_021600A8: .word ovl01_2160354
	arm_func_end ovl01_216009C

	arm_func_start ovl01_21600AC
ovl01_21600AC: // 0x021600AC
	ldr r1, _021600B8 // =ovl01_21600BC
	str r1, [r0]
	bx lr
	.align 2, 0
_021600B8: .word ovl01_21600BC
	arm_func_end ovl01_21600AC

	arm_func_start ovl01_21600BC
ovl01_21600BC: // 0x021600BC
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r1
	mov r1, #0
	str r1, [r4, #4]
	mov r5, r0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r3, [r5, #0x37c]
	ldr r2, [r5, #0x368]
	add r0, r4, #0x14
	add r3, r3, #0x37
	bl BossHelpers__Animation__Func_2038BF0
	mov r0, #0
	str r0, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r1, [r5, #0x37c]
	ldr r2, [r5, #0x36c]
	add r0, r4, #0x14
	add r3, r1, #3
	mov r1, #4
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r5, #0x230]
	add r0, r5, #0x500
	bic r1, r1, #4
	str r1, [r5, #0x230]
	ldr r1, [r5, #0x270]
	bic r1, r1, #4
	str r1, [r5, #0x270]
	ldrh r0, [r0, #0x9c]
	cmp r0, #1
	beq _0216015C
	add r0, r5, #0x198
	mov r2, #0
	mov r3, r2
	add r0, r0, #0x400
	mov r1, #1
	bl BossHelpers__Palette__Func_2038BAC
_0216015C:
	ldr r0, _0216016C // =ovl01_2160170
	str r0, [r4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216016C: .word ovl01_2160170
	arm_func_end ovl01_21600BC

	arm_func_start ovl01_2160170
ovl01_2160170: // 0x02160170
	bx lr
	arm_func_end ovl01_2160170

	arm_func_start ovl01_2160174
ovl01_2160174: // 0x02160174
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r1
	mov r2, #1
	str r2, [r4, #4]
	mov r1, #0
	mov r5, r0
	stmia sp, {r1, r2}
	ldr r3, [r5, #0x37c]
	ldr r2, [r5, #0x368]
	add r0, r4, #0x14
	add r3, r3, #0x34
	bl BossHelpers__Animation__Func_2038BF0
	mov r0, #0
	str r0, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r2, [r5, #0x36c]
	ldr r3, [r5, #0x37c]
	add r0, r4, #0x14
	mov r1, #4
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r5, #0x230]
	add r0, r5, #0x500
	bic r1, r1, #4
	str r1, [r5, #0x230]
	ldr r1, [r5, #0x270]
	orr r1, r1, #4
	str r1, [r5, #0x270]
	ldrh r0, [r0, #0x9c]
	cmp r0, #1
	beq _0216020C
	mov r1, #1
	add r0, r5, #0x198
	mov r2, r1
	mov r3, r1
	add r0, r0, #0x400
	bl BossHelpers__Palette__Func_2038BAC
_0216020C:
	mov r1, #0
	mov r0, #0x9a
	str r1, [sp]
	sub r1, r0, #0x9b
	str r0, [sp, #4]
	ldr r0, [r5, #0x984]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add r1, r5, #0xfc
	ldr r0, [r5, #0x984]
	add r1, r1, #0x400
	bl ProcessSpatialVoiceClip
	mov r0, #0
	str r0, [r4, #0x10]
	ldr r2, _02160264 // =ovl01_2160268
	mov r0, r5
	mov r1, r4
	str r2, [r4]
	blx r2
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02160264: .word ovl01_2160268
	arm_func_end ovl01_2160174

	arm_func_start ovl01_2160268
ovl01_2160268: // 0x02160268
	ldr r0, [r1, #8]
	cmp r0, #0
	bxne lr
	ldrh r0, [r1, #0xc]
	cmp r0, #0
	bxeq lr
	ldr r0, [r1, #0x10]
	add r2, r0, #1
	str r2, [r1, #0x10]
	ldrh r0, [r1, #0xc]
	cmp r2, r0
	ldrhi r0, _021602A0 // =ovl01_21602A4
	strhi r0, [r1]
	bx lr
	.align 2, 0
_021602A0: .word ovl01_21602A4
	arm_func_end ovl01_2160268

	arm_func_start ovl01_21602A4
ovl01_21602A4: // 0x021602A4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r1
	mov r1, #2
	str r1, [r4, #4]
	mov r1, #0
	str r1, [sp]
	mov r5, r0
	str r1, [sp, #4]
	ldr r3, [r5, #0x37c]
	ldr r2, [r5, #0x368]
	add r0, r4, #0x14
	add r3, r3, #0x3d
	bl BossHelpers__Animation__Func_2038BF0
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	ldr r1, [r5, #0x37c]
	ldr r2, [r5, #0x36c]
	add r0, r4, #0x14
	add r3, r1, #9
	mov r1, #4
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r5, #0x230]
	add r0, r5, #0x500
	orr r1, r1, #4
	str r1, [r5, #0x230]
	ldr r1, [r5, #0x270]
	bic r1, r1, #4
	str r1, [r5, #0x270]
	ldrh r0, [r0, #0x9c]
	cmp r0, #2
	beq _02160340
	add r0, r5, #0x198
	mov r1, #1
	mov r3, r1
	add r0, r0, #0x400
	mov r2, #2
	bl BossHelpers__Palette__Func_2038BAC
_02160340:
	ldr r0, _02160350 // =ovl01_2160354
	str r0, [r4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02160350: .word ovl01_2160354
	arm_func_end ovl01_21602A4

	arm_func_start ovl01_2160354
ovl01_2160354: // 0x02160354
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r1
	mov r1, #3
	str r1, [r4, #4]
	mov r1, #0
	mov r5, r0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r3, [r5, #0x37c]
	ldr r2, [r5, #0x368]
	add r0, r4, #0x14
	add r3, r3, #0x37
	bl BossHelpers__Animation__Func_2038BF0
	mov r0, #0
	str r0, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r1, [r5, #0x37c]
	ldr r2, [r5, #0x36c]
	add r0, r4, #0x14
	add r3, r1, #3
	mov r1, #4
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r5, #0x230]
	add r0, r5, #0x500
	orr r1, r1, #4
	str r1, [r5, #0x230]
	ldr r1, [r5, #0x270]
	bic r1, r1, #4
	str r1, [r5, #0x270]
	ldrh r0, [r0, #0x9c]
	cmp r0, #2
	beq _021603F8
	add r0, r5, #0x198
	mov r1, #1
	mov r3, r1
	add r0, r0, #0x400
	mov r2, #2
	bl BossHelpers__Palette__Func_2038BAC
_021603F8:
	mov r0, #0
	str r0, [r4, #0x10]
	ldr r2, _0216041C // =ovl01_2160420
	mov r0, r5
	mov r1, r4
	str r2, [r4]
	blx r2
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216041C: .word ovl01_2160420
	arm_func_end ovl01_2160354

	arm_func_start ovl01_2160420
ovl01_2160420: // 0x02160420
	ldr r0, [r1, #8]
	cmp r0, #0
	bxne lr
	ldrh r0, [r1, #0xe]
	cmp r0, #0
	bxeq lr
	ldr r0, [r1, #0x10]
	add r2, r0, #1
	str r2, [r1, #0x10]
	ldrh r0, [r1, #0xe]
	cmp r2, r0
	ldrhi r0, _02160458 // =ovl01_216045C
	strhi r0, [r1]
	bx lr
	.align 2, 0
_02160458: .word ovl01_216045C
	arm_func_end ovl01_2160420

	arm_func_start ovl01_216045C
ovl01_216045C: // 0x0216045C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r1
	mov r1, #4
	str r1, [r4, #4]
	mov r1, #0
	str r1, [sp]
	mov r5, r0
	str r1, [sp, #4]
	ldr r3, [r5, #0x37c]
	ldr r2, [r5, #0x368]
	add r0, r4, #0x14
	add r3, r3, #0x3a
	bl BossHelpers__Animation__Func_2038BF0
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	ldr r1, [r5, #0x37c]
	ldr r2, [r5, #0x36c]
	add r0, r4, #0x14
	add r3, r1, #6
	mov r1, #4
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r5, #0x230]
	add r0, r5, #0x500
	orr r1, r1, #4
	str r1, [r5, #0x230]
	ldr r1, [r5, #0x270]
	bic r1, r1, #4
	str r1, [r5, #0x270]
	ldrh r0, [r0, #0x9c]
	cmp r0, #2
	beq _021604F8
	add r0, r5, #0x198
	mov r1, #1
	mov r3, r1
	add r0, r0, #0x400
	mov r2, #2
	bl BossHelpers__Palette__Func_2038BAC
_021604F8:
	ldr r0, _02160508 // =ovl01_216050C
	str r0, [r4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02160508: .word ovl01_216050C
	arm_func_end ovl01_216045C

	arm_func_start ovl01_216050C
ovl01_216050C: // 0x0216050C
	add r0, r1, #0x100
	ldrh r0, [r0, #0x20]
	tst r0, #0x8000
	ldrne r0, _02160524 // =ovl01_2160174
	strne r0, [r1]
	bx lr
	.align 2, 0
_02160524: .word ovl01_2160174
	arm_func_end ovl01_216050C

	arm_func_start ovl01_2160528
ovl01_2160528: // 0x02160528
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x14
	mov r6, r1
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	mov r4, r0
	str r1, [sp, #0x10]
	ldr r3, [r4, #0x370]
	ldr r0, _021605AC // =0x0000011A
	ldr ip, [r3, #0x45c]
	mov r5, r2
	mov r3, r1
	rsb r2, ip, #0
	bl GameObject__SpawnObject
	str r4, [r0, #0x11c]
	cmp r6, #0
	rsblt r6, r6, #0
	str r4, [r0, #0x370]
	str r6, [r0, #0x384]
	cmp r5, #0
	beq _021605A0
	ldr r1, [r0, #0x384]
	rsb r1, r1, #0
	str r1, [r0, #0x384]
	ldr r1, [r0, #0x20]
	orr r1, r1, #1
	str r1, [r0, #0x20]
_021605A0:
	str r0, [r4, #0x390]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_021605AC: .word 0x0000011A
	arm_func_end ovl01_2160528

	arm_func_start ovl01_21605B0
ovl01_21605B0: // 0x021605B0
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x374]
	blx r1
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_21605B0

	arm_func_start ovl01_21605C0
ovl01_21605C0: // 0x021605C0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	add r0, r0, #0x3d0
	bl AnimatorMDL__Release
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_21605C0

	arm_func_start ovl01_21605E0
ovl01_21605E0: // 0x021605E0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x20]
	tst r1, #0x20
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, pc}
	ldr r1, [r4, #0x380]
	cmp r1, #0
	bne _02160628
	ldr ip, _0216065C // =0x001187BC
	ldr r3, _02160660 // =0x00722543
	add r1, r4, #0x3d0
	mov r2, #0x40000
	str ip, [sp]
	bl BossHelpers__Arena__Func_2038E00
	b _02160644
_02160628:
	ldr r1, [r4, #0x48]
	ldr r2, [r4, #0x4c]
	ldr r0, [r4, #0x44]
	rsb r1, r1, #0
	str r0, [r4, #0x418]
	str r1, [r4, #0x41c]
	str r2, [r4, #0x420]
_02160644:
	add r0, r4, #0x3d0
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #0x3d0
	bl AnimatorMDL__Draw
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0216065C: .word 0x001187BC
_02160660: .word 0x00722543
	arm_func_end ovl01_21605E0

	arm_func_start ovl01_2160664
ovl01_2160664: // 0x02160664
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	bl GetCurrentTaskWork_
	mov ip, r0
	ldr r0, [ip, #0x18]
	tst r0, #0xc
	addne sp, sp, #0xc
	ldmneia sp!, {pc}
	tst r0, #2
	addne sp, sp, #0xc
	ldmneia sp!, {pc}
	ldr r0, [ip, #0x230]
	tst r0, #4
	addeq sp, sp, #0xc
	ldmeqia sp!, {pc}
	mov r0, #0x40000
	ldr r1, _021606D4 // =0x00722543
	str r0, [sp]
	ldr r0, _021606D8 // =0x001187BC
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r2, [ip, #0x44]
	ldr r3, [ip, #0x48]
	add r0, ip, #0x218
	add r1, ip, #0x390
	bl BossHelpers__Collision__Func_2039120
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_021606D4: .word 0x00722543
_021606D8: .word 0x001187BC
	arm_func_end ovl01_2160664

	arm_func_start ovl01_21606DC
ovl01_21606DC: // 0x021606DC
	stmdb sp!, {r4, lr}
	ldr r4, [r0, #0x1c]
	ldr r0, [r1, #0x1c]
	ldrh r1, [r4]
	cmp r1, #1
	ldmneia sp!, {r4, pc}
	ldr r1, [r0, #0x230]
	orr r1, r1, #0x800
	str r1, [r0, #0x230]
	ldr r1, [r0, #0x3a8]
	orr r1, r1, #0x800
	str r1, [r0, #0x3a8]
	bl ovl01_216073C
	mov r0, r4
	bl Player__Action_DestroyAttackRecoil
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_21606DC

	arm_func_start ovl01_216071C
ovl01_216071C: // 0x0216071C
	stmdb sp!, {r3, lr}
	mov r2, #0
	ldr r1, _02160738 // =ovl01_216075C
	str r2, [r0, #0x378]
	str r1, [r0, #0x374]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_02160738: .word ovl01_216075C
	arm_func_end ovl01_216071C

	arm_func_start ovl01_216073C
ovl01_216073C: // 0x0216073C
	stmdb sp!, {r3, lr}
	mov r2, #2
	ldr r1, _02160758 // =ovl01_2160938
	str r2, [r0, #0x378]
	str r1, [r0, #0x374]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_02160758: .word ovl01_2160938
	arm_func_end ovl01_216073C

	arm_func_start ovl01_216075C
ovl01_216075C: // 0x0216075C
	mov r2, #1
	ldr r1, _02160770 // =ovl01_2160774
	str r2, [r0, #0x380]
	str r1, [r0, #0x374]
	bx lr
	.align 2, 0
_02160770: .word ovl01_2160774
	arm_func_end ovl01_216075C

	arm_func_start ovl01_2160774
ovl01_2160774: // 0x02160774
	ldr r1, [r0, #0x1c]
	tst r1, #1
	ldrne r1, _02160788 // =ovl01_216078C
	strne r1, [r0, #0x374]
	bx lr
	.align 2, 0
_02160788: .word ovl01_216078C
	arm_func_end ovl01_2160774

	arm_func_start ovl01_216078C
ovl01_216078C: // 0x0216078C
	stmdb sp!, {r3, lr}
	mov r2, #0x3c
	ldr r1, _021607A8 // =ovl01_21607AC
	str r2, [r0, #0x2c]
	str r1, [r0, #0x374]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_021607A8: .word ovl01_21607AC
	arm_func_end ovl01_216078C

	arm_func_start ovl01_21607AC
ovl01_21607AC: // 0x021607AC
	ldr r1, [r0, #0x2c]
	subs r1, r1, #1
	str r1, [r0, #0x2c]
	ldreq r1, _021607C4 // =ovl01_21607C8
	streq r1, [r0, #0x374]
	bx lr
	.align 2, 0
_021607C4: .word ovl01_21607C8
	arm_func_end ovl01_21607AC

	arm_func_start ovl01_21607C8
ovl01_21607C8: // 0x021607C8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	mov r1, #0
	mov r3, #0x4000
	mov r0, r3, asr #4
	mov r5, r0, lsl #1
	str r1, [r4, #0x38c]
	ldr ip, _02160838 // =_mt_math_rand
	ldr r0, _0216083C // =0x00196225
	ldr r6, [ip]
	ldr r1, _02160840 // =0x3C6EF35F
	add r2, r5, #1
	mla r7, r6, r0, r1
	str r7, [ip]
	add ip, r4, #0x300
	ldr lr, _02160844 // =FX_SinCosTable_
	mov r1, r5, lsl #1
	mov r0, r2, lsl #1
	ldrsh r2, [lr, r0]
	ldrsh r1, [lr, r1]
	add r0, r4, #0x3f4
	strh r3, [ip, #0x88]
	blx MTX_RotY33_
	ldr r1, _02160848 // =ovl01_216084C
	mov r0, r4
	str r1, [r4, #0x374]
	blx r1
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02160838: .word _mt_math_rand
_0216083C: .word 0x00196225
_02160840: .word 0x3C6EF35F
_02160844: .word FX_SinCosTable_
_02160848: .word ovl01_216084C
	arm_func_end ovl01_21607C8

	arm_func_start ovl01_216084C
ovl01_216084C: // 0x0216084C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x38c]
	ldr r0, _021608E0 // =0x001187BC
	add r1, r1, #0x3000
	str r1, [r4, #0x38c]
	cmp r1, r0
	strge r0, [r4, #0x38c]
	add r0, r4, #0x300
	mov r5, #0
	ldrh r0, [r0, #0x88]
	ldr r1, [r4, #0x38c]
	movge r5, #1
	add r2, r4, #0x44
	add r3, r4, #0x4c
	bl BossHelpers__Arena__Func_2038D24
	cmp r5, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, #0
	str r0, [r4, #0x380]
	ldr r0, [r4, #0x44]
	ldr r2, _021608E4 // =0x00722543
	str r0, [sp]
	ldr ip, [r4, #0x4c]
	ldr r3, _021608E0 // =0x001187BC
	add r0, r4, #0x44
	mov r1, #0x40000
	str ip, [sp, #4]
	bl BossHelpers__Arena__Func_2038D88
	mov r1, #0
	ldr r0, _021608E8 // =ovl01_21608EC
	str r1, [r4, #0x4c]
	str r0, [r4, #0x374]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021608E0: .word 0x001187BC
_021608E4: .word 0x00722543
_021608E8: .word ovl01_21608EC
	arm_func_end ovl01_216084C

	arm_func_start ovl01_21608EC
ovl01_21608EC: // 0x021608EC
	ldr r1, [r0, #0x230]
	mov r2, #0x78
	orr r1, r1, #4
	str r1, [r0, #0x230]
	ldr r1, _0216090C // =ovl01_2160910
	str r2, [r0, #0x37c]
	str r1, [r0, #0x374]
	bx lr
	.align 2, 0
_0216090C: .word ovl01_2160910
	arm_func_end ovl01_21608EC

	arm_func_start ovl01_2160910
ovl01_2160910: // 0x02160910
	ldr r1, [r0, #0x37c]
	cmp r1, #0
	bxeq lr
	subs r1, r1, #1
	str r1, [r0, #0x37c]
	ldreq r1, [r0, #0x384]
	streq r1, [r0, #0x98]
	movne r1, #0
	strne r1, [r0, #0x98]
	bx lr
	arm_func_end ovl01_2160910

	arm_func_start ovl01_2160938
ovl01_2160938: // 0x02160938
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x11c]
	cmp r1, #0
	movne r0, #0
	strne r0, [r1, #0x390]
	ldr r1, [r4, #0x18]
	mov r0, #0
	orr r1, r1, #8
	str r1, [r4, #0x18]
	ldr r2, [r4, #0x41c]
	ldr r1, [r4, #0x418]
	ldr r3, [r4, #0x420]
	add r2, r2, #0x20000
	bl BossFX__CreateBomb
	mov ip, #0x99
	sub r1, ip, #0x9a
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	ldr r0, _021609A4 // =ovl01_21609A8
	str r0, [r4, #0x374]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021609A4: .word ovl01_21609A8
	arm_func_end ovl01_2160938

	arm_func_start ovl01_21609A8
ovl01_21609A8: // 0x021609A8
	bx lr
	arm_func_end ovl01_21609A8

	arm_func_start ovl01_21609AC
ovl01_21609AC: // 0x021609AC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x448]
	ldr r0, [r0]
	cmp r0, #0x1b000
	blt _02160A04
	cmp r0, #0x1d000
	bge _02160A04
	ldr r0, _02160A20 // =gPlayer
	ldr r0, [r0]
	bl BossHelpers__Player__IsDead
	cmp r0, #0
	beq _02160A04
	ldr r0, _02160A20 // =gPlayer
	ldr r0, [r0]
	ldr r1, [r0, #0x1c]
	tst r1, #0x10
	addeq r1, r0, #0x600
	ldreqsh r1, [r1, #0x82]
	cmpeq r1, #0
	bne _02160A04
	bl Player__Hurt
_02160A04:
	add r0, r4, #0x400
	ldrh r0, [r0, #0x70]
	tst r0, #0x8000
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #8
	strne r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160A20: .word gPlayer
	arm_func_end ovl01_21609AC

	arm_func_start ovl01_2160A24
ovl01_2160A24: // 0x02160A24
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	add r0, r0, #0x364
	bl AnimatorMDL__Release
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2160A24

	arm_func_start ovl01_2160A44
ovl01_2160A44: // 0x02160A44
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x364
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #0x364
	bl AnimatorMDL__Draw
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2160A44

	.rodata

_02179C64: // 0x02179C64
	.byte 0, 0x40, 0x99, 0x29, 0, 0x20
	
_02179C6A: // 0x02179C6A
	.hword 0x3A0, 0x280, 0x140

_02179C70: // 0x02179C70
    .word 0x20003000, 0x1800
	
_02179C78: // 0x02179C78
    .word 0x1000, 0x1000
	
_02179C80: // 0x02179C80
    .word aBallAHit           // "ball_a_hit"
	.word aBallBHit           // "ball_b_hit"
	.word aBallCHit           // "ball_c_hit"

_02179C8C: // 0x02179C8C
    .word 0x1A660, 0x2E328, 0x41FF0
	
_02179C98: // 0x02179C98
    .word 0, 0x1000, 0

_02179CA4: // 0x02179CA4
    .word 0x4000, 0x6000, 0x8000
	
_02179CB0: // 0x02179CB0
    .word 0
	.word 0x1000, 0
	.word 0x3000, 0x4000, 0x5000

_02179CC8: // 0x02179CC8
    .word 0x1A660, 0x2E328, 0x41FF0
	
_02179CD4: // 0x02179CD4
    .word 0, 1, 2, 2

_02179CE4: // 0x02179CE4
    .hword 0xFFF0
	
_02179CE6: // 0x02179CE6
    .hword 0xFFF0

_02179CE8: // 0x02178CE8
	.word 0x100010, 0xFFE8FFE8, 0x180018, 0xFFE0FFE0, 0x200020

_02179CFC: // 0x02179CFC
    .word 0x300020, 0x200080, 0x800030, 0x300020, 0x200080, 0x800030
	
_02179D14: // 0x02179D14
    .hword 0x60, 0x40, 0x20, 0x80, 0x60, 0x40, 0xA0, 0x80, 0x60

_02179D26: // 0x02179D26
	.hword 0xC0, 0xA0, 0x80

_02179D2C: // 0x02179D2C
    .word 0, 0
	.word 0xFF0168, 0xFF012C, 0x1FF012C, 0xFF012C, 0xFF00F0
	.word 0xFF00B4

_02179D4C: // 0x02179D4C
    .word 0, 0, 0
	.word 0x7F012C, 0, 0
	.word 0xFF00F0, 0xFF00B4

_02179D6C: // 0x02179D6C
    .word 0, 0, 0
	.word 0xB4003C, 0, 0
	.word 0xB4003C, 0xB40078, 0

_02179D90: // 0x02179D90
    .word 0xB4003C, 0xB40078, 0xB400B4

	.data

aTopPl: // 0x0217A720
    .asciz "top_pl"
    .align 4

aEyePl: // 0x0217A728
    .asciz "eye_pl"
    .align 4

aFacePl: // 0x0217A730
    .asciz "face_pl"
    .align 4

aSideBPl: // 0x0217A738
    .asciz "side_b_pl"
    .align 4

aBallAHit: // 0x0217A744
    .asciz "ball_a_hit"
    .align 4

aBallBHit: // 0x0217A750
    .asciz "ball_b_hit"
    .align 4

aBallCHit: // 0x0217A75C
    .asciz "ball_c_hit"
    .align 4

aHTamaAPl: // 0x0217A768
    .asciz "h_tama_a_pl"
    .align 4

aHTamaBPl: // 0x0217A774
    .asciz "h_tama_b_pl"
    .align 4

aHTamaCPl: // 0x0217A780
    .asciz "h_tama_c_pl"
    .align 4

_0217A78C: // 0x0217A78C
    .word aHTamaAPl           // "h_tama_a_pl"
	.word aHTamaBPl           // "h_tama_b_pl"
	.word aHTamaCPl           // "h_tama_c_pl"

_0217A798: // 0x0217A798
    .word aEyePl              // "eye_pl"
	.word aFacePl             // "face_pl"
	.word aSetuzokuMekaPl     // "setuzoku_meka_pl"
	.word aSideBPl            // "side_b_pl"
	.word aSideMeka1Pl        // "side_meka1_pl"
	.word aSideMeka2Pl        // "side_meka2_pl"
	.word aSideMeka3Pl        // "side_meka3_pl"
	.word aTopPl              // "top_pl"

aSideMeka2Pl: // 0x0217A7B8
    .asciz "side_meka2_pl"
    .align 4

aSideMeka3Pl: // 0x0217A7C8
    .asciz "side_meka3_pl"
    .align 4

aSideMeka1Pl: // 0x0217A7D8
    .asciz "side_meka1_pl"
    .align 4

aSetuzokuMekaPl: // 0x0217A7E8
    .asciz "setuzoku_meka_pl"
    .align 4

_0217A7FC: // 0x0217A7FC
    .word 0x637865

aBody: // 0x0217A800
    .asciz "body"
    .align 4

aBodyA: // 0x0217A808
    .asciz "body_a"
    .align 4

aBodyB: // 0x0217A810
    .asciz "body_b"
    .align 4

aWeak_0: // 0x0217A818
    .asciz "weak"
    .align 4

aArmBall: // 0x0217A820
    .asciz "arm_ball"
    .align 4
