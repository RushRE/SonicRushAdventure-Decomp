	.include "asm/macros.inc"
	.include "global.inc"

.public BossArena__explosionFXSpawnTime
	
	.bss

.public Boss6Stage__Singleton
Boss6Stage__Singleton: // 0x02179B9C
	.space 0x04 // Task*
	
	.text

	arm_func_start Boss6Stage__Create
Boss6Stage__Create: // 0x021539C4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x80
	mov r3, #0x1500
	mov r6, r0
	mov r5, r1
	str r2, [sp, #0x14]
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _02153DD4 // =0x00000E28
	ldr r0, _02153DD8 // =StageTask_Main
	ldr r1, _02153DDC // =ovl02_21566C4
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, _02153DE0 // =Boss6Stage__Singleton
	str r0, [r1]
	bl GetTaskWork_
	mov r8, r0
	mov r0, #0
	mov r1, r8
	mov r2, r4
	bl MIi_CpuClear16
	ldr r3, [sp, #0x14]
	mov r1, r6
	mov r2, r5
	mov r0, r8
	bl GameObject__InitFromObject
	ldr r1, _02153DE4 // =ovl02_21565D8
	ldr r0, _02153DE8 // =ovl02_21567AC
	str r1, [r8, #0xf4]
	str r0, [r8, #0xfc]
	ldr r0, [r8, #0x18]
	ldr r2, _02153DEC // =0x000034CC
	orr r0, r0, #0x12
	str r0, [r8, #0x18]
	ldr r0, [r8, #0x20]
	mov r1, #0x400
	orr r0, r0, #0x2180
	str r0, [r8, #0x20]
	ldr r3, [r8, #0x1c]
	add r0, r8, #0x300
	orr r3, r3, #0xa300
	str r3, [r8, #0x1c]
	str r2, [r8, #0x38]
	str r2, [r8, #0x3c]
	str r2, [r8, #0x40]
	strh r1, [r0, #0x80]
	ldr r0, [sp, #0x14]
	ldr r1, _02153DF0 // =ovl02_2156834
	rsb r4, r0, #0
	str r4, [r8, #0x38c]
	add r0, r8, #0x390
	str r1, [r8, #0x37c]
	bl ovl02_2156274
	ldr r1, _02153DF4 // =0x00083FE0
	ldr r0, _02153DF8 // =0x001EEF88
	str r1, [r8, #0x390]
	str r4, [r8, #0x394]
	str r0, [r8, #0x398]
	mov r0, r8
	bl ovl02_2155A78
	mov r1, #0
	str r1, [r8, #0x39c]
	str r1, [r8, #0x3a0]
	str r0, [r8, #0x3a4]
	add r0, r8, #0x23c
	ldr r1, _02153DFC // =_02178CCC
	add r0, r0, #0x800
	mov r2, #0xc
	bl BossHelpers__Unknown2038AEC__Init
	add r0, r8, #0x154
	add r0, r0, #0xc00
	bl BossHelpers__Light__Init
	add r0, r8, #0x364
	bl ovl02_2154F7C
	bl BossHelpers__Model__InitSystem
	mov r9, #0
	add r0, r8, #0x158
	ldr r7, _02153E00 // =0x02133A18
	ldr r4, _02153E04 // =_02179680
	add r10, r0, #0x400
	mov r6, r9
	mov r5, r9
_02153B18:
	str r7, [sp]
	mov r0, r8
	mov r1, r10
	mov r2, r4
	mov r3, r9
	str r6, [sp, #4]
	bl ObjAction3dNNModelLoad
	add r9, r9, #1
	str r5, [r8, #0x12c]
	cmp r9, #3
	add r10, r10, #0x17c
	blt _02153B18
	ldr r0, _02153E08 // =bossAssetFiles
	add r4, r8, #0x258
	str r0, [sp]
	ldr r2, _02153E04 // =_02179680
	mov r0, r8
	add r1, r4, #0x800
	mov r3, #9
	str r5, [sp, #4]
	bl ObjAction3dNNModelLoad
	mov r6, #0
	add r5, r8, #0x3d4
	mov r0, #0xa000
	str r6, [r8, #0x12c]
	str r0, [r4, #0x820]
	str r0, [r4, #0x818]
	mov r0, #0xc
	strb r0, [r4, #0x80a]
	mov r0, #0x13
	strb r0, [r4, #0x80b]
	ldr r0, _02153E08 // =bossAssetFiles
	strb r6, [r4, #0x80c]
	str r0, [sp]
	ldr r2, _02153E04 // =_02179680
	mov r0, r8
	add r1, r5, #0x800
	mov r3, #0xa
	str r6, [sp, #4]
	bl ObjAction3dNNModelLoad
	mov r1, r6
	str r1, [r8, #0x12c]
	strb r1, [r5, #0x80a]
	ldr r0, _02153E0C // =gameArchiveStage
	ldr r1, _02153E10 // =_02179684
	ldr r2, [r0]
	add r0, sp, #0x18
	bl NNS_FndMountArchive
	add r0, r8, #0x1cc
	ldr r4, _02153E08 // =bossAssetFiles
	add r10, r0, #0x800
	mov r9, r6
	add r7, sp, #0x18
	mov r11, #0x16
	mov r5, #5
_02153BF4:
	mov r0, r7
	mov r1, r11
	bl NNS_FndGetArchiveFileByIndex
	mov r6, r0
	ldr r0, [r4, #0x10]
	bl NNS_G3dGetTex
	ldr r1, _02153E14 // =aZ6TaLinePl
	bl Asset3DSetup__PaletteFromName
	str r5, [sp]
	str r0, [sp, #4]
	mov r1, r6
	mov r0, r10
	mov r2, #0
	mov r3, #2
	bl InitPaletteAnimator
	add r9, r9, #1
	add r10, r10, #0x20
	cmp r9, #3
	blt _02153BF4
	add r0, r8, #0x188
	ldr r6, _02153E18 // =_02179504
	ldr r4, _02153E08 // =bossAssetFiles
	add r9, r0, #0xc00
	mov r10, #0
	add r11, sp, #0x18
	mov r5, #5
_02153C5C:
	mov r0, r11
	add r1, r10, #0x17
	bl NNS_FndGetArchiveFileByIndex
	mov r7, r0
	ldr r0, [r4, #0x18]
	bl NNS_G3dGetTex
	ldr r1, [r6, r10, lsl #2]
	bl Asset3DSetup__PaletteFromName
	str r5, [sp]
	mov r2, #0
	str r0, [sp, #4]
	mov r1, r7
	mov r0, r9
	mov r3, r2
	bl InitPaletteAnimator
	add r10, r10, #1
	add r9, r9, #0x20
	cmp r10, #4
	blt _02153C5C
	add r0, r8, #0x188
	mov r2, #0
	mov r3, r2
	add r0, r0, #0xc00
	mov r1, #4
	bl BossHelpers__Palette__Func_2038BAC
	add r0, sp, #0x18
	mov r1, #0x1b
	bl NNS_FndGetArchiveFileByIndex
	ldr r1, _02153E08 // =bossAssetFiles
	mov r4, r0
	ldr r0, [r1]
	bl NNS_G3dGetTex
	ldr r1, _02153E1C // =_021794DC
	ldr r1, [r1]
	bl Asset3DSetup__PaletteFromName
	mov r2, #5
	str r2, [sp]
	str r0, [sp, #4]
	add r0, r8, #0x208
	mov r2, #0
	mov r1, r4
	add r0, r0, #0xc00
	mov r3, r2
	bl InitPaletteAnimator
	mov r1, #1
	add r0, r8, #0x208
	add r0, r0, #0xc00
	mov r2, r1
	mov r3, r1
	bl BossHelpers__Palette__Func_2038BAC
	add r0, sp, #0x18
	bl NNS_FndUnmountArchive
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	ldr r4, _02153E20 // =0xFFDF0080
	ldr r2, [sp, #0x14]
	ldr r1, _02153DF4 // =0x00083FE0
	mov r0, #0x128
	add r2, r2, r4
	str r3, [sp, #0x10]
	bl GameObject__SpawnObject
	str r0, [r8, #0x370]
	mov r6, #0
	ldr r4, _02153E24 // =0x00000129
	str r8, [r0, #0x370]
	mov r5, r6
_02153D70:
	ldr r2, [r8, #0x370]
	and r0, r6, #0xff
	str r5, [sp]
	str r5, [sp, #4]
	str r5, [sp, #8]
	str r5, [sp, #0xc]
	str r0, [sp, #0x10]
	ldr r1, [r2, #0x44]
	ldr r2, [r2, #0x48]
	mov r0, r4
	mov r3, r5
	bl GameObject__SpawnObject
	add r1, r8, r6, lsl #2
	add r6, r6, #1
	str r0, [r1, #0x374]
	str r8, [r0, #0x370]
	cmp r6, #2
	blt _02153D70
	bl InitSpatialAudioConfig
	ldr r1, _02153E28 // =renderCoreSwapBuffer
	mov r2, #1
	mov r0, r8
	str r2, [r1, #4]
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02153DD4: .word 0x00000E28
_02153DD8: .word StageTask_Main
_02153DDC: .word ovl02_21566C4
_02153DE0: .word Boss6Stage__Singleton
_02153DE4: .word ovl02_21565D8
_02153DE8: .word ovl02_21567AC
_02153DEC: .word 0x000034CC
_02153DF0: .word ovl02_2156834
_02153DF4: .word 0x00083FE0
_02153DF8: .word 0x001EEF88
_02153DFC: .word _02178CCC
_02153E00: .word 0x02133A18
_02153E04: .word _02179680
_02153E08: .word bossAssetFiles
_02153E0C: .word gameArchiveStage
_02153E10: .word _02179684
_02153E14: .word aZ6TaLinePl
_02153E18: .word _02179504
_02153E1C: .word _021794DC
_02153E20: .word 0xFFDF0080
_02153E24: .word 0x00000129
_02153E28: .word renderCoreSwapBuffer
	arm_func_end Boss6Stage__Create

	arm_func_start Boss6__Create
Boss6__Create: // 0x02153E2C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x74
	mov r3, #0x1500
	mov r7, r0
	mov r5, r1
	mov r4, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r6, _021541BC // =0x00000A8C
	ldr r0, _021541C0 // =StageTask_Main
	ldr r1, _021541C4 // =ovl02_2156EA4
	mov r3, r2
	str r6, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r8, r0
	mov r0, #0
	mov r1, r8
	mov r2, r6
	bl MIi_CpuClear16
	mov r1, r7
	mov r0, r8
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	ldr r1, _021541C8 // =ovl02_2156D34
	ldr r0, _021541CC // =ovl02_2156F2C
	str r1, [r8, #0xf4]
	str r0, [r8, #0xfc]
	ldr r0, _021541D0 // =ovl02_215702C
	mov r1, #0x1000
	str r0, [r8, #0x108]
	ldr r2, [r8, #0x18]
	mov r0, #0
	orr r2, r2, #0x10
	str r2, [r8, #0x18]
	ldr r2, [r8, #0x20]
	orr r2, r2, #0x180
	str r2, [r8, #0x20]
	ldr r2, [r8, #0x1c]
	orr r2, r2, #0x8300
	str r2, [r8, #0x1c]
	str r1, [r8, #0x38]
	str r1, [r8, #0x3c]
	str r1, [r8, #0x40]
	str r5, [r8, #0x44]
	str r4, [r8, #0x48]
	str r0, [r8, #0x4c]
	bl AllocSndHandle
	str r0, [r8, #0xa88]
	mov r1, #0x49
	str r1, [sp]
	add r0, r1, #0xee
	str r0, [sp, #4]
	add r0, r1, #0xc9
	str r0, [sp, #8]
	add r0, r8, #0x3c4
	mov r1, #0x20000
	mov r2, #0x10000
	mov r3, #0xa000
	bl ovl02_2154FE4
	add r0, r8, #0x218
	mov r1, #3
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	add r0, r8, #0x218
	mov r1, #3
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r0, #0x27
	mov r3, #0x69
	str r0, [sp]
	mov r0, #0x4f
	sub r1, r3, #0x90
	stmib sp, {r0, r3}
	mov r2, r1
	add r0, r8, #0x218
	sub r3, r3, #0xc5
	bl ObjRect__SetBox3D
	str r8, [r8, #0x234]
	ldr r0, [r8, #0x230]
	mov r1, #0
	orr r3, r0, #4
	mov r2, r1
	add r0, r8, #0x258
	str r3, [r8, #0x230]
	bl ObjRect__SetAttackStat
	add r0, r8, #0x258
	mov r1, #2
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r0, #0xe
	str r0, [sp]
	mov r0, #0x13
	str r0, [sp, #4]
	mov r0, #0x34
	mov r2, #0
	str r0, [sp, #8]
	sub r1, r0, #0x42
	add r0, r8, #0x258
	sub r3, r2, #0x4f
	bl ObjRect__SetBox3D
	ldr r1, _021541D4 // =ovl02_215708C
	str r8, [r8, #0x274]
	str r1, [r8, #0x27c]
	ldr r1, [r8, #0x270]
	add r0, r8, #0x364
	orr r1, r1, #4
	str r1, [r8, #0x270]
	bl ovl02_2154F7C
	add r4, r8, #0x214
	ldr r0, _021541D8 // =bossAssetFiles
	mov r3, #0
	stmia sp, {r0, r3}
	ldr r2, _021541DC // =_02179680
	mov r0, r8
	add r1, r4, #0x400
	bl ObjAction3dNNModelLoad
	mov r3, #0
	str r3, [r8, #0x12c]
	add r1, r6, #0x2a40
	str r1, [r4, #0x418]
	str r1, [r4, #0x41c]
	str r1, [r4, #0x420]
	mov r0, #4
	strb r0, [r4, #0x40a]
	ldr r1, _021541E0 // =gameArchiveStage
	strb r3, [r4, #0x40b]
	ldr r2, [r1]
	mov r0, r8
	str r2, [sp]
	ldr r2, _021541E4 // =aBoss6Nsbca
	add r1, r4, #0x400
	bl ObjAction3dNNMotionLoad
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r2, [r4, #0x548]
	add r0, r4, #0x400
	mov r3, #3
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, _021541E8 // =BossHelpers__Model__RenderCallback
	mov r5, #3
	add r0, r4, #0x490
	mov r2, #0
	mov r3, #6
	str r5, [sp]
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0x494]
	ldr r1, _021541EC // =aBodyWeak_0
	mov r2, #0x1e
	bl BossHelpers__Model__Init
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0x494]
	ldr r1, _021541F0 // =aBodyMuzzle_0
	mov r2, #0x1d
	bl BossHelpers__Model__Init
	ldr r1, _021541D8 // =bossAssetFiles
	mov r0, #0
	str r1, [sp]
	str r0, [sp, #4]
	ldr r2, _021541DC // =_02179680
	mov r0, r8
	add r1, r8, #0x790
	mov r3, #1
	bl ObjAction3dNNModelLoad
	mov r2, #0
	ldr r1, _021541D8 // =bossAssetFiles
	str r2, [r8, #0x12c]
	stmia sp, {r1, r2}
	add r1, r8, #0x10c
	ldr r2, _021541DC // =_02179680
	mov r0, r8
	add r1, r1, #0x800
	mov r3, #2
	bl ObjAction3dNNModelLoad
	mov r0, #0
	str r0, [r8, #0x12c]
	ldr r2, _021541E0 // =gameArchiveStage
	ldr r1, _021541F4 // =_02179684
	ldr r2, [r2]
	add r0, sp, #0xc
	bl NNS_FndMountArchive
	add r0, r8, #0x94
	ldr r6, _021541F8 // =_02179590
	ldr r4, _021541D8 // =bossAssetFiles
	mov r9, #0
	add r10, r0, #0x400
	add r11, sp, #0xc
	mov r5, #5
_0215413C:
	mov r0, r11
	add r1, r9, #0xa
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
	cmp r9, #0xc
	blt _0215413C
	add r0, r8, #0x94
	mov r2, #0
	mov r3, r2
	add r0, r0, #0x400
	mov r1, #0xc
	bl BossHelpers__Palette__Func_2038BAC
	add r0, sp, #0xc
	bl NNS_FndUnmountArchive
	mov r0, r8
	bl ovl02_215746C
	mov r0, r8
	add sp, sp, #0x74
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021541BC: .word 0x00000A8C
_021541C0: .word StageTask_Main
_021541C4: .word ovl02_2156EA4
_021541C8: .word ovl02_2156D34
_021541CC: .word ovl02_2156F2C
_021541D0: .word ovl02_215702C
_021541D4: .word ovl02_215708C
_021541D8: .word bossAssetFiles
_021541DC: .word _02179680
_021541E0: .word gameArchiveStage
_021541E4: .word aBoss6Nsbca
_021541E8: .word BossHelpers__Model__RenderCallback
_021541EC: .word aBodyWeak_0
_021541F0: .word aBodyMuzzle_0
_021541F4: .word _02179684
_021541F8: .word _02179590
	arm_func_end Boss6__Create

	arm_func_start Boss6Platform__Create
Boss6Platform__Create: // 0x021541FC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r4, #0x1500
	mov r8, r0
	mov r7, r1
	mov r6, r2
	str r4, [sp]
	mov r4, #2
	ldr r0, _0215459C // =StageTask_Main
	ldr r1, _021545A0 // =ovl02_215A338
	mov r2, #0
	mov r5, r3
	mov r3, r2
	str r4, [sp, #4]
	mov r4, #0xa40
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0xa40
	bl MIi_CpuClear16
	mov r1, r8
	mov r0, r4
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	ldr r1, _021545A4 // =ovl02_215A2C4
	ldr r0, _021545A8 // =ovl02_215A3BC
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r0, [r4, #0x18]
	mov r1, #0x1000
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r2, [r4, #0x20]
	mov r0, #0
	orr r2, r2, #0x180
	str r2, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	orr r2, r2, #0x8300
	str r2, [r4, #0x1c]
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	str r7, [r4, #0x44]
	str r6, [r4, #0x48]
	str r0, [r4, #0x4c]
	str r7, [r4, #0x430]
	str r6, [r4, #0x434]
	str r0, [r4, #0x438]
	str r5, [r4, #0x39c]
	bl AllocSndHandle
	str r0, [r4, #0xa3c]
	ldr r1, _021545AC // =0x00000112
	mov r0, #0x49
	str r1, [sp]
	add r1, r1, #0x25
	str r1, [sp, #4]
	str r0, [sp, #8]
	add r0, r4, #0x3a0
	mov r1, #0x4000
	mov r2, r1
	mov r3, #0x2000
	bl ovl02_2154FE4
	str r4, [r4, #0x2d8]
	add r5, r4, #0x2d8
	ldr r1, _021545B0 // =StageTask__DefaultDiffData
	mov r0, #1
	str r1, [r5, #0x24]
	strh r0, [r5, #0x22]
	mov r2, #0x40
	mov r0, #0x18
	strh r2, [r5, #0x30]
	strh r0, [r5, #0x32]
	sub r0, r0, #0x38
	strh r0, [r5, #0x18]
	mov r3, #0
	add r0, r4, #0x218
	mov r1, #2
	strh r3, [r5, #0x1a]
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	mov r1, #3
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	mov r0, #0x1a
	mov r3, #0xd
	str r0, [sp]
	mov r0, #0
	sub r1, r3, #0x27
	stmib sp, {r0, r3}
	mov r2, r1
	add r0, r4, #0x218
	sub r3, r3, #0x1a
	bl ObjRect__SetBox3D
	str r4, [r4, #0x234]
	ldr r1, [r4, #0x230]
	add r0, r4, #0x258
	bic r1, r1, #4
	str r1, [r4, #0x230]
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	add r0, r4, #0x258
	mov r1, #3
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	mov r0, #0x1a
	str r0, [sp]
	str r0, [sp, #4]
	mov r0, #0xd
	mov r2, #0
	str r0, [sp, #8]
	sub r1, r0, #0x27
	add r0, r4, #0x258
	sub r3, r2, #0xd
	bl ObjRect__SetBox3D
	str r4, [r4, #0x274]
	ldr r1, [r4, #0x270]
	add r0, r4, #0x298
	bic r1, r1, #4
	str r1, [r4, #0x270]
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	add r0, r4, #0x298
	mov r1, #3
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	mov r0, #0
	str r0, [sp]
	mov r0, #0x1a
	mov r2, #0xd
	str r0, [sp, #4]
	sub r1, r2, #0x1a
	str r2, [sp, #8]
	add r0, r4, #0x298
	sub r2, r2, #0x27
	mov r3, r1
	bl ObjRect__SetBox3D
	str r4, [r4, #0x2b4]
	ldr r1, [r4, #0x2b0]
	mov r2, #0x1a
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	mov r0, #0xd
	str r2, [sp]
	sub r1, r0, #0x27
	stmib sp, {r0, r2}
	mov r3, r1
	add r0, r4, #0x3f0
	mov r2, #0
	bl ObjRect__SetBox3D
	str r4, [r4, #0x40c]
	ldr r0, [r4, #0x39c]
	ldr r1, [r4, #0x44]
	cmp r0, #0
	add r0, r4, #0x400
	bne _02154490
	add r1, r1, #0x64000
	str r1, [r4, #0x44]
	mov r1, #0
	b _0215449C
_02154490:
	sub r1, r1, #0x64000
	str r1, [r4, #0x44]
	mov r1, #0x8000
_0215449C:
	strh r1, [r0, #0x3c]
	add r0, r4, #0x364
	bl ovl02_2154F7C
	ldr r1, _021545B4 // =bossAssetFiles
	add r5, r4, #0x4c
	str r1, [sp]
	mov r6, #0
	ldr r2, _021545B8 // =_02179680
	mov r0, r4
	add r1, r5, #0x400
	mov r3, #3
	str r6, [sp, #4]
	bl ObjAction3dNNModelLoad
	mov r3, r6
	add r6, r4, #0x1c8
	ldr r0, _021545BC // =0x000034CC
	str r3, [r4, #0x12c]
	str r0, [r5, #0x418]
	str r0, [r5, #0x41c]
	str r0, [r5, #0x420]
	mov r0, #8
	strb r0, [r5, #0x40a]
	ldr r0, _021545B4 // =bossAssetFiles
	strb r3, [r5, #0x40b]
	str r0, [sp]
	str r3, [sp, #4]
	ldr r2, _021545B8 // =_02179680
	mov r0, r4
	add r1, r6, #0x400
	mov r3, #6
	bl ObjAction3dNNModelLoad
	mov r3, #0
	ldr r1, _021545BC // =0x000034CC
	str r3, [r4, #0x12c]
	str r1, [r6, #0x418]
	str r1, [r6, #0x41c]
	mov r0, #8
	str r1, [r6, #0x420]
	strb r0, [r6, #0x40a]
	add r0, r4, #0x344
	add r1, r0, #0x400
	ldr r2, _021545B4 // =bossAssetFiles
	strb r3, [r6, #0x40b]
	stmia sp, {r2, r3}
	ldr r2, _021545B8 // =_02179680
	mov r0, r4
	mov r3, #4
	bl ObjAction3dNNModelLoad
	mov r2, #0
	ldr r1, _021545B4 // =bossAssetFiles
	str r2, [r4, #0x12c]
	stmia sp, {r1, r2}
	ldr r2, _021545B8 // =_02179680
	mov r0, r4
	add r1, r4, #0x8c0
	mov r3, #5
	bl ObjAction3dNNModelLoad
	mov r0, #0
	str r0, [r4, #0x12c]
	mov r0, r4
	bl ovl02_215A550
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215459C: .word StageTask_Main
_021545A0: .word ovl02_215A338
_021545A4: .word ovl02_215A2C4
_021545A8: .word ovl02_215A3BC
_021545AC: .word 0x00000112
_021545B0: .word StageTask__DefaultDiffData
_021545B4: .word bossAssetFiles
_021545B8: .word _02179680
_021545BC: .word 0x000034CC
	arm_func_end Boss6Platform__Create

	arm_func_start Boss6EnemyA__Create
Boss6EnemyA__Create: // 0x021545C0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r4, #0x1500
	mov r8, r0
	str r4, [sp]
	mov r0, #2
	mov r7, r1
	mov r6, r2
	str r0, [sp, #4]
	ldr r4, _021547AC // =0x000004FC
	ldr r0, _021547B0 // =StageTask_Main
	ldr r1, _021547B4 // =GameObject__Destructor
	mov r2, #0
	mov r5, r3
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _021547AC // =0x000004FC
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r1, r8
	mov r0, r4
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	ldr r0, _021547B8 // =ovl02_215B928
	mov r1, #0x1000
	str r0, [r4, #0xf4]
	ldr r2, [r4, #0x18]
	mov r0, #0
	orr r2, r2, #0x10
	str r2, [r4, #0x18]
	ldr r2, [r4, #0x20]
	cmp r5, #0
	orr r2, r2, #0x180
	str r2, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	orr r2, r2, #0x8300
	str r2, [r4, #0x1c]
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	str r1, [r4, #0x40]
	str r7, [r4, #0x44]
	str r6, [r4, #0x48]
	str r0, [r4, #0x4c]
	str r5, [r4, #0x378]
	add r0, r4, #0x218
	mov r1, #2
	mov r2, #0x40
	mov r5, #0x10
	bne _021546D0
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	mov r1, #0
	str r5, [sp]
	sub r2, r1, #0x36
	stmib sp, {r1, r5}
	mov r3, r2
	add r0, r4, #0x218
	sub r1, r1, #0x10
	bl ObjRect__SetBox3D
	b _02154704
_021546D0:
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	mov r1, #3
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	mov r2, #0
	str r5, [sp]
	sub r1, r2, #0x10
	stmib sp, {r2, r5}
	mov r3, r1
	add r0, r4, #0x218
	sub r2, r2, #0x1a
	bl ObjRect__SetBox3D
_02154704:
	ldr r0, _021547BC // =ovl02_2155270
	str r4, [r4, #0x234]
	str r0, [r4, #0x23c]
	ldr r1, [r4, #0x230]
	add r0, r4, #0x364
	orr r1, r1, #4
	str r1, [r4, #0x230]
	bl ovl02_2154F7C
	ldr r0, [r4, #0x378]
	cmp r0, #0
	bne _02154754
	ldr r1, _021547C0 // =0x02133A10
	ldr r2, _021547C4 // =_02179680
	mov r0, r4
	str r1, [sp]
	mov r3, #0
	add r1, r4, #0x380
	str r3, [sp, #4]
	bl ObjAction3dNNModelLoad
	b _02154778
_02154754:
	ldr r1, _021547C8 // =bossAssetFiles
	ldr r2, _021547C4 // =_02179680
	mov r0, r4
	str r1, [sp]
	mov r5, #0
	add r1, r4, #0x380
	mov r3, #8
	str r5, [sp, #4]
	bl ObjAction3dNNModelLoad
_02154778:
	ldr r0, _021547CC // =0x000034CC
	mov r1, #7
	str r0, [r4, #0x398]
	str r0, [r4, #0x39c]
	str r0, [r4, #0x3a0]
	mov r0, r4
	strb r1, [r4, #0x38a]
	mov r1, #0
	strb r1, [r4, #0x38b]
	bl ovl02_215B938
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021547AC: .word 0x000004FC
_021547B0: .word StageTask_Main
_021547B4: .word GameObject__Destructor
_021547B8: .word ovl02_215B928
_021547BC: .word ovl02_2155270
_021547C0: .word 0x02133A10
_021547C4: .word _02179680
_021547C8: .word bossAssetFiles
_021547CC: .word 0x000034CC
	arm_func_end Boss6EnemyA__Create

	arm_func_start Boss6EnemyB__Create
Boss6EnemyB__Create: // 0x021547D0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	ldr r4, _021549D0 // =0x00001501
	mov r8, r0
	mov r7, r1
	mov r6, r2
	str r4, [sp]
	mov r0, #2
	ldr r4, _021549D4 // =0x0000086C
	str r0, [sp, #4]
	ldr r0, _021549D8 // =StageTask_Main
	ldr r1, _021549DC // =ovl02_215BB18
	mov r2, #0
	mov r5, r3
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	ldr r2, _021549D4 // =0x0000086C
	bl MIi_CpuClear16
	mov r1, r8
	mov r0, r4
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	ldr r1, _021549E0 // =ovl02_215BA88
	ldr r0, _021549E4 // =ovl02_215BB70
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r0, [r4, #0x18]
	mov r2, #0x1000
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	mov r1, #0
	orr r0, r0, #0x180
	str r0, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	add r0, r4, #0x39c
	orr r3, r3, #0x8300
	str r3, [r4, #0x1c]
	str r2, [r4, #0x38]
	str r2, [r4, #0x3c]
	str r2, [r4, #0x40]
	str r7, [r4, #0x44]
	str r6, [r4, #0x48]
	str r1, [r4, #0x4c]
	str r5, [r4, #0x394]
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	mov r2, #0x4000
	mov r3, r1
	bl ovl02_2154FE4
	mov r1, #0x8000
	add r0, r4, #0x300
	strh r1, [r0, #0xe6]
	add r0, r4, #0x218
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	mov r0, #0x10
	str r0, [sp]
	mov r3, #0x1a
	str r3, [sp, #4]
	str r0, [sp, #8]
	add r0, r4, #0x218
	sub r1, r3, #0x2a
	sub r2, r3, #0x34
	sub r3, r3, #0x4e
	bl ObjRect__SetBox3D
	ldr r0, _021549E8 // =ovl02_2155270
	str r4, [r4, #0x234]
	str r0, [r4, #0x23c]
	ldr r1, [r4, #0x230]
	add r0, r4, #0x364
	orr r1, r1, #4
	str r1, [r4, #0x230]
	bl ovl02_2154F7C
	ldr r1, _021549EC // =0x02133A10
	ldr r2, _021549F0 // =_02179680
	str r1, [sp]
	mov r5, #0
	mov r0, r4
	add r1, r4, #0x3f8
	mov r3, #1
	str r5, [sp, #4]
	bl ObjAction3dNNModelLoad
	add r1, r4, #0x174
	ldr r0, _021549F4 // =0x000034CC
	str r5, [r4, #0x12c]
	str r0, [r4, #0x410]
	str r0, [r4, #0x414]
	str r0, [r4, #0x418]
	mov r0, #8
	strb r0, [r4, #0x402]
	ldr r0, _021549EC // =0x02133A10
	strb r5, [r4, #0x403]
	str r0, [sp]
	ldr r2, _021549F0 // =_02179680
	mov r0, r4
	add r1, r1, #0x400
	mov r3, #2
	str r5, [sp, #4]
	bl ObjAction3dNNModelLoad
	mov r2, r5
	ldr r1, _021549EC // =0x02133A10
	str r2, [r4, #0x12c]
	stmia sp, {r1, r2}
	ldr r2, _021549F0 // =_02179680
	mov r0, r4
	add r1, r4, #0x6f0
	mov r3, #3
	bl ObjAction3dNNModelLoad
	mov r0, r5
	str r0, [r4, #0x12c]
	mov r0, r4
	bl ovl02_215BBA0
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021549D0: .word 0x00001501
_021549D4: .word 0x0000086C
_021549D8: .word StageTask_Main
_021549DC: .word ovl02_215BB18
_021549E0: .word ovl02_215BA88
_021549E4: .word ovl02_215BB70
_021549E8: .word ovl02_2155270
_021549EC: .word 0x02133A10
_021549F0: .word _02179680
_021549F4: .word 0x000034CC
	arm_func_end Boss6EnemyB__Create

	arm_func_start Boss6Missile__Create
Boss6Missile__Create: // 0x021549F8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r7, r0
	mov r5, r1
	mov r4, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r6, _02154B94 // =0x00000524
	ldr r0, _02154B98 // =StageTask_Main
	ldr r1, _02154B9C // =GameObject__Destructor
	mov r3, r2
	str r6, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r8, r0
	mov r0, #0
	mov r1, r8
	mov r2, r6
	bl MIi_CpuClear16
	mov r1, r7
	mov r0, r8
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	ldr r1, _02154BA0 // =ovl02_215C32C
	ldr r0, _02154BA4 // =ovl02_215C350
	str r1, [r8, #0xf4]
	str r0, [r8, #0x108]
	ldr r1, [r8, #0x18]
	mov r0, #0x1000
	orr r1, r1, #0x10
	str r1, [r8, #0x18]
	ldr r1, [r8, #0x20]
	mov r9, #0
	orr r1, r1, #0x180
	str r1, [r8, #0x20]
	ldr r1, [r8, #0x1c]
	ldr r11, _02154BA8 // =ovl02_215C3DC
	orr r1, r1, #0x8300
	str r1, [r8, #0x1c]
	str r0, [r8, #0x38]
	str r0, [r8, #0x3c]
	str r0, [r8, #0x40]
	str r5, [r8, #0x44]
	str r4, [r8, #0x48]
	mvn r5, #4
	add r10, r8, #0x218
	str r9, [r8, #0x4c]
	sub r4, r5, #1
	mov r7, #5
	mov r6, #6
_02154AD0:
	mov r0, r10
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r10
	mov r1, #3
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	str r7, [sp]
	str r7, [sp, #4]
	str r6, [sp, #8]
	mov r0, r10
	mov r1, r5
	mov r2, r5
	mov r3, r4
	bl ObjRect__SetBox3D
	str r8, [r10, #0x1c]
	str r11, [r10, #0x20]
	ldr r0, [r10, #0x18]
	add r9, r9, #1
	orr r0, r0, #4
	str r0, [r10, #0x18]
	cmp r9, #3
	add r10, r10, #0x40
	blt _02154AD0
	add r0, r8, #0x364
	bl ovl02_2154F7C
	ldr r1, _02154BAC // =bossAssetFiles
	ldr r2, _02154BB0 // =_02179680
	str r1, [sp]
	mov r4, #0
	mov r0, r8
	add r1, r8, #0x3a8
	mov r3, #7
	str r4, [sp, #4]
	bl ObjAction3dNNModelLoad
	ldr r0, _02154BB4 // =0x00001A66
	mov r1, #7
	str r0, [r8, #0x3c0]
	str r0, [r8, #0x3c4]
	str r0, [r8, #0x3c8]
	strb r1, [r8, #0x3b2]
	mov r1, r4
	mov r0, r8
	strb r1, [r8, #0x3b3]
	bl ovl02_215C494
	mov r0, r8
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02154B94: .word 0x00000524
_02154B98: .word StageTask_Main
_02154B9C: .word GameObject__Destructor
_02154BA0: .word ovl02_215C32C
_02154BA4: .word ovl02_215C350
_02154BA8: .word ovl02_215C3DC
_02154BAC: .word bossAssetFiles
_02154BB0: .word _02179680
_02154BB4: .word 0x00001A66
	arm_func_end Boss6Missile__Create

	arm_func_start Boss6Ring__Create
Boss6Ring__Create: // 0x02154BB8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _02154D24 // =0x00000474
	ldr r0, _02154D28 // =StageTask_Main
	ldr r1, _02154D2C // =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02154D24 // =0x00000474
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r1, r7
	mov r0, r4
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, _02154D30 // =ovl02_215C810
	ldr r0, _02154D34 // =ovl02_215C834
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r0, [r4, #0x18]
	mov r2, #0x1000
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x20]
	mov r1, #0
	orr r0, r0, #0x180
	str r0, [r4, #0x20]
	ldr r3, [r4, #0x1c]
	add r0, r4, #0x218
	orr r3, r3, #0x8300
	str r3, [r4, #0x1c]
	str r2, [r4, #0x38]
	str r2, [r4, #0x3c]
	str r2, [r4, #0x40]
	str r6, [r4, #0x44]
	str r5, [r4, #0x48]
	mov r2, r1
	str r1, [r4, #0x4c]
	bl ObjRect__SetAttackStat
	mov r1, #0
	add r0, r4, #0x218
	mov r2, r1
	bl ObjRect__SetDefenceStat
	mov r3, #0
	mov r0, #0xc
	str r0, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	add r0, r4, #0x218
	sub r1, r3, #0xc
	sub r2, r3, #0x12
	sub r3, r3, #4
	bl ObjRect__SetBox3D
	ldr r0, _02154D38 // =ovl02_215C8AC
	str r4, [r4, #0x234]
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	add r6, r4, #0x370
	orr r0, r0, #4
	str r0, [r4, #0x230]
	ldr r0, _02154D3C // =ringManagerWork
	mov r5, #0x10
	ldr r1, [r0]
	add r1, r1, #0x15c
	str r1, [r4, #0x36c]
	ldr r0, [r0]
	add ip, r0, #0x260
_02154CF4:
	ldmia ip!, {r0, r1, r2, r3}
	stmia r6!, {r0, r1, r2, r3}
	subs r5, r5, #1
	bne _02154CF4
	ldr r1, [ip]
	add r0, r4, #0x400
	str r1, [r6]
	ldrh r1, [r0, #0xc]
	bl AnimatorSprite__SetAnimation
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02154D24: .word 0x00000474
_02154D28: .word StageTask_Main
_02154D2C: .word GameObject__Destructor
_02154D30: .word ovl02_215C810
_02154D34: .word ovl02_215C834
_02154D38: .word ovl02_215C8AC
_02154D3C: .word ringManagerWork
	arm_func_end Boss6Ring__Create

	arm_func_start Boss6Stage__GetScrollSpeed
Boss6Stage__GetScrollSpeed: // 0x02154D40
	stmdb sp!, {r3, lr}
	ldr r0, _02154D58 // =Boss6Stage__Singleton
	ldr r0, [r0]
	bl GetTaskWork_
	ldr r0, [r0, #0x3a4]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02154D58: .word Boss6Stage__Singleton
	arm_func_end Boss6Stage__GetScrollSpeed

	arm_func_start ovl02_2154D5C
ovl02_2154D5C: // 0x02154D5C
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	ldr r1, _02154D9C // =Boss6Stage__Singleton
	mov r5, r0
	ldr r0, [r1]
	bl GetTaskWork_
	ldr r1, [r5, #0x20]
	mov r4, r0
	tst r1, #0x20
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0xd50]
	blx r0
	mov r0, r5
	mov r1, r4
	bl ovl02_2154DA0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02154D9C: .word Boss6Stage__Singleton
	arm_func_end ovl02_2154D5C

	arm_func_start ovl02_2154DA0
ovl02_2154DA0: // 0x02154DA0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r2, _02154EB0 // =Boss6Stage__Singleton
	mov r6, r0
	ldr r0, [r2]
	mov r5, r1
	bl GetTaskWork_
	ldr r1, [r0, #0x38c]
	ldr r0, [r6, #0x48]
	rsb r1, r1, #0
	subs r4, r1, r0
	ldr r1, [r5, #0x370]
	mov r0, r6
	add r1, r1, #0x258
	movmi r4, #0
	bl ovl02_2154EB4
	cmp r0, #0
	ble _02154DF0
	cmp r0, r4
	movlt r4, r0
_02154DF0:
	ldr r1, [r5, #0x374]
	mov r0, r6
	add r1, r1, #0x3f0
	bl ovl02_2154EB4
	cmp r0, #0
	ble _02154E10
	cmp r0, r4
	movlt r4, r0
_02154E10:
	ldr r1, [r5, #0x378]
	mov r0, r6
	add r1, r1, #0x3f0
	bl ovl02_2154EB4
	cmp r0, #0
	ble _02154E30
	cmp r0, r4
	movlt r4, r0
_02154E30:
	mov r2, #0xc
	mov r0, #0
	str r2, [sp]
	mov r1, #3
	mov r2, r1
	mov r3, r0
	str r0, [sp, #4]
	bl NNS_G3dGlbPolygonAttr
	add r0, r5, #0x258
	add ip, r0, #0x800
	add r0, r6, #0x44
	add r3, ip, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [ip, #0x4c]
	mov r0, ip
	rsb r2, r1, #0
	str r2, [ip, #0x4c]
	ldrsh r1, [r6, #0xf2]
	sub r1, r2, r1, lsl #12
	str r1, [ip, #0x4c]
	str r4, [ip, #0x1c]
	bl AnimatorMDL__Draw
	add r4, r5, #0x3d4
	ldr r0, [r4, #0x894]
	mov r1, #0
	mov r2, #0x1f0000
	bl NNSi_G3dModifyPolygonAttrMask
	add r0, r4, #0x800
	bl AnimatorMDL__Draw
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02154EB0: .word Boss6Stage__Singleton
	arm_func_end ovl02_2154DA0

	arm_func_start ovl02_2154EB4
ovl02_2154EB4: // 0x02154EB4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r2, [r1, #0x1c]
	ldrsh r3, [r1]
	ldr lr, [r1, #0xc]
	ldrsh r5, [r1, #6]
	ldrsh r7, [r0, #0xf0]
	ldrsh r6, [r0, #0xec]
	add r4, lr, r3
	ldr ip, [r2, #0x44]
	add r5, lr, r5
	add r4, ip, r4, lsl #12
	sub r3, r7, r6
	add ip, ip, r5, lsl #12
	ldr r5, [r0, #0x44]
	sub r4, r4, r3, lsl #12
	cmp r4, r5
	add r4, ip, r3, lsl #12
	cmple r5, r4
	mvngt r0, #0
	ldmgtia sp!, {r3, r4, r5, r6, r7, pc}
	ldrsh ip, [r1, #4]
	ldr r5, [r1, #0x14]
	ldrsh lr, [r1, #0xa]
	ldr r4, [r2, #0x4c]
	add ip, r5, ip
	add ip, r4, ip, lsl #12
	add lr, r5, lr
	add r4, r4, lr, lsl #12
	sub ip, ip, r3, lsl #12
	ldr lr, [r0, #0x4c]
	add r3, r4, r3, lsl #12
	cmp ip, lr
	cmple lr, r3
	mvngt r0, #0
	ldmgtia sp!, {r3, r4, r5, r6, r7, pc}
	ldrsh r3, [r1, #8]
	ldr lr, [r1, #0x10]
	ldrsh r1, [r1, #2]
	add r3, lr, r3
	ldr ip, [r2, #0x48]
	mov r2, r3, lsl #0xc
	add r2, r2, ip, lsl #1
	add r1, lr, r1
	add r1, r2, r1, lsl #12
	ldr r0, [r0, #0x48]
	mov r2, r1, asr #1
	cmp r0, r1, asr #1
	mvnge r0, #0
	sublt r0, r2, r0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end ovl02_2154EB4

	arm_func_start ovl02_2154F7C
ovl02_2154F7C: // 0x02154F7C
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x68
	ldr r1, _02154FDC // =gameArchiveStage
	mov r4, r0
	ldr r2, [r1]
	ldr r1, _02154FE0 // =_02179684
	add r0, sp, #0
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #7
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4]
	add r0, sp, #0
	mov r1, #8
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #4]
	add r0, sp, #0
	mov r1, #9
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #8]
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	add sp, sp, #0x68
	ldmia sp!, {r4, pc}
	.align 2, 0
_02154FDC: .word gameArchiveStage
_02154FE0: .word _02179684
	arm_func_end ovl02_2154F7C

	arm_func_start ovl02_2154FE4
ovl02_2154FE4: // 0x02154FE4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	mov r7, r1
	mov r6, r2
	mov r1, r4
	mov r0, #0
	mov r2, #0x50
	mov r5, r3
	bl MIi_CpuClear16
	mov r0, #0x1000
	str r0, [r4, #0x44]
	cmp r7, #0
	rsblt r7, r7, #0
	cmp r6, #0
	rsblt r6, r6, #0
	str r7, [r4, #0x24]
	cmp r5, #0
	ldrh r0, [sp, #0x18]
	str r6, [r4, #0x28]
	rsblt r5, r5, #0
	str r5, [r4, #0x2c]
	strh r0, [r4, #0x30]
	strh r0, [r4, #0x36]
	strh r0, [r4, #0x3c]
	ldrh r1, [sp, #0x1c]
	ldrh r0, [sp, #0x20]
	ldr r3, _021550C0 // =_mt_math_rand
	strh r1, [r4, #0x32]
	strh r1, [r4, #0x38]
	strh r1, [r4, #0x3e]
	strh r0, [r4, #0x34]
	strh r0, [r4, #0x3a]
	strh r0, [r4, #0x40]
	ldr ip, [r3]
	ldr r1, _021550C4 // =0x00196225
	ldr r2, _021550C8 // =0x3C6EF35F
	mov r0, r4
	mla lr, ip, r1, r2
	str lr, [r3]
	mov ip, lr, lsr #0x10
	strh ip, [r4, #0x48]
	ldr ip, [r3]
	mla lr, ip, r1, r2
	str lr, [r3]
	mov ip, lr, lsr #0x10
	strh ip, [r4, #0x4a]
	ldr ip, [r3]
	mla r1, ip, r1, r2
	str r1, [r3]
	mov r1, r1, lsr #0x10
	strh r1, [r4, #0x4c]
	bl ovl02_21550CC
	mov r0, r4
	bl ovl02_21550CC
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021550C0: .word _mt_math_rand
_021550C4: .word 0x00196225
_021550C8: .word 0x3C6EF35F
	arm_func_end ovl02_2154FE4

	arm_func_start ovl02_21550CC
ovl02_21550CC: // 0x021550CC
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	add r3, r5, #0xc
	ldmia r5, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r4, #0
_021550E4:
	add r3, r5, r4, lsl #1
	ldrh r1, [r3, #0x36]
	ldrh r0, [r3, #0x3c]
	ldrh r2, [r3, #0x48]
	add r0, r1, r0
	mov r0, r0, asr #1
	strh r0, [r3, #0x36]
	ldrh r1, [r3, #0x48]
	ldrh r0, [r3, #0x36]
	add r0, r1, r0
	strh r0, [r3, #0x48]
	ldrh r0, [r3, #0x48]
	cmp r2, r0
	bhs _0215512C
	ldrh r0, [r3, #0x30]
	bl ovl02_2155220
	add r1, r5, r4, lsl #1
	strh r0, [r1, #0x3c]
_0215512C:
	add r4, r4, #1
	cmp r4, #3
	blt _021550E4
	ldrh r0, [r5, #0x48]
	ldr ip, _0215521C // =FX_SinCosTable_
	ldr r2, [r5, #0x24]
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r1, [ip, r0]
	ldr r4, [r5, #0x44]
	mov r0, r5
	smull r3, r1, r2, r1
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	smull r2, r1, r4, r2
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r5]
	ldrh r1, [r5, #0x4a]
	ldr lr, [r5, #0x28]
	ldr r3, [r5, #0x44]
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r4, [ip, r1]
	add r1, r5, #0xc
	add r2, r5, #0x18
	smull r6, r4, lr, r4
	adds r6, r6, #0x800
	adc r4, r4, #0
	mov r6, r6, lsr #0xc
	orr r6, r6, r4, lsl #20
	smull r6, r4, r3, r6
	adds r6, r6, #0x800
	adc r3, r4, #0
	mov r4, r6, lsr #0xc
	orr r4, r4, r3, lsl #20
	str r4, [r5, #4]
	ldrh r4, [r5, #0x4c]
	ldr lr, [r5, #0x2c]
	ldr r3, [r5, #0x44]
	mov r4, r4, asr #4
	mov r4, r4, lsl #2
	ldrsh r4, [ip, r4]
	smull ip, r4, lr, r4
	adds ip, ip, #0x800
	adc r4, r4, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r4, lsl #20
	smull ip, r4, r3, ip
	adds ip, ip, #0x800
	adc r3, r4, #0
	mov r4, ip, lsr #0xc
	orr r4, r4, r3, lsl #20
	str r4, [r5, #8]
	bl VEC_Subtract
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215521C: .word FX_SinCosTable_
	arm_func_end ovl02_21550CC

	arm_func_start ovl02_2155220
ovl02_2155220: // 0x02155220
	stmdb sp!, {r3, lr}
	ldr ip, _02155260 // =_mt_math_rand
	ldr r1, _02155264 // =0x00196225
	ldr lr, [ip]
	ldr r2, _02155268 // =0x3C6EF35F
	ldr r3, _0215526C // =0x000007FF
	mla r2, lr, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	and r1, r3, r1, lsr #16
	add r1, r1, #0xc00
	mul r0, r1, r0
	mov r0, r0, lsl #4
	str r2, [ip]
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155260: .word _mt_math_rand
_02155264: .word 0x00196225
_02155268: .word 0x3C6EF35F
_0215526C: .word 0x000007FF
	arm_func_end ovl02_2155220

	arm_func_start ovl02_2155270
ovl02_2155270: // 0x02155270
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r0, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r1, [r0]
	cmp r1, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	ldr r2, [r4, #0x230]
	mov r1, #0
	orr r2, r2, #0x800
	str r2, [r4, #0x230]
	sub r2, r1, #0xe000
	bl Player__Action_Spring
	ldr r1, [r4, #0x18]
	mov r0, #0
	orr r1, r1, #8
	str r1, [r4, #0x18]
	ldr r2, [r4, #0x48]
	ldr r1, [r4, #0x44]
	ldr r3, [r4, #0x4c]
	rsb r2, r2, #0x20000
	bl BossFX__CreateBomb
	mov ip, #0x99
	sub r1, ip, #0x9a
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2155270

	arm_func_start ovl02_21552F0
ovl02_21552F0: // 0x021552F0
	ldr r1, _02155328 // =gPlayer
	mov r2, #0
	ldr r1, [r1]
	ldr r3, [r1, #0x114]
_02155300:
	add r1, r0, r2, lsl #2
	ldr r1, [r1, #0x374]
	cmp r3, r1
	moveq r0, r1
	bxeq lr
	add r2, r2, #1
	cmp r2, #2
	blt _02155300
	mov r0, #0
	bx lr
	.align 2, 0
_02155328: .word gPlayer
	arm_func_end ovl02_21552F0

	arm_func_start ovl02_215532C
ovl02_215532C: // 0x0215532C
	ldr r2, [r0, #0x470]
	rsb r2, r2, #0
	str r2, [r1]
	ldr r2, [r0, #0x474]
	rsb r2, r2, #0
	str r2, [r1, #4]
	ldr r0, [r0, #0x478]
	rsb r0, r0, #0
	str r0, [r1, #8]
	bx lr
	arm_func_end ovl02_215532C

	arm_func_start ovl02_2155354
ovl02_2155354: // 0x02155354
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r1
	add r1, sp, #0
	mov r6, r0
	mov r4, r2
	bl ovl02_215532C
	add r2, r6, #0x88
	add r1, sp, #0
	mov r0, r5
	mov r3, r4
	add r2, r2, #0x400
	bl VEC_MultAdd
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	arm_func_end ovl02_2155354

	arm_func_start ovl02_2155390
ovl02_2155390: // 0x02155390
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	ldr r4, _02155530 // =Boss6Stage__Singleton
	mov r10, r0
	ldr r0, [r4]
	mov r4, r3
	str r1, [sp, #8]
	str r2, [sp, #0xc]
	bl GetTaskWork_
	ldr r1, [r0, #0x38c]
	ldr r0, [r10, #0x48]
	rsb r1, r1, #0
	sub r5, r1, r0
	cmp r5, #0
	addle sp, sp, #0x10
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r5, #0xb2000
	addgt sp, sp, #0x10
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, _02155534 // =0x00001199
	mov r1, #0
	umull r3, r2, r5, r0
	mla r2, r5, r1, r2
	mov r1, r5, asr #0x1f
	adds r3, r3, #0x800
	mla r2, r1, r0, r2
	adc r0, r2, #0
	mov r7, r3, lsr #0xc
	cmp r5, #0x30000
	orr r7, r7, r0, lsl #20
	movlt r5, #0x30000
	blt _02155418
	cmp r5, #0xb2000
	movgt r5, #0xb2000
_02155418:
	sub r0, r5, #0x30000
	mov r1, #0x82000
	bl FX_Div
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	ldr r1, _02155538 // =0xFFFFF029
	mov r2, #0x800
	umull r9, r5, r0, r1
	mvn r3, #0
	sub r2, r2, #0xf800
	umull r8, r6, r0, r2
	adds r9, r9, #0x800
	mla r5, r0, r3, r5
	mov r11, r0, asr #0x1f
	mla r6, r0, r3, r6
	mov r0, #0
	mla r5, r11, r1, r5
	mla r6, r11, r2, r6
	adc r1, r5, r0
	mov r9, r9, lsr #0xc
	orr r9, r9, r1, lsl #20
	add r1, r9, #0xcc
	adds r2, r8, #0x800
	add r5, r1, #0x3400
	adc r1, r6, r0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, r2, #0x10000
	mov r1, r1, asr #0xc
	str r1, [sp]
	mov r1, #3
	mov r2, r1
	mov r3, r0
	str r0, [sp, #4]
	bl NNS_G3dGlbPolygonAttr
	rsb r8, r4, #0
	mov r6, #0
	add r4, sp, #8
	mov r11, #0xc
_021554B4:
	cmp r6, #0
	ldr r9, [r4, r6, lsl #2]
	bne _021554F8
	strb r11, [r9, #0xa]
	mov r0, #0x16
	strb r0, [r9, #0xb]
	mov r0, #0x13
	strb r0, [r9, #0xc]
	mov r0, #0x14
	strb r0, [r9, #0xd]
	mov r0, #0
	strb r0, [r9, #0xe]
	str r7, [r9, #0x1c]
	str r5, [r9, #0x18]
	str r5, [r9, #0x20]
	str r8, [r9, #0x58]
	b _02155510
_021554F8:
	mov r1, #0
	mov r0, r1
	strb r0, [r9, #0xa]
	ldr r0, [r9, #0x94]
	mov r2, #0x1f0000
	bl NNSi_G3dModifyPolygonAttrMask
_02155510:
	mov r1, r9
	mov r0, r10
	bl StageTask__Draw3D
	add r6, r6, #1
	cmp r6, #2
	blt _021554B4
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02155530: .word Boss6Stage__Singleton
_02155534: .word 0x00001199
_02155538: .word 0xFFFFF029
	arm_func_end ovl02_2155390

	arm_func_start ovl02_215553C
ovl02_215553C: // 0x0215553C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x14]
	cmp r1, #0
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
	bl BossHelpers__Unknown2038AEC__Func_2038B7C
	ldr r2, [r4, #0x14]
	mov r1, #0x320000
	ldr r2, [r2, #0x4c]
	ldr r0, [r0, #8]
	rsb r1, r1, #0
	sub r0, r2, r0
	cmp r0, r1
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_215553C

	arm_func_start ovl02_2155580
ovl02_2155580: // 0x02155580
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mov r6, r0
	mov r0, r5
	bl BossHelpers__Unknown2038AEC__Func_2038B7C
	mov r4, r0
	ldr r1, [r4, #4]
	mov r0, r6
	mov r2, #0x10000
	bl ovl02_215C7BC
	ldr r1, [r5, #0x14]
	cmp r1, #0
	beq _021555C4
	ldr r2, [r1, #0x4c]
	ldr r1, [r4, #8]
	sub r1, r2, r1
	str r1, [r0, #0x4c]
_021555C4:
	str r0, [r5, #0x14]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl02_2155580

	arm_func_start ovl02_21555CC
ovl02_21555CC: // 0x021555CC
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r1
	ldr r1, [r4, #0x14]
	mov r5, r0
	cmp r1, #0
	beq _021555F4
	ldr r0, [r1, #0x18]
	tst r0, #8
	movne r0, #0
	strne r0, [r4, #0x14]
_021555F4:
	ldr r0, [r4, #0x18]
	cmp r0, #0
	mov r0, r4
	beq _02155628
	bl ovl02_215553C
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	mov r1, r4
	bl ovl02_2155580
	mov r0, #0
	str r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_02155628:
	bl BossHelpers__Unknown2038AEC__Func_2038B28
	cmp r0, #1
	beq _02155644
	cmp r0, #2
	moveq r0, #0
	streq r0, [r4, #0x14]
	ldmia sp!, {r3, r4, r5, pc}
_02155644:
	mov r0, r4
	bl ovl02_215553C
	cmp r0, #0
	moveq r0, #1
	streq r0, [r4, #0x18]
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	mov r1, r4
	bl ovl02_2155580
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_21555CC

	arm_func_start ovl02_215566C
ovl02_215566C: // 0x0215566C
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r1
	mov r5, r0
	bl ovl02_2155A04
	ldr r1, [r4]
	cmp r1, #0
	beq _021556A0
	ldrh r1, [r4, #4]
	cmp r1, #4
	bhs _021556A0
	ldrh r1, [r4, #6]
	cmp r0, r1
	beq _021556FC
_021556A0:
	ldr r3, _02155734 // =_mt_math_rand
	ldr r1, _02155738 // =0x00196225
	ldr lr, [r3]
	ldr r2, _0215573C // =0x3C6EF35F
	mov ip, #0
	mla r1, lr, r1, r2
	str r1, [r3]
	strh ip, [r4, #4]
	strh r0, [r4, #6]
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	ldrh r1, [r4, #6]
	ldr r0, _02155740 // =_021794EC
	and r2, r2, #3
	ldr r3, [r0, r1, lsl #2]
	ldr r1, [r4]
	ldr r0, [r3, r2, lsl #2]
	cmp r1, r0
	addeq r0, r2, #1
	andeq r2, r0, #3
	ldr r0, [r3, r2, lsl #2]
	str r0, [r4]
_021556FC:
	ldrh r1, [r4, #4]
	add r0, r1, #1
	strh r0, [r4, #4]
	ldr r0, [r4]
	ldr r4, [r0, r1, lsl #2]
	sub r0, r4, #3
	cmp r0, #1
	bhi _0215572C
	mov r0, r5
	bl ovl02_2155744
	cmp r0, #0
	movne r4, #0
_0215572C:
	mov r0, r4
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02155734: .word _mt_math_rand
_02155738: .word 0x00196225
_0215573C: .word 0x3C6EF35F
_02155740: .word _021794EC
	arm_func_end ovl02_215566C

	arm_func_start ovl02_2155744
ovl02_2155744: // 0x02155744
	mov r2, #0
_02155748:
	add r1, r0, r2, lsl #2
	ldr r1, [r1, #0x374]
	ldr r1, [r1, #0x398]
	cmp r1, #3
	cmpne r1, #4
	bne _02155768
	mov r0, #1
	bx lr
_02155768:
	add r2, r2, #1
	cmp r2, #2
	blt _02155748
	mov r0, #0
	bx lr
	arm_func_end ovl02_2155744

	arm_func_start ovl02_215577C
ovl02_215577C: // 0x0215577C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl ovl02_2155BBC
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrh r0, [r5]
	cmp r0, #0
	bne _021557F0
	mov r4, #0
_021557A4:
	add r0, r6, r4, lsl #2
	ldr r0, [r0, #0x374]
	ldr r1, [r0, #0x398]
	cmp r1, #0
	cmpne r1, #1
	beq _021557C8
	cmp r1, #2
	beq _021557D0
	b _021557D4
_021557C8:
	bl ovl02_215A5B8
	b _021557D4
_021557D0:
	bl ovl02_215A598
_021557D4:
	add r4, r4, #1
	cmp r4, #2
	blt _021557A4
	mov r0, r6
	bl ovl02_2155C00
	strh r0, [r5]
	ldmia sp!, {r4, r5, r6, pc}
_021557F0:
	sub r0, r0, #1
	strh r0, [r5]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl02_215577C

	arm_func_start ovl02_21557FC
ovl02_21557FC: // 0x021557FC
	stmdb sp!, {r3, lr}
	ldr r1, _0215581C // =gPlayer
	ldr r1, [r1]
	ldr r1, [r1, #0x48]
	cmp r1, #0x230000
	ldmleia sp!, {r3, pc}
	bl ovl02_2155820
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215581C: .word gPlayer
	arm_func_end ovl02_21557FC

	arm_func_start ovl02_2155820
ovl02_2155820: // 0x02155820
	add r0, r0, #0x300
	mov r1, #0
	strh r1, [r0, #0x82]
	bx lr
	arm_func_end ovl02_2155820

	arm_func_start ovl02_2155830
ovl02_2155830: // 0x02155830
	add r0, r0, #0x300
	ldrh r1, [r0, #0x82]
	add r1, r1, #1
	strh r1, [r0, #0x82]
	ldrh r0, [r0, #0x82]
	bx lr
	arm_func_end ovl02_2155830

	arm_func_start ovl02_2155848
ovl02_2155848: // 0x02155848
	add r0, r0, #0x300
	ldrh r0, [r0, #0x82]
	bx lr
	arm_func_end ovl02_2155848

	arm_func_start ovl02_2155854
ovl02_2155854: // 0x02155854
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl02_2155848
	mov r0, r4
	bl ovl02_2155848
	cmp r0, #5
	movhi r0, #5
	ldmhiia sp!, {r4, pc}
	mov r0, r4
	bl ovl02_2155848
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2155854

	arm_func_start ovl02_2155880
ovl02_2155880: // 0x02155880
	stmdb sp!, {r4, lr}
	ldr r1, _021558D4 // =gPlayer
	mov r4, r0
	ldr r1, [r1]
	ldr r1, [r1, #0x48]
	cmp r1, #0x320000
	ble _021558AC
	mov r0, #0
	str r0, [r4, #0xa30]
	str r0, [r4, #0xa34]
	ldmia sp!, {r4, pc}
_021558AC:
	ldr r1, [r4, #0xa34]
	cmp r1, #0
	bne _021558C8
	bl ovl02_21552F0
	cmp r0, #0
	movne r0, #1
	strne r0, [r4, #0xa34]
_021558C8:
	ldr r0, [r4, #0xa34]
	str r0, [r4, #0xa30]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021558D4: .word gPlayer
	arm_func_end ovl02_2155880

	arm_func_start ovl02_21558D8
ovl02_21558D8: // 0x021558D8
	mov r1, #1
	str r1, [r0, #0xa34]
	str r1, [r0, #0xa30]
	bx lr
	arm_func_end ovl02_21558D8

	arm_func_start ovl02_21558E8
ovl02_21558E8: // 0x021558E8
	ldr r0, [r0, #0xa30]
	bx lr
	arm_func_end ovl02_21558E8

	arm_func_start ovl02_21558F0
ovl02_21558F0: // 0x021558F0
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, _021559F0 // =gPlayer
	ldr r1, _021559F4 // =0x0030F000
	ldr r4, [r2]
	ldr r0, [r4, #0x48]
	cmp r0, r1
	ble _0215591C
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x80000
	str r0, [r4, #0x1c]
	ldmia sp!, {r3, r4, r5, pc}
_0215591C:
	ldr r3, [r4, #0x1c]
	sub r0, r1, #0xbc000
	bic r3, r3, #0x80000
	str r3, [r4, #0x1c]
	ldr r2, [r2]
	ldr r2, [r2, #0x48]
	cmp r2, r0
	ldrlt r4, _021559F8 // =0x0020FF80
	blt _02155988
	rsb r0, r1, #0xbc000
	add r0, r2, r0
	mov r1, #0xbc000
	bl FX_Div
	mov r0, r0, lsl #0x10
	mov r4, r0, asr #0x10
	ldr r0, _021559FC // =0xFFEF8040
	mvn r1, #0
	umull r3, r2, r4, r0
	adds r3, r3, #0x800
	mla r2, r4, r1, r2
	mov r1, r4, asr #0x1f
	mla r2, r1, r0, r2
	adc r0, r2, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x3f80
	add r4, r0, #0x20c000
_02155988:
	ldr r1, _021559F0 // =gPlayer
	ldr r0, _02155A00 // =0x00083FE0
	ldr lr, [r1]
	mov r1, r4, asr #1
	ldrsh r3, [lr, #0xec]
	ldr ip, [lr, #0x44]
	ldrsh r2, [lr, #0xf0]
	add r1, r1, #0xfe0
	sub r5, r0, r4, asr #1
	add r3, ip, r3, lsl #12
	cmp r3, r5
	add r4, r1, #0x83000
	add r0, ip, r2, lsl #12
	bge _021559D4
	ldr r1, [lr, #0xb0]
	sub r0, r5, r3
	add r0, r1, r0
	str r0, [lr, #0xb0]
	ldmia sp!, {r3, r4, r5, pc}
_021559D4:
	cmp r4, r0
	ldmgeia sp!, {r3, r4, r5, pc}
	ldr r1, [lr, #0xb0]
	sub r0, r4, r0
	add r0, r1, r0
	str r0, [lr, #0xb0]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021559F0: .word gPlayer
_021559F4: .word 0x0030F000
_021559F8: .word 0x0020FF80
_021559FC: .word 0xFFEF8040
_02155A00: .word 0x00083FE0
	arm_func_end ovl02_21558F0

	arm_func_start ovl02_2155A04
ovl02_2155A04: // 0x02155A04
	add r0, r0, #0x300
	ldrsh r3, [r0, #0x80]
	ldr r2, _02155A3C // =_021787E0
	mov r0, #0
_02155A14:
	mov r1, r0, lsl #1
	ldrsh r1, [r2, r1]
	cmp r1, r3
	bxlt lr
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #2
	blo _02155A14
	bx lr
	.align 2, 0
_02155A3C: .word _021787E0
	arm_func_end ovl02_2155A04

	arm_func_start ovl02_2155A40
ovl02_2155A40: // 0x02155A40
	ldr r0, _02155A58 // =gameState
	ldr r1, _02155A5C // =_021787F0
	ldr r0, [r0, #0x18]
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02155A58: .word gameState
_02155A5C: .word _021787F0
	arm_func_end ovl02_2155A40

	arm_func_start ovl02_2155A60
ovl02_2155A60: // 0x02155A60
	stmdb sp!, {r3, lr}
	bl ovl02_2155854
	ldr r1, _02155A74 // =_02178984
	ldr r0, [r1, r0, lsl #2]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155A74: .word _02178984
	arm_func_end ovl02_2155A60

	arm_func_start ovl02_2155A78
ovl02_2155A78: // 0x02155A78
	stmdb sp!, {r3, lr}
	ldr r1, _02155AAC // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r1, [r1, #0x70]
	cmpeq r1, #0xf
	ldreq r0, _02155AB0 // =_021794DC
	ldreq r0, [r0, #0x24]
	ldmeqia sp!, {r3, pc}
	bl ovl02_2155A04
	ldr r1, _02155AB4 // =_021794F8
	ldr r0, [r1, r0, lsl #2]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155AAC: .word gameState
_02155AB0: .word _021794DC
_02155AB4: .word _021794F8
	arm_func_end ovl02_2155A78

	arm_func_start ovl02_2155AB8
ovl02_2155AB8: // 0x02155AB8
	stmdb sp!, {r4, lr}
	ldr r1, _02155B28 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r1, [r1, #0x70]
	cmpeq r1, #0xf
	ldreq r4, _02155B2C // =_02178964
	beq _02155AE8
	bl ovl02_2155A04
	ldr r2, _02155B30 // =_02178958
	mov r1, #6
	mla r4, r0, r1, r2
_02155AE8:
	ldr r2, _02155B34 // =_mt_math_rand
	ldr r0, _02155B38 // =0x00196225
	ldr ip, [r2]
	ldr r1, _02155B3C // =0x3C6EF35F
	ldrh r3, [r4, #2]
	mla lr, ip, r0, r1
	mov r0, lr, lsr #0x10
	mov r0, r0, lsl #0x10
	ldrh ip, [r4]
	ldrh r1, [r4, #4]
	and r0, r3, r0, lsr #16
	str lr, [r2]
	mla r0, r1, r0, ip
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155B28: .word gameState
_02155B2C: .word _02178964
_02155B30: .word _02178958
_02155B34: .word _mt_math_rand
_02155B38: .word 0x00196225
_02155B3C: .word 0x3C6EF35F
	arm_func_end ovl02_2155AB8

	arm_func_start ovl02_2155B40
ovl02_2155B40: // 0x02155B40
	stmdb sp!, {r3, lr}
	ldr r1, _02155B74 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r1, [r1, #0x70]
	cmpeq r1, #0xf
	ldreq r0, _02155B78 // =_021789CC
	ldmeqia sp!, {r3, pc}
	bl ovl02_2155A04
	ldr r2, _02155B7C // =_021789B4
	mov r1, #0xc
	mla r0, r1, r0, r2
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155B74: .word gameState
_02155B78: .word _021789CC
_02155B7C: .word _021789B4
	arm_func_end ovl02_2155B40

	arm_func_start ovl02_2155B80
ovl02_2155B80: // 0x02155B80
	stmdb sp!, {r3, lr}
	ldr r1, _02155BB0 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r1, [r1, #0x70]
	cmpeq r1, #0xf
	ldreq r0, _02155BB4 // =_021789AC
	ldmeqia sp!, {r3, pc}
	bl ovl02_2155A04
	ldr r1, _02155BB8 // =_0217899C
	add r0, r1, r0, lsl #3
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155BB0: .word gameState
_02155BB4: .word _021789AC
_02155BB8: .word _0217899C
	arm_func_end ovl02_2155B80

	arm_func_start ovl02_2155BBC
ovl02_2155BBC: // 0x02155BBC
	stmdb sp!, {r3, lr}
	ldr r1, _02155BF4 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r1, [r1, #0x70]
	cmpeq r1, #0xf
	ldreq r0, _02155BF8 // =_021794DC
	ldreqh r0, [r0, #0xe]
	ldmeqia sp!, {r3, pc}
	bl ovl02_2155A04
	ldr r1, _02155BFC // =_021794E6
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155BF4: .word gameState
_02155BF8: .word _021794DC
_02155BFC: .word _021794E6
	arm_func_end ovl02_2155BBC

	arm_func_start ovl02_2155C00
ovl02_2155C00: // 0x02155C00
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _02155C74 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r1, [r1, #0x70]
	cmpeq r1, #0xf
	moveq r0, #2
	beq _02155C24
	bl ovl02_2155A04
_02155C24:
	ldr r2, _02155C78 // =_mt_math_rand
	mov r1, #6
	mul r4, r0, r1
	ldr r5, _02155C7C // =_02179544
	ldr ip, [r2]
	add r6, r5, r4
	ldr r0, _02155C80 // =0x00196225
	ldr r1, _02155C84 // =0x3C6EF35F
	ldrh r3, [r6, #2]
	mla lr, ip, r0, r1
	mov r0, lr, lsr #0x10
	mov r0, r0, lsl #0x10
	ldrh ip, [r5, r4]
	ldrh r1, [r6, #4]
	and r0, r3, r0, lsr #16
	str lr, [r2]
	mla r0, r1, r0, ip
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02155C74: .word gameState
_02155C78: .word _mt_math_rand
_02155C7C: .word _02179544
_02155C80: .word 0x00196225
_02155C84: .word 0x3C6EF35F
	arm_func_end ovl02_2155C00

	arm_func_start ovl02_2155C88
ovl02_2155C88: // 0x02155C88
	stmdb sp!, {r3, lr}
	ldr r1, _02155CC0 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r1, [r1, #0x70]
	cmpeq r1, #0xf
	ldreq r0, _02155CC4 // =_021794DC
	ldreqh r0, [r0, #8]
	ldmeqia sp!, {r3, pc}
	bl ovl02_2155A04
	ldr r1, _02155CC8 // =_021794E0
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155CC0: .word gameState
_02155CC4: .word _021794DC
_02155CC8: .word _021794E0
	arm_func_end ovl02_2155C88

	arm_func_start ovl02_2155CCC
ovl02_2155CCC: // 0x02155CCC
	stmdb sp!, {r4, lr}
	ldr r1, _02155D58 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r1, [r1, #0x70]
	cmpeq r1, #0xf
	bne _02155D1C
	ldr r2, _02155D5C // =_mt_math_rand
	ldr r0, _02155D60 // =0x00196225
	ldr ip, [r2]
	ldr r1, _02155D64 // =0x3C6EF35F
	ldr r3, _02155D68 // =_02178BDC
	mla r1, ip, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x1e
	str r1, [r2]
	add r0, r3, r0, lsr #27
	ldmia sp!, {r4, pc}
_02155D1C:
	ldr r3, _02155D5C // =_mt_math_rand
	ldr r1, _02155D60 // =0x00196225
	ldr ip, [r3]
	ldr r2, _02155D64 // =0x3C6EF35F
	mla r2, ip, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	str r2, [r3]
	mov r4, r1, lsr #0x10
	bl ovl02_2155A04
	ldr r2, _02155D6C // =_02178B9C
	mov r1, r4, lsl #0x1e
	add r0, r2, r0, lsl #5
	add r0, r0, r1, lsr #27
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155D58: .word gameState
_02155D5C: .word _mt_math_rand
_02155D60: .word 0x00196225
_02155D64: .word 0x3C6EF35F
_02155D68: .word _02178BDC
_02155D6C: .word _02178B9C
	arm_func_end ovl02_2155CCC

	arm_func_start ovl02_2155D70
ovl02_2155D70: // 0x02155D70
	stmdb sp!, {r3, lr}
	bl ovl02_2155854
	ldr r1, _02155D88 // =_02178860
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155D88: .word _02178860
	arm_func_end ovl02_2155D70

	arm_func_start ovl02_2155D8C
ovl02_2155D8C: // 0x02155D8C
	stmdb sp!, {r4, lr}
	bl ovl02_2155854
	ldr r3, _02155DDC // =_mt_math_rand
	ldr r1, _02155DE0 // =0x00196225
	ldr ip, [r3]
	ldr r2, _02155DE4 // =0x3C6EF35F
	ldr r4, _02155DE8 // =_0217896A
	mla lr, ip, r1, r2
	add r1, r4, r0, lsl #2
	mov r2, r0, lsl #2
	mov r0, lr, lsr #0x10
	ldrh r1, [r1, #2]
	mov r0, r0, lsl #0x10
	ldrh r2, [r4, r2]
	and r0, r1, r0, lsr #16
	str lr, [r3]
	add r0, r2, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155DDC: .word _mt_math_rand
_02155DE0: .word 0x00196225
_02155DE4: .word 0x3C6EF35F
_02155DE8: .word _0217896A
	arm_func_end ovl02_2155D8C

	arm_func_start ovl02_2155DEC
ovl02_2155DEC: // 0x02155DEC
	stmdb sp!, {r3, lr}
	bl ovl02_2155854
	ldr r1, _02155E00 // =_021789FC
	ldr r0, [r1, r0, lsl #3]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155E00: .word _021789FC
	arm_func_end ovl02_2155DEC

	arm_func_start ovl02_2155E04
ovl02_2155E04: // 0x02155E04
	stmdb sp!, {r3, lr}
	bl ovl02_2155854
	ldr r1, _02155E18 // =_02178A00
	ldr r0, [r1, r0, lsl #3]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155E18: .word _02178A00
	arm_func_end ovl02_2155E04

	arm_func_start ovl02_2155E1C
ovl02_2155E1C: // 0x02155E1C
	stmdb sp!, {r3, lr}
	bl ovl02_2155854
	ldr r1, _02155E34 // =_02178824
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155E34: .word _02178824
	arm_func_end ovl02_2155E1C

	arm_func_start ovl02_2155E38
ovl02_2155E38: // 0x02155E38
	stmdb sp!, {r4, r5, r6, lr}
	bl ovl02_2155A04
	ldr r1, _02155EA0 // =gameState
	ldr r3, _02155EA4 // =_mt_math_rand
	mov r2, #6
	ldr r4, [r1, #0x18]
	ldr ip, _02155EA8 // =_021789D8
	mov r1, #0x12
	mla r5, r4, r1, ip
	mul r4, r0, r2
	add r6, r5, r4
	ldr ip, [r3]
	ldr r0, _02155EAC // =0x00196225
	ldr r1, _02155EB0 // =0x3C6EF35F
	ldrh r2, [r6, #2]
	mla lr, ip, r0, r1
	mov r0, lr, lsr #0x10
	mov r0, r0, lsl #0x10
	ldrh ip, [r5, r4]
	ldrh r1, [r6, #4]
	and r0, r2, r0, lsr #16
	str lr, [r3]
	mla r0, r1, r0, ip
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02155EA0: .word gameState
_02155EA4: .word _mt_math_rand
_02155EA8: .word _021789D8
_02155EAC: .word 0x00196225
_02155EB0: .word 0x3C6EF35F
	arm_func_end ovl02_2155E38

	arm_func_start ovl02_2155EB4
ovl02_2155EB4: // 0x02155EB4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	ldr r1, _02155FA4 // =_02178848
	mov r4, r0
	add r3, sp, #0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r4
	mov r1, #1
	bl BossArena__SetCameraType
	mov r0, r4
	add r1, sp, #0
	bl BossArena__SetUpVector
	ldr r1, [r5, #0x38c]
	mov r0, r4
	add r2, r1, #0x1f4000
	ldr r1, _02155FA8 // =0x02133BC8
	mov r3, #0
	ldrh r1, [r1, #0x2a]
	mov r1, r1, lsl #0xc
	mov r1, r1, asr #1
	bl BossArena__SetTracker1TargetPos
	mov r1, #0
	mov r0, r4
	mov r2, r1
	mov r3, r1
	bl BossArena__SetTracker1TargetOffset
	mov r1, #0
	mov r0, r4
	mov r2, r1
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r4
	mov r1, #0xc8000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r1, #0x1e000
	mov r0, r4
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r4
	mov r1, #0
	bl BossArena__SetAngleTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAngleSpeed
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02155FA4: .word _02178848
_02155FA8: .word 0x02133BC8
	arm_func_end ovl02_2155EB4

	arm_func_start ovl02_2155FAC
ovl02_2155FAC: // 0x02155FAC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r0, #2
	bl BossArena__GetCamera
	ldr r1, _02156098 // =_0217886C
	mov r4, r0
	add r3, sp, #0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r4
	mov r1, #1
	bl BossArena__SetCameraType
	mov r0, r4
	add r1, sp, #0
	bl BossArena__SetUpVector
	ldr r1, [r5, #0x38c]
	mov r0, r4
	add r2, r1, #0x50000
	ldr r1, _0215609C // =0x02133BC8
	mov r3, #0
	ldrh r1, [r1, #0x2a]
	mov r1, r1, lsl #0xc
	mov r1, r1, asr #1
	bl BossArena__SetTracker1TargetPos
	mov r1, #0
	mov r0, r4
	mov r2, r1
	mov r3, r1
	bl BossArena__SetTracker1TargetOffset
	mov r1, #0
	mov r0, r4
	mov r2, r1
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r4
	mov r1, #0x78000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x3c000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r4
	mov r1, #0
	bl BossArena__SetAngleTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAngleSpeed
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02156098: .word _0217886C
_0215609C: .word 0x02133BC8
	arm_func_end ovl02_2155FAC

	arm_func_start ovl02_21560A0
ovl02_21560A0: // 0x021560A0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	ldr r1, _0215613C // =0x02133BC8
	ldr r2, [r5, #0x38c]
	ldrh r1, [r1, #0x2a]
	mov r4, r0
	add r2, r2, #0x21c000
	mov r1, r1, lsl #0xc
	mov r1, r1, asr #1
	mov r3, #0
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0xf0000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x1e000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r5
	bl ovl02_21552F0
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r0, #0x39c]
	cmp r0, #0
	ldreq r1, _02156140 // =0x00001555
	mov r0, r4
	ldrne r1, _02156144 // =0x0000EAAB
	bl BossArena__SetAngleTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAngleSpeed
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215613C: .word 0x02133BC8
_02156140: .word 0x00001555
_02156144: .word 0x0000EAAB
	arm_func_end ovl02_21560A0

	arm_func_start ovl02_2156148
ovl02_2156148: // 0x02156148
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	mov r0, #1
	bl BossArena__GetCamera
	mov r5, r0
	mov r1, #0xe6000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r5
	mov r1, #0x80
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r7
	bl ovl02_21552F0
	cmp r0, #0
	beq _0215624C
	add r0, r0, #0x400
	ldrh r0, [r0, #0x3c]
	ldr r2, _02156268 // =FX_SinCosTable_
	ldr r1, _0215626C // =0x00001555
	add r0, r0, #0x4000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r3, r0, lsl #1
	mov r0, r3, lsl #1
	ldrsh r0, [r2, r0]
	add r3, r3, #1
	mov r3, r3, lsl #1
	smulbb r0, r0, r1
	mov r1, r0, lsl #4
	ldrsh r6, [r2, r3]
	mov r0, r5
	mov r1, r1, lsr #0x10
	bl BossArena__SetAngleTarget
	mov r0, #0x1e000
	umull r3, r2, r6, r0
	mov r1, #0
	adds r3, r3, #0x800
	mla r2, r6, r1, r2
	mov r4, r6, asr #0x1f
	mla r2, r4, r0, r2
	adc r2, r2, #0
	mov r1, r3, lsr #0xc
	mov r0, r5
	orr r1, r1, r2, lsl #20
	bl BossArena__SetAmplitudeYTarget
	ldr r1, [r7, #0x38c]
	mov r0, r5
	add r2, r1, #0x230000
	ldr r1, _02156270 // =0x02133BC8
	mov r3, #0
	ldrh r1, [r1, #0x2a]
	mov r7, #0x14000
	umull lr, ip, r6, r7
	mov r1, r1, lsl #0xc
	mov r1, r1, asr #1
	mla ip, r6, r3, ip
	mla ip, r4, r7, ip
	adds r6, lr, #0x800
	adc r4, ip, #0
	mov r6, r6, lsr #0xc
	orr r6, r6, r4, lsl #20
	add r2, r2, r6
	bl BossArena__SetTracker1TargetPos
_0215624C:
	mov r0, r5
	mov r1, #0x80
	bl BossArena__SetAngleSpeed
	mov r0, r5
	mov r1, #0x80
	bl BossArena__SetAmplitudeYSpeed
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02156268: .word FX_SinCosTable_
_0215626C: .word 0x00001555
_02156270: .word 0x02133BC8
	arm_func_end ovl02_2156148

	arm_func_start ovl02_2156274
ovl02_2156274: // 0x02156274
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r10, r0
	ldr r2, _021562F8 // =0x0000069C
	mov r1, r10
	mov r0, #0
	bl MIi_CpuClear16
	add r0, r10, #0x18
	mov r1, #0
	bl NNS_FndInitList
	mov r7, #0
	ldr r4, _021562FC // =0x00149FB0
	mov r9, r7
	add r8, r10, #0x24
	mov r6, #3
	mov r5, r7
_021562B0:
	mov r1, r8
	add r0, r10, #0x18
	bl NNS_FndAppendListObject
	mov r0, r7
	mov r1, r6
	bl FX_ModS32
	str r0, [r8, #8]
	add r0, r8, #0xc
	bl MTX_Identity33_
	str r5, [r8, #0x30]
	str r5, [r8, #0x34]
	str r9, [r8, #0x38]
	add r7, r7, #1
	cmp r7, #7
	add r8, r8, #0x3c
	add r9, r9, r4
	blt _021562B0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_021562F8: .word 0x0000069C
_021562FC: .word 0x00149FB0
	arm_func_end ovl02_2156274

	arm_func_start ovl02_2156300
ovl02_2156300: // 0x02156300
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	add r6, r0, #0x390
	bl ovl02_2155A78
	ldr r2, [r6, #0x14]
	cmp r2, r0
	bge _0215634C
	bge _02156334
	sub r1, r0, r2
	cmp r1, #0xcc
	addgt r0, r2, #0xcc
	strgt r0, [r6, #0x14]
	strle r0, [r6, #0x14]
	b _0215634C
_02156334:
	ble _0215634C
	sub r1, r2, r0
	cmp r1, #0xcc
	subgt r0, r2, #0xcc
	strgt r0, [r6, #0x14]
	strle r0, [r6, #0x14]
_0215634C:
	add r0, r6, #0x18
	mov r1, #0
	bl NNS_FndGetNthListObject
	movs r7, r0
	mov r8, #0
	beq _021563E8
	ldr r0, _02156470 // =FX_SinCosTable_
	ldr r4, _02156474 // =0xFFEB6050
	ldrsh r9, [r0, #2]
	ldrsh r10, [r0]
	mov r5, r8
_02156378:
	cmp r8, #0
	bne _021563A4
	add r0, r7, #0x30
	add r1, r6, #0xc
	mov r2, r0
	bl VEC_Add
	mov r1, r10
	mov r2, r9
	add r0, r7, #0xc
	blx MTX_RotX33_
	b _021563D0
_021563A4:
	str r5, [r7, #0x30]
	str r5, [r7, #0x34]
	add r0, r7, #0x30
	str r4, [r7, #0x38]
	add r1, r8, #0xc
	mov r2, r0
	bl MTX_MultVec43
	ldr r1, [r7, #0x38]
	add r0, r7, #0xc
	rsb r1, r1, #0
	bl ovl02_2156534
_021563D0:
	mov r1, r7
	add r0, r6, #0x18
	mov r8, r7
	bl NNS_FndGetNextListObject
	movs r7, r0
	bne _02156378
_021563E8:
	add r0, r6, #0x18
	mov r1, #0
	bl NNS_FndGetNthListObject
	mov r4, r0
	ldr r0, [r4, #0x38]
	cmp r0, #0
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r1, r4
	add r0, r6, #0x18
	bl NNS_FndRemoveListObject
	ldrh r1, [r6, #0x20]
	add r0, r6, #0x18
	sub r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl NNS_FndGetNthListObject
	mov r1, #0
	mov r2, r0
	str r1, [r4, #0x30]
	str r1, [r4, #0x34]
	ldr r0, _02156474 // =0xFFEB6050
	add r1, r2, #0xc
	str r0, [r4, #0x38]
	add r0, r4, #0x30
	mov r2, r0
	bl MTX_MultVec43
	ldr r1, [r4, #0x38]
	add r0, r4, #0xc
	rsb r1, r1, #0
	bl ovl02_2156534
	mov r1, r4
	add r0, r6, #0x18
	bl NNS_FndAppendListObject
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02156470: .word FX_SinCosTable_
_02156474: .word 0xFFEB6050
	arm_func_end ovl02_2156300

	arm_func_start ovl02_2156478
ovl02_2156478: // 0x02156478
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r8, r0
	add r5, r8, #0x390
	add r0, r5, #0x18
	mov r1, #0
	bl NNS_FndGetNthListObject
	movs r6, r0
	beq _021564F8
	add r4, r5, #0x1c8
	mov r9, #0x17c
_021564A0:
	ldr r1, [r6, #8]
	mov r0, r5
	mla r7, r1, r9, r4
	add r1, r6, #0x30
	add r2, r7, #0x48
	bl VEC_Add
	add lr, r6, #0xc
	ldmia lr!, {r0, r1, r2, r3}
	add ip, r7, #0x24
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r0, [lr]
	mov r1, r7
	str r0, [ip]
	mov r0, r8
	bl StageTask__Draw3D
	add r0, r5, #0x18
	mov r1, r6
	bl NNS_FndGetNextListObject
	movs r6, r0
	bne _021564A0
_021564F8:
	ldr r0, [r8, #0xa2c]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	add r0, r5, #0x23c
	add r5, r0, #0x400
	mov r4, #0
_02156510:
	mov r0, r5
	bl AnimatePalette
	mov r0, r5
	bl DrawAnimatedPalette
	add r4, r4, #1
	cmp r4, #3
	add r5, r5, #0x20
	blt _02156510
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end ovl02_2156478

	arm_func_start ovl02_2156534
ovl02_2156534: // 0x02156534
	stmdb sp!, {r3, lr}
	ldr r2, _02156594 // =0x003DDF10
	mov r3, #0
	cmp r1, r2
	ble _02156564
	rsb r2, r2, #0
	add r1, r1, r2
	mov r1, r1, lsl #4
	mov r1, r1, asr #0xc
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
_02156564:
	mov r1, r3, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	ldr r3, _02156598 // =FX_SinCosTable_
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	blx MTX_RotX33_
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156594: .word 0x003DDF10
_02156598: .word FX_SinCosTable_
	arm_func_end ovl02_2156534

	arm_func_start ovl02_215659C
ovl02_215659C: // 0x0215659C
	stmdb sp!, {r3, lr}
	ldr r1, _021565D0 // =gPlayer
	ldr r0, _021565D4 // =0x002B1000
	ldr r1, [r1]
	ldr r1, [r1, #0x48]
	cmp r1, r0
	bge _021565C4
	mov r0, #0
	bl SetHUDActiveScreen
	ldmia sp!, {r3, pc}
_021565C4:
	mov r0, #1
	bl SetHUDActiveScreen
	ldmia sp!, {r3, pc}
	.align 2, 0
_021565D0: .word gPlayer
_021565D4: .word 0x002B1000
	arm_func_end ovl02_215659C

	arm_func_start ovl02_21565D8
ovl02_21565D8: // 0x021565D8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x37c]
	blx r1
	ldr r0, [r4, #0xa2c]
	cmp r0, #0
	bne _021565FC
	mov r0, r4
	bl ovl02_2156300
_021565FC:
	mov r0, r4
	bl ovl02_2155880
	mov r0, r4
	bl ovl02_21558F0
	mov r0, r4
	bl ovl02_21557FC
	add r1, r4, #0x238
	mov r0, r4
	add r1, r1, #0x800
	bl ovl02_215577C
	ldr r0, [r4, #0x388]
	cmp r0, #0
	beq _02156658
	ldr r0, _021566BC // =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #3
	ldreq r0, [r0, #0x70]
	cmpeq r0, #0xb
	beq _02156658
	add r1, r4, #0x23c
	mov r0, r4
	add r1, r1, #0x800
	bl ovl02_21555CC
_02156658:
	add r0, r4, #0x154
	add r0, r0, #0xc00
	bl BossHelpers__Light__Func_203954C
	mov r0, r4
	bl ovl02_215659C
	ldr r1, _021566C0 // =gPlayer
	mov r0, r4
	ldr r1, [r1]
	mov r2, #0
	add r1, r1, #0x500
	strh r2, [r1, #0xf8]
	bl ovl02_21558E8
	cmp r0, #0
	mov r0, r4
	beq _021566B4
	bl ovl02_2155BBC
	cmp r0, #0
	mov r0, r4
	bne _021566AC
	bl ovl02_21560A0
	ldmia sp!, {r4, pc}
_021566AC:
	bl ovl02_2156148
	ldmia sp!, {r4, pc}
_021566B4:
	bl ovl02_2155EB4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021566BC: .word gameState
_021566C0: .word gPlayer
	arm_func_end ovl02_21565D8

	arm_func_start ovl02_21566C4
ovl02_21566C4: // 0x021566C4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x158
	add r7, r0, #0x400
	mov r6, #0
_021566E0:
	mov r0, r7
	bl BossHelpers__Animation__Func_2038C58
	mov r0, r7
	bl AnimatorMDL__Release
	add r6, r6, #1
	cmp r6, #3
	add r7, r7, #0x17c
	blt _021566E0
	add r0, r4, #0x258
	add r0, r0, #0x800
	bl BossHelpers__Animation__Func_2038C58
	add r0, r4, #0x258
	add r0, r0, #0x800
	bl AnimatorMDL__Release
	add r0, r4, #0x3d4
	add r0, r0, #0x800
	bl BossHelpers__Animation__Func_2038C58
	add r0, r4, #0x3d4
	add r0, r0, #0x800
	bl AnimatorMDL__Release
	add r0, r4, #0x1cc
	ldr r1, _021567A4 // =renderCoreSwapBuffer
	mov r7, #0
	str r7, [r1, #4]
	add r6, r0, #0x800
_02156744:
	mov r0, r6
	bl ReleasePaletteAnimator
	add r7, r7, #1
	cmp r7, #3
	add r6, r6, #0x20
	blt _02156744
	add r0, r4, #0x188
	add r6, r0, #0xc00
	mov r7, #0
_02156768:
	mov r0, r6
	bl ReleasePaletteAnimator
	add r7, r7, #1
	cmp r7, #4
	add r6, r6, #0x20
	blt _02156768
	add r0, r4, #0x208
	add r0, r0, #0xc00
	bl ReleasePaletteAnimator
	ldr r1, _021567A8 // =Boss6Stage__Singleton
	mov r2, #0
	mov r0, r5
	str r2, [r1]
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021567A4: .word renderCoreSwapBuffer
_021567A8: .word Boss6Stage__Singleton
	arm_func_end ovl02_21566C4

	arm_func_start ovl02_21567AC
ovl02_21567AC: // 0x021567AC
	stmdb sp!, {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	ldmneia sp!, {r4, r5, r6, pc}
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _021567F0
	add r0, r4, #0x154
	add r0, r0, #0xc00
	bl BossHelpers__Light__SetLights2
	mov r0, r4
	bl ovl02_2156478
	add r0, r4, #0x154
	add r0, r0, #0xc00
	bl BossHelpers__Light__SetLights1
_021567F0:
	add r0, r4, #0x188
	add r6, r0, #0xc00
	mov r5, #0
_021567FC:
	mov r0, r6
	bl AnimatePalette
	mov r0, r6
	bl DrawAnimatedPalette
	add r5, r5, #1
	cmp r5, #4
	add r6, r6, #0x20
	blt _021567FC
	add r4, r4, #0x208
	add r0, r4, #0xc00
	bl AnimatePalette
	add r0, r4, #0xc00
	bl DrawAnimatedPalette
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ovl02_21567AC

	arm_func_start ovl02_2156834
ovl02_2156834: // 0x02156834
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r0, #4
	bl BossArena__SetType
	mov r0, r4
	bl ovl02_2155EB4
	mov r0, r4
	bl ovl02_2155FAC
	mov r0, #1
	bl BossArena__GetCamera
	mov r5, r0
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__ApplyAmplitudeXZTarget
	mov r0, r5
	bl BossArena__ApplyAmplitudeYTarget
	mov r0, r5
	bl BossArena__ApplyAngleTarget
	bl BossArena__Func_20397E4
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	mov r0, #2
	bl BossArena__GetCamera
	mov r5, r0
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__ApplyAmplitudeXZTarget
	mov r0, r5
	bl BossArena__ApplyAmplitudeYTarget
	mov r0, r5
	bl BossArena__ApplyAngleTarget
	bl BossArena__Func_20397E4
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	mov r0, #1
	bl BossArena__SetUnknown2Type
	bl BossArena__GetUnknown2Animator
	mov r5, r0
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	str r2, [sp]
	mov r0, r5
	ldr r1, _021569A0 // =bossAssetFiles
	mov r3, r2
	ldr r1, [r1, #0x18]
	bl AnimatorMDL__SetResource
	mov r3, #0
	str r3, [sp]
	mov r1, #1
	str r1, [sp, #4]
	mov r0, r5
	ldr r2, [r4, #0x368]
	bl BossHelpers__Animation__Func_2038BF0
	mov r3, #0
	str r3, [sp]
	mov r0, #1
	str r0, [sp, #4]
	mov r0, r5
	mov r1, #3
	ldr r2, [r4, #0x36c]
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _021569A4 // =0x005DC000
	str r0, [r5, #0x18]
	str r0, [r5, #0x1c]
	str r0, [r5, #0x20]
	bl Camera3D__Create
	ldr r0, _021569A8 // =gPlayer
	ldr r0, [r0]
	bl BossPlayerHelpers_Action_SetOnLandGround_Boss6
	ldr r1, _021569A8 // =gPlayer
	ldr r2, _021569AC // =ovl02_2154D5C
	ldr r3, [r1]
	add r0, r4, #0x300
	ldr r3, [r3, #0xfc]
	str r3, [r4, #0xd50]
	ldr r1, [r1]
	str r2, [r1, #0xfc]
	ldrsh r0, [r0, #0x80]
	bl UpdateBossHealthHUD
	ldr r1, _021569B0 // =ovl02_21569B4
	mov r0, #1
	str r1, [r4, #0x37c]
	str r0, [r4, #0x384]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021569A0: .word bossAssetFiles
_021569A4: .word 0x005DC000
_021569A8: .word gPlayer
_021569AC: .word ovl02_2154D5C
_021569B0: .word ovl02_21569B4
	arm_func_end ovl02_2156834

	arm_func_start ovl02_21569B4
ovl02_21569B4: // 0x021569B4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl TitleCard__GetProgress
	cmp r0, #5
	moveq r0, #1
	streq r0, [r4, #0x388]
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_21569B4

	arm_func_start ovl02_21569D0
ovl02_21569D0: // 0x021569D0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x94
	mov r2, #1
	mov r3, r2
	add r0, r0, #0x400
	mov r1, #0xc
	bl BossHelpers__Palette__Func_2038BAC
	add r0, r4, #0x400
	mov r1, #0x3c
	strh r1, [r0, #0x1c]
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_21569D0

	arm_func_start ovl02_2156A00
ovl02_2156A00: // 0x02156A00
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x3c
	ldr r2, _02156AC4 // =_02178878
	add r3, sp, #0x30
	mov r5, r0
	mov ip, r1
	ldmia r2, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, _02156AC8 // =_02178818
	add r6, sp, #0x24
	ldmia r0, {r0, r1, r2}
	add r3, sp, #0
	add r4, r5, #0x650
	stmia r6, {r0, r1, r2}
	ldmia r4, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r4
	mov r1, r6
	mov r2, ip
	bl sub_2066AC0
	mov r4, r0
	add r0, sp, #0x30
	add r1, sp, #0
	add r2, sp, #0x18
	bl VEC_CrossProduct
	add r0, sp, #0x18
	mov r1, r0
	bl VEC_Normalize
	add r0, sp, #0
	add r1, sp, #0x18
	add r2, sp, #0xc
	bl VEC_CrossProduct
	add r0, r5, #0x238
	add r6, r0, #0x400
	add r0, r5, #0x244
	add r3, r5, #0x650
	add r1, sp, #0x18
	add ip, r0, #0x400
	ldmia r1, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	add lr, sp, #0xc
	ldmia lr, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	add r5, sp, #0
	ldmia r5, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r4
	add sp, sp, #0x3c
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02156AC4: .word _02178878
_02156AC8: .word _02178818
	arm_func_end ovl02_2156A00

	arm_func_start ovl02_2156ACC
ovl02_2156ACC: // 0x02156ACC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x28
	ldr r6, _02156BC4 // =Boss6Stage__Singleton
	ldr r9, [r0, #0x45c]
	ldr r5, [r0, #0x458]
	rsb ip, r9, #0
	ldr r8, [r0, #0x460]
	add r4, r0, #0x98
	ldr r7, _02156BC8 // =0x00083FE0
	mov r11, r1
	mov r1, #1
	str r8, [sp, #0x24]
	ldr r0, [r6]
	mov r10, r2
	mov r9, r3
	str r5, [sp, #0x1c]
	str ip, [sp, #0x20]
	str r7, [sp, #0x10]
	ldr r8, [sp, #0x50]
	str r1, [sp, #0xc]
	bl GetTaskWork_
	ldr r2, [r0, #0x38c]
	mov r1, #0x1e000
	ldr r0, _02156BCC // =0xFFDF0080
	rsb r2, r2, #0
	add r0, r2, r0
	str r0, [sp, #0x14]
	str r1, [sp, #0x18]
	mov r5, #0
_02156B40:
	str r10, [sp]
	add r0, sp, #0x10
	ldr r7, [r0, r5, lsl #2]
	str r9, [sp, #4]
	add r0, sp, #0x1c
	str r8, [sp, #8]
	ldr r6, [r0, r5, lsl #2]
	ldr r2, [r4, r5, lsl #2]
	mov r0, r6
	mov r1, r7
	mov r3, r11
	bl BossHelpers__Math__Func_20392BC
	subs r1, r7, r6
	rsbmi r1, r1, #0
	str r0, [r4, r5, lsl #2]
	cmp r8, r1
	blt _02156B98
	ldr r0, [r4, r5, lsl #2]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r10, r0
	bge _02156BA4
_02156B98:
	mov r0, #0
	str r0, [sp, #0xc]
	b _02156BAC
_02156BA4:
	mov r0, #0
	str r0, [r4, r5, lsl #2]
_02156BAC:
	add r5, r5, #1
	cmp r5, #3
	blt _02156B40
	ldr r0, [sp, #0xc]
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02156BC4: .word Boss6Stage__Singleton
_02156BC8: .word 0x00083FE0
_02156BCC: .word 0xFFDF0080
	arm_func_end ovl02_2156ACC

	arm_func_start ovl02_2156BD0
ovl02_2156BD0: // 0x02156BD0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	ldr r0, [r5, #0x370]
	bl ovl02_21558E8
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [r5, #0x3c0]
	cmp r0, #1
	cmpne r0, #2
	cmpne r0, #3
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	add r0, r5, #0x400
	ldrh r1, [r0, #0x2c]
	cmp r1, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	sub r1, r1, #1
	strh r1, [r0, #0x2c]
	ldrh r0, [r0, #0x2c]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [r5, #0x370]
	bl ovl02_2155E38
	add r1, r5, #0x400
	strh r0, [r1, #0x2c]
	ldr r2, _02156D28 // =_mt_math_rand
	ldr r0, _02156D2C // =0x00196225
	ldr r3, [r2]
	ldr r1, _02156D30 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	str r1, [r2]
	movne r6, #0
	ldr r0, [r5, #0x370]
	moveq r6, #1
	bl ovl02_2155744
	cmp r0, #0
	bne _02156D0C
	ldr r3, _02156D28 // =_mt_math_rand
	ldr r4, [r5, #0x370]
	ldr r2, [r3]
	ldr r0, _02156D2C // =0x00196225
	ldr r1, _02156D30 // =0x3C6EF35F
	add r4, r4, r6, lsl #2
	mla ip, r2, r0, r1
	mov r2, ip, lsr #0x10
	mov r2, r2, lsl #0x10
	ldr r4, [r4, #0x374]
	mov r2, r2, lsr #0x10
	str ip, [r3]
	ands r2, r2, #1
	beq _02156CB4
	cmp r2, #1
	beq _02156CCC
	b _02156D0C
_02156CB4:
	ldr r0, [r5, #0x370]
	bl ovl02_2155B40
	mov r1, r0
	mov r0, r4
	bl ovl02_215A5D8
	b _02156D0C
_02156CCC:
	mla r2, ip, r0, r1
	mla r0, r2, r0, r1
	str r0, [r3]
	mov r1, r2, lsr #0x10
	mov r0, r0, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r2, r0, lsl #0x10
	ldr r0, [r5, #0x370]
	mov r6, r1, lsr #0x10
	mov r7, r2, lsr #0x10
	bl ovl02_2155B80
	mov r3, r0
	mov r0, r4
	and r1, r7, #1
	and r2, r6, #1
	bl ovl02_215A618
_02156D0C:
	ldr r0, [r5, #0x430]
	cmp r0, #0
	moveq r0, #1
	streq r0, [r5, #0x430]
	movne r0, #0
	strne r0, [r5, #0x430]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02156D28: .word _mt_math_rand
_02156D2C: .word 0x00196225
_02156D30: .word 0x3C6EF35F
	arm_func_end ovl02_2156BD0

	arm_func_start ovl02_2156D34
ovl02_2156D34: // 0x02156D34
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r1, [r4, #0x3bc]
	blx r1
	mov r0, r4
	bl ovl02_2156BD0
	ldr r1, [r4, #0x408]
	cmp r1, #0x1000
	ble _02156D94
	bge _02156D78
	rsb r0, r1, #0x1000
	cmp r0, #8
	addgt r0, r1, #8
	strgt r0, [r4, #0x408]
	movle r0, #0x1000
	strle r0, [r4, #0x408]
	b _02156D94
_02156D78:
	ble _02156D94
	sub r0, r1, #0x1000
	cmp r0, #8
	subgt r0, r1, #8
	strgt r0, [r4, #0x408]
	movle r0, #0x1000
	strle r0, [r4, #0x408]
_02156D94:
	add r0, r4, #0x3c4
	bl ovl02_21550CC
	add r0, r4, #0x3dc
	add r3, r4, #0xb0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r4, #0x400
	ldrh r1, [r0, #0x1c]
	cmp r1, #0
	beq _02156DE8
	sub r1, r1, #1
	strh r1, [r0, #0x1c]
	ldrh r0, [r0, #0x1c]
	cmp r0, #0
	bne _02156DE8
	add r0, r4, #0x94
	mov r2, #0
	mov r3, r2
	add r0, r0, #0x400
	mov r1, #0xc
	bl BossHelpers__Palette__Func_2038BAC
_02156DE8:
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
	arm_func_end ovl02_2156D34

	arm_func_start ovl02_2156EA4
ovl02_2156EA4: // 0x02156EA4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	bl GetTaskWork_
	mov r5, r0
	add r0, r5, #0x214
	add r0, r0, #0x400
	bl BossHelpers__Animation__Func_2038C58
	add r0, r5, #0x214
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	add r0, r5, #0x790
	bl BossHelpers__Animation__Func_2038C58
	add r0, r5, #0x790
	bl AnimatorMDL__Release
	add r0, r5, #0x10c
	add r0, r0, #0x800
	bl BossHelpers__Animation__Func_2038C58
	add r0, r5, #0x10c
	add r0, r0, #0x800
	bl AnimatorMDL__Release
	add r0, r5, #0x94
	add r7, r0, #0x400
	mov r6, #0
_02156F00:
	mov r0, r7
	bl ReleasePaletteAnimator
	add r6, r6, #1
	cmp r6, #0xc
	add r7, r7, #0x20
	blt _02156F00
	ldr r0, [r5, #0xa88]
	bl FreeSndHandle
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end ovl02_2156EA4

	arm_func_start ovl02_2156F2C
ovl02_2156F2C: // 0x02156F2C
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r5, r4, #0x214
	bl ovl02_2156FDC
	cmp r0, #0
	ldreq r0, [r4, #0x20]
	add r1, r5, #0x400
	orreq r0, r0, #0x20
	streq r0, [r4, #0x20]
	mov r0, r4
	bl StageTask__Draw3D
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	bne _02156FA0
	add r0, r4, #0x34
	add r1, r0, #0x400
	mov r0, #0x1e
	bl BossHelpers__Model__SetMatrixMode
	add r0, r4, #0x64
	add r1, r0, #0x400
	mov r0, #0x1d
	bl BossHelpers__Model__SetMatrixMode
	add r2, r4, #0x10c
	mov r0, r4
	add r1, r4, #0x790
	add r2, r2, #0x800
	mov r3, #0xf000
	bl ovl02_2155390
_02156FA0:
	ldr r1, [r4, #0x20]
	add r0, r4, #0x94
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	add r5, r0, #0x400
	mov r4, #0
_02156FB8:
	mov r0, r5
	bl AnimatePalette
	mov r0, r5
	bl DrawAnimatedPalette
	add r4, r4, #1
	cmp r4, #0xc
	add r5, r5, #0x20
	blt _02156FB8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_2156F2C

	arm_func_start ovl02_2156FDC
ovl02_2156FDC: // 0x02156FDC
	stmdb sp!, {r4, lr}
	ldr r1, [r0, #0x420]
	mov r4, #0
	cmp r1, #0
	beq _0215701C
	ldr r0, [r0, #0x3c0]
	cmp r0, #4
	cmpne r0, #6
	cmpne r0, #7
	bne _0215700C
	mov r4, #1
	b _02157024
_0215700C:
	bl Camera3D__UseEngineA
	cmp r0, #0
	movne r4, #1
	b _02157024
_0215701C:
	mov r4, #1
	str r4, [r0, #0x420]
_02157024:
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2156FDC

	arm_func_start ovl02_215702C
ovl02_215702C: // 0x0215702C
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
	beq _02157064
	ldr r0, [r4, #0x234]
	add r1, r4, #0x218
	bl StageTask__HandleCollider
_02157064:
	ldr r0, [r4, #0x270]
	tst r0, #4
	ldmeqia sp!, {r4, pc}
	ldr r2, [r4, #0x45c]
	ldr r1, [r4, #0x458]
	ldr r3, [r4, #0x460]
	add r0, r4, #0x258
	rsb r2, r2, #0
	bl BossHelpers__Collision__Func_20390AC
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_215702C

	arm_func_start ovl02_215708C
ovl02_215708C: // 0x0215708C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r3, r0
	ldr r5, [r3, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, r4
	mov r2, r5
	bl ovl02_215727C
	ldr r0, [r4, #0x370]
	bl ovl02_2155830
	ldr r0, [r4, #0x370]
	bl ovl02_2155848
	cmp r0, #2
	blo _021570DC
	ldr r0, [r4, #0x370]
	bl ovl02_21558D8
_021570DC:
	ldr r0, [r4, #0x370]
	bl ovl02_2155A04
	mov r6, r0
	ldr r0, [r4, #0x370]
	bl ovl02_2155A60
	mov r7, r0
	bl ovl02_2155A40
	smull r2, r1, r0, r7
	adds r2, r2, #0x800
	ldr r0, [r4, #0x370]
	adc r1, r1, #0
	add r0, r0, #0x300
	mov r3, r2, lsr #0xc
	ldrsh ip, [r0, #0x80]
	orr r3, r3, r1, lsl #20
	mov r2, #0
	sub r1, ip, r3
	strh r1, [r0, #0x80]
	ldr r0, [r4, #0x370]
	add r1, r0, #0x300
	ldrsh r0, [r1, #0x80]
	cmp r0, #0
	bgt _021571A8
	ldr r0, [r4, #0x3c0]
	cmp r0, #6
	bne _02157154
	mov r0, r4
	strh r2, [r1, #0x80]
	bl ovl02_2157670
	b _02157200
_02157154:
	mov r2, #1
	mov r0, r4
	strh r2, [r1, #0x80]
	bl ovl02_2157650
	mov r0, r4
	bl ovl02_21569D0
	ldr r0, [r5, #0x48]
	ldr r1, [r5, #0x44]
	ldr r3, [r5, #0x4c]
	rsb r2, r0, #0
	mov r0, #0
	bl BossFX__CreateHitA
	mov r0, #0
	str r0, [sp]
	mov r1, #0xce
	str r1, [sp, #4]
	sub r1, r1, #0xcf
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _02157200
_021571A8:
	mov r0, r4
	bl ovl02_21569D0
	ldr r0, [r5, #0x48]
	ldr r1, [r5, #0x44]
	rsb r2, r0, #0
	ldr r3, [r5, #0x4c]
	mov r0, #0
	bl BossFX__CreateHitA
	mov r3, #0x8c
	mov r0, #0
	sub r1, r3, #0x8d
	stmia sp, {r0, r3}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x370]
	bl ovl02_2155854
	sub r0, r0, #1
	mov r2, r0, lsl #6
	ldr r0, _02157274 // =defaultSfxPlayer
	ldr r1, _02157278 // =0x0000FFFF
	bl NNS_SndPlayerSetTrackPitch
_02157200:
	ldr r0, [r4, #0x370]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0x80]
	bl UpdateBossHealthHUD
	ldr r0, [r4, #0x370]
	bl ovl02_2155A04
	mov r5, r0
	cmp r6, r5
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	add r0, r4, #0x400
	ldrh r0, [r0, #0x2c]
	cmp r0, #0
	bne _02157258
	ldr r0, [r4, #0x370]
	bl ovl02_2155E38
	add r1, r4, #0x400
	strh r0, [r1, #0x2c]
	ldrh r0, [r1, #0x2c]
	cmp r0, #0
	movne r0, #1
	strneh r0, [r1, #0x2c]
_02157258:
	cmp r5, #2
	addlo sp, sp, #8
	ldmloia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, #1
	bl ChangeBossBGMVariant
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02157274: .word defaultSfxPlayer
_02157278: .word 0x0000FFFF
	arm_func_end ovl02_215708C

	arm_func_start ovl02_215727C
ovl02_215727C: // 0x0215727C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r6, r0
	mov r9, r2
	ldr r5, [r6, #0x44]
	ldr r0, [r9, #0x44]
	ldr r4, [r6, #0x48]
	ldr r2, [r9, #0x48]
	mov r10, r1
	sub r0, r5, r0
	sub r1, r4, r2
	mov r8, r3
	bl FX_Atan2Idx
	mov r5, r0
	ldr r0, [r6, #0x370]
	bl ovl02_2155D70
	cmp r0, r5
	movhi r5, r0
	bhi _021572D8
	rsb r0, r0, #0
	mov r0, r0, lsl #0x10
	cmp r5, r0, lsr #16
	mov r0, r0, lsr #0x10
	movhi r5, r0
_021572D8:
	ldr r0, [r6, #0x370]
	bl ovl02_2155D8C
	cmp r5, #0x2000
	bhs _021572F8
	add r0, r5, r0
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	b _02157308
_021572F8:
	cmp r5, #0xe000
	subhi r0, r5, r0
	movhi r0, r0, lsl #0x10
	movhi r5, r0, lsr #0x10
_02157308:
	ldr r0, [r6, #0x370]
	bl ovl02_2155DEC
	mov r4, r0
	ldr r0, [r6, #0x370]
	bl ovl02_2155E04
	mov r1, r5, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r3, r0
	mov r2, r2, lsl #1
	mov r1, r1, lsl #1
	ldr r7, [r10, #0x1c]
	ldr r0, [r10, #0xc]
	ldr r6, [r7, #0x44]
	ldr ip, [r7, #0x48]
	add r6, r6, r0
	ldr r7, [r10, #0x10]
	mov r0, r9
	add r7, ip, r7
	ldr ip, _02157468 // =FX_SinCosTable_
	ldrsh r2, [ip, r2]
	ldrsh ip, [ip, r1]
	smull r2, r1, r4, r2
	smull ip, r4, r3, ip
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	rsb r1, r2, #0
	adds r3, ip, #0x800
	adc r2, r4, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	rsb r2, r3, #0
	bl Player__Action_Spring
	cmp r5, #0x8000
	bhs _021573D4
	ldrsh r2, [r10]
	ldrsh r0, [r8, #6]
	ldr r1, [r9, #0x44]
	add r2, r6, r2, lsl #12
	add r0, r1, r0, lsl #12
	sub r1, r2, r0
	mov r0, #0xa000
	rsb r0, r0, #0
	str r1, [r9, #0xb0]
	cmp r1, r0
	strgt r0, [r9, #0xb0]
	b _021573FC
_021573D4:
	ldrsh r2, [r10, #6]
	ldrsh r0, [r8]
	ldr r1, [r9, #0x44]
	add r2, r6, r2, lsl #12
	add r0, r1, r0, lsl #12
	sub r0, r2, r0
	str r0, [r9, #0xb0]
	cmp r0, #0xa000
	movlt r0, #0xa000
	strlt r0, [r9, #0xb0]
_021573FC:
	cmp r5, #0x4000
	blo _02157438
	cmp r5, #0xc000
	bhs _02157438
	ldrsh r2, [r10, #8]
	ldrsh r0, [r8, #2]
	ldr r1, [r9, #0x48]
	add r2, r7, r2, lsl #12
	add r0, r1, r0, lsl #12
	sub r0, r2, r0
	str r0, [r9, #0xb4]
	cmp r0, #0xa000
	movlt r0, #0xa000
	strlt r0, [r9, #0xb4]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02157438:
	ldrsh r2, [r10, #2]
	ldrsh r0, [r8, #8]
	ldr r1, [r9, #0x48]
	add r2, r7, r2, lsl #12
	add r0, r1, r0, lsl #12
	sub r1, r2, r0
	mov r0, #0xa000
	rsb r0, r0, #0
	str r1, [r9, #0xb4]
	cmp r1, r0
	strgt r0, [r9, #0xb4]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02157468: .word FX_SinCosTable_
	arm_func_end ovl02_215727C

	arm_func_start ovl02_215746C
ovl02_215746C: // 0x0215746C
	mov r2, #0
	ldr r1, _02157480 // =ovl02_2157690
	str r2, [r0, #0x3c0]
	str r1, [r0, #0x3bc]
	bx lr
	.align 2, 0
_02157480: .word ovl02_2157690
	arm_func_end ovl02_215746C

	arm_func_start ovl02_2157484
ovl02_2157484: // 0x02157484
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	add r1, r5, #0x374
	mov r0, #0
	mov r2, #4
	bl MIi_CpuClear16
	add r0, r5, #0x300
	strh r4, [r0, #0x74]
	mov r0, #1
	str r0, [r5, #0x3c0]
	ldr r1, _021574C4 // =ovl02_21576B0
	mov r0, r5
	str r1, [r5, #0x3bc]
	blx r1
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021574C4: .word ovl02_21576B0
	arm_func_end ovl02_2157484

	arm_func_start ovl02_21574C8
ovl02_21574C8: // 0x021574C8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add r6, r0, #0x374
	str r0, [sp]
	mov r1, r6
	mov r0, #0
	mov r2, #0x48
	bl MIi_CpuClear16
	ldr r0, _021575B4 // =gameState
	ldr r3, _021575B8 // =_mt_math_rand
	ldr r0, [r0, #0x18]
	ldr r4, [r3]
	cmp r0, #0
	ldr r0, _021575BC // =0x00196225
	ldr r2, _021575C0 // =0x3C6EF35F
	ldreq r7, _021575C4 // =_02179558
	mla r2, r4, r0, r2
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r1, #3
	mov r0, r0, lsr #0x10
	ldrne r7, _021575C8 // =_02179574
	mov r10, #7
	str r2, [r3]
	bl FX_ModS32
	add r0, r0, #2
	mov r0, r0, lsl #0x10
	movs r8, r0, lsr #0x10
	mov r9, #0
	beq _02157584
	ldr r5, _021575B8 // =_mt_math_rand
	ldr r11, _021575BC // =0x00196225
	ldr r4, _021575C0 // =0x3C6EF35F
_02157548:
	ldr r0, [r5]
	mov r1, r10
	mla r2, r0, r11, r4
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	str r2, [r5]
	mov r0, r0, lsr #0x10
	bl FX_ModS32
	add r1, r9, #1
	ldr r2, [r7, r0, lsl #2]
	mov r0, r1, lsl #0x10
	str r2, [r6, r9, lsl #2]
	cmp r8, r0, lsr #16
	mov r9, r0, lsr #0x10
	bhi _02157548
_02157584:
	ldr r1, [r6]
	add r0, r6, #0x24
	mov r2, #0x10
	bl BossHelpers__Unknown2038AEC__Init
	ldr r0, [sp]
	mov r1, #2
	str r1, [r0, #0x3c0]
	ldr r2, _021575CC // =ovl02_2157C4C
	mov r1, r0
	str r2, [r1, #0x3bc]
	blx r2
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021575B4: .word gameState
_021575B8: .word _mt_math_rand
_021575BC: .word 0x00196225
_021575C0: .word 0x3C6EF35F
_021575C4: .word _02179558
_021575C8: .word _02179574
_021575CC: .word ovl02_2157C4C
	arm_func_end ovl02_21574C8

	arm_func_start ovl02_21575D0
ovl02_21575D0: // 0x021575D0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	add r1, r5, #0x374
	mov r0, #0
	mov r2, #0xc
	bl MIi_CpuClear16
	ldr r1, _0215760C // =ovl02_21580AC
	str r4, [r5, #0x374]
	mov r0, #3
	str r0, [r5, #0x3c0]
	mov r0, r5
	str r1, [r5, #0x3bc]
	blx r1
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215760C: .word ovl02_21580AC
	arm_func_end ovl02_21575D0

	arm_func_start ovl02_2157610
ovl02_2157610: // 0x02157610
	stmdb sp!, {r3, lr}
	mov r2, #4
	ldr r1, _0215762C // =ovl02_21582D0
	str r2, [r0, #0x3c0]
	str r1, [r0, #0x3bc]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215762C: .word ovl02_21582D0
	arm_func_end ovl02_2157610

	arm_func_start ovl02_2157630
ovl02_2157630: // 0x02157630
	stmdb sp!, {r3, lr}
	mov r2, #5
	ldr r1, _0215764C // =ovl02_2159218
	str r2, [r0, #0x3c0]
	str r1, [r0, #0x3bc]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215764C: .word ovl02_2159218
	arm_func_end ovl02_2157630

	arm_func_start ovl02_2157650
ovl02_2157650: // 0x02157650
	stmdb sp!, {r3, lr}
	mov r2, #6
	ldr r1, _0215766C // =ovl02_21599E0
	str r2, [r0, #0x3c0]
	str r1, [r0, #0x3bc]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215766C: .word ovl02_21599E0
	arm_func_end ovl02_2157650

	arm_func_start ovl02_2157670
ovl02_2157670: // 0x02157670
	stmdb sp!, {r3, lr}
	mov r2, #7
	ldr r1, _0215768C // =ovl02_2159DB4
	str r2, [r0, #0x3c0]
	str r1, [r0, #0x3bc]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215768C: .word ovl02_2159DB4
	arm_func_end ovl02_2157670

	arm_func_start ovl02_2157690
ovl02_2157690: // 0x02157690
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x370]
	ldr r1, [r1, #0x388]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	mov r1, #0
	bl ovl02_2157484
	ldmia sp!, {r3, pc}
	arm_func_end ovl02_2157690

	arm_func_start ovl02_21576B0
ovl02_21576B0: // 0x021576B0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x230]
	add r0, r4, #0x400
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	orr r1, r1, #4
	str r1, [r4, #0x270]
	ldrh r0, [r0, #0x2c]
	cmp r0, #0
	bne _021576F0
	ldr r0, [r4, #0x370]
	bl ovl02_2155E38
	add r1, r4, #0x400
	strh r0, [r1, #0x2c]
_021576F0:
	ldr r0, _021576FC // =ovl02_2157700
	str r0, [r4, #0x3bc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021576FC: .word ovl02_2157700
	arm_func_end ovl02_21576B0

	arm_func_start ovl02_2157700
ovl02_2157700: // 0x02157700
	stmdb sp!, {r3, r4, r5, lr}
	mov r1, #0xa3
	mov r5, r0
	mov ip, #0x10000
	mov r2, r1
	mov r3, #0x1000
	str ip, [sp]
	add r4, r5, #0x374
	bl ovl02_2156ACC
	add r1, r5, #0x300
	ldrh r1, [r1, #0x74]
	cmp r1, #0
	subne r0, r1, #1
	strneh r0, [r4]
	ldmneia sp!, {r3, r4, r5, pc}
	cmp r0, #0
	ldrne r0, _0215774C // =ovl02_2157750
	strne r0, [r5, #0x3bc]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215774C: .word ovl02_2157750
	arm_func_end ovl02_2157700

	arm_func_start ovl02_2157750
ovl02_2157750: // 0x02157750
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r0, [r4, #0x370]
	bl ovl02_21558E8
	cmp r0, #0
	beq _021577A0
	ldr r0, [r4, #0x370]
	bl ovl02_2155C88
	mov r5, r0
	ldr r0, [r4, #0x370]
	bl ovl02_2155E1C
	add r1, r4, #0x400
	add r0, r5, r0
	ldrh r1, [r1, #0x24]
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	ldmhsia sp!, {r4, r5, r6, pc}
	mov r0, r4
	bl ovl02_2157630
	ldmia sp!, {r4, r5, r6, pc}
_021577A0:
	add r1, r4, #0x14
	ldr r0, [r4, #0x370]
	add r1, r1, #0x400
	bl ovl02_215566C
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r4, r5, r6, pc}
_021577BC: // jump table
	b _021577D0 // case 0
	b _021577E0 // case 1
	b _021577F8 // case 2
	b _02157804 // case 3
	b _02157854 // case 4
_021577D0:
	ldr r1, _021578E0 // =_02178AAC
	mov r0, r4
	bl ovl02_21574C8
	ldmia sp!, {r4, r5, r6, pc}
_021577E0:
	ldr r0, [r4, #0x370]
	bl ovl02_2155CCC
	mov r1, r0
	mov r0, r4
	bl ovl02_21575D0
	ldmia sp!, {r4, r5, r6, pc}
_021577F8:
	mov r0, r4
	bl ovl02_2157610
	ldmia sp!, {r4, r5, r6, pc}
_02157804:
	ldr r2, _021578E4 // =_mt_math_rand
	ldr r0, _021578E8 // =0x00196225
	ldr r3, [r2]
	ldr r1, _021578EC // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	movne r1, #0
	ldr r0, [r4, #0x370]
	moveq r1, #1
	add r1, r0, r1, lsl #2
	ldr r4, [r1, #0x374]
	bl ovl02_2155B40
	mov r1, r0
	mov r0, r4
	bl ovl02_215A5D8
	ldmia sp!, {r4, r5, r6, pc}
_02157854:
	ldr r2, _021578E4 // =_mt_math_rand
	ldr r0, _021578E8 // =0x00196225
	ldr r3, [r2]
	ldr r1, _021578EC // =0x3C6EF35F
	mla r5, r3, r0, r1
	mov r0, r5, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	str r5, [r2]
	ldr r0, _021578E8 // =0x00196225
	ldr r1, _021578EC // =0x3C6EF35F
	movne r6, #0
	mla r2, r5, r0, r1
	mla r3, r2, r0, r1
	mov r0, r2, lsr #0x10
	mov r1, r3, lsr #0x10
	ldr ip, [r4, #0x370]
	moveq r6, #1
	add ip, ip, r6, lsl #2
	mov r0, r0, lsl #0x10
	ldr r5, [ip, #0x374]
	ldr r2, _021578E4 // =_mt_math_rand
	mov r1, r1, lsl #0x10
	str r3, [r2]
	mov r6, r0, lsr #0x10
	ldr r0, [r4, #0x370]
	mov r4, r1, lsr #0x10
	bl ovl02_2155B80
	mov r3, r0
	mov r0, r5
	and r1, r4, #1
	and r2, r6, #1
	bl ovl02_215A618
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021578E0: .word _02178AAC
_021578E4: .word _mt_math_rand
_021578E8: .word 0x00196225
_021578EC: .word 0x3C6EF35F
	arm_func_end ovl02_2157750

	arm_func_start ovl02_21578F0
ovl02_21578F0: // 0x021578F0
	stmdb sp!, {r4, lr}
	ldr r4, _02157984 // =_mt_math_rand
	ldr r2, _02157988 // =0x00196225
	ldr ip, [r4]
	ldr r3, _0215798C // =0x3C6EF35F
	ldr lr, _02157990 // =0x000007FF
	mla r1, ip, r2, r3
	mov ip, r1, lsr #0x10
	mov ip, ip, lsl #0x10
	str r1, [r4]
	and ip, lr, ip, lsr #16
	add ip, ip, #0x31c
	ldrh lr, [r0, #0x42]
	add ip, ip, #0x400
	mov ip, ip, lsl #0x10
	cmp lr, #0
	mov ip, ip, lsr #0x10
	bne _02157964
	mla r2, r1, r2, r3
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r2, [r4]
	tst r1, #1
	beq _0215797C
	rsb r1, ip, #0
	mov r1, r1, lsl #0x10
	mov ip, r1, lsr #0x10
	b _0215797C
_02157964:
	mov r1, lr, lsl #0x10
	mov r1, r1, asr #0x10
	cmp r1, #0
	rsbgt r1, ip, #0
	movgt r1, r1, lsl #0x10
	movgt ip, r1, lsr #0x10
_0215797C:
	strh ip, [r0, #0x42]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157984: .word _mt_math_rand
_02157988: .word 0x00196225
_0215798C: .word 0x3C6EF35F
_02157990: .word 0x000007FF
	arm_func_end ovl02_21578F0

	arm_func_start ovl02_2157994
ovl02_2157994: // 0x02157994
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r1, #4
	str r1, [sp]
	mov r2, #0x5b
	ldr r1, _02157A18 // =0x00000222
	str r2, [sp, #4]
	mov r4, r0
	str r1, [sp, #8]
	ldrsh r0, [r4, #0x40]
	ldrsh r1, [r4, #0x42]
	ldrsh r2, [r4, #0x44]
	mov r3, #0xa
	bl BossHelpers__Math__Func_20392BC
	strh r0, [r4, #0x44]
	ldrh r1, [r4, #0x40]
	ldrsh r0, [r4, #0x44]
	add r0, r1, r0
	strh r0, [r4, #0x40]
	ldrh r1, [r4, #0x42]
	ldrh r0, [r4, #0x40]
	sub r0, r1, r0
	mov r0, r0, lsl #0x10
	movs r1, r0, asr #0x10
	ldr r0, _02157A18 // =0x00000222
	rsbmi r1, r1, #0
	cmp r1, r0
	addge sp, sp, #0xc
	ldmgeia sp!, {r3, r4, pc}
	mov r0, r4
	bl ovl02_21578F0
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02157A18: .word 0x00000222
	arm_func_end ovl02_2157994

	arm_func_start ovl02_2157A1C
ovl02_2157A1C: // 0x02157A1C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r3, #0x10
	str r3, [sp]
	mov r1, #0x5b
	str r1, [sp, #4]
	str r1, [sp, #8]
	mov r4, r0
	ldrsh r0, [r4, #0x40]
	ldrsh r2, [r4, #0x44]
	mov r1, #0
	bl BossHelpers__Math__Func_20392BC
	strh r0, [r4, #0x44]
	ldrh r1, [r4, #0x40]
	ldrsh r0, [r4, #0x44]
	add r0, r1, r0
	strh r0, [r4, #0x40]
	ldrh r0, [r4, #0x40]
	rsb r0, r0, #0
	mov r0, r0, lsl #0x10
	movs r0, r0, asr #0x10
	rsbmi r0, r0, #0
	cmp r0, #0x5b
	bge _02157AA8
	ldrsh r0, [r4, #0x44]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x5b
	bge _02157AA8
	mov r0, #0
	strh r0, [r4, #0x44]
	strh r0, [r4, #0x40]
	add sp, sp, #0xc
	mov r0, #1
	ldmia sp!, {r3, r4, pc}
_02157AA8:
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	arm_func_end ovl02_2157A1C

	arm_func_start ovl02_2157AB4
ovl02_2157AB4: // 0x02157AB4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x48
	mov r5, r0
	add r4, r5, #0x374
	ldrh r1, [r4, #0x40]
	ldr r3, _02157B80 // =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	blx MTX_RotY33_
	ldrh r1, [r4, #0x40]
	ldr r3, _02157B80 // =FX_SinCosTable_
	add r0, sp, #0x24
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	blx MTX_RotZ33_
	add r2, r5, #0x238
	add r0, sp, #0x24
	add r1, sp, #0
	add r2, r2, #0x400
	bl MTX_Concat33
	ldrh r2, [r4, #0x40]
	ldr r0, _02157B80 // =FX_SinCosTable_
	mov r1, #0
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r2, [r0, r2]
	mov r0, #0x1800
	ldr ip, [r5, #0x44]
	umull r4, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r1, r4, #0x800
	adc r0, r3, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	sub r0, ip, r1
	str r0, [r5, #0x44]
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02157B80: .word FX_SinCosTable_
	arm_func_end ovl02_2157AB4

	arm_func_start ovl02_2157B84
ovl02_2157B84: // 0x02157B84
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x38]
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x24
	bl BossHelpers__Unknown2038AEC__Func_2038B7C
	ldr r2, [r4, #0x38]
	mov r1, #0x320000
	ldr r2, [r2, #0x4c]
	ldr r0, [r0, #0xc]
	rsb r1, r1, #0
	sub r0, r2, r0
	cmp r0, r1
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_2157B84

	arm_func_start ovl02_2157BCC
ovl02_2157BCC: // 0x02157BCC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	add r0, r5, #0x398
	bl BossHelpers__Unknown2038AEC__Func_2038B7C
	mov r4, r0
	ldr r1, [r5, #0x428]
	ldr r0, [r5, #0x370]
	cmp r1, #0
	ldr r1, [r4, #4]
	ldr r2, [r4, #8]
	movne r1, #1
	bl ovl02_215B8D0
	ldr r1, [r5, #0x3ac]
	cmp r1, #0
	beq _02157C1C
	ldr r2, [r1, #0x4c]
	ldr r1, [r4, #0xc]
	sub r1, r2, r1
	str r1, [r0, #0x4c]
_02157C1C:
	str r0, [r5, #0x3ac]
	add r2, sp, #0
	mov r0, r5
	mov r1, #0xa000
	bl ovl02_2155354
	ldr r1, [sp]
	ldr r2, [sp, #4]
	ldr r3, [sp, #8]
	mov r0, #0
	bl BossFX__CreateCondorFire
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end ovl02_2157BCC

	arm_func_start ovl02_2157C4C
ovl02_2157C4C: // 0x02157C4C
	mov r2, #1
	ldr r1, _02157C60 // =ovl02_2157C64
	str r2, [r0, #0x428]
	str r1, [r0, #0x3bc]
	bx lr
	.align 2, 0
_02157C60: .word ovl02_2157C64
	arm_func_end ovl02_2157C4C

	arm_func_start ovl02_2157C64
ovl02_2157C64: // 0x02157C64
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0x98]
	str r1, [r4, #0x9c]
	str r1, [r4, #0xa0]
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x214
	ldr r2, [r4, #0x75c]
	add r0, r0, #0x400
	mov r3, #3
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02157CAC // =ovl02_2157CB0
	str r0, [r4, #0x3bc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157CAC: .word ovl02_2157CB0
	arm_func_end ovl02_2157C64

	arm_func_start ovl02_2157CB0
ovl02_2157CB0: // 0x02157CB0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x214
	add r0, r0, #0x400
	mov r1, #0
	bl BossHelpers__Animation__Func_2038C44
	cmp r0, #0
	ldrne r0, _02157CD8 // =ovl02_2157CDC
	strne r0, [r4, #0x3bc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157CD8: .word ovl02_2157CDC
	arm_func_end ovl02_2157CB0

	arm_func_start ovl02_2157CDC
ovl02_2157CDC: // 0x02157CDC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r4, r5, #0x374
	mov r0, r4
	bl ovl02_2157994
	mov r0, r5
	bl ovl02_2157AB4
	mov r2, #0x10000
	mov r1, #0xa3
	mov r0, r5
	str r2, [sp]
	mov r2, r1
	mov r3, #0x1000
	bl ovl02_2156ACC
	ldr r0, [r5, #0x370]
	bl ovl02_21558E8
	cmp r0, #0
	beq _02157D38
	add r0, r4, #0x24
	bl BossHelpers__Unknown2038AEC__Func_2038B24
	ldr r0, _02157E28 // =ovl02_2157E2C
	str r0, [r5, #0x3bc]
	ldmia sp!, {r3, r4, r5, pc}
_02157D38:
	ldr r0, [r4, #0x38]
	cmp r0, #0
	beq _02157D54
	ldr r0, [r0, #0x18]
	tst r0, #8
	movne r0, #0
	strne r0, [r4, #0x38]
_02157D54:
	ldr r0, [r4, #0x3c]
	cmp r0, #0
	beq _02157D84
	mov r0, r4
	bl ovl02_2157B84
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl ovl02_2157BCC
	mov r0, #0
	str r0, [r4, #0x3c]
	ldmia sp!, {r3, r4, r5, pc}
_02157D84:
	add r0, r4, #0x24
	bl BossHelpers__Unknown2038AEC__Func_2038B28
	cmp r0, #1
	beq _02157DA0
	cmp r0, #2
	beq _02157DC4
	ldmia sp!, {r3, r4, r5, pc}
_02157DA0:
	mov r0, r4
	bl ovl02_2157B84
	cmp r0, #0
	moveq r0, #1
	streq r0, [r4, #0x3c]
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl ovl02_2157BCC
	ldmia sp!, {r3, r4, r5, pc}
_02157DC4:
	add r0, r4, #0x24
	bl BossHelpers__Unknown2038AEC__Func_2038B24
	ldrh r0, [r4, #0x20]
	add r0, r0, #1
	strh r0, [r4, #0x20]
	ldr r0, [r5, #0x428]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	str r0, [r5, #0x428]
	ldrh r0, [r4, #0x20]
	cmp r0, #8
	bhs _02157E04
	ldr r1, [r4, r0, lsl #2]
	cmp r1, #0
	bne _02157E10
_02157E04:
	ldr r0, _02157E28 // =ovl02_2157E2C
	str r0, [r5, #0x3bc]
	ldmia sp!, {r3, r4, r5, pc}
_02157E10:
	add r0, r4, #0x24
	mov r2, #0x10
	bl BossHelpers__Unknown2038AEC__Init
	mov r0, #0
	str r0, [r4, #0x38]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02157E28: .word ovl02_2157E2C
	arm_func_end ovl02_2157CDC

	arm_func_start ovl02_2157E2C
ovl02_2157E2C: // 0x02157E2C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x214
	ldr r2, [r4, #0x75c]
	add r0, r0, #0x400
	mov r3, #4
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02157E68 // =ovl02_2157E6C
	str r0, [r4, #0x3bc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157E68: .word ovl02_2157E6C
	arm_func_end ovl02_2157E2C

	arm_func_start ovl02_2157E6C
ovl02_2157E6C: // 0x02157E6C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0x374
	bl ovl02_2157A1C
	mov r4, r0
	mov r0, r5
	bl ovl02_2157AB4
	mov r2, #0x10000
	mov r1, #0xa3
	str r2, [sp]
	mov r0, r5
	mov r2, r1
	mov r3, #0x1000
	bl ovl02_2156ACC
	add r0, r5, #0x214
	add r0, r0, #0x400
	mov r1, #0
	bl BossHelpers__Animation__Func_2038C44
	cmp r0, #0
	cmpne r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x370]
	bl ovl02_2155AB8
	mov r1, r0
	mov r0, r5
	bl ovl02_2157484
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_2157E6C

	arm_func_start ovl02_2157ED8
ovl02_2157ED8: // 0x02157ED8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r3, #0x10
	mov r1, #0xb6
	str r3, [sp]
	str r1, [sp, #4]
	add r1, r1, #0x2d8
	mov r4, r0
	str r1, [sp, #8]
	ldrsh r0, [r4, #6]
	ldrsh r1, [r4, #8]
	ldrsh r2, [r4, #0xa]
	bl BossHelpers__Math__Func_20392BC
	strh r0, [r4, #0xa]
	ldrh r1, [r4, #6]
	ldrsh r0, [r4, #0xa]
	add r0, r1, r0
	strh r0, [r4, #6]
	ldrh r1, [r4, #8]
	ldrh r0, [r4, #6]
	sub r0, r1, r0
	mov r0, r0, lsl #0x10
	movs r1, r0, asr #0x10
	ldr r0, _02157F64 // =0x0000038E
	rsbmi r1, r1, #0
	cmp r1, r0
	bge _02157F58
	ldrsh r0, [r4, #0xa]
	cmp r0, #0
	addeq sp, sp, #0xc
	moveq r0, #1
	ldmeqia sp!, {r3, r4, pc}
_02157F58:
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02157F64: .word 0x0000038E
	arm_func_end ovl02_2157ED8

	arm_func_start ovl02_2157F68
ovl02_2157F68: // 0x02157F68
	stmdb sp!, {r3, lr}
	add r1, r0, #0x300
	ldrh r1, [r1, #0x7a]
	add r0, r0, #0x238
	ldr r3, _02157FA4 // =FX_SinCosTable_
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	add r0, r0, #0x400
	blx MTX_RotY33_
	ldmia sp!, {r3, pc}
	.align 2, 0
_02157FA4: .word FX_SinCosTable_
	arm_func_end ovl02_2157F68

	arm_func_start ovl02_2157FA8
ovl02_2157FA8: // 0x02157FA8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r3, #0x10
	str r3, [sp]
	mov r1, #0x5b
	str r1, [sp, #4]
	str r1, [sp, #8]
	mov r4, r0
	ldrsh r0, [r4, #6]
	ldrsh r2, [r4, #0xa]
	mov r1, #0
	bl BossHelpers__Math__Func_20392BC
	strh r0, [r4, #0xa]
	ldrh r1, [r4, #6]
	ldrsh r0, [r4, #0xa]
	add r0, r1, r0
	strh r0, [r4, #6]
	ldrh r0, [r4, #6]
	rsb r0, r0, #0
	mov r0, r0, lsl #0x10
	movs r0, r0, asr #0x10
	rsbmi r0, r0, #0
	cmp r0, #0x5b
	bge _02158034
	ldrsh r0, [r4, #0xa]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x5b
	bge _02158034
	mov r0, #0
	strh r0, [r4, #0xa]
	strh r0, [r4, #6]
	add sp, sp, #0xc
	mov r0, #1
	ldmia sp!, {r3, r4, pc}
_02158034:
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	arm_func_end ovl02_2157FA8

	arm_func_start ovl02_2158040
ovl02_2158040: // 0x02158040
	stmdb sp!, {r3, lr}
	ldrh r2, [r0, #4]
	ldr r1, [r0]
	ldr r0, _02158078 // =0x00002AAA
	add r2, r2, #1
	mul r0, r2, r0
	ldrh r1, [r1, #4]
	add r1, r1, #1
	bl FX_DivS32
	ldr r1, _0215807C // =0x00001555
	sub r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, pc}
	.align 2, 0
_02158078: .word 0x00002AAA
_0215807C: .word 0x00001555
	arm_func_end ovl02_2158040

	arm_func_start ovl02_2158080
ovl02_2158080: // 0x02158080
	ldrh r2, [r0, #4]
	ldr r1, [r0]
	ldr r0, _021580A4 // =0x00107FC0
	add r2, r2, #1
	ldrh r1, [r1, #4]
	mul r0, r2, r0
	ldr ip, _021580A8 // =FX_DivS32
	add r1, r1, #1
	bx ip
	.align 2, 0
_021580A4: .word 0x00107FC0
_021580A8: .word FX_DivS32
	arm_func_end ovl02_2158080

	arm_func_start ovl02_21580AC
ovl02_21580AC: // 0x021580AC
	ldr r1, _021580B8 // =ovl02_21580BC
	str r1, [r0, #0x3bc]
	bx lr
	.align 2, 0
_021580B8: .word ovl02_21580BC
	arm_func_end ovl02_21580AC

	arm_func_start ovl02_21580BC
ovl02_21580BC: // 0x021580BC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, _02158110 // =0x00001555
	add r0, r4, #0x300
	strh r1, [r0, #0x7c]
	mov r1, #0
	str r1, [r4, #0x98]
	str r1, [r4, #0x9c]
	str r1, [r4, #0xa0]
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x214
	ldr r2, [r4, #0x75c]
	add r0, r0, #0x400
	mov r3, #3
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02158114 // =ovl02_2158118
	str r0, [r4, #0x3bc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158110: .word 0x00001555
_02158114: .word ovl02_2158118
	arm_func_end ovl02_21580BC

	arm_func_start ovl02_2158118
ovl02_2158118: // 0x02158118
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0x374
	bl ovl02_2157ED8
	mov r4, r0
	mov r0, r5
	bl ovl02_2157F68
	add r0, r5, #0x214
	add r0, r0, #0x400
	mov r1, #0
	bl BossHelpers__Animation__Func_2038C44
	cmp r0, #0
	cmpne r4, #0
	ldrne r0, _02158158 // =ovl02_215815C
	strne r0, [r5, #0x3bc]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02158158: .word ovl02_215815C
	arm_func_end ovl02_2158118

	arm_func_start ovl02_215815C
ovl02_215815C: // 0x0215815C
	ldr r3, _02158174 // =0x0000EAAB
	add r1, r0, #0x300
	ldr r2, _02158178 // =ovl02_215817C
	strh r3, [r1, #0x7c]
	str r2, [r0, #0x3bc]
	bx lr
	.align 2, 0
_02158174: .word 0x0000EAAB
_02158178: .word ovl02_215817C
	arm_func_end ovl02_215815C

	arm_func_start ovl02_215817C
ovl02_215817C: // 0x0215817C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #0x370]
	add r4, r6, #0x374
	bl ovl02_21558E8
	cmp r0, #0
	ldrne r0, _02158220 // =ovl02_2158224
	strne r0, [r6, #0x3bc]
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r4
	bl ovl02_2157ED8
	mov r5, r0
	mov r0, r6
	bl ovl02_2157F68
	ldr r0, [r4]
	ldrh r1, [r4, #4]
	ldrh r0, [r0, #4]
	cmp r1, r0
	bhs _02158210
	mov r0, r4
	bl ovl02_2158040
	ldrsh r1, [r4, #6]
	mov r0, r0, lsl #0x10
	cmp r1, r0, asr #16
	bgt _02158210
	mov r0, r4
	bl ovl02_2158080
	ldr r3, [r4]
	mov r2, r0
	ldrh r1, [r4, #4]
	ldr r3, [r3]
	ldr r0, [r6, #0x370]
	ldr r1, [r3, r1, lsl #2]
	bl ovl02_215B9E0
	ldrh r0, [r4, #4]
	add r0, r0, #1
	strh r0, [r4, #4]
_02158210:
	cmp r5, #0
	ldrne r0, _02158220 // =ovl02_2158224
	strne r0, [r6, #0x3bc]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02158220: .word ovl02_2158224
	arm_func_end ovl02_215817C

	arm_func_start ovl02_2158224
ovl02_2158224: // 0x02158224
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov ip, #0x98
	sub r1, ip, #0x99
	mov r4, r0
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x214
	ldr r2, [r4, #0x75c]
	add r0, r0, #0x400
	mov r3, #4
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _0215827C // =ovl02_2158280
	str r0, [r4, #0x3bc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215827C: .word ovl02_2158280
	arm_func_end ovl02_2158224

	arm_func_start ovl02_2158280
ovl02_2158280: // 0x02158280
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0x374
	bl ovl02_2157FA8
	mov r4, r0
	mov r0, r5
	bl ovl02_2157F68
	add r0, r5, #0x214
	add r0, r0, #0x400
	mov r1, #0
	bl BossHelpers__Animation__Func_2038C44
	cmp r0, #0
	cmpne r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x370]
	bl ovl02_2155AB8
	mov r1, r0
	mov r0, r5
	bl ovl02_2157484
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_2158280

	arm_func_start ovl02_21582D0
ovl02_21582D0: // 0x021582D0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r1, r4, #0x374
	mov r0, #0
	mov r2, #0x28
	bl MIi_CpuClear16
	ldr r1, [r4, #0x230]
	mov r0, #0
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	str r0, [r4, #0x98]
	str r0, [r4, #0x9c]
	str r0, [r4, #0xa0]
	ldr r0, [r4, #0x370]
	bl ovl02_2155EB4
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #0x64000
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #0x80
	bl BossArena__SetAmplitudeYSpeed
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x214
	add r0, r0, #0x400
	ldr r2, [r4, #0x75c]
	mov r3, #5
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02158370 // =ovl02_2158374
	str r0, [r4, #0x3bc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158370: .word ovl02_2158374
	arm_func_end ovl02_21582D0

	arm_func_start ovl02_2158374
ovl02_2158374: // 0x02158374
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r4, r5, #0x374
	add r0, r5, #0x44
	add r3, r4, #0xc
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r3, [r4, #0xc]
	ldr r0, _02158458 // =0x00083FE0
	mov r1, #0x800
	sub r2, r0, r3
	mov r0, r2, asr #0x1f
	mov r0, r0, lsl #0xb
	adds r1, r1, r2, lsl #11
	orr r0, r0, r2, lsr #21
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r1, r3, r1
	ldr r0, _0215845C // =Boss6Stage__Singleton
	str r1, [r4, #0x18]
	ldr r0, [r0]
	bl GetTaskWork_
	ldr r0, [r0, #0x38c]
	ldr lr, [r4, #0x10]
	rsb r0, r0, #0
	sub r0, r0, #0x50000
	sub r2, r0, lr
	mov r0, r2, asr #0x1f
	mov r0, r0, lsl #0xb
	mov r1, #0x800
	adds ip, r1, r2, lsl #11
	orr r0, r0, r2, lsr #21
	adc r0, r0, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r0, lsl #20
	add r0, lr, ip
	str r0, [r4, #0x1c]
	mov r3, #0
	ldr lr, [r4, #0x14]
	sub r0, r3, #0x1f4000
	sub ip, r0, lr
	adds r0, r1, ip, lsl #11
	mov r1, r0, lsr #0xc
	mov r0, ip, asr #0x1f
	mov r0, r0, lsl #0xb
	orr r0, r0, ip, lsr #21
	adc r0, r0, #0
	orr r1, r1, r0, lsl #20
	add r0, lr, r1
	str r0, [r4, #0x20]
	ldr r2, _02158460 // =ovl02_2158464
	strh r3, [r4, #0xa]
	mov r0, r5
	str r2, [r5, #0x3bc]
	blx r2
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02158458: .word 0x00083FE0
_0215845C: .word Boss6Stage__Singleton
_02158460: .word ovl02_2158464
	arm_func_end ovl02_2158374

	arm_func_start ovl02_2158464
ovl02_2158464: // 0x02158464
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r4, r0
	add r0, r4, #0x374
	ldrsh r1, [r0, #0xa]
	mov r5, #0
	mov r2, #2
	add r1, r1, #0x51
	strh r1, [r0, #0xa]
	ldrsh r1, [r0, #0xa]
	mov lr, #0
	mov r6, #0x800
	cmp r1, #0x1000
	movgt r1, #0x1000
	strgth r1, [r0, #0xa]
	ldrsh ip, [r0, #0xa]
	ldr r7, [r0, #0x18]
	ldr r1, [r0, #0xc]
	movgt r5, #1
	mov r3, ip, asr #0x1f
_021584B0:
	sub r7, r7, r1
	umull r9, r8, r7, ip
	mla r8, r7, r3, r8
	mov r7, r7, asr #0x1f
	mla r8, r7, ip, r8
	adds r9, r9, r6
	adc r7, r8, lr
	mov r8, r9, lsr #0xc
	orr r8, r8, r7, lsl #20
	cmp r2, #0
	add r7, r1, r8
	sub r2, r2, #1
	bne _021584B0
	str r7, [r4, #0x44]
	ldrsh ip, [r0, #0xa]
	ldr r7, [r0, #0x1c]
	ldr r1, [r0, #0x10]
	mov r3, ip, asr #0x1f
	mov r2, #2
	mov lr, #0
	mov r6, #0x800
_02158504:
	sub r7, r7, r1
	umull r9, r8, r7, ip
	mla r8, r7, r3, r8
	mov r7, r7, asr #0x1f
	mla r8, r7, ip, r8
	adds r9, r9, r6
	adc r7, r8, lr
	mov r8, r9, lsr #0xc
	orr r8, r8, r7, lsl #20
	cmp r2, #0
	add r7, r1, r8
	sub r2, r2, #1
	bne _02158504
	str r7, [r4, #0x48]
	ldrsh ip, [r0, #0xa]
	ldr r7, [r0, #0x20]
	ldr r1, [r0, #0x14]
	mov r3, ip, asr #0x1f
	mov r2, #2
	mov r6, #0
	mov lr, #0x800
_02158558:
	sub r7, r7, r1
	umull r9, r8, r7, ip
	mla r8, r7, r3, r8
	mov r7, r7, asr #0x1f
	mla r8, r7, ip, r8
	adds r9, r9, lr
	adc r7, r8, r6
	mov r8, r9, lsr #0xc
	orr r8, r8, r7, lsl #20
	cmp r2, #0
	add r7, r1, r8
	sub r2, r2, #1
	bne _02158558
	str r7, [r4, #0x4c]
	ldrsh r0, [r0, #0xa]
	cmp r0, #0x800
	movge r0, #0xe000
	bge _021585B0
	mov r0, r0, lsl #0xe
	rsb r0, r0, #0
	mov r0, r0, lsl #4
	mov r0, r0, lsr #0x10
_021585B0:
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r2, r0, lsl #1
	ldr r3, _021585F4 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	add r0, r4, #0x238
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	add r0, r0, #0x400
	blx MTX_RotX33_
	cmp r5, #0
	ldrne r0, _021585F8 // =ovl02_21585FC
	strne r0, [r4, #0x3bc]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_021585F4: .word FX_SinCosTable_
_021585F8: .word ovl02_21585FC
	arm_func_end ovl02_2158464

	arm_func_start ovl02_21585FC
ovl02_21585FC: // 0x021585FC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r4, r5, #0x374
	add r0, r4, #0x18
	add ip, r4, #0xc
	ldmia r0, {r0, r1, r2}
	ldr r3, _021586B0 // =Boss6Stage__Singleton
	stmia ip, {r0, r1, r2}
	ldr r0, [r3]
	bl GetTaskWork_
	ldr r0, [r0, #0x38c]
	ldr r1, _021586B4 // =0x00083FE0
	rsb r2, r0, #0
	mov r0, #0x1f4000
	str r1, [r4, #0x18]
	sub r1, r2, #0x50000
	str r1, [r4, #0x1c]
	rsb r0, r0, #0
	str r0, [r4, #0x20]
	mov r0, #0
	strh r0, [r4, #0xa]
	ldr r0, [r5, #0x370]
	bl ovl02_2155FAC
	mov r0, #2
	bl BossArena__GetCamera
	mov r1, #0x1e000
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, #2
	bl BossArena__GetCamera
	mov r1, #0x80
	bl BossArena__SetAmplitudeYSpeed
	mov r0, #2
	bl BossArena__GetCamera
	mov r1, #0x96000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, #2
	bl BossArena__GetCamera
	mov r1, #0x80
	bl BossArena__SetAmplitudeYSpeed
	ldr r1, _021586B8 // =ovl02_21586BC
	mov r0, r5
	str r1, [r5, #0x3bc]
	blx r1
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021586B0: .word Boss6Stage__Singleton
_021586B4: .word 0x00083FE0
_021586B8: .word ovl02_21586BC
	arm_func_end ovl02_21585FC

	arm_func_start ovl02_21586BC
ovl02_21586BC: // 0x021586BC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r5, r0
	add r2, r5, #0x374
	ldrsh r0, [r2, #0xa]
	mov r4, #0
	mov lr, #2
	add r0, r0, #0x51
	strh r0, [r2, #0xa]
	ldrsh r0, [r2, #0xa]
	mov r9, #0
	mov r8, #0x800
	cmp r0, #0x1000
	movgt r0, #0x1000
	strgth r0, [r2, #0xa]
	ldrsh r7, [r2, #0xa]
	ldr ip, [r2, #0x18]
	ldr r3, [r2, #0xc]
	movgt r4, #1
	mov r6, r7, asr #0x1f
_02158708:
	sub r10, ip, r3
	umull r1, r0, r10, r7
	mla r0, r10, r6, r0
	mov r10, r10, asr #0x1f
	adds r1, r1, r8
	mla r0, r10, r7, r0
	adc r0, r0, r9
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	cmp lr, #0
	add r3, r3, r1
	sub lr, lr, #1
	bne _02158708
	str r3, [r5, #0x44]
	ldrsh r7, [r2, #0xa]
	ldr ip, [r2, #0x1c]
	ldr r3, [r2, #0x10]
	mov r6, r7, asr #0x1f
	mov lr, #2
	mov r9, #0
	mov r8, #0x800
_0215875C:
	sub r10, ip, r3
	umull r1, r0, r10, r7
	mla r0, r10, r6, r0
	mov r10, r10, asr #0x1f
	adds r1, r1, r8
	mla r0, r10, r7, r0
	adc r0, r0, r9
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	cmp lr, #0
	add r3, r3, r1
	sub lr, lr, #1
	bne _0215875C
	str r3, [r5, #0x48]
	ldrsh r7, [r2, #0xa]
	ldr ip, [r2, #0x20]
	ldr r3, [r2, #0x14]
	mov r6, r7, asr #0x1f
	mov lr, #2
	mov r9, #0
	mov r8, #0x800
_021587B0:
	sub r10, ip, r3
	umull r1, r0, r10, r7
	mla r0, r10, r6, r0
	mov r10, r10, asr #0x1f
	adds r1, r1, r8
	mla r0, r10, r7, r0
	adc r0, r0, r9
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	cmp lr, #0
	add r3, r3, r1
	sub lr, lr, #1
	bne _021587B0
	str r3, [r5, #0x4c]
	ldrsh r0, [r2, #0xa]
	ldr r2, _02158844 // =FX_SinCosTable_
	add r3, r5, #0x238
	rsb r0, r0, #0x1000
	mov r0, r0, lsl #0xd
	rsb r0, r0, #0
	mov r0, r0, lsl #4
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
	add r0, r3, #0x400
	blx MTX_RotX33_
	cmp r4, #0
	ldrne r0, _02158848 // =ovl02_215884C
	strne r0, [r5, #0x3bc]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02158844: .word FX_SinCosTable_
_02158848: .word ovl02_215884C
	arm_func_end ovl02_21586BC

	arm_func_start ovl02_215884C
ovl02_215884C: // 0x0215884C
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r1, [r4, #0x230]
	mov r0, #0x5000
	orr r1, r1, #4
	str r1, [r4, #0x230]
	rsb r0, r0, #0
	str r0, [r4, #0xa0]
	add r5, r4, #0x374
	mov r0, r0, asr #0xf
	strh r0, [r5, #6]
	add r1, r4, #0x300
	mov r0, #0
	strh r0, [r1, #0x74]
	strh r0, [r5, #2]
	strh r0, [r5, #4]
	bl BossFX__CreateCondorTackle
	str r0, [r5, #0x24]
	mov r0, #0
	strh r0, [r5, #8]
	ldr r1, _021588B0 // =ovl02_21588B4
	mov r0, r4
	str r1, [r4, #0x3bc]
	blx r1
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021588B0: .word ovl02_21588B4
	arm_func_end ovl02_215884C

	arm_func_start ovl02_21588B4
ovl02_21588B4: // 0x021588B4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x9c
	mov r5, r0
	ldr r2, [r5, #0xa0]
	add r4, r5, #0x374
	cmp r2, #0x6000
	bge _021588F8
	ldr r0, _02158BF8 // =0x00000333
	rsb r1, r2, #0x6000
	cmp r1, r0
	movle r0, #0x6000
	strle r0, [r5, #0xa0]
	ble _02158918
	add r0, r2, #0x33
	add r0, r0, #0x300
	str r0, [r5, #0xa0]
	b _02158918
_021588F8:
	ble _02158918
	ldr r0, _02158BF8 // =0x00000333
	sub r1, r2, #0x6000
	cmp r1, r0
	subgt r0, r2, r0
	strgt r0, [r5, #0xa0]
	movle r0, #0x6000
	strle r0, [r5, #0xa0]
_02158918:
	ldrh r1, [r4, #8]
	add r0, r1, #1
	strh r0, [r4, #8]
	cmp r1, #0x3c
	bne _02158948
	mov r6, #0x9b
	sub r1, r6, #0x9c
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r6}
	bl PlaySfxEx
_02158948:
	ldr r0, [r5, #0xa0]
	cmp r0, #0
	bge _02158974
	ldrh r1, [r4]
	ldr r0, _02158BFC // =0x00000E38
	add r1, r1, #0xb6
	strh r1, [r4]
	ldrh r1, [r4]
	cmp r1, r0
	strhih r0, [r4]
	b _02158990
_02158974:
	ldrh r0, [r4]
	sub r0, r0, #0x16
	strh r0, [r4]
	ldrsh r0, [r4]
	cmp r0, #0
	movlt r0, #0
	strlth r0, [r4]
_02158990:
	ldr r0, [r5, #0xa0]
	cmp r0, #0
	ble _021589E4
	ldrsh r0, [r4, #6]
	ldr r1, _02158C00 // =0xFFFFF778
	cmp r0, #0
	addgt r0, r0, #0x10
	suble r0, r0, #0x10
	strh r0, [r4, #6]
	ldrsh r2, [r4, #6]
	cmp r2, r1
	movlt r2, r1
	blt _021589D0
	rsb r0, r1, #0
	cmp r2, r0
	movgt r2, r0
_021589D0:
	strh r2, [r4, #6]
	ldrh r1, [r4, #4]
	ldrsh r0, [r4, #6]
	sub r0, r1, r0
	strh r0, [r4, #4]
_021589E4:
	mov r0, #0x12c000
	ldr r1, [r5, #0x4c]
	rsb r0, r0, #0
	cmp r1, r0
	ble _02158A90
	ldr r3, _02158C04 // =0x00000199
	mov r0, #0x1000
	str r3, [sp]
	str r0, [sp, #4]
	mov r0, #0x2000
	str r0, [sp, #8]
	ldr r1, _02158C08 // =gPlayer
	ldr r0, [r5, #0x44]
	ldr r1, [r1]
	ldr r2, [r5, #0x98]
	ldr r1, [r1, #0x44]
	sub r3, r3, #0x52
	bl BossHelpers__Math__Func_20392BC
	str r0, [r5, #0x98]
	ldrsh r0, [r4, #6]
	cmp r0, #0
	ldrh r0, [r4, #2]
	addgt r0, r0, #0xb6
	suble r0, r0, #0xb6
	strh r0, [r4, #2]
	mov r0, #0x3000
	ldr r1, [r5, #0x98]
	rsb r0, r0, #0
	cmp r1, r0
	movlt r1, r0
	blt _02158A68
	cmp r1, #0x3000
	movgt r1, #0x3000
_02158A68:
	str r1, [r5, #0x98]
	ldrsh r2, [r4, #2]
	ldr r1, _02158C0C // =0xFFFFF556
	cmp r2, r1
	movlt r2, r1
	blt _02158A8C
	rsb r0, r1, #0
	cmp r2, r0
	movgt r2, r0
_02158A8C:
	strh r2, [r4, #2]
_02158A90:
	ldrh r1, [r4]
	ldr r3, _02158C10 // =FX_SinCosTable_
	add r0, sp, #0x78
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r6, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r6]
	ldrsh r2, [r3, r2]
	blx MTX_RotX33_
	ldrh r1, [r4, #2]
	ldr r3, _02158C10 // =FX_SinCosTable_
	add r0, sp, #0x54
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r6, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r6]
	ldrsh r2, [r3, r2]
	blx MTX_RotX33_
	ldrh r1, [r4, #4]
	ldr r3, _02158C10 // =FX_SinCosTable_
	add r0, sp, #0x30
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r6, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r6]
	ldrsh r2, [r3, r2]
	blx MTX_RotZ33_
	add r2, r5, #0x238
	add r0, sp, #0x30
	add r1, sp, #0x78
	add r2, r2, #0x400
	bl MTX_Concat33
	add r1, r5, #0x238
	add r0, r1, #0x400
	mov r2, r0
	add r1, sp, #0x54
	bl MTX_Concat33
	ldr r1, [r4, #0x24]
	add r0, r5, #0x44
	add r7, r1, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r7, {r0, r1, r2}
	ldr r1, [r4, #0x24]
	add r6, r5, #0x650
	ldr r0, [r1, #0x4c]
	add lr, sp, #0x24
	add r0, r0, #0x96000
	str r0, [r1, #0x4c]
	ldr r1, [r4, #0x24]
	mov ip, #0
	ldr r0, [r1, #0x48]
	mov r3, #0x1000
	add r0, r0, #0x1e000
	str r0, [r1, #0x48]
	ldmia r6, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	mov r1, lr
	add r0, sp, #0x18
	add r2, sp, #0xc
	str r3, [sp, #0x1c]
	str ip, [sp, #0x18]
	str ip, [sp, #0x20]
	bl VEC_CrossProduct
	ldr r0, [r4, #0x24]
	add ip, sp, #0xc
	add r4, r0, #0x18c
	ldmia ip!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia ip!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldr r0, [ip]
	str r0, [r4]
	ldr r0, [r5, #0x4c]
	cmp r0, #0x1f4000
	addle sp, sp, #0x9c
	ldmleia sp!, {r4, r5, r6, r7, pc}
	mov r1, #0
	str r1, [r5, #0x98]
	str r1, [r5, #0x9c]
	ldr r0, _02158C14 // =ovl02_2158C18
	str r1, [r5, #0xa0]
	str r0, [r5, #0x3bc]
	add sp, sp, #0x9c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02158BF8: .word 0x00000333
_02158BFC: .word 0x00000E38
_02158C00: .word 0xFFFFF778
_02158C04: .word 0x00000199
_02158C08: .word gPlayer
_02158C0C: .word 0xFFFFF556
_02158C10: .word FX_SinCosTable_
_02158C14: .word ovl02_2158C18
	arm_func_end ovl02_21588B4

	arm_func_start ovl02_2158C18
ovl02_2158C18: // 0x02158C18
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r1, [r6, #0x270]
	ldr r0, _02158D20 // =Boss6Stage__Singleton
	orr r1, r1, #4
	str r1, [r6, #0x270]
	ldr r0, [r0]
	add r4, r6, #0x374
	bl GetTaskWork_
	ldr r1, [r0, #0x38c]
	ldr r0, _02158D24 // =0xFFBFC080
	rsb r1, r1, #0
	add r0, r1, r0
	str r0, [r6, #0x48]
	ldr r1, [r6, #0x460]
	ldr r0, [r6, #0x4c]
	sub r0, r1, r0
	rsb r0, r0, #0
	str r0, [r6, #0x4c]
	ldrsh r0, [r4, #6]
	ldr r2, [r6, #0x4c]
	cmp r0, #0
	ldrgt r1, [r6, #0x48]
	ldrgt r0, _02158D28 // =0x00277FE0
	ldrle r1, [r6, #0x48]
	ldrle r0, _02158D2C // =0xFFE8FFE0
	str r0, [r4, #0xc]
	str r1, [r4, #0x10]
	str r2, [r4, #0x14]
	ldr r0, _02158D20 // =Boss6Stage__Singleton
	ldr r5, [r6, #0x4c]
	ldr r0, [r0]
	bl GetTaskWork_
	ldr r2, [r0, #0x38c]
	ldr r1, _02158D30 // =0x00083FE0
	ldr r0, _02158D34 // =0xFFDF0080
	rsb r2, r2, #0
	str r1, [r4, #0x18]
	add r0, r2, r0
	str r0, [r4, #0x1c]
	add r0, r6, #0x214
	str r5, [r4, #0x20]
	mov r1, #0
	strh r1, [r4, #0xa]
	str r1, [r6, #0x408]
	str r1, [sp]
	str r1, [sp, #4]
	ldr r2, [r6, #0x75c]
	add r0, r0, #0x400
	mov r3, #6
	bl BossHelpers__Animation__Func_2038BF0
	ldr r1, [r4, #0x24]
	ldr r0, [r1, #0x18]
	orr r0, r0, #8
	str r0, [r1, #0x18]
	ldr r0, [r6, #0x370]
	bl ovl02_2155EB4
	ldr r0, [r6, #0x370]
	bl ovl02_2155FAC
	ldr r1, _02158D38 // =ovl02_2158D3C
	mov r0, r6
	str r1, [r6, #0x3bc]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02158D20: .word Boss6Stage__Singleton
_02158D24: .word 0xFFBFC080
_02158D28: .word 0x00277FE0
_02158D2C: .word 0xFFE8FFE0
_02158D30: .word 0x00083FE0
_02158D34: .word 0xFFDF0080
_02158D38: .word ovl02_2158D3C
	arm_func_end ovl02_2158C18

	arm_func_start ovl02_2158D3C
ovl02_2158D3C: // 0x02158D3C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r5, r0
	add r2, r5, #0x374
	ldrsh r0, [r2, #0xa]
	mov r4, #0
	mov lr, #2
	add r0, r0, #0x28
	strh r0, [r2, #0xa]
	ldrsh r0, [r2, #0xa]
	mov r9, #0
	mov r8, #0x800
	cmp r0, #0x1000
	movgt r0, #0x1000
	strgth r0, [r2, #0xa]
	ldrsh r7, [r2, #0xa]
	ldr ip, [r2, #0x18]
	ldr r3, [r2, #0xc]
	movgt r4, #1
	mov r6, r7, asr #0x1f
_02158D88:
	sub r10, ip, r3
	umull r1, r0, r10, r7
	mla r0, r10, r6, r0
	mov r10, r10, asr #0x1f
	adds r1, r1, r8
	mla r0, r10, r7, r0
	adc r0, r0, r9
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	cmp lr, #0
	add r3, r3, r1
	sub lr, lr, #1
	bne _02158D88
	str r3, [r5, #0x44]
	ldrsh r7, [r2, #0xa]
	ldr ip, [r2, #0x1c]
	ldr r3, [r2, #0x10]
	mov r6, r7, asr #0x1f
	mov lr, #2
	mov r9, #0
	mov r8, #0x800
_02158DDC:
	sub r10, ip, r3
	umull r1, r0, r10, r7
	mla r0, r10, r6, r0
	mov r10, r10, asr #0x1f
	adds r1, r1, r8
	mla r0, r10, r7, r0
	adc r0, r0, r9
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	cmp lr, #0
	add r3, r3, r1
	sub lr, lr, #1
	bne _02158DDC
	str r3, [r5, #0x48]
	ldrsh r7, [r2, #0xa]
	ldr ip, [r2, #0x20]
	ldr r3, [r2, #0x14]
	mov r6, r7, asr #0x1f
	mov lr, #2
	mov r9, #0
	mov r8, #0x800
_02158E30:
	sub r10, ip, r3
	umull r1, r0, r10, r7
	mla r0, r10, r6, r0
	mov r10, r10, asr #0x1f
	adds r1, r1, r8
	mla r0, r10, r7, r0
	adc r0, r0, r9
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	cmp lr, #0
	add r3, r3, r1
	sub lr, lr, #1
	bne _02158E30
	str r3, [r5, #0x4c]
	ldrsh ip, [r2, #0xa]
	mov r0, #0
	mov r1, #2
	mov r3, ip, asr #0x1f
	mov r7, r0
	mov r6, #0x800
_02158E80:
	rsb r8, r0, #0x1000
	umull lr, r9, r8, ip
	mla r9, r8, r3, r9
	mov r8, r8, asr #0x1f
	mla r9, r8, ip, r9
	adds lr, lr, r6
	adc r8, r9, r7
	mov r9, lr, lsr #0xc
	orr r9, r9, r8, lsl #20
	cmp r1, #0
	add r0, r0, r9
	sub r1, r1, #1
	bne _02158E80
	mov r0, r0, lsl #4
	strh r0, [r2, #4]
	ldrh r0, [r2, #4]
	ldr r3, _02158F20 // =FX_SinCosTable_
	add r0, r0, #0x31c
	add r0, r0, #0x400
	strh r0, [r2, #4]
	ldrsh r0, [r2, #6]
	cmp r0, #0
	ldrlth r0, [r2, #4]
	rsblt r0, r0, #0
	strlth r0, [r2, #4]
	ldrh r1, [r2, #4]
	add r0, r5, #0x238
	add r0, r0, #0x400
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r6, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r6]
	ldrsh r2, [r3, r2]
	blx MTX_RotZ33_
	cmp r4, #0
	ldrne r0, _02158F24 // =ovl02_2158F28
	strne r0, [r5, #0x3bc]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02158F20: .word FX_SinCosTable_
_02158F24: .word ovl02_2158F28
	arm_func_end ovl02_2158D3C

	arm_func_start ovl02_2158F28
ovl02_2158F28: // 0x02158F28
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r4, r5, #0x374
	ldrsh r1, [r4, #4]
	cmp r1, #0
	bge _02158F60
	rsb r0, r1, #0
	cmp r0, #0x24
	movle r1, #0
	ble _02158F7C
	add r0, r1, #0x24
	mov r0, r0, lsl #0x10
	mov r1, r0, asr #0x10
	b _02158F7C
_02158F60:
	ble _02158F7C
	cmp r1, #0x24
	movle r1, #0
	ble _02158F7C
	sub r0, r1, #0x24
	mov r0, r0, lsl #0x10
	mov r1, r0, asr #0x10
_02158F7C:
	strh r1, [r4, #4]
	ldrh r1, [r4, #4]
	add r0, r5, #0x238
	ldr r3, _02159014 // =FX_SinCosTable_
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	add r0, r0, #0x400
	blx MTX_RotZ33_
	ldr r1, [r5, #0x408]
	cmp r1, #0x1000
	bge _02158FD8
	rsb r0, r1, #0x1000
	cmp r0, #0xcc
	addgt r0, r1, #0xcc
	strgt r0, [r5, #0x408]
	movle r0, #0x1000
	strle r0, [r5, #0x408]
	b _02158FF4
_02158FD8:
	ble _02158FF4
	sub r0, r1, #0x1000
	cmp r0, #0xcc
	subgt r0, r1, #0xcc
	strgt r0, [r5, #0x408]
	movle r0, #0x1000
	strle r0, [r5, #0x408]
_02158FF4:
	ldrh r0, [r4, #4]
	cmp r0, #0
	ldreq r0, [r5, #0x408]
	cmpeq r0, #0x1000
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl ovl02_21576B0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02159014: .word FX_SinCosTable_
	arm_func_end ovl02_2158F28

	arm_func_start ovl02_2159018
ovl02_2159018: // 0x02159018
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x54
	mov r6, r0
	add r0, r6, #0x650
	ldmia r0, {r0, r1, r2}
	add r4, sp, #0x48
	stmia r4, {r0, r1, r2}
	ldr r5, _02159208 // =_02178890
	ldr r3, _0215920C // =gPlayer
	ldmia r5, {r0, r1, r2}
	add r4, sp, #0x30
	stmia r4, {r0, r1, r2}
	ldr r0, [r3]
	add r1, r6, #0x25c
	add r2, sp, #0x3c
	add r0, r0, #0x1b0
	add r1, r1, #0x400
	add r4, r6, #0x374
	mov r5, #1
	bl VEC_Subtract
	add r0, sp, #0x3c
	mov r1, r0
	bl VEC_Normalize
	add r2, sp, #0x3c
	ldr r1, _02159210 // =0x00002AAA
	add r0, sp, #0x30
	mov r3, r2
	bl sub_2066B94
	add r0, sp, #0x3c
	add r1, sp, #0x48
	add r2, sp, #0x24
	bl VEC_Subtract
	mov r9, #0
	add r7, r4, #4
	mov ip, #0x28
	mvn lr, #0x27
	mov r2, r9
	mov r3, r9
	mov r11, r9
	add r0, sp, #0x48
	add r8, sp, #0x24
_021590BC:
	ldr r1, [r8, r9, lsl #2]
	cmp r1, #0
	rsblt r10, r1, #0
	movge r10, r1
	cmp r10, #0x7a
	ble _02159114
	cmp r1, #0
	ldr r1, [r7, r9, lsl #2]
	addgt r1, r1, #2
	suble r1, r1, #2
	str r1, [r7, r9, lsl #2]
	add r1, r4, r9, lsl #2
	ldr r10, [r1, #4]
	cmp r10, lr
	movlt r10, lr
	blt _02159104
	cmp r10, #0x28
	movgt r10, ip
_02159104:
	add r1, r4, r9, lsl #2
	mov r5, r11
	str r10, [r1, #4]
	b _02159160
_02159114:
	add r1, r4, r9, lsl #2
	ldr r10, [r1, #4]
	cmp r10, #0
	bge _02159144
	rsb r10, r10, #0
	cmp r10, #2
	strle r3, [r1, #4]
	ble _02159160
	ldr r1, [r7, r9, lsl #2]
	add r1, r1, #2
	str r1, [r7, r9, lsl #2]
	b _02159160
_02159144:
	ble _02159160
	cmp r10, #2
	strle r2, [r1, #4]
	ble _02159160
	ldr r1, [r7, r9, lsl #2]
	sub r1, r1, #2
	str r1, [r7, r9, lsl #2]
_02159160:
	add r10, r4, r9, lsl #2
	ldr r1, [r0, r9, lsl #2]
	ldr r10, [r10, #4]
	add r1, r1, r10
	str r1, [r0, r9, lsl #2]
	add r9, r9, #1
	cmp r9, #3
	blt _021590BC
	mov r1, r0
	bl VEC_Normalize
	ldr r0, _02159214 // =_02178854
	add r3, sp, #0x18
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r1, sp, #0x48
	add r2, sp, #0xc
	mov r0, r3
	bl VEC_CrossProduct
	add r0, sp, #0xc
	mov r1, r0
	bl VEC_Normalize
	add r0, sp, #0x48
	add r1, sp, #0xc
	add r2, sp, #0
	bl VEC_CrossProduct
	add r0, r6, #0x238
	add r9, r0, #0x400
	add r0, r6, #0x244
	add r1, sp, #0xc
	add r7, r0, #0x400
	ldmia r1, {r0, r1, r2}
	stmia r9, {r0, r1, r2}
	add r8, sp, #0
	ldmia r8, {r0, r1, r2}
	stmia r7, {r0, r1, r2}
	add r4, sp, #0x48
	add r3, r6, #0x650
	ldmia r4, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r5
	add sp, sp, #0x54
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02159208: .word _02178890
_0215920C: .word gPlayer
_02159210: .word 0x00002AAA
_02159214: .word _02178854
	arm_func_end ovl02_2159018

	arm_func_start ovl02_2159218
ovl02_2159218: // 0x02159218
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x374
	mov r0, #0
	mov r2, #0x38
	bl MIi_CpuClear16
	mov r1, #0
	str r1, [r4, #0x98]
	str r1, [r4, #0x9c]
	ldr r0, _0215924C // =ovl02_2159250
	str r1, [r4, #0xa0]
	str r0, [r4, #0x3bc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215924C: .word ovl02_2159250
	arm_func_end ovl02_2159218

	arm_func_start ovl02_2159250
ovl02_2159250: // 0x02159250
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x214
	ldr r2, [r4, #0x75c]
	add r0, r0, #0x400
	mov r3, #1
	bl BossHelpers__Animation__Func_2038BF0
	add r1, r4, #0x58
	add r0, r4, #0x300
	mov r2, #0x78
	strh r2, [r0, #0x74]
	add r0, r1, #0x400
	add r3, r4, #0x384
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x388]
	add r0, r4, #0x44
	rsb r1, r1, #0
	str r1, [r4, #0x388]
	add r3, r4, #0x390
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, _021592C8 // =ovl02_21592CC
	str r0, [r4, #0x3bc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021592C8: .word ovl02_21592CC
	arm_func_end ovl02_2159250

	arm_func_start ovl02_21592CC
ovl02_21592CC: // 0x021592CC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r10, r0
	ldr r0, [r10, #0x370]
	add r4, r10, #0x374
	bl ovl02_21558E8
	cmp r0, #0
	ldreq r0, _021593B4 // =ovl02_2159624
	addeq sp, sp, #0x1c
	streq r0, [r10, #0x3bc]
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r10
	bl ovl02_2159018
	ldrh r1, [r4]
	str r0, [sp, #0xc]
	add r7, r10, #0x98
	cmp r1, #0
	subne r0, r1, #1
	strneh r0, [r4]
	moveq r0, #1
	ldr r1, [r10, #0x45c]
	streq r0, [sp, #0xc]
	ldr r2, [r10, #0x458]
	ldr r0, [r10, #0x460]
	rsb r1, r1, #0
	add r8, r4, #0x10
	str r2, [sp, #0x10]
	str r1, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r9, #0
	mov r11, #0xcc
	mov r6, #0x1000
	mov r5, #0x5000
	add r4, sp, #0x10
_02159354:
	str r11, [sp]
	str r6, [sp, #4]
	str r5, [sp, #8]
	ldr r0, [r4, r9, lsl #2]
	ldr r1, [r8, r9, lsl #2]
	ldr r2, [r7, r9, lsl #2]
	mov r3, r11
	bl BossHelpers__Math__Func_20392BC
	str r0, [r7, r9, lsl #2]
	add r9, r9, #1
	cmp r9, #3
	blt _02159354
	ldr r0, [sp, #0xc]
	cmp r0, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r1, #0
	str r1, [r10, #0x98]
	str r1, [r10, #0x9c]
	ldr r0, _021593B8 // =ovl02_21593BC
	str r1, [r10, #0xa0]
	str r0, [r10, #0x3bc]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021593B4: .word ovl02_2159624
_021593B8: .word ovl02_21593BC
	arm_func_end ovl02_21592CC

	arm_func_start ovl02_21593BC
ovl02_21593BC: // 0x021593BC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x24
	add r2, sp, #0x18
	mov r1, #0x14000
	mov r4, r0
	bl ovl02_2155354
	ldr r0, [sp, #0x1c]
	add r1, sp, #0xc
	rsb r2, r0, #0
	mov r0, r4
	str r2, [sp, #0x1c]
	bl ovl02_215532C
	ldr r1, [sp, #0x10]
	add r0, sp, #0xc
	rsb r2, r1, #0
	mov r1, r0
	str r2, [sp, #0x10]
	bl VEC_Normalize
	add r1, sp, #0xc
	ldr r0, _021594AC // =0x00001333
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #0x16c
	str r0, [sp, #8]
	ldr r0, [r4, #0x370]
	ldr r1, [sp, #0x18]
	ldr r2, [sp, #0x1c]
	ldr r3, [sp, #0x20]
	bl ovl02_215C074
	add r1, r4, #0x400
	ldrh r2, [r1, #0x24]
	mov r0, #0
	add r2, r2, #1
	strh r2, [r1, #0x24]
	ldr r2, [sp, #0x1c]
	ldr r1, [sp, #0x18]
	ldr r3, [sp, #0x20]
	rsb r2, r2, #0
	bl BossFX__CreateBomb
	mov r0, #0
	str r0, [sp]
	mov r0, #0x96
	sub r1, r0, #0x97
	str r0, [sp, #4]
	ldr r0, [r4, #0xa88]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	add r1, r4, #0x88
	ldr r0, [r4, #0xa88]
	add r1, r1, #0x400
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	ldr r1, _021594B0 // =ovl02_21594B4
	mov r0, r4
	str r1, [r4, #0x3bc]
	blx r1
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021594AC: .word 0x00001333
_021594B0: .word ovl02_21594B4
	arm_func_end ovl02_21593BC

	arm_func_start ovl02_21594B4
ovl02_21594B4: // 0x021594B4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x39c
	bl ovl02_215532C
	ldr r1, [r4, #0x39c]
	add r0, r4, #0x39c
	rsb r1, r1, #0
	str r1, [r4, #0x39c]
	ldr r2, [r4, #0x3a4]
	mov r1, r0
	rsb r2, r2, #0
	str r2, [r4, #0x3a4]
	bl VEC_Normalize
	mov r0, #0x5000
	str r0, [r4, #0x3a8]
	ldr r1, _02159504 // =ovl02_2159508
	mov r0, r4
	str r1, [r4, #0x3bc]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02159504: .word ovl02_2159508
	arm_func_end ovl02_21594B4

	arm_func_start ovl02_2159508
ovl02_2159508: // 0x02159508
	ldr r3, [r0, #0x3a8]
	cmp r3, #0
	bge _0215953C
	ldr r1, _02159618 // =0x00000333
	rsb r2, r3, #0
	cmp r2, r1
	movle r1, #0
	strle r1, [r0, #0x3a8]
	ble _02159558
	add r1, r3, #0x33
	add r1, r1, #0x300
	str r1, [r0, #0x3a8]
	b _02159558
_0215953C:
	ble _02159558
	ldr r1, _02159618 // =0x00000333
	cmp r3, r1
	subgt r1, r3, r1
	strgt r1, [r0, #0x3a8]
	movle r1, #0
	strle r1, [r0, #0x3a8]
_02159558:
	ldr r3, [r0, #0x3a8]
	ldr r1, [r0, #0x39c]
	mov r2, #0
	smull ip, r1, r3, r1
	adds r3, ip, #0x800
	adc r1, r1, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r1, lsl #20
	str r3, [r0, #0x98]
	ldr r3, [r0, #0x3a8]
	ldr r1, [r0, #0x3a0]
	smull ip, r1, r3, r1
	adds r3, ip, #0x800
	adc r1, r1, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r1, lsl #20
	str r3, [r0, #0x9c]
	ldr r3, [r0, #0x3a8]
	ldr r1, [r0, #0x3a4]
	smull ip, r1, r3, r1
	adds r3, ip, #0x800
	adc r1, r1, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r1, lsl #20
	str r3, [r0, #0xa0]
	ldr ip, [r0, #0x408]
	cmp ip, #0
	bge _021595EC
	ldr r1, _0215961C // =0x00000199
	rsb r3, ip, #0
	cmp r3, r1
	strle r2, [r0, #0x408]
	ble _02159604
	add r1, ip, #0x99
	add r1, r1, #0x100
	str r1, [r0, #0x408]
	b _02159604
_021595EC:
	ble _02159604
	ldr r1, _0215961C // =0x00000199
	cmp ip, r1
	subgt r1, ip, r1
	strgt r1, [r0, #0x408]
	strle r2, [r0, #0x408]
_02159604:
	ldr r1, [r0, #0x3a8]
	cmp r1, #0
	ldreq r1, _02159620 // =ovl02_2159624
	streq r1, [r0, #0x3bc]
	bx lr
	.align 2, 0
_02159618: .word 0x00000333
_0215961C: .word 0x00000199
_02159620: .word ovl02_2159624
	arm_func_end ovl02_2159508

	arm_func_start ovl02_2159624
ovl02_2159624: // 0x02159624
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r6, r0
	mov r2, #0
	mov r1, #0xb6
	add r4, r6, #0x374
	str r2, [sp]
	mov r5, #1
	bl ovl02_2156A00
	mov r1, #0
	mov r3, #0x2000
	ldr r2, _0215982C // =0x00000333
	add r8, r6, #0x98
	rsb r3, r3, #0
	mov lr, r1
	mov r7, r1
	mov ip, r1
	mov r11, r1
_02159668:
	add r9, r4, r1, lsl #2
	add r10, r6, r1, lsl #2
	ldr r9, [r9, #0x1c]
	ldr r10, [r10, #0x44]
	subs r9, r9, r10
	rsbmi r10, r9, #0
	movpl r10, r9
	cmp r10, #0xa000
	bge _0215970C
	add r9, r6, r1, lsl #2
	ldr r10, [r9, #0x98]
	cmp r10, #0
	bge _021596C0
	rsb r10, r10, #0
	cmp r10, r2
	strle r7, [r9, #0x98]
	ble _021596DC
	ldr r9, [r8, r1, lsl #2]
	add r9, r9, #0x33
	add r9, r9, #0x300
	str r9, [r8, r1, lsl #2]
	b _021596DC
_021596C0:
	ble _021596DC
	cmp r10, r2
	strle lr, [r9, #0x98]
	ble _021596DC
	ldr r9, [r8, r1, lsl #2]
	sub r9, r9, r2
	str r9, [r8, r1, lsl #2]
_021596DC:
	add r9, r6, r1, lsl #2
	ldr r9, [r9, #0x98]
	cmp r9, #0
	rsblt r9, r9, #0
	cmp r9, #0x1000
	addle r9, r6, r1, lsl #2
	strle ip, [r9, #0x98]
	add r9, r6, r1, lsl #2
	ldr r9, [r9, #0x98]
	cmp r9, #0
	movne r5, r11
	b _02159788
_0215970C:
	add r5, r6, r1, lsl #2
	ldr r10, [r5, #0x98]
	cmp r10, r9
	bge _02159740
	sub r10, r9, r10
	cmp r10, r2, lsr #1
	strle r9, [r5, #0x98]
	ble _02159760
	ldr r5, [r8, r1, lsl #2]
	add r5, r5, #0x99
	add r5, r5, #0x100
	str r5, [r8, r1, lsl #2]
	b _02159760
_02159740:
	ble _02159760
	sub r10, r10, r9
	cmp r10, r2, lsr #1
	strle r9, [r5, #0x98]
	ble _02159760
	ldr r5, [r8, r1, lsl #2]
	sub r5, r5, r2, lsr #1
	str r5, [r8, r1, lsl #2]
_02159760:
	add r5, r6, r1, lsl #2
	ldr r9, [r5, #0x98]
	cmp r9, r3
	movlt r9, r3
	blt _0215977C
	cmp r9, #0x2000
	movgt r9, #0x2000
_0215977C:
	add r5, r6, r1, lsl #2
	str r9, [r5, #0x98]
	mov r5, #0
_02159788:
	add r1, r1, #1
	cmp r1, #3
	blt _02159668
	cmp r5, #0
	beq _02159800
	ldr r3, [r6, #0x408]
	cmp r3, #0x1000
	bge _021597D0
	ldr r1, _02159830 // =0x00000199
	rsb r2, r3, #0x1000
	cmp r2, r1
	movle r1, #0x1000
	strle r1, [r6, #0x408]
	ble _021597F0
	add r1, r3, #0x99
	add r1, r1, #0x100
	str r1, [r6, #0x408]
	b _021597F0
_021597D0:
	ble _021597F0
	ldr r1, _02159830 // =0x00000199
	sub r2, r3, #0x1000
	cmp r2, r1
	subgt r1, r3, r1
	strgt r1, [r6, #0x408]
	movle r1, #0x1000
	strle r1, [r6, #0x408]
_021597F0:
	ldr r1, [r6, #0x408]
	cmp r1, #0x1000
	moveq r1, #1
	streq r1, [sp]
_02159800:
	ldr r1, [sp]
	cmp r1, #0
	cmpne r0, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r6, #0x370]
	bl ovl02_2155AB8
	mov r1, r0
	mov r0, r6
	bl ovl02_2157484
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215982C: .word 0x00000333
_02159830: .word 0x00000199
	arm_func_end ovl02_2159624

	arm_func_start ovl02_2159834
ovl02_2159834: // 0x02159834
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldrh r0, [r1, #6]
	cmp r0, #0
	subne r0, r0, #1
	strneh r0, [r1, #6]
	ldrh r0, [r1, #6]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r4, _02159938 // =_mt_math_rand
	ldr r3, _0215993C // =0x00196225
	ldr r2, [r4]
	ldr ip, _02159940 // =0x3C6EF35F
	mov lr, #0
	mla r0, r2, r3, ip
	mov r2, r0, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	and r5, r2, #0xf00
	mov r2, #0xf000
	umull r7, r6, r5, r2
	mla r6, r5, lr, r6
	mov lr, r5, asr #0x1f
	adds r5, r7, #0x800
	mla r6, lr, r2, r6
	adc r2, r6, #0
	mov r5, r5, lsr #0xc
	str r0, [r4]
	orr r5, r5, r2, lsl #20
	str r5, [r1]
	ldr r0, [r4]
	ldr lr, _02159944 // =FX_SinCosTable_
	mla r2, r0, r3, ip
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r2, [r4]
	bic r0, r0, #0xff
	strh r0, [r1, #4]
	ldrh r2, [r1, #4]
	ldr r3, [r1]
	mov r0, #4
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r2, [lr, r2]
	smull r4, r2, r3, r2
	adds r3, r4, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [r1, #8]
	ldrh r2, [r1, #4]
	ldr r3, [r1]
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r2, [lr, r2]
	smull r4, r2, r3, r2
	adds r3, r4, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [r1, #0xc]
	strh r0, [r1, #6]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02159938: .word _mt_math_rand
_0215993C: .word 0x00196225
_02159940: .word 0x3C6EF35F
_02159944: .word FX_SinCosTable_
	arm_func_end ovl02_2159834

	arm_func_start ovl02_2159948
ovl02_2159948: // 0x02159948
	stmdb sp!, {r3, lr}
	ldr r2, [r0, #0x44]
	cmp r2, #0x14000
	movle r2, #1
	strle r2, [r1, #0x14]
	ldr r3, [r0, #0x44]
	ldr r2, _021599D8 // =0x000F3FC0
	cmp r3, r2
	movge r2, #0
	strge r2, [r1, #0x14]
	ldr r2, [r1, #0x14]
	ldr r3, _021599DC // =FX_SinCosTable_
	cmp r2, #0
	mov r2, #0x4000
	rsbeq r2, r2, #0
	str r2, [r0, #0x98]
	ldrh r0, [r1, #0x18]
	mov r2, #0
	add r0, r0, #0x31c
	add r0, r0, #0x400
	strh r0, [r1, #0x18]
	ldrh ip, [r1, #0x18]
	mov r0, #0xf000
	mov ip, ip, asr #4
	mov ip, ip, lsl #2
	ldrsh r3, [r3, ip]
	umull lr, ip, r3, r0
	mla ip, r3, r2, ip
	mov r2, r3, asr #0x1f
	mla ip, r2, r0, ip
	adds r3, lr, #0x800
	adc r0, ip, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [r1, #0x20]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021599D8: .word 0x000F3FC0
_021599DC: .word FX_SinCosTable_
	arm_func_end ovl02_2159948

	arm_func_start ovl02_21599E0
ovl02_21599E0: // 0x021599E0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r1, r4, #0x374
	mov r0, #0
	mov r2, #0x2c
	bl MIi_CpuClear16
	ldr r2, _02159A70 // =_mt_math_rand
	ldr r0, _02159A74 // =0x00196225
	ldr ip, [r2]
	ldr r1, _02159A78 // =0x3C6EF35F
	add r3, r4, #0x214
	mla r1, ip, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	and r0, r0, #1
	str r0, [r4, #0x388]
	ldr r0, [r4, #0x270]
	mov r1, #0
	bic r0, r0, #4
	str r0, [r4, #0x270]
	str r1, [r4, #0x98]
	str r1, [r4, #0x9c]
	str r1, [r4, #0xa0]
	str r1, [sp]
	str r1, [sp, #4]
	ldr r2, [r4, #0x75c]
	add r0, r3, #0x400
	mov r3, #5
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02159A7C // =ovl02_2159A80
	str r0, [r4, #0x3bc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02159A70: .word _mt_math_rand
_02159A74: .word 0x00196225
_02159A78: .word 0x3C6EF35F
_02159A7C: .word ovl02_2159A80
	arm_func_end ovl02_21599E0

	arm_func_start ovl02_2159A80
ovl02_2159A80: // 0x02159A80
	mov r1, #0x5000
	rsb r1, r1, #0
	str r1, [r0, #0xa0]
	mov r2, #0x5000
	ldr r1, _02159AA0 // =ovl02_2159AA4
	str r2, [r0, #0x9c]
	str r1, [r0, #0x3bc]
	bx lr
	.align 2, 0
_02159AA0: .word ovl02_2159AA4
	arm_func_end ovl02_2159A80

	arm_func_start ovl02_2159AA4
ovl02_2159AA4: // 0x02159AA4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0xa0]
	cmp r2, #0
	bge _02159AE0
	ldr r0, _02159B60 // =0x00000199
	rsb r1, r2, #0
	cmp r1, r0
	movle r0, #0
	strle r0, [r4, #0xa0]
	ble _02159AFC
	add r0, r2, #0x99
	add r0, r0, #0x100
	str r0, [r4, #0xa0]
	b _02159AFC
_02159AE0:
	ble _02159AFC
	ldr r0, _02159B60 // =0x00000199
	cmp r2, r0
	subgt r0, r2, r0
	strgt r0, [r4, #0xa0]
	movle r0, #0
	strle r0, [r4, #0xa0]
_02159AFC:
	ldr r1, [r4, #0x9c]
	cmp r1, #0x1000
	bge _02159B24
	rsb r0, r1, #0x1000
	cmp r0, #0xcc
	addgt r0, r1, #0xcc
	strgt r0, [r4, #0x9c]
	movle r0, #0x1000
	strle r0, [r4, #0x9c]
	b _02159B40
_02159B24:
	ble _02159B40
	sub r0, r1, #0x1000
	cmp r0, #0xcc
	subgt r0, r1, #0xcc
	strgt r0, [r4, #0x9c]
	movle r0, #0x1000
	strle r0, [r4, #0x9c]
_02159B40:
	mov r0, r4
	mov r1, #0xb6
	bl ovl02_2156A00
	ldr r0, [r4, #0xa0]
	cmp r0, #0
	ldreq r0, _02159B64 // =ovl02_2159B68
	streq r0, [r4, #0x3bc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02159B60: .word 0x00000199
_02159B64: .word ovl02_2159B68
	arm_func_end ovl02_2159AA4

	arm_func_start ovl02_2159B68
ovl02_2159B68: // 0x02159B68
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r4, r5, #0x374
	add r0, r5, #0x44
	add r1, r4, #8
	mov r2, r0
	bl VEC_Subtract
	add r0, r5, #0x44
	add r1, r4, #0x1c
	mov r2, r0
	bl VEC_Subtract
	mov r0, r5
	mov r1, #0xb6
	bl ovl02_2156A00
	mov r0, #0x64000
	ldr r1, [r5, #0x4c]
	rsb r0, r0, #0
	cmp r1, r0
	bge _02159C0C
	ldr r2, [r5, #0xa0]
	cmp r2, #0x1000
	bge _02159BE8
	ldr r0, _02159CEC // =0x00000199
	rsb r1, r2, #0x1000
	cmp r1, r0
	movle r0, #0x1000
	strle r0, [r5, #0xa0]
	ble _02159C20
	add r0, r2, #0x99
	add r0, r0, #0x100
	str r0, [r5, #0xa0]
	b _02159C20
_02159BE8:
	ble _02159C20
	ldr r0, _02159CEC // =0x00000199
	sub r1, r2, #0x1000
	cmp r1, r0
	subgt r0, r2, r0
	strgt r0, [r5, #0xa0]
	movle r0, #0x1000
	strle r0, [r5, #0xa0]
	b _02159C20
_02159C0C:
	mov r0, #0
	str r0, [r5, #0xa0]
	ldr r0, [r5, #0x270]
	orr r0, r0, #4
	str r0, [r5, #0x270]
_02159C20:
	ldr r1, [r5, #0x9c]
	cmp r1, #0x1000
	bge _02159C48
	rsb r0, r1, #0x1000
	cmp r0, #0xcc
	addgt r0, r1, #0xcc
	strgt r0, [r5, #0x9c]
	movle r0, #0x1000
	strle r0, [r5, #0x9c]
	b _02159C64
_02159C48:
	ble _02159C64
	sub r0, r1, #0x1000
	cmp r0, #0xcc
	subgt r0, r1, #0xcc
	strgt r0, [r5, #0x9c]
	movle r0, #0x1000
	strle r0, [r5, #0x9c]
_02159C64:
	ldr r0, _02159CF0 // =Boss6Stage__Singleton
	ldr r0, [r0]
	bl GetTaskWork_
	ldr r1, [r0, #0x38c]
	ldr r0, [r5, #0x48]
	rsb r1, r1, #0
	sub r1, r1, #0x6e000
	cmp r1, r0
	movlt r0, #0
	strlt r0, [r5, #0x9c]
	mov r0, r5
	mov r1, r4
	bl ovl02_2159834
	mov r0, r5
	mov r1, r4
	bl ovl02_2159948
	add r0, r5, #0x44
	add r1, r4, #8
	mov r2, r0
	bl VEC_Add
	add r0, r5, #0x44
	add r1, r4, #0x1c
	mov r2, r0
	bl VEC_Add
	ldr r0, [r5, #0x270]
	tst r0, #4
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r1, [r4, #0x28]
	add r0, r1, #1
	strh r0, [r4, #0x28]
	cmp r1, #0x258
	ldrhi r0, _02159CF4 // =ovl02_2159CF8
	strhi r0, [r5, #0x3bc]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02159CEC: .word 0x00000199
_02159CF0: .word Boss6Stage__Singleton
_02159CF4: .word ovl02_2159CF8
	arm_func_end ovl02_2159B68

	arm_func_start ovl02_2159CF8
ovl02_2159CF8: // 0x02159CF8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x214
	ldr r2, [r4, #0x75c]
	add r0, r0, #0x400
	mov r3, #6
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, [r4, #0x270]
	ldr r1, _02159D68 // =0x00000199
	bic r0, r0, #4
	str r0, [r4, #0x270]
	ldr r0, [r4, #0x370]
	add r0, r0, #0x300
	strh r1, [r0, #0x80]
	ldr r0, [r4, #0x370]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0x80]
	bl UpdateBossHealthHUD
	ldr r1, _02159D6C // =ovl02_2159D70
	mov r0, r4
	str r1, [r4, #0x3bc]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02159D68: .word 0x00000199
_02159D6C: .word ovl02_2159D70
	arm_func_end ovl02_2159CF8

	arm_func_start ovl02_2159D70
ovl02_2159D70: // 0x02159D70
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r1, #0xcc
	mov ip, #0x5000
	add r2, r1, #0xcd
	mov r3, #0x3000
	mov r4, r0
	str ip, [sp]
	bl ovl02_2156ACC
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, pc}
	mov r0, r4
	mov r1, #0
	bl ovl02_2157484
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end ovl02_2159D70

	arm_func_start ovl02_2159DB4
ovl02_2159DB4: // 0x02159DB4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	add r4, r5, #0x374
	mov r1, r4
	mov r0, #0
	mov r2, #0xa
	bl MIi_CpuClear16
	ldr r1, [r5, #0x270]
	ldr r0, _02159ECC // =playerGameStatus
	bic r1, r1, #4
	str r1, [r5, #0x270]
	ldr r1, [r0]
	bic r1, r1, #1
	str r1, [r0]
	bl StopStageBGM
	ldr r0, _02159ED0 // =gPlayer
	ldr r0, [r0]
	bl Player__Action_Blank
	ldr r0, _02159ED0 // =gPlayer
	mov r1, #0x12
	ldr r0, [r0]
	bl Player__ChangeAction
	mov r2, #0
	ldr r1, _02159ED0 // =gPlayer
	ldr r0, [r1]
	add r0, r0, #0x600
	strh r2, [r0, #0x82]
	ldr r0, [r1]
	bl BossHelpers__Player__LockControl
	mov r0, #0
	str r0, [r5, #0x72c]
	str r0, [r5, #0x408]
	str r0, [r5, #0x98]
	str r0, [r5, #0x9c]
	str r0, [r5, #0xa0]
	mov r1, #1
	ldr r0, [r5, #0x370]
	str r1, [r0, #0xa2c]
	bl BossArena__GetUnknown2Animator
	mov r1, #0
	str r1, [r0, #0x118]
	bl EnableObjectManagerFlag2
	ldr r1, [r5, #0x18]
	mov r0, #0
	orr r1, r1, #0x20
	str r1, [r5, #0x18]
	ldr r2, [r5, #0x370]
	ldr r1, [r2, #0x18]
	orr r1, r1, #0x20
	str r1, [r2, #0x18]
	ldr r1, [r5, #0x44]
	ldr r2, [r5, #0x48]
	ldr r3, [r5, #0x4c]
	rsb r2, r2, #0
	bl BossFX__CreateCondorExplode2
	mov r0, #0
	str r0, [sp]
	mov r1, #0x95
	str r1, [sp, #4]
	sub r1, r1, #0x96
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, #0
	strh r0, [r4, #8]
	ldr r0, _02159ED4 // =ovl02_2159ED8
	str r0, [r5, #0x3bc]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02159ECC: .word playerGameStatus
_02159ED0: .word gPlayer
_02159ED4: .word ovl02_2159ED8
	arm_func_end ovl02_2159DB4

	arm_func_start ovl02_2159ED8
ovl02_2159ED8: // 0x02159ED8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r1, r5, #0x374
	ldrh r0, [r1, #8]
	add r0, r0, #1
	strh r0, [r1, #8]
	ldrh r0, [r1, #8]
	cmp r0, #0x5a
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #2
	bl BossArena__GetCamera
	ldr r2, [r5, #0x48]
	ldr r3, [r5, #0x4c]
	ldr r1, [r5, #0x44]
	mov r4, r0
	rsb r2, r2, #0
	add r3, r3, #0x32000
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0xc8000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r4
	mov r1, #0
	bl BossArena__SetAmplitudeYTarget
	ldr r1, _02159F98 // =gPlayer
	ldr r0, _02159F9C // =0x000A4FD8
	ldr r1, [r1]
	ldr r1, [r1, #0x44]
	cmp r1, r0
	bge _02159F60
	ldr r1, _02159FA0 // =0x00001555
	mov r0, r4
	bl BossArena__SetAngleTarget
	b _02159F6C
_02159F60:
	ldr r1, _02159FA4 // =0x0000EAAB
	mov r0, r4
	bl BossArena__SetAngleTarget
_02159F6C:
	mov r1, #0xcc
	mov r0, r4
	mov r2, r1
	bl BossArena__SetTracker1Speed
	mov r1, #0xcc
	mov r0, r4
	mov r2, r1
	bl BossArena__SetTracker0Speed
	ldr r0, _02159FA8 // =ovl02_2159FAC
	str r0, [r5, #0x3bc]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02159F98: .word gPlayer
_02159F9C: .word 0x000A4FD8
_02159FA0: .word 0x00001555
_02159FA4: .word 0x0000EAAB
_02159FA8: .word ovl02_2159FAC
	arm_func_end ovl02_2159ED8

	arm_func_start ovl02_2159FAC
ovl02_2159FAC: // 0x02159FAC
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
	ldr r1, _0215A010 // =ovl02_215A014
	bic r3, r3, #1
	orr r3, r3, #1
	strh r3, [r4, #0x20]
	ldrh r3, [r4, #0x20]
	orr r3, r3, #0x1e
	strh r3, [r4, #0x20]
	strh r2, [r0, #0x7c]
	str r1, [r5, #0x3bc]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215A010: .word ovl02_215A014
	arm_func_end ovl02_2159FAC

	arm_func_start ovl02_215A014
ovl02_215A014: // 0x0215A014
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r10, r0
	ldr r4, [r10, #0x370]
	add r8, r10, #0x374
	bl Camera3D__GetWork
	add r1, r4, #0xd00
	ldrsh r3, [r1, #0x84]
	mvn r2, #0xf
	cmp r3, r2
	beq _0215A06C
	ldrh r2, [r8, #2]
	add r2, r2, #1
	strh r2, [r8, #2]
	ldrh r2, [r8, #2]
	cmp r2, #1
	bls _0215A06C
	mov r2, #0
	strh r2, [r8, #2]
	ldrsh r2, [r1, #0x84]
	sub r2, r2, #1
	strh r2, [r1, #0x84]
_0215A06C:
	ldrh r1, [r0, #0x24]
	cmp r1, #0x10
	bhs _0215A0A4
	ldrh r1, [r8]
	add r1, r1, #1
	strh r1, [r8]
	ldrh r1, [r8]
	cmp r1, #2
	bls _0215A0A4
	mov r1, #0
	strh r1, [r8]
	ldrh r1, [r0, #0x24]
	add r1, r1, #1
	strh r1, [r0, #0x24]
_0215A0A4:
	mov r9, #0
	ldr r7, _0215A148 // =BossArena__explosionFXSpawnTime
	mov r6, r9
	mov r11, r9
	mov r5, #0xcd
	mvn r4, #0
_0215A0BC:
	ldrh r1, [r8, #8]
	ldr r0, [r7, r9, lsl #2]
	cmp r1, r0
	bne _0215A11C
	ldr r0, [r10, #0x48]
	ldr r1, [r10, #0x44]
	rsb r2, r0, #0
	ldr r3, [r10, #0x4c]
	mov r0, r6
	bl BossFX__CreateCondorExplode0
	str r11, [sp]
	mov r0, r11
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
_0215A11C:
	add r9, r9, #1
	cmp r9, #3
	blt _0215A0BC
	ldrh r1, [r8, #8]
	add r0, r1, #1
	strh r0, [r8, #8]
	cmp r1, #0xd2
	ldrhi r0, _0215A14C // =ovl02_215A150
	strhi r0, [r10, #0x3bc]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215A148: .word BossArena__explosionFXSpawnTime
_0215A14C: .word ovl02_215A150
	arm_func_end ovl02_215A014

	arm_func_start ovl02_215A150
ovl02_215A150: // 0x0215A150
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	rsb r2, r0, #0
	ldr r3, [r4, #0x4c]
	mov r0, #0
	bl BossFX__CreateCondorExplode1
	mov r2, #0x2000
	str r2, [r0, #0x38]
	str r2, [r0, #0x3c]
	str r2, [r0, #0x40]
	ldr r1, _0215A1DC // =0x00000555
	mov r2, #0xe3
	str r1, [r0, #0x280]
	mov r0, #0xa000
	mov r1, #0x3000
	bl ShakeScreenEx
	mov r3, #0x8d
	sub r1, r3, #0x8e
	mov r0, #0
	stmia sp, {r0, r3}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r1, _0215A1E0 // =ovl02_215A1E4
	add r0, r4, #0x300
	mov r2, #0
	strh r2, [r0, #0x7c]
	mov r0, r4
	str r1, [r4, #0x3bc]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215A1DC: .word 0x00000555
_0215A1E0: .word ovl02_215A1E4
	arm_func_end ovl02_215A150

	arm_func_start ovl02_215A1E4
ovl02_215A1E4: // 0x0215A1E4
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r6, [r5, #0x370]
	add r4, r5, #0x374
	bl Camera3D__GetWork
	add r3, r6, #0xd00
	ldrsh ip, [r3, #0x84]
	mov r1, #0
	mov r2, r1
	cmp ip, #0
	addne ip, ip, #1
	strneh ip, [r3, #0x84]
	ldrsh r3, [r0, #0x58]
	moveq r1, #1
	cmp r3, #0x10
	bge _0215A26C
	ldrh r3, [r4, #8]
	cmp r3, #0xb4
	bls _0215A270
	ldrh r3, [r4, #6]
	add r3, r3, #1
	strh r3, [r4, #6]
	ldrh r3, [r4, #6]
	cmp r3, #3
	bls _0215A270
	ldrsh ip, [r0, #0x58]
	mov r3, #0
	add ip, ip, #1
	strh ip, [r0, #0x58]
	ldrsh ip, [r0, #0xb4]
	add ip, ip, #1
	strh ip, [r0, #0xb4]
	strh r3, [r4, #6]
	b _0215A270
_0215A26C:
	mov r2, #1
_0215A270:
	ldrh r0, [r4, #8]
	cmp r1, #0
	cmpne r2, #0
	add r0, r0, #1
	strh r0, [r4, #8]
	ldrne r0, _0215A290 // =ovl02_215A294
	strne r0, [r5, #0x3bc]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215A290: .word ovl02_215A294
	arm_func_end ovl02_215A1E4

	arm_func_start ovl02_215A294
ovl02_215A294: // 0x0215A294
	ldr r0, _0215A2A8 // =playerGameStatus
	ldr r1, [r0]
	orr r1, r1, #4
	str r1, [r0]
	bx lr
	.align 2, 0
_0215A2A8: .word playerGameStatus
	arm_func_end ovl02_215A294

	arm_func_start ovl02_215A2AC
ovl02_215A2AC: // 0x0215A2AC
	ldr r1, [r0, #0x39c]
	ldr r0, [r0, #0x370]
	cmp r1, #0
	ldreq r0, [r0, #0x378]
	ldrne r0, [r0, #0x374]
	bx lr
	arm_func_end ovl02_215A2AC

	arm_func_start ovl02_215A2C4
ovl02_215A2C4: // 0x0215A2C4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x394]
	blx r1
	ldr r1, [r4, #0x3e4]
	cmp r1, #0x1000
	ble _0215A31C
	bge _0215A300
	rsb r0, r1, #0x1000
	cmp r0, #8
	addgt r0, r1, #8
	strgt r0, [r4, #0x3e4]
	movle r0, #0x1000
	strle r0, [r4, #0x3e4]
	b _0215A31C
_0215A300:
	ble _0215A31C
	sub r0, r1, #0x1000
	cmp r0, #8
	subgt r0, r1, #8
	strgt r0, [r4, #0x3e4]
	movle r0, #0x1000
	strle r0, [r4, #0x3e4]
_0215A31C:
	add r0, r4, #0x3a0
	bl ovl02_21550CC
	add r0, r4, #0x3b8
	add r3, r4, #0xb0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_215A2C4

	arm_func_start ovl02_215A338
ovl02_215A338: // 0x0215A338
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x4c
	mov r1, #0
	add r0, r0, #0x400
	str r1, [r4, #0x2fc]
	bl BossHelpers__Animation__Func_2038C58
	add r0, r4, #0x4c
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	add r0, r4, #0x1c8
	add r0, r0, #0x400
	bl BossHelpers__Animation__Func_2038C58
	add r0, r4, #0x1c8
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	add r0, r4, #0x344
	add r0, r0, #0x400
	bl BossHelpers__Animation__Func_2038C58
	add r0, r4, #0x344
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	add r0, r4, #0x8c0
	bl BossHelpers__Animation__Func_2038C58
	add r0, r4, #0x8c0
	bl AnimatorMDL__Release
	ldr r0, [r4, #0xa3c]
	bl FreeSndHandle
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_215A338

	arm_func_start ovl02_215A3BC
ovl02_215A3BC: // 0x0215A3BC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x24
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x398]
	mov r5, #0
	cmp r0, #3
	cmpne r0, #4
	bne _0215A3E8
	mov r5, #1
	b _0215A3F4
_0215A3E8:
	bl Camera3D__UseEngineA
	cmp r0, #0
	movne r5, #1
_0215A3F4:
	cmp r5, #0
	addeq sp, sp, #0x24
	ldmeqia sp!, {r4, r5, pc}
	add r1, r4, #0x4c
	mov r0, r4
	add r1, r1, #0x400
	bl StageTask__Draw3D
	ldr r0, [r4, #0x398]
	cmp r0, #4
	bne _0215A434
	mov r2, #0x1000
	add r0, sp, #0
	mov r3, r2
	mov r1, #0x800
	blx MTX_Scale33_
	b _0215A4A4
_0215A434:
	add ip, r4, #0x470
	ldmia ip!, {r0, r1, r2, r3}
	add r5, sp, #0
	stmia r5!, {r0, r1, r2, r3}
	ldmia ip!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldr r0, [ip]
	str r0, [r5]
	ldr lr, [sp, #0x10]
	cmp lr, #0
	bge _0215A4A4
	ldr r5, [sp]
	ldr r3, [sp, #4]
	ldr r2, [sp, #8]
	ldr r1, [sp, #0xc]
	ldr r0, [sp, #0x14]
	rsb ip, r5, #0
	rsb r5, r3, #0
	rsb r3, r2, #0
	rsb r2, r1, #0
	rsb r1, lr, #0
	rsb r0, r0, #0
	str ip, [sp]
	str r5, [sp, #4]
	str r3, [sp, #8]
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
_0215A4A4:
	add r0, r4, #0x368
	add ip, sp, #0
	add r5, r0, #0x400
	ldmia ip!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia ip!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldr r1, [ip]
	add r0, r4, #0xe4
	str r1, [r5]
	add lr, sp, #0
	add r5, r0, #0x800
	ldmia lr!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldr r0, [lr]
	add ip, r4, #0x344
	str r0, [r5]
	add r1, ip, #0x400
	mov r0, r4
	add r2, r4, #0x8c0
	mov r3, #0xf000
	bl ovl02_2155390
	ldr r0, [r4, #0x448]
	cmp r0, #0
	addeq sp, sp, #0x24
	ldmeqia sp!, {r4, r5, pc}
	add r0, r4, #0x1c8
	add r5, r0, #0x400
	add lr, r4, #0x470
	add ip, r5, #0x24
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r2, [lr]
	mov r0, r4
	mov r1, r5
	str r2, [ip]
	bl StageTask__Draw3D
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, pc}
	arm_func_end ovl02_215A3BC

	arm_func_start ovl02_215A550
ovl02_215A550: // 0x0215A550
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x444]
	cmp r1, #0
	bne _0215A578
	ldr r1, [r0, #0x398]
	sub r1, r1, #1
	cmp r1, #1
	movls r1, #1
	strls r1, [r0, #0x444]
	ldmlsia sp!, {r3, pc}
_0215A578:
	mov r2, #0
	str r2, [r0, #0x444]
	ldr r1, _0215A594 // =ovl02_215A668
	str r2, [r0, #0x398]
	str r1, [r0, #0x394]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215A594: .word ovl02_215A668
	arm_func_end ovl02_215A550

	arm_func_start ovl02_215A598
ovl02_215A598: // 0x0215A598
	stmdb sp!, {r3, lr}
	mov r2, #1
	ldr r1, _0215A5B4 // =ovl02_215AA0C
	str r2, [r0, #0x398]
	str r1, [r0, #0x394]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215A5B4: .word ovl02_215AA0C
	arm_func_end ovl02_215A598

	arm_func_start ovl02_215A5B8
ovl02_215A5B8: // 0x0215A5B8
	stmdb sp!, {r3, lr}
	mov r2, #2
	ldr r1, _0215A5D4 // =ovl02_215AA38
	str r2, [r0, #0x398]
	str r1, [r0, #0x394]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215A5D4: .word ovl02_215AA38
	arm_func_end ovl02_215A5B8

	arm_func_start ovl02_215A5D8
ovl02_215A5D8: // 0x0215A5D8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	add r1, r5, #0x374
	mov r0, #0
	mov r2, #0x14
	bl MIi_CpuClear16
	ldr r1, _0215A614 // =ovl02_215AAE8
	str r4, [r5, #0x374]
	mov r0, #3
	str r0, [r5, #0x398]
	mov r0, r5
	str r1, [r5, #0x394]
	blx r1
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215A614: .word ovl02_215AAE8
	arm_func_end ovl02_215A5D8

	arm_func_start ovl02_215A618
ovl02_215A618: // 0x0215A618
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	mov r6, r1
	mov r5, r2
	add r1, r7, #0x374
	mov r0, #0
	mov r2, #0x20
	mov r4, r3
	bl MIi_CpuClear16
	str r6, [r7, #0x378]
	str r5, [r7, #0x37c]
	ldr r1, _0215A664 // =ovl02_215B308
	str r4, [r7, #0x374]
	mov r0, #4
	str r0, [r7, #0x398]
	mov r0, r7
	str r1, [r7, #0x394]
	blx r1
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215A664: .word ovl02_215B308
	arm_func_end ovl02_215A618

	arm_func_start ovl02_215A668
ovl02_215A668: // 0x0215A668
	mov r2, #0
	str r2, [r0, #0x448]
	ldr r1, [r0, #0x39c]
	cmp r1, #0
	add r1, r0, #0x400
	movne r2, #0x8000
	strh r2, [r1, #0x3c]
	ldr r1, _0215A690 // =ovl02_215A694
	str r1, [r0, #0x394]
	bx lr
	.align 2, 0
_0215A690: .word ovl02_215A694
	arm_func_end ovl02_215A668

	arm_func_start ovl02_215A694
ovl02_215A694: // 0x0215A694
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	mov r10, r0
	ldr r0, [r10, #0x370]
	ldr r1, [r0, #0x370]
	ldr r0, [r1, #0x3c0]
	cmp r0, #1
	bne _0215A6DC
	add r0, r1, #0x58
	add r0, r0, #0x400
	add r3, r10, #0x430
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r10, #0x434]
	mov r0, #0
	rsb r1, r1, #0x1e000
	str r1, [r10, #0x434]
	str r0, [r10, #0x438]
_0215A6DC:
	add r0, r10, #0x430
	add r3, sp, #0xc
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r10, #0x39c]
	cmp r0, #0
	ldrne r0, [sp, #0xc]
	subne r0, r0, #0x64000
	strne r0, [sp, #0xc]
	bne _0215A710
	ldr r0, [sp, #0xc]
	add r0, r0, #0x64000
	str r0, [sp, #0xc]
_0215A710:
	add r8, sp, #0xc
	add r6, r10, #0x98
	add r7, r10, #0x44
	mov r9, #0
	mov r5, #0x51
	mov r4, #0x1000
	mov r11, #0x6000
_0215A72C:
	str r5, [sp]
	stmib sp, {r4, r11}
	ldr r0, [r7, r9, lsl #2]
	ldr r1, [r8, r9, lsl #2]
	ldr r2, [r6, r9, lsl #2]
	mov r3, #0x28
	bl BossHelpers__Math__Func_20392BC
	str r0, [r6, r9, lsl #2]
	add r9, r9, #1
	cmp r9, #3
	blt _0215A72C
	ldr r1, [r10, #0x3e4]
	cmp r1, #0x1000
	bge _0215A784
	rsb r0, r1, #0x1000
	cmp r0, #0xcc
	addgt r0, r1, #0xcc
	strgt r0, [r10, #0x3e4]
	movle r0, #0x1000
	add sp, sp, #0x18
	strle r0, [r10, #0x3e4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0215A784:
	addle sp, sp, #0x18
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	sub r0, r1, #0x1000
	cmp r0, #0xcc
	subgt r0, r1, #0xcc
	strgt r0, [r10, #0x3e4]
	movle r0, #0x1000
	strle r0, [r10, #0x3e4]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end ovl02_215A694

	arm_func_start ovl02_215A7AC
ovl02_215A7AC: // 0x0215A7AC
	stmdb sp!, {r3, r4, r5, lr}
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r4, r0, lsl #1
	add r0, r4, #1
	ldr r3, _0215A814 // =FX_SinCosTable_
	mov ip, r0, lsl #1
	mov r0, r4, lsl #1
	ldrsh ip, [r3, ip]
	ldrsh r3, [r3, r0]
	mov r0, #0
	smull r4, lr, ip, r1
	adds r5, r4, #0x800
	smull ip, r1, r3, r1
	adc r4, lr, #0
	adds r3, ip, #0x800
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	adc r1, r1, #0
	mov r3, r3, lsr #0xc
	str r5, [r2]
	orr r3, r3, r1, lsl #20
	str r3, [r2, #4]
	str r0, [r2, #8]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215A814: .word FX_SinCosTable_
	arm_func_end ovl02_215A7AC

	arm_func_start ovl02_215A818
ovl02_215A818: // 0x0215A818
	ldr r1, [r0, #0x39c]
	add r0, r0, #0x400
	cmp r1, #0
	ldreqsh r1, [r0, #0x3c]
	beq _0215A83C
	ldrh r0, [r0, #0x3c]
	sub r0, r0, #0x8000
	mov r0, r0, lsl #0x10
	mov r1, r0, asr #0x10
_0215A83C:
	ldr r0, _0215A858 // =0x00000AAA
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r1, r0
	movgt r0, #0
	movle r0, #1
	bx lr
	.align 2, 0
_0215A858: .word 0x00000AAA
	arm_func_end ovl02_215A818

	arm_func_start ovl02_215A85C
ovl02_215A85C: // 0x0215A85C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	mov r10, r0
	ldr r2, [r10, #0x444]
	mov r4, r1
	cmp r2, #0
	beq _0215A894
	bl ovl02_215A818
	cmp r0, #0
	beq _0215A894
	mov r0, r10
	bl ovl02_215A550
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0215A894:
	ldr r1, _0215A9FC // =0x00083FE0
	ldr r0, _0215AA00 // =Boss6Stage__Singleton
	str r1, [r10, #0x430]
	ldr r0, [r0]
	bl GetTaskWork_
	ldr r1, [r0, #0x38c]
	ldr r0, _0215AA04 // =0xFFDF0080
	rsb r1, r1, #0
	add r0, r1, r0
	str r0, [r10, #0x434]
	mov r0, #0
	str r0, [r10, #0x438]
	cmp r4, #0
	ldr r0, [r10, #0x370]
	beq _0215A8E4
	bl ovl02_2155BBC
	add r1, r10, #0x400
	ldrh r2, [r1, #0x3c]
	add r0, r2, r0
	b _0215A8F4
_0215A8E4:
	bl ovl02_2155BBC
	add r1, r10, #0x400
	ldrh r2, [r1, #0x3c]
	sub r0, r2, r0
_0215A8F4:
	strh r0, [r1, #0x3c]
	add r0, r10, #0x400
	ldrh r0, [r0, #0x3c]
	add r2, sp, #0xc
	mov r1, #0x64000
	bl ovl02_215A7AC
	add r0, sp, #0xc
	add r2, sp, #0x18
	add r1, r10, #0x430
	bl VEC_Add
	ldr r0, [r10, #0x440]
	cmp r0, #0
	bne _0215A99C
	mov r0, #1
	mov r9, #0
	ldr r5, _0215AA08 // =0x00000199
	add r8, sp, #0x18
	str r0, [r10, #0x440]
	add r6, r10, #0x98
	add r7, r10, #0x44
	mov r11, r9
	mov r4, #0x2000
_0215A94C:
	str r5, [sp]
	str r4, [sp, #4]
	str r4, [sp, #8]
	ldr r0, [r7, r9, lsl #2]
	ldr r1, [r8, r9, lsl #2]
	ldr r2, [r6, r9, lsl #2]
	mov r3, #0x28
	bl BossHelpers__Math__Func_20392BC
	str r0, [r6, r9, lsl #2]
	ldr r1, [r7, r9, lsl #2]
	ldr r2, [r8, r9, lsl #2]
	add r0, r1, r0
	subs r0, r2, r0
	rsbmi r0, r0, #0
	cmp r0, #0x2000
	add r9, r9, #1
	strgt r11, [r10, #0x440]
	cmp r9, #3
	blt _0215A94C
	b _0215A9AC
_0215A99C:
	add r0, sp, #0x18
	add r1, r10, #0x44
	add r2, r10, #0x98
	bl VEC_Subtract
_0215A9AC:
	ldr r1, [r10, #0x3e4]
	cmp r1, #0
	bge _0215A9D8
	rsb r0, r1, #0
	cmp r0, #0xcc
	addgt r0, r1, #0xcc
	strgt r0, [r10, #0x3e4]
	movle r0, #0
	add sp, sp, #0x24
	strle r0, [r10, #0x3e4]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0215A9D8:
	addle sp, sp, #0x24
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r1, #0xcc
	subgt r0, r1, #0xcc
	strgt r0, [r10, #0x3e4]
	movle r0, #0
	strle r0, [r10, #0x3e4]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215A9FC: .word 0x00083FE0
_0215AA00: .word Boss6Stage__Singleton
_0215AA04: .word 0xFFDF0080
_0215AA08: .word 0x00000199
	arm_func_end ovl02_215A85C

	arm_func_start ovl02_215AA0C
ovl02_215AA0C: // 0x0215AA0C
	mov r2, #0
	str r2, [r0, #0x448]
	ldr r1, _0215AA24 // =ovl02_215AA28
	str r2, [r0, #0x440]
	str r1, [r0, #0x394]
	bx lr
	.align 2, 0
_0215AA24: .word ovl02_215AA28
	arm_func_end ovl02_215AA0C

	arm_func_start ovl02_215AA28
ovl02_215AA28: // 0x0215AA28
	ldr ip, _0215AA34 // =ovl02_215A85C
	mov r1, #1
	bx ip
	.align 2, 0
_0215AA34: .word ovl02_215A85C
	arm_func_end ovl02_215AA28

	arm_func_start ovl02_215AA38
ovl02_215AA38: // 0x0215AA38
	mov r2, #0
	str r2, [r0, #0x448]
	ldr r1, _0215AA50 // =ovl02_215AA54
	str r2, [r0, #0x440]
	str r1, [r0, #0x394]
	bx lr
	.align 2, 0
_0215AA50: .word ovl02_215AA54
	arm_func_end ovl02_215AA38

	arm_func_start ovl02_215AA54
ovl02_215AA54: // 0x0215AA54
	ldr ip, _0215AA60 // =ovl02_215A85C
	mov r1, #0
	bx ip
	.align 2, 0
_0215AA60: .word ovl02_215A85C
	arm_func_end ovl02_215AA54

	arm_func_start ovl02_215AA64
ovl02_215AA64: // 0x0215AA64
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x48
	mov r5, r0
	add r4, r5, #0x374
	ldrh r1, [r4, #0xe]
	ldr r3, _0215AAE4 // =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	blx MTX_RotZ33_
	ldrh r1, [r4, #0x10]
	ldr r3, _0215AAE4 // =FX_SinCosTable_
	add r0, sp, #0x24
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	blx MTX_RotY33_
	add r0, sp, #0x24
	add r1, sp, #0
	add r2, r5, #0x470
	bl MTX_Concat33
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215AAE4: .word FX_SinCosTable_
	arm_func_end ovl02_215AA64

	arm_func_start ovl02_215AAE8
ovl02_215AAE8: // 0x0215AAE8
	stmdb sp!, {r3, lr}
	mov r2, #0
	ldr r1, _0215AB04 // =ovl02_215AB08
	str r2, [r0, #0x2d8]
	str r1, [r0, #0x394]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215AB04: .word ovl02_215AB08
	arm_func_end ovl02_215AAE8

	arm_func_start ovl02_215AB08
ovl02_215AB08: // 0x0215AB08
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	ldr r1, _0215AC6C // =gPlayer
	mov r10, r0
	ldr r0, [r1]
	add r6, r10, #0x374
	ldr r1, [r0, #0x44]
	add r7, r10, #0x98
	str r1, [sp, #0xc]
	cmp r1, #0x20000
	add r8, r10, #0x44
	movlt r1, #0x20000
	blt _0215AB48
	ldr r0, _0215AC70 // =0x000E7FC0
	cmp r1, r0
	movgt r1, r0
_0215AB48:
	ldr r0, _0215AC74 // =Boss6Stage__Singleton
	str r1, [sp, #0xc]
	ldr r0, [r0]
	bl GetTaskWork_
	ldr r1, _0215AC6C // =gPlayer
	ldr r2, [r0, #0x38c]
	ldr r0, [r1]
	rsb r1, r2, #0
	ldr r0, [r0, #0x4c]
	ldr r5, _0215AC78 // =0x00000999
	sub r1, r1, #0x78000
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r9, #0
	mov r11, #0x4000
	mov r4, r5, lsr #1
_0215AB88:
	stmia sp, {r5, r11}
	mov r0, #0x5000
	str r0, [sp, #8]
	add r1, sp, #0xc
	ldr r0, [r8, r9, lsl #2]
	ldr r1, [r1, r9, lsl #2]
	ldr r2, [r7, r9, lsl #2]
	mov r3, r4
	bl BossHelpers__Math__Func_20392BC
	str r0, [r7, r9, lsl #2]
	add r9, r9, #1
	cmp r9, #3
	blt _0215AB88
	ldrh r0, [r6, #0xe]
	add r0, r0, #0x16c
	strh r0, [r6, #0xe]
	ldrh r0, [r6, #0xe]
	cmp r0, #0x8000
	movhi r0, #0x8000
	strhih r0, [r6, #0xe]
	mov r0, r10
	bl ovl02_215AA64
	ldr r1, [r10, #0x3e4]
	cmp r1, #0
	bge _0215AC08
	rsb r0, r1, #0
	cmp r0, #0xcc
	addgt r0, r1, #0xcc
	strgt r0, [r10, #0x3e4]
	movle r0, #0
	strle r0, [r10, #0x3e4]
	b _0215AC20
_0215AC08:
	ble _0215AC20
	cmp r1, #0xcc
	subgt r0, r1, #0xcc
	strgt r0, [r10, #0x3e4]
	movle r0, #0
	strle r0, [r10, #0x3e4]
_0215AC20:
	ldr r0, _0215AC6C // =gPlayer
	ldr r2, [r0]
	ldr r1, [r2, #0x5d8]
	bic r1, r1, #0x800
	str r1, [r2, #0x5d8]
	ldr r1, [r0]
	ldr r0, [r1, #0x5d8]
	orr r0, r0, #0x1000
	str r0, [r1, #0x5d8]
	ldr r0, [r7, #4]
	cmp r0, #0
	ldreq r0, [r7, #8]
	cmpeq r0, #0
	ldreqh r0, [r6, #0xe]
	cmpeq r0, #0x8000
	ldreq r0, _0215AC7C // =ovl02_215AC80
	streq r0, [r10, #0x394]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215AC6C: .word gPlayer
_0215AC70: .word 0x000E7FC0
_0215AC74: .word Boss6Stage__Singleton
_0215AC78: .word 0x00000999
_0215AC7C: .word ovl02_215AC80
	arm_func_end ovl02_215AB08

	arm_func_start ovl02_215AC80
ovl02_215AC80: // 0x0215AC80
	stmdb sp!, {r3, lr}
	mov r2, #0
	str r0, [r0, #0x2d8]
	add r3, r0, #0x2d8
	strh r2, [r3, #0x22]
	sub r2, r2, #0x18
	ldr r1, _0215ACAC // =ovl02_215ACB0
	strh r2, [r3, #0x1a]
	str r1, [r0, #0x394]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215ACAC: .word ovl02_215ACB0
	arm_func_end ovl02_215AC80

	arm_func_start ovl02_215ACB0
ovl02_215ACB0: // 0x0215ACB0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, [r5, #0x374]
	add r4, r5, #0x374
	ldrh r1, [r4, #4]
	ldrh r0, [r0, #2]
	cmp r1, r0
	addlo r0, r1, #1
	strloh r0, [r4, #4]
	ldr r0, _0215ADE4 // =gPlayer
	ldr r0, [r0]
	ldr r1, [r0, #0x44]
	cmp r1, #0x20000
	movlt r1, #0x20000
	blt _0215ACFC
	ldr r0, _0215ADE8 // =0x000E7FC0
	cmp r1, r0
	movgt r1, r0
_0215ACFC:
	ldr r3, _0215ADEC // =0x00000199
	mov r0, #0x2000
	str r3, [sp]
	str r0, [sp, #4]
	mov r0, #0x14000
	str r0, [sp, #8]
	ldr r0, [r5, #0x44]
	ldr r2, [r5, #0x98]
	bl BossHelpers__Math__Func_20392BC
	str r0, [r5, #0x98]
	ldr r0, _0215ADE4 // =gPlayer
	ldr r1, [r5, #0x44]
	ldr r0, [r0]
	mov r3, #0
	ldr r0, [r0, #0x44]
	subs r0, r0, r1
	rsbmi r0, r0, #0
	cmp r0, #0x14000
	ldrlth r0, [r4, #6]
	addlt r0, r0, #1
	movge r0, #0
	strh r0, [r4, #6]
	ldr r2, [r4]
	ldrh r1, [r4, #4]
	ldrh r0, [r2, #2]
	cmp r1, r0
	blo _0215AD90
	ldrh r0, [r4, #6]
	cmp r0, #0
	movne r3, #1
	bne _0215ADAC
	ldrh r1, [r4, #0xc]
	add r0, r1, #1
	cmp r1, #0xb4
	strh r0, [r4, #0xc]
	movhi r3, #1
	b _0215ADAC
_0215AD90:
	ldrh r0, [r2]
	cmp r1, r0
	blo _0215ADAC
	ldrh r1, [r2, #4]
	ldrh r0, [r4, #6]
	cmp r1, r0
	movlo r3, #1
_0215ADAC:
	cmp r3, #0
	ldrne r0, _0215ADF0 // =ovl02_215ADF4
	strne r0, [r5, #0x394]
	ldr r0, _0215ADE4 // =gPlayer
	ldr r2, [r0]
	ldr r1, [r2, #0x5d8]
	bic r1, r1, #0x800
	str r1, [r2, #0x5d8]
	ldr r1, [r0]
	ldr r0, [r1, #0x5d8]
	orr r0, r0, #0x1000
	str r0, [r1, #0x5d8]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0215ADE4: .word gPlayer
_0215ADE8: .word 0x000E7FC0
_0215ADEC: .word 0x00000199
_0215ADF0: .word ovl02_215ADF4
	arm_func_end ovl02_215ACB0

	arm_func_start ovl02_215ADF4
ovl02_215ADF4: // 0x0215ADF4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r0, #0
	str r0, [r4, #0x98]
	ldr r1, [r4, #0x230]
	mov ip, #0x9a
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r2, [r4, #0x270]
	sub r1, ip, #0x9b
	orr r2, r2, #4
	str r2, [r4, #0x270]
	mov r2, #1
	str r2, [r4, #0x448]
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	ldr r0, _0215AE50 // =ovl02_215AE54
	str r0, [r4, #0x394]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215AE50: .word ovl02_215AE54
	arm_func_end ovl02_215ADF4

	arm_func_start ovl02_215AE54
ovl02_215AE54: // 0x0215AE54
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r4, r5, #0x374
	ldrh r0, [r4, #8]
	add r0, r0, #1
	strh r0, [r4, #8]
	ldr r1, [r5, #0x374]
	ldrh r0, [r4, #8]
	ldrh r1, [r1, #6]
	cmp r0, r1
	ldrhs r0, _0215AEEC // =ovl02_215AEF4
	movhs ip, #0x1000
	strhs r0, [r5, #0x394]
	bhs _0215AEA0
	mov r0, r0, lsl #0xc
	mov r1, r1, lsl #0xc
	bl FX_Div
	mov r0, r0, lsl #0x10
	mov ip, r0, asr #0x10
_0215AEA0:
	ldr r0, _0215AEF0 // =0x01E93000
	mov r1, #0
	umull r3, r2, ip, r0
	mla r2, ip, r1, r2
	mov r1, ip, asr #0x1f
	adds r3, r3, #0x800
	mla r2, r1, r0, r2
	adc r0, r2, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	mov r0, r1, asr #0xc
	strh r0, [r4, #0x12]
	ldrh r2, [r4, #0x10]
	ldrh r1, [r4, #0x12]
	mov r0, r5
	add r1, r2, r1
	strh r1, [r4, #0x10]
	bl ovl02_215AA64
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215AEEC: .word ovl02_215AEF4
_0215AEF0: .word 0x01E93000
	arm_func_end ovl02_215AE54

	arm_func_start ovl02_215AEF4
ovl02_215AEF4: // 0x0215AEF4
	stmdb sp!, {r3, lr}
	mov r1, #0
	str r1, [r0, #0x2d8]
	ldr r2, [r0, #0x374]
	ldr r1, _0215AF1C // =ovl02_215AF20
	ldr r2, [r2, #8]
	str r2, [r0, #0x9c]
	str r1, [r0, #0x394]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215AF1C: .word ovl02_215AF20
	arm_func_end ovl02_215AEF4

	arm_func_start ovl02_215AF20
ovl02_215AF20: // 0x0215AF20
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r1, _0215AFE8 // =Boss6Stage__Singleton
	mov r5, r0
	ldr r0, [r1]
	add r4, r5, #0x374
	bl GetTaskWork_
	ldr r0, [r0, #0x38c]
	ldr r1, [r5, #0x48]
	rsb r0, r0, #0
	sub r0, r0, #0x5000
	cmp r1, r0
	ble _0215AFC8
	ldr r0, _0215AFE8 // =Boss6Stage__Singleton
	ldr r0, [r0]
	bl GetTaskWork_
	ldr r0, [r0, #0x38c]
	mov r2, #0
	rsb r0, r0, #0
	sub r0, r0, #0x5000
	str r0, [r5, #0x48]
	str r2, [r5, #0x9c]
	ldr r1, [r5, #0x270]
	mov r0, #5
	bic r1, r1, #4
	str r1, [r5, #0x270]
	strh r0, [r4, #0xa]
	mov r0, #0x97
	sub r1, r0, #0x98
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r5, #0xa3c]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r5, #0xa3c]
	add r1, r5, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	ldr r0, _0215AFEC // =ovl02_215AFF0
	str r0, [r5, #0x394]
_0215AFC8:
	ldrh r2, [r4, #0x10]
	ldrh r1, [r4, #0x12]
	mov r0, r5
	add r1, r2, r1
	strh r1, [r4, #0x10]
	bl ovl02_215AA64
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215AFE8: .word Boss6Stage__Singleton
_0215AFEC: .word ovl02_215AFF0
	arm_func_end ovl02_215AF20

	arm_func_start ovl02_215AFF0
ovl02_215AFF0: // 0x0215AFF0
	add r3, r0, #0x374
	ldrh r1, [r3, #0xa]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r3, #0xa]
	bne _0215B014
	ldr r1, [r0, #0x370]
	ldr r1, [r1, #0x3a4]
	str r1, [r0, #0xa0]
_0215B014:
	ldr r1, [r0, #0x4c]
	cmp r1, #0x12c000
	ble _0215B030
	mov r2, #0
	ldr r1, _0215B048 // =ovl02_215B050
	str r2, [r0, #0x448]
	str r1, [r0, #0x394]
_0215B030:
	ldrh r2, [r3, #0x10]
	ldrh r1, [r3, #0x12]
	ldr ip, _0215B04C // =ovl02_215AA64
	add r1, r2, r1
	strh r1, [r3, #0x10]
	bx ip
	.align 2, 0
_0215B048: .word ovl02_215B050
_0215B04C: .word ovl02_215AA64
	arm_func_end ovl02_215AFF0

	arm_func_start ovl02_215B050
ovl02_215B050: // 0x0215B050
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0x98]
	str r1, [r4, #0x9c]
	str r1, [r4, #0xa0]
	add r2, r4, #0x374
	strh r1, [r2, #0x10]
	strh r1, [r2, #0xe]
	add r5, r4, #0x2d8
	bl ovl02_215AA64
	add r0, r4, #0x470
	bl MTX_Identity33_
	str r4, [r4, #0x2d8]
	mov r1, #1
	strh r1, [r5, #0x22]
	mov r1, #0
	mov r0, r4
	strh r1, [r5, #0x1a]
	bl ovl02_215A2AC
	mov r5, r0
	ldr r0, [r5, #0x398]
	cmp r0, #0
	cmpne r0, #1
	cmpne r0, #2
	bne _0215B118
	add r0, r5, #0x400
	ldrh r0, [r0, #0x3c]
	add r0, r0, #0x8000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #0x2000
	blo _0215B0E4
	cmp r0, #0x4000
	movlo r0, #0x2000
	blo _0215B0F4
_0215B0E4:
	cmp r0, #0x4000
	blo _0215B0F4
	cmp r0, #0x6000
	movlo r0, #0x6000
_0215B0F4:
	add r2, sp, #0
	mov r1, #0x190000
	bl ovl02_215A7AC
	add r0, sp, #0
	add r1, r5, #0x430
	add r2, r4, #0x44
	bl VEC_Add
	mov r0, #0
	str r0, [r4, #0x4c]
_0215B118:
	ldr r0, _0215B128 // =ovl02_215B12C
	str r0, [r4, #0x394]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0215B128: .word ovl02_215B12C
	arm_func_end ovl02_215B050

	arm_func_start ovl02_215B12C
ovl02_215B12C: // 0x0215B12C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x24
	mov r5, r0
	bl ovl02_215A2AC
	mov r4, r0
	ldr r0, [r4, #0x398]
	cmp r0, #0
	cmpne r0, #1
	cmpne r0, #2
	bne _0215B190
	add r0, r4, #0x400
	ldrh r1, [r0, #0x3c]
	add r0, r5, #0x400
	add r2, sp, #0xc
	add r1, r1, #0x8000
	strh r1, [r0, #0x3c]
	ldrh r0, [r0, #0x3c]
	mov r1, #0x64000
	bl ovl02_215A7AC
	add r0, sp, #0xc
	add r2, sp, #0x18
	add r1, r4, #0x430
	bl VEC_Add
	mov r0, #0
	str r0, [sp, #0x20]
_0215B190:
	ldr r1, _0215B280 // =0x00000199
	mov r0, #0x6000
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #0x14000
	str r0, [sp, #8]
	ldr r0, [r5, #0x44]
	ldr r1, [sp, #0x18]
	ldr r2, [r5, #0x98]
	mov r3, #0xcc
	bl BossHelpers__Math__Func_20392BC
	str r0, [r5, #0x98]
	ldr r1, _0215B280 // =0x00000199
	mov r0, #0x6000
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #0x14000
	str r0, [sp, #8]
	ldr r0, [r5, #0x48]
	ldr r1, [sp, #0x1c]
	ldr r2, [r5, #0x9c]
	mov r3, #0xcc
	bl BossHelpers__Math__Func_20392BC
	str r0, [r5, #0x9c]
	ldr r3, [sp, #0x18]
	ldr r2, [r5, #0x44]
	ldr r1, [sp, #0x1c]
	subs r2, r3, r2
	ldr r0, [r5, #0x48]
	rsbmi r2, r2, #0
	cmp r2, #0x14000
	addge sp, sp, #0x24
	sub r0, r1, r0
	ldmgeia sp!, {r4, r5, pc}
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x14000
	addge sp, sp, #0x24
	ldmgeia sp!, {r4, r5, pc}
	ldr r0, [r4, #0x398]
	cmp r0, #0
	beq _0215B250
	cmp r0, #1
	beq _0215B260
	cmp r0, #2
	beq _0215B270
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, pc}
_0215B250:
	mov r0, r5
	bl ovl02_215A550
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, pc}
_0215B260:
	mov r0, r5
	bl ovl02_215A598
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, pc}
_0215B270:
	mov r0, r5
	bl ovl02_215A5B8
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0215B280: .word 0x00000199
	arm_func_end ovl02_215B12C

	arm_func_start ovl02_215B284
ovl02_215B284: // 0x0215B284
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x48
	mov r5, r0
	add r4, r5, #0x374
	ldrh r1, [r4, #0x18]
	ldr r3, _0215B304 // =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	blx MTX_RotZ33_
	ldrh r1, [r4, #0x1c]
	ldr r3, _0215B304 // =FX_SinCosTable_
	add r0, sp, #0x24
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r4, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r4]
	ldrsh r2, [r3, r2]
	blx MTX_RotY33_
	add r0, sp, #0x24
	add r1, sp, #0
	add r2, r5, #0x470
	bl MTX_Concat33
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215B304: .word FX_SinCosTable_
	arm_func_end ovl02_215B284

	arm_func_start ovl02_215B308
ovl02_215B308: // 0x0215B308
	mov r2, #0
	ldr r1, _0215B31C // =ovl02_215B320
	str r2, [r0, #0x2d8]
	str r1, [r0, #0x394]
	bx lr
	.align 2, 0
_0215B31C: .word ovl02_215B320
	arm_func_end ovl02_215B308

	arm_func_start ovl02_215B320
ovl02_215B320: // 0x0215B320
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r4, r5, #0x374
	mov r0, #0
	str r0, [r4, #0x14]
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0215B35C
	ldr r1, _0215B3C8 // =0x000DFFC0
	mov r0, #0x4000
	str r1, [r4, #0xc]
	strh r0, [r4, #0x1a]
	ldr r0, [r5, #0x20]
	bic r0, r0, #1
	b _0215B374
_0215B35C:
	mov r0, #0x28000
	str r0, [r4, #0xc]
	mov r0, #0xc000
	strh r0, [r4, #0x1a]
	ldr r0, [r5, #0x20]
	orr r0, r0, #1
_0215B374:
	str r0, [r5, #0x20]
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _0215B3A0
	ldr r0, _0215B3CC // =Boss6Stage__Singleton
	ldr r0, [r0]
	bl GetTaskWork_
	ldr r0, [r0, #0x38c]
	rsb r0, r0, #0
	sub r0, r0, #0x50000
	b _0215B3B8
_0215B3A0:
	ldr r0, _0215B3CC // =Boss6Stage__Singleton
	ldr r0, [r0]
	bl GetTaskWork_
	ldr r0, [r0, #0x38c]
	rsb r0, r0, #0
	sub r0, r0, #0x28000
_0215B3B8:
	str r0, [r4, #0x10]
	ldr r0, _0215B3D0 // =ovl02_215B3D4
	str r0, [r5, #0x394]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215B3C8: .word 0x000DFFC0
_0215B3CC: .word Boss6Stage__Singleton
_0215B3D0: .word ovl02_215B3D4
	arm_func_end ovl02_215B320

	arm_func_start ovl02_215B3D4
ovl02_215B3D4: // 0x0215B3D4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r10, r0
	ldr r11, _0215B568 // =0x00000999
	add r5, r10, #0x374
	add r6, r10, #0x98
	add r7, r10, #0x44
	add r8, r5, #0xc
	mov r9, #0
	mov r4, r11, lsr #1
_0215B3FC:
	str r11, [sp]
	mov r0, #0x4000
	str r0, [sp, #4]
	mov r0, #0x5000
	str r0, [sp, #8]
	ldr r0, [r7, r9, lsl #2]
	ldr r1, [r8, r9, lsl #2]
	ldr r2, [r6, r9, lsl #2]
	mov r3, r4
	bl BossHelpers__Math__Func_20392BC
	str r0, [r6, r9, lsl #2]
	add r9, r9, #1
	cmp r9, #3
	blt _0215B3FC
	ldrsh r2, [r5, #0x18]
	ldrsh r1, [r5, #0x1a]
	cmp r2, r1
	bge _0215B464
	sub r0, r1, r2
	cmp r0, #0x16c
	movle r2, r1
	ble _0215B484
	add r0, r2, #0x16c
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	b _0215B484
_0215B464:
	ble _0215B484
	sub r0, r2, r1
	cmp r0, #0x16c
	movle r2, r1
	ble _0215B484
	sub r0, r2, #0x16c
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
_0215B484:
	mov r0, r10
	strh r2, [r5, #0x18]
	bl ovl02_215B284
	ldr r1, [r10, #0x3e4]
	cmp r1, #0
	bge _0215B4B8
	rsb r0, r1, #0
	cmp r0, #0xcc
	addgt r0, r1, #0xcc
	strgt r0, [r10, #0x3e4]
	movle r0, #0
	strle r0, [r10, #0x3e4]
	b _0215B4D0
_0215B4B8:
	ble _0215B4D0
	cmp r1, #0xcc
	subgt r0, r1, #0xcc
	strgt r0, [r10, #0x3e4]
	movle r0, #0
	strle r0, [r10, #0x3e4]
_0215B4D0:
	ldr r0, [r6]
	cmp r0, #0
	ldreq r0, [r6, #4]
	cmpeq r0, #0
	ldreq r0, [r6, #8]
	cmpeq r0, #0
	ldreqh r1, [r5, #0x1a]
	ldreqh r0, [r5, #0x18]
	cmpeq r1, r0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r3, #0
	str r3, [r10, #0x2c]
	ldr r1, [r10, #0x230]
	mov r0, #0x9a
	bic r1, r1, #4
	str r1, [r10, #0x230]
	ldr r2, [r10, #0x2b0]
	sub r1, r0, #0x9b
	orr r2, r2, #4
	str r2, [r10, #0x2b0]
	mov r2, #1
	str r2, [r10, #0x448]
	str r3, [sp]
	str r0, [sp, #4]
	ldr r0, [r10, #0xa3c]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, [r10, #0xa3c]
	add r1, r10, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	ldr r0, _0215B56C // =ovl02_215B570
	str r0, [r10, #0x394]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215B568: .word 0x00000999
_0215B56C: .word ovl02_215B570
	arm_func_end ovl02_215B3D4

	arm_func_start ovl02_215B570
ovl02_215B570: // 0x0215B570
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #0x374]
	ldr r5, [r6, #0x2c]
	ldrh r1, [r0]
	add r0, r5, #1
	add r4, r6, #0x374
	cmp r0, r1
	ldrge r0, _0215B608 // =ovl02_215B610
	movge ip, #0x1000
	strge r0, [r6, #0x394]
	bge _0215B5B4
	mov r0, r0, lsl #0xc
	mov r1, r1, lsl #0xc
	bl FX_Div
	mov r0, r0, lsl #0x10
	mov ip, r0, asr #0x10
_0215B5B4:
	ldr r0, _0215B60C // =0x01E93000
	mov r1, #0
	umull r3, r2, ip, r0
	mla r2, ip, r1, r2
	mov r1, ip, asr #0x1f
	adds r3, r3, #0x800
	mla r2, r1, r0, r2
	add r5, r5, #1
	adc r0, r2, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r5, [r6, #0x2c]
	mov r0, r1, asr #0xc
	strh r0, [r4, #0x1e]
	ldrh r2, [r4, #0x1c]
	ldrh r1, [r4, #0x1e]
	mov r0, r6
	add r1, r2, r1
	strh r1, [r4, #0x1c]
	bl ovl02_215B284
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215B608: .word ovl02_215B610
_0215B60C: .word 0x01E93000
	arm_func_end ovl02_215B570

	arm_func_start ovl02_215B610
ovl02_215B610: // 0x0215B610
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x378]
	cmp r1, #0
	ldr r1, [r0, #0x374]
	ldrne r1, [r1, #4]
	rsbne r1, r1, #0
	ldreq r1, [r1, #4]
	str r1, [r0, #0x98]
	ldr r1, _0215B640 // =ovl02_215B644
	str r1, [r0, #0x394]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215B640: .word ovl02_215B644
	arm_func_end ovl02_215B610

	arm_func_start ovl02_215B644
ovl02_215B644: // 0x0215B644
	stmdb sp!, {r3, lr}
	add r1, r0, #0x374
	ldr r2, [r1, #4]
	mov ip, #0
	cmp r2, #0
	ldr r2, [r1, #0xc]
	ldr r3, [r0, #0x44]
	beq _0215B674
	sub r2, r2, #0x12c000
	cmp r3, r2
	movlt ip, #1
	b _0215B680
_0215B674:
	add r2, r2, #0x12c000
	cmp r3, r2
	movgt ip, #1
_0215B680:
	cmp ip, #0
	beq _0215B698
	mov r3, #0
	ldr r2, _0215B6B0 // =ovl02_215B6B4
	str r3, [r0, #0x448]
	str r2, [r0, #0x394]
_0215B698:
	ldrh r3, [r1, #0x1c]
	ldrh r2, [r1, #0x1e]
	add r2, r3, r2
	strh r2, [r1, #0x1c]
	bl ovl02_215B284
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215B6B0: .word ovl02_215B6B4
	arm_func_end ovl02_215B644

	arm_func_start ovl02_215B6B4
ovl02_215B6B4: // 0x0215B6B4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r0
	mov r0, #0
	str r0, [r4, #0x98]
	str r0, [r4, #0x9c]
	str r0, [r4, #0xa0]
	add r0, r4, #0x470
	bl MTX_Identity33_
	str r4, [r4, #0x2d8]
	ldr r1, [r4, #0x2b0]
	mov r0, r4
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	bl ovl02_215A2AC
	mov r5, r0
	ldr r0, [r5, #0x398]
	cmp r0, #0
	cmpne r0, #1
	cmpne r0, #2
	bne _0215B764
	add r0, r5, #0x400
	ldrh r0, [r0, #0x3c]
	add r0, r0, #0x8000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #0x2000
	blo _0215B730
	cmp r0, #0x4000
	movlo r0, #0x2000
	blo _0215B740
_0215B730:
	cmp r0, #0x4000
	blo _0215B740
	cmp r0, #0x6000
	movlo r0, #0x6000
_0215B740:
	add r2, sp, #0
	mov r1, #0x190000
	bl ovl02_215A7AC
	add r0, sp, #0
	add r1, r5, #0x430
	add r2, r4, #0x44
	bl VEC_Add
	mov r0, #0
	str r0, [r4, #0x4c]
_0215B764:
	ldr r0, _0215B774 // =ovl02_215B778
	str r0, [r4, #0x394]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0215B774: .word ovl02_215B778
	arm_func_end ovl02_215B6B4

	arm_func_start ovl02_215B778
ovl02_215B778: // 0x0215B778
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x24
	mov r5, r0
	bl ovl02_215A2AC
	mov r4, r0
	ldr r0, [r4, #0x398]
	cmp r0, #0
	cmpne r0, #1
	cmpne r0, #2
	bne _0215B7DC
	add r0, r4, #0x400
	ldrh r1, [r0, #0x3c]
	add r0, r5, #0x400
	add r2, sp, #0xc
	add r1, r1, #0x8000
	strh r1, [r0, #0x3c]
	ldrh r0, [r0, #0x3c]
	mov r1, #0x64000
	bl ovl02_215A7AC
	add r0, sp, #0xc
	add r2, sp, #0x18
	add r1, r4, #0x430
	bl VEC_Add
	mov r0, #0
	str r0, [sp, #0x20]
_0215B7DC:
	ldr r1, _0215B8CC // =0x00000199
	mov r0, #0x6000
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #0x14000
	str r0, [sp, #8]
	ldr r0, [r5, #0x44]
	ldr r1, [sp, #0x18]
	ldr r2, [r5, #0x98]
	mov r3, #0xcc
	bl BossHelpers__Math__Func_20392BC
	str r0, [r5, #0x98]
	ldr r1, _0215B8CC // =0x00000199
	mov r0, #0x6000
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #0x14000
	str r0, [sp, #8]
	ldr r0, [r5, #0x48]
	ldr r1, [sp, #0x1c]
	ldr r2, [r5, #0x9c]
	mov r3, #0xcc
	bl BossHelpers__Math__Func_20392BC
	str r0, [r5, #0x9c]
	ldr r3, [sp, #0x18]
	ldr r2, [r5, #0x44]
	ldr r1, [sp, #0x1c]
	subs r2, r3, r2
	ldr r0, [r5, #0x48]
	rsbmi r2, r2, #0
	cmp r2, #0x14000
	addge sp, sp, #0x24
	sub r0, r1, r0
	ldmgeia sp!, {r4, r5, pc}
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x14000
	addge sp, sp, #0x24
	ldmgeia sp!, {r4, r5, pc}
	ldr r0, [r4, #0x398]
	cmp r0, #0
	beq _0215B89C
	cmp r0, #1
	beq _0215B8AC
	cmp r0, #2
	beq _0215B8BC
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, pc}
_0215B89C:
	mov r0, r5
	bl ovl02_215A550
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, pc}
_0215B8AC:
	mov r0, r5
	bl ovl02_215A598
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, pc}
_0215B8BC:
	mov r0, r5
	bl ovl02_215A5B8
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0215B8CC: .word 0x00000199
	arm_func_end ovl02_215B778

	arm_func_start ovl02_215B8D0
ovl02_215B8D0: // 0x0215B8D0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	and r1, r1, #0xff
	str r3, [sp, #0xc]
	mov r4, r0
	str r1, [sp, #0x10]
	ldr ip, [r4, #0x38c]
	mov r1, r2
	ldr r0, _0215B924 // =0x0000012A
	rsb r2, ip, #0
	bl GameObject__SpawnObject
	mov r1, #0x320000
	rsb r1, r1, #0
	str r1, [r0, #0x4c]
	str r4, [r0, #0x370]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0215B924: .word 0x0000012A
	arm_func_end ovl02_215B8D0

	arm_func_start ovl02_215B928
ovl02_215B928: // 0x0215B928
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x374]
	blx r1
	ldmia sp!, {r3, pc}
	arm_func_end ovl02_215B928

	arm_func_start ovl02_215B938
ovl02_215B938: // 0x0215B938
	mov r2, #0
	ldr r1, _0215B94C // =ovl02_215B950
	str r2, [r0, #0x37c]
	str r1, [r0, #0x374]
	bx lr
	.align 2, 0
_0215B94C: .word ovl02_215B950
	arm_func_end ovl02_215B938

	arm_func_start ovl02_215B950
ovl02_215B950: // 0x0215B950
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r2, [r4, #0x48]
	ldr r0, [r4, #0x4c]
	ldr r1, [r4, #0x44]
	add r3, r0, #0x10000
	rsb r2, r2, #0
	mov r0, #0
	bl BossFX__CreateCondorImpact
	ldr r2, [r4, #0x370]
	mov ip, #0x95
	ldr r3, [r2, #0x3a4]
	sub r1, ip, #0x96
	str r3, [r0, #0xa0]
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	ldr r1, _0215B9B8 // =ovl02_215B9BC
	mov r0, r4
	str r1, [r4, #0x374]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215B9B8: .word ovl02_215B9BC
	arm_func_end ovl02_215B950

	arm_func_start ovl02_215B9BC
ovl02_215B9BC: // 0x0215B9BC
	ldr r1, [r0, #0x370]
	ldr r1, [r1, #0x3a4]
	str r1, [r0, #0xa0]
	ldr r1, [r0, #0x4c]
	cmp r1, #0x30000
	ldrgt r1, [r0, #0x18]
	orrgt r1, r1, #8
	strgt r1, [r0, #0x18]
	bx lr
	arm_func_end ovl02_215B9BC

	arm_func_start ovl02_215B9E0
ovl02_215B9E0: // 0x0215B9E0
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x14
	mov r5, r2
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	mov r6, r0
	str r2, [sp, #8]
	and r4, r1, #0xff
	str r2, [sp, #0xc]
	ldr r0, _0215BA80 // =0x0000012B
	mov r1, r2
	mov r3, r2
	str r4, [sp, #0x10]
	bl GameObject__SpawnObject
	mov r4, r0
	str r6, [r4, #0x370]
	ldr r0, [r6, #0x370]
	add r3, r4, #0x44
	add r0, r0, #0x88
	add r0, r0, #0x400
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x48]
	ldr r0, _0215BA84 // =Boss6Stage__Singleton
	rsb r1, r1, #0
	str r1, [r4, #0x48]
	str r5, [r4, #0x3ec]
	ldr r0, [r0]
	bl GetTaskWork_
	ldr r0, [r0, #0x38c]
	mov r1, #0x258000
	rsb r0, r0, #0
	sub r0, r0, #0x28000
	str r0, [r4, #0x3f0]
	rsb r1, r1, #0
	mov r0, r4
	str r1, [r4, #0x3f4]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0215BA80: .word 0x0000012B
_0215BA84: .word Boss6Stage__Singleton
	arm_func_end ovl02_215B9E0

	arm_func_start ovl02_215BA88
ovl02_215BA88: // 0x0215BA88
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x4c]
	cmp r1, #0x40000
	ble _0215BAAC
	ldr r0, [r4, #0x18]
	orr r0, r0, #8
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
_0215BAAC:
	ldr r1, [r4, #0x390]
	blx r1
	ldr r1, [r4, #0x3e0]
	cmp r1, #0x1000
	ble _0215BAFC
	bge _0215BAE0
	rsb r0, r1, #0x1000
	cmp r0, #0x51
	addgt r0, r1, #0x51
	strgt r0, [r4, #0x3e0]
	movle r0, #0x1000
	strle r0, [r4, #0x3e0]
	b _0215BAFC
_0215BAE0:
	ble _0215BAFC
	sub r0, r1, #0x1000
	cmp r0, #0x51
	subgt r0, r1, #0x51
	strgt r0, [r4, #0x3e0]
	movle r0, #0x1000
	strle r0, [r4, #0x3e0]
_0215BAFC:
	add r0, r4, #0x39c
	bl ovl02_21550CC
	add r0, r4, #0x3b4
	add r3, r4, #0xb0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_215BA88

	arm_func_start ovl02_215BB18
ovl02_215BB18: // 0x0215BB18
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x3f8
	bl BossHelpers__Animation__Func_2038C58
	add r0, r4, #0x3f8
	bl AnimatorMDL__Release
	add r0, r4, #0x174
	add r0, r0, #0x400
	bl BossHelpers__Animation__Func_2038C58
	add r0, r4, #0x174
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	add r0, r4, #0x6f0
	bl BossHelpers__Animation__Func_2038C58
	add r0, r4, #0x174
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_215BB18

	arm_func_start ovl02_215BB70
ovl02_215BB70: // 0x0215BB70
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r1, r4, #0x3f8
	bl StageTask__Draw3D
	add r1, r4, #0x174
	mov r0, r4
	add r1, r1, #0x400
	add r2, r4, #0x6f0
	mov r3, #0xf000
	bl ovl02_2155390
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_215BB70

	arm_func_start ovl02_215BBA0
ovl02_215BBA0: // 0x0215BBA0
	mov r2, #0
	ldr r1, _0215BBB4 // =ovl02_215BBD8
	str r2, [r0, #0x398]
	str r1, [r0, #0x390]
	bx lr
	.align 2, 0
_0215BBB4: .word ovl02_215BBD8
	arm_func_end ovl02_215BBA0

	arm_func_start ovl02_215BBB8
ovl02_215BBB8: // 0x0215BBB8
	stmdb sp!, {r3, lr}
	mov r2, #1
	ldr r1, _0215BBD4 // =ovl02_215BC6C
	str r2, [r0, #0x398]
	str r1, [r0, #0x390]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215BBD4: .word ovl02_215BC6C
	arm_func_end ovl02_215BBB8

	arm_func_start ovl02_215BBD8
ovl02_215BBD8: // 0x0215BBD8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r4, #0
	add r2, r0, #0x98
	add r3, r0, #0x44
	add ip, r0, #0x3ec
	mov lr, #1
	mov r7, r4
	mov r6, r4
	mov r5, #0x800
_0215BBFC:
	ldr r8, [ip, r4, lsl #2]
	ldr r1, [r3, r4, lsl #2]
	sub r1, r8, r1
	mov r8, r1, asr #0x1f
	mov r8, r8, lsl #0xb
	adds r9, r5, r1, lsl #11
	orr r8, r8, r1, lsr #21
	adc r8, r8, r6
	mov r9, r9, lsr #0xc
	orrs r9, r9, r8, lsl #20
	str r9, [r2, r4, lsl #2]
	rsbmi r9, r9, #0
	cmp r9, #4
	add r4, r4, #1
	movgt lr, r7
	cmp r4, #3
	blt _0215BBFC
	cmp lr, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	add r1, r0, #0x300
	mov r2, #0x200
	strh r2, [r1, #0xce]
	strh r2, [r1, #0xd4]
	strh r2, [r1, #0xda]
	mov r1, #0x5000
	str r1, [r0, #0x3e0]
	bl ovl02_215BBB8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end ovl02_215BBD8

	arm_func_start ovl02_215BC6C
ovl02_215BC6C: // 0x0215BC6C
	ldr r1, [r0, #0x394]
	cmp r1, #4
	addls pc, pc, r1, lsl #2
	bx lr
_0215BC7C: // jump table
	b _0215BC90 // case 0
	b _0215BC9C // case 1
	b _0215BCA8 // case 2
	b _0215BCB4 // case 3
	b _0215BCC0 // case 4
_0215BC90:
	ldr r1, _0215BCCC // =ovl02_215BCE0
	str r1, [r0, #0x390]
	bx lr
_0215BC9C:
	ldr r1, _0215BCD0 // =ovl02_215BD4C
	str r1, [r0, #0x390]
	bx lr
_0215BCA8:
	ldr r1, _0215BCD4 // =ovl02_215BDB8
	str r1, [r0, #0x390]
	bx lr
_0215BCB4:
	ldr r1, _0215BCD8 // =ovl02_215BE24
	str r1, [r0, #0x390]
	bx lr
_0215BCC0:
	ldr r1, _0215BCDC // =ovl02_215BF50
	str r1, [r0, #0x390]
	bx lr
	.align 2, 0
_0215BCCC: .word ovl02_215BCE0
_0215BCD0: .word ovl02_215BD4C
_0215BCD4: .word ovl02_215BDB8
_0215BCD8: .word ovl02_215BE24
_0215BCDC: .word ovl02_215BF50
	arm_func_end ovl02_215BC6C

	arm_func_start ovl02_215BCE0
ovl02_215BCE0: // 0x0215BCE0
	mov r2, #0x3000
	ldr r1, _0215BCF4 // =ovl02_215BCF8
	str r2, [r0, #0xa0]
	str r1, [r0, #0x390]
	bx lr
	.align 2, 0
_0215BCF4: .word ovl02_215BCF8
	arm_func_end ovl02_215BCE0

	arm_func_start ovl02_215BCF8
ovl02_215BCF8: // 0x0215BCF8
	bx lr
	arm_func_end ovl02_215BCF8

	arm_func_start ovl02_215BCFC
ovl02_215BCFC: // 0x0215BCFC
	ldrh ip, [r1, #4]
	ldrh r2, [r1, #6]
	ldr r3, _0215BD48 // =FX_SinCosTable_
	add r2, ip, r2
	strh r2, [r1, #4]
	ldrh ip, [r1, #4]
	ldr r2, [r1, #8]
	mov ip, ip, asr #4
	mov ip, ip, lsl #2
	ldrsh r3, [r3, ip]
	smull ip, r2, r3, r2
	adds r3, ip, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [r0, #0x98]
	ldr r1, [r1, #0xc]
	str r1, [r0, #0xa0]
	bx lr
	.align 2, 0
_0215BD48: .word FX_SinCosTable_
	arm_func_end ovl02_215BCFC

	arm_func_start ovl02_215BD4C
ovl02_215BD4C: // 0x0215BD4C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r4, r5, #0x374
	mov r1, r4
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	ldr r1, [r5, #0x44]
	ldr r0, _0215BD9C // =0x0000D555
	str r1, [r5, #0x374]
	strh r0, [r4, #4]
	mov r1, #0xb6
	ldr r0, _0215BDA0 // =0x000014CC
	strh r1, [r4, #6]
	str r0, [r4, #8]
	mov r1, #0x3000
	ldr r0, _0215BDA4 // =ovl02_215BDA8
	str r1, [r4, #0xc]
	str r0, [r5, #0x390]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215BD9C: .word 0x0000D555
_0215BDA0: .word 0x000014CC
_0215BDA4: .word ovl02_215BDA8
	arm_func_end ovl02_215BD4C

	arm_func_start ovl02_215BDA8
ovl02_215BDA8: // 0x0215BDA8
	ldr ip, _0215BDB4 // =ovl02_215BCFC
	add r1, r0, #0x374
	bx ip
	.align 2, 0
_0215BDB4: .word ovl02_215BCFC
	arm_func_end ovl02_215BDA8

	arm_func_start ovl02_215BDB8
ovl02_215BDB8: // 0x0215BDB8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r4, r5, #0x374
	mov r1, r4
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	ldr r1, [r5, #0x44]
	ldr r0, _0215BE08 // =0x00005555
	str r1, [r5, #0x374]
	strh r0, [r4, #4]
	mov r1, #0xb6
	ldr r0, _0215BE0C // =0x000014CC
	strh r1, [r4, #6]
	str r0, [r4, #8]
	mov r1, #0x3000
	ldr r0, _0215BE10 // =ovl02_215BE14
	str r1, [r4, #0xc]
	str r0, [r5, #0x390]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215BE08: .word 0x00005555
_0215BE0C: .word 0x000014CC
_0215BE10: .word ovl02_215BE14
	arm_func_end ovl02_215BDB8

	arm_func_start ovl02_215BE14
ovl02_215BE14: // 0x0215BE14
	ldr ip, _0215BE20 // =ovl02_215BCFC
	add r1, r0, #0x374
	bx ip
	.align 2, 0
_0215BE20: .word ovl02_215BCFC
	arm_func_end ovl02_215BE14

	arm_func_start ovl02_215BE24
ovl02_215BE24: // 0x0215BE24
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x374
	mov r0, #0
	mov r2, #0x14
	bl MIi_CpuClear16
	mov r0, #0xcc
	str r0, [r4, #0x374]
	add r0, r0, #0xcd
	str r0, [r4, #0x378]
	mov r0, #0x2800
	str r0, [r4, #0x37c]
	mov r0, #0xa000
	str r0, [r4, #0x380]
	mov r1, #0x3000
	ldr r0, _0215BE70 // =ovl02_215BE74
	str r1, [r4, #0x384]
	str r0, [r4, #0x390]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215BE70: .word ovl02_215BE74
	arm_func_end ovl02_215BE24

	arm_func_start ovl02_215BE74
ovl02_215BE74: // 0x0215BE74
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	ldr r0, [r4, #0x4c]
	cmp r0, #0x1e000
	bge _0215BEC4
	ldr r1, [r4, #0x378]
	ldr r0, _0215BED4 // =gPlayer
	str r1, [sp]
	ldr r1, [r4, #0x37c]
	str r1, [sp, #4]
	ldr r1, [r4, #0x380]
	str r1, [sp, #8]
	ldr r1, [r0]
	ldr r0, [r4, #0x44]
	ldr r1, [r1, #0x44]
	ldr r2, [r4, #0x98]
	ldr r3, [r4, #0x374]
	bl BossHelpers__Math__Func_20392BC
	str r0, [r4, #0x98]
_0215BEC4:
	ldr r0, [r4, #0x384]
	str r0, [r4, #0xa0]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0215BED4: .word gPlayer
	arm_func_end ovl02_215BE74

	arm_func_start ovl02_215BED8
ovl02_215BED8: // 0x0215BED8
	stmdb sp!, {r4, lr}
	mov r4, r1
	add r0, r4, #0xc
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	ldr r3, _0215BF40 // =_mt_math_rand
	ldr r0, _0215BF44 // =0x00196225
	ldr ip, [r3]
	ldr r2, _0215BF48 // =0x3C6EF35F
	mov r1, #4
	mla r2, ip, r0, r2
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r2, [r3]
	bl FX_ModS32
	ldr r1, _0215BF4C // =0x0002A54A
	mov r2, #0
	mul r3, r0, r1
	add r0, r3, r1, lsr #1
	str r0, [r4, #0xc]
	ldr r0, [r4, #0x14]
	add r0, r0, #0x96000
	str r0, [r4, #0x14]
	strh r2, [r4, #0x18]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215BF40: .word _mt_math_rand
_0215BF44: .word 0x00196225
_0215BF48: .word 0x3C6EF35F
_0215BF4C: .word 0x0002A54A
	arm_func_end ovl02_215BED8

	arm_func_start ovl02_215BF50
ovl02_215BF50: // 0x0215BF50
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r4, r5, #0x374
	mov r1, r4
	mov r0, #0
	mov r2, #0x1c
	bl MIi_CpuClear16
	add r0, r5, #0x44
	add r3, r4, #0xc
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldmia r3, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	mov r0, r5
	mov r1, r4
	bl ovl02_215BED8
	ldr r0, _0215BF9C // =ovl02_215BFA0
	str r0, [r5, #0x390]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215BF9C: .word ovl02_215BFA0
	arm_func_end ovl02_215BF50

	arm_func_start ovl02_215BFA0
ovl02_215BFA0: // 0x0215BFA0
	stmdb sp!, {r3, r4, r5, lr}
	add r4, r0, #0x374
	ldrh r1, [r4, #0x1a]
	cmp r1, #0
	mov r1, #0
	bne _0215C05C
	ldrsh r2, [r4, #0x18]
	add r2, r2, #0xcc
	strh r2, [r4, #0x18]
	ldrsh r2, [r4, #0x18]
	cmp r2, #0x1000
	movge r1, #0x1000
	strgeh r1, [r4, #0x18]
	ldr lr, [r4]
	ldr r2, [r4, #0xc]
	ldrsh r3, [r4, #0x18]
	sub r5, r2, lr
	movge r1, #1
	smull ip, r3, r5, r3
	adds r5, ip, #0x800
	adc r3, r3, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r3, lsl #20
	ldr r2, [r0, #0x44]
	add r3, lr, r5
	sub r2, r3, r2
	str r2, [r0, #0x98]
	ldr r5, [r4, #8]
	ldr r2, [r4, #0x14]
	ldrsh r3, [r4, #0x18]
	sub ip, r2, r5
	ldr r2, [r0, #0x4c]
	smull lr, r3, ip, r3
	adds ip, lr, #0x800
	adc r3, r3, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r3, lsl #20
	add r3, r5, ip
	sub r2, r3, r2
	str r2, [r0, #0xa0]
	cmp r1, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r1, r4
	bl ovl02_215BED8
	mov r0, #0x3c
	strh r0, [r4, #0x1a]
	ldmia sp!, {r3, r4, r5, pc}
_0215C05C:
	str r1, [r0, #0xa0]
	str r1, [r0, #0x98]
	ldrh r0, [r4, #0x1a]
	sub r0, r0, #1
	strh r0, [r4, #0x1a]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_215BFA0

	arm_func_start ovl02_215C074
ovl02_215C074: // 0x0215C074
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x14
	mov r7, r1
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	mov r8, r0
	mov r6, r2
	mov r5, r3
	str r1, [sp, #0xc]
	mov r2, r1
	mov r3, r1
	mov r0, #0x12c
	str r1, [sp, #0x10]
	bl GameObject__SpawnObject
	mov r4, r0
	ldrh r1, [sp, #0x38]
	str r8, [r4, #0x370]
	add r3, r4, #0x300
	ldr r0, [sp, #0x34]
	strh r1, [r3, #0x98]
	str r0, [r4, #0x37c]
	str r7, [r4, #0x44]
	str r6, [r4, #0x48]
	ldr r0, [sp, #0x30]
	str r5, [r4, #0x4c]
	add lr, r4, #0x380
	ldmia r0, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	add ip, r4, #0x38c
	ldmia lr, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	mov r0, #0x3c
	strh r0, [r3, #0x9a]
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	arm_func_end ovl02_215C074

	arm_func_start ovl02_215C10C
ovl02_215C10C: // 0x0215C10C
	stmdb sp!, {r3, lr}
	ldr r3, [r0, #0x380]
	ldr r2, [r0, #0x37c]
	ldr r1, _0215C1C0 // =gPlayer
	smull ip, r2, r3, r2
	adds r3, ip, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [r0, #0x98]
	ldr ip, [r0, #0x384]
	ldr r3, [r0, #0x37c]
	mov r2, #0
	smull lr, r3, ip, r3
	adds ip, lr, #0x800
	adc r3, r3, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r3, lsl #20
	str ip, [r0, #0x9c]
	ldr ip, [r0, #0x388]
	ldr r3, [r0, #0x37c]
	smull lr, r3, ip, r3
	adds ip, lr, #0x800
	adc r3, r3, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r3, lsl #20
	str ip, [r0, #0xa0]
	ldr r3, [r1]
	ldr r1, [r0, #0x4c]
	ldr r3, [r3, #0x4c]
	subs r3, r3, r1
	streq r2, [r0, #0xa0]
	ldmeqia sp!, {r3, pc}
	ldr r1, [r0, #0xa0]
	cmp r3, #0
	add r1, r3, r1
	ble _0215C1A8
	cmp r1, #0
	ble _0215C1B8
_0215C1A8:
	cmp r3, #0
	ldmgeia sp!, {r3, pc}
	cmp r1, #0
	ldmltia sp!, {r3, pc}
_0215C1B8:
	str r3, [r0, #0xa0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215C1C0: .word gPlayer
	arm_func_end ovl02_215C10C

	arm_func_start ovl02_215C1C4
ovl02_215C1C4: // 0x0215C1C4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x60
	ldr r1, _0215C318 // =_02178884
	mov r5, r0
	ldr r4, _0215C31C // =_0217880C
	add r6, sp, #0x54
	ldmia r1, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	add r3, sp, #0x48
	ldmia r4, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, r6
	add r0, r5, #0x380
	mov r6, #0
	bl VEC_DotProduct
	cmp r0, #0
	ldr r1, _0215C320 // =0x00000F33
	rsblt r0, r0, #0
	cmp r0, r1
	add r0, r5, #0x38c
	addlt r6, sp, #0x54
	cmp r6, #0
	add r4, sp, #0x24
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	ldr r0, [sp, #0x28]
	mov r1, r4
	rsb r3, r0, #0
	addeq r6, sp, #0x48
	add r2, sp, #0x3c
	mov r0, r6
	str r3, [sp, #0x28]
	add r4, r5, #0x3cc
	bl VEC_CrossProduct
	add r0, sp, #0x3c
	mov r1, r0
	bl VEC_Normalize
	add r0, sp, #0x24
	add r1, sp, #0x3c
	add r2, sp, #0x30
	bl VEC_CrossProduct
	add r0, sp, #0x3c
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	add r10, sp, #0x30
	add r9, r4, #0xc
	ldmia r10, {r0, r1, r2}
	stmia r9, {r0, r1, r2}
	add r8, sp, #0x24
	add r7, r4, #0x18
	ldmia r8, {r0, r1, r2}
	stmia r7, {r0, r1, r2}
	ldr r4, [r5, #0x37c]
	ldr r3, _0215C324 // =0x00000199
	add lr, r5, #0x300
	mov ip, #0
	umull r8, r7, r4, r3
	mla r7, r4, ip, r7
	mov r2, r4, asr #0x1f
	mla r7, r2, r3, r7
	adds r3, r8, #0x800
	ldrh r1, [lr, #0x9c]
	adc r2, r7, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	mov r2, r3, lsl #0x10
	add r1, r1, r2, lsr #16
	strh r1, [lr, #0x9c]
	ldrh r1, [lr, #0x9c]
	ldr r6, _0215C328 // =FX_SinCosTable_
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r6, r1]
	ldrsh r2, [r6, r2]
	blx MTX_RotZ33_
	add r1, r5, #0x3cc
	add r0, sp, #0
	mov r2, r1
	bl MTX_Concat33
	add sp, sp, #0x60
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0215C318: .word _02178884
_0215C31C: .word _0217880C
_0215C320: .word 0x00000F33
_0215C324: .word 0x00000199
_0215C328: .word FX_SinCosTable_
	arm_func_end ovl02_215C1C4

	arm_func_start ovl02_215C32C
ovl02_215C32C: // 0x0215C32C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x374]
	blx r1
	mov r0, r4
	bl ovl02_215C10C
	mov r0, r4
	bl ovl02_215C1C4
	ldmia sp!, {r4, pc}
	arm_func_end ovl02_215C32C

	arm_func_start ovl02_215C350
ovl02_215C350: // 0x0215C350
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	bl GetCurrentTaskWork_
	mov r6, r0
	ldr r0, [r6, #0x18]
	tst r0, #0xc
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, pc}
	tst r0, #2
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, pc}
	ldr r5, _0215C3D8 // =_02178830
	add r8, r6, #0x218
	mov r7, #0
	add r4, sp, #0
_0215C38C:
	ldr r0, [r8, #0x18]
	tst r0, #4
	beq _0215C3C0
	ldr r0, [r5, r7, lsl #2]
	mov r3, r4
	add r1, r6, #0x38c
	add r2, r6, #0x44
	bl VEC_MultAdd
	ldr r1, [sp]
	ldr r2, [sp, #4]
	ldr r3, [sp, #8]
	mov r0, r8
	bl BossHelpers__Collision__Func_20390AC
_0215C3C0:
	add r7, r7, #1
	cmp r7, #3
	add r8, r8, #0x40
	blt _0215C38C
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215C3D8: .word _02178830
	arm_func_end ovl02_215C350

	arm_func_start ovl02_215C3DC
ovl02_215C3DC: // 0x0215C3DC
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	ldr r1, [r1, #0x1c]
	ldr r2, [r0, #0x1c]
	ldrh r0, [r1]
	cmp r0, #1
	addne sp, sp, #0x14
	ldmneia sp!, {pc}
	mov r3, #0
_0215C400:
	add r1, r2, r3, lsl #6
	ldr r0, [r1, #0x230]
	add r3, r3, #1
	orr r0, r0, #0x800
	str r0, [r1, #0x230]
	cmp r3, #3
	blt _0215C400
	ldr r1, [r2, #0x18]
	mov r0, #0x14000
	orr r1, r1, #8
	str r1, [r2, #0x18]
	ldr r1, [r2, #0x370]
	add r3, sp, #8
	ldr r1, [r1, #0x370]
	rsb r0, r0, #0
	add ip, r1, #0x400
	ldrh lr, [ip, #0x24]
	add r1, r2, #0x38c
	add r2, r2, #0x44
	sub lr, lr, #1
	strh lr, [ip, #0x24]
	bl VEC_MultAdd
	ldr r0, [sp, #0xc]
	ldr r1, [sp, #8]
	rsb r2, r0, #0
	ldr r3, [sp, #0x10]
	mov r0, #0
	bl BossFX__CreateBomb
	mov ip, #0x99
	sub r1, ip, #0x9a
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	add sp, sp, #0x14
	ldmia sp!, {pc}
	arm_func_end ovl02_215C3DC

	arm_func_start ovl02_215C494
ovl02_215C494: // 0x0215C494
	mov r2, #0
	ldr r1, _0215C4A8 // =ovl02_215C4C4
	str r2, [r0, #0x378]
	str r1, [r0, #0x374]
	bx lr
	.align 2, 0
_0215C4A8: .word ovl02_215C4C4
	arm_func_end ovl02_215C494

	arm_func_start ovl02_215C4AC
ovl02_215C4AC: // 0x0215C4AC
	mov r2, #1
	ldr r1, _0215C4C0 // =ovl02_215C6A0
	str r2, [r0, #0x378]
	str r1, [r0, #0x374]
	bx lr
	.align 2, 0
_0215C4C0: .word ovl02_215C6A0
	arm_func_end ovl02_215C4AC

	arm_func_start ovl02_215C4C4
ovl02_215C4C4: // 0x0215C4C4
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	add r0, r4, #0x300
	ldrh r1, [r0, #0x9a]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x9a]
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x370]
	bl ovl02_21558E8
	cmp r0, #0
	bne _0215C50C
	mov r0, r4
	bl ovl02_215C4AC
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
_0215C50C:
	ldr r0, _0215C68C // =gPlayer
	add r2, sp, #0
	ldr r0, [r0]
	add r1, r4, #0x44
	add r0, r0, #0x44
	bl VEC_Subtract
	add r0, sp, #0
	mov r1, r0
	bl VEC_Normalize
	ldr r0, [r4, #0x3a0]
	cmp r0, #0
	beq _0215C630
	add r2, r4, #0x300
	ldrh r0, [r2, #0xa6]
	cmp r0, #0
	bne _0215C57C
	ldr r3, _0215C690 // =_mt_math_rand
	ldr r0, _0215C694 // =0x00196225
	ldr ip, [r3]
	ldr r1, _0215C698 // =0x3C6EF35F
	mla r1, ip, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x7f
	str r1, [r3]
	add r0, r0, #0x3c
	strh r0, [r2, #0xa6]
_0215C57C:
	add r0, r4, #0x300
	ldrh r2, [r0, #0xa6]
	ldrh r1, [r0, #0xa4]
	cmp r2, r1
	bhs _0215C5F8
	add r0, sp, #0
	add r1, r4, #0x380
	bl VEC_DotProduct
	ldr r1, _0215C69C // =0x02113350
	ldrsh r1, [r1, #0xaa]
	cmp r1, r0
	bgt _0215C5EC
	ldr r2, [sp, #4]
	ldr ip, [sp]
	smull r1, r0, r2, r2
	smull r3, r2, ip, ip
	adds r3, r3, #0x800
	adc r2, r2, #0
	adds r1, r1, #0x800
	mov r3, r3, lsr #0xc
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r3, r3, r2, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r3, r1
	bl FX_Sqrt
	cmp r0, #0x32000
	ble _0215C600
_0215C5EC:
	mov r0, #0
	str r0, [r4, #0x3a0]
	b _0215C600
_0215C5F8:
	add r1, r1, #1
	strh r1, [r0, #0xa4]
_0215C600:
	add r0, r4, #0x300
	ldrh r2, [r0, #0x98]
	mov r1, #0x1800
	add r0, r4, #0x38c
	mul r1, r2, r1
	mov r2, r1, lsl #4
	add r1, r4, #0x380
	mov r2, r2, lsr #0x10
	mov r3, r0
	bl sub_2066AC0
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
_0215C630:
	add r0, r4, #0x300
	ldrh r2, [r0, #0x98]
	add r0, r4, #0x380
	add r1, sp, #0
	mov r3, r0
	bl sub_2066AC0
	str r0, [r4, #0x3a0]
	add r0, r4, #0x300
	ldrh r2, [r0, #0x98]
	mov r0, #0x1800
	add r1, sp, #0
	mul r0, r2, r0
	mov r2, r0, lsl #4
	add r0, r4, #0x38c
	mov r2, r2, lsr #0x10
	mov r3, r0
	bl sub_2066AC0
	add r0, r4, #0x300
	mov r1, #0
	strh r1, [r0, #0xa4]
	strh r1, [r0, #0xa6]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0215C68C: .word gPlayer
_0215C690: .word _mt_math_rand
_0215C694: .word 0x00196225
_0215C698: .word 0x3C6EF35F
_0215C69C: .word 0x02113350
	arm_func_end ovl02_215C4C4

	arm_func_start ovl02_215C6A0
ovl02_215C6A0: // 0x0215C6A0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	mov r10, r0
	ldr r0, [r10, #0x18]
	mov r2, #0
	orr r0, r0, #8
	str r0, [r10, #0x18]
_0215C6BC:
	add r1, r10, r2, lsl #6
	ldr r0, [r1, #0x230]
	add r2, r2, #1
	bic r0, r0, #4
	str r0, [r1, #0x230]
	cmp r2, #3
	blt _0215C6BC
	ldr r4, _0215C7B0 // =ovl02_215C3DC
	add r8, r10, #0x218
	mov r9, #0
	mov r7, #2
	mov r11, #0x40
	mov r6, #4
	mvn r5, #3
_0215C6F4:
	mov r0, r8
	mov r1, r7
	mov r2, r11
	bl ObjRect__SetAttackStat
	mov r0, r8
	mov r1, #3
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	str r6, [sp]
	str r6, [sp, #4]
	str r6, [sp, #8]
	mov r0, r8
	mov r1, r5
	mov r2, r5
	mov r3, r5
	bl ObjRect__SetBox3D
	str r10, [r8, #0x1c]
	str r4, [r8, #0x20]
	ldr r0, [r8, #0x18]
	add r9, r9, #1
	orr r0, r0, #4
	str r0, [r8, #0x18]
	cmp r9, #3
	add r8, r8, #0x40
	blt _0215C6F4
	mov r0, #0x14000
	add r3, sp, #0xc
	rsb r0, r0, #0
	add r1, r10, #0x38c
	add r2, r10, #0x44
	bl VEC_MultAdd
	ldr r0, [sp, #0x10]
	ldr r1, [sp, #0xc]
	rsb r2, r0, #0
	ldr r3, [sp, #0x14]
	mov r0, #0
	bl BossFX__CreateBomb
	ldr r0, [r10, #0x370]
	ldr r1, _0215C7B4 // =ovl02_215C7B8
	ldr r0, [r0, #0x370]
	add r0, r0, #0x400
	ldrh r2, [r0, #0x24]
	sub r2, r2, #1
	strh r2, [r0, #0x24]
	str r1, [r10, #0x374]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0215C7B0: .word ovl02_215C3DC
_0215C7B4: .word ovl02_215C7B8
	arm_func_end ovl02_215C6A0

	arm_func_start ovl02_215C7B8
ovl02_215C7B8: // 0x0215C7B8
	bx lr
	arm_func_end ovl02_215C7B8

	arm_func_start ovl02_215C7BC
ovl02_215C7BC: // 0x0215C7BC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	mov r4, r0
	str r3, [sp, #0x10]
	ldr ip, [r4, #0x38c]
	ldr r0, _0215C80C // =0x0000012D
	add r2, ip, r2
	rsb r2, r2, #0
	bl GameObject__SpawnObject
	mov r1, #0x320000
	rsb r1, r1, #0
	str r1, [r0, #0x4c]
	str r4, [r0, #0x364]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0215C80C: .word 0x0000012D
	arm_func_end ovl02_215C7BC

	arm_func_start ovl02_215C810
ovl02_215C810: // 0x0215C810
	ldr r1, [r0, #0x364]
	ldr r1, [r1, #0x3a4]
	str r1, [r0, #0xa0]
	ldr r1, [r0, #0x4c]
	cmp r1, #0x30000
	ldrgt r1, [r0, #0x18]
	orrgt r1, r1, #8
	strgt r1, [r0, #0x18]
	bx lr
	arm_func_end ovl02_215C810

	arm_func_start ovl02_215C834
ovl02_215C834: // 0x0215C834
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x368]
	cmp r0, #0
	ldreq r5, [r4, #0x36c]
	beq _0215C864
	add r5, r4, #0x370
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
_0215C864:
	add r0, r4, #0x44
	add r3, r5, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r5, #0x4c]
	mov r0, r5
	rsb r1, r1, #0
	str r1, [r5, #0x4c]
	bl AnimatorSprite3D__Draw
	ldr r0, [r4, #0x368]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0xcc]
	tst r0, #0x40000000
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #8
	strne r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl02_215C834

	arm_func_start ovl02_215C8AC
ovl02_215C8AC: // 0x0215C8AC
	stmdb sp!, {r3, lr}
	ldr r0, [r0, #0x1c]
	ldr r3, [r1, #0x1c]
	ldrh r1, [r0]
	cmp r1, #1
	ldmneia sp!, {r3, pc}
	ldr r2, [r3, #0x230]
	mov r1, #1
	orr r2, r2, #0x800
	bic r2, r2, #4
	str r2, [r3, #0x230]
	str r1, [r3, #0x368]
	bl Player__GiveRings
	ldmia sp!, {r3, pc}
	arm_func_end ovl02_215C8AC

	.rodata

_021787E0: // 0x021787E0
    .word 0x19902CC
	
_021787E4: // 0x021787E4
    .word 0
	
_021787E8: // 0x021787E8
    .word 0x14000
	
_021787EC: // 0x021787EC
    .word 0xA000

_021787F0: // 0x021787F0
    .word 0x330040
	
_021787F4: // 0x021787F4
    .word 4

_021787F8: // 0x021787F8
    .word 4

_021787FC: // 0x021787FC
    .word 0

_02178800: // 0x02178800
    .word 0

_02178804: // 0x02178804
    .word 1, 2
	
_0217880C: // 0x0217880C
    .word 0, 0

_02178814: // 0x02178814
    .word 0x1000

_02178818: // 0x02178818
    .word 0, 0
	
_02178820: // 0x02178820
    .word 0x1000

_02178824: // 0x02178824
    .word 0
	
_02178828: // 0x02178828
    .word 0x10000

_0217882C: // 0x0217882C
    .word 0x20001

_02178830: // 0x02178830
    .word 0xFFFF8000

_02178834: // 0x02178834
    .word 0xFFFEC000

_02178838: // 0x02178838
    .word 0xFFFE0000

_0217883C: // 0x0217883C
    .word 3
	
_02178840: // 0x02178840
    .word 0

_02178844: // 0x02178844
    .word 3

_02178848: // 0x02178848
    .word 0

_0217884C: // 0x0217884C
    .word 0x1000, 0

_02178854: // 0x02178854
    .word 0

_02178858: // 0x02178858
    .word 0x1000, 0

_02178860: // 0x02178860
    .word 0x2D800B6, 0x88805B0, 0xE380B60
	
_0217886C: // 0x0217886C
    .word 0

_02178870: // 0x02178870
    .word 0x1000, 0

_02178878: // 0x02178878
    .word 0

_0217887C: // 0x0217887C
    .word 0x1000, 0

_02178884: // 0x02178884
    .word 0

_02178888: // 0x02178888
    .word 0x1000, 0

_02178890: // 0x02178890
    .word 0, 0

_02178898: // 0x02178898
    .word 0x1000

_0217889C: // 0x0217889C
    .word 1

_021788A0: // 0x021788A0
    .word 0

_021788A4: // 0x021788A4
    .word 2

_021788A8: // 0x021788A8
    .word 2, 0

_021788B0: // 0x021788B0
    .word 1, 0

_021788B8: // 0x021788B8
    .word 2, 0, 0, 0

_021788C8: // 0x021788C8
    .word 2, 0

_021788D0: // 0x021788D0
    .word 1, 0

_021788D8: // 0x021788D8
    .word 0, 0
	
_021788E0: // 0x021788E0
    .word 1, 0

_021788E8: // 0x021788E8
    .word 0

_021788EC: // 0x021788EC
    .word 1, 0, 0

_021788F8: // 0x021788F8
    .word 0, 0, 0
	
_02178904: // 0x02178904
    .word 1

_02178908: // 0x02178908
    .word 0

_0217890C: // 0x0217890C
    .word 1, 0, 0

_02178918: // 0x02178918
    .word 0

_0217891C: // 0x0217891C
    .word 1, 0, 0

_02178928: // 0x02178928
    .word 0, 0

_02178930: // 0x02178930
    .word 1, 0

_02178938: // 0x02178938
    .word 0, 0

_02178940: // 0x02178940
    .word 1, 0

_02178948: // 0x02178948
    .word 2, 0
	
_02178950: // 0x02178950
    .word 1, 0
	
_02178958: // 0x02178958
    .word 0x7001E, 0x14000A, 0xA0003
	
_02178964: // 0x02178964
    .hword 5
	
_02178966: // 0x02178966
    .hword 3
	
_02178968: // 0x02178968
    .hword 5
	
_0217896A: // 0x0217896A
    .hword 0

_0217896C: // 0x0217896C
    .word 0x16C03FF, 0x2D803FF, 0x71C03FF, 0xB6003FF, 0xE3803FF
    .word 0x3FF

_02178984: // 0x02178984
    .word 0x1000, 0xE66, 0xCCC, 0x999, 0x800, 0x666
	                        
_0217899C: // 0x0217899C
    .word 0x3C, 0x3000, 0x2D, 0x3800
	
_021789AC: // 0x021789AC
    .word 0x1E, 0x4000
	
_021789B4: // 0x021789B4
    .hword 0x3C, 0x78, 0x3C, 0x3C
	
_021789BC: // 0x021789BC
    .word 0x8000, 0xB4003C, 0x2D005A, 0x8800

_021789CC: // 0x021789CC
    .word 0xF0003C, 0x1E0078, 0x9000
	
_021789D8: // 0x021789D8
    .word 0

_021789DC: // 0x021789DC
    .word 0x3840000, 0x1E000F, 0xF0258, 0x1E, 0

_021789F0: // 0x021789F0
    .word 0x70258, 0x12C001E, 0x1E0007

_021789FC: // 0x021789FC
    .word 0x2000
	 
_02178A00: // 0x02178A00
    .word 0x6000, 0x2800, 0x5999, 0x3000, 0x5333, 0x4000, 0x4CCC, 0x4800, 0x4666, 0x5000, 0x4000

_02178A2C: // 0x02178A2C
    .word 0xA, 1, 0x6ED39, 0

_02178A3C: // 0x02178A3C
    .word 4, 0

_02178A44: // 0x02178A44
    .word 0xC37CD, 0x12C000, 4, 1, 0x447EF, 0x12C000, 0xFFFF, 2, 0, 0

_02178A6C: // 0x02178A6C
    .word 0xA, 0

_02178A74: // 0x02178A74
    .word 0xC37CD, 0

_02178A7C: // 0x02178A7C
    .word 4, 0

_02178A84: // 0x02178A84
    .word 0x1A2A5, 0x12C000, 4, 0

_02178A94: // 0x02178A94
    .word 0x99283, 0x12C000, 0xFFFF, 2, 0, 0

_02178AAC: // 0x02178AAC
    .word 0xA, 0

_02178AB4: // 0x02178AB4
    .word 0x6ED39, 0

_02178ABC: // 0x02178ABC
    .word 2, 0

_02178AC4: // 0x02178AC4
    .word 0x99283, 0

_02178ACC: // 0x02178ACC
    .word 4, 1, 0x447EF, 0x96000, 2, 1, 0xC37CD, 0

_02178AEC: // 0x02178AEC
    .word 0xFFFF, 2, 0, 0

_02178AFC: // 0x02178AFC
    .word 0xA, 0

_02178B04: // 0x02178B04
    .word 0x447EF, 0

_02178B0C: // 0x02178B0C
    .word 4, 0

_02178B14: // 0x02178B14
    .word 0xC37CD, 0x96000, 4, 0

_02178B24: // 0x02178B24
    .word 0x6ED39, 0x12C000, 4, 0

_02178B34: // 0x02178B34
    .word 0x99283, 0x12C000, 0xFFFF, 2, 0, 0

_02178B4C: // 0x02178B4C
    .word 0xA, 1, 0x6ED39, 0
    .word 4, 1, 0xC37CD, 0x96000, 4, 0
    .word 0xEDD17, 0x12C000, 4, 1, 0x99283, 0x12C000, 0xFFFF
    .word 2, 0, 0

_02178B9C: // 0x02178B9C
    .word _021787E4, 1, _021787E4, 1, _021787FC
    .word 2, _021787FC, 2, _021787FC, 2, _02178804
    .word 2, _0217889C, 3, _0217883C, 3

_02178BDC: // 0x02178BDC
    .word _02178804, 2, _0217889C, 3, _0217883C
    .word 3, _021787F4, 2

_02178BFC: // 0x02178BFC
    .word 0xA, 1, 0x99283, 0, 4, 1, 0x6ED39, 0x1C2000, 4, 0
    .word 0x447EF, 0x1C2000, 4, 0, 0xC37CD, 0x12C000, 4, 1, 0x6ED39
    .word 0x12C000, 0xFFFF, 2, 0, 0

_02178C5C: // 0x02178C5C
    .word 0xA, 1, 0x447EF, 0

_02178C6C: // 0x02178C6CC
    .word 4, 1, 0x99283, 0x12C000, 4, 1, 0x6ED39, 0x96000, 4
    .word 1, 0xC37CD, 0x12C000, 4, 0
    .word 0x447EF, 0x1C2000, 4, 1, 0x99283, 0x12C000, 0xFFFF
    .word 2, 0, 0

_02178CCC: // 0x02178CCC
    .word 0xA, 0x76539, 0

	.data

_021794DC: // 0x021794DC
    .word aZ6BAPl_0 // "z6_b_a_pl"

_021794E0: // 0x021794E0
    .word 0x10001
	
_021794E4: // 0x021794E4
    .hword 2
	
_021794E6: // 0x021794E6
    .hword 0
	
_021794E8: // 0x021794E8
	.byte 0x3C, 0

_021794EA: // 0x021794EA
    .hword 0x5B
	
_021794EC: // 0x021794EC
    .word _02179524
	.word _02179534
	.word _02179514

_021794F8: // 0x021794F8
    .word 0x5000, 0x8000
	
_02179500: // 0x02179500
    .word 0xB000
	
_02179504: // 0x02179504
    .word aZ6CloudPl_0        // "z6_cloud_pl"
	.word aZ6Sky1Pl_0         // "z6_sky_1_pl"
	.word aZ6Sky2Pl_0         // "z6_sky_2_pl"
	.word aZ6Sky3Pl_0         // "z6_sky_3_pl"

_02179514: // 0x02179514
    .word _02178948
	.word _021788A8
	.word _021788B8
	.word _021788C8

_02179524: // 0x02179524
    .word _021788D8
	.word _021788D8
	.word _021788E8
	.word _021788F8

_02179534: // 0x02179534
    .word _02178908
	.word _02178918
	.word _02178928
	.word _02178938

_02179544: // 0x02179544
	.word 0

_02179548: // 0x02179548
    .word 0x4B00000, 0x1E000F, 0x70384, 0x1E

_02179558: // 0x02179558
    .word _02178AAC
	.word _02178A2C
	.word _02178A6C
	.word _02178AFC
	.word _02178B4C
	.word _02178C5C
	.word _02178BFC

_02179574: // 0x02179574
    .word _02178AAC
	.word _02178A2C
	.word _02178A6C
	.word _02178AFC
	.word _02178B4C
	.word _02178C5C
	.word _02178BFC

_02179590: // 0x02179590
    .word aFacePl             // "face_pl"
	.word aEyeAPl             // "eye_a_pl"
	.word aJetBPl_0           // "jet_b_pl"
	.word aKaitenPl_0         // "kaiten_pl"
	.word aKaitenBPl_0        // "kaiten_b_pl"
	.word aKaitenSidePl_0     // "kaiten_side_pl"
	.word aPDPl               // "p_d_pl"
	.word aPDbPl              // "p_db_pl"
	.word aSideAPl_0          // "side_a_pl"
	.word aSideBPl_0          // "side_b_pl"
	.word aStomacPl_0         // "stomac_pl"
	.word aTunoPl             // "tuno_pl"

aPDPl: // 0x021795C0
    .asciz "p_d_pl"
    .align 4

aFacePl: // 0x021795C8
    .asciz "face_pl"
    .align 4

aPDbPl: // 0x021795D0
    .asciz "p_db_pl"
    .align 4

aTunoPl: // 0x021795D8
    .asciz "tuno_pl"
    .align 4

aEyeAPl: // 0x021795E0
    .asciz "eye_a_pl"
    .align 4

aJetBPl_0: // 0x021795EC
    .asciz "jet_b_pl"
    .align 4

aZ6BAPl_0: // 0x021795F8
    .asciz "z6_b_a_pl"
    .align 4

aSideAPl_0: // 0x02179604
    .asciz "side_a_pl"
    .align 4

aSideBPl_0: // 0x02179610
    .asciz "side_b_pl"
    .align 4

aKaitenPl_0: // 0x0217961C
    .asciz "kaiten_pl"
    .align 4

aStomacPl_0: // 0x02179628
    .asciz "stomac_pl"
    .align 4

aZ6Sky1Pl_0: // 0x02179634
    .asciz "z6_sky_1_pl"
    .align 4

aZ6Sky2Pl_0: // 0x02179640
    .asciz "z6_sky_2_pl"
    .align 4

aZ6Sky3Pl_0: // 0x0217964C
    .asciz "z6_sky_3_pl"
    .align 4

aKaitenBPl_0: // 0x02179658
    .asciz "kaiten_b_pl"
    .align 4

aZ6CloudPl_0: // 0x02179664
    .asciz "z6_cloud_pl"
    .align 4

aKaitenSidePl_0: // 0x02179670
    .asciz "kaiten_side_pl"
    .align 4

_02179680: // 0x02179680
    .word 0
	
_02179684: // 0x02179684
    .word 0x637865
	
aZ6TaLinePl: // 0x02179688
    .asciz "z6_ta_line_pl"
    .align 4

aBoss6Nsbca: // 0x02179698
    .asciz "/boss6.nsbca"
    .align 4

aBodyWeak_0: // 0x021796A8
    .asciz "body_weak"
    .align 4

aBodyMuzzle_0: // 0x021796B4
    .asciz "body_muzzle"
    .align 4