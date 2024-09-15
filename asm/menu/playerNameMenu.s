	.include "asm/macros.inc"
	.include "global.inc"

	.text

arm_func_start PlayerNameMenu__Create
PlayerNameMenu__Create: // 0x02160E58
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x1c
	mov r2, #0
	str r2, [sp]
	ldr r0, _02160ED4 // =PlayerNameMenu__Main
	ldr r1, _02160ED8 // =PlayerNameMenu__Destructor
	mov r3, r2
	str r2, [sp, #4]
	mov r4, #0xb4
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0xb4
	bl MIi_CpuClear16
	mov r0, r4
	bl PlayerNameMenu__Func_2160EDC
	bl ResetTouchInput
	add r0, sp, #0xc
	bl PlayerNameMenu__GetSaveName
	mov r2, r4
	mov r0, #0
	add r1, sp, #0xc
	bl NameMenu__Create
	bl LoadSysSoundVillage
	mov r0, #0
	bl PlaySysVillageTrack
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02160ED4: .word PlayerNameMenu__Main
_02160ED8: .word PlayerNameMenu__Destructor
	arm_func_end PlayerNameMenu__Create

	arm_func_start PlayerNameMenu__Func_2160EDC
PlayerNameMenu__Func_2160EDC: // 0x02160EDC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl PlayerNameMenu__Func_2160F04
	mov r0, r4
	bl PlayerNameMenu__Func_2160FE4
	mov r0, r4
	bl PlayerNameMenu__Func_2161028
	mov r0, r4
	bl NameMenu__LoadAssets_ARM
	ldmia sp!, {r4, pc}
	arm_func_end PlayerNameMenu__Func_2160EDC

	arm_func_start PlayerNameMenu__Func_2160F04
PlayerNameMenu__Func_2160F04: // 0x02160F04
	stmdb sp!, {r3, lr}
	mov r0, #0
	bl VRAMSystem__Init
	ldr r0, _02160FD0 // =renderCurrentDisplay
	mov r2, #1
	ldr r1, _02160FD4 // =renderCoreGFXControlA
	str r2, [r0]
	ldrsh r0, [r1, #0x58]
	cmp r0, #0
	bgt _02160F44
	ldr r0, _02160FD8 // =renderCoreGFXControlB
	sub r2, r2, #0x11
	strh r2, [r0, #0x58]
	ldrsh r0, [r0, #0x58]
	strh r0, [r1, #0x58]
	b _02160F54
_02160F44:
	ldr r0, _02160FD8 // =renderCoreGFXControlB
	mov r2, #0x10
	strh r2, [r0, #0x58]
	strh r2, [r1, #0x58]
_02160F54:
	mov r1, #0
	mov r2, r1
	mov r0, #1
	bl GX_SetGraphicsMode
	mov r2, #0x4000000
	ldr r1, [r2]
	mov r0, #0
	bic r1, r1, #0x1f00
	str r1, [r2]
	bl GXS_SetGraphicsMode
	ldr r3, _02160FDC // =0x04001000
	mov r0, #0
	ldr r2, [r3]
	mov r1, #0x6000000
	bic ip, r2, #0x1f00
	mov r2, #0x80000
	str ip, [r3]
	bl MIi_CpuClearFast
	mov r0, #0
	mov r1, #0x6200000
	mov r2, #0x20000
	bl MIi_CpuClearFast
	mov r0, #0
	mov r1, #0x5000000
	mov r2, #0x200
	bl MIi_CpuClear16
	mov r0, #0
	ldr r1, _02160FE0 // =0x05000400
	mov r2, #0x200
	bl MIi_CpuClear16
	ldmia sp!, {r3, pc}
	.align 2, 0
_02160FD0: .word renderCurrentDisplay
_02160FD4: .word renderCoreGFXControlA
_02160FD8: .word renderCoreGFXControlB
_02160FDC: .word 0x04001000
_02160FE0: .word 0x05000400
	arm_func_end PlayerNameMenu__Func_2160F04

	arm_func_start PlayerNameMenu__Func_2160FE4
PlayerNameMenu__Func_2160FE4: // 0x02160FE4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _02161024 // =aFntFontAllFnt_3_ovl04
	mov r1, #0
	bl FSRequestFileSync
	str r0, [r4, #0xb0]
	mov r0, r4
	bl FontWindow__Init
	ldr r1, [r4, #0xb0]
	mov r0, r4
	mov r2, #1
	bl FontWindow__LoadFromMemory
	mov r0, r4
	mov r1, #0
	bl FontWindow__SetDMA
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161024: .word aFntFontAllFnt_3_ovl04
	arm_func_end PlayerNameMenu__Func_2160FE4

	arm_func_start PlayerNameMenu__Func_2161028
PlayerNameMenu__Func_2161028: // 0x02161028
	bx lr
	arm_func_end PlayerNameMenu__Func_2161028

	arm_func_start NameMenu__LoadAssets_ARM
NameMenu__LoadAssets_ARM: // 0x0216102C
	ldr ip, _02161034 // =NameMenu__LoadAssets
	bx ip
	.align 2, 0
_02161034: .word NameMenu__LoadAssets
	arm_func_end NameMenu__LoadAssets_ARM

	arm_func_start PlayerNameMenu__Func_2161038
PlayerNameMenu__Func_2161038: // 0x02161038
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl PlayerNameMenu__Func_2161090
	mov r0, r4
	bl PlayerNameMenu__Func_216108C
	mov r0, r4
	bl PlayerNameMenu__Func_2161064
	mov r0, r4
	bl PlayerNameMenu__Func_2161060
	ldmia sp!, {r4, pc}
	arm_func_end PlayerNameMenu__Func_2161038

	arm_func_start PlayerNameMenu__Func_2161060
PlayerNameMenu__Func_2161060: // 0x02161060
	bx lr
	arm_func_end PlayerNameMenu__Func_2161060

	arm_func_start PlayerNameMenu__Func_2161064
PlayerNameMenu__Func_2161064: // 0x02161064
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl FontWindow__Release
	ldr r0, [r4, #0xb0]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0xb0]
	ldmia sp!, {r4, pc}
	arm_func_end PlayerNameMenu__Func_2161064

	arm_func_start PlayerNameMenu__Func_216108C
PlayerNameMenu__Func_216108C: // 0x0216108C
	bx lr
	arm_func_end PlayerNameMenu__Func_216108C

	arm_func_start PlayerNameMenu__Func_2161090
PlayerNameMenu__Func_2161090: // 0x02161090
	ldr ip, _02161098 // =NameMenu__Func_215EE98
	bx ip
	.align 2, 0
_02161098: .word NameMenu__Func_215EE98
	arm_func_end PlayerNameMenu__Func_2161090

	arm_func_start PlayerNameMenu__Main
PlayerNameMenu__Main: // 0x0216109C
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl NameMenu__Func_215EE68
	cmp r0, #0
	beq _02161108
	bl NameMenu__Func_215EE80
	cmp r0, #0
	beq _021610E8
	bl NameMenu__Func_215EE8C
	bl PlayerNameMenu__SetSaveName
	cmp r0, #0
	bne _021610E8
	bl DestroyCurrentTask
	bl ReleaseSysSound
	mov r0, #1
	bl RequestSysEventChange
	bl NextSysEvent
	ldmia sp!, {r4, pc}
_021610E8:
	bl DestroyCurrentTask
	ldr r1, _02161114 // =gameState
	mov r2, #1
	mov r0, #0
	strb r2, [r1, #0xdc]
	bl RequestSysEventChange
	bl NextSysEvent
	ldmia sp!, {r4, pc}
_02161108:
	mov r0, r4
	bl FontWindow__PrepareSwapBuffer
	ldmia sp!, {r4, pc}
	.align 2, 0
_02161114: .word gameState
	arm_func_end PlayerNameMenu__Main

	arm_func_start PlayerNameMenu__Destructor
PlayerNameMenu__Destructor: // 0x02161118
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	bl PlayerNameMenu__Func_2161038
	ldmia sp!, {r3, pc}
	arm_func_end PlayerNameMenu__Destructor

	arm_func_start PlayerNameMenu__GetSaveName
PlayerNameMenu__GetSaveName: // 0x02161128
	ldr ip, _0216113C // =MIi_CpuCopy16
	mov r1, r0
	ldr r0, _02161140 // =saveGame
	mov r2, #0x10
	bx ip
	.align 2, 0
_0216113C: .word MIi_CpuCopy16
_02161140: .word saveGame
	arm_func_end PlayerNameMenu__GetSaveName

	arm_func_start PlayerNameMenu__SetSaveName
PlayerNameMenu__SetSaveName: // 0x02161144
	stmdb sp!, {r3, lr}
	ldr r1, _02161160 // =saveGame
	mov r2, #0x10
	bl MIi_CpuCopy16
	mov r0, #2
	bl TrySaveGameData
	ldmia sp!, {r3, pc}
	.align 2, 0
_02161160: .word saveGame
	arm_func_end PlayerNameMenu__SetSaveName

    .data

aFntFontAllFnt_3_ovl04: // 0x02162E2C
	.asciz "fnt/font_all.fnt"
	.align 4
