	.include "asm/macros.inc"
	.include "global.inc"

.public BossArena__explosionFXSpawnTime

	.bss

_0217AFB8: // 0x0217AFB8
	.space 0x04
	
	.text

	thumb_func_start Boss5Stage__Create
Boss5Stage__Create: // _021739C4
	push {r4, r5, r6, r7, lr}
	sub sp, #0x1c
	mov r5, r0
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	ldr r0, _02173BDC // =0x00001130
	str r1, [sp, #0x14]
	str r2, [sp, #0x18]
	str r0, [sp, #8]
	mov r2, #0
	ldr r0, _02173BE0 // =StageTask_Main
	ldr r1, _02173BE4 // =ovl01_2176E28
	mov r3, r2
	bl TaskCreate_
	ldr r1, _02173BE8 // =_0217AFB8
	str r0, [r1]
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02173BDC // =0x00001130
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	ldr r2, [sp, #0x14]
	ldr r3, [sp, #0x18]
	mov r0, r4
	mov r1, r5
	bl GameObject__InitFromObject
	mov r0, r4
	ldr r1, _02173BEC // =ovl01_2176DDC
	add r0, #0xf4
	str r1, [r0]
	mov r0, r4
	ldr r1, _02173BF0 // =ovl01_2176EAC
	add r0, #0xfc
	str r1, [r0]
	ldr r1, [r4, #0x18]
	mov r0, #0x12
	orr r1, r0
	str r1, [r4, #0x18]
	ldr r2, [r4, #0x20]
	ldr r1, _02173BF4 // =0x00002184
	sub r0, #0x13
	orr r1, r2
	str r1, [r4, #0x20]
	mov r1, #0xa3
	ldr r2, [r4, #0x1c]
	lsl r1, r1, #8
	orr r1, r2
	str r1, [r4, #0x1c]
	ldr r1, _02173BF8 // =0x000034CC
	mov r2, #1
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	lsl r2, r2, #0xa
	str r1, [r4, #0x40]
	mov r1, r2
	sub r1, #0x74
	strh r2, [r4, r1]
	ldr r1, [sp, #0x18]
	neg r3, r1
	mov r1, r2
	sub r1, #0x70
	str r3, [r4, r1]
	mov r1, r2
	sub r1, #0x7e
	strh r0, [r4, r1]
	mov r0, #0xd3
	lsl r0, r0, #4
	add r0, r4, r0
	mov r1, #0x88
	bl MI_CpuFill8
	mov r0, #0xd9
	lsl r0, r0, #2
	add r0, r4, r0
	bl ovl01_2175328
	mov r0, #0xe5
	lsl r0, r0, #2
	add r0, r4, r0
	bl BossHelpers__Light__Init
	ldr r0, _02173BFC // =0x000003C6
	add r0, r4, r0
	bl BossHelpers__Light__Init
	bl BossHelpers__Model__InitSystem
	ldr r0, _02173C00 // =0x0000040C
	ldr r2, _02173C04 // =_0217AEF4
	add r5, r4, r0
	ldr r0, _02173C08 // =0x02133A18
	mov r3, #0
	str r0, [sp]
	mov r0, r4
	mov r1, r5
	str r3, [sp, #4]
	bl ObjAction3dNNModelLoad
	mov r0, #0x4b
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r4, r0]
	ldr r0, _02173BE8 // =_0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x39
	lsl r1, r1, #4
	ldr r6, [r0, r1]
	mov r0, #0
	bl ovl01_21772CC
	asr r0, r0, #1
	str r0, [r5, #0x48]
	str r6, [r5, #0x4c]
	mov r3, #0
	ldr r0, _02173C0C // =gameArchiveStage
	str r3, [r5, #0x50]
	ldr r0, [r0, #0]
	ldr r2, _02173C10 // =aBoss5Nsbta
	str r0, [sp]
	mov r0, r4
	mov r1, r5
	bl ObjAction3dNNMotionLoad
	mov r3, #0
	str r3, [sp]
	mov r2, #0x56
	ldr r0, _02173C00 // =0x0000040C
	str r3, [sp, #4]
	lsl r2, r2, #4
	ldr r2, [r4, r2]
	add r0, r4, r0
	mov r1, #3
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02173C14 // =0x00000898
	ldr r2, _02173C04 // =_0217AEF4
	add r5, r4, r0
	ldr r0, _02173C08 // =0x02133A18
	mov r1, r5
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r4
	mov r3, #8
	bl ObjAction3dNNModelLoad
	mov r0, #0x4b
	mov r3, #0
	lsl r0, r0, #2
	str r3, [r4, r0]
	mov r0, #0xfa
	lsl r0, r0, #0xe
	str r0, [r5, #0x18]
	str r0, [r5, #0x1c]
	str r0, [r5, #0x20]
	ldr r0, _02173C0C // =gameArchiveStage
	ldr r2, _02173C10 // =aBoss5Nsbta
	ldr r0, [r0, #0]
	mov r1, r5
	str r0, [sp]
	mov r0, r4
	bl ObjAction3dNNMotionLoad
	mov r0, #0
	str r0, [sp]
	mov r3, #1
	mov r2, #0x55
	str r3, [sp, #4]
	lsl r2, r2, #2
	ldr r2, [r5, r2]
	mov r0, r5
	mov r1, #3
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02173C18 // =0x00000588
	mov r6, #0
	add r7, r4, r0
	mov r5, r6
_02173B3C:
	ldr r0, _02173C08 // =0x02133A18
	ldr r2, _02173C04 // =_0217AEF4
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r4
	mov r1, r7
	add r3, r6, #6
	bl ObjAction3dNNModelLoad
	mov r0, #0x4b
	lsl r0, r0, #2
	str r5, [r4, r0]
	add r0, #0x50
	add r6, r6, #1
	add r7, r7, r0
	cmp r6, #2
	blt _02173B3C
	ldr r0, _02173C1C // =0x00000A14
	add r6, r4, r0
	ldr r0, _02173C20 // =VRAMSystem__VRAM_PALETTE_BG
	ldr r7, [r0, #0]
_02173B68:
	mov r0, #0
	str r0, [sp]
	mov r1, #0x37
	lsl r2, r5, #0x10
	str r7, [sp, #4]
	lsl r1, r1, #4
	ldr r1, [r4, r1]
	mov r0, r6
	lsr r2, r2, #0x10
	mov r3, #2
	bl InitPaletteAnimator
	add r5, r5, #1
	add r6, #0x20
	cmp r5, #8
	blt _02173B68
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	ldr r0, _02173C24 // =0x00000122
	ldr r1, [sp, #0x14]
	ldr r2, [sp, #0x18]
	str r3, [sp, #0x10]
	bl GameObject__SpawnObject
	mov r1, #0xdd
	lsl r1, r1, #2
	str r0, [r4, r1]
	mov r0, #0
	bl ovl01_21772CC
	mov r1, r0
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	ldr r0, _02173C28 // =0x00000123
	ldr r2, [sp, #0x18]
	asr r1, r1, #1
	str r3, [sp, #0x10]
	bl GameObject__SpawnObject
	mov r1, #0xde
	lsl r1, r1, #2
	str r0, [r4, r1]
	bl InitSpatialAudioConfig
	mov r0, #0xdf
	ldr r1, _02173C2C // =ovl01_2177018
	lsl r0, r0, #2
	str r1, [r4, r0]
	mov r0, r4
	add sp, #0x1c
	pop {r4, r5, r6, r7, pc}
	nop
_02173BDC: .word 0x00001130
_02173BE0: .word StageTask_Main
_02173BE4: .word ovl01_2176E28
_02173BE8: .word _0217AFB8
_02173BEC: .word ovl01_2176DDC
_02173BF0: .word ovl01_2176EAC
_02173BF4: .word 0x00002184
_02173BF8: .word 0x000034CC
_02173BFC: .word 0x000003C6
_02173C00: .word 0x0000040C
_02173C04: .word _0217AEF4
_02173C08: .word 0x02133A18
_02173C0C: .word gameArchiveStage
_02173C10: .word aBoss5Nsbta
_02173C14: .word 0x00000898
_02173C18: .word 0x00000588
_02173C1C: .word 0x00000A14
_02173C20: .word VRAMSystem__VRAM_PALETTE_BG
_02173C24: .word 0x00000122
_02173C28: .word 0x00000123
_02173C2C: .word ovl01_2177018
	thumb_func_end Boss5Stage__Create

	thumb_func_start Boss5__Create
Boss5__Create: // _02173C30
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x78
	mov r5, r0
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0xb3
	lsl r0, r0, #4
	mov r6, r1
	mov r7, r2
	str r0, [sp, #8]
	mov r2, #0
	ldr r0, _02173E8C // =StageTask_Main
	ldr r1, _02173E90 // =ovl01_2177584
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r2, #0xb3
	mov r0, #0
	mov r1, r4
	lsl r2, r2, #4
	bl MIi_CpuClear16
	ldr r0, _02173E94 // =_0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0xdd
	lsl r1, r1, #2
	str r0, [r4, r1]
	mov r0, r4
	mov r1, r5
	mov r2, r6
	mov r3, r7
	bl GameObject__InitFromObject
	mov r0, r4
	ldr r1, _02173E98 // =ovl01_2177568
	add r0, #0xf4
	str r1, [r0]
	mov r0, r4
	ldr r1, _02173E9C // =ovl01_21775D8
	add r0, #0xfc
	str r1, [r0]
	mov r1, #0x42
	ldr r0, _02173EA0 // =ovl01_2177654
	lsl r1, r1, #2
	str r0, [r4, r1]
	ldr r2, [r4, #0x18]
	mov r0, #0x10
	orr r2, r0
	str r2, [r4, #0x18]
	ldr r2, [r4, #0x20]
	add r1, #0x78
	orr r1, r2
	str r1, [r4, #0x20]
	mov r1, #0x9f
	ldr r2, [r4, #0x1c]
	lsl r1, r1, #8
	orr r1, r2
	str r1, [r4, #0x1c]
	lsl r0, r0, #8
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	ldr r0, _02173E94 // =_0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x39
	lsl r1, r1, #4
	ldr r0, [r0, r1]
	sub r1, #0x2c
	neg r2, r0
	mov r0, #0
	str r0, [r4, #0x44]
	str r2, [r4, #0x48]
	str r0, [r4, #0x4c]
	add r0, r4, r1
	bl ovl01_2175328
	bl AllocSndHandle
	mov r1, #0xb2
	lsl r1, r1, #4
	str r0, [r4, r1]
	bl AllocSndHandle
	ldr r1, _02173EA4 // =0x00000B24
	str r0, [r4, r1]
	mov r0, #0x86
	lsl r0, r0, #2
	add r5, r4, r0
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #2
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r3, #0x20
	str r3, [sp]
	str r3, [sp, #4]
	mov r1, r3
	mov r2, r3
	str r3, [sp, #8]
	mov r0, r5
	sub r1, #0x28
	sub r2, #0x50
	sub r3, #0x40
	bl ObjRect__SetBox3D
	ldr r0, _02173EA8 // =ovl01_21777A8
	str r4, [r5, #0x1c]
	str r0, [r5, #0x24]
	mov r0, #0
	mov r1, r4
	bl ovl01_2177540
	mov r0, #0x96
	lsl r0, r0, #2
	add r5, r4, r0
	mov r0, r5
	mov r1, #3
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #3
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r3, #0x20
	mov r0, #0x78
	str r0, [sp]
	str r0, [sp, #4]
	mov r1, r3
	mov r2, r3
	str r3, [sp, #8]
	mov r0, r5
	sub r1, #0x8e
	sub r2, #0x98
	sub r3, #0x40
	bl ObjRect__SetBox3D
	mov r0, #1
	mov r1, r4
	str r4, [r5, #0x1c]
	bl ovl01_2177540
	mov r0, #0xa6
	lsl r0, r0, #2
	add r5, r4, r0
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #2
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r0, #0x78
	mov r3, #0x20
	str r0, [sp]
	str r0, [sp, #4]
	mov r1, r3
	sub r1, #0x98
	str r3, [sp, #8]
	mov r0, r5
	mov r2, r1
	sub r3, #0x40
	bl ObjRect__SetBox3D
	ldr r0, _02173EAC // =ovl01_2177858
	str r4, [r5, #0x1c]
	str r0, [r5, #0x24]
	mov r0, #2
	mov r1, r4
	bl ovl01_2177540
	mov r0, #0x9a
	lsl r0, r0, #4
	add r5, r4, r0
	ldr r0, _02173EB0 // =bossAssetFiles
	ldr r2, _02173EB4 // =_0217AEF4
	str r0, [sp]
	mov r3, #0
	mov r0, r4
	mov r1, r5
	str r3, [sp, #4]
	bl ObjAction3dNNModelLoad
	mov r0, #0x4b
	mov r3, #0
	lsl r0, r0, #2
	str r3, [r4, r0]
	ldr r0, _02173EB8 // =0x000034CC
	ldr r2, _02173EBC // =aBoss5Nsbca
	str r0, [r5, #0x18]
	str r0, [r5, #0x1c]
	str r0, [r5, #0x20]
	mov r0, #4
	strb r0, [r5, #0xa]
	ldr r0, _02173EC0 // =gameArchiveStage
	strb r3, [r5, #0xb]
	ldr r0, [r0, #0]
	mov r1, r5
	str r0, [sp]
	mov r0, r4
	bl ObjAction3dNNMotionLoad
	mov r0, #3
	str r0, [sp]
	mov r0, r5
	ldr r1, _02173EC4 // =BossHelpers__Model__RenderCallback
	add r0, #0x90
	mov r2, #0
	mov r3, #6
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	mov r0, r5
	str r3, [sp]
	add r0, #0x94
	ldr r0, [r0, #0]
	ldr r1, _02173EC8 // =aBodyWeak
	mov r2, #0x1e
	bl BossHelpers__Model__Init
	mov r3, #0
	str r3, [sp]
	add r5, #0x94
	ldr r0, [r5, #0]
	ldr r1, _02173ECC // =aBodyCenter
	mov r2, #0x1d
	bl BossHelpers__Model__Init
	ldr r2, _02173EC0 // =gameArchiveStage
	ldr r1, _02173ED0 // =aExc_6
	ldr r2, [r2, #0]
	add r0, sp, #0x10
	bl NNS_FndMountArchive
	mov r0, #2
	lsl r0, r0, #0xa
	ldr r5, _02173ED4 // =_0217AEC0
	mov r7, #0
	add r6, r4, r0
_02173E34:
	mov r1, r7
	add r0, sp, #0x10
	add r1, #0xb
	bl NNS_FndGetArchiveFileByIndex
	str r0, [sp, #0xc]
	ldr r0, _02173EB0 // =bossAssetFiles
	ldr r0, [r0, #0]
	bl NNS_G3dGetTex
	ldr r1, [r5, #0]
	bl Asset3DSetup__PaletteFromName
	mov r1, #5
	str r1, [sp]
	mov r2, #0
	str r0, [sp, #4]
	ldr r1, [sp, #0xc]
	mov r0, r6
	mov r3, r2
	bl InitPaletteAnimator
	add r7, r7, #1
	add r5, r5, #4
	add r6, #0x20
	cmp r7, #0xd
	blt _02173E34
	mov r0, #2
	lsl r0, r0, #0xa
	mov r2, #0
	add r0, r4, r0
	mov r1, #0xd
	mov r3, r2
	bl BossHelpers__Palette__Func_2038BAC
	add r0, sp, #0x10
	bl NNS_FndUnmountArchive
	mov r0, r4
	bl ovl01_2177918
	mov r0, r4
	add sp, #0x78
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02173E8C: .word StageTask_Main
_02173E90: .word ovl01_2177584
_02173E94: .word _0217AFB8
_02173E98: .word ovl01_2177568
_02173E9C: .word ovl01_21775D8
_02173EA0: .word ovl01_2177654
_02173EA4: .word 0x00000B24
_02173EA8: .word ovl01_21777A8
_02173EAC: .word ovl01_2177858
_02173EB0: .word bossAssetFiles
_02173EB4: .word _0217AEF4
_02173EB8: .word 0x000034CC
_02173EBC: .word aBoss5Nsbca
_02173EC0: .word gameArchiveStage
_02173EC4: .word BossHelpers__Model__RenderCallback
_02173EC8: .word aBodyWeak
_02173ECC: .word aBodyCenter
_02173ED0: .word aExc_6
_02173ED4: .word _0217AEC0
	thumb_func_end Boss5__Create

	thumb_func_start Boss5Core__Create
Boss5Core__Create: // _02173ED8
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r4, #0
	str r4, [sp]
	str r4, [sp, #4]
	mov r5, r0
	str r4, [sp, #8]
	mov r7, r2
	ldrh r3, [r5, #2]
	ldr r2, _02173FE8 // =GameObject__ViewOffsetTable
	mov r6, r1
	ldrb r3, [r2, r3]
	mov r2, #0x42
	lsl r2, r2, #2
	sub r2, r2, r3
	lsl r2, r2, #0x10
	mov r0, r6
	mov r1, r7
	asr r2, r2, #0x10
	mov r3, r4
	bl ovl01_217571C
	cmp r0, #0
	beq _02173F0E
	add sp, #0xc
	mov r0, r4
	pop {r4, r5, r6, r7, pc}
_02173F0E:
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0x4e
	lsl r0, r0, #4
	str r0, [sp, #8]
	mov r2, r4
	ldr r0, _02173FEC // =StageTask_Main
	ldr r1, _02173FF0 // =ovl01_2176970
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r2, #0x4e
	mov r0, #0
	mov r1, r4
	lsl r2, r2, #4
	bl MIi_CpuClear16
	mov r0, r4
	mov r1, r5
	mov r2, r6
	mov r3, r7
	bl GameObject__InitFromObject
	mov r0, r4
	ldr r1, _02173FF4 // =ovl01_217696C
	add r0, #0xf4
	str r1, [r0]
	mov r0, r4
	ldr r1, _02173FF8 // =ovl01_2176998
	add r0, #0xfc
	str r1, [r0]
	mov r0, #1
	ldr r1, [r4, #0x20]
	lsl r0, r0, #8
	orr r1, r0
	str r1, [r4, #0x20]
	mov r1, #0x9f
	ldr r2, [r4, #0x1c]
	lsl r1, r1, #8
	orr r1, r2
	str r1, [r4, #0x1c]
	lsl r0, r0, #4
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	mov r0, #0x86
	lsl r0, r0, #2
	add r5, r4, r0
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #2
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	mov r3, #0x20
	mov r0, #0x10
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r1, r3
	mov r2, r3
	str r3, [sp, #8]
	mov r0, r5
	sub r1, #0x30
	sub r2, #0x70
	sub r3, #0x40
	bl ObjRect__SetBox3D
	ldr r0, _02173FFC // =ovl01_21769F0
	str r4, [r5, #0x1c]
	str r0, [r5, #0x24]
	ldr r1, [r5, #0x18]
	mov r0, #4
	orr r0, r1
	str r0, [r5, #0x18]
	mov r0, #0xd9
	lsl r0, r0, #2
	add r5, r4, r0
	ldr r0, _02174000 // =0x02133A10
	ldr r2, _02174004 // =_0217AEF4
	str r0, [sp]
	mov r3, #0
	mov r0, r4
	mov r1, r5
	str r3, [sp, #4]
	bl ObjAction3dNNModelLoad
	mov r0, #0x4b
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r4, r0]
	ldr r0, _02174008 // =0x000034CC
	str r0, [r5, #0x18]
	str r0, [r5, #0x1c]
	str r0, [r5, #0x20]
	mov r0, r4
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_02173FE8: .word GameObject__ViewOffsetTable
_02173FEC: .word StageTask_Main
_02173FF0: .word ovl01_2176970
_02173FF4: .word ovl01_217696C
_02173FF8: .word ovl01_2176998
_02173FFC: .word ovl01_21769F0
_02174000: .word 0x02133A10
_02174004: .word _0217AEF4
_02174008: .word 0x000034CC
	thumb_func_end Boss5Core__Create

	thumb_func_start Boss5Sea__Create
Boss5Sea__Create: // _0217400C
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r6, r0
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	ldr r0, _021740E8 // =0x000004F8
	mov r7, r1
	mov r5, r2
	str r0, [sp, #8]
	mov r2, #0
	ldr r0, _021740EC // =StageTask_Main
	ldr r1, _021740F0 // =ovl01_2177370
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _021740E8 // =0x000004F8
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	ldr r0, _021740F4 // =_0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0xdd
	mov r3, #0x32
	lsl r1, r1, #2
	str r0, [r4, r1]
	lsl r3, r3, #0xc
	mov r0, r4
	mov r1, r6
	mov r2, r7
	add r3, r5, r3
	bl GameObject__InitFromObject
	mov r0, r4
	ldr r1, _021740F8 // =ovl01_21772D8
	add r0, #0xf4
	str r1, [r0]
	mov r0, r4
	ldr r1, _021740FC // =ovl01_21773A0
	add r0, #0xfc
	str r1, [r0]
	ldr r1, [r4, #0x18]
	mov r0, #0x10
	orr r1, r0
	str r1, [r4, #0x18]
	mov r1, #6
	ldr r2, [r4, #0x20]
	lsl r1, r1, #6
	orr r1, r2
	str r1, [r4, #0x20]
	mov r1, #0x9f
	ldr r2, [r4, #0x1c]
	lsl r1, r1, #8
	orr r1, r2
	str r1, [r4, #0x1c]
	lsl r0, r0, #8
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	mov r0, #0xd9
	lsl r0, r0, #2
	add r0, r4, r0
	bl ovl01_2175328
	mov r0, #0xb6
	lsl r0, r0, #2
	add r3, r4, r0
	add r0, #0xa4
	add r5, r4, r0
	ldr r1, _02174100 // =StageTask__DefaultDiffData
	str r4, [r3]
	str r1, [r3, #0x24]
	mov r2, #0
	mov r1, #0x19
	strh r2, [r3, #0x22]
	lsl r1, r1, #4
	strh r1, [r3, #0x30]
	mov r1, #8
	strh r1, [r3, #0x32]
	sub r1, #0xd0
	strh r1, [r3, #0x18]
	strh r2, [r3, #0x1a]
	ldr r0, _02174104 // =0x02133A18
	mov r1, r5
	str r0, [sp]
	str r2, [sp, #4]
	ldr r2, _02174108 // =_0217AEF4
	mov r0, r4
	mov r3, #1
	bl ObjAction3dNNModelLoad
	mov r0, #0x4b
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r4, r0]
	ldr r0, _0217410C // =0x000034CC
	str r0, [r5, #0x18]
	str r0, [r5, #0x1c]
	str r0, [r5, #0x20]
	mov r0, r4
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_021740E8: .word 0x000004F8
_021740EC: .word StageTask_Main
_021740F0: .word ovl01_2177370
_021740F4: .word _0217AFB8
_021740F8: .word ovl01_21772D8
_021740FC: .word ovl01_21773A0
_02174100: .word StageTask__DefaultDiffData
_02174104: .word 0x02133A18
_02174108: .word _0217AEF4
_0217410C: .word 0x000034CC
	thumb_func_end Boss5Sea__Create

	thumb_func_start Boss5MapChunk__Create
Boss5MapChunk__Create: // _02174110
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r4, #0
	str r4, [sp]
	str r4, [sp, #4]
	mov r5, r0
	str r4, [sp, #8]
	mov r7, r2
	ldrh r3, [r5, #2]
	ldr r2, _021741E0 // =GameObject__ViewOffsetTable
	mov r6, r1
	ldrb r3, [r2, r3]
	mov r2, #0x42
	lsl r2, r2, #2
	sub r2, r2, r3
	lsl r2, r2, #0x10
	mov r0, r6
	mov r1, r7
	asr r2, r2, #0x10
	mov r3, r4
	bl ovl01_217571C
	cmp r0, #0
	beq _02174146
	add sp, #0xc
	mov r0, r4
	pop {r4, r5, r6, r7, pc}
_02174146:
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0x4e
	lsl r0, r0, #4
	str r0, [sp, #8]
	mov r2, r4
	ldr r0, _021741E4 // =StageTask_Main
	ldr r1, _021741E8 // =GameObject__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r2, #0x4e
	mov r0, #0
	mov r1, r4
	lsl r2, r2, #4
	bl MIi_CpuClear16
	mov r0, r4
	mov r1, r5
	mov r2, r6
	mov r3, r7
	bl GameObject__InitFromObject
	mov r0, r4
	ldr r1, _021741EC // =ovl01_2175BCC
	add r0, #0xf4
	str r1, [r0]
	mov r0, r4
	ldr r1, _021741F0 // =ovl01_2175BD0
	add r0, #0xfc
	str r1, [r0]
	mov r0, #0x11
	ldr r1, _021741F4 // =ovl01_21758A0
	lsl r0, r0, #4
	str r1, [r4, r0]
	ldr r1, [r4, #0x20]
	sub r0, #0x10
	orr r0, r1
	str r0, [r4, #0x20]
	mov r0, #0x9f
	ldr r1, [r4, #0x1c]
	lsl r0, r0, #8
	orr r0, r1
	str r0, [r4, #0x1c]
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	mov r0, #0xd9
	lsl r0, r0, #2
	add r6, r4, r0
	ldr r0, _021741F8 // =0x02133A20
	mov r3, #6
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	ldrsb r3, [r5, r3]
	ldr r2, _021741FC // =_0217AEF4
	mov r0, r4
	mov r1, r6
	bl ObjAction3dNNModelLoad
	mov r0, #2
	lsl r0, r0, #0xe
	str r0, [r6, #0x18]
	str r0, [r6, #0x1c]
	str r0, [r6, #0x20]
	mov r0, r4
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_021741E0: .word GameObject__ViewOffsetTable
_021741E4: .word StageTask_Main
_021741E8: .word GameObject__Destructor
_021741EC: .word ovl01_2175BCC
_021741F0: .word ovl01_2175BD0
_021741F4: .word ovl01_21758A0
_021741F8: .word 0x02133A20
_021741FC: .word _0217AEF4
	thumb_func_end Boss5MapChunk__Create

	thumb_func_start Boss5Unknown2174200__Create
Boss5Unknown2174200__Create: // _02174200
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r5, r0
	mov r6, r1
	mov r7, r2
	bl ovl01_2175A18
	cmp r0, #0
	bne _02174218
	add sp, #0xc
	mov r0, #0
	pop {r4, r5, r6, r7, pc}
_02174218:
	mov r4, #0
	str r4, [sp]
	str r4, [sp, #4]
	str r4, [sp, #8]
	ldrh r3, [r5, #2]
	ldr r2, _021742D8 // =GameObject__ViewOffsetTable
	mov r0, r6
	ldrb r3, [r2, r3]
	mov r2, #0x42
	lsl r2, r2, #2
	sub r2, r2, r3
	lsl r2, r2, #0x10
	mov r1, r7
	asr r2, r2, #0x10
	mov r3, r4
	bl ovl01_217571C
	cmp r0, #0
	beq _02174244
	add sp, #0xc
	mov r0, r4
	pop {r4, r5, r6, r7, pc}
_02174244:
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0x37
	lsl r0, r0, #4
	str r0, [sp, #8]
	mov r2, r4
	ldr r0, _021742DC // =StageTask_Main
	ldr r1, _021742E0 // =GameObject__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r2, #0x37
	mov r0, #0
	mov r1, r4
	lsl r2, r2, #4
	bl MIi_CpuClear16
	mov r0, r4
	mov r1, r5
	mov r2, r6
	mov r3, r7
	bl GameObject__InitFromObject
	mov r0, r4
	ldr r1, _021742E4 // =ovl01_2175C20
	add r0, #0xf4
	str r1, [r0]
	mov r0, #0x11
	ldr r1, _021742E8 // =ovl01_21758A0
	lsl r0, r0, #4
	str r1, [r4, r0]
	ldr r1, [r4, #0x20]
	mov r0, #0x20
	orr r0, r1
	str r0, [r4, #0x20]
	mov r0, #0x9f
	ldr r1, [r4, #0x1c]
	lsl r0, r0, #8
	orr r0, r1
	str r0, [r4, #0x1c]
	mov r0, #6
	mov r1, #0xda
	ldrsb r0, [r5, r0]
	lsl r1, r1, #2
	strh r0, [r4, r1]
	mov r0, #7
	ldrsb r2, [r5, r0]
	add r0, r1, #2
	strh r2, [r4, r0]
	ldrb r2, [r5, #8]
	add r0, r1, #4
	strh r2, [r4, r0]
	ldrh r2, [r5, #4]
	mov r0, #4
	tst r0, r2
	beq _021742D0
	ldrh r0, [r4, r1]
	lsl r0, r0, #2
	strh r0, [r4, r1]
	add r0, r1, #2
	ldrh r0, [r4, r0]
	lsl r2, r0, #2
	add r0, r1, #2
	strh r2, [r4, r0]
_021742D0:
	mov r0, r4
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_021742D8: .word GameObject__ViewOffsetTable
_021742DC: .word StageTask_Main
_021742E0: .word GameObject__Destructor
_021742E4: .word ovl01_2175C20
_021742E8: .word ovl01_21758A0
	thumb_func_end Boss5Unknown2174200__Create

	thumb_func_start Boss5Battery__Create
Boss5Battery__Create: // _021742EC
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r5, r0
	mov r6, r1
	mov r7, r2
	bl ovl01_2175A18
	cmp r0, #0
	bne _02174304
	add sp, #0xc
	mov r0, #0
	pop {r4, r5, r6, r7, pc}
_02174304:
	mov r4, #0
	str r4, [sp]
	str r4, [sp, #4]
	str r4, [sp, #8]
	ldrh r3, [r5, #2]
	ldr r2, _021743F8 // =GameObject__ViewOffsetTable
	mov r0, r6
	ldrb r3, [r2, r3]
	mov r2, #0x42
	lsl r2, r2, #2
	sub r2, r2, r3
	lsl r2, r2, #0x10
	mov r1, r7
	asr r2, r2, #0x10
	mov r3, r4
	bl ovl01_217571C
	cmp r0, #0
	beq _02174330
	add sp, #0xc
	mov r0, r4
	pop {r4, r5, r6, r7, pc}
_02174330:
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	ldr r0, _021743FC // =0x000004EC
	mov r2, r4
	str r0, [sp, #8]
	ldr r0, _02174400 // =StageTask_Main
	ldr r1, _02174404 // =GameObject__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _021743FC // =0x000004EC
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r0, r4
	mov r1, r5
	mov r2, r6
	mov r3, r7
	bl GameObject__InitFromObject
	mov r0, r4
	ldr r1, _02174408 // =ovl01_2175CA8
	add r0, #0xf4
	str r1, [r0]
	mov r0, #0x11
	ldr r1, _0217440C // =ovl01_21758A0
	lsl r0, r0, #4
	str r1, [r4, r0]
	mov r0, r4
	ldr r1, _02174410 // =ovl01_2175924
	add r0, #0xfc
	str r1, [r0]
	mov r0, #0x9f
	ldr r1, [r4, #0x1c]
	lsl r0, r0, #8
	orr r0, r1
	str r0, [r4, #0x1c]
	ldrh r1, [r5, #4]
	mov r0, #0x40
	tst r0, r1
	ldr r1, [r4, #0x20]
	beq _0217439A
	mov r0, #1
	bic r1, r0
	str r1, [r4, #0x20]
	b _021743A0
_0217439A:
	mov r0, #1
	orr r0, r1
	str r0, [r4, #0x20]
_021743A0:
	mov r0, #6
	ldrsb r0, [r5, r0]
	ldr r1, _02174414 // =0x000004E4
	strh r0, [r4, r1]
	mov r0, #7
	ldrsb r2, [r5, r0]
	add r0, r1, #2
	strh r2, [r4, r0]
	ldrb r2, [r5, #8]
	add r0, r1, #4
	strh r2, [r4, r0]
	ldrh r2, [r5, #4]
	mov r0, #4
	tst r0, r2
	beq _021743CE
	ldrh r0, [r4, r1]
	lsl r0, r0, #2
	strh r0, [r4, r1]
	add r0, r1, #2
	ldrh r0, [r4, r0]
	lsl r2, r0, #2
	add r0, r1, #2
	strh r2, [r4, r0]
_021743CE:
	mov r0, #0xd9
	lsl r0, r0, #2
	add r5, r4, r0
	ldr r0, _02174418 // =0x02133A10
	ldr r2, _0217441C // =_0217AEF4
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r4
	mov r1, r5
	mov r3, #9
	bl ObjAction3dNNModelLoad
	ldr r0, _02174420 // =0x000034CC
	str r0, [r5, #0x18]
	str r0, [r5, #0x1c]
	str r0, [r5, #0x20]
	mov r0, r4
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_021743F8: .word GameObject__ViewOffsetTable
_021743FC: .word 0x000004EC
_02174400: .word StageTask_Main
_02174404: .word GameObject__Destructor
_02174408: .word ovl01_2175CA8
_0217440C: .word ovl01_21758A0
_02174410: .word ovl01_2175924
_02174414: .word 0x000004E4
_02174418: .word 0x02133A10
_0217441C: .word _0217AEF4
_02174420: .word 0x000034CC
	thumb_func_end Boss5Battery__Create

	thumb_func_start Boss5Missile__Create
Boss5Missile__Create: // _02174424
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r5, r0
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0x4e
	lsl r0, r0, #4
	mov r6, r1
	mov r7, r2
	str r0, [sp, #8]
	mov r2, #0
	ldr r0, _0217454C // =StageTask_Main
	ldr r1, _02174550 // =ovl01_2175D28
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r2, #0x4e
	mov r0, #0
	mov r1, r4
	lsl r2, r2, #4
	bl MIi_CpuClear16
	mov r0, r4
	mov r1, r5
	mov r2, r6
	mov r3, r7
	bl GameObject__InitFromObject
	mov r0, #0x11
	ldr r1, _02174554 // =ovl01_21758A0
	lsl r0, r0, #4
	str r1, [r4, r0]
	mov r0, r4
	ldr r1, _02174558 // =ovl01_2175924
	add r0, #0xfc
	str r1, [r0]
	mov r0, #0x9f
	ldr r1, [r4, #0x1c]
	lsl r0, r0, #8
	orr r0, r1
	str r0, [r4, #0x1c]
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	ldrh r1, [r5, #4]
	mov r0, #3
	and r0, r1
	lsl r1, r0, #2
	ldr r0, _0217455C // =_0217A1B8
	ldr r0, [r0, r1]
	neg r1, r0
	mov r0, r4
	add r0, #0x98
	str r1, [r0]
	ldrh r1, [r5, #4]
	mov r0, #0x40
	tst r0, r1
	beq _021744B8
	mov r0, r4
	add r0, #0x98
	ldr r0, [r0, #0]
	neg r1, r0
	mov r0, r4
	add r0, #0x98
	str r1, [r0]
	b _021744C0
_021744B8:
	ldr r1, [r4, #0x20]
	mov r0, #1
	orr r0, r1
	str r0, [r4, #0x20]
_021744C0:
	mov r1, #0xb6
	lsl r1, r1, #2
	add r0, r4, r1
	ldr r2, _02174560 // =StageTask__DefaultDiffData
	str r4, [r0]
	str r2, [r0, #0x24]
	mov r2, #0
	strh r2, [r0, #0x22]
	mov r2, #0x20
	sub r1, #0xc0
	add r5, r4, r1
	mov r3, #0x18
	strh r2, [r0, #0x30]
	mov r2, r3
	strh r3, [r0, #0x32]
	sub r2, #0x28
	strh r2, [r0, #0x18]
	sub r3, #0x25
	strh r3, [r0, #0x1a]
	mov r0, r5
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	ldr r1, _02174564 // =0x0000FFFF
	mov r0, r5
	mov r2, #0xff
	bl ObjRect__SetDefenceStat
	mov r0, #0x12
	str r0, [sp]
	mov r0, #8
	mov r2, #4
	str r0, [sp, #4]
	mov r1, #0x20
	mov r3, r2
	str r1, [sp, #8]
	mov r0, r5
	sub r1, #0x2a
	sub r3, #0x24
	bl ObjRect__SetBox3D
	ldr r0, _02174568 // =ovl01_2175D40
	str r4, [r5, #0x1c]
	str r0, [r5, #0x20]
	ldr r1, [r5, #0x18]
	mov r0, #4
	orr r0, r1
	str r0, [r5, #0x18]
	mov r0, #0xd9
	lsl r0, r0, #2
	add r5, r4, r0
	ldr r0, _0217456C // =0x02133A10
	ldr r2, _02174570 // =_0217AEF4
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r4
	mov r1, r5
	mov r3, #1
	bl ObjAction3dNNModelLoad
	ldr r0, _02174574 // =0x000034CC
	str r0, [r5, #0x18]
	str r0, [r5, #0x1c]
	str r0, [r5, #0x20]
	mov r0, r4
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_0217454C: .word StageTask_Main
_02174550: .word ovl01_2175D28
_02174554: .word ovl01_21758A0
_02174558: .word ovl01_2175924
_0217455C: .word _0217A1B8
_02174560: .word StageTask__DefaultDiffData
_02174564: .word 0x0000FFFF
_02174568: .word ovl01_2175D40
_0217456C: .word 0x02133A10
_02174570: .word _0217AEF4
_02174574: .word 0x000034CC
	thumb_func_end Boss5Missile__Create

	thumb_func_start Boss5Unknown2174578__Create
Boss5Unknown2174578__Create: // _02174578
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r5, r0
	mov r6, r1
	mov r7, r2
	bl ovl01_2175A18
	cmp r0, #0
	bne _02174590
	add sp, #0xc
	mov r0, #0
	pop {r4, r5, r6, r7, pc}
_02174590:
	mov r4, #0
	str r4, [sp]
	str r4, [sp, #4]
	str r4, [sp, #8]
	ldrh r3, [r5, #2]
	ldr r2, _02174654 // =GameObject__ViewOffsetTable
	mov r0, r6
	ldrb r3, [r2, r3]
	mov r2, #0x42
	lsl r2, r2, #2
	sub r2, r2, r3
	lsl r2, r2, #0x10
	mov r1, r7
	asr r2, r2, #0x10
	mov r3, r4
	bl ovl01_217571C
	cmp r0, #0
	beq _021745BC
	add sp, #0xc
	mov r0, r4
	pop {r4, r5, r6, r7, pc}
_021745BC:
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0xdb
	lsl r0, r0, #2
	str r0, [sp, #8]
	mov r2, r4
	ldr r0, _02174658 // =StageTask_Main
	ldr r1, _0217465C // =GameObject__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r2, #0xdb
	mov r0, #0
	mov r1, r4
	lsl r2, r2, #2
	bl MIi_CpuClear16
	mov r0, r4
	mov r1, r5
	mov r2, r6
	mov r3, r7
	bl GameObject__InitFromObject
	mov r0, r4
	ldr r1, _02174660 // =ovl01_2175D7C
	add r0, #0xf4
	str r1, [r0]
	mov r0, #0x11
	ldr r1, _02174664 // =ovl01_21758A0
	lsl r0, r0, #4
	str r1, [r4, r0]
	ldr r1, [r4, #0x20]
	mov r0, #0x20
	orr r0, r1
	str r0, [r4, #0x20]
	mov r0, #0x9f
	ldr r1, [r4, #0x1c]
	lsl r0, r0, #8
	orr r0, r1
	str r0, [r4, #0x1c]
	mov r0, #7
	ldrsb r0, [r5, r0]
	mov r1, #0xd9
	lsl r1, r1, #2
	lsl r0, r0, #0xc
	str r0, [r4, r1]
	ldrb r2, [r5, #8]
	add r0, r1, #4
	strh r2, [r4, r0]
	ldrb r2, [r5, #9]
	add r0, r1, #6
	strh r2, [r4, r0]
	ldrh r2, [r5, #4]
	mov r0, #4
	tst r0, r2
	beq _0217464C
	add r0, r1, #4
	ldrh r0, [r4, r0]
	lsl r2, r0, #2
	add r0, r1, #4
	strh r2, [r4, r0]
	add r0, r1, #6
	ldrh r0, [r4, r0]
	lsl r2, r0, #2
	add r0, r1, #6
	strh r2, [r4, r0]
_0217464C:
	mov r0, r4
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_02174654: .word GameObject__ViewOffsetTable
_02174658: .word StageTask_Main
_0217465C: .word GameObject__Destructor
_02174660: .word ovl01_2175D7C
_02174664: .word ovl01_21758A0
	thumb_func_end Boss5Unknown2174578__Create

	thumb_func_start CreateBoss5Icicle
CreateBoss5Icicle: // _02174668
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r5, r0
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0x4e
	lsl r0, r0, #4
	mov r6, r1
	mov r7, r2
	str r0, [sp, #8]
	mov r2, #0
	ldr r0, _02174750 // =StageTask_Main
	ldr r1, _02174754 // =GameObject__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r2, #0x4e
	mov r0, #0
	mov r1, r4
	lsl r2, r2, #4
	bl MIi_CpuClear16
	mov r0, r4
	mov r1, r5
	mov r2, r6
	mov r3, r7
	bl GameObject__InitFromObject
	mov r1, #0x11
	ldr r0, _02174758 // =ovl01_21758A0
	lsl r1, r1, #4
	str r0, [r4, r1]
	mov r0, r4
	ldr r2, _0217475C // =ovl01_2175924
	add r0, #0xfc
	str r2, [r0]
	ldr r0, [r4, #0x20]
	sub r1, #0x10
	orr r0, r1
	str r0, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	ldr r0, _02174760 // =0x00009F80
	mov r2, #0x40
	orr r0, r1
	str r0, [r4, #0x1c]
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	ldrh r0, [r5, #4]
	lsl r0, r0, #0x1e
	lsr r1, r0, #0x1c
	ldr r0, _02174764 // =_0217A1C8
	ldr r1, [r0, r1]
	mov r0, r4
	add r0, #0x9c
	str r1, [r0]
	mov r0, #0x86
	lsl r0, r0, #2
	add r5, r4, r0
	mov r0, r5
	mov r1, #2
	bl ObjRect__SetAttackStat
	ldr r1, _02174768 // =0x0000FFFF
	mov r0, r5
	mov r2, #0xff
	bl ObjRect__SetDefenceStat
	mov r3, #0x20
	mov r0, #0x14
	str r0, [sp]
	mov r0, #0x1e
	str r0, [sp, #4]
	mov r1, r3
	mov r2, r3
	str r3, [sp, #8]
	mov r0, r5
	sub r1, #0x34
	sub r2, #0x3e
	sub r3, #0x40
	bl ObjRect__SetBox3D
	str r4, [r5, #0x1c]
	ldr r1, [r5, #0x18]
	mov r0, #4
	orr r0, r1
	str r0, [r5, #0x18]
	mov r0, #0xd9
	lsl r0, r0, #2
	add r5, r4, r0
	ldr r0, _0217476C // =0x02133A10
	ldr r2, _02174770 // =_0217AEF4
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r4
	mov r1, r5
	mov r3, #2
	bl ObjAction3dNNModelLoad
	ldr r0, _02174774 // =0x000034CC
	str r0, [r5, #0x18]
	str r0, [r5, #0x1c]
	str r0, [r5, #0x20]
	mov r0, r4
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_02174750: .word StageTask_Main
_02174754: .word GameObject__Destructor
_02174758: .word ovl01_21758A0
_0217475C: .word ovl01_2175924
_02174760: .word 0x00009F80
_02174764: .word _0217A1C8
_02174768: .word 0x0000FFFF
_0217476C: .word 0x02133A10
_02174770: .word _0217AEF4
_02174774: .word 0x000034CC
	thumb_func_end CreateBoss5Icicle

	thumb_func_start Boss5Icicle2__Create
Boss5Icicle2__Create: // _02174778
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r5, r0
	mov r6, r1
	mov r7, r2
	bl ovl01_2175A18
	cmp r0, #0
	bne _02174790
	add sp, #0xc
	mov r0, #0
	pop {r4, r5, r6, r7, pc}
_02174790:
	mov r4, #0
	str r4, [sp]
	str r4, [sp, #4]
	str r4, [sp, #8]
	ldrh r3, [r5, #2]
	ldr r2, _02174898 // =GameObject__ViewOffsetTable
	mov r0, r6
	ldrb r3, [r2, r3]
	mov r2, #0x42
	lsl r2, r2, #2
	sub r2, r2, r3
	lsl r2, r2, #0x10
	mov r1, r7
	asr r2, r2, #0x10
	mov r3, r4
	bl ovl01_217571C
	cmp r0, #0
	beq _021747BC
	add sp, #0xc
	mov r0, r4
	pop {r4, r5, r6, r7, pc}
_021747BC:
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	ldr r0, _0217489C // =0x000004E8
	mov r2, r4
	str r0, [sp, #8]
	ldr r0, _021748A0 // =StageTask_Main
	ldr r1, _021748A4 // =GameObject__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _0217489C // =0x000004E8
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r0, r4
	mov r1, r5
	mov r2, r6
	mov r3, r7
	bl GameObject__InitFromObject
	mov r0, r4
	ldr r1, _021748A8 // =ovl01_2175DD0
	add r0, #0xf4
	str r1, [r0]
	mov r1, #0x11
	ldr r0, _021748AC // =ovl01_21758A0
	lsl r1, r1, #4
	str r0, [r4, r1]
	mov r0, r4
	ldr r2, _021748B0 // =ovl01_2175924
	add r0, #0xfc
	str r2, [r0]
	ldr r0, [r4, #0x20]
	sub r1, #0x10
	orr r0, r1
	str r0, [r4, #0x20]
	mov r0, #0x9f
	ldr r1, [r4, #0x1c]
	lsl r0, r0, #8
	orr r0, r1
	str r0, [r4, #0x1c]
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	bl AllocSndHandle
	mov r1, #0xcf
	lsl r1, r1, #2
	str r0, [r4, r1]
	mov r0, #0x86
	lsl r0, r0, #2
	add r5, r4, r0
	mov r0, r5
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	ldr r1, _021748B4 // =0x0000FFFF
	mov r0, r5
	mov r2, #0xff
	bl ObjRect__SetDefenceStat
	mov r3, #0x20
	mov r0, #0x14
	str r0, [sp]
	mov r0, #0x1e
	str r0, [sp, #4]
	mov r1, r3
	mov r2, r3
	str r3, [sp, #8]
	mov r0, r5
	sub r1, #0x34
	sub r2, #0x3e
	sub r3, #0x40
	bl ObjRect__SetBox3D
	str r4, [r5, #0x1c]
	ldr r1, [r5, #0x18]
	mov r0, #4
	orr r0, r1
	str r0, [r5, #0x18]
	mov r0, #0xd9
	lsl r0, r0, #2
	add r5, r4, r0
	ldr r0, _021748B8 // =0x02133A10
	ldr r2, _021748BC // =_0217AEF4
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r4
	mov r1, r5
	mov r3, #2
	bl ObjAction3dNNModelLoad
	ldr r0, _021748C0 // =0x000034CC
	str r0, [r5, #0x18]
	str r0, [r5, #0x1c]
	str r0, [r5, #0x20]
	mov r0, r4
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02174898: .word GameObject__ViewOffsetTable
_0217489C: .word 0x000004E8
_021748A0: .word StageTask_Main
_021748A4: .word GameObject__Destructor
_021748A8: .word ovl01_2175DD0
_021748AC: .word ovl01_21758A0
_021748B0: .word ovl01_2175924
_021748B4: .word 0x0000FFFF
_021748B8: .word 0x02133A10
_021748BC: .word _0217AEF4
_021748C0: .word 0x000034CC
	thumb_func_end Boss5Icicle2__Create

	thumb_func_start Boss5Unknown21748C4__Create
Boss5Unknown21748C4__Create: // _021748C4
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r4, #0
	str r4, [sp]
	str r4, [sp, #4]
	mov r5, r0
	str r4, [sp, #8]
	mov r7, r2
	ldrh r3, [r5, #2]
	ldr r2, _0217495C // =GameObject__ViewOffsetTable
	mov r6, r1
	ldrb r3, [r2, r3]
	mov r2, #0x42
	lsl r2, r2, #2
	sub r2, r2, r3
	lsl r2, r2, #0x10
	mov r0, r6
	mov r1, r7
	asr r2, r2, #0x10
	mov r3, r4
	bl ovl01_217571C
	cmp r0, #0
	beq _021748FA
	add sp, #0xc
	mov r0, r4
	pop {r4, r5, r6, r7, pc}
_021748FA:
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0xda
	lsl r0, r0, #2
	str r0, [sp, #8]
	mov r2, r4
	ldr r0, _02174960 // =StageTask_Main
	ldr r1, _02174964 // =GameObject__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r2, #0xda
	mov r0, #0
	mov r1, r4
	lsl r2, r2, #2
	bl MIi_CpuClear16
	mov r0, r4
	mov r1, r5
	mov r2, r6
	mov r3, r7
	bl GameObject__InitFromObject
	mov r0, r4
	ldr r1, _02174968 // =ovl01_2175F48
	add r0, #0xf4
	str r1, [r0]
	mov r0, #0x11
	ldr r1, _0217496C // =ovl01_21758A0
	lsl r0, r0, #4
	str r1, [r4, r0]
	ldr r1, [r4, #0x20]
	mov r0, #0x20
	orr r0, r1
	str r0, [r4, #0x20]
	mov r0, #0x9f
	ldr r1, [r4, #0x1c]
	lsl r0, r0, #8
	orr r0, r1
	str r0, [r4, #0x1c]
	mov r0, r4
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_0217495C: .word GameObject__ViewOffsetTable
_02174960: .word StageTask_Main
_02174964: .word GameObject__Destructor
_02174968: .word ovl01_2175F48
_0217496C: .word ovl01_21758A0
	thumb_func_end Boss5Unknown21748C4__Create

	thumb_func_start Boss5FreezeArea__Create
Boss5FreezeArea__Create: // _02174970
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r5, r0
	mov r6, r1
	mov r7, r2
	bl ovl01_2175A18
	cmp r0, #0
	bne _02174988
	add sp, #0xc
	mov r0, #0
	pop {r4, r5, r6, r7, pc}
_02174988:
	mov r4, #0
	str r4, [sp]
	str r4, [sp, #4]
	str r4, [sp, #8]
	ldrh r3, [r5, #2]
	ldr r2, _02174AFC // =GameObject__ViewOffsetTable
	mov r0, r6
	ldrb r3, [r2, r3]
	mov r2, #0x42
	lsl r2, r2, #2
	sub r2, r2, r3
	lsl r2, r2, #0x10
	mov r1, r7
	asr r2, r2, #0x10
	mov r3, r4
	bl ovl01_217571C
	cmp r0, #0
	beq _021749B4
	add sp, #0xc
	mov r0, r4
	pop {r4, r5, r6, r7, pc}
_021749B4:
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0x4e
	lsl r0, r0, #4
	str r0, [sp, #8]
	mov r2, r4
	ldr r0, _02174B00 // =StageTask_Main
	ldr r1, _02174B04 // =GameObject__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r2, #0x4e
	mov r0, #0
	mov r1, r4
	lsl r2, r2, #4
	bl MIi_CpuClear16
	mov r0, r4
	mov r1, r5
	mov r2, r6
	mov r3, r7
	bl GameObject__InitFromObject
	mov r1, #0x11
	ldr r0, _02174B08 // =ovl01_21758A0
	lsl r1, r1, #4
	str r0, [r4, r1]
	mov r0, r4
	ldr r2, _02174B0C // =ovl01_2175924
	add r0, #0xfc
	str r2, [r0]
	ldr r0, [r4, #0x20]
	sub r1, #0xc
	orr r0, r1
	str r0, [r4, #0x20]
	mov r0, #0x9f
	ldr r1, [r4, #0x1c]
	lsl r0, r0, #8
	orr r0, r1
	str r0, [r4, #0x1c]
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	mov r0, #0x86
	lsl r0, r0, #2
	add r5, r4, r0
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl ObjRect__SetAttackStat
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl ObjRect__SetDefenceStat
	mov r0, #0x20
	mov r2, #0
	str r0, [sp]
	mov r1, r2
	str r2, [sp, #4]
	sub r1, #0x20
	str r0, [sp, #8]
	mov r0, r5
	sub r2, #0x10
	mov r3, r1
	bl ObjRect__SetBox3D
	ldr r1, [r5, #0x18]
	mov r0, #0xc4
	orr r0, r1
	str r0, [r5, #0x18]
	ldr r0, _02174B10 // =ovl01_2175F2C
	ldr r2, _02174B14 // =_0217AEF4
	str r0, [r5, #0x24]
	mov r0, #0xd9
	lsl r0, r0, #2
	str r4, [r5, #0x1c]
	add r5, r4, r0
	ldr r0, _02174B18 // =0x02133A10
	mov r1, r5
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r4
	mov r3, #6
	bl ObjAction3dNNModelLoad
	ldr r0, _02174B1C // =0x000034CC
	ldr r2, _02174B20 // =aBoss5Nsbca
	str r0, [r5, #0x18]
	str r0, [r5, #0x1c]
	str r0, [r5, #0x20]
	ldr r0, _02174B24 // =gameArchiveStage
	mov r1, r5
	ldr r0, [r0, #0]
	mov r3, #0
	str r0, [sp]
	mov r0, r4
	bl ObjAction3dNNMotionLoad
	mov r1, #0
	mov r2, #0x52
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	lsl r2, r2, #2
	ldr r2, [r5, r2]
	mov r0, r5
	mov r3, #0x18
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02174B24 // =gameArchiveStage
	ldr r2, _02174B28 // =aBoss5Nsbma
	ldr r0, [r0, #0]
	mov r1, r5
	str r0, [sp]
	mov r0, r4
	mov r3, #0
	bl ObjAction3dNNMotionLoad
	mov r3, #0
	mov r2, #0x53
	str r3, [sp]
	mov r1, #1
	str r1, [sp, #4]
	lsl r2, r2, #2
	ldr r2, [r5, r2]
	mov r0, r5
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02174B24 // =gameArchiveStage
	ldr r2, _02174B2C // =aBoss5Nsbta
	ldr r0, [r0, #0]
	mov r1, r5
	str r0, [sp]
	mov r0, r4
	mov r3, #0
	bl ObjAction3dNNMotionLoad
	mov r0, #0
	str r0, [sp]
	mov r0, #1
	mov r2, #0x55
	str r0, [sp, #4]
	lsl r2, r2, #2
	ldr r2, [r5, r2]
	mov r0, r5
	mov r1, #3
	mov r3, #2
	bl BossHelpers__Animation__Func_2038BF0
	mov r0, r4
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_02174AFC: .word GameObject__ViewOffsetTable
_02174B00: .word StageTask_Main
_02174B04: .word GameObject__Destructor
_02174B08: .word ovl01_21758A0
_02174B0C: .word ovl01_2175924
_02174B10: .word ovl01_2175F2C
_02174B14: .word _0217AEF4
_02174B18: .word 0x02133A10
_02174B1C: .word 0x000034CC
_02174B20: .word aBoss5Nsbca
_02174B24: .word gameArchiveStage
_02174B28: .word aBoss5Nsbma
_02174B2C: .word aBoss5Nsbta
	thumb_func_end Boss5FreezeArea__Create

	thumb_func_start Boss5PlayerFreezeEffect__Create
Boss5PlayerFreezeEffect__Create: // _02174B30
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r5, r0
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	ldr r0, _02174C28 // =0x000004E4
	mov r6, r1
	mov r7, r2
	str r0, [sp, #8]
	mov r2, #0
	ldr r0, _02174C2C // =StageTask_Main
	ldr r1, _02174C30 // =GameObject__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02174C28 // =0x000004E4
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r0, r4
	mov r1, r5
	mov r2, r6
	mov r3, r7
	bl GameObject__InitFromObject
	mov r0, r4
	ldr r1, _02174C34 // =ovl01_21766EC
	add r0, #0xf4
	str r1, [r0]
	mov r0, r4
	ldr r1, _02174C38 // =ovl01_2175924
	add r0, #0xfc
	str r1, [r0]
	ldr r1, [r4, #0x18]
	mov r0, #0x10
	orr r1, r0
	str r1, [r4, #0x18]
	mov r1, r0
	ldr r2, [r4, #0x20]
	add r1, #0xf0
	orr r1, r2
	str r1, [r4, #0x20]
	mov r1, #0x9f
	ldr r2, [r4, #0x1c]
	lsl r1, r1, #8
	orr r1, r2
	str r1, [r4, #0x1c]
	lsl r0, r0, #8
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	mov r0, #0xd9
	lsl r0, r0, #2
	add r5, r4, r0
	ldr r0, _02174C3C // =0x02133A10
	ldr r2, _02174C40 // =_0217AEF4
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r4
	mov r1, r5
	mov r3, #8
	bl ObjAction3dNNModelLoad
	ldr r0, _02174C44 // =0x000034CC
	ldr r2, _02174C48 // =aBoss5Nsbca
	str r0, [r5, #0x18]
	str r0, [r5, #0x1c]
	str r0, [r5, #0x20]
	ldr r0, _02174C4C // =gameArchiveStage
	mov r1, r5
	ldr r0, [r0, #0]
	mov r3, #0
	str r0, [sp]
	mov r0, r4
	bl ObjAction3dNNMotionLoad
	mov r1, #0
	str r1, [sp]
	mov r2, #0x52
	str r1, [sp, #4]
	lsl r2, r2, #2
	ldr r2, [r5, r2]
	mov r0, r5
	mov r3, #0x19
	bl BossHelpers__Animation__Func_2038BF0
	ldr r0, _02174C4C // =gameArchiveStage
	ldr r2, _02174C50 // =aBoss5Nsbva
	ldr r0, [r0, #0]
	mov r1, r5
	str r0, [sp]
	mov r0, r4
	mov r3, #0
	bl ObjAction3dNNMotionLoad
	mov r3, #0
	str r3, [sp]
	mov r2, #0x56
	str r3, [sp, #4]
	lsl r2, r2, #2
	ldr r2, [r5, r2]
	mov r0, r5
	mov r1, #4
	bl BossHelpers__Animation__Func_2038BF0
	mov r0, #0x46
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r5, r0]
	mov r0, r4
	bl ovl01_21766EC
	mov r0, r4
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_02174C28: .word 0x000004E4
_02174C2C: .word StageTask_Main
_02174C30: .word GameObject__Destructor
_02174C34: .word ovl01_21766EC
_02174C38: .word ovl01_2175924
_02174C3C: .word 0x02133A10
_02174C40: .word _0217AEF4
_02174C44: .word 0x000034CC
_02174C48: .word aBoss5Nsbca
_02174C4C: .word gameArchiveStage
_02174C50: .word aBoss5Nsbva
	thumb_func_end Boss5PlayerFreezeEffect__Create

	thumb_func_start Boss5EnemyFish__Create
Boss5EnemyFish__Create: // _02174C54
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r5, r0
	mov r6, r1
	mov r7, r2
	bl ovl01_2175A18
	cmp r0, #0
	bne _02174C6C
	add sp, #0xc
	mov r0, #0
	pop {r4, r5, r6, r7, pc}
_02174C6C:
	mov r4, #0
	str r4, [sp]
	str r4, [sp, #4]
	str r4, [sp, #8]
	ldrh r3, [r5, #2]
	ldr r2, _02174DAC // =GameObject__ViewOffsetTable
	mov r0, r6
	ldrb r3, [r2, r3]
	mov r2, #0x42
	lsl r2, r2, #2
	sub r2, r2, r3
	lsl r2, r2, #0x10
	mov r1, r7
	asr r2, r2, #0x10
	mov r3, r4
	bl ovl01_217571C
	cmp r0, #0
	beq _02174C98
	add sp, #0xc
	mov r0, r4
	pop {r4, r5, r6, r7, pc}
_02174C98:
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0x4e
	lsl r0, r0, #4
	str r0, [sp, #8]
	mov r2, r4
	ldr r0, _02174DB0 // =StageTask_Main
	ldr r1, _02174DB4 // =GameObject__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r2, #0x4e
	mov r0, #0
	mov r1, r4
	lsl r2, r2, #4
	bl MIi_CpuClear16
	mov r0, r4
	mov r1, r5
	mov r2, r6
	mov r3, r7
	bl GameObject__InitFromObject
	mov r0, r4
	ldr r1, _02174DB8 // =ovl01_21760A0
	add r0, #0xf4
	str r1, [r0]
	mov r0, r4
	ldr r1, _02174DBC // =ovl01_2175924
	add r0, #0xfc
	str r1, [r0]
	mov r0, #0x11
	ldr r1, _02174DC0 // =ovl01_21758A0
	lsl r0, r0, #4
	str r1, [r4, r0]
	ldr r1, [r4, #0x20]
	sub r0, #0x10
	orr r0, r1
	str r0, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	ldr r0, _02174DC4 // =0x00008280
	mov r2, #4
	orr r0, r1
	str r0, [r4, #0x1c]
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	mov r1, r2
	str r2, [sp]
	mov r0, r4
	sub r1, #0xc
	sub r2, #8
	mov r3, #8
	bl StageTask__SetHitbox
	mov r0, #0x86
	lsl r0, r0, #2
	add r5, r4, r0
	mov r0, r5
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #1
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	mov r3, #0x20
	mov r0, #0xc
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r1, r3
	mov r2, r3
	str r3, [sp, #8]
	mov r0, r5
	sub r1, #0x2c
	sub r2, #0x38
	sub r3, #0x40
	bl ObjRect__SetBox3D
	ldr r0, _02174DC8 // =ovl01_217623C
	str r4, [r5, #0x1c]
	str r0, [r5, #0x24]
	ldr r1, [r5, #0x18]
	mov r0, #4
	orr r0, r1
	str r0, [r5, #0x18]
	mov r0, #0xd9
	lsl r0, r0, #2
	add r5, r4, r0
	ldr r0, _02174DCC // =0x02133A10
	ldr r2, _02174DD0 // =_0217AEF4
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r4
	mov r1, r5
	mov r3, #3
	bl ObjAction3dNNModelLoad
	ldr r0, _02174DD4 // =0x000034CC
	ldr r2, _02174DD8 // =aBoss5Nsbca
	str r0, [r5, #0x18]
	str r0, [r5, #0x1c]
	str r0, [r5, #0x20]
	ldr r0, _02174DDC // =gameArchiveStage
	mov r1, r5
	ldr r0, [r0, #0]
	mov r3, #0
	str r0, [sp]
	mov r0, r4
	bl ObjAction3dNNMotionLoad
	mov r1, #0
	mov r2, #0x52
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	lsl r2, r2, #2
	ldr r2, [r5, r2]
	mov r0, r5
	mov r3, #0x1a
	bl BossHelpers__Animation__Func_2038BF0
	mov r0, r4
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_02174DAC: .word GameObject__ViewOffsetTable
_02174DB0: .word StageTask_Main
_02174DB4: .word GameObject__Destructor
_02174DB8: .word ovl01_21760A0
_02174DBC: .word ovl01_2175924
_02174DC0: .word ovl01_21758A0
_02174DC4: .word 0x00008280
_02174DC8: .word ovl01_217623C
_02174DCC: .word 0x02133A10
_02174DD0: .word _0217AEF4
_02174DD4: .word 0x000034CC
_02174DD8: .word aBoss5Nsbca
_02174DDC: .word gameArchiveStage
	thumb_func_end Boss5EnemyFish__Create

	thumb_func_start Boss5EnemyFish2__Create
Boss5EnemyFish2__Create: // _02174DE0
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r5, r0
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	ldr r0, _02174F10 // =0x000004E4
	mov r6, r1
	mov r7, r2
	str r0, [sp, #8]
	mov r2, #0
	ldr r0, _02174F14 // =StageTask_Main
	ldr r1, _02174F18 // =ovl01_2176450
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02174F10 // =0x000004E4
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r0, r4
	mov r1, r5
	mov r2, r6
	mov r3, r7
	bl GameObject__InitFromObject
	mov r0, r4
	ldr r1, _02174F1C // =ovl01_2176288
	add r0, #0xf4
	str r1, [r0]
	mov r0, r4
	ldr r1, _02174F20 // =ovl01_21758CC
	add r0, #0xfc
	str r1, [r0]
	ldr r1, [r4, #0x18]
	mov r0, #0x10
	orr r1, r0
	str r1, [r4, #0x18]
	mov r1, r0
	ldr r2, [r4, #0x20]
	add r1, #0xf0
	orr r1, r2
	str r1, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	ldr r1, _02174F24 // =0x00088280
	lsl r0, r0, #8
	orr r1, r2
	str r1, [r4, #0x1c]
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	mov r2, #4
	str r0, [r4, #0x40]
	mov r1, r2
	str r2, [sp]
	mov r0, r4
	sub r1, #0xc
	sub r2, #8
	mov r3, #8
	bl StageTask__SetHitbox
	mov r0, #0x86
	lsl r0, r0, #2
	add r5, r4, r0
	mov r0, r5
	mov r1, #2
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #1
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	mov r3, #0x20
	mov r0, #0xc
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r1, r3
	mov r2, r3
	str r3, [sp, #8]
	mov r0, r5
	sub r1, #0x2c
	sub r2, #0x38
	sub r3, #0x40
	bl ObjRect__SetBox3D
	ldr r0, _02174F28 // =ovl01_2176460
	str r4, [r5, #0x1c]
	str r0, [r5, #0x24]
	ldr r1, [r5, #0x18]
	mov r0, #4
	orr r0, r1
	str r0, [r5, #0x18]
	mov r0, #0xd9
	lsl r0, r0, #2
	add r5, r4, r0
	ldr r0, _02174F2C // =0x02133A10
	ldr r2, _02174F30 // =_0217AEF4
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r4
	mov r1, r5
	mov r3, #3
	bl ObjAction3dNNModelLoad
	ldr r0, _02174F34 // =0x000034CC
	ldr r2, _02174F38 // =aBoss5Nsbca
	str r0, [r5, #0x18]
	str r0, [r5, #0x1c]
	str r0, [r5, #0x20]
	ldr r0, _02174F3C // =gameArchiveStage
	mov r1, r5
	ldr r0, [r0, #0]
	mov r3, #0
	str r0, [sp]
	mov r0, r4
	bl ObjAction3dNNMotionLoad
	mov r1, #0
	mov r2, #0x52
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	lsl r2, r2, #2
	ldr r2, [r5, r2]
	mov r0, r5
	mov r3, #0x1a
	bl BossHelpers__Animation__Func_2038BF0
	bl ovl01_2175A38
	mov r0, #0x1f
	ldr r1, [r4, #0x1c]
	lsl r0, r0, #8
	orr r0, r1
	str r0, [r4, #0x1c]
	ldr r1, [r4, #0x18]
	mov r0, #2
	orr r0, r1
	str r0, [r4, #0x18]
	mov r0, r4
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_02174F10: .word 0x000004E4
_02174F14: .word StageTask_Main
_02174F18: .word ovl01_2176450
_02174F1C: .word ovl01_2176288
_02174F20: .word ovl01_21758CC
_02174F24: .word 0x00088280
_02174F28: .word ovl01_2176460
_02174F2C: .word 0x02133A10
_02174F30: .word _0217AEF4
_02174F34: .word 0x000034CC
_02174F38: .word aBoss5Nsbca
_02174F3C: .word gameArchiveStage
	thumb_func_end Boss5EnemyFish2__Create

	thumb_func_start Boss5LifeSupport__Create
Boss5LifeSupport__Create: // _02174F40
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r7, r0
	mov r5, r1
	mov r6, r2
	bl ovl01_2176540
	cmp r0, #0
	bne _02174F58
	add sp, #0xc
	mov r0, #0
	pop {r4, r5, r6, r7, pc}
_02174F58:
	mov r4, #0
	str r4, [sp]
	str r4, [sp, #4]
	str r4, [sp, #8]
	ldrh r3, [r7, #2]
	ldr r2, _02175158 // =GameObject__ViewOffsetTable
	mov r0, r5
	ldrb r3, [r2, r3]
	mov r2, #0x42
	lsl r2, r2, #2
	sub r2, r2, r3
	lsl r2, r2, #0x10
	mov r1, r6
	asr r2, r2, #0x10
	mov r3, r4
	bl ovl01_217571C
	cmp r0, #0
	beq _02174F84
	add sp, #0xc
	mov r0, r4
	pop {r4, r5, r6, r7, pc}
_02174F84:
	mov r0, #6
	ldrsb r0, [r7, r0]
	bl ovl01_217599C
	cmp r0, #0
	beq _02174F96
	add sp, #0xc
	mov r0, r4
	pop {r4, r5, r6, r7, pc}
_02174F96:
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0x4e
	lsl r0, r0, #4
	str r0, [sp, #8]
	mov r2, r4
	ldr r0, _0217515C // =StageTask_Main
	ldr r1, _02175160 // =ovl01_2176528
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r2, #0x4e
	mov r0, #0
	mov r1, r4
	lsl r2, r2, #4
	bl MIi_CpuClear16
	mov r0, r4
	mov r1, r7
	mov r2, r5
	mov r3, r6
	bl GameObject__InitFromObject
	mov r0, r4
	ldr r1, _02175164 // =ovl01_2175924
	add r0, #0xfc
	str r1, [r0]
	mov r0, #0x11
	ldr r1, _02175168 // =ovl01_21758A0
	lsl r0, r0, #4
	str r1, [r4, r0]
	ldr r1, [r4, #0x20]
	sub r0, #0x10
	orr r0, r1
	str r0, [r4, #0x20]
	mov r0, #0x9f
	ldr r1, [r4, #0x1c]
	lsl r0, r0, #8
	orr r0, r1
	str r0, [r4, #0x1c]
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	mov r0, #0xb6
	lsl r0, r0, #2
	add r5, r4, r0
	sub r0, #0xc0
	add r6, r4, r0
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl ObjRect__SetAttackStat
	mov r0, r6
	mov r1, #1
	mov r2, #0x40
	bl ObjRect__SetDefenceStat
	ldrh r1, [r7, #4]
	mov r0, #3
	and r0, r1
	cmp r0, #3
	bhi _021750CA
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02175030: // jump table
	.hword _02175038 - _02175030 - 2 // case 0
	.hword _02175074 - _02175030 - 2 // case 1
	.hword _02175090 - _02175030 - 2 // case 2
	.hword _021750AE - _02175030 - 2 // case 3
_02175038:
	mov r0, #0xc
	mov r3, #0x20
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r1, r3
	mov r2, r3
	str r3, [sp, #8]
	mov r0, r6
	sub r1, #0x2c
	sub r2, #0x38
	sub r3, #0x40
	bl ObjRect__SetBox3D
	str r4, [r5]
	bl ovl01_2175A00
	str r0, [r5, #0x24]
	mov r0, #0
	strh r0, [r5, #0x22]
	mov r0, #0x14
	mov r1, #0x10
	strh r0, [r5, #0x30]
	mov r0, r1
	strh r1, [r5, #0x32]
	sub r0, #0x1a
	strh r0, [r5, #0x18]
	sub r1, #0x20
	strh r1, [r5, #0x1a]
	b _021750CA
_02175074:
	mov r0, #0xc
	str r0, [sp]
	mov r0, #0x18
	mov r2, #0
	str r0, [sp, #4]
	mov r1, #0x20
	mov r3, r2
	str r1, [sp, #8]
	mov r0, r6
	sub r1, #0x2c
	sub r3, #0x20
	bl ObjRect__SetBox3D
	b _021750CA
_02175090:
	mov r0, #0
	mov r3, #0x20
	str r0, [sp]
	mov r0, #0xc
	str r0, [sp, #4]
	mov r1, r3
	mov r2, r3
	str r3, [sp, #8]
	mov r0, r6
	sub r1, #0x38
	sub r2, #0x2c
	sub r3, #0x40
	bl ObjRect__SetBox3D
	b _021750CA
_021750AE:
	mov r0, #0x18
	mov r3, #0
	str r0, [sp]
	mov r0, #0xc
	str r0, [sp, #4]
	mov r0, #0x20
	mov r2, r3
	str r0, [sp, #8]
	mov r1, r3
	mov r0, r6
	sub r2, #0xc
	sub r3, #0x20
	bl ObjRect__SetBox3D
_021750CA:
	ldr r0, _0217516C // =ovl01_2176648
	str r4, [r6, #0x1c]
	str r0, [r6, #0x24]
	ldr r0, [r6, #0x18]
	mov r3, #4
	orr r0, r3
	str r0, [r6, #0x18]
	mov r0, #0xd9
	lsl r0, r0, #2
	add r5, r4, r0
	ldr r0, _02175170 // =0x02133A10
	ldr r2, _02175174 // =_0217AEF4
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r4
	mov r1, r5
	bl ObjAction3dNNModelLoad
	ldr r0, _02175178 // =0x000034CC
	str r0, [r5, #0x18]
	str r0, [r5, #0x1c]
	str r0, [r5, #0x20]
	ldrh r1, [r7, #4]
	mov r0, #3
	and r0, r1
	cmp r0, #3
	bhi _02175150
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0217510E: // jump table
	.hword _02175150 - _0217510E - 2 // case 0
	.hword _02175116 - _0217510E - 2 // case 1
	.hword _0217512A - _0217510E - 2 // case 2
	.hword _0217513E - _0217510E - 2 // case 3
_02175116:
	ldr r3, _0217517C // =FX_SinCosTable_+0x00002000
	mov r1, #0
	mov r2, #2
	add r5, #0x24
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	mov r0, r5
	bl MTX_RotZ33_
	b _02175150
_0217512A:
	ldr r3, _02175180 // =FX_SinCosTable_+0x00001000
	mov r1, #0
	mov r2, #2
	add r5, #0x24
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	mov r0, r5
	bl MTX_RotZ33_
	b _02175150
_0217513E:
	ldr r3, _02175184 // =FX_SinCosTable_+0x00003000
	mov r1, #0
	mov r2, #2
	add r5, #0x24
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	mov r0, r5
	bl MTX_RotZ33_
_02175150:
	mov r0, r4
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_02175158: .word GameObject__ViewOffsetTable
_0217515C: .word StageTask_Main
_02175160: .word ovl01_2176528
_02175164: .word ovl01_2175924
_02175168: .word ovl01_21758A0
_0217516C: .word ovl01_2176648
_02175170: .word 0x02133A10
_02175174: .word _0217AEF4
_02175178: .word 0x000034CC
_0217517C: .word FX_SinCosTable_+0x00002000
_02175180: .word FX_SinCosTable_+0x00001000
_02175184: .word FX_SinCosTable_+0x00003000
	thumb_func_end Boss5LifeSupport__Create

	thumb_func_start Boss5Shutter__Create
Boss5Shutter__Create: // _02175188
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r6, r0
	ldr r0, _021752A0 // =_0217AFB8
	mov r5, r1
	ldr r0, [r0, #0]
	mov r7, r2
	cmp r0, #0
	bne _021751A0
	add sp, #0xc
	mov r0, #0
	pop {r4, r5, r6, r7, pc}
_021751A0:
	bl GetTaskWork_
	bl ovl01_2175A80
	mov r1, #6
	ldrsb r1, [r6, r1]
	cmp r1, r0
	bne _021751B6
	add sp, #0xc
	mov r0, #0
	pop {r4, r5, r6, r7, pc}
_021751B6:
	mov r0, #0x15
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0x4e
	lsl r0, r0, #4
	str r0, [sp, #8]
	mov r2, #0
	ldr r0, _021752A4 // =StageTask_Main
	ldr r1, _021752A8 // =ovl01_21766D4
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r2, #0x4e
	mov r0, #0
	mov r1, r4
	lsl r2, r2, #4
	bl MIi_CpuClear16
	mov r0, r4
	mov r1, r6
	mov r2, r5
	mov r3, r7
	bl GameObject__InitFromObject
	mov r1, #0x11
	ldr r0, _021752AC // =ovl01_21758A0
	lsl r1, r1, #4
	str r0, [r4, r1]
	mov r0, r4
	ldr r2, _021752B0 // =ovl01_2175924
	add r0, #0xfc
	str r2, [r0]
	ldr r0, [r4, #0x20]
	sub r1, #0x10
	orr r0, r1
	str r0, [r4, #0x20]
	mov r0, #0x9f
	ldr r1, [r4, #0x1c]
	lsl r0, r0, #8
	orr r0, r1
	str r0, [r4, #0x1c]
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	mov r0, #0xb6
	lsl r0, r0, #2
	add r5, r4, r0
	str r4, [r5]
	bl ovl01_2175A00
	str r0, [r5, #0x24]
	mov r0, #0
	strh r0, [r5, #0x22]
	ldrh r1, [r6, #4]
	mov r0, #1
	tst r0, r1
	beq _02175248
	mov r0, #0x80
	mov r1, #0x40
	strh r0, [r5, #0x30]
	mov r0, r1
	strh r1, [r5, #0x32]
	sub r0, #0x80
	strh r0, [r5, #0x18]
	sub r1, #0x60
	b _02175258
_02175248:
	mov r0, #0x40
	mov r1, #0x80
	strh r0, [r5, #0x30]
	mov r0, r1
	strh r1, [r5, #0x32]
	sub r0, #0xa0
	strh r0, [r5, #0x18]
	sub r1, #0xc0
_02175258:
	mov r0, #0xd9
	lsl r0, r0, #2
	strh r1, [r5, #0x1a]
	add r5, r4, r0
	ldr r0, _021752B4 // =0x02133A10
	ldr r2, _021752B8 // =_0217AEF4
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r4
	mov r1, r5
	mov r3, #5
	bl ObjAction3dNNModelLoad
	mov r0, #2
	lsl r0, r0, #0xe
	str r0, [r5, #0x18]
	str r0, [r5, #0x1c]
	str r0, [r5, #0x20]
	ldrh r1, [r6, #4]
	mov r0, #1
	tst r0, r1
	beq _02175298
	ldr r3, _021752BC // =FX_SinCosTable_+0x00001000
	mov r1, #0
	mov r2, #2
	add r5, #0x24
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	mov r0, r5
	bl MTX_RotZ33_
_02175298:
	mov r0, r4
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_021752A0: .word _0217AFB8
_021752A4: .word StageTask_Main
_021752A8: .word ovl01_21766D4
_021752AC: .word ovl01_21758A0
_021752B0: .word ovl01_2175924
_021752B4: .word 0x02133A10
_021752B8: .word _0217AEF4
_021752BC: .word FX_SinCosTable_+0x00001000
	thumb_func_end Boss5Shutter__Create

	thumb_func_start ovl01_21752C0
ovl01_21752C0: // _021752C0
	push {r3, r4, r5, lr}
	ldr r1, _02175324 // =_0217AFB8
	mov r4, r0
	ldr r1, [r1, #0]
	cmp r1, #0
	bne _021752D2
	bl MTX_Identity43_
	pop {r3, r4, r5, pc}
_021752D2:
	mov r0, r1
	bl GetTaskWork_
	mov r1, #0xdd
	lsl r1, r1, #2
	ldr r1, [r0, r1]
	mov r0, #0x1f
	lsl r0, r0, #6
	add r5, r1, r0
	mov r3, r4
	mov r2, #6
_021752E8:
	ldmia r5!, {r0, r1}
	stmia r3!, {r0, r1}
	sub r2, r2, #1
	bne _021752E8
	mov r1, #0
	mov r0, #1
	str r1, [r4, #0xc]
	lsl r0, r0, #0xc
	str r0, [r4, #0x10]
	mov r0, r4
	str r1, [r4, #0x14]
	add r0, #0x18
	str r1, [r4, #0x1c]
	mov r1, r0
	bl VEC_Normalize
	mov r0, r4
	mov r1, r4
	add r0, #0xc
	add r1, #0x18
	mov r2, r4
	bl VEC_CrossProduct
	mov r0, #0x46
	ldr r1, [r4, #0x28]
	lsl r0, r0, #0xc
	sub r0, r1, r0
	str r0, [r4, #0x28]
	pop {r3, r4, r5, pc}
	nop
_02175324: .word _0217AFB8
	thumb_func_end ovl01_21752C0

	thumb_func_start ovl01_2175328
ovl01_2175328: // _02175328
	push {r4, lr}
	sub sp, #0x68
	mov r4, r0
	bl MapFarSys__GetAsset
	str r0, [r4]
	ldr r2, _02175368 // =gameArchiveStage
	ldr r1, _0217536C // =aExc_6
	ldr r2, [r2, #0]
	add r0, sp, #0
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #0x1a
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #4]
	add r0, sp, #0
	mov r1, #0x18
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #8]
	add r0, sp, #0
	mov r1, #0x19
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0xc]
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	add sp, #0x68
	pop {r4, pc}
	.align 2, 0
_02175368: .word gameArchiveStage
_0217536C: .word aExc_6
	thumb_func_end ovl01_2175328

	thumb_func_start ovl01_2175370
ovl01_2175370: // _02175370
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x38
	ldr r1, _02175518 // =0x00000B14
	mov r5, r0
	ldr r0, [r5, r1]
	cmp r0, #0
	beq _02175380
	b _02175512
_02175380:
	ldr r2, _0217551C // =_0217A138
	mov r0, #0
	ldrh r3, [r2, #0x10]
	str r0, [sp, #0x24]
	add r0, sp, #0x28
	strh r3, [r0, #8]
	ldrh r3, [r2, #0x12]
	add r6, sp, #0x30
	strh r3, [r0, #0xa]
	ldrh r3, [r2, #0x14]
	ldrh r2, [r2, #0x16]
	strh r3, [r0, #0xc]
	strh r2, [r0, #0xe]
	add r0, r1, #4
	add r4, r5, r0
	ldr r0, _02175520 // =VRAMSystem__VRAM_PALETTE_OBJ
	ldr r7, [r0, #0]
_021753A2:
	mov r0, #0xda
	lsl r0, r0, #2
	ldr r0, [r5, r0]
	mov r1, #0
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	str r7, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r1, #0xda
	str r0, [sp, #0x18]
	lsl r1, r1, #2
	ldr r1, [r5, r1]
	mov r0, r4
	mov r2, #0
	mov r3, #0x10
	bl AnimatorSprite__Init
	mov r0, #0xda
	lsl r0, r0, #2
	ldr r0, [r5, r0]
	mov r1, #0
	mov r2, #0x76
	bl ObjDrawAllocSpritePalette
	mov r1, r4
	add r1, #0x50
	strh r0, [r1]
	mov r0, #0
	ldrsh r0, [r6, r0]
	strh r0, [r4, #8]
	mov r0, #2
	ldrsh r0, [r6, r0]
	add r6, r6, #4
	strh r0, [r4, #0xa]
	ldr r0, [sp, #0x24]
	add r4, #0x64
	add r0, r0, #1
	str r0, [sp, #0x24]
	cmp r0, #2
	blt _021753A2
	mov r0, #0xbe
	lsl r0, r0, #4
	add r4, r5, r0
	mov r0, #0xda
	lsl r0, r0, #2
	ldr r0, [r5, r0]
	mov r1, #0x14
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	str r7, [sp, #0x10]
	str r1, [sp, #0x14]
	str r1, [sp, #0x18]
	mov r1, #0xda
	lsl r1, r1, #2
	ldr r1, [r5, r1]
	mov r0, r4
	mov r2, #0x14
	mov r3, #0x10
	bl AnimatorSprite__Init
	mov r0, #0xda
	lsl r0, r0, #2
	ldr r0, [r5, r0]
	mov r1, #0x14
	mov r2, #0x76
	bl ObjDrawAllocSpritePalette
	mov r1, r4
	add r1, #0x50
	strh r0, [r1]
	mov r0, #0x86
	strh r0, [r4, #8]
	mov r0, #0x1e
	mov r1, #0
	strh r0, [r4, #0xa]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, _0217551C // =_0217A138
	mov r0, #0
	str r0, [sp, #0x20]
	ldrh r2, [r1, #0x18]
	add r0, sp, #0x28
	add r6, sp, #0x28
	strh r2, [r0]
	ldrh r2, [r1, #0x1a]
	strh r2, [r0, #2]
	ldrh r2, [r1, #0x1c]
	ldrh r1, [r1, #0x1e]
	strh r2, [r0, #4]
	strh r1, [r0, #6]
	ldr r0, _02175524 // =0x00000C44
	add r4, r5, r0
_02175484:
	mov r0, #0xda
	lsl r0, r0, #2
	ldr r0, [r5, r0]
	mov r1, #0xa
	str r4, [sp, #0x1c]
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	str r7, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r1, #0xda
	str r0, [sp, #0x18]
	lsl r1, r1, #2
	ldr r1, [r5, r1]
	mov r0, r4
	mov r2, #0xa
	mov r3, #0x10
	bl AnimatorSprite__Init
	mov r0, #0xda
	lsl r0, r0, #2
	ldr r0, [r5, r0]
	mov r1, #0xa
	mov r2, #0x76
	bl ObjDrawAllocSpritePalette
	mov r1, r4
	add r1, #0x50
	strh r0, [r1]
	mov r0, #0
	ldrsh r0, [r6, r0]
	strh r0, [r4, #8]
	mov r0, #2
	ldrsh r0, [r6, r0]
	add r6, r6, #4
	strh r0, [r4, #0xa]
	ldr r0, [sp, #0x20]
	add r4, #0x64
	add r0, r0, #1
	str r0, [sp, #0x20]
	cmp r0, #2
	blt _02175484
	ldr r0, [sp, #0x1c]
	mov r2, #0
	add r0, #0x50
	str r2, [sp]
	str r0, [sp, #0x1c]
	ldrh r0, [r0, #0]
	mov r1, #0xdb
	lsl r1, r1, #2
	lsl r0, r0, #5
	add r0, r7, r0
	str r0, [sp, #4]
	ldr r0, _02175528 // =0x00000D0C
	ldr r1, [r5, r1]
	add r0, r5, r0
	mov r3, #2
	bl InitPaletteAnimator
	ldr r0, _02175518 // =0x00000B14
	mov r1, #1
	str r1, [r5, r0]
_02175512:
	add sp, #0x38
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02175518: .word 0x00000B14
_0217551C: .word _0217A138
_02175520: .word VRAMSystem__VRAM_PALETTE_OBJ
_02175524: .word 0x00000C44
_02175528: .word 0x00000D0C
	thumb_func_end ovl01_2175370

	thumb_func_start ovl01_217552C
ovl01_217552C: // _0217552C
	push {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, _021755A8 // =0x00000B14
	ldr r1, [r6, r0]
	cmp r1, #0
	beq _021755A4
	add r0, r0, #4
	mov r4, #0
	add r5, r6, r0
_0217553E:
	mov r0, r5
	add r0, #0x50
	ldrh r0, [r0, #0]
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	bl ObjDrawReleaseSpritePalette
	mov r0, r5
	bl AnimatorSprite__Release
	add r4, r4, #1
	add r5, #0x64
	cmp r4, #2
	blt _0217553E
	mov r4, #0xbe
	lsl r4, r4, #4
	add r0, r6, r4
	add r0, #0x50
	ldrh r0, [r0, #0]
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	bl ObjDrawReleaseSpritePalette
	add r0, r6, r4
	bl AnimatorSprite__Release
	mov r0, r4
	add r0, #0x64
	mov r5, #0
	add r4, r6, r0
_0217557A:
	mov r0, r4
	add r0, #0x50
	ldrh r0, [r0, #0]
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	bl ObjDrawReleaseSpritePalette
	mov r0, r4
	bl AnimatorSprite__Release
	add r5, r5, #1
	add r4, #0x64
	cmp r5, #2
	blt _0217557A
	ldr r0, _021755AC // =0x00000D0C
	add r0, r6, r0
	bl ReleasePaletteAnimator
	ldr r0, _021755A8 // =0x00000B14
	mov r1, #0
	str r1, [r6, r0]
_021755A4:
	pop {r4, r5, r6, pc}
	nop
_021755A8: .word 0x00000B14
_021755AC: .word 0x00000D0C
	thumb_func_end ovl01_217552C

	thumb_func_start ovl01_21755B0
ovl01_21755B0: // _021755B0
	push {r3, r4, r5, lr}
	sub sp, #8
	mov r4, r0
	ldr r0, _021756B8 // =0x00000B14
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _021756B2
	ldr r0, _021756BC // =0x00000404
	add r2, sp, #0
	ldrh r0, [r4, r0]
	add r1, sp, #4
	add r2, #2
	add r3, sp, #0
	bl AkUtilFrameToTime
	add r0, sp, #0
	ldrh r0, [r0, #2]
	mov r1, #0xa
	bl FX_DivS32
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	ldr r0, _021756C0 // =0x00000B7C
	lsl r1, r5, #0x10
	add r0, r4, r0
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	ldr r0, _021756C0 // =0x00000B7C
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, sp, #0
	ldrh r1, [r0, #2]
	mov r0, #0xa
	mul r0, r5
	sub r0, r1, r0
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	ldr r0, _021756C4 // =0x00000B18
	lsl r1, r1, #0x10
	add r0, r4, r0
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	ldr r0, _021756C4 // =0x00000B18
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, sp, #0
	ldrh r0, [r0, #0]
	mov r1, #0xa
	bl FX_DivS32
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	mov r1, r5
	ldr r0, _021756C8 // =0x00000CA8
	add r1, #0xa
	lsl r1, r1, #0x10
	add r0, r4, r0
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	ldr r0, _021756C8 // =0x00000CA8
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r1, sp, #0
	ldrh r2, [r1, #0]
	mov r1, #0xa
	mul r1, r5
	sub r1, r2, r1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	ldr r0, _021756CC // =0x00000C44
	add r1, #0xa
	lsl r1, r1, #0x10
	add r0, r4, r0
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	ldr r0, _021756CC // =0x00000C44
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, _021756BC // =0x00000404
	ldrh r1, [r4, r0]
	mov r0, #0x96
	lsl r0, r0, #2
	cmp r1, r0
	bhs _0217568E
	mov r0, #0xd1
	lsl r0, r0, #4
	ldrh r1, [r4, r0]
	cmp r1, #1
	beq _021756A2
	sub r0, r0, #4
	add r0, r4, r0
	mov r1, #1
	bl SetPaletteAnimation
	b _021756A2
_0217568E:
	mov r0, #0xd1
	lsl r0, r0, #4
	ldrh r1, [r4, r0]
	cmp r1, #0
	beq _021756A2
	sub r0, r0, #4
	add r0, r4, r0
	mov r1, #0
	bl SetPaletteAnimation
_021756A2:
	ldr r0, _021756D0 // =0x00000D0C
	add r0, r4, r0
	bl AnimatePalette
	ldr r0, _021756D0 // =0x00000D0C
	add r0, r4, r0
	bl DrawAnimatedPalette
_021756B2:
	add sp, #8
	pop {r3, r4, r5, pc}
	nop
_021756B8: .word 0x00000B14
_021756BC: .word 0x00000404
_021756C0: .word 0x00000B7C
_021756C4: .word 0x00000B18
_021756C8: .word 0x00000CA8
_021756CC: .word 0x00000C44
_021756D0: .word 0x00000D0C
	thumb_func_end ovl01_21755B0

	thumb_func_start ovl01_21756D4
ovl01_21756D4: // _021756D4
	push {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, _02175714 // =0x00000B14
	ldr r1, [r6, r0]
	cmp r1, #0
	beq _02175712
	add r0, r0, #4
	mov r4, #0
	add r5, r6, r0
_021756E6:
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	add r4, r4, #1
	add r5, #0x64
	cmp r4, #2
	blt _021756E6
	mov r0, #0xbe
	lsl r0, r0, #4
	add r0, r6, r0
	bl AnimatorSprite__DrawFrame
	ldr r0, _02175718 // =0x00000C44
	mov r4, #0
	add r5, r6, r0
_02175704:
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	add r4, r4, #1
	add r5, #0x64
	cmp r4, #2
	blt _02175704
_02175712:
	pop {r4, r5, r6, pc}
	.align 2, 0
_02175714: .word 0x00000B14
_02175718: .word 0x00000C44
	thumb_func_end ovl01_21756D4

	thumb_func_start ovl01_217571C
ovl01_217571C: // _0217571C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	str r0, [sp]
	ldr r0, _02175898 // =g_obj
	mov r5, #1
	lsl r5, r5, #8
	mov r4, r2
	str r1, [sp, #4]
	ldr r0, [r0, #0]
	lsl r2, r5, #4
	mov r7, r3
	mov r1, #0xc0
	ldr r6, [sp, #0x28]
	cmp r0, r2
	beq _0217575A
	lsl r2, r5, #5
	sub r3, r2, r0
	asr r2, r3, #0x1f
	lsr r0, r3, #0x18
	lsl r2, r2, #8
	orr r2, r0
	lsl r0, r3, #8
	lsl r3, r5, #3
	add r0, r0, r3
	ldr r3, _0217589C // =0x00000000
	adc r2, r3
	lsl r2, r2, #0x14
	lsr r0, r0, #0xc
	orr r0, r2
	lsl r0, r0, #0x10
	asr r5, r0, #0x10
_0217575A:
	ldr r0, _02175898 // =g_obj
	mov r2, #1
	ldr r0, [r0, #4]
	lsl r2, r2, #0xc
	cmp r0, r2
	beq _0217578A
	lsl r1, r2, #1
	sub r0, r1, r0
	asr r1, r0, #0x1f
	mov r2, #0xc0
	mov r3, #0
	bl _ull_mul
	mov r2, r0
	mov r0, #2
	mov r3, #0
	lsl r0, r0, #0xa
	add r0, r2, r0
	adc r1, r3
	lsl r1, r1, #0x14
	lsr r0, r0, #0xc
	orr r0, r1
	lsl r0, r0, #0x10
	asr r1, r0, #0x10
_0217578A:
	ldr r0, _02175898 // =g_obj
	mov r2, #2
	ldr r3, [r0, #0x28]
	lsl r2, r2, #0xa
	tst r2, r3
	beq _02175812
	ldr r3, [r0, #0x38]
	ldr r2, [r0, #0x30]
	cmp r2, r3
	bge _021757BC
	ldr r0, [r0, #0x2c]
	asr r0, r0, #0xc
	sub r0, r0, r4
	str r0, [sp, #8]
	asr r0, r2, #0xc
	str r0, [sp, #0xc]
	lsl r2, r4, #1
	sub r0, r0, r4
	add r4, r5, r2
	asr r5, r3, #0xc
	ldr r3, [sp, #0xc]
	sub r3, r5, r3
	add r1, r1, r3
	add r2, r2, r1
	b _021757D8
_021757BC:
	ldr r0, [r0, #0x34]
	asr r2, r2, #0xc
	asr r0, r0, #0xc
	sub r0, r0, r4
	str r0, [sp, #8]
	asr r0, r3, #0xc
	mov ip, r0
	lsl r3, r4, #1
	sub r0, r0, r4
	add r4, r5, r3
	mov r5, ip
	sub r2, r2, r5
	add r1, r1, r2
	add r2, r3, r1
_021757D8:
	add r5, sp, #0x18
	mov r3, #0x18
	ldrsh r3, [r5, r3]
	ldr r1, [sp, #8]
	add r0, r0, r6
	sub r3, r3, r6
	add r2, r2, r3
	mov r3, #0x14
	ldrsh r3, [r5, r3]
	add r1, r1, r7
	sub r3, r3, r7
	add r4, r4, r3
	ldr r3, [sp]
	asr r3, r3, #0xc
	cmp r1, r3
	bgt _02175892
	add r1, r1, r4
	cmp r1, r3
	blt _02175892
	ldr r1, [sp, #4]
	asr r1, r1, #0xc
	cmp r0, r1
	bgt _02175892
	add r0, r0, r2
	cmp r0, r1
	blt _02175892
	add sp, #0x14
	mov r0, #0
	pop {r4, r5, r6, r7, pc}
_02175812:
	ldr r2, [r0, #0x2c]
	lsl r3, r4, #1
	asr r2, r2, #0xc
	add r5, r5, r3
	str r5, [sp, #0x10]
	sub r2, r2, r4
	add r3, r1, r3
	add r1, r2, r7
	mov r5, #0x18
	add r2, sp, #0x18
	ldrsh r2, [r2, r5]
	ldr r0, [r0, #0x30]
	sub r2, r2, r6
	add r5, r3, r2
	mov r3, #0x14
	add r2, sp, #0x18
	ldrsh r2, [r2, r3]
	asr r0, r0, #0xc
	sub r0, r0, r4
	sub r3, r2, r7
	ldr r2, [sp, #0x10]
	add r0, r0, r6
	add r3, r2, r3
	ldr r2, [sp]
	asr r2, r2, #0xc
	cmp r1, r2
	bgt _02175862
	add r1, r1, r3
	cmp r1, r2
	blt _02175862
	ldr r1, [sp, #4]
	asr r1, r1, #0xc
	cmp r0, r1
	bgt _02175862
	add r0, r0, r5
	cmp r0, r1
	blt _02175862
	add sp, #0x14
	mov r0, #0
	pop {r4, r5, r6, r7, pc}
_02175862:
	ldr r1, _02175898 // =g_obj
	ldr r0, [r1, #0x34]
	ldr r1, [r1, #0x38]
	asr r0, r0, #0xc
	sub r0, r0, r4
	asr r1, r1, #0xc
	sub r1, r1, r4
	add r0, r0, r7
	add r4, r1, r6
	cmp r0, r2
	bgt _02175892
	add r0, r0, r3
	cmp r0, r2
	blt _02175892
	ldr r0, [sp, #4]
	asr r1, r0, #0xc
	cmp r4, r1
	bgt _02175892
	add r0, r4, r5
	cmp r0, r1
	blt _02175892
	add sp, #0x14
	mov r0, #0
	pop {r4, r5, r6, r7, pc}
_02175892:
	mov r0, #1
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02175898: .word g_obj
_0217589C: .word 0x00000000
	thumb_func_end ovl01_217571C

	thumb_func_start ovl01_21758A0
ovl01_21758A0: // _021758A0
	push {r3, r4, lr}
	sub sp, #0xc
	mov r3, r0
	mov r0, #0x10
	ldrsh r0, [r3, r0]
	mov r2, #0xc
	mov r4, #0xe
	str r0, [sp]
	mov r0, #0x12
	ldrsh r0, [r3, r0]
	str r0, [sp, #4]
	mov r0, #0x14
	ldrsh r0, [r3, r0]
	str r0, [sp, #8]
	ldr r0, [r3, #0x44]
	ldr r1, [r3, #0x48]
	ldrsh r2, [r3, r2]
	ldrsh r3, [r3, r4]
	bl ovl01_217571C
	add sp, #0xc
	pop {r3, r4, pc}
	thumb_func_end ovl01_21758A0

	thumb_func_start ovl01_21758CC
ovl01_21758CC: // _021758CC
	push {r4, r5, r6, lr}
	ldr r0, _0217591C // =_0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl GetCurrentTaskWork_
	mov r6, #0xd9
	mov r5, r0
	lsl r6, r6, #2
	bl Camera3D__GetTask
	cmp r0, #0
	beq _021758F2
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _021758FA
_021758F2:
	ldr r1, [r5, #0x20]
	mov r0, #0x20
	orr r0, r1
	str r0, [r5, #0x20]
_021758FA:
	ldr r0, _02175920 // =0x000003C6
	add r0, r4, r0
	bl BossHelpers__Light__SetLights2
	mov r0, r5
	add r1, r5, r6
	bl StageTask__Draw3D
	ldr r0, _02175920 // =0x000003C6
	add r0, r4, r0
	bl BossHelpers__Light__SetLights1
	ldr r1, [r5, #0x20]
	mov r0, #0x20
	bic r1, r0
	str r1, [r5, #0x20]
	pop {r4, r5, r6, pc}
	.align 2, 0
_0217591C: .word _0217AFB8
_02175920: .word 0x000003C6
	thumb_func_end ovl01_21758CC

	thumb_func_start ovl01_2175924
ovl01_2175924: // _02175924
	push {r4, r5, r6, lr}
	ldr r0, _02175974 // =_0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl GetCurrentTaskWork_
	mov r6, #0xd9
	mov r5, r0
	lsl r6, r6, #2
	bl Camera3D__GetTask
	cmp r0, #0
	beq _0217594A
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _02175952
_0217594A:
	ldr r1, [r5, #0x20]
	mov r0, #0x20
	orr r0, r1
	str r0, [r5, #0x20]
_02175952:
	ldr r0, _02175978 // =0x000003C6
	add r0, r4, r0
	bl BossHelpers__Light__SetLights2
	mov r0, r5
	add r1, r5, r6
	bl StageTask__Draw3D
	ldr r0, _02175978 // =0x000003C6
	add r0, r4, r0
	bl BossHelpers__Light__SetLights1
	ldr r1, [r5, #0x20]
	mov r0, #0x20
	bic r1, r0
	str r1, [r5, #0x20]
	pop {r4, r5, r6, pc}
	.align 2, 0
_02175974: .word _0217AFB8
_02175978: .word 0x000003C6
	thumb_func_end ovl01_2175924

	thumb_func_start ovl01_217597C
ovl01_217597C: // _0217597C
	push {r3, lr}
	ldr r0, _02175994 // =_0217AFB8
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _02175990
	bl GetTaskWork_
	ldr r1, _02175998 // =0x00000D2C
	mov r2, #0
	str r2, [r0, r1]
_02175990:
	pop {r3, pc}
	nop
_02175994: .word _0217AFB8
_02175998: .word 0x00000D2C
	thumb_func_end ovl01_217597C

	thumb_func_start ovl01_217599C
ovl01_217599C: // _0217599C
	push {r4, lr}
	mov r4, r0
	ldr r0, _021759BC // =_0217AFB8
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _021759AC
	mov r0, #1
	pop {r4, pc}
_021759AC:
	bl GetTaskWork_
	ldr r1, _021759C0 // =0x00000D2C
	ldr r1, [r0, r1]
	mov r0, #1
	lsl r0, r4
	and r0, r1
	pop {r4, pc}
	.align 2, 0
_021759BC: .word _0217AFB8
_021759C0: .word 0x00000D2C
	thumb_func_end ovl01_217599C

	thumb_func_start ovl01_21759C4
ovl01_21759C4: // _021759C4
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _021759F8 // =_0217AFB8
	mov r4, r1
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _021759F4
	bl GetTaskWork_
	cmp r4, #0
	ldr r1, _021759FC // =0x00000D2C
	beq _021759E8
	mov r2, #1
	ldr r3, [r0, r1]
	lsl r2, r5
	orr r2, r3
	str r2, [r0, r1]
	pop {r3, r4, r5, pc}
_021759E8:
	mov r2, #1
	lsl r2, r5
	ldr r3, [r0, r1]
	mvn r2, r2
	and r2, r3
	str r2, [r0, r1]
_021759F4:
	pop {r3, r4, r5, pc}
	nop
_021759F8: .word _0217AFB8
_021759FC: .word 0x00000D2C
	thumb_func_end ovl01_21759C4

	thumb_func_start ovl01_2175A00
ovl01_2175A00: // _02175A00
	push {r3, lr}
	ldr r0, _02175A14 // =_0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0xd3
	lsl r1, r1, #4
	add r0, r0, r1
	pop {r3, pc}
	nop
_02175A14: .word _0217AFB8
	thumb_func_end ovl01_2175A00

	thumb_func_start ovl01_2175A18
ovl01_2175A18: // _02175A18
	ldrh r1, [r0, #4]
	mov r0, #0x80
	tst r0, r1
	bne _02175A24
	mov r0, #1
	bx lr
_02175A24:
	ldr r0, _02175A34 // =gameState
	ldr r0, [r0, #0x18]
	cmp r0, #0
	beq _02175A30
	mov r0, #1
	bx lr
_02175A30:
	mov r0, #0
	bx lr
	.align 2, 0
_02175A34: .word gameState
	thumb_func_end ovl01_2175A18

	thumb_func_start ovl01_2175A38
ovl01_2175A38: // _02175A38
	push {r4, lr}
	ldr r0, _02175A58 // =_0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0xe
	lsl r0, r0, #6
	ldrh r1, [r4, r0]
	add r1, r1, #1
	strh r1, [r4, r0]
	bl ovl01_2175B6C
	ldr r1, _02175A5C // =0x00000382
	strh r0, [r4, r1]
	pop {r4, pc}
	.align 2, 0
_02175A58: .word _0217AFB8
_02175A5C: .word 0x00000382
	thumb_func_end ovl01_2175A38

	thumb_func_start ovl01_2175A60
ovl01_2175A60: // _02175A60
	push {r3, lr}
	ldr r0, _02175A7C // =_0217AFB8
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _02175A78
	bl GetTaskWork_
	mov r1, #0xe
	lsl r1, r1, #6
	ldrh r2, [r0, r1]
	sub r2, r2, #1
	strh r2, [r0, r1]
_02175A78:
	pop {r3, pc}
	nop
_02175A7C: .word _0217AFB8
	thumb_func_end ovl01_2175A60

	thumb_func_start ovl01_2175A80
ovl01_2175A80: // _02175A80
	mov r1, #0xe3
	lsl r1, r1, #2
	ldrsh r3, [r0, r1]
	ldr r1, _02175AA4 // =_0217A13C
	mov r2, #0
_02175A8A:
	lsl r0, r2, #1
	ldrsh r0, [r1, r0]
	cmp r0, r3
	bge _02175A96
	mov r0, r2
	bx lr
_02175A96:
	add r0, r2, #1
	lsl r0, r0, #0x10
	lsr r2, r0, #0x10
	cmp r2, #2
	blo _02175A8A
	mov r0, r2
	bx lr
	.align 2, 0
_02175AA4: .word _0217A13C
	thumb_func_end ovl01_2175A80

	thumb_func_start ovl01_2175AA8
ovl01_2175AA8: // _02175AA8
	push {r3, lr}
	ldr r1, _02175AE8 // =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	bne _02175AD0
	ldr r1, [r1, #0x70]
	cmp r1, #0xf
	bne _02175AD0
	bl ovl01_2175A80
	ldr r1, _02175AE8 // =gameState
	ldr r2, [r1, #0x18]
	mov r1, #6
	mov r3, r2
	mul r3, r1
	ldr r2, _02175AEC // =_0217A1AC
	lsl r1, r0, #1
	add r0, r2, r3
	ldrh r0, [r1, r0]
	pop {r3, pc}
_02175AD0:
	bl ovl01_2175A80
	ldr r1, _02175AE8 // =gameState
	ldr r2, [r1, #0x18]
	mov r1, #6
	mov r3, r2
	mul r3, r1
	ldr r2, _02175AF0 // =_0217A194
	lsl r1, r0, #1
	add r0, r2, r3
	ldrh r0, [r1, r0]
	pop {r3, pc}
	.align 2, 0
_02175AE8: .word gameState
_02175AEC: .word _0217A1AC
_02175AF0: .word _0217A194
	thumb_func_end ovl01_2175AA8

	thumb_func_start ovl01_2175AF4
ovl01_2175AF4: // _02175AF4
	ldr r0, _02175B18 // =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #3
	bne _02175B0C
	ldr r1, [r0, #0x70]
	cmp r1, #0xf
	bne _02175B0C
	ldr r0, [r0, #0x18]
	lsl r1, r0, #1
	ldr r0, _02175B1C // =_0217A140
	ldrh r0, [r0, r1]
	bx lr
_02175B0C:
	ldr r0, _02175B18 // =gameState
	ldr r0, [r0, #0x18]
	lsl r1, r0, #1
	ldr r0, _02175B20 // =_0217A138
	ldrh r0, [r0, r1]
	bx lr
	.align 2, 0
_02175B18: .word gameState
_02175B1C: .word _0217A140
_02175B20: .word _0217A138
	thumb_func_end ovl01_2175AF4

	thumb_func_start ovl01_2175B24
ovl01_2175B24: // _02175B24
	push {r3, lr}
	bl ovl01_2175A80
	ldr r1, _02175B40 // =gameState
	ldr r2, [r1, #0x18]
	mov r1, #6
	mov r3, r2
	mul r3, r1
	ldr r2, _02175B44 // =_0217A158
	lsl r1, r0, #1
	add r0, r2, r3
	ldrh r0, [r1, r0]
	pop {r3, pc}
	nop
_02175B40: .word gameState
_02175B44: .word _0217A158
	thumb_func_end ovl01_2175B24

	thumb_func_start ovl01_2175B48
ovl01_2175B48: // _02175B48
	ldr r1, _02175B64 // =gameState
	ldr r2, [r1, #0x18]
	mov r1, #0xc
	mov r3, r2
	mul r3, r1
	mov r1, #0xde
	lsl r1, r1, #2
	ldr r0, [r0, r1]
	ldr r2, _02175B68 // =_0217A1D8
	ldr r0, [r0, r1]
	lsl r1, r0, #1
	add r0, r2, r3
	ldrh r0, [r1, r0]
	bx lr
	.align 2, 0
_02175B64: .word gameState
_02175B68: .word _0217A1D8
	thumb_func_end ovl01_2175B48

	thumb_func_start ovl01_2175B6C
ovl01_2175B6C: // _02175B6C
	push {r3, r4, r5, r6}
	ldr r4, _02175BA4 // =_mt_math_rand
	ldr r0, _02175BA8 // =gameState
	ldr r5, [r4, #0]
	ldr r3, _02175BAC // =0x00196225
	ldr r2, [r0, #0x18]
	mov r6, r5
	mov r0, #6
	mul r6, r3
	ldr r3, _02175BB0 // =0x3C6EF35F
	ldr r1, _02175BB4 // =_0217A1A0
	mul r0, r2
	add r2, r1, r0
	add r5, r6, r3
	ldrh r0, [r1, r0]
	ldrh r3, [r2, #4]
	lsr r1, r5, #0x10
	lsl r1, r1, #0x10
	ldrh r2, [r2, #2]
	lsr r1, r1, #0x10
	str r5, [r4]
	and r1, r2
	mul r1, r3
	add r0, r0, r1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	pop {r3, r4, r5, r6}
	bx lr
	.align 2, 0
_02175BA4: .word _mt_math_rand
_02175BA8: .word gameState
_02175BAC: .word 0x00196225
_02175BB0: .word 0x3C6EF35F
_02175BB4: .word _0217A1A0
	thumb_func_end ovl01_2175B6C

	thumb_func_start ovl01_2175BB8
ovl01_2175BB8: // _02175BB8
	push {r3, lr}
	bl ovl01_2175A80
	lsl r1, r0, #2
	ldr r0, _02175BC8 // =_0217A164
	ldr r0, [r0, r1]
	pop {r3, pc}
	nop
_02175BC8: .word _0217A164
	thumb_func_end ovl01_2175BB8

	thumb_func_start ovl01_2175BCC
ovl01_2175BCC: // _02175BCC
	bx lr
	.align 2, 0
	thumb_func_end ovl01_2175BCC

	thumb_func_start ovl01_2175BD0
ovl01_2175BD0: // _02175BD0
	push {r3, r4, r5, lr}
	ldr r0, _02175C18 // =_0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r5, r0
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x20]
	mov r0, #0x20
	tst r0, r1
	bne _02175C16
	bl Camera3D__GetTask
	cmp r0, #0
	beq _02175C16
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02175C16
	ldr r0, _02175C1C // =0x000003C6
	add r0, r5, r0
	bl BossHelpers__Light__SetLights2
	mov r1, #0xd9
	lsl r1, r1, #2
	mov r0, r4
	add r1, r4, r1
	bl StageTask__Draw3D
	ldr r0, _02175C1C // =0x000003C6
	add r0, r5, r0
	bl BossHelpers__Light__SetLights1
_02175C16:
	pop {r3, r4, r5, pc}
	.align 2, 0
_02175C18: .word _0217AFB8
_02175C1C: .word 0x000003C6
	thumb_func_end ovl01_2175BD0

	thumb_func_start ovl01_2175C20
ovl01_2175C20: // _02175C20
	push {r3, r4, lr}
	sub sp, #0x14
	mov r1, #0xd9
	mov r4, r0
	lsl r1, r1, #2
	ldr r0, [r4, r1]
	cmp r0, #0
	bne _02175CA0
	add r0, r1, #6
	ldrh r3, [r4, r0]
	mov r0, r3
	sub r2, r0, #1
	add r0, r1, #6
	strh r2, [r4, r0]
	cmp r3, #0
	bne _02175CA0
	sub r1, #0x24
	ldr r1, [r4, r1]
	ldr r0, _02175CA4 // =mapCamera
	ldrh r3, [r1, #4]
	mov r1, #0x80
	mov r2, r3
	tst r2, r1
	ldr r2, [r0, #4]
	beq _02175C58
	lsl r0, r1, #0xa
	sub r1, r2, r0
	b _02175C62
_02175C58:
	ldr r0, [r0, #0x24]
	lsl r0, r0, #8
	add r2, r2, r0
	lsl r0, r1, #0xa
	add r1, r2, r0
_02175C62:
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #0x49
	ldr r2, [r4, #0x48]
	lsl r0, r0, #2
	bl GameObject__SpawnObject
	mov r1, #0xda
	lsl r1, r1, #2
	ldrh r2, [r4, r1]
	add r0, r1, #2
	strh r2, [r4, r0]
	add r0, r1, #4
	ldrh r0, [r4, r0]
	cmp r0, #0
	beq _02175CA0
	add r0, r1, #4
	ldrh r0, [r4, r0]
	sub r2, r0, #1
	add r0, r1, #4
	strh r2, [r4, r0]
	ldrh r0, [r4, r0]
	cmp r0, #0
	bne _02175CA0
	mov r2, #1
	sub r0, r1, #4
	str r2, [r4, r0]
_02175CA0:
	add sp, #0x14
	pop {r3, r4, pc}
	.align 2, 0
_02175CA4: .word mapCamera
	thumb_func_end ovl01_2175C20

	thumb_func_start ovl01_2175CA8
ovl01_2175CA8: // _02175CA8
	push {r3, r4, lr}
	sub sp, #0x14
	mov r1, #0x4e
	mov r4, r0
	lsl r1, r1, #4
	ldr r0, [r4, r1]
	cmp r0, #0
	bne _02175D20
	add r0, r1, #6
	ldrh r3, [r4, r0]
	mov r0, r3
	sub r2, r0, #1
	add r0, r1, #6
	strh r2, [r4, r0]
	cmp r3, #0
	bne _02175D20
	mov r1, #0xd
	lsl r1, r1, #6
	ldr r1, [r4, r1]
	ldr r0, [r4, #0x44]
	ldrh r3, [r1, #4]
	mov r1, #0x80
	mov r2, r3
	tst r2, r1
	beq _02175CE0
	lsl r1, r1, #0xa
	sub r1, r0, r1
	b _02175CE4
_02175CE0:
	lsl r1, r1, #0xa
	add r1, r0, r1
_02175CE4:
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #0x49
	ldr r2, [r4, #0x48]
	lsl r0, r0, #2
	bl GameObject__SpawnObject
	ldr r1, _02175D24 // =0x000004E4
	ldrh r2, [r4, r1]
	add r0, r1, #2
	strh r2, [r4, r0]
	add r0, r1, #4
	ldrh r0, [r4, r0]
	cmp r0, #0
	beq _02175D20
	add r0, r1, #4
	ldrh r0, [r4, r0]
	sub r2, r0, #1
	add r0, r1, #4
	strh r2, [r4, r0]
	ldrh r0, [r4, r0]
	cmp r0, #0
	bne _02175D20
	mov r2, #1
	sub r0, r1, #4
	str r2, [r4, r0]
_02175D20:
	add sp, #0x14
	pop {r3, r4, pc}
	.align 2, 0
_02175D24: .word 0x000004E4
	thumb_func_end ovl01_2175CA8

	thumb_func_start ovl01_2175D28
ovl01_2175D28: // _02175D28
	push {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	mov r1, #0xbf
	mov r2, #0
	lsl r1, r1, #2
	str r2, [r0, r1]
	mov r0, r4
	bl GameObject__Destructor
	pop {r4, pc}
	thumb_func_end ovl01_2175D28

	thumb_func_start ovl01_2175D40
ovl01_2175D40: // _02175D40
	push {r3, lr}
	sub sp, #8
	ldr r3, [r0, #0x1c]
	ldr r0, [r1, #0x1c]
	ldrh r0, [r0, #0]
	cmp r0, #1
	bne _02175D76
	ldr r1, [r3, #0x18]
	mov r0, #8
	orr r0, r1
	str r0, [r3, #0x18]
	ldr r2, [r3, #0x48]
	ldr r1, [r3, #0x44]
	ldr r3, [r3, #0x4c]
	mov r0, #0
	neg r2, r2
	bl BossFX__CreateBomb
	mov r0, #0
	str r0, [sp]
	mov r1, #0x99
	str r1, [sp, #4]
	sub r1, #0x9a
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02175D76:
	add sp, #8
	pop {r3, pc}
	.align 2, 0
	thumb_func_end ovl01_2175D40

	thumb_func_start ovl01_2175D7C
ovl01_2175D7C: // _02175D7C
	push {r4, r5, lr}
	sub sp, #0x14
	ldr r3, _02175DC8 // =0x0000036A
	mov r4, r0
	ldrh r1, [r4, r3]
	sub r0, r1, #1
	strh r0, [r4, r3]
	cmp r1, #0
	bne _02175DC2
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	sub r2, r3, #6
	sub r3, #0x2a
	ldr r3, [r4, r3]
	ldr r5, [r4, #0x48]
	ldr r2, [r4, r2]
	ldrh r3, [r3, #4]
	ldr r0, _02175DCC // =0x00000125
	ldr r1, [r4, #0x44]
	add r2, r5, r2
	bl GameObject__SpawnObject
	mov r1, #0xd9
	lsl r1, r1, #2
	ldr r2, [r4, r1]
	asr r2, r2, #0xc
	strh r2, [r0, #0x10]
	add r0, r1, #4
	ldrh r2, [r4, r0]
	add r0, r1, #6
	strh r2, [r4, r0]
_02175DC2:
	add sp, #0x14
	pop {r4, r5, pc}
	nop
_02175DC8: .word 0x0000036A
_02175DCC: .word 0x00000125
	thumb_func_end ovl01_2175D7C

	thumb_func_start ovl01_2175DD0
ovl01_2175DD0: // _02175DD0
	push {r4, r5, lr}
	sub sp, #0x14
	mov r2, #0x4e
	mov r4, r0
	lsl r2, r2, #4
	ldr r0, [r4, r2]
	cmp r0, #0
	beq _02175DEC
	cmp r0, #1
	beq _02175E2C
	cmp r0, #2
	beq _02175EE0
	add sp, #0x14
	pop {r4, r5, pc}
_02175DEC:
	ldr r0, _02175F1C // =gPlayer
	add r3, sp, #8
	ldr r5, [r0, #0]
	add r5, #0x44
	ldmia r5!, {r0, r1}
	stmia r3!, {r0, r1}
	ldr r0, [r5, #0]
	str r0, [r3]
	mov r0, #0xd
	lsl r0, r0, #6
	ldr r1, [r4, r0]
	mov r0, #6
	ldrsb r0, [r1, r0]
	ldrb r1, [r1, #8]
	ldr r3, [r4, #0x44]
	lsl r0, r0, #0xc
	add r0, r3, r0
	lsl r1, r1, #0xc
	add r5, r0, r1
	ldr r3, [r4, #0x48]
	ldr r1, [sp, #0xc]
	cmp r3, r1
	bge _02175F18
	ldr r1, [sp, #8]
	cmp r0, r1
	bgt _02175F18
	cmp r1, r5
	bgt _02175F18
	mov r0, #1
	add sp, #0x14
	str r0, [r4, r2]
	pop {r4, r5, pc}
_02175E2C:
	ldr r1, [r4, #0x28]
	mov r0, #7
	tst r0, r1
	bne _02175E86
	add r1, #0x40
	mov r0, r4
	str r1, [r4, #0x28]
	lsr r1, r1, #6
	add r0, #0x28
	cmp r1, #0x10
	bhs _02175E6E
	ldr r2, [r0, #0]
	mov r1, #4
	orr r1, r2
	str r1, [r0]
	ldr r2, _02175F20 // =_mt_math_rand
	ldr r1, _02175F24 // =0x00196225
	ldr r3, [r2, #0]
	add sp, #0x14
	mov r4, r3
	mul r4, r1
	ldr r1, _02175F28 // =0x3C6EF35F
	add r1, r4, r1
	str r1, [r2]
	lsr r1, r1, #0x10
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	lsl r1, r1, #0x1e
	ldr r2, [r0, #0]
	lsr r1, r1, #0x1a
	eor r1, r2
	str r1, [r0]
	pop {r4, r5, pc}
_02175E6E:
	ldr r1, [r4, #0x1c]
	mov r0, #0x80
	orr r1, r0
	str r1, [r4, #0x1c]
	lsl r1, r0, #6
	mov r0, r4
	add r0, #0x9c
	str r1, [r0]
	mov r0, #2
	add sp, #0x14
	str r0, [r4, r2]
	pop {r4, r5, pc}
_02175E86:
	sub r0, r1, #1
	str r0, [r4, #0x28]
	lsr r1, r0, #4
	mov r0, #3
	and r0, r1
	cmp r0, #3
	bhi _02175F18
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02175EA0: // jump table
	.hword _02175EA8 - _02175EA0 - 2 // case 0
	.hword _02175EB6 - _02175EA0 - 2 // case 1
	.hword _02175EC4 - _02175EA0 - 2 // case 2
	.hword _02175ED2 - _02175EA0 - 2 // case 3
_02175EA8:
	mov r0, #2
	ldr r1, [r4, #0x50]
	lsl r0, r0, #0xc
	sub r0, r1, r0
	add sp, #0x14
	str r0, [r4, #0x50]
	pop {r4, r5, pc}
_02175EB6:
	mov r0, #2
	ldr r1, [r4, #0x50]
	lsl r0, r0, #0xc
	add r0, r1, r0
	add sp, #0x14
	str r0, [r4, #0x50]
	pop {r4, r5, pc}
_02175EC4:
	mov r0, #2
	ldr r1, [r4, #0x54]
	lsl r0, r0, #0xc
	sub r0, r1, r0
	add sp, #0x14
	str r0, [r4, #0x54]
	pop {r4, r5, pc}
_02175ED2:
	mov r0, #2
	ldr r1, [r4, #0x54]
	lsl r0, r0, #0xc
	add r0, r1, r0
	add sp, #0x14
	str r0, [r4, #0x54]
	pop {r4, r5, pc}
_02175EE0:
	ldr r0, [r4, #0x24]
	cmp r0, #0
	bne _02175F18
	mov r0, #1
	str r0, [r4, #0x24]
	mov r0, #0
	str r0, [sp]
	mov r1, #0xdd
	mov r0, #0xcf
	str r1, [sp, #4]
	sub r1, #0xde
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	mov r0, #0xcf
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	add r4, #0x44
	mov r1, r4
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
_02175F18:
	add sp, #0x14
	pop {r4, r5, pc}
	.align 2, 0
_02175F1C: .word gPlayer
_02175F20: .word _mt_math_rand
_02175F24: .word 0x00196225
_02175F28: .word 0x3C6EF35F
	thumb_func_end ovl01_2175DD0

	thumb_func_start ovl01_2175F2C
ovl01_2175F2C: // _02175F2C
	push {r3, lr}
	ldr r0, [r0, #0x1c]
	ldrh r1, [r0, #0]
	cmp r1, #1
	bne _02175F42
	ldr r1, _02175F44 // =0x00000682
	ldrsh r1, [r0, r1]
	cmp r1, #0
	bne _02175F42
	bl BossPlayerHelpers_Action_Boss5Freeze
_02175F42:
	pop {r3, pc}
	.align 2, 0
_02175F44: .word 0x00000682
	thumb_func_end ovl01_2175F2C

	thumb_func_start ovl01_2175F48
ovl01_2175F48: // _02175F48
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r5, r0
	ldr r0, _02176080 // =gPlayer
	mov r6, #0
	ldr r4, [r0, #0]
	mov r0, #0x10
	ldr r1, [r4, #0x1c]
	tst r0, r1
	bne _02175FA6
	mov r3, r4
	add r3, #0x44
	ldmia r3!, {r0, r1}
	add r2, sp, #0
	stmia r2!, {r0, r1}
	ldr r0, [r3, #0]
	mov r1, #6
	str r0, [r2]
	mov r0, #0xd
	lsl r0, r0, #6
	ldr r2, [r5, r0]
	ldr r0, [r5, #0x44]
	ldrsb r1, [r2, r1]
	mov r3, #7
	ldrsb r3, [r2, r3]
	lsl r1, r1, #0xc
	add r1, r0, r1
	ldrb r0, [r2, #8]
	ldrb r2, [r2, #9]
	lsl r3, r3, #0xc
	lsl r0, r0, #0xc
	add r7, r1, r0
	ldr r0, [r5, #0x48]
	lsl r2, r2, #0xc
	add r0, r0, r3
	add r3, r0, r2
	ldr r2, [sp]
	cmp r1, r2
	bgt _02175FA6
	cmp r2, r7
	bgt _02175FA6
	ldr r1, [sp, #4]
	cmp r0, r1
	bgt _02175FA6
	cmp r1, r3
	bgt _02175FA6
	mov r6, #1
_02175FA6:
	mov r0, #0xd9
	lsl r0, r0, #2
	ldr r0, [r5, r0]
	cmp r0, #0
	bne _0217603A
	cmp r6, #0
	beq _0217603A
	mov r0, #0x5d
	lsl r0, r0, #4
	ldrb r1, [r4, r0]
	mov r0, #0x58
	mov r3, #0
	mov r2, r1
	mul r2, r0
	ldr r0, _02176084 // =playerPhysicsTable
	ldr r0, [r0, r2]
	ldr r2, _02176088 // =0x00000999
	asr r1, r0, #0x1f
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	mov r0, #6
	lsl r0, r0, #8
	str r1, [r4, r0]
	sub r0, #0x30
	ldrb r1, [r4, r0]
	mov r0, #0x58
	mov r2, r1
	mul r2, r0
	ldr r0, _0217608C // =0x0210E980
	ldr r0, [r0, r2]
	ldr r2, _02176090 // =0x00000199
	asr r1, r0, #0x1f
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	ldr r0, _02176094 // =0x00000608
	str r1, [r4, r0]
	sub r0, #0x38
	ldrb r1, [r4, r0]
	mov r0, #0x58
	mov r2, r1
	mul r2, r0
	ldr r0, _02176098 // =0x0210E990
	ldr r0, [r0, r2]
	ldr r2, _02176090 // =0x00000199
	asr r1, r0, #0x1f
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	ldr r0, _0217609C // =0x00000618
	str r1, [r4, r0]
	b _02176074
_0217603A:
	cmp r0, #0
	beq _02176074
	cmp r6, #0
	bne _02176074
	mov r2, #0x5d
	lsl r2, r2, #4
	ldrb r0, [r4, r2]
	mov r1, #0x58
	mov r3, r0
	ldr r0, _02176084 // =playerPhysicsTable
	mul r3, r1
	ldr r3, [r0, r3]
	mov r0, r2
	add r0, #0x30
	str r3, [r4, r0]
	ldrb r0, [r4, r2]
	mov r3, r0
	ldr r0, _0217608C // =0x0210E980
	mul r3, r1
	ldr r3, [r0, r3]
	mov r0, r2
	add r0, #0x38
	str r3, [r4, r0]
	ldrb r0, [r4, r2]
	add r2, #0x48
	mul r1, r0
	ldr r0, _02176098 // =0x0210E990
	ldr r0, [r0, r1]
	str r0, [r4, r2]
_02176074:
	mov r0, #0xd9
	lsl r0, r0, #2
	str r6, [r5, r0]
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_02176080: .word gPlayer
_02176084: .word playerPhysicsTable
_02176088: .word 0x00000999
_0217608C: .word 0x0210E980
_02176090: .word 0x00000199
_02176094: .word 0x00000608
_02176098: .word 0x0210E990
_0217609C: .word 0x00000618
	thumb_func_end ovl01_2175F48

	thumb_func_start ovl01_21760A0
ovl01_21760A0: // _021760A0
	push {r4, r5, r6, r7}
	mov r6, r0
	ldr r0, _02176228 // =gPlayer
	mov r1, #0xd
	lsl r1, r1, #6
	ldr r2, [r0, #0]
	mov r4, r1
	ldr r0, [r6, r1]
	mov r5, #6
	ldrsb r5, [r0, r5]
	add r1, #0xc
	add r4, #8
	ldr r7, [r6, r1]
	mov r1, #7
	ldrsb r1, [r0, r1]
	ldr r4, [r6, r4]
	lsl r5, r5, #0xc
	add r4, r4, r5
	ldrb r5, [r0, #8]
	ldrb r0, [r0, #9]
	lsl r1, r1, #0xc
	add r1, r7, r1
	lsl r5, r5, #0xc
	lsl r0, r0, #0xc
	ldr r7, [r2, #0x44]
	mov r3, #0
	add r5, r4, r5
	add r0, r1, r0
	cmp r4, r7
	bgt _021760EC
	cmp r7, r5
	bgt _021760EC
	ldr r2, [r2, #0x48]
	cmp r1, r2
	bgt _021760EC
	cmp r2, r0
	bgt _021760EC
	mov r3, #1
_021760EC:
	ldr r2, [r6, #0x1c]
	mov r0, #1
	tst r0, r2
	bne _021760F6
	b _02176222
_021760F6:
	mov r0, r2
	mov r1, #0x10
	orr r0, r1
	str r0, [r6, #0x1c]
	mov r0, r6
	add r0, #0x9c
	ldr r2, _0217622C // =0xFFFFF000
	cmp r3, #0
	str r2, [r0]
	ldr r3, _02176230 // =0x00196225
	beq _0217615E
	ldr r0, _02176234 // =_mt_math_rand
	ldr r2, [r0, #0]
	mul r3, r2
	ldr r2, _02176238 // =0x3C6EF35F
	add r2, r3, r2
	str r2, [r0]
	lsr r0, r2, #0x10
	lsl r0, r0, #0x10
	lsr r2, r0, #0x10
	mov r0, #3
	and r2, r0
	cmp r2, #3
	bhi _021761B0
	add r2, r2, r2
	add r2, pc
	ldrh r2, [r2, #6]
	lsl r2, r2, #0x10
	asr r2, r2, #0x10
	add pc, r2
_02176132: // jump table
	.hword _0217613A - _02176132 - 2 // case 0
	.hword _0217613A - _02176132 - 2 // case 1
	.hword _0217613A - _02176132 - 2 // case 2
	.hword _0217614C - _02176132 - 2 // case 3
_0217613A:
	mov r0, r6
	add r0, #0x9c
	ldr r2, [r0, #0]
	lsl r0, r1, #8
	sub r1, r2, r0
	mov r0, r6
	add r0, #0x9c
	str r1, [r0]
	b _021761B0
_0217614C:
	mov r1, r6
	add r1, #0x9c
	ldr r1, [r1, #0]
	lsl r0, r0, #0xc
	sub r1, r1, r0
	mov r0, r6
	add r0, #0x9c
	str r1, [r0]
	b _021761B0
_0217615E:
	ldr r0, _02176234 // =_mt_math_rand
	ldr r2, [r0, #0]
	mul r3, r2
	ldr r2, _02176238 // =0x3C6EF35F
	add r2, r3, r2
	str r2, [r0]
	lsr r0, r2, #0x10
	lsl r0, r0, #0x10
	lsr r2, r0, #0x10
	mov r0, #3
	and r0, r2
	cmp r0, #3
	bhi _021761B0
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02176184: // jump table
	.hword _0217618C - _02176184 - 2 // case 0
	.hword _0217618C - _02176184 - 2 // case 1
	.hword _0217618C - _02176184 - 2 // case 2
	.hword _0217619E - _02176184 - 2 // case 3
_0217618C:
	mov r0, r6
	add r0, #0x9c
	ldr r2, [r0, #0]
	lsl r0, r1, #8
	sub r1, r2, r0
	mov r0, r6
	add r0, #0x9c
	str r1, [r0]
	b _021761B0
_0217619E:
	mov r0, r6
	add r0, #0x9c
	ldr r1, [r0, #0]
	mov r0, #0xa
	lsl r0, r0, #0xa
	sub r1, r1, r0
	mov r0, r6
	add r0, #0x9c
	str r1, [r0]
_021761B0:
	mov r0, #2
	lsl r0, r0, #0xe
	ldr r2, [r6, #0x44]
	add r1, r4, r0
	cmp r2, r1
	bge _021761C6
	lsr r0, r0, #3
	add r6, #0x98
	str r0, [r6]
	pop {r4, r5, r6, r7}
	bx lr
_021761C6:
	sub r1, r5, r0
	cmp r1, r2
	bge _021761D6
	ldr r0, _0217622C // =0xFFFFF000
	add r6, #0x98
	str r0, [r6]
	pop {r4, r5, r6, r7}
	bx lr
_021761D6:
	ldr r2, _02176234 // =_mt_math_rand
	ldr r1, _02176230 // =0x00196225
	ldr r3, [r2, #0]
	mov r4, r3
	mul r4, r1
	ldr r1, _02176238 // =0x3C6EF35F
	add r1, r4, r1
	str r1, [r2]
	lsr r1, r1, #0x10
	lsl r1, r1, #0x10
	lsr r2, r1, #0x10
	mov r1, #3
	and r1, r2
	cmp r1, #3
	bhi _02176222
	add r1, r1, r1
	add r1, pc
	ldrh r1, [r1, #6]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add pc, r1
_02176200: // jump table
	.hword _02176208 - _02176200 - 2 // case 0
	.hword _02176212 - _02176200 - 2 // case 1
	.hword _0217621C - _02176200 - 2 // case 2
	.hword _0217621C - _02176200 - 2 // case 3
_02176208:
	ldr r0, _0217622C // =0xFFFFF000
	add r6, #0x98
	str r0, [r6]
	pop {r4, r5, r6, r7}
	bx lr
_02176212:
	lsr r0, r0, #3
	add r6, #0x98
	str r0, [r6]
	pop {r4, r5, r6, r7}
	bx lr
_0217621C:
	mov r0, #0
	add r6, #0x98
	str r0, [r6]
_02176222:
	pop {r4, r5, r6, r7}
	bx lr
	nop
_02176228: .word gPlayer
_0217622C: .word 0xFFFFF000
_02176230: .word 0x00196225
_02176234: .word _mt_math_rand
_02176238: .word 0x3C6EF35F
	thumb_func_end ovl01_21760A0

	thumb_func_start ovl01_217623C
ovl01_217623C: // _0217623C
	push {r4, lr}
	sub sp, #8
	ldr r4, [r0, #0x1c]
	ldr r3, [r1, #0x1c]
	ldrh r0, [r4, #0]
	cmp r0, #1
	bne _02176284
	ldr r1, [r3, #0x18]
	mov r0, #8
	orr r1, r0
	str r1, [r3, #0x18]
	mov r1, #0x23
	lsl r1, r1, #4
	ldr r2, [r3, r1]
	lsl r0, r0, #8
	orr r0, r2
	str r0, [r3, r1]
	ldr r2, [r3, #0x48]
	ldr r1, [r3, #0x44]
	ldr r3, [r3, #0x4c]
	mov r0, #0
	neg r2, r2
	bl BossFX__CreateBomb
	mov r0, r4
	bl Player__Action_DestroyAttackRecoil
	mov r0, #0
	str r0, [sp]
	mov r1, #0x99
	str r1, [sp, #4]
	sub r1, #0x9a
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02176284:
	add sp, #8
	pop {r4, pc}
	thumb_func_end ovl01_217623C

	thumb_func_start ovl01_2176288
ovl01_2176288: // _02176288
	push {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, _02176428 // =_0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0xdd
	lsl r1, r1, #2
	ldr r1, [r0, r1]
	ldr r0, _0217642C // =0x0000078C
	ldr r0, [r1, r0]
	cmp r0, #1
	beq _021762BE
	cmp r0, #2
	beq _021762BE
	ldr r1, [r4, #0x18]
	mov r0, #8
	orr r0, r1
	str r0, [r4, #0x18]
	ldr r2, [r4, #0x48]
	ldr r1, [r4, #0x44]
	ldr r3, [r4, #0x4c]
	mov r0, #0
	neg r2, r2
	bl BossFX__CreateBomb
	pop {r3, r4, r5, pc}
_021762BE:
	ldr r0, [r4, #0x4c]
	cmp r0, #0
	beq _021762EC
	neg r1, r0
	mov r0, r4
	add r0, #0xb8
	str r1, [r0]
	mov r0, r4
	add r0, #0xb8
	ldr r1, [r0, #0]
	ldr r0, _02176430 // =0xFFFFE000
	cmp r1, r0
	bge _021762DC
	mov r1, r0
	b _021762E6
_021762DC:
	mov r0, #2
	lsl r0, r0, #0xc
	cmp r1, r0
	ble _021762E6
	mov r1, r0
_021762E6:
	mov r0, r4
	add r0, #0xb8
	str r1, [r0]
_021762EC:
	mov r1, #0x4e
	lsl r1, r1, #4
	ldr r0, [r4, r1]
	cmp r0, #0
	beq _021762FC
	cmp r0, #1
	beq _02176322
	pop {r3, r4, r5, pc}
_021762FC:
	mov r0, r4
	add r0, #0x9c
	ldr r0, [r0, #0]
	cmp r0, #0
	bgt _02176308
	b _02176424
_02176308:
	ldr r2, [r4, #0x1c]
	ldr r0, _02176434 // =0xFFFFE0FF
	and r2, r0
	ldr r0, _02176438 // =0xFFFFFDFF
	and r0, r2
	str r0, [r4, #0x1c]
	ldr r2, [r4, #0x18]
	mov r0, #2
	bic r2, r0
	str r2, [r4, #0x18]
	mov r0, #1
	str r0, [r4, r1]
	pop {r3, r4, r5, pc}
_02176322:
	ldr r1, [r4, #0x1c]
	mov r0, #1
	tst r0, r1
	beq _02176424
	mov r0, #0x10
	orr r1, r0
	str r1, [r4, #0x1c]
	ldr r2, _0217643C // =_mt_math_rand
	ldr r1, _02176440 // =0x00196225
	ldr r3, [r2, #0]
	mov r5, r3
	mul r5, r1
	ldr r1, _02176444 // =0x3C6EF35F
	add r1, r5, r1
	str r1, [r2]
	lsr r1, r1, #0x10
	lsl r1, r1, #0x10
	lsr r2, r1, #0x10
	mov r1, #3
	and r2, r1
	cmp r2, #3
	bhi _02176384
	add r2, r2, r2
	add r2, pc
	ldrh r2, [r2, #6]
	lsl r2, r2, #0x10
	asr r2, r2, #0x10
	add pc, r2
_0217635A: // jump table
	.hword _02176362 - _0217635A - 2 // case 0
	.hword _02176362 - _0217635A - 2 // case 1
	.hword _02176362 - _0217635A - 2 // case 2
	.hword _02176374 - _0217635A - 2 // case 3
_02176362:
	mov r1, r4
	add r1, #0x9c
	ldr r1, [r1, #0]
	lsl r0, r0, #9
	sub r1, r1, r0
	mov r0, r4
	add r0, #0x9c
	str r1, [r0]
	b _02176384
_02176374:
	mov r0, r4
	add r0, #0x9c
	ldr r2, [r0, #0]
	lsl r0, r1, #0xc
	sub r1, r2, r0
	mov r0, r4
	add r0, #0x9c
	str r1, [r0]
_02176384:
	ldr r1, _0217643C // =_mt_math_rand
	ldr r0, _02176440 // =0x00196225
	ldr r2, [r1, #0]
	mov r3, r2
	mul r3, r0
	ldr r0, _02176444 // =0x3C6EF35F
	add r0, r3, r0
	str r0, [r1]
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	mov r0, #7
	and r0, r1
	cmp r0, #7
	bhi _02176424
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_021763AE: // jump table
	.hword _021763BE - _021763AE - 2 // case 0
	.hword _021763C6 - _021763AE - 2 // case 1
	.hword _021763CE - _021763AE - 2 // case 2
	.hword _021763D8 - _021763AE - 2 // case 3
	.hword _021763E2 - _021763AE - 2 // case 4
	.hword _021763E2 - _021763AE - 2 // case 5
	.hword _021763EA - _021763AE - 2 // case 6
	.hword _02176408 - _021763AE - 2 // case 7
_021763BE:
	ldr r0, _02176448 // =0xFFFFF000
	add r4, #0x98
	str r0, [r4]
	pop {r3, r4, r5, pc}
_021763C6:
	ldr r0, _02176430 // =0xFFFFE000
	add r4, #0x98
	str r0, [r4]
	pop {r3, r4, r5, pc}
_021763CE:
	mov r0, #1
	lsl r0, r0, #0xc
	add r4, #0x98
	str r0, [r4]
	pop {r3, r4, r5, pc}
_021763D8:
	mov r0, #2
	lsl r0, r0, #0xc
	add r4, #0x98
	str r0, [r4]
	pop {r3, r4, r5, pc}
_021763E2:
	mov r0, #0
	add r4, #0x98
	str r0, [r4]
	pop {r3, r4, r5, pc}
_021763EA:
	ldr r0, _0217644C // =gPlayer
	ldr r1, [r4, #0x44]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x44]
	cmp r1, r0
	bge _02176400
	mov r0, #1
	lsl r0, r0, #0xc
	add r4, #0x98
	str r0, [r4]
	pop {r3, r4, r5, pc}
_02176400:
	ldr r0, _02176448 // =0xFFFFF000
	add r4, #0x98
	str r0, [r4]
	pop {r3, r4, r5, pc}
_02176408:
	ldr r0, _0217644C // =gPlayer
	ldr r1, [r4, #0x44]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x44]
	cmp r1, r0
	bge _0217641E
	mov r0, #2
	lsl r0, r0, #0xc
	add r4, #0x98
	str r0, [r4]
	pop {r3, r4, r5, pc}
_0217641E:
	ldr r0, _02176430 // =0xFFFFE000
	add r4, #0x98
	str r0, [r4]
_02176424:
	pop {r3, r4, r5, pc}
	nop
_02176428: .word _0217AFB8
_0217642C: .word 0x0000078C
_02176430: .word 0xFFFFE000
_02176434: .word 0xFFFFE0FF
_02176438: .word 0xFFFFFDFF
_0217643C: .word _mt_math_rand
_02176440: .word 0x00196225
_02176444: .word 0x3C6EF35F
_02176448: .word 0xFFFFF000
_0217644C: .word gPlayer
	thumb_func_end ovl01_2176288

	thumb_func_start ovl01_2176450
ovl01_2176450: // _02176450
	push {r4, lr}
	mov r4, r0
	bl ovl01_2175A60
	mov r0, r4
	bl GameObject__Destructor
	pop {r4, pc}
	thumb_func_end ovl01_2176450

	thumb_func_start ovl01_2176460
ovl01_2176460: // _02176460
	push {r4, lr}
	sub sp, #8
	ldr r4, [r0, #0x1c]
	ldr r3, [r1, #0x1c]
	ldrh r0, [r4, #0]
	cmp r0, #1
	bne _021764A8
	ldr r1, [r3, #0x18]
	mov r0, #8
	orr r1, r0
	str r1, [r3, #0x18]
	mov r1, #0x23
	lsl r1, r1, #4
	ldr r2, [r3, r1]
	lsl r0, r0, #8
	orr r0, r2
	str r0, [r3, r1]
	ldr r2, [r3, #0x48]
	ldr r1, [r3, #0x44]
	ldr r3, [r3, #0x4c]
	mov r0, #0
	neg r2, r2
	bl BossFX__CreateBomb
	mov r0, r4
	bl Player__Action_DestroyAttackRecoil
	mov r0, #0
	str r0, [sp]
	mov r1, #0x99
	str r1, [sp, #4]
	sub r1, #0x9a
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_021764A8:
	add sp, #8
	pop {r4, pc}
	thumb_func_end ovl01_2176460

	thumb_func_start ovl01_21764AC
ovl01_21764AC: // _021764AC
	push {r4, r5, lr}
	sub sp, #0x14
	mov r5, r0
	ldr r0, _0217651C // =_0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	mov r2, #0x39
	mov r4, r0
	str r3, [sp, #0x10]
	lsl r2, r2, #4
	ldr r2, [r4, r2]
	ldr r0, _02176520 // =0x00000127
	neg r4, r2
	mov r2, #0xf
	lsl r2, r2, #0xe
	mov r1, r5
	add r2, r4, r2
	bl GameObject__SpawnObject
	mov r4, r0
	mov r0, #0x96
	lsl r0, r0, #0xc
	str r0, [r4, #0x4c]
	mov r0, r4
	ldr r1, _02176524 // =0xFFFF9000
	add r0, #0x9c
	str r1, [r0]
	ldr r0, _0217651C // =_0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r2, #0x39
	mov r3, r0
	lsl r2, r2, #4
	ldr r2, [r3, r2]
	mov r0, #0
	neg r3, r2
	mov r2, #0xf
	lsl r2, r2, #0xe
	add r2, r3, r2
	mov r3, #0x96
	mov r1, r5
	neg r2, r2
	lsl r3, r3, #0xc
	bl BossFX__CreateWhaleSplashC
	mov r0, r4
	add sp, #0x14
	pop {r4, r5, pc}
	nop
_0217651C: .word _0217AFB8
_02176520: .word 0x00000127
_02176524: .word 0xFFFF9000
	thumb_func_end ovl01_21764AC

	thumb_func_start ovl01_2176528
ovl01_2176528: // _02176528
	push {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	mov r1, #0xbf
	mov r2, #0
	lsl r1, r1, #2
	str r2, [r0, r1]
	mov r0, r4
	bl GameObject__Destructor
	pop {r4, pc}
	thumb_func_end ovl01_2176528

	thumb_func_start ovl01_2176540
ovl01_2176540: // _02176540
	ldrh r1, [r0, #4]
	mov r0, #0x80
	tst r0, r1
	bne _0217654C
	mov r0, #1
	bx lr
_0217654C:
	ldr r0, _0217655C // =gameState
	ldr r0, [r0, #0x18]
	cmp r0, #0
	bne _02176558
	mov r0, #1
	bx lr
_02176558:
	mov r0, #0
	bx lr
	.align 2, 0
_0217655C: .word gameState
	thumb_func_end ovl01_2176540

	thumb_func_start ovl01_2176560
ovl01_2176560: // _02176560
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r2, r0
	mov r4, r2
	add r4, #0x44
	ldmia r4!, {r0, r1}
	add r3, sp, #0
	stmia r3!, {r0, r1}
	ldr r0, [r4, #0]
	str r0, [r3]
	mov r0, #0xd
	lsl r0, r0, #6
	ldr r0, [r2, r0]
	ldrh r1, [r0, #4]
	mov r0, #3
	and r0, r1
	cmp r0, #3
	bhi _021765C6
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02176590: // jump table
	.hword _02176598 - _02176590 - 2 // case 0
	.hword _021765A4 - _02176590 - 2 // case 1
	.hword _021765B0 - _02176590 - 2 // case 2
	.hword _021765BC - _02176590 - 2 // case 3
_02176598:
	mov r0, #2
	ldr r1, [sp, #4]
	lsl r0, r0, #0xe
	sub r0, r1, r0
	str r0, [sp, #4]
	b _021765C6
_021765A4:
	mov r0, #2
	ldr r1, [sp, #4]
	lsl r0, r0, #0xe
	add r0, r1, r0
	str r0, [sp, #4]
	b _021765C6
_021765B0:
	mov r0, #2
	ldr r1, [sp]
	lsl r0, r0, #0xe
	sub r0, r1, r0
	str r0, [sp]
	b _021765C6
_021765BC:
	mov r0, #2
	ldr r1, [sp]
	lsl r0, r0, #0xe
	add r0, r1, r0
	str r0, [sp]
_021765C6:
	ldr r0, [sp, #4]
	ldr r7, [sp, #8]
	mov r4, #0
	neg r5, r0
_021765CE:
	ldr r1, [sp]
	mov r0, #0
	mov r2, r5
	mov r3, r7
	bl BossFX__CreateBomb
	mov r3, r0
	lsl r0, r4, #0x1d
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	asr r0, r0, #4
	lsl r2, r0, #2
	ldr r0, _02176640 // =FX_SinCosTable_
	add r1, r0, r2
	mov r0, #2
	ldrsh r0, [r1, r0]
	asr r1, r0, #0x1f
	lsr r6, r0, #0x14
	lsl r1, r1, #0xc
	orr r1, r6
	lsl r6, r0, #0xc
	mov r0, #2
	lsl r0, r0, #0xa
	add r6, r6, r0
	ldr r0, _02176644 // =0x00000000
	adc r1, r0
	lsl r0, r1, #0x14
	lsr r1, r6, #0xc
	orr r1, r0
	mov r0, r3
	add r0, #0x98
	str r1, [r0]
	ldr r0, _02176640 // =FX_SinCosTable_
	ldrsh r0, [r0, r2]
	asr r1, r0, #0x1f
	lsr r2, r0, #0x14
	lsl r1, r1, #0xc
	orr r1, r2
	lsl r2, r0, #0xc
	mov r0, #2
	lsl r0, r0, #0xa
	add r0, r2, r0
	ldr r2, _02176644 // =0x00000000
	adc r1, r2
	lsl r1, r1, #0x14
	lsr r0, r0, #0xc
	orr r0, r1
	add r3, #0x9c
	str r0, [r3]
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	cmp r4, #5
	blo _021765CE
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02176640: .word FX_SinCosTable_
_02176644: .word 0x00000000
	thumb_func_end ovl01_2176560

	thumb_func_start ovl01_2176648
ovl01_2176648: // _02176648
	push {r4, r5, r6, lr}
	sub sp, #8
	ldr r6, [r0, #0x1c]
	ldr r5, [r1, #0x1c]
	ldrh r0, [r6, #0]
	cmp r0, #1
	bne _021766C8
	ldr r0, _021766CC // =_0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r1, [r5, #0x18]
	mov r0, #8
	orr r1, r0
	str r1, [r5, #0x18]
	mov r1, #0x23
	lsl r1, r1, #4
	ldr r2, [r5, r1]
	lsl r0, r0, #8
	orr r0, r2
	str r0, [r5, r1]
	ldr r1, [r5, #0x20]
	mov r0, #0x20
	orr r0, r1
	str r0, [r5, #0x20]
	mov r0, #0xd
	lsl r0, r0, #6
	ldr r1, [r5, r0]
	mov r0, #6
	ldrsb r0, [r1, r0]
	mov r1, #1
	bl ovl01_21759C4
	mov r1, #0xdd
	lsl r1, r1, #2
	ldr r2, [r4, r1]
	ldr r0, _021766D0 // =0x0000078C
	ldr r0, [r2, r0]
	cmp r0, #9
	bne _021766A4
	mov r0, r1
	add r0, #0x8e
	ldrh r0, [r4, r0]
	add r1, #0x90
	strh r0, [r4, r1]
_021766A4:
	mov r0, #0
	bl CreateScreenEffect
	mov r0, r5
	bl ovl01_2176560
	mov r0, r6
	bl Player__Action_DestroyAttackRecoil
	mov r0, #0
	str r0, [sp]
	mov r1, #0xd8
	str r1, [sp, #4]
	sub r1, #0xd9
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_021766C8:
	add sp, #8
	pop {r4, r5, r6, pc}
	.align 2, 0
_021766CC: .word _0217AFB8
_021766D0: .word 0x0000078C
	thumb_func_end ovl01_2176648

	thumb_func_start ovl01_21766D4
ovl01_21766D4: // _021766D4
	push {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	mov r1, #0xbf
	mov r2, #0
	lsl r1, r1, #2
	str r2, [r0, r1]
	mov r0, r4
	bl GameObject__Destructor
	pop {r4, pc}
	thumb_func_end ovl01_21766D4

	thumb_func_start ovl01_21766EC
ovl01_21766EC: // _021766EC
	push {r4, lr}
	sub sp, #8
	mov r4, r0
	mov r0, #0x4e
	lsl r0, r0, #4
	ldr r1, [r4, r0]
	cmp r1, #0
	beq _02176716
	mov r1, #1
	lsl r1, r1, #0xc
	sub r0, #0x64
	str r1, [r4, r0]
	ldr r1, [r4, #0x20]
	mov r0, #8
	tst r1, r0
	beq _02176758
	ldr r1, [r4, #0x18]
	add sp, #8
	orr r0, r1
	str r0, [r4, #0x18]
	pop {r4, pc}
_02176716:
	ldr r1, _0217675C // =gPlayer
	add r0, #0xf4
	ldr r1, [r1, #0]
	ldrsh r0, [r1, r0]
	cmp r0, #0x78
	beq _0217673C
	mov r0, #0
	str r0, [sp]
	mov r1, #0xdb
	str r1, [sp, #4]
	sub r1, #0xdc
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, #0x4e
	mov r1, #1
	lsl r0, r0, #4
	str r1, [r4, r0]
_0217673C:
	ldr r0, _0217675C // =gPlayer
	mov r2, r4
	ldr r1, [r0, #0]
	mov r0, #0x1b
	lsl r0, r0, #4
	add r3, r1, r0
	ldmia r3!, {r0, r1}
	add r2, #0x44
	stmia r2!, {r0, r1}
	ldr r0, [r3, #0]
	str r0, [r2]
	ldr r0, [r4, #0x48]
	neg r0, r0
	str r0, [r4, #0x48]
_02176758:
	add sp, #8
	pop {r4, pc}
	.align 2, 0
_0217675C: .word gPlayer
	thumb_func_end ovl01_21766EC

	thumb_func_start Boss5Unknown2176760__Create__Create
Boss5Unknown2176760__Create__Create: // 0x02176760
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r0, #0x1a
	lsl r0, r0, #8
	str r0, [sp]
	mov r0, #4
	str r0, [sp, #4]
	mov r0, #0x5f
	lsl r0, r0, #2
	str r0, [sp, #8]
	mov r2, #0
	ldr r0, _02176804 // =StageTask_Main
	ldr r1, _02176808 // =Boss5Unknown2176760__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r6, r0
	mov r2, #0x5f
	mov r0, #0
	mov r1, r6
	lsl r2, r2, #2
	bl MIi_CpuClear16
	mov r0, r6
	ldr r1, _0217680C // =Boss5Unknown2176760__State_2176810
	add r0, #0xf4
	str r1, [r0]
	mov r1, #0x20
	mov r0, #0x1f
	str r1, [r6, #0x20]
	lsl r0, r0, #8
	str r0, [r6, #0x1c]
	mov r0, #0x12
	str r0, [r6, #0x18]
	mov r0, #0x5a
	lsl r1, r1, #0xe
	lsl r0, r0, #2
	str r1, [r6, r0]
	bl MapSys__GetCameraA
	mov r4, r0
	mov r0, #0
	mov r1, r0
	mov r2, r0
	mov r3, r0
	bl BossFX__CreateWhaleTsunami1
	mov r1, #0x17
	lsl r1, r1, #4
	str r0, [r6, r1]
	mov r0, #0xee
	ldr r2, [r4, #4]
	lsl r0, r0, #0xc
	add r2, r2, r0
	ldr r0, [r6, r1]
	add r5, r6, #4
	str r2, [r0, #0x44]
	ldr r2, [r4, #8]
	ldr r0, [r6, r1]
	mov r4, #1
	str r2, [r0, #0x48]
	ldr r0, [r6, r1]
	mov r2, #0
	str r2, [r0, #0x4c]
	mov r7, r1
_021767E6:
	mov r0, #0
	mov r1, r0
	mov r2, r0
	mov r3, r0
	bl BossFX__CreateWhaleTsunami2
	str r0, [r5, r7]
	add r4, r4, #1
	add r5, r5, #4
	cmp r4, #3
	blt _021767E6
	mov r0, r6
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_02176804: .word StageTask_Main
_02176808: .word Boss5Unknown2176760__Destructor
_0217680C: .word Boss5Unknown2176760__State_2176810
	thumb_func_end Boss5Unknown2176760__Create__Create

	thumb_func_start Boss5Unknown2176760__State_2176810
Boss5Unknown2176760__State_2176810: // 0x02176810
	push {r3, r4, r5, r6, r7, lr}
	str r0, [sp]
	bl MapSys__GetCameraA
	mov r4, r0
	mov r1, #0x17
	ldr r0, [sp]
	lsl r1, r1, #4
	ldr r0, [r0, r1]
	mov r1, #0x42
	ldr r2, [r0, #0x44]
	lsl r1, r1, #0xe
	add r2, r2, r1
	ldr r1, [r4, #4]
	cmp r2, r1
	bge _02176864
	ldr r2, [r0, #0x18]
	mov r1, #8
	orr r1, r2
	str r1, [r0, #0x18]
	ldr r0, [sp]
	mov r3, #1
	add r5, r0, #4
	mov r0, #0x17
	lsl r0, r0, #4
	sub r1, r0, #4
_02176844:
	ldr r2, [r5, r0]
	add r3, r3, #1
	str r2, [r5, r1]
	add r5, r5, #4
	cmp r3, #3
	blt _02176844
	mov r0, #0
	mov r1, r0
	mov r2, r0
	mov r3, r0
	bl BossFX__CreateWhaleTsunami2
	mov r2, #0x5e
	ldr r1, [sp]
	lsl r2, r2, #2
	str r0, [r1, r2]
_02176864:
	bl RenderCore_GetDMARenderCount
	mov r2, #0x17
	ldr r1, [sp]
	lsl r2, r2, #4
	ldr r1, [r1, r2]
	add r2, #0xdc
	ldr r1, [r1, r2]
	ldr r3, _0217693C // =0x00000FFF
	ldr r1, [r1, #8]
	and r0, r3
	ldrh r1, [r1, #4]
	lsl r1, r1, #0xc
	add r1, r1, r3
	asr r1, r1, #0xc
	bl FX_ModS32
	lsl r2, r0, #0xc
	mov r0, #0x17
	ldr r1, [sp]
	lsl r0, r0, #4
	ldr r5, [r1, r0]
	mov r1, #6
	mov r7, #0x3a
	ldr r3, [r5, #0x44]
	lsl r1, r1, #0xc
	sub r1, r3, r1
	str r1, [r5, #0x44]
	mov r3, r0
	ldr r1, [sp]
	sub r3, #8
	ldr r4, [r4, #8]
	ldr r1, [r1, r3]
	mov r6, #1
	add r3, r4, r1
	ldr r1, [sp]
	lsl r7, r7, #0xe
	ldr r0, [r1, r0]
	str r3, [r0, #0x48]
	mov r0, r1
	add r5, r0, #4
_021768B6:
	mov r0, #0x17
	lsl r0, r0, #4
	ldr r4, [r5, r0]
	sub r0, r0, #4
	ldr r3, [r5, r0]
	add r4, #0x44
	add r3, #0x44
	ldmia r3!, {r0, r1}
	stmia r4!, {r0, r1}
	ldr r0, [r3, #0]
	add r6, r6, #1
	str r0, [r4]
	mov r0, #0x17
	lsl r0, r0, #4
	ldr r1, [r5, r0]
	add r5, r5, #4
	ldr r0, [r1, #0x44]
	add r0, r0, r7
	str r0, [r1, #0x44]
	cmp r6, #3
	blt _021768B6
	mov r4, #0x17
	lsl r4, r4, #4
	mov r5, r4
	ldr r1, [sp]
	mov r7, #0
	add r5, #0xdc
_021768EC:
	mov r0, #0
	mov r3, r0
_021768F0:
	ldr r6, [r1, r4]
	add r6, r6, r3
	ldr r6, [r6, r5]
	cmp r6, #0
	beq _021768FC
	str r2, [r6]
_021768FC:
	add r0, r0, #1
	add r3, r3, #4
	cmp r0, #5
	blt _021768F0
	add r7, r7, #1
	add r1, r1, #4
	cmp r7, #3
	blt _021768EC
	mov r0, #0x5b
	ldr r1, [sp]
	lsl r0, r0, #2
	ldr r3, [r1, r0]
	add r2, r3, #1
	str r2, [r1, r0]
	cmp r3, #0x3c
	bls _0217693A
	sub r2, r0, #4
	ldr r2, [r1, r2]
	mov r1, #0x1e
	lsl r1, r1, #0xc
	cmp r2, r1
	ble _0217693A
	ldr r1, [sp]
	sub r2, r0, #4
	ldr r2, [r1, r2]
	mov r1, #2
	lsl r1, r1, #0xa
	sub r2, r2, r1
	sub r1, r0, #4
	ldr r0, [sp]
	str r2, [r0, r1]
_0217693A:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0217693C: .word 0x00000FFF
	thumb_func_end Boss5Unknown2176760__State_2176810

	thumb_func_start Boss5Unknown2176760__Destructor
Boss5Unknown2176760__Destructor: // 0x02176940
	push {r4, r5, r6, lr}
	mov r4, r0
	bl GetTaskWork_
	mov r5, #0x17
	mov r2, #0
	mov r3, #8
	lsl r5, r5, #4
_02176950:
	ldr r1, [r0, r5]
	cmp r1, #0
	beq _0217695C
	ldr r6, [r1, #0x18]
	orr r6, r3
	str r6, [r1, #0x18]
_0217695C:
	add r2, r2, #1
	add r0, r0, #4
	cmp r2, #3
	blt _02176950
	mov r0, r4
	bl StageTask_Destructor
	pop {r4, r5, r6, pc}
	thumb_func_end Boss5Unknown2176760__Destructor

	thumb_func_start ovl01_217696C
ovl01_217696C: // 0x0217696C
	bx lr
	.align 2, 0
	thumb_func_end ovl01_217696C

	thumb_func_start ovl01_2176970
ovl01_2176970: // 0x02176970
	push {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0xd9
	lsl r0, r0, #2
	add r0, r4, r0
	bl BossHelpers__Animation__Func_2038C58
	mov r0, #0xd9
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorMDL__Release
	mov r0, r5
	bl GameObject__Destructor
	pop {r3, r4, r5, pc}
	.align 2, 0
	thumb_func_end ovl01_2176970

	thumb_func_start ovl01_2176998
ovl01_2176998: // 0x02176998
	push {r3, r4, r5, lr}
	ldr r0, _021769E8 // =0x0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl GetCurrentTaskWork_
	mov r5, r0
	bl Camera3D__GetTask
	cmp r0, #0
	beq _021769BA
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _021769C2
_021769BA:
	ldr r1, [r5, #0x20]
	mov r0, #0x20
	orr r0, r1
	str r0, [r5, #0x20]
_021769C2:
	ldr r0, _021769EC // =0x000003C6
	add r0, r4, r0
	bl BossHelpers__Light__SetLights2
	mov r1, #0xd9
	lsl r1, r1, #2
	mov r0, r5
	add r1, r5, r1
	bl StageTask__Draw3D
	ldr r0, _021769EC // =0x000003C6
	add r0, r4, r0
	bl BossHelpers__Light__SetLights1
	ldr r1, [r5, #0x20]
	mov r0, #0x20
	bic r1, r0
	str r1, [r5, #0x20]
	pop {r3, r4, r5, pc}
	.align 2, 0
_021769E8: .word 0x0217AFB8
_021769EC: .word 0x000003C6
	thumb_func_end ovl01_2176998

	thumb_func_start ovl01_21769F0
ovl01_21769F0: // 0x021769F0
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x10
	mov r7, r0
	ldr r0, [r1, #0x1c]
	ldr r4, [r7, #0x1c]
	str r0, [sp, #0xc]
	ldrh r0, [r4, #0]
	str r1, [sp, #8]
	cmp r0, #1
	bne _02176ACA
	ldr r0, _02176AD0 // =0x0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r6, r0
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r5, [r6, r0]
	ldr r0, _02176AD4 // =gPlayer
	ldr r0, [r0, #0]
	bl BossHelpers__Player__LockControl
	mov r0, r4
	bl Player__Action_AttackRecoil
	ldr r0, [sp, #0xc]
	ldr r1, [sp, #8]
	mov r2, #0
	ldrsh r1, [r1, r2]
	mov r2, #6
	ldrsh r2, [r7, r2]
	ldr r0, [r0, #0x44]
	lsl r1, r1, #0xc
	add r1, r0, r1
	ldr r0, [r4, #0x44]
	lsl r2, r2, #0xc
	add r0, r0, r2
	sub r1, r1, r0
	mov r0, r4
	add r0, #0xb0
	str r1, [r0]
	mov r0, r4
	ldr r1, _02176AD8 // =0xFFFFD000
	add r0, #0x98
	str r1, [r0]
	mov r0, r6
	bl ovl01_2175A80
	cmp r0, #2
	bne _02176A58
	mov r1, #0xa
	b _02176A5E
_02176A58:
	lsl r1, r0, #1
	ldr r0, _02176ADC // =0x0217A13C
	ldrsh r1, [r0, r1]
_02176A5E:
	mov r0, #0xe3
	lsl r0, r0, #2
	strh r1, [r6, r0]
	mov r0, #0xe3
	lsl r0, r0, #2
	ldrsh r0, [r6, r0]
	bl UpdateBossHealthHUD
	mov r0, r6
	bl ovl01_2175BB8
	mov r1, r0
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r2, [r5, r0]
	add r0, r0, #4
	ldr r0, [r2, r0]
	bl ovl01_21773FC
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r1, [r5, r0]
	add r0, r0, #4
	ldr r2, [r1, r0]
	mov r0, #0x20
	ldr r1, [r2, #0x20]
	orr r0, r1
	str r0, [r2, #0x20]
	ldr r2, [r4, #0x48]
	ldr r1, [r4, #0x44]
	ldr r3, [r4, #0x4c]
	mov r0, #0
	neg r2, r2
	bl BossFX__CreateHitA
	mov r0, #0
	str r0, [sp]
	mov r1, #0x8c
	str r1, [sp, #4]
	sub r1, #0x8d
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, r5
	bl ovl01_21774F8
	ldr r0, _02176AE0 // =0x0000078C
	ldr r0, [r5, r0]
	cmp r0, #0xa
	beq _02176ACA
	mov r0, r5
	bl ovl01_2177A54
_02176ACA:
	add sp, #0x10
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02176AD0: .word 0x0217AFB8
_02176AD4: .word gPlayer
_02176AD8: .word 0xFFFFD000
_02176ADC: .word 0x0217A13C
_02176AE0: .word 0x0000078C
	thumb_func_end ovl01_21769F0

	thumb_func_start ovl01_2176AE4
ovl01_2176AE4: // 0x02176AE4
	mov r1, #0xdd
	lsl r1, r1, #2
	ldr r1, [r0, r1]
	ldr r0, _02176B20 // =0x0000078C
	ldr r0, [r1, r0]
	cmp r0, #0xc
	bhi _02176B18
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02176AFE: // jump table
	.hword _02176B1C - _02176AFE - 2 // case 0
	.hword _02176B1C - _02176AFE - 2 // case 1
	.hword _02176B1C - _02176AFE - 2 // case 2
	.hword _02176B1C - _02176AFE - 2 // case 3
	.hword _02176B1C - _02176AFE - 2 // case 4
	.hword _02176B18 - _02176AFE - 2 // case 5
	.hword _02176B1C - _02176AFE - 2 // case 6
	.hword _02176B1C - _02176AFE - 2 // case 7
	.hword _02176B18 - _02176AFE - 2 // case 8
	.hword _02176B18 - _02176AFE - 2 // case 9
	.hword _02176B18 - _02176AFE - 2 // case 10
	.hword _02176B1C - _02176AFE - 2 // case 11
	.hword _02176B1C - _02176AFE - 2 // case 12
_02176B18:
	mov r0, #1
	bx lr
_02176B1C:
	mov r0, #0
	bx lr
	.align 2, 0
_02176B20: .word 0x0000078C
	thumb_func_end ovl01_2176AE4

	thumb_func_start ovl01_2176B24
ovl01_2176B24: // 0x02176B24
	push {r3, r4, r5, lr}
	mov r0, #1
	bl BossArena__GetCamera
	mov r5, r0
	bl GetScreenShakeOffsetX
	mov r4, r0
	bl GetScreenShakeOffsetY
	mov r2, r0
	mov r0, r5
	mov r1, r4
	mov r3, #0
	bl BossArena__SetNextPos
	mov r0, #2
	bl BossArena__GetCamera
	mov r5, r0
	bl GetScreenShakeOffsetX
	mov r4, r0
	bl GetScreenShakeOffsetY
	mov r2, r0
	mov r0, r5
	mov r1, r4
	mov r3, #0
	bl BossArena__SetNextPos
	pop {r3, r4, r5, pc}
	thumb_func_end ovl01_2176B24

	thumb_func_start ovl01_2176B64
ovl01_2176B64: // 0x02176B64
	push {r3, r4, r5, lr}
	mov r0, #2
	bl BossArena__GetCamera
	mov r5, r0
	bl MapSys__GetCameraA
	mov r4, r0
	mov r0, r5
	bl BossArena__GetCameraConfig
	ldrh r2, [r0, #0]
	ldr r1, _02176BC0 // =FX_SinCosTable_
	asr r0, r2, #4
	asr r2, r2, #4
	lsl r2, r2, #1
	add r2, r2, #1
	lsl r0, r0, #2
	lsl r2, r2, #1
	ldrsh r0, [r1, r0]
	ldrsh r1, [r1, r2]
	bl FX_Div
	mov r1, r0
	mov r0, #6
	lsl r0, r0, #0x10
	bl FX_Div
	mov r1, r0
	mov r0, r5
	bl BossArena__SetAmplitudeXZTarget
	mov r1, #2
	ldr r2, [r4, #4]
	lsl r1, r1, #0x12
	add r1, r2, r1
	mov r2, #6
	ldr r3, [r4, #8]
	lsl r2, r2, #0x10
	add r2, r3, r2
	mov r0, r5
	neg r2, r2
	mov r3, #0
	bl BossArena__SetTracker1TargetPos
	pop {r3, r4, r5, pc}
	.align 2, 0
_02176BC0: .word FX_SinCosTable_
	thumb_func_end ovl01_2176B64

	thumb_func_start ovl01_2176BC4
ovl01_2176BC4: // 0x02176BC4
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x10
	str r0, [sp]
	mov r0, #2
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	str r0, [sp, #0xc]
	bl MapSys__GetCameraA
	str r0, [sp, #8]
	ldr r0, [r0, #4]
	ldr r1, _02176C40 // =0x0014A000
	bl FX_ModS32
	str r0, [sp, #4]
	ldr r0, [sp, #8]
	ldr r1, _02176C44 // =0x0000014A
	ldr r0, [r0, #4]
	asr r0, r0, #0xc
	bl FX_DivS32
	mov r7, #0x22
	ldr r3, [sp]
	mov r1, r0
	ldr r4, _02176C48 // =0x00000588
	mov r0, r3
	ldr r6, _02176C4C // =0x0217A208
	mov r2, #0
	add r0, r0, r4
	lsl r7, r7, #6
_02176C04:
	add r4, r1, r2
	lsl r4, r4, #0x1c
	lsr r4, r4, #0x1a
	ldr r5, [r6, r4]
	mov r4, #0x5f
	lsl r4, r4, #2
	mul r4, r5
	add r4, r0, r4
	str r4, [r3, r7]
	add r2, r2, #1
	add r3, r3, #4
	cmp r2, #3
	blt _02176C04
	ldr r0, [sp, #8]
	ldr r2, _02176C50 // =0x0000088C
	ldr r1, [r0, #4]
	ldr r0, [sp, #4]
	sub r1, r1, r0
	ldr r0, [sp]
	str r1, [r0, r2]
	ldr r0, [sp, #0xc]
	add r1, r2, #4
	ldr r3, [r0, #0x24]
	ldr r0, [sp]
	add r2, #8
	str r3, [r0, r1]
	mov r1, #0
	str r1, [r0, r2]
	add sp, #0x10
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02176C40: .word 0x0014A000
_02176C44: .word 0x0000014A
_02176C48: .word 0x00000588
_02176C4C: .word 0x0217A208
_02176C50: .word 0x0000088C
	thumb_func_end ovl01_2176BC4

	thumb_func_start ovl01_2176C54
ovl01_2176C54: // 0x02176C54
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x18
	mov r7, r0
	mov r0, #0xfe
	lsl r0, r0, #2
	ldr r1, [r7, r0]
	cmp r1, #0
	bne _02176C66
	b _02176D80
_02176C66:
	add r1, r0, #4
	ldr r1, [r7, r1]
	cmp r1, #0
	beq _02176CA0
	mov r1, #0
	str r1, [sp, #0x10]
	mov r1, r0
	sub r1, #0x14
	add r4, r7, r1
	sub r0, #0x2c
	add r5, r7, r0
	mov r6, r4
_02176C7E:
	mov r0, #1
	str r0, [sp]
	mov r0, r6
	mov r1, r5
	mov r2, r4
	mov r3, #1
	bl Palette__UnknownFunc11
	ldr r0, [sp, #0x10]
	add r4, #8
	add r0, r0, #1
	add r5, #8
	add r6, #8
	str r0, [sp, #0x10]
	cmp r0, #3
	blt _02176C7E
	b _02176CE8
_02176CA0:
	sub r0, #0x14
	mov r1, #0
	add r6, r7, r0
	str r1, [sp, #8]
	mov r4, r7
	mov r5, r6
_02176CAC:
	mov r0, #0xf3
	lsl r0, r0, #2
	ldrh r0, [r4, r0]
	add r1, sp, #0x14
	strh r0, [r1]
	mov r1, #0x1f
	mov r2, r1
	mov r3, r1
	sub r2, #0x2f
	sub r3, #0x2f
	bl ObjDraw__TintColor
	add r1, sp, #0x14
	strh r0, [r1]
	mov r0, #1
	str r0, [sp]
	mov r0, r5
	add r1, sp, #0x14
	mov r2, r6
	mov r3, #1
	bl Palette__UnknownFunc11
	ldr r0, [sp, #8]
	add r4, #8
	add r0, r0, #1
	add r6, #8
	add r5, #8
	str r0, [sp, #8]
	cmp r0, #3
	blt _02176CAC
_02176CE8:
	mov r1, #1
	lsl r1, r1, #0xa
	ldrh r0, [r7, r1]
	cmp r0, #0
	bne _02176D58
	sub r0, r1, #4
	ldr r0, [r7, r0]
	cmp r0, #0
	bne _02176D58
	add r0, r1, #4
	ldrh r0, [r7, r0]
	cmp r0, #0x3c
	bls _02176D28
	mov r2, r1
	mov r0, #0
	add r2, #8
	sub r1, #0x8c
	str r0, [r7, r2]
	ldr r2, [r7, r1]
	ldr r1, _02176DC0 // =0x0000078C
	ldr r1, [r2, r1]
	cmp r1, #9
	bne _02176D58
	str r0, [sp]
	mov r1, #0xd9
	str r1, [sp, #4]
	sub r1, #0xda
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _02176D58
_02176D28:
	mov r0, r1
	add r0, #8
	ldr r0, [r7, r0]
	cmp r0, #0
	bne _02176D58
	mov r0, r1
	mov r2, #1
	add r0, #8
	str r2, [r7, r0]
	sub r1, #0x8c
	ldr r1, [r7, r1]
	ldr r0, _02176DC0 // =0x0000078C
	ldr r0, [r1, r0]
	cmp r0, #9
	bne _02176D58
	mov r0, #0
	str r0, [sp]
	mov r1, #0xdc
	str r1, [sp, #4]
	sub r1, #0xdd
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02176D58:
	mov r0, #1
	lsl r0, r0, #0xa
	ldrh r1, [r7, r0]
	add r1, r1, #1
	strh r1, [r7, r0]
	ldrh r1, [r7, r0]
	cmp r1, #0x1e
	blo _02176DBC
	mov r1, #0
	strh r1, [r7, r0]
	sub r0, r0, #4
	ldr r0, [r7, r0]
	cmp r0, #0
	bne _02176D76
	mov r1, #1
_02176D76:
	mov r0, #0xff
	lsl r0, r0, #2
	add sp, #0x18
	str r1, [r7, r0]
	pop {r3, r4, r5, r6, r7, pc}
_02176D80:
	mov r1, #0
	str r1, [sp, #0xc]
	mov r1, r0
	sub r1, #0x14
	add r4, r7, r1
	sub r0, #0x2c
	add r5, r7, r0
	mov r6, r4
_02176D90:
	mov r0, #1
	str r0, [sp]
	mov r0, r6
	mov r1, r5
	mov r2, r4
	mov r3, #1
	bl Palette__UnknownFunc11
	ldr r0, [sp, #0xc]
	add r4, #8
	add r0, r0, #1
	add r5, #8
	add r6, #8
	str r0, [sp, #0xc]
	cmp r0, #3
	blt _02176D90
	mov r0, #0xff
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r7, r0]
	add r0, r0, #4
	strh r1, [r7, r0]
_02176DBC:
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02176DC0: .word 0x0000078C
	thumb_func_end ovl01_2176C54

	thumb_func_start ovl01_2176DC4
ovl01_2176DC4: // 0x02176DC4
	mov r1, #0xfe
	mov r2, #1
	lsl r1, r1, #2
	str r2, [r0, r1]
	bx lr
	.align 2, 0
	thumb_func_end ovl01_2176DC4

	thumb_func_start ovl01_2176DD0
ovl01_2176DD0: // 0x02176DD0
	mov r1, #0xfe
	mov r2, #0
	lsl r1, r1, #2
	str r2, [r0, r1]
	bx lr
	.align 2, 0
	thumb_func_end ovl01_2176DD0

	thumb_func_start ovl01_2176DDC
ovl01_2176DDC: // 0x02176DDC
	push {r4, lr}
	mov r4, r0
	bl ovl01_2176B24
	mov r0, #0xe1
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _02176DFE
	mov r0, r4
	bl ovl01_2176AE4
	cmp r0, #1
	bne _02176DFE
	mov r0, r4
	bl ovl01_2176B64
_02176DFE:
	mov r0, #0xe5
	lsl r0, r0, #2
	add r0, r4, r0
	bl BossHelpers__Light__Func_203954C
	mov r0, r4
	bl ovl01_2176BC4
	mov r0, r4
	bl ovl01_2176C54
	mov r0, r4
	bl ovl01_21755B0
	mov r1, #0xdf
	lsl r1, r1, #2
	ldr r1, [r4, r1]
	mov r0, r4
	blx r1
	pop {r4, pc}
	.align 2, 0
	thumb_func_end ovl01_2176DDC

	thumb_func_start ovl01_2176E28
ovl01_2176E28: // 0x02176E28
	push {r3, r4, r5, r6, r7, lr}
	str r0, [sp]
	bl GetTaskWork_
	mov r6, r0
	ldr r0, _02176E98 // =0x0000040C
	add r0, r6, r0
	bl BossHelpers__Animation__Func_2038C58
	ldr r0, _02176E98 // =0x0000040C
	add r0, r6, r0
	bl AnimatorMDL__Release
	ldr r0, _02176E9C // =0x00000898
	add r0, r6, r0
	bl BossHelpers__Animation__Func_2038C58
	ldr r0, _02176E9C // =0x00000898
	add r0, r6, r0
	bl AnimatorMDL__Release
	ldr r0, _02176EA0 // =0x00000588
	mov r7, #0x5f
	mov r4, #0
	add r5, r6, r0
	lsl r7, r7, #2
_02176E5C:
	mov r0, r5
	bl BossHelpers__Animation__Func_2038C58
	mov r0, r5
	bl AnimatorMDL__Release
	add r4, r4, #1
	add r5, r5, r7
	cmp r4, #2
	blt _02176E5C
	ldr r0, _02176EA4 // =0x00000A14
	mov r5, #0
	add r4, r6, r0
_02176E76:
	mov r0, r4
	bl ReleasePaletteAnimator
	add r5, r5, #1
	add r4, #0x20
	cmp r5, #8
	blt _02176E76
	mov r0, r6
	bl ovl01_217552C
	ldr r0, _02176EA8 // =0x0217AFB8
	mov r1, #0
	str r1, [r0]
	ldr r0, [sp]
	bl GameObject__Destructor
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02176E98: .word 0x0000040C
_02176E9C: .word 0x00000898
_02176EA0: .word 0x00000588
_02176EA4: .word 0x00000A14
_02176EA8: .word 0x0217AFB8
	thumb_func_end ovl01_2176E28

	thumb_func_start ovl01_2176EAC
ovl01_2176EAC: // 0x02176EAC
	push {r3, r4, r5, r6, r7, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r5, #0
	bl Camera3D__GetTask
	cmp r0, #0
	beq _02176ED4
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _02176EC8
	mov r5, #1
_02176EC8:
	cmp r5, #0
	bne _02176ED4
	ldr r1, [r4, #0x20]
	mov r0, #0x20
	orr r0, r1
	str r0, [r4, #0x20]
_02176ED4:
	mov r0, #0xe5
	lsl r0, r0, #2
	add r0, r4, r0
	bl BossHelpers__Light__SetLights2
	ldr r1, _02177000 // =0x0000040C
	mov r0, r4
	add r1, r4, r1
	bl StageTask__Draw3D
	mov r0, #0xe5
	lsl r0, r0, #2
	add r0, r4, r0
	bl BossHelpers__Light__SetLights1
	ldr r1, [r4, #0x20]
	mov r0, #0x20
	bic r1, r0
	str r1, [r4, #0x20]
	mov r5, #0
	bl Camera3D__GetTask
	cmp r0, #0
	beq _02176F18
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02176F18
	mov r0, r4
	bl ovl01_2176AE4
	cmp r0, #0
	bne _02176F18
	mov r5, #1
_02176F18:
	mov r0, #0xe5
	lsl r0, r0, #2
	add r0, r4, r0
	bl BossHelpers__Light__SetLights2
	mov r0, #2
	ldr r6, _02177004 // =0x00000898
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	mov r3, r0
	add r3, #0x20
	add r2, r4, r6
	ldmia r3!, {r0, r1}
	add r2, #0x48
	stmia r2!, {r0, r1}
	ldr r0, [r3, #0]
	str r0, [r2]
	add r0, r4, r6
	bl AnimatorMDL__ProcessAnimation
	cmp r5, #0
	beq _02176F4E
	add r0, r4, r6
	bl AnimatorMDL__Draw
_02176F4E:
	mov r0, #0xe5
	lsl r0, r0, #2
	add r0, r4, r0
	bl BossHelpers__Light__SetLights1
	mov r0, #0
	str r0, [sp]
	bl Camera3D__GetTask
	cmp r0, #0
	beq _02176F88
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02176F7A
	mov r0, r4
	bl ovl01_2176AE4
	cmp r0, #1
	bne _02176F7A
	mov r0, #1
	str r0, [sp]
_02176F7A:
	ldr r0, [sp]
	cmp r0, #0
	bne _02176F88
	ldr r1, [r4, #0x20]
	mov r0, #0x20
	orr r0, r1
	str r0, [r4, #0x20]
_02176F88:
	ldr r0, _02177008 // =0x000003C6
	add r0, r4, r0
	bl BossHelpers__Light__SetLights2
	mov r7, #0
	mov r6, r4
	mov r5, r7
_02176F96:
	mov r0, #0x22
	lsl r0, r0, #6
	ldr r2, [r6, r0]
	add r0, #0x14
	ldr r3, _0217700C // =0x0000088C
	ldr r1, [r4, r0]
	mov r0, #0x89
	lsl r0, r0, #4
	ldr r3, [r4, r3]
	ldr r0, [r4, r0]
	add r3, r3, r5
	str r3, [r2, #0x48]
	str r0, [r2, #0x4c]
	str r1, [r2, #0x50]
	mov r0, r4
	mov r1, r2
	bl StageTask__Draw3D
	ldr r0, _02177010 // =0x0014A000
	add r7, r7, #1
	add r6, r6, #4
	add r5, r5, r0
	cmp r7, #3
	blt _02176F96
	ldr r0, _02177008 // =0x000003C6
	add r0, r4, r0
	bl BossHelpers__Light__SetLights1
	ldr r0, [sp]
	cmp r0, #0
	beq _02176FDA
	mov r0, r4
	bl ovl01_21756D4
_02176FDA:
	ldr r1, [r4, #0x20]
	mov r0, #0x20
	bic r1, r0
	ldr r0, _02177014 // =0x00000A14
	str r1, [r4, #0x20]
	mov r5, #0
	add r4, r4, r0
_02176FE8:
	mov r0, r4
	bl AnimatePalette
	mov r0, r4
	bl DrawAnimatedPalette
	add r5, r5, #1
	add r4, #0x20
	cmp r5, #8
	blt _02176FE8
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02177000: .word 0x0000040C
_02177004: .word 0x00000898
_02177008: .word 0x000003C6
_0217700C: .word 0x0000088C
_02177010: .word 0x0014A000
_02177014: .word 0x00000A14
	thumb_func_end ovl01_2176EAC

	thumb_func_start ovl01_2177018
ovl01_2177018: // 0x02177018
	push {r4, r5, r6, lr}
	sub sp, #0x20
	mov r4, r0
	mov r6, #0xd9
	mov r0, #4
	lsl r6, r6, #2
	bl BossArena__SetType
	mov r0, #0
	add r1, sp, #0
	mov r2, #0x20
	bl MIi_CpuClear16
	ldr r1, _02177168 // =0x00000E38
	add r0, sp, #0
	strh r1, [r0]
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [sp, #4]
	ldr r0, _0217716C // =0x00001555
	str r0, [sp, #0xc]
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #1
	mov r5, r0
	bl BossArena__SetCameraType
	mov r0, r6
	add r0, #0x10
	ldr r0, [r4, r0]
	bl ovl01_2177BB4
	mov r0, r5
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
	mov r1, #1
	mov r5, r0
	bl BossArena__SetCameraType
	mov r0, r6
	add r0, #0x10
	ldr r0, [r4, r0]
	bl ovl01_2177C98
	mov r0, r5
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
	ldr r2, _02177170 // =0x0400000A
	mov r0, #0x43
	ldrh r1, [r2, #0]
	and r1, r0
	ldr r0, _02177174 // =0x00006004
	orr r0, r1
	strh r0, [r2]
	mov r0, #2
	bl BossArena__SetUnknown2Type
	bl BossArena__GetField4A8
	mov r1, r6
	ldr r2, [r4, r1]
	str r2, [r0, #4]
	mov r2, #1
	strb r2, [r0, #0x14]
	mov r2, #0
	strh r2, [r0, #0x2c]
	strh r2, [r0, #0x2e]
	ldr r0, [r4, r1]
	bl GetBackgroundPixels
	ldr r2, _02177178 // =VRAMSystem__VRAM_BG
	mov r1, #0
	ldr r3, [r2, #0]
	mov r2, #1
	lsl r2, r2, #0xe
	add r2, r3, r2
	bl LoadCompressedPixels
	ldr r0, [r4, r6]
	bl GetBackgroundPalette
	ldr r2, _0217717C // =VRAMSystem__VRAM_PALETTE_BG
	mov r1, #0
	ldr r2, [r2, #0]
	bl LoadCompressedPalette
	mov r1, #0xff
	mov r0, #0
	mvn r1, r1
	bl BossArena__Func_2039A94
	mov r0, #1
	lsl r0, r0, #0x1a
	mov r1, #0x1f
	ldr r2, [r0, #0]
	lsl r1, r1, #8
	and r1, r2
	lsr r3, r1, #8
	ldr r2, [r0, #0]
	ldr r1, _02177180 // =0xFFFFE0FF
	and r2, r1
	mov r1, #2
	orr r1, r3
	lsl r1, r1, #8
	orr r1, r2
	str r1, [r0]
	bl Camera3D__Create
	mov r0, r6
	add r0, #0x28
	ldrsh r0, [r4, r0]
	bl UpdateBossHealthHUD
	mov r0, #0
	bl SetHUDActiveScreen
	mov r0, r6
	ldr r1, _02177184 // =ovl01_2177188
	add r0, #0x18
	str r1, [r4, r0]
	mov r0, #0
	bl BossHelpers__Blend__Func_2039488
	mov r0, r6
	mov r1, #1
	add r0, #0x20
	str r1, [r4, r0]
	add sp, #0x20
	pop {r4, r5, r6, pc}
	nop
_02177168: .word 0x00000E38
_0217716C: .word 0x00001555
_02177170: .word 0x0400000A
_02177174: .word 0x00006004
_02177178: .word VRAMSystem__VRAM_BG
_0217717C: .word VRAMSystem__VRAM_PALETTE_BG
_02177180: .word 0xFFFFE0FF
_02177184: .word ovl01_2177188
	thumb_func_end ovl01_2177018

	thumb_func_start ovl01_2177188
ovl01_2177188: // 0x02177188
	push {r4, lr}
	mov r4, r0
	bl TitleCard__GetProgress
	cmp r0, #5
	bne _021771A2
	mov r0, #0xe2
	mov r1, #1
	lsl r0, r0, #2
	str r1, [r4, r0]
	ldr r1, _021771A4 // =ovl01_21771A8
	sub r0, #0xc
	str r1, [r4, r0]
_021771A2:
	pop {r4, pc}
	.align 2, 0
_021771A4: .word ovl01_21771A8
	thumb_func_end ovl01_2177188

	thumb_func_start ovl01_21771A8
ovl01_21771A8: // 0x021771A8
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r6, r0
	mov r0, #0xde
	lsl r0, r0, #2
	sub r1, r0, #4
	ldr r2, [r6, r1]
	ldr r1, _021772B0 // =0x0000078C
	ldr r4, [r6, r0]
	ldr r1, [r2, r1]
	cmp r1, #1
	beq _021771D0
	cmp r1, #2
	beq _021771D0
	mov r1, #0
	mvn r1, r1
	add r0, #0xa
	add sp, #0xc
	strh r1, [r6, r0]
	pop {r4, r5, r6, r7, pc}
_021771D0:
	mov r0, r6
	bl ovl01_2175B48
	str r0, [sp, #8]
	mov r0, #0xe
	lsl r0, r0, #6
	ldrh r2, [r6, r0]
	ldr r1, [sp, #8]
	cmp r2, r1
	bhs _021772AA
	add r1, r0, #2
	ldrsh r1, [r6, r1]
	cmp r1, #0
	blt _021772AA
	add r2, r0, #2
	ldrsh r2, [r6, r2]
	sub r3, r2, #1
	add r2, r0, #2
	strh r3, [r6, r2]
	cmp r1, #0
	bne _021772AA
	ldrh r1, [r6, r0]
	ldr r0, [sp, #8]
	ldr r7, _021772B4 // =0x0000FFFF
	cmp r1, r0
	bhs _02177298
_02177204:
	mov r0, #0
	bl ovl01_21772CC
	ldr r1, [r4, #0x44]
	asr r0, r0, #1
	sub r1, r1, r0
	mov r0, #1
	lsl r0, r0, #0x10
	add r5, r1, r0
	mov r0, #0xde
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	bl ovl01_21772CC
	add r1, r5, r0
	mov r0, #1
	lsl r0, r0, #0x10
	sub r2, r1, r0
	ldr r0, _021772B8 // =_mt_math_rand
	ldr r1, _021772BC // =0x00196225
	ldr r0, [r0, #0]
	mul r1, r0
	ldr r0, _021772C0 // =0x3C6EF35F
	add r1, r1, r0
	ldr r0, _021772B8 // =_mt_math_rand
	str r1, [r0]
	lsr r0, r1, #0x10
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	mov r0, #7
	and r0, r1
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	cmp r7, r1
	bne _02177254
	add r1, r1, #1
	mov r0, #7
	and r0, r1
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
_02177254:
	ldr r0, _021772C4 // =gPlayer
	mov r7, r1
	ldr r0, [r0, #0]
	ldr r3, [r0, #0x44]
	mov r0, #0xa
	lsl r0, r0, #0xe
	sub r0, r3, r0
	mov r3, #0xa
	lsl r3, r3, #0xc
	mul r3, r1
	add r0, r0, r3
	cmp r0, r5
	blt _02177276
	cmp r0, r2
	bgt _02177274
	mov r2, r0
_02177274:
	mov r5, r2
_02177276:
	mov r0, r5
	bl ovl01_21764AC
	ldr r0, _021772C8 // =gameState
	ldr r0, [r0, #0x14]
	cmp r0, #3
	bne _02177298
	ldr r0, _021772C8 // =gameState
	ldr r0, [r0, #0x70]
	cmp r0, #0xf
	bne _02177298
	mov r0, #0xe
	lsl r0, r0, #6
	ldrh r1, [r6, r0]
	ldr r0, [sp, #8]
	cmp r1, r0
	blo _02177204
_02177298:
	mov r0, #0
	str r0, [sp]
	mov r1, #0xd7
	str r1, [sp, #4]
	sub r1, #0xd8
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_021772AA:
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_021772B0: .word 0x0000078C
_021772B4: .word 0x0000FFFF
_021772B8: .word _mt_math_rand
_021772BC: .word 0x00196225
_021772C0: .word 0x3C6EF35F
_021772C4: .word gPlayer
_021772C8: .word gameState
	thumb_func_end ovl01_21771A8

	thumb_func_start ovl01_21772CC
ovl01_21772CC: // 0x021772CC
	lsl r1, r0, #2
	ldr r0, _021772D4 // =0x0217A1F0
	ldr r0, [r0, r1]
	bx lr
	.align 2, 0
_021772D4: .word 0x0217A1F0
	thumb_func_end ovl01_21772CC

	thumb_func_start ovl01_21772D8
ovl01_21772D8: // 0x021772D8
	push {r4, lr}
	mov r4, r0
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	bl ovl01_2176AE4
	cmp r0, #0
	bne _02177360
	mov r0, #0
	bl ovl01_21772CC
	asr r3, r0, #0xc
	ldr r0, _0217736C // =stageCollision
	ldr r2, [r0, #0x1c]
	ldr r1, [r0, #0x24]
	sub r1, r1, r2
	cmp r3, r1
	bge _02177304
	add r1, r2, r3
	str r1, [r0, #0x24]
	pop {r4, pc}
_02177304:
	mov r0, #0xde
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	bl ovl01_21772CC
	ldr r1, _0217736C // =stageCollision
	asr r0, r0, #0xc
	ldr r3, [r1, #0x24]
	ldr r2, [r1, #0x1c]
	sub r2, r3, r2
	cmp r0, r2
	bge _02177322
	sub r2, r3, #1
	str r2, [r1, #0x24]
	b _0217732A
_02177322:
	cmp r0, r2
	ble _0217732A
	add r2, r3, #1
	str r2, [r1, #0x24]
_0217732A:
	ldr r1, _0217736C // =stageCollision
	ldr r3, [r1, #0x24]
	ldr r2, [r1, #0x1c]
	sub r2, r3, r2
	cmp r0, r2
	bge _0217733C
	sub r2, r3, #1
	str r2, [r1, #0x24]
	b _02177344
_0217733C:
	cmp r0, r2
	ble _02177344
	add r2, r3, #1
	str r2, [r1, #0x24]
_02177344:
	ldr r1, _0217736C // =stageCollision
	ldr r3, [r1, #0x24]
	ldr r2, [r1, #0x1c]
	sub r2, r3, r2
	cmp r0, r2
	bge _02177356
	sub r0, r3, #1
	str r0, [r1, #0x24]
	pop {r4, pc}
_02177356:
	cmp r0, r2
	ble _02177368
	add r0, r3, #1
	str r0, [r1, #0x24]
	pop {r4, pc}
_02177360:
	ldr r0, _0217736C // =stageCollision
	ldrh r1, [r0, #0x18]
	lsl r1, r1, #6
	str r1, [r0, #0x24]
_02177368:
	pop {r4, pc}
	nop
_0217736C: .word stageCollision
	thumb_func_end ovl01_21772D8

	thumb_func_start ovl01_2177370
ovl01_2177370: // 0x02177370
	push {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0xdf
	lsl r0, r0, #2
	add r0, r4, r0
	bl BossHelpers__Animation__Func_2038C58
	mov r0, #0xdf
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorMDL__Release
	mov r0, #0xbf
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r4, r0]
	mov r0, r5
	bl GameObject__Destructor
	pop {r3, r4, r5, pc}
	.align 2, 0
	thumb_func_end ovl01_2177370

	thumb_func_start ovl01_21773A0
ovl01_21773A0: // 0x021773A0
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x20]
	mov r0, #0x20
	tst r0, r1
	bne _021773F8
	bl Camera3D__GetTask
	cmp r0, #0
	beq _021773C0
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _021773C8
_021773C0:
	ldr r1, [r4, #0x20]
	mov r0, #0x20
	orr r0, r1
	str r0, [r4, #0x20]
_021773C8:
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r0, #0x20
	add r0, r1, r0
	bl BossHelpers__Light__SetLights2
	mov r1, #0xdf
	lsl r1, r1, #2
	mov r0, r4
	add r1, r4, r1
	bl StageTask__Draw3D
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r0, #0x20
	add r0, r1, r0
	bl BossHelpers__Light__SetLights1
	ldr r1, [r4, #0x20]
	mov r0, #0x20
	bic r1, r0
	str r1, [r4, #0x20]
_021773F8:
	pop {r4, pc}
	.align 2, 0
	thumb_func_end ovl01_21773A0

	thumb_func_start ovl01_21773FC
ovl01_21773FC: // 0x021773FC
	push {r4, r5, r6, lr}
	sub sp, #8
	mov r5, r0
	mov r0, #0xde
	lsl r0, r0, #2
	mov r4, r1
	ldr r1, [r5, r0]
	cmp r1, r4
	beq _0217745C
	str r4, [r5, r0]
	cmp r4, #5
	bne _02177420
	ldr r1, [r5, #0x20]
	mov r0, #0x20
	orr r0, r1
	add sp, #8
	str r0, [r5, #0x20]
	pop {r4, r5, r6, pc}
_02177420:
	add r0, r0, #4
	add r6, r5, r0
	mov r0, r6
	bl BossHelpers__Animation__Func_2038C58
	mov r0, r6
	bl AnimatorMDL__Release
	ldr r0, _02177460 // =0x02133A18
	ldr r2, _02177464 // =0x0217AEF4
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r5
	mov r1, r6
	add r3, r4, #1
	bl ObjAction3dNNModelLoad
	mov r0, #0x4b
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r5, r0]
	ldr r0, _02177468 // =0x000034CC
	str r0, [r6, #0x18]
	str r0, [r6, #0x1c]
	str r0, [r6, #0x20]
	ldr r1, [r5, #0x20]
	mov r0, #0x20
	bic r1, r0
	str r1, [r5, #0x20]
_0217745C:
	add sp, #8
	pop {r4, r5, r6, pc}
	.align 2, 0
_02177460: .word 0x02133A18
_02177464: .word 0x0217AEF4
_02177468: .word 0x000034CC
	thumb_func_end ovl01_21773FC

	thumb_func_start ovl01_217746C
ovl01_217746C: // 0x0217746C
	push {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #0
	bl ovl01_21772CC
	mov r4, r0
	mov r0, #0xde
	lsl r0, r0, #2
	ldr r0, [r5, r0]
	bl ovl01_21772CC
	ldr r2, [r5, #0x44]
	asr r1, r4, #1
	sub r1, r2, r1
	asr r0, r0, #1
	add r0, r1, r0
	pop {r3, r4, r5, pc}
	.align 2, 0
	thumb_func_end ovl01_217746C

	thumb_func_start ovl01_2177490
ovl01_2177490: // 0x02177490
	ldr r1, _02177498 // =0x00000A84
	ldr r0, [r0, r1]
	ldr r0, [r0, #0]
	bx lr
	.align 2, 0
_02177498: .word 0x00000A84
	thumb_func_end ovl01_2177490

	thumb_func_start ovl01_217749C
ovl01_217749C: // 0x0217749C
	push {r3, r4, r5, lr}
	sub sp, #8
	mov r5, r0
	mov r4, r1
	cmp r2, #0
	ldr r1, [r5, #0x20]
	beq _021774B2
	mov r0, #4
	orr r0, r1
	str r0, [r5, #0x20]
	b _021774B8
_021774B2:
	mov r0, #4
	bic r1, r0
	str r1, [r5, #0x20]
_021774B8:
	mov r1, #0
	str r1, [sp]
	mov r0, #0x9a
	lsl r0, r0, #4
	ldr r2, _021774E0 // =0x00000AE8
	str r1, [sp, #4]
	ldr r2, [r5, r2]
	add r0, r5, r0
	mov r3, r4
	bl BossHelpers__Animation__Func_2038BF0
	mov r1, #1
	ldr r0, _021774E4 // =0x00000AB8
	lsl r1, r1, #0xc
	str r1, [r5, r0]
	add r0, #0x64
	str r4, [r5, r0]
	add sp, #8
	pop {r3, r4, r5, pc}
	nop
_021774E0: .word 0x00000AE8
_021774E4: .word 0x00000AB8
	thumb_func_end ovl01_217749C

	thumb_func_start ovl01_21774E8
ovl01_21774E8: // 0x021774E8
	ldr r1, _021774F4 // =0x00000AAC
	ldrh r1, [r0, r1]
	mov r0, #2
	lsl r0, r0, #0xe
	and r0, r1
	bx lr
	.align 2, 0
_021774F4: .word 0x00000AAC
	thumb_func_end ovl01_21774E8

	thumb_func_start ovl01_21774F8
ovl01_21774F8: // 0x021774F8
	push {r4, lr}
	mov r4, r0
	mov r0, #2
	lsl r0, r0, #0xa
	mov r2, #1
	add r0, r4, r0
	mov r1, #0xd
	mov r3, r2
	bl BossHelpers__Palette__Func_2038BAC
	ldr r0, _02177514 // =0x000007FC
	mov r1, #0x78
	strh r1, [r4, r0]
	pop {r4, pc}
	.align 2, 0
_02177514: .word 0x000007FC
	thumb_func_end ovl01_21774F8

	thumb_func_start ovl01_2177518
ovl01_2177518: // 0x02177518
	push {r3, lr}
	ldr r1, _0217753C // =0x000007FC
	ldrh r2, [r0, r1]
	cmp r2, #0
	beq _0217753A
	sub r2, r2, #1
	strh r2, [r0, r1]
	ldrh r2, [r0, r1]
	cmp r2, #0
	bne _0217753A
	add r1, r1, #4
	mov r2, #0
	add r0, r0, r1
	mov r1, #0xd
	mov r3, r2
	bl BossHelpers__Palette__Func_2038BAC
_0217753A:
	pop {r3, pc}
	.align 2, 0
_0217753C: .word 0x000007FC
	thumb_func_end ovl01_2177518

	thumb_func_start ovl01_2177540
ovl01_2177540: // 0x02177540
	mov r2, #0x23
	lsl r2, r2, #4
	add r3, r1, r2
	lsl r2, r0, #6
	ldr r1, [r3, r2]
	mov r0, #4
	bic r1, r0
	str r1, [r3, r2]
	bx lr
	.align 2, 0
	thumb_func_end ovl01_2177540

	thumb_func_start ovl01_2177554
ovl01_2177554: // 0x02177554
	mov r2, #0x23
	lsl r2, r2, #4
	add r3, r1, r2
	lsl r2, r0, #6
	ldr r1, [r3, r2]
	mov r0, #4
	orr r0, r1
	str r0, [r3, r2]
	bx lr
	.align 2, 0
	thumb_func_end ovl01_2177554

	thumb_func_start ovl01_2177568
ovl01_2177568: // 0x02177568
	push {r4, lr}
	ldr r1, _02177580 // =0x00000784
	mov r4, r0
	ldr r1, [r4, r1]
	blx r1
	mov r0, r4
	bl ovl01_2177518
	mov r0, r4
	bl ovl01_2177890
	pop {r4, pc}
	.align 2, 0
_02177580: .word 0x00000784
	thumb_func_end ovl01_2177568

	thumb_func_start ovl01_2177584
ovl01_2177584: // 0x02177584
	push {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	bl GetTaskWork_
	mov r6, r0
	mov r0, #0x9a
	lsl r0, r0, #4
	add r0, r6, r0
	bl BossHelpers__Animation__Func_2038C58
	mov r0, #0x9a
	lsl r0, r0, #4
	add r0, r6, r0
	bl AnimatorMDL__Release
	mov r0, #2
	lsl r0, r0, #0xa
	mov r4, #0
	add r5, r6, r0
_021775AA:
	mov r0, r5
	bl ReleasePaletteAnimator
	add r4, r4, #1
	add r5, #0x20
	cmp r4, #0xd
	blt _021775AA
	mov r0, #0xb2
	lsl r0, r0, #4
	ldr r0, [r6, r0]
	bl FreeSndHandle
	ldr r0, _021775D4 // =0x00000B24
	ldr r0, [r6, r0]
	bl FreeSndHandle
	mov r0, r7
	bl GameObject__Destructor
	pop {r3, r4, r5, r6, r7, pc}
	nop
_021775D4: .word 0x00000B24
	thumb_func_end ovl01_2177584

	thumb_func_start ovl01_21775D8
ovl01_21775D8: // 0x021775D8
	push {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r6, r0
	mov r0, #2
	lsl r0, r0, #0xa
	mov r4, #0
	add r5, r6, r0
_021775E8:
	mov r0, r5
	bl AnimatePalette
	mov r0, r5
	bl DrawAnimatedPalette
	add r4, r4, #1
	add r5, #0x20
	cmp r4, #0xd
	blt _021775E8
	ldr r1, [r6, #0x20]
	mov r0, #0x20
	tst r0, r1
	bne _02177650
	bl Camera3D__GetTask
	cmp r0, #0
	beq _02177614
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _0217761C
_02177614:
	ldr r1, [r6, #0x20]
	mov r0, #0x20
	orr r0, r1
	str r0, [r6, #0x20]
_0217761C:
	mov r1, #0x9a
	lsl r1, r1, #4
	mov r0, r6
	add r1, r6, r1
	bl StageTask__Draw3D
	ldr r1, [r6, #0x20]
	mov r0, #0x20
	tst r0, r1
	bne _02177648
	mov r1, #0x79
	lsl r1, r1, #4
	mov r0, #0x1e
	add r1, r6, r1
	bl BossHelpers__Model__SetMatrixMode
	mov r1, #0x1f
	lsl r1, r1, #6
	mov r0, #0x1d
	add r1, r6, r1
	bl BossHelpers__Model__SetMatrixMode
_02177648:
	ldr r1, [r6, #0x20]
	mov r0, #0x20
	bic r1, r0
	str r1, [r6, #0x20]
_02177650:
	pop {r4, r5, r6, pc}
	.align 2, 0
	thumb_func_end ovl01_21775D8

	thumb_func_start ovl01_2177654
ovl01_2177654: // 0x02177654
	push {r4, r5, r6, lr}
	sub sp, #0x18
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x18]
	mov r0, #0xc
	tst r0, r1
	bne _0217766C
	mov r0, #2
	tst r0, r1
	beq _0217766E
_0217766C:
	b _0217779A
_0217766E:
	mov r0, #0x86
	lsl r0, r0, #2
	add r0, r4, r0
	ldr r2, [r0, #0x18]
	mov r1, #4
	tst r1, r2
	beq _0217768E
	ldr r3, _021777A0 // =0x000007B4
	add r2, r3, #4
	ldr r1, [r4, r3]
	ldr r2, [r4, r2]
	add r3, #8
	ldr r3, [r4, r3]
	neg r2, r2
	bl BossHelpers__Collision__Func_20390AC
_0217768E:
	mov r0, #0x96
	lsl r0, r0, #2
	add r5, r4, r0
	ldr r1, [r5, #0x18]
	mov r0, #4
	tst r0, r1
	beq _02177714
	ldr r0, _021777A4 // =0x000007D8
	add r3, sp, #0xc
	add r6, r4, r0
	ldmia r6!, {r0, r1}
	mov r2, r3
	stmia r3!, {r0, r1}
	ldr r0, [r6, #0]
	mov r1, r2
	str r0, [r3]
	mov r0, r2
	bl VEC_Normalize
	ldr r0, [sp, #0xc]
	mov r2, #0xe6
	asr r1, r0, #0x1f
	lsl r2, r2, #0xc
	mov r3, #0
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	mov r2, #0xe6
	ldr r0, [sp, #0x10]
	str r1, [sp, #0xc]
	asr r1, r0, #0x1f
	lsl r2, r2, #0xc
	bl _ull_mul
	mov r3, #2
	mov r6, #0
	lsl r3, r3, #0xa
	add r2, r0, r3
	adc r1, r6
	lsl r0, r1, #0x14
	lsr r2, r2, #0xc
	orr r2, r0
	mov r1, r3
	str r2, [sp, #0x10]
	str r6, [sp, #0x14]
	sub r1, #0x1c
	mov r0, r5
	ldr r5, [r4, r1]
	ldr r1, [sp, #0xc]
	add r1, r5, r1
	mov r5, r3
	sub r5, #0x18
	ldr r5, [r4, r5]
	sub r3, #0x14
	ldr r3, [r4, r3]
	add r2, r5, r2
	neg r2, r2
	add r3, r3, r6
	bl BossHelpers__Collision__Func_20390AC
_02177714:
	mov r0, #0xa6
	lsl r0, r0, #2
	add r5, r4, r0
	ldr r1, [r5, #0x18]
	mov r0, #4
	tst r0, r1
	beq _0217779A
	ldr r0, _021777A4 // =0x000007D8
	add r3, sp, #0
	add r6, r4, r0
	ldmia r6!, {r0, r1}
	mov r2, r3
	stmia r3!, {r0, r1}
	ldr r0, [r6, #0]
	mov r1, r2
	str r0, [r3]
	mov r0, r2
	bl VEC_Normalize
	ldr r0, [sp]
	mov r2, #0xd2
	asr r1, r0, #0x1f
	lsl r2, r2, #0xc
	mov r3, #0
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	mov r2, #0xd2
	ldr r0, [sp, #4]
	str r1, [sp]
	asr r1, r0, #0x1f
	lsl r2, r2, #0xc
	bl _ull_mul
	mov r3, #2
	mov r6, #0
	lsl r3, r3, #0xa
	add r2, r0, r3
	adc r1, r6
	lsl r0, r1, #0x14
	lsr r2, r2, #0xc
	orr r2, r0
	mov r1, r3
	str r2, [sp, #4]
	str r6, [sp, #8]
	sub r1, #0x1c
	mov r0, r5
	ldr r5, [r4, r1]
	ldr r1, [sp]
	add r1, r5, r1
	mov r5, r3
	sub r5, #0x18
	ldr r5, [r4, r5]
	sub r3, #0x14
	ldr r3, [r4, r3]
	add r2, r5, r2
	neg r2, r2
	add r3, r3, r6
	bl BossHelpers__Collision__Func_20390AC
_0217779A:
	add sp, #0x18
	pop {r4, r5, r6, pc}
	nop
_021777A0: .word 0x000007B4
_021777A4: .word 0x000007D8
	thumb_func_end ovl01_2177654

	thumb_func_start ovl01_21777A8
ovl01_21777A8: // 0x021777A8
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #8
	mov r6, r0
	ldr r5, [r6, #0x1c]
	mov r7, r1
	ldrh r0, [r5, #0]
	ldr r4, [r7, #0x1c]
	cmp r0, #1
	bne _02177846
	ldr r0, _0217784C // =0x0000078C
	ldr r0, [r4, r0]
	cmp r0, #6
	bne _021777F6
	mov r1, #0xdd
	lsl r1, r1, #2
	mov r0, r1
	ldr r2, [r4, r1]
	mov r3, #0
	add r0, #0x18
	strh r3, [r2, r0]
	ldr r0, [r4, r1]
	add r1, #0x18
	ldrsh r0, [r0, r1]
	bl UpdateBossHealthHUD
	mov r0, r4
	bl ovl01_2177B68
	mov r0, #0
	str r0, [sp]
	mov r1, #0xce
	str r1, [sp, #4]
	sub r1, #0xcf
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
_021777F6:
	mov r0, r5
	bl Player__Action_AttackRecoil
	ldr r0, _02177850 // =0x000007B4
	mov r3, #6
	ldr r1, [r4, r0]
	mov r0, #0
	ldrsh r2, [r7, r0]
	ldrsh r3, [r6, r3]
	lsl r2, r2, #0xc
	add r2, r1, r2
	ldr r1, [r5, #0x44]
	lsl r3, r3, #0xc
	add r1, r1, r3
	sub r2, r2, r1
	mov r1, r5
	add r1, #0xb0
	str r2, [r1]
	mov r1, r5
	ldr r2, _02177854 // =0xFFFFD000
	add r1, #0x98
	str r2, [r1]
	ldr r2, [r5, #0x48]
	ldr r1, [r5, #0x44]
	ldr r3, [r5, #0x4c]
	neg r2, r2
	bl BossFX__CreateHitB
	mov r0, r4
	bl ovl01_2177A10
	mov r0, #0
	str r0, [sp]
	mov r1, #0xcf
	str r1, [sp, #4]
	sub r1, #0xd0
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02177846:
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0217784C: .word 0x0000078C
_02177850: .word 0x000007B4
_02177854: .word 0xFFFFD000
	thumb_func_end ovl01_21777A8

	thumb_func_start ovl01_2177858
ovl01_2177858: // 0x02177858
	push {r3, lr}
	ldr r0, [r0, #0x1c]
	ldr r1, [r1, #0x1c]
	ldrh r0, [r0, #0]
	cmp r0, #1
	bne _0217786A
	mov r0, r1
	bl ovl01_2177A88
_0217786A:
	pop {r3, pc}
	thumb_func_end ovl01_2177858

	thumb_func_start ovl01_217786C
ovl01_217786C: // 0x0217786C
	bx lr
	.align 2, 0
	thumb_func_end ovl01_217786C

	thumb_func_start ovl01_2177870
ovl01_2177870: // 0x02177870
	push {r3, r4}
	ldr r2, _0217788C // =0x00000788
	ldr r4, [r0, r2]
	cmp r4, #0
	beq _02177886
	ldr r3, [r4, #0x18]
	mov r1, #8
	orr r1, r3
	str r1, [r4, #0x18]
	mov r1, #0
	str r1, [r0, r2]
_02177886:
	pop {r3, r4}
	bx lr
	nop
_0217788C: .word 0x00000788
	thumb_func_end ovl01_2177870

	thumb_func_start ovl01_2177890
ovl01_2177890: // 0x02177890
	push {r4, lr}
	sub sp, #8
	ldr r2, _021778E4 // =0x00000B28
	mov r4, r0
	ldr r0, [r4, r2]
	cmp r0, #0
	beq _021778DE
	add r0, r2, #4
	ldrh r0, [r4, r0]
	add r1, r0, #1
	add r0, r2, #4
	strh r1, [r4, r0]
	ldrh r0, [r4, r0]
	cmp r0, #0x3c
	bls _021778DE
	mov r0, #0
	str r0, [sp]
	mov r1, #0xd0
	str r1, [sp, #4]
	sub r0, r2, #4
	sub r1, #0xd1
	ldr r0, [r4, r0]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	ldr r0, _021778E8 // =0x00000B24
	mov r1, r4
	ldr r0, [r4, r0]
	add r1, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	ldr r0, _021778EC // =0x00000B2C
	mov r1, #0
	strh r1, [r4, r0]
_021778DE:
	add sp, #8
	pop {r4, pc}
	nop
_021778E4: .word 0x00000B28
_021778E8: .word 0x00000B24
_021778EC: .word 0x00000B2C
	thumb_func_end ovl01_2177890

	thumb_func_start ovl01_21778F0
ovl01_21778F0: // 0x021778F0
	ldr r1, _02177904 // =0x00000B28
	ldr r2, [r0, r1]
	cmp r2, #0
	bne _02177902
	mov r2, #1
	str r2, [r0, r1]
	mov r2, #0x3c
	add r1, r1, #4
	strh r2, [r0, r1]
_02177902:
	bx lr
	.align 2, 0
_02177904: .word 0x00000B28
	thumb_func_end ovl01_21778F0

	thumb_func_start ovl01_2177908
ovl01_2177908: // 0x02177908
	ldr r1, _02177914 // =0x00000B28
	mov r2, #0
	str r2, [r0, r1]
	add r1, r1, #4
	strh r2, [r0, r1]
	bx lr
	.align 2, 0
_02177914: .word 0x00000B28
	thumb_func_end ovl01_2177908

	thumb_func_start ovl01_2177918
ovl01_2177918: // 0x02177918
	ldr r1, _02177928 // =0x0000078C
	mov r2, #0
	str r2, [r0, r1]
	ldr r2, _0217792C // =ovl01_2177BAC
	sub r1, #8
	str r2, [r0, r1]
	bx lr
	nop
_02177928: .word 0x0000078C
_0217792C: .word ovl01_2177BAC
	thumb_func_end ovl01_2177918

	thumb_func_start ovl01_2177930
ovl01_2177930: // 0x02177930
	push {r4, lr}
	mov r1, #0xde
	mov r4, r0
	lsl r1, r1, #2
	mov r0, #0
	add r1, r4, r1
	mov r2, #2
	bl MIi_CpuClear16
	ldr r1, _0217795C // =0x0000078C
	mov r0, #1
	str r0, [r4, r1]
	mov r0, r1
	ldr r2, _02177960 // =ovl01_2177D7C
	sub r0, #8
	str r2, [r4, r0]
	sub r1, #8
	ldr r1, [r4, r1]
	mov r0, r4
	blx r1
	pop {r4, pc}
	nop
_0217795C: .word 0x0000078C
_02177960: .word ovl01_2177D7C
	thumb_func_end ovl01_2177930

	thumb_func_start ovl01_2177964
ovl01_2177964: // 0x02177964
	push {r4, lr}
	mov r1, #0xde
	mov r4, r0
	lsl r1, r1, #2
	mov r0, #0
	add r1, r4, r1
	mov r2, #2
	bl MIi_CpuClear16
	ldr r1, _02177990 // =0x0000078C
	mov r0, #2
	str r0, [r4, r1]
	mov r0, r1
	ldr r2, _02177994 // =ovl01_2177E0C
	sub r0, #8
	str r2, [r4, r0]
	sub r1, #8
	ldr r1, [r4, r1]
	mov r0, r4
	blx r1
	pop {r4, pc}
	nop
_02177990: .word 0x0000078C
_02177994: .word ovl01_2177E0C
	thumb_func_end ovl01_2177964

	thumb_func_start ovl01_2177998
ovl01_2177998: // 0x02177998
	push {r4, lr}
	mov r1, #0xde
	mov r4, r0
	lsl r1, r1, #2
	mov r0, #0
	add r1, r4, r1
	mov r2, #2
	bl MIi_CpuClear16
	ldr r1, _021779C4 // =0x0000078C
	mov r0, #2
	str r0, [r4, r1]
	mov r0, r1
	ldr r2, _021779C8 // =ovl01_2178478
	sub r0, #8
	str r2, [r4, r0]
	sub r1, #8
	ldr r1, [r4, r1]
	mov r0, r4
	blx r1
	pop {r4, pc}
	nop
_021779C4: .word 0x0000078C
_021779C8: .word ovl01_2178478
	thumb_func_end ovl01_2177998

	thumb_func_start ovl01_21779CC
ovl01_21779CC: // 0x021779CC
	push {r3, r4, r5, lr}
	mov r1, #0xde
	mov r4, r0
	lsl r1, r1, #2
	mov r0, #0
	add r1, r4, r1
	mov r2, #4
	bl MIi_CpuClear16
	mov r5, #0
_021779E0:
	mov r0, r5
	mov r1, r4
	bl ovl01_2177540
	add r5, r5, #1
	cmp r5, #3
	blt _021779E0
	ldr r1, _02177A08 // =0x0000078C
	mov r0, #3
	str r0, [r4, r1]
	mov r0, r1
	ldr r2, _02177A0C // =ovl01_21785C0
	sub r0, #8
	str r2, [r4, r0]
	sub r1, #8
	ldr r1, [r4, r1]
	mov r0, r4
	blx r1
	pop {r3, r4, r5, pc}
	nop
_02177A08: .word 0x0000078C
_02177A0C: .word ovl01_21785C0
	thumb_func_end ovl01_21779CC

	thumb_func_start ovl01_2177A10
ovl01_2177A10: // 0x02177A10
	push {r3, r4, r5, lr}
	mov r1, #0xde
	mov r4, r0
	lsl r1, r1, #2
	mov r0, #0
	add r1, r4, r1
	mov r2, #2
	bl MIi_CpuClear16
	mov r5, #0
_02177A24:
	mov r0, r5
	mov r1, r4
	bl ovl01_2177540
	add r5, r5, #1
	cmp r5, #3
	blt _02177A24
	ldr r1, _02177A4C // =0x0000078C
	mov r0, #4
	str r0, [r4, r1]
	mov r0, r1
	ldr r2, _02177A50 // =ovl01_2178684
	sub r0, #8
	str r2, [r4, r0]
	sub r1, #8
	ldr r1, [r4, r1]
	mov r0, r4
	blx r1
	pop {r3, r4, r5, pc}
	nop
_02177A4C: .word 0x0000078C
_02177A50: .word ovl01_2178684
	thumb_func_end ovl01_2177A10

	thumb_func_start ovl01_2177A54
ovl01_2177A54: // 0x02177A54
	push {r4, lr}
	mov r1, #0xde
	mov r4, r0
	lsl r1, r1, #2
	mov r0, #0
	add r1, r4, r1
	mov r2, #2
	bl MIi_CpuClear16
	ldr r1, _02177A80 // =0x0000078C
	mov r0, #5
	str r0, [r4, r1]
	mov r0, r1
	ldr r2, _02177A84 // =ovl01_21787DC
	sub r0, #8
	str r2, [r4, r0]
	sub r1, #8
	ldr r1, [r4, r1]
	mov r0, r4
	blx r1
	pop {r4, pc}
	nop
_02177A80: .word 0x0000078C
_02177A84: .word ovl01_21787DC
	thumb_func_end ovl01_2177A54

	thumb_func_start ovl01_2177A88
ovl01_2177A88: // 0x02177A88
	push {r3, r4, r5, lr}
	mov r1, #0xde
	mov r4, r0
	lsl r1, r1, #2
	mov r0, #0
	add r1, r4, r1
	mov r2, #4
	bl MIi_CpuClear16
	mov r5, #0
_02177A9C:
	mov r0, r5
	mov r1, r4
	bl ovl01_2177540
	add r5, r5, #1
	cmp r5, #3
	blt _02177A9C
	ldr r1, _02177AC4 // =0x0000078C
	mov r0, #7
	str r0, [r4, r1]
	mov r0, r1
	ldr r2, _02177AC8 // =ovl01_2178820
	sub r0, #8
	str r2, [r4, r0]
	sub r1, #8
	ldr r1, [r4, r1]
	mov r0, r4
	blx r1
	pop {r3, r4, r5, pc}
	nop
_02177AC4: .word 0x0000078C
_02177AC8: .word ovl01_2178820
	thumb_func_end ovl01_2177A88

	thumb_func_start ovl01_2177ACC
ovl01_2177ACC: // 0x02177ACC
	push {r4, lr}
	mov r1, #0xde
	mov r4, r0
	lsl r1, r1, #2
	mov r0, #0
	add r1, r4, r1
	mov r2, #8
	bl MIi_CpuClear16
	ldr r1, _02177AF8 // =0x0000078C
	mov r0, #9
	str r0, [r4, r1]
	mov r0, r1
	ldr r2, _02177AFC // =ovl01_2178BF0
	sub r0, #8
	str r2, [r4, r0]
	sub r1, #8
	ldr r1, [r4, r1]
	mov r0, r4
	blx r1
	pop {r4, pc}
	nop
_02177AF8: .word 0x0000078C
_02177AFC: .word ovl01_2178BF0
	thumb_func_end ovl01_2177ACC

	thumb_func_start ovl01_2177B00
ovl01_2177B00: // 0x02177B00
	push {r4, lr}
	mov r1, #0xde
	mov r4, r0
	lsl r1, r1, #2
	mov r0, #0
	add r1, r4, r1
	mov r2, #8
	bl MIi_CpuClear16
	ldr r1, _02177B2C // =0x0000078C
	mov r0, #0xa
	str r0, [r4, r1]
	mov r0, r1
	ldr r2, _02177B30 // =ovl01_2178CD4
	sub r0, #8
	str r2, [r4, r0]
	sub r1, #8
	ldr r1, [r4, r1]
	mov r0, r4
	blx r1
	pop {r4, pc}
	nop
_02177B2C: .word 0x0000078C
_02177B30: .word ovl01_2178CD4
	thumb_func_end ovl01_2177B00

	thumb_func_start ovl01_2177B34
ovl01_2177B34: // 0x02177B34
	push {r4, lr}
	mov r1, #0xde
	mov r4, r0
	lsl r1, r1, #2
	mov r0, #0
	add r1, r4, r1
	mov r2, #4
	bl MIi_CpuClear16
	ldr r1, _02177B60 // =0x0000078C
	mov r0, #6
	str r0, [r4, r1]
	mov r0, r1
	ldr r2, _02177B64 // =ovl01_2179218
	sub r0, #8
	str r2, [r4, r0]
	sub r1, #8
	ldr r1, [r4, r1]
	mov r0, r4
	blx r1
	pop {r4, pc}
	nop
_02177B60: .word 0x0000078C
_02177B64: .word ovl01_2179218
	thumb_func_end ovl01_2177B34

	thumb_func_start ovl01_2177B68
ovl01_2177B68: // 0x02177B68
	push {r3, r4, r5, lr}
	mov r2, #0xde
	mov r4, r0
	lsl r2, r2, #2
	add r1, r4, r2
	mov r0, #0
	add r2, #0x92
	bl MIi_CpuClear16
	mov r5, #0
_02177B7C:
	mov r0, r5
	mov r1, r4
	bl ovl01_2177540
	add r5, r5, #1
	cmp r5, #3
	blt _02177B7C
	ldr r1, _02177BA4 // =0x0000078C
	mov r0, #0xc
	str r0, [r4, r1]
	mov r0, r1
	ldr r2, _02177BA8 // =ovl01_2179584
	sub r0, #8
	str r2, [r4, r0]
	sub r1, #8
	ldr r1, [r4, r1]
	mov r0, r4
	blx r1
	pop {r3, r4, r5, pc}
	nop
_02177BA4: .word 0x0000078C
_02177BA8: .word ovl01_2179584
	thumb_func_end ovl01_2177B68

	thumb_func_start ovl01_2177BAC
ovl01_2177BAC: // 0x02177BAC
	ldr r3, _02177BB0 // =ovl01_2177930
	bx r3
	.align 2, 0
_02177BB0: .word ovl01_2177930
	thumb_func_end ovl01_2177BAC

	thumb_func_start ovl01_2177BB4
ovl01_2177BB4: // 0x02177BB4
	push {r4, r5, lr}
	sub sp, #0x2c
	ldr r3, _02177C80 // =0x0217A170
	mov r4, r0
	ldmia r3!, {r0, r1}
	add r2, sp, #0
	stmia r2!, {r0, r1}
	ldr r0, [r3, #0]
	add r1, sp, #0xc
	str r0, [r2]
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClear16
	ldr r1, _02177C84 // =0x00000E38
	add r0, sp, #0
	strh r1, [r0, #0xc]
	mov r1, #1
	lsl r1, r1, #0xc
	lsl r0, r1, #0xc
	str r0, [sp, #0x14]
	ldr r0, _02177C88 // =0x00001555
	str r1, [sp, #0x10]
	str r0, [sp, #0x18]
	lsr r0, r1, #1
	str r0, [sp, #0x1c]
	mov r0, #1
	bl BossArena__GetCamera
	add r1, sp, #0xc
	mov r5, r0
	bl BossArena__SetCameraConfig
	mov r1, #0
	mov r0, r5
	mov r2, r1
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r0, r0, #4
	ldr r0, [r1, r0]
	bl ovl01_217746C
	mov r4, r0
	ldr r0, _02177C8C // =0x0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r2, #0x39
	mov r3, r0
	lsl r2, r2, #4
	ldr r3, [r3, r2]
	mov r2, #5
	lsl r2, r2, #0x10
	add r2, r3, r2
	mov r0, r5
	mov r1, r4
	mov r3, #0
	bl BossArena__SetTracker1TargetPos
	mov r1, #1
	ldr r2, _02177C90 // =0x00000199
	mov r0, r5
	lsl r1, r1, #0xa
	bl BossArena__SetTracker1Speed
	mov r0, r5
	mov r1, #1
	bl BossArena__SetTracker1UseObj3D
	mov r1, #1
	ldr r2, _02177C90 // =0x00000199
	mov r0, r5
	lsl r1, r1, #0xa
	bl BossArena__SetTracker0Speed
	mov r1, #0xfa
	mov r0, r5
	lsl r1, r1, #0xe
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r5
	mov r1, #0xcc
	bl BossArena__SetAmplitudeXZSpeed
	ldr r1, _02177C94 // =0xFFF9C000
	mov r0, r5
	bl BossArena__SetAmplitudeYTarget
	mov r0, r5
	mov r1, #0xcc
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r5
	add r1, sp, #0
	bl BossArena__SetUpVector
	add sp, #0x2c
	pop {r4, r5, pc}
	.align 2, 0
_02177C80: .word 0x0217A170
_02177C84: .word 0x00000E38
_02177C88: .word 0x00001555
_02177C8C: .word 0x0217AFB8
_02177C90: .word 0x00000199
_02177C94: .word 0xFFF9C000
	thumb_func_end ovl01_2177BB4

	thumb_func_start ovl01_2177C98
ovl01_2177C98: // 0x02177C98
	push {r4, r5, lr}
	sub sp, #0x2c
	ldr r3, _02177D68 // =0x0217A17C
	mov r4, r0
	ldmia r3!, {r0, r1}
	add r2, sp, #0
	stmia r2!, {r0, r1}
	ldr r0, [r3, #0]
	add r1, sp, #0xc
	str r0, [r2]
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClear16
	ldr r1, _02177D6C // =0x00000E38
	add r0, sp, #0
	strh r1, [r0, #0xc]
	mov r1, #1
	lsl r1, r1, #0xc
	lsl r0, r1, #0xc
	str r0, [sp, #0x14]
	ldr r0, _02177D70 // =0x00001555
	str r1, [sp, #0x10]
	str r0, [sp, #0x18]
	lsr r0, r1, #1
	str r0, [sp, #0x1c]
	mov r0, #2
	bl BossArena__GetCamera
	add r1, sp, #0xc
	mov r5, r0
	bl BossArena__SetCameraConfig
	mov r1, #0
	mov r0, r5
	mov r2, r1
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r0, r0, #4
	ldr r0, [r1, r0]
	bl ovl01_217746C
	mov r4, r0
	ldr r0, _02177D74 // =0x0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r2, #0x39
	mov r3, r0
	lsl r2, r2, #4
	ldr r3, [r3, r2]
	mov r2, #0x96
	lsl r2, r2, #0xe
	sub r2, r3, r2
	mov r0, r5
	mov r1, r4
	mov r3, #0
	bl BossArena__SetTracker1TargetPos
	mov r1, #1
	ldr r2, _02177D78 // =0x00000199
	mov r0, r5
	lsl r1, r1, #0xa
	bl BossArena__SetTracker1Speed
	mov r0, r5
	mov r1, #1
	bl BossArena__SetTracker1UseObj3D
	mov r1, #1
	ldr r2, _02177D78 // =0x00000199
	mov r0, r5
	lsl r1, r1, #0xa
	bl BossArena__SetTracker0Speed
	mov r1, #0x4b
	mov r0, r5
	lsl r1, r1, #0xe
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r5
	mov r1, #0xcc
	bl BossArena__SetAmplitudeXZSpeed
	mov r1, #0x32
	mov r0, r5
	lsl r1, r1, #0xc
	bl BossArena__SetAmplitudeYTarget
	mov r0, r5
	mov r1, #0xcc
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r5
	add r1, sp, #0
	bl BossArena__SetUpVector
	add sp, #0x2c
	pop {r4, r5, pc}
	nop
_02177D68: .word 0x0217A17C
_02177D6C: .word 0x00000E38
_02177D70: .word 0x00001555
_02177D74: .word 0x0217AFB8
_02177D78: .word 0x00000199
	thumb_func_end ovl01_2177C98

	thumb_func_start ovl01_2177D7C
ovl01_2177D7C: // 0x02177D7C
	push {r4, lr}
	mov r1, #0
	mov r2, r1
	mov r4, r0
	bl ovl01_217749C
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r3, [r4, r0]
	mov r2, r4
	add r3, #0x44
	ldmia r3!, {r0, r1}
	add r2, #0x44
	stmia r2!, {r0, r1}
	ldr r0, [r3, #0]
	str r0, [r2]
	mov r0, r4
	bl ovl01_2177BB4
	mov r0, r4
	bl ovl01_2177C98
	mov r0, r4
	bl ovl01_217786C
	mov r0, r4
	bl ovl01_21778F0
	ldr r1, _02177DBC // =ovl01_2177DC4
	ldr r0, _02177DC0 // =0x00000784
	str r1, [r4, r0]
	pop {r4, pc}
	.align 2, 0
_02177DBC: .word ovl01_2177DC4
_02177DC0: .word 0x00000784
	thumb_func_end ovl01_2177D7C

	thumb_func_start ovl01_2177DC4
ovl01_2177DC4: // 0x02177DC4
	push {r3, r4, r5, lr}
	mov r4, #0xde
	mov r5, r0
	lsl r4, r4, #2
	bl ovl01_21774E8
	cmp r0, #0
	beq _02177E04
	ldr r0, _02177E08 // =0x00000B1C
	ldr r0, [r5, r0]
	cmp r0, #1
	bne _02177DFE
	bl TitleCard__GetProgress
	cmp r0, #5
	beq _02177DEC
	bl TitleCard__GetProgress
	cmp r0, #0
	bne _02177DF2
_02177DEC:
	ldrh r0, [r5, r4]
	add r0, r0, #1
	strh r0, [r5, r4]
_02177DF2:
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl ovl01_217749C
	pop {r3, r4, r5, pc}
_02177DFE:
	mov r0, r5
	bl ovl01_2177964
_02177E04:
	pop {r3, r4, r5, pc}
	nop
_02177E08: .word 0x00000B1C
	thumb_func_end ovl01_2177DC4

	thumb_func_start ovl01_2177E0C
ovl01_2177E0C: // 0x02177E0C
	push {r3, lr}
	ldr r2, _02177E1C // =ovl01_2177E24
	ldr r1, _02177E20 // =0x00000784
	str r2, [r0, r1]
	ldr r1, [r0, r1]
	blx r1
	pop {r3, pc}
	nop
_02177E1C: .word ovl01_2177E24
_02177E20: .word 0x00000784
	thumb_func_end ovl01_2177E0C

	thumb_func_start ovl01_2177E24
ovl01_2177E24: // 0x02177E24
	push {r4, r5, r6, lr}
	mov r1, #3
	mov r2, #0
	mov r5, r0
	bl ovl01_217749C
	mov r0, #1
	bl BossArena__GetCamera
	mov r4, r0
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r1, [r5, r0]
	add r0, r0, #4
	ldr r0, [r1, r0]
	bl ovl01_217746C
	mov r6, r0
	ldr r0, _02177EA0 // =0x0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r3, #0x19
	lsl r3, r3, #0xe
	add r1, r6, r3
	mov r6, #0x39
	mov r2, r0
	lsl r6, r6, #4
	ldr r6, [r2, r6]
	mov r2, #5
	lsl r2, r2, #0x10
	mov r0, r4
	add r2, r6, r2
	bl BossArena__SetTracker1TargetPos
	mov r1, #0xaf
	mov r0, r4
	lsl r1, r1, #0xe
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r4
	mov r1, #0
	bl BossArena__SetAmplitudeYTarget
	ldr r1, _02177EA4 // =0x0000D555
	mov r0, r4
	bl BossArena__SetAngleTarget
	mov r0, #2
	bl BossArena__GetCamera
	ldr r1, _02177EA4 // =0x0000D555
	bl BossArena__SetAngleTarget
	mov r0, r5
	bl ovl01_21778F0
	ldr r1, _02177EA8 // =ovl01_2177EB0
	ldr r0, _02177EAC // =0x00000784
	str r1, [r5, r0]
	pop {r4, r5, r6, pc}
	nop
_02177EA0: .word 0x0217AFB8
_02177EA4: .word 0x0000D555
_02177EA8: .word ovl01_2177EB0
_02177EAC: .word 0x00000784
	thumb_func_end ovl01_2177E24

	thumb_func_start ovl01_2177EB0
ovl01_2177EB0: // 0x02177EB0
	push {r3, r4, r5, lr}
	mov r4, r0
	bl ovl01_21774E8
	cmp r0, #0
	beq _02177EF2
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r1, _02177EF4 // =0x000007EC
	ldr r3, [r4, r0]
	add r0, #0x1c
	ldr r0, [r3, r0]
	mov r3, r1
	sub r3, #8
	ldr r5, [r4, r3]
	ldr r2, [r4, r1]
	add r3, r1, #4
	str r5, [r4, r3]
	mov r3, r1
	neg r0, r0
	add r3, #8
	str r0, [r4, r3]
	mov r0, r1
	add r0, #0xc
	str r2, [r4, r0]
	mov r0, r1
	ldr r2, _02177EF8 // =ovl01_2177EFC
	sub r0, #0x68
	str r2, [r4, r0]
	sub r1, #0x68
	ldr r1, [r4, r1]
	mov r0, r4
	blx r1
_02177EF2:
	pop {r3, r4, r5, pc}
	.align 2, 0
_02177EF4: .word 0x000007EC
_02177EF8: .word ovl01_2177EFC
	thumb_func_end ovl01_2177EB0

	thumb_func_start ovl01_2177EFC
ovl01_2177EFC: // 0x02177EFC
	push {r4, lr}
	mov r1, #4
	mov r2, #1
	mov r4, r0
	bl ovl01_217749C
	mov r0, #0x7f
	lsl r0, r0, #4
	add r3, r4, r0
	mov r2, r4
	ldmia r3!, {r0, r1}
	add r2, #0x44
	stmia r2!, {r0, r1}
	ldr r0, [r3, #0]
	str r0, [r2]
	mov r0, r4
	bl ovl01_2177870
	mov r0, r4
	bl ovl01_2177908
	mov r0, #0xde
	mov r1, #0
	lsl r0, r0, #2
	strh r1, [r4, r0]
	ldr r1, _02177F38 // =ovl01_2177F40
	ldr r0, _02177F3C // =0x00000784
	str r1, [r4, r0]
	pop {r4, pc}
	nop
_02177F38: .word ovl01_2177F40
_02177F3C: .word 0x00000784
	thumb_func_end ovl01_2177EFC

	thumb_func_start ovl01_2177F40
ovl01_2177F40: // 0x02177F40
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	str r0, [sp, #8]
	mov r0, #0xde
	lsl r0, r0, #2
	ldr r1, [sp, #8]
	sub r2, r0, #4
	ldr r2, [r1, r2]
	mov r1, r0
	add r1, #0x10
	ldr r1, [r2, r1]
	cmp r1, #0
	beq _02177FF0
	ldr r1, [sp, #8]
	ldrh r1, [r1, r0]
	add r2, r1, #1
	ldr r1, [sp, #8]
	strh r2, [r1, r0]
	ldrh r1, [r1, r0]
	cmp r1, #0x78
	bls _02177FF0
	ldr r1, [sp, #8]
	sub r2, r0, #4
	ldr r5, [r1, r2]
	ldr r4, [r5, r0]
	mov r0, #0
	bl ovl01_21772CC
	ldr r1, [r4, #0x44]
	asr r0, r0, #1
	sub r1, r1, r0
	mov r0, #1
	lsl r0, r0, #0x10
	add r6, r1, r0
	mov r0, #0xde
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	bl ovl01_21772CC
	add r1, r6, r0
	mov r0, #1
	lsl r0, r0, #0x10
	sub r7, r1, r0
	mov r1, #0xdd
	ldr r0, [sp, #8]
	lsl r1, r1, #2
	ldr r0, [r0, r1]
	bl ovl01_2175B48
	mov r1, #0xe
	lsl r1, r1, #6
	ldrh r1, [r5, r1]
	sub r0, r0, r1
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	cmp r4, #0
	ble _02177FE8
	sub r0, r7, r6
	add r1, r4, #1
	bl FX_DivS32
	mov r7, r0
	mov r5, #0
	cmp r4, #0
	ble _02177FD6
_02177FC2:
	add r0, r5, #1
	mul r0, r7
	add r0, r6, r0
	bl ovl01_21764AC
	add r0, r5, #1
	lsl r0, r0, #0x10
	asr r5, r0, #0x10
	cmp r5, r4
	blt _02177FC2
_02177FD6:
	mov r0, #0
	str r0, [sp]
	mov r1, #0xd7
	str r1, [sp, #4]
	sub r1, #0xd8
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02177FE8:
	ldr r2, _02177FF4 // =ovl01_2177FFC
	ldr r1, _02177FF8 // =0x00000784
	ldr r0, [sp, #8]
	str r2, [r0, r1]
_02177FF0:
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02177FF4: .word ovl01_2177FFC
_02177FF8: .word 0x00000784
	thumb_func_end ovl01_2177F40

	thumb_func_start ovl01_2177FFC
ovl01_2177FFC: // 0x02177FFC
	push {r4, lr}
	mov r4, r0
	mov r1, #5
	mov r2, #0
	bl ovl01_217749C
	mov r0, r4
	bl ovl01_21778F0
	ldr r1, _02178018 // =ovl01_2178020
	ldr r0, _0217801C // =0x00000784
	str r1, [r4, r0]
	pop {r4, pc}
	nop
_02178018: .word ovl01_2178020
_0217801C: .word 0x00000784
	thumb_func_end ovl01_2177FFC

	thumb_func_start ovl01_2178020
ovl01_2178020: // 0x02178020
	push {r4, r5, r6, r7, lr}
	sub sp, #0x24
	ldr r2, _021781FC // =0x00000B1C
	mov r1, r0
	ldr r1, [r1, r2]
	str r0, [sp]
	cmp r1, #5
	bne _02178048
	bl ovl01_21774E8
	cmp r0, #0
	beq _02178048
	ldr r0, [sp]
	mov r1, #6
	mov r2, #1
	bl ovl01_217749C
	ldr r0, [sp]
	bl ovl01_217786C
_02178048:
	ldr r0, [sp]
	ldr r1, _02178200 // =0xFFFFB000
	add r0, #0x98
	str r1, [r0]
	ldr r0, _02178204 // =stageCollision
	ldr r0, [r0, #0x24]
	lsl r1, r0, #0xc
	ldr r0, _02178208 // =0x000F77C4
	add r1, r1, r0
	ldr r0, [sp]
	ldr r2, [r0, #0x44]
	add r0, #0x98
	ldr r0, [r0, #0]
	sub r0, r2, r0
	cmp r1, r0
	blt _02178078
	ldr r0, [sp]
	sub r2, r1, r2
	add r0, #0x98
	str r2, [r0]
	ldr r3, _0217820C // =ovl01_217822C
	ldr r2, _02178210 // =0x00000784
	ldr r0, [sp]
	str r3, [r0, r2]
_02178078:
	ldr r0, [sp]
	mov r3, #0x7f
	ldr r2, [r0, #0x44]
	add r0, #0x98
	ldr r0, [r0, #0]
	lsl r3, r3, #4
	sub r0, r2, r0
	ldr r2, [sp]
	sub r0, r0, r1
	ldr r2, [r2, r3]
	sub r1, r2, r1
	bl FX_Div
	lsl r0, r0, #0x10
	asr r1, r0, #0x10
	mov r0, #1
	lsl r0, r0, #0xc
	sub r0, r0, r1
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	mov r0, #1
	bl BossArena__GetCamera
	str r0, [sp, #8]
	mov r7, #1
	mov r6, #0
	asr r5, r4, #0x1f
_021780AE:
	mov r0, #0x19
	lsl r0, r0, #0xe
	sub r0, r6, r0
	asr r1, r0, #0x1f
	mov r2, r4
	mov r3, r5
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r2, r0, r2
	ldr r0, _02178214 // =0x00000000
	adc r1, r0
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	mov r0, #0x19
	lsl r0, r0, #0xe
	add r6, r1, r0
	mov r0, r7
	sub r7, r7, #1
	cmp r0, #0
	bne _021780AE
	mov r0, #1
	str r0, [sp, #4]
	mov r7, #0
_021780E2:
	mov r0, #0x19
	lsl r0, r0, #0xe
	sub r0, r7, r0
	asr r1, r0, #0x1f
	mov r2, r4
	mov r3, r5
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r2, r0, r2
	ldr r0, _02178214 // =0x00000000
	adc r1, r0
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	mov r0, #0x19
	lsl r0, r0, #0xe
	add r7, r1, r0
	ldr r1, [sp, #4]
	mov r0, r1
	sub r0, r0, #1
	str r0, [sp, #4]
	cmp r1, #0
	bne _021780E2
	mov r1, #0xdd
	ldr r0, [sp]
	lsl r1, r1, #2
	ldr r2, [r0, r1]
	add r0, r1, #4
	ldr r0, [r2, r0]
	bl ovl01_217746C
	str r0, [sp, #0xc]
	ldr r0, _02178218 // =0x0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r2, _0217821C // =0xFFFE2000
	str r0, [sp, #0x10]
	mov r0, r4
	mov r1, r5
	asr r3, r2, #0x11
	bl _ull_mul
	mov r3, #0x39
	mov ip, r0
	str r1, [sp, #0x18]
	ldr r1, [sp, #0xc]
	ldr r2, [sp, #0x10]
	lsl r3, r3, #4
	ldr r2, [r2, r3]
	mov r3, ip
	str r2, [sp, #0x20]
	mov r2, #2
	lsl r2, r2, #0xa
	add r1, r1, r6
	add r6, r3, r2
	ldr r3, _02178214 // =0x00000000
	ldr r2, [sp, #0x18]
	ldr r0, [sp, #8]
	adc r2, r3
	str r2, [sp, #0x18]
	lsr r3, r6, #0xc
	lsl r2, r2, #0x14
	str r3, [sp, #0x1c]
	orr r3, r2
	str r3, [sp, #0x1c]
	mov r3, #5
	ldr r2, [sp, #0x1c]
	lsl r3, r3, #0x10
	add r3, r2, r3
	ldr r2, [sp, #0x20]
	add r2, r2, r3
	mov r3, r7
	bl BossArena__SetTracker1TargetPos
	ldr r2, _02178220 // =0xFFF38000
	mov r0, r4
	mov r1, r5
	asr r3, r2, #0x14
	bl _ull_mul
	mov r2, #2
	mov r6, r0
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r6, r2
	adc r1, r3
	lsl r1, r1, #0x14
	lsr r2, r2, #0xc
	orr r2, r1
	mov r1, #0xaf
	lsl r1, r1, #0xe
	ldr r0, [sp, #8]
	add r1, r2, r1
	bl BossArena__SetAmplitudeXZTarget
	mov r2, #0x1e
	mov r0, r4
	mov r1, r5
	lsl r2, r2, #0xc
	mov r3, #0
	bl _ull_mul
	mov r2, #2
	mov r5, r0
	mov r3, #0
	lsl r2, r2, #0xa
	add r5, r5, r2
	adc r1, r3
	lsl r2, r1, #0x14
	lsr r1, r5, #0xc
	ldr r0, [sp, #8]
	orr r1, r2
	bl BossArena__SetAmplitudeYTarget
	ldr r0, _02178224 // =0x0000D555
	ldr r1, _02178228 // =0x0000F8E3
	mov r2, r4
	bl Unknown2066510__LerpAngle
	mov r1, r0
	ldr r0, [sp, #8]
	bl BossArena__SetAngleTarget
	mov r0, #2
	bl BossArena__GetCamera
	mov r5, r0
	ldr r0, _02178224 // =0x0000D555
	ldr r1, _02178228 // =0x0000F8E3
	mov r2, r4
	bl Unknown2066510__LerpAngle
	mov r1, r0
	mov r0, r5
	bl BossArena__SetAngleTarget
	add sp, #0x24
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_021781FC: .word 0x00000B1C
_02178200: .word 0xFFFFB000
_02178204: .word stageCollision
_02178208: .word 0x000F77C4
_0217820C: .word ovl01_217822C
_02178210: .word 0x00000784
_02178214: .word 0x00000000
_02178218: .word 0x0217AFB8
_0217821C: .word 0xFFFE2000
_02178220: .word 0xFFF38000
_02178224: .word 0x0000D555
_02178228: .word 0x0000F8E3
	thumb_func_end ovl01_2178020

	thumb_func_start ovl01_217822C
ovl01_217822C: // 0x0217822C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	str r0, [sp, #0xc]
	mov r1, #7
	mov r2, #0
	bl ovl01_217749C
	ldr r1, [sp, #0xc]
	mov r0, #1
	bl ovl01_2177554
	ldr r0, [sp, #0xc]
	mov r1, #0
	add r0, #0x98
	str r1, [r0]
	ldr r0, _02178394 // =0x0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #0x39
	lsl r1, r1, #4
	ldr r4, [r0, r1]
	ldr r1, _02178398 // =0x000007B4
	ldr r0, [sp, #0xc]
	ldr r5, [r0, r1]
	mov r0, #2
	lsl r2, r0, #0x11
	mov r1, r5
	sub r2, r4, r2
	lsl r3, r0, #0xf
	bl BossFX__CreateWhaleBite
	mov r0, #0
	str r0, [sp, #0x10]
	mov r0, #1
	lsl r0, r0, #0x10
	add r7, r5, r0
_02178276:
	ldr r0, _0217839C // =_mt_math_rand
	ldr r1, [r0, #0]
	ldr r0, _021783A0 // =0x00196225
	mov r2, r1
	mul r2, r0
	ldr r0, _021783A4 // =0x3C6EF35F
	add r0, r2, r0
	lsr r1, r0, #0x10
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	lsl r1, r1, #0x1b
	lsr r3, r1, #0xf
	ldr r1, _021783A0 // =0x00196225
	ldr r2, _021783A0 // =0x00196225
	mul r1, r0
	ldr r0, _021783A4 // =0x3C6EF35F
	add r0, r1, r0
	lsr r1, r0, #0x10
	mul r2, r0
	ldr r0, _021783A4 // =0x3C6EF35F
	lsl r1, r1, #0x10
	add r2, r2, r0
	lsr r0, r2, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	lsl r0, r0, #0x1e
	lsr r5, r0, #0x12
	mov r0, #1
	lsl r0, r0, #0xe
	add r6, r5, r0
	ldr r0, _021783A0 // =0x00196225
	lsr r1, r1, #0x10
	mul r0, r2
	ldr r2, _021783A4 // =0x3C6EF35F
	lsl r1, r1, #0x1a
	add r5, r0, r2
	lsr r0, r5, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	lsl r0, r0, #0x1f
	lsr r2, r0, #0x13
	ldr r0, _021783A8 // =0xFFFFE000
	lsr r1, r1, #0xe
	sub r2, r0, r2
	ldr r0, _021783A0 // =0x00196225
	mul r0, r5
	ldr r5, _021783A4 // =0x3C6EF35F
	add r5, r0, r5
	ldr r0, _0217839C // =_mt_math_rand
	str r5, [r0]
	lsr r0, r5, #0x10
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	mov r0, #1
	tst r0, r5
	str r2, [sp]
	beq _021782FA
	str r6, [sp, #4]
	mov r0, #0
	str r0, [sp, #8]
	mov r0, #2
	add r1, r7, r1
	mov r2, r4
	bl BossFX__CreateWhaleIceA
	b _0217830A
_021782FA:
	str r6, [sp, #4]
	mov r0, #0
	str r0, [sp, #8]
	mov r0, #2
	add r1, r7, r1
	mov r2, r4
	bl BossFX__CreateWhaleIceB
_0217830A:
	ldr r1, _0217839C // =_mt_math_rand
	ldr r2, [r1, #0]
	ldr r1, _021783A0 // =0x00196225
	mov r3, r2
	mul r3, r1
	ldr r1, _021783A4 // =0x3C6EF35F
	add r2, r3, r1
	ldr r1, _0217839C // =_mt_math_rand
	mov r3, #0x63
	str r2, [r1]
	lsr r1, r2, #0x10
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	lsl r3, r3, #2
	asr r1, r1, #4
	add r0, r0, r3
	ldr r2, _021783AC // =FX_SinCosTable_
	lsl r1, r1, #2
	ldr r3, _021783AC // =FX_SinCosTable_
	add r2, r2, r1
	ldrsh r1, [r3, r1]
	mov r3, #2
	ldrsh r2, [r2, r3]
	bl MTX_RotZ33_
	ldr r0, [sp, #0x10]
	add r0, r0, #1
	str r0, [sp, #0x10]
	cmp r0, #0x10
	blt _02178276
	ldr r0, [sp, #0xc]
	bl ovl01_2177870
	mov r0, #0
	str r0, [sp]
	mov r1, #0xd1
	mov r2, #0xb2
	str r1, [sp, #4]
	sub r1, #0xd2
	ldr r0, [sp, #0xc]
	lsl r2, r2, #4
	ldr r0, [r0, r2]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	mov r1, #0xb2
	ldr r0, [sp, #0xc]
	lsl r1, r1, #4
	ldr r0, [r0, r1]
	ldr r1, [sp, #0xc]
	add r1, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	ldr r0, [sp, #0xc]
	bl ovl01_2177908
	ldr r2, _021783B0 // =ovl01_21783B8
	ldr r1, _021783B4 // =0x00000784
	ldr r0, [sp, #0xc]
	str r2, [r0, r1]
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02178394: .word 0x0217AFB8
_02178398: .word 0x000007B4
_0217839C: .word _mt_math_rand
_021783A0: .word 0x00196225
_021783A4: .word 0x3C6EF35F
_021783A8: .word 0xFFFFE000
_021783AC: .word FX_SinCosTable_
_021783B0: .word ovl01_21783B8
_021783B4: .word 0x00000784
	thumb_func_end ovl01_217822C

	thumb_func_start ovl01_21783B8
ovl01_21783B8: // 0x021783B8
	push {r4, lr}
	mov r4, r0
	bl ovl01_2177490
	mov r1, #2
	lsl r1, r1, #0xe
	cmp r0, r1
	bne _021783FA
	mov r0, #0
	mov r1, r4
	bl ovl01_2177554
	mov r0, #1
	mov r1, r4
	bl ovl01_2177540
	mov r1, #0xdd
	lsl r1, r1, #2
	ldr r2, [r4, r1]
	add r0, r1, #4
	ldr r0, [r2, r0]
	add r1, r1, #4
	ldr r1, [r0, r1]
	add r1, r1, #1
	bl ovl01_21773FC
	mov r0, #3
	mov r1, #2
	ldr r2, _0217840C // =0x00000199
	lsl r0, r0, #0xe
	lsl r1, r1, #0xc
	bl ShakeScreenEx
_021783FA:
	mov r0, r4
	bl ovl01_21774E8
	cmp r0, #0
	beq _0217840A
	ldr r1, _02178410 // =ovl01_2178418
	ldr r0, _02178414 // =0x00000784
	str r1, [r4, r0]
_0217840A:
	pop {r4, pc}
	.align 2, 0
_0217840C: .word 0x00000199
_02178410: .word ovl01_2178418
_02178414: .word 0x00000784
	thumb_func_end ovl01_21783B8

	thumb_func_start ovl01_2178418
ovl01_2178418: // 0x02178418
	push {r4, lr}
	mov r1, #0xa
	mov r2, #1
	mov r4, r0
	bl ovl01_217749C
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	bl ovl01_2175AA8
	mov r1, #0xde
	lsl r1, r1, #2
	strh r0, [r4, r1]
	ldr r1, _0217843C // =ovl01_2178444
	ldr r0, _02178440 // =0x00000784
	str r1, [r4, r0]
	pop {r4, pc}
	.align 2, 0
_0217843C: .word ovl01_2178444
_02178440: .word 0x00000784
	thumb_func_end ovl01_2178418

	thumb_func_start ovl01_2178444
ovl01_2178444: // 0x02178444
	push {r3, lr}
	mov r2, #0xde
	lsl r2, r2, #2
	ldrh r3, [r0, r2]
	sub r1, r3, #1
	strh r1, [r0, r2]
	cmp r3, #0
	bne _0217846C
	sub r1, r2, #4
	ldr r1, [r0, r1]
	ldr r1, [r1, r2]
	ldr r1, [r1, r2]
	cmp r1, #4
	bne _02178466
	bl ovl01_21779CC
	pop {r3, pc}
_02178466:
	ldr r2, _02178470 // =ovl01_2178478
	ldr r1, _02178474 // =0x00000784
	str r2, [r0, r1]
_0217846C:
	pop {r3, pc}
	nop
_02178470: .word ovl01_2178478
_02178474: .word 0x00000784
	thumb_func_end ovl01_2178444

	thumb_func_start ovl01_2178478
ovl01_2178478: // 0x02178478
	push {r4, lr}
	sub sp, #0x38
	mov r4, r0
	mov r1, #8
	mov r2, #0
	bl ovl01_217749C
	mov r0, #0
	mov r1, r4
	bl ovl01_2177540
	add r0, sp, #8
	bl ovl01_21752C0
	add r0, sp, #8
	str r0, [sp]
	ldr r1, [sp, #0x2c]
	ldr r2, [sp, #0x30]
	ldr r3, [sp, #0x34]
	mov r0, #0
	bl BossFX__CreateWhaleSplashB
	mov r0, #0
	str r0, [sp]
	mov r1, #0xd4
	mov r0, #0xb2
	str r1, [sp, #4]
	sub r1, #0xd5
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	mov r0, #0xb2
	lsl r0, r0, #4
	mov r1, r4
	ldr r0, [r4, r0]
	add r1, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	ldr r1, _021784DC // =ovl01_21784E4
	ldr r0, _021784E0 // =0x00000784
	str r1, [r4, r0]
	add sp, #0x38
	pop {r4, pc}
	.align 2, 0
_021784DC: .word ovl01_21784E4
_021784E0: .word 0x00000784
	thumb_func_end ovl01_2178478

	thumb_func_start ovl01_21784E4
ovl01_21784E4: // 0x021784E4
	push {r4, lr}
	mov r4, r0
	bl ovl01_21774E8
	cmp r0, #0
	beq _021784F6
	ldr r1, _021784F8 // =ovl01_2178500
	ldr r0, _021784FC // =0x00000784
	str r1, [r4, r0]
_021784F6:
	pop {r4, pc}
	.align 2, 0
_021784F8: .word ovl01_2178500
_021784FC: .word 0x00000784
	thumb_func_end ovl01_21784E4

	thumb_func_start ovl01_2178500
ovl01_2178500: // 0x02178500
	push {r4, r5, r6, lr}
	mov r1, #9
	mov r2, #0
	mov r5, r0
	bl ovl01_217749C
	mov r0, #0x7f
	lsl r0, r0, #4
	add r3, r5, r0
	mov r2, r5
	ldmia r3!, {r0, r1}
	add r2, #0x44
	stmia r2!, {r0, r1}
	ldr r0, [r3, #0]
	str r0, [r2]
	mov r0, #1
	bl BossArena__GetCamera
	mov r4, r0
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r1, [r5, r0]
	add r0, r0, #4
	ldr r0, [r1, r0]
	bl ovl01_217746C
	mov r6, r0
	ldr r0, _02178594 // =0x0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r3, #0x19
	lsl r3, r3, #0xe
	add r1, r6, r3
	mov r6, #0x39
	mov r2, r0
	lsl r6, r6, #4
	ldr r6, [r2, r6]
	mov r2, #5
	lsl r2, r2, #0x10
	mov r0, r4
	add r2, r6, r2
	bl BossArena__SetTracker1TargetPos
	mov r1, #0xaf
	mov r0, r4
	lsl r1, r1, #0xe
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r4
	mov r1, #0
	bl BossArena__SetAmplitudeYTarget
	ldr r1, _02178598 // =0x0000D555
	mov r0, r4
	bl BossArena__SetAngleTarget
	mov r0, #2
	bl BossArena__GetCamera
	mov r1, #0xaf
	lsl r1, r1, #0xe
	mov r4, r0
	bl BossArena__SetAmplitudeXZTarget
	ldr r1, _02178598 // =0x0000D555
	mov r0, r4
	bl BossArena__SetAngleTarget
	ldr r1, _0217859C // =ovl01_21785A4
	ldr r0, _021785A0 // =0x00000784
	str r1, [r5, r0]
	pop {r4, r5, r6, pc}
	nop
_02178594: .word 0x0217AFB8
_02178598: .word 0x0000D555
_0217859C: .word ovl01_21785A4
_021785A0: .word 0x00000784
	thumb_func_end ovl01_2178500

	thumb_func_start ovl01_21785A4
ovl01_21785A4: // 0x021785A4
	push {r4, lr}
	mov r4, r0
	bl ovl01_21774E8
	cmp r0, #0
	beq _021785B6
	ldr r1, _021785B8 // =ovl01_2177EFC
	ldr r0, _021785BC // =0x00000784
	str r1, [r4, r0]
_021785B6:
	pop {r4, pc}
	.align 2, 0
_021785B8: .word ovl01_2177EFC
_021785BC: .word 0x00000784
	thumb_func_end ovl01_21785A4

	thumb_func_start ovl01_21785C0
ovl01_21785C0: // 0x021785C0
	push {r4, lr}
	mov r1, #0xe
	mov r2, #0
	mov r4, r0
	bl ovl01_217749C
	ldr r1, _021785D4 // =ovl01_21785DC
	ldr r0, _021785D8 // =0x00000784
	str r1, [r4, r0]
	pop {r4, pc}
	.align 2, 0
_021785D4: .word ovl01_21785DC
_021785D8: .word 0x00000784
	thumb_func_end ovl01_21785C0

	thumb_func_start ovl01_21785DC
ovl01_21785DC: // 0x021785DC
	push {r4, lr}
	mov r4, r0
	bl ovl01_21774E8
	cmp r0, #0
	beq _021785F4
	ldr r0, _021785F8 // =ovl01_2178600
	ldr r1, _021785FC // =0x00000784
	str r0, [r4, r1]
	ldr r1, [r4, r1]
	mov r0, r4
	blx r1
_021785F4:
	pop {r4, pc}
	nop
_021785F8: .word ovl01_2178600
_021785FC: .word 0x00000784
	thumb_func_end ovl01_21785DC

	thumb_func_start ovl01_2178600
ovl01_2178600: // 0x02178600
	push {r4, lr}
	sub sp, #0x38
	mov r1, #0xf
	mov r2, #0
	mov r4, r0
	bl ovl01_217749C
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r0, r0, #4
	ldr r0, [r1, r0]
	mov r1, #5
	bl ovl01_21773FC
	ldr r0, _02178670 // =gPlayer
	ldr r0, [r0, #0]
	bl Player__Action_Die
	add r0, sp, #8
	bl ovl01_21752C0
	ldr r0, _02178674 // =0x0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r3, r0
	add r0, sp, #8
	str r0, [sp]
	mov r2, #0x39
	lsl r2, r2, #4
	ldr r2, [r3, r2]
	ldr r1, [sp, #0x2c]
	neg r3, r2
	mov r2, #0xf
	lsl r2, r2, #0xe
	add r2, r3, r2
	ldr r3, [sp, #0x34]
	mov r0, #0
	neg r2, r2
	bl BossFX__CreateWhaleSplashB
	mov r0, #0
	str r0, [sp]
	mov r1, #0xd6
	str r1, [sp, #4]
	sub r1, #0xd7
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r1, _02178678 // =ovl01_2178680
	ldr r0, _0217867C // =0x00000784
	str r1, [r4, r0]
	add sp, #0x38
	pop {r4, pc}
	.align 2, 0
_02178670: .word gPlayer
_02178674: .word 0x0217AFB8
_02178678: .word ovl01_2178680
_0217867C: .word 0x00000784
	thumb_func_end ovl01_2178600

	thumb_func_start ovl01_2178680
ovl01_2178680: // 0x02178680
	bx lr
	.align 2, 0
	thumb_func_end ovl01_2178680

	thumb_func_start ovl01_2178684
ovl01_2178684: // 0x02178684
	push {r4, lr}
	sub sp, #8
	mov r4, r0
	mov r1, #0xb
	mov r2, #0
	bl ovl01_217749C
	mov r0, r4
	mov r1, #0
	add r0, #0x98
	str r1, [r0]
	mov r0, r4
	add r0, #0x9c
	str r1, [r0]
	mov r0, r4
	add r0, #0xa0
	str r1, [r0]
	str r1, [sp]
	mov r1, #0xd2
	mov r0, #0xb2
	str r1, [sp, #4]
	sub r1, #0xd3
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	mov r0, #0xb2
	lsl r0, r0, #4
	mov r1, r4
	ldr r0, [r4, r0]
	add r1, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	ldr r1, _021786DC // =ovl01_21786E4
	ldr r0, _021786E0 // =0x00000784
	str r1, [r4, r0]
	add sp, #8
	pop {r4, pc}
	.align 2, 0
_021786DC: .word ovl01_21786E4
_021786E0: .word 0x00000784
	thumb_func_end ovl01_2178684

	thumb_func_start ovl01_21786E4
ovl01_21786E4: // 0x021786E4
	push {r4, lr}
	mov r4, r0
	bl ovl01_21774E8
	cmp r0, #0
	beq _021786F6
	ldr r1, _021786F8 // =ovl01_2178700
	ldr r0, _021786FC // =0x00000784
	str r1, [r4, r0]
_021786F6:
	pop {r4, pc}
	.align 2, 0
_021786F8: .word ovl01_2178700
_021786FC: .word 0x00000784
	thumb_func_end ovl01_21786E4

	thumb_func_start ovl01_2178700
ovl01_2178700: // 0x02178700
	push {r4, lr}
	mov r4, r0
	mov r1, #0xc
	mov r2, #1
	bl ovl01_217749C
	mov r0, #2
	mov r1, r4
	bl ovl01_2177554
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	bl ovl01_2175AF4
	mov r1, #0xde
	lsl r1, r1, #2
	strh r0, [r4, r1]
	ldr r1, _0217872C // =ovl01_2178734
	ldr r0, _02178730 // =0x00000784
	str r1, [r4, r0]
	pop {r4, pc}
	.align 2, 0
_0217872C: .word ovl01_2178734
_02178730: .word 0x00000784
	thumb_func_end ovl01_2178700

	thumb_func_start ovl01_2178734
ovl01_2178734: // 0x02178734
	mov r1, #0xde
	lsl r1, r1, #2
	ldrh r3, [r0, r1]
	sub r2, r3, #1
	strh r2, [r0, r1]
	cmp r3, #0
	bne _02178748
	ldr r2, _0217874C // =ovl01_2178754
	ldr r1, _02178750 // =0x00000784
	str r2, [r0, r1]
_02178748:
	bx lr
	nop
_0217874C: .word ovl01_2178754
_02178750: .word 0x00000784
	thumb_func_end ovl01_2178734

	thumb_func_start ovl01_2178754
ovl01_2178754: // 0x02178754
	push {r4, lr}
	sub sp, #8
	mov r4, r0
	mov r1, #0xd
	mov r2, #0
	bl ovl01_217749C
	mov r0, #2
	mov r1, r4
	bl ovl01_2177540
	mov r0, #0
	str r0, [sp]
	mov r1, #0xd3
	mov r0, #0xb2
	str r1, [sp, #4]
	sub r1, #0xd4
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	mov r0, #0xb2
	lsl r0, r0, #4
	mov r1, r4
	ldr r0, [r4, r0]
	add r1, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	ldr r1, _021787A4 // =ovl01_21787AC
	ldr r0, _021787A8 // =0x00000784
	str r1, [r4, r0]
	add sp, #8
	pop {r4, pc}
	nop
_021787A4: .word ovl01_21787AC
_021787A8: .word 0x00000784
	thumb_func_end ovl01_2178754

	thumb_func_start ovl01_21787AC
ovl01_21787AC: // 0x021787AC
	push {r4, lr}
	mov r4, r0
	bl ovl01_21774E8
	cmp r0, #0
	beq _021787D8
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r2, [r4, r0]
	add r1, r0, #4
	ldr r1, [r2, r1]
	add r0, r0, #4
	ldr r0, [r1, r0]
	cmp r0, #4
	bne _021787D2
	mov r0, r4
	bl ovl01_21779CC
	pop {r4, pc}
_021787D2:
	mov r0, r4
	bl ovl01_2177998
_021787D8:
	pop {r4, pc}
	.align 2, 0
	thumb_func_end ovl01_21787AC

	thumb_func_start ovl01_21787DC
ovl01_21787DC: // 0x021787DC
	push {r4, lr}
	mov r1, #0x13
	mov r2, #1
	mov r4, r0
	bl ovl01_217749C
	ldr r1, _021787FC // =playerGameStatus
	mov r0, #1
	ldr r2, [r1, #0]
	bic r2, r0
	str r2, [r1]
	ldr r1, _02178800 // =ovl01_2178808
	ldr r0, _02178804 // =0x00000784
	str r1, [r4, r0]
	pop {r4, pc}
	nop
_021787FC: .word playerGameStatus
_02178800: .word ovl01_2178808
_02178804: .word 0x00000784
	thumb_func_end ovl01_21787DC

	thumb_func_start ovl01_2178808
ovl01_2178808: // 0x02178808
	push {r3, lr}
	mov r1, #0xde
	lsl r1, r1, #2
	ldrh r3, [r0, r1]
	add r2, r3, #1
	strh r2, [r0, r1]
	cmp r3, #0x3c
	bls _0217881C
	bl ovl01_2177B00
_0217881C:
	pop {r3, pc}
	.align 2, 0
	thumb_func_end ovl01_2178808

	thumb_func_start ovl01_2178820
ovl01_2178820: // 0x02178820
	push {r3, r4, r5, lr}
	ldr r1, _02178860 // =playerGameStatus
	mov r4, r0
	ldr r2, [r1, #0]
	mov r0, #1
	bic r2, r0
	ldr r0, _02178864 // =gPlayer
	str r2, [r1]
	ldr r0, [r0, #0]
	bl BossHelpers__Player__LockControl
	mov r0, #1
	bl BossArena__GetCamera
	ldr r1, _02178868 // =0xFFFE2000
	mov r5, r0
	bl BossArena__SetAmplitudeYTarget
	ldr r1, _0217886C // =0x0000D555
	mov r0, r5
	bl BossArena__SetAngleTarget
	mov r0, #2
	bl BossArena__GetCamera
	ldr r1, _0217886C // =0x0000D555
	bl BossArena__SetAngleTarget
	ldr r1, _02178870 // =ovl01_2178878
	ldr r0, _02178874 // =0x00000784
	str r1, [r4, r0]
	pop {r3, r4, r5, pc}
	.align 2, 0
_02178860: .word playerGameStatus
_02178864: .word gPlayer
_02178868: .word 0xFFFE2000
_0217886C: .word 0x0000D555
_02178870: .word ovl01_2178878
_02178874: .word 0x00000784
	thumb_func_end ovl01_2178820

	thumb_func_start ovl01_2178878
ovl01_2178878: // 0x02178878
	ldr r1, _0217888C // =gPlayer
	ldr r1, [r1, #0]
	ldr r2, [r1, #0x1c]
	mov r1, #0x10
	tst r1, r2
	bne _0217888A
	ldr r2, _02178890 // =ovl01_2178898
	ldr r1, _02178894 // =0x00000784
	str r2, [r0, r1]
_0217888A:
	bx lr
	.align 2, 0
_0217888C: .word gPlayer
_02178890: .word ovl01_2178898
_02178894: .word 0x00000784
	thumb_func_end ovl01_2178878

	thumb_func_start ovl01_2178898
ovl01_2178898: // 0x02178898
	mov r1, #0xde
	lsl r1, r1, #2
	add r3, r0, r1
	ldrh r2, [r3, #2]
	add r1, r2, #1
	strh r1, [r3, #2]
	cmp r2, #0x3c
	bls _021788AE
	ldr r2, _021788B0 // =ovl01_21788B8
	ldr r1, _021788B4 // =0x00000784
	str r2, [r0, r1]
_021788AE:
	bx lr
	.align 2, 0
_021788B0: .word ovl01_21788B8
_021788B4: .word 0x00000784
	thumb_func_end ovl01_2178898

	thumb_func_start ovl01_21788B8
ovl01_21788B8: // 0x021788B8
	push {r4, lr}
	mov r4, r0
	mov r0, #0xde
	lsl r0, r0, #2
	add r1, r4, r0
	mov r0, #0x1e
	strh r0, [r1]
	mov r0, #0
	strh r0, [r1, #2]
	bl Camera3D__GetWork
	add r0, #0x20
	mov r1, #0xf
	mov r2, #0
	bl RenderCore_SetBlendBrightness
	bl Camera3D__GetWork
	add r0, #0x7c
	mov r1, #0xf
	mov r2, #0
	bl RenderCore_SetBlendBrightness
	ldr r0, _021788F4 // =ovl01_21788FC
	ldr r1, _021788F8 // =0x00000784
	str r0, [r4, r1]
	ldr r1, [r4, r1]
	mov r0, r4
	blx r1
	pop {r4, pc}
	.align 2, 0
_021788F4: .word ovl01_21788FC
_021788F8: .word 0x00000784
	thumb_func_end ovl01_21788B8

	thumb_func_start ovl01_21788FC
ovl01_21788FC: // 0x021788FC
	push {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	mov r0, #0xde
	lsl r0, r0, #2
	ldrsh r1, [r6, r0]
	add r4, r6, r0
	mov r5, #0
	sub r1, r1, #1
	strh r1, [r4]
	ldrsh r1, [r6, r0]
	mov r0, r5
	sub r0, #0x10
	cmp r1, r0
	bge _0217891E
	sub r5, #0x10
	strh r5, [r4]
	mov r5, #1
_0217891E:
	mov r0, #0
	ldrsh r7, [r4, r0]
	cmp r7, #0
	bge _02178940
	bl Camera3D__GetWork
	add r0, #0x20
	mov r1, r7
	bl RenderCore_ChangeBlendBrightness
	bl Camera3D__GetWork
	mov r1, #0
	ldrsh r1, [r4, r1]
	add r0, #0x7c
	bl RenderCore_ChangeBlendBrightness
_02178940:
	ldr r3, _02178978 // =gPlayer
	mov r2, #0x72
	ldr r0, [r3, #0]
	lsl r2, r2, #4
	ldrh r7, [r0, r2]
	mov r1, #0x13
	orr r1, r7
	strh r1, [r0, r2]
	ldrh r1, [r4, #2]
	add r0, r1, #1
	strh r0, [r4, #2]
	cmp r1, #0
	beq _02178964
	ldr r1, [r3, #0]
	mov r4, #0
	add r0, r2, #2
	strh r4, [r1, r0]
	b _0217896C
_02178964:
	ldr r3, [r3, #0]
	add r0, r2, #2
	ldrh r1, [r3, r2]
	strh r1, [r3, r0]
_0217896C:
	cmp r5, #0
	beq _02178976
	ldr r1, _0217897C // =ovl01_2178984
	ldr r0, _02178980 // =0x00000784
	str r1, [r6, r0]
_02178976:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02178978: .word gPlayer
_0217897C: .word ovl01_2178984
_02178980: .word 0x00000784
	thumb_func_end ovl01_21788FC

	thumb_func_start ovl01_2178984
ovl01_2178984: // 0x02178984
	push {r4, r5, r6, lr}
	sub sp, #0x20
	mov r5, r0
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r6, [r5, r0]
	ldr r0, _02178B1C // =0x0000078C
	mov r1, #8
	str r1, [r5, r0]
	ldr r1, _02178B20 // =playerGameStatus
	mov r0, #1
	ldr r2, [r1, #0]
	orr r0, r2
	str r0, [r1]
	ldr r0, _02178B24 // =gPlayer
	ldr r0, [r0, #0]
	bl BossHelpers__Player__UnlockControl
	ldr r0, _02178B24 // =gPlayer
	mov r1, #5
	ldr r0, [r0, #0]
	ldr r2, _02178B28 // =0x005AA000
	lsl r1, r1, #0x10
	bl BossPlayerHelpers_Action_TryBoss5Warp
	ldr r0, _02178B24 // =gPlayer
	mov r2, #0
	ldr r1, [r0, #0]
	ldr r0, _02178B2C // =0x00000682
	strh r2, [r1, r0]
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #0
	mov r2, r1
	mov r3, r1
	mov r4, r0
	bl BossArena__SetTracker1TargetWork
	mov r1, #0x32
	ldr r2, [r5, #0x44]
	lsl r1, r1, #0xc
	add r1, r2, r1
	mov r2, #0x4b
	ldr r3, [r5, #0x48]
	lsl r2, r2, #0xe
	sub r2, r2, r3
	ldr r3, [r5, #0x4c]
	mov r0, r4
	bl BossArena__SetTracker1TargetPos
	mov r1, #1
	mov r0, r4
	lsl r1, r1, #0xc
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r4
	mov r1, #1
	bl BossArena__SetTracker1UseObj3D
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r1, #0x4b
	mov r0, r4
	lsl r1, r1, #0x10
	bl BossArena__SetAmplitudeXZTarget
	mov r1, #1
	mov r0, r4
	lsl r1, r1, #0xc
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	bl BossArena__ApplyAmplitudeXZTarget
	mov r0, r4
	mov r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r1, #1
	mov r0, r4
	lsl r1, r1, #0xc
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r4
	bl BossArena__ApplyAmplitudeYTarget
	mov r0, r4
	mov r1, #0
	bl BossArena__SetAngleTarget
	mov r1, #1
	mov r0, r4
	lsl r1, r1, #0xc
	bl BossArena__SetAngleSpeed
	mov r0, r4
	bl BossArena__ApplyAngleTarget
	bl BossArena__Func_20397E4
	mov r0, r4
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r4
	bl BossArena__UpdateTracker0TargetPos
	mov r0, #0
	add r1, sp, #0
	mov r2, #0x20
	bl MIi_CpuClear16
	ldr r1, _02178B30 // =0x00000E38
	add r0, sp, #0
	strh r1, [r0]
	mov r1, #1
	lsl r1, r1, #0xc
	lsl r0, r1, #0xb
	str r0, [sp, #8]
	ldr r0, _02178B34 // =0x00001555
	str r1, [sp, #4]
	str r0, [sp, #0xc]
	mov r0, #2
	str r1, [sp, #0x10]
	bl BossArena__GetCamera
	mov r1, #1
	lsl r1, r1, #0xc
	mov r2, #0
	mov r4, r0
	bl BossArena__SetTracker1Speed
	mov r1, #1
	mov r0, r4
	lsl r1, r1, #0xc
	mov r2, #0
	bl BossArena__SetTracker0Speed
	mov r1, #1
	mov r0, r4
	lsl r1, r1, #0xc
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r1, #1
	mov r0, r4
	lsl r1, r1, #0xc
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r4
	mov r1, #0
	bl BossArena__SetAngleTarget
	mov r1, #1
	mov r0, r4
	lsl r1, r1, #0xc
	bl BossArena__SetAngleSpeed
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r1, [r5, r0]
	add r0, r0, #4
	ldr r2, [r1, r0]
	mov r0, #0x20
	ldr r1, [r2, #0x20]
	orr r0, r1
	str r0, [r2, #0x20]
	mov r0, #1
	bl SetHUDActiveScreen
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r0, [r5, r0]
	bl ovl01_2175B24
	ldr r1, _02178B38 // =0x00000402
	strh r0, [r6, r1]
	ldrh r2, [r6, r1]
	add r0, r1, #2
	strh r2, [r6, r0]
	mov r0, r6
	bl ovl01_2175370
	mov r0, r6
	bl ovl01_21755B0
	mov r0, #1
	bl ChangeBossBGMVariant
	mov r1, #0xf
	mov r0, #0xde
	mvn r1, r1
	lsl r0, r0, #2
	strh r1, [r5, r0]
	ldr r1, _02178B3C // =ovl01_2178B44
	ldr r0, _02178B40 // =0x00000784
	str r1, [r5, r0]
	add sp, #0x20
	pop {r4, r5, r6, pc}
	.align 2, 0
_02178B1C: .word 0x0000078C
_02178B20: .word playerGameStatus
_02178B24: .word gPlayer
_02178B28: .word 0x005AA000
_02178B2C: .word 0x00000682
_02178B30: .word 0x00000E38
_02178B34: .word 0x00001555
_02178B38: .word 0x00000402
_02178B3C: .word ovl01_2178B44
_02178B40: .word 0x00000784
	thumb_func_end ovl01_2178984

	thumb_func_start ovl01_2178B44
ovl01_2178B44: // 0x02178B44
	push {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #0xde
	lsl r0, r0, #2
	add r4, r5, r0
	ldrsh r0, [r5, r0]
	cmp r0, #0
	bge _02178B58
	add r0, r0, #1
	strh r0, [r4]
_02178B58:
	bl Camera3D__GetWork
	mov r1, #0
	ldrsh r1, [r4, r1]
	add r0, #0x7c
	bl RenderCore_ChangeBlendBrightness
	mov r0, #0
	ldrsh r0, [r4, r0]
	cmp r0, #0
	bne _02178B74
	ldr r1, _02178B78 // =ovl01_2178B80
	ldr r0, _02178B7C // =0x00000784
	str r1, [r5, r0]
_02178B74:
	pop {r3, r4, r5, pc}
	nop
_02178B78: .word ovl01_2178B80
_02178B7C: .word 0x00000784
	thumb_func_end ovl01_2178B44

	thumb_func_start ovl01_2178B80
ovl01_2178B80: // 0x02178B80
	push {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #0xde
	lsl r0, r0, #2
	add r4, r5, r0
	mov r0, #1
	bl BossHelpers__Blend__Func_2039488
	mov r1, #0
	mov r0, #0xde
	strh r1, [r4, #2]
	sub r1, #0x10
	lsl r0, r0, #2
	strh r1, [r5, r0]
	ldr r1, _02178BA4 // =ovl01_2178BAC
	ldr r0, _02178BA8 // =0x00000784
	str r1, [r5, r0]
	pop {r3, r4, r5, pc}
	.align 2, 0
_02178BA4: .word ovl01_2178BAC
_02178BA8: .word 0x00000784
	thumb_func_end ovl01_2178B80

	thumb_func_start ovl01_2178BAC
ovl01_2178BAC: // 0x02178BAC
	push {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #0xde
	lsl r0, r0, #2
	add r4, r5, r0
	ldrh r1, [r4, #2]
	add r0, r1, #1
	strh r0, [r4, #2]
	cmp r1, #0x1e
	bls _02178BEC
	mov r0, #0
	ldrsh r0, [r4, r0]
	cmp r0, #0
	bge _02178BCC
	add r0, r0, #1
	strh r0, [r4]
_02178BCC:
	bl Camera3D__GetWork
	mov r1, #0
	ldrsh r1, [r4, r1]
	add r0, #0x20
	bl RenderCore_ChangeBlendBrightness
	mov r0, #0
	ldrsh r1, [r4, r0]
	cmp r1, #0
	bne _02178BEC
	bl BossHelpers__Blend__Func_2039488
	mov r0, r5
	bl ovl01_2177ACC
_02178BEC:
	pop {r3, r4, r5, pc}
	.align 2, 0
	thumb_func_end ovl01_2178BAC

	thumb_func_start ovl01_2178BF0
ovl01_2178BF0: // 0x02178BF0
	push {r3, lr}
	ldr r2, _02178C00 // =ovl01_2178C08
	ldr r1, _02178C04 // =0x00000784
	str r2, [r0, r1]
	ldr r1, [r0, r1]
	blx r1
	pop {r3, pc}
	nop
_02178C00: .word ovl01_2178C08
_02178C04: .word 0x00000784
	thumb_func_end ovl01_2178BF0

	thumb_func_start ovl01_2178C08
ovl01_2178C08: // 0x02178C08
	push {r3, r4, r5, lr}
	mov r1, #0xdd
	mov r4, r0
	lsl r1, r1, #2
	mov r0, r1
	ldr r5, [r4, r1]
	add r0, #0x90
	ldrh r0, [r5, r0]
	cmp r0, #0
	beq _02178C28
	mov r0, r1
	add r0, #0x90
	ldrh r0, [r5, r0]
	add r1, #0x90
	sub r0, r0, #1
	strh r0, [r5, r1]
_02178C28:
	ldr r0, _02178CC8 // =0x00000404
	ldrh r1, [r5, r0]
	cmp r1, #0
	bne _02178C42
	mov r0, r4
	mov r1, #0x11
	mov r2, #1
	bl ovl01_217749C
	mov r0, r4
	bl ovl01_2177B00
	pop {r3, r4, r5, pc}
_02178C42:
	mov r0, #0x96
	lsl r0, r0, #2
	cmp r1, r0
	ldr r0, _02178CCC // =0x00000B1C
	bhs _02178CB0
	ldr r0, [r4, r0]
	cmp r0, #0x10
	beq _02178C5C
	mov r0, r4
	mov r1, #0x10
	mov r2, #0
	bl ovl01_217749C
_02178C5C:
	ldr r0, _02178CD0 // =0x00000A84
	ldr r1, _02178CC8 // =0x00000404
	ldr r0, [r4, r0]
	ldrh r1, [r5, r1]
	ldr r0, [r0, #8]
	ldrh r0, [r0, #4]
	lsl r1, r1, #0xc
	lsl r0, r0, #0xc
	bl FX_Div
	mov r2, r0
	ldr r0, _02178CC8 // =0x00000404
	asr r3, r2, #0x1f
	ldrh r1, [r5, r0]
	mov r0, #0x96
	lsl r0, r0, #2
	sub r0, r0, r1
	lsl r0, r0, #0xc
	asr r1, r0, #0x1f
	bl _ull_mul
	mov r3, #2
	mov r2, #0
	lsl r3, r3, #0xa
	add r3, r0, r3
	adc r1, r2
	lsl r0, r1, #0x14
	lsr r3, r3, #0xc
	orr r3, r0
	ldr r0, _02178CD0 // =0x00000A84
_02178C98:
	ldr r1, [r4, r0]
	cmp r1, #0
	beq _02178CA0
	str r3, [r1]
_02178CA0:
	add r2, r2, #1
	add r4, r4, #4
	cmp r2, #5
	blt _02178C98
	mov r0, r5
	bl ovl01_2176DC4
	pop {r3, r4, r5, pc}
_02178CB0:
	ldr r0, [r4, r0]
	cmp r0, #0xc
	beq _02178CC0
	mov r0, r4
	mov r1, #0xc
	mov r2, #1
	bl ovl01_217749C
_02178CC0:
	mov r0, r5
	bl ovl01_2176DD0
	pop {r3, r4, r5, pc}
	.align 2, 0
_02178CC8: .word 0x00000404
_02178CCC: .word 0x00000B1C
_02178CD0: .word 0x00000A84
	thumb_func_end ovl01_2178C08

	thumb_func_start ovl01_2178CD4
ovl01_2178CD4: // 0x02178CD4
	push {r3, r4, r5, lr}
	sub sp, #8
	mov r5, r0
	mov r0, #0xde
	lsl r0, r0, #2
	add r4, r5, r0
	bl Boss5Unknown2176760__Create__Create
	mov r1, #0xde
	lsl r1, r1, #2
	str r0, [r5, r1]
	mov r0, #0
	str r0, [sp]
	mov r1, #0xde
	str r1, [sp, #4]
	sub r1, #0xdf
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, #0
	strh r0, [r4, #6]
	ldr r0, _02178D10 // =ovl01_2178D18
	ldr r1, _02178D14 // =0x00000784
	str r0, [r5, r1]
	ldr r1, [r5, r1]
	mov r0, r5
	blx r1
	add sp, #8
	pop {r3, r4, r5, pc}
	.align 2, 0
_02178D10: .word ovl01_2178D18
_02178D14: .word 0x00000784
	thumb_func_end ovl01_2178CD4

	thumb_func_start ovl01_2178D18
ovl01_2178D18: // 0x02178D18
	mov r1, #0xde
	lsl r1, r1, #2
	add r3, r0, r1
	ldrh r2, [r3, #6]
	add r1, r2, #1
	strh r1, [r3, #6]
	cmp r2, #0x5a
	bls _02178D2E
	ldr r2, _02178D30 // =ovl01_2178D38
	ldr r1, _02178D34 // =0x00000784
	str r2, [r0, r1]
_02178D2E:
	bx lr
	.align 2, 0
_02178D30: .word ovl01_2178D38
_02178D34: .word 0x00000784
	thumb_func_end ovl01_2178D18

	thumb_func_start ovl01_2178D38
ovl01_2178D38: // 0x02178D38
	push {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #0xde
	lsl r0, r0, #2
	add r4, r5, r0
	ldr r0, _02178D90 // =gPlayer
	ldr r0, [r0, #0]
	bl BossHelpers__Player__IsDead
	cmp r0, #0
	beq _02178D8C
	ldr r1, _02178D94 // =playerGameStatus
	mov r0, #1
	ldr r2, [r1, #0]
	bic r2, r0
	ldr r0, _02178D90 // =gPlayer
	str r2, [r1]
	ldr r0, [r0, #0]
	bl Player__Action_Intangible
	ldr r0, _02178D90 // =gPlayer
	mov r1, #0xe
	ldr r0, [r0, #0]
	bl Player__ChangeAction
	ldr r0, _02178D90 // =gPlayer
	ldr r0, [r0, #0]
	bl BossHelpers__Player__LockControl
	bl Camera3D__GetWork
	add r0, #0x7c
	mov r1, #0x1f
	mov r2, #0
	bl RenderCore_SetBlendBrightness
	mov r0, #0
	strh r0, [r4, #6]
	strh r0, [r4, #4]
	ldr r1, _02178D98 // =ovl01_2178DA0
	ldr r0, _02178D9C // =0x00000784
	str r1, [r5, r0]
_02178D8C:
	pop {r3, r4, r5, pc}
	nop
_02178D90: .word gPlayer
_02178D94: .word playerGameStatus
_02178D98: .word ovl01_2178DA0
_02178D9C: .word 0x00000784
	thumb_func_end ovl01_2178D38

	thumb_func_start ovl01_2178DA0
ovl01_2178DA0: // 0x02178DA0
	push {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #0xde
	lsl r0, r0, #2
	add r4, r5, r0
	ldrh r1, [r4, #6]
	add r0, r1, #1
	strh r0, [r4, #6]
	cmp r1, #0x1e
	bls _02178DD0
	mov r0, #4
	ldrsh r1, [r4, r0]
	sub r0, #0x14
	cmp r1, r0
	ble _02178DD0
	sub r0, r1, #1
	strh r0, [r4, #4]
	bl Camera3D__GetWork
	mov r1, #4
	ldrsh r1, [r4, r1]
	add r0, #0x7c
	bl RenderCore_ChangeBlendBrightness
_02178DD0:
	ldr r1, _02178DFC // =gPlayer
	mov r0, #0x10
	ldr r3, [r1, #0]
	ldr r2, [r3, #0x1c]
	orr r0, r2
	str r0, [r3, #0x1c]
	ldr r0, [r1, #0]
	ldr r2, _02178E00 // =0xFFFFE000
	add r0, #0x98
	str r2, [r0]
	ldr r0, [r1, #0]
	add r0, #0x9c
	str r2, [r0]
	mov r0, #4
	ldrsh r1, [r4, r0]
	sub r0, #0x14
	cmp r1, r0
	bne _02178DFA
	ldr r1, _02178E04 // =ovl01_2178E0C
	ldr r0, _02178E08 // =0x00000784
	str r1, [r5, r0]
_02178DFA:
	pop {r3, r4, r5, pc}
	.align 2, 0
_02178DFC: .word gPlayer
_02178E00: .word 0xFFFFE000
_02178E04: .word ovl01_2178E0C
_02178E08: .word 0x00000784
	thumb_func_end ovl01_2178DA0

	thumb_func_start ovl01_2178E0C
ovl01_2178E0C: // 0x02178E0C
	push {r4, lr}
	mov r4, r0
	mov r0, #0
	bl SetHUDActiveScreen
	ldr r0, _02178E24 // =0x0000037E
	mov r1, #0
	strh r1, [r4, r0]
	ldr r1, _02178E28 // =ovl01_2178E30
	ldr r0, _02178E2C // =0x00000784
	str r1, [r4, r0]
	pop {r4, pc}
	.align 2, 0
_02178E24: .word 0x0000037E
_02178E28: .word ovl01_2178E30
_02178E2C: .word 0x00000784
	thumb_func_end ovl01_2178E0C

	thumb_func_start ovl01_2178E30
ovl01_2178E30: // 0x02178E30
	mov r1, #0xde
	lsl r1, r1, #2
	add r3, r0, r1
	ldrh r2, [r3, #6]
	add r1, r2, #1
	strh r1, [r3, #6]
	cmp r2, #0x3c
	bls _02178E46
	ldr r2, _02178E48 // =ovl01_2178E50
	ldr r1, _02178E4C // =0x00000784
	str r2, [r0, r1]
_02178E46:
	bx lr
	.align 2, 0
_02178E48: .word ovl01_2178E50
_02178E4C: .word 0x00000784
	thumb_func_end ovl01_2178E30

	thumb_func_start ovl01_2178E50
ovl01_2178E50: // 0x02178E50
	push {r4, r5, r6, lr}
	sub sp, #8
	mov r5, r0
	mov r0, #0xdd
	lsl r0, r0, #2
	add r1, r0, #4
	add r6, r5, r1
	mov r1, #0xf
	ldr r2, [r5, #0x44]
	lsl r1, r1, #0xe
	sub r3, r2, r1
	ldr r2, _02178F18 // =gPlayer
	ldr r4, [r5, r0]
	ldr r1, [r2, #0]
	str r3, [r1, #0x44]
	ldr r3, [r5, #0x48]
	ldr r1, _02178F1C // =0x00172000
	sub r3, r3, r1
	ldr r1, [r2, #0]
	str r3, [r1, #0x48]
	ldr r1, [r2, #0]
	ldr r2, _02178F20 // =0xFFF7FFFF
	ldr r3, [r1, #0x1c]
	and r2, r3
	str r2, [r1, #0x1c]
	mov r1, r0
	mov r2, #0
	add r1, #0x90
	strh r2, [r4, r1]
	mov r1, r0
	add r1, #0x90
	ldrh r1, [r4, r1]
	add r0, #0x8e
	strh r1, [r4, r0]
	mov r0, r4
	bl ovl01_217552C
	ldr r0, _02178F24 // =0x00000B1C
	ldr r0, [r5, r0]
	cmp r0, #0x13
	bne _02178EAE
	mov r0, r5
	mov r1, #0x14
	mov r2, #0
	bl ovl01_217749C
	b _02178EB8
_02178EAE:
	mov r0, r5
	mov r1, #0xd
	mov r2, #0
	bl ovl01_217749C
_02178EB8:
	mov r1, #0xf
	ldr r2, [r5, #0x44]
	lsl r1, r1, #0xe
	sub r1, r2, r1
	mov r2, #5
	ldr r3, [r5, #0x48]
	lsl r2, r2, #0x12
	sub r2, r3, r2
	ldr r3, [r5, #0x4c]
	mov r0, #0
	bl BossFX__CreateWhaleSpout
	mov r0, #0
	str r0, [sp]
	mov r1, #0xdf
	str r1, [sp, #4]
	sub r1, #0xe0
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r2, [r6, #0]
	mov r0, #8
	ldr r1, [r2, #0x18]
	orr r0, r1
	str r0, [r2, #0x18]
	bl ovl01_217597C
	mov r0, r4
	bl ovl01_2176DD0
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r1, [r5, r0]
	add r0, #0x18
	ldrsh r0, [r1, r0]
	cmp r0, #0xa
	ble _02178F0A
	mov r0, #0
	bl ChangeBossBGMVariant
_02178F0A:
	mov r0, #0
	strh r0, [r6, #6]
	ldr r1, _02178F28 // =ovl01_2178F30
	ldr r0, _02178F2C // =0x00000784
	str r1, [r5, r0]
	add sp, #8
	pop {r4, r5, r6, pc}
	.align 2, 0
_02178F18: .word gPlayer
_02178F1C: .word 0x00172000
_02178F20: .word 0xFFF7FFFF
_02178F24: .word 0x00000B1C
_02178F28: .word ovl01_2178F30
_02178F2C: .word 0x00000784
	thumb_func_end ovl01_2178E50

	thumb_func_start ovl01_2178F30
ovl01_2178F30: // 0x02178F30
	push {r3, r4, r5, r6, r7, lr}
	mov r1, #0xde
	lsl r1, r1, #2
	mov r5, r0
	sub r0, r1, #4
	ldr r0, [r5, r0]
	add r4, r5, r1
	ldr r0, [r0, r1]
	bl ovl01_217746C
	mov r7, r0
	ldrh r0, [r4, #6]
	cmp r0, #0x3c
	bne _02178FA4
	mov r0, #1
	bl BossArena__GetCamera
	ldr r1, _02179084 // =gPlayer
	mov r6, r0
	ldr r1, [r1, #0]
	mov r2, r1
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	mov r0, r6
	mov r1, #1
	bl BossArena__SetTracker1UseObj3D
	mov r1, #1
	mov r0, r6
	lsl r1, r1, #0xa
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r1, #1
	mov r0, r6
	lsl r1, r1, #0xa
	mov r2, #0
	bl BossArena__SetTracker0Speed
	mov r1, #0x4b
	mov r0, r6
	lsl r1, r1, #0xe
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r6
	mov r1, #0xcc
	bl BossArena__SetAmplitudeXZSpeed
	mov r1, #0x1e
	mov r0, r6
	lsl r1, r1, #0xc
	bl BossArena__SetAmplitudeYTarget
	mov r0, r6
	mov r1, #0xcc
	bl BossArena__SetAmplitudeYSpeed
_02178FA4:
	ldr r2, _02179084 // =gPlayer
	ldr r1, _02179088 // =0xFFCE0000
	ldr r0, [r2, #0]
	ldr r3, [r0, #0x48]
	cmp r3, r1
	ble _02178FB8
	ldr r1, _0217908C // =0xFFFF4000
	add r0, #0x9c
	str r1, [r0]
	b _02178FC8
_02178FB8:
	mov r1, #0
	add r0, #0x9c
	str r1, [r0]
	ldr r2, [r2, #0]
	mov r0, #0x80
	ldr r1, [r2, #0x1c]
	bic r1, r0
	str r1, [r2, #0x1c]
_02178FC8:
	ldr r0, _02179084 // =gPlayer
	ldr r1, [r0, #0]
	ldr r0, [r1, #0x44]
	cmp r7, r0
	bge _02178FD6
	ldr r0, _02179090 // =0xFFFFC000
	b _02178FD8
_02178FD6:
	mov r0, #0
_02178FD8:
	add r1, #0x98
	str r0, [r1]
	ldr r0, _02179084 // =gPlayer
	ldr r1, [r0, #0]
	mov r0, r1
	add r0, #0x98
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0217907A
	add r1, #0x9c
	ldr r0, [r1, #0]
	cmp r0, #0
	bne _0217907A
	ldrh r0, [r4, #6]
	cmp r0, #0xb4
	bls _0217907A
	ldr r0, _02179094 // =0x0000078C
	mov r1, #0xb
	str r1, [r5, r0]
	mov r0, #2
	bl BossArena__GetCamera
	mov r6, r0
	mov r0, r5
	bl ovl01_2177C98
	mov r0, r6
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r6
	bl BossArena__ApplyAmplitudeXZTarget
	mov r0, r6
	bl BossArena__ApplyAmplitudeYTarget
	mov r0, r6
	bl BossArena__ApplyAngleTarget
	bl BossArena__Func_20397E4
	mov r0, r6
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r6
	bl BossArena__UpdateTracker0TargetPos
	ldr r0, _02179084 // =gPlayer
	ldr r0, [r0, #0]
	bl Player__RemoveCollideEvent
	ldr r0, _02179084 // =gPlayer
	ldr r0, [r0, #0]
	bl Player__OnLandGround
	ldr r0, _02179084 // =gPlayer
	ldr r2, [r0, #0]
	mov r0, #0x80
	ldr r1, [r2, #0x1c]
	orr r0, r1
	mov r1, #0xdd
	lsl r1, r1, #2
	str r0, [r2, #0x1c]
	ldr r2, [r5, r1]
	add r0, r1, #4
	ldr r3, [r2, r0]
	mov r0, #0x20
	ldr r2, [r3, #0x20]
	bic r2, r0
	str r2, [r3, #0x20]
	ldr r0, [r5, r1]
	add r1, #0x18
	ldrsh r0, [r0, r1]
	cmp r0, #0xa
	bgt _02179074
	mov r0, r5
	bl ovl01_2177B34
	b _0217907A
_02179074:
	ldr r1, _02179098 // =ovl01_21790A0
	ldr r0, _0217909C // =0x00000784
	str r1, [r5, r0]
_0217907A:
	ldrh r0, [r4, #6]
	add r0, r0, #1
	strh r0, [r4, #6]
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02179084: .word gPlayer
_02179088: .word 0xFFCE0000
_0217908C: .word 0xFFFF4000
_02179090: .word 0xFFFFC000
_02179094: .word 0x0000078C
_02179098: .word ovl01_21790A0
_0217909C: .word 0x00000784
	thumb_func_end ovl01_2178F30

	thumb_func_start ovl01_21790A0
ovl01_21790A0: // 0x021790A0
	mov r3, #0xde
	lsl r3, r3, #2
	sub r2, r3, #4
	ldr r2, [r0, r2]
	add r1, r0, r3
	ldr r2, [r2, r3]
	ldr r2, [r2, r3]
	cmp r2, #4
	beq _021790BA
	ldr r3, [r0, #0x20]
	mov r2, #0x20
	orr r2, r3
	str r2, [r0, #0x20]
_021790BA:
	mov r2, #0xf
	mvn r2, r2
	strh r2, [r1, #4]
	ldr r2, _021790C8 // =ovl01_21790D0
	ldr r1, _021790CC // =0x00000784
	str r2, [r0, r1]
	bx lr
	.align 2, 0
_021790C8: .word ovl01_21790D0
_021790CC: .word 0x00000784
	thumb_func_end ovl01_21790A0

	thumb_func_start ovl01_21790D0
ovl01_21790D0: // 0x021790D0
	push {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #0xde
	lsl r0, r0, #2
	add r4, r5, r0
	mov r0, #4
	ldrsh r0, [r4, r0]
	cmp r0, #0
	bge _021790F6
	add r0, r0, #1
	strh r0, [r4, #4]
	bl Camera3D__GetWork
	mov r1, #4
	ldrsh r1, [r4, r1]
	add r0, #0x7c
	bl RenderCore_ChangeBlendBrightness
	b _021790FC
_021790F6:
	mov r0, #1
	bl BossHelpers__Blend__Func_2039488
_021790FC:
	ldr r0, _02179110 // =gPlayer
	ldr r0, [r0, #0]
	ldr r1, [r0, #0x1c]
	mov r0, #1
	tst r0, r1
	beq _0217910E
	ldr r1, _02179114 // =ovl01_217911C
	ldr r0, _02179118 // =0x00000784
	str r1, [r5, r0]
_0217910E:
	pop {r3, r4, r5, pc}
	.align 2, 0
_02179110: .word gPlayer
_02179114: .word ovl01_217911C
_02179118: .word 0x00000784
	thumb_func_end ovl01_21790D0

	thumb_func_start ovl01_217911C
ovl01_217911C: // 0x0217911C
	push {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #0xde
	lsl r0, r0, #2
	add r4, r5, r0
	ldr r0, _02179190 // =gPlayer
	ldr r0, [r0, #0]
	bl BossHelpers__Player__UnlockControl
	ldr r0, _02179190 // =gPlayer
	ldr r2, [r0, #0]
	mov r0, #2
	ldr r1, [r2, #0x1c]
	lsl r0, r0, #0x12
	orr r0, r1
	str r0, [r2, #0x1c]
	ldr r1, _02179194 // =playerGameStatus
	mov r0, #1
	ldr r2, [r1, #0]
	orr r0, r2
	str r0, [r1]
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r2, [r5, r0]
	add r1, r0, #4
	ldr r1, [r2, r1]
	add r0, r0, #4
	ldr r0, [r1, r0]
	cmp r0, #4
	beq _0217917A
	add r2, #0x44
	mov r3, r5
	ldmia r2!, {r0, r1}
	add r3, #0x44
	stmia r3!, {r0, r1}
	ldr r0, [r2, #0]
	mov r2, #0
	str r0, [r3]
	ldr r1, [r5, #0x20]
	mov r0, #0x20
	bic r1, r0
	str r1, [r5, #0x20]
	mov r0, r5
	mov r1, #2
	bl ovl01_217749C
	b _02179182
_0217917A:
	mov r0, r5
	bl ovl01_21779CC
	pop {r3, r4, r5, pc}
_02179182:
	mov r0, #0
	strh r0, [r4, #6]
	ldr r1, _02179198 // =ovl01_21791A0
	ldr r0, _0217919C // =0x00000784
	str r1, [r5, r0]
	pop {r3, r4, r5, pc}
	nop
_02179190: .word gPlayer
_02179194: .word playerGameStatus
_02179198: .word ovl01_21791A0
_0217919C: .word 0x00000784
	thumb_func_end ovl01_217911C

	thumb_func_start ovl01_21791A0
ovl01_21791A0: // 0x021791A0
	push {r3, r4, r5, lr}
	sub sp, #0x38
	mov r5, r0
	mov r0, #0xde
	lsl r0, r0, #2
	add r4, r5, r0
	ldrh r0, [r4, #6]
	cmp r0, #0x50
	bne _021791E0
	add r0, sp, #8
	bl ovl01_21752C0
	ldr r0, _02179214 // =0x0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r3, r0
	add r0, sp, #8
	str r0, [sp]
	mov r2, #0x39
	lsl r2, r2, #4
	ldr r2, [r3, r2]
	ldr r1, [sp, #0x2c]
	neg r3, r2
	mov r2, #0xf
	lsl r2, r2, #0xe
	add r2, r3, r2
	ldr r3, [sp, #0x34]
	mov r0, #4
	neg r2, r2
	bl BossFX__CreateWhaleSplashB
_021791E0:
	ldrh r0, [r4, #6]
	cmp r0, #0x28
	bne _021791F8
	mov r0, #0
	str r0, [sp]
	mov r1, #0xa8
	str r1, [sp, #4]
	sub r1, #0xa9
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_021791F8:
	ldrh r0, [r4, #6]
	add r0, r0, #1
	strh r0, [r4, #6]
	mov r0, r5
	bl ovl01_21774E8
	cmp r0, #0
	beq _0217920E
	mov r0, r5
	bl ovl01_2177930
_0217920E:
	add sp, #0x38
	pop {r3, r4, r5, pc}
	nop
_02179214: .word 0x0217AFB8
	thumb_func_end ovl01_21791A0

	thumb_func_start ovl01_2179218
ovl01_2179218: // 0x02179218
	push {r3, r4, r5, lr}
	mov r4, r0
	mov r5, #0
_0217921E:
	mov r0, r5
	mov r1, r4
	bl ovl01_2177540
	add r5, r5, #1
	cmp r5, #3
	blt _0217921E
	mov r0, r4
	mov r1, #0x15
	mov r2, #0
	bl ovl01_217749C
	ldr r1, _02179240 // =ovl01_2179248
	ldr r0, _02179244 // =0x00000784
	str r1, [r4, r0]
	pop {r3, r4, r5, pc}
	nop
_02179240: .word ovl01_2179248
_02179244: .word 0x00000784
	thumb_func_end ovl01_2179218

	thumb_func_start ovl01_2179248
ovl01_2179248: // 0x02179248
	push {r4, lr}
	mov r4, r0
	bl ovl01_21774E8
	cmp r0, #0
	beq _0217925A
	ldr r1, _0217925C // =ovl01_2179264
	ldr r0, _02179260 // =0x00000784
	str r1, [r4, r0]
_0217925A:
	pop {r4, pc}
	.align 2, 0
_0217925C: .word ovl01_2179264
_02179260: .word 0x00000784
	thumb_func_end ovl01_2179248

	thumb_func_start ovl01_2179264
ovl01_2179264: // 0x02179264
	push {r4, lr}
	mov r1, #0x16
	mov r2, #1
	mov r4, r0
	bl ovl01_217749C
	mov r1, #0xf
	mov r0, #0xde
	mvn r1, r1
	lsl r0, r0, #2
	strh r1, [r4, r0]
	ldr r1, _02179284 // =ovl01_217928C
	ldr r0, _02179288 // =0x00000784
	str r1, [r4, r0]
	pop {r4, pc}
	nop
_02179284: .word ovl01_217928C
_02179288: .word 0x00000784
	thumb_func_end ovl01_2179264

	thumb_func_start ovl01_217928C
ovl01_217928C: // 0x0217928C
	push {r4, r5, r6, lr}
	mov r6, r0
	mov r0, #0xde
	lsl r0, r0, #2
	add r4, r6, r0
	ldrsh r0, [r6, r0]
	mov r5, #1
	cmp r0, #0
	bge _021792B4
	add r0, r0, #1
	strh r0, [r4]
	bl Camera3D__GetWork
	mov r1, #0
	ldrsh r1, [r4, r1]
	add r0, #0x7c
	bl RenderCore_ChangeBlendBrightness
	mov r5, #0
	b _021792BA
_021792B4:
	mov r0, r5
	bl BossHelpers__Blend__Func_2039488
_021792BA:
	ldr r0, _021792D4 // =gPlayer
	ldr r0, [r0, #0]
	ldr r1, [r0, #0x1c]
	mov r0, #1
	tst r0, r1
	bne _021792C8
	mov r5, #0
_021792C8:
	cmp r5, #0
	beq _021792D2
	ldr r1, _021792D8 // =ovl01_21792E0
	ldr r0, _021792DC // =0x00000784
	str r1, [r6, r0]
_021792D2:
	pop {r4, r5, r6, pc}
	.align 2, 0
_021792D4: .word gPlayer
_021792D8: .word ovl01_21792E0
_021792DC: .word 0x00000784
	thumb_func_end ovl01_217928C

	thumb_func_start ovl01_21792E0
ovl01_21792E0: // 0x021792E0
	push {r4, lr}
	mov r4, r0
	ldr r0, _0217932C // =gPlayer
	ldr r0, [r0, #0]
	bl BossHelpers__Player__UnlockControl
	ldr r0, _0217932C // =gPlayer
	ldr r2, [r0, #0]
	mov r0, #2
	ldr r1, [r2, #0x1c]
	lsl r0, r0, #0x12
	orr r0, r1
	str r0, [r2, #0x1c]
	ldr r1, _02179330 // =playerGameStatus
	mov r0, #1
	ldr r2, [r1, #0]
	orr r0, r2
	str r0, [r1]
	mov r0, #0
	mov r1, r4
	bl ovl01_2177554
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #0x96
	lsl r1, r1, #0xe
	bl BossArena__SetAmplitudeXZTarget
	mov r1, #0x96
	ldr r0, _02179334 // =0x0000037A
	lsl r1, r1, #2
	strh r1, [r4, r0]
	ldr r1, _02179338 // =ovl01_2179340
	ldr r0, _0217933C // =0x00000784
	str r1, [r4, r0]
	pop {r4, pc}
	nop
_0217932C: .word gPlayer
_02179330: .word playerGameStatus
_02179334: .word 0x0000037A
_02179338: .word ovl01_2179340
_0217933C: .word 0x00000784
	thumb_func_end ovl01_21792E0

	thumb_func_start ovl01_2179340
ovl01_2179340: // 0x02179340
	mov r1, #0xde
	lsl r1, r1, #2
	add r2, r0, r1
	ldrh r1, [r2, #2]
	sub r1, r1, #1
	strh r1, [r2, #2]
	ldrh r1, [r2, #2]
	cmp r1, #0
	bne _02179358
	ldr r2, _0217935C // =ovl01_2179364
	ldr r1, _02179360 // =0x00000784
	str r2, [r0, r1]
_02179358:
	bx lr
	nop
_0217935C: .word ovl01_2179364
_02179360: .word 0x00000784
	thumb_func_end ovl01_2179340

	thumb_func_start ovl01_2179364
ovl01_2179364: // 0x02179364
	push {r3, r4, r5, lr}
	mov r4, r0
	mov r5, #0
_0217936A:
	mov r0, r5
	mov r1, r4
	bl ovl01_2177540
	add r5, r5, #1
	cmp r5, #3
	blt _0217936A
	mov r1, #0xdd
	lsl r1, r1, #2
	mov r0, r1
	ldr r3, _021793A0 // =0x00000151
	ldr r2, [r4, r1]
	add r0, #0x18
	strh r3, [r2, r0]
	ldr r0, [r4, r1]
	add r1, #0x18
	ldrsh r0, [r0, r1]
	bl UpdateBossHealthHUD
	mov r0, #0
	bl ChangeBossBGMVariant
	ldr r1, _021793A4 // =ovl01_21793AC
	ldr r0, _021793A8 // =0x00000784
	str r1, [r4, r0]
	pop {r3, r4, r5, pc}
	nop
_021793A0: .word 0x00000151
_021793A4: .word ovl01_21793AC
_021793A8: .word 0x00000784
	thumb_func_end ovl01_2179364

	thumb_func_start ovl01_21793AC
ovl01_21793AC: // 0x021793AC
	push {r4, lr}
	mov r4, r0
	bl ovl01_21774E8
	cmp r0, #0
	beq _021793BE
	ldr r1, _021793C0 // =ovl01_21793C8
	ldr r0, _021793C4 // =0x00000784
	str r1, [r4, r0]
_021793BE:
	pop {r4, pc}
	.align 2, 0
_021793C0: .word ovl01_21793C8
_021793C4: .word 0x00000784
	thumb_func_end ovl01_21793AC

	thumb_func_start ovl01_21793C8
ovl01_21793C8: // 0x021793C8
	push {r4, lr}
	mov r1, #0x17
	mov r2, #0
	mov r4, r0
	bl ovl01_217749C
	ldr r1, _021793DC // =ovl01_21793E4
	ldr r0, _021793E0 // =0x00000784
	str r1, [r4, r0]
	pop {r4, pc}
	.align 2, 0
_021793DC: .word ovl01_21793E4
_021793E0: .word 0x00000784
	thumb_func_end ovl01_21793C8

	thumb_func_start ovl01_21793E4
ovl01_21793E4: // 0x021793E4
	push {r4, lr}
	mov r4, r0
	bl ovl01_21774E8
	cmp r0, #0
	beq _021793F6
	ldr r1, _021793F8 // =ovl01_2179400
	ldr r0, _021793FC // =0x00000784
	str r1, [r4, r0]
_021793F6:
	pop {r4, pc}
	.align 2, 0
_021793F8: .word ovl01_2179400
_021793FC: .word 0x00000784
	thumb_func_end ovl01_21793E4

	thumb_func_start ovl01_2179400
ovl01_2179400: // 0x02179400
	push {r4, lr}
	sub sp, #0x38
	mov r1, #8
	mov r2, #0
	mov r4, r0
	bl ovl01_217749C
	add r0, sp, #8
	bl ovl01_21752C0
	add r0, sp, #8
	str r0, [sp]
	ldr r1, [sp, #0x2c]
	ldr r2, [sp, #0x30]
	ldr r3, [sp, #0x34]
	mov r0, #0
	bl BossFX__CreateWhaleSplashB
	mov r0, #0
	str r0, [sp]
	mov r1, #0xd4
	mov r0, #0xb2
	str r1, [sp, #4]
	sub r1, #0xd5
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl DisableSpatialVolume
	mov r0, #0xb2
	lsl r0, r0, #4
	mov r1, r4
	ldr r0, [r4, r0]
	add r1, #0x44
	bl ProcessSpatialVoiceClip
	bl EnableSpatialVolume
	ldr r1, _0217945C // =ovl01_2179464
	ldr r0, _02179460 // =0x00000784
	str r1, [r4, r0]
	add sp, #0x38
	pop {r4, pc}
	.align 2, 0
_0217945C: .word ovl01_2179464
_02179460: .word 0x00000784
	thumb_func_end ovl01_2179400

	thumb_func_start ovl01_2179464
ovl01_2179464: // 0x02179464
	push {r4, lr}
	mov r4, r0
	bl ovl01_21774E8
	cmp r0, #0
	beq _02179476
	ldr r1, _02179478 // =ovl01_2179480
	ldr r0, _0217947C // =0x00000784
	str r1, [r4, r0]
_02179476:
	pop {r4, pc}
	.align 2, 0
_02179478: .word ovl01_2179480
_0217947C: .word 0x00000784
	thumb_func_end ovl01_2179464

	thumb_func_start ovl01_2179480
ovl01_2179480: // 0x02179480
	push {r4, lr}
	mov r4, r0
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r3, [r4, r0]
	mov r2, r4
	add r3, #0x44
	ldmia r3!, {r0, r1}
	add r2, #0x44
	stmia r2!, {r0, r1}
	ldr r0, [r3, #0]
	str r0, [r2]
	ldr r1, [r4, #0x20]
	mov r0, #0x20
	bic r1, r0
	str r1, [r4, #0x20]
	mov r0, r4
	mov r1, #2
	mov r2, #0
	bl ovl01_217749C
	ldr r0, _021794B8 // =0x0000037A
	mov r1, #0
	strh r1, [r4, r0]
	ldr r1, _021794BC // =ovl01_21794C4
	ldr r0, _021794C0 // =0x00000784
	str r1, [r4, r0]
	pop {r4, pc}
	.align 2, 0
_021794B8: .word 0x0000037A
_021794BC: .word ovl01_21794C4
_021794C0: .word 0x00000784
	thumb_func_end ovl01_2179480

	thumb_func_start ovl01_21794C4
ovl01_21794C4: // 0x021794C4
	push {r3, r4, r5, lr}
	sub sp, #0x38
	mov r5, r0
	mov r0, #0xde
	lsl r0, r0, #2
	add r4, r5, r0
	ldrh r0, [r4, #2]
	cmp r0, #0x50
	bne _02179504
	add r0, sp, #8
	bl ovl01_21752C0
	ldr r0, _02179538 // =0x0217AFB8
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r3, r0
	add r0, sp, #8
	str r0, [sp]
	mov r2, #0x39
	lsl r2, r2, #4
	ldr r2, [r3, r2]
	ldr r1, [sp, #0x2c]
	neg r3, r2
	mov r2, #0xf
	lsl r2, r2, #0xe
	add r2, r3, r2
	ldr r3, [sp, #0x34]
	mov r0, #4
	neg r2, r2
	bl BossFX__CreateWhaleSplashB
_02179504:
	ldrh r0, [r4, #2]
	cmp r0, #0x28
	bne _0217951C
	mov r0, #0
	str r0, [sp]
	mov r1, #0xa8
	str r1, [sp, #4]
	sub r1, #0xa9
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_0217951C:
	ldrh r0, [r4, #2]
	add r0, r0, #1
	strh r0, [r4, #2]
	mov r0, r5
	bl ovl01_21774E8
	cmp r0, #0
	beq _02179532
	mov r0, r5
	bl ovl01_2177930
_02179532:
	add sp, #0x38
	pop {r3, r4, r5, pc}
	nop
_02179538: .word 0x0217AFB8
	thumb_func_end ovl01_21794C4

	thumb_func_start ovl01_217953C
ovl01_217953C: // 0x0217953C
	push {r3, r4, r5, lr}
	mov r2, #0xde
	lsl r2, r2, #2
	sub r1, r2, #4
	add r4, r0, r2
	ldr r0, [r0, r1]
	add r2, #0x4c
	ldrsh r3, [r0, r2]
	cmp r3, #0
	bge _02179552
	neg r3, r3
_02179552:
	mov r2, #2
	lsl r2, r2, #8
	lsl r3, r3, #0x18
	add r1, r4, r2
	mov r0, r4
	lsr r2, r2, #1
	lsr r3, r3, #0x18
	bl Palette__UnknownFunc10
	mov r5, #2
	lsl r5, r5, #8
	add r0, r4, r5
	mov r1, r5
	bl DC_StoreRange
	ldr r3, _02179580 // =VRAMSystem__VRAM_PALETTE_BG
	add r0, r4, r5
	ldr r3, [r3, #0]
	lsr r1, r5, #1
	mov r2, #0
	bl QueueUncompressedPalette
	pop {r3, r4, r5, pc}
	.align 2, 0
_02179580: .word VRAMSystem__VRAM_PALETTE_BG
	thumb_func_end ovl01_217953C

	thumb_func_start ovl01_2179584
ovl01_2179584: // 0x02179584
	push {r4, r5, r6, lr}
	sub sp, #8
	mov r2, #0xdd
	lsl r2, r2, #2
	mov r5, r0
	add r0, r2, #4
	add r6, r5, r0
	ldr r4, [r5, r2]
	mov r0, #0
	mov r1, r6
	add r2, #0x96
	bl MIi_CpuClear16
	ldr r1, _02179620 // =playerGameStatus
	mov r0, #1
	ldr r2, [r1, #0]
	bic r2, r0
	str r2, [r1]
	bl StopStageBGM
	ldr r0, _02179624 // =gPlayer
	ldr r0, [r0, #0]
	bl Player__Action_Blank
	ldr r0, _02179624 // =gPlayer
	mov r1, #0x12
	ldr r0, [r0, #0]
	bl Player__ChangeAction
	ldr r1, _02179624 // =gPlayer
	ldr r0, _02179628 // =0x00000682
	ldr r2, [r1, #0]
	mov r3, #0
	strh r3, [r2, r0]
	ldr r0, [r1, #0]
	bl BossHelpers__Player__LockControl
	ldr r0, _0217962C // =0x00000524
	mov r1, #0
	str r1, [r4, r0]
	ldr r0, _02179630 // =0x00000AB8
	str r1, [r5, r0]
	bl EnableObjectManagerFlag2
	ldr r1, [r5, #0x18]
	mov r0, #0x20
	orr r1, r0
	str r1, [r5, #0x18]
	ldr r1, [r4, #0x18]
	orr r0, r1
	str r0, [r4, #0x18]
	ldr r0, _02179624 // =gPlayer
	ldr r3, [r0, #0]
	mov r0, #0
	ldr r2, [r3, #0x48]
	ldr r1, [r3, #0x44]
	ldr r3, [r3, #0x4c]
	neg r2, r2
	bl BossFX__CreateWhaleExplode2
	mov r0, #0
	str r0, [sp]
	mov r1, #0xd3
	str r1, [sp, #4]
	sub r1, #0xd4
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, _02179634 // =0x00000408
	mov r1, #0
	strh r1, [r6, r0]
	ldr r1, _02179638 // =ovl01_2179640
	ldr r0, _0217963C // =0x00000784
	str r1, [r5, r0]
	add sp, #8
	pop {r4, r5, r6, pc}
	nop
_02179620: .word playerGameStatus
_02179624: .word gPlayer
_02179628: .word 0x00000682
_0217962C: .word 0x00000524
_02179630: .word 0x00000AB8
_02179634: .word 0x00000408
_02179638: .word ovl01_2179640
_0217963C: .word 0x00000784
	thumb_func_end ovl01_2179584

	thumb_func_start ovl01_2179640
ovl01_2179640: // 0x02179640
	push {r4, r5, r6, lr}
	mov r1, #0xde
	lsl r1, r1, #2
	mov r5, r0
	mov r0, r1
	add r3, r5, r1
	add r0, #0x90
	ldrh r0, [r3, r0]
	add r2, r0, #1
	mov r0, r1
	add r0, #0x90
	add r1, #0x90
	strh r2, [r3, r0]
	ldrh r0, [r3, r1]
	cmp r0, #0x5a
	bne _021796C0
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #0
	mov r2, r1
	mov r3, r1
	mov r4, r0
	bl BossArena__SetTracker1TargetWork
	ldr r3, _021796C4 // =0x000007E4
	mov r0, r4
	add r2, r3, #4
	ldr r1, [r5, r3]
	ldr r6, [r5, r2]
	mov r2, #0x32
	add r3, #8
	lsl r2, r2, #0xe
	ldr r3, [r5, r3]
	add r2, r6, r2
	bl BossArena__SetTracker1TargetPos
	mov r1, #0xfa
	mov r0, r4
	lsl r1, r1, #0xe
	bl BossArena__SetAmplitudeXZTarget
	mov r1, #0x19
	mov r0, r4
	lsl r1, r1, #0xe
	bl BossArena__SetAmplitudeYTarget
	mov r1, #1
	lsl r1, r1, #8
	mov r2, r1
	mov r0, r4
	add r2, #0x99
	bl BossArena__SetTracker1Speed
	mov r1, #1
	lsl r1, r1, #8
	mov r2, r1
	mov r0, r4
	add r2, #0x99
	bl BossArena__SetTracker0Speed
	ldr r1, _021796C8 // =ovl01_21796D0
	ldr r0, _021796CC // =0x00000784
	str r1, [r5, r0]
_021796C0:
	pop {r4, r5, r6, pc}
	nop
_021796C4: .word 0x000007E4
_021796C8: .word ovl01_21796D0
_021796CC: .word 0x00000784
	thumb_func_end ovl01_2179640

	thumb_func_start ovl01_21796D0
ovl01_21796D0: // 0x021796D0
	push {r4, r5, r6, lr}
	mov r6, r0
	mov r0, #0xde
	lsl r0, r0, #2
	add r4, r6, r0
	bl Camera3D__GetWork
	mov r5, r0
	add r5, #0x5c
	mov r1, r5
	mov r0, #0
	add r1, #0x20
	mov r2, #6
	bl MIi_CpuClear16
	ldrh r1, [r5, #0x20]
	mov r0, #0xc0
	mov r2, #0x10
	bic r1, r0
	mov r0, #0xc0
	orr r0, r1
	strh r0, [r5, #0x20]
	ldrh r1, [r5, #0x20]
	mov r0, #1
	bic r1, r0
	mov r0, #1
	orr r0, r1
	strh r0, [r5, #0x20]
	ldrh r1, [r5, #0x20]
	mov r0, #2
	orr r0, r1
	strh r0, [r5, #0x20]
	ldrh r1, [r5, #0x20]
	mov r0, #4
	orr r0, r1
	strh r0, [r5, #0x20]
	ldrh r1, [r5, #0x20]
	mov r0, #8
	orr r0, r1
	strh r0, [r5, #0x20]
	ldrh r0, [r5, #0x20]
	mov r1, r4
	orr r0, r2
	strh r0, [r5, #0x20]
	ldr r0, _02179740 // =VRAMSystem__VRAM_PALETTE_BG
	lsl r2, r2, #5
	ldr r0, [r0, #0]
	bl MIi_CpuCopyFast
	ldr r0, _02179744 // =0x00000408
	mov r1, #0
	strh r1, [r4, r0]
	ldr r1, _02179748 // =ovl01_2179750
	ldr r0, _0217974C // =0x00000784
	str r1, [r6, r0]
	pop {r4, r5, r6, pc}
	.align 2, 0
_02179740: .word VRAMSystem__VRAM_PALETTE_BG
_02179744: .word 0x00000408
_02179748: .word ovl01_2179750
_0217974C: .word 0x00000784
	thumb_func_end ovl01_21796D0

	thumb_func_start ovl01_2179750
ovl01_2179750: // 0x02179750
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #8
	mov r5, r0
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r4, [r5, r0]
	add r0, r0, #4
	add r6, r5, r0
	bl Camera3D__GetWork
	mov r1, #0xf1
	lsl r1, r1, #2
	mov r2, #0xf
	ldrsh r3, [r4, r1]
	mvn r2, r2
	add r0, #0x5c
	cmp r3, r2
	beq _0217979A
	mov r2, r1
	add r2, #0x3e
	ldrh r2, [r6, r2]
	add r3, r2, #1
	mov r2, r1
	add r2, #0x3e
	strh r3, [r6, r2]
	mov r2, r1
	add r2, #0x3e
	ldrh r2, [r6, r2]
	cmp r2, #1
	bls _0217979A
	mov r2, r1
	mov r3, #0
	add r2, #0x3e
	strh r3, [r6, r2]
	ldrsh r2, [r4, r1]
	sub r2, r2, #1
	strh r2, [r4, r1]
_0217979A:
	ldrh r1, [r0, #0x24]
	cmp r1, #0x10
	bhs _021797BA
	mov r1, #1
	lsl r1, r1, #0xa
	ldrh r2, [r6, r1]
	add r2, r2, #1
	strh r2, [r6, r1]
	ldrh r2, [r6, r1]
	cmp r2, #2
	bls _021797BA
	mov r2, #0
	strh r2, [r6, r1]
	ldrh r1, [r0, #0x24]
	add r1, r1, #1
	strh r1, [r0, #0x24]
_021797BA:
	mov r0, r5
	bl ovl01_217953C
	ldr r4, _02179828 // =BossArena__explosionFXSpawnTime
	mov r7, #0
_021797C4:
	ldr r0, _0217982C // =0x00000408
	ldrh r1, [r6, r0]
	ldr r0, [r4, #0]
	cmp r1, r0
	bne _0217980A
	ldr r1, _02179830 // =0x000007E4
	ldr r2, _02179834 // =0x000007E8
	ldr r3, _02179838 // =0x000007EC
	ldr r1, [r5, r1]
	ldr r2, [r5, r2]
	ldr r3, [r5, r3]
	mov r0, #0
	bl BossFX__CreateWhaleExplode0
	mov r0, #0
	str r0, [sp]
	mov r0, #0xcd
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	sub r2, r0, #1
	sub r3, r0, #1
	bl PlaySfxEx
	mov r1, #2
	ldr r0, _0217983C // =0x00000103
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	mov r0, #3
	lsl r0, r0, #0xc
	mov r1, r0
	lsr r2, r0, #3
	bl ShakeScreenEx
_0217980A:
	add r7, r7, #1
	add r4, r4, #4
	cmp r7, #3
	blt _021797C4
	ldr r0, _0217982C // =0x00000408
	ldrh r2, [r6, r0]
	add r1, r2, #1
	strh r1, [r6, r0]
	cmp r2, #0xd2
	bls _02179824
	ldr r1, _02179840 // =ovl01_2179848
	ldr r0, _02179844 // =0x00000784
	str r1, [r5, r0]
_02179824:
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02179828: .word BossArena__explosionFXSpawnTime
_0217982C: .word 0x00000408
_02179830: .word 0x000007E4
_02179834: .word 0x000007E8
_02179838: .word 0x000007EC
_0217983C: .word 0x00000103
_02179840: .word ovl01_2179848
_02179844: .word 0x00000784
	thumb_func_end ovl01_2179750

	thumb_func_start ovl01_2179848
ovl01_2179848: // 0x02179848
	push {r3, r4, r5, lr}
	sub sp, #8
	ldr r3, _021798CC // =0x000007E4
	mov r5, r0
	mov r0, #0xdd
	add r2, r3, #4
	ldr r1, [r5, r3]
	add r3, #8
	lsl r0, r0, #2
	ldr r4, [r5, r0]
	ldr r2, [r5, r2]
	ldr r3, [r5, r3]
	mov r0, #0
	bl BossFX__CreateWhaleExplode1
	mov r1, #2
	lsl r1, r1, #0xe
	str r1, [r0, #0x38]
	str r1, [r0, #0x3c]
	str r1, [r0, #0x40]
	mov r1, #0xa
	ldr r2, _021798D0 // =0x00000555
	lsl r1, r1, #6
	str r2, [r0, r1]
	sub r1, #0xf4
	add r0, r0, r1
	ldr r3, _021798D4 // =FX_SinCosTable_+0x00000540
	mov r1, #0x14
	mov r2, #0x16
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	bl MTX_RotX33_
	mov r0, #0xa
	mov r1, #3
	lsl r0, r0, #0xc
	lsl r1, r1, #0xc
	mov r2, #0xe3
	bl ShakeScreenEx
	mov r0, #0
	str r0, [sp]
	mov r1, #0x8d
	str r1, [sp, #4]
	sub r1, #0x8e
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r1, #1
	ldr r0, _021798D8 // =0x00000524
	lsl r1, r1, #0xc
	str r1, [r4, r0]
	mov r1, #0x1e
	mov r0, #0
	lsl r1, r1, #6
	strh r0, [r5, r1]
	add r0, r1, #4
	ldr r2, _021798DC // =ovl01_21798E0
	add r1, r1, #4
	str r2, [r5, r0]
	ldr r1, [r5, r1]
	mov r0, r5
	blx r1
	add sp, #8
	pop {r3, r4, r5, pc}
	.align 2, 0
_021798CC: .word 0x000007E4
_021798D0: .word 0x00000555
_021798D4: .word FX_SinCosTable_+0x00000540
_021798D8: .word 0x00000524
_021798DC: .word ovl01_21798E0
	thumb_func_end ovl01_2179848

	thumb_func_start ovl01_21798E0
ovl01_21798E0: // 0x021798E0
	push {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	mov r0, #0xdd
	lsl r0, r0, #2
	ldr r7, [r6, r0]
	add r0, r0, #4
	add r4, r6, r0
	bl Camera3D__GetWork
	mov r1, #0xf1
	lsl r1, r1, #2
	mov r5, #0
	ldrsh r2, [r7, r1]
	str r5, [sp]
	cmp r2, #0
	beq _02179906
	add r2, r2, #1
	strh r2, [r7, r1]
	b _0217990A
_02179906:
	mov r1, #1
	str r1, [sp]
_0217990A:
	mov r7, #0x58
	ldrsh r1, [r0, r7]
	cmp r1, #0x10
	bge _02179946
	ldr r2, _02179968 // =0x00000408
	ldrh r1, [r4, r2]
	cmp r1, #0xb4
	bls _02179948
	sub r1, r2, #2
	ldrh r1, [r4, r1]
	add r3, r1, #1
	sub r1, r2, #2
	strh r3, [r4, r1]
	ldrh r1, [r4, r1]
	cmp r1, #3
	bls _02179948
	ldrsh r1, [r0, r7]
	add r3, r1, #1
	mov r1, r0
	add r1, #0x58
	strh r3, [r1]
	mov r1, #0xb4
	ldrsh r1, [r0, r1]
	add r0, #0xb4
	add r1, r1, #1
	strh r1, [r0]
	mov r1, #0
	sub r0, r2, #2
	strh r1, [r4, r0]
	b _02179948
_02179946:
	mov r5, #1
_02179948:
	mov r0, r6
	bl ovl01_217953C
	ldr r0, _02179968 // =0x00000408
	ldrh r1, [r4, r0]
	add r1, r1, #1
	strh r1, [r4, r0]
	ldr r0, [sp]
	cmp r0, #0
	beq _02179966
	cmp r5, #0
	beq _02179966
	ldr r1, _0217996C // =ovl01_2179974
	ldr r0, _02179970 // =0x00000784
	str r1, [r6, r0]
_02179966:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02179968: .word 0x00000408
_0217996C: .word ovl01_2179974
_02179970: .word 0x00000784
	thumb_func_end ovl01_21798E0

	thumb_func_start ovl01_2179974
ovl01_2179974: // 0x02179974
	ldr r1, _02179980 // =playerGameStatus
	mov r0, #4
	ldr r2, [r1, #0]
	orr r0, r2
	str r0, [r1]
	bx lr
	.align 2, 0
_02179980: .word playerGameStatus
	thumb_func_end ovl01_2179974

	.rodata
	
_0217A138: // 0x0217A138
    .word 0xB4012C
	
_0217A13C: // 0x0217A13C
    .word 0x15102A3
	
_0217A140: // 0x0217A140
    .word 0x3C00B4, 0x1000
	
_0217A148: // 0x0217A148
    .hword 0x7B

_0217A14A: // 0x0217A14A
    .hword 0x28

_0217A14C: // 0x0217A14C
    .hword 0x67

_0217A14E: // 0x0217A14E
    .hword 0x28

_0217A150: // 0x0217A150
    .hword 0xA0

_0217A152: // 0x0217A152
    .hword 0x24

_0217A154: // 0x0217A154
    .hword 0x95

_0217A156: // 0x0217A156
    .hword 0x24

_0217A158: // 0x0217A158
    .byte 8, 7, 8, 7, 8, 7, 8, 7, 8, 7, 8, 7

_0217A164: // 0x0217A164
    .byte 0, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0

_0217A170: // 0x0217A170
    .word 0, 0x1000

_0217A178: // 0x0217A178
    .word 0

_0217A17C: // 0x0217A17C
    .word 0, 0x1000

_0217A184: // 0x0217A184
    .word 0
	.word 0
	.word 0x1000
	.word 0

_0217A194: // 0x0217A194
    .word 0x1A401E0, 0x1680168, 0xF0012C
	
_0217A1A0: // 0x0217A1A0
    .word 0x30078, 0x3C001E, 0x1E0003

_0217A1AC: // 0x0217A1AC
    .word 0x9600B4, 0x780078, 0x3C005A
	
_0217A1B8: // 0x0217A1B8
    .word 0x1000
	
_0217A1BC: // 0x0217A1BC
    .word 0x1800, 0x2000, 0x2800
	
_0217A1C8: // 0x0217A1C8
    .word 0x1000, 0x1800, 0x2000, 0x2800
	
_0217A1D8: // 0x0217A1D8
    .word 0x20002, 0x10001, 0, 0x30003, 0x20002, 0x10001

_0217A1F0: // 0x0217A1F0
    .word 0x149FB0, 0x107FC0, 0xC5FD0, 0x83FE0, 0x41FF0, 0
	
_0217A208: // 0x0217A208
    .word 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0

	.data

aZ5HandPl: // 0x0217AE14
    .asciz "z5_hand_pl"
    .align 4

aZ5HeadPl: // 0x0217AE20
    .asciz "z5_head_pl"
    .align 4

aZ5BodyPl: // 0x0217AE2C
    .asciz "z5_body_pl"
    .align 4

aZ5WeekPl: // 0x0217AE38
    .asciz "z5_week_pl"
    .align 4

aZ5TailPl: // 0x0217AE44
    .asciz "z5_tail_pl"
    .align 4

aZ5SidePl: // 0x0217AE50
    .asciz "z5_side_pl"
    .align 4

aZ5FacePl: // 0x0217AE5C
    .asciz "z5_face_pl"
    .align 4

aZ5JointPl: // 0x0217AE68
    .asciz "z5_joint_pl"
    .align 4

aZ5MousePl: // 0x0217AE74
    .asciz "z5_mouse_pl"
    .align 4

aZ5BackAPl: // 0x0217AE80
    .asciz "z5_back_a_pl"
    .align 4

aZ5SideToPl: // 0x0217AE90
    .asciz "z5_side_to_pl"
    .align 4

aZ5ToothAPl: // 0x0217AEA0
    .asciz "z5_tooth_a_pl"
    .align 4

aZ5TailTopPl: // 0x0217AEB0
    .asciz "z5_tail_top_pl"
    .align 4

_0217AEC0: // 0x0217AEC0
    .word aZ5BackAPl 	// "z5_back_a_pl"
	.word aZ5BodyPl		// "z5_body_pl"
	.word aZ5FacePl		// "z5_face_pl"

_0217AECC: // 0x0217AECC
    .word aZ5HandPl 		  // "z5_hand_pl"
	.word aZ5HeadPl           // "z5_head_pl"
	.word aZ5JointPl          // "z5_joint_pl"
	.word aZ5MousePl          // "z5_mouse_pl"
	.word aZ5SidePl           // "z5_side_pl"
	.word aZ5SideToPl         // "z5_side_to_pl"
	.word aZ5TailPl           // "z5_tail_pl"
	.word aZ5TailTopPl        // "z5_tail_top_pl"
	.word aZ5ToothAPl         // "z5_tooth_a_pl"
	.word aZ5WeekPl           // "z5_week_pl"

_0217AEF4: // 0x0217AEF4
    .word 0
	
aBoss5Nsbta: // 0x0217AEF8
    .asciz "/boss5.nsbta"
    .align 4

aBoss5Nsbca: // 0x0217AF08
    .asciz "/boss5.nsbca"
    .align 4

aBodyWeak: // 0x0217AF18
    .asciz "body_weak"
    .align 4

aBodyCenter: // 0x0217AF24
    .asciz "body_center"
    .align 4

aExc_6: // 0x0217AF30
    .asciz "exc"
    .align 4

aBoss5Nsbma: // 0x0217AF34
    .asciz "/boss5.nsbma"
    .align 4

aBoss5Nsbva: // 0x0217AF44
    .asciz "/boss5.nsbva"
    .align 4