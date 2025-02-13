	.include "asm/macros.inc"
	.include "global.inc"

	.text

	thumb_func_start MainMenu__Create
MainMenu__Create: // 0x02152960
	push {r3, r4, lr}
	sub sp, #0xc
	mov r0, #0
	bl SaveGame__GsExit
	mov r2, #0
	str r2, [sp]
	ldr r0, _021529DC // =0x00002614
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _021529E0 // =MainMenu__Main
	ldr r1, _021529E4 // =MainMenu__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _021529DC // =0x00002614
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear32
	ldr r0, _021529E8 // =0x04000204
	ldrh r2, [r0, #0]
	lsr r1, r0, #0xb
	and r1, r2
	asr r2, r1, #0xf
	ldr r1, _021529EC // =0x00002610
	str r2, [r4, r1]
	ldrh r2, [r0, #0]
	lsr r1, r0, #0xb
	orr r1, r2
	strh r1, [r0]
	ldr r0, _021529F0 // =gameState+0x00000140
	ldrh r0, [r0, #0x14]
	cmp r0, #0
	beq _021529B2
	cmp r0, #1
	beq _021529BE
	b _021529C2
_021529B2:
	ldr r0, _021529F4 // =gameState
	mov r1, #0
	strh r1, [r0, #0x28]
	str r1, [r0, #4]
	str r1, [r4, #0x18]
	b _021529C2
_021529BE:
	mov r0, #1
	str r0, [r4, #0x18]
_021529C2:
	ldr r0, _021529F0 // =gameState+0x00000140
	mov r1, #0
	strh r1, [r0, #0x14]
	mov r0, r4
	bl MainMenu__Init
	bl LoadSysSoundVillage
	mov r0, #0
	bl PlaySysVillageTrack
	add sp, #0xc
	pop {r3, r4, pc}
	.align 2, 0
_021529DC: .word 0x00002614
_021529E0: .word MainMenu__Main
_021529E4: .word MainMenu__Destructor
_021529E8: .word 0x04000204
_021529EC: .word 0x00002610
_021529F0: .word gameState+0x00000140
_021529F4: .word gameState
	thumb_func_end MainMenu__Create

	thumb_func_start MainMenu__Init
MainMenu__Init: // 0x021529F8
	push {r4, lr}
	mov r4, r0
	bl MainMenu__Func_2152C58
	mov r0, r4
	bl MainMenu__Func_2152C90
	mov r0, #0x14
	bl CARD_SetThreadPriority
	ldr r0, _02152A28 // =0x00002468
	mov r1, #2
	add r0, r4, r0
	lsl r1, r1, #0xa
	bl InitThreadWorker
	ldr r0, _02152A28 // =0x00002468
	ldr r1, _02152A2C // =MainMenu__InitAssets
	add r0, r4, r0
	mov r2, r4
	mov r3, #0x16
	bl CreateThreadWorker
	pop {r4, pc}
	.align 2, 0
_02152A28: .word 0x00002468
_02152A2C: .word MainMenu__InitAssets
	thumb_func_end MainMenu__Init

	thumb_func_start MainMenu__InitAssets
MainMenu__InitAssets: // 0x02152A30
	push {r4, lr}
	mov r4, r0
	bl MainMenu__LoadArchives
	mov r0, r4
	add r0, #0xd8
	bl FontWindow__Init
	mov r0, r4
	ldr r1, [r4, #0x10]
	add r0, #0xd8
	mov r2, #1
	bl FontWindow__LoadFromMemory
	mov r0, r4
	add r0, #0xd8
	bl FontWindow__LoadWinSimple
	ldr r0, _02152A8C // =0x0000232C
	add r0, r4, r0
	bl FontWindowAnimator__Init
	ldr r0, _02152A90 // =0x00002390
	add r0, r4, r0
	bl FontAnimator__Init
	mov r0, r4
	ldr r1, [r4, #0]
	add r0, #0x1c
	mov r2, #0
	bl MainMenu__SetBackground
	mov r0, r4
	mov r1, #1
	add r0, #0xc8
	str r1, [r0]
	bl StageSelectMenu__LoadAssets
	mov r1, r4
	add r1, #0xcc
	str r0, [r1]
	bl CharacterSelectMenu__LoadAssets
	add r4, #0xd0
	str r0, [r4]
	pop {r4, pc}
	.align 2, 0
_02152A8C: .word 0x0000232C
_02152A90: .word 0x00002390
	thumb_func_end MainMenu__InitAssets

	thumb_func_start MainMenu__Func_2152A94
MainMenu__Func_2152A94: // 0x02152A94
	push {r4, lr}
	mov r4, r0
	bl ResetTouchInput
	mov r0, r4
	bl MainMenu__Func_2152F94
	mov r0, r4
	bl MainMenu__Func_2153068
	pop {r4, pc}
	.align 2, 0
	thumb_func_end MainMenu__Func_2152A94

	thumb_func_start MainMenu__LoadArchives
MainMenu__LoadArchives: // 0x02152AAC
	push {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, _02152B60 // =_0217E560
	mov r1, #0
	ldr r0, [r0, #0]
	bl ArchiveFileUnknown__LoadFile
	str r0, [r4, #4]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _02152AE6
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02152AD2: // jump table
	.hword _02152ADE - _02152AD2 - 2 // case 0
	.hword _02152ADE - _02152AD2 - 2 // case 1
	.hword _02152ADE - _02152AD2 - 2 // case 2
	.hword _02152ADE - _02152AD2 - 2 // case 3
	.hword _02152ADE - _02152AD2 - 2 // case 4
	.hword _02152ADE - _02152AD2 - 2 // case 5
_02152ADE:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _02152AE8
_02152AE6:
	mov r0, #1
_02152AE8:
	cmp r0, #5
	bhi _02152B1C
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02152AF8: // jump table
	.hword _02152B04 - _02152AF8 - 2 // case 0
	.hword _02152B08 - _02152AF8 - 2 // case 1
	.hword _02152B0C - _02152AF8 - 2 // case 2
	.hword _02152B10 - _02152AF8 - 2 // case 3
	.hword _02152B14 - _02152AF8 - 2 // case 4
	.hword _02152B18 - _02152AF8 - 2 // case 5
_02152B04:
	mov r1, #0
	b _02152B1E
_02152B08:
	mov r1, #1
	b _02152B1E
_02152B0C:
	mov r1, #2
	b _02152B1E
_02152B10:
	mov r1, #3
	b _02152B1E
_02152B14:
	mov r1, #4
	b _02152B1E
_02152B18:
	mov r1, #5
	b _02152B1E
_02152B1C:
	mov r1, #0
_02152B1E:
	ldr r0, _02152B60 // =_0217E560
	mov r2, #0
	ldr r0, [r0, #4]
	mvn r2, r2
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	lsr r0, r0, #8
	bl _AllocHeadHEAP_USER
	str r0, [r4, #8]
	ldr r1, [r4, #8]
	mov r0, r5
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	ldr r0, _02152B60 // =_0217E560
	mov r1, #0
	ldr r0, [r0, #8]
	mov r2, r1
	bl ReadFileFromBundle
	str r0, [r4, #0xc]
	ldr r0, _02152B60 // =_0217E560
	mov r1, #0
	ldr r0, [r0, #0xc]
	bl FSRequestFileSync
	str r0, [r4, #0x10]
	pop {r3, r4, r5, pc}
	.align 2, 0
_02152B60: .word _0217E560
	thumb_func_end MainMenu__LoadArchives

	thumb_func_start MainMenu__Func_2152B64
MainMenu__Func_2152B64: // 0x02152B64
	push {r4, lr}
	mov r4, r0
	ldr r0, _02152C40 // =0x00002468
	add r0, r4, r0
	bl IsThreadWorkerFinished
	cmp r0, #0
	bne _02152B7C
	ldr r0, _02152C40 // =0x00002468
	add r0, r4, r0
	bl JoinThreadWorker
_02152B7C:
	ldr r0, _02152C40 // =0x00002468
	add r0, r4, r0
	bl ReleaseThreadWorker
	mov r0, r4
	add r0, #0xd0
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _02152B9A
	bl CharacterSelectMenu__ReleaseAssets
	mov r0, r4
	mov r1, #0
	add r0, #0xd0
	str r1, [r0]
_02152B9A:
	mov r0, r4
	add r0, #0xcc
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _02152BB0
	bl StageSelectMenu__ReleaseAssets
	mov r0, r4
	mov r1, #0
	add r0, #0xcc
	str r1, [r0]
_02152BB0:
	mov r0, r4
	bl MainMenu__Func_215314C
	mov r0, r4
	bl MainMenu__Func_2152FCC
	mov r0, r4
	add r0, #0x1c
	bl MainMenu__Func_21567BC
	ldr r0, [r4, #0x10]
	cmp r0, #0
	beq _02152BD2
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x10]
_02152BD2:
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _02152BE0
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0xc]
_02152BE0:
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _02152BEE
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #8]
_02152BEE:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _02152BFC
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #4]
_02152BFC:
	ldr r0, _02152C44 // =0x0000232C
	add r0, r4, r0
	bl FontWindowAnimator__Release
	ldr r0, _02152C48 // =0x00002390
	add r0, r4, r0
	bl FontAnimator__Release
	mov r0, r4
	add r0, #0xd8
	bl FontWindow__Release
	mov r0, #4
	bl CARD_SetThreadPriority
	ldr r0, _02152C4C // =0x00002610
	ldr r1, [r4, r0]
	cmp r1, #1
	beq _02152C2A
	cmp r1, #0
	beq _02152C2A
	mov r1, #0
	str r1, [r4, r0]
_02152C2A:
	ldr r2, _02152C50 // =0x04000204
	ldr r0, _02152C4C // =0x00002610
	ldrh r1, [r2, #0]
	ldr r3, [r4, r0]
	ldr r0, _02152C54 // =0xFFFF7FFF
	and r1, r0
	lsl r0, r3, #0xf
	orr r0, r1
	strh r0, [r2]
	pop {r4, pc}
	nop
_02152C40: .word 0x00002468
_02152C44: .word 0x0000232C
_02152C48: .word 0x00002390
_02152C4C: .word 0x00002610
_02152C50: .word 0x04000204
_02152C54: .word 0xFFFF7FFF
	thumb_func_end MainMenu__Func_2152B64

	thumb_func_start MainMenu__Func_2152C58
MainMenu__Func_2152C58: // 0x02152C58
	mov r1, #0x62
	mov r2, #7
	lsl r1, r1, #2
	str r2, [r0, r1]
	bx lr
	.align 2, 0
	thumb_func_end MainMenu__Func_2152C58

	thumb_func_start MainMenu__Func_2152C64
MainMenu__Func_2152C64: // 0x02152C64
	mov r2, #0x62
	lsl r2, r2, #2
	str r1, [r0, r2]
	bx lr
	thumb_func_end MainMenu__Func_2152C64

	thumb_func_start MainMenu__Func_2152C6C
MainMenu__Func_2152C6C: // 0x02152C6C
	push {r3, lr}
	cmp r0, #6
	blt _02152C74
	mov r0, #0
_02152C74:
	cmp r0, #3
	bne _02152C7E
	ldr r1, _02152C8C // =gameState+0x000000C0
	mov r2, #1
	strb r2, [r1, #0x1c]
_02152C7E:
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	bl RequestSysEventChange
	bl NextSysEvent
	pop {r3, pc}
	.align 2, 0
_02152C8C: .word gameState+0x000000C0
	thumb_func_end MainMenu__Func_2152C6C

	thumb_func_start MainMenu__Func_2152C90
MainMenu__Func_2152C90: // 0x02152C90
	push {r4, lr}
	mov r4, r0
	mov r0, #0
	str r0, [r4]
	bl MainMenu__SetupDisplay
	mov r0, r4
	bl MainMenu__SetupDisplay2
	pop {r4, pc}
	thumb_func_end MainMenu__Func_2152C90

	thumb_func_start MainMenu__SetupDisplay
MainMenu__SetupDisplay: // 0x02152CA4
	push {r3, r4, r5, r6, r7, lr}
	mov r0, #0
	bl VRAMSystem__Init
	mov r0, #0
	bl VRAMSystem__SetupBGExtPalBank
	mov r0, #0
	bl VRAMSystem__SetupBGExtPalBank
	mov r0, #0
	bl VRAMSystem__SetupSubBGExtPalBank
	mov r2, #0
	ldr r4, _02152D44 // =VRAMSystem__GFXControl
	mov r1, r2
	mov r0, r2
_02152CC6:
	mov r3, r0
	mov r5, r0
_02152CCA:
	ldr r6, [r4, #0]
	add r3, r3, #1
	strh r1, [r6, r5]
	ldr r6, [r4, #0]
	add r6, r6, r5
	add r5, r5, #4
	strh r1, [r6, #2]
	cmp r3, #4
	blt _02152CCA
	add r2, r2, #1
	add r4, r4, #4
	cmp r2, #2
	blt _02152CC6
	ldr r0, _02152D48 // =0x04000008
	mov r4, #3
	ldrh r2, [r0, #0]
	bic r2, r4
	strh r2, [r0]
	ldrh r3, [r0, #2]
	mov r2, #1
	bic r3, r4
	orr r3, r2
	strh r3, [r0, #2]
	ldrh r5, [r0, #4]
	mov r3, #2
	bic r5, r4
	orr r5, r3
	strh r5, [r0, #4]
	ldrh r6, [r0, #6]
	mov r5, #3
	bic r6, r4
	orr r6, r5
	strh r6, [r0, #6]
	sub r0, #8
	ldr r7, [r0, #0]
	ldr r6, _02152D4C // =0xFFFFE0FF
	and r7, r6
	str r7, [r0]
	ldr r0, _02152D50 // =0x04001008
	ldrh r7, [r0, #0]
	bic r7, r4
	strh r7, [r0]
	ldrh r7, [r0, #2]
	bic r7, r4
	orr r2, r7
	strh r2, [r0, #2]
	ldrh r2, [r0, #4]
	bic r2, r4
	orr r2, r3
	strh r2, [r0, #4]
	ldrh r2, [r0, #6]
	bic r2, r4
	orr r2, r5
	strh r2, [r0, #6]
	sub r0, #8
	ldr r2, [r0, #0]
	and r2, r6
	str r2, [r0]
	ldr r0, _02152D54 // =renderCurrentDisplay
	str r1, [r0]
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02152D44: .word VRAMSystem__GFXControl
_02152D48: .word 0x04000008
_02152D4C: .word 0xFFFFE0FF
_02152D50: .word 0x04001008
_02152D54: .word renderCurrentDisplay
	thumb_func_end MainMenu__SetupDisplay

	thumb_func_start MainMenu__SetupDisplay2
MainMenu__SetupDisplay2: // 0x02152D58
	push {r3, r4, lr}
	sub sp, #4
	ldr r1, _02152EB8 // =0x04000304
	ldr r2, _02152EBC // =0xFFFFFDF1
	ldrh r3, [r1, #0]
	and r3, r2
	ldr r2, _02152EC0 // =0x0000020E
	orr r2, r3
	strh r2, [r1]
	ldrh r3, [r1, #0]
	mov r2, #0xc
	bic r3, r2
	strh r3, [r1]
	ldr r0, [r0, #0]
	cmp r0, #0
	ldr r0, _02152EC4 // =0xFFFFE0FF
	bne _02152E24
	lsl r3, r1, #0x18
	ldr r2, [r3, #0]
	and r2, r0
	mov r0, #6
	lsl r0, r0, #0xa
	orr r0, r2
	str r0, [r3]
	lsr r0, r1, #0x10
	str r0, [sp]
	ldr r1, _02152EC8 // =0x00200010
	mov r0, #2
	mov r2, #0x40
	mov r3, #0
	bl VRAMSystem__SetupOBJBank
	mov r2, #1
	lsl r2, r2, #0x1a
	ldr r1, [r2, #0]
	ldr r0, _02152ECC // =0xC7FFFFFF
	and r1, r0
	str r1, [r2]
	ldr r1, [r2, #0]
	asr r0, r0, #3
	and r0, r1
	str r0, [r2]
	mov r1, #0
	mov r0, #1
	mov r2, r1
	bl GX_SetGraphicsMode
	ldr r0, _02152ED0 // =0x04000008
	mov r2, #0x43
	ldrh r1, [r0, #0]
	add sp, #4
	mov r3, r1
	mov r1, #0x71
	and r3, r2
	lsl r1, r1, #4
	orr r1, r3
	strh r1, [r0]
	ldrh r1, [r0, #2]
	mov r3, r1
	ldr r1, _02152ED4 // =0x0000060C
	and r3, r2
	orr r1, r3
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	mov r3, r1
	ldr r1, _02152ED8 // =0x0000C208
	and r3, r2
	orr r3, r1
	strh r3, [r0, #4]
	ldrh r3, [r0, #6]
	and r3, r2
	ldr r2, _02152EDC // =0x00004018
	orr r2, r3
	strh r2, [r0, #6]
	ldrh r2, [r0, #0]
	mov r3, #3
	bic r2, r3
	strh r2, [r0]
	ldrh r4, [r0, #2]
	mov r2, #1
	bic r4, r3
	orr r2, r4
	strh r2, [r0, #2]
	ldrh r4, [r0, #4]
	mov r2, #2
	bic r4, r3
	orr r2, r4
	strh r2, [r0, #4]
	ldrh r4, [r0, #6]
	mov r2, #3
	bic r4, r3
	mov r3, r4
	orr r3, r2
	strh r3, [r0, #6]
	lsl r3, r1, #0x17
	ldr r1, [r3, #0]
	ldr r0, _02152EC4 // =0xFFFFE0FF
	and r1, r0
	lsl r0, r2, #0xb
	orr r0, r1
	str r0, [r3]
	pop {r3, r4, pc}
_02152E24:
	ldr r2, _02152EE0 // =0x04001000
	mov r3, #0
	ldr r1, [r2, #0]
	and r1, r0
	mov r0, #6
	lsl r0, r0, #0xa
	orr r0, r1
	str r0, [r2]
	lsr r0, r2, #0x10
	str r0, [sp]
	ldr r1, _02152EC8 // =0x00200010
	mov r0, #8
	mov r2, #0x40
	bl VRAMSystem__SetupSubOBJBank
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r0, _02152EE4 // =0x04001008
	mov r2, #0x43
	ldrh r1, [r0, #0]
	mov r3, r1
	mov r1, #0x71
	and r3, r2
	lsl r1, r1, #4
	orr r1, r3
	strh r1, [r0]
	ldrh r1, [r0, #2]
	mov r3, r1
	ldr r1, _02152ED4 // =0x0000060C
	and r3, r2
	orr r1, r3
	strh r1, [r0, #2]
	ldrh r1, [r0, #4]
	mov r3, r1
	ldr r1, _02152ED8 // =0x0000C208
	and r3, r2
	orr r1, r3
	strh r1, [r0, #4]
	ldrh r1, [r0, #6]
	and r2, r1
	ldr r1, _02152EDC // =0x00004018
	orr r1, r2
	strh r1, [r0, #6]
	ldrh r1, [r0, #0]
	mov r2, #3
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
	mov r2, r3
	orr r2, r1
	strh r2, [r0, #6]
	sub r0, #8
	ldr r3, [r0, #0]
	ldr r2, _02152EC4 // =0xFFFFE0FF
	lsl r1, r1, #0xb
	and r2, r3
	orr r1, r2
	str r1, [r0]
	add sp, #4
	pop {r3, r4, pc}
	nop
_02152EB8: .word 0x04000304
_02152EBC: .word 0xFFFFFDF1
_02152EC0: .word 0x0000020E
_02152EC4: .word 0xFFFFE0FF
_02152EC8: .word 0x00200010
_02152ECC: .word 0xC7FFFFFF
_02152ED0: .word 0x04000008
_02152ED4: .word 0x0000060C
_02152ED8: .word 0x0000C208
_02152EDC: .word 0x00004018
_02152EE0: .word 0x04001000
_02152EE4: .word 0x04001008
	thumb_func_end MainMenu__SetupDisplay2

	thumb_func_start MainMenu__SetWindowVisible
MainMenu__SetWindowVisible: // 0x02152EE8
	push {r3, r4}
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02152F40
	cmp r2, #0
	beq _02152F1A
	mov r0, #1
	lsl r0, r0, #0x1a
	mov r2, #0x1f
	ldr r3, [r0, #0]
	lsl r2, r2, #8
	and r2, r3
	lsr r4, r2, #8
	ldr r3, [r0, #0]
	ldr r2, _02152F8C // =0xFFFFE0FF
	and r3, r2
	mov r2, #1
	lsl r2, r1
	mov r1, r2
	orr r1, r4
	lsl r1, r1, #8
	orr r1, r3
	str r1, [r0]
	pop {r3, r4}
	bx lr
_02152F1A:
	mov r2, #1
	lsl r2, r2, #0x1a
	ldr r3, [r2, #0]
	mov r0, #0x1f
	lsl r0, r0, #8
	and r0, r3
	lsr r3, r0, #8
	ldr r4, [r2, #0]
	ldr r0, _02152F8C // =0xFFFFE0FF
	and r0, r4
	mov r4, #1
	lsl r4, r1
	mvn r1, r4
	and r1, r3
	lsl r1, r1, #8
	orr r0, r1
	str r0, [r2]
	pop {r3, r4}
	bx lr
_02152F40:
	cmp r2, #0
	beq _02152F68
	ldr r0, _02152F90 // =0x04001000
	mov r2, #0x1f
	ldr r3, [r0, #0]
	lsl r2, r2, #8
	and r2, r3
	lsr r4, r2, #8
	ldr r3, [r0, #0]
	ldr r2, _02152F8C // =0xFFFFE0FF
	and r3, r2
	mov r2, #1
	lsl r2, r1
	mov r1, r2
	orr r1, r4
	lsl r1, r1, #8
	orr r1, r3
	str r1, [r0]
	pop {r3, r4}
	bx lr
_02152F68:
	ldr r2, _02152F90 // =0x04001000
	mov r0, #0x1f
	ldr r3, [r2, #0]
	lsl r0, r0, #8
	and r0, r3
	lsr r3, r0, #8
	ldr r4, [r2, #0]
	ldr r0, _02152F8C // =0xFFFFE0FF
	and r0, r4
	mov r4, #1
	lsl r4, r1
	mvn r1, r4
	and r1, r3
	lsl r1, r1, #8
	orr r0, r1
	str r0, [r2]
	pop {r3, r4}
	bx lr
	.align 2, 0
_02152F8C: .word 0xFFFFE0FF
_02152F90: .word 0x04001000
	thumb_func_end MainMenu__SetWindowVisible

	thumb_func_start MainMenu__Func_2152F94
MainMenu__Func_2152F94: // 0x02152F94
	push {r4, lr}
	mov r2, r0
	ldr r0, [r2, #0]
	cmp r0, #0
	bne _02152FA2
	mov r0, #1
	b _02152FA4
_02152FA2:
	mov r0, #0
_02152FA4:
	ldr r1, _02152FC8 // =VRAMSystem__GFXControl
	lsl r3, r0, #2
	ldr r3, [r1, r3]
	mov r4, #0x58
	ldrsh r1, [r3, r4]
	cmp r1, #0
	bgt _02152FB6
	sub r4, #0x68
	b _02152FB8
_02152FB6:
	mov r4, #0x10
_02152FB8:
	add r3, #0x58
	mov r1, #4
	add r2, #0xd8
	strh r4, [r3]
	bl CreateNavTails
	pop {r4, pc}
	nop
_02152FC8: .word VRAMSystem__GFXControl
	thumb_func_end MainMenu__Func_2152F94

	thumb_func_start MainMenu__Func_2152FCC
MainMenu__Func_2152FCC: // 0x02152FCC
	bx lr
	.align 2, 0
	thumb_func_end MainMenu__Func_2152FCC

	thumb_func_start MainMenu__Func_2152FD0
MainMenu__Func_2152FD0: // 0x02152FD0
	ldr r1, [r0, #0x14]
	cmp r1, #0
	bne _0215301A
	ldr r1, [r0, #0]
	cmp r1, #0
	bne _02152FFC
	ldr r2, _0215301C // =renderCoreGFXControlB+0x00000040
	mov r1, #0x18
	ldrsh r3, [r2, r1]
	mov r1, #0x63
	lsl r1, r1, #2
	ldrsh r0, [r0, r1]
	cmp r0, r3
	ble _02152FF2
	add r0, r3, #1
	strh r0, [r2, #0x18]
	bx lr
_02152FF2:
	cmp r0, r3
	bge _0215301A
	sub r0, r3, #1
	strh r0, [r2, #0x18]
	bx lr
_02152FFC:
	ldr r2, _02153020 // =renderCoreGFXControlA+0x00000040
	mov r1, #0x18
	ldrsh r3, [r2, r1]
	mov r1, #0x63
	lsl r1, r1, #2
	ldrsh r0, [r0, r1]
	cmp r0, r3
	ble _02153012
	add r0, r3, #1
	strh r0, [r2, #0x18]
	bx lr
_02153012:
	cmp r0, r3
	bge _0215301A
	sub r0, r3, #1
	strh r0, [r2, #0x18]
_0215301A:
	bx lr
	.align 2, 0
_0215301C: .word renderCoreGFXControlB+0x00000040
_02153020: .word renderCoreGFXControlA+0x00000040
	thumb_func_end MainMenu__Func_2152FD0

	thumb_func_start MainMenu__Func_2153024
MainMenu__Func_2153024: // 0x02153024
	mov r2, #0x63
	lsl r2, r2, #2
	strh r1, [r0, r2]
	bx lr
	thumb_func_end MainMenu__Func_2153024

	thumb_func_start MainMenu__Func_215302C
MainMenu__Func_215302C: // 0x0215302C
	ldr r1, [r0, #0]
	cmp r1, #0
	bne _02153048
	mov r1, #0x63
	lsl r1, r1, #2
	ldrsh r2, [r0, r1]
	ldr r0, _02153064 // =VRAMSystem__GFXControl
	ldr r1, [r0, #4]
	mov r0, #0x58
	ldrsh r0, [r1, r0]
	cmp r2, r0
	bne _0215305E
	mov r0, #1
	bx lr
_02153048:
	mov r1, #0x63
	lsl r1, r1, #2
	ldrsh r2, [r0, r1]
	ldr r0, _02153064 // =VRAMSystem__GFXControl
	ldr r1, [r0, #0]
	mov r0, #0x58
	ldrsh r0, [r1, r0]
	cmp r2, r0
	bne _0215305E
	mov r0, #1
	bx lr
_0215305E:
	mov r0, #0
	bx lr
	nop
_02153064: .word VRAMSystem__GFXControl
	thumb_func_end MainMenu__Func_215302C

	thumb_func_start MainMenu__Func_2153068
MainMenu__Func_2153068: // 0x02153068
	push {r3, r4, lr}
	sub sp, #0xc
	mov r4, r0
	ldr r0, [r4, #0]
	lsl r1, r0, #2
	ldr r0, _02153128 // =VRAMSystem__GFXControl
	ldr r2, [r0, r1]
	mov r1, #0x58
	ldrsh r0, [r2, r1]
	cmp r0, #0
	bgt _02153082
	sub r1, #0x68
	b _02153084
_02153082:
	mov r1, #0x10
_02153084:
	add r2, #0x58
	mov r0, r4
	strh r1, [r2]
	bl MainMenu__Func_2153254
	ldr r0, _0215312C // =0x00002460
	mov r1, #0
	str r1, [r4, r0]
	ldr r0, [r4, #4]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	mov r0, #2
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	ldr r0, _02153130 // =0x000022E4
	ldr r3, [r4, #0]
	add r0, r4, r0
	mov r2, #0
	bl InitBackground
	mov r0, #2
	lsl r0, r0, #8
	bl _AllocHeadHEAP_USER
	ldr r1, _02153134 // =0x00002454
	str r0, [r4, r1]
	mov r0, #1
	lsl r0, r0, #0xa
	bl _AllocHeadHEAP_USER
	ldr r1, _02153138 // =0x00002458
	str r0, [r4, r1]
	mov r0, #2
	lsl r0, r0, #8
	bl _AllocHeadHEAP_USER
	ldr r1, _0215313C // =0x0000245C
	str r0, [r4, r1]
	mov r0, r4
	bl MainMenu__Func_2155FBC
	mov r0, r4
	bl MainMenu__InitSprites
	mov r0, r4
	bl MainMenu__Func_2153B40
	mov r0, #0
	str r0, [r4, #0x14]
	mov r0, r4
	bl MainMenu__Func_21549C8
	mov r3, r0
	mov r0, r4
	mov r1, #1
	mov r2, #0
	bl MainMenu__Func_2153FD0
	ldr r1, _02153140 // =MainMenu__State_21548A4
	mov r0, r4
	bl MainMenu__SetState
	bl MainMenu__Func_21565B8
	cmp r0, #0
	beq _0215311E
	ldr r0, [r4, #0x18]
	cmp r0, #0
	beq _0215311E
	ldr r1, _02153144 // =MainMenu__Func_2156174
	mov r0, r4
	bl MainMenu__SetState
_0215311E:
	ldr r0, _02153148 // =gameState+0x00000140
	mov r1, #0
	strh r1, [r0, #0x14]
	add sp, #0xc
	pop {r3, r4, pc}
	.align 2, 0
_02153128: .word VRAMSystem__GFXControl
_0215312C: .word 0x00002460
_02153130: .word 0x000022E4
_02153134: .word 0x00002454
_02153138: .word 0x00002458
_0215313C: .word 0x0000245C
_02153140: .word MainMenu__State_21548A4
_02153144: .word MainMenu__Func_2156174
_02153148: .word gameState+0x00000140
	thumb_func_end MainMenu__Func_2153068

	thumb_func_start MainMenu__Func_215314C
MainMenu__Func_215314C: // 0x0215314C
	push {r4, lr}
	mov r4, r0
	bl MainMenu__Func_21560A4
	mov r0, r4
	bl MainMenu__ReleaseSprites
	ldr r0, _021531A4 // =0x00002454
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _0215316C
	bl _FreeHEAP_USER
	ldr r0, _021531A4 // =0x00002454
	mov r1, #0
	str r1, [r4, r0]
_0215316C:
	ldr r0, _021531A8 // =0x00002458
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _0215317E
	bl _FreeHEAP_USER
	ldr r0, _021531A8 // =0x00002458
	mov r1, #0
	str r1, [r4, r0]
_0215317E:
	ldr r0, _021531AC // =0x0000245C
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _02153190
	bl _FreeHEAP_USER
	ldr r0, _021531AC // =0x0000245C
	mov r1, #0
	str r1, [r4, r0]
_02153190:
	ldr r0, _021531B0 // =0x0000232C
	add r0, r4, r0
	bl FontWindowAnimator__Release
	ldr r0, _021531B4 // =0x00002390
	add r0, r4, r0
	bl FontAnimator__Release
	pop {r4, pc}
	nop
_021531A4: .word 0x00002454
_021531A8: .word 0x00002458
_021531AC: .word 0x0000245C
_021531B0: .word 0x0000232C
_021531B4: .word 0x00002390
	thumb_func_end MainMenu__Func_215314C

	thumb_func_start MainMenu__Func_21531B8
MainMenu__Func_21531B8: // 0x021531B8
	push {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, [r4, #0x14]
	cmp r0, #0
	bne _021531E8
	ldr r0, [r4, #0]
	lsl r1, r0, #2
	ldr r0, _02153230 // =VRAMSystem__GFXControl
	ldr r0, [r0, r1]
	mov r1, #0x58
	ldrsh r2, [r0, r1]
	ldr r1, _02153234 // =0x000022CC
	ldrsh r1, [r4, r1]
	cmp r1, r2
	ble _021531DE
	add r1, r2, #1
	add r0, #0x58
	strh r1, [r0]
	b _021531E8
_021531DE:
	cmp r1, r2
	bge _021531E8
	sub r1, r2, #1
	add r0, #0x58
	strh r1, [r0]
_021531E8:
	mov r0, #0x69
	lsl r0, r0, #2
	add r0, r4, r0
	bl TouchField__Process
	mov r0, r4
	add r0, #0xc8
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _02153204
	mov r0, r4
	add r0, #0x1c
	bl MainMenu__HandleBackgroundControl
_02153204:
	ldr r0, _02153238 // =0x00002460
	ldr r5, [r4, r0]
	cmp r5, #0
	beq _02153210
	mov r0, r4
	blx r5
_02153210:
	ldr r0, _02153238 // =0x00002460
	ldr r0, [r4, r0]
	cmp r5, r0
	bne _02153220
	ldr r0, _0215323C // =0x000022C8
	ldr r1, [r4, r0]
	add r1, r1, #1
	str r1, [r4, r0]
_02153220:
	ldr r0, _02153238 // =0x00002460
	ldr r0, [r4, r0]
	cmp r0, #0
	bne _0215322C
	mov r0, #0
	pop {r3, r4, r5, pc}
_0215322C:
	mov r0, #1
	pop {r3, r4, r5, pc}
	.align 2, 0
_02153230: .word VRAMSystem__GFXControl
_02153234: .word 0x000022CC
_02153238: .word 0x00002460
_0215323C: .word 0x000022C8
	thumb_func_end MainMenu__Func_21531B8

	thumb_func_start MainMenu__SetState
MainMenu__SetState: // 0x02153240
	ldr r2, _0215324C // =0x00002460
	str r1, [r0, r2]
	ldr r1, _02153250 // =0x000022C8
	mov r2, #0
	str r2, [r0, r1]
	bx lr
	.align 2, 0
_0215324C: .word 0x00002460
_02153250: .word 0x000022C8
	thumb_func_end MainMenu__SetState

	thumb_func_start MainMenu__Func_2153254
MainMenu__Func_2153254: // 0x02153254
	ldr r2, _0215325C // =0x000022CC
	strh r1, [r0, r2]
	bx lr
	nop
_0215325C: .word 0x000022CC
	thumb_func_end MainMenu__Func_2153254

	thumb_func_start MainMenu__Func_2153260
MainMenu__Func_2153260: // 0x02153260
	ldr r1, _0215327C // =0x000022CC
	ldrsh r2, [r0, r1]
	ldr r0, [r0, #0]
	lsl r1, r0, #2
	ldr r0, _02153280 // =VRAMSystem__GFXControl
	ldr r1, [r0, r1]
	mov r0, #0x58
	ldrsh r0, [r1, r0]
	cmp r2, r0
	bne _02153278
	mov r0, #1
	bx lr
_02153278:
	mov r0, #0
	bx lr
	.align 2, 0
_0215327C: .word 0x000022CC
_02153280: .word VRAMSystem__GFXControl
	thumb_func_end MainMenu__Func_2153260

	thumb_func_start MainMenu__Func_2153284
MainMenu__Func_2153284: // 0x02153284
	push {r3, r4}
	mov r3, #0xff
	mvn r3, r3
	cmp r1, r3
	bge _02153292
	mov r1, r3
	b _0215329C
_02153292:
	mov r3, #1
	lsl r3, r3, #8
	cmp r1, r3
	ble _0215329C
	mov r1, r3
_0215329C:
	mov r3, #0xff
	mvn r3, r3
	cmp r2, r3
	bge _021532A8
	mov r2, r3
	b _021532B2
_021532A8:
	mov r3, #1
	lsl r3, r3, #8
	cmp r2, r3
	ble _021532B2
	mov r2, r3
_021532B2:
	ldr r0, [r0, #0]
	lsl r3, r0, #2
	ldr r0, _021532CC // =VRAMSystem__GFXControl
	ldr r3, [r0, r3]
	neg r0, r1
	mov r4, r3
	strh r0, [r3, #8]
	add r4, #8
	neg r0, r2
	strh r0, [r4, #2]
	pop {r3, r4}
	bx lr
	nop
_021532CC: .word VRAMSystem__GFXControl
	thumb_func_end MainMenu__Func_2153284

	thumb_func_start MainMenu__Func_21532D0
MainMenu__Func_21532D0: // 0x021532D0
	push {r4, lr}
	cmp r1, #0
	beq _021532F2
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _021532E8
	ldr r1, _02153334 // =touchInput
	mov r0, #4
	ldrh r2, [r1, #0x12]
	tst r0, r2
	bne _021532EC
_021532E8:
	ldr r0, _02153338 // =0x0000FFFF
	pop {r4, pc}
_021532EC:
	ldrh r3, [r1, #0x1c]
	ldrh r4, [r1, #0x1e]
	b _0215330C
_021532F2:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02153304
	ldr r1, _02153334 // =touchInput
	mov r0, #8
	ldrh r2, [r1, #0x12]
	tst r0, r2
	bne _02153308
_02153304:
	ldr r0, _02153338 // =0x0000FFFF
	pop {r4, pc}
_02153308:
	ldrh r3, [r1, #0x20]
	ldrh r4, [r1, #0x22]
_0215330C:
	mov r1, #0
	mov r2, #0x38
	sub r3, #0x30
_02153312:
	lsl r0, r2, #0x10
	lsr r0, r0, #0x10
	cmp r3, #0xa0
	bhs _02153326
	sub r0, r4, r0
	cmp r0, #0x18
	bhs _02153326
	lsl r0, r1, #0x10
	lsr r0, r0, #0x10
	pop {r4, pc}
_02153326:
	add r1, r1, #1
	add r2, #0x1c
	cmp r1, #4
	blt _02153312
	ldr r0, _02153338 // =0x0000FFFF
	pop {r4, pc}
	nop
_02153334: .word touchInput
_02153338: .word 0x0000FFFF
	thumb_func_end MainMenu__Func_21532D0

	thumb_func_start MainMenu__InitSprites
MainMenu__InitSprites: // 0x0215333C
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x90
	ldr r1, _021536B8 // =0x0217D0E8
	mov r5, r0
	ldrh r2, [r1, #0x2c]
	add r0, sp, #0x84
	strh r2, [r0]
	ldrh r2, [r1, #0x2e]
	strh r2, [r0, #2]
	ldrh r2, [r1, #0x30]
	strh r2, [r0, #4]
	ldrh r2, [r1, #0x32]
	ldrh r1, [r1, #0x34]
	strh r2, [r0, #6]
	strh r1, [r0, #8]
	ldr r0, [r5, #0]
	cmp r0, #0
	bne _0215336A
	ldr r0, _021536BC // =0x05000200
	str r0, [sp, #0x60]
	mov r0, #2
	str r0, [sp, #0x5c]
	b _02153372
_0215336A:
	ldr r0, _021536C0 // =0x05000600
	str r0, [sp, #0x60]
	mov r0, #4
	str r0, [sp, #0x5c]
_02153372:
	ldr r0, [r5, #4]
	mov r1, #1
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x80]
	ldr r0, [r5, #8]
	mov r1, #0
	bl FileUnknown__GetAOUFile
	mov r4, r0
	ldr r0, [r5, #0xc]
	mov r1, #2
	str r0, [sp, #0x7c]
	ldr r0, [r5, #4]
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x78]
	ldr r0, [r5, #4]
	mov r1, #3
	bl FileUnknown__GetAOUFile
	mov r7, r0
	ldr r0, [r5, #4]
	mov r1, #4
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x74]
	ldr r0, [r5, #4]
	mov r1, #5
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x70]
	ldr r0, [r5, #4]
	mov r1, #6
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x6c]
	ldr r0, [r5, #8]
	mov r1, #1
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x68]
	mov r0, #0
	str r0, [sp, #0x64]
	mov r0, #0x7e
	lsl r0, r0, #2
	add r0, r5, r0
	ldr r6, _021536C4 // =0x0217D11E
	str r0, [sp, #0x3c]
_021533D4:
	ldrh r1, [r6, #0]
	mov r0, r4
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r3, #4
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x60]
	mov r1, r4
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	ldrh r2, [r6, #0]
	ldr r0, [sp, #0x3c]
	bl AnimatorSprite__Init
	ldr r1, [sp, #0x3c]
	mov r0, #0xc
	add r1, #0x50
	strh r0, [r1]
	ldr r0, [sp, #0x3c]
	add r6, r6, #2
	add r0, #0x64
	str r0, [sp, #0x3c]
	ldr r0, [sp, #0x64]
	add r0, r0, #1
	str r0, [sp, #0x64]
	cmp r0, #6
	blt _021533D4
	mov r0, #0
	str r0, [sp, #0x30]
	mov r0, #0x45
	lsl r0, r0, #4
	add r0, r5, r0
	ldr r6, _021536C8 // =0x0217D12A
	str r0, [sp, #0x40]
_02153430:
	ldrh r1, [r6, #0]
	mov r0, r4
	bl Sprite__GetSpriteSize3FromAnim
	str r0, [sp, #0x28]
	ldrh r1, [r6, #0]
	mov r0, r4
	add r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl Sprite__GetSpriteSize3FromAnim
	ldr r1, [sp, #0x28]
	cmp r0, r1
	bls _02153450
	str r0, [sp, #0x28]
_02153450:
	ldrh r1, [r6, #0]
	mov r0, r4
	add r1, r1, #2
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl Sprite__GetSpriteSize3FromAnim
	ldr r1, [sp, #0x28]
	cmp r0, r1
	bls _02153466
	str r0, [sp, #0x28]
_02153466:
	ldr r0, [r5, #0]
	ldr r1, [sp, #0x28]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r3, #4
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x60]
	mov r1, r4
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	ldrh r2, [r6, #0]
	ldr r0, [sp, #0x40]
	bl AnimatorSprite__Init
	ldr r1, [sp, #0x40]
	mov r0, #0
	add r1, #0x50
	strh r0, [r1]
	ldr r0, [sp, #0x40]
	add r6, r6, #2
	add r0, #0x64
	str r0, [sp, #0x40]
	ldr r0, [sp, #0x30]
	add r0, r0, #1
	str r0, [sp, #0x30]
	cmp r0, #6
	blt _02153430
	ldr r0, [sp, #0x80]
	mov r1, #0
	ldr r6, _021536CC // =0x000006A8
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r2, #0
	str r1, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x60]
	str r2, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #2
	str r0, [sp, #0x18]
	ldr r1, [sp, #0x80]
	add r0, r5, r6
	mov r3, r2
	bl AnimatorSprite__Init
	add r0, r5, r6
	mov r1, #0
	add r0, #0x50
	strh r1, [r0]
	ldr r0, [sp, #0x6c]
	add r6, #0x64
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r2, #0
	str r1, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x60]
	str r2, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	ldr r1, [sp, #0x6c]
	add r0, r5, r6
	mov r3, #4
	str r2, [sp, #0x18]
	bl AnimatorSprite__Init
	add r0, r5, r6
	mov r1, #3
	add r0, #0x50
	strh r1, [r0]
	ldr r0, [sp, #0x80]
	mov r1, #0xe
	bl Sprite__GetSpriteSize3FromAnim
	mov r6, r0
	ldr r0, [sp, #0x80]
	mov r1, #0xf
	bl Sprite__GetSpriteSize3FromAnim
	cmp r0, r6
	bls _02153538
	mov r6, r0
_02153538:
	ldr r0, [r5, #0]
	mov r1, r6
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r3, #0
	str r1, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x60]
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0x77
	lsl r0, r0, #4
	ldr r1, [sp, #0x80]
	add r0, r5, r0
	mov r2, #0xe
	str r3, [sp, #0x18]
	bl AnimatorSprite__Init
	mov r0, #0x77
	lsl r0, r0, #4
	add r0, r5, r0
	mov r1, #4
	add r0, #0x50
	strh r1, [r0]
	mov r0, r4
	mov r1, #5
	ldr r6, _021536D0 // =0x000007D4
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r3, #0
	str r1, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x60]
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r5, r6
	mov r1, r4
	mov r2, #5
	bl AnimatorSprite__Init
	add r0, r5, r6
	mov r1, #0xc
	add r0, #0x50
	strh r1, [r0]
	ldr r0, [sp, #0x80]
	mov r1, #2
	add r6, #0x64
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r3, #0
	str r1, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x60]
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r2, #2
	ldr r1, [sp, #0x80]
	add r0, r5, r6
	str r2, [sp, #0x18]
	bl AnimatorSprite__Init
	add r0, r5, r6
	mov r1, #6
	add r0, #0x50
	strh r1, [r0]
	mov r0, #0
	str r0, [sp, #0x2c]
	str r0, [sp, #0x34]
	add r6, sp, #0x84
_021535EC:
	ldrh r1, [r6, #0]
	mov r0, r4
	bl Sprite__GetSpriteSize3FromAnim
	ldr r1, [sp, #0x2c]
	cmp r0, r1
	bls _021535FC
	str r0, [sp, #0x2c]
_021535FC:
	ldr r0, [sp, #0x34]
	add r6, r6, #2
	add r0, r0, #1
	str r0, [sp, #0x34]
	cmp r0, #5
	blt _021535EC
	ldr r0, [r5, #0]
	ldr r1, [sp, #0x2c]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r3, #0
	str r1, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x60]
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	ldr r0, _021536D4 // =0x0000089C
	mov r1, r4
	add r0, r5, r0
	mov r2, #0x1b
	bl AnimatorSprite__Init
	ldr r0, _021536D4 // =0x0000089C
	mov r4, #9
	add r0, r5, r0
	mov r1, #7
	add r0, #0x50
	strh r1, [r0]
	ldr r0, [sp, #0x7c]
	mov r1, #0x2d
	lsl r4, r4, #8
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r3, #0
	str r1, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x60]
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #2
	str r0, [sp, #0x18]
	ldr r1, [sp, #0x7c]
	add r0, r5, r4
	mov r2, #0x2d
	bl AnimatorSprite__Init
	add r0, r5, r4
	mov r1, #8
	add r0, #0x50
	strh r1, [r0]
	ldr r0, [sp, #0x7c]
	mov r1, #6
	add r4, #0x64
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r2, #6
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, [sp, #0x60]
	ldr r1, [sp, #0x7c]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r5, r4
	mov r3, #4
	bl AnimatorSprite__Init
	add r0, r5, r4
	mov r1, #9
	add r0, #0x50
	ldr r4, _021536D8 // =0x000009C8
	b _021536DC
	.align 2, 0
_021536B8: .word 0x0217D0E8
_021536BC: .word 0x05000200
_021536C0: .word 0x05000600
_021536C4: .word 0x0217D11E
_021536C8: .word 0x0217D12A
_021536CC: .word 0x000006A8
_021536D0: .word 0x000007D4
_021536D4: .word 0x0000089C
_021536D8: .word 0x000009C8
_021536DC:
	strh r1, [r0]
	ldr r0, [sp, #0x80]
	mov r1, #3
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r3, #0
	str r1, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x60]
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #2
	str r0, [sp, #0x18]
	ldr r1, [sp, #0x80]
	add r0, r5, r4
	mov r2, #3
	bl AnimatorSprite__Init
	add r0, r5, r4
	mov r1, #0xa
	add r0, #0x50
	strh r1, [r0]
	ldr r0, [sp, #0x70]
	mov r1, #0
	bl Sprite__GetSpriteSize3FromAnim
	str r0, [sp, #0x44]
	mov r0, r4
	add r0, #0x64
	mov r6, #0
	add r4, r5, r0
_0215372A:
	ldr r0, [r5, #0]
	ldr r1, [sp, #0x44]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	lsl r2, r6, #0x10
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x60]
	ldr r1, [sp, #0x70]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r4
	lsr r2, r2, #0x10
	mov r3, #0
	bl AnimatorSprite__Init
	mov r1, r4
	add r1, #0x50
	mov r0, #0xd
	add r6, r6, #1
	add r4, #0x64
	strh r0, [r1]
	cmp r6, #0xa
	blt _0215372A
	ldr r0, [sp, #0x70]
	mov r1, #0xa
	bl Sprite__GetSpriteSize3FromAnim
	str r0, [sp, #0x48]
	ldr r0, _02153B0C // =0x00000E14
	mov r6, #0
	add r4, r5, r0
_02153778:
	ldr r0, [r5, #0]
	ldr r1, [sp, #0x48]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r2, r6
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x60]
	add r2, #0xa
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	lsl r2, r2, #0x10
	str r0, [sp, #0x18]
	ldr r1, [sp, #0x70]
	mov r0, r4
	lsr r2, r2, #0x10
	mov r3, #0
	bl AnimatorSprite__Init
	mov r1, r4
	add r1, #0x50
	mov r0, #0xe
	add r6, r6, #1
	add r4, #0x64
	strh r0, [r1]
	cmp r6, #0xa
	blt _02153778
	ldr r0, [sp, #0x80]
	mov r1, #5
	ldr r4, _02153B10 // =0x000011FC
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r3, #0
	str r1, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x60]
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #3
	str r0, [sp, #0x18]
	ldr r1, [sp, #0x80]
	add r0, r5, r4
	mov r2, #5
	bl AnimatorSprite__Init
	add r0, r5, r4
	mov r1, #0xb
	add r0, #0x50
	strh r1, [r0]
	ldr r0, [sp, #0x80]
	mov r1, #4
	ldr r4, _02153B14 // =0x00002264
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r3, #0
	str r1, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x60]
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #2
	str r0, [sp, #0x18]
	ldr r1, [sp, #0x80]
	add r0, r5, r4
	mov r2, #4
	bl AnimatorSprite__Init
	add r0, r5, r4
	mov r1, #0xb
	add r0, #0x50
	strh r1, [r0]
	ldr r0, [sp, #0x80]
	mov r1, #1
	ldr r4, _02153B18 // =0x00001260
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r2, #1
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x60]
	str r1, [sp, #0xc]
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r1, [sp, #0x80]
	add r0, r5, r4
	mov r3, #4
	bl AnimatorSprite__Init
	add r0, r5, r4
	mov r1, #5
	add r0, #0x50
	strh r1, [r0]
	ldr r0, [sp, #0x80]
	mov r1, #6
	add r4, #0x64
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r3, #0
	str r1, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x60]
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #3
	str r0, [sp, #0x18]
	ldr r1, [sp, #0x80]
	add r0, r5, r4
	mov r2, #6
	bl AnimatorSprite__Init
	add r0, r5, r4
	mov r1, #5
	add r0, #0x50
	strh r1, [r0]
	ldr r0, [sp, #0x80]
	mov r1, #0x10
	ldr r4, _02153B1C // =0x0000219C
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r3, #0
	str r1, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x60]
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	ldr r1, [sp, #0x80]
	add r0, r5, r4
	mov r2, #0x10
	str r3, [sp, #0x18]
	bl AnimatorSprite__Init
	add r0, r5, r4
	mov r1, #0xf
	add r0, #0x50
	strh r1, [r0]
	ldr r0, [sp, #0x80]
	mov r1, #0x11
	add r4, #0x64
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r3, #0
	str r1, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x60]
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	ldr r1, [sp, #0x80]
	add r0, r5, r4
	mov r2, #0x11
	str r3, [sp, #0x18]
	bl AnimatorSprite__Init
	add r0, r5, r4
	mov r1, #0xf
	add r0, #0x50
	strh r1, [r0]
	ldr r0, _02153B20 // =0x00001328
	mov r6, #0
	add r4, r5, r0
	mov r0, r6
	str r0, [sp, #0x38]
_02153926:
	lsl r1, r6, #0x10
	ldr r0, [sp, #0x78]
	lsr r1, r1, #0x10
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	lsl r2, r6, #0x10
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, _02153B24 // =0x00002454
	ldr r1, [sp, #0x78]
	ldr r0, [r5, r0]
	lsr r2, r2, #0x10
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #2
	str r0, [sp, #0x18]
	mov r0, r4
	mov r3, #0
	bl AnimatorSprite__Init
	ldr r1, [r4, #0x3c]
	mov r0, #0x10
	orr r0, r1
	str r0, [r4, #0x3c]
	ldr r0, [sp, #0x5c]
	mov r1, r4
	str r0, [r4, #0x48]
	ldr r0, [sp, #0x38]
	add r1, #0x50
	str r0, [r4, #0x4c]
	add r6, r6, #1
	add r4, #0x64
	strh r0, [r1]
	cmp r6, #9
	blt _02153926
	ldr r0, _02153B28 // =0x000016AC
	add r0, r5, r0
	str r0, [sp, #0x54]
	ldr r0, [sp, #0x38]
	str r0, [sp, #0x50]
	str r0, [sp, #0x4c]
_0215398C:
	ldr r4, [sp, #0x54]
	mov r6, #0
_02153990:
	ldr r0, [sp, #0x50]
	add r0, r6, r0
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x58]
	ldr r1, [sp, #0x58]
	mov r0, r7
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r3, #0
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, _02153B2C // =0x00002458
	ldr r1, [r5, r0]
	ldr r0, [sp, #0x4c]
	add r0, r1, r0
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #2
	str r0, [sp, #0x18]
	ldr r2, [sp, #0x58]
	mov r0, r4
	mov r1, r7
	bl AnimatorSprite__Init
	ldr r1, [r4, #0x3c]
	mov r0, #0x10
	orr r0, r1
	str r0, [r4, #0x3c]
	ldr r0, [sp, #0x5c]
	str r0, [r4, #0x48]
	mov r0, #0
	str r0, [r4, #0x4c]
	ldr r0, [sp, #0x38]
	cmp r0, #0
	bne _021539F4
	mov r1, r4
	add r1, #0x50
	mov r0, #1
	b _021539FA
_021539F4:
	mov r1, r4
	add r1, #0x50
	mov r0, #2
_021539FA:
	add r6, r6, #1
	add r4, #0x64
	strh r0, [r1]
	cmp r6, #7
	blt _02153990
	mov r0, #0xaf
	ldr r1, [sp, #0x54]
	lsl r0, r0, #2
	add r1, r1, r0
	str r1, [sp, #0x54]
	ldr r1, [sp, #0x50]
	sub r0, #0xbc
	add r1, r1, #7
	str r1, [sp, #0x50]
	ldr r1, [sp, #0x4c]
	add r0, r1, r0
	str r0, [sp, #0x4c]
	ldr r0, [sp, #0x38]
	add r0, r0, #1
	str r0, [sp, #0x38]
	cmp r0, #2
	blt _0215398C
	ldr r0, _02153B30 // =0x00001C24
	mov r6, #0
	add r4, r5, r0
_02153A2C:
	lsl r0, r6, #0x10
	lsr r7, r0, #0x10
	ldr r0, [sp, #0x74]
	mov r1, r7
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	ldr r0, [r5, #0]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0]
	mov r2, r7
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, _02153B34 // =0x0000245C
	ldr r1, [sp, #0x74]
	ldr r0, [r5, r0]
	mov r3, #0
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #2
	str r0, [sp, #0x18]
	mov r0, r4
	bl AnimatorSprite__Init
	ldr r1, [r4, #0x3c]
	mov r0, #0x10
	orr r0, r1
	str r0, [r4, #0x3c]
	ldr r0, [sp, #0x5c]
	mov r1, r4
	str r0, [r4, #0x48]
	mov r0, #0
	str r0, [r4, #0x4c]
	add r1, #0x50
	mov r0, #3
	add r6, r6, #1
	add r4, #0x64
	strh r0, [r1]
	cmp r6, #0xe
	blt _02153A2C
	mov r0, #1
	str r0, [sp]
	mov r1, #0
	str r1, [sp, #4]
	mov r1, #9
	str r1, [sp, #8]
	mov r1, #0x20
	str r1, [sp, #0xc]
	mov r1, #0xb
	str r1, [sp, #0x10]
	ldr r1, [r5, #0]
	mov r2, #0
	str r1, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r1, #2
	str r1, [sp, #0x1c]
	str r0, [sp, #0x20]
	mov r0, #0
	str r0, [sp, #0x24]
	ldr r0, _02153B38 // =0x0000232C
	mov r1, r5
	add r0, r5, r0
	add r1, #0xd8
	mov r3, r2
	bl FontWindowAnimator__Load1
	mov r0, #0x15
	str r0, [sp]
	mov r0, #0x19
	str r0, [sp, #4]
	mov r0, #2
	str r0, [sp, #8]
	ldr r0, [r5, #0]
	mov r1, r5
	str r0, [sp, #0xc]
	mov r2, #0
	str r2, [sp, #0x10]
	mov r0, #3
	str r0, [sp, #0x14]
	mov r0, #1
	str r0, [sp, #0x18]
	ldr r0, _02153B3C // =0x00002390
	add r1, #0xd8
	add r0, r5, r0
	mov r3, #6
	bl FontAnimator__LoadFont1
	ldr r0, _02153B3C // =0x00002390
	ldr r1, [sp, #0x68]
	add r0, r5, r0
	bl FontAnimator__LoadMPCFile
	ldr r0, _02153B3C // =0x00002390
	mov r1, #0
	add r0, r5, r0
	bl FontAnimator__SetMsgSequence
	ldr r0, _02153B3C // =0x00002390
	mov r1, #1
	add r0, r5, r0
	mov r2, #0
	bl FontAnimator__InitStartPos
	add sp, #0x90
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02153B0C: .word 0x00000E14
_02153B10: .word 0x000011FC
_02153B14: .word 0x00002264
_02153B18: .word 0x00001260
_02153B1C: .word 0x0000219C
_02153B20: .word 0x00001328
_02153B24: .word 0x00002454
_02153B28: .word 0x000016AC
_02153B2C: .word 0x00002458
_02153B30: .word 0x00001C24
_02153B34: .word 0x0000245C
_02153B38: .word 0x0000232C
_02153B3C: .word 0x00002390
	thumb_func_end MainMenu__InitSprites

	thumb_func_start MainMenu__Func_2153B40
MainMenu__Func_2153B40: // 0x02153B40
	push {r4, r5, r6, lr}
	mov r4, r0
	ldr r0, [r4, #0]
	cmp r0, #0
	bne _02153B4E
	mov r6, #2
	b _02153B50
_02153B4E:
	mov r6, #4
_02153B50:
	ldr r0, _02153C9C // =0x00001328
	add r5, r4, r0
	ldr r1, [r5, #0x3c]
	mov r0, #0x10
	bic r1, r0
	mov r0, #0x40
	orr r0, r1
	str r0, [r5, #0x3c]
	mov r1, #0
	ldr r0, _02153CA0 // =0x00002454
	str r1, [r5, #0x48]
	ldr r0, [r4, r0]
	mov r2, r1
	str r0, [r5, #0x4c]
	mov r0, r5
	add r0, #0x50
	strh r1, [r0]
	mov r0, r5
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r5, #0x3c]
	mov r0, #0x10
	orr r0, r1
	str r0, [r5, #0x3c]
	str r6, [r5, #0x48]
	mov r0, #0
	str r0, [r5, #0x4c]
	add r5, #0x50
	strh r0, [r5]
	ldr r0, _02153CA0 // =0x00002454
	ldr r0, [r4, r0]
	bl MainMenu__Func_2156468
	ldr r0, _02153CA0 // =0x00002454
	mov r1, #1
	ldr r0, [r4, r0]
	lsl r1, r1, #8
	mov r2, r6
	mov r3, #0
	bl QueueUncompressedPalette
	ldr r0, _02153CA4 // =0x000016AC
	add r5, r4, r0
	ldr r1, [r5, #0x3c]
	mov r0, #0x10
	bic r1, r0
	mov r0, #0x40
	orr r0, r1
	str r0, [r5, #0x3c]
	mov r1, #0
	ldr r0, _02153CA8 // =0x00002458
	str r1, [r5, #0x48]
	ldr r0, [r4, r0]
	mov r2, r1
	str r0, [r5, #0x4c]
	mov r0, r5
	add r0, #0x50
	strh r1, [r0]
	mov r0, r5
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r5, #0x3c]
	mov r0, #0x10
	orr r0, r1
	str r0, [r5, #0x3c]
	str r6, [r5, #0x48]
	mov r1, #0
	str r1, [r5, #0x4c]
	mov r0, #1
	add r5, #0x50
	strh r0, [r5]
	ldr r0, _02153CAC // =0x00001968
	add r5, r4, r0
	ldr r2, [r5, #0x3c]
	mov r0, #0x10
	bic r2, r0
	mov r0, #0x40
	orr r2, r0
	str r2, [r5, #0x3c]
	ldr r2, _02153CA8 // =0x00002458
	str r1, [r5, #0x48]
	ldr r2, [r4, r2]
	lsl r0, r0, #3
	add r0, r2, r0
	str r0, [r5, #0x4c]
	mov r0, r5
	add r0, #0x50
	strh r1, [r0]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r5, #0x3c]
	mov r0, #0x10
	orr r0, r1
	str r0, [r5, #0x3c]
	str r6, [r5, #0x48]
	mov r0, #0
	str r0, [r5, #0x4c]
	mov r0, #2
	add r5, #0x50
	strh r0, [r5]
	ldr r0, _02153CA8 // =0x00002458
	ldr r0, [r4, r0]
	bl MainMenu__Func_2156498
	ldr r0, _02153CA8 // =0x00002458
	ldr r1, [r4, r0]
	mov r0, #2
	lsl r0, r0, #8
	add r0, r1, r0
	bl MainMenu__Func_21564C8
	ldr r0, _02153CA8 // =0x00002458
	mov r1, #2
	lsl r1, r1, #8
	ldr r0, [r4, r0]
	mov r2, r6
	mov r3, r1
	bl QueueUncompressedPalette
	ldr r0, _02153CB0 // =0x00001C24
	add r5, r4, r0
	ldr r1, [r5, #0x3c]
	mov r0, #0x10
	bic r1, r0
	mov r0, #0x40
	orr r0, r1
	str r0, [r5, #0x3c]
	mov r1, #0
	ldr r0, _02153CB4 // =0x0000245C
	str r1, [r5, #0x48]
	ldr r0, [r4, r0]
	mov r2, r1
	str r0, [r5, #0x4c]
	mov r0, r5
	add r0, #0x50
	strh r1, [r0]
	mov r0, r5
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r5, #0x3c]
	mov r0, #0x10
	orr r0, r1
	str r0, [r5, #0x3c]
	str r6, [r5, #0x48]
	mov r0, #0
	str r0, [r5, #0x4c]
	mov r0, #3
	add r5, #0x50
	strh r0, [r5]
	ldr r0, _02153CB4 // =0x0000245C
	ldr r0, [r4, r0]
	bl MainMenu__Func_21564F8
	ldr r0, _02153CB4 // =0x0000245C
	mov r1, #1
	mov r3, #6
	ldr r0, [r4, r0]
	lsl r1, r1, #8
	mov r2, r6
	lsl r3, r3, #8
	bl QueueUncompressedPalette
	pop {r4, r5, r6, pc}
	nop
_02153C9C: .word 0x00001328
_02153CA0: .word 0x00002454
_02153CA4: .word 0x000016AC
_02153CA8: .word 0x00002458
_02153CAC: .word 0x00001968
_02153CB0: .word 0x00001C24
_02153CB4: .word 0x0000245C
	thumb_func_end MainMenu__Func_2153B40

	thumb_func_start MainMenu__ReleaseSprites
MainMenu__ReleaseSprites: // 0x02153CB8
	push {r3, r4, r5, r6, r7, lr}
	ldr r1, _02153E3C // =0x00001C24
	str r0, [sp]
	add r1, r0, r1
	ldr r0, _02153E40 // =0x00000514
	mov r4, #0xd
	add r5, r1, r0
_02153CC6:
	mov r0, r5
	bl AnimatorSprite__Release
	sub r5, #0x64
	sub r4, r4, #1
	bpl _02153CC6
	ldr r1, _02153E44 // =0x000016AC
	ldr r0, [sp]
	mov r7, #1
	add r1, r0, r1
	mov r0, #0xaf
	lsl r0, r0, #2
	add r6, r1, r0
_02153CE0:
	mov r0, #0x96
	lsl r0, r0, #2
	mov r4, #6
	add r5, r6, r0
_02153CE8:
	mov r0, r5
	bl AnimatorSprite__Release
	sub r5, #0x64
	sub r4, r4, #1
	bpl _02153CE8
	mov r0, #0xaf
	lsl r0, r0, #2
	sub r6, r6, r0
	sub r7, r7, #1
	bpl _02153CE0
	ldr r1, _02153E48 // =0x00001328
	ldr r0, [sp]
	mov r4, #8
	add r1, r0, r1
	mov r0, #0x32
	lsl r0, r0, #4
	add r5, r1, r0
_02153D0C:
	mov r0, r5
	bl AnimatorSprite__Release
	sub r5, #0x64
	sub r4, r4, #1
	bpl _02153D0C
	mov r1, #0x22
	ldr r0, [sp]
	lsl r1, r1, #8
	add r0, r0, r1
	bl AnimatorSprite__Release
	ldr r1, _02153E4C // =0x0000219C
	ldr r0, [sp]
	add r0, r0, r1
	bl AnimatorSprite__Release
	ldr r1, _02153E50 // =0x000012C4
	ldr r0, [sp]
	add r0, r0, r1
	bl AnimatorSprite__Release
	ldr r1, _02153E54 // =0x00001260
	ldr r0, [sp]
	add r0, r0, r1
	bl AnimatorSprite__Release
	ldr r1, _02153E58 // =0x00002264
	ldr r0, [sp]
	add r0, r0, r1
	bl AnimatorSprite__Release
	ldr r1, _02153E5C // =0x000011FC
	ldr r0, [sp]
	add r0, r0, r1
	bl AnimatorSprite__Release
	ldr r1, _02153E60 // =0x00000A2C
	ldr r0, [sp]
	mov r7, #1
	add r1, r0, r1
	mov r0, #0xfa
	lsl r0, r0, #2
	add r6, r1, r0
_02153D64:
	mov r0, #0xe1
	lsl r0, r0, #2
	mov r5, #9
	add r4, r6, r0
_02153D6C:
	mov r0, r4
	bl AnimatorSprite__Release
	sub r4, #0x64
	sub r5, r5, #1
	bpl _02153D6C
	mov r0, #0xfa
	lsl r0, r0, #2
	sub r6, r6, r0
	sub r7, r7, #1
	bpl _02153D64
	ldr r1, _02153E64 // =0x000009C8
	ldr r0, [sp]
	add r0, r0, r1
	bl AnimatorSprite__Release
	ldr r1, _02153E68 // =0x00000964
	ldr r0, [sp]
	add r0, r0, r1
	bl AnimatorSprite__Release
	mov r1, #9
	ldr r0, [sp]
	lsl r1, r1, #8
	add r0, r0, r1
	bl AnimatorSprite__Release
	ldr r1, _02153E6C // =0x0000089C
	ldr r0, [sp]
	add r0, r0, r1
	bl AnimatorSprite__Release
	ldr r1, _02153E70 // =0x00000838
	ldr r0, [sp]
	add r0, r0, r1
	bl AnimatorSprite__Release
	ldr r1, _02153E74 // =0x000007D4
	ldr r0, [sp]
	add r0, r0, r1
	bl AnimatorSprite__Release
	mov r1, #0x77
	ldr r0, [sp]
	lsl r1, r1, #4
	add r0, r0, r1
	bl AnimatorSprite__Release
	ldr r1, _02153E78 // =0x0000070C
	ldr r0, [sp]
	add r0, r0, r1
	bl AnimatorSprite__Release
	ldr r1, _02153E7C // =0x000006A8
	ldr r0, [sp]
	add r0, r0, r1
	bl AnimatorSprite__Release
	mov r1, #0x45
	ldr r0, [sp]
	lsl r1, r1, #4
	add r1, r0, r1
	mov r0, #0x7d
	lsl r0, r0, #2
	mov r4, #5
	add r5, r1, r0
_02153DF0:
	mov r0, r5
	bl AnimatorSprite__Release
	sub r5, #0x64
	sub r4, r4, #1
	bpl _02153DF0
	mov r1, #0x7e
	ldr r0, [sp]
	lsl r1, r1, #2
	add r2, r0, r1
	sub r0, r1, #4
	mov r4, #5
	add r5, r2, r0
_02153E0A:
	mov r0, r5
	bl AnimatorSprite__Release
	sub r5, #0x64
	sub r4, r4, #1
	bpl _02153E0A
	mov r2, #0x7e
	ldr r1, [sp]
	lsl r2, r2, #2
	add r1, r1, r2
	ldr r2, _02153E80 // =0x000020D0
	mov r0, #0
	bl MIi_CpuClear32
	ldr r1, _02153E84 // =0x0000232C
	ldr r0, [sp]
	add r0, r0, r1
	bl FontWindowAnimator__Release
	ldr r1, _02153E88 // =0x00002390
	ldr r0, [sp]
	add r0, r0, r1
	bl FontAnimator__Release
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02153E3C: .word 0x00001C24
_02153E40: .word 0x00000514
_02153E44: .word 0x000016AC
_02153E48: .word 0x00001328
_02153E4C: .word 0x0000219C
_02153E50: .word 0x000012C4
_02153E54: .word 0x00001260
_02153E58: .word 0x00002264
_02153E5C: .word 0x000011FC
_02153E60: .word 0x00000A2C
_02153E64: .word 0x000009C8
_02153E68: .word 0x00000964
_02153E6C: .word 0x0000089C
_02153E70: .word 0x00000838
_02153E74: .word 0x000007D4
_02153E78: .word 0x0000070C
_02153E7C: .word 0x000006A8
_02153E80: .word 0x000020D0
_02153E84: .word 0x0000232C
_02153E88: .word 0x00002390
	thumb_func_end MainMenu__ReleaseSprites

	thumb_func_start MainMenu__Func_2153E8C
MainMenu__Func_2153E8C: // 0x02153E8C
	push {r3, r4, r5, r6, r7, lr}
	mov r1, #0x7e
	lsl r1, r1, #2
	ldr r4, _02153F00 // =0x0217D11E
	str r0, [sp]
	mov r6, #0
	add r5, r0, r1
_02153E9A:
	ldrh r1, [r4, #0]
	mov r0, r5
	bl AnimatorSprite__SetAnimation
	add r6, r6, #1
	add r4, r4, #2
	add r5, #0x64
	cmp r6, #6
	blt _02153E9A
	mov r1, #0x45
	ldr r0, [sp]
	lsl r1, r1, #4
	ldr r4, _02153F04 // =0x0217D12A
	mov r7, #0
	add r6, r0, r1
	mov r5, r0
_02153EBA:
	ldrh r1, [r4, #0]
	mov r0, r6
	bl AnimatorSprite__SetAnimation
	mov r0, #0x4a
	mov r1, #0
	lsl r0, r0, #4
	strh r1, [r5, r0]
	add r7, r7, #1
	add r4, r4, #2
	add r6, #0x64
	add r5, #0x64
	cmp r7, #6
	blt _02153EBA
	ldr r1, _02153F08 // =0x000006A8
	ldr r0, [sp]
	add r0, r0, r1
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	ldr r1, _02153F0C // =0x0000070C
	ldr r0, [sp]
	add r0, r0, r1
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	mov r1, #0x77
	ldr r0, [sp]
	lsl r1, r1, #4
	add r0, r0, r1
	mov r1, #0xe
	bl AnimatorSprite__SetAnimation
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02153F00: .word 0x0217D11E
_02153F04: .word 0x0217D12A
_02153F08: .word 0x000006A8
_02153F0C: .word 0x0000070C
	thumb_func_end MainMenu__Func_2153E8C

	thumb_func_start MainMenu__Func_2153F10
MainMenu__Func_2153F10: // 0x02153F10
	push {r4, lr}
	ldr r1, [r0, #0]
	cmp r1, #0
	bne _02153F1E
	mov r4, #6
	lsl r4, r4, #0x18
	b _02153F22
_02153F1E:
	mov r4, #0x62
	lsl r4, r4, #0x14
_02153F22:
	ldr r1, _02153F3C // =0x000022E4
	add r0, r0, r1
	bl DrawBackground
	mov r1, #0x16
	lsl r1, r1, #8
	mov r2, #0x1a
	mov r0, #0
	add r1, r4, r1
	lsl r2, r2, #8
	bl MIi_CpuClearFast
	pop {r4, pc}
	.align 2, 0
_02153F3C: .word 0x000022E4
	thumb_func_end MainMenu__Func_2153F10

	thumb_func_start MainMenu__Func_2153F40
MainMenu__Func_2153F40: // 0x02153F40
	push {r4, lr}
	mov r4, r0
	ldr r0, _02153F74 // =0x00002468
	add r0, r4, r0
	bl IsThreadWorkerFinished
	cmp r0, #0
	beq _02153F70
	mov r0, r4
	bl MainMenu__Func_2153B40
	mov r0, r4
	bl MainMenu__Func_21549C8
	mov r3, r0
	mov r0, r4
	mov r1, #1
	mov r2, #0
	bl MainMenu__Func_2153FD0
	ldr r1, _02153F78 // =MainMenu__State_21548A4
	mov r0, r4
	bl MainMenu__SetState
_02153F70:
	pop {r4, pc}
	nop
_02153F74: .word 0x00002468
_02153F78: .word MainMenu__State_21548A4
	thumb_func_end MainMenu__Func_2153F40

	thumb_func_start MainMenu__Func_2153F7C
MainMenu__Func_2153F7C: // 0x02153F7C
	push {r4, lr}
	mov r4, r0
	ldr r0, _02153FC0 // =0x00002468
	add r0, r4, r0
	bl IsThreadWorkerFinished
	cmp r0, #0
	beq _02153FBC
	mov r0, r4
	bl MainMenu__Func_2153B40
	mov r0, r4
	add r0, #0x1c
	bl MainMenu__Func_2156714
	mov r0, r4
	mov r1, #1
	add r0, #0xc8
	str r1, [r0]
	mov r0, r4
	bl MainMenu__Func_21549C8
	mov r3, r0
	mov r0, r4
	mov r1, #1
	mov r2, #0
	bl MainMenu__Func_2153FD0
	ldr r1, _02153FC4 // =MainMenu__State_21548A4
	mov r0, r4
	bl MainMenu__SetState
_02153FBC:
	pop {r4, pc}
	nop
_02153FC0: .word 0x00002468
_02153FC4: .word MainMenu__State_21548A4
	thumb_func_end MainMenu__Func_2153F7C

	thumb_func_start MainMenu__Func_2153FC8
MainMenu__Func_2153FC8: // 0x02153FC8
	ldr r3, _02153FCC // =MainMenu__InitSprites
	bx r3
	.align 2, 0
_02153FCC: .word MainMenu__InitSprites
	thumb_func_end MainMenu__Func_2153FC8

	thumb_func_start MainMenu__Func_2153FD0
MainMenu__Func_2153FD0: // 0x02153FD0
	push {r3, r4, r5, r6, r7, lr}
	str r1, [sp]
	mov r1, #0x65
	mov r4, r0
	lsl r1, r1, #2
	str r3, [r4, r1]
	mov r5, #0
	add r0, r1, #4
	str r5, [r4, r0]
	mov r0, r1
	add r0, #8
	strh r2, [r4, r0]
	add r1, #8
	ldrh r1, [r4, r1]
	lsl r0, r1, #1
	ldrh r0, [r3, r0]
	cmp r0, #7
	bne _02154016
	mov r0, r5
	mov r5, #0x67
	lsl r5, r5, #2
	mov r2, r5
	mov r7, r5
_02153FFE:
	cmp r1, #3
	bhs _0215400A
	ldrh r1, [r4, r5]
	add r1, r1, #1
	strh r1, [r4, r5]
	b _0215400C
_0215400A:
	strh r0, [r4, r2]
_0215400C:
	ldrh r1, [r4, r7]
	lsl r6, r1, #1
	ldrh r6, [r3, r6]
	cmp r6, #7
	beq _02153FFE
_02154016:
	mov r0, r4
	bl MainMenu__Func_2153E8C
	mov r0, r4
	bl MainMenu__Func_2153F10
	ldr r0, [sp]
	cmp r0, #0
	beq _02154034
	mov r2, #1
	mov r0, r4
	mov r1, #0
	lsl r2, r2, #8
	bl MainMenu__Func_2153284
_02154034:
	mov r0, r4
	mov r1, #0
	bl MainMenu__Func_2153254
	mov r1, #0x19
	mov r0, #0
	lsl r1, r1, #4
	str r0, [r4, r1]
	ldr r0, [sp]
	cmp r0, #0
	beq _02154058
	ldr r0, _02154068 // =MainMenu__Func_21540BC
	add r1, #0x10
	str r0, [r4, r1]
	mov r0, #7
	bl PlaySysSfx
	b _0215405E
_02154058:
	ldr r0, _0215406C // =MainMenu__Func_21541D4
	add r1, #0x10
	str r0, [r4, r1]
_0215405E:
	mov r0, r4
	mov r1, #0
	bl MainMenu__Func_215600C
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02154068: .word MainMenu__Func_21540BC
_0215406C: .word MainMenu__Func_21541D4
	thumb_func_end MainMenu__Func_2153FD0

	thumb_func_start MainMenu__Func_2154070
MainMenu__Func_2154070: // 0x02154070
	push {r3, r4, r5, lr}
	mov r1, #0x1a
	mov r5, r0
	lsl r1, r1, #4
	ldr r4, [r5, r1]
	cmp r4, #0
	beq _02154080
	blx r4
_02154080:
	mov r1, #0x1a
	lsl r1, r1, #4
	ldr r0, [r5, r1]
	cmp r4, r0
	bne _02154098
	mov r0, r1
	sub r0, #0x10
	ldr r0, [r5, r0]
	sub r1, #0x10
	add r0, r0, #1
	str r0, [r5, r1]
	pop {r3, r4, r5, pc}
_02154098:
	mov r0, #0
	sub r1, #0x10
	str r0, [r5, r1]
	pop {r3, r4, r5, pc}
	thumb_func_end MainMenu__Func_2154070

	thumb_func_start MainMenu__Func_21540A0
MainMenu__Func_21540A0: // 0x021540A0
	mov r1, #0x1a
	lsl r1, r1, #4
	ldr r0, [r0, r1]
	cmp r0, #0
	bne _021540AE
	mov r0, #1
	bx lr
_021540AE:
	mov r0, #0
	bx lr
	.align 2, 0
	thumb_func_end MainMenu__Func_21540A0

	thumb_func_start MainMenu__Func_21540B4
MainMenu__Func_21540B4: // 0x021540B4
	mov r1, #0x67
	lsl r1, r1, #2
	ldrh r0, [r0, r1]
	bx lr
	thumb_func_end MainMenu__Func_21540B4

	thumb_func_start MainMenu__Func_21540BC
MainMenu__Func_21540BC: // 0x021540BC
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r4, #1
	mov r1, #2
	mov r2, r4
	mov r5, r0
	bl MainMenu__SetWindowVisible
	mov r0, #0x19
	lsl r0, r0, #4
	ldr r3, [r5, r0]
	cmp r3, #0xc
	blo _021540DA
	mov r6, #0
	b _021540EE
_021540DA:
	lsl r0, r4, #0xd
	str r0, [sp]
	mov r0, #0xc0
	mov r1, #0
	mov r2, #0xc
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r6, r0, #0x10
	mov r4, #0
_021540EE:
	mov r0, r5
	mov r1, #0
	mov r2, r6
	bl MainMenu__Func_2153284
	mov r1, #0x65
	lsl r1, r1, #2
	ldr r1, [r5, r1]
	add r6, #0x10
	lsl r3, r6, #0x10
	ldrh r1, [r1, #0x12]
	mov r0, r5
	mov r2, #0x28
	asr r3, r3, #0x10
	bl MainMenu__DrawTextPrompt
	mov r0, #0x19
	lsl r0, r0, #4
	ldr r1, [r5, r0]
	cmp r1, #8
	bhs _0215411C
	mov r4, #0
	b _0215412A
_0215411C:
	mov r0, r5
	sub r1, #8
	bl MainMenu__Func_2154718
	cmp r0, #0
	bne _0215412A
	mov r4, #0
_0215412A:
	mov r0, #0x65
	lsl r0, r0, #2
	ldr r1, [r5, r0]
	ldrh r1, [r1, #0x14]
	cmp r1, #0
	beq _0215418E
	sub r0, r0, #4
	ldr r6, [r5, r0]
	cmp r6, #0x10
	bhs _02154142
	mov r4, #0
	b _0215418E
_02154142:
	sub r6, #0x10
	cmp r6, #0xc
	blo _02154156
	mov r0, r5
	mov r1, #0x10
	mov r2, #0xb0
	mov r3, #0
	bl MainMenu__Func_2155804
	b _0215418E
_02154156:
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x10
	mov r1, r0
	mov r2, #0xc
	mov r3, r6
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0xd0
	mov r1, #0xb0
	mov r2, #0xc
	mov r3, r6
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r2, r0, #0x10
	mov r0, r5
	mov r1, r4
	mov r3, #0
	bl MainMenu__Func_2155804
	mov r4, #0
_0215418E:
	cmp r4, #0
	beq _021541C6
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl MainMenu__Func_2153284
	mov r0, #0x65
	lsl r0, r0, #2
	ldr r0, [r5, r0]
	ldr r1, _021541CC // =0x0000FFFF
	ldrh r0, [r0, #0x16]
	cmp r0, r1
	beq _021541B0
	mov r1, #0xb4
	bl NavTailsSpeak
_021541B0:
	mov r1, #0x65
	lsl r1, r1, #2
	ldr r1, [r5, r1]
	mov r0, r5
	ldrh r1, [r1, #0x14]
	bl MainMenu__Func_215600C
	mov r0, #0x1a
	ldr r1, _021541D0 // =MainMenu__Func_21542A0
	lsl r0, r0, #4
	str r1, [r5, r0]
_021541C6:
	add sp, #4
	pop {r3, r4, r5, r6, pc}
	nop
_021541CC: .word 0x0000FFFF
_021541D0: .word MainMenu__Func_21542A0
	thumb_func_end MainMenu__Func_21540BC

	thumb_func_start MainMenu__Func_21541D4
MainMenu__Func_21541D4: // 0x021541D4
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r1, #0x65
	mov r5, r0
	lsl r1, r1, #2
	ldr r1, [r5, r1]
	mov r2, #0x28
	ldrh r1, [r1, #0x12]
	mov r3, #0x10
	bl MainMenu__DrawTextPrompt
	mov r1, #0x19
	lsl r1, r1, #4
	ldr r1, [r5, r1]
	mov r0, r5
	bl MainMenu__Func_2154718
	mov r6, r0
	mov r0, #0x65
	lsl r0, r0, #2
	ldr r1, [r5, r0]
	ldrh r1, [r1, #0x14]
	cmp r1, #0
	beq _0215425C
	sub r0, r0, #4
	ldr r4, [r5, r0]
	cmp r4, #8
	bhs _02154210
	mov r6, #0
	b _0215425C
_02154210:
	sub r4, #8
	cmp r4, #0xc
	blo _02154224
	mov r0, r5
	mov r1, #0x10
	mov r2, #0xb0
	mov r3, #0
	bl MainMenu__Func_2155804
	b _0215425C
_02154224:
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x10
	mov r1, r0
	mov r2, #0xc
	mov r3, r4
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r6, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0xd0
	mov r1, #0xb0
	mov r2, #0xc
	mov r3, r4
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r2, r0, #0x10
	mov r0, r5
	mov r1, r6
	mov r3, #0
	bl MainMenu__Func_2155804
	mov r6, #0
_0215425C:
	cmp r6, #0
	beq _0215428E
	mov r0, #0x65
	lsl r0, r0, #2
	ldr r0, [r5, r0]
	ldr r1, _02154294 // =0x0000FFFF
	ldrh r0, [r0, #0x16]
	cmp r0, r1
	beq _02154274
	mov r1, #0xb4
	bl NavTailsSpeak
_02154274:
	mov r1, #0x65
	lsl r1, r1, #2
	ldr r1, [r5, r1]
	mov r0, r5
	ldrh r1, [r1, #0x14]
	bl MainMenu__Func_215600C
	ldr r1, _02154294 // =0x0000FFFF
	ldr r0, _02154298 // =0x0000019E
	strh r1, [r5, r0]
	ldr r1, _0215429C // =MainMenu__Func_21542A0
	add r0, r0, #2
	str r1, [r5, r0]
_0215428E:
	add sp, #4
	pop {r3, r4, r5, r6, pc}
	nop
_02154294: .word 0x0000FFFF
_02154298: .word 0x0000019E
_0215429C: .word MainMenu__Func_21542A0
	thumb_func_end MainMenu__Func_21541D4

	thumb_func_start MainMenu__Func_21542A0
MainMenu__Func_21542A0: // 0x021542A0
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #8
	mov r1, #0
	str r1, [sp, #4]
	str r1, [sp]
	mov r7, r1
	mov r1, #0x65
	mov r5, r0
	lsl r1, r1, #2
	ldr r4, [r5, r1]
	mov r1, #1
	bl MainMenu__Func_21532D0
	cmp r0, #4
	bhs _021542DA
	lsl r1, r0, #1
	ldrh r1, [r4, r1]
	cmp r1, #6
	bhs _02154306
	mov r1, #0x67
	lsl r1, r1, #2
	ldrh r2, [r5, r1]
	cmp r2, r0
	beq _021542D4
	strh r0, [r5, r1]
	mov r7, #1
_021542D4:
	ldr r1, _02154458 // =0x0000019E
	strh r0, [r5, r1]
	b _02154306
_021542DA:
	ldr r0, _02154458 // =0x0000019E
	ldrh r6, [r5, r0]
	ldr r0, _0215445C // =0x0000FFFF
	cmp r6, r0
	beq _02154306
	mov r0, r5
	mov r1, r7
	bl MainMenu__Func_21532D0
	cmp r6, r0
	bne _02154306
	mov r0, #0x67
	lsl r0, r0, #2
	ldrh r0, [r5, r0]
	cmp r6, r0
	bne _02154306
	lsl r0, r6, #1
	ldrh r0, [r4, r0]
	cmp r0, #6
	bhs _02154306
	mov r0, #1
	str r0, [sp, #4]
_02154306:
	ldr r0, _02154460 // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x40
	tst r0, r1
	beq _0215433E
	mov r3, #0x67
	lsl r3, r3, #2
	mov r0, #3
	mov r1, r3
	mov r7, r3
	mov r2, r3
_0215431C:
	ldrh r6, [r5, r2]
	cmp r6, #0
	bne _02154326
	strh r0, [r5, r1]
	b _0215432C
_02154326:
	ldrh r6, [r5, r3]
	sub r6, r6, #1
	strh r6, [r5, r3]
_0215432C:
	ldrh r6, [r5, r7]
	lsl r6, r6, #1
	ldrh r6, [r4, r6]
	cmp r6, #6
	bhs _0215431C
	ldr r1, _0215445C // =0x0000FFFF
	ldr r0, _02154458 // =0x0000019E
	mov r7, #1
	strh r1, [r5, r0]
_0215433E:
	ldr r0, _02154460 // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x80
	tst r0, r1
	beq _02154376
	mov r3, #0x67
	lsl r3, r3, #2
	mov r0, #0
	mov r1, r3
	mov r7, r3
	mov r2, r3
_02154354:
	ldrh r6, [r5, r2]
	cmp r6, #3
	bne _0215435E
	strh r0, [r5, r1]
	b _02154364
_0215435E:
	ldrh r6, [r5, r3]
	add r6, r6, #1
	strh r6, [r5, r3]
_02154364:
	ldrh r6, [r5, r7]
	lsl r6, r6, #1
	ldrh r6, [r4, r6]
	cmp r6, #6
	bhs _02154354
	ldr r1, _0215445C // =0x0000FFFF
	ldr r0, _02154458 // =0x0000019E
	mov r7, #1
	strh r1, [r5, r0]
_02154376:
	ldr r0, _02154460 // =padInput
	mov r1, #1
	ldrh r0, [r0, #4]
	mov r2, r0
	tst r2, r1
	beq _02154384
	str r1, [sp, #4]
_02154384:
	ldrh r1, [r4, #0x14]
	cmp r1, #0
	beq _0215439E
	mov r1, #2
	tst r0, r1
	bne _0215439A
	mov r0, r5
	bl MainMenu__Func_2156074
	cmp r0, #0
	beq _0215439E
_0215439A:
	mov r0, #1
	str r0, [sp]
_0215439E:
	cmp r7, #1
	bne _021543B0
	mov r0, #0x66
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r5, r0]
	mov r0, #2
	bl PlaySysMenuNavSfx
_021543B0:
	ldrh r1, [r4, #0x12]
	mov r0, r5
	mov r2, #0x28
	mov r3, #0x10
	bl MainMenu__DrawTextPrompt
	mov r0, r5
	mov r1, #1
	bl MainMenu__Func_2154848
	ldr r0, [sp, #4]
	cmp r0, #0
	bne _021543D8
	mov r1, #0x67
	lsl r1, r1, #2
	ldrh r1, [r5, r1]
	mov r0, r5
	mov r2, #0
	bl MainMenu__DrawCursor
_021543D8:
	ldrh r0, [r4, #0x14]
	cmp r0, #0
	beq _021543F0
	mov r0, r5
	bl MainMenu__Func_2156048
	mov r3, r0
	mov r0, r5
	mov r1, #0x10
	mov r2, #0xb0
	bl MainMenu__Func_2155804
_021543F0:
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _0215440E
	mov r0, r5
	mov r1, #0
	bl MainMenu__Func_215600C
	mov r0, #0x1a
	ldr r1, _02154464 // =MainMenu__Func_2154470
	lsl r0, r0, #4
	str r1, [r5, r0]
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _02154448
_0215440E:
	ldr r0, [sp]
	cmp r0, #0
	beq _02154448
	mov r0, r5
	mov r1, #0
	bl MainMenu__Func_215600C
	mov r1, #0x67
	mov r0, #4
	lsl r1, r1, #2
	strh r0, [r5, r1]
	mov r0, r1
	sub r0, #8
	ldr r2, [r5, r0]
	ldrh r0, [r5, r1]
	lsl r0, r0, #1
	add r0, r2, r0
	ldrh r2, [r0, #8]
	mov r0, #1
	tst r0, r2
	beq _0215443C
	ldr r2, _02154468 // =MainMenu__Func_215456C
	b _0215443E
_0215443C:
	ldr r2, _0215446C // =MainMenu__Func_21544E8
_0215443E:
	add r0, r1, #4
	str r2, [r5, r0]
	mov r0, #1
	bl PlaySysMenuNavSfx
_02154448:
	mov r0, #0x66
	lsl r0, r0, #2
	ldr r1, [r5, r0]
	add r1, r1, #1
	str r1, [r5, r0]
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02154458: .word 0x0000019E
_0215445C: .word 0x0000FFFF
_02154460: .word padInput
_02154464: .word MainMenu__Func_2154470
_02154468: .word MainMenu__Func_215456C
_0215446C: .word MainMenu__Func_21544E8
	thumb_func_end MainMenu__Func_21542A0

	thumb_func_start MainMenu__Func_2154470
MainMenu__Func_2154470: // 0x02154470
	push {r4, lr}
	mov r1, #0x65
	mov r4, r0
	lsl r1, r1, #2
	ldr r1, [r4, r1]
	mov r2, #0x28
	ldrh r1, [r1, #0x12]
	mov r3, #0x10
	bl MainMenu__DrawTextPrompt
	mov r0, r4
	mov r1, #2
	bl MainMenu__Func_2154848
	mov r0, #0x65
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	ldrh r0, [r0, #0x14]
	cmp r0, #0
	beq _021544A4
	mov r0, r4
	mov r1, #0x10
	mov r2, #0xb0
	mov r3, #0
	bl MainMenu__Func_2155804
_021544A4:
	mov r1, #0x19
	lsl r1, r1, #4
	ldr r0, [r4, r1]
	cmp r0, #0x10
	blo _021544D2
	add r0, r1, #4
	ldr r2, [r4, r0]
	mov r0, r1
	add r0, #0xc
	ldrh r0, [r4, r0]
	lsl r0, r0, #1
	add r0, r2, r0
	ldrh r2, [r0, #8]
	mov r0, #1
	tst r0, r2
	beq _021544CC
	ldr r0, _021544E0 // =MainMenu__Func_215456C
	add r1, #0x10
	str r0, [r4, r1]
	b _021544D2
_021544CC:
	ldr r0, _021544E4 // =MainMenu__Func_21544E8
	add r1, #0x10
	str r0, [r4, r1]
_021544D2:
	mov r0, #0x66
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r1, r1, #1
	str r1, [r4, r0]
	pop {r4, pc}
	nop
_021544E0: .word MainMenu__Func_215456C
_021544E4: .word MainMenu__Func_21544E8
	thumb_func_end MainMenu__Func_2154470

	thumb_func_start MainMenu__Func_21544E8
MainMenu__Func_21544E8: // 0x021544E8
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r1, #0x65
	mov r5, r0
	lsl r1, r1, #2
	ldr r1, [r5, r1]
	mov r2, #0x28
	ldrh r1, [r1, #0x12]
	mov r3, #0x10
	bl MainMenu__DrawTextPrompt
	mov r1, #0x19
	lsl r1, r1, #4
	ldr r1, [r5, r1]
	mov r0, r5
	bl MainMenu__Func_21547A8
	mov r1, #0x65
	lsl r1, r1, #2
	ldr r2, [r5, r1]
	ldrh r2, [r2, #0x14]
	cmp r2, #0
	beq _02154556
	sub r1, r1, #4
	ldr r4, [r5, r1]
	cmp r4, #0xc
	bhs _02154556
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x10
	mov r1, r0
	mov r2, #0xc
	mov r3, r4
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r6, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0xb0
	mov r1, #0xd0
	mov r2, #0xc
	mov r3, r4
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r2, r0, #0x10
	mov r0, r5
	mov r1, r6
	mov r3, #0
	bl MainMenu__Func_2155804
	mov r0, #0
_02154556:
	cmp r0, #0
	beq _02154562
	mov r0, #0x1a
	ldr r1, _02154568 // =MainMenu__Func_2154690
	lsl r0, r0, #4
	str r1, [r5, r0]
_02154562:
	add sp, #4
	pop {r3, r4, r5, r6, pc}
	nop
_02154568: .word MainMenu__Func_2154690
	thumb_func_end MainMenu__Func_21544E8

	thumb_func_start MainMenu__Func_215456C
MainMenu__Func_215456C: // 0x0215456C
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r1, #0x19
	mov r5, r0
	lsl r1, r1, #4
	ldr r1, [r5, r1]
	mov r6, #1
	bl MainMenu__Func_21547A8
	cmp r0, #0
	bne _02154584
	mov r6, #0
_02154584:
	mov r0, #0x65
	lsl r0, r0, #2
	ldr r1, [r5, r0]
	ldrh r1, [r1, #0x14]
	cmp r1, #0
	beq _021545D0
	sub r0, r0, #4
	ldr r4, [r5, r0]
	cmp r4, #0xc
	bhs _021545D0
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x10
	mov r1, r0
	mov r2, #0xc
	mov r3, r4
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r6, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0xb0
	mov r1, #0xd0
	mov r2, #0xc
	mov r3, r4
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r2, r0, #0x10
	mov r0, r5
	mov r1, r6
	mov r3, #0
	bl MainMenu__Func_2155804
	mov r6, #0
_021545D0:
	mov r0, #0x19
	lsl r0, r0, #4
	ldr r3, [r5, r0]
	cmp r3, #0x10
	bhs _021545DE
	mov r4, #0
	b _021545F0
_021545DE:
	mov r0, #0
	mov r1, #0xc0
	mov r2, #0xc
	sub r3, #0x10
	str r0, [sp]
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
_021545F0:
	mov r0, r5
	mov r1, #0
	mov r2, r4
	bl MainMenu__Func_2153284
	mov r0, #0x19
	lsl r0, r0, #4
	ldr r0, [r5, r0]
	cmp r0, #0x1c
	bhs _02154606
	mov r6, #0
_02154606:
	mov r1, #0x65
	lsl r1, r1, #2
	ldr r1, [r5, r1]
	add r4, #0x10
	ldrh r1, [r1, #0x12]
	lsl r3, r4, #0x10
	mov r0, r5
	mov r2, #0x28
	asr r3, r3, #0x10
	bl MainMenu__DrawTextPrompt
	mov r1, #0x19
	lsl r1, r1, #4
	ldr r0, [r5, r1]
	cmp r0, #0x10
	bne _0215467C
	add r0, r1, #4
	add r1, #0xc
	ldr r2, [r5, r0]
	ldrh r0, [r5, r1]
	mov r1, #2
	lsl r0, r0, #1
	add r0, r2, r0
	ldrh r0, [r0, #8]
	tst r0, r1
	beq _02154642
	mov r0, r5
	sub r1, #0x12
	bl MainMenu__Func_2153254
_02154642:
	mov r0, #0x65
	lsl r0, r0, #2
	ldr r1, [r5, r0]
	add r0, #8
	ldrh r0, [r5, r0]
	lsl r0, r0, #1
	add r0, r1, r0
	ldrh r0, [r0, #8]
	mov r1, #4
	tst r0, r1
	beq _02154660
	mov r0, r5
	sub r1, #0x14
	bl MainMenu__Func_2153024
_02154660:
	mov r0, #0x65
	lsl r0, r0, #2
	ldr r1, [r5, r0]
	add r0, #8
	ldrh r0, [r5, r0]
	lsl r0, r0, #1
	add r0, r1, r0
	ldrh r1, [r0, #8]
	mov r0, #8
	tst r0, r1
	beq _0215467C
	mov r0, #0xc
	bl FadeSysTrack
_0215467C:
	cmp r6, #0
	beq _02154688
	mov r0, #0x1a
	ldr r1, _0215468C // =MainMenu__Func_2154690
	lsl r0, r0, #4
	str r1, [r5, r0]
_02154688:
	add sp, #4
	pop {r3, r4, r5, r6, pc}
	.align 2, 0
_0215468C: .word MainMenu__Func_2154690
	thumb_func_end MainMenu__Func_215456C

	thumb_func_start MainMenu__Func_2154690
MainMenu__Func_2154690: // 0x02154690
	push {r4, lr}
	mov r1, #0
	mov r4, r0
	bl MainMenu__Func_215600C
	mov r0, #0x65
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r0, #8
	ldrh r0, [r4, r0]
	lsl r0, r0, #1
	add r0, r1, r0
	ldrh r2, [r0, #8]
	mov r0, #1
	tst r0, r2
	bne _021546BC
	ldrh r1, [r1, #0x12]
	mov r0, r4
	mov r2, #0x28
	mov r3, #0x10
	bl MainMenu__DrawTextPrompt
_021546BC:
	mov r0, #0x65
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r0, #8
	ldrh r0, [r4, r0]
	lsl r0, r0, #1
	add r0, r1, r0
	ldrh r0, [r0, #8]
	mov r1, #2
	tst r0, r1
	beq _021546E4
	mov r0, r4
	sub r1, #0x12
	bl MainMenu__Func_2153254
	mov r0, r4
	bl MainMenu__Func_2153260
	cmp r0, #0
	beq _02154714
_021546E4:
	mov r0, #0x65
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r0, #8
	ldrh r0, [r4, r0]
	lsl r0, r0, #1
	add r0, r1, r0
	ldrh r0, [r0, #8]
	mov r1, #4
	tst r0, r1
	beq _0215470C
	mov r0, r4
	sub r1, #0x14
	bl MainMenu__Func_2153024
	mov r0, r4
	bl MainMenu__Func_215302C
	cmp r0, #0
	beq _02154714
_0215470C:
	mov r0, #0x1a
	mov r1, #0
	lsl r0, r0, #4
	str r1, [r4, r0]
_02154714:
	pop {r4, pc}
	.align 2, 0
	thumb_func_end MainMenu__Func_2154690

	thumb_func_start MainMenu__Func_2154718
MainMenu__Func_2154718: // 0x02154718
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r7, r0
	mov r0, #1
	mov r5, #0
	mov r6, r1
	mov r4, #0x38
	str r0, [sp, #0xc]
	str r5, [sp, #0x10]
_0215472A:
	mov r0, #0x65
	lsl r0, r0, #2
	ldr r0, [r7, r0]
	ldrh r1, [r0, r5]
	cmp r1, #6
	bhs _02154790
	cmp r6, #0
	bge _02154740
	mov r0, #0
	str r0, [sp, #0xc]
	b _0215478E
_02154740:
	cmp r6, #0xc
	bge _0215477C
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, r4
	add r0, #0xc0
	mov r1, r4
	mov r2, #0xc
	mov r3, r6
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r1, #0x65
	str r0, [sp, #8]
	lsl r1, r1, #2
	ldr r1, [r7, r1]
	mov r0, r7
	ldrh r1, [r1, r5]
	mov r2, #0
	mov r3, #0x30
	bl MainMenu__DrawTextPrompt2
	b _0215478E
_0215477C:
	str r4, [sp]
	mov r0, #0
	str r0, [sp, #4]
	str r0, [sp, #8]
	mov r0, r7
	mov r2, #0
	mov r3, #0x30
	bl MainMenu__DrawTextPrompt2
_0215478E:
	sub r6, r6, #4
_02154790:
	add r4, #0x1c
	lsl r0, r4, #0x10
	asr r4, r0, #0x10
	ldr r0, [sp, #0x10]
	add r5, r5, #2
	add r0, r0, #1
	str r0, [sp, #0x10]
	cmp r0, #4
	blt _0215472A
	ldr r0, [sp, #0xc]
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	thumb_func_end MainMenu__Func_2154718

	thumb_func_start MainMenu__Func_21547A8
MainMenu__Func_21547A8: // 0x021547A8
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x18
	mov r6, r0
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #3
	mov r5, r1
	mov r4, #0x8c
	str r0, [sp, #0x10]
	mov r7, #6
_021547BC:
	mov r0, #0x65
	lsl r0, r0, #2
	ldr r0, [r6, r0]
	ldrh r1, [r0, r7]
	cmp r1, #6
	bhs _02154832
	mov r0, #0x67
	lsl r0, r0, #2
	ldrh r2, [r6, r0]
	ldr r0, [sp, #0x10]
	cmp r0, r2
	bne _021547DA
	mov r0, #1
	str r0, [sp, #0xc]
	b _021547DE
_021547DA:
	mov r0, #0
	str r0, [sp, #0xc]
_021547DE:
	cmp r5, #0
	bge _021547FA
	str r4, [sp]
	mov r0, #0
	str r0, [sp, #4]
	str r0, [sp, #8]
	ldr r2, [sp, #0xc]
	mov r0, r6
	mov r3, #0x30
	bl MainMenu__DrawTextPrompt2
	mov r0, #0
	str r0, [sp, #0x14]
	b _02154830
_021547FA:
	cmp r5, #0xc
	bge _02154830
	mov r0, #0
	mov r1, r4
	str r0, [sp, #0x14]
	str r0, [sp]
	mov r0, r4
	add r1, #0xc0
	mov r2, #0xc
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r1, #0x65
	str r0, [sp, #8]
	lsl r1, r1, #2
	ldr r1, [r6, r1]
	ldr r2, [sp, #0xc]
	ldrh r1, [r1, r7]
	mov r0, r6
	mov r3, #0x30
	bl MainMenu__DrawTextPrompt2
_02154830:
	sub r5, r5, #4
_02154832:
	sub r4, #0x1c
	lsl r0, r4, #0x10
	asr r4, r0, #0x10
	ldr r0, [sp, #0x10]
	sub r7, r7, #2
	sub r0, r0, #1
	str r0, [sp, #0x10]
	bpl _021547BC
	ldr r0, [sp, #0x14]
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}
	thumb_func_end MainMenu__Func_21547A8

	thumb_func_start MainMenu__Func_2154848
MainMenu__Func_2154848: // 0x02154848
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x10
	mov r7, #0
	mov r5, r0
	str r1, [sp, #0xc]
	mov r6, r7
	mov r4, #0x38
_02154856:
	mov r0, #0x65
	lsl r0, r0, #2
	ldr r0, [r5, r0]
	ldrh r3, [r0, r6]
	cmp r3, #6
	bhs _02154896
	mov r1, #0x67
	lsl r1, r1, #2
	ldrh r1, [r5, r1]
	mov r0, #0
	cmp r1, r7
	bne _0215487E
	mov r1, #0x66
	lsl r1, r1, #2
	ldr r1, [r5, r1]
	ldr r2, [sp, #0xc]
	cmp r1, #3
	bhs _02154880
	mov r0, #1
	b _02154880
_0215487E:
	mov r2, r0
_02154880:
	lsl r1, r4, #0x10
	asr r1, r1, #0x10
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r1, r3
	mov r0, r5
	mov r3, #0x30
	bl MainMenu__DrawTextPrompt2
_02154896:
	add r7, r7, #1
	add r6, r6, #2
	add r4, #0x1c
	cmp r7, #4
	blt _02154856
	add sp, #0x10
	pop {r3, r4, r5, r6, r7, pc}
	thumb_func_end MainMenu__Func_2154848

	thumb_func_start MainMenu__State_21548A4
MainMenu__State_21548A4: // 0x021548A4
	push {r4, lr}
	mov r4, r0
	bl MainMenu__Func_2154070
	mov r0, r4
	bl MainMenu__Func_21540A0
	cmp r0, #0
	beq _021549A8
	bl MainMenu__Func_21565B8
	cmp r0, #0
	beq _02154952
	mov r0, r4
	bl MainMenu__Func_21540B4
	cmp r0, #3
	bhi _02154940
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_021548D4: // jump table
	.hword _021548DC - _021548D4 - 2 // case 0
	.hword _021548F8 - _021548D4 - 2 // case 1
	.hword _0215490A - _021548D4 - 2 // case 2
	.hword _02154936 - _021548D4 - 2 // case 3
_021548DC:
	bl MainMenu__Func_21565A4
	cmp r0, #0
	beq _021548EE
	ldr r1, _021549AC // =MainMenu__Func_21562E4
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
_021548EE:
	ldr r1, _021549B0 // =MainMenu__Func_2156174
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
_021548F8:
	mov r0, r4
	mov r1, #0
	add r0, #0xc8
	str r1, [r0]
	ldr r1, _021549B4 // =MainMenu__Func_21560A8
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
_0215490A:
	bl SaveGame__Func_205BF24
	cmp r0, #0
	beq _02154928
	ldr r3, _021549B8 // =0x0217D166
	mov r0, r4
	mov r1, #0
	mov r2, #2
	bl MainMenu__Func_2153FD0
	ldr r1, _021549BC // =MainMenu__Func_21549E4
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
_02154928:
	bl SaveGame__Block1__SetFlags1_0x80000
	ldr r1, _021549C0 // =MainMenu__State_Save
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
_02154936:
	ldr r1, _021549C4 // =MainMenu__Func_2154B54
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
_02154940:
	mov r0, r4
	mov r1, #3
	bl MainMenu__Func_2152C64
	mov r0, r4
	mov r1, #0
	bl MainMenu__SetState
	pop {r4, pc}
_02154952:
	mov r0, r4
	bl MainMenu__Func_21540B4
	cmp r0, #1
	beq _02154962
	cmp r0, #2
	beq _0215498E
	b _02154998
_02154962:
	bl SaveGame__Func_205BF24
	cmp r0, #0
	beq _02154980
	ldr r3, _021549B8 // =0x0217D166
	mov r0, r4
	mov r1, #0
	mov r2, #2
	bl MainMenu__Func_2153FD0
	ldr r1, _021549BC // =MainMenu__Func_21549E4
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
_02154980:
	bl SaveGame__Block1__SetFlags1_0x80000
	ldr r1, _021549C0 // =MainMenu__State_Save
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
_0215498E:
	ldr r1, _021549C4 // =MainMenu__Func_2154B54
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
_02154998:
	mov r0, r4
	mov r1, #3
	bl MainMenu__Func_2152C64
	mov r0, r4
	mov r1, #0
	bl MainMenu__SetState
_021549A8:
	pop {r4, pc}
	nop
_021549AC: .word MainMenu__Func_21562E4
_021549B0: .word MainMenu__Func_2156174
_021549B4: .word MainMenu__Func_21560A8
_021549B8: .word 0x0217D166
_021549BC: .word MainMenu__Func_21549E4
_021549C0: .word MainMenu__State_Save
_021549C4: .word MainMenu__Func_2154B54
	thumb_func_end MainMenu__State_21548A4

	thumb_func_start MainMenu__Func_21549C8
MainMenu__Func_21549C8: // 0x021549C8
	push {r3, lr}
	bl MainMenu__Func_21565B8
	cmp r0, #0
	beq _021549D6
	ldr r0, _021549DC // =0x0217D136
	pop {r3, pc}
_021549D6:
	ldr r0, _021549E0 // =0x0217D14E
	pop {r3, pc}
	nop
_021549DC: .word 0x0217D136
_021549E0: .word 0x0217D14E
	thumb_func_end MainMenu__Func_21549C8

	thumb_func_start MainMenu__Func_21549E4
MainMenu__Func_21549E4: // 0x021549E4
	push {r4, lr}
	mov r4, r0
	bl MainMenu__Func_2154070
	mov r0, r4
	bl MainMenu__Func_21540A0
	cmp r0, #0
	beq _02154A46
	mov r0, r4
	bl MainMenu__Func_21540B4
	cmp r0, #1
	beq _02154A06
	cmp r0, #2
	beq _02154A10
	b _02154A2C
_02154A06:
	ldr r1, _02154A48 // =MainMenu__State_Save
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
_02154A10:
	mov r0, r4
	bl MainMenu__Func_21549C8
	mov r1, #0
	mov r3, r0
	mov r0, r4
	mov r2, r1
	bl MainMenu__Func_2153FD0
	ldr r1, _02154A4C // =MainMenu__State_21548A4
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
_02154A2C:
	mov r0, r4
	bl MainMenu__Func_21549C8
	mov r1, #0
	mov r3, r0
	mov r0, r4
	mov r2, r1
	bl MainMenu__Func_2153FD0
	ldr r1, _02154A4C // =MainMenu__State_21548A4
	mov r0, r4
	bl MainMenu__SetState
_02154A46:
	pop {r4, pc}
	.align 2, 0
_02154A48: .word MainMenu__State_Save
_02154A4C: .word MainMenu__State_21548A4
	thumb_func_end MainMenu__Func_21549E4

	thumb_func_start MainMenu__State_Save
MainMenu__State_Save: // 0x02154A50
	push {r4, lr}
	mov r1, #3
	mov r2, #0x28
	mov r3, #0x10
	mov r4, r0
	bl MainMenu__DrawTextPrompt
	ldr r0, _02154A74 // =0x00002534
	mov r1, #0
	add r0, r4, r0
	mov r2, #0x18
	bl CreateSaveGameWorker
	ldr r1, _02154A78 // =MainMenu__State_WaitSaveComplete
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
	.align 2, 0
_02154A74: .word 0x00002534
_02154A78: .word MainMenu__State_WaitSaveComplete
	thumb_func_end MainMenu__State_Save

	thumb_func_start MainMenu__State_WaitSaveComplete
MainMenu__State_WaitSaveComplete: // 0x02154A7C
	push {r4, lr}
	mov r1, #3
	mov r2, #0x28
	mov r3, #0x10
	mov r4, r0
	bl MainMenu__DrawTextPrompt
	ldr r0, _02154ADC // =0x00002534
	add r0, r4, r0
	bl AwaitSaveGameCompletion
	cmp r0, #0
	beq _02154ADA
	ldr r0, _02154ADC // =0x00002534
	add r0, r4, r0
	bl GetSaveGameSuccess
	cmp r0, #0
	beq _02154AB8
	ldr r0, _02154AE0 // =0x00002464
	mov r1, #0
	str r1, [r4, r0]
	ldr r1, _02154AE4 // =MainMenu__State_2154B00
	mov r0, r4
	bl MainMenu__SetState
	mov r0, r4
	bl MainMenu__Func_2154AF4
	pop {r4, pc}
_02154AB8:
	ldr r1, _02154AE8 // =MainMenu__State_2154B40
	mov r0, r4
	bl MainMenu__SetState
	mov r1, #0xf
	mov r0, r4
	mvn r1, r1
	bl MainMenu__Func_2153024
	mov r0, #0xf
	ldr r1, _02154AEC // =renderCoreGFXControlB+0x00000040
	mvn r0, r0
	strh r0, [r1, #0x18]
	mov r0, #0x18
	ldrsh r1, [r1, r0]
	ldr r0, _02154AF0 // =renderCoreGFXControlA+0x00000040
	strh r1, [r0, #0x18]
_02154ADA:
	pop {r4, pc}
	.align 2, 0
_02154ADC: .word 0x00002534
_02154AE0: .word 0x00002464
_02154AE4: .word MainMenu__State_2154B00
_02154AE8: .word MainMenu__State_2154B40
_02154AEC: .word renderCoreGFXControlB+0x00000040
_02154AF0: .word renderCoreGFXControlA+0x00000040
	thumb_func_end MainMenu__State_WaitSaveComplete

	thumb_func_start MainMenu__Func_2154AF4
MainMenu__Func_2154AF4: // 0x02154AF4
	ldr r3, _02154AFC // =PlaySysMenuNavSfx
	mov r0, #0
	bx r3
	nop
_02154AFC: .word PlaySysMenuNavSfx
	thumb_func_end MainMenu__Func_2154AF4

	thumb_func_start MainMenu__State_2154B00
MainMenu__State_2154B00: // 0x02154B00
	push {r4, lr}
	mov r1, #4
	mov r2, #0x28
	mov r3, #0x10
	mov r4, r0
	bl MainMenu__DrawTextPrompt
	ldr r0, _02154B38 // =0x00002464
	ldr r1, [r4, r0]
	add r1, r1, #1
	str r1, [r4, r0]
	ldr r0, [r4, r0]
	cmp r0, #0x78
	blo _02154B36
	mov r0, r4
	bl MainMenu__Func_21549C8
	mov r1, #0
	mov r3, r0
	mov r0, r4
	mov r2, r1
	bl MainMenu__Func_2153FD0
	ldr r1, _02154B3C // =MainMenu__State_21548A4
	mov r0, r4
	bl MainMenu__SetState
_02154B36:
	pop {r4, pc}
	.align 2, 0
_02154B38: .word 0x00002464
_02154B3C: .word MainMenu__State_21548A4
	thumb_func_end MainMenu__State_2154B00

	thumb_func_start MainMenu__State_2154B40
MainMenu__State_2154B40: // 0x02154B40
	push {r4, lr}
	mov r4, r0
	mov r1, #5
	bl MainMenu__Func_2152C64
	mov r0, r4
	mov r1, #0
	bl MainMenu__SetState
	pop {r4, pc}
	thumb_func_end MainMenu__State_2154B40

	thumb_func_start MainMenu__Func_2154B54
MainMenu__Func_2154B54: // 0x02154B54
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0]
	cmp r0, #0
	bne _02154B64
	mov r4, #6
	lsl r4, r4, #0x18
	b _02154B68
_02154B64:
	mov r4, #0x62
	lsl r4, r4, #0x14
_02154B68:
	ldr r2, _02154C28 // =0x000022D0
	mov r1, #0
	str r1, [r5, r2]
	add r0, r2, #4
	strh r1, [r5, r0]
	add r0, r2, #6
	strh r1, [r5, r0]
	mov r0, r2
	add r0, #8
	strh r1, [r5, r0]
	add r2, #0x10
	mov r0, r5
	str r1, [r5, r2]
	bl MainMenu__Func_215600C
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl MainMenu__SetWindowVisible
	mov r0, r5
	mov r1, #1
	mov r2, #0
	bl MainMenu__SetWindowVisible
	ldr r1, [r5, #0]
	mov r0, #0
	lsl r2, r1, #2
	ldr r1, _02154C2C // =VRAMSystem__GFXControl
	ldr r2, [r1, r2]
	strh r0, [r2]
	ldr r2, [r5, #0]
	lsl r2, r2, #2
	ldr r2, [r1, r2]
	strh r0, [r2, #2]
	ldr r2, [r5, #0]
	lsl r2, r2, #2
	ldr r2, [r1, r2]
	strh r0, [r2, #4]
	ldr r2, [r5, #0]
	lsl r2, r2, #2
	ldr r1, [r1, r2]
	mov r2, #2
	strh r0, [r1, #6]
	mov r1, #3
	lsl r1, r1, #0xc
	add r1, r4, r1
	lsl r2, r2, #0xa
	bl MIi_CpuClearFast
	mov r1, #3
	lsl r1, r1, #0xe
	mov r0, #0
	add r1, r4, r1
	mov r2, #0x20
	bl MIi_CpuClear32
	mov r1, #0xe
	lsl r1, r1, #0xa
	mov r2, #2
	mov r0, #0
	add r1, r4, r1
	lsl r2, r2, #0xa
	bl MIi_CpuClearFast
	mov r1, #1
	lsl r1, r1, #0x10
	mov r0, #0
	add r1, r4, r1
	mov r2, #0x20
	bl MIi_CpuClear32
	ldr r0, _02154C30 // =0x00002390
	add r0, r5, r0
	bl FontAnimator__LoadMappingsFunc
	ldr r0, _02154C30 // =0x00002390
	add r0, r5, r0
	bl FontAnimator__LoadPaletteFunc
	mov r0, r5
	bl MainMenu__GetMessageSequence
	mov r1, r0
	ldr r0, _02154C30 // =0x00002390
	add r0, r5, r0
	bl FontAnimator__SetMsgSequence
	ldr r0, _02154C34 // =0x000022DC
	mov r1, #0
	str r1, [r5, r0]
	ldr r1, _02154C38 // =MainMenu__Func_2154C3C
	mov r0, r5
	bl MainMenu__SetState
	pop {r3, r4, r5, pc}
	.align 2, 0
_02154C28: .word 0x000022D0
_02154C2C: .word VRAMSystem__GFXControl
_02154C30: .word 0x00002390
_02154C34: .word 0x000022DC
_02154C38: .word MainMenu__Func_2154C3C
	thumb_func_end MainMenu__Func_2154B54

	thumb_func_start MainMenu__Func_2154C3C
MainMenu__Func_2154C3C: // 0x02154C3C
	push {r3, r4, r5, lr}
	ldr r1, _02154CE4 // =0x000022DC
	mov r5, r0
	ldr r1, [r5, r1]
	mov r4, #1
	bl MainMenu__Func_2155164
	cmp r0, #0
	bne _02154C50
	mov r4, #0
_02154C50:
	ldr r1, _02154CE4 // =0x000022DC
	mov r0, r5
	ldr r1, [r5, r1]
	bl MainMenu__Func_2155228
	cmp r0, #0
	bne _02154C60
	mov r4, #0
_02154C60:
	ldr r1, _02154CE4 // =0x000022DC
	mov r0, r5
	ldr r1, [r5, r1]
	bl MainMenu__Func_215530C
	cmp r0, #0
	bne _02154C70
	mov r4, #0
_02154C70:
	ldr r1, _02154CE4 // =0x000022DC
	mov r0, r5
	ldr r1, [r5, r1]
	bl MainMenu__Func_21553F8
	cmp r0, #0
	bne _02154C80
	mov r4, #0
_02154C80:
	ldr r1, _02154CE4 // =0x000022DC
	mov r0, r5
	ldr r1, [r5, r1]
	bl MainMenu__Func_2155534
	cmp r0, #0
	bne _02154C90
	mov r4, #0
_02154C90:
	ldr r1, _02154CE4 // =0x000022DC
	mov r0, r5
	ldr r1, [r5, r1]
	bl MainMenu__Func_21555F4
	cmp r0, #0
	bne _02154CA0
	mov r4, #0
_02154CA0:
	ldr r0, _02154CE4 // =0x000022DC
	ldr r1, [r5, r0]
	add r1, r1, #1
	str r1, [r5, r0]
	add r0, #0xb4
	add r0, r5, r0
	mov r1, #1
	bl FontAnimator__LoadCharacters
	cmp r4, #0
	beq _02154CE2
	mov r0, r5
	mov r1, #1
	bl MainMenu__Func_215600C
	ldr r0, _02154CE8 // =0x00002390
	mov r1, #0
	add r0, r5, r0
	bl FontAnimator__LoadCharacters
	ldr r0, _02154CE8 // =0x00002390
	add r0, r5, r0
	bl FontAnimator__Draw
	ldr r0, _02154CE4 // =0x000022DC
	mov r1, #0
	str r1, [r5, r0]
	add r0, r0, #4
	str r1, [r5, r0]
	ldr r1, _02154CEC // =MainMenu__Func_2154CF0
	mov r0, r5
	bl MainMenu__SetState
_02154CE2:
	pop {r3, r4, r5, pc}
	.align 2, 0
_02154CE4: .word 0x000022DC
_02154CE8: .word 0x00002390
_02154CEC: .word MainMenu__Func_2154CF0
	thumb_func_end MainMenu__Func_2154C3C

	thumb_func_start MainMenu__Func_2154CF0
MainMenu__Func_2154CF0: // 0x02154CF0
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #8
	ldr r1, _02154F84 // =padInput
	mov r4, #0
	ldrh r2, [r1, #4]
	mov r1, #1
	lsl r1, r1, #8
	mov r5, r0
	str r4, [sp, #4]
	tst r1, r2
	bne _02154D0E
	bl MainMenu__Func_2155F7C
	cmp r0, #0
	beq _02154D22
_02154D0E:
	ldr r0, _02154F88 // =0x000022D0
	ldr r1, [r5, r0]
	cmp r1, #2
	bge _02154D1A
	add r1, r1, #1
	b _02154D1C
_02154D1A:
	mov r1, #0
_02154D1C:
	str r1, [r5, r0]
	mov r4, #1
	b _02154D4A
_02154D22:
	ldr r0, _02154F84 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #2
	lsl r0, r0, #8
	tst r0, r1
	bne _02154D38
	mov r0, r5
	bl MainMenu__Func_2155F3C
	cmp r0, #0
	beq _02154D4A
_02154D38:
	ldr r0, _02154F88 // =0x000022D0
	ldr r1, [r5, r0]
	cmp r1, #0
	ble _02154D44
	sub r1, r1, #1
	b _02154D46
_02154D44:
	mov r1, #2
_02154D46:
	str r1, [r5, r0]
	mov r4, #1
_02154D4A:
	ldr r0, _02154F84 // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x20
	tst r0, r1
	beq _02154D58
	mov r3, #1
	b _02154D5A
_02154D58:
	mov r3, #0
_02154D5A:
	mov r0, #0x40
	tst r0, r1
	beq _02154D64
	mov r2, #1
	b _02154D66
_02154D64:
	mov r2, #0
_02154D66:
	mov r0, #0x10
	tst r0, r1
	beq _02154D70
	mov r0, #1
	b _02154D72
_02154D70:
	mov r0, #0
_02154D72:
	mov r6, #0x80
	tst r1, r6
	beq _02154D7C
	mov r1, #1
	b _02154D7E
_02154D7C:
	mov r1, #0
_02154D7E:
	ldr r6, _02154F88 // =0x000022D0
	ldr r7, [r5, r6]
	cmp r7, #0
	beq _02154D90
	cmp r7, #1
	beq _02154E04
	cmp r7, #2
	beq _02154E70
	b _02154EDA
_02154D90:
	add r6, r6, #4
	ldrh r6, [r5, r6]
	cmp r3, #0
	beq _02154DAE
	cmp r6, #0
	bne _02154DA0
	mov r6, #3
	b _02154DAE
_02154DA0:
	cmp r6, #4
	bne _02154DA8
	mov r6, #8
	b _02154DAE
_02154DA8:
	sub r3, r6, #1
	lsl r3, r3, #0x10
	lsr r6, r3, #0x10
_02154DAE:
	cmp r0, #0
	beq _02154DC8
	cmp r6, #3
	bne _02154DBA
	mov r6, #0
	b _02154DC8
_02154DBA:
	cmp r6, #8
	bne _02154DC2
	mov r6, #4
	b _02154DC8
_02154DC2:
	add r0, r6, #1
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
_02154DC8:
	cmp r2, #0
	bne _02154DD0
	cmp r1, #0
	beq _02154DEA
_02154DD0:
	cmp r6, #4
	bhs _02154DDC
	add r0, r6, #4
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
	b _02154DEA
_02154DDC:
	cmp r6, #8
	bhs _02154DE8
	sub r0, r6, #4
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
	b _02154DEA
_02154DE8:
	mov r6, #3
_02154DEA:
	mov r0, r5
	bl MainMenu__Func_2155E50
	cmp r0, #9
	bhs _02154DF6
	mov r6, r0
_02154DF6:
	ldr r0, _02154F8C // =0x000022D4
	ldrh r1, [r5, r0]
	cmp r6, r1
	beq _02154EDA
	strh r6, [r5, r0]
	mov r4, #1
	b _02154EDA
_02154E04:
	add r6, r6, #6
	ldrh r6, [r5, r6]
	cmp r3, #0
	beq _02154E22
	cmp r6, #0
	beq _02154E14
	cmp r6, #7
	bne _02154E1C
_02154E14:
	add r3, r6, #6
	lsl r3, r3, #0x10
	lsr r6, r3, #0x10
	b _02154E22
_02154E1C:
	sub r3, r6, #1
	lsl r3, r3, #0x10
	lsr r6, r3, #0x10
_02154E22:
	cmp r0, #0
	beq _02154E3C
	cmp r6, #6
	beq _02154E2E
	cmp r6, #0xd
	bne _02154E36
_02154E2E:
	sub r0, r6, #6
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
	b _02154E3C
_02154E36:
	add r0, r6, #1
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
_02154E3C:
	cmp r2, #0
	bne _02154E44
	cmp r1, #0
	beq _02154E56
_02154E44:
	cmp r6, #7
	bhs _02154E50
	add r0, r6, #7
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
	b _02154E56
_02154E50:
	sub r0, r6, #7
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
_02154E56:
	mov r0, r5
	bl MainMenu__Func_2155ECC
	cmp r0, #0xe
	bhs _02154E62
	mov r6, r0
_02154E62:
	ldr r0, _02154F90 // =0x000022D6
	ldrh r1, [r5, r0]
	cmp r6, r1
	beq _02154EDA
	strh r6, [r5, r0]
	mov r4, #1
	b _02154EDA
_02154E70:
	add r6, #8
	ldrh r6, [r5, r6]
	cmp r3, #0
	beq _02154E8E
	cmp r6, #0
	beq _02154E80
	cmp r6, #7
	bne _02154E88
_02154E80:
	add r3, r6, #6
	lsl r3, r3, #0x10
	lsr r6, r3, #0x10
	b _02154E8E
_02154E88:
	sub r3, r6, #1
	lsl r3, r3, #0x10
	lsr r6, r3, #0x10
_02154E8E:
	cmp r0, #0
	beq _02154EA8
	cmp r6, #6
	beq _02154E9A
	cmp r6, #0xd
	bne _02154EA2
_02154E9A:
	sub r0, r6, #6
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
	b _02154EA8
_02154EA2:
	add r0, r6, #1
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
_02154EA8:
	cmp r2, #0
	bne _02154EB0
	cmp r1, #0
	beq _02154EC2
_02154EB0:
	cmp r6, #7
	bhs _02154EBC
	add r0, r6, #7
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
	b _02154EC2
_02154EBC:
	sub r0, r6, #7
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
_02154EC2:
	mov r0, r5
	bl MainMenu__Func_2155ECC
	cmp r0, #0xe
	bhs _02154ECE
	mov r6, r0
_02154ECE:
	ldr r0, _02154F94 // =0x000022D8
	ldrh r1, [r5, r0]
	cmp r6, r1
	beq _02154EDA
	strh r6, [r5, r0]
	mov r4, #1
_02154EDA:
	ldr r0, _02154F84 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #2
	tst r0, r1
	bne _02154EEE
	mov r0, r5
	bl MainMenu__Func_2156074
	cmp r0, #0
	beq _02154EF2
_02154EEE:
	mov r0, #1
	str r0, [sp, #4]
_02154EF2:
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl MainMenu__Func_2155BAC
	mov r0, #1
	str r0, [sp]
	ldr r1, _02154F88 // =0x000022D0
	mov r0, r5
	ldr r1, [r5, r1]
	mov r2, #0x20
	mov r3, #0x28
	bl MainMenu__Func_2155BF0
	bl MainMenu__GetRingCount
	mov r3, r0
	mov r0, r5
	mov r1, #0xa0
	mov r2, #0
	bl MainMenu__DrawRingCount
	ldr r1, _02154F88 // =0x000022D0
	ldr r0, [r5, r1]
	cmp r0, #0
	beq _02154F30
	cmp r0, #1
	beq _02154F3E
	cmp r0, #2
	beq _02154F4C
	b _02154F58
_02154F30:
	add r1, r1, #4
	ldrh r1, [r5, r1]
	mov r0, r5
	mov r2, r4
	bl MainMenu__Func_215583C
	b _02154F58
_02154F3E:
	add r1, r1, #6
	ldrh r1, [r5, r1]
	mov r0, r5
	mov r2, r4
	bl MainMenu__Func_215598C
	b _02154F58
_02154F4C:
	add r1, #8
	ldrh r1, [r5, r1]
	mov r0, r5
	mov r2, r4
	bl MainMenu__Func_2155A9C
_02154F58:
	mov r0, r5
	mov r1, #0x2a
	mov r2, #0xa0
	bl MainMenu__DrawTextBorder2
	cmp r4, #0
	beq _02154FA8
	mov r0, r5
	bl MainMenu__GetMessageSequence
	mov r1, r0
	ldr r0, _02154F98 // =0x00002390
	add r0, r5, r0
	bl FontAnimator__SetMsgSequence
	ldr r0, _02154F98 // =0x00002390
	mov r1, #0
	add r0, r5, r0
	bl FontAnimator__LoadCharacters
	ldr r0, _02154F98 // =0x00002390
	b _02154F9C
	.align 2, 0
_02154F84: .word padInput
_02154F88: .word 0x000022D0
_02154F8C: .word 0x000022D4
_02154F90: .word 0x000022D6
_02154F94: .word 0x000022D8
_02154F98: .word 0x00002390
_02154F9C:
	add r0, r5, r0
	bl FontAnimator__Draw
	mov r0, #2
	bl PlaySysMenuNavSfx
_02154FA8:
	mov r0, r5
	bl MainMenu__Func_2156048
	mov r3, r0
	mov r0, r5
	mov r1, #0x10
	mov r2, #0xb0
	bl MainMenu__Func_2155804
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _02154FE6
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl MainMenu__SetWindowVisible
	ldr r0, _02154FF4 // =0x000022DC
	mov r1, #0
	str r1, [r5, r0]
	add r0, r0, #4
	str r1, [r5, r0]
	ldr r1, _02154FF8 // =MainMenu__Func_2154FFC
	mov r0, r5
	bl MainMenu__SetState
	mov r0, #1
	bl PlaySysMenuNavSfx
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
_02154FE6:
	mov r0, r5
	mov r1, #0
	mov r2, #1
	bl MainMenu__SetWindowVisible
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02154FF4: .word 0x000022DC
_02154FF8: .word MainMenu__Func_2154FFC
	thumb_func_end MainMenu__Func_2154CF0

	thumb_func_start MainMenu__Func_2154FFC
MainMenu__Func_2154FFC: // 0x02154FFC
	push {r3, r4, r5, lr}
	ldr r1, _02155080 // =0x000022DC
	mov r5, r0
	ldr r1, [r5, r1]
	mov r4, #1
	bl MainMenu__Func_21551C8
	cmp r0, #0
	bne _02155010
	mov r4, #0
_02155010:
	ldr r1, _02155080 // =0x000022DC
	mov r0, r5
	ldr r1, [r5, r1]
	bl MainMenu__Func_215529C
	cmp r0, #0
	bne _02155020
	mov r4, #0
_02155020:
	ldr r1, _02155080 // =0x000022DC
	mov r0, r5
	ldr r1, [r5, r1]
	bl MainMenu__Func_2155380
	cmp r0, #0
	bne _02155030
	mov r4, #0
_02155030:
	ldr r1, _02155080 // =0x000022DC
	mov r0, r5
	ldr r1, [r5, r1]
	bl MainMenu__Func_215549C
	cmp r0, #0
	bne _02155040
	mov r4, #0
_02155040:
	ldr r1, _02155080 // =0x000022DC
	mov r0, r5
	ldr r1, [r5, r1]
	bl MainMenu__Func_2155594
	cmp r0, #0
	bne _02155050
	mov r4, #0
_02155050:
	ldr r1, _02155080 // =0x000022DC
	mov r0, r5
	ldr r1, [r5, r1]
	bl MainMenu__Func_2155658
	cmp r0, #0
	bne _02155060
	mov r4, #0
_02155060:
	ldr r0, _02155080 // =0x000022DC
	ldr r1, [r5, r0]
	add r1, r1, #1
	str r1, [r5, r0]
	cmp r4, #0
	beq _0215507C
	mov r1, #0
	str r1, [r5, r0]
	add r0, r0, #4
	str r1, [r5, r0]
	ldr r1, _02155084 // =MainMenu__Func_2155088
	mov r0, r5
	bl MainMenu__SetState
_0215507C:
	pop {r3, r4, r5, pc}
	nop
_02155080: .word 0x000022DC
_02155084: .word MainMenu__Func_2155088
	thumb_func_end MainMenu__Func_2154FFC

	thumb_func_start MainMenu__Func_2155088
MainMenu__Func_2155088: // 0x02155088
	push {r4, lr}
	mov r1, #0
	mov r4, r0
	bl MainMenu__Func_215600C
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl MainMenu__SetWindowVisible
	mov r0, r4
	mov r1, #1
	mov r2, #0
	bl MainMenu__SetWindowVisible
	mov r0, r4
	bl MainMenu__Func_21549C8
	mov r3, r0
	mov r0, r4
	mov r1, #1
	mov r2, #0
	bl MainMenu__Func_2153FD0
	ldr r1, _021550C4 // =MainMenu__State_21548A4
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
	nop
_021550C4: .word MainMenu__State_21548A4
	thumb_func_end MainMenu__Func_2155088

	thumb_func_start MainMenu__GetMessageSequence
MainMenu__GetMessageSequence: // 0x021550C8
	push {r4, lr}
	mov r4, r0
	ldr r0, _02155154 // =0x000022D0
	ldr r1, [r4, r0]
	cmp r1, #0
	beq _021550DE
	cmp r1, #1
	beq _021550F4
	cmp r1, #2
	beq _02155132
	b _0215514E
_021550DE:
	add r0, r0, #4
	ldrh r0, [r4, r0]
	bl MainMenu__HasMaterial
	cmp r0, #0
	beq _021550F0
	ldr r0, _02155158 // =0x000022D4
	ldrh r0, [r4, r0]
	pop {r4, pc}
_021550F0:
	mov r0, #0x25
	pop {r4, pc}
_021550F4:
	add r0, r0, #6
	ldrh r0, [r4, r0]
	cmp r0, #7
	bhs _02155114
	bl MainMenu__HasChaosEmerald
	cmp r0, #0
	beq _02155110
	ldr r0, _0215515C // =0x000022D6
	ldrh r0, [r4, r0]
	add r0, #9
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	pop {r4, pc}
_02155110:
	mov r0, #0x25
	pop {r4, pc}
_02155114:
	sub r0, r0, #7
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	bl MainMenu__HasSolEmerald
	cmp r0, #0
	beq _0215512E
	ldr r0, _0215515C // =0x000022D6
	ldrh r0, [r4, r0]
	add r0, #9
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	pop {r4, pc}
_0215512E:
	mov r0, #0x25
	pop {r4, pc}
_02155132:
	add r0, #8
	ldrh r0, [r4, r0]
	bl MainMenu__HasMedal
	cmp r0, #0
	beq _0215514A
	ldr r0, _02155160 // =0x000022D8
	ldrh r0, [r4, r0]
	add r0, #0x17
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	pop {r4, pc}
_0215514A:
	mov r0, #0x25
	pop {r4, pc}
_0215514E:
	mov r0, #0x25
	pop {r4, pc}
	nop
_02155154: .word 0x000022D0
_02155158: .word 0x000022D4
_0215515C: .word 0x000022D6
_02155160: .word 0x000022D8
	thumb_func_end MainMenu__GetMessageSequence

	thumb_func_start MainMenu__Func_2155164
MainMenu__Func_2155164: // 0x02155164
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r6, r0
	cmp r1, #9
	bhs _02155174
	add sp, #4
	mov r0, #0
	pop {r3, r4, r5, r6, pc}
_02155174:
	mov r5, r1
	sub r5, #9
	cmp r5, #0x10
	blo _0215518A
	mov r1, #0
	mov r2, r1
	bl MainMenu__Func_2155BAC
	add sp, #4
	mov r0, #1
	pop {r3, r4, r5, r6, pc}
_0215518A:
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0xff
	mvn r0, r0
	mov r1, #0
	mov r2, #0x10
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0
	mov r1, r0
	mov r2, #0x10
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r2, r0, #0x10
	mov r0, r6
	mov r1, r4
	bl MainMenu__Func_2155BAC
	mov r0, #0
	add sp, #4
	pop {r3, r4, r5, r6, pc}
	.align 2, 0
	thumb_func_end MainMenu__Func_2155164

	thumb_func_start MainMenu__Func_21551C8
MainMenu__Func_21551C8: // 0x021551C8
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r6, r0
	cmp r1, #1
	bhs _021551E0
	mov r1, #0
	mov r2, r1
	bl MainMenu__Func_2155BAC
	add sp, #4
	mov r0, #0
	pop {r3, r4, r5, r6, pc}
_021551E0:
	sub r5, r1, #1
	cmp r5, #0x10
	blo _021551EC
	add sp, #4
	mov r0, #1
	pop {r3, r4, r5, r6, pc}
_021551EC:
	mov r0, #2
	lsl r0, r0, #0xc
	mov r1, #0xff
	str r0, [sp]
	mov r0, #0
	mvn r1, r1
	mov r2, #0x10
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0
	mov r1, r0
	mov r2, #0x10
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r2, r0, #0x10
	mov r0, r6
	mov r1, r4
	bl MainMenu__Func_2155BAC
	mov r0, #0
	add sp, #4
	pop {r3, r4, r5, r6, pc}
	thumb_func_end MainMenu__Func_21551C8

	thumb_func_start MainMenu__Func_2155228
MainMenu__Func_2155228: // 0x02155228
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r4, r0
	cmp r1, #9
	bhs _02155238
	add sp, #4
	mov r0, #0
	pop {r3, r4, r5, r6, pc}
_02155238:
	mov r5, r1
	sub r5, #9
	cmp r5, #0x10
	blo _02155256
	bl MainMenu__GetRingCount
	mov r3, r0
	mov r0, r4
	mov r1, #0xa0
	mov r2, #0
	bl MainMenu__DrawRingCount
	add sp, #4
	mov r0, #1
	pop {r3, r4, r5, r6, pc}
_02155256:
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x12
	lsl r0, r0, #4
	mov r1, #0xa0
	mov r2, #0x10
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r6, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0
	mov r1, r0
	mov r2, #0x10
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r5, r0, #0x10
	bl MainMenu__GetRingCount
	mov r3, r0
	mov r0, r4
	mov r1, r6
	mov r2, r5
	bl MainMenu__DrawRingCount
	mov r0, #0
	add sp, #4
	pop {r3, r4, r5, r6, pc}
	.align 2, 0
	thumb_func_end MainMenu__Func_2155228

	thumb_func_start MainMenu__Func_215529C
MainMenu__Func_215529C: // 0x0215529C
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r4, r0
	cmp r1, #1
	bhs _021552BC
	bl MainMenu__GetRingCount
	mov r3, r0
	mov r0, r4
	mov r1, #0xa0
	mov r2, #0
	bl MainMenu__DrawRingCount
	add sp, #4
	mov r0, #0
	pop {r3, r4, r5, r6, pc}
_021552BC:
	sub r5, r1, #1
	cmp r5, #0x10
	blo _021552C8
	add sp, #4
	mov r0, #1
	pop {r3, r4, r5, r6, pc}
_021552C8:
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0xa0
	mov r1, r0
	add r1, #0x80
	mov r2, #0x10
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r6, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0
	mov r1, r0
	mov r2, #0x10
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r5, r0, #0x10
	bl MainMenu__GetRingCount
	mov r3, r0
	mov r0, r4
	mov r1, r6
	mov r2, r5
	bl MainMenu__DrawRingCount
	mov r0, #0
	add sp, #4
	pop {r3, r4, r5, r6, pc}
	thumb_func_end MainMenu__Func_215529C

	thumb_func_start MainMenu__Func_215530C
MainMenu__Func_215530C: // 0x0215530C
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r5, r0
	cmp r1, #1
	bhs _0215531C
	add sp, #4
	mov r0, #0
	pop {r3, r4, r5, r6, pc}
_0215531C:
	sub r4, r1, #1
	cmp r4, #0x10
	blo _02155338
	mov r1, #0
	str r1, [sp]
	ldr r1, _0215537C // =0x000022D0
	mov r2, #0x20
	ldr r1, [r5, r1]
	mov r3, #0x28
	bl MainMenu__Func_2155BF0
	add sp, #4
	mov r0, #1
	pop {r3, r4, r5, r6, pc}
_02155338:
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x20
	mov r1, r0
	mov r2, #0x10
	mov r3, r4
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r6, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x3f
	mvn r0, r0
	mov r1, #0x28
	mov r2, #0x10
	mov r3, r4
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r3, r0, #0x10
	mov r0, #0
	str r0, [sp]
	ldr r1, _0215537C // =0x000022D0
	mov r0, r5
	ldr r1, [r5, r1]
	mov r2, r6
	bl MainMenu__Func_2155BF0
	mov r0, #0
	add sp, #4
	pop {r3, r4, r5, r6, pc}
	.align 2, 0
_0215537C: .word 0x000022D0
	thumb_func_end MainMenu__Func_215530C

	thumb_func_start MainMenu__Func_2155380
MainMenu__Func_2155380: // 0x02155380
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r5, r0
	cmp r1, #9
	bhs _021553A0
	mov r1, #0
	str r1, [sp]
	ldr r1, _021553F4 // =0x000022D0
	mov r2, #0x20
	ldr r1, [r5, r1]
	mov r3, #0x28
	bl MainMenu__Func_2155BF0
	add sp, #4
	mov r0, #0
	pop {r3, r4, r5, r6, pc}
_021553A0:
	mov r4, r1
	sub r4, #9
	cmp r4, #0x10
	blo _021553AE
	add sp, #4
	mov r0, #1
	pop {r3, r4, r5, r6, pc}
_021553AE:
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x20
	mov r1, r0
	mov r2, #0x10
	mov r3, r4
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r6, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x28
	mov r1, r0
	sub r1, #0x68
	mov r2, #0x10
	mov r3, r4
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r3, r0, #0x10
	mov r0, #0
	str r0, [sp]
	ldr r1, _021553F4 // =0x000022D0
	mov r0, r5
	ldr r1, [r5, r1]
	mov r2, r6
	bl MainMenu__Func_2155BF0
	mov r0, #0
	add sp, #4
	pop {r3, r4, r5, r6, pc}
	nop
_021553F4: .word 0x000022D0
	thumb_func_end MainMenu__Func_2155380

	thumb_func_start MainMenu__Func_21553F8
MainMenu__Func_21553F8: // 0x021553F8
	push {r3, r4, lr}
	sub sp, #4
	mov r4, r0
	cmp r1, #0xf
	bhs _02155408
	add sp, #4
	mov r0, #0
	pop {r3, r4, pc}
_02155408:
	ldr r1, _02155494 // =0x000022E0
	ldr r2, [r4, r1]
	cmp r2, #0
	bne _0215543E
	add r1, #0x4c
	add r0, r4, r1
	bl FontWindowAnimator__Func_20599C4
	ldr r0, _02155498 // =0x0000232C
	mov r3, #0
	add r0, r4, r0
	mov r1, #1
	mov r2, #7
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	ldr r0, _02155498 // =0x0000232C
	add r0, r4, r0
	bl FontWindowAnimator__StartAnimating
	mov r0, #4
	bl PlaySysSfx
	ldr r0, _02155494 // =0x000022E0
	mov r1, #1
	str r1, [r4, r0]
	b _0215547C
_0215543E:
	cmp r2, #1
	bne _02155452
	mov r1, #1
	mov r2, r1
	bl MainMenu__SetWindowVisible
	ldr r0, _02155494 // =0x000022E0
	mov r1, #2
	str r1, [r4, r0]
	b _0215547C
_02155452:
	cmp r2, #2
	bne _02155476
	add r1, #0x4c
	add r0, r4, r1
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	beq _0215547C
	ldr r0, _02155498 // =0x0000232C
	add r0, r4, r0
	bl FontWindowAnimator__SetWindowOpen
	ldr r0, _02155494 // =0x000022E0
	mov r1, #3
	str r1, [r4, r0]
	add sp, #4
	mov r0, #0
	pop {r3, r4, pc}
_02155476:
	add sp, #4
	mov r0, #1
	pop {r3, r4, pc}
_0215547C:
	ldr r0, _02155498 // =0x0000232C
	add r0, r4, r0
	bl FontWindowAnimator__ProcessWindowAnim
	ldr r0, _02155498 // =0x0000232C
	add r0, r4, r0
	bl FontWindowAnimator__Draw
	mov r0, #0
	add sp, #4
	pop {r3, r4, pc}
	nop
_02155494: .word 0x000022E0
_02155498: .word 0x0000232C
	thumb_func_end MainMenu__Func_21553F8

	thumb_func_start MainMenu__Func_215549C
MainMenu__Func_215549C: // 0x0215549C
	push {r3, r4, lr}
	sub sp, #4
	mov r4, r0
	cmp r1, #1
	bhs _021554AC
	add sp, #4
	mov r0, #0
	pop {r3, r4, pc}
_021554AC:
	ldr r0, _0215552C // =0x000022E0
	ldr r1, [r4, r0]
	cmp r1, #0
	bne _021554D4
	add r0, #0x4c
	mov r3, #0
	add r0, r4, r0
	mov r1, #4
	mov r2, #7
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	ldr r0, _02155530 // =0x0000232C
	add r0, r4, r0
	bl FontWindowAnimator__StartAnimating
	ldr r0, _0215552C // =0x000022E0
	mov r1, #1
	str r1, [r4, r0]
	b _02155514
_021554D4:
	cmp r1, #1
	bne _021554F6
	add r0, #0x4c
	add r0, r4, r0
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	beq _02155514
	mov r0, r4
	mov r1, #1
	mov r2, #0
	bl MainMenu__SetWindowVisible
	ldr r0, _0215552C // =0x000022E0
	mov r1, #2
	str r1, [r4, r0]
	b _02155514
_021554F6:
	cmp r1, #2
	bne _0215550E
	add r0, #0x4c
	add r0, r4, r0
	bl FontWindowAnimator__SetWindowOpen
	ldr r0, _0215552C // =0x000022E0
	mov r1, #3
	str r1, [r4, r0]
	add sp, #4
	mov r0, #1
	pop {r3, r4, pc}
_0215550E:
	add sp, #4
	mov r0, #1
	pop {r3, r4, pc}
_02155514:
	ldr r0, _02155530 // =0x0000232C
	add r0, r4, r0
	bl FontWindowAnimator__ProcessWindowAnim
	ldr r0, _02155530 // =0x0000232C
	add r0, r4, r0
	bl FontWindowAnimator__Draw
	mov r0, #0
	add sp, #4
	pop {r3, r4, pc}
	nop
_0215552C: .word 0x000022E0
_02155530: .word 0x0000232C
	thumb_func_end MainMenu__Func_215549C

	thumb_func_start MainMenu__Func_2155534
MainMenu__Func_2155534: // 0x02155534
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r6, r0
	cmp r1, #1
	bhs _02155544
	add sp, #4
	mov r0, #0
	pop {r3, r4, r5, r6, pc}
_02155544:
	sub r5, r1, #1
	cmp r5, #0x10
	blo _02155558
	mov r1, #0x2a
	mov r2, #0xa0
	bl MainMenu__DrawTextBorder2
	add sp, #4
	mov r0, #1
	pop {r3, r4, r5, r6, pc}
_02155558:
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x2a
	mov r1, r0
	mov r2, #0x10
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0xc0
	mov r1, #0xa0
	mov r2, #0x10
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r2, r0, #0x10
	mov r0, r6
	mov r1, r4
	bl MainMenu__DrawTextBorder2
	mov r0, #0
	add sp, #4
	pop {r3, r4, r5, r6, pc}
	.align 2, 0
	thumb_func_end MainMenu__Func_2155534

	thumb_func_start MainMenu__Func_2155594
MainMenu__Func_2155594: // 0x02155594
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r6, r0
	cmp r1, #9
	bhs _021555AC
	mov r1, #0x2a
	mov r2, #0xa0
	bl MainMenu__DrawTextBorder2
	add sp, #4
	mov r0, #0
	pop {r3, r4, r5, r6, pc}
_021555AC:
	mov r5, r1
	sub r5, #9
	cmp r5, #0x10
	blo _021555BA
	add sp, #4
	mov r0, #1
	pop {r3, r4, r5, r6, pc}
_021555BA:
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x2a
	mov r1, r0
	mov r2, #0x10
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0xa0
	mov r1, #0xc0
	mov r2, #0x10
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r2, r0, #0x10
	mov r0, r6
	mov r1, r4
	bl MainMenu__DrawTextBorder2
	mov r0, #0
	add sp, #4
	pop {r3, r4, r5, r6, pc}
	thumb_func_end MainMenu__Func_2155594

	thumb_func_start MainMenu__Func_21555F4
MainMenu__Func_21555F4: // 0x021555F4
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r6, r0
	cmp r1, #9
	bhs _02155604
	add sp, #4
	mov r0, #0
	pop {r3, r4, r5, r6, pc}
_02155604:
	mov r5, r1
	sub r5, #9
	cmp r5, #0x10
	blo _0215561C
	mov r1, #0x10
	mov r2, #0xb0
	mov r3, #0
	bl MainMenu__Func_2155804
	add sp, #4
	mov r0, #1
	pop {r3, r4, r5, r6, pc}
_0215561C:
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x10
	mov r1, r0
	mov r2, r0
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0xd0
	mov r1, #0xb0
	mov r2, #0x10
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r2, r0, #0x10
	mov r0, r6
	mov r1, r4
	mov r3, #0
	bl MainMenu__Func_2155804
	mov r0, #0
	add sp, #4
	pop {r3, r4, r5, r6, pc}
	thumb_func_end MainMenu__Func_21555F4

	thumb_func_start MainMenu__Func_2155658
MainMenu__Func_2155658: // 0x02155658
	push {r3, r4, r5, r6, lr}
	sub sp, #4
	mov r6, r0
	cmp r1, #1
	bhs _02155672
	mov r1, #0x10
	mov r2, #0xb0
	mov r3, #0
	bl MainMenu__Func_2155804
	add sp, #4
	mov r0, #0
	pop {r3, r4, r5, r6, pc}
_02155672:
	sub r5, r1, #1
	cmp r5, #0x10
	blo _0215567E
	add sp, #4
	mov r0, #1
	pop {r3, r4, r5, r6, pc}
_0215567E:
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x10
	mov r1, r0
	mov r2, r0
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r4, r0, #0x10
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0xb0
	mov r1, #0xd0
	mov r2, #0x10
	mov r3, r5
	bl Unknown2051334__Func_2051534
	lsl r0, r0, #0x10
	asr r2, r0, #0x10
	mov r0, r6
	mov r1, r4
	mov r3, #0
	bl MainMenu__Func_2155804
	mov r0, #0
	add sp, #4
	pop {r3, r4, r5, r6, pc}
	.align 2, 0
	thumb_func_end MainMenu__Func_2155658

	thumb_func_start MainMenu__DrawTextPrompt
MainMenu__DrawTextPrompt: // 0x021556BC
	push {r4, lr}
	mov r4, #0xaf
	mvn r4, r4
	cmp r2, r4
	ble _021556F6
	add r4, #0x90
	cmp r3, r4
	ble _021556F6
	mov r4, #1
	lsl r4, r4, #8
	cmp r2, r4
	bge _021556F6
	cmp r3, #0xc0
	bge _021556F6
	add r4, #0xf8
	add r4, r0, r4
	mov r0, #0x64
	mul r0, r1
	add r4, r4, r0
	strh r2, [r4, #8]
	mov r1, #0
	mov r0, r4
	mov r2, r1
	strh r3, [r4, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
_021556F6:
	pop {r4, pc}
	thumb_func_end MainMenu__DrawTextPrompt

	thumb_func_start MainMenu__DrawTextPrompt2
MainMenu__DrawTextPrompt2: // 0x021556F8
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r2
	mov r2, #0x45
	lsl r2, r2, #4
	str r0, [sp]
	add r2, r0, r2
	mov r0, #0x64
	mul r0, r1
	add r4, r2, r0
	ldr r0, _021557C0 // =0x0217D12A
	lsl r1, r1, #1
	ldrh r0, [r0, r1]
	mov r7, r3
	ldr r6, [sp, #0x18]
	add r0, r5, r0
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	ldr r0, [sp, #0x1c]
	cmp r0, #0
	bne _02155726
	ldrh r0, [r4, #0xc]
	cmp r1, r0
	beq _02155746
_02155726:
	mov r0, r4
	bl AnimatorSprite__SetAnimation
	cmp r5, #2
	ldr r1, [r4, #0x3c]
	bne _0215573A
	mov r0, #4
	orr r0, r1
	str r0, [r4, #0x3c]
	b _02155740
_0215573A:
	mov r0, #4
	bic r1, r0
	str r1, [r4, #0x3c]
_02155740:
	mov r0, r4
	add r0, #0x50
	strh r5, [r0]
_02155746:
	mov r0, #0xa2
	mvn r0, r0
	cmp r7, r0
	ble _021557BC
	add r0, #0x88
	cmp r6, r0
	ble _021557BC
	ldr r0, _021557C4 // =0x00000103
	cmp r7, r0
	bge _021557BC
	cmp r6, #0xc3
	bge _021557BC
	strh r7, [r4, #8]
	strh r6, [r4, #0xa]
	cmp r5, #0
	beq _0215578E
	ldr r0, [sp, #0x20]
	cmp r0, #0
	beq _0215577E
	mov r0, #8
	ldrsh r0, [r4, r0]
	sub r0, r0, #1
	strh r0, [r4, #8]
	mov r0, #0xa
	ldrsh r0, [r4, r0]
	sub r0, r0, #1
	strh r0, [r4, #0xa]
	b _0215578E
_0215577E:
	mov r0, #8
	ldrsh r0, [r4, r0]
	sub r0, r0, #3
	strh r0, [r4, #8]
	mov r0, #0xa
	ldrsh r0, [r4, r0]
	sub r0, r0, #3
	strh r0, [r4, #0xa]
_0215578E:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	cmp r5, #0
	beq _021557BC
	ldr r1, _021557C8 // =0x000006A8
	ldr r0, [sp]
	add r4, r0, r1
	mov r1, #0
	strh r7, [r4, #8]
	mov r0, r4
	mov r2, r1
	strh r6, [r4, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
_021557BC:
	pop {r3, r4, r5, r6, r7, pc}
	nop
_021557C0: .word 0x0217D12A
_021557C4: .word 0x00000103
_021557C8: .word 0x000006A8
	thumb_func_end MainMenu__DrawTextPrompt2

	thumb_func_start MainMenu__DrawCursor
MainMenu__DrawCursor: // 0x021557CC
	push {r3, r4, r5, lr}
	mov r5, r1
	ldr r1, _02155800 // =0x0000070C
	add r4, r0, r1
	cmp r2, #0
	beq _021557E0
	mov r0, r4
	mov r1, #0
	bl AnimatorSprite__SetAnimation
_021557E0:
	mov r0, #0x30
	strh r0, [r4, #8]
	mov r0, #0x1c
	mul r0, r5
	add r0, #0x41
	mov r1, #0
	strh r0, [r4, #0xa]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	pop {r3, r4, r5, pc}
	nop
_02155800: .word 0x0000070C
	thumb_func_end MainMenu__DrawCursor

	thumb_func_start MainMenu__Func_2155804
MainMenu__Func_2155804: // 0x02155804
	push {r4, r5, r6, lr}
	mov r5, r1
	mov r1, #0x77
	lsl r1, r1, #4
	mov r6, r2
	add r4, r0, r1
	cmp r3, #0
	beq _02155818
	mov r1, #0xf
	b _0215581A
_02155818:
	mov r1, #0xe
_0215581A:
	ldrh r0, [r4, #0xc]
	cmp r1, r0
	beq _02155826
	mov r0, r4
	bl AnimatorSprite__SetAnimation
_02155826:
	mov r1, #0
	strh r5, [r4, #8]
	mov r0, r4
	mov r2, r1
	strh r6, [r4, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	pop {r4, r5, r6, pc}
	thumb_func_end MainMenu__Func_2155804

	thumb_func_start MainMenu__Func_215583C
MainMenu__Func_215583C: // 0x0215583C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x1c
	str r1, [sp, #4]
	ldr r1, _0215597C // =0x000011FC
	str r0, [sp]
	add r0, r0, r1
	mov r1, #0
	str r2, [sp, #8]
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, _02155980 // =0x00002264
	ldr r0, [sp]
	add r0, r0, r1
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, _02155984 // =0x00001328
	ldr r0, [sp]
	mov r4, #0x37
	add r0, r0, r1
	str r0, [sp, #0x14]
	ldr r1, _0215597C // =0x000011FC
	ldr r0, [sp]
	mov r5, #0x53
	add r0, r0, r1
	str r0, [sp, #0x18]
	ldr r1, _02155980 // =0x00002264
	ldr r0, [sp]
	mov r6, #0
	add r0, r0, r1
	str r0, [sp, #0xc]
	ldr r1, _02155988 // =0x00001260
	ldr r0, [sp]
	add r0, r0, r1
	str r0, [sp, #0x10]
_02155886:
	cmp r6, #4
	bne _02155892
	add r5, #0x22
	lsl r0, r5, #0x10
	mov r4, #0x24
	asr r5, r0, #0x10
_02155892:
	ldr r0, [sp, #0x18]
	mov r1, #0
	strh r4, [r0, #8]
	mov r2, r1
	strh r5, [r0, #0xa]
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0x18]
	bl AnimatorSprite__DrawFrame
	mov r0, #0
	bl MainMenu__CheckItemUnlocked
	cmp r0, #0
	beq _0215592A
	ldr r0, [sp, #0x14]
	mov r1, #0
	strh r4, [r0, #8]
	mov r2, r1
	strh r5, [r0, #0xa]
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0x14]
	bl AnimatorSprite__DrawFrame
	lsl r0, r6, #0x10
	lsr r0, r0, #0x10
	bl MainMenu__HasMaterial
	cmp r0, #0
	beq _0215593E
	lsl r0, r6, #0x10
	lsr r0, r0, #0x10
	bl MainMenu__GetMaterialCount
	mov r7, r0
	cmp r7, #0x63
	ble _021558E0
	mov r7, #0x63
_021558E0:
	mov r0, r7
	mov r1, #0xa
	bl FX_DivS32
	mov r3, r0
	mov r0, #0xa
	mul r0, r3
	sub r7, r7, r0
	cmp r3, #0
	ble _0215590E
	mov r1, r4
	mov r2, r5
	add r1, #0xe
	add r2, #0xe
	lsl r1, r1, #0x10
	lsl r2, r2, #0x10
	lsl r3, r3, #0x18
	ldr r0, [sp]
	asr r1, r1, #0x10
	asr r2, r2, #0x10
	lsr r3, r3, #0x18
	bl MainMenu__DrawDigitSmall
_0215590E:
	mov r1, r4
	mov r2, r5
	add r1, #0x16
	add r2, #0xe
	lsl r1, r1, #0x10
	lsl r2, r2, #0x10
	lsl r3, r7, #0x18
	ldr r0, [sp]
	asr r1, r1, #0x10
	asr r2, r2, #0x10
	lsr r3, r3, #0x18
	bl MainMenu__DrawDigitSmall
	b _0215593E
_0215592A:
	ldr r0, [sp, #0xc]
	mov r1, #0
	strh r4, [r0, #8]
	mov r2, r1
	strh r5, [r0, #0xa]
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0xc]
	bl AnimatorSprite__DrawFrame
_0215593E:
	ldr r0, [sp, #4]
	cmp r0, r6
	bne _02155966
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _02155952
	ldr r0, [sp, #0x10]
	mov r1, #1
	bl AnimatorSprite__SetAnimation
_02155952:
	ldr r0, [sp, #0x10]
	mov r1, #0
	strh r4, [r0, #8]
	mov r2, r1
	strh r5, [r0, #0xa]
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0x10]
	bl AnimatorSprite__DrawFrame
_02155966:
	add r4, #0x26
	lsl r0, r4, #0x10
	asr r4, r0, #0x10
	ldr r0, [sp, #0x14]
	add r6, r6, #1
	add r0, #0x64
	str r0, [sp, #0x14]
	cmp r6, #9
	blt _02155886
	add sp, #0x1c
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_0215597C: .word 0x000011FC
_02155980: .word 0x00002264
_02155984: .word 0x00001328
_02155988: .word 0x00001260
	thumb_func_end MainMenu__Func_215583C

	thumb_func_start MainMenu__Func_215598C
MainMenu__Func_215598C: // 0x0215598C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x24
	str r1, [sp, #4]
	ldr r1, _02155A8C // =0x000011FC
	str r0, [sp]
	add r0, r0, r1
	mov r1, #0
	str r2, [sp, #8]
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, _02155A90 // =0x00002264
	ldr r0, [sp]
	add r0, r0, r1
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0
	str r0, [sp, #0x14]
	str r0, [sp, #0x1c]
	ldr r1, _02155A94 // =0x000016AC
	ldr r0, [sp]
	add r0, r0, r1
	str r0, [sp, #0x10]
_021559BE:
	ldr r0, [sp, #0x1c]
	cmp r0, #0
	bne _021559CA
	mov r4, #0xa
	mov r5, #0x53
	b _021559CE
_021559CA:
	mov r4, #0xa
	mov r5, #0x75
_021559CE:
	mov r0, #0
	str r0, [sp, #0x18]
	ldr r1, _02155A90 // =0x00002264
	ldr r0, [sp]
	ldr r6, [sp, #0x10]
	add r0, r0, r1
	str r0, [sp, #0xc]
	ldr r1, _02155A98 // =0x00001260
	ldr r0, [sp]
	add r7, r0, r1
	sub r1, #0x64
	add r0, r0, r1
	str r0, [sp, #0x20]
_021559E8:
	ldr r0, [sp, #0x20]
	mov r1, #0
	strh r4, [r0, #8]
	mov r2, r1
	strh r5, [r0, #0xa]
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0x20]
	bl AnimatorSprite__DrawFrame
	mov r0, #1
	bl MainMenu__CheckItemUnlocked
	cmp r0, #0
	beq _02155A1C
	mov r1, #0
	strh r4, [r6, #8]
	mov r0, r6
	mov r2, r1
	strh r5, [r6, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	b _02155A30
_02155A1C:
	ldr r0, [sp, #0xc]
	mov r1, #0
	strh r4, [r0, #8]
	mov r2, r1
	strh r5, [r0, #0xa]
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0xc]
	bl AnimatorSprite__DrawFrame
_02155A30:
	ldr r1, [sp, #4]
	ldr r0, [sp, #0x14]
	cmp r1, r0
	bne _02155A5A
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _02155A46
	mov r0, r7
	mov r1, #1
	bl AnimatorSprite__SetAnimation
_02155A46:
	mov r1, #0
	strh r4, [r7, #8]
	mov r0, r7
	mov r2, r1
	strh r5, [r7, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r7
	bl AnimatorSprite__DrawFrame
_02155A5A:
	add r4, #0x22
	lsl r0, r4, #0x10
	asr r4, r0, #0x10
	ldr r0, [sp, #0x14]
	add r6, #0x64
	add r0, r0, #1
	str r0, [sp, #0x14]
	ldr r0, [sp, #0x18]
	add r0, r0, #1
	str r0, [sp, #0x18]
	cmp r0, #7
	blt _021559E8
	mov r1, #0xaf
	ldr r0, [sp, #0x10]
	lsl r1, r1, #2
	add r0, r0, r1
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x1c]
	add r0, r0, #1
	str r0, [sp, #0x1c]
	cmp r0, #2
	blt _021559BE
	add sp, #0x24
	pop {r4, r5, r6, r7, pc}
	nop
_02155A8C: .word 0x000011FC
_02155A90: .word 0x00002264
_02155A94: .word 0x000016AC
_02155A98: .word 0x00001260
	thumb_func_end MainMenu__Func_215598C

	thumb_func_start MainMenu__Func_2155A9C
MainMenu__Func_2155A9C: // 0x02155A9C
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x28
	str r1, [sp, #4]
	ldr r1, _02155B9C // =0x000011FC
	str r0, [sp]
	add r0, r0, r1
	mov r1, #0
	str r2, [sp, #8]
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, _02155BA0 // =0x00002264
	ldr r0, [sp]
	add r0, r0, r1
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0
	str r0, [sp, #0x18]
	str r0, [sp, #0x1c]
	str r0, [sp, #0x14]
_02155AC8:
	ldr r0, [sp, #0x1c]
	cmp r0, #0
	bne _02155AD4
	mov r4, #0xa
	mov r5, #0x53
	b _02155AD8
_02155AD4:
	mov r4, #0xa
	mov r5, #0x75
_02155AD8:
	ldr r1, _02155BA0 // =0x00002264
	ldr r0, [sp]
	mov r7, #0
	add r0, r0, r1
	str r0, [sp, #0x10]
	ldr r1, _02155BA4 // =0x00001C24
	ldr r0, [sp]
	add r0, r0, r1
	str r0, [sp, #0x24]
	ldr r1, _02155BA8 // =0x00001260
	ldr r0, [sp]
	add r6, r0, r1
	sub r1, #0x64
	add r0, r0, r1
	str r0, [sp, #0x20]
_02155AF6:
	ldr r0, [sp, #0x20]
	mov r1, #0
	strh r4, [r0, #8]
	mov r2, r1
	strh r5, [r0, #0xa]
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0x20]
	bl AnimatorSprite__DrawFrame
	mov r0, #2
	bl MainMenu__CheckItemUnlocked
	cmp r0, #0
	beq _02155B38
	ldr r0, [sp, #0x14]
	add r1, r7, r0
	mov r2, r1
	mov r0, #0x64
	mul r2, r0
	ldr r0, [sp, #0x24]
	mov r1, #0
	add r0, r0, r2
	strh r4, [r0, #8]
	str r0, [sp, #0xc]
	mov r2, r1
	strh r5, [r0, #0xa]
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0xc]
	bl AnimatorSprite__DrawFrame
	b _02155B4C
_02155B38:
	ldr r0, [sp, #0x10]
	mov r1, #0
	strh r4, [r0, #8]
	mov r2, r1
	strh r5, [r0, #0xa]
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0x10]
	bl AnimatorSprite__DrawFrame
_02155B4C:
	ldr r1, [sp, #4]
	ldr r0, [sp, #0x18]
	cmp r1, r0
	bne _02155B76
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _02155B62
	mov r0, r6
	mov r1, #1
	bl AnimatorSprite__SetAnimation
_02155B62:
	mov r1, #0
	strh r4, [r6, #8]
	mov r0, r6
	mov r2, r1
	strh r5, [r6, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r6
	bl AnimatorSprite__DrawFrame
_02155B76:
	add r4, #0x22
	lsl r0, r4, #0x10
	asr r4, r0, #0x10
	ldr r0, [sp, #0x18]
	add r7, r7, #1
	add r0, r0, #1
	str r0, [sp, #0x18]
	cmp r7, #7
	blt _02155AF6
	ldr r0, [sp, #0x14]
	add r0, r0, #7
	str r0, [sp, #0x14]
	ldr r0, [sp, #0x1c]
	add r0, r0, #1
	str r0, [sp, #0x1c]
	cmp r0, #2
	blt _02155AC8
	add sp, #0x28
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02155B9C: .word 0x000011FC
_02155BA0: .word 0x00002264
_02155BA4: .word 0x00001C24
_02155BA8: .word 0x00001260
	thumb_func_end MainMenu__Func_2155A9C

	thumb_func_start MainMenu__Func_2155BAC
MainMenu__Func_2155BAC: // 0x02155BAC
	push {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	ldr r0, _02155BE8 // =0x00000838
	mov r5, r1
	add r7, r4, r0
	mov r1, #0
	mov r6, r2
	strh r5, [r7, #8]
	mov r0, r7
	mov r2, r1
	strh r6, [r7, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r7
	bl AnimatorSprite__DrawFrame
	ldr r0, _02155BEC // =0x000007D4
	mov r1, #0
	add r4, r4, r0
	strh r5, [r4, #8]
	mov r0, r4
	mov r2, r1
	strh r6, [r4, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02155BE8: .word 0x00000838
_02155BEC: .word 0x000007D4
	thumb_func_end MainMenu__Func_2155BAC

	thumb_func_start MainMenu__Func_2155BF0
MainMenu__Func_2155BF0: // 0x02155BF0
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r6, r0
	mov r0, #0x1f
	mov r5, r3
	mvn r0, r0
	mov r4, r1
	str r2, [sp]
	cmp r5, r0
	ble _02155C08
	cmp r5, #0xc0
	ble _02155C0A
_02155C08:
	b _02155D10
_02155C0A:
	mov r0, #9
	lsl r0, r0, #8
	add r0, r6, r0
	ldr r1, [sp]
	str r0, [sp, #8]
	strh r1, [r0, #8]
	mov r1, #0
	mov r2, r1
	strh r5, [r0, #0xa]
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #8]
	bl AnimatorSprite__DrawFrame
	cmp r4, #3
	bge _02155C92
	ldr r0, _02155D14 // =0x0000089C
	add r0, r6, r0
	str r0, [sp, #4]
	mov r0, r4
	bl MainMenu__CheckItemUnlocked
	cmp r0, #0
	beq _02155C54
	cmp r4, #0
	beq _02155C48
	cmp r4, #1
	beq _02155C4C
	cmp r4, #2
	beq _02155C50
	b _02155C6C
_02155C48:
	mov r7, #0x1b
	b _02155C6C
_02155C4C:
	mov r7, #0x1c
	b _02155C6C
_02155C50:
	mov r7, #0x1d
	b _02155C6C
_02155C54:
	cmp r4, #0
	beq _02155C62
	cmp r4, #1
	beq _02155C66
	cmp r4, #2
	beq _02155C6A
	b _02155C6C
_02155C62:
	mov r7, #0x1f
	b _02155C6C
_02155C66:
	mov r7, #0x1f
	b _02155C6C
_02155C6A:
	mov r7, #0x1e
_02155C6C:
	ldr r0, [sp, #4]
	ldrh r0, [r0, #0xc]
	cmp r7, r0
	beq _02155C7C
	ldr r0, [sp, #4]
	mov r1, r7
	bl AnimatorSprite__SetAnimation
_02155C7C:
	ldr r1, [sp]
	ldr r0, [sp, #4]
	strh r1, [r0, #8]
	mov r1, #0
	mov r2, r1
	strh r5, [r0, #0xa]
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #4]
	bl AnimatorSprite__DrawFrame
_02155C92:
	ldr r0, [sp, #0x20]
	cmp r0, #0
	beq _02155D10
	ldr r0, _02155D18 // =0x00000964
	mov r1, #0
	add r4, r6, r0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r5, #4
	strh r0, [r4, #0xa]
	ldr r1, [r4, #0x3c]
	mov r0, #0x80
	bic r1, r0
	str r1, [r4, #0x3c]
	ldr r0, [sp]
	sub r0, #0x18
	strh r0, [r4, #8]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	ldr r1, [r4, #0x3c]
	mov r0, #0x80
	orr r0, r1
	str r0, [r4, #0x3c]
	ldr r0, [sp]
	add r0, #0xd8
	strh r0, [r4, #8]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	ldr r0, _02155D1C // =0x0000219C
	mov r1, #0
	add r4, r6, r0
	ldr r0, [sp]
	add r5, #0x16
	sub r0, #0x11
	strh r0, [r4, #8]
	mov r0, r4
	mov r2, r1
	strh r5, [r4, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	mov r0, #0x22
	lsl r0, r0, #8
	add r4, r6, r0
	ldr r0, [sp]
	mov r1, #0
	add r0, #0xc1
	str r0, [sp]
	strh r0, [r4, #8]
	mov r0, r4
	mov r2, r1
	strh r5, [r4, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
_02155D10:
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02155D14: .word 0x0000089C
_02155D18: .word 0x00000964
_02155D1C: .word 0x0000219C
	thumb_func_end MainMenu__Func_2155BF0

	thumb_func_start MainMenu__DrawRingCount
MainMenu__DrawRingCount: // 0x02155D20
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r5, r1
	ldr r1, _02155DA4 // =0x000012C4
	str r0, [sp]
	add r4, r0, r1
	mov r1, #0
	mov r7, r2
	strh r5, [r4, #8]
	mov r0, r4
	mov r2, r1
	mov r6, r3
	strh r7, [r4, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	mov r0, #0
	mvn r0, r0
	cmp r6, r0
	beq _02155D9E
	ldr r0, _02155DA8 // =0x000F423F
	cmp r6, r0
	bls _02155D54
	mov r6, r0
_02155D54:
	add r5, #0x1a
	lsl r0, r5, #0x10
	asr r5, r0, #0x10
	mov r0, #0
	add r7, #0xc
	str r0, [sp, #4]
	lsl r0, r7, #0x10
	asr r0, r0, #0x10
	ldr r4, _02155DAC // =0x000186A0
	str r0, [sp, #8]
_02155D68:
	mov r0, r6
	mov r1, r4
	bl FX_DivS32
	mov r7, r0
	mul r0, r4
	sub r6, r6, r0
	mov r0, r4
	mov r1, #0xa
	bl FX_DivS32
	mov r4, r0
	lsl r3, r7, #0x18
	ldr r0, [sp]
	ldr r2, [sp, #8]
	mov r1, r5
	lsr r3, r3, #0x18
	bl MainMenu__DrawDigitBig
	add r5, #9
	lsl r0, r5, #0x10
	asr r5, r0, #0x10
	ldr r0, [sp, #4]
	add r0, r0, #1
	str r0, [sp, #4]
	cmp r0, #6
	blt _02155D68
_02155D9E:
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_02155DA4: .word 0x000012C4
_02155DA8: .word 0x000F423F
_02155DAC: .word 0x000186A0
	thumb_func_end MainMenu__DrawRingCount

	thumb_func_start MainMenu__DrawTextBorder2
MainMenu__DrawTextBorder2: // 0x02155DB0
	push {r4, lr}
	ldr r3, _02155DCC // =0x000009C8
	add r4, r0, r3
	strh r1, [r4, #8]
	mov r1, #0
	strh r2, [r4, #0xa]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	pop {r4, pc}
	.align 2, 0
_02155DCC: .word 0x000009C8
	thumb_func_end MainMenu__DrawTextBorder2

	thumb_func_start MainMenu__DrawDigitSmall
MainMenu__DrawDigitSmall: // 0x02155DD0
	push {r3, r4, r5, lr}
	mov r5, #0xf
	mvn r5, r5
	cmp r1, r5
	blt _02155E08
	mov r4, #1
	lsl r4, r4, #8
	cmp r1, r4
	bge _02155E08
	cmp r2, r5
	blt _02155E08
	cmp r2, #0xc0
	bge _02155E08
	ldr r4, _02155E0C // =0x00000A2C
	add r4, r0, r4
	mov r0, #0x64
	mul r0, r3
	add r4, r4, r0
	strh r1, [r4, #8]
	mov r1, #0
	strh r2, [r4, #0xa]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
_02155E08:
	pop {r3, r4, r5, pc}
	nop
_02155E0C: .word 0x00000A2C
	thumb_func_end MainMenu__DrawDigitSmall

	thumb_func_start MainMenu__DrawDigitBig
MainMenu__DrawDigitBig: // 0x02155E10
	push {r3, r4, r5, lr}
	mov r5, #0xf
	mvn r5, r5
	cmp r1, r5
	blt _02155E48
	mov r4, #1
	lsl r4, r4, #8
	cmp r1, r4
	bge _02155E48
	cmp r2, r5
	blt _02155E48
	cmp r2, #0xc0
	bge _02155E48
	ldr r4, _02155E4C // =0x00000E14
	add r4, r0, r4
	mov r0, #0x64
	mul r0, r3
	add r4, r4, r0
	strh r1, [r4, #8]
	mov r1, #0
	strh r2, [r4, #0xa]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
_02155E48:
	pop {r3, r4, r5, pc}
	nop
_02155E4C: .word 0x00000E14
	thumb_func_end MainMenu__DrawDigitBig

	thumb_func_start MainMenu__Func_2155E50
MainMenu__Func_2155E50: // 0x02155E50
	push {r4, lr}
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02155E68
	ldr r0, _02155EC4 // =touchInput
	ldrh r1, [r0, #0x12]
	mov r0, #4
	tst r0, r1
	beq _02155E68
	mov r0, #1
	b _02155E6A
_02155E68:
	mov r0, #0
_02155E6A:
	cmp r0, #0
	bne _02155E72
	ldr r0, _02155EC8 // =0x0000FFFF
	pop {r4, pc}
_02155E72:
	ldr r1, _02155EC4 // =touchInput
	ldrh r4, [r1, #0x1e]
	ldrh r0, [r1, #0x1c]
	mov r1, r4
	sub r1, #0x53
	cmp r1, #0x22
	bhs _02155E9C
	mov r2, #0x34
	mov r3, #0
_02155E84:
	sub r1, r0, r2
	cmp r1, #0x26
	bhs _02155E90
	lsl r0, r3, #0x10
	lsr r0, r0, #0x10
	pop {r4, pc}
_02155E90:
	add r2, #0x26
	lsl r1, r2, #0x10
	add r3, r3, #1
	lsr r2, r1, #0x10
	cmp r3, #4
	blt _02155E84
_02155E9C:
	sub r4, #0x75
	cmp r4, #0x22
	bhs _02155EBE
	mov r2, #0x21
	mov r3, #4
_02155EA6:
	sub r1, r0, r2
	cmp r1, #0x26
	bhs _02155EB2
	lsl r0, r3, #0x10
	lsr r0, r0, #0x10
	pop {r4, pc}
_02155EB2:
	add r2, #0x26
	lsl r1, r2, #0x10
	add r3, r3, #1
	lsr r2, r1, #0x10
	cmp r3, #9
	blt _02155EA6
_02155EBE:
	ldr r0, _02155EC8 // =0x0000FFFF
	pop {r4, pc}
	nop
_02155EC4: .word touchInput
_02155EC8: .word 0x0000FFFF
	thumb_func_end MainMenu__Func_2155E50

	thumb_func_start MainMenu__Func_2155ECC
MainMenu__Func_2155ECC: // 0x02155ECC
	push {r3, r4, r5, r6, r7, lr}
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02155EE4
	ldr r0, _02155F34 // =touchInput
	ldrh r1, [r0, #0x12]
	mov r0, #4
	tst r0, r1
	beq _02155EE4
	mov r0, #1
	b _02155EE6
_02155EE4:
	mov r0, #0
_02155EE6:
	cmp r0, #0
	bne _02155EEE
	ldr r0, _02155F38 // =0x0000FFFF
	pop {r3, r4, r5, r6, r7, pc}
_02155EEE:
	ldr r0, _02155F34 // =touchInput
	mov r3, #0
	ldrh r5, [r0, #0x1e]
	ldrh r6, [r0, #0x1c]
	mov r1, #9
	mov r2, #0x53
	mov r0, r3
_02155EFC:
	sub r4, r5, r2
	cmp r4, #0x22
	bhs _02155F22
	mov r4, r0
_02155F04:
	sub r7, r6, r1
	cmp r7, #0x22
	bhs _02155F16
	mov r0, #7
	mul r0, r3
	add r0, r4, r0
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	pop {r3, r4, r5, r6, r7, pc}
_02155F16:
	add r1, #0x22
	lsl r1, r1, #0x10
	add r4, r4, #1
	lsr r1, r1, #0x10
	cmp r4, #7
	blt _02155F04
_02155F22:
	add r2, #0x22
	lsl r2, r2, #0x10
	add r3, r3, #1
	lsr r2, r2, #0x10
	cmp r3, #2
	blt _02155EFC
	ldr r0, _02155F38 // =0x0000FFFF
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02155F34: .word touchInput
_02155F38: .word 0x0000FFFF
	thumb_func_end MainMenu__Func_2155ECC

	thumb_func_start MainMenu__Func_2155F3C
MainMenu__Func_2155F3C: // 0x02155F3C
	push {r3, lr}
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02155F54
	ldr r0, _02155F78 // =touchInput
	ldrh r1, [r0, #0x12]
	mov r0, #4
	tst r0, r1
	beq _02155F54
	mov r0, #1
	b _02155F56
_02155F54:
	mov r0, #0
_02155F56:
	cmp r0, #0
	bne _02155F5E
	mov r0, #0
	pop {r3, pc}
_02155F5E:
	ldr r0, _02155F78 // =touchInput
	ldrh r1, [r0, #0x1e]
	ldrh r0, [r0, #0x1c]
	cmp r0, #0x20
	bhs _02155F72
	sub r1, #0x28
	cmp r1, #0x20
	bhs _02155F72
	mov r0, #1
	pop {r3, pc}
_02155F72:
	mov r0, #0
	pop {r3, pc}
	nop
_02155F78: .word touchInput
	thumb_func_end MainMenu__Func_2155F3C

	thumb_func_start MainMenu__Func_2155F7C
MainMenu__Func_2155F7C: // 0x02155F7C
	push {r3, lr}
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02155F94
	ldr r0, _02155FB8 // =touchInput
	ldrh r1, [r0, #0x12]
	mov r0, #4
	tst r0, r1
	beq _02155F94
	mov r0, #1
	b _02155F96
_02155F94:
	mov r0, #0
_02155F96:
	cmp r0, #0
	bne _02155F9E
	mov r0, #0
	pop {r3, pc}
_02155F9E:
	ldr r0, _02155FB8 // =touchInput
	ldrh r1, [r0, #0x1e]
	ldrh r0, [r0, #0x1c]
	sub r0, #0xe0
	cmp r0, #0x20
	bhs _02155FB4
	sub r1, #0x28
	cmp r1, #0x20
	bhs _02155FB4
	mov r0, #1
	pop {r3, pc}
_02155FB4:
	mov r0, #0
	pop {r3, pc}
	.align 2, 0
_02155FB8: .word touchInput
	thumb_func_end MainMenu__Func_2155F7C

	thumb_func_start MainMenu__Func_2155FBC
MainMenu__Func_2155FBC: // 0x02155FBC
	push {r3, r4, lr}
	sub sp, #0x1c
	mov r4, r0
	mov r0, #0x69
	lsl r0, r0, #2
	add r0, r4, r0
	bl TouchField__Init
	mov r0, #0x6d
	mov r3, #0
	lsl r0, r0, #2
	strb r3, [r4, r0]
	add r0, #8
	mov r2, #0x10
	add r1, sp, #8
	strh r2, [r1]
	mov r2, #0xb0
	strh r2, [r1, #2]
	sub r2, #0xbc
	strh r2, [r1, #4]
	strh r2, [r1, #6]
	mov r2, #0xc
	strh r2, [r1, #8]
	strh r2, [r1, #0xa]
	str r3, [sp]
	str r3, [sp, #4]
	ldr r2, _02156008 // =TouchField__PointInRect
	add r0, r4, r0
	add r1, sp, #8
	add r3, sp, #0xc
	bl TouchField__InitAreaShape
	mov r0, #0x7d
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r4, r0]
	add sp, #0x1c
	pop {r3, r4, pc}
	.align 2, 0
_02156008: .word TouchField__PointInRect
	thumb_func_end MainMenu__Func_2155FBC

	thumb_func_start MainMenu__Func_215600C
MainMenu__Func_215600C: // 0x0215600C
	push {r3, lr}
	mov r2, #0x7d
	mov r3, r0
	lsl r2, r2, #2
	ldr r0, [r3, r2]
	cmp r0, r1
	beq _02156040
	str r1, [r3, r2]
	cmp r1, #0
	beq _02156032
	mov r0, r2
	sub r2, #0x38
	sub r0, #0x50
	add r1, r3, r2
	ldr r2, _02156044 // =0x0000FFFF
	add r0, r3, r0
	bl TouchField__AddArea
	pop {r3, pc}
_02156032:
	mov r0, r2
	sub r0, #0x50
	sub r2, #0x38
	add r0, r3, r0
	add r1, r3, r2
	bl TouchField__RemoveArea
_02156040:
	pop {r3, pc}
	nop
_02156044: .word 0x0000FFFF
	thumb_func_end MainMenu__Func_215600C

	thumb_func_start MainMenu__Func_2156048
MainMenu__Func_2156048: // 0x02156048
	mov r1, #0x7d
	lsl r1, r1, #2
	ldr r2, [r0, r1]
	cmp r2, #0
	bne _02156056
	mov r0, #0
	bx lr
_02156056:
	sub r1, #0x24
	ldr r1, [r0, r1]
	mov r0, #2
	lsl r0, r0, #0xa
	tst r0, r1
	beq _02156066
	mov r0, #0
	bx lr
_02156066:
	mov r0, #0x10
	tst r0, r1
	beq _02156070
	mov r0, #1
	bx lr
_02156070:
	mov r0, #0
	bx lr
	thumb_func_end MainMenu__Func_2156048

	thumb_func_start MainMenu__Func_2156074
MainMenu__Func_2156074: // 0x02156074
	mov r1, #0x7d
	lsl r1, r1, #2
	ldr r2, [r0, r1]
	cmp r2, #0
	bne _02156082
	mov r0, #0
	bx lr
_02156082:
	sub r1, #0x24
	ldr r2, [r0, r1]
	mov r0, #2
	lsl r0, r0, #0xa
	mov r1, r2
	tst r1, r0
	beq _02156094
	mov r0, #0
	bx lr
_02156094:
	lsl r0, r0, #7
	tst r0, r2
	beq _0215609E
	mov r0, #1
	bx lr
_0215609E:
	mov r0, #0
	bx lr
	.align 2, 0
	thumb_func_end MainMenu__Func_2156074

	thumb_func_start MainMenu__Func_21560A4
MainMenu__Func_21560A4: // 0x021560A4
	bx lr
	.align 2, 0
	thumb_func_end MainMenu__Func_21560A4

	thumb_func_start MainMenu__Func_21560A8
MainMenu__Func_21560A8: // 0x021560A8
	push {r4, lr}
	mov r4, r0
	mov r0, #1
	str r0, [r4, #0x14]
	bl ReleaseSysSound
	mov r0, r4
	bl MainMenu__ReleaseSprites
	bl LoadSpriteButtonCursorSprite
	bl LoadSpriteButtonTouchpadSprite
	ldr r0, [r4, #0]
	bl SeaMapMenu__Create
	ldr r1, _021560D4 // =MainMenu__Func_21560D8
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
	nop
_021560D4: .word MainMenu__Func_21560D8
	thumb_func_end MainMenu__Func_21560A8

	thumb_func_start MainMenu__Func_21560D8
MainMenu__Func_21560D8: // 0x021560D8
	push {r4, lr}
	mov r4, r0
	bl SeaMapView__IsActive
	cmp r0, #0
	bne _021560EC
	ldr r1, _021560F0 // =MainMenu__Func_21560F4
	mov r0, r4
	bl MainMenu__SetState
_021560EC:
	pop {r4, pc}
	nop
_021560F0: .word MainMenu__Func_21560F4
	thumb_func_end MainMenu__Func_21560D8

	thumb_func_start MainMenu__Func_21560F4
MainMenu__Func_21560F4: // 0x021560F4
	push {r3, r4, r5, lr}
	mov r4, r0
	bl SeaMapView__Func_203DCB4
	mov r5, r0
	bl ReleaseSpriteButtonTouchpadSprite
	bl ReleaseSpriteButtonCursorSprite
	cmp r5, #1
	beq _02156110
	cmp r5, #2
	beq _02156128
	b _02156154
_02156110:
	mov r0, #0xb
	bl SaveGame__SetProgressType
	mov r0, r4
	mov r1, #4
	bl MainMenu__Func_2152C64
	mov r0, r4
	mov r1, #0
	bl MainMenu__SetState
	pop {r3, r4, r5, pc}
_02156128:
	mov r0, #0
	str r0, [r4, #0x14]
	mov r0, r4
	bl MainMenu__SetupDisplay2
	ldr r0, _02156168 // =0x00002468
	ldr r1, _0215616C // =MainMenu__Func_2153FC8
	add r0, r4, r0
	mov r2, r4
	mov r3, #0x16
	bl CreateThreadWorker
	ldr r1, _02156170 // =MainMenu__Func_2153F7C
	mov r0, r4
	bl MainMenu__SetState
	bl LoadSysSoundVillage
	mov r0, #0
	bl PlaySysVillageTrack
	pop {r3, r4, r5, pc}
_02156154:
	mov r1, #0
	mov r0, r4
	str r1, [r4, #0x14]
	bl MainMenu__Func_2152C64
	mov r0, r4
	mov r1, #0
	bl MainMenu__SetState
	pop {r3, r4, r5, pc}
	.align 2, 0
_02156168: .word 0x00002468
_0215616C: .word MainMenu__Func_2153FC8
_02156170: .word MainMenu__Func_2153F7C
	thumb_func_end MainMenu__Func_21560F4

	thumb_func_start MainMenu__Func_2156174
MainMenu__Func_2156174: // 0x02156174
	push {r4, lr}
	mov r4, r0
	mov r1, #1
	str r1, [r4, #0x14]
	bl MainMenu__ReleaseSprites
	ldr r0, [r4, #0x18]
	cmp r0, #0
	beq _02156196
	mov r0, r4
	add r0, #0xcc
	ldr r0, [r0, #0]
	ldr r1, [r4, #0]
	mov r2, #0x27
	bl StageSelectMenu__Create
	b _021561A4
_02156196:
	mov r0, r4
	add r0, #0xcc
	ldr r0, [r0, #0]
	ldr r1, [r4, #0]
	mov r2, #0x26
	bl StageSelectMenu__Create
_021561A4:
	mov r0, #0
	str r0, [r4, #0x18]
	mov r0, r4
	mov r1, #0x2e
	add r0, #0xd4
	strh r1, [r0]
	mov r0, #7
	bl PlaySysSfx
	ldr r1, _021561C0 // =MainMenu__State_21561C4
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
	.align 2, 0
_021561C0: .word MainMenu__State_21561C4
	thumb_func_end MainMenu__Func_2156174

	thumb_func_start MainMenu__State_21561C4
MainMenu__State_21561C4: // 0x021561C4
	push {r4, lr}
	mov r4, r0
	add r0, #0xcc
	ldr r0, [r0, #0]
	bl StageSelectMenu__Func_215DA40
	cmp r0, #0
	beq _021561DE
	ldr r1, _02156220 // =MainMenu__Func_2156228
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
_021561DE:
	mov r0, r4
	add r0, #0xcc
	ldr r0, [r0, #0]
	bl StageSelectMenu__Func_215DA68
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	cmp r1, #0x2e
	bhs _021561F8
	ldr r0, _02156224 // =0x0217D19A
	lsl r2, r1, #1
	ldrh r0, [r0, r2]
	b _021561FA
_021561F8:
	mov r0, #0
_021561FA:
	mov r2, r4
	add r2, #0xd4
	ldrh r2, [r2, #0]
	cmp r2, #0x2e
	bhs _0215620C
	lsl r3, r2, #1
	ldr r2, _02156224 // =0x0217D19A
	ldrh r2, [r2, r3]
	b _0215620E
_0215620C:
	mov r2, #0
_0215620E:
	add r4, #0xd4
	strh r1, [r4]
	cmp r0, r2
	beq _0215621C
	mov r1, #0xb4
	bl NavTailsSpeak
_0215621C:
	pop {r4, pc}
	nop
_02156220: .word MainMenu__Func_2156228
_02156224: .word 0x0217D19A
	thumb_func_end MainMenu__State_21561C4

	thumb_func_start MainMenu__Func_2156228
MainMenu__Func_2156228: // 0x02156228
	push {r4, lr}
	mov r4, r0
	add r0, #0xcc
	ldr r0, [r0, #0]
	bl StageSelectMenu__Func_215DA54
	cmp r0, #3
	bhi _021562BC
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02156244: // jump table
	.hword _021562BC - _02156244 - 2 // case 0
	.hword _0215624C - _02156244 - 2 // case 1
	.hword _02156288 - _02156244 - 2 // case 2
	.hword _0215626A - _02156244 - 2 // case 3
_0215624C:
	ldr r0, _021562D0 // =gameState
	mov r1, #0
	str r1, [r0, #0x14]
	mov r0, r4
	mov r1, #1
	bl MainMenu__Func_2152C64
	mov r0, #1
	bl SaveGame__GsExit
	mov r0, r4
	mov r1, #0
	bl MainMenu__SetState
	pop {r4, pc}
_0215626A:
	ldr r0, _021562D0 // =gameState
	mov r1, #0
	str r1, [r0, #0x14]
	mov r0, r4
	mov r1, #2
	bl MainMenu__Func_2152C64
	mov r0, #1
	bl SaveGame__GsExit
	mov r0, r4
	mov r1, #0
	bl MainMenu__SetState
	pop {r4, pc}
_02156288:
	bl MainMenu__Func_21565A4
	cmp r0, #0
	beq _0215629A
	ldr r1, _021562D4 // =MainMenu__Func_21562E4
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
_0215629A:
	mov r0, #0
	str r0, [r4, #0x14]
	mov r0, r4
	bl MainMenu__SetupDisplay2
	ldr r0, _021562D8 // =0x00002468
	ldr r1, _021562DC // =MainMenu__Func_2153FC8
	add r0, r4, r0
	mov r2, r4
	mov r3, #0x16
	bl CreateThreadWorker
	ldr r1, _021562E0 // =MainMenu__Func_2153F40
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
_021562BC:
	mov r1, #0
	mov r0, r4
	str r1, [r4, #0x14]
	bl MainMenu__Func_2152C64
	mov r0, r4
	mov r1, #0
	bl MainMenu__SetState
	pop {r4, pc}
	.align 2, 0
_021562D0: .word gameState
_021562D4: .word MainMenu__Func_21562E4
_021562D8: .word 0x00002468
_021562DC: .word MainMenu__Func_2153FC8
_021562E0: .word MainMenu__Func_2153F40
	thumb_func_end MainMenu__Func_2156228

	thumb_func_start MainMenu__Func_21562E4
MainMenu__Func_21562E4: // 0x021562E4
	push {r4, lr}
	mov r4, r0
	mov r1, #1
	str r1, [r4, #0x14]
	bl MainMenu__ReleaseSprites
	mov r0, r4
	add r0, #0xd0
	ldr r0, [r0, #0]
	ldr r1, [r4, #0]
	mov r2, #0
	bl CharacterSelectMenu__Create
	mov r0, #7
	bl PlaySysSfx
	ldr r1, _02156310 // =MainMenu__Func_2156314
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
	nop
_02156310: .word MainMenu__Func_2156314
	thumb_func_end MainMenu__Func_21562E4

	thumb_func_start MainMenu__Func_2156314
MainMenu__Func_2156314: // 0x02156314
	push {r4, lr}
	mov r4, r0
	add r0, #0xd0
	ldr r0, [r0, #0]
	bl CharacterSelectMenu__Func_215FC18
	cmp r0, #0
	beq _0215632C
	ldr r1, _02156330 // =MainMenu__Func_2156334
	mov r0, r4
	bl MainMenu__SetState
_0215632C:
	pop {r4, pc}
	nop
_02156330: .word MainMenu__Func_2156334
	thumb_func_end MainMenu__Func_2156314

	thumb_func_start MainMenu__Func_2156334
MainMenu__Func_2156334: // 0x02156334
	push {r4, lr}
	mov r4, r0
	add r0, #0xd0
	ldr r0, [r0, #0]
	bl CharacterSelectMenu__Func_215FC2C
	cmp r0, #0
	beq _0215637A
	cmp r0, #1
	beq _0215634E
	cmp r0, #2
	beq _02156358
	b _0215637A
_0215634E:
	ldr r1, _02156390 // =MainMenu__Func_2156174
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
_02156358:
	mov r0, #0
	str r0, [r4, #0x14]
	mov r0, r4
	bl MainMenu__SetupDisplay2
	ldr r0, _02156394 // =0x00002468
	ldr r1, _02156398 // =MainMenu__Func_2153FC8
	add r0, r4, r0
	mov r2, r4
	mov r3, #0x16
	bl CreateThreadWorker
	ldr r1, _0215639C // =MainMenu__Func_2153F40
	mov r0, r4
	bl MainMenu__SetState
	pop {r4, pc}
_0215637A:
	mov r1, #0
	mov r0, r4
	str r1, [r4, #0x14]
	bl MainMenu__Func_2152C64
	mov r0, r4
	mov r1, #0
	bl MainMenu__SetState
	pop {r4, pc}
	nop
_02156390: .word MainMenu__Func_2156174
_02156394: .word 0x00002468
_02156398: .word MainMenu__Func_2153FC8
_0215639C: .word MainMenu__Func_2153F40
	thumb_func_end MainMenu__Func_2156334

	thumb_func_start MainMenu__Main
MainMenu__Main: // 0x021563A0
	push {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, _021563C0 // =0x00002468
	add r0, r0, r1
	bl IsThreadWorkerFinished
	cmp r0, #0
	beq _021563BE
	mov r0, #4
	bl CARD_SetThreadPriority
	ldr r0, _021563C4 // =MainMenu__Main_21563C8
	bl SetCurrentTaskMainEvent
_021563BE:
	pop {r3, pc}
	.align 2, 0
_021563C0: .word 0x00002468
_021563C4: .word MainMenu__Main_21563C8
	thumb_func_end MainMenu__Main

	thumb_func_start MainMenu__Main_21563C8
MainMenu__Main_21563C8: // 0x021563C8
	push {r3, lr}
	bl GetCurrentTaskWork_
	bl MainMenu__Func_2152A94
	ldr r0, _021563DC // =MainMenu__Main_21563E0
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	nop
_021563DC: .word MainMenu__Main_21563E0
	thumb_func_end MainMenu__Main_21563C8

	thumb_func_start MainMenu__Main_21563E0
MainMenu__Main_21563E0: // 0x021563E0
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl MainMenu__Func_2152FD0
	mov r0, r4
	bl MainMenu__Func_21531B8
	cmp r0, #0
	bne _021563FA
	mov r0, #1
	b _021563FC
_021563FA:
	mov r0, #0
_021563FC:
	cmp r0, #0
	beq _02156408
	ldr r0, _02156414 // =MainMenu__Main_2156418
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_02156408:
	add r4, #0xd8
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	pop {r4, pc}
	nop
_02156414: .word MainMenu__Main_2156418
	thumb_func_end MainMenu__Main_21563E0

	thumb_func_start MainMenu__Main_2156418
MainMenu__Main_2156418: // 0x02156418
	push {r3, r4, r5, lr}
	mov r5, #1
	bl GetCurrentTaskWork_
	mov r1, #0x62
	lsl r1, r1, #2
	ldr r4, [r0, r1]
	bl DestroyNavTails
	bl DestroyCurrentTask
	cmp r4, #5
	bhi _0215644C
	add r0, r4, r4
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0215643E: // jump table
	.hword _0215644C - _0215643E - 2 // case 0
	.hword _0215644C - _0215643E - 2 // case 1
	.hword _0215644C - _0215643E - 2 // case 2
	.hword _0215644A - _0215643E - 2 // case 3
	.hword _0215644C - _0215643E - 2 // case 4
	.hword _0215644C - _0215643E - 2 // case 5
_0215644A:
	mov r5, #0
_0215644C:
	cmp r5, #0
	beq _02156454
	bl ReleaseSysSound
_02156454:
	mov r0, r4
	bl MainMenu__Func_2152C6C
	pop {r3, r4, r5, pc}
	thumb_func_end MainMenu__Main_2156418

	thumb_func_start MainMenu__Destructor
MainMenu__Destructor: // 0x0215645C
	push {r3, lr}
	bl GetTaskWork_
	bl MainMenu__Func_2152B64
	pop {r3, pc}
	thumb_func_end MainMenu__Destructor

	thumb_func_start MainMenu__Func_2156468
MainMenu__Func_2156468: // 0x02156468
	push {r3, r4, r5, r6, r7, lr}
	ldr r6, _02156494 // =0x00001CE7
	mov r5, r0
	mov r4, #0
	mov r7, #0x20
_02156472:
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	bl MainMenu__HasMaterial
	cmp r0, #0
	bne _02156488
	mov r0, r6
	mov r1, r5
	mov r2, r7
	bl MIi_CpuClear16
_02156488:
	add r4, r4, #1
	add r5, #0x20
	cmp r4, #9
	blt _02156472
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02156494: .word 0x00001CE7
	thumb_func_end MainMenu__Func_2156468

	thumb_func_start MainMenu__Func_2156498
MainMenu__Func_2156498: // 0x02156498
	push {r3, r4, r5, r6, r7, lr}
	ldr r6, _021564C4 // =0x00001CE7
	mov r5, r0
	mov r4, #0
	mov r7, #0x20
_021564A2:
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	bl MainMenu__HasChaosEmerald
	cmp r0, #0
	bne _021564B8
	mov r0, r6
	mov r1, r5
	mov r2, r7
	bl MIi_CpuClear16
_021564B8:
	add r4, r4, #1
	add r5, #0x20
	cmp r4, #7
	blt _021564A2
	pop {r3, r4, r5, r6, r7, pc}
	nop
_021564C4: .word 0x00001CE7
	thumb_func_end MainMenu__Func_2156498

	thumb_func_start MainMenu__Func_21564C8
MainMenu__Func_21564C8: // 0x021564C8
	push {r3, r4, r5, r6, r7, lr}
	ldr r6, _021564F4 // =0x00001CE7
	mov r5, r0
	mov r4, #0
	mov r7, #0x20
_021564D2:
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	bl MainMenu__HasSolEmerald
	cmp r0, #0
	bne _021564E8
	mov r0, r6
	mov r1, r5
	mov r2, r7
	bl MIi_CpuClear16
_021564E8:
	add r4, r4, #1
	add r5, #0x20
	cmp r4, #7
	blt _021564D2
	pop {r3, r4, r5, r6, r7, pc}
	nop
_021564F4: .word 0x00001CE7
	thumb_func_end MainMenu__Func_21564C8

	thumb_func_start MainMenu__Func_21564F8
MainMenu__Func_21564F8: // 0x021564F8
	push {r3, r4, r5, r6, r7, lr}
	ldr r6, _02156524 // =0x00001CE7
	mov r5, r0
	mov r4, #0
	mov r7, #0x20
_02156502:
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	bl MainMenu__HasMedal
	cmp r0, #0
	bne _02156518
	mov r0, r6
	mov r1, r5
	mov r2, r7
	bl MIi_CpuClear16
_02156518:
	add r4, r4, #1
	add r5, #0x20
	cmp r4, #0xe
	blt _02156502
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02156524: .word 0x00001CE7
	thumb_func_end MainMenu__Func_21564F8

	thumb_func_start MainMenu__HasMaterial
MainMenu__HasMaterial: // 0x02156528
	ldr r3, _02156530 // =SaveGame__HasMaterial
	mov r1, r0
	ldr r0, _02156534 // =saveGame+0x00000028
	bx r3
	.align 2, 0
_02156530: .word SaveGame__HasMaterial
_02156534: .word saveGame+0x00000028
	thumb_func_end MainMenu__HasMaterial

	thumb_func_start MainMenu__GetMaterialCount
MainMenu__GetMaterialCount: // 0x02156538
	ldr r3, _02156540 // =SaveGame__GetMaterialCount
	mov r1, r0
	ldr r0, _02156544 // =saveGame+0x00000028
	bx r3
	.align 2, 0
_02156540: .word SaveGame__GetMaterialCount
_02156544: .word saveGame+0x00000028
	thumb_func_end MainMenu__GetMaterialCount

	thumb_func_start MainMenu__HasChaosEmerald
MainMenu__HasChaosEmerald: // 0x02156548
	mov r1, r0
	lsl r1, r1, #0x18
	ldr r3, _02156554 // =SaveGame__HasChaosEmerald
	ldr r0, _02156558 // =saveGame+0x000001D0
	lsr r1, r1, #0x18
	bx r3
	.align 2, 0
_02156554: .word SaveGame__HasChaosEmerald
_02156558: .word saveGame+0x000001D0
	thumb_func_end MainMenu__HasChaosEmerald

	thumb_func_start MainMenu__HasSolEmerald
MainMenu__HasSolEmerald: // 0x0215655C
	mov r1, r0
	lsl r1, r1, #0x18
	ldr r3, _02156568 // =SaveGame__HasSolEmerald
	ldr r0, _0215656C // =saveGame+0x00000028
	lsr r1, r1, #0x18
	bx r3
	.align 2, 0
_02156568: .word SaveGame__HasSolEmerald
_0215656C: .word saveGame+0x00000028
	thumb_func_end MainMenu__HasSolEmerald

	thumb_func_start MainMenu__HasMedal
MainMenu__HasMedal: // 0x02156570
	push {r3, r4, lr}
	sub sp, #0x1c
	ldr r4, _021565A0 // =0x0217D17E
	add r3, sp, #0
	mov r2, #0xe
_0215657A:
	ldrh r1, [r4, #0]
	add r4, r4, #2
	strh r1, [r3]
	add r3, r3, #2
	sub r2, r2, #1
	bne _0215657A
	lsl r1, r0, #1
	add r0, sp, #0
	ldrh r0, [r0, r1]
	bl SaveGame__GetMissionStatus
	cmp r0, #3
	blt _0215659A
	add sp, #0x1c
	mov r0, #1
	pop {r3, r4, pc}
_0215659A:
	mov r0, #0
	add sp, #0x1c
	pop {r3, r4, pc}
	.align 2, 0
_021565A0: .word 0x0217D17E
	thumb_func_end MainMenu__HasMedal

	thumb_func_start MainMenu__Func_21565A4
MainMenu__Func_21565A4: // 0x021565A4
	push {r3, lr}
	bl SaveGame__GetGameProgress
	cmp r0, #0x10
	blt _021565B2
	mov r0, #1
	pop {r3, pc}
_021565B2:
	mov r0, #0
	pop {r3, pc}
	.align 2, 0
	thumb_func_end MainMenu__Func_21565A4

	thumb_func_start MainMenu__Func_21565B8
MainMenu__Func_21565B8: // 0x021565B8
	push {r3, lr}
	bl SaveGame__GetGameProgress
	cmp r0, #3
	blt _021565C6
	mov r0, #1
	pop {r3, pc}
_021565C6:
	mov r0, #0
	pop {r3, pc}
	.align 2, 0
	thumb_func_end MainMenu__Func_21565B8

	thumb_func_start MainMenu__GetRingCount
MainMenu__GetRingCount: // 0x021565CC
	ldr r0, _021565D4 // =saveGame+0x00000180
	ldr r0, [r0, #0x3c]
	bx lr
	nop
_021565D4: .word saveGame+0x00000180
	thumb_func_end MainMenu__GetRingCount

	thumb_func_start MainMenu__CheckItemUnlocked
MainMenu__CheckItemUnlocked: // 0x021565D8
	push {r4, lr}
	cmp r0, #0
	beq _021565E8
	cmp r0, #1
	beq _02156602
	cmp r0, #2
	beq _0215662C
	b _02156644
_021565E8:
	mov r4, #0
_021565EA:
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	bl MainMenu__HasMaterial
	cmp r0, #0
	beq _021565FA
	mov r0, #1
	pop {r4, pc}
_021565FA:
	add r4, r4, #1
	cmp r4, #9
	blt _021565EA
	b _02156644
_02156602:
	mov r4, #0
_02156604:
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	bl MainMenu__HasChaosEmerald
	cmp r0, #0
	beq _02156614
	mov r0, #1
	pop {r4, pc}
_02156614:
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	bl MainMenu__HasSolEmerald
	cmp r0, #0
	beq _02156624
	mov r0, #1
	pop {r4, pc}
_02156624:
	add r4, r4, #1
	cmp r4, #7
	blt _02156604
	b _02156644
_0215662C:
	mov r4, #0
_0215662E:
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	bl MainMenu__HasMedal
	cmp r0, #0
	beq _0215663E
	mov r0, #1
	pop {r4, pc}
_0215663E:
	add r4, r4, #1
	cmp r4, #0xe
	blt _0215662E
_02156644:
	mov r0, #0
	pop {r4, pc}
	thumb_func_end MainMenu__CheckItemUnlocked

	.rodata

	_0217D068:
	.byte 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x01, 0x00
	.byte 0x0F, 0x00, 0x09, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x10, 0x00
	.byte 0x01, 0x00, 0x00, 0x20, 0x00, 0x00, 0xA0, 0x00, 0x00, 0x00, 0x20, 0x01, 0x10, 0x00, 0x00, 0xFF
	.byte 0x10, 0x00, 0xA0, 0x00, 0x00, 0x20, 0x00, 0x00, 0xA0, 0x00, 0x10, 0x00, 0x01, 0x00, 0x00, 0x20
	.byte 0x28, 0x00, 0x20, 0x00, 0xC0, 0xFF, 0x20, 0x00, 0x10, 0x00, 0x01, 0x00, 0x00, 0x20, 0xC0, 0xFF
	.byte 0x20, 0x00, 0x28, 0x00, 0x20, 0x00, 0x10, 0x00, 0x09, 0x00, 0x09, 0x00, 0x00, 0x20, 0x00, 0xFF
	.byte 0x2A, 0x00, 0xC0, 0x00, 0x2A, 0x00, 0x20, 0x01, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x01, 0x00
	.byte 0x00, 0x20, 0xC0, 0x00, 0x2A, 0x00, 0xA0, 0x00, 0x2A, 0x00, 0x10, 0x00, 0x09, 0x00, 0x00, 0x20
	.byte 0xB0, 0x00, 0x10, 0x00, 0xD0, 0x00, 0x10, 0x00, 0x10, 0x00, 0x09, 0x00, 0x00, 0x20, 0xD0, 0x00
	.byte 0x10, 0x00, 0xB0, 0x00, 0x10, 0x00, 0x10, 0x00, 0x01, 0x00, 0x22, 0x00, 0x26, 0x00, 0x22, 0x00
	.byte 0x22, 0x00, 0x20, 0x00, 0x20, 0x00, 0x28, 0x00, 0x00, 0x00, 0x20, 0x00, 0x20, 0x00, 0x28, 0x00
	.byte 0xE0, 0x00, 0x08, 0x00, 0x1B, 0x00, 0x1C, 0x00, 0x1D, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x00, 0x00
	.byte 0x01, 0x00, 0x03, 0x00, 0x04, 0x00, 0x06, 0x00, 0x05, 0x00, 0x07, 0x00, 0x0A, 0x00, 0x0D, 0x00
	.byte 0x10, 0x00, 0x13, 0x00, 0x16, 0x00, 0x05, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x01, 0x00
	.byte 0x0B, 0x00, 0x00, 0x00, 0x01, 0x00, 0x07, 0x00, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x07, 0x00
	.byte 0x01, 0x00, 0x02, 0x00, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x07, 0x00
	.byte 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x07, 0x00, 0x03, 0x00, 0x04, 0x00, 0x07, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x01, 0x00, 0xFF, 0xFF, 0x02, 0x00
	.byte 0x07, 0x00, 0x0D, 0x00, 0x11, 0x00, 0x17, 0x00, 0x1B, 0x00, 0x21, 0x00, 0x25, 0x00, 0x2B, 0x00
	.byte 0x30, 0x00, 0x35, 0x00, 0x39, 0x00, 0x3F, 0x00, 0x43, 0x00, 0x0A, 0x00, 0x0A, 0x00, 0x13, 0x00
	.byte 0x0A, 0x00, 0x0B, 0x00, 0x0B, 0x00, 0x0B, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x14, 0x00, 0x0C, 0x00
	.byte 0x0D, 0x00, 0x0D, 0x00, 0x0D, 0x00, 0x0E, 0x00, 0x0E, 0x00, 0x0E, 0x00, 0x0F, 0x00, 0x0F, 0x00
	.byte 0x15, 0x00, 0x0F, 0x00, 0x10, 0x00, 0x10, 0x00, 0x10, 0x00, 0x12, 0x00, 0x1A, 0x00, 0x1B, 0x00
	.byte 0x1C, 0x00, 0x1D, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x20, 0x00, 0x21, 0x00, 0x22, 0x00, 0x23, 0x00
	.byte 0x24, 0x00, 0x25, 0x00, 0x26, 0x00, 0x27, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x03, 0x00, 0x03, 0x00, 0xE0, 0x69, 0x15, 0x02
	.byte 0xB8, 0x69, 0x15, 0x02, 0x90, 0x69, 0x15, 0x02, 0x68, 0x69, 0x15, 0x02, 0x40, 0x69, 0x15, 0x02
	.byte 0x18, 0x69, 0x15, 0x02, 0xF0, 0x68, 0x15, 0x02, 0xC8, 0x68, 0x15, 0x02, 0x0E, 0x00, 0x0F, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0xE8, 0x03, 0x00, 0x00, 0xDC, 0x05, 0x00, 0x00, 0xD0, 0x07, 0x00, 0x00
	.byte 0xC4, 0x09, 0x00, 0x00, 0xB8, 0x0B, 0x00, 0x00, 0xAC, 0x0D, 0x00, 0x00, 0xA0, 0x0F, 0x00, 0x00
	.byte 0x94, 0x11, 0x00, 0x00, 0x88, 0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE8, 0x03, 0x00, 0x00
	.byte 0xA0, 0x0F, 0x00, 0x00, 0x58, 0x1B, 0x00, 0x00, 0x10, 0x27, 0x00, 0x00, 0xE0, 0x2E, 0x00, 0x00
	.byte 0xB0, 0x36, 0x00, 0x00, 0x80, 0x3E, 0x00, 0x00, 0x50, 0x46, 0x00, 0x00, 0x20, 0x4E, 0x00, 0x00
	.byte 0x88, 0x13, 0x00, 0x00, 0x20, 0x4E, 0x00, 0x00, 0xB8, 0x88, 0x00, 0x00, 0xC8, 0xAF, 0x00, 0x00
	.byte 0xD8, 0xD6, 0x00, 0x00, 0xE8, 0xFD, 0x00, 0x00, 0xF8, 0x24, 0x01, 0x00, 0x80, 0x38, 0x01, 0x00
	.byte 0x08, 0x4C, 0x01, 0x00, 0x10, 0x27, 0x00, 0x00, 0x98, 0x3A, 0x00, 0x00, 0x20, 0x4E, 0x00, 0x00
	.byte 0xA8, 0x61, 0x00, 0x00, 0x30, 0x75, 0x00, 0x00, 0xD0, 0x84, 0x00, 0x00, 0x70, 0x94, 0x00, 0x00
	.byte 0x10, 0xA4, 0x00, 0x00, 0xC8, 0xAF, 0x00, 0x00, 0x11, 0x00, 0x12, 0x01, 0x14, 0x16, 0x13, 0x02
	.byte 0x21, 0x03, 0x22, 0x04, 0x23, 0x05, 0x31, 0x06, 0x32, 0x07, 0x34, 0x17, 0x33, 0x08, 0x41, 0x09
	.byte 0x42, 0x0A, 0x43, 0x0B, 0x51, 0x0C, 0x52, 0x0D, 0x53, 0x0E, 0x61, 0x0F, 0x62, 0x10, 0x64, 0x18
	.byte 0x63, 0x11, 0x71, 0x12, 0x72, 0x13, 0x73, 0x14, 0x81, 0x15, 0x91, 0x19, 0x91, 0x1A, 0x91, 0x1B
	.byte 0xA1, 0x1C, 0xA1, 0x1D, 0xA1, 0x1E, 0xA1, 0x1F, 0xA1, 0x20, 0xA1, 0x21, 0xA1, 0x22, 0xA1, 0x23
	.byte 0xA1, 0x24, 0xA1, 0x25, 0xA1, 0x26, 0xA1, 0x27, 0xA1, 0x28, 0xA1, 0x29, 0xA1, 0x2A, 0xA1, 0x2B
	.byte 0xA1, 0x2C, 0xA1, 0x2D, 0x00, 0x02, 0x02, 0x00, 0x02, 0x02, 0x02, 0x00, 0x01, 0x00, 0x02, 0x02
	.byte 0x00, 0x03, 0x03, 0x00, 0x03, 0x03, 0x00, 0x03, 0x03, 0x00, 0x04, 0x04, 0x00, 0x04, 0x04, 0x02
	.byte 0x00, 0x01, 0x00, 0x04, 0x04, 0x00, 0x05, 0x05, 0x00, 0x05, 0x05, 0x00, 0x05, 0x05, 0x00, 0x06
	.byte 0x06, 0x00, 0x06, 0x06, 0x00, 0x06, 0x06, 0x00, 0x07, 0x07, 0x00, 0x07, 0x07, 0x02, 0x00, 0x01
	.byte 0x00, 0x07, 0x07, 0x00, 0x08, 0x08, 0x00, 0x08, 0x08, 0x00, 0x08, 0x08, 0x00, 0x08, 0x08, 0x02
	.byte 0x00, 0x01, 0x02, 0x04, 0x04, 0x02, 0x00, 0x01, 0x03, 0x02, 0x00, 0x03, 0x02, 0x01, 0x03, 0x04
	.byte 0x00, 0x03, 0x03, 0x01, 0x03, 0x03, 0x00, 0x03, 0x04, 0x01, 0x03, 0x06, 0x00, 0x03, 0x06, 0x01
	.byte 0x02, 0x00, 0x01, 0x03, 0x05, 0x00, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x1E
	.byte 0x28, 0x32, 0x3C, 0x46, 0x50, 0x5A, 0x64, 0x01, 0x1E, 0x28, 0x32, 0x3C, 0x46, 0x50, 0x5A, 0x64
	.byte 0x01, 0x0F, 0x14, 0x19, 0x1E, 0x23, 0x28, 0x2D, 0x32, 0x01, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A
	.byte 0x0B, 0x0C, 0x01, 0x1E, 0x28, 0x32, 0x3C, 0x46, 0x50, 0x5A, 0x64, 0x01, 0x1E, 0x28, 0x32, 0x3C
	.byte 0x46, 0x50, 0x5A, 0x64, 0x01, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x01, 0x1E, 0x28
	.byte 0x32, 0x3C, 0x46, 0x50, 0x5A, 0x64, 0x01, 0x1E, 0x28, 0x32, 0x3C, 0x46, 0x50, 0x5A, 0x64, 0x01
	.byte 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x01, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B
	.byte 0x0C, 0x01, 0x1E, 0x28, 0x32, 0x3C, 0x46, 0x50, 0x5A, 0x64, 0x01, 0x1E, 0x28, 0x32, 0x3C, 0x46
	.byte 0x50, 0x5A, 0x64, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x01, 0x1E, 0x28, 0x32
	.byte 0x3C, 0x46, 0x50, 0x5A, 0x64, 0x01, 0x1E, 0x28, 0x32, 0x3C, 0x46, 0x50, 0x5A, 0x64, 0x01, 0x05
	.byte 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x01, 0x1E, 0x28, 0x32, 0x3C, 0x46, 0x50, 0x5A, 0x64
	.byte 0x01, 0x1E, 0x28, 0x32, 0x3C, 0x46, 0x50, 0x5A, 0x64, 0x01, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A
	.byte 0x0B, 0x0C, 0x01, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x01, 0x1E, 0x28, 0x32, 0x3C
	.byte 0x46, 0x50, 0x5A, 0x64, 0x01, 0x1E, 0x28, 0x32, 0x3C, 0x46, 0x50, 0x5A, 0x64, 0x01, 0x05, 0x06
	.byte 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x01, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x01
	.byte 0x0A, 0x14, 0x1E, 0x28, 0x32, 0x3C, 0x46, 0x50, 0x01, 0x0A, 0x14, 0x1E, 0x28, 0x32, 0x3C, 0x46
	.byte 0x50, 0x01, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x01, 0x1E, 0x28, 0x32, 0x3C, 0x46
	.byte 0x50, 0x5A, 0x64, 0x01, 0x05, 0x0A, 0x14, 0x1E, 0x28, 0x32, 0x3C, 0x46, 0x01, 0x05, 0x0A, 0x14
	.byte 0x1E, 0x28, 0x32, 0x3C, 0x46, 0x01, 0x02, 0x03, 0x05, 0x0A, 0x14, 0x1E, 0x28, 0x32, 0x01, 0x05
	.byte 0x0A, 0x14, 0x1E, 0x28, 0x32, 0x3C, 0x46, 0x01, 0x02, 0x03, 0x04, 0x05, 0x0A, 0x14, 0x1E, 0x28
	.byte 0x01, 0x02, 0x03, 0x04, 0x05, 0x0A, 0x14, 0x1E, 0x28, 0x01, 0x0A, 0x14, 0x1E, 0x28, 0x32, 0x3C
	.byte 0x46, 0x50, 0x01, 0x02, 0x05, 0x0A, 0x14, 0x1E, 0x28, 0x32, 0x3C, 0x01, 0x05, 0x06, 0x07, 0x08
	.byte 0x09, 0x0A, 0x0B, 0x0C, 0x01, 0x1E, 0x28, 0x32, 0x3C, 0x46, 0x50, 0x5A, 0x64, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x82, 0x00, 0x78, 0x00
	.byte 0x6E, 0x00, 0x64, 0x00, 0x5A, 0x00, 0x50, 0x00, 0x46, 0x00, 0x3C, 0x00, 0x82, 0x00, 0x78, 0x00
	.byte 0x6E, 0x00, 0x64, 0x00, 0x5A, 0x00, 0x50, 0x00, 0x46, 0x00, 0x3C, 0x00, 0xBE, 0x00, 0xB4, 0x00
	.byte 0xAA, 0x00, 0xA0, 0x00, 0x96, 0x00, 0x8C, 0x00, 0x82, 0x00, 0x78, 0x00, 0xA0, 0x00, 0x96, 0x00
	.byte 0x8C, 0x00, 0x82, 0x00, 0x78, 0x00, 0x6E, 0x00, 0x64, 0x00, 0x5A, 0x00, 0x96, 0x00, 0x8C, 0x00
	.byte 0x82, 0x00, 0x78, 0x00, 0x6E, 0x00, 0x64, 0x00, 0x5A, 0x00, 0x50, 0x00, 0x96, 0x00, 0x8C, 0x00
	.byte 0x82, 0x00, 0x78, 0x00, 0x6E, 0x00, 0x64, 0x00, 0x5A, 0x00, 0x50, 0x00, 0xA0, 0x00, 0x96, 0x00
	.byte 0x8C, 0x00, 0x82, 0x00, 0x78, 0x00, 0x6E, 0x00, 0x64, 0x00, 0x5A, 0x00, 0xA0, 0x00, 0x96, 0x00
	.byte 0x8C, 0x00, 0x82, 0x00, 0x78, 0x00, 0x6E, 0x00, 0x64, 0x00, 0x5A, 0x00, 0xBE, 0x00, 0xB4, 0x00
	.byte 0xAA, 0x00, 0xA0, 0x00, 0x96, 0x00, 0x8C, 0x00, 0x82, 0x00, 0x78, 0x00, 0x3C, 0x00, 0x37, 0x00
	.byte 0x32, 0x00, 0x2D, 0x00, 0x28, 0x00, 0x23, 0x00, 0x1E, 0x00, 0x19, 0x00, 0xAA, 0x00, 0xA0, 0x00
	.byte 0x96, 0x00, 0x8C, 0x00, 0x82, 0x00, 0x78, 0x00, 0x6E, 0x00, 0x64, 0x00, 0xAA, 0x00, 0xA0, 0x00
	.byte 0x96, 0x00, 0x8C, 0x00, 0x82, 0x00, 0x78, 0x00, 0x6E, 0x00, 0x64, 0x00, 0xAA, 0x00, 0xA0, 0x00
	.byte 0x96, 0x00, 0x8C, 0x00, 0x82, 0x00, 0x78, 0x00, 0x6E, 0x00, 0x64, 0x00, 0xAA, 0x00, 0xA0, 0x00
	.byte 0x96, 0x00, 0x8C, 0x00, 0x82, 0x00, 0x78, 0x00, 0x6E, 0x00, 0x64, 0x00, 0x96, 0x00, 0x8C, 0x00
	.byte 0x82, 0x00, 0x78, 0x00, 0x6E, 0x00, 0x64, 0x00, 0x5A, 0x00, 0x50, 0x00, 0xAA, 0x00, 0xA0, 0x00
	.byte 0x96, 0x00, 0x8C, 0x00, 0x82, 0x00, 0x78, 0x00, 0x6E, 0x00, 0x64, 0x00, 0xC8, 0x00, 0xBE, 0x00
	.byte 0xB4, 0x00, 0xAA, 0x00, 0xA0, 0x00, 0x96, 0x00, 0x8C, 0x00, 0x82, 0x00, 0xBE, 0x00, 0xB4, 0x00
	.byte 0xAA, 0x00, 0xA0, 0x00, 0x96, 0x00, 0x8C, 0x00, 0x82, 0x00, 0x78, 0x00, 0xBE, 0x00, 0xB4, 0x00
	.byte 0xAA, 0x00, 0xA0, 0x00, 0x96, 0x00, 0x8C, 0x00, 0x82, 0x00, 0x78, 0x00, 0x3C, 0x00, 0x37, 0x00
	.byte 0x32, 0x00, 0x2D, 0x00, 0x28, 0x00, 0x23, 0x00, 0x1E, 0x00, 0x19, 0x00, 0xC8, 0x00, 0xBE, 0x00
	.byte 0xB4, 0x00, 0xAA, 0x00, 0xA0, 0x00, 0x96, 0x00, 0x8C, 0x00, 0x82, 0x00, 0xBE, 0x00, 0xB4, 0x00
	.byte 0xAA, 0x00, 0xA0, 0x00, 0x96, 0x00, 0x8C, 0x00, 0x82, 0x00, 0x78, 0x00, 0xDC, 0x00, 0xD2, 0x00
	.byte 0xC8, 0x00, 0xBE, 0x00, 0xB4, 0x00, 0xAA, 0x00, 0xA0, 0x00, 0x96, 0x00, 0xFA, 0x00, 0xF0, 0x00
	.byte 0xE6, 0x00, 0xDC, 0x00, 0xD2, 0x00, 0xC8, 0x00, 0xBE, 0x00, 0xB4, 0x00, 0xB8, 0x01, 0xA4, 0x01
	.byte 0x90, 0x01, 0x7C, 0x01, 0x68, 0x01, 0x54, 0x01, 0x40, 0x01, 0x2C, 0x01, 0x46, 0x00, 0x41, 0x00
	.byte 0x3C, 0x00, 0x37, 0x00, 0x32, 0x00, 0x2D, 0x00, 0x28, 0x00, 0x23, 0x00, 0x55, 0x00, 0x50, 0x00
	.byte 0x4B, 0x00, 0x46, 0x00, 0x41, 0x00, 0x3C, 0x00, 0x37, 0x00, 0x32, 0x00, 0x3C, 0x00, 0x37, 0x00
	.byte 0x32, 0x00, 0x2D, 0x00, 0x28, 0x00, 0x23, 0x00, 0x1E, 0x00, 0x19, 0x00, 0x50, 0x00, 0x4B, 0x00
	.byte 0x46, 0x00, 0x41, 0x00, 0x3C, 0x00, 0x37, 0x00, 0x32, 0x00, 0x2D, 0x00, 0x41, 0x00, 0x3C, 0x00
	.byte 0x37, 0x00, 0x32, 0x00, 0x2D, 0x00, 0x28, 0x00, 0x23, 0x00, 0x1E, 0x00, 0x8C, 0x00, 0x82, 0x00
	.byte 0x78, 0x00, 0x6E, 0x00, 0x64, 0x00, 0x5A, 0x00, 0x50, 0x00, 0x46, 0x00, 0x32, 0x00, 0x2D, 0x00
	.byte 0x28, 0x00, 0x23, 0x00, 0x1E, 0x00, 0x19, 0x00, 0x14, 0x00, 0x0F, 0x00, 0x4B, 0x00, 0x46, 0x00
	.byte 0x41, 0x00, 0x3C, 0x00, 0x37, 0x00, 0x32, 0x00, 0x2D, 0x00, 0x28, 0x00, 0x46, 0x00, 0x41, 0x00
	.byte 0x3C, 0x00, 0x37, 0x00, 0x32, 0x00, 0x2D, 0x00, 0x28, 0x00, 0x23, 0x00, 0x41, 0x00, 0x3C, 0x00
	.byte 0x37, 0x00, 0x32, 0x00, 0x2D, 0x00, 0x28, 0x00, 0x23, 0x00, 0x1E, 0x00, 0x4B, 0x00, 0x46, 0x00
	.byte 0x41, 0x00, 0x3C, 0x00, 0x37, 0x00, 0x32, 0x00, 0x2D, 0x00, 0x28, 0x00, 0x46, 0x00, 0x41, 0x00
	.byte 0x3C, 0x00, 0x37, 0x00, 0x32, 0x00, 0x2D, 0x00, 0x28, 0x00, 0x23, 0x00, 0x41, 0x00, 0x3C, 0x00
	.byte 0x37, 0x00, 0x32, 0x00, 0x2D, 0x00, 0x28, 0x00, 0x23, 0x00, 0x1E, 0x00, 0x82, 0x00, 0x78, 0x00
	.byte 0x6E, 0x00, 0x64, 0x00, 0x5A, 0x00, 0x50, 0x00, 0x46, 0x00, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x88, 0x13
	.byte 0x10, 0x27, 0x98, 0x3A, 0x20, 0x4E, 0xA8, 0x61, 0x30, 0x75, 0xB8, 0x88, 0x40, 0x9C, 0x01, 0x00
	.byte 0x88, 0x13, 0x10, 0x27, 0x98, 0x3A, 0x20, 0x4E, 0xA8, 0x61, 0x30, 0x75, 0xB8, 0x88, 0x40, 0x9C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0xF4, 0x01, 0xE8, 0x03, 0x88, 0x13, 0x10, 0x27, 0x98, 0x3A
	.byte 0x20, 0x4E, 0xA8, 0x61, 0x30, 0x75, 0x01, 0x00, 0x88, 0x13, 0x10, 0x27, 0x98, 0x3A, 0x20, 0x4E
	.byte 0xA8, 0x61, 0x30, 0x75, 0xB8, 0x88, 0x40, 0x9C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0xF4, 0x01, 0xE8, 0x03
	.byte 0x88, 0x13, 0x10, 0x27, 0x98, 0x3A, 0x20, 0x4E, 0xA8, 0x61, 0x30, 0x75, 0x01, 0x00, 0xF4, 0x01
	.byte 0xE8, 0x03, 0x88, 0x13, 0x10, 0x27, 0x98, 0x3A, 0x20, 0x4E, 0xA8, 0x61, 0x30, 0x75, 0x01, 0x00
	.byte 0x2C, 0x01, 0xF4, 0x01, 0xE8, 0x03, 0xD0, 0x07, 0xA0, 0x0F, 0x70, 0x17, 0x40, 0x1F, 0x10, 0x27
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x01, 0x00, 0x88, 0x13, 0x10, 0x27, 0x98, 0x3A, 0x20, 0x4E, 0xA8, 0x61, 0x30, 0x75
	.byte 0xB8, 0x88, 0x40, 0x9C, 0x01, 0x00, 0x88, 0x13, 0x10, 0x27, 0x98, 0x3A, 0x20, 0x4E, 0xA8, 0x61
	.byte 0x30, 0x75, 0xB8, 0x88, 0x40, 0x9C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x88, 0x13, 0x10, 0x27, 0x98, 0x3A
	.byte 0x20, 0x4E, 0xA8, 0x61, 0x30, 0x75, 0xB8, 0x88, 0x40, 0x9C, 0x01, 0x00, 0x88, 0x13, 0x10, 0x27
	.byte 0x98, 0x3A, 0x20, 0x4E, 0xA8, 0x61, 0x30, 0x75, 0xB8, 0x88, 0x40, 0x9C, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
	.byte 0xF4, 0x01, 0xE8, 0x03, 0x88, 0x13, 0x10, 0x27, 0x98, 0x3A, 0x20, 0x4E, 0xA8, 0x61, 0x30, 0x75
	.byte 0x01, 0x00, 0xF4, 0x01, 0xE8, 0x03, 0x88, 0x13, 0x10, 0x27, 0x98, 0x3A, 0x20, 0x4E, 0xA8, 0x61
	.byte 0x30, 0x75, 0x01, 0x00, 0x2C, 0x01, 0xF4, 0x01, 0xE8, 0x03, 0xD0, 0x07, 0xA0, 0x0F, 0x70, 0x17
	.byte 0x40, 0x1F, 0x10, 0x27, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0xF4, 0x01, 0xE8, 0x03, 0x88, 0x13, 0x10, 0x27
	.byte 0x98, 0x3A, 0x20, 0x4E, 0xA8, 0x61, 0x30, 0x75, 0x01, 0x00, 0xF4, 0x01, 0xE8, 0x03, 0x88, 0x13
	.byte 0x10, 0x27, 0x98, 0x3A, 0x20, 0x4E, 0xA8, 0x61, 0x30, 0x75, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
	.byte 0xF4, 0x01, 0xE8, 0x03, 0xD0, 0x07, 0xA0, 0x0F, 0x70, 0x17, 0x40, 0x1F, 0x10, 0x27, 0xE0, 0x2E
	.byte 0x01, 0x00, 0xF4, 0x01, 0xD0, 0x07, 0x88, 0x13, 0x40, 0x1F, 0xF8, 0x2A, 0xB0, 0x36, 0x68, 0x42
	.byte 0x20, 0x4E, 0x01, 0x00, 0xF4, 0x01, 0xE8, 0x03, 0xD0, 0x07, 0xA0, 0x0F, 0x70, 0x17, 0x40, 0x1F
	.byte 0x10, 0x27, 0xE0, 0x2E, 0x01, 0x00, 0xF4, 0x01, 0xE8, 0x03, 0x88, 0x13, 0x10, 0x27, 0x98, 0x3A
	.byte 0x20, 0x4E, 0xA8, 0x61, 0x30, 0x75, 0x01, 0x00, 0xF4, 0x01, 0xE8, 0x03, 0x88, 0x13, 0x10, 0x27
	.byte 0x98, 0x3A, 0x20, 0x4E, 0xA8, 0x61, 0x30, 0x75, 0x01, 0x00, 0xF4, 0x01, 0xE8, 0x03, 0xD0, 0x07
	.byte 0xA0, 0x0F, 0x70, 0x17, 0x40, 0x1F, 0x10, 0x27, 0xE0, 0x2E, 0x01, 0x00, 0x64, 0x00, 0x2C, 0x01
	.byte 0xF4, 0x01, 0xE8, 0x03, 0xD0, 0x07, 0xB8, 0x0B, 0xA0, 0x0F, 0x88, 0x13, 0x01, 0x00, 0xF4, 0x01
	.byte 0xE8, 0x03, 0x88, 0x13, 0x10, 0x27, 0x98, 0x3A, 0x20, 0x4E, 0xA8, 0x61, 0x30, 0x75, 0x01, 0x00
	.byte 0x64, 0x00, 0x2C, 0x01, 0xF4, 0x01, 0xE8, 0x03, 0xD0, 0x07, 0xB8, 0x0B, 0xA0, 0x0F, 0x88, 0x13
	.byte 0x01, 0x00, 0x2C, 0x01, 0xF4, 0x01, 0xE8, 0x03, 0xD0, 0x07, 0xA0, 0x0F, 0x70, 0x17, 0x40, 0x1F
	.byte 0x10, 0x27, 0x01, 0x00, 0xF4, 0x01, 0xE8, 0x03, 0x88, 0x13, 0x10, 0x27, 0x98, 0x3A, 0x20, 0x4E
	.byte 0xA8, 0x61, 0x30, 0x75, 0x01, 0x00, 0x2C, 0x01, 0xF4, 0x01, 0xE8, 0x03, 0xD0, 0x07, 0xA0, 0x0F
	.byte 0x70, 0x17, 0x40, 0x1F, 0x10, 0x27, 0x01, 0x00, 0xF4, 0x01, 0xD0, 0x07, 0x88, 0x13, 0x40, 0x1F
	.byte 0xF8, 0x2A, 0xB0, 0x36, 0x68, 0x42, 0x20, 0x4E, 0x01, 0x00, 0x88, 0x13, 0x10, 0x27, 0x98, 0x3A
	.byte 0x20, 0x4E, 0xA8, 0x61, 0x30, 0x75, 0xB8, 0x88, 0x40, 0x9C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x04, 0x02, 0x00, 0x01, 0x02, 0x00
	.byte 0x01, 0x05, 0x02, 0x00, 0x01, 0x02, 0x00, 0x01, 0x02, 0x00, 0x01, 0x05, 0x02, 0x00, 0x01, 0x02
	.byte 0x03, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05
	.byte 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x00, 0x00, 0x1C, 0x00, 0x1E, 0x00, 0x1D, 0x00, 0x1F, 0x00
	.byte 0x21, 0x00, 0x20, 0x00, 0x22, 0x00, 0x24, 0x00, 0x23, 0x00, 0x31, 0x00, 0x33, 0x00, 0x32, 0x00
	.byte 0x26, 0x14, 0x27, 0x15, 0x28, 0x16, 0x29, 0x17, 0x2A, 0x18, 0x2B, 0x19, 0x2C, 0x1A, 0x2E, 0x1B
	.byte 0x30, 0x2F, 0x4B, 0x37, 0x4C, 0x38, 0x4D, 0x39, 0x4E, 0x3A, 0x4F, 0x3B, 0x50, 0x3C, 0x51, 0x3D
	.byte 0x52, 0x3E, 0x53, 0x3F, 0x54, 0x40, 0x55, 0x41, 0x56, 0x42, 0x57, 0x43, 0x58, 0x44, 0x59, 0x45
	.byte 0x5A, 0x46, 0x5B, 0x47, 0x5C, 0x48, 0x5D, 0x49, 0x01, 0x01, 0x00, 0x01, 0x02, 0x01, 0x09, 0x01
	.byte 0x16, 0x01, 0x03, 0x02, 0x02, 0x01, 0x03, 0x02, 0x02, 0x04, 0x02, 0x03, 0x05, 0x03, 0x01, 0x06
	.byte 0x03, 0x02, 0x07, 0x0A, 0x01, 0x17, 0x03, 0x03, 0x08, 0x04, 0x01, 0x09, 0x04, 0x02, 0x0A, 0x04
	.byte 0x03, 0x0B, 0x05, 0x01, 0x0C, 0x05, 0x02, 0x0D, 0x05, 0x03, 0x0E, 0x06, 0x01, 0x0F, 0x06, 0x02
	.byte 0x10, 0x0B, 0x01, 0x18, 0x06, 0x03, 0x11, 0x07, 0x01, 0x12, 0x07, 0x02, 0x13, 0x07, 0x03, 0x14
	.byte 0x08, 0x01, 0x15, 0x0C, 0x01, 0x19, 0x0D, 0x01, 0x1A, 0x0E, 0x01, 0x1B, 0x0F, 0x01, 0x1C, 0x10
	.byte 0x01, 0x1D, 0x11, 0x01, 0x1E, 0x12, 0x01, 0x1F, 0x13, 0x01, 0x20, 0x14, 0x01, 0x21, 0x15, 0x01
	.byte 0x22, 0x16, 0x01, 0x23, 0x17, 0x01, 0x24, 0x18, 0x01, 0x25, 0x19, 0x01, 0x26, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1A, 0x01, 0x2B, 0x1B, 0x01, 0x2C, 0x1C
	.byte 0x01, 0x2D, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00, 0x03, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00
	.byte 0x06, 0x00, 0x03, 0x00, 0x07, 0x00, 0x08, 0x00, 0x0A, 0x00, 0x03, 0x00, 0x0B, 0x00, 0x0C, 0x00
	.byte 0x0D, 0x00, 0x03, 0x00, 0x0E, 0x00, 0x0F, 0x00, 0x10, 0x00, 0x03, 0x00, 0x11, 0x00, 0x12, 0x00
	.byte 0x14, 0x00, 0x03, 0x00, 0x15, 0x00, 0x16, 0x00, 0x17, 0x00, 0x01, 0x00, 0x18, 0x00, 0x2E, 0x00
	.byte 0x2E, 0x00, 0x01, 0x00, 0x02, 0x00, 0x2E, 0x00, 0x2E, 0x00, 0x01, 0x00, 0x09, 0x00, 0x2E, 0x00
	.byte 0x2E, 0x00, 0x01, 0x00, 0x13, 0x00, 0x2E, 0x00, 0x2E, 0x00, 0x01, 0x00, 0x19, 0x00, 0x2E, 0x00
	.byte 0x2E, 0x00, 0x01, 0x00, 0x1A, 0x00, 0x2E, 0x00, 0x2E, 0x00, 0x01, 0x00, 0x1B, 0x00, 0x2E, 0x00
	.byte 0x2E, 0x00, 0x01, 0x00, 0x1C, 0x00, 0x2E, 0x00, 0x2E, 0x00, 0x01, 0x00, 0x1D, 0x00, 0x2E, 0x00
	.byte 0x2E, 0x00, 0x01, 0x00, 0x1E, 0x00, 0x2E, 0x00, 0x2E, 0x00, 0x01, 0x00, 0x1F, 0x00, 0x2E, 0x00
	.byte 0x2E, 0x00, 0x01, 0x00, 0x20, 0x00, 0x2E, 0x00, 0x2E, 0x00, 0x01, 0x00, 0x21, 0x00, 0x2E, 0x00
	.byte 0x2E, 0x00, 0x01, 0x00, 0x22, 0x00, 0x2E, 0x00, 0x2E, 0x00, 0x01, 0x00, 0x23, 0x00, 0x2E, 0x00
	.byte 0x2E, 0x00, 0x01, 0x00, 0x24, 0x00, 0x2E, 0x00, 0x2E, 0x00, 0x01, 0x00, 0x25, 0x00, 0x2E, 0x00
	.byte 0x2E, 0x00, 0x01, 0x00, 0x26, 0x00, 0x2E, 0x00, 0x2E, 0x00, 0x01, 0x00, 0x2B, 0x00, 0x2E, 0x00
	.byte 0x2E, 0x00, 0x01, 0x00, 0x2C, 0x00, 0x2E, 0x00, 0x2E, 0x00, 0x01, 0x00, 0x2D, 0x00, 0x2E, 0x00
	.byte 0x2E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x0E, 0x0F, 0x10, 0x11, 0x00, 0x01, 0x02, 0x03, 0x0E, 0x0F, 0x10, 0x11, 0x12, 0x13, 0x14, 0x17
	.byte 0x18, 0x19, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x02, 0x02, 0x03, 0x03, 0x04, 0x04, 0x05, 0x05
	.byte 0x06, 0x06, 0x07, 0x08, 0x09, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01
	.byte 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x28, 0x00, 0x3B, 0x00
	.byte 0x20, 0x00, 0x36, 0x00, 0x5A, 0x00, 0x62, 0x00, 0x5A, 0x00, 0x62, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x80, 0x00, 0x9F, 0x00, 0x2C, 0x00, 0x9E, 0x00, 0xD4, 0x00, 0x9E, 0x00, 0x07, 0x00, 0xF0, 0xFF
	.byte 0xF2, 0xFF, 0xFF, 0xFF, 0x0C, 0x00, 0x07, 0x00, 0x01, 0x00, 0xF2, 0xFF, 0x10, 0x00, 0x0C, 0x00
	.byte 0x02, 0x00, 0x01, 0x00, 0x00, 0x00, 0x52, 0x00, 0x1A, 0x00, 0x03, 0x00, 0x01, 0x00, 0x00, 0x00
	.byte 0x52, 0x00, 0x1A, 0x00, 0x04, 0x00, 0x00, 0x00, 0x01, 0x00, 0x90, 0x00, 0x1A, 0x00, 0x01, 0x00
	.byte 0x0E, 0x00, 0x28, 0x00, 0x35, 0x00, 0x01, 0x01, 0x03, 0x00, 0x01, 0x00, 0x15, 0x00, 0x20, 0x00
	.byte 0x30, 0x00, 0x02, 0x01, 0x04, 0x00, 0x01, 0x00, 0x00, 0x00, 0x5A, 0x00, 0x56, 0x00, 0x05, 0x01
	.byte 0x01, 0x00, 0x01, 0x00, 0x03, 0x00, 0x5A, 0x00, 0x6E, 0x00, 0x06, 0x01, 0x01, 0x00, 0x02, 0x00
	.byte 0x00, 0x00, 0x38, 0x00, 0x90, 0x00, 0x07, 0x01, 0x01, 0x00, 0x01, 0x00, 0x06, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x08, 0x01, 0x02, 0x00, 0x01, 0x00, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x01
	.byte 0x02, 0x00, 0x03, 0x00, 0x02, 0x00, 0x00, 0x00, 0x3E, 0x00, 0x03, 0x01, 0x02, 0x00, 0xFF, 0xFF
	.byte 0x00, 0x00, 0x60, 0x00, 0x60, 0x00, 0x04, 0x01, 0x00, 0x00, 0x02, 0x00, 0x03, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x0A, 0x01, 0x02, 0x00, 0x01, 0x00, 0x1B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0B, 0x01
	.byte 0x01, 0x00, 0x01, 0x00, 0x1B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0B, 0x01, 0x01, 0x00, 0x00, 0x00
	.byte 0x27, 0x28, 0x29, 0x2A, 0x00, 0x01, 0x04, 0x05, 0x07, 0x08, 0x0B, 0x0C, 0x0E, 0x0F, 0x11, 0x12
	.byte 0x15, 0x16, 0x2B, 0x2C, 0x2D, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x50, 0x00, 0x64, 0x00
	.byte 0x01, 0x01, 0x03, 0x00, 0x01, 0x00, 0x01, 0x00, 0xB0, 0x00, 0x64, 0x00, 0x02, 0x01, 0x03, 0x00
	.byte 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x01, 0x02, 0x00, 0x01, 0x00, 0x03, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x04, 0x01, 0x04, 0x00, 0x02, 0x00, 0x00, 0x00, 0x28, 0x00, 0x88, 0x00
	.byte 0x05, 0x01, 0x01, 0x00, 0x02, 0x00, 0x03, 0x00, 0x88, 0x00, 0x88, 0x00, 0x06, 0x01, 0x01, 0x00
	.byte 0x02, 0x00, 0x06, 0x00, 0x80, 0x00, 0x34, 0x00, 0x07, 0x01, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x18, 0x00, 0x06, 0x00, 0x0D, 0x00, 0x01, 0x00, 0x05, 0x00, 0x0C, 0x00, 0x01, 0x00, 0x00, 0x00
	.byte 0x04, 0x00, 0x01, 0x00, 0x0F, 0x01, 0x00, 0x00, 0x05, 0x00, 0x0B, 0x00, 0x01, 0x00, 0x00, 0x00
	.byte 0xCA, 0x00, 0x14, 0x00, 0x0E, 0x01, 0x01, 0x00, 0x05, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
	.byte 0x18, 0x00, 0x01, 0x00, 0x0D, 0x01, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
	.byte 0x12, 0x00, 0x01, 0x00, 0x0D, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x14, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00
	.byte 0x14, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x28, 0x00, 0x00, 0x00, 0x00, 0x18, 0x00, 0x00
	.byte 0x08, 0x00, 0x00, 0x00, 0x11, 0x00, 0x12, 0x00, 0x13, 0x00, 0x14, 0x00, 0x15, 0x00, 0x16, 0x00
	.byte 0x17, 0x00, 0x18, 0x00, 0x19, 0x00, 0x10, 0x00, 0x08, 0x00, 0x04, 0x00, 0x00, 0x00, 0x04, 0x00
	.byte 0x08, 0x00, 0x08, 0x00, 0x04, 0x00, 0x00, 0x00, 0x04, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x03, 0x00, 0x02, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, 0x00, 0x03, 0x00, 0x00, 0x00
a1234567890: // 0x0217DFE0
	.asciz "1234567890"
_0217DFEB:
	.byte 0x00, 0x6D, 0x7A, 0x16, 0x02
	.byte 0x02, 0x00, 0x00, 0x00, 0x29, 0x7E, 0x16, 0x02, 0x03, 0x00, 0x00, 0x00, 0x0D, 0x77, 0x16, 0x02
	.byte 0x04, 0x00, 0x00, 0x00, 0x11, 0x7A, 0x16, 0x02, 0x05, 0x00, 0x00, 0x00, 0x21, 0x81, 0x16, 0x02
	.byte 0x0D, 0x00, 0x00, 0x00, 0x61, 0x78, 0x16, 0x02, 0x0E, 0x00, 0x00, 0x00, 0xB5, 0x90, 0x16, 0x02
	.byte 0x0F, 0x00, 0x00, 0x00, 0x31, 0x8D, 0x16, 0x02, 0x12, 0x00, 0x00, 0x00, 0xD5, 0x8D, 0x16, 0x02
	.byte 0x13, 0x00, 0x00, 0x00, 0x31, 0x8F, 0x16, 0x02, 0x14, 0x00, 0x00, 0x00, 0xAD, 0x87, 0x16, 0x02
	.byte 0x10, 0x00, 0x00, 0x00, 0x6D, 0x88, 0x16, 0x02, 0x0B, 0x00, 0x00, 0x00, 0xA1, 0x88, 0x16, 0x02
	.byte 0x0C, 0x00, 0x00, 0x00, 0xD5, 0x88, 0x16, 0x02, 0x11, 0x00, 0x00, 0x00, 0xC9, 0x89, 0x16, 0x02
	.byte 0x0B, 0x00, 0x00, 0x00, 0xFD, 0x89, 0x16, 0x02, 0x0C, 0x00, 0x00, 0x00, 0x5D, 0x7B, 0x16, 0x02
	.byte 0x06, 0x00, 0x00, 0x00, 0x81, 0x7C, 0x16, 0x02, 0x0B, 0x00, 0x00, 0x00, 0xD9, 0x7C, 0x16, 0x02
	.byte 0x0C, 0x00, 0x00, 0x00, 0x35, 0x7D, 0x16, 0x02, 0x07, 0x00, 0x00, 0x00, 0x4D, 0x7F, 0x16, 0x02
	.byte 0x0B, 0x00, 0x00, 0x00, 0xAD, 0x7F, 0x16, 0x02, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0xC0, 0x00, 0x10, 0x00, 0x01, 0x00, 0x01, 0x00, 0x90, 0xFF, 0x00, 0x00, 0x03, 0x03, 0x01, 0x00
	.byte 0x01, 0x00, 0x90, 0xFF, 0x00, 0x00, 0x02, 0x03, 0x01, 0x00, 0x09, 0x00, 0xA0, 0xFF, 0x00, 0x00
	.byte 0x07, 0x02, 0x01, 0x00, 0x0A, 0x00, 0xA0, 0xFF, 0x00, 0x00, 0x07, 0x02, 0x01, 0x00, 0x0B, 0x00
	.byte 0xA0, 0xFF, 0x00, 0x00, 0x07, 0x02, 0x01, 0x00, 0x0C, 0x00, 0xA0, 0xFF, 0x00, 0x00, 0x07, 0x02
	.byte 0x01, 0x00, 0x0D, 0x00, 0xA0, 0xFF, 0x00, 0x00, 0x07, 0x02, 0x00, 0x00, 0x74, 0x06, 0x17, 0x02
	.byte 0xA4, 0x07, 0x17, 0x02, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x04, 0x06, 0x08, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x0C, 0x00, 0x18, 0x00, 0x18, 0x00, 0x0C, 0x00, 0x03, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00
	.byte 0x01, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00, 0x02, 0x00, 0x00, 0x00
	.byte 0x08, 0x00, 0x0F, 0x00, 0x08, 0x00, 0x07, 0x00, 0x07, 0x00, 0x07, 0x00, 0x07, 0x00, 0x03, 0x00
	.byte 0x08, 0x00, 0x00, 0x00, 0x03, 0x00, 0x25, 0x00, 0x1A, 0x00, 0x20, 0x00, 0x17, 0x00, 0x18, 0x00
	.byte 0x09, 0x00, 0x00, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00
	.byte 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x2D, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x18, 0x00, 0x24, 0x00, 0xE8, 0x00, 0x3C, 0x00, 0x18, 0x00, 0x3C, 0x00
	.byte 0xE8, 0x00, 0x54, 0x00, 0x18, 0x00, 0x54, 0x00, 0xE8, 0x00, 0x6C, 0x00, 0x18, 0x00, 0x6C, 0x00
	.byte 0xE8, 0x00, 0x84, 0x00, 0x18, 0x00, 0x84, 0x00, 0xE8, 0x00, 0x9C, 0x00, 0x00, 0x00, 0x60, 0x00
	.byte 0x18, 0x00, 0x78, 0x00, 0xE8, 0x00, 0x60, 0x00, 0x00, 0x01, 0x78, 0x00, 0x78, 0x00, 0xA0, 0x00
	.byte 0xE8, 0x00, 0xB0, 0x00, 0x06, 0x05, 0x00, 0x18, 0x06, 0x00, 0x00, 0x08, 0x14, 0x00, 0x00, 0x00
	.byte 0x04, 0x00, 0x00, 0x00, 0x02, 0x15, 0x00, 0x00, 0x02, 0x15, 0x01, 0x00, 0x00, 0x04, 0x02, 0x00
	.byte 0x00, 0x04, 0x02, 0x00, 0x01, 0x18, 0x03, 0x00, 0x01, 0x19, 0x04, 0x00, 0x02, 0x1E, 0x05, 0x00
	.byte 0x02, 0x1E, 0x05, 0x00, 0x01, 0x0F, 0x06, 0x00, 0x00, 0x01, 0x07, 0x00, 0x00, 0x02, 0x08, 0x00
	.byte 0x00, 0x25, 0x00, 0x00, 0x01, 0x1C, 0x01, 0x00, 0x00, 0x21, 0x02, 0x00, 0x00, 0x22, 0x03, 0x00
	.byte 0x01, 0x1A, 0x04, 0x00, 0x01, 0x1B, 0x05, 0x00, 0x00, 0x00, 0x06, 0x00, 0x05, 0x06, 0xA0, 0x00
	.byte 0x00, 0x08, 0x18, 0x00, 0x88, 0x00, 0x00, 0x18, 0x50, 0x00, 0x88, 0x00, 0x50, 0x00, 0x18, 0x00
	.byte 0x50, 0x00, 0x06, 0x00, 0x14, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x40, 0x20, 0x06
	.byte 0x00, 0x48, 0x20, 0x06, 0x02, 0x15, 0x00, 0x02, 0x15, 0x01, 0x00, 0x04, 0x02, 0x00, 0x04, 0x02
	.byte 0x01, 0x10, 0x03, 0x02, 0x1E, 0x04, 0x02, 0x1E, 0x04, 0x01, 0x0F, 0x05, 0x01, 0x11, 0x06, 0x00
	.byte 0x01, 0x07, 0x00, 0x02, 0x08, 0x00, 0x1F, 0x00, 0x00, 0x20, 0x01, 0x01, 0x12, 0x02, 0x01, 0x14
	.byte 0x03, 0x00, 0x25, 0x04, 0x01, 0x16, 0x05, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x02, 0x02
	.byte 0x02, 0x03, 0x03, 0x03, 0x04, 0x04, 0x04, 0x05, 0x05, 0x05, 0x06, 0x06, 0x06, 0x08, 0x09, 0x07
	.byte 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07
	.byte 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x00, 0x00, 0x03, 0x03, 0x03, 0x04, 0x04, 0x04, 0x05, 0x05
	.byte 0x05, 0x06, 0x06, 0x06, 0x07, 0x07, 0x07, 0x08, 0x08, 0x08, 0x09, 0x09, 0x09, 0x0A, 0x0B, 0x0C
	.byte 0x0D, 0x0E, 0x0F, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1B
	.byte 0x1B, 0x1B, 0x1B, 0x1C, 0x1D, 0x1E, 0x00, 0x00, 0x14, 0x14, 0x14, 0x15, 0x15, 0x15, 0x16, 0x16
	.byte 0x16, 0x17, 0x17, 0x17, 0x18, 0x18, 0x18, 0x19, 0x19, 0x19, 0x1A, 0x1A, 0x1A
a789Abcdefffffg: // 0x0217E2ED
	.asciz "/789:;<=>?@ABCDEFFFFFGHI"
_0217E307:
	.byte 0x00, 0x1E, 0x21, 0x24, 0x1E, 0x21, 0x24, 0x1E, 0x21
	.byte 0x24, 0x1E, 0x21, 0x24, 0x1E, 0x21, 0x24, 0x1E, 0x21, 0x24, 0x1E, 0x21
a33333333333333: // 0x0217E31C
	.asciz "$$$33333333333333333333333"
_0217E337:
	.byte 0x00, 0x68, 0x00, 0x48, 0x00, 0x94, 0x00, 0x94, 0x00
	.byte 0x00, 0x02, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x33, 0x00, 0x00, 0x00, 0x37, 0x01, 0x00
	.byte 0x00, 0x31, 0x02, 0x00, 0x00, 0x0C, 0x03, 0x00, 0x00, 0x20, 0x04, 0x00, 0x00, 0x23, 0x05, 0x00
	.byte 0x00, 0x29, 0x06, 0x00, 0x00, 0x0D, 0x07, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x51, 0x09, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00
	.byte 0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x01, 0x00, 0x03, 0x00, 0x00, 0x00, 0x03, 0x00, 0x01, 0x00
	.byte 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x05, 0x00
	.byte 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x01, 0x00
	.byte 0x04, 0x00, 0x05, 0x00, 0x07, 0x00, 0x08, 0x00, 0x0B, 0x00, 0x0C, 0x00, 0x0E, 0x00, 0x0F, 0x00
	.byte 0x11, 0x00, 0x12, 0x00, 0x15, 0x00, 0x16, 0x00, 0x00, 0x00, 0x01, 0x00, 0x03, 0x00, 0x04, 0x00
	.byte 0x05, 0x00, 0x06, 0x00, 0x07, 0x00, 0x08, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x0C, 0x00, 0x0D, 0x00
	.byte 0x0E, 0x00, 0x0F, 0x00, 0x10, 0x00, 0x11, 0x00, 0x12, 0x00, 0x14, 0x00, 0x15, 0x00, 0x16, 0x00
	.byte 0x17, 0x00, 0x18, 0x00, 0x2E, 0x00, 0x09, 0x00, 0x13, 0x00, 0x19, 0x00, 0x1A, 0x00, 0x1B, 0x00
	.byte 0x1C, 0x00, 0x1D, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x20, 0x00, 0x21, 0x00, 0x22, 0x00, 0x23, 0x00
	.byte 0x24, 0x00, 0x25, 0x00, 0x26, 0x00, 0x27, 0x00, 0x28, 0x00, 0x29, 0x00, 0x2A, 0x00, 0x00, 0x00
	.byte 0x01, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, 0x00, 0x07, 0x00, 0x08, 0x00, 0x0A, 0x00
	.byte 0x0B, 0x00, 0x0C, 0x00, 0x0D, 0x00, 0x0E, 0x00, 0x0F, 0x00, 0x10, 0x00, 0x11, 0x00, 0x12, 0x00
	.byte 0x14, 0x00, 0x15, 0x00, 0x16, 0x00, 0x17, 0x00, 0x18, 0x00, 0x2E, 0x00, 0x09, 0x00, 0x13, 0x00
	.byte 0x19, 0x00, 0x1A, 0x00, 0x1B, 0x00, 0x1C, 0x00, 0x1D, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x20, 0x00
	.byte 0x21, 0x00, 0x22, 0x00, 0x23, 0x00, 0x24, 0x00, 0x25, 0x00, 0x26, 0x00, 0x27, 0x00, 0x28, 0x00
	.byte 0x29, 0x00, 0x2A, 0x00, 0x2B, 0x00, 0x2C, 0x00, 0x2D, 0x00, 0x03, 0x00, 0x00, 0x00, 0x03, 0x00
	.byte 0x00, 0x01, 0x01, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x06, 0x00
	.byte 0x00, 0x01, 0x07, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x01, 0x0D, 0x00
	.byte 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00, 0x13, 0x00, 0x00, 0x00, 0x13, 0x00, 0x00, 0x01, 0x14, 0x00
	.byte 0x00, 0x00, 0x18, 0x02, 0x00, 0x00, 0x18, 0x02, 0x00, 0x02, 0x18, 0x03, 0x00, 0x00, 0x18, 0x00
	.byte 0x04, 0x00, 0x18, 0x00, 0x04, 0x03, 0x18, 0x00, 0x03, 0x00, 0x18, 0x00, 0x05, 0x00, 0x21, 0x04
	.byte 0x06, 0x00, 0x21, 0x04, 0x06, 0x01, 0x22, 0x04, 0x06, 0x00, 0x23, 0x04, 0x06, 0x00, 0x26, 0x04
	.byte 0x06, 0x00, 0x03, 0x00, 0x00, 0x01, 0x04, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x05, 0x00
	.byte 0x00, 0x00, 0x06, 0x00, 0x00, 0x01, 0x07, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x0E, 0x00
	.byte 0x00, 0x01, 0x0F, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x13, 0x00
	.byte 0x00, 0x01, 0x14, 0x00, 0x00, 0x00, 0x15, 0x00, 0x00, 0x00, 0x18, 0x02, 0x00, 0x02, 0x18, 0x03
	.byte 0x00, 0x00, 0x18, 0x04, 0x00, 0x00, 0x18, 0x00, 0x04, 0x03, 0x18, 0x00, 0x05, 0x00, 0x18, 0x00
	.byte 0x04, 0x00, 0x18, 0x00, 0x06, 0x00, 0x21, 0x04, 0x06, 0x01, 0x22, 0x04, 0x06, 0x00, 0x23, 0x04
	.byte 0x06, 0x00, 0x24, 0x04, 0x06, 0x00, 0x27, 0x04, 0x06, 0x00, 0x00, 0x00
	
	.data

_0217E560: // 0x0217E560
	.word aNarcViPaLz7Nar	// "narc/vi_pa_lz7.narc"

_0217E564: // 0x0217E564
	.word aBbViPaBb			// "bb/vi_pa.bb"

_0217E568: // 0x0217E568
	.word aBbDmasBb_1		// "bb/dmas.bb"

_0217E56C: // 0x0217E56C
	.word aFntFontAllFnt_6	// "fnt/font_all.fnt"
	
aBbDmasBb_1: // 0x0217E570
	.asciz "bb/dmas.bb"
	.align 4
	
aBbViPaBb: // 0x0217E57C
	.asciz "bb/vi_pa.bb"
	.align 4
	
aFntFontAllFnt_6: // 0x0217E588
	.asciz "fnt/font_all.fnt"
	.align 4
	
aNarcViPaLz7Nar: // 0x0217E59C
	.asciz "narc/vi_pa_lz7.narc"
	.align 4