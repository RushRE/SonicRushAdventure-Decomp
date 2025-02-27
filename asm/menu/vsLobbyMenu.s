	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public VSLobbyMenu__sVars
VSLobbyMenu__sVars: // 0x0217EFD8
	.space 0x04 // VSState *vsState;
	.space 0x04 // VSCharacterSelect *vsCharacterSelect;
	.space 0x04 // VSLobbyMenu *vsLobbyMenuTask;

	.text

	thumb_func_start VSLobbyMenu__Create
VSLobbyMenu__Create: // 0x02163B54
	push {lr}
	sub sp, #0xc
	ldr r0, _02163BC8 // =0x000020A1
	mov r2, #0
	str r0, [sp]
	mov r0, #0xee
	str r2, [sp, #4]
	lsl r0, r0, #2
	str r0, [sp, #8]
	ldr r0, _02163BCC // =VSLobbyMenu__Main1
	ldr r1, _02163BD0 // =VSLobbyMenu__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r1, r0
	ldr r0, _02163BD4 // =VSLobbyMenu__sVars
	mov r2, #0xee
	str r1, [r0, #8]
	mov r0, #0
	lsl r2, r2, #2
	bl MIi_CpuClear32
	ldr r0, _02163BD4 // =VSLobbyMenu__sVars
	mov r1, #0
	ldr r0, [r0, #8]
	str r1, [r0, #4]
	bl GetSysEventList
	mov r1, #0xe
	ldrsh r0, [r0, r1]
	cmp r0, #0x10
	beq _02163BA6
	ldr r0, _02163BD4 // =VSLobbyMenu__sVars
	ldr r2, [r0, #8]
	mov r0, #2
	ldr r1, [r2, #0]
	lsl r0, r0, #0xe
	orr r0, r1
	str r0, [r2]
_02163BA6:
	mov r0, #0xef
	lsl r0, r0, #8
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _02163BD8 // =VSLobbyMenu__Main2
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	ldr r1, _02163BD4 // =VSLobbyMenu__sVars
	ldr r1, [r1, #8]
	str r0, [r1, #8]
	add sp, #0xc
	pop {pc}
	nop
_02163BC8: .word 0x000020A1
_02163BCC: .word VSLobbyMenu__Main1
_02163BD0: .word VSLobbyMenu__Destructor
_02163BD4: .word VSLobbyMenu__sVars
_02163BD8: .word VSLobbyMenu__Main2
	thumb_func_end VSLobbyMenu__Create

	thumb_func_start VSLobbyMenu__Func_2163BDC
VSLobbyMenu__Func_2163BDC: // 0x02163BDC
	ldr r1, _02163BF8 // =VSLobbyMenu__sVars
	cmp r0, #0
	ldr r1, [r1, #8]
	beq _02163BEA
	cmp r0, #1
	beq _02163BEE
	b _02163BF2
_02163BEA:
	ldr r0, [r1, #0x2c]
	bx lr
_02163BEE:
	ldr r0, [r1, #0x18]
	bx lr
_02163BF2:
	mov r0, #0
	bx lr
	nop
_02163BF8: .word VSLobbyMenu__sVars
	thumb_func_end VSLobbyMenu__Func_2163BDC

	thumb_func_start VSLobbyMenu__Func_2163BFC
VSLobbyMenu__Func_2163BFC: // 0x02163BFC
	push {r4, r5, r6, r7}
	ldr r1, _02163C68 // =VSLobbyMenu__sVars
	mov r7, #2
	ldr r5, [r1, #8]
	mov r1, #0xe3
	lsl r1, r1, #2
	add r4, r5, r1
	add r1, r1, #5
	add r3, r5, r1
	mov r1, #0xe3
	lsl r1, r1, #2
	sub r1, r1, #4
	ldr r1, [r5, r1]
	orr r0, r7
	lsl r2, r1, #1
	lsl r0, r0, #0x18
	lsr r7, r0, #0x18
	mov r0, #3
	ldrb r1, [r3, r2]
	mov r6, #3
	and r0, r7
	bic r1, r6
	orr r0, r1
	strb r0, [r3, r2]
	mov r0, #0xe3
	lsl r0, r0, #2
	sub r0, r0, #4
	ldr r0, [r5, r0]
	cmp r0, #0
	bne _02163C50
	ldrb r1, [r4, #5]
	lsl r0, r1, #0x1e
	lsr r2, r0, #0x1e
	ldrb r0, [r4, #7]
	lsl r0, r0, #0x1e
	lsr r0, r0, #0x1e
	cmp r2, r0
	bne _02163C64
	bic r1, r6
	strb r1, [r4, #5]
	pop {r4, r5, r6, r7}
	bx lr
_02163C50:
	ldrb r1, [r4, #7]
	lsl r0, r1, #0x1e
	lsr r2, r0, #0x1e
	ldrb r0, [r4, #5]
	lsl r0, r0, #0x1e
	lsr r0, r0, #0x1e
	cmp r2, r0
	bne _02163C64
	bic r1, r6
	strb r1, [r4, #7]
_02163C64:
	pop {r4, r5, r6, r7}
	bx lr
	.align 2, 0
_02163C68: .word VSLobbyMenu__sVars
	thumb_func_end VSLobbyMenu__Func_2163BFC

	thumb_func_start VSLobbyMenu__Func_2163C6C
VSLobbyMenu__Func_2163C6C: // 0x02163C6C
	push {r4, lr}
	ldr r0, _02163C9C // =VSLobbyMenu__sVars
	ldr r4, [r0, #8]
	bl MultibootManager__Func_2061A24
	cmp r0, #0
	beq _02163C96
	mov r0, #0xe2
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r0, #9
	lsl r1, r1, #1
	add r1, r4, r1
	ldrb r0, [r1, r0]
	lsl r0, r0, #0x1e
	lsr r0, r0, #0x1e
	beq _02163C92
	mov r0, #1
	pop {r4, pc}
_02163C92:
	mov r0, #2
	pop {r4, pc}
_02163C96:
	mov r0, #0
	pop {r4, pc}
	nop
_02163C9C: .word VSLobbyMenu__sVars
	thumb_func_end VSLobbyMenu__Func_2163C6C

	thumb_func_start VSLobbyMenu__Func_2163CA0
VSLobbyMenu__Func_2163CA0: // 0x02163CA0
	ldr r0, _02163CD8 // =VSLobbyMenu__sVars
	ldr r1, [r0, #8]
	mov r0, #0xe2
	lsl r0, r0, #2
	ldr r0, [r1, r0]
	cmp r0, #0
	bne _02163CB2
	mov r0, #1
	b _02163CB4
_02163CB2:
	mov r0, #0
_02163CB4:
	lsl r0, r0, #1
	add r1, r1, r0
	ldr r0, _02163CDC // =0x00000391
	ldrb r0, [r1, r0]
	lsl r0, r0, #0x1e
	lsr r0, r0, #0x1e
	beq _02163CD4
	cmp r0, #2
	beq _02163CCC
	cmp r0, #3
	beq _02163CD0
	b _02163CD4
_02163CCC:
	mov r0, #1
	bx lr
_02163CD0:
	mov r0, #2
	bx lr
_02163CD4:
	mov r0, #0
	bx lr
	.align 2, 0
_02163CD8: .word VSLobbyMenu__sVars
_02163CDC: .word 0x00000391
	thumb_func_end VSLobbyMenu__Func_2163CA0

	thumb_func_start VSLobbyMenu__Func_2163CE0
VSLobbyMenu__Func_2163CE0: // 0x02163CE0
	push {r4, r5, r6, r7}
	ldr r2, _02163D18 // =VSLobbyMenu__sVars
	ldr r6, _02163D1C // =0x00000391
	ldr r5, [r2, #8]
	mov r2, r6
	sub r2, #9
	ldr r2, [r5, r2]
	add r4, r5, r6
	lsl r3, r2, #1
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	lsl r0, r0, #0x1c
	ldrb r2, [r4, r3]
	mov r7, #0x3c
	lsr r0, r0, #0x1a
	bic r2, r7
	orr r0, r2
	strb r0, [r4, r3]
	mov r0, r6
	sub r0, #9
	ldr r0, [r5, r0]
	lsl r0, r0, #1
	add r2, r5, r0
	sub r0, r6, #1
	strb r1, [r2, r0]
	pop {r4, r5, r6, r7}
	bx lr
	nop
_02163D18: .word VSLobbyMenu__sVars
_02163D1C: .word 0x00000391
	thumb_func_end VSLobbyMenu__Func_2163CE0

	thumb_func_start VSLobbyMenu__Func_2163D20
VSLobbyMenu__Func_2163D20: // 0x02163D20
	ldr r0, _02163D30 // =VSLobbyMenu__sVars
	ldr r1, [r0, #8]
	mov r0, #0xe3
	lsl r0, r0, #2
	add r0, r1, r0
	ldrb r0, [r0, #0xc]
	bx lr
	nop
_02163D30: .word VSLobbyMenu__sVars
	thumb_func_end VSLobbyMenu__Func_2163D20

	thumb_func_start VSLobbyMenu__Func_2163D34
VSLobbyMenu__Func_2163D34: // 0x02163D34
	push {r3, r4, r5, r6, r7, lr}
	ldr r0, _02163D80 // =VSLobbyMenu__sVars
	ldr r1, [r0, #8]
	mov r0, #0xe3
	lsl r0, r0, #2
	add r6, r1, r0
	bl VSLobbyMenu__IsRace
	cmp r0, #0
	beq _02163D4C
	mov r5, #0x11
	b _02163D4E
_02163D4C:
	mov r5, #4
_02163D4E:
	ldr r0, _02163D84 // =_mt_math_rand
	mov r7, #1
	ldr r4, [r0, #0]
_02163D54:
	ldr r0, _02163D88 // =0x00196225
	mov r1, r4
	mul r1, r0
	ldr r0, _02163D8C // =0x3C6EF35F
	add r4, r1, r0
	ldr r0, _02163D84 // =_mt_math_rand
	mov r1, r5
	str r4, [r0]
	lsr r0, r4, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	asr r0, r0, #4
	bl _u32_div_f
	mov r0, r7
	ldr r2, [r6, #8]
	lsl r0, r1
	tst r0, r2
	beq _02163D54
	mov r0, r1
	thumb_func_end VSLobbyMenu__Func_2163D34

	thumb_func_start VSLobbyMenu__Func_2163D7C
VSLobbyMenu__Func_2163D7C: // 0x02163D7C
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02163D80: .word VSLobbyMenu__sVars
_02163D84: .word _mt_math_rand
_02163D88: .word 0x00196225
_02163D8C: .word 0x3C6EF35F
	thumb_func_end VSLobbyMenu__Func_2163D7C

	thumb_func_start VSLobbyMenu__Func_2163D90
VSLobbyMenu__Func_2163D90: // 0x02163D90
	ldr r0, _02163DA8 // =VSLobbyMenu__sVars
	ldr r0, [r0, #8]
	ldr r1, [r0, #0]
	mov r0, #2
	lsl r0, r0, #0xe
	tst r0, r1
	beq _02163DA2
	mov r0, #1
	bx lr
_02163DA2:
	mov r0, #0
	bx lr
	nop
_02163DA8: .word VSLobbyMenu__sVars
	thumb_func_end VSLobbyMenu__Func_2163D90

	thumb_func_start VSLobbyMenu__Func_2163DAC
VSLobbyMenu__Func_2163DAC: // 0x02163DAC
	ldr r0, _02163DBC // =VSLobbyMenu__sVars
	ldr r1, [r0, #8]
	mov r0, #0xe3
	lsl r0, r0, #2
	add r0, r1, r0
	ldr r0, [r0, #8]
	bx lr
	nop
_02163DBC: .word VSLobbyMenu__sVars
	thumb_func_end VSLobbyMenu__Func_2163DAC

	thumb_func_start VSLobbyMenu__GetTouchField
VSLobbyMenu__GetTouchField: // 0x02163DC0
	ldr r0, _02163DCC // =VSLobbyMenu__sVars
	ldr r1, [r0, #8]
	mov r0, #0x3a
	lsl r0, r0, #4
	add r0, r1, r0
	bx lr
	.align 2, 0
_02163DCC: .word VSLobbyMenu__sVars
	thumb_func_end VSLobbyMenu__GetTouchField

	thumb_func_start VSLobbyMenu__SetFlag
VSLobbyMenu__SetFlag: // 0x02163DD0
	ldr r1, _02163DDC // =VSLobbyMenu__sVars
	ldr r2, [r1, #8]
	ldr r1, [r2, #0]
	orr r0, r1
	str r0, [r2]
	bx lr
	.align 2, 0
_02163DDC: .word VSLobbyMenu__sVars
	thumb_func_end VSLobbyMenu__SetFlag

	thumb_func_start VSLobbyMenu__RemoveFlag
VSLobbyMenu__RemoveFlag: // 0x02163DE0
	ldr r1, _02163DF0 // =VSLobbyMenu__sVars
	mvn r0, r0
	ldr r2, [r1, #8]
	ldr r1, [r2, #0]
	and r0, r1
	str r0, [r2]
	bx lr
	nop
_02163DF0: .word VSLobbyMenu__sVars
	thumb_func_end VSLobbyMenu__RemoveFlag

	thumb_func_start VSLobbyMenu__Func_2163DF4
VSLobbyMenu__Func_2163DF4: // 0x02163DF4
	ldr r0, _02163E0C // =VSLobbyMenu__sVars
	ldr r1, [r0, #8]
	mov r0, #0xe7
	lsl r0, r0, #2
	ldrsh r0, [r1, r0]
	cmp r0, #0
	bne _02163E06
	mov r0, #1
	bx lr
_02163E06:
	mov r0, #0
	bx lr
	nop
_02163E0C: .word VSLobbyMenu__sVars
	thumb_func_end VSLobbyMenu__Func_2163DF4

	thumb_func_start VSLobbyMenu__FadeSysTrack
VSLobbyMenu__FadeSysTrack: // 0x02163E10
	ldr r3, _02163E14 // =FadeSysTrack
	bx r3
	.align 2, 0
_02163E14: .word FadeSysTrack
	thumb_func_end VSLobbyMenu__FadeSysTrack

	thumb_func_start VSLobbyMenu__Func_2163E18
VSLobbyMenu__Func_2163E18: // 0x02163E18
	ldr r3, _02163E1C // =ReleaseSysSound
	bx r3
	.align 2, 0
_02163E1C: .word ReleaseSysSound
	thumb_func_end VSLobbyMenu__Func_2163E18

	thumb_func_start VSLobbyMenu__Destructor
VSLobbyMenu__Destructor: // 0x02163E20
	ldr r0, _02163E28 // =VSLobbyMenu__sVars
	mov r1, #0
	str r1, [r0, #8]
	bx lr
	.align 2, 0
_02163E28: .word VSLobbyMenu__sVars
	thumb_func_end VSLobbyMenu__Destructor

	thumb_func_start VSLobbyMenu__SetupDisplay
VSLobbyMenu__SetupDisplay: // 0x02163E2C
	push {r3, r4, r5, r6, r7, lr}
	bl VSLobbyMenu__Func_2163D90
	cmp r0, #0
	beq _02163E3E
	mov r0, #0
	bl SetupDisplayForZone
	b _02163E54
_02163E3E:
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _02163E4E
	mov r0, #1
	bl SetupDisplayForZone
	b _02163E54
_02163E4E:
	mov r0, #0
	bl SetupDisplayForZone
_02163E54:
	mov r1, #0
	mov r0, #1
	mov r2, r1
	bl GX_SetGraphicsMode
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r0, _02163F3C // =renderCurrentDisplay
	mov r5, #1
	ldr r3, _02163F40 // =0x04000008
	str r5, [r0]
	ldrh r0, [r3, #0]
	mov r1, #0x43
	mov r4, #0
	mov r2, r0
	ldr r0, _02163F44 // =0x00002F0C
	and r2, r1
	orr r0, r2
	strh r0, [r3]
	ldrh r0, [r3, #2]
	mov r2, r0
	ldr r0, _02163F48 // =0x00002D04
	and r2, r1
	orr r0, r2
	strh r0, [r3, #2]
	ldrh r0, [r3, #4]
	ldr r2, _02163F4C // =0x00000E08
	and r0, r1
	orr r0, r2
	strh r0, [r3, #4]
	ldr r0, _02163F50 // =renderCoreGFXControlA
	strh r4, [r0, #0xe]
	ldrh r6, [r0, #0xe]
	strh r6, [r0, #0xc]
	strh r6, [r0, #0xa]
	strh r6, [r0, #8]
	strh r6, [r0, #6]
	strh r6, [r0, #4]
	strh r6, [r0, #2]
	strh r6, [r0]
	ldrh r6, [r3, #2]
	mov r0, #3
	bic r6, r0
	strh r6, [r3, #2]
	ldrh r6, [r3, #0]
	bic r6, r0
	orr r6, r5
	strh r6, [r3]
	ldrh r7, [r3, #4]
	mov r6, #2
	bic r7, r0
	orr r6, r7
	strh r6, [r3, #4]
	ldrh r7, [r3, #6]
	mov r6, #3
	bic r7, r0
	orr r6, r7
	strh r6, [r3, #6]
	lsl r3, r2, #0x17
	ldr r7, [r3, #0]
	ldr r6, _02163F54 // =0xFFFFE0FF
	and r7, r6
	mov r6, #0x17
	lsl r6, r6, #8
	orr r6, r7
	str r6, [r3]
	ldr r3, _02163F58 // =0x0400100A
	ldrh r6, [r3, #0]
	mov r7, r6
	ldr r6, _02163F48 // =0x00002D04
	and r7, r1
	orr r6, r7
	strh r6, [r3]
	ldrh r6, [r3, #2]
	and r1, r6
	orr r1, r2
	strh r1, [r3, #2]
	ldr r1, _02163F5C // =renderCoreGFXControlB
	strh r4, [r1, #0xe]
	ldrh r2, [r1, #0xe]
	strh r2, [r1, #0xc]
	ldrh r2, [r1, #0xc]
	strh r2, [r1, #0xa]
	strh r2, [r1, #8]
	strh r2, [r1, #6]
	strh r2, [r1, #4]
	strh r2, [r1, #2]
	strh r2, [r1]
	ldrh r1, [r3, #0]
	bic r1, r0
	strh r1, [r3]
	sub r1, r3, #2
	ldrh r2, [r1, #0]
	bic r2, r0
	orr r2, r5
	strh r2, [r1]
	ldrh r2, [r3, #2]
	mov r1, #2
	bic r2, r0
	orr r1, r2
	strh r1, [r3, #2]
	ldrh r1, [r3, #4]
	bic r1, r0
	mov r0, #3
	orr r0, r1
	strh r0, [r3, #4]
	sub r3, #0xa
	ldr r1, [r3, #0]
	ldr r0, _02163F54 // =0xFFFFE0FF
	and r1, r0
	mov r0, #0x16
	lsl r0, r0, #8
	orr r0, r1
	str r0, [r3]
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02163F3C: .word renderCurrentDisplay
_02163F40: .word 0x04000008
_02163F44: .word 0x00002F0C
_02163F48: .word 0x00002D04
_02163F4C: .word 0x00000E08
_02163F50: .word renderCoreGFXControlA
_02163F54: .word 0xFFFFE0FF
_02163F58: .word 0x0400100A
_02163F5C: .word renderCoreGFXControlB
	thumb_func_end VSLobbyMenu__SetupDisplay

	thumb_func_start VSLobbyMenu__Func_2163F60
VSLobbyMenu__Func_2163F60: // 0x02163F60
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	mov r0, #0xe3
	lsl r0, r0, #2
	add r4, r5, r0
	ldr r1, [r5, #0]
	mov r0, #1
	tst r0, r1
	beq _02163FDA
	bl MultibootManager__GetField8
	cmp r0, #0xc
	beq _02163F82
	bl MultibootManager__GetField8
	cmp r0, #0x14
	bne _02163FDA
_02163F82:
	bl MultibootManager__Func_2061A24
	cmp r0, #0
	beq _02163FDA
	bl MultibootManager__Func_2061BD4
	ldrh r2, [r4, #0xe]
	ldrh r1, [r0, #0xe]
	orr r1, r2
	strh r1, [r4, #0xe]
	ldr r1, [r0, #0]
	str r1, [r4]
	mov r1, #0xe2
	lsl r1, r1, #2
	ldr r1, [r5, r1]
	cmp r1, #0
	bne _02163FC0
	ldrh r0, [r0, #6]
	strh r0, [r4, #6]
	ldrb r1, [r4, #5]
	lsl r0, r1, #0x1e
	lsr r2, r0, #0x1e
	ldrb r0, [r4, #7]
	lsl r0, r0, #0x1e
	lsr r0, r0, #0x1e
	cmp r2, r0
	bne _02163FDA
	mov r0, #3
	bic r1, r0
	strb r1, [r4, #5]
	b _02163FDA
_02163FC0:
	ldrh r0, [r0, #4]
	strh r0, [r4, #4]
	ldrb r1, [r4, #7]
	lsl r0, r1, #0x1e
	lsr r2, r0, #0x1e
	ldrb r0, [r4, #5]
	lsl r0, r0, #0x1e
	lsr r0, r0, #0x1e
	cmp r2, r0
	bne _02163FDA
	mov r0, #3
	bic r1, r0
	strb r1, [r4, #7]
_02163FDA:
	ldr r1, [r5, #0]
	mov r0, #2
	tst r0, r1
	beq _0216402C
	bl MultibootManager__Func_2060CF0
	cmp r0, #2
	bne _02164010
	bl MultibootManager__Func_2060D0C
	cmp r0, #0
	bne _02164010
	ldrb r1, [r4, #7]
	ldrb r2, [r4, #6]
	mov r0, #0
	lsl r1, r1, #0x1a
	lsr r1, r1, #0x1c
	bl VSState__Func_2163784
	ldrb r1, [r4, #5]
	ldrb r2, [r4, #4]
	mov r0, #1
	lsl r1, r1, #0x1a
	lsr r1, r1, #0x1c
	bl VSState__Func_2163784
	b _0216402C
_02164010:
	ldrb r1, [r4, #5]
	ldrb r2, [r4, #4]
	mov r0, #0
	lsl r1, r1, #0x1a
	lsr r1, r1, #0x1c
	bl VSState__Func_2163784
	ldrb r1, [r4, #7]
	ldrb r2, [r4, #6]
	mov r0, #1
	lsl r1, r1, #0x1a
	lsr r1, r1, #0x1c
	bl VSState__Func_2163784
_0216402C:
	ldr r1, [r5, #0]
	mov r0, #4
	tst r0, r1
	beq _0216406C
	mov r1, #0x2f
	lsl r1, r1, #4
	ldr r2, [r5, r1]
	ldr r0, _021640CC // =0x00000555
	add r0, r2, r0
	str r0, [r5, r1]
	ldr r0, [r5, r1]
	lsl r0, r0, #4
	lsr r0, r0, #0x10
	beq _0216406C
	ldr r2, _021640D0 // =renderCoreGFXControlA
	ldrh r3, [r2, #8]
	add r3, r3, r0
	strh r3, [r2, #8]
	ldrh r3, [r2, #0xa]
	add r3, r3, r0
	strh r3, [r2, #0xa]
	ldr r2, _021640D4 // =renderCoreGFXControlB
	ldrh r3, [r2, #8]
	add r3, r3, r0
	strh r3, [r2, #8]
	ldrh r3, [r2, #0xa]
	add r0, r3, r0
	strh r0, [r2, #0xa]
	ldr r2, [r5, r1]
	ldr r0, _021640D8 // =0x00000FFF
	and r0, r2
	str r0, [r5, r1]
_0216406C:
	ldr r1, [r5, #0]
	mov r0, #8
	tst r0, r1
	beq _02164092
	mov r0, #0x2f
	mov r4, r5
	lsl r0, r0, #4
	add r4, #0x34
	mov r7, #0
	add r6, r5, r0
	b _0216408E
_02164082:
	mov r0, r4
	mov r1, r7
	mov r2, r7
	bl AnimatorSprite__ProcessAnimation
	add r4, #0x64
_0216408E:
	cmp r4, r6
	bne _02164082
_02164092:
	ldr r1, [r5, #0]
	mov r0, #0x10
	tst r0, r1
	beq _0216409E
	bl VSState__ProcessAnimations
_0216409E:
	mov r1, #0xe7
	lsl r1, r1, #2
	ldrsh r0, [r5, r1]
	cmp r0, #0
	blt _021640BE
	add r0, r1, #2
	ldrsh r0, [r5, r0]
	add r2, r0, #1
	add r0, r1, #2
	strh r2, [r5, r0]
	ldrsh r0, [r5, r0]
	ldr r2, _021640DC // =0x00000708
	cmp r0, r2
	ble _021640BE
	add r0, r1, #2
	strh r2, [r5, r0]
_021640BE:
	mov r0, #0x3a
	lsl r0, r0, #4
	add r0, r5, r0
	bl TouchField__Process
	pop {r3, r4, r5, r6, r7, pc}
	nop
_021640CC: .word 0x00000555
_021640D0: .word renderCoreGFXControlA
_021640D4: .word renderCoreGFXControlB
_021640D8: .word 0x00000FFF
_021640DC: .word 0x00000708
	thumb_func_end VSLobbyMenu__Func_2163F60

	thumb_func_start VSLobbyMenu__Func_21640E0
VSLobbyMenu__Func_21640E0: // 0x021640E0
	push {r3, r4, r5, r6, r7, lr}
	mov r3, #0xe7
	mov r4, r0
	lsl r3, r3, #2
	ldrsh r0, [r4, r3]
	cmp r0, #0
	blt _021641D0
	add r0, r3, #2
	ldrsh r1, [r4, r0]
	ldr r0, _02164220 // =0x00000708
	sub r0, r0, r1
	mov r1, #0x3c
	bl _s32_div_f
	mov r1, #0xe7
	lsl r1, r1, #2
	strh r0, [r4, r1]
	ldrsh r5, [r4, r1]
	mov r1, #0xa
	mov r0, r5
	bl _s32_div_f
	mov r1, #0xa
	bl _s32_div_f
	lsl r0, r1, #0x10
	lsr r0, r0, #0x10
	str r0, [sp]
	mov r6, #0x8a
	mov r0, r5
	mov r1, #0xa
	lsl r6, r6, #2
	bl _s32_div_f
	lsl r1, r1, #0x10
	add r0, r4, r6
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	add r0, r4, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r5, r6
	add r5, #0x64
	ldr r1, [sp]
	add r0, r4, r5
	bl AnimatorSprite__SetAnimation
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r7, r6
	sub r7, #0x64
	add r2, r4, r7
	ldr r1, [r2, #0x3c]
	mov r0, #1
	bic r1, r0
	str r1, [r2, #0x3c]
	mov r1, r7
	sub r1, #0x64
	add r1, r4, r1
	ldr r3, [r1, #0x3c]
	ldr r5, _02164224 // =0x0217DF28
	bic r3, r0
	str r3, [r1, #0x3c]
	mov r3, #8
	ldrsh r6, [r2, r3]
	ldrsh r3, [r5, r3]
	add r3, r6, r3
	strh r3, [r1, #8]
	mov r3, #0xa
	ldrsh r6, [r2, r3]
	ldrsh r3, [r5, r3]
	ldr r5, _02164228 // =0x0217DF48
	add r3, r6, r3
	strh r3, [r1, #0xa]
	mov r1, r7
	add r1, #0x64
	add r1, r4, r1
	ldr r3, [r1, #0x3c]
	add r7, #0xc8
	bic r3, r0
	str r3, [r1, #0x3c]
	mov r3, #8
	ldrsh r6, [r2, r3]
	ldrsh r3, [r5, r3]
	add r3, r6, r3
	strh r3, [r1, #8]
	mov r3, #0xa
	ldrsh r6, [r2, r3]
	ldrsh r3, [r5, r3]
	add r3, r6, r3
	strh r3, [r1, #0xa]
	ldr r5, [sp]
	add r3, r4, r7
	cmp r5, #0
	ldr r1, _0216422C // =0x0217DF58
	ldr r5, [r3, #0x3c]
	beq _021641B4
	bic r5, r0
	str r5, [r3, #0x3c]
	b _021641BA
_021641B4:
	mov r0, #1
	orr r0, r5
	str r0, [r3, #0x3c]
_021641BA:
	mov r0, #8
	ldrsh r5, [r2, r0]
	ldrsh r0, [r1, r0]
	add r0, r5, r0
	strh r0, [r3, #8]
	mov r0, #0xa
	ldrsh r2, [r2, r0]
	ldrsh r0, [r1, r0]
	add r0, r2, r0
	strh r0, [r3, #0xa]
	b _02164200
_021641D0:
	mov r1, #0x71
	lsl r1, r1, #2
	add r5, r4, r1
	ldr r0, [r5, #0x3c]
	mov r2, #1
	orr r0, r2
	str r0, [r5, #0x3c]
	mov r0, r1
	sub r0, #0x64
	add r5, r4, r0
	ldr r0, [r5, #0x3c]
	add r1, #0x64
	orr r0, r2
	add r1, r4, r1
	str r0, [r5, #0x3c]
	ldr r0, [r1, #0x3c]
	orr r0, r2
	str r0, [r1, #0x3c]
	mov r0, r3
	sub r0, #0xd4
	ldr r0, [r4, r0]
	sub r3, #0xd4
	orr r0, r2
	str r0, [r4, r3]
_02164200:
	mov r0, #0x2f
	mov r5, r4
	lsl r0, r0, #4
	add r5, #0x34
	add r4, r4, r0
	cmp r5, r4
	beq _0216421A
_0216420E:
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	add r5, #0x64
	cmp r5, r4
	bne _0216420E
_0216421A:
	bl VSState__Draw
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02164220: .word 0x00000708
_02164224: .word 0x0217DF28
_02164228: .word 0x0217DF48
_0216422C: .word 0x0217DF58
	thumb_func_end VSLobbyMenu__Func_21640E0

	thumb_func_start VSLobbyMenu__LoadAssets
VSLobbyMenu__LoadAssets: // 0x02164230
	push {r4, lr}
	sub sp, #0x38
	mov r3, #0
	mov r4, r0
	sub r1, r3, #1
	ldr r0, _021642CC // =aNarcDmvsCmnNar_0
	str r3, [sp]
	mov r2, r1
	bl ArchiveFile__Load
	str r0, [r4]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _02164270
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0216425C: // jump table
	.hword _02164268 - _0216425C - 2 // case 0
	.hword _02164268 - _0216425C - 2 // case 1
	.hword _02164268 - _0216425C - 2 // case 2
	.hword _02164268 - _0216425C - 2 // case 3
	.hword _02164268 - _0216425C - 2 // case 4
	.hword _02164268 - _0216425C - 2 // case 5
_02164268:
	bl RenderCore_GetLanguagePtr
	ldrb r1, [r0, #0]
	b _02164272
_02164270:
	mov r1, #1
_02164272:
	mov r0, #0
	mov r2, r4
	str r0, [sp]
	add r2, #0x20
	str r2, [sp, #4]
	mov r2, #2
	str r2, [sp, #8]
	add r2, r4, #4
	str r2, [sp, #0xc]
	ldr r2, _021642D0 // =aDmvsTitleBac_0
	str r2, [sp, #0x10]
	mov r2, r4
	add r2, #8
	str r2, [sp, #0x14]
	lsl r2, r1, #2
	ldr r1, _021642D4 // =0x0217EC1C
	ldr r1, [r1, r2]
	mov r2, #1
	str r1, [sp, #0x18]
	mov r1, r4
	add r1, #0xc
	str r1, [sp, #0x1c]
	ldr r1, _021642D8 // =aDmvsCursorBac_0
	str r1, [sp, #0x20]
	mov r1, r4
	add r1, #0x14
	str r1, [sp, #0x24]
	ldr r1, _021642DC // =aDmvsTimeBac_0
	str r1, [sp, #0x28]
	mov r1, r4
	add r1, #0x10
	str r1, [sp, #0x2c]
	ldr r1, _021642E0 // =aDmvsBtnBac
	str r1, [sp, #0x30]
	str r0, [sp, #0x34]
	mov r1, r4
	ldr r0, [r4, #0]
	add r4, #0x1c
	add r1, #0x18
	mov r3, r4
	bl StageClear__LoadFiles
	add sp, #0x38
	pop {r4, pc}
	nop
_021642CC: .word aNarcDmvsCmnNar_0
_021642D0: .word aDmvsTitleBac_0
_021642D4: .word 0x0217EC1C
_021642D8: .word aDmvsCursorBac_0
_021642DC: .word aDmvsTimeBac_0
_021642E0: .word aDmvsBtnBac
	thumb_func_end VSLobbyMenu__LoadAssets

	thumb_func_start VSLobbyMenu__ReleaseAssets
VSLobbyMenu__ReleaseAssets: // 0x021642E4
	push {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0]
	bl _FreeHEAP_USER
	mov r0, #0
	mov r1, r4
	mov r2, #0x28
	bl MIi_CpuClear32
	pop {r4, pc}
	.align 2, 0
	thumb_func_end VSLobbyMenu__ReleaseAssets

	thumb_func_start VSLobbyMenu__Func_21642FC
VSLobbyMenu__Func_21642FC: // 0x021642FC
	push {r3, r4, r5, r6, r7, lr}
	mov r4, #0
	bl VSLobbyMenu__IsRace
	cmp r0, #0
	beq _0216432C
	ldr r5, _02164358 // =ovl03_0217DE84
	mov r6, r4
	mov r7, #1
_0216430E:
	ldrb r0, [r5, #0]
	mov r1, #0
	mov r2, #1
	bl MenuHelpers__CheckProgress
	cmp r0, #0
	beq _02164322
	mov r0, r7
	lsl r0, r6
	orr r4, r0
_02164322:
	add r6, r6, #1
	add r5, r5, #1
	cmp r6, #0x11
	blo _0216430E
	b _0216434E
_0216432C:
	ldr r6, _0216435C // =ovl03_0217DE80
	mov r5, r4
	mov r7, #1
_02164332:
	ldrb r0, [r6, #0]
	mov r1, #0
	mov r2, #1
	bl MenuHelpers__CheckProgress
	cmp r0, #0
	beq _02164346
	mov r0, r7
	lsl r0, r5
	orr r4, r0
_02164346:
	add r5, r5, #1
	add r6, r6, #1
	cmp r5, #4
	blo _02164332
_0216434E:
	cmp r4, #0
	bne _02164354
	mov r4, #1
_02164354:
	mov r0, r4
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02164358: .word ovl03_0217DE84
_0216435C: .word ovl03_0217DE80
	thumb_func_end VSLobbyMenu__Func_21642FC

	thumb_func_start VSLobbyMenu__Func_2164360
VSLobbyMenu__Func_2164360: // 0x02164360
	push {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl VSLobbyMenu__IsRace
	cmp r0, #0
	beq _0216437C
	cmp r5, #7
	bhs _02164378
	lsl r0, r5, #1
	add r0, r4, r0
	pop {r3, r4, r5, pc}
_02164378:
	add r0, r5, #7
	pop {r3, r4, r5, pc}
_0216437C:
	mov r0, r5
	pop {r3, r4, r5, pc}
	thumb_func_end VSLobbyMenu__Func_2164360

	thumb_func_start VSLobbyMenu__IsRace
VSLobbyMenu__IsRace: // 0x02164380
	ldr r0, _02164390 // =gameState
	ldr r0, [r0, #0x20]
	cmp r0, #0
	bne _0216438C
	mov r0, #1
	bx lr
_0216438C:
	mov r0, #0
	bx lr
	.align 2, 0
_02164390: .word gameState
	thumb_func_end VSLobbyMenu__IsRace

	thumb_func_start VSLobbyMenu__Main1
VSLobbyMenu__Main1: // 0x02164394
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl MultibootManager__GetField8
	cmp r0, #0xc
	bgt _021643AC
	bge _021643FE
	cmp r0, #0
	beq _021643CC
	pop {r4, pc}
_021643AC:
	cmp r0, #0x18
	bgt _02164422
	cmp r0, #0x14
	blt _02164422
	beq _021643FE
	cmp r0, #0x16
	beq _021643C0
	cmp r0, #0x18
	beq _021643C6
	pop {r4, pc}
_021643C0:
	bl MultibootManager__Func_20613E4
	pop {r4, pc}
_021643C6:
	bl MultibootManager__Create
	pop {r4, pc}
_021643CC:
	mov r0, #1
	bl RequestSysEventChange
	bl NextSysEvent
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _021643EE
	bl VSLobbyMenu__Func_2163D90
	cmp r0, #0
	bne _021643EE
	bl ReleaseStageCommonAssets
	bl ReleaseStageCommonArchives
_021643EE:
	bl MultibootManager__Func_2060C9C
	ldr r0, [r4, #8]
	bl DestroyTask
	bl DestroyCurrentTask
	pop {r4, pc}
_021643FE:
	bl MultibootManager__Func_2060D0C
	cmp r0, #0
	beq _0216440A
	mov r1, #0
	b _0216440C
_0216440A:
	mov r1, #1
_0216440C:
	mov r0, #0xe2
	lsl r0, r0, #2
	str r1, [r4, r0]
	bl MultibootManager__Func_2060D0C
	mov r1, #0xe
	lsl r1, r1, #6
	str r0, [r4, r1]
	ldr r0, _02164424 // =VSLobbyMenu__Main_2164428
	bl SetCurrentTaskMainEvent
_02164422:
	pop {r4, pc}
	.align 2, 0
_02164424: .word VSLobbyMenu__Main_2164428
	thumb_func_end VSLobbyMenu__Main1

	thumb_func_start VSLobbyMenu__Main_2164428
VSLobbyMenu__Main_2164428: // 0x02164428
	push {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r0, #0xe3
	lsl r0, r0, #2
	add r5, r4, r0
	bl MultibootManager__Func_2061BD4
	mov r6, r0
	bl MultibootManager__GetField8
	cmp r0, #0
	bne _02164476
	mov r0, #1
	bl RequestSysEventChange
	bl NextSysEvent
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _02164466
	bl VSLobbyMenu__Func_2163D90
	cmp r0, #0
	bne _02164466
	bl ReleaseStageCommonAssets
	bl ReleaseStageCommonArchives
_02164466:
	bl MultibootManager__Func_2060C9C
	ldr r0, [r4, #8]
	bl DestroyTask
	bl DestroyCurrentTask
	pop {r4, r5, r6, pc}
_02164476:
	bl MultibootManager__Func_2061A24
	cmp r0, #0
	beq _021644C0
	mov r0, r6
	mov r1, r5
	mov r2, #0x10
	bl MIi_CpuCopy32
	mov r1, #0xe2
	lsl r1, r1, #2
	ldr r1, [r4, r1]
	add r0, r5, #5
	lsl r3, r1, #1
	ldrb r2, [r0, r3]
	mov r1, #0x3c
	bic r2, r1
	strb r2, [r0, r3]
	bl VSLobbyMenu__Func_21642FC
	ldr r1, [r5, #8]
	orr r0, r1
	str r0, [r5, #8]
	bl Task__Unknown204BE48__Rand
	ldr r1, [r5, #0]
	eor r0, r1
	str r0, [r5]
	mov r0, r5
	mov r1, #0x10
	bl MultibootManager__Func_2061A98
	bl MultibootManager__Func_206193C
	ldr r0, _021644C4 // =VSLobbyMenu__Main_21644C8
	bl SetCurrentTaskMainEvent
_021644C0:
	pop {r4, r5, r6, pc}
	nop
_021644C4: .word VSLobbyMenu__Main_21644C8
	thumb_func_end VSLobbyMenu__Main_2164428

	thumb_func_start VSLobbyMenu__Main_21644C8
VSLobbyMenu__Main_21644C8: // 0x021644C8
	push {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl MultibootManager__GetField8
	cmp r0, #0
	bne _0216450A
	mov r0, #1
	bl RequestSysEventChange
	bl NextSysEvent
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _021644FA
	bl VSLobbyMenu__Func_2163D90
	cmp r0, #0
	bne _021644FA
	bl ReleaseStageCommonAssets
	bl ReleaseStageCommonArchives
_021644FA:
	bl MultibootManager__Func_2060C9C
	ldr r0, [r4, #8]
	bl DestroyTask
	bl DestroyCurrentTask
	pop {r3, r4, r5, pc}
_0216450A:
	bl MultibootManager__Func_20619B4
	cmp r0, #0
	beq _02164538
	mov r0, #0xe3
	lsl r0, r0, #2
	add r5, r4, r0
	bl MultibootManager__Func_2061BD4
	ldr r1, [r5, #8]
	ldr r0, [r0, #8]
	orr r0, r1
	str r0, [r5, #8]
	bl Task__Unknown204BE48__Rand
	mov r1, #0xe3
	lsl r1, r1, #2
	ldr r2, [r4, r1]
	eor r0, r2
	str r0, [r4, r1]
	ldr r0, _0216453C // =VSLobbyMenu__Main_2164540
	bl SetCurrentTaskMainEvent
_02164538:
	pop {r3, r4, r5, pc}
	nop
_0216453C: .word VSLobbyMenu__Main_2164540
	thumb_func_end VSLobbyMenu__Main_21644C8

	thumb_func_start VSLobbyMenu__Main_2164540
VSLobbyMenu__Main_2164540: // 0x02164540
	push {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r5, _02164608 // =gameState
	bl MultibootManager__Func_2060CF0
	cmp r0, #2
	bne _02164586
	bl MultibootManager__Func_2060D34
	cmp r0, #0
	beq _02164586
	mov r0, r5
	ldr r0, [r0, #0x20]
	cmp r0, #0
	bne _02164566
	mov r0, #1
	b _02164568
_02164566:
	mov r0, #0
_02164568:
	bl SaveGame__SetLastPlayedVsMode
	cmp r0, #0
	bne _02164586
	mov r0, #2
	bl RequestSysEventChange
	bl NextSysEvent
	ldr r0, [r4, #8]
	bl DestroyTask
	bl DestroyCurrentTask
	pop {r3, r4, r5, pc}
_02164586:
	ldr r1, [r4, #0]
	mov r0, #0x1f
	orr r0, r1
	str r0, [r4]
	mov r0, #0xe1
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r1, r1, #1
	str r1, [r4, r0]
	bl VSLobbyMenu__Func_2163D90
	cmp r0, #0
	beq _021645EE
	mov r0, #1
	str r0, [r5, #0x14]
	bl MultibootManager__Func_2060DC4
	cmp r0, #0
	bne _021645B0
	mov r0, #0
	b _021645B2
_021645B0:
	mov r0, #1
_021645B2:
	str r0, [r5, #0x20]
	ldr r1, [r5, #0x10]
	ldr r0, _0216460C // =0xFFFFFBCF
	and r0, r1
	str r0, [r5, #0x10]
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _021645CE
	ldr r1, [r5, #0x10]
	mov r0, #0x30
	orr r0, r1
	str r0, [r5, #0x10]
	b _021645E8
_021645CE:
	bl MultibootManager__Func_2060CF0
	cmp r0, #2
	ldr r1, [r5, #0x10]
	bne _021645E2
	mov r0, #0x42
	lsl r0, r0, #4
	orr r0, r1
	str r0, [r5, #0x10]
	b _021645E8
_021645E2:
	mov r0, #0x20
	orr r0, r1
	str r0, [r5, #0x10]
_021645E8:
	bl VSLobbyMenu__InitAssets
	pop {r3, r4, r5, pc}
_021645EE:
	bl MultibootManager__Func_2060CF0
	cmp r0, #2
	beq _021645FC
	bl VSLobbyMenu__InitAssets
	pop {r3, r4, r5, pc}
_021645FC:
	bl MultibootManager__Func_20618A8
	ldr r0, _02164610 // =VSLobbyMenu__Main_2164614
	bl SetCurrentTaskMainEvent
	pop {r3, r4, r5, pc}
	.align 2, 0
_02164608: .word gameState
_0216460C: .word 0xFFFFFBCF
_02164610: .word VSLobbyMenu__Main_2164614
	thumb_func_end VSLobbyMenu__Main_2164540

	thumb_func_start VSLobbyMenu__Main_2164614
VSLobbyMenu__Main_2164614: // 0x02164614
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl MultibootManager__GetField8
	cmp r0, #0
	beq _0216462A
	cmp r0, #0x14
	beq _0216465C
	pop {r4, pc}
_0216462A:
	mov r0, #1
	bl RequestSysEventChange
	bl NextSysEvent
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _0216464C
	bl VSLobbyMenu__Func_2163D90
	cmp r0, #0
	bne _0216464C
	bl ReleaseStageCommonAssets
	bl ReleaseStageCommonArchives
_0216464C:
	bl MultibootManager__Func_2060C9C
	ldr r0, [r4, #8]
	bl DestroyTask
	bl DestroyCurrentTask
	pop {r4, pc}
_0216465C:
	bl VSLobbyMenu__InitAssets
	pop {r4, pc}
	.align 2, 0
	thumb_func_end VSLobbyMenu__Main_2164614

	thumb_func_start VSLobbyMenu__InitAssets
VSLobbyMenu__InitAssets: // 0x02164664
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x70
	bl GetCurrentTaskWork_
	str r0, [sp, #0x24]
	bl VSLobbyMenu__SetupDisplay
	mov r0, #0
	bl LoadSysSound
	ldr r0, [sp, #0x24]
	add r0, #0xc
	bl VSLobbyMenu__LoadAssets
	ldr r0, [sp, #0x24]
	mov r2, #0x38
	ldr r4, [r0, #0x28]
	mov r0, #1
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, sp, #0x28
	mov r1, r4
	mov r3, #0
	bl InitBackground
	add r0, sp, #0x28
	bl DrawBackground
	mov r3, #1
	str r3, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, sp, #0x28
	mov r1, r4
	mov r2, #0x38
	bl InitBackground
	mov r0, #0xc0
	str r0, [sp, #0x34]
	add r0, sp, #0x28
	bl DrawBackground
	ldr r0, [sp, #0x24]
	mov r2, #0x38
	ldr r4, [r0, #0x24]
	mov r0, #2
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	str r0, [sp, #8]
	add r0, sp, #0x28
	mov r1, r4
	mov r3, #0
	bl InitBackground
	add r0, sp, #0x28
	bl DrawBackground
	mov r0, #2
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	str r0, [sp, #8]
	add r0, sp, #0x28
	mov r1, r4
	mov r2, #0x38
	mov r3, #1
	bl InitBackground
	add r0, sp, #0x28
	bl DrawBackground
	ldr r5, [sp, #0x24]
	ldr r4, _02164888 // =ovl03_0217DEF8
	mov r6, #0
	add r5, #0x34
_02164706:
	ldrh r0, [r4, #0]
	ldr r7, [r4, #4]
	lsl r1, r0, #2
	ldr r0, [sp, #0x24]
	add r0, r0, r1
	ldr r0, [r0, #0xc]
	cmp r6, #2
	str r0, [sp, #0x14]
	ldrh r0, [r4, #2]
	str r0, [sp, #0x20]
	bne _02164730
	mov r0, #0
	mvn r0, r0
	str r0, [sp]
	ldr r0, [sp, #0x14]
	mov r1, r7
	mov r2, #0
	mov r3, #1
	bl StageSelectMenu__Func_215E8EC
	b _0216473A
_02164730:
	ldr r0, [sp, #0x14]
	ldr r2, [sp, #0x20]
	mov r1, r7
	bl SpriteUnknown__GetSpriteSizeFromAnim
_0216473A:
	str r7, [sp]
	str r0, [sp, #4]
	ldrb r0, [r4, #0xc]
	mov r3, #2
	ldr r1, [sp, #0x14]
	str r0, [sp, #8]
	ldrb r0, [r4, #0xd]
	lsl r3, r3, #0xa
	str r0, [sp, #0xc]
	ldrb r0, [r4, #0xe]
	str r0, [sp, #0x10]
	ldr r2, [sp, #0x20]
	mov r0, r5
	bl SpriteUnknown__InitAnimator
	ldr r0, [r4, #8]
	cmp r6, #2
	str r0, [r5, #8]
	bne _0216477A
	bl VSLobbyMenu__IsRace
	cmp r0, #0
	beq _02164772
	mov r0, r5
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	b _0216477A
_02164772:
	mov r0, r5
	mov r1, #1
	bl AnimatorSprite__SetAnimation
_0216477A:
	add r6, r6, #1
	add r4, #0x10
	add r5, #0x64
	cmp r6, #7
	blo _02164706
	mov r0, #0
	mov r7, #0xbd
	str r0, [sp, #0x1c]
	str r0, [sp, #0x18]
	ldr r0, [sp, #0x24]
	lsl r7, r7, #2
	add r0, r0, r7
	bl FontFile__Init
	ldr r0, [sp, #0x24]
	ldr r1, _0216488C // =aFntFontIplFnt_2
	add r0, r0, r7
	mov r2, #0
	bl FontFile__InitFromPath
	mov r4, #6
	bl MultibootManager__Func_2060CF0
	cmp r0, #2
	bne _021647B4
	mov r5, #1
	mov r6, #0
	orr r4, r5
	b _021647C6
_021647B4:
	bl MultibootManager__Func_2060D0C
	cmp r0, #0
	beq _021647C2
	mov r6, #0
	mov r5, #1
	b _021647C6
_021647C2:
	mov r6, #1
	mov r5, #0
_021647C6:
	bl VSState__AllocAssets
	mov r1, #0
	mov r0, r4
	mov r2, #2
	mov r3, r1
	bl VSState__LoadAssets
	ldr r0, [sp, #0x24]
	mov r1, #0
	add r0, r0, r7
	mov r2, #7
	mov r3, #1
	bl VSState__Func_2163510
	bl MultibootManager__Func_2060CF0
	cmp r0, #2
	bne _021647F8
	bl SaveGame__GetOnlineScore
	str r0, [sp, #0x1c]
	bl MultibootManager__Func_2060D9C
	str r0, [sp, #0x18]
_021647F8:
	ldr r1, [sp, #0x1c]
	mov r0, r6
	bl VSState__SetPlayerInfo
	bl MultibootManager__Func_2060D4C
	mov r6, r0
	bl MultibootManager__Func_2060D74
	mov r2, r0
	ldr r3, [sp, #0x18]
	mov r0, r5
	mov r1, r6
	bl VSState__SetPlayerInfoEx
	mov r0, r4
	bl VSState__InitSprites
	bl VSStageSelectMenu__Alloc
	ldr r0, [sp, #0x24]
	ldr r1, [r0, #0]
	mov r0, #1
	lsl r0, r0, #0xe
	orr r1, r0
	ldr r0, [sp, #0x24]
	str r1, [r0]
	bl LoadConnectionStatusIconAssets
	mov r1, #0
	str r1, [sp]
	mov r0, #0xe4
	str r0, [sp, #4]
	mov r0, #0xa6
	str r0, [sp, #8]
	mov r0, #2
	mov r2, #0xc
	mov r3, #1
	bl CreateConnectionStatusIcon
	bl VSCharacterSelect__Alloc
	ldr r0, [sp, #0x24]
	ldr r1, [r0, #0]
	mov r0, #2
	lsl r0, r0, #0xc
	orr r1, r0
	ldr r0, [sp, #0x24]
	str r1, [r0]
	mov r0, #1
	bl StartSamplingTouchInput
	mov r1, #0x3a
	ldr r0, [sp, #0x24]
	lsl r1, r1, #4
	add r0, r0, r1
	bl TouchField__Init
	ldr r1, _02164890 // =0x0000039E
	ldr r0, [sp, #0x24]
	mov r2, #0
	strh r2, [r0, r1]
	sub r1, r1, #2
	strh r2, [r0, r1]
	bl MultibootManager__Func_206193C
	ldr r0, _02164894 // =VSLobbyMenu__Main_2164898
	bl SetCurrentTaskMainEvent
	add sp, #0x70
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02164888: .word ovl03_0217DEF8
_0216488C: .word aFntFontIplFnt_2
_02164890: .word 0x0000039E
_02164894: .word VSLobbyMenu__Main_2164898
	thumb_func_end VSLobbyMenu__InitAssets

	thumb_func_start VSLobbyMenu__Main_2164898
VSLobbyMenu__Main_2164898: // 0x02164898
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl MultibootManager__GetField8
	cmp r0, #0
	bne _021648B0
	ldr r0, _02164900 // =VSLobbyMenu__Main_2164E64
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_021648B0:
	bl MultibootManager__Func_20619B4
	cmp r0, #0
	beq _021648FE
	mov r0, #0xe1
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r4, r0]
	ldr r1, _02164904 // =renderCoreGFXControlA+0x00000040
	mov r0, #0x18
	ldrsh r0, [r1, r0]
	cmp r0, #0
	beq _021648E0
	bge _021648D0
	mov r0, #2
	b _021648D2
_021648D0:
	mov r0, #3
_021648D2:
	lsl r0, r0, #0x10
	mov r1, #1
	lsr r0, r0, #0x10
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	b _021648EA
_021648E0:
	mov r1, #1
	mov r0, #0x42
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
_021648EA:
	mov r0, #0x29
	mov r1, #0
	bl PlaySysTrack
	mov r0, #0
	bl VSCharacterSelect__Create
	ldr r0, _02164908 // =VSLobbyMenu__Main_216490C
	bl SetCurrentTaskMainEvent
_021648FE:
	pop {r4, pc}
	.align 2, 0
_02164900: .word VSLobbyMenu__Main_2164E64
_02164904: .word renderCoreGFXControlA+0x00000040
_02164908: .word VSLobbyMenu__Main_216490C
	thumb_func_end VSLobbyMenu__Main_2164898

	thumb_func_start VSLobbyMenu__Main_216490C
VSLobbyMenu__Main_216490C: // 0x0216490C
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl MultibootManager__GetField8
	cmp r0, #0
	bne _02164924
	ldr r0, _0216495C // =VSLobbyMenu__Main_2164E64
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_02164924:
	mov r0, #0xe1
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r1, r1, #1
	str r1, [r4, r0]
	mov r0, r4
	bl VSLobbyMenu__Func_2163F60
	mov r0, r4
	bl VSLobbyMenu__Func_21640E0
	bl VSCharacterSelect__Func_2162374
	cmp r0, #0
	beq _0216495A
	bl VSCharacterSelect__Free
	ldr r1, [r4, #0]
	ldr r0, _02164960 // =0xFFFFBFFF
	and r0, r1
	str r0, [r4]
	mov r0, #0
	bl VSStageSelectMenu__Create
	ldr r0, _02164964 // =VSLobbyMenu__Main_2164968
	bl SetCurrentTaskMainEvent
_0216495A:
	pop {r4, pc}
	.align 2, 0
_0216495C: .word VSLobbyMenu__Main_2164E64
_02164960: .word 0xFFFFBFFF
_02164964: .word VSLobbyMenu__Main_2164968
	thumb_func_end VSLobbyMenu__Main_216490C

	thumb_func_start VSLobbyMenu__Main_2164968
VSLobbyMenu__Main_2164968: // 0x02164968
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl MultibootManager__GetField8
	cmp r0, #0
	bne _02164980
	ldr r0, _021649C8 // =VSLobbyMenu__Main_2164E64
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_02164980:
	mov r0, #0xe1
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r1, r1, #1
	str r1, [r4, r0]
	mov r0, r4
	bl VSLobbyMenu__Func_2163F60
	mov r0, r4
	bl VSLobbyMenu__Func_21640E0
	bl VSStageSelectMenu__Func_2160C3C
	cmp r0, #0
	beq _021649C6
	mov r1, #0xe
	lsl r1, r1, #6
	ldr r0, [r4, r1]
	cmp r0, #0
	beq _021649B2
	mov r0, r1
	add r0, #0x1a
	ldrh r2, [r4, r0]
	mov r0, #2
	b _021649BA
_021649B2:
	mov r0, r1
	add r0, #0x1a
	ldrh r2, [r4, r0]
	mov r0, #4
_021649BA:
	orr r0, r2
	add r1, #0x1a
	strh r0, [r4, r1]
	ldr r0, _021649CC // =VSLobbyMenu__Main_21649D0
	bl SetCurrentTaskMainEvent
_021649C6:
	pop {r4, pc}
	.align 2, 0
_021649C8: .word VSLobbyMenu__Main_2164E64
_021649CC: .word VSLobbyMenu__Main_21649D0
	thumb_func_end VSLobbyMenu__Main_2164968

	thumb_func_start VSLobbyMenu__Main_21649D0
VSLobbyMenu__Main_21649D0: // 0x021649D0
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #8
	bl GetCurrentTaskWork_
	mov r7, r0
	mov r0, #0xe3
	lsl r0, r0, #2
	mov r6, #1
	add r5, r7, r0
	bl MultibootManager__GetField8
	cmp r0, #0
	bne _021649F4
	ldr r0, _02164C00 // =VSLobbyMenu__Main_2164E64
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
_021649F4:
	mov r0, #0xe1
	lsl r0, r0, #2
	ldr r1, [r7, r0]
	add r1, r1, #1
	str r1, [r7, r0]
	mov r0, r7
	bl VSLobbyMenu__Func_2163F60
	mov r0, r7
	bl VSLobbyMenu__Func_21640E0
	mov r4, #0
	mov r0, r4
	b _02164A48
_02164A10:
	lsl r1, r4, #1
	add r1, r5, r1
	ldrb r1, [r1, #5]
	lsl r1, r1, #0x1a
	lsr r1, r1, #0x1c
	cmp r1, #0xc
	bhi _02164A44
	add r1, r1, r1
	add r1, pc
	ldrh r1, [r1, #6]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add pc, r1
_02164A2A: // jump table
	.hword _02164A44 - _02164A2A - 2 // case 0
	.hword _02164A44 - _02164A2A - 2 // case 1
	.hword _02164A44 - _02164A2A - 2 // case 2
	.hword _02164A44 - _02164A2A - 2 // case 3
	.hword _02164A44 - _02164A2A - 2 // case 4
	.hword _02164A44 - _02164A2A - 2 // case 5
	.hword _02164A44 - _02164A2A - 2 // case 6
	.hword _02164A46 - _02164A2A - 2 // case 7
	.hword _02164A46 - _02164A2A - 2 // case 8
	.hword _02164A46 - _02164A2A - 2 // case 9
	.hword _02164A46 - _02164A2A - 2 // case 10
	.hword _02164A46 - _02164A2A - 2 // case 11
	.hword _02164A46 - _02164A2A - 2 // case 12
_02164A44:
	mov r6, r0
_02164A46:
	add r4, r4, #1
_02164A48:
	cmp r4, #2
	blo _02164A10
	cmp r6, #0
	bne _02164A52
	b _02164BFA
_02164A52:
	mov r0, #0xe2
	lsl r0, r0, #2
	ldr r0, [r7, r0]
	cmp r0, #0
	beq _02164A5E
	b _02164B64
_02164A5E:
	mov r4, #0
	add r6, sp, #0
	b _02164ABE
_02164A64:
	lsl r0, r4, #1
	add r0, r5, r0
	ldrb r1, [r0, #5]
	lsl r1, r1, #0x1a
	lsr r1, r1, #0x1c
	cmp r1, #0xc
	bhi _02164ABC
	add r1, r1, r1
	add r1, pc
	ldrh r1, [r1, #6]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add pc, r1
_02164A7E: // jump table
	.hword _02164ABC - _02164A7E - 2 // case 0
	.hword _02164ABC - _02164A7E - 2 // case 1
	.hword _02164ABC - _02164A7E - 2 // case 2
	.hword _02164ABC - _02164A7E - 2 // case 3
	.hword _02164ABC - _02164A7E - 2 // case 4
	.hword _02164ABC - _02164A7E - 2 // case 5
	.hword _02164ABC - _02164A7E - 2 // case 6
	.hword _02164A98 - _02164A7E - 2 // case 7
	.hword _02164A98 - _02164A7E - 2 // case 8
	.hword _02164A98 - _02164A7E - 2 // case 9
	.hword _02164AA6 - _02164A7E - 2 // case 10
	.hword _02164AB4 - _02164A7E - 2 // case 11
	.hword _02164A98 - _02164A7E - 2 // case 12
_02164A98:
	ldrb r0, [r0, #4]
	mov r1, #0
	bl VSLobbyMenu__Func_2164360
	lsl r1, r4, #2
	str r0, [r6, r1]
	b _02164ABC
_02164AA6:
	ldrb r0, [r0, #4]
	mov r1, #1
	bl VSLobbyMenu__Func_2164360
	lsl r1, r4, #2
	str r0, [r6, r1]
	b _02164ABC
_02164AB4:
	mov r0, #0
	lsl r1, r4, #2
	mvn r0, r0
	str r0, [r6, r1]
_02164ABC:
	add r4, r4, #1
_02164ABE:
	cmp r4, #2
	blo _02164A64
	mov r0, #0
	ldr r1, [sp]
	mvn r0, r0
	cmp r1, r0
	bne _02164ADE
	ldr r1, [sp, #4]
	cmp r1, r0
	beq _02164ADE
	strb r1, [r5, #0xc]
	ldrh r1, [r5, #0xe]
	mov r0, #0x10
	bic r1, r0
	strh r1, [r5, #0xe]
	b _02164B5A
_02164ADE:
	mov r0, #0
	ldr r2, [sp]
	mvn r0, r0
	cmp r2, r0
	beq _02164AFA
	ldr r1, [sp, #4]
	cmp r1, r0
	bne _02164AFA
	strb r2, [r5, #0xc]
	ldrh r1, [r5, #0xe]
	mov r0, #0x10
	bic r1, r0
	strh r1, [r5, #0xe]
	b _02164B5A
_02164AFA:
	mov r0, #0
	ldr r1, [sp]
	mvn r0, r0
	cmp r1, r0
	bne _02164B1A
	ldr r1, [sp, #4]
	cmp r1, r0
	bne _02164B1A
	bl VSLobbyMenu__Func_2163D34
	strb r0, [r5, #0xc]
	ldrh r1, [r5, #0xe]
	mov r0, #0x10
	orr r0, r1
	strh r0, [r5, #0xe]
	b _02164B5A
_02164B1A:
	ldr r1, [sp]
	ldr r0, [sp, #4]
	cmp r1, r0
	bne _02164B2E
	strb r1, [r5, #0xc]
	ldrh r1, [r5, #0xe]
	mov r0, #0x10
	bic r1, r0
	strh r1, [r5, #0xe]
	b _02164B5A
_02164B2E:
	ldr r1, _02164C04 // =_mt_math_rand
	ldr r0, _02164C08 // =0x00196225
	ldr r2, [r1, #0]
	mov r3, r2
	mul r3, r0
	ldr r0, _02164C0C // =0x3C6EF35F
	add r0, r3, r0
	str r0, [r1]
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	asr r1, r0, #4
	mov r0, #1
	and r0, r1
	lsl r1, r0, #2
	add r0, sp, #0
	ldr r0, [r0, r1]
	strb r0, [r5, #0xc]
	ldrh r1, [r5, #0xe]
	mov r0, #0x10
	orr r0, r1
	strh r0, [r5, #0xe]
_02164B5A:
	ldrh r1, [r5, #0xe]
	mov r0, #8
	orr r0, r1
	strh r0, [r5, #0xe]
	b _02164B82
_02164B64:
	ldrh r1, [r5, #0xe]
	mov r0, #8
	tst r0, r1
	beq _02164BFA
	bl MultibootManager__Func_2061A24
	cmp r0, #0
	beq _02164B82
	bl MultibootManager__Func_2061BD4
	ldrb r0, [r0, #0xc]
	strb r0, [r5, #0xc]
	ldrh r0, [r5, #0xe]
	orr r0, r0
	strh r0, [r5, #0xe]
_02164B82:
	bl VSLobbyMenu__IsRace
	cmp r0, #0
	ldrb r1, [r5, #0xc]
	beq _02164B94
	ldr r0, _02164C10 // =ovl03_0217DE84
	ldrb r1, [r0, r1]
	ldr r0, _02164C14 // =gameState
	b _02164B9A
_02164B94:
	ldr r0, _02164C18 // =ovl03_0217DE80
	ldrb r1, [r0, r1]
	ldr r0, _02164C14 // =gameState
_02164B9A:
	mov r2, #0xe2
	lsl r2, r2, #2
	strh r1, [r0, #0x28]
	ldr r0, [r7, r2]
	mov r1, #1
	lsl r0, r0, #1
	add r0, r5, r0
	ldrb r0, [r0, #5]
	lsl r0, r0, #0x1e
	lsr r0, r0, #0x1e
	mov r3, r0
	ldr r0, _02164C14 // =gameState
	and r3, r1
	str r3, [r0, #4]
	ldr r0, [r7, r2]
	cmp r0, #0
	bne _02164BD6
	ldrb r0, [r5, #5]
	lsl r0, r0, #0x1e
	lsr r0, r0, #0x1e
	mov r2, r0
	ldr r0, _02164C14 // =gameState
	and r2, r1
	str r2, [r0, #8]
	ldrb r0, [r5, #7]
	lsl r0, r0, #0x1e
	lsr r0, r0, #0x1e
	and r1, r0
	ldr r0, _02164C14 // =gameState
	b _02164BEE
_02164BD6:
	ldrb r0, [r5, #7]
	lsl r0, r0, #0x1e
	lsr r0, r0, #0x1e
	mov r2, r0
	ldr r0, _02164C14 // =gameState
	and r2, r1
	str r2, [r0, #8]
	ldrb r0, [r5, #5]
	lsl r0, r0, #0x1e
	lsr r0, r0, #0x1e
	and r1, r0
	ldr r0, _02164C14 // =gameState
_02164BEE:
	str r1, [r0, #0xc]
	bl MultibootManager__Func_206193C
	ldr r0, _02164C1C // =VSLobbyMenu__Main_2164C20
	bl SetCurrentTaskMainEvent
_02164BFA:
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02164C00: .word VSLobbyMenu__Main_2164E64
_02164C04: .word _mt_math_rand
_02164C08: .word 0x00196225
_02164C0C: .word 0x3C6EF35F
_02164C10: .word ovl03_0217DE84
_02164C14: .word gameState
_02164C18: .word ovl03_0217DE80
_02164C1C: .word VSLobbyMenu__Main_2164C20
	thumb_func_end VSLobbyMenu__Main_21649D0

	thumb_func_start VSLobbyMenu__Main_2164C20
VSLobbyMenu__Main_2164C20: // 0x02164C20
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl MultibootManager__GetField8
	cmp r0, #0
	bne _02164C38
	ldr r0, _02164C84 // =VSLobbyMenu__Main_2164E64
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_02164C38:
	mov r0, #0xe1
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r1, r1, #1
	str r1, [r4, r0]
	mov r0, r4
	bl VSLobbyMenu__Func_2163F60
	mov r0, r4
	bl VSLobbyMenu__Func_21640E0
	bl MultibootManager__Func_20619B4
	cmp r0, #0
	beq _02164C82
	mov r0, #0xe3
	lsl r0, r0, #2
	add r0, r4, r0
	ldrh r1, [r0, #0xe]
	mov r0, #0x10
	tst r0, r1
	beq _02164C6C
	mov r0, #3
	bl VSStageSelectMenu__Create
	b _02164C72
_02164C6C:
	mov r0, #1
	bl VSStageSelectMenu__Create
_02164C72:
	mov r1, #0
	mov r0, #0xe7
	mvn r1, r1
	lsl r0, r0, #2
	strh r1, [r4, r0]
	ldr r0, _02164C88 // =VSLobbyMenu__Main_2164C8C
	bl SetCurrentTaskMainEvent
_02164C82:
	pop {r4, pc}
	.align 2, 0
_02164C84: .word VSLobbyMenu__Main_2164E64
_02164C88: .word VSLobbyMenu__Main_2164C8C
	thumb_func_end VSLobbyMenu__Main_2164C20

	thumb_func_start VSLobbyMenu__Main_2164C8C
VSLobbyMenu__Main_2164C8C: // 0x02164C8C
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl MultibootManager__GetField8
	cmp r0, #0
	bne _02164CA4
	ldr r0, _02164D08 // =VSLobbyMenu__Main_2164E64
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_02164CA4:
	mov r0, #0xe1
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r1, r1, #1
	str r1, [r4, r0]
	mov r0, r4
	bl VSLobbyMenu__Func_2163F60
	mov r0, r4
	bl VSLobbyMenu__Func_21640E0
	bl VSStageSelectMenu__Func_2160C3C
	cmp r0, #0
	beq _02164D04
	bl VSStageSelectMenu__Func_2160C54
	cmp r0, #2
	beq _02164CD0
	cmp r0, #4
	beq _02164CF2
	pop {r4, pc}
_02164CD0:
	mov r1, #1
	mov r0, #5
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	mov r0, #0xc
	bl FadeSysTrack
	mov r0, #1
	ldr r1, [r4, #0]
	lsl r0, r0, #0xc
	orr r0, r1
	str r0, [r4]
	ldr r0, _02164D0C // =VSLobbyMenu__Main_2164D50
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
_02164CF2:
	ldr r1, [r4, #0]
	ldr r0, _02164D10 // =0xFFFFEFFF
	and r0, r1
	str r0, [r4]
	bl MultibootManager__Func_206150C
	ldr r0, _02164D14 // =VSLobbyMenu__Main_2164D18
	bl SetCurrentTaskMainEvent
_02164D04:
	pop {r4, pc}
	nop
_02164D08: .word VSLobbyMenu__Main_2164E64
_02164D0C: .word VSLobbyMenu__Main_2164D50
_02164D10: .word 0xFFFFEFFF
_02164D14: .word VSLobbyMenu__Main_2164D18
	thumb_func_end VSLobbyMenu__Main_2164C8C

	thumb_func_start VSLobbyMenu__Main_2164D18
VSLobbyMenu__Main_2164D18: // 0x02164D18
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl VSLobbyMenu__Func_2163F60
	mov r0, r4
	bl VSLobbyMenu__Func_21640E0
	bl MultibootManager__GetField8
	cmp r0, #0
	beq _02164D38
	cmp r0, #0x15
	beq _02164D44
	cmp r0, #0x16
_02164D38:
	ldr r0, _02164D48 // =gameState+0x00000100
	mov r1, #0
	str r1, [r0, #0x64]
	ldr r0, _02164D4C // =VSLobbyMenu__Main_2164E64
	bl SetCurrentTaskMainEvent
_02164D44:
	pop {r4, pc}
	nop
_02164D48: .word gameState+0x00000100
_02164D4C: .word VSLobbyMenu__Main_2164E64
	thumb_func_end VSLobbyMenu__Main_2164D18

	thumb_func_start VSLobbyMenu__Main_2164D50
VSLobbyMenu__Main_2164D50: // 0x02164D50
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r1, #0xe1
	mov r4, r0
	lsl r1, r1, #2
	ldr r2, [r4, r1]
	add r2, r2, #1
	str r2, [r4, r1]
	bl VSLobbyMenu__Func_2163F60
	mov r0, r4
	bl VSLobbyMenu__Func_21640E0
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _02164D7E
	bl DestroyDrawFadeTask
	ldr r0, _02164D80 // =VSLobbyMenu__Main_2164D84
	bl SetCurrentTaskMainEvent
_02164D7E:
	pop {r4, pc}
	.align 2, 0
_02164D80: .word VSLobbyMenu__Main_2164D84
	thumb_func_end VSLobbyMenu__Main_2164D50

	thumb_func_start VSLobbyMenu__Main_2164D84
VSLobbyMenu__Main_2164D84: // 0x02164D84
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r0, #0xe1
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r1, r1, #1
	str r1, [r4, r0]
	bl StopSamplingTouchInput
	mov r0, #1
	ldr r1, [r4, #0]
	lsl r0, r0, #0xe
	tst r0, r1
	beq _02164DB0
	bl VSCharacterSelect__Free
	ldr r1, [r4, #0]
	ldr r0, _02164E58 // =0xFFFFBFFF
	and r0, r1
	str r0, [r4]
_02164DB0:
	bl ReleaseConnectionStatusIconAssets
	mov r0, #2
	ldr r1, [r4, #0]
	lsl r0, r0, #0xc
	tst r0, r1
	beq _02164DCA
	bl VSStageSelectMenu__Release
	ldr r1, [r4, #0]
	ldr r0, _02164E5C // =0xFFFFDFFF
	and r0, r1
	str r0, [r4]
_02164DCA:
	bl VSState__ReleaseAssets
	mov r0, #0xbd
	lsl r0, r0, #2
	add r0, r4, r0
	bl FontFile__Release
	mov r0, r4
	add r0, #0xc
	bl VSLobbyMenu__ReleaseAssets
	mov r0, #0xe3
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	ldr r0, _02164E60 // =_mt_math_rand
	str r1, [r0]
	ldr r0, [r4, #4]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	bl RequestSysEventChange
	bl NextSysEvent
	bl ReleaseSysSound
	bl MultibootManager__GetField8
	cmp r0, #0
	bne _02164E46
	mov r0, #1
	ldr r1, [r4, #0]
	lsl r0, r0, #0xc
	tst r0, r1
	beq _02164E28
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _02164E22
	bl VSLobbyMenu__Func_2163D90
	cmp r0, #0
	bne _02164E22
	bl ReleaseStageCommonAssets
_02164E22:
	bl VSStageSelectMenu__Func_2160C60
	b _02164E40
_02164E28:
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	beq _02164E40
	bl VSLobbyMenu__Func_2163D90
	cmp r0, #0
	bne _02164E40
	bl ReleaseStageCommonAssets
	bl ReleaseStageCommonArchives
_02164E40:
	mov r0, #1
	bl RequestSysEventChange
_02164E46:
	bl MultibootManager__Func_2060C9C
	ldr r0, [r4, #8]
	bl DestroyTask
	bl DestroyCurrentTask
	pop {r4, pc}
	nop
_02164E58: .word 0xFFFFBFFF
_02164E5C: .word 0xFFFFDFFF
_02164E60: .word _mt_math_rand
	thumb_func_end VSLobbyMenu__Main_2164D84

	thumb_func_start VSLobbyMenu__Main_2164E64
VSLobbyMenu__Main_2164E64: // 0x02164E64
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r0, #1
	str r0, [r4, #4]
	mov r0, #0xe1
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	add r1, r1, #1
	str r1, [r4, r0]
	mov r0, #3
	bl VSLobbyMenu__RemoveFlag
	mov r0, #1
	ldr r1, [r4, #0]
	lsl r0, r0, #0xe
	tst r0, r1
	beq _02164E8E
	bl VSCharacterSelect__Func_2162364
_02164E8E:
	mov r0, #2
	ldr r1, [r4, #0]
	lsl r0, r0, #0xc
	tst r0, r1
	beq _02164E9C
	bl VSStageSelectMenu__Func_2160C2C
_02164E9C:
	mov r0, r4
	bl VSLobbyMenu__Func_2163F60
	mov r0, r4
	bl VSLobbyMenu__Func_21640E0
	ldr r0, _02164EB0 // =VSLobbyMenu__Main_2164EB4
	bl SetCurrentTaskMainEvent
	pop {r4, pc}
	.align 2, 0
_02164EB0: .word VSLobbyMenu__Main_2164EB4
	thumb_func_end VSLobbyMenu__Main_2164E64

	thumb_func_start VSLobbyMenu__Main_2164EB4
VSLobbyMenu__Main_2164EB4: // 0x02164EB4
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r1, #0xe1
	mov r4, r0
	lsl r1, r1, #2
	ldr r2, [r4, r1]
	add r2, r2, #1
	str r2, [r4, r1]
	bl VSLobbyMenu__Func_2163F60
	mov r0, r4
	bl VSLobbyMenu__Func_21640E0
	mov r0, #2
	ldr r1, [r4, #0]
	lsl r0, r0, #0xc
	tst r0, r1
	beq _02164EE2
	bl VSStageSelectMenu__Func_2160C3C
	cmp r0, #0
	beq _02164F08
_02164EE2:
	mov r0, #1
	ldr r1, [r4, #0]
	lsl r0, r0, #0xe
	tst r0, r1
	beq _02164EF4
	bl VSCharacterSelect__Func_2162374
	cmp r0, #0
	beq _02164F08
_02164EF4:
	mov r0, #4
	lsl r1, r0, #0xa
	bl CreateDrawFadeTask
	mov r0, #0xc
	bl FadeSysTrack
	ldr r0, _02164F0C // =VSLobbyMenu__Main_2164D50
	bl SetCurrentTaskMainEvent
_02164F08:
	pop {r4, pc}
	nop
_02164F0C: .word VSLobbyMenu__Main_2164D50
	thumb_func_end VSLobbyMenu__Main_2164EB4

	thumb_func_start VSLobbyMenu__Main2
VSLobbyMenu__Main2: // 0x02164F10
	push {r4, lr}
	ldr r0, _02164F34 // =VSLobbyMenu__sVars
	ldr r4, [r0, #8]
	bl MultibootManager__GetField8
	cmp r0, #0x18
	beq _02164F32
	bl MultibootManager__Func_2061A24
	cmp r0, #0
	beq _02164F32
	mov r0, #0xe3
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0x10
	bl MultibootManager__Func_2061A98
_02164F32:
	pop {r4, pc}
	.align 2, 0
_02164F34: .word VSLobbyMenu__sVars
	thumb_func_end VSLobbyMenu__Main2

	.rodata

.public ovl03_0217DE80
ovl03_0217DE80: // 0x0217DE80
    .byte 39, 40, 41, 42

.public ovl03_0217DE84
ovl03_0217DE84: // 0x0217DE84
    .byte 0, 1, 4, 5, 7, 8, 11, 12, 14, 15, 17, 18, 21, 22, 43, 44, 45
	
	.align 4

.public ovl03_0217DE98
ovl03_0217DE98: // 0x0217DE98
    .hword 1
	.hword 0
	.hword 0x50
	.hword 0x64
	.byte  1
	.byte  1
	.byte  3
	.byte  0

	.hword 1
	.hword 1
	.hword 0xB0
	.hword 0x64
	.byte  2
	.byte  1
	.byte  3
	.byte  0

	.hword 1
	.hword 2
	.hword 0
	.hword 0
	.byte  3
	.byte  1
	.byte  2
	.byte  0

	.hword 1
	.hword 3
	.hword 0
	.hword 0
	.byte  4
	.byte  1
	.byte  4
	.byte  0

	.hword 2
	.hword 0
	.hword 0x28
	.hword 0x88
	.byte  5
	.byte  1
	.byte  1
	.byte  0

	.hword 2
	.hword 3
	.hword 0x88
	.hword 0x88
	.byte  6
	.byte  1
	.byte  1
	.byte  0

	.hword 2
	.hword 6
	.hword 0x80
	.hword 0x34
	.byte  7
	.byte  1
	.byte  0
	.byte  0

	.hword 0xFFFF
	.hword 0
	.hword 0
	.hword 0
	.byte  8
	.byte  1
	.byte  0
	.byte  0

.public ovl03_0217DEF8
ovl03_0217DEF8: // 0x0217DEF8
    .hword 1
	.hword 0
	.word  0
	.hword 0
	.hword 0
	.byte  0xF
	.byte  0
	.byte  0
	.byte  0
	
	.hword 1
	.hword 1
	.word  0
	.hword 0
	.hword 0
	.byte  0xE
	.byte  0
	.byte  2
	.byte  0
	
	.hword 2
	.hword 0
	.word  0
	.hword 0x18
	.hword 6
	.byte  0xD
	.byte  0
	.byte  1
	.byte  0
	
	.hword 5
	.hword 12
	.word  1
	.hword 4
	.hword 1
	.byte  0xF
	.byte  1
	.byte  0
	.byte  0
	
	.hword 5
	.hword 11
	.word  1
	.hword 0xCA
	.hword 0x14
	.byte  0xE
	.byte  1
	.byte  1
	.byte  0
	
	.hword 5
	.hword 0
	.word  1
	.hword 0x18
	.hword 1
	.byte  0xD
	.byte  1
	.byte  0
	.byte  0
	
	.hword 5
	.hword 0
	.word  1
	.hword 0x12
	.hword 1
	.byte  0xD
	.byte  1
	.byte  0
	.byte  0

	.data

aNarcDmvsCmnNar_0: // 0x0217ECA4
	.asciz "/narc/dmvs_cmn.narc"
	.align 4
	
aDmvsTitleBac_0: // 0x0217ECB8
	.asciz "/dmvs_title.bac"
	.align 4
	
aDmvsCursorBac_0: // 0x0217ECC8
	.asciz "dmvs_cursor.bac"
	.align 4
	
aDmvsTimeBac_0: // 0x0217ECD8
	.asciz "dmvs_time.bac"
	.align 4
	
aDmvsBtnBac: // 0x0217ECE8
	.asciz "/dmvs_btn.bac"
	.align 4
	
aFntFontIplFnt_2: // 0x0217ECF8
	.asciz "/fnt/font_ipl.fnt"
	.align 4