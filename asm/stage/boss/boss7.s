	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Boss7Stage__Create
Boss7Stage__Create: // 0x0215C8E4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x80
	mov r7, #0x1500
	mov r8, r0
	mov r5, r1
	mov r4, r2
	mov r2, #0
	str r7, [sp]
	mov r6, #2
	str r6, [sp, #4]
	sub r6, r7, #0x450
	ldr r0, _0215CBB8 // =StageTask_Main
	ldr r1, _0215CBBC // =ovl02_215F7D4
	mov r3, r2
	str r6, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	ldr r2, _0215CBC0 // =0x000010B0
	str r0, [sp, #0x14]
	mov r1, #0
	bl MI_CpuFill8
	ldr r0, [sp, #0x14]
	mov r1, r8
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	ldr r2, _0215CBC4 // =ovl02_215F744
	ldr r0, [sp, #0x14]
	ldr r1, _0215CBC8 // =ovl02_215F898
	str r2, [r0, #0xf4]
	str r1, [r0, #0xfc]
	ldr r1, _0215CBCC // =ovl02_215F8CC
	mov r2, #1
	str r1, [r0, #0x108]
	ldr r1, [r0, #0x18]
	add r0, r0, #0x364
	orr r3, r1, #0x12
	ldr r1, [sp, #0x14]
	str r3, [r1, #0x18]
	ldr r1, [r1, #0x1c]
	orr r3, r1, #0xb300
	ldr r1, [sp, #0x14]
	str r3, [r1, #0x1c]
	str r2, [r1, #0x3e0]
	bl ovl02_215DAB8
	ldr r0, [sp, #0x14]
	add r0, r0, #0x3a8
	bl BossHelpers__Light__Init
	bl BossHelpers__Model__InitSystem
	mov r0, #0x400000
	bl SetSpatialAudioDropoffRate
	ldr r0, [sp, #0x14]
	mov r1, #0
	add r0, r0, #0x400
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, [sp, #0x14]
	ldr r1, _0215CBD0 // =bossAssetFiles
	str r2, [sp]
	ldr r1, [r1, #8]
	add r0, r0, #0x400
	mov r3, r2
	bl AnimatorMDL__SetResource
	ldr r2, _0215CBD4 // =0x0004058A
	ldr r0, [sp, #0x14]
	mov r1, #0xa
	str r2, [r0, #0x418]
	str r2, [r0, #0x41c]
	str r2, [r0, #0x420]
	ldr r0, _0215CBD8 // =g_obj
	mov r3, #0
	strb r1, [r0, #0x60]
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	mov r0, #0x134
	add r1, r5, #0x40000
	sub r2, r4, #0x1000
	str r3, [sp, #0x10]
	bl GameObject__SpawnObject
	ldr r1, [sp, #0x14]
	mov r3, #0
	str r0, [r1, #0x370]
	str r1, [r0, #0x370]
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	ldr r0, _0215CBDC // =0x00000137
	add r1, r5, #0x60000
	sub r2, r4, #0x1000
	str r3, [sp, #0x10]
	bl GameObject__SpawnObject
	ldr r1, [sp, #0x14]
	ldr r2, _0215CBE0 // =ovl02_215F920
	str r0, [r1, #0x374]
	str r1, [r0, #0x370]
	ldr r0, [sp, #0x14]
	ldr r1, _0215CBE4 // =gameArchiveStage
	str r2, [r0, #0x38c]
	ldr r2, [r1]
	ldr r1, _0215CBE8 // =_02179768
	add r0, sp, #0x18
	bl NNS_FndMountArchive
	add r0, sp, #0x18
	mov r1, #0x19
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultSetup
	add r0, sp, #0x18
	mov r1, #0xa
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultSetup
	add r0, sp, #0x18
	mov r1, #0xe
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultSetup
	add r0, sp, #0x18
	mov r1, #9
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultSetup
	add r0, sp, #0x18
	bl NNS_FndUnmountArchive
	ldr r2, _0215CBE4 // =gameArchiveStage
	ldr r1, _0215CBEC // =aBsef7FlameBac
	ldr r2, [r2]
	mov r0, #0
	bl ObjDataLoad
	mov r7, r0
	ldr r0, [sp, #0x14]
	ldr sl, [sp, #0x14]
	add r0, r0, #0x288
	mov fp, #0
	add sb, r0, #0x400
_0215CAFC:
	mov r0, r7
	bl Sprite__GetTextureSize
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r4, r0
	mov r0, r7
	bl Sprite__GetPaletteSize
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #0
	stmia sp, {r1, r4}
	str r0, [sp, #8]
	mov r0, sb
	mov r2, r7
	mov r3, r1
	bl AnimatorSprite3D__Init
	ldr r0, [sl, #0x754]
	add r5, sl, #0x354
	orr r0, r0, #4
	add r8, fp, #1
	str r0, [sl, #0x754]
	add r4, sl, #0x700
	mov r6, #0
_0215CB60:
	ldrh r0, [r4, #0x26]
	mov r1, r6
	mov r2, r6
	add r0, r0, #1
	cmp r0, r8
	ldr r0, [r5, #0x400]
	orrlt r0, r0, #0x18
	bicge r0, r0, #0x18
	str r0, [r5, #0x400]
	mov r0, sb
	bl AnimatorSprite3D__ProcessAnimation
	ldrh r0, [r4, #0x26]
	cmp r8, r0
	bne _0215CB60
	add fp, fp, #1
	cmp fp, #0xa
	add sb, sb, #0x104
	add sl, sl, #0x104
	blt _0215CAFC
	ldr r0, [sp, #0x14]
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_0215CBB8: .word StageTask_Main
_0215CBBC: .word ovl02_215F7D4
_0215CBC0: .word 0x000010B0
_0215CBC4: .word ovl02_215F744
_0215CBC8: .word ovl02_215F898
_0215CBCC: .word ovl02_215F8CC
_0215CBD0: .word bossAssetFiles
_0215CBD4: .word 0x0004058A
_0215CBD8: .word g_obj
_0215CBDC: .word 0x00000137
_0215CBE0: .word ovl02_215F920
_0215CBE4: .word gameArchiveStage
_0215CBE8: .word _02179768
_0215CBEC: .word aBsef7FlameBac
	arm_func_end Boss7Stage__Create

	arm_func_start Boss7Saw__Create
Boss7Saw__Create: // 0x0215CBF0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x74
	mov r4, #0x1500
	mov r5, r0
	str r4, [sp]
	mov r0, #2
	mov r8, r1
	mov r7, r2
	str r0, [sp, #4]
	ldr r4, _0215CD98 // =0x000004D8
	ldr r0, _0215CD9C // =StageTask_Main
	ldr r1, _0215CDA0 // =ovl02_2160568
	mov r2, #0
	mov r6, r3
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	ldr r2, _0215CD98 // =0x000004D8
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r1, r5
	mov r0, r4
	mov r2, r8
	mov r3, r7
	bl GameObject__InitFromObject
	ldr r1, _0215CDA4 // =ovl02_216052C
	ldr r0, _0215CDA8 // =ovl02_216057C
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r1, _0215CDAC // =ovl02_2160610
	ldr r0, _0215CDB0 // =0x000E03C0
	str r1, [r4, #0x108]
	ldr r1, [r4, #0x18]
	ldr r3, _0215CDB4 // =_021796C0
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	bic r1, r0, #0x10
	ldr r0, _0215CDB8 // =0xEFFF1FE0
	add r5, r4, #0x258
	and r0, r1, r0
	str r0, [r4, #0x1c]
	str r8, [r4, #0x44]
	str r7, [r4, #0x48]
	str r6, [r4, #0x36c]
	ldrsh r1, [r3, #6]
	mov r0, r5
	str r1, [sp]
	ldrsh r1, [r3]
	ldrsh r2, [r3, #2]
	ldrsh r3, [r3, #4]
	bl ObjRect__SetBox2D
	ldr r1, _0215CDBC // =0x00000102
	mov r0, r5
	strh r1, [r5, #0x34]
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	str r4, [r5, #0x1c]
	ldr r0, [r4, #0x230]
	bic r0, r0, #4
	str r0, [r4, #0x230]
	ldr r0, [r4, #0x2b0]
	bic r0, r0, #4
	str r0, [r4, #0x2b0]
	mov r3, #4
	sub r1, r3, #8
	mov r0, r4
	mov r2, r1
	str r3, [sp]
	bl StageTask__SetHitbox
	ldr r1, _0215CDC0 // =gameArchiveStage
	add r0, sp, #0xc
	ldr r2, [r1]
	ldr r1, _0215CDC4 // =_02179768
	bl NNS_FndMountArchive
	add r0, r4, #0x394
	mov r1, #0
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #9
	bl NNS_FndGetArchiveFileByIndex
	mov r2, #0
	mov r1, r0
	add r0, r4, #0x394
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	mov r0, #0
	str r0, [r4, #0x3ac]
	str r0, [r4, #0x3b0]
	str r0, [r4, #0x3b4]
	add r0, sp, #0xc
	bl NNS_FndUnmountArchive
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	bl ovl02_2160690
	mov r0, r4
	add sp, sp, #0x74
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215CD98: .word 0x000004D8
_0215CD9C: .word StageTask_Main
_0215CDA0: .word ovl02_2160568
_0215CDA4: .word ovl02_216052C
_0215CDA8: .word ovl02_216057C
_0215CDAC: .word ovl02_2160610
_0215CDB0: .word 0x000E03C0
_0215CDB4: .word _021796C0
_0215CDB8: .word 0xEFFF1FE0
_0215CDBC: .word 0x00000102
_0215CDC0: .word gameArchiveStage
_0215CDC4: .word _02179768
	arm_func_end Boss7Saw__Create

	arm_func_start Boss7Whisker__Create
Boss7Whisker__Create: // 0x0215CDC8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	ldr r0, _0215D11C // =StageTask_Main
	ldr r1, _0215D120 // =ovl02_2160A0C
	mov r3, r2
	str r4, [sp, #4]
	mov r4, #0xb90
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0xb90
	bl MI_CpuFill8
	mov r1, r7
	mov r0, r4
	mov r2, #0
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, _0215D124 // =ovl02_2160920
	ldr r0, _0215D128 // =ovl02_2160A30
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r0, _0215D12C // =ovl02_2160CA0
	mov r2, #0x400
	str r0, [r4, #0x108]
	ldr r0, [r4, #0x18]
	add r1, r4, #0x300
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r3, [r4, #0x1c]
	add r0, r4, #0x364
	orr r3, r3, #0x280
	orr r3, r3, #0x88000
	str r3, [r4, #0x1c]
	strh r2, [r1, #0xd2]
	str r6, [r4, #0x44]
	str r5, [r4, #0x48]
	bl ovl02_215DAB8
	add r5, r4, #0x3f8
	mov r0, r5
	mov r1, #2
	mov r2, #0
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r3, _0215D130 // =_021796C0
	mov r0, r5
	ldrsh r1, [r3, #0x2e]
	str r1, [sp]
	ldrsh r1, [r3, #0x28]
	ldrsh r2, [r3, #0x2a]
	ldrsh r3, [r3, #0x2c]
	bl ObjRect__SetBox2D
	str r4, [r5, #0x1c]
	ldr r1, _0215D134 // =ovl02_2160D58
	ldr r0, _0215D138 // =0x00000102
	str r1, [r5, #0x24]
	strh r0, [r5, #0x34]
	ldr r1, [r5, #0x18]
	add r0, r4, #0xb8
	orr r1, r1, #0x400
	str r1, [r5, #0x18]
	add r6, r0, #0x400
	mov r0, r6
	mov r1, #2
	mov r2, #0
	bl ObjRect__SetAttackStat
	mov r0, r6
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r3, _0215D130 // =_021796C0
	mov r0, r6
	ldrsh r1, [r3, #0x46]
	str r1, [sp]
	ldrsh r1, [r3, #0x40]
	ldrsh r2, [r3, #0x42]
	ldrsh r3, [r3, #0x44]
	bl ObjRect__SetBox2D
	add r0, r4, #0x38
	add r5, r0, #0x400
	ldr r1, _0215D134 // =ovl02_2160D58
	str r4, [r6, #0x1c]
	ldr r0, _0215D138 // =0x00000102
	str r1, [r6, #0x24]
	strh r0, [r6, #0x34]
	ldr r1, [r6, #0x18]
	mov r0, r5
	orr r2, r1, #0x400
	mov r1, #2
	str r2, [r6, #0x18]
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r3, _0215D130 // =_021796C0
	mov r0, r5
	ldrsh r1, [r3, #0x36]
	str r1, [sp]
	ldrsh r1, [r3, #0x30]
	ldrsh r2, [r3, #0x32]
	ldrsh r3, [r3, #0x34]
	bl ObjRect__SetBox2D
	str r4, [r5, #0x1c]
	ldr r1, _0215D13C // =ovl02_2160F60
	ldr r0, _0215D138 // =0x00000102
	str r1, [r5, #0x20]
	strh r0, [r5, #0x34]
	ldr r1, [r5, #0x18]
	add r0, r4, #0xf8
	bic r1, r1, #4
	str r1, [r5, #0x18]
	add r5, r0, #0x400
	mov r0, r5
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r3, _0215D130 // =_021796C0
	mov r0, r5
	ldrsh r1, [r3, #0x4e]
	str r1, [sp]
	ldrsh r1, [r3, #0x48]
	ldrsh r2, [r3, #0x4a]
	ldrsh r3, [r3, #0x4c]
	bl ObjRect__SetBox2D
	str r4, [r5, #0x1c]
	ldr r1, _0215D13C // =ovl02_2160F60
	ldr r0, _0215D138 // =0x00000102
	str r1, [r5, #0x20]
	strh r0, [r5, #0x34]
	ldr r0, [r5, #0x18]
	add r6, r4, #0x24c
	bic r0, r0, #4
	str r0, [r5, #0x18]
	add r0, r6, #0x800
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _0215D140 // =bossAssetFiles
	str r2, [sp]
	ldr r1, [r0]
	mov r3, r2
	add r0, r6, #0x800
	bl AnimatorMDL__SetResource
	ldr r1, _0215D144 // =0x000034CC
	mov r0, #4
	str r1, [r6, #0x818]
	str r1, [r6, #0x81c]
	str r1, [r6, #0x820]
	ldr r1, _0215D148 // =BossHelpers__Model__RenderCallback
	strb r0, [r6, #0x80a]
	mov r5, #3
	add r0, r6, #0x890
	mov r2, #0
	mov r3, #6
	str r5, [sp]
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	ldr r0, [r6, #0x894]
	ldr r1, _0215D14C // =aHip
	mov r2, #0x1e
	bl BossHelpers__Model__Init
	mov r3, #0
	str r3, [sp]
	ldr r0, [r6, #0x894]
	ldr r1, _0215D150 // =aHead_1
	mov r2, #0x1d
	bl BossHelpers__Model__Init
	mov r3, #0
	str r3, [sp]
	ldr r0, [r6, #0x894]
	ldr r1, _0215D154 // =aLElbow_0
	mov r2, #0x1c
	bl BossHelpers__Model__Init
	mov r3, #0
	str r3, [sp]
	ldr r0, [r6, #0x894]
	ldr r1, _0215D158 // =aRElbow_0
	mov r2, #0x1b
	bl BossHelpers__Model__Init
	mvn r2, #1
	str r2, [sp]
	mov r0, r4
	sub r1, r2, #6
	sub r2, r2, #8
	mov r3, #8
	bl StageTask__SetHitbox
	mov r0, r4
	bl ovl02_2166D68
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	bl ovl02_21611C4
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215D11C: .word StageTask_Main
_0215D120: .word ovl02_2160A0C
_0215D124: .word ovl02_2160920
_0215D128: .word ovl02_2160A30
_0215D12C: .word ovl02_2160CA0
_0215D130: .word _021796C0
_0215D134: .word ovl02_2160D58
_0215D138: .word 0x00000102
_0215D13C: .word ovl02_2160F60
_0215D140: .word bossAssetFiles
_0215D144: .word 0x000034CC
_0215D148: .word BossHelpers__Model__RenderCallback
_0215D14C: .word aHip
_0215D150: .word aHead_1
_0215D154: .word aLElbow_0
_0215D158: .word aRElbow_0
	arm_func_end Boss7Whisker__Create

	arm_func_start Boss7Rocket__Create
Boss7Rocket__Create: // 0x0215D15C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x74
	mov r4, #0x1500
	mov r8, r0
	str r4, [sp]
	mov r0, #2
	mov r7, r1
	mov r6, r2
	str r0, [sp, #4]
	ldr r4, _0215D400 // =0x0000063C
	ldr r0, _0215D404 // =StageTask_Main
	ldr r1, _0215D408 // =ovl02_216341C
	mov r2, #0
	mov r5, r3
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	ldr r2, _0215D400 // =0x0000063C
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r1, r8
	mov r0, r4
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	ldr r1, _0215D40C // =ovl02_21633F4
	ldr r0, _0215D410 // =ovl02_2163458
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r1, _0215D414 // =ovl02_2163640
	add r0, r4, #0x364
	str r1, [r4, #0x108]
	ldr r1, [r4, #0x18]
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x1340
	bic r1, r1, #0x80
	str r1, [r4, #0x1c]
	str r7, [r4, #0x44]
	str r6, [r4, #0x48]
	str r5, [r4, #0x374]
	bl ovl02_215DAB8
	ldr r2, _0215D418 // =_021796C0
	mov r1, #0x18
	ldrsh r6, [r2, #0x14]
	add r5, r4, #0x258
	sub r3, r1, #0x30
	str r6, [sp]
	ldrsh r6, [r2, #0x16]
	mov r0, r5
	str r6, [sp, #4]
	str r1, [sp, #8]
	ldrsh r1, [r2, #0x10]
	ldrsh r2, [r2, #0x12]
	bl ObjRect__SetBox3D
	ldr r1, _0215D41C // =0x00000102
	mov r0, r5
	strh r1, [r5, #0x34]
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r0, _0215D420 // =ovl02_216369C
	str r4, [r5, #0x1c]
	str r0, [r5, #0x20]
	ldr r0, [r5, #0x18]
	add r6, r4, #0x3b4
	bic r1, r0, #4
	str r1, [r5, #0x18]
	mov r0, r6
	mov r1, #0
	bl AnimatorMDL__Init
	ldr r0, [r4, #0x374]
	cmp r0, #0
	bne _0215D2C0
	mov r3, #0
	ldr r0, _0215D424 // =bossAssetFiles
	str r3, [sp]
	ldr r1, [r0]
	mov r0, r6
	mov r2, #2
	bl AnimatorMDL__SetResource
	b _0215D2E4
_0215D2C0:
	cmp r0, #1
	bne _0215D2E4
	mov r3, #0
	ldr r0, _0215D424 // =bossAssetFiles
	str r3, [sp]
	ldr r1, [r0]
	mov r0, r6
	mov r2, #3
	bl AnimatorMDL__SetResource
_0215D2E4:
	ldr r1, _0215D428 // =0x000034CC
	mov r0, #4
	str r1, [r6, #0x18]
	str r1, [r6, #0x1c]
	str r1, [r6, #0x20]
	strb r0, [r6, #0xa]
	mov r5, #3
	ldr r1, _0215D42C // =BossHelpers__Model__RenderCallback
	add r0, r6, #0x90
	mov r2, #0
	mov r3, #6
	str r5, [sp]
	bl NNS_G3dRenderObjSetCallBack
	ldr r1, _0215D430 // =gameArchiveStage
	add r0, sp, #0xc
	ldr r2, [r1]
	ldr r1, _0215D434 // =_02179768
	bl NNS_FndMountArchive
	add r5, r4, #0xf8
	add r0, r5, #0x400
	mov r1, #0
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #0x19
	bl NNS_FndGetArchiveFileByIndex
	mov r2, #0
	mov r1, r0
	add r0, r5, #0x400
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	add r0, sp, #0xc
	mov r1, #0x1a
	bl NNS_FndGetArchiveFileByIndex
	mov r1, #0
	mov r2, r0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r5, #0x400
	mov r3, r1
	bl BossHelpers__Animation__Func_2038BF0
	add r0, sp, #0xc
	mov r1, #0x1b
	bl NNS_FndGetArchiveFileByIndex
	mov r6, r0
	add r0, sp, #0xc
	mov r1, #0x19
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dGetTex
	str r0, [sp]
	mov r0, #1
	str r0, [sp, #4]
	mov r2, r6
	add r0, r5, #0x400
	mov r1, #2
	mov r3, #0
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _0215D428 // =0x000034CC
	str r0, [r5, #0x418]
	str r0, [r5, #0x41c]
	str r0, [r5, #0x420]
	add r0, sp, #0xc
	bl NNS_FndUnmountArchive
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	bl ovl02_216396C
	mov r0, r4
	add sp, sp, #0x74
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215D400: .word 0x0000063C
_0215D404: .word StageTask_Main
_0215D408: .word ovl02_216341C
_0215D40C: .word ovl02_21633F4
_0215D410: .word ovl02_2163458
_0215D414: .word ovl02_2163640
_0215D418: .word _021796C0
_0215D41C: .word 0x00000102
_0215D420: .word ovl02_216369C
_0215D424: .word bossAssetFiles
_0215D428: .word 0x000034CC
_0215D42C: .word BossHelpers__Model__RenderCallback
_0215D430: .word gameArchiveStage
_0215D434: .word _02179768
	arm_func_end Boss7Rocket__Create

	arm_func_start Boss7Unknown__Create
Boss7Unknown__Create: // 0x0215D438
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0xc
	mov r7, #0x1500
	mov r6, r0
	str r7, [sp]
	mov r0, #2
	mov r5, r1
	mov r4, r2
	str r0, [sp, #4]
	ldr r7, _0215D598 // =0x00000904
	ldr r0, _0215D59C // =StageTask_Main
	ldr r1, _0215D5A0 // =ovl02_2163B3C
	mov r2, #0
	mov sl, r3
	mov r3, r2
	str r7, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	ldr r2, _0215D598 // =0x00000904
	mov r7, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r1, r6
	mov r0, r7
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	ldr r1, _0215D5A4 // =ovl02_2163B24
	ldr r0, _0215D5A8 // =ovl02_2163B48
	str r1, [r7, #0xf4]
	str r0, [r7, #0xfc]
	ldr r0, _0215D5AC // =ovl02_2163B7C
	ldr r6, _0215D5B0 // =0x00000102
	str r0, [r7, #0x108]
	ldr r0, [r7, #0x18]
	mov r8, #0
	orr r0, r0, #0x10
	str r0, [r7, #0x18]
	ldr r0, [r7, #0x1c]
	add sb, r7, #0x3b4
	orr r0, r0, #0x9700
	bic r0, r0, #0x80
	str r0, [r7, #0x1c]
	str r5, [r7, #0x44]
	str r4, [r7, #0x48]
	ldr r5, _0215D5B4 // =ovl02_2163BFC
	ldr r4, _0215D5B8 // =_021796C0
	str sl, [r7, #0x374]
	mov fp, #2
_0215D4FC:
	ldrsh r1, [r4, #0xe]
	add r0, sb, #0xc
	str r1, [sp]
	ldrsh r1, [r4, #8]
	ldrsh r2, [r4, #0xa]
	ldrsh r3, [r4, #0xc]
	bl ObjRect__SetBox2D
	add r0, sb, #0xc
	mov r1, fp
	mov r2, #0x40
	strh r6, [sb, #0x40]
	bl ObjRect__SetAttackStat
	add r0, sb, #0xc
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	str r7, [sb, #0x28]
	str r5, [sb, #0x2c]
	ldr r0, [sb, #0x24]
	add r8, r8, #1
	bic r0, r0, #4
	str r0, [sb, #0x24]
	cmp r8, #0xf
	add sb, sb, #0x58
	blt _0215D4FC
	mov r0, #0
	str r0, [r7, #0x3b0]
	cmp sl, #0
	bne _0215D57C
	mov r0, r7
	bl ovl02_2164344
	b _0215D58C
_0215D57C:
	cmp sl, #1
	bne _0215D58C
	mov r0, r7
	bl ovl02_216446C
_0215D58C:
	mov r0, r7
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_0215D598: .word 0x00000904
_0215D59C: .word StageTask_Main
_0215D5A0: .word ovl02_2163B3C
_0215D5A4: .word ovl02_2163B24
_0215D5A8: .word ovl02_2163B48
_0215D5AC: .word ovl02_2163B7C
_0215D5B0: .word 0x00000102
_0215D5B4: .word ovl02_2163BFC
_0215D5B8: .word _021796C0
	arm_func_end Boss7Unknown__Create

	arm_func_start Boss7Johnny__Create
Boss7Johnny__Create: // 0x0215D5BC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x74
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	ldr r0, _0215DA78 // =StageTask_Main
	ldr r1, _0215DA7C // =ovl02_21646A0
	mov r3, r2
	str r4, [sp, #4]
	mov r4, #0xdc0
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0xdc0
	bl MI_CpuFill8
	mov r1, r7
	mov r0, r4
	mov r2, #0
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, _0215DA80 // =ovl02_216461C
	ldr r0, _0215DA84 // =ovl02_21646E0
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r0, _0215DA88 // =ovl02_2164AE0
	mov r2, #0x400
	str r0, [r4, #0x108]
	ldr r0, [r4, #0x18]
	add r1, r4, #0x300
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r3, [r4, #0x1c]
	add r0, r4, #0x364
	orr r3, r3, #0x2c0
	orr r3, r3, #0x80000
	str r3, [r4, #0x1c]
	strh r2, [r1, #0xd2]
	str r6, [r4, #0x44]
	str r5, [r4, #0x48]
	bl ovl02_215DAB8
	add r5, r4, #0x3fc
	mov r0, r5
	mov r1, #2
	mov r2, #0
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r3, _0215DA8C // =_021796C0
	mov r0, r5
	ldrsh r1, [r3, #0x5e]
	str r1, [sp]
	ldrsh r1, [r3, #0x58]
	ldrsh r2, [r3, #0x5a]
	ldrsh r3, [r3, #0x5c]
	bl ObjRect__SetBox2D
	str r4, [r5, #0x1c]
	ldr r1, _0215DA90 // =ovl02_2164BAC
	ldr r0, _0215DA94 // =0x00000102
	str r1, [r5, #0x24]
	strh r0, [r5, #0x34]
	ldr r1, [r5, #0x18]
	add r0, r4, #0xbc
	orr r1, r1, #0x400
	str r1, [r5, #0x18]
	add r6, r0, #0x400
	mov r0, r6
	mov r1, #2
	mov r2, #0
	bl ObjRect__SetAttackStat
	mov r0, r6
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r3, _0215DA8C // =_021796C0
	mov r0, r6
	ldrsh r1, [r3, #0x76]
	str r1, [sp]
	ldrsh r1, [r3, #0x70]
	ldrsh r2, [r3, #0x72]
	ldrsh r3, [r3, #0x74]
	bl ObjRect__SetBox2D
	add r0, r4, #0x3c
	add r5, r0, #0x400
	ldr r1, _0215DA90 // =ovl02_2164BAC
	str r4, [r6, #0x1c]
	ldr r0, _0215DA94 // =0x00000102
	str r1, [r6, #0x24]
	strh r0, [r6, #0x34]
	ldr r1, [r6, #0x18]
	mov r0, r5
	orr r2, r1, #0x400
	mov r1, #2
	str r2, [r6, #0x18]
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r3, _0215DA8C // =_021796C0
	mov r0, r5
	ldrsh r1, [r3, #0x66]
	str r1, [sp]
	ldrsh r1, [r3, #0x60]
	ldrsh r2, [r3, #0x62]
	ldrsh r3, [r3, #0x64]
	bl ObjRect__SetBox2D
	str r4, [r5, #0x1c]
	ldr r1, _0215DA98 // =ovl02_2164D8C
	ldr r0, _0215DA94 // =0x00000102
	str r1, [r5, #0x20]
	strh r0, [r5, #0x34]
	ldr r1, [r5, #0x18]
	add r0, r4, #0xfc
	bic r1, r1, #4
	str r1, [r5, #0x18]
	add r5, r0, #0x400
	mov r0, r5
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r3, _0215DA8C // =_021796C0
	mov r0, r5
	ldrsh r1, [r3, #0x7e]
	str r1, [sp]
	ldrsh r1, [r3, #0x78]
	ldrsh r2, [r3, #0x7a]
	ldrsh r3, [r3, #0x7c]
	bl ObjRect__SetBox2D
	str r4, [r5, #0x1c]
	ldr r1, _0215DA98 // =ovl02_2164D8C
	ldr r0, _0215DA94 // =0x00000102
	str r1, [r5, #0x20]
	strh r0, [r5, #0x34]
	ldr r0, [r5, #0x18]
	add r6, r4, #0x1f4
	bic r0, r0, #4
	str r0, [r5, #0x18]
	add r0, r6, #0x800
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #0
	ldr r0, _0215DA9C // =bossAssetFiles
	str r3, [sp]
	ldr r1, [r0]
	add r0, r6, #0x800
	mov r2, #1
	bl AnimatorMDL__SetResource
	ldr r1, _0215DAA0 // =0x000034CC
	mov r0, #4
	str r1, [r6, #0x818]
	str r1, [r6, #0x81c]
	str r1, [r6, #0x820]
	strb r0, [r6, #0x80a]
	mov r0, #0xf
	strb r0, [r6, #0x80b]
	mov r5, #3
	ldr r1, _0215DAA4 // =BossHelpers__Model__RenderCallback
	add r0, r6, #0x890
	mov r2, #0
	mov r3, #6
	str r5, [sp]
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	ldr r0, [r6, #0x894]
	ldr r1, _0215DAA8 // =aHip
	mov r2, #0x1a
	bl BossHelpers__Model__Init
	mov r3, #0
	str r3, [sp]
	ldr r0, [r6, #0x894]
	ldr r1, _0215DAAC // =aHead_1
	mov r2, #0x19
	bl BossHelpers__Model__Init
	ldr r2, _0215DAB0 // =gameArchiveStage
	ldr r1, _0215DAB4 // =_02179768
	ldr r2, [r2]
	add r0, sp, #0xc
	bl NNS_FndMountArchive
	add r6, r4, #0x7c
	add r0, r6, #0xc00
	mov r1, #0
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #0xa
	bl NNS_FndGetArchiveFileByIndex
	mov r2, #0
	mov r1, r0
	add r0, r6, #0xc00
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	add r0, sp, #0xc
	mov r1, #0xb
	bl NNS_FndGetArchiveFileByIndex
	mov r1, #0
	mov r2, r0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r6, #0xc00
	mov r3, r1
	bl BossHelpers__Animation__Func_2038BF0
	add r0, sp, #0xc
	mov r1, #0xc
	bl NNS_FndGetArchiveFileByIndex
	mov r3, #0
	mov r2, r0
	str r3, [sp]
	mov r1, #1
	add r0, r6, #0xc00
	str r1, [sp, #4]
	bl BossHelpers__Animation__Func_2038BF0
	add r0, sp, #0xc
	mov r1, #0xd
	bl NNS_FndGetArchiveFileByIndex
	mov r3, #0
	mov r2, r0
	str r3, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r6, #0xc00
	mov r1, #4
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _0215DAA0 // =0x000034CC
	add r5, r4, #0x338
	str r0, [r6, #0xc18]
	str r0, [r6, #0xc1c]
	str r0, [r6, #0xc20]
	add r0, r5, #0x800
	mov r1, #0
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #0xe
	bl NNS_FndGetArchiveFileByIndex
	mov r2, #0
	mov r1, r0
	add r0, r5, #0x800
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	add r0, sp, #0xc
	mov r1, #0xf
	bl NNS_FndGetArchiveFileByIndex
	mov r1, #0
	mov r2, r0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r5, #0x800
	mov r3, r1
	bl BossHelpers__Animation__Func_2038BF0
	add r0, sp, #0xc
	mov r1, #0x10
	bl NNS_FndGetArchiveFileByIndex
	mov r6, r0
	add r0, sp, #0xc
	mov r1, #0xe
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dGetTex
	str r0, [sp]
	mov r0, #1
	str r0, [sp, #4]
	mov r2, r6
	add r0, r5, #0x800
	mov r1, #2
	mov r3, #0
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, _0215DAA0 // =0x000034CC
	add r0, sp, #0xc
	str r1, [r5, #0x818]
	str r1, [r5, #0x81c]
	str r1, [r5, #0x820]
	bl NNS_FndUnmountArchive
	mvn r5, #1
	mov r0, r4
	sub r1, r5, #6
	sub r2, r5, #8
	mov r3, #8
	str r5, [sp]
	bl StageTask__SetHitbox
	mov r0, r4
	bl ovl02_2167540
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	bl ovl02_21650F4
	mov r0, r4
	add sp, sp, #0x74
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215DA78: .word StageTask_Main
_0215DA7C: .word ovl02_21646A0
_0215DA80: .word ovl02_216461C
_0215DA84: .word ovl02_21646E0
_0215DA88: .word ovl02_2164AE0
_0215DA8C: .word _021796C0
_0215DA90: .word ovl02_2164BAC
_0215DA94: .word 0x00000102
_0215DA98: .word ovl02_2164D8C
_0215DA9C: .word bossAssetFiles
_0215DAA0: .word 0x000034CC
_0215DAA4: .word BossHelpers__Model__RenderCallback
_0215DAA8: .word aHip
_0215DAAC: .word aHead_1
_0215DAB0: .word gameArchiveStage
_0215DAB4: .word _02179768
	arm_func_end Boss7Johnny__Create

	arm_func_start ovl02_215DAB8
ovl02_215DAB8: // 0x0215DAB8
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x68
	mov r4, r0
	bl MapFarSys__GetAsset
	str r0, [r4]
	ldr r1, _0215DB10 // =gameArchiveStage
	add r0, sp, #0
	ldr r2, [r1]
	ldr r1, _0215DB14 // =_02179768
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #6
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #4]
	add r0, sp, #0
	mov r1, #7
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #8]
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	add sp, sp, #0x68
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215DB10: .word gameArchiveStage
_0215DB14: .word _02179768
	arm_func_end ovl02_215DAB8

	arm_func_start ovl02_215DB18
ovl02_215DB18: // 0x0215DB18
	ldr r2, [r0, #0x340]
	ldrh r3, [r2, #2]
	cmp r3, #0x134
	bne _0215DB38
	add r1, r0, #0x300
	add r0, r0, #0x374
	ldrh r1, [r1, #0xd0]
	b _0215DB4C
_0215DB38:
	ldr r2, _0215DB54 // =0x00000137
	cmp r3, r2
	addeq r1, r0, #0x300
	ldreqh r1, [r1, #0xd0]
	addeq r0, r0, #0x374
_0215DB4C:
	ldr ip, _0215DB58 // =Input__ReadFromValue
	bx ip
	.align 2, 0
_0215DB54: .word 0x00000137
_0215DB58: .word ReadPadInput
	arm_func_end ovl02_215DB18

	arm_func_start ovl02_215DB5C
ovl02_215DB5C: // 0x0215DB5C
	ldr r0, _0215DB7C // =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #3
	ldreq r0, [r0, #0x70]
	cmpeq r0, #0xe
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_0215DB7C: .word gameState
	arm_func_end ovl02_215DB5C

	arm_func_start ovl02_215DB80
ovl02_215DB80: // 0x0215DB80
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	sub sp, sp, #0x18
	mov r8, r0
	ldr r3, [r8, #0x370]
	mov r4, #0xcc
	cmp r3, #0
	ldrne r1, [r8, #0x374]
	cmpne r1, #0
	beq _0215DBD4
	add r2, sp, #0
	add r0, r3, #0x44
	add r1, r1, #0x44
	bl VEC_Add
	ldr r1, [sp]
	ldr r0, [sp, #4]
	mov r1, r1, asr #1
	mov r0, r0, asr #1
	str r0, [sp, #4]
	str r1, [sp]
	add r0, sp, #0
	b _0215DBEC
_0215DBD4:
	cmp r3, #0
	addne r0, r3, #0x44
	bne _0215DBEC
	ldr r1, [r8, #0x374]
	cmp r1, #0
	addne r0, r1, #0x44
_0215DBEC:
	ldr r1, _0215DECC // =gPlayer
	add r2, sp, #0xc
	ldr r1, [r1]
	add r1, r1, #0x44
	bl VEC_Subtract
	ldr r0, _0215DECC // =gPlayer
	ldr r1, [sp, #0xc]
	ldr r3, [r0]
	ldr r2, [sp, #0x10]
	ldr r0, [r3, #0x44]
	ldr r3, [r3, #0x48]
	add r0, r0, r1, asr #3
	str r0, [r8, #0x390]
	add r0, r3, r2, asr #3
	str r0, [r8, #0x394]
	mov r0, #0
	str r0, [r8, #0x398]
	ldr r3, [sp, #0x10]
	ldr r2, [sp, #0xc]
	cmp r3, #0
	rsblt r0, r3, #0
	movge r0, r3
	cmp r2, #0
	rsblt r1, r2, #0
	movge r1, r2
	cmp r1, r0
	ble _0215DCA0
	cmp r2, #0
	rsblt r2, r2, #0
	adds r6, r2, #0x96000
	movmi r6, #0
	bmi _0215DC74
	cmp r6, #0x160000
	movgt r6, #0x160000
_0215DC74:
	mov r0, #0xc00
	umull r3, r2, r6, r0
	mov r1, #0
	mla r2, r6, r1, r2
	mov r1, r6, asr #0x1f
	adds r3, r3, #0x800
	mla r2, r1, r0, r2
	adc r0, r2, #0
	mov r5, r3, lsr #0xc
	orr r5, r5, r0, lsl #20
	b _0215DCE4
_0215DCA0:
	cmp r3, #0
	rsblt r3, r3, #0
	adds r5, r3, #0x96000
	movmi r5, #0
	bmi _0215DCBC
	cmp r5, #0x108000
	movgt r5, #0x108000
_0215DCBC:
	ldr r0, _0215DED0 // =0x00001555
	mov r1, #0
	umull r3, r2, r5, r0
	mla r2, r5, r1, r2
	mov r1, r5, asr #0x1f
	adds r3, r3, #0x800
	mla r2, r1, r0, r2
	adc r0, r2, #0
	mov r6, r3, lsr #0xc
	orr r6, r6, r0, lsl #20
_0215DCE4:
	cmp r5, #0x64000
	movle r5, #0x64000
	ble _0215DD08
	cmp r5, #0xb4000
	movle r5, #0xb4000
	ble _0215DD08
	cmp r5, #0xfa000
	movle r5, #0xfa000
	movgt r5, #0x17c000
_0215DD08:
	ldr r1, _0215DED4 // =0x02113750
	ldrsh r0, [r1, #0x38]
	ldrsh r1, [r1, #0x3a]
	bl FX_Div
	mov r2, r5, asr #1
	smull r3, r1, r0, r2
	adds r0, r3, #0x800
	adc r3, r1, #0
	mov r1, r0, lsr #0xc
	orr r1, r1, r3, lsl #20
	ldr r0, [r8, #0x39c]
	ldr r3, _0215DED8 // =0x00000355
	cmp r0, r1
	mov ip, #0
	umull sb, r0, r5, r3
	mla r0, r5, ip, r0
	mov lr, r5, asr #0x1f
	movgt r7, #0x100
	mla r0, lr, r3, r0
	ldr ip, _0215DECC // =gPlayer
	str r1, [r8, #0x39c]
	ldr r3, [ip]
	movle r7, #0x80
	adds r1, sb, #0x800
	ldr r3, [r3, #0x44]
	mov sb, r1, lsr #0xc
	adc r0, r0, #0
	orr sb, sb, r0, lsl #20
	ldr r1, [r8, #0x390]
	sub ip, r3, #0x100000
	cmp r1, ip
	add r0, r2, sb
	blt _0215DD98
	add ip, r3, #0x100000
	cmp r1, ip
	movle ip, r1
_0215DD98:
	mov r1, r6, asr #1
	sub r3, r1, #0x20000
	str ip, [r8, #0x390]
	cmp ip, r3
	blt _0215DDB8
	rsb r3, r1, #0x2e0000
	cmp ip, r3
	movle r3, ip
_0215DDB8:
	ldr r1, _0215DECC // =gPlayer
	str r3, [r8, #0x390]
	ldr r1, [r1]
	ldr r1, [r1, #0x48]
	cmp r1, #0x1a0000
	ldr r1, [r8, #0x394]
	bgt _0215DE20
	rsb r6, r0, #0
	sub r1, r1, r6
	sub r0, r1, r0
	add r0, r2, r0
	cmp r0, #0x1a0000
	blt _0215DE14
	mov r0, r5
	bl _f_itof
	mov r1, r0
	ldr r0, _0215DEDC // =0x3EB33333
	bl _f_mul
	bl _f_ftoi
	mov r1, #0x1a0000
	str r1, [r8, #0x394]
	rsb r6, r0, #0
	mov r4, #0x100
_0215DE14:
	mov r0, #0
	bl SetHUDActiveScreen
	b _0215DE60
_0215DE20:
	mov r6, r0
	sub r0, r1, r2
	cmp r0, #0x1a0000
	bge _0215DE58
	mov r0, r5
	bl _f_itof
	mov r1, r0
	ldr r0, _0215DEDC // =0x3EB33333
	bl _f_mul
	bl _f_ftoi
	mov r1, #0x1a0000
	mov r6, r0
	str r1, [r8, #0x394]
	mov r4, #0x100
_0215DE58:
	mov r0, #1
	bl SetHUDActiveScreen
_0215DE60:
	mov r0, #0
	bl BossArena__GetCamera
	ldr r2, [r8, #0x394]
	ldr r1, [r8, #0x390]
	ldr r3, [r8, #0x398]
	mov r5, r0
	sub r2, r6, r2
	bl BossArena__SetTracker1TargetPos
	mov r0, r5
	mov r1, r4
	mov r2, #0
	bl BossArena__SetTracker1Speed
	ldr r1, [r8, #0x39c]
	mov r0, r5
	mov r1, r1, lsl #1
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r5
	mov r1, r7
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r5
	mov r1, #0x64000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r5
	mov r1, #0x100
	bl BossArena__SetAmplitudeYSpeed
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_0215DECC: .word gPlayer
_0215DED0: .word 0x00001555
_0215DED4: .word 0x02113750
_0215DED8: .word 0x00000355
_0215DEDC: .word 0x3EB33333
	arm_func_end ovl02_215DB80

	arm_func_start ovl02_215DEE0
ovl02_215DEE0: // 0x0215DEE0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r6, r0
	add r0, r6, #0x9b0
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r6, #0x370]
	ldr r0, [r0, #0x3fc]
	cmp r0, #0
	beq _0215DF18
	cmp r0, #1
	beq _0215DF2C
	b _0215DF40
_0215DF18:
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, #0x96000
	sub r5, r4, #0xaf000
	b _0215DF40
_0215DF2C:
	mov r0, #1
	bl BossArena__GetCamera
	mov r4, #0x64000
	rsb r4, r4, #0
	mov r5, #0xc8000
_0215DF40:
	mov r0, #0
	bl BossArena__GetCamera
	mov r1, #0
	ldr ip, [r6, #0x370]
	mov lr, #1
	mov r2, r1
	mov r3, r1
	str lr, [ip, #0x3ec]
	mov r7, r0
	bl BossArena__SetTracker1TargetWork
	ldr r0, [sp, #4]
	ldr r1, [sp]
	add r2, r0, r4
	ldr r3, [sp, #8]
	mov r0, r7
	bl BossArena__SetTracker1TargetPos
	mov r0, r7
	mov r1, r5
	bl BossArena__SetAmplitudeYTarget
	mov r0, r7
	mov r1, #0x3e8000
	bl BossArena__SetAmplitudeXZTarget
	ldr r0, [r6, #0x44]
	cmp r0, #0x160000
	mov r0, r7
	bgt _0215DFB4
	mov r1, #0x2000
	bl BossArena__SetAngleTarget
	b _0215DFBC
_0215DFB4:
	mov r1, #0xe000
	bl BossArena__SetAngleTarget
_0215DFBC:
	ldr r2, _0215DFD4 // =0x00000333
	mov r0, r7
	mov r1, #0x100
	bl BossArena__SetTracker0Speed
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215DFD4: .word 0x00000333
	arm_func_end ovl02_215DEE0

	arm_func_start ovl02_215DFD8
ovl02_215DFD8: // 0x0215DFD8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r6, r0
	add r0, r6, #0x1b8
	add r0, r0, #0x800
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r6, #0x370]
	ldr r0, [r0, #0x3fc]
	cmp r0, #0
	beq _0215E01C
	cmp r0, #1
	moveq r4, #0x64000
	rsbeq r4, r4, #0
	moveq r5, #0xc8000
	b _0215E024
_0215E01C:
	mov r4, #0x96000
	sub r5, r4, #0xaf000
_0215E024:
	mov r0, #0
	bl BossArena__GetCamera
	mov r1, #0
	ldr ip, [r6, #0x370]
	mov lr, #1
	mov r2, r1
	mov r3, r1
	str lr, [ip, #0x3ec]
	mov r7, r0
	bl BossArena__SetTracker1TargetWork
	ldr r0, [sp, #4]
	ldr r1, [sp]
	add r2, r0, r4
	ldr r3, [sp, #8]
	mov r0, r7
	bl BossArena__SetTracker1TargetPos
	mov r0, r7
	mov r1, r5
	bl BossArena__SetAmplitudeYTarget
	mov r0, r7
	mov r1, #0x3e8000
	bl BossArena__SetAmplitudeXZTarget
	ldr r0, [r6, #0x44]
	cmp r0, #0x160000
	mov r0, r7
	bgt _0215E098
	mov r1, #0x2000
	bl BossArena__SetAngleTarget
	b _0215E0A0
_0215E098:
	mov r1, #0xe000
	bl BossArena__SetAngleTarget
_0215E0A0:
	ldr r2, _0215E0B8 // =0x00000333
	mov r0, r7
	mov r1, #0x100
	bl BossArena__SetTracker0Speed
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0215E0B8: .word 0x00000333
	arm_func_end ovl02_215DFD8

	arm_func_start ovl02_215E0BC
ovl02_215E0BC: // 0x0215E0BC
	stmdb sp!, {r4, lr}
	mov r1, #0
	str r1, [r0, #0x3ec]
	mov r0, #2
	bl BossArena__SetType
	mov r0, #0
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #0
	bl BossArena__SetAngleTarget
	mov r0, r4
	mov r1, #0x200
	mov r2, #0
	bl BossArena__SetTracker0Speed
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_215E0BC

	arm_func_start ovl02_215E0F8
ovl02_215E0F8: // 0x0215E0F8
	ldr r2, [r0, #0x98]
	cmp r2, #0
	movgt r2, #0x8000
	bgt _0215E128
	movgt r2, #0x8000
	rsbgt r2, r2, #0
	bgt _0215E128
	ldr r2, [r0, #0x44]
	ldr r0, [r1, #0x44]
	cmp r2, r0
	mov r2, #0x8000
	rsbge r2, r2, #0
_0215E128:
	ldr r0, [r1, #0x1c]
	tst r0, #0x8000
	strne r2, [r1, #0x98]
	streq r2, [r1, #0xc8]
	ldr r2, [r1, #0x9c]
	mov r0, #0x5000
	add r2, r2, r2, asr #1
	rsb r3, r2, #0
	rsb r0, r0, #0
	str r3, [r1, #0x9c]
	cmp r3, r0
	movlt r3, r0
	blt _0215E164
	cmp r3, #0x5000
	movgt r3, #0x5000
_0215E164:
	str r3, [r1, #0x9c]
	bx lr
	arm_func_end ovl02_215E0F8

	arm_func_start ovl02_215E16C
ovl02_215E16C: // 0x0215E16C
	ldr r2, [r0, #0x44]
	ldr r0, [r1, #0x44]
	mov r3, #0x3000
	cmp r2, r0
	mov r2, #0x3000
	ldr ip, _0215E198 // =Player__Gimmick_Jump
	rsbge r3, r3, #0
	mov r0, r1
	mov r1, r3
	rsb r2, r2, #0
	bx ip
	.align 2, 0
_0215E198: .word Player__Gimmick_Jump
	arm_func_end ovl02_215E16C

	arm_func_start ovl02_215E19C
ovl02_215E19C: // 0x0215E19C
	ldr r0, [r0, #0x1c]
	tst r0, #1
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end ovl02_215E19C

	arm_func_start ovl02_215E1B0
ovl02_215E1B0: // 0x0215E1B0
	add r1, r0, #0x300
	ldrh r1, [r1, #0x58]
	cmp r1, #1
	bxne lr
	add r1, r0, #0x500
	mov r2, #0
	strh r2, [r1, #0x7a]
	ldr r1, [r0, #0x3d4]
	tst r1, #2
	ldr r1, [r0, #0x20]
	bicne r1, r1, #1
	strne r1, [r0, #0x20]
	orreq r1, r1, #1
	streq r1, [r0, #0x20]
	bx lr
	arm_func_end ovl02_215E1B0

	arm_func_start ovl02_215E1EC
ovl02_215E1EC: // 0x0215E1EC
	add r1, r0, #0x300
	ldrh r1, [r1, #0x58]
	cmp r1, #1
	bxne lr
	add r1, r0, #0x500
	mov r2, #0
	strh r2, [r1, #0x80]
	ldr r1, [r0, #0x3d4]
	tst r1, #2
	ldr r1, [r0, #0x20]
	bicne r1, r1, #1
	strne r1, [r0, #0x20]
	orreq r1, r1, #1
	streq r1, [r0, #0x20]
	bx lr
	arm_func_end ovl02_215E1EC

	arm_func_start ovl02_215E228
ovl02_215E228: // 0x0215E228
	ldr r1, [r0, #0x370]
	cmp r1, #0
	moveq r0, #0
	bxeq lr
	add r0, r1, #0x300
	ldrsh r0, [r0, #0xd2]
	cmp r0, #0
	movle r0, #0
	bxle lr
	ldr r0, [r1, #0x18]
	tst r0, #0xc
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end ovl02_215E228

	arm_func_start ovl02_215E260
ovl02_215E260: // 0x0215E260
	ldr r1, [r0, #0x374]
	cmp r1, #0
	moveq r0, #0
	bxeq lr
	add r0, r1, #0x300
	ldrsh r0, [r0, #0xd2]
	cmp r0, #0
	movle r0, #0
	bxle lr
	ldr r0, [r1, #0x18]
	tst r0, #0xc
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end ovl02_215E260

	arm_func_start ovl02_215E298
ovl02_215E298: // 0x0215E298
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EDFC
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r4, pc}
_0215E2B0: // jump table
	b _0215E2C8 // case 0
	b _0215E2D4 // case 1
	b _0215E3A8 // case 2
	b _0215E3B4 // case 3
	b _0215E3D8 // case 4
	b _0215E3FC // case 5
_0215E2C8:
	mov r0, r4
	bl ovl02_2166D68
	ldmia sp!, {r4, pc}
_0215E2D4:
	ldr r1, _0215E408 // =gPlayer
	mov r0, #0x80000
	ldr r3, [r1]
	ldr r1, [r4, #0x48]
	ldr r2, [r3, #0x48]
	rsb r0, r0, #0
	sub r1, r2, r1
	cmp r1, r0
	bge _0215E358
	ldr r0, [r3, #0x1c]
	tst r0, #1
	beq _0215E358
	mov r0, r4
	bl ovl02_215E40C
	cmp r0, #0
	bne _0215E358
	ldr r1, _0215E408 // =gPlayer
	mov r0, #0x100000
	ldr r2, [r1]
	ldr r3, [r4, #0x44]
	ldr r1, [r2, #0x48]
	rsb r0, r0, #0
	sub r1, r1, r3
	cmp r1, r0
	bgt _0215E34C
	ldr r0, [r2, #0x44]
	subs r0, r0, r3
	rsbmi r0, r0, #0
	cmp r0, #0x100000
	ldmgeia sp!, {r4, pc}
_0215E34C:
	mov r0, r4
	bl ovl02_2166F00
	ldmia sp!, {r4, pc}
_0215E358:
	ldr r0, _0215E408 // =gPlayer
	ldr r1, [r4, #0x48]
	ldr r2, [r0]
	ldr r0, [r2, #0x48]
	sub r0, r0, r1
	cmp r0, #0x40000
	ble _0215E39C
	ldr r0, [r2, #0x1c]
	tst r0, #1
	beq _0215E39C
	mov r0, r4
	bl ovl02_215E40C
	cmp r0, #0
	bne _0215E39C
	mov r0, r4
	bl ovl02_2166FC4
	ldmia sp!, {r4, pc}
_0215E39C:
	mov r0, r4
	bl ovl02_2166E54
	ldmia sp!, {r4, pc}
_0215E3A8:
	mov r0, r4
	bl ovl02_21670AC
	ldmia sp!, {r4, pc}
_0215E3B4:
	mov r0, r4
	bl ovl02_215EEEC
	cmp r0, #0
	mov r0, r4
	bne _0215E3D0
	bl ovl02_2167294
	ldmia sp!, {r4, pc}
_0215E3D0:
	bl ovl02_2167324
	ldmia sp!, {r4, pc}
_0215E3D8:
	mov r0, r4
	bl ovl02_215EF0C
	cmp r0, #0
	mov r0, r4
	bne _0215E3F4
	bl ovl02_21673B4
	ldmia sp!, {r4, pc}
_0215E3F4:
	bl ovl02_2167418
	ldmia sp!, {r4, pc}
_0215E3FC:
	mov r0, r4
	bl ovl02_216747C
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E408: .word gPlayer
	arm_func_end ovl02_215E298

	arm_func_start ovl02_215E40C
ovl02_215E40C: // 0x0215E40C
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #5
	blo _0215E428
	cmp r0, #0x27
	movls r0, #1
	bxls lr
_0215E428:
	mov r0, #0
	bx lr
	arm_func_end ovl02_215E40C

	arm_func_start ovl02_215E430
ovl02_215E430: // 0x0215E430
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #0x25
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end ovl02_215E430

	arm_func_start ovl02_215E448
ovl02_215E448: // 0x0215E448
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #1
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end ovl02_215E448

	arm_func_start ovl02_215E460
ovl02_215E460: // 0x0215E460
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #5
	blo _0215E47C
	cmp r0, #9
	movls r0, #1
	bxls lr
_0215E47C:
	mov r0, #0
	bx lr
	arm_func_end ovl02_215E460

	arm_func_start ovl02_215E484
ovl02_215E484: // 0x0215E484
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #0xa
	blo _0215E4A0
	cmp r0, #0x12
	movls r0, #1
	bxls lr
_0215E4A0:
	mov r0, #0
	bx lr
	arm_func_end ovl02_215E484

	arm_func_start ovl02_215E4A8
ovl02_215E4A8: // 0x0215E4A8
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #0x13
	blo _0215E4C4
	cmp r0, #0x16
	movls r0, #1
	bxls lr
_0215E4C4:
	mov r0, #0
	bx lr
	arm_func_end ovl02_215E4A8

	arm_func_start ovl02_215E4CC
ovl02_215E4CC: // 0x0215E4CC
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #0x17
	blo _0215E4E8
	cmp r0, #0x1a
	movls r0, #1
	bxls lr
_0215E4E8:
	mov r0, #0
	bx lr
	arm_func_end ovl02_215E4CC

	arm_func_start ovl02_215E4F0
ovl02_215E4F0: // 0x0215E4F0
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #0x1b
	blo _0215E50C
	cmp r0, #0x1e
	movls r0, #1
	bxls lr
_0215E50C:
	mov r0, #0
	bx lr
	arm_func_end ovl02_215E4F0

	arm_func_start ovl02_215E514
ovl02_215E514: // 0x0215E514
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #0x25
	blo _0215E530
	cmp r0, #0x27
	movls r0, #1
	bxls lr
_0215E530:
	mov r0, #0
	bx lr
	arm_func_end ovl02_215E514

	arm_func_start ovl02_215E538
ovl02_215E538: // 0x0215E538
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #0x28
	blo _0215E554
	cmp r0, #0x2a
	movls r0, #1
	bxls lr
_0215E554:
	mov r0, #0
	bx lr
	arm_func_end ovl02_215E538

	arm_func_start ovl02_215E55C
ovl02_215E55C: // 0x0215E55C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x3d4]
	tst r1, #0x40
	beq _0215E580
	bic r1, r1, #0x40
	str r1, [r4, #0x3d4]
	bl ovl02_2167A3C
	ldmia sp!, {r4, pc}
_0215E580:
	bl ovl02_215EF2C
	cmp r0, #0
	beq _0215E5A0
	cmp r0, #1
	beq _0215E5AC
	cmp r0, #2
	beq _0215E680
	ldmia sp!, {r4, pc}
_0215E5A0:
	mov r0, r4
	bl ovl02_2167540
	ldmia sp!, {r4, pc}
_0215E5AC:
	ldr r1, _0215E6B8 // =gPlayer
	mov r0, #0x80000
	ldr r3, [r1]
	ldr r1, [r4, #0x48]
	ldr r2, [r3, #0x48]
	rsb r0, r0, #0
	sub r1, r2, r1
	cmp r1, r0
	bge _0215E630
	ldr r0, [r3, #0x1c]
	tst r0, #1
	beq _0215E630
	mov r0, r4
	bl ovl02_215E6BC
	cmp r0, #0
	bne _0215E630
	ldr r1, _0215E6B8 // =gPlayer
	mov r0, #0x100000
	ldr r2, [r1]
	ldr r3, [r4, #0x44]
	ldr r1, [r2, #0x48]
	rsb r0, r0, #0
	sub r1, r1, r3
	cmp r1, r0
	bgt _0215E624
	ldr r0, [r2, #0x44]
	subs r0, r0, r3
	rsbmi r0, r0, #0
	cmp r0, #0x100000
	ldmgeia sp!, {r4, pc}
_0215E624:
	mov r0, r4
	bl ovl02_21676D8
	ldmia sp!, {r4, pc}
_0215E630:
	ldr r0, _0215E6B8 // =gPlayer
	ldr r1, [r4, #0x48]
	ldr r2, [r0]
	ldr r0, [r2, #0x48]
	sub r0, r0, r1
	cmp r0, #0x40000
	ble _0215E674
	ldr r0, [r2, #0x1c]
	tst r0, #1
	beq _0215E674
	mov r0, r4
	bl ovl02_215E6BC
	cmp r0, #0
	bne _0215E674
	mov r0, r4
	bl ovl02_216779C
	ldmia sp!, {r4, pc}
_0215E674:
	mov r0, r4
	bl ovl02_216762C
	ldmia sp!, {r4, pc}
_0215E680:
	ldr r1, _0215E6B8 // =gPlayer
	mov r0, #0x80000
	ldr r2, [r1]
	ldr r1, [r4, #0x48]
	ldr r2, [r2, #0x48]
	rsb r0, r0, #0
	sub r1, r2, r1
	cmp r1, r0
	mov r0, r4
	bge _0215E6B0
	bl ovl02_21676D8
	ldmia sp!, {r4, pc}
_0215E6B0:
	bl ovl02_2167884
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215E6B8: .word gPlayer
	arm_func_end ovl02_215E55C

	arm_func_start ovl02_215E6BC
ovl02_215E6BC: // 0x0215E6BC
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #5
	blo _0215E6D8
	cmp r0, #0x1b
	movls r0, #1
	bxls lr
_0215E6D8:
	mov r0, #0
	bx lr
	arm_func_end ovl02_215E6BC

	arm_func_start ovl02_215E6E0
ovl02_215E6E0: // 0x0215E6E0
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #1
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end ovl02_215E6E0

	arm_func_start ovl02_215E6F8
ovl02_215E6F8: // 0x0215E6F8
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #5
	blo _0215E714
	cmp r0, #7
	movls r0, #1
	bxls lr
_0215E714:
	mov r0, #0
	bx lr
	arm_func_end ovl02_215E6F8

	arm_func_start ovl02_215E71C
ovl02_215E71C: // 0x0215E71C
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #8
	blo _0215E738
	cmp r0, #0xd
	movls r0, #1
	bxls lr
_0215E738:
	mov r0, #0
	bx lr
	arm_func_end ovl02_215E71C

	arm_func_start ovl02_215E740
ovl02_215E740: // 0x0215E740
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #0xa
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end ovl02_215E740

	arm_func_start ovl02_215E758
ovl02_215E758: // 0x0215E758
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #0xb
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end ovl02_215E758

	arm_func_start ovl02_215E770
ovl02_215E770: // 0x0215E770
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #0x14
	blo _0215E78C
	cmp r0, #0x1b
	movls r0, #1
	bxls lr
_0215E78C:
	mov r0, #0
	bx lr
	arm_func_end ovl02_215E770

	arm_func_start ovl02_215E794
ovl02_215E794: // 0x0215E794
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #0x15
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end ovl02_215E794

	arm_func_start ovl02_215E7AC
ovl02_215E7AC: // 0x0215E7AC
	ldr r1, [r0, #0x3d4]
	tst r1, #0x100
	moveq r0, #0
	bxeq lr
	bic r1, r1, #0x100
	str r1, [r0, #0x3d4]
	mov r0, #1
	bx lr
	arm_func_end ovl02_215E7AC

	arm_func_start ovl02_215E7CC
ovl02_215E7CC: // 0x0215E7CC
	add r0, r0, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #0x19
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end ovl02_215E7CC

	arm_func_start ovl02_215E7E4
ovl02_215E7E4: // 0x0215E7E4
	ldrsh r2, [r1, #0xec]
	ldr ip, [r1, #0x44]
	mov r3, r2, lsl #0xc
	adds r2, ip, r2, lsl #12
	bpl _0215E814
	ldr r2, [r1, #0xbc]
	rsb r3, r3, #0
	sub r2, r3, r2
	str r2, [r1, #0x44]
	mov r2, #0
	str r2, [r1, #0x98]
	b _0215E840
_0215E814:
	ldrsh r3, [r1, #0xf0]
	add r2, ip, r3, lsl #12
	cmp r2, #0x2c0000
	mov r3, r3, lsl #0xc
	ble _0215E840
	ldr r2, [r1, #0xbc]
	rsb r3, r3, #0x2c0000
	sub r2, r3, r2
	str r2, [r1, #0x44]
	mov r2, #0
	str r2, [r1, #0x98]
_0215E840:
	ldrsh r2, [r1, #0xee]
	ldr ip, [r1, #0x48]
	mov r3, r2, lsl #0xc
	adds r2, ip, r2, lsl #12
	bpl _0215E878
	ldr r0, [r1, #0xc0]
	rsb r2, r3, #0
	sub r0, r2, r0
	str r0, [r1, #0x48]
	ldr r0, [r1, #0x9c]
	cmp r0, #0
	movlt r0, #0
	strlt r0, [r1, #0x9c]
	bx lr
_0215E878:
	ldrsh r3, [r1, #0xf2]
	ldr r2, [r0, #0x48]
	add r0, ip, r3, lsl #12
	cmp r0, r2
	bxle lr
	ldr r0, [r1, #0xc0]
	sub r2, r2, r3, lsl #12
	sub r0, r2, r0
	str r0, [r1, #0x48]
	ldr r0, [r1, #0x9c]
	cmp r0, #0
	movgt r0, #0
	strgt r0, [r1, #0x9c]
	bx lr
	arm_func_end ovl02_215E7E4

	arm_func_start ovl02_215E8B0
ovl02_215E8B0: // 0x0215E8B0
	ldr r1, _0215E904 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r1, [r1, #0x70]
	cmpeq r1, #0xf
	moveq r0, #3
	bxeq lr
	add r0, r0, #0x300
	ldrsh r3, [r0, #0xd2]
	ldr r2, _0215E908 // =_02178DC0
	mov r0, #0
_0215E8DC:
	mov r1, r0, lsl #1
	ldrh r1, [r2, r1]
	cmp r1, r3
	bxlt lr
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #3
	blo _0215E8DC
	bx lr
	.align 2, 0
_0215E904: .word gameState
_0215E908: .word _02178DC0
	arm_func_end ovl02_215E8B0

	arm_func_start ovl02_215E90C
ovl02_215E90C: // 0x0215E90C
	ldr r1, _0215E960 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r1, [r1, #0x70]
	cmpeq r1, #0xf
	moveq r0, #3
	bxeq lr
	add r0, r0, #0x300
	ldrsh r3, [r0, #0xd2]
	ldr r2, _0215E964 // =_02178DC0
	mov r0, #0
_0215E938:
	mov r1, r0, lsl #1
	ldrh r1, [r2, r1]
	cmp r1, r3
	bxlt lr
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #3
	blo _0215E938
	bx lr
	.align 2, 0
_0215E960: .word gameState
_0215E964: .word _02178DC0
	arm_func_end ovl02_215E90C

	arm_func_start ovl02_215E968
ovl02_215E968: // 0x0215E968
	ldr r1, _0215E99C // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r1, [r1, #0x70]
	cmpeq r1, #0xf
	moveq r0, #1
	bxeq lr
	add r0, r0, #0x300
	ldrsh r0, [r0, #0xd2]
	cmp r0, #0x200
	movgt r0, #0
	movle r0, #1
	bx lr
	.align 2, 0
_0215E99C: .word gameState
	arm_func_end ovl02_215E968

	arm_func_start ovl02_215E9A0
ovl02_215E9A0: // 0x0215E9A0
	ldr r1, _0215E9D4 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r1, [r1, #0x70]
	cmpeq r1, #0xf
	moveq r0, #1
	bxeq lr
	add r0, r0, #0x300
	ldrsh r0, [r0, #0xd2]
	cmp r0, #0x200
	movgt r0, #0
	movle r0, #1
	bx lr
	.align 2, 0
_0215E9D4: .word gameState
	arm_func_end ovl02_215E9A0

	arm_func_start ovl02_215E9D8
ovl02_215E9D8: // 0x0215E9D8
	stmdb sp!, {r3, lr}
	ldr r1, _0215EA20 // =gPlayer
	ldr r2, [r1]
	add r1, r0, #0x44
	add r0, r2, #0x44
	bl VEC_Distance
	ldr r2, _0215EA24 // =_021796D8
	mov r3, #3
_0215E9F8:
	ldr r1, [r2, r3, lsl #2]
	cmp r0, r1
	movgt r0, r3
	ldmgtia sp!, {r3, pc}
	sub r1, r3, #1
	mov r1, r1, lsl #0x10
	movs r3, r1, asr #0x10
	bpl _0215E9F8
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215EA20: .word gPlayer
_0215EA24: .word _021796D8
	arm_func_end ovl02_215E9D8

	arm_func_start ovl02_215EA28
ovl02_215EA28: // 0x0215EA28
	ldr r0, _0215EA40 // =gameState
	ldr r1, _0215EA44 // =_02178DBC
	ldr r0, [r0, #0x18]
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_0215EA40: .word gameState
_0215EA44: .word _02178DBC
	arm_func_end ovl02_215EA28

	arm_func_start ovl02_215EA48
ovl02_215EA48: // 0x0215EA48
	ldr r0, _0215EA60 // =gameState
	ldr r1, _0215EA64 // =_02178DB4
	ldr r0, [r0, #0x18]
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_0215EA60: .word gameState
_0215EA64: .word _02178DB4
	arm_func_end ovl02_215EA48

	arm_func_start ovl02_215EA68
ovl02_215EA68: // 0x0215EA68
	stmdb sp!, {r3, lr}
	bl ovl02_215E8B0
	ldr r1, _0215EA80 // =_02178DDC
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215EA80: .word _02178DDC
	arm_func_end ovl02_215EA68

	arm_func_start ovl02_215EA84
ovl02_215EA84: // 0x0215EA84
	stmdb sp!, {r3, lr}
	bl ovl02_215E8B0
	ldr r1, _0215EA9C // =_02178DCC
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215EA9C: .word _02178DCC
	arm_func_end ovl02_215EA84

	arm_func_start ovl02_215EAA0
ovl02_215EAA0: // 0x0215EAA0
	stmdb sp!, {r3, lr}
	bl ovl02_215E90C
	ldr r1, _0215EAB8 // =_02178DD4
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215EAB8: .word _02178DD4
	arm_func_end ovl02_215EAA0

	arm_func_start ovl02_215EABC
ovl02_215EABC: // 0x0215EABC
	stmdb sp!, {r3, lr}
	bl ovl02_215E90C
	ldr r1, _0215EAD4 // =_02178DEC
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215EAD4: .word _02178DEC
	arm_func_end ovl02_215EABC

	arm_func_start ovl02_215EAD8
ovl02_215EAD8: // 0x0215EAD8
	stmdb sp!, {r3, lr}
	ldr r1, _0215EB40 // =gameState
	ldr r1, [r1, #0x18]
	cmp r1, #0
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	bl ovl02_215E90C
	ldr r1, _0215EB44 // =_02178DE4
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	ldr r3, _0215EB48 // =_mt_math_rand
	ldr r1, _0215EB4C // =0x00196225
	ldr ip, [r3]
	ldr r2, _0215EB50 // =0x3C6EF35F
	mla r2, ip, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	tst r1, #1
	subne r0, r0, #1
	movne r0, r0, lsl #0x10
	str r2, [r3]
	movne r0, r0, lsr #0x10
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215EB40: .word gameState
_0215EB44: .word _02178DE4
_0215EB48: .word _mt_math_rand
_0215EB4C: .word 0x00196225
_0215EB50: .word 0x3C6EF35F
	arm_func_end ovl02_215EAD8

	arm_func_start ovl02_215EB54
ovl02_215EB54: // 0x0215EB54
	stmdb sp!, {r3, lr}
	bl ovl02_215E90C
	ldr r1, _0215EB6C // =_02178DF4
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215EB6C: .word _02178DF4
	arm_func_end ovl02_215EB54

	arm_func_start ovl02_215EB70
ovl02_215EB70: // 0x0215EB70
	stmdb sp!, {r3, lr}
	ldr r0, _0215EB90 // =_02178DFC
	mov r1, #3
	bl ovl02_215ED7C
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215EB90: .word _02178DFC
	arm_func_end ovl02_215EB70

	arm_func_start ovl02_215EB94
ovl02_215EB94: // 0x0215EB94
	stmdb sp!, {r3, r4, r5, lr}
	ldr r3, _0215EC70 // =_mt_math_rand
	ldr r1, _0215EC74 // =0x00196225
	ldr r4, [r3]
	ldr r2, _0215EC78 // =0x3C6EF35F
	mla r5, r4, r1, r2
	mov r1, r5, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r1, lsr #0x1f
	rsb r1, r2, r1, lsl #30
	adds r1, r2, r1, ror #30
	str r5, [r3]
	str r1, [r0, #0x3f0]
	bne _0215EBE8
	ldr r1, _0215EC7C // =gPlayer
	ldr r1, [r1]
	ldr r1, [r1, #0x568]
	tst r1, #4
	movne r1, #1
	strne r1, [r0, #0x3f0]
_0215EBE8:
	ldr r1, _0215EC7C // =gPlayer
	ldr r2, [r0, #0x44]
	ldr r1, [r1]
	ldr r1, [r1, #0x44]
	subs r2, r1, r2
	ldr r1, _0215EC80 // =_021796C0
	rsbmi r2, r2, #0
	ldr r1, [r1, #0x1c]
	cmp r2, r1
	bgt _0215EC20
	add r0, r0, #0x300
	mov r1, #0
	strh r1, [r0, #0xee]
	ldmia sp!, {r3, r4, r5, pc}
_0215EC20:
	ldr lr, _0215EC70 // =_mt_math_rand
	ldr r1, _0215EC74 // =0x00196225
	ldr r4, [lr]
	ldr r2, _0215EC78 // =0x3C6EF35F
	ldr r3, _0215EC84 // =0x84210843
	mla r5, r4, r1, r2
	mov r1, r5, lsr #0x10
	mov r1, r1, lsl #0x10
	mov ip, r1, lsr #0x10
	smull r2, r4, r3, ip
	add r4, r4, r1, lsr #16
	mov r2, ip, lsr #0x1f
	add r4, r2, r4, asr #4
	mov ip, #0x1f
	smull r2, r3, ip, r4
	str r5, [lr]
	rsb r4, r2, r1, lsr #16
	add r0, r0, #0x300
	strh r4, [r0, #0xee]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215EC70: .word _mt_math_rand
_0215EC74: .word 0x00196225
_0215EC78: .word 0x3C6EF35F
_0215EC7C: .word gPlayer
_0215EC80: .word _021796C0
_0215EC84: .word 0x84210843
	arm_func_end ovl02_215EB94

	arm_func_start ovl02_215EC88
ovl02_215EC88: // 0x0215EC88
	stmdb sp!, {r3, r4, r5, lr}
	ldr r3, _0215ED64 // =_mt_math_rand
	ldr r1, _0215ED68 // =0x00196225
	ldr r4, [r3]
	ldr r2, _0215ED6C // =0x3C6EF35F
	mla r5, r4, r1, r2
	mov r1, r5, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r1, lsr #0x1f
	rsb r1, r2, r1, lsl #30
	adds r1, r2, r1, ror #30
	str r5, [r3]
	str r1, [r0, #0x3f4]
	bne _0215ECDC
	ldr r1, _0215ED70 // =gPlayer
	ldr r1, [r1]
	ldr r1, [r1, #0x568]
	tst r1, #4
	movne r1, #1
	strne r1, [r0, #0x3f4]
_0215ECDC:
	ldr r1, _0215ED70 // =gPlayer
	ldr r2, [r0, #0x44]
	ldr r1, [r1]
	ldr r1, [r1, #0x44]
	subs r2, r1, r2
	ldr r1, _0215ED74 // =_021796C0
	rsbmi r2, r2, #0
	ldr r1, [r1, #0x1c]
	cmp r2, r1
	bgt _0215ED14
	add r0, r0, #0x300
	mov r1, #0
	strh r1, [r0, #0xf8]
	ldmia sp!, {r3, r4, r5, pc}
_0215ED14:
	ldr lr, _0215ED64 // =_mt_math_rand
	ldr r1, _0215ED68 // =0x00196225
	ldr r4, [lr]
	ldr r2, _0215ED6C // =0x3C6EF35F
	ldr r3, _0215ED78 // =0x84210843
	mla r5, r4, r1, r2
	mov r1, r5, lsr #0x10
	mov r1, r1, lsl #0x10
	mov ip, r1, lsr #0x10
	smull r2, r4, r3, ip
	add r4, r4, r1, lsr #16
	mov r2, ip, lsr #0x1f
	add r4, r2, r4, asr #4
	mov ip, #0x1f
	smull r2, r3, ip, r4
	str r5, [lr]
	rsb r4, r2, r1, lsr #16
	add r0, r0, #0x300
	strh r4, [r0, #0xf8]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215ED64: .word _mt_math_rand
_0215ED68: .word 0x00196225
_0215ED6C: .word 0x3C6EF35F
_0215ED70: .word gPlayer
_0215ED74: .word _021796C0
_0215ED78: .word 0x84210843
	arm_func_end ovl02_215EC88

	arm_func_start ovl02_215ED7C
ovl02_215ED7C: // 0x0215ED7C
	stmdb sp!, {r3, r4, r5, lr}
	ldr lr, _0215EDF0 // =_mt_math_rand
	mov r2, #0
	ldr r4, [lr]
	ldr r3, _0215EDF4 // =0x00196225
	ldr ip, _0215EDF8 // =0x3C6EF35F
	mov r5, r2
	mla ip, r4, r3, ip
	mov r3, ip, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	str ip, [lr]
	cmp r1, #0
	mov r4, r3, asr #4
	bls _0215EDE0
_0215EDB8:
	ldr r3, [r0, r5, lsl #2]
	add r2, r2, r3
	cmp r4, r2
	movle r0, r5
	ldmleia sp!, {r3, r4, r5, pc}
	add r3, r5, #1
	mov r3, r3, lsl #0x10
	cmp r1, r3, lsr #16
	mov r5, r3, lsr #0x10
	bhi _0215EDB8
_0215EDE0:
	sub r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215EDF0: .word _mt_math_rand
_0215EDF4: .word 0x00196225
_0215EDF8: .word 0x3C6EF35F
	arm_func_end ovl02_215ED7C

	arm_func_start ovl02_215EDFC
ovl02_215EDFC: // 0x0215EDFC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl ovl02_215E968
	mov r1, r0, lsl #0x10
	ldr r0, [r5, #0x370]
	mov r4, r1, lsr #0x10
	bl ovl02_215E260
	cmp r0, #0
	beq _0215EEB4
	cmp r4, #1
	beq _0215EE3C
	ldr r0, [r5, #0x370]
	ldr r0, [r0, #0x374]
	bl ovl02_215E9A0
	cmp r0, #1
	bne _0215EEB4
_0215EE3C:
	ldr r2, _0215EEDC // =_mt_math_rand
	ldr r0, _0215EEE0 // =0x00196225
	ldr r3, [r2]
	ldr r1, _0215EEE4 // =0x3C6EF35F
	mla r0, r3, r0, r1
	str r0, [r2]
	ldr r3, [r5, #0x370]
	mov r2, r0, lsr #0x10
	add r0, r3, #0x300
	ldrh r1, [r0, #0xda]
	mov r0, r2, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r1, #0xe10
	mov r2, r0, asr #4
	movhs r0, #0x1000
	bhs _0215EE98
	add r0, r1, #0x99
	adds r0, r0, #0x100
	movmi r0, #0
	bmi _0215EE94
	cmp r0, #0x1000
	movgt r0, #0x1000
_0215EE94:
	mov r0, r0, asr #1
_0215EE98:
	cmp r2, r0
	bgt _0215EEB4
	add r0, r3, #0x300
	mov r1, #0
	strh r1, [r0, #0xda]
	mov r0, #5
	ldmia sp!, {r3, r4, r5, pc}
_0215EEB4:
	mov r0, r5
	bl ovl02_215E9D8
	ldr r2, _0215EEE8 // =_02178EB4
	mov r1, #0x60
	mla r2, r4, r1, r2
	mov r1, #0x18
	mla r0, r1, r0, r2
	mov r1, #6
	bl ovl02_215ED7C
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215EEDC: .word _mt_math_rand
_0215EEE0: .word 0x00196225
_0215EEE4: .word 0x3C6EF35F
_0215EEE8: .word _02178EB4
	arm_func_end ovl02_215EDFC

	arm_func_start ovl02_215EEEC
ovl02_215EEEC: // 0x0215EEEC
	stmdb sp!, {r3, lr}
	bl ovl02_215E8B0
	ldr r2, _0215EF08 // =_02178E14
	mov r1, #2
	add r0, r2, r0, lsl #3
	bl ovl02_215ED7C
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215EF08: .word _02178E14
	arm_func_end ovl02_215EEEC

	arm_func_start ovl02_215EF0C
ovl02_215EF0C: // 0x0215EF0C
	stmdb sp!, {r3, lr}
	bl ovl02_215E8B0
	ldr r2, _0215EF28 // =_02178E34
	mov r1, #2
	add r0, r2, r0, lsl #3
	bl ovl02_215ED7C
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215EF28: .word _02178E34
	arm_func_end ovl02_215EF0C

	arm_func_start ovl02_215EF2C
ovl02_215EF2C: // 0x0215EF2C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215E9A0
	mov r1, r0, lsl #0x10
	mov r0, r4
	mov r4, r1, lsr #0x10
	bl ovl02_215E9D8
	ldr r2, _0215EF68 // =_02178E54
	mov r1, #0x30
	mla r2, r4, r1, r2
	mov r1, #0xc
	mla r0, r1, r0, r2
	mov r1, #3
	bl ovl02_215ED7C
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215EF68: .word _02178E54
	arm_func_end ovl02_215EF2C

	arm_func_start ovl02_215EF6C
ovl02_215EF6C: // 0x0215EF6C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	mov r4, r1
	add r0, r5, #0x300
	ldr r3, _0215EFD4 // =_02178F90
	strh r4, [r0, #0x58]
	add r0, r5, #0x24c
	mov r1, #0
	mov r6, r2
	stmia sp, {r1, r6}
	ldrb r3, [r3, r4]
	ldr r2, [r5, #0x368]
	add r0, r0, #0x800
	bl BossHelpers__Animation__Func_2038BF0
	mov r0, #0
	stmia sp, {r0, r6}
	ldr r1, _0215EFD8 // =_02178FBC
	add r0, r5, #0x24c
	ldrb r3, [r1, r4]
	ldr r2, [r5, #0x36c]
	add r0, r0, #0x800
	mov r1, #4
	bl BossHelpers__Animation__Func_2038BF0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215EFD4: .word _02178F90
_0215EFD8: .word _02178FBC
	arm_func_end ovl02_215EF6C

	arm_func_start ovl02_215EFDC
ovl02_215EFDC: // 0x0215EFDC
	ldr ip, _0215EFF0 // =BossHelpers__Animation__Func_2038C44
	add r0, r0, #0x24c
	add r0, r0, #0x800
	mov r1, #0
	bx ip
	.align 2, 0
_0215EFF0: .word BossHelpers__Animation__Func_2038C44
	arm_func_end ovl02_215EFDC

	arm_func_start ovl02_215EFF4
ovl02_215EFF4: // 0x0215EFF4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x70
	mov r4, r0
	mov r5, r1
	ldr r3, _0215F114 // =_02178F74
	add r0, r4, #0x300
	strh r5, [r0, #0x58]
	mov r1, #0
	add ip, r4, #0x1f4
	stmia sp, {r1, r2}
	ldrb r3, [r3, r5]
	ldr r2, [r4, #0x368]
	add r0, ip, #0x800
	bl BossHelpers__Animation__Func_2038BF0
	cmp r5, #0x15
	bgt _0215F05C
	bge _0215F070
	cmp r5, #9
	bgt _0215F078
	cmp r5, #3
	blt _0215F078
	cmpne r5, #6
	beq _0215F068
	cmp r5, #9
	beq _0215F070
	b _0215F078
_0215F05C:
	cmp r5, #0x18
	beq _0215F070
	b _0215F078
_0215F068:
	mov r6, #1
	b _0215F07C
_0215F070:
	mov r6, #2
	b _0215F07C
_0215F078:
	mov r6, #0
_0215F07C:
	ldr r1, _0215F118 // =gameArchiveStage
	add r0, sp, #8
	ldr r2, [r1]
	ldr r1, _0215F11C // =_02179768
	bl NNS_FndMountArchive
	add r0, sp, #8
	mov r1, #0xf
	bl NNS_FndGetArchiveFileByIndex
	mov r1, #0
	add ip, r4, #0x338
	mov r2, r0
	mov r3, r6
	add r0, ip, #0x800
	str r1, [sp]
	mov r5, #1
	str r5, [sp, #4]
	bl BossHelpers__Animation__Func_2038BF0
	add r0, sp, #8
	mov r1, #0x10
	bl NNS_FndGetArchiveFileByIndex
	mov r5, r0
	add r0, sp, #8
	mov r1, #0xe
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dGetTex
	add r1, r4, #0x338
	str r0, [sp]
	add r0, r1, #0x800
	mov r1, #1
	str r1, [sp, #4]
	mov r2, r5
	mov r3, r6
	mov r1, #2
	bl BossHelpers__Animation__Func_2038BF0
	add r0, sp, #8
	bl NNS_FndUnmountArchive
	add sp, sp, #0x70
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215F114: .word _02178F74
_0215F118: .word gameArchiveStage
_0215F11C: .word _02179768
	arm_func_end ovl02_215EFF4

	arm_func_start ovl02_215F120
ovl02_215F120: // 0x0215F120
	ldr ip, _0215F134 // =BossHelpers__Animation__Func_2038C44
	add r0, r0, #0x1f4
	add r0, r0, #0x800
	mov r1, #0
	bx ip
	.align 2, 0
_0215F134: .word BossHelpers__Animation__Func_2038C44
	arm_func_end ovl02_215F120

	arm_func_start ovl02_215F138
ovl02_215F138: // 0x0215F138
	stmdb sp!, {r3, lr}
	add r1, r0, #0x300
	ldrh r1, [r1, #0x74]
	tst r1, #0x30
	beq _0215F15C
	mov r1, #3
	mov r2, #1
	bl ovl02_215EF6C
	ldmia sp!, {r3, pc}
_0215F15C:
	mov r1, #4
	mov r2, #0
	bl ovl02_215EF6C
	ldmia sp!, {r3, pc}
	arm_func_end ovl02_215F138

	arm_func_start ovl02_215F16C
ovl02_215F16C: // 0x0215F16C
	stmdb sp!, {r3, lr}
	add r1, r0, #0x300
	ldrh r1, [r1, #0x74]
	tst r1, #0x30
	beq _0215F190
	mov r1, #3
	mov r2, #1
	bl ovl02_215EFF4
	ldmia sp!, {r3, pc}
_0215F190:
	mov r1, #4
	mov r2, #0
	bl ovl02_215EFF4
	ldmia sp!, {r3, pc}
	arm_func_end ovl02_215F16C

	arm_func_start ovl02_215F1A0
ovl02_215F1A0: // 0x0215F1A0
	add r1, r0, #0x500
	ldrh r0, [r1, #0x7a]
	add r0, r0, #0x31c
	add r0, r0, #0x400
	strh r0, [r1, #0x7a]
	ldrh r0, [r1, #0x7a]
	cmp r0, #0x8000
	mov r0, #0
	strhsh r0, [r1, #0x7a]
	movhs r0, #1
	bx lr
	arm_func_end ovl02_215F1A0

	arm_func_start ovl02_215F1CC
ovl02_215F1CC: // 0x0215F1CC
	add r1, r0, #0x500
	ldrh r0, [r1, #0x80]
	add r0, r0, #0x31c
	add r0, r0, #0x400
	strh r0, [r1, #0x80]
	ldrh r0, [r1, #0x80]
	cmp r0, #0x8000
	mov r0, #0
	strhsh r0, [r1, #0x80]
	movhs r0, #1
	bx lr
	arm_func_end ovl02_215F1CC

	arm_func_start ovl02_215F1F8
ovl02_215F1F8: // 0x0215F1F8
	ldr r1, _0215F204 // =ovl02_2160B70
	str r1, [r0, #0xfc]
	bx lr
	.align 2, 0
_0215F204: .word ovl02_2160B70
	arm_func_end ovl02_215F1F8

	arm_func_start ovl02_215F208
ovl02_215F208: // 0x0215F208
	ldr r1, _0215F214 // =ovl02_2164974
	str r1, [r0, #0xfc]
	bx lr
	.align 2, 0
_0215F214: .word ovl02_2164974
	arm_func_end ovl02_215F208

	arm_func_start ovl02_215F218
ovl02_215F218: // 0x0215F218
	add r1, r0, #0x500
	ldrh r0, [r1, #0x80]
	add r0, r0, #0x238
	add r0, r0, #0xc00
	strh r0, [r1, #0x80]
	bx lr
	arm_func_end ovl02_215F218

	arm_func_start ovl02_215F230
ovl02_215F230: // 0x0215F230
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EA28
	add r1, r4, #0x300
	ldrsh r2, [r1, #0xd2]
	sub r2, r2, r0
	mov r0, #2
	strh r2, [r1, #0xd2]
	bl SetActiveBossHealthbar
	add r0, r4, #0x300
	ldrsh r0, [r0, #0xd2]
	cmp r0, #0
	ble _0215F27C
	mov r0, r4
	bl ovl02_2162B50
	add r0, r4, #0x500
	mov r1, #4
	strh r1, [r0, #0x7e]
	b _0215F2A0
_0215F27C:
	bl ovl02_215DB5C
	cmp r0, #0
	beq _0215F298
	ldr r0, _0215F2E4 // =gPlayer
	ldr r0, [r0]
	bl Player__Action_Die
	b _0215F2A0
_0215F298:
	mov r0, r4
	bl ovl02_2162CCC
_0215F2A0:
	add r0, r4, #0x300
	ldrsh r0, [r0, #0xd2]
	bl UpdateBossHealthHUD
	add r0, r4, #0x300
	ldrsh r0, [r0, #0xd2]
	cmp r0, #0x200
	ldmgeia sp!, {r4, pc}
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x3e4]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, #1
	bl ChangeBossBGMVariant
	ldr r0, [r4, #0x370]
	mov r1, #1
	str r1, [r0, #0x3e4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215F2E4: .word gPlayer
	arm_func_end ovl02_215F230

	arm_func_start ovl02_215F2E8
ovl02_215F2E8: // 0x0215F2E8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EA48
	add r1, r4, #0x300
	ldrsh r2, [r1, #0xd2]
	sub r2, r2, r0
	mov r0, #1
	strh r2, [r1, #0xd2]
	bl SetActiveBossHealthbar
	add r0, r4, #0x300
	ldrsh r0, [r0, #0xd2]
	cmp r0, #0
	mov r0, r4
	ble _0215F334
	bl ovl02_2166494
	add r0, r4, #0x500
	mov r1, #4
	strh r1, [r0, #0x82]
	b _0215F338
_0215F334:
	bl ovl02_2166604
_0215F338:
	add r0, r4, #0x300
	ldrsh r0, [r0, #0xd2]
	bl UpdateBossHealthHUD
	ldr r0, [r4, #0x3d4]
	tst r0, #0x40
	orrne r0, r0, #0x80
	strne r0, [r4, #0x3d4]
	add r0, r4, #0x300
	ldrsh r0, [r0, #0xd2]
	cmp r0, #0x200
	ldmgeia sp!, {r4, pc}
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x3e4]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, #1
	bl ChangeBossBGMVariant
	ldr r0, [r4, #0x370]
	mov r1, #1
	str r1, [r0, #0x3e4]
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_215F2E8

	arm_func_start ovl02_215F38C
ovl02_215F38C: // 0x0215F38C
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr ip, _0215F42C // =_mt_math_rand
	ldr r1, _0215F430 // =0x00196225
	ldr lr, [ip]
	ldr r2, _0215F434 // =0x3C6EF35F
	ldr r3, _0215F438 // =0x00000555
	mla r2, lr, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r2, [ip]
	cmp r3, r1, asr #4
	mov r1, r1, asr #4
	blt _0215F3F4
	mov r1, #0
	str r1, [sp]
	ldr r2, _0215F43C // =0x0000010A
	sub r1, r1, #1
	str r2, [sp, #4]
	ldr r0, [r0, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	add sp, sp, #8
	ldmia sp!, {r3, pc}
_0215F3F4:
	cmp r1, r3, lsl #1
	addgt sp, sp, #8
	ldmgtia sp!, {r3, pc}
	mov r1, #0
	str r1, [sp]
	rsb r2, r3, #0x660
	sub r1, r1, #1
	str r2, [sp, #4]
	ldr r0, [r0, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215F42C: .word _mt_math_rand
_0215F430: .word 0x00196225
_0215F434: .word 0x3C6EF35F
_0215F438: .word 0x00000555
_0215F43C: .word 0x0000010A
	arm_func_end ovl02_215F38C

	arm_func_start ovl02_215F440
ovl02_215F440: // 0x0215F440
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr ip, _0215F504 // =_mt_math_rand
	ldr r1, _0215F508 // =0x00196225
	ldr lr, [ip]
	ldr r2, _0215F50C // =0x3C6EF35F
	add r3, r0, #0x300
	mla r1, lr, r1, r2
	str r1, [ip]
	mov r1, r1, lsr #0x10
	ldrsh r2, [r3, #0xd2]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r2, #0
	mov r2, r1, asr #4
	bgt _0215F494
	ldr r1, [r0, #0x370]
	ldr r1, [r1, #0x374]
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, pc}
_0215F494:
	ldr r1, _0215F510 // =0x00000555
	cmp r2, r1
	bgt _0215F4CC
	mov r1, #0
	str r1, [sp]
	mov r2, #0x108
	str r2, [sp, #4]
	sub r1, r1, #1
	ldr r0, [r0, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	add sp, sp, #8
	ldmia sp!, {r3, pc}
_0215F4CC:
	cmp r2, r1, lsl #1
	addgt sp, sp, #8
	ldmgtia sp!, {r3, pc}
	mov r1, #0
	ldr r2, _0215F514 // =0x00000109
	str r1, [sp]
	rsb r1, r2, #0x108
	str r2, [sp, #4]
	ldr r0, [r0, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215F504: .word _mt_math_rand
_0215F508: .word 0x00196225
_0215F50C: .word 0x3C6EF35F
_0215F510: .word 0x00000555
_0215F514: .word 0x00000109
	arm_func_end ovl02_215F440

	arm_func_start ovl02_215F518
ovl02_215F518: // 0x0215F518
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr ip, _0215F5B8 // =_mt_math_rand
	ldr r1, _0215F5BC // =0x00196225
	ldr lr, [ip]
	ldr r2, _0215F5C0 // =0x3C6EF35F
	ldr r3, _0215F5C4 // =0x00000555
	mla r2, lr, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r2, [ip]
	cmp r3, r1, asr #4
	mov r1, r1, asr #4
	blt _0215F580
	mov r1, #0
	str r1, [sp]
	mov r2, #0x10c
	str r2, [sp, #4]
	sub r1, r1, #1
	ldr r0, [r0, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	add sp, sp, #8
	ldmia sp!, {r3, pc}
_0215F580:
	cmp r1, r3, lsl #1
	addgt sp, sp, #8
	ldmgtia sp!, {r3, pc}
	mov r1, #0
	ldr r2, _0215F5C8 // =0x0000010D
	str r1, [sp]
	rsb r1, r2, #0x10c
	str r2, [sp, #4]
	ldr r0, [r0, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215F5B8: .word _mt_math_rand
_0215F5BC: .word 0x00196225
_0215F5C0: .word 0x3C6EF35F
_0215F5C4: .word 0x00000555
_0215F5C8: .word 0x0000010D
	arm_func_end ovl02_215F518

	arm_func_start ovl02_215F5CC
ovl02_215F5CC: // 0x0215F5CC
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr ip, _0215F690 // =_mt_math_rand
	ldr r1, _0215F694 // =0x00196225
	ldr lr, [ip]
	ldr r2, _0215F698 // =0x3C6EF35F
	add r3, r0, #0x300
	mla r1, lr, r1, r2
	str r1, [ip]
	mov r1, r1, lsr #0x10
	ldrsh r2, [r3, #0xd2]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r2, #0
	mov r2, r1, asr #4
	bgt _0215F620
	ldr r1, [r0, #0x370]
	ldr r1, [r1, #0x370]
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, pc}
_0215F620:
	ldr r1, _0215F69C // =0x00000555
	cmp r2, r1
	bgt _0215F658
	mov r1, #0
	str r1, [sp]
	ldr r2, _0215F6A0 // =0x0000010E
	sub r1, r1, #1
	str r2, [sp, #4]
	ldr r0, [r0, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	add sp, sp, #8
	ldmia sp!, {r3, pc}
_0215F658:
	cmp r2, r1, lsl #1
	addgt sp, sp, #8
	ldmgtia sp!, {r3, pc}
	mov r1, #0
	ldr r2, _0215F6A4 // =0x0000010F
	str r1, [sp]
	sub r1, r2, #0x110
	str r2, [sp, #4]
	ldr r0, [r0, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215F690: .word _mt_math_rand
_0215F694: .word 0x00196225
_0215F698: .word 0x3C6EF35F
_0215F69C: .word 0x00000555
_0215F6A0: .word 0x0000010E
_0215F6A4: .word 0x0000010F
	arm_func_end ovl02_215F5CC

	arm_func_start ovl02_215F6A8
ovl02_215F6A8: // 0x0215F6A8
	stmdb sp!, {r3, lr}
	ldmia r0, {r1, r2, r3}
	mov r0, #0
	bl BossFX__CreateHitA
	ldr r2, [r0, #0x18]
	ldr r1, _0215F6D8 // =0x000024F5
	orr r2, r2, #0x20
	str r2, [r0, #0x18]
	str r1, [r0, #0x180]
	str r1, [r0, #0x184]
	str r1, [r0, #0x188]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215F6D8: .word 0x000024F5
	arm_func_end ovl02_215F6A8

	arm_func_start ovl02_215F6DC
ovl02_215F6DC: // 0x0215F6DC
	stmdb sp!, {r3, lr}
	ldmia r0, {r1, r2, r3}
	mov r0, #0
	bl BossFX__CreateHitB
	ldr r2, [r0, #0x18]
	ldr r1, _0215F70C // =0x000024F5
	orr r2, r2, #0x20
	str r2, [r0, #0x18]
	str r1, [r0, #0x180]
	str r1, [r0, #0x184]
	str r1, [r0, #0x188]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215F70C: .word 0x000024F5
	arm_func_end ovl02_215F6DC

	arm_func_start ovl02_215F710
ovl02_215F710: // 0x0215F710
	stmdb sp!, {r3, lr}
	ldmia r0, {r1, r2, r3}
	mov r0, #0
	bl BossFX__CreateRivalExplode2
	ldr r2, [r0, #0x18]
	ldr r1, _0215F740 // =0x000034CC
	orr r2, r2, #0x20
	str r2, [r0, #0x18]
	str r1, [r0, #0x180]
	str r1, [r0, #0x184]
	str r1, [r0, #0x188]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215F740: .word 0x000034CC
	arm_func_end ovl02_215F710

	arm_func_start ovl02_215F744
ovl02_215F744: // 0x0215F744
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2160414
	add r0, r4, #0x3a8
	bl BossHelpers__Light__Func_203954C
	ldr r0, [r4, #0x370]
	cmp r0, #0
	ldrne r1, [r4, #0x374]
	cmpne r1, #0
	beq _0215F7B0
	bl ovl02_215E968
	cmp r0, #1
	beq _0215F788
	ldr r0, [r4, #0x374]
	bl ovl02_215E9A0
	cmp r0, #1
	bne _0215F7A4
_0215F788:
	add r0, r4, #0x300
	ldrh r2, [r0, #0xda]
	ldr r1, _0215F7D0 // =0x00001770
	cmp r2, r1
	addls r1, r2, #1
	strlsh r1, [r0, #0xda]
	b _0215F7B0
_0215F7A4:
	add r0, r4, #0x300
	mov r1, #0
	strh r1, [r0, #0xda]
_0215F7B0:
	ldr r1, [r4, #0x38c]
	cmp r1, #0
	beq _0215F7C4
	mov r0, r4
	blx r1
_0215F7C4:
	mov r0, r4
	bl ovl02_215FFE4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215F7D0: .word 0x00001770
	arm_func_end ovl02_215F744

	arm_func_start ovl02_215F7D4
ovl02_215F7D4: // 0x0215F7D4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x68
	mov r6, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x400
	bl AnimatorMDL__Release
	add r0, r4, #0x288
	add r5, r0, #0x400
	mov r4, #0
_0215F7FC:
	mov r0, r5
	bl AnimatorSprite3D__Release
	add r4, r4, #1
	cmp r4, #0xa
	add r5, r5, #0x104
	blt _0215F7FC
	ldr r1, _0215F88C // =gameArchiveStage
	add r0, sp, #0
	ldr r2, [r1]
	ldr r1, _0215F890 // =_02179768
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #0x19
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultRelease
	add r0, sp, #0
	mov r1, #0xa
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultRelease
	add r0, sp, #0
	mov r1, #0xe
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultRelease
	add r0, sp, #0
	mov r1, #9
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultRelease
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	ldr r1, _0215F894 // =renderCoreSwapBuffer
	mov r2, #0
	mov r0, r6
	str r2, [r1, #4]
	bl GameObject__Destructor
	add sp, sp, #0x68
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215F88C: .word gameArchiveStage
_0215F890: .word _02179768
_0215F894: .word renderCoreSwapBuffer
	arm_func_end ovl02_215F7D4

	arm_func_start ovl02_215F898
ovl02_215F898: // 0x0215F898
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x3a8
	bl BossHelpers__Light__SetLights2
	mov r0, r4
	bl ovl02_21604FC
	add r0, r4, #0x3a8
	bl BossHelpers__Light__SetLights1
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_215F898

	arm_func_start ovl02_215F8CC
ovl02_215F8CC: // 0x0215F8CC
	stmdb sp!, {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x18]
	tst r0, #2
	ldmneia sp!, {r4, r5, r6, pc}
	add r6, r4, #0x218
	mov r5, #0
_0215F8EC:
	ldr r0, [r6, #0x18]
	tst r0, #4
	beq _0215F90C
	ldr r1, [r4, #0x44]
	ldr r2, [r4, #0x48]
	ldr r3, [r4, #0x4c]
	mov r0, r6
	bl BossHelpers__Collision__Func_20390AC
_0215F90C:
	add r5, r5, #1
	cmp r5, #3
	add r6, r6, #0x40
	blt _0215F8EC
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl02_215F8CC

	arm_func_start ovl02_215F920
ovl02_215F920: // 0x0215F920
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x2c
	mov r5, r0
	ldr r0, _0215FC74 // =_02178E08
	ldr r4, [r5, #0x370]
	add r3, sp, #0x20
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #2
	bl BossArena__SetType
	mov r0, #0
	bl BossArena__SetField35C
	add r0, sp, #0
	mov r1, #0
	mov r2, #0x20
	bl MI_CpuFill8
	mov ip, #0x1000
	mov r1, #0x1000000
	ldr r0, _0215FC78 // =0x0000038E
	str r1, [sp, #8]
	ldr r1, _0215FC7C // =0x00001555
	strh r0, [sp]
	add r0, r0, #0x31c
	str r1, [sp, #0xc]
	mov r1, #0
	umull r6, r3, ip, r0
	mla r3, ip, r1, r3
	mov r2, ip, asr #0x1f
	adds r1, r6, #0x800
	mla r3, r2, r0, r3
	adc r0, r3, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x1000
	mov r0, r0, lsl #1
	str ip, [sp, #4]
	str ip, [sp, #0x10]
	bl BossArena__SetField358
	mov r0, #0x258000
	str r0, [r5, #0x39c]
	mov r0, #0
	bl BossArena__GetCamera
	mov r6, r0
	add r1, sp, #0x20
	bl BossArena__SetUpVector
	mov r0, r6
	mov r1, #1
	bl BossArena__SetCameraType
	mov r0, r6
	add r1, sp, #0
	bl BossArena__SetCameraConfig
	mov r2, #0
	ldr r1, [r4, #0x44]
	mov r0, r6
	mov r3, r2
	bl BossArena__SetTracker1TargetPos
	mov r0, r6
	mov r1, #0x100
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r6
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r6
	mov r1, #0x258000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r6
	mov r1, #0x100
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r6
	bl BossArena__ApplyAmplitudeXZTarget
	mov r0, r6
	mov r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r6
	bl BossArena__ApplyAmplitudeYTarget
	bl BossArena__Func_20397E4
	mov r0, r5
	bl ovl02_215DB80
	mov r0, r6
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r6
	bl BossArena__UpdateTracker0TargetPos
	mov r0, r6
	bl BossArena__ApplyAmplitudeXZTarget
	mov r0, r6
	bl BossArena__ApplyAmplitudeYTarget
	bl BossArena__Func_20397E4
	mov r0, r6
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r6
	bl BossArena__UpdateTracker0TargetPos
	ldr r2, _0215FC80 // =0x0400000A
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
	ldr r2, _0215FC84 // =VRAMSystem__VRAM_BG
	mov r1, #0
	ldr r2, [r2]
	add r2, r2, #0x4000
	bl LoadCompressedPixels
	ldr r0, [r5, #0x364]
	bl GetBackgroundPalette
	ldr r2, _0215FC88 // =VRAMSystem__VRAM_PALETTE_BG
	mov r1, #0
	ldr r2, [r2]
	bl LoadCompressedPalette
	mov r0, #0
	sub r1, r0, #0x100
	bl BossArena__Func_2039A94
	mov r2, #0x4000000
	ldr r1, [r2]
	ldr r0, [r2]
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
	strh r1, [r4, #0x20]
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	bic r1, r1, #1
	orr r1, r1, #1
	strh r1, [r4, #0x20]
	ldrh r1, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	mov r1, r1, lsl #0x1f
	mov r1, r1, lsr #0x1f
	bic r2, r2, #1
	and r1, r1, #1
	orr r1, r2, r1
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	orr r1, r1, #0x200
	strh r1, [r4, #0x20]
	ldrh r1, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	mov r1, r1, lsl #0x16
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x200
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #22
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	orr r1, r1, #0x400
	strh r1, [r4, #0x20]
	ldrh r1, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	mov r1, r1, lsl #0x15
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x400
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #21
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	orr r1, r1, #0x800
	strh r1, [r4, #0x20]
	ldrh r1, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	mov r1, r1, lsl #0x14
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x800
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #20
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	orr r1, r1, #0x1000
	strh r1, [r4, #0x20]
	ldrh r1, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	mov r1, r1, lsl #0x13
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x1000
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #19
	strh r1, [r0, #0x7c]
	mov r0, #1
	bl SetActiveBossHealthbar
	ldr r0, [r5, #0x374]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0xd2]
	bl UpdateBossHealthHUD
	mov r0, #2
	bl SetActiveBossHealthbar
	ldr r0, [r5, #0x370]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0xd2]
	bl UpdateBossHealthHUD
	mov r0, #1
	bl SetHUDActiveScreen
	ldr r0, _0215FC8C // =ovl02_215FC90
	str r0, [r5, #0x38c]
	add sp, sp, #0x2c
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0215FC74: .word _02178E08
_0215FC78: .word 0x0000038E
_0215FC7C: .word 0x00001555
_0215FC80: .word 0x0400000A
_0215FC84: .word VRAMSystem__VRAM_BG
_0215FC88: .word VRAMSystem__VRAM_PALETTE_BG
_0215FC8C: .word ovl02_215FC90
	arm_func_end ovl02_215F920

	arm_func_start ovl02_215FC90
ovl02_215FC90: // 0x0215FC90
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215DB80
	ldr r0, [r4, #0x370]
	cmp r0, #0
	ldrne r0, [r4, #0x374]
	cmpne r0, #0
	ldmeqia sp!, {r4, pc}
	bl TitleCard__GetProgress
	cmp r0, #5
	ldmneia sp!, {r4, pc}
	mov r1, #0
	ldr r0, _0215FCD0 // =ovl02_215FCD4
	str r1, [r4, #0x3e0]
	str r0, [r4, #0x38c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215FCD0: .word ovl02_215FCD4
	arm_func_end ovl02_215FC90

	arm_func_start ovl02_215FCD4
ovl02_215FCD4: // 0x0215FCD4
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x3ec]
	cmp r1, #0
	ldmneia sp!, {r3, pc}
	bl ovl02_215DB80
	ldmia sp!, {r3, pc}
	arm_func_end ovl02_215FCD4

	arm_func_start ovl02_215FCEC
ovl02_215FCEC: // 0x0215FCEC
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _0215FEBC // =gPlayer
	mov r5, r0
	ldr r0, [r1]
	bl Player__Action_Blank
	ldr r0, _0215FEBC // =gPlayer
	mov r1, #0x12
	ldr r0, [r0]
	bl Player__ChangeAction
	ldr r2, _0215FEBC // =gPlayer
	add r1, r5, #0x300
	ldr r0, [r2]
	mov r3, #0
	add r0, r0, #0x600
	ldrsh r0, [r0, #0x82]
	strh r0, [r1, #0xdc]
	ldr r0, [r2]
	add r0, r0, #0x600
	strh r3, [r0, #0x82]
	ldr r0, [r2]
	bl BossHelpers__Player__LockControl
	ldr r1, [r5, #0x370]
	cmp r1, #0
	movne r0, #0
	strne r0, [r1, #0xb64]
	ldr r1, [r5, #0x374]
	cmp r1, #0
	movne r0, #0
	strne r0, [r1, #0xb0c]
	bl EnableObjectManagerFlag2
	ldr r2, [r5, #0x370]
	cmp r2, #0
	beq _0215FDAC
	ldr r0, [r2, #0x18]
	mov r1, #0
	orr r0, r0, #0x20
	str r0, [r2, #0x18]
	ldr r2, [r5, #0x370]
	ldr r0, [r2, #0x1c]
	orr r0, r0, #0x2000
	str r0, [r2, #0x1c]
	ldr r0, [r5, #0x370]
	add r0, r0, #0x300
	strh r1, [r0, #0x50]
	ldr r1, [r5, #0x370]
	ldr r0, [r1, #0x20]
	bic r0, r0, #0x20
	str r0, [r1, #0x20]
_0215FDAC:
	ldr r2, [r5, #0x374]
	cmp r2, #0
	beq _0215FDF4
	ldr r0, [r2, #0x18]
	mov r1, #0
	orr r0, r0, #0x20
	str r0, [r2, #0x18]
	ldr r2, [r5, #0x374]
	ldr r0, [r2, #0x1c]
	orr r0, r0, #0x2000
	str r0, [r2, #0x1c]
	ldr r0, [r5, #0x374]
	add r0, r0, #0x300
	strh r1, [r0, #0x50]
	ldr r1, [r5, #0x374]
	ldr r0, [r1, #0x20]
	bic r0, r0, #0x20
	str r0, [r1, #0x20]
_0215FDF4:
	ldr r0, [r5, #0x18]
	mov r1, #1
	orr r0, r0, #0x20
	str r0, [r5, #0x18]
	ldr r0, _0215FEC0 // =playerGameStatus
	str r1, [r5, #0x3e8]
	ldr r1, [r0]
	bic r1, r1, #1
	str r1, [r0]
	bl Camera3D__GetWork
	ldr r2, [r5, #0x3fc]
	mov r1, #0x5c
	mla r4, r2, r1, r0
	add r0, r4, #0x20
	mov r1, #0
	mov r2, #6
	bl MI_CpuFill8
	ldrh r0, [r4, #0x20]
	bic r0, r0, #0xc0
	orr r0, r0, #0xc0
	strh r0, [r4, #0x20]
	ldrh r0, [r4, #0x20]
	bic r0, r0, #1
	orr r0, r0, #1
	strh r0, [r4, #0x20]
	ldrh r0, [r4, #0x20]
	orr r0, r0, #0x1e
	strh r0, [r4, #0x20]
	ldr r0, [r5, #0x370]
	cmp r0, #0
	ldrne r0, [r5, #0x374]
	cmpne r0, #0
	beq _0215FE84
	bl ovl02_215DB5C
	cmp r0, #0
	beq _0215FE88
_0215FE84:
	bl StopStageBGM
_0215FE88:
	mov r6, #0
	mov r4, r6
_0215FE90:
	add r0, r5, r6, lsl #2
	ldr r0, [r0, #0x384]
	cmp r0, #0
	beq _0215FEAC
	ldr r0, [r0, #0x138]
	mov r1, r4
	bl NNS_SndPlayerStopSeq
_0215FEAC:
	add r6, r6, #1
	cmp r6, #2
	blt _0215FE90
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215FEBC: .word gPlayer
_0215FEC0: .word playerGameStatus
	arm_func_end ovl02_215FCEC

	arm_func_start ovl02_215FEC4
ovl02_215FEC4: // 0x0215FEC4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, _0215FFD8 // =gPlayer
	add r0, r4, #0x300
	ldr r2, [r1]
	ldrsh r3, [r0, #0xdc]
	add r0, r2, #0x600
	strh r3, [r0, #0x82]
	ldr r0, [r1]
	ldr r1, [r0, #0x5e4]
	blx r1
	ldr r0, _0215FFD8 // =gPlayer
	ldr r0, [r0]
	bl BossHelpers__Player__UnlockControl
	bl ovl02_215DB5C
	cmp r0, #0
	beq _0215FF1C
	ldr r0, _0215FFD8 // =gPlayer
	ldr r1, [r0]
	ldr r0, [r1, #0x18]
	orr r0, r0, #2
	str r0, [r1, #0x18]
_0215FF1C:
	ldr r1, [r4, #0x370]
	cmp r1, #0
	movne r0, #0x1000
	strne r0, [r1, #0xb64]
	ldr r1, [r4, #0x374]
	cmp r1, #0
	movne r0, #0x1000
	strne r0, [r1, #0xb0c]
	bl DisableObjectManagerFlag2
	ldr r2, [r4, #0x370]
	cmp r2, #0
	beq _0215FF78
	ldr r0, [r2, #0x18]
	mov r1, #0x78
	bic r0, r0, #0x20
	str r0, [r2, #0x18]
	ldr r2, [r4, #0x370]
	ldr r0, [r2, #0x1c]
	bic r0, r0, #0x2000
	str r0, [r2, #0x1c]
	ldr r0, [r4, #0x370]
	add r0, r0, #0x300
	strh r1, [r0, #0x50]
_0215FF78:
	ldr r2, [r4, #0x374]
	cmp r2, #0
	beq _0215FFB0
	ldr r0, [r2, #0x18]
	mov r1, #0x78
	bic r0, r0, #0x20
	str r0, [r2, #0x18]
	ldr r2, [r4, #0x374]
	ldr r0, [r2, #0x1c]
	bic r0, r0, #0x2000
	str r0, [r2, #0x1c]
	ldr r0, [r4, #0x374]
	add r0, r0, #0x300
	strh r1, [r0, #0x50]
_0215FFB0:
	ldr r0, [r4, #0x18]
	bic r0, r0, #0x20
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x370]
	cmp r0, #0
	ldrne r0, [r4, #0x374]
	cmpne r0, #0
	movne r0, #0
	strne r0, [r4, #0x3e8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215FFD8: .word gPlayer
	arm_func_end ovl02_215FEC4

	arm_func_start ovl02_215FFDC
ovl02_215FFDC: // 0x0215FFDC
	ldr r0, [r0, #0x3e8]
	bx lr
	arm_func_end ovl02_215FFDC

	arm_func_start ovl02_215FFE4
ovl02_215FFE4: // 0x0215FFE4
	stmdb sp!, {r3, lr}
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _02160010
	mov r0, #0x20
	mov r1, r0
	bl BossArena__Func_2039AB4
	mov r0, #0
	mov r1, r0
	bl BossArena__Func_2039A94
	ldmia sp!, {r3, pc}
_02160010:
	mov r0, #0
	mov r1, #0x20
	bl BossArena__Func_2039AB4
	mov r0, #0
	sub r1, r0, #0x100
	bl BossArena__Func_2039A94
	ldmia sp!, {r3, pc}
	arm_func_end ovl02_215FFE4

	arm_func_start ovl02_216002C
ovl02_216002C: // 0x0216002C
	stmdb sp!, {r4, lr}
	add r0, r0, #0x300
	ldrsh r2, [r0, #0xd8]
	mov r4, r1
	mov r0, r4
	cmp r2, #0
	rsblt r2, r2, #0
	and r3, r2, #0xff
	add r1, r4, #0x200
	mov r2, #0x100
	bl Palette__UnknownFunc10
	add r0, r4, #0x200
	mov r1, #0x200
	bl DC_StoreRange
	ldr r1, _02160080 // =VRAMSystem__VRAM_PALETTE_BG
	add r0, r4, #0x200
	ldr r3, [r1]
	mov r1, #0x100
	mov r2, #0
	bl QueueUncompressedPalette
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160080: .word VRAMSystem__VRAM_PALETTE_BG
	arm_func_end ovl02_216002C

	arm_func_start ovl02_2160084
ovl02_2160084: // 0x02160084
	stmdb sp!, {r3, lr}
	ldr r2, [r0, #0x370]
	ldr r3, [r0, #0x374]
	cmp r2, #0
	addne r0, r2, #0x300
	ldrnesh r2, [r0, #0xd2]
	moveq r2, #0
	cmp r3, #0
	addne r0, r3, #0x300
	ldrnesh r3, [r0, #0xd2]
	ldr r0, _0216015C // =gameState
	ldr r0, [r0, #0x18]
	moveq r3, #0
	cmp r0, #0
	beq _021600CC
	cmp r0, #1
	moveq r1, #2
	b _021600D0
_021600CC:
	mov r1, #1
_021600D0:
	ldr r0, _0216015C // =gameState
	ldr ip, [r0, #0x14]
	cmp ip, #3
	ldreq r0, [r0, #0x70]
	cmpeq r0, #0xf
	mov r0, #0
	bne _02160124
	cmp r1, #0
	ldmlsia sp!, {r3, pc}
	ldr lr, _02160160 // =_02178DB0
_021600F8:
	mov ip, r0, lsl #1
	ldrh ip, [lr, ip]
	cmp ip, r2
	cmplt ip, r3
	ldmltia sp!, {r3, pc}
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r0, r0, lsr #0x10
	bhi _021600F8
	ldmia sp!, {r3, pc}
_02160124:
	cmp r1, #0
	ldmlsia sp!, {r3, pc}
	ldr lr, _02160164 // =_02178DB8
_02160130:
	mov ip, r0, lsl #1
	ldrh ip, [lr, ip]
	cmp ip, r2
	cmplt ip, r3
	ldmltia sp!, {r3, pc}
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r0, r0, lsr #0x10
	bhi _02160130
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216015C: .word gameState
_02160160: .word _02178DB0
_02160164: .word _02178DB8
	arm_func_end ovl02_2160084

	arm_func_start ovl02_2160168
ovl02_2160168: // 0x02160168
	mov r2, #0
_0216016C:
	add r1, r0, r2, lsl #2
	ldr r1, [r1, #0x384]
	cmp r1, #0
	beq _0216018C
	ldr r1, [r1, #0x37c]
	cmp r1, #0xa
	movhs r0, #1
	bxhs lr
_0216018C:
	add r2, r2, #1
	cmp r2, #2
	blt _0216016C
	mov r0, #0
	bx lr
	arm_func_end ovl02_2160168

	arm_func_start ovl02_21601A0
ovl02_21601A0: // 0x021601A0
	mov r2, #0
_021601A4:
	add r1, r0, r2, lsl #2
	ldr r1, [r1, #0x384]
	cmp r1, #0
	beq _021601C4
	ldr r1, [r1, #0x374]
	cmp r1, #0
	moveq r0, #0
	bxeq lr
_021601C4:
	add r2, r2, #1
	cmp r2, #2
	blt _021601A4
	mov r0, #1
	bx lr
	arm_func_end ovl02_21601A0

	arm_func_start ovl02_21601D8
ovl02_21601D8: // 0x021601D8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r0, [r4, #0x3f0]
	cmp r0, #0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	cmp r0, #1
	beq _0216020C
	cmp r0, #2
	beq _02160250
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
_0216020C:
	ldr r2, [r4, #0x3f4]
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	ldr r1, _021602E0 // =_02179748
	str r3, [sp, #0x10]
	ldr r0, _021602E4 // =_0217974C
	ldr r1, [r1, r2, lsl #3]
	ldr r2, [r0, r2, lsl #3]
	mov r0, #0x138
	bl GameObject__SpawnObject
	str r0, [r4, #0x384]
	add sp, sp, #0x14
	str r4, [r0, #0x364]
	ldmia sp!, {r3, r4, pc}
_02160250:
	ldr r2, [r4, #0x3f4]
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	ldr r1, _021602E0 // =_02179748
	str r3, [sp, #0x10]
	ldr r0, _021602E4 // =_0217974C
	ldr r1, [r1, r2, lsl #3]
	ldr r2, [r0, r2, lsl #3]
	mov r0, #0x138
	bl GameObject__SpawnObject
	str r0, [r4, #0x384]
	str r4, [r0, #0x364]
	ldr r0, [r4, #0x3f4]
	mov r3, #0
	add r2, r0, #1
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	cmp r2, #4
	str r3, [sp, #0xc]
	mov r0, #1
	str r0, [sp, #0x10]
	ldr r1, _021602E0 // =_02179748
	movge r2, #0
	ldr r0, _021602E4 // =_0217974C
	ldr r1, [r1, r2, lsl #3]
	ldr r2, [r0, r2, lsl #3]
	mov r0, #0x138
	bl GameObject__SpawnObject
	str r0, [r4, #0x388]
	str r4, [r0, #0x364]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021602E0: .word _02179748
_021602E4: .word _0217974C
	arm_func_end ovl02_21601D8

	arm_func_start ovl02_21602E8
ovl02_21602E8: // 0x021602E8
	mov r3, #0
	mov r1, #1
_021602F0:
	add r2, r0, r3, lsl #2
	ldr r2, [r2, #0x384]
	add r3, r3, #1
	cmp r2, #0
	strne r1, [r2, #0x370]
	cmp r3, #2
	blt _021602F0
	bx lr
	arm_func_end ovl02_21602E8

	arm_func_start ovl02_2160310
ovl02_2160310: // 0x02160310
	stmdb sp!, {r3, lr}
	mov lr, #0
	mov r1, lr
_0216031C:
	add ip, r0, lr, lsl #2
	ldr r3, [ip, #0x384]
	cmp r3, #0
	beq _0216033C
	ldr r2, [r3, #0x18]
	orr r2, r2, #4
	str r2, [r3, #0x18]
	str r1, [ip, #0x384]
_0216033C:
	add lr, lr, #1
	cmp lr, #2
	blt _0216031C
	ldmia sp!, {r3, pc}
	arm_func_end ovl02_2160310

	arm_func_start ovl02_216034C
ovl02_216034C: // 0x0216034C
	mov r3, #0
_02160350:
	add r1, r0, r3, lsl #2
	ldr r2, [r1, #0x384]
	add r3, r3, #1
	cmp r2, #0
	ldrne r1, [r2, #0x18]
	orrne r1, r1, #2
	strne r1, [r2, #0x18]
	cmp r3, #2
	blt _02160350
	bx lr
	arm_func_end ovl02_216034C

	arm_func_start ovl02_2160378
ovl02_2160378: // 0x02160378
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, [r4, #0x3f0]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	cmp r0, #1
	beq _021603A0
	cmp r0, #2
	beq _021603C0
	ldmia sp!, {r3, r4, r5, pc}
_021603A0:
	ldr r3, [r4, #0x3f4]
	ldr r1, _0216040C // =_02179748
	ldr r2, _02160410 // =_0217974C
	ldr r0, [r4, #0x384]
	ldr r1, [r1, r3, lsl #3]
	ldr r2, [r2, r3, lsl #3]
	bl ovl02_2160650
	ldmia sp!, {r3, r4, r5, pc}
_021603C0:
	ldr r3, [r4, #0x3f4]
	ldr r1, _0216040C // =_02179748
	ldr r2, _02160410 // =_0217974C
	ldr r0, [r4, #0x384]
	ldr r1, [r1, r3, lsl #3]
	ldr r2, [r2, r3, lsl #3]
	ldr r5, [r4, #0x388]
	bl ovl02_2160650
	ldr r0, [r4, #0x3f4]
	ldr r1, _0216040C // =_02179748
	add r2, r0, #1
	cmp r2, #4
	movge r2, #0
	ldr r0, _02160410 // =_0217974C
	ldr r1, [r1, r2, lsl #3]
	ldr r2, [r0, r2, lsl #3]
	mov r0, r5
	bl ovl02_2160650
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216040C: .word _02179748
_02160410: .word _0217974C
	arm_func_end ovl02_2160378

	arm_func_start ovl02_2160414
ovl02_2160414: // 0x02160414
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r5, [r4, #0x3f0]
	bl ovl02_2160084
	cmp r5, r0
	beq _0216048C
	ldr r0, [r4, #0x3f8]
	cmp r0, #0
	mov r0, r4
	beq _02160468
	bl ovl02_2160168
	cmp r0, #0
	beq _02160450
	mov r0, r4
	bl ovl02_21602E8
_02160450:
	mov r0, r4
	bl ovl02_21601A0
	cmp r0, #0
	movne r0, #0
	strne r0, [r4, #0x3f8]
	ldmia sp!, {r3, r4, r5, pc}
_02160468:
	bl ovl02_2160084
	str r0, [r4, #0x3f0]
	mov r0, r4
	bl ovl02_2160310
	mov r0, r4
	bl ovl02_21601D8
	mov r0, #1
	str r0, [r4, #0x3f8]
	ldmia sp!, {r3, r4, r5, pc}
_0216048C:
	cmp r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x3f8]
	cmp r0, #0
	beq _021604D0
	mov r0, r4
	bl ovl02_2160168
	cmp r0, #0
	beq _021604B8
	mov r0, r4
	bl ovl02_21602E8
_021604B8:
	mov r0, r4
	bl ovl02_21601A0
	cmp r0, #0
	movne r0, #0
	strne r0, [r4, #0x3f8]
	ldmia sp!, {r3, r4, r5, pc}
_021604D0:
	ldr r0, [r4, #0x3f4]
	add r0, r0, #1
	str r0, [r4, #0x3f4]
	cmp r0, #4
	movge r0, #0
	strge r0, [r4, #0x3f4]
	mov r0, r4
	bl ovl02_2160378
	mov r0, #1
	str r0, [r4, #0x3f8]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_2160414

	arm_func_start ovl02_21604FC
ovl02_21604FC: // 0x021604FC
	stmdb sp!, {r3, lr}
	add ip, r0, #0x400
	add r0, r0, #0x44
	add r3, ip, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [ip, #0x4c]
	mov r0, ip
	rsb r1, r1, #0
	str r1, [ip, #0x4c]
	bl AnimatorMDL__Draw
	ldmia sp!, {r3, pc}
	arm_func_end ovl02_21604FC

	arm_func_start ovl02_216052C
ovl02_216052C: // 0x0216052C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r3, [r1, #0x80]
	ldrh r2, [r1, #0x82]
	add r2, r3, r2
	strh r2, [r1, #0x80]
	ldr r1, [r4, #0x368]
	cmp r1, #0
	beq _02160558
	blx r1
_02160558:
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_216052C

	arm_func_start ovl02_2160568
ovl02_2160568: // 0x02160568
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	add r0, r0, #0x394
	bl AnimatorMDL__Release
	ldmia sp!, {r3, pc}
	arm_func_end ovl02_2160568

	arm_func_start ovl02_216057C
ovl02_216057C: // 0x0216057C
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x44
	add r3, r4, #0x3dc
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x3e0]
	add r0, r4, #0x300
	rsb r1, r1, #0
	str r1, [r4, #0x3e0]
	ldr r1, [r4, #0x384]
	ldr r3, _0216060C // =FX_SinCosTable_
	str r1, [r4, #0x3e4]
	ldrh r1, [r0, #0x80]
	add r0, r4, #0x3b8
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	blx MTX_RotZ33_
	ldr r1, [r4, #0x390]
	add r0, r4, #0x394
	str r1, [r4, #0x3ac]
	str r1, [r4, #0x3b0]
	str r1, [r4, #0x3b4]
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #0x394
	bl AnimatorMDL__Draw
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216060C: .word FX_SinCosTable_
	arm_func_end ovl02_216057C

	arm_func_start ovl02_2160610
ovl02_2160610: // 0x02160610
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x18]
	tst r1, #0xc
	ldmneia sp!, {r3, pc}
	tst r1, #2
	ldmneia sp!, {r3, pc}
	ldr r1, [r0, #0x270]
	tst r1, #4
	ldmeqia sp!, {r3, pc}
	ldr r1, [r0, #0x44]
	ldr r2, [r0, #0x48]
	ldr r3, [r0, #0x4c]
	add r0, r0, #0x258
	bl BossHelpers__Collision__Func_20390AC
	ldmia sp!, {r3, pc}
	arm_func_end ovl02_2160610

	arm_func_start ovl02_2160650
ovl02_2160650: // 0x02160650
	ldr ip, [r0, #0x270]
	mov r3, #0
	bic ip, ip, #4
	str ip, [r0, #0x270]
	str r3, [r0, #0x370]
	str r3, [r0, #0x374]
	str r3, [r0, #0x37c]
	str r3, [r0, #0x388]
	str r3, [r0, #0x390]
	str r3, [r0, #0xc8]
	str r1, [r0, #0x44]
	ldr r1, _0216068C // =ovl02_2160690
	str r2, [r0, #0x48]
	str r1, [r0, #0x368]
	bx lr
	.align 2, 0
_0216068C: .word ovl02_2160690
	arm_func_end ovl02_2160650

	arm_func_start ovl02_2160690
ovl02_2160690: // 0x02160690
	mov r2, #0
	str r2, [r0, #0x98]
	add r1, r0, #0x300
	strh r2, [r1, #0x82]
	str r2, [r0, #0x390]
	ldr r1, [r0, #0x270]
	bic r1, r1, #4
	str r1, [r0, #0x270]
	ldr r1, [r0, #0x36c]
	cmp r1, #0
	beq _021606D8
	cmp r1, #1
	bne _021606E8
	mov r1, #0x20000
	str r1, [r0, #0x384]
	mov r1, #0x7000
	str r1, [r0, #0x38c]
	b _021606E8
_021606D8:
	mov r1, #0x20000
	str r1, [r0, #0x384]
	sub r1, r1, #0x27000
	str r1, [r0, #0x38c]
_021606E8:
	ldr r1, _021606F4 // =ovl02_21606F8
	str r1, [r0, #0x368]
	bx lr
	.align 2, 0
_021606F4: .word ovl02_21606F8
	arm_func_end ovl02_2160690

	arm_func_start ovl02_21606F8
ovl02_21606F8: // 0x021606F8
	ldr r1, [r0, #0x390]
	ldr r2, _0216071C // =0x0002D0AD
	add r1, r1, #0x4000
	str r1, [r0, #0x390]
	cmp r1, r2
	ldrge r1, _02160720 // =ovl02_2160724
	strge r2, [r0, #0x390]
	strge r1, [r0, #0x368]
	bx lr
	.align 2, 0
_0216071C: .word 0x0002D0AD
_02160720: .word ovl02_2160724
	arm_func_end ovl02_21606F8

	arm_func_start ovl02_2160724
ovl02_2160724: // 0x02160724
	mov r2, #0x3c
	ldr r1, _02160738 // =ovl02_216073C
	str r2, [r0, #0x378]
	str r1, [r0, #0x368]
	bx lr
	.align 2, 0
_02160738: .word ovl02_216073C
	arm_func_end ovl02_2160724

	arm_func_start ovl02_216073C
ovl02_216073C: // 0x0216073C
	ldr r1, [r0, #0x378]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0x378]
	ldreq r1, _02160758 // =ovl02_216075C
	streq r1, [r0, #0x368]
	bx lr
	.align 2, 0
_02160758: .word ovl02_216075C
	arm_func_end ovl02_216073C

	arm_func_start ovl02_216075C
ovl02_216075C: // 0x0216075C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x270]
	mov r0, #0
	orr r1, r1, #4
	str r1, [r4, #0x270]
	ldr r2, [r4, #0x38c]
	ldr r1, _021607D4 // =0x000004FA
	str r2, [r4, #0x388]
	str r0, [r4, #0xc8]
	add r0, r4, #0x300
	strh r1, [r0, #0x82]
	ldr r0, [r4, #0x364]
	bl ovl02_215FFDC
	cmp r0, #0
	bne _021607C4
	mov r1, #0
	mov r0, #0xed
	str r1, [sp]
	sub r1, r0, #0xee
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_021607C4:
	ldr r0, _021607D8 // =ovl02_21607DC
	str r0, [r4, #0x368]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021607D4: .word 0x000004FA
_021607D8: .word ovl02_21607DC
	arm_func_end ovl02_216075C

	arm_func_start ovl02_21607DC
ovl02_21607DC: // 0x021607DC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x1c]
	tst r0, #0xc
	bne _02160800
	ldr r0, [r4, #0xe4]
	tst r0, #1
	beq _02160878
_02160800:
	ldr r0, [r4, #0x44]
	cmp r0, #0
	movlt r0, #0
	blt _02160818
	cmp r0, #0x2c0000
	movgt r0, #0x2c0000
_02160818:
	str r0, [r4, #0x44]
	ldr r0, [r4, #0x388]
	mov r1, #0
	rsb r0, r0, #0
	str r0, [r4, #0x388]
	str r0, [r4, #0xc8]
	ldr r0, [r4, #0x138]
	bl NNS_SndPlayerStopSeq
	ldr r0, [r4, #0x364]
	bl ovl02_215FFDC
	cmp r0, #0
	bne _0216086C
	mov r1, #0
	mov r0, #0xed
	str r1, [sp]
	sub r1, r0, #0xee
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_0216086C:
	ldr r0, [r4, #0x37c]
	add r0, r0, #1
	str r0, [r4, #0x37c]
_02160878:
	ldr r1, [r4, #0x388]
	ldr r2, [r4, #0xc8]
	cmp r1, #0
	rsblt r0, r1, #0
	movge r0, r1
	cmp r2, #0
	rsblt r2, r2, #0
	cmp r2, r0
	strge r1, [r4, #0xc8]
	bge _021608AC
	ldr r0, [r4, #0xc8]
	add r0, r0, r1, asr #6
	str r0, [r4, #0xc8]
_021608AC:
	ldr r0, [r4, #0x370]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	str r1, [r4, #0x370]
	ldr r0, [r4, #0x138]
	bl NNS_SndPlayerStopSeq
	ldr r0, _021608DC // =ovl02_21608E0
	str r0, [r4, #0x368]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021608DC: .word ovl02_21608E0
	arm_func_end ovl02_21607DC

	arm_func_start ovl02_21608E0
ovl02_21608E0: // 0x021608E0
	mov r2, #0
	ldr r1, _021608F4 // =ovl02_21608F8
	str r2, [r0, #0xc8]
	str r1, [r0, #0x368]
	bx lr
	.align 2, 0
_021608F4: .word ovl02_21608F8
	arm_func_end ovl02_21608E0

	arm_func_start ovl02_21608F8
ovl02_21608F8: // 0x021608F8
	ldr r1, [r0, #0x390]
	sub r1, r1, #0x4000
	str r1, [r0, #0x390]
	cmp r1, #0
	bxgt lr
	mov r1, #0
	str r1, [r0, #0x390]
	mov r1, #1
	str r1, [r0, #0x374]
	bx lr
	arm_func_end ovl02_21608F8

	arm_func_start ovl02_2160920
ovl02_2160920: // 0x02160920
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	add r0, r4, #0x300
	mov r1, #0
	strh r1, [r0, #0xd0]
	ldr r0, [r4, #0x3d4]
	tst r0, #0x20
	beq _02160954
	ldr r0, _02160A08 // =ovl02_2166D68
	str r0, [r4, #0x3c8]
	ldr r0, [r4, #0x3d4]
	bic r0, r0, #0x20
	str r0, [r4, #0x3d4]
_02160954:
	ldr r1, [r4, #0x3c8]
	cmp r1, #0
	beq _02160974
	ldr r0, [r4, #0x3d4]
	tst r0, #0x10
	bne _02160974
	mov r0, r4
	blx r1
_02160974:
	mov r0, r4
	bl ovl02_215DB18
	ldr r1, [r4, #0x3cc]
	cmp r1, #0
	beq _02160990
	mov r0, r4
	blx r1
_02160990:
	mov r0, r4
	bl ovl02_215E4CC
	cmp r0, #0
	bne _021609F8
	mov r0, r4
	bl ovl02_215E4F0
	cmp r0, #0
	bne _021609F8
	mov r5, #0
_021609B4:
	ldr r0, [r4, #0x370]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x378]
	cmp r0, #0
	beq _021609E4
	bl ovl02_2163840
	cmp r0, #0
	beq _021609E4
	ldr r0, [r4, #0x370]
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x378]
	bl ovl02_216389C
_021609E4:
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #2
	blo _021609B4
_021609F8:
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02160A08: .word ovl02_2166D68
	arm_func_end ovl02_2160920

	arm_func_start ovl02_2160A0C
ovl02_2160A0C: // 0x02160A0C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	add r0, r0, #0x24c
	add r0, r0, #0x800
	bl AnimatorMDL__Release
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2160A0C

	arm_func_start ovl02_2160A30
ovl02_2160A30: // 0x02160A30
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x24c
	add r5, r0, #0x800
	add r0, r4, #0x44
	add r3, r5, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r5, #0x4c]
	add r0, r4, #0x500
	rsb r1, r1, #0
	str r1, [r5, #0x4c]
	ldr r1, [r4, #0x20]
	ldrh r0, [r0, #0x7a]
	tst r1, #1
	beq _02160AB4
	add r0, r0, #0x4000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _02160B6C // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r5, #0x24
	blx MTX_RotY33_
	b _02160AF0
_02160AB4:
	add r0, r0, #0xc000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _02160B6C // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r5, #0x24
	blx MTX_RotY33_
_02160AF0:
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	beq _02160B18
	add r0, r4, #0x300
	ldrsh r0, [r0, #0x50]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl AnimatorMDL__ProcessAnimation
	ldmia sp!, {r3, r4, r5, pc}
_02160B18:
	mov r0, r5
	bl AnimatorMDL__ProcessAnimation
	mov r0, r5
	bl AnimatorMDL__Draw
	add r0, r4, #0x18c
	add r1, r0, #0x800
	mov r0, #0x1e
	bl BossHelpers__Model__SetMatrixMode
	add r0, r4, #0x1bc
	add r1, r0, #0x800
	mov r0, #0x1d
	bl BossHelpers__Model__SetMatrixMode
	add r0, r4, #0x1ec
	add r1, r0, #0x800
	mov r0, #0x1c
	bl BossHelpers__Model__SetMatrixMode
	add r0, r4, #0x21c
	add r1, r0, #0x800
	mov r0, #0x1b
	bl BossHelpers__Model__SetMatrixMode
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02160B6C: .word FX_SinCosTable_
	arm_func_end ovl02_2160A30

	arm_func_start ovl02_2160B70
ovl02_2160B70: // 0x02160B70
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x24
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x24c
	add r5, r0, #0x800
	add r0, r4, #0x44
	add r3, r5, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r5, #0x4c]
	add r0, r4, #0x500
	rsb r1, r1, #0
	str r1, [r5, #0x4c]
	ldr r1, [r4, #0x20]
	ldrh r0, [r0, #0x7a]
	tst r1, #1
	beq _02160BF8
	add r0, r0, #0x4000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _02160C9C // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r5, #0x24
	blx MTX_RotY33_
	b _02160C34
_02160BF8:
	add r0, r0, #0xc000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _02160C9C // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r5, #0x24
	blx MTX_RotY33_
_02160C34:
	add r2, r4, #0x500
	ldrh r1, [r2, #0x7c]
	ldr r3, _02160C9C // =FX_SinCosTable_
	add r0, sp, #0
	add r1, r1, #0x55
	add r1, r1, #0x1500
	strh r1, [r2, #0x7c]
	ldrh r1, [r2, #0x7c]
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	blx MTX_RotZ33_
	add r0, r5, #0x24
	add r1, sp, #0
	mov r2, r0
	bl MTX_Concat33
	mov r0, r5
	bl AnimatorMDL__ProcessAnimation
	mov r0, r5
	bl AnimatorMDL__Draw
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02160C9C: .word FX_SinCosTable_
	arm_func_end ovl02_2160B70

	arm_func_start ovl02_2160CA0
ovl02_2160CA0: // 0x02160CA0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x18]
	tst r0, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	tst r0, #2
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	add r0, r4, #0x500
	ldrh r1, [r0, #0x7e]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x7e]
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	add r0, r4, #0x300
	ldrsh r0, [r0, #0x50]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	add r0, r4, #0xb8
	add r6, r4, #0x3f8
	add r7, r0, #0x400
	mov r5, #0
_02160CF8:
	ldr r0, [r6, #0x18]
	tst r0, #4
	beq _02160D1C
	ldr r2, [r4, #0x9e4]
	ldr r1, [r4, #0x9e0]
	ldr r3, [r4, #0x9e8]
	mov r0, r6
	rsb r2, r2, #0
	bl BossHelpers__Collision__Func_20390AC
_02160D1C:
	ldr r0, [r7, #0x18]
	tst r0, #4
	beq _02160D40
	ldr r2, [r4, #0x9b4]
	ldr r1, [r4, #0x9b0]
	ldr r3, [r4, #0x9b8]
	mov r0, r7
	rsb r2, r2, #0
	bl BossHelpers__Collision__Func_20390AC
_02160D40:
	add r5, r5, #1
	cmp r5, #3
	add r6, r6, #0x40
	add r7, r7, #0x40
	blt _02160CF8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end ovl02_2160CA0

	arm_func_start ovl02_2160D58
ovl02_2160D58: // 0x02160D58
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r2, [r5]
	cmp r2, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r2, [r4, #0x3d4]
	tst r2, #4
	beq _02160E08
	ldr r0, _02160F5C // =gPlayer
	ldr r0, [r0]
	add r0, r0, #0x600
	ldrsh r0, [r0, #0x82]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl ovl02_215E430
	cmp r0, #0
	beq _02160DC0
	mov r0, r4
	mov r1, #0x28
	mov r2, #0
	bl ovl02_215EF6C
_02160DC0:
	ldr r0, _02160F5C // =gPlayer
	ldr r0, [r0]
	add r0, r0, #0x1b0
	bl ovl02_215F6DC
	mov r2, #0
	mov r0, #0xea
	str r2, [sp]
	sub r1, r0, #0xeb
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, r4
	mov r1, r5
	bl ovl02_215E0F8
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_02160E08:
	ldr r2, [r5, #0x568]
	tst r2, #4
	beq _02160EA0
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x374]
	cmp r0, #0
	beq _02160E48
	add r0, r0, #0x300
	ldrsh r0, [r0, #0xd2]
	cmp r0, #0
	bgt _02160E48
	mov r0, r4
	mov r1, r5
	bl ovl02_215E0F8
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_02160E48:
	mov r0, r4
	bl ovl02_215F230
	ldr r0, _02160F5C // =gPlayer
	ldr r0, [r0]
	add r0, r0, #0x1b0
	bl ovl02_215F6A8
	mov r3, #0x8c
	mov r0, #0
	sub r1, r3, #0x8d
	stmia sp, {r0, r3}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, r4
	bl ovl02_215F440
	mov r0, r5
	bl Player__Action_DestroyAttackRecoil
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_02160EA0:
	ldr r2, _02160F5C // =gPlayer
	ldr r2, [r2]
	add r2, r2, #0x600
	ldrsh r2, [r2, #0x82]
	cmp r2, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r3, [r5, #0x44]
	ldr r2, [r4, #0x44]
	cmp r2, r3
	bge _02160EF4
	ldrsh ip, [r1, #6]
	ldr lr, [r1, #0xc]
	ldrsh r1, [r0]
	add ip, lr, ip
	mov r0, #0x4000
	sub r1, ip, r1
	add r1, r2, r1, lsl #12
	sub r1, r1, r3
	str r1, [r5, #0xb0]
	b _02160F1C
_02160EF4:
	ldrsh ip, [r1]
	ldr lr, [r1, #0xc]
	ldrsh r1, [r0, #6]
	add ip, lr, ip
	mov r0, #0x4000
	sub r1, ip, r1
	add r1, r2, r1, lsl #12
	sub r1, r1, r3
	str r1, [r5, #0xb0]
	rsb r0, r0, #0
_02160F1C:
	ldr r1, [r4, #0x3d4]
	tst r1, #8
	bne _02160F44
	ldr r2, [r5, #0xb0]
	rsb r1, r0, #0
	mov r2, r2, asr #1
	str r2, [r5, #0xb0]
	rsb r2, r2, #0
	str r2, [r4, #0xb0]
	str r1, [r4, #0x98]
_02160F44:
	ldr r1, [r5, #0x1c]
	tst r1, #0x8000
	strne r0, [r5, #0x98]
	streq r0, [r5, #0xc8]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02160F5C: .word gPlayer
	arm_func_end ovl02_2160D58

	arm_func_start ovl02_2160F60
ovl02_2160F60: // 0x02160F60
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r5, r1
	ldr r7, [r5, #0x1c]
	mov r6, r0
	ldrh r0, [r7]
	ldr r4, [r6, #0x1c]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, r4
	bl ovl02_215E484
	cmp r0, #0
	beq _02160FD8
	add r0, r4, #0x500
	ldrsh r2, [r0, #0x78]
	cmp r2, #0x64
	blt _02160FD8
	ldr r1, [r7, #0x44]
	ldr r0, [r4, #0x44]
	subs r1, r1, r0
	rsbmi r1, r1, #0
	sub r0, r2, #0x20
	cmp r1, r0, lsl #12
	bge _02160FD8
	mov r0, r6
	mov r1, r5
	bl ObjRect__FuncNoHit
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02160FD8:
	mov r1, #0
	ldr r0, _02161004 // =0x00000107
	str r1, [sp]
	sub r1, r0, #0x108
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02161004: .word 0x00000107
	arm_func_end ovl02_2160F60

	arm_func_start ovl02_2161008
ovl02_2161008: // 0x02161008
	ldr r1, [r0, #0x410]
	orr r1, r1, #4
	str r1, [r0, #0x410]
	ldr r1, [r0, #0x4d0]
	orr r1, r1, #4
	str r1, [r0, #0x4d0]
	ldr r1, [r0, #0x450]
	bic r1, r1, #4
	str r1, [r0, #0x450]
	ldr r1, [r0, #0x510]
	bic r1, r1, #4
	str r1, [r0, #0x510]
	ldr r1, [r0, #0x3d4]
	bic r1, r1, #4
	str r1, [r0, #0x3d4]
	bx lr
	arm_func_end ovl02_2161008

	arm_func_start ovl02_2161048
ovl02_2161048: // 0x02161048
	ldr r1, [r0, #0x410]
	bic r1, r1, #4
	str r1, [r0, #0x410]
	ldr r1, [r0, #0x4d0]
	bic r1, r1, #4
	str r1, [r0, #0x4d0]
	ldr r1, [r0, #0x450]
	orr r1, r1, #4
	str r1, [r0, #0x450]
	ldr r1, [r0, #0x510]
	orr r1, r1, #4
	str r1, [r0, #0x510]
	ldr r1, [r0, #0x3d4]
	bic r1, r1, #4
	str r1, [r0, #0x3d4]
	bx lr
	arm_func_end ovl02_2161048

	arm_func_start ovl02_2161088
ovl02_2161088: // 0x02161088
	ldr r1, [r0, #0x410]
	orr r1, r1, #4
	str r1, [r0, #0x410]
	ldr r1, [r0, #0x4d0]
	bic r1, r1, #4
	str r1, [r0, #0x4d0]
	ldr r1, [r0, #0x450]
	bic r1, r1, #4
	str r1, [r0, #0x450]
	ldr r1, [r0, #0x510]
	orr r1, r1, #4
	str r1, [r0, #0x510]
	ldr r1, [r0, #0x3d4]
	bic r1, r1, #4
	str r1, [r0, #0x3d4]
	bx lr
	arm_func_end ovl02_2161088

	arm_func_start ovl02_21610C8
ovl02_21610C8: // 0x021610C8
	ldr r1, [r0, #0x410]
	orr r1, r1, #4
	str r1, [r0, #0x410]
	ldr r1, [r0, #0x4d0]
	orr r1, r1, #4
	str r1, [r0, #0x4d0]
	ldr r1, [r0, #0x450]
	bic r1, r1, #4
	str r1, [r0, #0x450]
	ldr r1, [r0, #0x510]
	bic r1, r1, #4
	str r1, [r0, #0x510]
	ldr r1, [r0, #0x3d4]
	orr r1, r1, #4
	str r1, [r0, #0x3d4]
	bx lr
	arm_func_end ovl02_21610C8

	arm_func_start ovl02_2161108
ovl02_2161108: // 0x02161108
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	add r3, sp, #0
	add r0, r0, #0x9b0
	mov ip, r1
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [sp, #4]
	mov r0, r3
	rsb r2, r1, #0
	add r1, ip, #0x44
	str r2, [sp, #4]
	bl VEC_Distance
	cmp r0, #0x40000
	movle r0, #1
	movgt r0, #0
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end ovl02_2161108

	arm_func_start ovl02_2161150
ovl02_2161150: // 0x02161150
	stmdb sp!, {r3, lr}
	ldr r2, _02161184 // =_021796C0
	mov r3, r1
	ldrsh ip, [r2, #0x4e]
	rsb r1, r3, #0
	add r0, r0, #0xf8
	str ip, [sp]
	ldrsh r2, [r2, #0x4a]
	mov r1, r1, lsl #0x10
	add r0, r0, #0x400
	mov r1, r1, asr #0x10
	bl ObjRect__SetBox2D
	ldmia sp!, {r3, pc}
	.align 2, 0
_02161184: .word _021796C0
	arm_func_end ovl02_2161150

	arm_func_start ovl02_2161188
ovl02_2161188: // 0x02161188
	stmdb sp!, {r3, lr}
	add r1, r0, #0x500
	mov r2, #0
	ldr r3, _021611C0 // =_021796C0
	strh r2, [r1, #0x78]
	ldrsh r1, [r3, #0x4e]
	add r0, r0, #0xf8
	add r0, r0, #0x400
	str r1, [sp]
	ldrsh r1, [r3, #0x48]
	ldrsh r2, [r3, #0x4a]
	ldrsh r3, [r3, #0x4c]
	bl ObjRect__SetBox2D
	ldmia sp!, {r3, pc}
	.align 2, 0
_021611C0: .word _021796C0
	arm_func_end ovl02_2161188

	arm_func_start ovl02_21611C4
ovl02_21611C4: // 0x021611C4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2161008
	ldr r0, [r4, #0x98]
	cmp r0, #0
	beq _021611E8
	mov r0, r4
	bl ovl02_216178C
	ldmia sp!, {r4, pc}
_021611E8:
	add r0, r4, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #3
	bgt _02161214
	cmp r0, #0
	addge pc, pc, r0, lsl #2
	b _0216125C
_02161204: // jump table
	b _02161220 // case 0
	b _02161234 // case 1
	b _02161234 // case 2
	b _02161234 // case 3
_02161214:
	cmp r0, #0x25
	beq _02161248
	b _0216125C
_02161220:
	mov r0, r4
	mov r1, #0
	mov r2, #1
	bl ovl02_215EF6C
	b _0216127C
_02161234:
	mov r0, r4
	mov r1, #4
	mov r2, #0
	bl ovl02_215EF6C
	b _0216127C
_02161248:
	mov r0, r4
	mov r1, #0
	mov r2, #1
	bl ovl02_215EF6C
	b _0216127C
_0216125C:
	mov r0, r4
	bl ovl02_215EFDC
	cmp r0, #0
	beq _0216127C
	mov r0, r4
	mov r1, #0
	mov r2, #1
	bl ovl02_215EF6C
_0216127C:
	ldr r0, _02161288 // =ovl02_216128C
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161288: .word ovl02_216128C
	arm_func_end ovl02_21611C4

	arm_func_start ovl02_216128C
ovl02_216128C: // 0x0216128C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r1, [r1, #0x58]
	cmp r1, #4
	bne _021612C0
	bl ovl02_215EFDC
	cmp r0, #0
	beq _021612C0
	mov r0, r4
	mov r1, #0
	mov r2, #1
	bl ovl02_215EF6C
_021612C0:
	mov r0, r4
	bl ovl02_215E19C
	cmp r0, #0
	beq _021612DC
	mov r0, r4
	bl ovl02_21613D0
	ldmia sp!, {r4, pc}
_021612DC:
	add r0, r4, #0x300
	ldrh r1, [r0, #0x74]
	ands r0, r1, #2
	beq _02161300
	tst r1, #0x40
	beq _02161300
	mov r0, r4
	bl ovl02_2161C2C
	ldmia sp!, {r4, pc}
_02161300:
	cmp r0, #0
	beq _0216131C
	tst r1, #0x80
	beq _0216131C
	mov r0, r4
	bl ovl02_2161624
	ldmia sp!, {r4, pc}
_0216131C:
	add r0, r4, #0x300
	ldrh r0, [r0, #0x78]
	tst r0, #2
	beq _02161338
	mov r0, r4
	bl ovl02_2161408
	ldmia sp!, {r4, pc}
_02161338:
	tst r1, #0x30
	ldreq r0, [r4, #0x98]
	cmpeq r0, #0
	beq _02161354
	mov r0, r4
	bl ovl02_216178C
	ldmia sp!, {r4, pc}
_02161354:
	ands r0, r1, #0x400
	beq _02161370
	tst r1, #0x40
	beq _02161370
	mov r0, r4
	bl ovl02_21622A4
	ldmia sp!, {r4, pc}
_02161370:
	cmp r0, #0
	beq _02161384
	mov r0, r4
	bl ovl02_2162114
	ldmia sp!, {r4, pc}
_02161384:
	ands r0, r1, #1
	beq _021613A0
	tst r1, #0x40
	beq _021613A0
	mov r0, r4
	bl ovl02_2162634
	ldmia sp!, {r4, pc}
_021613A0:
	cmp r0, #0
	beq _021613B4
	mov r0, r4
	bl ovl02_2162434
	ldmia sp!, {r4, pc}
_021613B4:
	tst r1, #0x800
	ldmeqia sp!, {r4, pc}
	tst r1, #0x40
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_2162864
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_216128C

	arm_func_start ovl02_21613D0
ovl02_21613D0: // 0x021613D0
	ldr r2, [r0, #0x20]
	ldr r1, _02161404 // =ovl02_2161588
	orr r2, r2, #4
	str r2, [r0, #0x20]
	ldr r2, [r0, #0x1c]
	orr r2, r2, #0x10
	orr r2, r2, #0x8000
	str r2, [r0, #0x1c]
	str r1, [r0, #0x3cc]
	ldr r1, [r0, #0x3d4]
	orr r1, r1, #1
	str r1, [r0, #0x3d4]
	bx lr
	.align 2, 0
_02161404: .word ovl02_2161588
	arm_func_end ovl02_21613D0

	arm_func_start ovl02_2161408
ovl02_2161408: // 0x02161408
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r2, #0
	str r2, [r4, #0x98]
	mov r1, #5
	bl ovl02_215EF6C
	ldr r1, [r4, #0x1c]
	ldr r0, _02161448 // =ovl02_216144C
	orr r1, r1, #0x10
	orr r1, r1, #0x8000
	str r1, [r4, #0x1c]
	str r0, [r4, #0x3cc]
	mov r0, #0
	str r0, [r4, #0x2c]
	str r0, [r4, #0x28]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161448: .word ovl02_216144C
	arm_func_end ovl02_2161408

	arm_func_start ovl02_216144C
ovl02_216144C: // 0x0216144C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	mov r0, #0xe1
	str r1, [sp]
	sub r1, r0, #0xe2
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, _0216149C // =ovl02_21614A0
	str r0, [r4, #0x3cc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216149C: .word ovl02_21614A0
	arm_func_end ovl02_216144C

	arm_func_start ovl02_21614A0
ovl02_21614A0: // 0x021614A0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2163300
	mov r3, #0xa000
	rsb r3, r3, #0
	mov r0, r4
	mov r1, #6
	mov r2, #1
	str r3, [r4, #0x9c]
	bl ovl02_215EF6C
	ldr r0, _021614D4 // =ovl02_21614D8
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021614D4: .word ovl02_21614D8
	arm_func_end ovl02_21614A0

	arm_func_start ovl02_21614D8
ovl02_21614D8: // 0x021614D8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2163300
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #2
	bne _02161508
	mov r1, #0x3000
	rsb r1, r1, #0
	ldr r0, _0216151C // =ovl02_2161520
	str r1, [r4, #0x9c]
	str r0, [r4, #0x3cc]
_02161508:
	ldr r0, [r4, #0x9c]
	cmp r0, #0
	ldrge r0, _0216151C // =ovl02_2161520
	strge r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216151C: .word ovl02_2161520
	arm_func_end ovl02_21614D8

	arm_func_start ovl02_2161520
ovl02_2161520: // 0x02161520
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2163300
	mov r0, r4
	mov r1, #7
	mov r2, #0
	bl ovl02_215EF6C
	ldr r0, _02161548 // =ovl02_216154C
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161548: .word ovl02_216154C
	arm_func_end ovl02_2161520

	arm_func_start ovl02_216154C
ovl02_216154C: // 0x0216154C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2163300
	mov r0, r4
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _02161580 // =ovl02_2161588
	strne r0, [r4, #0x3cc]
	ldr r0, [r4, #0x1c]
	tst r0, #1
	ldrne r0, _02161584 // =ovl02_21615D8
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161580: .word ovl02_2161588
_02161584: .word ovl02_21615D8
	arm_func_end ovl02_216154C

	arm_func_start ovl02_2161588
ovl02_2161588: // 0x02161588
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2163300
	mov r0, r4
	mov r1, #8
	mov r2, #1
	bl ovl02_215EF6C
	ldr r0, _021615B0 // =ovl02_21615B4
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021615B0: .word ovl02_21615B4
	arm_func_end ovl02_2161588

	arm_func_start ovl02_21615B4
ovl02_21615B4: // 0x021615B4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2163300
	ldr r0, [r4, #0x1c]
	tst r0, #1
	ldrne r0, _021615D4 // =ovl02_21615D8
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021615D4: .word ovl02_21615D8
	arm_func_end ovl02_21615B4

	arm_func_start ovl02_21615D8
ovl02_21615D8: // 0x021615D8
	stmdb sp!, {r4, lr}
	mov r1, #9
	mov r2, #0
	mov r4, r0
	bl ovl02_215EF6C
	mov r1, #0
	ldr r0, _02161600 // =ovl02_2161604
	str r1, [r4, #0x98]
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161600: .word ovl02_2161604
	arm_func_end ovl02_21615D8

	arm_func_start ovl02_2161604
ovl02_2161604: // 0x02161604
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_21611C4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2161604

	arm_func_start ovl02_2161624
ovl02_2161624: // 0x02161624
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r2, #0
	str r2, [r4, #0x98]
	mov r1, #7
	bl ovl02_215EF6C
	ldr r1, [r4, #0x1c]
	ldr r0, _02161670 // =ovl02_2161674
	orr r1, r1, #0x10
	orr r1, r1, #0x8000
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x18]
	bic r1, r1, #1
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x1c]
	bic r1, r1, #1
	str r1, [r4, #0x1c]
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161670: .word ovl02_2161674
	arm_func_end ovl02_2161624

	arm_func_start ovl02_2161674
ovl02_2161674: // 0x02161674
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2163300
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #2
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #1
	streq r0, [r4, #0x18]
	mov r0, r4
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _021616B0 // =ovl02_21616B4
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021616B0: .word ovl02_21616B4
	arm_func_end ovl02_2161674

	arm_func_start ovl02_21616B4
ovl02_21616B4: // 0x021616B4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2163300
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	mov r1, #8
	mov r2, #1
	tst r0, #2
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #1
	streq r0, [r4, #0x18]
	mov r0, r4
	bl ovl02_215EF6C
	ldr r0, _021616F4 // =ovl02_21616F8
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021616F4: .word ovl02_21616F8
	arm_func_end ovl02_21616B4

	arm_func_start ovl02_21616F8
ovl02_21616F8: // 0x021616F8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2163300
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #2
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #1
	streq r0, [r4, #0x18]
	ldr r0, [r4, #0x1c]
	tst r0, #1
	ldrne r0, _02161730 // =ovl02_2161734
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161730: .word ovl02_2161734
	arm_func_end ovl02_21616F8

	arm_func_start ovl02_2161734
ovl02_2161734: // 0x02161734
	stmdb sp!, {r4, lr}
	mov r1, #9
	mov r2, #0
	mov r4, r0
	bl ovl02_215EF6C
	mov r0, #0
	str r0, [r4, #0x98]
	ldr r1, [r4, #0x18]
	ldr r0, _02161768 // =ovl02_216176C
	orr r1, r1, #1
	str r1, [r4, #0x18]
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161768: .word ovl02_216176C
	arm_func_end ovl02_2161734

	arm_func_start ovl02_216176C
ovl02_216176C: // 0x0216176C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_21611C4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_216176C

	arm_func_start ovl02_216178C
ovl02_216178C: // 0x0216178C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x20]
	ands r1, r0, #1
	beq _021617B0
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #0x20
	bne _021617C8
_021617B0:
	cmp r1, #0
	bne _021617DC
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #0x10
	beq _021617DC
_021617C8:
	mov r0, r4
	mov r1, #1
	mov r2, #0
	bl ovl02_215EF6C
	b _02161838
_021617DC:
	add r0, r4, #0x300
	ldrh r1, [r0, #0x58]
	cmp r1, #1
	bne _021617F8
	mov r0, r4
	bl ovl02_215F138
	b _02161838
_021617F8:
	cmp r1, #2
	bne _02161814
	mov r0, r4
	mov r1, #3
	mov r2, #1
	bl ovl02_215EF6C
	b _02161838
_02161814:
	ldr r0, [r4, #0x98]
	cmp r0, #0
	beq _02161828
	cmp r1, #4
	beq _02161838
_02161828:
	mov r0, r4
	mov r1, #2
	mov r2, #0
	bl ovl02_215EF6C
_02161838:
	add r0, r4, #0x300
	ldrh r1, [r0, #0x58]
	cmp r1, #1
	bne _02161874
	ldrh r0, [r0, #0x74]
	tst r0, #0x20
	beq _02161864
	ldr r0, [r4, #0x3d4]
	orr r0, r0, #2
	str r0, [r4, #0x3d4]
	b _02161874
_02161864:
	tst r0, #0x10
	ldrne r0, [r4, #0x3d4]
	bicne r0, r0, #2
	strne r0, [r4, #0x3d4]
_02161874:
	ldr r0, [r4, #0x1c]
	ldr r1, _02161894 // =ovl02_2161898
	bic r0, r0, #0x10
	str r0, [r4, #0x1c]
	mov r0, r4
	str r1, [r4, #0x3cc]
	bl ovl02_2163230
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161894: .word ovl02_2161898
	arm_func_end ovl02_216178C

	arm_func_start ovl02_2161898
ovl02_2161898: // 0x02161898
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #3
	bne _021618EC
	ldr r0, [r4, #0xb30]
	ldr r0, [r0]
	cmp r0, #0x1000
	cmpne r0, #0x32000
	bne _021618EC
	mov r1, #0
	mov r0, #0xe0
	str r1, [sp]
	sub r1, r0, #0xe1
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_021618EC:
	add r0, r4, #0x300
	ldrh r1, [r0, #0x74]
	ands r2, r1, #0x20
	beq _02161908
	ldr r0, [r4, #0x98]
	cmp r0, #0
	bgt _0216191C
_02161908:
	tst r1, #0x10
	beq _0216196C
	ldr r0, [r4, #0x98]
	cmp r0, #0
	bge _0216196C
_0216191C:
	cmp r2, #0
	beq _02161934
	ldr r0, [r4, #0x3d4]
	orr r0, r0, #2
	str r0, [r4, #0x3d4]
	b _02161944
_02161934:
	tst r1, #0x10
	ldrne r0, [r4, #0x3d4]
	bicne r0, r0, #2
	strne r0, [r4, #0x3d4]
_02161944:
	add r0, r4, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #1
	bne _0216196C
	mov r0, r4
	bl ovl02_215E1B0
	mov r0, r4
	mov r1, #3
	mov r2, #1
	bl ovl02_215EF6C
_0216196C:
	add r0, r4, #0x300
	ldrh r1, [r0, #0x58]
	cmp r1, #1
	bne _021619A8
	ldrh r0, [r0, #0x74]
	tst r0, #0x20
	beq _02161998
	ldr r0, [r4, #0x3d4]
	orr r0, r0, #2
	str r0, [r4, #0x3d4]
	b _021619A8
_02161998:
	tst r0, #0x10
	ldrne r0, [r4, #0x3d4]
	bicne r0, r0, #2
	strne r0, [r4, #0x3d4]
_021619A8:
	mov r0, r4
	bl ovl02_215E19C
	cmp r0, #0
	beq _021619D0
	mov r0, r4
	bl ovl02_215E1B0
	mov r0, r4
	bl ovl02_21613D0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_021619D0:
	add r0, r4, #0x300
	ldrh r2, [r0, #0x58]
	cmp r2, #1
	bne _02161A24
	mov r0, r4
	bl ovl02_215F1A0
	cmp r0, #0
	beq _02161AC8
	mov r0, r4
	bl ovl02_215E1B0
	ldr r0, [r4, #0x98]
	cmp r0, #0
	ldreq r0, [r4, #0xa0]
	cmpeq r0, #0
	mov r0, r4
	bne _02161A1C
	bl ovl02_21611C4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02161A1C:
	bl ovl02_215F138
	b _02161AC8
_02161A24:
	ldr r1, [r4, #0x98]
	cmp r1, #0
	bne _02161A54
	ldrh r0, [r0, #0x74]
	tst r0, #0x30
	bne _02161A54
	mov r0, r4
	bl ovl02_215E1B0
	mov r0, r4
	bl ovl02_21611C4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02161A54:
	cmp r2, #2
	bne _02161A80
	mov r0, r4
	bl ovl02_215EFDC
	cmp r0, #0
	beq _02161AC8
	mov r0, r4
	bl ovl02_215E1B0
	mov r0, r4
	bl ovl02_215F138
	b _02161AC8
_02161A80:
	cmp r2, #4
	bne _02161AC8
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #0x30
	mov r0, r4
	beq _02161AAC
	bl ovl02_215E1B0
	mov r0, r4
	bl ovl02_215F138
	b _02161AC8
_02161AAC:
	bl ovl02_215EFDC
	cmp r0, #0
	beq _02161AC8
	mov r0, r4
	bl ovl02_215E1B0
	mov r0, r4
	bl ovl02_21611C4
_02161AC8:
	mov r0, r4
	bl ovl02_2163230
	add r0, r4, #0x300
	ldrh r1, [r0, #0x74]
	ands r0, r1, #2
	beq _02161B00
	tst r1, #0x40
	beq _02161B00
	mov r0, r4
	bl ovl02_215E1B0
	mov r0, r4
	bl ovl02_2161C2C
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02161B00:
	cmp r0, #0
	beq _02161B28
	tst r1, #0x80
	beq _02161B28
	mov r0, r4
	bl ovl02_215E1B0
	mov r0, r4
	bl ovl02_2161624
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02161B28:
	add r0, r4, #0x300
	ldrh r0, [r0, #0x78]
	tst r0, #2
	beq _02161B50
	mov r0, r4
	bl ovl02_215E1B0
	mov r0, r4
	bl ovl02_2161408
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02161B50:
	ands r0, r1, #0x400
	beq _02161B78
	tst r1, #0x40
	beq _02161B78
	mov r0, r4
	bl ovl02_215E1B0
	mov r0, r4
	bl ovl02_21622A4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02161B78:
	cmp r0, #0
	beq _02161B98
	mov r0, r4
	bl ovl02_215E1B0
	mov r0, r4
	bl ovl02_2162114
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02161B98:
	ands r0, r1, #1
	beq _02161BC0
	tst r1, #0x40
	beq _02161BC0
	mov r0, r4
	bl ovl02_215E1B0
	mov r0, r4
	bl ovl02_2162634
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02161BC0:
	cmp r0, #0
	beq _02161BE0
	mov r0, r4
	bl ovl02_215E1B0
	mov r0, r4
	bl ovl02_2162434
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02161BE0:
	tst r1, #0x800
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	tst r1, #0x40
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E1B0
	mov r0, r4
	bl ovl02_2162864
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2161898

	arm_func_start ovl02_2161C10
ovl02_2161C10: // 0x02161C10
	ldr r1, [r0, #0x3dc]
	ldr r0, [r0, #0x48]
	sub r1, r1, #0x10000
	cmp r1, r0
	movlt r0, #1
	movge r0, #0
	bx lr
	arm_func_end ovl02_2161C10

	arm_func_start ovl02_2161C2C
ovl02_2161C2C: // 0x02161C2C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	ldr r0, _02161C88 // =gPlayer
	str r1, [r4, #0x98]
	ldr r0, [r0]
	add r3, r4, #0x3d8
	add r0, r0, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r4
	bl ovl02_21610C8
	mov r0, r4
	mov r1, #0xa
	mov r2, #0
	bl ovl02_215EF6C
	ldr r1, [r4, #0x1c]
	ldr r0, _02161C8C // =ovl02_2161C90
	orr r1, r1, #0x10
	orr r1, r1, #0x8000
	str r1, [r4, #0x1c]
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161C88: .word gPlayer
_02161C8C: .word ovl02_2161C90
	arm_func_end ovl02_2161C2C

	arm_func_start ovl02_2161C90
ovl02_2161C90: // 0x02161C90
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _02161CAC // =ovl02_2161CB0
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161CAC: .word ovl02_2161CB0
	arm_func_end ovl02_2161C90

	arm_func_start ovl02_2161CB0
ovl02_2161CB0: // 0x02161CB0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x20
	mov r1, #0
	mov r2, #0xe1
	str r1, [sp]
	sub r1, r2, #0xe2
	str r2, [sp, #4]
	mov r4, r0
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, r4
	bl ovl02_215F38C
	mov r0, r4
	bl ovl02_21633CC
	add r0, r4, #0x3d8
	add r3, sp, #0x14
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r2, [sp, #0x18]
	mov r0, r3
	sub r2, r2, #0x1b0000
	str r2, [sp, #0x18]
	add r1, r4, #0x44
	add r2, sp, #8
	bl VEC_Subtract
	ldr r0, [sp, #8]
	mov r2, #1
	mov r0, r0, asr #6
	str r0, [r4, #0x98]
	ldr r0, [sp, #0xc]
	movs r0, r0, asr #6
	str r0, [r4, #0x9c]
	movpl r0, r0, lsl #1
	rsbpl r0, r0, #0
	strpl r0, [r4, #0x9c]
	ldr r1, [r4, #0x18]
	mov r0, r4
	bic r3, r1, #1
	mov r1, #0xb
	str r3, [r4, #0x18]
	bl ovl02_215EF6C
	ldr r0, _02161D6C // =ovl02_2161D70
	str r0, [r4, #0x3cc]
	add sp, sp, #0x20
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161D6C: .word ovl02_2161D70
	arm_func_end ovl02_2161CB0

	arm_func_start ovl02_2161D70
ovl02_2161D70: // 0x02161D70
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_21633CC
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #2
	ldmneia sp!, {r4, pc}
	mov r1, #0
	str r1, [r4, #0xa0]
	str r1, [r4, #0x9c]
	ldr r0, _02161DA8 // =ovl02_2161DAC
	str r1, [r4, #0x98]
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161DA8: .word ovl02_2161DAC
	arm_func_end ovl02_2161D70

	arm_func_start ovl02_2161DAC
ovl02_2161DAC: // 0x02161DAC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	mov r2, #0xe3
	str r1, [sp]
	sub r1, r2, #0xe4
	str r2, [sp, #4]
	mov r4, r0
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r2, #0
	str r2, [r4, #0xa0]
	str r2, [r4, #0x9c]
	str r2, [r4, #0x98]
	ldr r1, [r4, #0x1c]
	mov r0, r4
	bic r3, r1, #0x80
	mov r1, #0xc
	str r3, [r4, #0x1c]
	bl ovl02_215EF6C
	ldr r0, _02161E14 // =ovl02_2161E18
	str r0, [r4, #0x3cc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161E14: .word ovl02_2161E18
	arm_func_end ovl02_2161DAC

	arm_func_start ovl02_2161E18
ovl02_2161E18: // 0x02161E18
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _02161E34 // =ovl02_2161E38
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161E34: .word ovl02_2161E38
	arm_func_end ovl02_2161E18

	arm_func_start ovl02_2161E38
ovl02_2161E38: // 0x02161E38
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r3, #0x4000
	mov r1, #0xd
	mov r2, #1
	str r3, [r4, #0xb64]
	bl ovl02_215EF6C
	ldr r0, _02161E60 // =ovl02_2161E64
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161E60: .word ovl02_2161E64
	arm_func_end ovl02_2161E38

	arm_func_start ovl02_2161E64
ovl02_2161E64: // 0x02161E64
	add r1, r0, #0x300
	ldrh r1, [r1, #0x74]
	tst r1, #0x40
	bxne lr
	mov r2, #0x1000
	ldr r1, _02161E88 // =ovl02_2161E8C
	str r2, [r0, #0xb64]
	str r1, [r0, #0x3cc]
	bx lr
	.align 2, 0
_02161E88: .word ovl02_2161E8C
	arm_func_end ovl02_2161E64

	arm_func_start ovl02_2161E8C
ovl02_2161E8C: // 0x02161E8C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2161048
	mov r0, r4
	mov r1, #0xe
	mov r2, #0
	bl ovl02_215EF6C
	ldr r0, _02161EB4 // =ovl02_2161EB8
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161EB4: .word ovl02_2161EB8
	arm_func_end ovl02_2161E8C

	arm_func_start ovl02_2161EB8
ovl02_2161EB8: // 0x02161EB8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2161C10
	cmp r0, #0
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #1
	strne r0, [r4, #0x18]
	mov r0, r4
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _02161EEC // =ovl02_2161EF0
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161EEC: .word ovl02_2161EF0
	arm_func_end ovl02_2161EB8

	arm_func_start ovl02_2161EF0
ovl02_2161EF0: // 0x02161EF0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0x1c]
	mov r1, #0xa000
	orr r2, r2, #0x80
	str r2, [r4, #0x1c]
	str r1, [r4, #0x9c]
	bl ovl02_2161048
	mov r0, r4
	add r3, r4, #0x500
	mov ip, #0
	mov r1, #0xf
	mov r2, #1
	strh ip, [r3, #0x78]
	bl ovl02_215EF6C
	mov r0, r4
	bl ovl02_2161C10
	cmp r0, #0
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #1
	strne r0, [r4, #0x18]
	ldr r0, _02161F50 // =ovl02_2161F54
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161F50: .word ovl02_2161F54
	arm_func_end ovl02_2161EF0

	arm_func_start ovl02_2161F54
ovl02_2161F54: // 0x02161F54
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2161C10
	cmp r0, #0
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #1
	strne r0, [r4, #0x18]
	ldr r0, [r4, #0x1c]
	tst r0, #1
	ldrne r0, _02161F84 // =ovl02_2161F88
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161F84: .word ovl02_2161F88
	arm_func_end ovl02_2161F54

	arm_func_start ovl02_2161F88
ovl02_2161F88: // 0x02161F88
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	rsb r2, r0, #0
	ldr r3, [r4, #0x4c]
	mov r0, #0
	bl BossFX__CreateRivalHipatk
	mov r2, #0
	mov r0, #0xe4
	str r2, [sp]
	sub r1, r0, #0xe5
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r1, [r4, #0x3d4]
	mov r0, r4
	orr r1, r1, #8
	str r1, [r4, #0x3d4]
	ldr r1, [r4, #0x18]
	orr r1, r1, #1
	str r1, [r4, #0x18]
	bl ovl02_2161088
	mov r1, #0x28
	add r0, r4, #0x500
	strh r1, [r0, #0x78]
	mov r0, r4
	bl ovl02_2161150
	mov r0, r4
	mov r1, #0x10
	mov r2, #0
	bl ovl02_215EF6C
	ldr r0, _02162024 // =ovl02_2162028
	str r0, [r4, #0x3cc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162024: .word ovl02_2162028
	arm_func_end ovl02_2161F88

	arm_func_start ovl02_2162028
ovl02_2162028: // 0x02162028
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x500
	ldrsh r1, [r0, #0x78]
	cmp r1, #0x1cc
	addlt r1, r1, #0xb
	movge r1, #0x1cc
	strh r1, [r0, #0x78]
	add r0, r4, #0x500
	ldrsh r1, [r0, #0x78]
	mov r0, r4
	bl ovl02_2161150
	mov r0, r4
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _02162070 // =ovl02_2162074
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162070: .word ovl02_2162074
	arm_func_end ovl02_2162028

	arm_func_start ovl02_2162074
ovl02_2162074: // 0x02162074
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2161008
	mov r0, r4
	bl ovl02_2161188
	mov r0, r4
	mov r1, #0x11
	mov r2, #1
	bl ovl02_215EF6C
	ldr r0, _021620A4 // =ovl02_21620A8
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021620A4: .word ovl02_21620A8
	arm_func_end ovl02_2162074

	arm_func_start ovl02_21620A8
ovl02_21620A8: // 0x021620A8
	add r1, r0, #0x300
	ldrh r1, [r1, #0x74]
	tst r1, #2
	ldreq r1, _021620C0 // =ovl02_21620C4
	streq r1, [r0, #0x3cc]
	bx lr
	.align 2, 0
_021620C0: .word ovl02_21620C4
	arm_func_end ovl02_21620A8

	arm_func_start ovl02_21620C4
ovl02_21620C4: // 0x021620C4
	stmdb sp!, {r4, lr}
	mov r1, #0x12
	mov r2, #0
	mov r4, r0
	bl ovl02_215EF6C
	ldr r0, _021620E4 // =ovl02_21620E8
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021620E4: .word ovl02_21620E8
	arm_func_end ovl02_21620C4

	arm_func_start ovl02_21620E8
ovl02_21620E8: // 0x021620E8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x3d4]
	mov r0, r4
	bic r1, r1, #8
	str r1, [r4, #0x3d4]
	bl ovl02_21611C4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_21620E8

	arm_func_start ovl02_2162114
ovl02_2162114: // 0x02162114
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0x98]
	ldr r1, [r4, #0x3d4]
	orr r1, r1, #8
	str r1, [r4, #0x3d4]
	bl ovl02_2161008
	mov r0, r4
	mov r1, #0x13
	mov r2, #0
	bl ovl02_215EF6C
	mov r0, r4
	bl ovl02_215F38C
	ldr r0, _02162158 // =ovl02_216215C
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162158: .word ovl02_216215C
	arm_func_end ovl02_2162114

	arm_func_start ovl02_216215C
ovl02_216215C: // 0x0216215C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _02162178 // =ovl02_216217C
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162178: .word ovl02_216217C
	arm_func_end ovl02_216215C

	arm_func_start ovl02_216217C
ovl02_216217C: // 0x0216217C
	stmdb sp!, {r4, lr}
	mov r1, #0x14
	mov r2, #0
	mov r4, r0
	bl ovl02_215EF6C
	ldr r0, _0216219C // =ovl02_21621A0
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216219C: .word ovl02_21621A0
	arm_func_end ovl02_216217C

	arm_func_start ovl02_21621A0
ovl02_21621A0: // 0x021621A0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0xb30]
	ldr r0, [r0]
	cmp r0, #0x10000
	bne _021621EC
	mov r1, #0
	mov r0, #0xe5
	str r1, [sp]
	sub r1, r0, #0xe6
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, r4
	mov r1, #0
	bl ovl02_2163D6C
_021621EC:
	mov r0, r4
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _02162208 // =ovl02_216220C
	strne r0, [r4, #0x3cc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162208: .word ovl02_216220C
	arm_func_end ovl02_21621A0

	arm_func_start ovl02_216220C
ovl02_216220C: // 0x0216220C
	stmdb sp!, {r4, lr}
	mov r1, #0x15
	mov r2, #1
	mov r4, r0
	bl ovl02_215EF6C
	ldr r0, _0216222C // =ovl02_2162230
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216222C: .word ovl02_2162230
	arm_func_end ovl02_216220C

	arm_func_start ovl02_2162230
ovl02_2162230: // 0x02162230
	add r1, r0, #0x300
	ldrh r1, [r1, #0x74]
	tst r1, #0x400
	ldreq r1, _02162248 // =ovl02_216224C
	streq r1, [r0, #0x3cc]
	bx lr
	.align 2, 0
_02162248: .word ovl02_216224C
	arm_func_end ovl02_2162230

	arm_func_start ovl02_216224C
ovl02_216224C: // 0x0216224C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2163E4C
	mov r0, r4
	mov r1, #0x16
	mov r2, #0
	bl ovl02_215EF6C
	ldr r0, _02162274 // =ovl02_2162278
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162274: .word ovl02_2162278
	arm_func_end ovl02_216224C

	arm_func_start ovl02_2162278
ovl02_2162278: // 0x02162278
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x3d4]
	mov r0, r4
	bic r1, r1, #8
	str r1, [r4, #0x3d4]
	bl ovl02_21611C4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2162278

	arm_func_start ovl02_21622A4
ovl02_21622A4: // 0x021622A4
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0x98]
	ldr r1, [r4, #0x3d4]
	orr r1, r1, #8
	str r1, [r4, #0x3d4]
	bl ovl02_2161008
	mov r0, r4
	mov r1, #0x13
	mov r2, #0
	bl ovl02_215EF6C
	mov r0, r4
	bl ovl02_215F38C
	ldr r0, _021622E8 // =ovl02_21622EC
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021622E8: .word ovl02_21622EC
	arm_func_end ovl02_21622A4

	arm_func_start ovl02_21622EC
ovl02_21622EC: // 0x021622EC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _02162308 // =ovl02_216230C
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162308: .word ovl02_216230C
	arm_func_end ovl02_21622EC

	arm_func_start ovl02_216230C
ovl02_216230C: // 0x0216230C
	stmdb sp!, {r4, lr}
	mov r1, #0x14
	mov r2, #0
	mov r4, r0
	bl ovl02_215EF6C
	ldr r0, _0216232C // =ovl02_2162330
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216232C: .word ovl02_2162330
	arm_func_end ovl02_216230C

	arm_func_start ovl02_2162330
ovl02_2162330: // 0x02162330
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0xb30]
	ldr r0, [r0]
	cmp r0, #0x10000
	bne _0216237C
	mov r1, #0
	mov r0, #0xe5
	str r1, [sp]
	sub r1, r0, #0xe6
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, r4
	mov r1, #1
	bl ovl02_2163D6C
_0216237C:
	mov r0, r4
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _02162398 // =ovl02_216239C
	strne r0, [r4, #0x3cc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162398: .word ovl02_216239C
	arm_func_end ovl02_2162330

	arm_func_start ovl02_216239C
ovl02_216239C: // 0x0216239C
	stmdb sp!, {r4, lr}
	mov r1, #0x15
	mov r2, #1
	mov r4, r0
	bl ovl02_215EF6C
	ldr r0, _021623BC // =ovl02_21623C0
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021623BC: .word ovl02_21623C0
	arm_func_end ovl02_216239C

	arm_func_start ovl02_21623C0
ovl02_21623C0: // 0x021623C0
	add r1, r0, #0x300
	ldrh r1, [r1, #0x74]
	tst r1, #0x400
	ldreq r1, _021623D8 // =ovl02_21623DC
	streq r1, [r0, #0x3cc]
	bx lr
	.align 2, 0
_021623D8: .word ovl02_21623DC
	arm_func_end ovl02_21623C0

	arm_func_start ovl02_21623DC
ovl02_21623DC: // 0x021623DC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2163E4C
	mov r0, r4
	mov r1, #0x16
	mov r2, #0
	bl ovl02_215EF6C
	ldr r0, _02162404 // =ovl02_2162408
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162404: .word ovl02_2162408
	arm_func_end ovl02_21623DC

	arm_func_start ovl02_2162408
ovl02_2162408: // 0x02162408
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x3d4]
	mov r0, r4
	bic r1, r1, #8
	str r1, [r4, #0x3d4]
	bl ovl02_21611C4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2162408

	arm_func_start ovl02_2162434
ovl02_2162434: // 0x02162434
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0x98]
	ldr r1, [r4, #0x3d4]
	orr r1, r1, #8
	str r1, [r4, #0x3d4]
	bl ovl02_2161008
	mov r0, r4
	mov r1, #0x17
	mov r2, #0
	bl ovl02_215EF6C
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x378]
	cmp r0, #0
	beq _02162478
	bl ovl02_216389C
_02162478:
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x37c]
	cmp r0, #0
	beq _0216248C
	bl ovl02_216389C
_0216248C:
	mov r0, r4
	bl ovl02_215F38C
	ldr r0, _021624A0 // =ovl02_21624A4
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021624A0: .word ovl02_21624A4
	arm_func_end ovl02_2162434

	arm_func_start ovl02_21624A4
ovl02_21624A4: // 0x021624A4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _021624C0 // =ovl02_21624C4
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021624C0: .word ovl02_21624C4
	arm_func_end ovl02_21624A4

	arm_func_start ovl02_21624C4
ovl02_21624C4: // 0x021624C4
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	add r0, r4, #0xa40
	add r3, sp, #8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r4
	mov r1, #1
	mov r2, #0xa000
	bl ovl02_216370C
	ldr r1, [sp, #8]
	ldr r2, [sp, #0xc]
	ldr r3, [sp, #0x10]
	mov r0, #0
	bl BossFX__CreateRivalShot
	add r1, r0, #0x18c
	add r0, r4, #0xa70
	bl sub_20665F8
	mov r0, #0
	str r0, [sp]
	mov r0, #0xe6
	sub r1, r0, #0xe7
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, r4
	mov r1, #0x18
	mov r2, #0
	bl ovl02_215EF6C
	ldr r0, _02162554 // =ovl02_2162558
	str r0, [r4, #0x3cc]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02162554: .word ovl02_2162558
	arm_func_end ovl02_21624C4

	arm_func_start ovl02_2162558
ovl02_2162558: // 0x02162558
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _02162574 // =ovl02_2162578
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162574: .word ovl02_2162578
	arm_func_end ovl02_2162558

	arm_func_start ovl02_2162578
ovl02_2162578: // 0x02162578
	stmdb sp!, {r4, lr}
	mov r1, #0x19
	mov r2, #1
	mov r4, r0
	bl ovl02_215EF6C
	ldr r0, _02162598 // =ovl02_216259C
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162598: .word ovl02_216259C
	arm_func_end ovl02_2162578

	arm_func_start ovl02_216259C
ovl02_216259C: // 0x0216259C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #1
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x37c]
	bl ovl02_2163840
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x37c]
	bl ovl02_216389C
	ldr r0, _021625E0 // =ovl02_21625E4
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021625E0: .word ovl02_21625E4
	arm_func_end ovl02_216259C

	arm_func_start ovl02_21625E4
ovl02_21625E4: // 0x021625E4
	stmdb sp!, {r4, lr}
	mov r1, #0x1a
	mov r2, #0
	mov r4, r0
	bl ovl02_215EF6C
	ldr r0, _02162604 // =ovl02_2162608
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162604: .word ovl02_2162608
	arm_func_end ovl02_21625E4

	arm_func_start ovl02_2162608
ovl02_2162608: // 0x02162608
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x3d4]
	mov r0, r4
	bic r1, r1, #8
	str r1, [r4, #0x3d4]
	bl ovl02_21611C4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2162608

	arm_func_start ovl02_2162634
ovl02_2162634: // 0x02162634
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0x98]
	ldr r1, [r4, #0x3d4]
	orr r1, r1, #8
	str r1, [r4, #0x3d4]
	bl ovl02_2161008
	mov r0, r4
	mov r1, #0x1b
	mov r2, #0
	bl ovl02_215EF6C
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x378]
	cmp r0, #0
	beq _02162678
	bl ovl02_216389C
_02162678:
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x37c]
	cmp r0, #0
	beq _0216268C
	bl ovl02_216389C
_0216268C:
	mov r0, r4
	bl ovl02_215F38C
	ldr r0, _021626A0 // =ovl02_21626A4
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021626A0: .word ovl02_21626A4
	arm_func_end ovl02_2162634

	arm_func_start ovl02_21626A4
ovl02_21626A4: // 0x021626A4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _021626C0 // =ovl02_21626C4
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021626C0: .word ovl02_21626C4
	arm_func_end ovl02_21626A4

	arm_func_start ovl02_21626C4
ovl02_21626C4: // 0x021626C4
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	add r0, r4, #0xa40
	add r3, sp, #8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r4
	mov r1, #0
	mov r2, #0xa000
	bl ovl02_216370C
	mov r0, r4
	mov r1, #1
	mov r2, #0x8000
	bl ovl02_216370C
	ldr r1, [sp, #8]
	ldr r2, [sp, #0xc]
	ldr r3, [sp, #0x10]
	mov r0, #0
	bl BossFX__CreateRivalShot
	add r1, r0, #0x18c
	add r0, r4, #0xa70
	bl sub_20665F8
	mov r0, #0
	str r0, [sp]
	mov r0, #0xe6
	sub r1, r0, #0xe7
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, r4
	mov r1, #0x1c
	mov r2, #0
	bl ovl02_215EF6C
	ldr r0, _02162764 // =ovl02_2162768
	str r0, [r4, #0x3cc]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02162764: .word ovl02_2162768
	arm_func_end ovl02_21626C4

	arm_func_start ovl02_2162768
ovl02_2162768: // 0x02162768
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _02162784 // =ovl02_2162788
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162784: .word ovl02_2162788
	arm_func_end ovl02_2162768

	arm_func_start ovl02_2162788
ovl02_2162788: // 0x02162788
	stmdb sp!, {r4, lr}
	mov r1, #0x1d
	mov r2, #1
	mov r4, r0
	bl ovl02_215EF6C
	ldr r0, _021627A8 // =ovl02_21627AC
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021627A8: .word ovl02_21627AC
	arm_func_end ovl02_2162788

	arm_func_start ovl02_21627AC
ovl02_21627AC: // 0x021627AC
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #1
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x378]
	bl ovl02_2163840
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x37c]
	bl ovl02_2163840
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x378]
	bl ovl02_216389C
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x37c]
	bl ovl02_216389C
	ldr r0, _02162810 // =ovl02_2162814
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162810: .word ovl02_2162814
	arm_func_end ovl02_21627AC

	arm_func_start ovl02_2162814
ovl02_2162814: // 0x02162814
	stmdb sp!, {r4, lr}
	mov r1, #0x1e
	mov r2, #0
	mov r4, r0
	bl ovl02_215EF6C
	ldr r0, _02162834 // =ovl02_2162838
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162834: .word ovl02_2162838
	arm_func_end ovl02_2162814

	arm_func_start ovl02_2162838
ovl02_2162838: // 0x02162838
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x3d4]
	mov r0, r4
	bic r1, r1, #8
	str r1, [r4, #0x3d4]
	bl ovl02_21611C4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2162838

	arm_func_start ovl02_2162864
ovl02_2162864: // 0x02162864
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0
	str r0, [r4, #0x98]
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x374]
	cmp r0, #0
	bne _0216289C
	ldr r1, [r4, #0x3d4]
	ldr r0, _021628D8 // =ovl02_2162B28
	orr r1, r1, #0x30
	str r1, [r4, #0x3d4]
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
_0216289C:
	bl ovl02_21650E4
	ldr r1, [r4, #0x3d4]
	mov r0, r4
	orr r1, r1, #8
	str r1, [r4, #0x3d4]
	bl ovl02_21610C8
	mov r0, r4
	mov r1, #0x25
	mov r2, #1
	bl ovl02_215EF6C
	mov r1, #0x168
	ldr r0, _021628DC // =ovl02_21628E0
	str r1, [r4, #0x3f4]
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021628D8: .word ovl02_2162B28
_021628DC: .word ovl02_21628E0
	arm_func_end ovl02_2162864

	arm_func_start ovl02_21628E0
ovl02_21628E0: // 0x021628E0
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r1, _02162A1C // =_02178DB0
	mov r5, r0
	ldr r4, [r5, #0x370]
	ldrh r0, [r1, #0x1a]
	ldrh r3, [r1, #0x16]
	ldrh r2, [r1, #0x18]
	ldr r4, [r4, #0x374]
	strh r0, [sp, #4]
	cmp r4, #0
	ldreq r0, _02162A20 // =ovl02_2162B28
	strh r3, [sp]
	strh r2, [sp, #2]
	addeq sp, sp, #8
	streq r0, [r5, #0x3cc]
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x3f4]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r5, #0x3f4]
	bne _02162948
	cmp r4, #0
	ldrne r0, [r4, #0x3d4]
	orrne r0, r0, #0xa0
	strne r0, [r4, #0x3d4]
_02162948:
	mov r0, r5
	bl ovl02_215E538
	cmp r0, #0
	beq _0216298C
	mov r0, r5
	bl ovl02_215EFDC
	cmp r0, #0
	beq _0216298C
	add r0, r5, #0x300
	ldrh r2, [r0, #0x58]
	add r1, sp, #0
	mov r0, r5
	sub r2, r2, #0x28
	mov r2, r2, lsl #1
	ldrsh r1, [r1, r2]
	mov r2, #1
	bl ovl02_215EF6C
_0216298C:
	mov r0, r5
	mov r1, r4
	bl ovl02_2161108
	cmp r0, #0
	beq _021629E4
	mov r0, r4
	bl ovl02_215E794
	cmp r0, #0
	beq _021629E4
	ldr r1, [r4, #0x3d4]
	add r0, r5, #0x44
	bic r1, r1, #0x80
	str r1, [r4, #0x3d4]
	add r3, r4, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r4
	bl ovl02_21660DC
	ldr r0, _02162A24 // =ovl02_2162A28
	add sp, sp, #8
	str r0, [r5, #0x3cc]
	ldmia sp!, {r3, r4, r5, pc}
_021629E4:
	ldr r0, [r4, #0x3d4]
	tst r0, #0x80
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	bic r0, r0, #0x80
	bic r0, r0, #0x40
	str r0, [r4, #0x3d4]
	ldr r1, [r5, #0x3d4]
	ldr r0, _02162A20 // =ovl02_2162B28
	orr r1, r1, #0x30
	str r1, [r5, #0x3d4]
	str r0, [r5, #0x3cc]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02162A1C: .word _02178DB0
_02162A20: .word ovl02_2162B28
_02162A24: .word ovl02_2162A28
	arm_func_end ovl02_21628E0

	arm_func_start ovl02_2162A28
ovl02_2162A28: // 0x02162A28
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0x26
	mov r2, #0
	bl ovl02_215EF6C
	mov r0, r4
	bl ovl02_215F38C
	ldr r0, _02162A50 // =ovl02_2162A54
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162A50: .word ovl02_2162A54
	arm_func_end ovl02_2162A28

	arm_func_start ovl02_2162A54
ovl02_2162A54: // 0x02162A54
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _02162A70 // =ovl02_2162A74
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162A70: .word ovl02_2162A74
	arm_func_end ovl02_2162A54

	arm_func_start ovl02_2162A74
ovl02_2162A74: // 0x02162A74
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	mov r2, #0xeb
	str r1, [sp]
	sub r1, r2, #0xec
	mov r4, r0
	str r2, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, r4
	mov r1, #0x27
	mov r2, #0
	bl ovl02_215EF6C
	ldr r0, _02162AC4 // =ovl02_2162AC8
	str r0, [r4, #0x3cc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162AC4: .word ovl02_2162AC8
	arm_func_end ovl02_2162A74

	arm_func_start ovl02_2162AC8
ovl02_2162AC8: // 0x02162AC8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0xb30]
	ldr r0, [r0]
	cmp r0, #0x28000
	bne _02162B08
	mov r1, #0
	mov r0, #0xe2
	str r1, [sp]
	sub r1, r0, #0xe3
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02162B08:
	mov r0, r4
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _02162B24 // =ovl02_2162B28
	strne r0, [r4, #0x3cc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162B24: .word ovl02_2162B28
	arm_func_end ovl02_2162AC8

	arm_func_start ovl02_2162B28
ovl02_2162B28: // 0x02162B28
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x3d4]
	bic r1, r1, #8
	bic r1, r1, #0x10
	str r1, [r4, #0x3d4]
	bl ovl02_2161008
	mov r0, r4
	bl ovl02_21611C4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2162B28

	arm_func_start ovl02_2162B50
ovl02_2162B50: // 0x02162B50
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x500
	mov r2, #0
	strh r2, [r1, #0x7a]
	bl ovl02_2161008
	mov r0, r4
	bl ovl02_2161188
	ldr r0, [r4, #0x20]
	add r2, r4, #0x300
	tst r0, #1
	mov r0, #0x3000
	rsbne r0, r0, #0
	strne r0, [r4, #0x98]
	streq r0, [r4, #0x98]
	subeq r0, r0, #0x6000
	str r0, [r4, #0x9c]
	ldr r0, [r4, #0x1c]
	mov r3, #0x78
	orr r0, r0, #0x10
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x18]
	orr r0, r0, #1
	str r0, [r4, #0x18]
	ldr r1, [r4, #0x1c]
	mov r0, r4
	bic r1, r1, #0x1000
	str r1, [r4, #0x1c]
	ldr ip, [r4, #0x3d4]
	mov r1, #0x22
	bic ip, ip, #8
	str ip, [r4, #0x3d4]
	strh r3, [r2, #0x50]
	ldr r3, [r4, #0x3d4]
	mov r2, #0
	orr r3, r3, #0x30
	str r3, [r4, #0x3d4]
	bl ovl02_215EF6C
	ldr r0, _02162BF4 // =ovl02_2162BF8
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162BF4: .word ovl02_2162BF8
	arm_func_end ovl02_2162B50

	arm_func_start ovl02_2162BF8
ovl02_2162BF8: // 0x02162BF8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldrne r0, _02162C14 // =ovl02_2162C18
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162C14: .word ovl02_2162C18
	arm_func_end ovl02_2162BF8

	arm_func_start ovl02_2162C18
ovl02_2162C18: // 0x02162C18
	stmdb sp!, {r4, lr}
	mov r1, #0x23
	mov r2, #1
	mov r4, r0
	bl ovl02_215EF6C
	ldr r0, _02162C38 // =ovl02_2162C3C
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162C38: .word ovl02_2162C3C
	arm_func_end ovl02_2162C18

	arm_func_start ovl02_2162C3C
ovl02_2162C3C: // 0x02162C3C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x9c]
	cmp r1, #0
	ldmltia sp!, {r4, pc}
	mov r1, #0x24
	mov r2, #0
	bl ovl02_215EF6C
	ldr r0, _02162C68 // =ovl02_2162C6C
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162C68: .word ovl02_2162C6C
	arm_func_end ovl02_2162C3C

	arm_func_start ovl02_2162C6C
ovl02_2162C6C: // 0x02162C6C
	ldr r1, [r0, #0x1c]
	tst r1, #1
	bxeq lr
	mov r2, #0
	ldr r1, _02162C8C // =ovl02_2162C90
	str r2, [r0, #0x98]
	str r1, [r0, #0x3cc]
	bx lr
	.align 2, 0
_02162C8C: .word ovl02_2162C90
	arm_func_end ovl02_2162C6C

	arm_func_start ovl02_2162C90
ovl02_2162C90: // 0x02162C90
	ldr r1, _02162C9C // =ovl02_2162CA0
	str r1, [r0, #0x3cc]
	bx lr
	.align 2, 0
_02162C9C: .word ovl02_2162CA0
	arm_func_end ovl02_2162C90

	arm_func_start ovl02_2162CA0
ovl02_2162CA0: // 0x02162CA0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EFDC
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x3d4]
	mov r0, r4
	bic r1, r1, #0x10
	str r1, [r4, #0x3d4]
	bl ovl02_21611C4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2162CA0

	arm_func_start ovl02_2162CCC
ovl02_2162CCC: // 0x02162CCC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, _02162DE4 // =0x0000040A
	add r0, r4, #0x580
	mov r1, #0
	bl MI_CpuFill8
	ldr r0, [r4, #0x410]
	bic r0, r0, #4
	str r0, [r4, #0x410]
	ldr r0, [r4, #0x450]
	bic r0, r0, #4
	str r0, [r4, #0x450]
	ldr r0, [r4, #0x490]
	bic r0, r0, #4
	str r0, [r4, #0x490]
	ldr r0, [r4, #0x4d0]
	bic r0, r0, #4
	str r0, [r4, #0x4d0]
	ldr r0, [r4, #0x510]
	bic r0, r0, #4
	str r0, [r4, #0x510]
	ldr r0, [r4, #0x550]
	bic r0, r0, #4
	str r0, [r4, #0x550]
	ldr r0, [r4, #0x48]
	cmp r0, #0x1c0000
	movle r1, #1
	ldr r0, [r4, #0x370]
	movgt r1, #0
	str r1, [r0, #0x3fc]
	ldr r0, [r4, #0x370]
	bl ovl02_215FCEC
	ldr r0, _02162DE8 // =VRAMSystem__VRAM_PALETTE_BG
	add r1, r4, #0x580
	ldr r0, [r0]
	mov r2, #0x200
	bl MIi_CpuCopyFast
	ldr r0, [r4, #0x370]
	ldr r2, [r0, #0x380]
	cmp r2, #0
	beq _02162D84
	ldr r1, [r2, #0x18]
	mov r0, r4
	orr r1, r1, #0x20
	str r1, [r2, #0x18]
	bl ovl02_2163E4C
_02162D84:
	mov r3, #0
	mov r1, r3
_02162D8C:
	ldr r0, [r4, #0x370]
	add r0, r0, r3, lsl #2
	ldr r2, [r0, #0x378]
	cmp r2, #0
	beq _02162DB8
	ldr r0, [r2, #0x18]
	orr r0, r0, #8
	str r0, [r2, #0x18]
	ldr r0, [r4, #0x370]
	add r0, r0, r3, lsl #2
	str r1, [r0, #0x378]
_02162DB8:
	add r3, r3, #1
	cmp r3, #2
	blt _02162D8C
	mov r0, r4
	bl ovl02_215DEE0
	add r0, r4, #0x980
	mov r2, #0
	ldr r1, _02162DEC // =ovl02_2162DF0
	strh r2, [r0, #8]
	str r1, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162DE4: .word 0x0000040A
_02162DE8: .word VRAMSystem__VRAM_PALETTE_BG
_02162DEC: .word ovl02_2162DF0
	arm_func_end ovl02_2162CCC

	arm_func_start ovl02_2162DF0
ovl02_2162DF0: // 0x02162DF0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r4, [r7, #0x370]
	bl Camera3D__GetWork
	add r2, r4, #0x300
	mov r5, #0
	ldr r3, [r4, #0x3fc]
	mov r1, #0x5c
	mla r0, r3, r1, r0
	ldrsh r3, [r2, #0xd8]
	sub r1, r5, #0x10
	mov r6, r5
	cmp r3, r1
	beq _02162E58
	add r1, r7, #0x980
	ldrh r3, [r1, #2]
	add r3, r3, #1
	strh r3, [r1, #2]
	ldrh r3, [r1, #2]
	cmp r3, #1
	bls _02162E5C
	strh r5, [r1, #2]
	ldrsh r1, [r2, #0xd8]
	sub r1, r1, #1
	strh r1, [r2, #0xd8]
	b _02162E5C
_02162E58:
	mov r5, #1
_02162E5C:
	ldrh r1, [r0, #0x24]
	cmp r1, #0x10
	bhs _02162E9C
	add r1, r7, #0x980
	ldrh r2, [r1]
	add r2, r2, #1
	strh r2, [r1]
	ldrh r2, [r1]
	cmp r2, #2
	bls _02162EA0
	mov r2, #0
	strh r2, [r1]
	ldrh r1, [r0, #0x24]
	add r1, r1, #1
	strh r1, [r0, #0x24]
	b _02162EA0
_02162E9C:
	mov r6, #1
_02162EA0:
	mov r0, r4
	add r1, r7, #0x580
	bl ovl02_216002C
	add r0, r7, #0x980
	ldrh r2, [r0, #8]
	add r1, r2, #1
	strh r1, [r0, #8]
	cmp r2, #0x78
	ldmlsia sp!, {r3, r4, r5, r6, r7, pc}
	cmp r5, #0
	cmpne r6, #0
	ldrne r0, _02162ED8 // =ovl02_2162EDC
	strne r0, [r7, #0x3cc]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02162ED8: .word ovl02_2162EDC
	arm_func_end ovl02_2162DF0

	arm_func_start ovl02_2162EDC
ovl02_2162EDC: // 0x02162EDC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	add r0, r4, #0x9b0
	add r3, sp, #8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r3
	bl ovl02_215F710
	mov ip, #0x8c
	sub r1, ip, #0x8d
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	ldr r0, _02162FE4 // =gPlayer
	ldr r1, [r4, #0x44]
	ldr r0, [r0]
	ldr r0, [r0, #0x44]
	cmp r0, r1
	mov r0, #0x8000
	strlt r0, [r4, #0x98]
	sublt r0, r0, #0x10000
	rsbge r0, r0, #0
	strge r0, [r4, #0x98]
	str r0, [r4, #0x9c]
	mov r0, #0
	str r0, [r4, #0xa0]
	ldr r1, [r4, #0x1c]
	ldr r0, _02162FE8 // =0xFFF7DFFE
	orr r1, r1, #0x90
	orr r1, r1, #0x9000
	and r1, r1, r0
	mov r0, r4
	str r1, [r4, #0x1c]
	bl ovl02_215F1F8
	ldr r0, [r4, #0x370]
	bl ovl02_215FEC4
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x374]
	cmp r0, #0
	bne _02162FA0
	ldr r0, _02162FE4 // =gPlayer
	ldr r0, [r0]
	bl BossHelpers__Player__LockControl
	ldr r0, [r4, #0x370]
	bl ovl02_216034C
	b _02162FB0
_02162FA0:
	ldr r0, _02162FEC // =playerGameStatus
	ldr r1, [r0]
	orr r1, r1, #1
	str r1, [r0]
_02162FB0:
	ldr r1, _02162FE4 // =gPlayer
	mov r0, r4
	ldr r1, [r1]
	bl ovl02_215E16C
	ldr r1, _02162FF0 // =ovl02_2162FF4
	add r0, r4, #0x980
	mov r2, #0
	strh r2, [r0, #8]
	mov r0, r4
	str r1, [r4, #0x3cc]
	blx r1
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02162FE4: .word gPlayer
_02162FE8: .word 0xFFF7DFFE
_02162FEC: .word playerGameStatus
_02162FF0: .word ovl02_2162FF4
	arm_func_end ovl02_2162EDC

	arm_func_start ovl02_2162FF4
ovl02_2162FF4: // 0x02162FF4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r4, [r7, #0x370]
	bl Camera3D__GetWork
	add r1, r4, #0x300
	ldrsh r2, [r1, #0xd8]
	mov r5, #0
	mov r6, r5
	cmp r2, #0
	addne r2, r2, #1
	strneh r2, [r1, #0xd8]
	ldr r1, [r4, #0x374]
	moveq r5, #1
	cmp r1, #0
	moveq r2, #0x10
	ldrsh r1, [r0, #0x58]
	movne r2, #0
	cmp r1, r2
	bge _0216308C
	add r1, r7, #0x980
	ldrh r2, [r1, #8]
	cmp r2, #0x3c
	bls _02163090
	ldrh r2, [r1, #6]
	add r2, r2, #1
	strh r2, [r1, #6]
	ldrh r2, [r1, #6]
	cmp r2, #3
	bls _02163090
	ldrsh r3, [r0, #0x58]
	mov r2, #0
	add r3, r3, #1
	strh r3, [r0, #0x58]
	ldrsh r3, [r0, #0xb4]
	add r3, r3, #1
	strh r3, [r0, #0xb4]
	strh r2, [r1, #6]
	b _02163090
_0216308C:
	mov r6, #1
_02163090:
	mov r0, r4
	add r1, r7, #0x580
	bl ovl02_216002C
	add r0, r7, #0x980
	ldrh r1, [r0, #8]
	cmp r5, #0
	cmpne r6, #0
	add r1, r1, #1
	strh r1, [r0, #8]
	ldrne r0, _021630C0 // =ovl02_21630C4
	strne r0, [r7, #0x3cc]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021630C0: .word ovl02_21630C4
	arm_func_end ovl02_2162FF4

	arm_func_start ovl02_21630C4
ovl02_21630C4: // 0x021630C4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x370]
	ldr r0, [r1, #0x374]
	cmp r0, #0
	bne _021630F4
	bl StopStageBGM
	ldr r0, _0216322C // =playerGameStatus
	ldr r1, [r0]
	orr r1, r1, #4
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021630F4:
	mov r0, #0
	str r0, [r1, #0x370]
	ldr r1, [r4, #0x18]
	mov r0, #1
	orr r1, r1, #4
	str r1, [r4, #0x18]
	bl SetActiveBossHealthbar
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x374]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0xd2]
	sub r0, r0, #1
	bl UpdateBossHealthHUD
	ldr r0, [r4, #0x370]
	bl ovl02_215E0BC
	bl Camera3D__GetWork
	mov r4, r0
	bl Camera3D__GetWork
	mov r1, #0
	strh r1, [r4, #0x20]
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	bic r1, r1, #1
	orr r1, r1, #1
	strh r1, [r4, #0x20]
	ldrh r1, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	mov r1, r1, lsl #0x1f
	mov r1, r1, lsr #0x1f
	bic r2, r2, #1
	and r1, r1, #1
	orr r1, r2, r1
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	orr r1, r1, #0x200
	strh r1, [r4, #0x20]
	ldrh r1, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	mov r1, r1, lsl #0x16
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x200
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #22
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	orr r1, r1, #0x400
	strh r1, [r4, #0x20]
	ldrh r1, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	mov r1, r1, lsl #0x15
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x400
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #21
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	orr r1, r1, #0x800
	strh r1, [r4, #0x20]
	ldrh r1, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	mov r1, r1, lsl #0x14
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x800
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #20
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	orr r1, r1, #0x1000
	strh r1, [r4, #0x20]
	ldrh r1, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	mov r1, r1, lsl #0x13
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x1000
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #19
	strh r1, [r0, #0x7c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216322C: .word playerGameStatus
	arm_func_end ovl02_21630C4

	arm_func_start ovl02_2163230
ovl02_2163230: // 0x02163230
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x300
	ldrh r1, [r0, #0x74]
	tst r1, #0x30
	beq _021632D8
	tst r1, #0x10
	ldrh r0, [r0, #0x58]
	beq _02163294
	cmp r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	ldr r0, [r4, #0x98]
	cmp r0, #0
	bge _0216327C
	mov r1, #0x100
	bl ObjSpdDownSet
	str r0, [r4, #0x98]
_0216327C:
	ldr r0, [r4, #0x98]
	mov r1, #0x400
	mov r2, #0x2000
	bl ObjSpdUpSet
	str r0, [r4, #0x98]
	ldmia sp!, {r4, pc}
_02163294:
	cmp r0, #1
	ldrne r0, [r4, #0x20]
	bicne r0, r0, #1
	strne r0, [r4, #0x20]
	ldr r0, [r4, #0x98]
	cmp r0, #0
	ble _021632BC
	mov r1, #0x100
	bl ObjSpdDownSet
	str r0, [r4, #0x98]
_021632BC:
	mov r1, #0x400
	ldr r0, [r4, #0x98]
	rsb r1, r1, #0
	mov r2, #0x2000
	bl ObjSpdUpSet
	str r0, [r4, #0x98]
	ldmia sp!, {r4, pc}
_021632D8:
	ldrh r0, [r4, #0x34]
	add r0, r0, #0x2000
	and r0, r0, #0xff00
	cmp r0, #0x4000
	ldmgtia sp!, {r4, pc}
	ldr r0, [r4, #0x98]
	mov r1, #0x100
	bl ObjSpdDownSet
	str r0, [r4, #0x98]
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2163230

	arm_func_start ovl02_2163300
ovl02_2163300: // 0x02163300
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #0x30
	beq _02163398
	tst r0, #0x10
	ldr r0, [r4, #0x20]
	beq _0216335C
	orr r0, r0, #1
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x98]
	cmp r0, #0
	bge _02163344
	mov r1, #0x100
	bl ObjSpdDownSet
	str r0, [r4, #0x98]
_02163344:
	ldr r0, [r4, #0x98]
	mov r1, #0x400
	mov r2, #0x3000
	bl ObjSpdUpSet
	str r0, [r4, #0x98]
	ldmia sp!, {r4, pc}
_0216335C:
	bic r0, r0, #1
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x98]
	cmp r0, #0
	ble _0216337C
	mov r1, #0x100
	bl ObjSpdDownSet
	str r0, [r4, #0x98]
_0216337C:
	mov r1, #0x400
	ldr r0, [r4, #0x98]
	rsb r1, r1, #0
	mov r2, #0x3000
	bl ObjSpdUpSet
	str r0, [r4, #0x98]
	ldmia sp!, {r4, pc}
_02163398:
	mov r1, #0x3000
	ldr r0, [r4, #0x98]
	rsb r1, r1, #0
	cmp r0, r1
	movlt r0, r1
	blt _021633B8
	cmp r0, #0x3000
	movgt r0, #0x3000
_021633B8:
	mov r1, #0x100
	str r0, [r4, #0x98]
	bl ObjSpdDownSet
	str r0, [r4, #0x98]
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2163300

	arm_func_start ovl02_21633CC
ovl02_21633CC: // 0x021633CC
	ldr r1, [r0, #0x98]
	cmp r1, #0
	bxeq lr
	cmp r1, #0
	ldr r1, [r0, #0x20]
	orrgt r1, r1, #1
	strgt r1, [r0, #0x20]
	bicle r1, r1, #1
	strle r1, [r0, #0x20]
	bx lr
	arm_func_end ovl02_21633CC

	arm_func_start ovl02_21633F4
ovl02_21633F4: // 0x021633F4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x378]
	cmp r1, #0
	beq _0216340C
	blx r1
_0216340C:
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_21633F4

	arm_func_start ovl02_216341C
ovl02_216341C: // 0x0216341C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x138]
	mov r1, #0x1e
	bl NNS_SndPlayerStopSeq
	add r0, r4, #0x3b4
	bl AnimatorMDL__Release
	add r0, r4, #0xf8
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_216341C

	arm_func_start ovl02_2163458
ovl02_2163458: // 0x02163458
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x48
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	addne sp, sp, #0x48
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	add r0, r4, #0x44
	add r3, r4, #0x3fc
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x400]
	add r0, r4, #0x3d8
	rsb r1, r1, #0
	str r1, [r4, #0x400]
	bl MTX_Identity33_
	ldr r0, [r4, #0x374]
	cmp r0, #0
	beq _021634E0
	cmp r0, #1
	bne _02163508
	ldr r0, [r4, #0x20]
	tst r0, #1
	ldr r0, [r4, #0x38c]
	beq _021634D0
	rsb r0, r0, #0
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	b _02163508
_021634D0:
	rsb r0, r0, #0x8000
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	b _02163508
_021634E0:
	ldr r0, [r4, #0x20]
	tst r0, #1
	ldr r0, [r4, #0x38c]
	rsbeq r0, r0, #0
	moveq r0, r0, lsl #0x10
	moveq r5, r0, lsr #0x10
	beq _02163508
	rsb r0, r0, #0x8000
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
_02163508:
	ldr r0, [r4, #0x20]
	tst r0, #1
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	beq _0216355C
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _02163638 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r4, #0x3d8
	blx MTX_RotZ33_
	ldr r2, _0216363C // =0x02114950
	add r0, sp, #0x24
	ldrsh r1, [r2]
	ldrsh r2, [r2, #2]
	blx MTX_RotY33_
	b _02163598
_0216355C:
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _02163638 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r4, #0x3d8
	blx MTX_RotZ33_
	ldr r2, _02163638 // =FX_SinCosTable_
	add r0, sp, #0x24
	ldrsh r1, [r2]
	ldrsh r2, [r2, #2]
	blx MTX_RotY33_
_02163598:
	add r1, r4, #0x3d8
	add r0, sp, #0x24
	mov r2, r1
	bl MTX_Concat33
	add r0, r4, #0x3b4
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #0x3b4
	bl AnimatorMDL__Draw
	add r0, r4, #0xf8
	add r5, r0, #0x400
	add r7, r4, #0x3d8
	ldmia r7!, {r0, r1, r2, r3}
	add r6, r5, #0x24
	stmia r6!, {r0, r1, r2, r3}
	ldmia r7!, {r0, r1, r2, r3}
	stmia r6!, {r0, r1, r2, r3}
	ldr r0, [r7]
	add lr, r4, #0x3fc
	str r0, [r6]
	add ip, r5, #0x48
	ldmia lr, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r0, [r4, #0x374]
	cmp r0, #0
	bne _02163620
	ldr r2, _0216363C // =0x02114950
	add r0, sp, #0
	ldrsh r1, [r2]
	ldrsh r2, [r2, #2]
	blx MTX_RotZ33_
	add r1, r5, #0x24
	add r0, sp, #0
	mov r2, r1
	bl MTX_Concat33
_02163620:
	mov r0, r5
	bl AnimatorMDL__ProcessAnimation
	mov r0, r5
	bl AnimatorMDL__Draw
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02163638: .word FX_SinCosTable_
_0216363C: .word 0x02114950
	arm_func_end ovl02_2163458

	arm_func_start ovl02_2163640
ovl02_2163640: // 0x02163640
	stmdb sp!, {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x18]
	tst r0, #0xc
	ldmneia sp!, {r4, r5, r6, pc}
	tst r0, #2
	ldmneia sp!, {r4, r5, r6, pc}
	add r6, r4, #0x218
	mov r5, #0
_02163668:
	ldr r0, [r6, #0x18]
	tst r0, #4
	beq _02163688
	ldr r1, [r4, #0x44]
	ldr r2, [r4, #0x48]
	ldr r3, [r4, #0x4c]
	mov r0, r6
	bl BossHelpers__Collision__Func_20390AC
_02163688:
	add r5, r5, #1
	cmp r5, #3
	add r6, r6, #0x40
	blt _02163668
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl02_2163640

	arm_func_start ovl02_216369C
ovl02_216369C: // 0x0216369C
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr r1, [r1, #0x1c]
	ldr r2, [r0, #0x1c]
	ldrh r0, [r1]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, pc}
	ldr r0, _02163704 // =gPlayer
	ldr r0, [r0]
	add r0, r0, #0x600
	ldrsh r0, [r0, #0x82]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, pc}
	mov r1, #0
	ldr r0, _02163708 // =0x00000107
	str r1, [sp]
	sub r1, r0, #0x108
	str r0, [sp, #4]
	ldr r0, [r2, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_02163704: .word gPlayer
_02163708: .word 0x00000107
	arm_func_end ovl02_216369C

	arm_func_start ovl02_216370C
ovl02_216370C: // 0x0216370C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x20
	mov r7, r0
	ldr r8, [r7, #0x370]
	mov r6, r1
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	mov r5, r2
	ldr r0, _02163838 // =0x00000135
	mov r2, r1
	mov r3, r1
	str r1, [sp, #0xc]
	and r4, r6, #0xff
	str r4, [sp, #0x10]
	bl GameObject__SpawnObject
	add r1, r8, r6, lsl #2
	mov r4, r0
	str r0, [r1, #0x378]
	str r8, [r4, #0x370]
	cmp r6, #1
	bne _021637A0
	ldr r0, [r7, #0x20]
	ldr r1, [r4, #0x20]
	tst r0, #1
	beq _0216378C
	orr r1, r1, #1
	mov r0, #0
	str r1, [r4, #0x20]
	strh r0, [r4, #0x34]
	b _021637DC
_0216378C:
	bic r1, r1, #1
	mov r0, #0x8000
	str r1, [r4, #0x20]
	strh r0, [r4, #0x34]
	b _021637DC
_021637A0:
	cmp r6, #0
	bne _021637DC
	ldr r0, [r7, #0x20]
	ldr r1, [r4, #0x20]
	tst r0, #1
	beq _021637CC
	bic r1, r1, #1
	mov r0, #0
	str r1, [r4, #0x20]
	strh r0, [r4, #0x34]
	b _021637DC
_021637CC:
	orr r1, r1, #1
	mov r0, #0x8000
	str r1, [r4, #0x20]
	strh r0, [r4, #0x34]
_021637DC:
	add r0, r7, #0x1ec
	add r1, r0, #0x800
	mov r0, #0x30
	mla r0, r6, r0, r1
	add r1, sp, #0x14
	add r2, r4, #0x390
	add r3, r4, #0x44
	bl sub_2066724
	ldr r1, [r4, #0x48]
	ldr r0, _0216383C // =gPlayer
	rsb r1, r1, #0
	str r1, [r4, #0x48]
	ldr r0, [r0]
	add r3, r4, #0x380
	add r0, r0, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	str r5, [r4, #0xc8]
	ldr r0, [r4, #0x1c]
	bic r0, r0, #0x80
	str r0, [r4, #0x1c]
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02163838: .word 0x00000135
_0216383C: .word gPlayer
	arm_func_end ovl02_216370C

	arm_func_start ovl02_2163840
ovl02_2163840: // 0x02163840
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov ip, r0
	ldr r0, [ip, #0x370]
	ldr r1, [ip, #0x374]
	ldr r2, [r0, #0x370]
	mov r0, #0x30
	mla r0, r1, r0, r2
	add r0, r0, #0xa10
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [sp, #4]
	mov r1, r3
	rsb r2, r0, #0
	add r0, ip, #0x44
	str r2, [sp, #4]
	bl VEC_Distance
	cmp r0, #0x40000
	movle r0, #1
	movgt r0, #0
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end ovl02_2163840

	arm_func_start ovl02_216389C
ovl02_216389C: // 0x0216389C
	ldr r2, [r0, #0x370]
	ldr r1, [r0, #0x374]
	mov r3, #0
	add r1, r2, r1, lsl #2
	str r3, [r1, #0x378]
	ldr r1, [r0, #0x18]
	orr r1, r1, #8
	str r1, [r0, #0x18]
	bx lr
	arm_func_end ovl02_216389C

	arm_func_start ovl02_21638C0
ovl02_21638C0: // 0x021638C0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r6, r2
	mov r0, r1
	add r2, sp, #0
	add r1, r5, #0x44
	mov r4, r3
	bl VEC_Subtract
	ldr r0, [sp, #4]
	ldr r1, [sp]
	bl FX_Atan2Idx
	mov r7, r0
	ldrh r0, [r5, #0x34]
	mov r2, r6
	mov r1, r7
	bl BossHelpers__Math__Func_2039264
	strh r0, [r5, #0x34]
	ldrh r0, [r5, #0x34]
	subs r3, r7, r0
	rsbmi r1, r3, #0
	movpl r1, r3
	subs r6, r0, r7
	rsbmi r2, r6, #0
	movpl r2, r6
	cmp r2, r1
	bge _02163938
	cmp r6, #0
	rsblt r6, r6, #0
	b _02163944
_02163938:
	cmp r3, #0
	rsblt r3, r3, #0
	mov r6, r3
_02163944:
	mov r6, r6, lsl #0x10
	mov r1, r7
	mov r2, r6, lsr #0x12
	bl BossHelpers__Math__Func_2039264
	str r0, [r5, #0x38c]
	cmp r4, r6, lsr #16
	movhs r0, #1
	movlo r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end ovl02_21638C0

	arm_func_start ovl02_216396C
ovl02_216396C: // 0x0216396C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x270]
	mov r0, #0xe7
	orr r1, r1, #4
	str r1, [r4, #0x270]
	mov r1, #0
	str r1, [sp]
	sub r1, r0, #0xe8
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x300
	mov r2, #0x78
	ldr r1, _021639C4 // =ovl02_21639C8
	strh r2, [r0, #0x7e]
	str r1, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021639C4: .word ovl02_21639C8
	arm_func_end ovl02_216396C

	arm_func_start ovl02_21639C8
ovl02_21639C8: // 0x021639C8
	stmdb sp!, {r4, lr}
	ldr r2, _02163A10 // =0x0000038E
	mov r4, r0
	add r1, r4, #0x380
	mov r3, r2, lsl #1
	bl ovl02_21638C0
	cmp r0, #0
	ldrne r0, _02163A14 // =ovl02_2163A1C
	strne r0, [r4, #0x378]
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x300
	ldrh r1, [r0, #0x7e]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x7e]
	ldreq r0, _02163A18 // =ovl02_2163A7C
	streq r0, [r4, #0x378]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02163A10: .word 0x0000038E
_02163A14: .word ovl02_2163A1C
_02163A18: .word ovl02_2163A7C
	arm_func_end ovl02_21639C8

	arm_func_start ovl02_2163A1C
ovl02_2163A1C: // 0x02163A1C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	add r2, sp, #0
	add r0, r4, #0x380
	add r1, r4, #0x44
	bl VEC_Subtract
	mov r0, r4
	add r1, r4, #0x380
	mov r2, #0
	mov r3, #0x2000
	bl ovl02_21638C0
	cmp r0, #0
	ldreq r0, _02163A78 // =ovl02_2163A7C
	addeq sp, sp, #0xc
	streq r0, [r4, #0x378]
	ldmeqia sp!, {r3, r4, pc}
	ldr r0, [sp, #4]
	ldr r1, [sp]
	bl FX_Atan2Idx
	strh r0, [r4, #0x34]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02163A78: .word ovl02_2163A7C
	arm_func_end ovl02_2163A1C

	arm_func_start ovl02_2163A7C
ovl02_2163A7C: // 0x02163A7C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	ldr r0, [r4, #0x370]
	ldr r1, [r4, #0x374]
	ldr r2, [r0, #0x370]
	mov r0, #0x30
	mla r0, r1, r0, r2
	add r0, r0, #0xa10
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [sp, #4]
	ldr r2, _02163AE0 // =0x000004FA
	rsb ip, r0, #0
	mov r1, r3
	mov r0, r4
	add r3, r2, #0x5b0
	str ip, [sp, #4]
	bl ovl02_21638C0
	cmp r0, #0
	ldrne r0, _02163AE4 // =ovl02_2163AE8
	strne r0, [r4, #0x378]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02163AE0: .word 0x000004FA
_02163AE4: .word ovl02_2163AE8
	arm_func_end ovl02_2163A7C

	arm_func_start ovl02_2163AE8
ovl02_2163AE8: // 0x02163AE8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	ldr r0, [r4, #0x370]
	add r2, sp, #0
	ldr r0, [r0, #0x370]
	add r1, r4, #0x44
	add r0, r0, #0x44
	bl VEC_Subtract
	ldr r0, [sp, #4]
	ldr r1, [sp]
	bl FX_Atan2Idx
	strh r0, [r4, #0x34]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	arm_func_end ovl02_2163AE8

	arm_func_start ovl02_2163B24
ovl02_2163B24: // 0x02163B24
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x378]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	blx r1
	ldmia sp!, {r3, pc}
	arm_func_end ovl02_2163B24

	arm_func_start ovl02_2163B3C
ovl02_2163B3C: // 0x02163B3C
	ldr ip, _02163B44 // =GameObject__Destructor
	bx ip
	.align 2, 0
_02163B44: .word GameObject__Destructor
	arm_func_end ovl02_2163B3C

	arm_func_start ovl02_2163B48
ovl02_2163B48: // 0x02163B48
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x20]
	tst r1, #0x20
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0x3b0]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	bl ovl02_2163C9C
	mov r0, r4
	bl ovl02_2163D00
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2163B48

	arm_func_start ovl02_2163B7C
ovl02_2163B7C: // 0x02163B7C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	bl GetCurrentTaskWork_
	mov r7, r0
	ldr r0, [r7, #0x18]
	tst r0, #0xc
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	tst r0, #2
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, pc}
	add r6, r7, #0x3c0
	mov r5, #0
	add r4, sp, #0
_02163BB4:
	ldr r0, [r6, #0x18]
	tst r0, #4
	beq _02163BE0
	add r0, r7, #0x3b4
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	ldr r1, [sp]
	ldr r2, [sp, #4]
	ldr r3, [sp, #8]
	mov r0, r6
	bl BossHelpers__Collision__Func_20390AC
_02163BE0:
	add r5, r5, #1
	cmp r5, #0xf
	add r6, r6, #0x58
	add r7, r7, #0x58
	blt _02163BB4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end ovl02_2163B7C

	arm_func_start ovl02_2163BFC
ovl02_2163BFC: // 0x02163BFC
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr r1, [r1, #0x1c]
	ldr r2, [r0, #0x1c]
	ldrh r0, [r1]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, pc}
	ldr r0, _02163C64 // =gPlayer
	ldr r0, [r0]
	add r0, r0, #0x600
	ldrsh r0, [r0, #0x82]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, pc}
	mov r1, #0
	ldr r0, _02163C68 // =0x00000107
	str r1, [sp]
	sub r1, r0, #0x108
	str r0, [sp, #4]
	ldr r0, [r2, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_02163C64: .word gPlayer
_02163C68: .word 0x00000107
	arm_func_end ovl02_2163BFC

	arm_func_start ovl02_2163C6C
ovl02_2163C6C: // 0x02163C6C
	add r0, r0, #0x288
	add r3, r0, #0x400
	mov r2, #0
_02163C78:
	add r0, r1, r2, lsl #2
	add r2, r2, #1
	str r3, [r0, #0x8dc]
	cmp r2, #0xa
	add r3, r3, #0x104
	blt _02163C78
	mov r0, #1
	str r0, [r1, #0x3b0]
	bx lr
	arm_func_end ovl02_2163C6C

	arm_func_start ovl02_2163C9C
ovl02_2163C9C: // 0x02163C9C
	mov r3, #0
	add ip, r0, #0x3b4
	mov r2, r3
	mov r0, r3
_02163CAC:
	ldrh r1, [ip, #0x50]
	tst r1, #1
	bne _02163CEC
	ldrh r1, [ip, #0x52]
	add r1, r1, #1
	strh r1, [ip, #0x52]
	ldrh r1, [ip, #0x52]
	cmp r1, #4
	blo _02163CE0
	ldrh r1, [ip, #0x54]
	add r1, r1, #1
	strh r1, [ip, #0x54]
	strh r2, [ip, #0x52]
_02163CE0:
	ldrh r1, [ip, #0x54]
	cmp r1, #0xa
	strhsh r0, [ip, #0x54]
_02163CEC:
	add r3, r3, #1
	cmp r3, #0xf
	add ip, ip, #0x58
	blt _02163CAC
	bx lr
	arm_func_end ovl02_2163C9C

	arm_func_start ovl02_2163D00
ovl02_2163D00: // 0x02163D00
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	add r5, r6, #0x3b4
	mov r4, #0
_02163D10:
	ldrh r0, [r5, #0x50]
	tst r0, #2
	bne _02163D58
	ldrh r3, [r5, #0x54]
	ldmia r5, {r0, r1, r2}
	add r3, r6, r3, lsl #2
	ldr ip, [r3, #0x8dc]
	add r3, ip, #0x48
	stmia r3, {r0, r1, r2}
	ldr r1, [ip, #0x4c]
	mov r0, ip
	rsb r1, r1, #0
	str r1, [ip, #0x4c]
	ldr r1, [r5, #0x4c]
	str r1, [ip, #0x18]
	str r1, [ip, #0x1c]
	str r1, [ip, #0x20]
	bl AnimatorSprite3D__Draw
_02163D58:
	add r4, r4, #1
	cmp r4, #0xf
	add r5, r5, #0x58
	blt _02163D10
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl02_2163D00

	arm_func_start ovl02_2163D6C
ovl02_2163D6C: // 0x02163D6C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	mov r5, r0
	ldr r6, [r5, #0x370]
	arm_func_end ovl02_2163D6C

	arm_func_start ovl02_2163D7C
ovl02_2163D7C: // 0x02163D7C
	ldr r0, [r6, #0x380]
	cmp r0, #0
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, pc}
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r2, [sp, #8]
	and r4, r1, #0xff
	str r2, [sp, #0xc]
	ldr r0, _02163E48 // =0x00000136
	mov r1, r2
	mov r3, r2
	str r4, [sp, #0x10]
	bl GameObject__SpawnObject
	mov r4, r0
	str r0, [r6, #0x380]
	mov r0, r6
	mov r1, r4
	str r6, [r4, #0x370]
	bl ovl02_2163C6C
	ldr r0, [r5, #0x20]
	add r3, r4, #0x44
	tst r0, #1
	ldr r0, [r4, #0x20]
	orrne r0, r0, #1
	biceq r0, r0, #1
	str r0, [r4, #0x20]
	ldr r1, [r4, #0x20]
	add r0, r5, #0x1bc
	orr r2, r1, #4
	str r2, [r4, #0x20]
	add r1, sp, #0x14
	add r0, r0, #0x800
	add r2, r4, #0x37c
	bl sub_2066724
	ldr r1, [r4, #0x48]
	add r0, r4, #0x44
	rsb r3, r1, #0
	add r1, r5, #0x44
	add r2, r4, #0x3a0
	str r3, [r4, #0x48]
	bl VEC_Subtract
	add r0, r4, #0x300
	mov r1, #0
	strh r1, [r0, #0xac]
	ldr r0, [r4, #0x1c]
	bic r0, r0, #0x80
	str r0, [r4, #0x1c]
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02163E48: .word 0x00000136
	arm_func_end ovl02_2163D7C

	arm_func_start ovl02_2163E4C
ovl02_2163E4C: // 0x02163E4C
	ldr r0, [r0, #0x370]
	ldr r1, [r0, #0x380]
	cmp r1, #0
	bxeq lr
	ldr r0, [r1, #0x374]
	cmp r0, #0
	beq _02163E78
	cmp r0, #1
	ldreq r0, _02163E84 // =ovl02_21645B4
	streq r0, [r1, #0x378]
	bx lr
_02163E78:
	ldr r0, _02163E88 // =ovl02_2164404
	str r0, [r1, #0x378]
	bx lr
	.align 2, 0
_02163E84: .word ovl02_21645B4
_02163E88: .word ovl02_2164404
	arm_func_end ovl02_2163E4C

	arm_func_start ovl02_2163E8C
ovl02_2163E8C: // 0x02163E8C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r2, r4, #0x300
	ldrh r1, [r2, #0xac]
	cmp r1, #0xf
	movhs r0, #0xf
	strhsh r0, [r2, #0xac]
	ldmhsia sp!, {r4, pc}
	ldr r2, [r4, #0x374]
	cmp r2, #1
	bne _02163EC0
	bl ovl02_21640B4
	b _02163EC4
_02163EC0:
	bl ovl02_2163F6C
_02163EC4:
	add r0, r4, #0x300
	ldrh r1, [r0, #0xac]
	add r1, r1, #1
	strh r1, [r0, #0xac]
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2163E8C

	arm_func_start ovl02_2163ED8
ovl02_2163ED8: // 0x02163ED8
	add r2, r0, #0x3b4
	mov r0, #0x58
	mla r2, r1, r0, r2
	ldrh r0, [r2, #0x50]
	orr r0, r0, #3
	strh r0, [r2, #0x50]
	ldr r0, [r2, #0x24]
	bic r0, r0, #4
	str r0, [r2, #0x24]
	bx lr
	arm_func_end ovl02_2163ED8

	arm_func_start ovl02_2163F00
ovl02_2163F00: // 0x02163F00
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov ip, #0
	mov r3, #3
	mov r2, #2
	str ip, [sp, #8]
	str ip, [sp, #0xc]
	strh r3, [sp, #0x10]
	strh r2, [sp, #0x12]
	ldr r2, [r0]
	mov r4, r1
	mov r1, r2, asr #0xc
	str r1, [sp]
	ldr r1, [r0, #4]
	add r0, sp, #0
	mov r1, r1, asr #0xc
	str r1, [sp, #4]
	bl ObjDiffCollision
	mov r1, r0, lsl #0xc
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #8
	movlt r0, #1
	str r1, [r4]
	movge r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	arm_func_end ovl02_2163F00

	arm_func_start ovl02_2163F6C
ovl02_2163F6C: // 0x02163F6C
	stmdb sp!, {r3, r4, r5, lr}
	mov lr, r0
	movs ip, r1
	add r1, lr, #0x3b4
	mov r0, #0x58
	mla r4, ip, r0, r1
	bne _02163FC0
	add r0, lr, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	ldr r0, [lr, #0x20]
	tst r0, #1
	ldr r0, [r4]
	addne r0, r0, #0xa000
	subeq r0, r0, #0xa000
	str r0, [r4]
	ldr r1, [r4, #4]
	mov r0, #0x400
	add r1, r1, #0x1000
	str r1, [r4, #4]
	b _02164014
_02163FC0:
	sub r1, ip, #1
	mul r3, r1, r0
	add r0, lr, r3
	add r0, r0, #0x3b4
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	ldr r0, [lr, #0x20]
	tst r0, #1
	ldr r0, [r4]
	addne r0, r0, #0x8000
	subeq r0, r0, #0x8000
	str r0, [r4]
	ldr r1, [r4, #4]
	add r0, lr, r3
	add r1, r1, #0x4000
	str r1, [r4, #4]
	ldr r1, [r4, #8]
	add r1, r1, #0x1000
	str r1, [r4, #8]
	ldr r0, [r0, #0x400]
	add r0, r0, r0, asr #2
_02164014:
	str r0, [r4, #0x4c]
	sub r1, ip, #1
	mov r0, #0x58
	mla r0, r1, r0, lr
	mov r1, #0
	strh r1, [r4, #0x52]
	add r0, r0, #0x400
	ldrsh r0, [r0, #8]
	ldr r2, _021640B0 // =_021796C0
	subs r0, r0, #4
	addmi r0, r0, #0xa
	strh r0, [r4, #0x54]
	ldrh r1, [r4, #0x50]
	add r0, r4, #0xc
	bic r1, r1, #2
	strh r1, [r4, #0x50]
	ldrsh r1, [r2, #0xe]
	ldr r5, [r4, #0x4c]
	mul r3, r1, r5
	mov r1, r3, lsl #4
	mov r1, r1, asr #0x10
	str r1, [sp]
	ldrsh ip, [r2, #8]
	ldrsh r3, [r2, #0xa]
	ldrsh r1, [r2, #0xc]
	mul lr, ip, r5
	mul r2, r3, r5
	mul r3, r1, r5
	mov r1, lr, lsl #4
	mov r2, r2, lsl #4
	mov r3, r3, lsl #4
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	mov r3, r3, asr #0x10
	bl ObjRect__SetBox2D
	ldr r0, [r4, #0x24]
	orr r0, r0, #4
	str r0, [r4, #0x24]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021640B0: .word _021796C0
	arm_func_end ovl02_2163F6C

	arm_func_start ovl02_21640B4
ovl02_21640B4: // 0x021640B4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x60
	mov r6, r0
	movs r5, r1
	add r1, r6, #0x3b4
	mov r0, #0x58
	mla r4, r5, r0, r1
	bne _02164110
	add r0, r6, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	ldr r0, [r6, #0x20]
	tst r0, #1
	ldr r0, [r4]
	addne r0, r0, #0xa000
	subeq r0, r0, #0xa000
	str r0, [r4]
	ldr r1, [r4, #4]
	mov r0, #0x400
	add r1, r1, #0x1000
	str r1, [r4, #4]
	str r0, [r4, #0x4c]
	b _021642A4
_02164110:
	sub r1, r5, #1
	mla r3, r1, r0, r6
	add r0, r3, #0x3b4
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	ldr r0, [r3, #0x400]
	add ip, r0, r0, asr #2
	cmp ip, #0x1000
	str ip, [r4, #0x4c]
	movge r0, #0x1000
	strge r0, [r4, #0x4c]
	bge _02164174
	mov r0, #0xc000
	umull r3, r2, ip, r0
	mov r1, #0
	mla r2, ip, r1, r2
	mov r1, ip, asr #0x1f
	mla r2, r1, r0, r2
	adds r3, r3, #0x800
	adc r0, r2, #0
	mov r1, r3, lsr #0xc
	ldr r2, [r4, #4]
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	str r0, [r4, #4]
_02164174:
	add r3, sp, #8
	ldmia r4, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r6, #0x20]
	ldr r2, [r4, #0x4c]
	tst r0, #1
	mov r0, #0x800
	mov r1, r2, asr #0x1f
	beq _021641C0
	mov r1, r1, lsl #0xf
	adds r3, r0, r2, lsl #15
	orr r1, r1, r2, lsr #17
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	ldr r2, [sp, #8]
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	str r0, [sp, #8]
	b _021641E4
_021641C0:
	mov r1, r1, lsl #0xf
	adds r3, r0, r2, lsl #15
	orr r1, r1, r2, lsr #17
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	ldr r2, [sp, #8]
	orr r1, r1, r0, lsl #20
	sub r0, r2, r1
	str r0, [sp, #8]
_021641E4:
	add r0, sp, #8
	add r1, sp, #4
	bl ovl02_2163F00
	ldr r0, [sp, #4]
	cmp r0, #0
	bge _02164234
	ldr r2, [r4, #0x4c]
	mov r0, #0x18000
	umull ip, r3, r2, r0
	mov r1, #0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	adds r2, ip, #0x800
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	ldr r2, [r4, #4]
	orr r1, r1, r0, lsl #20
	sub r0, r2, r1
	str r0, [r4, #4]
_02164234:
	ldr r0, [r6, #0x20]
	ldr r2, [r4, #0x4c]
	tst r0, #1
	mov r0, #0x18000
	umull ip, r3, r2, r0
	mov r1, #0
	beq _0216427C
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r2, ip, #0x800
	mov r1, r2, lsr #0xc
	adc r0, r3, #0
	ldr r2, [r4]
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	str r0, [r4]
	b _021642A4
_0216427C:
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r2, ip, #0x800
	mov r1, r2, lsr #0xc
	adc r0, r3, #0
	ldr r2, [r4]
	orr r1, r1, r0, lsl #20
	sub r0, r2, r1
	str r0, [r4]
_021642A4:
	sub r1, r5, #1
	mov r0, #0x58
	mla r0, r1, r0, r6
	mov r1, #0
	strh r1, [r4, #0x52]
	add r0, r0, #0x400
	ldrsh r0, [r0, #8]
	ldr r2, _02164340 // =_021796C0
	subs r0, r0, #4
	addmi r0, r0, #0xa
	strh r0, [r4, #0x54]
	ldrh r1, [r4, #0x50]
	add r0, r4, #0xc
	bic r1, r1, #2
	strh r1, [r4, #0x50]
	ldrsh r1, [r2, #0xe]
	ldr ip, [r4, #0x4c]
	mul r3, r1, ip
	mov r1, r3, lsl #4
	mov r1, r1, asr #0x10
	str r1, [sp]
	ldrsh r5, [r2, #8]
	ldrsh r3, [r2, #0xa]
	ldrsh r1, [r2, #0xc]
	mul r6, r5, ip
	mul r2, r3, ip
	mul r3, r1, ip
	mov r1, r6, lsl #4
	mov r2, r2, lsl #4
	mov r3, r3, lsl #4
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	mov r3, r3, asr #0x10
	bl ObjRect__SetBox2D
	ldr r0, [r4, #0x24]
	orr r0, r0, #4
	str r0, [r4, #0x24]
	add sp, sp, #0x60
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02164340: .word _021796C0
	arm_func_end ovl02_21640B4

	arm_func_start ovl02_2164344
ovl02_2164344: // 0x02164344
	add r1, r0, #0x300
	mov r3, #0
	ldr r2, _0216435C // =ovl02_2164360
	strh r3, [r1, #0xae]
	str r2, [r0, #0x378]
	bx lr
	.align 2, 0
_0216435C: .word ovl02_2164360
	arm_func_end ovl02_2164344

	arm_func_start ovl02_2164360
ovl02_2164360: // 0x02164360
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x300
	ldrh r1, [r0, #0xac]
	cmp r1, #0xa
	beq _021643B0
	ldrh r1, [r0, #0xae]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xae]
	add r0, r4, #0x300
	ldrh r0, [r0, #0xae]
	cmp r0, #0
	bne _021643B8
	mov r0, r4
	bl ovl02_2163E8C
	add r0, r4, #0x300
	mov r1, #2
	strh r1, [r0, #0xae]
	b _021643B8
_021643B0:
	ldr r0, _021643D8 // =ovl02_21643DC
	str r0, [r4, #0x378]
_021643B8:
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x370]
	bl ovl02_215E4A8
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_21645B4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021643D8: .word ovl02_21643DC
	arm_func_end ovl02_2164360

	arm_func_start ovl02_21643DC
ovl02_21643DC: // 0x021643DC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x370]
	bl ovl02_215E4A8
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_2164404
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_21643DC

	arm_func_start ovl02_2164404
ovl02_2164404: // 0x02164404
	add r1, r0, #0x300
	mov r3, #0
	ldr r2, _0216441C // =ovl02_2164420
	strh r3, [r1, #0xac]
	str r2, [r0, #0x378]
	bx lr
	.align 2, 0
_0216441C: .word ovl02_2164420
	arm_func_end ovl02_2164404

	arm_func_start ovl02_2164420
ovl02_2164420: // 0x02164420
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r1, [r1, #0xac]
	cmp r1, #0xa
	bhs _02164450
	bl ovl02_2163ED8
	add r0, r4, #0x300
	ldrh r1, [r0, #0xac]
	add r1, r1, #1
	strh r1, [r0, #0xac]
	ldmia sp!, {r4, pc}
_02164450:
	ldr r0, [r4, #0x370]
	mov r1, #0
	str r1, [r0, #0x380]
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2164420

	arm_func_start ovl02_216446C
ovl02_216446C: // 0x0216446C
	add r1, r0, #0x300
	mov r3, #0
	ldr r2, _02164484 // =ovl02_2164488
	strh r3, [r1, #0xae]
	str r2, [r0, #0x378]
	bx lr
	.align 2, 0
_02164484: .word ovl02_2164488
	arm_func_end ovl02_216446C

	arm_func_start ovl02_2164488
ovl02_2164488: // 0x02164488
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	add r0, r4, #0x300
	ldrh r1, [r0, #0xac]
	cmp r1, #0xf
	beq _02164558
	ldrh r1, [r0, #0xae]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xae]
	add r0, r4, #0x300
	ldrh r1, [r0, #0xae]
	cmp r1, #0
	bne _021644DC
	mov r0, r4
	bl ovl02_2163E8C
	add r0, r4, #0x300
	mov r1, #2
	strh r1, [r0, #0xae]
	b _02164560
_021644DC:
	ldrh r1, [r0, #0xac]
	add r2, r4, #0x3b4
	mov r0, #0x58
	sub r1, r1, #1
	mla r0, r1, r0, r2
	add r1, sp, #0
	bl ovl02_2163F00
	add r1, r4, #0x300
	ldrh r2, [r1, #0xac]
	mov r1, #0x58
	sub r2, r2, #1
	mul ip, r2, r1
	add r1, r4, ip
	ldr r1, [r1, #0x400]
	cmp r1, #0x1000
	bge _02164528
	ldr r1, [sp]
	cmp r1, #0
	bge _02164560
_02164528:
	add r3, r4, #0x3b8
	ldr r2, [r3, ip]
	ldr r1, [sp]
	cmp r0, #0
	add r0, r2, r1
	str r0, [r3, ip]
	bne _02164560
	add r0, r4, #0x300
	ldrh r1, [r0, #0xae]
	add r1, r1, #1
	strh r1, [r0, #0xae]
	b _02164560
_02164558:
	ldr r0, _02164588 // =ovl02_216458C
	str r0, [r4, #0x378]
_02164560:
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x370]
	bl ovl02_215E4A8
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, pc}
	mov r0, r4
	bl ovl02_21645B4
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02164588: .word ovl02_216458C
	arm_func_end ovl02_2164488

	arm_func_start ovl02_216458C
ovl02_216458C: // 0x0216458C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x370]
	bl ovl02_215E4A8
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_21645B4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_216458C

	arm_func_start ovl02_21645B4
ovl02_21645B4: // 0x021645B4
	add r1, r0, #0x300
	mov r3, #0
	ldr r2, _021645CC // =ovl02_21645D0
	strh r3, [r1, #0xac]
	str r2, [r0, #0x378]
	bx lr
	.align 2, 0
_021645CC: .word ovl02_21645D0
	arm_func_end ovl02_21645B4

	arm_func_start ovl02_21645D0
ovl02_21645D0: // 0x021645D0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r1, [r1, #0xac]
	cmp r1, #0xf
	bhs _02164600
	bl ovl02_2163ED8
	add r0, r4, #0x300
	ldrh r1, [r0, #0xac]
	add r1, r1, #1
	strh r1, [r0, #0xac]
	ldmia sp!, {r4, pc}
_02164600:
	ldr r0, [r4, #0x370]
	mov r1, #0
	str r1, [r0, #0x380]
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_21645D0

	arm_func_start ovl02_216461C
ovl02_216461C: // 0x0216461C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x300
	mov r1, #0
	strh r1, [r0, #0xd0]
	ldr r0, [r4, #0x3d4]
	tst r0, #0x20
	beq _02164650
	ldr r0, _0216469C // =ovl02_2167540
	str r0, [r4, #0x3c8]
	ldr r0, [r4, #0x3d4]
	bic r0, r0, #0x20
	str r0, [r4, #0x3d4]
_02164650:
	ldr r1, [r4, #0x3c8]
	cmp r1, #0
	beq _02164670
	ldr r0, [r4, #0x3d4]
	tst r0, #0x10
	bne _02164670
	mov r0, r4
	blx r1
_02164670:
	mov r0, r4
	bl ovl02_215DB18
	ldr r1, [r4, #0x3cc]
	cmp r1, #0
	beq _0216468C
	mov r0, r4
	blx r1
_0216468C:
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216469C: .word ovl02_2167540
	arm_func_end ovl02_216461C

	arm_func_start ovl02_21646A0
ovl02_21646A0: // 0x021646A0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x338
	add r0, r0, #0x800
	bl AnimatorMDL__Release
	add r0, r4, #0x7c
	add r0, r0, #0xc00
	bl AnimatorMDL__Release
	add r0, r4, #0x1f4
	add r0, r0, #0x800
	bl AnimatorMDL__Release
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_21646A0

	arm_func_start ovl02_21646E0
ovl02_21646E0: // 0x021646E0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, lr}
	sub sp, sp, #0x54
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x1f4
	add r5, r0, #0x800
	add r0, r4, #0x44
	add r3, r5, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r5, #0x4c]
	add r1, sp, #0x24
	rsb r0, r0, #0
	str r0, [r5, #0x4c]
	ldr r6, [r5, #0x5c]
	ldr r2, [r5, #0x58]
	rsb r7, r6, #0
	ldr r0, [r5, #0x54]
	rsb r6, r2, #0
	rsb r2, r0, #0
	str r2, [sp, #0x24]
	mov r0, r3
	mov r2, r3
	str r6, [sp, #0x28]
	str r7, [sp, #0x2c]
	bl VEC_Add
	ldr r1, [r4, #0x20]
	add r0, r4, #0x500
	tst r1, #1
	ldrh r0, [r0, #0x80]
	beq _0216479C
	add r0, r0, #0x4000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _02164970 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r5, #0x24
	blx MTX_RotY33_
	b _021647D8
_0216479C:
	add r0, r0, #0xc000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _02164970 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r5, #0x24
	blx MTX_RotY33_
_021647D8:
	ldr r0, [r4, #0x57c]
	ldr r2, _02164970 // =FX_SinCosTable_
	rsb r0, r0, #0
	mov r0, r0, lsl #0x10
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
	add r0, sp, #0x30
	blx MTX_RotZ33_
	add r0, r5, #0x24
	add r1, sp, #0x30
	mov r2, r0
	bl MTX_Concat33
	add r0, r4, #0x7c
	add r6, r0, #0xc00
	add r0, r4, #0x218
	add sb, r0, #0x800
	ldmia sb!, {r0, r1, r2, r3}
	add r8, r6, #0x24
	stmia r8!, {r0, r1, r2, r3}
	add r0, r4, #0x338
	add r7, r0, #0x800
	ldmia sb!, {r0, r1, r2, r3}
	stmia r8!, {r0, r1, r2, r3}
	ldr r0, [sb]
	add lr, r4, #0x44
	str r0, [r8]
	add ip, r6, #0x48
	ldmia lr, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r2, [r6, #0x4c]
	add sl, r4, #0x194
	rsb r2, r2, #0
	add r0, sl, #0x800
	add r1, sp, #0
	str r2, [r6, #0x4c]
	bl sub_20665F8
	add r0, r4, #0x1b8
	add ip, sp, #0
	add sb, r0, #0x800
	ldmia ip!, {r0, r1, r2, r3}
	add sl, r7, #0x24
	stmia sl!, {r0, r1, r2, r3}
	ldmia ip!, {r0, r1, r2, r3}
	stmia sl!, {r0, r1, r2, r3}
	ldr r0, [ip]
	add r8, r7, #0x48
	str r0, [sl]
	ldmia sb, {r0, r1, r2}
	stmia r8, {r0, r1, r2}
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	beq _0216490C
	add r0, r4, #0x300
	ldrsh r0, [r0, #0x50]
	cmp r0, #0
	addeq sp, sp, #0x54
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
	mov r0, r5
	bl AnimatorMDL__ProcessAnimation
	mov r0, r7
	bl AnimatorMDL__ProcessAnimation
	ldr r0, [r4, #0x3d4]
	tst r0, #0x200
	addeq sp, sp, #0x54
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
	mov r0, r6
	bl AnimatorMDL__ProcessAnimation
	add sp, sp, #0x54
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
_0216490C:
	mov r0, r5
	bl AnimatorMDL__ProcessAnimation
	mov r0, r7
	bl AnimatorMDL__ProcessAnimation
	mov r0, r5
	bl AnimatorMDL__Draw
	mov r0, r7
	bl AnimatorMDL__Draw
	ldr r0, [r4, #0x3d4]
	tst r0, #0x200
	beq _02164948
	mov r0, r6
	bl AnimatorMDL__ProcessAnimation
	mov r0, r6
	bl AnimatorMDL__Draw
_02164948:
	add r0, r4, #0x194
	add r1, r0, #0x800
	mov r0, #0x1a
	bl BossHelpers__Model__SetMatrixMode
	add r0, r4, #0x1c4
	add r1, r0, #0x800
	mov r0, #0x19
	bl BossHelpers__Model__SetMatrixMode
	add sp, sp, #0x54
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
	.align 2, 0
_02164970: .word FX_SinCosTable_
	arm_func_end ovl02_21646E0

	arm_func_start ovl02_2164974
ovl02_2164974: // 0x02164974
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x30
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x1f4
	add r5, r0, #0x800
	add r0, r4, #0x44
	add r3, r5, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r5, #0x4c]
	add r1, sp, #0
	rsb r0, r0, #0
	str r0, [r5, #0x4c]
	ldr ip, [r5, #0x5c]
	ldr r2, [r5, #0x58]
	rsb lr, ip, #0
	ldr r0, [r5, #0x54]
	rsb ip, r2, #0
	rsb r2, r0, #0
	str r2, [sp]
	mov r0, r3
	mov r2, r3
	str ip, [sp, #4]
	str lr, [sp, #8]
	bl VEC_Add
	ldr r1, [r4, #0x20]
	add r0, r4, #0x500
	tst r1, #1
	ldrh r0, [r0, #0x80]
	beq _02164A30
	add r0, r0, #0x4000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _02164ADC // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r5, #0x24
	blx MTX_RotY33_
	b _02164A6C
_02164A30:
	add r0, r0, #0xc000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _02164ADC // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r5, #0x24
	blx MTX_RotY33_
_02164A6C:
	ldr r0, [r4, #0x57c]
	ldr r2, _02164ADC // =FX_SinCosTable_
	add r0, r0, #0x55
	add r3, r0, #0x1500
	mov r0, r3, lsl #0x10
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
	add r0, sp, #0xc
	str r3, [r4, #0x57c]
	blx MTX_RotZ33_
	add r0, r5, #0x24
	add r1, sp, #0xc
	mov r2, r0
	bl MTX_Concat33
	mov r0, r5
	bl AnimatorMDL__ProcessAnimation
	mov r0, r5
	bl AnimatorMDL__Draw
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02164ADC: .word FX_SinCosTable_
	arm_func_end ovl02_2164974

	arm_func_start ovl02_2164AE0
ovl02_2164AE0: // 0x02164AE0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x18]
	tst r1, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	tst r1, #2
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	add r1, r0, #0x500
	ldrh r2, [r1, #0x82]
	cmp r2, #0
	subne r0, r2, #1
	strneh r0, [r1, #0x82]
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r2, [r1, #0x86]
	cmp r2, #0
	subne r2, r2, #1
	strneh r2, [r1, #0x86]
	add r1, r0, #0x300
	ldrsh r1, [r1, #0x50]
	cmp r1, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	add r1, r0, #0xbc
	add r5, r0, #0x3fc
	add r6, r1, #0x400
	mov r4, #0
	add r7, r0, #0x1e8
	add r8, r0, #0x1b8
_02164B4C:
	ldr r0, [r5, #0x18]
	tst r0, #4
	beq _02164B70
	ldr r2, [r7, #0x804]
	ldr r1, [r7, #0x800]
	ldr r3, [r7, #0x808]
	mov r0, r5
	rsb r2, r2, #0
	bl BossHelpers__Collision__Func_20390AC
_02164B70:
	ldr r0, [r6, #0x18]
	tst r0, #4
	beq _02164B94
	ldr r2, [r8, #0x804]
	ldr r1, [r8, #0x800]
	ldr r3, [r8, #0x808]
	mov r0, r6
	rsb r2, r2, #0
	bl BossHelpers__Collision__Func_20390AC
_02164B94:
	add r4, r4, #1
	cmp r4, #3
	add r5, r5, #0x40
	add r6, r6, #0x40
	blt _02164B4C
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end ovl02_2164AE0

	arm_func_start ovl02_2164BAC
ovl02_2164BAC: // 0x02164BAC
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r2, [r5]
	cmp r2, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r2, [r4, #0x3d4]
	tst r2, #4
	beq _02164C34
	ldr r0, _02164D88 // =gPlayer
	ldr r1, [r0]
	add r0, r1, #0x600
	ldrsh r0, [r0, #0x82]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	add r0, r1, #0x1b0
	bl ovl02_215F6DC
	mov r2, #0
	mov r0, #0xea
	str r2, [sp]
	sub r1, r0, #0xeb
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, r4
	mov r1, r5
	bl ovl02_215E0F8
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_02164C34:
	ldr r2, [r5, #0x568]
	tst r2, #4
	beq _02164CCC
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x370]
	cmp r0, #0
	beq _02164C74
	add r0, r0, #0x300
	ldrsh r0, [r0, #0xd2]
	cmp r0, #0
	bgt _02164C74
	mov r0, r4
	mov r1, r5
	bl ovl02_215E0F8
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_02164C74:
	mov r0, r4
	bl ovl02_215F2E8
	ldr r0, _02164D88 // =gPlayer
	ldr r0, [r0]
	add r0, r0, #0x1b0
	bl ovl02_215F6A8
	mov r3, #0x8c
	mov r0, #0
	sub r1, r3, #0x8d
	stmia sp, {r0, r3}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, r4
	bl ovl02_215F5CC
	mov r0, r5
	bl Player__Action_DestroyAttackRecoil
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_02164CCC:
	ldr r2, _02164D88 // =gPlayer
	ldr r2, [r2]
	add r2, r2, #0x600
	ldrsh r2, [r2, #0x82]
	cmp r2, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r3, [r5, #0x44]
	ldr r2, [r4, #0x44]
	cmp r2, r3
	bge _02164D20
	ldrsh ip, [r1, #6]
	ldr lr, [r1, #0xc]
	ldrsh r1, [r0]
	add ip, lr, ip
	mov r0, #0x4000
	sub r1, ip, r1
	add r1, r2, r1, lsl #12
	sub r1, r1, r3
	str r1, [r5, #0xb0]
	b _02164D48
_02164D20:
	ldrsh ip, [r1]
	ldr lr, [r1, #0xc]
	ldrsh r1, [r0, #6]
	add ip, lr, ip
	mov r0, #0x4000
	sub r1, ip, r1
	add r1, r2, r1, lsl #12
	sub r1, r1, r3
	str r1, [r5, #0xb0]
	rsb r0, r0, #0
_02164D48:
	ldr r1, [r4, #0x3d4]
	tst r1, #8
	bne _02164D70
	ldr r2, [r5, #0xb0]
	rsb r1, r0, #0
	mov r2, r2, asr #1
	str r2, [r5, #0xb0]
	rsb r2, r2, #0
	str r2, [r4, #0xb0]
	str r1, [r4, #0x98]
_02164D70:
	ldr r1, [r5, #0x1c]
	tst r1, #0x8000
	strne r0, [r5, #0x98]
	streq r0, [r5, #0xc8]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02164D88: .word gPlayer
	arm_func_end ovl02_2164BAC

	arm_func_start ovl02_2164D8C
ovl02_2164D8C: // 0x02164D8C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r1
	ldr r1, [r5, #0x1c]
	mov r6, r0
	ldrh r0, [r1]
	ldr r4, [r6, #0x1c]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, [r1, #0x568]
	tst r0, #4
	mov r0, r4
	beq _02164E30
	bl ovl02_215E0F8
	mov r0, r6
	mov r1, r5
	bl ObjRect__FuncNoHit
	add r0, r4, #0x500
	ldrh r0, [r0, #0x86]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, _02164E6C // =gPlayer
	ldr r0, [r0]
	add r0, r0, #0x1b0
	bl ovl02_215F6DC
	mov r2, #0
	mov r0, #0xea
	str r2, [sp]
	sub r1, r0, #0xeb
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x500
	mov r1, #0xa
	strh r1, [r0, #0x86]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
_02164E30:
	bl ovl02_215E770
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r1, #0
	ldr r0, _02164E70 // =0x00000107
	str r1, [sp]
	sub r1, r0, #0x108
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02164E6C: .word gPlayer
_02164E70: .word 0x00000107
	arm_func_end ovl02_2164D8C

	arm_func_start ovl02_2164E74
ovl02_2164E74: // 0x02164E74
	ldr r1, [r0, #0x414]
	orr r1, r1, #4
	str r1, [r0, #0x414]
	ldr r1, [r0, #0x4d4]
	orr r1, r1, #4
	str r1, [r0, #0x4d4]
	ldr r1, [r0, #0x454]
	bic r1, r1, #4
	str r1, [r0, #0x454]
	ldr r1, [r0, #0x514]
	bic r1, r1, #4
	str r1, [r0, #0x514]
	ldr r1, [r0, #0x3d4]
	bic r1, r1, #4
	str r1, [r0, #0x3d4]
	bx lr
	arm_func_end ovl02_2164E74

	arm_func_start ovl02_2164EB4
ovl02_2164EB4: // 0x02164EB4
	ldr r1, [r0, #0x414]
	bic r1, r1, #4
	str r1, [r0, #0x414]
	ldr r1, [r0, #0x4d4]
	bic r1, r1, #4
	str r1, [r0, #0x4d4]
	ldr r1, [r0, #0x454]
	orr r1, r1, #4
	str r1, [r0, #0x454]
	ldr r1, [r0, #0x514]
	orr r1, r1, #4
	str r1, [r0, #0x514]
	ldr r1, [r0, #0x3d4]
	bic r1, r1, #4
	str r1, [r0, #0x3d4]
	bx lr
	arm_func_end ovl02_2164EB4

	arm_func_start ovl02_2164EF4
ovl02_2164EF4: // 0x02164EF4
	ldr r1, [r0, #0x414]
	orr r1, r1, #4
	str r1, [r0, #0x414]
	ldr r1, [r0, #0x4d4]
	orr r1, r1, #4
	str r1, [r0, #0x4d4]
	ldr r1, [r0, #0x454]
	bic r1, r1, #4
	str r1, [r0, #0x454]
	ldr r1, [r0, #0x514]
	bic r1, r1, #4
	str r1, [r0, #0x514]
	ldr r1, [r0, #0x3d4]
	orr r1, r1, #4
	str r1, [r0, #0x3d4]
	bx lr
	arm_func_end ovl02_2164EF4

	arm_func_start ovl02_2164F34
ovl02_2164F34: // 0x02164F34
	ldr ip, _02164F44 // =StageTask__SetGravity
	mov r1, #0x2a0
	mov r2, #0xf000
	bx ip
	.align 2, 0
_02164F44: .word StageTask__SetGravity
	arm_func_end ovl02_2164F34

	arm_func_start ovl02_2164F48
ovl02_2164F48: // 0x02164F48
	ldr ip, _02164F58 // =StageTask__SetGravity
	mov r1, #0x2a0
	mov r2, #0xf000
	bx ip
	.align 2, 0
_02164F58: .word StageTask__SetGravity
	arm_func_end ovl02_2164F48

	arm_func_start ovl02_2164F5C
ovl02_2164F5C: // 0x02164F5C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x18
	mov r5, r0
	ldr r3, [r5, #0x44]
	ldr r0, [r5, #0xa48]
	mov r4, r2
	sub r0, r3, r0
	str r0, [sp, #0xc]
	ldr r3, [r5, #0x48]
	ldr r2, [r5, #0xa4c]
	mov r0, r1
	add r1, r3, r2
	str r1, [sp, #0x10]
	ldr r3, [r5, #0x4c]
	ldr r2, [r5, #0xa50]
	add r1, sp, #0xc
	sub r3, r3, r2
	add r2, sp, #0
	str r3, [sp, #0x14]
	bl VEC_Subtract
	ldr r0, [sp, #4]
	ldr r1, [sp]
	bl FX_Atan2Idx
	ldrh r1, [r5, #0x34]
	subs ip, r0, r1
	rsbmi r3, ip, #0
	movpl r3, ip
	subs r5, r1, r0
	rsbmi r1, r5, #0
	movpl r1, r5
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	mov r1, r3, lsl #0x10
	cmp r2, r1, lsr #16
	bge _02164FF8
	cmp r5, #0
	rsblt r5, r5, #0
	mov r1, r5, lsl #0x10
	b _02165004
_02164FF8:
	cmp ip, #0
	rsblt ip, ip, #0
	mov r1, ip, lsl #0x10
_02165004:
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r4, #0
	strneh r0, [r4]
	mov r0, r1
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_2164F5C

	arm_func_start ovl02_2165024
ovl02_2165024: // 0x02165024
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r2
	add r2, sp, #0
	mov r5, r0
	bl ovl02_2164F5C
	cmp r4, #0
	ldreqh r0, [sp]
	beq _02165054
	ldrh r0, [r5, #0x34]
	ldrh r1, [sp]
	ldr r2, _02165064 // =0x0000038E
	bl BossHelpers__Math__Func_2039264
_02165054:
	strh r0, [r5, #0x34]
	mov r0, r5
	bl ovl02_2165068
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02165064: .word 0x0000038E
	arm_func_end ovl02_2165024

	arm_func_start ovl02_2165068
ovl02_2165068: // 0x02165068
	ldrh r1, [r0, #0x34]
	add r1, r1, #0x4000
	str r1, [r0, #0x57c]
	bx lr
	arm_func_end ovl02_2165068

	arm_func_start ovl02_2165078
ovl02_2165078: // 0x02165078
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r3, r0
	add r0, r3, #0x1b8
	add r0, r0, #0x800
	add r4, sp, #0xc
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	ldr r0, [r3, #0x48]
	add r2, r3, #0x248
	ldr lr, [r3, #0x4c]
	ldr r3, [r3, #0x44]
	rsb ip, r0, #0
	add r0, sp, #0
	mov r1, r4
	add r2, r2, #0x800
	str r3, [sp]
	str ip, [sp, #4]
	str lr, [sp, #8]
	bl VEC_Subtract
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2165078

	arm_func_start ovl02_21650D0
ovl02_21650D0: // 0x021650D0
	mov r1, #0
	str r1, [r0, #0xa48]
	str r1, [r0, #0xa4c]
	str r1, [r0, #0xa50]
	bx lr
	arm_func_end ovl02_21650D0

	arm_func_start ovl02_21650E4
ovl02_21650E4: // 0x021650E4
	ldr r1, [r0, #0x3d4]
	orr r1, r1, #0x40
	str r1, [r0, #0x3d4]
	bx lr
	arm_func_end ovl02_21650E4

	arm_func_start ovl02_21650F4
ovl02_21650F4: // 0x021650F4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2164E74
	ldr r0, [r4, #0x98]
	cmp r0, #0
	beq _02165118
	mov r0, r4
	bl ovl02_21655E8
	ldmia sp!, {r4, pc}
_02165118:
	add r0, r4, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02165164
_0216512C: // jump table
	b _0216513C // case 0
	b _02165150 // case 1
	b _02165150 // case 2
	b _02165150 // case 3
_0216513C:
	mov r0, r4
	mov r1, #0
	mov r2, #1
	bl ovl02_215EFF4
	b _02165184
_02165150:
	mov r0, r4
	mov r1, #4
	mov r2, #0
	bl ovl02_215EFF4
	b _02165184
_02165164:
	mov r0, r4
	bl ovl02_215F120
	cmp r0, #0
	beq _02165184
	mov r0, r4
	mov r1, #0
	mov r2, #1
	bl ovl02_215EFF4
_02165184:
	ldr r0, _02165190 // =ovl02_2165194
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165190: .word ovl02_2165194
	arm_func_end ovl02_21650F4

	arm_func_start ovl02_2165194
ovl02_2165194: // 0x02165194
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r1, [r1, #0x58]
	cmp r1, #4
	bne _021651C8
	bl ovl02_215F120
	cmp r0, #0
	beq _021651C8
	mov r0, r4
	mov r1, #0
	mov r2, #1
	bl ovl02_215EFF4
_021651C8:
	mov r0, r4
	bl ovl02_215E19C
	cmp r0, #0
	beq _021651E4
	mov r0, r4
	bl ovl02_2165284
	ldmia sp!, {r4, pc}
_021651E4:
	add r0, r4, #0x300
	ldrh r1, [r0, #0x74]
	tst r1, #2
	beq _02165208
	tst r1, #0x80
	beq _02165208
	mov r0, r4
	bl ovl02_216546C
	ldmia sp!, {r4, pc}
_02165208:
	add r0, r4, #0x300
	ldrh r0, [r0, #0x78]
	tst r0, #2
	beq _02165224
	mov r0, r4
	bl ovl02_21652BC
	ldmia sp!, {r4, pc}
_02165224:
	tst r1, #0x30
	ldreq r0, [r4, #0x98]
	cmpeq r0, #0
	beq _0216523C
	mov r0, r4
	bl ovl02_21655E8
_0216523C:
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #1
	beq _02165260
	mov r0, r4
	bl ovl02_215E1EC
	mov r0, r4
	bl ovl02_2165964
	ldmia sp!, {r4, pc}
_02165260:
	tst r0, #0x800
	ldmeqia sp!, {r4, pc}
	tst r0, #0x40
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E1EC
	mov r0, r4
	bl ovl02_2165E8C
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2165194

	arm_func_start ovl02_2165284
ovl02_2165284: // 0x02165284
	ldr r2, [r0, #0x20]
	ldr r1, _021652B8 // =ovl02_21653D0
	orr r2, r2, #4
	str r2, [r0, #0x20]
	ldr r2, [r0, #0x1c]
	orr r2, r2, #0x10
	orr r2, r2, #0x8000
	str r2, [r0, #0x1c]
	str r1, [r0, #0x3cc]
	ldr r1, [r0, #0x3d4]
	orr r1, r1, #1
	str r1, [r0, #0x3d4]
	bx lr
	.align 2, 0
_021652B8: .word ovl02_21653D0
	arm_func_end ovl02_2165284

	arm_func_start ovl02_21652BC
ovl02_21652BC: // 0x021652BC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r2, #0
	str r2, [r4, #0x98]
	mov r1, #5
	bl ovl02_215EFF4
	ldr r1, [r4, #0x1c]
	ldr r0, _021652FC // =ovl02_2165300
	orr r1, r1, #0x10
	orr r1, r1, #0x8000
	str r1, [r4, #0x1c]
	str r0, [r4, #0x3cc]
	mov r0, #0
	str r0, [r4, #0x2c]
	str r0, [r4, #0x28]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021652FC: .word ovl02_2165300
	arm_func_end ovl02_21652BC

	arm_func_start ovl02_2165300
ovl02_2165300: // 0x02165300
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215F120
	cmp r0, #0
	ldrne r0, _0216531C // =ovl02_2165320
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216531C: .word ovl02_2165320
	arm_func_end ovl02_2165300

	arm_func_start ovl02_2165320
ovl02_2165320: // 0x02165320
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	mov r2, #0xe9
	str r1, [sp]
	sub r1, r2, #0xea
	mov r4, r0
	str r2, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, r4
	bl ovl02_2166C18
	mov r3, #0xd000
	rsb r3, r3, #0
	mov r0, r4
	mov r1, #6
	mov r2, #1
	str r3, [r4, #0x9c]
	bl ovl02_215EFF4
	ldr r0, _02165384 // =ovl02_2165388
	str r0, [r4, #0x3cc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165384: .word ovl02_2165388
	arm_func_end ovl02_2165320

	arm_func_start ovl02_2165388
ovl02_2165388: // 0x02165388
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2166C18
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #2
	bne _021653B8
	mov r1, #0x3000
	rsb r1, r1, #0
	ldr r0, _021653CC // =ovl02_21653D0
	str r1, [r4, #0x9c]
	str r0, [r4, #0x3cc]
_021653B8:
	ldr r0, [r4, #0x9c]
	cmp r0, #0
	ldrge r0, _021653CC // =ovl02_21653D0
	strge r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021653CC: .word ovl02_21653D0
	arm_func_end ovl02_2165388

	arm_func_start ovl02_21653D0
ovl02_21653D0: // 0x021653D0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2166C18
	mov r0, r4
	bl ovl02_2164F34
	ldr r0, _021653F0 // =ovl02_21653F4
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021653F0: .word ovl02_21653F4
	arm_func_end ovl02_21653D0

	arm_func_start ovl02_21653F4
ovl02_21653F4: // 0x021653F4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2166C18
	ldr r0, [r4, #0x1c]
	tst r0, #1
	ldrne r0, _02165414 // =ovl02_2165418
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165414: .word ovl02_2165418
	arm_func_end ovl02_21653F4

	arm_func_start ovl02_2165418
ovl02_2165418: // 0x02165418
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #7
	mov r2, #0
	bl ovl02_215EFF4
	mov r1, #0
	mov r0, r4
	str r1, [r4, #0x98]
	bl ovl02_2164F48
	ldr r0, _02165448 // =ovl02_216544C
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165448: .word ovl02_216544C
	arm_func_end ovl02_2165418

	arm_func_start ovl02_216544C
ovl02_216544C: // 0x0216544C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215F120
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_21650F4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_216544C

	arm_func_start ovl02_216546C
ovl02_216546C: // 0x0216546C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0x98]
	bl ovl02_2164F34
	mov r0, r4
	mov r1, #5
	mov r2, #0
	bl ovl02_215EFF4
	ldr r1, [r4, #0x1c]
	ldr r0, _021654C4 // =ovl02_21654C8
	orr r1, r1, #0x10
	orr r1, r1, #0x8000
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x18]
	bic r1, r1, #1
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x1c]
	bic r1, r1, #1
	str r1, [r4, #0x1c]
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021654C4: .word ovl02_21654C8
	arm_func_end ovl02_216546C

	arm_func_start ovl02_21654C8
ovl02_21654C8: // 0x021654C8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2166C18
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #2
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #1
	streq r0, [r4, #0x18]
	mov r0, r4
	bl ovl02_215F120
	cmp r0, #0
	ldrne r0, _02165504 // =ovl02_2165508
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165504: .word ovl02_2165508
	arm_func_end ovl02_21654C8

	arm_func_start ovl02_2165508
ovl02_2165508: // 0x02165508
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2166C18
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	mov r1, #6
	mov r2, #1
	tst r0, #2
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #1
	streq r0, [r4, #0x18]
	mov r0, r4
	bl ovl02_215EFF4
	ldr r0, _02165548 // =ovl02_216554C
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165548: .word ovl02_216554C
	arm_func_end ovl02_2165508

	arm_func_start ovl02_216554C
ovl02_216554C: // 0x0216554C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2166C18
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #2
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #1
	streq r0, [r4, #0x18]
	ldr r0, [r4, #0x1c]
	tst r0, #1
	ldrne r0, _02165584 // =ovl02_2165588
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165584: .word ovl02_2165588
	arm_func_end ovl02_216554C

	arm_func_start ovl02_2165588
ovl02_2165588: // 0x02165588
	stmdb sp!, {r4, lr}
	mov r1, #7
	mov r2, #0
	mov r4, r0
	bl ovl02_215EFF4
	mov r0, #0
	str r0, [r4, #0x98]
	ldr r1, [r4, #0x18]
	mov r0, r4
	orr r1, r1, #1
	str r1, [r4, #0x18]
	bl ovl02_2164F48
	ldr r0, _021655C4 // =ovl02_21655C8
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021655C4: .word ovl02_21655C8
	arm_func_end ovl02_2165588

	arm_func_start ovl02_21655C8
ovl02_21655C8: // 0x021655C8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215F120
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_21650F4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_21655C8

	arm_func_start ovl02_21655E8
ovl02_21655E8: // 0x021655E8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x20]
	ands r1, r0, #1
	beq _0216560C
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #0x20
	bne _02165624
_0216560C:
	cmp r1, #0
	bne _02165638
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #0x10
	beq _02165638
_02165624:
	mov r0, r4
	mov r1, #1
	mov r2, #0
	bl ovl02_215EFF4
	b _02165694
_02165638:
	add r0, r4, #0x300
	ldrh r1, [r0, #0x58]
	cmp r1, #1
	bne _02165654
	mov r0, r4
	bl ovl02_215F16C
	b _02165694
_02165654:
	cmp r1, #2
	bne _02165670
	mov r0, r4
	mov r1, #3
	mov r2, #1
	bl ovl02_215EFF4
	b _02165694
_02165670:
	ldr r0, [r4, #0x98]
	cmp r0, #0
	beq _02165684
	cmp r1, #4
	beq _02165694
_02165684:
	mov r0, r4
	mov r1, #2
	mov r2, #0
	bl ovl02_215EFF4
_02165694:
	add r0, r4, #0x300
	ldrh r1, [r0, #0x58]
	cmp r1, #1
	bne _021656D0
	ldrh r0, [r0, #0x74]
	tst r0, #0x20
	beq _021656C0
	ldr r0, [r4, #0x3d4]
	orr r0, r0, #2
	str r0, [r4, #0x3d4]
	b _021656D0
_021656C0:
	tst r0, #0x10
	ldrne r0, [r4, #0x3d4]
	bicne r0, r0, #2
	strne r0, [r4, #0x3d4]
_021656D0:
	ldr r0, [r4, #0x1c]
	ldr r1, _021656F0 // =ovl02_21656F4
	bic r0, r0, #0x10
	str r0, [r4, #0x1c]
	mov r0, r4
	str r1, [r4, #0x3cc]
	bl ovl02_2166B48
	ldmia sp!, {r4, pc}
	.align 2, 0
_021656F0: .word ovl02_21656F4
	arm_func_end ovl02_21655E8

	arm_func_start ovl02_21656F4
ovl02_21656F4: // 0x021656F4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x300
	ldrh r1, [r0, #0x74]
	ands r2, r1, #0x20
	beq _02165718
	ldr r0, [r4, #0x98]
	cmp r0, #0
	bgt _0216572C
_02165718:
	tst r1, #0x10
	beq _0216577C
	ldr r0, [r4, #0x98]
	cmp r0, #0
	bge _0216577C
_0216572C:
	cmp r2, #0
	beq _02165744
	ldr r0, [r4, #0x3d4]
	orr r0, r0, #2
	str r0, [r4, #0x3d4]
	b _02165754
_02165744:
	tst r1, #0x10
	ldrne r0, [r4, #0x3d4]
	bicne r0, r0, #2
	strne r0, [r4, #0x3d4]
_02165754:
	add r0, r4, #0x300
	ldrh r0, [r0, #0x58]
	cmp r0, #1
	bne _0216577C
	mov r0, r4
	bl ovl02_215E1EC
	mov r0, r4
	mov r1, #3
	mov r2, #1
	bl ovl02_215EFF4
_0216577C:
	add r0, r4, #0x300
	ldrh r1, [r0, #0x58]
	cmp r1, #1
	bne _021657B8
	ldrh r0, [r0, #0x74]
	tst r0, #0x20
	beq _021657A8
	ldr r0, [r4, #0x3d4]
	orr r0, r0, #2
	str r0, [r4, #0x3d4]
	b _021657B8
_021657A8:
	tst r0, #0x10
	ldrne r0, [r4, #0x3d4]
	bicne r0, r0, #2
	strne r0, [r4, #0x3d4]
_021657B8:
	mov r0, r4
	bl ovl02_215E19C
	cmp r0, #0
	beq _021657DC
	mov r0, r4
	bl ovl02_215E1EC
	mov r0, r4
	bl ovl02_2165284
	ldmia sp!, {r4, pc}
_021657DC:
	add r0, r4, #0x300
	ldrh r2, [r0, #0x58]
	cmp r2, #1
	bne _0216582C
	mov r0, r4
	bl ovl02_215F1CC
	cmp r0, #0
	beq _021658CC
	mov r0, r4
	bl ovl02_215E1EC
	ldr r0, [r4, #0x98]
	cmp r0, #0
	ldreq r0, [r4, #0xa0]
	cmpeq r0, #0
	mov r0, r4
	bne _02165824
	bl ovl02_21650F4
	ldmia sp!, {r4, pc}
_02165824:
	bl ovl02_215F16C
	b _021658CC
_0216582C:
	ldr r1, [r4, #0x98]
	cmp r1, #0
	bne _02165858
	ldrh r0, [r0, #0x74]
	tst r0, #0x30
	bne _02165858
	mov r0, r4
	bl ovl02_215E1EC
	mov r0, r4
	bl ovl02_21650F4
	ldmia sp!, {r4, pc}
_02165858:
	cmp r2, #2
	bne _02165884
	mov r0, r4
	bl ovl02_215F120
	cmp r0, #0
	beq _021658CC
	mov r0, r4
	bl ovl02_215E1EC
	mov r0, r4
	bl ovl02_215F16C
	b _021658CC
_02165884:
	cmp r2, #4
	bne _021658CC
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #0x30
	mov r0, r4
	beq _021658B0
	bl ovl02_215E1EC
	mov r0, r4
	bl ovl02_215F16C
	b _021658CC
_021658B0:
	bl ovl02_215F120
	cmp r0, #0
	beq _021658CC
	mov r0, r4
	bl ovl02_215E1EC
	mov r0, r4
	bl ovl02_21650F4
_021658CC:
	mov r0, r4
	bl ovl02_2166B48
	add r0, r4, #0x300
	ldrh r1, [r0, #0x74]
	tst r1, #2
	beq _02165900
	tst r1, #0x80
	beq _02165900
	mov r0, r4
	bl ovl02_215E1EC
	mov r0, r4
	bl ovl02_216546C
	ldmia sp!, {r4, pc}
_02165900:
	add r0, r4, #0x300
	ldrh r0, [r0, #0x78]
	tst r0, #2
	beq _02165924
	mov r0, r4
	bl ovl02_215E1EC
	mov r0, r4
	bl ovl02_21652BC
	ldmia sp!, {r4, pc}
_02165924:
	tst r1, #1
	beq _02165940
	mov r0, r4
	bl ovl02_215E1EC
	mov r0, r4
	bl ovl02_2165964
	ldmia sp!, {r4, pc}
_02165940:
	tst r1, #0x800
	ldmeqia sp!, {r4, pc}
	tst r1, #0x40
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E1EC
	mov r0, r4
	bl ovl02_2165E8C
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_21656F4

	arm_func_start ovl02_2165964
ovl02_2165964: // 0x02165964
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0x98]
	str r1, [r4, #0xc8]
	bl ovl02_2164E74
	ldr r1, [r4, #0x3d4]
	mov r0, r4
	orr r1, r1, #8
	str r1, [r4, #0x3d4]
	mov r1, #8
	mov r2, #0
	bl ovl02_215EFF4
	ldr r1, [r4, #0x1c]
	ldr r0, _021659E0 // =0xFFFF7FFE
	orr r1, r1, #0x50
	orr r1, r1, #0x20000000
	and r0, r1, r0
	str r0, [r4, #0x1c]
	add r1, r4, #0x300
	mov r2, #0x3c
	strh r2, [r1, #0xf0]
	mov r1, #0xc000
	mov r0, r4
	strh r1, [r4, #0x34]
	bl ovl02_2165078
	mov r0, r4
	bl ovl02_215F518
	ldr r0, _021659E4 // =ovl02_21659E8
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021659E0: .word 0xFFFF7FFE
_021659E4: .word ovl02_21659E8
	arm_func_end ovl02_2165964

	arm_func_start ovl02_21659E8
ovl02_21659E8: // 0x021659E8
	stmdb sp!, {r4, lr}
	ldr r1, _02165A68 // =gPlayer
	mov r4, r0
	ldr r0, [r1]
	add r3, r4, #0x3d8
	add r0, r0, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r4, #0x300
	ldrh r2, [r0, #0xf0]
	mov r0, r4
	mov r1, r3
	bl ovl02_2165024
	add r0, r4, #0x300
	ldrh r1, [r0, #0xf0]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xf0]
	mov r0, r4
	bl ovl02_215F120
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	add r1, r4, #0x3d8
	mov r2, #0
	bl ovl02_2165024
	add r0, r4, #0x300
	mov r2, #0
	ldr r1, _02165A6C // =ovl02_2165A70
	strh r2, [r0, #0xf0]
	str r1, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165A68: .word gPlayer
_02165A6C: .word ovl02_2165A70
	arm_func_end ovl02_21659E8

	arm_func_start ovl02_2165A70
ovl02_2165A70: // 0x02165A70
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r1, #0xa000
	str r1, [r4, #0xc8]
	ldr r1, [r4, #0x18]
	bic r1, r1, #1
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x1000
	bic r1, r1, #0x80
	str r1, [r4, #0x1c]
	bl ovl02_2164EB4
	mov r0, r4
	mov r1, #9
	mov r2, #1
	bl ovl02_215EFF4
	mov r2, #0
	mov r0, #0xe8
	str r2, [sp]
	sub r1, r0, #0xe9
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, _02165AE8 // =ovl02_2165AEC
	str r0, [r4, #0x3cc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165AE8: .word ovl02_2165AEC
	arm_func_end ovl02_2165A70

	arm_func_start ovl02_2165AEC
ovl02_2165AEC: // 0x02165AEC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215F218
	mov r0, r4
	add r1, r4, #0x3d8
	mov r2, #0
	bl ovl02_2164F5C
	ldr r1, _02165B8C // =0x00005555
	cmp r0, r1
	bhs _02165B20
	ldr r0, [r4, #0x1c]
	tst r0, #0xf
	ldmeqia sp!, {r4, pc}
_02165B20:
	mov r3, #0
	str r3, [r4, #0x57c]
	str r3, [r4, #0xc8]
	str r3, [r4, #0xa0]
	str r3, [r4, #0x9c]
	str r3, [r4, #0x98]
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #1
	ldrne r0, _02165B90 // =ovl02_2165BB4
	strne r0, [r4, #0x3cc]
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x18]
	ldr r1, _02165B94 // =0xDFFFEFFF
	orr r0, r0, #1
	str r0, [r4, #0x18]
	ldr r2, [r4, #0x1c]
	mov r0, r4
	and r1, r2, r1
	orr r1, r1, #0x90
	str r1, [r4, #0x1c]
	sub r1, r3, #0x3000
	str r1, [r4, #0x9c]
	bl ovl02_2164E74
	ldr r0, _02165B98 // =ovl02_2165B9C
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165B8C: .word 0x00005555
_02165B90: .word ovl02_2165BB4
_02165B94: .word 0xDFFFEFFF
_02165B98: .word ovl02_2165B9C
	arm_func_end ovl02_2165AEC

	arm_func_start ovl02_2165B9C
ovl02_2165B9C: // 0x02165B9C
	ldr r1, [r0, #0x1c]
	tst r1, #1
	ldrne r1, _02165BB0 // =ovl02_2165CFC
	strne r1, [r0, #0x3cc]
	bx lr
	.align 2, 0
_02165BB0: .word ovl02_2165CFC
	arm_func_end ovl02_2165B9C

	arm_func_start ovl02_2165BB4
ovl02_2165BB4: // 0x02165BB4
	stmdb sp!, {r4, lr}
	mov r1, #0
	mov r4, r0
	str r1, [r4, #0xc8]
	str r1, [r4, #0xa0]
	str r1, [r4, #0x9c]
	str r1, [r4, #0x98]
	bl ovl02_2164E74
	mov r0, r4
	mov r1, #0xa
	mov r2, #1
	bl ovl02_215EFF4
	ldr r1, [r4, #0x1c]
	ldr r0, _02165C2C // =0xFFFF7FFE
	orr r1, r1, #0x50
	orr r1, r1, #0x20000000
	and r0, r1, r0
	str r0, [r4, #0x1c]
	add r0, r4, #0x300
	mov r1, #0x1e
	strh r1, [r0, #0xf0]
	mov r0, #0xc000
	strh r0, [r4, #0x34]
	mov r2, #0
	str r2, [r4, #0x57c]
	add r0, r4, #0x500
	ldr r1, _02165C30 // =ovl02_2165C34
	strh r2, [r0, #0x80]
	str r1, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165C2C: .word 0xFFFF7FFE
_02165C30: .word ovl02_2165C34
	arm_func_end ovl02_2165BB4

	arm_func_start ovl02_2165C34
ovl02_2165C34: // 0x02165C34
	ldr r1, [r0, #0x57c]
	add r2, r0, #0x300
	add r1, r1, #0x238
	add r1, r1, #0xc00
	str r1, [r0, #0x57c]
	ldrh r1, [r2, #0xf0]
	cmp r1, #0
	subne r0, r1, #1
	strneh r0, [r2, #0xf0]
	bxne lr
	mov r3, #0
	ldr r1, _02165C70 // =ovl02_2165C74
	strh r3, [r2, #0xf0]
	str r1, [r0, #0x3cc]
	bx lr
	.align 2, 0
_02165C70: .word ovl02_2165C74
	arm_func_end ovl02_2165C34

	arm_func_start ovl02_2165C74
ovl02_2165C74: // 0x02165C74
	stmdb sp!, {r4, lr}
	ldr r1, _02165CF4 // =gPlayer
	mov r4, r0
	ldr r0, [r1]
	add r3, r4, #0x3d8
	add r0, r0, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r4, #0x300
	ldrh r2, [r0, #0xf0]
	mov r0, r4
	mov r1, r3
	bl ovl02_2165024
	add r0, r4, #0x300
	ldrh r1, [r0, #0xf0]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xf0]
	mov r0, r4
	bl ovl02_215F120
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	add r1, r4, #0x3d8
	mov r2, #0
	bl ovl02_2165024
	add r0, r4, #0x300
	mov r2, #0
	ldr r1, _02165CF8 // =ovl02_2165A70
	strh r2, [r0, #0xf0]
	str r1, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165CF4: .word gPlayer
_02165CF8: .word ovl02_2165A70
	arm_func_end ovl02_2165C74

	arm_func_start ovl02_2165CFC
ovl02_2165CFC: // 0x02165CFC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r2, #0
	str r2, [r4, #0x98]
	add r1, r4, #0x500
	strh r2, [r1, #0x80]
	ldr r1, [r4, #0x1c]
	bic r1, r1, #0x20000000
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x3d4]
	orr r1, r1, #8
	str r1, [r4, #0x3d4]
	bl ovl02_21650D0
	mov r0, r4
	bl ovl02_2164E74
	mov r0, r4
	mov r1, #0xb
	mov r2, #0
	bl ovl02_215EFF4
	ldr r0, _02165D54 // =ovl02_2165D58
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165D54: .word ovl02_2165D58
	arm_func_end ovl02_2165CFC

	arm_func_start ovl02_2165D58
ovl02_2165D58: // 0x02165D58
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215F120
	cmp r0, #0
	ldrne r0, _02165D74 // =ovl02_2165D78
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165D74: .word ovl02_2165D78
	arm_func_end ovl02_2165D58

	arm_func_start ovl02_2165D78
ovl02_2165D78: // 0x02165D78
	stmdb sp!, {r4, lr}
	mov r1, #0xc
	mov r2, #1
	mov r4, r0
	bl ovl02_215EFF4
	ldr r0, _02165D98 // =ovl02_2165D9C
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165D98: .word ovl02_2165D9C
	arm_func_end ovl02_2165D78

	arm_func_start ovl02_2165D9C
ovl02_2165D9C: // 0x02165D9C
	add r1, r0, #0x300
	ldrh r1, [r1, #0x74]
	tst r1, #0x80
	ldreq r1, _02165DB4 // =ovl02_2165DB8
	streq r1, [r0, #0x3cc]
	bx lr
	.align 2, 0
_02165DB4: .word ovl02_2165DB8
	arm_func_end ovl02_2165D9C

	arm_func_start ovl02_2165DB8
ovl02_2165DB8: // 0x02165DB8
	stmdb sp!, {r4, lr}
	mov r1, #0xd
	mov r2, #0
	mov r4, r0
	bl ovl02_215EFF4
	ldr r0, _02165DD8 // =ovl02_2165DDC
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165DD8: .word ovl02_2165DDC
	arm_func_end ovl02_2165DB8

	arm_func_start ovl02_2165DDC
ovl02_2165DDC: // 0x02165DDC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215F120
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x3d4]
	mov r0, r4
	bic r1, r1, #8
	str r1, [r4, #0x3d4]
	bl ovl02_21650F4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2165DDC

	arm_func_start ovl02_2165E08
ovl02_2165E08: // 0x02165E08
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	add r0, r4, #0x1b8
	add r0, r0, #0x800
	add ip, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r0, [sp, #4]
	add r3, r4, #0x44
	rsb r0, r0, #0
	str r0, [sp, #4]
	ldmia ip, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r4
	mov r1, #0x18
	mov r2, #1
	bl ovl02_215EFF4
	ldr r0, _02165E88 // =gPlayer
	add ip, r4, #0x3d8
	ldr r0, [r0]
	mov r3, #0xf000
	add r0, r0, #0x44
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	mov r0, r4
	mov r1, ip
	mov r2, #0
	str r3, [r4, #0xc8]
	bl ovl02_2165024
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02165E88: .word gPlayer
	arm_func_end ovl02_2165E08

	arm_func_start ovl02_2165E8C
ovl02_2165E8C: // 0x02165E8C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0
	str r0, [r4, #0x98]
	str r0, [r4, #0xc8]
	ldr r0, [r4, #0x370]
	add r3, r4, #0x3d8
	ldr r0, [r0, #0x370]
	add r0, r0, #0x9b0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x3dc]
	mov r0, r4
	rsb r1, r1, #0
	str r1, [r4, #0x3dc]
	bl ovl02_2164EF4
	mov r0, r4
	mov r1, #0x14
	mov r2, #0
	bl ovl02_215EFF4
	ldr r1, [r4, #0x1c]
	ldr r0, _02165F1C // =0xFFFF7FFE
	orr r1, r1, #0x50
	orr r1, r1, #0x20000000
	and r0, r1, r0
	str r0, [r4, #0x1c]
	add r1, r4, #0x300
	mov r2, #0x3c
	strh r2, [r1, #0xf0]
	mov r1, #0xc000
	mov r0, r4
	strh r1, [r4, #0x34]
	bl ovl02_2165078
	ldr r0, _02165F20 // =ovl02_2165F24
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165F1C: .word 0xFFFF7FFE
_02165F20: .word ovl02_2165F24
	arm_func_end ovl02_2165E8C

	arm_func_start ovl02_2165F24
ovl02_2165F24: // 0x02165F24
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r2, [r1, #0xf0]
	add r1, r4, #0x3d8
	bl ovl02_2165024
	add r0, r4, #0x300
	ldrh r1, [r0, #0xf0]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xf0]
	mov r0, r4
	bl ovl02_215F120
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	add r1, r4, #0x3d8
	mov r2, #0
	bl ovl02_2165024
	add r0, r4, #0x300
	mov r2, #0
	ldr r1, _02165F88 // =ovl02_2165F8C
	strh r2, [r0, #0xf0]
	str r1, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165F88: .word ovl02_2165F8C
	arm_func_end ovl02_2165F24

	arm_func_start ovl02_2165F8C
ovl02_2165F8C: // 0x02165F8C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r1, #0xa000
	str r1, [r4, #0xc8]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x1000
	bic r1, r1, #0x80
	str r1, [r4, #0x1c]
	bl ovl02_2164EF4
	mov r0, r4
	mov r1, #0x15
	mov r2, #1
	bl ovl02_215EFF4
	mov r2, #0
	mov r0, #0xe8
	str r2, [sp]
	sub r1, r0, #0xe9
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, _02165FF8 // =ovl02_2165FFC
	str r0, [r4, #0x3cc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165FF8: .word ovl02_2165FFC
	arm_func_end ovl02_2165F8C

	arm_func_start ovl02_2165FFC
ovl02_2165FFC: // 0x02165FFC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215F218
	mov r0, r4
	add r1, r4, #0x3d8
	mov r2, #0
	bl ovl02_2164F5C
	ldr r1, _02166064 // =0x00005555
	cmp r0, r1
	ldmloia sp!, {r4, pc}
	mov r1, #0
	str r1, [r4, #0x57c]
	add r0, r4, #0x500
	strh r1, [r0, #0x80]
	str r1, [r4, #0xc8]
	str r1, [r4, #0xa0]
	str r1, [r4, #0x9c]
	mov r0, r4
	str r1, [r4, #0x98]
	bl ovl02_21650D0
	add r0, r4, #0x500
	mov r2, #0x1e
	ldr r1, _02166068 // =ovl02_216606C
	strh r2, [r0, #0x84]
	str r1, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166064: .word 0x00005555
_02166068: .word ovl02_216606C
	arm_func_end ovl02_2165FFC

	arm_func_start ovl02_216606C
ovl02_216606C: // 0x0216606C
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	add r0, r4, #0x500
	ldrh r1, [r0, #0x84]
	mov r5, #0
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x84]
	ldr r0, [r4, #0x370]
	moveq r5, #1
	bl ovl02_215E228
	cmp r0, #0
	beq _021660A8
	cmp r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
_021660A8:
	ldr r2, [r4, #0x1c]
	ldr r0, _021660D4 // =0xDFFFEFFE
	mov r1, #0x3000
	and r0, r2, r0
	orr r0, r0, #0x90
	str r0, [r4, #0x1c]
	rsb r1, r1, #0
	ldr r0, _021660D8 // =ovl02_2166358
	str r1, [r4, #0x9c]
	str r0, [r4, #0x3cc]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021660D4: .word 0xDFFFEFFE
_021660D8: .word ovl02_2166358
	arm_func_end ovl02_216606C

	arm_func_start ovl02_21660DC
ovl02_21660DC: // 0x021660DC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x370]
	mov r1, #0
	ldr r2, [r0, #0x370]
	add r0, r4, #0x500
	str r1, [r4, #0xa0]
	str r1, [r4, #0x9c]
	str r1, [r4, #0x98]
	str r1, [r4, #0xc8]
	str r1, [r4, #0xc4]
	str r1, [r4, #0xc0]
	str r1, [r4, #0xbc]
	strh r1, [r0, #0x80]
	str r1, [r4, #0x57c]
	ldr r0, [r2, #0x20]
	tst r0, #1
	ldr r0, [r4, #0x20]
	orrne r0, r0, #1
	biceq r0, r0, #1
	str r0, [r4, #0x20]
	mov r0, r4
	bl ovl02_2164EF4
	mov r0, r4
	mov r1, #0x16
	mov r2, #0
	bl ovl02_215EFF4
	mov r0, r4
	bl ovl02_21650D0
	ldr r0, _0216615C // =ovl02_2166160
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216615C: .word ovl02_2166160
	arm_func_end ovl02_21660DC

	arm_func_start ovl02_2166160
ovl02_2166160: // 0x02166160
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215F120
	cmp r0, #0
	ldrne r0, _0216617C // =ovl02_2166180
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216617C: .word ovl02_2166180
	arm_func_end ovl02_2166160

	arm_func_start ovl02_2166180
ovl02_2166180: // 0x02166180
	stmdb sp!, {r4, lr}
	mov r1, #0x17
	mov r2, #0
	mov r4, r0
	bl ovl02_215EFF4
	ldr r0, _021661A0 // =ovl02_21661A4
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021661A0: .word ovl02_21661A4
	arm_func_end ovl02_2166180

	arm_func_start ovl02_21661A4
ovl02_21661A4: // 0x021661A4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215F120
	cmp r0, #0
	ldrne r0, _021661C0 // =ovl02_21661C4
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021661C0: .word ovl02_21661C4
	arm_func_end ovl02_21661A4

	arm_func_start ovl02_21661C4
ovl02_21661C4: // 0x021661C4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r2, [r4, #0x18]
	ldr r1, _02166240 // =0x20004050
	bic r2, r2, #1
	str r2, [r4, #0x18]
	ldr r3, [r4, #0x1c]
	ldr r2, _02166244 // =0xFFFF6F7E
	orr r1, r3, r1
	and r1, r1, r2
	str r1, [r4, #0x1c]
	bl ovl02_2165E08
	mov r0, r4
	bl ovl02_2164EB4
	ldr r2, [r4, #0x3d4]
	mov r0, #0xe8
	orr r2, r2, #0x200
	str r2, [r4, #0x3d4]
	mov r2, #0
	str r2, [sp]
	sub r1, r0, #0xe9
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, _02166248 // =ovl02_216624C
	str r0, [r4, #0x3cc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166240: .word 0x20004050
_02166244: .word 0xFFFF6F7E
_02166248: .word ovl02_216624C
	arm_func_end ovl02_21661C4

	arm_func_start ovl02_216624C
ovl02_216624C: // 0x0216624C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl ovl02_215F218
	ldr r0, [r4, #0x1c]
	tst r0, #0xf
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x3d4]
	mov r0, #0xec
	orr r1, r1, #0x100
	str r1, [r4, #0x3d4]
	mov r1, #0
	str r1, [sp]
	sub r1, r0, #0xed
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x1c]
	tst r0, #0xc
	beq _021662CC
	bic r0, r0, #0xc
	str r0, [r4, #0x1c]
	ldrh r0, [r4, #0x34]
	mov r1, r4
	rsb r0, r0, #0x8000
	strh r0, [r4, #0x34]
	ldr r0, [r4, #0x370]
	bl ovl02_215E7E4
	b _021662DC
_021662CC:
	tst r0, #3
	ldrneh r0, [r4, #0x34]
	rsbne r0, r0, #0
	strneh r0, [r4, #0x34]
_021662DC:
	mov r1, #0
	str r1, [r4, #0xbc]
	str r1, [r4, #0xc0]
	mov r0, r4
	str r1, [r4, #0xc4]
	bl ovl02_2165068
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #0x800
	beq _02166310
	tst r0, #0x40
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
_02166310:
	ldr r1, [r4, #0x18]
	mov r0, #0x3000
	orr r1, r1, #1
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x1c]
	rsb r0, r0, #0
	bic r1, r1, #0x20000001
	orr r1, r1, #0x90
	str r1, [r4, #0x1c]
	str r0, [r4, #0x9c]
	ldr r1, [r4, #0x3d4]
	ldr r0, _02166354 // =ovl02_2166358
	bic r1, r1, #0x200
	str r1, [r4, #0x3d4]
	str r0, [r4, #0x3cc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166354: .word ovl02_2166358
	arm_func_end ovl02_216624C

	arm_func_start ovl02_2166358
ovl02_2166358: // 0x02166358
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215F218
	ldr r0, [r4, #0x1c]
	tst r0, #0xf
	ldrne r0, _02166378 // =ovl02_216637C
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166378: .word ovl02_216637C
	arm_func_end ovl02_2166358

	arm_func_start ovl02_216637C
ovl02_216637C: // 0x0216637C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r2, #0
	str r2, [r4, #0xc8]
	add r1, r4, #0x500
	strh r2, [r1, #0x80]
	str r2, [r4, #0x57c]
	mov r1, #0xc000
	strh r1, [r4, #0x34]
	ldr r2, [r4, #0x3d4]
	ldr r1, _021663DC // =0xDFFFBFFF
	orr r2, r2, #8
	str r2, [r4, #0x3d4]
	ldr r2, [r4, #0x1c]
	and r1, r2, r1
	str r1, [r4, #0x1c]
	bl ovl02_2164E74
	mov r0, r4
	mov r1, #0x19
	mov r2, #0
	bl ovl02_215EFF4
	ldr r0, _021663E0 // =ovl02_21663E4
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021663DC: .word 0xDFFFBFFF
_021663E0: .word ovl02_21663E4
	arm_func_end ovl02_216637C

	arm_func_start ovl02_21663E4
ovl02_21663E4: // 0x021663E4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215F120
	cmp r0, #0
	ldrne r0, _02166400 // =ovl02_2166404
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166400: .word ovl02_2166404
	arm_func_end ovl02_21663E4

	arm_func_start ovl02_2166404
ovl02_2166404: // 0x02166404
	stmdb sp!, {r4, lr}
	mov r1, #0x1a
	mov r2, #1
	mov r4, r0
	bl ovl02_215EFF4
	ldr r0, _02166424 // =ovl02_2166428
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166424: .word ovl02_2166428
	arm_func_end ovl02_2166404

	arm_func_start ovl02_2166428
ovl02_2166428: // 0x02166428
	add r1, r0, #0x300
	ldrh r1, [r1, #0x74]
	tst r1, #0x80
	ldreq r1, _02166440 // =ovl02_2166444
	streq r1, [r0, #0x3cc]
	bx lr
	.align 2, 0
_02166440: .word ovl02_2166444
	arm_func_end ovl02_2166428

	arm_func_start ovl02_2166444
ovl02_2166444: // 0x02166444
	stmdb sp!, {r4, lr}
	mov r1, #0x1b
	mov r2, #0
	mov r4, r0
	bl ovl02_215EFF4
	ldr r0, _02166464 // =ovl02_2166468
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166464: .word ovl02_2166468
	arm_func_end ovl02_2166444

	arm_func_start ovl02_2166468
ovl02_2166468: // 0x02166468
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215F120
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x3d4]
	mov r0, r4
	bic r1, r1, #8
	str r1, [r4, #0x3d4]
	bl ovl02_21650F4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2166468

	arm_func_start ovl02_2166494
ovl02_2166494: // 0x02166494
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x500
	mov r2, #0
	strh r2, [r1, #0x80]
	str r2, [r4, #0x57c]
	bl ovl02_2164E74
	ldr r0, [r4, #0x20]
	mov r2, #0
	tst r0, #1
	mov r0, #0x3000
	rsbne r0, r0, #0
	strne r0, [r4, #0x98]
	streq r0, [r4, #0x98]
	subeq r0, r0, #0x6000
	str r0, [r4, #0x9c]
	strh r2, [r4, #0x34]
	ldr r1, [r4, #0x1c]
	ldr r0, _02166544 // =0xDFFFAFBF
	orr r1, r1, #0x90
	orr r1, r1, #0x8000
	and r0, r1, r0
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x18]
	add r1, r4, #0x300
	orr r0, r0, #1
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x1c]
	mov r3, #0x78
	bic r0, r0, #0x1000
	str r0, [r4, #0x1c]
	ldr ip, [r4, #0x3d4]
	mov r0, r4
	bic ip, ip, #8
	str ip, [r4, #0x3d4]
	strh r3, [r1, #0x50]
	ldr r3, [r4, #0x3d4]
	mov r1, #0x11
	orr r3, r3, #0x30
	str r3, [r4, #0x3d4]
	bl ovl02_215EFF4
	ldr r0, _02166548 // =ovl02_216654C
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166544: .word 0xDFFFAFBF
_02166548: .word ovl02_216654C
	arm_func_end ovl02_2166494

	arm_func_start ovl02_216654C
ovl02_216654C: // 0x0216654C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215F120
	cmp r0, #0
	ldrne r0, _02166568 // =ovl02_216656C
	strne r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166568: .word ovl02_216656C
	arm_func_end ovl02_216654C

	arm_func_start ovl02_216656C
ovl02_216656C: // 0x0216656C
	stmdb sp!, {r4, lr}
	mov r1, #0x12
	mov r2, #1
	mov r4, r0
	bl ovl02_215EFF4
	ldr r0, _0216658C // =ovl02_2166590
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216658C: .word ovl02_2166590
	arm_func_end ovl02_216656C

	arm_func_start ovl02_2166590
ovl02_2166590: // 0x02166590
	ldr r1, [r0, #0x1c]
	tst r1, #1
	bxeq lr
	mov r2, #0
	ldr r1, _021665B0 // =ovl02_21665B4
	str r2, [r0, #0x98]
	str r1, [r0, #0x3cc]
	bx lr
	.align 2, 0
_021665B0: .word ovl02_21665B4
	arm_func_end ovl02_2166590

	arm_func_start ovl02_21665B4
ovl02_21665B4: // 0x021665B4
	stmdb sp!, {r4, lr}
	mov r1, #0x13
	mov r2, #0
	mov r4, r0
	bl ovl02_215EFF4
	ldr r0, _021665D4 // =ovl02_21665D8
	str r0, [r4, #0x3cc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021665D4: .word ovl02_21665D8
	arm_func_end ovl02_21665B4

	arm_func_start ovl02_21665D8
ovl02_21665D8: // 0x021665D8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215F120
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x3d4]
	mov r0, r4
	bic r1, r1, #0x10
	str r1, [r4, #0x3d4]
	bl ovl02_21650F4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_21665D8

	arm_func_start ovl02_2166604
ovl02_2166604: // 0x02166604
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	add r5, r4, #0x188
	ldr r2, _021666BC // =0x0000040A
	add r0, r5, #0x400
	mov r1, #0
	bl MI_CpuFill8
	ldr r0, [r4, #0x414]
	bic r0, r0, #4
	str r0, [r4, #0x414]
	ldr r0, [r4, #0x454]
	bic r0, r0, #4
	str r0, [r4, #0x454]
	ldr r0, [r4, #0x494]
	bic r0, r0, #4
	str r0, [r4, #0x494]
	ldr r0, [r4, #0x4d4]
	bic r0, r0, #4
	str r0, [r4, #0x4d4]
	ldr r0, [r4, #0x514]
	bic r0, r0, #4
	str r0, [r4, #0x514]
	ldr r0, [r4, #0x554]
	bic r0, r0, #4
	str r0, [r4, #0x554]
	ldr r0, [r4, #0x48]
	cmp r0, #0x1c0000
	movle r1, #1
	ldr r0, [r4, #0x370]
	movgt r1, #0
	str r1, [r0, #0x3fc]
	ldr r0, [r4, #0x370]
	bl ovl02_215FCEC
	ldr r0, _021666C0 // =VRAMSystem__VRAM_PALETTE_BG
	add r1, r5, #0x400
	ldr r0, [r0]
	mov r2, #0x200
	bl MIi_CpuCopyFast
	mov r0, r4
	bl ovl02_215DFD8
	add r0, r5, #0x800
	mov r2, #0
	ldr r1, _021666C4 // =ovl02_21666C8
	strh r2, [r0, #8]
	str r1, [r4, #0x3cc]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021666BC: .word 0x0000040A
_021666C0: .word VRAMSystem__VRAM_PALETTE_BG
_021666C4: .word ovl02_21666C8
	arm_func_end ovl02_2166604

	arm_func_start ovl02_21666C8
ovl02_21666C8: // 0x021666C8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	ldr r5, [r8, #0x370]
	add r4, r8, #0x188
	bl Camera3D__GetWork
	mov r6, #0
	add r2, r5, #0x300
	ldr r3, [r5, #0x3fc]
	mov r1, #0x5c
	mla r0, r3, r1, r0
	ldrsh r3, [r2, #0xd8]
	sub r1, r6, #0x10
	mov r7, r6
	cmp r3, r1
	beq _02166734
	add r1, r4, #0x800
	ldrh r3, [r1, #2]
	add r3, r3, #1
	strh r3, [r1, #2]
	ldrh r3, [r1, #2]
	cmp r3, #1
	bls _02166738
	strh r6, [r1, #2]
	ldrsh r1, [r2, #0xd8]
	sub r1, r1, #1
	strh r1, [r2, #0xd8]
	b _02166738
_02166734:
	mov r6, #1
_02166738:
	ldrh r1, [r0, #0x24]
	cmp r1, #0x10
	bhs _02166778
	add r1, r4, #0x800
	ldrh r2, [r1]
	add r2, r2, #1
	strh r2, [r1]
	ldrh r2, [r1]
	cmp r2, #2
	bls _0216677C
	mov r2, #0
	strh r2, [r1]
	ldrh r1, [r0, #0x24]
	add r1, r1, #1
	strh r1, [r0, #0x24]
	b _0216677C
_02166778:
	mov r7, #1
_0216677C:
	add r1, r8, #0x188
	mov r0, r5
	add r1, r1, #0x400
	bl ovl02_216002C
	add r0, r4, #0x800
	ldrh r2, [r0, #8]
	add r1, r2, #1
	strh r1, [r0, #8]
	cmp r2, #0x78
	ldmlsia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r6, #0
	cmpne r7, #0
	ldrne r0, _021667B8 // =ovl02_21667BC
	strne r0, [r8, #0x3cc]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021667B8: .word ovl02_21667BC
	arm_func_end ovl02_21666C8

	arm_func_start ovl02_21667BC
ovl02_21667BC: // 0x021667BC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r4, r0
	add r0, r4, #0x1b8
	add r0, r0, #0x800
	add r3, sp, #8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r3
	add r5, r4, #0x188
	bl ovl02_215F710
	mov r3, #0x8c
	sub r1, r3, #0x8d
	mov r0, #0
	stmia sp, {r0, r3}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, _021668CC // =gPlayer
	ldr r1, [r4, #0x44]
	ldr r0, [r0]
	ldr r0, [r0, #0x44]
	cmp r0, r1
	mov r0, #0x8000
	strlt r0, [r4, #0x98]
	sublt r0, r0, #0x10000
	rsbge r0, r0, #0
	strge r0, [r4, #0x98]
	str r0, [r4, #0x9c]
	mov r0, #0
	str r0, [r4, #0xa0]
	ldr r1, [r4, #0x1c]
	ldr r0, _021668D0 // =0xFFF7DFFE
	orr r1, r1, #0x90
	orr r1, r1, #0x9000
	and r1, r1, r0
	mov r0, r4
	str r1, [r4, #0x1c]
	bl ovl02_215F208
	ldr r0, [r4, #0x370]
	bl ovl02_215FEC4
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x370]
	cmp r0, #0
	bne _02166888
	ldr r0, _021668CC // =gPlayer
	ldr r0, [r0]
	bl BossHelpers__Player__LockControl
	ldr r0, [r4, #0x370]
	bl ovl02_216034C
	b _02166898
_02166888:
	ldr r0, _021668D4 // =playerGameStatus
	ldr r1, [r0]
	orr r1, r1, #1
	str r1, [r0]
_02166898:
	ldr r1, _021668CC // =gPlayer
	mov r0, r4
	ldr r1, [r1]
	bl ovl02_215E16C
	ldr r1, _021668D8 // =ovl02_21668DC
	add r0, r5, #0x800
	mov r2, #0
	strh r2, [r0, #8]
	mov r0, r4
	str r1, [r4, #0x3cc]
	blx r1
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_021668CC: .word gPlayer
_021668D0: .word 0xFFF7DFFE
_021668D4: .word playerGameStatus
_021668D8: .word ovl02_21668DC
	arm_func_end ovl02_21667BC

	arm_func_start ovl02_21668DC
ovl02_21668DC: // 0x021668DC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	mov sb, r0
	ldr r5, [sb, #0x370]
	add r4, sb, #0x188
	bl Camera3D__GetWork
	add r1, r5, #0x300
	ldrsh r2, [r1, #0xd8]
	mov r6, r0
	mov r7, #0
	cmp r2, #0
	addne r0, r2, #1
	strneh r0, [r1, #0xd8]
	mov r8, r7
	ldr r0, [r5, #0x370]
	moveq r7, #1
	cmp r0, #0
	beq _0216692C
	bl ovl02_215DB5C
	cmp r0, #0
	beq _02166934
_0216692C:
	mov r1, #0x10
	b _02166938
_02166934:
	mov r1, #0
_02166938:
	ldrsh r0, [r6, #0x58]
	cmp r0, r1
	bge _02166990
	add r0, r4, #0x800
	ldrh r1, [r0, #8]
	cmp r1, #0x3c
	bls _02166994
	ldrh r1, [r0, #6]
	add r1, r1, #1
	strh r1, [r0, #6]
	ldrh r1, [r0, #6]
	cmp r1, #3
	bls _02166994
	ldrsh r2, [r6, #0x58]
	mov r1, #0
	add r2, r2, #1
	strh r2, [r6, #0x58]
	ldrsh r2, [r6, #0xb4]
	add r2, r2, #1
	strh r2, [r6, #0xb4]
	strh r1, [r0, #6]
	b _02166994
_02166990:
	mov r8, #1
_02166994:
	add r1, sb, #0x188
	mov r0, r5
	add r1, r1, #0x400
	bl ovl02_216002C
	add r0, r4, #0x800
	ldrh r1, [r0, #8]
	cmp r7, #0
	cmpne r8, #0
	add r1, r1, #1
	strh r1, [r0, #8]
	ldrne r0, _021669C8 // =ovl02_21669CC
	strne r0, [sb, #0x3cc]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_021669C8: .word ovl02_21669CC
	arm_func_end ovl02_21668DC

	arm_func_start ovl02_21669CC
ovl02_21669CC: // 0x021669CC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x370]
	cmp r0, #0
	beq _021669F0
	bl ovl02_215DB5C
	cmp r0, #0
	beq _02166A08
_021669F0:
	bl StopStageBGM
	ldr r0, _02166B44 // =playerGameStatus
	ldr r1, [r0]
	orr r1, r1, #4
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02166A08:
	ldr r0, [r4, #0x370]
	mov r1, #0
	str r1, [r0, #0x374]
	ldr r1, [r4, #0x18]
	mov r0, #2
	orr r1, r1, #4
	str r1, [r4, #0x18]
	bl SetActiveBossHealthbar
	ldr r0, [r4, #0x370]
	ldr r0, [r0, #0x370]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0xd2]
	sub r0, r0, #1
	bl UpdateBossHealthHUD
	ldr r0, [r4, #0x370]
	bl ovl02_215E0BC
	bl Camera3D__GetWork
	mov r4, r0
	bl Camera3D__GetWork
	mov r1, #0
	strh r1, [r4, #0x20]
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	bic r1, r1, #1
	orr r1, r1, #1
	strh r1, [r4, #0x20]
	ldrh r1, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	mov r1, r1, lsl #0x1f
	mov r1, r1, lsr #0x1f
	bic r2, r2, #1
	and r1, r1, #1
	orr r1, r2, r1
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	orr r1, r1, #0x200
	strh r1, [r4, #0x20]
	ldrh r1, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	mov r1, r1, lsl #0x16
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x200
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #22
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	orr r1, r1, #0x400
	strh r1, [r4, #0x20]
	ldrh r1, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	mov r1, r1, lsl #0x15
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x400
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #21
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	orr r1, r1, #0x800
	strh r1, [r4, #0x20]
	ldrh r1, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	mov r1, r1, lsl #0x14
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x800
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #20
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	orr r1, r1, #0x1000
	strh r1, [r4, #0x20]
	ldrh r1, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	mov r1, r1, lsl #0x13
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x1000
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #19
	strh r1, [r0, #0x7c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166B44: .word playerGameStatus
	arm_func_end ovl02_21669CC

	arm_func_start ovl02_2166B48
ovl02_2166B48: // 0x02166B48
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x300
	ldrh r1, [r0, #0x74]
	tst r1, #0x30
	beq _02166BF0
	tst r1, #0x10
	ldrh r0, [r0, #0x58]
	beq _02166BAC
	cmp r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	ldr r0, [r4, #0x98]
	cmp r0, #0
	bge _02166B94
	mov r1, #0x100
	bl ObjSpdDownSet
	str r0, [r4, #0x98]
_02166B94:
	ldr r0, [r4, #0x98]
	mov r1, #0x400
	mov r2, #0x3000
	bl ObjSpdUpSet
	str r0, [r4, #0x98]
	ldmia sp!, {r4, pc}
_02166BAC:
	cmp r0, #1
	ldrne r0, [r4, #0x20]
	bicne r0, r0, #1
	strne r0, [r4, #0x20]
	ldr r0, [r4, #0x98]
	cmp r0, #0
	ble _02166BD4
	mov r1, #0x100
	bl ObjSpdDownSet
	str r0, [r4, #0x98]
_02166BD4:
	mov r1, #0x400
	ldr r0, [r4, #0x98]
	rsb r1, r1, #0
	mov r2, #0x3000
	bl ObjSpdUpSet
	str r0, [r4, #0x98]
	ldmia sp!, {r4, pc}
_02166BF0:
	ldrh r0, [r4, #0x34]
	add r0, r0, #0x2000
	and r0, r0, #0xff00
	cmp r0, #0x4000
	ldmgtia sp!, {r4, pc}
	ldr r0, [r4, #0x98]
	mov r1, #0x100
	bl ObjSpdDownSet
	str r0, [r4, #0x98]
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2166B48

	arm_func_start ovl02_2166C18
ovl02_2166C18: // 0x02166C18
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x300
	ldrh r0, [r0, #0x74]
	tst r0, #0x30
	beq _02166CB0
	tst r0, #0x10
	ldr r0, [r4, #0x20]
	beq _02166C74
	orr r0, r0, #1
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x98]
	cmp r0, #0
	bge _02166C5C
	mov r1, #0x100
	bl ObjSpdDownSet
	str r0, [r4, #0x98]
_02166C5C:
	ldr r0, [r4, #0x98]
	mov r1, #0x400
	mov r2, #0x3000
	bl ObjSpdUpSet
	str r0, [r4, #0x98]
	ldmia sp!, {r4, pc}
_02166C74:
	bic r0, r0, #1
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x98]
	cmp r0, #0
	ble _02166C94
	mov r1, #0x100
	bl ObjSpdDownSet
	str r0, [r4, #0x98]
_02166C94:
	mov r1, #0x400
	ldr r0, [r4, #0x98]
	rsb r1, r1, #0
	mov r2, #0x3000
	bl ObjSpdUpSet
	str r0, [r4, #0x98]
	ldmia sp!, {r4, pc}
_02166CB0:
	mov r1, #0x3000
	ldr r0, [r4, #0x98]
	rsb r1, r1, #0
	cmp r0, r1
	movlt r0, r1
	blt _02166CD0
	cmp r0, #0x3000
	movgt r0, #0x3000
_02166CD0:
	mov r1, #0x100
	str r0, [r4, #0x98]
	bl ObjSpdDownSet
	str r0, [r4, #0x98]
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2166C18

	arm_func_start ovl02_2166CE4
ovl02_2166CE4: // 0x02166CE4
	ldr r2, _02166D60 // =gPlayer
	ldr r3, [r0, #0x44]
	ldr r2, [r2]
	ldr r2, [r2, #0x44]
	subs r3, r2, r3
	ldr r2, _02166D64 // =_021796D8
	rsbmi r3, r3, #0
	ldr r1, [r2, r1, lsl #2]
	cmp r3, r1
	bgt _02166D2C
	add r1, r0, #0x300
	ldrh r2, [r1, #0xee]
	cmp r2, #0
	subne r2, r2, #1
	strneh r2, [r1, #0xee]
	bne _02166D2C
	mov r0, #0
	bx lr
_02166D2C:
	ldr r1, _02166D60 // =gPlayer
	ldr r2, [r0, #0x44]
	ldr r1, [r1]
	add r0, r0, #0x300
	ldr r1, [r1, #0x44]
	cmp r1, r2
	ldrgth r1, [r0, #0xd0]
	orrgt r1, r1, #0x10
	ldrleh r1, [r0, #0xd0]
	orrle r1, r1, #0x20
	strh r1, [r0, #0xd0]
	mov r0, #1
	bx lr
	.align 2, 0
_02166D60: .word gPlayer
_02166D64: .word _021796D8
	arm_func_end ovl02_2166CE4

	arm_func_start ovl02_2166D68
ovl02_2166D68: // 0x02166D68
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EA68
	add r1, r4, #0x300
	ldr r2, _02166D88 // =ovl02_2166D8C
	strh r0, [r1, #0xe4]
	str r2, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166D88: .word ovl02_2166D8C
	arm_func_end ovl02_2166D68

	arm_func_start ovl02_2166D8C
ovl02_2166D8C: // 0x02166D8C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x370]
	ldr r1, [r1, #0x3e0]
	cmp r1, #0
	ldmneia sp!, {r4, pc}
	ldr r1, _02166E50 // =gPlayer
	ldr r2, [r4, #0x44]
	ldr r1, [r1]
	ldr r1, [r1, #0x44]
	cmp r1, r2
	ble _02166DE8
	ldr r1, [r4, #0x20]
	tst r1, #1
	bne _02166DE8
	bl ovl02_215E448
	cmp r0, #0
	bne _02166DE8
	add r0, r4, #0x300
	ldrh r1, [r0, #0xd0]
	orr r1, r1, #0x10
	strh r1, [r0, #0xd0]
	b _02166E2C
_02166DE8:
	ldr r0, _02166E50 // =gPlayer
	ldr r1, [r4, #0x44]
	ldr r0, [r0]
	ldr r0, [r0, #0x44]
	cmp r0, r1
	bge _02166E2C
	ldr r0, [r4, #0x20]
	tst r0, #1
	beq _02166E2C
	mov r0, r4
	bl ovl02_215E448
	cmp r0, #0
	bne _02166E2C
	add r0, r4, #0x300
	ldrh r1, [r0, #0xd0]
	orr r1, r1, #0x20
	strh r1, [r0, #0xd0]
_02166E2C:
	add r0, r4, #0x300
	ldrh r1, [r0, #0xe4]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe4]
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E298
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166E50: .word gPlayer
	arm_func_end ovl02_2166D8C

	arm_func_start ovl02_2166E54
ovl02_2166E54: // 0x02166E54
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	mov r2, #0x78
	strh r2, [r1, #0xe4]
	bl ovl02_215EB94
	ldr r0, _02166E78 // =ovl02_2166E7C
	str r0, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166E78: .word ovl02_2166E7C
	arm_func_end ovl02_2166E54

	arm_func_start ovl02_2166E7C
ovl02_2166E7C: // 0x02166E7C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x3f0]
	bl ovl02_2166CE4
	cmp r0, #0
	addeq r0, r4, #0x300
	moveq r1, #0
	streqh r1, [r0, #0xe4]
	add r0, r4, #0x300
	ldrh r2, [r0, #0xd0]
	tst r2, #0x10
	beq _02166EC0
	ldr r1, [r4, #0x98]
	cmp r1, #0
	movlt r1, #0
	strlth r1, [r0, #0xe4]
	blt _02166EDC
_02166EC0:
	tst r2, #0x20
	beq _02166EDC
	ldr r0, [r4, #0x98]
	cmp r0, #0
	addgt r0, r4, #0x300
	movgt r1, #0
	strgth r1, [r0, #0xe4]
_02166EDC:
	add r0, r4, #0x300
	ldrh r1, [r0, #0xe4]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe4]
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E298
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2166E7C

	arm_func_start ovl02_2166F00
ovl02_2166F00: // 0x02166F00
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r2, [r1, #0xd0]
	orr r2, r2, #2
	strh r2, [r1, #0xd0]
	bl ovl02_215EB94
	ldr r0, _02166F28 // =ovl02_2166F2C
	str r0, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166F28: .word ovl02_2166F2C
	arm_func_end ovl02_2166F00

	arm_func_start ovl02_2166F2C
ovl02_2166F2C: // 0x02166F2C
	stmdb sp!, {r4, lr}
	ldr r1, _02166F90 // =gPlayer
	mov r4, r0
	ldr r1, [r1]
	ldr r0, [r4, #0x48]
	ldr r1, [r1, #0x48]
	cmp r1, r0
	bge _02166F5C
	add r0, r4, #0x300
	ldrh r1, [r0, #0xd0]
	orr r1, r1, #2
	strh r1, [r0, #0xd0]
_02166F5C:
	ldr r1, [r4, #0x3f0]
	mov r0, r4
	bl ovl02_2166CE4
	ldr r0, [r4, #0x9c]
	cmp r0, #0
	bgt _02166F84
	mov r0, r4
	bl ovl02_215E460
	cmp r0, #0
	ldmneia sp!, {r4, pc}
_02166F84:
	ldr r0, _02166F94 // =ovl02_2166F98
	str r0, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166F90: .word gPlayer
_02166F94: .word ovl02_2166F98
	arm_func_end ovl02_2166F2C

	arm_func_start ovl02_2166F98
ovl02_2166F98: // 0x02166F98
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x1c]
	tst r1, #1
	ldmeqia sp!, {r4, pc}
	bl ovl02_215E460
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E298
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2166F98

	arm_func_start ovl02_2166FC4
ovl02_2166FC4: // 0x02166FC4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r3, [r1, #0xd0]
	mov r2, #0x1e
	orr r3, r3, #0x82
	strh r3, [r1, #0xd0]
	strh r2, [r1, #0xe6]
	bl ovl02_215EB94
	ldr r0, _02166FF4 // =ovl02_2166FF8
	str r0, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166FF4: .word ovl02_2166FF8
	arm_func_end ovl02_2166FC4

	arm_func_start ovl02_2166FF8
ovl02_2166FF8: // 0x02166FF8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x3f0]
	bl ovl02_2166CE4
	add r0, r4, #0x300
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	beq _0216702C
	sub r1, r1, #1
	strh r1, [r0, #0xe6]
	ldrh r1, [r0, #0xd0]
	orr r1, r1, #2
	strh r1, [r0, #0xd0]
_0216702C:
	ldr r0, [r4, #0x9c]
	cmp r0, #0
	bgt _02167048
	mov r0, r4
	bl ovl02_215E460
	cmp r0, #0
	ldmneia sp!, {r4, pc}
_02167048:
	ldr r0, _02167054 // =ovl02_2167058
	str r0, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167054: .word ovl02_2167058
	arm_func_end ovl02_2166FF8

	arm_func_start ovl02_2167058
ovl02_2167058: // 0x02167058
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x300
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	beq _02167084
	sub r1, r1, #1
	strh r1, [r0, #0xe6]
	ldrh r1, [r0, #0xd0]
	orr r1, r1, #2
	strh r1, [r0, #0xd0]
_02167084:
	ldr r0, [r4, #0x1c]
	tst r0, #1
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E460
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E298
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2167058

	arm_func_start ovl02_21670AC
ovl02_21670AC: // 0x021670AC
	add r1, r0, #0x300
	ldrh r3, [r1, #0xd0]
	ldr r2, _021670C8 // =ovl02_21670CC
	orr r3, r3, #0x42
	strh r3, [r1, #0xd0]
	str r2, [r0, #0x3c8]
	bx lr
	.align 2, 0
_021670C8: .word ovl02_21670CC
	arm_func_end ovl02_21670AC

	arm_func_start ovl02_21670CC
ovl02_21670CC: // 0x021670CC
	add r1, r0, #0x300
	ldrh r2, [r1, #0xd0]
	orr r2, r2, #0x42
	strh r2, [r1, #0xd0]
	ldr r1, [r0, #0x98]
	cmp r1, #0
	bge _02167100
	ldr r2, [r0, #0x44]
	ldr r1, [r0, #0x3d8]
	cmp r2, r1
	ldrle r1, _02167174 // =ovl02_216717C
	strle r1, [r0, #0x3c8]
	bx lr
_02167100:
	ble _0216711C
	ldr r2, [r0, #0x44]
	ldr r1, [r0, #0x3d8]
	cmp r2, r1
	ldrge r1, _02167174 // =ovl02_216717C
	strge r1, [r0, #0x3c8]
	bx lr
_0216711C:
	ldr r3, [r0, #0x1c]
	tst r3, #0xc
	ldrne r1, _02167174 // =ovl02_216717C
	strne r1, [r0, #0x3c8]
	bxne lr
	ldr r1, [r0, #0x9c]
	cmp r1, #0
	ble _0216715C
	ldr r1, _02167178 // =gPlayer
	ldr r2, [r0, #0x48]
	ldr r1, [r1]
	ldr r1, [r1, #0x48]
	cmp r2, r1
	ldrge r1, _02167174 // =ovl02_216717C
	strge r1, [r0, #0x3c8]
	bxge lr
_0216715C:
	tst r3, #1
	bxeq lr
	tst r3, #0x1000
	ldrne r1, _02167174 // =ovl02_216717C
	strne r1, [r0, #0x3c8]
	bx lr
	.align 2, 0
_02167174: .word ovl02_216717C
_02167178: .word gPlayer
	arm_func_end ovl02_21670CC

	arm_func_start ovl02_216717C
ovl02_216717C: // 0x0216717C
	add r1, r0, #0x300
	ldrh ip, [r1, #0xd0]
	mov r3, #0x1e
	ldr r2, _021671A0 // =ovl02_21671A4
	orr ip, ip, #0x40
	strh ip, [r1, #0xd0]
	strh r3, [r1, #0xe8]
	str r2, [r0, #0x3c8]
	bx lr
	.align 2, 0
_021671A0: .word ovl02_21671A4
	arm_func_end ovl02_216717C

	arm_func_start ovl02_21671A4
ovl02_21671A4: // 0x021671A4
	add r1, r0, #0x300
	ldrh r2, [r1, #0xd0]
	orr r2, r2, #0x40
	strh r2, [r1, #0xd0]
	ldrh r2, [r1, #0xe8]
	cmp r2, #0
	subne r0, r2, #1
	strneh r0, [r1, #0xe8]
	ldreq r1, _021671D0 // =ovl02_21671D4
	streq r1, [r0, #0x3c8]
	bx lr
	.align 2, 0
_021671D0: .word ovl02_21671D4
	arm_func_end ovl02_21671A4

	arm_func_start ovl02_21671D4
ovl02_21671D4: // 0x021671D4
	ldr r1, _021671E0 // =ovl02_21671E4
	str r1, [r0, #0x3c8]
	bx lr
	.align 2, 0
_021671E0: .word ovl02_21671E4
	arm_func_end ovl02_21671D4

	arm_func_start ovl02_21671E4
ovl02_21671E4: // 0x021671E4
	add r1, r0, #0x300
	ldrh r2, [r1, #0xd0]
	orr r2, r2, #2
	strh r2, [r1, #0xd0]
	ldr r1, [r0, #0x1c]
	tst r1, #1
	ldrne r1, _02167208 // =ovl02_216720C
	strne r1, [r0, #0x3c8]
	bx lr
	.align 2, 0
_02167208: .word ovl02_216720C
	arm_func_end ovl02_21671E4

	arm_func_start ovl02_216720C
ovl02_216720C: // 0x0216720C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r2, [r1, #0xd0]
	orr r2, r2, #2
	strh r2, [r1, #0xd0]
	bl ovl02_215EA84
	add r1, r4, #0x300
	ldr r2, _0216723C // =ovl02_2167240
	strh r0, [r1, #0xea]
	str r2, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216723C: .word ovl02_2167240
	arm_func_end ovl02_216720C

	arm_func_start ovl02_2167240
ovl02_2167240: // 0x02167240
	add r1, r0, #0x300
	ldrh r2, [r1, #0xea]
	cmp r2, #0
	ldreq r1, _02167270 // =ovl02_2167274
	streq r1, [r0, #0x3c8]
	bxeq lr
	sub r0, r2, #1
	strh r0, [r1, #0xea]
	ldrh r0, [r1, #0xd0]
	orr r0, r0, #2
	strh r0, [r1, #0xd0]
	bx lr
	.align 2, 0
_02167270: .word ovl02_2167274
	arm_func_end ovl02_2167240

	arm_func_start ovl02_2167274
ovl02_2167274: // 0x02167274
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215E484
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E298
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2167274

	arm_func_start ovl02_2167294
ovl02_2167294: // 0x02167294
	add r1, r0, #0x300
	mov r3, #0xf0
	ldr r2, _021672AC // =ovl02_21672B0
	strh r3, [r1, #0xec]
	str r2, [r0, #0x3c8]
	bx lr
	.align 2, 0
_021672AC: .word ovl02_21672B0
	arm_func_end ovl02_2167294

	arm_func_start ovl02_21672B0
ovl02_21672B0: // 0x021672B0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215E40C
	cmp r0, #0
	ldreq r0, _021672CC // =ovl02_21672D0
	streq r0, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021672CC: .word ovl02_21672D0
	arm_func_end ovl02_21672B0

	arm_func_start ovl02_21672D0
ovl02_21672D0: // 0x021672D0
	add r1, r0, #0x300
	ldrh r2, [r1, #0xec]
	cmp r2, #0
	ldreq r1, _02167300 // =ovl02_2167304
	streq r1, [r0, #0x3c8]
	bxeq lr
	sub r0, r2, #1
	strh r0, [r1, #0xec]
	ldrh r0, [r1, #0xd0]
	orr r0, r0, #0x400
	strh r0, [r1, #0xd0]
	bx lr
	.align 2, 0
_02167300: .word ovl02_2167304
	arm_func_end ovl02_21672D0

	arm_func_start ovl02_2167304
ovl02_2167304: // 0x02167304
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215E4A8
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E298
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2167304

	arm_func_start ovl02_2167324
ovl02_2167324: // 0x02167324
	add r1, r0, #0x300
	mov r3, #0x168
	ldr r2, _0216733C // =ovl02_2167340
	strh r3, [r1, #0xec]
	str r2, [r0, #0x3c8]
	bx lr
	.align 2, 0
_0216733C: .word ovl02_2167340
	arm_func_end ovl02_2167324

	arm_func_start ovl02_2167340
ovl02_2167340: // 0x02167340
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215E40C
	cmp r0, #0
	ldreq r0, _0216735C // =ovl02_2167360
	streq r0, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216735C: .word ovl02_2167360
	arm_func_end ovl02_2167340

	arm_func_start ovl02_2167360
ovl02_2167360: // 0x02167360
	add r1, r0, #0x300
	ldrh r2, [r1, #0xec]
	cmp r2, #0
	ldreq r1, _02167390 // =ovl02_2167394
	streq r1, [r0, #0x3c8]
	bxeq lr
	sub r0, r2, #1
	strh r0, [r1, #0xec]
	ldrh r0, [r1, #0xd0]
	orr r0, r0, #0x440
	strh r0, [r1, #0xd0]
	bx lr
	.align 2, 0
_02167390: .word ovl02_2167394
	arm_func_end ovl02_2167360

	arm_func_start ovl02_2167394
ovl02_2167394: // 0x02167394
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215E4A8
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E298
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2167394

	arm_func_start ovl02_21673B4
ovl02_21673B4: // 0x021673B4
	ldr r1, _021673C0 // =ovl02_21673C4
	str r1, [r0, #0x3c8]
	bx lr
	.align 2, 0
_021673C0: .word ovl02_21673C4
	arm_func_end ovl02_21673B4

	arm_func_start ovl02_21673C4
ovl02_21673C4: // 0x021673C4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215E40C
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x300
	ldrh r2, [r0, #0xd0]
	ldr r1, _021673F4 // =ovl02_21673F8
	orr r2, r2, #1
	strh r2, [r0, #0xd0]
	str r1, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021673F4: .word ovl02_21673F8
	arm_func_end ovl02_21673C4

	arm_func_start ovl02_21673F8
ovl02_21673F8: // 0x021673F8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215E4CC
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E298
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_21673F8

	arm_func_start ovl02_2167418
ovl02_2167418: // 0x02167418
	ldr r1, _02167424 // =ovl02_2167428
	str r1, [r0, #0x3c8]
	bx lr
	.align 2, 0
_02167424: .word ovl02_2167428
	arm_func_end ovl02_2167418

	arm_func_start ovl02_2167428
ovl02_2167428: // 0x02167428
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215E40C
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x300
	ldrh r2, [r0, #0xd0]
	ldr r1, _02167458 // =ovl02_216745C
	orr r2, r2, #0x41
	strh r2, [r0, #0xd0]
	str r1, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167458: .word ovl02_216745C
	arm_func_end ovl02_2167428

	arm_func_start ovl02_216745C
ovl02_216745C: // 0x0216745C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215E4F0
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E298
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_216745C

	arm_func_start ovl02_216747C
ovl02_216747C: // 0x0216747C
	add r1, r0, #0x300
	ldrh r3, [r1, #0xd0]
	ldr r2, _02167498 // =ovl02_216749C
	orr r3, r3, #0x840
	strh r3, [r1, #0xd0]
	str r2, [r0, #0x3c8]
	bx lr
	.align 2, 0
_02167498: .word ovl02_216749C
	arm_func_end ovl02_216747C

	arm_func_start ovl02_216749C
ovl02_216749C: // 0x0216749C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215E514
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E298
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_216749C

	arm_func_start ovl02_21674BC
ovl02_21674BC: // 0x021674BC
	ldr r2, _02167538 // =gPlayer
	ldr r3, [r0, #0x44]
	ldr r2, [r2]
	ldr r2, [r2, #0x44]
	subs r3, r2, r3
	ldr r2, _0216753C // =_021796D8
	rsbmi r3, r3, #0
	ldr r1, [r2, r1, lsl #2]
	cmp r3, r1
	bgt _02167504
	add r1, r0, #0x300
	ldrh r2, [r1, #0xf8]
	cmp r2, #0
	subne r2, r2, #1
	strneh r2, [r1, #0xf8]
	bne _02167504
	mov r0, #0
	bx lr
_02167504:
	ldr r1, _02167538 // =gPlayer
	ldr r2, [r0, #0x44]
	ldr r1, [r1]
	add r0, r0, #0x300
	ldr r1, [r1, #0x44]
	cmp r1, r2
	ldrgth r1, [r0, #0xd0]
	orrgt r1, r1, #0x10
	ldrleh r1, [r0, #0xd0]
	orrle r1, r1, #0x20
	strh r1, [r0, #0xd0]
	mov r0, #1
	bx lr
	.align 2, 0
_02167538: .word gPlayer
_0216753C: .word _021796D8
	arm_func_end ovl02_21674BC

	arm_func_start ovl02_2167540
ovl02_2167540: // 0x02167540
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215EAA0
	add r1, r4, #0x300
	ldr r2, _02167560 // =ovl02_2167564
	strh r0, [r1, #0xe4]
	str r2, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167560: .word ovl02_2167564
	arm_func_end ovl02_2167540

	arm_func_start ovl02_2167564
ovl02_2167564: // 0x02167564
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x370]
	ldr r1, [r1, #0x3e0]
	cmp r1, #0
	ldmneia sp!, {r4, pc}
	ldr r1, _02167628 // =gPlayer
	ldr r2, [r4, #0x44]
	ldr r1, [r1]
	ldr r1, [r1, #0x44]
	cmp r1, r2
	ble _021675C0
	ldr r1, [r4, #0x20]
	tst r1, #1
	bne _021675C0
	bl ovl02_215E6E0
	cmp r0, #0
	bne _021675C0
	add r0, r4, #0x300
	ldrh r1, [r0, #0xd0]
	orr r1, r1, #0x10
	strh r1, [r0, #0xd0]
	b _02167604
_021675C0:
	ldr r0, _02167628 // =gPlayer
	ldr r1, [r4, #0x44]
	ldr r0, [r0]
	ldr r0, [r0, #0x44]
	cmp r0, r1
	bge _02167604
	ldr r0, [r4, #0x20]
	tst r0, #1
	beq _02167604
	mov r0, r4
	bl ovl02_215E6E0
	cmp r0, #0
	bne _02167604
	add r0, r4, #0x300
	ldrh r1, [r0, #0xd0]
	orr r1, r1, #0x20
	strh r1, [r0, #0xd0]
_02167604:
	add r0, r4, #0x300
	ldrh r1, [r0, #0xe4]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe4]
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E55C
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167628: .word gPlayer
	arm_func_end ovl02_2167564

	arm_func_start ovl02_216762C
ovl02_216762C: // 0x0216762C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	mov r2, #0x78
	strh r2, [r1, #0xe4]
	bl ovl02_215EC88
	ldr r0, _02167650 // =ovl02_2167654
	str r0, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167650: .word ovl02_2167654
	arm_func_end ovl02_216762C

	arm_func_start ovl02_2167654
ovl02_2167654: // 0x02167654
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x3f4]
	bl ovl02_21674BC
	cmp r0, #0
	addeq r0, r4, #0x300
	moveq r1, #0
	streqh r1, [r0, #0xe4]
	add r0, r4, #0x300
	ldrh r2, [r0, #0xd0]
	tst r2, #0x10
	beq _02167698
	ldr r1, [r4, #0x98]
	cmp r1, #0
	movlt r1, #0
	strlth r1, [r0, #0xe4]
	blt _021676B4
_02167698:
	tst r2, #0x20
	beq _021676B4
	ldr r0, [r4, #0x98]
	cmp r0, #0
	addgt r0, r4, #0x300
	movgt r1, #0
	strgth r1, [r0, #0xe4]
_021676B4:
	add r0, r4, #0x300
	ldrh r1, [r0, #0xe4]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe4]
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E55C
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2167654

	arm_func_start ovl02_21676D8
ovl02_21676D8: // 0x021676D8
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r2, [r1, #0xd0]
	orr r2, r2, #2
	strh r2, [r1, #0xd0]
	bl ovl02_215EC88
	ldr r0, _02167700 // =ovl02_2167704
	str r0, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167700: .word ovl02_2167704
	arm_func_end ovl02_21676D8

	arm_func_start ovl02_2167704
ovl02_2167704: // 0x02167704
	stmdb sp!, {r4, lr}
	ldr r1, _02167768 // =gPlayer
	mov r4, r0
	ldr r1, [r1]
	ldr r0, [r4, #0x48]
	ldr r1, [r1, #0x48]
	cmp r1, r0
	bge _02167734
	add r0, r4, #0x300
	ldrh r1, [r0, #0xd0]
	orr r1, r1, #2
	strh r1, [r0, #0xd0]
_02167734:
	ldr r1, [r4, #0x3f4]
	mov r0, r4
	bl ovl02_21674BC
	ldr r0, [r4, #0x9c]
	cmp r0, #0
	bgt _0216775C
	mov r0, r4
	bl ovl02_215E6F8
	cmp r0, #0
	ldmneia sp!, {r4, pc}
_0216775C:
	ldr r0, _0216776C // =ovl02_2167770
	str r0, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167768: .word gPlayer
_0216776C: .word ovl02_2167770
	arm_func_end ovl02_2167704

	arm_func_start ovl02_2167770
ovl02_2167770: // 0x02167770
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x1c]
	tst r1, #1
	ldmeqia sp!, {r4, pc}
	bl ovl02_215E6F8
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E55C
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2167770

	arm_func_start ovl02_216779C
ovl02_216779C: // 0x0216779C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r3, [r1, #0xd0]
	mov r2, #0x1e
	orr r3, r3, #0x82
	strh r3, [r1, #0xd0]
	strh r2, [r1, #0xe6]
	bl ovl02_215EC88
	ldr r0, _021677CC // =ovl02_21677D0
	str r0, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021677CC: .word ovl02_21677D0
	arm_func_end ovl02_216779C

	arm_func_start ovl02_21677D0
ovl02_21677D0: // 0x021677D0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x3f4]
	bl ovl02_21674BC
	add r0, r4, #0x300
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	beq _02167804
	sub r1, r1, #1
	strh r1, [r0, #0xe6]
	ldrh r1, [r0, #0xd0]
	orr r1, r1, #2
	strh r1, [r0, #0xd0]
_02167804:
	ldr r0, [r4, #0x9c]
	cmp r0, #0
	bgt _02167820
	mov r0, r4
	bl ovl02_215E6F8
	cmp r0, #0
	ldmneia sp!, {r4, pc}
_02167820:
	ldr r0, _0216782C // =ovl02_2167830
	str r0, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216782C: .word ovl02_2167830
	arm_func_end ovl02_21677D0

	arm_func_start ovl02_2167830
ovl02_2167830: // 0x02167830
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x300
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	beq _0216785C
	sub r1, r1, #1
	strh r1, [r0, #0xe6]
	ldrh r1, [r0, #0xd0]
	orr r1, r1, #2
	strh r1, [r0, #0xd0]
_0216785C:
	ldr r0, [r4, #0x1c]
	tst r0, #1
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E6F8
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E55C
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2167830

	arm_func_start ovl02_2167884
ovl02_2167884: // 0x02167884
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r2, [r1, #0xd0]
	orr r2, r2, #1
	strh r2, [r1, #0xd0]
	bl ovl02_215EAD8
	add r1, r4, #0x300
	ldr r2, _021678B4 // =ovl02_21678B8
	strh r0, [r1, #0xe8]
	str r2, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021678B4: .word ovl02_21678B8
	arm_func_end ovl02_2167884

	arm_func_start ovl02_21678B8
ovl02_21678B8: // 0x021678B8
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x300
	ldrh r1, [r0, #0xe8]
	cmp r1, #0
	ldrneh r1, [r0, #0xd0]
	orrne r1, r1, #1
	strneh r1, [r0, #0xd0]
	mov r0, r4
	bl ovl02_215E740
	cmp r0, #0
	ldrne r0, _02167928 // =ovl02_21679BC
	strne r0, [r4, #0x3c8]
	mov r0, r4
	bl ovl02_215E758
	cmp r0, #0
	ldrne r0, _0216792C // =ovl02_2167934
	strne r0, [r4, #0x3c8]
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x1c]
	tst r0, #1
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E71C
	cmp r0, #0
	ldreq r0, _02167930 // =ovl02_216799C
	streq r0, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167928: .word ovl02_21679BC
_0216792C: .word ovl02_2167934
_02167930: .word ovl02_216799C
	arm_func_end ovl02_21678B8

	arm_func_start ovl02_2167934
ovl02_2167934: // 0x02167934
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r2, [r1, #0xd0]
	orr r2, r2, #0x80
	strh r2, [r1, #0xd0]
	bl ovl02_215EABC
	add r1, r4, #0x300
	ldr r2, _02167964 // =ovl02_2167968
	strh r0, [r1, #0xea]
	str r2, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167964: .word ovl02_2167968
	arm_func_end ovl02_2167934

	arm_func_start ovl02_2167968
ovl02_2167968: // 0x02167968
	add r1, r0, #0x300
	ldrh r2, [r1, #0xea]
	cmp r2, #0
	ldreq r1, _02167998 // =ovl02_216799C
	streq r1, [r0, #0x3c8]
	bxeq lr
	sub r0, r2, #1
	strh r0, [r1, #0xea]
	ldrh r0, [r1, #0xd0]
	orr r0, r0, #0x80
	strh r0, [r1, #0xd0]
	bx lr
	.align 2, 0
_02167998: .word ovl02_216799C
	arm_func_end ovl02_2167968

	arm_func_start ovl02_216799C
ovl02_216799C: // 0x0216799C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215E71C
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E55C
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_216799C

	arm_func_start ovl02_21679BC
ovl02_21679BC: // 0x021679BC
	add r1, r0, #0x300
	ldrh r2, [r1, #0xd0]
	orr r2, r2, #1
	strh r2, [r1, #0xd0]
	ldrh r2, [r1, #0xe8]
	cmp r2, #0
	subne r2, r2, #1
	strneh r2, [r1, #0xe8]
	ldr r1, _021679E8 // =ovl02_21679EC
	str r1, [r0, #0x3c8]
	bx lr
	.align 2, 0
_021679E8: .word ovl02_21679EC
	arm_func_end ovl02_21679BC

	arm_func_start ovl02_21679EC
ovl02_21679EC: // 0x021679EC
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x300
	ldrh r1, [r0, #0xe8]
	cmp r1, #0
	ldrneh r1, [r0, #0xd0]
	orrne r1, r1, #1
	strneh r1, [r0, #0xd0]
	mov r0, r4
	bl ovl02_215E740
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x300
	ldrh r2, [r0, #0xd0]
	ldr r1, _02167A38 // =ovl02_21678B8
	bic r2, r2, #1
	strh r2, [r0, #0xd0]
	str r1, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167A38: .word ovl02_21678B8
	arm_func_end ovl02_21679EC

	arm_func_start ovl02_2167A3C
ovl02_2167A3C: // 0x02167A3C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r2, [r1, #0xd0]
	orr r2, r2, #0x840
	strh r2, [r1, #0xd0]
	bl ovl02_215EB70
	add r1, r4, #0x300
	ldr r2, _02167A6C // =ovl02_2167A70
	strh r0, [r1, #0xec]
	str r2, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167A6C: .word ovl02_2167A70
	arm_func_end ovl02_2167A3C

	arm_func_start ovl02_2167A70
ovl02_2167A70: // 0x02167A70
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x370]
	bl ovl02_215E228
	cmp r0, #0
	ldreq r0, _02167ADC // =ovl02_2167AE0
	streq r0, [r4, #0x3c8]
	add r0, r4, #0x300
	ldrh r0, [r0, #0xec]
	cmp r0, #0
	beq _02167AD0
	mov r0, r4
	bl ovl02_215E7AC
	cmp r0, #0
	beq _02167ABC
	add r0, r4, #0x300
	ldrh r1, [r0, #0xec]
	sub r1, r1, #1
	strh r1, [r0, #0xec]
_02167ABC:
	add r0, r4, #0x300
	ldrh r1, [r0, #0xd0]
	orr r1, r1, #0x840
	strh r1, [r0, #0xd0]
	ldmia sp!, {r4, pc}
_02167AD0:
	ldr r0, _02167ADC // =ovl02_2167AE0
	str r0, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167ADC: .word ovl02_2167AE0
	arm_func_end ovl02_2167A70

	arm_func_start ovl02_2167AE0
ovl02_2167AE0: // 0x02167AE0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215E7CC
	cmp r0, #0
	ldreq r0, [r4, #0x1c]
	cmpeq r0, #0
	ldrne r0, _02167B04 // =ovl02_2167B08
	strne r0, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167B04: .word ovl02_2167B08
	arm_func_end ovl02_2167AE0

	arm_func_start ovl02_2167B08
ovl02_2167B08: // 0x02167B08
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r2, [r1, #0xd0]
	orr r2, r2, #0x80
	strh r2, [r1, #0xd0]
	bl ovl02_215EB54
	add r1, r4, #0x300
	ldr r2, _02167B38 // =ovl02_2167B3C
	strh r0, [r1, #0xee]
	str r2, [r4, #0x3c8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167B38: .word ovl02_2167B3C
	arm_func_end ovl02_2167B08

	arm_func_start ovl02_2167B3C
ovl02_2167B3C: // 0x02167B3C
	add r1, r0, #0x300
	ldrh r2, [r1, #0xee]
	cmp r2, #0
	ldreq r1, _02167B6C // =ovl02_2167B70
	streq r1, [r0, #0x3c8]
	bxeq lr
	sub r0, r2, #1
	strh r0, [r1, #0xee]
	ldrh r0, [r1, #0xd0]
	orr r0, r0, #0x80
	strh r0, [r1, #0xd0]
	bx lr
	.align 2, 0
_02167B6C: .word ovl02_2167B70
	arm_func_end ovl02_2167B3C

	arm_func_start ovl02_2167B70
ovl02_2167B70: // 0x02167B70
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_215E770
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_215E55C
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2167B70

	.rodata

_02178CD8: // 0x02178CD8
    .word 2, 0x91A83, 0
    .word 2, 0x76539, 0x32000, 2, 0x91A83, 0
    .word 2, 0x76539, 0x32000, 2, 0x91A83, 0
    .word 2, 0x3FAA5, 0xC8000, 2, 0x5AFEF, 0
    .word 2, 0x3FAA5, 0x32000, 2, 0x5AFEF, 0
    .word 2, 0x3FAA5, 0x32000, 2, 0x5AFEF, 0
    .word 2, 0xACFCD, 0xC8000, 2, 0xC8517, 0
    .word 2, 0xACFCD, 0x32000, 2, 0xC8517, 0
    .word 2, 0xACFCD, 0x32000, 2, 0xC8517, 0
    .word 0xFFFF, 0, 0

_02178DB0: // 0x02178DB0
    .word 0x2330366
	
_02178DB4: // 0x02178DB4
    .word 0x200028
	
_02178DB8: // 0x02178DB8
    .word 0x15502AA
	
_02178DBC: // 0x02178DBC
    .word 0x200028
	
_02178DC0: // 0x02178DC0
    .word 0x2000333
	
_02178DC4: // 0x02178DC4
    .byte 0x33, 1

_02178DC6: // 0x02178DC6
    .hword 0x29

_02178DC8: // 0x02178DC8
    .hword 0x2A

_02178DCA: // 0x02178DCA
    .hword 0x25

_02178DCC: // 0x02178DCC
    .word 0x28003C, 0x14001E
	
_02178DD4: // 0x02178DD4
    .word 0x14001E, 0x5000A
	
_02178DDC: // 0x02178DDC
    .word 0x14001E, 0x5000A
	
_02178DE4: // 0x02178DE4
    .word 0x10000, 0x20001
	
_02178DEC: // 0x02178DEC
    .hword 0x50, 0x46, 0x3C, 0x32
	
_02178DF4: // 0x02178DF4
    .hword 0x78, 0x78, 0x3C, 0x3C
	
_02178DFC: // 0x02178DFC
    .word 0x547, 0x547, 0x570
	
_02178E08: // 0x02178E08
    .word 0

_02178E0C: // 0x02178E0C
    .word 0x1000, 0

_02178E14: // 0x02178E14
    .word 0x1000, 0
    .word 0xB33, 0x4CC, 0x4CC, 0xB33, 0
    .word 0x1000

_02178E34: // 0x02178E34
    .word 0x1000, 0
    .word 0xB33, 0x4CC, 0x4CC, 0xB33, 0
    .word 0x1000

_02178E54: // 0x02178E54
    .word 0x4CC, 0x4CC, 0x666, 0x333, 0x4CC, 0x800, 0x199, 0x800
    .word 0x666, 0
    .word 0x1000, 0
    .word 0x333, 0x4CC, 0x800, 0x199, 0x666, 0x800, 0
    .word 0x800, 0x800, 0
    .word 0x1000, 0

_02178EB4: // 0x02178EB4
    .word 0x4CC, 0x333, 0x333, 0x4CC, 0, 0
    .word 0x199, 0x4CC, 0x333, 0x199, 0x4CC, 0
    .word 0x199, 0x800, 0x4CC, 0
    .word 0x199, 0, 0
    .word 0x1000, 0, 0, 0, 0
    .word 0x199, 0x333, 0x4CC, 0x666, 0, 0
    .word 0x199, 0x4CC, 0x4CC, 0x199, 0x333, 0, 0
    .word 0x999, 0x4CC, 0
    .word 0x199, 0, 0
    .word 0x1000, 0, 0, 0, 0

_02178F74: // 0x02178F74
    .word 0x35343427, 0x33323136, 0x2E2D2C2B, 0x2928302F, 0x2625242A
    .word 0x38372C2B, 0x302F2E2C

_02178F90: // 0x02178F90
    .word 0x1C1B1B07, 0x1413121D, 0x13121615, 0xE0D0C0B, 0x311100F
    .word 0x17060504, 0x201A1918, 0x8232221, 0x1000A09, 0x1F1E0702
    .word 0xA0908

_02178FBC: // 0x02178FBC
    .word 0x1C1B1B07, 0x1413121D, 0x13121615, 0xE0D0C0B, 0x311100F
    .word 0x17060504, 0x201A1918, 0x8232221, 0x1000A09, 0x1F1E0702
    .word 9

	.data

_021796C0: // 0x021796C0
    .hword 0xFFE2
	
_021796C2: // 0x021796C2
    .hword 0xFFE2

_021796C4: // 0x021796C4
    .hword 0x1E

_021796C6: // 0x021796C6
    .hword 0x1E

_021796C8: // 0x021796C8
    .hword 0xFFF0
	
_021796CA: // 0x021796CA
    .hword 0xFFC0
	
_021796CC: // 0x021796CC
    .hword 0x10
	
_021796CE: // 0x021796CE
    .hword 0
	
_021796D0: // 0x021796D0
    .hword 0xFFF0

_021796D2: // 0x021796D2
    .hword 0xFFF0

_021796D4: // 0x021796D4
    .hword 0x10
	
_021796D6: // 0x021796D6
    .hword 0x10

_021796D8: // 0x021796D8
    .word 0
	
_021796DC: // 0x021796DC
    .word 0x80000
	
_021796E0: // 0x021796E0
	.hword 0

_021796E2: // 0x021796E2
	.hword 0x10
	
_021796E4: // 0x021796E4
	.hword 0

_021796E6: // 0x021796E6
	.hword 0x18

_021796E8: // 0x021796E8
    .hword 0xFFF6

_021796EA: // 0x021796EA
    .hword 0xFFF6

_021796EC: // 0x021796EC
    .hword 0xA

_021796EE: // 0x021796EE
    .hword 0xA

_021796F0: // 0x021796F0
    .hword 0xFFF6

_021796F2: // 0x021796F2
    .hword 0xFFF6

_021796F4: // 0x021796F4
    .hword 0xA

_021796F6: // 0x021796F6
    .hword 0xA

_021796F8: // 0x021796F8
    .hword 0xFFF6

_021796FA: // 0x021796FA
    .hword 0xFFF6

_021796FC: // 0x021796FC
    .hword 0xA

_021796FE: // 0x021796FE
    .hword 0xA

_02179700: // 0x02179700
    .hword 0xFFEC

_02179702: // 0x02179702
    .hword 0xFFF6

_02179704: // 0x02179704
    .hword 0x14

_02179706: // 0x02179706
    .hword 0xA

_02179708: // 0x02179708
    .hword 0xFFEC
	
_0217970A: // 0x0217970A
    .hword 0xFFF6
	
_0217970C: // 0x0217970C
    .hword 0x14
	
_0217970E: // 0x0217970E
    .hword 0xA
	
_02179710: // 0x02179710
    .hword 0xFFEC
	
_02179712: // 0x02179712
    .hword 0xFFF6
	
_02179714: // 0x02179714
    .hword 0x14
	
_02179716: // 0x02179716
    .hword 0xA

_02179718: // 0x02179718
    .hword 0xFFF6

_0217971A: // 0x0217971A
    .hword 0xFFF6

_0217971C: // 0x0217971C
    .hword 0xA

_0217971E: // 0x0217971E
    .hword 5

_02179720: // 0x02179720
    .hword 0xFFF6

_02179722: // 0x02179722
    .hword 0xFFF6

_02179724: // 0x02179724
    .hword 0xA

_02179726: // 0x02179726
    .hword 5

_02179728: // 0x02179728
	.hword 0xFFF6

_0217972A: // 0x0217972A
	.hword 0xFFF6

_0217972C: // 0x0217972C
	.hword 0xA

_0217972E: // 0x0217972E
	.hword 0x5

_02179730: // 0x02179730
    .hword 0xFFF4
	
_02179732: // 0x02179732
    .hword 0xFFFB

_02179734: // 0x02179734
    .hword 0xC

_02179736: // 0x02179736
    .hword 0xA

_02179738: // 0x02179738
    .hword 0xFFF4

_0217973A: // 0x0217973A
    .hword 0xFFFB

_0217973C: // 0x0217973C
    .hword 0xC

_0217973E: // 0x0217973E
    .hword 0xA

_02179740: // 0x02179740
	.hword 0xFFF4

_02179742: // 0x02179742
	.hword 0xFFFB

_02179744: // 0x02179744
	.hword 0xC

_02179746: // 0x02179746
	.hword 0xA
	
_02179748: // 0x02179748
    .word 0x160000
	
_0217974C: // 0x0217974C
    .word 0x33999A, 0x160000, 0x23999A, 0x160000, 0x19999A, 0x160000, 0xD999A

_02179768: // 0x02179768
    .word 0x637865
aBsef7FlameBac: // 0x0217976C
    .asciz "bsef7_flame.bac"
    .align 4

aHip: // 0x0217977C
    .asciz "hip"
    .align 4

aHead_1: // 0x02179780
    .asciz "head"
    .align 4

aLElbow_0: // 0x02179788
    .asciz "l_elbow"
    .align 4

aRElbow_0: // 0x02179790
    .asciz "r_elbow"
    .align 4