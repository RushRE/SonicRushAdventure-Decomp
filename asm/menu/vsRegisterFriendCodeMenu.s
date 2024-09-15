	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start VSRegisterFriendCodeMenu__Init
VSRegisterFriendCodeMenu__Init: // 0x02172958
	ldr ip, _0217296C // =MIi_CpuClear32
	mov r1, r0
	mov r0, #0
	mov r2, #8
	bx ip
	.align 2, 0
_0217296C: .word MIi_CpuClear32
	arm_func_end VSRegisterFriendCodeMenu__Init

	arm_func_start VSRegisterFriendCodeMenu__Release
VSRegisterFriendCodeMenu__Release: // 0x02172970
	ldr ip, _02172984 // =MIi_CpuClear32
	mov r1, r0
	mov r0, #0
	mov r2, #8
	bx ip
	.align 2, 0
_02172984: .word MIi_CpuClear32
	arm_func_end VSRegisterFriendCodeMenu__Release

	arm_func_start VSRegisterFriendCodeMenu__Create
VSRegisterFriendCodeMenu__Create: // 0x02172988
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r2, #0
	mov r1, #0x10
	stmia sp, {r1, r2}
	mov r5, r0
	mov r4, #4
	ldr r0, _021729FC // =VSRegisterFriendCodeMenu__Main
	ldr r1, _02172A00 // =VSRegisterFriendCodeMenu__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	str r0, [r5]
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #4
	bl MIi_CpuClear32
	mov r0, r4
	str r5, [r4]
	mov r1, #0
	str r1, [r5, #4]
	bl VSRegisterFriendCodeMenu__LoadAssets
	bl LoadSysSoundVillage
	mov r0, #0
	bl PlaySysVillageTrack
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_021729FC: .word VSRegisterFriendCodeMenu__Main
_02172A00: .word VSRegisterFriendCodeMenu__Destructor
	arm_func_end VSRegisterFriendCodeMenu__Create

	arm_func_start VSRegisterFriendCodeMenu__IsActive
VSRegisterFriendCodeMenu__IsActive: // 0x02172A04
	ldr r0, [r0]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end VSRegisterFriendCodeMenu__IsActive

	arm_func_start VSRegisterFriendCodeMenu__Func_2172A18
VSRegisterFriendCodeMenu__Func_2172A18: // 0x02172A18
	ldr r0, [r0, #4]
	bx lr
	arm_func_end VSRegisterFriendCodeMenu__Func_2172A18

	arm_func_start VSViewFriendCodeMenu__LoadAssets
VSViewFriendCodeMenu__LoadAssets: // 0x02172A20
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear32
	ldr r0, _02172A4C // =aNarcDmwfFcLz7N
	mov r1, #0
	bl ArchiveFileUnknown__LoadFile
	str r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02172A4C: .word aNarcDmwfFcLz7N
	arm_func_end VSViewFriendCodeMenu__LoadAssets

	arm_func_start VSViewFriendCodeMenu__ReleaseAssets
VSViewFriendCodeMenu__ReleaseAssets: // 0x02172A50
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4]
	ldmia sp!, {r4, pc}
	arm_func_end VSViewFriendCodeMenu__ReleaseAssets

	arm_func_start VSViewFriendCodeMenu__Create
VSViewFriendCodeMenu__Create: // 0x02172A74
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r1, #0x10
	mov r2, #0
	str r1, [sp]
	ldr r4, _02172AD8 // =0x000004BC
	mov r5, r0
	ldr r0, _02172ADC // =VSViewFriendCodeMenu__Main
	ldr r1, _02172AE0 // =VSViewFriendCodeMenu__Destructor
	stmib sp, {r2, r4}
	mov r3, r2
	bl TaskCreate_
	str r0, [r5, #4]
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02172AD8 // =0x000004BC
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear32
	str r5, [r4]
	ldr r0, [r5, #4]
	bl GetTaskWork_
	bl VSViewFriendCodeMenu__InitSprites
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02172AD8: .word 0x000004BC
_02172ADC: .word VSViewFriendCodeMenu__Main
_02172AE0: .word VSViewFriendCodeMenu__Destructor
	arm_func_end VSViewFriendCodeMenu__Create

	arm_func_start VSViewFriendCodeMenu__IsActive
VSViewFriendCodeMenu__IsActive: // 0x02172AE4
	ldr r0, [r0, #4]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end VSViewFriendCodeMenu__IsActive

	arm_func_start VSRegisterFriendCodeMenu__LoadAssets
VSRegisterFriendCodeMenu__LoadAssets: // 0x02172AF8
	stmdb sp!, {r3, lr}
	blx FriendCodeMenu__LoadAssets
	blx VSMenu__GetFontWindow
	mov r2, r0
	mov r0, #0
	mov r1, r0
	blx FriendCodeMenu__Create
	ldmia sp!, {r3, pc}
	arm_func_end VSRegisterFriendCodeMenu__LoadAssets

	arm_func_start VSRegisterFriendCodeMenu__ReleaseAssets
VSRegisterFriendCodeMenu__ReleaseAssets: // 0x02172B18
	stmdb sp!, {r4, lr}
	mov r4, r0
	blx FriendCodeMenu__Func_216508C
	ldr r0, [r4]
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r4, pc}
	arm_func_end VSRegisterFriendCodeMenu__ReleaseAssets

	arm_func_start VSRegisterFriendCodeMenu__Main
VSRegisterFriendCodeMenu__Main: // 0x02172B34
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	blx FriendCodeMenu__Func_2165040
	cmp r0, #2
	bne _02172BA4
	blx FriendCodeMenu__GetFriendKey
	mov r4, r0
	bl VSRegisterFriendCodeMenu__Func_2172BC8
	cmp r0, #0
	beq _02172B98
	mov r0, r4
	bl VSRegisterFriendCodeMenu__Func_2172BEC
	cmp r0, #0
	mov r0, #1
	beq _02172B8C
	mov r1, r0
	blx FriendCodeMenu__Func_216504C
	ldr r0, [r5]
	mov r1, #1
	str r1, [r0, #4]
	b _02172BA4
_02172B8C:
	mov r1, #0
	blx FriendCodeMenu__Func_216504C
	b _02172BA4
_02172B98:
	mov r0, #0
	mov r1, r0
	blx FriendCodeMenu__Func_216504C
_02172BA4:
	blx FriendCodeMenu__Func_2165068
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	bl DestroyCurrentTask
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end VSRegisterFriendCodeMenu__Main

	arm_func_start VSRegisterFriendCodeMenu__Destructor
VSRegisterFriendCodeMenu__Destructor: // 0x02172BB8
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	bl VSRegisterFriendCodeMenu__ReleaseAssets
	ldmia sp!, {r3, pc}
	arm_func_end VSRegisterFriendCodeMenu__Destructor

	arm_func_start VSRegisterFriendCodeMenu__Func_2172BC8
VSRegisterFriendCodeMenu__Func_2172BC8: // 0x02172BC8
	stmdb sp!, {r3, lr}
	bl DWC_Acc_NumericKeyToFriendKey
	mov r3, r0
	mov r2, r1
	ldr r0, _02172BE8 // =0x0213529C
	mov r1, r3
	bl DWC_CheckFriendKey
	ldmia sp!, {r3, pc}
	.align 2, 0
_02172BE8: .word 0x0213529C
	arm_func_end VSRegisterFriendCodeMenu__Func_2172BC8

	arm_func_start VSRegisterFriendCodeMenu__Func_2172BEC
VSRegisterFriendCodeMenu__Func_2172BEC: // 0x02172BEC
	stmdb sp!, {r3, r4, r5, lr}
	bl DWC_Acc_NumericKeyToFriendKey
	mov r4, r0
	mov r5, r1
	bl SaveGame__FindFriendViaKey
	ldr r1, _02172C38 // =0x0000FFFF
	cmp r0, r1
	movne r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	bl SaveGame__GetFriendCount
	cmp r0, #0x1e
	blo _02172C24
	mov r0, #0x1d
	bl SaveGame__DeleteFriend
_02172C24:
	mov r0, r4
	mov r1, r5
	bl SaveGame__AddFriendViaKey
	mov r0, #1
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02172C38: .word 0x0000FFFF
	arm_func_end VSRegisterFriendCodeMenu__Func_2172BEC

	arm_func_start VSViewFriendCodeMenu__InitSprites
VSViewFriendCodeMenu__InitSprites: // 0x02172C3C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x30
	str r0, [sp, #0x1c]
	ldr r1, [sp, #0x1c]
	mov r2, #0
	add r0, sp, #0x24
	str r2, [r1, #0x4b4]
	bl VSViewFriendCodeMenu__Func_21730CC
	ldr r1, [sp, #0x1c]
	str r0, [r1, #0x4b8]
	mov r0, r1
	ldr r0, [r0]
	mov r1, #0
	ldr r0, [r0]
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x20]
	bl Sprite__GetSpriteSize3
	mov r4, #0
	ldr r8, [sp, #0x1c]
	mov r11, r0
	mov r0, r8
	add r5, sp, #0x24
	mov r9, r4
	add r6, r0, #4
	mov r7, #0x26
_02172CA0:
	cmp r4, #0
	moveq r10, #0
	mov r0, #1
	mov r1, r11
	movne r10, #0x10
	bl VRAMSystem__AllocSpriteVram
	mov r1, #1
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, _02172D68 // =0x05000600
	orr r3, r10, #0x200
	str r0, [sp, #0x10]
	mov r0, r1
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	ldrb r2, [r5]
	ldr r1, [sp, #0x20]
	mov r0, r6
	bl AnimatorSprite__Init
	cmp r4, #6
	movlt r0, #0x50
	strlth r7, [r8, #0xc]
	subge r0, r9, #0xb2
	strgeh r0, [r8, #0xc]
	movge r0, #0x80
	add r4, r4, #1
	strh r0, [r8, #0xe]
	add r5, r5, #1
	add r6, r6, #0x64
	add r7, r7, #0x24
	add r8, r8, #0x64
	add r9, r9, #0x24
	cmp r4, #0xc
	blt _02172CA0
	ldr r0, [sp, #0x1c]
	ldr r0, [r0, #0x4b8]
	cmp r0, #0
	beq _02172D58
	mov r0, #0x19
	blx VSMenu__SetNetworkMessageSequence
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02172D58:
	mov r0, #0x1a
	blx VSMenu__SetNetworkMessageSequence
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02172D68: .word 0x05000600
	arm_func_end VSViewFriendCodeMenu__InitSprites

	arm_func_start VSViewFriendCodeMenu__ReleaseSprites
VSViewFriendCodeMenu__ReleaseSprites: // 0x02172D6C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r6, #0
	add r7, r8, #4
	mov r5, r6
	mov r4, #0x64
_02172D84:
	mov r0, r7
	bl AnimatorSprite__Release
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl MIi_CpuClear16
	add r6, r6, #1
	cmp r6, #0xc
	add r7, r7, #0x64
	blt _02172D84
	ldr r0, [r8]
	mov r1, #0
	str r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end VSViewFriendCodeMenu__ReleaseSprites

	arm_func_start VSViewFriendCodeMenu__Main
VSViewFriendCodeMenu__Main: // 0x02172DBC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bl GetCurrentTaskWork_
	mov r7, r0
	ldr r0, [r7, #0x4b8]
	cmp r0, #0
	bne _02172DF0
	mov r0, #1
	bl VSViewFriendCodeMenu__Func_2173154
	mov r1, #0
	ldr r0, _02172EF0 // =VSViewFriendCodeMenu__Main_2172EF8
	str r1, [r7, #0x4b4]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02172DF0:
	mov r8, #0
	ldr r4, _02172EF4 // =0x00001333
	mov r10, r8
	add r9, r7, #4
	mov r6, #0x1000
	mov r5, r8
	mov r11, #6
_02172E0C:
	mov r1, #0
	mov r0, r9
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [r7, #0x4b4]
	sub r0, r0, r10
	subs r3, r0, #0x10
	bmi _02172EAC
	cmp r3, #6
	bge _02172E64
	mov r0, r5
	mov r1, r4
	mov r2, r11
	str r6, [sp]
	bl Unknown2051334__Func_2051534
	mov r0, r0, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, r9
	mov r2, r1
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
	b _02172EAC
_02172E64:
	cmp r3, #9
	bge _02172EA4
	mov r0, #0x1000
	str r0, [sp]
	mov r0, r4
	mov r1, #0x1000
	mov r2, #3
	sub r3, r3, #6
	bl Unknown2051334__Func_2051534
	mov r0, r0, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, r9
	mov r2, r1
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
	b _02172EAC
_02172EA4:
	mov r0, r9
	bl AnimatorSprite__DrawFrame
_02172EAC:
	add r8, r8, #1
	cmp r8, #0xc
	add r9, r9, #0x64
	add r10, r10, #2
	blt _02172E0C
	ldr r0, [r7, #0x4b4]
	cmp r0, #0x2f
	addlo r0, r0, #1
	strlo r0, [r7, #0x4b4]
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, #1
	bl VSViewFriendCodeMenu__Func_2173154
	mov r1, #0
	ldr r0, _02172EF0 // =VSViewFriendCodeMenu__Main_2172EF8
	str r1, [r7, #0x4b4]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02172EF0: .word VSViewFriendCodeMenu__Main_2172EF8
_02172EF4: .word 0x00001333
	arm_func_end VSViewFriendCodeMenu__Main

	arm_func_start VSViewFriendCodeMenu__Main_2172EF8
VSViewFriendCodeMenu__Main_2172EF8: // 0x02172EF8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, #0
	bl GetCurrentTaskWork_
	ldr r1, _02172FA4 // =padInput
	mov r5, r0
	ldrh r0, [r1, #4]
	tst r0, #2
	bne _02172F24
	bl VSViewFriendCodeMenu__Func_2173184
	cmp r0, #0
	beq _02172F30
_02172F24:
	mov r6, #1
	mov r0, r6
	bl PlaySysMenuNavSfx
_02172F30:
	ldr r0, [r5, #0x4b8]
	cmp r0, #0
	beq _02172F70
	mov r7, #0
	add r8, r5, #4
	mov r4, r7
_02172F48:
	mov r0, r8
	mov r1, r4
	mov r2, r4
	bl AnimatorSprite__ProcessAnimation
	mov r0, r8
	bl AnimatorSprite__DrawFrame
	add r7, r7, #1
	cmp r7, #0xc
	add r8, r8, #0x64
	blt _02172F48
_02172F70:
	cmp r6, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #0
	bl VSViewFriendCodeMenu__Func_2173154
	ldr r0, _02172FA8 // =0x0000FFFF
	blx VSMenu__SetNetworkMessageSequence
	ldr r0, _02172FA8 // =0x0000FFFF
	blx VSMenu__Func_21667F0
	mov r1, #0
	ldr r0, _02172FAC // =VSViewFriendCodeMenu__Main_2172FB0
	str r1, [r5, #0x4b4]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02172FA4: .word padInput
_02172FA8: .word 0x0000FFFF
_02172FAC: .word VSViewFriendCodeMenu__Main_2172FB0
	arm_func_end VSViewFriendCodeMenu__Main_2172EF8

	arm_func_start VSViewFriendCodeMenu__Main_2172FB0
VSViewFriendCodeMenu__Main_2172FB0: // 0x02172FB0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bl GetCurrentTaskWork_
	mov r7, r0
	ldr r0, [r7, #0x4b8]
	cmp r0, #0
	bne _02172FD0
	bl DestroyCurrentTask
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02172FD0:
	mov r8, #0
	mov r4, #0x1000
	ldr r5, _021730B8 // =0x00001333
	mov r10, r8
	add r9, r7, #4
	mov r6, r4
	mov r11, #3
_02172FEC:
	mov r1, #0
	mov r0, r9
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [r7, #0x4b4]
	sub r0, r0, r10
	subs r3, r0, #0x10
	bpl _02173018
	mov r0, r9
	bl AnimatorSprite__DrawFrame
	b _02173088
_02173018:
	cmp r3, #3
	bge _02173050
	mov r0, r6
	mov r1, r5
	mov r2, r11
	str r6, [sp]
	bl Unknown2051334__Func_2051534
	mov r0, r0, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, r9
	mov r2, r1
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
	b _02173088
_02173050:
	cmp r3, #9
	bge _02173088
	mov r0, r5
	mov r1, #0
	mov r2, #6
	sub r3, r3, #3
	str r4, [sp]
	bl Unknown2051334__Func_2051534
	mov r0, r0, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, r9
	mov r2, r1
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
_02173088:
	add r8, r8, #1
	cmp r8, #0xc
	add r9, r9, #0x64
	add r10, r10, #2
	blt _02172FEC
	ldr r0, [r7, #0x4b4]
	cmp r0, #0x2f
	addlo r0, r0, #1
	strlo r0, [r7, #0x4b4]
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl DestroyCurrentTask
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021730B8: .word 0x00001333
	arm_func_end VSViewFriendCodeMenu__Main_2172FB0

	arm_func_start VSViewFriendCodeMenu__Destructor
VSViewFriendCodeMenu__Destructor: // 0x021730BC
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	bl VSViewFriendCodeMenu__ReleaseSprites
	ldmia sp!, {r3, pc}
	arm_func_end VSViewFriendCodeMenu__Destructor

	arm_func_start VSViewFriendCodeMenu__Func_21730CC
VSViewFriendCodeMenu__Func_21730CC: // 0x021730CC
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r6, r0
	ldr r0, _02173150 // =0x0213529C
	bl DWC_CreateFriendKey
	mov r5, r1
	mov r4, r0
	cmp r5, #0
	cmpeq r4, #0
	mov r1, #0
	beq _0217312C
	add r0, sp, #0
	mov r1, r4
	mov r2, r5
	bl DWC_Acc_FriendKeyToNumericKey
	add r2, sp, #0
	mov r1, #0
_02173110:
	ldrsb r0, [r2], #1
	sub r0, r0, #0x30
	strb r0, [r6, r1]
	add r1, r1, #1
	cmp r1, #0xc
	blt _02173110
	b _02173138
_0217312C:
	mov r0, r6
	mov r2, #0xc
	bl MI_CpuFill8
_02173138:
	mov r0, #0
	cmp r5, r0
	cmpeq r4, r0
	movne r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02173150: .word 0x0213529C
	arm_func_end VSViewFriendCodeMenu__Func_21730CC

	arm_func_start VSViewFriendCodeMenu__Func_2173154
VSViewFriendCodeMenu__Func_2173154: // 0x02173154
	stmdb sp!, {r3, lr}
	cmp r0, #0
	beq _02173170
	ldr r0, _02173180 // =VSViewFriendCodeMenu__Func_217319C
	mov r1, #0
	blx VSMenu__SetTouchCallback
	ldmia sp!, {r3, pc}
_02173170:
	mov r0, #0
	mov r1, r0
	blx VSMenu__SetTouchCallback
	ldmia sp!, {r3, pc}
	.align 2, 0
_02173180: .word VSViewFriendCodeMenu__Func_217319C
	arm_func_end VSViewFriendCodeMenu__Func_2173154

	arm_func_start VSViewFriendCodeMenu__Func_2173184
VSViewFriendCodeMenu__Func_2173184: // 0x02173184
	stmdb sp!, {r3, lr}
	blx VSMenu__GetUnknownTouchResponseFlags
	tst r0, #0x40000
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end VSViewFriendCodeMenu__Func_2173184

	arm_func_start VSViewFriendCodeMenu__Func_217319C
VSViewFriendCodeMenu__Func_217319C: // 0x0217319C
	bx lr
	arm_func_end VSViewFriendCodeMenu__Func_217319C
	
	.data

aNarcDmwfFcLz7N: // 0x0217EE98
	.asciz "narc/dmwf_fc_lz7.narc"
	.align 4
