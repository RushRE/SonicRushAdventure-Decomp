	.include "asm/macros.inc"
	.include "global.inc"

	.public _02161514

	.bss

StageClearEx__Singleton: // 0x02162E80
    .space 0x04 // Task*

	.text

thumb_func_start StageClearEx__Create
StageClearEx__Create: // 0x02153CBC
	push {lr}
	sub sp, #0xc
	mov r0, #1
	str r0, [sp]
	mov r2, #0
	ldr r0, _02153CE8 // =0x00001178
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02153CEC // =StageClearEx__Main
	ldr r1, _02153CF0 // =StageClearEx__Destructor
	mov r3, r2
	blx TaskCreate_
	ldr r1, _02153CF4 // =StageClearEx__Singleton
	str r0, [r1]
	blx GetTaskWork_
	bl StageClearEx__Func_2153D64
	add sp, #0xc
	pop {pc}
	nop
_02153CE8: .word 0x00001178
_02153CEC: .word StageClearEx__Main
_02153CF0: .word StageClearEx__Destructor
_02153CF4: .word StageClearEx__Singleton
	thumb_func_end StageClearEx__Create

	thumb_func_start StageClearEx__Destructor
StageClearEx__Destructor: // 0x02153CF8
	ldr r0, _02153D00 // =StageClearEx__Singleton
	mov r1, #0
	str r1, [r0]
	bx lr
	.align 2, 0
_02153D00: .word StageClearEx__Singleton
	thumb_func_end StageClearEx__Destructor

	thumb_func_start StageClearEx__SetState
