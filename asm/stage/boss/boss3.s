	.include "asm/macros.inc"
	.include "global.inc"

.public BossArena__explosionFXSpawnTime

	.bss

_0217AF88: // 0x0217AF88
	.space 0x04

_0217AF8C: // 0x0217AF8C
	.space 36

	.text

	arm_func_start Boss3Stage__Create
Boss3Stage__Create: // 0x02160A70
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xe4
	mov r3, #0x1500
	mov r4, r0
	mov r11, r1
	mov r10, r2
	mov r2, #0
	str r3, [sp]
	mov r0, #2
	ldr r5, _02160ED4 // =0x00000F54
	str r0, [sp, #4]
	ldr r0, _02160ED8 // =StageTask_Main
	ldr r1, _02160EDC // =ovl01_2162F54
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	ldr r1, _02160EE0 // =_0217AF88
	str r0, [r1]
	bl GetTaskWork_
	mov r5, r0
	mov r0, #0
	mov r1, r5
	ldr r2, _02160ED4 // =0x00000F54
	bl MIi_CpuClear16
	mov r1, r4
	mov r0, r5
	mov r2, r11
	mov r3, r10
	bl GameObject__InitFromObject
	ldr r1, _02160EE4 // =ovl01_2162F18
	ldr r0, _02160EE8 // =ovl01_2163028
	str r1, [r5, #0xf4]
	str r0, [r5, #0xfc]
	ldr r0, [r5, #0x18]
	mov r1, #0x400
	orr r0, r0, #0x12
	str r0, [r5, #0x18]
	ldr r2, [r5, #0x1c]
	add r0, r5, #0x300
	orr r2, r2, #0xa300
	str r2, [r5, #0x1c]
	strh r1, [r0, #0xb8]
	str r10, [r5, #0x3c4]
	str r10, [r5, #0x3cc]
	str r10, [r5, #0x3d4]
	sub r0, r10, #0x19c000
	str r0, [r5, #0x3d8]
	ldr r1, _02160EEC // =ovl01_21631E0
	mov r0, #1
	str r1, [r5, #0x3b4]
	str r0, [r5, #0x414]
	add r0, r5, #0x24
	add r0, r0, #0x400
	bl BossHelpers__Light__Init
	add r0, r5, #0x364
	bl ovl01_2161BD0
	mov r0, r5
	add r1, r5, #0x56
	add r1, r1, #0x400
	bl ovl01_21628AC
	bl BossHelpers__Model__InitSystem
	add r4, r5, #0x108
	add r0, r4, #0x400
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	str r2, [sp]
	add r0, r4, #0x400
	ldr r1, _02160EF0 // =bossAssetFiles
	mov r3, r2
	ldr r1, [r1, #8]
	bl AnimatorMDL__SetResource
	mov r1, #0
	str r1, [r4, #0x448]
	rsb r0, r10, #0
	str r0, [r4, #0x44c]
	str r1, [r4, #0x450]
	ldr r0, _02160EF4 // =0x000034CC
	str r0, [r4, #0x418]
	str r0, [r4, #0x41c]
	str r0, [r4, #0x420]
	add r0, r5, #0x24c
	add r6, r0, #0x400
	mov r0, r6
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _02160EF0 // =bossAssetFiles
	str r2, [sp]
	ldr r1, [r0, #0x10]
	mov r0, r6
	mov r3, r2
	bl AnimatorMDL__SetResource
	add r0, r5, #0x550
	add r4, r6, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	add r0, r5, #0x520
	add r3, r6, #0x18
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r4, r5, #0x790
	mov r0, r4
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r1, _02160EF0 // =bossAssetFiles
	str r2, [sp]
	ldr r1, [r1, #0x18]
	mov r0, r4
	mov r3, r2
	bl AnimatorMDL__SetResource
	add r1, r5, #0x550
	add r7, r4, #0x48
	add r0, r5, #0xd4
	add r3, r4, #0x18
	add r4, r0, #0x800
	ldmia r1, {r0, r1, r2}
	stmia r7, {r0, r1, r2}
	add r6, r5, #0x520
	ldmia r6, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r4
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r1, _02160EF0 // =bossAssetFiles
	str r2, [sp]
	ldr r1, [r1, #0x20]
	mov r0, r4
	mov r3, r2
	bl AnimatorMDL__SetResource
	mov r3, #0
	str r3, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r2, [r5, #0x36c]
	mov r0, r4
	mov r1, #3
	bl BossHelpers__Animation__Func_2038BF0
	add r0, r5, #0x550
	add r8, r4, #0x48
	ldmia r0, {r0, r1, r2}
	add r6, r4, #0x18
	stmia r8, {r0, r1, r2}
	add r7, r5, #0x520
	ldmia r7, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	mov r4, #1
	mov r1, #0
	stmia sp, {r1, r4}
	ldr r2, [r5, #0x368]
	mov r3, #2
	add r0, r5, #0x790
	bl BossHelpers__Animation__Func_2038BF0
	add r4, r5, #0x108
	mov r0, #4
	strb r0, [r4, #0x40a]
	mov r6, #3
	ldr r1, _02160EF8 // =BossHelpers__Model__RenderCallback
	add r0, r4, #0x490
	mov r2, #0
	mov r3, #6
	str r6, [sp]
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0x494]
	ldr r1, _02160EFC // =aStage00
	mov r2, #0x1e
	bl BossHelpers__Model__Init
	ldr r1, _02160F00 // =gameArchiveStage
	add r0, sp, #0x7c
	ldr r2, [r1]
	ldr r1, _02160F04 // =aExc_3
	bl NNS_FndMountArchive
	add r0, sp, #0x7c
	mov r1, #0x31
	bl NNS_FndGetArchiveFileByIndex
	add r1, r5, #0x218
	mov r6, r0
	add r8, r1, #0x800
	mov r7, #0
	mov r9, r5
_02160D4C:
	mov r0, r6
	bl Sprite__GetTextureSize
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r4, r0
	mov r0, r6
	bl Sprite__GetPaletteSize
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #0
	stmia sp, {r1, r4}
	str r0, [sp, #8]
	mov r0, r8
	mov r2, r6
	mov r3, #1
	bl AnimatorSprite3D__Init
	mov r0, #0x1c
	strb r0, [r9, #0xa22]
	mov r0, #7
	strb r0, [r9, #0xa23]
	ldr r0, [r9, #0xae4]
	mov r1, r7, lsl #1
	orr r0, r0, #4
	str r0, [r9, #0xae4]
	ldr r0, _02160F08 // =_02179DF4
	add r8, r8, #0x104
	ldrh r1, [r0, r1]
	ldr r0, _02160F0C // =0x00001A66
	str r0, [r9, #0xa30]
	str r0, [r9, #0xa34]
	str r0, [r9, #0xa38]
	add r0, r5, r7, lsl #2
	add r7, r7, #1
	str r1, [r0, #0xf40]
	add r9, r9, #0x104
	cmp r7, #5
	blt _02160D4C
	add r0, sp, #0x7c
	bl NNS_FndUnmountArchive
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	ldr r0, _02160F10 // =0x0000012E
	mov r1, r11
	mov r2, r10
	str r3, [sp, #0x10]
	bl GameObject__SpawnObject
	str r0, [r5, #0x374]
	mov r6, #0
	ldr r7, _02160F14 // =0x0000012F
	str r5, [r0, #0xa3c]
	mov r4, r6
_02160E2C:
	str r4, [sp]
	str r4, [sp, #4]
	str r4, [sp, #8]
	mov r0, r7
	mov r1, r11
	mov r2, r10
	mov r3, r4
	str r4, [sp, #0xc]
	and r8, r6, #0xff
	str r8, [sp, #0x10]
	bl GameObject__SpawnObject
	add r1, r5, r6, lsl #2
	add r6, r6, #1
	str r0, [r1, #0x398]
	str r5, [r0, #0x374]
	cmp r6, #4
	blt _02160E2C
	ldr r1, _02160F00 // =gameArchiveStage
	add r0, sp, #0x14
	ldr r2, [r1]
	ldr r1, _02160F04 // =aExc_3
	bl NNS_FndMountArchive
	add r0, sp, #0x14
	mov r1, #0x19
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultSetup
	add r0, sp, #0x14
	mov r1, #0x1c
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultSetup
	add r0, sp, #0x14
	mov r1, #0x20
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultSetup
	add r0, sp, #0x14
	bl NNS_FndUnmountArchive
	mov r0, r5
	bl StageTask__InitSeqPlayer
	bl DisableSpatialVolume
	mov r0, r5
	add sp, sp, #0xe4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02160ED4: .word 0x00000F54
_02160ED8: .word StageTask_Main
_02160EDC: .word ovl01_2162F54
_02160EE0: .word _0217AF88
_02160EE4: .word ovl01_2162F18
_02160EE8: .word ovl01_2163028
_02160EEC: .word ovl01_21631E0
_02160EF0: .word bossAssetFiles
_02160EF4: .word 0x000034CC
_02160EF8: .word BossHelpers__Model__RenderCallback
_02160EFC: .word aStage00
_02160F00: .word gameArchiveStage
_02160F04: .word aExc_3
_02160F08: .word _02179DF4
_02160F0C: .word 0x00001A66
_02160F10: .word 0x0000012E
_02160F14: .word 0x0000012F
	arm_func_end Boss3Stage__Create

	arm_func_start Boss3__Create
Boss3__Create: // 0x02160F18
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x7c
	mov r5, #0x1500
	mov r7, r0
	mov r6, r2
	mov r2, #0
	str r5, [sp]
	mov r4, #2
	ldr r0, _021611C4 // =StageTask_Main
	ldr r1, _021611C8 // =ovl01_21637F0
	mov r3, r2
	str r4, [sp, #4]
	sub r4, r5, #0x368
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r8, r0
	ldr r2, _021611CC // =0x00001198
	mov r1, r8
	mov r0, #0
	bl MIi_CpuClear16
	mov r1, r7
	mov r3, r6
	mov r0, r8
	mov r2, #0
	bl GameObject__InitFromObject
	ldr r1, _021611D0 // =ovl01_2163604
	ldr r0, _021611D4 // =ovl01_2163838
	str r1, [r8, #0xf4]
	str r0, [r8, #0xfc]
	ldr r1, [r8, #0x18]
	add r0, r8, #0x22c
	orr r1, r1, #0x10
	str r1, [r8, #0x18]
	add r0, r0, #0x800
	ldr r1, [r8, #0x1c]
	orr r1, r1, #0x8300
	str r1, [r8, #0x1c]
	bl ovl01_2161BD0
	add r4, r8, #0x1cc
	add r0, r4, #0xc00
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	str r2, [sp]
	add r0, r4, #0xc00
	ldr r1, _021611D8 // =bossAssetFiles
	mov r3, r2
	ldr r1, [r1]
	bl AnimatorMDL__SetResource
	ldr r1, _021611DC // =0x000034CC
	mov r0, #4
	str r1, [r4, #0xc18]
	str r1, [r4, #0xc1c]
	str r1, [r4, #0xc20]
	strb r0, [r4, #0xc0a]
	mov r0, #3
	str r0, [sp]
	add r0, r4, #0xc90
	ldr r1, _021611E0 // =BossHelpers__Model__RenderCallback
	mov r2, #0
	mov r3, #6
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0xc94]
	ldr r1, _021611E4 // =aBody_0
	mov r2, #0x1d
	bl BossHelpers__Model__Init
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0xc94]
	ldr r1, _021611E8 // =aMouth
	mov r2, #0x1c
	bl BossHelpers__Model__Init
	ldr r0, _021611EC // =_02179D9C
	mov r9, #0
	ldrh r2, [r0, #0x50]
	ldrh r1, [r0, #0x52]
	ldr r6, _021611DC // =0x000034CC
	strh r2, [sp, #0xc]
	strh r1, [sp, #0xe]
	ldrh r1, [r0, #0x54]
	ldrh r0, [r0, #0x56]
	add r7, sp, #0xc
	add r10, r8, #0xf10
	strh r1, [sp, #0x10]
	strh r0, [sp, #0x12]
	mov r5, #4
	mov r11, #3
	mov r4, r9
_02161084:
	mov r0, r10
	mov r1, #0
	bl AnimatorMDL__Init
	mov r0, #0
	str r0, [sp]
	ldr r1, _021611D8 // =bossAssetFiles
	mov r0, r10
	ldr r1, [r1]
	mov r2, #3
	mov r3, #0
	bl AnimatorMDL__SetResource
	mov r0, #0
	str r0, [r10, #0x48]
	str r0, [r10, #0x4c]
	str r0, [r10, #0x50]
	str r6, [r10, #0x18]
	str r6, [r10, #0x1c]
	str r6, [r10, #0x20]
	strb r5, [r10, #0xa]
	ldr r1, _021611E0 // =BossHelpers__Model__RenderCallback
	str r11, [sp]
	add r0, r10, #0x90
	mov r2, #0
	mov r3, #6
	bl NNS_G3dRenderObjSetCallBack
	str r4, [sp]
	add r2, r7, r9, lsl #2
	ldrh r2, [r2, #2]
	ldr r0, [r10, #0x94]
	ldr r1, _021611F0 // =aArmHit
	mov r3, r4
	bl BossHelpers__Model__Init
	add r9, r9, #1
	add r10, r10, #0x144
	cmp r9, #2
	blt _02161084
	ldr r1, _021611F4 // =gameArchiveStage
	add r0, sp, #0x14
	ldr r2, [r1]
	ldr r1, _021611F8 // =aExc_3
	bl NNS_FndMountArchive
	add r0, r8, #0x3cc
	ldr r6, _021611FC // =_0217A8E8
	ldr r4, _021611D8 // =bossAssetFiles
	add r10, r0, #0x800
	mov r9, #0
	add r11, sp, #0x14
	mov r5, #5
_02161144:
	mov r0, r11
	add r1, r9, #9
	bl NNS_FndGetArchiveFileByIndex
	mov r7, r0
	ldr r0, [r4]
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
	blt _02161144
	mov r0, r8
	mov r1, #2
	bl ovl01_2163EB0
	add r0, sp, #0x14
	bl NNS_FndUnmountArchive
	mov r0, r8
	bl StageTask__InitSeqPlayer
	mov r0, r8
	mov r1, #0
	bl ovl01_2163D10
	mov r0, r8
	add sp, sp, #0x7c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021611C4: .word StageTask_Main
_021611C8: .word ovl01_21637F0
_021611CC: .word 0x00001198
_021611D0: .word ovl01_2163604
_021611D4: .word ovl01_2163838
_021611D8: .word bossAssetFiles
_021611DC: .word 0x000034CC
_021611E0: .word BossHelpers__Model__RenderCallback
_021611E4: .word aBody_0
_021611E8: .word aMouth
_021611EC: .word _02179D9C
_021611F0: .word aArmHit
_021611F4: .word gameArchiveStage
_021611F8: .word aExc_3
_021611FC: .word _0217A8E8
	arm_func_end Boss3__Create

	arm_func_start Boss3SplatInk__Create
Boss3SplatInk__Create: // 0x02161200
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
	ldr r4, _021613B8 // =0x00000698
	ldr r0, _021613BC // =StageTask_Main
	ldr r1, _021613C0 // =ovl01_2167390
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _021613B8 // =0x00000698
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r1, r7
	mov r2, r6
	mov r3, r5
	mov r0, r4
	bl GameObject__InitFromObject
	ldr r1, _021613C4 // =ovl01_2167380
	ldr r0, _021613C8 // =ovl01_21673C0
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r1, _021613CC // =ovl01_21674F4
	add r0, r4, #0x364
	str r1, [r4, #0x108]
	ldr r1, [r4, #0x18]
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x8200
	str r1, [r4, #0x1c]
	bl ovl01_2161BD0
	ldr r3, _021613D0 // =_0217A82C
	add r0, r4, #0x258
	ldrsh r1, [r3, #0x22]
	str r1, [sp]
	ldrsh r1, [r3, #0x1c]
	ldrsh r2, [r3, #0x1e]
	ldrsh r3, [r3, #0x20]
	bl ObjRect__SetBox2D
	ldr r1, _021613D4 // =ovl01_216759C
	str r4, [r4, #0x274]
	str r1, [r4, #0x278]
	ldr r2, [r4, #0x270]
	ldr r1, _021613D8 // =aExc_3
	bic r2, r2, #4
	str r2, [r4, #0x270]
	ldr r2, _021613DC // =gameArchiveStage
	add r0, sp, #0xc
	ldr r2, [r2]
	bl NNS_FndMountArchive
	add r0, r4, #0x410
	mov r1, #0
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #0x19
	bl NNS_FndGetArchiveFileByIndex
	mov r2, #0
	mov r1, r0
	add r0, r4, #0x410
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	str r1, [r4, #0x458]
	str r1, [r4, #0x45c]
	ldr r2, _021613E0 // =0x000034CC
	str r1, [r4, #0x460]
	str r2, [r4, #0x428]
	add r5, r4, #0x154
	str r2, [r4, #0x42c]
	add r0, r5, #0x400
	str r2, [r4, #0x430]
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #0x19
	bl NNS_FndGetArchiveFileByIndex
	mov r1, r0
	mov r3, #0
	add r0, r5, #0x400
	mov r2, #1
	str r3, [sp]
	bl AnimatorMDL__SetResource
	mov r0, #0
	str r0, [r5, #0x448]
	str r0, [r5, #0x44c]
	str r0, [r5, #0x450]
	ldr r1, _021613E0 // =0x000034CC
	add r0, sp, #0xc
	str r1, [r5, #0x418]
	str r1, [r5, #0x41c]
	str r1, [r5, #0x420]
	bl NNS_FndUnmountArchive
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	mov r1, #0
	bl ovl01_21675A0
	mov r0, r4
	add sp, sp, #0x74
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_021613B8: .word 0x00000698
_021613BC: .word StageTask_Main
_021613C0: .word ovl01_2167390
_021613C4: .word ovl01_2167380
_021613C8: .word ovl01_21673C0
_021613CC: .word ovl01_21674F4
_021613D0: .word _0217A82C
_021613D4: .word ovl01_216759C
_021613D8: .word aExc_3
_021613DC: .word gameArchiveStage
_021613E0: .word 0x000034CC
	arm_func_end Boss3SplatInk__Create

	arm_func_start Boss3DimInk__Create
Boss3DimInk__Create: // 0x021613E4
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
	ldr r4, _021615B4 // =0x0000079C
	ldr r0, _021615B8 // =StageTask_Main
	ldr r1, _021615BC // =ovl01_2167970
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _021615B4 // =0x0000079C
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r1, r7
	mov r2, r6
	mov r3, r5
	mov r0, r4
	bl GameObject__InitFromObject
	ldr r1, _021615C0 // =ovl01_2167810
	ldr r0, _021615C4 // =ovl01_21679AC
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r1, [r4, #0x18]
	add r0, r4, #0x364
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x8300
	str r1, [r4, #0x1c]
	bl ovl01_2161BD0
	ldr r2, _021615C8 // =gameArchiveStage
	ldr r1, _021615CC // =aExc_3
	ldr r2, [r2]
	add r0, sp, #0xc
	bl NNS_FndMountArchive
	add r0, r4, #0x3d0
	mov r1, #0
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #0x1c
	bl NNS_FndGetArchiveFileByIndex
	mov r2, #0
	mov r1, r0
	add r0, r4, #0x3d0
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	str r1, [r4, #0x418]
	str r1, [r4, #0x41c]
	ldr r2, _021615D0 // =0x000C5FD0
	str r1, [r4, #0x420]
	ldr r0, _021615D4 // =0x000E6FC8
	str r2, [r4, #0x3e8]
	str r0, [r4, #0x3ec]
	ldr r0, _021615D8 // =0x001ACF98
	add r6, r4, #0x114
	str r0, [r4, #0x3f0]
	add r0, r6, #0x400
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #0x1c
	bl NNS_FndGetArchiveFileByIndex
	mov r1, r0
	mov r3, #0
	add r0, r6, #0x400
	mov r2, #1
	str r3, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	str r1, [r6, #0x448]
	str r1, [r6, #0x44c]
	add r5, r4, #0x258
	ldr r2, _021615DC // =0x000034CC
	str r1, [r6, #0x450]
	str r2, [r6, #0x418]
	str r2, [r6, #0x41c]
	add r0, r5, #0x400
	str r2, [r6, #0x420]
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #0x1c
	bl NNS_FndGetArchiveFileByIndex
	mov r1, r0
	mov r3, #0
	add r0, r5, #0x400
	mov r2, #2
	str r3, [sp]
	bl AnimatorMDL__SetResource
	mov r0, #0
	str r0, [r5, #0x448]
	str r0, [r5, #0x44c]
	str r0, [r5, #0x450]
	ldr r1, _021615DC // =0x000034CC
	add r0, sp, #0xc
	str r1, [r5, #0x418]
	str r1, [r5, #0x41c]
	str r1, [r5, #0x420]
	bl NNS_FndUnmountArchive
	ldr r1, [r4, #0x20]
	ldr r0, _021615E0 // =ovl01_2167C44
	orr r1, r1, #0x20
	str r1, [r4, #0x20]
	str r0, [r4, #0x378]
	mov r0, r4
	add sp, sp, #0x74
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_021615B4: .word 0x0000079C
_021615B8: .word StageTask_Main
_021615BC: .word ovl01_2167970
_021615C0: .word ovl01_2167810
_021615C4: .word ovl01_21679AC
_021615C8: .word gameArchiveStage
_021615CC: .word aExc_3
_021615D0: .word 0x000C5FD0
_021615D4: .word 0x000E6FC8
_021615D8: .word 0x001ACF98
_021615DC: .word 0x000034CC
_021615E0: .word ovl01_2167C44
	arm_func_end Boss3DimInk__Create

	arm_func_start Boss3InkSmoke__Create
Boss3InkSmoke__Create: // 0x021615E4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x74
	mov r0, #0x1a00
	str r0, [sp]
	mov r4, #4
	mov r2, #0
	str r4, [sp, #4]
	add r4, r4, #0x6b0
	ldr r0, _02161748 // =StageTask_Main
	ldr r1, _0216174C // =ovl01_2167FD4
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r6, r0
	ldr r2, _02161750 // =0x000006B4
	mov r1, r6
	mov r0, #0
	bl MIi_CpuClear16
	ldr r1, _02161754 // =ovl01_2167F80
	ldr r0, _02161758 // =ovl01_2168014
	str r1, [r6, #0xf4]
	str r0, [r6, #0xfc]
	ldr r0, [r6, #0x18]
	ldr r1, _0216175C // =gameArchiveStage
	orr r0, r0, #0x10
	str r0, [r6, #0x18]
	ldr r2, [r6, #0x1c]
	add r0, sp, #0xc
	orr r2, r2, #0x1300
	str r2, [r6, #0x1c]
	ldr r2, [r1]
	ldr r1, _02161760 // =aExc_3
	bl NNS_FndMountArchive
	add r0, sp, #0xc
	mov r1, #0x1f
	bl NNS_FndGetArchiveFileByIndex
	mov r8, #0
	ldr r11, OpeningBlazeNameSprite__LetterPositions // =_02179DAA
	mov r7, r0
	mov r10, r6
	add r9, r6, #0x3a8
	mov r4, r8
_02161690:
	mov r0, r7
	bl Sprite__GetTextureSize
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r5, r0
	mov r0, r7
	bl Sprite__GetPaletteSize
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r3, r8, lsl #1
	stmia sp, {r4, r5}
	str r0, [sp, #8]
	ldrh r3, [r11, r3]
	mov r0, r9
	mov r1, r4
	mov r2, r7
	bl AnimatorSprite3D__Init
	mov r0, #0x1c
	strb r0, [r10, #0x3b2]
	mov r0, #7
	strb r0, [r10, #0x3b3]
	ldr r1, [r10, #0x474]
	mov r0, r9
	orr r1, r1, #4
	str r1, [r10, #0x474]
	ldr r1, _02161768 // =0x000034CC
	str r1, [r10, #0x3c0]
	str r1, [r10, #0x3c4]
	str r1, [r10, #0x3c8]
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	add r8, r8, #1
	add r9, r9, #0x104
	add r10, r10, #0x104
	cmp r8, #3
	blt _02161690
	add r0, sp, #0xc
	bl NNS_FndUnmountArchive
	ldr r1, _0216176C // =ovl01_21681A8
	mov r0, r6
	str r1, [r6, #0x378]
	add sp, sp, #0x74
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02161748: .word StageTask_Main
_0216174C: .word ovl01_2167FD4
_02161750: .word 0x000006B4
_02161754: .word ovl01_2167F80
_02161758: .word ovl01_2168014
_0216175C: .word gameArchiveStage
_02161760: .word aExc_3
OpeningBlazeNameSprite__LetterPositions: .word _02179DAA
_02161768: .word 0x000034CC
_0216176C: .word ovl01_21681A8
	arm_func_end Boss3InkSmoke__Create

	arm_func_start Boss3ScreenSplatInk__Create
Boss3ScreenSplatInk__Create: // 0x02161770
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
	ldr r4, _02161884 // =0x000004EC
	ldr r0, _02161888 // =StageTask_Main
	ldr r1, _0216188C // =ovl01_21682F8
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02161884 // =0x000004EC
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r1, r7
	mov r2, r6
	mov r3, r5
	mov r0, r4
	bl GameObject__InitFromObject
	ldr r1, _02161890 // =ovl01_2168260
	ldr r0, _02161894 // =ovl01_2168324
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r1, [r4, #0x18]
	add r0, r4, #0x364
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x8300
	str r1, [r4, #0x1c]
	bl ovl01_2161BD0
	ldr r2, _02161898 // =gameArchiveStage
	ldr r1, _0216189C // =aExc_3
	ldr r2, [r2]
	add r0, sp, #0xc
	bl NNS_FndMountArchive
	add r0, r4, #0x3a8
	mov r1, #0
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #0x20
	bl NNS_FndGetArchiveFileByIndex
	mov r2, #0
	mov r1, r0
	add r0, r4, #0x3a8
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	mov r0, #0
	str r0, [r4, #0x3f0]
	str r0, [r4, #0x3f4]
	str r0, [r4, #0x3f8]
	ldr r1, _021618A0 // =0x000034CC
	add r0, sp, #0xc
	str r1, [r4, #0x3c0]
	str r1, [r4, #0x3c4]
	str r1, [r4, #0x3c8]
	bl NNS_FndUnmountArchive
	mov r0, r4
	add sp, sp, #0x74
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02161884: .word 0x000004EC
_02161888: .word StageTask_Main
_0216188C: .word ovl01_21682F8
_02161890: .word ovl01_2168260
_02161894: .word ovl01_2168324
_02161898: .word gameArchiveStage
_0216189C: .word aExc_3
_021618A0: .word 0x000034CC
	arm_func_end Boss3ScreenSplatInk__Create

	arm_func_start Boss3Arm__Create
Boss3Arm__Create: // 0x021618A4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r4, #0x1500
	mov r8, r0
	mov r7, r1
	mov r6, r2
	str r4, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x610
	ldr r0, _02161B7C // =StageTask_Main
	ldr r1, _02161B80 // =ovl01_21685FC
	mov r2, #0
	mov r5, r3
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x610
	bl MIi_CpuClear16
	mov r1, r8
	mov r2, r7
	mov r3, r6
	mov r0, r4
	bl GameObject__InitFromObject
	ldr r1, _02161B84 // =ovl01_2168520
	ldr r0, _02161B88 // =ovl01_2168620
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r1, _02161B8C // =ovl01_2168704
	add r0, r4, #0x364
	str r1, [r4, #0x108]
	ldr r1, [r4, #0x18]
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x8300
	str r1, [r4, #0x1c]
	str r5, [r4, #0x380]
	bl ovl01_2161BD0
	mov r1, #0
	add r0, r4, #0x218
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r3, _02161B90 // =_0217A82C
	add r0, r4, #0x218
	ldrsh r1, [r3, #0x42]
	str r1, [sp]
	ldrsh r1, [r3, #0x3c]
	ldrsh r2, [r3, #0x3e]
	ldrsh r3, [r3, #0x40]
	bl ObjRect__SetBox2D
	str r4, [r4, #0x234]
	ldr r0, [r4, #0x380]
	cmp r0, #0
	ldreq r0, _02161B94 // =ovl01_21687E8
	ldrne r0, _02161B98 // =ovl01_2168AC4
	str r0, [r4, #0x23c]
	ldr r1, [r4, #0x230]
	add r0, r4, #0x258
	orr r1, r1, #0x400
	bic r3, r1, #4
	mov r1, #2
	mov r2, #0x40
	str r3, [r4, #0x230]
	bl ObjRect__SetAttackStat
	add r0, r4, #0x258
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r3, _02161B90 // =_0217A82C
	add r0, r4, #0x258
	ldrsh r1, [r3, #0x4a]
	str r1, [sp]
	ldrsh r1, [r3, #0x44]
	ldrsh r2, [r3, #0x46]
	ldrsh r3, [r3, #0x48]
	bl ObjRect__SetBox2D
	str r4, [r4, #0x274]
	ldr r1, [r4, #0x270]
	add r0, r4, #0x298
	bic r1, r1, #4
	str r1, [r4, #0x270]
	mov r1, #2
	mov r2, #0
	bl ObjRect__SetAttackStat
	mov r1, #0
	add r0, r4, #0x298
	mov r2, r1
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x2b0]
	ldr r0, _02161B9C // =ovl01_2168D6C
	orr r1, r1, #0xc0
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x2bc]
	ldr r3, _02161B90 // =_0217A82C
	add r0, r4, #0x298
	ldrsh r1, [r3, #0x52]
	str r1, [sp]
	ldrsh r1, [r3, #0x4c]
	ldrsh r2, [r3, #0x4e]
	ldrsh r3, [r3, #0x50]
	bl ObjRect__SetBox2D
	str r4, [r4, #0x2b4]
	ldr r0, [r4, #0x2b0]
	add r6, r4, #0xcc
	bic r0, r0, #4
	str r0, [r4, #0x2b0]
	add r0, r6, #0x400
	mov r1, #0
	bl AnimatorMDL__Init
	cmp r5, #0
	bne _02161AA4
	mov r3, #0
	ldr r0, _02161BA0 // =bossAssetFiles
	str r3, [sp]
	ldr r1, [r0]
	add r0, r6, #0x400
	mov r2, #1
	bl AnimatorMDL__SetResource
	b _02161AC8
_02161AA4:
	cmp r5, #1
	blo _02161AC8
	mov r3, #0
	ldr r0, _02161BA0 // =bossAssetFiles
	str r3, [sp]
	ldr r1, [r0]
	add r0, r6, #0x400
	mov r2, #2
	bl AnimatorMDL__SetResource
_02161AC8:
	mov r2, #0
	str r2, [r6, #0x448]
	str r2, [r6, #0x44c]
	ldr r0, _02161BA4 // =0x000034CC
	str r2, [r6, #0x450]
	str r0, [r6, #0x418]
	str r0, [r6, #0x41c]
	str r0, [r6, #0x420]
	mov r0, #4
	ldr r1, _02161BA8 // =BossHelpers__Model__RenderCallback
	strb r0, [r6, #0x40a]
	mov r7, #3
	add r0, r6, #0x490
	mov r3, #6
	str r7, [sp]
	bl NNS_G3dRenderObjSetCallBack
	cmp r5, #0
	bne _02161B2C
	mov r3, #0
	str r3, [sp]
	ldr r0, [r6, #0x494]
	ldr r1, _02161BAC // =aArmHit
	mov r2, #0x1d
	bl BossHelpers__Model__Init
	b _02161B4C
_02161B2C:
	cmp r5, #1
	bne _02161B4C
	mov r3, #0
	str r3, [sp]
	ldr r0, [r6, #0x494]
	ldr r1, _02161BAC // =aArmHit
	mov r2, #0x1d
	bl BossHelpers__Model__Init
_02161B4C:
	mov r1, #0x78000
	mov r0, r4
	str r1, [r4, #0x46c]
	mov r1, #0x32000
	str r1, [r4, #0x470]
	bl StageTask__InitSeqPlayer
	mov r0, r4
	mov r1, #0
	bl ovl01_2168F84
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02161B7C: .word StageTask_Main
_02161B80: .word ovl01_21685FC
_02161B84: .word ovl01_2168520
_02161B88: .word ovl01_2168620
_02161B8C: .word ovl01_2168704
_02161B90: .word _0217A82C
_02161B94: .word ovl01_21687E8
_02161B98: .word ovl01_2168AC4
_02161B9C: .word ovl01_2168D6C
_02161BA0: .word bossAssetFiles
_02161BA4: .word 0x000034CC
_02161BA8: .word BossHelpers__Model__RenderCallback
_02161BAC: .word aArmHit
	arm_func_end Boss3Arm__Create

	arm_func_start Boss3__SetInkSplatFlag
Boss3__SetInkSplatFlag: // 0x02161BB0
	stmdb sp!, {r3, lr}
	ldr r0, _02161BCC // =_0217AF88
	ldr r0, [r0]
	bl GetTaskWork_
	mov r1, #1
	str r1, [r0, #0x40c]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02161BCC: .word _0217AF88
	arm_func_end Boss3__SetInkSplatFlag

	arm_func_start ovl01_2161BD0
ovl01_2161BD0: // 0x02161BD0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x68
	mov r4, r0
	bl MapFarSys__GetAsset
	str r0, [r4]
	ldr r1, _02161C38 // =gameArchiveStage
	add r0, sp, #0
	ldr r2, [r1]
	ldr r1, _02161C3C // =aExc_3
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
	mov r1, #0x30
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0xc]
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	add sp, sp, #0x68
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161C38: .word gameArchiveStage
_02161C3C: .word aExc_3
	arm_func_end ovl01_2161BD0

	arm_func_start ovl01_2161C40
ovl01_2161C40: // 0x02161C40
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r2, _02161D54 // =gPlayer
	mov r5, r1
	add r4, sp, #0
	mov r3, #0
	ldr r2, [r2]
	str r3, [r4]
	str r3, [r4, #4]
	str r3, [r4, #8]
	mov r4, r0
	ldr r0, [r2, #0x44]
	ldr r2, _02161D58 // =0x006BAA99
	mov r1, #0x40000
	bl BossHelpers__Arena__Func_2038DCC
	sub r0, r5, r0
	mov r0, r0, lsl #0x10
	mov r5, r0, asr #0x10
	mov r0, r5, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0x8000
	blo _02161CFC
	bl GetSpatialAudioDropoffRate
	sub r1, r5, #0x8000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r1, asr #4
	ldr r1, _02161D5C // =FX_SinCosTable_
	mov r2, r2, lsl #2
	ldrsh r3, [r1, r2]
	ldr r2, _02161D54 // =gPlayer
	add r1, sp, #0
	smull ip, r3, r0, r3
	adds ip, ip, #0x800
	ldr lr, [r2]
	adc r0, r3, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r0, lsl #20
	ldr r3, [lr, #0x44]
	mov r0, r4
	sub r2, r3, r2
	str r2, [sp]
	bl ProcessSpatialSfx
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
_02161CFC:
	bl GetSpatialAudioDropoffRate
	mov r1, r6, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r1, asr #4
	ldr r1, _02161D5C // =FX_SinCosTable_
	mov r2, r2, lsl #2
	ldrsh r3, [r1, r2]
	ldr r2, _02161D54 // =gPlayer
	add r1, sp, #0
	smull ip, r3, r0, r3
	adds ip, ip, #0x800
	ldr lr, [r2]
	adc r0, r3, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r0, lsl #20
	ldr r3, [lr, #0x44]
	mov r0, r4
	add r2, r3, r2
	str r2, [sp]
	bl ProcessSpatialSfx
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02161D54: .word gPlayer
_02161D58: .word 0x006BAA99
_02161D5C: .word FX_SinCosTable_
	arm_func_end ovl01_2161C40

	arm_func_start ovl01_2161D60
ovl01_2161D60: // 0x02161D60
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	ldr r1, _02161E18 // =_0217AF88
	mov r4, r0
	ldr r0, [r1]
	bl GetTaskWork_
	ldr r1, [r4, #0x20]
	mov r5, r0
	tst r1, #0x20
	ldmneia sp!, {r3, r4, r5, pc}
	bl ovl01_2162918
	ldr r0, [r5, #0x40c]
	cmp r0, #0
	beq _02161DC0
	ldr r0, _02161E1C // =gPlayer
	ldr r1, [r5, #0x3cc]
	ldr r0, [r0]
	ldr r0, [r0, #0x48]
	cmp r0, r1
	ble _02161DBC
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _02161DC0
_02161DBC:
	bl ovl01_2162990
_02161DC0:
	ldr r2, _02161E20 // =0x006BAA99
	ldr r3, _02161E24 // =0x00107FC0
	mov r0, r4
	mov r1, #0x40000
	bl BossHelpers__Arena__Func_2038EBC
	mov r4, r0
	bl ovl01_2161E28
	add r0, r5, #0x24
	add r0, r0, #0x400
	bl BossHelpers__Light__SetLights1
	ldr r0, [r5, #0x41c]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, r4
	bl BossArena__SetAngleTarget
	mov r0, #2
	bl BossArena__GetCamera
	mov r1, r4
	bl BossArena__SetAngleTarget
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02161E18: .word _0217AF88
_02161E1C: .word gPlayer
_02161E20: .word 0x006BAA99
_02161E24: .word 0x00107FC0
	arm_func_end ovl01_2161D60

	arm_func_start ovl01_2161E28
ovl01_2161E28: // 0x02161E28
	stmdb sp!, {r3, lr}
	ldr r0, _02161E3C // =_0217AF88
	ldr r0, [r0, #4]
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02161E3C: .word _0217AF88
	arm_func_end ovl01_2161E28

	arm_func_start ovl01_2161E40
ovl01_2161E40: // 0x02161E40
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x1c]
	tst r1, #0x10
	ldmeqia sp!, {r4, pc}
	bl Player__Action_DestroyAttackRecoil
	add r0, r4, #0x500
	mov r1, #0x18
	strh r1, [r0, #0xfa]
	ldr r0, [r4, #0xbc]
	cmp r0, #0
	mov r0, #0x2000
	rsblt r0, r0, #0
	str r0, [r4, #0x98]
	mov r0, #0
	str r0, [r4, #0xc8]
	mov r0, #0x4000
	rsb r0, r0, #0
	str r0, [r4, #0x9c]
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2161E40

	arm_func_start ovl01_2161E90
ovl01_2161E90: // 0x02161E90
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x1c]
	tst r1, #0x10
	ldmeqia sp!, {r4, pc}
	bl Player__Action_DestroyAttackRecoil
	add r0, r4, #0x500
	mov r1, #0x18
	strh r1, [r0, #0xfa]
	ldr r0, [r4, #0xbc]
	cmp r0, #0
	mov r0, #0x2000
	rsblt r0, r0, #0
	str r0, [r4, #0x98]
	mov r0, #0
	str r0, [r4, #0xc8]
	mov r0, #0x5800
	rsb r0, r0, #0
	str r0, [r4, #0x9c]
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2161E90

	arm_func_start ovl01_2161EE0
ovl01_2161EE0: // 0x02161EE0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x1c]
	tst r1, #0x10
	ldmeqia sp!, {r4, pc}
	bl Player__Action_DestroyAttackRecoil
	add r0, r4, #0x500
	mov r1, #0x18
	strh r1, [r0, #0xfa]
	ldr r0, [r4, #0xbc]
	cmp r0, #0
	ble _02161F24
	mov r0, #0x2000
	str r0, [r4, #0x98]
	mov r0, #0
	str r0, [r4, #0xc8]
	b _02161F5C
_02161F24:
	bne _02161F48
	ldr r0, [r4, #0x20]
	tst r0, #1
	mov r0, #0x2000
	rsbne r0, r0, #0
	str r0, [r4, #0x98]
	mov r0, #0
	str r0, [r4, #0xc8]
	b _02161F5C
_02161F48:
	mov r0, #0x2000
	rsb r0, r0, #0
	str r0, [r4, #0x98]
	mov r0, #0
	str r0, [r4, #0xc8]
_02161F5C:
	mov r0, #0x5000
	rsb r0, r0, #0
	str r0, [r4, #0x9c]
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2161EE0

	arm_func_start ovl01_2161F6C
ovl01_2161F6C: // 0x02161F6C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r2, #0
	mov r1, #0x8c
	str r2, [sp]
	mov r4, r0
	str r1, [sp, #4]
	sub r1, r1, #0x8d
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x374]
	ldr r1, _02161FD0 // =0x0000FFFF
	ldr r2, [r0, #0x3c0]
	ldr r0, [r0, #0x138]
	mov r2, r2, lsl #6
	bl NNS_SndPlayerSetTrackPitch
	ldr r1, [r4, #0x374]
	ldr r0, [r1, #0x3c0]
	add r0, r0, #1
	str r0, [r1, #0x3c0]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161FD0: .word 0x0000FFFF
	arm_func_end ovl01_2161F6C

	arm_func_start ovl01_2161FD4
ovl01_2161FD4: // 0x02161FD4
	stmdb sp!, {r3, lr}
	ldr r1, _02161FF4 // =gPlayer
	ldr r1, [r1]
	ldr r1, [r1, #0x1c]
	tst r1, #1
	ldmeqia sp!, {r3, pc}
	bl ovl01_2161FF8
	ldmia sp!, {r3, pc}
	.align 2, 0
_02161FF4: .word gPlayer
	arm_func_end ovl01_2161FD4

	arm_func_start ovl01_2161FF8
ovl01_2161FF8: // 0x02161FF8
	mov r1, #0
	str r1, [r0, #0x3c0]
	bx lr
	arm_func_end ovl01_2161FF8

	arm_func_start ovl01_2162004
ovl01_2162004: // 0x02162004
	ldr ip, _02162014 // =BossFX__CreateHitA
	ldmia r0, {r1, r2, r3}
	mov r0, #0
	bx ip
	.align 2, 0
_02162014: .word BossFX__CreateHitA
	arm_func_end ovl01_2162004

	arm_func_start ovl01_2162018
ovl01_2162018: // 0x02162018
	ldr ip, _02162028 // =BossFX__CreateHitB
	ldmia r0, {r1, r2, r3}
	mov r0, #0
	bx ip
	.align 2, 0
_02162028: .word BossFX__CreateHitB
	arm_func_end ovl01_2162018

	arm_func_start ovl01_216202C
ovl01_216202C: // 0x0216202C
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
	arm_func_end ovl01_216202C

	arm_func_start ovl01_216208C
ovl01_216208C: // 0x0216208C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r1, _021622A4 // =_02179E00
	add r3, sp, #0
	mov r4, r0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #4
	bl BossArena__SetType
	mov r0, #1
	bl BossArena__GetCamera
	add r1, sp, #0
	mov r5, r0
	bl BossArena__SetUpVector
	mov r0, r5
	mov r1, #1
	bl BossArena__SetCameraType
	ldr r1, _021622A8 // =gPlayer
	mov r0, r5
	ldr r1, [r1]
	mov r2, #0
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	ldr r2, [r4, #0x3cc]
	mov r1, #0
	mov r0, r5
	mov r3, r1
	rsb r2, r2, #0x64000
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
	mov r1, #0xe6000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r5
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r5
	bl BossArena__ApplyAmplitudeXZTarget
	mov r0, r5
	mov r1, #0x5000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r5
	mov r1, #0x100
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r5
	bl BossArena__ApplyAmplitudeYTarget
	ldr r0, _021622A8 // =gPlayer
	ldr r2, _021622AC // =0x006BAA99
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
	mov r0, #2
	bl BossArena__GetCamera
	add r1, sp, #0
	mov r5, r0
	bl BossArena__SetUpVector
	mov r0, r5
	mov r1, #1
	bl BossArena__SetCameraType
	ldr r1, _021622A8 // =gPlayer
	mov r0, r5
	ldr r1, [r1]
	mov r2, #0
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	mov r1, #0
	ldr r4, [r4, #0x3cc]
	ldr r2, _021622B0 // =0xFFE3E000
	mov r0, r5
	mov r3, r1
	sub r2, r2, r4
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
	mov r1, #0xe6000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r5
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r5
	bl BossArena__ApplyAmplitudeXZTarget
	mov r0, r5
	mov r1, #0x64000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r5
	mov r1, #0x100
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r5
	bl BossArena__ApplyAmplitudeYTarget
	ldr r0, _021622A8 // =gPlayer
	mov r1, #0x40000
	ldr r0, [r0]
	ldr r2, _021622AC // =0x006BAA99
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
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_021622A4: .word _02179E00
_021622A8: .word gPlayer
_021622AC: .word 0x006BAA99
_021622B0: .word 0xFFE3E000
	arm_func_end ovl01_216208C

	arm_func_start ovl01_21622B4
ovl01_21622B4: // 0x021622B4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #0xe6000
	mov r4, r0
	bl BossArena__SetAmplitudeXZTarget
	ldr r2, [r5, #0x3cc]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	rsb r2, r2, #0x64000
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x5000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x80
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #0xe6000
	bl BossArena__SetAmplitudeXZTarget
	ldr ip, [r5, #0x3cc]
	mov r0, r4
	mov r1, #0
	ldr r2, _0216236C // =0xFFE3E000
	mov r3, r1
	sub r2, r2, ip
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x64000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x80
	mov r2, #0
	bl BossArena__SetTracker1Speed
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216236C: .word 0xFFE3E000
	arm_func_end ovl01_21622B4

	arm_func_start ovl01_2162370
ovl01_2162370: // 0x02162370
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #0xe6000
	mov r4, r0
	bl BossArena__SetAmplitudeXZTarget
	ldr r2, [r5, #0x3cc]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	rsb r2, r2, #0x64000
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x5000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #0xe6000
	bl BossArena__SetAmplitudeXZTarget
	ldr ip, [r5, #0x3cc]
	mov r0, r4
	mov r1, #0
	ldr r2, _02162428 // =0xFFE3E000
	mov r3, r1
	sub r2, r2, ip
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x64000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02162428: .word 0xFFE3E000
	arm_func_end ovl01_2162370

	arm_func_start ovl01_216242C
ovl01_216242C: // 0x0216242C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	ldr r1, _021624E4 // =0x00136000
	mov r4, r0
	bl BossArena__SetAmplitudeXZTarget
	ldr r2, [r5, #0x3cc]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	rsb r2, r2, #0x64000
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x5000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	ldr r1, _021624E4 // =0x00136000
	bl BossArena__SetAmplitudeXZTarget
	ldr ip, [r5, #0x3cc]
	mov r0, r4
	mov r1, #0
	ldr r2, _021624E8 // =0xFFE3E000
	mov r3, r1
	sub r2, r2, ip
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x64000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021624E4: .word 0x00136000
_021624E8: .word 0xFFE3E000
	arm_func_end ovl01_216242C

	arm_func_start ovl01_21624EC
ovl01_21624EC: // 0x021624EC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	ldr r1, _021625C4 // =0x00136000
	mov r4, r0
	bl BossArena__SetAmplitudeXZTarget
	mov r1, #0
	ldr r3, [r5, #0x3cc]
	sub r2, r1, #0x64000
	mov r0, r4
	sub r2, r2, r3
	mov r3, r1
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0xc8000
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x80
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeYSpeed
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	ldr r1, _021625C4 // =0x00136000
	bl BossArena__SetAmplitudeXZTarget
	ldr r3, [r5, #0x3cc]
	mov r0, r4
	mov r1, #0
	sub r2, r1, #0x1f4000
	sub r2, r2, r3
	mov r3, r1
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0xc8000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x80
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeYSpeed
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021625C4: .word 0x00136000
	arm_func_end ovl01_21624EC

	arm_func_start ovl01_21625C8
ovl01_21625C8: // 0x021625C8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #0xe6000
	mov r4, r0
	bl BossArena__SetAmplitudeXZTarget
	ldr r2, [r5, #0x3cc]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	rsb r2, r2, #0x1f4000
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0xc8000
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x80
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #0xe6000
	bl BossArena__SetAmplitudeXZTarget
	ldr r1, [r5, #0x3c4]
	mov r0, r4
	rsb r2, r1, #0x64000
	mov r1, #0
	mov r3, r1
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x5000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x80
	mov r2, #0
	bl BossArena__SetTracker1Speed
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_21625C8

	arm_func_start ovl01_2162680
ovl01_2162680: // 0x02162680
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #0xe6000
	mov r4, r0
	bl BossArena__SetAmplitudeXZTarget
	ldr r2, [r5, #0x3cc]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	rsb r2, r2, #0x1f4000
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0xc8000
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #0xe6000
	bl BossArena__SetAmplitudeXZTarget
	ldr r1, [r5, #0x3c4]
	mov r0, r4
	rsb r2, r1, #0x64000
	mov r1, #0
	mov r3, r1
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x5000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_2162680

	arm_func_start ovl01_2162738
ovl01_2162738: // 0x02162738
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #0xe6000
	mov r4, r0
	bl BossArena__SetAmplitudeXZTarget
	ldr r2, [r5, #0x3cc]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	rsb r2, r2, #0x1f4000
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0xc8000
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x80
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #0xe6000
	bl BossArena__SetAmplitudeXZTarget
	ldr r1, [r5, #0x3c4]
	mov r0, r4
	rsb r2, r1, #0x64000
	mov r1, #0
	mov r3, r1
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x5000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x80
	mov r2, #0
	bl BossArena__SetTracker1Speed
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_2162738

	arm_func_start ovl01_21627F0
ovl01_21627F0: // 0x021627F0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r0, #2
	bl BossArena__GetCamera
	ldr r1, [r5, #0x398]
	add r3, sp, #0
	add r1, r1, #0x4c0
	mov r4, r0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0
	mov r3, #1
	str r3, [r5, #0x41c]
	mov r0, r4
	mov r2, r1
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	ldr r1, [sp]
	ldr r2, [sp, #4]
	ldr r3, [sp, #8]
	mov r0, r4
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x32000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0xb4000
	bl BossArena__SetAmplitudeXZTarget
	ldr r1, [r5, #0x398]
	mov r0, r4
	add r1, r1, #0x400
	ldrh r1, [r1, #0x44]
	sub r1, r1, #0x2000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl BossArena__SetAngleTarget
	mov r1, #0xcc
	mov r0, r4
	mov r2, r1
	bl BossArena__SetTracker1Speed
	mov r1, #0xcc
	mov r0, r4
	mov r2, r1
	bl BossArena__SetTracker0Speed
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end ovl01_21627F0

	arm_func_start ovl01_21628AC
ovl01_21628AC: // 0x021628AC
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	mov r0, #0
	mov r2, #0x32
	mov r6, r1
	bl MIi_CpuClear16
	mov r5, r6
	mov r4, #0
_021628CC:
	ldr r0, [r7, #0x370]
	mov r1, r5
	mov r2, r4
	bl GetDrawStateLight
	mov r0, r4, lsl #3
	add r2, r6, r4, lsl #3
	ldrh r1, [r6, r0]
	ldrh r0, [r2, #2]
	add r4, r4, #1
	cmp r4, #3
	strh r1, [r2, #0x18]
	strh r0, [r2, #0x1a]
	ldrh r1, [r2, #4]
	ldrh r0, [r2, #6]
	add r5, r5, #8
	strh r1, [r2, #0x1c]
	strh r0, [r2, #0x1e]
	blt _021628CC
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end ovl01_21628AC

	arm_func_start ovl01_2162918
ovl01_2162918: // 0x02162918
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r0, #1
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	mov r5, r0
	mov r0, #2
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	mov r6, r0
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _02162960
	ldr r1, [r5, #0x24]
	ldr r0, [r4, #0x3cc]
	rsb r1, r1, #0
	cmp r1, r0
	bge _02162980
_02162960:
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #0x24]
	ldr r0, [r4, #0x3cc]
	rsb r1, r1, #0
	cmp r1, r0
	ldmltia sp!, {r4, r5, r6, pc}
_02162980:
	add r0, r4, #0x56
	add r0, r0, #0x400
	bl BossHelpers__Light__SetLights2
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl01_2162918

	arm_func_start ovl01_2162990
ovl01_2162990: // 0x02162990
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r7, #0
	mov r4, #0x1000
	rsb r4, r4, #0
	add r6, sp, #0
	mov r5, r7
_021629AC:
	mov r0, r7
	mov r1, r6
	strh r5, [sp]
	strh r4, [sp, #2]
	strh r5, [sp, #4]
	strh r5, [sp, #6]
	bl Camera3D__SetLight
	add r7, r7, #1
	cmp r7, #3
	blt _021629AC
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end ovl01_2162990

	arm_func_start ovl01_21629DC
ovl01_21629DC: // 0x021629DC
	ldr r1, _02162A30 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r1, [r1, #0x70]
	cmpeq r1, #0xf
	moveq r0, #3
	bxeq lr
	add r0, r0, #0x300
	ldrsh r3, [r0, #0xb8]
	ldr r2, _02162A34 // =_02179DB0
	mov r0, #0
_02162A08:
	mov r1, r0, lsl #1
	ldrh r1, [r2, r1]
	cmp r1, r3
	bxlt lr
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #3
	blo _02162A08
	bx lr
	.align 2, 0
_02162A30: .word gameState
_02162A34: .word _02179DB0
	arm_func_end ovl01_21629DC

	arm_func_start ovl01_2162A38
ovl01_2162A38: // 0x02162A38
	ldr r0, _02162A4C // =gameState
	ldr r1, _02162A50 // =_02179DCC
	ldr r0, [r0, #0x18]
	ldr r0, [r1, r0, lsl #2]
	bx lr
	.align 2, 0
_02162A4C: .word gameState
_02162A50: .word _02179DCC
	arm_func_end ovl01_2162A38

	arm_func_start ovl01_2162A54
ovl01_2162A54: // 0x02162A54
	stmdb sp!, {r3, lr}
	bl ovl01_21629DC
	ldr r1, _02162A6C // =_02179DC4
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02162A6C: .word _02179DC4
	arm_func_end ovl01_2162A54

	arm_func_start ovl01_2162A70
ovl01_2162A70: // 0x02162A70
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl ovl01_2162A38
	mov r4, r0
	mov r0, r5
	bl ovl01_2162A54
	mul r0, r4, r0
	mov r0, r0, lsl #4
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_2162A70

	arm_func_start ovl01_2162A98
ovl01_2162A98: // 0x02162A98
	stmdb sp!, {r3, lr}
	bl ovl01_21629DC
	ldr r1, _02162AAC // =_02179E1C
	ldr r0, [r1, r0, lsl #2]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02162AAC: .word _02179E1C
	arm_func_end ovl01_2162A98

	arm_func_start ovl01_2162AB0
ovl01_2162AB0: // 0x02162AB0
	stmdb sp!, {r3, lr}
	bl ovl01_21629DC
	ldr r1, _02162AC8 // =_02179DE4
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02162AC8: .word _02179DE4
	arm_func_end ovl01_2162AB0

	arm_func_start ovl01_2162ACC
ovl01_2162ACC: // 0x02162ACC
	stmdb sp!, {r3, lr}
	bl ovl01_21629DC
	ldr r1, _02162AE4 // =_02179DBC
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02162AE4: .word _02179DBC
	arm_func_end ovl01_2162ACC

	arm_func_start ovl01_2162AE8
ovl01_2162AE8: // 0x02162AE8
	stmdb sp!, {r3, lr}
	bl ovl01_21629DC
	ldr r1, _02162B00 // =_02179DDC
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02162B00: .word _02179DDC
	arm_func_end ovl01_2162AE8

	arm_func_start ovl01_2162B04
ovl01_2162B04: // 0x02162B04
	stmdb sp!, {r3, lr}
	bl ovl01_21629DC
	ldr r1, _02162B1C // =_02179DD4
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02162B1C: .word _02179DD4
	arm_func_end ovl01_2162B04

	arm_func_start ovl01_2162B20
ovl01_2162B20: // 0x02162B20
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, _02162B9C // =_mt_math_rand
	mov r3, #0
	ldr r5, [r4]
	ldr ip, _02162BA0 // =0x00196225
	ldr lr, _02162BA4 // =0x3C6EF35F
	mov r2, r3
	mla lr, r5, ip, lr
	mov ip, lr, lsr #0x10
	mov ip, ip, lsl #0x10
	str lr, [r4]
	cmp r1, #0
	mov r5, ip, lsr #0x10
	bls _02162B8C
_02162B58:
	mov r4, r2, lsl #1
	ldrh r4, [r0, r4]
	add r3, r3, r4
	mov r3, r3, lsl #0x10
	cmp r5, r3, lsr #16
	mov r3, r3, lsr #0x10
	movls r0, r2
	ldmlsia sp!, {r3, r4, r5, pc}
	add r2, r2, #1
	mov r2, r2, lsl #0x10
	cmp r1, r2, lsr #16
	mov r2, r2, lsr #0x10
	bhi _02162B58
_02162B8C:
	sub r0, r2, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02162B9C: .word _mt_math_rand
_02162BA0: .word 0x00196225
_02162BA4: .word 0x3C6EF35F
	arm_func_end ovl01_2162B20

	arm_func_start ovl01_2162BA8
ovl01_2162BA8: // 0x02162BA8
	stmdb sp!, {r3, lr}
	bl ovl01_21629DC
	ldr r2, _02162BCC // =_02179E5C
	mov r1, #6
	mla r0, r1, r0, r2
	mov r1, #3
	bl ovl01_2162B20
	and r0, r0, #0xff
	ldmia sp!, {r3, pc}
	.align 2, 0
_02162BCC: .word _02179E5C
	arm_func_end ovl01_2162BA8

	arm_func_start ovl01_2162BD0
ovl01_2162BD0: // 0x02162BD0
	stmdb sp!, {r3, lr}
	bl ovl01_21629DC
	ldr r2, _02162BF0 // =_02179E4C
	mov r1, #2
	add r0, r2, r0, lsl #2
	bl ovl01_2162B20
	and r0, r0, #0xff
	ldmia sp!, {r3, pc}
	.align 2, 0
_02162BF0: .word _02179E4C
	arm_func_end ovl01_2162BD0

	arm_func_start ovl01_2162BF4
ovl01_2162BF4: // 0x02162BF4
	stmdb sp!, {r4, r5, r6, lr}
	ldr r5, _02162C30 // =_02179DB6
	mov r6, r0
	mov r4, #3
_02162C04:
	mov r0, r5
	mov r1, r4
	bl ovl01_2162B20
	and r0, r0, #0xff
	cmp r0, #2
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #0x374]
	ldr r1, [r1, #0xaec]
	cmp r1, #0
	bne _02162C04
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02162C30: .word _02179DB6
	arm_func_end ovl01_2162BF4

	arm_func_start ovl01_2162C34
ovl01_2162C34: // 0x02162C34
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r11, r0
	add r1, r11, #0xaf0
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	ldrb r0, [r11, #0xadc]
	cmp r0, #2
	bne _02162CAC
	ldr r2, _02162DD0 // =_mt_math_rand
	ldr r0, _02162DD4 // =0x00196225
	ldr r4, [r2]
	ldr r1, _02162DD8 // =0x3C6EF35F
	ldr r3, _02162DDC // =_02179E3C
	mla r1, r4, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #1
	mov r0, r0, lsl #0x10
	movs r0, r0, lsr #0x10
	str r1, [r2]
	ldr r0, [r3, r0, lsl #2]
	moveq r1, #1
	str r0, [r11, #0xaf0]
	ldr r0, _02162DDC // =_02179E3C
	movne r1, #0
	ldr r0, [r0, r1, lsl #2]
	str r0, [r11, #0xaf4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02162CAC:
	cmp r0, #4
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, _02162DE0 // =_02179D9C
	mov r8, #0
	ldrb r2, [r0]
	ldrb r1, [r0, #1]
	strb r2, [sp]
	strb r1, [sp, #1]
	ldrb r1, [r0, #2]
	ldrb r0, [r0, #3]
	strb r1, [sp, #2]
	strb r0, [sp, #3]
_02162CDC:
	ldr r6, _02162DD0 // =_mt_math_rand
	ldr r4, _02162DD4 // =0x00196225
	ldr r5, _02162DD8 // =0x3C6EF35F
	add r10, sp, #1
	mov r7, #1
	add r9, sp, #0
_02162CF4:
	ldr r0, [r6]
	mov r1, r7
	mla r2, r0, r4, r5
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r2, [r6]
	bl FX_ModS32
	cmp r0, #0
	ldr r0, [r6]
	mov r1, r7
	bge _02162D44
	mla r2, r0, r4, r5
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r2, [r6]
	bl FX_ModS32
	rsb r0, r0, #0
	b _02162D5C
_02162D44:
	mla r2, r0, r4, r5
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r2, [r6]
	bl FX_ModS32
_02162D5C:
	mov r0, r0, lsl #0x10
	ldrb r2, [r9, r0, lsr #16]
	ldrb r1, [r10]
	add r7, r7, #1
	cmp r7, #4
	eor r1, r2, r1
	strb r1, [r9, r0, lsr #16]
	ldrb r2, [r10]
	and r1, r1, #0xff
	eor r1, r2, r1
	strb r1, [r10], #1
	ldrb r2, [r9, r0, lsr #16]
	and r1, r1, #0xff
	eor r1, r2, r1
	strb r1, [r9, r0, lsr #16]
	blt _02162CF4
	add r8, r8, #1
	cmp r8, #5
	blt _02162CDC
	ldr r2, _02162DDC // =_02179E3C
	mov r3, #0
_02162DB0:
	ldrb r1, [r9], #1
	add r0, r11, r3, lsl #2
	add r3, r3, #1
	ldr r1, [r2, r1, lsl #2]
	cmp r3, #4
	str r1, [r0, #0xaf0]
	blt _02162DB0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02162DD0: .word _mt_math_rand
_02162DD4: .word 0x00196225
_02162DD8: .word 0x3C6EF35F
_02162DDC: .word _02179E3C
_02162DE0: .word _02179D9C
	arm_func_end ovl01_2162C34

	arm_func_start ovl01_2162DE4
ovl01_2162DE4: // 0x02162DE4
	stmdb sp!, {r3, lr}
	ldr r0, _02162DFC // =_02179DA4
	mov r1, #3
	bl ovl01_2162B20
	and r0, r0, #0xff
	ldmia sp!, {r3, pc}
	.align 2, 0
_02162DFC: .word _02179DA4
	arm_func_end ovl01_2162DE4

	arm_func_start ovl01_2162E00
ovl01_2162E00: // 0x02162E00
	stmdb sp!, {r4, lr}
	bl ovl01_21629DC
	ldr r2, _02162E34 // =_02179E0C
	mov r1, #2
	add r0, r2, r0, lsl #2
	bl ovl01_2162B20
	ands r0, r0, #0xff
	moveq r4, #2
	beq _02162E2C
	cmp r0, #1
	moveq r4, #4
_02162E2C:
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162E34: .word _02179E0C
	arm_func_end ovl01_2162E00

	arm_func_start ovl01_2162E38
ovl01_2162E38: // 0x02162E38
	ldr r3, _02162EAC // =_mt_math_rand
	ldr r1, _02162EB0 // =0x00196225
	ldr ip, [r3]
	ldr r2, _02162EB4 // =0x3C6EF35F
	mla r2, ip, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #1
	mov r1, r1, lsl #0x10
	str r2, [r3]
	movs r1, r1, lsr #0x10
	ldr r1, [r0, #0xa3c]
	movne r3, #1
	ldrne r2, [r1, #0x398]
	movne r1, #0
	strne r3, [r2, #0x478]
	ldrne r0, [r0, #0xa3c]
	ldrne r0, [r0, #0x39c]
	strne r1, [r0, #0x478]
	bxne lr
	ldr r2, [r1, #0x398]
	mov r3, #0
	mov r1, #1
	str r3, [r2, #0x478]
	ldr r0, [r0, #0xa3c]
	ldr r0, [r0, #0x39c]
	str r1, [r0, #0x478]
	bx lr
	.align 2, 0
_02162EAC: .word _mt_math_rand
_02162EB0: .word 0x00196225
_02162EB4: .word 0x3C6EF35F
	arm_func_end ovl01_2162E38

	arm_func_start ovl01_2162EB8
ovl01_2162EB8: // 0x02162EB8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x374]
	add r0, r0, #0xa00
	ldrh r1, [r0, #0xf2]
	cmp r1, #2
	movhs r1, #0
	strhsh r1, [r0, #0xf2]
	mov r0, r4
	bl ovl01_21629DC
	ldr r1, [r4, #0x374]
	ldr r2, _02162F0C // =_02179E2C
	add r1, r1, #0xa00
	ldrh r3, [r1, #0xf2]
	add r0, r2, r0, lsl #2
	mov r2, r3, lsl #1
	ldrh r2, [r2, r0]
	add r0, r3, #1
	strh r0, [r1, #0xf2]
	and r0, r2, #0xff
	ldmia sp!, {r4, pc}
	.align 2, 0
_02162F0C: .word _02179E2C
	arm_func_end ovl01_2162EB8

	arm_func_start ovl01_2162F10
ovl01_2162F10: // 0x02162F10
	mov r0, #2
	bx lr
	arm_func_end ovl01_2162F10

	arm_func_start ovl01_2162F18
ovl01_2162F18: // 0x02162F18
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl01_2161FD4
	ldr r0, [r4, #0x420]
	cmp r0, #0
	bne _02162F38
	mov r0, r4
	bl ovl01_216202C
_02162F38:
	add r0, r4, #0x24
	add r0, r0, #0x400
	bl BossHelpers__Light__Func_203954C
	ldr r1, [r4, #0x3b4]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2162F18

	arm_func_start ovl01_2162F54
ovl01_2162F54: // 0x02162F54
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x68
	mov r4, r0
	bl GetTaskWork_
	mov r5, r0
	add r0, r5, #0x108
	add r7, r0, #0x400
	mov r6, #0
_02162F74:
	mov r0, r7
	bl AnimatorMDL__Release
	add r6, r6, #1
	cmp r6, #4
	add r7, r7, #0x144
	blt _02162F74
	bl EnableSpatialVolume
	ldr r1, _0216301C // =gameArchiveStage
	add r0, sp, #0
	ldr r2, [r1]
	ldr r1, _02163020 // =aExc_3
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #0x19
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultRelease
	add r0, sp, #0
	mov r1, #0x1c
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultRelease
	add r0, sp, #0
	mov r1, #0x20
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultRelease
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	add r0, r5, #0x218
	add r5, r0, #0x800
	mov r6, #0
_02162FE8:
	mov r0, r5
	bl AnimatorSprite3D__Release
	add r6, r6, #1
	cmp r6, #5
	add r5, r5, #0x104
	blt _02162FE8
	ldr r1, _02163024 // =renderCoreSwapBuffer
	mov r2, #0
	mov r0, r4
	str r2, [r1, #4]
	bl GameObject__Destructor
	add sp, sp, #0x68
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216301C: .word gameArchiveStage
_02163020: .word aExc_3
_02163024: .word renderCoreSwapBuffer
	arm_func_end ovl01_2162F54

	arm_func_start ovl01_2163028
ovl01_2163028: // 0x02163028
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bl GetCurrentTaskWork_
	mov r7, r0
	ldr r0, [r7, #0x20]
	tst r0, #0x20
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r0, r7, #0x24
	add r0, r0, #0x400
	bl BossHelpers__Light__SetLights2
	mov r0, r7
	bl ovl01_2162918
	ldr r2, [r7, #0x3c4]
	add r0, r7, #0x108
	mov r1, #0
	str r1, [r0, #0x448]
	rsb r2, r2, #0
	str r2, [r0, #0x44c]
	str r1, [r0, #0x450]
	add r0, r0, #0x400
	bl AnimatorMDL__Draw
	ldr r2, [r7, #0x3cc]
	add r0, r7, #0x24c
	mov r1, #0
	str r1, [r0, #0x448]
	rsb r2, r2, #0
	str r2, [r0, #0x44c]
	str r1, [r0, #0x450]
	add r0, r0, #0x400
	bl AnimatorMDL__Draw
	ldr r0, [r7, #0x3cc]
	mov r1, #0
	str r1, [r7, #0x7d8]
	rsb r0, r0, #0
	str r0, [r7, #0x7dc]
	add r0, r7, #0x790
	str r1, [r7, #0x7e0]
	bl AnimatorMDL__ProcessAnimation
	add r0, r7, #0x790
	bl AnimatorMDL__Draw
	ldr r0, [r7, #0x3cc]
	add r4, r7, #0xd4
	mov r1, #0
	str r1, [r4, #0x848]
	rsb r0, r0, #0
	str r0, [r4, #0x84c]
	add r0, r4, #0x800
	str r1, [r4, #0x850]
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #0x800
	bl AnimatorMDL__Draw
	mov r0, #1
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	ldr r0, [r7, #0x3cc]
	ldr r1, [r7, #0x3c4]
	add r0, r0, #0x32000
	cmp r1, r0
	ble _021631C0
	mov r8, #0
	add r0, r7, #0x218
	ldr r10, _021631DC // =_02179E74
	add r9, r0, #0x800
	mov r6, r8
	mov r5, r8
	mov r4, #0x78
_0216312C:
	add r1, r7, r8, lsl #2
	ldr r0, [r1, #0xf40]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r1, #0xf40]
	bne _021631AC
	ldr r2, [r7, #0x3c4]
	ldr r1, [r1, #0xf2c]
	ldmia r10, {r0, r3}
	sub r2, r3, r2
	str r0, [r9, #0x48]
	add r0, r2, r1
	str r0, [r9, #0x4c]
	ldr r3, [r10, #8]
	mov r0, r9
	mov r1, r6
	mov r2, r6
	str r3, [r9, #0x50]
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, [r9, #0xcc]
	tst r0, #0x40000000
	beq _02163194
	add r0, r7, r8, lsl #2
	str r5, [r0, #0xf2c]
	str r4, [r0, #0xf40]
	b _021631AC
_02163194:
	add r2, r7, r8, lsl #2
	ldr r1, [r2, #0xf2c]
	mov r0, r9
	add r1, r1, #0x2000
	str r1, [r2, #0xf2c]
	bl AnimatorSprite3D__Draw
_021631AC:
	add r8, r8, #1
	cmp r8, #5
	add r9, r9, #0x104
	add r10, r10, #0xc
	blt _0216312C
_021631C0:
	add r0, r7, #0x24
	add r0, r0, #0x400
	bl BossHelpers__Light__SetLights1
	add r1, r7, #0x3dc
	mov r0, #0x1e
	bl BossHelpers__Model__SetMatrixMode
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_021631DC: .word _02179E74
	arm_func_end ovl01_2163028

	arm_func_start ovl01_21631E0
ovl01_21631E0: // 0x021631E0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl ovl01_216208C
	ldr r2, _021633E4 // =0x0400000A
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
	ldr r2, _021633E8 // =VRAMSystem__VRAM_BG
	mov r1, #0
	ldr r2, [r2]
	add r2, r2, #0x4000
	bl LoadCompressedPixels
	ldr r0, [r5, #0x364]
	bl GetBackgroundPalette
	ldr r2, _021633EC // =VRAMSystem__VRAM_PALETTE_BG
	mov r1, #0
	ldr r2, [r2]
	bl LoadCompressedPalette
	mov r0, #0
	sub r1, r0, #0x104
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
	ldrh r2, [r4, #0x20]
	ldrh r3, [r0, #0x7c]
	ldr r1, _021633F0 // =gPlayer
	mov r2, r2, lsl #0x16
	mov r2, r2, lsr #0x1f
	bic r3, r3, #0x200
	mov r2, r2, lsl #0x1f
	orr r2, r3, r2, lsr #22
	strh r2, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	orr r2, r2, #0x400
	strh r2, [r4, #0x20]
	ldrh r2, [r4, #0x20]
	ldrh r3, [r0, #0x7c]
	mov r2, r2, lsl #0x15
	mov r2, r2, lsr #0x1f
	bic r3, r3, #0x400
	mov r2, r2, lsl #0x1f
	orr r2, r3, r2, lsr #21
	strh r2, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	orr r2, r2, #0x800
	strh r2, [r4, #0x20]
	ldrh r2, [r4, #0x20]
	ldrh r3, [r0, #0x7c]
	mov r2, r2, lsl #0x14
	mov r2, r2, lsr #0x1f
	bic r3, r3, #0x800
	mov r2, r2, lsl #0x1f
	orr r2, r3, r2, lsr #20
	strh r2, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	orr r2, r2, #0x1000
	strh r2, [r4, #0x20]
	ldrh r2, [r4, #0x20]
	ldrh r3, [r0, #0x7c]
	mov r2, r2, lsl #0x13
	mov r2, r2, lsr #0x1f
	bic r3, r3, #0x1000
	mov r2, r2, lsl #0x1f
	orr r2, r3, r2, lsr #19
	strh r2, [r0, #0x7c]
	ldr r0, [r1]
	bl BossPlayerHelpers_Action_SetBoss3DefendEvent
	ldr r2, _021633F0 // =gPlayer
	ldr r1, _021633F4 // =_0217AF88
	ldr ip, [r2]
	ldr r3, _021633F8 // =ovl01_2161D60
	ldr r4, [ip, #0xfc]
	add r0, r5, #0x300
	str r4, [r1, #4]
	str r3, [ip, #0xfc]
	ldr r2, [r2]
	ldr r1, [r2, #0x20]
	orr r1, r1, #0x2000
	str r1, [r2, #0x20]
	ldrsh r0, [r0, #0xb8]
	bl UpdateBossHealthHUD
	mov r0, #0
	bl SetHUDActiveScreen
	ldr r0, _021633FC // =ovl01_2163400
	str r0, [r5, #0x3b4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021633E4: .word 0x0400000A
_021633E8: .word VRAMSystem__VRAM_BG
_021633EC: .word VRAMSystem__VRAM_PALETTE_BG
_021633F0: .word gPlayer
_021633F4: .word _0217AF88
_021633F8: .word ovl01_2161D60
_021633FC: .word ovl01_2163400
	arm_func_end ovl01_21631E0

	arm_func_start ovl01_2163400
ovl01_2163400: // 0x02163400
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl01_216208C
	ldr r0, _02163418 // =ovl01_216341C
	str r0, [r4, #0x3b4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02163418: .word ovl01_216341C
	arm_func_end ovl01_2163400

	arm_func_start ovl01_216341C
ovl01_216341C: // 0x0216341C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x374]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl TitleCard__GetProgress
	cmp r0, #5
	ldmneia sp!, {r4, pc}
	mov r1, #0
	ldr r0, _02163450 // =ovl01_2163454
	str r1, [r4, #0x414]
	str r0, [r4, #0x3b4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02163450: .word ovl01_2163454
	arm_func_end ovl01_216341C

	arm_func_start ovl01_2163454
ovl01_2163454: // 0x02163454
	bx lr
	arm_func_end ovl01_2163454

	arm_func_start ovl01_2163458
ovl01_2163458: // 0x02163458
	add r0, r0, #0x300
	ldrsh r3, [r0, #0xba]
	ldr r2, _02163490 // =_02179DA0
	mov r0, #0
_02163468:
	mov r1, r0, lsl #1
	ldrh r1, [r2, r1]
	cmp r1, r3
	bxgt lr
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #2
	blo _02163468
	bx lr
	.align 2, 0
_02163490: .word _02179DA0
	arm_func_end ovl01_2163458

	arm_func_start ovl01_2163494
ovl01_2163494: // 0x02163494
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r2
	mov r6, r0
	cmp r1, r5
	add r4, r1, r5
	bge _02163548
	ldr r1, [r6, #0x3c4]
	ldr r0, [r6, #0x3cc]
	sub r1, r1, #0x14000
	cmp r0, r1
	ble _021634F4
	ldr r0, [r6, #0x3d0]
	cmp r0, r1
	bge _021634F4
	mov r1, #0
	mov r0, #0xa7
	str r1, [sp]
	sub r1, r0, #0xa8
	str r0, [sp, #4]
	ldr r0, [r6, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_021634F4:
	ldr r0, [r6, #0x3cc]
	cmp r0, r4, asr #1
	ldr r0, [r6, #0x3c8]
	blt _0216353C
	sub r0, r0, #0x400
	str r0, [r6, #0x3c8]
	cmp r0, #0
	ble _02163520
	ldr r0, [r6, #0x3cc]
	cmp r0, r5
	blt _021635E0
_02163520:
	mov r0, #0
	str r0, [r6, #0x3c8]
	str r5, [r6, #0x3d0]
	add sp, sp, #8
	str r5, [r6, #0x3cc]
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_0216353C:
	add r0, r0, #0x400
	str r0, [r6, #0x3c8]
	b _021635E0
_02163548:
	cmp r1, r5
	blt _021635E0
	ldr r1, [r6, #0x3c4]
	ldr r0, [r6, #0x3cc]
	sub r1, r1, #0x14000
	cmp r0, r1
	bge _02163594
	ldr r0, [r6, #0x3d0]
	cmp r0, r1
	ble _02163594
	mov r1, #0
	mov r0, #0xa8
	str r1, [sp]
	sub r1, r0, #0xa9
	str r0, [sp, #4]
	ldr r0, [r6, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02163594:
	ldr r0, [r6, #0x3cc]
	cmp r0, r4, asr #1
	ldr r0, [r6, #0x3c8]
	bgt _021635D8
	adds r0, r0, #0x400
	str r0, [r6, #0x3c8]
	bpl _021635BC
	ldr r0, [r6, #0x3cc]
	cmp r0, r5
	bgt _021635E0
_021635BC:
	mov r0, #0
	str r0, [r6, #0x3c8]
	str r5, [r6, #0x3d0]
	add sp, sp, #8
	str r5, [r6, #0x3cc]
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_021635D8:
	sub r0, r0, #0x400
	str r0, [r6, #0x3c8]
_021635E0:
	ldr r1, [r6, #0x3cc]
	mov r0, #0
	str r1, [r6, #0x3d0]
	ldr r2, [r6, #0x3cc]
	ldr r1, [r6, #0x3c8]
	add r1, r2, r1
	str r1, [r6, #0x3cc]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl01_2163494

	arm_func_start ovl01_2163604
ovl01_2163604: // 0x02163604
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x30
	mov r10, r0
	add r8, r10, #0x3a8
	mov r5, #0
	mov r6, r10
	mov r7, r5
	mov r9, r8
	add r4, r10, #0xb30
	add r11, r10, #0xa00
_0216362C:
	add r3, r6, #0x3a8
	ldmia r4, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r6, #0x3b0]
	add r0, sp, #0
	add r1, r1, #0x4a000
	add r1, r1, #0x100000
	str r1, [r6, #0x3b0]
	ldr r1, [r10, #0xa3c]
	ldr r1, [r1, #0x3c4]
	add r1, r1, #0xff0
	add r1, r1, #0x41000
	str r1, [r6, #0x3ac]
	ldrh r1, [r11, #0xd6]
	add r1, r1, #0x2000
	sub r1, r1, r7
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	ldr r1, _021637EC // =FX_SinCosTable_
	mov r3, r2, lsl #1
	ldrsh r1, [r1, r3]
	ldr r3, _021637EC // =FX_SinCosTable_
	add r2, r3, r2, lsl #1
	ldrsh r2, [r2, #2]
	bl MTX_RotY43_
	mov r0, r9
	add r1, sp, #0
	mov r2, r8
	bl MTX_MultVec43
	add r5, r5, #1
	add r6, r6, #0x364
	add r7, r7, #0x4000
	add r8, r8, #0x364
	add r9, r9, #0x364
	cmp r5, #2
	blt _0216362C
	ldr r1, [r10, #0xa3c]
	ldr r0, [r1, #0x410]
	cmp r0, #0
	beq _02163720
	ldr r0, [r10, #0xa4c]
	cmp r0, #0
	cmpne r0, #7
	bne _02163720
	mov r0, r10
	mov r1, #0xe
	bl ovl01_2163D10
	ldr r0, [r10, #0xa3c]
	mov r1, #0
	str r1, [r0, #0x410]
	ldr r0, [r10, #0xa3c]
	add r0, r0, #0x300
	strh r1, [r0, #0xba]
	ldr r0, [r10, #0xa3c]
	add r0, r0, #0x300
	strh r1, [r0, #0xbe]
	b _021637B8
_02163720:
	add r0, r1, #0x300
	ldrsh r0, [r0, #0xba]
	cmp r0, #9
	blt _0216375C
	ldr r0, [r10, #0xa4c]
	cmp r0, #0
	bne _0216375C
	mov r0, r10
	mov r1, #0xb
	bl ovl01_2163E28
	ldr r0, [r10, #0xa3c]
	mov r1, #0
	add r0, r0, #0x300
	strh r1, [r0, #0xba]
	b _021637B8
_0216375C:
	add r0, r1, #0x300
	ldrsh r0, [r0, #0xbe]
	cmp r0, #7
	blt _02163798
	ldr r0, [r10, #0xa4c]
	cmp r0, #7
	bne _02163798
	mov r0, r10
	mov r1, #0xc
	bl ovl01_2163E28
	ldr r0, [r10, #0xa3c]
	mov r1, #0
	add r0, r0, #0x300
	strh r1, [r0, #0xbe]
	b _021637B8
_02163798:
	ldr r1, [r10, #0xa40]
	mov r0, r10
	blx r1
	ldr r1, [r10, #0xa44]
	cmp r1, #0
	beq _021637B8
	mov r0, r10
	blx r1
_021637B8:
	ldr r1, [r10, #0xa48]
	cmp r1, #0
	beq _021637CC
	mov r0, r10
	blx r1
_021637CC:
	ldr r0, [r10, #0xae8]
	cmp r0, #0
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r10
	bl ovl01_2163B44
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021637EC: .word FX_SinCosTable_
	arm_func_end ovl01_2163604

	arm_func_start ovl01_21637F0
ovl01_21637F0: // 0x021637F0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x1cc
	add r0, r0, #0xc00
	bl AnimatorMDL__Release
	add r5, r4, #0xf10
	mov r4, #0
_02163814:
	mov r0, r5
	bl AnimatorMDL__Release
	add r4, r4, #1
	cmp r4, #2
	add r5, r5, #0x144
	blt _02163814
	mov r0, r6
	bl GameObject__Destructor
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl01_21637F0

	arm_func_start ovl01_2163838
ovl01_2163838: // 0x02163838
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	ldr r0, [r5, #0x20]
	tst r0, #0x20
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r5, #0xa3c]
	bl ovl01_2162918
	add r0, r5, #0x214
	add r1, r5, #0x44
	add r3, r0, #0xc00
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r5, #0x48]
	add r0, r5, #0xa00
	rsb r1, r1, #0
	str r1, [r5, #0xe18]
	ldrh r1, [r0, #0xd4]
	add r0, r5, #0x1cc
	add r4, r0, #0xc00
	mov r0, r1, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _021639F0 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r4, #0x24
	bl MTX_RotY33_
	mov r0, r4
	bl AnimatorMDL__ProcessAnimation
	mov r0, r4
	bl AnimatorMDL__Draw
	add r0, r5, #0x30c
	add r1, r0, #0x800
	mov r0, #0x1d
	bl BossHelpers__Model__SetMatrixMode
	add r1, r5, #0x33c
	mov r0, #0x1c
	add r1, r1, #0x800
	bl BossHelpers__Model__SetMatrixMode
	mov r6, #0
	ldr r11, _021639F0 // =FX_SinCosTable_
	mov r7, r5
	mov r8, r5
	add r9, r5, #0xf10
	mov r10, r6
	add r4, r5, #0xa00
_021638FC:
	ldr r0, [r7, #0x384]
	tst r0, #0x20
	bne _02163974
	add r0, r8, #0x358
	add r1, r7, #0x3a8
	add r3, r0, #0xc00
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r7, #0x3ac]
	add r0, r9, #0x24
	rsb r1, r1, #0
	str r1, [r8, #0xf5c]
	ldrh r1, [r4, #0xd6]
	add r1, r1, #0x2000
	sub r1, r1, r10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	ldrsh r1, [r11, r1]
	add r2, r11, r2, lsl #1
	ldrsh r2, [r2, #2]
	bl MTX_RotY33_
	mov r0, r9
	bl AnimatorMDL__ProcessAnimation
	mov r0, r9
	bl AnimatorMDL__Draw
_02163974:
	add r6, r6, #1
	cmp r6, #2
	add r7, r7, #0x364
	add r8, r8, #0x144
	add r9, r9, #0x144
	add r10, r10, #0x4000
	blt _021638FC
	add r0, r5, #0x36c
	add r1, r0, #0x800
	mov r0, #0x1a
	bl BossHelpers__Model__SetMatrixMode
	add r0, r5, #0x39c
	add r1, r0, #0x800
	mov r0, #0x18
	bl BossHelpers__Model__SetMatrixMode
	add r0, r5, #0x3cc
	add r6, r0, #0x800
	mov r4, #0
_021639BC:
	mov r0, r6
	bl AnimatePalette
	mov r0, r6
	bl DrawAnimatedPalette
	add r4, r4, #1
	cmp r4, #0x10
	add r6, r6, #0x20
	blt _021639BC
	ldr r0, [r5, #0xa3c]
	add r0, r0, #0x24
	add r0, r0, #0x400
	bl BossHelpers__Light__SetLights1
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021639F0: .word FX_SinCosTable_
	arm_func_end ovl01_2163838

	arm_func_start ovl01_21639F4
ovl01_21639F4: // 0x021639F4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0xa3c]
	bl ovl01_2162A70
	ldr r1, [r4, #0xa3c]
	add r1, r1, #0x300
	ldrsh r2, [r1, #0xb8]
	sub r0, r2, r0
	strh r0, [r1, #0xb8]
	ldr r0, [r4, #0xa50]
	cmp r0, #1
	bne _02163A3C
	ldr r0, [r4, #0xa3c]
	add r0, r0, #0x300
	ldrsh r1, [r0, #0xbe]
	add r1, r1, #1
	strh r1, [r0, #0xbe]
_02163A3C:
	ldr r0, [r4, #0xa3c]
	add r0, r0, #0x300
	ldrsh r1, [r0, #0xb8]
	cmp r1, #0
	ldrgt r0, _02163AEC // =ovl01_216602C
	bgt _02163A94
	mov r1, #1
	strh r1, [r0, #0xb8]
	mov r1, #0
	mov r0, #0xce
	str r1, [sp]
	sub r1, r0, #0xcf
	str r0, [sp, #4]
	ldr r0, [r4, #0xa3c]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	ldr r1, [r4, #0xa3c]
	mov r2, #1
	ldr r0, _02163AEC // =ovl01_216602C
	str r2, [r1, #0x410]
_02163A94:
	str r0, [r4, #0xa44]
	ldr r0, [r4, #0xa3c]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0xb8]
	bl UpdateBossHealthHUD
	ldr r1, [r4, #0xa3c]
	add r0, r1, #0x300
	ldrsh r0, [r0, #0xb8]
	cmp r0, #0x200
	addge sp, sp, #8
	ldmgeia sp!, {r4, pc}
	ldr r0, [r1, #0x418]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	mov r0, #1
	bl ChangeBossBGMVariant
	ldr r0, [r4, #0xa3c]
	mov r1, #1
	str r1, [r0, #0x418]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02163AEC: .word ovl01_216602C
	arm_func_end ovl01_21639F4

	arm_func_start ovl01_2163AF0
ovl01_2163AF0: // 0x02163AF0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xa50]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	cmp r1, #0
	addeq r0, r0, #0x300
	ldreqsh r1, [r0, #0xba]
	addeq r1, r1, #1
	beq _02163B28
	add r0, r0, #0x300
	ldrsh r1, [r0, #0xba]
	add r1, r1, #4
_02163B28:
	strh r1, [r0, #0xba]
	ldr r0, [r4, #0xa3c]
	bl ovl01_2163458
	mov r1, r0
	mov r0, r4
	bl ovl01_2163F00
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2163AF0

	arm_func_start ovl01_2163B44
ovl01_2163B44: // 0x02163B44
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _02163CB8 // =gPlayer
	mov r4, r0
	ldr r0, [r1]
	bl BossHelpers__Player__IsDead
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, _02163CB8 // =gPlayer
	ldr r2, _02163CBC // =0x006BAA99
	ldr r0, [r0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__Func_2038DCC
	add r1, r4, #0xa00
	mov r0, r0, lsl #0x10
	ldrsh r2, [r1, #0xd6]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	rsb r0, r2, r0, asr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr r1, _02163CC0 // =0x00001C72
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r1, r0, lsr #0x10
	cmplt r1, #0x8000
	bge _02163BFC
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r4, #0xf10
	mov r3, #0x29
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02163CB8 // =gPlayer
	mov r3, #0xa000
	rsb r3, r3, #0
	ldr r2, [r0]
	add r1, r3, #0x8000
	str r3, [r2, #0xb0]
	ldr r0, [r0]
	mov r2, #0x1000
	bl BossPlayerHelpers_Action_Boss3ArmKnockback
	b _02163C50
_02163BFC:
	ldr r0, _02163CC4 // =0x0000E38E
	cmp r1, r0
	bge _02163C50
	cmp r1, #0x8000
	ble _02163C50
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x54
	ldr r2, [r4, #0xa30]
	add r0, r0, #0x1000
	mov r3, #0x29
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02163CB8 // =gPlayer
	mov r3, #0xa000
	ldr r2, [r0]
	mov r1, #0x2000
	str r3, [r2, #0xb0]
	ldr r0, [r0]
	mov r2, #0x1000
	bl BossPlayerHelpers_Action_Boss3ArmKnockback
_02163C50:
	add r0, r4, #0x1000
	ldrh r0, [r0, #0x1c]
	tst r0, #0x8000
	beq _02163C7C
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r4, #0xf10
	mov r3, #0x27
	bl BossHelpers__Animation__Func_2038BF0
_02163C7C:
	add r0, r4, #0x1100
	ldrh r0, [r0, #0x60]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x54
	ldr r2, [r4, #0xa30]
	add r0, r0, #0x1000
	mov r3, #0x27
	bl BossHelpers__Animation__Func_2038BF0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02163CB8: .word gPlayer
_02163CBC: .word 0x006BAA99
_02163CC0: .word 0x00001C72
_02163CC4: .word 0x0000E38E
	arm_func_end ovl01_2163B44

	arm_func_start ovl01_2163CC8
ovl01_2163CC8: // 0x02163CC8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xa3c]
	bl ovl01_2162BD0
	cmp r0, #1
	bne _02163CF4
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	bic r1, r1, #0x10
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_02163CF4:
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	orr r1, r1, #0x10
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2163CC8

	arm_func_start ovl01_2163D10
ovl01_2163D10: // 0x02163D10
	stmdb sp!, {r3, lr}
	str r1, [r0, #0xa4c]
	cmp r1, #0xe
	addls pc, pc, r1, lsl #2
	b _02163DEC
_02163D24: // jump table
	b _02163D60 // case 0
	b _02163D6C // case 1
	b _02163D78 // case 2
	b _02163D84 // case 3
	b _02163D90 // case 4
	b _02163D9C // case 5
	b _02163DA8 // case 6
	b _02163DB4 // case 7
	b _02163DC0 // case 8
	b _02163DCC // case 9
	b _02163DD8 // case 10
	b _02163DEC // case 11
	b _02163DEC // case 12
	b _02163DEC // case 13
	b _02163DE4 // case 14
_02163D60:
	ldr r1, _02163DF8 // =ovl01_2163F24
	str r1, [r0, #0xa40]
	b _02163DEC
_02163D6C:
	ldr r1, _02163DFC // =ovl01_2164100
	str r1, [r0, #0xa40]
	b _02163DEC
_02163D78:
	ldr r1, _02163E00 // =ovl01_21644E4
	arm_func_end ovl01_2163D10

	arm_func_start ovl01_2163D7C
ovl01_2163D7C: // 0x02163D7C
	str r1, [r0, #0xa40]
	b _02163DEC
_02163D84:
	ldr r1, _02163E04 // =ovl01_21646BC
	str r1, [r0, #0xa40]
	b _02163DEC
_02163D90:
	ldr r1, _02163E08 // =ovl01_2164728
	str r1, [r0, #0xa40]
	b _02163DEC
_02163D9C:
	ldr r1, _02163E0C // =ovl01_21649D8
	str r1, [r0, #0xa40]
	b _02163DEC
_02163DA8:
	ldr r1, _02163E10 // =ovl01_2164B80
	str r1, [r0, #0xa40]
	b _02163DEC
_02163DB4:
	ldr r1, _02163E14 // =ovl01_2165084
	str r1, [r0, #0xa40]
	b _02163DEC
_02163DC0:
	ldr r1, _02163E18 // =ovl01_21651EC
	str r1, [r0, #0xa40]
	b _02163DEC
_02163DCC:
	ldr r1, _02163E1C // =ovl01_21655B0
	str r1, [r0, #0xa40]
	b _02163DEC
_02163DD8:
	ldr r1, _02163E20 // =ovl01_21658B8
	str r1, [r0, #0xa40]
	b _02163DEC
_02163DE4:
	ldr r1, _02163E24 // =ovl01_2166460
	str r1, [r0, #0xa40]
_02163DEC:
	ldr r1, [r0, #0xa40]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_02163DF8: .word ovl01_2163F24
_02163DFC: .word ovl01_2164100
_02163E00: .word ovl01_21644E4
_02163E04: .word ovl01_21646BC
_02163E08: .word ovl01_2164728
_02163E0C: .word ovl01_21649D8
_02163E10: .word ovl01_2164B80
_02163E14: .word ovl01_2165084
_02163E18: .word ovl01_21651EC
_02163E1C: .word ovl01_21655B0
_02163E20: .word ovl01_21658B8
_02163E24: .word ovl01_2166460
	arm_func_end ovl01_2163D7C

	arm_func_start ovl01_2163E28
ovl01_2163E28: // 0x02163E28
	stmdb sp!, {r3, lr}
	str r1, [r0, #0xa4c]
	cmp r1, #0xb
	beq _02163E48
	cmp r1, #0xc
	ldreq r1, _02163E5C // =ovl01_2165DD8
	streq r1, [r0, #0xa40]
	b _02163E50
_02163E48:
	ldr r1, _02163E60 // =ovl01_2165B2C
	str r1, [r0, #0xa40]
_02163E50:
	ldr r1, [r0, #0xa40]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_02163E5C: .word ovl01_2165DD8
_02163E60: .word ovl01_2165B2C
	arm_func_end ovl01_2163E28

	arm_func_start ovl01_2163E64
ovl01_2163E64: // 0x02163E64
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, _02163EA8 // =gPlayer
	mov r4, r1
	ldr r1, [r2]
	mov r5, r0
	ldr r0, [r1, #0x44]
	ldr r2, _02163EAC // =0x006BAA99
	mov r1, #0x40000
	bl BossHelpers__Arena__Func_2038DCC
	add r2, r5, #0xa00
	mov r1, r0
	ldrh r0, [r2, #0xd4]
	mov r2, r4
	bl BossHelpers__Math__Func_2039264
	add r1, r5, #0xa00
	strh r0, [r1, #0xd4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02163EA8: .word gPlayer
_02163EAC: .word 0x006BAA99
	arm_func_end ovl01_2163E64

	arm_func_start ovl01_2163EB0
ovl01_2163EB0: // 0x02163EB0
	stmdb sp!, {r3, lr}
	cmp r1, #6
	mov r3, #0
	addls pc, pc, r1, lsl #2
	ldmia sp!, {r3, pc}
_02163EC4: // jump table
	b _02163EE0 // case 0
	b _02163EE0 // case 1
	b _02163EE0 // case 2
	b _02163EE4 // case 3
	b _02163EE0 // case 4
	b _02163EE4 // case 5
	b _02163EE0 // case 6
_02163EE0:
	mov r3, #1
_02163EE4:
	add r0, r0, #0x3cc
	mov r1, r1, lsl #0x10
	add r0, r0, #0x800
	mov r2, r1, lsr #0x10
	mov r1, #0x10
	bl BossHelpers__Palette__Func_2038BAC
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_2163EB0

	arm_func_start ovl01_2163F00
ovl01_2163F00: // 0x02163F00
	ldr r2, [r0, #0xa3c]
	add r2, r2, #0x300
	ldrh r3, [r2, #0xbc]
	cmp r3, r1
	ldrne r3, _02163F20 // =ovl01_21661C8
	strneh r1, [r2, #0xbc]
	strne r3, [r0, #0xa48]
	bx lr
	.align 2, 0
_02163F20: .word ovl01_21661C8
	arm_func_end ovl01_2163F00

	arm_func_start ovl01_2163F24
ovl01_2163F24: // 0x02163F24
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	mov r4, r0
	add r0, r4, #0x1cc
	str r1, [sp]
	mov r2, #1
	str r2, [sp, #4]
	ldr r2, [r4, #0xa30]
	mov r3, r1
	add r0, r0, #0xc00
	bl BossHelpers__Animation__Func_2038BF0
	mov r1, #0
	str r1, [sp]
	mov r3, #1
	str r3, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r4, #0xf10
	bl BossHelpers__Animation__Func_2038BF0
	mov r1, #0
	add r0, r4, #0x54
	str r1, [sp]
	mov r3, #1
	str r3, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r0, #0x1000
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x384]
	add r0, r4, #0xa00
	orr r1, r1, #0x20
	str r1, [r4, #0x384]
	ldr r2, [r4, #0x6e8]
	mov r1, #0x78
	orr r2, r2, #0x20
	str r2, [r4, #0x6e8]
	strh r1, [r0, #0xe6]
	ldrh r0, [r0, #0xda]
	tst r0, #0x10
	ldrne r0, _02163FD0 // =ovl01_21640A4
	ldreq r0, _02163FD4 // =ovl01_2163FD8
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02163FD0: .word ovl01_21640A4
_02163FD4: .word ovl01_2163FD8
	arm_func_end ovl01_2163F24

	arm_func_start ovl01_2163FD8
ovl01_2163FD8: // 0x02163FD8
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	ldr r0, [r4, #0xa3c]
	ldr r0, [r0, #0x414]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	tst r1, #2
	ldreqh r0, [r0, #0xe6]
	cmpeq r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	bl ovl01_2162BA8
	cmp r0, #0
	bne _02164054
	mov r0, r4
	mov r1, #1
	bl ovl01_2163D10
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	orr r1, r1, #2
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_02164054:
	cmp r0, #1
	bne _0216407C
	mov r0, r4
	mov r1, #2
	bl ovl01_2163D10
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	orr r1, r1, #2
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_0216407C:
	cmp r0, #2
	ldmneia sp!, {r4, pc}
	mov r0, r4
	mov r1, #4
	bl ovl01_2163D10
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	orr r1, r1, #2
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2163FD8

	arm_func_start ovl01_21640A4
ovl01_21640A4: // 0x021640A4
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	tst r1, #2
	ldreqh r0, [r0, #0xe6]
	cmpeq r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	mov r1, #6
	bl ovl01_2163D10
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	orr r1, r1, #2
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_21640A4

	arm_func_start ovl01_2164100
ovl01_2164100: // 0x02164100
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _021641FC // =ovl01_2164204
	mov r4, r0
	str r1, [r4, #0xa40]
	ldr r0, [r4, #0xa3c]
	bl ovl01_2162E00
	strb r0, [r4, #0xadc]
	mov r0, #0
	strb r0, [r4, #0xadd]
	ldrb r0, [r4, #0xadc]
	cmp r0, #2
	bne _02164180
	add r1, r4, #0xa00
	ldrh r2, [r1, #0xda]
	mov r0, r4
	orr r2, r2, #8
	strh r2, [r1, #0xda]
	bl ovl01_2162C34
	mov r6, #0
	mov r0, #1
	strb r6, [r4, #0xb0a]
	str r0, [r4, #0xae0]
	mov r5, r0
_0216415C:
	ldr r0, [r4, #0xa3c]
	mov r1, r5
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x398]
	bl ovl01_2168F84
	add r6, r6, #1
	cmp r6, #2
	blt _0216415C
	b _021641CC
_02164180:
	cmp r0, #4
	bne _021641CC
	add r1, r4, #0xa00
	ldrh r2, [r1, #0xda]
	mov r0, r4
	bic r2, r2, #8
	strh r2, [r1, #0xda]
	bl ovl01_2162C34
	bl ovl01_2162DE4
	strb r0, [r4, #0xb0a]
	ldrb r1, [r4, #0xadd]
	ldr r2, _02164200 // =_0217A8B8
	and r0, r0, #0xff
	add r0, r2, r0, lsl #4
	ldr r0, [r0, r1, lsl #2]
	mov r1, #1
	str r0, [r4, #0xae0]
	ldr r0, [r4, #0xa3c]
	bl ovl01_2169164
_021641CC:
	add r0, r4, #0xa00
	ldrh r3, [r0, #0xda]
	mov r2, #0
	mov r1, #0x78
	bic r3, r3, #4
	strh r3, [r0, #0xda]
	str r2, [r4, #0xb00]
	strh r1, [r0, #0xe6]
	add r0, r4, #0xb00
	mov r1, #0x8c
	strh r1, [r0, #8]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021641FC: .word ovl01_2164204
_02164200: .word _0217A8B8
	arm_func_end ovl01_2164100

	arm_func_start ovl01_2164204
ovl01_2164204: // 0x02164204
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	bne _02164360
	ldrh r1, [r0, #0xda]
	tst r1, #4
	bne _02164360
	ldrb r0, [r4, #0xadc]
	ldrb r2, [r4, #0xadd]
	cmp r2, r0
	bhs _02164360
	bhs _02164274
	tst r1, #8
	beq _02164260
	ldr r0, _021643C0 // =_0217A8D8
	add r1, r2, #2
	ldr r0, [r0, r1, lsl #2]
	str r0, [r4, #0xae0]
	b _02164274
_02164260:
	ldrb r1, [r4, #0xb0a]
	ldr r0, _021643C4 // =_0217A8B8
	add r0, r0, r1, lsl #4
	ldr r0, [r0, r2, lsl #2]
	str r0, [r4, #0xae0]
_02164274:
	ldr r0, [r4, #0xb00]
	cmp r0, #0
	ldrne r0, [r4, #0xb04]
	cmpne r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0xb04]
	ldr r0, [r4, #0xb00]
	cmp r0, #0
	beq _02164360
	add r1, r4, #0xb00
	ldrh r0, [r1, #8]
	cmp r0, #0
	ldreq r0, [r4, #0xb04]
	cmpeq r0, #0
	bne _02164360
	add r0, r4, #0xa00
	ldrh ip, [r0, #0xda]
	mov r3, #0xa
	mov r2, #0x1e
	orr ip, ip, #4
	strh ip, [r0, #0xda]
	strh r3, [r0, #0xe6]
	strh r2, [r1, #8]
	ldrb r0, [r4, #0xadd]
	ldr r1, [r4, #0xa3c]
	cmp r0, #0
	ldr r0, [r4, #0xae0]
	bne _02164324
	add r0, r1, r0, lsl #2
	ldr r0, [r0, #0x398]
	bl ovl01_21697D0
	cmp r0, #0
	bne _0216430C
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	bic r1, r1, #4
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_0216430C:
	mov r0, #0
	str r0, [r4, #0xb00]
	ldrb r0, [r4, #0xadd]
	add r0, r0, #1
	strb r0, [r4, #0xadd]
	b _02164360
_02164324:
	add r0, r1, r0, lsl #2
	ldr r0, [r0, #0x398]
	bl ovl01_21697D0
	cmp r0, #0
	bne _0216434C
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	bic r1, r1, #4
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_0216434C:
	mov r0, #0
	str r0, [r4, #0xb00]
	ldrb r0, [r4, #0xadd]
	add r0, r0, #1
	strb r0, [r4, #0xadd]
_02164360:
	ldrb r1, [r4, #0xadd]
	ldrb r0, [r4, #0xadc]
	cmp r1, r0
	bne _02164388
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xda]
	tst r0, #4
	ldreq r0, _021643C8 // =ovl01_21643CC
	streq r0, [r4, #0xa40]
	ldmeqia sp!, {r4, pc}
_02164388:
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	tst r1, #4
	ldmneia sp!, {r4, pc}
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xb00
	ldrh r1, [r0, #8]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021643C0: .word _0217A8D8
_021643C4: .word _0217A8B8
_021643C8: .word ovl01_21643CC
	arm_func_end ovl01_2164204

	arm_func_start ovl01_21643CC
ovl01_21643CC: // 0x021643CC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xae0]
	cmp r0, #0
	ldr r0, [r4, #0xa3c]
	bne _021643F8
	bl ovl01_2162AB0
	add r1, r0, r0, lsl #1
	add r0, r4, #0xa00
	strh r1, [r0, #0xe6]
	b _02164404
_021643F8:
	bl ovl01_2162AB0
	add r1, r4, #0xa00
	strh r0, [r1, #0xe6]
_02164404:
	ldr r0, _02164410 // =ovl01_2164414
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164410: .word ovl01_2164414
	arm_func_end ovl01_21643CC

	arm_func_start ovl01_2164414
ovl01_2164414: // 0x02164414
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, _02164480 // =ovl01_216997C
	mov r3, #0
_02164450:
	ldr r1, [r4, #0xa3c]
	add r1, r1, r3, lsl #2
	ldr r2, [r1, #0x398]
	add r3, r3, #1
	ldr r1, [r2, #0x37c]
	cmp r1, #2
	streq r0, [r2, #0x378]
	cmp r3, #4
	blt _02164450
	ldr r0, _02164484 // =ovl01_2164488
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164480: .word ovl01_216997C
_02164484: .word ovl01_2164488
	arm_func_end ovl01_2164414

	arm_func_start ovl01_2164488
ovl01_2164488: // 0x02164488
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0xa3c]
	mov r1, #0
_02164498:
	add r0, r2, r1, lsl #2
	ldr r0, [r0, #0x398]
	ldr r0, [r0, #0x37c]
	sub r0, r0, #1
	cmp r0, #3
	ldmlsia sp!, {r4, pc}
	add r1, r1, #1
	cmp r1, #4
	blt _02164498
	add r1, r4, #0xa00
	ldrh r2, [r1, #0xda]
	mov r0, r4
	bic r2, r2, #2
	strh r2, [r1, #0xda]
	bl ovl01_2163CC8
	mov r0, r4
	mov r1, #0
	bl ovl01_2163D10
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2164488

	arm_func_start ovl01_21644E4
ovl01_21644E4: // 0x021644E4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0xa00
	mov r2, #0x3fc
	ldr r1, _02164578 // =ovl01_2164580
	strh r2, [r0, #0xe6]
	ldr r5, _0216457C // =_0217A82C
	str r1, [r4, #0xa40]
	mov r6, #0
_0216450C:
	ldrsh r0, [r5, #0xa]
	str r0, [sp]
	ldr r0, [r4, #0xa3c]
	ldrsh r1, [r5, #4]
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x398]
	ldrsh r2, [r5, #6]
	ldrsh r3, [r5, #8]
	add r0, r0, #0x258
	bl ObjRect__SetBox2D
	add r6, r6, #1
	cmp r6, #4
	blt _0216450C
	mov r1, #0
	mov r0, #0xa1
	str r1, [sp]
	sub r1, r0, #0xa2
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0xa3c]
	mov r1, #5
	bl ovl01_2169164
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02164578: .word ovl01_2164580
_0216457C: .word _0217A82C
	arm_func_end ovl01_21644E4

	arm_func_start ovl01_2164580
ovl01_2164580: // 0x02164580
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r1, _021645E4 // =ovl01_2169DCC
	mov r2, #0
_021645BC:
	ldr r0, [r4, #0xa3c]
	add r0, r0, r2, lsl #2
	ldr r0, [r0, #0x398]
	add r2, r2, #1
	str r1, [r0, #0x378]
	cmp r2, #4
	blt _021645BC
	ldr r0, _021645E8 // =ovl01_21645EC
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021645E4: .word ovl01_2169DCC
_021645E8: .word ovl01_21645EC
	arm_func_end ovl01_2164580

	arm_func_start ovl01_21645EC
ovl01_21645EC: // 0x021645EC
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r2, [r4, #0xa3c]
	mov r1, #0xf0
	add r5, r2, #0x398
	bl ovl01_2163E64
	mov r2, #0
_0216460C:
	ldr r0, [r5, r2, lsl #2]
	ldr r1, [r0, #0x37c]
	cmp r1, #0
	beq _02164638
	cmp r1, #6
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, r5, r6, pc}
	mov r1, #0
	bl ovl01_2168F84
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_02164638:
	add r2, r2, #1
	cmp r2, #4
	blt _0216460C
	ldr r5, _021646B8 // =_0217A82C
	mov r6, #0
_0216464C:
	ldrsh r0, [r5, #0x4a]
	str r0, [sp]
	ldr r0, [r4, #0xa3c]
	ldrsh r1, [r5, #0x44]
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x398]
	ldrsh r2, [r5, #0x46]
	ldrsh r3, [r5, #0x48]
	add r0, r0, #0x258
	bl ObjRect__SetBox2D
	add r6, r6, #1
	cmp r6, #4
	blt _0216464C
	ldr r0, [r4, #0x138]
	mov r1, #0x1e
	bl NNS_SndPlayerStopSeq
	mov r0, r4
	bl ovl01_2163CC8
	mov r0, r4
	mov r1, #0
	bl ovl01_2163D10
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	bic r1, r1, #2
	strh r1, [r0, #0xda]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_021646B8: .word _0217A82C
	arm_func_end ovl01_21645EC

	arm_func_start ovl01_21646BC
ovl01_21646BC: // 0x021646BC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xa3c]
	mov r1, #7
	bl ovl01_2169164
	add r0, r4, #0xa00
	mov r1, #0xb4
	strh r1, [r0, #0xf0]
	ldr r0, [r4, #0x138]
	mov r1, #0x1e
	bl NNS_SndPlayerStopSeq
	ldr r0, _021646F4 // =ovl01_21646F8
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021646F4: .word ovl01_21646F8
	arm_func_end ovl01_21646BC

	arm_func_start ovl01_21646F8
ovl01_21646F8: // 0x021646F8
	add r1, r0, #0xa00
	ldrh r2, [r1, #0xf0]
	cmp r2, #0
	subne r2, r2, #1
	strneh r2, [r1, #0xf0]
	add r1, r0, #0xa00
	ldrh r1, [r1, #0xf0]
	cmp r1, #0
	ldreq r1, _02164724 // =ovl01_21645EC
	streq r1, [r0, #0xa40]
	bx lr
	.align 2, 0
_02164724: .word ovl01_21645EC
	arm_func_end ovl01_21646F8

	arm_func_start ovl01_2164728
ovl01_2164728: // 0x02164728
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _0216489C // =ovl01_21648B0
	mov r4, r0
	str r1, [r4, #0xa40]
	bl ovl01_2162E38
	mov r6, #0
_02164744:
	ldr r0, [r4, #0xa3c]
	add r0, r0, r6, lsl #2
	ldr r1, [r0, #0x398]
	ldr r0, [r1, #0x478]
	add r7, r1, #0x218
	cmp r0, #1
	bne _021647A0
	ldr r8, _021648A0 // =_0217A880
	mov r5, #0
_02164768:
	add r3, r8, r5, lsl #3
	ldrsh r1, [r3, #6]
	mov r2, r5, lsl #3
	mov r0, r7
	str r1, [sp]
	ldrsh r1, [r8, r2]
	ldrsh r2, [r3, #2]
	ldrsh r3, [r3, #4]
	bl ObjRect__SetBox2D
	add r5, r5, #1
	cmp r5, #3
	add r7, r7, #0x40
	blt _02164768
	b _021647F4
_021647A0:
	ldr r5, _021648A0 // =_0217A880
	mov r8, #0
_021647A8:
	add r2, r5, r8, lsl #3
	ldrsh r1, [r2, #6]
	mov ip, r8, lsl #3
	mov r0, r7
	str r1, [sp]
	ldrsh r3, [r2, #4]
	ldrsh r1, [r5, ip]
	ldrsh r2, [r2, #2]
	rsb ip, r3, #0
	rsb r3, r1, #0
	mov r1, ip, lsl #0x10
	mov r3, r3, lsl #0x10
	mov r1, r1, asr #0x10
	mov r3, r3, asr #0x10
	bl ObjRect__SetBox2D
	add r8, r8, #1
	cmp r8, #3
	add r7, r7, #0x40
	blt _021647A8
_021647F4:
	add r6, r6, #1
	cmp r6, #2
	blt _02164744
	ldr r0, [r4, #0xa3c]
	mov r1, #2
	add r0, r0, #0x88
	add r5, r0, #0x400
	mov r0, r5
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r3, _021648A4 // =_0217A82C
	mov r0, r5
	ldrsh r1, [r3, #0x1a]
	str r1, [sp]
	ldrsh r1, [r3, #0x14]
	ldrsh r2, [r3, #0x16]
	ldrsh r3, [r3, #0x18]
	bl ObjRect__SetBox2D
	ldr r1, _021648A8 // =0x00000102
	ldr r0, _021648AC // =gPlayer
	strh r1, [r5, #0x34]
	ldr r0, [r0]
	mov r6, #0
	str r0, [r5, #0x1c]
	ldr r0, [r5, #0x18]
	bic r0, r0, #4
	str r0, [r5, #0x18]
	mov r5, #8
_02164874:
	ldr r0, [r4, #0xa3c]
	mov r1, r5
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x398]
	bl ovl01_2168F84
	add r6, r6, #1
	cmp r6, #2
	blt _02164874
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216489C: .word ovl01_21648B0
_021648A0: .word _0217A880
_021648A4: .word _0217A82C
_021648A8: .word 0x00000102
_021648AC: .word gPlayer
	arm_func_end ovl01_2164728

	arm_func_start ovl01_21648B0
ovl01_21648B0: // 0x021648B0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r9, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	ldr r3, [r9, #0xa3c]
	ldr r0, [r3, #0x4a0]
	tst r0, #4
	beq _02164910
	mov r0, #0x40000
	ldr r1, _021649C8 // =0x006BAA99
	str r0, [sp]
	ldr r0, _021649CC // =0x00107FC0
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r1, _021649D0 // =gPlayer
	add r0, r3, #0x88
	ldr r2, [r1]
	add r1, r3, #0xc8
	ldr r2, [r2, #0x44]
	ldr r3, [r3, #0x3c4]
	add r0, r0, #0x400
	add r1, r1, #0x400
	bl BossHelpers__Collision__Func_2039120
_02164910:
	ldr r2, [r9, #0xa3c]
	mov r1, #0
_02164918:
	add r0, r2, r1, lsl #2
	ldr r0, [r0, #0x398]
	ldr r0, [r0, #0x37c]
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, pc}
	add r1, r1, #1
	cmp r1, #2
	blt _02164918
	mov r8, #0
	ldr r4, _021649D4 // =_0217A868
	mov r5, r8
_02164948:
	ldr r0, [r9, #0xa3c]
	mov r6, r5
	add r0, r0, r8, lsl #2
	ldr r0, [r0, #0x398]
	add r7, r0, #0x218
_0216495C:
	add r3, r4, r6, lsl #3
	ldrsh r1, [r3, #6]
	mov r2, r6, lsl #3
	mov r0, r7
	str r1, [sp]
	ldrsh r1, [r4, r2]
	ldrsh r2, [r3, #2]
	ldrsh r3, [r3, #4]
	bl ObjRect__SetBox2D
	add r6, r6, #1
	cmp r6, #3
	add r7, r7, #0x40
	blt _0216495C
	add r8, r8, #1
	cmp r8, #2
	blt _02164948
	add r1, r9, #0xa00
	ldrh r2, [r1, #0xda]
	mov r0, r9
	bic r2, r2, #2
	strh r2, [r1, #0xda]
	bl ovl01_2163CC8
	mov r0, r9
	mov r1, #0
	bl ovl01_2163D10
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_021649C8: .word 0x006BAA99
_021649CC: .word 0x00107FC0
_021649D0: .word gPlayer
_021649D4: .word _0217A868
	arm_func_end ovl01_21648B0

	arm_func_start ovl01_21649D8
ovl01_21649D8: // 0x021649D8
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, #0
	mov r4, #0xa
_021649E8:
	ldr r0, [r6, #0xa3c]
	mov r1, r4
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x398]
	bl ovl01_2168F84
	add r5, r5, #1
	cmp r5, #2
	blt _021649E8
	ldr r0, _02164A14 // =ovl01_21648B0
	str r0, [r6, #0xa40]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02164A14: .word ovl01_21648B0
	arm_func_end ovl01_21649D8

	arm_func_start ovl01_2164A18
ovl01_2164A18: // 0x02164A18
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r5, r0
	ldr r4, [r5, #0xa3c]
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	mov r2, r1
	mov r3, r1
	str r1, [sp, #0x10]
	mov r0, #0x130
	bl GameObject__SpawnObject
	ldrb r2, [r5, #0xadc]
	add r1, r5, #0xb60
	ldr ip, _02164B70 // =_0217A898
	sub r2, r2, #1
	add r2, r4, r2, lsl #2
	str r0, [r2, #0x378]
	ldrb r0, [r5, #0xadc]
	add r6, r5, #0xa00
	ldr r3, _02164B74 // =FX_SinCosTable_
	sub r0, r0, #1
	add r0, r4, r0, lsl #2
	ldr lr, [r0, #0x378]
	ldr r7, _02164B78 // =0x00107FC0
	str r4, [lr, #0x374]
	add r4, lr, #0x44
	ldmia r1, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	ldr r0, [lr, #0x48]
	mov r1, #0
	rsb r0, r0, #0
	str r0, [lr, #0x48]
	ldrb r4, [r5, #0xae4]
	ldrb r2, [r5, #0xadc]
	ldrh r0, [r6, #0xf0]
	sub r5, r4, #1
	sub r2, r2, #1
	mov r4, r2, lsl #1
	add r2, ip, r5, lsl #3
	ldrh r5, [r4, r2]
	ldr r2, [lr, #0x44]
	ldr r4, _02164B7C // =0xFFFFF334
	add r0, r0, r5
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r6, r0, lsl #1
	mov r0, r6, lsl #1
	ldrsh r5, [r3, r0]
	add r0, r6, #1
	mov r0, r0, lsl #1
	umull ip, r6, r5, r7
	ldrsh r0, [r3, r0]
	adds ip, ip, #0x800
	mla r6, r5, r1, r6
	mov r3, r5, asr #0x1f
	mla r6, r3, r7, r6
	adc r3, r6, #0
	mov r5, ip, lsr #0xc
	orr r5, r5, r3, lsl #20
	sub r5, r5, r2
	umull r3, r2, r0, r7
	mov r5, r5, asr #5
	str r5, [lr, #0x98]
	str r4, [lr, #0x9c]
	adds r3, r3, #0x800
	mla r2, r0, r1, r2
	mov r0, r0, asr #0x1f
	mla r2, r0, r7, r2
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	ldr r0, [lr, #0x4c]
	orr r2, r2, r1, lsl #20
	sub r0, r2, r0
	mov r0, r0, asr #5
	str r0, [lr, #0xa0]
	ldr r0, [lr, #0x1c]
	orr r0, r0, #0x80
	str r0, [lr, #0x1c]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02164B70: .word _0217A898
_02164B74: .word FX_SinCosTable_
_02164B78: .word 0x00107FC0
_02164B7C: .word 0xFFFFF334
	arm_func_end ovl01_2164A18

	arm_func_start ovl01_2164B80
ovl01_2164B80: // 0x02164B80
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0xa3c]
	bl ovl01_2162EB8
	strb r0, [r4, #0xae4]
	mov r1, #0
	strb r1, [r4, #0xadc]
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x22
	bl BossHelpers__Animation__Func_2038BF0
	add r0, r4, #0xa00
	mov r2, #0
	ldr r1, _02164BD8 // =ovl01_2164BDC
	strh r2, [r0, #0xf0]
	str r1, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164BD8: .word ovl01_2164BDC
	arm_func_end ovl01_2164B80

	arm_func_start ovl01_2164BDC
ovl01_2164BDC: // 0x02164BDC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	ldmeqia sp!, {r4, pc}
	ldr r0, _02164C28 // =gPlayer
	ldr r2, _02164C2C // =0x006BAA99
	ldr r0, [r0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__Func_2038DCC
	add r1, r4, #0xa00
	ldr r2, _02164C30 // =ovl01_2164C34
	strh r0, [r1, #0xf0]
	str r2, [r4, #0xa40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164C28: .word gPlayer
_02164C2C: .word 0x006BAA99
_02164C30: .word ovl01_2164C34
	arm_func_end ovl01_2164BDC

	arm_func_start ovl01_2164C34
ovl01_2164C34: // 0x02164C34
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0xa00
	mov r1, #5
	strh r1, [r0, #0xe6]
	mov r1, #0
	add r0, r4, #0x1cc
	str r1, [sp]
	mov r2, #1
	str r2, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x23
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02164C80 // =ovl01_2164C84
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164C80: .word ovl01_2164C84
	arm_func_end ovl01_2164C34

	arm_func_start ovl01_2164C84
ovl01_2164C84: // 0x02164C84
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf00
	bl ovl01_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldreq r0, _02164CC0 // =ovl01_2164CC4
	streq r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164CC0: .word ovl01_2164CC4
	arm_func_end ovl01_2164C84

	arm_func_start ovl01_2164CC4
ovl01_2164CC4: // 0x02164CC4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0xf00
	mov r4, r0
	bl ovl01_2163E64
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x24
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02164D08 // =ovl01_2164D0C
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164D08: .word ovl01_2164D0C
	arm_func_end ovl01_2164CC4

	arm_func_start ovl01_2164D0C
ovl01_2164D0C: // 0x02164D0C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r1, #0xf00
	bl ovl01_2163E64
	ldr r0, [r4, #0xeb0]
	ldr r0, [r0]
	cmp r0, #0x1000
	bne _02164D88
	ldrb r0, [r4, #0xae4]
	mov r5, #0
	cmp r0, #0
	ble _02164D64
_02164D40:
	ldrb r1, [r4, #0xadc]
	mov r0, r4
	add r1, r1, #1
	strb r1, [r4, #0xadc]
	bl ovl01_2164A18
	ldrb r0, [r4, #0xae4]
	add r5, r5, #1
	cmp r5, r0
	blt _02164D40
_02164D64:
	mov r1, #0
	mov r0, #0xa4
	str r1, [sp]
	sub r1, r0, #0xa5
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02164D88:
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	ldrne r0, _02164DA4 // =ovl01_2164DA8
	strne r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02164DA4: .word ovl01_2164DA8
	arm_func_end ovl01_2164D0C

	arm_func_start ovl01_2164DA8
ovl01_2164DA8: // 0x02164DA8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x25
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02164DE4 // =ovl01_2164DE8
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164DE4: .word ovl01_2164DE8
	arm_func_end ovl01_2164DA8

	arm_func_start ovl01_2164DE8
ovl01_2164DE8: // 0x02164DE8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	mov r3, r1
	add r0, r0, #0xc00
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02164E3C // =ovl01_2164E40
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02164E3C: .word ovl01_2164E40
	arm_func_end ovl01_2164DE8

	arm_func_start ovl01_2164E40
ovl01_2164E40: // 0x02164E40
	add r1, r0, #0xa00
	mov r3, #0
	ldr r2, _02164E58 // =ovl01_2164E5C
	strh r3, [r1, #0xe6]
	str r2, [r0, #0xa40]
	bx lr
	.align 2, 0
_02164E58: .word ovl01_2164E5C
	arm_func_end ovl01_2164E40

	arm_func_start ovl01_2164E5C
ovl01_2164E5C: // 0x02164E5C
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldrb r1, [r4, #0xae4]
	ldrb r5, [r4, #0xadc]
	ldr ip, _02164F1C // =_0217A898
	ldr r2, [r4, #0xa3c]
	sub r3, r1, r5
	sub lr, r1, #1
	sub r1, r5, #1
	add r1, r2, r1, lsl #2
	add r2, ip, lr, lsl #3
	mov r3, r3, lsl #1
	ldrh ip, [r0, #0xf0]
	ldrh r2, [r3, r2]
	ldr r1, [r1, #0x398]
	add r0, r1, #0x400
	add r2, ip, r2
	strh r2, [r0, #0x44]
	ldrb r0, [r4, #0xadc]
	ldr r2, [r4, #0xa3c]
	mov r1, #0xb
	sub r0, r0, #1
	add r0, r2, r0, lsl #2
	ldr r0, [r0, #0x398]
	bl ovl01_2168F84
	ldrb r0, [r4, #0xadc]
	cmp r0, #0
	subne r0, r0, #1
	strneb r0, [r4, #0xadc]
	ldrb r0, [r4, #0xadc]
	cmp r0, #0
	ldreq r0, _02164F20 // =ovl01_2164F24
	movne r1, #0
	streq r0, [r4, #0xa40]
	addne r0, r4, #0xa00
	strneh r1, [r0, #0xe6]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02164F1C: .word _0217A898
_02164F20: .word ovl01_2164F24
	arm_func_end ovl01_2164E5C

	arm_func_start ovl01_2164F24
ovl01_2164F24: // 0x02164F24
	add r1, r0, #0xa00
	mov r3, #0x8c
	ldr r2, _02164F3C // =ovl01_2164F40
	strh r3, [r1, #0xe6]
	str r2, [r0, #0xa40]
	bx lr
	.align 2, 0
_02164F3C: .word ovl01_2164F40
	arm_func_end ovl01_2164F24

	arm_func_start ovl01_2164F40
ovl01_2164F40: // 0x02164F40
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	ldrb r0, [r4, #0xadc]
	subs r1, r0, #1
	bmi _02164F84
	ldr r2, [r4, #0xa3c]
_02164F60:
	add r0, r2, r1, lsl #2
	ldr r0, [r0, #0x398]
	ldr r0, [r0, #0x37c]
	cmp r0, #0xc
	cmpne r0, #0
	cmpne r0, #0xd
	ldmneia sp!, {r4, r5, r6, pc}
	subs r1, r1, #1
	bpl _02164F60
_02164F84:
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, _02165018 // =ovl01_216ADBC
	mov r3, #0
_02164FB0:
	ldr r1, [r4, #0xa3c]
	add r1, r1, r3, lsl #2
	ldr r2, [r1, #0x398]
	add r3, r3, #1
	ldr r1, [r2, #0x37c]
	cmp r1, #0xc
	streq r0, [r2, #0x378]
	cmp r3, #4
	blt _02164FB0
	ldrb r0, [r4, #0xae4]
	mov r6, #0
	cmp r0, #0
	ble _0216500C
	mov r5, #3
_02164FE8:
	ldr r0, [r4, #0xa3c]
	mov r1, r5
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x378]
	bl ovl01_21675A0
	ldrb r0, [r4, #0xae4]
	add r6, r6, #1
	cmp r6, r0
	blt _02164FE8
_0216500C:
	ldr r0, _0216501C // =ovl01_2165020
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02165018: .word ovl01_216ADBC
_0216501C: .word ovl01_2165020
	arm_func_end ovl01_2164F40

	arm_func_start ovl01_2165020
ovl01_2165020: // 0x02165020
	stmdb sp!, {r4, lr}
	mov r1, #0xf0
	mov r4, r0
	bl ovl01_2163E64
	ldr r2, [r4, #0xa3c]
	mov r1, #0
_02165038:
	add r0, r2, r1, lsl #2
	ldr r0, [r0, #0x398]
	ldr r0, [r0, #0x37c]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	add r1, r1, #1
	cmp r1, #4
	blt _02165038
	add r2, r4, #0xa00
	ldrh r3, [r2, #0xda]
	mov r0, r4
	mov r1, #0
	bic r3, r3, #2
	strh r3, [r2, #0xda]
	ldrh r3, [r2, #0xda]
	bic r3, r3, #0x10
	strh r3, [r2, #0xda]
	bl ovl01_2163D10
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2165020

	arm_func_start ovl01_2165084
ovl01_2165084: // 0x02165084
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	mov r3, r1
	add r0, r0, #0xc00
	bl BossHelpers__Animation__Func_2038BF0
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r4, #0xf10
	mov r3, #0x27
	bl BossHelpers__Animation__Func_2038BF0
	mov r1, #0
	add r0, r4, #0x54
	str r1, [sp]
	mov r2, #1
	str r2, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r0, #0x1000
	mov r3, #0x27
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x384]
	add r0, r4, #0xa00
	bic r1, r1, #0x20
	str r1, [r4, #0x384]
	ldr r1, [r4, #0x6e8]
	mov r2, #0x78
	bic r1, r1, #0x20
	str r1, [r4, #0x6e8]
	ldr r1, _0216512C // =ovl01_2165130
	strh r2, [r0, #0xe6]
	str r1, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216512C: .word ovl01_2165130
	arm_func_end ovl01_2165084

	arm_func_start ovl01_2165130
ovl01_2165130: // 0x02165130
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	tst r1, #2
	ldreqh r0, [r0, #0xe6]
	cmpeq r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	bl ovl01_2162BF4
	cmp r0, #0
	bne _0216519C
	mov r0, r4
	mov r1, #8
	bl ovl01_2163D10
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	orr r1, r1, #2
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_0216519C:
	cmp r0, #1
	bne _021651C4
	mov r0, r4
	mov r1, #9
	bl ovl01_2163D10
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	orr r1, r1, #2
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_021651C4:
	cmp r0, #2
	ldmneia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0xa
	bl ovl01_2163D10
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	orr r1, r1, #2
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2165130

	arm_func_start ovl01_21651EC
ovl01_21651EC: // 0x021651EC
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _021652DC // =ovl01_21652E4
	mov r4, r0
	str r1, [r4, #0xa40]
	ldr r0, [r4, #0xa3c]
	bl ovl01_2162F10
	strb r0, [r4, #0xadc]
	mov r0, #0
	strb r0, [r4, #0xadd]
	ldrb r0, [r4, #0xadc]
	cmp r0, #2
	bne _0216526C
	add r1, r4, #0xa00
	ldrh r2, [r1, #0xda]
	mov r0, r4
	orr r2, r2, #8
	strh r2, [r1, #0xda]
	bl ovl01_2162C34
	mov r6, #0
	mov r0, #1
	strb r6, [r4, #0xb0a]
	str r0, [r4, #0xae0]
	mov r5, r0
_02165248:
	ldr r0, [r4, #0xa3c]
	mov r1, r5
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x398]
	bl ovl01_2168F84
	add r6, r6, #1
	cmp r6, #2
	blt _02165248
	b _021652B8
_0216526C:
	cmp r0, #4
	bne _021652B8
	add r1, r4, #0xa00
	ldrh r2, [r1, #0xda]
	mov r0, r4
	bic r2, r2, #8
	strh r2, [r1, #0xda]
	bl ovl01_2162C34
	bl ovl01_2162DE4
	strb r0, [r4, #0xb0a]
	ldrb r1, [r4, #0xadd]
	ldr r2, _021652E0 // =_0217A8B8
	and r0, r0, #0xff
	add r0, r2, r0, lsl #4
	ldr r0, [r0, r1, lsl #2]
	mov r1, #1
	str r0, [r4, #0xae0]
	ldr r0, [r4, #0xa3c]
	bl ovl01_2169164
_021652B8:
	add r0, r4, #0xa00
	ldrh r3, [r0, #0xda]
	mov r2, #0
	mov r1, #0x8c
	bic r3, r3, #4
	strh r3, [r0, #0xda]
	str r2, [r4, #0xb00]
	strh r1, [r0, #0xe6]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021652DC: .word ovl01_21652E4
_021652E0: .word _0217A8B8
	arm_func_end ovl01_21651EC

	arm_func_start ovl01_21652E4
ovl01_21652E4: // 0x021652E4
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	bne _02165420
	ldrh r1, [r0, #0xda]
	tst r1, #4
	bne _02165420
	ldrb r0, [r4, #0xadc]
	ldrb r2, [r4, #0xadd]
	cmp r2, r0
	bhs _02165420
	bhs _02165354
	tst r1, #8
	beq _02165340
	ldr r0, _02165480 // =_0217A8D8
	add r1, r2, #2
	ldr r0, [r0, r1, lsl #2]
	str r0, [r4, #0xae0]
	b _02165354
_02165340:
	ldrb r1, [r4, #0xb0a]
	ldr r0, _02165484 // =_0217A8B8
	add r0, r0, r1, lsl #4
	ldr r0, [r0, r2, lsl #2]
	str r0, [r4, #0xae0]
_02165354:
	ldr r0, [r4, #0xb00]
	cmp r0, #0
	beq _02165420
	add r1, r4, #0xb00
	ldrh r0, [r1, #8]
	cmp r0, #0
	bne _02165420
	add r0, r4, #0xa00
	ldrh ip, [r0, #0xda]
	mov r3, #0xa
	mov r2, #0x1e
	orr ip, ip, #4
	strh ip, [r0, #0xda]
	strh r3, [r0, #0xe6]
	strh r2, [r1, #8]
	ldrb r0, [r4, #0xadd]
	ldr r1, [r4, #0xa3c]
	cmp r0, #0
	ldr r0, [r4, #0xae0]
	bne _021653E4
	add r0, r1, r0, lsl #2
	ldr r0, [r0, #0x398]
	bl ovl01_21697D0
	cmp r0, #0
	bne _021653CC
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	bic r1, r1, #4
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_021653CC:
	mov r0, #0
	str r0, [r4, #0xb00]
	ldrb r0, [r4, #0xadd]
	add r0, r0, #1
	strb r0, [r4, #0xadd]
	b _02165420
_021653E4:
	add r0, r1, r0, lsl #2
	ldr r0, [r0, #0x398]
	bl ovl01_21697D0
	cmp r0, #0
	bne _0216540C
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	bic r1, r1, #4
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_0216540C:
	mov r0, #0
	str r0, [r4, #0xb00]
	ldrb r0, [r4, #0xadd]
	add r0, r0, #1
	strb r0, [r4, #0xadd]
_02165420:
	ldrb r1, [r4, #0xadd]
	ldrb r0, [r4, #0xadc]
	cmp r1, r0
	bne _02165448
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xda]
	tst r0, #4
	ldreq r0, _02165488 // =ovl01_216548C
	streq r0, [r4, #0xa40]
	ldmeqia sp!, {r4, pc}
_02165448:
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	tst r1, #4
	ldmneia sp!, {r4, pc}
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xb00
	ldrh r1, [r0, #8]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165480: .word _0217A8D8
_02165484: .word _0217A8B8
_02165488: .word ovl01_216548C
	arm_func_end ovl01_21652E4

	arm_func_start ovl01_216548C
ovl01_216548C: // 0x0216548C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xae0]
	cmp r0, #0
	ldr r0, [r4, #0xa3c]
	bne _021654B8
	bl ovl01_2162AB0
	add r1, r0, r0, lsl #1
	add r0, r4, #0xa00
	strh r1, [r0, #0xe6]
	b _021654C4
_021654B8:
	bl ovl01_2162AB0
	add r1, r4, #0xa00
	strh r0, [r1, #0xe6]
_021654C4:
	ldr r0, _021654D0 // =ovl01_21654D4
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021654D0: .word ovl01_21654D4
	arm_func_end ovl01_216548C

	arm_func_start ovl01_21654D4
ovl01_21654D4: // 0x021654D4
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, _02165540 // =ovl01_216997C
	mov r3, #0
_02165510:
	ldr r1, [r4, #0xa3c]
	add r1, r1, r3, lsl #2
	ldr r2, [r1, #0x398]
	add r3, r3, #1
	ldr r1, [r2, #0x37c]
	cmp r1, #2
	streq r0, [r2, #0x378]
	cmp r3, #4
	blt _02165510
	ldr r0, _02165544 // =ovl01_2165548
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165540: .word ovl01_216997C
_02165544: .word ovl01_2165548
	arm_func_end ovl01_21654D4

	arm_func_start ovl01_2165548
ovl01_2165548: // 0x02165548
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0xa3c]
	mov r1, #0
_02165558:
	add r0, r2, r1, lsl #2
	ldr r0, [r0, #0x398]
	ldr r0, [r0, #0x37c]
	cmp r0, #0x10
	ldmeqia sp!, {r4, pc}
	sub r0, r0, #2
	cmp r0, #2
	ldmlsia sp!, {r4, pc}
	add r1, r1, #1
	cmp r1, #4
	blt _02165558
	add r0, r4, #0xa00
	ldrh r2, [r0, #0xda]
	mov r1, #0xf
	bic r2, r2, #2
	strh r2, [r0, #0xda]
	ldr r0, [r4, #0xa3c]
	bl ovl01_2169164
	mov r0, r4
	mov r1, #7
	bl ovl01_2163D10
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2165548

	arm_func_start ovl01_21655B0
ovl01_21655B0: // 0x021655B0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r1, _021656A8 // =gPlayer
	mov r4, r0
	ldr r0, [r1]
	ldr r2, _021656AC // =0x006BAA99
	ldr r0, [r0, #0x44]
	mov r1, #0x40000
	bl BossHelpers__Arena__Func_2038DCC
	add r1, r4, #0xa00
	mov r0, r0, lsl #0x10
	ldrh r1, [r1, #0xd6]
	mov r2, r0, lsr #0x10
	ldr r5, _021656B0 // =_0217A82C
	add r0, r1, #0x2000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r2, lsl #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, asr #0x10
	rsb r0, r1, r0, asr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #0x2000
	movls r0, #0
	movhi r0, #1
	str r0, [r4, #0xaf0]
	mov r6, #0
_02165628:
	ldrsh r0, [r5, #0xa]
	str r0, [sp]
	ldr r0, [r4, #0xa3c]
	ldrsh r1, [r5, #4]
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x398]
	ldrsh r2, [r5, #6]
	ldrsh r3, [r5, #8]
	add r0, r0, #0x258
	bl ObjRect__SetBox2D
	add r6, r6, #1
	cmp r6, #4
	blt _02165628
	mov r0, #1
	str r0, [r4, #0xaf4]
	add r0, r4, #0xa00
	mov r1, #0x3c
	strh r1, [r0, #0xe6]
	mov r0, #3
	mov r2, #0xa1
	str r0, [r4, #0xae0]
	mov r0, #0
	sub r1, r2, #0xa2
	stmia sp, {r0, r2}
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, _021656B4 // =ovl01_216572C
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021656A8: .word gPlayer
_021656AC: .word 0x006BAA99
_021656B0: .word _0217A82C
_021656B4: .word ovl01_216572C
	arm_func_end ovl01_21655B0

	arm_func_start ovl01_21656B8
ovl01_21656B8: // 0x021656B8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0xaf4]
	ldr r0, [r4, #0xaf0]
	mov r2, #3
	cmp r0, #0
	strne r1, [r4, #0xaf0]
	moveq r0, #1
	streq r0, [r4, #0xaf0]
	add r0, r4, #0xa00
	mov r1, #0x3c
	strh r1, [r0, #0xe6]
	str r2, [r4, #0xae0]
	mov r2, #0
	mov r0, #0xa1
	str r2, [sp]
	sub r1, r0, #0xa2
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, _02165728 // =ovl01_216572C
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165728: .word ovl01_216572C
	arm_func_end ovl01_21656B8

	arm_func_start ovl01_216572C
ovl01_216572C: // 0x0216572C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r2, [r4, #0xa3c]
	ldr r0, [r4, #0xae0]
	mov r1, #0x11
	add r0, r2, r0, lsl #2
	ldr r0, [r0, #0x398]
	bl ovl01_2168F84
	add r0, r4, #0xa00
	mov r1, #0x3c
	strh r1, [r0, #0xe6]
	ldr r0, [r4, #0xae0]
	cmp r0, #0
	ldreq r0, _021657A0 // =ovl01_21657A4
	streq r0, [r4, #0xa40]
	subne r0, r0, #1
	strne r0, [r4, #0xae0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021657A0: .word ovl01_21657A4
	arm_func_end ovl01_216572C

	arm_func_start ovl01_21657A4
ovl01_21657A4: // 0x021657A4
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r2, [r4, #0xa3c]
	mov r1, #0xf0
	add r5, r2, #0x398
	bl ovl01_2163E64
	mov r1, #0
_021657C4:
	ldr r0, [r5, r1, lsl #2]
	ldr r0, [r0, #0x37c]
	cmp r0, #0xf
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, r5, r6, pc}
	add r1, r1, #1
	cmp r1, #4
	blt _021657C4
	ldr r0, [r4, #0x138]
	mov r1, #0x1e
	bl NNS_SndPlayerStopSeq
	ldr r0, [r4, #0xaf4]
	cmp r0, #0
	ldrne r0, _02165868 // =ovl01_21656B8
	addne sp, sp, #4
	strne r0, [r4, #0xa40]
	ldmneia sp!, {r3, r4, r5, r6, pc}
	ldr r5, _0216586C // =_0217A82C
	mov r6, #0
_02165810:
	ldrsh r0, [r5, #0x4a]
	str r0, [sp]
	ldr r0, [r4, #0xa3c]
	ldrsh r1, [r5, #0x44]
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x398]
	ldrsh r2, [r5, #0x46]
	ldrsh r3, [r5, #0x48]
	add r0, r0, #0x258
	bl ObjRect__SetBox2D
	add r6, r6, #1
	cmp r6, #4
	blt _02165810
	mov r0, r4
	mov r1, #7
	bl ovl01_2163D10
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	bic r1, r1, #2
	strh r1, [r0, #0xda]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02165868: .word ovl01_21656B8
_0216586C: .word _0217A82C
	arm_func_end ovl01_21657A4

	arm_func_start ovl01_2165870
ovl01_2165870: // 0x02165870
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	ldr r4, [r0, #0xa3c]
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, _021658B4 // =0x00000131
	mov r2, r1
	mov r3, r1
	str r1, [sp, #0x10]
	bl GameObject__SpawnObject
	str r0, [r4, #0x388]
	str r4, [r0, #0x374]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021658B4: .word 0x00000131
	arm_func_end ovl01_2165870

	arm_func_start ovl01_21658B8
ovl01_21658B8: // 0x021658B8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x22
	bl BossHelpers__Animation__Func_2038BF0
	mov r1, #1
	ldr r0, _021658FC // =ovl01_2165900
	str r1, [r4, #0xaec]
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021658FC: .word ovl01_2165900
	arm_func_end ovl01_21658B8

	arm_func_start ovl01_2165900
ovl01_2165900: // 0x02165900
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	ldrne r0, _02165928 // =ovl01_216592C
	strne r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165928: .word ovl01_216592C
	arm_func_end ovl01_2165900

	arm_func_start ovl01_216592C
ovl01_216592C: // 0x0216592C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0xa00
	mov r1, #5
	strh r1, [r0, #0xe6]
	mov r1, #0
	add r0, r4, #0x1cc
	str r1, [sp]
	mov r2, #1
	str r2, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x23
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02165978 // =ovl01_216597C
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165978: .word ovl01_216597C
	arm_func_end ovl01_216592C

	arm_func_start ovl01_216597C
ovl01_216597C: // 0x0216597C
	add r1, r0, #0xa00
	ldrh r2, [r1, #0xe6]
	cmp r2, #0
	subne r2, r2, #1
	strneh r2, [r1, #0xe6]
	add r1, r0, #0xa00
	ldrh r1, [r1, #0xe6]
	cmp r1, #0
	ldreq r1, _021659A8 // =ovl01_21659AC
	streq r1, [r0, #0xa40]
	bx lr
	.align 2, 0
_021659A8: .word ovl01_21659AC
	arm_func_end ovl01_216597C

	arm_func_start ovl01_21659AC
ovl01_21659AC: // 0x021659AC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x24
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _021659E8 // =ovl01_21659EC
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021659E8: .word ovl01_21659EC
	arm_func_end ovl01_21659AC

	arm_func_start ovl01_21659EC
ovl01_21659EC: // 0x021659EC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0xeb0]
	ldr r1, [r1]
	cmp r1, #0x1000
	bne _02165A30
	bl ovl01_2165870
	mov r2, #0
	mov r0, #0xa4
	sub r1, r0, #0xa5
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02165A30:
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	ldrne r0, _02165A4C // =ovl01_2165A50
	strne r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165A4C: .word ovl01_2165A50
	arm_func_end ovl01_21659EC

	arm_func_start ovl01_2165A50
ovl01_2165A50: // 0x02165A50
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x25
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02165A8C // =ovl01_2165A90
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165A8C: .word ovl01_2165A90
	arm_func_end ovl01_2165A50

	arm_func_start ovl01_2165A90
ovl01_2165A90: // 0x02165A90
	add r1, r0, #0xe00
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldrne r1, _02165AA8 // =ovl01_2165AAC
	strne r1, [r0, #0xa40]
	bx lr
	.align 2, 0
_02165AA8: .word ovl01_2165AAC
	arm_func_end ovl01_2165A90

	arm_func_start ovl01_2165AAC
ovl01_2165AAC: // 0x02165AAC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	mov r3, r1
	add r0, r0, #0xc00
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02165AEC // =ovl01_2165AF0
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165AEC: .word ovl01_2165AF0
	arm_func_end ovl01_2165AAC

	arm_func_start ovl01_2165AF0
ovl01_2165AF0: // 0x02165AF0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0xa3c]
	ldr r1, [r1, #0x388]
	add r1, r1, #0x300
	ldrh r1, [r1, #0xc8]
	cmp r1, #2
	ldmneia sp!, {r4, pc}
	mov r1, #7
	bl ovl01_2163D10
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	bic r1, r1, #2
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2165AF0

	arm_func_start ovl01_2165B2C
ovl01_2165B2C: // 0x02165B2C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r4, #0xf10
	mov r3, #0x26
	bl BossHelpers__Animation__Func_2038BF0
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x54
	ldr r2, [r4, #0xa30]
	add r0, r0, #0x1000
	mov r3, #0x26
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x384]
	ldr r0, _02165C00 // =gPlayer
	bic r1, r1, #0x20
	str r1, [r4, #0x384]
	ldr r1, [r4, #0x6e8]
	ldr r2, _02165C04 // =0x006BAA99
	bic r1, r1, #0x20
	str r1, [r4, #0x6e8]
	ldr r0, [r0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__Func_2038DCC
	add r1, r4, #0xa00
	strh r0, [r1, #0xd6]
	mov r0, #0
	strh r0, [r1, #0xd8]
	ldr r0, [r4, #0xa3c]
	mov r1, #0x13
	bl ovl01_2169164
	mov r0, #0
	str r0, [sp]
	mov r0, #0x9f
	str r0, [sp, #4]
	sub r1, r0, #0xa0
	ldr r0, [r4, #0xa3c]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	mov r0, #1
	bl SetHUDActiveScreen
	ldr r0, _02165C08 // =ovl01_2165C0C
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165C00: .word gPlayer
_02165C04: .word 0x006BAA99
_02165C08: .word ovl01_2165C0C
	arm_func_end ovl01_2165B2C

	arm_func_start ovl01_2165C0C
ovl01_2165C0C: // 0x02165C0C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	ldr r0, [r4, #0xa3c]
	bl ovl01_216242C
	ldr r0, _02165CE4 // =gPlayer
	ldr r2, _02165CE8 // =0x006BAA99
	ldr r0, [r0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__Func_2038DCC
	mov r1, #0x16
	str r1, [sp]
	add r1, r1, #0x20c
	str r1, [sp, #4]
	str r1, [sp, #8]
	add r2, r4, #0xa00
	mov r1, r0
	ldrh r0, [r2, #0xd6]
	ldrsh r2, [r2, #0xd8]
	mov r3, #0xb
	bl BossHelpers__Math__Func_2039360
	add r1, r4, #0xa00
	strh r0, [r1, #0xd8]
	ldrh r2, [r1, #0xd6]
	ldrsh r0, [r1, #0xd8]
	add r0, r2, r0
	strh r0, [r1, #0xd6]
	ldr r0, [r4, #0xff4]
	ldr r0, [r0]
	cmp r0, #0x33000
	bne _02165CB8
	mov r0, #0
	mov r1, #0xa0
	stmia sp, {r0, r1}
	sub r1, r1, #0xa1
	ldr r0, [r4, #0xa3c]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
_02165CB8:
	add r0, r4, #0x1000
	ldrh r0, [r0, #0x1c]
	tst r0, #0x8000
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, pc}
	mov r1, #1
	ldr r0, _02165CEC // =ovl01_2165CF0
	str r1, [r4, #0xae8]
	str r0, [r4, #0xa40]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02165CE4: .word gPlayer
_02165CE8: .word 0x006BAA99
_02165CEC: .word ovl01_2165CF0
	arm_func_end ovl01_2165C0C

	arm_func_start ovl01_2165CF0
ovl01_2165CF0: // 0x02165CF0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r1, #0xf0
	ldr r4, [r5, #0xa3c]
	bl ovl01_2163E64
	ldr r0, [r5, #0xa3c]
	bl ovl01_21624EC
	ldr r1, [r4, #0x3d4]
	ldr r2, [r4, #0x3d8]
	mov r0, r4
	bl ovl01_2163494
	cmp r0, #0
	ldrne r0, _02165D2C // =ovl01_2165D30
	strne r0, [r5, #0xa40]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02165D2C: .word ovl01_2165D30
	arm_func_end ovl01_2165CF0

	arm_func_start ovl01_2165D30
ovl01_2165D30: // 0x02165D30
	add r1, r0, #0xa00
	mov r3, #0x78
	ldr r2, _02165D48 // =ovl01_2165D4C
	strh r3, [r1, #0xe6]
	str r2, [r0, #0xa40]
	bx lr
	.align 2, 0
_02165D48: .word ovl01_2165D4C
	arm_func_end ovl01_2165D30

	arm_func_start ovl01_2165D4C
ovl01_2165D4C: // 0x02165D4C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	ldr r0, [r4, #0xa3c]
	bl ovl01_21625C8
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	bl ovl01_2162680
	ldr r1, [r4, #0xa3c]
	ldr r0, [r1, #0x40c]
	cmp r0, #0
	movne r0, #0
	strne r0, [r1, #0x40c]
	mov r0, r4
	mov r1, #7
	bl ovl01_2163D10
	ldr r0, [r4, #0xa3c]
	mov r1, #0xf
	bl ovl01_2169164
	add r0, r4, #0xa00
	ldrh r2, [r0, #0xda]
	mov r1, #1
	bic r2, r2, #2
	strh r2, [r0, #0xda]
	str r1, [r4, #0xa50]
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2165D4C

	arm_func_start ovl01_2165DD8
ovl01_2165DD8: // 0x02165DD8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xa3c]
	ldr r1, [r0, #0x388]
	cmp r1, #0
	ldrne r0, _02165E14 // =ovl01_2167EE4
	strne r0, [r1, #0x378]
	ldr r0, [r4, #0xa3c]
	mov r1, #0
	bl ovl01_2169164
	mov r0, #0
	bl SetHUDActiveScreen
	ldr r0, _02165E18 // =ovl01_2165E1C
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165E14: .word ovl01_2167EE4
_02165E18: .word ovl01_2165E1C
	arm_func_end ovl01_2165DD8

	arm_func_start ovl01_2165E1C
ovl01_2165E1C: // 0x02165E1C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r1, #0xf0
	ldr r4, [r5, #0xa3c]
	bl ovl01_2163E64
	ldr r0, [r5, #0xa3c]
	bl ovl01_21624EC
	ldr r1, [r4, #0x3d8]
	ldr r2, [r4, #0x3d4]
	mov r0, r4
	bl ovl01_2163494
	cmp r0, #0
	ldrne r0, _02165E58 // =ovl01_2165E5C
	strne r0, [r5, #0xa40]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02165E58: .word ovl01_2165E5C
	arm_func_end ovl01_2165E1C

	arm_func_start ovl01_2165E5C
ovl01_2165E5C: // 0x02165E5C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r4, #0xf10
	mov r3, #0x28
	bl BossHelpers__Animation__Func_2038BF0
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x54
	ldr r2, [r4, #0xa30]
	add r0, r0, #0x1000
	mov r3, #0x28
	bl BossHelpers__Animation__Func_2038BF0
	mov r1, #0
	ldr r0, _02165EBC // =ovl01_2165EC0
	str r1, [r4, #0xae8]
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02165EBC: .word ovl01_2165EC0
	arm_func_end ovl01_2165E5C

	arm_func_start ovl01_2165EC0
ovl01_2165EC0: // 0x02165EC0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	ldr r0, [r4, #0xa3c]
	bl ovl01_216242C
	ldr r0, _02165FA4 // =gPlayer
	ldr r2, _02165FA8 // =0x006BAA99
	ldr r0, [r0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__Func_2038DCC
	mov r1, #0x16
	str r1, [sp]
	add r1, r1, #0x20c
	str r1, [sp, #4]
	str r1, [sp, #8]
	add r2, r4, #0xa00
	mov r1, r0
	ldrh r0, [r2, #0xd6]
	ldrsh r2, [r2, #0xd8]
	mov r3, #0xb
	bl BossHelpers__Math__Func_2039360
	add r1, r4, #0xa00
	strh r0, [r1, #0xd8]
	ldrh r3, [r1, #0xd6]
	ldrsh r2, [r1, #0xd8]
	add r0, r4, #0x1000
	add r2, r3, r2
	strh r2, [r1, #0xd6]
	ldrh r0, [r0, #0x1c]
	tst r0, #0x8000
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x384]
	mov r1, #0
	orr r0, r0, #0x20
	str r0, [r4, #0x384]
	ldr r0, [r4, #0x6e8]
	orr r0, r0, #0x20
	str r0, [r4, #0x6e8]
	ldr r0, [r4, #0xa3c]
	add r0, r0, #0x300
	strh r1, [r0, #0xba]
	ldr r0, [r4, #0xa3c]
	bl ovl01_2163458
	mov r1, r0
	mov r0, r4
	bl ovl01_2163F00
	ldr r1, _02165FAC // =ovl01_2165FB0
	add r0, r4, #0xa00
	str r1, [r4, #0xa40]
	mov r1, #0x78
	strh r1, [r0, #0xe6]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02165FA4: .word gPlayer
_02165FA8: .word 0x006BAA99
_02165FAC: .word ovl01_2165FB0
	arm_func_end ovl01_2165EC0

	arm_func_start ovl01_2165FB0
ovl01_2165FB0: // 0x02165FB0
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	ldr r0, [r4, #0xa3c]
	bl ovl01_21622B4
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	bl ovl01_2162370
	mov r0, r4
	mov r1, #0
	bl ovl01_2163D10
	ldr r0, [r4, #0xa3c]
	mov r1, #0
	bl ovl01_2169164
	add r0, r4, #0xa00
	ldrh r2, [r0, #0xda]
	mov r1, #0
	bic r2, r2, #2
	strh r2, [r0, #0xda]
	str r1, [r4, #0xa50]
	str r1, [r4, #0xaec]
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2165FB0

	arm_func_start ovl01_216602C
ovl01_216602C: // 0x0216602C
	ldr r1, _02166038 // =ovl01_216603C
	str r1, [r0, #0xa44]
	bx lr
	.align 2, 0
_02166038: .word ovl01_216603C
	arm_func_end ovl01_216602C

	arm_func_start ovl01_216603C
ovl01_216603C: // 0x0216603C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x1f
	bl BossHelpers__Animation__Func_2038BF0
	mov r0, r4
	mov r1, #1
	bl ovl01_2163EB0
	ldr r0, _02166084 // =ovl01_2166088
	str r0, [r4, #0xa44]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166084: .word ovl01_2166088
	arm_func_end ovl01_216603C

	arm_func_start ovl01_2166088
ovl01_2166088: // 0x02166088
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0xeb0]
	ldr r1, [r1]
	mov r1, r1, asr #0xc
	tst r1, #4
	beq _021660B8
	ldr r1, [r4, #0xa3c]
	add r1, r1, #0x300
	ldrh r1, [r1, #0xbc]
	bl ovl01_2166184
	b _021660C0
_021660B8:
	mov r1, #1
	bl ovl01_2163EB0
_021660C0:
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	ldrne r0, _021660D8 // =ovl01_21660DC
	strne r0, [r4, #0xa44]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021660D8: .word ovl01_21660DC
	arm_func_end ovl01_2166088

	arm_func_start ovl01_21660DC
ovl01_21660DC: // 0x021660DC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x20
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0xa3c]
	mov r0, r4
	add r1, r1, #0x300
	ldrh r1, [r1, #0xbc]
	bl ovl01_2166184
	ldr r0, _0216612C // =ovl01_2166130
	str r0, [r4, #0xa44]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216612C: .word ovl01_2166130
	arm_func_end ovl01_21660DC

	arm_func_start ovl01_2166130
ovl01_2166130: // 0x02166130
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	mov r3, r1
	add r0, r0, #0xc00
	bl BossHelpers__Animation__Func_2038BF0
	mov r0, #0
	str r0, [r4, #0xa44]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2166130

	arm_func_start ovl01_2166184
ovl01_2166184: // 0x02166184
	stmdb sp!, {r3, lr}
	cmp r1, #0
	beq _021661A4
	cmp r1, #1
	beq _021661B0
	cmp r1, #2
	beq _021661BC
	ldmia sp!, {r3, pc}
_021661A4:
	mov r1, #2
	bl ovl01_2163EB0
	ldmia sp!, {r3, pc}
_021661B0:
	mov r1, #4
	bl ovl01_2163EB0
	ldmia sp!, {r3, pc}
_021661BC:
	mov r1, #6
	bl ovl01_2163EB0
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_2166184

	arm_func_start ovl01_21661C8
ovl01_21661C8: // 0x021661C8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0xa3c]
	add r1, r1, #0x300
	ldrh r1, [r1, #0xbc]
	cmp r1, #0
	beq _021661FC
	cmp r1, #1
	beq _02166208
	cmp r1, #2
	beq _02166214
	b _0216625C
_021661FC:
	mov r1, #3
	bl ovl01_2163EB0
	b _0216625C
_02166208:
	mov r1, #3
	bl ovl01_2163EB0
	b _0216625C
_02166214:
	mov r1, #5
	bl ovl01_2163EB0
	mov r2, #0
	mov r0, #0xa6
	sub r1, r0, #0xa7
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0xa3c]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	ldr r3, [r4, #0x4c]
	rsb r2, r0, #0
	mov r0, #0
	bl BossFX__CreateKrackenAngry
_0216625C:
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x1f
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _0216628C // =ovl01_2166290
	str r0, [r4, #0xa48]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216628C: .word ovl01_2166290
	arm_func_end ovl01_21661C8

	arm_func_start ovl01_2166290
ovl01_2166290: // 0x02166290
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	add r1, r6, #0xb00
	ldrh r1, [r1, #0xec]
	mov r4, #0
	mov r5, r4
	tst r1, #0x8000
	beq _021662C8
	ldr r1, [r6, #0xa3c]
	add r1, r1, #0x300
	ldrh r1, [r1, #0xbc]
	bl ovl01_2166184
	mov r4, #1
_021662C8:
	add r0, r6, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	beq _02166300
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r6, #0x1cc
	ldr r2, [r6, #0xa30]
	mov r3, r1
	add r0, r0, #0xc00
	bl BossHelpers__Animation__Func_2038BF0
	mov r5, #1
_02166300:
	cmp r4, #0
	cmpne r5, #0
	movne r0, #0
	strne r0, [r6, #0xa48]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl01_2166290

	arm_func_start ovl01_2166318
ovl01_2166318: // 0x02166318
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	mov r6, r0
	ldr r5, [r6, #0xa3c]
	mov r0, #2
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	mov r4, r0
	mov r2, r1
	mov r3, r1
	str r1, [sp, #0x10]
	mov r0, #0x130
	bl GameObject__SpawnObject
	add ip, r4, #0x20
	mov r4, r0
	str r0, [r5, #0x390]
	add r1, r6, #0xb60
	str r5, [r4, #0x374]
	add lr, r4, #0x44
	ldmia r1, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	ldr r1, [r4, #0x48]
	add r0, r4, #4
	rsb r1, r1, #0
	str r1, [r4, #0x48]
	add r3, r0, #0x400
	ldmia ip, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r3
	ldr r3, [r4, #0x408]
	mov r1, lr
	rsb r3, r3, #0
	add r2, sp, #0x14
	str r3, [r4, #0x408]
	bl VEC_Subtract
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x18]
	mov r1, r1, asr #4
	str r1, [sp, #0x14]
	ldr r1, [sp, #0x1c]
	mov r0, r0, asr #4
	mov r1, r1, asr #4
	str r0, [sp, #0x18]
	add r0, sp, #0x14
	str r1, [sp, #0x1c]
	add r3, r4, #0x98
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x1c]
	bic r0, r0, #0x80
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x18]
	orr r0, r0, #2
	str r0, [r4, #0x18]
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl01_2166318

	arm_func_start ovl01_216640C
ovl01_216640C: // 0x0216640C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	ldr r4, [r0, #0xa3c]
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, _02166458 // =0x00000133
	mov r2, r1
	mov r3, r1
	str r1, [sp, #0x10]
	bl GameObject__SpawnObject
	str r0, [r4, #0x394]
	ldr r1, _0216645C // =ovl01_21683F0
	str r4, [r0, #0x374]
	str r1, [r0, #0x378]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02166458: .word 0x00000133
_0216645C: .word ovl01_21683F0
	arm_func_end ovl01_216640C

	arm_func_start ovl01_2166460
ovl01_2166460: // 0x02166460
	ldr r1, [r0, #0xa50]
	cmp r1, #0
	ldreq r1, _02166484 // =ovl01_216648C
	streq r1, [r0, #0xa40]
	bxeq lr
	cmp r1, #1
	ldreq r1, _02166488 // =ovl01_216653C
	streq r1, [r0, #0xa40]
	bx lr
	.align 2, 0
_02166484: .word ovl01_216648C
_02166488: .word ovl01_216653C
	arm_func_end ovl01_2166460

	arm_func_start ovl01_216648C
ovl01_216648C: // 0x0216648C
	stmdb sp!, {r4, lr}
	ldr r1, _021664D8 // =ovl01_21664DC
	mov r4, r0
	str r1, [r4, #0xa40]
	ldr r0, [r4, #0xa3c]
	mov r1, #0
	add r0, r0, #0x300
	strh r1, [r0, #0xba]
	ldr r0, [r4, #0xa3c]
	bl ovl01_2163458
	mov r1, r0
	mov r0, r4
	bl ovl01_2163F00
	add r1, r4, #0xa00
	mov r2, #0x78
	mov r0, #1
	strh r2, [r1, #0xe6]
	bl SetHUDActiveScreen
	ldmia sp!, {r4, pc}
	.align 2, 0
_021664D8: .word ovl01_21664DC
	arm_func_end ovl01_216648C

	arm_func_start ovl01_21664DC
ovl01_21664DC: // 0x021664DC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	ldr r0, [r4, #0xa3c]
	bl ovl01_21625C8
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	bl ovl01_2162680
	ldr r0, _02166538 // =ovl01_216678C
	mov r1, #0
	str r0, [r4, #0xa40]
	ldr r0, [r4, #0xa3c]
	bl ovl01_2169164
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166538: .word ovl01_216678C
	arm_func_end ovl01_21664DC

	arm_func_start ovl01_216653C
ovl01_216653C: // 0x0216653C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xa3c]
	ldr r1, [r0, #0x388]
	cmp r1, #0
	beq _02166570
	ldr r0, _02166584 // =ovl01_2167EE4
	str r0, [r1, #0x378]
	ldr r0, [r4, #0xa3c]
	ldr r1, [r0, #0x388]
	ldr r0, [r1, #0x20]
	orr r0, r0, #0x20
	str r0, [r1, #0x20]
_02166570:
	mov r0, #1
	bl SetHUDActiveScreen
	ldr r0, _02166588 // =ovl01_216658C
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166584: .word ovl01_2167EE4
_02166588: .word ovl01_216658C
	arm_func_end ovl01_216653C

	arm_func_start ovl01_216658C
ovl01_216658C: // 0x0216658C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r1, #0xf0
	ldr r4, [r5, #0xa3c]
	bl ovl01_2163E64
	ldr r0, [r5, #0xa3c]
	bl ovl01_2162738
	ldr r1, [r4, #0x3d8]
	ldr r2, [r4, #0x3d4]
	mov r0, r4
	bl ovl01_2163494
	cmp r0, #0
	ldrne r0, _021665C8 // =ovl01_21665CC
	strne r0, [r5, #0xa40]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021665C8: .word ovl01_21665CC
	arm_func_end ovl01_216658C

	arm_func_start ovl01_21665CC
ovl01_21665CC: // 0x021665CC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r4, #0xf10
	mov r3, #0x28
	bl BossHelpers__Animation__Func_2038BF0
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x54
	ldr r2, [r4, #0xa30]
	add r0, r0, #0x1000
	mov r3, #0x28
	bl BossHelpers__Animation__Func_2038BF0
	mov r1, #0
	ldr r0, _0216662C // =ovl01_2166630
	str r1, [r4, #0xae8]
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216662C: .word ovl01_2166630
	arm_func_end ovl01_21665CC

	arm_func_start ovl01_2166630
ovl01_2166630: // 0x02166630
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	ldr r0, [r4, #0xa3c]
	bl ovl01_2162738
	ldr r0, _02166714 // =gPlayer
	ldr r2, _02166718 // =0x006BAA99
	ldr r0, [r0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__Func_2038DCC
	mov r1, #0x16
	str r1, [sp]
	add r1, r1, #0x20c
	str r1, [sp, #4]
	str r1, [sp, #8]
	add r2, r4, #0xa00
	mov r1, r0
	ldrh r0, [r2, #0xd6]
	ldrsh r2, [r2, #0xd8]
	mov r3, #0xb
	bl BossHelpers__Math__Func_2039360
	add r1, r4, #0xa00
	strh r0, [r1, #0xd8]
	ldrh r3, [r1, #0xd6]
	ldrsh r2, [r1, #0xd8]
	add r0, r4, #0x1000
	add r2, r3, r2
	strh r2, [r1, #0xd6]
	ldrh r0, [r0, #0x1c]
	tst r0, #0x8000
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x384]
	mov r1, #0
	orr r0, r0, #0x20
	str r0, [r4, #0x384]
	ldr r0, [r4, #0x6e8]
	orr r0, r0, #0x20
	str r0, [r4, #0x6e8]
	ldr r0, [r4, #0xa3c]
	add r0, r0, #0x300
	strh r1, [r0, #0xba]
	ldr r0, [r4, #0xa3c]
	bl ovl01_2163458
	mov r1, r0
	mov r0, r4
	bl ovl01_2163F00
	ldr r1, _0216671C // =ovl01_2166720
	add r0, r4, #0xa00
	str r1, [r4, #0xa40]
	mov r1, #0x78
	strh r1, [r0, #0xe6]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02166714: .word gPlayer
_02166718: .word 0x006BAA99
_0216671C: .word ovl01_2166720
	arm_func_end ovl01_2166630

	arm_func_start ovl01_2166720
ovl01_2166720: // 0x02166720
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	ldr r0, [r4, #0xa3c]
	bl ovl01_2162738
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	bl ovl01_2162680
	ldr r0, _02166788 // =ovl01_216678C
	mov r1, #0
	str r0, [r4, #0xa40]
	ldr r0, [r4, #0xa3c]
	bl ovl01_2169164
	mov r0, #0
	str r0, [r4, #0xa50]
	str r0, [r4, #0xaec]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166788: .word ovl01_216678C
	arm_func_end ovl01_2166720

	arm_func_start ovl01_216678C
ovl01_216678C: // 0x0216678C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x22
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _021667C8 // =ovl01_21667CC
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021667C8: .word ovl01_21667CC
	arm_func_end ovl01_216678C

	arm_func_start ovl01_21667CC
ovl01_21667CC: // 0x021667CC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	ldrne r0, _021667F4 // =ovl01_21667F8
	strne r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021667F4: .word ovl01_21667F8
	arm_func_end ovl01_21667CC

	arm_func_start ovl01_21667F8
ovl01_21667F8: // 0x021667F8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0xa00
	mov r1, #5
	strh r1, [r0, #0xe6]
	mov r1, #0
	add r0, r4, #0x1cc
	str r1, [sp]
	mov r2, #1
	str r2, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x23
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02166844 // =ovl01_2166848
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166844: .word ovl01_2166848
	arm_func_end ovl01_21667F8

	arm_func_start ovl01_2166848
ovl01_2166848: // 0x02166848
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldreq r0, _02166884 // =ovl01_2166888
	streq r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166884: .word ovl01_2166888
	arm_func_end ovl01_2166848

	arm_func_start ovl01_2166888
ovl01_2166888: // 0x02166888
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x24
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _021668C4 // =ovl01_21668C8
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021668C4: .word ovl01_21668C8
	arm_func_end ovl01_2166888

	arm_func_start ovl01_21668C8
ovl01_21668C8: // 0x021668C8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	ldr r0, [r4, #0xeb0]
	ldr r0, [r0]
	cmp r0, #0x1000
	bne _02166918
	mov r0, r4
	bl ovl01_2166318
	mov r2, #0
	mov r0, #0xa4
	sub r1, r0, #0xa5
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02166918:
	ldr r0, [r4, #0xa3c]
	ldr r2, [r0, #0x390]
	cmp r2, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r1, [r2, #0x48]
	ldr r0, [r2, #0x408]
	cmp r1, r0
	addgt sp, sp, #8
	ldmgtia sp!, {r4, pc}
	ldr r1, [r2, #0x18]
	mov r0, r4
	orr r1, r1, #8
	str r1, [r2, #0x18]
	ldr r1, [r4, #0xa3c]
	mov r2, #0
	str r2, [r1, #0x390]
	bl ovl01_216640C
	mov r2, #0
	mov r0, #0xa5
	sub r1, r0, #0xa6
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, _02166994 // =ovl01_2166998
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166994: .word ovl01_2166998
	arm_func_end ovl01_21668C8

	arm_func_start ovl01_2166998
ovl01_2166998: // 0x02166998
	add r1, r0, #0xe00
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldrne r1, _021669B0 // =ovl01_21669B4
	strne r1, [r0, #0xa40]
	bx lr
	.align 2, 0
_021669B0: .word ovl01_21669B4
	arm_func_end ovl01_2166998

	arm_func_start ovl01_21669B4
ovl01_21669B4: // 0x021669B4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x25
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _021669F0 // =ovl01_21669F4
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021669F0: .word ovl01_21669F4
	arm_func_end ovl01_21669B4

	arm_func_start ovl01_21669F4
ovl01_21669F4: // 0x021669F4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	mov r3, r1
	add r0, r0, #0xc00
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02166A50 // =ovl01_2166A54
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166A50: .word ovl01_2166A54
	arm_func_end ovl01_21669F4

	arm_func_start ovl01_2166A54
ovl01_2166A54: // 0x02166A54
	add r1, r0, #0xa00
	mov r3, #0
	ldr r2, _02166A6C // =ovl01_2166A70
	strh r3, [r1, #0xe6]
	str r2, [r0, #0xa40]
	bx lr
	.align 2, 0
_02166A6C: .word ovl01_2166A70
	arm_func_end ovl01_2166A54

	arm_func_start ovl01_2166A70
ovl01_2166A70: // 0x02166A70
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	add r0, r6, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r6, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r2, _02166B24 // =_mt_math_rand
	mov r4, #0
	ldr r3, [r2]
	ldr r0, _02166B28 // =0x00196225
	ldr r1, _02166B2C // =0x3C6EF35F
	mov r5, r4
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	str r1, [r2]
	mov r7, r0, lsl #0x1e
	mov r8, #0x15
_02166ADC:
	ldr r1, [r6, #0xa3c]
	mov r0, r5, lsl #0x10
	add r1, r1, r4, lsl #2
	ldr r1, [r1, #0x398]
	mov r0, r0, lsr #0x10
	add r2, r0, r7, lsr #16
	add r0, r1, #0x400
	strh r2, [r0, #0x44]
	ldr r0, [r6, #0xa3c]
	mov r1, r8
	bl ovl01_2169164
	add r4, r4, #1
	cmp r4, #4
	add r5, r5, #0x4000
	blt _02166ADC
	ldr r0, _02166B30 // =ovl01_2166B34
	str r0, [r6, #0xa40]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02166B24: .word _mt_math_rand
_02166B28: .word 0x00196225
_02166B2C: .word 0x3C6EF35F
_02166B30: .word ovl01_2166B34
	arm_func_end ovl01_2166A70

	arm_func_start ovl01_2166B34
ovl01_2166B34: // 0x02166B34
	stmdb sp!, {r4, lr}
	mov r1, #0xf0
	mov r4, r0
	bl ovl01_2163E64
	ldr r2, [r4, #0xa3c]
	mov r1, #0
_02166B4C:
	add r0, r2, r1, lsl #2
	ldr r0, [r0, #0x398]
	ldr r0, [r0, #0x37c]
	cmp r0, #0x16
	cmpne r0, #0
	cmpne r0, #0xf
	ldmneia sp!, {r4, pc}
	add r1, r1, #1
	cmp r1, #4
	blt _02166B4C
	add r0, r4, #0xa00
	mov r2, #0x258
	ldr r1, _02166B8C // =ovl01_2166B90
	strh r2, [r0, #0xe6]
	str r1, [r4, #0xa40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166B8C: .word ovl01_2166B90
	arm_func_end ovl01_2166B34

	arm_func_start ovl01_2166B90
ovl01_2166B90: // 0x02166B90
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl ovl01_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, _02166BEC // =ovl01_2166BF4
	ldr r2, _02166BF0 // =ovl01_21684EC
	str r0, [r4, #0xa40]
	ldr r0, [r4, #0xa3c]
	mov r1, #0
	ldr r0, [r0, #0x394]
	str r2, [r0, #0x378]
	ldr r0, [r4, #0xa3c]
	str r1, [r0, #0x394]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166BEC: .word ovl01_2166BF4
_02166BF0: .word ovl01_21684EC
	arm_func_end ovl01_2166B90

	arm_func_start ovl01_2166BF4
ovl01_2166BF4: // 0x02166BF4
	ldr r1, _02166C2C // =ovl01_216B5B4
	mov ip, #0
_02166BFC:
	ldr r2, [r0, #0xa3c]
	add r2, r2, ip, lsl #2
	ldr r3, [r2, #0x398]
	add ip, ip, #1
	ldr r2, [r3, #0x37c]
	cmp r2, #0x16
	streq r1, [r3, #0x378]
	cmp ip, #4
	blt _02166BFC
	ldr r1, _02166C30 // =ovl01_2166C34
	str r1, [r0, #0xa40]
	bx lr
	.align 2, 0
_02166C2C: .word ovl01_216B5B4
_02166C30: .word ovl01_2166C34
	arm_func_end ovl01_2166BF4

	arm_func_start ovl01_2166C34
ovl01_2166C34: // 0x02166C34
	stmdb sp!, {r4, lr}
	mov r1, #0xf0
	mov r4, r0
	bl ovl01_2163E64
	ldr r2, [r4, #0xa3c]
	mov r1, #0
_02166C4C:
	add r0, r2, r1, lsl #2
	ldr r0, [r0, #0x398]
	ldr r0, [r0, #0x37c]
	cmp r0, #0
	cmpne r0, #0xf
	ldmneia sp!, {r4, pc}
	add r1, r1, #1
	cmp r1, #4
	blt _02166C4C
	add r0, r4, #0xa00
	ldrh r2, [r0, #0xda]
	ldr r1, _02166C98 // =ovl01_2166C9C
	bic r2, r2, #2
	strh r2, [r0, #0xda]
	ldrh r2, [r0, #0xda]
	bic r2, r2, #0x10
	strh r2, [r0, #0xda]
	str r1, [r4, #0xa40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166C98: .word ovl01_2166C9C
	arm_func_end ovl01_2166C34

	arm_func_start ovl01_2166C9C
ovl01_2166C9C: // 0x02166C9C
	ldr r2, _02166CBC // =ovl01_2166CC4
	ldr ip, _02166CC0 // =SetHUDActiveScreen
	str r2, [r0, #0xa40]
	add r1, r0, #0xa00
	mov r2, #0x78
	mov r0, #0
	strh r2, [r1, #0xe6]
	bx ip
	.align 2, 0
_02166CBC: .word ovl01_2166CC4
_02166CC0: .word SetHUDActiveScreen
	arm_func_end ovl01_2166C9C

	arm_func_start ovl01_2166CC4
ovl01_2166CC4: // 0x02166CC4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xa3c]
	bl ovl01_21622B4
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	bl ovl01_2162370
	ldr r0, [r4, #0xa3c]
	mov r1, #0
	add r0, r0, #0x300
	strh r1, [r0, #0xba]
	ldr r0, [r4, #0xa3c]
	bl ovl01_2163458
	mov r1, r0
	mov r0, r4
	bl ovl01_2163F00
	ldr r0, [r4, #0xa3c]
	mov r1, #0xcc
	add r0, r0, #0x300
	strh r1, [r0, #0xb8]
	ldr r0, [r4, #0xa3c]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0xb8]
	bl UpdateBossHealthHUD
	mov r0, r4
	mov r1, #0
	bl ovl01_2163D10
	ldr r0, [r4, #0xa3c]
	mov r1, #0
	bl ovl01_2169164
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2166CC4

	arm_func_start ovl01_2166D60
ovl01_2166D60: // 0x02166D60
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	add r4, r5, #0xaf0
	mov r1, r4
	mov r0, #0
	mov r2, #0xa
	bl MIi_CpuClear16
	mov r0, #0
_02166D84:
	ldr r1, [r5, #0xa3c]
	add r1, r1, r0, lsl #2
	ldr r2, [r1, #0x398]
	ldr r1, [r2, #0x39c]
	bic r1, r1, #4
	str r1, [r2, #0x39c]
	ldr r1, [r5, #0xa3c]
	add r1, r1, r0, lsl #2
	ldr r2, [r1, #0x398]
	ldr r1, [r2, #0x3dc]
	bic r1, r1, #4
	str r1, [r2, #0x3dc]
	ldr r1, [r5, #0xa3c]
	add r1, r1, r0, lsl #2
	ldr r2, [r1, #0x398]
	add r0, r0, #1
	ldr r1, [r2, #0x41c]
	cmp r0, #4
	bic r1, r1, #4
	str r1, [r2, #0x41c]
	blt _02166D84
	ldr r0, _02166ECC // =playerGameStatus
	ldr r1, [r0]
	bic r1, r1, #1
	str r1, [r0]
	bl StopStageBGM
	ldr r0, _02166ED0 // =gPlayer
	ldr r0, [r0]
	bl Player__Action_Blank
	ldr r0, _02166ED0 // =gPlayer
	mov r1, #0x12
	ldr r0, [r0]
	bl Player__ChangeAction
	mov r2, #0
	ldr r1, _02166ED0 // =gPlayer
	ldr r0, [r1]
	add r0, r0, #0x600
	strh r2, [r0, #0x82]
	ldr r0, [r1]
	bl BossHelpers__Player__LockControl
	mov r0, #0
	str r0, [r5, #0xee4]
	bl EnableObjectManagerFlag2
	ldr r0, [r5, #0x18]
	ldr r1, _02166ED0 // =gPlayer
	orr r0, r0, #0x20
	str r0, [r5, #0x18]
	ldr r3, [r5, #0xa3c]
	mov r0, #0
	ldr r2, [r3, #0x18]
	orr r2, r2, #0x20
	str r2, [r3, #0x18]
	ldr r2, [r5, #0xa3c]
	ldr r3, [r2, #0x394]
	ldr r2, [r3, #0x18]
	orr r2, r2, #0x20
	str r2, [r3, #0x18]
	ldr r3, [r1]
	ldr r1, [r3, #0x1b0]
	ldr r2, [r3, #0x1b4]
	ldr r3, [r3, #0x1b8]
	bl BossFX__CreateKrackenExplode2
	mov r0, #0
	str r0, [sp]
	mov r1, #0xce
	str r1, [sp, #4]
	sub r1, r1, #0xcf
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r3, _02166ED4 // =ovl01_21684EC
	ldr r0, [r5, #0xa3c]
	mov r2, #0
	ldr r1, [r0, #0x394]
	ldr r0, _02166ED8 // =ovl01_2166EDC
	str r3, [r1, #0x378]
	ldr r1, [r5, #0xa3c]
	str r2, [r1, #0x394]
	strh r2, [r4, #8]
	str r0, [r5, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02166ECC: .word playerGameStatus
_02166ED0: .word gPlayer
_02166ED4: .word ovl01_21684EC
_02166ED8: .word ovl01_2166EDC
	arm_func_end ovl01_2166D60

	arm_func_start ovl01_2166EDC
ovl01_2166EDC: // 0x02166EDC
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0xaf0
	ldrh r0, [r1, #8]
	add r0, r0, #1
	strh r0, [r1, #8]
	ldrh r0, [r1, #8]
	cmp r0, #0x5a
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	bl ovl01_21627F0
	ldr r0, _02166F14 // =ovl01_2166F18
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166F14: .word ovl01_2166F18
	arm_func_end ovl01_2166EDC

	arm_func_start ovl01_2166F18
ovl01_2166F18: // 0x02166F18
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl Camera3D__GetWork
	mov r4, r0
	add r1, r4, #0x20
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	ldrh r1, [r4, #0x20]
	add r0, r5, #0xa00
	mov r2, #0
	bic r1, r1, #0xc0
	orr r1, r1, #0xc0
	strh r1, [r4, #0x20]
	ldrh r3, [r4, #0x20]
	ldr r1, _02166F7C // =ovl01_2166F80
	bic r3, r3, #1
	orr r3, r3, #1
	strh r3, [r4, #0x20]
	ldrh r3, [r4, #0x20]
	orr r3, r3, #0x1e
	strh r3, [r4, #0x20]
	strh r2, [r0, #0xf8]
	str r1, [r5, #0xa40]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02166F7C: .word ovl01_2166F80
	arm_func_end ovl01_2166F18

	arm_func_start ovl01_2166F80
ovl01_2166F80: // 0x02166F80
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r10, r0
	ldr r4, [r10, #0xa3c]
	add r8, r10, #0xaf0
	bl Camera3D__GetWork
	add r1, r4, #0x400
	ldrsh r3, [r1, #0x54]
	mvn r2, #0xf
	cmp r3, r2
	beq _02166FD8
	ldrh r2, [r8, #2]
	add r2, r2, #1
	strh r2, [r8, #2]
	ldrh r2, [r8, #2]
	cmp r2, #1
	bls _02166FD8
	mov r2, #0
	strh r2, [r8, #2]
	ldrsh r2, [r1, #0x54]
	sub r2, r2, #1
	strh r2, [r1, #0x54]
_02166FD8:
	ldrh r1, [r0, #0x24]
	cmp r1, #0x10
	bhs _02167010
	ldrh r1, [r8]
	add r1, r1, #1
	strh r1, [r8]
	ldrh r1, [r8]
	cmp r1, #2
	bls _02167010
	mov r1, #0
	strh r1, [r8]
	ldrh r1, [r0, #0x24]
	add r1, r1, #1
	strh r1, [r0, #0x24]
_02167010:
	mov r9, #0
	ldr r7, _021670BC // =BossArena__explosionFXSpawnTime
	mov r11, r9
	mov r6, r9
	mov r5, #0xcd
	mvn r4, #0
_02167028:
	ldrh r1, [r8, #8]
	ldr r0, [r7, r9, lsl #2]
	cmp r1, r0
	bne _02167090
	ldr r1, [r10, #0xa3c]
	mov r0, r11
	ldr r3, [r1, #0x398]
	ldr r1, [r3, #0x4c0]
	ldr r2, [r3, #0x4c4]
	ldr r3, [r3, #0x4c8]
	bl BossFX__CreateKrackenExplode0
	str r6, [sp]
	str r5, [sp, #4]
	ldr r0, [r10, #0xa3c]
	mov r1, r4
	ldr r0, [r0, #0x138]
	mov r2, r4
	mov r3, r4
	bl PlaySfxEx
	add r0, r4, #0x204
	mov r1, #0x2000
	bl CreateDrawFadeTask
	mov r0, #0x3000
	mov r1, r0
	mov r2, #0x600
	bl ShakeScreenEx
_02167090:
	add r9, r9, #1
	cmp r9, #3
	blt _02167028
	ldrh r1, [r8, #8]
	add r0, r1, #1
	strh r0, [r8, #8]
	cmp r1, #0xd2
	ldrhi r0, _021670C0 // =ovl01_21670C4
	strhi r0, [r10, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021670BC: .word BossArena__explosionFXSpawnTime
_021670C0: .word ovl01_21670C4
	arm_func_end ovl01_2166F80

	arm_func_start ovl01_21670C4
ovl01_21670C4: // 0x021670C4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0xa3c]
	mov r0, #0
	ldr r3, [r1, #0x398]
	ldr r1, [r3, #0x4c0]
	ldr r2, [r3, #0x4c4]
	ldr r3, [r3, #0x4c8]
	bl BossFX__CreateKrackenExplode1
	mov r2, #0x2000
	str r2, [r0, #0x38]
	str r2, [r0, #0x3c]
	str r2, [r0, #0x40]
	ldr r1, _0216715C // =0x00000555
	mov r2, #0xe3
	str r1, [r0, #0x280]
	mov r0, #0xa000
	mov r1, #0x3000
	bl ShakeScreenEx
	mov r2, #0
	mov r0, #0x8d
	str r2, [sp]
	sub r1, r0, #0x8e
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r1, _02167160 // =ovl01_2167164
	add r0, r4, #0xa00
	mov r2, #0
	strh r2, [r0, #0xf8]
	mov r0, r4
	str r1, [r4, #0xa40]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216715C: .word 0x00000555
_02167160: .word ovl01_2167164
	arm_func_end ovl01_21670C4

	arm_func_start ovl01_2167164
ovl01_2167164: // 0x02167164
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	mov r7, r0
	ldr r0, [r7, #0xa3c]
	add r4, r7, #0xaf0
	str r0, [sp, #4]
	bl Camera3D__GetWork
	ldrh r1, [r4, #4]
	mov r5, r0
	mov r6, #0
	add r0, r1, #1
	strh r0, [r4, #4]
	ldrh r0, [r4, #4]
	str r6, [sp]
	cmp r0, #3
	bls _021672B8
	ldr r1, _02167358 // =_mt_math_rand
	ldr r2, _0216735C // =0x3C6EF35F
	ldr r3, [r1]
	ldr r1, _02167360 // =0x00196225
	mov r11, #0xc8000
	mla r8, r3, r1, r2
	mla r3, r8, r1, r2
	mla r10, r3, r1, r2
	mov r2, r8, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r1, r3, lsr #0x10
	mov r9, r1, lsl #0x10
	mov r2, r2, asr #4
	umull r8, r3, r2, r11
	mov r1, r10, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov ip, r1, asr #4
	adds r8, r8, #0x800
	mov r9, r9, lsr #0x10
	mov lr, r9, asr #4
	mla r3, r2, r6, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r11, r3
	adc r1, r3, r6
	mov r8, r8, lsr #0xc
	orr r8, r8, r1, lsl #20
	mov r1, ip, asr #0x1f
	add r0, r7, #0xb60
	str r1, [sp, #8]
	ldmia r0, {r0, r1, r2}
	ldr r9, _02167358 // =_mt_math_rand
	mov r3, lr, asr #0x1f
	str r10, [r9]
	add r9, sp, #0xc
	stmia r9, {r0, r1, r2}
	umull r10, r9, lr, r11
	mla r9, lr, r6, r9
	mla r9, r3, r11, r9
	adds r10, r10, #0x800
	adc r3, r9, r6
	mov r9, r10, lsr #0xc
	orr r9, r9, r3, lsl #20
	sub r3, r9, #0x64000
	ldr r2, [sp, #0x14]
	ldr r9, [sp, #8]
	add r3, r2, r3
	mov r2, #0x96000
	umull r11, r10, ip, r2
	mla r10, ip, r6, r10
	mla r10, r9, r2, r10
	adds r9, r11, #0x800
	ldr r0, [sp, #0xc]
	sub r8, r8, #0x64000
	add r1, r0, r8
	adc r2, r10, r6
	mov r9, r9, lsr #0xc
	orr r9, r9, r2, lsl #20
	ldr r8, [sp, #0x10]
	add r2, r9, #0x1e000
	add r2, r8, r2
	mov r0, r6
	str r1, [sp, #0xc]
	str r3, [sp, #0x14]
	str r2, [sp, #0x10]
	bl BossFX__CreateBomb2
	mov r0, r6
	strh r0, [r4, #4]
_021672B8:
	ldr r0, [sp, #4]
	add r0, r0, #0x400
	ldrsh r1, [r0, #0x54]
	cmp r1, #0
	addne r1, r1, #1
	strneh r1, [r0, #0x54]
	ldrsh r0, [r5, #0x58]
	moveq r6, #1
	cmp r0, #0x10
	bge _02167328
	ldrh r0, [r4, #8]
	cmp r0, #0xb4
	bls _02167330
	ldrh r0, [r4, #6]
	add r0, r0, #1
	strh r0, [r4, #6]
	ldrh r0, [r4, #6]
	cmp r0, #3
	bls _02167330
	ldrsh r1, [r5, #0x58]
	mov r0, #0
	add r1, r1, #1
	strh r1, [r5, #0x58]
	ldrsh r1, [r5, #0xb4]
	add r1, r1, #1
	strh r1, [r5, #0xb4]
	strh r0, [r4, #6]
	b _02167330
_02167328:
	mov r0, #1
	str r0, [sp]
_02167330:
	ldrh r0, [r4, #8]
	cmp r6, #0
	add r0, r0, #1
	strh r0, [r4, #8]
	ldrne r0, [sp]
	cmpne r0, #0
	ldrne r0, _02167364 // =ovl01_2167368
	strne r0, [r7, #0xa40]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02167358: .word _mt_math_rand
_0216735C: .word 0x3C6EF35F
_02167360: .word 0x00196225
_02167364: .word ovl01_2167368
	arm_func_end ovl01_2167164

	arm_func_start ovl01_2167368
ovl01_2167368: // 0x02167368
	ldr r0, _0216737C // =playerGameStatus
	ldr r1, [r0]
	orr r1, r1, #4
	str r1, [r0]
	bx lr
	.align 2, 0
_0216737C: .word playerGameStatus
	arm_func_end ovl01_2167368

	arm_func_start ovl01_2167380
ovl01_2167380: // 0x02167380
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x378]
	blx r1
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_2167380

	arm_func_start ovl01_2167390
ovl01_2167390: // 0x02167390
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x410
	bl AnimatorMDL__Release
	add r0, r4, #0x154
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_2167390

	arm_func_start ovl01_21673C0
ovl01_21673C0: // 0x021673C0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x24
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	addne sp, sp, #0x24
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r4, #0x37c]
	sub r0, r0, #2
	cmp r0, #1
	addls r0, r4, #0x154
	addls r5, r0, #0x400
	bls _021674BC
	mov r2, #0
	mov r3, #0x1000
	add r1, sp, #0xc
	add r0, r4, #0x98
	str r3, [sp, #0x18]
	str r2, [sp, #0x1c]
	str r2, [sp, #0x20]
	add r5, r4, #0x410
	bl VEC_Normalize
	ldr r0, [sp, #0x10]
	ldr ip, [sp, #0x14]
	rsb r1, r0, #0
	smull r0, r3, r1, r1
	adds r6, r0, #0x800
	smull r2, r0, ip, ip
	adc r3, r3, #0
	adds r2, r2, #0x800
	mov r6, r6, lsr #0xc
	adc r0, r0, #0
	mov r2, r2, lsr #0xc
	orr r6, r6, r3, lsl #20
	orr r2, r2, r0, lsl #20
	ldr r7, [sp, #0xc]
	add r0, r6, r2
	str r1, [sp, #0x10]
	bl FX_Sqrt
	mov r1, r7
	bl FX_Atan2Idx
	mov r6, r0
	add r0, sp, #0x18
	add r1, sp, #0xc
	add r2, sp, #0
	bl VEC_CrossProduct
	add r0, sp, #0
	mov r1, r0
	bl VEC_Normalize
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r2, r0, lsl #1
	mov lr, r2, lsl #1
	add r2, r2, #1
	ldr ip, _021674F0 // =FX_SinCosTable_
	mov r3, r2, lsl #1
	ldrsh r2, [ip, lr]
	ldrsh r3, [ip, r3]
	add r0, r5, #0x24
	add r1, sp, #0
	bl MTX_RotAxis33
_021674BC:
	add r0, r4, #0x44
	add r3, r5, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r5, #0x4c]
	mov r0, r5
	rsb r1, r1, #0
	str r1, [r5, #0x4c]
	bl AnimatorMDL__ProcessAnimation
	mov r0, r5
	bl AnimatorMDL__Draw
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_021674F0: .word FX_SinCosTable_
	arm_func_end ovl01_21673C0

	arm_func_start ovl01_21674F4
ovl01_21674F4: // 0x021674F4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x18]
	tst r1, #0xc
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	tst r1, #2
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r5, _02167594 // =0x006BAA99
	ldr r4, _02167598 // =0x00107FC0
	add r9, r0, #0x218
	add r10, r0, #0x380
	mov r8, #0
	add r7, r0, #0x44
	mov r11, #0x40000
	add r6, sp, #8
_0216753C:
	ldmia r7, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	ldr r0, [sp, #0xc]
	rsb r0, r0, #0
	str r0, [sp, #0xc]
	ldr r0, [r9, #0x18]
	tst r0, #4
	beq _02167578
	str r5, [sp]
	mov r0, r9
	mov r1, r10
	mov r2, r6
	mov r3, r11
	str r4, [sp, #4]
	bl BossHelpers__Collision__Func_203919C
_02167578:
	add r8, r8, #1
	cmp r8, #2
	add r9, r9, #0x40
	add r10, r10, #0x40
	blt _0216753C
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02167594: .word 0x006BAA99
_02167598: .word 0x00107FC0
	arm_func_end ovl01_21674F4

	arm_func_start ovl01_216759C
ovl01_216759C: // 0x0216759C
	bx lr
	arm_func_end ovl01_216759C

	arm_func_start ovl01_21675A0
ovl01_21675A0: // 0x021675A0
	stmdb sp!, {r3, lr}
	str r1, [r0, #0x37c]
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _021675F0
_021675B4: // jump table
	b _021675C4 // case 0
	b _021675D0 // case 1
	b _021675DC // case 2
	b _021675E8 // case 3
_021675C4:
	ldr r1, _021675FC // =ovl01_216760C
	str r1, [r0, #0x378]
	b _021675F0
_021675D0:
	ldr r1, _02167600 // =ovl01_216768C
	str r1, [r0, #0x378]
	b _021675F0
_021675DC:
	ldr r1, _02167604 // =ovl01_2167764
	str r1, [r0, #0x378]
	b _021675F0
_021675E8:
	ldr r1, _02167608 // =ovl01_2167784
	str r1, [r0, #0x378]
_021675F0:
	ldr r1, [r0, #0x378]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_021675FC: .word ovl01_216760C
_02167600: .word ovl01_216768C
_02167604: .word ovl01_2167764
_02167608: .word ovl01_2167784
	arm_func_end ovl01_21675A0

	arm_func_start ovl01_216760C
ovl01_216760C: // 0x0216760C
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x70
	ldr r1, _02167670 // =ovl01_216767C
	mov r4, r0
	str r1, [r4, #0x378]
	ldr r0, _02167674 // =gameArchiveStage
	ldr r1, _02167678 // =aExc_3
	ldr r2, [r0]
	add r0, sp, #8
	bl NNS_FndMountArchive
	add r0, sp, #8
	mov r1, #0x1a
	bl NNS_FndGetArchiveFileByIndex
	mov r1, #0
	mov r2, r0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	mov r3, r1
	add r0, r4, #0x410
	bl BossHelpers__Animation__Func_2038BF0
	add r0, sp, #8
	bl NNS_FndUnmountArchive
	add sp, sp, #0x70
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167670: .word ovl01_216767C
_02167674: .word gameArchiveStage
_02167678: .word aExc_3
	arm_func_end ovl01_216760C

	arm_func_start ovl01_216767C
ovl01_216767C: // 0x0216767C
	ldr ip, _02167688 // =ovl01_21675A0
	mov r1, #1
	bx ip
	.align 2, 0
_02167688: .word ovl01_21675A0
	arm_func_end ovl01_216767C

	arm_func_start ovl01_216768C
ovl01_216768C: // 0x0216768C
	ldr r1, _02167698 // =ovl01_216769C
	str r1, [r0, #0x378]
	bx lr
	.align 2, 0
_02167698: .word ovl01_216769C
	arm_func_end ovl01_216768C

	arm_func_start ovl01_216769C
ovl01_216769C: // 0x0216769C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	add r0, r4, #0x58
	add r0, r0, #0x400
	add r3, sp, #8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0
	mov r0, r3
	str r1, [sp, #0xc]
	bl VEC_Mag
	cmp r0, #0
	add r0, sp, #8
	bge _021676E4
	bl VEC_Mag
	rsb r0, r0, #0
	b _021676E8
_021676E4:
	bl VEC_Mag
_021676E8:
	ldr r1, _02167760 // =0x000D3300
	cmp r0, r1
	ldrge r0, [r4, #0x270]
	orrge r0, r0, #4
	strge r0, [r4, #0x270]
	ldr r0, [r4, #0x1c]
	tst r0, #0xf
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	mov r3, #0
	str r3, [r4, #0x98]
	str r3, [r4, #0x9c]
	str r3, [r4, #0xa0]
	ldr r1, [r4, #0x374]
	mov r0, #0xa5
	ldr r2, [r1, #0x3c4]
	sub r1, r0, #0xa6
	sub r2, r2, #0x1000
	str r2, [r4, #0x48]
	str r3, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, r4
	mov r1, #2
	bl ovl01_21675A0
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02167760: .word 0x000D3300
	arm_func_end ovl01_216769C

	arm_func_start ovl01_2167764
ovl01_2167764: // 0x02167764
	ldr r2, [r0, #0x270]
	ldr r1, _0216777C // =ovl01_2167780
	bic r2, r2, #4
	str r2, [r0, #0x270]
	str r1, [r0, #0x378]
	bx lr
	.align 2, 0
_0216777C: .word ovl01_2167780
	arm_func_end ovl01_2167764

	arm_func_start ovl01_2167780
ovl01_2167780: // 0x02167780
	bx lr
	arm_func_end ovl01_2167780

	arm_func_start ovl01_2167784
ovl01_2167784: // 0x02167784
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x70
	ldr r1, _021677E8 // =gameArchiveStage
	mov r4, r0
	ldr r2, [r1]
	ldr r1, _021677EC // =aExc_3
	add r0, sp, #8
	bl NNS_FndMountArchive
	add r0, sp, #8
	mov r1, #0x1b
	bl NNS_FndGetArchiveFileByIndex
	mov r3, #0
	str r3, [sp]
	add r1, r4, #0x154
	mov r2, r0
	add r0, r1, #0x400
	mov r1, #1
	str r3, [sp, #4]
	bl BossHelpers__Animation__Func_2038BF0
	add r0, sp, #8
	bl NNS_FndUnmountArchive
	ldr r0, _021677F0 // =ovl01_21677F4
	str r0, [r4, #0x378]
	add sp, sp, #0x70
	ldmia sp!, {r4, pc}
	.align 2, 0
_021677E8: .word gameArchiveStage
_021677EC: .word aExc_3
_021677F0: .word ovl01_21677F4
	arm_func_end ovl01_2167784

	arm_func_start ovl01_21677F4
ovl01_21677F4: // 0x021677F4
	add r1, r0, #0x600
	ldrh r1, [r1, #0x62]
	tst r1, #0x8000
	ldrne r1, [r0, #0x18]
	orrne r1, r1, #4
	strne r1, [r0, #0x18]
	bx lr
	arm_func_end ovl01_21677F4

	arm_func_start ovl01_2167810
ovl01_2167810: // 0x02167810
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x3c
	mov r4, r0
	add r0, r4, #0x300
	ldrh r1, [r0, #0xc8]
	cmp r1, #2
	bne _021678AC
	ldr r1, _02167960 // =gPlayer
	mov r2, #0
	str r2, [r4, #0x44]
	ldr r2, [r1]
	ldr r1, _02167964 // =0x0020FF80
	ldr r2, [r2, #0x48]
	ldr r3, _02167968 // =FX_SinCosTable_
	str r2, [r4, #0x48]
	str r1, [r4, #0x4c]
	ldrh r1, [r0, #0x7c]
	add r0, sp, #0xc
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY43_
	add lr, sp, #0xc
	ldmia lr!, {r0, r1, r2, r3}
	add ip, r4, #0x380
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r1, [lr]
	add r0, r4, #0x44
	str r1, [ip]
	add r1, sp, #0xc
	mov r2, r0
	bl MTX_MultVec43
	b _0216794C
_021678AC:
	ldr r1, [r4, #0x374]
	ldr r2, _02167968 // =FX_SinCosTable_
	ldr r1, [r1, #0x374]
	mov ip, #0
	add r1, r1, #0xa00
	ldrh r3, [r1, #0xd4]
	add r0, sp, #0
	mov r1, r0
	add r3, r3, #0x4000
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, asr #4
	mov r3, r3, lsl #2
	ldrsh r3, [r2, r3]
	str ip, [sp, #4]
	str r3, [sp]
	ldr r3, [r4, #0x374]
	ldr r3, [r3, #0x374]
	add r3, r3, #0xa00
	ldrh r3, [r3, #0xd4]
	add r3, r3, #0x4000
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, asr #4
	mov r3, r3, lsl #1
	add r3, r3, #1
	mov r3, r3, lsl #1
	ldrsh r2, [r2, r3]
	str r2, [sp, #8]
	bl VEC_Normalize
	ldr r0, _0216796C // =FX_SinCosTable_+0x800
	add r1, sp, #0
	ldrsh r2, [r0]
	ldrsh r3, [r0, #2]
	add r0, r4, #0x3a4
	bl MTX_RotAxis33
_0216794C:
	ldr r1, [r4, #0x378]
	mov r0, r4
	blx r1
	add sp, sp, #0x3c
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02167960: .word gPlayer
_02167964: .word 0x0020FF80
_02167968: .word FX_SinCosTable_
_0216796C: .word FX_SinCosTable_+0x800
	arm_func_end ovl01_2167810

	arm_func_start ovl01_2167970
ovl01_2167970: // 0x02167970
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x3d0
	bl AnimatorMDL__Release
	add r0, r4, #0x114
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	add r0, r4, #0x258
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_2167970

	arm_func_start ovl01_21679AC
ovl01_21679AC: // 0x021679AC
	stmdb sp!, {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x374]
	ldr r0, [r4, #0x20]
	ldr r5, [r1, #0x374]
	tst r0, #0x20
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r4, #0x300
	ldrh r0, [r0, #0xc8]
	cmp r0, #0
	beq _021679F0
	cmp r0, #1
	beq _02167A40
	cmp r0, #2
	beq _02167A90
	b _02167AD0
_021679F0:
	add r0, r4, #0x138
	add lr, r4, #0x3a4
	add ip, r0, #0x400
	mov r6, ip
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r2, [lr]
	mov r0, r6
	mov r1, r6
	str r2, [ip]
	bl Unknown2066510__NormalizeScale
	add r0, r4, #0x114
	add r6, r0, #0x400
	add r0, r5, #0xb60
	add r3, r6, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	b _02167AD0
_02167A40:
	add r0, r4, #0x27c
	add lr, r4, #0x3a4
	add ip, r0, #0x400
	mov r6, ip
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r2, [lr]
	mov r0, r6
	mov r1, r6
	str r2, [ip]
	bl Unknown2066510__NormalizeScale
	add r0, r4, #0x258
	add r6, r0, #0x400
	add r0, r5, #0xb60
	add r3, r6, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	b _02167AD0
_02167A90:
	add r6, r4, #0x380
	add r5, r4, #0x3f4
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldr r0, [r6]
	add r6, r4, #0x3d0
	str r0, [r5]
	add r0, r4, #0x44
	add r3, r6, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r6, #0x4c]
	rsb r0, r0, #0
	str r0, [r6, #0x4c]
_02167AD0:
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldr r0, [r6, #0x94]
	beq _02167AEC
	mov r1, #1
	bl NNS_G3dMdlSetMdlDepthTestCondAll
	b _02167AF4
_02167AEC:
	mov r1, #0
	bl NNS_G3dMdlSetMdlDepthTestCondAll
_02167AF4:
	mov r0, r6
	bl AnimatorMDL__ProcessAnimation
	mov r0, r6
	bl AnimatorMDL__Draw
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl01_21679AC

	arm_func_start ovl01_2167B08
ovl01_2167B08: // 0x02167B08
	stmdb sp!, {r4, lr}
	ldr r3, _02167B40 // =gPlayer
	mov r4, r0
	ldr r0, [r3]
	ldr r2, _02167B44 // =0x006BAA99
	ldr r0, [r0, #0x48]
	mov r1, #0x40000
	str r0, [r4, #0x48]
	ldr r0, [r3]
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__Func_2038DCC
	add r1, r4, #0x300
	strh r0, [r1, #0x7c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167B40: .word gPlayer
_02167B44: .word 0x006BAA99
	arm_func_end ovl01_2167B08

	arm_func_start ovl01_2167B48
ovl01_2167B48: // 0x02167B48
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	ldr r4, [r0, #0x374]
	mov r5, r1
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, _02167BB8 // =0x00000132
	mov r2, r1
	mov r3, r1
	str r1, [sp, #0x10]
	bl GameObject__SpawnObject
	str r0, [r4, #0x38c]
	str r4, [r0, #0x374]
	ldr r1, [r4, #0x374]
	mov r2, #0
	ldr r3, [r1, #0x48]
	add r1, r0, #0x300
	str r2, [r0, #0x44]
	str r3, [r0, #0x48]
	str r2, [r0, #0x4c]
	strh r5, [r1, #0xa0]
	sub r0, r2, #0x2e
	strh r0, [r1, #0xa2]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02167BB8: .word 0x00000132
	arm_func_end ovl01_2167B48

	arm_func_start ovl01_2167BBC
ovl01_2167BBC: // 0x02167BBC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl Camera3D__GetWork
	mov r4, r0
	add r1, r4, #0x7c
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	mov r0, r5, asr #0x1f
	mov r1, r0, lsl #0x10
	ldrh r2, [r4, #0x7c]
	orr r1, r1, r5, lsr #16
	bic r0, r2, #1
	orr r0, r0, #1
	strh r0, [r4, #0x7c]
	mov r0, #0x800
	ldrh r3, [r4, #0x7c]
	adds r2, r0, r5, lsl #16
	bic r0, r3, #0xc0
	orr r3, r0, #0xc0
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	movs r0, r1, asr #0xc
	strh r3, [r4, #0x7c]
	rsbmi r0, r0, #0
	ldrh r1, [r4, #0x80]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bic r1, r1, #0x1f
	and r0, r0, #0x1f
	orr r0, r1, r0
	strh r0, [r4, #0x80]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_2167BBC

	arm_func_start ovl01_2167C44
ovl01_2167C44: // 0x02167C44
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x70
	mov r4, r0
	mov r2, #0
	str r2, [r4, #0x3cc]
	ldr r1, [r4, #0x20]
	add r0, r4, #0x300
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	strh r2, [r0, #0xc8]
	ldr r1, _02167CF0 // =gameArchiveStage
	add r0, sp, #8
	ldr r2, [r1]
	ldr r1, _02167CF4 // =aExc_3
	bl NNS_FndMountArchive
	add r0, sp, #8
	mov r1, #0x1d
	bl NNS_FndGetArchiveFileByIndex
	mov r1, #0
	str r1, [sp]
	add ip, r4, #0x114
	mov r2, r0
	mov r3, r1
	add r0, ip, #0x400
	str r1, [sp, #4]
	bl BossHelpers__Animation__Func_2038BF0
	add r0, sp, #8
	mov r1, #0x1e
	bl NNS_FndGetArchiveFileByIndex
	mov r2, r0
	mov r3, #0
	add r0, r4, #0x114
	str r3, [sp]
	add r0, r0, #0x400
	mov r1, #3
	str r3, [sp, #4]
	bl BossHelpers__Animation__Func_2038BF0
	add r0, sp, #8
	bl NNS_FndUnmountArchive
	ldr r0, _02167CF8 // =ovl01_2167CFC
	str r0, [r4, #0x378]
	add sp, sp, #0x70
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167CF0: .word gameArchiveStage
_02167CF4: .word aExc_3
_02167CF8: .word ovl01_2167CFC
	arm_func_end ovl01_2167C44

	arm_func_start ovl01_2167CFC
ovl01_2167CFC: // 0x02167CFC
	add r1, r0, #0x600
	ldrh r1, [r1, #0x20]
	tst r1, #0x8000
	ldrne r1, _02167D14 // =ovl01_2167D18
	strne r1, [r0, #0x378]
	bx lr
	.align 2, 0
_02167D14: .word ovl01_2167D18
	arm_func_end ovl01_2167CFC

	arm_func_start ovl01_2167D18
ovl01_2167D18: // 0x02167D18
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x70
	mov r4, r0
	ldr r1, _02167DDC // =gameArchiveStage
	add r0, r4, #0x300
	mov r2, #1
	strh r2, [r0, #0xc8]
	ldr r2, [r1]
	ldr r1, _02167DE0 // =aExc_3
	add r0, sp, #8
	bl NNS_FndMountArchive
	add r0, sp, #8
	mov r1, #0x1d
	bl NNS_FndGetArchiveFileByIndex
	mov r1, #0
	add ip, r4, #0x258
	mov r2, r0
	str r1, [sp]
	mov r3, #1
	add r0, ip, #0x400
	str r3, [sp, #4]
	bl BossHelpers__Animation__Func_2038BF0
	add r0, sp, #8
	mov r1, #0x1e
	bl NNS_FndGetArchiveFileByIndex
	mov r2, r0
	mov r0, #0
	str r0, [sp]
	add r0, r4, #0x258
	mov r3, #1
	add r0, r0, #0x400
	mov r1, #3
	str r3, [sp, #4]
	bl BossHelpers__Animation__Func_2038BF0
	add r0, sp, #8
	bl NNS_FndUnmountArchive
	mov r1, #0x78
	add r0, r4, #0x300
	strh r1, [r0, #0xca]
	ldr r1, [r4, #0x374]
	mov r0, r4
	ldr r1, [r1, #0x374]
	add r1, r1, #0xa00
	ldrh r1, [r1, #0xd6]
	bl ovl01_2167B48
	ldr r0, _02167DE4 // =ovl01_2167DE8
	str r0, [r4, #0x378]
	add sp, sp, #0x70
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167DDC: .word gameArchiveStage
_02167DE0: .word aExc_3
_02167DE4: .word ovl01_2167DE8
	arm_func_end ovl01_2167D18

	arm_func_start ovl01_2167DE8
ovl01_2167DE8: // 0x02167DE8
	add r1, r0, #0x300
	ldrh r2, [r1, #0xca]
	cmp r2, #0
	subne r0, r2, #1
	strneh r0, [r1, #0xca]
	ldreq r1, _02167E08 // =ovl01_2167E0C
	streq r1, [r0, #0x378]
	bx lr
	.align 2, 0
_02167E08: .word ovl01_2167E0C
	arm_func_end ovl01_2167DE8

	arm_func_start ovl01_2167E0C
ovl01_2167E0C: // 0x02167E0C
	ldr r1, _02167E18 // =ovl01_2167E1C
	str r1, [r0, #0x378]
	bx lr
	.align 2, 0
_02167E18: .word ovl01_2167E1C
	arm_func_end ovl01_2167E0C

	arm_func_start ovl01_2167E1C
ovl01_2167E1C: // 0x02167E1C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl01_2167B08
	ldr r0, [r4, #0x3cc]
	cmp r0, #0x1000
	addlt r0, r0, #0x80
	strlt r0, [r4, #0x3cc]
	blt _02167E60
	add r0, r4, #0x300
	mov r1, #2
	strh r1, [r0, #0xc8]
	ldr r0, [r4, #0x374]
	ldr r2, _02167E6C // =ovl01_216821C
	ldr r1, [r0, #0x38c]
	ldr r0, _02167E70 // =ovl01_2167E74
	str r2, [r1, #0x378]
	str r0, [r4, #0x378]
_02167E60:
	ldr r0, [r4, #0x3cc]
	bl ovl01_2167BBC
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167E6C: .word ovl01_216821C
_02167E70: .word ovl01_2167E74
	arm_func_end ovl01_2167E1C

	arm_func_start ovl01_2167E74
ovl01_2167E74: // 0x02167E74
	add r1, r0, #0x300
	mov r3, #0x3e8
	ldr r2, _02167E8C // =ovl01_2167E90
	strh r3, [r1, #0xca]
	str r2, [r0, #0x378]
	bx lr
	.align 2, 0
_02167E8C: .word ovl01_2167E90
	arm_func_end ovl01_2167E74

	arm_func_start ovl01_2167E90
ovl01_2167E90: // 0x02167E90
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl01_2167B08
	ldr r0, [r4, #0x3cc]
	cmp r0, #0x800
	subgt r0, r0, #0x40
	strgt r0, [r4, #0x3cc]
	ldr r0, [r4, #0x3cc]
	bl ovl01_2167BBC
	add r0, r4, #0x300
	ldrh r1, [r0, #0xca]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xca]
	add r0, r4, #0x300
	ldrh r0, [r0, #0xca]
	cmp r0, #0
	ldreq r0, _02167EE0 // =ovl01_2167EE4
	streq r0, [r4, #0x378]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167EE0: .word ovl01_2167EE4
	arm_func_end ovl01_2167E90

	arm_func_start ovl01_2167EE4
ovl01_2167EE4: // 0x02167EE4
	add r1, r0, #0x300
	mov r2, #0x78
	strh r2, [r1, #0xca]
	ldr r1, [r0, #0x374]
	ldr r2, [r1, #0x38c]
	cmp r2, #0
	ldrne r1, _02167F10 // =ovl01_216821C
	strne r1, [r2, #0x378]
	ldr r1, _02167F14 // =ovl01_2167F18
	str r1, [r0, #0x378]
	bx lr
	.align 2, 0
_02167F10: .word ovl01_216821C
_02167F14: .word ovl01_2167F18
	arm_func_end ovl01_2167EE4

	arm_func_start ovl01_2167F18
ovl01_2167F18: // 0x02167F18
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl01_2167B08
	ldr r0, [r4, #0x3cc]
	cmp r0, #0
	subgt r0, r0, #0x20
	movle r0, #0
	str r0, [r4, #0x3cc]
	ldr r0, [r4, #0x3cc]
	bl ovl01_2167BBC
	add r0, r4, #0x300
	ldrh r1, [r0, #0xca]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xca]
	add r0, r4, #0x300
	ldrh r0, [r0, #0xca]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x18]
	mov r1, #0
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x374]
	str r1, [r0, #0x388]
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2167F18

	arm_func_start ovl01_2167F80
ovl01_2167F80: // 0x02167F80
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x300
	ldrh r1, [r0, #0xa0]
	ldr r3, _02167FD0 // =FX_SinCosTable_
	add r0, r4, #0x37c
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	ldr r1, [r4, #0x378]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167FD0: .word FX_SinCosTable_
	arm_func_end ovl01_2167F80

	arm_func_start ovl01_2167FD4
ovl01_2167FD4: // 0x02167FD4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl GetTaskWork_
	ldr r1, [r0, #0x374]
	mov r4, #0
	str r4, [r1, #0x38c]
	add r5, r0, #0x3a8
_02167FF0:
	mov r0, r5
	bl AnimatorSprite3D__Release
	add r4, r4, #1
	cmp r4, #3
	add r5, r5, #0x104
	blt _02167FF0
	mov r0, r6
	bl StageTask_Destructor
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl01_2167FD4

	arm_func_start ovl01_2168014
ovl01_2168014: // 0x02168014
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x3c
	bl GetCurrentTaskWork_
	mov r7, r0
	ldr r0, [r7, #0x20]
	tst r0, #0x20
	addne sp, sp, #0x3c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r10, _021681A0 // =_0217A928
	ldr r11, _021681A4 // =0x55555556
	mov r9, #0
	add r5, r7, #0x3a8
	add r4, r7, #0x44
	add r6, sp, #0x30
_0216804C:
	smull r0, r1, r11, r9
	add r1, r1, r9, lsr #31
	mov r0, #3
	smull r1, r2, r0, r1
	sub r1, r9, r1
	add r3, r1, r1, lsl #6
	ldmia r10, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	add r8, r5, r3, lsl #2
	add r3, r8, #0x48
	ldmia r4, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r8, #0x4c]
	mov r0, r3
	rsb r1, r1, #0
	str r1, [r8, #0x4c]
	mov r2, r3
	mov r1, r6
	bl VEC_Add
	add r0, r8, #0x48
	add r1, r7, #0x37c
	mov r2, r0
	bl MTX_MultVec33
	ldr r0, [r7, #0x3a4]
	ldr r1, [r8, #0xf4]
	mov r0, r0, asr #0xc
	bic r1, r1, #0x1f0000
	mov r0, r0, lsl #0x1b
	orr r0, r1, r0, lsr #11
	str r0, [r8, #0xf4]
	mov r0, r8
	bl AnimatorSprite3D__Draw
	add r9, r9, #1
	add r10, r10, #0xc
	cmp r9, #6
	blt _0216804C
	ldr r8, _021681A0 // =_0217A928
	mov r9, #0
	add r5, r7, #0x3a8
	add r4, r7, #0x44
	add r6, sp, #0x24
	add r11, sp, #0
_021680F4:
	ldr r0, _021681A4 // =0x55555556
	smull r1, r2, r0, r9
	add r2, r2, r9, lsr #31
	mov r0, #3
	smull r1, r2, r0, r2
	sub r2, r9, r1
	add r3, r2, r2, lsl #6
	ldmia r8, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	add r10, r5, r3, lsl #2
	add r3, r10, #0x48
	ldmia r4, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r10, #0x4c]
	mov r0, r3
	rsb r1, r1, #0
	add r1, r1, #0x3c000
	str r1, [r10, #0x4c]
	mov r2, r3
	mov r1, r6
	bl VEC_Add
	add r0, r7, #0x37c
	mov r1, r11
	bl MTX_Transpose33_
	add r0, r10, #0x48
	mov r1, r11
	mov r2, r0
	bl MTX_MultVec33
	ldr r0, [r7, #0x3a4]
	ldr r1, [r10, #0xf4]
	mov r0, r0, asr #0xc
	bic r1, r1, #0x1f0000
	mov r0, r0, lsl #0x1b
	orr r0, r1, r0, lsr #11
	str r0, [r10, #0xf4]
	mov r0, r10
	bl AnimatorSprite3D__Draw
	add r9, r9, #1
	add r8, r8, #0xc
	cmp r9, #6
	blt _021680F4
	add sp, sp, #0x3c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021681A0: .word _0217A928
_021681A4: .word 0x55555556
	arm_func_end ovl01_2168014

	arm_func_start ovl01_21681A8
ovl01_21681A8: // 0x021681A8
	add r1, r0, #0x9c
	add r3, r1, #0x400
	mov r2, #0
_021681B4:
	ldr r1, [r3]
	add r2, r2, #1
	bic r1, r1, #0x1f0000
	orr r1, r1, #0x10000
	str r1, [r3]
	cmp r2, #3
	add r3, r3, #0x104
	blt _021681B4
	mov r2, #0x1000
	ldr r1, _021681E8 // =ovl01_21681EC
	str r2, [r0, #0x3a4]
	str r1, [r0, #0x378]
	bx lr
	.align 2, 0
_021681E8: .word ovl01_21681EC
	arm_func_end ovl01_21681A8

	arm_func_start ovl01_21681EC
ovl01_21681EC: // 0x021681EC
	add r1, r0, #0x300
	ldrsh r3, [r1, #0xa0]
	ldrsh r2, [r1, #0xa2]
	add r2, r3, r2
	strh r2, [r1, #0xa0]
	ldr r1, [r0, #0x3a4]
	add r1, r1, #0x400
	str r1, [r0, #0x3a4]
	cmp r1, #0x1f000
	movgt r1, #0x1f000
	strgt r1, [r0, #0x3a4]
	bx lr
	arm_func_end ovl01_21681EC

	arm_func_start ovl01_216821C
ovl01_216821C: // 0x0216821C
	ldr r1, _02168228 // =ovl01_216822C
	str r1, [r0, #0x378]
	bx lr
	.align 2, 0
_02168228: .word ovl01_216822C
	arm_func_end ovl01_216821C

	arm_func_start ovl01_216822C
ovl01_216822C: // 0x0216822C
	ldr r1, [r0, #0x3a4]
	sub r1, r1, #0x1000
	str r1, [r0, #0x3a4]
	cmp r1, #0
	bxgt lr
	mov r2, #0
	str r2, [r0, #0x3a4]
	ldr r1, [r0, #0x18]
	orr r1, r1, #4
	str r1, [r0, #0x18]
	ldr r0, [r0, #0x374]
	str r2, [r0, #0x38c]
	bx lr
	arm_func_end ovl01_216822C

	arm_func_start ovl01_2168260
ovl01_2168260: // 0x02168260
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x30
	mov r4, r0
	mov r0, #2
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	mov ip, r0
	ldr r1, [r4, #0x374]
	mov r2, #1
	str r2, [r1, #0x420]
	add r3, sp, #0
	add r0, ip, #0x20
	add r1, ip, #0x2c
	add r2, ip, #0x38
	bl Unknown2066510__Func_2066A4C
	add r0, sp, #0x24
	add r3, r4, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x48]
	add lr, sp, #0
	rsb r0, r0, #0
	str r0, [r4, #0x48]
	ldmia lr!, {r0, r1, r2, r3}
	add ip, r4, #0x37c
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r0, [lr]
	str r0, [ip]
	ldr r1, [r4, #0x378]
	cmp r1, #0
	addeq sp, sp, #0x30
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	blx r1
	add sp, sp, #0x30
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2168260

	arm_func_start ovl01_21682F8
ovl01_21682F8: // 0x021682F8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	ldr r1, [r0, #0x374]
	mov r2, #0
	add r0, r0, #0x3a8
	str r2, [r1, #0x420]
	bl AnimatorMDL__Release
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_21682F8

	arm_func_start ovl01_2168324
ovl01_2168324: // 0x02168324
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	add lr, r4, #0x37c
	ldmia lr!, {r0, r1, r2, r3}
	add ip, r4, #0x3cc
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r1, [lr]
	add r0, r4, #0x44
	str r1, [ip]
	add r3, r4, #0x3f0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x3f4]
	add r0, r4, #0x300
	rsb r1, r1, #0
	str r1, [r4, #0x3f4]
	ldrsh r2, [r0, #0xa2]
	mov r0, #0
	mov r1, #3
	cmp r2, #0
	ble _021683B0
	str r2, [sp]
	mov r2, r1
	mov r3, r0
	str r0, [sp, #4]
	bl NNS_G3dGlbPolygonAttr
	b _021683C8
_021683B0:
	mov r2, #1
	str r2, [sp]
	mov r2, r1
	mov r3, r0
	str r0, [sp, #4]
	bl NNS_G3dGlbPolygonAttr
_021683C8:
	ldr r0, [r4, #0x43c]
	mov r1, #0
	mov r2, #0x1f0000
	bl NNSi_G3dModifyPolygonAttrMask
	add r0, r4, #0x3a8
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #0x3a8
	bl AnimatorMDL__Draw
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2168324

	arm_func_start ovl01_21683F0
ovl01_21683F0: // 0x021683F0
	add r1, r0, #0x300
	mov r2, #0x1f
	strh r2, [r1, #0xa2]
	mov r2, #0
	ldr r1, _02168410 // =ovl01_2168414
	str r2, [r0, #0x3a4]
	str r1, [r0, #0x378]
	bx lr
	.align 2, 0
_02168410: .word ovl01_2168414
	arm_func_end ovl01_21683F0

	arm_func_start ovl01_2168414
ovl01_2168414: // 0x02168414
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0216848C
	ldr r0, _021684E8 // =touchInput
	ldrh r1, [r0, #0x12]
	tst r1, #1
	beq _0216848C
	ldrh r1, [r0, #0x18]
	ldrh r0, [r0, #0x14]
	subs r0, r1, r0
	ldr r1, _021684E8 // =touchInput
	rsbmi r0, r0, #0
	ldrh r2, [r1, #0x1a]
	mov r0, r0, lsl #0x10
	ldrh r1, [r1, #0x16]
	mov r3, r0, lsr #0x10
	subs r0, r2, r1
	rsbmi r0, r0, #0
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	mul r0, r1, r1
	mla r0, r3, r3, r0
	mov r0, r0, lsl #0xc
	bl FX_Sqrt
	cmp r0, #0
	ldrgt r1, [r4, #0x3a4]
	addgt r0, r1, r0
	strgt r0, [r4, #0x3a4]
_0216848C:
	ldr r0, [r4, #0x3a4]
	cmp r0, #0x100000
	blt _021684CC
	add r0, r4, #0x300
	ldrsh r1, [r0, #0xa2]
	cmp r1, #0
	beq _021684CC
	sub r1, r1, #2
	strh r1, [r0, #0xa2]
	ldrsh r1, [r0, #0xa2]
	cmp r1, #0
	movlt r1, #0
	strlth r1, [r0, #0xa2]
	ldr r0, [r4, #0x3a4]
	sub r0, r0, #0x100000
	str r0, [r4, #0x3a4]
_021684CC:
	add r0, r4, #0x300
	ldrsh r0, [r0, #0xa2]
	cmp r0, #0
	ldreq r0, [r4, #0x18]
	orreq r0, r0, #4
	streq r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021684E8: .word touchInput
	arm_func_end ovl01_2168414

	arm_func_start ovl01_21684EC
ovl01_21684EC: // 0x021684EC
	ldr r1, _021684F8 // =ovl01_21684FC
	str r1, [r0, #0x378]
	bx lr
	.align 2, 0
_021684F8: .word ovl01_21684FC
	arm_func_end ovl01_21684EC

	arm_func_start ovl01_21684FC
ovl01_21684FC: // 0x021684FC
	add r1, r0, #0x300
	ldrsh r2, [r1, #0xa2]
	cmp r2, #0
	subne r0, r2, #1
	strneh r0, [r1, #0xa2]
	ldreq r1, [r0, #0x18]
	orreq r1, r1, #4
	streq r1, [r0, #0x18]
	bx lr
	arm_func_end ovl01_21684FC

	arm_func_start ovl01_2168520
ovl01_2168520: // 0x02168520
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x30
	mov r5, r0
	ldr r1, [r5, #0x374]
	mov r0, #0
	ldr r4, [r1, #0x374]
	add r1, r5, #0x400
	str r0, [r5, #0x44]
	ldr r0, [r5, #0x470]
	ldr r3, _021685F8 // =FX_SinCosTable_
	str r0, [r5, #0x48]
	ldr r2, [r5, #0x46c]
	add r0, sp, #0
	str r2, [r5, #0x4c]
	ldrh r1, [r1, #0x44]
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY43_
	add r0, r5, #0x48
	add lr, sp, #0
	add ip, r0, #0x400
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r1, [lr]
	add r0, r5, #0x44
	str r1, [ip]
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec43
	ldr r2, [r5, #0x44]
	ldr r1, [r4, #0xb30]
	mov r0, r5
	add r1, r2, r1
	str r1, [r5, #0x44]
	ldr r1, [r5, #0x374]
	ldr r2, [r5, #0x48]
	ldr r1, [r1, #0x3c4]
	add r1, r2, r1
	str r1, [r5, #0x48]
	ldr r1, [r4, #0xb38]
	ldr r2, [r5, #0x4c]
	add r1, r2, r1
	str r1, [r5, #0x4c]
	ldr r1, [r5, #0x378]
	blx r1
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021685F8: .word FX_SinCosTable_
	arm_func_end ovl01_2168520

	arm_func_start ovl01_21685FC
ovl01_21685FC: // 0x021685FC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	add r0, r0, #0xcc
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_21685FC

	arm_func_start ovl01_2168620
ovl01_2168620: // 0x02168620
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	ldmneia sp!, {r3, r4, r5, pc}
	add r0, r4, #0x48
	add ip, r0, #0x400
	add r5, r4, #0x4f0
	ldmia ip!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia ip!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldr r1, [ip]
	add r0, r4, #0x114
	str r1, [r5]
	add r1, r4, #0x44
	add r3, r0, #0x400
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x518]
	rsb r0, r0, #0
	str r0, [r4, #0x518]
	ldr r0, [r4, #0x374]
	bl ovl01_2162918
	add r5, r4, #0xcc
	add r0, r5, #0x400
	bl AnimatorMDL__ProcessAnimation
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _021686CC
	ldr r0, [r4, #0x374]
	ldr r1, [r0, #0x374]
	ldr r0, [r1, #0xa50]
	cmp r0, #0
	bne _021686CC
	ldr r0, [r1, #0xa4c]
	cmp r0, #0xe
	beq _021686CC
	ldr r0, [r5, #0x494]
	mov r1, #1
	bl NNS_G3dMdlSetMdlDepthTestCondAll
	b _021686D8
_021686CC:
	ldr r0, [r5, #0x494]
	mov r1, #0
	bl NNS_G3dMdlSetMdlDepthTestCondAll
_021686D8:
	add r0, r5, #0x400
	bl AnimatorMDL__Draw
	ldr r0, [r4, #0x374]
	add r0, r0, #0x24
	add r0, r0, #0x400
	bl BossHelpers__Light__SetLights1
	add r0, r4, #0x9c
	add r1, r0, #0x400
	mov r0, #0x1d
	bl BossHelpers__Model__SetMatrixMode
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_2168620

	arm_func_start ovl01_2168704
ovl01_2168704: // 0x02168704
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	bl GetCurrentTaskWork_
	mov r7, r0
	ldr r0, [r7, #0x18]
	tst r0, #0xc
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	tst r0, #2
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r7, #0x400
	ldrh r1, [r0, #0x76]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x76]
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r6, _021687DC // =0x006BAA99
	ldr r5, _021687E0 // =0x00107FC0
	ldr r4, _021687E4 // =gPlayer
	add r9, r7, #0x218
	add r10, r7, #0x384
	mov r8, #0
	mov r11, #0x40000
_02168768:
	ldr r0, [r9, #0x18]
	tst r0, #4
	beq _021687C0
	ldr r0, [r4]
	add r0, r0, #0x500
	ldrsh r0, [r0, #0xd4]
	sub r0, r0, #0xe
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _021687A4
	cmp r8, #0
	beq _021687C0
_021687A4:
	str r6, [sp]
	mov r0, r9
	mov r1, r10
	mov r3, r11
	add r2, r7, #0x4c0
	str r5, [sp, #4]
	bl BossHelpers__Collision__Func_203919C
_021687C0:
	add r8, r8, #1
	cmp r8, #3
	add r9, r9, #0x40
	add r10, r10, #0x40
	blt _02168768
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021687DC: .word 0x006BAA99
_021687E0: .word 0x00107FC0
_021687E4: .word gPlayer
	arm_func_end ovl01_2168704

	arm_func_start ovl01_21687E8
ovl01_21687E8: // 0x021687E8
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	ldr r0, [r0, #0x374]
	bl ovl01_21639F4
	ldr r0, [r4, #0x374]
	mov r1, #0
	ldr r0, [r0, #0x374]
	bl ovl01_2163AF0
	mov r0, r4
	mov r1, #3
	bl ovl01_2168F84
	add r0, r5, #0x1b0
	bl ovl01_2162004
	mov r0, r4
	bl ovl01_2161F6C
	mov r0, r5
	bl ovl01_2161E40
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_21687E8

	arm_func_start ovl01_2168850
ovl01_2168850: // 0x02168850
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	ldr r0, [r0, #0x374]
	bl ovl01_21639F4
	ldr r0, [r4, #0x374]
	mov r1, #0
	ldr r0, [r0, #0x374]
	bl ovl01_2163AF0
	ldr r0, [r4, #0x374]
	mov r1, #3
	ldr r0, [r0, #0x374]
	bl ovl01_2163D10
	add r0, r5, #0x1b0
	bl ovl01_2162004
	mov r0, r4
	bl ovl01_2161F6C
	mov r0, r5
	bl ovl01_2161E90
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_2168850

	arm_func_start ovl01_21688BC
ovl01_21688BC: // 0x021688BC
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	ldr r0, [r0, #0x374]
	bl ovl01_21639F4
	ldr r0, [r4, #0x374]
	mov r1, #0
	ldr r0, [r0, #0x374]
	bl ovl01_2163AF0
	mov r0, r4
	mov r1, #9
	bl ovl01_2168F84
	add r0, r5, #0x1b0
	bl ovl01_2162004
	mov r0, r4
	bl ovl01_2161F6C
	mov r0, r5
	bl ovl01_2161E40
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_21688BC

	arm_func_start ovl01_2168924
ovl01_2168924: // 0x02168924
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	ldr r0, [r0, #0x374]
	bl ovl01_21639F4
	ldr r0, [r4, #0x374]
	mov r1, #0
	ldr r0, [r0, #0x374]
	bl ovl01_2163AF0
	mov r0, r4
	mov r1, #0xd
	bl ovl01_2168F84
	add r0, r5, #0x1b0
	bl ovl01_2162004
	mov r0, r4
	bl ovl01_2161F6C
	mov r0, r5
	bl ovl01_2161E40
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_2168924

	arm_func_start ovl01_216898C
ovl01_216898C: // 0x0216898C
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	mov r1, #0
	ldr r0, [r0, #0x374]
	str r1, [r0, #0xaf4]
	ldr r0, [r4, #0x374]
	ldr r0, [r0, #0x374]
	bl ovl01_21639F4
	ldr r0, [r4, #0x374]
	mov r1, #0
	ldr r0, [r0, #0x374]
	bl ovl01_2163AF0
	mov r0, r4
	mov r1, #0x12
	bl ovl01_2168F84
	add r0, r5, #0x1b0
	bl ovl01_2162004
	mov r0, r4
	bl ovl01_2161F6C
	mov r0, r5
	bl ovl01_2161EE0
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_216898C

	arm_func_start ovl01_2168A04
ovl01_2168A04: // 0x02168A04
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	mov r1, #0
	add r0, r0, #0x300
	strh r1, [r0, #0xb8]
	ldr r0, [r4, #0x374]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0xb8]
	bl UpdateBossHealthHUD
	ldr r0, [r4, #0x374]
	ldr r2, _02168A64 // =ovl01_2166D60
	ldr r1, [r0, #0x374]
	mov r0, r5
	str r2, [r1, #0xa40]
	bl ovl01_2161E40
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02168A64: .word ovl01_2166D60
	arm_func_end ovl01_2168A04

	arm_func_start ovl01_2168A68
ovl01_2168A68: // 0x02168A68
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	ldr r0, [r0, #0x374]
	bl ovl01_21639F4
	ldr r0, [r4, #0x374]
	mov r1, #0
	ldr r0, [r0, #0x374]
	bl ovl01_2163AF0
	add r0, r5, #0x1b0
	bl ovl01_2162004
	mov r0, r4
	bl ovl01_2161F6C
	mov r0, r5
	bl ovl01_2161E40
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_2168A68

	arm_func_start ovl01_2168AC4
ovl01_2168AC4: // 0x02168AC4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	mov r1, #1
	ldr r0, [r0, #0x374]
	bl ovl01_2163AF0
	mov r0, r4
	mov r1, #4
	bl ovl01_2168F84
	add r0, r5, #0x1b0
	bl ovl01_2162018
	mov r0, #0
	str r0, [sp]
	mov r0, #0xcf
	str r0, [sp, #4]
	sub r1, r0, #0xd0
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	mov r0, r5
	bl ovl01_2161E40
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_2168AC4

	arm_func_start ovl01_2168B4C
ovl01_2168B4C: // 0x02168B4C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	mov r1, #1
	ldr r0, [r0, #0x374]
	bl ovl01_2163AF0
	ldr r1, _02168BD0 // =ovl01_2169F14
	add r0, r5, #0x1b0
	str r1, [r4, #0x378]
	bl ovl01_2162018
	mov r2, #0
	mov r0, #0xcf
	sub r1, r0, #0xd0
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	mov r0, r5
	bl ovl01_2161E90
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02168BD0: .word ovl01_2169F14
	arm_func_end ovl01_2168B4C

	arm_func_start ovl01_2168BD4
ovl01_2168BD4: // 0x02168BD4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	mov r1, #1
	ldr r0, [r0, #0x374]
	bl ovl01_2163AF0
	ldr r0, [r4, #0x374]
	mov r1, #5
	ldr r0, [r0, #0x374]
	bl ovl01_2163D10
	add r0, r5, #0x1b0
	bl ovl01_2162018
	mov r0, #0
	str r0, [sp]
	mov r0, #0xcf
	str r0, [sp, #4]
	sub r1, r0, #0xd0
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	mov r0, r5
	bl ovl01_2161E40
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_2168BD4

	arm_func_start ovl01_2168C60
ovl01_2168C60: // 0x02168C60
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	mov r1, #1
	ldr r0, [r0, #0x374]
	bl ovl01_2163AF0
	mov r0, r4
	mov r1, #0xe
	bl ovl01_2168F84
	add r0, r5, #0x1b0
	bl ovl01_2162018
	mov r0, #0
	str r0, [sp]
	mov r0, #0xcf
	str r0, [sp, #4]
	sub r1, r0, #0xd0
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	mov r0, r5
	bl ovl01_2161E40
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_2168C60

	arm_func_start ovl01_2168CE8
ovl01_2168CE8: // 0x02168CE8
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	mov r1, #1
	ldr r0, [r0, #0x374]
	bl ovl01_2163AF0
	mov r0, r4
	bl ovl01_216B2C8
	add r0, r5, #0x1b0
	bl ovl01_2162018
	mov r0, #0
	str r0, [sp]
	mov r0, #0xcf
	str r0, [sp, #4]
	sub r1, r0, #0xd0
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	mov r0, r5
	bl ovl01_2161EE0
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_2168CE8

	arm_func_start ovl01_2168D6C
ovl01_2168D6C: // 0x02168D6C
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, [r0, #0x1c]
	ldrh r3, [r2]
	cmp r3, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r3, [r2, #0x1c]
	ldr r4, [r1, #0xc]
	tst r3, #0x8000
	ldr r3, [r1, #0x1c]
	ldr ip, [r2, #0x44]
	ldr lr, [r3, #0x44]
	ldr r3, [r0, #0xc]
	ldrne r5, [r2, #0x98]
	add r4, lr, r4, lsl #12
	add ip, ip, r3, lsl #12
	ldreq r5, [r2, #0xc8]
	cmp r4, ip
	bge _02168DF4
	cmp r5, #0
	ldmgtia sp!, {r3, r4, r5, pc}
	ldrsh r3, [r1, #6]
	ldrsh r1, [r0]
	mov r0, #0
	add r3, r4, r3, lsl #12
	sub r1, r3, r1, lsl #12
	sub r1, r1, ip
	str r1, [r2, #0xb0]
	ldr r1, [r2, #0x1c]
	orr r1, r1, #4
	str r1, [r2, #0x1c]
	str r0, [r2, #0x98]
	str r0, [r2, #0xa0]
	str r0, [r2, #0xc8]
	ldmia sp!, {r3, r4, r5, pc}
_02168DF4:
	cmp r5, #0
	ldmltia sp!, {r3, r4, r5, pc}
	ldrsh r3, [r1]
	ldrsh r1, [r0, #6]
	mov r0, #0
	add r3, r4, r3, lsl #12
	sub r1, r3, r1, lsl #12
	sub r1, r1, ip
	str r1, [r2, #0xb0]
	ldr r1, [r2, #0x1c]
	orr r1, r1, #4
	str r1, [r2, #0x1c]
	str r0, [r2, #0x98]
	str r0, [r2, #0xa0]
	str r0, [r2, #0xc8]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl01_2168D6C

	arm_func_start ovl01_2168E34
ovl01_2168E34: // 0x02168E34
	stmdb sp!, {r4, lr}
	ldr r2, [r0, #0x1c]
	ldrh r3, [r2]
	cmp r3, #1
	ldmneia sp!, {r4, pc}
	ldr r3, [r1, #0x1c]
	ldr r4, [r1, #0xc]
	ldr lr, [r3, #0x44]
	ldr ip, [r2, #0x44]
	ldr r3, [r0, #0xc]
	add r4, lr, r4, lsl #12
	add ip, ip, r3, lsl #12
	cmp r4, ip
	bge _02168EA4
	ldrsh r3, [r1, #6]
	ldrsh r1, [r0]
	mov r0, #0
	add r3, r4, r3, lsl #12
	sub r1, r3, r1, lsl #12
	sub r1, r1, ip
	str r1, [r2, #0xb0]
	ldr r1, [r2, #0x1c]
	orr r1, r1, #4
	str r1, [r2, #0x1c]
	str r0, [r2, #0x98]
	str r0, [r2, #0xa0]
	str r0, [r2, #0xc8]
	ldmia sp!, {r4, pc}
_02168EA4:
	ldrsh r3, [r1]
	ldrsh r1, [r0, #6]
	mov r0, #0
	add r3, r4, r3, lsl #12
	sub r1, r3, r1, lsl #12
	sub r1, r1, ip
	str r1, [r2, #0xb0]
	ldr r1, [r2, #0x1c]
	orr r1, r1, #4
	str r1, [r2, #0x1c]
	str r0, [r2, #0x98]
	str r0, [r2, #0xa0]
	str r0, [r2, #0xc8]
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2168E34

	arm_func_start ovl01_2168EDC
ovl01_2168EDC: // 0x02168EDC
	stmdb sp!, {r3, lr}
	ldr ip, [r0, #0x1c]
	ldr lr, [r1, #0x1c]
	ldrh r0, [ip]
	cmp r0, #1
	ldmneia sp!, {r3, pc}
	ldr r1, [r1, #0xc]
	ldr r0, [lr, #0x44]
	ldr r3, [lr, #0x4c4]
	ldr r2, [ip, #0x44]
	add r0, r0, r1, lsl #12
	sub r0, r2, r0
	str r0, [lr, #0x48c]
	ldr r0, [ip, #0x48]
	rsb r1, r3, #0
	sub r0, r0, r1
	str r0, [lr, #0x490]
	mov r0, #1
	str r0, [lr, #0x488]
	str ip, [lr, #0x480]
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_2168EDC

	arm_func_start ovl01_2168F30
ovl01_2168F30: // 0x02168F30
	stmdb sp!, {r3, lr}
	mov r2, #0xc
	mul ip, r1, r2
	ldr r3, _02168F80 // =_0217A858
	mov lr, #0
_02168F44:
	ldr r1, [r0, #0x380]
	ldr r1, [r3, r1, lsl #2]
	add r1, ip, r1
	ldr r2, [r1, lr, lsl #2]
	cmp r2, #0
	addne r1, r0, lr, lsl #6
	strne r2, [r1, #0x23c]
	add r2, r0, lr, lsl #6
	ldr r1, [r2, #0x230]
	add lr, lr, #1
	bic r1, r1, #0x300
	str r1, [r2, #0x230]
	cmp lr, #3
	blt _02168F44
	ldmia sp!, {r3, pc}
	.align 2, 0
_02168F80: .word _0217A858
	arm_func_end ovl01_2168F30

	arm_func_start ovl01_2168F84
ovl01_2168F84: // 0x02168F84
	stmdb sp!, {r3, lr}
	str r1, [r0, #0x37c]
	cmp r1, #0x16
	addls pc, pc, r1, lsl #2
	b _02169104
_02168F98: // jump table
	b _02168FF4 // case 0
	b _02169000 // case 1
	b _0216900C // case 2
	b _02169018 // case 3
	b _02169024 // case 4
	b _02169030 // case 5
	b _0216903C // case 6
	b _02169048 // case 7
	b _02169054 // case 8
	b _02169060 // case 9
	b _0216906C // case 10
	b _02169078 // case 11
	b _02169084 // case 12
	b _02169090 // case 13
	b _0216909C // case 14
	b _021690A8 // case 15
	b _021690B4 // case 16
	b _021690C0 // case 17
	b _021690CC // case 18
	b _021690D8 // case 19
	b _021690E4 // case 20
	b _021690F0 // case 21
	b _021690FC // case 22
_02168FF4:
	ldr r1, _02169110 // =ovl01_2169194
	str r1, [r0, #0x378]
	b _02169104
_02169000:
	ldr r1, _02169114 // =ovl01_216937C
	str r1, [r0, #0x378]
	b _02169104
_0216900C:
	ldr r1, _02169118 // =ovl01_2169900
	str r1, [r0, #0x378]
	b _02169104
_02169018:
	ldr r1, _0216911C // =ovl01_2169B3C
	str r1, [r0, #0x378]
	b _02169104
_02169024:
	ldr r1, _02169120 // =ovl01_2169A5C
	str r1, [r0, #0x378]
	b _02169104
_02169030:
	ldr r1, _02169124 // =ovl01_2169C18
	str r1, [r0, #0x378]
	b _02169104
_0216903C:
	ldr r1, _02169128 // =ovl01_2169FE4
	str r1, [r0, #0x378]
	b _02169104
_02169048:
	ldr r1, _0216912C // =ovl01_216A178
	str r1, [r0, #0x378]
	b _02169104
_02169054:
	ldr r1, _02169130 // =ovl01_216A210
	str r1, [r0, #0x378]
	b _02169104
_02169060:
	ldr r1, _02169134 // =ovl01_216AAE0
	str r1, [r0, #0x378]
	b _02169104
_0216906C:
	ldr r1, _02169138 // =ovl01_216A9C8
	str r1, [r0, #0x378]
	b _02169104
_02169078:
	ldr r1, _0216913C // =ovl01_216ABD0
	str r1, [r0, #0x378]
	b _02169104
_02169084:
	ldr r1, _02169140 // =ovl01_216AD50
	str r1, [r0, #0x378]
	b _02169104
_02169090:
	ldr r1, _02169144 // =ovl01_216AF54
	str r1, [r0, #0x378]
	b _02169104
_0216909C:
	ldr r1, _02169148 // =ovl01_216AE88
	str r1, [r0, #0x378]
	b _02169104
_021690A8:
	ldr r1, _02169110 // =ovl01_2169194
	str r1, [r0, #0x378]
	b _02169104
_021690B4:
	ldr r1, _02169114 // =ovl01_216937C
	str r1, [r0, #0x378]
	b _02169104
_021690C0:
	ldr r1, _0216914C // =ovl01_216B054
	str r1, [r0, #0x378]
	b _02169104
_021690CC:
	ldr r1, _02169150 // =ovl01_216B34C
	str r1, [r0, #0x378]
	b _02169104
_021690D8:
	ldr r1, _02169154 // =ovl01_216B3F0
	str r1, [r0, #0x378]
	b _02169104
_021690E4:
	ldr r1, _02169158 // =ovl01_216B410
	str r1, [r0, #0x378]
	b _02169104
_021690F0:
	ldr r1, _0216915C // =ovl01_216B430
	str r1, [r0, #0x378]
	b _02169104
_021690FC:
	ldr r1, _02169160 // =ovl01_216B548
	str r1, [r0, #0x378]
_02169104:
	ldr r1, [r0, #0x378]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_02169110: .word ovl01_2169194
_02169114: .word ovl01_216937C
_02169118: .word ovl01_2169900
_0216911C: .word ovl01_2169B3C
_02169120: .word ovl01_2169A5C
_02169124: .word ovl01_2169C18
_02169128: .word ovl01_2169FE4
_0216912C: .word ovl01_216A178
_02169130: .word ovl01_216A210
_02169134: .word ovl01_216AAE0
_02169138: .word ovl01_216A9C8
_0216913C: .word ovl01_216ABD0
_02169140: .word ovl01_216AD50
_02169144: .word ovl01_216AF54
_02169148: .word ovl01_216AE88
_0216914C: .word ovl01_216B054
_02169150: .word ovl01_216B34C
_02169154: .word ovl01_216B3F0
_02169158: .word ovl01_216B410
_0216915C: .word ovl01_216B430
_02169160: .word ovl01_216B548
	arm_func_end ovl01_2168F84

	arm_func_start ovl01_2169164
ovl01_2169164: // 0x02169164
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, #0
_02169174:
	add r0, r6, r4, lsl #2
	ldr r0, [r0, #0x398]
	mov r1, r5
	bl ovl01_2168F84
	add r4, r4, #1
	cmp r4, #4
	blt _02169174
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl01_2169164

	arm_func_start ovl01_2169194
ovl01_2169194: // 0x02169194
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r3, #1
	mov r4, r0
	str r3, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, [r4, #0x20]
	mov r2, #0x78000
	orr r0, r0, #0x20
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x230]
	mov r1, #0x32000
	bic r0, r0, #4
	str r0, [r4, #0x230]
	ldr r3, [r4, #0x270]
	ldr r0, _02169210 // =ovl01_2169214
	bic r3, r3, #4
	str r3, [r4, #0x270]
	ldr r3, [r4, #0x2b0]
	bic r3, r3, #4
	str r3, [r4, #0x2b0]
	str r2, [r4, #0x46c]
	str r1, [r4, #0x470]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169210: .word ovl01_2169214
	arm_func_end ovl01_2169194

	arm_func_start ovl01_2169214
ovl01_2169214: // 0x02169214
	bx lr
	arm_func_end ovl01_2169214

	arm_func_start ovl01_2169218
ovl01_2169218: // 0x02169218
	stmdb sp!, {r4, lr}
	ldr r2, [r0, #0x374]
	mov ip, r1, lsl #0x10
	ldr r0, [r0, #0x380]
	ldr r1, _0216928C // =0x00000AAA
	mov r4, #0
_02169230:
	add r3, r2, r4, lsl #2
	ldr lr, [r3, #0x398]
	ldr r3, [lr, #0x380]
	cmp r0, r3
	beq _02169278
	ldr r3, [lr, #0x37c]
	sub r3, r3, #2
	cmp r3, #2
	bhi _02169278
	add r3, lr, #0x400
	ldrsh r3, [r3, #0x44]
	sub r3, r3, ip, asr #16
	mov r3, r3, lsl #0x10
	movs r3, r3, asr #0x10
	rsbmi r3, r3, #0
	cmp r3, r1
	movlt r0, #0
	ldmltia sp!, {r4, pc}
_02169278:
	add r4, r4, #1
	cmp r4, #4
	blt _02169230
	mov r0, #1
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216928C: .word 0x00000AAA
	arm_func_end ovl01_2169218

	arm_func_start ovl01_2169290
ovl01_2169290: // 0x02169290
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #4
	mov r9, #0x8000
	mov r10, r0
	rsb r9, r9, #0
	mov r4, r1, lsl #0x10
	mov r7, #0
_021692AC:
	ldr r0, [r10, #0x374]
	ldr r1, [r10, #0x380]
	add r0, r0, r7, lsl #2
	ldr r2, [r0, #0x398]
	ldr r0, [r2, #0x380]
	cmp r1, r0
	beq _0216935C
	ldr r0, [r2, #0x37c]
	sub r0, r0, #2
	cmp r0, #2
	bhi _0216935C
	add r0, r2, #0x400
	ldrsh r0, [r0, #0x44]
	mov r8, #0
	add r5, sp, #0
	add r1, r0, #0xb60
	sub r0, r0, #0xb60
	strh r1, [sp]
	strh r0, [sp, #2]
_021692F8:
	mov r0, r8, lsl #1
	ldrh r1, [r5, r0]
	mov r0, r10
	mov r2, r1, lsl #0x10
	mov r2, r2, asr #0x10
	sub r2, r2, r4, asr #16
	mov r2, r2, lsl #0x10
	mov r6, r2, asr #0x10
	bl ovl01_2169218
	cmp r0, #0
	beq _02169350
	cmp r9, #0
	rsblt r2, r9, #0
	movge r2, r9
	cmp r6, #0
	rsblt r0, r6, #0
	movge r0, r6
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r2, lsl #0x10
	cmp r1, r0, lsr #16
	movlo r9, r6
_02169350:
	add r8, r8, #1
	cmp r8, #2
	blt _021692F8
_0216935C:
	add r7, r7, #1
	cmp r7, #4
	blt _021692AC
	cmp r9, #0x8000
	moveq r9, #0
	mov r0, r9
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end ovl01_2169290

	arm_func_start ovl01_216937C
ovl01_216937C: // 0x0216937C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #3
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, [r4, #0x20]
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	ldr r2, [r4, #0x374]
	ldr r0, [r2, #0x374]
	ldr r0, [r0, #0xa50]
	cmp r0, #0
	bne _021693FC
	mov r1, #0
	mov r0, #0x9f
	str r1, [sp]
	sub r1, r0, #0xa0
	str r0, [sp, #4]
	ldr r0, [r2, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl ovl01_2161C40
_021693FC:
	mov r0, r4
	mov r1, #1
	bl ovl01_2168F30
	ldr r0, _0216946C // =gPlayer
	ldr r2, _02169470 // =0x006BAA99
	ldr r0, [r0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__Func_2038DCC
	add r1, r4, #0x400
	strh r0, [r1, #0x44]
	ldr r2, [r4, #0x374]
	ldr r0, [r4, #0x380]
	ldr r2, [r2, #0x374]
	ldrh r3, [r1, #0x44]
	add r0, r2, r0, lsl #2
	ldr r0, [r0, #0xaf0]
	mov r2, #0
	add r0, r3, r0
	strh r0, [r1, #0x44]
	str r2, [r4, #0x478]
	strh r2, [r1, #0x7c]
	strh r2, [r1, #0x7e]
	ldr r0, _02169474 // =ovl01_2169478
	strh r2, [r1, #0x80]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216946C: .word gPlayer
_02169470: .word 0x006BAA99
_02169474: .word ovl01_2169478
	arm_func_end ovl01_216937C

	arm_func_start ovl01_2169478
ovl01_2169478: // 0x02169478
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldrne r1, _02169490 // =ovl01_2169494
	strne r1, [r0, #0x378]
	bx lr
	.align 2, 0
_02169490: .word ovl01_2169494
	arm_func_end ovl01_2169478

	arm_func_start ovl01_2169494
ovl01_2169494: // 0x02169494
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #4
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _021694D4 // =ovl01_21694D8
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021694D4: .word ovl01_21694D8
	arm_func_end ovl01_2169494

	arm_func_start ovl01_21694D8
ovl01_21694D8: // 0x021694D8
	ldr r1, _021694E4 // =ovl01_21694E8
	str r1, [r0, #0x378]
	bx lr
	.align 2, 0
_021694E4: .word ovl01_21694E8
	arm_func_end ovl01_21694D8

	arm_func_start ovl01_21694E8
ovl01_21694E8: // 0x021694E8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #4
	bl BossHelpers__Animation__Func_2038BF0
	add r0, r4, #0x400
	mov r1, #0
	strh r1, [r0, #0x46]
	mov r2, #0x78
	ldr r1, _0216953C // =ovl01_2169540
	strh r2, [r0, #0x80]
	str r1, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216953C: .word ovl01_2169540
	arm_func_end ovl01_21694E8

	arm_func_start ovl01_2169540
ovl01_2169540: // 0x02169540
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r6, r0
	ldr r2, [r6, #0x374]
	ldr r0, [r6, #0x380]
	ldr r1, [r2, #0x374]
	ldr r1, [r1, #0xae0]
	cmp r1, r0
	bne _02169668
	ldr r0, _021697C4 // =gPlayer
	ldr r2, _021697C8 // =0x006BAA99
	ldr r0, [r0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__Func_2038DCC
	ldr r1, _021697C4 // =gPlayer
	mov r4, r0
	ldr r1, [r1]
	ldr r0, [r1, #0x1c]
	tst r0, #0x8000
	ldrne r5, [r1, #0x98]
	ldr r0, [r6, #0x374]
	ldreq r5, [r1, #0xc8]
	bl ovl01_2162A98
	smull r1, r0, r5, r0
	adds r1, r1, #0x800
	mov r2, r1, lsr #0xc
	adc r0, r0, #0
	orr r2, r2, r0, lsl #20
	ldr r0, _021697CC // =0x0038E000
	mov r1, #0
	umull r5, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r5, r5, #0x800
	adc r0, r3, #0
	mov r1, r5, lsr #0xc
	orr r1, r1, r0, lsl #20
	mov r1, r1, lsl #4
	mov r0, r4, lsl #0x10
	mov r1, r1, asr #0x10
	add r4, r1, r0, asr #16
	mov r1, r4, lsl #0x10
	mov r0, r6
	mov r1, r1, lsr #0x10
	bl ovl01_2169218
	cmp r0, #0
	movne r5, #0
	bne _0216961C
	mov r1, r4, lsl #0x10
	mov r0, r6
	mov r1, r1, lsr #0x10
	bl ovl01_2169290
	mov r5, r0
_0216961C:
	add r0, r6, #0x400
	ldrh r0, [r0, #0x80]
	cmp r0, #0
	bne _02169644
	mov r1, r4, lsl #0x10
	mov r0, r6
	mov r1, r1, lsr #0x10
	bl ovl01_2169218
	cmp r0, #0
	bne _021696AC
_02169644:
	add r0, r6, #0x400
	ldrh r1, [r0, #0x80]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x80]
	add r1, r5, r4
	add r0, r6, #0x400
	strh r1, [r0, #0x7e]
	b _021696AC
_02169668:
	add r0, r2, r1, lsl #2
	ldr r0, [r0, #0x398]
	add r1, r6, #0x400
	add r0, r0, #0x400
	ldrh r4, [r0, #0x7e]
	strh r4, [r1, #0x7e]
	ldr r0, [r6, #0x374]
	ldr r2, [r6, #0x380]
	ldr r3, [r0, #0x374]
	ldr r0, [r3, #0xae0]
	add r2, r3, r2, lsl #2
	add r0, r3, r0, lsl #2
	ldr r2, [r2, #0xaf0]
	ldr r0, [r0, #0xaf0]
	sub r0, r2, r0
	add r0, r4, r0
	strh r0, [r1, #0x7e]
_021696AC:
	add r0, r6, #0x400
	ldrsh r1, [r0, #0x44]
	ldrsh r0, [r0, #0x7e]
	subs r4, r1, r0
	rsbmi r0, r4, #0
	movpl r0, r4
	cmp r0, #0xb6
	movgt r0, #1
	strgt r0, [r6, #0x478]
	ldr r1, [r6, #0x374]
	ldr r0, [r6, #0x380]
	ldr r2, [r1, #0x374]
	ldr r1, [r2, #0xae0]
	cmp r1, r0
	bne _02169720
	cmp r4, #0
	rsblt r0, r4, #0
	movge r0, r4
	cmp r0, #0x16c
	bgt _02169720
	ldr r0, [r2, #0xb00]
	cmp r0, #0
	bne _02169720
	mov r0, #0
	str r0, [r2, #0xb04]
	ldr r0, [r6, #0x374]
	mov r1, #1
	ldr r0, [r0, #0x374]
	str r1, [r0, #0xb00]
_02169720:
	ldr r0, [r6, #0x478]
	cmp r0, #0
	beq _02169740
	add r0, r6, #0x400
	ldrh r1, [r0, #0x7c]
	cmp r1, #0
	addeq r1, r1, #1
	streqh r1, [r0, #0x7c]
_02169740:
	add r2, r6, #0x400
	ldrh r0, [r2, #0x7c]
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	mov r0, #0x22
	str r0, [sp]
	mov r0, #0x280
	str r0, [sp, #4]
	mov r0, #0
	str r0, [sp, #8]
	ldrh r0, [r2, #0x44]
	ldrh r1, [r2, #0x7e]
	ldrsh r2, [r2, #0x46]
	mov r3, #5
	bl BossHelpers__Math__Func_2039360
	add r1, r6, #0x400
	strh r0, [r1, #0x46]
	cmp r4, #0
	rsblt r4, r4, #0
	cmp r4, #0xb6
	ldrh r2, [r1, #0x44]
	ldrsh r0, [r1, #0x46]
	addge sp, sp, #0xc
	add r0, r2, r0
	strh r0, [r1, #0x44]
	ldmgeia sp!, {r3, r4, r5, r6, pc}
	mov r1, #0
	str r1, [r6, #0x478]
	add r0, r6, #0x400
	strh r1, [r0, #0x7c]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_021697C4: .word gPlayer
_021697C8: .word 0x006BAA99
_021697CC: .word 0x0038E000
	arm_func_end ovl01_2169540

	arm_func_start ovl01_21697D0
ovl01_21697D0: // 0x021697D0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x400
	ldrh r1, [r1, #0x44]
	bl ovl01_2169218
	cmp r0, #0
	ldrne r1, _021697FC // =ovl01_2169800
	moveq r0, #0
	movne r0, #1
	strne r1, [r4, #0x378]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021697FC: .word ovl01_2169800
	arm_func_end ovl01_21697D0

	arm_func_start ovl01_2169800
ovl01_2169800: // 0x02169800
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #5
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, [r4, #0x374]
	ldr r0, [r0, #0x374]
	ldr r0, [r0, #0xa50]
	cmp r0, #1
	moveq r0, #0x800
	movne r0, #0x1000
	str r0, [r4, #0x5e8]
	ldr r1, [r4, #0x270]
	ldr r0, _02169864 // =ovl01_2169868
	orr r1, r1, #4
	str r1, [r4, #0x270]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169864: .word ovl01_2169868
	arm_func_end ovl01_2169800

	arm_func_start ovl01_2169868
ovl01_2169868: // 0x02169868
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x46c]
	cmp r0, #0xaa000
	addlt r0, r0, #0x5000
	strlt r0, [r4, #0x46c]
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x374]
	mov r3, #0xa0
	ldr r0, [r0, #0x374]
	sub r1, r3, #0xa1
	add r0, r0, #0xa00
	ldrh lr, [r0, #0xda]
	mov ip, #0
	mov r2, r1
	bic lr, lr, #4
	strh lr, [r0, #0xda]
	str ip, [sp]
	str r3, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl ovl01_2161C40
	mov r0, r4
	mov r1, #2
	bl ovl01_2168F84
	mov r0, #0x1000
	str r0, [r4, #0x5e8]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2169868

	arm_func_start ovl01_2169900
ovl01_2169900: // 0x02169900
	ldr r2, [r0, #0x230]
	ldr r1, _02169930 // =ovl01_2169934
	orr r2, r2, #4
	str r2, [r0, #0x230]
	ldr r2, [r0, #0x270]
	bic r2, r2, #4
	str r2, [r0, #0x270]
	ldr r2, [r0, #0x2b0]
	orr r2, r2, #4
	str r2, [r0, #0x2b0]
	str r1, [r0, #0x378]
	bx lr
	.align 2, 0
_02169930: .word ovl01_2169934
	arm_func_end ovl01_2169900

	arm_func_start ovl01_2169934
ovl01_2169934: // 0x02169934
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #6
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02169974 // =ovl01_2169978
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169974: .word ovl01_2169978
	arm_func_end ovl01_2169934

	arm_func_start ovl01_2169978
ovl01_2169978: // 0x02169978
	bx lr
	arm_func_end ovl01_2169978

	arm_func_start ovl01_216997C
ovl01_216997C: // 0x0216997C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #7
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x230]
	ldr r0, _021699DC // =ovl01_21699E0
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021699DC: .word ovl01_21699E0
	arm_func_end ovl01_216997C

	arm_func_start ovl01_21699E0
ovl01_21699E0: // 0x021699E0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r1, r4, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	bl ovl01_2168F84
	ldr r2, [r4, #0x374]
	ldr r0, [r2, #0x374]
	ldr r0, [r0, #0xa50]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	mov r1, #0
	mov r0, #0xa3
	str r1, [sp]
	sub r1, r0, #0xa4
	str r0, [sp, #4]
	ldr r0, [r2, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl ovl01_2161C40
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_21699E0

	arm_func_start ovl01_2169A5C
ovl01_2169A5C: // 0x02169A5C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #8
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x230]
	ldr r0, _02169ABC // =ovl01_2169AC0
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169ABC: .word ovl01_2169AC0
	arm_func_end ovl01_2169A5C

	arm_func_start ovl01_2169AC0
ovl01_2169AC0: // 0x02169AC0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r2, [r4, #0x374]
	ldr r0, [r2, #0x374]
	ldr r0, [r0, #0xa50]
	cmp r0, #0
	bne _02169B28
	mov r1, #0
	mov r0, #0xa3
	str r1, [sp]
	sub r1, r0, #0xa4
	str r0, [sp, #4]
	ldr r0, [r2, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl ovl01_2161C40
_02169B28:
	mov r0, r4
	mov r1, #0
	bl ovl01_2168F84
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2169AC0

	arm_func_start ovl01_2169B3C
ovl01_2169B3C: // 0x02169B3C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r2, r4, #0x500
	ldrh r3, [r2, #0xd8]
	mov r1, #2
	orr r3, r3, #1
	strh r3, [r2, #0xd8]
	ldr r2, [r4, #0x230]
	orr r2, r2, #4
	str r2, [r4, #0x230]
	ldr r2, [r4, #0x270]
	bic r2, r2, #4
	str r2, [r4, #0x270]
	ldr r2, [r4, #0x2b0]
	orr r2, r2, #4
	str r2, [r4, #0x2b0]
	bl ovl01_2168F30
	add r0, r4, #0x400
	mov r2, #0xb4
	ldr r1, _02169B98 // =ovl01_2169B9C
	strh r2, [r0, #0x74]
	str r1, [r4, #0x378]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169B98: .word ovl01_2169B9C
	arm_func_end ovl01_2169B3C

	arm_func_start ovl01_2169B9C
ovl01_2169B9C: // 0x02169B9C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x400
	ldrh r1, [r0, #0x74]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x74]
	add r0, r4, #0x400
	ldrh r0, [r0, #0x74]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	mov r1, #4
	bl ovl01_2168F84
	mov r0, r4
	mov r1, #1
	bl ovl01_2168F30
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2169B9C

	arm_func_start ovl01_2169BE4
ovl01_2169BE4: // 0x02169BE4
	add r0, r0, #0x400
	ldrh r2, [r0, #0x44]
	ldrh r1, [r0, #0x78]
	add r1, r2, r1
	strh r1, [r0, #0x44]
	ldrh r1, [r0, #0x78]
	add r1, r1, #5
	strh r1, [r0, #0x78]
	ldrh r2, [r0, #0x7a]
	ldrh r1, [r0, #0x78]
	cmp r1, r2
	strhih r2, [r0, #0x78]
	bx lr
	arm_func_end ovl01_2169BE4

	arm_func_start ovl01_2169C18
ovl01_2169C18: // 0x02169C18
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #9
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x20]
	mov r0, r4
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	ldr r2, [r4, #0x230]
	mov r1, #3
	bic r2, r2, #4
	str r2, [r4, #0x230]
	ldr r2, [r4, #0x270]
	bic r2, r2, #4
	str r2, [r4, #0x270]
	ldr r2, [r4, #0x2b0]
	orr r2, r2, #4
	str r2, [r4, #0x2b0]
	bl ovl01_2168F30
	ldr r0, _02169D20 // =gPlayer
	ldr r2, _02169D24 // =0x006BAA99
	ldr r0, [r0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__Func_2038DCC
	add r1, r4, #0x400
	strh r0, [r1, #0x44]
	ldrh r3, [r1, #0x44]
	ldr r2, [r4, #0x380]
	ldr r0, _02169D28 // =_0217A838
	mov r2, r2, lsl #1
	ldrh r2, [r0, r2]
	mov r0, #0
	add r2, r3, r2
	strh r2, [r1, #0x44]
	strh r0, [r1, #0x78]
	strh r0, [r1, #0x7c]
	ldr r0, [r4, #0x374]
	bl ovl01_2162ACC
	add r1, r4, #0x400
	strh r0, [r1, #0x7a]
	mov r0, #0
	str r0, [sp]
	mov r0, #0x9f
	str r0, [sp, #4]
	sub r1, r0, #0xa0
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x400
	ldrh r1, [r1, #0x44]
	bl ovl01_2161C40
	ldr r0, _02169D2C // =ovl01_2169D30
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169D20: .word gPlayer
_02169D24: .word 0x006BAA99
_02169D28: .word _0217A838
_02169D2C: .word ovl01_2169D30
	arm_func_end ovl01_2169C18

	arm_func_start ovl01_2169D30
ovl01_2169D30: // 0x02169D30
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldrne r1, _02169D48 // =ovl01_2169D4C
	strne r1, [r0, #0x378]
	bx lr
	.align 2, 0
_02169D48: .word ovl01_2169D4C
	arm_func_end ovl01_2169D30

	arm_func_start ovl01_2169D4C
ovl01_2169D4C: // 0x02169D4C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xa
	bl BossHelpers__Animation__Func_2038BF0
	add r0, r4, #0x400
	mov r1, #0
	strh r1, [r0, #0x78]
	ldr r1, [r4, #0x230]
	ldr r0, _02169DBC // =ovl01_2169DC0
	orr r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	orr r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169DBC: .word ovl01_2169DC0
	arm_func_end ovl01_2169D4C

	arm_func_start ovl01_2169DC0
ovl01_2169DC0: // 0x02169DC0
	ldr ip, _02169DC8 // =ovl01_2169BE4
	bx ip
	.align 2, 0
_02169DC8: .word ovl01_2169BE4
	arm_func_end ovl01_2169DC0

	arm_func_start ovl01_2169DCC
ovl01_2169DCC: // 0x02169DCC
	ldr r1, _02169DD8 // =ovl01_2169DDC
	str r1, [r0, #0x378]
	bx lr
	.align 2, 0
_02169DD8: .word ovl01_2169DDC
	arm_func_end ovl01_2169DCC

	arm_func_start ovl01_2169DDC
ovl01_2169DDC: // 0x02169DDC
	add r1, r0, #0x400
	ldrh r3, [r1, #0x44]
	ldrh r2, [r1, #0x78]
	add r2, r3, r2
	strh r2, [r1, #0x44]
	ldrsh r2, [r1, #0x78]
	sub r2, r2, #5
	mov r2, r2, lsl #0x10
	movs r2, r2, asr #0x10
	ldrmi r1, _02169E10 // =ovl01_2169E14
	strmi r1, [r0, #0x378]
	strplh r2, [r1, #0x78]
	bx lr
	.align 2, 0
_02169E10: .word ovl01_2169E14
	arm_func_end ovl01_2169DDC

	arm_func_start ovl01_2169E14
ovl01_2169E14: // 0x02169E14
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xb
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x230]
	ldr r0, _02169E74 // =ovl01_2169E78
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	orr r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169E74: .word ovl01_2169E78
	arm_func_end ovl01_2169E14

	arm_func_start ovl01_2169E78
ovl01_2169E78: // 0x02169E78
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	bne _02169EA4
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
_02169EA4:
	ldr r1, [r4, #0x230]
	mov r0, #0xa3
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r2, [r4, #0x270]
	sub r1, r0, #0xa4
	bic r2, r2, #4
	str r2, [r4, #0x270]
	ldr r3, [r4, #0x2b0]
	mov r2, #0
	bic r3, r3, #4
	str r3, [r4, #0x2b0]
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl ovl01_2161C40
	mov r0, r4
	mov r1, #0
	bl ovl01_2168F84
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2169E78

	arm_func_start ovl01_2169F14
ovl01_2169F14: // 0x02169F14
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xc
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x230]
	ldr r0, _02169F74 // =ovl01_2169F78
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02169F74: .word ovl01_2169F78
	arm_func_end ovl01_2169F14

	arm_func_start ovl01_2169F78
ovl01_2169F78: // 0x02169F78
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl ovl01_2169BE4
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	mov r1, #0xa3
	stmia sp, {r0, r1}
	sub r1, r1, #0xa4
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl ovl01_2161C40
	mov r0, r4
	mov r1, #6
	bl ovl01_2168F84
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_2169F78

	arm_func_start ovl01_2169FE4
ovl01_2169FE4: // 0x02169FE4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl ovl01_2169BE4
	mov r1, #0
	add r0, r4, #0xcc
	str r1, [sp]
	mov r3, #1
	str r3, [sp, #4]
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x20]
	add r0, r4, #0x400
	orr r1, r1, #0x20
	str r1, [r4, #0x20]
	mov r2, #0x7f
	ldr r1, _0216A03C // =ovl01_216A040
	strh r2, [r0, #0x7c]
	str r1, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216A03C: .word ovl01_216A040
	arm_func_end ovl01_2169FE4

	arm_func_start ovl01_216A040
ovl01_216A040: // 0x0216A040
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl01_2169BE4
	add r0, r4, #0x400
	ldrh r1, [r0, #0x7c]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x7c]
	add r0, r4, #0x400
	ldrh r0, [r0, #0x7c]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x374]
	ldr r0, [r0, #0x374]
	ldr r0, [r0, #0xa4c]
	cmp r0, #3
	mov r0, r4
	bne _0216A094
	mov r1, #0
	bl ovl01_2168F84
	ldmia sp!, {r4, pc}
_0216A094:
	bl ovl01_216A09C
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216A040

	arm_func_start ovl01_216A09C
ovl01_216A09C: // 0x0216A09C
	mov r2, #5
	ldr r1, _0216A0B0 // =ovl01_216A0B4
	str r2, [r0, #0x37c]
	str r1, [r0, #0x378]
	bx lr
	.align 2, 0
_0216A0B0: .word ovl01_216A0B4
	arm_func_end ovl01_216A09C

	arm_func_start ovl01_216A0B4
ovl01_216A0B4: // 0x0216A0B4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl ovl01_2169BE4
	ldr r0, [r4, #0x20]
	mov r1, #0
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #9
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x230]
	ldr r0, _0216A124 // =ovl01_216A128
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	orr r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216A124: .word ovl01_216A128
	arm_func_end ovl01_216A0B4

	arm_func_start ovl01_216A128
ovl01_216A128: // 0x0216A128
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl01_2169BE4
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	ldmeqia sp!, {r4, pc}
	ldr r0, _0216A174 // =ovl01_2169DC0
	str r0, [r4, #0x378]
	ldr r0, [r4, #0x230]
	orr r0, r0, #4
	str r0, [r4, #0x230]
	ldr r0, [r4, #0x270]
	orr r0, r0, #4
	str r0, [r4, #0x270]
	ldr r0, [r4, #0x2b0]
	bic r0, r0, #4
	str r0, [r4, #0x2b0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216A174: .word ovl01_2169DC0
	arm_func_end ovl01_216A128

	arm_func_start ovl01_216A178
ovl01_216A178: // 0x0216A178
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r2, r4, #0x500
	ldrh r3, [r2, #0xd8]
	mov r1, #4
	orr r3, r3, #1
	strh r3, [r2, #0xd8]
	ldr r2, [r4, #0x230]
	orr r2, r2, #4
	str r2, [r4, #0x230]
	ldr r2, [r4, #0x270]
	bic r2, r2, #4
	str r2, [r4, #0x270]
	ldr r2, [r4, #0x2b0]
	orr r2, r2, #4
	str r2, [r4, #0x2b0]
	bl ovl01_2168F30
	ldr r0, _0216A1C8 // =ovl01_216A1CC
	str r0, [r4, #0x378]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216A1C8: .word ovl01_216A1CC
	arm_func_end ovl01_216A178

	arm_func_start ovl01_216A1CC
ovl01_216A1CC: // 0x0216A1CC
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x374]
	ldr r1, [r1, #0x374]
	add r1, r1, #0xa00
	ldrh r1, [r1, #0xf0]
	cmp r1, #0
	ldmneia sp!, {r3, pc}
	ldr r1, _0216A20C // =ovl01_2169E14
	add r2, r0, #0x500
	str r1, [r0, #0x378]
	ldrh r3, [r2, #0xd8]
	mov r1, #0
	bic r3, r3, #1
	strh r3, [r2, #0xd8]
	bl ovl01_2168F30
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216A20C: .word ovl01_2169E14
	arm_func_end ovl01_216A1CC

	arm_func_start ovl01_216A210
ovl01_216A210: // 0x0216A210
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x478]
	cmp r0, #0
	bne _0216A24C
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xd
	bl BossHelpers__Animation__Func_2038BF0
	b _0216A274
_0216A24C:
	cmp r0, #1
	bne _0216A274
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x14
	bl BossHelpers__Animation__Func_2038BF0
_0216A274:
	ldr r1, [r4, #0x20]
	mov r0, r4
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	mov r1, #5
	bl ovl01_2168F30
	ldr r1, [r4, #0x230]
	ldr r0, _0216A358 // =gPlayer
	orr r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	ldr r2, _0216A35C // =0x006BAA99
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r3, [r4, #0x2b0]
	mov r1, #0x40000
	orr r3, r3, #4
	str r3, [r4, #0x2b0]
	ldr r0, [r0]
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__Func_2038DCC
	add r1, r4, #0x400
	strh r0, [r1, #0x7c]
	ldrh ip, [r1, #0x7c]
	ldr r0, _0216A360 // =_0217A82C
	mov r2, #0
	strh ip, [r1, #0x44]
	ldr r3, [r4, #0x478]
	mov r3, r3, lsl #1
	ldrh r3, [r0, r3]
	mov r0, #0x37000
	add r3, ip, r3
	strh r3, [r1, #0x44]
	str r0, [r4, #0x470]
	str r2, [r4, #0x480]
	strh r2, [r1, #0x84]
	str r2, [r4, #0x488]
	str r2, [r4, #0x494]
	str r2, [r4, #0x490]
	str r2, [r4, #0x48c]
	mov r0, #0x9f
	str r2, [sp]
	sub r1, r0, #0xa0
	str r0, [sp, #4]
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl ovl01_2161C40
	ldr r0, _0216A364 // =ovl01_216A368
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216A358: .word gPlayer
_0216A35C: .word 0x006BAA99
_0216A360: .word _0217A82C
_0216A364: .word ovl01_216A368
	arm_func_end ovl01_216A210

	arm_func_start ovl01_216A368
ovl01_216A368: // 0x0216A368
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	bxeq lr
	ldr r2, _0216A390 // =ovl01_216A394
	add r1, r0, #0x400
	str r2, [r0, #0x378]
	mov r0, #0x3c
	strh r0, [r1, #0x98]
	bx lr
	.align 2, 0
_0216A390: .word ovl01_216A394
	arm_func_end ovl01_216A368

	arm_func_start ovl01_216A394
ovl01_216A394: // 0x0216A394
	add r1, r0, #0x400
	ldrh r2, [r1, #0x98]
	cmp r2, #0
	subne r2, r2, #1
	strneh r2, [r1, #0x98]
	add r1, r0, #0x400
	ldrh r1, [r1, #0x98]
	cmp r1, #0
	ldreq r1, _0216A3C0 // =ovl01_216A3C4
	streq r1, [r0, #0x378]
	bx lr
	.align 2, 0
_0216A3C0: .word ovl01_216A3C4
	arm_func_end ovl01_216A394

	arm_func_start ovl01_216A3C4
ovl01_216A3C4: // 0x0216A3C4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x478]
	cmp r0, #0
	bne _0216A404
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xe
	bl BossHelpers__Animation__Func_2038BF0
	b _0216A430
_0216A404:
	cmp r0, #1
	bne _0216A430
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x15
	bl BossHelpers__Animation__Func_2038BF0
_0216A430:
	ldr r0, [r4, #0x374]
	bl ovl01_2162AE8
	add r1, r4, #0x400
	strh r0, [r1, #0x84]
	mov r0, r4
	mov r1, #6
	bl ovl01_2168F30
	ldr r0, _0216A45C // =ovl01_216A460
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216A45C: .word ovl01_216A460
	arm_func_end ovl01_216A3C4

	arm_func_start ovl01_216A460
ovl01_216A460: // 0x0216A460
	ldr r2, [r0, #0x478]
	cmp r2, #0
	bne _0216A4D0
	add r2, r0, #0x400
	ldrh r3, [r2, #0x44]
	ldrh r1, [r2, #0x84]
	sub r1, r3, r1
	strh r1, [r2, #0x44]
	ldr ip, [r0, #0x374]
	ldr r3, [ip, #0x398]
	ldr r1, [r3, #0x478]
	cmp r1, #1
	bne _0216A4B0
	add r1, r3, #0x400
	ldrh r1, [r1, #0x44]
	ldrh r2, [r2, #0x44]
	sub r2, r2, r1
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
	b _0216A538
_0216A4B0:
	ldr r1, [ip, #0x39c]
	ldrh r2, [r2, #0x44]
	add r1, r1, #0x400
	ldrh r1, [r1, #0x44]
	sub r2, r2, r1
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
	b _0216A538
_0216A4D0:
	cmp r2, #1
	bne _0216A538
	add r2, r0, #0x400
	ldrh r3, [r2, #0x44]
	ldrh r1, [r2, #0x84]
	add r1, r3, r1
	strh r1, [r2, #0x44]
	ldr ip, [r0, #0x374]
	ldr r3, [ip, #0x398]
	ldr r1, [r3, #0x478]
	cmp r1, #0
	bne _0216A51C
	add r1, r3, #0x400
	ldrh r1, [r1, #0x44]
	ldrh r2, [r2, #0x44]
	sub r2, r1, r2
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
	b _0216A538
_0216A51C:
	ldr r1, [ip, #0x39c]
	ldrh r2, [r2, #0x44]
	add r1, r1, #0x400
	ldrh r1, [r1, #0x44]
	sub r2, r1, r2
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
_0216A538:
	mov r2, r3, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r2, asr #4
	ldr r2, _0216A56C // =FX_SinCosTable_
	mov r3, r3, lsl #2
	ldrsh r2, [r2, r3]
	cmp r2, #0
	bxgt lr
	add r2, r0, #0x400
	ldr r3, _0216A570 // =ovl01_216A574
	strh r1, [r2, #0x44]
	str r3, [r0, #0x378]
	bx lr
	.align 2, 0
_0216A56C: .word FX_SinCosTable_
_0216A570: .word ovl01_216A574
	arm_func_end ovl01_216A460

	arm_func_start ovl01_216A574
ovl01_216A574: // 0x0216A574
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x478]
	cmp r0, #0
	bne _0216A5B0
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xf
	bl BossHelpers__Animation__Func_2038BF0
	b _0216A5D8
_0216A5B0:
	cmp r0, #1
	bne _0216A5D8
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x16
	bl BossHelpers__Animation__Func_2038BF0
_0216A5D8:
	ldr r1, [r4, #0x230]
	ldr r0, _0216A60C // =ovl01_216A610
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	orr r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216A60C: .word ovl01_216A610
	arm_func_end ovl01_216A574

	arm_func_start ovl01_216A610
ovl01_216A610: // 0x0216A610
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldrne r1, _0216A628 // =ovl01_216A62C
	strne r1, [r0, #0x378]
	bx lr
	.align 2, 0
_0216A628: .word ovl01_216A62C
	arm_func_end ovl01_216A610

	arm_func_start ovl01_216A62C
ovl01_216A62C: // 0x0216A62C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x478]
	cmp r0, #0
	bne _0216A66C
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x10
	bl BossHelpers__Animation__Func_2038BF0
	b _0216A698
_0216A66C:
	cmp r0, #1
	bne _0216A698
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x17
	bl BossHelpers__Animation__Func_2038BF0
_0216A698:
	ldr r0, [r4, #0x380]
	cmp r0, #1
	bne _0216A6E4
	mov r0, r4
	mov r1, #7
	bl ovl01_2168F30
	mov r2, #0
	mov r0, #0xa2
	sub r1, r0, #0xa3
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl ovl01_2161C40
_0216A6E4:
	ldr r0, _0216A6F4 // =ovl01_216A6F8
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216A6F4: .word ovl01_216A6F8
	arm_func_end ovl01_216A62C

	arm_func_start ovl01_216A6F8
ovl01_216A6F8: // 0x0216A6F8
	ldr r1, [r0, #0x380]
	cmp r1, #1
	ldreq r1, [r0, #0x488]
	cmpeq r1, #0
	ldrne r1, _0216A72C // =ovl01_216A734
	strne r1, [r0, #0x378]
	bxne lr
	ldr r1, _0216A730 // =ovl01_216A9C8
	str r1, [r0, #0x378]
	ldr r0, [r0, #0x374]
	ldr r0, [r0, #0x398]
	str r1, [r0, #0x378]
	bx lr
	.align 2, 0
_0216A72C: .word ovl01_216A734
_0216A730: .word ovl01_216A9C8
	arm_func_end ovl01_216A6F8

	arm_func_start ovl01_216A734
ovl01_216A734: // 0x0216A734
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x478]
	cmp r0, #0
	bne _0216A770
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x11
	bl BossHelpers__Animation__Func_2038BF0
	b _0216A798
_0216A770:
	cmp r0, #1
	bne _0216A798
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x18
	bl BossHelpers__Animation__Func_2038BF0
_0216A798:
	ldr r0, _0216A7A8 // =ovl01_216A7AC
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216A7A8: .word ovl01_216A7AC
	arm_func_end ovl01_216A734

	arm_func_start ovl01_216A7AC
ovl01_216A7AC: // 0x0216A7AC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r0
	ldr r0, [r4, #0x488]
	cmp r0, #0
	beq _0216A81C
	ldr r1, [r4, #0x44]
	ldr r2, _0216A8A4 // =0x006BAA99
	str r1, [sp]
	ldr r1, [r4, #0x4c]
	ldr r3, _0216A8A8 // =0x00107FC0
	str r1, [sp, #4]
	add r0, sp, #8
	mov r1, #0x40000
	bl BossHelpers__Arena__Func_2038D88
	ldr r1, [r4, #0x4c4]
	ldr r0, [r4, #0x480]
	rsb r5, r1, #0
	bl BossHelpers__Player__IsDead
	cmp r0, #0
	beq _0216A81C
	ldr r1, [sp, #8]
	ldr r0, [r4, #0x480]
	str r1, [r0, #0x44]
	ldr r1, [r4, #0x490]
	ldr r0, [r4, #0x480]
	add r1, r5, r1
	str r1, [r0, #0x48]
_0216A81C:
	ldr r0, [r4, #0x5b0]
	ldr r0, [r0]
	cmp r0, #0x2d000
	bne _0216A888
	ldr r0, [r4, #0x488]
	cmp r0, #0
	beq _0216A870
	ldr r1, [r4, #0x374]
	ldr r0, [r1, #0x4a0]
	orr r0, r0, #4
	str r0, [r1, #0x4a0]
	ldr r0, [r4, #0x480]
	bl BossHelpers__Player__IsDead
	cmp r0, #0
	beq _0216A870
	ldr r0, [r4, #0x480]
	mov r1, #0xa000
	str r1, [r0, #0xb4]
	ldr r0, [r4, #0x480]
	mov r1, #0x32000
	str r1, [r0, #0x9c]
_0216A870:
	mov r0, r4
	mov r1, #5
	bl ovl01_2168F30
	mov r0, #0
	str r0, [r4, #0x488]
	str r0, [r4, #0x480]
_0216A888:
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	ldrne r0, _0216A8AC // =ovl01_216A8B0
	strne r0, [r4, #0x378]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0216A8A4: .word 0x006BAA99
_0216A8A8: .word 0x00107FC0
_0216A8AC: .word ovl01_216A8B0
	arm_func_end ovl01_216A7AC

	arm_func_start ovl01_216A8B0
ovl01_216A8B0: // 0x0216A8B0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x478]
	cmp r0, #0
	bne _0216A8EC
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x12
	bl BossHelpers__Animation__Func_2038BF0
	b _0216A914
_0216A8EC:
	cmp r0, #1
	bne _0216A914
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x19
	bl BossHelpers__Animation__Func_2038BF0
_0216A914:
	ldr r1, [r4, #0x230]
	ldr r0, _0216A948 // =ovl01_216A94C
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216A948: .word ovl01_216A94C
	arm_func_end ovl01_216A8B0

	arm_func_start ovl01_216A94C
ovl01_216A94C: // 0x0216A94C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	mov r1, #0xa3
	stmia sp, {r0, r1}
	sub r1, r1, #0xa4
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl ovl01_2161C40
	mov r0, r4
	mov r1, #0
	bl ovl01_2168F84
	mov r0, r4
	mov r1, #0
	bl ovl01_2168F30
	mov r0, #0x32000
	str r0, [r4, #0x470]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216A94C

	arm_func_start ovl01_216A9C8
ovl01_216A9C8: // 0x0216A9C8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x478]
	cmp r0, #0
	bne _0216AA04
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x13
	bl BossHelpers__Animation__Func_2038BF0
	b _0216AA2C
_0216AA04:
	cmp r0, #1
	bne _0216AA2C
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x1a
	bl BossHelpers__Animation__Func_2038BF0
_0216AA2C:
	mov r0, r4
	mov r1, #0
	bl ovl01_2168F30
	ldr r1, [r4, #0x230]
	ldr r0, _0216AA6C // =ovl01_216AA70
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216AA6C: .word ovl01_216AA70
	arm_func_end ovl01_216A9C8

	arm_func_start ovl01_216AA70
ovl01_216AA70: // 0x0216AA70
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	mov r1, #0xa3
	stmia sp, {r0, r1}
	sub r1, r1, #0xa4
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl ovl01_2161C40
	mov r2, #0x32000
	mov r0, r4
	mov r1, #0
	str r2, [r4, #0x470]
	bl ovl01_2168F84
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216AA70

	arm_func_start ovl01_216AAE0
ovl01_216AAE0: // 0x0216AAE0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r2, r4, #0x500
	ldrh r3, [r2, #0xd8]
	mov r1, #8
	orr r3, r3, #1
	strh r3, [r2, #0xd8]
	ldr r2, [r4, #0x230]
	orr r2, r2, #4
	str r2, [r4, #0x230]
	ldr r2, [r4, #0x270]
	bic r2, r2, #4
	str r2, [r4, #0x270]
	ldr r2, [r4, #0x2b0]
	orr r2, r2, #4
	str r2, [r4, #0x2b0]
	bl ovl01_2168F30
	ldr r0, _0216AB30 // =ovl01_216AB34
	str r0, [r4, #0x378]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216AB30: .word ovl01_216AB34
	arm_func_end ovl01_216AAE0

	arm_func_start ovl01_216AB34
ovl01_216AB34: // 0x0216AB34
	ldr r1, [r0, #0x374]
	ldr r2, [r0, #0x478]
	ldr r1, [r1, #0x39c]
	cmp r2, #0
	add r1, r1, #0x400
	ldrh r1, [r1, #0x44]
	bne _0216AB68
	add r2, r0, #0x400
	ldrh r2, [r2, #0x44]
	sub r2, r2, r1
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
	b _0216AB84
_0216AB68:
	cmp r2, #1
	bne _0216AB84
	add r2, r0, #0x400
	ldrh r2, [r2, #0x44]
	sub r2, r1, r2
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
_0216AB84:
	mov r2, r3, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r2, asr #4
	ldr r2, _0216ABC8 // =FX_SinCosTable_
	mov r3, r3, lsl #2
	ldrsh r2, [r2, r3]
	cmp r2, #0
	bxgt lr
	add r2, r0, #0x400
	ldr r3, _0216ABCC // =ovl01_216A574
	strh r1, [r2, #0x44]
	str r3, [r0, #0x378]
	add r0, r0, #0x500
	ldrh r1, [r0, #0xd8]
	bic r1, r1, #1
	strh r1, [r0, #0xd8]
	bx lr
	.align 2, 0
_0216ABC8: .word FX_SinCosTable_
_0216ABCC: .word ovl01_216A574
	arm_func_end ovl01_216AB34

	arm_func_start ovl01_216ABD0
ovl01_216ABD0: // 0x0216ABD0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #3
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x20]
	mov r0, r4
	bic r2, r1, #0x20
	mov r1, #9
	str r2, [r4, #0x20]
	bl ovl01_2168F30
	mov r2, #0
	mov r0, #0x9f
	sub r1, r0, #0xa0
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl ovl01_2161C40
	ldr r0, _0216AC58 // =ovl01_216AC5C
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216AC58: .word ovl01_216AC5C
	arm_func_end ovl01_216ABD0

	arm_func_start ovl01_216AC5C
ovl01_216AC5C: // 0x0216AC5C
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldrne r1, _0216AC74 // =ovl01_216AC78
	strne r1, [r0, #0x378]
	bx lr
	.align 2, 0
_0216AC74: .word ovl01_216AC78
	arm_func_end ovl01_216AC5C

	arm_func_start ovl01_216AC78
ovl01_216AC78: // 0x0216AC78
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #5
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x230]
	ldr r0, _0216ACD8 // =ovl01_216ACDC
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	orr r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216ACD8: .word ovl01_216ACDC
	arm_func_end ovl01_216AC78

	arm_func_start ovl01_216ACDC
ovl01_216ACDC: // 0x0216ACDC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	mov r0, #0xa0
	str r1, [sp]
	sub r1, r0, #0xa1
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl ovl01_2161C40
	ldr r2, [r4, #0x374]
	mov r3, #0
	mov r0, r4
	mov r1, #0xc
	str r3, [r2, #0x40c]
	bl ovl01_2168F84
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216ACDC

	arm_func_start ovl01_216AD50
ovl01_216AD50: // 0x0216AD50
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #6
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x230]
	ldr r0, _0216ADB4 // =ovl01_216ADB8
	orr r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	orr r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216ADB4: .word ovl01_216ADB8
	arm_func_end ovl01_216AD50

	arm_func_start ovl01_216ADB8
ovl01_216ADB8: // 0x0216ADB8
	bx lr
	arm_func_end ovl01_216ADB8

	arm_func_start ovl01_216ADBC
ovl01_216ADBC: // 0x0216ADBC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #7
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x230]
	ldr r0, _0216AE1C // =ovl01_216AE20
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216AE1C: .word ovl01_216AE20
	arm_func_end ovl01_216ADBC

	arm_func_start ovl01_216AE20
ovl01_216AE20: // 0x0216AE20
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	mov r1, #0xa3
	stmia sp, {r0, r1}
	sub r1, r1, #0xa4
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl ovl01_2161C40
	mov r0, r4
	mov r1, #0
	bl ovl01_2168F84
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216AE20

	arm_func_start ovl01_216AE88
ovl01_216AE88: // 0x0216AE88
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #8
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x230]
	ldr r0, _0216AEE8 // =ovl01_216AEEC
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216AEE8: .word ovl01_216AEEC
	arm_func_end ovl01_216AE88

	arm_func_start ovl01_216AEEC
ovl01_216AEEC: // 0x0216AEEC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	mov r1, #0xa3
	stmia sp, {r0, r1}
	sub r1, r1, #0xa4
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl ovl01_2161C40
	mov r0, r4
	mov r1, #0
	bl ovl01_2168F84
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216AEEC

	arm_func_start ovl01_216AF54
ovl01_216AF54: // 0x0216AF54
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r2, r4, #0x500
	ldrh r3, [r2, #0xd8]
	mov r1, #0xa
	orr r3, r3, #1
	strh r3, [r2, #0xd8]
	ldr r2, [r4, #0x230]
	orr r2, r2, #4
	str r2, [r4, #0x230]
	ldr r2, [r4, #0x270]
	bic r2, r2, #4
	str r2, [r4, #0x270]
	ldr r2, [r4, #0x2b0]
	orr r2, r2, #4
	str r2, [r4, #0x2b0]
	bl ovl01_2168F30
	add r0, r4, #0x400
	mov r2, #0xb4
	ldr r1, _0216AFB0 // =ovl01_216AFB4
	strh r2, [r0, #0x74]
	str r1, [r4, #0x378]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216AFB0: .word ovl01_216AFB4
	arm_func_end ovl01_216AF54

	arm_func_start ovl01_216AFB4
ovl01_216AFB4: // 0x0216AFB4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x400
	ldrh r1, [r0, #0x74]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x74]
	add r0, r4, #0x400
	ldrh r0, [r0, #0x74]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0xe
	bl ovl01_2168F84
	mov r0, r4
	mov r1, #9
	bl ovl01_2168F30
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216AFB4

	arm_func_start ovl01_216AFFC
ovl01_216AFFC: // 0x0216AFFC
	ldr r1, [r0, #0x374]
	ldr r1, [r1, #0x374]
	ldr r1, [r1, #0xaf0]
	cmp r1, #0
	add r1, r0, #0x400
	ldreqsh r3, [r1, #0x44]
	ldreqsh r2, [r1, #0x78]
	subeq r2, r3, r2
	beq _0216B02C
	ldrsh r3, [r1, #0x44]
	ldrsh r2, [r1, #0x78]
	add r2, r3, r2
_0216B02C:
	add r0, r0, #0x400
	strh r2, [r1, #0x44]
	ldrh r1, [r0, #0x78]
	add r1, r1, #5
	strh r1, [r0, #0x78]
	ldrh r2, [r0, #0x7a]
	ldrh r1, [r0, #0x78]
	cmp r1, r2
	strhih r2, [r0, #0x78]
	bx lr
	arm_func_end ovl01_216AFFC

	arm_func_start ovl01_216B054
ovl01_216B054: // 0x0216B054
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r1, [r5, #0x374]
	add r0, r5, #0xcc
	ldr r4, [r1, #0x374]
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldr r2, [r5, #0x368]
	add r0, r0, #0x400
	mov r3, #9
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r5, #0x20]
	mov r0, r5
	bic r1, r1, #0x20
	str r1, [r5, #0x20]
	ldr r2, [r5, #0x230]
	mov r1, #0xb
	bic r2, r2, #4
	str r2, [r5, #0x230]
	ldr r2, [r5, #0x270]
	orr r2, r2, #4
	str r2, [r5, #0x270]
	ldr r2, [r5, #0x2b0]
	bic r2, r2, #4
	str r2, [r5, #0x2b0]
	bl ovl01_2168F30
	ldr r0, [r4, #0xaf0]
	cmp r0, #0
	add r0, r4, #0xa00
	beq _0216B0E8
	ldrsh r2, [r0, #0xd6]
	ldr r0, _0216B130 // =0xFFFFE71C
	add r1, r5, #0x400
	add r0, r2, r0
	b _0216B0F8
_0216B0E8:
	ldrsh r0, [r0, #0xd6]
	add r1, r5, #0x400
	add r0, r0, #0xe4
	add r0, r0, #0x1800
_0216B0F8:
	strh r0, [r1, #0x44]
	ldrh r0, [r1, #0x44]
	strh r0, [r1, #0x7c]
	add r0, r5, #0x400
	mov r1, #0
	strh r1, [r0, #0x78]
	ldr r0, [r5, #0x374]
	bl ovl01_2162B04
	add r1, r5, #0x400
	ldr r2, _0216B134 // =ovl01_216B138
	strh r0, [r1, #0x7a]
	str r2, [r5, #0x378]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0216B130: .word 0xFFFFE71C
_0216B134: .word ovl01_216B138
	arm_func_end ovl01_216B054

	arm_func_start ovl01_216B138
ovl01_216B138: // 0x0216B138
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldrne r1, _0216B150 // =ovl01_216B154
	strne r1, [r0, #0x378]
	bx lr
	.align 2, 0
_0216B150: .word ovl01_216B154
	arm_func_end ovl01_216B138

	arm_func_start ovl01_216B154
ovl01_216B154: // 0x0216B154
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xa
	bl BossHelpers__Animation__Func_2038BF0
	add r0, r4, #0x400
	mov r1, #0
	strh r1, [r0, #0x78]
	ldr r1, [r4, #0x230]
	ldr r0, _0216B1C4 // =ovl01_216B1C8
	orr r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	orr r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B1C4: .word ovl01_216B1C8
	arm_func_end ovl01_216B154

	arm_func_start ovl01_216B1C8
ovl01_216B1C8: // 0x0216B1C8
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x374]
	ldr r1, [r1, #0x374]
	ldr r1, [r1, #0xaf0]
	cmp r1, #0
	add r1, r0, #0x400
	ldrnesh r2, [r1, #0x44]
	ldrnesh r1, [r1, #0x7c]
	ldreqsh r2, [r1, #0x7c]
	ldreqsh r1, [r1, #0x44]
	sub r1, r2, r1
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	ldr r1, _0216B218 // =0x000031C8
	cmp r2, r1
	ldrhs r1, _0216B21C // =ovl01_216B220
	strhs r1, [r0, #0x378]
	ldmhsia sp!, {r3, pc}
	bl ovl01_216AFFC
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216B218: .word 0x000031C8
_0216B21C: .word ovl01_216B220
	arm_func_end ovl01_216B1C8

	arm_func_start ovl01_216B220
ovl01_216B220: // 0x0216B220
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xb
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x230]
	ldr r0, _0216B280 // =ovl01_216B284
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	orr r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B280: .word ovl01_216B284
	arm_func_end ovl01_216B220

	arm_func_start ovl01_216B284
ovl01_216B284: // 0x0216B284
	stmdb sp!, {r3, lr}
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldmeqia sp!, {r3, pc}
	ldr r2, [r0, #0x230]
	mov r1, #0xf
	bic r2, r2, #4
	str r2, [r0, #0x230]
	ldr r2, [r0, #0x270]
	bic r2, r2, #4
	str r2, [r0, #0x270]
	ldr r2, [r0, #0x2b0]
	bic r2, r2, #4
	str r2, [r0, #0x2b0]
	bl ovl01_2168F84
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_216B284

	arm_func_start ovl01_216B2C8
ovl01_216B2C8: // 0x0216B2C8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xc
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x230]
	ldr r0, _0216B328 // =ovl01_216B32C
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B328: .word ovl01_216B32C
	arm_func_end ovl01_216B2C8

	arm_func_start ovl01_216B32C
ovl01_216B32C: // 0x0216B32C
	stmdb sp!, {r3, lr}
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldmeqia sp!, {r3, pc}
	mov r1, #0xf
	bl ovl01_2168F84
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_216B32C

	arm_func_start ovl01_216B34C
ovl01_216B34C: // 0x0216B34C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r2, r4, #0x500
	ldrh r3, [r2, #0xd8]
	mov r1, #0xc
	orr r3, r3, #1
	strh r3, [r2, #0xd8]
	ldr r2, [r4, #0x230]
	orr r2, r2, #4
	str r2, [r4, #0x230]
	ldr r2, [r4, #0x270]
	bic r2, r2, #4
	str r2, [r4, #0x270]
	ldr r2, [r4, #0x2b0]
	orr r2, r2, #4
	str r2, [r4, #0x2b0]
	bl ovl01_2168F30
	add r0, r4, #0x400
	mov r2, #0xb4
	ldr r1, _0216B3A8 // =ovl01_216B3AC
	strh r2, [r0, #0x74]
	str r1, [r4, #0x378]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B3A8: .word ovl01_216B3AC
	arm_func_end ovl01_216B34C

	arm_func_start ovl01_216B3AC
ovl01_216B3AC: // 0x0216B3AC
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x400
	ldrh r1, [r0, #0x74]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x74]
	add r0, r4, #0x400
	ldrh r0, [r0, #0x74]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl ovl01_216B2C8
	mov r0, r4
	mov r1, #0
	bl ovl01_2168F30
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216B3AC

	arm_func_start ovl01_216B3F0
ovl01_216B3F0: // 0x0216B3F0
	ldr r1, _0216B3FC // =ovl01_216B400
	str r1, [r0, #0x378]
	bx lr
	.align 2, 0
_0216B3FC: .word ovl01_216B400
	arm_func_end ovl01_216B3F0

	arm_func_start ovl01_216B400
ovl01_216B400: // 0x0216B400
	ldr ip, _0216B40C // =ovl01_2168F84
	mov r1, #0
	bx ip
	.align 2, 0
_0216B40C: .word ovl01_2168F84
	arm_func_end ovl01_216B400

	arm_func_start ovl01_216B410
ovl01_216B410: // 0x0216B410
	ldr r1, _0216B41C // =ovl01_216B420
	str r1, [r0, #0x378]
	bx lr
	.align 2, 0
_0216B41C: .word ovl01_216B420
	arm_func_end ovl01_216B410

	arm_func_start ovl01_216B420
ovl01_216B420: // 0x0216B420
	ldr ip, _0216B42C // =ovl01_2168F84
	mov r1, #0
	bx ip
	.align 2, 0
_0216B42C: .word ovl01_2168F84
	arm_func_end ovl01_216B420

	arm_func_start ovl01_216B430
ovl01_216B430: // 0x0216B430
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #3
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x20]
	mov r0, r4
	bic r2, r1, #0x20
	mov r1, #0xd
	str r2, [r4, #0x20]
	bl ovl01_2168F30
	ldr r0, _0216B484 // =ovl01_216B488
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B484: .word ovl01_216B488
	arm_func_end ovl01_216B430

	arm_func_start ovl01_216B488
ovl01_216B488: // 0x0216B488
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldrne r1, _0216B4A0 // =ovl01_216B4A4
	strne r1, [r0, #0x378]
	bx lr
	.align 2, 0
_0216B4A0: .word ovl01_216B4A4
	arm_func_end ovl01_216B488

	arm_func_start ovl01_216B4A4
ovl01_216B4A4: // 0x0216B4A4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #5
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x270]
	ldr r0, _0216B4EC // =ovl01_216B4F0
	orr r1, r1, #4
	str r1, [r4, #0x270]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B4EC: .word ovl01_216B4F0
	arm_func_end ovl01_216B4A4

	arm_func_start ovl01_216B4F0
ovl01_216B4F0: // 0x0216B4F0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	mov r0, #0xa0
	str r1, [sp]
	sub r1, r0, #0xa1
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, r4
	mov r1, #0x16
	bl ovl01_2168F84
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl01_216B4F0

	arm_func_start ovl01_216B548
ovl01_216B548: // 0x0216B548
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #6
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x230]
	ldr r0, _0216B5AC // =ovl01_216B5B0
	orr r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	orr r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B5AC: .word ovl01_216B5B0
	arm_func_end ovl01_216B548

	arm_func_start ovl01_216B5B0
ovl01_216B5B0: // 0x0216B5B0
	bx lr
	arm_func_end ovl01_216B5B0

	arm_func_start ovl01_216B5B4
ovl01_216B5B4: // 0x0216B5B4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #7
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x230]
	ldr r0, _0216B614 // =ovl01_216B618
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216B614: .word ovl01_216B618
	arm_func_end ovl01_216B5B4

	arm_func_start ovl01_216B618
ovl01_216B618: // 0x0216B618
	stmdb sp!, {r3, lr}
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldmeqia sp!, {r3, pc}
	mov r1, #0
	bl ovl01_2168F84
	ldmia sp!, {r3, pc}
	arm_func_end ovl01_216B618

	.rodata
	
_02179D9C: // 0x02179D9C
    .byte 0
	
_02179D9D: // 0x02179D9D
    .byte 1

_02179D9E: // 0x02179D9E
    .byte 2

_02179D9F: // 0x02179D9F
    .byte 3

_02179DA0: // 0x02179DA0
    .word 0x90003
	
_02179DA4: // 0x02179DA4
    .byte 0x55, 0x55, 0x55, 0x55, 0x55, 0x55

_02179DAA: // 0x02179DAA
	.byte 0, 0, 1, 0, 2, 0

_02179DB0: // 0x02179DB0
    .hword 0x333, 0x200, 0xCC

_02179DB6: // 0x02179DB6
    .hword 0x5999, 0x5999, 0x4CCC
	
_02179DBC: // 0x02179DBC
    .word 0x11100E3, 0x16C013E
	
_02179DC4: // 0x02179DC4
    .hword 0x30, 0x30, 0x30, 0x30
	
_02179DCC: // 0x02179DCC
    .word 0x1000, 0xCCC
	
_02179DD4: // 0x02179DD4
    .word 0x880088, 0x880088
	
_02179DDC: // 0x02179DDC
    .word 0xB600B6, 0xB600B6
	
_02179DE4: // 0x02179DE4
    .hword 0x3C, 0x3C, 0x3C, 0x3C
	
_02179DEC: // 0x02179DEC
    .hword 0x1B

_02179DEE: // 0x02179DEE
    .hword 0x1A

_02179DF0: // 0x02179DF0
    .hword 0x19

_02179DF2: // 0x02179DF2
    .hword 0x18

_02179DF4: // 0x02179DF4
    .word 0x6E0032, 0x500019, 1
	
_02179E00: // 0x02179E00
    .word 0, 0x1000, 0
_02179E0C: // 0x02179E0C
    .word 0xFFFF, 0x4CCCB332, 0xB3324CCC, 0xFFFF0000
	
_02179E1C: // 0x02179E1C
    .word 0x333, 0x666, 0x999, 0xCCC
	
_02179E2C: // 0x02179E2C
    .word 0x30003, 0x30003, 0x40003, 0x40003
	
_02179E3C: // 0x02179E3C
    .word 0x2000, 0xAAA, 0xFFFFF556, 0xFFFFE000
	
_02179E4C: // 0x02179E4C
    .word 0xCCCC3333, 0xB3324CCC, 0x99996666, 0x7FFF7FFF
	
_02179E5C: // 0x02179E5C
    .word 0x7FFF4CCC, 0x66663333, 0x66666666, 0x33337FFF, 0x99994CCC, 0x33333333

_02179E74: // 0x02179E74
    .word 0xD0000, 0xF000

	.data

_0217A82C: // 0x0217A82C
    .word 0xE0002000
	
_0217A830: // 0x0217A830
    .hword 0xFFE8
	
_0217A832: // 0x0217A832
    .hword 0xFFF0
	
_0217A834: // 0x0217A834
    .hword 0x18
	
_0217A836: // 0x0217A836
    .hword 0x18
	
_0217A838: // 0x0217A838
    .word 0xE0006000, 0xA0002000
	
_0217A840: // 0x0217A840
    .hword 0xFFE8

_0217A842: // 0x0217A842
    .hword 0xFFE8

_0217A844: // 0x0217A844
    .hword 0x18

_0217A846: // 0x0217A846
    .hword 0x18

_0217A848: // 0x0217A848
    .hword 0xFFF0

_0217A84A: // 0x0217A84A
    .hword 0xFFF0

_0217A84C: // 0x0217A84C
    .hword 0x10

_0217A84E: // 0x0217A84E
    .hword 0x10

_0217A850: // 0x0217A850
	.word 0, 0

_0217A858: // 0x0217A858
    .word _0217A970, _0217AA18, _0217AA18, _0217AA18

_0217A868: // 0x0217A868
    .hword 0xFFE6
	
_0217A86A: // 0x0217A86A
    .hword 0xFFE8

_0217A86C: // 0x0217A86C
    .hword 0x1A
	
_0217A86E: // 0x0217A86E
    .hword 0xFFF8
	
_0217A870: // 0x0217A870
    .hword 0xFFE2
	
_0217A872: // 0x0217A872
    .hword 0xFFCE
	
_0217A874: // 0x0217A874
    .hword 0x1E
	
_0217A876: // 0x0217A876
    .hword 0x18
	
_0217A878: // 0x0217A878
    .hword 0xFFE1

_0217A87A: // 0x0217A87A
    .hword 0xFFF8

_0217A87C: // 0x0217A87C
    .hword 0x1F

_0217A87E: // 0x0217A87E
    .hword 0x18

_0217A880: // 0x0217A880
    .word 0xFFE2FFCE, 0xFFE80010, 0xFFE2FFCE, 0x1E0018, 0xFFE8FFEC, 0x1F0014

_0217A898: // 0x0217A898
    .word 0, 0
	.word 0x18E3, 0
	.word 0xE71C18E3, 0
	.word 0xE71C31C7, 0x18E3

_0217A8B8: // 0x0217A8B8
    .word 3, 0, 2, 1, 3, 2, 0, 1

_0217A8D8: // 0x0217A8D8
    .word 3, 2, 1, 0
	
_0217A8E8: // 0x0217A8E8
	.word aZ3Atama1Pl         // "z3_atama1_pl"
	.word aZ3Atama2Pl         // "z3_atama2_pl"
	.word aZ3Atama3Pl         // "z3_atama3_pl"
	.word aZ3BodyPl           // "z3_body_pl"
	.word aZ3EyePl            // "z3_eye_pl"
	.word aZ3FmPl             // "z3_fm_pl"
	.word aZ3HandPl           // "z3_hand_pl"
	.word aZ3Htop1Pl          // "z3_htop1_pl"
	.word aZ3Htop2Pl          // "z3_htop2_pl"
	.word aZ3Htop3Pl          // "z3_htop3_pl"
	.word aZ3NeckPl           // "z3_neck_pl"
	.word aZ3OmemePl          // "z3_omeme_pl"
	.word aZ3RPl              // "z3_r_pl"
	.word aZ3SidePl           // "z3_side_pl"
	.word aZ3UnderPl          // "z3_under_pl"
	.word aZ3WeakpPl          // "z3_weakp_pl"

_0217A928: // 0x0217A928
    .word 0x107FC0, 0x3C000, 0x83FE0, 0
	.word 0xD2000, 0x107FC0, 0x83FE0, 0x28000, 0
	.word 0x107FC0, 0x6E000, 0
	.word 0x83FE0, 0x14000, 0x107FC0, 0x83FE0, 0xC8000, 0x107FC0

_0217A970: // 0x0217A970
    .word ovl01_21687E8
	.word 0
	.word ovl01_2168D6C
	.word ovl01_21687E8
	.word 0
	.word ovl01_2168D6C
	.word ovl01_2168A68
	.word 0
	.word ovl01_2168D6C
	.word ovl01_2168850
	.word 0
	.word ovl01_2168D6C
	.word ovl01_2168A68
	.word 0
	.word ovl01_2168D6C
	.word ovl01_21688BC
	.word 0
	.word ovl01_2168D6C
	.word ovl01_21688BC
	.word 0
	.word ovl01_2168E34
	.word ovl01_21688BC
	.word 0
	.word ovl01_2168E34
	.word ovl01_2168A68
	.word 0, 0
	.word ovl01_2168924
	.word 0
	.word ovl01_2168D6C
	.word ovl01_2168A68
	.word 0
	.word ovl01_2168D6C
	.word ovl01_216898C
	.word 0
	.word ovl01_2168D6C
	.word ovl01_2168A68
	.word 0
	.word ovl01_2168D6C
	.word ovl01_2168A04

_0217AA10: // 0x0217AA10
    .word 0, ovl01_2168D6C

_0217AA18: // 0x0217AA18
    .word ovl01_2168AC4
	.word 0
	.word ovl01_2168D6C
	.word ovl01_2168AC4
	.word 0
	.word ovl01_2168D6C
	.word 0, 0, 0
	.word ovl01_2168B4C
	.word 0
	.word ovl01_2168D6C
	.word ovl01_2168B4C
	.word 0
	.word ovl01_2168D6C
	.word ovl01_2168BD4
	.word 0
	.word ovl01_2168D6C
	.word ovl01_2168BD4
	.word 0
	.word ovl01_2168E34
	.word ovl01_2168BD4
	.word 0
	.word ovl01_2168EDC
	.word ovl01_2168BD4
	.word 0, 0
	.word ovl01_2168C60
	.word 0
	.word ovl01_2168D6C
	.word ovl01_2168C60
	.word 0
	.word ovl01_2168D6C
	.word ovl01_2168CE8
	.word 0
	.word ovl01_2168D6C
	.word ovl01_2168CE8
	.word 0
	.word ovl01_2168D6C
	.word ovl01_2168C60
	.word 0
	.word ovl01_2168D6C

aZ3RPl: // 0x0217AAC0
    .asciz "z3_r_pl"
    .align 4

aZ3FmPl: // 0x0217AAC8
    .asciz "z3_fm_pl"
    .align 4

aZ3EyePl: // 0x0217AAD4
    .asciz "z3_eye_pl"
    .align 4

aZ3BodyPl: // 0x0217AAE0
    .asciz "z3_body_pl"
    .align 4

aZ3HandPl: // 0x0217AAEC
    .asciz "z3_hand_pl"
    .align 4

aZ3SidePl: // 0x0217AAF8
    .asciz "z3_side_pl"
    .align 4

aZ3NeckPl: // 0x0217AB04
    .asciz "z3_neck_pl"
    .align 4

aZ3Htop1Pl: // 0x0217AB10
    .asciz "z3_htop1_pl"
    .align 4

aZ3Htop2Pl: // 0x0217AB1C
    .asciz "z3_htop2_pl"
    .align 4

aZ3Htop3Pl: // 0x0217AB28
    .asciz "z3_htop3_pl"
    .align 4

aZ3OmemePl: // 0x0217AB34
    .asciz "z3_omeme_pl"
    .align 4

aZ3UnderPl: // 0x0217AB40
    .asciz "z3_under_pl"
    .align 4

aZ3WeakpPl: // 0x0217AB4C
    .asciz "z3_weakp_pl"
    .align 4

aZ3Atama1Pl: // 0x0217AB58
    .asciz "z3_atama1_pl"
    .align 4

aZ3Atama2Pl: // 0x0217AB68
    .asciz "z3_atama2_pl"
    .align 4

aZ3Atama3Pl: // 0x0217AB78
    .asciz "z3_atama3_pl"
    .align 4

aStage00: // 0x0217AB88
    .asciz "stage_00"
    .align 4

aExc_3: // 0x0217AB94
    .asciz "exc"
    .align 4

aBody_0: // 0x0217AB98
    .asciz "body"
    .align 4

aMouth: // 0x0217ABA0
    .asciz "mouth"
    .align 4

aArmHit: // 0x0217ABA8
    .asciz "arm_hit"
    .align 4
