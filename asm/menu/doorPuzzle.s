	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DoorPuzzle__Init
DoorPuzzle__Init: // 0x02157380
	ldr r0, _02157390 // =gameState
	ldr ip, _02157394 // =DoorPuzzle__Create
	ldr r0, [r0, #0x158]
	bx ip
	.align 2, 0
_02157390: .word gameState
_02157394: .word DoorPuzzle__Create
	arm_func_end DoorPuzzle__Init

	arm_func_start DoorPuzzle__Create
DoorPuzzle__Create: // 0x02157398
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	bl DoorPuzzle__Func_215743C
	mov r0, #0x2000
	mov r2, #0
	str r0, [sp]
	ldr r0, _02157414 // =DoorPuzzle__Main
	ldr r1, _02157418 // =DoorPuzzle__Destructor
	mov r3, r2
	str r2, [sp, #4]
	mov r4, #0xc0
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0xc0
	bl MIi_CpuClear16
	mov r0, r4
	str r5, [r4, #0xac]
	bl DoorPuzzle__LoadArchives
	mov r0, r4
	bl DoorPuzzle__LoadAssets
	mov r0, r4
	bl Task__Unknown215790C__Create
	mov r0, #0x19
	bl LoadSysSound
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02157414: .word DoorPuzzle__Main
_02157418: .word DoorPuzzle__Destructor
	arm_func_end DoorPuzzle__Create

	arm_func_start DoorPuzzle__Func_215741C
DoorPuzzle__Func_215741C: // 0x0215741C
	stmdb sp!, {r3, lr}
	mov r0, #2
	bl ClearTaskScope
	mov r0, #1
	bl ClearTaskScope
	mov r0, #0
	bl ClearTaskScope
	ldmia sp!, {r3, pc}
	arm_func_end DoorPuzzle__Func_215741C

	arm_func_start DoorPuzzle__Func_215743C
DoorPuzzle__Func_215743C: // 0x0215743C
	stmdb sp!, {r3, lr}
	mov r0, #0
	bl VRAMSystem__Init
	ldr lr, _0215767C // =0x04000304
	ldr r0, _02157680 // =0xFFFFFDF1
	ldrh r2, [lr]
	ldr r1, _02157684 // =renderCoreGFXControlA
	mov r3, #0
	and r0, r2, r0
	orr r0, r0, #2
	orr r0, r0, #0x200
	strh r0, [lr]
	ldrh r2, [lr]
	ldr r0, _02157688 // =renderCurrentDisplay
	mov ip, #1
	orr r2, r2, #0x8000
	strh r2, [lr]
	str r3, [r1, #0x1c]
	ldrh r2, [r1, #0x20]
	str ip, [r0]
	sub r0, r3, #0x10
	bic r2, r2, #0xc0
	strh r2, [r1, #0x20]
	strh r0, [r1, #0x58]
	strh r3, [r1, #0x5a]
	ldrsh r1, [r1, #0x58]
	sub r0, lr, #0x298
	bl GXx_SetMasterBrightness_
	mov ip, #0x4000000
	ldr r0, [ip]
	mov r1, #0
	bic r0, r0, #0x38000000
	str r0, [ip]
	ldr r0, [ip]
	mov r2, r1
	bic r3, r0, #0x7000000
	mov r0, #1
	str r3, [ip]
	bl GX_SetGraphicsMode
	ldr r1, _0215768C // =0x04000008
	ldr r2, _02157684 // =renderCoreGFXControlA
	ldrh r3, [r1, #0]
	mov r0, #0
	and r3, r3, #0x43
	orr r3, r3, #0x84
	strh r3, [r1]
	ldrh r3, [r1, #2]
	and r3, r3, #0x43
	orr r3, r3, #0x110
	strh r3, [r1, #2]
	ldrh r3, [r1, #4]
	and r3, r3, #0x43
	orr r3, r3, #0x214
	strh r3, [r1, #4]
	strh r0, [r2, #2]
	strh r0, [r2]
	strh r0, [r2, #6]
	strh r0, [r2, #4]
	strh r0, [r2, #0xa]
	strh r0, [r2, #8]
	strh r0, [r2, #0xe]
	strh r0, [r2, #0xc]
	ldrh r2, [r1, #0]
	bic r2, r2, #3
	orr r2, r2, #3
	strh r2, [r1]
	ldrh r2, [r1, #2]
	bic r2, r2, #3
	orr r2, r2, #2
	strh r2, [r1, #2]
	ldrh r2, [r1, #4]
	mov ip, #0x4000000
	ldr r3, _02157690 // =VRAMSystem__VRAM_BG
	bic r2, r2, #3
	orr r2, r2, #1
	strh r2, [r1, #4]
	ldrh lr, [r1, #6]
	mov r2, #0x20000
	bic lr, lr, #3
	strh lr, [r1, #6]
	ldr r1, [ip]
	bic r1, r1, #0x1f00
	orr r1, r1, #0x1700
	str r1, [ip]
	ldr r1, [r3, #0]
	bl MIi_CpuClear16
	mov ip, #0
	ldr r1, _02157694 // =renderCoreGFXControlB
	sub r2, ip, #0x10
	str ip, [r1, #0x1c]
	ldrh r3, [r1, #0x20]
	ldr r0, _02157698 // =0x0400106C
	bic r3, r3, #0xc0
	strh r3, [r1, #0x20]
	strh r2, [r1, #0x58]
	strh ip, [r1, #0x5a]
	ldrsh r1, [r1, #0x58]
	bl GXx_SetMasterBrightness_
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r1, _0215769C // =0x04001008
	ldr r2, _02157694 // =renderCoreGFXControlB
	ldrh r3, [r1, #0]
	mov r0, #0
	and r3, r3, #0x43
	orr r3, r3, #0x84
	strh r3, [r1]
	ldrh r3, [r1, #2]
	and r3, r3, #0x43
	orr r3, r3, #0x110
	strh r3, [r1, #2]
	strh r0, [r2, #2]
	strh r0, [r2]
	strh r0, [r2, #6]
	strh r0, [r2, #4]
	strh r0, [r2, #0xa]
	strh r0, [r2, #8]
	strh r0, [r2, #0xe]
	strh r0, [r2, #0xc]
	ldrh r2, [r1, #0]
	bic r2, r2, #3
	orr r2, r2, #3
	strh r2, [r1]
	ldrh r2, [r1, #2]
	bic r2, r2, #3
	orr r2, r2, #2
	strh r2, [r1, #2]
	ldrh r2, [r1, #4]
	bic r2, r2, #3
	orr r2, r2, #1
	strh r2, [r1, #4]
	ldrh r2, [r1, #6]
	bic r2, r2, #3
	strh r2, [r1, #6]
	sub r3, r1, #8
	ldr r2, [r3, #0]
	ldr r1, _02157690 // =VRAMSystem__VRAM_BG
	bic r2, r2, #0x1f00
	orr r2, r2, #0x1100
	str r2, [r3]
	ldr r1, [r1, #4]
	mov r2, #0x20000
	bl MIi_CpuClear16
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215767C: .word 0x04000304
_02157680: .word 0xFFFFFDF1
_02157684: .word renderCoreGFXControlA
_02157688: .word renderCurrentDisplay
_0215768C: .word 0x04000008
_02157690: .word VRAMSystem__VRAM_BG
_02157694: .word renderCoreGFXControlB
_02157698: .word 0x0400106C
_0215769C: .word 0x04001008
	arm_func_end DoorPuzzle__Func_215743C

	arm_func_start DoorPuzzle__LoadArchives
DoorPuzzle__LoadArchives: // 0x021576A0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _02157714 // =aNarcDmpzLz7Nar
	mov r1, #0
	bl FSRequestFileSync
	mov r4, r0
	ldr r0, [r4, #0]
	mov r0, r0, lsr #8
	bl _AllocTailHEAP_USER
	str r0, [r5]
	mov r1, r0
	mov r0, r4
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	ldr r0, _02157718 // =aNarcTkdmLz7Nar_ovl04
	mov r1, #0
	bl FSRequestFileSync
	mov r4, r0
	ldr r0, [r4, #0]
	mov r0, r0, lsr #8
	bl _AllocTailHEAP_USER
	str r0, [r5, #4]
	mov r1, r0
	mov r0, r4
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02157714: .word aNarcDmpzLz7Nar
_02157718: .word aNarcTkdmLz7Nar_ovl04
	arm_func_end DoorPuzzle__LoadArchives

	arm_func_start DoorPuzzle__Func_215771C
DoorPuzzle__Func_215771C: // 0x0215771C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0]
	bl _FreeHEAP_USER
	ldr r0, [r4, #4]
	bl _FreeHEAP_USER
	ldmia sp!, {r4, pc}
	arm_func_end DoorPuzzle__Func_215771C

	arm_func_start DoorPuzzle__LoadAssets
DoorPuzzle__LoadAssets: // 0x02157738
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	ldr r0, [r4, #0]
	mov r1, #9
	bl FileUnknown__GetAOUFile
	mov r3, #0
	mov r1, r0
	str r3, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov ip, #0x18
	add r0, r4, #0x10
	mov r2, #0x38
	str ip, [sp, #8]
	bl InitBackground
	add r0, r4, #0x10
	bl DrawBackground
	ldr r0, [r4, #0]
	mov r1, #8
	bl FileUnknown__GetAOUFile
	mov r1, r0
	mov r0, #0
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, r4, #0x58
	mov r2, #0x38
	mov r3, #1
	bl InitBackground
	add r0, r4, #0x58
	bl DrawBackground
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	arm_func_end DoorPuzzle__LoadAssets

	arm_func_start DoorPuzzle__Func_21577C8
DoorPuzzle__Func_21577C8: // 0x021577C8
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x20
	mov r4, r0
	mov r0, #0x20
	bl _AllocTailHEAP_USER
	str r0, [r4]
	mov r0, #0x800
	bl _AllocTailHEAP_USER
	str r0, [r4, #4]
	mov r0, #0x20
	bl _AllocTailHEAP_USER
	str r0, [r4, #8]
	ldr r0, _02157894 // =0x00001111
	ldr r1, [r4, #0]
	mov r2, #0x20
	bl MIi_CpuClear16
	mov r0, #0
	ldr r1, [r4, #4]
	mov r2, #0x800
	bl MIi_CpuClear16
	mov r0, #0
	ldr r1, [r4, #8]
	mov r2, #0x20
	bl MIi_CpuClear16
	ldr r0, [r4, #0]
	mov r1, #0x20
	mov r2, #0
	ldr r3, _02157898 // =0x06210000
	bl LoadUncompressedPixels
	mov r2, #1
	str r2, [sp]
	mov r0, #0xc
	str r0, [sp, #4]
	mov r1, #0
	str r1, [sp, #8]
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r3, #0x20
	str r3, [sp, #0x18]
	str r3, [sp, #0x1c]
	ldr r0, [r4, #4]
	mov r2, r1
	bl Mappings__LoadUnknown
	ldr r0, [r4, #8]
	mov r1, #0x10
	mov r2, #0
	ldr r3, _0215789C // =0x05000400
	bl LoadUncompressedPalette
	add sp, sp, #0x20
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157894: .word 0x00001111
_02157898: .word 0x06210000
_0215789C: .word 0x05000400
	arm_func_end DoorPuzzle__Func_21577C8

	arm_func_start DoorPuzzle__Func_21578A0
DoorPuzzle__Func_21578A0: // 0x021578A0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0]
	bl _FreeHEAP_USER
	ldr r0, [r4, #4]
	bl _FreeHEAP_USER
	ldr r0, [r4, #8]
	bl _FreeHEAP_USER
	ldmia sp!, {r4, pc}
	arm_func_end DoorPuzzle__Func_21578A0

	arm_func_start DoorPuzzle__Func_21578C4
DoorPuzzle__Func_21578C4: // 0x021578C4
	ldr r2, [r0, #0xb0]
	orr r2, r2, #1
	str r2, [r0, #0xb0]
	str r1, [r0, #0xb4]
	bx lr
	arm_func_end DoorPuzzle__Func_21578C4

	arm_func_start DoorPuzzle__Func_21578D8
DoorPuzzle__Func_21578D8: // 0x021578D8
	stmdb sp!, {r3, lr}
	ldr r0, [r0, #0xb0]
	tst r0, #2
	beq _021578F4
	mov r0, #0xa
	bl SaveGame__Func_205B9F0
	b _021578FC
_021578F4:
	mov r0, #0
	bl SaveGame__Func_205B9F0
_021578FC:
	mov r0, #0
	bl RequestSysEventChange
	bl NextSysEvent
	ldmia sp!, {r3, pc}
	arm_func_end DoorPuzzle__Func_21578D8

	arm_func_start Task__Unknown215790C__Create
Task__Unknown215790C__Create: // 0x0215790C
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x1c
	mov r1, #0x3000
	mov r5, r0
	mov r2, #0
	str r1, [sp]
	mov r4, #2
	ldr r0, _02157A48 // =Task__Unknown215790C__Main
	ldr r1, _02157A4C // =Task__Unknown215790C__Destructor
	mov r3, r2
	str r4, [sp, #4]
	mov r4, #0xcc
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0xcc
	bl MIi_CpuClear16
	ldr r0, [r5, #0]
	mov r1, #5
	bl FileUnknown__GetAOUFile
	mov r6, r0
	bl Sprite__GetSpriteSize3
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, r6
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r3, _02157A50 // =0x05000200
	mov r0, #2
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r4, #4
	mov r3, #4
	bl AnimatorSprite__Init
	mov r0, #1
	strh r0, [r4, #0x54]
	mov r0, #0x18
	strh r0, [r4, #0xc]
	mov r0, #0x10
	strh r0, [r4, #0xe]
	ldr r0, [r5, #0]
	mov r1, #5
	bl FileUnknown__GetAOUFile
	mov r5, r0
	bl Sprite__GetSpriteSize3
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, r5
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr r2, _02157A50 // =0x05000200
	mov r0, #2
	str r2, [sp, #0x10]
	str r3, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r4, #0x68
	mov r2, #1
	mov r3, #4
	bl AnimatorSprite__Init
	mov r0, #2
	strh r0, [r4, #0xb8]
	mov r0, #0xc8
	strh r0, [r4, #0x70]
	mov r0, #0x10
	strh r0, [r4, #0x72]
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02157A48: .word Task__Unknown215790C__Main
_02157A4C: .word Task__Unknown215790C__Destructor
_02157A50: .word 0x05000200
	arm_func_end Task__Unknown215790C__Create

	arm_func_start Task__Unknown215790C__Destructor
Task__Unknown215790C__Destructor: // 0x02157A54
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #4
	bl AnimatorSprite__Release
	add r0, r4, #0x68
	bl AnimatorSprite__Release
	ldmia sp!, {r4, pc}
	arm_func_end Task__Unknown215790C__Destructor

	arm_func_start Task__Unknown215790C__Main
Task__Unknown215790C__Main: // 0x02157A74
	ldr ip, _02157A80 // =SetCurrentTaskMainEvent
	ldr r0, _02157A84 // =Task__Unknown215790C__Main_2157A88
	bx ip
	.align 2, 0
_02157A80: .word SetCurrentTaskMainEvent
_02157A84: .word Task__Unknown215790C__Main_2157A88
	arm_func_end Task__Unknown215790C__Main

	arm_func_start Task__Unknown215790C__Main_2157A88
Task__Unknown215790C__Main_2157A88: // 0x02157A88
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, r1
	add r0, r4, #4
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x68
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #4
	bl AnimatorSprite__DrawFrame
	add r0, r4, #0x68
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}
	arm_func_end Task__Unknown215790C__Main_2157A88

	arm_func_start DoorPuzzleDoor__Create
DoorPuzzleDoor__Create: // 0x02157AC8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	mov r1, #0x3000
	mov r10, r0
	str r1, [sp]
	mov r0, #1
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _02157DCC // =0x00000644
	ldr r0, _02157DD0 // =DoorPuzzleDoor__Main
	ldr r1, _02157DD4 // =DoorPuzzleDoor__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	str r0, [sp, #0x1c]
	mov r1, r0
	mov r2, r4
	mov r0, #0
	bl MIi_CpuClear16
	ldr r2, [sp, #0x1c]
	ldr r0, _02157DD8 // =aFntFontAllFnt_2_ovl04
	mov r1, #0
	str r10, [r2, #0x1dc]
	bl FSRequestFileSync
	mov r7, #0
	ldr r9, [sp, #0x1c]
	str r0, [r10, #8]
	mov r0, r9
	ldr r11, _02157DDC // =0x02162A92
	add r8, r0, #0x1f8
	mov r5, r7
	mvn r4, #0x45
_02157B4C:
	mov r0, r7, lsl #1
	ldrh r1, [r11, r0]
	ldr r0, [r10, #0]
	bl FileUnknown__GetAOUFile
	mov r6, r0
	bl Sprite__GetSpriteSize3
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	str r5, [sp]
	str r5, [sp, #4]
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	str r5, [sp, #0x10]
	str r5, [sp, #0x14]
	mov r1, r6
	mov r0, r8
	mov r2, r5
	mov r3, #4
	str r5, [sp, #0x18]
	bl AnimatorSprite__Init
	add r1, r9, #0x200
	mov r0, #0x30
	strh r0, [r1]
	add r7, r7, #1
	strh r4, [r1, #2]
	add r8, r8, #0x64
	add r9, r9, #0x64
	cmp r7, #4
	blt _02157B4C
	mov r1, #0
	ldr r0, _02157DE0 // =aBbTkdmCutinBb
	mov r2, r1
	bl ReadFileFromBundle
	mov r4, r0
	ldr r0, [r4, #0]
	mov r0, r0, lsr #8
	bl _AllocTailHEAP_USER
	str r0, [r10, #0xc]
	mov r1, r0
	mov r0, r4
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	ldr r0, [sp, #0x1c]
	mov r6, #0
	add r1, r0, #0xb4
	ldr r5, _02157DE4 // =0x02162AA6
	mov r8, r0
	add r7, r0, #0x388
	add r9, r1, #0x400
	mov r11, r6
	mov r4, r6
_02157C24:
	ldr r0, [r10, #0xc]
	bl Sprite__GetSpriteSize3
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	str r11, [sp]
	str r11, [sp, #4]
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	str r11, [sp, #0x10]
	str r11, [sp, #0x14]
	str r11, [sp, #0x18]
	ldr r2, _02157DE8 // =0x02162A86
	mov r3, r6, lsl #1
	ldrh r2, [r2, r3]
	ldr r1, [r10, #0xc]
	mov r0, r7
	mov r3, #4
	bl AnimatorSprite__Init
	add r0, r6, #1
	add r3, r8, #0x300
	strh r0, [r3, #0xd8]
	mov r0, r6, lsl #2
	ldrsh r2, [r5, r0]
	add r1, r5, r6, lsl #2
	mov r0, r7
	strh r2, [r3, #0x90]
	ldrsh ip, [r1, #2]
	mov r1, #0
	mov r2, r1
	strh ip, [r3, #0x92]
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [r10, #0xc]
	bl Sprite__GetSpriteSize3
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	str r4, [sp]
	str r4, [sp, #4]
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	str r4, [sp, #0x10]
	str r4, [sp, #0x14]
	mov r0, #1
	str r0, [sp, #0x18]
	ldr r1, [r10, #0xc]
	mov r0, r9
	mov r2, r4
	mov r3, #4
	bl AnimatorSprite__Init
	add r1, r8, #0x500
	mov r0, #4
	strh r0, [r1, #4]
	mov r0, r6, lsl #2
	ldrsh r1, [r5, r0]
	add r2, r8, #0x400
	add r0, r5, r6, lsl #2
	strh r1, [r2, #0xbc]
	ldrsh r3, [r0, #2]
	mov r1, #0
	mov r0, r9
	strh r3, [r2, #0xbe]
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r7, r7, #0x64
	add r8, r8, #0x64
	add r9, r9, #0x64
	add r6, r6, #1
	cmp r6, #3
	blt _02157C24
	ldr r0, [r10, #4]
	mov r1, #1
	bl FileUnknown__GetAOUFile
	mov r4, r0
	bl Sprite__GetSpriteSize3
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x1c]
	ldr r3, _02157DEC // =0x05000200
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r1, r4
	add r0, r0, #0x5e0
	mov r3, #4
	str r2, [sp, #0x18]
	bl AnimatorSprite__Init
	ldr r0, [sp, #0x1c]
	mov r1, #0
	add r0, r0, #0x600
	strh r1, [r0, #0x30]
	ldr r0, [sp, #0x1c]
	mov r1, #0xe0
	add r0, r0, #0x500
	strh r1, [r0, #0xe8]
	mov r1, #0xa0
	strh r1, [r0, #0xea]
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02157DCC: .word 0x00000644
_02157DD0: .word DoorPuzzleDoor__Main
_02157DD4: .word DoorPuzzleDoor__Destructor
_02157DD8: .word aFntFontAllFnt_2_ovl04
_02157DDC: .word 0x02162A92
_02157DE0: .word aBbTkdmCutinBb
_02157DE4: .word 0x02162AA6
_02157DE8: .word 0x02162A86
_02157DEC: .word 0x05000200
	arm_func_end DoorPuzzleDoor__Create

	arm_func_start DoorPuzzleDoor__Destructor
DoorPuzzleDoor__Destructor: // 0x02157DF0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl GetTaskWork_
	mov r4, r0
	bl DoorPuzzleDoor__Func_215876C
	ldr r0, [r4, #0x1dc]
	ldr r0, [r0, #8]
	bl _FreeHEAP_USER
	add r0, r4, #0xb4
	add r6, r4, #0x388
	add r7, r0, #0x400
	mov r5, #0
_02157E1C:
	mov r0, r6
	bl AnimatorSprite__Release
	mov r0, r7
	bl AnimatorSprite__Release
	add r5, r5, #1
	cmp r5, #3
	add r6, r6, #0x64
	add r7, r7, #0x64
	blt _02157E1C
	ldr r0, [r4, #0x1dc]
	ldr r0, [r0, #0xc]
	bl _FreeHEAP_USER
	add r6, r4, #0x1f8
	mov r5, #0
_02157E54:
	mov r0, r6
	bl AnimatorSprite__Release
	add r5, r5, #1
	cmp r5, #4
	add r6, r6, #0x64
	blt _02157E54
	add r0, r4, #0x5e0
	bl AnimatorSprite__Release
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end DoorPuzzleDoor__Destructor

	arm_func_start DoorPuzzleDoor__Main
DoorPuzzleDoor__Main: // 0x02157E78
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x1dc]
	ldr r1, [r1, #0xac]
	cmp r1, #2
	ldreq r1, _02157EAC // =DoorPuzzleDoor__Func_21581D4
	ldrne r1, _02157EB0 // =DoorPuzzleDoor__Func_21580F8
	str r1, [r0, #0x1e0]
	mov r1, #0
	str r1, [r0, #0x1e4]
	ldr r0, _02157EB4 // =DoorPuzzleDoor__Main_2157EB8
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02157EAC: .word DoorPuzzleDoor__Func_21581D4
_02157EB0: .word DoorPuzzleDoor__Func_21580F8
_02157EB4: .word DoorPuzzleDoor__Main_2157EB8
	arm_func_end DoorPuzzleDoor__Main

	arm_func_start DoorPuzzleDoor__Main_2157EB8
DoorPuzzleDoor__Main_2157EB8: // 0x02157EB8
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x1e0]
	cmp r1, #0
	beq _02157ED4
	blx r1
_02157ED4:
	ldr r1, [r4, #0x1e4]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
	arm_func_end DoorPuzzleDoor__Main_2157EB8

	arm_func_start DoorPuzzleDoor__Func_2157EEC
DoorPuzzleDoor__Func_2157EEC: // 0x02157EEC
	ldr r2, [r0, #0x1dc]
	ldr r1, _02157F0C // =0x02162A9A
	ldr r2, [r2, #0xac]
	add r0, r0, #0x100
	mov r2, r2, lsl #2
	ldrh r1, [r1, r2]
	strh r1, [r0, #0xd8]
	bx lr
	.align 2, 0
_02157F0C: .word 0x02162A9A
	arm_func_end DoorPuzzleDoor__Func_2157EEC

	arm_func_start DoorPuzzleDoor__Func_2157F10
DoorPuzzleDoor__Func_2157F10: // 0x02157F10
	add r1, r0, #0x100
	ldrh r3, [r1, #0xd8]
	ldr r2, _02157F48 // =0x02162A9C
	add r3, r3, #1
	strh r3, [r1, #0xd8]
	ldr r0, [r0, #0x1dc]
	ldrh r1, [r1, #0xd8]
	ldr r0, [r0, #0xac]
	mov r0, r0, lsl #2
	ldrh r0, [r2, r0]
	cmp r1, r0
	movhi r0, #1
	movls r0, #0
	bx lr
	.align 2, 0
_02157F48: .word 0x02162A9C
	arm_func_end DoorPuzzleDoor__Func_2157F10

	arm_func_start DoorPuzzleDoor__Func_2157F4C
DoorPuzzleDoor__Func_2157F4C: // 0x02157F4C
	ldr r2, _02157F64 // =0x02162AB2
	mov r1, r1, lsl #1
	ldrh r1, [r2, r1]
	add r0, r0, #0x100
	strh r1, [r0, #0xd8]
	bx lr
	.align 2, 0
_02157F64: .word 0x02162AB2
	arm_func_end DoorPuzzleDoor__Func_2157F4C

	arm_func_start DoorPuzzleDoor__Func_2157F68
DoorPuzzleDoor__Func_2157F68: // 0x02157F68
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DoorPuzzleDoor__Func_21585FC
	mov r0, r4
	bl DoorPuzzleDoor__Func_2158790
	ldr r1, _02157F90 // =DoorPuzzleDoor__Func_2157F94
	mov r0, r4
	str r1, [r4, #0x1e4]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157F90: .word DoorPuzzleDoor__Func_2157F94
	arm_func_end DoorPuzzleDoor__Func_2157F68

	arm_func_start DoorPuzzleDoor__Func_2157F94
DoorPuzzleDoor__Func_2157F94: // 0x02157F94
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DoorPuzzleDoor__Func_21587C8
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl DoorPuzzleDoor__Func_2158844
	ldr r0, _02157FBC // =DoorPuzzleDoor__Func_2157FC0
	str r0, [r4, #0x1e4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157FBC: .word DoorPuzzleDoor__Func_2157FC0
	arm_func_end DoorPuzzleDoor__Func_2157F94

	arm_func_start DoorPuzzleDoor__Func_2157FC0
DoorPuzzleDoor__Func_2157FC0: // 0x02157FC0
	stmdb sp!, {r3, lr}
	ldr r1, _02157FD4 // =DoorPuzzleDoor__Func_2157FD8
	str r1, [r0, #0x1e4]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_02157FD4: .word DoorPuzzleDoor__Func_2157FD8
	arm_func_end DoorPuzzleDoor__Func_2157FC0

	arm_func_start DoorPuzzleDoor__Func_2157FD8
DoorPuzzleDoor__Func_2157FD8: // 0x02157FD8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl04_215889C
	arm_func_end DoorPuzzleDoor__Func_2157FD8

	arm_func_start DoorPuzzleDoor__Func_2157FE4
DoorPuzzleDoor__Func_2157FE4: // 0x02157FE4
	ldr r0, [r4, #0x1f0]
	cmp r0, #1
	bne _02158000
	mov r0, r4
	bl DoorPuzzleDoor__Func_21588E4
	mov r0, #0
	str r0, [r4, #0x1f0]
_02158000:
	add r0, r4, #0x114
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl DoorPuzzleDoor__Func_21585BC
	ldr r0, _02158024 // =DoorPuzzleDoor__Func_2158028
	str r0, [r4, #0x1e4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158024: .word DoorPuzzleDoor__Func_2158028
	arm_func_end DoorPuzzleDoor__Func_2157FE4

	arm_func_start DoorPuzzleDoor__Func_2158028
DoorPuzzleDoor__Func_2158028: // 0x02158028
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl04_215889C
	ldr r0, [r4, #0x1f0]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	cmp r0, #2
	beq _02158054
	cmp r0, #3
	beq _02158078
	ldmia sp!, {r4, pc}
_02158054:
	mov r0, r4
	bl DoorPuzzleDoor__Func_2158914
	mov r0, r4
	bl DoorPuzzleDoor__Func_21585DC
	ldr r1, _0215808C // =DoorPuzzleDoor__Func_2157FC0
	mov r0, #0
	str r1, [r4, #0x1e4]
	str r0, [r4, #0x1f0]
	ldmia sp!, {r4, pc}
_02158078:
	ldr r1, _02158090 // =DoorPuzzleDoor__Func_2158094
	mov r0, #0
	str r1, [r4, #0x1e4]
	str r0, [r4, #0x1f0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215808C: .word DoorPuzzleDoor__Func_2157FC0
_02158090: .word DoorPuzzleDoor__Func_2158094
	arm_func_end DoorPuzzleDoor__Func_2158028

	arm_func_start DoorPuzzleDoor__Func_2158094
DoorPuzzleDoor__Func_2158094: // 0x02158094
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DoorPuzzleDoor__Func_2158854
	ldr r1, _021580B4 // =DoorPuzzleDoor__Func_21580B8
	mov r0, r4
	str r1, [r4, #0x1e4]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_021580B4: .word DoorPuzzleDoor__Func_21580B8
	arm_func_end DoorPuzzleDoor__Func_2158094

	arm_func_start DoorPuzzleDoor__Func_21580B8
DoorPuzzleDoor__Func_21580B8: // 0x021580B8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DoorPuzzleDoor__Func_2158800
	cmp r0, #0
	ldrne r0, _021580D4 // =DoorPuzzleDoor__Func_21580D8
	strne r0, [r4, #0x1e4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021580D4: .word DoorPuzzleDoor__Func_21580D8
	arm_func_end DoorPuzzleDoor__Func_21580B8

	arm_func_start DoorPuzzleDoor__Func_21580D8
DoorPuzzleDoor__Func_21580D8: // 0x021580D8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DoorPuzzleDoor__Func_2158844
	mov r0, r4
	bl DoorPuzzleDoor__Func_215876C
	mov r0, #0
	str r0, [r4, #0x1e4]
	ldmia sp!, {r4, pc}
	arm_func_end DoorPuzzleDoor__Func_21580D8

	arm_func_start DoorPuzzleDoor__Func_21580F8
DoorPuzzleDoor__Func_21580F8: // 0x021580F8
	stmdb sp!, {r4, lr}
	ldr r1, _02158134 // =DoorPuzzleDoor__Func_2157F68
	mov r4, r0
	str r1, [r4, #0x1e4]
	mov r1, #0
	str r1, [r4, #0x1f0]
	bl DoorPuzzleDoor__Func_21585DC
	ldr r1, [r4, #0x1e8]
	mov r0, r4
	orr r1, r1, #1
	str r1, [r4, #0x1e8]
	bl DoorPuzzleDoor__Func_2157EEC
	ldr r0, _02158138 // =DoorPuzzleDoor__Func_215813C
	str r0, [r4, #0x1e0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158134: .word DoorPuzzleDoor__Func_2157F68
_02158138: .word DoorPuzzleDoor__Func_215813C
	arm_func_end DoorPuzzleDoor__Func_21580F8

	arm_func_start DoorPuzzleDoor__Func_215813C
DoorPuzzleDoor__Func_215813C: // 0x0215813C
	stmdb sp!, {r4, lr}
	ldr r2, _021581CC // =padInput
	ldr r1, _021581D0 // =0x00000C01
	ldrh r2, [r2, #4]
	mov r4, r0
	tst r2, r1
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x1e8]
	tst r0, #2
	beq _021581C0
	mov r0, #5
	bl PlaySysSfx
	add r0, r4, #0x114
	bl FontAnimator__IsLastDialog
	cmp r0, #0
	beq _021581B4
	mov r0, r4
	bl DoorPuzzleDoor__Func_2157F10
	cmp r0, #0
	moveq r0, #2
	streq r0, [r4, #0x1f0]
	ldmeqia sp!, {r4, pc}
	mov r0, #3
	str r0, [r4, #0x1f0]
	mov r0, #0
	str r0, [r4, #0x1e0]
	ldr r0, [r4, #0x1dc]
	mov r1, #0x3c
	bl DoorPuzzle__Func_21578C4
	ldmia sp!, {r4, pc}
_021581B4:
	mov r0, #2
	str r0, [r4, #0x1f0]
	ldmia sp!, {r4, pc}
_021581C0:
	mov r0, #1
	str r0, [r4, #0x1f0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021581CC: .word padInput
_021581D0: .word 0x00000C01
	arm_func_end DoorPuzzleDoor__Func_215813C

	arm_func_start DoorPuzzleDoor__Func_21581D4
DoorPuzzleDoor__Func_21581D4: // 0x021581D4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0x1e8]
	ldr r1, _02158228 // =DoorPuzzleDoor__Func_2157F68
	bic r2, r2, #1
	orr r2, r2, #4
	str r2, [r4, #0x1e8]
	str r1, [r4, #0x1e4]
	mov r1, #0
	str r1, [r4, #0x1f0]
	bl DoorPuzzleDoor__Func_21585DC
	mov r0, r4
	bl DoorPuzzleDoor__Func_2157EEC
	mov r0, #0x258
	str r0, [r4, #0x1ec]
	ldr r1, [r4, #0x1dc]
	mov r2, #4
	ldr r0, _0215822C // =DoorPuzzleDoor__Func_2158230
	str r2, [r1, #0xbc]
	str r0, [r4, #0x1e0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158228: .word DoorPuzzleDoor__Func_2157F68
_0215822C: .word DoorPuzzleDoor__Func_2158230
	arm_func_end DoorPuzzleDoor__Func_21581D4

	arm_func_start DoorPuzzleDoor__Func_2158230
DoorPuzzleDoor__Func_2158230: // 0x02158230
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl IsTouchInputEnabled
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, _02158294 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #1
	bl DoorPuzzleDoor__Func_2157F4C
	mov r0, #2
	str r0, [r4, #0x1f0]
	mov r0, #0x258
	str r0, [r4, #0x1ec]
	ldr r1, [r4, #0x1dc]
	mov r2, #4
	ldr r0, _02158298 // =DoorPuzzleDoor__Func_215829C
	str r2, [r1, #0xbc]
	str r0, [r4, #0x1e0]
	ldr r0, [r4, #0x1dc]
	mov r1, #0
	str r1, [r0, #0xb8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158294: .word touchInput
_02158298: .word DoorPuzzleDoor__Func_215829C
	arm_func_end DoorPuzzleDoor__Func_2158230

	arm_func_start DoorPuzzleDoor__Func_215829C
DoorPuzzleDoor__Func_215829C: // 0x0215829C
	stmdb sp!, {r4, lr}
	ldr r1, _021583D4 // =padInput
	mov r4, r0
	ldrh r1, [r1, #4]
	tst r1, #2
	beq _021582F4
	mov r0, #1
	bl PlaySysSfx
	ldr r3, [r4, #0x1dc]
	mov r0, r4
	ldr r2, [r3, #0xb0]
	mov r1, #5
	orr r2, r2, #8
	str r2, [r3, #0xb0]
	bl DoorPuzzleDoor__Func_2157F4C
	mov r0, #2
	str r0, [r4, #0x1f0]
	mov r1, #0xf0
	ldr r0, _021583D8 // =DoorPuzzleDoor__Func_21583E0
	str r1, [r4, #0x1ec]
	str r0, [r4, #0x1e0]
	ldmia sp!, {r4, pc}
_021582F4:
	ldr r1, [r4, #0x1dc]
	ldr r2, [r1, #0xbc]
	cmp r2, #2
	bne _02158350
	mov r1, #2
	bl DoorPuzzleDoor__Func_2157F4C
	mov r0, #2
	str r0, [r4, #0x1f0]
	ldr r0, [r4, #0x1dc]
	ldr r0, [r0, #0xb0]
	tst r0, #2
	beq _02158338
	mov r1, #0x64
	ldr r0, _021583DC // =DoorPuzzleDoor__Func_215841C
	str r1, [r4, #0x1ec]
	str r0, [r4, #0x1e0]
	ldmia sp!, {r4, pc}
_02158338:
	mov r0, #0x258
	str r0, [r4, #0x1ec]
	ldr r0, [r4, #0x1dc]
	mov r1, #1
	str r1, [r0, #0xbc]
	ldmia sp!, {r4, pc}
_02158350:
	ldr r1, [r1, #0xb8]
	cmp r1, #0x4b0
	blo _02158390
	mov r1, #3
	bl DoorPuzzleDoor__Func_2157F4C
	mov r0, #2
	str r0, [r4, #0x1f0]
	mov r0, #0x258
	str r0, [r4, #0x1ec]
	ldr r0, [r4, #0x1dc]
	mov r1, #0
	str r1, [r0, #0xb8]
	ldr r0, [r4, #0x1dc]
	mov r1, #1
	str r1, [r0, #0xbc]
	ldmia sp!, {r4, pc}
_02158390:
	ldr r1, [r4, #0x1ec]
	cmp r1, #0
	subne r0, r1, #1
	strne r0, [r4, #0x1ec]
	ldmneia sp!, {r4, pc}
	cmp r2, #1
	ldmneia sp!, {r4, pc}
	mov r1, #1
	bl DoorPuzzleDoor__Func_2157F4C
	mov r0, #2
	str r0, [r4, #0x1f0]
	mov r0, #0x258
	str r0, [r4, #0x1ec]
	ldr r0, [r4, #0x1dc]
	mov r1, #4
	str r1, [r0, #0xbc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021583D4: .word padInput
_021583D8: .word DoorPuzzleDoor__Func_21583E0
_021583DC: .word DoorPuzzleDoor__Func_215841C
	arm_func_end DoorPuzzleDoor__Func_215829C

	arm_func_start DoorPuzzleDoor__Func_21583E0
DoorPuzzleDoor__Func_21583E0: // 0x021583E0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x1ec]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x1ec]
	ldmneia sp!, {r4, pc}
	mov r0, #3
	str r0, [r4, #0x1f0]
	ldr r0, [r4, #0x1dc]
	mov r1, #0x3c
	bl DoorPuzzle__Func_21578C4
	mov r0, #0
	str r0, [r4, #0x1e0]
	ldmia sp!, {r4, pc}
	arm_func_end DoorPuzzleDoor__Func_21583E0

	arm_func_start DoorPuzzleDoor__Func_215841C
DoorPuzzleDoor__Func_215841C: // 0x0215841C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x1ec]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x1ec]
	ldmneia sp!, {r4, pc}
	mov r0, #3
	str r0, [r4, #0x1f0]
	ldr r0, [r4, #0x1dc]
	mov r1, #0x3c
	bl DoorPuzzle__Func_21578C4
	mov r0, #0
	str r0, [r4, #0x1e0]
	ldmia sp!, {r4, pc}
	arm_func_end DoorPuzzleDoor__Func_215841C

	arm_func_start DoorPuzzleDoor__Func_2158458
DoorPuzzleDoor__Func_2158458: // 0x02158458
	sub r0, r0, #0xa
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	bx lr
_02158468: // jump table
	b _02158480 // case 0
	b _0215848C // case 1
	b _02158498 // case 2
	b _021584A4 // case 3
	b _021584B0 // case 4
	b _021584BC // case 5
_02158480:
	mov r0, #0
	str r0, [r2, #0x1f4]
	bx lr
_0215848C:
	mov r0, #1
	str r0, [r2, #0x1f4]
	bx lr
_02158498:
	mov r0, #2
	str r0, [r2, #0x1f4]
	bx lr
_021584A4:
	mov r0, #3
	str r0, [r2, #0x1f4]
	bx lr
_021584B0:
	mov r0, #4
	str r0, [r2, #0x1f4]
	bx lr
_021584BC:
	mov r0, #5
	str r0, [r2, #0x1f4]
	bx lr
	arm_func_end DoorPuzzleDoor__Func_2158458

	arm_func_start DoorPuzzleDoor__Func_21584C8
DoorPuzzleDoor__Func_21584C8: // 0x021584C8
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, [r0, #0x1f4]
	ldr r1, _02158514 // =0x02162ACA
	mov ip, r2, lsl #2
	ldrh r3, [r1, ip]
	mov r1, #0x64
	ldr r2, _02158518 // =0x02162ACC
	mul r4, r3, r1
	add r5, r0, #0x1f8
	ldrh r1, [r2, ip]
	add r0, r5, r4
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	mov r2, r1
	add r0, r5, r4
	bl AnimatorSprite__ProcessAnimation
	add r0, r5, r4
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02158514: .word 0x02162ACA
_02158518: .word 0x02162ACC
	arm_func_end DoorPuzzleDoor__Func_21584C8

	arm_func_start DoorPuzzleDoor__Func_215851C
DoorPuzzleDoor__Func_215851C: // 0x0215851C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r1, [r0, #0x1e8]
	tst r1, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r6, #0
	add r1, r0, #0xb4
	add r7, r0, #0x388
	add r8, r1, #0x400
	mov r5, r6
	mov r4, r6
_02158544:
	mov r0, r7
	mov r1, r5
	mov r2, r5
	bl AnimatorSprite__ProcessAnimation
	mov r0, r8
	mov r1, r4
	mov r2, r4
	bl AnimatorSprite__ProcessAnimation
	mov r0, r7
	bl AnimatorSprite__DrawFrame
	mov r0, r8
	bl AnimatorSprite__DrawFrame
	add r6, r6, #1
	cmp r6, #3
	add r7, r7, #0x64
	add r8, r8, #0x64
	blt _02158544
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end DoorPuzzleDoor__Func_215851C

	arm_func_start DoorPuzzleDoor__Func_215858C
DoorPuzzleDoor__Func_215858C: // 0x0215858C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x1e8]
	tst r0, #1
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x5e0
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x5e0
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}
	arm_func_end DoorPuzzleDoor__Func_215858C

	arm_func_start DoorPuzzleDoor__Func_21585BC
DoorPuzzleDoor__Func_21585BC: // 0x021585BC
	ldr r2, [r0, #0x1e8]
	ldr ip, _021585D8 // =AnimatorSprite__SetAnimation
	orr r2, r2, #2
	str r2, [r0, #0x1e8]
	mov r1, #2
	add r0, r0, #0x5e0
	bx ip
	.align 2, 0
_021585D8: .word AnimatorSprite__SetAnimation
	arm_func_end DoorPuzzleDoor__Func_21585BC

	arm_func_start DoorPuzzleDoor__Func_21585DC
DoorPuzzleDoor__Func_21585DC: // 0x021585DC
	ldr r2, [r0, #0x1e8]
	ldr ip, _021585F8 // =AnimatorSprite__SetAnimation
	bic r2, r2, #2
	str r2, [r0, #0x1e8]
	mov r1, #0
	add r0, r0, #0x5e0
	bx ip
	.align 2, 0
_021585F8: .word AnimatorSprite__SetAnimation
	arm_func_end DoorPuzzleDoor__Func_21585DC

	arm_func_start DoorPuzzleDoor__Func_21585FC
DoorPuzzleDoor__Func_21585FC: // 0x021585FC
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x28
	mov r4, r0
	bl FontWindow__Init
	ldr r1, [r4, #0x1dc]
	mov r0, r4
	ldr r1, [r1, #8]
	mov r2, #1
	bl FontWindow__LoadFromMemory
	add r0, r4, #0xb0
	bl FontWindowAnimator__Init
	mov r0, #2
	str r0, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r0, #0xe
	str r0, [sp, #8]
	mov r0, #0x20
	str r0, [sp, #0xc]
	mov r0, #0xa
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r0, #1
	str r0, [sp, #0x18]
	str r2, [sp, #0x1c]
	str r0, [sp, #0x20]
	add r0, r4, #0xb0
	mov r1, r4
	mov r3, r2
	str r2, [sp, #0x24]
	bl FontWindowAnimator__Load1
	add r0, r4, #0x114
	bl FontAnimator__Init
	mov r0, #0xf
	str r0, [sp]
	mov r0, #0x15
	str r0, [sp, #4]
	mov r0, #8
	str r0, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	mov r0, #2
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r4, #0x114
	mov r1, r4
	mov r3, #0xb
	bl FontAnimator__LoadFont1
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _021586FC
_021586D8: // jump table
	b _021586F0 // case 0
	b _021586F0 // case 1
	b _021586F0 // case 2
	b _021586F0 // case 3
	b _021586F0 // case 4
	b _021586F0 // case 5
_021586F0:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _02158700
_021586FC:
	mov r0, #1
_02158700:
	ldr r2, [r4, #0x1dc]
	add r0, r0, #0xa
	mov r1, r0, lsl #0x10
	ldr r0, [r2, #0]
	mov r1, r1, lsr #0x10
	bl FileUnknown__GetAOUFile
	mov r1, r0
	add r0, r4, #0x114
	bl FontAnimator__LoadMPCFile
	ldr r1, _02158768 // =DoorPuzzleDoor__Func_2158458
	mov r2, r4
	add r0, r4, #0x114
	bl FontAnimator__SetCallback
	add r0, r4, #0x100
	ldrh r1, [r0, #0xd8]
	add r0, r4, #0x114
	bl FontAnimator__SetMsgSequence
	add r0, r4, #0x114
	mov r1, #0
	bl FontAnimator__SetDialog
	add r0, r4, #0x114
	bl FontAnimator__LoadMappingsFunc
	add r0, r4, #0x114
	bl FontAnimator__LoadPaletteFunc
	add sp, sp, #0x28
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158768: .word DoorPuzzleDoor__Func_2158458
	arm_func_end DoorPuzzleDoor__Func_21585FC

	arm_func_start DoorPuzzleDoor__Func_215876C
DoorPuzzleDoor__Func_215876C: // 0x0215876C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x114
	bl FontAnimator__Release
	add r0, r4, #0xb0
	bl FontWindowAnimator__Release
	mov r0, r4
	bl FontWindow__Release
	ldmia sp!, {r4, pc}
	arm_func_end DoorPuzzleDoor__Func_215876C

	arm_func_start DoorPuzzleDoor__Func_2158790
DoorPuzzleDoor__Func_2158790: // 0x02158790
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	mov ip, #0
	add r0, r4, #0xb0
	mov r1, #2
	mov r2, #0xf
	mov r3, #0xa
	str ip, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0xb0
	bl FontWindowAnimator__StartAnimating
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end DoorPuzzleDoor__Func_2158790

	arm_func_start DoorPuzzleDoor__Func_21587C8
DoorPuzzleDoor__Func_21587C8: // 0x021587C8
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xb0
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r4, #0xb0
	bl FontWindowAnimator__Draw
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	add r0, r4, #0xb0
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end DoorPuzzleDoor__Func_21587C8

	arm_func_start DoorPuzzleDoor__Func_2158800
DoorPuzzleDoor__Func_2158800: // 0x02158800
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xb0
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r4, #0xb0
	bl FontWindowAnimator__Draw
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	add r0, r4, #0xb0
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0xb0
	bl FontWindowAnimator__SetWindowClosed
	mov r0, #1
	ldmia sp!, {r4, pc}
	arm_func_end DoorPuzzleDoor__Func_2158800

	arm_func_start DoorPuzzleDoor__Func_2158844
DoorPuzzleDoor__Func_2158844: // 0x02158844
	ldr ip, _02158850 // =FontWindowAnimator__SetWindowOpen
	add r0, r0, #0xb0
	bx ip
	.align 2, 0
_02158850: .word FontWindowAnimator__SetWindowOpen
	arm_func_end DoorPuzzleDoor__Func_2158844

	arm_func_start DoorPuzzleDoor__Func_2158854
DoorPuzzleDoor__Func_2158854: // 0x02158854
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	add r0, r4, #0x114
	bl FontAnimator__ClearPixels
	add r0, r4, #0x114
	bl FontAnimator__Draw
	mov r3, #0
	add r0, r4, #0xb0
	mov r1, #5
	mov r2, #0xf
	str r3, [sp]
	mov r3, #0xa
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0xb0
	bl FontWindowAnimator__StartAnimating
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end DoorPuzzleDoor__Func_2158854

	arm_func_start ovl04_215889C
ovl04_215889C: // 0x0215889C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xb0
	bl FontWindowAnimator__Draw
	add r0, r4, #0x114
	mov r1, #1
	bl FontAnimator__LoadCharacters
	add r0, r4, #0x114
	bl FontAnimator__Draw
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	mov r0, r4
	bl DoorPuzzleDoor__Func_21584C8
	mov r0, r4
	bl DoorPuzzleDoor__Func_215851C
	mov r0, r4
	bl DoorPuzzleDoor__Func_215858C
	ldmia sp!, {r4, pc}
	arm_func_end ovl04_215889C

	arm_func_start DoorPuzzleDoor__Func_21588E4
DoorPuzzleDoor__Func_21588E4: // 0x021588E4
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xb0
	bl FontWindowAnimator__Draw
	add r0, r4, #0x114
	mov r1, #0
	bl FontAnimator__LoadCharacters
	add r0, r4, #0x114
	bl FontAnimator__Draw
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	ldmia sp!, {r4, pc}
	arm_func_end DoorPuzzleDoor__Func_21588E4

	arm_func_start DoorPuzzleDoor__Func_2158914
DoorPuzzleDoor__Func_2158914: // 0x02158914
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x114
	bl FontAnimator__IsLastDialog
	cmp r0, #0
	beq _0215894C
	add r0, r4, #0x100
	ldrh r1, [r0, #0xd8]
	add r0, r4, #0x114
	bl FontAnimator__SetMsgSequence
	add r0, r4, #0x114
	mov r1, #0
	bl FontAnimator__SetDialog
	b _02158978
_0215894C:
	add r0, r4, #0x114
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	beq _02158978
	add r0, r4, #0x114
	bl FontAnimator__GetDialogID
	add r0, r0, #1
	mov r1, r0, lsl #0x10
	add r0, r4, #0x114
	mov r1, r1, lsr #0x10
	bl FontAnimator__SetDialog
_02158978:
	add r0, r4, #0x114
	bl FontAnimator__LoadMappingsFunc
	add r0, r4, #0x114
	bl FontAnimator__LoadPaletteFunc
	ldmia sp!, {r4, pc}
	arm_func_end DoorPuzzleDoor__Func_2158914

	arm_func_start Task__Unknown215898C__Create
Task__Unknown215898C__Create: // 0x0215898C
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r1, #0x3000
	mov r6, r0
	mov r2, #0
	str r1, [sp]
	mov r4, #1
	str r4, [sp, #4]
	mov r4, #0x1ec
	ldr r0, _02158A20 // =Task__Unknown215898C__Main
	ldr r1, _02158A24 // =Task__Unknown215898C__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r5, r0
	mov r1, r5
	mov r0, #0
	mov r2, r4
	bl MIi_CpuClear16
	str r6, [r5, #4]
	ldr r4, _02158A28 // =0x02162ABE
	mov r6, #0
_021589E8:
	mov r1, r6, lsl #2
	add r0, r4, r6, lsl #2
	ldrsh r2, [r4, r1]
	ldrsh r3, [r0, #2]
	mov r0, r5
	mov r1, r6
	bl Task__Unknown215898C__Func_2158CAC
	add r6, r6, #1
	cmp r6, #3
	blt _021589E8
	bl AllocSndHandle
	str r0, [r5, #8]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02158A20: .word Task__Unknown215898C__Main
_02158A24: .word Task__Unknown215898C__Destructor
_02158A28: .word 0x02162ABE
	arm_func_end Task__Unknown215898C__Create

	arm_func_start Task__Unknown215898C__Destructor
Task__Unknown215898C__Destructor: // 0x02158A2C
	stmdb sp!, {r4, r5, r6, lr}
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #8]
	bl FreeSndHandle
	add r5, r4, #0x28
	add r6, r4, #0x8c
	mov r4, #0
_02158A4C:
	mov r0, r5
	bl AnimatorSprite__Release
	mov r0, r6
	bl ReleasePaletteAnimator
	add r4, r4, #1
	cmp r4, #3
	add r5, r5, #0xa0
	add r6, r6, #0xa0
	blt _02158A4C
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end Task__Unknown215898C__Destructor

	arm_func_start Task__Unknown215898C__Main
Task__Unknown215898C__Main: // 0x02158A74
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #4]
	ldr r1, [r1, #0xac]
	cmp r1, #2
	bne _02158AC4
	bl Task__Unknown215898C__Func_2158E14
	mov r0, r4
	bl Task__Unknown21590E0__Create
	ldr r1, _02158AF8 // =Task__Unknown215898C__Func_2158F04
	ldr r0, _02158AFC // =Task__Unknown215898C__Func_2158ED0
	mov r2, #0
_02158AA8:
	str r1, [r4, #0x20]
	add r2, r2, #1
	str r0, [r4, #0x24]
	cmp r2, #3
	add r4, r4, #0xa0
	blt _02158AA8
	b _02158AEC
_02158AC4:
	bl Task__Unknown215898C__Func_2158E24
	mov r2, #0
	ldr r0, _02158AFC // =Task__Unknown215898C__Func_2158ED0
	mov r1, r2
_02158AD4:
	str r1, [r4, #0x20]
	add r2, r2, #1
	str r0, [r4, #0x24]
	cmp r2, #3
	add r4, r4, #0xa0
	blt _02158AD4
_02158AEC:
	ldr r0, _02158B00 // =Task__Unknown215898C__Main_2158B04
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158AF8: .word Task__Unknown215898C__Func_2158F04
_02158AFC: .word Task__Unknown215898C__Func_2158ED0
_02158B00: .word Task__Unknown215898C__Main_2158B04
	arm_func_end Task__Unknown215898C__Main

	arm_func_start Task__Unknown215898C__Main_2158B04
Task__Unknown215898C__Main_2158B04: // 0x02158B04
	stmdb sp!, {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r6, r4, #0xc
	mov r5, #0
_02158B18:
	ldr r1, [r6, #0x14]
	cmp r1, #0
	beq _02158B2C
	mov r0, r6
	blx r1
_02158B2C:
	ldr r1, [r6, #0x18]
	cmp r1, #0
	beq _02158B40
	mov r0, r6
	blx r1
_02158B40:
	add r5, r5, #1
	cmp r5, #3
	add r6, r6, #0xa0
	blt _02158B18
	ldr r0, [r4, #4]
	ldr r0, [r0, #0xac]
	cmp r0, #2
	bne _02158BA4
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02158B8C
	ldr r0, _02158C78 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	beq _02158B8C
	ldr r0, [r4, #4]
	mov r1, #0
	str r1, [r0, #0xb8]
	b _02158BA4
_02158B8C:
	ldr r2, [r4, #4]
	ldr r0, _02158C7C // =0x0000FFFF
	ldr r1, [r2, #0xb8]
	cmp r1, r0
	addlo r0, r1, #1
	strlo r0, [r2, #0xb8]
_02158BA4:
	ldr r0, [r4, #4]
	ldr r0, [r0, #0xb0]
	tst r0, #8
	mov r0, r4
	beq _02158BFC
	mov r2, #0
	mov r1, r2
_02158BC0:
	add r2, r2, #1
	str r1, [r0, #0x20]
	cmp r2, #3
	add r0, r0, #0xa0
	blt _02158BC0
	ldr r0, [r4, #8]
	ldr r2, [r0, #0]
	cmp r2, #0
	beq _02158BF0
	bl NNS_SndPlayerStopSeq
	ldr r0, [r4, #8]
	bl NNS_SndHandleReleaseSeq
_02158BF0:
	mov r0, r4
	bl Task__Unknown215898C__Func_2158E24
	ldmia sp!, {r4, r5, r6, pc}
_02158BFC:
	bl Task__Unknown215898C__Func_2158C80
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r2, #0
	mov r0, r4
	mov r1, r2
_02158C14:
	add r2, r2, #1
	str r1, [r0, #0x20]
	cmp r2, #3
	add r0, r0, #0xa0
	blt _02158C14
	ldr r0, [r4, #8]
	ldr r2, [r0, #0]
	cmp r2, #0
	beq _02158C44
	bl NNS_SndPlayerStopSeq
	ldr r0, [r4, #8]
	bl NNS_SndHandleReleaseSeq
_02158C44:
	ldr r0, [r4, #4]
	ldr r0, [r0, #0xb0]
	tst r0, #2
	bne _02158C5C
	mov r0, r4
	bl Task__Unknown2159504__Create
_02158C5C:
	ldr r2, [r4, #4]
	mov r0, r4
	ldr r1, [r2, #0xb0]
	orr r1, r1, #2
	str r1, [r2, #0xb0]
	bl Task__Unknown215898C__Func_2158E24
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02158C78: .word touchInput
_02158C7C: .word 0x0000FFFF
	arm_func_end Task__Unknown215898C__Main_2158B04

	arm_func_start Task__Unknown215898C__Func_2158C80
Task__Unknown215898C__Func_2158C80: // 0x02158C80
	mov r2, #0
_02158C84:
	ldr r1, [r0, #0x18]
	tst r1, #1
	moveq r0, #0
	bxeq lr
	add r2, r2, #1
	cmp r2, #3
	add r0, r0, #0xa0
	blt _02158C84
	mov r0, #1
	bx lr
	arm_func_end Task__Unknown215898C__Func_2158C80

	arm_func_start Task__Unknown215898C__Func_2158CAC
Task__Unknown215898C__Func_2158CAC: // 0x02158CAC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x1c
	mov r7, r1
	mov r1, #0xa0
	mul r6, r7, r1
	mov r8, r0
	add r4, r8, #0xc
	add r5, r4, r6
	str r8, [r5, #0x10]
	strh r2, [r4, r6]
	strh r3, [r5, #2]
	strh r2, [r4, r6]
	ldr r0, _02158DAC // =0x02162A80
	strh r3, [r5, #2]
	mov r1, r7, lsl #1
	ldrh r0, [r0, r1]
	mov r1, #0
	strh r0, [r5, #4]
	ldr r0, [r8, #4]
	ldr r0, [r0, #0]
	bl FileUnknown__GetAOUFile
	mov r9, r0
	bl Sprite__GetSpriteSize3
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov ip, #1
	str ip, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	mov r3, #4
	str r3, [sp, #0xc]
	str r2, [sp, #0x10]
	mov r0, #3
	str r0, [sp, #0x14]
	str ip, [sp, #0x18]
	add r0, r8, #0x28
	ldr r2, _02158DB0 // =0x02162A8C
	mov ip, r7, lsl #1
	ldrh r2, [r2, ip]
	mov r1, r9
	add r0, r0, r6
	bl AnimatorSprite__Init
	strh r7, [r5, #0x6c]
	ldrsh r0, [r4, r6]
	mov r1, #6
	strh r0, [r5, #0x24]
	ldrsh r0, [r5, #2]
	strh r0, [r5, #0x26]
	ldr r0, [r8, #4]
	ldr r0, [r0, #0]
	bl FileUnknown__GetAOUFile
	add r2, r8, #0x8c
	mov r1, r0
	add r0, r2, r6
	mov r3, r7, lsl #9
	mov r2, #4
	stmia sp, {r2, r3}
	mov r2, #0
	mov r3, #2
	bl InitPaletteAnimator
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02158DAC: .word 0x02162A80
_02158DB0: .word 0x02162A8C
	arm_func_end Task__Unknown215898C__Func_2158CAC

	arm_func_start Task__Unknown215898C__Func_2158DB4
Task__Unknown215898C__Func_2158DB4: // 0x02158DB4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xc]
	tst r0, #2
	ldreq r0, [r4, #0x58]
	biceq r0, r0, #0x10
	beq _02158DE8
	add r0, r4, #0x80
	bl AnimatePalette
	add r0, r4, #0x80
	bl DrawAnimatedPalette
	ldr r0, [r4, #0x58]
	orr r0, r0, #0x10
_02158DE8:
	mov r1, #0
	str r0, [r4, #0x58]
	mov r2, r1
	add r0, r4, #0x1c
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0x1000
	ldrh r3, [r4, #4]
	mov r2, r1
	add r0, r4, #0x1c
	bl AnimatorSprite__DrawFrameRotoZoom
	ldmia sp!, {r4, pc}
	arm_func_end Task__Unknown215898C__Func_2158DB4

	arm_func_start Task__Unknown215898C__Func_2158E14
Task__Unknown215898C__Func_2158E14: // 0x02158E14
	ldr ip, _02158E20 // =StartSamplingTouchInput
	mov r0, #4
	bx ip
	.align 2, 0
_02158E20: .word StartSamplingTouchInput
	arm_func_end Task__Unknown215898C__Func_2158E14

	arm_func_start Task__Unknown215898C__Func_2158E24
Task__Unknown215898C__Func_2158E24: // 0x02158E24
	ldr ip, _02158E2C // =StopSamplingTouchInput
	bx ip
	.align 2, 0
_02158E2C: .word StopSamplingTouchInput
	arm_func_end Task__Unknown215898C__Func_2158E24

	arm_func_start Task__Unknown215898C__Func_2158E30
Task__Unknown215898C__Func_2158E30: // 0x02158E30
	ldrh r2, [r0, #4]
	ldr r1, _02158ECC // =0x0000FDDE
	cmp r2, r1
	bgt _02158E4C
	rsb r1, r1, #0x10000
	cmp r2, r1
	bge _02158E80
_02158E4C:
	ldr r1, [r0, #0xc]
	orr r1, r1, #2
	str r1, [r0, #0xc]
	tst r1, #1
	bne _02158E98
	ldrh r1, [r0, #6]
	add r1, r1, #1
	strh r1, [r0, #6]
	ldrh r1, [r0, #6]
	cmp r1, #0x28
	movhi r1, #0x28
	strhih r1, [r0, #6]
	b _02158E98
_02158E80:
	mov r1, #0
	strh r1, [r0, #6]
	ldr r1, [r0, #0xc]
	bic r1, r1, #1
	bic r1, r1, #2
	str r1, [r0, #0xc]
_02158E98:
	ldrh r1, [r0, #6]
	cmp r1, #0x28
	bxlo lr
	ldr r1, [r0, #0x10]
	mov r3, #2
	ldr r2, [r1, #4]
	mov r1, #0
	str r3, [r2, #0xbc]
	ldr r2, [r0, #0xc]
	orr r2, r2, #1
	str r2, [r0, #0xc]
	strh r1, [r0, #6]
	bx lr
	.align 2, 0
_02158ECC: .word 0x0000FDDE
	arm_func_end Task__Unknown215898C__Func_2158E30

	arm_func_start Task__Unknown215898C__Func_2158ED0
Task__Unknown215898C__Func_2158ED0: // 0x02158ED0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl Task__Unknown215898C__Func_2158DB4
	ldr r0, _02158EE8 // =Task__Unknown215898C__Func_2158EEC
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02158EE8: .word Task__Unknown215898C__Func_2158EEC
	arm_func_end Task__Unknown215898C__Func_2158ED0

	arm_func_start Task__Unknown215898C__Func_2158EEC
Task__Unknown215898C__Func_2158EEC: // 0x02158EEC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl Task__Unknown215898C__Func_2158DB4
	mov r0, r4
	bl Task__Unknown215898C__Func_2158E30
	ldmia sp!, {r4, pc}
	arm_func_end Task__Unknown215898C__Func_2158EEC

	arm_func_start Task__Unknown215898C__Func_2158F04
Task__Unknown215898C__Func_2158F04: // 0x02158F04
	ldr r1, _02158F10 // =Task__Unknown215898C__Func_2158F14
	str r1, [r0, #0x14]
	bx lr
	.align 2, 0
_02158F10: .word Task__Unknown215898C__Func_2158F14
	arm_func_end Task__Unknown215898C__Func_2158F04

	arm_func_start Task__Unknown215898C__Func_2158F14
Task__Unknown215898C__Func_2158F14: // 0x02158F14
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x20
	mov r5, r0
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #0]
	tst r0, #1
	addeq sp, sp, #0x20
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _021590A8
	ldr r0, _021590DC // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	beq _021590A8
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02158F6C
	ldr r0, _021590DC // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	bne _021590A8
_02158F6C:
	ldr r2, _021590DC // =touchInput
	mov r4, #0
	ldrh r3, [r2, #0x14]
	add r0, sp, #8
	add r1, sp, #0x14
	mov r3, r3, lsl #0xc
	str r3, [sp, #0x14]
	ldrh r2, [r2, #0x16]
	mov r2, r2, lsl #0xc
	str r2, [sp, #0x18]
	str r4, [sp, #0x1c]
	ldrsh r3, [r5, #2]
	ldrsh r2, [r5, #0]
	mov r3, r3, lsl #0xc
	mov r2, r2, lsl #0xc
	str r2, [sp, #8]
	str r3, [sp, #0xc]
	str r4, [sp, #0x10]
	bl VEC_Distance
	cmp r0, #0x22000
	addge sp, sp, #0x20
	ldmgeia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r2, _021590DC // =touchInput
	ldr r4, [sp, #0x18]
	ldr r0, [sp, #0xc]
	ldr r3, [sp, #0x14]
	ldr r1, [sp, #8]
	sub r0, r4, r0
	sub r1, r3, r1
	ldrh r7, [r2, #0x1a]
	ldrh r6, [r2, #0x18]
	bl FX_Atan2Idx
	ldr r1, [sp, #8]
	ldr r2, [sp, #0xc]
	mov r4, r0
	rsb r0, r2, r7, lsl #12
	rsb r1, r1, r6, lsl #12
	bl FX_Atan2Idx
	subs r1, r4, r0
	rsbmi r0, r1, #0
	movpl r0, r1
	cmp r0, #0x8000
	ble _0215902C
	cmp r1, #0
	movlt r0, #0x10000
	rsbge r1, r1, #0x10000
	rsblt r0, r0, #0
	sublt r1, r0, r1
_0215902C:
	mov r0, r1, asr #4
	mov r0, r0, lsl #0x10
	movs r4, r0, lsr #0x10
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #8]
	beq _02159074
	ldr r1, [r0, #0]
	cmp r1, #0
	bne _02159094
	mov ip, #3
	sub r1, ip, #4
	mov r2, #0x23
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	str ip, [sp, #4]
	bl PlaySfxEx
	b _02159094
_02159074:
	ldr r1, [r0, #0]
	cmp r1, #0
	beq _02159094
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #8]
	bl NNS_SndHandleReleaseSeq
_02159094:
	ldrh r0, [r5, #4]
	add sp, sp, #0x20
	add r0, r0, r4
	strh r0, [r5, #4]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_021590A8:
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #8]
	ldr r1, [r0, #0]
	cmp r1, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	ldr r0, [r5, #0x10]
	ldr r0, [r0, #8]
	bl NNS_SndHandleReleaseSeq
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021590DC: .word touchInput
	arm_func_end Task__Unknown215898C__Func_2158F14

	arm_func_start Task__Unknown21590E0__Create
Task__Unknown21590E0__Create: // 0x021590E0
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x1c
	mov r1, #0x3000
	mov r6, r0
	mov r2, #0
	str r1, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x70
	ldr r0, _021591BC // =Task__Unknown21590E0__Main
	ldr r1, _021591C0 // =Task__Unknown21590E0__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r5, r0
	mov r1, r5
	mov r0, #0
	mov r2, r4
	bl MIi_CpuClear16
	str r6, [r5]
	ldr r0, [r6, #4]
	add r0, r0, #0xa0
	bl DoorPuzzle__Func_21577C8
	bl LoadSpriteButtonTouchpadSprite
	bl GetSpriteButtonTouchpadSprite
	mov r4, r0
	bl Sprite__GetSpriteSize3
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r2, #1
	str r2, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r3, _021591C4 // =0x05000600
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r1, r4
	add r0, r5, #0xc
	mov r3, #4
	str r2, [sp, #0x18]
	bl AnimatorSprite__Init
	mov r0, #0x80
	strh r0, [r5, #0x14]
	mov r0, #0x60
	mov r1, #0
	strh r0, [r5, #0x16]
	add r0, r5, #0xc
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_021591BC: .word Task__Unknown21590E0__Main
_021591C0: .word Task__Unknown21590E0__Destructor
_021591C4: .word 0x05000600
	arm_func_end Task__Unknown21590E0__Create

	arm_func_start Task__Unknown21590E0__Destructor
Task__Unknown21590E0__Destructor: // 0x021591C8
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0]
	ldr r0, [r0, #4]
	add r0, r0, #0xa0
	bl DoorPuzzle__Func_21578A0
	add r0, r4, #0xc
	bl AnimatorSprite__Release
	bl ReleaseSpriteButtonTouchpadSprite
	ldmia sp!, {r4, pc}
	arm_func_end Task__Unknown21590E0__Destructor

	arm_func_start Task__Unknown21590E0__Main
Task__Unknown21590E0__Main: // 0x021591F4
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	mov r1, #0x258
	str r1, [r0, #4]
	ldr r0, _02159210 // =Task__Unknown21590E0__Main_2159214
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02159210: .word Task__Unknown21590E0__Main_2159214
	arm_func_end Task__Unknown21590E0__Main

	arm_func_start Task__Unknown21590E0__Main_2159214
Task__Unknown21590E0__Main_2159214: // 0x02159214
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0]
	ldr r1, [r1, #4]
	ldr r1, [r1, #0xb0]
	tst r1, #4
	ldmeqia sp!, {r3, pc}
	bl Task__Unknown21590E0__Func_2159318
	mov r0, #2
	bl PlaySysSfx
	ldr r0, _02159248 // =Task__Unknown21590E0__Main_215924C
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02159248: .word Task__Unknown21590E0__Main_215924C
	arm_func_end Task__Unknown21590E0__Main_2159214

	arm_func_start Task__Unknown21590E0__Main_215924C
Task__Unknown21590E0__Main_215924C: // 0x0215924C
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, r1
	add r0, r4, #0xc
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0xc
	bl AnimatorSprite__DrawFrame
	mov r0, r4
	mov r1, #0x800
	mov r2, #7
	bl Task__Unknown21590E0__Func_2159414
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0215929C
	ldr r0, _021592E0 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	bne _021592B0
_0215929C:
	ldr r0, [r4, #4]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #4]
	ldmneia sp!, {r4, pc}
_021592B0:
	ldrh r0, [r4, #0x1a]
	cmp r0, #0xc
	ldmloia sp!, {r4, pc}
	mov r0, #0
	bl PlaySysSfx
	ldr r2, [r4, #0]
	ldr r0, _021592E4 // =Task__Unknown21590E0__Main_21592E8
	ldr r1, [r2, #0]
	orr r1, r1, #1
	str r1, [r2]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_021592E0: .word touchInput
_021592E4: .word Task__Unknown21590E0__Main_21592E8
	arm_func_end Task__Unknown21590E0__Main_215924C

	arm_func_start Task__Unknown21590E0__Main_21592E8
Task__Unknown21590E0__Main_21592E8: // 0x021592E8
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r1, #0x800
	mov r2, #0xf
	mov r4, r0
	bl Task__Unknown21590E0__Func_2159414
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl Task__Unknown21590E0__Func_21593C8
	bl DestroyCurrentTask
	ldmia sp!, {r4, pc}
	arm_func_end Task__Unknown21590E0__Main_21592E8

	arm_func_start Task__Unknown21590E0__Func_2159318
Task__Unknown21590E0__Func_2159318: // 0x02159318
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x10000
	ldr ip, _021593BC // =0x04001000
	str r0, [r4, #8]
	ldr r1, [ip]
	ldr r0, [ip]
	and r1, r1, #0x1f00
	mov r2, r1, lsr #8
	bic r1, r0, #0x1f00
	bic r0, r2, #2
	orr r3, r1, r0, lsl #8
	ldr r1, _021593C0 // =0x0213D284
	mov r0, #0
	mov r2, #6
	str r3, [ip]
	bl MIi_CpuClear16
	ldr r1, _021593C4 // =renderCoreGFXControlB
	ldrh r0, [r1, #0x20]
	bic r0, r0, #0xc0
	orr r0, r0, #0x40
	strh r0, [r1, #0x20]
	ldrh r0, [r1, #0x20]
	orr r0, r0, #0x100
	strh r0, [r1, #0x20]
	ldrh r0, [r1, #0x20]
	orr r0, r0, #2
	orr r0, r0, #0x1000
	strh r0, [r1, #0x20]
	ldrh r0, [r1, #0x22]
	bic r0, r0, #0x1f
	strh r0, [r1, #0x22]
	ldr r0, [r4, #8]
	ldrh r2, [r1, #0x22]
	mov r0, r0, lsl #4
	mov r0, r0, lsr #0x10
	bic r2, r2, #0x1f00
	mov r0, r0, lsl #0x1b
	orr r0, r2, r0, lsr #19
	strh r0, [r1, #0x22]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021593BC: .word 0x04001000
_021593C0: .word 0x0213D284
_021593C4: .word renderCoreGFXControlB
	arm_func_end Task__Unknown21590E0__Func_2159318

	arm_func_start Task__Unknown21590E0__Func_21593C8
Task__Unknown21590E0__Func_21593C8: // 0x021593C8
	stmdb sp!, {r3, lr}
	mov r1, #0x10000
	str r1, [r0, #8]
	ldr ip, _0215940C // =0x04001000
	ldr r1, _02159410 // =0x0213D284
	ldr r2, [ip]
	ldr r0, [ip]
	and r2, r2, #0x1f00
	mov r3, r2, lsr #8
	bic r2, r0, #0x1f00
	bic r0, r3, #2
	orr r3, r2, r0, lsl #8
	mov r0, #0
	mov r2, #6
	str r3, [ip]
	bl MIi_CpuClear16
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215940C: .word 0x04001000
_02159410: .word 0x0213D284
	arm_func_end Task__Unknown21590E0__Func_21593C8

	arm_func_start Task__Unknown21590E0__Func_2159414
Task__Unknown21590E0__Func_2159414: // 0x02159414
	stmdb sp!, {r3, r4, r5, lr}
	movs r3, r2, lsl #0xc
	movmi r3, #0
	bmi _0215942C
	cmp r3, #0x10000
	movgt r3, #0x10000
_0215942C:
	ldr r5, _021594FC // =0x04001000
	ldr r2, [r0, #8]
	ldr r4, [r5, #0]
	sub r2, r3, r2
	and r4, r4, #0x1f00
	mov r4, r4, lsr #8
	tst r4, #2
	bne _0215946C
	ldr lr, [r5]
	ldr ip, [r5]
	and lr, lr, #0x1f00
	mov r4, lr, lsr #8
	bic lr, ip, #0x1f00
	orr ip, r4, #2
	orr ip, lr, ip, lsl #8
	str ip, [r5]
_0215946C:
	cmp r1, #0
	movlt r1, #0
	blt _02159480
	cmp r1, #0x10000
	movgt r1, #0x10000
_02159480:
	cmp r2, #0
	ldr r2, [r0, #8]
	bge _021594A0
	sub r1, r2, r1
	str r1, [r0, #8]
	cmp r3, r1
	strgt r3, [r0, #8]
	b _021594B0
_021594A0:
	add r1, r2, r1
	str r1, [r0, #8]
	cmp r3, r1
	strlt r3, [r0, #8]
_021594B0:
	ldr r1, [r0, #8]
	movs r1, r1, asr #0xc
	movmi r1, #0
	bmi _021594C8
	cmp r1, #0x10
	movgt r1, #0x10
_021594C8:
	ldr r2, _02159500 // =renderCoreGFXControlB
	mov r1, r1, lsl #0x10
	ldrh ip, [r2, #0x22]
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x1b
	bic ip, ip, #0x1f00
	orr r1, ip, r1, lsr #19
	strh r1, [r2, #0x22]
	ldr r0, [r0, #8]
	cmp r0, r3
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021594FC: .word 0x04001000
_02159500: .word renderCoreGFXControlB
	arm_func_end Task__Unknown21590E0__Func_2159414

	arm_func_start Task__Unknown2159504__Create
Task__Unknown2159504__Create: // 0x02159504
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r1, #0x3000
	mov r5, r0
	mov r2, #0
	str r1, [sp]
	mov r4, #2
	ldr r0, _0215958C // =Task__Unknown2159504__Main
	ldr r1, _02159590 // =Task__Unknown2159504__Destructor
	mov r3, r2
	str r4, [sp, #4]
	mov r4, #0x20
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClear16
	ldr r0, [r5, #4]
	mov r1, #7
	ldr r0, [r0, #0]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	mov r0, r4
	mov r2, #3
	str r2, [sp]
	mov r2, #0
	str r2, [sp, #4]
	mov r3, r2
	bl InitPaletteAnimator
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0215958C: .word Task__Unknown2159504__Main
_02159590: .word Task__Unknown2159504__Destructor
	arm_func_end Task__Unknown2159504__Create

	arm_func_start Task__Unknown2159504__Destructor
Task__Unknown2159504__Destructor: // 0x02159594
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	bl ReleasePaletteAnimator
	ldmia sp!, {r3, pc}
	arm_func_end Task__Unknown2159504__Destructor

	arm_func_start Task__Unknown2159504__Main
Task__Unknown2159504__Main: // 0x021595A4
	stmdb sp!, {r3, lr}
	mov r0, #4
	bl PlaySysSfx
	ldr r0, _021595BC // =Task__Unknown2159504__Main_21595C0
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_021595BC: .word Task__Unknown2159504__Main_21595C0
	arm_func_end Task__Unknown2159504__Main

	arm_func_start Task__Unknown2159504__Main_21595C0
Task__Unknown2159504__Main_21595C0: // 0x021595C0
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl AnimatePalette
	mov r0, r4
	bl DrawAnimatedPalette
	mov r0, r4
	bl CheckPaletteAnimationLooped
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl DestroyCurrentTask
	ldmia sp!, {r4, pc}
	arm_func_end Task__Unknown2159504__Main_21595C0

	arm_func_start DoorPuzzle__Main
DoorPuzzle__Main: // 0x021595F0
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r0, #2
	mov r1, #0x1000
	bl CreateDrawFadeTask
	mov r0, r4
	bl Task__Unknown215898C__Create
	mov r0, #0x25
	mov r1, #1
	bl PlaySysTrack
	ldr r0, _02159628 // =DoorPuzzle__Main_2159648
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02159628: .word DoorPuzzle__Main_2159648
	arm_func_end DoorPuzzle__Main

	arm_func_start DoorPuzzle__Destructor
DoorPuzzle__Destructor: // 0x0215962C
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl ReleaseSysSound
	mov r0, r4
	bl DoorPuzzle__Func_215771C
	ldmia sp!, {r4, pc}
	arm_func_end DoorPuzzle__Destructor

	arm_func_start DoorPuzzle__Main_2159648
DoorPuzzle__Main_2159648: // 0x02159648
	stmdb sp!, {r3, lr}
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, _02159664 // =DoorPuzzle__Main_2159668
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02159664: .word DoorPuzzle__Main_2159668
	arm_func_end DoorPuzzle__Main_2159648

	arm_func_start DoorPuzzle__Main_2159668
DoorPuzzle__Main_2159668: // 0x02159668
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0xb0]
	orr r1, r1, #4
	str r1, [r0, #0xb0]
	bl DoorPuzzleDoor__Create
	ldr r0, _0215968C // =DoorPuzzle__Main_2159690
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215968C: .word DoorPuzzle__Main_2159690
	arm_func_end DoorPuzzle__Main_2159668

	arm_func_start DoorPuzzle__Main_2159690
DoorPuzzle__Main_2159690: // 0x02159690
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0xb0]
	tst r1, #1
	ldmeqia sp!, {r3, pc}
	ldr r1, [r0, #0xb4]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0xb4]
	ldmneia sp!, {r3, pc}
	ldr r0, _021596C4 // =DoorPuzzle__Main_21596C8
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_021596C4: .word DoorPuzzle__Main_21596C8
	arm_func_end DoorPuzzle__Main_2159690

	arm_func_start DoorPuzzle__Main_21596C8
DoorPuzzle__Main_21596C8: // 0x021596C8
	stmdb sp!, {r3, lr}
	mov r0, #4
	mov r1, #0x1000
	bl CreateDrawFadeTask
	mov r0, #0x14
	bl FadeSysTrack
	ldr r0, _021596EC // =DoorPuzzle__Main_21596F0
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_021596EC: .word DoorPuzzle__Main_21596F0
	arm_func_end DoorPuzzle__Main_21596C8

	arm_func_start DoorPuzzle__Main_21596F0
DoorPuzzle__Main_21596F0: // 0x021596F0
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl DestroyDrawFadeTask
	mov r0, r4
	bl DoorPuzzle__Func_21578D8
	bl DoorPuzzle__Func_215741C
	ldmia sp!, {r4, pc}
	arm_func_end DoorPuzzle__Main_21596F0

    .data
    
_02162A80:
	.hword 0x4000, 0xC000, 0x8000

_02162A86:
	.hword 26, 27, 28

_02162A8C:
	.word 0x10000, 0x10002, 0x30002, 4

_02162A9C:
	.hword 6, 7, 7, 8, 0xC, 0x30, 0x40, 0x80, 0x40, 0xD0, 0x40

_02162AB2:
	.hword 8, 9, 0xA, 0xB, 9, 0xC, 0x80, 0x3A, 0x56, 0x85, 0xAA, 0x85, 0

_02162ACC:
	.word 0, 0x10001, 0x10000, 0x20001, 0x30000, 0

aNarcDmpzLz7Nar: // 0x02162AE4
	.asciz "/narc/dmpz_lz7.narc"
	.align 4

aNarcTkdmLz7Nar_ovl04: // 0x02162AF8
	.asciz "/narc/tkdm_lz7.narc"
	.align 4

aFntFontAllFnt_2_ovl04: // 0x02162B0C
	.asciz "fnt/font_all.fnt"
	.align 4

aBbTkdmCutinBb: // 0x02162B20
	.asciz "/bb/tkdm_cutin.bb"
	.align 4