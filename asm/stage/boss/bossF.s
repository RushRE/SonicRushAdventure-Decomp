	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

.public BossFStage__Singleton
BossFStage__Singleton: // 0x02179BA0
	.space 0x04 // Task*

	.text

	arm_func_start BossFStage__Create
BossFStage__Create: // 0x02167B90
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	ldr r3, _02167D7C // =0x000014F6
	mov r7, r0
	str r3, [sp]
	mov r0, #2
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _02167D80 // =0x00000598
	ldr r0, _02167D84 // =StageTask_Main
	ldr r1, _02167D88 // =ovl02_2168F34
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, _02167D8C // =BossFStage__Singleton
	str r0, [r1]
	bl GetTaskWork_
	mov r2, r4
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r1, r7
	mov r2, r6
	mov r0, r4
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r0, _02167D90 // =ovl02_216911C
	mov r3, #0x400
	str r0, [r4, #0xf4]
	ldr r1, [r4, #0x18]
	add r0, r4, #0x300
	orr r1, r1, #0x12
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x20]
	mov r2, #0
	orr r1, r1, #0x2180
	str r1, [r4, #0x20]
	ldr r6, [r4, #0x1c]
	sub r1, r2, #0xb4000
	orr r6, r6, #0x2100
	str r6, [r4, #0x1c]
	strh r3, [r0, #0x7c]
	str r2, [r4, #0x504]
	str r1, [r4, #0x508]
	str r1, [r4, #0x50c]
	mov r0, #0xcc
	str r0, [r4, #0x510]
	sub r0, r2, #0xc8000
	str r0, [r4, #0x514]
	str r2, [r4, #0x518]
	mov r0, #0x4000
	str r0, [r4, #0x594]
	bl ovl02_2169F80
	add r1, r4, #0x500
	strh r0, [r1, #0x36]
	mov r0, #0
	bl ovl02_216A014
	mov r0, #0
	bl ovl02_216A034
	add r0, r4, #0x364
	bl ovl02_2169E20
	add r0, r4, #0x550
	bl BossHelpers__InitLights
	ldr r1, _02167D94 // =ovl02_216A120
	mov r0, r4
	str r1, [r4, #0x378]
	bl ovl02_216ABCC
	str r0, [r4, #0x368]
	mov r6, #0
_02167CAC:
	mov r0, r4
	mov r1, r6
	bl ovl02_216AD0C
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #5
	blo _02167CAC
	bl BossHelpers__Model__InitSystem
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	ldr r0, _02167D98 // =0x00000139
	mov r1, r4
	mov r2, r5
	str r3, [sp, #0x10]
	bl GameObject__SpawnObject
	str r0, [r4, #0x36c]
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	mov r1, r4
	mov r3, r2
	str r2, [sp, #0x10]
	mov r0, #0x13c
	bl GameObject__SpawnObject
	str r0, [r4, #0x370]
	mov r0, #1
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	mov r0, #0x13c
	mov r1, r4
	mov r3, r2
	bl GameObject__SpawnObject
	str r0, [r4, #0x374]
	bl ovl02_2174218
	bl ovl02_2168F68
	mov r0, #0x1f4000
	bl SetSpatialAudioDropoffRate
	mov r0, #0x12c000
	bl SetSpatialAudioDistanceThreshold
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02167D7C: .word 0x000014F6
_02167D80: .word 0x00000598
_02167D84: .word StageTask_Main
_02167D88: .word ovl02_2168F34
_02167D8C: .word BossFStage__Singleton
_02167D90: .word ovl02_216911C
_02167D94: .word ovl02_216A120
_02167D98: .word 0x00000139
	arm_func_end BossFStage__Create

	arm_func_start BossF__Create
BossF__Create: // 0x02167D9C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x7c
	ldr r3, _02168200 // =0x000014FF
	mov r9, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _02168204 // =StageTask_Main
	ldr r1, _02168208 // =ovl02_216B020
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	bl GetTaskWork_
	mov r7, r0
	mov r0, r4
	bl GetTaskWork_
	mov r1, #0
	mov r2, #0x364
	mov r4, r0
	bl MI_CpuFill8
	mov r0, r7
	mov r1, #0x36c
	bl StageTask__AllocateWorker
	mov r8, r0
	mov r1, #0
	ldr r0, _0216820C // =bossAssetFiles
	ldr r2, _02168210 // =aBossfBodyNsbmd_0
	stmia sp, {r0, r1}
	mov r0, r7
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r1, #0
	ldr r0, [r7, #0x12c]
	mov r2, #4
	strb r2, [r0, #0xa]
	ldr r2, [r7, #0x12c]
	ldr r0, _02168214 // =gameArchiveStage
	strb r1, [r2, #0xb]
	ldr r2, [r0, #0]
	mov r0, r7
	str r2, [sp]
	ldr r2, _02168218 // =aBossfBodyNsbca_0
	mov r3, r1
	bl ObjAction3dNNMotionLoad
	mov r0, r7
	mov r1, #1
	bl StageTask__SetAnimation
	ldr r0, [r7, #0x20]
	mov r3, r5
	orr r0, r0, #4
	str r0, [r7, #0x20]
	ldr r0, [r7, #0x12c]
	mov r5, #0x200
	add r0, r0, #0x100
	strh r5, [r0, #0x30]
	ldr r2, _0216821C // =0x000034CC
	ldr r5, [r7, #0x12c]
	mov r1, r9
	str r2, [r5, #0x18]
	str r2, [r5, #0x1c]
	str r2, [r5, #0x20]
	mov r0, r4
	mov r2, r6
	bl GameObject__InitFromObject
	ldr r0, _02168220 // =ovl02_216B218
	str r0, [r7, #0xf8]
	ldr r1, [r7, #0x18]
	mov r0, r7
	orr r1, r1, #0x10
	str r1, [r7, #0x18]
	ldr r2, [r7, #0x20]
	mov r1, r6
	orr r2, r2, #0x180
	str r2, [r7, #0x20]
	ldr r2, [r7, #0x1c]
	add r3, r8, #0x100
	orr r2, r2, #0x2100
	str r2, [r7, #0x1c]
	mov r5, #2
	mov r2, #0
	strh r5, [r3, #0x8a]
	bl StageTask__SetParent
	mov r1, #0x178000
	ldr r0, _02168224 // =0x00794000
	str r1, [r7, #0x44]
	str r0, [r7, #0x48]
	sub r0, r1, #0x2b8000
	str r0, [r7, #0x4c]
	mov r0, #3
	str r0, [sp]
	ldr r0, [r7, #0x12c]
	ldr r1, _02168228 // =BossHelpers__Model__RenderCallback
	add r0, r0, #0x90
	mov r2, #0
	mov r3, #6
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	ldr r0, [r7, #0x12c]
	ldr r1, _0216822C // =aWeak_0
	ldr r0, [r0, #0x94]
	mov r2, #0x1e
	bl BossHelpers__Model__Init
	mov r3, #0
	str r3, [sp]
	ldr r0, [r7, #0x12c]
	ldr r1, _02168230 // =aHead_2
	ldr r0, [r0, #0x94]
	mov r2, #0x1d
	bl BossHelpers__Model__Init
	mov r3, #0
	str r3, [sp]
	ldr r0, [r7, #0x12c]
	ldr r1, _02168234 // =aArmL_0
	ldr r0, [r0, #0x94]
	mov r2, #0x1c
	bl BossHelpers__Model__Init
	mov r3, #0
	str r3, [sp]
	ldr r0, [r7, #0x12c]
	ldr r1, _02168238 // =aArmR_0
	ldr r0, [r0, #0x94]
	mov r2, #0x1b
	bl BossHelpers__Model__Init
	mov r3, #0
	str r3, [sp]
	ldr r0, [r7, #0x12c]
	ldr r1, _0216823C // =aCannonL_0
	ldr r0, [r0, #0x94]
	mov r2, #0x1a
	bl BossHelpers__Model__Init
	mov r3, #0
	str r3, [sp]
	ldr r0, [r7, #0x12c]
	ldr r1, _02168240 // =aCannonR_0
	ldr r0, [r0, #0x94]
	mov r2, #0x19
	bl BossHelpers__Model__Init
	str r7, [sp]
	ldr r0, [r7, #0x12c]
	ldr r1, _02168244 // =aBalkanL_0
	ldr r0, [r0, #0x94]
	ldr r3, _02168248 // =ovl02_216B060
	mov r2, #0x18
	bl BossHelpers__Model__Init
	str r7, [sp]
	ldr r0, [r7, #0x12c]
	ldr r1, _0216824C // =aBalkanR_0
	ldr r0, [r0, #0x94]
	ldr r3, _02168250 // =ovl02_216B0C4
	mov r2, #0x17
	bl BossHelpers__Model__Init
	mov r3, #0
	str r3, [sp]
	ldr r0, [r7, #0x12c]
	ldr r1, _02168254 // =aBody_0
	ldr r0, [r0, #0x94]
	mov r2, #0x14
	bl BossHelpers__Model__Init
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	ldr r0, _02168258 // =0x0000013A
	mov r1, r7
	mov r3, r2
	bl GameObject__SpawnObject
	str r0, [r8]
	mov r0, #1
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	ldr r0, _02168258 // =0x0000013A
	mov r1, r7
	mov r3, r2
	bl GameObject__SpawnObject
	str r0, [r8, #4]
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	ldr r0, _0216825C // =0x0000013B
	mov r1, r7
	mov r3, r2
	bl GameObject__SpawnObject
	str r0, [r8, #8]
	mov r0, #1
	str r0, [sp]
	rsb r0, r0, #0x13c
	mov r2, #0
	str r2, [sp, #4]
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	mov r1, r7
	mov r3, r2
	bl GameObject__SpawnObject
	mov r1, #0
	add r4, r4, #0x218
	str r0, [r8, #0xc]
	ldr r3, _02168260 // =ovl02_216B13C
	mov r0, r4
	mov r2, r1
	str r3, [r7, #0xfc]
	bl ObjRect__SetAttackStat
	mov r0, r4
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r3, #0xf
	mov r0, #0xd
	stmia sp, {r0, r3}
	mov r0, r4
	str r3, [sp, #8]
	sub r1, r3, #0x1c
	sub r2, r3, #0x1e
	sub r3, r3, #0x23
	bl ObjRect__SetBox3D
	ldr r0, _02168264 // =0x00000102
	str r7, [r4, #0x1c]
	strh r0, [r4, #0x34]
	ldr r2, [r4, #0x18]
	ldr r1, _02168268 // =ovl02_216B334
	orr r2, r2, #0x1000
	str r2, [r4, #0x18]
	str r1, [r4, #0x24]
	ldr r2, _02168214 // =gameArchiveStage
	ldr r1, _0216826C // =aExc_3
	ldr r2, [r2, #0]
	add r0, sp, #0x14
	bl NNS_FndMountArchive
	ldr r5, _02168270 // =_02179824
	ldr r11, _0216820C // =bossAssetFiles
	mov r9, #0
	add r10, r8, #0x2c
	mov r4, #5
_0216817C:
	add r0, sp, #0x14
	add r1, r9, #0xc
	bl NNS_FndGetArchiveFileByIndex
	mov r6, r0
	ldr r0, [r11, #0]
	bl NNS_G3dGetTex
	ldr r1, [r5, r9, lsl #2]
	bl Asset3DSetup__PaletteFromName
	str r4, [sp]
	mov r2, #0
	str r0, [sp, #4]
	mov r1, r6
	mov r0, r10
	mov r3, r2
	bl InitPaletteAnimator
	add r9, r9, #1
	add r10, r10, #0x20
	cmp r9, #8
	blt _0216817C
	mov r2, #0
	mov r3, r2
	add r0, r8, #0x2c
	mov r1, #8
	bl BossHelpers__SetPaletteAnimations
	add r0, sp, #0x14
	bl NNS_FndUnmountArchive
	mov r0, r7
	bl StageTask__InitSeqPlayer
	mov r0, r7
	bl ovl02_216B664
	mov r0, r7
	add sp, sp, #0x7c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02168200: .word 0x000014FF
_02168204: .word StageTask_Main
_02168208: .word ovl02_216B020
_0216820C: .word bossAssetFiles
_02168210: .word aBossfBodyNsbmd_0
_02168214: .word gameArchiveStage
_02168218: .word aBossfBodyNsbca_0
_0216821C: .word 0x000034CC
_02168220: .word ovl02_216B218
_02168224: .word 0x00794000
_02168228: .word BossHelpers__Model__RenderCallback
_0216822C: .word aWeak_0
_02168230: .word aHead_2
_02168234: .word aArmL_0
_02168238: .word aArmR_0
_0216823C: .word aCannonL_0
_02168240: .word aCannonR_0
_02168244: .word aBalkanL_0
_02168248: .word ovl02_216B060
_0216824C: .word aBalkanR_0
_02168250: .word ovl02_216B0C4
_02168254: .word aBody_0
_02168258: .word 0x0000013A
_0216825C: .word 0x0000013B
_02168260: .word ovl02_216B13C
_02168264: .word 0x00000102
_02168268: .word ovl02_216B334
_0216826C: .word aExc_3
_02168270: .word _02179824
	arm_func_end BossF__Create

	arm_func_start BossFArm__Create
BossFArm__Create: // 0x02168274
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x74
	mov r3, #0x1500
	mov r8, r0
	mov r5, r1
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _02168630 // =StageTask_Main
	ldr r1, _02168634 // =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	bl GetTaskWork_
	mov r6, r0
	mov r0, r4
	bl GetTaskWork_
	mov r1, #0
	mov r2, #0x364
	mov r4, r0
	bl MI_CpuFill8
	mov r0, r6
	mov r1, #0x9c
	bl StageTask__AllocateWorker
	mov r7, r0
	ldrsb r0, [r8, #6]
	mov r1, #0
	cmp r0, #0
	bne _02168338
	ldr r0, _02168638 // =bossAssetFiles+0x00000008
	ldr r2, _0216863C // =aBossfArmLNsbmd_0
	str r0, [sp]
	mov r0, r6
	mov r3, r1
	str r1, [sp, #4]
	bl ObjAction3dNNModelLoad
	ldr r0, _02168640 // =gameArchiveStage
	mov r1, #0
	ldr r9, [r0, #0]
	ldr r2, _02168644 // =aBossfArmLNsbca_0
	mov r0, r6
	mov r3, r1
	str r9, [sp]
	bl ObjAction3dNNMotionLoad
	mov r0, #0x16
	b _02168378
_02168338:
	ldr r0, _02168648 // =bossAssetFiles+0x00000010
	ldr r2, _0216864C // =aBossfArmRNsbmd_0
	str r0, [sp]
	mov r0, r6
	mov r3, r1
	str r1, [sp, #4]
	bl ObjAction3dNNModelLoad
	ldr r0, _02168640 // =gameArchiveStage
	mov r1, #0
	ldr r9, [r0, #0]
	ldr r2, _02168650 // =aBossfArmRNsbca_0
	mov r0, r6
	mov r3, r1
	str r9, [sp]
	bl ObjAction3dNNMotionLoad
	mov r0, #0x15
_02168378:
	strh r0, [r7, #4]
	ldr r0, [r6, #0x12c]
	mov r1, #4
	strb r1, [r0, #0xa]
	mov r1, #0
	ldr r0, [r6, #0x12c]
	mov r3, r1
	strb r1, [r0, #0xb]
	str r1, [sp]
	ldr r0, [r6, #0x12c]
	ldr r2, [r0, #0x148]
	bl AnimatorMDL__SetAnimation
	ldr r1, [r6, #0x20]
	mov r0, r6
	orr r2, r1, #4
	str r2, [r6, #0x20]
	mov r1, r5
	mov r2, #0
	bl StageTask__SetParent
	ldr r3, [r6, #0x12c]
	ldr r1, _02168654 // =0x000034CC
	mov r2, #0
	str r1, [r3, #0x18]
	str r1, [r3, #0x1c]
	str r1, [r3, #0x20]
	mov r0, r4
	mov r1, r8
	mov r3, r2
	bl GameObject__InitFromObject
	ldr r0, _02168658 // =ovl02_21701BC
	ldr r5, _0216865C // =ovl02_21704DC
	str r0, [r6, #0xf8]
	ldr r1, [r6, #0x24]
	mov r0, #3
	orr r1, r1, #2
	str r1, [r6, #0x24]
	ldr r2, [r6, #0x18]
	ldr r1, _02168660 // =ovl02_2170488
	orr r2, r2, #0x10
	str r2, [r6, #0x18]
	ldr r3, [r6, #0x20]
	mov r2, #0
	orr r3, r3, #0x180
	str r3, [r6, #0x20]
	ldr r9, [r6, #0x1c]
	mov r3, #6
	orr r9, r9, #0x2100
	str r9, [r6, #0x1c]
	str r5, [r6, #0xfc]
	str r0, [sp]
	ldr r0, [r6, #0x12c]
	add r0, r0, #0x90
	bl NNS_G3dRenderObjSetCallBack
	ldrsb r0, [r8, #6]
	cmp r0, #0
	ldr r0, [r6, #0x12c]
	bne _02168470
	ldr r0, [r0, #0x94]
	ldr r1, _02168664 // =aWristL
	add r0, r0, #0x40
	bl NNS_G3dGetResDictIdxByName
	b _02168480
_02168470:
	ldr r0, [r0, #0x94]
	ldr r1, _02168668 // =aWristR_0
	add r0, r0, #0x40
	bl NNS_G3dGetResDictIdxByName
_02168480:
	add r5, r4, #0x258
	str r0, [r7]
	mov r0, r5
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #1
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r3, #0x1e
	mov r0, #0x28
	str r0, [sp]
	stmib sp, {r0, r3}
	mov r0, r5
	sub r1, r3, #0x46
	sub r2, r3, #0x5a
	sub r3, r3, #0x3c
	bl ObjRect__SetBox3D
	ldr r3, _0216866C // =0x00000102
	str r6, [r5, #0x1c]
	strh r3, [r5, #0x34]
	ldr r2, [r5, #0x18]
	ldr r0, _02168670 // =ovl02_2170550
	orr r2, r2, r3, lsl #4
	str r2, [r5, #0x18]
	str r0, [r5, #0x24]
	ldr r0, [r5, #0x18]
	mov r1, #1
	bic r0, r0, #4
	str r0, [r5, #0x18]
	add r5, r4, #0x218
	mov r2, #0x40
	mov r0, r5
	bl ObjRect__SetAttackStat
	ldr r1, _02168674 // =0x0000FFFF
	mov r0, r5
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r3, #0x1e
	mov r0, #0x28
	str r0, [sp]
	str r0, [sp, #4]
	str r3, [sp, #8]
	mov r0, r5
	sub r1, r3, #0x46
	sub r2, r3, #0x5a
	sub r3, r3, #0x3c
	bl ObjRect__SetBox3D
	ldr r1, _02168678 // =0x00000201
	str r6, [r5, #0x1c]
	strh r1, [r5, #0x34]
	ldr r1, [r5, #0x18]
	ldr r0, _0216867C // =ovl02_21706B4
	orr r1, r1, #0x1000
	str r1, [r5, #0x18]
	str r0, [r5, #0x20]
	ldr r0, [r5, #0x18]
	ldr r1, _02168640 // =gameArchiveStage
	bic r0, r0, #4
	str r0, [r5, #0x18]
	ldrsb r0, [r8, #6]
	ldr r2, [r1, #0]
	ldr r1, _02168680 // =aExc_3
	cmp r0, #0
	mov r10, #1
	add r0, sp, #0xc
	movne r10, #2
	bl NNS_FndMountArchive
	mov r9, #0
	add r5, r7, #0xc
	ldr r11, _02168684 // =bossAssetFiles
	b _021685F0
_021685A4:
	add r0, sp, #0xc
	add r1, r9, #0x14
	add r8, r5, r9, lsl #5
	bl NNS_FndGetArchiveFileByIndex
	mov r4, r0
	ldr r0, [r11, r10, lsl #3]
	bl NNS_G3dGetTex
	ldr r1, _02168688 // =_02179844
	ldr r1, [r1, r9, lsl #2]
	bl Asset3DSetup__PaletteFromName
	mov r2, #5
	str r2, [sp]
	mov r2, #0
	str r0, [sp, #4]
	mov r1, r4
	mov r0, r8
	mov r3, r2
	bl InitPaletteAnimator
	add r9, r9, #1
_021685F0:
	cmp r9, #3
	blt _021685A4
	mov r2, #0
	mov r3, r2
	add r0, r7, #0xc
	mov r1, #3
	bl BossHelpers__SetPaletteAnimations
	add r0, sp, #0xc
	bl NNS_FndUnmountArchive
	mov r0, r6
	bl StageTask__InitSeqPlayer
	mov r0, r6
	bl ovl02_21706FC
	mov r0, r6
	add sp, sp, #0x74
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02168630: .word StageTask_Main
_02168634: .word GameObject__Destructor
_02168638: .word bossAssetFiles+0x00000008
_0216863C: .word aBossfArmLNsbmd_0
_02168640: .word gameArchiveStage
_02168644: .word aBossfArmLNsbca_0
_02168648: .word bossAssetFiles+0x00000010
_0216864C: .word aBossfArmRNsbmd_0
_02168650: .word aBossfArmRNsbca_0
_02168654: .word 0x000034CC
_02168658: .word ovl02_21701BC
_0216865C: .word ovl02_21704DC
_02168660: .word ovl02_2170488
_02168664: .word aWristL
_02168668: .word aWristR_0
_0216866C: .word 0x00000102
_02168670: .word ovl02_2170550
_02168674: .word 0x0000FFFF
_02168678: .word 0x00000201
_0216867C: .word ovl02_21706B4
_02168680: .word aExc_3
_02168684: .word bossAssetFiles
_02168688: .word _02179844
	arm_func_end BossFArm__Create

	arm_func_start BossFBodyCannon__Create
BossFBodyCannon__Create: // 0x0216868C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x78
	mov r3, #0x1500
	mov r6, r0
	mov r5, r1
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _02168874 // =StageTask_Main
	ldr r1, _02168878 // =ovl02_21710A4
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	bl GetTaskWork_
	mov r7, r0
	mov r0, r4
	bl GetTaskWork_
	mov r1, #0
	mov r2, #0x364
	mov r4, r0
	bl MI_CpuFill8
	mov r0, r7
	mov r1, #0x94
	bl StageTask__AllocateWorker
	mov r1, #0
	str r0, [sp, #0xc]
	ldr r2, _0216887C // =gameArchiveStage
	str r1, [sp]
	ldr r3, [r2, #0]
	ldr r2, _02168880 // =aBossfEtcNsbmd_0
	str r3, [sp, #4]
	mov r0, r7
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r0, [r7, #0x12c]
	mov r2, #4
	strb r2, [r0, #0xa]
	ldr r0, [r7, #0x12c]
	mov r1, #0
	strb r1, [r0, #0xb]
	ldrsb r0, [r6, #6]
	cmp r0, #0
	bne _02168758
	ldr r1, _0216887C // =gameArchiveStage
	ldr r0, _02168880 // =aBossfEtcNsbmd_0
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
_02168758:
	mov r0, r7
	mov r1, r5
	mov r2, #0
	bl StageTask__SetParent
	mov r2, #0
	mov r0, r4
	mov r1, r6
	mov r3, r2
	bl GameObject__InitFromObject
	ldr r0, _02168884 // =ovl02_21701BC
	str r0, [r7, #0xf8]
	ldr r0, [r7, #0x18]
	orr r0, r0, #0x12
	str r0, [r7, #0x18]
	ldr r0, [r7, #0x20]
	orr r0, r0, #0x180
	str r0, [r7, #0x20]
	ldr r0, [r7, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r7, #0x1c]
	ldrsb r0, [r6, #6]
	cmp r0, #0
	bne _02168858
	ldr r1, _0216887C // =gameArchiveStage
	ldr r0, _02168880 // =aBossfEtcNsbmd_0
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	ldr r1, _0216887C // =gameArchiveStage
	mov r9, r0
	ldr r2, [r1, #0]
	ldr r1, _02168888 // =aExc_3
	add r0, sp, #0x10
	bl NNS_FndMountArchive
	ldr r10, [sp, #0xc]
	ldr r5, _0216888C // =_02179864
	mov r8, #0
	add r11, sp, #0x10
	mov r4, #5
_021687F0:
	mov r0, r11
	add r1, r8, #0xe
	bl NNS_FndGetArchiveFileByIndex
	mov r6, r0
	mov r0, r9
	bl NNS_G3dGetTex
	ldr r1, [r5, r8, lsl #2]
	bl Asset3DSetup__PaletteFromName
	str r4, [sp]
	mov r2, #0
	str r0, [sp, #4]
	mov r1, r6
	mov r0, r10
	mov r3, r2
	bl InitPaletteAnimator
	add r8, r8, #1
	add r10, r10, #0x20
	cmp r8, #2
	blt _021687F0
	mov r2, #0
	ldr r0, [sp, #0xc]
	mov r3, r2
	mov r1, #2
	bl BossHelpers__SetPaletteAnimations
	add r0, sp, #0x10
	bl NNS_FndUnmountArchive
_02168858:
	mov r0, r7
	bl StageTask__InitSeqPlayer
	mov r0, r7
	bl ovl02_2171108
	mov r0, r7
	add sp, sp, #0x78
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02168874: .word StageTask_Main
_02168878: .word ovl02_21710A4
_0216887C: .word gameArchiveStage
_02168880: .word aBossfEtcNsbmd_0
_02168884: .word ovl02_21701BC
_02168888: .word aExc_3
_0216888C: .word _02179864
	arm_func_end BossFBodyCannon__Create

	arm_func_start BossFShipCannon__Create
BossFShipCannon__Create: // 0x02168890
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x54
	mov r3, #0x1500
	mov r8, r0
	mov r7, r1
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	ldr r0, _02168BFC // =StageTask_Main
	ldr r1, _02168C00 // =ovl02_2172618
	mov r3, r2
	str r4, [sp, #4]
	mov r4, #0x364
	str r4, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	mov r0, r5
	bl GetTaskWork_
	mov r1, #0
	mov r5, r0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, #0x68
	bl StageTask__AllocateWorker
	mov r6, r0
	ldrsb r0, [r8, #6]
	cmp r0, #0
	beq _02168934
	mov r1, #0
	ldr r0, _02168C04 // =gameArchiveStage
	str r1, [sp]
	ldr ip, [r0]
	ldr r2, _02168C08 // =aBossfEtcNsbmd_0
	mov r0, r4
	mov r3, #1
	str ip, [sp, #4]
	bl ObjAction3dNNModelLoad
	b _02168970
_02168934:
	ldr r0, _02168C04 // =gameArchiveStage
	ldr r1, _02168C08 // =aBossfEtcNsbmd_0
	ldr r2, [r0, #0]
	add r0, r6, #0x60
	bl ObjActionLoadArchiveFile
	add r1, r6, #0x60
	ldr r2, _02168C08 // =aBossfEtcNsbmd_0
	mov r0, r4
	str r1, [sp]
	mov r1, #0
	mov r3, #1
	str r1, [sp, #4]
	bl ObjAction3dNNModelLoad
	add r0, r6, #0x60
	bl ObjDataRelease
_02168970:
	ldr r0, [r4, #0x12c]
	mov r1, #4
	strb r1, [r0, #0xa]
	ldr r3, [r4, #0x12c]
	mov r2, #0
	mov r0, r4
	mov r1, r7
	strb r2, [r3, #0xb]
	bl StageTask__SetParent
	mov r2, #0
	ldr ip, [r4, #0x12c]
	ldr r7, _02168C0C // =0x000034CC
	mov r0, r5
	str r7, [ip, #0x18]
	str r7, [ip, #0x1c]
	mov r1, r8
	mov r3, r2
	str r7, [ip, #0x20]
	bl GameObject__InitFromObject
	ldr r0, _02168C10 // =ovl02_2172670
	str r0, [r4, #0xf8]
	ldr r0, [r4, #0x18]
	orr r0, r0, #0x12
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x180
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	ldrsb r0, [r8, #6]
	cmp r0, #0
	ldr r0, _02168C14 // =0x00738000
	bne _02168A24
	mov r1, #0x56000
	str r1, [r4, #0x44]
	str r0, [r4, #0x48]
	mov r0, #0
	str r0, [r4, #0x4c]
	mov r0, #0x4000
	strh r0, [r6, #0xa]
	ldr r0, [r4, #0x20]
	orr r0, r0, #1
	str r0, [r4, #0x20]
	b _02168A40
_02168A24:
	ldr r1, _02168C18 // =0x0029A000
	str r1, [r4, #0x44]
	str r0, [r4, #0x48]
	mov r0, #0
	str r0, [r4, #0x4c]
	mov r0, #0xc000
	strh r0, [r6, #0xa]
_02168A40:
	mov r0, #3
	str r0, [sp]
	ldr r0, [r4, #0x12c]
	ldr r1, _02168C1C // =ovl02_21726D4
	add r0, r0, #0x90
	mov r2, #0
	mov r3, #6
	bl NNS_G3dRenderObjSetCallBack
	ldr r0, [r4, #0x12c]
	ldr r1, _02168C20 // =aBarrel_0
	ldr r0, [r0, #0x94]
	add r0, r0, #0x40
	bl NNS_G3dGetResDictIdxByName
	mov r1, #0
	add r7, r5, #0x218
	str r0, [r6]
	mov r0, r7
	mov r2, r1
	bl ObjRect__SetAttackStat
	mov r0, r7
	mov r1, #2
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r1, #0x58
	str r1, [sp]
	sub r0, r1, #0x67
	str r0, [sp, #4]
	sub r2, r1, #0x170
	mov r3, #0x1e
	str r3, [sp, #8]
	mov r0, r7
	sub r1, r3, #0x5a
	sub r3, r3, #0x6e
	bl ObjRect__SetBox3D
	str r4, [r7, #0x1c]
	ldr r1, _02168C24 // =0x00000102
	ldr r0, _02168C28 // =ovl02_21727C4
	strh r1, [r7, #0x34]
	str r0, [r7, #0x24]
	add r7, r5, #0x258
	mov r0, r7
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r7
	mov r1, #1
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	mvn r3, #0x2c
	str r3, [sp]
	mov r0, r7
	sub r1, r3, #0x23
	sub r2, r3, #0x10
	sub r3, r3, #3
	bl ObjRect__SetBox2D
	str r4, [r7, #0x1c]
	ldr r1, _02168C24 // =0x00000102
	ldr r0, _02168C2C // =ovl02_2172AD8
	strh r1, [r7, #0x34]
	str r0, [r7, #0x24]
	ldr r0, [r4, #0x12c]
	mov r1, #1
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlGetMdlEmi
	strh r0, [r6, #0x2c]
	mov r1, #0
	mov r0, r4
	strh r1, [r6, #0x14]
	bl ovl02_217019C
	cmp r0, #0
	add r0, sp, #0xc
	beq _02168B98
	ldr r1, _02168C30 // =FX_SinCosTable_+0x00001000
	ldrsh r2, [r1, #2]
	ldrsh r1, [r1, #0]
	bl MTX_RotY33_
	ldr r1, _02168C34 // =FX_SinCosTable_+0x00000100
	add r0, sp, #0x30
	ldrsh r2, [r1, #0xc2]
	ldrsh r1, [r1, #0xc0]
	bl MTX_RotX33_
	add r0, sp, #0x30
	add r1, sp, #0xc
	add r2, r6, #0x30
	bl MTX_Concat33
	b _02168BCC
_02168B98:
	ldr r1, _02168C38 // =FX_SinCosTable_+0x00003000
	ldrsh r2, [r1, #2]
	ldrsh r1, [r1, #0]
	bl MTX_RotY33_
	ldr r1, _02168C34 // =FX_SinCosTable_+0x00000100
	add r0, sp, #0x30
	ldrsh r2, [r1, #0xc2]
	ldrsh r1, [r1, #0xc0]
	bl MTX_RotX33_
	add r0, sp, #0x30
	add r1, sp, #0xc
	add r2, r6, #0x30
	bl MTX_Concat33
_02168BCC:
	mov r0, r4
	bl StageTask__InitSeqPlayer
	bl AllocSndHandle
	str r0, [r6, #0x54]
	mov r0, r4
	bl ovl02_2172C1C
	mov r0, r4
	bl ovl02_2173D98
	str r0, [r6, #0x58]
	mov r0, r4
	add sp, sp, #0x54
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02168BFC: .word StageTask_Main
_02168C00: .word ovl02_2172618
_02168C04: .word gameArchiveStage
_02168C08: .word aBossfEtcNsbmd_0
_02168C0C: .word 0x000034CC
_02168C10: .word ovl02_2172670
_02168C14: .word 0x00738000
_02168C18: .word 0x0029A000
_02168C1C: .word ovl02_21726D4
_02168C20: .word aBarrel_0
_02168C24: .word 0x00000102
_02168C28: .word ovl02_21727C4
_02168C2C: .word ovl02_2172AD8
_02168C30: .word FX_SinCosTable_+0x00001000
_02168C34: .word FX_SinCosTable_+0x00000100
_02168C38: .word FX_SinCosTable_+0x00003000
	arm_func_end BossFShipCannon__Create

	arm_func_start BossFMissileGreen__Create
BossFMissileGreen__Create: // 0x02168C3C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	ldr r0, _02168D9C // =StageTask_Main
	ldr r1, _02168DA0 // =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #4]
	mov r4, #0x364
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	bl GetTaskWork_
	mov r5, r0
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r1, #0
	str r1, [sp]
	ldr r2, _02168DA4 // =gameArchiveStage
	mov r0, r5
	ldr r3, [r2, #0]
	ldr r2, _02168DA8 // =aBossfEtcNsbmd_0
	str r3, [sp, #4]
	mov r3, #3
	bl ObjAction3dNNModelLoad
	mov r1, r8
	mov r2, r7
	mov r3, r6
	mov r6, #4
	ldr r0, [r5, #0x12c]
	mov r7, #0
	strb r6, [r0, #0xa]
	ldr r0, [r5, #0x12c]
	ldr r6, _02168DAC // =0x000034CC
	strb r7, [r0, #0xb]
	ldr r7, [r5, #0x12c]
	mov r0, r4
	str r6, [r7, #0x18]
	str r6, [r7, #0x1c]
	str r6, [r7, #0x20]
	bl GameObject__InitFromObject
	add r4, r4, #0x218
	ldr r1, [r5, #0x18]
	mov r0, r4
	orr r1, r1, #0x12
	str r1, [r5, #0x18]
	ldr r2, [r5, #0x20]
	mov r1, #2
	orr r2, r2, #0x180
	str r2, [r5, #0x20]
	ldr r3, [r5, #0x1c]
	mov r2, #0x40
	orr r3, r3, #0x100
	str r3, [r5, #0x1c]
	bl ObjRect__SetAttackStat
	mov r0, r4
	mov r1, #1
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	mov r3, #0xf
	str r3, [sp]
	mov r0, r4
	sub r1, r3, #0x1e
	mov r2, r1
	bl ObjRect__SetBox2D
	ldr r0, _02168DB0 // =0x00000102
	str r5, [r4, #0x1c]
	ldr r1, _02168DB4 // =ovl02_217492C
	strh r0, [r4, #0x34]
	mov r0, r5
	str r1, [r4, #0x24]
	bl ovl02_2176638
	mov r0, r5
	bl StageTask__InitSeqPlayer
	mov r0, r5
	bl ovl02_2174ED0
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02168D9C: .word StageTask_Main
_02168DA0: .word GameObject__Destructor
_02168DA4: .word gameArchiveStage
_02168DA8: .word aBossfEtcNsbmd_0
_02168DAC: .word 0x000034CC
_02168DB0: .word 0x00000102
_02168DB4: .word ovl02_217492C
	arm_func_end BossFMissileGreen__Create

	arm_func_start BossFMissileRed__Create
BossFMissileRed__Create: // 0x02168DB8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	ldr r0, _02168F18 // =StageTask_Main
	ldr r1, _02168F1C // =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #4]
	mov r4, #0x364
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	bl GetTaskWork_
	mov r5, r0
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r1, #0
	str r1, [sp]
	ldr r2, _02168F20 // =gameArchiveStage
	mov r0, r5
	ldr r3, [r2, #0]
	ldr r2, _02168F24 // =aBossfEtcNsbmd_0
	str r3, [sp, #4]
	mov r3, #4
	bl ObjAction3dNNModelLoad
	mov r1, r8
	mov r2, r7
	mov r3, r6
	mov r6, #4
	ldr r0, [r5, #0x12c]
	mov r7, #0
	strb r6, [r0, #0xa]
	ldr r0, [r5, #0x12c]
	ldr r6, _02168F28 // =0x000034CC
	strb r7, [r0, #0xb]
	ldr r7, [r5, #0x12c]
	mov r0, r4
	str r6, [r7, #0x18]
	str r6, [r7, #0x1c]
	str r6, [r7, #0x20]
	bl GameObject__InitFromObject
	add r4, r4, #0x218
	ldr r1, [r5, #0x18]
	mov r0, r4
	orr r1, r1, #0x12
	str r1, [r5, #0x18]
	ldr r2, [r5, #0x20]
	mov r1, #2
	orr r2, r2, #0x180
	str r2, [r5, #0x20]
	ldr r3, [r5, #0x1c]
	mov r2, #0x40
	orr r3, r3, #0x100
	str r3, [r5, #0x1c]
	bl ObjRect__SetAttackStat
	mov r0, r4
	mov r1, #1
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	mov r3, #0xf
	str r3, [sp]
	mov r0, r4
	sub r1, r3, #0x1e
	mov r2, r1
	bl ObjRect__SetBox2D
	ldr r0, _02168F2C // =0x00000102
	str r5, [r4, #0x1c]
	ldr r1, _02168F30 // =ovl02_217492C
	strh r0, [r4, #0x34]
	mov r0, r5
	str r1, [r4, #0x24]
	bl ovl02_2176638
	mov r0, r5
	bl StageTask__InitSeqPlayer
	mov r0, r5
	bl ovl02_2174ED0
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02168F18: .word StageTask_Main
_02168F1C: .word GameObject__Destructor
_02168F20: .word gameArchiveStage
_02168F24: .word aBossfEtcNsbmd_0
_02168F28: .word 0x000034CC
_02168F2C: .word 0x00000102
_02168F30: .word ovl02_217492C
	arm_func_end BossFMissileRed__Create

	arm_func_start ovl02_2168F34
ovl02_2168F34: // 0x02168F34
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	ldr r0, _02168F64 // =BossFStage__Singleton
	mov r1, #0
	str r1, [r0]
	bl ovl02_2168FEC
	mov r0, #0x1000
	bl SetObjSpeed
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r4, pc}
	.align 2, 0
_02168F64: .word BossFStage__Singleton
	arm_func_end ovl02_2168F34

	arm_func_start ovl02_2168F68
ovl02_2168F68: // 0x02168F68
	stmdb sp!, {r3, lr}
	ldr r1, _02168FD4 // =gameArchiveStage
	ldr r0, _02168FD8 // =aBsefHitBNsbmd_0
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r1, _02168FD4 // =gameArchiveStage
	ldr r0, _02168FDC // =aBsef8ZJetNsbmd_0
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r1, _02168FD4 // =gameArchiveStage
	ldr r0, _02168FE0 // =aBsef8Float1Nsb_3
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r1, _02168FD4 // =gameArchiveStage
	ldr r0, _02168FE4 // =aBsef8WaveNsbmd_0
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r1, _02168FD4 // =gameArchiveStage
	ldr r0, _02168FE8 // =aBsef8BariaNsbm_0
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldmia sp!, {r3, pc}
	.align 2, 0
_02168FD4: .word gameArchiveStage
_02168FD8: .word aBsefHitBNsbmd_0
_02168FDC: .word aBsef8ZJetNsbmd_0
_02168FE0: .word aBsef8Float1Nsb_3
_02168FE4: .word aBsef8WaveNsbmd_0
_02168FE8: .word aBsef8BariaNsbm_0
	arm_func_end ovl02_2168F68

	arm_func_start ovl02_2168FEC
ovl02_2168FEC: // 0x02168FEC
	stmdb sp!, {r3, lr}
	ldr r1, _0216905C // =gameArchiveStage
	ldr r0, _02169060 // =aBsefHitBNsbmd_0
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r1, _0216905C // =gameArchiveStage
	ldr r0, _02169064 // =aBsef8ZJetNsbmd_0
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r1, _0216905C // =gameArchiveStage
	ldr r0, _02169068 // =aBsef8Float1Nsb_3
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r1, _0216905C // =gameArchiveStage
	ldr r0, _0216906C // =aBsef8WaveNsbmd_0
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r1, _0216905C // =gameArchiveStage
	ldr r0, _02169070 // =aBsef8BariaNsbm_0
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	bl ovl02_21690C8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216905C: .word gameArchiveStage
_02169060: .word aBsefHitBNsbmd_0
_02169064: .word aBsef8ZJetNsbmd_0
_02169068: .word aBsef8Float1Nsb_3
_0216906C: .word aBsef8WaveNsbmd_0
_02169070: .word aBsef8BariaNsbm_0
	arm_func_end ovl02_2168FEC

	arm_func_start ovl02_2169074
ovl02_2169074: // 0x02169074
	stmdb sp!, {r3, lr}
	ldr r1, _021690B8 // =gameArchiveStage
	ldr r0, _021690BC // =aBsef8BFlash1Ns_1
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r1, _021690B8 // =gameArchiveStage
	ldr r0, _021690C0 // =aBsef8BFlash2Ns_1
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r1, _021690B8 // =gameArchiveStage
	ldr r0, _021690C4 // =aBsef8BeamNsbmd_0
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldmia sp!, {r3, pc}
	.align 2, 0
_021690B8: .word gameArchiveStage
_021690BC: .word aBsef8BFlash1Ns_1
_021690C0: .word aBsef8BFlash2Ns_1
_021690C4: .word aBsef8BeamNsbmd_0
	arm_func_end ovl02_2169074

	arm_func_start ovl02_21690C8
ovl02_21690C8: // 0x021690C8
	stmdb sp!, {r3, lr}
	ldr r1, _0216910C // =gameArchiveStage
	ldr r0, _02169110 // =aBsef8BFlash1Ns_1
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r1, _0216910C // =gameArchiveStage
	ldr r0, _02169114 // =aBsef8BFlash2Ns_1
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r1, _0216910C // =gameArchiveStage
	ldr r0, _02169118 // =aBsef8BeamNsbmd_0
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216910C: .word gameArchiveStage
_02169110: .word aBsef8BFlash1Ns_1
_02169114: .word aBsef8BFlash2Ns_1
_02169118: .word aBsef8BeamNsbmd_0
	arm_func_end ovl02_21690C8

	arm_func_start ovl02_216911C
ovl02_216911C: // 0x0216911C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x550
	bl BossHelpers__ProcessLights
	add r0, r4, #0x550
	bl BossHelpers__RevertModifiedLights
	ldr r1, [r4, #0x378]
	mov r0, r4
	blx r1
	bl TitleCard__GetProgress
	cmp r0, #5
	bne _0216919C
	add r0, r4, #0x500
	mov r2, #7
	strh r2, [r0, #0x3a]
	ldr r1, _021691A8 // =ovl02_21691B8
	ldr r2, _021691AC // =_mt_math_rand
	str r1, [r4, #0xf4]
	ldr r3, [r2, #0]
	ldr r0, _021691B0 // =0x00196225
	ldr r1, _021691B4 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	ldr r0, [r4, #0x384]
	orrne r0, r0, #2
	strne r0, [r4, #0x384]
	orreq r0, r0, #4
	streq r0, [r4, #0x384]
_0216919C:
	mov r0, r4
	bl ovl02_21693F4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021691A8: .word ovl02_21691B8
_021691AC: .word _mt_math_rand
_021691B0: .word 0x00196225
_021691B4: .word 0x3C6EF35F
	arm_func_end ovl02_216911C

	arm_func_start ovl02_21691B8
ovl02_21691B8: // 0x021691B8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r1, [r4, #0x58c]
	add r0, r4, #0x500
	mov r1, r1, asr #0xc
	strh r1, [r0, #0x80]
	ldr r0, [r4, #0x384]
	tst r0, #0x100
	bne _021691E8
	add r0, r4, #0x550
	bl BossHelpers__ProcessLights
_021691E8:
	add r0, r4, #0x550
	bl BossHelpers__RevertModifiedLights
	mov r3, #0x400
	str r3, [sp]
	arm_func_end ovl02_21691B8

	arm_func_start ovl02_21691F8
ovl02_21691F8: // 0x021691F8
	ldr r0, [r4, #0x58c]
	ldr r1, [r4, #0x590]
	mov r2, #1
	bl ObjShiftSet
	str r0, [r4, #0x58c]
	ldr r0, [r4, #0x384]
	tst r0, #0x80
	beq _02169268
	mov r0, #0
	str r0, [sp]
	ldr r1, [r4, #0x588]
	ldr r0, _021693E4 // =0x00007FFF
	mov r1, r1, asr #0xc
	mov r2, r0
	mov r3, #0x3f
	bl G3X_SetClearColor
	ldr r0, [r4, #0x588]
	mov r1, #0
	cmp r0, #0
	arm_func_end ovl02_21691F8

	arm_func_start ovl02_2169244
ovl02_2169244: // 0x02169244
	ldreq r0, [r4, #0x384]
	mov r3, r1
	biceq r0, r0, #0x80
	streq r0, [r4, #0x384]
	str r1, [sp]
	ldr r0, [r4, #0x588]
	mov r2, #3
	bl ObjShiftSet
	str r0, [r4, #0x588]
_02169268:
	ldr r1, [r4, #0x378]
	mov r0, r4
	blx r1
	ldr r1, [r4, #0x508]
	ldr r0, [r4, #0x50c]
	subs r0, r0, r1
	beq _021692C0
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x800
	strle r1, [r4, #0x50c]
	ldr r3, [r4, #0x508]
	ldr r1, [r4, #0x50c]
	ldr r0, [r4, #0x510]
	sub r1, r1, r3
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r3, r1
	str r0, [r4, #0x508]
_021692C0:
	ldr r0, [r4, #0x504]
	add r0, r0, #0x200
	str r0, [r4, #0x504]
	ldr r1, [r4, #0x508]
	mov r0, r0, lsl #4
	mov r1, r1, lsl #4
	mov r0, r0, asr #0x10
	mov r1, r1, asr #0x10
	bl BossArena__Func_2039A94
	ldr r1, [r4, #0x584]
	add r0, r4, #0x500
	add r1, r1, #1
	str r1, [r4, #0x584]
	ldrh r0, [r0, #0x36]
	cmp r0, #0
	beq _02169368
	bl GetObjSpeed
	cmp r0, #0
	beq _02169368
	ldr r0, [r4, #0x584]
	tst r0, #7
	bne _02169368
	ldr r2, _021693E8 // =_obj_disp_rand
	ldr r0, _021693EC // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _021693F0 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #0xf
	bne _02169368
	ldr r1, [r4, #0x384]
	mov r0, #0x1f000
	orr r1, r1, #0x80
	str r1, [r4, #0x384]
	str r0, [r4, #0x588]
	ldr r0, [r4, #0x590]
	sub r0, r0, #0x8000
	str r0, [r4, #0x58c]
	bl ovl02_2178088
_02169368:
	mov r0, r4
	bl ovl02_2169490
	mov r0, r4
	bl ovl02_2169AF8
	add r0, r4, #0x500
	ldrh r1, [r0, #0x38]
	ldrh r0, [r0, #0x36]
	cmp r1, r0
	beq _021693C8
	bl Camera3D__GetWork
	add r0, r4, #0x500
	ldrh r0, [r0, #0x36]
	cmp r0, #1
	beq _021693C8
	cmp r0, #2
	beq _021693BC
	cmp r0, #3
	moveq r0, #0x6000
	rsbeq r0, r0, #0
	streq r0, [r4, #0x590]
	b _021693C8
_021693BC:
	mov r0, #0x3000
	rsb r0, r0, #0
	str r0, [r4, #0x590]
_021693C8:
	add r1, r4, #0x500
	ldrh r2, [r1, #0x36]
	mov r0, r4
	strh r2, [r1, #0x38]
	bl ovl02_21693F4
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021693E4: .word 0x00007FFF
_021693E8: .word _obj_disp_rand
_021693EC: .word 0x00196225
_021693F0: .word 0x3C6EF35F
	arm_func_end ovl02_2169244

	arm_func_start ovl02_21693F4
ovl02_21693F4: // 0x021693F4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x384]
	ldr r4, [r5, #0x594]
	tst r0, #0x400
	ldmneia sp!, {r3, r4, r5, pc}
	tst r0, #0x200
	mov r0, r4
	mov r1, #0x800
	beq _02169428
	mov r2, #0x7f000
	bl ObjSpdUpSet
	b _0216942C
_02169428:
	bl ObjSpdDownSet
_0216942C:
	str r0, [r5, #0x594]
	ldr r0, [r5, #0x594]
	cmp r0, #0
	movlt r0, #0
	strlt r0, [r5, #0x594]
	ldr r0, [r5, #0x594]
	cmp r0, #0x7f000
	movgt r0, #0x7f000
	strgt r0, [r5, #0x594]
	ldr r1, [r5, #0x594]
	cmp r4, r1
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, _02169488 // =bgmHandle
	mov r2, r1, asr #0xc
	mov r1, #0x4000
	bl NNS_SndPlayerSetTrackVolume
	ldr r1, [r5, #0x594]
	ldr r0, _02169488 // =bgmHandle
	mov r2, r1, asr #0xc
	ldr r1, _0216948C // =0x00008220
	rsb r2, r2, #0x7f
	bl NNS_SndPlayerSetTrackVolume
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02169488: .word bgmHandle
_0216948C: .word 0x00008220
	arm_func_end ovl02_21693F4

	arm_func_start ovl02_2169490
ovl02_2169490: // 0x02169490
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x384]
	tst r1, #0x10
	ldmneia sp!, {r3, pc}
	tst r1, #1
	beq _021694B0
	bl ovl02_21694B8
	ldmia sp!, {r3, pc}
_021694B0:
	bl ovl02_2169868
	ldmia sp!, {r3, pc}
	arm_func_end ovl02_2169490

	arm_func_start ovl02_21694B8
ovl02_21694B8: // 0x021694B8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r2, [r0, #0x370]
	ldr r7, [r0, #0x36c]
	ldr r5, [r2, #0xf4]
	ldr r4, _02169840 // =ovl02_21730A4
	ldr r1, _02169844 // =gPlayer
	cmp r5, r4
	ldrne r2, [r0, #0x374]
	ldr r6, [r1, #0]
	ldrne r3, [r2, #0xf4]
	ldr ip, [r7, #0x124]
	cmpne r3, r4
	ldrne r2, _02169848 // =ovl02_217344C
	mov r1, #0
	cmpne r5, r2
	cmpne r3, r2
	bne _0216950C
	add r0, r0, #0x500
	mov r1, #0
	strh r1, [r0, #0x3a]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0216950C:
	ldr r2, [r6, #0x5d8]
	tst r2, #0x200000
	ldreq r2, [r6, #0x4c]
	cmpeq r2, #0
	beq _02169530
	add r0, r0, #0x500
	mov r1, #0
	strh r1, [r0, #0x3a]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02169530:
	ldr r3, [r7, #0xf4]
	ldr r2, _0216984C // =ovl02_216B6CC
	cmp r3, r2
	bne _021695AC
	add r2, r0, #0x500
	strh r1, [r2, #0x3a]
	ldrh r3, [r2, #0x42]
	cmp r3, #0
	beq _0216959C
	mov r3, r1
_02169558:
	add r2, ip, r3, lsl #2
	ldr r2, [r2, #0x10]
	cmp r2, #0
	movne r1, r2
	add r2, r3, #1
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
	cmp r3, #4
	blo _02169558
	add r0, r0, #0x500
	ldrh r2, [r0, #0x42]
	cmp r1, #0
	sub r1, r2, #1
	strh r1, [r0, #0x42]
	moveq r1, #0
	streqh r1, [r0, #0x42]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0216959C:
	ldrh r1, [r2, #0x40]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r2, #0x40]
_021695AC:
	add r1, r0, #0x500
	ldrh r2, [r1, #0x40]
	cmp r2, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldrh r2, [r1, #0x36]
	cmp r2, #0
	bne _02169638
	ldr r6, _02169850 // =_mt_math_rand
	ldr r4, _02169854 // =0x00196225
	ldr r7, [r6, #0]
	ldr r5, _02169858 // =0x3C6EF35F
	ldr r2, _0216985C // =_02179000
	mla r3, r7, r4, r5
	mov r7, r3, lsr #0x10
	mov lr, r7, lsl #0x10
	mov r7, lr, lsr #0x10
	mov r7, r7, lsl #0x1e
	mov r7, r7, lsr #0x1d
	ldrh r7, [r2, r7]
	str r3, [r6]
	strh r7, [r1, #0x3a]
	ldrh r3, [r1, #0x3e]
	cmp r3, r7
	bne _021696A4
	ldr r3, [r6, #0]
	mla r4, r3, r4, r5
	mov r3, r4, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, lsl #0x1e
	mov r3, r3, lsr #0x1d
	ldrh r2, [r2, r3]
	str r4, [r6]
	strh r2, [r1, #0x3a]
	b _021696A4
_02169638:
	ldr r6, _02169850 // =_mt_math_rand
	ldr lr, _02169854 // =0x00196225
	ldr r5, [r6, #0]
	ldr r4, _02169858 // =0x3C6EF35F
	ldr r2, _02169860 // =_021790D8
	mla r3, r5, lr, r4
	mov r5, r3, lsr #0x10
	mov r5, r5, lsl #0x10
	mov r5, r5, lsr #0x10
	mov r5, r5, lsl #0x1c
	mov r5, r5, lsr #0x1b
	ldrh r5, [r2, r5]
	str r3, [r6]
	strh r5, [r1, #0x3a]
	ldrh r3, [r1, #0x3e]
	cmp r3, r5
	bne _021696A4
	ldr r3, [r6, #0]
	mla r4, r3, lr, r4
	mov r3, r4, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, lsl #0x1c
	mov r3, r3, lsr #0x1b
	ldrh r2, [r2, r3]
	str r4, [r6]
	strh r2, [r1, #0x3a]
_021696A4:
	add r3, r0, #0x500
	ldrh r2, [r3, #0x44]
	mov r1, #0x3c
	add r2, r2, #1
	strh r2, [r3, #0x44]
	strh r1, [r3, #0x40]
	ldrh r1, [r3, #0x44]
	cmp r1, #5
	movhi r1, #8
	strhih r1, [r3, #0x3a]
	bhi _02169744
	cmp r1, #3
	bls _0216970C
	ldr r4, _02169850 // =_mt_math_rand
	ldr r1, _02169854 // =0x00196225
	ldr r5, [r4, #0]
	ldr r2, _02169858 // =0x3C6EF35F
	mla r2, r5, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	tst r1, #3
	str r2, [r4]
	moveq r1, #8
	streqh r1, [r3, #0x3a]
	b _02169744
_0216970C:
	cmp r1, #2
	bls _02169744
	ldr r4, _02169850 // =_mt_math_rand
	ldr r1, _02169854 // =0x00196225
	ldr r5, [r4, #0]
	ldr r2, _02169858 // =0x3C6EF35F
	mla r2, r5, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	tst r1, #7
	str r2, [r4]
	moveq r1, #8
	streqh r1, [r3, #0x3a]
_02169744:
	add r1, ip, #0x100
	ldrh r1, [r1, #0x8c]
	cmp r1, #5
	addhi r1, r0, #0x500
	movhi r2, #1
	strhih r2, [r1, #0x3a]
	add r1, r0, #0x500
	ldrh r2, [r1, #0x3c]
	cmp r2, #0
	beq _02169784
	strh r2, [r1, #0x3a]
	mov r2, #0
	strh r2, [r1, #0x3c]
	ldrh r2, [r1, #0x44]
	sub r2, r2, #1
	strh r2, [r1, #0x44]
_02169784:
	add r1, r0, #0x500
	ldrh r2, [r1, #0x36]
	add lr, r0, #0x500
	cmp r2, #0
	moveq r2, #0
	streqh r2, [r1, #0x44]
	ldrh r1, [lr, #0x3a]
	cmp r1, #1
	bne _0216980C
	mov r1, #0xf0
	strh r1, [lr, #0x42]
	add r2, ip, #0x100
	mov r1, #0
	strh r1, [r2, #0x8c]
	ldrh r2, [lr, #0x36]
	cmp r2, #3
	blo _0216980C
	ldr r4, _02169850 // =_mt_math_rand
	ldr r2, _02169854 // =0x00196225
	ldr r6, [r4, #0]
	ldr r3, _02169858 // =0x3C6EF35F
	ldr r5, _02169864 // =_02178FF8
	mla r7, r6, r2, r3
	mov r2, r7, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x1e
	mov r2, r2, lsr #0x1d
	ldrh r3, [r5, r2]
	str r7, [r4]
	mov r2, #1
	strh r3, [lr, #0x3c]
	strh r1, [lr, #0x42]
	strh r2, [lr, #0x40]
_0216980C:
	add r0, r0, #0x500
	ldrh r1, [r0, #0x3a]
	cmp r1, #7
	ldmhsia sp!, {r3, r4, r5, r6, r7, pc}
	strh r1, [r0, #0x3e]
	ldrh r0, [r0, #0x3a]
	cmp r0, #1
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	add r0, ip, #0x100
	ldrh r1, [r0, #0x8c]
	add r1, r1, #1
	strh r1, [r0, #0x8c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02169840: .word ovl02_21730A4
_02169844: .word gPlayer
_02169848: .word ovl02_217344C
_0216984C: .word ovl02_216B6CC
_02169850: .word _mt_math_rand
_02169854: .word 0x00196225
_02169858: .word 0x3C6EF35F
_0216985C: .word _02179000
_02169860: .word _021790D8
_02169864: .word _02178FF8
	arm_func_end ovl02_21694B8

	arm_func_start ovl02_2169868
ovl02_2169868: // 0x02169868
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, [r0, #0x370]
	ldr r1, _02169AD8 // =gPlayer
	ldr r5, [r2, #0xf4]
	ldr r4, _02169ADC // =ovl02_21730A4
	ldr r6, [r1, #0]
	cmp r5, r4
	ldrne r1, [r0, #0x374]
	ldr ip, [r0, #0x36c]
	ldrne r2, [r1, #0xf4]
	ldr r3, [ip, #0x124]
	cmpne r2, r4
	ldrne r1, _02169AE0 // =ovl02_217344C
	cmpne r5, r1
	cmpne r2, r1
	bne _021698C0
	add r0, r0, #0x500
	mov r1, #0
	strh r1, [r0, #0x46]
	mov r1, #7
	strh r1, [r0, #0x3a]
	ldmia sp!, {r4, r5, r6, pc}
_021698C0:
	ldr r1, [r6, #0x5d8]
	tst r1, #0x200000
	ldreq r1, [r6, #0x4c]
	cmpeq r1, #0
	beq _021698E4
	add r0, r0, #0x500
	mov r1, #7
	strh r1, [r0, #0x3a]
	ldmia sp!, {r4, r5, r6, pc}
_021698E4:
	ldr r2, [ip, #0xf4]
	ldr r1, _02169AE4 // =ovl02_216B6CC
	cmp r2, r1
	bne _02169910
	add r1, r0, #0x500
	mov r2, #0
	strh r2, [r1, #0x3a]
	ldrh r2, [r1, #0x40]
	cmp r2, #0
	subne r2, r2, #1
	strneh r2, [r1, #0x40]
_02169910:
	add r5, r0, #0x500
	ldrh r1, [r5, #0x40]
	cmp r1, #0
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r6, _02169AE8 // =_mt_math_rand
	ldr ip, _02169AEC // =0x00196225
	ldr r4, [r6, #0]
	ldr lr, _02169AF0 // =0x3C6EF35F
	ldr r1, _02169AF4 // =_021790F8
	mla r2, r4, ip, lr
	mov r4, r2, lsr #0x10
	mov r4, r4, lsl #0x10
	mov r4, r4, lsr #0x10
	mov r4, r4, lsl #0x1c
	mov r4, r4, lsr #0x1b
	ldrh r4, [r1, r4]
	str r2, [r6]
	strh r4, [r5, #0x3a]
	ldrh r2, [r5, #0x3e]
	cmp r2, r4
	bne _0216998C
	ldr r2, [r6, #0]
	mla r4, r2, ip, lr
	mov r2, r4, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x1c
	mov r2, r2, lsr #0x1b
	ldrh r1, [r1, r2]
	str r4, [r6]
	strh r1, [r5, #0x3a]
_0216998C:
	add ip, r0, #0x500
	ldrh r2, [ip, #0x46]
	mov r1, #0x3c
	add r2, r2, #1
	strh r2, [ip, #0x46]
	strh r1, [ip, #0x40]
	ldrh r2, [ip, #0x46]
	cmp r2, #5
	addls r1, r3, #0x100
	ldrlsh r1, [r1, #0x8c]
	cmpls r1, #8
	bls _021699CC
	add r1, r0, #0x500
	mov r2, #7
	strh r2, [r1, #0x3a]
	b _02169A7C
_021699CC:
	cmp r2, #4
	bls _02169A08
	ldr r4, _02169AE8 // =_mt_math_rand
	ldr r1, _02169AEC // =0x00196225
	ldr r5, [r4, #0]
	ldr r2, _02169AF0 // =0x3C6EF35F
	mla r2, r5, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	tst r1, #3
	str r2, [r4]
	moveq r1, #7
	streqh r1, [ip, #0x3a]
	b _02169A7C
_02169A08:
	cmp r2, #3
	bls _02169A44
	ldr r4, _02169AE8 // =_mt_math_rand
	ldr r1, _02169AEC // =0x00196225
	ldr r5, [r4, #0]
	ldr r2, _02169AF0 // =0x3C6EF35F
	mla r2, r5, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	tst r1, #7
	str r2, [r4]
	moveq r1, #7
	streqh r1, [ip, #0x3a]
	b _02169A7C
_02169A44:
	cmp r2, #2
	bls _02169A7C
	ldr r4, _02169AE8 // =_mt_math_rand
	ldr r1, _02169AEC // =0x00196225
	ldr r5, [r4, #0]
	ldr r2, _02169AF0 // =0x3C6EF35F
	mla r2, r5, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	tst r1, #0xf
	str r2, [r4]
	moveq r1, #7
	streqh r1, [ip, #0x3a]
_02169A7C:
	add r1, r0, #0x500
	ldrh r2, [r1, #0x3a]
	cmp r2, #7
	moveq r2, #0
	streqh r2, [r1, #0x46]
	add r1, r0, #0x500
	ldrh r2, [r1, #0x3a]
	add r0, r0, #0x500
	cmp r2, #7
	movne r2, #0
	strneh r2, [r1, #0x44]
	ldrh r1, [r0, #0x3a]
	cmp r1, #7
	ldmhsia sp!, {r4, r5, r6, pc}
	strh r1, [r0, #0x3e]
	ldrh r0, [r0, #0x3a]
	cmp r0, #1
	ldmeqia sp!, {r4, r5, r6, pc}
	add r0, r3, #0x100
	ldrh r1, [r0, #0x8c]
	add r1, r1, #1
	strh r1, [r0, #0x8c]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02169AD8: .word gPlayer
_02169ADC: .word ovl02_21730A4
_02169AE0: .word ovl02_217344C
_02169AE4: .word ovl02_216B6CC
_02169AE8: .word _mt_math_rand
_02169AEC: .word 0x00196225
_02169AF0: .word 0x3C6EF35F
_02169AF4: .word _021790F8
	arm_func_end ovl02_2169868

	arm_func_start ovl02_2169AF8
ovl02_2169AF8: // 0x02169AF8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r1, _02169E08 // =gPlayer
	ldr r3, [r0, #0x384]
	ldr r2, [r0, #0x36c]
	ldr r4, [r1, #0]
	ldr r1, [r2, #0x124]
	tst r3, #0x10
	bicne r3, r3, #6
	strne r3, [r0, #0x384]
	ldr r6, [r0, #0x384]
	mov r2, #0
	tst r6, #2
	beq _02169B54
	ldr r5, [r0, #0x370]
	ldr r3, _02169E0C // =ovl02_2172CA0
	ldr r5, [r5, #0xf4]
	cmp r5, r3
	bne _02169B54
	bic r3, r6, #2
	str r3, [r0, #0x384]
	add r3, r0, #0x500
	mov r5, #0xb4
	strh r5, [r3, #0x4a]
_02169B54:
	ldr r6, [r0, #0x384]
	tst r6, #4
	beq _02169B88
	ldr r5, [r0, #0x374]
	ldr r3, _02169E0C // =ovl02_2172CA0
	ldr r5, [r5, #0xf4]
	cmp r5, r3
	bne _02169B88
	bic r3, r6, #4
	str r3, [r0, #0x384]
	add r3, r0, #0x500
	mov r5, #0xb4
	strh r5, [r3, #0x48]
_02169B88:
	ldr r7, [r0, #0x384]
	ldr r3, _02169E08 // =gPlayer
	mov ip, #0
	mov lr, ip
	tst r7, #2
	ldr r3, [r3, #0]
	beq _02169BC0
	ldr r6, [r0, #0x370]
	ldr r5, _02169E0C // =ovl02_2172CA0
	ldr r6, [r6, #0xf4]
	cmp r6, r5
	ldrne r5, _02169E10 // =ovl02_2172D10
	cmpne r6, r5
	movne ip, #1
_02169BC0:
	tst r7, #4
	beq _02169BE4
	ldr r6, [r0, #0x374]
	ldr r5, _02169E0C // =ovl02_2172CA0
	ldr r6, [r6, #0xf4]
	cmp r6, r5
	ldrne r5, _02169E10 // =ovl02_2172D10
	cmpne r6, r5
	movne lr, #1
_02169BE4:
	cmp ip, #0
	cmpne lr, #0
	ldr r5, [r3, #0x18]
	beq _02169C00
	bic r5, r5, #1
	str r5, [r3, #0x18]
	b _02169C40
_02169C00:
	orr r5, r5, #1
	cmp ip, #0
	str r5, [r3, #0x18]
	beq _02169C24
	ldr ip, [r3, #0x44]
	cmp ip, #0x178000
	ldrlt ip, [r3, #0x18]
	biclt ip, ip, #1
	strlt ip, [r3, #0x18]
_02169C24:
	cmp lr, #0
	beq _02169C40
	ldr ip, [r3, #0x44]
	cmp ip, #0x178000
	ldrgt ip, [r3, #0x18]
	bicgt ip, ip, #1
	strgt ip, [r3, #0x18]
_02169C40:
	ldr r3, [r0, #0x384]
	tst r3, #0x10
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	add r3, r0, #0x500
	ldrsh ip, [r3, #0x4c]
	cmp ip, #0
	subne ip, ip, #1
	strneh ip, [r3, #0x4c]
	add r3, r0, #0x500
	ldrsh ip, [r3, #0x4a]
	cmp ip, #0
	subne ip, ip, #1
	strneh ip, [r3, #0x4a]
	add r3, r0, #0x500
	ldrsh ip, [r3, #0x48]
	cmp ip, #0
	subne ip, ip, #1
	strneh ip, [r3, #0x48]
	add r3, r0, #0x500
	ldrh r3, [r3, #0x36]
	cmp r3, #2
	bhs _02169CA4
	ldr r3, [r0, #0x384]
	tst r3, #6
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
_02169CA4:
	mov r5, #0
_02169CA8:
	add r3, r1, r5, lsl #2
	ldr r3, [r3, #0x10]
	cmp r3, #0
	movne r2, r3
	add r3, r5, #1
	mov r3, r3, lsl #0x10
	mov r5, r3, lsr #0x10
	cmp r5, #4
	blo _02169CA8
	add r3, r0, #0x500
	ldrsh r1, [r3, #0x4c]
	cmp r1, #0
	cmpeq r2, #0
	bne _02169CF4
	ldr r1, [r4, #0x5d8]
	tst r1, #0x200000
	ldreq r1, [r4, #0x4c]
	cmpeq r1, #0
	beq _02169D0C
_02169CF4:
	ldr r1, [r4, #0x4c]
	cmp r1, #0
	addne r0, r0, #0x500
	movne r1, #0x64
	strneh r1, [r0, #0x4c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02169D0C:
	ldrsh r1, [r3, #0x4e]
	cmp r1, #3
	bge _02169D44
	ldr r4, _02169E14 // =_mt_math_rand
	ldr r1, _02169E18 // =0x00196225
	ldr ip, [r4]
	ldr r2, _02169E1C // =0x3C6EF35F
	mla r2, ip, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r2, [r4]
	tst r1, #1
	bne _02169DDC
_02169D44:
	ldr r1, [r0, #0x384]
	tst r1, #2
	movne r1, #0
	bne _02169D88
	tst r1, #4
	movne r1, #1
	bne _02169D88
	ldr r3, _02169E14 // =_mt_math_rand
	ldr r1, _02169E18 // =0x00196225
	ldr r4, [r3, #0]
	ldr r2, _02169E1C // =0x3C6EF35F
	mla r2, r4, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #1
	str r2, [r3]
_02169D88:
	cmp r1, #0
	add r1, r0, #0x500
	beq _02169DB8
	ldrsh r2, [r1, #0x4a]
	cmp r2, #0
	bne _02169DE8
	ldr r3, [r0, #0x384]
	mov r2, #0
	orr r3, r3, #2
	str r3, [r0, #0x384]
	strh r2, [r1, #0x4e]
	b _02169DE8
_02169DB8:
	ldrsh r2, [r1, #0x48]
	cmp r2, #0
	bne _02169DE8
	ldr r3, [r0, #0x384]
	mov r2, #0
	orr r3, r3, #4
	str r3, [r0, #0x384]
	strh r2, [r1, #0x4e]
	b _02169DE8
_02169DDC:
	ldrsh r1, [r3, #0x4e]
	add r1, r1, #1
	strh r1, [r3, #0x4e]
_02169DE8:
	mov r3, #0x5a
	add r1, r0, #0x500
	strh r3, [r1, #0x4c]
	ldrh r2, [r1, #0x36]
	sub r0, r3, #0x64
	mla r0, r2, r0, r3
	strh r0, [r1, #0x4c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02169E08: .word gPlayer
_02169E0C: .word ovl02_2172CA0
_02169E10: .word ovl02_2172D10
_02169E14: .word _mt_math_rand
_02169E18: .word 0x00196225
_02169E1C: .word 0x3C6EF35F
	arm_func_end ovl02_2169AF8

	arm_func_start ovl02_2169E20
ovl02_2169E20: // 0x02169E20
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl MapFarSys__GetAsset
	str r0, [r4]
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2169E20

	arm_func_start ovl02_2169E34
ovl02_2169E34: // 0x02169E34
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, _02169EB4 // =BossFStage__Singleton
	mov r4, r0
	ldr r0, [r2, #0]
	mov r5, r1
	bl GetTaskWork_
	ldr r1, [r0, #0x378]
	ldr r0, _02169EB8 // =ovl02_216A460
	cmp r1, r0
	bne _02169E6C
	ldr r0, [r4, #0x20]
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	ldmia sp!, {r3, r4, r5, pc}
_02169E6C:
	cmp r5, #0
	bne _02169E94
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldr r0, [r4, #0x20]
	bicne r0, r0, #0x20
	strne r0, [r4, #0x20]
	orreq r0, r0, #0x20
	streq r0, [r4, #0x20]
	ldmia sp!, {r3, r4, r5, pc}
_02169E94:
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldr r0, [r4, #0x20]
	orrne r0, r0, #0x20
	strne r0, [r4, #0x20]
	biceq r0, r0, #0x20
	streq r0, [r4, #0x20]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02169EB4: .word BossFStage__Singleton
_02169EB8: .word ovl02_216A460
	arm_func_end ovl02_2169E34

	arm_func_start ovl02_2169EBC
ovl02_2169EBC: // 0x02169EBC
	stmdb sp!, {r4, lr}
	ldr r1, _02169EF0 // =BossFStage__Singleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0x36c]
	ldr r0, [r0, #0x124]
	ldr r1, [r0, #0x210]
	ldr r2, [r0, #0x214]
	ldr r0, [r0, #0x20c]
	rsb r1, r1, #0
	stmia r4, {r0, r1, r2}
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169EF0: .word BossFStage__Singleton
	arm_func_end ovl02_2169EBC

	arm_func_start ovl02_2169EF4
ovl02_2169EF4: // 0x02169EF4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r0, _02169F7C // =BossFStage__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r7, r0
	ldr r0, [r7, #0x384]
	add r1, r7, #0x500
	orr r0, r0, #0x100
	str r0, [r7, #0x384]
	ldr r2, [r7, #0x590]
	add r0, r7, #0x550
	mov r2, r2, asr #0xc
	strh r2, [r1, #0x80]
	bl BossHelpers__ProcessLights
	mov r8, #0
	mov r6, #5
	mov r5, r8
	mvn r4, #3
_02169F3C:
	add r0, r7, r8, lsl #3
	add r0, r0, #0x500
	ldrh r0, [r0, #0x6e]
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl ObjDraw__TintColor
	add r1, r8, #1
	add r3, r7, r8, lsl #3
	mov r2, r1, lsl #0x10
	add r1, r3, #0x500
	mov r8, r2, lsr #0x10
	arm_func_end ovl02_2169EF4

	arm_func_start ovl02_2169F6C
ovl02_2169F6C: // 0x02169F6C
	strh r0, [r1, #0x6e]
	cmp r8, #3
	blo _02169F3C
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02169F7C: .word BossFStage__Singleton
	arm_func_end ovl02_2169F6C

	arm_func_start ovl02_2169F80
ovl02_2169F80: // 0x02169F80
	stmdb sp!, {r4, lr}
	ldr r0, _02169FE0 // =BossFStage__Singleton
	ldr r4, _02169FE4 // =_02179010
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _02169FE8 // =gameState
	add r0, r0, #0x300
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r1, [r1, #0x70]
	ldrsh r2, [r0, #0x7c]
	cmpeq r1, #0xf
	ldreq r4, _02169FEC // =_02179008
	mov r0, #0
_02169FB8:
	mov r1, r0, lsl #1
	ldrsh r1, [r4, r1]
	cmp r1, r2
	ldmleia sp!, {r4, pc}
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #4
	blo _02169FB8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169FE0: .word BossFStage__Singleton
_02169FE4: .word _02179010
_02169FE8: .word gameState
_02169FEC: .word _02179008
	arm_func_end ovl02_2169F80

	arm_func_start ovl02_2169FF0
ovl02_2169FF0: // 0x02169FF0
	stmdb sp!, {r4, lr}
	ldr r1, _0216A010 // =BossFStage__Singleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	add r0, r0, #0x500
	strh r4, [r0, #0x34]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216A010: .word BossFStage__Singleton
	arm_func_end ovl02_2169FF0

	arm_func_start ovl02_216A014
ovl02_216A014: // 0x0216A014
	stmdb sp!, {r4, lr}
	ldr r1, _0216A030 // =BossFStage__Singleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	str r4, [r0, #0x530]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216A030: .word BossFStage__Singleton
	arm_func_end ovl02_216A014

	arm_func_start ovl02_216A034
ovl02_216A034: // 0x0216A034
	stmdb sp!, {r4, lr}
	ldr r1, _0216A050 // =BossFStage__Singleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	str r4, [r0, #0x524]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216A050: .word BossFStage__Singleton
	arm_func_end ovl02_216A034

	arm_func_start ovl02_216A054
ovl02_216A054: // 0x0216A054
	ldr r0, _0216A06C // =gameState
	ldr r1, _0216A070 // =_02178FF0
	ldr r0, [r0, #0x18]
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_0216A06C: .word gameState
_0216A070: .word _02178FF0
	arm_func_end ovl02_216A054

	arm_func_start ovl02_216A074
ovl02_216A074: // 0x0216A074
	ldr r0, _0216A08C // =gameState
	ldr r1, _0216A090 // =_02178FE8
	ldr r0, [r0, #0x18]
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_0216A08C: .word gameState
_0216A090: .word _02178FE8
	arm_func_end ovl02_216A074

	arm_func_start ovl02_216A094
ovl02_216A094: // 0x0216A094
	ldr r0, _0216A0AC // =gameState
	ldr r1, _0216A0B0 // =_02178FEC
	ldr r0, [r0, #0x18]
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_0216A0AC: .word gameState
_0216A0B0: .word _02178FEC
	arm_func_end ovl02_216A094

	arm_func_start ovl02_216A0B4
ovl02_216A0B4: // 0x0216A0B4
	ldr r0, _0216A0CC // =gameState
	ldr r1, _0216A0D0 // =_02178FF4
	ldr r0, [r0, #0x18]
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_0216A0CC: .word gameState
_0216A0D0: .word _02178FF4
	arm_func_end ovl02_216A0B4

	arm_func_start ovl02_216A0D4
ovl02_216A0D4: // 0x0216A0D4
	ldr r0, _0216A11C // =gPlayer
	ldr r2, [r0, #0]
	ldr r1, [r2, #0x5d8]
	orr r1, r1, #0x40
	str r1, [r2, #0x5d8]
	ldr r2, [r0, #0]
	ldr r1, [r2, #0x5d8]
	orr r1, r1, #0x400000
	str r1, [r2, #0x5d8]
	ldr r2, [r0, #0]
	ldr r1, [r2, #0x1c]
	bic r1, r1, #0x200000
	str r1, [r2, #0x1c]
	ldr r1, [r0, #0]
	ldr r0, [r1, #0x1c]
	orr r0, r0, #0x200
	str r0, [r1, #0x1c]
	bx lr
	.align 2, 0
_0216A11C: .word gPlayer
	arm_func_end ovl02_216A0D4

	arm_func_start ovl02_216A120
ovl02_216A120: // 0x0216A120
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x2c
	ldr r1, _0216A444 // =_0217903C
	add r3, sp, #0
	mov r5, r0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #4
	bl BossArena__SetType
	ldr r0, _0216A448 // =0x00001555
	bl BossArena__SetField35C
	add r0, sp, #0xc
	mov r1, #0
	mov r2, #0x20
	bl MI_CpuFill8
	ldr r1, _0216A44C // =0x00000E38
	mov r0, #0x1000
	str r0, [sp, #0x10]
	sub r0, r0, #0x334
	strh r1, [sp, #0xc]
	str r0, [sp, #0x1c]
	mov r0, #0x800000
	ldr r1, _0216A448 // =0x00001555
	str r0, [sp, #0x14]
	mov r0, #1
	str r1, [sp, #0x18]
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #0
	bl BossArena__SetCameraType
	mov r0, r4
	add r1, sp, #0xc
	bl BossArena__SetCameraConfig
	mov r0, #0
	bl ovl02_216AA74
	mov r1, r0
	mov r0, r4
	mov r2, r1
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	mov r0, #1
	bl ovl02_216AA74
	mov r1, r0
	mov r0, r4
	mov r2, r1
	mov r3, r1
	bl BossArena__SetTracker0TargetWork
	mov r0, r4
	add r1, sp, #0
	bl BossArena__SetUpVector
	mov r0, r4
	bl BossArena__UpdateTracker0TargetPos
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #0
	bl BossArena__SetCameraType
	mov r0, r4
	add r1, sp, #0xc
	bl BossArena__SetCameraConfig
	mov r0, #2
	bl ovl02_216AA74
	mov r1, r0
	mov r0, r4
	mov r2, r1
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	mov r0, #3
	bl ovl02_216AA74
	mov r1, r0
	mov r0, r4
	mov r2, r1
	mov r3, r1
	bl BossArena__SetTracker0TargetWork
	add r1, sp, #0
	mov r0, r4
	bl BossArena__SetUpVector
	mov r0, r4
	bl BossArena__UpdateTracker0TargetPos
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	ldr r2, _0216A450 // =0x0400000A
	mov r0, #2
	ldrh r1, [r2, #0]
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
	ldr r2, _0216A454 // =VRAMSystem__VRAM_BG
	mov r1, #0
	ldr r2, [r2, #0]
	add r2, r2, #0x4000
	bl LoadCompressedPixels
	ldr r0, [r5, #0x364]
	bl GetBackgroundPalette
	ldr r2, _0216A458 // =VRAMSystem__VRAM_PALETTE_BG
	mov r1, #0
	ldr r2, [r2, #0]
	bl LoadCompressedPalette
	ldr r0, [r5, #0x504]
	ldr r1, [r5, #0x508]
	mov r0, r0, lsl #4
	mov r1, r1, lsl #4
	mov r0, r0, asr #0x10
	mov r1, r1, asr #0x10
	bl BossArena__Func_2039A94
	mov r2, #0x4000000
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #2
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
	bic r1, r1, #1
	orr r1, r1, #1
	strh r1, [r0, #0x7c]
	ldrh r2, [r0, #0x7c]
	ldrh r3, [r4, #0x20]
	ldr r1, _0216A45C // =ovl02_216A460
	mov r2, r2, lsl #0x1f
	mov r2, r2, lsr #0x1f
	bic r3, r3, #1
	and r2, r2, #1
	orr r2, r3, r2
	strh r2, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	orr r2, r2, #0x200
	strh r2, [r0, #0x7c]
	ldrh r2, [r0, #0x7c]
	ldrh r3, [r4, #0x20]
	mov r2, r2, lsl #0x16
	mov r2, r2, lsr #0x1f
	bic r3, r3, #0x200
	mov r2, r2, lsl #0x1f
	orr r2, r3, r2, lsr #22
	strh r2, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	orr r2, r2, #0x400
	strh r2, [r0, #0x7c]
	ldrh r2, [r0, #0x7c]
	ldrh r3, [r4, #0x20]
	mov r2, r2, lsl #0x15
	mov r2, r2, lsr #0x1f
	bic r3, r3, #0x400
	mov r2, r2, lsl #0x1f
	orr r2, r3, r2, lsr #21
	strh r2, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	orr r2, r2, #0x800
	strh r2, [r0, #0x7c]
	ldrh r2, [r0, #0x7c]
	ldrh r3, [r4, #0x20]
	mov r2, r2, lsl #0x14
	mov r2, r2, lsr #0x1f
	bic r3, r3, #0x800
	mov r2, r2, lsl #0x1f
	orr r2, r3, r2, lsr #20
	strh r2, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	orr r2, r2, #0x1000
	strh r2, [r0, #0x7c]
	ldrh r0, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r0, r0, lsl #0x13
	mov r0, r0, lsr #0x1f
	bic r2, r2, #0x1000
	mov r0, r0, lsl #0x1f
	orr r0, r2, r0, lsr #19
	strh r0, [r4, #0x20]
	str r1, [r5, #0x378]
	bl ovl02_216A0D4
	add r0, r5, #0x300
	ldrsh r0, [r0, #0x7c]
	bl UpdateBossHealthHUD
	mov r0, #1
	bl SetHUDActiveScreen
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216A444: .word _0217903C
_0216A448: .word 0x00001555
_0216A44C: .word 0x00000E38
_0216A450: .word 0x0400000A
_0216A454: .word VRAMSystem__VRAM_BG
_0216A458: .word VRAMSystem__VRAM_PALETTE_BG
_0216A45C: .word ovl02_216A460
	arm_func_end ovl02_216A120

	arm_func_start ovl02_216A460
ovl02_216A460: // 0x0216A460
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x2c
	mov r4, r0
	bl TitleCard__GetProgress
	cmp r0, #3
	addne sp, sp, #0x2c
	ldmneia sp!, {r4, r5, pc}
	ldr r0, _0216A6AC // =_0217909C
	add r3, sp, #0x20
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, sp, #0
	mov r1, #0
	mov r2, #0x20
	bl MI_CpuFill8
	mov r5, #0x1000
	ldr ip, _0216A6B0 // =0x00000E38
	ldr r2, _0216A6B4 // =0x00001555
	sub r1, r5, #0x334
	mov r3, #0x800000
	mov r0, #1
	strh ip, [sp]
	str r5, [sp, #4]
	str r3, [sp, #8]
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	bl BossArena__GetCamera
	mov r1, #1
	mov r5, r0
	bl BossArena__SetCameraType
	mov r0, r5
	add r1, sp, #0
	bl BossArena__SetCameraConfig
	ldr r3, _0216A6B8 // =gPlayer
	mov r1, #0
	ldr r3, [r3, #0]
	mov r0, r5
	mov r2, r1
	bl BossArena__SetTracker1TargetWork
	ldr r2, _0216A6BC // =0xFFA94000
	mov r0, r5
	mov r1, #0x178000
	mov r3, #0
	bl BossArena__SetTracker1TargetPos
	mov r0, r5
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r5
	mov r1, #1
	bl BossArena__SetTracker1UseObj3D
	mov r0, r5
	mov r1, #0x12c000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r5
	mov r1, #0xcc
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r5
	bl BossArena__ApplyAmplitudeXZTarget
	ldr r1, [r4, #0x514]
	mov r0, r5
	bl BossArena__SetAmplitudeYTarget
	mov r0, r5
	mov r1, #0xcc
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r5
	bl BossArena__ApplyAmplitudeYTarget
	mov r0, r5
	mov r1, #0
	bl BossArena__SetAngleTarget
	mov r0, r5
	mov r1, #0xcc
	bl BossArena__SetAngleSpeed
	mov r0, r5
	bl BossArena__ApplyAngleTarget
	mov r0, r5
	add r1, sp, #0x20
	bl BossArena__SetUpVector
	bl BossArena__Func_20397E4
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	mov r0, #2
	bl BossArena__GetCamera
	mov r1, #1
	mov r5, r0
	bl BossArena__SetCameraType
	add r1, sp, #0
	mov r0, r5
	bl BossArena__SetCameraConfig
	ldr r1, _0216A6B8 // =gPlayer
	mov r0, r5
	ldr r3, [r1, #0]
	mov r1, #0
	mov r2, r1
	bl BossArena__SetTracker1TargetWork
	mov r1, #0x178000
	mov r0, r5
	sub r2, r1, #0x860000
	mov r3, #0
	bl BossArena__SetTracker1TargetPos
	mov r0, r5
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r5
	mov r1, #1
	bl BossArena__SetTracker1UseObj3D
	mov r0, r5
	mov r1, #0x12c000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r5
	mov r1, #0xcc
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r5
	bl BossArena__ApplyAmplitudeXZTarget
	ldr r1, [r4, #0x518]
	mov r0, r5
	bl BossArena__SetAmplitudeYTarget
	mov r0, r5
	mov r1, #0xcc
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r5
	bl BossArena__ApplyAmplitudeYTarget
	mov r0, r5
	mov r1, #0
	bl BossArena__SetAngleTarget
	mov r0, r5
	mov r1, #0xcc
	bl BossArena__SetAngleSpeed
	mov r0, r5
	bl BossArena__ApplyAngleTarget
	mov r0, r5
	add r1, sp, #0x20
	bl BossArena__SetUpVector
	bl BossArena__Func_20397E4
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	mov r0, #1
	bl BossArena__GetCamera
	ldr r0, _0216A6C0 // =ovl02_216A6C4
	str r0, [r4, #0x378]
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216A6AC: .word _0217909C
_0216A6B0: .word 0x00000E38
_0216A6B4: .word 0x00001555
_0216A6B8: .word gPlayer
_0216A6BC: .word 0xFFA94000
_0216A6C0: .word ovl02_216A6C4
	arm_func_end ovl02_216A460

	arm_func_start ovl02_216A6C4
ovl02_216A6C4: // 0x0216A6C4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldr r1, _0216AA5C // =gPlayer
	mov r8, r0
	ldr r0, [r8, #0x36c]
	ldr r7, [r1, #0]
	ldr r3, [r8, #0x384]
	ldr r0, [r0, #0x124]
	ands r2, r3, #2
	ldr r4, [r8, #0x530]
	ldr r6, [r7, #0x44]
	mov r1, #0
	mov r5, #0x12c000
	beq _0216A700
	tst r3, #4
	movne r1, #1
_0216A700:
	ldr r0, [r0, #0x20]
	tst r0, #0x40
	ldr r0, [r7, #0x5d8]
	movne r1, #1
	tst r0, #0x200000
	ldreq r0, [r7, #0x4c]
	cmpeq r0, #0
	movne r1, #1
	tst r3, #0x10
	movne r1, #1
	cmp r1, #0
	bne _0216A82C
	cmp r2, #0
	mov r2, #0x38000
	beq _0216A7AC
	ldr r1, [r8, #0x370]
	ldr r0, _0216AA60 // =ovl02_21730A4
	ldr r1, [r1, #0xf4]
	cmp r1, r0
	ldr r0, _0216AA64 // =ovl02_21736C8
	moveq r2, #0x6e000
	cmp r1, r0
	ldrne r0, _0216AA68 // =ovl02_2173C9C
	cmpne r1, r0
	moveq r2, #0
	sub r0, r6, r2
	cmp r0, #0xb4000
	bge _0216A780
	rsb r0, r6, #0xb4000
	cmp r0, #0
	movgt r0, #0
	rsb r2, r0, #0
_0216A780:
	cmp r2, #0
	mov r1, #0x1800
	ldr r0, [r8, #0x51c]
	beq _0216A7A0
	rsb r1, r1, #0
	bl ObjSpdUpSet
	str r0, [r8, #0x51c]
	b _0216A83C
_0216A7A0:
	bl ObjSpdDownSet
	str r0, [r8, #0x51c]
	b _0216A83C
_0216A7AC:
	tst r3, #4
	beq _0216A818
	ldr r1, [r8, #0x374]
	ldr r0, _0216AA60 // =ovl02_21730A4
	ldr r1, [r1, #0xf4]
	cmp r1, r0
	ldr r0, _0216AA64 // =ovl02_21736C8
	moveq r2, #0x6e000
	cmp r1, r0
	ldrne r0, _0216AA68 // =ovl02_2173C9C
	cmpne r1, r0
	moveq r2, #0
	add r0, r6, r2
	cmp r0, #0x23c000
	ble _0216A7F0
	rsbs r2, r6, #0x23c000
	movmi r2, #0
_0216A7F0:
	cmp r2, #0
	ldr r0, [r8, #0x51c]
	mov r1, #0x1800
	beq _0216A80C
	bl ObjSpdUpSet
	str r0, [r8, #0x51c]
	b _0216A83C
_0216A80C:
	bl ObjSpdDownSet
	str r0, [r8, #0x51c]
	b _0216A83C
_0216A818:
	ldr r0, [r8, #0x51c]
	mov r1, #0x1800
	bl ObjSpdDownSet
	str r0, [r8, #0x51c]
	b _0216A83C
_0216A82C:
	ldr r0, [r8, #0x51c]
	mov r1, #0x1800
	bl ObjSpdDownSet
	str r0, [r8, #0x51c]
_0216A83C:
	ldr r1, [r8, #0x51c]
	ldr r0, [r8, #0x530]
	mov r7, #0x8e000
	cmp r0, #0
	add r6, r6, r1
	add r1, r7, #0x1d4000
	beq _0216A894
	mov r1, #0x200000
	bl FX_Div
	rsb r7, r0, #0x1000
	mov r0, #0xea000
	umull r3, r2, r7, r0
	mov r1, #0
	adds r3, r3, #0x800
	mla r2, r7, r1, r2
	mov r1, r7, asr #0x1f
	mla r2, r1, r0, r2
	adc r0, r2, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	rsb r7, r1, #0x178000
	add r1, r1, #0x178000
_0216A894:
	cmp r6, r7
	blt _0216A8A8
	cmp r6, r1
	movle r1, r6
	mov r7, r1
_0216A8A8:
	ldr r0, _0216AA5C // =gPlayer
	mov r6, #0
	ldr r0, [r0, #0]
	ldr r1, [r8, #0x520]
	ldr r0, [r0, #0x48]
	cmp r0, #0x560000
	rsblt r6, r0, #0x560000
	ldr r0, [r8, #0x524]
	subs r0, r0, r1
	beq _0216A91C
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x100
	strle r1, [r8, #0x524]
	ldr r0, [r8, #0x520]
	ldr r1, [r8, #0x524]
	mov r2, #0
	sub r3, r1, r0
	mov r1, #0xcc
	umull r10, r9, r3, r1
	mla r9, r3, r2, r9
	mov r2, r3, asr #0x1f
	mla r9, r2, r1, r9
	adds r3, r10, #0x800
	adc r1, r9, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r0, r0, r2
	str r0, [r8, #0x520]
_0216A91C:
	ldr r1, [r8, #0x520]
	ldr r2, [r8, #0x528]
	ldr r0, [r8, #0x52c]
	add r6, r6, r1
	subs r0, r0, r2
	beq _0216A980
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x100
	strle r2, [r8, #0x52c]
	ldr r0, [r8, #0x528]
	ldr r1, [r8, #0x52c]
	mov r2, #0
	sub r3, r1, r0
	mov r1, #0xcc
	umull r10, r9, r3, r1
	mla r9, r3, r2, r9
	mov r2, r3, asr #0x1f
	mla r9, r2, r1, r9
	adds r3, r10, #0x800
	adc r1, r9, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r0, r0, r2
	str r0, [r8, #0x528]
_0216A980:
	mov r0, #1
	bl BossArena__GetCamera
	ldr r1, _0216AA6C // =0xFFA94000
	ldr r2, [r8, #0x528]
	add r3, r6, r1
	mov r1, r7
	add r2, r3, r2
	mov r3, #0
	mov r9, r0
	bl BossArena__SetTracker1TargetPos
	ldr r1, [r8, #0x514]
	mov r0, r9
	bl BossArena__SetAmplitudeYTarget
	mov r0, r9
	add r1, r8, #0x500
	ldrh r1, [r1, #0x34]
	bl BossArena__SetAngleTarget
	mov r0, r9
	add r1, r5, r4
	bl BossArena__SetAmplitudeXZTarget
	bl GetScreenShakeOffsetX
	mov r10, r0
	bl GetScreenShakeOffsetY
	mov r1, r10
	mov r2, r0
	mov r0, r9
	mov r3, #0
	bl BossArena__SetNextPos
	mov r0, #2
	bl BossArena__GetCamera
	mov r1, r7
	mov r7, r0
	ldr r2, _0216AA70 // =0xFF918000
	mov r3, #0
	add r2, r6, r2
	bl BossArena__SetTracker1TargetPos
	mov r0, r7
	ldr r1, [r8, #0x518]
	bl BossArena__SetAmplitudeYTarget
	add r0, r8, #0x500
	ldrh r1, [r0, #0x34]
	mov r0, r7
	bl BossArena__SetAngleTarget
	add r1, r5, r4
	mov r0, r7
	bl BossArena__SetAmplitudeXZTarget
	bl GetScreenShakeOffsetX
	mov r4, r0
	bl GetScreenShakeOffsetY
	mov r1, r4
	mov r2, r0
	mov r0, r7
	mov r3, #0
	bl BossArena__SetNextPos
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0216AA5C: .word gPlayer
_0216AA60: .word ovl02_21730A4
_0216AA64: .word ovl02_21736C8
_0216AA68: .word ovl02_2173C9C
_0216AA6C: .word 0xFFA94000
_0216AA70: .word 0xFF918000
	arm_func_end ovl02_216A6C4

	arm_func_start ovl02_216AA74
ovl02_216AA74: // 0x0216AA74
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #0x1a00
	mov r1, #4
	bl CreateStageTaskEx_
	mov r4, r0
	mov r1, #5
	bl StageTask__SetType
	ldr r1, [r4, #0x18]
	mov r0, r4
	orr r1, r1, #2
	str r1, [r4, #0x18]
	ldr r2, [r4, #0x20]
	mov r1, #0
	orr r2, r2, #0x180
	str r2, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	orr r2, r2, #0x100
	str r2, [r4, #0x1c]
	bl StageTask__InitExWork
	cmp r5, #3
	addls pc, pc, r5, lsl #2
	b _0216AB7C
_0216AAD0: // jump table
	b _0216AAE0 // case 0
	b _0216AB08 // case 1
	b _0216AB30 // case 2
	b _0216AB58 // case 3
_0216AAE0:
	mov r1, #0x178000
	str r1, [r4, #0x44]
	add r0, r1, #0x5a0000
	str r0, [r4, #0x48]
	sub r0, r1, #0x240000
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x140]
	ldr r1, _0216AB8C // =_02179118
	bl ObjExWork__Func_2076EE4
	b _0216AB7C
_0216AB08:
	mov r1, #0x1dc000
	ldr r0, _0216AB90 // =0x00768000
	str r1, [r4, #0x44]
	str r0, [r4, #0x48]
	mov r0, #0x14000
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x140]
	ldr r1, _0216AB94 // =_02179188
	bl ObjExWork__Func_2076EE4
	b _0216AB7C
_0216AB30:
	mov r1, #0x78000
	ldr r0, _0216AB98 // =0x006DC000
	str r1, [r4, #0x44]
	str r0, [r4, #0x48]
	mov r0, #0xfa000
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x140]
	ldr r1, _0216AB9C // =_021791F8
	bl ObjExWork__Func_2076EE4
	b _0216AB7C
_0216AB58:
	mov r0, #0x3c000
	str r0, [r4, #0x44]
	add r0, r0, #0x6a0000
	str r0, [r4, #0x48]
	mov r0, #0x2bc000
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x140]
	ldr r1, _0216ABA0 // =_02179268
	bl ObjExWork__Func_2076EE4
_0216AB7C:
	ldr r1, _0216ABA4 // =ovl02_216ABA8
	mov r0, r4
	str r1, [r4, #0xf4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216AB8C: .word _02179118
_0216AB90: .word 0x00768000
_0216AB94: .word _02179188
_0216AB98: .word 0x006DC000
_0216AB9C: .word _021791F8
_0216ABA0: .word _02179268
_0216ABA4: .word ovl02_216ABA8
	arm_func_end ovl02_216AA74

	arm_func_start ovl02_216ABA8
ovl02_216ABA8: // 0x0216ABA8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ExWork__Func_2076D90
	bl TitleCard__GetProgress
	cmp r0, #3
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #4
	streq r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_216ABA8

	arm_func_start ovl02_216ABCC
ovl02_216ABCC: // 0x0216ABCC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r0, #0x1500
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r1, #6
	bl StageTask__SetType
	ldr r0, [r4, #0x120]
	mov r1, #0
	bl SetTaskPauseLevel
	ldr r0, [r4, #0x120]
	ldr r1, _0216ACB8 // =ovl02_216ACCC
	bl SetTaskDestructorEvent
	mov r1, #0
	str r1, [sp]
	ldr r2, _0216ACBC // =gameArchiveStage
	mov r0, r4
	ldr r3, [r2, #0]
	ldr r2, _0216ACC0 // =aBossfStageNsbm_0
	str r3, [sp, #4]
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r1, #4
	ldr r0, [r4, #0x12c]
	mov r2, #0
	strb r1, [r0, #0xa]
	ldr r1, [r4, #0x12c]
	ldr r0, _0216ACC0 // =aBossfStageNsbm_0
	strb r2, [r1, #0xb]
	ldr r1, _0216ACBC // =gameArchiveStage
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, [r4, #0x18]
	mov r2, #0x178000
	orr r0, r0, #0x12
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	mov r1, #0x740000
	orr r0, r0, #0x180
	str r0, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	mov r0, #0
	orr r3, r3, #0x2100
	str r3, [r4, #0x1c]
	str r2, [r4, #0x44]
	str r1, [r4, #0x48]
	str r0, [r4, #0x4c]
	ldr r2, [r4, #0x12c]
	ldr r1, _0216ACC4 // =0x000034CC
	ldr r0, _0216ACC8 // =ovl02_216ACFC
	str r1, [r2, #0x18]
	str r1, [r2, #0x1c]
	str r1, [r2, #0x20]
	str r0, [r4, #0xf4]
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216ACB8: .word ovl02_216ACCC
_0216ACBC: .word gameArchiveStage
_0216ACC0: .word aBossfStageNsbm_0
_0216ACC4: .word 0x000034CC
_0216ACC8: .word ovl02_216ACFC
	arm_func_end ovl02_216ABCC

	arm_func_start ovl02_216ACCC
ovl02_216ACCC: // 0x0216ACCC
	stmdb sp!, {r4, lr}
	ldr r1, _0216ACF4 // =gameArchiveStage
	mov r4, r0
	ldr r1, [r1, #0]
	ldr r0, _0216ACF8 // =aBossfStageNsbm_0
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	mov r0, r4
	bl StageTask_Destructor
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216ACF4: .word gameArchiveStage
_0216ACF8: .word aBossfStageNsbm_0
	arm_func_end ovl02_216ACCC

	arm_func_start ovl02_216ACFC
ovl02_216ACFC: // 0x0216ACFC
	ldr ip, _0216AD08 // =ovl02_2169E34
	mov r1, #1
	bx ip
	.align 2, 0
_0216AD08: .word ovl02_2169E34
	arm_func_end ovl02_216ACFC

	arm_func_start ovl02_216AD0C
ovl02_216AD0C: // 0x0216AD0C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r1
	add r0, r5, #1
	add r0, r0, #0x1500
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r1, #6
	bl StageTask__SetType
	ldr r0, [r4, #0x120]
	mov r1, #0
	bl SetTaskPauseLevel
	mov r1, #0
	ldr r2, _0216AED0 // =gameArchiveStage
	str r1, [sp]
	ldr r3, [r2, #0]
	ldr r2, _0216AED4 // =aBossfEtcNsbmd_0
	str r3, [sp, #4]
	mov r0, r4
	mov r3, #2
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x12c]
	mov r2, #4
	strb r2, [r1, #0xa]
	ldr r1, [r4, #0x12c]
	mov r0, #0
	strb r0, [r1, #0xb]
	ldr r1, [r4, #0x18]
	cmp r5, #4
	orr r1, r1, #0x12
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x180
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	str r5, [r4, #0x24]
	addls pc, pc, r5, lsl #2
	b _0216ADCC
_0216ADB8: // jump table
	b _0216ADCC // case 0
	b _0216ADF0 // case 1
	b _0216AE14 // case 2
	b _0216AE38 // case 3
	b _0216AE5C // case 4
_0216ADCC:
	mov r1, #0xa8000
	ldr r0, _0216AED8 // =0x0076A000
	str r1, [r4, #0x44]
	str r0, [r4, #0x48]
	sub r0, r0, #0x8a0000
	str r0, [r4, #0x4c]
	mov r0, #0x120
	str r0, [r4, #0x2c]
	b _0216AE78
_0216ADF0:
	mov r1, #0x178000
	ldr r0, _0216AED8 // =0x0076A000
	str r1, [r4, #0x44]
	str r0, [r4, #0x48]
	sub r0, r1, #0x210000
	str r0, [r4, #0x4c]
	mov r0, #0x80
	str r0, [r4, #0x2c]
	b _0216AE78
_0216AE14:
	mov r1, #0x248000
	ldr r0, _0216AED8 // =0x0076A000
	str r1, [r4, #0x44]
	str r0, [r4, #0x48]
	sub r0, r0, #0x8a0000
	str r0, [r4, #0x4c]
	mov r0, #0x20
	str r0, [r4, #0x2c]
	b _0216AE78
_0216AE38:
	mov r1, #0xa8000
	mov r0, #0x6e0000
	str r1, [r4, #0x44]
	str r0, [r4, #0x48]
	rsb r0, r0, #0x31c000
	str r0, [r4, #0x4c]
	mov r0, #0x100
	str r0, [r4, #0x2c]
	b _0216AE78
_0216AE5C:
	mov r2, #0x248000
	mov r1, #0x6e0000
	str r2, [r4, #0x44]
	str r1, [r4, #0x48]
	rsb r1, r1, #0x31c000
	str r1, [r4, #0x4c]
	str r0, [r4, #0x2c]
_0216AE78:
	ldr r2, [r4, #0x12c]
	ldr r0, _0216AEDC // =0x000034CC
	mov r1, #0
	str r0, [r2, #0x18]
	str r0, [r2, #0x1c]
	str r0, [r2, #0x20]
	ldr r0, _0216AEE0 // =ovl02_216AEE4
	str r1, [r4, #0x28]
	str r0, [r4, #0xf4]
	ldr r0, [r4, #0x12c]
	ldr r1, [r4, #0x24]
	ldr r0, [r0, #0x94]
	add r1, r1, #0x14
	bl NNS_G3dMdlSetMdlPolygonIDAll
	ldr r0, [r4, #0x12c]
	ldr r1, [r4, #0x28]
	ldr r0, [r0, #0x94]
	mov r1, r1, lsr #0xc
	bl NNS_G3dMdlSetMdlAlphaAll
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216AED0: .word gameArchiveStage
_0216AED4: .word aBossfEtcNsbmd_0
_0216AED8: .word 0x0076A000
_0216AEDC: .word 0x000034CC
_0216AEE0: .word ovl02_216AEE4
	arm_func_end ovl02_216AD0C

	arm_func_start ovl02_216AEE4
ovl02_216AEE4: // 0x0216AEE4
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _0216B018 // =BossFStage__Singleton
	mov r5, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	ldr r1, [r5, #0x28]
	mov r4, r0
	cmp r1, #0
	bne _0216AF18
	ldr r0, [r5, #0x20]
	orr r0, r0, #0x20
	str r0, [r5, #0x20]
	b _0216AFA8
_0216AF18:
	ldr r0, [r5, #0x12c]
	ldr r1, [r5, #0x24]
	ldr r0, [r0, #0x94]
	add r1, r1, #0x14
	bl NNS_G3dMdlSetMdlPolygonIDAll
	ldr r0, [r5, #0x12c]
	ldr r1, [r5, #0x28]
	ldr r0, [r0, #0x94]
	mov r1, r1, lsr #0xc
	bl NNS_G3dMdlSetMdlAlphaAll
	ldr r1, [r5, #0x20]
	ldr r0, _0216B01C // =FX_SinCosTable_
	bic r1, r1, #0x20
	str r1, [r5, #0x20]
	ldr r1, [r5, #0x2c]
	add r2, r1, #1
	mov r1, r2, lsl #0x17
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r1, [r0, r1]
	str r2, [r5, #0x2c]
	strh r1, [r5, #0x34]
	ldrh r1, [r5, #0x34]
	ldr ip, [r5, #0x12c]
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r3, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r0, r3]
	ldrsh r2, [r0, r2]
	add r0, ip, #0x24
	bl MTX_RotZ33_
_0216AFA8:
	ldr r0, [r4, #0x384]
	mov r1, #0x400
	tst r0, #1
	ldr r0, [r5, #0x28]
	beq _0216AFCC
	mov r2, #0x10000
	bl ObjSpdUpSet
	str r0, [r5, #0x28]
	b _0216AFF0
_0216AFCC:
	bl ObjSpdDownSet
	str r0, [r5, #0x28]
	cmp r0, #0
	bne _0216AFF0
	ldr r0, [r4, #0x384]
	tst r0, #0x400
	ldrne r0, [r5, #0x18]
	orrne r0, r0, #4
	strne r0, [r5, #0x18]
_0216AFF0:
	ldr r0, [r5, #0x28]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x24]
	tst r0, #0x40
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	mov r1, #1
	bl ovl02_2169E34
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216B018: .word BossFStage__Singleton
_0216B01C: .word FX_SinCosTable_
	arm_func_end ovl02_216AEE4

	arm_func_start ovl02_216B020
ovl02_216B020: // 0x0216B020
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl GetTaskWork_
	ldr r0, [r0, #0x124]
	mov r5, #0
	add r4, r0, #0x2c
_0216B038:
	add r0, r4, r5, lsl #5
	bl ReleasePaletteAnimator
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #8
	blo _0216B038
	mov r0, r6
	bl GameObject__Destructor
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl02_216B020

	arm_func_start ovl02_216B060
ovl02_216B060: // 0x0216B060
	stmdb sp!, {lr}
	sub sp, sp, #0x24
	ldr r1, [r1, #0x124]
	ldr r0, [r1, #0x20]
	tst r0, #0x40
	addeq sp, sp, #0x24
	ldmeqia sp!, {pc}
	ldrh r1, [r1, #0x28]
	ldr r3, _0216B0C0 // =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotX33_
	add r1, sp, #0
	mov r0, #0x1a
	mov r2, #9
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x24
	ldmia sp!, {pc}
	.align 2, 0
_0216B0C0: .word FX_SinCosTable_
	arm_func_end ovl02_216B060

	arm_func_start ovl02_216B0C4
ovl02_216B0C4: // 0x0216B0C4
	stmdb sp!, {lr}
	sub sp, sp, #0x24
	ldr r1, [r1, #0x124]
	ldr r0, [r1, #0x20]
	tst r0, #0x40
	addeq sp, sp, #0x24
	ldmeqia sp!, {pc}
	ldrh r1, [r1, #0x28]
	ldr r3, _0216B138 // =FX_SinCosTable_
	add r0, sp, #0
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotX33_
	add r1, sp, #0
	mov r0, #0x1a
	mov r2, #9
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x24
	ldmia sp!, {pc}
	.align 2, 0
_0216B138: .word FX_SinCosTable_
	arm_func_end ovl02_216B0C4

	arm_func_start ovl02_216B13C
ovl02_216B13C: // 0x0216B13C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r5, [r4, #0x124]
	bl StageTask__Draw
	add r1, r5, #0x1b8
	mov r0, #0x14
	bl BossHelpers__Model__SetMatrixMode
	add r1, r5, #0x248
	mov r0, #0x1c
	bl BossHelpers__Model__SetMatrixMode
	add r1, r5, #0x278
	mov r0, #0x1b
	bl BossHelpers__Model__SetMatrixMode
	add r1, r5, #0x2a8
	mov r0, #0x1a
	bl BossHelpers__Model__SetMatrixMode
	add r1, r5, #0x2d8
	mov r0, #0x19
	bl BossHelpers__Model__SetMatrixMode
	mov r0, #0x18
	add r1, r5, #0x308
	bl BossHelpers__Model__SetMatrixMode
	mov r0, #0x17
	add r1, r5, #0x338
	bl BossHelpers__Model__SetMatrixMode
	mov r0, #0x1d
	add r1, r5, #0x218
	bl BossHelpers__Model__SetMatrixMode
	mov r0, #0x1e
	add r1, r5, #0x1e8
	bl BossHelpers__Model__SetMatrixMode
	mov r7, #0
	add r6, r5, #0x2c
_0216B1C4:
	add r8, r6, r7, lsl #5
	mov r0, r8
	bl AnimatePalette
	mov r0, r8
	bl DrawAnimatedPalette
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #8
	blo _0216B1C4
	ldr r0, [r5, #0x20c]
	mov r0, r0, asr #0xc
	str r0, [r4, #0x224]
	ldr r0, [r5, #0x210]
	rsb r0, r0, #0
	mov r0, r0, asr #0xc
	str r0, [r4, #0x228]
	ldr r0, [r5, #0x214]
	mov r0, r0, asr #0xc
	str r0, [r4, #0x22c]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end ovl02_216B13C

	arm_func_start ovl02_216B218
ovl02_216B218: // 0x0216B218
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov ip, #0
	ldr r0, [r4, #0x124]
	ldr r5, [r4, #0x11c]
	mov r2, ip
_0216B234:
	add r3, r0, ip, lsl #2
	ldr r1, [r3, #0x10]
	cmp r1, #0
	beq _0216B250
	ldr r1, [r1, #0x18]
	tst r1, #4
	strne r2, [r3, #0x10]
_0216B250:
	add r1, ip, #1
	mov r1, r1, lsl #0x10
	mov ip, r1, lsr #0x10
	cmp ip, #4
	blo _0216B234
	ldr r1, [r4, #8]
	cmp r1, #0
	bne _0216B280
	ldrsh r1, [r0, #0x24]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x24]
_0216B280:
	add r1, r0, #0x100
	ldrh r2, [r1, #0xb4]
	cmp r2, #0
	beq _0216B2B8
	sub r2, r2, #1
	strh r2, [r1, #0xb4]
	ldrh r1, [r1, #0xb4]
	cmp r1, #0
	bne _0216B2B8
	mov r2, #0
	mov r3, r2
	add r0, r0, #0x2c
	mov r1, #8
	bl BossHelpers__SetPaletteAnimations
_0216B2B8:
	ldr r1, [r4, #0xf4]
	ldr r0, _0216B32C // =ovl02_216B808
	cmp r1, r0
	ldrne r0, _0216B330 // =ovl02_216BA80
	cmpne r1, r0
	beq _0216B2DC
	ldr r0, [r5, #0x384]
	tst r0, #0x40
	beq _0216B2EC
_0216B2DC:
	ldr r0, [r4, #0x20]
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	b _0216B30C
_0216B2EC:
	tst r0, #1
	mov r0, r4
	beq _0216B304
	mov r1, #0
	bl ovl02_2169E34
	b _0216B30C
_0216B304:
	mov r1, #1
	bl ovl02_2169E34
_0216B30C:
	ldr r0, [r4, #0x35c]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r0, #0x18]
	tst r0, #4
	movne r0, #0
	strne r0, [r4, #0x35c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216B32C: .word ovl02_216B808
_0216B330: .word ovl02_216BA80
	arm_func_end ovl02_216B218

	arm_func_start ovl02_216B334
ovl02_216B334: // 0x0216B334
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r9, r0
	ldr r5, [r9, #0x1c]
	mov r8, r1
	ldrh r2, [r5, #0]
	ldr r4, [r8, #0x1c]
	cmp r2, #1
	ldr r6, [r4, #0x124]
	ldr r7, [r4, #0x11c]
	bne _0216B55C
	ldrsh r2, [r6, #0x24]
	cmp r2, #0
	beq _0216B378
	bl ObjRect__FuncNoHit
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0216B378:
	ldr r2, [r7, #0x384]
	tst r2, #0x10
	beq _0216B3D4
	mov r0, r5
	bl Player__Action_Blank
	mov r0, r5
	mov r1, #0x12
	bl Player__ChangeAction
	add r1, r5, #0x600
	mov r2, #0
	mov r0, r5
	strh r2, [r1, #0x82]
	bl BossHelpers__Player__LockControl
	ldr r0, [r5, #0x1c]
	mov r1, #0x10000
	bic r0, r0, #0x80
	str r0, [r5, #0x1c]
	str r1, [r5, #4]
	mov r0, r4
	str r1, [r5, #8]
	bl ovl02_21700A0
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0216B3D4:
	ldr r2, [r8, #0x14]
	mov r2, r2, lsl #0xc
	str r2, [r5, #0x4c]
	bl ovl02_216F064
	str r5, [r4, #0x35c]
	add r0, r7, #0x300
	ldrh r1, [r0, #0x7e]
	cmp r1, #6
	movhs r1, #5
	strhsh r1, [r0, #0x7e]
	add r0, r7, #0x300
	ldrh r1, [r0, #0x7e]
	ldr r0, _0216B658 // =_021790A8
	ldr r8, [r0, r1, lsl #2]
	bl ovl02_216A074
	smull r2, r1, r0, r8
	adds r2, r2, #0x800
	ldr r0, [r7, #0x384]
	adc r1, r1, #0
	mov r3, r2, lsr #0xc
	tst r0, #8
	add r0, r7, #0x300
	orr r3, r3, r1, lsl #20
	movne r3, r3, asr #1
	ldrsh r2, [r0, #0x7c]
	add r1, r3, #1
	sub r1, r2, r1
	strh r1, [r0, #0x7c]
	ldrsh r1, [r0, #0x7c]
	cmp r1, #0
	movle r1, #0
	strleh r1, [r0, #0x7c]
	bl ovl02_2169F80
	add r1, r7, #0x500
	strh r0, [r1, #0x36]
	add r0, r7, #0x300
	ldrh r0, [r0, #0x7e]
	cmp r0, #0
	bne _0216B4E0
	ldr r0, [r7, #0x384]
	tst r0, #8
	bne _0216B4E0
	mov r0, #0xa
	bl ShakeScreen
	mov r0, #0
	bl CreateScreenEffect
	mov r0, #0x10000
	str r0, [r4, #4]
	str r0, [r4, #8]
	ldr r1, [r4, #4]
	add r0, r7, #0x300
	str r1, [r5, #4]
	str r1, [r5, #8]
	ldrsh r0, [r0, #0x7c]
	cmp r0, #0
	bgt _0216B4E0
	ldr r0, [r7, #0x384]
	tst r0, #0x40
	beq _0216B4E0
	orr r0, r0, #0x10
	str r0, [r7, #0x384]
	ldr r0, [r4, #0x18]
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r0, [r5, #0x9c]
	mov r0, r0, asr #2
	str r0, [r5, #0x9c]
_0216B4E0:
	add r0, r7, #0x300
	ldrh r1, [r0, #0x7e]
	add r1, r1, #1
	strh r1, [r0, #0x7e]
	ldr r1, [r7, #0x384]
	tst r1, #8
	beq _0216B538
	mov r1, #6
	strh r1, [r0, #0x7e]
	ldr r1, [r7, #0x384]
	mov r0, #8
	bic r1, r1, #8
	str r1, [r7, #0x384]
	bl ShakeScreen
	add r0, r7, #0x300
	ldrh r1, [r0, #0x80]
	add r1, r1, #1
	strh r1, [r0, #0x80]
	ldrh r1, [r0, #0x80]
	cmp r1, #4
	movhi r1, #4
	strhih r1, [r0, #0x80]
_0216B538:
	mov r0, r4
	bl ovl02_216F178
	ldr r0, [r5, #0x48]
	ldr r1, [r5, #0x44]
	ldr r3, [r5, #0x4c]
	rsb r2, r0, #0
	mov r0, #0
	bl BossFX__CreateHitA
	b _0216B5CC
_0216B55C:
	mov r0, #0x8000
	str r0, [r4, #4]
	str r0, [r4, #8]
	ldr r0, [r4, #4]
	str r0, [r5, #4]
	str r0, [r5, #8]
	bl ovl02_216A054
	add r1, r7, #0x300
	ldrsh r2, [r1, #0x7c]
	sub r0, r2, r0
	strh r0, [r1, #0x7c]
	ldrsh r0, [r1, #0x7c]
	cmp r0, #0
	movle r0, #0
	strleh r0, [r1, #0x7c]
	mov r0, r8
	mov r1, r9
	bl ObjRect__HitCenterX
	mov r4, r0
	mov r0, r8
	mov r1, r9
	bl ObjRect__HitCenterY
	ldr r3, [r8, #0x14]
	rsb r2, r0, #0
	mov r1, r4
	mov r0, #0
	mov r3, r3, lsl #0xc
	bl BossFX__CreateHitA
_0216B5CC:
	mov r4, #0x8c
	sub r1, r4, #0x8d
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
	add r0, r7, #0x300
	ldrh r2, [r0, #0x7e]
	ldr r0, _0216B65C // =defaultSfxPlayer
	ldr r1, _0216B660 // =0x0000FFFF
	mov r2, r2, lsl #6
	bl NNS_SndPlayerSetTrackPitch
	mov r0, #4
	bl ShakeScreen
	add r0, r7, #0x300
	ldrsh r0, [r0, #0x7c]
	bl UpdateBossHealthHUD
	cmp r6, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r2, #1
	mov r3, r2
	add r0, r6, #0x2c
	mov r1, #8
	bl BossHelpers__SetPaletteAnimations
	add r0, r6, #0x100
	mov r1, #0x20
	strh r1, [r0, #0xb4]
	ldrh r1, [r5, #0]
	cmp r1, #1
	movne r1, #0x14
	strneh r1, [r0, #0xb4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0216B658: .word _021790A8
_0216B65C: .word defaultSfxPlayer
_0216B660: .word 0x0000FFFF
	arm_func_end ovl02_216B334

	arm_func_start ovl02_216B664
ovl02_216B664: // 0x0216B664
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0x11c]
	ldr r1, _0216B6C8 // =ovl02_216B6CC
	str r1, [r4, #0xf4]
	ldr r1, [r2, #0x384]
	tst r1, #1
	ldr r1, [r4, #0x12c]
	add r1, r1, #0x100
	beq _0216B6A4
	ldrh r1, [r1, #0x74]
	cmp r1, #0
	beq _0216B6B8
	mov r1, #0
	bl StageTask__SetAnimation
	b _0216B6B8
_0216B6A4:
	ldrh r1, [r1, #0x74]
	cmp r1, #1
	beq _0216B6B8
	mov r1, #1
	bl StageTask__SetAnimation
_0216B6B8:
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B6C8: .word ovl02_216B6CC
	arm_func_end ovl02_216B664

	arm_func_start ovl02_216B6CC
ovl02_216B6CC: // 0x0216B6CC
	stmdb sp!, {r4, lr}
	ldr r1, [r0, #0x11c]
	ldr r2, _0216B780 // =gPlayer
	add r1, r1, #0x500
	ldrh r1, [r1, #0x3a]
	ldr r4, [r2, #0]
	cmp r1, #8
	addls pc, pc, r1, lsl #2
	b _0216B750
_0216B6F0: // jump table
	b _0216B750 // case 0
	b _0216B724 // case 1
	b _0216B72C // case 2
	b _0216B734 // case 3
	b _0216B73C // case 4
	b _0216B744 // case 5
	b _0216B74C // case 6
	b _0216B714 // case 7
	b _0216B71C // case 8
_0216B714:
	bl ovl02_216B784
	b _0216B750
_0216B71C:
	bl ovl02_216B9F4
	b _0216B750
_0216B724:
	bl ovl02_216EC24
	b _0216B750
_0216B72C:
	bl ovl02_216BBD4
	b _0216B750
_0216B734:
	bl ovl02_216DB04
	b _0216B750
_0216B73C:
	bl ovl02_216CFA4
	b _0216B750
_0216B744:
	bl ovl02_216CD18
	b _0216B750
_0216B74C:
	bl ovl02_216D9D4
_0216B750:
	ldr r0, [r4, #0x4c]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x5d8]
	tst r0, #0x200000
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x1c]
	tst r0, #1
	movne r0, #0
	strne r0, [r4, #0x4c]
	strne r0, [r4, #0xa0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B780: .word gPlayer
	arm_func_end ovl02_216B6CC

	arm_func_start ovl02_216B784
ovl02_216B784: // 0x0216B784
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r5, [r6, #0x11c]
	ldr r4, [r6, #0x124]
	ldr r1, [r5, #0x384]
	ldr r2, _0216B804 // =ovl02_216B808
	orr r1, r1, #1
	bic r1, r1, #0x200
	str r1, [r5, #0x384]
	mov r1, #0x1f
	str r2, [r6, #0xf4]
	bl StageTask__SetAnimation
	mov r0, #0xf0000
	rsb r0, r0, #0
	str r0, [r5, #0x50c]
	add r0, r0, #0x8c000
	str r0, [r5, #0x514]
	mov r1, #0x64000
	mov r0, #0x50000
	str r1, [r5, #0x518]
	bl ovl02_216A014
	mov r0, #0x18000
	bl ovl02_216A034
	add r0, r4, #0x100
	mov r5, #0
	strh r5, [r0, #0x50]
	add r0, r6, #0x44
	add r3, r4, #0x12c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	str r5, [r6, #0x28]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216B804: .word ovl02_216B808
	arm_func_end ovl02_216B784

	arm_func_start ovl02_216B808
ovl02_216B808: // 0x0216B808
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r1, [r5, #0x12c]
	ldr r4, [r5, #0x124]
	add r1, r1, #0x100
	ldrh r1, [r1, #0x74]
	cmp r1, #0
	beq _0216B89C
	cmp r1, #0x1f
	bne _0216B980
	ldrh r0, [r5, #0x30]
	mov r1, #0xc00
	mov r2, #0xa0
	bl ObjRoopMove16
	strh r0, [r5, #0x30]
	ldr r0, [r5, #0x20]
	tst r0, #8
	beq _0216B980
	ldr r0, [r5, #0x28]
	cmp r0, #0
	bne _0216B880
	ldr r2, _0216B9E8 // =0x00000266
	mov r3, #1
	mov r0, #0x6000
	mov r1, #0x3000
	str r3, [r5, #0x28]
	bl ShakeScreenEx
	mov r0, #0x4000
	str r0, [r5, #4]
	str r0, [r5, #8]
_0216B880:
	mov r0, r5
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	b _0216B980
_0216B89C:
	ldr r1, [r5, #0x28]
	add r1, r1, #1
	str r1, [r5, #0x28]
	cmp r1, #0xc
	bne _0216B8B4
	bl ovl02_2176800
_0216B8B4:
	ldr r0, [r5, #0x28]
	cmp r0, #6
	bne _0216B8D8
	ldr r0, [r5, #0x48]
	ldr r1, [r5, #0x44]
	ldr r3, [r5, #0x4c]
	rsb r2, r0, #0x40000
	mov r0, #0
	bl BossFX__CreateTitanHover
_0216B8D8:
	ldr r0, [r5, #0x28]
	cmp r0, #2
	bne _0216B8F0
	mov r0, #0
	mov r1, #0x124
	bl ovl02_217873C
_0216B8F0:
	ldr r0, [r5, #8]
	cmp r0, #0
	bne _0216B980
	mov r0, #0xa
	str r0, [sp]
	add r0, r4, #0x100
	ldrh r0, [r0, #0x50]
	mov r1, #0x1000
	mov r2, #4
	mov r3, #0x100
	bl ObjShiftSet
	add r1, r4, #0x100
	strh r0, [r1, #0x50]
	ldrh r2, [r1, #0x50]
	ldr r1, [r4, #0x12c]
	mov r0, #0x178000
	bl ObjAlphaSet
	str r0, [r5, #0x44]
	add r0, r4, #0x100
	ldrh r2, [r0, #0x50]
	ldr r1, [r4, #0x130]
	ldr r0, _0216B9EC // =0x00564000
	bl ObjAlphaSet
	str r0, [r5, #0x48]
	add r1, r4, #0x100
	mov r0, #0x3d4000
	ldrh r2, [r1, #0x50]
	ldr r1, [r4, #0x134]
	rsb r0, r0, #0
	bl ObjAlphaSet
	str r0, [r5, #0x4c]
	ldrh r0, [r5, #0x30]
	mov r1, #0
	mov r2, #0x80
	bl ObjRoopMove16
	strh r0, [r5, #0x30]
_0216B980:
	ldrh r0, [r5, #0x30]
	ldr r2, _0216B9F0 // =FX_SinCosTable_
	ldr r3, [r5, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotX33_
	ldrh r0, [r5, #0x30]
	cmp r0, #0
	ldreq r0, [r5, #0x44]
	cmpeq r0, #0x178000
	ldreq r1, [r5, #0x48]
	ldreq r0, _0216B9EC // =0x00564000
	cmpeq r1, r0
	ldreq r1, [r5, #0x4c]
	rsbeq r0, r0, #0x190000
	cmpeq r1, r0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl ovl02_216B664
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216B9E8: .word 0x00000266
_0216B9EC: .word 0x00564000
_0216B9F0: .word FX_SinCosTable_
	arm_func_end ovl02_216B808

	arm_func_start ovl02_216B9F4
ovl02_216B9F4: // 0x0216B9F4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r3, [r5, #0x11c]
	mov r0, #0xb4000
	ldr r1, [r3, #0x384]
	ldr r4, [r5, #0x124]
	bic r1, r1, #1
	str r1, [r3, #0x384]
	orr r2, r1, #0x200
	ldr r1, _0216BA78 // =ovl02_216BA80
	str r2, [r3, #0x384]
	rsb r0, r0, #0
	str r1, [r5, #0xf4]
	str r0, [r3, #0x50c]
	sub r0, r0, #0x14000
	str r0, [r3, #0x514]
	mov r0, #0
	str r0, [r3, #0x518]
	bl ovl02_216A014
	mov r0, #0
	bl ovl02_216A034
	add r0, r4, #0x100
	mov ip, #0
	strh ip, [r0, #0x50]
	add r0, r5, #0x44
	add r3, r4, #0x12c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, _0216BA7C // =0x00000127
	mov r0, ip
	str ip, [r5, #0x28]
	bl ovl02_217873C
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216BA78: .word ovl02_216BA80
_0216BA7C: .word 0x00000127
	arm_func_end ovl02_216B9F4

	arm_func_start ovl02_216BA80
ovl02_216BA80: // 0x0216BA80
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r4, [r5, #0x124]
	mov r2, #0
	str r2, [sp]
	mov r0, #4
	str r0, [sp, #4]
	add r0, r4, #0x100
	ldrh r0, [r0, #0x50]
	mov r1, #0x1000
	mov r3, #3
	bl ObjDiffSet
	add r1, r4, #0x100
	strh r0, [r1, #0x50]
	mov r0, #4
	str r0, [sp]
	ldr r0, [r5, #0x28]
	mov r1, #0x1000
	mov r2, #3
	mov r3, #0
	bl ObjShiftSet
	str r0, [r5, #0x28]
	mov r0, r0
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	ldr r1, [r4, #0x12c]
	mov r0, #0x178000
	bl ObjAlphaSet
	str r0, [r5, #0x44]
	add r0, r4, #0x100
	ldrh r2, [r0, #0x50]
	ldr r0, _0216BBC8 // =0x00794000
	ldr r1, [r4, #0x130]
	bl ObjAlphaSet
	str r0, [r5, #0x48]
	ldr r2, [r5, #0x28]
	mov r0, #0x140000
	mov r2, r2, lsl #0x10
	ldr r1, [r4, #0x134]
	rsb r0, r0, #0
	mov r2, r2, lsr #0x10
	bl ObjAlphaSet
	str r0, [r5, #0x4c]
	ldr r1, [r5, #0x44]
	cmp r1, #0x178000
	ldreq r2, [r5, #0x48]
	ldreq r0, _0216BBC8 // =0x00794000
	cmpeq r2, r0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #0x140000
	ldr r3, [r5, #0x4c]
	rsb r0, r0, #0
	cmp r3, r0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	rsb r2, r2, #0x30000
	mov r0, #0
	bl BossFX__CreateRexRage
	cmp r0, #0
	beq _0216BB90
	ldr r2, _0216BBCC // =ovl02_2176A2C
	mov r1, #0x2000
	str r2, [r0, #0x2e4]
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	str r1, [r0, #0x40]
_0216BB90:
	mov r0, #0
	mov r1, #6
	bl ovl02_217873C
	ldr r2, _0216BBD0 // =0x000001C7
	mov r0, #0x8000
	mov r1, #0x3000
	bl ShakeScreenEx
	mov r1, #0x10000
	str r1, [r5, #4]
	mov r0, r5
	str r1, [r5, #8]
	bl ovl02_216B664
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216BBC8: .word 0x00794000
_0216BBCC: .word ovl02_2176A2C
_0216BBD0: .word 0x000001C7
	arm_func_end ovl02_216BA80

	arm_func_start ovl02_216BBD4
ovl02_216BBD4: // 0x0216BBD4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r3, _0216BD7C // =_mt_math_rand
	add r0, r4, #0x100
	ldrh ip, [r0, #0x88]
	ldr r1, _0216BD80 // =0x00196225
	ldr r2, _0216BD84 // =0x3C6EF35F
	add ip, ip, #1
	strh ip, [r0, #0x88]
	ldr ip, [r3]
	mla r2, ip, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r2, [r3]
	tst r1, #3
	beq _0216BC28
	ldrh r0, [r0, #0x88]
	cmp r0, #2
	bls _0216BC40
_0216BC28:
	add r1, r4, #0x100
	mov r2, #0
	mov r0, r5
	strh r2, [r1, #0x88]
	bl ovl02_216C740
	ldmia sp!, {r3, r4, r5, pc}
_0216BC40:
	ldr r1, _0216BD88 // =ovl02_216BE0C
	ldr r0, _0216BD8C // =gPlayer
	str r1, [r5, #0xf4]
	ldr r0, [r0, #0]
	str r0, [r5, #0x35c]
	bl ovl02_2169F80
	strh r0, [r4, #0x26]
	mov r2, #0x5a
	str r2, [r5, #0x2c]
	ldrh r1, [r4, #0x26]
	mov r0, #0
	rsb r1, r1, r1, lsl #4
	add r1, r1, #0x5a
	str r1, [r5, #0x2c]
	str r0, [r5, #0x28]
	ldrh r0, [r4, #0x26]
	cmp r0, #0
	beq _0216BCEC
	cmp r0, #1
	cmpne r0, #2
	ldr r0, _0216BD80 // =0x00196225
	bne _0216BCC4
	ldr r2, _0216BD7C // =_mt_math_rand
	ldr r1, _0216BD84 // =0x3C6EF35F
	ldr r3, [r2, #0]
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	and r0, r0, #1
	str r0, [r5, #0x28]
	b _0216BCEC
_0216BCC4:
	ldr r2, _0216BD7C // =_mt_math_rand
	ldr r1, _0216BD84 // =0x3C6EF35F
	ldr r3, [r2, #0]
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	and r0, r0, #3
	str r0, [r5, #0x28]
_0216BCEC:
	add r0, r5, #0x44
	add r3, r4, #0x12c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x20]
	ldr r2, _0216BD7C // =_mt_math_rand
	bic r0, r0, #0x10
	str r0, [r4, #0x20]
	ldr r3, [r2, #0]
	ldr r0, _0216BD80 // =0x00196225
	ldr r1, _0216BD84 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #0x10
	strne r0, [r4, #0x20]
	ldr r0, [r4, #0x20]
	tst r0, #0x10
	mov r0, r5
	beq _0216BD58
	mov r1, #8
	bl StageTask__SetAnimation
	b _0216BD60
_0216BD58:
	mov r1, #2
	bl StageTask__SetAnimation
_0216BD60:
	ldr r1, [r4, #0x20]
	mov r0, r5
	bic r2, r1, #0x20
	mov r1, #0x128
	str r2, [r4, #0x20]
	bl ovl02_217873C
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216BD7C: .word _mt_math_rand
_0216BD80: .word 0x00196225
_0216BD84: .word 0x3C6EF35F
_0216BD88: .word ovl02_216BE0C
_0216BD8C: .word gPlayer
	arm_func_end ovl02_216BBD4

	arm_func_start ovl02_216BD90
ovl02_216BD90: // 0x0216BD90
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r1, _0216BE08 // =ovl02_216BE0C
	mov r2, #0x20
	str r1, [r5, #0xf4]
	str r2, [r5, #0x2c]
	ldrh r1, [r4, #0x26]
	add r1, r2, r1, lsl #3
	str r1, [r5, #0x2c]
	ldr r1, [r5, #0x28]
	sub r1, r1, #1
	str r1, [r5, #0x28]
	ldr r1, [r4, #0x20]
	eor r1, r1, #0x10
	str r1, [r4, #0x20]
	tst r1, #0x10
	beq _0216BDE4
	mov r1, #9
	bl StageTask__SetAnimation
	b _0216BDEC
_0216BDE4:
	mov r1, #3
	bl StageTask__SetAnimation
_0216BDEC:
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	ldr r0, [r4, #0x20]
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216BE08: .word ovl02_216BE0C
	arm_func_end ovl02_216BD90

	arm_func_start ovl02_216BE0C
ovl02_216BE0C: // 0x0216BE0C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r1, [r7, #0x12c]
	ldr r5, [r7, #0x124]
	add r1, r1, #0x100
	ldrh r2, [r1, #0x74]
	ldr r1, [r7, #0x35c]
	cmp r2, #9
	addls pc, pc, r2, lsl #2
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0216BE34: // jump table
	ldmia sp!, {r3, r4, r5, r6, r7, pc} // case 0
	ldmia sp!, {r3, r4, r5, r6, r7, pc} // case 1
	b _0216BE5C // case 2
	b _0216BE88 // case 3
	ldmia sp!, {r3, r4, r5, r6, r7, pc} // case 4
	ldmia sp!, {r3, r4, r5, r6, r7, pc} // case 5
	ldmia sp!, {r3, r4, r5, r6, r7, pc} // case 6
	ldmia sp!, {r3, r4, r5, r6, r7, pc} // case 7
	b _0216BE5C // case 8
	b _0216BE88 // case 9
_0216BE5C:
	ldr r1, [r7, #0x20]
	tst r1, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	add r1, r2, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r0, [r7, #0x20]
	orr r0, r0, #4
	str r0, [r7, #0x20]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0216BE88:
	cmp r1, #0
	beq _0216BFB4
	ldrh r3, [r5, #0x26]
	ldr r2, [r7, #0x28]
	mov r4, #0xa0
	mov r0, #0x18
	mla r0, r3, r0, r4
	mov r0, r0, lsl #0x10
	cmp r2, #0
	mov r6, r0, asr #0x10
	beq _0216BEC4
	mov r0, #0x100
	add r0, r0, r3, lsl #5
	mov r0, r0, lsl #0x10
	mov r6, r0, asr #0x10
_0216BEC4:
	ldr r3, [r1, #0x44]
	ldr r0, [r7, #0x44]
	ldr r2, [r1, #0x4c]
	ldr r1, [r7, #0x4c]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r4, r0
	ldrh r0, [r7, #0x32]
	mov r1, r4
	mov r2, r6
	bl ObjRoopMove16
	strh r0, [r7, #0x32]
	ldrh r0, [r7, #0x32]
	ldr r3, [r7, #0x12c]
	ldr r2, _0216BFD0 // =FX_SinCosTable_
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotY33_
	ldrh r1, [r7, #0x32]
	mov r0, r4
	bl ObjRoopDiff16
	ldr r1, [r7, #0x20]
	tst r1, #1
	beq _0216BF7C
	mov r1, #0x1400
	rsb r1, r1, #0
	cmp r0, r1
	ble _0216BF68
	cmp r0, #0xa00
	bge _0216BF68
	ldr r0, [r5, #0x20]
	orr r0, r0, #0x20
	str r0, [r5, #0x20]
	b _0216BFB4
_0216BF68:
	ldr r0, [r5, #0x20]
	tst r0, #0x20
	mvnne r0, #0
	strne r0, [r7, #0x2c]
	b _0216BFB4
_0216BF7C:
	cmp r0, #0x1400
	bge _0216BFA4
	mov r1, #0xa00
	rsb r1, r1, #0
	cmp r0, r1
	ble _0216BFA4
	ldr r0, [r5, #0x20]
	orr r0, r0, #0x20
	str r0, [r5, #0x20]
	b _0216BFB4
_0216BFA4:
	ldr r0, [r5, #0x20]
	tst r0, #0x20
	mvnne r0, #0
	strne r0, [r7, #0x2c]
_0216BFB4:
	ldr r0, [r7, #0x2c]
	subs r0, r0, #1
	str r0, [r7, #0x2c]
	ldmplia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, r7
	bl ovl02_216BFD4
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216BFD0: .word FX_SinCosTable_
	arm_func_end ovl02_216BE0C

	arm_func_start ovl02_216BFD4
ovl02_216BFD4: // 0x0216BFD4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r1, _0216C080 // =ovl02_216C084
	str r1, [r5, #0xf4]
	ldr r1, [r4, #0x20]
	tst r1, #0x10
	beq _0216C000
	mov r1, #0xa
	bl StageTask__SetAnimation
	b _0216C008
_0216C000:
	mov r1, #4
	bl StageTask__SetAnimation
_0216C008:
	mov r2, #0x40
	str r2, [r5, #0x2c]
	ldrh r1, [r4, #0x26]
	sub r0, r2, #0x4a
	mla r0, r1, r0, r2
	str r0, [r5, #0x2c]
	ldr r0, [r5, #0x28]
	cmp r0, #0
	beq _0216C044
	mov r2, #0x18
	str r2, [r5, #0x2c]
	ldrh r1, [r4, #0x26]
	sub r0, r2, #0x1b
	mla r0, r1, r0, r2
	str r0, [r5, #0x2c]
_0216C044:
	add r5, r5, #0x44
	add r3, r4, #0x138
	ldmia r5, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r3, r4, #0x144
	ldmia r5, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r4, #0x100
	mov r1, #0
	strh r1, [r0, #0x50]
	strh r1, [r0, #0x52]
	ldr r0, [r4, #0x20]
	bic r0, r0, #0x80
	str r0, [r4, #0x20]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216C080: .word ovl02_216C084
	arm_func_end ovl02_216BFD4

	arm_func_start ovl02_216C084
ovl02_216C084: // 0x0216C084
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r5, r0
	ldr r0, [r5, #0x12c]
	ldr r4, [r5, #0x124]
	add r0, r0, #0x100
	ldrh r0, [r0, #0x74]
	ldr r6, [r5, #0x35c]
	cmp r0, #0xd
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0216C0AC: // jump table
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc} // case 0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc} // case 1
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc} // case 2
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc} // case 3
	b _0216C0E4 // case 4
	b _0216C2D4 // case 5
	b _0216C4D0 // case 6
	b _0216C4D0 // case 7
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc} // case 8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc} // case 9
	b _0216C0E4 // case 10
	b _0216C2D4 // case 11
	b _0216C4D0 // case 12
	b _0216C4D0 // case 13
_0216C0E4:
	ldr r0, [r5, #0x2c]
	subs r0, r0, #1
	str r0, [r5, #0x2c]
	ldmplia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r0, _0216C6C0 // =gPlayer
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x5d8]
	tst r0, #0x200000
	movne r0, #0
	strne r0, [r5, #0x28]
	ldr r1, [r5, #0x12c]
	mov r0, r5
	add r1, r1, #0x100
	ldrh r1, [r1, #0x74]
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x20]
	mov r2, #0x70
	tst r0, #0x10
	orrne r0, r0, #1
	orreq r0, r0, #2
	str r0, [r4, #0x20]
	str r2, [r5, #0x2c]
	ldrh r1, [r4, #0x26]
	sub r0, r2, #0x7e
	mla r0, r1, r0, r2
	str r0, [r5, #0x2c]
	ldr r0, [r5, #0x28]
	cmp r0, #0
	beq _0216C180
	mov r1, #0x2a
	str r1, [r5, #0x2c]
	ldrh r0, [r4, #0x26]
	mov r0, r0, lsl #2
	rsb r0, r0, #0
	add r0, r0, #0x2a
	str r0, [r5, #0x2c]
_0216C180:
	ldrh r1, [r5, #0x32]
	mov r0, #0
	bl ObjRoopDiff16
	cmp r0, #0
	ldrh r1, [r5, #0x32]
	mov r0, #0
	bge _0216C1A8
	bl ObjRoopDiff16
	rsb r0, r0, #0
	b _0216C1AC
_0216C1A8:
	bl ObjRoopDiff16
_0216C1AC:
	cmp r0, #0xe00
	ble _0216C29C
	ldrh r1, [r5, #0x32]
	mov r0, #0
	bl ObjRoopDiff16
	cmp r0, #0
	ldrh r1, [r5, #0x32]
	mov r0, #0
	bge _0216C1DC
	bl ObjRoopDiff16
	rsb r0, r0, #0
	b _0216C1E0
_0216C1DC:
	bl ObjRoopDiff16
_0216C1E0:
	add r6, r5, #0x44
	sub r8, r0, #0xe00
	mov r7, #0x60000
	umull ip, r3, r8, r7
	mov lr, #0
	add r9, r4, #0x138
	ldmia r6, {r0, r1, r2}
	stmia r9, {r0, r1, r2}
	adds ip, ip, #0x800
	mla r3, r8, lr, r3
	mov r0, r8, asr #0x1f
	mla r3, r0, r7, r3
	add r7, r4, #0x144
	ldmia r6, {r0, r1, r2}
	stmia r7, {r0, r1, r2}
	add r0, r4, #0x100
	strh lr, [r0, #0x50]
	ldrh r0, [r5, #0x32]
	ldr r6, _0216C6C4 // =FX_SinCosTable_
	adc r2, r3, #0
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	mov r1, ip, lsr #0xc
	ldrsh r0, [r6, r0]
	orr r1, r1, r2, lsl #20
	ldr r3, [r4, #0x144]
	smull r2, r0, r1, r0
	adds r2, r2, #0x800
	adc r0, r0, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	add r0, r3, r2
	str r0, [r4, #0x144]
	ldrh r2, [r5, #0x32]
	ldr r0, [r4, #0x14c]
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r2, [r6, r2]
	smull r3, r2, r1, r2
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r0, r0, r2
	str r0, [r4, #0x14c]
_0216C29C:
	ldr r0, [r5, #0x12c]
	mov r1, #0x1000
	str r1, [r0, #0x118]
	ldr r3, [r5, #0x12c]
	ldrh r1, [r4, #0x26]
	ldr r2, [r3, #0x118]
	mov r0, r5
	add r1, r2, r1, lsl #11
	str r1, [r3, #0x118]
	bl ovl02_2175988
	ldr r1, _0216C6C8 // =0x00000129
	mov r0, r5
	bl ovl02_217873C
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0216C2D4:
	add r0, r4, #0x100
	ldrh r0, [r0, #0x50]
	mov r1, #0x200
	mov r2, #0x1000
	bl ObjSpdUpSet
	add r1, r4, #0x100
	strh r0, [r1, #0x50]
	ldrh r2, [r1, #0x50]
	ldr r0, [r4, #0x144]
	ldr r1, [r4, #0x138]
	bl ObjAlphaSet
	str r0, [r5, #0x44]
	add r0, r4, #0x100
	ldrh r2, [r0, #0x50]
	ldr r0, [r4, #0x14c]
	ldr r1, [r4, #0x140]
	bl ObjAlphaSet
	str r0, [r5, #0x4c]
	ldr r0, [r4, #0x20]
	tst r0, #0x80
	bne _0216C364
	ldr r1, [r5, #0x12c]
	ldr r0, [r1, #0xe4]
	ldr r0, [r0, #0]
	cmp r0, #0x12000
	blt _0216C364
	mov r0, #0x1000
	str r0, [r1, #0x118]
	ldr r0, [r5, #0x20]
	tst r0, #8
	bne _0216C358
	mov r0, #9
	bl ShakeScreen
_0216C358:
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x80
	str r0, [r4, #0x20]
_0216C364:
	ldr r0, [r5, #0x20]
	tst r0, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x84
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x154]
	cmp r0, #0
	beq _0216C400
	ldr r0, [r4, #0x20]
	bic r0, r0, #4
	orr r0, r0, #8
	str r0, [r4, #0x20]
	ldr r0, [r5, #8]
	cmp r0, #0
	bne _0216C400
	mov r0, #4
	str r0, [sp]
	ldr r0, [r4, #0x154]
	mov r1, #0
	mov r2, #3
	mov r3, #0xc0
	bl ObjShiftSet
	str r0, [r4, #0x154]
	ldrh r1, [r5, #0x32]
	ldr r2, _0216C6C4 // =FX_SinCosTable_
	add r0, r1, r0
	strh r0, [r5, #0x32]
	ldrh r0, [r5, #0x32]
	ldr r3, [r5, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotY33_
_0216C400:
	ldr r0, [r4, #0x154]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [r5, #0x2c]
	subs r0, r0, #1
	str r0, [r5, #0x2c]
	ldmplia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [r5, #0x12c]
	mov r1, #0x1000
	str r1, [r0, #0x118]
	ldr r0, [r4, #0x20]
	bic r0, r0, #0xc
	bic r0, r0, #3
	str r0, [r4, #0x20]
	ldr r0, [r5, #0x28]
	cmp r0, #0
	bne _0216C468
	ldr r1, [r5, #0x12c]
	mov r0, r5
	add r1, r1, #0x100
	ldrh r1, [r1, #0x74]
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	b _0216C498
_0216C468:
	mov r0, r5
	mov r1, #0x128
	bl ovl02_217873C
	ldr r0, [r4, #0x20]
	tst r0, #0x10
	mov r0, r5
	beq _0216C490
	mov r1, #0xd
	bl StageTask__SetAnimation
	b _0216C498
_0216C490:
	mov r1, #7
	bl StageTask__SetAnimation
_0216C498:
	ldr r1, [r4, #0x144]
	ldr r0, [r4, #0x138]
	cmp r1, r0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, #0x8000
	rsb r0, r0, #0
	str r0, [r5, #0x9c]
	ldr r1, [r5, #0x1c]
	mov r0, #0x4000
	orr r1, r1, #0x10
	str r1, [r5, #0x1c]
	str r0, [r5, #4]
	str r0, [r5, #8]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0216C4D0:
	add r0, r4, #0x100
	ldrh r0, [r0, #0x50]
	mov r1, #0xa0
	bl ObjSpdDownSet
	add r1, r4, #0x100
	strh r0, [r1, #0x50]
	ldrh r2, [r1, #0x50]
	ldr r0, [r4, #0x144]
	ldr r1, [r4, #0x138]
	bl ObjAlphaSet
	str r0, [r5, #0x44]
	add r0, r4, #0x100
	ldrh r2, [r0, #0x50]
	ldr r0, [r4, #0x14c]
	ldr r1, [r4, #0x140]
	bl ObjAlphaSet
	str r0, [r5, #0x4c]
	ldr r1, [r4, #0x144]
	ldr r0, [r4, #0x138]
	cmp r1, r0
	beq _0216C590
	ldr r2, [r5, #0x48]
	ldr r0, [r5, #0x9c]
	mov r1, #0xc00
	add r0, r2, r0
	str r0, [r5, #0x48]
	ldr r0, [r5, #0x9c]
	mov r2, #0x1a000
	bl ObjSpdUpSet
	str r0, [r5, #0x9c]
	ldr r1, [r4, #0x13c]
	ldr r0, [r5, #0x48]
	cmp r0, r1
	blt _0216C590
	str r1, [r5, #0x48]
	ldr r0, [r5, #0x1c]
	tst r0, #0x10
	beq _0216C590
	ldr r2, _0216C6CC // =0x00000266
	mov r0, #0x6000
	mov r1, #0x3000
	bl ShakeScreenEx
	ldr r1, [r5, #0x1c]
	mov r0, r5
	bic r2, r1, #0x10
	mov r1, #6
	str r2, [r5, #0x1c]
	bl ovl02_217873C
_0216C590:
	ldr r0, [r5, #0x28]
	cmp r0, #0
	bne _0216C5E4
	ldrh r0, [r5, #0x32]
	mov r1, #0
	mov r2, #0xa0
	bl ObjRoopMove16
	strh r0, [r5, #0x32]
	ldrh r0, [r5, #0x32]
	ldr r3, [r5, #0x12c]
	ldr r2, _0216C6C4 // =FX_SinCosTable_
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotY33_
	b _0216C64C
_0216C5E4:
	cmp r6, #0
	beq _0216C64C
	ldr r3, [r6, #0x44]
	ldr r0, [r5, #0x44]
	ldr r2, [r6, #0x4c]
	ldr r1, [r5, #0x4c]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r1, r0
	ldrh r0, [r5, #0x32]
	mov r2, #0xa0
	bl ObjRoopMove16
	strh r0, [r5, #0x32]
	ldrh r0, [r5, #0x32]
	ldr r3, [r5, #0x12c]
	ldr r2, _0216C6C4 // =FX_SinCosTable_
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotY33_
_0216C64C:
	ldr r0, [r5, #0x1c]
	tst r0, #0x10
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldrh r0, [r5, #0x32]
	cmp r0, #0
	beq _0216C670
	ldr r0, [r5, #0x28]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0216C670:
	ldr r0, [r5, #0x20]
	tst r0, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r1, [r4, #0x13c]
	mov r0, #0
	str r1, [r5, #0x48]
	str r0, [r5, #0x9c]
	ldr r0, [r5, #0x12c]
	add r0, r0, #0x100
	ldrh r1, [r0, #0xc]
	bic r1, r1, #4
	strh r1, [r0, #0xc]
	ldr r0, [r5, #0x28]
	cmp r0, #0
	mov r0, r5
	beq _0216C6B8
	bl ovl02_216BD90
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0216C6B8:
	bl ovl02_216B664
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0216C6C0: .word gPlayer
_0216C6C4: .word FX_SinCosTable_
_0216C6C8: .word 0x00000129
_0216C6CC: .word 0x00000266
	arm_func_end ovl02_216C084

	arm_func_start ovl02_216C6D0
ovl02_216C6D0: // 0x0216C6D0
	ldr ip, [r0, #0xf4]
	ldr r2, _0216C738 // =ovl02_216C084
	ldr r3, [r0, #0x124]
	cmp ip, r2
	ldrne r2, _0216C73C // =ovl02_216C82C
	cmpne ip, r2
	bxne lr
	ldr r2, [r0, #0x12c]
	add r2, r2, #0x100
	ldrh r2, [r2, #0x74]
	cmp r2, #5
	cmpne r2, #0xb
	bxne lr
	ldr r2, _0216C73C // =ovl02_216C82C
	cmp ip, r2
	bne _0216C71C
	ldr r2, [r0, #0x28]
	cmp r2, #0
	movne r1, r1, asr #3
_0216C71C:
	str r1, [r3, #0x154]
	mov r1, #0x8000
	str r1, [r0, #8]
	ldr r1, [r0, #0x2c]
	mov r1, r1, asr #2
	str r1, [r0, #0x2c]
	bx lr
	.align 2, 0
_0216C738: .word ovl02_216C084
_0216C73C: .word ovl02_216C82C
	arm_func_end ovl02_216C6D0

	arm_func_start ovl02_216C740
ovl02_216C740: // 0x0216C740
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r1, _0216C818 // =ovl02_216C82C
	ldr r0, _0216C81C // =gPlayer
	str r1, [r5, #0xf4]
	ldr r0, [r0, #0]
	str r0, [r5, #0x35c]
	bl ovl02_2169F80
	mov r2, #0x3c
	strh r0, [r4, #0x26]
	str r2, [r5, #0x2c]
	ldrh r1, [r4, #0x26]
	sub r0, r2, #0x42
	add r3, r4, #0x12c
	mla r0, r1, r0, r2
	str r0, [r5, #0x2c]
	mov r0, #4
	str r0, [r5, #0x28]
	add r0, r5, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x20]
	ldr r2, _0216C820 // =_mt_math_rand
	bic r0, r0, #0x10
	str r0, [r4, #0x20]
	ldr r3, [r2, #0]
	ldr r0, _0216C824 // =0x00196225
	ldr r1, _0216C828 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #0x10
	strne r0, [r4, #0x20]
	ldr r0, [r4, #0x20]
	tst r0, #0x10
	mov r0, r5
	beq _0216C7F4
	mov r1, #8
	bl StageTask__SetAnimation
	b _0216C7FC
_0216C7F4:
	mov r1, #2
	bl StageTask__SetAnimation
_0216C7FC:
	ldr r1, [r4, #0x20]
	mov r0, r5
	bic r2, r1, #0x20
	mov r1, #0x128
	str r2, [r4, #0x20]
	bl ovl02_217873C
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216C818: .word ovl02_216C82C
_0216C81C: .word gPlayer
_0216C820: .word _mt_math_rand
_0216C824: .word 0x00196225
_0216C828: .word 0x3C6EF35F
	arm_func_end ovl02_216C740

	arm_func_start ovl02_216C82C
ovl02_216C82C: // 0x0216C82C
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r3, [r5, #0x12c]
	ldr r4, [r5, #0x124]
	add r1, r3, #0x100
	ldrh r2, [r1, #0x74]
	ldr r1, [r5, #0x35c]
	cmp r2, #0xd
	addls pc, pc, r2, lsl #2
	b _0216CD04
_0216C858: // jump table
	b _0216CD04 // case 0
	b _0216CD04 // case 1
	b _0216C890 // case 2
	b _0216C8C4 // case 3
	b _0216C914 // case 4
	b _0216C9E4 // case 5
	b _0216CB90 // case 6
	b _0216CB90 // case 7
	b _0216C890 // case 8
	b _0216C8C4 // case 9
	b _0216C914 // case 10
	b _0216C9E4 // case 11
	b _0216CB90 // case 12
	b _0216CB90 // case 13
_0216C890:
	ldr r1, [r5, #0x20]
	tst r1, #8
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	add r1, r2, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r0, [r5, #0x20]
	add sp, sp, #4
	orr r0, r0, #4
	str r0, [r5, #0x20]
	ldmia sp!, {r3, r4, r5, r6, pc}
_0216C8C4:
	ldr r1, [r5, #0x2c]
	subs r1, r1, #1
	addpl sp, sp, #4
	str r1, [r5, #0x2c]
	ldmplia sp!, {r3, r4, r5, r6, pc}
	ldr r1, [r4, #0x20]
	tst r1, #0x10
	beq _0216C8F0
	mov r1, #0xa
	bl StageTask__SetAnimation
	b _0216C8F8
_0216C8F0:
	mov r1, #4
	bl StageTask__SetAnimation
_0216C8F8:
	add r0, r4, #0x100
	mov r1, #0
	strh r1, [r0, #0x52]
	mov r0, #0x18
	add sp, sp, #4
	str r0, [r5, #0x2c]
	ldmia sp!, {r3, r4, r5, r6, pc}
_0216C914:
	ldr r0, [r5, #0x2c]
	subs r0, r0, #1
	addpl sp, sp, #4
	str r0, [r5, #0x2c]
	ldmplia sp!, {r3, r4, r5, r6, pc}
	ldr r0, _0216CD0C // =gPlayer
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x5d8]
	tst r0, #0x200000
	movne r0, #0
	strne r0, [r5, #0x28]
	ldr r1, [r4, #0x20]
	mov r0, r5
	bic r1, r1, #0x80
	str r1, [r4, #0x20]
	ldr r1, [r5, #0x12c]
	add r1, r1, #0x100
	ldrh r1, [r1, #0x74]
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x20]
	tst r0, #0x10
	orrne r0, r0, #1
	orreq r0, r0, #2
	str r0, [r4, #0x20]
	ldr r0, [r5, #0x28]
	cmp r0, #0
	movne r0, #0xa
	bne _0216C9A4
	mov r2, #0x78
	str r2, [r5, #0x2c]
	ldrh r1, [r4, #0x26]
	sub r0, r2, #0x86
	mla r0, r1, r0, r2
_0216C9A4:
	str r0, [r5, #0x2c]
	ldr r0, [r5, #0x12c]
	mov r1, #0x1000
	str r1, [r0, #0x118]
	ldr r3, [r5, #0x12c]
	ldrh r1, [r4, #0x26]
	ldr r2, [r3, #0x118]
	mov r0, r5
	add r1, r2, r1, lsl #11
	str r1, [r3, #0x118]
	bl ovl02_2175988
	ldr r1, _0216CD10 // =0x00000129
	mov r0, r5
	bl ovl02_217873C
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_0216C9E4:
	ldr r0, [r4, #0x20]
	tst r0, #0x80
	bne _0216CA40
	ldr r0, [r3, #0xe4]
	ldr r0, [r0, #0]
	cmp r0, #0x12000
	blt _0216CA40
	mov r0, #0x1000
	str r0, [r3, #0x118]
	ldr r0, [r5, #0x20]
	tst r0, #8
	bne _0216CA34
	ldr r0, [r5, #0x28]
	cmp r0, #0
	beq _0216CA2C
	mov r0, #9
	bl ShakeScreen
	b _0216CA34
_0216CA2C:
	mov r0, #0xa
	bl ShakeScreen
_0216CA34:
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x80
	str r0, [r4, #0x20]
_0216CA40:
	ldr r0, [r5, #0x20]
	tst r0, #8
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x84
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x154]
	cmp r0, #0
	beq _0216CAE0
	ldr r0, [r4, #0x20]
	bic r0, r0, #4
	orr r0, r0, #8
	str r0, [r4, #0x20]
	ldr r0, [r5, #8]
	cmp r0, #0
	bne _0216CAE0
	mov r0, #4
	str r0, [sp]
	ldr r0, [r4, #0x154]
	mov r1, #0
	mov r2, #3
	mov r3, #0xc0
	bl ObjShiftSet
	str r0, [r4, #0x154]
	ldrh r1, [r5, #0x32]
	ldr r2, _0216CD14 // =FX_SinCosTable_
	add r0, r1, r0
	strh r0, [r5, #0x32]
	ldrh r0, [r5, #0x32]
	ldr r3, [r5, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotY33_
_0216CAE0:
	ldr r0, [r4, #0x154]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, r5, r6, pc}
	ldr r0, [r5, #0x2c]
	subs r0, r0, #1
	addpl sp, sp, #4
	str r0, [r5, #0x2c]
	ldmplia sp!, {r3, r4, r5, r6, pc}
	ldr r0, [r5, #0x12c]
	mov r1, #0x1000
	str r1, [r0, #0x118]
	ldr r0, [r4, #0x20]
	bic r0, r0, #0xc
	bic r0, r0, #3
	str r0, [r4, #0x20]
	ldr r0, [r5, #0x28]
	cmp r0, #0
	bne _0216CB54
	ldr r1, [r5, #0x12c]
	mov r0, r5
	add r1, r1, #0x100
	ldrh r1, [r1, #0x74]
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_0216CB54:
	mov r0, r5
	mov r1, #0x128
	bl ovl02_217873C
	ldr r0, [r4, #0x20]
	tst r0, #0x10
	mov r0, r5
	beq _0216CB80
	mov r1, #0xd
	bl StageTask__SetAnimation
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_0216CB80:
	mov r1, #7
	bl StageTask__SetAnimation
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_0216CB90:
	ldr r0, [r5, #0x28]
	cmp r0, #0
	bne _0216CBE4
	ldrh r0, [r5, #0x32]
	mov r1, #0
	mov r2, #0xa0
	bl ObjRoopMove16
	strh r0, [r5, #0x32]
	ldrh r0, [r5, #0x32]
	ldr r3, [r5, #0x12c]
	ldr r2, _0216CD14 // =FX_SinCosTable_
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotY33_
	b _0216CC68
_0216CBE4:
	cmp r1, #0
	ldrneh r3, [r4, #0x26]
	cmpne r3, #0
	beq _0216CC68
	mov r2, #0x10
	mov r0, #0xd
	mla r0, r3, r0, r2
	mov r2, r0, lsl #0x10
	ldr ip, [r1, #0x44]
	ldr r0, [r5, #0x44]
	ldr r3, [r1, #0x4c]
	ldr r1, [r5, #0x4c]
	sub r0, ip, r0
	sub r1, r3, r1
	mov r6, r2, asr #0x10
	bl FX_Atan2Idx
	mov r1, r0
	ldrh r0, [r5, #0x32]
	mov r2, r6
	bl ObjRoopMove16
	strh r0, [r5, #0x32]
	ldrh r0, [r5, #0x32]
	ldr r3, [r5, #0x12c]
	ldr r2, _0216CD14 // =FX_SinCosTable_
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotY33_
_0216CC68:
	ldrh r0, [r5, #0x32]
	cmp r0, #0
	beq _0216CC84
	ldr r0, [r5, #0x28]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, pc}
_0216CC84:
	ldr r0, [r5, #0x20]
	tst r0, #8
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r0, [r5, #0x28]
	cmp r0, #0
	beq _0216CCFC
	mov r1, #4
	str r1, [r5, #0x2c]
	ldr r0, [r5, #0x28]
	sub r0, r0, #1
	str r0, [r5, #0x28]
	ldr r0, [r4, #0x20]
	eor r0, r0, #0x10
	str r0, [r4, #0x20]
	tst r0, #0x10
	mov r0, r5
	beq _0216CCD8
	mov r1, #0xa
	bl StageTask__SetAnimation
	b _0216CCDC
_0216CCD8:
	bl StageTask__SetAnimation
_0216CCDC:
	ldr r0, [r5, #0x20]
	add sp, sp, #4
	orr r0, r0, #4
	str r0, [r5, #0x20]
	ldr r0, [r4, #0x20]
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	ldmia sp!, {r3, r4, r5, r6, pc}
_0216CCFC:
	mov r0, r5
	bl ovl02_216B664
_0216CD04:
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0216CD0C: .word gPlayer
_0216CD10: .word 0x00000129
_0216CD14: .word FX_SinCosTable_
	arm_func_end ovl02_216C82C

	arm_func_start ovl02_216CD18
ovl02_216CD18: // 0x0216CD18
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r1, _0216CDC4 // =ovl02_216CDD8
	ldr r0, _0216CDC8 // =gPlayer
	str r1, [r5, #0xf4]
	ldr r0, [r0, #0]
	str r0, [r5, #0x35c]
	bl ovl02_2169F80
	strh r0, [r4, #0x26]
	add r0, r5, #0x44
	add r3, r4, #0x12c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x20]
	ldr r2, _0216CDCC // =_mt_math_rand
	bic r0, r0, #0x10
	str r0, [r4, #0x20]
	ldr r3, [r2, #0]
	ldr r0, _0216CDD0 // =0x00196225
	ldr r1, _0216CDD4 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #0x10
	strne r0, [r4, #0x20]
	ldr r0, [r4, #0x20]
	tst r0, #0x10
	mov r0, r5
	beq _0216CDAC
	mov r1, #0x21
	bl StageTask__SetAnimation
	b _0216CDB4
_0216CDAC:
	mov r1, #0x20
	bl StageTask__SetAnimation
_0216CDB4:
	mov r0, r5
	mov r1, #0x128
	bl ovl02_217873C
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216CDC4: .word ovl02_216CDD8
_0216CDC8: .word gPlayer
_0216CDCC: .word _mt_math_rand
_0216CDD0: .word 0x00196225
_0216CDD4: .word 0x3C6EF35F
	arm_func_end ovl02_216CD18

	arm_func_start ovl02_216CDD8
ovl02_216CDD8: // 0x0216CDD8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r3, [r4, #0x12c]
	ldr r0, [r4, #0x124]
	add r1, r3, #0x100
	ldrh r2, [r1, #0x74]
	ldr r1, [r4, #0x11c]
	cmp r2, #0x20
	beq _0216CE08
	cmp r2, #0x21
	beq _0216CEA0
	b _0216CF38
_0216CE08:
	ldr r2, [r3, #0xe4]
	ldr r2, [r2, #0]
	cmp r2, #0x50000
	bne _0216CE2C
	ldr r3, [r0, #0x20]
	mov r2, #0x10000
	orr r3, r3, #0x10000
	str r3, [r0, #0x20]
	str r2, [r4, #4]
_0216CE2C:
	ldr r2, [r4, #0x20]
	tst r2, #8
	ldmeqia sp!, {r4, pc}
	ldrh r2, [r0, #0x26]
	cmp r2, #2
	bls _0216CE6C
	ldr r0, [r0, #0x20]
	tst r0, #0x8000
	bne _0216CE6C
	mov r0, r4
	mov r1, #0x21
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #0x128
	bl ovl02_217873C
	ldmia sp!, {r4, pc}
_0216CE6C:
	ldr r0, [r1, #0x384]
	tst r0, #1
	mov r0, r4
	beq _0216CE88
	mov r1, #0
	bl StageTask__SetAnimation
	b _0216CE90
_0216CE88:
	mov r1, #1
	bl StageTask__SetAnimation
_0216CE90:
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}
_0216CEA0:
	ldr r2, [r3, #0xe4]
	ldr r2, [r2, #0]
	cmp r2, #0x50000
	bne _0216CEC4
	ldr r3, [r0, #0x20]
	mov r2, #0x10000
	orr r3, r3, #0x8000
	str r3, [r0, #0x20]
	str r2, [r4, #4]
_0216CEC4:
	ldr r2, [r4, #0x20]
	tst r2, #8
	ldmeqia sp!, {r4, pc}
	ldrh r2, [r0, #0x26]
	cmp r2, #2
	bls _0216CF04
	ldr r0, [r0, #0x20]
	tst r0, #0x10000
	bne _0216CF04
	mov r0, r4
	mov r1, #0x20
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #0x128
	bl ovl02_217873C
	ldmia sp!, {r4, pc}
_0216CF04:
	ldr r0, [r1, #0x384]
	tst r0, #1
	mov r0, r4
	beq _0216CF20
	mov r1, #0
	bl StageTask__SetAnimation
	b _0216CF28
_0216CF20:
	mov r1, #1
	bl StageTask__SetAnimation
_0216CF28:
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}
_0216CF38:
	ldr r2, [r0, #0]
	ldr r1, _0216CFA0 // =ovl02_217070C
	ldr r2, [r2, #0xf4]
	cmp r2, r1
	bne _0216CF60
	ldr r2, [r0, #0x20]
	mov r1, #0x10000
	bic r2, r2, #0x8000
	str r2, [r0, #0x20]
	str r1, [r4, #4]
_0216CF60:
	ldr r2, [r0, #4]
	ldr r1, _0216CFA0 // =ovl02_217070C
	ldr r2, [r2, #0xf4]
	cmp r2, r1
	bne _0216CF88
	ldr r2, [r0, #0x20]
	mov r1, #0x10000
	bic r2, r2, #0x10000
	str r2, [r0, #0x20]
	str r1, [r4, #4]
_0216CF88:
	ldr r0, [r0, #0x20]
	tst r0, #0x18000
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_216B664
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216CFA0: .word ovl02_217070C
	arm_func_end ovl02_216CDD8

	arm_func_start ovl02_216CFA4
ovl02_216CFA4: // 0x0216CFA4
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _0216D250 // =gPlayer
	mov r6, r0
	ldr r4, [r6, #0x124]
	ldr r5, [r6, #0x11c]
	ldr r1, [r1, #0]
	ldr r0, _0216D254 // =ovl02_216D370
	str r1, [r6, #0x35c]
	str r0, [r6, #0xf4]
	bl ovl02_2169F80
	strh r0, [r4, #0x26]
	mov r0, r6
	mov r1, #0xe
	bl StageTask__SetAnimation
	mov r2, #0xc8
	str r2, [r6, #0x2c]
	ldrh r1, [r4, #0x26]
	sub r0, r2, #0xd2
	mla r0, r1, r0, r2
	str r0, [r6, #0x2c]
	ldr r2, _0216D258 // =_mt_math_rand
	ldr r0, _0216D25C // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _0216D260 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	ldr r0, [r4, #0x20]
	orrne r0, r0, #0x100
	biceq r0, r0, #0x100
	str r0, [r4, #0x20]
	ldrh r0, [r4, #0x26]
	cmp r0, #0
	beq _0216D044
	cmp r0, #1
	beq _0216D050
	b _0216D084
_0216D044:
	mov r0, #0
	str r0, [r6, #0x28]
	b _0216D0DC
_0216D050:
	ldr r2, _0216D258 // =_mt_math_rand
	ldr r0, _0216D25C // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _0216D260 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #1
	str r1, [r2]
	add r0, r0, #1
	str r0, [r6, #0x28]
	b _0216D0DC
_0216D084:
	ldr r3, _0216D258 // =_mt_math_rand
	ldr r1, _0216D25C // =0x00196225
	ldr r0, [r3, #0]
	ldr r2, _0216D260 // =0x3C6EF35F
	mla ip, r0, r1, r2
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #1
	str ip, [r3]
	add r0, r0, #1
	str r0, [r6, #0x28]
	ldr r0, [r3, #0]
	mla r1, r0, r1, r2
	mov r0, r1, lsr #0x10
	str r1, [r3]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr r1, [r6, #0x28]
	and r0, r0, #1
	add r0, r1, r0
	str r0, [r6, #0x28]
_0216D0DC:
	ldr r0, [r4, #0x20]
	ldr r3, _0216D258 // =_mt_math_rand
	bic r0, r0, #0x1000
	str r0, [r4, #0x20]
	ldr r2, [r3, #0]
	ldr r0, _0216D25C // =0x00196225
	ldr r1, _0216D260 // =0x3C6EF35F
	mla ip, r2, r0, r1
	mov r2, ip, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	str ip, [r3]
	tst r2, #1
	beq _0216D154
	ldr ip, [r4, #0x20]
	mov r2, #0
	orr ip, ip, #0x1000
	str ip, [r4, #0x20]
	str r2, [r6, #0x28]
	ldrh r2, [r4, #0x26]
	cmp r2, #0
	beq _0216D154
	ldr r2, [r3, #0]
	mla r1, r2, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r3]
	and r0, r0, #1
	str r0, [r6, #0x28]
_0216D154:
	ldrh r0, [r4, #0x26]
	cmp r0, #0
	bne _0216D188
	ldr r0, [r5, #0x384]
	tst r0, #2
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #0x100
	strne r0, [r4, #0x20]
	ldr r0, [r5, #0x384]
	tst r0, #4
	ldrne r0, [r4, #0x20]
	bicne r0, r0, #0x100
	strne r0, [r4, #0x20]
_0216D188:
	ldr r0, [r6, #0x35c]
	cmp r0, #0
	beq _0216D1EC
	add r0, r0, #0x44
	add r3, r4, #0x144
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r6, #0x35c]
	add r5, r4, #0x168
	add r0, r0, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	ldr r0, [r6, #0x35c]
	add r5, r4, #0x174
	add r0, r0, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	ldr r0, [r4, #0x20]
	tst r0, #0x1000
	beq _0216D1EC
	ldrh r0, [r4, #0x26]
	cmp r0, #0
	addeq r0, r6, #0x44
	ldmeqia r0, {r0, r1, r2}
	stmeqia r3, {r0, r1, r2}
_0216D1EC:
	ldr r0, [r4, #0x2cc]
	mov r3, #0x2800
	str r0, [r4, #0x168]
	ldr r1, [r4, #0x2fc]
	mov r0, #0
	str r1, [r4, #0x174]
	ldr r1, [r4, #0x2d0]
	rsb r1, r1, #0
	str r1, [r4, #0x16c]
	ldr r2, [r4, #0x300]
	ldr r1, _0216D264 // =0x00000122
	rsb r2, r2, #0
	str r2, [r4, #0x178]
	ldr r2, [r4, #0x20]
	bic r5, r2, #0x200
	bic r2, r5, #0x400
	bic r2, r2, #0x800
	str r2, [r4, #0x20]
	str r0, [r4, #0x180]
	str r3, [r4, #0x184]
	ldrh r2, [r4, #0x26]
	add r2, r3, r2, lsl #12
	str r2, [r4, #0x184]
	bl ovl02_217873C
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216D250: .word gPlayer
_0216D254: .word ovl02_216D370
_0216D258: .word _mt_math_rand
_0216D25C: .word 0x00196225
_0216D260: .word 0x3C6EF35F
_0216D264: .word 0x00000122
	arm_func_end ovl02_216CFA4

	arm_func_start ovl02_216D268
ovl02_216D268: // 0x0216D268
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r2, _0216D36C // =ovl02_216D370
	mov r1, #0xf
	str r2, [r5, #0xf4]
	bl StageTask__SetAnimation
	ldr r0, [r5, #0x20]
	mov r1, #0x50
	orr r0, r0, #4
	str r0, [r5, #0x20]
	str r1, [r5, #0x2c]
	ldrh r0, [r4, #0x26]
	mov r0, r0, lsl #4
	rsb r0, r0, #0
	add r0, r0, #0x50
	str r0, [r5, #0x2c]
	ldr r0, [r4, #0x20]
	eor r0, r0, #0x100
	str r0, [r4, #0x20]
	ldr r0, [r5, #0x28]
	sub r0, r0, #1
	str r0, [r5, #0x28]
	ldr r0, [r4, #0x20]
	bic r0, r0, #0x200
	bic r1, r0, #0x400
	bic r0, r1, #0x800
	str r0, [r4, #0x20]
	tst r0, #0x1000
	beq _0216D2F0
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x600
	str r0, [r4, #0x20]
	b _0216D308
_0216D2F0:
	tst r0, #0x100
	ldr r0, [r4, #0x20]
	orrne r0, r0, #0x200
	strne r0, [r4, #0x20]
	orreq r0, r0, #0x400
	streq r0, [r4, #0x20]
_0216D308:
	ldr r0, [r4, #0x20]
	tst r0, #0x1000
	bne _0216D344
	tst r0, #0x100
	beq _0216D330
	add r0, r4, #0x174
	add r3, r4, #0x168
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	b _0216D34C
_0216D330:
	add r0, r4, #0x168
	add r3, r4, #0x174
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	b _0216D34C
_0216D344:
	ldr r0, [r5, #0x44]
	str r0, [r4, #0x144]
_0216D34C:
	mov r0, #0
	mov r1, #0x3800
	str r0, [r4, #0x180]
	str r1, [r4, #0x184]
	ldrh r0, [r4, #0x26]
	add r0, r1, r0, lsl #12
	str r0, [r4, #0x184]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216D36C: .word ovl02_216D370
	arm_func_end ovl02_216D268

	arm_func_start ovl02_216D370
ovl02_216D370: // 0x0216D370
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x3c
	mov r6, r0
	ldr r1, [r6, #0x12c]
	ldr r4, [r6, #0x124]
	add r1, r1, #0x100
	ldrh r2, [r1, #0x74]
	ldr r5, [r6, #0x35c]
	cmp r2, #0xe
	beq _0216D3A8
	cmp r2, #0xf
	beq _0216D408
	add sp, sp, #0x3c
	ldmia sp!, {r3, r4, r5, r6, pc}
_0216D3A8:
	ldr r1, [r6, #0x20]
	tst r1, #8
	addeq sp, sp, #0x3c
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	add r1, r2, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
	ldr r0, [r4, #0x20]
	tst r0, #0x1000
	orrne r0, r0, #0x600
	addne sp, sp, #0x3c
	strne r0, [r4, #0x20]
	ldmneia sp!, {r3, r4, r5, r6, pc}
	tst r0, #0x100
	orrne r0, r0, #0x200
	strne r0, [r4, #0x20]
	orreq r0, r0, #0x400
	add sp, sp, #0x3c
	streq r0, [r4, #0x20]
	ldmia sp!, {r3, r4, r5, r6, pc}
_0216D408:
	cmp r5, #0
	beq _0216D650
	ldr r0, [r4, #0x20]
	ldr ip, [r4, #0x184]
	tst r0, #0x1000
	add r3, sp, #0x30
	beq _0216D4D8
	add r0, r4, #0x144
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldrh r0, [r4, #0x26]
	cmp r0, #0
	beq _0216D46C
	mov r3, ip, asr #5
	stmia sp, {r3, ip}
	mov r0, #0x6000
	str r0, [sp, #8]
	ldr r0, [sp, #0x30]
	ldr r1, [r5, #0x44]
	ldr r2, [r4, #0x180]
	bl BossHelpers__Math__Func_20392BC
	str r0, [r4, #0x180]
	ldr r1, [sp, #0x30]
	add r0, r1, r0
	str r0, [sp, #0x30]
_0216D46C:
	mov r0, #0x40
	str r0, [sp]
	ldr r0, [r4, #0x16c]
	mov r1, #0x740000
	mov r2, #3
	mov r3, #0
	bl ObjShiftSet
	str r0, [r4, #0x16c]
	mov r0, #0x40
	str r0, [sp]
	ldr r0, [r4, #0x178]
	mov r1, #0x740000
	mov r2, #3
	mov r3, #0
	bl ObjShiftSet
	str r0, [r4, #0x178]
	ldr r1, [sp, #0x30]
	add r0, sp, #0x30
	add r1, r1, #0x40000
	str r1, [r4, #0x168]
	ldr r1, [sp, #0x30]
	add r3, r4, #0x144
	sub r1, r1, #0x40000
	str r1, [r4, #0x174]
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	b _0216D568
_0216D4D8:
	tst r0, #0x200
	addne r0, r4, #0x168
	addeq r0, r4, #0x174
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, ip, asr #3
	stmia sp, {r0, ip}
	mov r0, #0x1000
	str r0, [sp, #8]
	ldr r0, [sp, #0x30]
	ldr r1, [r5, #0x44]
	ldr r2, [r4, #0x180]
	mov r3, ip, asr #5
	bl BossHelpers__Math__Func_20392BC
	str r0, [r4, #0x180]
	ldr r1, [sp, #0x30]
	mov r2, #3
	add r0, r1, r0
	str r0, [sp, #0x30]
	mov r0, #0x40
	str r0, [sp]
	ldr r0, [sp, #0x34]
	mov r1, #0x740000
	mov r3, #0
	bl ObjShiftSet
	str r0, [sp, #0x34]
	ldr r0, [r4, #0x20]
	tst r0, #0x200
	add r0, sp, #0x30
	addeq r3, r4, #0x174
	ldmeqia r0, {r0, r1, r2}
	stmeqia r3, {r0, r1, r2}
	beq _0216D568
	add r3, r4, #0x168
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
_0216D568:
	ldrh r0, [r4, #0x26]
	cmp r0, #0
	bne _0216D580
	ldr r0, [r4, #0x20]
	tst r0, #0x1000
	bne _0216D5B0
_0216D580:
	ldr r3, [sp, #0x30]
	ldr r0, [r6, #0x44]
	ldr r2, [sp, #0x38]
	ldr r1, [r6, #0x4c]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r1, r0
	ldrh r0, [r6, #0x32]
	mov r2, #0x100
	bl ObjRoopMove16
	strh r0, [r6, #0x32]
_0216D5B0:
	ldr r3, [r5, #0x48]
	ldr r0, [r4, #0x2d0]
	ldr r2, [r5, #0x4c]
	ldr r1, [r6, #0x4c]
	add r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r1, r0
	ldrh r0, [r6, #0x30]
	mov r2, #0x100
	bl ObjRoopMove16
	strh r0, [r6, #0x30]
	ldrh r1, [r6, #0x32]
	ldr r3, _0216D670 // =FX_SinCosTable_
	add r0, sp, #0xc
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	ldrh r1, [r6, #0x30]
	ldr r0, [r6, #0x12c]
	ldr r3, _0216D670 // =FX_SinCosTable_
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r2, r1, #1
	mov r1, r1, lsl #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	add r0, r0, #0x24
	bl MTX_RotX33_
	ldr r2, [r6, #0x12c]
	add r1, sp, #0xc
	add r0, r2, #0x24
	add r2, r2, #0x24
	bl MTX_Concat33
_0216D650:
	ldr r0, [r6, #0x20]
	tst r0, #8
	addeq sp, sp, #0x3c
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	mov r0, r6
	bl ovl02_216D674
	add sp, sp, #0x3c
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0216D670: .word FX_SinCosTable_
	arm_func_end ovl02_216D370

	arm_func_start ovl02_216D674
ovl02_216D674: // 0x0216D674
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r2, _0216D6E4 // =ovl02_216D6E8
	mov r1, #0x10
	str r2, [r5, #0xf4]
	bl StageTask__SetAnimation
	ldr r0, [r5, #0x20]
	mov r2, #0x27
	orr r0, r0, #4
	str r0, [r5, #0x20]
	str r2, [r5, #0x2c]
	ldrh r1, [r4, #0x26]
	sub r0, r2, #0x2e
	mla r0, r1, r0, r2
	str r0, [r5, #0x2c]
	ldr r0, [r4, #0x20]
	tst r0, #0x1000
	ldrne r0, [r5, #0x2c]
	addne r0, r0, #8
	strne r0, [r5, #0x2c]
	ldr r1, [r4, #0x20]
	mov r0, r5
	orr r2, r1, #0x800
	mov r1, #0xb9
	str r2, [r4, #0x20]
	bl ovl02_217873C
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216D6E4: .word ovl02_216D6E8
	arm_func_end ovl02_216D674

	arm_func_start ovl02_216D6E8
ovl02_216D6E8: // 0x0216D6E8
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x48
	mov r5, r0
	ldr r2, [r5, #0x12c]
	ldr r4, [r5, #0x124]
	add r1, r2, #0x100
	ldrh r1, [r1, #0x74]
	cmp r1, #0x10
	beq _0216D720
	cmp r1, #0x11
	cmpne r1, #0x12
	beq _0216D818
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
_0216D720:
	ldr r1, [r5, #0x2c]
	cmp r1, #1
	bne _0216D7A0
	ldr r1, [r4, #0x20]
	tst r1, #0x1000
	beq _0216D758
	ldr r1, [r4, #0x168]
	ldr r2, [r4, #0x16c]
	bl ovl02_2172108
	ldr r1, [r4, #0x174]
	ldr r2, [r4, #0x178]
	mov r0, r5
	bl ovl02_2172108
	b _0216D774
_0216D758:
	tst r1, #0x200
	ldrne r1, [r4, #0x168]
	ldrne r2, [r4, #0x16c]
	ldreq r1, [r4, #0x174]
	ldreq r2, [r4, #0x178]
	mov r0, r5
	bl ovl02_2172108
_0216D774:
	ldr r1, _0216D9C8 // =0x00000123
	mov r0, r5
	bl ovl02_217873C
	ldr r1, [r4, #0x20]
	mov r0, #0x10000
	bic r1, r1, #0x600
	bic r1, r1, #0x800
	str r1, [r4, #0x20]
	str r0, [r5, #4]
	mov r0, #0x6000
	str r0, [r5, #8]
_0216D7A0:
	ldr r0, [r5, #0x2c]
	sub r0, r0, #1
	cmp r0, #0
	addgt sp, sp, #0x48
	str r0, [r5, #0x2c]
	ldmgtia sp!, {r3, r4, r5, pc}
	ldr r0, _0216D9CC // =gPlayer
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x5d8]
	tst r0, #0x200000
	movne r0, #0
	strne r0, [r5, #0x28]
	ldr r0, [r5, #0x28]
	cmp r0, #0
	beq _0216D7F0
	mov r0, r5
	mov r1, #0x12
	bl StageTask__SetAnimation
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
_0216D7F0:
	ldr r1, [r5, #0x12c]
	mov r0, r5
	add r1, r1, #0x100
	ldrh r1, [r1, #0x74]
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
_0216D818:
	ldr r0, [r5, #0x28]
	cmp r0, #0
	beq _0216D8D4
	ldr r0, [r4, #0x20]
	tst r0, #0x1000
	beq _0216D8B4
	ldrh r0, [r5, #0x32]
	mov r1, #0
	mov r2, #0xa0
	bl ObjRoopMove16
	strh r0, [r5, #0x32]
	ldrh r1, [r5, #0x32]
	ldr r3, _0216D9D0 // =FX_SinCosTable_
	add r0, sp, #0x24
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	ldrh r0, [r5, #0x30]
	ldr r2, _0216D9D0 // =FX_SinCosTable_
	ldr r3, [r5, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotX33_
	ldr r2, [r5, #0x12c]
	add r1, sp, #0x24
	add r0, r2, #0x24
	add r2, r2, #0x24
	bl MTX_Concat33
_0216D8B4:
	ldr r0, [r5, #0x20]
	tst r0, #8
	addeq sp, sp, #0x48
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl ovl02_216D268
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
_0216D8D4:
	ldr r0, [r2, #0xe4]
	ldr r0, [r0, #0]
	cmp r0, #0xe000
	blt _0216D8F8
	ldrh r0, [r5, #0x30]
	mov r1, #0
	mov r2, #0x180
	bl ObjRoopMove16
	strh r0, [r5, #0x30]
_0216D8F8:
	ldr r0, [r5, #0x12c]
	ldr r0, [r0, #0xe4]
	ldr r0, [r0, #0]
	cmp r0, #0x10000
	blt _0216D990
	ldrh r0, [r5, #0x32]
	mov r1, #0
	mov r2, #0xa0
	bl ObjRoopMove16
	strh r0, [r5, #0x32]
	ldrh r1, [r5, #0x32]
	ldr r3, _0216D9D0 // =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	ldrh r0, [r5, #0x30]
	ldr r2, _0216D9D0 // =FX_SinCosTable_
	ldr r3, [r5, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotX33_
	ldr r2, [r5, #0x12c]
	add r1, sp, #0
	add r0, r2, #0x24
	add r2, r2, #0x24
	bl MTX_Concat33
_0216D990:
	ldr r0, [r5, #0x20]
	tst r0, #8
	addeq sp, sp, #0x48
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5, #0x32]
	cmp r0, #0
	ldreqh r0, [r5, #0x30]
	cmpeq r0, #0
	addne sp, sp, #0x48
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl ovl02_216B664
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216D9C8: .word 0x00000123
_0216D9CC: .word gPlayer
_0216D9D0: .word FX_SinCosTable_
	arm_func_end ovl02_216D6E8

	arm_func_start ovl02_216D9D4
ovl02_216D9D4: // 0x0216D9D4
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _0216DA40 // =gPlayer
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r1, [r1, #0]
	ldr r0, _0216DA44 // =ovl02_216DA54
	str r1, [r5, #0x35c]
	str r0, [r5, #0xf4]
	bl ovl02_2169F80
	strh r0, [r4, #0x26]
	ldr r2, _0216DA48 // =_mt_math_rand
	ldr r0, _0216DA4C // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _0216DA50 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	ldr r0, [r4, #0x20]
	orrne r0, r0, #0x2000
	orreq r0, r0, #0x4000
	str r0, [r4, #0x20]
	mov r0, #0
	str r0, [r5, #0x2c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216DA40: .word gPlayer
_0216DA44: .word ovl02_216DA54
_0216DA48: .word _mt_math_rand
_0216DA4C: .word 0x00196225
_0216DA50: .word 0x3C6EF35F
	arm_func_end ovl02_216D9D4

	arm_func_start ovl02_216DA54
ovl02_216DA54: // 0x0216DA54
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x124]
	ldr r2, _0216DB00 // =ovl02_2171118
	ldr r3, [r1, #8]
	ldr r3, [r3, #0xf4]
	cmp r3, r2
	bne _0216DA84
	ldr r3, [r1, #0x20]
	mov r2, #0x10000
	bic r3, r3, #0x2000
	str r3, [r1, #0x20]
	str r2, [r0, #4]
_0216DA84:
	ldr r3, [r1, #0xc]
	ldr r2, _0216DB00 // =ovl02_2171118
	ldr r3, [r3, #0xf4]
	cmp r3, r2
	bne _0216DAAC
	ldr r3, [r1, #0x20]
	mov r2, #0x10000
	bic r3, r3, #0x4000
	str r3, [r1, #0x20]
	str r2, [r0, #4]
_0216DAAC:
	ldrh r2, [r1, #0x26]
	cmp r2, #1
	bls _0216DAEC
	ldr r2, [r0, #0x2c]
	add r2, r2, #1
	str r2, [r0, #0x2c]
	cmp r2, #0x30
	bne _0216DAEC
	ldr r2, [r1, #0x20]
	tst r2, #0x2000
	orrne r2, r2, #0x4000
	strne r2, [r1, #0x20]
	ldr r2, [r1, #0x20]
	tst r2, #0x4000
	orrne r2, r2, #0x2000
	strne r2, [r1, #0x20]
_0216DAEC:
	ldr r1, [r1, #0x20]
	tst r1, #0x6000
	ldmneia sp!, {r3, pc}
	bl ovl02_216B664
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216DB00: .word ovl02_2171118
	arm_func_end ovl02_216DA54

	arm_func_start ovl02_216DB04
ovl02_216DB04: // 0x0216DB04
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _0216DB58 // =gPlayer
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r1, [r1, #0]
	ldr r0, _0216DB5C // =ovl02_216DB64
	str r1, [r5, #0x35c]
	str r0, [r5, #0xf4]
	bl ovl02_2169F80
	strh r0, [r4, #0x26]
	mov r0, r5
	mov r1, #0x13
	bl StageTask__SetAnimation
	mov r0, #0
	str r0, [r5, #0x2c]
	ldr r2, [r5, #0x44]
	ldr r1, _0216DB60 // =0x0000012A
	mov r0, r5
	str r2, [r4, #0x158]
	bl ovl02_217873C
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216DB58: .word gPlayer
_0216DB5C: .word ovl02_216DB64
_0216DB60: .word 0x0000012A
	arm_func_end ovl02_216DB04

	arm_func_start ovl02_216DB64
ovl02_216DB64: // 0x0216DB64
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x2c]
	ldr r4, [r5, #0x124]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #0x14
	bne _0216DBA8
	mov r0, #0x70000
	rsb r0, r0, #0
	bl ovl02_216A014
	mov r0, #0x20000
	rsb r0, r0, #0
	bl ovl02_216A034
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x40
	str r0, [r4, #0x20]
_0216DBA8:
	ldr r0, [r5, #0x20]
	tst r0, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r2, _0216DC4C // =_mt_math_rand
	ldr r0, _0216DC50 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _0216DC54 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r3, r0, #3
	str r1, [r2]
	add r0, r4, #0x100
	cmp r3, #3
	ldrh r0, [r0, #0x8a]
	moveq r3, #0
	cmp r0, r3
	bne _0216DC08
	add r0, r3, #1
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	cmp r3, #3
	moveq r3, #0
_0216DC08:
	cmp r3, #1
	beq _0216DC2C
	cmp r3, #2
	add r1, r4, #0x100
	mov r0, r5
	beq _0216DC40
	strh r3, [r1, #0x8a]
	bl ovl02_216DC58
	ldmia sp!, {r3, r4, r5, pc}
_0216DC2C:
	add r1, r4, #0x100
	mov r0, r5
	strh r3, [r1, #0x8a]
	bl ovl02_216DF48
	ldmia sp!, {r3, r4, r5, pc}
_0216DC40:
	strh r3, [r1, #0x8a]
	bl ovl02_216E34C
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216DC4C: .word _mt_math_rand
_0216DC50: .word 0x00196225
_0216DC54: .word 0x3C6EF35F
	arm_func_end ovl02_216DB64

	arm_func_start ovl02_216DC58
ovl02_216DC58: // 0x0216DC58
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r2, _0216DCB0 // =ovl02_216DCB4
	mov r1, #0x14
	str r2, [r5, #0xf4]
	bl StageTask__SetAnimation
	ldr r0, [r5, #0x20]
	mov r3, #0x5a
	orr r0, r0, #4
	str r0, [r5, #0x20]
	str r3, [r5, #0x2c]
	ldrh r2, [r4, #0x26]
	sub r0, r3, #0x5f
	mov r1, #0
	mla r0, r2, r0, r3
	str r0, [r5, #0x2c]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x40
	str r0, [r4, #0x20]
	str r1, [r4, #0x15c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216DCB0: .word ovl02_216DCB4
	arm_func_end ovl02_216DC58

	arm_func_start ovl02_216DCB4
ovl02_216DCB4: // 0x0216DCB4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	ldr r5, [r7, #0x35c]
	ldr r4, [r7, #0x124]
	cmp r5, #0
	beq _0216DD0C
	ldr r3, [r5, #0x44]
	ldr r0, [r7, #0x44]
	ldr r2, [r5, #0x4c]
	ldr r1, [r7, #0x4c]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r6, r0
	mov r1, r6
	mov r0, #0
	bl ObjRoopDiff16
	add r0, r6, r0, asr #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ovl02_2169FF0
_0216DD0C:
	ldr r0, [r7, #8]
	cmp r0, #0
	bne _0216DE24
	ldr r0, [r7, #0x20]
	tst r0, #4
	beq _0216DE24
	ldr r0, [r7, #0x12c]
	ldrh r2, [r4, #0x26]
	add r0, r0, #0x100
	ldrh r1, [r0, #0x74]
	mov r3, #0x6000
	mov r0, #0xa00
	mla r3, r2, r0, r3
	cmp r1, #0x15
	moveq r3, r3, asr #1
	mov r0, r3, asr #3
	stmia sp, {r0, r3}
	mov r0, #0x1000
	str r0, [sp, #8]
	ldr r0, [r4, #0x158]
	ldr r1, [r5, #0x44]
	ldr r2, [r4, #0x15c]
	mov r3, r3, asr #4
	bl BossHelpers__Math__Func_20392BC
	str r0, [r4, #0x15c]
	ldr r1, [r4, #0x158]
	add r3, r1, r0
	str r3, [r4, #0x158]
	ldr r0, [r7, #0x44]
	ldr r2, [r5, #0x4c]
	ldr r1, [r7, #0x4c]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	strh r0, [r7, #0x32]
	ldrh r0, [r7, #0x32]
	ldr r2, _0216DF44 // =FX_SinCosTable_
	ldr r3, [r7, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotY33_
	ldr r0, [r7, #0x12c]
	ldrh r2, [r4, #0x26]
	add r0, r0, #0x100
	ldrh r1, [r0, #0x74]
	mov r0, #0x28
	add r0, r0, r2, lsl #3
	mov r0, r0, lsl #0x10
	cmp r1, #0x15
	mov r6, r0, asr #0x10
	moveq r0, r6, lsl #0xf
	moveq r6, r0, asr #0x10
	ldr r3, [r5, #0x48]
	ldr r0, [r4, #0x330]
	ldr r2, [r5, #0x4c]
	ldr r1, [r7, #0x4c]
	add r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r1, r0
	ldrh r0, [r4, #0x28]
	mov r2, r6
	bl ObjRoopMove16
	strh r0, [r4, #0x28]
_0216DE24:
	ldr r0, [r7, #0x12c]
	add r0, r0, #0x100
	ldrh r0, [r0, #0x74]
	cmp r0, #0x14
	beq _0216DE48
	cmp r0, #0x15
	beq _0216DEC4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0216DE48:
	ldr r0, [r7, #0x2c]
	cmp r0, #0x10
	bne _0216DE64
	mov r0, #0x8000
	str r0, [r7, #4]
	mov r0, #0x10000
	str r0, [r7, #8]
_0216DE64:
	ldr r0, [r7, #0x2c]
	subs r0, r0, #1
	addpl sp, sp, #0xc
	str r0, [r7, #0x2c]
	ldmplia sp!, {r4, r5, r6, r7, pc}
	ldr r1, [r7, #0x12c]
	mov r0, r7
	add r1, r1, #0x100
	ldrh r1, [r1, #0x74]
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r0, [r7, #0x20]
	mov r2, #0x46
	orr r0, r0, #4
	str r0, [r7, #0x20]
	str r2, [r7, #0x2c]
	ldrh r1, [r4, #0x26]
	mov r0, #0x23
	add sp, sp, #0xc
	mla r0, r1, r0, r2
	str r0, [r7, #0x2c]
	ldmia sp!, {r4, r5, r6, r7, pc}
_0216DEC4:
	ldr r0, [r7, #0x20]
	tst r0, #4
	ldr r0, [r7, #0x2c]
	beq _0216DF24
	tst r0, #7
	bne _0216DEE4
	mov r0, r7
	bl ovl02_216E814
_0216DEE4:
	ldr r0, [r7, #0x2c]
	subs r0, r0, #1
	addpl sp, sp, #0xc
	str r0, [r7, #0x2c]
	ldmplia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r7, #0x20]
	mov r2, #0x20
	bic r0, r0, #4
	str r0, [r7, #0x20]
	str r2, [r7, #0x2c]
	ldrh r1, [r4, #0x26]
	sub r0, r2, #0x25
	add sp, sp, #0xc
	mla r0, r1, r0, r2
	str r0, [r7, #0x2c]
	ldmia sp!, {r4, r5, r6, r7, pc}
_0216DF24:
	subs r0, r0, #1
	addpl sp, sp, #0xc
	str r0, [r7, #0x2c]
	ldmplia sp!, {r4, r5, r6, r7, pc}
	mov r0, r7
	bl ovl02_216E740
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216DF44: .word FX_SinCosTable_
	arm_func_end ovl02_216DCB4

	arm_func_start ovl02_216DF48
ovl02_216DF48: // 0x0216DF48
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	ldr r5, [r6, #0x11c]
	ldr r2, _0216E0B0 // =ovl02_216E0C0
	mov r1, #0x14
	str r2, [r6, #0xf4]
	bl StageTask__SetAnimation
	ldr r0, [r6, #0x20]
	mov r1, #0
	orr r0, r0, #4
	str r0, [r6, #0x20]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x40
	str r0, [r4, #0x20]
	str r1, [r6, #0x2c]
	str r1, [r6, #0x28]
	ldrh r0, [r4, #0x26]
	cmp r0, #0
	beq _0216DFAC
	cmp r0, #1
	beq _0216DFB4
	cmp r0, #4
	beq _0216DFF0
	b _0216DFE4
_0216DFAC:
	str r1, [r6, #0x28]
	b _0216E020
_0216DFB4:
	ldr r2, _0216E0B4 // =_mt_math_rand
	ldr r0, _0216E0B8 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _0216E0BC // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	and r0, r0, #1
	str r0, [r6, #0x28]
	b _0216E020
_0216DFE4:
	mov r0, #1
	str r0, [r6, #0x28]
	b _0216E020
_0216DFF0:
	ldr r2, _0216E0B4 // =_mt_math_rand
	ldr r0, _0216E0B8 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _0216E0BC // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #1
	str r1, [r2]
	add r0, r0, #2
	str r0, [r6, #0x28]
_0216E020:
	mov r2, #0x4000
	str r2, [r4, #0x15c]
	ldrh r1, [r4, #0x26]
	add r0, r4, #0x100
	add r1, r2, r1, lsl #12
	str r1, [r4, #0x15c]
	mov r1, #0x300
	strh r1, [r0, #0x64]
	ldr r2, _0216E0B4 // =_mt_math_rand
	ldr r0, _0216E0B8 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _0216E0BC // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	beq _0216E088
	mov r0, #0x30000
	str r0, [r4, #0x158]
	ldr r0, [r5, #0x384]
	tst r0, #2
	movne r0, #0xb4000
	strne r0, [r4, #0x158]
	ldmia sp!, {r4, r5, r6, pc}
_0216E088:
	mov r0, #0x2c0000
	str r0, [r4, #0x158]
	ldr r0, [r5, #0x384]
	tst r0, #4
	movne r0, #0x23c000
	strne r0, [r4, #0x158]
	ldr r0, [r4, #0x15c]
	rsb r0, r0, #0
	str r0, [r4, #0x15c]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216E0B0: .word ovl02_216E0C0
_0216E0B4: .word _mt_math_rand
_0216E0B8: .word 0x00196225
_0216E0BC: .word 0x3C6EF35F
	arm_func_end ovl02_216DF48

	arm_func_start ovl02_216E0C0
ovl02_216E0C0: // 0x0216E0C0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r0
	ldr r1, [r7, #0x35c]
	ldr r4, [r7, #0x124]
	cmp r1, #0
	ldr r5, [r7, #0x11c]
	mov r6, #0
	beq _0216E11C
	ldr r3, [r1, #0x44]
	ldr r0, [r7, #0x44]
	ldr r2, [r1, #0x4c]
	ldr r1, [r7, #0x4c]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r8, r0
	mov r1, r8
	mov r0, r6
	bl ObjRoopDiff16
	add r0, r8, r0, asr #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ovl02_2169FF0
_0216E11C:
	ldr r0, [r7, #0x12c]
	add r0, r0, #0x100
	ldrh r0, [r0, #0x74]
	cmp r0, #0x14
	beq _0216E13C
	cmp r0, #0x15
	beq _0216E20C
	b _0216E314
_0216E13C:
	ldr r0, [r7, #0x4c]
	ldr r3, [r4, #0x158]
	ldr r2, [r7, #0x44]
	rsb r1, r0, #0
	sub r0, r3, r2
	bl FX_Atan2Idx
	mov r5, r0
	ldrh r0, [r7, #0x32]
	mov r1, r5
	mov r2, #0xc0
	bl ObjRoopMove16
	strh r0, [r7, #0x32]
	add r1, r4, #0x100
	ldrh r0, [r4, #0x28]
	ldrh r1, [r1, #0x64]
	mov r2, #0xc0
	bl ObjRoopMove16
	strh r0, [r4, #0x28]
	ldr r0, [r7, #0x2c]
	cmp r0, #0
	bne _0216E1C4
	ldrh r0, [r7, #0x32]
	cmp r5, r0
	bne _0216E314
	add r0, r4, #0x100
	ldrh r1, [r4, #0x28]
	ldrh r0, [r0, #0x64]
	cmp r1, r0
	bne _0216E314
	mov r0, #0x8000
	str r0, [r7, #4]
	mov r0, #0x10
	str r0, [r7, #0x2c]
	b _0216E314
_0216E1C4:
	sub r0, r0, #1
	str r0, [r7, #0x2c]
	cmp r0, #0
	bgt _0216E314
	ldr r1, [r7, #0x12c]
	mov r0, r7
	add r1, r1, #0x100
	ldrh r1, [r1, #0x74]
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r1, [r7, #0x20]
	mov r0, #0
	orr r1, r1, #4
	str r1, [r7, #0x20]
	str r0, [r7, #0x2c]
	b _0216E314
_0216E20C:
	ldr r0, [r7, #0x20]
	tst r0, #4
	beq _0216E2F8
	ldr r1, [r4, #0x158]
	ldr r0, [r4, #0x15c]
	add r2, r1, r0
	str r2, [r4, #0x158]
	ldr r1, [r7, #0x4c]
	ldr r0, [r7, #0x44]
	rsb r1, r1, #0
	sub r0, r2, r0
	bl FX_Atan2Idx
	strh r0, [r7, #0x32]
	ldr r0, [r7, #0x2c]
	tst r0, #7
	bne _0216E254
	mov r0, r7
	bl ovl02_216E814
_0216E254:
	ldr r0, [r7, #0x2c]
	add r0, r0, #1
	str r0, [r7, #0x2c]
	ldr r0, [r4, #0x15c]
	cmp r0, #0
	ldr r0, [r5, #0x384]
	bge _0216E28C
	tst r0, #2
	mov r1, #0x30000
	ldr r0, [r4, #0x158]
	movne r1, #0xb4000
	cmp r1, r0
	movgt r6, #1
	b _0216E2A4
_0216E28C:
	tst r0, #4
	mov r1, #0x2c0000
	ldr r0, [r4, #0x158]
	movne r1, #0x23c000
	cmp r1, r0
	movlt r6, #1
_0216E2A4:
	cmp r6, #0
	beq _0216E314
	ldr r0, [r7, #0x28]
	cmp r0, #0
	beq _0216E2D0
	sub r0, r0, #1
	str r0, [r7, #0x28]
	ldr r0, [r4, #0x15c]
	rsb r0, r0, #0
	str r0, [r4, #0x15c]
	b _0216E314
_0216E2D0:
	ldr r0, [r7, #0x20]
	mov r2, #0x20
	bic r0, r0, #4
	str r0, [r7, #0x20]
	str r2, [r7, #0x2c]
	ldrh r1, [r4, #0x26]
	sub r0, r2, #0x25
	mla r0, r1, r0, r2
	str r0, [r7, #0x2c]
	b _0216E314
_0216E2F8:
	ldr r0, [r7, #0x2c]
	sub r0, r0, #1
	str r0, [r7, #0x2c]
	cmp r0, #0
	bgt _0216E314
	mov r0, r7
	bl ovl02_216E740
_0216E314:
	ldrh r0, [r7, #0x32]
	ldr r3, [r7, #0x12c]
	ldr r2, _0216E348 // =FX_SinCosTable_
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotY33_
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216E348: .word FX_SinCosTable_
	arm_func_end ovl02_216E0C0

	arm_func_start ovl02_216E34C
ovl02_216E34C: // 0x0216E34C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r2, _0216E448 // =ovl02_216E458
	mov r1, #0x14
	str r2, [r5, #0xf4]
	bl StageTask__SetAnimation
	ldr r0, [r5, #0x20]
	mov r2, #0x5a
	orr r0, r0, #4
	str r0, [r5, #0x20]
	str r2, [r5, #0x2c]
	ldrh r1, [r4, #0x26]
	mov r0, #0xa
	mla r0, r1, r0, r2
	str r0, [r5, #0x2c]
	mov r0, #2
	str r0, [r5, #0x28]
	ldrh r0, [r4, #0x26]
	cmp r0, #1
	bls _0216E3FC
	ldr r3, _0216E44C // =_mt_math_rand
	ldr r1, _0216E450 // =0x00196225
	ldr r0, [r3, #0]
	ldr r2, _0216E454 // =0x3C6EF35F
	mla ip, r0, r1, r2
	mov r0, ip, lsr #0x10
	str ip, [r3]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr ip, [r5, #0x28]
	and r0, r0, #1
	add r0, ip, r0
	str r0, [r5, #0x28]
	ldr r0, [r3, #0]
	mla r1, r0, r1, r2
	mov r0, r1, lsr #0x10
	str r1, [r3]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr r1, [r5, #0x28]
	and r0, r0, #1
	add r0, r1, r0
	str r0, [r5, #0x28]
_0216E3FC:
	mov r3, #0xf200
	add r1, r4, #0x100
	strh r3, [r1, #0x64]
	ldrh r2, [r4, #0x26]
	mov r0, #0x280
	mla r0, r2, r0, r3
	strh r0, [r1, #0x64]
	ldr r0, [r4, #0x20]
	mov r1, #0x6000
	orr r0, r0, #0x40
	str r0, [r4, #0x20]
	mov r0, #0
	str r0, [r4, #0x15c]
	str r1, [r4, #0x160]
	ldrh r0, [r4, #0x26]
	add r0, r0, r0, lsl #1
	add r0, r1, r0, lsl #10
	str r0, [r4, #0x160]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216E448: .word ovl02_216E458
_0216E44C: .word _mt_math_rand
_0216E450: .word 0x00196225
_0216E454: .word 0x3C6EF35F
	arm_func_end ovl02_216E34C

	arm_func_start ovl02_216E458
ovl02_216E458: // 0x0216E458
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r6, r0
	ldr r5, [r6, #0x35c]
	ldr r4, [r6, #0x124]
	cmp r5, #0
	beq _0216E4B0
	ldr r3, [r5, #0x44]
	ldr r0, [r6, #0x44]
	ldr r2, [r5, #0x4c]
	ldr r1, [r6, #0x4c]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r7, r0
	mov r1, r7
	mov r0, #0
	bl ObjRoopDiff16
	add r0, r7, r0, asr #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ovl02_2169FF0
_0216E4B0:
	ldr r0, [r6, #0x12c]
	add r0, r0, #0x100
	ldrh r0, [r0, #0x74]
	cmp r0, #0x14
	beq _0216E4D4
	cmp r0, #0x15
	beq _0216E634
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0216E4D4:
	add r1, r4, #0x100
	ldrh r0, [r4, #0x28]
	ldrh r1, [r1, #0x64]
	mov r2, #0x120
	bl ObjRoopMove16
	strh r0, [r4, #0x28]
	ldr r0, [r6, #8]
	cmp r0, #0
	bne _0216E5AC
	ldr ip, [r4, #0x160]
	cmp ip, #0xa800
	bge _0216E52C
	mov r0, ip, asr #3
	stmia sp, {r0, ip}
	mov r0, #0x1000
	str r0, [sp, #8]
	ldr r0, [r4, #0x158]
	ldr r1, [r5, #0x44]
	ldr r2, [r4, #0x15c]
	mov r3, ip, asr #4
	bl BossHelpers__Math__Func_20392BC
	b _0216E54C
_0216E52C:
	mov r3, ip, asr #1
	stmia sp, {r3, ip}
	mov r0, #0x1000
	str r0, [sp, #8]
	ldr r0, [r4, #0x158]
	ldr r1, [r5, #0x44]
	ldr r2, [r4, #0x15c]
	bl BossHelpers__Math__Func_20392BC
_0216E54C:
	str r0, [r4, #0x15c]
	ldr r1, [r4, #0x158]
	ldr r0, [r4, #0x15c]
	add r3, r1, r0
	str r3, [r4, #0x158]
	ldr r0, [r6, #0x44]
	ldr r2, [r5, #0x4c]
	ldr r1, [r6, #0x4c]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	strh r0, [r6, #0x32]
	ldrh r0, [r6, #0x32]
	ldr r2, _0216E73C // =FX_SinCosTable_
	ldr r3, [r6, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotY33_
_0216E5AC:
	ldr r0, [r4, #0x160]
	cmp r0, #0xa800
	ldr r0, [r6, #0x2c]
	bge _0216E5D4
	cmp r0, #0x10
	bne _0216E5E4
	mov r0, #0x10000
	str r0, [r6, #4]
	str r0, [r6, #8]
	b _0216E5E4
_0216E5D4:
	cmp r0, #6
	moveq r0, #0x6000
	streq r0, [r6, #4]
	streq r0, [r6, #8]
_0216E5E4:
	ldr r0, [r6, #0x2c]
	subs r0, r0, #1
	addpl sp, sp, #0xc
	str r0, [r6, #0x2c]
	ldmplia sp!, {r4, r5, r6, r7, pc}
	ldr r1, [r6, #0x12c]
	mov r0, r6
	add r1, r1, #0x100
	ldrh r1, [r1, #0x74]
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r1, [r6, #0x20]
	mov r0, #0
	orr r1, r1, #4
	str r1, [r6, #0x20]
	add sp, sp, #0xc
	str r0, [r6, #0x2c]
	ldmia sp!, {r4, r5, r6, r7, pc}
_0216E634:
	ldr r0, [r6, #0x20]
	tst r0, #4
	beq _0216E718
	ldrh r0, [r4, #0x28]
	mov r1, #0x800
	mov r2, #0x80
	bl ObjRoopMove16
	strh r0, [r4, #0x28]
	ldr r0, [r6, #0x2c]
	tst r0, #7
	bne _0216E668
	mov r0, r6
	bl ovl02_216E814
_0216E668:
	ldr r0, [r6, #0x2c]
	add r0, r0, #1
	str r0, [r6, #0x2c]
	ldrh r0, [r4, #0x28]
	cmp r0, #0x800
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r6, #0x28]
	cmp r0, #0
	bne _0216E6BC
	ldr r0, [r6, #0x20]
	mov r2, #0x20
	bic r0, r0, #4
	str r0, [r6, #0x20]
	str r2, [r6, #0x2c]
	ldrh r1, [r4, #0x26]
	sub r0, r2, #0x25
	add sp, sp, #0xc
	mla r0, r1, r0, r2
	str r0, [r6, #0x2c]
	ldmia sp!, {r4, r5, r6, r7, pc}
_0216E6BC:
	sub r1, r0, #1
	str r1, [r6, #0x28]
	mov r0, r6
	mov r1, #0x14
	bl StageTask__SetAnimation
	ldr r0, [r6, #0x20]
	mov r1, #0x1e
	orr r0, r0, #4
	str r0, [r6, #0x20]
	str r1, [r6, #0x2c]
	ldrh r0, [r4, #0x26]
	mov r2, #0xa800
	add sp, sp, #0xc
	mov r0, r0, lsl #2
	rsb r0, r0, #0
	add r0, r0, #0x1e
	str r0, [r6, #0x2c]
	str r2, [r4, #0x160]
	ldrh r1, [r4, #0x26]
	mov r0, #0x1800
	mla r0, r1, r0, r2
	str r0, [r4, #0x160]
	ldmia sp!, {r4, r5, r6, r7, pc}
_0216E718:
	ldr r0, [r6, #0x2c]
	subs r0, r0, #1
	addpl sp, sp, #0xc
	str r0, [r6, #0x2c]
	ldmplia sp!, {r4, r5, r6, r7, pc}
	mov r0, r6
	bl ovl02_216E740
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216E73C: .word FX_SinCosTable_
	arm_func_end ovl02_216E458

	arm_func_start ovl02_216E740
ovl02_216E740: // 0x0216E740
	ldr r2, _0216E754 // =ovl02_216E75C
	ldr ip, _0216E758 // =StageTask__SetAnimation
	mov r1, #0x16
	str r2, [r0, #0xf4]
	bx ip
	.align 2, 0
_0216E754: .word ovl02_216E75C
_0216E758: .word StageTask__SetAnimation
	arm_func_end ovl02_216E740

	arm_func_start ovl02_216E75C
ovl02_216E75C: // 0x0216E75C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	mov r1, #0
	ldrh r0, [r4, #0x28]
	mov r2, #0x80
	bl ObjRoopMove16
	strh r0, [r4, #0x28]
	ldrh r0, [r5, #0x32]
	mov r1, #0
	mov r2, #0x100
	bl ObjRoopMove16
	strh r0, [r5, #0x32]
	ldrh r0, [r5, #0x32]
	ldr r2, _0216E810 // =FX_SinCosTable_
	ldr r3, [r5, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotY33_
	ldr r0, [r5, #0x20]
	tst r0, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r4, #0x28]
	cmp r0, #0
	ldreqh r0, [r5, #0x32]
	cmpeq r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, [r4, #0x20]
	mov r0, #0
	bic r1, r1, #0x40
	str r1, [r4, #0x20]
	bl ovl02_216A014
	mov r0, #0
	bl ovl02_216A034
	mov r0, #0
	bl ovl02_2169FF0
	mov r0, r5
	bl ovl02_216B664
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216E810: .word FX_SinCosTable_
	arm_func_end ovl02_216E75C

	arm_func_start ovl02_216E814
ovl02_216E814: // 0x0216E814
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x3c
	mov r5, r0
	ldr r4, [r5, #0x124]
	add r1, sp, #0x30
	mov r0, #0
	str r0, [r1]
	str r0, [r1, #4]
	str r0, [r1, #8]
	ldr r0, [r4, #0x158]
	mov r1, #0x900
	str r0, [sp, #0x30]
	ldr r0, [r4, #0x330]
	rsb r0, r0, #0
	str r0, [sp, #0x34]
	ldrsh r0, [r4, #0x28]
	bl FX_Div
	mov r1, #0x38000
	umull ip, r3, r0, r1
	mov r2, #0
	mla r3, r0, r2, r3
	mov r0, r0, asr #0x1f
	mla r3, r0, r1, r3
	adds ip, ip, #0x800
	adc r0, r3, #0
	mov r1, ip, lsr #0xc
	orr r1, r1, r0, lsl #20
	ldr r2, [sp, #0x34]
	mov r0, r5
	add r2, r2, r1
	add r1, sp, #0x30
	str r2, [sp, #0x34]
	bl ovl02_216E9A8
	ldr r0, _0216E9A4 // =_02179078
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x330]
	ldr r2, [r4, #0x334]
	ldr r0, [r4, #0x32c]
	rsb r1, r1, #0
	str r0, [sp, #0x30]
	str r1, [sp, #0x34]
	add r0, r4, #0x308
	add r1, sp, #0xc
	str r2, [sp, #0x38]
	bl MI_Copy36B
	add r0, sp, #0
	add r1, sp, #0xc
	mov r2, r0
	bl MTX_MultVec33
	ldr r1, [sp, #4]
	add r0, sp, #0x30
	rsb r1, r1, #0
	str r1, [sp, #4]
	add r1, sp, #0
	mov r2, r0
	bl VEC_Add
	ldr r2, [sp, #0x34]
	ldr r1, [sp, #0x30]
	ldr r3, [sp, #0x38]
	mov r0, #1
	rsb r2, r2, #0
	bl BossFX__CreateHitB
	cmp r0, #0
	beq _0216E934
	mov r1, #0xc00
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	str r1, [r0, #0x40]
	mov r1, #0x6000
	str r1, [r0, #0x280]
_0216E934:
	ldr r1, [r4, #0x360]
	ldr r5, [r4, #0x364]
	ldr r3, [r4, #0x35c]
	rsb r4, r1, #0
	add r0, sp, #0x30
	add r1, sp, #0
	mov r2, r0
	str r4, [sp, #0x34]
	str r3, [sp, #0x30]
	str r5, [sp, #0x38]
	bl VEC_Add
	ldr r0, [sp, #0x34]
	ldr r1, [sp, #0x30]
	rsb r2, r0, #0
	ldr r3, [sp, #0x38]
	mov r0, #1
	bl BossFX__CreateHitB
	cmp r0, #0
	addeq sp, sp, #0x3c
	ldmeqia sp!, {r4, r5, pc}
	mov r1, #0xc00
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	str r1, [r0, #0x40]
	mov r1, #0x6000
	str r1, [r0, #0x280]
	add sp, sp, #0x3c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216E9A4: .word _02179078
	arm_func_end ovl02_216E814

	arm_func_start ovl02_216E9A8
ovl02_216E9A8: // 0x0216E9A8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	mov r5, r1
	mov r0, #0x1500
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r1, #6
	bl StageTask__SetType
	ldr r0, [r4, #0x120]
	mov r1, #0
	bl SetTaskPauseLevel
	ldr r3, _0216EB44 // =0x0000FFFF
	mov r1, #0
	str r3, [sp]
	str r1, [sp, #4]
	ldr r2, _0216EB48 // =gameArchiveStage
	mov r0, r4
	ldr r6, [r2, #0]
	ldr r2, _0216EB4C // =aBsefBombBac_1
	str r6, [sp, #8]
	bl ObjObjectAction3dBACLoad
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	mov r1, r7
	mov r3, #0x2000
	ldr r2, [r4, #0x134]
	mov r0, r4
	str r3, [r2, #0xc8]
	ldr r3, [r4, #0x18]
	mov r2, #0
	orr r3, r3, #0x10
	str r3, [r4, #0x18]
	ldr r3, [r4, #0x20]
	orr r3, r3, #0x180
	str r3, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	orr r3, r3, #0x100
	str r3, [r4, #0x1c]
	bl StageTask__SetParent
	add r3, r4, #0x44
	ldmia r5, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r4
	mov r1, #0
	mov r2, r1
	mov r3, r1
	bl StageTask__InitCollider
	mov r0, r4
	mov r1, #0
	bl StageTask__GetCollider
	mov r6, r0
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r6
	ldr r1, _0216EB44 // =0x0000FFFF
	mov r2, #0
	bl ObjRect__SetDefenceStat
	mov r3, #0xc
	str r3, [sp]
	mov r0, r6
	sub r1, r3, #0x18
	mov r2, r1
	bl ObjRect__SetBox2D
	mov r1, #0
	ldr r5, _0216EB50 // =0x00000102
	str r4, [r6, #0x1c]
	mov r0, r4
	mov r3, r1
	mov r2, #1
	strh r5, [r6, #0x34]
	bl StageTask__InitCollider
	mov r0, r4
	mov r1, #1
	bl StageTask__GetCollider
	mov r1, #1
	mov r2, #0x40
	mov r5, r0
	bl ObjRect__SetAttackStat
	ldr r1, _0216EB44 // =0x0000FFFF
	mov r0, r5
	mov r2, #0
	bl ObjRect__SetDefenceStat
	mov r2, #0x12
	str r2, [sp]
	mov r0, r5
	sub r1, r2, #0x2d
	sub r2, r2, #0x24
	mov r3, #0x1b
	bl ObjRect__SetBox2D
	str r4, [r5, #0x1c]
	ldr r1, _0216EB54 // =0x00000201
	mov r0, r4
	strh r1, [r5, #0x34]
	bl StageTask__InitSeqPlayer
	mov r0, r4
	bl ovl02_216EB58
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216EB44: .word 0x0000FFFF
_0216EB48: .word gameArchiveStage
_0216EB4C: .word aBsefBombBac_1
_0216EB50: .word 0x00000102
_0216EB54: .word 0x00000201
	arm_func_end ovl02_216E9A8

	arm_func_start ovl02_216EB58
ovl02_216EB58: // 0x0216EB58
	ldr r2, _0216EB98 // =ovl02_216EBA0
	mov r1, #0
	str r2, [r0, #0xf4]
	str r1, [r0, #0x2c]
	sub r1, r1, #0x1000
	str r1, [r0, #0xa0]
	ldr r1, [r0, #0x18]
	ldr ip, _0216EB9C // =ShakeScreen
	orr r1, r1, #2
	str r1, [r0, #0x18]
	ldr r1, [r0, #0x20]
	orr r1, r1, #0x1000
	orr r1, r1, #0x20
	str r1, [r0, #0x20]
	mov r0, #1
	bx ip
	.align 2, 0
_0216EB98: .word ovl02_216EBA0
_0216EB9C: .word ShakeScreen
	arm_func_end ovl02_216EB58

	arm_func_start ovl02_216EBA0
ovl02_216EBA0: // 0x0216EBA0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x2c]
	add r1, r1, #1
	str r1, [r4, #0x2c]
	cmp r1, #4
	ldmleia sp!, {r4, pc}
	ldr r1, [r4, #0x18]
	bic r1, r1, #2
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x20]
	tst r1, #0x1000
	beq _0216EBDC
	ldr r1, _0216EC20 // =0x0000012B
	bl ovl02_217873C
_0216EBDC:
	ldr r0, [r4, #0x20]
	mov r1, #1
	bic r0, r0, #0x1000
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x2c]
	cmp r0, #7
	ldrgt r0, [r4, #0x18]
	orrgt r0, r0, #2
	strgt r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	tst r0, #8
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #4
	strne r0, [r4, #0x18]
	mov r0, r4
	bl ovl02_2169E34
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216EC20: .word 0x0000012B
	arm_func_end ovl02_216EBA0

	arm_func_start ovl02_216EC24
ovl02_216EC24: // 0x0216EC24
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r3, #0
	ldr r2, [r4, #0x124]
	mov ip, r3
	mov r1, #1
_0216EC3C:
	add r0, r2, ip, lsl #2
	ldr r0, [r0, #0x10]
	cmp r0, #0
	add r0, ip, #1
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	moveq r3, r1
	cmp ip, #4
	blo _0216EC3C
	cmp r3, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, _0216ECAC // =ovl02_216ECB4
	mov r0, #8
	str r1, [r4, #0xf4]
	str r0, [r4, #0x2c]
	bl ovl02_2169F80
	ldr r1, [r4, #0x2c]
	subs r0, r1, r0, lsl #1
	str r0, [r4, #0x2c]
	movmi r0, #0
	strmi r0, [r4, #0x2c]
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimation
	ldr r1, _0216ECB0 // =0x00000125
	mov r0, #0
	bl ovl02_217873C
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216ECAC: .word ovl02_216ECB4
_0216ECB0: .word 0x00000125
	arm_func_end ovl02_216EC24

	arm_func_start ovl02_216ECB4
ovl02_216ECB4: // 0x0216ECB4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x12c]
	add r1, r1, #0x100
	ldrh r2, [r1, #0x74]
	cmp r2, #0x17
	beq _0216ECE4
	cmp r2, #0x18
	beq _0216ED1C
	cmp r2, #0x19
	beq _0216ED78
	ldmia sp!, {r4, pc}
_0216ECE4:
	ldr r1, [r4, #0x20]
	tst r1, #8
	ldmeqia sp!, {r4, pc}
	add r1, r2, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}
_0216ED1C:
	ldr r1, [r4, #0x20]
	tst r1, #8
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x2c]
	cmp r1, #0
	beq _0216ED50
	subs r0, r1, #1
	str r0, [r4, #0x2c]
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x20]
	bic r0, r0, #4
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}
_0216ED50:
	bl ovl02_216ED8C
	ldr r1, [r4, #0x12c]
	mov r0, r4
	add r1, r1, #0x100
	ldrh r1, [r1, #0x74]
	add r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldmia sp!, {r4, pc}
_0216ED78:
	ldr r1, [r4, #0x20]
	tst r1, #8
	ldmeqia sp!, {r4, pc}
	bl ovl02_216B664
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_216ECB4

	arm_func_start ovl02_216ED8C
ovl02_216ED8C: // 0x0216ED8C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x38
	ldr r5, _0216F04C // =_mt_math_rand
	str r0, [sp, #0x14]
	ldr r3, [r5, #0]
	ldr r1, _0216F050 // =0x00196225
	ldr r2, _0216F054 // =0x3C6EF35F
	ldr r0, [r0, #0x11c]
	mla r6, r3, r1, r2
	mla r2, r6, r1, r2
	ldr r1, [sp, #0x14]
	mov r3, r6, lsr #0x10
	ldr r4, [r1, #0x124]
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #3
	str r1, [sp, #0x1c]
	str r2, [r5]
	add r1, r0, #0x500
	ldrh r1, [r1, #0x36]
	mov r3, r3, lsl #0x10
	mov r8, r3, lsr #0x10
	cmp r1, #0
	moveq r3, #0xa
	streq r3, [sp, #0x1c]
	ldr r3, _0216F050 // =0x00196225
	ldr r5, _0216F054 // =0x3C6EF35F
	ldr r7, _0216F04C // =_mt_math_rand
	mla r3, r2, r3, r5
	mov r2, r3, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	and r2, r2, #1
	mov r2, r2, lsl #0x18
	str r3, [r7]
	movs r2, r2, asr #0x18
	str r2, [sp, #0x28]
	ldreq r2, [sp, #0x14]
	mov r6, #0
	ldreq r2, [r2, #0x44]
	mov r1, #0xe
	subeq r10, r2, #0x4b000
	beq _0216EE48
	ldr r2, [sp, #0x14]
	ldr r2, [r2, #0x44]
	add r10, r2, #0x4b000
_0216EE48:
	ldr r2, [sp, #0x14]
	ldr r3, [r0, #0x384]
	ldr r2, [r2, #0x48]
	tst r3, #2
	str r2, [sp, #0x30]
	beq _0216EE7C
	ldr r2, [sp, #0x28]
	cmp r2, #0
	moveq r6, #3
	beq _0216EE7C
	sub r1, r1, #3
	mov r1, r1, lsl #0x18
	mov r1, r1, asr #0x18
_0216EE7C:
	tst r3, #4
	beq _0216EE9C
	ldr r2, [sp, #0x28]
	cmp r2, #0
	subeq r1, r1, #3
	moveq r1, r1, lsl #0x18
	movne r6, #3
	moveq r1, r1, asr #0x18
_0216EE9C:
	and r2, r8, #8
	sub r1, r1, #4
	add r0, r0, #0x500
	str r2, [sp, #0x24]
	str r1, [sp, #0x20]
	mov r9, #0
	str r0, [sp, #0x34]
_0216EEB8:
	add r0, r4, r9, lsl #2
	ldr r0, [r0, #0x10]
	cmp r0, #0
	bne _0216F030
	ldr r0, [sp, #0x24]
	cmp r0, #0
	addeq r0, r8, r9
	andeq r1, r0, #7
	ldreq r0, _0216F058 // =_021792D8
	beq _0216EEEC
	sub r0, r8, r9
	and r1, r0, #7
	ldr r0, _0216F058 // =_021792D8
_0216EEEC:
	ldrsb r5, [r0, r1]
	ldr r0, _0216F04C // =_mt_math_rand
	ldr r1, _0216F050 // =0x00196225
	ldr r3, [r0, #0]
	ldr r0, _0216F054 // =0x3C6EF35F
	sub r2, r6, r9
	mla r7, r3, r1, r0
	ldr r0, [sp, #0x20]
	sub r1, r0, r2
	ldr r0, _0216F04C // =_mt_math_rand
	str r7, [r0]
	mov r0, r7, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl FX_ModS32
	add r0, r6, r0
	mov r0, r0, lsl #0x18
	mov r6, r0, asr #0x18
	ldr r0, [sp, #0x1c]
	ldr r1, _0216F050 // =0x00196225
	cmp r9, r0
	ldr r0, _0216F05C // =0x0000013D
	mov r11, r6
	addeq r0, r0, #1
	streq r0, [sp, #0x18]
	strne r0, [sp, #0x18]
	ldr r0, _0216F04C // =_mt_math_rand
	ldr r2, [r0, #0]
	ldr r0, _0216F054 // =0x3C6EF35F
	mla r1, r2, r1, r0
	ldr r0, _0216F04C // =_mt_math_rand
	str r1, [r0]
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r7, r0, #3
	ldr r0, [sp, #0x34]
	cmp r7, #3
	ldrh r0, [r0, #0x36]
	movhs r7, #0
	cmp r0, #0
	cmpeq r7, #1
	ldr r0, [sp, #0x28]
	moveq r7, #2
	cmp r0, #0
	moveq r0, #0x32000
	mlaeq r0, r9, r0, r10
	streq r0, [sp, #0x2c]
	beq _0216EFCC
	rsb r0, r6, #0xd
	mov r0, r0, lsl #0x18
	mov r11, r0, asr #0x18
	mov r0, #0x32000
	mul r0, r9, r0
	sub r0, r10, r0
	str r0, [sp, #0x2c]
_0216EFCC:
	bl ovl02_2169F80
	stmia sp, {r5, r11}
	str r7, [sp, #8]
	and r0, r0, #0xff
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x18]
	mov r2, #0
	str r2, [sp, #0x10]
	ldr r3, [sp, #0x30]
	ldr r2, _0216F060 // =0xFFE3E000
	ldr r1, [sp, #0x2c]
	add r2, r3, r2
	mov r3, #0
	bl GameObject__SpawnObject
	add r1, r4, r9, lsl #2
	str r0, [r1, #0x10]
	add r1, r6, #1
	mov r1, r1, lsl #0x18
	cmp r0, #0
	mov r6, r1, asr #0x18
	beq _0216F030
	ldr r1, [sp, #0x14]
	ldr r1, [r1, #0x4c]
	sub r1, r1, #0x50000
	str r1, [r0, #0x4c]
_0216F030:
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #4
	blo _0216EEB8
	add sp, sp, #0x38
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216F04C: .word _mt_math_rand
_0216F050: .word 0x00196225
_0216F054: .word 0x3C6EF35F
_0216F058: .word _021792D8
_0216F05C: .word 0x0000013D
_0216F060: .word 0xFFE3E000
	arm_func_end ovl02_216ED8C

	arm_func_start ovl02_216F064
ovl02_216F064: // 0x0216F064
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r1
	ldr r3, [r6, #0x1c]
	ldr r1, _0216F164 // =ovl02_216F45C
	ldr r2, [r3, #0xf4]
	ldr r4, [r0, #0x1c]
	ldr r5, [r3, #0x11c]
	cmp r2, r1
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r4
	ldr r7, [r4, #0x4c]
	bl BossHelpers__Player__UnlockControl
	mov r0, r4
	bl Player__InitState
	ldr r1, [r4, #0x1c]
	mov r0, r4
	orr r1, r1, #0x10
	str r1, [r4, #0x1c]
	bl Player__Action_DestroyAttackRecoil
	str r7, [r4, #0x4c]
	ldr r0, [r4, #0x5dc]
	orr r0, r0, #0x20000000
	str r0, [r4, #0x5dc]
	bl ovl02_216A0D4
	ldr lr, _0216F168 // =_mt_math_rand
	mov ip, #0xa800
	ldr r7, [lr]
	ldr r1, _0216F16C // =0x00196225
	ldr r2, _0216F170 // =0x3C6EF35F
	ldr r3, _0216F174 // =0x00000FFF
	mla r8, r7, r1, r2
	mov r1, r8, lsr #0x10
	mov r1, r1, lsl #0x10
	and r2, r3, r1, lsr #16
	ldr r0, [r4, #0x44]
	ldr r6, [r6, #0xc]
	sub r1, r3, #0x800
	sub r3, r0, r6, lsl #12
	sub r0, r1, r2
	add r2, r0, r3, lsl #1
	rsb ip, ip, #0
	cmp r2, ip
	str r8, [lr]
	movlt r2, ip
	blt _0216F120
	cmp r2, #0xa800
	movgt r2, #0xa800
_0216F120:
	add r0, r5, #0x300
	ldrh r1, [r0, #0x7e]
	cmp r1, #0
	moveq r0, #0x8000
	rsbeq r0, r0, #0
	movne r0, #0xe00
	mulne r0, r1, r0
	subne r0, r0, #0x6000
	str r0, [r4, #0x9c]
	str r2, [r4, #0x98]
	add r0, r5, #0x300
	ldrh r0, [r0, #0x7e]
	cmp r0, #5
	movhs r0, #0
	strhs r0, [r4, #0x98]
	strhs r0, [r4, #0x9c]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216F164: .word ovl02_216F45C
_0216F168: .word _mt_math_rand
_0216F16C: .word 0x00196225
_0216F170: .word 0x3C6EF35F
_0216F174: .word 0x00000FFF
	arm_func_end ovl02_216F064

	arm_func_start ovl02_216F178
ovl02_216F178: // 0x0216F178
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x24
	mov r6, r0
	ldr r1, [r6, #0xf4]
	ldr r0, _0216F370 // =ovl02_216F45C
	ldr r4, [r6, #0x124]
	cmp r1, r0
	ldr r5, [r6, #0x11c]
	bne _0216F1C0
	add r0, r5, #0x300
	mov r1, #0
	strh r1, [r0, #0x7e]
	mov r0, #0x4000
	str r0, [r6, #4]
	mov r0, #0x3c
	add sp, sp, #0x24
	strh r0, [r4, #0x24]
	ldmia sp!, {r3, r4, r5, r6, pc}
_0216F1C0:
	ldr r1, _0216F374 // =ovl02_216F37C
	mov r0, #8
	str r1, [r6, #0xf4]
	strh r0, [r4, #0x24]
	add r0, r5, #0x300
	ldrh r0, [r0, #0x7e]
	cmp r0, #6
	movhs r0, #0x3c
	strhsh r0, [r4, #0x24]
	add r0, r5, #0x300
	ldrh r0, [r0, #0x7e]
	cmp r0, #1
	bhi _0216F210
	ldrsh r2, [r4, #0x24]
	mov r0, r6
	mov r1, #0x1a
	mov r2, r2, lsl #1
	strh r2, [r4, #0x24]
	bl StageTask__SetAnimation
	b _0216F248
_0216F210:
	ldr r0, [r6, #0x12c]
	add r0, r0, #0x100
	ldrh r0, [r0, #0x74]
	cmp r0, #0x1b
	beq _0216F230
	mov r0, r6
	mov r1, #0x1b
	bl StageTask__SetAnimation
_0216F230:
	ldr r1, [r6, #0x20]
	mov r0, #0x4000
	orr r1, r1, #4
	str r1, [r6, #0x20]
	str r0, [r6, #4]
	str r0, [r6, #8]
_0216F248:
	mov r0, #0
	str r0, [r6, #0x2c]
	ldr r0, [r5, #0x384]
	tst r0, #0x10
	beq _0216F31C
	ldr r0, _0216F378 // =_02179018
	add ip, sp, #0xc
	ldmia r0, {r0, r1, r2}
	add r3, sp, #0x18
	add lr, r6, #0x224
	stmia ip, {r0, r1, r2}
	ldmia lr, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r2, [sp, #0x18]
	ldr r1, [sp, #0x1c]
	ldr r0, [sp, #0x20]
	mov r2, r2, lsl #0xc
	mov lr, r0, lsl #0xc
	mov r1, r1, lsl #0xc
	str r2, [sp, #0x18]
	str r1, [sp, #0x1c]
	mov r0, r6
	mov r1, r3
	mov r2, ip
	str lr, [sp, #0x20]
	bl ovl02_21773FC
	ldr r0, [sp, #0xc]
	add r1, sp, #0x18
	rsb r0, r0, #0
	str r0, [sp, #0xc]
	add r2, sp, #0xc
	mov r0, r6
	bl ovl02_21773FC
	ldr r1, [sp, #0x14]
	mov r0, r6
	rsb r1, r1, #0
	str r1, [sp, #0x14]
	add r1, sp, #0x18
	add r2, sp, #0xc
	bl ovl02_21773FC
	ldr r1, [sp, #0xc]
	mov r0, r6
	rsb r1, r1, #0
	str r1, [sp, #0xc]
	add r1, sp, #0x18
	add r2, sp, #0xc
	bl ovl02_21773FC
	mov r0, #0
	mov r1, #0x8d
	bl ovl02_217873C
	add r0, r4, #0x100
	mov r1, #0x32
	strh r1, [r0, #0x8e]
_0216F31C:
	mov r0, #0xd
	mov r3, #0x28
	str r0, [sp]
	sub r0, r0, #0x14
	stmib sp, {r0, r3}
	add r0, r6, #0x218
	sub r1, r3, #0x35
	sub r2, r3, #0x37
	sub r3, r3, #0x50
	bl ObjRect__SetBox3D
	ldr r0, [r5, #0x384]
	tst r0, #0x10
	addeq sp, sp, #0x24
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	mov r0, #0
	mov r2, r0
	mov r1, #0x64
	bl FadeStageBGMToTargetVolume
	bl ovl02_2169074
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0216F370: .word ovl02_216F45C
_0216F374: .word ovl02_216F37C
_0216F378: .word _02179018
	arm_func_end ovl02_216F178

	arm_func_start ovl02_216F37C
ovl02_216F37C: // 0x0216F37C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #0x2c]
	ldr r1, [r6, #0x124]
	ldr r4, [r6, #0x11c]
	ldr r5, [r6, #0x35c]
	add r0, r0, #1
	str r0, [r6, #0x2c]
	ldr r0, [r4, #0x384]
	tst r0, #0x10
	beq _0216F3D8
	add r0, r1, #0x100
	ldrh r1, [r0, #0x8e]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x8e]
	ldr r0, [r6, #0x2c]
	tst r0, #0xf
	bne _0216F3D8
	mov r0, r6
	bl ovl02_21775E8
	mov r0, #3
	bl ShakeScreen
_0216F3D8:
	ldr r1, [r5, #0x48]
	ldr r0, _0216F404 // =0x0044C000
	cmp r1, r0
	bgt _0216F3F8
	add r0, r4, #0x300
	ldrh r0, [r0, #0x7e]
	cmp r0, #6
	ldmloia sp!, {r4, r5, r6, pc}
_0216F3F8:
	mov r0, r6
	bl ovl02_216F408
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216F404: .word 0x0044C000
	arm_func_end ovl02_216F37C

	arm_func_start ovl02_216F408
ovl02_216F408: // 0x0216F408
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	ldr r2, _0216F458 // =ovl02_216F45C
	mov r4, r0
	mov r1, #0x1c
	str r2, [r4, #0xf4]
	bl StageTask__SetAnimation
	mov ip, #0xf
	mov r0, #0
	str r0, [r4, #0x2c]
	mov r0, #0xd
	stmia sp, {r0, ip}
	add r0, r4, #0x218
	sub r1, ip, #0x1c
	sub r2, ip, #0x1e
	sub r3, ip, #0x23
	str ip, [sp, #8]
	bl ObjRect__SetBox3D
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0216F458: .word ovl02_216F45C
	arm_func_end ovl02_216F408

	arm_func_start ovl02_216F45C
ovl02_216F45C: // 0x0216F45C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x11c]
	ldr r1, [r6, #0x124]
	ldr r0, [r4, #0x384]
	ldr r5, [r6, #0x35c]
	tst r0, #0x10
	beq _0216F4AC
	add r0, r1, #0x100
	ldrh r1, [r0, #0x8e]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x8e]
	ldr r0, [r6, #0x2c]
	tst r0, #0xf
	bne _0216F4AC
	mov r0, r6
	bl ovl02_21775E8
	mov r0, #3
	bl ShakeScreen
_0216F4AC:
	ldr r0, [r6, #0x2c]
	add r0, r0, #1
	str r0, [r6, #0x2c]
	cmp r0, #0xc
	bne _0216F528
	cmp r5, #0
	beq _0216F50C
	ldr r1, [r5, #0x5dc]
	mov r0, #0x6000
	bic r1, r1, #0x20000000
	str r1, [r5, #0x5dc]
	rsb r0, r0, #0
	str r0, [r5, #0x9c]
	mov r0, #0xc000
	str r0, [r5, #0xa0]
	ldr r0, [r5, #0x48]
	ldr r1, [r5, #0x44]
	ldr r3, [r5, #0x4c]
	rsb r2, r0, #0
	mov r0, #1
	bl BossFX__CreateHitB
	mov r0, #0
	mov r1, #0xcf
	bl ovl02_217873C
_0216F50C:
	mov r0, #0x50000
	bl ovl02_216A014
	mov r0, #0x18000
	bl ovl02_216A034
	ldr r0, [r4, #0x384]
	bic r0, r0, #0x200
	str r0, [r4, #0x384]
_0216F528:
	ldr r0, [r6, #0x20]
	tst r0, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	add r0, r4, #0x300
	mov r1, #0
	strh r1, [r0, #0x7e]
	ldr r0, [r4, #0x384]
	tst r0, #0x10
	mov r0, r6
	beq _0216F558
	bl ovl02_216F778
	ldmia sp!, {r4, r5, r6, pc}
_0216F558:
	bl ovl02_216B664
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl02_216F45C

	arm_func_start ovl02_216F560
ovl02_216F560: // 0x0216F560
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r10, r0
	ldr r0, _0216F768 // =_mt_math_rand
	ldr r2, _0216F76C // =0x00196225
	ldr r4, [r0, #0]
	ldr r3, _0216F770 // =0x3C6EF35F
	mov r11, #0
	mla r1, r4, r2, r3
	mla r4, r1, r2, r3
	mla r6, r4, r2, r3
	mov r2, r4, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x18
	mov r2, r2, lsr #0xc
	rsb r7, r2, #0
	mov r2, r6, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r8, r1, #0xff
	add r3, r7, #0x80000
	mov r4, r2, lsr #0x10
	mov r2, r3, lsl #0xc
	mov r2, r2, lsr #0x10
	and r3, r4, #0x3f
	mov r2, r2, lsl #0x10
	rsb r5, r3, #0x20
	mov r3, r2, lsr #0x10
	mov r2, r5, lsl #0x16
	mov r3, r3, asr #4
	mov r3, r3, lsl #1
	mov r2, r2, lsr #0x10
	mov r4, r2, lsl #0x10
	add r2, r3, #1
	mov r4, r4, lsr #0x10
	ldr r1, _0216F774 // =FX_SinCosTable_
	mov r2, r2, lsl #1
	mov r4, r4, asr #4
	mov r9, r3, lsl #1
	mov r3, r4, lsl #2
	ldrsh r4, [r1, r9]
	ldrsh r2, [r1, r2]
	ldrsh ip, [r1, r3]
	mov r1, #0x2800
	umull r9, r3, r2, r1
	rsb r1, r8, #0x80
	mla r3, r2, r11, r3
	str r1, [sp]
	adds r1, r9, #0x800
	mov r9, r1, lsr #0xc
	mov r1, r2, asr #0x1f
	mov r2, #0x2800
	mla r3, r1, r2, r3
	adc r1, r3, #0
	add r0, r10, #0x44
	orr r9, r9, r1, lsl #20
	ldr r8, [r10, #0x124]
	ldmia r0, {r0, r1, r2}
	add r3, sp, #0x10
	stmia r3, {r0, r1, r2}
	ldr r0, _0216F768 // =_mt_math_rand
	ldr r2, [sp, #0x10]
	str r6, [r0]
	ldr r0, [sp]
	ldr r1, [sp, #0x14]
	add r0, r2, r0, lsl #12
	str r0, [sp, #0x10]
	sub r0, r1, #0x60000
	add r0, r0, r7
	str r0, [sp, #0x14]
	mov r0, #0x2800
	umull r2, r1, r4, r0
	ldr r3, [sp, #0x18]
	mov lr, r4, asr #0x1f
	add r0, r3, #0x80000
	add r0, r0, r5, lsl #12
	str r0, [sp, #0x18]
	mov r0, #0
	mla r1, r4, r0, r1
	mov r0, #0x2800
	mla r1, lr, r0, r1
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	mov r0, #0x1800
	str r1, [sp, #8]
	umull r2, r1, ip, r0
	mov r0, #0
	mla r1, ip, r0, r1
	mov r11, ip, asr #0x1f
	mov r0, #0x1800
	mla r1, r11, r0, r1
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r9, [sp, #4]
	cmp r9, #0
	str r1, [sp, #0xc]
	rsblt r9, r9, #0
	str r9, [sp, #4]
	ldr r1, [sp, #0x10]
	ldr r0, [r10, #0x44]
	add r2, sp, #4
	cmp r1, r0
	rsblt r0, r9, #0
	strlt r0, [sp, #4]
	ldr r0, [sp, #4]
	mov r1, #0
	rsb r0, r0, #0
	str r1, [sp, #0xc]
	mov r0, r0, lsl #5
	str r0, [r8, #0x190]
	ldr r0, [sp, #8]
	add r1, sp, #0x10
	rsb r0, r0, #0
	mov r0, r0, lsl #5
	str r0, [r8, #0x194]
	ldr r0, [sp, #0xc]
	rsb r0, r0, #0
	mov r3, r0, lsl #5
	mov r0, r10
	str r3, [r8, #0x198]
	bl ovl02_21773FC
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216F768: .word _mt_math_rand
_0216F76C: .word 0x00196225
_0216F770: .word 0x3C6EF35F
_0216F774: .word FX_SinCosTable_
	arm_func_end ovl02_216F560

	arm_func_start ovl02_216F778
ovl02_216F778: // 0x0216F778
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r3, [r5, #0x11c]
	ldr r4, [r5, #0x124]
	ldr r2, [r3, #0x384]
	ldr r1, _0216F80C // =ovl02_216F810
	orr r2, r2, #0x800
	str r2, [r3, #0x384]
	str r1, [r5, #0xf4]
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r1, [r5, #0x20]
	add r0, r4, #0x100
	orr r1, r1, #4
	add r3, r4, #0x12c
	str r1, [r5, #0x20]
	mov ip, #0
	strh ip, [r0, #0x50]
	add r0, r5, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r4, #0x28
	str ip, [r5, #0x2c]
	ldr r1, [r5, #0x1c]
	mov r0, #0xd
	bic r1, r1, #0x2000
	str r1, [r5, #0x1c]
	stmia sp, {r0, ip}
	add r0, r5, #0x218
	sub r1, r4, #0x35
	sub r2, r4, #0x37
	sub r3, r4, #0x50
	str r4, [sp, #8]
	bl ObjRect__SetBox3D
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216F80C: .word ovl02_216F810
	arm_func_end ovl02_216F778

	arm_func_start ovl02_216F810
ovl02_216F810: // 0x0216F810
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r1, [r5, #0x2c]
	ldr r4, [r5, #0x124]
	cmp r1, #0xdc
	bgt _0216F878
	bge _0216F8F4
	cmp r1, #0x54
	bgt _0216F854
	bge _0216F8F4
	cmp r1, #0x10
	bgt _0216F848
	beq _0216F8F4
	b _0216F91C
_0216F848:
	cmp r1, #0x40
	beq _0216F8C8
	b _0216F91C
_0216F854:
	cmp r1, #0xa0
	bgt _0216F86C
	bge _0216F8F4
	cmp r1, #0x8c
	beq _0216F8F4
	b _0216F91C
_0216F86C:
	cmp r1, #0xc8
	beq _0216F8C8
	b _0216F91C
_0216F878:
	cmp r1, #0x12c
	bgt _0216F8A4
	bge _0216F8F4
	cmp r1, #0x104
	bgt _0216F894
	beq _0216F8F4
	b _0216F91C
_0216F894:
	ldr r0, _0216FAB8 // =0x0000010E
	cmp r1, r0
	beq _0216F8F4
	b _0216F91C
_0216F8A4:
	cmp r1, #0x168
	bgt _0216F8BC
	bge _0216F8C8
	cmp r1, #0x140
	beq _0216F8F4
	b _0216F91C
_0216F8BC:
	cmp r1, #0x17c
	beq _0216F8F4
	b _0216F91C
_0216F8C8:
	mov r0, r5
	add r1, r4, #0x100
	mov r2, #0x20
	strh r2, [r1, #0x8e]
	bl ovl02_216F560
	mov r1, #0x8000
	str r1, [r5, #4]
	mov r0, #9
	str r1, [r5, #8]
	bl ShakeScreen
	b _0216F91C
_0216F8F4:
	mov r0, r5
	add r1, r4, #0x100
	mov r2, #0x20
	strh r2, [r1, #0x8e]
	bl ovl02_216F560
	mov r1, #0x10000
	str r1, [r5, #4]
	mov r0, #0xa
	str r1, [r5, #8]
	bl ShakeScreen
_0216F91C:
	add r0, r4, #0x100
	ldrh r1, [r0, #0x8e]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x8e]
	ldr r0, [r5, #0x2c]
	tst r0, #0xf
	bne _0216F944
	mov r0, r5
	bl ovl02_21775E8
_0216F944:
	ldr r0, [r5, #8]
	cmp r0, #0
	bne _0216F980
	add r0, r4, #0x100
	ldrh r0, [r0, #0x50]
	mov r1, #0x10
	mov r2, #0x1000
	bl ObjSpdUpSet
	add r1, r4, #0x100
	strh r0, [r1, #0x50]
	ldrh r0, [r5, #0x30]
	mov r1, #0x1000
	mov r2, #0x10
	bl ObjRoopMove16
	strh r0, [r5, #0x30]
_0216F980:
	add r0, r4, #0x100
	ldrh r2, [r0, #0x50]
	ldr r1, [r4, #0x12c]
	mov r0, #0x178000
	bl ObjAlphaSet
	str r0, [r5, #0x44]
	add r0, r4, #0x100
	ldrh r2, [r0, #0x50]
	ldr r1, [r4, #0x130]
	ldr r0, _0216FABC // =0x0071C000
	bl ObjAlphaSet
	str r0, [r5, #0x48]
	add r1, r4, #0x100
	ldrh r2, [r1, #0x50]
	mov r0, #0x168000
	ldr r1, [r4, #0x134]
	rsb r0, r0, #0
	bl ObjAlphaSet
	str r0, [r5, #0x4c]
	add r0, r4, #0x190
	add ip, r5, #0xb0
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	mov r3, #0x80
	str r3, [sp]
	mov r1, #0
	ldr r0, [r4, #0x190]
	mov r2, #2
	mov r3, r1
	bl ObjShiftSet
	str r0, [r4, #0x190]
	mov r0, #0x80
	str r0, [sp]
	mov r1, #0
	ldr r0, [r4, #0x194]
	mov r2, #2
	mov r3, r1
	bl ObjShiftSet
	str r0, [r4, #0x194]
	mov r0, #0x80
	str r0, [sp]
	mov r1, #0
	ldr r0, [r4, #0x198]
	mov r2, #2
	mov r3, r1
	bl ObjShiftSet
	str r0, [r4, #0x198]
	ldrh r1, [r5, #0x30]
	ldr r0, [r5, #0x12c]
	ldr r3, _0216FAC0 // =FX_SinCosTable_
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	add r0, r0, #0x24
	bl MTX_RotX33_
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #0x190
	ldmleia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x44]
	cmp r0, #0x178000
	ldreq r1, [r5, #0x48]
	ldreq r0, _0216FABC // =0x0071C000
	cmpeq r1, r0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #0x168000
	ldr r1, [r5, #0x4c]
	rsb r0, r0, #0
	cmp r1, r0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl ovl02_216FAC4
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216FAB8: .word 0x0000010E
_0216FABC: .word 0x0071C000
_0216FAC0: .word FX_SinCosTable_
	arm_func_end ovl02_216F810

	arm_func_start ovl02_216FAC4
ovl02_216FAC4: // 0x0216FAC4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x11c]
	mov r0, #0x118000
	ldr r1, [r4, #0x384]
	rsb r0, r0, #0
	bic r1, r1, #1
	str r1, [r4, #0x384]
	mov r1, #0x96000
	str r1, [r4, #0x52c]
	str r0, [r4, #0x50c]
	add r1, r0, #0x96000
	str r1, [r4, #0x514]
	mov r0, #0
	str r1, [r4, #0x518]
	bl ovl02_216A014
	mov r0, #0
	bl ovl02_216A034
	ldr r1, _0216FB3C // =ovl02_216FB40
	mov r0, #0
	str r1, [r5, #0xf4]
	str r0, [r5, #0x2c]
	mov r0, #0x3c
	str r0, [r5, #0x28]
	mov r0, #1
	bl ChangeBossBGMVariant
	ldr r0, [r4, #0x384]
	orr r0, r0, #0x400
	str r0, [r4, #0x384]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216FB3C: .word ovl02_216FB40
	arm_func_end ovl02_216FAC4

	arm_func_start ovl02_216FB40
ovl02_216FB40: // 0x0216FB40
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x124]
	add r0, r0, #0x100
	ldrh r1, [r0, #0x8e]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x8e]
	ldr r0, [r4, #0x2c]
	tst r0, #0xf
	bne _0216FB74
	mov r0, r4
	bl ovl02_21775E8
_0216FB74:
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x28]
	cmp r0, #0
	bne _0216FBE8
	ldr r0, [r4, #0x2c]
	cmp r0, #0x10
	bne _0216FBBC
	mov r0, r4
	mov r1, #0
	bl ovl02_2175D1C
	mov r0, r4
	mov r1, #1
	bl ovl02_2175D1C
	mov r0, #0
	mov r1, #0x130
	bl ovl02_217873C
_0216FBBC:
	ldr r0, [r4, #0x2c]
	cmp r0, #0x104
	bne _0216FBD0
	mov r0, r4
	bl ovl02_2177740
_0216FBD0:
	ldr r0, [r4, #0x20]
	tst r0, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_216FC0C
	ldmia sp!, {r4, pc}
_0216FBE8:
	subs r0, r0, #1
	str r0, [r4, #0x28]
	ldmneia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0x1d
	bl StageTask__SetAnimation
	mov r0, #0
	str r0, [r4, #0x2c]
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_216FB40

	arm_func_start ovl02_216FC0C
ovl02_216FC0C: // 0x0216FC0C
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r6, [r5, #0x11c]
	bl ovl02_2169EF4
	mov r1, #0x64000
	rsb r1, r1, #0
	str r1, [r6, #0x514]
	mov r0, #0x14000
	str r1, [r6, #0x518]
	bl ovl02_216A014
	ldr r1, _0216FD08 // =ovl02_216FD10
	mov r0, r5
	str r1, [r5, #0xf4]
	mov r1, #0x1e
	bl StageTask__SetAnimation
	ldr r1, [r5, #0x20]
	mov r0, #0x96000
	orr r1, r1, #4
	str r1, [r5, #0x20]
	ldr r1, [r5, #0x18]
	rsb r0, r0, #0
	bic r1, r1, #2
	str r1, [r5, #0x18]
	str r0, [r4, #0x19c]
	mov r2, #0x740000
	str r2, [r4, #0x1a0]
	mov r1, #0
	rsb r0, r0, #0x2f0000
	str r1, [r4, #0x1a4]
	str r0, [r4, #0x1a8]
	str r2, [r4, #0x1ac]
	mov r0, r5
	str r1, [r4, #0x1b0]
	bl ovl02_2177740
	mov r0, r5
	mov r1, #0
	bl ovl02_2177868
	mov r0, r5
	mov r1, #1
	bl ovl02_2177868
	mov r0, r5
	mov r1, #0
	bl ovl02_2177B94
	mov r0, r5
	mov r1, #1
	bl ovl02_2177B94
	mov r0, r5
	mov r1, #0
	bl ovl02_2177DD8
	mov r0, r5
	mov r1, #1
	bl ovl02_2177DD8
	mov r0, #0xb
	bl ShakeScreen
	add r1, r4, #0x100
	mov r0, #0
	str r0, [r5, #0x2c]
	str r0, [r5, #0x28]
	strh r0, [r1, #0x50]
	ldr r1, _0216FD0C // =0x00000131
	bl ovl02_217873C
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216FD08: .word ovl02_216FD10
_0216FD0C: .word 0x00000131
	arm_func_end ovl02_216FC0C

	arm_func_start ovl02_216FD10
ovl02_216FD10: // 0x0216FD10
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x2c]
	ldr r4, [r5, #0x124]
	cmp r0, #0x244
	bgt _0216FD48
	bge _0216FDC8
	cmp r0, #0x5a
	bgt _0216FD3C
	beq _0216FD64
	b _0216FEFC
_0216FD3C:
	cmp r0, #0x1f4
	beq _0216FD70
	b _0216FEFC
_0216FD48:
	cmp r0, #0x2a8
	bgt _0216FD58
	beq _0216FE20
	b _0216FEFC
_0216FD58:
	cmp r0, #0x2d0
	beq _0216FE90
	b _0216FEFC
_0216FD64:
	mov r0, #0xd
	bl ShakeScreen
	b _0216FEFC
_0216FD70:
	ldr r0, [r5, #0x28]
	add r3, r4, #0x100
	add r0, r0, #1
	str r0, [r5, #0x28]
	mov r0, #0
	strh r0, [r3, #0x50]
	add r0, r5, #0x44
	add ip, r4, #0x12c
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	mov r1, #0x20
	mov r0, r5
	strh r1, [r3, #0x8e]
	bl ovl02_216F560
	mov r1, #0x10000
	str r1, [r5, #4]
	mov r0, #0xe
	str r1, [r5, #8]
	bl ShakeScreen
	mov r0, #0
	bl CreateScreenEffect
	b _0216FEFC
_0216FDC8:
	ldr r0, [r5, #0x28]
	add r3, r4, #0x100
	add r0, r0, #1
	str r0, [r5, #0x28]
	mov r0, #0
	strh r0, [r3, #0x50]
	add r0, r5, #0x44
	add ip, r4, #0x12c
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	mov r1, #0x20
	mov r0, r5
	strh r1, [r3, #0x8e]
	bl ovl02_216F560
	mov r1, #0x10000
	str r1, [r5, #4]
	mov r0, #0xf
	str r1, [r5, #8]
	bl ShakeScreen
	mov r0, #0
	bl CreateScreenEffect
	b _0216FEFC
_0216FE20:
	ldr r0, _0217008C // =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #3
	ldreq r0, [r0, #0x70]
	cmpeq r0, #0xf
	beq _0216FEFC
	ldr r0, [r5, #0x28]
	add r3, r4, #0x100
	add r0, r0, #1
	str r0, [r5, #0x28]
	mov r0, #0
	strh r0, [r3, #0x50]
	add r0, r5, #0x44
	add ip, r4, #0x12c
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	mov r1, #0x20
	mov r0, r5
	strh r1, [r3, #0x8e]
	bl ovl02_216F560
	mov r1, #0x10000
	str r1, [r5, #4]
	mov r0, #0xf
	str r1, [r5, #8]
	bl ShakeScreen
	mov r0, #0
	bl CreateScreenEffect
	b _0216FEFC
_0216FE90:
	ldr r0, _0217008C // =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #3
	ldreq r0, [r0, #0x70]
	cmpeq r0, #0xf
	bne _0216FEFC
	ldr r0, [r5, #0x28]
	add r3, r4, #0x100
	add r0, r0, #1
	str r0, [r5, #0x28]
	mov r0, #0
	strh r0, [r3, #0x50]
	add r0, r5, #0x44
	add ip, r4, #0x12c
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	mov r1, #0x20
	mov r0, r5
	strh r1, [r3, #0x8e]
	bl ovl02_216F560
	mov r1, #0x10000
	str r1, [r5, #4]
	mov r0, #0xf
	str r1, [r5, #8]
	bl ShakeScreen
	mov r0, #0
	bl CreateScreenEffect
_0216FEFC:
	ldr r0, [r5, #0x2c]
	cmp r0, #0x5a
	ble _0216FF34
	ldr r0, [r4, #0x19c]
	ldr r1, _02170090 // =0x00000B31
	mov r2, #0x178000
	bl ObjSpdUpSet
	str r0, [r4, #0x19c]
	mov r2, #0x178000
	ldr r0, [r4, #0x1a8]
	rsb r2, r2, #0
	mvn r1, #0xb30
	bl ObjSpdUpSet
	str r0, [r4, #0x1a8]
_0216FF34:
	ldr r1, [r5, #0x2c]
	add r0, r4, #0x100
	add r1, r1, #1
	str r1, [r5, #0x2c]
	ldrh r1, [r0, #0x8e]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x8e]
	ldr r0, [r5, #0x2c]
	tst r0, #0xf
	bne _0216FF68
	mov r0, r5
	bl ovl02_21775E8
_0216FF68:
	ldr r0, [r5, #0x28]
	cmp r0, #0
	beq _0216FFAC
	ldr r0, [r4, #0x12c]
	str r0, [r5, #0x44]
	ldr r0, [r4, #0x134]
	str r0, [r5, #0x4c]
	ldr r0, [r5, #8]
	cmp r0, #0
	bne _0216FFAC
	add r0, r4, #0x100
	ldrh r0, [r0, #0x50]
	mov r1, #0x1a0
	mov r2, #0x1000
	bl ObjSpdUpSet
	add r1, r4, #0x100
	strh r0, [r1, #0x50]
_0216FFAC:
	ldr r0, [r5, #0x28]
	cmp r0, #1
	bne _0216FFD0
	add r0, r4, #0x100
	ldrh r2, [r0, #0x50]
	ldr r1, [r4, #0x130]
	ldr r0, _02170094 // =0x00744000
	bl ObjAlphaSet
	str r0, [r5, #0x48]
_0216FFD0:
	ldr r0, [r5, #0x28]
	cmp r0, #2
	bne _0216FFF4
	add r0, r4, #0x100
	ldrh r2, [r0, #0x50]
	ldr r1, [r4, #0x130]
	ldr r0, _02170098 // =0x00758000
	bl ObjAlphaSet
	str r0, [r5, #0x48]
_0216FFF4:
	ldr r0, [r5, #0x28]
	cmp r0, #3
	bne _02170018
	add r0, r4, #0x100
	ldrh r2, [r0, #0x50]
	ldr r1, [r4, #0x130]
	ldr r0, _0217009C // =0x0077C000
	bl ObjAlphaSet
	str r0, [r5, #0x48]
_02170018:
	add r0, r4, #0x190
	add r3, r5, #0xb0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #0x80
	str r0, [sp]
	mov r1, #0
	ldr r0, [r4, #0x190]
	mov r3, r1
	mov r2, #2
	bl ObjShiftSet
	mov r1, #0
	str r0, [r4, #0x190]
	mov r0, #0x80
	str r0, [sp]
	ldr r0, [r4, #0x194]
	mov r3, r1
	mov r2, #2
	bl ObjShiftSet
	mov r1, #0
	str r0, [r4, #0x194]
	mov r0, #0x80
	str r0, [sp]
	ldr r0, [r4, #0x198]
	mov r2, #2
	mov r3, r1
	bl ObjShiftSet
	str r0, [r4, #0x198]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217008C: .word gameState
_02170090: .word 0x00000B31
_02170094: .word 0x00744000
_02170098: .word 0x00758000
_0217009C: .word 0x0077C000
	arm_func_end ovl02_216FD10

	arm_func_start ovl02_21700A0
ovl02_21700A0: // _021700A0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _02170128 // =ovl02_2170130
	mov r4, r0
	str r1, [r4, #0xf4]
	ldr r1, [r4, #0x18]
	mov r0, #0
	orr r1, r1, #2
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x1000
	str r1, [r4, #0x20]
	bl ShakeScreen
	mov r0, #5
	bl ShakeScreen
	mov r0, #0
	str r0, [r4, #0x2c]
	str r0, [r4, #0x28]
	bl SetObjSpeed
	bl StopStageBGM
	bl NNS_SndStopSoundAll
	ldr r1, _0217012C // =playerGameStatus
	mov r2, #0xce
	ldr r3, [r1, #0]
	mov r0, #0
	bic r3, r3, #1
	str r3, [r1]
	sub r1, r2, #0xcf
	stmia sp, {r0, r2}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170128: .word ovl02_2170130
_0217012C: .word playerGameStatus
	arm_func_end ovl02_21700A0

	arm_func_start ovl02_2170130
ovl02_2170130: // _02170130
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x28]
	ldr r4, [r5, #0x124]
	add r0, r0, #1
	str r0, [r5, #0x28]
	cmp r0, #0x3c
	ldmloia sp!, {r3, r4, r5, pc}
	bne _02170164
	mov r0, #5
	mov r1, #0x200
	bl CreateDrawFadeTask
	str r0, [r4, #0x368]
_02170164:
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #0x10
	ldmleia sp!, {r3, r4, r5, pc}
	ldr r0, _02170198 // =playerGameStatus
	ldr r1, [r0, #0]
	orr r1, r1, #4
	str r1, [r0]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02170198: .word playerGameStatus
	arm_func_end ovl02_2170130

	arm_func_start ovl02_217019C
ovl02_217019C: // _0217019C
	ldr r0, [r0, #0x340]
	ldrsb r0, [r0, #6]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bx lr
	arm_func_end ovl02_217019C

	arm_func_start ovl02_21701BC
ovl02_21701BC: // _021701BC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r5, [r4, #0x11c]
	ldr r0, [r4, #0x24]
	ldr r6, [r5, #0x124]
	tst r0, #1
	bne _021701F8
	ldr r0, [r4, #0x20]
	bic r1, r0, #0x20
	str r1, [r4, #0x20]
	ldr r0, [r5, #0x20]
	and r0, r0, #0x20
	orr r0, r1, r0
	str r0, [r4, #0x20]
_021701F8:
	ldr r0, [r4, #0x24]
	tst r0, #2
	beq _021702E4
	ldr r0, [r5, #0x12c]
	ldr r1, [r4, #0x12c]
	ldr r2, [r0, #0x118]
	mov r0, #0
	str r2, [r1, #0x118]
	ldr r1, [r5, #0x12c]
	ldr r2, [r4, #0x12c]
	add r1, r1, #0x100
	ldrsh r3, [r1, #0x30]
	add r1, r2, #0x100
	strh r3, [r1, #0x30]
	ldr r1, [r5, #0x12c]
	ldr r2, [r4, #0x12c]
	add r1, r1, #0x100
	add r2, r2, #0x100
	ldrh r1, [r1, #0x74]
	ldrh r2, [r2, #0x74]
	cmp r2, r1
	movne r0, #1
	cmp r0, #0
	beq _02170260
	mov r0, r4
	bl StageTask__SetAnimation
_02170260:
	ldr r0, [r4, #0x20]
	bic r1, r0, #4
	str r1, [r4, #0x20]
	ldr r0, [r5, #0x20]
	and r0, r0, #4
	orr r0, r1, r0
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x12c]
	add r0, r0, #0x100
	ldrh r1, [r0, #0xc]
	bic r1, r1, #4
	strh r1, [r0, #0xc]
	ldr r0, [r5, #0x12c]
	ldr r1, [r4, #0x12c]
	add r0, r0, #0x100
	add r1, r1, #0x100
	ldrh r0, [r0, #0xc]
	ldrh r2, [r1, #0xc]
	and r0, r0, #4
	orr r0, r2, r0
	strh r0, [r1, #0xc]
	ldr r0, [r4, #8]
	cmp r0, #0
	bne _021702E4
	ldr r0, [r5, #8]
	cmp r0, #0
	beq _021702E4
	str r0, [r4, #8]
	mov r0, #0x1000
	bl StageTask__AdvanceBySpeed
	ldr r1, [r4, #8]
	add r0, r1, r0
	str r0, [r4, #8]
_021702E4:
	ldr r0, [r4, #0x35c]
	cmp r0, #0
	beq _02170300
	ldr r0, [r0, #0x18]
	tst r0, #4
	movne r0, #0
	strne r0, [r4, #0x35c]
_02170300:
	ldr r1, [r4, #0x340]
	ldr r0, _02170480 // =0x0000013A
	ldrh r1, [r1, #2]
	cmp r1, r0
	bne _021703C0
	ldr r5, [r4, #0x124]
	ldrsh r0, [r5, #6]
	cmp r0, #0
	subne r0, r0, #1
	strneh r0, [r5, #6]
	add r0, r6, #0x100
	ldrh r0, [r0, #0xb4]
	cmp r0, #0
	ldr r0, [r4, #0x24]
	beq _02170368
	tst r0, #4
	bne _02170390
	mov r2, #1
	mov r3, r2
	add r0, r5, #0xc
	mov r1, #3
	bl BossHelpers__SetPaletteAnimations
	ldr r0, [r4, #0x24]
	orr r0, r0, #4
	str r0, [r4, #0x24]
	b _02170390
_02170368:
	tst r0, #4
	beq _02170390
	mov r2, #0
	mov r3, r2
	add r0, r5, #0xc
	mov r1, #3
	bl BossHelpers__SetPaletteAnimations
	ldr r0, [r4, #0x24]
	bic r0, r0, #4
	str r0, [r4, #0x24]
_02170390:
	mov r7, #0
	add r5, r5, #0xc
_02170398:
	add r8, r5, r7, lsl #5
	mov r0, r8
	bl AnimatePalette
	mov r0, r8
	bl DrawAnimatedPalette
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #3
	blo _02170398
_021703C0:
	ldr r1, [r4, #0x340]
	ldr r0, _02170484 // =0x0000013B
	ldrh r1, [r1, #2]
	cmp r1, r0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r5, [r4, #0x124]
	mov r0, r4
	bl ovl02_217019C
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	add r0, r6, #0x100
	ldrh r0, [r0, #0xb4]
	cmp r0, #0
	ldr r0, [r4, #0x24]
	beq _02170428
	tst r0, #4
	bne _02170450
	mov r2, #1
	mov r0, r5
	mov r3, r2
	mov r1, #2
	bl BossHelpers__SetPaletteAnimations
	ldr r0, [r4, #0x24]
	orr r0, r0, #4
	str r0, [r4, #0x24]
	b _02170450
_02170428:
	tst r0, #4
	beq _02170450
	mov r2, #0
	mov r0, r5
	mov r3, r2
	mov r1, #2
	bl BossHelpers__SetPaletteAnimations
	ldr r0, [r4, #0x24]
	bic r0, r0, #4
	str r0, [r4, #0x24]
_02170450:
	mov r6, #0
_02170454:
	add r4, r5, r6, lsl #5
	mov r0, r4
	bl AnimatePalette
	mov r0, r4
	bl DrawAnimatedPalette
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #2
	blo _02170454
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02170480: .word 0x0000013A
_02170484: .word 0x0000013B
	arm_func_end ovl02_21701BC

	arm_func_start ovl02_2170488
ovl02_2170488: // _02170488
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	bl GetCurrentTaskWork_
	ldr r1, [r4, #8]
	ldr r2, [r0, #0x124]
	tst r1, #0x10
	ldrneb r1, [r4, #0xae]
	ldr r0, [r2, #0]
	mvneq r1, #0
	cmp r0, r1
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, pc}
	ldrh r3, [r2, #4]
	add r1, sp, #0
	mov r0, #0x13
	mov r2, #1
	str r3, [sp]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end ovl02_2170488

	arm_func_start ovl02_21704DC
ovl02_21704DC: // _021704DC
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r5, [r4, #0x124]
	bl StageTask__Draw
	ldrh r0, [r5, #4]
	add r1, r5, #0x6c
	bl BossHelpers__Model__SetMatrixMode
	ldr r0, [r5, #0x90]
	mov r0, r0, asr #0xc
	str r0, [r4, #0x264]
	ldr r0, [r5, #0x94]
	rsb r0, r0, #0
	mov r0, r0, asr #0xc
	str r0, [r4, #0x268]
	ldr r0, [r5, #0x98]
	mov r0, r0, asr #0xc
	str r0, [r4, #0x26c]
	ldr r0, [r5, #0x90]
	mov r0, r0, asr #0xc
	str r0, [r4, #0x224]
	ldr r0, [r5, #0x94]
	rsb r0, r0, #0
	mov r0, r0, asr #0xc
	str r0, [r4, #0x228]
	ldr r0, [r5, #0x98]
	mov r0, r0, asr #0xc
	str r0, [r4, #0x22c]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_21704DC

	arm_func_start ovl02_2170550
ovl02_2170550: // _02170550
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r8, r0
	ldr r5, [r8, #0x1c]
	mov r7, r1
	ldr r4, [r7, #0x1c]
	ldrh r2, [r5, #0]
	ldr r3, [r4, #0x124]
	cmp r2, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldrh r2, [r8, #0x30]
	tst r2, #2
	beq _0217064C
	ldrsh r2, [r3, #6]
	cmp r2, #0
	beq _02170594
	bl ObjRect__FuncNoHit
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02170594:
	mov r1, #8
	mov r0, r5
	strh r1, [r3, #6]
	bl Player__Action_DestroyAttackRecoil
	bl ovl02_216A0D4
	ldr r1, [r5, #0x44]
	ldr r0, [r7, #0xc]
	mov r6, #0x4000
	cmp r1, r0, lsl #12
	mov r0, r5
	sublt r6, r6, #0x8000
	bl BossHelpers__Player__IsAlive
	cmp r0, #0
	beq _021705E8
	ldr r0, [r5, #0x1c]
	mov r1, #0x18
	tst r0, #0x10
	strne r6, [r5, #0x98]
	streq r6, [r5, #0xc8]
	add r0, r5, #0x500
	strh r1, [r0, #0xfa]
_021705E8:
	mov r0, r7
	mov r1, r8
	bl ObjRect__HitCenterX
	mov r9, r0
	mov r0, r7
	mov r1, r8
	bl ObjRect__HitCenterY
	rsb r2, r0, #0
	ldr r3, [r5, #0x4c]
	mov r1, r9
	mov r0, #1
	bl BossFX__CreateHitB
	mov r0, #0x8000
	str r0, [r4, #4]
	str r0, [r5, #4]
	str r0, [r5, #8]
	mov r0, #0
	mov r1, #0xcf
	bl ovl02_217873C
	ldr r2, [r5, #0xbc]
	mov r1, r6, asr #5
	ldr r0, [r4, #0x11c]
	rsb r1, r1, r2, asr #5
	bl ovl02_216C6D0
	b _02170658
_0217064C:
	ldr r0, [r5, #0x1c]
	orr r0, r0, #4
	str r0, [r5, #0x1c]
_02170658:
	ldr r3, [r7, #0xc]
	ldr r2, [r5, #0x44]
	cmp r2, r3, lsl #12
	ble _0217068C
	ldrsh r1, [r7, #6]
	ldrsh r0, [r8, #0]
	add r1, r3, r1
	add r0, r2, r0, lsl #12
	rsbs r0, r0, r1, lsl #12
	str r0, [r5, #0xb0]
	movmi r0, #0
	strmi r0, [r5, #0xb0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0217068C:
	ldrsh r1, [r7, #0]
	ldrsh r0, [r8, #6]
	add r1, r3, r1
	add r0, r2, r0, lsl #12
	rsb r0, r0, r1, lsl #12
	str r0, [r5, #0xb0]
	cmp r0, #0
	movgt r0, #0
	strgt r0, [r5, #0xb0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end ovl02_2170550

	arm_func_start ovl02_21706B4
ovl02_21706B4: // _021706B4
	stmdb sp!, {r3, lr}
	ldr ip, [r1, #0x1c]
	ldr r3, [r0, #0x1c]
	ldrh r2, [ip]
	cmp r2, #2
	ldrneh r2, [r3, #0]
	cmpne r2, #3
	ldmneia sp!, {r3, pc}
	ldr r2, [ip, #0x340]
	ldrh r2, [r2, #2]
	cmp r2, #0x13c
	bne _021706F4
	ldr r1, [r0, #0x18]
	orr r1, r1, #0x800
	str r1, [r0, #0x18]
	ldmia sp!, {r3, pc}
_021706F4:
	bl ObjRect__FuncNoHit
	ldmia sp!, {r3, pc}
	arm_func_end ovl02_21706B4

	arm_func_start ovl02_21706FC
ovl02_21706FC: // _021706FC
	ldr r1, _02170708 // =ovl02_217070C
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_02170708: .word ovl02_217070C
	arm_func_end ovl02_21706FC

	arm_func_start ovl02_217070C
ovl02_217070C: // _0217070C
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r6, r0
	ldr r4, [r6, #0x11c]
	ldr r5, [r4, #0x124]
	bl ovl02_217019C
	cmp r0, #0
	addne r0, r5, #0x248
	addeq r0, r5, #0x278
	ldr r1, [r0, #0x28]
	ldr r2, [r0, #0x2c]
	ldr r0, [r0, #0x24]
	rsb r1, r1, #0
	str r0, [r6, #0x44]
	str r1, [r6, #0x48]
	str r2, [r6, #0x4c]
	ldr r1, [r6, #0x12c]
	ldr r0, _02170940 // =0x000034CC
	str r0, [r1, #0x18]
	str r0, [r1, #0x1c]
	str r0, [r1, #0x20]
	ldr r0, [r4, #0x12c]
	ldr r1, [r6, #0x12c]
	add ip, r0, #0x24
	add r4, r1, #0x24
	ldmia ip!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia ip!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldr r1, [ip]
	mov r0, r6
	str r1, [r4]
	bl ovl02_217019C
	cmp r0, #0
	beq _021707A4
	ldr r0, [r5, #0x20]
	tst r0, #1
	bne _021707C0
_021707A4:
	mov r0, r6
	bl ovl02_217019C
	cmp r0, #0
	bne _021708DC
	ldr r0, [r5, #0x20]
	tst r0, #2
	beq _021708DC
_021707C0:
	ldr r0, [r6, #0x270]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	tst r0, #4
	ldrne r0, [r6, #0x270]
	bicne r0, r0, #0x200
	strne r0, [r6, #0x270]
	ldr r0, [r5, #0x20]
	tst r0, #8
	beq _02170808
	ldr r0, [r6, #0x230]
	tst r0, #4
	bne _021708F4
	orr r0, r0, #4
	bic r0, r0, #0x800
	str r0, [r6, #0x230]
	b _021708F4
_02170808:
	tst r0, #4
	beq _02170870
	mov r1, #0
	mov r2, r1
	add r0, r6, #0x258
	bl ObjRect__SetAttackStat
	mov r1, #0
	mov r2, r1
	add r0, r6, #0x258
	bl ObjRect__SetDefenceStat
	ldr r1, [r6, #0x270]
	mov r3, #0x1e
	bic r1, r1, #0x800
	str r1, [r6, #0x270]
	mov r0, #0x28
	str r0, [sp]
	stmib sp, {r0, r3}
	add r0, r6, #0x258
	sub r1, r3, #0x46
	sub r2, r3, #0x5a
	sub r3, r3, #0x3c
	bl ObjRect__SetBox3D
	ldr r0, [r6, #0x230]
	bic r0, r0, #4
	str r0, [r6, #0x230]
	b _021708F4
_02170870:
	add r0, r6, #0x258
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	ldr r1, _02170944 // =0x0000FFFF
	add r0, r6, #0x258
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r1, [r6, #0x270]
	mov r3, #0x1e
	bic r1, r1, #0x800
	str r1, [r6, #0x270]
	mov r0, #0x28
	str r0, [sp]
	stmib sp, {r0, r3}
	add r0, r6, #0x258
	sub r1, r3, #0x46
	sub r2, r3, #0x5a
	sub r3, r3, #0x3c
	bl ObjRect__SetBox3D
	ldr r0, [r6, #0x230]
	tst r0, #4
	bne _021708F4
	orr r0, r0, #4
	bic r0, r0, #0x800
	str r0, [r6, #0x230]
	b _021708F4
_021708DC:
	ldr r0, [r6, #0x270]
	bic r0, r0, #4
	str r0, [r6, #0x270]
	ldr r0, [r6, #0x230]
	bic r0, r0, #4
	str r0, [r6, #0x230]
_021708F4:
	mov r0, r6
	bl ovl02_217019C
	cmp r0, #0
	ldr r0, [r5, #0x20]
	beq _02170924
	tst r0, #0x8000
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	mov r0, r6
	bl ovl02_2170948
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
_02170924:
	tst r0, #0x10000
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	mov r0, r6
	bl ovl02_2170948
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02170940: .word 0x000034CC
_02170944: .word 0x0000FFFF
	arm_func_end ovl02_217070C

	arm_func_start ovl02_2170948
ovl02_2170948: // _02170948
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x24
	ldr r1, _02170A44 // =ovl02_2170A4C
	mov r4, r0
	str r1, [r4, #0xf4]
	mov r1, #0
	str r1, [r4, #0x2c]
	str r1, [r4, #0x28]
	ldr r2, [r4, #0x20]
	mov r1, #0x22
	bic r2, r2, #0x20
	str r2, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	bic r2, r2, #0x2000
	str r2, [r4, #0x1c]
	ldr r2, [r4, #0x24]
	orr r2, r2, #1
	bic r2, r2, #2
	str r2, [r4, #0x24]
	bl StageTask__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	bl ovl02_217019C
	cmp r0, #0
	movne r0, #0xc000
	moveq r0, #0x4000
	mov r2, #0xc000
	strh r0, [r4, #0x32]
	mov r0, r2, asr #4
	strh r2, [r4, #0x30]
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _02170A48 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldr r3, [r4, #0x12c]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotX33_
	ldrh r1, [r4, #0x32]
	ldr r3, _02170A48 // =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	ldr r2, [r4, #0x12c]
	add r0, sp, #0
	add r1, r2, #0x24
	add r2, r2, #0x24
	bl MTX_Concat33
	mov r0, r4
	mov r1, #0x6b
	bl ovl02_217873C
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02170A44: .word ovl02_2170A4C
_02170A48: .word FX_SinCosTable_
	arm_func_end ovl02_2170948

	arm_func_start ovl02_2170A4C
ovl02_2170A4C: // _02170A4C
	stmdb sp!, {r3, lr}
	mov r1, #0x18000
	rsb r1, r1, #0
	str r1, [r0, #0x9c]
	ldr r1, [r0, #0x48]
	cmp r1, #0x190000
	ldmgeia sp!, {r3, pc}
	bl ovl02_2170A70
	ldmia sp!, {r3, pc}
	arm_func_end ovl02_2170A4C

	arm_func_start ovl02_2170A70
ovl02_2170A70: // _02170A70
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r2, _02170B60 // =gPlayer
	mov r1, #0
	ldr r2, [r2, #0]
	ldr r3, _02170B64 // =ovl02_2170B70
	mov r4, r0
	str r3, [r4, #0xf4]
	str r1, [r4, #0x2c]
	str r1, [r4, #0x28]
	ldr r3, [r4, #0x1c]
	sub lr, r1, #0x64000
	bic r3, r3, #0x2000
	str r3, [r4, #0x1c]
	ldr r3, [r4, #0x24]
	ldr ip, _02170B68 // =0xFFA24000
	orr r3, r3, #1
	str r3, [r4, #0x24]
	ldr r5, [r4, #0x20]
	mov r3, #0x4000
	bic r5, r5, #0x20
	str r5, [r4, #0x20]
	str r1, [r4, #0x9c]
	ldr r1, [r2, #0x44]
	str r1, [r4, #0x44]
	str lr, [r4, #0x48]
	str ip, [r4, #0x4c]
	strh r3, [r4, #0x30]
	bl ovl02_217019C
	mov ip, #0x1e
	cmp r0, #0
	movne r0, #0xc000
	moveq r0, #0x4000
	strh r0, [r4, #0x32]
	mov r0, #0x28
	str r0, [sp]
	str r0, [sp, #4]
	add r0, r4, #0x258
	sub r1, ip, #0x46
	sub r2, ip, #0x5a
	sub r3, ip, #0x3c
	str ip, [sp, #8]
	bl ObjRect__SetBox3D
	add r0, r4, #0x258
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	ldr r1, _02170B6C // =0x0000FFFF
	add r0, r4, #0x258
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r0, [r4, #0x270]
	bic r0, r0, #0x800
	str r0, [r4, #0x270]
	ldr r0, [r4, #0x230]
	orr r0, r0, #4
	bic r0, r0, #0x800
	str r0, [r4, #0x230]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02170B60: .word gPlayer
_02170B64: .word ovl02_2170B70
_02170B68: .word 0xFFA24000
_02170B6C: .word 0x0000FFFF
	arm_func_end ovl02_2170A70

	arm_func_start ovl02_2170B70
ovl02_2170B70: // _02170B70
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x30
	mov r5, r0
	ldr r0, _02170DD8 // =gPlayer
	ldr r1, [r5, #4]
	ldr r4, [r0, #0]
	cmp r1, #0x4000
	movlt r0, #0x8000
	strlt r0, [r5, #4]
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #0x37
	ble _02170BB8
	ldrh r0, [r5, #0x30]
	mov r1, #0x200
	bl ObjSpdDownSet
	strh r0, [r5, #0x30]
_02170BB8:
	ldrh r0, [r5, #0x30]
	ldr r2, _02170DDC // =FX_SinCosTable_
	ldr r3, [r5, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotX33_
	ldrh r1, [r5, #0x32]
	ldr r3, _02170DDC // =FX_SinCosTable_
	add r0, sp, #0xc
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	ldr r2, [r5, #0x12c]
	add r0, sp, #0xc
	add r1, r2, #0x24
	add r2, r2, #0x24
	bl MTX_Concat33
	mov r0, #0x100
	str r0, [sp]
	mov r0, #0x3000
	str r0, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [r5, #0x44]
	ldr r1, [r4, #0x44]
	ldr r2, [r5, #0x98]
	mov r3, #0x280
	bl BossHelpers__Math__Func_20392BC
	str r0, [r5, #0x98]
	mov r0, r5
	bl ovl02_217019C
	cmp r0, #0
	movne r0, #0xc000
	moveq r0, #0x4000
	strh r0, [r5, #0x32]
	ldrh r1, [r5, #0x32]
	ldr r0, [r5, #0x98]
	add r0, r1, r0, asr #3
	strh r0, [r5, #0x32]
	ldrh r0, [r5, #0x30]
	cmp r0, #0
	bne _02170CDC
	mov r3, #0x1000
	str r3, [sp]
	mov r0, #0x3000
	str r0, [sp, #4]
	mov r0, #0x4000
	str r0, [sp, #8]
	ldr r0, [r5, #0x48]
	ldr r1, [r4, #0x48]
	ldr r2, [r5, #0x9c]
	bl BossHelpers__Math__Func_20392BC
	str r0, [r5, #0x9c]
	ldrh r2, [r5, #0x30]
	ldr r0, _02170DDC // =FX_SinCosTable_
	mov r1, #0
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r2, [r0, r2]
	mov r0, #0x18000
	b _02170D38
_02170CDC:
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	ldr r3, _02170DDC // =FX_SinCosTable_
	mov r0, r0, lsl #2
	ldrsh r2, [r3, r0]
	mov r0, #0x18000
	mov r1, #0
	umull ip, r4, r2, r0
	mla r4, r2, r1, r4
	mov r2, r2, asr #0x1f
	mla r4, r2, r0, r4
	adds ip, ip, #0x800
	adc r2, r4, #0
	mov r4, ip, lsr #0xc
	orr r4, r4, r2, lsl #20
	str r4, [r5, #0x9c]
	ldrh r2, [r5, #0x30]
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r2, [r3, r2]
_02170D38:
	umull r4, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r4, r4, #0x800
	adc r0, r3, #0
	mov r1, r4, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r5, #0xa0]
	mov r0, #0x96000
	ldr r1, [r5, #0x94]
	rsb r0, r0, #0
	cmp r1, r0
	bge _02170DB8
	ldr r1, [r5, #0x4c]
	cmp r1, r0
	ble _02170DB8
	ldr r2, _02170DE0 // =0x000001C7
	mov r0, #0x8000
	mov r1, #0x3000
	bl ShakeScreenEx
	mov r0, #0
	ldr r1, [r5, #0x44]
	mov r3, r0
	sub r2, r0, #0x740000
	bl BossFX__CreateRexRage
	cmp r0, #0
	ldrne r1, _02170DE4 // =ovl02_2176A2C
	strne r1, [r0, #0x2e4]
	ldr r1, _02170DE8 // =0x00000129
	mov r0, r5
	bl ovl02_217873C
_02170DB8:
	ldr r0, [r5, #0x4c]
	cmp r0, #0x1f4000
	addle sp, sp, #0x30
	ldmleia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl ovl02_2170DEC
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02170DD8: .word gPlayer
_02170DDC: .word FX_SinCosTable_
_02170DE0: .word 0x000001C7
_02170DE4: .word ovl02_2176A2C
_02170DE8: .word 0x00000129
	arm_func_end ovl02_2170B70

	arm_func_start ovl02_2170DEC
ovl02_2170DEC: // _02170DEC
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r6, r0
	ldr r1, [r6, #0x11c]
	ldr r4, [r6, #0x124]
	ldr r5, [r1, #0x124]
	bl ovl02_217019C
	cmp r0, #0
	addne r5, r5, #0x248
	addeq r5, r5, #0x278
	ldr r0, [r6, #0x12c]
	mov lr, r5
	add ip, r0, #0x24
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r1, [lr]
	ldr r0, _02170F04 // =ovl02_2170F0C
	str r1, [ip]
	str r0, [r6, #0xf4]
	mov r2, #0
	str r2, [r6, #0x2c]
	str r2, [r6, #0x98]
	mov r0, #0x10000
	str r0, [r6, #0x9c]
	ldr r0, _02170F08 // =0x001C2000
	str r2, [r6, #0xa0]
	str r0, [r6, #0x48]
	ldr r0, [r6, #0x20]
	mov r1, #0x110000
	bic r0, r0, #0x20
	str r0, [r6, #0x20]
	str r1, [r4, #8]
	mov r0, r6
	str r1, [sp]
	str r2, [sp, #4]
	str r2, [sp, #8]
	bl ovl02_217019C
	cmp r0, #0
	ldrne r0, [sp]
	rsbne r0, r0, #0
	strne r0, [sp]
	ldr r1, [r6, #0x12c]
	add r0, sp, #0
	add r1, r1, #0x24
	mov r2, r0
	bl MTX_MultVec33
	ldr r0, [sp, #4]
	add r1, sp, #0
	rsb r0, r0, #0
	str r0, [sp, #4]
	ldr r2, [r5, #0x28]
	ldr r3, [r5, #0x2c]
	ldr r0, [r5, #0x24]
	rsb r2, r2, #0
	str r0, [r6, #0x44]
	str r2, [r6, #0x48]
	add r0, r6, #0x44
	str r3, [r6, #0x4c]
	mov r2, r0
	bl VEC_Subtract
	ldr r0, [r6, #0x270]
	bic r0, r0, #4
	str r0, [r6, #0x270]
	ldr r0, [r6, #0x230]
	bic r0, r0, #4
	str r0, [r6, #0x230]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02170F04: .word ovl02_2170F0C
_02170F08: .word 0x001C2000
	arm_func_end ovl02_2170DEC

	arm_func_start ovl02_2170F0C
ovl02_2170F0C: // _02170F0C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	ldr r5, [r7, #0x11c]
	ldr r4, [r7, #0x124]
	ldr r6, [r5, #0x124]
	bl ovl02_217019C
	cmp r0, #0
	addne r6, r6, #0x248
	addeq r6, r6, #0x278
	ldr r0, [r7, #0x12c]
	mov lr, r6
	add ip, r0, #0x24
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r1, [lr]
	mov r0, #0x1000
	str r1, [ip]
	ldr r2, [r7, #0x12c]
	mov r1, #0xc000
	str r0, [r2, #0x18]
	str r0, [r2, #0x1c]
	str r0, [r2, #0x20]
	ldr r0, [r4, #8]
	bl ObjSpdDownSet
	mov r2, r0
	str r0, [r4, #8]
	mov r1, #0
	mov r0, r7
	str r2, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	bl ovl02_217019C
	cmp r0, #0
	ldrne r0, [sp]
	rsbne r0, r0, #0
	strne r0, [sp]
	ldr r1, [r7, #0x12c]
	add r0, sp, #0
	add r1, r1, #0x24
	mov r2, r0
	bl MTX_MultVec33
	ldr r0, [sp, #4]
	add r1, sp, #0
	rsb r0, r0, #0
	str r0, [sp, #4]
	ldr r2, [r6, #0x28]
	ldr r3, [r6, #0x2c]
	ldr r0, [r6, #0x24]
	rsb r2, r2, #0
	str r0, [r7, #0x44]
	str r2, [r7, #0x48]
	add r0, r7, #0x44
	str r3, [r7, #0x4c]
	mov r2, r0
	bl VEC_Subtract
	ldr r0, [r4, #8]
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r1, [r6, #0x28]
	mov r0, #0x10000
	rsb r1, r1, #0
	str r1, [r7, #0x48]
	str r0, [r7, #4]
	ldr r0, [r7, #0x1c]
	mov r1, #0
	orr r0, r0, #0x2000
	str r0, [r7, #0x1c]
	ldr r2, [r7, #0x24]
	mov r0, r7
	bic r2, r2, #1
	str r2, [r7, #0x24]
	str r1, [r7, #0x9c]
	strh r1, [r7, #0x30]
	strh r1, [r7, #0x32]
	strh r1, [r7, #0x34]
	ldr r2, [r7, #0x24]
	mov r1, #0x50
	orr r2, r2, #2
	str r2, [r7, #0x24]
	ldr r2, [r7, #0x20]
	bic r2, r2, #4
	str r2, [r7, #0x20]
	bl ovl02_217873C
	mov r0, r7
	bl ovl02_21706FC
	ldr r1, [r5, #0x12c]
	mov r0, r7
	add r1, r1, #0x100
	ldrh r1, [r1, #0x74]
	bl StageTask__SetAnimation
	ldr r1, [r5, #0x12c]
	ldr r0, [r7, #0x12c]
	ldr r1, [r1, #0xe4]
	ldr r0, [r0, #0xe4]
	ldr r1, [r1, #0]
	str r1, [r0]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end ovl02_2170F0C

	arm_func_start ovl02_21710A4
ovl02_21710A4: // _021710A4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl GetTaskWork_
	ldr r4, [r0, #0x124]
	bl ovl02_217019C
	cmp r0, #0
	beq _021710F4
	mov r5, #0
_021710C4:
	add r0, r4, r5, lsl #5
	bl ReleasePaletteAnimator
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #2
	blo _021710C4
	ldr r1, _02171100 // =gameArchiveStage
	ldr r0, _02171104 // =aBossfEtcNsbmd_0
	ldr r1, [r1, #0]
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
_021710F4:
	mov r0, r6
	bl GameObject__Destructor
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02171100: .word gameArchiveStage
_02171104: .word aBossfEtcNsbmd_0
	arm_func_end ovl02_21710A4

	arm_func_start ovl02_2171108
ovl02_2171108: // _02171108
	ldr r1, _02171114 // =ovl02_2171118
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_02171114: .word ovl02_2171118
	arm_func_end ovl02_2171108

	arm_func_start ovl02_2171118
ovl02_2171118: // _02171118
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r6, r0
	ldr r1, [r6, #0x11c]
	ldr r4, [r6, #0x124]
	ldr r5, [r1, #0x124]
	bl ovl02_217019C
	cmp r0, #0
	addne ip, r5, #0x2a8
	addeq ip, r5, #0x2d8
	ldr r1, [ip, #0x28]
	ldr r2, [ip, #0x2c]
	ldr r0, [ip, #0x24]
	rsb r1, r1, #0
	str r0, [r6, #0x44]
	str r1, [r6, #0x48]
	str r2, [r6, #0x4c]
	ldr lr, [r6, #0x12c]
	ldmia ip!, {r0, r1, r2, r3}
	add lr, lr, #0x24
	stmia lr!, {r0, r1, r2, r3}
	ldmia ip!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	ldr r1, [ip]
	mov r0, #0x1000
	str r1, [lr]
	ldr r1, [r6, #0x12c]
	str r0, [r1, #0x18]
	str r0, [r1, #0x1c]
	str r0, [r1, #0x20]
	ldr r1, [r4, #0x80]
	ldr r0, [r4, #0x84]
	ldr r2, [r4, #0x88]
	orr r0, r1, r0
	orrs r0, r2, r0
	beq _02171218
	add r0, r6, #0x44
	add r1, r4, #0x80
	mov r2, r0
	bl VEC_Subtract
	mov r0, #0x100
	str r0, [sp]
	mov r1, #0
	ldr r0, [r4, #0x80]
	mov r3, r1
	mov r2, #3
	bl ObjShiftSet
	str r0, [r4, #0x80]
	mov r0, #0x100
	mov r1, #0
	str r0, [sp]
	ldr r0, [r4, #0x84]
	mov r3, r1
	mov r2, #3
	bl ObjShiftSet
	str r0, [r4, #0x84]
	mov r0, #0x100
	str r0, [sp]
	mov r1, #0
	ldr r0, [r4, #0x88]
	mov r2, #3
	mov r3, r1
	bl ObjShiftSet
	str r0, [r4, #0x88]
_02171218:
	mov r0, r6
	bl ovl02_217019C
	cmp r0, #0
	ldr r0, [r5, #0x20]
	beq _02171260
	tst r0, #0x200
	beq _02171244
	mov r0, r6
	bl ovl02_2171294
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_02171244:
	tst r0, #0x2000
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	mov r0, r6
	bl ovl02_2171694
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_02171260:
	tst r0, #0x400
	beq _02171278
	mov r0, r6
	bl ovl02_2171294
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_02171278:
	tst r0, #0x4000
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	mov r0, r6
	bl ovl02_2171694
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	arm_func_end ovl02_2171118

	arm_func_start ovl02_2171294
ovl02_2171294: // _02171294
	ldr r3, [r0, #0x124]
	mov r2, #0
	strh r2, [r3, #0x70]
	ldr r1, _021712B0 // =ovl02_21712B4
	strh r2, [r3, #0x72]
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_021712B0: .word ovl02_21712B4
	arm_func_end ovl02_2171294

	arm_func_start ovl02_21712B4
ovl02_21712B4: // _021712B4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x80
	mov r6, r0
	ldr r0, _02171684 // =_02179090
	ldr r5, [r6, #0x11c]
	ldr r4, [r6, #0x124]
	add r3, sp, #0x5c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r6
	ldr r5, [r5, #0x124]
	bl ovl02_217019C
	cmp r0, #0
	add r3, sp, #0x50
	beq _02171304
	add r0, r5, #0x168
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r5, #0x2a8
	b _02171314
_02171304:
	add r0, r5, #0x174
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r5, #0x2d8
_02171314:
	ldr r1, [r0, #0x28]
	ldr r2, [r0, #0x2c]
	ldr r0, [r0, #0x24]
	rsb r1, r1, #0
	str r0, [r6, #0x44]
	str r1, [r6, #0x48]
	str r2, [r6, #0x4c]
	ldr r0, [r6, #8]
	cmp r0, #0
	bne _021713F0
	ldrh r0, [r4, #0x72]
	cmp r0, #0
	beq _021713A4
	mov r0, #0x40
	str r0, [sp]
	ldr r0, [r4, #0x74]
	ldr r1, [r6, #0x44]
	mov r2, #2
	mov r3, #0
	bl ObjShiftSet
	str r0, [r4, #0x74]
	mov r0, #0x40
	str r0, [sp]
	ldr r0, [r4, #0x78]
	ldr r1, [r6, #0x48]
	mov r2, #2
	mov r3, #0
	bl ObjShiftSet
	str r0, [r4, #0x78]
	add r0, r4, #0x74
	add r3, sp, #0x50
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldrh r0, [r4, #0x72]
	add r0, r0, #1
	strh r0, [r4, #0x72]
_021713A4:
	ldr r0, [sp, #0x54]
	add lr, sp, #0x44
	rsb r0, r0, #0
	str r0, [sp, #0x54]
	add r0, r6, #0x44
	ldmia r0, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	ldr r0, [sp, #0x48]
	add r1, sp, #0x50
	rsb ip, r0, #0
	add r2, sp, #0x5c
	add r3, sp, #0x14
	mov r0, lr
	str ip, [sp, #0x48]
	bl Unknown2066510__Func_2066A4C
	ldr r1, [r6, #0x12c]
	add r0, sp, #0x14
	add r1, r1, #0x24
	bl MI_Copy36B
_021713F0:
	ldr r1, [r6, #0x12c]
	ldr r0, _02171688 // =0x000034CC
	str r0, [r1, #0x18]
	str r0, [r1, #0x1c]
	str r0, [r1, #0x20]
	ldr r1, [r4, #0x80]
	ldr r0, [r4, #0x84]
	ldr r2, [r4, #0x88]
	orr r0, r1, r0
	orrs r0, r2, r0
	beq _0217148C
	add r0, r6, #0x44
	add r1, r4, #0x80
	mov r2, r0
	bl VEC_Subtract
	mov r0, #0x100
	str r0, [sp]
	mov r1, #0
	ldr r0, [r4, #0x80]
	mov r3, r1
	mov r2, #3
	bl ObjShiftSet
	str r0, [r4, #0x80]
	mov r0, #0x100
	mov r1, #0
	str r0, [sp]
	ldr r0, [r4, #0x84]
	mov r3, r1
	mov r2, #3
	bl ObjShiftSet
	str r0, [r4, #0x84]
	mov r0, #0x100
	str r0, [sp]
	mov r1, #0
	ldr r0, [r4, #0x88]
	mov r2, #3
	mov r3, r1
	bl ObjShiftSet
	str r0, [r4, #0x88]
_0217148C:
	ldrh r0, [r4, #0x72]
	cmp r0, #0
	bne _02171664
	mov r1, #0
	mov r2, r1
	mov r0, #0x15
	bl NNS_G3dGeBufferOP_N
	mov r3, #0x20000000
	add r1, sp, #4
	mov r0, #0x2a
	mov r2, #1
	str r3, [sp, #4]
	bl NNS_G3dGeBufferOP_N
	add r0, r6, #0x44
	add ip, sp, #0x74
	ldmia r0, {r0, r1, r2}
	mov r3, #0
	stmia ip, {r0, r1, r2}
	ldr r0, [sp, #0x78]
	str r3, [sp, #0x68]
	rsb r0, r0, #0
	str r0, [sp, #0x78]
	sub r0, r3, #0x800000
	str r0, [sp, #0x70]
	str r3, [sp, #0x6c]
	ldr r1, [r6, #0x12c]
	add r0, sp, #0x68
	add r1, r1, #0x24
	mov r2, r0
	bl MTX_MultVec33
	add r1, sp, #0x68
	add r0, sp, #0x74
	mov r2, r1
	bl VEC_Subtract
	ldr r0, [r5, #0x20]
	ldr r2, _0217168C // =0x0000047C
	tst r0, #0x800
	beq _0217153C
	ldrh r0, [r4, #0x70]
	tst r0, #4
	ldrh r0, [r4, #0x70]
	ldreq r2, _02171690 // =0x00007FFF
	add r0, r0, #1
	strh r0, [r4, #0x70]
_0217153C:
	add r0, sp, #0x74
	add r1, sp, #0x68
	mov r3, #0x14
	bl ovl02_2178294
	mov r0, r6
	mov r7, #0
	bl ovl02_217019C
	cmp r0, #0
	ldr r0, [r5, #0x20]
	beq _0217156C
	tst r0, #0x200
	b _02171570
_0217156C:
	tst r0, #0x400
_02171570:
	moveq r7, #1
	cmp r7, #0
	beq _02171664
	mov r2, #0
	sub r1, r2, #0x90000
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	ldr r1, [r6, #0x12c]
	add r0, sp, #8
	mov r2, r0
	add r1, r1, #0x24
	bl MTX_MultVec33
	ldr r0, [sp, #0xc]
	add r1, sp, #8
	rsb r0, r0, #0
	str r0, [sp, #0xc]
	mov r2, r1
	add r0, r6, #0x44
	bl VEC_Subtract
	ldr r1, [r6, #0x12c]
	mov r0, #0
	add r1, r1, #0x24
	str r1, [sp]
	ldr r2, [sp, #0xc]
	ldr r1, [sp, #8]
	ldr r3, [sp, #0x10]
	rsb r2, r2, #0
	bl BossFX__CreateTitanFlashC
	cmp r0, #0
	beq _021715FC
	mov r1, #0x1200
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	str r1, [r0, #0x40]
_021715FC:
	mov r0, #0xc000
	str r0, [r6, #4]
	mov r0, #0xa000
	str r0, [r6, #8]
	mov r0, #0
	str r0, [r4, #0x80]
	str r0, [r4, #0x84]
	mov r0, #0x3c000
	str r0, [r4, #0x88]
	ldr r1, [r6, #0x12c]
	add r0, r4, #0x80
	add r1, r1, #0x24
	mov r2, r0
	bl MTX_MultVec33
	ldr r1, [r4, #0x84]
	mov r0, #1
	rsb r1, r1, #0
	str r1, [r4, #0x84]
	strh r0, [r4, #0x72]
	ldr r1, [sp, #0x54]
	add r0, sp, #0x50
	rsb r1, r1, #0
	str r1, [sp, #0x54]
	add r3, r4, #0x74
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
_02171664:
	ldrh r0, [r4, #0x72]
	cmp r0, #0xa
	addlo sp, sp, #0x80
	ldmloia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, r6
	bl ovl02_2171108
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02171684: .word _02179090
_02171688: .word 0x000034CC
_0217168C: .word 0x0000047C
_02171690: .word 0x00007FFF
	arm_func_end ovl02_21712B4

	arm_func_start ovl02_2171694
ovl02_2171694: // _02171694
	ldr r2, _021716D8 // =ovl02_21716E0
	mov r1, #0
	str r2, [r0, #0xf4]
	str r1, [r0, #0x2c]
	str r1, [r0, #0x28]
	ldr r2, [r0, #0x1c]
	ldr ip, _021716DC // =ovl02_217873C
	bic r2, r2, #0x2000
	str r2, [r0, #0x1c]
	ldr r2, [r0, #0x24]
	mov r1, #0x6b
	orr r2, r2, #1
	str r2, [r0, #0x24]
	ldr r2, [r0, #0x20]
	bic r2, r2, #0x20
	str r2, [r0, #0x20]
	bx ip
	.align 2, 0
_021716D8: .word ovl02_21716E0
_021716DC: .word ovl02_217873C
	arm_func_end ovl02_2171694

	arm_func_start ovl02_21716E0
ovl02_21716E0: // _021716E0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #0x30]
	mov r1, #0xc000
	mov r2, #0x400
	bl ObjRoopMove16
	strh r0, [r4, #0x30]
	ldrh r0, [r4, #0x30]
	ldr r3, [r4, #0x12c]
	ldr r2, _021717A0 // =FX_SinCosTable_
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotX33_
	ldr r0, [r4, #0x28]
	cmp r0, #0
	bne _0217175C
	ldrh r0, [r4, #0x30]
	cmp r0, #0xc000
	bne _02171770
	mov r1, #1
	mov r0, #0x8000
	str r1, [r4, #0x28]
	str r0, [r4, #4]
	str r0, [r4, #8]
	b _02171770
_0217175C:
	ldr r0, [r4, #8]
	cmp r0, #0
	moveq r0, #0x10000
	rsbeq r0, r0, #0
	streq r0, [r4, #0x9c]
_02171770:
	ldr r2, [r4, #0x12c]
	ldr r1, _021717A4 // =0x000034CC
	ldr r0, _021717A8 // =0x001C2000
	str r1, [r2, #0x18]
	str r1, [r2, #0x1c]
	str r1, [r2, #0x20]
	ldr r1, [r4, #0x48]
	cmp r1, r0
	ldmgeia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_21717AC
	ldmia sp!, {r4, pc}
	.align 2, 0
_021717A0: .word FX_SinCosTable_
_021717A4: .word 0x000034CC
_021717A8: .word 0x001C2000
	arm_func_end ovl02_21716E0

	arm_func_start ovl02_21717AC
ovl02_21717AC: // _021717AC
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x24
	ldr r1, _02171A10 // =BossFStage__Singleton
	mov r6, r0
	ldr r0, [r1, #0]
	ldr r5, [r6, #0x124]
	bl GetTaskWork_
	ldr r1, _02171A14 // =ovl02_2171A28
	ldr r3, _02171A18 // =_mt_math_rand
	str r1, [r6, #0xf4]
	ldr ip, [r3]
	ldr r1, _02171A1C // =0x00196225
	ldr r2, _02171A20 // =0x3C6EF35F
	mov r4, r0
	mla r1, ip, r1, r2
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r3]
	tst r0, #1
	ldr r1, [r6, #0x20]
	mov r0, r6
	beq _021718DC
	bic r1, r1, #1
	str r1, [r6, #0x20]
	bl ovl02_217019C
	cmp r0, #0
	beq _02171840
	mov r0, #0x30000
	str r0, [r6, #0x44]
	ldr r0, [r4, #0x384]
	tst r0, #2
	movne r0, #0xa8000
	strne r0, [r6, #0x44]
	mov r0, #0
	str r0, [r6, #0x28]
	b _021719AC
_02171840:
	mov r0, #0x80000
	str r0, [r6, #0x44]
	ldr r0, [r4, #0x384]
	ldr r2, _02171A24 // =FX_SinCosTable_
	tst r0, #2
	movne r0, #0xf8000
	strne r0, [r6, #0x44]
	mov r0, #0x8000
	strh r0, [r6, #0x32]
	mov r0, #1
	str r0, [r6, #0x28]
	ldrh r0, [r6, #0x30]
	ldr r3, [r6, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotX33_
	ldrh r1, [r6, #0x32]
	ldr r3, _02171A24 // =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	ldr r2, [r6, #0x12c]
	add r1, sp, #0
	add r0, r2, #0x24
	add r2, r2, #0x24
	bl MTX_Concat33
	b _021719AC
_021718DC:
	orr r1, r1, #1
	str r1, [r6, #0x20]
	bl ovl02_217019C
	cmp r0, #0
	beq _02171914
	mov r0, #0x2c0000
	str r0, [r6, #0x44]
	ldr r0, [r4, #0x384]
	tst r0, #4
	movne r0, #0x248000
	strne r0, [r6, #0x44]
	mov r0, #0
	str r0, [r6, #0x28]
	b _021719AC
_02171914:
	mov r0, #0x270000
	str r0, [r6, #0x44]
	ldr r0, [r4, #0x384]
	ldr r2, _02171A24 // =FX_SinCosTable_
	tst r0, #4
	movne r0, #0x1f8000
	strne r0, [r6, #0x44]
	mov r0, #0x8000
	strh r0, [r6, #0x32]
	mov r0, #1
	str r0, [r6, #0x28]
	ldrh r0, [r6, #0x30]
	ldr r3, [r6, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotX33_
	ldrh r1, [r6, #0x32]
	ldr r3, _02171A24 // =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	ldr r2, [r6, #0x12c]
	add r1, sp, #0
	add r0, r2, #0x24
	add r2, r2, #0x24
	bl MTX_Concat33
_021719AC:
	mov r3, #0x3e8000
	str r3, [r6, #0x48]
	mov r4, #0
	mov r2, #0x4000
	mov r0, r2, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	str r4, [r6, #0x4c]
	mov r3, #0x8000
	str r3, [r6, #0x9c]
	str r4, [r6, #0x2c]
	strh r2, [r6, #0x30]
	ldr r2, _02171A24 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldr r3, [r6, #0x12c]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotX33_
	mov r0, r4
	strh r0, [r5, #0x70]
	str r0, [r5, #0x8c]
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02171A10: .word BossFStage__Singleton
_02171A14: .word ovl02_2171A28
_02171A18: .word _mt_math_rand
_02171A1C: .word 0x00196225
_02171A20: .word 0x3C6EF35F
_02171A24: .word FX_SinCosTable_
	arm_func_end ovl02_21717AC

	arm_func_start ovl02_2171A28
ovl02_2171A28: // _02171A28
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x44
	ldr r1, _02171EC8 // =BossFStage__Singleton
	mov r7, r0
	ldr r0, [r1, #0]
	ldr r4, [r7, #0x11c]
	ldr r5, [r7, #0x124]
	bl GetTaskWork_
	mov r6, r0
	mov r0, r7
	mov r1, #0
	bl ovl02_2169E34
	ldr r0, [r7, #0x9c]
	mov r1, #0x200
	bl ObjSpdDownSet
	str r0, [r7, #0x9c]
	ldr r0, [r5, #0x84]
	cmp r0, #0
	ldreq r0, [r7, #0x98]
	cmpeq r0, #0
	ldreq r0, [r7, #0x9c]
	cmpeq r0, #0
	ldreq r0, [r7, #0xa0]
	cmpeq r0, #0
	bne _02171B68
	ldr r0, [r7, #0x2c]
	add r0, r0, #1
	str r0, [r7, #0x2c]
	cmp r0, #0x18
	bne _02171B68
	ldr r1, [r7, #0x44]
	mov r0, r4
	mov r2, #0x740000
	bl ovl02_2172108
	mov r2, #0
	ldr r1, _02171ECC // =0x00000123
	mov r0, r7
	str r2, [r7, #0x2c]
	bl ovl02_217873C
	mov r0, #0x20000
	rsb r0, r0, #0
	str r0, [r5, #0x84]
	ldr r0, [r7, #0x20]
	tst r0, #1
	ldr r0, [r6, #0x384]
	beq _02171B0C
	tst r0, #2
	ldr r0, [r7, #0x44]
	mov r1, #0x18000
	movne r1, #0x78000
	sub r0, r0, #0xa0000
	cmp r0, r1
	bge _02171B38
	mov r0, r7
	bl ovl02_2171EDC
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, r6, r7, pc}
_02171B0C:
	tst r0, #4
	ldr r0, [r7, #0x44]
	mov r1, #0x2d8000
	movne r1, #0x278000
	add r0, r0, #0xa0000
	cmp r0, r1
	ble _02171B38
	mov r0, r7
	bl ovl02_2171EDC
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, r6, r7, pc}
_02171B38:
	mov r0, #0xc000
	str r0, [r5, #0x8c]
	mov r0, #0x600
	strh r0, [r5, #0x90]
	add r0, r6, #0x500
	ldrh r0, [r0, #0x36]
	cmp r0, #2
	bls _02171B68
	mov r0, #0x10000
	str r0, [r5, #0x8c]
	mov r0, #0x800
	strh r0, [r5, #0x90]
_02171B68:
	ldr r0, [r5, #0x84]
	cmp r0, #0
	bne _02171C44
	mov r1, #0
	mov r2, r1
	mov r0, #0x15
	bl NNS_G3dGeBufferOP_N
	mov r3, #0x20000000
	add r1, sp, #4
	mov r0, #0x2a
	mov r2, #1
	str r3, [sp, #4]
	bl NNS_G3dGeBufferOP_N
	add r0, r7, #0x44
	mov r4, #0
	ldmia r0, {r0, r1, r2}
	add r6, sp, #0x38
	stmia r6, {r0, r1, r2}
	ldr r0, [sp, #0x3c]
	sub r3, r4, #0x800000
	rsb r1, r0, #0
	add r0, sp, #0x2c
	str r3, [sp, #0x34]
	str r4, [sp, #0x2c]
	str r4, [sp, #0x30]
	str r1, [sp, #0x3c]
	ldr r1, [r7, #0x12c]
	mov r2, r0
	add r1, r1, #0x24
	bl MTX_MultVec33
	add r1, sp, #0x2c
	mov r0, r6
	mov r2, r1
	bl VEC_Subtract
	ldr r0, [r7, #0x2c]
	ldr r4, _02171ED0 // =0x0000047C
	cmp r0, #0xb
	bne _02171C0C
	mov r0, r7
	mov r1, #0xb9
	bl ovl02_217873C
_02171C0C:
	ldr r0, [r7, #0x2c]
	cmp r0, #0xa
	ble _02171C30
	ldrh r0, [r5, #0x70]
	tst r0, #4
	ldrh r0, [r5, #0x70]
	ldreq r4, _02171ED4 // =0x00007FFF
	add r0, r0, #1
	strh r0, [r5, #0x70]
_02171C30:
	add r0, sp, #0x38
	add r1, sp, #0x2c
	mov r2, r4
	mov r3, #0x14
	bl ovl02_2178294
_02171C44:
	ldr r0, [r5, #0x84]
	cmp r0, #0
	bne _02171E28
	ldr r0, [r5, #0x8c]
	cmp r0, #0
	beq _02171E28
	ldr r0, [r7, #0x20]
	tst r0, #1
	ldr r0, [r7, #0x28]
	beq _02171CE0
	tst r0, #1
	ldrh r1, [r7, #0x32]
	ldrsh r0, [r5, #0x90]
	beq _02171CAC
	add r0, r1, r0
	strh r0, [r7, #0x32]
	ldrh r0, [r7, #0x32]
	cmp r0, #0x8000
	bhs _02171D50
	mov r0, #0
	strh r0, [r7, #0x32]
	str r0, [r5, #0x8c]
	ldr r0, [r7, #0x28]
	add r0, r0, #1
	str r0, [r7, #0x28]
	b _02171D50
_02171CAC:
	sub r0, r1, r0
	strh r0, [r7, #0x32]
	ldrh r0, [r7, #0x32]
	cmp r0, #0x8000
	bhs _02171D50
	mov r0, #0x8000
	strh r0, [r7, #0x32]
	mov r0, #0
	str r0, [r5, #0x8c]
	ldr r0, [r7, #0x28]
	add r0, r0, #1
	str r0, [r7, #0x28]
	b _02171D50
_02171CE0:
	tst r0, #1
	ldrh r1, [r7, #0x32]
	ldrsh r0, [r5, #0x90]
	beq _02171D20
	sub r0, r1, r0
	strh r0, [r7, #0x32]
	ldrh r0, [r7, #0x32]
	cmp r0, #0x8000
	bls _02171D50
	mov r0, #0
	strh r0, [r7, #0x32]
	str r0, [r5, #0x8c]
	ldr r0, [r7, #0x28]
	add r0, r0, #1
	str r0, [r7, #0x28]
	b _02171D50
_02171D20:
	add r0, r1, r0
	strh r0, [r7, #0x32]
	ldrh r0, [r7, #0x32]
	cmp r0, #0x8000
	bls _02171D50
	mov r0, #0x8000
	strh r0, [r7, #0x32]
	mov r0, #0
	str r0, [r5, #0x8c]
	ldr r0, [r7, #0x28]
	add r0, r0, #1
	str r0, [r7, #0x28]
_02171D50:
	ldrh r0, [r7, #0x30]
	ldr r2, _02171ED8 // =FX_SinCosTable_
	ldr r3, [r7, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotX33_
	ldrh r1, [r7, #0x32]
	ldr r3, _02171ED8 // =FX_SinCosTable_
	add r0, sp, #8
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	ldr r2, [r7, #0x12c]
	add r1, sp, #8
	add r0, r2, #0x24
	add r2, r2, #0x24
	bl MTX_Concat33
	ldrh r0, [r7, #0x32]
	ldr r2, _02171ED8 // =FX_SinCosTable_
	ldr r1, [r5, #0x8c]
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r0, [r2, r0]
	smull r3, r0, r1, r0
	adds r1, r3, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r7, #0x98]
	ldrh r0, [r7, #0x32]
	ldr r1, [r5, #0x8c]
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrsh r0, [r2, r0]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r7, #0xa0]
	b _02171E34
_02171E28:
	mov r0, #0
	str r0, [r7, #0x98]
	str r0, [r7, #0xa0]
_02171E34:
	ldr r1, [r5, #0x80]
	ldr r0, [r5, #0x84]
	ldr r2, [r5, #0x88]
	orr r0, r1, r0
	orrs r0, r2, r0
	addeq sp, sp, #0x44
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	add r0, r5, #0x80
	add r3, r7, #0x50
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #0x100
	str r0, [sp]
	mov r1, #0
	ldr r0, [r5, #0x80]
	mov r3, r1
	mov r2, #3
	bl ObjShiftSet
	mov r1, #0
	str r0, [r5, #0x80]
	mov r0, #0x100
	str r0, [sp]
	ldr r0, [r5, #0x84]
	mov r3, r1
	mov r2, #3
	bl ObjShiftSet
	mov r1, #0
	str r0, [r5, #0x84]
	mov r0, #0x100
	str r0, [sp]
	ldr r0, [r5, #0x88]
	mov r2, #3
	mov r3, r1
	bl ObjShiftSet
	str r0, [r5, #0x88]
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02171EC8: .word BossFStage__Singleton
_02171ECC: .word 0x00000123
_02171ED0: .word 0x0000047C
_02171ED4: .word 0x00007FFF
_02171ED8: .word FX_SinCosTable_
	arm_func_end ovl02_2171A28

	arm_func_start ovl02_2171EDC
ovl02_2171EDC: // _02171EDC
	ldr r2, _02171EFC // =ovl02_2171F00
	mov r1, #0
	str r2, [r0, #0xf4]
	str r1, [r0, #0x2c]
	ldr r1, [r0, #0x20]
	bic r1, r1, #1
	str r1, [r0, #0x20]
	bx lr
	.align 2, 0
_02171EFC: .word ovl02_2171F00
	arm_func_end ovl02_2171EDC

	arm_func_start ovl02_2171F00
ovl02_2171F00: // _02171F00
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	mov r1, #0
	bl ovl02_2169E34
	ldr r1, [r4, #0x80]
	ldr r0, [r4, #0x84]
	ldr r2, [r4, #0x88]
	orr r0, r1, r0
	orrs r0, r2, r0
	beq _02171F9C
	add r0, r4, #0x80
	add r3, r5, #0x50
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #0x100
	str r0, [sp]
	mov r1, #0
	ldr r0, [r4, #0x80]
	mov r3, r1
	mov r2, #3
	bl ObjShiftSet
	mov r1, #0
	str r0, [r4, #0x80]
	mov r0, #0x100
	str r0, [sp]
	ldr r0, [r4, #0x84]
	mov r3, r1
	mov r2, #3
	bl ObjShiftSet
	mov r1, #0
	str r0, [r4, #0x84]
	mov r0, #0x100
	str r0, [sp]
	ldr r0, [r4, #0x88]
	mov r2, #3
	mov r3, r1
	bl ObjShiftSet
	str r0, [r4, #0x88]
_02171F9C:
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #0x18
	ble _02171FC8
	mov r1, #0x400
	ldr r0, [r5, #0x9c]
	rsb r1, r1, #0
	mov r2, #0x8000
	bl ObjSpdUpSet
	str r0, [r5, #0x9c]
_02171FC8:
	ldr r0, [r5, #0x48]
	cmp r0, #0x3e8000
	ldmgeia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl ovl02_2171FE0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_2171F00

	arm_func_start ovl02_2171FE0
ovl02_2171FE0: // _02171FE0
	stmdb sp!, {r4, lr}
	ldr r1, _0217202C // =ovl02_2172034
	mov r4, r0
	str r1, [r4, #0xf4]
	mov r1, #0
	str r1, [r4, #0x2c]
	str r1, [r4, #0x98]
	mov r0, #0x10000
	str r0, [r4, #0x9c]
	ldr r0, _02172030 // =0x001C2000
	str r1, [r4, #0xa0]
	str r0, [r4, #0x48]
	ldr r0, [r4, #0x12c]
	add r0, r0, #0x24
	bl MTX_Identity33_
	ldr r0, [r4, #0x20]
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217202C: .word ovl02_2172034
_02172030: .word 0x001C2000
	arm_func_end ovl02_2171FE0

	arm_func_start ovl02_2172034
ovl02_2172034: // _02172034
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r1, [r4, #0x11c]
	ldr r5, [r1, #0x124]
	bl ovl02_217019C
	cmp r0, #0
	addne ip, r5, #0x2a8
	addeq ip, r5, #0x2d8
	ldr r0, [ip, #0x24]
	mov r6, ip
	str r0, [r4, #0x44]
	ldr r0, [ip, #0x2c]
	mov lr, #0x1000
	str r0, [r4, #0x4c]
	ldr r5, [r4, #0x12c]
	ldmia r6!, {r0, r1, r2, r3}
	add r5, r5, #0x24
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldr r0, [r6, #0]
	str r0, [r5]
	ldr r0, [r4, #0x12c]
	str lr, [r0, #0x18]
	str lr, [r0, #0x1c]
	str lr, [r0, #0x20]
	ldr r2, [ip, #0x28]
	ldr r1, [r4, #0x48]
	ldr r0, [r4, #0x9c]
	rsb r2, r2, #0
	add r0, r1, r0
	cmp r0, r2
	ldmltia sp!, {r4, r5, r6, pc}
	str r2, [r4, #0x48]
	mov r0, #0x10000
	str r0, [r4, #4]
	ldr r0, [r4, #0x1c]
	mov r2, #0
	orr r0, r0, #0x2000
	str r0, [r4, #0x1c]
	ldr r1, [r4, #0x24]
	mov r0, r4
	bic r1, r1, #1
	str r1, [r4, #0x24]
	str r2, [r4, #0x9c]
	strh r2, [r4, #0x30]
	strh r2, [r4, #0x32]
	mov r1, #0x50
	strh r2, [r4, #0x34]
	bl ovl02_217873C
	mov r0, r4
	bl ovl02_2171108
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl02_2172034

	arm_func_start ovl02_2172108
ovl02_2172108: // _02172108
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	mov r6, r1
	mov r0, #0x1500
	mov r1, #2
	mov r5, r2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r1, #6
	bl StageTask__SetType
	ldr r0, [r4, #0x120]
	mov r1, #0
	bl SetTaskPauseLevel
	mov r0, r4
	mov r1, #0x70
	bl StageTask__AllocateWorker
	ldr r3, _021722C0 // =0x0000FFFF
	mov r1, #0
	str r3, [sp]
	str r1, [sp, #4]
	ldr r2, _021722C4 // =gameArchiveStage
	mov r0, r4
	ldr ip, [r2]
	ldr r2, _021722C8 // =aBsefBombBac_1
	str ip, [sp, #8]
	bl ObjObjectAction3dBACLoad
	mov r1, r7
	mov r2, #0x1d
	ldr r0, [r4, #0x134]
	mov r3, #7
	strb r2, [r0, #0xa]
	ldr r2, [r4, #0x134]
	ldr r0, _021722CC // =ovl02_21722D8
	strb r3, [r2, #0xb]
	str r0, [r4, #0xfc]
	ldr r2, [r4, #0x18]
	mov r0, r4
	orr r2, r2, #0x12
	str r2, [r4, #0x18]
	ldr r3, [r4, #0x20]
	mov r2, #0
	orr r3, r3, #0x180
	str r3, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	orr r3, r3, #0x100
	str r3, [r4, #0x1c]
	bl StageTask__SetParent
	str r6, [r4, #0x44]
	str r5, [r4, #0x48]
	mov r1, #0
	str r1, [r4, #0x4c]
	mov r0, r4
	mov r2, r1
	mov r3, r1
	bl StageTask__InitCollider
	mov r0, r4
	mov r1, #0
	bl StageTask__GetCollider
	mov r6, r0
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r6
	ldr r1, _021722C0 // =0x0000FFFF
	mov r2, #0
	bl ObjRect__SetDefenceStat
	mov r2, #0
	str r2, [sp]
	mov r0, r6
	sub r1, r2, #0x18
	sub r2, r2, #0xb4
	mov r3, #0x18
	bl ObjRect__SetBox2D
	mov r1, #0
	ldr r5, _021722D0 // =0x00000102
	str r4, [r6, #0x1c]
	mov r0, r4
	mov r3, r1
	mov r2, #1
	strh r5, [r6, #0x34]
	bl StageTask__InitCollider
	mov r0, r4
	mov r1, #1
	bl StageTask__GetCollider
	mov r1, #1
	mov r2, #0x40
	mov r5, r0
	bl ObjRect__SetAttackStat
	ldr r1, _021722C0 // =0x0000FFFF
	mov r0, r5
	mov r2, #0
	bl ObjRect__SetDefenceStat
	mov r2, #0
	str r2, [sp]
	mov r0, r5
	sub r1, r2, #0x20
	sub r2, r2, #0xb4
	mov r3, #0x20
	bl ObjRect__SetBox2D
	str r4, [r5, #0x1c]
	ldr r1, _021722D4 // =0x00000201
	mov r0, r4
	strh r1, [r5, #0x34]
	bl StageTask__InitSeqPlayer
	mov r0, r4
	bl ovl02_2172388
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_021722C0: .word 0x0000FFFF
_021722C4: .word gameArchiveStage
_021722C8: .word aBsefBombBac_1
_021722CC: .word ovl02_21722D8
_021722D0: .word 0x00000102
_021722D4: .word 0x00000201
	arm_func_end ovl02_2172108

	arm_func_start ovl02_21722D8
ovl02_21722D8: // _021722D8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	bl GetCurrentTaskWork_
	mov r6, r0
	ldr r7, [r6, #0x124]
	add r5, r6, #0x44
	add r3, sp, #0
	ldmia r5, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r6, #0x20]
	mov r8, #0
	bic r0, r0, #0x1000
	str r0, [r6, #0x20]
	add r4, r7, #0x30
	mov r9, #0xc
_02172314:
	mul ip, r8, r9
	add r3, r7, ip
	ldmia r3, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	mov r0, r3
	mov r2, r3
	add r1, r4, ip
	bl VEC_Add
	add r0, r7, r8, lsl #2
	ldr r1, [r0, #0x60]
	mov r0, r6
	str r1, [r6, #0x38]
	str r1, [r6, #0x3c]
	str r1, [r6, #0x40]
	bl StageTask__Draw
	add r0, r8, #1
	ldr r1, [r6, #0x20]
	mov r0, r0, lsl #0x10
	orr r1, r1, #0x1000
	mov r8, r0, lsr #0x10
	str r1, [r6, #0x20]
	cmp r8, #4
	blo _02172314
	add r0, sp, #0
	add r3, r6, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end ovl02_21722D8

	arm_func_start ovl02_2172388
ovl02_2172388: // _02172388
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r4, r0
	ldr r8, [r4, #0x124]
	ldr r0, _02172594 // =ovl02_21725AC
	mov r7, #0
	str r0, [r4, #0xf4]
	str r7, [r4, #0x2c]
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	sub r0, r0, #0x20000
	str r1, [r8]
	stmib r8, {r0, r7}
	str r7, [r8, #0x30]
	sub r5, r7, #0x1000
	str r5, [r8, #0x34]
	mov lr, #0x2800
	str r7, [r8, #0x38]
	str lr, [r8, #0x60]
	ldr r2, _02172598 // =_mt_math_rand
	ldr r0, _0217259C // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _021725A0 // =0x3C6EF35F
	ldr ip, [r4, #0x44]
	mla r6, r3, r0, r1
	mov r3, r6, lsr #0x10
	mov r3, r3, lsl #0x10
	mla r10, r6, r0, r1
	mov r3, r3, lsr #0x10
	and r6, r3, #0xf
	ldr r3, [r4, #0x48]
	rsb r11, r6, #8
	mov r6, r10, lsr #0x10
	add ip, ip, r11, lsl #12
	str r10, [r2]
	ldr r9, _021725A4 // =0x00000FFF
	mov r6, r6, lsl #0x10
	str ip, [r8, #0xc]
	sub r3, r3, #0x50000
	str r3, [r8, #0x10]
	and r6, r9, r6, lsr #16
	rsb r3, r6, #0x800
	str r5, [r8, #0x14]
	str r3, [r8, #0x3c]
	sub r6, lr, #0x4800
	str r6, [r8, #0x40]
	mov r11, #0x1c00
	str r7, [r8, #0x44]
	str r11, [r8, #0x64]
	ldr r10, [r2, #0]
	ldr r5, [r4, #0x48]
	mla r3, r10, r0, r1
	mla ip, r3, r0, r1
	mla r10, ip, r0, r1
	mov r3, r3, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	and lr, r3, #0x1f
	ldr r3, [r4, #0x44]
	rsb lr, lr, #0x10
	mov ip, ip, lsr #0x10
	add lr, r3, lr, lsl #12
	mov r3, r10, lsr #0x10
	str r10, [r2]
	mov ip, ip, lsl #0x10
	add r10, r9, #0x1000
	and ip, r10, ip, lsr #16
	mov r3, r3, lsl #0x10
	sub r10, r9, #0x800
	and r10, r10, r3, lsr #16
	sub r3, r11, #0x4c00
	str lr, [r8, #0x18]
	sub r5, r5, #0x6e000
	str r5, [r8, #0x1c]
	sub r3, r3, r10
	rsb r5, ip, #0x1000
	str r6, [r8, #0x20]
	str r5, [r8, #0x48]
	str r3, [r8, #0x4c]
	mov r6, #0x1800
	str r7, [r8, #0x50]
	str r6, [r8, #0x68]
	ldr r3, [r2, #0]
	ldr r5, [r4, #0x48]
	mla ip, r3, r0, r1
	mla r3, ip, r0, r1
	mla r10, r3, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	ldr r1, [r4, #0x44]
	rsb r0, r0, #0x10
	mov ip, r3, lsr #0x10
	add r0, r1, r0, lsl #12
	str r10, [r2]
	str r0, [r8, #0x24]
	sub r5, r5, #0x82000
	str r5, [r8, #0x28]
	sub r5, r6, #0x4800
	mov r3, r10, lsr #0x10
	mov r0, ip, lsl #0x10
	add r1, r9, #0x1000
	and r2, r1, r0, lsr #16
	mov r0, r3, lsl #0x10
	sub r1, r9, #0x800
	and r1, r1, r0, lsr #16
	sub r0, r6, #0x5800
	str r5, [r8, #0x2c]
	rsb r2, r2, #0x1000
	str r2, [r8, #0x54]
	sub r0, r0, r1
	str r0, [r8, #0x58]
	str r7, [r8, #0x5c]
	str r11, [r8, #0x6c]
	mov r0, #9
	bl ShakeScreen
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	rsb r2, r0, #0
	ldr r3, [r4, #0x4c]
	mov r0, r7
	bl BossFX__CreateRexRage
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r2, _021725A8 // =ovl02_2176A2C
	mov r1, #0xe00
	str r2, [r0, #0x2e4]
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	str r1, [r0, #0x40]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02172594: .word ovl02_21725AC
_02172598: .word _mt_math_rand
_0217259C: .word 0x00196225
_021725A0: .word 0x3C6EF35F
_021725A4: .word 0x00000FFF
_021725A8: .word ovl02_2176A2C
	arm_func_end ovl02_2172388

	arm_func_start ovl02_21725AC
ovl02_21725AC: // _021725AC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x2c]
	cmp r1, #1
	beq _021725D4
	cmp r1, #4
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #2
	streq r0, [r4, #0x18]
	b _021725E8
_021725D4:
	ldr r2, [r4, #0x18]
	mov r1, #0xc2
	bic r2, r2, #2
	str r2, [r4, #0x18]
	bl ovl02_217873C
_021725E8:
	ldr r0, [r4, #0x20]
	tst r0, #8
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #4
	strne r0, [r4, #0x18]
	ldr r1, [r4, #0x2c]
	mov r0, r4
	add r2, r1, #1
	mov r1, #1
	str r2, [r4, #0x2c]
	bl ovl02_2169E34
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_21725AC

	arm_func_start ovl02_2172618
ovl02_2172618: // _02172618
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x124]
	ldr r0, [r0, #0x54]
	cmp r0, #0
	beq _0217263C
	bl NNS_SndHandleReleaseSeq
_0217263C:
	mov r0, r4
	bl ovl02_217019C
	cmp r0, #0
	beq _02172664
	ldr r0, [r4, #0x12c]
	ldr r0, [r0, #0x15c]
	bl ObjDataRelease
	ldr r0, [r4, #0x12c]
	mov r1, #0
	str r1, [r0, #0x144]
_02172664:
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_2172618

	arm_func_start ovl02_2172670
ovl02_2172670: // _02172670
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r2, [r0, #0x124]
	ldr r1, [r2, #0x58]
	cmp r1, #0
	beq _02172698
	ldr r1, [r1, #0x18]
	tst r1, #4
	movne r1, #0
	strne r1, [r2, #0x58]
_02172698:
	ldr r1, [r2, #0x5c]
	cmp r1, #0
	beq _021726B4
	ldr r1, [r1, #0x18]
	tst r1, #4
	movne r1, #0
	strne r1, [r2, #0x5c]
_021726B4:
	ldr r1, [r0, #0x35c]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldr r1, [r1, #0x18]
	tst r1, #4
	movne r1, #0
	strne r1, [r0, #0x35c]
	ldmia sp!, {r3, pc}
	arm_func_end ovl02_2172670

	arm_func_start ovl02_21726D4
ovl02_21726D4: // _021726D4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x30
	mov r5, r0
	bl GetCurrentTaskWork_
	ldr r1, [r5, #8]
	ldr r4, [r0, #0x124]
	tst r1, #0x10
	ldrneb r1, [r5, #0xae]
	ldr r0, [r4, #0]
	mvneq r1, #0
	cmp r0, r1
	addne sp, sp, #0x30
	ldmneia sp!, {r3, r4, r5, pc}
	ldrh r0, [r4, #8]
	ldr r2, _021727C0 // =FX_SinCosTable_
	ldr r1, [r4, #4]
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	mov r3, r0, lsl #1
	ldrsh r3, [r2, r3]
	add r0, r0, #1
	mov r0, r0, lsl #1
	smull r3, ip, r1, r3
	ldrsh r2, [r2, r0]
	adds lr, r3, #0x800
	mov r0, #0
	smull r3, r2, r1, r2
	adc r1, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r1, lsl #20
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	rsb ip, ip, #0
	str r0, [sp]
	str r2, [sp, #8]
	add r1, sp, #0
	str ip, [sp, #4]
	mov r0, #0x1c
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
	ldrh r1, [r4, #8]
	ldr r3, _021727C0 // =FX_SinCosTable_
	add r0, sp, #0xc
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	bl MTX_RotX33_
	add r1, sp, #0xc
	mov r0, #0x1a
	mov r2, #9
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021727C0: .word FX_SinCosTable_
	arm_func_end ovl02_21726D4

	arm_func_start ovl02_21727C4
ovl02_21727C4: // _021727C4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r7, r1
	ldr r4, [r7, #0x1c]
	mov r8, r0
	ldr r1, [r4, #0xf4]
	ldr r0, _02172AC4 // =ovl02_2172E68
	ldr r6, [r8, #0x1c]
	cmp r1, r0
	ldr r5, [r4, #0x124]
	ldrh r0, [r6, #0]
	bne _02172A9C
	cmp r0, #1
	bne _02172920
	add r0, r6, #0x600
	ldrsh r0, [r0, #0x82]
	cmp r0, #0
	bne _021728A8
	mov r1, #0
	str r1, [r6, #0x98]
	mov r0, r4
	str r1, [r6, #0xc8]
	bl ovl02_217019C
	cmp r0, #0
	ldr r0, [r6, #0x20]
	orrne r0, r0, #1
	biceq r0, r0, #1
	str r0, [r6, #0x20]
	mov r0, r6
	bl Player__Hurt
	bl ovl02_216A0D4
	bl ovl02_216A094
	ldrsh r1, [r5, #0x10]
	sub r0, r1, r0, asr #1
	strh r0, [r5, #0x10]
	ldr r0, [r5, #0x58]
	cmp r0, #0
	beq _0217285C
	bl ovl02_21741F4
_0217285C:
	mov r0, #2
	bl ShakeScreen
	mov r0, r7
	mov r1, r8
	bl ObjRect__HitCenterX
	mov r9, r0
	mov r0, r7
	mov r1, r8
	bl ObjRect__HitCenterY
	ldr r3, [r7, #0x14]
	rsb r2, r0, #0
	mov r1, r9
	mov r0, #0
	mov r3, r3, lsl #0xc
	bl BossFX__CreateHitA
	mov r0, r4
	mov r1, #0x134
	bl ovl02_217873C
	b _021728B4
_021728A8:
	ldr r0, [r6, #0x1c]
	orr r0, r0, #4
	str r0, [r6, #0x1c]
_021728B4:
	mov r0, r4
	bl ovl02_217019C
	cmp r0, #0
	ldrsh r2, [r7, #0]
	beq _021728F4
	ldrsh r0, [r8, #0]
	ldr r1, [r6, #0x44]
	ldr r3, [r4, #0x44]
	rsb r2, r2, #0
	add r2, r3, r2, lsl #12
	add r0, r1, r0, lsl #12
	subs r0, r2, r0
	str r0, [r6, #0xb0]
	movmi r0, #0
	strmi r0, [r6, #0xb0]
	b _02172A18
_021728F4:
	ldrsh r0, [r8, #6]
	ldr r3, [r4, #0x44]
	ldr r1, [r6, #0x44]
	add r2, r3, r2, lsl #12
	add r0, r1, r0, lsl #12
	sub r0, r2, r0
	str r0, [r6, #0xb0]
	cmp r0, #0
	movgt r0, #0
	strgt r0, [r6, #0xb0]
	b _02172A18
_02172920:
	add r0, r0, #0xfe
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _02172964
	bl ovl02_216A094
	ldrsh r1, [r5, #0x10]
	sub r0, r1, r0
	strh r0, [r5, #0x10]
	ldr r0, [r5, #0x58]
	cmp r0, #0
	beq _02172958
	bl ovl02_21741F4
_02172958:
	mov r0, #2
	bl ShakeScreen
	b _021729B8
_02172964:
	ldr r1, [r8, #0x18]
	ldr r0, _02172AC8 // =ovl02_21725AC
	orr r1, r1, #0x800
	str r1, [r8, #0x18]
	ldr r1, [r6, #0xf4]
	cmp r1, r0
	bne _02172990
	bl ovl02_216A094
	ldrsh r1, [r5, #0x10]
	sub r0, r1, r0
	b _0217299C
_02172990:
	bl ovl02_216A094
	ldrsh r1, [r5, #0x10]
	sub r0, r1, r0, asr #1
_0217299C:
	strh r0, [r5, #0x10]
	ldr r0, [r5, #0x58]
	cmp r0, #0
	beq _021729B0
	bl ovl02_21741F4
_021729B0:
	mov r0, #2
	bl ShakeScreen
_021729B8:
	ldr r1, _02172ACC // =0x00000135
	mov r0, r4
	bl ovl02_217873C
	mov r0, r7
	mov r1, r8
	bl ObjRect__HitCenterX
	mov r6, r0
	mov r0, r7
	mov r1, r8
	bl ObjRect__HitCenterY
	ldr r3, [r7, #0x14]
	rsb r2, r0, #0
	mov r1, r6
	mov r3, r3, lsl #0xc
	mov r0, #0
	bl BossFX__CreateHitA
	cmp r0, #0
	beq _02172A18
	ldr r2, _02172AD0 // =ovl02_2176A2C
	mov r1, #0x2000
	str r2, [r0, #0x2e4]
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	str r1, [r0, #0x40]
_02172A18:
	ldrsh r0, [r5, #0x10]
	cmp r0, #0
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r1, #0
	mov r0, r4
	strh r1, [r5, #0x10]
	bl ovl02_2172ECC
	mov r0, #0
	bl CreateScreenEffect
	mov r0, #8
	bl ShakeScreen
	mov r0, r4
	mov r4, #0x6000
	bl ovl02_217019C
	cmp r0, #0
	ldr r0, _02172AD4 // =gPlayer
	rsbeq r4, r4, #0
	ldr r0, [r0, #0]
	bl BossHelpers__Player__IsAlive
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r0, _02172AD4 // =gPlayer
	ldr r1, [r0, #0]
	ldr r0, [r1, #0x1c]
	tst r0, #0x10
	strne r4, [r1, #0x98]
	streq r4, [r1, #0xc8]
	ldr r0, _02172AD4 // =gPlayer
	mov r1, #0x18
	ldr r0, [r0, #0]
	add r0, r0, #0x500
	strh r1, [r0, #0xfa]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02172A9C:
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, r6
	bl BossHelpers__Player__IsAlive
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, r4
	mov r1, r6
	bl ovl02_2173568
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02172AC4: .word ovl02_2172E68
_02172AC8: .word ovl02_21725AC
_02172ACC: .word 0x00000135
_02172AD0: .word ovl02_2176A2C
_02172AD4: .word gPlayer
	arm_func_end ovl02_21727C4

	arm_func_start ovl02_2172AD8
ovl02_2172AD8: // _02172AD8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	ldr r6, [r8, #0x1c]
	mov r7, r1
	ldr r4, [r7, #0x1c]
	ldrh r0, [r6, #0]
	ldr r5, [r4, #0x124]
	cmp r0, #1
	ldreqsh r0, [r5, #0x16]
	cmpeq r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r6
	bl Player__Action_DestroyAttackRecoil
	bl ovl02_216A0D4
	bl ovl02_216A0B4
	ldrsh r3, [r5, #0x12]
	mov r2, #0x30
	mov r1, #8
	sub r0, r3, r0
	strh r0, [r5, #0x12]
	strh r2, [r5, #0x14]
	strh r1, [r5, #0x16]
	mov r0, r7
	mov r1, r8
	bl ObjRect__HitCenterX
	mov r1, r8
	mov r8, r0
	mov r0, r7
	bl ObjRect__HitCenterY
	rsb r2, r0, #0
	ldr r3, [r4, #0x4c]
	mov r1, r8
	mov r0, #0
	bl BossFX__CreateHitA
	ldrsh r0, [r5, #0x12]
	cmp r0, #0
	bgt _02172BB8
	mov r1, #0
	mov r0, r4
	strh r1, [r5, #0x12]
	bl ovl02_21733B8
	ldr r0, [r4, #0x20]
	ldr r2, [r4, #0x44]
	tst r0, #1
	ldr r0, [r4, #0x48]
	sub r1, r2, #0x30000
	ldr r3, [r4, #0x4c]
	sub r0, r0, #0x32000
	addne r1, r2, #0x30000
	rsb r2, r0, #0
	mov r0, #0
	bl BossFX__CreateBomb
	mov r0, r4
	mov r1, #0x99
	bl ovl02_217873C
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02172BB8:
	mov r0, r4
	mov r5, #0x4000
	bl ovl02_217019C
	cmp r0, #0
	ldr r0, [r6, #0xc0]
	rsbeq r5, r5, #0
	cmp r0, #0
	ldrlt r0, [r6, #0x9c]
	rsblt r0, r0, #0
	strlt r0, [r6, #0x9c]
	mov r0, r6
	bl BossHelpers__Player__IsAlive
	cmp r0, #0
	beq _02172C0C
	ldr r0, [r6, #0x1c]
	mov r1, #0x18
	tst r0, #0x10
	strne r5, [r6, #0x98]
	streq r5, [r6, #0xc8]
	add r0, r6, #0x500
	strh r1, [r0, #0xfa]
_02172C0C:
	mov r0, r4
	mov r1, #0x28
	bl ovl02_217873C
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end ovl02_2172AD8

	arm_func_start ovl02_2172C1C
ovl02_2172C1C: // _02172C1C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr ip, [r4, #0x124]
	ldr r0, _02172C98 // =ovl02_2172CA0
	mov r2, #0
	str r0, [r4, #0xf4]
	ldr r0, [r4, #0x20]
	orr r3, r0, #0x20
	str r3, [r4, #0x20]
	mov r3, #0xa000
	mov r0, r2, asr #4
	str r3, [ip, #4]
	mov r1, r0, lsl #1
	add r0, r1, #1
	strh r2, [ip, #8]
	strh r2, [ip, #0xa]
	ldr r2, _02172C9C // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldr r3, [r4, #0x12c]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotY33_
	ldr r0, [r4, #0x270]
	bic r0, r0, #4
	str r0, [r4, #0x270]
	ldr r0, [r4, #0x230]
	bic r0, r0, #4
	str r0, [r4, #0x230]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02172C98: .word ovl02_2172CA0
_02172C9C: .word FX_SinCosTable_
	arm_func_end ovl02_2172C1C

	arm_func_start ovl02_2172CA0
ovl02_2172CA0: // _02172CA0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x11c]
	ldr r1, [r4, #0x384]
	tst r1, #0x10
	beq _02172CC8
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_02172CC8:
	bl ovl02_217019C
	cmp r0, #0
	ldr r0, [r4, #0x384]
	beq _02172CEC
	tst r0, #2
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl ovl02_2172D00
	ldmia sp!, {r3, r4, r5, pc}
_02172CEC:
	tst r0, #4
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl ovl02_2172D00
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_2172CA0

	arm_func_start ovl02_2172D00
ovl02_2172D00: // _02172D00
	ldr r1, _02172D0C // =ovl02_2172D10
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_02172D0C: .word ovl02_2172D10
	arm_func_end ovl02_2172D00

	arm_func_start ovl02_2172D10
ovl02_2172D10: // _02172D10
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _02172D58 // =gPlayer
	mov r5, r0
	ldr r4, [r1, #0]
	bl ovl02_217019C
	cmp r0, #0
	ldr r0, [r4, #0x44]
	beq _02172D44
	cmp r0, #0xb4000
	ldmltia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl ovl02_2172D5C
	ldmia sp!, {r3, r4, r5, pc}
_02172D44:
	cmp r0, #0x23c000
	ldmgtia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl ovl02_2172D5C
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02172D58: .word gPlayer
	arm_func_end ovl02_2172D10

	arm_func_start ovl02_2172D5C
ovl02_2172D5C: // _02172D5C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r0, _02172E58 // =ovl02_2172E68
	mov r2, #0x58
	str r0, [r5, #0xf4]
	ldr r0, [r5, #0x20]
	mov r3, #0x1e
	orr r0, r0, #0x20
	str r0, [r5, #0x20]
	ldr r1, [r5, #0x18]
	sub r0, r2, #0x67
	bic r1, r1, #2
	str r1, [r5, #0x18]
	str r2, [sp]
	stmib sp, {r0, r3}
	sub r1, r3, #0x5a
	add r0, r5, #0x218
	sub r2, r2, #0x170
	sub r3, r3, #0x6e
	bl ObjRect__SetBox3D
	ldr r1, [r5, #0x230]
	ldr r0, _02172E5C // =ovl02_21727C4
	orr r1, r1, #0x84
	str r1, [r5, #0x230]
	str r0, [r5, #0x23c]
	bl ovl02_2169F80
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02172E0C
_02172DD8: // jump table
	b _02172DE8 // case 0
	b _02172DF4 // case 1
	b _02172DF4 // case 2
	b _02172E00 // case 3
_02172DE8:
	ldr r0, _02172E60 // =0x000002FF
	strh r0, [r4, #0x10]
	b _02172E14
_02172DF4:
	mov r0, #0x200
	strh r0, [r4, #0x10]
	b _02172E14
_02172E00:
	mov r0, #0x400
	strh r0, [r4, #0x10]
	b _02172E14
_02172E0C:
	mov r0, #0x700
	strh r0, [r4, #0x10]
_02172E14:
	mov r0, #0x48000
	str r0, [r4, #0xc]
	str r0, [r5, #0x54]
	ldr r0, [r5, #0x48]
	ldr r1, [r5, #0x44]
	rsb r2, r0, #0x10000
	ldr r3, [r5, #0x4c]
	mov r0, #0
	bl BossFX__CreateRexRage
	cmp r0, #0
	ldrne r1, _02172E64 // =ovl02_2176A2C
	strne r1, [r0, #0x2e4]
	mov r0, r5
	mov r1, #0x12c
	bl ovl02_217873C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02172E58: .word ovl02_2172E68
_02172E5C: .word ovl02_21727C4
_02172E60: .word 0x000002FF
_02172E64: .word ovl02_2176A2C
	arm_func_end ovl02_2172D5C

	arm_func_start ovl02_2172E68
ovl02_2172E68: // _02172E68
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r1, [r5, #0x11c]
	ldr r4, [r5, #0x124]
	ldr r1, [r1, #0x384]
	tst r1, #0x10
	beq _02172E94
	bl ovl02_21733B8
	mov r0, #0x168
	str r0, [r5, #0x2c]
	ldmia sp!, {r3, r4, r5, pc}
_02172E94:
	ldr r0, [r4, #0xc]
	mov r1, #0
	str r0, [r5, #0x54]
	mov r0, #8
	str r0, [sp]
	ldr r0, [r4, #0xc]
	mov r3, r1
	mov r2, #1
	bl ObjShiftSet
	str r0, [r4, #0xc]
	mov r0, r5
	mov r1, #1
	bl ovl02_2169E34
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_2172E68

	arm_func_start ovl02_2172ECC
ovl02_2172ECC: // _02172ECC
	ldr r3, [r0, #0x124]
	ldr r2, _02172EFC // =ovl02_2172F08
	mov r1, #0
	str r2, [r0, #0xf4]
	strh r1, [r3, #0xa]
	str r1, [r0, #0x2c]
	ldr r2, [r0, #0x230]
	ldr ip, _02172F00 // =ovl02_217873C
	bic r2, r2, #4
	ldr r1, _02172F04 // =0x0000012D
	str r2, [r0, #0x230]
	bx ip
	.align 2, 0
_02172EFC: .word ovl02_2172F08
_02172F00: .word ovl02_217873C
_02172F04: .word 0x0000012D
	arm_func_end ovl02_2172ECC

	arm_func_start ovl02_2172F08
ovl02_2172F08: // _02172F08
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r5, [r4, #0x124]
	mov r0, #8
	str r0, [sp]
	mov r1, #0
	ldr r0, [r5, #4]
	mov r3, r1
	mov r2, #1
	bl ObjShiftSet
	str r0, [r5, #4]
	mov r0, r4
	bl ovl02_217019C
	cmp r0, #0
	ldrh r0, [r5, #0xa]
	mov r2, #0x400
	beq _02172F58
	mov r1, #0x4000
	bl ObjRoopMove16
	b _02172F60
_02172F58:
	mov r1, #0xc000
	bl ObjRoopMove16
_02172F60:
	strh r0, [r5, #0xa]
	ldrh r0, [r5, #0xa]
	ldr r2, _02172FCC // =FX_SinCosTable_
	ldr r3, [r4, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotY33_
	mov r0, r4
	mov r1, #1
	bl ovl02_2169E34
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0x10
	ldmleia sp!, {r3, r4, r5, pc}
	ldr r1, [r4, #0x270]
	mov r0, r4
	orr r1, r1, #4
	str r1, [r4, #0x270]
	bl ovl02_2172FD0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02172FCC: .word FX_SinCosTable_
	arm_func_end ovl02_2172F08

	arm_func_start ovl02_2172FD0
ovl02_2172FD0: // _02172FD0
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _02173098 // =BossFStage__Singleton
	mov r6, r0
	ldr r0, [r1, #0]
	ldr r4, [r6, #0x124]
	bl GetTaskWork_
	ldr r5, [r0, #0x36c]
	mov r1, #0
	strh r1, [r4, #0x14]
	ldr r0, _0217309C // =ovl02_21730A4
	strh r1, [r4, #0x16]
	str r0, [r6, #0xf4]
	bl ovl02_2169F80
	cmp r0, #0
	beq _02173018
	cmp r0, #1
	beq _02173024
	b _02173030
_02173018:
	mov r0, #0xa
	strh r0, [r4, #0x12]
	b _02173038
_02173024:
	mov r0, #0x400
	strh r0, [r4, #0x12]
	b _02173038
_02173030:
	mov r0, #0x800
	strh r0, [r4, #0x12]
_02173038:
	ldr r1, [r5, #0xf4]
	ldr r0, _021730A0 // =ovl02_216B6CC
	cmp r1, r0
	movne r0, #0x8e
	bne _02173068
	mov r0, #0x50
	str r0, [r6, #0x2c]
	bl ovl02_2169F80
	mov r0, r0, lsl #3
	ldr r1, [r6, #0x2c]
	rsb r0, r0, #0
	add r0, r1, r0
_02173068:
	str r0, [r6, #0x2c]
	mov r0, #2
	str r0, [r6, #0x28]
	bl ovl02_2169F80
	ldr r1, [r6, #0x28]
	add r0, r1, r0
	str r0, [r6, #0x28]
	bl ovl02_2169F80
	cmp r0, #0
	moveq r0, #1
	streq r0, [r6, #0x28]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02173098: .word BossFStage__Singleton
_0217309C: .word ovl02_21730A4
_021730A0: .word ovl02_216B6CC
	arm_func_end ovl02_2172FD0

	arm_func_start ovl02_21730A4
ovl02_21730A4: // _021730A4
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	ldr r1, _02173394 // =BossFStage__Singleton
	mov r5, r0
	ldr r0, [r1, #0]
	ldr r4, [r5, #0x124]
	bl GetTaskWork_
	ldr r1, [r0, #0x384]
	ldr r6, [r0, #0x36c]
	tst r1, #0x10
	beq _021730E8
	mov r0, r5
	bl ovl02_21733B8
	mov r0, #0x168
	add sp, sp, #4
	str r0, [r5, #0x2c]
	ldmia sp!, {r3, r4, r5, r6, pc}
_021730E8:
	ldr r0, [r4, #4]
	mov r1, #0x800
	bl ObjSpdDownSet
	ldr r1, _02173398 // =gPlayer
	str r0, [r4, #4]
	ldr r0, [r1, #0]
	ldr r0, [r0, #0x5d8]
	tst r0, #0x200000
	bne _0217312C
	ldr r1, [r6, #0xf4]
	ldr r0, _0217339C // =ovl02_216B6CC
	cmp r1, r0
	ldrne r0, _021733A0 // =ovl02_216B808
	cmpne r1, r0
	ldreq r0, [r5, #0x2c]
	subeq r0, r0, #1
	streq r0, [r5, #0x2c]
_0217312C:
	ldr r0, [r5, #0x2c]
	cmp r0, #0x28
	bgt _02173150
	ldrh r0, [r4, #8]
	mov r1, #0xf900
	mov r2, #0x80
	bl ObjRoopMove16
	strh r0, [r4, #8]
	b _02173170
_02173150:
	ldr r0, [r5, #4]
	cmp r0, #0
	bne _02173170
	ldrh r0, [r4, #8]
	mov r1, #0
	mov r2, #0x20
	bl ObjRoopMove16
	strh r0, [r4, #8]
_02173170:
	ldrsh r1, [r4, #8]
	mvn r0, #0x3c
	add r3, r5, #0x258
	mov r2, r1, lsl #4
	sub r1, r0, r2, asr #12
	add r0, r0, #0x10
	strh r1, [r3, #2]
	sub r0, r0, r2, asr #12
	strh r0, [r3, #8]
	ldr r0, [r5, #0x2c]
	cmp r0, #0
	bgt _0217330C
	mov r1, #0x5000
	str r1, [r4, #4]
	mov r1, #0x8000
	mov r0, r5
	str r1, [r5, #4]
	bl ovl02_21746D4
	ldr r1, _021733A4 // =0x0000012E
	mov r0, r5
	bl ovl02_217873C
	mov r0, r5
	bl ovl02_217019C
	cmp r0, #0
	ldr r0, [r5, #0x44]
	addne r1, r0, #0x52000
	subeq r1, r0, #0x52000
	add r0, r4, #0x30
	str r0, [sp]
	ldr r0, [r5, #0x48]
	ldr r3, [r5, #0x4c]
	sub r0, r0, #0x2a000
	rsb r2, r0, #0
	mov r0, #0
	bl BossFX__CreateTitanFlashG
	ldr r1, [r5, #0x28]
	mov r0, #0x8e
	sub r1, r1, #1
	str r1, [r5, #0x28]
	str r0, [r5, #0x2c]
	bl ovl02_2169F80
	mov r0, r0, lsl #3
	ldr r1, [r5, #0x2c]
	rsb r0, r0, #0
	add r0, r1, r0
	str r0, [r5, #0x2c]
	bl ovl02_2169F80
	cmp r0, #2
	blo _02173284
	ldr r3, _021733A8 // =_mt_math_rand
	ldr r0, _021733AC // =0x00196225
	ldr r2, [r3, #0]
	ldr r1, _021733B0 // =0x3C6EF35F
	mla ip, r2, r0, r1
	mov r2, ip, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	str ip, [r3]
	tst r2, #1
	beq _02173284
	mla r1, ip, r0, r1
	mov r0, r1, lsr #0x10
	str r1, [r3]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr r1, [r5, #0x2c]
	and r0, r0, #0x1f
	add r0, r1, r0
	str r0, [r5, #0x2c]
_02173284:
	ldr r0, [r5, #0x28]
	cmp r0, #0
	bne _0217330C
	ldr r1, [r5, #0x2c]
	mov r0, #2
	mov r1, r1, lsl #1
	str r1, [r5, #0x2c]
	str r0, [r5, #0x28]
	bl ovl02_2169F80
	cmp r0, #2
	blo _0217330C
	ldr r3, _021733A8 // =_mt_math_rand
	ldr r1, _021733AC // =0x00196225
	ldr r0, [r3, #0]
	ldr r2, _021733B0 // =0x3C6EF35F
	mla ip, r0, r1, r2
	mov r0, ip, lsr #0x10
	str ip, [r3]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr ip, [r5, #0x28]
	and r0, r0, #1
	add r0, ip, r0
	str r0, [r5, #0x28]
	ldr r0, [r3, #0]
	mla r1, r0, r1, r2
	mov r0, r1, lsr #0x10
	str r1, [r3]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr r1, [r5, #0x28]
	and r0, r0, #1
	add r0, r1, r0
	str r0, [r5, #0x28]
_0217330C:
	ldrsh r0, [r4, #0x14]
	cmp r0, #0
	beq _02173370
	sub r0, r0, #1
	strh r0, [r4, #0x14]
	ldrsh r0, [r4, #0x14]
	mov r1, #0
	tst r0, #2
	ldr r0, [r5, #0x12c]
	beq _02173344
	ldrh r2, [r4, #0x2c]
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlEmi
	b _02173350
_02173344:
	ldr r2, _021733B4 // =0x00007FFF
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlEmi
_02173350:
	ldrsh r0, [r4, #0x14]
	cmp r0, #0
	bne _02173370
	ldr r0, [r5, #0x12c]
	ldrh r2, [r4, #0x2c]
	ldr r0, [r0, #0x94]
	mov r1, #0
	bl NNS_G3dMdlSetMdlEmi
_02173370:
	ldrsh r0, [r4, #0x16]
	mov r1, #1
	cmp r0, #0
	subne r0, r0, #1
	strneh r0, [r4, #0x16]
	mov r0, r5
	bl ovl02_2169E34
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02173394: .word BossFStage__Singleton
_02173398: .word gPlayer
_0217339C: .word ovl02_216B6CC
_021733A0: .word ovl02_216B808
_021733A4: .word 0x0000012E
_021733A8: .word _mt_math_rand
_021733AC: .word 0x00196225
_021733B0: .word 0x3C6EF35F
_021733B4: .word 0x00007FFF
	arm_func_end ovl02_21730A4

	arm_func_start ovl02_21733B8
ovl02_21733B8: // _021733B8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r2, [r4, #0x124]
	ldr r0, _02173444 // =ovl02_217344C
	mov r1, #0
	str r0, [r4, #0xf4]
	str r1, [r4, #0x2c]
	strh r1, [r2, #0x14]
	strh r1, [r2, #0x16]
	strh r1, [r2, #8]
	mov r0, #0x14000
	str r0, [r2, #4]
	ldr r0, [r4, #0x12c]
	ldrh r2, [r2, #0x2c]
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlEmi
	ldr r1, [r4, #0x270]
	mov r2, #0
	bic r1, r1, #4
	str r1, [r4, #0x270]
	add r0, r4, #0x218
	str r2, [sp]
	sub r1, r2, #0xc
	sub r2, r2, #0x54
	mov r3, #0xc
	bl ObjRect__SetBox2D
	ldr r1, [r4, #0x230]
	ldr r0, _02173448 // =ovl02_21727C4
	orr r1, r1, #0x84
	bic r1, r1, #0x800
	str r1, [r4, #0x230]
	str r0, [r4, #0x23c]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02173444: .word ovl02_217344C
_02173448: .word ovl02_21727C4
	arm_func_end ovl02_21733B8

	arm_func_start ovl02_217344C
ovl02_217344C: // _0217344C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x11c]
	ldr r4, [r5, #0x124]
	ldr r0, [r0, #0x384]
	tst r0, #0x10
	movne r0, #0x168
	strne r0, [r5, #0x2c]
	ldr r0, [r5, #0x2c]
	cmp r0, #0
	bne _02173480
	mov r0, r5
	bl ovl02_21770F0
_02173480:
	mov r0, r5
	mov r1, #1
	bl ovl02_2169E34
	ldr r0, [r5, #0x2c]
	cmp r0, #0x12c
	ble _021734C4
	tst r0, #2
	ldr r0, [r5, #0x12c]
	mov r1, #1
	beq _021734B8
	ldrh r2, [r4, #0x2c]
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlEmi
	b _021734C4
_021734B8:
	ldr r0, [r0, #0x94]
	rsb r2, r1, #0x8000
	bl NNS_G3dMdlSetMdlEmi
_021734C4:
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #0x168
	ldmleia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x48]
	ldr r1, [r5, #0x44]
	ldr r3, [r5, #0x4c]
	rsb r2, r0, #0x20000
	mov r0, #0
	bl BossFX__CreateBomb
	cmp r0, #0
	beq _02173518
	mov r1, #0x2800
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	str r1, [r0, #0x40]
	sub r1, r1, #0x4c00
	str r1, [r0, #0x9c]
	mov r1, #0xd0
	str r1, [r0, #0xa8]
_02173518:
	ldr r1, [r5, #0x2c]
	ldr r0, _02173564 // =0x00000172
	cmp r1, r0
	bge _02173544
	mov r0, #0
	bl CreateScreenEffect
	mov r0, #4
	bl ShakeScreen
	mov r0, r5
	mov r1, #0x43
	bl ovl02_217873C
_02173544:
	ldr r0, [r5, #0x12c]
	ldrh r2, [r4, #0x2c]
	ldr r0, [r0, #0x94]
	mov r1, #1
	bl NNS_G3dMdlSetMdlEmi
	mov r0, r5
	bl ovl02_2172C1C
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02173564: .word 0x00000172
	arm_func_end ovl02_217344C

	arm_func_start ovl02_2173568
ovl02_2173568: // _02173568
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r1
	ldrh r1, [r5, #0]
	mov r6, r0
	ldr r4, [r6, #0x124]
	cmp r1, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, _021736C4 // =ovl02_21736C8
	mov r1, #1
	str r0, [r6, #0xf4]
	str r5, [r6, #0x35c]
	ldr r0, [r6, #0x12c]
	ldrh r2, [r4, #0x2c]
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlEmi
	mov r0, r5
	bl Player__InitState
	mov r0, r5
	bl Player__Action_Launch
	bl ovl02_216A0D4
	mov r0, r5
	mov r1, #0x12
	bl Player__ChangeAction
	ldr r1, [r5, #0x20]
	mov r0, r5
	orr r1, r1, #4
	str r1, [r5, #0x20]
	bl BossHelpers__Player__LockControl
	ldr r0, [r5, #0x5dc]
	mov r2, #0
	orr r0, r0, #0x20000000
	str r0, [r5, #0x5dc]
	ldr r1, [r5, #0x1c]
	add r0, r5, #0x550
	orr r1, r1, #0x110
	bic r1, r1, #0x80
	bic r1, r1, #1
	str r1, [r5, #0x1c]
	ldr r3, [r5, #0x18]
	mov r1, #2
	orr r3, r3, #2
	str r3, [r5, #0x18]
	str r2, [r5, #0x98]
	str r2, [r5, #0x9c]
	str r2, [r5, #0xc8]
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov ip, #0
	str ip, [r5, #0x574]
	ldr r0, [r5, #0x568]
	bic r0, r0, #8
	str r0, [r5, #0x568]
	ldrb r0, [r5, #0x5d0]
	cmp r0, #1
	beq _02173670
	sub r1, ip, #1
	add r0, r5, #0x254
	str ip, [sp]
	mov r2, r1
	mov r3, r1
	add r0, r0, #0x400
	str ip, [sp, #4]
	bl PlaySfxEx
	b _02173690
_02173670:
	mov lr, #0x13
	sub r1, lr, #0x14
	add r0, r5, #0x254
	mov r2, r1
	mov r3, r1
	add r0, r0, #0x400
	stmia sp, {ip, lr}
	bl PlaySfxEx
_02173690:
	add r0, r5, #0x44
	add r3, r4, #0x20
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r6, #0x230]
	mov r0, #0
	bic r1, r1, #4
	str r1, [r6, #0x230]
	str r0, [r6, #0x2c]
	str r0, [r4, #0x18]
	strh r0, [r4, #0x1c]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021736C4: .word ovl02_21736C8
	arm_func_end ovl02_2173568

	arm_func_start ovl02_21736C8
ovl02_21736C8: // _021736C8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x20
	ldr r1, _021739E8 // =BossFStage__Singleton
	mov r7, r0
	ldr r0, [r1, #0]
	ldr r4, [r7, #0x124]
	ldr r5, [r7, #0x35c]
	bl GetTaskWork_
	ldr r1, [r7, #0x2c]
	ldr r6, [r0, #0x36c]
	cmp r1, #0x100
	addlt r0, r1, #1
	strlt r0, [r7, #0x2c]
	mov r0, r7
	mov r1, #1
	bl ovl02_2169E34
	ldr r0, [r5, #0x5d8]
	tst r0, #0x200000
	beq _02173778
	ldr r8, [r7, #0x44]
	mov r0, r7
	bl ovl02_217019C
	cmp r0, #0
	subne r8, r8, #0x5000
	mov r0, #0x40
	addeq r8, r8, #0x5000
	str r0, [sp]
	ldr r0, [r5, #0x44]
	mov r1, r8
	mov r2, #1
	mov r3, #0
	bl ObjShiftSet
	str r0, [r5, #0x44]
	mov r0, #0
	str r0, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	ldr r0, [r5, #0x48]
	ldr r1, [r7, #0x48]
	ldr r2, [r4, #0x24]
	mov r3, #1
	bl ObjDiffSet
	str r0, [r5, #0x48]
	b _021737B0
_02173778:
	ldr r0, [r4, #0x54]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, r7
	bl ovl02_21733B8
	mov r0, #0
	bl ovl02_2169FF0
	mov r0, #0x168
	str r0, [r7, #0x2c]
	ldr r0, [r7, #0x230]
	add sp, sp, #0x20
	bic r0, r0, #4
	str r0, [r7, #0x230]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_021737B0:
	ldr r2, [r7, #0x2c]
	cmp r2, #0x20
	addlt sp, sp, #0x20
	ldmltia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, [r6, #0xf4]
	ldr r0, _021739EC // =ovl02_216B6CC
	cmp r1, r0
	movne r0, #0x20
	addne sp, sp, #0x20
	strne r0, [r7, #0x2c]
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r2, #0x21
	bne _021737F0
	mov r0, #0
	mov r1, #0x128
	bl ovl02_217873C
_021737F0:
	ldr r0, [r4, #4]
	mov r1, #0x600
	bl ObjSpdDownSet
	str r0, [r4, #4]
	add r0, sp, #0x14
	bl ovl02_2169EBC
	ldr r3, [sp, #0x14]
	ldr r0, [r7, #0x44]
	ldr r2, [sp, #0x1c]
	ldr r1, [r7, #0x4c]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r1, r0
	ldrh r0, [r4, #0xa]
	mov r2, #0xc0
	bl ObjRoopMove16
	strh r0, [r4, #0xa]
	ldrh r1, [r4, #0xa]
	ldr r0, [r7, #0x12c]
	ldr r3, _021739F0 // =FX_SinCosTable_
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	add r0, r0, #0x24
	bl MTX_RotY33_
	ldr r0, [r7, #0x2c]
	cmp r0, #0x64
	bne _02173894
	mov r0, r7
	bl ovl02_2176A3C
	str r0, [r4, #0x5c]
	mov r0, r7
	bl ovl02_2176E90
	mov r0, #0
	mov r1, #0x128
	bl ovl02_217873C
_02173894:
	ldr r0, [r7, #0x2c]
	cmp r0, #0x64
	addlt sp, sp, #0x20
	ldmltia sp!, {r4, r5, r6, r7, r8, pc}
	add r0, sp, #8
	bl ovl02_2169EBC
	ldr r3, [r7, #0x4c]
	ldr r0, [sp, #0x10]
	ldr r2, [r7, #0x48]
	ldr r1, [sp, #0xc]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r6, r0
	mov r0, r7
	bl ovl02_217019C
	cmp r0, #0
	ldrh r0, [r4, #0xa]
	beq _021738F8
	add r0, r0, #0x3c0
	add r0, r0, #0x8000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ovl02_2169FF0
	b _0217390C
_021738F8:
	add r0, r0, #0x3c40
	add r0, r0, #0x4000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ovl02_2169FF0
_0217390C:
	ldrh r0, [r4, #8]
	mov r1, r6
	mov r2, #0x80
	bl ObjRoopMove16
	strh r0, [r4, #8]
	ldrh r0, [r4, #0x1c]
	cmp r0, #0
	ldreqh r0, [r4, #8]
	cmpeq r6, r0
	moveq r0, #1
	streqh r0, [r4, #0x1c]
	ldrh r0, [r4, #0x1c]
	cmp r0, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r4, #0x18]
	add r0, r0, #1
	str r0, [r4, #0x18]
	ldr r0, [r5, #0x5d8]
	tst r0, #0x200000
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r4, #0x18]
	cmp r0, #0x14
	addls sp, sp, #0x20
	ldmlsia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r0, #0x15
	bne _021739B4
	ldr r1, _021739F4 // =0x0000012F
	mov r0, #0
	bl NNS_SndPlayerCountPlayingSeqBySeqArcIdx
	cmp r0, #0
	bne _021739B4
	mov r1, #0
	ldr r0, _021739F4 // =0x0000012F
	str r1, [sp]
	sub r1, r0, #0x130
	str r0, [sp, #4]
	ldr r0, [r4, #0x54]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_021739B4:
	ldr r1, _021739F8 // =playerGameStatus
	ldr r0, _021739FC // =0x00000C03
	ldrh r1, [r1, #0x3a]
	tst r1, r0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r4, #0x54]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, r7
	bl ovl02_2173A00
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021739E8: .word BossFStage__Singleton
_021739EC: .word ovl02_216B6CC
_021739F0: .word FX_SinCosTable_
_021739F4: .word 0x0000012F
_021739F8: .word playerGameStatus
_021739FC: .word 0x00000C03
	arm_func_end ovl02_21736C8

	arm_func_start ovl02_2173A00
ovl02_2173A00: // _02173A00
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x50
	ldr r1, _02173C8C // =BossFStage__Singleton
	mov r6, r0
	ldr r0, [r1, #0]
	ldr r4, [r6, #0x124]
	ldr r5, [r6, #0x35c]
	bl GetTaskWork_
	mov r7, r0
	ldr r0, [r7, #0x384]
	orr r0, r0, #0x200
	str r0, [r7, #0x384]
	ldr r0, [r4, #0x5c]
	cmp r0, #0
	beq _02173AD4
	ldr r0, [r0, #0x24]
	tst r0, #8
	mov r0, #0
	beq _02173AA4
	ldr r8, _02173C90 // =0x00000136
	sub r1, r0, #1
	stmia sp, {r0, r8}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r1, [r6, #0x24]
	mov r0, r5
	orr r1, r1, #8
	str r1, [r6, #0x24]
	bl ovl02_2175ED4
	mov r0, r5
	bl ovl02_21760C4
	bl ovl02_216A074
	add r1, r7, #0x300
	ldrsh r1, [r1, #0x7c]
	cmp r1, r0
	bgt _02173AD4
	ldr r0, [r7, #0x384]
	orr r0, r0, #0x40
	str r0, [r7, #0x384]
	b _02173AD4
_02173AA4:
	mov r8, #1
	sub r1, r8, #2
	stmia sp, {r0, r8}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r6, #0x24]
	bic r0, r0, #8
	str r0, [r6, #0x24]
	ldr r0, [r7, #0x384]
	orr r0, r0, #8
	str r0, [r7, #0x384]
_02173AD4:
	ldrh r1, [r4, #0xa]
	mov r0, #0x68000
	ldr r7, _02173C94 // =FX_SinCosTable_
	add r1, r1, #0x8000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r3, r1, lsl #1
	mov r1, r3, lsl #1
	ldrsh r9, [r7, r1]
	rsb r0, r0, #0
	mvn r1, #0
	umull r8, lr, r9, r0
	mla lr, r9, r1, lr
	add r3, r3, #1
	mov r3, r3, lsl #1
	mov r9, r9, asr #0x1f
	adds r8, r8, #0x800
	mla lr, r9, r0, lr
	ldrsh r3, [r7, r3]
	mov r2, #0x800
	adc lr, lr, #0
	umull r9, ip, r3, r0
	mov r8, r8, lsr #0xc
	mla ip, r3, r1, ip
	adds r9, r9, #0x800
	orr r8, r8, lr, lsl #20
	mov lr, r9, lsr #0xc
	sub r9, r2, #0x38800
	ldr r10, [r6, #0x44]
	mov r2, r3, asr #0x1f
	mla ip, r2, r0, ip
	add r8, r10, r8
	str r8, [r5, #0x44]
	ldr r2, [r6, #0x48]
	adc r0, ip, #0
	sub r2, r2, #0x32000
	str r2, [r5, #0x48]
	orr lr, lr, r0, lsl #20
	ldr r2, [r6, #0x4c]
	add r0, sp, #8
	add r2, r2, lr
	str r2, [r5, #0x4c]
	ldrh r3, [r4, #8]
	ldr r2, [r5, #0x48]
	mov r3, r3, asr #4
	mov r3, r3, lsl #2
	ldrsh r8, [r7, r3]
	umull lr, ip, r8, r9
	mla ip, r8, r1, ip
	mov r3, r8, asr #0x1f
	mla ip, r3, r9, ip
	adds r3, lr, #0x800
	adc r1, ip, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r1, lsl #20
	add r1, r2, r3
	str r1, [r5, #0x48]
	ldrh r1, [r4, #0xa]
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r7, r1]
	ldrsh r2, [r7, r2]
	bl MTX_RotY33_
	ldrh r1, [r4, #8]
	mov r3, r7
	add r0, sp, #0x2c
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	bl MTX_RotX33_
	add r0, sp, #0x2c
	add r1, sp, #8
	mov r2, r0
	bl MTX_Concat33
	add r1, sp, #0x2c
	str r1, [sp]
	ldr r2, [r5, #0x48]
	ldr r1, [r5, #0x44]
	ldr r3, [r5, #0x4c]
	mov r0, #0
	rsb r2, r2, #0
	bl BossFX__CreateTitanFlashC
	mov r0, #0x40000
	rsb r0, r0, #0
	bl ovl02_216A014
	mov r0, #0
	bl ovl02_216A034
	mov r1, #0x5000
	ldr r0, _02173C98 // =ovl02_2173C9C
	str r1, [r4, #4]
	str r0, [r6, #0xf4]
	mov r0, #0
	str r0, [r6, #0x2c]
	add sp, sp, #0x50
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02173C8C: .word BossFStage__Singleton
_02173C90: .word 0x00000136
_02173C94: .word FX_SinCosTable_
_02173C98: .word ovl02_2173C9C
	arm_func_end ovl02_2173A00

	arm_func_start ovl02_2173C9C
ovl02_2173C9C: // _02173C9C
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x84
	mov r5, r0
	ldr r4, [r5, #0x35c]
	mov r1, #1
	ldr r6, [r5, #0x124]
	bl ovl02_2169E34
	ldr r0, [r4, #0x5d8]
	tst r0, #0x200000
	bne _02173CF0
	mov r0, r5
	bl ovl02_21733B8
	mov r0, #0
	bl ovl02_2169FF0
	ldr r0, _02173D8C // =0x00000172
	add sp, sp, #0x84
	str r0, [r5, #0x2c]
	ldr r0, [r5, #0x230]
	bic r0, r0, #4
	str r0, [r5, #0x230]
	ldmia sp!, {r3, r4, r5, r6, pc}
_02173CF0:
	ldr r0, [r6, #4]
	mov r1, #0x800
	bl ObjSpdDownSet
	ldr r1, _02173D90 // =_02179024
	str r0, [r6, #4]
	add r3, sp, #0x60
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, _02173D94 // =_02179048
	add ip, sp, #0x54
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	add r0, r4, #0x44
	add r3, sp, #0x6c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, sp, #0x78
	bl ovl02_2169EBC
	add r0, sp, #0x6c
	add r1, sp, #0x78
	add r2, sp, #0x60
	add r3, sp, #0x24
	bl Unknown2066510__Func_2066A4C
	add r0, sp, #0x24
	add r1, sp, #0
	bl MI_Copy36B
	add r0, sp, #0x54
	add r1, sp, #0
	add r2, r4, #0xb0
	bl MTX_MultVec33
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #0x1e
	ldrgt r0, [r4, #0x18]
	bicgt r0, r0, #2
	strgt r0, [r4, #0x18]
	add sp, sp, #0x84
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02173D8C: .word 0x00000172
_02173D90: .word _02179024
_02173D94: .word _02179048
	arm_func_end ovl02_2173C9C

	arm_func_start ovl02_2173D98
ovl02_2173D98: // _02173D98
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	mov r0, #0x1500
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r1, #6
	bl StageTask__SetType
	ldr r0, [r4, #0x120]
	mov r1, #0
	bl SetTaskPauseLevel
	mov r0, r4
	mov r1, #0x10
	bl StageTask__AllocateWorker
	mov r6, r0
	mov r0, r5
	bl ovl02_217019C
	cmp r0, #0
	beq _02173E10
	mov r1, #0
	ldr r0, _02173ED8 // =gameArchiveStage
	str r1, [sp]
	ldr ip, [r0]
	ldr r2, _02173EDC // =aBossfEtcNsbmd_0
	mov r0, r4
	mov r3, #5
	str ip, [sp, #4]
	bl ObjAction3dNNModelLoad
	b _02173E58
_02173E10:
	ldr r0, _02173ED8 // =gameArchiveStage
	ldr r1, _02173EDC // =aBossfEtcNsbmd_0
	ldr r2, [r0, #0]
	add r0, r6, #8
	bl ObjActionLoadArchiveFile
	add r1, r6, #8
	ldr r2, _02173EDC // =aBossfEtcNsbmd_0
	mov r0, r4
	str r1, [sp]
	mov r1, #0
	mov r3, #5
	str r1, [sp, #4]
	bl ObjAction3dNNModelLoad
	add r0, r6, #8
	bl ObjDataRelease
	ldr r0, [r4, #0x120]
	ldr r1, _02173EE0 // =ovl02_2173EE8
	bl SetTaskDestructorEvent
_02173E58:
	ldr r0, [r4, #0x12c]
	mov r1, #4
	strb r1, [r0, #0xa]
	ldr r0, [r4, #0x12c]
	mov r2, #0
	strb r2, [r0, #0xb]
	ldr r1, [r4, #0x18]
	mov r0, r4
	orr r1, r1, #0x12
	str r1, [r4, #0x18]
	ldr r3, [r4, #0x20]
	mov r1, r5
	orr r3, r3, #0x180
	str r3, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	orr r3, r3, #0x2100
	str r3, [r4, #0x1c]
	bl StageTask__SetParent
	add r0, r5, #0x44
	add r3, r4, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r2, [r4, #0x12c]
	ldr r1, _02173EE4 // =0x000034CC
	mov r0, r4
	str r1, [r2, #0x18]
	str r1, [r2, #0x1c]
	str r1, [r2, #0x20]
	bl ovl02_2173F1C
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02173ED8: .word gameArchiveStage
_02173EDC: .word aBossfEtcNsbmd_0
_02173EE0: .word ovl02_2173EE8
_02173EE4: .word 0x000034CC
	arm_func_end ovl02_2173D98

	arm_func_start ovl02_2173EE8
ovl02_2173EE8: // _02173EE8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x12c]
	ldr r0, [r0, #0x15c]
	bl ObjDataRelease
	ldr r1, [r4, #0x12c]
	mov r2, #0
	mov r0, r5
	str r2, [r1, #0x144]
	bl StageTask_Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_2173EE8

	arm_func_start ovl02_2173F1C
ovl02_2173F1C: // _02173F1C
	ldr r3, [r0, #0x124]
	ldr r2, _02173F4C // =ovl02_2173F50
	mov r1, #0x1000
	str r2, [r0, #0xf4]
	str r1, [r3]
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	str r1, [r0, #0x40]
	mov r1, #0
	str r1, [r0, #0x2c]
	strh r1, [r3, #4]
	bx lr
	.align 2, 0
_02173F4C: .word ovl02_2173F50
	arm_func_end ovl02_2173F1C

	arm_func_start ovl02_2173F50
ovl02_2173F50: // _02173F50
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r6, r0
	ldr r0, [r6, #0x12c]
	ldr r4, [r6, #0x124]
	ldr r0, [r0, #0x94]
	mov r1, #0x1e
	ldr r5, [r6, #0x11c]
	bl NNS_G3dMdlSetMdlPolygonIDAll
	ldr r0, [r6, #0x12c]
	ldr r1, [r4, #0]
	ldr r0, [r0, #0x94]
	mov r1, r1, asr #0xc
	bl NNS_G3dMdlSetMdlAlphaAll
	mov r0, r6
	mov r1, #1
	bl ovl02_2169E34
	ldr r1, [r5, #0xf4]
	ldr r0, _021740E8 // =ovl02_2172CA0
	cmp r1, r0
	ldrne r0, _021740EC // =ovl02_2172D10
	cmpne r1, r0
	bne _02173FBC
	ldr r0, [r6, #0x20]
	orr r0, r0, #0x20
	str r0, [r6, #0x20]
	b _021740C4
_02173FBC:
	mov r0, #0x10
	str r0, [sp]
	ldr r0, [r4, #0]
	mov r1, #0x10000
	mov r2, #3
	mov r3, #0x800
	bl ObjShiftSet
	str r0, [r4]
	ldr r0, [r6, #0x2c]
	ldr r1, _021740F0 // =FX_SinCosTable_
	add r2, r0, #1
	mov r0, r2, lsl #0x18
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r1, [r1, r0]
	str r2, [r6, #0x2c]
	mov r0, #0x800
	mov r2, r1, asr #1
	mov r1, r2, asr #0x1f
	mov r1, r1, lsl #0xb
	adds r3, r0, r2, lsl #11
	orr r1, r1, r2, lsr #21
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	rsb r0, r1, #0x1000
	str r0, [r6, #0x3c]
	ldr r0, [r6, #0x2c]
	tst r0, #4
	beq _02174048
	mov r0, #0x1000
	b _0217404C
_02174048:
	mov r0, #0xf80
_0217404C:
	str r0, [r6, #0x38]
	ldr r0, [r6, #0x2c]
	tst r0, #2
	movne r0, #0xf00
	strne r0, [r6, #0x38]
	ldr r0, [r6, #0x38]
	str r0, [r6, #0x40]
	ldrsh r0, [r4, #4]
	cmp r0, #0
	beq _021740C4
	sub r0, r0, #1
	strh r0, [r4, #4]
	ldrsh r0, [r4, #4]
	tst r0, #2
	ldr r0, [r6, #0x12c]
	beq _0217409C
	ldr r1, _021740F4 // =0x0000421F
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlDiffAll
	b _021740A8
_0217409C:
	ldr r1, _021740F8 // =0x00007FFF
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlDiffAll
_021740A8:
	ldrsh r0, [r4, #4]
	cmp r0, #0
	bne _021740C4
	ldr r0, [r6, #0x12c]
	ldr r1, _021740F8 // =0x00007FFF
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlDiffAll
_021740C4:
	ldr r1, [r5, #0xf4]
	ldr r0, _021740FC // =ovl02_2172F08
	cmp r1, r0
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, r5, r6, pc}
	mov r0, r6
	bl ovl02_2174100
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_021740E8: .word ovl02_2172CA0
_021740EC: .word ovl02_2172D10
_021740F0: .word FX_SinCosTable_
_021740F4: .word 0x0000421F
_021740F8: .word 0x00007FFF
_021740FC: .word ovl02_2172F08
	arm_func_end ovl02_2173F50

	arm_func_start ovl02_2174100
ovl02_2174100: // _02174100
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0x124]
	ldr r1, _02174154 // =ovl02_217415C
	mov r0, #0x10000
	str r1, [r4, #0xf4]
	str r0, [r2]
	mov r0, #0x1000
	str r0, [r4, #0x38]
	str r0, [r4, #0x40]
	ldr r0, [r4, #0x12c]
	ldr r1, _02174158 // =0x00007FFF
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlDiffAll
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	ldr r3, [r4, #0x4c]
	rsb r2, r0, #0x40000
	mov r0, #0
	bl BossFX__CreateTitanBreak
	ldmia sp!, {r4, pc}
	.align 2, 0
_02174154: .word ovl02_217415C
_02174158: .word 0x00007FFF
	arm_func_end ovl02_2174100

	arm_func_start ovl02_217415C
ovl02_217415C: // _0217415C
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r0, [r5, #0x12c]
	ldr r6, [r5, #0x124]
	ldr r0, [r0, #0x94]
	mov r1, #0x1e
	ldr r4, [r5, #0x11c]
	bl NNS_G3dMdlSetMdlPolygonIDAll
	ldr r0, [r5, #0x12c]
	ldr r1, [r6, #0]
	ldr r0, [r0, #0x94]
	mov r1, r1, asr #0xc
	bl NNS_G3dMdlSetMdlAlphaAll
	mov r0, r5
	mov r1, #1
	bl ovl02_2169E34
	ldr r0, [r6, #0]
	mov r1, #0xc00
	bl ObjSpdDownSet
	str r0, [r6]
	ldr r0, [r5, #0x38]
	mov r1, #0x600
	mov r2, #0xc000
	bl ObjSpdUpSet
	str r0, [r5, #0x38]
	ldr r0, [r6, #0]
	cmp r0, #0x1000
	ldrlt r0, [r5, #0x20]
	orrlt r0, r0, #0x20
	strlt r0, [r5, #0x20]
	ldr r1, [r4, #0xf4]
	ldr r0, _021741F0 // =ovl02_2172CA0
	cmp r1, r0
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r5
	bl ovl02_2173F1C
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021741F0: .word ovl02_2172CA0
	arm_func_end ovl02_217415C

	arm_func_start ovl02_21741F4
ovl02_21741F4: // _021741F4
	ldr r2, [r0, #0x124]
	mov r3, #0x40
	mov r1, #0x4000
	strh r3, [r2, #4]
	str r1, [r0, #4]
	ldr ip, _02174214 // =ovl02_2177F28
	str r1, [r0, #8]
	bx ip
	.align 2, 0
_02174214: .word ovl02_2177F28
	arm_func_end ovl02_21741F4

	arm_func_start ovl02_2174218
ovl02_2174218: // _02174218
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r0, #0x1500
	mov r1, #2
	bl CreateStageTaskEx_
	mov r4, r0
	mov r1, #6
	bl StageTask__SetType
	ldr r0, [r4, #0x120]
	mov r1, #0
	bl SetTaskPauseLevel
	mov r0, r4
	mov r1, #0x50
	bl StageTask__AllocateWorker
	mov r1, #0
	str r1, [sp]
	ldr r2, _021742D8 // =gameArchiveStage
	mov r0, r4
	ldr r3, [r2, #0]
	ldr r2, _021742DC // =aBsef8BariaNsbm_0
	str r3, [sp, #4]
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x18]
	ldr r0, _021742E0 // =ovl02_21742E8
	orr r1, r1, #0x12
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x20]
	ldr r2, _021742E4 // =0x000034CC
	orr r1, r1, #0x180
	str r1, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	mov r1, #0xb00
	orr r3, r3, #0x2100
	str r3, [r4, #0x1c]
	str r0, [r4, #0xfc]
	ldr r3, [r4, #0x12c]
	mov r0, r4
	str r2, [r3, #0x18]
	str r2, [r3, #0x1c]
	str r2, [r3, #0x20]
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	bl ovl02_2174458
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021742D8: .word gameArchiveStage
_021742DC: .word aBsef8BariaNsbm_0
_021742E0: .word ovl02_21742E8
_021742E4: .word 0x000034CC
	arm_func_end ovl02_2174218

	arm_func_start ovl02_21742E8
ovl02_21742E8: // _021742E8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	bl GetCurrentTaskWork_
	mov r8, r0
	add r0, r8, #0x44
	ldr r9, [r8, #0x124]
	add r4, sp, #8
	ldmia r0, {r0, r1, r2}
	ldr r3, _0217444C // =BossFStage__Singleton
	stmia r4, {r0, r1, r2}
	ldr r0, [r3, #0]
	bl GetTaskWork_
	ldr r1, [r8, #0x20]
	tst r1, #0x20
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bic r1, r1, #0x1000
	str r1, [r8, #0x20]
	ldr r1, [r0, #0x374]
	ldr r0, [r0, #0x370]
	str r1, [sp]
	str r0, [sp, #4]
	mov r11, #0
_02174344:
	add r1, sp, #0
	ldr r2, [r1, r11, lsl #2]
	ldr r0, _02174450 // =ovl02_2172E68
	ldr r1, [r2, #0xf4]
	cmp r1, r0
	bne _02174420
	ldr r7, _02174454 // =FX_SinCosTable_
	mov r10, #0
	add r6, r8, #0x44
	add r5, r2, #0x44
	mov r4, #0xc
_02174370:
	add r1, r9, r10, lsl #1
	ldrh r0, [r1, #0x30]
	cmp r0, #0
	beq _0217440C
	ldrh r0, [r1, #0x34]
	ldr r3, [r8, #0x12c]
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	mov r1, r0, lsl #1
	add r0, r7, r0, lsl #1
	ldrsh r1, [r7, r1]
	ldrsh r2, [r0, #2]
	add r0, r3, #0x24
	bl MTX_RotY33_
	mla r0, r10, r4, r9
	add r0, r0, #0x38
	ldmia r0, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	add ip, r9, r10, lsl #2
	add r3, r9, r10, lsl #1
	ldmia r5, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	ldr r0, [ip, #8]
	ldr r1, [r8, #0x48]
	sub r0, r1, r0
	str r0, [r8, #0x48]
	ldrh r1, [r3, #0x2c]
	ldr r0, [r8, #0x12c]
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlAlphaAll
	ldr r1, [r9, r10, lsl #2]
	mov r0, r8
	str r1, [r8, #0x38]
	str r1, [r8, #0x3c]
	str r1, [r8, #0x40]
	bl StageTask__Draw
	ldr r0, [r8, #0x20]
	orr r0, r0, #0x1000
	str r0, [r8, #0x20]
_0217440C:
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	mov r10, r0, lsr #0x10
	cmp r10, #2
	blo _02174370
_02174420:
	add r0, r11, #1
	mov r0, r0, lsl #0x10
	mov r11, r0, lsr #0x10
	cmp r11, #2
	blo _02174344
	add r0, sp, #8
	add r3, r8, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0217444C: .word BossFStage__Singleton
_02174450: .word ovl02_2172E68
_02174454: .word FX_SinCosTable_
	arm_func_end ovl02_21742E8

	arm_func_start ovl02_2174458
ovl02_2174458: // _02174458
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r6, [r0, #0x124]
	ldr r1, _021744C4 // =ovl02_21744C8
	mov r7, #0
	str r1, [r0, #0xf4]
	str r7, [r0, #0x2c]
	mov r5, #0x14
	mov r3, #0x1000
	mov r2, r7
	mov r0, #0x58000
_02174480:
	mul lr, r7, r0
	add r4, r6, r7, lsl #1
	add r1, r7, #1
	strh r5, [r4, #0x2c]
	mov ip, r7, lsl #0xf
	strh ip, [r4, #0x34]
	add ip, r6, r7, lsl #2
	str lr, [ip, #8]
	str r3, [ip, #0x10]
	strh r2, [r4, #0x28]
	mov r1, r1, lsl #0x10
	str r3, [ip, #0x18]
	mov r7, r1, lsr #0x10
	str r3, [ip, #0x20]
	cmp r7, #2
	blo _02174480
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021744C4: .word ovl02_21744C8
	arm_func_end ovl02_2174458

	arm_func_start ovl02_21744C8
ovl02_21744C8: // _021744C8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr r1, _021746BC // =BossFStage__Singleton
	mov r7, r0
	ldr r0, [r1, #0]
	ldr r5, [r7, #0x124]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x384]
	tst r0, #0x10
	beq _02174500
	ldr r0, [r7, #0x18]
	orr r0, r0, #4
	str r0, [r7, #0x18]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02174500:
	mov r0, r7
	mov r1, #1
	bl ovl02_2169E34
	ldr r0, [r4, #0x374]
	ldr r1, _021746C0 // =ovl02_2172E68
	ldr r0, [r0, #0xf4]
	cmp r0, r1
	ldrne r0, [r4, #0x370]
	ldrne r0, [r0, #0xf4]
	cmpne r0, r1
	bne _021746A0
	ldr r9, _021746C4 // =_obj_disp_rand
	mov r6, #0
	mov r4, #0x14
	mov r11, #0x1000
	mov r8, #0x180
_02174540:
	add r2, r5, r6, lsl #1
	ldrh r0, [r2, #0x2c]
	cmp r0, #1
	bne _0217457C
	strh r4, [r2, #0x2c]
	add r1, r5, r6, lsl #2
	str r11, [r1, #0x10]
	str r11, [r1, #0x18]
	str r11, [r1, #0x20]
	mov r0, #0x8000
	str r0, [r1, #8]
	mov r0, #0xb00
	str r0, [r5, r6, lsl #2]
	mov r0, #0
	strh r0, [r2, #0x28]
_0217457C:
	add r3, r5, r6, lsl #1
	ldrh r0, [r3, #0x28]
	add r2, r5, r6, lsl #2
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #2
	ldr r0, _021746C8 // =FX_SinCosTable_
	ldrsh r0, [r0, r1]
	mov ip, r0, asr #1
	mov r0, #0
	umull r10, lr, ip, r8
	mla lr, ip, r0, lr
	mov r1, ip, asr #0x1f
	mla lr, r1, r8, lr
	mov r0, #0x800
	adds r1, r10, r0
	mov r0, #0
	adc r0, lr, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	rsb r0, r1, #0xa80
	str r0, [r5, r6, lsl #2]
	ldr r10, [r9, #0]
	ldr r1, _021746CC // =0x00196225
	ldr r0, _021746D0 // =0x3C6EF35F
	mla r0, r10, r1, r0
	str r0, [r9]
	mov r0, r0, lsr #0x10
	strh r0, [r3, #0x34]
	ldr r0, [r2, #0x10]
	ldr r1, [r2, #0x18]
	ldr r2, [r2, #0x20]
	bl ObjSpdUpSet
	add r1, r5, r6, lsl #2
	str r0, [r1, #0x10]
	ldr r3, [r1, #8]
	add r2, r5, r6, lsl #1
	add r0, r3, r0
	str r0, [r1, #8]
	ldrh r0, [r2, #0x28]
	add r0, r0, #1
	strh r0, [r2, #0x28]
	ldr r0, [r1, #8]
	cmp r0, #0x6c000
	ble _02174664
	mov r0, r0, asr #0xc
	sub r0, r0, #0x6c
	mov r0, r0, asr #1
	rsb r2, r0, #0x1f
	add r1, r5, r6, lsl #1
	cmp r2, #1
	ldrh r0, [r1, #0x2c]
	movlt r2, #1
	cmp r0, r2
	strgth r2, [r1, #0x2c]
_02174664:
	add r1, r5, r6, lsl #1
	mov r0, #0
	strh r0, [r1, #0x30]
	ldr r0, [r7, #0x2c]
	mov r0, r0, asr #1
	and r0, r0, #1
	cmp r0, r6
	moveq r0, #1
	streqh r0, [r1, #0x30]
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #2
	blo _02174540
	b _021746AC
_021746A0:
	ldr r0, [r7, #0x20]
	orr r0, r0, #0x20
	str r0, [r7, #0x20]
_021746AC:
	ldr r0, [r7, #0x2c]
	add r0, r0, #1
	str r0, [r7, #0x2c]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021746BC: .word BossFStage__Singleton
_021746C0: .word ovl02_2172E68
_021746C4: .word _obj_disp_rand
_021746C8: .word FX_SinCosTable_
_021746CC: .word 0x00196225
_021746D0: .word 0x3C6EF35F
	arm_func_end ovl02_21744C8

	arm_func_start ovl02_21746D4
ovl02_21746D4: // _021746D4
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	mov r0, #0x1500
	mov r1, #2
	bl CreateStageTaskEx_
	mov r5, r0
	mov r1, #6
	bl StageTask__SetType
	ldr r0, [r5, #0x120]
	mov r1, #0
	bl SetTaskPauseLevel
	ldr r1, [r5, #0x18]
	mov r0, r5
	orr r1, r1, #0x10
	str r1, [r5, #0x18]
	ldr r2, [r5, #0x20]
	mov r1, r4
	orr r2, r2, #0x1a0
	str r2, [r5, #0x20]
	ldr r3, [r5, #0x1c]
	mov r2, #0
	orr r3, r3, #0x100
	str r3, [r5, #0x1c]
	bl StageTask__SetParent
	add r0, r4, #0x44
	add r3, r5, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r5
	mov r1, #0
	mov r2, r1
	mov r3, r1
	bl StageTask__InitCollider
	mov r0, r5
	mov r1, #0
	bl StageTask__GetCollider
	mov r4, r0
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r4
	ldr r1, _021747D4 // =0x0000FFFF
	mov r2, #0
	bl ObjRect__SetDefenceStat
	bl ovl02_2169F80
	mov r2, r0
	mov r3, #0
	str r3, [sp]
	mov r0, r4
	sub r1, r3, #6
	mul r1, r2, r1
	sub r1, r1, #0x30
	mov r1, r1, lsl #0x10
	mov r1, r1, asr #0x10
	sub r2, r3, #0x2e
	sub r3, r3, #0x10
	bl ObjRect__SetBox2D
	str r5, [r4, #0x1c]
	ldr r1, _021747D8 // =0x00000102
	mov r0, r5
	strh r1, [r4, #0x34]
	bl ovl02_21747DC
	mov r0, r5
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021747D4: .word 0x0000FFFF
_021747D8: .word 0x00000102
	arm_func_end ovl02_21746D4

	arm_func_start ovl02_21747DC
ovl02_21747DC: // _021747DC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x11c]
	ldr r1, _0217486C // =ovl02_2174870
	mov r0, r4
	str r1, [r5, #0xf4]
	bl ovl02_217019C
	cmp r0, #0
	ldr r0, [r5, #0x44]
	addne r0, r0, #0x98000
	strne r0, [r5, #0x44]
	bne _02174820
	sub r0, r0, #0x98000
	str r0, [r5, #0x44]
	ldr r0, [r5, #0x20]
	orr r0, r0, #1
	str r0, [r5, #0x20]
_02174820:
	mov r0, #0
	str r0, [r5, #0x4c]
	mov r0, #0x4800
	str r0, [r5, #0x98]
	bl ovl02_2169F80
	ldr r1, [r5, #0x98]
	add r1, r1, r0, lsl #11
	mov r0, r4
	str r1, [r5, #0x98]
	bl ovl02_217019C
	cmp r0, #0
	ldreq r0, [r5, #0x98]
	mov r1, #0
	rsbeq r0, r0, #0
	streq r0, [r5, #0x98]
	mov r0, #6
	str r1, [r5, #0x2c]
	bl ShakeScreen
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217486C: .word ovl02_2174870
	arm_func_end ovl02_21747DC

	arm_func_start ovl02_2174870
ovl02_2174870: // _02174870
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _02174928 // =BossFStage__Singleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	ldr r1, [r4, #0x2c]
	mov r5, r0
	tst r1, #7
	bne _021748C0
	mov r0, r4
	mov r1, #0x99
	bl ovl02_217873C
	ldr r3, [r4, #0x4c]
	mov r0, #0
	ldr ip, [r4, #0x48]
	sub r2, r0, #0x4000
	ldr r1, [r4, #0x44]
	sub r2, r2, ip
	add r3, r3, #0x4000
	bl BossFX__CreateTitanBomb
_021748C0:
	ldr r0, [r4, #0x98]
	cmp r0, #0
	ldr r0, [r5, #0x384]
	bge _021748F8
	tst r0, #2
	mov r1, #0
	ldr r0, [r4, #0x44]
	movne r1, #0xb4000
	cmp r0, r1
	bgt _02174918
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	b _02174918
_021748F8:
	tst r0, #4
	mov r1, #0x2f0000
	ldr r0, [r4, #0x44]
	movne r1, #0x23c000
	cmp r0, r1
	ldrge r0, [r4, #0x18]
	orrge r0, r0, #4
	strge r0, [r4, #0x18]
_02174918:
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02174928: .word BossFStage__Singleton
	arm_func_end ovl02_2174870

	arm_func_start ovl02_217492C
ovl02_217492C: // _0217492C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r7, r0
	ldr r5, [r7, #0x1c]
	mov r6, r1
	ldrh r0, [r5, #0]
	ldr r4, [r6, #0x1c]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r1, [r4, #0x18]
	mov r0, r4
	orr r2, r1, #2
	mov r1, r5
	str r2, [r4, #0x18]
	bl ovl02_2174A78
	mov r0, #0x2000
	ldr r1, [r5, #0xc0]
	rsb r0, r0, #0
	cmp r1, r0
	ble _0217498C
	mov r0, r5
	bl Player__Action_DestroyAttackRecoil
	bl ovl02_216A0D4
_0217498C:
	mov r0, #0x8000
	str r0, [r4, #4]
	str r0, [r4, #8]
	ldr r2, [r4, #4]
	mov r0, r6
	str r2, [r5, #4]
	mov r1, r7
	str r2, [r5, #8]
	bl ObjRect__HitCenterX
	mov r5, r0
	mov r0, r6
	mov r1, r7
	bl ObjRect__HitCenterY
	rsb r2, r0, #0
	ldr r3, [r4, #0x4c]
	mov r1, r5
	mov r0, #1
	bl BossFX__CreateHitB
	mov r0, #0
	str r0, [sp]
	mov r0, #0x28
	sub r1, r0, #0x29
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end ovl02_217492C

	arm_func_start ovl02_2174A0C
ovl02_2174A0C: // _02174A0C
	stmdb sp!, {r4, lr}
	ldr r3, [r1, #0x1c]
	ldr r4, [r0, #0x1c]
	ldrh r2, [r3, #0]
	cmp r2, #2
	ldrneh r2, [r4, #0]
	cmpne r2, #3
	ldmneia sp!, {r4, pc}
	ldr r3, [r3, #0x340]
	ldr r2, _02174A74 // =0x00000139
	ldrh r3, [r3, #2]
	cmp r3, r2
	cmpne r3, #0x13c
	bne _02174A6C
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	rsb r2, r0, #0
	ldr r3, [r4, #0x4c]
	mov r0, #0
	bl BossFX__CreateBomb
	ldr r0, [r4, #0x18]
	orr r0, r0, #0xa
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
_02174A6C:
	bl ObjRect__FuncNoHit
	ldmia sp!, {r4, pc}
	.align 2, 0
_02174A74: .word 0x00000139
	arm_func_end ovl02_2174A0C

	arm_func_start ovl02_2174A78
ovl02_2174A78: // _02174A78
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r3, [r6, #0x20]
	ldr r2, _02174C04 // =0x0000013E
	bic r3, r3, #0x20
	str r3, [r6, #0x20]
	ldr r3, [r6, #0x270]
	mov r5, r1
	bic r3, r3, #4
	orr r3, r3, #0x800
	str r3, [r6, #0x270]
	ldr r3, [r6, #0x340]
	ldrh r3, [r3, #2]
	cmp r3, r2
	bne _02174ABC
	bl ovl02_2174D00
	ldmia sp!, {r4, r5, r6, pc}
_02174ABC:
	ldr r0, _02174C08 // =ovl02_2174C18
	add r4, r6, #0x218
	str r0, [r6, #0xf4]
	add r0, r2, #0xc3
	strh r0, [r4, #0x34]
	ldr r3, _02174C0C // =ovl02_2174A0C
	mov r0, r4
	mov r1, #1
	mov r2, #0x40
	str r3, [r4, #0x20]
	bl ObjRect__SetAttackStat
	ldr r1, _02174C10 // =0x0000FFFF
	mov r0, r4
	mov r2, #0
	bl ObjRect__SetDefenceStat
	mov r0, #0
	str r0, [r4, #0x24]
	ldr r0, [r6, #0x18]
	bic r0, r0, #2
	str r0, [r6, #0x18]
	ldr r3, [r6, #0x48]
	ldr r0, [r5, #0x48]
	ldr r2, [r6, #0x44]
	ldr r1, [r5, #0x44]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	strh r0, [r6, #0x34]
	ldr r0, [r5, #0xc0]
	ldr r2, [r5, #0xbc]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r2, #0
	rsblt r2, r2, #0
	add r0, r2, r0
	mov r1, #0x8000
	add r1, r1, r0, asr #1
	ldrh r0, [r6, #0x34]
	cmp r1, #0xf000
	movgt r1, #0xf000
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r3, r1, lsl #1
	ldr r2, _02174C14 // =FX_SinCosTable_
	mov r0, r0, lsl #1
	ldrsh r0, [r2, r0]
	mov r1, r1, asr #2
	smull r4, r0, r3, r0
	adds r3, r4, #0x800
	adc r0, r0, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r0, lsl #20
	str r3, [r6, #0x98]
	ldrh r0, [r6, #0x34]
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r0, [r2, r0]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r6, #0x9c]
	ldr r1, [r6, #0x98]
	ldr r0, [r5, #0xbc]
	adds r0, r1, r0
	str r0, [r6, #0x98]
	bmi _02174BDC
	cmp r0, #0x4000
	movlt r0, #0x4000
	strlt r0, [r6, #0x98]
_02174BDC:
	ldr r1, [r6, #0x98]
	cmp r1, #0
	bge _02174BF8
	mov r0, #0x4000
	rsb r0, r0, #0
	cmp r1, r0
	strgt r0, [r6, #0x98]
_02174BF8:
	mov r0, #0
	str r0, [r6, #0x2c]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02174C04: .word 0x0000013E
_02174C08: .word ovl02_2174C18
_02174C0C: .word ovl02_2174A0C
_02174C10: .word 0x0000FFFF
_02174C14: .word FX_SinCosTable_
	arm_func_end ovl02_2174A78

	arm_func_start ovl02_2174C18
ovl02_2174C18: // _02174C18
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x24
	mov r4, r0
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0x3c
	ldrle r0, [r4, #0x48]
	cmple r0, #0x740000
	ble _02174C6C
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	rsb r2, r0, #0
	ldr r3, [r4, #0x4c]
	mov r0, #0
	bl BossFX__CreateBomb
	ldr r0, [r4, #0x18]
	add sp, sp, #0x24
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, pc}
_02174C6C:
	ldrh r0, [r4, #0x30]
	ldr r2, _02174CFC // =FX_SinCosTable_
	add r0, r0, #0x800
	strh r0, [r4, #0x30]
	ldrh r0, [r4, #0x32]
	add r0, r0, #0x400
	strh r0, [r4, #0x32]
	ldrh r0, [r4, #0x30]
	ldr r3, [r4, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotX33_
	ldrh r1, [r4, #0x32]
	ldr r3, _02174CFC // =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	ldr r2, [r4, #0x12c]
	add r1, sp, #0
	add r0, r2, #0x24
	add r2, r2, #0x24
	bl MTX_Concat33
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02174CFC: .word FX_SinCosTable_
	arm_func_end ovl02_2174C18

	arm_func_start ovl02_2174D00
ovl02_2174D00: // _02174D00
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x84
	ldr r1, _02174DC8 // =ovl02_2174DE0
	mov r5, r0
	str r1, [r5, #0xf4]
	ldr r0, _02174DCC // =0x00000201
	add r4, r5, #0x218
	strh r0, [r4, #0x34]
	ldr r3, _02174DD0 // =ovl02_2174A0C
	mov r0, r4
	mov r1, #2
	mov r2, #0x40
	str r3, [r4, #0x20]
	bl ObjRect__SetAttackStat
	ldr r1, _02174DD4 // =0x0000FFFF
	mov r0, r4
	mov r2, #0
	bl ObjRect__SetDefenceStat
	mov r1, #0
	ldr r0, _02174DD8 // =_02179060
	str r1, [r4, #0x24]
	add r3, sp, #0x60
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, _02174DDC // =_02179084
	add r3, sp, #0x54
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r5, #0x44
	add r3, sp, #0x6c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, sp, #0x78
	bl ovl02_2169EBC
	add r0, sp, #0x6c
	add r1, sp, #0x78
	add r2, sp, #0x60
	add r3, sp, #0x24
	bl Unknown2066510__Func_2066A4C
	add r0, sp, #0x24
	add r1, sp, #0
	bl MI_Copy36B
	add r0, sp, #0x54
	add r1, sp, #0
	add r2, r5, #0x98
	bl MTX_MultVec33
	mov r0, #0
	str r0, [r5, #0x2c]
	add sp, sp, #0x84
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02174DC8: .word ovl02_2174DE0
_02174DCC: .word 0x00000201
_02174DD0: .word ovl02_2174A0C
_02174DD4: .word 0x0000FFFF
_02174DD8: .word _02179060
_02174DDC: .word _02179084
	arm_func_end ovl02_2174D00

	arm_func_start ovl02_2174DE0
ovl02_2174DE0: // _02174DE0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x24
	mov r4, r0
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0x78
	ble _02174E2C
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	rsb r2, r0, #0
	ldr r3, [r4, #0x4c]
	mov r0, #0
	bl BossFX__CreateBomb
	ldr r0, [r4, #0x18]
	add sp, sp, #0x24
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, pc}
_02174E2C:
	cmp r0, #6
	ldreq r0, [r4, #0x18]
	ldr r2, _02174ECC // =FX_SinCosTable_
	biceq r0, r0, #2
	streq r0, [r4, #0x18]
	ldrh r0, [r4, #0x30]
	add r0, r0, #0x800
	strh r0, [r4, #0x30]
	ldrh r0, [r4, #0x32]
	add r0, r0, #0x400
	strh r0, [r4, #0x32]
	ldrh r0, [r4, #0x30]
	ldr r3, [r4, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotX33_
	ldrh r1, [r4, #0x32]
	ldr r3, _02174ECC // =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	ldr r2, [r4, #0x12c]
	add r1, sp, #0
	add r0, r2, #0x24
	add r2, r2, #0x24
	bl MTX_Concat33
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02174ECC: .word FX_SinCosTable_
	arm_func_end ovl02_2174DE0

	arm_func_start ovl02_2174ED0
ovl02_2174ED0: // _02174ED0
	ldr r2, _02174F0C // =ovl02_2174F10
	mov r1, #0xc000
	str r2, [r0, #0xf4]
	strh r1, [r0, #0x30]
	ldr r1, [r0, #0x340]
	ldrsb r1, [r1, #6]
	add r1, r1, #1
	str r1, [r0, #0x2c]
	ldr r1, [r0, #0x20]
	orr r1, r1, #0x20
	str r1, [r0, #0x20]
	ldr r1, [r0, #0x1c]
	orr r1, r1, #0x2000
	str r1, [r0, #0x1c]
	bx lr
	.align 2, 0
_02174F0C: .word ovl02_2174F10
	arm_func_end ovl02_2174ED0

	arm_func_start ovl02_2174F10
ovl02_2174F10: // _02174F10
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x4c
	mov r4, r0
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	beq _02174FA8
	subs r0, r0, #1
	addne sp, sp, #0x4c
	str r0, [r4, #0x2c]
	ldmneia sp!, {r4, r5, pc}
	ldr r2, _02175168 // =FX_SinCosTable_+0x00001000
	add r0, sp, #0x28
	ldrsh r1, [r2, #0]
	ldrsh r2, [r2, #2]
	bl MTX_RotX33_
	add r1, sp, #0x28
	str r1, [sp]
	ldr r2, [r4, #0x48]
	ldr r1, [r4, #0x44]
	ldr r3, [r4, #0x4c]
	mov r0, #0
	rsb r2, r2, #0x38000
	bl BossFX__CreateTitanFlashC
	cmp r0, #0
	beq _02174F84
	ldr r2, _0217516C // =ovl02_2176A1C
	mov r1, #0x2000
	str r2, [r0, #0x2e4]
	str r1, [r0, #0x280]
_02174F84:
	ldr r0, [r4, #0x20]
	ldr r1, _02175170 // =0x00000126
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	mov r0, r4
	bic r2, r2, #0x2000
	str r2, [r4, #0x1c]
	bl ovl02_217873C
_02174FA8:
	ldr r0, [r4, #0x340]
	mov r3, #0x53000
	ldrsb r2, [r0, #7]
	mov r0, #0x32000
	ldr r1, [r4, #0x44]
	mla r5, r2, r0, r3
	cmp r1, r5
	bge _02174FDC
	ldr r0, [r4, #0x98]
	mov r1, #0x80
	mov r2, #0x3000
	bl ObjSpdUpSet
	str r0, [r4, #0x98]
_02174FDC:
	ldr r0, [r4, #0x44]
	cmp r0, r5
	ble _02174FFC
	ldr r0, [r4, #0x98]
	mvn r1, #0x7f
	mov r2, #0x3000
	bl ObjSpdUpSet
	str r0, [r4, #0x98]
_02174FFC:
	mov r0, #0x190000
	ldr r1, [r4, #0x4c]
	rsb r0, r0, #0
	cmp r1, r0
	bge _02175024
	ldrh r0, [r4, #0x30]
	mov r1, #0xf000
	mov r2, #0x140
	bl ObjRoopMove16
	strh r0, [r4, #0x30]
_02175024:
	ldrh r0, [r4, #0x30]
	ldr r2, _02175174 // =FX_SinCosTable_
	ldr r3, [r4, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotX33_
	ldr r0, [r4, #0x98]
	ldr r2, _02175174 // =FX_SinCosTable_
	rsb r0, r0, #0
	mov r0, r0, lsl #0xe
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #4
	bl MTX_RotZ33_
	ldr r2, [r4, #0x12c]
	add r1, sp, #4
	add r0, r2, #0x24
	add r2, r2, #0x24
	bl MTX_Concat33
	ldrh r1, [r4, #0x30]
	ldr ip, _02175174 // =FX_SinCosTable_
	mov r0, #0x800
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r3, [ip, r1]
	ldr r1, _02175178 // =0x00226000
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #0xf
	adds lr, r0, r3, lsl #15
	orr r2, r2, r3, lsr #17
	adc r2, r2, #0
	mov r3, lr, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [r4, #0x9c]
	ldrh r2, [r4, #0x30]
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r3, [ip, r2]
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #0xf
	adds ip, r0, r3, lsl #15
	orr r2, r2, r3, lsr #17
	adc r0, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [r4, #0xa0]
	ldr r2, [r4, #0x48]
	cmp r2, r1
	bge _02175138
	mov r0, r4
	bl ovl02_217517C
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02175138:
	ldr r1, [r4, #0x4c]
	mvn r0, #0x140000
	cmp r1, r0
	addlt sp, sp, #0x4c
	ldmltia sp!, {r4, r5, pc}
	cmp r2, #0x2bc000
	addge sp, sp, #0x4c
	ldmgeia sp!, {r4, r5, pc}
	mov r0, r4
	bl ovl02_217517C
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02175168: .word FX_SinCosTable_+0x00001000
_0217516C: .word ovl02_2176A1C
_02175170: .word 0x00000126
_02175174: .word FX_SinCosTable_
_02175178: .word 0x00226000
	arm_func_end ovl02_2174F10

	arm_func_start ovl02_217517C
ovl02_217517C: // _0217517C
	stmdb sp!, {r4, lr}
	ldr r1, _0217522C // =ovl02_2175238
	mov r4, r0
	mov r3, #0x53000
	str r1, [r4, #0xf4]
	str r3, [r4, #0x44]
	ldr r0, [r4, #0x340]
	mov r2, #0x4000
	ldrsb r1, [r0, #7]
	mov r0, #0x32000
	mla r0, r1, r0, r3
	str r0, [r4, #0x44]
	ldr r3, _02175230 // =0x0044C000
	mov r0, r2, asr #4
	str r3, [r4, #0x48]
	mov r3, #0
	str r3, [r4, #0x4c]
	str r3, [r4, #0xc8]
	str r3, [r4, #0x98]
	str r2, [r4, #0x9c]
	mov r1, r0, lsl #1
	add r0, r1, #1
	str r3, [r4, #0xa0]
	strh r2, [r4, #0x30]
	ldr r2, _02175234 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldr r3, [r4, #0x12c]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotX33_
	ldr r0, [r4, #0x18]
	bic r0, r0, #2
	str r0, [r4, #0x18]
	ldr r1, [r4, #0x340]
	ldrb r0, [r1, #8]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldrb r0, [r1, #9]
	ldr r1, [r4, #0x9c]
	add r0, r1, r0, lsl #12
	str r0, [r4, #0x9c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217522C: .word ovl02_2175238
_02175230: .word 0x0044C000
_02175234: .word FX_SinCosTable_
	arm_func_end ovl02_217517C

	arm_func_start ovl02_2175238
ovl02_2175238: // _02175238
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x340]
	ldrb r0, [r0, #8]
	cmp r0, #1
	cmpne r0, #2
	bne _0217526C
	ldr r0, [r4, #0x48]
	cmp r0, #0x6c0000
	ble _0217526C
	mov r0, r4
	bl ovl02_21752B4
	ldmia sp!, {r4, pc}
_0217526C:
	ldr r1, [r4, #0x48]
	ldr r0, _021752B0 // =0x0072C000
	cmp r1, r0
	ldmleia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0x99
	bl ovl02_217873C
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	ldr r3, [r4, #0x4c]
	rsb r2, r0, #0
	mov r0, #0
	bl BossFX__CreateBomb
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021752B0: .word 0x0072C000
	arm_func_end ovl02_2175238

	arm_func_start ovl02_21752B4
ovl02_21752B4: // _021752B4
	ldr r1, _021752C0 // =ovl02_21752C4
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_021752C0: .word ovl02_21752C4
	arm_func_end ovl02_21752B4

	arm_func_start ovl02_21752C4
ovl02_21752C4: // _021752C4
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r1, #8
	str r1, [sp]
	mov r4, r0
	ldr r0, [r4, #0x9c]
	mov r1, #0
	mov r2, #2
	mov r3, #0x200
	bl ObjShiftSet
	mov r1, #0x4000
	str r0, [r4, #0x9c]
	bl FX_Div
	mov r1, r0, asr #0x1f
	mov r2, r1, lsl #0xe
	mov r1, #0x800
	adds r1, r1, r0, lsl #14
	orr r2, r2, r0, lsr #18
	adc r0, r2, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	strh r1, [r4, #0x30]
	ldrh r1, [r4, #0x30]
	ldr r0, [r4, #0x12c]
	ldr r3, _021753A4 // =FX_SinCosTable_
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r2, r1, #1
	mov r1, r1, lsl #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	add r0, r0, #0x24
	bl MTX_RotX33_
	ldr r0, [r4, #0x9c]
	cmp r0, #0
	bne _02175390
	ldr r0, [r4, #0x340]
	ldrb r0, [r0, #8]
	cmp r0, #1
	beq _02175370
	cmp r0, #2
	beq _02175380
_02175370:
	mov r0, r4
	bl ovl02_21753A8
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
_02175380:
	mov r0, r4
	bl ovl02_217572C
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
_02175390:
	mov r0, r4
	mov r1, #1
	bl ovl02_2169E34
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021753A4: .word FX_SinCosTable_
	arm_func_end ovl02_21752C4

	arm_func_start ovl02_21753A8
ovl02_21753A8: // _021753A8
	ldr r1, _021753DC // =ovl02_21753E4
	mov r2, #0
	str r1, [r0, #0xf4]
	ldr r3, [r0, #0x20]
	ldr r1, _021753E0 // =gPlayer
	bic r3, r3, #0x20
	str r3, [r0, #0x20]
	str r2, [r0, #0x2c]
	strh r2, [r0, #0x30]
	strh r2, [r0, #0x32]
	ldr r1, [r1, #0]
	str r1, [r0, #0x35c]
	bx lr
	.align 2, 0
_021753DC: .word ovl02_21753E4
_021753E0: .word gPlayer
	arm_func_end ovl02_21753A8

	arm_func_start ovl02_21753E4
ovl02_21753E4: // _021753E4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x24
	mov r4, r0
	ldr r5, [r4, #0x35c]
	cmp r5, #0
	beq _021754F8
	ldr r1, [r5, #0x44]
	ldr r0, [r4, #0x44]
	mov r2, #0x800
	cmp r1, r0
	ldrh r0, [r4, #0x32]
	ble _02175420
	mov r1, #0x4000
	bl ObjRoopMove16
	b _02175428
_02175420:
	mov r1, #0xc000
	bl ObjRoopMove16
_02175428:
	strh r0, [r4, #0x32]
	ldr r3, [r5, #0x48]
	ldr r0, [r4, #0x48]
	ldr r2, [r5, #0x44]
	ldr r1, [r4, #0x44]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r1, r0
	ldr r2, [r4, #0x340]
	cmp r1, #0x4000
	ldrb r0, [r2, #9]
	mov r2, #0x100
	add r0, r2, r0, lsl #7
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	blo _0217547C
	cmp r1, #0xc000
	rsblo r0, r1, #0x8000
	movlo r0, r0, lsl #0x10
	movlo r1, r0, lsr #0x10
_0217547C:
	ldrh r0, [r4, #0x30]
	bl ObjRoopMove16
	strh r0, [r4, #0x30]
	ldrh r0, [r4, #0x30]
	ldr r2, _0217559C // =FX_SinCosTable_
	ldr r3, [r4, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotX33_
	ldrh r1, [r4, #0x32]
	ldr r3, _0217559C // =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	ldr r2, [r4, #0x12c]
	add r1, sp, #0
	add r0, r2, #0x24
	add r2, r2, #0x24
	bl MTX_Concat33
_021754F8:
	ldr r0, [r4, #0x2c]
	ldr r1, _0217559C // =FX_SinCosTable_
	mov r0, r0, lsl #0x1a
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r3, [r1, r0]
	mov r1, #0x800
	mov r0, r4
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #0xc
	adds ip, r1, r3, lsl #12
	orr r2, r2, r3, lsr #20
	adc r1, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x9c]
	mov r1, #1
	bl ovl02_2169E34
	ldrh r0, [r4, #0x32]
	cmp r0, #0x4000
	cmpne r0, #0xc000
	addne sp, sp, #0x24
	ldmneia sp!, {r4, r5, pc}
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	cmp r0, #0x78
	addle sp, sp, #0x24
	str r0, [r4, #0x2c]
	ldmleia sp!, {r4, r5, pc}
	ldrh r0, [r4, #0x32]
	cmp r0, #0xc000
	ldrh r0, [r4, #0x30]
	rsbeq r0, r0, #0x8000
	strh r0, [r4, #0x34]
	mov r0, r4
	bl ovl02_21755A0
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0217559C: .word FX_SinCosTable_
	arm_func_end ovl02_21753E4

	arm_func_start ovl02_21755A0
ovl02_21755A0: // _021755A0
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r4, r0
	add r5, r4, #0x258
	mov r0, r5
	mov r1, #1
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	ldr r1, _021756C0 // =0x0000FFFF
	mov r0, r5
	mov r2, #0
	bl ObjRect__SetDefenceStat
	mov r3, #0xf
	sub r1, r3, #0x1e
	mov r0, r5
	mov r2, r1
	str r3, [sp]
	bl ObjRect__SetBox2D
	ldr r1, _021756C4 // =0x00000201
	ldr r0, _021756C8 // =ovl02_2174A0C
	strh r1, [r5, #0x34]
	str r0, [r5, #0x20]
	str r4, [r5, #0x1c]
	mov r3, #0
	str r3, [r5, #0x24]
	ldr r0, _021756CC // =ovl02_21756D4
	mov r5, #0x5800
	str r0, [r4, #0xf4]
	ldr r0, [r4, #0x20]
	ldr lr, _021756D0 // =FX_SinCosTable_
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	str r3, [r4, #0x2c]
	ldr r0, [r4, #0x340]
	ldrh r1, [r4, #0x34]
	ldrb r2, [r0, #9]
	mov r0, r4
	mov ip, r1, asr #4
	add r1, r2, r2, lsl #1
	add r2, r5, r1, lsl #10
	mov r1, ip, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #1
	ldrsh ip, [lr, r1]
	mov r1, #0x6b
	smull r5, ip, r2, ip
	adds r6, r5, #0x800
	adc r5, ip, #0
	mov r6, r6, lsr #0xc
	orr r6, r6, r5, lsl #20
	str r6, [r4, #0x98]
	ldrh ip, [r4, #0x34]
	mov ip, ip, asr #4
	mov ip, ip, lsl #2
	ldrsh ip, [lr, ip]
	smull lr, ip, r2, ip
	adds lr, lr, #0x800
	adc r2, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r2, lsl #20
	str ip, [r4, #0x9c]
	str r3, [r4, #0xa0]
	ldr r2, [r4, #0x340]
	ldrb r2, [r2, #9]
	rsb r2, r2, #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #4
	str r2, [r4, #4]
	str r2, [r4, #8]
	bl ovl02_217873C
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_021756C0: .word 0x0000FFFF
_021756C4: .word 0x00000201
_021756C8: .word ovl02_2174A0C
_021756CC: .word ovl02_21756D4
_021756D0: .word FX_SinCosTable_
	arm_func_end ovl02_21755A0

	arm_func_start ovl02_21756D4
ovl02_21756D4: // _021756D4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0x78
	ldrle r0, [r4, #0x48]
	cmple r0, #0x740000
	ldmleia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0x99
	bl ovl02_217873C
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	ldr r3, [r4, #0x4c]
	rsb r2, r0, #0
	mov r0, #0
	bl BossFX__CreateBomb
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_21756D4

	arm_func_start ovl02_217572C
ovl02_217572C: // _0217572C
	stmdb sp!, {r3, lr}
	ldr r2, _021757B4 // =ovl02_21757C4
	mov r1, #0
	str r2, [r0, #0xf4]
	str r1, [r0, #0x2c]
	mov r1, #0xf0
	ldr ip, _021757B8 // =_mt_math_rand
	str r1, [r0, #0x28]
	ldr r1, [ip]
	ldr r2, _021757BC // =0x00196225
	ldr r3, _021757C0 // =0x3C6EF35F
	mla lr, r1, r2, r3
	mov r1, lr, lsr #0x10
	mov r1, r1, lsl #0x10
	str lr, [ip]
	mov r1, r1, lsr #0x10
	ldr lr, [r0, #0x28]
	and r1, r1, #0xff
	add r1, lr, r1
	str r1, [r0, #0x28]
	ldr r1, [ip]
	mla r2, r1, r2, r3
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r2, [ip]
	tst r1, #1
	ldrne r1, [r0, #0x20]
	orrne r1, r1, #1
	strne r1, [r0, #0x20]
	ldr r1, [r0, #0x20]
	bic r1, r1, #0x20
	str r1, [r0, #0x20]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021757B4: .word ovl02_21757C4
_021757B8: .word _mt_math_rand
_021757BC: .word 0x00196225
_021757C0: .word 0x3C6EF35F
	arm_func_end ovl02_217572C

	arm_func_start ovl02_21757C4
ovl02_21757C4: // _021757C4
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _02175980 // =BossFStage__Singleton
	mov r6, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	ldr r1, [r6, #0x340]
	ldr r2, [r6, #0x2c]
	ldrb r3, [r1, #9]
	tst r2, #0x7f
	mov r5, r0
	ldreq r0, [r6, #0x20]
	mov r1, #0x600
	eoreq r0, r0, #1
	streq r0, [r6, #0x20]
	ldr r0, [r5, #0x384]
	smulbb r4, r3, r1
	mov r1, #0x40000
	tst r0, #2
	movne r1, #0xb4000
	tst r0, #4
	mov r2, #0x2b0000
	ldr r0, [r6, #0x44]
	movne r2, #0x23c000
	cmp r0, r1
	ldrle r0, [r6, #0x20]
	mov r1, #0x400
	bicle r0, r0, #1
	strle r0, [r6, #0x20]
	ldr r0, [r6, #0x44]
	cmp r0, r2
	ldrge r0, [r6, #0x20]
	orrge r0, r0, #1
	strge r0, [r6, #0x20]
	ldr r0, [r6, #0x20]
	tst r0, #1
	ldr r0, [r6, #0x98]
	beq _02175868
	rsb r1, r1, #0
	add r2, r4, #0x1400
	bl ObjSpdUpSet
	b _02175870
_02175868:
	add r2, r4, #0x1400
	bl ObjSpdUpSet
_02175870:
	str r0, [r6, #0x98]
	ldr r0, [r6, #0x98]
	add r1, r4, #0x1400
	bl FX_Div
	mov r1, r0, asr #0x1f
	mov r2, r1, lsl #0xe
	mov r1, #0x800
	adds r1, r1, r0, lsl #14
	orr r2, r2, r0, lsr #18
	adc r0, r2, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	strh r1, [r6, #0x32]
	ldrh r0, [r6, #0x32]
	ldr r2, _02175984 // =FX_SinCosTable_
	ldr r3, [r6, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotY33_
	ldr r0, [r6, #0x2c]
	ldr r1, _02175984 // =FX_SinCosTable_
	mov r0, r0, lsl #0x1a
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r2, [r1, r0]
	mov r0, #0x800
	mov r1, r2, asr #0x1f
	mov r1, r1, lsl #0xc
	adds r3, r0, r2, lsl #12
	orr r1, r1, r2, lsr #20
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r6, #0x9c]
	ldr r0, [r6, #0x2c]
	add r1, r0, #1
	str r1, [r6, #0x2c]
	ldr r0, [r6, #0x28]
	cmp r1, r0
	bhi _02175940
	ldr r0, [r5, #0x384]
	tst r0, #1
	bne _02175970
_02175940:
	mov r0, r6
	mov r1, #0x99
	bl ovl02_217873C
	ldr r0, [r6, #0x48]
	ldr r1, [r6, #0x44]
	ldr r3, [r6, #0x4c]
	rsb r2, r0, #0
	mov r0, #0
	bl BossFX__CreateBomb
	ldr r0, [r6, #0x18]
	orr r0, r0, #4
	str r0, [r6, #0x18]
_02175970:
	mov r0, r6
	mov r1, #1
	bl ovl02_2169E34
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02175980: .word BossFStage__Singleton
_02175984: .word FX_SinCosTable_
	arm_func_end ovl02_21757C4

	arm_func_start ovl02_2175988
ovl02_2175988: // _02175988
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r5, [r0, #0x124]
	mov r0, #0x1a00
	mov r1, #4
	bl CreateStageTaskEx_
	mov r1, #5
	mov r4, r0
	bl StageTask__SetType
	mov r1, #0
	ldr r0, _02175AA4 // =gameArchiveStage
	str r1, [sp]
	ldr r3, [r0, #0]
	ldr r2, _02175AA8 // =aBsef8WaveNsbmd_0
	str r3, [sp, #4]
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, _02175AA4 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	mov r1, #0
	str r2, [sp]
	ldr r2, _02175AAC // =aBsef8WaveNsbca_0
	mov r3, r1
	bl ObjAction3dNNMotionLoad
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x18]
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x180
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	ldr r0, [r5, #0x20]
	tst r0, #0x10
	ldreq r1, [r5, #4]
	beq _02175A48
	ldr r1, [r5, #0]
	mov r0, #1
	str r0, [r4, #0x28]
_02175A48:
	mov r0, r4
	mov r2, #0
	ldr r5, [r1, #0x124]
	bl StageTask__SetParent
	ldr r0, [r4, #0x20]
	mov r1, #0x1f
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldr r2, [r5, #0x94]
	ldr r3, [r5, #0x98]
	ldr r0, [r5, #0x90]
	rsb r2, r2, #0
	str r0, [r4, #0x44]
	str r2, [r4, #0x48]
	str r3, [r4, #0x4c]
	ldr r0, [r4, #0x12c]
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlAlphaAll
	ldr r1, _02175AB0 // =ovl02_2175AB4
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02175AA4: .word gameArchiveStage
_02175AA8: .word aBsef8WaveNsbmd_0
_02175AAC: .word aBsef8WaveNsbca_0
_02175AB0: .word ovl02_2175AB4
	arm_func_end ovl02_2175988

	arm_func_start ovl02_2175AB4
ovl02_2175AB4: // _02175AB4
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x54
	ldr r1, _02175BC0 // =_02179030
	add r3, sp, #0
	mov r6, r0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r4, [r6, #0x11c]
	ldr r5, [r4, #0x124]
	ldr r1, [r5, #0x94]
	ldr r2, [r5, #0x98]
	ldr r0, [r5, #0x90]
	rsb r1, r1, #0
	str r0, [r6, #0x44]
	str r1, [r6, #0x48]
	str r2, [r6, #0x4c]
	ldr r0, [r6, #0x28]
	ldr r2, _02175BC4 // =FX_SinCosTable_
	cmp r0, #0
	movne r0, #0x4000
	moveq r0, #0xc000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0xc
	bl MTX_RotY33_
	add r1, sp, #0x30
	add r0, r5, #0x6c
	bl MI_Copy36B
	ldr r2, [r6, #0x12c]
	add r0, sp, #0x30
	add r1, sp, #0xc
	add r2, r2, #0x24
	bl MTX_Concat33
	ldr r0, [r6, #0x28]
	add r1, sp, #0x30
	cmp r0, #0
	ldrne r0, [sp]
	rsbne r0, r0, #0
	strne r0, [sp]
	add r0, sp, #0
	mov r2, r0
	bl MTX_MultVec33
	add r0, r6, #0x44
	add r1, sp, #0
	mov r2, r0
	bl VEC_Subtract
	ldr r0, [r4, #0x11c]
	ldr r0, [r0, #0x124]
	ldr r0, [r0, #0x20]
	tst r0, #0x80
	beq _02175BAC
	mov r1, #0x1f000
	ldr r0, _02175BC8 // =ovl02_2175BCC
	str r1, [r6, #0x2c]
	str r0, [r6, #0xf4]
_02175BAC:
	mov r0, r6
	mov r1, #1
	bl ovl02_2169E34
	add sp, sp, #0x54
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02175BC0: .word _02179030
_02175BC4: .word FX_SinCosTable_
_02175BC8: .word ovl02_2175BCC
	arm_func_end ovl02_2175AB4

	arm_func_start ovl02_2175BCC
ovl02_2175BCC: // _02175BCC
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, [r4, #0x38]
	ldr r5, [r4, #0x11c]
	mov r3, #0
	str r3, [sp]
	mov r1, #0x3000
	mov r2, #1
	bl ObjShiftSet
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	ldr r0, [r4, #0x2c]
	mov r1, #0x2000
	bl ObjSpdDownSet
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x12c]
	mov r1, #0xa
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlPolygonIDAll
	ldr r0, [r4, #0x12c]
	ldr r1, [r4, #0x2c]
	ldr r0, [r0, #0x94]
	mov r1, r1, asr #0xc
	bl NNS_G3dMdlSetMdlAlphaAll
	ldrh r0, [r5, #0]
	cmp r0, #1
	mov r0, r4
	bne _02175C4C
	mov r1, #0
	bl ovl02_2169E34
	b _02175C54
_02175C4C:
	mov r1, #1
	bl ovl02_2169E34
_02175C54:
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x20
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_2175BCC

	arm_func_start ovl02_2175C7C
ovl02_2175C7C: // _02175C7C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4, #0x38]
	mov r1, #0
	mov r3, r1
	str r1, [sp]
	mov r2, #4
	bl ObjShiftSet
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	ldr r0, [r4, #0x2c]
	mov r1, #0x1000
	bl ObjSpdDownSet
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x12c]
	mov r1, #0xa
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlPolygonIDAll
	ldr r0, [r4, #0x12c]
	ldr r1, [r4, #0x2c]
	ldr r0, [r0, #0x94]
	mov r1, r1, asr #0xc
	bl NNS_G3dMdlSetMdlAlphaAll
	mov r0, r4
	mov r1, #1
	bl ovl02_2169E34
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x20
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end ovl02_2175C7C

	arm_func_start ovl02_2175D1C
ovl02_2175D1C: // _02175D1C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r1
	ldr r5, [r0, #0x124]
	mov r0, #0x1a00
	mov r1, #4
	bl CreateStageTaskEx_
	mov r1, #5
	mov r4, r0
	bl StageTask__SetType
	mov r1, #0
	ldr r0, _02175E64 // =gameArchiveStage
	str r1, [sp]
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp, #4]
	ldr r2, _02175E68 // =aBsef8WaveNsbmd_0
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, _02175E64 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	mov r1, #0
	str r2, [sp]
	ldr r2, _02175E6C // =aBsef8WaveNsbca_0
	mov r3, r1
	bl ObjAction3dNNMotionLoad
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x20]
	ldr r1, _02175E70 // =0x00006998
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldr r2, [r4, #0x18]
	mov r0, #0xe00
	orr r2, r2, #2
	str r2, [r4, #0x18]
	ldr r2, [r4, #0x20]
	cmp r6, #0
	orr r2, r2, #0x180
	str r2, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	orr r2, r2, #0x2100
	str r2, [r4, #0x1c]
	ldr r2, [r4, #0x12c]
	str r1, [r2, #0x18]
	str r1, [r2, #0x1c]
	str r1, [r2, #0x20]
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	ldreq r1, [r5, #4]
	beq _02175E00
	ldr r1, [r5, #0]
	mov r0, #1
	str r0, [r4, #0x28]
_02175E00:
	mov r0, r4
	mov r2, #0
	ldr r5, [r1, #0x124]
	bl StageTask__SetParent
	ldr r0, [r4, #0x20]
	mov r1, #0x1f
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldr r2, [r5, #0x94]
	ldr r3, [r5, #0x98]
	ldr r0, [r5, #0x90]
	rsb r2, r2, #0
	str r0, [r4, #0x44]
	str r2, [r4, #0x48]
	str r3, [r4, #0x4c]
	ldr r0, [r4, #0x12c]
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlAlphaAll
	mov r0, #0
	ldr r1, _02175E74 // =ovl02_2175E78
	str r0, [r4, #0x2c]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02175E64: .word gameArchiveStage
_02175E68: .word aBsef8WaveNsbmd_0
_02175E6C: .word aBsef8WaveNsbca_0
_02175E70: .word 0x00006998
_02175E74: .word ovl02_2175E78
	arm_func_end ovl02_2175D1C

	arm_func_start ovl02_2175E78
ovl02_2175E78: // _02175E78
	ldr r1, [r0, #0x11c]
	ldr r1, [r1, #0x124]
	ldr r2, [r1, #0x94]
	ldr r3, [r1, #0x98]
	ldr r1, [r1, #0x90]
	rsb r2, r2, #0
	str r1, [r0, #0x44]
	str r2, [r0, #0x48]
	str r3, [r0, #0x4c]
	ldr r1, [r0, #0x2c]
	add r1, r1, #1
	str r1, [r0, #0x2c]
	cmp r1, #0xdc
	ble _02175EC0
	mov r2, #0x1f000
	ldr r1, _02175ECC // =ovl02_2175C7C
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
_02175EC0:
	ldr ip, _02175ED0 // =ovl02_2169E34
	mov r1, #1
	bx ip
	.align 2, 0
_02175ECC: .word ovl02_2175C7C
_02175ED0: .word ovl02_2169E34
	arm_func_end ovl02_2175E78

	arm_func_start ovl02_2175ED4
ovl02_2175ED4: // _02175ED4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	mov r0, #0x1a00
	mov r1, #4
	bl CreateStageTaskEx_
	mov r1, #5
	mov r4, r0
	bl StageTask__SetType
	mov r1, #0
	ldr r0, _02175FE4 // =gameArchiveStage
	str r1, [sp]
	ldr r3, [r0, #0]
	ldr r2, _02175FE8 // =aBsef8WaveNsbmd_0
	mov r0, r4
	str r3, [sp, #4]
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, _02175FE4 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	mov r1, #0
	str r2, [sp]
	ldr r2, _02175FEC // =aBsef8WaveNsbca_0
	mov r3, r1
	bl ObjAction3dNNMotionLoad
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x20]
	ldr r2, _02175FF0 // =0x000034CC
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldr r1, [r4, #0x18]
	mov r0, #0xd00
	orr r1, r1, #2
	str r1, [r4, #0x18]
	ldr r3, [r4, #0x20]
	mov r1, #0x1f
	orr r3, r3, #0x180
	str r3, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	orr r3, r3, #0x2100
	str r3, [r4, #0x1c]
	ldr r3, [r4, #0x12c]
	str r2, [r3, #0x18]
	str r2, [r3, #0x1c]
	str r2, [r3, #0x20]
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	ldr r0, [r4, #0x12c]
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlAlphaAll
	mov r1, r5
	mov r0, r4
	mov r2, #0
	bl StageTask__SetParent
	ldr r1, [r4, #0x20]
	mov r0, #0
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0x28]
	ldr r1, _02175FF4 // =ovl02_2175FF8
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02175FE4: .word gameArchiveStage
_02175FE8: .word aBsef8WaveNsbmd_0
_02175FEC: .word aBsef8WaveNsbca_0
_02175FF0: .word 0x000034CC
_02175FF4: .word ovl02_2175FF8
	arm_func_end ovl02_2175ED4

	arm_func_start ovl02_2175FF8
ovl02_2175FF8: // _02175FF8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x54
	mov r4, r0
	ldr r3, [r4, #0x11c]
	add ip, r4, #0x44
	add r0, r3, #0x44
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r0, [r3, #0x5d8]
	tst r0, #0x200000
	bne _0217603C
	mov r1, #0x1f000
	ldr r0, _021760BC // =ovl02_2175BCC
	str r1, [r4, #0x2c]
	add sp, sp, #0x54
	str r0, [r4, #0xf4]
	ldmia sp!, {r3, r4, pc}
_0217603C:
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	cmp r0, #4
	addhs sp, sp, #0x54
	str r0, [r4, #0x28]
	ldmhsia sp!, {r3, r4, pc}
	ldr r0, _021760C0 // =_0217906C
	add r3, sp, #0x30
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r3, sp, #0x3c
	ldmia ip, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [sp, #0x40]
	add r0, sp, #0x48
	rsb r1, r1, #0
	str r1, [sp, #0x40]
	bl ovl02_2169EBC
	ldr r1, [sp, #0x4c]
	add r0, sp, #0x3c
	rsb r2, r1, #0
	str r2, [sp, #0x4c]
	add r1, sp, #0x48
	add r2, sp, #0x30
	add r3, sp, #0
	bl Unknown2066510__Func_2066A4C
	ldr r1, [r4, #0x12c]
	add r0, sp, #0
	add r1, r1, #0x24
	bl MI_Copy36B
	add sp, sp, #0x54
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021760BC: .word ovl02_2175BCC
_021760C0: .word _0217906C
	arm_func_end ovl02_2175FF8

	arm_func_start ovl02_21760C4
ovl02_21760C4: // _021760C4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r0, #0x1a00
	mov r1, #4
	bl CreateStageTaskEx_
	mov r4, r0
	mov r1, #5
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x340
	bl StageTask__AllocateWorker
	ldr r1, [r4, #0x18]
	mov r5, r0
	orr r0, r1, #2
	str r0, [r4, #0x18]
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x1a0
	str r1, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	mov r1, r6
	orr r2, r2, #0x2100
	str r2, [r4, #0x1c]
	mov r2, #0
	bl StageTask__SetParent
	mov r3, #0
_0217612C:
	add r0, r3, #1
	and r2, r3, #3
	add r1, r5, r3, lsl #1
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	rsb r2, r2, #0
	add r0, r1, #0x300
	strh r2, [r0]
	cmp r3, #0x20
	blo _0217612C
	mov r0, #0
	str r0, [r4, #0x28]
	ldr r1, _02176170 // =ovl02_2176174
	str r0, [r4, #0x2c]
	mov r0, r4
	str r1, [r4, #0xf4]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02176170: .word ovl02_2176174
	arm_func_end ovl02_21760C4

	arm_func_start ovl02_2176174
ovl02_2176174: // _02176174
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x50
	ldr r5, [r0, #0x11c]
	ldr r6, [r0, #0x124]
	add r1, r5, #0x44
	add r3, r0, #0x44
	str r0, [sp]
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r5, #0x5d8]
	tst r0, #0x200000
	bne _021761C4
	ldr r0, [sp]
	ldr r0, [r0, #0x2c]
	add r1, r0, #1
	ldr r0, [sp]
	cmp r1, #0x10
	str r1, [r0, #0x2c]
	movgt r1, #1
	strgt r1, [r0, #0x28]
_021761C4:
	bl NNS_G3dGlbFlushVP
	mov r1, #0
	mov r2, r1
	mov r0, #0x15
	bl NNS_G3dGeBufferOP_N
	mov r3, #0x20000000
	add r1, sp, #0x1c
	mov r0, #0x2a
	mov r2, #1
	str r3, [sp, #0x1c]
	bl NNS_G3dGeBufferOP_N
	add r2, sp, #0x20
	mov r1, #0
	add r0, sp, #0x2c
	str r1, [r2]
	str r1, [r2, #4]
	str r1, [r2, #8]
	mov r1, #1
	str r1, [sp, #4]
	bl ovl02_2169EBC
	add r0, r5, #0x44
	str r0, [sp, #8]
	mvn r0, #0x63
	mov r7, #0
	add r4, r6, #0x180
	add r5, sp, #0x20
	str r0, [sp, #0x10]
_02176230:
	add r0, r6, r7, lsl #1
	add r0, r0, #0x300
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _021764A8
	mov r0, #0xc
	mul r9, r7, r0
	add r8, r6, r9
	add r0, r8, #0x180
	str r0, [sp, #0x14]
	add r0, sp, #0x2c
	ldmia r0, {r0, r1, r2}
	stmia r8, {r0, r1, r2}
	ldr r0, _02176624 // =_mt_math_rand
	ldr r1, _02176628 // =0x00196225
	ldr r2, [r0, #0]
	ldr r0, _0217662C // =0x3C6EF35F
	mla r1, r2, r1, r0
	ldr r0, _02176624 // =_mt_math_rand
	str r1, [r0]
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r3, r0, lsl #1
	ldr r0, _02176630 // =FX_SinCosTable_
	mov r1, r3, lsl #1
	ldrsh r2, [r0, r1]
	add r0, r0, r3, lsl #1
	mov r3, #0x60000
	umull ip, r3, r2, r3
	adds r10, ip, #0x800
	mov ip, #0
	mla r3, r2, ip, r3
	mov r1, r2, asr #0x1f
	mov ip, #0x60000
	mla r3, r1, ip, r3
	ldr r11, [r6, r9]
	mov r10, r10, lsr #0xc
	adc r3, r3, #0
	orr r10, r10, r3, lsl #20
	add r3, r11, r10
	str r3, [r6, r9]
	mov ip, #0
	ldrsh r11, [r0, #2]
	mov r0, #0xc8000
	mov r10, ip
	umull lr, r0, r2, r0
	mla r0, r2, r10, r0
	mov r2, #0xc8000
	mla r0, r1, r2, r0
	mov r1, #0x60000
	umull ip, r1, r11, r1
	adds r2, ip, #0x800
	mov ip, #0
	mla r1, r11, ip, r1
	mov r10, r11, asr #0x1f
	mov ip, #0x60000
	mla r1, r10, ip, r1
	ldr r3, [r8, #4]
	mov r2, r2, lsr #0xc
	adc r1, r1, #0
	orr r2, r2, r1, lsl #20
	add r1, r3, r2
	adds r2, lr, #0x800
	mov ip, #0
	str r1, [r8, #4]
	mov r1, ip
	mov r3, r2, lsr #0xc
	adc r0, r0, r1
	orr r3, r3, r0, lsl #20
	mov r0, #0xc8000
	mov r2, ip
	umull r1, r0, r11, r0
	mla r0, r11, r2, r0
	mov r2, #0xc8000
	mla r0, r10, r2, r0
	adds r2, r1, #0x800
	mov r1, ip
	adc r0, r0, r1
	mov r10, r2, lsr #0xc
	orr r10, r10, r0, lsl #20
	ldr r0, [sp, #8]
	ldmia r0, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x24]
	add r1, r1, r3
	add r0, r0, r10
	ldr r3, [sp, #0x14]
	str r1, [sp, #0x20]
	str r0, [sp, #0x24]
	ldmia r5, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r8, #4]
	ldr r0, [r8, #0x184]
	subs r0, r1, r0
	rsbmi r0, r0, #0
	cmp r0, #0x100000
	ble _021764A8
	add r0, r6, r9
	add r1, r4, r9
	mov r2, r5
	bl VEC_Subtract
	add r0, r6, r9
	ldr r9, [sp, #0x20]
	ldr r3, [sp, #0x28]
	mov r2, r8
	mov r8, r3, asr #0x1f
	str r8, [sp, #0xc]
	mov r8, #0x700
	umull r10, lr, r9, r8
	adds r8, r10, #0x800
	mov r10, #0
	mla lr, r9, r10, lr
	ldr ip, [sp, #0x24]
	mov r11, r9, asr #0x1f
	mov r10, #0x700
	mla lr, r11, r10, lr
	mov r8, r8, lsr #0xc
	adc r10, lr, #0
	orr r8, r8, r10, lsl #20
	sub r8, r9, r8
	str r8, [sp, #0x20]
	mov r8, #0x700
	umull r10, r8, ip, r8
	adds r9, r10, #0x800
	mov r10, #0
	mov r1, ip, asr #0x1f
	str r1, [sp, #0x18]
	mla r8, ip, r10, r8
	ldr r10, [sp, #0x18]
	mov r11, #0x700
	mla r8, r10, r11, r8
	mov r9, r9, lsr #0xc
	adc r8, r8, #0
	orr r9, r9, r8, lsl #20
	sub r8, ip, r9
	str r8, [sp, #0x24]
	mov r8, r11
	umull r10, r8, r3, r8
	adds r9, r10, #0x800
	mov r10, #0
	mla r8, r3, r10, r8
	ldr r11, [sp, #0xc]
	mov r10, #0x700
	mla r8, r11, r10, r8
	mov r9, r9, lsr #0xc
	adc r8, r8, #0
	orr r9, r9, r8, lsl #20
	sub r3, r3, r9
	mov r1, r5
	str r3, [sp, #0x28]
	bl VEC_Subtract
_021764A8:
	add r0, r6, r7, lsl #1
	add r10, r0, #0x300
	ldrsh r0, [r10, #0]
	cmp r0, #0
	blt _021765DC
	mov r0, #0xc
	mul r8, r7, r0
	add r9, r6, r8
	add r3, sp, #0x44
	ldmia r9, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [sp, #0x48]
	add r11, r9, #0x180
	rsb r0, r0, #0
	str r0, [sp, #0x48]
	add r3, sp, #0x38
	ldmia r11, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [sp, #0x3c]
	ldr r2, _02176634 // =0x00007FFF
	rsb r1, r1, #0
	str r1, [sp, #0x3c]
	ldrsh r3, [r10, #0]
	add r0, sp, #0x44
	add r1, sp, #0x38
	mov r3, r3, lsl #2
	rsb r3, r3, #0x10
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	bl ovl02_2178294
	mov r0, r9
	add r1, r4, r8
	mov r2, r5
	bl VEC_Subtract
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x24]
	mov r1, r1, asr #2
	str r1, [sp, #0x20]
	ldr r1, [sp, #0x28]
	mov r0, r0, asr #2
	mov r1, r1, asr #2
	str r0, [sp, #0x24]
	str r1, [sp, #0x28]
	mov r2, r9
	mov r0, r9
	mov r1, r5
	bl VEC_Subtract
	add r0, r4, r8
	mov r2, r0
	mov r1, r5
	bl VEC_Subtract
	ldr r0, [sp]
	ldr r0, [r0, #0x2c]
	cmp r0, #0
	beq _0217658C
	cmp r0, #0xc
	blt _021765A0
_0217658C:
	add r0, r6, r7, lsl #1
	add r0, r0, #0x300
	ldrsh r1, [r0, #0]
	add r1, r1, #1
	strh r1, [r0]
_021765A0:
	add r0, r6, r7, lsl #1
	add r1, r0, #0x300
	ldrsh r0, [r1, #0]
	cmp r0, #4
	ble _021765D0
	ldr r0, [sp]
	ldr r0, [r0, #0x28]
	cmp r0, #0
	ldrne r0, [sp, #0x10]
	strneh r0, [r1]
	moveq r0, #0
	streqh r0, [r1]
_021765D0:
	mov r0, #0
	str r0, [sp, #4]
	b _021765E4
_021765DC:
	add r0, r0, #1
	strh r0, [r10]
_021765E4:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #0x20
	blo _02176230
	ldr r0, [sp, #4]
	cmp r0, #0
	addeq sp, sp, #0x50
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp]
	ldr r0, [r0, #0x18]
	orr r1, r0, #4
	ldr r0, [sp]
	str r1, [r0, #0x18]
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02176624: .word _mt_math_rand
_02176628: .word 0x00196225
_0217662C: .word 0x3C6EF35F
_02176630: .word FX_SinCosTable_
_02176634: .word 0x00007FFF
	arm_func_end ovl02_2176174

	arm_func_start ovl02_2176638
ovl02_2176638: // _02176638
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	mov r0, #0x1a00
	mov r1, #4
	bl CreateStageTaskEx_
	mov r1, #5
	mov r4, r0
	bl StageTask__SetType
	mov r1, #0
	ldr r0, _021766F0 // =gameArchiveStage
	str r1, [sp]
	ldr r3, [r0, #0]
	ldr r2, _021766F4 // =aBsef8ZJetNsbmd_0
	mov r0, r4
	str r3, [sp, #4]
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r0, [r4, #0x18]
	mov r1, r5
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	ldr r3, _021766F8 // =0x000034CC
	orr r0, r0, #0x180
	str r0, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	mov r0, r4
	orr r2, r2, #0x2100
	str r2, [r4, #0x1c]
	ldr ip, [r4, #0x12c]
	mov r2, #0x400
	str r3, [ip, #0x18]
	str r3, [ip, #0x1c]
	str r3, [ip, #0x20]
	bl StageTask__SetParent
	ldr r1, [r4, #0x20]
	mov r0, #0x10000
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0x28]
	ldr r1, _021766FC // =ovl02_2176700
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021766F0: .word gameArchiveStage
_021766F4: .word aBsef8ZJetNsbmd_0
_021766F8: .word 0x000034CC
_021766FC: .word ovl02_2176700
	arm_func_end ovl02_2176638

	arm_func_start ovl02_2176700
ovl02_2176700: // _02176700
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x11c]
	ldr r0, _021767FC // =ovl02_2174F10
	ldr r1, [r4, #0xf4]
	cmp r1, r0
	moveq r0, #0x2000
	streq r0, [r6, #0x40]
	beq _02176738
	ldr r0, [r4, #0x340]
	ldrb r0, [r0, #8]
	cmp r0, #0
	movne r0, #0x1000
	strne r0, [r6, #0x40]
_02176738:
	ldr r0, [r6, #0x20]
	tst r0, #0x20
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, [r6, #0x2c]
	tst r0, #4
	beq _0217675C
	tst r0, #2
	mov r0, #0x1000
	b _02176764
_0217675C:
	tst r0, #2
	mov r0, #0xa00
_02176764:
	movne r0, #0x600
	str r0, [r6, #0x38]
	str r0, [r6, #0x3c]
	ldr r0, [r6, #0x2c]
	tst r0, #0x10
	mov r0, r0, lsl #1
	andeq r5, r0, #0x1f
	beq _02176794
	and r0, r0, #0x1f
	rsb r0, r0, #0x1f
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
_02176794:
	cmp r5, #0
	ldreq r0, [r6, #0x20]
	mov r1, #5
	orreq r0, r0, #0x20
	streq r0, [r6, #0x20]
	ldr r0, [r6, #0x2c]
	add r0, r0, #1
	str r0, [r6, #0x2c]
	ldr r0, [r6, #0x12c]
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlPolygonIDAll
	ldr r0, [r6, #0x12c]
	mov r1, r5
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlAlphaAll
	ldr r0, [r4, #0x12c]
	ldr r1, [r6, #0x12c]
	add r5, r0, #0x24
	add r4, r1, #0x24
	ldmia r5!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia r5!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldr r0, [r5, #0]
	str r0, [r4]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021767FC: .word ovl02_2174F10
	arm_func_end ovl02_2176700

	arm_func_start ovl02_2176800
ovl02_2176800: // _02176800
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	mov r0, #0x1a00
	mov r1, #4
	bl CreateStageTaskEx_
	mov r1, #5
	mov r4, r0
	bl StageTask__SetType
	mov r1, #0
	ldr r0, _02176940 // =gameArchiveStage
	str r1, [sp]
	ldr r3, [r0, #0]
	ldr r2, _02176944 // =aBsef8Float1Nsb_3
	mov r0, r4
	str r3, [sp, #4]
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, _02176940 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	mov r1, #0
	str r2, [sp]
	ldr r2, _02176948 // =aBsef8Float1Nsb_4
	mov r3, r1
	bl ObjAction3dNNMotionLoad
	ldr r1, _02176940 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	mov r1, #0
	str r2, [sp]
	ldr r2, _0217694C // =aBsef8Float1Nsb_5
	mov r3, r1
	bl ObjAction3dNNMotionLoad
	ldr r1, _02176940 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	mov r1, #0
	str r2, [sp]
	ldr r2, _02176950 // =aBsef8Float1Nsb_6
	mov r3, r1
	bl ObjAction3dNNMotionLoad
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x12c]
	mov r3, #0
	str r3, [sp]
	mov r1, #4
	ldr r2, [r0, #0x158]
	bl AnimatorMDL__SetAnimation
	ldr r0, [r4, #0x12c]
	mov r3, #0
	str r3, [sp]
	mov r1, #1
	ldr r2, [r0, #0x14c]
	bl AnimatorMDL__SetAnimation
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x18]
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x180
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	mov r3, #0x1a
	mov r0, r4
	mov r1, r5
	mov r2, #0
	str r3, [r4, #0x2c]
	bl StageTask__SetParent
	ldr r1, _02176954 // =ovl02_2176958
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02176940: .word gameArchiveStage
_02176944: .word aBsef8Float1Nsb_3
_02176948: .word aBsef8Float1Nsb_4
_0217694C: .word aBsef8Float1Nsb_5
_02176950: .word aBsef8Float1Nsb_6
_02176954: .word ovl02_2176958
	arm_func_end ovl02_2176800

	arm_func_start ovl02_2176958
ovl02_2176958: // _02176958
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _02176A18 // =BossFStage__Singleton
	mov r4, r0
	ldr r5, [r4, #0x11c]
	ldr r0, [r1, #0]
	bl GetTaskWork_
	ldr ip, [r5, #0x124]
	ldr r1, [r4, #0x12c]
	add r6, ip, #0x1b8
	mov lr, r0
	add r5, r1, #0x24
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldr r0, [r6, #0]
	str r0, [r5]
	ldr r0, [ip, #0x1e0]
	ldr r2, [ip, #0x1e4]
	rsb r1, r0, #0
	ldr r0, [ip, #0x1dc]
	str r0, [r4, #0x44]
	str r1, [r4, #0x48]
	str r2, [r4, #0x4c]
	ldr r0, [lr, #0x384]
	tst r0, #0x400
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #4
	strne r0, [r4, #0x18]
	ldr r0, [lr, #0x384]
	tst r0, #0x10
	beq _021769E8
	ldr r0, [r4, #0x20]
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	ldmia sp!, {r4, r5, r6, pc}
_021769E8:
	tst r0, #1
	bne _02176A08
	ldr r0, [r4, #0x2c]
	subs r0, r0, #1
	str r0, [r4, #0x2c]
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #4
	streq r0, [r4, #0x18]
_02176A08:
	mov r0, r4
	mov r1, #0
	bl ovl02_2169E34
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02176A18: .word BossFStage__Singleton
	arm_func_end ovl02_2176958

	arm_func_start ovl02_2176A1C
ovl02_2176A1C: // _02176A1C
	ldr ip, _02176A28 // =ovl02_2169E34
	mov r1, #0
	bx ip
	.align 2, 0
_02176A28: .word ovl02_2169E34
	arm_func_end ovl02_2176A1C

	arm_func_start ovl02_2176A2C
ovl02_2176A2C: // _02176A2C
	ldr ip, _02176A38 // =ovl02_2169E34
	mov r1, #1
	bx ip
	.align 2, 0
_02176A38: .word ovl02_2169E34
	arm_func_end ovl02_2176A2C

	arm_func_start ovl02_2176A3C
ovl02_2176A3C: // _02176A3C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r0, #0x4800
	mov r1, #4
	bl CreateStageTaskEx_
	mov r1, #5
	mov r4, r0
	bl StageTask__SetType
	ldr r3, _02176B44 // =0x0000FFFF
	mov r1, #0
	str r3, [sp]
	ldr r0, _02176B48 // =gameArchiveStage
	str r1, [sp, #4]
	ldr r0, [r0, #0]
	ldr r2, _02176B4C // =aBsef8TargetBac_0
	str r0, [sp, #8]
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x134]
	mov r1, #0x1d
	strb r1, [r0, #0xa]
	ldr r0, [r4, #0x134]
	mov r1, #7
	strb r1, [r0, #0xb]
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x20000
	str r1, [r4, #0x20]
	mov r1, #0
	bl StageTask__SetAnimation
	mov r1, r5
	ldr r2, [r4, #0x18]
	mov r0, r4
	orr r2, r2, #2
	str r2, [r4, #0x18]
	ldr r3, [r4, #0x20]
	mov r2, #0
	orr r3, r3, #0x180
	str r3, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	orr r3, r3, #0x2100
	str r3, [r4, #0x1c]
	bl StageTask__SetParent
	mov r0, #1
	str r0, [r4, #0x2c]
	ldr r0, _02176B50 // =ovl02_2176B60
	ldr r3, _02176B54 // =_mt_math_rand
	str r0, [r4, #0xf4]
	ldr r5, [r3, #0]
	ldr r1, _02176B58 // =0x00196225
	ldr r2, _02176B5C // =0x3C6EF35F
	mov r0, r4
	mla r1, r5, r1, r2
	str r1, [r3]
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #3
	ldr r2, [r4, #0x24]
	orr r1, r2, r1
	str r1, [r4, #0x24]
	bl ovl02_21772A8
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02176B44: .word 0x0000FFFF
_02176B48: .word gameArchiveStage
_02176B4C: .word aBsef8TargetBac_0
_02176B50: .word ovl02_2176B60
_02176B54: .word _mt_math_rand
_02176B58: .word 0x00196225
_02176B5C: .word 0x3C6EF35F
	arm_func_end ovl02_2176A3C

	arm_func_start ovl02_2176B60
ovl02_2176B60: // _02176B60
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	ldr r0, _02176E80 // =BossFStage__Singleton
	ldr r5, [r4, #0x11c]
	ldr r0, [r0, #0]
	ldr r6, [r5, #0x124]
	bl GetTaskWork_
	mov r1, #0x80000
	str r1, [r4, #0x44]
	mov r1, #0x60000
	str r1, [r4, #0x48]
	mov r7, r0
	ldrh r0, [r6, #8]
	mov r1, #0x1f80
	bl FX_Div
	cmp r0, #0x1000
	blt _02176BC8
	ldr r1, [r4, #0x1c]
	mov r0, #0x1000
	tst r1, #0x2000
	beq _02176BC8
	bic r1, r1, #0x2000
	str r1, [r4, #0x1c]
	mov r1, #0x8000
	str r1, [r4, #4]
	str r1, [r4, #8]
_02176BC8:
	mov r1, #0x110000
	mov r2, #0
	umull ip, r3, r0, r1
	mla r3, r0, r2, r3
	mov r0, r0, asr #0x1f
	mla r3, r0, r1, r3
	adds r2, ip, #0x800
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x28]
	ldr r0, [r4, #0x48]
	cmp r1, #0x88000
	sublo r0, r0, r1
	blo _02176C14
	add r1, r0, #0x110000
	str r1, [r4, #0x48]
	ldr r0, [r4, #0x28]
	sub r0, r1, r0
_02176C14:
	str r0, [r4, #0x48]
	ldr r0, [r4, #8]
	cmp r0, #0
	bne _02176DE8
	ldr r0, [r4, #0x1c]
	tst r0, #0x2000
	bne _02176DE8
	bl ovl02_2169F80
	add r7, r7, #0x300
	ldrh ip, [r7, #0x80]
	mov r2, #0x100
	cmp r0, #3
	addeq r2, r2, #0x40
	cmp ip, #0
	movne r7, #0x24
	mulne r7, ip, r7
	subne r2, r2, r7
	ldr r7, [r6, #0x18]
	mov r3, #0
	sub r7, r7, #8
	mul r2, r7, r2
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r1, #0x38000
	cmp r0, #3
	mov r7, r2
	addls pc, pc, r0, lsl #2
	b _02176CE0
_02176C84: // jump table
	b _02176C94 // case 0
	b _02176CA0 // case 1
	b _02176CB4 // case 2
	b _02176CC8 // case 3
_02176C94:
	mov r2, #0
	mov r0, #0x60000
	b _02176CF8
_02176CA0:
	mov r0, r2, lsl #0x11
	mov r7, r0, lsr #0x10
	mov r0, #0x48000
	mov r1, #0x40000
	b _02176CF8
_02176CB4:
	mov r0, r2, lsl #0x11
	mov r2, r0, lsr #0x10
	mov r0, #0x5a000
	mov r1, #0x48000
	b _02176CF8
_02176CC8:
	mov r0, r2, lsl #0x12
	mov r2, r2, lsl #0x11
	mov r7, r0, lsr #0x10
	mov r2, r2, lsr #0x10
	mov r0, #0x40000
	b _02176CF8
_02176CE0:
	mov r0, r7, lsl #0x13
	mov r1, r2, lsl #0x12
	mov r7, r0, lsr #0x10
	mov r2, r1, lsr #0x10
	mov r0, #0x40000
	mov r1, #0x30000
_02176CF8:
	ldr ip, [r4, #0x24]
	mov r2, r2, lsl #0x10
	tst ip, #1
	rsbne r0, r0, #0
	tst ip, #2
	mov ip, r2, lsr #0x10
	mov r7, r7, lsl #0x10
	mov r2, r7, lsr #0x10
	mov ip, ip, asr #4
	mov r2, r2, asr #4
	ldr r7, _02176E84 // =FX_SinCosTable_
	mov ip, ip, lsl #2
	mov r2, r2, lsl #2
	ldrsh ip, [r7, ip]
	ldrsh r7, [r7, r2]
	rsbne r1, r1, #0
	smull lr, ip, r1, ip
	smull r7, r1, r0, r7
	adds lr, lr, #0x800
	adc r0, ip, #0
	mov ip, lr, lsr #0xc
	adds r7, r7, #0x800
	orr ip, ip, r0, lsl #20
	adc r0, r1, #0
	mov r1, r7, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r1, r3, r1
	ldr r2, [r4, #0x44]
	sub r3, r3, ip
	add r0, r2, r1
	str r0, [r4, #0x44]
	ldr r0, [r4, #0x48]
	add r0, r0, r3
	str r0, [r4, #0x48]
	ldr r0, [r6, #0x18]
	cmp r0, #0x14
	bls _02176DE8
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r1, #0x10000
	bgt _02176DCC
	cmp r3, #0
	rsblt r3, r3, #0
	cmp r3, #0x10000
	bgt _02176DCC
	mov r0, #0x1200
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	ldr r0, [r4, #0x24]
	orr r0, r0, #8
	str r0, [r4, #0x24]
	b _02176DE8
_02176DCC:
	mov r0, #0x1000
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	ldr r0, [r4, #0x24]
	bic r0, r0, #8
	str r0, [r4, #0x24]
_02176DE8:
	ldr r0, [r4, #0x2c]
	cmp r0, #0x1f
	bgt _02176E18
	ldr r2, [r4, #0x134]
	mov r0, r0, lsl #0x1b
	ldr r1, [r2, #0xf4]
	bic r1, r1, #0x1f0000
	orr r0, r1, r0, lsr #11
	str r0, [r2, #0xf4]
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
_02176E18:
	ldr r1, [r5, #0xf4]
	ldr r0, _02176E88 // =ovl02_21736C8
	cmp r1, r0
	beq _02176E58
	ldr r0, [r5, #0x24]
	tst r0, #8
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #4
	streq r0, [r4, #0x18]
	beq _02176E58
	mov r0, #0
	str r0, [r4, #0x2c]
	mov r1, #0x8000
	ldr r0, _02176E8C // =ovl02_2177040
	str r1, [r4, #4]
	str r0, [r4, #0xf4]
_02176E58:
	ldr r0, [r4, #0x28]
	cmp r0, #0x88000
	mov r0, r4
	bhs _02176E74
	mov r1, #1
	bl ovl02_2169E34
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02176E74:
	mov r1, #0
	bl ovl02_2169E34
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02176E80: .word BossFStage__Singleton
_02176E84: .word FX_SinCosTable_
_02176E88: .word ovl02_21736C8
_02176E8C: .word ovl02_2177040
	arm_func_end ovl02_2176B60

	arm_func_start ovl02_2176E90
ovl02_2176E90: // _02176E90
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r0, #0x4800
	mov r1, #4
	bl CreateStageTaskEx_
	mov r1, #5
	mov r4, r0
	bl StageTask__SetType
	ldr r3, _02176F7C // =0x0000FFFF
	mov r1, #0
	str r3, [sp]
	ldr r0, _02176F80 // =gameArchiveStage
	str r1, [sp, #4]
	ldr r0, [r0, #0]
	ldr r2, _02176F84 // =aBsef8TargetBac_0
	str r0, [sp, #8]
	mov r0, r4
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x134]
	mov r1, #0x1d
	strb r1, [r0, #0xa]
	ldr r0, [r4, #0x134]
	mov r1, #7
	strb r1, [r0, #0xb]
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x20000
	str r1, [r4, #0x20]
	mov r1, #1
	bl StageTask__SetAnimation
	mov r1, r5
	ldr r2, [r4, #0x18]
	mov r0, r4
	orr r2, r2, #2
	str r2, [r4, #0x18]
	ldr r3, [r4, #0x20]
	mov r2, #0
	orr r3, r3, #0x1a0
	str r3, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	orr r3, r3, #0x2100
	str r3, [r4, #0x1c]
	bl StageTask__SetParent
	mov r0, #0x2000
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	mov r0, #0x80000
	str r0, [r4, #0x44]
	mov r0, #0x60000
	str r0, [r4, #0x48]
	mov r0, #0
	str r0, [r4, #0x2c]
	ldr r1, _02176F88 // =ovl02_2176F8C
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02176F7C: .word 0x0000FFFF
_02176F80: .word gameArchiveStage
_02176F84: .word aBsef8TargetBac_0
_02176F88: .word ovl02_2176F8C
	arm_func_end ovl02_2176E90

	arm_func_start ovl02_2176F8C
ovl02_2176F8C: // _02176F8C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x2c]
	ldr r4, [r5, #0x11c]
	cmp r0, #0x38
	ble _02176FE0
	mov r0, #0x40
	str r0, [sp]
	ldr r0, [r5, #0x38]
	mov r1, #0x1000
	mov r2, #2
	mov r3, #0
	bl ObjShiftSet
	mov r2, r0
	str r2, [r5, #0x38]
	str r2, [r5, #0x3c]
	mov r0, r5
	mov r1, #0
	str r2, [r5, #0x40]
	bl ovl02_2169E34
	b _02176FF4
_02176FE0:
	add r0, r0, #1
	str r0, [r5, #0x2c]
	ldr r0, [r5, #0x20]
	orr r0, r0, #0x20
	str r0, [r5, #0x20]
_02176FF4:
	ldr r1, [r4, #0xf4]
	ldr r0, _02177038 // =ovl02_21736C8
	cmp r1, r0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x24]
	tst r0, #8
	ldreq r0, [r5, #0x18]
	orreq r0, r0, #4
	streq r0, [r5, #0x18]
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, #0
	str r0, [r5, #0x2c]
	mov r1, #0x8000
	ldr r0, _0217703C // =ovl02_2177040
	str r1, [r5, #4]
	str r0, [r5, #0xf4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02177038: .word ovl02_21736C8
_0217703C: .word ovl02_2177040
	arm_func_end ovl02_2176F8C

	arm_func_start ovl02_2177040
ovl02_2177040: // _02177040
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r1, #0x40
	str r1, [sp]
	mov r4, r0
	ldr r0, [r4, #0x38]
	mov r1, #0x4000
	mov r2, #2
	mov r3, #0
	bl ObjShiftSet
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	ldr r0, [r4, #0x2c]
	ldr r2, [r4, #0x134]
	mov r0, r0, lsl #3
	rsb r0, r0, #0x1f
	ldr r1, [r2, #0xf4]
	cmp r0, #1
	movlt r0, #1
	mov r0, r0, lsl #0x1b
	bic r1, r1, #0x1f0000
	orr r0, r1, r0, lsr #11
	str r0, [r2, #0xf4]
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x134]
	ldr r0, [r0, #0xf4]
	mov r0, r0, lsl #0xb
	mov r0, r0, lsr #0x1b
	cmp r0, #1
	bhi _021770DC
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x20
	str r0, [r4, #0x20]
_021770DC:
	mov r0, r4
	mov r1, #0
	bl ovl02_2169E34
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end ovl02_2177040

	arm_func_start ovl02_21770F0
ovl02_21770F0: // _021770F0
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	mov r0, #0x1a00
	mov r1, #4
	bl CreateStageTaskEx_
	mov r1, #5
	mov r4, r0
	bl StageTask__SetType
	mov r1, #0
	ldr r0, _02177248 // =gameArchiveStage
	str r1, [sp]
	ldr r3, [r0, #0]
	ldr r2, _0217724C // =aBsef8InNsbmd_0
	mov r0, r4
	str r3, [sp, #4]
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, _02177248 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	mov r1, #0
	str r2, [sp]
	ldr r2, _02177250 // =aBsef8InNsbca_0
	mov r3, r1
	bl ObjAction3dNNMotionLoad
	ldr r1, _02177248 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	mov r1, #0
	str r2, [sp]
	ldr r2, _02177254 // =aBsef8InNsbma_0
	mov r3, r1
	bl ObjAction3dNNMotionLoad
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x12c]
	mov r3, #0
	str r3, [sp]
	mov r1, #1
	ldr r2, [r0, #0x14c]
	bl AnimatorMDL__SetAnimation
	ldr r1, [r4, #0x20]
	add r0, r5, #0x44
	orr r1, r1, #4
	str r1, [r4, #0x20]
	add r3, r4, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x48]
	sub r0, r0, #0x10000
	str r0, [r4, #0x48]
	ldr r1, [r4, #0x12c]
	ldr r0, [r5, #0x12c]
	add ip, r1, #0x24
	add lr, r0, #0x24
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r0, [lr]
	str r0, [ip]
	ldr r0, [r4, #0x18]
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x180
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	ldr ip, [r4, #0x12c]
	ldr r3, _02177258 // =0x000034CC
	mov r0, r4
	str r3, [ip, #0x18]
	str r3, [ip, #0x1c]
	mov r1, r5
	mov r2, #0
	str r3, [ip, #0x20]
	bl StageTask__SetParent
	ldr r1, _0217725C // =ovl02_2177260
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02177248: .word gameArchiveStage
_0217724C: .word aBsef8InNsbmd_0
_02177250: .word aBsef8InNsbca_0
_02177254: .word aBsef8InNsbma_0
_02177258: .word 0x000034CC
_0217725C: .word ovl02_2177260
	arm_func_end ovl02_21770F0

	arm_func_start ovl02_2177260
ovl02_2177260: // _02177260
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x12c]
	ldr r4, [r5, #0x11c]
	ldr r0, [r0, #0x94]
	mov r1, #0x10
	bl NNS_G3dMdlSetMdlAlphaAll
	ldr r1, [r4, #0xf4]
	ldr r0, _021772A4 // =ovl02_217344C
	cmp r1, r0
	ldrne r0, [r5, #0x18]
	mov r1, #1
	orrne r0, r0, #4
	strne r0, [r5, #0x18]
	mov r0, r5
	bl ovl02_2169E34
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021772A4: .word ovl02_217344C
	arm_func_end ovl02_2177260

	arm_func_start ovl02_21772A8
ovl02_21772A8: // _021772A8
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	mov r0, #0x1a00
	mov r1, #4
	bl CreateStageTaskEx_
	mov r1, #5
	mov r4, r0
	bl StageTask__SetType
	ldr r0, _0217738C // =gameArchiveStage
	mov r1, #0
	ldr r0, [r0, #0]
	ldr r3, _02177390 // =0x0000FFFF
	str r0, [sp]
	ldr r2, _02177394 // =aAcFixKeyBac_0
	mov r0, r4
	str r3, [sp, #4]
	mov r3, r1
	bl ObjObjectAction2dBACLoad
	ldr r1, [r4, #0x18]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x18]
	mov r1, #5
	mov r2, #0x5a
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #5
	bl StageTask__SetAnimation
	mov r1, r5
	ldr r2, [r4, #0x20]
	mov r0, r4
	orr r2, r2, #4
	str r2, [r4, #0x20]
	ldr r3, [r4, #0x18]
	mov r2, #0
	orr r3, r3, #2
	str r3, [r4, #0x18]
	ldr r3, [r4, #0x20]
	orr r3, r3, #0x1a0
	str r3, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	orr r3, r3, #0x2100
	str r3, [r4, #0x1c]
	bl StageTask__SetParent
	mov r0, #0x80000
	str r0, [r4, #0x44]
	mov r0, #0xa0000
	str r0, [r4, #0x48]
	mov r0, #0
	str r0, [r4, #0x2c]
	str r0, [r4, #0x28]
	ldr r1, _02177398 // =ovl02_217739C
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217738C: .word gameArchiveStage
_02177390: .word 0x0000FFFF
_02177394: .word aAcFixKeyBac_0
_02177398: .word ovl02_217739C
	arm_func_end ovl02_21772A8

	arm_func_start ovl02_217739C
ovl02_217739C: // _0217739C
	stmdb sp!, {r3, lr}
	ldr r2, [r0, #0x11c]
	ldr r1, [r2, #0x24]
	ldr r3, [r2, #0x11c]
	tst r1, #8
	beq _021773C8
	ldr r2, [r0, #0x20]
	mov r1, #1
	bic r2, r2, #0x20
	str r2, [r0, #0x20]
	str r1, [r0, #0x28]
_021773C8:
	ldr r2, [r3, #0xf4]
	ldr r1, _021773F8 // =ovl02_21736C8
	cmp r2, r1
	ldrne r1, [r0, #0x18]
	orrne r1, r1, #4
	strne r1, [r0, #0x18]
	ldr r1, [r0, #0x28]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	mov r1, #0
	bl ovl02_2169E34
	ldmia sp!, {r3, pc}
	.align 2, 0
_021773F8: .word ovl02_21736C8
	arm_func_end ovl02_217739C

	arm_func_start ovl02_21773FC
ovl02_21773FC: // _021773FC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r9, r0
	mov r7, r1
	mov r0, #0x1500
	mov r1, #2
	mov r6, r2
	bl CreateStageTaskEx_
	mov r5, r0
	mov r1, #6
	bl StageTask__SetType
	ldr r0, [r5, #0x120]
	mov r1, #0
	bl SetTaskPauseLevel
	mov r0, r5
	mov r1, #0x70
	bl StageTask__AllocateWorker
	mov r4, r0
	ldr r3, _021775BC // =0x0000FFFF
	mov r1, #0
	str r3, [sp]
	str r1, [sp, #4]
	ldr r2, _021775C0 // =gameArchiveStage
	mov r0, r5
	ldr r8, [r2, #0]
	ldr r2, _021775C4 // =aBsefBombBac_1
	str r8, [sp, #8]
	bl ObjObjectAction3dBACLoad
	mov r1, r9
	mov r2, #0x1d
	ldr r0, [r5, #0x134]
	mov r3, #7
	strb r2, [r0, #0xa]
	ldr r2, [r5, #0x134]
	ldr r0, _021775C8 // =ovl02_21722D8
	strb r3, [r2, #0xb]
	str r0, [r5, #0xfc]
	ldr r2, [r5, #0x18]
	mov r0, r5
	orr r2, r2, #0x12
	str r2, [r5, #0x18]
	ldr r3, [r5, #0x20]
	mov r2, #0
	orr r3, r3, #0x180
	str r3, [r5, #0x20]
	ldr r3, [r5, #0x1c]
	orr r3, r3, #0x100
	str r3, [r5, #0x1c]
	bl StageTask__SetParent
	add r3, r5, #0x44
	ldmia r7, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r5
	bl StageTask__InitSeqPlayer
	mov r0, r5
	mov r1, #0x80
	bl ovl02_217873C
	ldr r3, [r5, #0x44]
	ldr r2, [r5, #0x48]
	ldr r1, [r5, #0x4c]
	mov r0, #0
	str r3, [r4]
	str r2, [r4, #4]
	str r1, [r4, #8]
	str r0, [r4, #0x30]
	str r0, [r4, #0x34]
	str r0, [r4, #0x38]
	mov r0, #0x2000
	str r0, [r4, #0x60]
	ldr lr, [r6]
	ldr ip, [r6, #4]
	ldr r8, [r6, #8]
	sub r7, r1, #0x1000
	str r3, [r4, #0xc]
	str r2, [r4, #0x10]
	str r7, [r4, #0x14]
	str lr, [r4, #0x3c]
	str ip, [r4, #0x40]
	str r8, [r4, #0x44]
	str r0, [r4, #0x64]
	ldmia r6, {r8, lr}
	ldr ip, [r6, #8]
	sub r7, r1, #0x2000
	str r3, [r4, #0x18]
	str r2, [r4, #0x1c]
	str r7, [r4, #0x20]
	mov r7, r8, lsl #1
	str r7, [r4, #0x48]
	mov r7, lr, lsl #1
	str r7, [r4, #0x4c]
	mov r7, ip, lsl #1
	str r7, [r4, #0x50]
	str r0, [r4, #0x68]
	ldr ip, [r6]
	ldr r7, [r6, #4]
	ldr r6, [r6, #8]
	sub r1, r1, #0x3000
	str r3, [r4, #0x24]
	str r2, [r4, #0x28]
	str r1, [r4, #0x2c]
	mov r1, ip, lsl #2
	str r1, [r4, #0x54]
	mov r1, r7, lsl #2
	str r1, [r4, #0x58]
	mov r1, r6, lsl #2
	str r1, [r4, #0x5c]
	str r0, [r4, #0x6c]
	ldr r1, _021775CC // =ovl02_21775D0
	mov r0, r5
	str r1, [r5, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_021775BC: .word 0x0000FFFF
_021775C0: .word gameArchiveStage
_021775C4: .word aBsefBombBac_1
_021775C8: .word ovl02_21722D8
_021775CC: .word ovl02_21775D0
	arm_func_end ovl02_21773FC

	arm_func_start ovl02_21775D0
ovl02_21775D0: // _021775D0
	ldr r1, [r0, #0x20]
	tst r1, #8
	ldrne r1, [r0, #0x18]
	orrne r1, r1, #4
	strne r1, [r0, #0x18]
	bx lr
	arm_func_end ovl02_21775D0

	arm_func_start ovl02_21775E8
ovl02_21775E8: // _021775E8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr ip, _02177730 // =_mt_math_rand
	ldr r4, [r0, #0x124]
	ldr r1, _02177734 // =0x00196225
	ldr r5, [ip]
	ldr r2, _02177738 // =0x3C6EF35F
	add r0, r0, #0x44
	mla r3, r5, r1, r2
	mla r5, r3, r1, r2
	mla r6, r5, r1, r2
	mla lr, r6, r1, r2
	mov r5, r5, lsr #0x10
	ldmia r0, {r0, r1, r2}
	add r7, sp, #0
	stmia r7, {r0, r1, r2}
	mov r5, r5, lsl #0x10
	mov r0, r6, lsr #0x10
	mov r2, r5, lsr #0x10
	mov r1, r0, lsl #0x10
	and r6, r2, #0xff
	mov r2, r1, lsr #0x10
	mov r1, lr, lsr #0x10
	mov r3, r3, lsr #0x10
	mov r0, r3, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr r3, [sp, #8]
	and r0, r0, #0xff
	mov r1, r1, lsl #0x10
	and r5, r2, #0x1f
	mov r2, r1, lsr #0x10
	ldr r7, [sp, #4]
	rsb r1, r6, #0
	add r6, r7, r1, lsl #12
	rsb r1, r5, #0
	add r5, r6, r1, lsl #12
	ldr r1, [sp]
	rsb r0, r0, #0x80
	add r1, r1, r0, lsl #12
	mov r0, r2, lsl #0x1a
	add r3, r3, #0x80000
	add r3, r3, r0, lsr #14
	rsb r2, r5, #0
	mov r0, #0
	str r1, [sp]
	str r5, [sp, #4]
	str lr, [ip]
	str r3, [sp, #8]
	bl BossFX__CreateBomb
	cmp r0, #0
	beq _02177708
	ldr r5, _02177730 // =_mt_math_rand
	mov lr, #0x1800
	ldr ip, [r5]
	ldr r1, _02177734 // =0x00196225
	ldr r2, _02177738 // =0x3C6EF35F
	ldr r3, _0217773C // =0x00000FFF
	mla r2, ip, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	and r1, r3, r1, lsr #16
	str r2, [r5]
	add r1, r1, #0x1800
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	str r1, [r0, #0x40]
	sub r1, lr, #0x3800
	str r1, [r0, #0x9c]
	mov r1, #0x2000
	str r1, [r0, #0xa0]
	mov r1, #0xc0
	str r1, [r0, #0xa8]
_02177708:
	add r0, r4, #0x100
	ldrh r0, [r0, #0x8e]
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	mov r0, #0
	mov r1, #0x99
	bl ovl02_217873C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02177730: .word _mt_math_rand
_02177734: .word 0x00196225
_02177738: .word 0x3C6EF35F
_0217773C: .word 0x00000FFF
	arm_func_end ovl02_21775E8

	arm_func_start ovl02_2177740
ovl02_2177740: // _02177740
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	mov r0, #0x1a00
	mov r1, #4
	bl CreateStageTaskEx_
	mov r1, #5
	mov r4, r0
	bl StageTask__SetType
	mov r1, #0
	ldr r0, _0217782C // =gameArchiveStage
	str r1, [sp]
	ldr r3, [r0, #0]
	ldr r2, _02177830 // =aBsef8BFlash1Ns_1
	mov r0, r4
	str r3, [sp, #4]
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, _0217782C // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	mov r1, #0
	str r2, [sp]
	ldr r2, _02177834 // =aBsef8BFlash1Ns_2
	mov r3, r1
	bl ObjAction3dNNMotionLoad
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	mov r1, r5
	ldr r0, [r4, #0x20]
	ldr ip, _02177838 // =0x000034CC
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x18]
	mov r3, #0x1800
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r2, [r4, #0x20]
	mov r0, r4
	orr r2, r2, #0x180
	str r2, [r4, #0x20]
	ldr lr, [r4, #0x1c]
	mov r2, #0
	orr lr, lr, #0x2100
	str lr, [r4, #0x1c]
	ldr lr, [r4, #0x12c]
	str ip, [lr, #0x18]
	str ip, [lr, #0x1c]
	str ip, [lr, #0x20]
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	str r3, [r4, #0x40]
	bl StageTask__SetParent
	ldr r1, _0217783C // =ovl02_2177840
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217782C: .word gameArchiveStage
_02177830: .word aBsef8BFlash1Ns_1
_02177834: .word aBsef8BFlash1Ns_2
_02177838: .word 0x000034CC
_0217783C: .word ovl02_2177840
	arm_func_end ovl02_2177740

	arm_func_start ovl02_2177840
ovl02_2177840: // _02177840
	ldr r1, [r0, #0x11c]
	ldr r1, [r1, #0x124]
	ldr r2, [r1, #0x210]
	ldr r3, [r1, #0x214]
	ldr r1, [r1, #0x20c]
	rsb r2, r2, #0
	str r1, [r0, #0x44]
	str r2, [r0, #0x48]
	str r3, [r0, #0x4c]
	bx lr
	arm_func_end ovl02_2177840

	arm_func_start ovl02_2177868
ovl02_2177868: // _02177868
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r7, r0
	mov r4, r1
	mov r0, #0x1a00
	mov r1, #4
	bl CreateStageTaskEx_
	mov r6, r0
	mov r1, #5
	bl StageTask__SetType
	mov r0, r6
	mov r1, #0x12
	bl StageTask__AllocateWorker
	mov r1, #0
	mov r5, r0
	ldr r2, _02177A70 // =gameArchiveStage
	str r1, [sp]
	ldr r3, [r2, #0]
	ldr r2, _02177A74 // =aBsef8BeamNsbmd_0
	str r3, [sp, #4]
	mov r0, r6
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, _02177A70 // =gameArchiveStage
	mov r0, r6
	ldr r2, [r1, #0]
	mov r1, #0
	str r2, [sp]
	ldr r2, _02177A78 // =aBsef8BeamNsbca_0
	mov r3, r1
	bl ObjAction3dNNMotionLoad
	ldr r1, _02177A70 // =gameArchiveStage
	mov r0, r6
	ldr r2, [r1, #0]
	mov r1, #0
	str r2, [sp]
	ldr r2, _02177A7C // =aBsef8BeamNsbta_0
	mov r3, r1
	bl ObjAction3dNNMotionLoad
	ldr r1, _02177A70 // =gameArchiveStage
	mov r0, r6
	ldr r2, [r1, #0]
	mov r1, #0
	str r2, [sp]
	ldr r2, _02177A80 // =aBsef8BeamNsbma_0
	mov r3, r1
	bl ObjAction3dNNMotionLoad
	mov r0, r6
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r0, [r6, #0x12c]
	mov r3, #0
	str r3, [sp]
	ldr r2, [r0, #0x154]
	mov r1, #3
	bl AnimatorMDL__SetAnimation
	ldr r0, [r6, #0x12c]
	mov r3, #0
	str r3, [sp]
	ldr r2, [r0, #0x14c]
	mov r1, #1
	bl AnimatorMDL__SetAnimation
	ldr r0, [r6, #0x20]
	orr r0, r0, #0x184
	str r0, [r6, #0x20]
	ldr r0, [r6, #0x1c]
	ldr r1, _02177A84 // =0x000034CC
	orr r0, r0, #0x2100
	str r0, [r6, #0x1c]
	str r4, [r6, #0x28]
	ldr r2, [r6, #0x12c]
	mov r0, #0x1800
	str r1, [r2, #0x18]
	str r1, [r2, #0x1c]
	str r1, [r2, #0x20]
	str r0, [r6, #0x38]
	mov r3, #0x1000
	str r3, [r6, #0x3c]
	mov r0, r6
	mov r1, r7
	mov r2, #0
	str r3, [r6, #0x40]
	bl StageTask__SetParent
	mov r1, #0
	mov r0, r6
	mov r2, r1
	mov r3, r1
	bl StageTask__InitCollider
	mov r0, r6
	mov r1, #0
	bl StageTask__GetCollider
	mov r1, #4
	mov r2, #0xfe
	mov r4, r0
	bl ObjRect__SetAttackStat
	mov r0, r4
	ldr r1, _02177A88 // =0x0000FFFF
	mov r2, #0
	bl ObjRect__SetDefenceStat
	str r6, [r4, #0x1c]
	ldr r1, _02177A8C // =0x00000102
	ldr r0, _02177A90 // =ovl02_2178390
	strh r1, [r4, #0x34]
	rsb r2, r1, #0xfa
	ldr r3, [r4, #0x18]
	mov r1, #0x18
	orr r3, r3, #4
	str r3, [r4, #0x18]
	str r5, [r4, #0x3c]
	str r0, [r4, #0x28]
	ldr r3, [r4, #0x18]
	mov r0, #8
	orr r3, r3, #0x80000
	str r3, [r4, #0x18]
	strh r2, [r5]
	strh r1, [r5, #2]
	strh r0, [r5, #4]
	strh r1, [r5, #6]
	mov r0, #0x10
	strh r0, [r5, #8]
	mov r1, #0x1f4
	strh r1, [r5, #0xa]
	sub r0, r1, #0x204
	strh r0, [r5, #0xc]
	strh r1, [r5, #0xe]
	ldr r1, _02177A94 // =ovl02_2177A98
	mov r0, r6
	str r1, [r6, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02177A70: .word gameArchiveStage
_02177A74: .word aBsef8BeamNsbmd_0
_02177A78: .word aBsef8BeamNsbca_0
_02177A7C: .word aBsef8BeamNsbta_0
_02177A80: .word aBsef8BeamNsbma_0
_02177A84: .word 0x000034CC
_02177A88: .word 0x0000FFFF
_02177A8C: .word 0x00000102
_02177A90: .word ovl02_2178390
_02177A94: .word ovl02_2177A98
	arm_func_end ovl02_2177868

	arm_func_start ovl02_2177A98
ovl02_2177A98: // _02177A98
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, [r5, #0x28]
	ldr r1, [r5, #0x11c]
	cmp r0, #0
	ldr r0, [r1, #0x124]
	ldr r4, [r5, #0x124]
	mov r1, #0x8000
	ldr ip, [r0, #0x214]
	bne _02177AEC
	ldr r3, [r0, #0x210]
	ldr r2, _02177B88 // =0x0016E000
	rsb r1, r1, #0
	sub r1, r1, r3
	str r2, [r5, #0x44]
	str r1, [r5, #0x48]
	add r3, sp, #0
	str ip, [r5, #0x4c]
	add r0, r0, #0x19c
	b _02177B10
_02177AEC:
	ldr r3, [r0, #0x210]
	ldr r2, _02177B8C // =0x00182000
	rsb r1, r1, #0
	sub r1, r1, r3
	str r2, [r5, #0x44]
	str r1, [r5, #0x48]
	add r3, sp, #0
	str ip, [r5, #0x4c]
	add r0, r0, #0x1a8
_02177B10:
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r3, [sp]
	ldr r0, [r5, #0x44]
	ldr r2, [sp, #4]
	ldr r1, [r5, #0x48]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	strh r0, [r5, #0x34]
	ldrh r0, [r5, #0x34]
	ldr r2, _02177B90 // =FX_SinCosTable_
	rsb r0, r0, #0
	strh r0, [r4, #0x10]
	ldrh r0, [r5, #0x34]
	ldr r3, [r5, #0x12c]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotZ33_
	mov r0, r5
	mov r1, #1
	bl ovl02_2169E34
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02177B88: .word 0x0016E000
_02177B8C: .word 0x00182000
_02177B90: .word FX_SinCosTable_
	arm_func_end ovl02_2177A98

	arm_func_start ovl02_2177B94
ovl02_2177B94: // _02177B94
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	mov r5, r1
	mov r0, #0x1a00
	mov r1, #4
	bl CreateStageTaskEx_
	mov r1, #5
	mov r4, r0
	bl StageTask__SetType
	mov r1, #0
	ldr r0, _02177CB0 // =gameArchiveStage
	str r1, [sp]
	ldr r2, [r0, #0]
	mov r0, r4
	str r2, [sp, #4]
	ldr r2, _02177CB4 // =aBsef8BFlash2Ns_1
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, _02177CB0 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	mov r1, #0
	str r2, [sp]
	ldr r2, _02177CB8 // =aBsef8BFlash2Ns_2
	mov r3, r1
	bl ObjAction3dNNMotionLoad
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x20]
	ldr ip, _02177CBC // =0x000034CC
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x18]
	mov r3, #0x1800
	orr r0, r0, #2
	str r0, [r4, #0x18]
	ldr r1, [r4, #0x20]
	ldr r0, _02177CC0 // =FX_SinCosTable_+0x00002000
	orr r1, r1, #0x180
	str r1, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	ldrsh r1, [r0, #0]
	orr r2, r2, #0x2100
	str r2, [r4, #0x1c]
	str r5, [r4, #0x28]
	ldrsh r2, [r0, #2]
	ldr r0, [r4, #0x12c]
	str ip, [r0, #0x18]
	str ip, [r0, #0x1c]
	str ip, [r0, #0x20]
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	str r3, [r4, #0x40]
	ldr r0, [r4, #0x12c]
	add r0, r0, #0x24
	bl MTX_RotY33_
	cmp r5, #0
	ldrne r0, [r4, #0x38]
	mov r1, r6
	rsbne r0, r0, #0
	strne r0, [r4, #0x38]
	mov r0, r4
	mov r2, #0
	bl StageTask__SetParent
	ldr r1, _02177CC4 // =ovl02_2177CC8
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02177CB0: .word gameArchiveStage
_02177CB4: .word aBsef8BFlash2Ns_1
_02177CB8: .word aBsef8BFlash2Ns_2
_02177CBC: .word 0x000034CC
_02177CC0: .word FX_SinCosTable_+0x00002000
_02177CC4: .word ovl02_2177CC8
	arm_func_end ovl02_2177B94

	arm_func_start ovl02_2177CC8
ovl02_2177CC8: // _02177CC8
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r4, r0
	ldr r2, [r4, #0x11c]
	mov r1, #1
	ldr r5, [r2, #0x124]
	bl ovl02_2169E34
	ldr r0, [r4, #0x28]
	cmp r0, #0
	bne _02177D18
	add r0, r5, #0x19c
	add r3, r4, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x44]
	ldr r0, _02177DBC // =0x0010A000
	cmp r1, r0
	ble _02177D3C
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
_02177D18:
	add r0, r5, #0x1a8
	add r3, r4, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x44]
	ldr r0, _02177DC0 // =0x001E6000
	cmp r1, r0
	addlt sp, sp, #0xc
	ldmltia sp!, {r3, r4, r5, r6, pc}
_02177D3C:
	bl GetObjSpeed
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	tst r0, #0x1f
	addne sp, sp, #0xc
	str r0, [r4, #0x2c]
	ldmneia sp!, {r3, r4, r5, r6, pc}
	ldr ip, _02177DC4 // =_mt_math_rand
	ldr r0, _02177DC8 // =0x00196225
	ldr r2, [ip]
	ldr r1, _02177DCC // =0x3C6EF35F
	ldr r6, _02177DD0 // =_02179054
	mla r5, r2, r0, r1
	add r3, sp, #0
	ldmia r6, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov lr, r5, lsr #0x10
	ldr r1, _02177DD4 // =0x00001FFF
	mov r0, lr, lsl #0x10
	and r0, r1, r0, lsr #16
	rsb lr, r0, #0x1000
	mov r0, r4
	mov r2, r3
	add r1, r4, #0x44
	str r5, [ip]
	str lr, [sp]
	bl ovl02_21773FC
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02177DBC: .word 0x0010A000
_02177DC0: .word 0x001E6000
_02177DC4: .word _mt_math_rand
_02177DC8: .word 0x00196225
_02177DCC: .word 0x3C6EF35F
_02177DD0: .word _02179054
_02177DD4: .word 0x00001FFF
	arm_func_end ovl02_2177CC8

	arm_func_start ovl02_2177DD8
ovl02_2177DD8: // _02177DD8
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r6, r0
	mov r5, r1
	mov r0, #0x4800
	mov r1, #4
	bl CreateStageTaskEx_
	mov r1, #5
	mov r4, r0
	bl StageTask__SetType
	ldr r3, _02177EDC // =0x0000FFFF
	mov r1, #0
	str r3, [sp]
	ldr r2, _02177EE0 // =gameArchiveStage
	str r1, [sp, #4]
	ldr ip, [r2]
	ldr r2, _02177EE4 // =aBsef8WhiteBac_0
	mov r0, r4
	str ip, [sp, #8]
	bl ObjObjectAction3dBACLoad
	ldr r0, [r4, #0x134]
	mov r2, #0x1d
	strb r2, [r0, #0xa]
	ldr r2, [r4, #0x134]
	mov r3, #7
	strb r3, [r2, #0xb]
	ldr lr, [r4, #0x134]
	add r0, r5, #8
	ldr ip, [lr, #0xf4]
	mov r3, r0, lsl #0x1a
	bic ip, ip, #0x3f000000
	orr r3, ip, r3, lsr #2
	str r3, [lr, #0xf4]
	ldr r3, [r4, #0x18]
	mov r1, r6
	orr r3, r3, #2
	str r3, [r4, #0x18]
	ldr r3, [r4, #0x20]
	mov r0, r4
	orr r3, r3, #0x180
	str r3, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	mov r2, #0
	orr r3, r3, #0x2100
	str r3, [r4, #0x1c]
	bl StageTask__SetParent
	str r5, [r4, #0x28]
	mov r0, #0x4000
	str r0, [r4, #0x38]
	mov r0, #0x80000
	str r0, [r4, #0x3c]
	mov r0, #0x1000
	str r0, [r4, #0x40]
	ldr r0, [r4, #0x28]
	ldr r1, _02177EE8 // =ovl02_2177EEC
	cmp r0, #0
	ldrne r0, [r4, #0x38]
	rsbne r0, r0, #0
	strne r0, [r4, #0x38]
	mov r0, #0
	str r0, [r4, #0x2c]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02177EDC: .word 0x0000FFFF
_02177EE0: .word gameArchiveStage
_02177EE4: .word aBsef8WhiteBac_0
_02177EE8: .word ovl02_2177EEC
	arm_func_end ovl02_2177DD8

	arm_func_start ovl02_2177EEC
ovl02_2177EEC: // _02177EEC
	mov ip, r0
	ldr r1, [ip, #0x11c]
	ldr r0, [ip, #0x28]
	ldr r1, [r1, #0x124]
	cmp r0, #0
	addeq r0, r1, #0x19c
	addne r0, r1, #0x1a8
	add r3, ip, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [ip, #0x28]
	add r0, r0, #0x70
	mov r0, r0, lsl #0xc
	str r0, [ip, #0x4c]
	bx lr
	arm_func_end ovl02_2177EEC

	arm_func_start ovl02_2177F28
ovl02_2177F28: // _02177F28
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	mov r0, #0x1a00
	mov r1, #4
	bl CreateStageTaskEx_
	mov r1, #5
	mov r4, r0
	bl StageTask__SetType
	mov r1, #0
	ldr r0, _0217800C // =gameArchiveStage
	str r1, [sp]
	ldr r3, [r0, #0]
	ldr r2, _02178010 // =aBsef8BDmgNsbmd_0
	mov r0, r4
	str r3, [sp, #4]
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x18]
	add r0, r5, #0x44
	orr r1, r1, #2
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x20]
	add r6, r4, #0x44
	orr r1, r1, #0x180
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	ldr lr, _02178014 // =0x000034CC
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	mov ip, #0x1f000
	mov r3, #0x4000
	ldmia r0, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	ldr r0, [r4, #0x12c]
	mov r1, #0x2d
	str lr, [r0, #0x18]
	str lr, [r0, #0x1c]
	str lr, [r0, #0x20]
	str ip, [r4, #0x28]
	str r3, [r4, #8]
	ldr r0, [r4, #0x12c]
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlPolygonIDAll
	ldr r0, [r4, #0x12c]
	mov r1, #0x1f
	ldr r0, [r0, #0x94]
	bl NNS_G3dMdlSetMdlAlphaAll
	mov r1, r5
	mov r0, r4
	mov r2, #0
	bl StageTask__SetParent
	ldr r1, _02178018 // =ovl02_217801C
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0217800C: .word gameArchiveStage
_02178010: .word aBsef8BDmgNsbmd_0
_02178014: .word 0x000034CC
_02178018: .word ovl02_217801C
	arm_func_end ovl02_2177F28

	arm_func_start ovl02_217801C
ovl02_217801C: // _0217801C
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r1, [r4, #0x28]
	ldr r0, [r4, #0x12c]
	mov r5, r1, lsr #0xc
	ldr r0, [r0, #0x94]
	mov r1, r5
	bl NNS_G3dMdlSetMdlAlphaAll
	ldr r0, [r4, #8]
	cmp r0, #0
	bne _02178068
	mov r0, #8
	str r0, [sp]
	mov r1, #0
	ldr r0, [r4, #0x28]
	mov r3, r1
	mov r2, #3
	bl ObjShiftSet
	str r0, [r4, #0x28]
_02178068:
	cmp r5, #0
	ldreq r0, [r4, #0x18]
	mov r1, #1
	orreq r0, r0, #4
	streq r0, [r4, #0x18]
	mov r0, r4
	bl ovl02_2169E34
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_217801C

	arm_func_start ovl02_2178088
ovl02_2178088: // _02178088
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r4, _02178190 // =_obj_disp_rand
	ldr r0, _02178194 // =0x00196225
	ldr r3, [r4, #0]
	ldr r1, _02178198 // =0x3C6EF35F
	mov lr, #0x2000
	mla r5, r3, r0, r1
	mla ip, r5, r0, r1
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x17
	add r1, lr, #0x2ec000
	mov r3, r5, lsr #0x10
	sub r5, r1, r0, lsr #11
	mov r6, r0, lsr #0xb
	mov r0, r3, lsl #0x10
	ldr r1, _0217819C // =0x000003FF
	str ip, [r4]
	and r0, r1, r0, lsr #16
	rsb r1, r0, #0x200
	mov r2, #0x178000
	add r3, sp, #0
	mov r0, #0
	str r0, [r3, #4]
	str r0, [r3]
	add r1, r2, r1, lsl #12
	str r0, [r3, #8]
	sub r3, r2, #0x560000
	rsb r2, r5, #0
	str r3, [sp, #8]
	str r1, [sp]
	str r5, [sp, #4]
	add r4, lr, r6, asr #7
	bl BossFX__CreateTitanLightning
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r2, [r0, #0x25c]
	ldr r1, _021781A0 // =ovl02_21781A4
	bic r2, r2, #0x1f0000
	orr r2, r2, #0x1c0000
	str r2, [r0, #0x25c]
	str r4, [r0, #0x38]
	str r4, [r0, #0x3c]
	str r4, [r0, #0x40]
	str r1, [r0, #0x27c]
	ldr r1, [r0, #0x25c]
	ldr r3, _02178190 // =_obj_disp_rand
	bic r1, r1, #0x3f000000
	orr r1, r1, #0x37000000
	str r1, [r0, #0x25c]
	ldr r4, [r3, #0]
	ldr r1, _02178194 // =0x00196225
	ldr r2, _02178198 // =0x3C6EF35F
	mla r2, r4, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0x1f
	str r2, [r3]
	rsb r1, r1, #0x34
	str r1, [r0, #0x28]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02178190: .word _obj_disp_rand
_02178194: .word 0x00196225
_02178198: .word 0x3C6EF35F
_0217819C: .word 0x000003FF
_021781A0: .word ovl02_21781A4
	arm_func_end ovl02_2178088

	arm_func_start ovl02_21781A4
ovl02_21781A4: // _021781A4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _02178278 // =BossFStage__Singleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0x384]
	tst r0, #0x800
	ldreq r1, [r4, #0x2c]
	ldreq r0, [r4, #0x28]
	cmpeq r1, r0
	bne _02178250
	ldr r2, _0217827C // =_obj_disp_rand
	ldr r0, _02178280 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02178284 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	str r1, [r2]
	mov r0, #0
	beq _02178220
	sub r1, r0, #1
	ldr ip, _02178288 // =0x00000132
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	b _02178238
_02178220:
	ldr ip, _0217828C // =0x00000133
	sub r1, ip, #0x134
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
_02178238:
	ldr r1, [r4, #0x28]
	ldr r0, _02178290 // =defaultSfxPlayer
	rsb r1, r1, #0x3c
	rsb r1, r1, #0x78
	mov r2, #0
	bl NNS_SndPlayerMoveVolume
_02178250:
	mov r0, r4
	mov r1, #0
	bl ovl02_2169E34
	ldr r0, [r4, #0x2c]
	cmp r0, #0x34
	ldrlt r0, [r4, #0x20]
	orrlt r0, r0, #0x20
	strlt r0, [r4, #0x20]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02178278: .word BossFStage__Singleton
_0217827C: .word _obj_disp_rand
_02178280: .word 0x00196225
_02178284: .word 0x3C6EF35F
_02178288: .word 0x00000132
_0217828C: .word 0x00000133
_02178290: .word defaultSfxPlayer
	arm_func_end ovl02_21781A4

	arm_func_start ovl02_2178294
ovl02_2178294: // _02178294
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x40
	mov r6, r1
	mov r7, r0
	mov r5, r2
	mov r2, #1
	add r1, sp, #0xc
	mov r0, #0x10
	mov r4, r3
	str r2, [sp, #0xc]
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r2, r1
	mov r0, #0x11
	bl NNS_G3dGeBufferOP_N
	add r0, sp, #0x10
	bl MTX_Identity43_
	ldr r2, [r6, #0]
	ldr r1, [r7, #0]
	mov r0, #0x19
	sub r1, r2, r1
	str r1, [sp, #0x10]
	ldr r3, [r6, #4]
	ldr r2, [r7, #4]
	add r1, sp, #0x10
	sub r2, r3, r2
	str r2, [sp, #0x20]
	ldr r6, [r6, #8]
	ldr r3, [r7, #8]
	mov r2, #0xc
	sub r3, r6, r3
	str r3, [sp, #0x30]
	ldr r3, [r7, #0]
	str r3, [sp, #0x34]
	ldr r3, [r7, #4]
	str r3, [sp, #0x38]
	ldr r3, [r7, #8]
	str r3, [sp, #0x3c]
	bl NNS_G3dGeBufferOP_N
	and r0, r4, #0x31
	mov r0, r0, lsl #0x10
	orr r0, r0, #0x20c0
	str r0, [sp, #8]
	mov r0, #0x29
	add r1, sp, #8
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, #0x20
	add r1, sp, #4
	mov r2, #1
	str r5, [sp, #4]
	bl NNS_G3dGeBufferOP_N
	ldr r0, _0217838C // =_021790C0
	mov r1, #0x18
	bl NNS_G3dGeSendDL
	mov r2, #1
	mov r0, #0x12
	add r1, sp, #0
	str r2, [sp]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x40
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0217838C: .word _021790C0
	arm_func_end ovl02_2178294

	arm_func_start ovl02_2178390
ovl02_2178390: // _02178390
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x40
	ldr ip, [r0, #0x3c]
	ldr r1, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	str r1, [sp, #0x10]
	ldrh r1, [ip, #0x10]
	str r0, [sp, #0x14]
	cmp r1, #0
	beq _021784E0
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r3, r0, lsl #1
	add r0, r3, #1
	mov r2, r0, lsl #1
	ldr r1, _021785F0 // =FX_SinCosTable_
	mov r0, r3, lsl #1
	ldrsh r7, [r1, r2]
	ldrsh r5, [r1, r0]
	mov lr, #0
	mov r6, r7, asr #0x1f
	mov r4, r5, asr #0x1f
_021783EC:
	mov r0, lr, lsl #2
	ldrsh r1, [ip, r0]
	add r8, sp, #0x20
	add r8, r8, lr, lsl #3
	str r8, [sp, #0x1c]
	add r8, lr, #1
	mov r3, r1, lsl #0xc
	mov r8, r8, lsl #0x10
	str r8, [sp, #0x18]
	umull r10, r8, r3, r7
	adds r9, r10, #0x800
	add r0, ip, lr, lsl #2
	ldrsh r0, [r0, #2]
	mla r8, r3, r6, r8
	mov r2, r3, asr #0x1f
	mla r8, r2, r7, r8
	mov r1, r0, lsl #0xc
	mov r9, r9, lsr #0xc
	adc r8, r8, #0
	mov r10, #0
	orr r9, r9, r8, lsl #20
	mov r8, r10
	add r11, r8, r9
	umull r10, r9, r1, r5
	adds r8, r10, #0x800
	mla r9, r1, r4, r9
	mov r0, r1, asr #0x1f
	mla r9, r0, r5, r9
	mov r10, r8, lsr #0xc
	adc r8, r9, #0
	orr r10, r10, r8, lsl #20
	sub r8, r11, r10
	mov r9, r8, asr #0xc
	add r8, sp, #0x20
	str r9, [r8, lr, lsl #3]
	ldr r8, [sp, #0x18]
	mov lr, r8, lsr #0x10
	umull r9, r8, r3, r5
	mla r8, r3, r4, r8
	adds r3, r9, #0x800
	mla r8, r2, r5, r8
	adc r2, r8, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, r3, #0
	umull r8, r3, r1, r7
	mla r3, r1, r6, r3
	mla r3, r0, r7, r3
	mov r0, #0x800
	adds r1, r8, r0
	mov r0, #0
	adc r0, r3, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	mov r1, r0, asr #0xc
	ldr r0, [sp, #0x1c]
	cmp lr, #4
	str r1, [r0, #4]
	blo _021783EC
	b _02178518
_021784E0:
	mov r4, #0
	add r3, sp, #0x20
_021784E8:
	mov r0, r4, lsl #2
	ldrsh r2, [ip, r0]
	add r0, r4, #1
	add r1, ip, r4, lsl #2
	str r2, [r3, r4, lsl #3]
	ldrsh r2, [r1, #2]
	mov r0, r0, lsl #0x10
	add r1, r3, r4, lsl #3
	mov r4, r0, lsr #0x10
	str r2, [r1, #4]
	cmp r4, #4
	blo _021784E8
_02178518:
	ldr r0, [sp, #0x14]
	mov r6, #0
	ldr r5, [r0, #0x44]
	ldr r4, [r0, #0x48]
	add r2, sp, #0x20
_0217852C:
	ldr r1, [r2, r6, lsl #3]
	add r0, r6, #1
	add r1, r1, r5, asr #12
	str r1, [r2, r6, lsl #3]
	add r3, r2, r6, lsl #3
	ldr r1, [r3, #4]
	mov r0, r0, lsl #0x10
	add r1, r1, r4, asr #12
	mov r6, r0, lsr #0x10
	str r1, [r3, #4]
	cmp r6, #4
	blo _0217852C
	ldr r0, [sp, #0x10]
	ldr r6, [sp, #0x24]
	ldr r2, [r0, #0x44]
	ldr r1, [r0, #0x48]
	ldr r4, [sp, #0x34]
	ldr r5, [sp, #0x30]
	ldr r0, [sp, #0x28]
	mov r8, r1, asr #0xc
	str r0, [sp]
	ldr r0, [sp, #0x2c]
	mov r7, r2, asr #0xc
	stmib sp, {r0, r5}
	str r4, [sp, #0xc]
	ldr r2, [sp, #0x20]
	mov r0, r7
	mov r1, r8
	mov r3, r6
	bl ovl02_21785F4
	cmp r0, #0
	addne sp, sp, #0x40
	movne r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp, #0x38]
	mov r0, r7
	str r1, [sp]
	ldr r2, [sp, #0x3c]
	mov r1, r8
	stmib sp, {r2, r5}
	str r4, [sp, #0xc]
	ldr r2, [sp, #0x20]
	mov r3, r6
	bl ovl02_21785F4
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #0x40
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021785F0: .word FX_SinCosTable_
	arm_func_end ovl02_2178390

	arm_func_start ovl02_21785F4
ovl02_21785F4: // _021785F4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	ldr r7, [sp, #0x38]
	mov r8, r2
	ldr r5, [sp, #0x40]
	ldr r6, [sp, #0x3c]
	mov r11, r3
	ldr r4, [sp, #0x44]
	sub r10, r8, r5
	sub r2, r11, r6
	mul r2, r10, r2
	sub r9, r8, r7
	sub r3, r11, r4
	mul r3, r9, r3
	cmp r2, r3
	mov r10, r0
	mov r9, r1
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	str r10, [sp]
	str r9, [sp, #4]
	str r5, [sp, #8]
	mov r0, r8
	mov r1, r11
	mov r2, r7
	mov r3, r6
	str r4, [sp, #0xc]
	bl ovl02_21786F8
	subs r0, r0, #0
	sbcs r0, r1, #0
	addlt sp, sp, #0x10
	mov r0, #0
	ldmltia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	str r10, [sp]
	str r9, [sp, #4]
	str r7, [sp, #8]
	mov r0, r8
	mov r1, r11
	mov r2, r5
	mov r3, r4
	str r6, [sp, #0xc]
	bl ovl02_21786F8
	subs r0, r0, #0
	sbcs r0, r1, #0
	addlt sp, sp, #0x10
	mov r0, #0
	ldmltia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	str r10, [sp]
	str r9, [sp, #4]
	str r8, [sp, #8]
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	str r11, [sp, #0xc]
	bl ovl02_21786F8
	subs r0, r0, #0
	sbcs r0, r1, #0
	mov r0, #0
	movge r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end ovl02_21785F4

	arm_func_start ovl02_21786F8
ovl02_21786F8: // _021786F8
	stmdb sp!, {r3, r4, r5, lr}
	ldr lr, [sp, #0x10]
	ldr ip, [sp, #0x18]
	sub r5, r1, r3
	sub lr, r0, lr
	sub r3, r0, ip
	mul lr, r5, lr
	ldr r4, [sp, #0x14]
	ldr ip, [sp, #0x1c]
	mul r3, r5, r3
	sub r5, r0, r2
	sub r2, r4, r1
	sub r0, ip, r1
	mla r2, r5, r2, lr
	mla r0, r5, r0, r3
	smull r0, r1, r2, r0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_21786F8

	arm_func_start ovl02_217873C
ovl02_217873C: // _0217873C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	movs r4, r0
	mov ip, r1
	beq _021787BC
	add r0, r4, #0x44
	add r3, sp, #8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #0
	sub r1, r0, #1
	stmia sp, {r0, ip}
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, _021787DC // =gPlayer
	mov r2, #0
	ldr r0, [r0, #0]
	add r1, sp, #8
	ldr ip, [r0, #0x48]
	str ip, [sp, #0xc]
	ldr r3, [r4, #0x48]
	ldr r0, [r0, #0x48]
	sub r0, r3, r0
	add r0, ip, r0, asr #2
	str r2, [sp, #0x10]
	str r0, [sp, #0xc]
	ldr r0, [r4, #0x138]
	bl ProcessSpatialSfx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
_021787BC:
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021787DC: .word gPlayer
	arm_func_end ovl02_217873C

	.rodata

_02178FE8: // 0x02178FE8
    .word 0x670081
	
_02178FEC: // 0x02178FEC
    .word 0x1560201
	
_02178FF0: // 0x02178FF0
    .word 0x210034
	
_02178FF4: // 0x02178FF4
    .word 0x1560201
	
_02178FF8: // 0x02178FF8
    .word 0x60004, 0x50005
	
_02179000: // 0x02179000
    .word 0x10001, 0x40001
	
_02179008: // 0x02179008
    .word 0x4660466, 0x2CC03CC
	
_02179010: // 0x02179010
    .word 0x23303CC, 0xFF9C0100

_02179018: // 0x02179018
    .word 0x3000, 0xFFFFF000, 0x3000
	
_02179024: // 0x02179024
    .word 0
	
_02179028: // 0x02179028
    .word 0x1000, 0

_02179030: // 0x02179030
    .word 0x12000, 0xFFFF0000, 0
	
_0217903C: // 0x0217903C
    .word 0

_02179040: // 0x02179040
    .word 0x1000, 0

_02179048: // 0x02179048
    .word 0, 0

_02179050: // 0x02179050
    .word 0x10000

_02179054: // 0x02179054
    .word 0

_02179058: // 0x02179058
    .word 0xFFFFE000, 0

_02179060: // 0x02179060
    .word 0

_02179064: // 0x02179064
    .word 0x1000, 0

_0217906C: // 0x0217906C
    .word 0

_02179070: // 0x02179070
    .word 0x1000, 0

_02179078: // 0x02179078
    .word 0, 0

_0217907C: // 0x0217907C
    .word 0x10000

_02179084: // 0x02179084
    .word 0, 0

_02179088: // 0x02179088
    .word 0x10000

_02179090: // 0x02179090
    .word 0
	
_02179094: // 0x02179094
    .word 0x1000, 0

_0217909C: // 0x0217909C
    .word 0

_021790A0: // 0x021790A0
    .word 0x1000, 0

_021790A8: // 0x021790A8
    .word 0x1000, 0x333, 0x266, 0x266, 0x266, 0x199
	
_021790C0: // 0x021790C0
    .byte 0x40, 0x24, 0x24, 0x24, 0, 0, 0, 0, 0, 0, 0, 0, 0x40, 0, 1, 4, 0, 0, 0, 0, 0x41, 0, 0, 0

_021790D8: // 0x021790D8
    .word 0x10001, 0x10001, 0x10001, 0x40004, 0x40004, 0x50005, 0x50005, 0x60006

_021790F8: // 0x021790F8
    .word 0x30003, 0x30003, 0x30003, 0x20003, 0x20002, 0x20002, 0x60002, 0x60006

_02179118: // 0x02179118
    .word 0, 0, 0, 0

_02179128: // 0x02179128
    .word 0xFFFFFC80, 0
    .word 8, 0
    .word 0xFFFFE400, 0, 0, 0, 0
    .word 0x64, 0
    .word 0xFFFFE400, 0, 0
    .word 0x380, 0
    .word 8, 0, 0, 0, 0, 0, 0, 0

_02179188: // 0x02179188
    .word 0, 0, 0, 0

_02179198: // 0x02179198
    .word 0xFFFFFD40, 0xFFFFFF80, 8, 0
    .word 0xFFFFEA00, 0xFFFFFC00, 0, 0, 0
    .word 0x64, 0
    .word 0xFFFFEA00, 0xFFFFFC00, 0
    .word 0x2C0, 0x80, 8, 0, 0, 0, 0, 0, 0, 0

_021791F8: // 0x021791F8
    .word 0, 0, 0

_02179204: // 0x02179204
    .word 0x600, 0xFFFFFEC0, 0
    .word 8, 0x3000, 0xFFFFF600, 0, 0, 0, 0
    .word 0x96, 0x3000, 0xFFFFF600, 0
    .word 0xFFFFFA00, 0x140, 0
    .word 8, 0, 0, 0, 0, 0, 0, 0

_02179268: // 0x02179268
    .word 0, 0, 0

_02179274: // 0x02179274
    .word 0x780, 0xFFFFFE40, 0xFFFFFC00, 8, 0x3C00, 0xFFFFF200
    .word 0xFFFFE000, 0, 0, 0
    .word 0x96, 0x3C00, 0xFFFFF200, 0xFFFFE000, 0xFFFFF880, 0x1C0
    .word 0x400, 8, 0, 0, 0, 0, 0, 0, 0

_021792D8: // 0x021792D8
    .word 0x8201000, 0x20180010
	
aWristL: // 0x021792E0
    .asciz "wrist_l"
    .align 4

_021792E8: // 0x021792E8
    .word 0, 0

aWristR_0: // 0x021792F0
    .asciz "wrist_r"
    .align 4

_021792F8: // 0x021792F8
    .word 0, 0

aBarrel_0: // 0x02179300
    .asciz "barrel"
    .align 4

_02179308: // 0x02179308
	.word 0, 0

	.data
aZ8DaiPl_0: // 0x02179798
    .asciz "z8_dai_pl"
    .align 4

aZ8TopPl_0: // 0x021797A4
    .asciz "z8_top_pl"
    .align 4

aZ8GunPl_0: // 0x021797B0
    .asciz "z8_gun_pl"
    .align 4

aZ8WeekPl_0: // 0x021797BC
    .asciz "z8_week_pl"
    .align 4

aZ8HandPl_0: // 0x021797C8
    .asciz "z8_hand_pl"
    .align 4

aZ8HeadPl_0: // 0x021797D4
    .asciz "z8_head_pl"
    .align 4

aZ8ArmBPl_0: // 0x021797E0
    .asciz "z8_arm_b_pl"
    .align 4

aZ8ArmAPl_0: // 0x021797EC
    .asciz "z8_arm_a_pl"
    .align 4

aZ8HDaiPl_0: // 0x021797F8
    .asciz "z8_h_dai_pl"
    .align 4

aZ8SideAPl_0: // 0x02179804
    .asciz "z8_side_a_pl"
    .align 4

aZ8ArmB2Pl_0: // 0x02179814
    .asciz "z8_arm_b2_pl"
    .align 4

_02179824: // 0x02179824
    .word aZ8ArmAPl_0         // "z8_arm_a_pl"
	.word aZ8DaiPl_0          // "z8_dai_pl"
	.word aZ8GunPl_0          // "z8_gun_pl"
	.word aZ8HDaiPl_0         // "z8_h_dai_pl"
	.word aZ8HeadPl_0         // "z8_head_pl"
	.word aZ8SideAPl_0        // "z8_side_a_pl"
	.word aZ8TopPl_0          // "z8_top_pl"
	.word aZ8WeekPl_0         // "z8_week_pl"

_02179844: // 0x02179844
    .word aZ8ArmBPl_0, aZ8ArmB2Pl_0, aZ8HandPl_0, 0, 0, 0, 0, 0

_02179864: // 0x02179864
    .word aZ8GunPl_0, aZ8HDaiPl_0, 0, 0, 0, 0, 0, 0

aBossfBodyNsbmd_0: // 0x02179884
    .asciz "bossF_body.nsbmd"
    .align 4

aBossfBodyNsbca_0: // 0x02179898
    .asciz "bossF_body.nsbca"
    .align 4

aWeak_0: // 0x021798AC
    .asciz "weak"
    .align 4

aHead_2: // 0x021798B4
    .asciz "head"
    .align 4

aArmL_0: // 0x021798BC
    .asciz "arm_l"
    .align 4

aArmR_0: // 0x021798C4
    .asciz "arm_r"
    .align 4
	
aCannonL_0: // 0x021798CC
    .asciz "cannon_l"
    .align 4
	
aCannonR_0: // 0x021798D8
    .asciz "cannon_r"
    .align 4
	
aBalkanL_0: // 0x021798E4
    .asciz "balkan_l"
    .align 4
	
aBalkanR_0: // 0x021798F0
    .asciz "balkan_r"
    .align 4
	
aBody_0: // 0x021798FC
    .asciz "body"
    .align 4
	
aExc_3: // 0x02179904
    .asciz "exc"
    .align 4
	
aBossfArmLNsbmd_0: // 0x02179908
    .asciz "bossF_arm_l.nsbmd"
    .align 4
	
aBossfArmLNsbca_0: // 0x0217991C
    .asciz "bossF_arm_l.nsbca"
    .align 4
	
aBossfArmRNsbmd_0: // 0x02179930
    .asciz "bossF_arm_r.nsbmd"
    .align 4
	
aBossfArmRNsbca_0: // 0x02179944
    .asciz "bossF_arm_r.nsbca"
    .align 4
	
aBossfEtcNsbmd_0: // 0x02179958
    .asciz "bossF_etc.nsbmd"
    .align 4
	
aBsefHitBNsbmd_0: // 0x02179968
    .asciz "bsef_hit_b.nsbmd"
    .align 4
	
aBsef8ZJetNsbmd_0: // 0x0217997C
    .asciz "bsef8_z_jet.nsbmd"
    .align 4
	
aBsef8Float1Nsb_3: // 0x02179990
    .asciz "bsef8_float1.nsbmd"
    .align 4
	
aBsef8WaveNsbmd_0: // 0x021799A4
    .asciz "bsef8_wave.nsbmd"
    .align 4
	
aBsef8BariaNsbm_0: // 0x021799B8
    .asciz "bsef8_baria.nsbmd"
    .align 4
	
aBsef8BFlash1Ns_1: // 0x021799CC
    .asciz "bsef8_b_flash1.nsbmd"
    .align 4
	
aBsef8BFlash2Ns_1: // 0x021799E4
    .asciz "bsef8_b_flash2.nsbmd"
    .align 4
	
aBsef8BeamNsbmd_0: // 0x021799FC
    .asciz "bsef8_beam.nsbmd"
    .align 4
	
aBossfStageNsbm_0: // 0x02179A10
    .asciz "bossF_stage.nsbmd"
    .align 4
	
aBsefBombBac_1: // 0x02179A24
    .asciz "bsef_bomb.bac"
    .align 4
	
aBsef8WaveNsbca_0: // 0x02179A34
    .asciz "bsef8_wave.nsbca"
    .align 4
	
aBsef8Float1Nsb_4: // 0x02179A48
    .asciz "bsef8_float1.nsbca"
    .align 4
	
aBsef8Float1Nsb_5: // 0x02179A5C
    .asciz "bsef8_float1.nsbva"
    .align 4
	
aBsef8Float1Nsb_6: // 0x02179A70
    .asciz "bsef8_float1.nsbma"
    .align 4
	
aBsef8TargetBac_0: // 0x02179A84
    .asciz "bsef8_target.bac"
    .align 4
	
aBsef8InNsbmd_0: // 0x02179A98
    .asciz "bsef8_in.nsbmd"
    .align 4
	
aBsef8InNsbca_0: // 0x02179AA8
    .asciz "bsef8_in.nsbca"
    .align 4
	
aBsef8InNsbma_0: // 0x02179AB8
    .asciz "bsef8_in.nsbma"
    .align 4
	
aAcFixKeyBac_0: // 0x02179AC8
    .asciz "ac_fix_key.bac"
    .align 4
	
aBsef8BFlash1Ns_2: // 0x02179AD8
    .asciz "bsef8_b_flash1.nsbca"
    .align 4
	
aBsef8BeamNsbca_0: // 0x02179AF0
    .asciz "bsef8_beam.nsbca"
    .align 4
	
aBsef8BeamNsbta_0: // 0x02179B04
    .asciz "bsef8_beam.nsbta"
    .align 4
	
aBsef8BeamNsbma_0: // 0x02179B18
    .asciz "bsef8_beam.nsbma"
    .align 4
	
aBsef8BFlash2Ns_2: // 0x02179B2C
    .asciz "bsef8_b_flash2.nsbca"
    .align 4
	
aBsef8WhiteBac_0: // 0x02179B44
    .asciz "bsef8_white.bac"
    .align 4

aBsef8BDmgNsbmd_0: // 0x02179B54
    .asciz "bsef8_b_dmg.nsbmd"
    .align 4