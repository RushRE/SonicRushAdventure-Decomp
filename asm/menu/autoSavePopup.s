	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start AutoSavePopup__Create
AutoSavePopup__Create: // 0x02161164
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r2, #0
	ldr r4, _021611BC // =0x0000043C
	str r2, [sp]
	ldr r0, _021611C0 // =AutoSavePopup__Main
	ldr r1, _021611C4 // =AutoSavePopup__Destructor
	mov r3, r2
	stmib sp, {r2, r4}
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _021611BC // =0x0000043C
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear32
	mov r1, #0
	mov r0, r4
	str r1, [r4, #0x438]
	bl TAMenu__Func_21611C8
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021611BC: .word 0x0000043C
_021611C0: .word AutoSavePopup__Main
_021611C4: .word AutoSavePopup__Destructor
	arm_func_end AutoSavePopup__Create

	arm_func_start TAMenu__Func_21611C8
TAMenu__Func_21611C8: // 0x021611C8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl TAMenu__Func_21611E8
	mov r0, r4
	bl TAMenu__LoadAssets
	mov r0, r4
	bl TAMenu__Func_2161308
	ldmia sp!, {r4, pc}
	arm_func_end TAMenu__Func_21611C8

	arm_func_start TAMenu__Func_21611E8
TAMenu__Func_21611E8: // 0x021611E8
	stmdb sp!, {r3, lr}
	mov r1, #0x4000000
	ldr r0, [r1]
	add r2, r1, #0x1000
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1000
	str r0, [r1]
	ldr r1, [r2]
	mov r0, #0
	bic r1, r1, #0x1f00
	orr r1, r1, #0x1000
	str r1, [r2]
	bl VRAMSystem__Init
	mov r1, #0
	mov r2, r1
	mov r0, #1
	bl GX_SetGraphicsMode
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r0, _02161268 // =0x05000400
	mov r3, #0
	strh r3, [r0]
	mov r1, #0x5000000
	strh r3, [r1]
	ldr r0, _0216126C // =renderCurrentDisplay
	mov r2, #1
	str r2, [r0]
	ldr r1, _02161270 // =renderCoreGFXControlB
	ldr r0, _02161274 // =renderCoreGFXControlA
	strh r3, [r1, #0x58]
	strh r3, [r0, #0x58]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02161268: .word 0x05000400
_0216126C: .word renderCurrentDisplay
_02161270: .word renderCoreGFXControlB
_02161274: .word renderCoreGFXControlA
	arm_func_end TAMenu__Func_21611E8

	arm_func_start TAMenu__LoadAssets
TAMenu__LoadAssets: // 0x02161278
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _02161300 // =aFntFontAllFnt_4_ovl04
	mov r1, #0
	bl FSRequestFileSync
	str r0, [r5, #0x430]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _021612C8
_021612A4: // jump table
	b _021612BC // case 0
	b _021612BC // case 1
	b _021612BC // case 2
	b _021612BC // case 3
	b _021612BC // case 4
	b _021612BC // case 5
_021612BC:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	b _021612CC
_021612C8:
	mov r0, #1
_021612CC:
	mov r1, r0, lsl #0x10
	ldr r0, _02161304 // =aBbDmtaMenuBb_ovl04
	mov r1, r1, lsr #0x10
	mvn r2, #0
	bl ReadFileFromBundle
	mov r4, r0
	mov r1, #1
	mov r2, #0
	bl ArchiveFileUnknown__GetFileFromMemArchive
	str r0, [r5, #0x434]
	mov r0, r4
	bl _FreeHEAP_USER
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02161300: .word aFntFontAllFnt_4_ovl04
_02161304: .word aBbDmtaMenuBb_ovl04
	arm_func_end TAMenu__LoadAssets

	arm_func_start TAMenu__Func_2161308
TAMenu__Func_2161308: // 0x02161308
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	add r0, r4, #0x380
	bl FontWindow__Init
	ldr r1, [r4, #0x430]
	add r0, r4, #0x380
	mov r2, #1
	bl FontWindow__LoadFromMemory
	mov r0, r4
	bl SaveSpriteButton__Func_206515C
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	add r0, r4, #0x380
	str r0, [sp, #8]
	ldr r1, [r4, #0x434]
	mov r0, r4
	str r1, [sp, #0xc]
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r1, #2
	str r1, [sp, #0x18]
	mov r1, #3
	mov r3, r2
	bl SaveSpriteButton__Func_20651D4
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
	arm_func_end TAMenu__Func_2161308

	arm_func_start TAMenu__Func_2161378
TAMenu__Func_2161378: // 0x02161378
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl TAMenu__Func_2161418
	mov r0, r4
	bl TAMenu__Func_21613DC
	mov r0, r4
	bl TAMenu__Func_2161398
	ldmia sp!, {r4, pc}
	arm_func_end TAMenu__Func_2161378

	arm_func_start TAMenu__Func_2161398
TAMenu__Func_2161398: // 0x02161398
	mov r1, #0x4000000
	ldr r0, [r1]
	add r2, r1, #0x1000
	bic r0, r0, #0x1f00
	str r0, [r1]
	ldr r1, [r2]
	ldr r0, _021613D4 // =renderCoreGFXControlB
	bic r1, r1, #0x1f00
	str r1, [r2]
	mvn r1, #0xf
	strh r1, [r0, #0x58]
	ldrsh r1, [r0, #0x58]
	ldr r0, _021613D8 // =renderCoreGFXControlA
	strh r1, [r0, #0x58]
	bx lr
	.align 2, 0
_021613D4: .word renderCoreGFXControlB
_021613D8: .word renderCoreGFXControlA
	arm_func_end TAMenu__Func_2161398

	arm_func_start TAMenu__Func_21613DC
TAMenu__Func_21613DC: // 0x021613DC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x434]
	cmp r0, #0
	beq _021613FC
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x434]
_021613FC:
	ldr r0, [r4, #0x430]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x430]
	ldmia sp!, {r4, pc}
	arm_func_end TAMenu__Func_21613DC

	arm_func_start TAMenu__Func_2161418
TAMenu__Func_2161418: // 0x02161418
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SaveSpriteButton__Func_20651A4
	add r0, r4, #0x380
	bl FontWindow__Release
	ldmia sp!, {r4, pc}
	arm_func_end TAMenu__Func_2161418

	arm_func_start AutoSavePopup__Main
AutoSavePopup__Main: // 0x02161430
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SaveSpriteButton__RunState2
	add r0, r4, #0x380
	bl FontWindow__PrepareSwapBuffer
	mov r0, r4
	bl SaveSpriteButton__CheckState2Thing
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, _02161464 // =TAMenu__Main_2161468
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161464: .word TAMenu__Main_2161468
	arm_func_end AutoSavePopup__Main

	arm_func_start TAMenu__Main_2161468
TAMenu__Main_2161468: // 0x02161468
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SaveSpriteButton__RunState2
	add r0, r4, #0x380
	bl FontWindow__PrepareSwapBuffer
	mov r0, #0
	bl TrySaveGameData
	cmp r0, #0
	moveq r1, #1
	movne r1, #0
	mov r0, r4
	str r1, [r4, #0x438]
	bl SaveSpriteButton__Func_206546C
	ldr r0, _021614AC // =TAMenu__Main_21614B0
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_021614AC: .word TAMenu__Main_21614B0
	arm_func_end TAMenu__Main_2161468

	arm_func_start TAMenu__Main_21614B0
TAMenu__Main_21614B0: // 0x021614B0
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SaveSpriteButton__RunState2
	add r0, r4, #0x380
	bl FontWindow__PrepareSwapBuffer
	mov r0, r4
	bl SaveSpriteButton__CheckInvalidState2
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r4, [r4, #0x438]
	bl DestroyCurrentTask
	cmp r4, #0
	beq _021614F4
	mov r0, #1
	bl RequestSysEventChange
	b _021614FC
_021614F4:
	mov r0, #0
	bl RequestSysEventChange
_021614FC:
	bl NextSysEvent
	ldmia sp!, {r4, pc}
	arm_func_end TAMenu__Main_21614B0

	arm_func_start AutoSavePopup__Destructor
AutoSavePopup__Destructor: // 0x02161504
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	bl TAMenu__Func_2161378
	ldmia sp!, {r3, pc}
	arm_func_end AutoSavePopup__Destructor

	.data

aFntFontAllFnt_4_ovl04: // 0x02162E40
	.asciz "fnt/font_all.fnt"
	.align 4

aBbDmtaMenuBb_ovl04: // 0x02162E54
	.asciz "bb/dmta_menu.bb"
	.align 4