StageClearEx__SetState: // 0x02153D04
	mov r2, #0
	str r2, [r0, #0xc]
	str r1, [r0, #8]
	bx lr
	thumb_func_end StageClearEx__SetState

	thumb_func_start Task__Unknown2153D0C__Create
Task__Unknown2153D0C__Create: // 0x02153D0C
	push {r3, r4, lr}
	sub sp, #0xc
	mov r4, r0
	mov r1, #0
	mov r0, #0x61
	str r0, [sp]
	ldr r0, _02153D30 // =0x00001178
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02153D34 // =Task__Unknown2153D0C__Main
	mov r2, r1
	mov r3, r1
	blx TaskCreate_
	str r0, [r4]
	add sp, #0xc
	pop {r3, r4, pc}
	nop
_02153D30: .word 0x00001178
_02153D34: .word Task__Unknown2153D0C__Main
	thumb_func_end Task__Unknown2153D0C__Create

	thumb_func_start Task__Unknown2153D38__Create
Task__Unknown2153D38__Create: // 0x02153D38
	push {r3, r4, lr}
	sub sp, #0xc
	mov r4, r0
	mov r1, #0
	mov r0, #0x81
	str r0, [sp]
	ldr r0, _02153D5C // =0x00001178
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02153D60 // =Task__Unknown2153D38__Main
	mov r2, r1
	mov r3, r1
	blx TaskCreate_
	str r0, [r4, #4]
	add sp, #0xc
	pop {r3, r4, pc}
	nop
_02153D5C: .word 0x00001178
_02153D60: .word Task__Unknown2153D38__Main
	thumb_func_end Task__Unknown2153D38__Create

	thumb_func_start StageClearEx__Func_2153D64
StageClearEx__Func_2153D64: // 0x02153D64
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r2, _02153DFC // =0x00001178
	mov r0, #0
	mov r1, r5
	blx MIi_CpuClear32
	mov r2, #1
	lsl r2, r2, #0x1a
	ldr r1, [r2]
	ldr r0, _02153E00 // =0xFFFFE0FF
	and r1, r0
	str r1, [r2]
	ldr r2, _02153E04 // =0x04001000
	ldr r1, [r2]
	and r0, r1
	str r0, [r2]
	mov r0, #1
	mov r1, #0
	mov r2, r0
	blx GX_SetGraphicsMode
	mov r0, #0
	blx GXS_SetGraphicsMode
	blx VRAMSystem__Reset
	mov r0, #3
	blx VRAMSystem__SetupTextureBank
	mov r0, #0x40
	blx VRAMSystem__SetupTexturePalBank
	mov r0, #0x20
	blx VRAMSystem__SetupBGBank
	mov r0, #1
	lsl r0, r0, #0xa
	str r0, [sp]
	ldr r1, _02153E08 // =0x00100010
	mov r0, #0x10
	mov r2, #0x40
	mov r3, #0
	blx VRAMSystem__SetupOBJBank
	mov r4, r5
	add r4, #0x14
	mov r0, r4
	bl StageClearEx__LoadArchives
	blx ReleaseAudioSystem
	mov r0, #0xf
	blx LoadSysSound
	mov r0, r5
	add r0, #0x1c
	mov r1, r4
	bl StageClearEx__Func_2153EA4
	ldr r0, _02153E0C // =0x00000958
	mov r1, r4
	add r0, r5, r0
	bl StageClearEx__Func_2154118
	mov r0, #1
	str r0, [r5, #0x10]
	mov r0, r5
	bl Task__Unknown2153D0C__Create
	ldr r1, _02153E10 // =StageClearEx__State_21548C0
	mov r0, r5
	bl StageClearEx__SetState
	pop {r3, r4, r5, pc}
	nop
_02153DFC: .word 0x00001178
_02153E00: .word 0xFFFFE0FF
_02153E04: .word 0x04001000
_02153E08: .word 0x00100010
_02153E0C: .word 0x00000958
_02153E10: .word StageClearEx__State_21548C0
	thumb_func_end StageClearEx__Func_2153D64

	thumb_func_start StageClearEx__Func_2153E14
StageClearEx__Func_2153E14: // 0x02153E14
	push {r4, lr}
	mov r4, r0
	ldr r0, [r4]
	cmp r0, #0
	beq _02153E22
	blx DestroyTask
_02153E22:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _02153E2C
	blx DestroyTask
_02153E2C:
	mov r0, #0
	str r0, [r4, #0x10]
	blx Camera3D__Destroy
	ldr r0, _02153E58 // =0x00000958
	add r0, r4, r0
	bl StageClearEx__Func_21543EC
	mov r0, r4
	add r0, #0x1c
	bl StageClearEx__Func_21540C4
	blx ReleaseSysSound
	add r4, #0x14
	mov r0, r4
	bl StageClearEx__Func_2153E90
	blx DestroyCurrentTask
	pop {r4, pc}
	nop
_02153E58: .word 0x00000958
	thumb_func_end StageClearEx__Func_2153E14

	thumb_func_start StageClearEx__LoadArchives
StageClearEx__LoadArchives: // 0x02153E5C
	push {r3, r4, lr}
	sub sp, #4
	mov r2, #0
	mov r4, r0
	ldr r0, _02153E88 // =aNarcPldm6700Lz
	str r2, [sp]
	sub r1, r2, #1
	mov r3, #1
	blx ArchiveFile__Load
	str r0, [r4]
	mov r2, #0
	ldr r0, _02153E8C // =aNarcCldmExLz7N
	sub r1, r2, #1
	mov r3, #1
	str r2, [sp]
	blx ArchiveFile__Load
	str r0, [r4, #4]
	add sp, #4
	pop {r3, r4, pc}
	nop
_02153E88: .word aNarcPldm6700Lz
_02153E8C: .word aNarcCldmExLz7N
	thumb_func_end StageClearEx__LoadArchives

	thumb_func_start StageClearEx__Func_2153E90
StageClearEx__Func_2153E90: // 0x02153E90
	push {r4, lr}
	mov r4, r0
	ldr r0, [r4, #4]
	blx _FreeHEAP_USER
	ldr r0, [r4]
	blx _FreeHEAP_USER
	pop {r4, pc}
	.align 2, 0
	thumb_func_end StageClearEx__Func_2153E90

	thumb_func_start StageClearEx__Func_2153EA4
StageClearEx__Func_2153EA4: // 0x02153EA4
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x20
	mov r5, r0
	mov r0, #1
	str r0, [sp]
	mov r0, r5
	add r0, #8
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	add r0, sp, #0x1c
	str r0, [sp, #0xc]
	mov r0, #0xb
	str r0, [sp, #0x10]
	mov r2, #0
	str r2, [sp, #0x14]
	ldr r0, [r1]
	mov r1, r5
	add r3, r5, #4
	bl StageClearEx__Func_21540A8
	ldr r0, [sp, #0x1c]
	ldr r1, _02154094 // =0x001FFFFF
	blx LoadDrawState
	ldr r0, _02154098 // =0x000008E8
	add r4, r5, r0
	ldr r0, [sp, #0x1c]
	mov r1, r4
	blx GetDrawStateCameraView
	ldr r0, [sp, #0x1c]
	mov r1, r4
	blx GetDrawStateCameraProjection
	ldr r4, [r4, #0x10]
	mov r2, #0x41
	asr r1, r4, #0x1f
	mov r0, r4
	lsl r2, r2, #2
	mov r3, #0
	blx _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	ldr r0, _0215409C // =0x00000938
	add r1, r4, r1
	str r1, [r5, r0]
	ldr r0, [r5, #8]
	ldr r6, [r5]
	str r0, [sp, #0x18]
	mov r0, r6
	ldr r7, [r5, #4]
	blx NNS_G3dResDefaultSetup
	mov r4, r5
	add r4, #0xc
	mov r0, r4
	mov r1, #0
	blx AnimatorMDL__Init
	mov r3, #0
	mov r0, r4
	mov r1, r6
	mov r2, #1
	str r3, [sp]
	blx AnimatorMDL__SetResource
	mov r1, #0
	mov r0, r4
	mov r2, r7
	mov r3, #0x26
	str r1, [sp]
	blx AnimatorMDL__SetAnimation
	mov r1, #0x43
	lsl r1, r1, #2
	ldrh r2, [r4, r1]
	mov r0, #2
	orr r0, r2
	strh r0, [r4, r1]
	add r1, #0x44
	add r4, r5, r1
	mov r0, r4
	mov r1, #0
	blx AnimatorMDL__Init
	mov r3, #0
	mov r0, r4
	mov r1, r6
	mov r2, #2
	str r3, [sp]
	blx AnimatorMDL__SetResource
	mov r1, #0
	mov r0, r4
	mov r2, r7
	mov r3, #0x27
	str r1, [sp]
	blx AnimatorMDL__SetAnimation
	mov r1, #0x43
	lsl r1, r1, #2
	ldrh r2, [r4, r1]
	mov r0, #2
	orr r0, r2
	strh r0, [r4, r1]
	mov r0, #0xa5
	lsl r0, r0, #2
	add r4, r5, r0
	mov r0, r4
	mov r1, #0
	blx AnimatorMDL__Init
	mov r3, #0
	mov r0, r4
	mov r1, r6
	mov r2, #0x10
	str r3, [sp]
	blx AnimatorMDL__SetResource
	mov r1, #0
	mov r0, r4
	mov r2, r7
	mov r3, #0x29
	str r1, [sp]
	blx AnimatorMDL__SetAnimation
	mov r1, #0x43
	lsl r1, r1, #2
	ldrh r2, [r4, r1]
	mov r0, #2
	orr r0, r2
	strh r0, [r4, r1]
	mov r0, #0xf6
	lsl r0, r0, #2
	add r4, r5, r0
	mov r0, r4
	mov r1, #0
	blx AnimatorMDL__Init
	mov r3, #0
	mov r0, r4
	mov r1, r6
	mov r2, #7
	str r3, [sp]
	blx AnimatorMDL__SetResource
	mov r1, #0
	mov r0, r4
	mov r2, r7
	mov r3, #0x28
	str r1, [sp]
	blx AnimatorMDL__SetAnimation
	mov r1, #0x43
	lsl r1, r1, #2
	ldrh r2, [r4, r1]
	mov r0, #2
	orr r0, r2
	strh r0, [r4, r1]
	ldr r0, _021540A0 // =0x0000051C
	mov r1, #0
	add r4, r5, r0
	mov r0, r4
	blx AnimatorMDL__Init
	mov r2, #0
	mov r0, r4
	mov r1, r6
	mov r3, r2
	str r2, [sp]
	blx AnimatorMDL__SetResource
	mov r1, #0
	mov r0, r4
	mov r2, r7
	mov r3, #0x25
	str r1, [sp]
	blx AnimatorMDL__SetAnimation
	mov r0, #0
	str r0, [sp]
	ldr r2, [sp, #0x18]
	mov r0, r4
	mov r1, #3
	mov r3, #0xc
	blx AnimatorMDL__SetAnimation
	mov r0, #0x43
	lsl r0, r0, #2
	ldrh r1, [r4, r0]
	mov r2, #2
	orr r1, r2
	strh r1, [r4, r0]
	add r1, r0, #6
	ldrh r1, [r4, r1]
	add r0, r0, #6
	orr r1, r2
	strh r1, [r4, r0]
	mov r4, #0x66
	lsl r4, r4, #4
	add r0, r5, r4
	mov r1, #0
	blx AnimatorMDL__Init
	mov r3, #0
	add r0, r5, r4
	mov r1, r6
	mov r2, #6
	str r3, [sp]
	blx AnimatorMDL__SetResource
	mov r1, #0
	add r0, r5, r4
	mov r2, r7
	mov r3, #0x2a
	str r1, [sp]
	blx AnimatorMDL__SetAnimation
	ldr r4, _021540A4 // =0x000007A4
	mov r1, #0
	add r0, r5, r4
	blx AnimatorMDL__Init
	mov r3, #0
	add r0, r5, r4
	mov r1, r6
	mov r2, #0x11
	str r3, [sp]
	blx AnimatorMDL__SetResource
	mov r1, #0
	add r0, r5, r4
	mov r2, r7
	mov r3, #0x2b
	str r1, [sp]
	blx AnimatorMDL__SetAnimation
	add sp, #0x20
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02154094: .word 0x001FFFFF
_02154098: .word 0x000008E8
_0215409C: .word 0x00000938
_021540A0: .word 0x0000051C
_021540A4: .word 0x000007A4
	thumb_func_end StageClearEx__Func_2153EA4

	thumb_func_start StageClearEx__Func_21540A8
StageClearEx__Func_21540A8: // 0x021540A8
	push {r0, r1, r2, r3}
	push {r3, lr}
	add r2, sp, #8
	mov r1, #3
	bic r2, r1
	ldr r0, [sp, #8]
	add r1, r2, #4
	blx ArchiveFile__LoadFiles
	pop {r3}
	pop {r3}
	add sp, #0x10
	bx r3
	.align 2, 0
	thumb_func_end StageClearEx__Func_21540A8

	thumb_func_start StageClearEx__Func_21540C4
StageClearEx__Func_21540C4: // 0x021540C4
	push {r4, lr}
	mov r4, r0
	add r0, #0xc
	blx AnimatorMDL__Release
	mov r0, #0x15
	lsl r0, r0, #4
	add r0, r4, r0
	blx AnimatorMDL__Release
	mov r0, #0xa5
	lsl r0, r0, #2
	add r0, r4, r0
	blx AnimatorMDL__Release
	mov r0, #0xf6
	lsl r0, r0, #2
	add r0, r4, r0
	blx AnimatorMDL__Release
	ldr r0, _02154110 // =0x0000051C
	add r0, r4, r0
	blx AnimatorMDL__Release
	mov r0, #0x66
	lsl r0, r0, #4
	add r0, r4, r0
	blx AnimatorMDL__Release
	ldr r0, _02154114 // =0x000007A4
	add r0, r4, r0
	blx AnimatorMDL__Release
	ldr r0, [r4]
	blx NNS_G3dResDefaultRelease
	pop {r4, pc}
	nop
_02154110: .word 0x0000051C
_02154114: .word 0x000007A4
	thumb_func_end StageClearEx__Func_21540C4

	thumb_func_start StageClearEx__Func_2154118
StageClearEx__Func_2154118: // 0x02154118
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x18
	mov r5, r0
	ldr r0, _021543B0 // =playerGameStatus
	mov r4, r1
	ldr r0, [r0, #0x1c]
	bl StageClearEx__CalcRingBonus
	ldr r1, _021543B4 // =0x00000808
	str r0, [r5, r1]
	ldr r0, _021543B0 // =playerGameStatus
	ldr r0, [r0, #0xc]
	bl StageClearEx__CalcTimeBonus
	ldr r1, _021543B8 // =0x0000080C
	str r0, [r5, r1]
	sub r0, r1, #4
	ldr r2, [r5, r0]
	ldr r0, [r5, r1]
	add r2, r2, r0
	add r0, r1, #4
	str r2, [r5, r0]
	mov r2, #0
	ldr r0, [r4, #4]
	add r1, sp, #0x14
	mov r3, r2
	bl StageClearEx__Func_21540A8
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0xa
	ldr r4, _021543BC // =0x00000528
	blx SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xe
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, _021543C0 // =0x00000804
	add r0, r5, r4
	mov r2, #0xa
	blx SpriteUnknown__Func_204C90C
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0xb
	add r4, #0x64
	blx SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xe
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, _021543C0 // =0x00000804
	add r0, r5, r4
	mov r2, #0xb
	blx SpriteUnknown__Func_204C90C
	mov r4, #0x3f
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0x17
	lsl r4, r4, #4
	blx SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xa
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, _021543C0 // =0x00000804
	add r0, r5, r4
	mov r2, #0x17
	blx SpriteUnknown__Func_204C90C
	ldr r4, _021543C4 // =0x0000051C
	mov r0, #0x9f
	add r1, r5, r4
	mvn r0, r0
	strh r0, [r1]
	mov r0, #0x84
	strh r0, [r1, #2]
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0x19
	sub r4, #0xc8
	blx SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xa
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, _021543C0 // =0x00000804
	add r0, r5, r4
	mov r2, #0x19
	blx SpriteUnknown__Func_204C90C
	mov r0, #0x52
	lsl r0, r0, #4
	add r1, r5, r0
	mov r0, #0x9f
	mvn r0, r0
	strh r0, [r1]
	mov r0, #0x98
	strh r0, [r1, #2]
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0x1b
	blx SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xa
	str r0, [sp, #0x10]
	ldr r0, _021543C8 // =0x000004B8
	ldr r1, [sp, #0x14]
	ldr r3, _021543C0 // =0x00000804
	add r0, r5, r0
	mov r2, #0x1b
	blx SpriteUnknown__Func_204C90C
	ldr r0, _021543CC // =0x00000524
	mov r6, r5
	add r1, r5, r0
	mov r0, #0x9f
	mvn r0, r0
	strh r0, [r1]
	mov r0, #0xac
	strh r0, [r1, #2]
	ldr r0, _021543D0 // =0x0000081C
	mov r1, #1
	str r1, [r5, r0]
	mov r4, #0
	add r6, #8
_02154252:
	lsl r0, r4, #0x10
	lsr r7, r0, #0x10
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, r7
	blx SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #5
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	mov r0, #0xc
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, _021543C0 // =0x00000804
	mov r0, r6
	mov r2, r7
	blx SpriteUnknown__Func_204C90C
	add r4, r4, #1
	add r6, #0x64
	cmp r4, #0xa
	blo _02154252
	ldr r0, [sp, #0x14]
	mov r4, #0x5f
	mov r1, #0
	mov r2, #0xc
	lsl r4, r4, #4
	blx SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #6
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, _021543C0 // =0x00000804
	add r0, r5, r4
	mov r2, #0xc
	blx SpriteUnknown__Func_204C90C
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0x21
	add r4, #0x64
	blx SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #4
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, _021543C0 // =0x00000804
	add r0, r5, r4
	mov r2, #0x21
	blx SpriteUnknown__Func_204C90C
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0x20
	ldr r4, _021543D4 // =0x000006B8
	blx SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #4
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, _021543C0 // =0x00000804
	add r0, r5, r4
	mov r2, #0x20
	blx SpriteUnknown__Func_204C90C
	mov r2, r4
	add r2, #0x68
	mov r1, #0
	ldr r3, _021543D8 // =0xFFFEA000
	str r1, [r5, r2]
	add r0, r2, #4
	str r3, [r5, r0]
	add r2, #0xc
	add r4, r5, r2
	ldr r0, [sp, #0x14]
	mov r2, #0xd
	blx SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #2
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xc
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, _021543DC // =0x00000805
	mov r0, r4
	mov r2, #0xd
	blx SpriteUnknown__Func_204C90C
	mov r0, #0xc0
	strh r0, [r4, #8]
	mov r0, #0x60
	strh r0, [r4, #0xa]
	mov r0, #0x81
	lsl r0, r0, #4
	ldr r1, [r5, r0]
	ldr r0, _021543E0 // =0x0000C350
	cmp r1, r0
	blo _0215434C
	mov r4, #0x1c
	b _02154362
_0215434C:
	ldr r0, _021543E4 // =0x00009C40
	cmp r1, r0
	blo _02154356
	mov r4, #0x1d
	b _02154362
_02154356:
	lsr r0, r0, #1
	cmp r1, r0
	blo _02154360
	mov r4, #0x1e
	b _02154362
_02154360:
	mov r4, #0x1f
_02154362:
	mov r0, #0x79
	lsl r0, r0, #4
	add r6, r5, r0
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, r4
	blx SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #3
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xa
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, _021543E8 // =0x00000A05
	mov r0, r6
	mov r2, r4
	blx SpriteUnknown__Func_204C90C
	mov r0, #0xc0
	strh r0, [r6, #8]
	mov r0, #0x60
	strh r0, [r6, #0xa]
	blx AllocSndHandle
	mov r1, #0x81
	str r0, [r5, #4]
	lsl r1, r1, #4
	sub r4, #0x1c
	ldr r1, [r5, r1]
	mov r0, #0x16
	mov r2, r4
	blx SaveGame__UpdateStageRecord
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021543B0: .word playerGameStatus
_021543B4: .word 0x00000808
_021543B8: .word 0x0000080C
_021543BC: .word 0x00000528
_021543C0: .word 0x00000804
_021543C4: .word 0x0000051C
_021543C8: .word 0x000004B8
_021543CC: .word 0x00000524
_021543D0: .word 0x0000081C
_021543D4: .word 0x000006B8
_021543D8: .word 0xFFFEA000
_021543DC: .word 0x00000805
_021543E0: .word 0x0000C350
_021543E4: .word 0x00009C40
_021543E8: .word 0x00000A05
	thumb_func_end StageClearEx__Func_2154118

	thumb_func_start StageClearEx__Func_21543EC
StageClearEx__Func_21543EC: // 0x021543EC
	push {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #4]
	blx FreeSndHandle
	mov r0, #0x79
	lsl r0, r0, #4
	add r0, r6, r0
	blx AnimatorSprite__Release
	ldr r0, _02154468 // =0x0000072C
	add r0, r6, r0
	blx AnimatorSprite__Release
	ldr r0, _0215446C // =0x000006B8
	add r0, r6, r0
	blx AnimatorSprite__Release
	ldr r0, _02154470 // =0x00000654
	add r0, r6, r0
	blx AnimatorSprite__Release
	mov r0, #0x5f
	lsl r0, r0, #4
	add r0, r6, r0
	blx AnimatorSprite__Release
	mov r0, #0x3f
	mov r5, r6
	lsl r0, r0, #4
	add r5, #8
	add r4, r6, r0
	cmp r5, r4
	beq _0215443C
_02154430:
	mov r0, r5
	blx AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _02154430
_0215443C:
	mov r0, #0x3f
	lsl r0, r0, #4
	add r5, r6, r0
	ldr r0, _02154474 // =0x0000051C
	add r4, r6, r0
	cmp r5, r4
	beq _02154456
_0215444A:
	mov r0, r5
	blx AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _0215444A
_02154456:
	ldr r0, _02154478 // =0x0000058C
	add r0, r6, r0
	blx AnimatorSprite__Release
	ldr r0, _0215447C // =0x00000528
	add r0, r6, r0
	blx AnimatorSprite__Release
	pop {r4, r5, r6, pc}
	.align 2, 0
_02154468: .word 0x0000072C
_0215446C: .word 0x000006B8
_02154470: .word 0x00000654
_02154474: .word 0x0000051C
_02154478: .word 0x0000058C
_0215447C: .word 0x00000528
	thumb_func_end StageClearEx__Func_21543EC

	thumb_func_start StageClearEx__Func_2154480
StageClearEx__Func_2154480: // 0x02154480
	push {r3, r4, r5, r6, r7, lr}
	mov r2, r0
	ldr r1, _02154564 // =0x00000958
	add r2, #0x1c
	add r4, r0, r1
	mov r5, r2
	sub r1, #0x70
	add r5, #0xc
	add r6, r2, r1
	cmp r5, r6
	beq _021544A6
	mov r7, #0x51
	lsl r7, r7, #2
_0215449A:
	mov r0, r5
	blx AnimatorMDL__ProcessAnimation
	add r5, r5, r7
	cmp r5, r6
	bne _0215449A
_021544A6:
	ldr r0, _02154568 // =0x000006B8
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	ldr r0, _0215456C // =0x00000654
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	mov r0, #0x5f
	lsl r0, r0, #4
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	mov r1, #0x72
	lsl r1, r1, #4
	mov r0, r1
	add r0, #8
	ldr r2, [r4, r1]
	ldr r0, [r4, r0]
	add r0, r2, r0
	str r0, [r4, r1]
	mov r0, #1
	ldr r2, [r4, r1]
	lsl r0, r0, #0x14
	cmp r2, r0
	blt _021544F0
	sub r0, r2, r0
	str r0, [r4, r1]
	mov r2, #1
	sub r0, r1, #4
	str r2, [r4, r0]
_021544F0:
	mov r0, #0x3f
	mov r5, r4
	lsl r0, r0, #4
	add r5, #8
	add r6, r4, r0
	cmp r5, r6
	beq _02154510
	mov r7, #0
_02154500:
	mov r0, r5
	mov r1, r7
	mov r2, r7
	blx AnimatorSprite__ProcessAnimation
	add r5, #0x64
	cmp r5, r6
	bne _02154500
_02154510:
	mov r0, #0x3f
	lsl r0, r0, #4
	add r5, r4, r0
	ldr r0, _02154570 // =0x0000051C
	add r6, r4, r0
	cmp r5, r6
	beq _02154530
	mov r7, #0
_02154520:
	mov r0, r5
	mov r1, r7
	mov r2, r7
	blx AnimatorSprite__ProcessAnimation
	add r5, #0x64
	cmp r5, r6
	bne _02154520
_02154530:
	ldr r0, _02154574 // =0x0000058C
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	ldr r0, _02154578 // =0x00000528
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	mov r0, #0x79
	lsl r0, r0, #4
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	ldr r0, _0215457C // =0x0000072C
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02154564: .word 0x00000958
_02154568: .word 0x000006B8
_0215456C: .word 0x00000654
_02154570: .word 0x0000051C
_02154574: .word 0x0000058C
_02154578: .word 0x00000528
_0215457C: .word 0x0000072C
	thumb_func_end StageClearEx__Func_2154480

	thumb_func_start StageClearEx__Func_2154580
StageClearEx__Func_2154580: // 0x02154580
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r7, r0
	mov r4, r7
	ldr r0, _0215487C // =0x000008E8
	add r4, #0x1c
	add r5, r4, r0
	blx Camera3D__UseEngineA
	cmp r0, #0
	ldr r0, _02154880 // =0x00000938
	beq _021545A8
	ldr r1, [r4, r0]
	sub r0, #0x50
	neg r1, r1
	add r0, r4, r0
	str r1, [r5, #0x18]
	blx Camera3D__LoadState
	b _021545B4
_021545A8:
	ldr r1, [r4, r0]
	sub r0, #0x50
	add r0, r4, r0
	str r1, [r5, #0x18]
	blx Camera3D__LoadState
_021545B4:
	ldr r0, _0215487C // =0x000008E8
	mov r5, r4
	add r5, #0xc
	add r4, r4, r0
	cmp r5, r4
	beq _021545D0
	mov r6, #0x51
	lsl r6, r6, #2
_021545C4:
	mov r0, r5
	blx AnimatorMDL__Draw
	add r5, r5, r6
	cmp r5, r4
	bne _021545C4
_021545D0:
	ldr r0, _02154884 // =0x00000958
	add r4, r7, r0
	blx Camera3D__UseEngineA
	cmp r0, #0
	bne _021545DE
	b _0215477E
_021545DE:
	mov r0, #0x5f
	lsl r0, r0, #4
	add r5, r4, r0
	mov r0, #0x72
	lsl r0, r0, #4
	ldr r1, [r4, r0]
	add r0, r0, #4
	asr r1, r1, #0xc
	strh r1, [r5, #8]
	ldr r0, [r4, r0]
	asr r0, r0, #0xc
	strh r0, [r5, #0xa]
	mov r0, r5
	blx AnimatorSprite__DrawFrame
	ldr r0, _02154888 // =0x000006B8
	ldr r1, [r5, #8]
	add r6, r4, r0
	str r1, [r6, #8]
	add r0, #0x64
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _02154612
	mov r0, r6
	blx AnimatorSprite__DrawFrame
_02154612:
	mov r0, #8
	ldrsh r1, [r5, r0]
	add r0, #0xf8
	sub r0, r1, r0
	strh r0, [r5, #8]
	mov r0, r5
	blx AnimatorSprite__DrawFrame
	mov r0, #8
	ldrsh r1, [r6, r0]
	add r0, #0xf8
	sub r0, r1, r0
	strh r0, [r6, #8]
	mov r0, r6
	blx AnimatorSprite__DrawFrame
	ldr r1, _0215488C // =0x0000051C
	mov r0, r1
	add r0, #0xc
	add r5, r4, r0
	ldrsh r0, [r4, r1]
	add r6, r4, r1
	add r0, #8
	strh r0, [r5, #8]
	mov r0, #2
	ldrsh r0, [r6, r0]
	strh r0, [r5, #0xa]
	mov r0, r5
	blx AnimatorSprite__DrawFrame
	ldr r1, _0215488C // =0x0000051C
	mov r0, #0x3f
	lsl r0, r0, #4
	ldrsh r1, [r4, r1]
	add r0, r4, r0
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r6, r1]
	sub r1, #8
	strh r1, [r0, #0xa]
	blx AnimatorSprite__DrawFrame
	mov r0, #6
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	ldr r0, _02154890 // =0x00000808
	ldr r1, _0215488C // =0x0000051C
	ldr r0, [r4, r0]
	mov r2, #2
	str r0, [sp, #8]
	ldrsh r1, [r4, r1]
	ldrsh r2, [r6, r2]
	mov r0, r4
	add r1, #0x58
	sub r2, r2, #2
	lsl r1, r1, #0x10
	lsl r2, r2, #0x10
	add r0, #8
	asr r1, r1, #0x10
	asr r2, r2, #0x10
	mov r3, #8
	bl StageClearEx__Func_2154D68
	mov r0, #0x52
	lsl r0, r0, #4
	add r6, r4, r0
	ldrsh r0, [r4, r0]
	add r0, #8
	strh r0, [r5, #8]
	mov r0, #2
	ldrsh r0, [r6, r0]
	strh r0, [r5, #0xa]
	mov r0, r5
	blx AnimatorSprite__DrawFrame
	ldr r1, _02154894 // =0x00000454
	add r0, r4, r1
	add r1, #0xcc
	ldrsh r1, [r4, r1]
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r6, r1]
	sub r1, #0x30
	strh r1, [r0, #0xa]
	blx AnimatorSprite__DrawFrame
	mov r0, #6
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	ldr r0, _02154898 // =0x0000080C
	mov r1, #0x52
	ldr r0, [r4, r0]
	lsl r1, r1, #4
	str r0, [sp, #8]
	mov r2, #2
	ldrsh r1, [r4, r1]
	ldrsh r2, [r6, r2]
	mov r0, r4
	add r1, #0x58
	sub r2, r2, #2
	lsl r1, r1, #0x10
	lsl r2, r2, #0x10
	add r0, #8
	asr r1, r1, #0x10
	asr r2, r2, #0x10
	mov r3, #8
	bl StageClearEx__Func_2154D68
	ldr r0, _0215489C // =0x00000818
	mov r5, #1
	ldrh r2, [r4, r0]
	mov r1, #0
	cmp r2, #0
	bls _02154704
	mov r0, #0xa
_021546FC:
	add r1, r1, #1
	mul r5, r0
	cmp r1, r2
	blo _021546FC
_02154704:
	mov r0, #0x81
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	mov r1, r5
	blx _u32_div_f
	ldr r0, _021548A0 // =0x00000814
	mov r6, r1
	ldr r0, [r4, r0]
	mov r1, r5
	blx _u32_div_f
	mul r0, r5
	ldr r1, _021548A4 // =0x00000524
	add r6, r6, r0
	mov r0, r1
	add r5, r4, r1
	ldrsh r1, [r4, r1]
	add r0, #0x68
	add r0, r4, r0
	add r1, #8
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r5, r1]
	strh r1, [r0, #0xa]
	blx AnimatorSprite__DrawFrame
	ldr r1, _021548A8 // =0x000004B8
	add r0, r4, r1
	add r1, #0x6c
	ldrsh r1, [r4, r1]
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r5, r1]
	sub r1, #0x58
	strh r1, [r0, #0xa]
	blx AnimatorSprite__DrawFrame
	mov r0, #6
	str r0, [sp]
	ldr r0, _021548AC // =0x0000081C
	ldr r1, _021548A4 // =0x00000524
	ldr r0, [r4, r0]
	mov r2, #2
	str r0, [sp, #4]
	str r6, [sp, #8]
	ldrsh r1, [r4, r1]
	ldrsh r2, [r5, r2]
	mov r0, r4
	add r1, #0x58
	sub r2, r2, #2
	lsl r1, r1, #0x10
	lsl r2, r2, #0x10
	add r0, #8
	asr r1, r1, #0x10
	asr r2, r2, #0x10
	mov r3, #8
	bl StageClearEx__Func_2154D68
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
_0215477E:
	mov r0, #0x5f
	lsl r0, r0, #4
	add r5, r4, r0
	mov r0, #0x72
	lsl r0, r0, #4
	ldr r1, [r4, r0]
	add r0, r0, #4
	asr r2, r1, #0xc
	mov r1, #1
	lsl r1, r1, #8
	sub r1, r1, r2
	strh r1, [r5, #8]
	ldr r0, [r4, r0]
	asr r1, r0, #0xc
	mov r0, #0xc0
	sub r0, r0, r1
	strh r0, [r5, #0xa]
	mov r0, r5
	blx AnimatorSprite__DrawFrame
	ldr r0, _021548B0 // =0x00000654
	add r6, r4, r0
	ldr r0, [r5, #8]
	str r0, [r6, #8]
	mov r0, r6
	blx AnimatorSprite__DrawFrame
	mov r0, #8
	ldrsh r1, [r5, r0]
	add r0, #0xf8
	sub r0, r1, r0
	strh r0, [r5, #8]
	mov r0, r5
	blx AnimatorSprite__DrawFrame
	ldr r0, _021548B4 // =0x0000071C
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _021547DC
	mov r0, #8
	ldrsh r1, [r6, r0]
	add r0, #0xf8
	sub r0, r1, r0
	strh r0, [r6, #8]
	mov r0, r6
	blx AnimatorSprite__DrawFrame
_021547DC:
	ldr r1, _021548B8 // =0x000007F4
	mov r0, #1
	ldr r2, [r4, r1]
	lsl r0, r0, #0xc
	cmp r2, r0
	beq _02154804
	sub r1, #0xc8
	add r0, r4, r1
	blx AnimatorSprite__DrawFrame
	ldr r0, _021548B8 // =0x000007F4
	mov r3, #0
	ldr r1, [r4, r0]
	sub r0, #0x64
	add r0, r4, r0
	mov r2, r1
	blx AnimatorSprite__DrawFrameRotoZoom
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
_02154804:
	mov r0, r1
	sub r0, #0xc8
	add r5, r4, r0
	mov r0, #8
	ldrsh r2, [r5, r0]
	add r0, r1, #4
	ldrsh r0, [r4, r0]
	add r0, r2, r0
	strh r0, [r5, #8]
	mov r0, #0xa
	ldrsh r2, [r5, r0]
	add r0, r1, #6
	ldrsh r0, [r4, r0]
	add r0, r2, r0
	strh r0, [r5, #0xa]
	mov r0, r5
	blx AnimatorSprite__DrawFrame
	ldr r1, _021548BC // =0x000007F8
	mov r0, #8
	ldrsh r3, [r5, r0]
	ldrsh r2, [r4, r1]
	add r6, r1, #2
	sub r2, r3, r2
	strh r2, [r5, #8]
	mov r2, #0xa
	ldrsh r3, [r5, r2]
	ldrsh r6, [r4, r6]
	sub r3, r3, r6
	strh r3, [r5, #0xa]
	mov r3, r1
	sub r3, #0x68
	add r5, r4, r3
	ldrsh r3, [r5, r0]
	ldrsh r0, [r4, r1]
	sub r0, r3, r0
	strh r0, [r5, #8]
	add r0, r1, #2
	ldrsh r2, [r5, r2]
	ldrsh r0, [r4, r0]
	sub r0, r2, r0
	strh r0, [r5, #0xa]
	mov r0, r5
	blx AnimatorSprite__DrawFrame
	mov r0, #8
	ldrsh r2, [r5, r0]
	ldr r0, _021548BC // =0x000007F8
	ldrsh r1, [r4, r0]
	add r0, r0, #2
	add r1, r2, r1
	strh r1, [r5, #8]
	mov r1, #0xa
	ldrsh r1, [r5, r1]
	ldrsh r0, [r4, r0]
	add r0, r1, r0
	strh r0, [r5, #0xa]
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_0215487C: .word 0x000008E8
_02154880: .word 0x00000938
_02154884: .word 0x00000958
_02154888: .word 0x000006B8
_0215488C: .word 0x0000051C
_02154890: .word 0x00000808
_02154894: .word 0x00000454
_02154898: .word 0x0000080C
_0215489C: .word 0x00000818
_021548A0: .word 0x00000814
_021548A4: .word 0x00000524
_021548A8: .word 0x000004B8
_021548AC: .word 0x0000081C
_021548B0: .word 0x00000654
_021548B4: .word 0x0000071C
_021548B8: .word 0x000007F4
_021548BC: .word 0x000007F8
	thumb_func_end StageClearEx__Func_2154580

	thumb_func_start StageClearEx__State_21548C0
StageClearEx__State_21548C0: // 0x021548C0
	push {r4, lr}
	mov r4, r0
	blx Camera3D__Create
	blx Camera3D__GetWork
	ldr r1, _02154928 // =0x0213D300
	mov r2, #0x18
	ldrsh r3, [r1, r2]
	mov r1, r0
	add r1, #0x58
	strh r3, [r1]
	ldr r1, _0215492C // =0x0213D2A4
	add r0, #0xb4
	ldrsh r1, [r1, r2]
	strh r1, [r0]
	mov r0, r4
	bl Task__Unknown2153D38__Create
	ldr r0, _02154930 // =0x04000008
	mov r2, #3
	ldrh r1, [r0]
	bic r1, r2
	strh r1, [r0]
	ldrh r3, [r0, #2]
	mov r1, #1
	bic r3, r2
	orr r1, r3
	strh r1, [r0, #2]
	ldrh r3, [r0, #4]
	mov r1, #2
	bic r3, r2
	orr r1, r3
	strh r1, [r0, #4]
	ldrh r3, [r0, #6]
	mov r1, #3
	bic r3, r2
	orr r1, r3
	strh r1, [r0, #6]
	sub r0, #8
	ldr r2, [r0]
	ldr r1, _02154934 // =0xFFFFE0FF
	and r2, r1
	mov r1, #0x11
	lsl r1, r1, #8
	orr r1, r2
	str r1, [r0]
	ldr r1, _02154938 // =StageClearEx__State_215493C
	mov r0, r4
	bl StageClearEx__SetState
	pop {r4, pc}
	.align 2, 0
_02154928: .word 0x0213D300
_0215492C: .word 0x0213D2A4
_02154930: .word 0x04000008
_02154934: .word 0xFFFFE0FF
_02154938: .word StageClearEx__State_215493C
	thumb_func_end StageClearEx__State_21548C0

	thumb_func_start StageClearEx__State_215493C
StageClearEx__State_215493C: // 0x0215493C
	push {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	blx Camera3D__GetWork
	mov r4, r0
	ldr r0, _02154990 // =0x0213D300
	mov r5, #0x18
	ldrsh r0, [r0, r5]
	cmp r0, #0
	ble _02154954
	mov r5, #0x10
	b _0215495C
_02154954:
	bge _0215495A
	sub r5, #0x28
	b _0215495C
_0215495A:
	mov r5, #0x10
_0215495C:
	mov r0, #0xb8
	beq _02154980
	mov r7, r4
	add r7, #0xb8
_02154964:
	ldr r2, [r6, #0xc]
	mov r1, #0
	lsl r2, r2, #0x16
	mov r0, r5
	asr r2, r2, #0x10
	mov r3, r1
	blx Task__Unknown204BE48__LerpValue
	mov r1, r4
	add r1, #0x58
	add r4, #0x5c
	strh r0, [r1]
	cmp r4, r7
	bne _02154964
_02154980:
	ldr r0, [r6, #0xc]
	cmp r0, #0x40
	bne _0215498E
	ldr r1, _02154994 // =StageClearEx__State_2154998
	mov r0, r6
	bl StageClearEx__SetState
_0215498E:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02154990: .word 0x0213D300
_02154994: .word StageClearEx__State_2154998
	thumb_func_end StageClearEx__State_215493C

	thumb_func_start StageClearEx__State_2154998
StageClearEx__State_2154998: // 0x02154998
	push {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xc]
	cmp r0, #0xb4
	bls _021549B2
	mov r0, #0xd
	mov r1, #1
	blx PlaySysTrack
	ldr r1, _021549B4 // =StageClearEx__State_21549B8
	mov r0, r4
	bl StageClearEx__SetState
_021549B2:
	pop {r4, pc}
	.align 2, 0
_021549B4: .word StageClearEx__State_21549B8
	thumb_func_end StageClearEx__State_2154998

	thumb_func_start StageClearEx__State_21549B8
StageClearEx__State_21549B8: // 0x021549B8
	push {r3, r4, lr}
	sub sp, #0x24
	mov r4, r0
	ldr r0, _02154A00 // =0x00000958
	mov r2, #6
	ldr r1, _02154A04 // =0x00000728
	add r0, r4, r0
	lsl r2, r2, #0xa
	str r2, [r0, r1]
	mov r3, #0
	str r3, [sp]
	mov r2, #0x10
	str r2, [sp, #4]
	ldr r2, _02154A08 // =Task__Unknown204BE48__LerpValue
	sub r1, r1, #4
	str r2, [sp, #8]
	str r3, [sp, #0xc]
	str r3, [sp, #0x10]
	str r3, [sp, #0x14]
	add r0, r0, r1
	str r3, [sp, #0x18]
	mov r2, #0x62
	str r2, [sp, #0x1c]
	str r3, [sp, #0x20]
	mov r3, #0x16
	ldr r2, _02154A0C // =0xFFFEA000
	mov r1, #4
	lsl r3, r3, #0xc
	blx Task__Unknown204BE48__Create
	ldr r1, _02154A10 // =StageClearEx__State_2154A14
	mov r0, r4
	bl StageClearEx__SetState
	add sp, #0x24
	pop {r3, r4, pc}
	.align 2, 0
_02154A00: .word 0x00000958
_02154A04: .word 0x00000728
_02154A08: .word Task__Unknown204BE48__LerpValue
_02154A0C: .word 0xFFFEA000
_02154A10: .word StageClearEx__State_2154A14
	thumb_func_end StageClearEx__State_21549B8

	thumb_func_start StageClearEx__State_2154A14
StageClearEx__State_2154A14: // 0x02154A14
	push {r3, lr}
	ldr r1, [r0, #0xc]
	cmp r1, #0x78
	bls _02154A22
	ldr r1, _02154A24 // =StageClearEx__State_2154A28
	bl StageClearEx__SetState
_02154A22:
	pop {r3, pc}
	.align 2, 0
_02154A24: .word StageClearEx__State_2154A28
	thumb_func_end StageClearEx__State_2154A14

	thumb_func_start StageClearEx__State_2154A28
StageClearEx__State_2154A28: // 0x02154A28
	push {r4, r5, r6, r7, lr}
	sub sp, #0x24
	mov r5, r0
	ldr r0, _02154AF8 // =0x00000958
	mov r3, #0
	add r4, r5, r0
	ldr r0, _02154AFC // =0x00000818
	ldr r6, _02154B00 // =_mt_math_rand
	strh r3, [r4, r0]
	ldr r1, [r6]
	ldr r0, _02154B04 // =0x00196225
	ldr r7, _02154B08 // =0x3C6EF35F
	mul r0, r1
	add r1, r0, r7
	ldr r2, _02154B04 // =0x00196225
	lsr r0, r1, #0x10
	mul r2, r1
	add r1, r2, r7
	str r1, [r6]
	lsr r1, r1, #0x10
	lsl r0, r0, #0x10
	lsl r1, r1, #0x10
	lsr r2, r1, #0xc
	lsr r0, r0, #0x10
	mov r1, #0xf
	and r0, r1
	mov r1, r2
	orr r1, r0
	ldr r0, _02154AFC // =0x00000818
	sub r0, r0, #4
	str r1, [r4, r0]
	mov r1, #2
	mov r2, r1
	str r3, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	ldr r0, _02154B0C // =Task__Unknown204BE48__LerpValue
	sub r2, #0xa2
	str r0, [sp, #8]
	ldr r0, _02154B10 // =0xFFFFF000
	str r0, [sp, #0xc]
	ldr r0, _02154B14 // =StageClearEx__Func_2154E38
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, #0x62
	str r0, [sp, #0x1c]
	ldr r0, _02154B18 // =0x0000051C
	str r3, [sp, #0x20]
	add r0, r4, r0
	blx Task__Unknown204BE48__Create
	mov r0, #0x10
	str r0, [sp]
	str r0, [sp, #4]
	ldr r0, _02154B0C // =Task__Unknown204BE48__LerpValue
	mov r1, #2
	str r0, [sp, #8]
	ldr r0, _02154B10 // =0xFFFFF000
	mov r2, r1
	str r0, [sp, #0xc]
	ldr r0, _02154B14 // =StageClearEx__Func_2154E38
	mov r3, #0
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, #0x62
	str r0, [sp, #0x1c]
	mov r0, #0x52
	lsl r0, r0, #4
	add r0, r4, r0
	sub r2, #0xa2
	str r3, [sp, #0x20]
	blx Task__Unknown204BE48__Create
	mov r0, #0x20
	str r0, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	ldr r0, _02154B0C // =Task__Unknown204BE48__LerpValue
	mov r1, #2
	str r0, [sp, #8]
	ldr r0, _02154B10 // =0xFFFFF000
	mov r2, r1
	str r0, [sp, #0xc]
	ldr r0, _02154B1C // =StageClearEx__Func_2154E58
	mov r3, #0
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, #0x62
	str r0, [sp, #0x1c]
	ldr r0, _02154B20 // =0x00000524
	sub r2, #0xa2
	add r0, r4, r0
	str r3, [sp, #0x20]
	blx Task__Unknown204BE48__Create
	ldr r1, _02154B24 // =StageClearEx__State_2154B28
	mov r0, r5
	bl StageClearEx__SetState
	add sp, #0x24
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02154AF8: .word 0x00000958
_02154AFC: .word 0x00000818
_02154B00: .word _mt_math_rand
_02154B04: .word 0x00196225
_02154B08: .word 0x3C6EF35F
_02154B0C: .word Task__Unknown204BE48__LerpValue
_02154B10: .word 0xFFFFF000
_02154B14: .word StageClearEx__Func_2154E38
_02154B18: .word 0x0000051C
_02154B1C: .word StageClearEx__Func_2154E58
_02154B20: .word 0x00000524
_02154B24: .word StageClearEx__State_2154B28
	thumb_func_end StageClearEx__State_2154A28

	thumb_func_start StageClearEx__State_2154B28
StageClearEx__State_2154B28: // 0x02154B28
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _02154B58 // =0x00000958
	ldr r1, [r5, #0xc]
	add r4, r5, r0
	mov r0, #1
	tst r0, r1
	beq _02154B46
	blx Task__Unknown204BE48__Rand
	ldr r1, _02154B5C // =0x000F4240
	blx _u32_div_f
	ldr r0, _02154B60 // =0x00000814
	str r1, [r4, r0]
_02154B46:
	ldr r0, [r5, #0xc]
	cmp r0, #0x5a
	bls _02154B54
	ldr r1, _02154B64 // =StageClearEx__State_2154B68
	mov r0, r5
	bl StageClearEx__SetState
_02154B54:
	pop {r3, r4, r5, pc}
	nop
_02154B58: .word 0x00000958
_02154B5C: .word 0x000F4240
_02154B60: .word 0x00000814
_02154B64: .word StageClearEx__State_2154B68
	thumb_func_end StageClearEx__State_2154B28

	thumb_func_start StageClearEx__State_2154B68
StageClearEx__State_2154B68: // 0x02154B68
	push {r3, r4, r5, lr}
	sub sp, #8
	mov r5, r0
	ldr r0, _02154BC4 // =0x00000958
	ldr r1, [r5, #0xc]
	add r4, r5, r0
	mov r0, #1
	tst r0, r1
	beq _02154B88
	blx Task__Unknown204BE48__Rand
	ldr r1, _02154BC8 // =0x000F4240
	blx _u32_div_f
	ldr r0, _02154BCC // =0x00000814
	str r1, [r4, r0]
_02154B88:
	ldr r0, [r5, #0xc]
	lsr r1, r0, #4
	ldr r0, _02154BD0 // =0x00000818
	strh r1, [r4, r0]
	ldrh r0, [r4, r0]
	cmp r0, #6
	blo _02154BC0
	mov r0, #6
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	blx PlaySfxEx
	ldr r0, [r4, #4]
	mov r1, #0
	blx NNS_SndPlayerStopSeq
	ldr r0, _02154BD4 // =0x0000081C
	mov r1, #0
	str r1, [r4, r0]
	ldr r1, _02154BD8 // =StageClearEx__State_2154BDC
	mov r0, r5
	bl StageClearEx__SetState
_02154BC0:
	add sp, #8
	pop {r3, r4, r5, pc}
	.align 2, 0
_02154BC4: .word 0x00000958
_02154BC8: .word 0x000F4240
_02154BCC: .word 0x00000814
_02154BD0: .word 0x00000818
_02154BD4: .word 0x0000081C
_02154BD8: .word StageClearEx__State_2154BDC
	thumb_func_end StageClearEx__State_2154B68

	thumb_func_start StageClearEx__State_2154BDC
StageClearEx__State_2154BDC: // 0x02154BDC
	push {r3, lr}
	ldr r1, [r0, #0xc]
	cmp r1, #0x20
	bls _02154BF6
	mov r2, #0x43
	lsl r2, r2, #6
	ldr r3, [r0, r2]
	mov r1, #1
	bic r3, r1
	ldr r1, _02154BF8 // =StageClearEx__State_2154BFC
	str r3, [r0, r2]
	bl StageClearEx__SetState
_02154BF6:
	pop {r3, pc}
	.align 2, 0
_02154BF8: .word StageClearEx__State_2154BFC
	thumb_func_end StageClearEx__State_2154BDC

	thumb_func_start StageClearEx__State_2154BFC
StageClearEx__State_2154BFC: // 0x02154BFC
	push {r4, lr}
	ldr r1, [r0, #0xc]
	cmp r1, #0x1e
	bls _02154C20
	ldr r1, _02154C24 // =0x00000958
	ldr r2, _02154C28 // =0x000007CC
	add r4, r0, r1
	ldr r3, [r4, r2]
	mov r1, #1
	bic r3, r1
	mov r1, #6
	str r3, [r4, r2]
	lsl r1, r1, #0xa
	add r2, #0x28
	str r1, [r4, r2]
	ldr r1, _02154C2C // =StageClearEx__State_2154C30
	bl StageClearEx__SetState
_02154C20:
	pop {r4, pc}
	nop
_02154C24: .word 0x00000958
_02154C28: .word 0x000007CC
_02154C2C: .word StageClearEx__State_2154C30
	thumb_func_end StageClearEx__State_2154BFC

	thumb_func_start StageClearEx__State_2154C30
StageClearEx__State_2154C30: // 0x02154C30
	push {r3, r4, r5, lr}
	sub sp, #8
	mov r5, r0
	ldr r0, _02154C84 // =0x00000958
	ldr r2, [r5, #0xc]
	add r4, r5, r0
	mov r0, #6
	mov r1, #1
	lsl r2, r2, #0x17
	ldr r3, _02154C88 // =0xFFFFD000
	lsl r0, r0, #0xa
	lsl r1, r1, #0xc
	asr r2, r2, #0x10
	blx Task__Unknown204BE48__LerpValue
	ldr r1, _02154C8C // =0x000007F4
	str r0, [r4, r1]
	ldr r0, [r5, #0xc]
	cmp r0, #0x20
	bls _02154C80
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [r4, r1]
	mov r0, #6
	str r0, [sp]
	mov r0, #3
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	blx PlaySfxEx
	mov r0, #6
	blx ShakeScreen
	ldr r1, _02154C90 // =StageClearEx__State_2154C94
	mov r0, r5
	bl StageClearEx__SetState
_02154C80:
	add sp, #8
	pop {r3, r4, r5, pc}
	.align 2, 0
_02154C84: .word 0x00000958
_02154C88: .word 0xFFFFD000
_02154C8C: .word 0x000007F4
_02154C90: .word StageClearEx__State_2154C94
	thumb_func_end StageClearEx__State_2154C30

	thumb_func_start StageClearEx__State_2154C94
StageClearEx__State_2154C94: // 0x02154C94
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _02154CC4 // =0x00000958
	add r4, r5, r0
	blx GetScreenShakeOffsetX
	asr r1, r0, #0xc
	ldr r0, _02154CC8 // =0x000007F8
	strh r1, [r4, r0]
	blx GetScreenShakeOffsetY
	asr r1, r0, #0xc
	ldr r0, _02154CCC // =0x000007FA
	strh r1, [r4, r0]
	mov r0, #0x11
	blx ShakeScreen
	cmp r0, #0
	bne _02154CC2
	ldr r1, _02154CD0 // =StageClearEx__State_2154CD4
	mov r0, r5
	bl StageClearEx__SetState
_02154CC2:
	pop {r3, r4, r5, pc}
	.align 2, 0
_02154CC4: .word 0x00000958
_02154CC8: .word 0x000007F8
_02154CCC: .word 0x000007FA
_02154CD0: .word StageClearEx__State_2154CD4
	thumb_func_end StageClearEx__State_2154C94

	thumb_func_start StageClearEx__State_2154CD4
StageClearEx__State_2154CD4: // 0x02154CD4
	push {r3, lr}
	ldr r1, [r0, #0xc]
	cmp r1, #0x10
	bls _02154CE2
	ldr r1, _02154CE4 // =StageClearEx__State_2154CE8
	bl StageClearEx__SetState
_02154CE2:
	pop {r3, pc}
	.align 2, 0
_02154CE4: .word StageClearEx__State_2154CE8
	thumb_func_end StageClearEx__State_2154CD4

	thumb_func_start StageClearEx__State_2154CE8
StageClearEx__State_2154CE8: // 0x02154CE8
	push {r3, lr}
	ldr r1, _02154D0C // =padInput
	ldrh r2, [r1, #4]
	ldr r1, _02154D10 // =0x00000C0B
	tst r1, r2
	beq _02154CFC
	ldr r1, _02154D14 // =StageClearEx__State_2154D18
	bl StageClearEx__SetState
	pop {r3, pc}
_02154CFC:
	ldr r1, [r0, #0xc]
	cmp r1, #0x78
	bls _02154D08
	ldr r1, _02154D14 // =StageClearEx__State_2154D18
	bl StageClearEx__SetState
_02154D08:
	pop {r3, pc}
	nop
_02154D0C: .word padInput
_02154D10: .word 0x00000C0B
_02154D14: .word StageClearEx__State_2154D18
	thumb_func_end StageClearEx__State_2154CE8

	thumb_func_start StageClearEx__State_2154D18
StageClearEx__State_2154D18: // 0x02154D18
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	blx Camera3D__GetWork
	mov r4, r0
	mov r0, #0xb8
	beq _02154D4A
	mov r6, r4
	mov r7, #0
	add r6, #0xb8
_02154D2C:
	ldr r2, [r5, #0xc]
	mov r1, #0xf
	lsl r2, r2, #0x17
	mov r0, r7
	mvn r1, r1
	asr r2, r2, #0x10
	mov r3, r7
	blx Task__Unknown204BE48__LerpValue
	mov r1, r4
	add r1, #0x58
	add r4, #0x5c
	strh r0, [r1]
	cmp r4, r6
	bne _02154D2C
_02154D4A:
	ldr r0, [r5, #0xc]
	cmp r0, #0x20
	bne _02154D66
	mov r0, #9
	blx SaveGame__Func_205B9F0
	mov r0, #0
	blx RequestSysEventChange
	blx NextSysEvent
	mov r0, r5
	bl StageClearEx__Func_2153E14
_02154D66:
	pop {r3, r4, r5, r6, r7, pc}
	thumb_func_end StageClearEx__State_2154D18

	thumb_func_start StageClearEx__Func_2154D68
StageClearEx__Func_2154D68: // 0x02154D68
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	str r0, [sp]
	ldr r0, [sp, #0x24]
	str r2, [sp, #4]
	str r0, [sp, #0x24]
	str r3, [sp, #8]
	add r0, sp, #0x10
	ldrh r7, [r0, #0x10]
	ldr r0, [sp, #8]
	mov r5, r1
	mov r1, r0
	mul r1, r7
	add r0, r5, r1
	lsl r0, r0, #0x10
	ldr r4, [sp, #0x28]
	asr r5, r0, #0x10
	mov r6, #0
	cmp r7, #0
	bls _02154DCE
_02154D90:
	mov r0, r4
	mov r1, #0xa
	blx _u32_div_f
	mov r2, r1
	ldr r1, [sp, #8]
	mov r0, #0x64
	mul r2, r0
	ldr r0, [sp]
	sub r1, r5, r1
	lsl r1, r1, #0x10
	add r0, r0, r2
	asr r5, r1, #0x10
	strh r5, [r0, #8]
	ldr r1, [sp, #4]
	strh r1, [r0, #0xa]
	blx AnimatorSprite__DrawFrame
	mov r0, r4
	mov r1, #0xa
	blx _u32_div_f
	mov r4, r0
	ldr r0, [sp, #0x24]
	cmp r0, #0
	bne _02154DC8
	cmp r4, #0
	beq _02154DCE
_02154DC8:
	add r6, r6, #1
	cmp r6, r7
	blo _02154D90
_02154DCE:
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
	thumb_func_end StageClearEx__Func_2154D68

	thumb_func_start StageClearEx__CalcTimeBonus
StageClearEx__CalcTimeBonus: // 0x02154DD4
	push {r4, r5}
	ldr r5, _02154E00 // =_02161514
	mov r4, #0
	mov r1, #0x3c
_02154DDC:
	ldrb r2, [r5]
	mov r3, r2
	mul r3, r1
	cmp r3, r0
	bhi _02154DF0
	ldr r0, _02154E04 // =_02161524
	lsl r1, r4, #2
	ldr r0, [r0, r1]
	pop {r4, r5}
	bx lr
_02154DF0:
	add r4, r4, #1
	add r5, r5, #1
	cmp r4, #8
	blo _02154DDC
	ldr r0, _02154E08 // =0x0000AFC8
	pop {r4, r5}
	bx lr
	nop
_02154E00: .word _02161514
_02154E04: .word _02161524
_02154E08: .word 0x0000AFC8
	thumb_func_end StageClearEx__CalcTimeBonus

	thumb_func_start StageClearEx__CalcRingBonus
StageClearEx__CalcRingBonus: // 0x02154E0C
	ldr r3, _02154E2C // =_0216151C
	mov r2, #0
_02154E10:
	ldrb r1, [r3]
	cmp r0, r1
	bhs _02154E1E
	ldr r0, _02154E30 // =_02161548
	lsl r1, r2, #2
	ldr r0, [r0, r1]
	bx lr
_02154E1E:
	add r2, r2, #1
	add r3, r3, #1
	cmp r2, #8
	blo _02154E10
	ldr r0, _02154E34 // =0x00001388
	bx lr
	nop
_02154E2C: .word _0216151C
_02154E30: .word _02161548
_02154E34: .word 0x00001388
	thumb_func_end StageClearEx__CalcRingBonus

	thumb_func_start StageClearEx__Func_2154E38
StageClearEx__Func_2154E38: // 0x02154E38
	push {r3, lr}
	sub sp, #8
	cmp r0, #4
	bne _02154E52
	mov r0, #6
	str r0, [sp]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	str r0, [sp, #4]
	blx PlaySfxEx
_02154E52:
	add sp, #8
	pop {r3, pc}
	.align 2, 0
	thumb_func_end StageClearEx__Func_2154E38

	thumb_func_start StageClearEx__Func_2154E58
StageClearEx__Func_2154E58: // 0x02154E58
	push {r4, lr}
	sub sp, #8
	mov r4, r2
	cmp r0, #4
	bne _02154E8A
	mov r0, #6
	str r0, [sp]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	str r0, [sp, #4]
	blx PlaySfxEx
	mov r0, #6
	str r0, [sp]
	mov r1, #1
	str r1, [sp, #4]
	sub r1, r1, #2
	ldr r0, _02154E90 // =0x0000095C
	mov r2, r1
	ldr r0, [r4, r0]
	mov r3, r1
	blx PlaySfxEx
_02154E8A:
	add sp, #8
	pop {r4, pc}
	nop
_02154E90: .word 0x0000095C
	thumb_func_end StageClearEx__Func_2154E58

	thumb_func_start StageClearEx__Main
StageClearEx__Main: // 0x02154E94
	push {r3, lr}
	blx GetCurrentTaskWork_
	ldr r1, [r0, #0xc]
	add r1, r1, #1
	str r1, [r0, #0xc]
	ldr r1, [r0, #8]
	cmp r1, #0
	beq _02154EA8
	blx r1
_02154EA8:
	pop {r3, pc}
	.align 2, 0
	thumb_func_end StageClearEx__Main

	thumb_func_start Task__Unknown2153D0C__Main
Task__Unknown2153D0C__Main: // 0x02154EAC
	push {r3, lr}
	ldr r0, _02154EBC // =StageClearEx__Singleton
	ldr r0, [r0]
	blx GetTaskWork_
	bl StageClearEx__Func_2154480
	pop {r3, pc}
	.align 2, 0
_02154EBC: .word StageClearEx__Singleton
	thumb_func_end Task__Unknown2153D0C__Main

	thumb_func_start Task__Unknown2153D38__Main
Task__Unknown2153D38__Main: // 0x02154EC0
	push {r3, lr}
	ldr r0, _02154ED0 // =StageClearEx__Singleton
	ldr r0, [r0]
	blx GetTaskWork_
	bl StageClearEx__Func_2154580
	pop {r3, pc}
	.align 2, 0
_02154ED0: .word StageClearEx__Singleton
	thumb_func_end Task__Unknown2153D38__Main

	.rodata

_02161514: // 0x02161514
    .byte 190, 180, 170, 160, 150, 140, 130, 120
	
_0216151C: // 0x0216151C
    .byte 15, 20, 25, 30, 35, 40, 45, 50
	
_02161524: // 0x02161524
    .word 10000, 15000, 20000, 25000, 30000, 34000, 38000, 42000, 45000

_02161548: // 0x02161548
    .word 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000

    .data
    
aNarcPldm6700Lz: // 0x021629D4
	.asciz "/narc/pldm_67_00_lz7.narc"
	.align 4

aNarcCldmExLz7N: // 0x021629F0
	.asciz "/narc/cldm_ex_lz7.narc"
	.align 4