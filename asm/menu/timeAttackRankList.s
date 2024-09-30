	.include "asm/macros.inc"
	.include "global.inc"

	.text
    
    thumb_func_start TimeAttackRankList__Create
TimeAttackRankList__Create: // 0x0216F60C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x5c
	mov r5, r0
	ldr r0, [sp, #0x74]
	str r3, [sp, #0x34]
	str r0, [sp, #0x74]
	mov r0, r2
	str r0, [r5, #0x10]
	add r0, sp, #0x60
	ldrh r0, [r0, #0x10]
	str r2, [sp, #0x30]
	mov r2, #0
	strh r0, [r5, #0x14]
	str r1, [r5, #8]
	ldr r0, _0216F858 // =aBbDmwfRankLang
	mov r1, #6
	mov r3, #1
	str r2, [sp]
	bl ArchiveFile__Load
	mov r1, #0x97
	lsl r1, r1, #2
	str r0, [r5, r1]
	ldr r0, [r5, r1]
	add r1, r1, #4
	add r1, r5, r1
	mov r2, #1
	mov r3, #0
	bl StageClear__LoadFiles
	mov r0, #0x9a
	lsl r0, r0, #2
	add r6, r5, r0
	add r0, sp, #0x60
	ldrh r0, [r0, #0x10]
	ldr r4, _0216F85C // =0x0217E0A4
	mov r7, #0
	str r0, [sp, #0x3c]
_0216F658:
	ldrh r0, [r4, #0]
	ldrh r2, [r4, #2]
	lsl r0, r0, #2
	add r1, r5, r0
	mov r0, #0x97
	lsl r0, r0, #2
	ldr r0, [r1, r0]
	ldr r1, [sp, #0x30]
	bl SpriteUnknown__Func_204C3CC
	ldr r1, [sp, #0x30]
	ldr r3, _0216F860 // =0x00000804
	str r1, [sp]
	str r0, [sp, #4]
	ldrb r1, [r4, #8]
	ldr r0, [sp, #0x3c]
	add r0, r1, r0
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	str r0, [sp, #8]
	ldr r0, [sp, #0x34]
	str r0, [sp, #0xc]
	ldrb r0, [r4, #9]
	str r0, [sp, #0x10]
	ldrh r1, [r4, #0]
	mov r0, r6
	lsl r1, r1, #2
	add r2, r5, r1
	mov r1, #0x97
	lsl r1, r1, #2
	ldr r1, [r2, r1]
	ldrh r2, [r4, #2]
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r7, r7, #1
	add r6, #0x64
	add r4, #0xa
	cmp r7, #7
	blo _0216F658
	ldr r0, _0216F864 // =gameState
	ldr r0, [r0, #4]
	cmp r0, #0
	bne _0216F6BC
	mov r1, #7
	b _0216F6BE
_0216F6BC:
	mov r1, #8
_0216F6BE:
	mov r0, #0xb3
	lsl r0, r0, #2
	add r0, r5, r0
	bl AnimatorSprite__SetAnimation
	ldr r1, _0216F868 // =0x00000594
	mov r7, #0
	sub r0, r1, #4
	ldrsh r2, [r5, r1]
	ldrsh r0, [r5, r0]
	mov r4, r5
	mov r6, r7
	sub r0, r2, r0
	str r0, [sp, #0x44]
	sub r0, r1, #2
	sub r1, r1, #6
	ldrsh r0, [r5, r0]
	ldrsh r1, [r5, r1]
	sub r0, r0, r1
	lsr r0, r0, #1
	str r0, [sp, #0x40]
_0216F6E8:
	ldr r0, _0216F86C // =0x0000058E
	ldrsh r1, [r5, r0]
	ldr r0, [sp, #0x40]
	add r1, r1, r0
	ldr r0, _0216F870 // =0x00000566
	strh r1, [r4, r0]
	mov r0, r6
	mov r1, #5
	bl _u32_div_f
	mov r1, #0x59
	lsl r1, r1, #4
	ldrsh r1, [r5, r1]
	add r7, r7, #1
	add r1, r1, r0
	ldr r0, _0216F874 // =0x00000568
	add r1, #0xc0
	strh r1, [r4, r0]
	ldr r0, [sp, #0x44]
	add r4, r4, #4
	add r6, r6, r0
	cmp r7, #5
	blo _0216F6E8
	add r1, sp, #0x50
	mov r0, #0
	add r1, #2
	mov r2, #0xa
	bl MIi_CpuClear16
	ldr r0, _0216F878 // =0x02110460
	add r1, sp, #0x54
	mov r2, #8
	bl MIi_CpuCopy16
	mov r0, #0x1b
	lsl r0, r0, #6
	bl _AllocHeadHEAP_USER
	mov r6, r0
	mov r0, #0
	str r0, [sp, #0x38]
	ldr r0, _0216F87C // =0x00000524
	mov r4, r5
	add r7, r5, r0
	ldr r0, [sp, #0x3c]
	add r4, #0x1c
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x48]
_0216F74C:
	mov r2, #0x1b
	mov r0, #0
	mov r1, r6
	lsl r2, r2, #6
	bl MIi_CpuClearFast
	ldr r0, [r7, #0]
	cmp r0, #0
	bne _0216F78C
	mov r0, #0x1b
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0x78
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r0, #8
	str r0, [sp, #0x18]
	mov r0, #0
	str r0, [sp, #0x1c]
	ldr r0, _0216F880 // =asc_217EDF8
	mov r1, #0
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x74]
	mov r2, #0x10
	mov r3, r6
	bl FontFile__Func_2052F38
	b _0216F7D6
_0216F78C:
	add r2, sp, #0x4c
	add r1, sp, #0x50
	add r2, #2
	add r3, sp, #0x4c
	bl AkUtilFrameToTime
	mov r0, #0x1b
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0x78
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r0, #8
	str r0, [sp, #0x18]
	mov r0, #0
	str r0, [sp, #0x1c]
	ldr r0, _0216F884 // =aD02d02d
	mov r1, #0
	str r0, [sp, #0x20]
	add r0, sp, #0x4c
	ldrh r0, [r0, #4]
	mov r2, #0x10
	mov r3, r6
	str r0, [sp, #0x24]
	add r0, sp, #0x4c
	ldrh r0, [r0, #2]
	str r0, [sp, #0x28]
	add r0, sp, #0x4c
	ldrh r0, [r0, #0]
	str r0, [sp, #0x2c]
	ldr r0, [sp, #0x74]
	bl FontFile__Func_2052F38
_0216F7D6:
	mov r0, #0x1b
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	add r0, sp, #0x50
	add r0, #2
	str r0, [sp, #8]
	mov r0, #4
	str r0, [sp, #0xc]
	ldr r1, [sp, #0x30]
	mov r0, r4
	mov r2, #0
	mov r3, r6
	bl Unknown2056FDC__Func_2057004
	ldr r0, [sp, #0x48]
	add r7, #8
	strh r0, [r4, #0x34]
	mov r0, #0x6c
	strh r0, [r4, #8]
	ldr r0, [sp, #0x38]
	add r4, #0x48
	add r0, r0, #1
	str r0, [sp, #0x38]
	cmp r0, #5
	blo _0216F74C
	mov r0, r6
	bl _FreeHEAP_USER
	mov r1, #0
	ldr r0, _0216F888 // =0x00004001
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	ldr r0, _0216F88C // =TimeAttackRankList__Main1
	mov r3, r1
	bl TaskCreate_
	str r0, [r5]
	bl GetTaskWork_
	mov r1, #0
	str r5, [r0]
	ldr r0, _0216F890 // =0x00004081
	mov r2, r1
	str r0, [sp]
	str r1, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	ldr r0, _0216F894 // =TimeAttackRankList__Main2
	mov r3, r1
	bl TaskCreate_
	str r0, [r5, #4]
	bl GetTaskWork_
	str r5, [r0]
	ldr r1, [r5, #0xc]
	mov r0, #1
	orr r0, r1
	str r0, [r5, #0xc]
	add sp, #0x5c
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_0216F858: .word aBbDmwfRankLang
_0216F85C: .word 0x0217E0A4
_0216F860: .word 0x00000804
_0216F864: .word gameState
_0216F868: .word 0x00000594
_0216F86C: .word 0x0000058E
_0216F870: .word 0x00000566
_0216F874: .word 0x00000568
_0216F878: .word 0x02110460
_0216F87C: .word 0x00000524
_0216F880: .word asc_217EDF8
_0216F884: .word aD02d02d
_0216F888: .word 0x00004001
_0216F88C: .word TimeAttackRankList__Main1
_0216F890: .word 0x00004081
_0216F894: .word TimeAttackRankList__Main2
	thumb_func_end TimeAttackRankList__Create

	thumb_func_start TimeAttackRankList__SetRecord
TimeAttackRankList__SetRecord: // 0x0216F898
	push {r3, r4}
	ldr r4, _0216F8AC // =0x00000524
	add r4, r0, r4
	lsl r0, r1, #3
	add r1, r4, r0
	str r2, [r4, r0]
	str r3, [r1, #4]
	pop {r3, r4}
	bx lr
	nop
_0216F8AC: .word 0x00000524
	thumb_func_end TimeAttackRankList__SetRecord

	thumb_func_start TimeAttackRankList__InitRecords
TimeAttackRankList__InitRecords: // 0x0216F8B0
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x48
	str r1, [sp, #0x30]
	add r1, sp, #0x3c
	mov r7, r0
	mov r0, #0
	add r1, #2
	mov r2, #0xa
	bl MIi_CpuClear16
	ldr r0, _0216F9B0 // =0x02110460
	add r1, sp, #0x40
	mov r2, #8
	bl MIi_CpuCopy16
	mov r0, #0x1b
	lsl r0, r0, #6
	bl _AllocHeadHEAP_USER
	mov r4, r0
	mov r0, #0
	str r0, [sp, #0x34]
	ldr r0, _0216F9B4 // =0x00000524
	mov r5, r7
	add r5, #0x1c
	add r6, r7, r0
_0216F8E4:
	mov r2, #0x1b
	mov r0, #0
	mov r1, r4
	lsl r2, r2, #6
	bl MIi_CpuClearFast
	ldr r0, [r6, #0]
	cmp r0, #0
	bne _0216F924
	mov r0, #0x1b
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0x78
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r0, #8
	str r0, [sp, #0x18]
	mov r0, #0
	str r0, [sp, #0x1c]
	ldr r0, _0216F9B8 // =asc_217EDF8
	mov r1, #0
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x30]
	mov r2, #0x10
	mov r3, r4
	bl FontFile__Func_2052F38
	b _0216F96E
_0216F924:
	add r2, sp, #0x38
	add r1, sp, #0x3c
	add r2, #2
	add r3, sp, #0x38
	bl AkUtilFrameToTime
	mov r0, #0x1b
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0x78
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r0, #8
	str r0, [sp, #0x18]
	mov r0, #0
	str r0, [sp, #0x1c]
	ldr r0, _0216F9BC // =aD02d02d
	mov r1, #0
	str r0, [sp, #0x20]
	add r0, sp, #0x38
	ldrh r0, [r0, #4]
	mov r2, #0x10
	mov r3, r4
	str r0, [sp, #0x24]
	add r0, sp, #0x38
	ldrh r0, [r0, #2]
	str r0, [sp, #0x28]
	add r0, sp, #0x38
	ldrh r0, [r0, #0]
	str r0, [sp, #0x2c]
	ldr r0, [sp, #0x30]
	bl FontFile__Func_2052F38
_0216F96E:
	mov r0, #0x1b
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	add r0, sp, #0x3c
	add r0, #2
	str r0, [sp, #8]
	mov r0, #4
	str r0, [sp, #0xc]
	ldr r1, [r7, #0x10]
	mov r0, r5
	mov r2, #0
	mov r3, r4
	bl Unknown2056FDC__Func_2057004
	ldrh r0, [r7, #0x14]
	add r6, #8
	add r0, r0, #1
	strh r0, [r5, #0x34]
	mov r0, #0x6c
	strh r0, [r5, #8]
	ldr r0, [sp, #0x34]
	add r5, #0x48
	add r0, r0, #1
	str r0, [sp, #0x34]
	cmp r0, #5
	blo _0216F8E4
	mov r0, r4
	bl _FreeHEAP_USER
	add sp, #0x48
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0216F9B0: .word 0x02110460
_0216F9B4: .word 0x00000524
_0216F9B8: .word asc_217EDF8
_0216F9BC: .word aD02d02d
	thumb_func_end TimeAttackRankList__InitRecords

	thumb_func_start TimeAttackRankList__Func_216F9C0
TimeAttackRankList__Func_216F9C0: // 0x0216F9C0
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x28
	ldr r1, _0216FA30 // =0x00000568
	mov r7, #0
	str r0, [sp, #0x24]
	mov r6, r7
	mov r4, r0
	add r5, r0, r1
_0216F9D0:
	cmp r7, #4
	bne _0216F9D8
	ldr r0, _0216FA34 // =TimeAttackRankList__Func_216FACC
	b _0216F9DA
_0216F9D8:
	mov r0, #0
_0216F9DA:
	ldr r1, _0216FA30 // =0x00000568
	ldrsh r3, [r4, r1]
	lsl r1, r6, #0x10
	lsr r1, r1, #0x10
	str r1, [sp]
	mov r1, #0x10
	str r1, [sp, #4]
	ldr r1, _0216FA38 // =Task__Unknown204BE48__LerpValue
	mov r2, r3
	str r1, [sp, #8]
	mov r1, #1
	lsl r1, r1, #0xc
	str r1, [sp, #0xc]
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x24]
	mov r1, #2
	str r0, [sp, #0x14]
	mov r0, #0
	str r0, [sp, #0x18]
	ldr r0, _0216FA3C // =0x00004002
	sub r3, #0xc0
	str r0, [sp, #0x1c]
	mov r0, #0
	str r0, [sp, #0x20]
	mov r0, r5
	bl Task__Unknown204BE48__Create
	ldr r1, _0216FA40 // =0x00000598
	add r7, r7, #1
	str r0, [r4, r1]
	add r6, r6, #4
	add r4, r4, #4
	add r5, r5, #4
	cmp r7, #5
	blo _0216F9D0
	ldr r0, [sp, #0x24]
	ldr r1, [r0, #0xc]
	mov r0, #2
	orr r1, r0
	ldr r0, [sp, #0x24]
	str r1, [r0, #0xc]
	add sp, #0x28
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216FA30: .word 0x00000568
_0216FA34: .word TimeAttackRankList__Func_216FACC
_0216FA38: .word Task__Unknown204BE48__LerpValue
_0216FA3C: .word 0x00004002
_0216FA40: .word 0x00000598
	thumb_func_end TimeAttackRankList__Func_216F9C0

	thumb_func_start TimeAttackRankList__Func_216FA44
TimeAttackRankList__Func_216FA44: // 0x0216FA44
	push {r4, r5, r6, r7, lr}
	sub sp, #0x24
	mov r7, r0
	ldr r0, _0216FAA4 // =0x00000568
	mov r4, #0
	mov r5, r7
	add r6, r7, r0
_0216FA52:
	cmp r4, #0
	bne _0216FA5A
	ldr r0, _0216FAA8 // =TimeAttackRankList__Func_216FAFC
	b _0216FA5C
_0216FA5A:
	mov r0, #0
_0216FA5C:
	ldr r1, _0216FAA4 // =0x00000568
	ldrsh r3, [r5, r1]
	mov r1, #4
	sub r1, r1, r4
	lsl r1, r1, #0x12
	lsr r1, r1, #0x10
	str r1, [sp]
	mov r1, #0x10
	str r1, [sp, #4]
	ldr r1, _0216FAAC // =Task__Unknown204BE48__LerpValue
	mov r2, r3
	str r1, [sp, #8]
	ldr r1, _0216FAB0 // =0xFFFFF000
	add r3, #0xc0
	str r1, [sp, #0xc]
	str r0, [sp, #0x10]
	str r7, [sp, #0x14]
	mov r0, #0
	str r0, [sp, #0x18]
	ldr r0, _0216FAB4 // =0x00004002
	mov r1, #2
	str r0, [sp, #0x1c]
	mov r0, #0
	str r0, [sp, #0x20]
	mov r0, r6
	bl Task__Unknown204BE48__Create
	ldr r1, _0216FAB8 // =0x00000598
	add r4, r4, #1
	str r0, [r5, r1]
	add r5, r5, #4
	add r6, r6, #4
	cmp r4, #5
	blo _0216FA52
	add sp, #0x24
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_0216FAA4: .word 0x00000568
_0216FAA8: .word TimeAttackRankList__Func_216FAFC
_0216FAAC: .word Task__Unknown204BE48__LerpValue
_0216FAB0: .word 0xFFFFF000
_0216FAB4: .word 0x00004002
_0216FAB8: .word 0x00000598
	thumb_func_end TimeAttackRankList__Func_216FA44

	thumb_func_start TimeAttackRankList__Func_216FABC
TimeAttackRankList__Func_216FABC: // 0x0216FABC
	ldr r1, [r0, #0xc]
	mov r0, #2
	tst r0, r1
	bne _0216FAC8
	mov r0, #1
	bx lr
_0216FAC8:
	mov r0, #0
	bx lr
	thumb_func_end TimeAttackRankList__Func_216FABC

	thumb_func_start TimeAttackRankList__Func_216FACC
TimeAttackRankList__Func_216FACC: // 0x0216FACC
	push {r3, lr}
	cmp r0, #5
	bhi _0216FAF6
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0216FADE: // jump table
	.hword _0216FAF6 - _0216FADE - 2 // case 0
	.hword _0216FAF6 - _0216FADE - 2 // case 1
	.hword _0216FAF6 - _0216FADE - 2 // case 2
	.hword _0216FAF6 - _0216FADE - 2 // case 3
	.hword _0216FAEA - _0216FADE - 2 // case 4
	.hword _0216FAF6 - _0216FADE - 2 // case 5
_0216FAEA:
	ldr r1, _0216FAF8 // =0x00000598
	mov r0, #0
	add r1, r2, r1
	mov r2, #0x14
	bl MIi_CpuClear32
_0216FAF6:
	pop {r3, pc}
	.align 2, 0
_0216FAF8: .word 0x00000598
	thumb_func_end TimeAttackRankList__Func_216FACC

	thumb_func_start TimeAttackRankList__Func_216FAFC
TimeAttackRankList__Func_216FAFC: // 0x0216FAFC
	push {r4, lr}
	mov r4, r2
	cmp r0, #5
	bhi _0216FB50
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0216FB10: // jump table
	.hword _0216FB50 - _0216FB10 - 2 // case 0
	.hword _0216FB50 - _0216FB10 - 2 // case 1
	.hword _0216FB50 - _0216FB10 - 2 // case 2
	.hword _0216FB50 - _0216FB10 - 2 // case 3
	.hword _0216FB1C - _0216FB10 - 2 // case 4
	.hword _0216FB50 - _0216FB10 - 2 // case 5
_0216FB1C:
	ldr r1, [r4, #0xc]
	mov r0, #2
	bic r1, r0
	str r1, [r4, #0xc]
	ldr r1, _0216FB54 // =0x00000598
	mov r0, #0
	add r1, r4, r1
	mov r2, #0x14
	bl MIi_CpuClear32
	ldr r0, [r4, #0]
	cmp r0, #0
	beq _0216FB40
	bl GetTaskWork_
	mov r1, #0
	str r1, [r0]
	str r1, [r4]
_0216FB40:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0216FB50
	bl GetTaskWork_
	mov r1, #0
	str r1, [r0]
	str r1, [r4, #4]
_0216FB50:
	pop {r4, pc}
	nop
_0216FB54: .word 0x00000598
	thumb_func_end TimeAttackRankList__Func_216FAFC

	thumb_func_start TimeAttackRankList__Main1
TimeAttackRankList__Main1: // 0x0216FB58
	push {r3, r4, r5, r6, r7, lr}
	bl GetCurrentTaskWork_
	ldr r6, [r0, #0]
	cmp r6, #0
	bne _0216FB6A
	bl DestroyCurrentTask
	pop {r3, r4, r5, r6, r7, pc}
_0216FB6A:
	mov r0, r6
	bl TimeAttackRankList__Func_216FABC
	cmp r0, #0
	bne _0216FBAE
	mov r0, #0x9a
	lsl r0, r0, #2
	add r5, r6, r0
	ldr r0, _0216FBB0 // =0x00000524
	add r4, r6, r0
	cmp r5, r4
	beq _0216FB94
	mov r7, #0
_0216FB84:
	mov r0, r5
	mov r1, r7
	mov r2, r7
	bl AnimatorSprite__ProcessAnimation
	add r5, #0x64
	cmp r5, r4
	bne _0216FB84
_0216FB94:
	mov r0, #0x97
	mov r4, r6
	lsl r0, r0, #2
	add r4, #0x1c
	add r5, r6, r0
	cmp r4, r5
	beq _0216FBAE
_0216FBA2:
	mov r0, r4
	bl Unknown2056FDC__Func_2057484
	add r4, #0x48
	cmp r4, r5
	bne _0216FBA2
_0216FBAE:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216FBB0: .word 0x00000524
	thumb_func_end TimeAttackRankList__Main1

	thumb_func_start TimeAttackRankList__Main2
TimeAttackRankList__Main2: // 0x0216FBB4
	push {r3, r4, r5, r6, r7, lr}
	bl GetCurrentTaskWork_
	ldr r6, [r0, #0]
	cmp r6, #0
	bne _0216FBC6
	bl DestroyCurrentTask
	pop {r3, r4, r5, r6, r7, pc}
_0216FBC6:
	mov r0, r6
	bl TimeAttackRankList__Func_216FABC
	cmp r0, #0
	bne _0216FC86
	mov r0, #0x9a
	lsl r0, r0, #2
	mov r5, r6
	add r0, r6, r0
	mov r7, #0
	mov r4, r6
	add r5, #0x1c
	str r0, [sp]
_0216FBE0:
	ldr r0, _0216FC88 // =0x00000564
	ldrh r0, [r6, r0]
	sub r0, r0, #1
	cmp r0, r7
	beq _0216FBEE
	mov r2, #1
	b _0216FBF0
_0216FBEE:
	mov r2, #0
_0216FBF0:
	mov r0, #0x64
	mov r1, r2
	mul r1, r0
	ldr r0, [sp]
	add r1, r0, r1
	mov r0, #0xa
	mul r0, r2
	ldr r2, _0216FC8C // =0x0217E0A4
	add r0, r2, r0
	mov r2, #4
	ldrsh r3, [r0, r2]
	ldr r2, _0216FC90 // =0x00000566
	ldrsh r2, [r4, r2]
	add r2, r3, r2
	strh r2, [r1, #8]
	mov r2, #6
	ldrsh r0, [r0, r2]
	ldr r2, _0216FC94 // =0x00000568
	ldrsh r2, [r4, r2]
	add r0, r0, r2
	strh r0, [r1, #0xa]
	mov r0, r1
	bl AnimatorSprite__DrawFrame
	ldr r0, _0216FC90 // =0x00000566
	ldrsh r0, [r4, r0]
	strh r0, [r5, #4]
	ldr r0, _0216FC94 // =0x00000568
	ldrsh r0, [r4, r0]
	strh r0, [r5, #6]
	mov r0, #6
	ldrsh r0, [r5, r0]
	cmp r0, #0
	ble _0216FC3E
	cmp r0, #0xc0
	bge _0216FC3E
	mov r0, r5
	bl Unknown2056FDC__Func_2057614
_0216FC3E:
	add r7, r7, #1
	add r4, r4, #4
	add r5, #0x48
	cmp r7, #5
	blo _0216FBE0
	mov r0, #0x9a
	lsl r0, r0, #2
	ldr r7, _0216FC8C // =0x0217E0A4
	mov r4, #0
	add r5, r6, r0
_0216FC52:
	add r0, r4, #2
	mov r1, #0x64
	mul r1, r0
	add r2, r5, r1
	mov r1, #0xa
	mul r1, r0
	ldr r3, _0216FC90 // =0x00000566
	add r1, r7, r1
	mov r0, #4
	ldrsh r0, [r1, r0]
	ldrsh r3, [r6, r3]
	add r0, r0, r3
	strh r0, [r2, #8]
	mov r0, #6
	ldrsh r0, [r1, r0]
	ldr r1, _0216FC94 // =0x00000568
	ldrsh r1, [r6, r1]
	add r0, r0, r1
	strh r0, [r2, #0xa]
	mov r0, r2
	bl AnimatorSprite__DrawFrame
	add r4, r4, #1
	add r6, r6, #4
	cmp r4, #5
	blo _0216FC52
_0216FC86:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216FC88: .word 0x00000564
_0216FC8C: .word 0x0217E0A4
_0216FC90: .word 0x00000566
_0216FC94: .word 0x00000568
	thumb_func_end TimeAttackRankList__Main2

	.data
	
aBbDmwfRankLang: // 0x0217EDE0
	.asciz "/bb/dmwf_rank_lang.bb"
	.align 4
	
asc_217EDF8: // 0x0217EDF8
	.asciz "-'--\"--"
	.align 4
	
aD02d02d: // 0x0217EE00
	.asciz "%d'%02d\"%02d"
	.align 4