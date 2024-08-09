	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SeaMapTraining__Create
SeaMapTraining__Create: // 0x02170ADC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	bl LoadSpriteButtonCursorSprite
	bl LoadSpriteButtonTouchpadSprite
	mov r2, #0
	str r2, [sp]
	ldr r0, _02170BB0 // =SeaMapTraining__Main
	ldr r1, _02170BB4 // =SeaMapTraining__Destructor
	mov r3, r2
	str r2, [sp, #4]
	mov r4, #0xe0
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0xe0
	bl MIi_CpuClear16
	ldr r1, _02170BB8 // =SeaMapTraining__State_InitNavTails
	add r0, r4, #0x1c
	str r1, [r4]
	bl TouchField__Init
	add r0, r4, #8
	bl SeaMapTraining__LoadAssets
	bl SeaMapTraining__SetupDisplay
	mov r0, r4
	bl SeaMapTraining__InitUnknown
	mov r0, r4
	bl SeaMapTraining__InitBackground
	mov r0, r4
	bl SeaMapTraining__InitSprites
	mov r0, #1
	mov r1, #0
	mov r2, r1
	bl CreateNavTails
	bl ReleaseAudioSystem
	ldr r0, _02170BBC // =aSndSysSoundDat_3
	bl LoadAudioSndArc
	mov r0, #6
	ldr r1, _02170BC0 // =audioManagerSndHeap
	ldr r1, [r1]
	bl NNS_SndArcLoadGroup
	mov r0, #7
	str r0, [sp]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlayTrack
	bl ResetTouchInput
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02170BB0: .word SeaMapTraining__Main
_02170BB4: .word SeaMapTraining__Destructor
_02170BB8: .word SeaMapTraining__State_InitNavTails
_02170BBC: .word aSndSysSoundDat_3
_02170BC0: .word audioManagerSndHeap
	arm_func_end SeaMapTraining__Create

	arm_func_start SeaMapTraining__Main
SeaMapTraining__Main: // 0x02170BC4
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4]
	blx r1
	ldr r0, [r4, #4]
	cmp r0, #0
	mov r0, r4
	bne _02170BF0
	bl SeaMapTraining__DrawLogo
	ldmia sp!, {r4, pc}
_02170BF0:
	bl SeaMapTraining__Destroy
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapTraining__Main

	arm_func_start SeaMapTraining__Destructor
SeaMapTraining__Destructor: // 0x02170BF8
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl SeaMapTraining__Func_2170E74
	mov r0, r4
	bl SeaMapTraining__Func_217101C
	add r0, r4, #8
	bl SeaMapTraining__ReleaseAssets
	bl ReleaseAudioSystem
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapTraining__Destructor

	arm_func_start SeaMapTraining__Destroy
SeaMapTraining__Destroy: // 0x02170C20
	stmdb sp!, {r3, lr}
	bl SeaMapChartCourseView__Destroy
	bl ReleaseSpriteButtonCursorSprite
	bl ReleaseSpriteButtonTouchpadSprite
	bl DestroyCurrentTask
	bl GetSysEventList
	ldrsh r0, [r0, #0xe]
	cmp r0, #0x1c
	bne _02170C58
	ldr r1, _02170C70 // =gameState
	mov r0, #1
	strb r0, [r1, #0xdc]
	bl RequestSysEventChange
	b _02170C68
_02170C58:
	mov r0, #2
	bl SaveGame__Func_205B9F0
	mov r0, #0
	bl RequestSysEventChange
_02170C68:
	bl NextSysEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02170C70: .word gameState
	arm_func_end SeaMapTraining__Destroy

	arm_func_start SeaMapTraining__DrawLogo
SeaMapTraining__DrawLogo: // 0x02170C74
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x18]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x34
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x34
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapTraining__DrawLogo

	arm_func_start SeaMapTraining__LoadAssets
SeaMapTraining__LoadAssets: // 0x02170CA4
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x68
	mov r5, r0
	mov r1, r5
	mov r0, #0
	mov r2, #0xc
	bl MIi_CpuClear16
	mov r1, #6
	ldr r0, _02170D38 // =aBbChBb_0
	sub r2, r1, #7
	bl ReadFileFromBundle
	mov r4, r0
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	str r0, [r5]
	mov r1, r0
	mov r0, r4
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	ldr r1, _02170D3C // =_0217EE74
	ldr r2, [r5]
	add r0, sp, #0
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #0
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r5, #4]
	add r0, sp, #0
	mov r1, #1
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r5, #8]
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	add sp, sp, #0x68
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02170D38: .word aBbChBb_0
_02170D3C: .word _0217EE74
	arm_func_end SeaMapTraining__LoadAssets

	arm_func_start SeaMapTraining__ReleaseAssets
SeaMapTraining__ReleaseAssets: // 0x02170D40
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4]
	bl _FreeHEAP_USER
	mov r1, r4
	mov r0, #0
	mov r2, #0xc
	bl MIi_CpuClear16
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapTraining__ReleaseAssets

	arm_func_start SeaMapTraining__SetupDisplay
SeaMapTraining__SetupDisplay: // 0x02170D64
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	bl VRAMSystem__Reset
	mov r0, #8
	bl VRAMSystem__SetupBGBank
	mov ip, #0x400
	mov r0, #0x60
	mov r1, #0x10
	mov r2, #0x40
	mov r3, #0
	str ip, [sp]
	bl VRAMSystem__SetupOBJBank
	mov r0, #4
	bl VRAMSystem__SetupSubBGBank
	mov r0, #0x200
	str r0, [sp]
	mov r0, #0x100
	mov r1, #0x10
	mov r2, #0x40
	mov r3, #0
	bl VRAMSystem__SetupSubOBJBank
	ldr r1, _02170E5C // =VRAMSystem__GFXControl
	mov r0, #1
	ldr r4, [r1]
	mov r1, #0
	mov r2, r1
	bl GX_SetGraphicsMode
	ldr ip, _02170E60 // =0x0400000E
	mov r0, #0
	ldrh r3, [ip]
	mov r1, r4
	mov r2, #0x10
	and r3, r3, #0x43
	orr r3, r3, #8
	strh r3, [ip]
	bl MIi_CpuClear32
	mov r0, #0
	mov r1, r4
	mov r2, #0x10
	bl MIi_CpuClear32
	mov r0, #0
	add r1, r4, #0x10
	mov r2, #0x10
	bl MIi_CpuClear16
	mov r0, #0
	add r1, r4, #0x20
	mov r2, #6
	bl MIi_CpuClear16
	add r1, r4, #0x5a
	mov r0, #0
	mov r2, #2
	bl MIi_CpuClear16
	mov r2, #0x4000000
	ldr r0, [r2]
	mov r1, #0
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1800
	str r0, [r2]
	ldr r0, _02170E64 // =renderCurrentDisplay
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02170E5C: .word VRAMSystem__GFXControl
_02170E60: .word 0x0400000E
_02170E64: .word renderCurrentDisplay
	arm_func_end SeaMapTraining__SetupDisplay

	arm_func_start SeaMapTraining__InitUnknown
SeaMapTraining__InitUnknown: // 0x02170E68
	mov r1, #1
	str r1, [r0, #0x14]
	bx lr
	arm_func_end SeaMapTraining__InitUnknown

	arm_func_start SeaMapTraining__Func_2170E74
SeaMapTraining__Func_2170E74: // 0x02170E74
	ldr r1, [r0, #0x14]
	cmp r1, #0
	movne r1, #0
	strne r1, [r0, #0x14]
	bx lr
	arm_func_end SeaMapTraining__Func_2170E74

	arm_func_start SeaMapTraining__InitBackground
SeaMapTraining__InitBackground: // 0x02170E88
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x54
	ldr r5, [r0, #0x10]
	mov r0, r5
	bl GetBackgroundWidth
	mov r4, r0
	mov r0, r5
	bl GetBackgroundHeight
	mov r1, #3
	stmia sp, {r1, r4}
	str r0, [sp, #8]
	add r0, sp, #0xc
	mov r1, r5
	mov r2, #0x38
	mov r3, #0
	bl InitBackground
	add r0, sp, #0xc
	bl DrawBackground
	add sp, sp, #0x54
	ldmia sp!, {r4, r5, pc}
	arm_func_end SeaMapTraining__InitBackground

	arm_func_start SeaMapTraining__InitSprites
SeaMapTraining__InitSprites: // 0x02170ED8
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x24
	mov r6, r0
	add r5, r6, #0x34
	ldr r4, _0217100C // =0x0217E104
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02170F24
_02170F00: // jump table
	b _02170F18 // case 0
	b _02170F18 // case 1
	b _02170F18 // case 2
	b _02170F18 // case 3
	b _02170F18 // case 4
	b _02170F18 // case 5
_02170F18:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	b _02170F28
_02170F24:
	mov r0, #1
_02170F28:
	ldrb r0, [r4, r0]
	mov r2, #0
	strh r0, [r5, #0xa2]
_02170F34:
	add r0, r4, r2
	ldrb r1, [r0, #8]
	add r0, r5, r2, lsl #1
	add r2, r2, #1
	strh r1, [r0, #0x9c]
	cmp r2, #3
	blt _02170F34
	mov r0, r6
	bl SeaMapTraining__GetSpriteSize
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r1, _02171010 // =VRAMSystem__VRAM_PALETTE_OBJ
	str r3, [sp, #0xc]
	ldr r0, [r1]
	str r0, [sp, #0x10]
	str r3, [sp, #0x14]
	str r3, [sp, #0x18]
	ldrh r2, [r5, #0xa2]
	ldr r1, [r6, #0xc]
	mov r0, r5
	bl AnimatorSprite__Init
	ldrh r2, [r5, #0x9c]
	mov r1, #0x80
	mov r0, #0x60
	strh r2, [r5, #0x50]
	strh r1, [r5, #8]
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r1, #0
	add r2, sp, #0x1c
	bl AnimatorSprite__GetBlockData
	ldr r1, _02171014 // =SeaMapTraining__Func_21710B0
	ldr r2, _02171018 // =TouchField__PointInRect
	stmia sp, {r1, r6}
	add r0, r5, #0x64
	add r1, r5, #8
	add r3, sp, #0x1c
	bl TouchField__InitAreaShape
	add r0, r6, #0x1c
	add r1, r5, #0x64
	mov r2, #0x10
	bl TouchField__AddArea
	mov r0, r5
	mov r1, #0
	bl SetSpriteButtonState
	mov r0, #1
	str r0, [r6, #0x18]
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0217100C: .word 0x0217E104
_02171010: .word VRAMSystem__VRAM_PALETTE_OBJ
_02171014: .word SeaMapTraining__Func_21710B0
_02171018: .word TouchField__PointInRect
	arm_func_end SeaMapTraining__InitSprites

	arm_func_start SeaMapTraining__Func_217101C
SeaMapTraining__Func_217101C: // 0x0217101C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x18]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x34
	bl AnimatorSprite__Release
	add r0, r4, #0x1c
	add r1, r4, #0x98
	bl TouchField__RemoveArea
	mov r0, #0
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapTraining__Func_217101C

	arm_func_start SeaMapTraining__GetSpriteSize
SeaMapTraining__GetSpriteSize: // 0x02171050
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	mov r7, #0
	ldr r6, [r0, #0xc]
	ldr r5, _021710AC // =0x0217E104
	mov r8, r7
	mov r4, r7
_02171068:
	mov sb, r4
_0217106C:
	ldrb r1, [r5, r8]
	mov r0, r6
	add r1, sb, r1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize1FromAnim
	cmp r7, r0
	add sb, sb, #1
	movlo r7, r0
	cmp sb, #2
	blt _0217106C
	add r8, r8, #1
	cmp r8, #8
	blt _02171068
	mov r0, r7
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_021710AC: .word 0x0217E104
	arm_func_end SeaMapTraining__GetSpriteSize

	arm_func_start SeaMapTraining__Func_21710B0
SeaMapTraining__Func_21710B0: // 0x021710B0
	stmdb sp!, {r3, lr}
	ldr r0, [r0]
	ldr r1, [r1, #0x14]
	cmp r0, #0x1000000
	bhi _021710E8
	bhs _0217111C
	cmp r0, #0x40000
	bhi _021710DC
	moveq r0, #1
	streq r0, [r2, #0xd8]
	ldmia sp!, {r3, pc}
_021710DC:
	cmp r0, #0x400000
	beq _02171104
	ldmia sp!, {r3, pc}
_021710E8:
	cmp r0, #0x2000000
	bhi _021710F8
	beq _02171104
	ldmia sp!, {r3, pc}
_021710F8:
	cmp r0, #0x8000000
	beq _0217111C
	ldmia sp!, {r3, pc}
_02171104:
	tst r1, #0x800
	ldmneia sp!, {r3, pc}
	add r0, r2, #0x34
	mov r1, #1
	bl SetSpriteButtonState
	ldmia sp!, {r3, pc}
_0217111C:
	tst r1, #0x800
	ldmneia sp!, {r3, pc}
	add r0, r2, #0x34
	mov r1, #0
	bl SetSpriteButtonState
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapTraining__Func_21710B0

	arm_func_start SeaMapTraining__State_InitNavTails
SeaMapTraining__State_InitNavTails: // 0x02171134
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x2d
	mov r1, #0
	bl NavTailsSpeak
	ldr r0, _02171154 // =SeaMapTraining__State_2171158
	str r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02171154: .word SeaMapTraining__State_2171158
	arm_func_end SeaMapTraining__State_InitNavTails

	arm_func_start SeaMapTraining__State_2171158
SeaMapTraining__State_2171158: // 0x02171158
	stmdb sp!, {r4, lr}
	mov lr, #0
	ldr r3, _021711B4 // =VRAMSystem__GFXControl
	mov ip, #1
	mov r1, lr
_0217116C:
	ldr r4, [r3, lr, lsl #2]
	ldrsh r2, [r4, #0x58]
	cmp r2, #0
	subgt r2, r2, #1
	strgth r2, [r4, #0x58]
	bgt _0217118C
	addlt r2, r2, #1
	strlth r2, [r4, #0x58]
_0217118C:
	ldrsh r2, [r4, #0x58]
	add lr, lr, #1
	cmp r2, #0
	movne ip, r1
	cmp lr, #2
	blt _0217116C
	cmp ip, #0
	ldrne r1, _021711B8 // =SeaMapTraining__State_21711BC
	strne r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021711B4: .word VRAMSystem__GFXControl
_021711B8: .word SeaMapTraining__State_21711BC
	arm_func_end SeaMapTraining__State_2171158

	arm_func_start SeaMapTraining__State_21711BC
SeaMapTraining__State_21711BC: // 0x021711BC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x1c
	bl TouchField__Process
	ldr r0, [r4, #0xd8]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	sub r1, r0, #1
	mov r2, #1
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	str r0, [sp, #4]
	bl PlaySfxEx
	ldr r0, _02171210 // =SeaMapTraining__State_2171214
	str r0, [r4]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02171210: .word SeaMapTraining__State_2171214
	arm_func_end SeaMapTraining__State_21711BC

	arm_func_start SeaMapTraining__State_2171214
SeaMapTraining__State_2171214: // 0x02171214
	ldr r2, _0217123C // =VRAMSystem__GFXControl
	mvn r1, #0xf
	ldr r3, [r2]
	ldrsh r2, [r3, #0x58]
	cmp r2, r1
	subgt r0, r2, #1
	ldrle r1, _02171240 // =SeaMapTraining__State_2171244
	strgth r0, [r3, #0x58]
	strle r1, [r0]
	bx lr
	.align 2, 0
_0217123C: .word VRAMSystem__GFXControl
_02171240: .word SeaMapTraining__State_2171244
	arm_func_end SeaMapTraining__State_2171214

	arm_func_start SeaMapTraining__State_2171244
SeaMapTraining__State_2171244: // 0x02171244
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapTraining__Func_2170E74
	mov r0, r4
	bl SeaMapTraining__Func_217101C
	ldr r0, _02171264 // =SeaMapTraining__State_2171268
	str r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02171264: .word SeaMapTraining__State_2171268
	arm_func_end SeaMapTraining__State_2171244

	arm_func_start SeaMapTraining__State_2171268
SeaMapTraining__State_2171268: // 0x02171268
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0
	mov r1, r0
	mov r2, #2
	bl SeaMapChartCourseView__Create
	ldr r0, _0217128C // =SeaMapTraining__State_2171290
	str r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217128C: .word SeaMapTraining__State_2171290
	arm_func_end SeaMapTraining__State_2171268

	arm_func_start SeaMapTraining__State_2171290
SeaMapTraining__State_2171290: // 0x02171290
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapChartCourseView__Func_2040978
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, #0x3c
	bl NNS_SndPlayerStopSeqAll
	ldr r0, _021712B8 // =SeaMapTraining__State_21712BC
	str r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021712B8: .word SeaMapTraining__State_21712BC
	arm_func_end SeaMapTraining__State_2171290

	arm_func_start SeaMapTraining__State_21712BC
SeaMapTraining__State_21712BC: // 0x021712BC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, #0
	ldr lr, _02171308 // =VRAMSystem__GFXControl
	mov r4, #1
	mov r2, r5
	mvn r1, #0xf
_021712D4:
	ldr ip, [lr, r5, lsl #2]
	add r5, r5, #1
	ldrsh r3, [ip, #0x58]
	cmp r3, r1
	subgt r3, r3, #1
	movgt r4, r2
	strgth r3, [ip, #0x58]
	cmp r5, #2
	blt _021712D4
	cmp r4, #0
	movne r1, #1
	strne r1, [r0, #4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02171308: .word VRAMSystem__GFXControl
	arm_func_end SeaMapTraining__State_21712BC

	.data
	
aSndSysSoundDat_3: // 0x0217EE50
	.asciz "snd/sys/sound_data.sdat"
	.align 4
	
aBbChBb_0: // 0x0217EE68
	.asciz "/bb/ch.bb"
	.align 4
	
_0217EE74: // 0x0217EE74
	.asciz "ch"
	.align 4
