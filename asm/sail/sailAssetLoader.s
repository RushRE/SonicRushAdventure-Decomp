	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailAssetLoader__LoadSprite3D
SailAssetLoader__LoadSprite3D: // 0x02153814
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x110
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl SailManager__GetArchive
	mov r9, r0
	mov r0, r6
	mov r1, r9
	bl ObjDataSearchArchive
	mov r1, r4
	bl Sprite__GetTextureSizeFromAnim
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	mov r0, r6
	mov r1, r9
	bl ObjDataSearchArchive
	mov r1, r4
	bl Sprite__GetPaletteSizeFromAnim
	mov r8, r0
	mov r0, r5
	bl GetObjectFileWork
	mov r1, r7
	bl ObjActionAllocTexture
	mov r7, r0
	add r0, r5, #1
	bl GetObjectFileWork
	mov r1, r8
	bl ObjActionAllocPalette
	mov r5, r0
	mov r1, r9
	mov r0, r6
	bl ObjDataSearchArchive
	mov r1, #0
	stmia sp, {r1, r7}
	mov r2, r0
	mov r3, r4
	add r0, sp, #0xc
	str r5, [sp, #8]
	bl AnimatorSprite3D__Init
	mov r1, #0
	add r0, sp, #0xc
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	add sp, sp, #0x110
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end SailAssetLoader__LoadSprite3D

	arm_func_start SailAssetLoader__ReleaseSprite3D
SailAssetLoader__ReleaseSprite3D: // 0x021538CC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x104
	mov r4, r0
	add r0, sp, #0
	mov r1, #0
	mov r2, #0x104
	bl MI_CpuFill8
	mov r1, #3
	mov r0, r4
	str r1, [sp]
	bl GetObjectFileWork
	ldr r1, [r0]
	add r0, r4, #1
	str r1, [sp, #0xd4]
	bl GetObjectFileWork
	ldr r1, [r0]
	mov r0, r4
	str r1, [sp, #0xdc]
	bl GetObjectFileWork
	mov r1, r0
	add r0, sp, #0
	bl ObjActionReleaseTexture
	add r0, r4, #1
	bl GetObjectFileWork
	mov r1, r0
	add r0, sp, #0
	bl ObjActionReleaseTexture
	add sp, sp, #0x104
	ldmia sp!, {r3, r4, pc}
	arm_func_end SailAssetLoader__ReleaseSprite3D

	arm_func_start SailAssetLoader__Create
SailAssetLoader__Create: // 0x02153940
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	bl SailManager__GetArchive
	mov r1, #0x4800
	str r1, [sp]
	mov r1, #4
	mov r4, r0
	mov r0, #0
	str r1, [sp, #4]
	ldr r1, _02153E48 // =SailAssetLoader__Destructor
	mov r2, r0
	mov r3, r0
	str r0, [sp, #8]
	bl TaskCreate_
	ldr r0, _02153E4C // =aSbWater00Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E50 // =aSbWater01Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E54 // =aSbWater02Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E58 // =aSbStoneNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E5C // =aSbGoalNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	bl SailManager__GetShipType
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02153D84
_021539D8: // jump table
	b _021539E8 // case 0
	b _02153AEC // case 1
	b _02153BF0 // case 2
	b _02153D04 // case 3
_021539E8:
	ldr r0, _02153E60 // =aSbJetNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E64 // =aSbJohNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E68 // =aSbBobNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E6C // =aSbSharkNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E70 // =aSbBirdNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E74 // =aSbBoost01Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E78 // =aSbBoost02Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E7C // =aSbJumpNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E80 // =aSbDashNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E84 // =aSbTrickNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E88 // =aSbSeagullNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E8C // =aSbCircleNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E90 // =aSbBuoyNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E94 // =aSbIceNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E98 // =aSbChaosNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E9C // =aSbTorpedoNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	b _02153D84
_02153AEC:
	ldr r0, _02153EA0 // =aSbSailerNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EA4 // =aSbSBoat01Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EA8 // =aSbSBoat02Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EAC // =aSbSBoat03Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EB0 // =aSbBigbob01Nsbm
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EB4 // =aSbBigbob02Nsbm
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EB8 // =aSbCruiserNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EBC // =aSbCruiser02Nsb
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E70 // =aSbBirdNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E9C // =aSbTorpedoNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EC0 // =aSbMissileNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E88 // =aSbSeagullNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E90 // =aSbBuoyNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E94 // =aSbIceNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EC4 // =aSbFlashNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EC8 // =aSbBazookaNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	b _02153D84
_02153BF0:
	ldr r0, _02153ECC // =aSbHoverNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E68 // =aSbBobNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E6C // =aSbSharkNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E70 // =aSbBirdNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E84 // =aSbTrickNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E88 // =aSbSeagullNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E90 // =aSbBuoyNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E94 // =aSbIceNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E9C // =aSbTorpedoNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153ED0 // =aSbSHover1Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153ED4 // =aSbSHover2Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153ED8 // =aSbWater09Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EA4 // =aSbSBoat01Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EA8 // =aSbSBoat02Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EDC // =aSbBullet1Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EE0 // =aSbBullet2Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	mov r1, r4
	ldr r0, _02153EE4 // =aSbBullet3Nsbmd
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	b _02153D84
_02153D04:
	ldr r0, _02153EE8 // =aSbSubmarineNsb
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EEC // =aSbSubWaterNsbm
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EA8 // =aSbSBoat02Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EF0 // =aSbSDepthNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EF4 // =aSbBSharkNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153E9C // =aSbTorpedoNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	ldr r0, _02153EF8 // =aSbSubFishNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
	mov r1, r4
	ldr r0, _02153E90 // =aSbBuoyNsbmd
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultSetup
_02153D84:
	ldr r0, _02153EFC // =aSbMineBac
	mov r1, #0x36
	mov r2, #0
	bl SailAssetLoader__LoadSprite3D
	ldr r4, _02153F00 // =aSbCloudBac
	mov r5, #0
_02153D9C:
	mov r0, r5, lsl #1
	add r0, r0, #0x38
	mov r1, r0, lsl #0x10
	mov r0, r4
	mov r2, r5
	mov r1, r1, asr #0x10
	bl SailAssetLoader__LoadSprite3D
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #3
	blo _02153D9C
	bl SailManager__GetShipType
	cmp r0, #1
	beq _02153DE8
	cmp r0, #2
	beq _02153E20
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
_02153DE8:
	ldr r0, _02153F04 // =aSbShellBac
	mov r1, #0x3e
	mov r2, #0
	bl SailAssetLoader__LoadSprite3D
	ldr r0, _02153F04 // =aSbShellBac
	mov r1, #0x40
	mov r2, #1
	bl SailAssetLoader__LoadSprite3D
	ldr r0, _02153F08 // =aSbFireBac
	mov r1, #0x6b
	mov r2, #0
	bl SailAssetLoader__LoadSprite3D
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
_02153E20:
	ldr r0, _02153F04 // =aSbShellBac
	mov r1, #0x3e
	mov r2, #0
	bl SailAssetLoader__LoadSprite3D
	ldr r0, _02153F04 // =aSbShellBac
	mov r1, #0x40
	mov r2, #1
	bl SailAssetLoader__LoadSprite3D
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02153E48: .word SailAssetLoader__Destructor
_02153E4C: .word aSbWater00Nsbmd
_02153E50: .word aSbWater01Nsbmd
_02153E54: .word aSbWater02Nsbmd
_02153E58: .word aSbStoneNsbmd
_02153E5C: .word aSbGoalNsbmd
_02153E60: .word aSbJetNsbmd
_02153E64: .word aSbJohNsbmd
_02153E68: .word aSbBobNsbmd
_02153E6C: .word aSbSharkNsbmd
_02153E70: .word aSbBirdNsbmd
_02153E74: .word aSbBoost01Nsbmd
_02153E78: .word aSbBoost02Nsbmd
_02153E7C: .word aSbJumpNsbmd
_02153E80: .word aSbDashNsbmd
_02153E84: .word aSbTrickNsbmd
_02153E88: .word aSbSeagullNsbmd
_02153E8C: .word aSbCircleNsbmd
_02153E90: .word aSbBuoyNsbmd
_02153E94: .word aSbIceNsbmd
_02153E98: .word aSbChaosNsbmd
_02153E9C: .word aSbTorpedoNsbmd
_02153EA0: .word aSbSailerNsbmd
_02153EA4: .word aSbSBoat01Nsbmd
_02153EA8: .word aSbSBoat02Nsbmd
_02153EAC: .word aSbSBoat03Nsbmd
_02153EB0: .word aSbBigbob01Nsbm
_02153EB4: .word aSbBigbob02Nsbm
_02153EB8: .word aSbCruiserNsbmd
_02153EBC: .word aSbCruiser02Nsb
_02153EC0: .word aSbMissileNsbmd
_02153EC4: .word aSbFlashNsbmd
_02153EC8: .word aSbBazookaNsbmd
_02153ECC: .word aSbHoverNsbmd
_02153ED0: .word aSbSHover1Nsbmd
_02153ED4: .word aSbSHover2Nsbmd
_02153ED8: .word aSbWater09Nsbmd
_02153EDC: .word aSbBullet1Nsbmd
_02153EE0: .word aSbBullet2Nsbmd
_02153EE4: .word aSbBullet3Nsbmd
_02153EE8: .word aSbSubmarineNsb
_02153EEC: .word aSbSubWaterNsbm
_02153EF0: .word aSbSDepthNsbmd
_02153EF4: .word aSbBSharkNsbmd
_02153EF8: .word aSbSubFishNsbmd
_02153EFC: .word aSbMineBac
_02153F00: .word aSbCloudBac
_02153F04: .word aSbShellBac
_02153F08: .word aSbFireBac
	arm_func_end SailAssetLoader__Create

	arm_func_start SailAssetLoader__Destructor
SailAssetLoader__Destructor: // 0x02153F0C
	stmdb sp!, {r4, lr}
	bl SailManager__GetArchive
	mov r4, r0
	ldr r0, _021543A0 // =aSbWater00Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543A4 // =aSbWater01Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543A8 // =aSbWater02Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543AC // =aSbStoneNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543B0 // =aSbGoalNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	bl SailManager__GetShipType
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02154324
_02153F78: // jump table
	b _02153F88 // case 0
	b _0215408C // case 1
	b _02154190 // case 2
	b _021542A4 // case 3
_02153F88:
	ldr r0, _021543B4 // =aSbJetNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543B8 // =aSbJohNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543BC // =aSbBobNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543C0 // =aSbSharkNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543C4 // =aSbBirdNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543C8 // =aSbBoost01Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543CC // =aSbBoost02Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543D0 // =aSbJumpNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543D4 // =aSbDashNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543D8 // =aSbTrickNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543DC // =aSbSeagullNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543E0 // =aSbCircleNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543E4 // =aSbBuoyNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543E8 // =aSbIceNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543EC // =aSbChaosNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543F0 // =aSbTorpedoNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	b _02154324
_0215408C:
	ldr r0, _021543F4 // =aSbSailerNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543F8 // =aSbSBoat01Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543FC // =aSbSBoat02Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _02154400 // =aSbSBoat03Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _02154404 // =aSbBigbob01Nsbm
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _02154408 // =aSbBigbob02Nsbm
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _0215440C // =aSbCruiserNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _02154410 // =aSbCruiser02Nsb
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543C4 // =aSbBirdNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543F0 // =aSbTorpedoNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _02154414 // =aSbMissileNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543DC // =aSbSeagullNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543E4 // =aSbBuoyNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543E8 // =aSbIceNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _02154418 // =aSbFlashNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _0215441C // =aSbBazookaNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	b _02154324
_02154190:
	ldr r0, _02154420 // =aSbHoverNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543BC // =aSbBobNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543C0 // =aSbSharkNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543C4 // =aSbBirdNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543D8 // =aSbTrickNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543DC // =aSbSeagullNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543E4 // =aSbBuoyNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543E8 // =aSbIceNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543F0 // =aSbTorpedoNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _02154424 // =aSbSHover1Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _02154428 // =aSbSHover2Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _0215442C // =aSbWater09Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543F8 // =aSbSBoat01Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543FC // =aSbSBoat02Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _02154430 // =aSbBullet1Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _02154434 // =aSbBullet2Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _02154438 // =aSbBullet3Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	b _02154324
_021542A4:
	ldr r0, _0215443C // =aSbSubmarineNsb
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _02154440 // =aSbSubWaterNsbm
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543FC // =aSbSBoat02Nsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _02154444 // =aSbSDepthNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _02154448 // =aSbBSharkNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _021543F0 // =aSbTorpedoNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	ldr r0, _0215444C // =aSbSubFishNsbmd
	mov r1, r4
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
	mov r1, r4
	ldr r0, _021543E4 // =aSbBuoyNsbmd
	bl ObjDataSearchArchive
	bl NNS_G3dResDefaultRelease
_02154324:
	mov r0, #0x36
	bl SailAssetLoader__ReleaseSprite3D
	mov r4, #0
_02154330:
	mov r0, r4, lsl #1
	add r0, r0, #0x38
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	bl SailAssetLoader__ReleaseSprite3D
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	cmp r4, #3
	blo _02154330
	bl SailManager__GetShipType
	cmp r0, #1
	beq _02154370
	cmp r0, #2
	beq _0215438C
	ldmia sp!, {r4, pc}
_02154370:
	mov r0, #0x3e
	bl SailAssetLoader__ReleaseSprite3D
	mov r0, #0x40
	bl SailAssetLoader__ReleaseSprite3D
	mov r0, #0x6b
	bl SailAssetLoader__ReleaseSprite3D
	ldmia sp!, {r4, pc}
_0215438C:
	mov r0, #0x3e
	bl SailAssetLoader__ReleaseSprite3D
	mov r0, #0x40
	bl SailAssetLoader__ReleaseSprite3D
	ldmia sp!, {r4, pc}
	.align 2, 0
_021543A0: .word aSbWater00Nsbmd
_021543A4: .word aSbWater01Nsbmd
_021543A8: .word aSbWater02Nsbmd
_021543AC: .word aSbStoneNsbmd
_021543B0: .word aSbGoalNsbmd
_021543B4: .word aSbJetNsbmd
_021543B8: .word aSbJohNsbmd
_021543BC: .word aSbBobNsbmd
_021543C0: .word aSbSharkNsbmd
_021543C4: .word aSbBirdNsbmd
_021543C8: .word aSbBoost01Nsbmd
_021543CC: .word aSbBoost02Nsbmd
_021543D0: .word aSbJumpNsbmd
_021543D4: .word aSbDashNsbmd
_021543D8: .word aSbTrickNsbmd
_021543DC: .word aSbSeagullNsbmd
_021543E0: .word aSbCircleNsbmd
_021543E4: .word aSbBuoyNsbmd
_021543E8: .word aSbIceNsbmd
_021543EC: .word aSbChaosNsbmd
_021543F0: .word aSbTorpedoNsbmd
_021543F4: .word aSbSailerNsbmd
_021543F8: .word aSbSBoat01Nsbmd
_021543FC: .word aSbSBoat02Nsbmd
_02154400: .word aSbSBoat03Nsbmd
_02154404: .word aSbBigbob01Nsbm
_02154408: .word aSbBigbob02Nsbm
_0215440C: .word aSbCruiserNsbmd
_02154410: .word aSbCruiser02Nsb
_02154414: .word aSbMissileNsbmd
_02154418: .word aSbFlashNsbmd
_0215441C: .word aSbBazookaNsbmd
_02154420: .word aSbHoverNsbmd
_02154424: .word aSbSHover1Nsbmd
_02154428: .word aSbSHover2Nsbmd
_0215442C: .word aSbWater09Nsbmd
_02154430: .word aSbBullet1Nsbmd
_02154434: .word aSbBullet2Nsbmd
_02154438: .word aSbBullet3Nsbmd
_0215443C: .word aSbSubmarineNsb
_02154440: .word aSbSubWaterNsbm
_02154444: .word aSbSDepthNsbmd
_02154448: .word aSbBSharkNsbmd
_0215444C: .word aSbSubFishNsbmd
	arm_func_end SailAssetLoader__Destructor

	.data
aSbWater00Nsbmd: // 0x0218C9CC
	.asciz "sb_water00.nsbmd"
    .align 4

aSbWater01Nsbmd: // 0x0218C9E0
	.asciz "sb_water01.nsbmd"
    .align 4

aSbWater02Nsbmd: // 0x0218C9F4
	.asciz "sb_water02.nsbmd"
    .align 4

aSbStoneNsbmd: // 0x0218CA08
	.asciz "sb_stone.nsbmd"
    .align 4

aSbGoalNsbmd: // 0x0218CA18
	.asciz "sb_goal.nsbmd"
    .align 4

aSbJetNsbmd: // 0x0218CA28
	.asciz "sb_jet.nsbmd"
    .align 4

aSbJohNsbmd: // 0x0218CA38
	.asciz "sb_joh.nsbmd"
    .align 4

aSbBobNsbmd: // 0x0218CA48
	.asciz "sb_bob.nsbmd"
    .align 4

aSbSharkNsbmd: // 0x0218CA58
	.asciz "sb_shark.nsbmd"
    .align 4

aSbBirdNsbmd: // 0x0218CA68
	.asciz "sb_bird.nsbmd"
    .align 4

aSbBoost01Nsbmd: // 0x0218CA78
	.asciz "sb_boost01.nsbmd"
    .align 4

aSbBoost02Nsbmd: // 0x0218CA8C
	.asciz "sb_boost02.nsbmd"
    .align 4

aSbJumpNsbmd: // 0x0218CAA0
	.asciz "sb_jump.nsbmd"
    .align 4

aSbDashNsbmd: // 0x0218CAB0
	.asciz "sb_dash.nsbmd"
    .align 4

aSbTrickNsbmd: // 0x0218CAC0
	.asciz "sb_trick.nsbmd"
    .align 4

aSbSeagullNsbmd: // 0x0218CAD0
	.asciz "sb_seagull.nsbmd"
    .align 4

aSbCircleNsbmd: // 0x0218CAE4
	.asciz "sb_circle.nsbmd"
    .align 4

aSbBuoyNsbmd: // 0x0218CAF4
	.asciz "sb_buoy.nsbmd"
    .align 4

aSbIceNsbmd: // 0x0218CB04
	.asciz "sb_ice.nsbmd"
    .align 4

aSbChaosNsbmd: // 0x0218CB14
	.asciz "sb_chaos.nsbmd"
    .align 4

aSbTorpedoNsbmd: // 0x0218CB24
	.asciz "sb_torpedo.nsbmd"
    .align 4

aSbSailerNsbmd: // 0x0218CB38
	.asciz "sb_sailer.nsbmd"
    .align 4

aSbSBoat01Nsbmd: // 0x0218CB48
	.asciz "sb_s_boat01.nsbmd"
    .align 4

aSbSBoat02Nsbmd: // 0x0218CB5C
	.asciz "sb_s_boat02.nsbmd"
    .align 4

aSbSBoat03Nsbmd: // 0x0218CB70
	.asciz "sb_s_boat03.nsbmd"
    .align 4

aSbBigbob01Nsbm: // 0x0218CB84
	.asciz "sb_bigbob01.nsbmd"
    .align 4

aSbBigbob02Nsbm: // 0x0218CB98
	.asciz "sb_bigbob02.nsbmd"
    .align 4

aSbCruiserNsbmd: // 0x0218CBAC
	.asciz "sb_cruiser.nsbmd"
    .align 4

aSbCruiser02Nsb: // 0x0218CBC0
	.asciz "sb_cruiser02.nsbmd"
	.align 4

aSbMissileNsbmd: // 0x0218CBD4
	.asciz "sb_missile.nsbmd"
	.align 4

aSbFlashNsbmd: // 0x0218CBE8
	.asciz "sb_flash.nsbmd"
	.align 4

aSbBazookaNsbmd: // 0x0218CBF8
	.asciz "sb_bazooka.nsbmd"
	.align 4

aSbHoverNsbmd: // 0x0218CC0C
	.asciz "sb_hover.nsbmd"
	.align 4

aSbSHover1Nsbmd: // 0x0218CC1C
	.asciz "sb_s_hover1.nsbmd"
	.align 4

aSbSHover2Nsbmd: // 0x0218CC30
	.asciz "sb_s_hover2.nsbmd"
	.align 4

aSbWater09Nsbmd: // 0x0218CC44
	.asciz "sb_water09.nsbmd"
	.align 4

aSbBullet1Nsbmd: // 0x0218CC58
	.asciz "sb_bullet1.nsbmd"
	.align 4

aSbBullet2Nsbmd: // 0x0218CC6C
	.asciz "sb_bullet2.nsbmd"
	.align 4

aSbBullet3Nsbmd: // 0x0218CC80
	.asciz "sb_bullet3.nsbmd"
	.align 4

aSbSubmarineNsb: // 0x0218CC94
	.asciz "sb_submarine.nsbmd"
    .align 4

aSbSubWaterNsbm: // 0x0218CCA8
	.asciz "sb_sub_water.nsbmd"
	.align 4

aSbSDepthNsbmd: // 0x0218CCBC
	.asciz "sb_s_depth.nsbmd"
	.align 4

aSbBSharkNsbmd: // 0x0218CCD0
	.asciz "sb_b_shark.nsbmd"
	.align 4

aSbSubFishNsbmd: // 0x0218CCE4
	.asciz "sb_sub_fish.nsbmd"
	.align 4

aSbMineBac: // 0x0218CCF8
	.asciz "sb_mine.bac"
	.align 4

aSbCloudBac: // 0x0218CD04
	.asciz "sb_cloud.bac"
	.align 4

aSbShellBac: // 0x0218CD14
	.asciz "sb_shell.bac"
	.align 4

aSbFireBac: // 0x0218CD24
	.asciz "sb_fire.bac"
    .align 4