	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start VSRecordsMenu__LoadAssets
VSRecordsMenu__LoadAssets: // 0x021731A0
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear32
	mov r1, #0
	ldr r0, _021731D0 // =aNarcDmwfVsrecL
	str r1, [r4]
	bl ArchiveFileUnknown__LoadFile
	str r0, [r4, #4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021731D0: .word aNarcDmwfVsrecL
	arm_func_end VSRecordsMenu__LoadAssets

	arm_func_start VSRecordsMenu__ReleaseAssets
VSRecordsMenu__ReleaseAssets: // 0x021731D4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #4]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #4]
	ldmia sp!, {r4, pc}
	arm_func_end VSRecordsMenu__ReleaseAssets

	arm_func_start VSRecordsMenu__Create
VSRecordsMenu__Create: // 0x021731F8
	ldr ip, _02173200 // =VSRecordsMenu__Func_2173218
	bx ip
	.align 2, 0
_02173200: .word VSRecordsMenu__Func_2173218
	arm_func_end VSRecordsMenu__Create

	arm_func_start VSRecordsMenu__Func_2173204
VSRecordsMenu__Func_2173204: // 0x02173204
	ldr r0, [r0, #0]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end VSRecordsMenu__Func_2173204

	arm_func_start VSRecordsMenu__Func_2173218
VSRecordsMenu__Func_2173218: // 0x02173218
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r2, #0
	mov r1, #0x10
	stmia sp, {r1, r2}
	mov r5, r0
	mov r4, #0x318
	ldr r0, _021732AC // =VSRecordsMenu__Main
	ldr r1, _021732B0 // =VSRecordsMenu__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	str r0, [r5]
	ldr r0, _021732B4 // =0x0000FFFF
	bl VSMenu__SetNetworkMessageSequence
	ldr r0, [r5, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x318
	bl MIi_CpuClear32
	str r5, [r4]
	mov r0, #0
	str r0, [r4, #4]
	bl VSMenu__GetFontWindow
	str r0, [r4, #0xd0]
	mov r0, #0
	bl VSRecordsMenu__Func_2173B0C
	mov r0, r4
	bl VSRecordsMenu__Func_21732B8
	mov r0, r4
	bl VSRecordsMenu__Func_2173320
	mov r0, r4
	bl VSRecordsMenu__Func_2173474
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_021732AC: .word VSRecordsMenu__Main
_021732B0: .word VSRecordsMenu__Destructor
_021732B4: .word 0x0000FFFF
	arm_func_end VSRecordsMenu__Func_2173218

	arm_func_start VSRecordsMenu__Func_21732B8
VSRecordsMenu__Func_21732B8: // 0x021732B8
	stmdb sp!, {r3, lr}
	mov r0, #0
	bl VSRecordsMenu__Func_2173940
	ldr ip, _02173310 // =0x0400000C
	ldr r1, _02173314 // =0x06004000
	ldrh r3, [ip]
	mov r0, #0
	mov r2, #0x20
	and r3, r3, #0x43
	orr r3, r3, #4
	orr r3, r3, #0x400
	strh r3, [ip]
	bl MIi_CpuClearFast
	ldr r1, _02173318 // =0x06002000
	mov r0, #0
	mov r2, #0x600
	bl MIi_CpuClearFast
	ldr r0, _0217331C // =renderCoreGFXControlA
	mov r1, #0
	strh r1, [r0, #8]
	strh r1, [r0, #0xa]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02173310: .word 0x0400000C
_02173314: .word 0x06004000
_02173318: .word 0x06002000
_0217331C: .word renderCoreGFXControlA
	arm_func_end VSRecordsMenu__Func_21732B8

	arm_func_start VSRecordsMenu__Func_2173320
VSRecordsMenu__Func_2173320: // 0x02173320
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02173364
_02173340: // jump table
	b _02173358 // case 0
	b _02173358 // case 1
	b _02173358 // case 2
	b _02173358 // case 3
	b _02173358 // case 4
	b _02173358 // case 5
_02173358:
	bl RenderCore_GetLanguagePtr
	ldrb r1, [r0, #0]
	b _02173368
_02173364:
	mov r1, #1
_02173368:
	ldr r0, [r4, #0]
	mov r1, r1, lsl #0x10
	ldr r0, [r0, #4]
	mov r1, r1, lsr #0x10
	bl FileUnknown__GetAOUFile
	mov r1, #0
	mov r5, r0
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r1, _02173470 // =0x05000200
	mov r0, #3
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	str r2, [sp, #0x18]
	add r0, r4, #8
	mov r1, r5
	mov r3, r2
	bl AnimatorSprite__Init
	mov r0, #0x10
	strh r0, [r4, #0x10]
	mov r0, #0x30
	strh r0, [r4, #0x12]
	mov r0, #0
	strh r0, [r4, #0x58]
	mov r0, r5
	mov r1, #1
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, r5
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr r2, _02173470 // =0x05000200
	mov r0, #3
	str r2, [sp, #0x10]
	str r0, [sp, #0x14]
	str r3, [sp, #0x18]
	add r0, r4, #0x6c
	mov r2, #1
	bl AnimatorSprite__Init
	mov r0, #0x10
	strh r0, [r4, #0x74]
	mov r0, #0x68
	strh r0, [r4, #0x76]
	mov r1, #0
	strh r1, [r4, #0xbc]
	add r0, r4, #8
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x6c
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02173470: .word 0x05000200
	arm_func_end VSRecordsMenu__Func_2173320

	arm_func_start VSRecordsMenu__Func_2173474
VSRecordsMenu__Func_2173474: // 0x02173474
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x34
	mov r4, r0
	mov r0, #0xc00
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x314]
	mov r1, r0
	mov r0, #0
	mov r2, #0xc00
	bl MIi_CpuClearFast
	add r0, r4, #0xd4
	str r0, [sp, #0x20]
	mov r0, #9
	ldr r8, [r4, #0x314]
	str r0, [sp, #0x28]
	mov r0, #0
	str r0, [sp, #0x30]
	mov r9, #0x20
	mov r11, #4
	mov r4, #2
_021734C4:
	ldr r0, [sp, #0x28]
	mov r7, #0xf
	str r0, [sp, #0x24]
	mov r0, #0
	str r0, [sp, #0x2c]
	ldr r0, [sp, #0x20]
	str r0, [sp, #0x1c]
_021734E0:
	ldr r0, [sp, #0x24]
	ldr r10, [sp, #0x1c]
	mov r0, r0, lsl #0x10
	mov r6, #0
	mov r5, r0, lsr #0x10
_021734F4:
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	stmia sp, {r0, r5, r11}
	str r4, [sp, #0xc]
	mov r1, #0
	str r8, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	mov r0, r10
	mov r2, r4
	mov r3, r1
	str r9, [sp, #0x18]
	bl Unknown2056570__Init
	mov r0, r10
	mov r1, #0
	bl Unknown2056570__Func_2056688
	add r6, r6, #1
	add r8, r8, #0x100
	add r9, r9, #0x100
	add r7, r7, #5
	add r10, r10, #0x30
	cmp r6, #3
	blt _021734F4
	ldr r0, [sp, #0x24]
	mov r7, #0xf
	add r0, r0, #2
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x1c]
	add r0, r0, #0x90
	str r0, [sp, #0x1c]
	ldr r0, [sp, #0x2c]
	add r0, r0, #1
	str r0, [sp, #0x2c]
	cmp r0, #2
	blt _021734E0
	ldr r0, [sp, #0x30]
	add r0, r0, #1
	str r0, [sp, #0x30]
	cmp r0, #2
	ldr r0, [sp, #0x28]
	add r0, r0, #7
	str r0, [sp, #0x28]
	ldr r0, [sp, #0x20]
	add r0, r0, #0x120
	str r0, [sp, #0x20]
	blt _021734C4
	ldr r0, _021735C4 // =FontAnimator__Palettes+0x00000008
	ldr r1, _021735C8 // =0x05000002
	mov r2, #8
	bl MIi_CpuCopy16
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021735C4: .word FontAnimator__Palettes+0x00000008
_021735C8: .word 0x05000002
	arm_func_end VSRecordsMenu__Func_2173474

	arm_func_start VSRecordsMenu__Func_21735CC
VSRecordsMenu__Func_21735CC: // 0x021735CC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl VSRecordsMenu__Func_2173648
	mov r0, r4
	bl VSRecordsMenu__Func_217361C
	mov r0, r4
	bl VSRecordsMenu__Func_21735F8
	ldr r0, [r4, #0]
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r4, pc}
	arm_func_end VSRecordsMenu__Func_21735CC

	arm_func_start VSRecordsMenu__Func_21735F8
VSRecordsMenu__Func_21735F8: // 0x021735F8
	stmdb sp!, {r3, lr}
	mov r0, #0
	bl VSRecordsMenu__Func_2173940
	ldr r1, _02173618 // =0x06002000
	mov r0, #0
	mov r2, #0x600
	bl MIi_CpuClearFast
	ldmia sp!, {r3, pc}
	.align 2, 0
_02173618: .word 0x06002000
	arm_func_end VSRecordsMenu__Func_21735F8

	arm_func_start VSRecordsMenu__Func_217361C
VSRecordsMenu__Func_217361C: // 0x0217361C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #8
	bl AnimatorSprite__Release
	add r0, r4, #0x6c
	bl AnimatorSprite__Release
	add r1, r4, #8
	mov r0, #0
	mov r2, #0xc8
	bl MIi_CpuClear32
	ldmia sp!, {r4, pc}
	arm_func_end VSRecordsMenu__Func_217361C

	arm_func_start VSRecordsMenu__Func_2173648
VSRecordsMenu__Func_2173648: // 0x02173648
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r5, #0
	str r0, [sp]
	add r8, r0, #0xd4
	mov r4, r5
	mov r11, r5
_02173660:
	mov r6, r11
	mov r9, r8
_02173668:
	mov r7, r4
	mov r10, r9
_02173670:
	mov r0, r10
	bl Unknown2056570__Func_2056670
	add r7, r7, #1
	cmp r7, #3
	add r10, r10, #0x30
	blt _02173670
	add r6, r6, #1
	cmp r6, #2
	add r9, r9, #0x90
	blt _02173668
	add r5, r5, #1
	cmp r5, #2
	add r8, r8, #0x120
	blt _02173660
	ldr r0, [sp]
	ldr r0, [r0, #0x314]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl _FreeHEAP_USER
	ldr r0, [sp]
	mov r1, #0
	str r1, [r0, #0x314]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end VSRecordsMenu__Func_2173648

	arm_func_start VSRecordsMenu__Main
VSRecordsMenu__Main: // 0x021736CC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, r1
	add r0, r4, #8
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x6c
	bl AnimatorSprite__ProcessAnimation
	ldr r3, [r4, #4]
	cmp r3, #0x18
	bhs _02173750
	mov ip, #0x2000
	mov r0, #0x80
	mov r1, #0
	mov r2, #0x18
	str ip, [sp]
	bl Unknown2051334__Func_2051534
	mov r2, #0x10
	strh r2, [r4, #0x10]
	rsb r1, r0, #0x30
	strh r1, [r4, #0x12]
	add r1, r0, #0x68
	strh r2, [r4, #0x74]
	add r0, r4, #8
	strh r1, [r4, #0x76]
	bl AnimatorSprite__DrawFrame
	add r0, r4, #0x6c
	bl AnimatorSprite__DrawFrame
	b _0217377C
_02173750:
	mov r1, #0x10
	strh r1, [r4, #0x10]
	mov r0, #0x30
	strh r0, [r4, #0x12]
	strh r1, [r4, #0x74]
	mov r1, #0x68
	add r0, r4, #8
	strh r1, [r4, #0x76]
	bl AnimatorSprite__DrawFrame
	add r0, r4, #0x6c
	bl AnimatorSprite__DrawFrame
_0217377C:
	ldr r0, [r4, #4]
	cmp r0, #0xc
	bhs _02173798
	mov r1, r0, lsl #0x10
	mov r0, r4
	mov r1, r1, lsr #0x10
	bl VSRecordsMenu__Func_2173994
_02173798:
	ldr r0, [r4, #4]
	cmp r0, #0x18
	addlo r0, r0, #1
	addlo sp, sp, #4
	strlo r0, [r4, #4]
	ldmloia sp!, {r3, r4, pc}
	mov r0, #1
	bl VSRecordsMenu__Func_2173940
	mov r0, #1
	bl VSRecordsMenu__Func_2173B0C
	mov r1, #0
	ldr r0, _021737D8 // =VSRecordsMenu__Main_217387C
	str r1, [r4, #4]
	bl SetCurrentTaskMainEvent
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021737D8: .word VSRecordsMenu__Main_217387C
	arm_func_end VSRecordsMenu__Main

	arm_func_start VSRecordsMenu__Main_21737DC
VSRecordsMenu__Main_21737DC: // 0x021737DC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, r1
	add r0, r4, #8
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x6c
	bl AnimatorSprite__ProcessAnimation
	ldr r3, [r4, #4]
	cmp r3, #0x18
	bhs _02173858
	mov r0, #0
	mov r1, #0x80
	mov r2, #0x18
	str r0, [sp]
	bl Unknown2051334__Func_2051534
	mov r2, #0x10
	strh r2, [r4, #0x10]
	rsb r1, r0, #0x30
	strh r1, [r4, #0x12]
	add r1, r0, #0x68
	strh r2, [r4, #0x74]
	add r0, r4, #8
	strh r1, [r4, #0x76]
	bl AnimatorSprite__DrawFrame
	add r0, r4, #0x6c
	bl AnimatorSprite__DrawFrame
_02173858:
	ldr r0, [r4, #4]
	cmp r0, #0x18
	addlo r0, r0, #1
	addlo sp, sp, #4
	strlo r0, [r4, #4]
	ldmloia sp!, {r3, r4, pc}
	bl DestroyCurrentTask
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end VSRecordsMenu__Main_21737DC

	arm_func_start VSRecordsMenu__Main_217387C
VSRecordsMenu__Main_217387C: // 0x0217387C
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r3, #0x10
	mov r1, #0
	strh r3, [r4, #0x10]
	mov r0, #0x30
	strh r0, [r4, #0x12]
	mov r2, r1
	strh r3, [r4, #0x74]
	mov r3, #0x68
	add r0, r4, #8
	strh r3, [r4, #0x76]
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x6c
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #8
	bl AnimatorSprite__DrawFrame
	add r0, r4, #0x6c
	bl AnimatorSprite__DrawFrame
	ldr r0, _02173924 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #2
	bne _021738F0
	bl VSRecordsMenu__Func_2173B3C
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
_021738F0:
	mov r0, #1
	bl PlaySysMenuNavSfx
	mov r0, #0
	bl VSRecordsMenu__Func_2173940
	mov r0, #0
	bl VSRecordsMenu__Func_2173B0C
	ldr r0, _02173928 // =0x0000FFFF
	bl VSMenu__Func_21667F0
	mov r1, #0
	ldr r0, _0217392C // =VSRecordsMenu__Main_21737DC
	str r1, [r4, #4]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02173924: .word padInput
_02173928: .word 0x0000FFFF
_0217392C: .word VSRecordsMenu__Main_21737DC
	arm_func_end VSRecordsMenu__Main_217387C

	arm_func_start VSRecordsMenu__Destructor
VSRecordsMenu__Destructor: // 0x02173930
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	bl VSRecordsMenu__Func_21735CC
	ldmia sp!, {r3, pc}
	arm_func_end VSRecordsMenu__Destructor

	arm_func_start VSRecordsMenu__Func_2173940
VSRecordsMenu__Func_2173940: // 0x02173940
	cmp r0, #0
	mov r2, #0x4000000
	beq _02173970
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #4
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
_02173970:
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	bic r0, r3, #4
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
	arm_func_end VSRecordsMenu__Func_2173940

	arm_func_start VSRecordsMenu__Func_2173994
VSRecordsMenu__Func_2173994: // 0x02173994
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	cmp r1, #0xc
	mov r7, r0
	addhs sp, sp, #0x24
	ldmhsia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, #0x30
	mul r5, r1, r0
	cmp r1, #6
	add r6, r7, #0xd4
	bhs _021739E8
	cmp r1, #3
	bhs _021739D8
	mov r0, r1
	bl VSRecordsMenu__Func_2173B58
	mov r4, r0
	b _02173A0C
_021739D8:
	sub r0, r1, #3
	bl VSRecordsMenu__Func_2173B64
	mov r4, r0
	b _02173A0C
_021739E8:
	cmp r1, #9
	bhs _02173A00
	sub r0, r1, #6
	bl VSRecordsMenu__Func_2173B70
	mov r4, r0
	b _02173A0C
_02173A00:
	sub r0, r1, #9
	bl VSRecordsMenu__Func_2173B7C
	mov r4, r0
_02173A0C:
	ldr r0, _02173AFC // =0x0000270F
	cmp r4, r0
	movgt r4, r0
	ldr r0, [r7, #0xd0]
	bl FontWindow__GetFont
	ldr r7, _02173B00 // =0x10624DD3
	mov r1, r4, lsr #0x1f
	smull r3, r2, r7, r4
	add r2, r1, r2, asr #6
	mov r1, #0x3e8
	mul r1, r2, r1
	sub r8, r4, r1
	ldr r7, _02173B04 // =0x51EB851F
	mov r3, r8, lsr #0x1f
	smull r4, r1, r7, r8
	add r1, r3, r1, asr #5
	mov r3, #0x64
	mul r3, r1, r3
	sub r9, r8, r3
	ldr r4, _02173B08 // =0x66666667
	mov r7, r0
	mov r0, r9, lsr #0x1f
	smull r3, r8, r4, r9
	add r8, r0, r8, asr #2
	mov r0, #0xa
	mul r0, r8, r0
	sub r3, r9, r0
	mov r0, #0x30
	str r2, [sp, #0x14]
	str r1, [sp, #0x18]
	str r8, [sp, #0x1c]
	str r3, [sp, #0x20]
	bl GetFontCharacterFromUTF
	mov r9, #0
	mov r8, r0
	mov r10, r9
	mov r4, r9
	add r11, sp, #0x14
_02173AA4:
	mov r0, r10, lsl #0x10
	mov r1, r0, asr #0x10
	ldr r0, [r11, r9, lsl #2]
	stmia sp, {r1, r4}
	add r0, r8, r0
	mov r1, r0, lsl #0x10
	str r4, [sp, #8]
	str r4, [sp, #0xc]
	mov r0, r7
	mov r2, r4
	mov r1, r1, lsr #0x10
	add r3, r6, r5
	str r4, [sp, #0x10]
	bl FontFile__Func_2052DD0
	add r9, r9, #1
	cmp r9, #4
	add r10, r10, #8
	blt _02173AA4
	add r0, r6, r5
	bl Unknown2056570__Func_2056B8C
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02173AFC: .word 0x0000270F
_02173B00: .word 0x10624DD3
_02173B04: .word 0x51EB851F
_02173B08: .word 0x66666667
	arm_func_end VSRecordsMenu__Func_2173994

	arm_func_start VSRecordsMenu__Func_2173B0C
VSRecordsMenu__Func_2173B0C: // 0x02173B0C
	stmdb sp!, {r3, lr}
	cmp r0, #0
	beq _02173B28
	ldr r0, _02173B38 // =VSRecordsMenu__Func_2173B54
	mov r1, #0
	bl VSMenu__SetTouchCallback
	ldmia sp!, {r3, pc}
_02173B28:
	mov r0, #0
	mov r1, r0
	bl VSMenu__SetTouchCallback
	ldmia sp!, {r3, pc}
	.align 2, 0
_02173B38: .word VSRecordsMenu__Func_2173B54
	arm_func_end VSRecordsMenu__Func_2173B0C

	arm_func_start VSRecordsMenu__Func_2173B3C
VSRecordsMenu__Func_2173B3C: // 0x02173B3C
	stmdb sp!, {r3, lr}
	bl VSMenu__GetUnknownTouchResponseFlags
	tst r0, #0x40000
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end VSRecordsMenu__Func_2173B3C

	arm_func_start VSRecordsMenu__Func_2173B54
VSRecordsMenu__Func_2173B54: // 0x02173B54
	bx lr
	arm_func_end VSRecordsMenu__Func_2173B54

	arm_func_start VSRecordsMenu__Func_2173B58
VSRecordsMenu__Func_2173B58: // 0x02173B58
	ldr ip, _02173B60 // =SaveGame__GetWirelessRaceRecord
	bx ip
	.align 2, 0
_02173B60: .word SaveGame__GetWirelessRaceRecord
	arm_func_end VSRecordsMenu__Func_2173B58

	arm_func_start VSRecordsMenu__Func_2173B64
VSRecordsMenu__Func_2173B64: // 0x02173B64
	ldr ip, _02173B6C // =SaveGame__GetWirelessRingBattleRecord
	bx ip
	.align 2, 0
_02173B6C: .word SaveGame__GetWirelessRingBattleRecord
	arm_func_end VSRecordsMenu__Func_2173B64

	arm_func_start VSRecordsMenu__Func_2173B70
VSRecordsMenu__Func_2173B70: // 0x02173B70
	ldr ip, _02173B78 // =SaveGame__GetNetworkRaceRecord
	bx ip
	.align 2, 0
_02173B78: .word SaveGame__GetNetworkRaceRecord
	arm_func_end VSRecordsMenu__Func_2173B70

	arm_func_start VSRecordsMenu__Func_2173B7C
VSRecordsMenu__Func_2173B7C: // 0x02173B7C
	ldr ip, _02173B84 // =SaveGame__GetNetworkRingBattleRecord
	bx ip
	.align 2, 0
_02173B84: .word SaveGame__GetNetworkRingBattleRecord
	arm_func_end VSRecordsMenu__Func_2173B7C

	.data
	
aNarcDmwfVsrecL: // 0x0217EEB0
	.asciz "narc/dmwf_vsrec_lz7.narc"
	.align 4