	.include "asm/macros.inc"
	.include "global.inc"

.public BossArena__explosionFXSpawnTime

	.bss

_0217AFB0: // 0x0217AFB0
	.space 0x02
	.align 4

_0217AFB4: // 0x0217AFB4
	.space 0x04

	.text

	arm_func_start Boss4Stage__Create
Boss4Stage__Create: // 0x0216B638
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	ldr r0, _0216B884 // =StageTask_Main
	ldr r1, _0216B888 // =ovl01_216D150
	mov r3, r2
	str r4, [sp, #4]
	mov r4, #0x550
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, _0216B88C // =_0217AFB0
	str r0, [r1, #4]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x550
	bl MIi_CpuClear16
	mov r1, r7
	mov r0, r4
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, _0216B890 // =ovl01_216D0C8
	ldr r0, _0216B894 // =ovl01_216D1F4
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r0, [r4, #0x18]
	ldr r2, _0216B898 // =0x000034CC
	orr r0, r0, #0x12
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	mov r1, #0x400
	orr r0, r0, #0x184
	orr r0, r0, #0x2000
	str r0, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	add r0, r4, #0x300
	orr r3, r3, #0xbf00
	str r3, [r4, #0x1c]
	str r2, [r4, #0x38]
	str r2, [r4, #0x3c]
	str r2, [r4, #0x40]
	strh r1, [r0, #0x94]
	rsb r7, r5, #0
	str r7, [r4, #0x398]
	add r0, r4, #0x364
	bl ovl01_216C920
	add r0, r4, #0x39c
	bl BossHelpers__InitLights
	bl BossHelpers__Model__InitSystem
	ldr r1, _0216B89C // =0x02133A18
	mov r0, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, r4
	add r1, r4, #0x3d4
	ldr r2, _0216B8A0 // =_0217ACD8
	mov r3, #1
	bl ObjAction3dNNModelLoad
	mov r3, #0
	str r3, [r4, #0x12c]
	str r3, [r4, #0x41c]
	str r7, [r4, #0x420]
	str r3, [r4, #0x424]
	ldr r1, _0216B8A4 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	add r1, r4, #0x3d4
	str r2, [sp]
	ldr r2, _0216B8A8 // =aBoss4Nsbta
	bl ObjAction3dNNMotionLoad
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	ldr r2, [r4, #0x528]
	add r0, r4, #0x3d4
	mov r1, #3
	bl BossHelpers__SetAnimation
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	ldr r0, _0216B8AC // =0x0000011E
	mov r1, r6
	mov r2, r5
	str r3, [sp, #0x10]
	bl GameObject__SpawnObject
	str r0, [r4, #0x384]
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	mov r1, r6
	mov r2, r5
	str r3, [sp, #0x10]
	mov r0, #0x11c
	bl GameObject__SpawnObject
	mov r1, #0
	str r0, [r4, #0x37c]
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	str r1, [sp, #0x10]
	ldr r0, _0216B8B0 // =0x0000011D
	mov r2, r1
	mov r3, r1
	bl GameObject__SpawnObject
	str r0, [r4, #0x380]
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	str r1, [sp, #0x10]
	ldr r0, _0216B8B4 // =0x0000011F
	mov r2, r1
	mov r3, r1
	bl GameObject__SpawnObject
	str r0, [r4, #0x388]
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #1
	str r0, [sp, #0x10]
	rsb r0, r0, #0x120
	mov r2, r1
	mov r3, r1
	bl GameObject__SpawnObject
	str r0, [r4, #0x38c]
	bl InitSpatialAudioConfig
	ldr r1, _0216B8B8 // =ovl01_216D238
	mov r0, r4
	str r1, [r4, #0x390]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216B884: .word StageTask_Main
_0216B888: .word ovl01_216D150
_0216B88C: .word _0217AFB0
_0216B890: .word ovl01_216D0C8
_0216B894: .word ovl01_216D1F4
_0216B898: .word 0x000034CC
_0216B89C: .word 0x02133A18
_0216B8A0: .word _0217ACD8
_0216B8A4: .word gameArchiveStage
_0216B8A8: .word aBoss4Nsbta
_0216B8AC: .word 0x0000011E
_0216B8B0: .word 0x0000011D
_0216B8B4: .word 0x0000011F
_0216B8B8: .word ovl01_216D238
	arm_func_end Boss4Stage__Create

	arm_func_start Boss4__Create
Boss4__Create: // 0x0216B8BC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x74
	mov r3, #0x1500
	mov r6, r0
	mov r5, r1
	mov r4, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r7, _0216BC58 // =0x000007EC
	ldr r0, _0216BC5C // =StageTask_Main
	ldr r1, _0216BC60 // =ovl01_216FC24
	mov r3, r2
	str r7, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r8, r0
	mov r0, #0
	mov r1, r8
	mov r2, r7
	bl MIi_CpuClear16
	ldr r0, _0216BC64 // =_0217AFB0
	ldr r0, [r0, #4]
	bl GetTaskWork_
	str r0, [r8, #0x37c]
	mov r1, r6
	mov r0, r8
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	ldr r1, _0216BC68 // =ovl01_216FBE8
	ldr r0, _0216BC6C // =ovl01_216FC8C
	str r1, [r8, #0xf4]
	str r0, [r8, #0xfc]
	ldr r0, _0216BC70 // =ovl01_216FD08
	mov r3, #0
	str r0, [r8, #0x108]
	ldr r1, [r8, #0x18]
	mov r0, r8
	orr r1, r1, #0x10
	str r1, [r8, #0x18]
	ldr r2, [r8, #0x20]
	sub r1, r3, #8
	orr r2, r2, #0x81
	str r2, [r8, #0x20]
	ldr r6, [r8, #0x1c]
	sub r2, r3, #0x14
	orr r6, r6, #0x1080
	orr r6, r6, #0x88000
	bic r6, r6, #0x200
	str r6, [r8, #0x1c]
	str r3, [sp]
	mov r3, #8
	bl StageTask__SetHitbox
	mov r0, #0x1000
	str r0, [r8, #0x38]
	str r0, [r8, #0x3c]
	str r0, [r8, #0x40]
	str r5, [r8, #0x44]
	mov r1, #0
	str r4, [r8, #0x48]
	str r1, [r8, #0x4c]
	add r0, r8, #0x380
	mov r2, r1
	bl InitPadInput
	bl AllocSndHandle
	str r0, [r8, #0x788]
	bl AllocSndHandle
	str r0, [r8, #0x78c]
	add r0, r8, #0x364
	bl ovl01_216C920
	add r0, r8, #0x218
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	add r0, r8, #0x218
	mov r1, #3
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	mov r0, #8
	str r0, [sp, #8]
	sub r3, r0, #0x10
	add r0, r8, #0x218
	mov r2, r1
	bl ObjRect__SetBox3D
	str r8, [r8, #0x234]
	ldr r1, [r8, #0x230]
	mov r0, r8
	orr r1, r1, #0x400
	str r1, [r8, #0x230]
	bl ovl01_216FFA8
	add r0, r8, #0x258
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r8, #0x258
	mov r1, #2
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r0, #0x10
	str r0, [sp]
	mov r0, #0x24
	str r0, [sp, #4]
	mov r3, #0x40
	str r3, [sp, #8]
	add r0, r8, #0x258
	sub r1, r3, #0x50
	sub r2, r3, #0x5c
	sub r3, r3, #0x80
	bl ObjRect__SetBox3D
	str r8, [r8, #0x274]
	ldr r1, _0216BC74 // =ovl01_216FD80
	mov r0, r8
	str r1, [r8, #0x27c]
	ldr r1, [r8, #0x270]
	orr r1, r1, #0x400
	str r1, [r8, #0x270]
	bl ovl01_216FF88
	add r0, r8, #0x298
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	add r0, r8, #0x298
	mov r1, #1
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	mov r0, #8
	str r0, [sp, #8]
	sub r3, r0, #0x10
	add r0, r8, #0x298
	mov r2, r1
	bl ObjRect__SetBox3D
	ldr r0, _0216BC78 // =ovl01_216FEB0
	str r8, [r8, #0x2b4]
	str r0, [r8, #0x2bc]
	ldr r1, [r8, #0x2b0]
	mov r0, r8
	orr r1, r1, #0x400
	str r1, [r8, #0x2b0]
	bl ovl01_2170120
	ldr r1, _0216BC7C // =bossAssetFiles
	add r4, r8, #0x208
	str r1, [sp]
	mov r3, #0
	ldr r2, _0216BC80 // =_0217ACD8
	mov r0, r8
	add r1, r4, #0x400
	str r3, [sp, #4]
	bl ObjAction3dNNModelLoad
	mov r3, #0
	ldr r0, _0216BC84 // =0x000034CC
	str r3, [r8, #0x12c]
	str r0, [r4, #0x418]
	str r0, [r4, #0x41c]
	str r0, [r4, #0x420]
	mov r0, #4
	strb r0, [r4, #0x40a]
	ldr r0, _0216BC88 // =gameArchiveStage
	strb r3, [r4, #0x40b]
	ldr r1, [r0, #0]
	ldr r2, _0216BC8C // =aBoss4Nsbca
	str r1, [sp]
	mov r0, r8
	add r1, r4, #0x400
	bl ObjAction3dNNMotionLoad
	mov r0, #3
	str r0, [sp]
	ldr r1, _0216BC90 // =BossHelpers__Model__RenderCallback
	add r0, r4, #0x490
	mov r2, #0
	mov r3, #6
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0x494]
	ldr r1, _0216BC94 // =aBodyCore
	mov r2, #0x1e
	bl BossHelpers__Model__Init
	ldr r2, _0216BC88 // =gameArchiveStage
	ldr r1, _0216BC98 // =aExc_5
	ldr r2, [r2, #0]
	add r0, sp, #0xc
	bl NNS_FndMountArchive
	add r0, r8, #4
	ldr r6, _0216BC9C // =_0217ABB4
	ldr r4, _0216BC7C // =bossAssetFiles
	mov r9, #0
	add r10, r0, #0x400
	add r11, sp, #0xc
	mov r5, #5
_0216BBD0:
	mov r0, r11
	add r1, r9, #0xd
	bl NNS_FndGetArchiveFileByIndex
	mov r7, r0
	ldr r0, [r4, #0]
	bl NNS_G3dGetTex
	ldr r1, [r6, r9, lsl #2]
	bl Asset3DSetup__PaletteFromName
	str r5, [sp]
	mov r2, #0
	str r0, [sp, #4]
	mov r1, r7
	mov r0, r10
	mov r3, r2
	bl InitPaletteAnimator
	add r9, r9, #1
	add r10, r10, #0x20
	cmp r9, #0x10
	blt _0216BBD0
	add r0, r8, #4
	mov r2, #0
	mov r3, r2
	add r0, r0, #0x400
	mov r1, #0x10
	bl BossHelpers__SetPaletteAnimations
	add r0, sp, #0xc
	bl NNS_FndUnmountArchive
	mov r0, r8
	bl ovl01_21708D0
	mov r0, r8
	bl ovl01_2171D44
	mov r0, r8
	add sp, sp, #0x74
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216BC58: .word 0x000007EC
_0216BC5C: .word StageTask_Main
_0216BC60: .word ovl01_216FC24
_0216BC64: .word _0217AFB0
_0216BC68: .word ovl01_216FBE8
_0216BC6C: .word ovl01_216FC8C
_0216BC70: .word ovl01_216FD08
_0216BC74: .word ovl01_216FD80
_0216BC78: .word ovl01_216FEB0
_0216BC7C: .word bossAssetFiles
_0216BC80: .word _0217ACD8
_0216BC84: .word 0x000034CC
_0216BC88: .word gameArchiveStage
_0216BC8C: .word aBoss4Nsbca
_0216BC90: .word BossHelpers__Model__RenderCallback
_0216BC94: .word aBodyCore
_0216BC98: .word aExc_5
_0216BC9C: .word _0217ABB4
	arm_func_end Boss4__Create

	arm_func_start Boss4Core__Create
Boss4Core__Create: // 0x0216BCA0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x74
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r0, #2
	ldr r4, _0216BF64 // =0x00000944
	str r0, [sp, #4]
	ldr r0, _0216BF68 // =StageTask_Main
	ldr r1, _0216BF6C // =ovl01_216E498
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	ldr r2, _0216BF64 // =0x00000944
	bl MIi_CpuClear16
	ldr r0, _0216BF70 // =_0217AFB0
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r1, r7
	str r0, [r4, #0x37c]
	mov r0, r4
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, _0216BF74 // =ovl01_216E408
	ldr r0, _0216BF78 // =ovl01_216E4E0
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r0, [r4, #0x18]
	mov r1, #0x1000
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r2, [r4, #0x20]
	mov r0, #0
	orr r2, r2, #0x84
	str r2, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	orr r2, r2, #0x9f00
	orr r2, r2, #0x80000
	str r2, [r4, #0x1c]
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	str r6, [r4, #0x44]
	str r5, [r4, #0x48]
	str r0, [r4, #0x4c]
	bl AllocSndHandle
	str r0, [r4, #0x7a0]
	add r0, r4, #0x364
	bl ovl01_216C920
	add r0, r4, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	mov r1, #2
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r0, #0x10
	str r0, [sp]
	str r0, [sp, #4]
	mov r2, #0x40
	str r2, [sp, #8]
	add r0, r4, #0x218
	sub r1, r2, #0x50
	sub r3, r2, #0x80
	mov r2, r1
	bl ObjRect__SetBox3D
	ldr r1, _0216BF7C // =ovl01_216E594
	str r4, [r4, #0x234]
	mov r0, r4
	str r1, [r4, #0x23c]
	bl ovl01_216E860
	ldr r0, [r4, #0x230]
	mov r1, #0
	orr r3, r0, #0x400
	mov r2, r1
	add r0, r4, #0x258
	str r3, [r4, #0x230]
	bl ObjRect__SetAttackStat
	add r0, r4, #0x258
	mov r1, #2
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r2, #0x40
	mov r0, #0x10
	str r0, [sp]
	stmib sp, {r0, r2}
	sub r1, r2, #0x50
	sub r3, r2, #0x80
	add r0, r4, #0x258
	mov r2, r1
	bl ObjRect__SetBox3D
	ldr r1, _0216BF80 // =ovl01_216E7F4
	str r4, [r4, #0x274]
	mov r0, r4
	str r1, [r4, #0x27c]
	bl ovl01_216E880
	ldr r0, [r4, #0x270]
	add r5, r4, #0x3c8
	orr r0, r0, #0x400
	str r0, [r4, #0x270]
	ldr r0, _0216BF84 // =0x02133A10
	mov r3, #0
	stmia sp, {r0, r3}
	ldr r2, _0216BF88 // =_0217ACD8
	mov r0, r4
	add r1, r5, #0x400
	bl ObjAction3dNNModelLoad
	mov r3, #0
	ldr r1, _0216BF8C // =0x000034CC
	str r3, [r4, #0x12c]
	str r1, [r5, #0x418]
	str r1, [r5, #0x41c]
	str r1, [r5, #0x420]
	mov r0, #4
	strb r0, [r5, #0x40a]
	ldr r2, _0216BF90 // =gameArchiveStage
	strb r3, [r5, #0x40b]
	add r1, r5, #0x400
	ldr r5, [r2, #0]
	ldr r2, _0216BF94 // =aBoss4CoreNsbma
	mov r0, r4
	str r5, [sp]
	bl ObjAction3dNNMotionLoad
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	add r0, r4, #0x3c8
	ldr r2, [r4, #0x914]
	add r0, r0, #0x400
	mov r1, #1
	bl BossHelpers__SetAnimation
	ldr r2, _0216BF90 // =gameArchiveStage
	ldr r1, _0216BF98 // =aExc_5
	ldr r2, [r2, #0]
	add r0, sp, #0xc
	bl NNS_FndMountArchive
	add r0, sp, #0xc
	mov r1, #0xc
	bl NNS_FndGetArchiveFileByIndex
	ldr r1, _0216BF9C // =bossAssetFiles
	mov r5, r0
	ldr r0, [r1, #8]
	bl NNS_G3dGetTex
	ldr r1, _0216BFA0 // =_0217ABB0
	ldr r1, [r1, #0]
	bl Asset3DSetup__PaletteFromName
	mov r1, #5
	str r1, [sp]
	mov r2, #0
	str r0, [sp, #4]
	add r0, r4, #0x3a4
	mov r1, r5
	add r0, r0, #0x400
	mov r3, r2
	bl InitPaletteAnimator
	add r0, r4, #0x3a4
	mov r2, #0
	add r0, r0, #0x400
	mov r1, #1
	mov r3, r2
	bl BossHelpers__SetPaletteAnimations
	add r0, sp, #0xc
	bl NNS_FndUnmountArchive
	mov r0, r4
	bl ovl01_216E890
	mov r0, r4
	add sp, sp, #0x74
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216BF64: .word 0x00000944
_0216BF68: .word StageTask_Main
_0216BF6C: .word ovl01_216E498
_0216BF70: .word _0217AFB0
_0216BF74: .word ovl01_216E408
_0216BF78: .word ovl01_216E4E0
_0216BF7C: .word ovl01_216E594
_0216BF80: .word ovl01_216E7F4
_0216BF84: .word 0x02133A10
_0216BF88: .word _0217ACD8
_0216BF8C: .word 0x000034CC
_0216BF90: .word gameArchiveStage
_0216BF94: .word aBoss4CoreNsbma
_0216BF98: .word aExc_5
_0216BF9C: .word bossAssetFiles
_0216BFA0: .word _0217ABB0
	arm_func_end Boss4Core__Create

	arm_func_start Boss4Ship__Create
Boss4Ship__Create: // 0x0216BFA4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	ldr r0, _0216C1A4 // =StageTask_Main
	ldr r1, _0216C1A8 // =ovl01_216E13C
	mov r3, r2
	str r4, [sp, #4]
	mov r4, #0x600
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x600
	bl MIi_CpuClear16
	ldr r0, _0216C1AC // =_0217AFB0
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r1, r7
	str r0, [r4, #0x37c]
	mov r0, r4
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, _0216C1B0 // =ovl01_216E118
	ldr r0, _0216C1B4 // =ovl01_216E170
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r0, [r4, #0x18]
	mov r3, #0x1000
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	mov r1, #0
	orr r0, r0, #0x180
	str r0, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	add r0, r4, #0x7c
	orr r2, r2, #0x9f00
	str r2, [r4, #0x1c]
	add r2, r0, #0x400
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	str r3, [r4, #0x40]
	str r6, [r4, #0x44]
	str r5, [r4, #0x48]
	str r1, [r4, #0x4c]
	ldr r1, _0216C1B8 // =0x00000222
	add r0, r4, #0x400
	strh r1, [r0, #0x7c]
	mov r0, #0xb6
	strh r0, [r2, #4]
	add r0, r4, #0x364
	bl ovl01_216C920
	str r4, [r4, #0x380]
	add r2, r4, #0x380
	ldr r1, [r4, #0x368]
	mov r0, #0x240
	str r1, [r2, #0x24]
	strh r0, [r2, #0x30]
	mov r1, #0x80
	strh r1, [r2, #0x32]
	sub r0, r1, #0x1d0
	strh r0, [r2, #0x18]
	sub r0, r1, #0xf0
	strh r0, [r2, #0x1a]
	ldr r0, [r2, #0x1c]
	orr r0, r0, #4
	str r0, [r2, #0x1c]
	ldr r0, _0216C1BC // =StageTask__DefaultDiffData
	str r4, [r4, #0x3e4]
	add r2, r4, #0x3e4
	mov r1, #0x1a8
	str r0, [r2, #0x24]
	mov r0, #8
	strh r1, [r2, #0x30]
	strh r0, [r2, #0x32]
	sub r0, r0, #0x100
	strh r0, [r2, #0x18]
	rsb r0, r1, #0x59
	add r5, r4, #0x84
	strh r0, [r2, #0x1a]
	mov r0, #1
	strh r0, [r2, #0x22]
	ldr r0, [r2, #0x1c]
	ldr r1, _0216C1C0 // =0x02133A18
	orr r0, r0, #4
	str r0, [r2, #0x1c]
	ldr r2, _0216C1C4 // =_0217ACD8
	mov r0, r4
	str r1, [sp]
	mov r3, #0
	add r1, r5, #0x400
	str r3, [sp, #4]
	bl ObjAction3dNNModelLoad
	mov r2, #0
	ldr r0, _0216C1C8 // =0x000034CC
	str r2, [r4, #0x12c]
	str r0, [r5, #0x418]
	str r0, [r5, #0x41c]
	str r0, [r5, #0x420]
	mov r0, #4
	strb r0, [r5, #0x40a]
	strb r2, [r5, #0x40b]
	mov r0, #3
	ldr r1, _0216C1CC // =BossHelpers__Model__RenderCallback
	str r0, [sp]
	add r0, r5, #0x490
	mov r3, #6
	bl NNS_G3dRenderObjSetCallBack
	ldr r0, [r5, #0x494]
	mov r3, #0
	ldr r1, _0216C1D0 // =aMast
	mov r2, #0x1e
	str r3, [sp]
	bl BossHelpers__Model__Init
	ldr r1, _0216C1D4 // =ovl01_216E378
	mov r0, r4
	str r1, [r4, #0x478]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216C1A4: .word StageTask_Main
_0216C1A8: .word ovl01_216E13C
_0216C1AC: .word _0217AFB0
_0216C1B0: .word ovl01_216E118
_0216C1B4: .word ovl01_216E170
_0216C1B8: .word 0x00000222
_0216C1BC: .word StageTask__DefaultDiffData
_0216C1C0: .word 0x02133A18
_0216C1C4: .word _0217ACD8
_0216C1C8: .word 0x000034CC
_0216C1CC: .word BossHelpers__Model__RenderCallback
_0216C1D0: .word aMast
_0216C1D4: .word ovl01_216E378
	arm_func_end Boss4Ship__Create

	arm_func_start Boss4Pulley__Create
Boss4Pulley__Create: // 0x0216C1D8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r4, #0x1500
	mov r8, r0
	mov r7, r1
	mov r6, r2
	str r4, [sp]
	mov r0, #2
	ldr r4, _0216C3CC // =0x0000053C
	str r0, [sp, #4]
	ldr r0, _0216C3D0 // =StageTask_Main
	ldr r1, _0216C3D4 // =ovl01_216DDB4
	mov r2, #0
	mov r5, r3
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	ldr r2, _0216C3CC // =0x0000053C
	bl MIi_CpuClear16
	ldr r0, _0216C3D8 // =_0217AFB0
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r1, r8
	str r0, [r4, #0x37c]
	mov r0, r4
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	ldr r1, _0216C3DC // =ovl01_216DC60
	ldr r0, _0216C3E0 // =ovl01_216DDE0
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r0, _0216C3E4 // =ovl01_216DEA4
	mov r2, #0x1000
	str r0, [r4, #0x108]
	ldr r0, [r4, #0x18]
	mov r1, #0
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r3, [r4, #0x20]
	add r0, r4, #0x364
	orr r3, r3, #0x180
	str r3, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	orr r3, r3, #0x9f00
	str r3, [r4, #0x1c]
	str r2, [r4, #0x38]
	str r2, [r4, #0x3c]
	str r2, [r4, #0x40]
	str r7, [r4, #0x44]
	str r6, [r4, #0x48]
	str r1, [r4, #0x4c]
	str r5, [r4, #0x380]
	bl ovl01_216C920
	add r0, r4, #0x218
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	mov r1, #2
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r0, #0xc
	str r0, [sp]
	str r0, [sp, #4]
	mov r2, #8
	str r2, [sp, #8]
	add r0, r4, #0x218
	sub r1, r2, #0x14
	sub r3, r2, #0x10
	mov r2, r1
	bl ObjRect__SetBox3D
	ldr r0, _0216C3E8 // =ovl01_216DEE8
	str r4, [r4, #0x234]
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	ldr r1, _0216C3EC // =0x02133A18
	orr r0, r0, #4
	str r0, [r4, #0x230]
	ldr r0, [r4, #0x380]
	ldr r2, _0216C3F0 // =_0217ACD8
	cmp r0, #0
	moveq r3, #3
	str r1, [sp]
	mov r5, #0
	movne r3, #2
	mov r0, r4
	add r1, r4, #0x3c0
	str r5, [sp, #4]
	bl ObjAction3dNNModelLoad
	mov r2, r5
	ldr r0, _0216C3F4 // =0x000034CC
	str r2, [r4, #0x12c]
	str r0, [r4, #0x3d8]
	str r0, [r4, #0x3dc]
	str r0, [r4, #0x3e0]
	mov r0, #8
	strb r0, [r4, #0x3ca]
	ldr r1, _0216C3F8 // =BossHelpers__Model__RenderCallback
	strb r2, [r4, #0x3cb]
	mov r5, #3
	add r0, r4, #0x450
	mov r3, #6
	str r5, [sp]
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0x454]
	ldr r1, _0216C3FC // =aCenter2
	mov r2, #0x1e
	bl BossHelpers__Model__Init
	ldr r2, _0216C400 // =FX_SinCosTable_+0x00003000
	add r0, r4, #0x3e4
	ldrsh r1, [r2, #0]
	ldrsh r2, [r2, #2]
	bl MTX_RotY33_
	mov r0, r4
	bl ovl01_216DF24
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216C3CC: .word 0x0000053C
_0216C3D0: .word StageTask_Main
_0216C3D4: .word ovl01_216DDB4
_0216C3D8: .word _0217AFB0
_0216C3DC: .word ovl01_216DC60
_0216C3E0: .word ovl01_216DDE0
_0216C3E4: .word ovl01_216DEA4
_0216C3E8: .word ovl01_216DEE8
_0216C3EC: .word 0x02133A18
_0216C3F0: .word _0217ACD8
_0216C3F4: .word 0x000034CC
_0216C3F8: .word BossHelpers__Model__RenderCallback
_0216C3FC: .word aCenter2
_0216C400: .word FX_SinCosTable_+0x00003000
	arm_func_end Boss4Pulley__Create

	arm_func_start Boss4FireColumn__Create
Boss4FireColumn__Create: // 0x0216C404
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r0, #2
	ldr r4, _0216C628 // =0x000004E8
	str r0, [sp, #4]
	ldr r0, _0216C62C // =StageTask_Main
	ldr r1, _0216C630 // =ovl01_216DB28
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	ldr r2, _0216C628 // =0x000004E8
	bl MIi_CpuClear16
	mov r1, r7
	mov r0, r4
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, _0216C634 // =ovl01_216D9D4
	ldr r0, _0216C638 // =ovl01_216DB68
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r0, [r4, #0x18]
	mov r2, #0x1000
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	mov r1, #0
	orr r0, r0, #0x1a0
	str r0, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	add r0, r4, #0x218
	orr r3, r3, #0x9f00
	str r3, [r4, #0x1c]
	str r2, [r4, #0x38]
	str r2, [r4, #0x3c]
	str r2, [r4, #0x40]
	str r6, [r4, #0x44]
	str r5, [r4, #0x48]
	str r1, [r4, #0x4c]
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	mov r1, #3
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	mov r0, #2
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r3, #0x20
	str r3, [sp, #8]
	add r0, r4, #0x218
	sub r1, r3, #0x22
	sub r2, r3, #0x278
	sub r3, r3, #0x40
	bl ObjRect__SetBox3D
	str r4, [r4, #0x234]
	ldr r0, [r4, #0x230]
	bic r0, r0, #4
	str r0, [r4, #0x230]
	mov r3, #0
	ldr r0, _0216C63C // =gameArchiveStage
	str r3, [sp]
	ldr r5, [r0, #0]
	ldr r2, _0216C640 // =aBsef4FcolNsbmd
	mov r0, r4
	add r1, r4, #0x36c
	str r5, [sp, #4]
	bl ObjAction3dNNModelLoad
	mov r1, #0
	ldr r0, _0216C644 // =0x000034CC
	str r1, [r4, #0x12c]
	str r0, [r4, #0x384]
	str r0, [r4, #0x388]
	str r0, [r4, #0x38c]
	mov r0, #8
	strb r0, [r4, #0x376]
	strb r1, [r4, #0x377]
	bl ovl01_216D064
	cmp r0, #1
	bne _0216C57C
	ldr r0, [r4, #0x4b0]
	bl Asset3DSetup__Create
_0216C57C:
	ldr r0, _0216C63C // =gameArchiveStage
	ldr r2, _0216C648 // =aBsef4FcolNsbca
	ldr r5, [r0, #0]
	mov r0, r4
	add r1, r4, #0x36c
	mov r3, #0
	str r5, [sp]
	bl ObjAction3dNNMotionLoad
	ldr r0, _0216C63C // =gameArchiveStage
	ldr r2, _0216C64C // =aBsef4FcolNsbma
	ldr r5, [r0, #0]
	mov r0, r4
	add r1, r4, #0x36c
	mov r3, #0
	str r5, [sp]
	bl ObjAction3dNNMotionLoad
	ldr r0, _0216C63C // =gameArchiveStage
	ldr r2, _0216C650 // =aBsef4FcolNsbta
	ldr r5, [r0, #0]
	mov r0, r4
	add r1, r4, #0x36c
	mov r3, #0
	str r5, [sp]
	bl ObjAction3dNNMotionLoad
	ldr r1, _0216C63C // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	add r1, r4, #0x36c
	str r2, [sp]
	ldr r2, _0216C654 // =aBsef4FcolNsbtp
	mov r3, #0
	bl ObjAction3dNNMotionLoad
	ldr r1, _0216C63C // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	add r1, r4, #0x36c
	str r2, [sp]
	ldr r2, _0216C658 // =aBsef4FcolNsbva
	mov r3, #0
	bl ObjAction3dNNMotionLoad
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216C628: .word 0x000004E8
_0216C62C: .word StageTask_Main
_0216C630: .word ovl01_216DB28
_0216C634: .word ovl01_216D9D4
_0216C638: .word ovl01_216DB68
_0216C63C: .word gameArchiveStage
_0216C640: .word aBsef4FcolNsbmd
_0216C644: .word 0x000034CC
_0216C648: .word aBsef4FcolNsbca
_0216C64C: .word aBsef4FcolNsbma
_0216C650: .word aBsef4FcolNsbta
_0216C654: .word aBsef4FcolNsbtp
_0216C658: .word aBsef4FcolNsbva
	arm_func_end Boss4FireColumn__Create

	arm_func_start Boss4FireBall__Create
Boss4FireBall__Create: // 0x0216C65C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r4, #0x1500
	mov r8, r0
	mov r7, r1
	mov r6, r2
	str r4, [sp]
	mov r0, #2
	ldr r4, _0216C8F0 // =0x000004EC
	str r0, [sp, #4]
	ldr r0, _0216C8F4 // =StageTask_Main
	ldr r1, _0216C8F8 // =ovl01_216D93C
	mov r2, #0
	mov r5, r3
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	ldr r2, _0216C8F0 // =0x000004EC
	bl MIi_CpuClear16
	mov r1, r8
	mov r0, r4
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	ldr r1, _0216C8FC // =ovl01_216D6B4
	ldr r0, _0216C900 // =ovl01_216D97C
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r0, [r4, #0x18]
	mov r2, #0x1000
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	mov r1, #0
	orr r0, r0, #0x1a0
	str r0, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	add r0, r4, #0x300
	orr r3, r3, #0x9f00
	str r3, [r4, #0x1c]
	str r2, [r4, #0x38]
	str r2, [r4, #0x3c]
	str r2, [r4, #0x40]
	str r7, [r4, #0x44]
	str r6, [r4, #0x48]
	str r1, [r4, #0x4c]
	strh r5, [r0, #0x6c]
	add r0, r4, #0x218
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	mov r1, #3
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	mov r0, #0xc
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r3, #4
	str r3, [sp, #8]
	add r0, r4, #0x218
	sub r1, r3, #0x10
	sub r2, r3, #0x1c
	sub r3, r3, #8
	bl ObjRect__SetBox3D
	str r4, [r4, #0x234]
	ldr r0, [r4, #0x230]
	orr r0, r0, #4
	str r0, [r4, #0x230]
	mov r3, #0
	ldr r0, _0216C904 // =gameArchiveStage
	str r3, [sp]
	ldr r5, [r0, #0]
	ldr r2, _0216C908 // =aBsef4FballNsbm
	mov r0, r4
	add r1, r4, #0x370
	str r5, [sp, #4]
	bl ObjAction3dNNModelLoad
	mov r1, #0
	ldr r0, _0216C90C // =0x00001A66
	str r1, [r4, #0x12c]
	str r0, [r4, #0x388]
	str r0, [r4, #0x38c]
	str r0, [r4, #0x390]
	mov r0, #8
	strb r0, [r4, #0x37a]
	strb r1, [r4, #0x37b]
	bl ovl01_216D000
	cmp r0, #1
	bne _0216C7E0
	ldr r0, [r4, #0x4b4]
	bl Asset3DSetup__Create
_0216C7E0:
	ldr r0, _0216C904 // =gameArchiveStage
	ldr r2, _0216C910 // =aBsef4FballNsbc
	ldr r5, [r0, #0]
	mov r0, r4
	add r1, r4, #0x370
	mov r3, #0
	str r5, [sp]
	bl ObjAction3dNNMotionLoad
	ldr r0, _0216C904 // =gameArchiveStage
	ldr r2, _0216C914 // =aBsef4FballNsbm_0
	ldr r5, [r0, #0]
	mov r0, r4
	add r1, r4, #0x370
	mov r3, #0
	str r5, [sp]
	bl ObjAction3dNNMotionLoad
	ldr r0, _0216C904 // =gameArchiveStage
	ldr r2, _0216C918 // =aBsef4FballNsbt
	ldr r5, [r0, #0]
	mov r0, r4
	add r1, r4, #0x370
	mov r3, #0
	str r5, [sp]
	bl ObjAction3dNNMotionLoad
	ldr r1, _0216C904 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	add r1, r4, #0x370
	str r2, [sp]
	ldr r2, _0216C91C // =aBsef4FballNsbt_0
	mov r3, #0
	bl ObjAction3dNNMotionLoad
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x370
	ldr r2, [r4, #0x4b8]
	mov r3, r1
	bl BossHelpers__SetAnimation
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	add r0, r4, #0x370
	mov r1, #1
	ldr r2, [r4, #0x4bc]
	bl BossHelpers__SetAnimation
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	add r0, r4, #0x370
	mov r1, #3
	ldr r2, [r4, #0x4c4]
	bl BossHelpers__SetAnimation
	ldr r0, [r4, #0x4b4]
	bl NNS_G3dGetTex
	str r0, [sp]
	mov r3, #0
	str r3, [sp, #4]
	add r0, r4, #0x370
	mov r1, #2
	ldr r2, [r4, #0x4c0]
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216C8F0: .word 0x000004EC
_0216C8F4: .word StageTask_Main
_0216C8F8: .word ovl01_216D93C
_0216C8FC: .word ovl01_216D6B4
_0216C900: .word ovl01_216D97C
_0216C904: .word gameArchiveStage
_0216C908: .word aBsef4FballNsbm
_0216C90C: .word 0x00001A66
_0216C910: .word aBsef4FballNsbc
_0216C914: .word aBsef4FballNsbm_0
_0216C918: .word aBsef4FballNsbt
_0216C91C: .word aBsef4FballNsbt_0
	arm_func_end Boss4FireBall__Create

	arm_func_start ovl01_216C920
ovl01_216C920: // 0x0216C920
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x68
	mov r4, r0
	bl MapFarSys__GetAsset
	str r0, [r4]
	ldr r1, _0216C9A8 // =gameArchiveStage
	add r0, sp, #0
	ldr r2, [r1, #0]
	ldr r1, _0216C9AC // =aExc_5
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #0xa
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #4]
	add r0, sp, #0
	mov r1, #0xb
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #8]
	add r0, sp, #0
	mov r1, #7
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0xc]
	add r0, sp, #0
	mov r1, #8
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0x10]
	add r0, sp, #0
	mov r1, #9
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0x14]
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	add sp, sp, #0x68
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216C9A8: .word gameArchiveStage
_0216C9AC: .word aExc_5
	arm_func_end ovl01_216C920

	arm_func_start ovl01_216C9B0
ovl01_216C9B0: // 0x0216C9B0
	add r0, r0, #0x300
	ldrsh r3, [r0, #0x94]
	ldr r2, _0216C9E8 // =_02179EBC
	mov r0, #0
_0216C9C0:
	mov r1, r0, lsl #1
	ldrh r1, [r2, r1]
	cmp r1, r3
	bxle lr
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #3
	blo _0216C9C0
	bx lr
	.align 2, 0
_0216C9E8: .word _02179EBC
	arm_func_end ovl01_216C9B0

	arm_func_start ovl01_216C9EC
ovl01_216C9EC: // 0x0216C9EC
	ldr r0, _0216CA04 // =gameState
	ldr r1, _0216CA08 // =_02179EB0
	ldr r0, [r0, #0x18]
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_0216CA04: .word gameState
_0216CA08: .word _02179EB0
	arm_func_end ovl01_216C9EC

	arm_func_start ovl01_216CA0C
ovl01_216CA0C: // 0x0216CA0C
	stmdb sp!, {r3, lr}
	ldr r1, _0216CA5C // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r2, [r1, #0x70]
	cmpeq r2, #0xf
	bne _0216CA3C
	ldr r1, [r1, #0x18]
	ldr r0, _0216CA60 // =_02179F26
	mov r1, r1, lsl #3
	ldrsh r0, [r0, r1]
	ldmia sp!, {r3, pc}
_0216CA3C:
	bl ovl01_216C9B0
	ldr r1, _0216CA5C // =gameState
	ldr r2, _0216CA64 // =_02179F10
	ldr r3, [r1, #0x18]
	mov r1, r0, lsl #1
	add r0, r2, r3, lsl #3
	ldrsh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216CA5C: .word gameState
_0216CA60: .word _02179F26
_0216CA64: .word _02179F10
	arm_func_end ovl01_216CA0C

	arm_func_start ovl01_216CA68
ovl01_216CA68: // 0x0216CA68
	stmdb sp!, {r3, lr}
	ldr r1, _0216CAB8 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r2, [r1, #0x70]
	cmpeq r2, #0xf
	bne _0216CA98
	ldr r1, [r1, #0x18]
	ldr r0, _0216CABC // =_02179F56
	mov r1, r1, lsl #3
	ldrsh r0, [r0, r1]
	ldmia sp!, {r3, pc}
_0216CA98:
	bl ovl01_216C9B0
	ldr r1, _0216CAB8 // =gameState
	ldr r2, _0216CAC0 // =_02179F40
	ldr r3, [r1, #0x18]
	mov r1, r0, lsl #1
	add r0, r2, r3, lsl #3
	ldrsh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216CAB8: .word gameState
_0216CABC: .word _02179F56
_0216CAC0: .word _02179F40
	arm_func_end ovl01_216CA68

	arm_func_start ovl01_216CAC4
ovl01_216CAC4: // 0x0216CAC4
	stmdb sp!, {r3, lr}
	ldr r1, _0216CB14 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r2, [r1, #0x70]
	cmpeq r2, #0xf
	bne _0216CAF4
	ldr r1, [r1, #0x18]
	ldr r0, _0216CB18 // =_02179EE6
	mov r1, r1, lsl #3
	ldrsh r0, [r0, r1]
	ldmia sp!, {r3, pc}
_0216CAF4:
	bl ovl01_216C9B0
	ldr r1, _0216CB14 // =gameState
	ldr r2, _0216CB1C // =_02179ED0
	ldr r3, [r1, #0x18]
	mov r1, r0, lsl #1
	add r0, r2, r3, lsl #3
	ldrsh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216CB14: .word gameState
_0216CB18: .word _02179EE6
_0216CB1C: .word _02179ED0
	arm_func_end ovl01_216CAC4

	arm_func_start ovl01_216CB20
ovl01_216CB20: // 0x0216CB20
	stmdb sp!, {r3, lr}
	ldr r1, _0216CB70 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r2, [r1, #0x70]
	cmpeq r2, #0xf
	bne _0216CB50
	ldr r1, [r1, #0x18]
	ldr r0, _0216CB74 // =_02179EF6
	mov r1, r1, lsl #3
	ldrh r0, [r0, r1]
	ldmia sp!, {r3, pc}
_0216CB50:
	bl ovl01_216C9B0
	ldr r1, _0216CB70 // =gameState
	ldr r2, _0216CB78 // =_02179EF0
	ldr r3, [r1, #0x18]
	mov r1, r0, lsl #1
	add r0, r2, r3, lsl #3
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216CB70: .word gameState
_0216CB74: .word _02179EF6
_0216CB78: .word _02179EF0
	arm_func_end ovl01_216CB20

	arm_func_start ovl01_216CB7C
ovl01_216CB7C: // 0x0216CB7C
	ldr r0, _0216CBC0 // =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #3
	ldreq r1, [r0, #0x70]
	cmpeq r1, #0xf
	bne _0216CBA8
	ldr r1, [r0, #0x18]
	ldr r0, _0216CBC4 // =_02179EB8
	mov r1, r1, lsl #1
	ldrh r0, [r0, r1]
	bx lr
_0216CBA8:
	ldr r0, _0216CBC0 // =gameState
	ldr r1, _0216CBC8 // =_02179EB4
	ldr r0, [r0, #0x18]
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_0216CBC0: .word gameState
_0216CBC4: .word _02179EB8
_0216CBC8: .word _02179EB4
	arm_func_end ovl01_216CB7C

	arm_func_start ovl01_216CBCC
ovl01_216CBCC: // 0x0216CBCC
	stmdb sp!, {r4, lr}
	ldr r3, _0216CC10 // =_mt_math_rand
	ldr r1, _0216CC14 // =0x00196225
	ldr ip, [r3]
	ldr r2, _0216CC18 // =0x3C6EF35F
	mla r2, ip, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	str r2, [r3]
	mov r4, r1, lsr #0x10
	bl ovl01_216C9B0
	ldr r2, _0216CC1C // =_02179F80
	mov r1, r4, lsl #0x1e
	mov r1, r1, lsr #0x1d
	add r0, r2, r0, lsl #3
	ldrh r0, [r1, r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216CC10: .word _mt_math_rand
_0216CC14: .word 0x00196225
_0216CC18: .word 0x3C6EF35F
_0216CC1C: .word _02179F80
	arm_func_end ovl01_216CBCC

	arm_func_start ovl01_216CC20
ovl01_216CC20: // 0x0216CC20
	stmdb sp!, {r4, lr}
	ldr r1, _0216CCB4 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r1, [r1, #0x70]
	cmpeq r1, #0xf
	bne _0216CC74
	ldr r2, _0216CCB8 // =_mt_math_rand
	ldr r0, _0216CCBC // =0x00196225
	ldr ip, [r2]
	ldr r1, _0216CCC0 // =0x3C6EF35F
	ldr r3, _0216CCC4 // =_02179F78
	mla r1, ip, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1d
	str r1, [r2]
	ldrh r0, [r3, r0]
	ldmia sp!, {r4, pc}
_0216CC74:
	ldr r3, _0216CCB8 // =_mt_math_rand
	ldr r1, _0216CCBC // =0x00196225
	ldr ip, [r3]
	ldr r2, _0216CCC0 // =0x3C6EF35F
	mla r2, ip, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	str r2, [r3]
	mov r4, r1, lsr #0x10
	bl ovl01_216C9B0
	ldr r2, _0216CCC8 // =_02179F60
	mov r1, r4, lsl #0x1e
	mov r1, r1, lsr #0x1d
	add r0, r2, r0, lsl #3
	ldrh r0, [r1, r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216CCB4: .word gameState
_0216CCB8: .word _mt_math_rand
_0216CCBC: .word 0x00196225
_0216CCC0: .word 0x3C6EF35F
_0216CCC4: .word _02179F78
_0216CCC8: .word _02179F60
	arm_func_end ovl01_216CC20

	arm_func_start ovl01_216CCCC
ovl01_216CCCC: // 0x0216CCCC
	stmdb sp!, {r3, lr}
	ldr r1, _0216CD1C // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r2, [r1, #0x70]
	cmpeq r2, #0xf
	bne _0216CCFC
	ldr r1, [r1, #0x18]
	ldr r0, _0216CD20 // =_02179F36
	mov r1, r1, lsl #3
	ldrh r0, [r0, r1]
	ldmia sp!, {r3, pc}
_0216CCFC:
	bl ovl01_216C9B0
	ldr r1, _0216CD1C // =gameState
	ldr r2, _0216CD24 // =_02179F30
	ldr r3, [r1, #0x18]
	mov r1, r0, lsl #1
	add r0, r2, r3, lsl #3
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216CD1C: .word gameState
_0216CD20: .word _02179F36
_0216CD24: .word _02179F30
	arm_func_end ovl01_216CCCC

	arm_func_start ovl01_216CD28
ovl01_216CD28: // 0x0216CD28
	stmdb sp!, {r3, lr}
	ldr r1, _0216CD78 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r2, [r1, #0x70]
	cmpeq r2, #0xf
	bne _0216CD58
	ldr r1, [r1, #0x18]
	ldr r0, _0216CD7C // =_02179F06
	mov r1, r1, lsl #3
	ldrsh r0, [r0, r1]
	ldmia sp!, {r3, pc}
_0216CD58:
	bl ovl01_216C9B0
	ldr r1, _0216CD78 // =gameState
	ldr r2, _0216CD80 // =_02179F00
	ldr r3, [r1, #0x18]
	mov r1, r0, lsl #1
	add r0, r2, r3, lsl #3
	ldrsh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216CD78: .word gameState
_0216CD7C: .word _02179F06
_0216CD80: .word _02179F00
	arm_func_end ovl01_216CD28

	arm_func_start ovl01_216CD84
ovl01_216CD84: // 0x0216CD84
	ldr r0, _0216CDA4 // =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #3
	ldreq r0, [r0, #0x70]
	cmpeq r0, #0xf
	ldreq r0, _0216CDA8 // =0x00000133
	movne r0, #0xcc
	bx lr
	.align 2, 0
_0216CDA4: .word gameState
_0216CDA8: .word 0x00000133
	arm_func_end ovl01_216CD84

	arm_func_start ovl01_216CDAC
ovl01_216CDAC: // 0x0216CDAC
	ldr r0, _0216CDCC // =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #3
	ldreq r0, [r0, #0x70]
	cmpeq r0, #0xf
	ldreq r0, _0216CDD0 // =0x000004CC
	ldrne r0, _0216CDD4 // =0x00000333
	bx lr
	.align 2, 0
_0216CDCC: .word gameState
_0216CDD0: .word 0x000004CC
_0216CDD4: .word 0x00000333
	arm_func_end ovl01_216CDAC

	arm_func_start ovl01_216CDD8
ovl01_216CDD8: // 0x0216CDD8
	ldr r0, _0216CDF8 // =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #3
	ldreq r0, [r0, #0x70]
	cmpeq r0, #0xf
	ldreq r0, _0216CDFC // =0x00000733
	ldrne r0, _0216CE00 // =0x000004CC
	bx lr
	.align 2, 0
_0216CDF8: .word gameState
_0216CDFC: .word 0x00000733
_0216CE00: .word 0x000004CC
	arm_func_end ovl01_216CDD8

	arm_func_start ovl01_216CE04
ovl01_216CE04: // 0x0216CE04
	ldr r0, _0216CE24 // =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #3
	ldreq r0, [r0, #0x70]
	cmpeq r0, #0xf
	moveq r0, #0x3000
	movne r0, #0x2000
	bx lr
	.align 2, 0
_0216CE24: .word gameState
	arm_func_end ovl01_216CE04

	arm_func_start ovl01_216CE28
ovl01_216CE28: // 0x0216CE28
	ldrh r1, [r0, #0]
	cmp r1, #1
	bne _0216CE50
	add r1, r0, #0x500
	ldrsh r1, [r1, #0xd4]
	cmp r1, #0x10
	cmpne r1, #0x11
	bne _0216CE50
	mov r0, #0
	bx lr
_0216CE50:
	ldr r1, [r0, #0x48]
	ldr r0, [r0, #0x44]
	cmp r1, #0x280000
	bge _0216CE70
	cmp r0, #0x200000
	movlt r0, #3
	movge r0, #4
	bx lr
_0216CE70:
	cmp r0, #0x200000
	movlt r0, #1
	movge r0, #2
	bx lr
	arm_func_end ovl01_216CE28

	arm_func_start ovl01_216CE80
ovl01_216CE80: // 0x0216CE80
	stmdb sp!, {r3, r4, r5, lr}
	mov r0, #1
	bl BossArena__GetCamera
	mov r5, r0
	bl GetScreenShakeOffsetX
	mov r4, r0
	bl GetScreenShakeOffsetY
	mov r1, r4
	mov r2, r0
	mov r0, r5
	mov r3, #0
	bl BossArena__SetNextPos
	mov r0, #2
	bl BossArena__GetCamera
	mov r5, r0
	bl GetScreenShakeOffsetX
	mov r4, r0
	bl GetScreenShakeOffsetY
	mov r1, r4
	mov r2, r0
	mov r0, r5
	mov r3, #0
	bl BossArena__SetNextPos
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_216CE80

	arm_func_start ovl01_216CEE0
ovl01_216CEE0: // 0x0216CEE0
	stmdb sp!, {r3, lr}
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _0216CF0C
	mov r0, #0x1c
	mov r1, r0
	bl BossArena__Func_2039AB4
	mov r0, #0
	sub r1, r0, #0x46
	bl BossArena__Func_2039A94
	ldmia sp!, {r3, pc}
_0216CF0C:
	mov r0, #0
	mov r1, #0x1c
	bl BossArena__Func_2039AB4
	mov r0, #0
	sub r1, r0, #0x12c
	bl BossArena__Func_2039A94
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_216CEE0

	arm_func_start ovl01_216CF28
ovl01_216CF28: // 0x0216CF28
	stmdb sp!, {r3, lr}
	ldr r0, [r0, #0x37c]
	ldr r0, [r0, #0x798]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r3, pc}
_0216CF40: // jump table
	ldmia sp!, {r3, pc} // case 0
	b _0216CF54 // case 1
	b _0216CF54 // case 2
	b _0216CF60 // case 3
	b _0216CF60 // case 4
_0216CF54:
	mov r0, #1
	bl SetHUDActiveScreen
	ldmia sp!, {r3, pc}
_0216CF60:
	mov r0, #0
	bl SetHUDActiveScreen
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_216CF28

	arm_func_start ovl01_216CF6C
ovl01_216CF6C: // 0x0216CF6C
	ldr r0, [r0, #0x384]
	mov r3, #0x8000
	ldrsh r0, [r0, #0x34]
	mov ip, #0x21c000
	cmp r0, #0
	addgt r3, r3, r0, lsl #5
	bgt _0216CF8C
	addlt ip, ip, r0, lsl #5
_0216CF8C:
	ldrsh r0, [r1, #0xec]
	ldr r2, [r1, #0x44]
	add r0, r2, r0, lsl #12
	cmp r3, r0
	ble _0216CFC8
	ldr r0, [r1, #0x98]
	cmp r0, #0
	movlt r0, #0
	strlt r0, [r1, #0x98]
	ldrsh r0, [r1, #0xec]
	ldr r2, [r1, #0x44]
	add r0, r2, r0, lsl #12
	sub r0, r3, r0
	str r0, [r1, #0xb0]
	bx lr
_0216CFC8:
	ldrsh r0, [r1, #0xf0]
	add r0, r2, r0, lsl #12
	cmp ip, r0
	bxge lr
	ldr r0, [r1, #0x98]
	cmp r0, #0
	movgt r0, #0
	strgt r0, [r1, #0x98]
	ldrsh r0, [r1, #0xf0]
	ldr r2, [r1, #0x44]
	add r0, r2, r0, lsl #12
	sub r0, ip, r0
	str r0, [r1, #0xb0]
	bx lr
	arm_func_end ovl01_216CF6C

	arm_func_start ovl01_216D000
ovl01_216D000: // 0x0216D000
	stmdb sp!, {r3, lr}
	ldr r0, _0216D028 // =_0217AFB0
	ldr r0, [r0, #4]
	bl GetTaskWork_
	add r0, r0, #0x300
	ldrsh r1, [r0, #0xce]
	add r1, r1, #1
	strh r1, [r0, #0xce]
	ldrsh r0, [r0, #0xce]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216D028: .word _0217AFB0
	arm_func_end ovl01_216D000

	arm_func_start ovl01_216D02C
ovl01_216D02C: // 0x0216D02C
	stmdb sp!, {r3, lr}
	ldr r0, _0216D060 // =_0217AFB0
	ldr r0, [r0, #4]
	cmp r0, #0
	mvneq r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetTaskWork_
	add r0, r0, #0x300
	ldrsh r1, [r0, #0xce]
	sub r1, r1, #1
	strh r1, [r0, #0xce]
	ldrsh r0, [r0, #0xce]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216D060: .word _0217AFB0
	arm_func_end ovl01_216D02C

	arm_func_start ovl01_216D064
ovl01_216D064: // 0x0216D064
	stmdb sp!, {r3, lr}
	ldr r0, _0216D08C // =_0217AFB0
	ldr r0, [r0, #4]
	bl GetTaskWork_
	add r0, r0, #0x300
	ldrsh r1, [r0, #0xd0]
	add r1, r1, #1
	strh r1, [r0, #0xd0]
	ldrsh r0, [r0, #0xd0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216D08C: .word _0217AFB0
	arm_func_end ovl01_216D064

	arm_func_start ovl01_216D090
ovl01_216D090: // 0x0216D090
	stmdb sp!, {r3, lr}
	ldr r0, _0216D0C4 // =_0217AFB0
	ldr r0, [r0, #4]
	cmp r0, #0
	mvneq r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetTaskWork_
	add r0, r0, #0x300
	ldrsh r1, [r0, #0xd0]
	sub r1, r1, #1
	strh r1, [r0, #0xd0]
	ldrsh r0, [r0, #0xd0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216D0C4: .word _0217AFB0
	arm_func_end ovl01_216D090

	arm_func_start ovl01_216D0C8
ovl01_216D0C8: // 0x0216D0C8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl01_216CE80
	add r0, r4, #0x39c
	bl BossHelpers__ProcessLights
	ldr r1, _0216D14C // =gPlayer
	mov r0, r4
	ldr r1, [r1, #0]
	bl ovl01_216CF6C
	ldr r1, [r4, #0x37c]
	mov r0, r4
	bl ovl01_216CF6C
	mov r0, r4
	bl ovl01_216CF28
	ldr r1, _0216D14C // =gPlayer
	mov r0, r4
	ldr r3, [r1, #0]
	ldr r2, [r3, #0x1c]
	orr r2, r2, #0x1000
	str r2, [r3, #0x1c]
	ldr r3, [r1, #0]
	ldr r2, [r3, #0x5d8]
	bic r2, r2, #0x800
	str r2, [r3, #0x5d8]
	ldr r2, [r1, #0]
	ldr r1, [r2, #0x5d8]
	orr r1, r1, #0x1000
	str r1, [r2, #0x5d8]
	ldr r1, [r4, #0x390]
	blx r1
	mov r0, r4
	bl ovl01_216CEE0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216D14C: .word gPlayer
	arm_func_end ovl01_216D0C8

	arm_func_start ovl01_216D150
ovl01_216D150: // 0x0216D150
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0xa8
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x300
	ldrsh r0, [r0, #0xce]
	cmp r0, #0
	ble _0216D1B4
	ldr r1, _0216D1E0 // =aExc_4
	add r0, sp, #0
	bl STD_CopyString
	ldr r1, _0216D1E4 // =aBsef4FballNsbm
	add r0, sp, #0
	bl STD_ConcatenateString
	ldr r1, _0216D1E8 // =gameArchiveStage
	add r0, sp, #0x40
	ldr r2, [r1, #0]
	ldr r1, _0216D1EC // =aExc_5
	bl NNS_FndMountArchive
	add r0, sp, #0
	bl NNS_FndGetArchiveFileByName
	bl NNS_G3dResDefaultRelease
	add r0, sp, #0x40
	bl NNS_FndUnmountArchive
_0216D1B4:
	add r0, r4, #0x3d4
	bl BossHelpers__ReleaseAnimation
	add r0, r4, #0x3d4
	bl AnimatorMDL__Release
	ldr r1, _0216D1F0 // =_0217AFB0
	mov r2, #0
	mov r0, r5
	str r2, [r1, #4]
	bl GameObject__Destructor
	add sp, sp, #0xa8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216D1E0: .word aExc_4
_0216D1E4: .word aBsef4FballNsbm
_0216D1E8: .word gameArchiveStage
_0216D1EC: .word aExc_5
_0216D1F0: .word _0217AFB0
	arm_func_end ovl01_216D150

	arm_func_start ovl01_216D1F4
ovl01_216D1F4: // 0x0216D1F4
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	ldmneia sp!, {r4, pc}
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x39c
	bl BossHelpers__RevertModifiedLights
	mov r0, r4
	add r1, r4, #0x3d4
	bl StageTask__Draw3D
	add r0, r4, #0x39c
	bl BossHelpers__ApplyModifiedLights
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216D1F4

	arm_func_start ovl01_216D238
ovl01_216D238: // 0x0216D238
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x2c
	ldr r1, _0216D624 // =_02179EC4
	add r3, sp, #0x20
	mov r5, r0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #4
	bl BossArena__SetType
	add r1, sp, #0
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClear16
	mov r0, #0x1000
	ldr r1, _0216D628 // =0x00001555
	str r0, [sp, #4]
	str r0, [sp, #0x10]
	mov r0, #0x800000
	str r0, [sp, #8]
	mov r0, #1
	strh r1, [sp]
	str r1, [sp, #0xc]
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #1
	bl BossArena__SetCameraType
	mov r0, r4
	add r1, sp, #0
	bl BossArena__SetCameraConfig
	ldr r1, _0216D62C // =gPlayer
	mov r2, #0
	ldr r1, [r1, #0]
	mov r0, r4
	mov r3, r2
	bl BossArena__SetTracker1TargetWork
	mov r0, r4
	mov r1, #1
	bl BossArena__SetTracker1UseObj3D
	ldr r0, _0216D630 // =_0217AFB0
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r1, [r0, #0x398]
	mov r0, r4
	add r2, r1, #0x190000
	mov r1, #0x12c000
	mov r3, #0
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	mov r1, #0xc8000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r4
	mov r1, #0xcc
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	bl BossArena__ApplyAmplitudeXZTarget
	mov r1, #0xa000
	mov r0, r4
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0xcc
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r4
	bl BossArena__ApplyAmplitudeYTarget
	mov r0, r4
	bl BossArena__ApplyAngleTarget
	mov r0, r4
	add r1, sp, #0x20
	bl BossArena__SetUpVector
	bl BossArena__Func_20397E4
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	bl BossArena__UpdateTracker0TargetPos
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #1
	bl BossArena__SetCameraType
	mov r0, r4
	add r1, sp, #0
	bl BossArena__SetCameraConfig
	ldr r1, _0216D62C // =gPlayer
	mov r2, #0
	ldr r1, [r1, #0]
	mov r0, r4
	mov r3, r2
	bl BossArena__SetTracker1TargetWork
	mov r0, r4
	mov r1, #1
	bl BossArena__SetTracker1UseObj3D
	ldr r0, _0216D630 // =_0217AFB0
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r1, [r0, #0x398]
	mov r0, r4
	add r2, r1, #0x50000
	mov r1, #0x12c000
	mov r3, #0
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	mov r1, #0xc8000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r4
	mov r1, #0xcc
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	bl BossArena__ApplyAmplitudeXZTarget
	mov r0, r4
	mov r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0xcc
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r4
	bl BossArena__ApplyAmplitudeYTarget
	mov r0, r4
	bl BossArena__ApplyAngleTarget
	mov r0, r4
	add r1, sp, #0x20
	bl BossArena__SetUpVector
	bl BossArena__Func_20397E4
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	bl BossArena__UpdateTracker0TargetPos
	ldr r2, _0216D634 // =0x0400000A
	mov r0, #2
	ldrh r1, [r2, #0]
	and r1, r1, #0x43
	orr r1, r1, #4
	orr r1, r1, #0x6000
	strh r1, [r2]
	bl BossArena__SetUnknown2Type
	bl BossArena__GetField4A8
	ldr r1, [r5, #0x364]
	str r1, [r0, #4]
	mov r1, #1
	strb r1, [r0, #0x14]
	mov r1, #0
	strh r1, [r0, #0x2c]
	strh r1, [r0, #0x2e]
	ldr r0, [r5, #0x364]
	bl GetBackgroundPixels
	ldr r2, _0216D638 // =VRAMSystem__VRAM_BG
	mov r1, #0
	ldr r2, [r2, #0]
	add r2, r2, #0x4000
	bl LoadCompressedPixels
	ldr r0, [r5, #0x364]
	bl GetBackgroundPalette
	ldr r2, _0216D63C // =VRAMSystem__VRAM_PALETTE_BG
	mov r1, #0
	ldr r2, [r2, #0]
	bl LoadCompressedPalette
	mov r0, #0
	sub r1, r0, #0x60
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
	ldrh r2, [r0, #0x7c]
	ldrh r3, [r4, #0x20]
	add r1, r5, #0x300
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
	ldrsh r0, [r1, #0x94]
	bl UpdateBossHealthHUD
	mov r0, #1
	bl SetHUDActiveScreen
	ldr r0, _0216D640 // =ovl01_216D644
	str r0, [r5, #0x390]
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216D624: .word _02179EC4
_0216D628: .word 0x00001555
_0216D62C: .word gPlayer
_0216D630: .word _0217AFB0
_0216D634: .word 0x0400000A
_0216D638: .word VRAMSystem__VRAM_BG
_0216D63C: .word VRAMSystem__VRAM_PALETTE_BG
_0216D640: .word ovl01_216D644
	arm_func_end ovl01_216D238

	arm_func_start ovl01_216D644
ovl01_216D644: // 0x0216D644
	bx lr
	arm_func_end ovl01_216D644

	arm_func_start ovl01_216D648
ovl01_216D648: // 0x0216D648
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	mov lr, r0
	mov ip, r1
	str r3, [sp, #8]
	mov r4, r2
	str r3, [sp, #0xc]
	ldr r0, _0216D6AC // =0x00000121
	mov r1, lr
	mov r2, ip
	str r3, [sp, #0x10]
	bl GameObject__SpawnObject
	ldr r2, _0216D6B0 // =_0217AFB0
	add r1, r0, #0x300
	ldrh r3, [r2, #0]
	add ip, r3, #1
	and r3, r3, #1
	strh r3, [r1, #0x6c]
	strh ip, [r2]
	str r4, [r0, #0x28]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0216D6AC: .word 0x00000121
_0216D6B0: .word _0217AFB0
	arm_func_end ovl01_216D648

	arm_func_start ovl01_216D6B4
ovl01_216D6B4: // 0x0216D6B4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, [r5, #0x54]
	sub r0, r0, #0x10000
	str r0, [r5, #0x54]
	ldr r0, [r5, #0x368]
	cmp r0, #0
	bne _0216D908
	ldr r0, [r5, #0x2c]
	cmp r0, #0
	ldrgt r0, [r5, #0x20]
	bicgt r0, r0, #0x20
	strgt r0, [r5, #0x20]
	ldr r0, [r5, #0x28]
	str r0, [r5, #0x98]
	ldr r0, [r5, #0x1c]
	tst r0, #1
	ldrne r0, [r5, #0x24]
	orrne r0, r0, #1
	strne r0, [r5, #0x24]
	ldr r0, [r5, #0x24]
	tst r0, #1
	moveq r0, #0x2000
	streq r0, [r5, #0x9c]
	beq _0216D72C
	ldr r0, [r5, #0x1c]
	tst r0, #1
	moveq r0, #0
	streq r0, [r5, #0x98]
_0216D72C:
	bl RenderCore_GetDMARenderCount
	add r1, r5, #0x300
	ldrh r1, [r1, #0x6c]
	and r0, r0, #1
	cmp r1, r0
	bne _0216D7B8
	ldr r0, [r5, #0x1c]
	mov r4, #0
	tst r0, #1
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	ldr r0, [r5, #0x44]
	ldr r1, [r5, #0x48]
	subne r4, r4, #8
	mov r0, r0, asr #0xc
	add r1, r4, r1, asr #12
	mov r2, #0x20
	mov r3, #2
	bl ObjCollisionObjectFastCheckDet
	add r1, r0, r4
	cmp r1, #2
	ble _0216D798
	ldr r0, [r5, #0x1c]
	bic r0, r0, #1
	str r0, [r5, #0x1c]
	b _0216D7B8
_0216D798:
	ldr r2, [r5, #0x1c]
	mov r1, #0
	orr r2, r2, #1
	str r2, [r5, #0x1c]
	ldr r2, [r5, #0xb4]
	add r0, r2, r0, lsl #12
	str r0, [r5, #0xb4]
	str r1, [r5, #0x9c]
_0216D7B8:
	ldr r0, [r5, #0x2c]
	cmp r0, #0x1e
	ble _0216D91C
	ldr r0, _0216D930 // =_0217AFB0
	ldr r4, [r5, #0x48]
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r0, [r0, #0x398]
	rsb r0, r0, #0
	add r0, r0, #0x64000
	cmp r0, r4
	blt _0216D854
	ldr r2, [r5, #0x44]
	cmp r2, #0x32000
	blt _0216D804
	cmp r2, #0x3a000
	bgt _0216D804
	cmp r4, #0x3b0000
	bge _0216D854
_0216D804:
	cmp r2, #0x1dc000
	blt _0216D81C
	cmp r2, #0x1e4000
	bgt _0216D81C
	cmp r4, #0x390000
	bge _0216D854
_0216D81C:
	cmp r2, #0x51000
	blt _0216D834
	cmp r2, #0x59000
	ldrle r0, _0216D934 // =0x0028A000
	cmple r4, r0
	ble _0216D854
_0216D834:
	ldr r1, _0216D938 // =0x001E6000
	cmp r2, r1
	blt _0216D91C
	add r0, r1, #0x8000
	cmp r2, r0
	addle r0, r1, #0xa4000
	cmple r4, r0
	bgt _0216D91C
_0216D854:
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldr r2, [r5, #0x4b8]
	add r0, r5, #0x370
	mov r3, #1
	bl BossHelpers__SetAnimation
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	mov r1, #1
	ldr r2, [r5, #0x4bc]
	mov r3, r1
	add r0, r5, #0x370
	bl BossHelpers__SetAnimation
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	ldr r2, [r5, #0x4c4]
	add r0, r5, #0x370
	mov r1, #3
	mov r3, #1
	bl BossHelpers__SetAnimation
	ldr r0, [r5, #0x4b4]
	bl NNS_G3dGetTex
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	add r0, r5, #0x370
	mov r1, #2
	ldr r2, [r5, #0x4c0]
	mov r3, #1
	bl BossHelpers__SetAnimation
	ldr r1, [r5, #0x20]
	mov r0, #0
	bic r1, r1, #4
	str r1, [r5, #0x20]
	str r0, [r5, #0x98]
	str r0, [r5, #0x9c]
	ldr r1, [r5, #0x230]
	mov r0, #1
	bic r1, r1, #4
	str r1, [r5, #0x230]
	str r0, [r5, #0x368]
	b _0216D91C
_0216D908:
	ldr r0, [r5, #0x20]
	tst r0, #8
	ldrne r0, [r5, #0x18]
	orrne r0, r0, #8
	strne r0, [r5, #0x18]
_0216D91C:
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216D930: .word _0217AFB0
_0216D934: .word 0x0028A000
_0216D938: .word 0x001E6000
	arm_func_end ovl01_216D6B4

	arm_func_start ovl01_216D93C
ovl01_216D93C: // 0x0216D93C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	bl ovl01_216D02C
	cmp r0, #0
	bne _0216D960
	ldr r0, [r4, #0x4b4]
	bl NNS_G3dResDefaultRelease
_0216D960:
	add r0, r4, #0x370
	bl BossHelpers__ReleaseAnimation
	add r0, r4, #0x370
	bl AnimatorMDL__Release
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_216D93C

	arm_func_start ovl01_216D97C
ovl01_216D97C: // 0x0216D97C
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x20]
	tst r1, #0x20
	ldmneia sp!, {r3, pc}
	add r1, r0, #0x370
	bl StageTask__Draw3D
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_216D97C

	arm_func_start ovl01_216D99C
ovl01_216D99C: // 0x0216D99C
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	mov r2, r1
	str r3, [sp, #0xc]
	mov r1, r0
	mov r0, #0x120
	str r3, [sp, #0x10]
	bl GameObject__SpawnObject
	add sp, sp, #0x14
	ldmia sp!, {pc}
	arm_func_end ovl01_216D99C

	arm_func_start ovl01_216D9D4
ovl01_216D9D4: // 0x0216D9D4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x368]
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	ldmia sp!, {r4, pc}
_0216D9EC: // jump table
	b _0216D9FC // case 0
	b _0216DA14 // case 1
	b _0216DAC8 // case 2
	b _0216DB00 // case 3
_0216D9FC:
	mov r1, #0
	mov r2, r1
	bl ovl01_216DB88
	mov r0, #1
	str r0, [r4, #0x368]
	ldmia sp!, {r4, pc}
_0216DA14:
	ldr r1, [r4, #0x20]
	add r0, r4, #0x218
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x450]
	ldr r1, [r1, #0]
	cmp r1, #0xf000
	ldreq r1, [r0, #0x18]
	orreq r1, r1, #4
	streq r1, [r0, #0x18]
	ldr r1, [r0, #0x18]
	tst r1, #4
	beq _0216DA7C
	ldrsh r1, [r0, #6]
	cmp r1, #0x14
	bge _0216DA7C
	add r1, r1, #2
	strh r1, [r0, #6]
	ldrsh r1, [r0, #0]
	sub r1, r1, #2
	strh r1, [r0]
	ldrsh r1, [r0, #6]
	cmp r1, #0x14
	movgt r1, #0x14
	strgth r1, [r0, #6]
	strgth r1, [r0]
_0216DA7C:
	ldr r0, [r4, #0x20]
	tst r0, #8
	ldmeqia sp!, {r4, pc}
	add ip, r4, #0x218
	ldr r0, [ip, #0x18]
	mov r1, #1
	orr r0, r0, #4
	str r0, [ip, #0x18]
	mov r3, #0x14
	strh r3, [ip, #6]
	sub ip, r3, #0x28
	add r3, r4, #0x200
	mov r0, r4
	mov r2, r1
	strh ip, [r3, #0x18]
	bl ovl01_216DB88
	mov r0, #2
	str r0, [r4, #0x368]
	ldmia sp!, {r4, pc}
_0216DAC8:
	ldr r2, [r4, #0x2c]
	add r1, r2, #1
	str r1, [r4, #0x2c]
	cmp r2, #0x3c
	ldmleia sp!, {r4, pc}
	ldr r2, [r4, #0x230]
	mov r1, #2
	bic r3, r2, #4
	mov r2, #0
	str r3, [r4, #0x230]
	bl ovl01_216DB88
	mov r0, #3
	str r0, [r4, #0x368]
	ldmia sp!, {r4, pc}
_0216DB00:
	ldr r0, [r4, #0x20]
	tst r0, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x18]
	orr r0, r0, #8
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x20
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216D9D4

	arm_func_start ovl01_216DB28
ovl01_216DB28: // 0x0216DB28
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	bl ovl01_216D090
	cmp r0, #0
	bne _0216DB4C
	ldr r0, [r4, #0x4b0]
	bl NNS_G3dResDefaultRelease
_0216DB4C:
	add r0, r4, #0x36c
	bl BossHelpers__ReleaseAnimation
	add r0, r4, #0x36c
	bl AnimatorMDL__Release
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_216DB28

	arm_func_start ovl01_216DB68
ovl01_216DB68: // 0x0216DB68
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x20]
	tst r1, #0x20
	ldmneia sp!, {r3, pc}
	add r1, r0, #0x36c
	bl StageTask__Draw3D
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_216DB68

	arm_func_start ovl01_216DB88
ovl01_216DB88: // 0x0216DB88
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, [r5, #0x20]
	mov r4, r1
	cmp r2, #0
	orrne r0, r0, #4
	biceq r0, r0, #4
	str r0, [r5, #0x20]
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldr r2, [r5, #0x4b4]
	mov r3, r4
	add r0, r5, #0x36c
	bl BossHelpers__SetAnimation
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	ldr r2, [r5, #0x4b8]
	mov r3, r4
	add r0, r5, #0x36c
	mov r1, #1
	bl BossHelpers__SetAnimation
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	ldr r2, [r5, #0x4c0]
	mov r3, r4
	add r0, r5, #0x36c
	mov r1, #3
	bl BossHelpers__SetAnimation
	ldr r0, [r5, #0x400]
	bl NNS_G3dGetTex
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	ldr r2, [r5, #0x4c0]
	add r0, r5, #0x36c
	mov r1, #2
	mov r3, r4
	bl BossHelpers__SetAnimation
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	ldr r2, [r5, #0x4c4]
	mov r3, r4
	add r0, r5, #0x36c
	mov r1, #4
	bl BossHelpers__SetAnimation
	mov r0, #0x1000
	str r0, [r5, #0x484]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_216DB88

	arm_func_start ovl01_216DC60
ovl01_216DC60: // 0x0216DC60
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, [r0, #0x37c]
	ldr r1, [r1, #0x384]
	ldr r3, [r1, #0x470]
	ldr r4, [r1, #0x474]
	ldr r2, [r1, #0x46c]
	rsb r3, r3, #0
	str r2, [r0, #0x44]
	str r3, [r0, #0x48]
	str r4, [r0, #0x4c]
	ldr r2, [r0, #0x380]
	mov r3, #0
	cmp r2, #0
	ldrh r2, [r1, #0x34]
	bne _0216DD20
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	ldr r5, _0216DDB0 // =FX_SinCosTable_
	mov r2, r2, lsl #1
	ldrsh r4, [r5, r2]
	mov r2, #0xd0000
	ldr lr, [r0, #0x44]
	umull ip, r6, r4, r2
	mla r6, r4, r3, r6
	mov r4, r4, asr #0x1f
	mla r6, r4, r2, r6
	adds ip, ip, #0x800
	adc r4, r6, #0
	mov r6, ip, lsr #0xc
	orr r6, r6, r4, lsl #20
	sub r4, lr, r6
	str r4, [r0, #0x44]
	ldrh r4, [r1, #0x34]
	ldr r1, [r0, #0x48]
	mov r4, r4, asr #4
	mov r4, r4, lsl #2
	ldrsh r4, [r5, r4]
	umull r6, r5, r4, r2
	mla r5, r4, r3, r5
	mov r3, r4, asr #0x1f
	mla r5, r3, r2, r5
	adds r6, r6, #0x800
	adc r2, r5, #0
	mov r3, r6, lsr #0xc
	orr r3, r3, r2, lsl #20
	sub r1, r1, r3
	b _0216DDA0
_0216DD20:
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	ldr lr, _0216DDB0 // =FX_SinCosTable_
	mov r2, r2, lsl #1
	ldrsh r4, [lr, r2]
	mov r2, #0xd0000
	ldr r6, [r0, #0x44]
	umull r5, ip, r4, r2
	mla ip, r4, r3, ip
	mov r4, r4, asr #0x1f
	adds r5, r5, #0x800
	mla ip, r4, r2, ip
	adc r4, ip, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	add r4, r6, r5
	str r4, [r0, #0x44]
	ldrh ip, [r1, #0x34]
	ldr r1, [r0, #0x48]
	mov ip, ip, asr #4
	mov ip, ip, lsl #2
	ldrsh ip, [lr, ip]
	umull r4, lr, ip, r2
	mla lr, ip, r3, lr
	mov r3, ip, asr #0x1f
	mla lr, r3, r2, lr
	adds r4, r4, #0x800
	adc r2, lr, #0
	mov r3, r4, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r1, r1, r3
_0216DDA0:
	str r1, [r0, #0x48]
	ldr r1, [r0, #0x3b4]
	blx r1
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216DDB0: .word FX_SinCosTable_
	arm_func_end ovl01_216DC60

	arm_func_start ovl01_216DDB4
ovl01_216DDB4: // 0x0216DDB4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x3c0
	bl BossHelpers__ReleaseAnimation
	add r0, r4, #0x3c0
	bl AnimatorMDL__Release
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_216DDB4

	arm_func_start ovl01_216DDE0
ovl01_216DDE0: // 0x0216DDE0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x24
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	addne sp, sp, #0x24
	ldmneia sp!, {r3, r4, pc}
	ldr r2, _0216DE9C // =FX_SinCosTable_+0x00003000
	add r0, r4, #0x3e4
	ldrsh r1, [r2, #0]
	ldrsh r2, [r2, #2]
	bl MTX_RotY33_
	ldr r0, [r4, #0x3bc]
	ldr r2, _0216DEA0 // =FX_SinCosTable_
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
	add r0, sp, #0
	bl MTX_RotX33_
	add r0, r4, #0x3e4
	add r1, sp, #0
	mov r2, r0
	bl MTX_Concat33
	ldr r0, [r4, #0x37c]
	add r0, r0, #0x39c
	bl BossHelpers__RevertModifiedLights
	mov r0, r4
	add r1, r4, #0x3c0
	bl StageTask__Draw3D
	ldr r0, [r4, #0x37c]
	add r0, r0, #0x39c
	bl BossHelpers__ApplyModifiedLights
	add r1, r4, #0x384
	mov r0, #0x1e
	bl BossHelpers__Model__SetMatrixMode
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0216DE9C: .word FX_SinCosTable_+0x00003000
_0216DEA0: .word FX_SinCosTable_
	arm_func_end ovl01_216DDE0

	arm_func_start ovl01_216DEA4
ovl01_216DEA4: // 0x0216DEA4
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x18]
	tst r1, #0xc
	ldmneia sp!, {r3, pc}
	tst r1, #2
	ldmneia sp!, {r3, pc}
	ldr r1, [r0, #0x230]
	tst r1, #4
	ldmeqia sp!, {r3, pc}
	ldr r2, [r0, #0x3ac]
	ldr r1, [r0, #0x3a8]
	ldr r3, [r0, #0x3b0]
	add r0, r0, #0x218
	rsb r2, r2, #0
	bl BossHelpers__Collision__HandleColliderSimple
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_216DEA4

	arm_func_start ovl01_216DEE8
ovl01_216DEE8: // 0x0216DEE8
	stmdb sp!, {r3, lr}
	ldr r2, [r1, #0x1c]
	ldr r1, [r0, #0x1c]
	ldrh r0, [r1, #0]
	cmp r0, #1
	ldmneia sp!, {r3, pc}
	add r0, r1, #0x500
	ldrsh r0, [r0, #0xd4]
	cmp r0, #0x12
	cmpne r0, #0x13
	cmpne r0, #0x5f
	ldmneia sp!, {r3, pc}
	mov r0, r2
	bl ovl01_216DF48
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_216DEE8

	arm_func_start ovl01_216DF24
ovl01_216DF24: // 0x0216DF24
	ldr r1, [r0, #0x18]
	mov r2, #0
	bic r1, r1, #2
	str r1, [r0, #0x18]
	ldr r1, _0216DF44 // =ovl01_216DFAC
	str r2, [r0, #0x3bc]
	str r1, [r0, #0x3b4]
	bx lr
	.align 2, 0
_0216DF44: .word ovl01_216DFAC
	arm_func_end ovl01_216DF24

	arm_func_start ovl01_216DF48
ovl01_216DF48: // 0x0216DF48
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, [r5, #0x18]
	mov r4, r1
	orr r0, r0, #2
	str r0, [r5, #0x18]
	mov r0, r4
	str r4, [r5, #0x3b8]
	bl Player__Action_Launch
	mov r0, r4
	bl BossHelpers__Player__LockControl
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	str r0, [sp]
	mov r3, #0x110
	str r3, [sp, #4]
	mov r3, r1
	bl PlaySfxEx
	ldr r0, _0216DFA8 // =ovl01_216DFB0
	str r0, [r5, #0x3b4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216DFA8: .word ovl01_216DFB0
	arm_func_end ovl01_216DF48

	arm_func_start ovl01_216DFAC
ovl01_216DFAC: // 0x0216DFAC
	bx lr
	arm_func_end ovl01_216DFAC

	arm_func_start ovl01_216DFB0
ovl01_216DFB0: // 0x0216DFB0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x3bc]
	add r1, r1, #0x2d8
	str r1, [r4, #0x3bc]
	cmp r1, #0x10000
	blo _0216DFD4
	bl ovl01_216DF24
	ldmia sp!, {r4, pc}
_0216DFD4:
	ldr r1, [r4, #0x3b8]
	cmp r1, #0
	ldrne r0, [r1, #0x1c]
	orrne r0, r0, #0x20
	strne r0, [r1, #0x1c]
	ldr r0, [r4, #0x3bc]
	cmp r0, #0x8000
	blo _0216E01C
	ldr r1, [r4, #0x3b8]
	cmp r1, #0
	beq _0216E014
	ldr r0, [r1, #0x1c]
	bic r0, r0, #0x20
	str r0, [r1, #0x1c]
	ldr r0, [r4, #0x3b8]
	bl BossHelpers__Player__UnlockControl
_0216E014:
	mov r0, #0
	str r0, [r4, #0x3b8]
_0216E01C:
	ldr r0, [r4, #0x3b8]
	cmp r0, #0
	addne r1, r0, #0x500
	ldrnesh r1, [r1, #0xd4]
	cmpne r1, #0x13
	beq _0216E040
	bl BossHelpers__Player__UnlockControl
	mov r0, #0
	str r0, [r4, #0x3b8]
_0216E040:
	ldr r3, [r4, #0x3b8]
	cmp r3, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x3ac]
	ldr r2, [r4, #0x3b0]
	ldr r0, [r4, #0x3a8]
	rsb r1, r1, #0
	str r0, [r3, #0x44]
	str r1, [r3, #0x48]
	str r2, [r3, #0x4c]
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216DFB0

	arm_func_start ovl01_216E06C
ovl01_216E06C: // 0x0216E06C
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, [r0, #0x46c]
	mov r3, #0
	str r2, [r1]
	ldr r2, [r0, #0x470]
	ldr lr, _0216E114 // =FX_SinCosTable_
	rsb r2, r2, #0
	stmib r1, {r2, r3}
	ldrh r4, [r0, #0x34]
	mov ip, #0x55000
	ldr r2, [r1, #0]
	mov r4, r4, asr #4
	mov r4, r4, lsl #2
	ldrsh r4, [lr, r4]
	umull r6, r5, r4, ip
	mla r5, r4, r3, r5
	mov r4, r4, asr #0x1f
	mla r5, r4, ip, r5
	adds r6, r6, #0x800
	adc r4, r5, #0
	mov r5, r6, lsr #0xc
	orr r5, r5, r4, lsl #20
	add r2, r2, r5
	str r2, [r1]
	ldrh r2, [r0, #0x34]
	ldr r0, [r1, #4]
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r2, [lr, r2]
	umull r4, lr, r2, ip
	mla lr, r2, r3, lr
	mov r2, r2, asr #0x1f
	adds r4, r4, #0x800
	mla lr, r2, ip, lr
	adc r2, lr, #0
	mov r3, r4, lsr #0xc
	orr r3, r3, r2, lsl #20
	sub r0, r0, r3
	str r0, [r1, #4]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216E114: .word FX_SinCosTable_
	arm_func_end ovl01_216E06C

	arm_func_start ovl01_216E118
ovl01_216E118: // 0x0216E118
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x478]
	blx r1
	add r0, r4, #0x380
	bl ObjCollisionObjectRegist
	add r0, r4, #0x3e4
	bl ObjCollisionObjectRegist
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216E118

	arm_func_start ovl01_216E13C
ovl01_216E13C: // 0x0216E13C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x84
	add r0, r0, #0x400
	bl BossHelpers__ReleaseAnimation
	add r0, r4, #0x84
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_216E13C

	arm_func_start ovl01_216E170
ovl01_216E170: // 0x0216E170
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x24
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	addne sp, sp, #0x24
	ldmneia sp!, {r4, r5, pc}
	ldr r2, _0216E238 // =FX_SinCosTable_+0x00003000
	add r0, r4, #0x84
	ldrsh r1, [r2, #0]
	add r5, r0, #0x400
	ldrsh r2, [r2, #2]
	add r0, r5, #0x24
	bl MTX_RotY33_
	ldrh r1, [r4, #0x34]
	ldr r3, _0216E23C // =FX_SinCosTable_
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
	bl MTX_RotZ33_
	add r0, r5, #0x24
	add r1, sp, #0
	mov r2, r0
	bl MTX_Concat33
	ldr r0, [r4, #0x37c]
	add r0, r0, #0x39c
	bl BossHelpers__RevertModifiedLights
	mov r0, r4
	mov r1, r5
	bl StageTask__Draw3D
	ldr r0, [r4, #0x37c]
	add r0, r0, #0x39c
	bl BossHelpers__ApplyModifiedLights
	add r0, r4, #0x48
	add r1, r0, #0x400
	mov r0, #0x1e
	bl BossHelpers__Model__SetMatrixMode
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216E238: .word FX_SinCosTable_+0x00003000
_0216E23C: .word FX_SinCosTable_
	arm_func_end ovl01_216E170

	arm_func_start ovl01_216E240
ovl01_216E240: // 0x0216E240
	add r1, r0, #0x400
	ldrh ip, [r1, #0x7c]
	ldr r3, _0216E31C // =0x00000222
	add r1, r0, #0x7c
	cmp ip, r3
	add r1, r1, #0x400
	bls _0216E298
	cmp ip, r3
	bhs _0216E27C
	sub r2, r3, ip
	cmp r2, #0x18
	addgt r2, ip, #0x18
	strgth r2, [r1]
	strleh r3, [r1]
	b _0216E298
_0216E27C:
	bls _0216E298
	rsb r2, r3, #0
	add r2, ip, r2
	cmp r2, #0x18
	subgt r2, ip, #0x18
	strgth r2, [r1]
	strleh r3, [r1]
_0216E298:
	ldrh r3, [r1, #4]
	cmp r3, #0xb6
	bls _0216E2E0
	bhs _0216E2C4
	rsb r2, r3, #0xb6
	cmp r2, #8
	addgt r2, r3, #8
	strgth r2, [r1, #4]
	movle r2, #0xb6
	strleh r2, [r1, #4]
	b _0216E2E0
_0216E2C4:
	bls _0216E2E0
	sub r2, r3, #0xb6
	cmp r2, #8
	subgt r2, r3, #8
	strgth r2, [r1, #4]
	movle r2, #0xb6
	strleh r2, [r1, #4]
_0216E2E0:
	ldrh ip, [r1, #2]
	ldrh r3, [r1, #4]
	ldr r2, _0216E320 // =FX_SinCosTable_
	add r3, ip, r3
	strh r3, [r1, #2]
	ldrh r3, [r1, #2]
	ldrh ip, [r1]
	mov r1, r3, asr #4
	mov r1, r1, lsl #2
	ldrsh r1, [r2, r1]
	mul r1, ip, r1
	mov r1, r1, asr #0xc
	rsb r1, r1, #0
	strh r1, [r0, #0x34]
	bx lr
	.align 2, 0
_0216E31C: .word 0x00000222
_0216E320: .word FX_SinCosTable_
	arm_func_end ovl01_216E240

	arm_func_start ovl01_216E324
ovl01_216E324: // 0x0216E324
	add r2, r0, #0x7c
	add r0, r0, #0x400
	strh r1, [r0, #0x7c]
	add r2, r2, #0x400
	mov r1, #0x8000
	ldr r0, _0216E348 // =0x00000222
	strh r1, [r2, #2]
	strh r0, [r2, #4]
	bx lr
	.align 2, 0
_0216E348: .word 0x00000222
	arm_func_end ovl01_216E324

	arm_func_start ovl01_216E34C
ovl01_216E34C: // 0x0216E34C
	add r2, r0, #0x7c
	add r0, r0, #0x400
	ldr r3, _0216E370 // =0x00001555
	strh r1, [r0, #0x7c]
	add r1, r2, #0x400
	ldr r0, _0216E374 // =0x00000222
	strh r3, [r1, #2]
	strh r0, [r1, #4]
	bx lr
	.align 2, 0
_0216E370: .word 0x00001555
_0216E374: .word 0x00000222
	arm_func_end ovl01_216E34C

	arm_func_start ovl01_216E378
ovl01_216E378: // 0x0216E378
	ldr r1, _0216E384 // =ovl01_216E388
	str r1, [r0, #0x478]
	bx lr
	.align 2, 0
_0216E384: .word ovl01_216E388
	arm_func_end ovl01_216E378

	arm_func_start ovl01_216E388
ovl01_216E388: // 0x0216E388
	ldr ip, _0216E390 // =ovl01_216E240
	bx ip
	.align 2, 0
_0216E390: .word ovl01_216E240
	arm_func_end ovl01_216E388

	arm_func_start ovl01_216E394
ovl01_216E394: // 0x0216E394
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #1
	add r0, r4, #0x3a4
	mov r2, r1
	mov r3, r1
	add r0, r0, #0x400
	bl BossHelpers__SetPaletteAnimations
	add r0, r4, #0x700
	mov r1, #0x3c
	strh r1, [r0, #0xc4]
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216E394

	arm_func_start ovl01_216E3C4
ovl01_216E3C4: // 0x0216E3C4
	stmdb sp!, {r3, lr}
	add r1, r0, #0x700
	ldrh r2, [r1, #0xc4]
	cmp r2, #0
	ldmeqia sp!, {r3, pc}
	sub r2, r2, #1
	strh r2, [r1, #0xc4]
	ldrh r1, [r1, #0xc4]
	cmp r1, #0
	ldmneia sp!, {r3, pc}
	add r0, r0, #0x3a4
	mov r2, #0
	mov r3, r2
	add r0, r0, #0x400
	mov r1, #1
	bl BossHelpers__SetPaletteAnimations
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_216E3C4

	arm_func_start ovl01_216E408
ovl01_216E408: // 0x0216E408
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x78c]
	blx r1
	add r1, r4, #0x700
	ldrh r0, [r1, #0x96]
	ldr r3, _0216E494 // =FX_SinCosTable_
	ldr ip, [r4, #0x798]
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r2, [r3, r0]
	mov r0, r4
	smull lr, r2, ip, r2
	adds ip, lr, #0x800
	adc r2, r2, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r2, lsl #20
	rsb r2, ip, #0
	str r2, [r4, #0x98]
	ldrh r1, [r1, #0x96]
	ldr r2, [r4, #0x798]
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #1
	ldrsh r1, [r3, r1]
	smull r3, r1, r2, r1
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	rsb r1, r2, #0
	str r1, [r4, #0x9c]
	bl ovl01_216E3C4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E494: .word FX_SinCosTable_
	arm_func_end ovl01_216E408

	arm_func_start ovl01_216E498
ovl01_216E498: // 0x0216E498
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x3c8
	add r0, r0, #0x400
	bl BossHelpers__ReleaseAnimation
	add r0, r4, #0x3c8
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	add r0, r4, #0x3a4
	add r0, r0, #0x400
	bl ReleasePaletteAnimator
	ldr r0, [r4, #0x7a0]
	bl FreeSndHandle
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_216E498

	arm_func_start ovl01_216E4E0
ovl01_216E4E0: // 0x0216E4E0
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x20]
	tst r1, #0x20
	ldmneia sp!, {r4, pc}
	add r1, r4, #0x3c8
	add r1, r1, #0x400
	bl StageTask__Draw3D
	add r4, r4, #0x3a4
	add r0, r4, #0x400
	bl AnimatePalette
	add r0, r4, #0x400
	bl DrawAnimatedPalette
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216E4E0

	arm_func_start ovl01_216E51C
ovl01_216E51C: // 0x0216E51C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	ldr r4, [r5, #0x1c]
	mov r7, r1
	mov r0, r4
	ldr r6, [r7, #0x1c]
	bl Player__Action_AttackRecoil
	mov r0, #0x5000
	str r0, [r4, #0x9c]
	ldr ip, [r6, #0x44]
	ldr r3, [r4, #0x44]
	cmp r3, ip
	ldrlesh r2, [r7, #0]
	ldrlesh r1, [r5, #6]
	suble r0, r0, #0x8000
	addle r2, ip, r2, lsl #12
	addle r1, r3, r1, lsl #12
	suble r1, r2, r1
	strle r1, [r4, #0xb0]
	strle r0, [r4, #0x98]
	ldmleia sp!, {r3, r4, r5, r6, r7, pc}
	ldrsh r2, [r7, #6]
	ldrsh r1, [r5, #0]
	mov r0, #0x3000
	add r2, ip, r2, lsl #12
	add r1, r3, r1, lsl #12
	sub r1, r2, r1
	str r1, [r4, #0xb0]
	str r0, [r4, #0x98]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end ovl01_216E51C

	arm_func_start ovl01_216E594
ovl01_216E594: // 0x0216E594
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r9, r0
	ldr r5, [r9, #0x1c]
	mov r8, r1
	ldrh r0, [r5, #0]
	ldr r4, [r8, #0x1c]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	add r0, r5, #0x500
	ldrsh r0, [r0, #0xd4]
	mov r1, #0
	cmp r0, #0x12
	cmpne r0, #0x13
	cmpne r0, #0x5f
	moveq r1, #1
	cmp r1, #0
	beq _0216E7E0
	ldr r0, [r4, #0x37c]
	bl ovl01_216C9B0
	mov r6, r0
	bl ovl01_216C9EC
	ldr r1, [r4, #0x37c]
	add r1, r1, #0x300
	ldrsh r2, [r1, #0x94]
	sub r0, r2, r0
	strh r0, [r1, #0x94]
	ldr r0, [r4, #0x37c]
	add r0, r0, #0x300
	ldrsh r1, [r0, #0x94]
	cmp r1, #0
	bgt _0216E6C0
	ldr r1, [r4, #0x790]
	cmp r1, #4
	beq _0216E67C
	mov r1, #1
	strh r1, [r0, #0x94]
	ldr r2, [r4, #0x44]
	ldr r0, [r5, #0x44]
	cmp r2, r0
	movlt r7, #0x2000
	movge r1, #2
	mov r0, r4
	movge r7, #0xe000
	bl ovl01_216EA98
	add r0, r4, #0x700
	mov ip, #0x8c
	sub r1, ip, #0x8d
	strh r7, [r0, #0x96]
	mov r0, #0x8000
	str r0, [r4, #0x798]
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	b _0216E6FC
_0216E67C:
	mov r1, #0
	strh r1, [r0, #0x94]
	ldr r0, [r4, #0x37c]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0x94]
	bl UpdateBossHealthHUD
	mov r0, r4
	bl ovl01_216EB0C
	mov r4, #0xce
	sub r1, r4, #0xcf
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0216E6C0:
	mov r7, #0x8c
	sub r1, r7, #0x8d
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r7}
	bl PlaySfxEx
	mov r0, r4
	bl ovl01_216E394
	ldr r0, [r4, #0x790]
	cmp r0, #0
	bne _0216E6FC
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x37c]
	bl ovl01_216FB74
_0216E6FC:
	ldr r1, [r4, #0x44]
	ldr r0, [r5, #0x44]
	cmp r1, r0
	movlt r7, #0x6000
	ldr r0, [r4, #0x37c]
	movge r7, #0xa000
	bl ovl01_216C9B0
	cmp r6, r0
	beq _0216E738
	cmp r6, #0
	bne _0216E738
	mov r0, r4
	mov r1, r7
	bl ovl01_216EA08
	b _0216E784
_0216E738:
	add r0, r4, #0x700
	ldrh r1, [r0, #0x94]
	add r1, r1, #1
	strh r1, [r0, #0x94]
	ldrh r0, [r0, #0x94]
	cmp r0, #5
	blo _0216E784
	ldr r0, [r4, #0x790]
	cmp r0, #1
	bne _0216E76C
	mov r0, r4
	mov r1, r7
	bl ovl01_216E970
_0216E76C:
	ldr r0, [r4, #0x790]
	cmp r0, #0
	bne _0216E784
	mov r0, r4
	mov r1, r7
	bl ovl01_216EA08
_0216E784:
	ldr r0, [r4, #0x37c]
	bl ovl01_216C9B0
	cmp r6, r0
	beq _0216E7A4
	cmp r6, #1
	bne _0216E7A4
	mov r0, #1
	bl ChangeBossBGMVariant
_0216E7A4:
	ldr r0, [r4, #0x37c]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0x94]
	bl UpdateBossHealthHUD
	ldr r0, [r5, #0x48]
	ldr r1, [r5, #0x44]
	rsb r2, r0, #0
	ldr r3, [r5, #0x4c]
	mov r0, #0
	bl BossFX__CreateHitA
	mov r0, r9
	mov r1, r8
	bl ovl01_216E51C
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0216E7E0:
	mov r0, r9
	mov r1, r8
	bl ovl01_216E7F4
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end ovl01_216E594

	arm_func_start ovl01_216E7F4
ovl01_216E7F4: // 0x0216E7F4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r4, [r0, #0x1c]
	ldrh r2, [r4, #0]
	cmp r2, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	bl ovl01_216E51C
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	rsb r2, r0, #0
	ldr r3, [r4, #0x4c]
	mov r0, #0
	bl BossFX__CreateHitB
	mov ip, #0x8c
	sub r1, ip, #0x8d
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216E7F4

	arm_func_start ovl01_216E850
ovl01_216E850: // 0x0216E850
	ldr r1, [r0, #0x230]
	orr r1, r1, #4
	str r1, [r0, #0x230]
	bx lr
	arm_func_end ovl01_216E850

	arm_func_start ovl01_216E860
ovl01_216E860: // 0x0216E860
	ldr r1, [r0, #0x230]
	bic r1, r1, #4
	str r1, [r0, #0x230]
	bx lr
	arm_func_end ovl01_216E860

	arm_func_start ovl01_216E870
ovl01_216E870: // 0x0216E870
	ldr r1, [r0, #0x270]
	orr r1, r1, #4
	str r1, [r0, #0x270]
	bx lr
	arm_func_end ovl01_216E870

	arm_func_start ovl01_216E880
ovl01_216E880: // 0x0216E880
	ldr r1, [r0, #0x270]
	bic r1, r1, #4
	str r1, [r0, #0x270]
	bx lr
	arm_func_end ovl01_216E880

	arm_func_start ovl01_216E890
ovl01_216E890: // 0x0216E890
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	ldr r0, _0216E8E8 // =ovl01_216EB2C
	str r1, [r4, #0x790]
	str r0, [r4, #0x78c]
	ldr r0, [r4, #0x20]
	bic r0, r0, #0x100
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x37c]
	bl ovl01_216FF88
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x37c]
	ldr r1, [r0, #0x7d4]
	cmp r1, #0xc
	bne _0216E8D8
	bl ovl01_21708E8
_0216E8D8:
	add r0, r4, #0x700
	mov r1, #0
	strh r1, [r0, #0x94]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E8E8: .word ovl01_216EB2C
	arm_func_end ovl01_216E890

	arm_func_start ovl01_216E8EC
ovl01_216E8EC: // 0x0216E8EC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r2, #1
	ldr r1, _0216E968 // =ovl01_216EBC0
	str r2, [r4, #0x790]
	str r1, [r4, #0x78c]
	bl ovl01_216E850
	mov r0, r4
	bl ovl01_216E880
	ldr r2, _0216E96C // =FX_SinCosTable_+0x00002000
	ldr r1, [r4, #0x20]
	add r0, r4, #0x3ec
	orr r3, r1, #0x100
	ldrsh r1, [r2, #0]
	ldrsh r2, [r2, #2]
	str r3, [r4, #0x20]
	add r0, r0, #0x400
	bl MTX_RotZ33_
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x37c]
	bl ovl01_216FF98
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x37c]
	ldr r1, [r0, #0x7d4]
	cmp r1, #0xc
	bne _0216E958
	bl ovl01_21708E8
_0216E958:
	add r0, r4, #0x700
	mov r1, #0
	strh r1, [r0, #0x94]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E968: .word ovl01_216EBC0
_0216E96C: .word FX_SinCosTable_+0x00002000
	arm_func_end ovl01_216E8EC

	arm_func_start ovl01_216E970
ovl01_216E970: // 0x0216E970
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x790]
	cmp r0, #1
	ldrne r0, _0216E9F8 // =ovl01_216EC08
	strne r0, [r4, #0x78c]
	bne _0216E99C
	ldr r2, _0216E9FC // =ovl01_216EBD8
	add r0, r4, #0x700
	str r2, [r4, #0x78c]
	strh r1, [r0, #0x96]
_0216E99C:
	ldr r2, _0216EA00 // =FX_SinCosTable_+0x00002000
	mov r0, #2
	str r0, [r4, #0x790]
	ldr r1, [r4, #0x20]
	add r0, r4, #0x3ec
	orr r3, r1, #0x100
	ldrsh r1, [r2, #0]
	ldrsh r2, [r2, #2]
	add r0, r0, #0x400
	str r3, [r4, #0x20]
	bl MTX_RotZ33_
	ldr r1, _0216EA04 // =0x00006999
	mov r0, r4
	str r1, [r4, #0x7e0]
	str r1, [r4, #0x7e4]
	str r1, [r4, #0x7e8]
	bl ovl01_216E860
	mov r0, r4
	bl ovl01_216E870
	add r0, r4, #0x700
	mov r1, #0
	strh r1, [r0, #0x9c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E9F8: .word ovl01_216EC08
_0216E9FC: .word ovl01_216EBD8
_0216EA00: .word FX_SinCosTable_+0x00002000
_0216EA04: .word 0x00006999
	arm_func_end ovl01_216E970

	arm_func_start ovl01_216EA08
ovl01_216EA08: // 0x0216EA08
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x790]
	cmp r0, #0
	ldrne r0, _0216EA8C // =ovl01_216EE98
	strne r0, [r4, #0x78c]
	bne _0216EA34
	ldr r2, _0216EA90 // =ovl01_216EE48
	add r0, r4, #0x700
	str r2, [r4, #0x78c]
	strh r1, [r0, #0x96]
_0216EA34:
	ldr r2, _0216EA94 // =FX_SinCosTable_+0x00002000
	mov r0, #3
	str r0, [r4, #0x790]
	ldr r1, [r4, #0x20]
	add r0, r4, #0x3ec
	orr r3, r1, #0x100
	ldrsh r1, [r2, #0]
	ldrsh r2, [r2, #2]
	add r0, r0, #0x400
	str r3, [r4, #0x20]
	bl MTX_RotZ33_
	mov r0, r4
	bl ovl01_216E860
	mov r0, r4
	bl ovl01_216E870
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x37c]
	bl ovl01_216FF98
	add r0, r4, #0x700
	mov r1, #0
	strh r1, [r0, #0x9c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216EA8C: .word ovl01_216EE98
_0216EA90: .word ovl01_216EE48
_0216EA94: .word FX_SinCosTable_+0x00002000
	arm_func_end ovl01_216EA08

	arm_func_start ovl01_216EA98
ovl01_216EA98: // 0x0216EA98
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	mov r3, #4
	ldr r2, _0216EB04 // =ovl01_216F12C
	str r3, [r4, #0x790]
	mov r5, r1
	str r2, [r4, #0x78c]
	bl ovl01_216E850
	mov r0, r4
	bl ovl01_216E880
	ldr r0, [r4, #0x18]
	add r1, r4, #0x380
	orr r0, r0, #2
	str r0, [r4, #0x18]
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	str r5, [r4, #0x380]
	mov r0, #0x258
	str r0, [r4, #0x384]
	mov r1, #0x3c
	ldr r0, _0216EB08 // =0x00006999
	str r1, [r4, #0x388]
	str r0, [r4, #0x7e0]
	str r0, [r4, #0x7e4]
	str r0, [r4, #0x7e8]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216EB04: .word ovl01_216F12C
_0216EB08: .word 0x00006999
	arm_func_end ovl01_216EA98

	arm_func_start ovl01_216EB0C
ovl01_216EB0C: // 0x0216EB0C
	stmdb sp!, {r3, lr}
	mov r2, #5
	ldr r1, _0216EB28 // =ovl01_216F5EC
	str r2, [r0, #0x790]
	str r1, [r0, #0x78c]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216EB28: .word ovl01_216F5EC
	arm_func_end ovl01_216EB0C

	arm_func_start ovl01_216EB2C
ovl01_216EB2C: // 0x0216EB2C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x37c]
	add r0, r4, #0x3ec
	ldr r3, [r1, #0x37c]
	add ip, r0, #0x400
	ldr r1, [r3, #0x3fc]
	ldr r2, [r3, #0x400]
	ldr r0, [r3, #0x3f8]
	rsb r1, r1, #0
	str r0, [r4, #0x44]
	str r1, [r4, #0x48]
	add lr, r3, #0x3d4
	str r2, [r4, #0x4c]
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r1, [lr]
	ldr r0, _0216EBBC // =0x000034CC
	str r1, [ip]
	str r0, [r4, #0x7e0]
	str r0, [r4, #0x7e4]
	str r0, [r4, #0x7e8]
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x37c]
	ldr r0, [r0, #0x7e8]
	cmp r0, #0xc
	mov r0, r4
	bne _0216EBAC
	bl ovl01_216E860
	b _0216EBB0
_0216EBAC:
	bl ovl01_216E850
_0216EBB0:
	mov r0, r4
	bl ovl01_216E880
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216EBBC: .word 0x000034CC
	arm_func_end ovl01_216EB2C

	arm_func_start ovl01_216EBC0
ovl01_216EBC0: // 0x0216EBC0
	ldr r2, [r0, #0x37c]
	ldr ip, _0216EBD4 // =ovl01_216E06C
	add r1, r0, #0x44
	ldr r0, [r2, #0x384]
	bx ip
	.align 2, 0
_0216EBD4: .word ovl01_216E06C
	arm_func_end ovl01_216EBC0

	arm_func_start ovl01_216EBD8
ovl01_216EBD8: // 0x0216EBD8
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x700
	mov r1, #0
	strh r1, [r0, #0x9c]
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x37c]
	bl ovl01_2170BE0
	ldr r0, _0216EC04 // =ovl01_216EC08
	str r0, [r4, #0x78c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216EC04: .word ovl01_216EC08
	arm_func_end ovl01_216EBD8

	arm_func_start ovl01_216EC08
ovl01_216EC08: // 0x0216EC08
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x14
	mov r5, r0
	ldr r0, [r5, #0x37c]
	ldr r0, [r0, #0x37c]
	ldr r1, [r0, #0x7e8]
	cmp r1, #0xe
	addls pc, pc, r1, lsl #2
	b _0216EC7C
_0216EC2C: // jump table
	b _0216EC7C // case 0
	b _0216EC7C // case 1
	b _0216EC7C // case 2
	b _0216EC7C // case 3
	b _0216EC7C // case 4
	b _0216EC78 // case 5
	b _0216EC78 // case 6
	b _0216EC78 // case 7
	b _0216EC78 // case 8
	b _0216EC78 // case 9
	b _0216EC7C // case 10
	b _0216EC7C // case 11
	b _0216EC68 // case 12
	b _0216EC7C // case 13
	b _0216EC70 // case 14
_0216EC68:
	bl ovl01_2171FE8
	b _0216EC7C
_0216EC70:
	bl ovl01_21720E8
	b _0216EC7C
_0216EC78:
	bl ovl01_2171D5C
_0216EC7C:
	add r0, r5, #0x700
	ldrh r1, [r0, #0x9c]
	add r3, sp, #8
	cmp r1, #0xb4
	addlo r1, r1, #1
	strloh r1, [r0, #0x9c]
	ldr r0, [r5, #0x37c]
	ldr r6, [r0, #0x37c]
	add r0, r6, #0x3f8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [sp, #0xc]
	rsb r4, r0, #0
	str r4, [sp, #0xc]
	ldr r0, [r5, #0x48]
	ldr r1, [r5, #0x44]
	subs r2, r0, r4
	ldr r0, [sp, #8]
	rsbmi r2, r2, #0
	subs r0, r1, r0
	rsbmi r0, r0, #0
	cmp r0, #0x8000
	cmplt r2, #0x8000
	bge _0216ED40
	ldr r0, [r6, #0x7e8]
	cmp r0, #1
	addne sp, sp, #0x14
	ldmneia sp!, {r3, r4, r5, r6, pc}
	ldr r0, _0216EE40 // =0x00000303
	mov r1, #0x800
	bl CreateDrawFadeTask
	mov r2, #0
	mov r0, #0xbb
	sub r1, r0, #0xbc
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r5, #0x7a0]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r5, #0x7a0]
	add r1, r5, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	mov r0, r5
	bl ovl01_216E890
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, r5, r6, pc}
_0216ED40:
	add r0, r5, #0x700
	ldrh r0, [r0, #0x9c]
	mov r1, #0xb4000
	mov r0, r0, lsl #0xc
	bl FX_Div
	ldr r1, [r5, #0x48]
	mov r2, r0, lsl #0x10
	ldr r3, [r5, #0x44]
	ldr r0, [sp, #8]
	sub r1, r1, r4
	sub r0, r3, r0
	mov r4, r2, asr #0x10
	bl FX_Atan2Idx
	mov r3, #0x3000
	rsb r3, r3, #0
	umull r2, r6, r4, r3
	mvn r1, #0
	ldr ip, _0216EE44 // =0x00AAA000
	mla r6, r4, r1, r6
	adds r1, r2, #0x800
	mov lr, r1, lsr #0xc
	mov r1, r0
	mov r2, r4, asr #0x1f
	mla r6, r2, r3, r6
	adc r0, r6, #0
	orr lr, lr, r0, lsl #20
	add r0, lr, #0x5000
	str r0, [r5, #0x798]
	mov r3, #0
	add r0, r5, #0x700
	ldrh r0, [r0, #0x96]
	umull r6, lr, r4, ip
	mla lr, r4, r3, lr
	mla lr, r2, ip, lr
	adds r3, r6, #0x800
	adc r2, lr, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, r3, #0xb6000
	mov r2, r2, lsl #4
	mov r2, r2, lsr #0x10
	bl Unknown2066510__LerpAngle2
	add r1, r5, #0x700
	strh r0, [r1, #0x96]
	ldr r1, [r5, #0x4c]
	cmp r1, #0
	bge _0216EE1C
	rsb r0, r1, #0
	cmp r0, #0x1000
	addgt r0, r1, #0x1000
	strgt r0, [r5, #0x4c]
	movle r0, #0
	add sp, sp, #0x14
	strle r0, [r5, #0x4c]
	ldmia sp!, {r3, r4, r5, r6, pc}
_0216EE1C:
	addle sp, sp, #0x14
	ldmleia sp!, {r3, r4, r5, r6, pc}
	cmp r1, #0x1000
	subgt r0, r1, #0x1000
	strgt r0, [r5, #0x4c]
	movle r0, #0
	strle r0, [r5, #0x4c]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0216EE40: .word 0x00000303
_0216EE44: .word 0x00AAA000
	arm_func_end ovl01_216EC08

	arm_func_start ovl01_216EE48
ovl01_216EE48: // 0x0216EE48
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x37c]
	bl ovl01_2170BE0
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x37c]
	bl ovl01_2171D5C
	ldr r1, _0216EE90 // =0x00006999
	add r0, r4, #0x700
	str r1, [r4, #0x7e0]
	str r1, [r4, #0x7e4]
	str r1, [r4, #0x7e8]
	mov r2, #0
	ldr r1, _0216EE94 // =ovl01_216EE98
	strh r2, [r0, #0x9c]
	str r1, [r4, #0x78c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216EE90: .word 0x00006999
_0216EE94: .word ovl01_216EE98
	arm_func_end ovl01_216EE48

	arm_func_start ovl01_216EE98
ovl01_216EE98: // 0x0216EE98
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x14
	mov r5, r0
	add r0, r5, #0x700
	ldrh r1, [r0, #0x9c]
	cmp r1, #0xb4
	addlo r1, r1, #1
	strloh r1, [r0, #0x9c]
	ldr r0, [r5, #0x37c]
	add r1, sp, #8
	ldr r0, [r0, #0x384]
	bl ovl01_216E06C
	ldr r1, [r5, #0x4c]
	ldr r0, [sp, #0x10]
	subs r2, r1, r0
	ldr r1, [r5, #0x48]
	ldr r0, [sp, #0xc]
	rsbmi r2, r2, #0
	subs r3, r1, r0
	ldr r1, [r5, #0x44]
	ldr r0, [sp, #8]
	rsbmi r3, r3, #0
	subs r0, r1, r0
	rsbmi r0, r0, #0
	cmp r0, #0x8000
	cmplt r3, #0x8000
	bge _0216EF60
	cmp r2, #0
	bne _0216EF60
	ldr r0, _0216F064 // =0x00000303
	mov r1, #0x800
	bl CreateDrawFadeTask
	mov r2, #0
	mov r0, #0xbb
	str r2, [sp]
	sub r1, r0, #0xbc
	str r0, [sp, #4]
	ldr r0, [r5, #0x7a0]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r5, #0x7a0]
	add r1, r5, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	mov r0, r5
	bl ovl01_216E8EC
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, r5, r6, pc}
_0216EF60:
	add r0, r5, #0x700
	ldrh r0, [r0, #0x9c]
	mov r1, #0xb4000
	mov r0, r0, lsl #0xc
	bl FX_Div
	mov r2, r0, lsl #0x10
	ldr r4, [r5, #0x44]
	ldr r0, [sp, #8]
	ldr r3, [r5, #0x48]
	ldr r1, [sp, #0xc]
	sub r0, r4, r0
	sub r1, r3, r1
	mov r4, r2, asr #0x10
	bl FX_Atan2Idx
	mov r3, #0x3000
	rsb r3, r3, #0
	umull r2, r6, r4, r3
	mvn r1, #0
	ldr ip, _0216F068 // =0x00AAA000
	mla r6, r4, r1, r6
	adds r1, r2, #0x800
	mov lr, r1, lsr #0xc
	mov r1, r0
	mov r2, r4, asr #0x1f
	mla r6, r2, r3, r6
	adc r0, r6, #0
	orr lr, lr, r0, lsl #20
	add r0, lr, #0x5000
	str r0, [r5, #0x798]
	mov r3, #0
	add r0, r5, #0x700
	ldrh r0, [r0, #0x96]
	umull r6, lr, r4, ip
	mla lr, r4, r3, lr
	mla lr, r2, ip, lr
	adds r3, r6, #0x800
	adc r2, lr, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, r3, #0xb6000
	mov r2, r2, lsl #4
	mov r2, r2, lsr #0x10
	bl Unknown2066510__LerpAngle2
	add r1, r5, #0x700
	strh r0, [r1, #0x96]
	ldr r1, [r5, #0x4c]
	cmp r1, #0
	bge _0216F040
	rsb r0, r1, #0
	cmp r0, #0x1000
	addgt r0, r1, #0x1000
	strgt r0, [r5, #0x4c]
	movle r0, #0
	add sp, sp, #0x14
	strle r0, [r5, #0x4c]
	ldmia sp!, {r3, r4, r5, r6, pc}
_0216F040:
	addle sp, sp, #0x14
	ldmleia sp!, {r3, r4, r5, r6, pc}
	cmp r1, #0x1000
	subgt r0, r1, #0x1000
	strgt r0, [r5, #0x4c]
	movle r0, #0
	strle r0, [r5, #0x4c]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0216F064: .word 0x00000303
_0216F068: .word 0x00AAA000
	arm_func_end ovl01_216EE98

	arm_func_start ovl01_216F06C
ovl01_216F06C: // 0x0216F06C
	stmdb sp!, {r3, lr}
	sub sp, sp, #0x10
	ldr r2, [r0, #0x37c]
	mov r1, #0
	ldr r2, [r2, #0x37c]
	add r2, r2, #0x394
	ldr r3, [r2, #0x404]
	cmp r3, #0
	ldrne r2, [r2, #0x400]
	cmpne r3, r2
	bne _0216F0C0
	ldr r3, [r0, #0x380]
	mov r2, #1
	add r0, sp, #0
_0216F0A4:
	cmp r3, r2
	strne r2, [r0, r1, lsl #2]
	add r2, r2, #1
	addne r1, r1, #1
	cmp r2, #5
	blt _0216F0A4
	b _0216F0E8
_0216F0C0:
	ldr r2, [r0, #0x380]
	mov ip, #1
	add r0, sp, #0
_0216F0CC:
	cmp r2, ip
	cmpne r3, ip
	strne ip, [r0, r1, lsl #2]
	add ip, ip, #1
	addne r1, r1, #1
	cmp ip, #5
	blt _0216F0CC
_0216F0E8:
	ldr r3, _0216F120 // =_mt_math_rand
	ldr r0, _0216F124 // =0x00196225
	ldr ip, [r3]
	ldr r2, _0216F128 // =0x3C6EF35F
	mla r2, ip, r0, r2
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r2, [r3]
	bl FX_ModS32
	add r1, sp, #0
	ldr r0, [r1, r0, lsl #2]
	add sp, sp, #0x10
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216F120: .word _mt_math_rand
_0216F124: .word 0x00196225
_0216F128: .word 0x3C6EF35F
	arm_func_end ovl01_216F06C

	arm_func_start ovl01_216F12C
ovl01_216F12C: // 0x0216F12C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r5, r0
	add r4, r5, #0x380
	ldr r0, [r4, #4]
	cmp r0, #0
	subgt r0, r0, #1
	strgt r0, [r4, #4]
	ldr r0, [r4, #8]
	cmp r0, #0
	ble _0216F168
	subs r0, r0, #1
	str r0, [r4, #8]
	ldreq r0, [r5, #0x18]
	biceq r0, r0, #2
	streq r0, [r5, #0x18]
_0216F168:
	ldrh r1, [r4, #0xc]
	add r0, r1, #1
	strh r0, [r4, #0xc]
	tst r1, #3
	bne _0216F228
	ldr r8, _0216F3EC // =_mt_math_rand
	ldr r2, _0216F3F0 // =0x00196225
	ldr r1, [r8, #0]
	ldr r3, _0216F3F4 // =0x3C6EF35F
	mov r7, #0
	mla r0, r1, r2, r3
	mov r1, r0, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r6, #0x28000
	umull r10, r9, r1, r6
	mla r9, r1, r7, r9
	mov r1, r1, asr #0x1f
	adds r10, r10, #0x800
	mla r9, r1, r6, r9
	str r0, [r8]
	adc r0, r9, #0
	mov r1, r10, lsr #0xc
	orr r1, r1, r0, lsl #20
	ldr r9, [r5, #0x44]
	rsb r0, r1, #0x14000
	add r0, r9, r0
	str r0, [r5, #0x44]
	ldr r1, [r8, #0]
	mla r0, r1, r2, r3
	mov r1, r0, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	umull r3, r2, r1, r6
	adds r3, r3, #0x800
	str r0, [r8]
	mla r2, r1, r7, r2
	mov r0, r1, asr #0x1f
	mla r2, r0, r6, r2
	adc r0, r2, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	ldr r2, [r5, #0x48]
	rsb r0, r1, #0x14000
	add r0, r2, r0
	str r0, [r5, #0x48]
_0216F228:
	ldr r6, [r4, #0]
	ldr r0, _0216F3F8 // =_02179FA0
	ldr r1, _0216F3FC // =_02179FA4
	ldr r2, [r5, #0x44]
	ldr r0, [r0, r6, lsl #3]
	ldr r3, [r5, #0x48]
	ldr r1, [r1, r6, lsl #3]
	subs r0, r2, r0
	sub r1, r3, r1
	rsbmi r3, r0, #0
	movpl r3, r0
	cmp r1, #0
	rsblt ip, r1, #0
	movge ip, r1
	cmp r3, ip
	ldr r10, _0216F400 // =0x00000F5E
	ble _0216F2BC
	mov lr, #0
	umull r2, r9, r3, r10
	mla r9, r3, lr, r9
	ldr r6, _0216F404 // =0x0000065D
	mov r3, r3, asr #0x1f
	umull r8, r7, ip, r6
	adds r2, r2, #0x800
	mla r9, r3, r10, r9
	adc r9, r9, #0
	adds r3, r8, #0x800
	mov r2, r2, lsr #0xc
	mla r7, ip, lr, r7
	mov r8, ip, asr #0x1f
	mla r7, r8, r6, r7
	adc r6, r7, #0
	mov r3, r3, lsr #0xc
	orr r2, r2, r9, lsl #20
	orr r3, r3, r6, lsl #20
	add r7, r2, r3
	b _0216F308
_0216F2BC:
	ldr lr, _0216F404 // =0x0000065D
	umull r2, r9, ip, r10
	mov r6, #0
	mla r9, ip, r6, r9
	umull r8, r7, r3, lr
	mla r7, r3, r6, r7
	mov ip, ip, asr #0x1f
	mov r3, r3, asr #0x1f
	adds r2, r2, #0x800
	mla r9, ip, r10, r9
	adc r9, r9, #0
	adds r8, r8, #0x800
	mla r7, r3, lr, r7
	mov r2, r2, lsr #0xc
	adc r3, r7, #0
	mov r6, r8, lsr #0xc
	orr r2, r2, r9, lsl #20
	orr r6, r6, r3, lsl #20
	add r7, r2, r6
_0216F308:
	bl FX_Atan2Idx
	ldr r1, [r4, #4]
	mov r6, r0
	cmp r1, #0xf0
	movge r3, #0x1000
	bge _0216F334
	mov r0, r1, lsl #0xc
	mov r1, #0xf0000
	bl FX_Div
	mov r0, r0, lsl #0x10
	mov r3, r0, asr #0x10
_0216F334:
	mov r0, r3, asr #0x1f
	mov r1, r0, lsl #0xd
	mov r0, #0x800
	adds r2, r0, r3, lsl #13
	orr r1, r1, r3, lsr #19
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	ldr r2, [r5, #0x798]
	add r3, r1, #0x1800
	cmp r2, r3
	bge _0216F388
	ldr r0, _0216F408 // =0x00000199
	sub r1, r3, r2
	cmp r1, r0
	strle r3, [r5, #0x798]
	ble _0216F3A4
	add r0, r2, #0x99
	add r0, r0, #0x100
	str r0, [r5, #0x798]
	b _0216F3A4
_0216F388:
	ble _0216F3A4
	ldr r0, _0216F408 // =0x00000199
	sub r1, r2, r3
	cmp r1, r0
	subgt r0, r2, r0
	strgt r0, [r5, #0x798]
	strle r3, [r5, #0x798]
_0216F3A4:
	add r0, r5, #0x700
	ldrh r0, [r0, #0x96]
	mov r1, r6
	mov r2, #0x2d8
	bl Unknown2066510__LerpAngle2
	add r1, r5, #0x700
	strh r0, [r1, #0x96]
	cmp r7, #0xf000
	ldmgeia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r0, [r4, #4]
	cmp r0, #0
	ldrle r0, _0216F40C // =ovl01_216F410
	strle r0, [r5, #0x78c]
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, r5
	bl ovl01_216F06C
	str r0, [r4]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0216F3EC: .word _mt_math_rand
_0216F3F0: .word 0x00196225
_0216F3F4: .word 0x3C6EF35F
_0216F3F8: .word _02179FA0
_0216F3FC: .word _02179FA4
_0216F400: .word 0x00000F5E
_0216F404: .word 0x0000065D
_0216F408: .word 0x00000199
_0216F40C: .word ovl01_216F410
	arm_func_end ovl01_216F12C

	arm_func_start ovl01_216F410
ovl01_216F410: // 0x0216F410
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r0, [r4, #0x37c]
	add r1, sp, #8
	ldr r0, [r0, #0x384]
	bl ovl01_216E06C
	ldr r1, [r4, #0x48]
	ldr r0, [sp, #0xc]
	ldr r2, [r4, #0x44]
	subs r1, r1, r0
	rsbmi r3, r1, #0
	ldr r0, [sp, #8]
	movpl r3, r1
	subs r0, r2, r0
	rsbmi r2, r0, #0
	movpl r2, r0
	cmp r2, #0x8000
	cmplt r3, #0x8000
	bge _0216F4D4
	ldr r0, [r4, #0x37c]
	mov r1, #0x100
	add r0, r0, #0x300
	strh r1, [r0, #0x94]
	ldr r0, [r4, #0x37c]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0x94]
	bl UpdateBossHealthHUD
	ldr r0, _0216F550 // =0x00000303
	mov r1, #0x800
	bl CreateDrawFadeTask
	mov r2, #0
	mov r0, #0xbb
	str r2, [sp]
	sub r1, r0, #0xbc
	str r0, [sp, #4]
	ldr r0, [r4, #0x7a0]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r4, #0x7a0]
	add r1, r4, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	mov r0, r4
	bl ovl01_216E8EC
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
_0216F4D4:
	bl FX_Atan2Idx
	ldr r3, [r4, #0x798]
	mov r1, r0
	cmp r3, #0x1800
	bge _0216F510
	ldr r0, _0216F554 // =0x00000199
	rsb r2, r3, #0x1800
	cmp r2, r0
	movle r0, #0x1800
	strle r0, [r4, #0x798]
	ble _0216F530
	add r0, r3, #0x99
	add r0, r0, #0x100
	str r0, [r4, #0x798]
	b _0216F530
_0216F510:
	ble _0216F530
	ldr r0, _0216F554 // =0x00000199
	sub r2, r3, #0x1800
	cmp r2, r0
	subgt r0, r3, r0
	strgt r0, [r4, #0x798]
	movle r0, #0x1800
	strle r0, [r4, #0x798]
_0216F530:
	add r0, r4, #0x700
	ldrh r0, [r0, #0x96]
	mov r2, #0x2d8
	bl Unknown2066510__LerpAngle2
	add r1, r4, #0x700
	strh r0, [r1, #0x96]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0216F550: .word 0x00000303
_0216F554: .word 0x00000199
	arm_func_end ovl01_216F410

	arm_func_start ovl01_216F558
ovl01_216F558: // 0x0216F558
	ldr r0, [r0, #0x37c]
	ldr r0, [r0, #0x37c]
	ldr r0, [r0, #0x798]
	cmp r0, #1
	cmpne r0, #2
	movne r0, #0
	moveq r0, #1
	bx lr
	arm_func_end ovl01_216F558

	arm_func_start ovl01_216F578
ovl01_216F578: // 0x0216F578
	stmdb sp!, {r3, lr}
	bl ovl01_216F558
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_216F578

	arm_func_start ovl01_216F590
ovl01_216F590: // 0x0216F590
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x37c]
	add r1, r4, #0x580
	add r0, r0, #0x300
	ldrsh r2, [r0, #0xcc]
	add r0, r4, #0x380
	cmp r2, #0
	rsblt r2, r2, #0
	and r3, r2, #0xff
	mov r2, #0x100
	bl DarkenColors
	add r0, r4, #0x580
	mov r1, #0x200
	bl DC_StoreRange
	ldr r1, _0216F5E8 // =VRAMSystem__VRAM_PALETTE_BG
	add r0, r4, #0x580
	ldr r3, [r1, #0]
	mov r1, #0x100
	mov r2, #0
	bl QueueUncompressedPalette
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216F5E8: .word VRAMSystem__VRAM_PALETTE_BG
	arm_func_end ovl01_216F590

	arm_func_start ovl01_216F5EC
ovl01_216F5EC: // 0x0216F5EC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r2, _0216F710 // =0x0000040A
	add r1, r4, #0x380
	mov r0, #0
	bl MIi_CpuClear16
	mov r0, r4
	bl ovl01_216E860
	mov r0, r4
	bl ovl01_216E880
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x37c]
	bl ovl01_216FF88
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x37c]
	bl ovl01_216FFA8
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x37c]
	bl ovl01_2170120
	ldr r0, _0216F714 // =playerGameStatus
	ldr r1, [r0, #0]
	bic r1, r1, #1
	str r1, [r0]
	bl StopStageBGM
	mov r0, #0
	str r0, [r4, #0x8e0]
	str r0, [r4, #0x798]
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x37c]
	bl ovl01_2170BE0
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x37c]
	bl ovl01_2172158
	mov r1, #0
	ldr r0, [r4, #0x37c]
	str r1, [r0, #0x4ec]
	bl EnableObjectManagerFlag2
	ldr r0, [r4, #0x18]
	ldr r1, _0216F718 // =gPlayer
	orr r0, r0, #0x20
	str r0, [r4, #0x18]
	ldr r2, [r4, #0x37c]
	mov r0, #0
	ldr r3, [r2, #0x37c]
	ldr r2, [r3, #0x18]
	orr r2, r2, #0x20
	str r2, [r3, #0x18]
	ldr r3, [r4, #0x37c]
	ldr r2, [r3, #0x18]
	orr r2, r2, #0x20
	str r2, [r3, #0x18]
	ldr r3, [r1, #0]
	ldr r1, [r3, #0x44]
	ldr r2, [r3, #0x48]
	ldr r3, [r3, #0x4c]
	rsb r2, r2, #0
	bl BossFX__CreatePirateExplode2
	mov r0, #0
	str r0, [sp]
	mov r1, #0x90
	str r1, [sp, #4]
	sub r1, r1, #0x91
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r1, #0
	add r0, r4, #0x780
	strh r1, [r0, #8]
	ldr r0, _0216F71C // =ovl01_216F720
	str r0, [r4, #0x78c]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216F710: .word 0x0000040A
_0216F714: .word playerGameStatus
_0216F718: .word gPlayer
_0216F71C: .word ovl01_216F720
	arm_func_end ovl01_216F5EC

	arm_func_start ovl01_216F720
ovl01_216F720: // 0x0216F720
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	add r0, r4, #0x780
	ldrh r1, [r0, #8]
	add r1, r1, #1
	strh r1, [r0, #8]
	ldrh r0, [r0, #8]
	cmp r0, #0x5a
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x37c]
	ldr r0, [r0, #0x798]
	cmp r0, #1
	cmpne r0, #2
	beq _0216F768
	mov r0, #1
	bl BossArena__GetCamera
	b _0216F770
_0216F768:
	mov r0, #2
	bl BossArena__GetCamera
_0216F770:
	ldr r2, [r4, #0x48]
	mov r5, r0
	ldr r1, [r4, #0x44]
	ldr r3, [r4, #0x4c]
	mov r0, r5
	rsb r2, r2, #0
	bl BossArena__SetTracker1TargetPos
	mov r0, r5
	mov r1, #0x96000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r5
	mov r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r1, #0xcc
	mov r0, r5
	mov r2, r1
	bl BossArena__SetTracker1Speed
	mov r1, #0xcc
	mov r0, r5
	mov r2, r1
	bl BossArena__SetTracker0Speed
	ldr r0, _0216F7D0 // =ovl01_216F7D4
	str r0, [r4, #0x78c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216F7D0: .word ovl01_216F7D4
	arm_func_end ovl01_216F720

	arm_func_start ovl01_216F7D4
ovl01_216F7D4: // 0x0216F7D4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl Camera3D__GetWork
	mov r4, r0
	mov r0, r5
	bl ovl01_216F578
	mov r1, #0x5c
	mla r4, r0, r1, r4
	add r1, r4, #0x20
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	ldrh r2, [r4, #0x20]
	ldr r0, _0216F85C // =VRAMSystem__VRAM_PALETTE_BG
	add r1, r5, #0x380
	bic r2, r2, #0xc0
	orr r2, r2, #0xc0
	strh r2, [r4, #0x20]
	ldrh r3, [r4, #0x20]
	ldr r0, [r0, #0]
	mov r2, #0x200
	bic r3, r3, #1
	orr r3, r3, #1
	strh r3, [r4, #0x20]
	ldrh r3, [r4, #0x20]
	orr r3, r3, #0x1e
	strh r3, [r4, #0x20]
	bl MIi_CpuCopyFast
	add r0, r5, #0x780
	mov r2, #0
	ldr r1, _0216F860 // =ovl01_216F864
	strh r2, [r0, #8]
	str r1, [r5, #0x78c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216F85C: .word VRAMSystem__VRAM_PALETTE_BG
_0216F860: .word ovl01_216F864
	arm_func_end ovl01_216F7D4

	arm_func_start ovl01_216F864
ovl01_216F864: // 0x0216F864
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r10, r0
	ldr r1, [r10, #0x37c]
	mvn r0, #0xf
	add r1, r1, #0x300
	ldrsh r2, [r1, #0xcc]
	cmp r2, r0
	beq _0216F8B8
	add r0, r10, #0x780
	ldrh r2, [r0, #2]
	add r2, r2, #1
	strh r2, [r0, #2]
	ldrh r2, [r0, #2]
	cmp r2, #1
	bls _0216F8B8
	mov r2, #0
	strh r2, [r0, #2]
	ldrsh r0, [r1, #0xcc]
	sub r0, r0, #1
	strh r0, [r1, #0xcc]
_0216F8B8:
	bl Camera3D__GetWork
	mov r4, r0
	mov r0, r10
	bl ovl01_216F578
	mov r1, #0x5c
	mla r2, r0, r1, r4
	ldrh r0, [r2, #0x24]
	cmp r0, #0x10
	bhs _0216F90C
	add r0, r10, #0x780
	ldrh r1, [r0, #0]
	add r1, r1, #1
	strh r1, [r0]
	ldrh r1, [r0, #0]
	cmp r1, #2
	bls _0216F90C
	mov r1, #0
	strh r1, [r0]
	ldrh r0, [r2, #0x24]
	add r0, r0, #1
	strh r0, [r2, #0x24]
_0216F90C:
	mov r0, r10
	bl ovl01_216F590
	mov r9, #0
	ldr r8, _0216F9DC // =BossArena__explosionFXSpawnTime
	add r4, r10, #0x780
	mov r7, r9
	mov r11, r9
	mov r6, #0xcd
	mvn r5, #0
_0216F930:
	ldrh r1, [r4, #8]
	ldr r0, [r8, r9, lsl #2]
	cmp r1, r0
	bne _0216F9AC
	ldr r1, [r10, #0x48]
	ldr r3, [r10, #0x4c]
	rsb r2, r1, #0
	ldr r1, [r10, #0x44]
	mov r0, r7
	bl BossFX__CreatePirateExplode0
	str r11, [sp]
	mov r0, r11
	mov r1, r5
	mov r2, r5
	mov r3, r5
	str r6, [sp, #4]
	bl PlaySfxEx
	mov r0, r10
	bl ovl01_216F558
	cmp r0, #0
	moveq r0, #0x100
	movne r0, #0x200
	orr r0, r0, #3
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0x2000
	bl CreateDrawFadeTask
	mov r0, #0x3000
	mov r1, r0
	mov r2, #0x600
	bl ShakeScreenEx
_0216F9AC:
	add r9, r9, #1
	cmp r9, #3
	blt _0216F930
	add r0, r10, #0x780
	ldrh r2, [r0, #8]
	add r1, r2, #1
	strh r1, [r0, #8]
	cmp r2, #0xd2
	ldrhi r0, _0216F9E0 // =ovl01_216F9E4
	strhi r0, [r10, #0x78c]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216F9DC: .word BossArena__explosionFXSpawnTime
_0216F9E0: .word ovl01_216F9E4
	arm_func_end ovl01_216F864

	arm_func_start ovl01_216F9E4
ovl01_216F9E4: // 0x0216F9E4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	rsb r2, r0, #0
	ldr r3, [r4, #0x4c]
	mov r0, #0
	bl BossFX__CreatePirateExplode1
	ldr r2, _0216FA94 // =FX_SinCosTable_+0x00000500
	mov ip, #0x2000
	str ip, [r0, #0x38]
	str ip, [r0, #0x3c]
	ldrsh r1, [r2, #0x54]
	ldrsh r2, [r2, #0x56]
	ldr r3, _0216FA98 // =0x00000555
	str ip, [r0, #0x40]
	str r3, [r0, #0x280]
	add r0, r0, #0x18c
	bl MTX_RotX33_
	mov r0, #0xa000
	mov r1, #0x3000
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
	ldr r0, [r4, #0x37c]
	mov r2, #0x1000
	str r2, [r0, #0x4ec]
	mov r1, #0
	add r0, r4, #0x700
	strh r1, [r0, #0x88]
	ldr r1, _0216FA9C // =ovl01_216FAA0
	mov r0, r4
	str r1, [r4, #0x78c]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216FA94: .word FX_SinCosTable_+0x00000500
_0216FA98: .word 0x00000555
_0216FA9C: .word ovl01_216FAA0
	arm_func_end ovl01_216F9E4

	arm_func_start ovl01_216FAA0
ovl01_216FAA0: // 0x0216FAA0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x37c]
	bl Camera3D__GetWork
	add r1, r4, #0x300
	ldrsh r2, [r1, #0xcc]
	mov r4, #0
	mov r5, r4
	cmp r2, #0
	addne r2, r2, #1
	strneh r2, [r1, #0xcc]
	ldrsh r1, [r0, #0x58]
	moveq r4, #1
	cmp r1, #0x10
	bge _0216FB28
	add r1, r6, #0x780
	ldrh r2, [r1, #8]
	cmp r2, #0xb4
	bls _0216FB2C
	ldrh r2, [r1, #6]
	add r2, r2, #1
	strh r2, [r1, #6]
	ldrh r2, [r1, #6]
	cmp r2, #3
	bls _0216FB2C
	ldrsh r3, [r0, #0x58]
	mov r2, #0
	add r3, r3, #1
	strh r3, [r0, #0x58]
	ldrsh r3, [r0, #0xb4]
	add r3, r3, #1
	strh r3, [r0, #0xb4]
	strh r2, [r1, #6]
	b _0216FB2C
_0216FB28:
	mov r5, #1
_0216FB2C:
	mov r0, r6
	bl ovl01_216F590
	add r0, r6, #0x780
	ldrh r1, [r0, #8]
	cmp r4, #0
	cmpne r5, #0
	add r1, r1, #1
	strh r1, [r0, #8]
	ldrne r0, _0216FB58 // =ovl01_216FB5C
	strne r0, [r6, #0x78c]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216FB58: .word ovl01_216FB5C
	arm_func_end ovl01_216FAA0

	arm_func_start ovl01_216FB5C
ovl01_216FB5C: // 0x0216FB5C
	ldr r0, _0216FB70 // =playerGameStatus
	ldr r1, [r0, #0]
	orr r1, r1, #4
	str r1, [r0]
	bx lr
	.align 2, 0
_0216FB70: .word playerGameStatus
	arm_func_end ovl01_216FB5C

	arm_func_start ovl01_216FB74
ovl01_216FB74: // 0x0216FB74
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #4
	mov r2, #1
	mov r3, r2
	add r0, r0, #0x400
	mov r1, #0x10
	bl BossHelpers__SetPaletteAnimations
	add r0, r4, #0x600
	mov r1, #0x3c
	strh r1, [r0, #4]
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216FB74

	arm_func_start ovl01_216FBA4
ovl01_216FBA4: // 0x0216FBA4
	stmdb sp!, {r3, lr}
	add r1, r0, #0x600
	ldrh r2, [r1, #4]
	cmp r2, #0
	ldmeqia sp!, {r3, pc}
	sub r2, r2, #1
	strh r2, [r1, #4]
	ldrh r1, [r1, #4]
	cmp r1, #0
	ldmneia sp!, {r3, pc}
	add r0, r0, #4
	mov r2, #0
	mov r3, r2
	add r0, r0, #0x400
	mov r1, #0x10
	bl BossHelpers__SetPaletteAnimations
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_216FBA4

	arm_func_start ovl01_216FBE8
ovl01_216FBE8: // 0x0216FBE8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl01_21703A4
	ldr r1, [r4, #0x7d0]
	mov r0, r4
	blx r1
	mov r1, r0
	add r0, r4, #0x380
	bl ReadPadInput
	ldr r1, [r4, #0x7e4]
	mov r0, r4
	blx r1
	mov r0, r4
	bl ovl01_216FBA4
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216FBE8

	arm_func_start ovl01_216FC24
ovl01_216FC24: // 0x0216FC24
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x208
	add r0, r0, #0x400
	bl BossHelpers__ReleaseAnimation
	add r0, r4, #0x208
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	add r0, r4, #4
	add r6, r0, #0x400
	mov r5, #0
_0216FC58:
	mov r0, r6
	bl ReleasePaletteAnimator
	add r5, r5, #1
	cmp r5, #0x10
	add r6, r6, #0x20
	blt _0216FC58
	ldr r0, [r4, #0x788]
	bl FreeSndHandle
	ldr r0, [r4, #0x78c]
	bl FreeSndHandle
	mov r0, r7
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end ovl01_216FC24

	arm_func_start ovl01_216FC8C
ovl01_216FC8C: // 0x0216FC8C
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x37c]
	add r0, r0, #0x39c
	bl BossHelpers__RevertModifiedLights
	add r1, r4, #0x208
	mov r0, r4
	add r1, r1, #0x400
	bl StageTask__Draw3D
	ldr r0, [r4, #0x37c]
	add r0, r0, #0x39c
	bl BossHelpers__ApplyModifiedLights
	add r1, r4, #0x3d4
	mov r0, #0x1e
	bl BossHelpers__Model__SetMatrixMode
	add r0, r4, #4
	add r5, r0, #0x400
	mov r4, #0
_0216FCE4:
	mov r0, r5
	bl AnimatePalette
	mov r0, r5
	bl DrawAnimatedPalette
	add r4, r4, #1
	cmp r4, #0x10
	add r5, r5, #0x20
	blt _0216FCE4
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_216FC8C

	arm_func_start ovl01_216FD08
ovl01_216FD08: // 0x0216FD08
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x18]
	tst r0, #0xc
	ldmneia sp!, {r4, pc}
	tst r0, #2
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x230]
	tst r0, #4
	beq _0216FD40
	ldr r0, [r4, #0x234]
	add r1, r4, #0x218
	bl StageTask__HandleCollider
_0216FD40:
	ldr r0, [r4, #0x270]
	tst r0, #4
	beq _0216FD64
	ldr r2, [r4, #0x3fc]
	ldr r1, [r4, #0x3f8]
	ldr r3, [r4, #0x400]
	add r0, r4, #0x258
	rsb r2, r2, #0
	bl BossHelpers__Collision__HandleColliderSimple
_0216FD64:
	ldr r0, [r4, #0x2b0]
	tst r0, #4
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x2b4]
	add r1, r4, #0x298
	bl StageTask__HandleCollider
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216FD08

	arm_func_start ovl01_216FD80
ovl01_216FD80: // 0x0216FD80
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
	mov r0, r5
	bl Player__Action_AttackRecoil
	ldr r0, [r4, #0x3fc]
	ldr r1, [r5, #0x48]
	rsb r0, r0, #0
	cmp r1, r0
	mov r0, #0x5000
	rsble r0, r0, #0
	str r0, [r5, #0x9c]
	ldr ip, [r4, #0x3f8]
	ldr r3, [r5, #0x44]
	mov r0, #0x3000
	cmp r3, ip
	ble _0216FDFC
	ldrsh r2, [r6, #6]
	ldrsh r1, [r7, #0]
	add r2, ip, r2, lsl #12
	add r1, r3, r1, lsl #12
	sub r1, r2, r1
	str r1, [r5, #0xb0]
	b _0216FE18
_0216FDFC:
	ldrsh r2, [r6, #0]
	ldrsh r1, [r7, #6]
	rsb r0, r0, #0
	add r2, ip, r2, lsl #12
	add r1, r3, r1, lsl #12
	sub r1, r2, r1
	str r1, [r5, #0xb0]
_0216FE18:
	str r0, [r5, #0x98]
	add r0, r4, #0x300
	ldrsh r1, [r0, #0xd2]
	sub r1, r1, #1
	strh r1, [r0, #0xd2]
	ldrsh r0, [r0, #0xd2]
	cmp r0, #0
	bne _0216FE6C
	ldr r0, [r4, #0x37c]
	bl ovl01_216CB20
	mov r1, r0
	mov r0, r4
	bl ovl01_2172098
	mov r3, #0xb0
	sub r1, r3, #0xb1
	mov r0, #0
	stmia sp, {r0, r3}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _0216FE88
_0216FE6C:
	mov r6, #0xaf
	sub r1, r6, #0xb0
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r6}
	bl PlaySfxEx
_0216FE88:
	mov r0, r4
	bl ovl01_216FB74
	ldr r0, [r5, #0x48]
	ldr r1, [r5, #0x44]
	ldr r3, [r5, #0x4c]
	rsb r2, r0, #0
	mov r0, #0
	bl BossFX__CreateHitB
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end ovl01_216FD80

	arm_func_start ovl01_216FEB0
ovl01_216FEB0: // 0x0216FEB0
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r4, [r0, #0x1c]
	ldr ip, [r1, #0x1c]
	ldrh r2, [r4, #0]
	cmp r2, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r3, [r4, #0x44]
	ldr r2, [ip, #0x3f8]
	mov r5, #0x3000
	cmp r3, r2
	ble _0216FF04
	ldrsh r0, [r0, #0]
	ldrsh r1, [r1, #6]
	ldr r2, [ip, #0x44]
	add r0, r3, r0, lsl #12
	add r1, r2, r1, lsl #12
	sub r0, r1, r0
	str r0, [r4, #0xb0]
	b _0216FF24
_0216FF04:
	ldrsh r0, [r0, #6]
	ldrsh r1, [r1, #0]
	ldr r2, [ip, #0x44]
	add r0, r3, r0, lsl #12
	add r1, r2, r1, lsl #12
	sub r0, r1, r0
	str r0, [r4, #0xb0]
	rsb r5, r5, #0
_0216FF24:
	ldr r0, [r4, #0x1c]
	tst r0, #0x10
	moveq r0, r5, lsl #1
	streq r0, [r4, #0xc8]
	beq _0216FF4C
	mov r0, r4
	bl Player__Action_AttackRecoil
	str r5, [r4, #0x98]
	mov r0, #0x5000
	str r0, [r4, #0x9c]
_0216FF4C:
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	rsb r2, r0, #0
	ldr r3, [r4, #0x4c]
	mov r0, #0
	bl BossFX__CreateHitB
	mov r4, #0xaf
	sub r1, r4, #0xb0
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_216FEB0

	arm_func_start ovl01_216FF88
ovl01_216FF88: // 0x0216FF88
	ldr r1, [r0, #0x270]
	bic r1, r1, #4
	str r1, [r0, #0x270]
	bx lr
	arm_func_end ovl01_216FF88

	arm_func_start ovl01_216FF98
ovl01_216FF98: // 0x0216FF98
	ldr r1, [r0, #0x270]
	orr r1, r1, #4
	str r1, [r0, #0x270]
	bx lr
	arm_func_end ovl01_216FF98

	arm_func_start ovl01_216FFA8
ovl01_216FFA8: // 0x0216FFA8
	ldr r1, [r0, #0x230]
	bic r1, r1, #4
	str r1, [r0, #0x230]
	bx lr
	arm_func_end ovl01_216FFA8

	arm_func_start ovl01_216FFB8
ovl01_216FFB8: // 0x0216FFB8
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r2, [r0, #0x230]
	mov r1, #0
	orr r2, r2, #4
	str r2, [r0, #0x230]
	mov r2, #0x80
	str r2, [sp]
	sub r2, r2, #0xb8
	str r2, [sp, #4]
	mov ip, #8
	add r0, r0, #0x218
	sub r2, r1, #0x74
	sub r3, r1, #8
	str ip, [sp, #8]
	bl ObjRect__SetBox3D
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end ovl01_216FFB8

	arm_func_start ovl01_2170000
ovl01_2170000: // _02170000
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r2, [r0, #0x230]
	mov r1, #0x20
	orr r2, r2, #4
	str r2, [r0, #0x230]
	mov r2, #0x80
	str r2, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov ip, #8
	add r0, r0, #0x218
	sub r2, r1, #0x50
	sub r3, r1, #0x28
	str ip, [sp, #8]
	bl ObjRect__SetBox3D
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end ovl01_2170000

	arm_func_start ovl01_2170048
ovl01_2170048: // _02170048
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r2, [r0, #0x230]
	mov r1, #0x30
	orr r2, r2, #4
	str r2, [r0, #0x230]
	mov r2, #0x80
	str r2, [sp]
	mov r2, #0x18
	str r2, [sp, #4]
	mov ip, #8
	add r0, r0, #0x218
	sub r2, r1, #0xbc
	sub r3, r1, #0x38
	str ip, [sp, #8]
	bl ObjRect__SetBox3D
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end ovl01_2170048

	arm_func_start ovl01_2170090
ovl01_2170090: // _02170090
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r1, [r0, #0x230]
	mov ip, #8
	orr r1, r1, #4
	str r1, [r0, #0x230]
	mov r1, #0x19
	str r1, [sp]
	sub r1, r1, #0x50
	str r1, [sp, #4]
	add r0, r0, #0x218
	sub r1, ip, #0x21
	sub r2, ip, #0x71
	sub r3, ip, #0x10
	str ip, [sp, #8]
	bl ObjRect__SetBox3D
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end ovl01_2170090

	arm_func_start ovl01_21700D8
ovl01_21700D8: // _021700D8
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r1, [r0, #0x230]
	mov ip, #8
	orr r1, r1, #4
	str r1, [r0, #0x230]
	mov r1, #0x14
	str r1, [sp]
	sub r1, r1, #0x1e
	str r1, [sp, #4]
	add r0, r0, #0x218
	sub r1, ip, #0x1c
	sub r2, ip, #0x3a
	sub r3, ip, #0x10
	str ip, [sp, #8]
	bl ObjRect__SetBox3D
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end ovl01_21700D8

	arm_func_start ovl01_2170120
ovl01_2170120: // _02170120
	ldr r1, [r0, #0x2b0]
	bic r1, r1, #4
	str r1, [r0, #0x2b0]
	bx lr
	arm_func_end ovl01_2170120

	arm_func_start ovl01_2170130
ovl01_2170130: // _02170130
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r1, [r0, #0x2b0]
	mov ip, #8
	orr r1, r1, #4
	str r1, [r0, #0x2b0]
	mov r1, #0x14
	str r1, [sp]
	sub r1, r1, #0x1e
	str r1, [sp, #4]
	add r0, r0, #0x298
	sub r1, ip, #0x1c
	sub r2, ip, #0x3a
	sub r3, ip, #0x10
	str ip, [sp, #8]
	bl ObjRect__SetBox3D
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end ovl01_2170130

	arm_func_start ovl01_2170178
ovl01_2170178: // _02170178
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r1, [r0, #0x2b0]
	mov ip, #8
	orr r1, r1, #4
	str r1, [r0, #0x2b0]
	mov r1, #0x19
	str r1, [sp]
	sub r1, r1, #0x50
	str r1, [sp, #4]
	add r0, r0, #0x298
	sub r1, ip, #0x21
	sub r2, ip, #0x71
	sub r3, ip, #0x10
	str ip, [sp, #8]
	bl ObjRect__SetBox3D
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end ovl01_2170178

	arm_func_start ovl01_21701C0
ovl01_21701C0: // _021701C0
	ldr r0, [r0, #0x20]
	and r0, r0, #1
	bx lr
	arm_func_end ovl01_21701C0

	arm_func_start ovl01_21701CC
ovl01_21701CC: // _021701CC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r3, r1
	mov r4, r0
	str r3, [r4, #0x784]
	ldr r0, [r4, #0x20]
	cmp r2, #0
	orrne r0, r0, #4
	biceq r0, r0, #4
	str r0, [r4, #0x20]
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x208
	ldr r2, [r4, #0x750]
	add r0, r0, #0x400
	bl BossHelpers__SetAnimation
	mov r0, #0x1000
	str r0, [r4, #0x720]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_21701CC

	arm_func_start ovl01_2170220
ovl01_2170220: // _02170220
	str r1, [r0, #0x720]
	bx lr
	arm_func_end ovl01_2170220

	arm_func_start ovl01_2170228
ovl01_2170228: // _02170228
	ldr r0, [r0, #0x6ec]
	ldr r0, [r0, #0]
	bx lr
	arm_func_end ovl01_2170228

	arm_func_start ovl01_2170234
ovl01_2170234: // _02170234
	ldr r0, [r0, #0x20]
	and r0, r0, #8
	bx lr
	arm_func_end ovl01_2170234

	arm_func_start ovl01_2170240
ovl01_2170240: // _02170240
	add r0, r0, #0x700
	ldrh r2, [r0, #0x14]
	orr r2, r2, #4
	strh r2, [r0, #0x14]
	strh r1, [r0, #0x3a]
	bx lr
	arm_func_end ovl01_2170240

	arm_func_start ovl01_2170258
ovl01_2170258: // _02170258
	add r0, r0, #0x700
	ldrh r0, [r0, #0x14]
	tst r0, #4
	moveq r0, #1
	bxeq lr
	tst r0, #0x4000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end ovl01_2170258

	arm_func_start ovl01_217027C
ovl01_217027C: // _0217027C
	stmdb sp!, {r3, lr}
	ldr r0, [r0, #0x20]
	tst r0, #1
	beq _021702A4
	ldr r2, _021702BC // =FX_SinCosTable_+0x00003000
	mov r0, r1
	ldrsh r1, [r2, #0]
	ldrsh r2, [r2, #2]
	bl MTX_RotY33_
	ldmia sp!, {r3, pc}
_021702A4:
	ldr r2, _021702C0 // =FX_SinCosTable_+0x00001000
	mov r0, r1
	ldrsh r1, [r2, #0]
	ldrsh r2, [r2, #2]
	bl MTX_RotY33_
	ldmia sp!, {r3, pc}
	.align 2, 0
_021702BC: .word FX_SinCosTable_+0x00003000
_021702C0: .word FX_SinCosTable_+0x00001000
	arm_func_end ovl01_217027C

	arm_func_start ovl01_21702C4
ovl01_21702C4: // _021702C4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #0x48]
	mov r5, r1
	ldr r1, [r6, #0x44]
	ldr r3, [r6, #0x4c]
	rsb r2, r0, #0
	mov r0, #0
	bl BossFX__CreatePirateSwdui
	mov r4, r0
	mov r0, r6
	add r1, r4, #0x18c
	bl ovl01_217027C
	str r5, [r4, #0x280]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl01_21702C4

	arm_func_start ovl01_2170300
ovl01_2170300: // _02170300
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #0x48]
	mov r5, r1
	ldr r1, [r6, #0x44]
	ldr r3, [r6, #0x4c]
	rsb r2, r0, #0
	mov r0, #0
	bl BossFX__CreatePirateSwdji
	mov r4, r0
	mov r0, r6
	add r1, r4, #0x18c
	bl ovl01_217027C
	str r5, [r4, #0x280]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl01_2170300

	arm_func_start ovl01_217033C
ovl01_217033C: // _0217033C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	ldr r3, [r4, #0x4c]
	rsb r2, r0, #0
	mov r0, #0
	bl BossFX__CreatePirateKick
	mov r1, r0
	mov r0, r4
	add r1, r1, #0x18c
	bl ovl01_217027C
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_217033C

	arm_func_start ovl01_2170370
ovl01_2170370: // _02170370
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	ldr r3, [r4, #0x4c]
	rsb r2, r0, #0
	mov r0, #0
	bl BossFX__CreatePirateShot
	mov r1, r0
	mov r0, r4
	add r1, r1, #0x18c
	bl ovl01_217027C
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2170370

	arm_func_start ovl01_21703A4
ovl01_21703A4: // _021703A4
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	add r5, r4, #0x394
	bl ovl01_216CE28
	ldr r1, _021704A8 // =gPlayer
	str r0, [r4, #0x794]
	ldr r0, [r1, #0]
	bl ovl01_216CE28
	str r0, [r5, #0x404]
	ldr r0, _021704A8 // =gPlayer
	ldr r1, [r4, #0x44]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x44]
	subs r0, r1, r0
	str r0, [r5, #0x410]
	rsbmi r0, r0, #0
	str r0, [r5, #0x410]
	ldr r0, [r4, #0x7e8]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _02170444
_021703F8: // jump table
	b _02170444 // case 0
	b _0217040C // case 1
	b _0217040C // case 2
	b _0217040C // case 3
	b _0217040C // case 4
_0217040C:
	ldr r1, [r5, #0x41c]
	cmp r1, #0
	ble _02170428
	ldr r0, [r5, #0x410]
	cmp r0, #0xa0000
	sublt r0, r1, #1
	strlt r0, [r5, #0x41c]
_02170428:
	ldr r1, [r5, #0x420]
	cmp r1, #0
	ble _02170444
	ldr r0, [r5, #0x410]
	cmp r0, #0xa0000
	subge r0, r1, #1
	strge r0, [r5, #0x420]
_02170444:
	ldr r0, _021704A8 // =gPlayer
	ldr r0, [r0, #0]
	add r0, r0, #0x500
	ldrsh r0, [r0, #0xd4]
	sub r0, r0, #0xe
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02170474
_02170464: // jump table
	b _0217047C // case 0
	b _0217047C // case 1
	b _0217047C // case 2
	b _0217047C // case 3
_02170474:
	mov r0, #0
	b _02170490
_0217047C:
	ldr r0, [r5, #0x40c]
	cmp r0, #0
	moveq r0, #1
	streq r0, [r5, #0x408]
	mov r0, #1
_02170490:
	str r0, [r5, #0x40c]
	ldr r0, [r4, #0x7d4]
	cmp r0, #0xb
	moveq r0, #0
	streq r0, [r5, #0x408]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021704A8: .word gPlayer
	arm_func_end ovl01_21703A4

	arm_func_start ovl01_21704AC
ovl01_21704AC: // _021704AC
	ldr r1, [r0, #0x794]
	add r0, r0, #0x394
	cmp r1, #0
	ldrne r0, [r0, #0x404]
	cmpne r0, #0
	moveq r0, #1
	bxeq lr
	cmp r1, r0
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end ovl01_21704AC

	arm_func_start ovl01_21704D8
ovl01_21704D8: // _021704D8
	ldr r2, _02170510 // =_mt_math_rand
	ldr r0, _02170514 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02170518 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	add r0, r0, r0, lsl #2
	mov r0, r0, lsl #0xe
	str r1, [r2]
	add r0, r0, #0x3c000
	bx lr
	.align 2, 0
_02170510: .word _mt_math_rand
_02170514: .word 0x00196225
_02170518: .word 0x3C6EF35F
	arm_func_end ovl01_21704D8

	arm_func_start ovl01_217051C
ovl01_217051C: // _0217051C
	ldr r2, _02170550 // =_mt_math_rand
	ldr r0, _02170554 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02170558 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	rsb r0, r0, r0, lsl #4
	str r1, [r2]
	add r0, r0, #0x1e
	bx lr
	.align 2, 0
_02170550: .word _mt_math_rand
_02170554: .word 0x00196225
_02170558: .word 0x3C6EF35F
	arm_func_end ovl01_217051C

	arm_func_start ovl01_217055C
ovl01_217055C: // _0217055C
	stmdb sp!, {r3, r4, r5, lr}
	ldr r0, [r0, #0x37c]
	bl ovl01_216C9B0
	ldr ip, _021705DC // =_mt_math_rand
	ldr r1, _021705E0 // =0x00196225
	ldr r4, [ip]
	ldr r2, _021705E4 // =0x3C6EF35F
	ldr r3, _021705E8 // =gameState
	mla lr, r4, r1, r2
	ldr r5, [r3, #0x18]
	ldr r4, _021705EC // =_02179FF8
	mov r3, lr, lsr #0x10
	add r4, r4, r5, lsl #5
	add r0, r4, r0, lsl #3
	mov r3, r3, lsl #0x10
	mov r4, r3, lsr #0x10
	ldrh r3, [r0, #6]
	and r4, r4, #0xff
	str lr, [ip]
	cmp r4, r3
	movlt r0, #1
	ldmltia sp!, {r3, r4, r5, pc}
	mla r4, lr, r1, r2
	mov r1, r4, lsr #0x10
	ldrh r2, [r0, #2]
	mov r1, r1, lsl #0x10
	ldrh lr, [r0]
	ldrh r3, [r0, #4]
	and r0, r2, r1, lsr #16
	str r4, [ip]
	mla r0, r3, r0, lr
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021705DC: .word _mt_math_rand
_021705E0: .word 0x00196225
_021705E4: .word 0x3C6EF35F
_021705E8: .word gameState
_021705EC: .word _02179FF8
	arm_func_end ovl01_217055C

	arm_func_start ovl01_21705F0
ovl01_21705F0: // _021705F0
	stmdb sp!, {r4, r5, r6, lr}
	ldr r0, [r0, #0x37c]
	bl ovl01_216C9B0
	ldr r1, _02170654 // =gameState
	ldr r3, _02170658 // =_mt_math_rand
	mov r2, #6
	ldr r4, [r1, #0x18]
	ldr ip, _0217065C // =_02179FC8
	mov r1, #0x18
	mla r5, r4, r1, ip
	mul r4, r0, r2
	add r6, r5, r4
	ldr ip, [r3]
	ldr r0, _02170660 // =0x00196225
	ldr r1, _02170664 // =0x3C6EF35F
	ldrh r2, [r6, #2]
	mla lr, ip, r0, r1
	mov r0, lr, lsr #0x10
	mov r0, r0, lsl #0x10
	ldrh ip, [r5, r4]
	ldrh r1, [r6, #4]
	and r0, r2, r0, lsr #16
	str lr, [r3]
	mla r0, r1, r0, ip
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02170654: .word gameState
_02170658: .word _mt_math_rand
_0217065C: .word _02179FC8
_02170660: .word 0x00196225
_02170664: .word 0x3C6EF35F
	arm_func_end ovl01_21705F0

	arm_func_start ovl01_2170668
ovl01_2170668: // _02170668
	stmdb sp!, {r3, lr}
	bl ovl01_21704AC
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_2170668

	arm_func_start ovl01_2170680
ovl01_2170680: // _02170680
	add r0, r0, #0x394
	ldr r1, [r0, #0x418]
	ldr r0, [r0, #0x410]
	cmp r1, r0
	movle r0, #1
	movgt r0, #0
	bx lr
	arm_func_end ovl01_2170680

	arm_func_start ovl01_217069C
ovl01_217069C: // _0217069C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r7, r0
	ldr r0, [r7, #0x37c]
	bl ovl01_216C9B0
	cmp r0, #2
	ldreq r0, [r7, #0x7e0]
	cmpeq r0, #0
	bne _021706CC
	mov r0, #1
	str r0, [r7, #0x7e0]
	mov r0, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_021706CC:
	ldr r6, _02170758 // =_0217A038
	ldr r5, _0217075C // =gameState
	ldr r4, _02170760 // =_mt_math_rand
	ldr r8, _02170764 // =0x00196225
	ldr r9, _02170768 // =0x3C6EF35F
_021706E0:
	ldr r0, [r5, #0x14]
	cmp r0, #3
	ldreq r0, [r5, #0x70]
	cmpeq r0, #0xf
	ldr r0, [r4, #0]
	bne _0217071C
	mla r1, r0, r8, r9
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x1d
	add r0, r6, r0, lsr #27
	str r1, [r4]
	ldr r0, [r0, #0x60]
	b _02170744
_0217071C:
	mla r1, r0, r8, r9
	str r1, [r4]
	mov r0, r1, lsr #0x10
	mov r1, r0, lsl #0x10
	ldr r0, [r7, #0x37c]
	mov r10, r1, lsr #0x10
	bl ovl01_216C9B0
	and r1, r10, #7
	add r0, r6, r0, lsl #5
	ldr r0, [r0, r1, lsl #2]
_02170744:
	cmp r0, #8
	ldreq r1, [r7, #0x7d8]
	cmpeq r1, #8
	beq _021706E0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02170758: .word _0217A038
_0217075C: .word gameState
_02170760: .word _mt_math_rand
_02170764: .word 0x00196225
_02170768: .word 0x3C6EF35F
	arm_func_end ovl01_217069C

	arm_func_start ovl01_217076C
ovl01_217076C: // _0217076C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r7, r0
	ldr r0, [r7, #0x37c]
	bl ovl01_216C9B0
	cmp r0, #2
	ldreq r0, [r7, #0x7e0]
	cmpeq r0, #0
	bne _0217079C
	mov r0, #1
	str r0, [r7, #0x7e0]
	mov r0, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_0217079C:
	ldr r6, _02170828 // =_0217A0B8
	ldr r5, _0217082C // =gameState
	ldr r4, _02170830 // =_mt_math_rand
	ldr r8, _02170834 // =0x00196225
	ldr r9, _02170838 // =0x3C6EF35F
_021707B0:
	ldr r0, [r5, #0x14]
	cmp r0, #3
	ldreq r0, [r5, #0x70]
	cmpeq r0, #0xf
	ldr r0, [r4, #0]
	bne _021707EC
	mla r1, r0, r8, r9
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x1d
	add r0, r6, r0, lsr #27
	str r1, [r4]
	ldr r0, [r0, #0x60]
	b _02170814
_021707EC:
	mla r1, r0, r8, r9
	str r1, [r4]
	mov r0, r1, lsr #0x10
	mov r1, r0, lsl #0x10
	ldr r0, [r7, #0x37c]
	mov r10, r1, lsr #0x10
	bl ovl01_216C9B0
	and r1, r10, #7
	add r0, r6, r0, lsl #5
	ldr r0, [r0, r1, lsl #2]
_02170814:
	cmp r0, #8
	ldreq r1, [r7, #0x7d8]
	cmpeq r1, #8
	beq _021707B0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02170828: .word _0217A0B8
_0217082C: .word gameState
_02170830: .word _mt_math_rand
_02170834: .word 0x00196225
_02170838: .word 0x3C6EF35F
	arm_func_end ovl01_217076C

	arm_func_start ovl01_217083C
ovl01_217083C: // _0217083C
	ldr r3, _0217087C // =_mt_math_rand
	ldr r0, _02170880 // =0x00196225
	ldr ip, [r3]
	ldr r1, _02170884 // =0x3C6EF35F
	mov r2, #0x1e
	mla r1, ip, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	smulbb r0, r0, r2
	add r0, r0, #0x3c
	mov r0, r0, lsl #0x10
	str r1, [r3]
	mov r0, r0, lsr #0x10
	bx lr
	.align 2, 0
_0217087C: .word _mt_math_rand
_02170880: .word 0x00196225
_02170884: .word 0x3C6EF35F
	arm_func_end ovl01_217083C

	arm_func_start ovl01_2170888
ovl01_2170888: // _02170888
	ldr r2, _021708C4 // =_mt_math_rand
	ldr r0, _021708C8 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _021708CC // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	rsb r0, r0, r0, lsl #4
	add r0, r0, #0x2d
	mov r0, r0, lsl #0x10
	str r1, [r2]
	mov r0, r0, lsr #0x10
	bx lr
	.align 2, 0
_021708C4: .word _mt_math_rand
_021708C8: .word 0x00196225
_021708CC: .word 0x3C6EF35F
	arm_func_end ovl01_2170888

	arm_func_start ovl01_21708D0
ovl01_21708D0: // _021708D0
	mov r2, #0
	ldr r1, _021708E4 // =ovl01_2170BF8
	str r2, [r0, #0x7d4]
	str r1, [r0, #0x7d0]
	bx lr
	.align 2, 0
_021708E4: .word ovl01_2170BF8
	arm_func_end ovl01_21708D0

	arm_func_start ovl01_21708E8
ovl01_21708E8: // _021708E8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0x394
	add r4, r0, #0x400
	mov r0, #1
	ldr r3, _02170964 // =ovl01_2170C20
	str r0, [r5, #0x7d4]
	add r1, r4, #0x24
	mov r0, #0
	mov r2, #4
	str r3, [r5, #0x7d0]
	bl MIi_CpuClear16
	mov r0, r5
	bl ovl01_21704D8
	str r0, [r4, #0x18]
	mov r0, r5
	bl ovl01_217051C
	str r0, [r4, #0x14]
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	bge _02170948
	mov r0, r5
	bl ovl01_217055C
	str r0, [r4, #0x1c]
_02170948:
	ldr r0, [r4, #0x20]
	cmp r0, #0
	ldmgeia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl ovl01_21705F0
	str r0, [r4, #0x20]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02170964: .word ovl01_2170C20
	arm_func_end ovl01_21708E8

	arm_func_start ovl01_2170968
ovl01_2170968: // _02170968
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r2, #2
	add r0, r5, #0x3b8
	mov r4, r1
	ldr r3, _021709A0 // =ovl01_2170F30
	str r2, [r5, #0x7d4]
	add r1, r0, #0x400
	mov r0, #0
	mov r2, #4
	str r3, [r5, #0x7d0]
	bl MIi_CpuClear16
	str r4, [r5, #0x7b8]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021709A0: .word ovl01_2170F30
	arm_func_end ovl01_2170968

	arm_func_start ovl01_21709A4
ovl01_21709A4: // _021709A4
	stmdb sp!, {r3, r4, r5, lr}
	movs r5, r1
	ldrne r1, [r0, #0x794]
	add r4, r0, #0x3b8
	cmpne r1, r5
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r2, #3
	ldr r1, _021709E4 // =ovl01_2170FD4
	str r2, [r0, #0x7d4]
	str r1, [r0, #0x7d0]
	add r1, r4, #0x400
	mov r0, #0
	mov r2, #4
	bl MIi_CpuClear16
	str r5, [r4, #0x400]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021709E4: .word ovl01_2170FD4
	arm_func_end ovl01_21709A4

	arm_func_start ovl01_21709E8
ovl01_21709E8: // _021709E8
	stmdb sp!, {r3, lr}
	mov ip, r0
	add r0, ip, #0x3b8
	mov r2, #4
	ldr r3, _02170A14 // =ovl01_21710FC
	str r2, [ip, #0x7d4]
	add r1, r0, #0x400
	mov r0, #0
	str r3, [ip, #0x7d0]
	bl MIi_CpuClear16
	ldmia sp!, {r3, pc}
	.align 2, 0
_02170A14: .word ovl01_21710FC
	arm_func_end ovl01_21709E8

	arm_func_start ovl01_2170A18
ovl01_2170A18: // _02170A18
	stmdb sp!, {r3, r4, r5, lr}
	mov ip, #5
	str ip, [r0, #0x7d4]
	add r2, r0, #0x394
	ldr r3, _02170A5C // =ovl01_2171190
	str ip, [r0, #0x7d8]
	str r3, [r0, #0x7d0]
	add r4, r2, #0x400
	mov r5, r1
	add r1, r4, #0x24
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear16
	strh r5, [r4, #0x28]
	mvn r0, #0
	str r0, [r4, #0x1c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02170A5C: .word ovl01_2171190
	arm_func_end ovl01_2170A18

	arm_func_start ovl01_2170A60
ovl01_2170A60: // _02170A60
	stmdb sp!, {r3, r4, r5, lr}
	mov ip, #6
	str ip, [r0, #0x7d4]
	add r2, r0, #0x394
	ldr r3, _02170AA4 // =ovl01_2171310
	str ip, [r0, #0x7d8]
	str r3, [r0, #0x7d0]
	add r4, r2, #0x400
	mov r5, r1
	add r1, r4, #0x24
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear16
	strh r5, [r4, #0x28]
	mvn r0, #0
	str r0, [r4, #0x20]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02170AA4: .word ovl01_2171310
	arm_func_end ovl01_2170A60

	arm_func_start ovl01_2170AA8
ovl01_2170AA8: // _02170AA8
	stmdb sp!, {r4, lr}
	mov r2, #7
	str r2, [r0, #0x7d4]
	add r1, r0, #0x394
	add r4, r1, #0x400
	ldr r1, _02170AE4 // =ovl01_2171434
	str r2, [r0, #0x7d8]
	str r1, [r0, #0x7d0]
	add r1, r4, #0x24
	mov r0, #0
	mov r2, #4
	bl MIi_CpuClear16
	mvn r0, #0
	str r0, [r4, #0x1c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170AE4: .word ovl01_2171434
	arm_func_end ovl01_2170AA8

	arm_func_start ovl01_2170AE8
ovl01_2170AE8: // _02170AE8
	stmdb sp!, {r3, r4, r5, lr}
	mov r2, #8
	str r2, [r0, #0x7d4]
	add r3, r0, #0x394
	ldr ip, _02170B2C // =ovl01_2171528
	str r2, [r0, #0x7d8]
	str ip, [r0, #0x7d0]
	add r4, r3, #0x400
	mov r5, r1
	add r1, r4, #0x24
	mov r0, #0
	bl MIi_CpuClear16
	mvn r0, #0
	str r5, [r4, #0x28]
	str r0, [r4, #0x20]
	str r0, [r4, #0x1c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02170B2C: .word ovl01_2171528
	arm_func_end ovl01_2170AE8

	arm_func_start ovl01_2170B30
ovl01_2170B30: // _02170B30
	stmdb sp!, {r3, r4, r5, lr}
	mov r3, #9
	ldr r2, _02170B64 // =ovl01_2171620
	str r3, [r0, #0x7d4]
	add r4, r0, #0x3b8
	mov r5, r1
	str r2, [r0, #0x7d0]
	add r1, r4, #0x400
	mov r0, #0
	mov r2, #0x18
	bl MIi_CpuClear16
	str r5, [r4, #0x404]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02170B64: .word ovl01_2171620
	arm_func_end ovl01_2170B30

	arm_func_start ovl01_2170B68
ovl01_2170B68: // _02170B68
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r2, #0xa
	add r0, r4, #0x3b8
	ldr r1, _02170BA0 // =ovl01_21717CC
	str r2, [r4, #0x7d4]
	str r1, [r4, #0x7d0]
	add r1, r0, #0x400
	mov r0, #0
	mov r2, #4
	bl MIi_CpuClear16
	ldr r0, [r4, #0x3fc]
	str r0, [r4, #0x7b8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170BA0: .word ovl01_21717CC
	arm_func_end ovl01_2170B68

	arm_func_start ovl01_2170BA4
ovl01_2170BA4: // _02170BA4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x3b8
	mov r1, #0xb
	ldr r3, _02170BDC // =ovl01_2171858
	str r1, [r4, #0x7d4]
	add r1, r0, #0x400
	mov r0, #0
	mov r2, #2
	str r3, [r4, #0x7d0]
	bl MIi_CpuClear16
	mov r0, r4
	bl ovl01_2172134
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170BDC: .word ovl01_2171858
	arm_func_end ovl01_2170BA4

	arm_func_start ovl01_2170BE0
ovl01_2170BE0: // _02170BE0
	mov r2, #0xc
	ldr r1, _02170BF4 // =ovl01_2171874
	str r2, [r0, #0x7d4]
	str r1, [r0, #0x7d0]
	bx lr
	.align 2, 0
_02170BF4: .word ovl01_2171874
	arm_func_end ovl01_2170BE0

	arm_func_start ovl01_2170BF8
ovl01_2170BF8: // _02170BF8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetSysEventList
	ldrsh r0, [r0, #0xc]
	cmp r0, #0xd
	beq _02170C18
	mov r0, r4
	bl ovl01_21708E8
_02170C18:
	mov r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2170BF8

	arm_func_start ovl01_2170C20
ovl01_2170C20: // _02170C20
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r1, [r5, #0x7e8]
	add r4, r5, #0x394
	cmp r1, #0xc
	bne _02170C44
	bl ovl01_2170B68
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02170C44:
	ldr r1, [r4, #0x408]
	cmp r1, #0
	beq _02170C5C
	bl ovl01_2170BA4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02170C5C:
	bl ovl01_2170668
	cmp r0, #0
	beq _02170CF0
	add r0, r5, #0x700
	ldrh r1, [r0, #0xdc]
	cmp r1, #0
	bne _02170CE8
	mov r0, r5
	bl ovl01_217083C
	add r1, r5, #0x700
	ldr r2, _02170F20 // =_mt_math_rand
	strh r0, [r1, #0xdc]
	ldr r3, [r2, #0]
	ldr r0, _02170F24 // =0x00196225
	ldr r1, _02170F28 // =0x3C6EF35F
	mla r0, r3, r0, r1
	str r0, [r2]
	mov r0, r0, lsr #0x10
	mov r1, r0, lsl #0x10
	ldr r0, [r5, #0x37c]
	mov r6, r1, lsr #0x10
	bl ovl01_216CD28
	cmp r0, r6, asr #4
	bgt _02170CCC
	ldr r1, [r4, #0x404]
	mov r0, r5
	bl ovl01_21709A4
	b _02170CE0
_02170CCC:
	ldr r0, [r5, #0x37c]
	bl ovl01_216CCCC
	mov r1, r0
	mov r0, r5
	bl ovl01_2170B30
_02170CE0:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02170CE8:
	sub r1, r1, #1
	strh r1, [r0, #0xdc]
_02170CF0:
	mov r0, r5
	bl ovl01_2170680
	cmp r0, #0
	beq _02170D24
	ldr r0, [r4, #0x414]
	cmp r0, #0
	bgt _02170D1C
	mov r0, r5
	bl ovl01_21709E8
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02170D1C:
	sub r0, r0, #1
	str r0, [r4, #0x414]
_02170D24:
	ldr r0, _02170F2C // =gPlayer
	ldr r1, [r5, #0x44]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x44]
	cmp r0, r1
	bge _02170D8C
	mov r0, r5
	bl ovl01_21701C0
	cmp r0, #0
	bne _02170D8C
	add r0, r5, #0x700
	ldrh r1, [r0, #0xde]
	cmp r1, #0
	bne _02170D80
	mov r0, r5
	bl ovl01_2170888
	add r1, r5, #0x700
	strh r0, [r1, #0xde]
	mov r0, r5
	mov r1, #1
	bl ovl01_2170968
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02170D80:
	sub r1, r1, #1
	strh r1, [r0, #0xde]
	b _02170DC8
_02170D8C:
	ldr r0, _02170F2C // =gPlayer
	ldr r1, [r5, #0x44]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x44]
	cmp r1, r0
	bge _02170DC8
	mov r0, r5
	bl ovl01_21701C0
	cmp r0, #0
	beq _02170DC8
	mov r0, r5
	mov r1, #0
	bl ovl01_2170968
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02170DC8:
	ldr r0, [r4, #0x41c]
	cmp r0, #0
	bne _02170E84
	mov r0, r5
	bl ovl01_217069C
	cmp r0, #9
	addls pc, pc, r0, lsl #2
	b _02170E7C
_02170DE8: // jump table
	b _02170E7C // case 0
	b _02170E7C // case 1
	b _02170E7C // case 2
	b _02170E7C // case 3
	b _02170E7C // case 4
	b _02170E28 // case 5
	b _02170E7C // case 6
	b _02170E40 // case 7
	b _02170E4C // case 8
	b _02170E10 // case 9
_02170E10:
	ldr r0, [r5, #0x37c]
	bl ovl01_216CCCC
	mov r1, r0
	mov r0, r5
	bl ovl01_2170B30
	b _02170E7C
_02170E28:
	ldr r0, [r5, #0x37c]
	bl ovl01_216CBCC
	mov r1, r0
	mov r0, r5
	bl ovl01_2170A18
	b _02170E7C
_02170E40:
	mov r0, r5
	bl ovl01_2170AA8
	b _02170E7C
_02170E4C:
	ldr r3, _02170F20 // =_mt_math_rand
	ldr r1, _02170F24 // =0x00196225
	ldr r4, [r3, #0]
	ldr r2, _02170F28 // =0x3C6EF35F
	mov r0, r5
	mla r2, r4, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #3
	str r2, [r3]
	bl ovl01_2170AE8
_02170E7C:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02170E84:
	ldr r0, [r4, #0x420]
	cmp r0, #0
	bne _02170F18
	mov r0, r5
	bl ovl01_217076C
	cmp r0, #6
	beq _02170EC8
	cmp r0, #8
	beq _02170EE0
	cmp r0, #9
	bne _02170F10
	ldr r0, [r5, #0x37c]
	bl ovl01_216CCCC
	mov r1, r0
	mov r0, r5
	bl ovl01_2170B30
	b _02170F10
_02170EC8:
	ldr r0, [r5, #0x37c]
	bl ovl01_216CC20
	mov r1, r0
	mov r0, r5
	bl ovl01_2170A60
	b _02170F10
_02170EE0:
	ldr r3, _02170F20 // =_mt_math_rand
	ldr r1, _02170F24 // =0x00196225
	ldr r4, [r3, #0]
	ldr r2, _02170F28 // =0x3C6EF35F
	mov r0, r5
	mla r2, r4, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #3
	str r2, [r3]
	bl ovl01_2170AE8
_02170F10:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02170F18:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02170F20: .word _mt_math_rand
_02170F24: .word 0x00196225
_02170F28: .word 0x3C6EF35F
_02170F2C: .word gPlayer
	arm_func_end ovl01_2170C20

	arm_func_start ovl01_2170F30
ovl01_2170F30: // _02170F30
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r1, [r6, #0x7e8]
	add r4, r6, #0x3b8
	cmp r1, #0xc
	mov r5, #0
	bne _02170F58
	bl ovl01_2170B68
	mov r0, r5
	ldmia sp!, {r4, r5, r6, pc}
_02170F58:
	ldr r1, [r4, #0x400]
	cmp r1, #0
	beq _02170F70
	bl ovl01_21701C0
	cmp r0, #0
	bne _02170F8C
_02170F70:
	ldr r0, [r4, #0x400]
	cmp r0, #0
	bne _02170F9C
	mov r0, r6
	bl ovl01_21701C0
	cmp r0, #0
	bne _02170F9C
_02170F8C:
	mov r0, r6
	bl ovl01_21708E8
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02170F9C:
	ldr r0, [r6, #0x7e8]
	cmp r0, #1
	bne _02170FCC
	ldr r0, [r4, #0x400]
	cmp r0, #0
	orreq r0, r5, #0x10
	moveq r0, r0, lsl #0x10
	moveq r5, r0, lsr #0x10
	beq _02170FCC
	orr r0, r5, #0x20
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
_02170FCC:
	mov r0, r5
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl01_2170F30

	arm_func_start ovl01_2170FD4
ovl01_2170FD4: // _02170FD4
	stmdb sp!, {r3, lr}
	ldr r2, [r0, #0x7e8]
	add r1, r0, #0x3b8
	cmp r2, #0xc
	bne _02170FF4
	bl ovl01_2170B68
	mov r0, #0
	ldmia sp!, {r3, pc}
_02170FF4:
	ldr r1, [r1, #0x400]
	sub r1, r1, #1
	cmp r1, #1
	ldrls r1, _02171014 // =ovl01_217101C
	ldrhi r1, _02171018 // =ovl01_217105C
	str r1, [r0, #0x7d0]
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02171014: .word ovl01_217101C
_02171018: .word ovl01_217105C
	arm_func_end ovl01_2170FD4

	arm_func_start ovl01_217101C
ovl01_217101C: // _0217101C
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x794]
	mov r2, #0
	sub r1, r1, #1
	cmp r1, #1
	bhi _02171040
	bl ovl01_21708E8
	mov r0, #0
	ldmia sp!, {r3, pc}
_02171040:
	ldr r0, [r0, #0x7e8]
	cmp r0, #1
	orreq r0, r2, #0x81
	moveq r0, r0, lsl #0x10
	moveq r2, r0, lsr #0x10
	mov r0, r2
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_217101C

	arm_func_start ovl01_217105C
ovl01_217105C: // _0217105C
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x794]
	mov r2, #0
	sub r1, r1, #3
	cmp r1, #1
	bhi _02171080
	bl ovl01_21708E8
	mov r0, #0
	ldmia sp!, {r3, pc}
_02171080:
	ldr r1, [r0, #0x7e8]
	cmp r1, #1
	beq _02171098
	cmp r1, #4
	beq _021710A8
	b _021710F4
_02171098:
	orr r0, r2, #1
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	b _021710F4
_021710A8:
	ldr r1, [r0, #0x9c]
	ldr r3, [r0, #0x44]
	cmp r1, #0
	orrlt r1, r2, #1
	movlt r1, r1, lsl #0x10
	movlt r2, r1, lsr #0x10
	ldr r1, [r0, #0x37c]
	ldr r0, [r1, #0x384]
	ldr r1, [r0, #0x46c]
	sub r0, r1, #0x87000
	cmp r3, r0
	orrlt r0, r2, #0x10
	movlt r0, r0, lsl #0x10
	add r1, r1, #0x87000
	movlt r2, r0, lsr #0x10
	cmp r3, r1
	orrgt r0, r2, #0x20
	movgt r0, r0, lsl #0x10
	movgt r2, r0, lsr #0x10
_021710F4:
	mov r0, r2
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_217105C

	arm_func_start ovl01_21710FC
ovl01_21710FC: // _021710FC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r1, [r6, #0x7e8]
	add r4, r6, #0x394
	cmp r1, #0xc
	mov r5, #0
	bne _02171124
	bl ovl01_2170B68
	mov r0, r5
	ldmia sp!, {r4, r5, r6, pc}
_02171124:
	bl ovl01_2170680
	cmp r0, #0
	mov r0, r6
	bne _02171140
	bl ovl01_21708E8
	mov r0, r5
	ldmia sp!, {r4, r5, r6, pc}
_02171140:
	bl ovl01_2170668
	cmp r0, #0
	beq _02171160
	ldr r1, [r4, #0x404]
	mov r0, r6
	bl ovl01_21709A4
	mov r0, r5
	ldmia sp!, {r4, r5, r6, pc}
_02171160:
	ldr r0, _0217118C // =gPlayer
	ldr r1, [r6, #0x44]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x44]
	cmp r1, r0
	orrlt r0, r5, #0x10
	orrge r0, r5, #0x20
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	mov r0, r5
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0217118C: .word gPlayer
	arm_func_end ovl01_21710FC

	arm_func_start ovl01_2171190
ovl01_2171190: // _02171190
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r2, [r6, #0x7e8]
	add r1, r6, #0x3b8
	cmp r2, #0xc
	add r4, r1, #0x400
	mov r5, #0
	bne _021711BC
	bl ovl01_2170B68
	mov r0, r5
	ldmia sp!, {r4, r5, r6, pc}
_021711BC:
	ldrh r1, [r4, #6]
	add r1, r1, #1
	strh r1, [r4, #6]
	ldr r1, [r4, #0]
	cmp r1, #0
	ldr r1, [r6, #0x7e8]
	beq _02171290
	cmp r1, #7
	addls pc, pc, r1, lsl #2
	b _02171264
_021711E4: // jump table
	b _02171264 // case 0
	b _02171274 // case 1
	b _02171274 // case 2
	b _02171264 // case 3
	b _02171264 // case 4
	b _02171204 // case 5
	b _02171228 // case 6
	b _0217124C // case 7
_02171204:
	ldrh r1, [r4, #4]
	cmp r1, #1
	bhi _02171274
	ldr r1, [r6, #0x784]
	cmp r1, #0x14
	bne _02171220
	bl ovl01_21708E8
_02171220:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02171228:
	ldrh r1, [r4, #4]
	cmp r1, #2
	bhi _02171274
	ldr r1, [r6, #0x784]
	cmp r1, #0x17
	bne _02171244
	bl ovl01_21708E8
_02171244:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0217124C:
	ldr r1, [r6, #0x784]
	cmp r1, #0x1a
	bne _0217125C
	bl ovl01_21708E8
_0217125C:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02171264:
	mov r0, r6
	bl ovl01_21708E8
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02171274:
	ldrh r0, [r4, #6]
	tst r0, #1
	bne _02171304
	orr r0, r5, #2
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	b _02171304
_02171290:
	cmp r1, #1
	bne _02171304
	ldr r1, _0217130C // =gPlayer
	ldr r2, [r6, #0x44]
	ldr r1, [r1, #0]
	ldr r1, [r1, #0x44]
	cmp r1, r2
	bge _021712CC
	bl ovl01_21701C0
	cmp r0, #0
	bne _021712CC
	orr r0, r5, #0x20
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	b _021712FC
_021712CC:
	ldr r0, _0217130C // =gPlayer
	ldr r1, [r6, #0x44]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x44]
	cmp r1, r0
	bge _021712FC
	mov r0, r6
	bl ovl01_21701C0
	cmp r0, #0
	orrne r0, r5, #0x10
	movne r0, r0, lsl #0x10
	movne r5, r0, lsr #0x10
_021712FC:
	mov r0, #1
	str r0, [r4]
_02171304:
	mov r0, r5
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0217130C: .word gPlayer
	arm_func_end ovl01_2171190

	arm_func_start ovl01_2171310
ovl01_2171310: // _02171310
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r2, [r6, #0x7e8]
	add r1, r6, #0x3b8
	cmp r2, #0xc
	add r4, r1, #0x400
	mov r5, #0
	bne _0217133C
	bl ovl01_2170B68
	mov r0, r5
	ldmia sp!, {r4, r5, r6, pc}
_0217133C:
	ldr r1, [r4, #0]
	cmp r1, #0
	beq _021713B4
	cmp r2, #1
	cmpne r2, #2
	beq _02171378
	cmp r2, #8
	bne _02171368
	ldr r0, [r6, #0x784]
	cmp r0, #0x1d
	bne _02171378
_02171368:
	mov r0, r6
	bl ovl01_21708E8
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02171378:
	cmp r2, #8
	bne _021713A4
	mov r0, r6
	bl ovl01_2172C4C
	ldrh r1, [r4, #4]
	cmp r1, r0
	bhi _021713A4
	mov r0, r6
	bl ovl01_21708E8
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_021713A4:
	orr r0, r5, #0x82
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	b _02171428
_021713B4:
	cmp r2, #1
	bne _02171428
	ldr r1, _02171430 // =gPlayer
	ldr r2, [r6, #0x44]
	ldr r1, [r1, #0]
	ldr r1, [r1, #0x44]
	cmp r1, r2
	bge _021713F0
	bl ovl01_21701C0
	cmp r0, #0
	bne _021713F0
	orr r0, r5, #0x20
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	b _02171420
_021713F0:
	ldr r0, _02171430 // =gPlayer
	ldr r1, [r6, #0x44]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x44]
	cmp r1, r0
	bge _02171420
	mov r0, r6
	bl ovl01_21701C0
	cmp r0, #0
	orrne r0, r5, #0x10
	movne r0, r0, lsl #0x10
	movne r5, r0, lsr #0x10
_02171420:
	mov r0, #1
	str r0, [r4]
_02171428:
	mov r0, r5
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02171430: .word gPlayer
	arm_func_end ovl01_2171310

	arm_func_start ovl01_2171434
ovl01_2171434: // _02171434
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r2, [r5, #0x7e8]
	add r6, r5, #0x3b8
	cmp r2, #0xc
	mov r4, #0
	bne _0217145C
	bl ovl01_2170B68
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
_0217145C:
	ldr r1, [r6, #0x400]
	cmp r1, #0
	beq _021714A8
	cmp r2, #1
	cmpne r2, #2
	beq _02171498
	cmp r2, #9
	bne _02171488
	ldr r0, [r5, #0x784]
	cmp r0, #0x20
	bne _02171498
_02171488:
	mov r0, r5
	bl ovl01_21708E8
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_02171498:
	orr r0, r4, #0x42
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	b _0217151C
_021714A8:
	cmp r2, #1
	bne _0217151C
	ldr r1, _02171524 // =gPlayer
	ldr r2, [r5, #0x44]
	ldr r1, [r1, #0]
	ldr r1, [r1, #0x44]
	cmp r1, r2
	bge _021714E4
	bl ovl01_21701C0
	cmp r0, #0
	bne _021714E4
	orr r0, r4, #0x20
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	b _02171514
_021714E4:
	ldr r0, _02171524 // =gPlayer
	ldr r1, [r5, #0x44]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x44]
	cmp r1, r0
	bge _02171514
	mov r0, r5
	bl ovl01_21701C0
	cmp r0, #0
	orrne r0, r4, #0x10
	movne r0, r0, lsl #0x10
	movne r4, r0, lsr #0x10
_02171514:
	mov r0, #1
	str r0, [r6, #0x400]
_0217151C:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02171524: .word gPlayer
	arm_func_end ovl01_2171434

	arm_func_start ovl01_2171528
ovl01_2171528: // _02171528
	stmdb sp!, {r3, lr}
	ldr r2, [r0, #0x7e8]
	add r1, r0, #0x394
	cmp r2, #0xc
	add r3, r1, #0x400
	mov ip, #0
	bne _02171550
	bl ovl01_2170B68
	mov r0, #0
	ldmia sp!, {r3, pc}
_02171550:
	ldr r1, [r3, #0x24]
	cmp r1, #0
	beq _0217160C
	cmp r2, #1
	beq _02171590
	cmp r2, #0xd
	bne _02171584
	ldr r1, [r0, #0x784]
	cmp r1, #0x25
	bne _02171590
	mov r1, #1
	str r1, [r3, #0x1c]
	str r1, [r3, #0x20]
_02171584:
	bl ovl01_21708E8
	mov r0, #0
	ldmia sp!, {r3, pc}
_02171590:
	ldr r0, [r0, #0x784]
	cmp r0, #0x22
	bne _021715FC
	ldr r0, [r3, #0x28]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02171618
_021715AC: // jump table
	b _021715BC // case 0
	b _021715CC // case 1
	b _021715DC // case 2
	b _021715EC // case 3
_021715BC:
	orr r0, ip, #0x20
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	b _02171618
_021715CC:
	orr r0, ip, #0x40
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	b _02171618
_021715DC:
	orr r0, ip, #0x80
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	b _02171618
_021715EC:
	orr r0, ip, #0x10
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	b _02171618
_021715FC:
	orr r0, ip, #0x41
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	b _02171618
_0217160C:
	cmp r2, #1
	moveq r0, #1
	streq r0, [r3, #0x24]
_02171618:
	mov r0, ip
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_2171528

	arm_func_start ovl01_2171620
ovl01_2171620: // _02171620
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov lr, r0
	add r0, lr, #0x3f8
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [sp, #4]
	add r0, lr, #0x3b8
	rsb r2, r1, #0x10000
	str r2, [sp, #4]
	ldr r1, [lr, #0x7b8]
	add r3, r0, #0x400
	cmp r1, #0
	mov ip, #0
	ldr r0, [lr, #0x7e8]
	beq _0217178C
	cmp r0, #0xa
	cmpne r0, #0xb
	beq _021717BC
	cmp r0, #0xc
	bne _02171778
	ldr r0, [r3, #0x14]
	cmp r0, #0
	beq _021716B4
	ldr r0, [r3, #0xc]
	sub r0, r0, r2
	cmp r0, #0x50000
	blt _021716A4
	orr r0, ip, #0x100
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	b _021717BC
_021716A4:
	orr r0, ip, #0x40
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	b _021717BC
_021716B4:
	ldr r0, [r3, #4]
	subs r0, r0, #1
	str r0, [r3, #4]
	bmi _021716E0
	ldr r0, _021717C8 // =gPlayer
	add lr, r3, #8
	ldr r0, [r0, #0]
	add r0, r0, #0x44
	ldmia r0, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	b _021716F8
_021716E0:
	cmp r0, #0
	bge _021716F8
	rsblt r0, r0, #0
	cmp r0, #0x78
	movgt r0, #1
	strgt r0, [r3, #0x14]
_021716F8:
	ldr lr, [r3, #8]
	ldr r2, [sp]
	ldr r0, [sp, #4]
	ldr r1, [r3, #0xc]
	subs r2, lr, r2
	rsbmi r2, r2, #0
	sub r1, r1, r0
	cmp r2, #0x8000
	bge _02171730
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r1, #0x8000
	movlt r1, #1
	strlt r1, [r3, #0x14]
_02171730:
	ldr r2, [sp]
	ldr r1, [r3, #8]
	cmp r2, r1
	orrlt r1, ip, #0x10
	orrge r1, ip, #0x20
	mov r1, r1, lsl #0x10
	mov ip, r1, lsr #0x10
	ldr r1, [r3, #0xc]
	cmp r0, r1
	bge _02171768
	orr r0, ip, #0x80
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	b _021717BC
_02171768:
	orr r0, ip, #0x40
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	b _021717BC
_02171778:
	mov r0, lr
	bl ovl01_21708E8
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {pc}
_0217178C:
	cmp r0, #1
	bne _021717AC
	orr r0, ip, #0x100
	mov r0, r0, lsl #0x10
	mov r1, #1
	str r1, [r3]
	mov ip, r0, lsr #0x10
	b _021717BC
_021717AC:
	sub r0, r0, #0xa
	cmp r0, #2
	movls r0, #1
	strls r0, [r3]
_021717BC:
	mov r0, ip
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_021717C8: .word gPlayer
	arm_func_end ovl01_2171620

	arm_func_start ovl01_21717CC
ovl01_21717CC: // _021717CC
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov ip, r0
	add r0, ip, #0x3f8
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r2, [ip, #0x7e8]
	add r1, ip, #0x3b8
	cmp r2, #0xa
	addeq sp, sp, #0xc
	mov r0, #0
	ldmeqia sp!, {pc}
	cmp r2, #0xc
	bne _02171844
	ldr r2, [sp, #4]
	ldr r1, [r1, #0x400]
	sub r1, r2, r1
	cmp r1, #0x50000
	bge _02171830
	orr r0, r0, #0x40
	mov r0, r0, lsl #0x10
	add sp, sp, #0xc
	mov r0, r0, lsr #0x10
	ldmia sp!, {pc}
_02171830:
	orr r0, r0, #0x100
	mov r0, r0, lsl #0x10
	add sp, sp, #0xc
	mov r0, r0, lsr #0x10
	ldmia sp!, {pc}
_02171844:
	mov r0, ip
	bl ovl01_21708E8
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end ovl01_21717CC

	arm_func_start ovl01_2171858
ovl01_2171858: // _02171858
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x7e8]
	cmp r1, #0x10
	beq _0217186C
	bl ovl01_21708E8
_0217186C:
	mov r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_2171858

	arm_func_start ovl01_2171874
ovl01_2171874: // _02171874
	mov r0, #0
	bx lr
	arm_func_end ovl01_2171874

	arm_func_start ovl01_217187C
ovl01_217187C: // _0217187C
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	add r0, r4, #0x300
	ldrh r0, [r0, #0x80]
	ands r1, r0, #0x20
	bne _0217189C
	tst r0, #0x10
	beq _02171950
_0217189C:
	cmp r1, #0
	beq _021718D4
	ldr r0, [r4, #0x98]
	cmp r0, #0
	ble _021718C4
	bl ovl01_216CDD8
	ldr r1, [r4, #0x98]
	sub r0, r1, r0
	str r0, [r4, #0x98]
	b _021718D4
_021718C4:
	bl ovl01_216CD84
	ldr r1, [r4, #0x98]
	sub r0, r1, r0
	str r0, [r4, #0x98]
_021718D4:
	add r0, r4, #0x300
	ldrh r0, [r0, #0x80]
	tst r0, #0x10
	beq _02171914
	ldr r0, [r4, #0x98]
	cmp r0, #0
	bge _02171904
	bl ovl01_216CDD8
	ldr r1, [r4, #0x98]
	add r0, r1, r0
	str r0, [r4, #0x98]
	b _02171914
_02171904:
	bl ovl01_216CD84
	ldr r1, [r4, #0x98]
	add r0, r1, r0
	str r0, [r4, #0x98]
_02171914:
	ldr r5, [r4, #0x98]
	bl ovl01_216CE04
	rsb r0, r0, #0
	cmp r5, r0
	bge _02171934
	bl ovl01_216CE04
	rsb r5, r0, #0
	b _02171948
_02171934:
	bl ovl01_216CE04
	cmp r5, r0
	ble _02171948
	bl ovl01_216CE04
	mov r5, r0
_02171948:
	str r5, [r4, #0x98]
	ldmia sp!, {r3, r4, r5, pc}
_02171950:
	ldr r0, [r4, #0x98]
	cmp r0, #0
	bge _0217198C
	bl ovl01_216CDAC
	ldr r1, [r4, #0x98]
	rsb r1, r1, #0
	cmp r0, r1
	movge r0, #0
	strge r0, [r4, #0x98]
	ldmgeia sp!, {r3, r4, r5, pc}
	bl ovl01_216CDAC
	ldr r1, [r4, #0x98]
	add r0, r1, r0
	str r0, [r4, #0x98]
	ldmia sp!, {r3, r4, r5, pc}
_0217198C:
	ldmleia sp!, {r3, r4, r5, pc}
	bl ovl01_216CDAC
	ldr r1, [r4, #0x98]
	cmp r0, r1
	movge r0, #0
	strge r0, [r4, #0x98]
	ldmgeia sp!, {r3, r4, r5, pc}
	bl ovl01_216CDAC
	ldr r1, [r4, #0x98]
	sub r0, r1, r0
	str r0, [r4, #0x98]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_217187C

	arm_func_start ovl01_21719BC
ovl01_21719BC: // _021719BC
	add r1, r0, #0x300
	ldrh r1, [r1, #0x80]
	tst r1, #0x30
	beq _02171A2C
	tst r1, #0x20
	beq _021719E4
	ldr r1, [r0, #0x98]
	sub r1, r1, #0x33
	sub r1, r1, #0x300
	str r1, [r0, #0x98]
_021719E4:
	add r1, r0, #0x300
	ldrh r1, [r1, #0x80]
	tst r1, #0x10
	beq _02171A04
	ldr r1, [r0, #0x98]
	add r1, r1, #0x33
	add r1, r1, #0x300
	str r1, [r0, #0x98]
_02171A04:
	mov r1, #0x4000
	ldr r2, [r0, #0x98]
	rsb r1, r1, #0
	cmp r2, r1
	movlt r2, r1
	blt _02171A24
	cmp r2, #0x4000
	movgt r2, #0x4000
_02171A24:
	str r2, [r0, #0x98]
	bx lr
_02171A2C:
	ldr r3, [r0, #0x98]
	cmp r3, #0
	bge _02171A60
	ldr r1, _02171A80 // =0x000004CC
	rsb r2, r3, #0
	cmp r2, r1
	movle r1, #0
	strle r1, [r0, #0x98]
	bxle lr
	add r1, r3, #0xcc
	add r1, r1, #0x400
	str r1, [r0, #0x98]
	bx lr
_02171A60:
	bxle lr
	ldr r1, _02171A80 // =0x000004CC
	cmp r3, r1
	subgt r1, r3, r1
	strgt r1, [r0, #0x98]
	movle r1, #0
	strle r1, [r0, #0x98]
	bx lr
	.align 2, 0
_02171A80: .word 0x000004CC
	arm_func_end ovl01_21719BC

	arm_func_start ovl01_2171A84
ovl01_2171A84: // _02171A84
	add r1, r0, #0x300
	ldrh r1, [r1, #0x80]
	tst r1, #0x30
	beq _02171B04
	tst r1, #0x20
	beq _02171AB4
	ldr r1, [r0, #0x98]
	cmp r1, #0
	movgt r1, #0
	strgt r1, [r0, #0x98]
	suble r1, r1, #0x800
	strle r1, [r0, #0x98]
_02171AB4:
	add r1, r0, #0x300
	ldrh r1, [r1, #0x80]
	tst r1, #0x10
	beq _02171ADC
	ldr r1, [r0, #0x98]
	cmp r1, #0
	movlt r1, #0
	strlt r1, [r0, #0x98]
	addge r1, r1, #0x800
	strge r1, [r0, #0x98]
_02171ADC:
	mov r1, #0x8000
	ldr r2, [r0, #0x98]
	rsb r1, r1, #0
	cmp r2, r1
	movlt r2, r1
	blt _02171AFC
	cmp r2, #0x8000
	movgt r2, #0x8000
_02171AFC:
	str r2, [r0, #0x98]
	b _02171B0C
_02171B04:
	mov r1, #0
	str r1, [r0, #0x98]
_02171B0C:
	add r1, r0, #0x300
	ldrh r1, [r1, #0x80]
	tst r1, #0xc0
	beq _02171B8C
	tst r1, #0x40
	beq _02171B3C
	ldr r1, [r0, #0x9c]
	cmp r1, #0
	movgt r1, #0
	strgt r1, [r0, #0x9c]
	suble r1, r1, #0x800
	strle r1, [r0, #0x9c]
_02171B3C:
	add r1, r0, #0x300
	ldrh r1, [r1, #0x80]
	tst r1, #0x80
	beq _02171B64
	ldr r1, [r0, #0x9c]
	cmp r1, #0
	movlt r1, #0
	strlt r1, [r0, #0x9c]
	addge r1, r1, #0x800
	strge r1, [r0, #0x9c]
_02171B64:
	mov r1, #0x8000
	ldr r2, [r0, #0x9c]
	rsb r1, r1, #0
	cmp r2, r1
	movlt r2, r1
	blt _02171B84
	cmp r2, #0x8000
	movgt r2, #0x8000
_02171B84:
	str r2, [r0, #0x9c]
	bx lr
_02171B8C:
	mov r1, #0
	str r1, [r0, #0x9c]
	bx lr
	arm_func_end ovl01_2171A84

	arm_func_start ovl01_2171B98
ovl01_2171B98: // _02171B98
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x1c]
	tst r1, #1
	beq _02171BC4
	add r1, r0, #0x300
	ldrh r1, [r1, #0x84]
	tst r1, #1
	beq _02171BC4
	bl ovl01_2171ECC
	mov r0, #1
	ldmia sp!, {r3, pc}
_02171BC4:
	mov r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_2171B98

	arm_func_start ovl01_2171BCC
ovl01_2171BCC: // _02171BCC
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x1c]
	tst r1, #1
	bne _02171BF4
	ldr r1, [r0, #0x7e8]
	cmp r1, #4
	beq _02171BF4
	bl ovl01_2171EE4
	mov r0, #1
	ldmia sp!, {r3, pc}
_02171BF4:
	mov r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_2171BCC

	arm_func_start ovl01_2171BFC
ovl01_2171BFC: // _02171BFC
	stmdb sp!, {r3, lr}
	ldr r3, [r0, #0x1c]
	tst r3, #1
	beq _02171C68
	ldr r2, [r0, #0x37c]
	ldr r1, [r0, #0x114]
	ldr r2, [r2, #0x384]
	cmp r2, r1
	bne _02171C68
	ldr r1, [r0, #0x48]
	cmp r1, #0x300000
	bge _02171C68
	add r1, r0, #0x300
	ldrh r2, [r1, #0x84]
	tst r2, #1
	beq _02171C68
	ldrh r1, [r1, #0x80]
	tst r1, #0x80
	beq _02171C68
	orr r1, r3, #0x20
	str r1, [r0, #0x1c]
	ldr r1, [r0, #0x48]
	add r1, r1, #0x20000
	str r1, [r0, #0x48]
	bl ovl01_2171EE4
	mov r0, #1
	ldmia sp!, {r3, pc}
_02171C68:
	mov r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_2171BFC

	arm_func_start ovl01_2171C70
ovl01_2171C70: // _02171C70
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x1c]
	tst r1, #1
	beq _02171CC8
	add r1, r0, #0x300
	ldrh r2, [r1, #0x84]
	tst r2, #2
	beq _02171CC8
	ldrh r2, [r1, #0x80]
	and r1, r2, #0x82
	cmp r1, #0x82
	bne _02171CA8
	bl ovl01_2171F60
	b _02171CC0
_02171CA8:
	and r1, r2, #0x42
	cmp r1, #0x42
	bne _02171CBC
	bl ovl01_2171F84
	b _02171CC0
_02171CBC:
	bl ovl01_2171F10
_02171CC0:
	mov r0, #1
	ldmia sp!, {r3, pc}
_02171CC8:
	mov r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_2171C70

	arm_func_start ovl01_2171CD0
ovl01_2171CD0: // _02171CD0
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x1c]
	tst r1, #1
	beq _02171D08
	add r1, r0, #0x300
	ldrh r2, [r1, #0x84]
	tst r2, #1
	beq _02171D08
	ldrh r1, [r1, #0x80]
	tst r1, #0x40
	beq _02171D08
	bl ovl01_2172080
	mov r0, #1
	ldmia sp!, {r3, pc}
_02171D08:
	mov r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_2171CD0

	arm_func_start ovl01_2171D10
ovl01_2171D10: // _02171D10
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x1c]
	tst r1, #1
	beq _02171D3C
	add r1, r0, #0x300
	ldrh r1, [r1, #0x84]
	tst r1, #4
	beq _02171D3C
	bl ovl01_2172134
	mov r0, #1
	ldmia sp!, {r3, pc}
_02171D3C:
	mov r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_2171D10

	arm_func_start ovl01_2171D44
ovl01_2171D44: // _02171D44
	mov r2, #0
	ldr r1, _02171D58 // =ovl01_21721A0
	str r2, [r0, #0x7e8]
	str r1, [r0, #0x7e4]
	bx lr
	.align 2, 0
_02171D58: .word ovl01_21721A0
	arm_func_end ovl01_2171D44

	arm_func_start ovl01_2171D5C
ovl01_2171D5C: // _02171D5C
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	mov r0, #1
	str r0, [r4, #0x7e8]
	ldr r1, [r4, #0x1c]
	add r0, r4, #0x300
	orr r1, r1, #0x80
	bic r1, r1, #0x10
	str r1, [r4, #0x1c]
	ldrsh r0, [r0, #0xd2]
	cmp r0, #0
	bgt _02171D9C
	ldr r0, [r4, #0x37c]
	bl ovl01_216CB7C
	add r1, r4, #0x300
	strh r0, [r1, #0xd2]
_02171D9C:
	ldr r0, [r4, #0x37c]
	ldr r0, [r0, #0x380]
	ldr r0, [r0, #0x790]
	cmp r0, #0
	mov r0, r4
	beq _02171DBC
	bl ovl01_216FF98
	b _02171DC0
_02171DBC:
	bl ovl01_216FF88
_02171DC0:
	mov r0, r4
	bl ovl01_2170130
	mov r0, r4
	bl ovl01_216FFA8
	ldr r1, [r4, #0x1c]
	mov r0, #1
	bic r1, r1, #0x200
	str r1, [r4, #0x1c]
	bl BossArena__GetCamera
	mov r1, #0xc8000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, #1
	bl BossArena__GetCamera
	mov r5, r0
	ldr r0, _02171E80 // =_0217AFB0
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r1, r0
	mov r0, r5
	ldr r2, [r1, #0x398]
	mov r1, #0
	add r2, r2, #0x190000
	mov r3, r1
	bl BossArena__SetTracker1TargetPos
	mov r0, #2
	bl BossArena__GetCamera
	mov r1, #0xc8000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, #2
	bl BossArena__GetCamera
	mov r5, r0
	ldr r0, _02171E80 // =_0217AFB0
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r1, r0
	mov r0, r5
	ldr r2, [r1, #0x398]
	mov r1, #0
	add r2, r2, #0x50000
	mov r3, r1
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0
	mov r2, #1
	bl ovl01_21701CC
	ldr r0, _02171E84 // =ovl01_21721B8
	str r0, [r4, #0x7e4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02171E80: .word _0217AFB0
_02171E84: .word ovl01_21721B8
	arm_func_end ovl01_2171D5C

	arm_func_start ovl01_2171E88
ovl01_2171E88: // _02171E88
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r3, #2
	mov r1, #7
	mov r2, #0
	str r3, [r4, #0x7e8]
	bl ovl01_21701CC
	ldr r0, _02171EB0 // =ovl01_21722A4
	str r0, [r4, #0x7e4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02171EB0: .word ovl01_21722A4
	arm_func_end ovl01_2171E88

	arm_func_start ovl01_2171EB4
ovl01_2171EB4: // _02171EB4
	mov r2, #3
	ldr r1, _02171EC8 // =ovl01_2172358
	str r2, [r0, #0x7e8]
	str r1, [r0, #0x7e4]
	bx lr
	.align 2, 0
_02171EC8: .word ovl01_2172358
	arm_func_end ovl01_2171EB4

	arm_func_start ovl01_2171ECC
ovl01_2171ECC: // _02171ECC
	mov r2, #4
	ldr r1, _02171EE0 // =ovl01_2172468
	str r2, [r0, #0x7e8]
	str r1, [r0, #0x7e4]
	bx lr
	.align 2, 0
_02171EE0: .word ovl01_2172468
	arm_func_end ovl01_2171ECC

	arm_func_start ovl01_2171EE4
ovl01_2171EE4: // _02171EE4
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r3, #4
	mov r1, #0xf
	mov r2, #0
	str r3, [r4, #0x7e8]
	bl ovl01_21701CC
	ldr r0, _02171F0C // =ovl01_2172468
	str r0, [r4, #0x7e4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02171F0C: .word ovl01_2172468
	arm_func_end ovl01_2171EE4

	arm_func_start ovl01_2171F10
ovl01_2171F10: // _02171F10
	mov r1, #5
	str r1, [r0, #0x7e8]
	mov r2, #0
	ldr r1, _02171F2C // =ovl01_21726AC
	str r2, [r0, #0x98]
	str r1, [r0, #0x7e4]
	bx lr
	.align 2, 0
_02171F2C: .word ovl01_21726AC
	arm_func_end ovl01_2171F10

	arm_func_start ovl01_2171F30
ovl01_2171F30: // _02171F30
	mov r2, #6
	ldr r1, _02171F44 // =ovl01_217291C
	str r2, [r0, #0x7e8]
	str r1, [r0, #0x7e4]
	bx lr
	.align 2, 0
_02171F44: .word ovl01_217291C
	arm_func_end ovl01_2171F30

	arm_func_start ovl01_2171F48
ovl01_2171F48: // _02171F48
	mov r2, #7
	ldr r1, _02171F5C // =ovl01_2172AB4
	str r2, [r0, #0x7e8]
	str r1, [r0, #0x7e4]
	bx lr
	.align 2, 0
_02171F5C: .word ovl01_2172AB4
	arm_func_end ovl01_2171F48

	arm_func_start ovl01_2171F60
ovl01_2171F60: // _02171F60
	mov r1, #8
	str r1, [r0, #0x7e8]
	mov r2, #0
	ldr r1, _02171F80 // =ovl01_2172C54
	str r2, [r0, #0x98]
	str r1, [r0, #0x7e4]
	str r2, [r0, #0x28]
	bx lr
	.align 2, 0
_02171F80: .word ovl01_2172C54
	arm_func_end ovl01_2171F60

	arm_func_start ovl01_2171F84
ovl01_2171F84: // _02171F84
	mov r1, #9
	str r1, [r0, #0x7e8]
	mov r2, #0
	ldr r1, _02171FA0 // =ovl01_2172DE0
	str r2, [r0, #0x98]
	str r1, [r0, #0x7e4]
	bx lr
	.align 2, 0
_02171FA0: .word ovl01_2172DE0
	arm_func_end ovl01_2171F84

	arm_func_start ovl01_2171FA4
ovl01_2171FA4: // _02171FA4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl01_2170120
	mov r0, #0xa
	str r0, [r4, #0x7e8]
	mov r0, #0
	ldr r1, _02171FE4 // =ovl01_2172F04
	str r0, [r4, #0x98]
	mov r0, r4
	str r1, [r4, #0x7e4]
	bl ovl01_216FF88
	mov r0, r4
	bl ovl01_216FFA8
	mov r0, r4
	bl ovl01_2170178
	ldmia sp!, {r4, pc}
	.align 2, 0
_02171FE4: .word ovl01_2172F04
	arm_func_end ovl01_2171FA4

	arm_func_start ovl01_2171FE8
ovl01_2171FE8: // _02171FE8
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xb
	str r1, [r4, #0x7e8]
	ldr r2, [r4, #0x1c]
	mov r1, #0
	orr r2, r2, #0x80
	bic r2, r2, #0x200
	str r2, [r4, #0x1c]
	str r1, [r4, #0x98]
	bl ovl01_216FF88
	mov r0, r4
	bl ovl01_216FFA8
	mov r0, r4
	bl ovl01_2170178
	ldr r0, _02172030 // =ovl01_2172F94
	str r0, [r4, #0x7e4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02172030: .word ovl01_2172F94
	arm_func_end ovl01_2171FE8

	arm_func_start ovl01_2172034
ovl01_2172034: // _02172034
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xc
	str r1, [r4, #0x7e8]
	ldr r1, [r4, #0x1c]
	bic r1, r1, #0x80
	orr r1, r1, #0x210
	str r1, [r4, #0x1c]
	bl ovl01_216FF88
	mov r0, r4
	bl ovl01_2170090
	mov r0, r4
	bl ovl01_2170120
	mov r1, #0
	ldr r0, _0217207C // =ovl01_2173044
	str r1, [r4, #0x2c]
	str r0, [r4, #0x7e4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217207C: .word ovl01_2173044
	arm_func_end ovl01_2172034

	arm_func_start ovl01_2172080
ovl01_2172080: // _02172080
	mov r2, #0xd
	ldr r1, _02172094 // =ovl01_2173330
	str r2, [r0, #0x7e8]
	str r1, [r0, #0x7e4]
	bx lr
	.align 2, 0
_02172094: .word ovl01_2173330
	arm_func_end ovl01_2172080

	arm_func_start ovl01_2172098
ovl01_2172098: // _02172098
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r3, #0xe
	ldr r2, _021720E4 // =ovl01_21737C8
	str r3, [r4, #0x7e8]
	str r2, [r4, #0x7e4]
	mov r2, #0
	str r2, [r4, #0x98]
	str r2, [r4, #0x9c]
	str r1, [r4, #0x2c]
	bl ovl01_216FF88
	mov r0, r4
	bl ovl01_216FFA8
	mov r0, r4
	bl ovl01_2170120
	ldr r0, [r4, #0x1c]
	bic r0, r0, #0x200
	str r0, [r4, #0x1c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021720E4: .word ovl01_21737C8
	arm_func_end ovl01_2172098

	arm_func_start ovl01_21720E8
ovl01_21720E8: // _021720E8
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r2, #0xf
	ldr r1, _02172130 // =ovl01_2173830
	str r2, [r4, #0x7e8]
	str r1, [r4, #0x7e4]
	mov r1, #0
	str r1, [r4, #0x98]
	str r1, [r4, #0x9c]
	bl ovl01_216FF88
	mov r0, r4
	bl ovl01_216FFA8
	mov r0, r4
	bl ovl01_2170120
	ldr r0, [r4, #0x1c]
	bic r0, r0, #0x200
	str r0, [r4, #0x1c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02172130: .word ovl01_2173830
	arm_func_end ovl01_21720E8

	arm_func_start ovl01_2172134
ovl01_2172134: // _02172134
	mov r2, #0x10
	ldr r1, _02172154 // =ovl01_21738DC
	str r2, [r0, #0x7e8]
	str r1, [r0, #0x7e4]
	mov r1, #0
	str r1, [r0, #0x98]
	str r1, [r0, #0x9c]
	bx lr
	.align 2, 0
_02172154: .word ovl01_21738DC
	arm_func_end ovl01_2172134

	arm_func_start ovl01_2172158
ovl01_2172158: // _02172158
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r2, #0x11
	ldr r1, _0217219C // =ovl01_21739C0
	str r2, [r4, #0x7e8]
	str r1, [r4, #0x7e4]
	mov r1, #0
	str r1, [r4, #0x98]
	str r1, [r4, #0x9c]
	str r1, [r4, #0x720]
	ldr r1, [r4, #0x1c]
	bic r1, r1, #0x80
	str r1, [r4, #0x1c]
	bl ovl01_216FF88
	mov r0, r4
	bl ovl01_216FFA8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217219C: .word ovl01_21739C0
	arm_func_end ovl01_2172158

	arm_func_start ovl01_21721A0
ovl01_21721A0: // _021721A0
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x1c]
	tst r1, #1
	ldmeqia sp!, {r3, pc}
	bl ovl01_2171D5C
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_21721A0

	arm_func_start ovl01_21721B8
ovl01_21721B8: // _021721B8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl01_217187C
	mov r0, r4
	bl ovl01_2171BCC
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2171BFC
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2171D10
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2171CD0
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2171B98
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2171C70
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x300
	ldrh r1, [r0, #0x84]
	tst r1, #0x100
	beq _02172240
	mov r0, r4
	bl ovl01_2171FA4
	ldmia sp!, {r4, pc}
_02172240:
	ldrh r0, [r0, #0x80]
	tst r0, #0x30
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_21701C0
	cmp r0, #0
	beq _0217226C
	add r0, r4, #0x300
	ldrh r0, [r0, #0x80]
	tst r0, #0x10
	bne _0217228C
_0217226C:
	mov r0, r4
	bl ovl01_21701C0
	cmp r0, #0
	bne _02172298
	add r0, r4, #0x300
	ldrh r0, [r0, #0x80]
	tst r0, #0x20
	beq _02172298
_0217228C:
	mov r0, r4
	bl ovl01_2171E88
	ldmia sp!, {r4, pc}
_02172298:
	mov r0, r4
	bl ovl01_2171EB4
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_21721B8

	arm_func_start ovl01_21722A4
ovl01_21722A4: // _021722A4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl01_217187C
	mov r0, r4
	bl ovl01_2171BCC
	cmp r0, #0
	beq _021722D0
	ldr r0, [r4, #0x20]
	eor r0, r0, #1
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}
_021722D0:
	mov r0, r4
	bl ovl01_2171CD0
	cmp r0, #0
	beq _021722F0
	ldr r0, [r4, #0x20]
	eor r0, r0, #1
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}
_021722F0:
	mov r0, r4
	bl ovl01_2171B98
	cmp r0, #0
	beq _02172310
	ldr r0, [r4, #0x20]
	eor r0, r0, #1
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}
_02172310:
	mov r0, r4
	bl ovl01_2171C70
	cmp r0, #0
	beq _02172330
	ldr r0, [r4, #0x20]
	eor r0, r0, #1
	str r0, [r4, #0x20]
	ldmia sp!, {r4, pc}
_02172330:
	mov r0, r4
	bl ovl01_2170234
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x20]
	mov r0, r4
	eor r1, r1, #1
	str r1, [r4, #0x20]
	bl ovl01_2171D5C
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_21722A4

	arm_func_start ovl01_2172358
ovl01_2172358: // _02172358
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl01_217187C
	mov r0, r4
	bl ovl01_2171BCC
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2171BFC
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2171CD0
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2171B98
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2171C70
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x300
	ldrh r0, [r0, #0x80]
	tst r0, #0x30
	beq _0217245C
	tst r0, #0x20
	beq _021723DC
	mov r0, r4
	bl ovl01_21701C0
	cmp r0, #0
	beq _021723FC
_021723DC:
	add r0, r4, #0x300
	ldrh r0, [r0, #0x80]
	tst r0, #0x10
	beq _02172408
	mov r0, r4
	bl ovl01_21701C0
	cmp r0, #0
	beq _02172408
_021723FC:
	mov r0, r4
	bl ovl01_21722A4
	ldmia sp!, {r4, pc}
_02172408:
	ldr r0, [r4, #0x784]
	cmp r0, #4
	beq _02172438
	cmp r0, #5
	ldmeqia sp!, {r4, pc}
	cmp r0, #6
	beq _02172438
	mov r0, r4
	mov r1, #4
	mov r2, #1
	bl ovl01_21701CC
	ldmia sp!, {r4, pc}
_02172438:
	mov r0, r4
	bl ovl01_2170234
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #5
	mov r2, #1
	bl ovl01_21701CC
	ldmia sp!, {r4, pc}
_0217245C:
	mov r0, r4
	bl ovl01_2171D5C
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2172358

	arm_func_start ovl01_2172468
ovl01_2172468: // _02172468
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl ovl01_21719BC
	ldr r0, [r4, #0x784]
	sub r0, r0, #0xd
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _021724A0
_0217248C: // jump table
	b _021724B8 // case 0
	b _02172540 // case 1
	b _021725C8 // case 2
	b _021725F4 // case 3
	b _02172664 // case 4
_021724A0:
	mov r0, r4
	mov r1, #0xd
	mov r2, #0
	bl ovl01_21701CC
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_021724B8:
	mov r1, #0
	mov r0, r4
	str r1, [r4, #0x98]
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0xe
	mov r2, #1
	bl ovl01_21701CC
	mov r3, #0
	str r3, [r4, #0x28]
	str r3, [r4, #0x2c]
	sub r0, r3, #0x8000
	str r0, [r4, #0x9c]
	ldr r2, [r4, #0x1c]
	mov r0, #0xb1
	orr r2, r2, #0x10
	str r2, [r4, #0x1c]
	str r3, [sp]
	sub r1, r0, #0xb2
	str r0, [sp, #4]
	ldr r0, [r4, #0x78c]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r4, #0x78c]
	add r1, r4, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02172540:
	ldr r0, [r4, #0x28]
	cmp r0, #0
	bne _02172580
	add r0, r4, #0x300
	ldrh r0, [r0, #0x80]
	tst r0, #1
	beq _02172580
	ldr r1, [r4, #0x2c]
	add r0, r1, #1
	str r0, [r4, #0x2c]
	cmp r1, #0x14
	bge _021725A0
	mov r0, #0x8000
	rsb r0, r0, #0
	str r0, [r4, #0x9c]
	b _021725A0
_02172580:
	mov r0, #0x1000
	ldr r1, [r4, #0x9c]
	rsb r0, r0, #0
	cmp r1, r0
	addlt r0, r1, #0xcc
	strlt r0, [r4, #0x9c]
	mov r0, #1
	str r0, [r4, #0x28]
_021725A0:
	ldr r0, [r4, #0x9c]
	cmp r0, #0
	addlt sp, sp, #8
	ldmltia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0xf
	mov r2, #0
	bl ovl01_21701CC
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_021725C8:
	mov r0, r4
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0x10
	mov r2, #0
	bl ovl01_21701CC
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_021725F4:
	ldr r0, [r4, #0x1c]
	tst r0, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r2, #0
	mov r0, r4
	str r2, [r4, #0x24]
	mov r1, #0x11
	bl ovl01_21701CC
	ldr r2, [r4, #0x1c]
	mov r0, #0xb4
	bic r2, r2, #0x10
	str r2, [r4, #0x1c]
	mov r2, #0
	str r2, [sp]
	sub r1, r0, #0xb5
	str r0, [sp, #4]
	ldr r0, [r4, #0x78c]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r4, #0x78c]
	add r1, r4, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02172664:
	ldr r2, _021726A8 // =0x00000111
	mov r3, #0
	mov r0, #0x2000
	mov r1, #0x1800
	str r3, [r4, #0x98]
	bl ShakeScreenEx
	mov r0, r4
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_216FF98
	mov r0, r4
	bl ovl01_2171D5C
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021726A8: .word 0x00000111
	arm_func_end ovl01_2172468

	arm_func_start ovl01_21726AC
ovl01_21726AC: // _021726AC
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x784]
	cmp r1, #0x12
	beq _02172708
	cmp r1, #0x13
	beq _0217276C
	cmp r1, #0x14
	beq _021728FC
	mov r1, #0x12
	mov r2, #0
	bl ovl01_21701CC
	ldr r0, [r4, #0x37c]
	bl ovl01_216CA0C
	mov r1, r0
	mov r0, r4
	bl ovl01_2170220
	mov r0, #0
	str r0, [r4, #0x28]
	add sp, sp, #8
	str r0, [r4, #0x24]
	ldmia sp!, {r3, r4, r5, pc}
_02172708:
	add r0, r4, #0x300
	ldrh r0, [r0, #0x84]
	tst r0, #2
	movne r0, #1
	strne r0, [r4, #0x28]
	mov r0, r4
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	mov r1, #0x3000
	bl ovl01_21702C4
	mov r0, r4
	mov r1, #0x13
	mov r2, #0
	bl ovl01_21701CC
	mov r0, r4
	mov r1, #0x3000
	bl ovl01_2170220
	add r0, r4, #0x700
	mov r1, #0
	strh r1, [r0, #0x90]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_0217276C:
	add r0, r4, #0x700
	ldrh r2, [r0, #0x90]
	add r1, r2, #1
	strh r1, [r0, #0x90]
	cmp r2, #5
	bne _021727BC
	mov r1, #0
	mov r0, #0xa9
	str r1, [sp]
	sub r1, r0, #0xaa
	str r0, [sp, #4]
	ldr r0, [r4, #0x788]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r4, #0x788]
	add r1, r4, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
_021727BC:
	mov r0, r4
	bl ovl01_2170228
	mov r5, r0
	cmp r5, #0x1e000
	ble _021727E4
	cmp r5, #0x32000
	bge _021727E4
	mov r0, r4
	bl ovl01_216FFB8
	b _021727EC
_021727E4:
	mov r0, r4
	bl ovl01_216FFA8
_021727EC:
	cmp r5, #0x1e000
	ble _02172824
	ldr r0, [r4, #0x24]
	cmp r0, #0
	bne _0217288C
	mov r0, r4
	bl ovl01_21701C0
	cmp r0, #0
	mov r0, #0x5000
	rsbne r0, r0, #0
	str r0, [r4, #0x98]
	mov r0, #1
	str r0, [r4, #0x24]
	b _0217288C
_02172824:
	ldr r0, [r4, #0x98]
	cmp r0, #0
	bge _02172860
	bl ovl01_216CDAC
	ldr r1, [r4, #0x98]
	rsb r1, r1, #0
	cmp r0, r1
	movge r0, #0
	strge r0, [r4, #0x98]
	bge _0217288C
	bl ovl01_216CDAC
	ldr r1, [r4, #0x98]
	add r0, r1, r0
	str r0, [r4, #0x98]
	b _0217288C
_02172860:
	ble _0217288C
	bl ovl01_216CDAC
	ldr r1, [r4, #0x98]
	cmp r0, r1
	movge r0, #0
	strge r0, [r4, #0x98]
	bge _0217288C
	bl ovl01_216CDAC
	ldr r1, [r4, #0x98]
	sub r0, r1, r0
	str r0, [r4, #0x98]
_0217288C:
	add r0, r4, #0x300
	ldrh r0, [r0, #0x84]
	tst r0, #2
	movne r0, #1
	strne r0, [r4, #0x28]
	mov r0, r4
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl ovl01_216FFA8
	mov r2, #0
	str r2, [r4, #0x98]
	ldr r0, [r4, #0x28]
	cmp r0, #0
	mov r0, r4
	beq _021728E0
	bl ovl01_2171F30
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_021728E0:
	mov r1, #0x14
	bl ovl01_21701CC
	mov r0, r4
	mov r1, #0x3000
	bl ovl01_2170220
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_021728FC:
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl ovl01_2171D5C
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_21726AC

	arm_func_start ovl01_217291C
ovl01_217291C: // _0217291C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x784]
	cmp r1, #0x15
	beq _02172974
	cmp r1, #0x16
	beq _02172A00
	cmp r1, #0x17
	beq _02172A94
	mov r1, #0x15
	mov r2, #0
	bl ovl01_21701CC
	ldr r0, [r4, #0x37c]
	bl ovl01_216CA68
	mov r1, r0
	mov r0, r4
	bl ovl01_2170220
	mov r0, #0
	add sp, sp, #8
	str r0, [r4, #0x28]
	ldmia sp!, {r4, pc}
_02172974:
	add r0, r4, #0x300
	ldrh r0, [r0, #0x84]
	tst r0, #2
	movne r0, #1
	strne r0, [r4, #0x28]
	mov r0, r4
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_217033C
	mov r0, r4
	mov r1, #0x16
	mov r2, #0
	bl ovl01_21701CC
	mov r0, r4
	mov r1, #0x3000
	bl ovl01_2170220
	mov r0, #0
	str r0, [sp]
	mov r0, #0xaa
	sub r1, r0, #0xab
	str r0, [sp, #4]
	ldr r0, [r4, #0x788]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r4, #0x788]
	add r1, r4, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02172A00:
	bl ovl01_2170228
	cmp r0, #0x10000
	ble _02172A20
	cmp r0, #0x1c000
	bge _02172A20
	mov r0, r4
	bl ovl01_2170000
	b _02172A34
_02172A20:
	mov r0, r4
	bl ovl01_216FFA8
	mov r0, r4
	mov r1, #0x3000
	bl ovl01_2170220
_02172A34:
	add r0, r4, #0x300
	ldrh r0, [r0, #0x84]
	tst r0, #2
	movne r0, #1
	strne r0, [r4, #0x28]
	mov r0, r4
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_216FFA8
	ldr r0, [r4, #0x28]
	cmp r0, #0
	mov r0, r4
	beq _02172A80
	bl ovl01_2171F48
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02172A80:
	mov r1, #0x17
	mov r2, #0
	bl ovl01_21701CC
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02172A94:
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2171D5C
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_217291C

	arm_func_start ovl01_2172AB4
ovl01_2172AB4: // _02172AB4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x784]
	cmp r1, #0x18
	beq _02172B20
	cmp r1, #0x19
	beq _02172B6C
	cmp r1, #0x1a
	beq _02172C2C
	mov r1, #0x18
	mov r2, #0
	bl ovl01_21701CC
	ldr r0, [r4, #0x37c]
	bl ovl01_216CAC4
	mov r1, r0
	mov r0, r4
	bl ovl01_2170220
	mov r0, r4
	bl ovl01_21701C0
	cmp r0, #0
	mov r0, #0x1000
	rsbne r0, r0, #0
	strne r0, [r4, #0x98]
	add sp, sp, #8
	streq r0, [r4, #0x98]
	ldmia sp!, {r4, pc}
_02172B20:
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0x3000
	bl ovl01_2170300
	mov r0, r4
	mov r1, #0x19
	mov r2, #0
	bl ovl01_21701CC
	mov r0, r4
	mov r1, #0x3000
	bl ovl01_2170220
	add r0, r4, #0x700
	mov r1, #0
	strh r1, [r0, #0x90]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02172B6C:
	add r0, r4, #0x700
	ldrh r2, [r0, #0x90]
	add r1, r2, #1
	strh r1, [r0, #0x90]
	cmp r2, #0x1e
	bne _02172BBC
	mov r1, #0
	mov r0, #0xab
	str r1, [sp]
	sub r1, r0, #0xac
	str r0, [sp, #4]
	ldr r0, [r4, #0x788]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r4, #0x788]
	add r1, r4, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
_02172BBC:
	mov r0, r4
	bl ovl01_2170228
	cmp r0, #0x68000
	ble _02172BE0
	cmp r0, #0x84000
	bge _02172BE0
	mov r0, r4
	bl ovl01_2170048
	b _02172BE8
_02172BE0:
	mov r0, r4
	bl ovl01_216FFA8
_02172BE8:
	mov r0, r4
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_216FFA8
	mov r2, #0
	mov r0, r4
	mov r1, #0x1a
	str r2, [r4, #0x98]
	bl ovl01_21701CC
	mov r0, r4
	mov r1, #0x3000
	bl ovl01_2170220
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02172C2C:
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2171D5C
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2172AB4

	arm_func_start ovl01_2172C4C
ovl01_2172C4C: // _02172C4C
	ldr r0, [r0, #0x28]
	bx lr
	arm_func_end ovl01_2172C4C

	arm_func_start ovl01_2172C54
ovl01_2172C54: // _02172C54
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x784]
	cmp r1, #0x1b
	beq _02172C90
	cmp r1, #0x1c
	beq _02172CC4
	cmp r1, #0x1d
	beq _02172D78
	mov r1, #0x1b
	mov r2, #0
	bl ovl01_21701CC
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02172C90:
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0x1c
	mov r2, #0
	bl ovl01_21701CC
	ldr r0, [r4, #0x28]
	add sp, sp, #8
	add r0, r0, #1
	str r0, [r4, #0x28]
	ldmia sp!, {r4, pc}
_02172CC4:
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	mov r0, #0xac
	str r1, [sp]
	sub r1, r0, #0xad
	str r0, [sp, #4]
	ldr r0, [r4, #0x788]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r4, #0x788]
	add r1, r4, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	ldr r0, [r4, #0x20]
	ldr r1, [r4, #0x44]
	tst r0, #1
	subne r0, r1, #0x3c000
	addeq r0, r1, #0x3c000
	ldr r1, [r4, #0x48]
	mov r2, #0x2000
	rsbne r2, r2, #0
	sub r1, r1, #0x20000
	bl ovl01_216D648
	add r0, r4, #0x300
	ldrh r0, [r0, #0x80]
	and r0, r0, #0x82
	cmp r0, #0x82
	bne _02172D60
	mov r1, #0
	ldr r0, _02172D98 // =ovl01_2172D9C
	str r1, [r4, #0x2c]
	add sp, sp, #8
	str r0, [r4, #0x7e4]
	ldmia sp!, {r4, pc}
_02172D60:
	mov r0, r4
	mov r1, #0x1d
	mov r2, #0
	bl ovl01_21701CC
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02172D78:
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2171D5C
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02172D98: .word ovl01_2172D9C
	arm_func_end ovl01_2172C54

	arm_func_start ovl01_2172D9C
ovl01_2172D9C: // _02172D9C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0x2c]
	add r1, r2, #1
	str r1, [r4, #0x2c]
	cmp r2, #0xa
	ldmltia sp!, {r4, pc}
	mov r1, #0x1c
	mov r2, #0
	bl ovl01_21701CC
	ldr r1, [r4, #0x28]
	ldr r0, _02172DDC // =ovl01_2172C54
	add r1, r1, #1
	str r1, [r4, #0x28]
	str r0, [r4, #0x7e4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02172DDC: .word ovl01_2172C54
	arm_func_end ovl01_2172D9C

	arm_func_start ovl01_2172DE0
ovl01_2172DE0: // _02172DE0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x784]
	cmp r1, #0x1e
	beq _02172E24
	cmp r1, #0x1f
	beq _02172E4C
	cmp r1, #0x20
	beq _02172EE4
	mov r1, #0x1e
	mov r2, #0
	bl ovl01_21701CC
	mov r0, #0
	add sp, sp, #8
	str r0, [r4, #0x2c]
	ldmia sp!, {r4, pc}
_02172E24:
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0x1f
	mov r2, #0
	bl ovl01_21701CC
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02172E4C:
	ldr r2, [r4, #0x2c]
	add r1, r2, #1
	str r1, [r4, #0x2c]
	cmp r2, #0xf
	bne _02172E64
	bl ovl01_2170370
_02172E64:
	mov r0, r4
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0x20
	mov r2, #0
	bl ovl01_21701CC
	ldr r0, [r4, #0x20]
	ldr r1, [r4, #0x44]
	tst r0, #1
	subne r0, r1, #0x64000
	addeq r0, r1, #0x64000
	ldr r1, [r4, #0x48]
	bl ovl01_216D99C
	mov r2, #0
	mov r0, #0xb6
	str r2, [sp]
	sub r1, r0, #0xb7
	str r0, [sp, #4]
	ldr r0, [r4, #0x788]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r4, #0x788]
	add r1, r4, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02172EE4:
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2171D5C
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2172DE0

	arm_func_start ovl01_2172F04
ovl01_2172F04: // _02172F04
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x784]
	cmp r1, #8
	beq _02172F74
	mov r1, #0x88
	bl ovl01_2170240
	mov r0, r4
	mov r1, #8
	mov r2, #0
	bl ovl01_21701CC
	mov r2, #0
	mov r0, #0xb2
	str r2, [sp]
	sub r1, r0, #0xb3
	str r0, [sp, #4]
	ldr r0, [r4, #0x78c]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r4, #0x78c]
	add r1, r4, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02172F74:
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2172034
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2172F04

	arm_func_start ovl01_2172F94
ovl01_2172F94: // _02172F94
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x784]
	cmp r1, #0xa
	beq _02173024
	bl ovl01_2170258
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0x88
	bl ovl01_2170240
	mov r0, r4
	mov r1, #0xa
	mov r2, #0
	bl ovl01_21701CC
	mov r0, r4
	mov r1, #0x2000
	bl ovl01_2170220
	mov r0, #0
	str r0, [sp]
	mov r0, #0xb3
	sub r1, r0, #0xb4
	str r0, [sp, #4]
	ldr r0, [r4, #0x78c]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r4, #0x78c]
	add r1, r4, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02173024:
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2171D5C
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2172F94

	arm_func_start ovl01_2173044
ovl01_2173044: // _02173044
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl01_2171A84
	add r0, r4, #0x300
	ldrh r0, [r0, #0x84]
	tst r0, #0x100
	bne _02173074
	ldr r1, [r4, #0x2c]
	add r0, r1, #1
	str r0, [r4, #0x2c]
	cmp r1, #0x12c
	ble _02173080
_02173074:
	mov r0, r4
	bl ovl01_2171FE8
	ldmia sp!, {r4, pc}
_02173080:
	ldr r1, [r4, #0x98]
	ldr r2, [r4, #0x9c]
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r2, #0
	ldr r0, _02173170 // =0x00000333
	rsblt r2, r2, #0
	cmp r1, r0
	cmple r2, r0
	bgt _021730B8
	add r0, r4, #0x300
	ldrh r0, [r0, #0x80]
	tst r0, #0xf0
	beq _02173134
_021730B8:
	cmp r1, r2
	ldr r0, [r4, #0x784]
	ble _021730FC
	cmp r0, #0xb
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2170258
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0x2d
	bl ovl01_2170240
	mov r0, r4
	mov r1, #0xb
	mov r2, #1
	bl ovl01_21701CC
	ldmia sp!, {r4, pc}
_021730FC:
	cmp r0, #0xc
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2170258
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0x2d
	bl ovl01_2170240
	mov r0, r4
	mov r1, #0xc
	mov r2, #1
	bl ovl01_21701CC
	ldmia sp!, {r4, pc}
_02173134:
	ldr r0, [r4, #0x784]
	cmp r0, #9
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2170258
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0x2d
	bl ovl01_2170240
	mov r0, r4
	mov r1, #9
	mov r2, #1
	bl ovl01_21701CC
	ldmia sp!, {r4, pc}
	.align 2, 0
_02173170: .word 0x00000333
	arm_func_end ovl01_2173044

	arm_func_start ovl01_2173174
ovl01_2173174: // _02173174
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, _0217332C // =gPlayer
	mov r4, r0
	ldr r0, [r2, #0]
	mov r6, r1
	bl BossHelpers__Player__IsAlive
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, _0217332C // =gPlayer
	ldr r0, [r0, #0]
	ldr r1, [r0, #0x1c]
	tst r1, #1
	ldmeqia sp!, {r4, r5, r6, pc}
	bl ovl01_216CE28
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r4, r5, r6, pc}
_021731B8: // jump table
	ldmia sp!, {r4, r5, r6, pc} // case 0
	b _021731CC // case 1
	b _021731CC // case 2
	b _021732F4 // case 3
	b _021732F4 // case 4
_021731CC:
	ldr r1, [r4, #0x37c]
	ldr r0, _0217332C // =gPlayer
	ldr r1, [r1, #0x384]
	ldr r2, [r0, #0]
	ldr r0, [r1, #0x44]
	ldr r1, [r2, #0x44]
	mov r4, #0
	sub r0, r1, r0
	mov r1, #0xfa000
	mov r5, r4
	bl FX_Div
	cmp r6, #3
	addls pc, pc, r6, lsl #2
	b _021732B8
_02173204: // jump table
	b _02173214 // case 0
	b _02173214 // case 1
	b _02173268 // case 2
	b _02173268 // case 3
_02173214:
	cmp r0, #0
	ble _021732B8
	mov r1, #0x5000
	mov r2, r4
	umull r4, r3, r0, r1
	mla r3, r0, r2, r3
	mov ip, r0, asr #0x1f
	mov r5, ip, lsl #0xe
	mov r2, #0x800
	adds r2, r2, r0, lsl #14
	orr r5, r5, r0, lsr #18
	mla r3, ip, r1, r3
	adc r0, r5, #0
	mov r6, r2, lsr #0xc
	adds r2, r4, #0x800
	orr r6, r6, r0, lsl #20
	adc r0, r3, #0
	mov r5, r2, lsr #0xc
	rsb r4, r6, #0
	orr r5, r5, r0, lsl #20
	b _021732B8
_02173268:
	cmp r0, #0
	bge _021732B8
	mov r1, #0x5000
	mov r2, r4
	umull r4, r3, r0, r1
	mla r3, r0, r2, r3
	mov ip, r0, asr #0x1f
	mov r5, ip, lsl #0xe
	mov r2, #0x800
	adds r2, r2, r0, lsl #14
	orr r5, r5, r0, lsr #18
	mla r3, ip, r1, r3
	adc r0, r5, #0
	mov r6, r2, lsr #0xc
	adds r2, r4, #0x800
	orr r6, r6, r0, lsl #20
	adc r0, r3, #0
	mov r5, r2, lsr #0xc
	rsb r4, r6, #0
	orr r5, r5, r0, lsl #20
_021732B8:
	ldr r0, _0217332C // =gPlayer
	mov r2, #0x4000
	cmp r5, #0
	rsblt r5, r5, #0
	rsb r2, r2, #0
	ldr r0, [r0, #0]
	mov r1, r4
	sub r2, r2, r5
	bl Player__Action_HurtAlt
	ldr r0, _0217332C // =gPlayer
	ldr r1, [r0, #0]
	ldr r0, [r1, #0x48]
	sub r0, r0, #0x8000
	str r0, [r1, #0x48]
	ldmia sp!, {r4, r5, r6, pc}
_021732F4:
	ldr r0, _0217332C // =gPlayer
	ldr r2, [r0, #0]
	ldr r1, [r2, #0x1c]
	orr r1, r1, #0x20
	str r1, [r2, #0x1c]
	ldr r2, [r0, #0]
	ldr r1, [r2, #0x1c]
	bic r1, r1, #0x10
	str r1, [r2, #0x1c]
	ldr r1, [r0, #0]
	ldr r0, [r1, #0x48]
	add r0, r0, #0x8000
	str r0, [r1, #0x48]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0217332C: .word gPlayer
	arm_func_end ovl01_2173174

	arm_func_start ovl01_2173330
ovl01_2173330: // _02173330
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x784]
	sub r1, r1, #0x21
	cmp r1, #4
	addls pc, pc, r1, lsl #2
	b _02173364
_02173350: // jump table
	b _0217341C // case 0
	b _0217349C // case 1
	b _02173584 // case 2
	b _021735AC // case 3
	b _02173788 // case 4
_02173364:
	mov r0, r4
	bl ovl01_216FF88
	ldr r1, [r4, #0x1c]
	mov r0, r4
	orr r1, r1, #0x200
	bic r3, r1, #0x81
	mov r1, #0x21
	mov r2, #0
	str r3, [r4, #0x1c]
	bl ovl01_21701CC
	mov r0, #1
	bl BossArena__GetCamera
	ldr r1, _021737B8 // =0x001C2000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, #1
	bl BossArena__GetCamera
	mov r4, r0
	ldr r0, _021737BC // =_0217AFB0
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r1, r0
	ldr r2, [r1, #0x398]
	mov r1, #0
	mov r0, r4
	add r2, r2, #0x2bc000
	mov r3, r1
	bl BossArena__SetTracker1TargetPos
	mov r0, #2
	bl BossArena__GetCamera
	ldr r1, _021737B8 // =0x001C2000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	ldr r0, _021737BC // =_0217AFB0
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r1, r0
	ldr r2, [r1, #0x398]
	mov r1, #0
	mov r0, r4
	add r2, r2, #0xb4000
	mov r3, r1
	bl BossArena__SetTracker1TargetPos
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_0217341C:
	mov r1, #0
	str r1, [r4, #0x98]
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	mov r1, #0x22
	mov r2, #1
	bl ovl01_21701CC
	mov r0, #0xa000
	rsb r0, r0, #0
	str r0, [r4, #0x9c]
	ldr r2, [r4, #0x1c]
	mov r0, #0xad
	orr r2, r2, #0x10
	str r2, [r4, #0x1c]
	mov r2, #0
	str r2, [sp]
	sub r1, r0, #0xae
	str r0, [sp, #4]
	ldr r0, [r4, #0x78c]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r4, #0x78c]
	add r1, r4, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_0217349C:
	mov r0, #0x190000
	ldr r1, [r4, #0x48]
	rsb r0, r0, #0
	cmp r1, r0
	addgt sp, sp, #8
	ldmgtia sp!, {r3, r4, r5, pc}
	ldr r1, [r4, #0x1c]
	mov r0, #0xa000
	orr r1, r1, #0x80
	str r1, [r4, #0x1c]
	str r0, [r4, #0x9c]
	add r0, r4, #0x300
	ldrh r0, [r0, #0x80]
	tst r0, #0x20
	beq _021734F8
	mov r0, #0
	str r0, [r4, #0x28]
	ldr r1, [r4, #0x20]
	mov r0, #0x4b000
	bic r1, r1, #1
	str r1, [r4, #0x20]
	str r0, [r4, #0x44]
	b _0217355C
_021734F8:
	tst r0, #0x40
	beq _02173520
	mov r0, #0
	str r0, [r4, #0x28]
	ldr r1, [r4, #0x20]
	mov r0, #0xaf000
	bic r1, r1, #1
	str r1, [r4, #0x20]
	str r0, [r4, #0x44]
	b _0217355C
_02173520:
	tst r0, #0x80
	mov r0, #3
	str r0, [r4, #0x28]
	beq _02173548
	ldr r1, [r4, #0x20]
	mov r0, #0x190000
	orr r1, r1, #1
	str r1, [r4, #0x20]
	str r0, [r4, #0x44]
	b _0217355C
_02173548:
	ldr r1, [r4, #0x20]
	mov r0, #0x1f4000
	orr r1, r1, #1
	str r1, [r4, #0x20]
	str r0, [r4, #0x44]
_0217355C:
	mov r0, r4
	mov r1, #0x23
	mov r2, #0
	bl ovl01_21701CC
	mov r0, r4
	bl ovl01_21700D8
	mov r0, r4
	bl ovl01_2170120
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_02173584:
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	mov r1, #0x24
	mov r2, #0
	bl ovl01_21701CC
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_021735AC:
	bl ovl01_216CE28
	cmp r0, #1
	cmpne r0, #2
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x1c]
	bic r0, r0, #0x200
	tst r0, #1
	addeq sp, sp, #8
	str r0, [r4, #0x1c]
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	mov r1, #0x25
	mov r2, #0
	bl ovl01_21701CC
	ldr r0, [r4, #0x1c]
	bic r0, r0, #0x10
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x28]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02173660
_02173604: // jump table
	b _02173614 // case 0
	b _02173628 // case 1
	b _0217363C // case 2
	b _02173650 // case 3
_02173614:
	ldr r0, [r4, #0x37c]
	ldr r1, _021737C0 // =0x00000E38
	ldr r0, [r0, #0x384]
	bl ovl01_216E34C
	b _02173660
_02173628:
	ldr r0, [r4, #0x37c]
	ldr r1, _021737C4 // =0x00000AAA
	ldr r0, [r0, #0x384]
	bl ovl01_216E34C
	b _02173660
_0217363C:
	ldr r0, [r4, #0x37c]
	ldr r1, _021737C4 // =0x00000AAA
	ldr r0, [r0, #0x384]
	bl ovl01_216E324
	b _02173660
_02173650:
	ldr r0, [r4, #0x37c]
	ldr r1, _021737C0 // =0x00000E38
	ldr r0, [r0, #0x384]
	bl ovl01_216E324
_02173660:
	ldr r1, [r4, #0x28]
	mov r0, r4
	bl ovl01_2173174
	mov r0, r4
	mov r1, #0x2000
	bl ovl01_2170220
	mov r0, r4
	bl ovl01_216FFA8
	mov r0, r4
	bl ovl01_2170130
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #0xc8000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, #1
	bl BossArena__GetCamera
	mov r5, r0
	ldr r0, _021737BC // =_0217AFB0
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r1, r0
	mov r0, r5
	ldr r2, [r1, #0x398]
	mov r1, #0
	add r2, r2, #0x190000
	mov r3, r1
	bl BossArena__SetTracker1TargetPos
	mov r0, #2
	bl BossArena__GetCamera
	mov r1, #0xc8000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, #2
	bl BossArena__GetCamera
	mov r5, r0
	ldr r0, _021737BC // =_0217AFB0
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r1, r0
	mov r0, r5
	ldr r2, [r1, #0x398]
	mov r1, #0
	add r2, r2, #0x50000
	mov r3, r1
	bl BossArena__SetTracker1TargetPos
	mov r0, #0
	ldr r1, [r4, #0x44]
	ldr r2, [r4, #0x48]
	ldr r3, [r4, #0x4c]
	rsb r2, r2, #0
	bl BossFX__CreatePirateLand
	mov r0, #0
	str r0, [sp]
	mov r0, #0xb7
	str r0, [sp, #4]
	sub r1, r0, #0xb8
	ldr r0, [r4, #0x78c]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r4, #0x78c]
	add r1, r4, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	mov r0, #0
	str r0, [sp]
	mov r1, #0xb8
	str r1, [sp, #4]
	sub r1, r1, #0xb9
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_02173788:
	mov r1, #0
	str r1, [r4, #0x98]
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl ovl01_216FF98
	mov r0, r4
	bl ovl01_2171D5C
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021737B8: .word 0x001C2000
_021737BC: .word _0217AFB0
_021737C0: .word 0x00000E38
_021737C4: .word 0x00000AAA
	arm_func_end ovl01_2173330

	arm_func_start ovl01_21737C8
ovl01_21737C8: // _021737C8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x784]
	cmp r1, #0x26
	beq _021737F4
	cmp r1, #0x27
	beq _02173814
	mov r1, #0x26
	mov r2, #0
	bl ovl01_21701CC
	ldmia sp!, {r4, pc}
_021737F4:
	bl ovl01_2170234
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0x27
	mov r2, #1
	bl ovl01_21701CC
	ldmia sp!, {r4, pc}
_02173814:
	ldr r2, [r4, #0x2c]
	sub r1, r2, #1
	str r1, [r4, #0x2c]
	cmp r2, #0
	ldmneia sp!, {r4, pc}
	bl ovl01_21720E8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_21737C8

	arm_func_start ovl01_2173830
ovl01_2173830: // _02173830
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x784]
	cmp r1, #0x28
	beq _02173868
	mov r1, #0x28
	mov r2, #1
	bl ovl01_21701CC
	add r0, r4, #0x700
	mov r1, #0
	strh r1, [r0, #0x90]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02173868:
	add r0, r4, #0x700
	ldrh r2, [r0, #0x90]
	add r1, r2, #1
	strh r1, [r0, #0x90]
	cmp r2, #0x23
	bne _021738B8
	mov r1, #0
	mov r0, #0xb3
	str r1, [sp]
	sub r1, r0, #0xb4
	str r0, [sp, #4]
	ldr r0, [r4, #0x78c]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r4, #0x78c]
	add r1, r4, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
_021738B8:
	mov r0, r4
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2171D5C
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2173830

	arm_func_start ovl01_21738DC
ovl01_21738DC: // _021738DC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x784]
	cmp r1, #1
	beq _02173950
	cmp r1, #2
	beq _02173978
	cmp r1, #3
	beq _021739A0
	mov r1, #1
	mov r2, #0
	bl ovl01_21701CC
	mov r2, #0
	mov r0, #0xae
	str r2, [sp]
	sub r1, r0, #0xaf
	str r0, [sp, #4]
	ldr r0, [r4, #0x78c]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r4, #0x78c]
	add r1, r4, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02173950:
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #2
	mov r2, #0
	bl ovl01_21701CC
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02173978:
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #3
	mov r2, #0
	bl ovl01_21701CC
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_021739A0:
	bl ovl01_2170234
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_2171D5C
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_21738DC

	arm_func_start ovl01_21739C0
ovl01_21739C0: // _021739C0
	bx lr
	arm_func_end ovl01_21739C0

	.rodata
	
_02179E7C: // 0x02179E7C
    .word 0
	.word 0xD7000, 0xF000, 0xFFF29000, 0xFFF74000, 0xF000, 0xFFF74000
	.word 0xFFF29000, 0xF000, 0xD7000, 0x96000, 0xF000, 0x104000

_02179EB0: // 0x02179EB0
    .word 0x280044
	
_02179EB4: // 0x02179EB4
    .word 0x50005
	
_02179EB8: // 0x02179EB8
    .word 0xA000A
	
_02179EBC: // 0x02179EBC
    .word 0x2000400, 0x100

_02179EC4: // 0x02179EC4
    .word 0, 0x1000, 0

_02179ED0: // 0x02179ED0
    .hword 0x5000, 0x5000, 0x5000, 0x5000, 0x5000, 0x5000, 0x5000, 0x5000, 0x6000, 0x6000, 0x6000

_02179EE6: // 0x02179EE6
    .hword 0x6000, 0x6000, 0x6000, 0x6000, 0x6000

_02179EF0: // 0x02179EF0
    .hword 0x1E0, 0x1E0, 0x168

_02179EF6: // 0x02179EF6
    .hword 0x12C, 0x12C, 0x12C, 0xF0, 0xB4
	
_02179F00: // 0x02179F00
    .hword 0, 0x333, 0x4000
	
_02179F06: // 0x02179F06
    .hword 0x5000, 0, 0x800, 0x999, 0xC00
	
_02179F10: // 0x02179F10
    .hword 0x1800, 0x1800, 0x2000, 0x2800, 0x2000, 0x2000, 0x2800, 0x3000, 0x3000, 0x3000, 0x3000
	
_02179F26: // 0x02179F26
    .hword 0x3000, 0x4000, 0x4000, 0x4000, 0x4000

_02179F30: // 0x02179F30
    .hword 2, 2, 2

_02179F36: // 0x02179F36
    .hword 2, 2, 2, 2, 2
	
_02179F40: // 0x02179F40
    .hword 0x3000, 0x3000, 0x3000, 0x3000, 0x3000, 0x3000, 0x3000, 0x3000, 0x4000, 0x4000, 0x4000
	
_02179F56: // 0x02179F56
    .hword 0x4000, 0x4000, 0x4000, 0x4000, 0x4000

_02179F60: // 0x02179F60
    .hword 1, 1, 2, 2, 1, 1, 2, 2, 2, 2, 3, 3
	
_02179F78: // 0x02179F78
    .hword 2, 3, 3, 3
	
_02179F80: // 0x02179F80
    .hword 1, 1, 2, 2, 1, 1, 2, 2, 2, 3, 3, 3, 2, 3, 3, 3

_02179FA0: // 0x02179FA0
    .hword 0xE000, 0x10
	
_02179FA4: // 0x02179FA4
    .word 0x352000, 0x64000, 0x352000, 0x1C2000, 0x352000, 0x8C000, 0x23A000, 0x1CC000, 0x23A000

_02179FC8: // 0x02179FC8
    .word 0x30078, 0x64001E, 0x1E0003, 0x30050, 0x3C001E, 0x1E0003, 0x30050, 0x3C001E, 0x1E0003, 0x30028, 0x28001E, 0x140003

_02179FF8: // 0x02179FF8
    .word 0x3005A, 0xF, 0x30046, 0x19000F, 0x30032, 0x33000F, 0x30032, 0x4C000F

_0217A018: // 0x0217A018
    .word 0x3003C, 0x19000F, 0x30028, 0x33000F, 0x30014, 0x4C000F, 0x30014, 0x99000F

_0217A038: // 0x0217A038
    .word 5, 5, 5, 5, 5, 7, 7, 7, 5, 5, 5, 5, 5, 7, 7, 7, 5
	.word 5, 5, 5, 5, 7, 7, 8, 5, 5, 5, 5, 7, 7, 8, 8

_0217A0B8: // 0x0217A0B8
    .word 6, 6, 6, 6, 6, 6, 9, 9, 6, 6, 6, 6, 6
	.word 6
	.word 9, 9, 6, 6, 6, 6, 9, 9, 8, 8, 6, 6, 6, 6, 9, 9, 8
	.word 8

	.data

_0217ABB0: // 0x0217ABB0
    .word aZ4CorePl
	
_0217ABB4: // 0x0217ABB4
    .word aZ4ArmPl			    // "z4_arm_pl"
	.word aZ4ArmbonePl       	// "z4_armbone_pl"
	.word aZ4AsikubiPl       	// "z4_asikubi_pl"
	.word aZ4BodyPl          	// "z4_body_pl"
	.word aZ4HatPl           	// "z4_hat_pl"
	.word aZ4HatUPl          	// "z4_hat_u_pl"
	.word aZ4KokansetuPl     	// "z4_kokansetu_pl"
	.word aZ4LegPl           	// "z4_leg_pl"
	.word aZ4NeckPl          	// "z4_neck_pl"
	.word aZ4SholderPl       	// "z4_sholder_pl"
	.word aZ4SholderBPl      	// "z4_sholder_b_pl"
	.word aZ4SkullPl         	// "z4_skull_pl"
	.word aZ4StomacPl        	// "z4_stomac_pl"
	.word aZ4TopPl           	// "z4_top_pl"
	.word aZ4TunoPl          	// "z4_tuno_pl"
	.word aZ4WeastPl         	// "z4_weast_pl"

aZ4TopPl: // 0x0217ABF4
    .asciz "z4_top_pl"
    .align 4

aZ4ArmPl: // 0x0217AC00
    .asciz "z4_arm_pl"
    .align 4

aZ4LegPl: // 0x0217AC0C
    .asciz "z4_leg_pl"
    .align 4

aZ4HatPl: // 0x0217AC18
    .asciz "z4_hat_pl"
    .align 4

aZ4BodyPl: // 0x0217AC24
    .asciz "z4_body_pl"
    .align 4

aZ4TunoPl: // 0x0217AC30
    .asciz "z4_tuno_pl"
    .align 4

aZ4CorePl: // 0x0217AC3C
    .asciz "z4_core_pl"
    .align 4

aZ4NeckPl: // 0x0217AC48
    .asciz "z4_neck_pl"
    .align 4

aZ4SkullPl: // 0x0217AC54
    .asciz "z4_skull_pl"
    .align 4

aZ4WeastPl: // 0x0217AC60
    .asciz "z4_weast_pl"
    .align 4

aZ4HatUPl: // 0x0217AC6C
    .asciz "z4_hat_u_pl"
    .align 4

aZ4StomacPl: // 0x0217AC78
    .asciz "z4_stomac_pl"
    .align 4

aZ4AsikubiPl: // 0x0217AC88
    .asciz "z4_asikubi_pl"
    .align 4

aZ4ArmbonePl: // 0x0217AC98
    .asciz "z4_armbone_pl"
    .align 4

aZ4SholderPl: // 0x0217ACA8
    .asciz "z4_sholder_pl"
    .align 4

aZ4SholderBPl: // 0x0217ACB8
    .asciz "z4_sholder_b_pl"
    .align 4

aZ4KokansetuPl: // 0x0217ACC8
    .asciz "z4_kokansetu_pl"
    .align 4

_0217ACD8: // 0x0217ACD8
    .word 0
	
aBoss4Nsbta: // 0x0217ACDC
    .asciz "/boss4.nsbta"
    .align 4

aBoss4Nsbca: // 0x0217ACEC
    .asciz "/boss4.nsbca"
    .align 4

aBodyCore: // 0x0217ACFC
    .asciz "body_core"
    .align 4

aExc_5: // 0x0217AD08
    .asciz "exc"
    .align 4

aBoss4CoreNsbma: // 0x0217AD0C
    .asciz "/boss4_core.nsbma"
    .align 4

aMast: // 0x0217AD20
    .asciz "mast"
    .align 4

aCenter2: // 0x0217AD28
    .asciz "center2"
    .align 4

aBsef4FcolNsbmd: // 0x0217AD30
    .asciz "/bsef4_fcol.nsbmd"
    .align 4

aBsef4FcolNsbca: // 0x0217AD44
    .asciz "/bsef4_fcol.nsbca"
    .align 4

aBsef4FcolNsbma: // 0x0217AD58
    .asciz "/bsef4_fcol.nsbma"
    .align 4

aBsef4FcolNsbta: // 0x0217AD6C
    .asciz "/bsef4_fcol.nsbta"
    .align 4

aBsef4FcolNsbtp: // 0x0217AD80
    .asciz "/bsef4_fcol.nsbtp"
    .align 4

aBsef4FcolNsbva: // 0x0217AD94
    .asciz "/bsef4_fcol.nsbva"
    .align 4

aBsef4FballNsbm: // 0x0217ADA8
    .asciz "/bsef4_fball.nsbmd"
    .align 4

aBsef4FballNsbc: // 0x0217ADBC
    .asciz "/bsef4_fball.nsbca"
    .align 4

aBsef4FballNsbm_0: // 0x0217ADD0
    .asciz "/bsef4_fball.nsbma"
    .align 4

aBsef4FballNsbt: // 0x0217ADE4
    .asciz "/bsef4_fball.nsbta"
    .align 4

aBsef4FballNsbt_0: // 0x0217ADF8
    .asciz "/bsef4_fball.nsbtp"
    .align 4

aExc_4: // 0x0217AE0C
    .asciz "exc:"
    .align 4