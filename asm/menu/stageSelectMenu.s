	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public StageSelectMenu__Singleton
StageSelectMenu__Singleton: // 0x0217EFCC
	.space 0x04 // Task*

	.text

	thumb_func_start StageSelectMenu__LoadAssets
StageSelectMenu__LoadAssets: // 0x0215D944
	push {r4, lr}
	mov r0, #0xa0
	bl _AllocHeadHEAP_SYSTEM
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0xa0
	bl MIi_CpuClear16
	mov r1, #0
	ldr r0, _0215D988 // =aBbDmasBb
	mov r2, r1
	bl ReadFileFromBundle
	str r0, [r4]
	ldr r0, _0215D98C // =aBbNlBb_1
	mov r1, #1
	mov r2, #0
	bl ReadFileFromBundle
	str r0, [r4, #4]
	mov r0, r4
	add r0, #8
	bl FontFile__Init
	mov r0, r4
	ldr r1, _0215D990 // =aFntFontIplFnt_ovl03
	add r0, #8
	mov r2, #1
	bl FontFile__InitFromPath
	mov r0, r4
	pop {r4, pc}
	.align 2, 0
_0215D988: .word aBbDmasBb
_0215D98C: .word aBbNlBb_1
_0215D990: .word aFntFontIplFnt_ovl03
	thumb_func_end StageSelectMenu__LoadAssets

	thumb_func_start StageSelectMenu__ReleaseAssets
StageSelectMenu__ReleaseAssets: // 0x0215D994
	push {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	add r0, #8
	bl FontFile__Release
	mov r5, r7
	mov r0, #8
	beq _0215D9B6
	mov r4, r7
	mov r6, #0
	add r4, #8
_0215D9AA:
	ldr r0, [r5, #0]
	bl _FreeHEAP_USER
	stmia r5!, {r6}
	cmp r5, r4
	bne _0215D9AA
_0215D9B6:
	mov r0, r7
	bl _FreeHEAP_SYSTEM
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
	thumb_func_end StageSelectMenu__ReleaseAssets

	thumb_func_start StageSelectMenu__Create
StageSelectMenu__Create: // 0x0215D9C0
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r5, r0
	ldr r0, _0215DA20 // =0x00003002
	mov r7, r2
	str r0, [sp]
	mov r2, #0
	mov r6, r1
	ldr r0, _0215DA24 // =0x00001404
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215DA28 // =StageSelectMenu__Main
	ldr r1, _0215DA2C // =StageSelectMenu__Destructor
	mov r3, r2
	bl TaskCreate_
	ldr r1, _0215DA30 // =StageSelectMenu__Singleton
	mov r2, #0
	str r0, [r1]
	mov r0, r5
	add r0, #0x94
	str r2, [r0]
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _0215DA24 // =0x00001404
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	ldr r1, _0215DA34 // =0x000013D0
	str r5, [r4]
	str r6, [r4, r1]
	add r0, r1, #4
	strh r7, [r4, r0]
	mov r0, #1
	add r1, #0xc
	str r0, [r4, r1]
	mov r0, r4
	bl StageSelectMenu__Func_215E14C
	ldr r0, _0215DA38 // =gameState
	ldrh r1, [r0, #0x28]
	ldr r0, _0215DA3C // =0x000013E0
	str r1, [r4, r0]
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_0215DA20: .word 0x00003002
_0215DA24: .word 0x00001404
_0215DA28: .word StageSelectMenu__Main
_0215DA2C: .word StageSelectMenu__Destructor
_0215DA30: .word StageSelectMenu__Singleton
_0215DA34: .word 0x000013D0
_0215DA38: .word gameState
_0215DA3C: .word 0x000013E0
	thumb_func_end StageSelectMenu__Create

	thumb_func_start StageSelectMenu__Func_215DA40
StageSelectMenu__Func_215DA40: // 0x0215DA40
	push {r3, lr}
	bl StageSelectMenu__Func_215DA54
	cmp r0, #0
	beq _0215DA4E
	mov r0, #1
	pop {r3, pc}
_0215DA4E:
	mov r0, #0
	pop {r3, pc}
	.align 2, 0
	thumb_func_end StageSelectMenu__Func_215DA40

	thumb_func_start StageSelectMenu__Func_215DA54
StageSelectMenu__Func_215DA54: // 0x0215DA54
	add r0, #0x94
	ldr r0, [r0, #0]
	bx lr
	.align 2, 0
	thumb_func_end StageSelectMenu__Func_215DA54

	thumb_func_start StageSelectMenu__Func_215DA5C
StageSelectMenu__Func_215DA5C: // 0x0215DA5C
	mov r3, r0
	add r3, #0x98
	str r1, [r3]
	add r0, #0x9c
	str r2, [r0]
	bx lr
	thumb_func_end StageSelectMenu__Func_215DA5C

	thumb_func_start StageSelectMenu__Func_215DA68
StageSelectMenu__Func_215DA68: // 0x0215DA68
	push {r3, lr}
	ldr r0, _0215DA84 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215DA88 // =0x000013DC
	ldr r2, [r0, r1]
	cmp r2, #0
	beq _0215DA7E
	mov r0, #0x2e
	pop {r3, pc}
_0215DA7E:
	add r1, r1, #4
	ldr r0, [r0, r1]
	pop {r3, pc}
	.align 2, 0
_0215DA84: .word StageSelectMenu__Singleton
_0215DA88: .word 0x000013DC
	thumb_func_end StageSelectMenu__Func_215DA68

	thumb_func_start StageSelectMenu__Destructor
StageSelectMenu__Destructor: // 0x0215DA8C
	push {r4, r5, r6, lr}
	bl GetTaskWork_
	mov r6, r0
	ldr r0, _0215DB20 // =0x000013D4
	ldrh r1, [r6, r0]
	mov r0, #0x80
	tst r0, r1
	beq _0215DAA4
	add r0, r6, #4
	bl TimeAttackRankList__Destroy
_0215DAA4:
	ldr r0, _0215DB24 // =0x000005C8
	add r5, r6, r0
	mov r0, #0x9b
	lsl r0, r0, #4
	add r4, r6, r0
	cmp r5, r4
	beq _0215DABE
_0215DAB2:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _0215DAB2
_0215DABE:
	mov r0, #0x9b
	lsl r0, r0, #4
	add r5, r6, r0
	ldr r0, _0215DB28 // =0x00000D98
	add r4, r6, r0
	cmp r5, r4
	beq _0215DAD8
_0215DACC:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _0215DACC
_0215DAD8:
	ldr r0, _0215DB28 // =0x00000D98
	add r5, r6, r0
	ldr r0, _0215DB2C // =0x00000F8C
	add r4, r6, r0
	cmp r5, r4
	beq _0215DAF0
_0215DAE4:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _0215DAE4
_0215DAF0:
	ldr r0, _0215DB30 // =0x00000FA4
	add r5, r6, r0
	ldr r0, _0215DB34 // =0x000013C4
	add r4, r6, r0
	cmp r5, r4
	beq _0215DB0A
_0215DAFC:
	mov r0, r5
	add r0, #0x38
	bl AnimatorSprite__Release
	add r5, #0xb0
	cmp r5, r4
	bne _0215DAFC
_0215DB0A:
	ldr r0, _0215DB38 // =0x000013E0
	ldr r0, [r6, r0]
	bl StageSelectMenu__Func_215E2A0
	ldr r1, _0215DB3C // =gameState
	strh r0, [r1, #0x28]
	ldr r0, _0215DB40 // =StageSelectMenu__Singleton
	mov r1, #0
	str r1, [r0]
	pop {r4, r5, r6, pc}
	nop
_0215DB20: .word 0x000013D4
_0215DB24: .word 0x000005C8
_0215DB28: .word 0x00000D98
_0215DB2C: .word 0x00000F8C
_0215DB30: .word 0x00000FA4
_0215DB34: .word 0x000013C4
_0215DB38: .word 0x000013E0
_0215DB3C: .word gameState
_0215DB40: .word StageSelectMenu__Singleton
	thumb_func_end StageSelectMenu__Destructor

	thumb_func_start StageSelectMenu__Func_215DB44
StageSelectMenu__Func_215DB44: // 0x0215DB44
	push {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r0, _0215DBFC // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r5, r0
	ldr r0, _0215DC00 // =0x000013E0
	ldr r0, [r5, r0]
	bl StageSelectMenu__Func_215DDC4
	ldr r1, _0215DC04 // =0x00000FA4
	add r4, r5, r1
	add r1, r0, #2
	mov r6, r1
	mov r0, #0xb0
	mul r6, r0
	mov r0, #1
	ldr r1, _0215DC08 // =0x000013DC
	cmp r7, #1
	str r0, [r5, r1]
	beq _0215DB76
	cmp r7, #2
	beq _0215DBAE
	b _0215DBF4
_0215DB76:
	mov r0, #0
	bl PlaySysMenuNavSfx
	add r1, r4, r6
	add r1, #0xa4
	add r0, r4, r6
	ldrh r1, [r1, #0]
	add r0, #0x38
	bl AnimatorSprite__SetAnimation
	ldr r2, [r5, #0]
	mov r0, r2
	add r0, #0x98
	ldr r3, [r0, #0]
	cmp r3, #0
	beq _0215DBA0
	add r2, #0x9c
	mov r0, #0
	ldr r2, [r2, #0]
	mov r1, r0
	blx r3
_0215DBA0:
	ldr r0, _0215DC0C // =0x000013C8
	mov r1, #1
	str r1, [r5, r0]
	mov r1, #0x10
	add r0, r0, #4
	str r1, [r5, r0]
	b _0215DBF4
_0215DBAE:
	bl PlaySysMenuNavSfx
	add r1, r4, r6
	add r1, #0xa0
	add r0, r4, r6
	ldrh r1, [r1, #0]
	add r0, #0x38
	bl AnimatorSprite__SetAnimation
	ldr r2, [r5, #0]
	mov r0, r2
	add r0, #0x98
	ldr r3, [r0, #0]
	cmp r3, #0
	beq _0215DBD6
	add r2, #0x9c
	ldr r2, [r2, #0]
	mov r0, #1
	mov r1, #0
	blx r3
_0215DBD6:
	ldr r0, _0215DC10 // =0x00000794
	mov r1, #1
	ldr r2, [r5, r0]
	orr r2, r1
	str r2, [r5, r0]
	ldr r0, _0215DC14 // =0x00001018
	ldr r2, [r5, r0]
	orr r1, r2
	str r1, [r5, r0]
	ldr r0, _0215DC0C // =0x000013C8
	mov r1, #2
	str r1, [r5, r0]
	mov r1, #0
	add r0, r0, #4
	str r1, [r5, r0]
_0215DBF4:
	ldr r0, _0215DC18 // =StageSelectMenu__Func_215F490
	bl SetCurrentTaskMainEvent
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215DBFC: .word StageSelectMenu__Singleton
_0215DC00: .word 0x000013E0
_0215DC04: .word 0x00000FA4
_0215DC08: .word 0x000013DC
_0215DC0C: .word 0x000013C8
_0215DC10: .word 0x00000794
_0215DC14: .word 0x00001018
_0215DC18: .word StageSelectMenu__Func_215F490
	thumb_func_end StageSelectMenu__Func_215DB44

	thumb_func_start StageSelectMenu__TouchAreaFunc_215DC1C
StageSelectMenu__TouchAreaFunc_215DC1C: // 0x0215DC1C
	push {r4, lr}
	mov r4, r2
	ldr r2, [r1, #0x14]
	ldr r1, [r0, #0]
	mov r0, #2
	lsl r0, r0, #0x14
	cmp r1, r0
	bne _0215DC56
	lsr r0, r0, #0xa
	tst r0, r2
	bne _0215DC56
	ldr r0, _0215DC58 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215DC5C // =0x000013E0
	ldr r0, [r0, r1]
	lsl r1, r4, #0x10
	asr r1, r1, #0x10
	bl StageSelectMenu__Func_215DE28
	mov r1, #0
	bl StageSelectMenu__Func_215E084
	mov r0, #2
	bl PlaySysMenuNavSfx
	bl StageSelectMenu__Func_215E324
_0215DC56:
	pop {r4, pc}
	.align 2, 0
_0215DC58: .word StageSelectMenu__Singleton
_0215DC5C: .word 0x000013E0
	thumb_func_end StageSelectMenu__TouchAreaFunc_215DC1C

	thumb_func_start StageSelectMenu__Func_215DC60
StageSelectMenu__Func_215DC60: // 0x0215DC60
	push {r4, lr}
	ldr r1, [r0, #0]
	mov r0, #1
	lsl r0, r0, #0x16
	mov r4, r2
	cmp r1, r0
	bne _0215DC92
	ldr r0, _0215DC94 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215DC98 // =0x000013E0
	ldr r0, [r0, r1]
	lsl r1, r4, #0x10
	lsr r1, r1, #0x10
	bl StageSelectMenu__Func_215DDD4
	mov r1, #1
	bl StageSelectMenu__Func_215E084
	mov r0, #2
	bl PlaySysMenuNavSfx
	bl StageSelectMenu__Func_215E324
_0215DC92:
	pop {r4, pc}
	.align 2, 0
_0215DC94: .word StageSelectMenu__Singleton
_0215DC98: .word 0x000013E0
	thumb_func_end StageSelectMenu__Func_215DC60

	thumb_func_start StageSelectMenu__Func_215DC9C
StageSelectMenu__Func_215DC9C: // 0x0215DC9C
	push {r3, lr}
	mov r1, r0
	add r1, #0xa4
	ldrh r1, [r1, #0]
	add r0, #0x38
	bl AnimatorSprite__SetAnimation
	mov r0, #1
	bl StageSelectMenu__Func_215DB44
	pop {r3, pc}
	.align 2, 0
	thumb_func_end StageSelectMenu__Func_215DC9C

	thumb_func_start StageSelectMenu__Func_215DCB4
StageSelectMenu__Func_215DCB4: // 0x0215DCB4
	push {r3, lr}
	mov r1, r0
	add r1, #0xa4
	ldrh r1, [r1, #0]
	add r0, #0x38
	bl AnimatorSprite__SetAnimation
	mov r0, #2
	bl StageSelectMenu__Func_215DB44
	pop {r3, pc}
	.align 2, 0
	thumb_func_end StageSelectMenu__Func_215DCB4

	thumb_func_start Task__OVL03Unknown215DCCC__Create
Task__OVL03Unknown215DCCC__Create: // 0x0215DCCC
	push {r4, r5, lr}
	sub sp, #0xc
	mov r5, r0
	ldr r0, _0215DD4C // =0x00003043
	mov r2, #0
	str r0, [sp]
	str r2, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	ldr r0, _0215DD50 // =Task__OVL03Unknown215DCCC__Main
	ldr r1, _0215DD54 // =Task__OVL03Unknown215DCCC__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0xc
	bl MIi_CpuClear16
	mov r2, #0
	str r2, [r4]
	ldr r0, _0215DD58 // =VRAMSystem__GFXControl
	lsl r1, r5, #2
	ldr r1, [r0, r1]
	str r5, [r4, #8]
	strh r2, [r1, #0x20]
	ldr r1, [r4, #8]
	lsl r1, r1, #2
	ldr r3, [r0, r1]
	mov r1, #1
	ldrh r2, [r3, #0x20]
	lsl r1, r1, #0xa
	orr r1, r2
	strh r1, [r3, #0x20]
	ldr r1, [r4, #8]
	lsl r1, r1, #2
	ldr r3, [r0, r1]
	mov r1, #0xc0
	ldrh r2, [r3, #0x20]
	bic r2, r1
	mov r1, #0x40
	orr r1, r2
	strh r1, [r3, #0x20]
	ldr r1, [r4, #8]
	lsl r1, r1, #2
	ldr r3, [r0, r1]
	mov r1, #0x1f
	ldrh r2, [r3, #0x22]
	bic r2, r1
	mov r1, #0x10
	orr r1, r2
	strh r1, [r3, #0x22]
	ldr r1, [r4, #8]
	lsl r1, r1, #2
	ldr r2, [r0, r1]
	ldr r0, _0215DD5C // =0xFFFFE0FF
	ldrh r1, [r2, #0x22]
	and r0, r1
	strh r0, [r2, #0x22]
	add sp, #0xc
	pop {r4, r5, pc}
	.align 2, 0
_0215DD4C: .word 0x00003043
_0215DD50: .word Task__OVL03Unknown215DCCC__Main
_0215DD54: .word Task__OVL03Unknown215DCCC__Destructor
_0215DD58: .word VRAMSystem__GFXControl
_0215DD5C: .word 0xFFFFE0FF
	thumb_func_end Task__OVL03Unknown215DCCC__Create

	thumb_func_start Task__OVL03Unknown215DCCC__Destructor
Task__OVL03Unknown215DCCC__Destructor: // 0x0215DD60
	push {r3, lr}
	bl GetTaskWork_
	ldr r1, [r0, #8]
	ldr r2, _0215DD80 // =VRAMSystem__GFXControl
	lsl r1, r1, #2
	ldr r1, [r2, r1]
	mov r3, #0
	strh r3, [r1, #0x20]
	ldr r0, [r0, #8]
	lsl r0, r0, #2
	ldr r1, [r2, r0]
	ldrh r0, [r1, #0x20]
	strh r0, [r1, #0x22]
	pop {r3, pc}
	nop
_0215DD80: .word VRAMSystem__GFXControl
	thumb_func_end Task__OVL03Unknown215DCCC__Destructor

	thumb_func_start StageSelectMenu__Func_215DD84
StageSelectMenu__Func_215DD84: // 0x0215DD84
	push {r4, lr}
	mov r4, r0
	ldr r0, _0215DD98 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r1, r4, r0
	ldr r0, _0215DD9C // =0x000013E3
	ldrb r0, [r1, r0]
	pop {r4, pc}
	.align 2, 0
_0215DD98: .word StageSelectMenu__Singleton
_0215DD9C: .word 0x000013E3
	thumb_func_end StageSelectMenu__Func_215DD84

	thumb_func_start StageSelectMenu__Func_215DDA0
StageSelectMenu__Func_215DDA0: // 0x0215DDA0
	sub r0, r0, #1
	lsl r2, r0, #3
	ldr r0, _0215DDB0 // =0x0217DC62
	lsl r1, r1, #1
	add r0, r0, r2
	ldrh r0, [r1, r0]
	bx lr
	nop
_0215DDB0: .word 0x0217DC62
	thumb_func_end StageSelectMenu__Func_215DDA0

	thumb_func_start StageSelectMenu__Func_215DDB4
StageSelectMenu__Func_215DDB4: // 0x0215DDB4
	lsl r1, r0, #1
	add r1, r0, r1
	ldr r0, _0215DDC0 // =0x0217DBD8
	ldrb r0, [r0, r1]
	bx lr
	nop
_0215DDC0: .word 0x0217DBD8
	thumb_func_end StageSelectMenu__Func_215DDB4

	thumb_func_start StageSelectMenu__Func_215DDC4
StageSelectMenu__Func_215DDC4: // 0x0215DDC4
	lsl r1, r0, #1
	add r1, r0, r1
	ldr r0, _0215DDD0 // =0x0217DBD9
	ldrb r0, [r0, r1]
	bx lr
	nop
_0215DDD0: .word 0x0217DBD9
	thumb_func_end StageSelectMenu__Func_215DDC4

	thumb_func_start StageSelectMenu__Func_215DDD4
StageSelectMenu__Func_215DDD4: // 0x0215DDD4
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r1
	lsl r1, r0, #1
	add r1, r0, r1
	ldr r0, _0215DE18 // =0x0217DBD8
	ldrb r4, [r0, r1]
	ldr r0, _0215DE1C // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r1, r4, r0
	ldr r0, _0215DE20 // =0x000013E3
	ldrb r0, [r1, r0]
	cmp r5, r0
	ble _0215DE0A
	ldr r6, _0215DE1C // =StageSelectMenu__Singleton
	ldr r7, _0215DE20 // =0x000013E3
_0215DDF6:
	sub r0, r5, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	ldr r0, [r6, #0]
	bl GetTaskWork_
	add r0, r4, r0
	ldrb r0, [r0, r7]
	cmp r5, r0
	bgt _0215DDF6
_0215DE0A:
	ldr r0, _0215DE24 // =0x0217DC5A
	lsl r2, r4, #3
	lsl r1, r5, #1
	add r0, r0, r2
	ldrh r0, [r1, r0]
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0215DE18: .word 0x0217DBD8
_0215DE1C: .word StageSelectMenu__Singleton
_0215DE20: .word 0x000013E3
_0215DE24: .word 0x0217DC5A
	thumb_func_end StageSelectMenu__Func_215DDD4

	thumb_func_start StageSelectMenu__Func_215DE28
StageSelectMenu__Func_215DE28: // 0x0215DE28
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r1
	lsl r1, r0, #1
	add r1, r0, r1
	ldr r0, _0215DEA0 // =0x0217DBD8
	ldr r7, _0215DEA4 // =StageSelectMenu__Singleton
	ldrb r4, [r0, r1]
	ldr r0, _0215DEA8 // =0x0217DBD9
	ldrb r6, [r0, r1]
_0215DE3A:
	add r4, r4, r5
	cmp r4, #0
	bgt _0215DE46
_0215DE40:
	add r4, #0x1c
	cmp r4, #0
	ble _0215DE40
_0215DE46:
	cmp r4, #0x1d
	blt _0215DE50
_0215DE4A:
	sub r4, #0x1c
	cmp r4, #0x1d
	bge _0215DE4A
_0215DE50:
	cmp r5, #0
	ble _0215DE58
	mov r5, #1
	b _0215DE5C
_0215DE58:
	mov r5, #0
	mvn r5, r5
_0215DE5C:
	ldr r0, [r7, #0]
	bl GetTaskWork_
	add r1, r4, r0
	ldr r0, _0215DEAC // =0x000013E3
	ldrb r0, [r1, r0]
	cmp r0, #0
	beq _0215DE3A
	ldr r0, _0215DEA4 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r1, r4, r0
	ldr r0, _0215DEAC // =0x000013E3
	ldrb r0, [r1, r0]
	cmp r6, r0
	ble _0215DE92
	ldr r5, _0215DEA4 // =StageSelectMenu__Singleton
	ldr r7, _0215DEAC // =0x000013E3
_0215DE82:
	ldr r0, [r5, #0]
	sub r6, r6, #1
	bl GetTaskWork_
	add r0, r4, r0
	ldrb r0, [r0, r7]
	cmp r6, r0
	bgt _0215DE82
_0215DE92:
	ldr r0, _0215DEB0 // =0x0217DC5A
	lsl r2, r4, #3
	lsl r1, r6, #1
	add r0, r0, r2
	ldrh r0, [r1, r0]
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0215DEA0: .word 0x0217DBD8
_0215DEA4: .word StageSelectMenu__Singleton
_0215DEA8: .word 0x0217DBD9
_0215DEAC: .word 0x000013E3
_0215DEB0: .word 0x0217DC5A
	thumb_func_end StageSelectMenu__Func_215DE28

	thumb_func_start StageSelectMenu__Func_215DEB4
StageSelectMenu__Func_215DEB4: // 0x0215DEB4
	push {r3, r4, r5, r6, r7, lr}
	lsl r2, r0, #1
	add r2, r0, r2
	ldr r0, _0215DF10 // =0x0217DBD8
	ldrb r4, [r0, r2]
	ldr r0, _0215DF14 // =0x0217DBD9
	ldrb r0, [r0, r2]
	add r5, r1, r0
	mov r0, r4
	bl StageSelectMenu__Func_215DD84
	cmp r5, #0
	bgt _0215DED4
_0215DECE:
	add r5, r5, r0
	cmp r5, #0
	ble _0215DECE
_0215DED4:
	cmp r5, r0
	ble _0215DEDE
_0215DED8:
	sub r5, r5, r0
	cmp r5, r0
	bgt _0215DED8
_0215DEDE:
	ldr r0, _0215DF18 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r1, r4, r0
	ldr r0, _0215DF1C // =0x000013E3
	ldrb r0, [r1, r0]
	cmp r5, r0
	ble _0215DF04
	ldr r6, _0215DF18 // =StageSelectMenu__Singleton
	ldr r7, _0215DF1C // =0x000013E3
_0215DEF4:
	ldr r0, [r6, #0]
	sub r5, r5, #1
	bl GetTaskWork_
	add r0, r4, r0
	ldrb r0, [r0, r7]
	cmp r5, r0
	bgt _0215DEF4
_0215DF04:
	ldr r0, _0215DF20 // =0x0217DC5A
	lsl r2, r4, #3
	lsl r1, r5, #1
	add r0, r0, r2
	ldrh r0, [r1, r0]
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215DF10: .word 0x0217DBD8
_0215DF14: .word 0x0217DBD9
_0215DF18: .word StageSelectMenu__Singleton
_0215DF1C: .word 0x000013E3
_0215DF20: .word 0x0217DC5A
	thumb_func_end StageSelectMenu__Func_215DEB4

	thumb_func_start ovl03_215DF24
ovl03_215DF24: // 0x0215DF24
	push {r3, r4, r5, lr}
	sub sp, #8
	mov r5, r1
	mov r1, r0
	mov r4, r2
	mov r2, #0
	add r1, #0x9c
	str r2, [r1]
	mov r1, r0
	add r1, #0xac
	str r3, [r1]
	mov r1, r0
	ldr r2, [sp, #0x18]
	add r1, #0xa8
	str r2, [r1]
	ldr r1, _0215DF5C // =StageSelectMenu__Func_215DF84
	mov r2, r5
	str r1, [sp]
	ldr r1, [sp, #0x1c]
	mov r3, r4
	str r1, [sp, #4]
	mov r1, r0
	add r1, #0x38
	bl TouchField__InitAreaSprite
	add sp, #8
	pop {r3, r4, r5, pc}
	nop
_0215DF5C: .word StageSelectMenu__Func_215DF84
	thumb_func_end ovl03_215DF24

	thumb_func_start StageSelectMenu__ConfigureButton
StageSelectMenu__ConfigureButton: // 0x0215DF60
	push {r3, r4, r5, lr}
	mov r4, r0
	mov r5, #1
	add r4, #0x9c
	str r5, [r4]
	mov r4, r0
	add r4, #0xa0
	strh r1, [r4]
	mov r4, r0
	add r4, #0xa2
	strh r2, [r4]
	mov r2, r0
	add r2, #0xa4
	add r0, #0x38
	strh r3, [r2]
	bl AnimatorSprite__SetAnimation
	pop {r3, r4, r5, pc}
	thumb_func_end StageSelectMenu__ConfigureButton

	thumb_func_start StageSelectMenu__Func_215DF84
StageSelectMenu__Func_215DF84: // 0x0215DF84
	push {r4, r5, r6, lr}
	mov r5, r0
	mov r4, r1
	mov r0, #1
	mov r6, r2
	ldr r1, [r5, #0]
	lsl r0, r0, #0x10
	ldr r2, [r4, #0x14]
	cmp r1, r0
	beq _0215DFA6
	lsl r3, r0, #1
	cmp r1, r3
	beq _0215DFCE
	lsl r0, r0, #8
	cmp r1, r0
	beq _0215DFEE
	b _0215E00C
_0215DFA6:
	mov r1, r4
	add r1, #0x9c
	ldr r1, [r1, #0]
	cmp r1, #0
	beq _0215E00C
	beq _0215E00C
	lsr r0, r0, #5
	tst r0, r2
	bne _0215E00C
	mov r1, r4
	add r1, #0xa2
	ldrh r1, [r1, #0]
	mov r0, r4
	add r0, #0x38
	bl AnimatorSprite__SetAnimation
	mov r0, #2
	bl PlaySysMenuNavSfx
	b _0215E00C
_0215DFCE:
	mov r1, r4
	add r1, #0x9c
	ldr r1, [r1, #0]
	cmp r1, #0
	beq _0215E00C
	lsr r0, r0, #5
	tst r0, r2
	bne _0215E00C
	mov r1, r4
	add r1, #0xa0
	ldrh r1, [r1, #0]
	mov r0, r4
	add r0, #0x38
	bl AnimatorSprite__SetAnimation
	b _0215E00C
_0215DFEE:
	mov r0, #0x20
	mov r1, r2
	tst r1, r0
	beq _0215E00C
	lsl r0, r0, #6
	tst r0, r2
	bne _0215E00C
	mov r0, r4
	add r0, #0xac
	ldr r2, [r0, #0]
	cmp r2, #0
	beq _0215E00C
	mov r0, r4
	mov r1, r6
	blx r2
_0215E00C:
	mov r0, r4
	add r0, #0xa8
	ldr r3, [r0, #0]
	cmp r3, #0
	beq _0215E01E
	mov r0, r5
	mov r1, r4
	mov r2, r6
	blx r3
_0215E01E:
	pop {r4, r5, r6, pc}
	thumb_func_end StageSelectMenu__Func_215DF84

	thumb_func_start StageSelectMover__Create
StageSelectMover__Create: // 0x0215E020
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x10
	mov r5, r0
	str r3, [sp, #0xc]
	add r0, sp, #0x18
	ldrh r0, [r0, #0x20]
	mov r6, r1
	mov r1, #0
	str r0, [sp]
	add r0, sp, #0x3c
	ldrb r0, [r0, #0]
	mov r7, r2
	mov r2, r1
	str r0, [sp, #4]
	mov r0, #0x20
	str r0, [sp, #8]
	ldr r0, _0215E080 // =StageSelectMover__Main
	mov r3, r1
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x20
	bl MIi_CpuClear16
	str r5, [r4]
	ldr r0, [sp, #0xc]
	strh r0, [r4, #4]
	ldr r0, [sp, #0x28]
	lsl r0, r0, #0xc
	str r0, [r4, #8]
	ldr r0, [sp, #0x2c]
	lsl r0, r0, #0xc
	str r0, [r4, #0xc]
	ldr r0, [sp, #0x30]
	lsl r0, r0, #0xc
	str r0, [r4, #0x10]
	ldr r0, [sp, #0x34]
	lsl r0, r0, #0xc
	str r0, [r4, #0x14]
	strh r6, [r4, #0x18]
	strh r7, [r4, #0x1c]
	add sp, #0x10
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0215E080: .word StageSelectMover__Main
	thumb_func_end StageSelectMover__Create

	thumb_func_start StageSelectMenu__Func_215E084
StageSelectMenu__Func_215E084: // 0x0215E084
	push {r4, r5, r6, lr}
	mov r5, r0
	ldr r0, _0215E0F4 // =StageSelectMenu__Singleton
	mov r6, r1
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mvn r0, r0
	cmp r5, r0
	beq _0215E0C6
	ldr r0, _0215E0F8 // =0x000013E0
	ldr r0, [r4, r0]
	bl StageSelectMenu__Func_215DDC4
	add r2, r0, #2
	ldr r1, _0215E0FC // =0x00000FA4
	mov r0, #0xb0
	mov r3, r2
	add r1, r4, r1
	mul r3, r0
	add r0, r1, r3
	add r1, r1, r3
	add r1, #0xa0
	ldrh r1, [r1, #0]
	add r0, #0x38
	bl AnimatorSprite__SetAnimation
	lsl r0, r5, #0x10
	lsr r1, r0, #0x10
	ldr r0, _0215E0F8 // =0x000013E0
	str r1, [r4, r0]
_0215E0C6:
	ldr r0, _0215E0F8 // =0x000013E0
	ldr r0, [r4, r0]
	bl StageSelectMenu__Func_215DDC4
	ldr r1, _0215E0FC // =0x00000FA4
	add r3, r4, r1
	add r1, r0, #2
	mov r0, #0xb0
	mov r2, r1
	mul r2, r0
	add r1, r3, r2
	add r1, #0xa2
	add r0, r3, r2
	ldrh r1, [r1, #0]
	add r0, #0x38
	bl AnimatorSprite__SetAnimation
	cmp r6, #0
	beq _0215E0F2
	ldr r0, _0215E100 // =0x000013C4
	mov r1, #0
	str r1, [r4, r0]
_0215E0F2:
	pop {r4, r5, r6, pc}
	.align 2, 0
_0215E0F4: .word StageSelectMenu__Singleton
_0215E0F8: .word 0x000013E0
_0215E0FC: .word 0x00000FA4
_0215E100: .word 0x000013C4
	thumb_func_end StageSelectMenu__Func_215E084

	thumb_func_start StageSelectMenu__Func_215E104
StageSelectMenu__Func_215E104: // 0x0215E104
	push {r3, r4, lr}
	sub sp, #4
	mov r4, r0
	ldr r2, [r4, #8]
	str r2, [sp]
	mov r2, #8
	ldrsh r3, [r4, r2]
	mov r2, #0
	ldrsh r2, [r1, r2]
	add r2, r3, r2
	strh r2, [r4, #8]
	mov r2, #0xa
	ldrsh r3, [r4, r2]
	mov r2, #2
	ldrsh r1, [r1, r2]
	add r1, r3, r1
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
	ldr r0, [sp]
	str r0, [r4, #8]
	add sp, #4
	pop {r3, r4, pc}
	.align 2, 0
	thumb_func_end StageSelectMenu__Func_215E104

	thumb_func_start StageSelectMenu__Func_215E134
StageSelectMenu__Func_215E134: // 0x0215E134
	ldr r0, _0215E148 // =padInput
	ldrh r1, [r0, #0]
	mov r0, #3
	tst r0, r1
	beq _0215E142
	mov r0, #1
	bx lr
_0215E142:
	mov r0, #0
	bx lr
	nop
_0215E148: .word padInput
	thumb_func_end StageSelectMenu__Func_215E134

	thumb_func_start StageSelectMenu__Func_215E14C
StageSelectMenu__Func_215E14C: // 0x0215E14C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	ldr r1, _0215E284 // =0x000013D4
	ldr r2, _0215E288 // =0x0217DC6A
	ldrh r1, [r0, r1]
	ldr r4, _0215E28C // =0x000013E3
	str r0, [sp]
	mov r0, #1
_0215E15C:
	mov r3, r2
	sub r3, #8
	ldrh r5, [r3, #0]
	ldr r3, [sp]
	add r2, #8
	add r3, r3, r0
	add r0, r0, #1
	strb r5, [r3, r4]
	cmp r0, #0x1d
	blo _0215E15C
	mov r0, #0x80
	tst r0, r1
	bne _0215E200
	mov r0, #1
	str r0, [sp, #0x10]
	ldr r0, _0215E288 // =0x0217DC6A
	mov r7, #0
	str r0, [sp, #8]
_0215E180:
	ldr r0, _0215E290 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, [sp, #0x10]
	mov r4, #0
	add r1, r1, r0
	ldr r0, _0215E28C // =0x000013E3
	ldrb r6, [r1, r0]
	cmp r6, #0
	bls _0215E1BC
	ldr r5, [sp, #8]
_0215E198:
	sub r0, r5, #6
	ldrh r0, [r0, #0]
	mov r1, r7
	mov r2, r7
	bl MenuHelpers__CheckProgress
	cmp r0, #0
	bne _0215E1B4
	ldr r1, [sp]
	ldr r0, [sp, #0x10]
	add r1, r1, r0
	ldr r0, _0215E28C // =0x000013E3
	strb r4, [r1, r0]
	b _0215E1BC
_0215E1B4:
	add r4, r4, #1
	add r5, r5, #2
	cmp r4, r6
	blo _0215E198
_0215E1BC:
	ldr r0, [sp, #8]
	add r0, #8
	str r0, [sp, #8]
	ldr r0, [sp, #0x10]
	add r0, r0, #1
	str r0, [sp, #0x10]
	cmp r0, #0x1d
	blo _0215E180
	ldr r1, _0215E294 // =0x000013FD
	ldr r0, [sp]
	add r2, r0, r1
	add r1, r1, #3
	add r1, r0, r1
	cmp r2, r1
	beq _0215E1E4
	mov r0, #0
_0215E1DC:
	strb r0, [r2]
	add r2, r2, #1
	cmp r2, r1
	bne _0215E1DC
_0215E1E4:
	mov r0, #0x16
	bl MenuHelpers__Func_217CE80
	mov r1, #0
	mov r2, r1
	bl MenuHelpers__CheckProgress
	cmp r0, #0
	bne _0215E25E
	ldr r1, _0215E298 // =0x000013EC
	ldr r0, [sp]
	mov r2, #0
	strb r2, [r0, r1]
	b _0215E25E
_0215E200:
	mov r0, #1
	str r0, [sp, #4]
	ldr r0, _0215E288 // =0x0217DC6A
	mov r7, #0
	str r0, [sp, #0xc]
_0215E20A:
	ldr r0, _0215E290 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, [sp, #4]
	mov r5, #0
	add r1, r1, r0
	ldr r0, _0215E28C // =0x000013E3
	ldrb r6, [r1, r0]
	cmp r6, #0
	bls _0215E246
	ldr r4, [sp, #0xc]
_0215E222:
	sub r0, r4, #6
	ldrh r0, [r0, #0]
	mov r1, r7
	mov r2, #1
	bl MenuHelpers__CheckProgress
	cmp r0, #0
	bne _0215E23E
	ldr r1, [sp]
	ldr r0, [sp, #4]
	add r1, r1, r0
	ldr r0, _0215E28C // =0x000013E3
	strb r5, [r1, r0]
	b _0215E246
_0215E23E:
	add r5, r5, #1
	add r4, r4, #2
	cmp r5, r6
	blo _0215E222
_0215E246:
	ldr r0, [sp, #0xc]
	add r0, #8
	str r0, [sp, #0xc]
	ldr r0, [sp, #4]
	add r0, r0, #1
	str r0, [sp, #4]
	cmp r0, #0x1d
	blo _0215E20A
	ldr r1, _0215E298 // =0x000013EC
	ldr r0, [sp]
	mov r2, #0
	strb r2, [r0, r1]
_0215E25E:
	ldr r1, _0215E28C // =0x000013E3
	mov r3, #0
	mov r2, #1
_0215E264:
	ldr r0, [sp]
	add r0, r0, r2
	ldrb r0, [r0, r1]
	add r2, r2, #1
	add r3, r3, r0
	cmp r2, #0x1d
	blo _0215E264
	cmp r3, #0
	bne _0215E27E
	ldr r1, _0215E29C // =0x000013E5
	ldr r0, [sp]
	mov r2, #1
	strb r2, [r0, r1]
_0215E27E:
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	nop
_0215E284: .word 0x000013D4
_0215E288: .word 0x0217DC6A
_0215E28C: .word 0x000013E3
_0215E290: .word StageSelectMenu__Singleton
_0215E294: .word 0x000013FD
_0215E298: .word 0x000013EC
_0215E29C: .word 0x000013E5
	thumb_func_end StageSelectMenu__Func_215E14C

	thumb_func_start StageSelectMenu__Func_215E2A0
StageSelectMenu__Func_215E2A0: // 0x0215E2A0
	bx lr
	.align 2, 0
	thumb_func_end StageSelectMenu__Func_215E2A0

	thumb_func_start StageSelectMenu__Func_215E2A4
StageSelectMenu__Func_215E2A4: // 0x0215E2A4
	lsl r1, r0, #1
	add r1, r0, r1
	ldr r0, _0215E2B0 // =0x0217DBDA
	ldr r3, _0215E2B4 // =SaveGame__GetStageScore
	ldrb r0, [r0, r1]
	bx r3
	.align 2, 0
_0215E2B0: .word 0x0217DBDA
_0215E2B4: .word SaveGame__GetStageScore
	thumb_func_end StageSelectMenu__Func_215E2A4

	thumb_func_start StageSelectMenu__Func_215E2B8
StageSelectMenu__Func_215E2B8: // 0x0215E2B8
	push {r3, lr}
	lsl r1, r0, #1
	add r1, r0, r1
	ldr r0, _0215E2F4 // =0x0217DBDA
	ldrb r0, [r0, r1]
	bl SaveGame__GetStageRank
	cmp r0, #3
	bhi _0215E2EE
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0215E2D6: // jump table
	.hword _0215E2DE - _0215E2D6 - 2 // case 0
	.hword _0215E2E2 - _0215E2D6 - 2 // case 1
	.hword _0215E2E6 - _0215E2D6 - 2 // case 2
	.hword _0215E2EA - _0215E2D6 - 2 // case 3
_0215E2DE:
	mov r0, #3
	pop {r3, pc}
_0215E2E2:
	mov r0, #0
	pop {r3, pc}
_0215E2E6:
	mov r0, #1
	pop {r3, pc}
_0215E2EA:
	mov r0, #2
	pop {r3, pc}
_0215E2EE:
	mov r0, #2
	pop {r3, pc}
	nop
_0215E2F4: .word 0x0217DBDA
	thumb_func_end StageSelectMenu__Func_215E2B8

	thumb_func_start StageSelectMenu__Func_215E2F8
StageSelectMenu__Func_215E2F8: // 0x0215E2F8
	push {r3, r4, r5, lr}
	mov r4, r1
	mov r3, r2
	lsl r2, r4, #1
	add r4, r4, r2
	mov r5, r0
	ldr r2, _0215E31C // =0x0217DBDA
	add r3, r3, #1
	lsl r1, r5, #0x18
	lsl r3, r3, #0x18
	ldrb r2, [r2, r4]
	ldr r0, _0215E320 // =saveGame+0x00000898
	lsr r1, r1, #0x18
	lsr r3, r3, #0x18
	bl SaveGame__GetTimeAttackRecord
	pop {r3, r4, r5, pc}
	nop
_0215E31C: .word 0x0217DBDA
_0215E320: .word saveGame+0x00000898
	thumb_func_end StageSelectMenu__Func_215E2F8

	thumb_func_start StageSelectMenu__Func_215E324
StageSelectMenu__Func_215E324: // 0x0215E324
	push {r3, r4, r5, r6, r7, lr}
	ldr r0, _0215E36C // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r5, r0
	ldr r0, _0215E370 // =0x000013D4
	ldr r6, _0215E374 // =gameState
	ldrh r1, [r5, r0]
	mov r0, #0x80
	tst r0, r1
	beq _0215E368
	ldr r7, _0215E378 // =0x000013E0
	mov r4, #0
_0215E340:
	ldr r0, [r6, #4]
	ldr r1, [r5, r7]
	mov r2, r4
	bl StageSelectMenu__Func_215E2F8
	lsl r1, r4, #0x10
	mov r2, r0
	ldr r3, [r6, #4]
	add r0, r5, #4
	lsr r1, r1, #0x10
	bl TimeAttackRankList__SetRecord
	add r4, r4, #1
	cmp r4, #5
	blo _0215E340
	ldr r1, [r5, #0]
	add r0, r5, #4
	add r1, #8
	bl TimeAttackRankList__InitRecords
_0215E368:
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0215E36C: .word StageSelectMenu__Singleton
_0215E370: .word 0x000013D4
_0215E374: .word gameState
_0215E378: .word 0x000013E0
	thumb_func_end StageSelectMenu__Func_215E324

	thumb_func_start StageSelectMenu__Main
StageSelectMenu__Main: // 0x0215E37C
	push {r4, r5, r6, lr}
	ldr r0, _0215E490 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r3, r0
	ldr r0, _0215E494 // =0x000013D0
	ldr r0, [r3, r0]
	cmp r0, #1
	beq _0215E3E2
	ldr r0, _0215E498 // =0x0400000C
	mov r1, #0x43
	ldrh r2, [r0, #0]
	mov r4, #0
	and r2, r1
	ldr r1, _0215E49C // =0x00008604
	orr r2, r1
	strh r2, [r0]
	ldr r2, _0215E4A0 // =renderCoreGFXControlA
	strh r4, [r2, #0xa]
	ldrh r4, [r2, #0xa]
	strh r4, [r2, #8]
	strh r4, [r2, #6]
	strh r4, [r2, #4]
	strh r4, [r2, #2]
	strh r4, [r2]
	sub r2, r0, #2
	ldrh r5, [r2, #0]
	mov r4, #3
	bic r5, r4
	strh r5, [r2]
	sub r5, r0, #4
	ldrh r6, [r5, #0]
	mov r2, #1
	bic r6, r4
	orr r2, r6
	strh r2, [r5]
	ldrh r5, [r0, #0]
	mov r2, #2
	bic r5, r4
	mov r4, r5
	orr r4, r2
	strh r4, [r0]
	lsl r4, r1, #0x18
	ldr r1, [r4, #0]
	ldr r0, _0215E4A4 // =0xFFFFE0FF
	and r1, r0
	lsl r0, r2, #0xa
	orr r0, r1
	str r0, [r4]
	b _0215E432
_0215E3E2:
	ldr r0, _0215E4A8 // =0x0400100C
	mov r1, #0x43
	ldrh r2, [r0, #0]
	and r2, r1
	ldr r1, _0215E49C // =0x00008604
	orr r1, r2
	strh r1, [r0]
	ldr r1, _0215E4AC // =renderCoreGFXControlB
	mov r2, #0
	strh r2, [r1, #0xa]
	ldrh r2, [r1, #0xa]
	strh r2, [r1, #8]
	strh r2, [r1, #6]
	strh r2, [r1, #4]
	strh r2, [r1, #2]
	strh r2, [r1]
	sub r1, r0, #2
	ldrh r4, [r1, #0]
	mov r2, #3
	bic r4, r2
	strh r4, [r1]
	sub r4, r0, #4
	ldrh r5, [r4, #0]
	mov r1, #1
	bic r5, r2
	orr r1, r5
	strh r1, [r4]
	ldrh r4, [r0, #0]
	mov r1, #2
	bic r4, r2
	mov r2, r4
	orr r2, r1
	strh r2, [r0]
	sub r0, #0xc
	ldr r4, [r0, #0]
	ldr r2, _0215E4A4 // =0xFFFFE0FF
	lsl r1, r1, #0xa
	and r2, r4
	orr r1, r2
	str r1, [r0]
_0215E432:
	ldr r0, _0215E494 // =0x000013D0
	ldr r0, [r3, r0]
	cmp r0, #1
	beq _0215E442
	ldr r0, _0215E4A0 // =renderCoreGFXControlA
	ldr r1, _0215E4AC // =renderCoreGFXControlB
	mov r2, #1
	b _0215E448
_0215E442:
	ldr r0, _0215E4AC // =renderCoreGFXControlB
	ldr r1, _0215E4A0 // =renderCoreGFXControlA
	mov r2, #2
_0215E448:
	mov r4, #0x58
	ldrsh r4, [r1, r4]
	lsl r2, r2, #8
	cmp r4, #0
	beq _0215E454
	mov r2, #0
_0215E454:
	ldr r4, _0215E4B0 // =0x000013D4
	ldrh r4, [r3, r4]
	mov r3, #1
	tst r3, r4
	beq _0215E47E
	mov r3, #0x58
	ldrsh r3, [r0, r3]
	cmp r3, #0
	beq _0215E47E
	bge _0215E46C
	mov r0, #2
	b _0215E46E
_0215E46C:
	mov r0, #3
_0215E46E:
	orr r0, r2
	lsl r0, r0, #0x10
	mov r1, #1
	lsr r0, r0, #0x10
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	b _0215E488
_0215E47E:
	mov r2, #0
	add r0, #0x58
	strh r2, [r0]
	add r1, #0x58
	strh r2, [r1]
_0215E488:
	ldr r0, _0215E4B4 // =StageSelectMenu__Main_215E4B8
	bl SetCurrentTaskMainEvent
	pop {r4, r5, r6, pc}
	.align 2, 0
_0215E490: .word StageSelectMenu__Singleton
_0215E494: .word 0x000013D0
_0215E498: .word 0x0400000C
_0215E49C: .word 0x00008604
_0215E4A0: .word renderCoreGFXControlA
_0215E4A4: .word 0xFFFFE0FF
_0215E4A8: .word 0x0400100C
_0215E4AC: .word renderCoreGFXControlB
_0215E4B0: .word 0x000013D4
_0215E4B4: .word StageSelectMenu__Main_215E4B8
	thumb_func_end StageSelectMenu__Main

	thumb_func_start StageSelectMenu__Main_215E4B8
StageSelectMenu__Main_215E4B8: // 0x0215E4B8
	push {r4, r5, lr}
	sub sp, #0x5c
	ldr r0, _0215E5A4 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _0215E5A8 // =0x000005C4
	mov r1, #0
	strh r1, [r4, r0]
	ldr r2, _0215E5AC // =0x000013D8
	mov r3, #1
	str r3, [r4, r2]
	ldr r2, [r4, r2]
	mov r0, #0xc0
	lsl r5, r2, #0xc
	asr r2, r5, #3
	lsr r2, r2, #0x1c
	add r2, r5, r2
	lsl r2, r2, #0xc
	asr r2, r2, #0x10
	lsl r3, r3, #0xc
	bl Task__Unknown204BE48__LerpValue
	ldr r1, _0215E5B0 // =0x000005C6
	strh r0, [r4, r1]
	ldr r0, _0215E5B4 // =0x00000F8C
	add r0, r4, r0
	bl TouchField__Init
	ldr r0, _0215E5B8 // =0x00000F98
	mov r2, #0
	str r2, [r4, r0]
	add r1, r0, #4
	strb r2, [r4, r1]
	add r0, r0, #6
	strb r2, [r4, r0]
	ldr r0, _0215E5BC // =0x000013D4
	ldrh r1, [r4, r0]
	mov r0, #0x80
	tst r0, r1
	beq _0215E510
	mov r1, #2
	b _0215E512
_0215E510:
	mov r1, #1
_0215E512:
	lsl r1, r1, #0x10
	ldr r0, _0215E5C0 // =aBbDmasBb
	lsr r1, r1, #0x10
	mov r2, #0
	bl ReadFileFromBundle
	mov r5, r0
	mov r0, #2
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	ldr r3, _0215E5C4 // =0x000013D0
	add r0, sp, #0x14
	ldr r3, [r4, r3]
	mov r1, r5
	mov r2, #0x38
	bl InitBackground
	add r0, sp, #0x14
	bl DrawBackground
	mov r0, r5
	bl _FreeHEAP_USER
	ldr r2, _0215E5A8 // =0x000005C4
	ldr r3, _0215E5C4 // =0x000013D0
	ldrsh r0, [r4, r2]
	neg r1, r0
	ldr r0, [r4, r3]
	lsl r5, r0, #2
	ldr r0, _0215E5C8 // =VRAMSystem__GFXControl
	ldr r5, [r0, r5]
	strh r1, [r5, #8]
	add r1, r2, #2
	ldrsh r1, [r4, r1]
	neg r2, r1
	ldr r1, [r4, r3]
	lsl r1, r1, #2
	ldr r0, [r0, r1]
	mov r1, #2
	strh r2, [r0, #0xa]
	ldr r4, [r4, r3]
	add r0, sp, #0xc
	add r0, #2
	str r0, [sp]
	mov r0, r4
	add r2, sp, #0x10
	add r3, sp, #0xc
	bl GetVRAMTileConfig
	ldr r1, _0215E5CC // =VRAMSystem__VRAM_BG
	lsl r2, r4, #2
	ldr r1, [r1, r2]
	add r2, sp, #0xc
	ldrh r3, [r2, #0]
	ldrh r2, [r2, #2]
	mov r0, #0
	lsl r3, r3, #0x10
	lsl r2, r2, #0xb
	add r2, r3, r2
	add r1, r1, r2
	mov r2, #2
	lsl r2, r2, #0xa
	add r1, r1, r2
	bl MIi_CpuClear32
	ldr r0, _0215E5D0 // =StageSelectMenu__Main_InitStageSprites
	bl SetCurrentTaskMainEvent
	add sp, #0x5c
	pop {r4, r5, pc}
	.align 2, 0
_0215E5A4: .word StageSelectMenu__Singleton
_0215E5A8: .word 0x000005C4
_0215E5AC: .word 0x000013D8
_0215E5B0: .word 0x000005C6
_0215E5B4: .word 0x00000F8C
_0215E5B8: .word 0x00000F98
_0215E5BC: .word 0x000013D4
_0215E5C0: .word aBbDmasBb
_0215E5C4: .word 0x000013D0
_0215E5C8: .word VRAMSystem__GFXControl
_0215E5CC: .word VRAMSystem__VRAM_BG
_0215E5D0: .word StageSelectMenu__Main_InitStageSprites
	thumb_func_end StageSelectMenu__Main_215E4B8

	thumb_func_start StageSelectMenu__Main_InitStageSprites
StageSelectMenu__Main_InitStageSprites: // 0x0215E5D4
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x20
	ldr r0, _0215E8B4 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r5, r0
	ldr r0, _0215E8B8 // =0x000013E0
	ldr r4, [r5, #0]
	ldr r0, [r5, r0]
	bl StageSelectMenu__Func_215DDB4
	str r0, [sp, #0x1c]
	mov r0, #0x69
	lsl r0, r0, #4
	add r6, r5, r0
	ldr r0, [sp, #0x1c]
	ldr r4, [r4, #0]
	lsl r7, r0, #1
	mov r0, #0x16
	str r0, [sp]
	mov r0, #0x17
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	mov r0, #0x19
	str r0, [sp, #0xc]
	mov r0, #0x1a
	str r0, [sp, #0x10]
	mov r0, #0x1b
	str r0, [sp, #0x14]
	sub r0, #0x1c
	str r0, [sp, #0x18]
	ldr r1, _0215E8BC // =0x000013D0
	mov r0, r4
	ldr r1, [r5, r1]
	mov r2, #0x14
	mov r3, #0x15
	bl StageSelectMenu__Func_215E8EC
	ldr r1, _0215E8BC // =0x000013D0
	ldr r2, _0215E8C0 // =0x0217DB9F
	ldr r1, [r5, r1]
	ldrb r2, [r2, r7]
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #0
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	mov r3, #1
	str r3, [sp, #0x10]
	mov r0, r6
	mov r1, r4
	lsl r3, r3, #0xb
	bl SpriteUnknown__Func_204C90C
	mov r0, #1
	str r0, [r6, #0x58]
	ldr r0, _0215E8C4 // =0x000013D4
	ldrh r1, [r5, r0]
	mov r0, #0x80
	tst r0, r1
	bne _0215E656
	mov r1, #0
	b _0215E658
_0215E656:
	mov r1, #0x18
_0215E658:
	ldr r0, _0215E8C8 // =0x00000698
	strh r1, [r5, r0]
	mov r1, #0
	ldr r0, _0215E8CC // =0x0000069A
	mov r2, r1
	strh r1, [r5, r0]
	mov r0, r6
	bl AnimatorSprite__ProcessAnimation
	ldr r0, _0215E8D0 // =0x000005C8
	ldr r1, _0215E8BC // =0x000013D0
	add r6, r5, r0
	mov r0, #0x28
	str r0, [sp]
	mov r0, #0x29
	str r0, [sp, #4]
	mov r0, #0x2a
	str r0, [sp, #8]
	mov r0, #0x2b
	str r0, [sp, #0xc]
	mov r0, #0x2c
	str r0, [sp, #0x10]
	mov r0, #0x2e
	str r0, [sp, #0x14]
	sub r0, #0x2f
	str r0, [sp, #0x18]
	ldr r1, [r5, r1]
	mov r0, r4
	mov r2, #0x26
	mov r3, #0x27
	bl StageSelectMenu__Func_215E8EC
	ldr r1, _0215E8BC // =0x000013D0
	ldr r2, _0215E8D4 // =0x0217DB9E
	ldr r1, [r5, r1]
	mov r3, #2
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #6
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	ldrb r2, [r2, r7]
	mov r0, r6
	mov r1, r4
	lsl r3, r3, #0xa
	bl SpriteUnknown__Func_204C90C
	mov r1, #1
	mov r2, #0x28
	str r1, [r6, #0x58]
	mov r0, r2
	strh r2, [r6, #8]
	sub r0, #0x41
	strh r0, [r6, #0xa]
	str r2, [sp]
	str r0, [sp, #4]
	str r2, [sp, #8]
	mov r2, #9
	str r2, [sp, #0xc]
	ldr r0, _0215E8D8 // =0x00003042
	lsl r1, r1, #0xc
	str r0, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	mov r0, r6
	add r0, #8
	add r2, #0xf7
	mov r3, #8
	bl StageSelectMover__Create
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, _0215E8BC // =0x000013D0
	ldr r0, _0215E8DC // =0x0000062C
	ldr r1, [r5, r1]
	add r6, r5, r0
	mov r0, r4
	mov r2, #0x2d
	bl SpriteUnknown__Func_204C3CC
	ldr r1, _0215E8BC // =0x000013D0
	mov r3, #2
	ldr r1, [r5, r1]
	mov r2, #0x2d
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #6
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, r6
	mov r1, r4
	lsl r3, r3, #0xa
	bl SpriteUnknown__Func_204C90C
	mov r0, #1
	mov r1, #0x20
	str r0, [r6, #0x58]
	mov r0, r1
	strh r1, [r6, #8]
	sub r0, #0x3e
	strh r0, [r6, #0xa]
	str r1, [sp]
	str r0, [sp, #4]
	str r1, [sp, #8]
	mov r2, #4
	ldr r0, _0215E8D8 // =0x00003042
	str r2, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	mov r0, r6
	lsl r1, r2, #0xa
	add r0, #8
	add r2, #0xfc
	mov r3, #8
	bl StageSelectMover__Create
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, _0215E8BC // =0x000013D0
	mov r0, r4
	ldr r1, [r5, r1]
	mov r2, #0x13
	ldr r6, _0215E8E0 // =0x000008E8
	bl SpriteUnknown__Func_204C3CC
	ldr r1, _0215E8BC // =0x000013D0
	mov r3, r6
	ldr r1, [r5, r1]
	mov r2, #0x13
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #0xa
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	add r0, r5, r6
	mov r1, r4
	sub r3, #0xe8
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	add r0, r5, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, _0215E8BC // =0x000013D0
	mov r0, r4
	ldr r1, [r5, r1]
	mov r2, #0x12
	add r6, #0x64
	bl SpriteUnknown__Func_204C3CC
	ldr r1, _0215E8BC // =0x000013D0
	mov r3, #2
	ldr r1, [r5, r1]
	mov r2, #0x12
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #0xa
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	add r0, r5, r6
	mov r1, r4
	lsl r3, r3, #0xa
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	add r0, r5, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x82
	lsl r0, r0, #4
	add r6, r5, r0
	ldr r0, [sp, #0x1c]
	add r0, #0x60
	lsl r0, r0, #0x10
	lsr r7, r0, #0x10
	ldr r0, _0215E8C4 // =0x000013D4
	ldrh r1, [r5, r0]
	mov r0, #0x80
	tst r0, r1
	beq _0215E7E4
	mov r7, #0x61
_0215E7E4:
	mov r0, #0
	mvn r0, r0
	str r0, [sp]
	ldr r1, _0215E8BC // =0x000013D0
	mov r0, r4
	ldr r1, [r5, r1]
	mov r2, #0x61
	mov r3, #0x6a
	bl StageSelectMenu__Func_215E8EC
	ldr r1, _0215E8BC // =0x000013D0
	mov r3, #2
	ldr r1, [r5, r1]
	mov r2, r7
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #0xb
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, r6
	mov r1, r4
	lsl r3, r3, #0xa
	bl SpriteUnknown__Func_204C90C
	mov r0, #1
	str r0, [r6, #0x58]
	mov r1, #0
	strh r1, [r6, #8]
	mov r0, r6
	mov r2, r1
	strh r1, [r6, #0xa]
	bl AnimatorSprite__ProcessAnimation
	ldr r0, _0215E8C4 // =0x000013D4
	ldrh r1, [r5, r0]
	mov r0, #0x80
	tst r0, r1
	beq _0215E83C
	ldr r1, [r6, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r6, #0x3c]
_0215E83C:
	ldr r0, _0215E8E4 // =0x00000884
	add r6, r5, r0
	ldr r0, [sp, #0x1c]
	cmp r0, #0xa
	blo _0215E84A
	cmp r0, #0xd
	bne _0215E84E
_0215E84A:
	mov r7, #0x5f
	b _0215E850
_0215E84E:
	mov r7, #0x60
_0215E850:
	mov r0, #0
	mvn r0, r0
	str r0, [sp]
	ldr r1, _0215E8BC // =0x000013D0
	mov r0, r4
	ldr r1, [r5, r1]
	mov r2, #0x5f
	mov r3, #0x60
	bl StageSelectMenu__Func_215E8EC
	ldr r1, _0215E8BC // =0x000013D0
	mov r3, #2
	ldr r1, [r5, r1]
	mov r2, r7
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, r6
	mov r1, r4
	lsl r3, r3, #0xa
	bl SpriteUnknown__Func_204C90C
	mov r0, #1
	str r0, [r6, #0x58]
	mov r1, #0
	strh r1, [r6, #8]
	mov r0, r6
	mov r2, r1
	strh r1, [r6, #0xa]
	bl AnimatorSprite__ProcessAnimation
	ldr r0, _0215E8C4 // =0x000013D4
	ldrh r1, [r5, r0]
	mov r0, #0x80
	tst r0, r1
	beq _0215E8A8
	ldr r1, [r6, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r6, #0x3c]
_0215E8A8:
	ldr r0, _0215E8E8 // =StageSelectMenu__Main_215E908
	bl SetCurrentTaskMainEvent
	add sp, #0x20
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0215E8B4: .word StageSelectMenu__Singleton
_0215E8B8: .word 0x000013E0
_0215E8BC: .word 0x000013D0
_0215E8C0: .word 0x0217DB9F
_0215E8C4: .word 0x000013D4
_0215E8C8: .word 0x00000698
_0215E8CC: .word 0x0000069A
_0215E8D0: .word 0x000005C8
_0215E8D4: .word 0x0217DB9E
_0215E8D8: .word 0x00003042
_0215E8DC: .word 0x0000062C
_0215E8E0: .word 0x000008E8
_0215E8E4: .word 0x00000884
_0215E8E8: .word StageSelectMenu__Main_215E908
	thumb_func_end StageSelectMenu__Main_InitStageSprites

	thumb_func_start StageSelectMenu__Func_215E8EC
StageSelectMenu__Func_215E8EC: // 0x0215E8EC
	push {r0, r1, r2, r3}
	push {r3, lr}
	add r3, sp, #0xc
	mov r2, #3
	bic r3, r2
	ldr r1, [sp, #0xc]
	add r2, r3, #4
	bl SpriteUnknown__Func_204C860
	pop {r3}
	pop {r3}
	add sp, #0x10
	bx r3
	.align 2, 0
	thumb_func_end StageSelectMenu__Func_215E8EC

	thumb_func_start StageSelectMenu__Main_215E908
StageSelectMenu__Main_215E908: // 0x0215E908
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x48
	ldr r0, _0215EC88 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0]
	str r0, [sp, #0x3c]
	ldr r0, _0215EC8C // =0x000013E0
	ldr r0, [r4, r0]
	bl StageSelectMenu__Func_215DDB4
	str r0, [sp, #0x38]
	ldr r0, _0215EC90 // =0x000013D4
	ldrh r1, [r4, r0]
	mov r0, #0x80
	tst r0, r1
	beq _0215E932
	mov r0, #0x93
	b _0215E934
_0215E932:
	mov r0, #0x6b
_0215E934:
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	str r0, [sp, #0x1c]
	ldr r0, [sp, #0x3c]
	ldr r1, _0215EC94 // =0x000013D0
	ldr r6, [r0, #0]
	ldr r0, _0215EC98 // =0x000006F4
	ldr r1, [r4, r1]
	add r5, r4, r0
	mov r0, r6
	mov r2, #5
	bl SpriteUnknown__Func_204C3CC
	ldr r1, _0215EC94 // =0x000013D0
	mov r3, #2
	ldr r1, [r4, r1]
	mov r2, #5
	str r1, [sp]
	str r0, [sp, #4]
	str r2, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, r5
	mov r1, r6
	lsl r3, r3, #0xa
	bl SpriteUnknown__Func_204C90C
	mov r0, #0
	strh r0, [r5, #8]
	strh r0, [r5, #0xa]
	ldr r0, _0215EC90 // =0x000013D4
	ldrh r1, [r4, r0]
	mov r0, #0x80
	tst r0, r1
	beq _0215E984
	ldr r1, [r5, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r5, #0x3c]
_0215E984:
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, _0215EC94 // =0x000013D0
	ldr r0, _0215EC9C // =0x00000758
	ldr r1, [r4, r1]
	add r5, r4, r0
	mov r0, r6
	mov r2, #5
	bl SpriteUnknown__Func_204C3CC
	ldr r1, _0215EC94 // =0x000013D0
	ldr r3, _0215ECA0 // =0x00000804
	ldr r1, [r4, r1]
	mov r2, #7
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #2
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, r5
	mov r1, r6
	bl SpriteUnknown__Func_204C90C
	ldr r0, [sp, #0x1c]
	add r0, r0, #4
	strh r0, [r5, #8]
	ldr r1, [r5, #0x3c]
	mov r0, #1
	orr r0, r1
	mov r1, #0
	str r0, [r5, #0x3c]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x9b
	lsl r0, r0, #4
	mov r7, #0x32
	add r0, r4, r0
	mov r5, #8
	lsl r7, r7, #4
	str r0, [sp, #0x40]
_0215E9E2:
	mov r0, #0x32
	ldr r1, _0215EC94 // =0x000013D0
	lsl r0, r0, #4
	sub r0, r7, r0
	lsl r2, r5, #0x10
	str r0, [sp, #0x44]
	ldr r1, [r4, r1]
	mov r0, r6
	lsr r2, r2, #0x10
	bl SpriteUnknown__Func_204C3CC
	ldr r1, _0215EC94 // =0x000013D0
	lsl r2, r5, #0x10
	ldr r1, [r4, r1]
	mov r3, #2
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #5
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x40]
	ldr r0, [sp, #0x44]
	lsr r2, r2, #0x10
	add r0, r1, r0
	mov r1, r6
	lsl r3, r3, #0xa
	bl SpriteUnknown__Func_204C90C
	ldr r1, [sp, #0x40]
	ldr r0, [sp, #0x44]
	add r0, r1, r0
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r5, r5, #1
	add r7, #0x64
	cmp r5, #0x11
	bls _0215E9E2
	ldr r0, _0215ECA4 // =0x00000D98
	mov r5, #0
	add r7, r4, r0
_0215EA3A:
	ldr r1, _0215EC94 // =0x000013D0
	lsl r2, r5, #0x10
	ldr r1, [r4, r1]
	mov r0, r6
	lsr r2, r2, #0x10
	bl SpriteUnknown__Func_204C3CC
	ldr r1, _0215EC94 // =0x000013D0
	lsl r2, r5, #0x10
	ldr r1, [r4, r1]
	ldr r3, _0215ECA0 // =0x00000804
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #1
	str r0, [sp, #0x10]
	mov r0, r7
	mov r1, r6
	lsr r2, r2, #0x10
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	mov r0, r7
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r5, r5, #1
	add r7, #0x64
	cmp r5, #3
	bls _0215EA3A
	ldr r1, _0215EC94 // =0x000013D0
	mov r0, r6
	ldr r1, [r4, r1]
	mov r2, #4
	ldr r5, _0215ECA8 // =0x00000F28
	bl SpriteUnknown__Func_204C3CC
	ldr r1, _0215EC94 // =0x000013D0
	ldr r3, _0215ECA0 // =0x00000804
	ldr r1, [r4, r1]
	mov r2, #4
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	add r0, r4, r5
	mov r1, r6
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, _0215ECAC // =0x0000108C
	mov r7, #1
	add r5, r4, r0
	sub r0, #0x38
	add r0, r4, r0
	str r0, [sp, #0x2c]
_0215EABE:
	cmp r7, #1
	bne _0215EAC8
	ldr r0, _0215ECA0 // =0x00000804
	str r0, [sp, #0x18]
	b _0215EACC
_0215EAC8:
	ldr r0, _0215ECB0 // =0x00000884
	str r0, [sp, #0x18]
_0215EACC:
	ldr r1, _0215EC94 // =0x000013D0
	mov r0, r6
	ldr r1, [r4, r1]
	mov r2, #6
	bl SpriteUnknown__Func_204C3CC
	ldr r1, _0215EC94 // =0x000013D0
	ldr r3, [sp, #0x18]
	ldr r1, [r4, r1]
	lsl r3, r3, #0x10
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #5
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #1
	str r0, [sp, #0x10]
	mov r0, r5
	mov r1, r6
	mov r2, #6
	lsr r3, r3, #0x10
	bl SpriteUnknown__Func_204C90C
	cmp r7, #1
	bne _0215EB30
	mov r0, #0x17
	mvn r0, r0
	strh r0, [r5, #8]
	mov r0, #8
	strh r0, [r5, #0xa]
	sub r0, #0x20
	str r0, [sp]
	mov r0, #8
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	ldr r0, _0215ECB4 // =0x00003042
	mov r1, #1
	str r0, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	mov r0, r5
	lsl r1, r1, #0xc
	add r0, #8
	lsr r2, r1, #4
	mov r3, #0x10
	bl StageSelectMover__Create
	b _0215EB64
_0215EB30:
	mov r0, #0x46
	lsl r0, r0, #2
	strh r0, [r5, #8]
	mov r0, #8
	strh r0, [r5, #0xa]
	mov r0, #0x46
	lsl r0, r0, #2
	str r0, [sp]
	mov r0, #8
	str r0, [sp, #4]
	mov r0, #0xf8
	str r0, [sp, #8]
	mov r0, #8
	str r0, [sp, #0xc]
	ldr r0, _0215ECB4 // =0x00003042
	mov r1, #1
	str r0, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	mov r0, r5
	lsl r1, r1, #0xc
	add r0, #8
	lsr r2, r1, #4
	mov r3, #0x10
	bl StageSelectMover__Create
_0215EB64:
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	cmp r7, #1
	bne _0215EB78
	mov r1, #0
	mvn r1, r1
	b _0215EB7A
_0215EB78:
	mov r1, #1
_0215EB7A:
	ldr r0, _0215ECB8 // =StageSelectMenu__TouchAreaFunc_215DC1C
	mov r2, #2
	str r0, [sp]
	str r1, [sp, #4]
	mov r1, #0
	ldr r0, [sp, #0x2c]
	mov r3, r1
	bl ovl03_215DF24
	ldr r0, _0215ECBC // =0x00000F8C
	mov r2, #1
	ldr r1, [sp, #0x2c]
	add r0, r4, r0
	lsl r2, r2, #8
	bl TouchField__AddArea
	ldr r0, [sp, #0x2c]
	add r7, r7, #1
	add r0, #0xb0
	add r5, #0xb0
	str r0, [sp, #0x2c]
	cmp r7, #2
	bls _0215EABE
	ldr r1, _0215ECC0 // =0x000011EC
	mov r5, #3
	add r0, r4, r1
	str r0, [sp, #0x34]
	mov r0, #0x21
	lsl r0, r0, #4
	sub r1, #0x38
	add r0, r4, r0
	add r7, r4, r1
	str r0, [sp, #0x30]
_0215EBBC:
	sub r1, r5, #3
	mov r0, #6
	mul r0, r1
	ldr r1, _0215ECC4 // =0x0217DB88
	add r2, r1, r0
	ldrh r1, [r2, #4]
	str r1, [sp, #0x28]
	ldrh r1, [r2, #2]
	str r1, [sp, #0x24]
	ldr r1, _0215ECC4 // =0x0217DB88
	ldrh r0, [r1, r0]
	ldr r1, _0215EC94 // =0x000013D0
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x28]
	str r0, [sp]
	mov r0, #0
	mvn r0, r0
	str r0, [sp, #4]
	ldr r1, [r4, r1]
	ldr r2, [sp, #0x20]
	ldr r3, [sp, #0x24]
	mov r0, r6
	bl StageSelectMenu__Func_215E8EC
	ldr r1, _0215EC94 // =0x000013D0
	ldr r3, _0215ECA0 // =0x00000804
	ldr r1, [r4, r1]
	str r1, [sp]
	str r0, [sp, #4]
	sub r0, r5, #1
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x34]
	ldr r2, [sp, #0x20]
	mov r1, r6
	bl SpriteUnknown__Func_204C90C
	ldr r0, _0215ECC8 // =StageSelectMenu__Func_215DC60
	mov r1, #0
	str r0, [sp]
	sub r0, r5, #2
	str r0, [sp, #4]
	ldr r3, _0215ECCC // =StageSelectMenu__Func_215DC9C
	mov r0, r7
	mov r2, r1
	bl ovl03_215DF24
	cmp r5, #3
	bne _0215EC30
	ldr r1, [sp, #0x38]
	mov r0, r4
	bl StageSelectMenu__Func_215FAC4
	b _0215EC3C
_0215EC30:
	ldr r1, [sp, #0x20]
	ldr r2, [sp, #0x24]
	ldr r3, [sp, #0x28]
	mov r0, r7
	bl StageSelectMenu__ConfigureButton
_0215EC3C:
	mov r1, #0
	ldr r0, [sp, #0x34]
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, _0215ECBC // =0x00000F8C
	mov r2, #1
	add r0, r4, r0
	mov r1, r7
	lsl r2, r2, #8
	bl TouchField__AddArea
	mov r0, #0x41
	ldr r1, [sp, #0x30]
	mov r2, #0
	lsl r0, r0, #6
	str r2, [r1, r0]
	ldr r0, [sp, #0x34]
	add r5, r5, #1
	add r0, #0xb0
	str r0, [sp, #0x34]
	mov r0, r1
	add r0, #0xb0
	add r7, #0xb0
	str r0, [sp, #0x30]
	cmp r5, #5
	bls _0215EBBC
	ldr r1, _0215EC94 // =0x000013D0
	ldr r0, _0215ECD0 // =0x000007BC
	ldr r1, [r4, r1]
	add r5, r4, r0
	mov r0, r6
	mov r2, #0x25
	bl SpriteUnknown__Func_204C3CC
	ldr r1, _0215EC94 // =0x000013D0
	ldr r3, _0215ECA0 // =0x00000804
	b _0215ECD4
	.align 2, 0
_0215EC88: .word StageSelectMenu__Singleton
_0215EC8C: .word 0x000013E0
_0215EC90: .word 0x000013D4
_0215EC94: .word 0x000013D0
_0215EC98: .word 0x000006F4
_0215EC9C: .word 0x00000758
_0215ECA0: .word 0x00000804
_0215ECA4: .word 0x00000D98
_0215ECA8: .word 0x00000F28
_0215ECAC: .word 0x0000108C
_0215ECB0: .word 0x00000884
_0215ECB4: .word 0x00003042
_0215ECB8: .word StageSelectMenu__TouchAreaFunc_215DC1C
_0215ECBC: .word 0x00000F8C
_0215ECC0: .word 0x000011EC
_0215ECC4: .word 0x0217DB88
_0215ECC8: .word StageSelectMenu__Func_215DC60
_0215ECCC: .word StageSelectMenu__Func_215DC9C
_0215ECD0: .word 0x000007BC
_0215ECD4:
	ldr r1, [r4, r1]
	mov r2, #0x25
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #2
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	mov r0, #1
	str r0, [sp, #0x10]
	mov r0, r5
	mov r1, r6
	bl SpriteUnknown__Func_204C90C
	ldr r0, [sp, #0x1c]
	mov r1, #0
	strh r0, [r5, #8]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0x3c]
	ldr r1, _0215EDB0 // =0x000013D0
	ldr r6, [r0, #4]
	ldr r0, _0215EDB4 // =0x00000FDC
	ldr r1, [r4, r1]
	add r5, r4, r0
	mov r0, r6
	bl SpriteUnknown__GetSpriteSize
	ldr r1, _0215EDB0 // =0x000013D0
	mov r3, #8
	ldr r1, [r4, r1]
	mov r2, #0
	str r1, [sp]
	str r0, [sp, #4]
	str r3, [sp, #8]
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	mov r0, r5
	mov r1, r6
	lsl r3, r3, #8
	bl SpriteUnknown__Func_204C90C
	ldr r1, [r5, #0x3c]
	mov r0, #1
	orr r0, r1
	str r0, [r5, #0x3c]
	mov r1, #0x10
	strh r1, [r5, #8]
	mov r2, #0xb0
	strh r2, [r5, #0xa]
	str r1, [sp]
	str r2, [sp, #4]
	str r1, [sp, #8]
	str r2, [sp, #0xc]
	ldr r0, _0215EDB8 // =0x00003042
	lsl r1, r1, #8
	str r0, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	mov r0, r5
	add r0, #8
	add r2, #0x50
	mov r3, #0x14
	bl StageSelectMover__Create
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0
	ldr r0, _0215EDBC // =0x00000FA4
	str r1, [sp]
	ldr r3, _0215EDC0 // =StageSelectMenu__Func_215DCB4
	add r0, r4, r0
	mov r2, r1
	str r1, [sp, #4]
	bl ovl03_215DF24
	ldr r0, _0215EDBC // =0x00000FA4
	mov r2, #1
	add r0, r4, r0
	mov r1, #0
	mov r3, r2
	bl StageSelectMenu__ConfigureButton
	ldr r1, _0215EDC4 // =0x00000F8C
	mov r2, #1
	add r0, r4, r1
	add r1, #0x18
	add r1, r4, r1
	lsl r2, r2, #8
	bl TouchField__AddArea
	ldr r0, _0215EDB0 // =0x000013D0
	ldr r0, [r4, r0]
	bl Task__OVL03Unknown215DCCC__Create
	mov r0, #0
	mvn r0, r0
	mov r1, #1
	bl StageSelectMenu__Func_215E084
	ldr r0, _0215EDC8 // =StageSelectMenu__Main_215EDCC
	bl SetCurrentTaskMainEvent
	add sp, #0x48
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215EDB0: .word 0x000013D0
_0215EDB4: .word 0x00000FDC
_0215EDB8: .word 0x00003042
_0215EDBC: .word 0x00000FA4
_0215EDC0: .word StageSelectMenu__Func_215DCB4
_0215EDC4: .word 0x00000F8C
_0215EDC8: .word StageSelectMenu__Main_215EDCC
	thumb_func_end StageSelectMenu__Main_215E908

	thumb_func_start StageSelectMenu__Main_215EDCC
StageSelectMenu__Main_215EDCC: // 0x0215EDCC
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #8
	ldr r0, _0215EE48 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r5, r0
	ldr r0, _0215EE4C // =0x000013D4
	ldr r6, _0215EE50 // =gameState
	ldrh r1, [r5, r0]
	mov r0, #0x80
	tst r0, r1
	beq _0215EE3E
	add r0, r5, #4
	bl TimeAttackRankList__Init
	ldr r0, _0215EE54 // =0x000013D0
	ldr r0, [r5, r0]
	cmp r0, #0
	beq _0215EDF8
	mov r2, #0
	b _0215EDFA
_0215EDF8:
	mov r2, #1
_0215EDFA:
	mov r1, #0
	str r1, [sp]
	ldr r0, [r5, #0]
	mov r3, r1
	add r0, #8
	str r0, [sp, #4]
	add r0, r5, #4
	bl TimeAttackRankList__Create
	ldr r7, _0215EE58 // =0x000013E0
	mov r4, #0
_0215EE10:
	ldr r0, [r6, #4]
	ldr r1, [r5, r7]
	mov r2, r4
	bl StageSelectMenu__Func_215E2F8
	lsl r1, r4, #0x10
	mov r2, r0
	ldr r3, [r6, #4]
	add r0, r5, #4
	lsr r1, r1, #0x10
	bl TimeAttackRankList__SetRecord
	add r4, r4, #1
	cmp r4, #5
	blo _0215EE10
	ldr r1, [r5, #0]
	add r0, r5, #4
	add r1, #8
	bl TimeAttackRankList__InitRecords
	add r0, r5, #4
	bl TimeAttackRankList__Func_216F9C0
_0215EE3E:
	ldr r0, _0215EE5C // =StageSelectMenu__Main_CreateUnknown215EE60
	bl SetCurrentTaskMainEvent
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215EE48: .word StageSelectMenu__Singleton
_0215EE4C: .word 0x000013D4
_0215EE50: .word gameState
_0215EE54: .word 0x000013D0
_0215EE58: .word 0x000013E0
_0215EE5C: .word StageSelectMenu__Main_CreateUnknown215EE60
	thumb_func_end StageSelectMenu__Main_215EDCC

	thumb_func_start StageSelectMenu__Main_CreateUnknown215EE60
StageSelectMenu__Main_CreateUnknown215EE60: // 0x0215EE60
	push {r3, r4, lr}
	sub sp, #0xc
	ldr r0, _0215EEC0 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl ResetTouchInput
	ldr r0, _0215EEC4 // =0x000013D0
	ldr r0, [r4, r0]
	cmp r0, #1
	ldr r0, _0215EEC8 // =0xFFFFE0FF
	beq _0215EE8E
	mov r2, #1
	lsl r2, r2, #0x1a
	ldr r1, [r2, #0]
	and r1, r0
	mov r0, #7
	lsl r0, r0, #0xa
	orr r0, r1
	str r0, [r2]
	b _0215EE9C
_0215EE8E:
	ldr r2, _0215EECC // =0x04001000
	ldr r1, [r2, #0]
	and r1, r0
	mov r0, #7
	lsl r0, r0, #0xa
	orr r0, r1
	str r0, [r2]
_0215EE9C:
	ldr r0, _0215EED0 // =0x00003081
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215EED4 // =Task__OVL03Unknown215EE60__Main
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	ldr r0, _0215EED8 // =0x000013D8
	mov r1, #0
	str r1, [r4, r0]
	ldr r0, _0215EEDC // =StageSelectMenu__Main_CreateUnknown215EEE0
	bl SetCurrentTaskMainEvent
	add sp, #0xc
	pop {r3, r4, pc}
	.align 2, 0
_0215EEC0: .word StageSelectMenu__Singleton
_0215EEC4: .word 0x000013D0
_0215EEC8: .word 0xFFFFE0FF
_0215EECC: .word 0x04001000
_0215EED0: .word 0x00003081
_0215EED4: .word Task__OVL03Unknown215EE60__Main
_0215EED8: .word 0x000013D8
_0215EEDC: .word StageSelectMenu__Main_CreateUnknown215EEE0
	thumb_func_end StageSelectMenu__Main_CreateUnknown215EE60

	thumb_func_start StageSelectMenu__Main_CreateUnknown215EEE0
StageSelectMenu__Main_CreateUnknown215EEE0: // 0x0215EEE0
	push {r3, r4, lr}
	sub sp, #0xc
	ldr r0, _0215EF78 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl StageSelectMenu__Func_215E134
	cmp r0, #0
	beq _0215EEF8
	b _0215EEF8
_0215EEF8:
	ldr r0, _0215EF7C // =0x000013D8
	ldr r1, [r4, r0]
	add r1, r1, #1
	str r1, [r4, r0]
	ldr r0, _0215EF7C // =0x000013D8
	ldr r2, [r4, r0]
	cmp r2, #0x20
	ble _0215EF56
	mov r1, #0
	add r0, r0, #4
	str r1, [r4, r0]
	ldr r0, _0215EF80 // =0x000005C6
	mov r2, #1
	strh r1, [r4, r0]
	ldr r0, _0215EF84 // =0x00000794
	ldr r3, [r4, r0]
	bic r3, r2
	str r3, [r4, r0]
	ldr r0, _0215EF88 // =0x00001018
	ldr r3, [r4, r0]
	bic r3, r2
	str r3, [r4, r0]
	ldr r2, [r4, #0]
	mov r0, r2
	add r0, #0x98
	ldr r3, [r0, #0]
	cmp r3, #0
	beq _0215EF38
	add r2, #0x9c
	ldr r2, [r2, #0]
	mov r0, #2
	blx r3
_0215EF38:
	ldr r0, _0215EF8C // =0x00003041
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #4]
	ldr r0, _0215EF90 // =Task__OVL03Unknown215EEE0__Main
	mov r2, r1
	mov r3, r1
	str r1, [sp, #8]
	bl TaskCreate_
	ldr r0, _0215EF94 // =StageSelectMenu__Main_215EF98
	bl SetCurrentTaskMainEvent
	add sp, #0xc
	pop {r3, r4, pc}
_0215EF56:
	lsl r3, r2, #0xc
	asr r2, r3, #3
	lsr r2, r2, #0x1c
	add r2, r3, r2
	lsl r2, r2, #0xc
	mov r3, #1
	mov r0, #0xc0
	mov r1, #0
	asr r2, r2, #0x10
	lsl r3, r3, #0xc
	bl Task__Unknown204BE48__LerpValue
	ldr r1, _0215EF80 // =0x000005C6
	strh r0, [r4, r1]
	add sp, #0xc
	pop {r3, r4, pc}
	nop
_0215EF78: .word StageSelectMenu__Singleton
_0215EF7C: .word 0x000013D8
_0215EF80: .word 0x000005C6
_0215EF84: .word 0x00000794
_0215EF88: .word 0x00001018
_0215EF8C: .word 0x00003041
_0215EF90: .word Task__OVL03Unknown215EEE0__Main
_0215EF94: .word StageSelectMenu__Main_215EF98
	thumb_func_end StageSelectMenu__Main_CreateUnknown215EEE0

	thumb_func_start StageSelectMenu__Main_215EF98
StageSelectMenu__Main_215EF98: // 0x0215EF98
	push {r3, r4, r5, lr}
	ldr r0, _0215F084 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, _0215F088 // =touchInput
	mov r4, r0
	ldrh r1, [r1, #0x12]
	mov r2, #1
	mov r0, #0
	tst r1, r2
	bne _0215F058
	ldr r1, _0215F08C // =padInput
	ldrh r5, [r1, #8]
	mov r1, #0x40
	mov r3, r5
	tst r3, r1
	beq _0215EFD6
	ldr r0, _0215F090 // =0x000013E0
	sub r1, #0x41
	ldr r0, [r4, r0]
	bl StageSelectMenu__Func_215DEB4
	mov r1, #1
	bl StageSelectMenu__Func_215E084
	mov r0, #2
	bl PlaySysMenuNavSfx
	mov r0, #1
	b _0215EFF4
_0215EFD6:
	mov r1, #0x80
	tst r1, r5
	beq _0215EFF4
	ldr r0, _0215F090 // =0x000013E0
	mov r1, r2
	ldr r0, [r4, r0]
	bl StageSelectMenu__Func_215DEB4
	mov r1, #1
	bl StageSelectMenu__Func_215E084
	mov r0, #2
	bl PlaySysMenuNavSfx
	mov r0, #1
_0215EFF4:
	ldr r1, _0215F08C // =padInput
	ldrh r3, [r1, #0]
	mov r1, #0x22
	lsl r1, r1, #4
	mov r2, r3
	tst r2, r1
	beq _0215F008
	lsr r1, r1, #1
	tst r1, r3
	bne _0215F050
_0215F008:
	ldr r1, _0215F08C // =padInput
	ldrh r3, [r1, #8]
	mov r1, #0x22
	lsl r1, r1, #4
	mov r2, r3
	tst r2, r1
	beq _0215F032
	ldr r0, _0215F090 // =0x000013E0
	mov r1, #0
	ldr r0, [r4, r0]
	mvn r1, r1
	bl StageSelectMenu__Func_215DE28
	mov r1, #0
	bl StageSelectMenu__Func_215E084
	mov r0, #2
	bl PlaySysMenuNavSfx
	mov r0, #1
	b _0215F050
_0215F032:
	lsr r1, r1, #1
	tst r1, r3
	beq _0215F050
	ldr r0, _0215F090 // =0x000013E0
	mov r1, #1
	ldr r0, [r4, r0]
	bl StageSelectMenu__Func_215DE28
	mov r1, #0
	bl StageSelectMenu__Func_215E084
	mov r0, #2
	bl PlaySysMenuNavSfx
	mov r0, #1
_0215F050:
	cmp r0, #0
	beq _0215F058
	bl StageSelectMenu__Func_215E324
_0215F058:
	ldr r0, _0215F08C // =padInput
	ldrh r2, [r0, #4]
	mov r0, #1
	mov r1, r2
	tst r1, r0
	beq _0215F06A
	bl StageSelectMenu__Func_215DB44
	pop {r3, r4, r5, pc}
_0215F06A:
	mov r0, #2
	mov r1, r2
	tst r1, r0
	beq _0215F078
	bl StageSelectMenu__Func_215DB44
	pop {r3, r4, r5, pc}
_0215F078:
	ldr r0, _0215F094 // =0x00000F8C
	add r0, r4, r0
	bl TouchField__Process
	pop {r3, r4, r5, pc}
	nop
_0215F084: .word StageSelectMenu__Singleton
_0215F088: .word touchInput
_0215F08C: .word padInput
_0215F090: .word 0x000013E0
_0215F094: .word 0x00000F8C
	thumb_func_end StageSelectMenu__Main_215EF98

	thumb_func_start Task__OVL03Unknown215EEE0__Main
Task__OVL03Unknown215EEE0__Main: // 0x0215F098
	push {r3, r4, r5, r6, r7, lr}
	ldr r0, _0215F184 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215F0A8
	bl DestroyCurrentTask
	pop {r3, r4, r5, r6, r7, pc}
_0215F0A8:
	bl GetTaskWork_
	mov r5, r0
	ldr r0, _0215F188 // =0x000013E0
	ldr r0, [r5, r0]
	bl StageSelectMenu__Func_215DDB4
	mov r4, r0
	ldr r0, _0215F188 // =0x000013E0
	ldr r0, [r5, r0]
	bl StageSelectMenu__Func_215DDC4
	ldr r1, _0215F18C // =0x000013C4
	mov r2, #2
	ldr r3, [r5, r1]
	lsl r2, r2, #0xc
	cmp r3, r2
	bge _0215F0DA
	ldr r0, _0215F190 // =0x00000666
	add r0, r3, r0
	str r0, [r5, r1]
	ldr r0, [r5, r1]
	cmp r0, r2
	blt _0215F0DA
	str r2, [r5, r1]
_0215F0DA:
	ldr r0, _0215F194 // =0x0217DB9E
	lsl r1, r4, #1
	ldrb r1, [r0, r1]
	ldr r0, _0215F198 // =0x000005D4
	ldrh r2, [r5, r0]
	cmp r2, r1
	beq _0215F102
	sub r0, #0xc
	add r0, r5, r0
	bl AnimatorSprite__SetAnimation
	mov r0, r5
	mov r1, r4
	bl StageSelectMenu__Func_215FAC4
	mov r0, #0
	mvn r0, r0
	mov r1, #1
	bl StageSelectMenu__Func_215E084
_0215F102:
	ldr r0, _0215F19C // =0x000005C8
	add r4, r5, r0
	mov r0, #0x9b
	lsl r0, r0, #4
	add r6, r5, r0
	cmp r4, r6
	beq _0215F122
	mov r7, #0
_0215F112:
	mov r0, r4
	mov r1, r7
	mov r2, r7
	bl AnimatorSprite__ProcessAnimation
	add r4, #0x64
	cmp r4, r6
	bne _0215F112
_0215F122:
	mov r0, #0x9b
	lsl r0, r0, #4
	add r4, r5, r0
	ldr r0, _0215F1A0 // =0x00000D98
	add r6, r5, r0
	cmp r4, r6
	beq _0215F142
	mov r7, #0
_0215F132:
	mov r0, r4
	mov r1, r7
	mov r2, r7
	bl AnimatorSprite__ProcessAnimation
	add r4, #0x64
	cmp r4, r6
	bne _0215F132
_0215F142:
	ldr r0, _0215F1A0 // =0x00000D98
	add r4, r5, r0
	ldr r0, _0215F1A4 // =0x00000F8C
	add r6, r5, r0
	cmp r4, r6
	beq _0215F160
	mov r7, #0
_0215F150:
	mov r0, r4
	mov r1, r7
	mov r2, r7
	bl AnimatorSprite__ProcessAnimation
	add r4, #0x64
	cmp r4, r6
	bne _0215F150
_0215F160:
	ldr r0, _0215F1A8 // =0x00000FA4
	add r4, r5, r0
	ldr r0, _0215F18C // =0x000013C4
	add r5, r5, r0
	cmp r4, r5
	beq _0215F180
	mov r6, #0
_0215F16E:
	mov r0, r4
	add r0, #0x38
	mov r1, r6
	mov r2, r6
	bl AnimatorSprite__ProcessAnimation
	add r4, #0xb0
	cmp r4, r5
	bne _0215F16E
_0215F180:
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0215F184: .word StageSelectMenu__Singleton
_0215F188: .word 0x000013E0
_0215F18C: .word 0x000013C4
_0215F190: .word 0x00000666
_0215F194: .word 0x0217DB9E
_0215F198: .word 0x000005D4
_0215F19C: .word 0x000005C8
_0215F1A0: .word 0x00000D98
_0215F1A4: .word 0x00000F8C
_0215F1A8: .word 0x00000FA4
	thumb_func_end Task__OVL03Unknown215EEE0__Main

	thumb_func_start Task__OVL03Unknown215EE60__Main
Task__OVL03Unknown215EE60__Main: // 0x0215F1AC
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x28
	ldr r0, _0215F44C // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215F1C0
	bl DestroyCurrentTask
	add sp, #0x28
	pop {r3, r4, r5, r6, r7, pc}
_0215F1C0:
	bl GetTaskWork_
	mov r5, r0
	ldr r0, _0215F450 // =0x000013E0
	ldr r0, [r5, r0]
	bl StageSelectMenu__Func_215DDB4
	str r0, [sp, #0x14]
	ldr r0, _0215F450 // =0x000013E0
	ldr r0, [r5, r0]
	bl StageSelectMenu__Func_215DDC4
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	bl StageSelectMenu__Func_215DD84
	mov r1, #3
	str r0, [sp]
	sub r0, r1, r0
	lsl r1, r0, #5
	lsr r0, r1, #0x1f
	add r0, r1, r0
	asr r0, r0, #1
	ldr r2, _0215F454 // =0x000005C4
	str r0, [sp, #0xc]
	ldrsh r0, [r5, r2]
	ldr r3, _0215F458 // =0x000013D0
	neg r1, r0
	ldr r0, [r5, r3]
	lsl r4, r0, #2
	ldr r0, _0215F45C // =VRAMSystem__GFXControl
	ldr r4, [r0, r4]
	strh r1, [r4, #8]
	add r1, r2, #2
	ldrsh r1, [r5, r1]
	neg r2, r1
	ldr r1, [r5, r3]
	add r3, #0x10
	lsl r1, r1, #2
	ldr r0, [r0, r1]
	strh r2, [r0, #0xa]
	ldr r0, [r5, r3]
	bl StageSelectMenu__Func_215DDC4
	ldr r1, [sp, #0xc]
	sub r0, r0, #1
	add r1, #0x42
	lsl r0, r0, #5
	add r1, r1, r0
	ldr r0, _0215F460 // =0x00000762
	strh r1, [r5, r0]
	ldr r0, _0215F450 // =0x000013E0
	ldr r0, [r5, r0]
	bl StageSelectMenu__Func_215DDC4
	ldr r1, [sp, #0xc]
	sub r0, r0, #1
	add r1, #0x38
	lsl r0, r0, #5
	add r1, r1, r0
	ldr r0, _0215F464 // =0x000007C6
	strh r1, [r5, r0]
	ldr r0, _0215F468 // =0x000005C8
	add r4, r5, r0
	add r0, #0xc8
	add r6, r5, r0
	cmp r4, r6
	beq _0215F258
_0215F24C:
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	add r4, #0x64
	cmp r4, r6
	bne _0215F24C
_0215F258:
	mov r0, #0x69
	lsl r0, r0, #4
	add r4, r5, r0
	ldr r0, _0215F46C // =0x000008E8
	add r6, r5, r0
	cmp r4, r6
	beq _0215F276
	ldr r7, _0215F454 // =0x000005C4
_0215F268:
	mov r0, r4
	add r1, r5, r7
	bl StageSelectMenu__Func_215E104
	add r4, #0x64
	cmp r4, r6
	bne _0215F268
_0215F276:
	ldr r0, _0215F470 // =0x000013D4
	ldrh r1, [r5, r0]
	mov r0, #0x80
	tst r0, r1
	bne _0215F35E
	ldr r0, [sp, #0xc]
	add r0, #0x39
	lsl r0, r0, #0x10
	asr r7, r0, #0x10
	mov r0, #0
	str r0, [sp, #0x18]
	ldr r0, [sp]
	cmp r0, #0
	bls _0215F35E
_0215F292:
	ldr r1, [sp, #0x18]
	ldr r0, [sp, #0x14]
	add r1, r1, #1
	lsl r0, r0, #0x10
	lsl r1, r1, #0x10
	lsr r0, r0, #0x10
	lsr r1, r1, #0x10
	bl StageSelectMenu__Func_215DDA0
	mov r6, r0
	bl StageSelectMenu__Func_215E2A4
	mov r4, r0
	beq _0215F2EA
	mov r0, r6
	mov r1, r4
	bl StageSelectMenu__Func_215E2B8
	ldr r1, _0215F474 // =0x00000D98
	add r2, r5, r1
	mov r1, #0x64
	mul r1, r0
	add r6, r2, r1
	ldr r1, _0215F454 // =0x000005C4
	mov r0, #0xd0
	strh r0, [r6, #8]
	mov r0, r6
	add r1, r5, r1
	strh r7, [r6, #0xa]
	bl StageSelectMenu__Func_215E104
	ldr r0, _0215F478 // =0x00000EC4
	add r1, r5, r0
	cmp r1, r6
	bne _0215F2EA
	add r0, #0x64
	add r0, r5, r0
	mov r1, #0xd0
	strh r1, [r0, #8]
	ldr r1, _0215F454 // =0x000005C4
	strh r7, [r0, #0xa]
	add r1, r5, r1
	bl StageSelectMenu__Func_215E104
_0215F2EA:
	add r0, r7, #1
	lsl r0, r0, #0x10
	asr r7, r0, #0x10
	ldr r0, _0215F47C // =0x0000094C
	mov r1, #0x9d
	add r0, r5, r0
	strh r1, [r0, #8]
	mov r1, r7
	add r1, #0x11
	strh r1, [r0, #0xa]
	ldr r1, _0215F454 // =0x000005C4
	mov r6, #0xcd
	add r1, r5, r1
	bl StageSelectMenu__Func_215E104
	mov r0, #0
	str r0, [sp, #8]
	mov r0, #0x9b
	lsl r0, r0, #4
	add r0, r5, r0
	str r0, [sp, #0x1c]
_0215F314:
	mov r0, r4
	mov r1, #0xa
	bl _u32_div_f
	mov r0, #0x64
	mov r2, r1
	sub r6, #8
	mul r2, r0
	ldr r0, [sp, #0x1c]
	lsl r1, r6, #0x10
	asr r6, r1, #0x10
	ldr r1, _0215F454 // =0x000005C4
	add r0, r0, r2
	strh r6, [r0, #8]
	add r1, r5, r1
	strh r7, [r0, #0xa]
	bl StageSelectMenu__Func_215E104
	mov r0, r4
	mov r1, #0xa
	bl _u32_div_f
	mov r4, r0
	ldr r0, [sp, #8]
	add r0, r0, #1
	str r0, [sp, #8]
	cmp r0, #6
	blo _0215F314
	add r7, #0x1f
	lsl r0, r7, #0x10
	asr r7, r0, #0x10
	ldr r0, [sp, #0x18]
	add r1, r0, #1
	ldr r0, [sp]
	str r1, [sp, #0x18]
	cmp r1, r0
	blo _0215F292
_0215F35E:
	ldr r0, _0215F470 // =0x000013D4
	ldrh r1, [r5, r0]
	mov r0, #0x80
	tst r0, r1
	beq _0215F36C
	mov r0, #0x93
	b _0215F36E
_0215F36C:
	mov r0, #0x6b
_0215F36E:
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	str r0, [sp, #4]
	ldr r0, [sp, #0xc]
	ldr r1, [sp, #4]
	add r0, #0x38
	str r0, [sp, #0xc]
	lsl r0, r0, #0x10
	asr r6, r0, #0x10
	ldr r0, _0215F480 // =0x000011EC
	add r1, #0x16
	add r4, r5, r0
	ldr r0, _0215F46C // =0x000008E8
	mov r7, #3
	add r0, r5, r0
	str r0, [sp, #0x20]
	lsl r0, r1, #0x10
	asr r0, r0, #0x10
	str r0, [sp, #0x24]
_0215F394:
	ldr r0, [sp, #4]
	sub r1, r7, #2
	strh r0, [r4, #8]
	ldr r0, [sp, #0x10]
	strh r6, [r4, #0xa]
	cmp r0, r1
	beq _0215F3AA
	ldr r0, [sp, #4]
	strh r0, [r4, #8]
	strh r6, [r4, #0xa]
	b _0215F3BA
_0215F3AA:
	ldr r0, _0215F484 // =0x000013C4
	ldr r0, [r5, r0]
	asr r1, r0, #0xc
	ldr r0, [sp, #4]
	sub r0, r0, r1
	strh r0, [r4, #8]
	sub r0, r6, r1
	strh r0, [r4, #0xa]
_0215F3BA:
	sub r1, r7, #3
	beq _0215F3D6
	ldr r0, [sp]
	cmp r1, r0
	bhs _0215F3D6
	ldr r1, [sp, #0x24]
	ldr r0, [sp, #0x20]
	strh r1, [r0, #8]
	sub r1, r6, #5
	strh r1, [r0, #0xa]
	ldr r1, _0215F454 // =0x000005C4
	add r1, r5, r1
	bl StageSelectMenu__Func_215E104
_0215F3D6:
	add r6, #0x20
	lsl r0, r6, #0x10
	add r7, r7, #1
	asr r6, r0, #0x10
	add r4, #0xb0
	cmp r7, #5
	bls _0215F394
	ldr r0, _0215F488 // =0x000011B4
	mov r6, #0
	add r3, r5, r0
	ldr r0, _0215F484 // =0x000013C4
	add r2, r5, r0
	cmp r3, r2
	beq _0215F410
	mov r7, #1
	mov r1, #1
_0215F3F6:
	ldr r0, [sp]
	mov r4, r6
	add r6, r6, #1
	cmp r4, r0
	ldr r0, [r3, #0x74]
	bhs _0215F406
	bic r0, r1
	b _0215F408
_0215F406:
	orr r0, r7
_0215F408:
	str r0, [r3, #0x74]
	add r3, #0xb0
	cmp r3, r2
	bne _0215F3F6
_0215F410:
	ldr r0, _0215F48C // =0x00000FA4
	add r4, r5, r0
	ldr r0, _0215F488 // =0x000011B4
	add r6, r5, r0
	cmp r4, r6
	beq _0215F42A
_0215F41C:
	mov r0, r4
	add r0, #0x38
	bl AnimatorSprite__DrawFrame
	add r4, #0xb0
	cmp r4, r6
	bne _0215F41C
_0215F42A:
	ldr r0, _0215F488 // =0x000011B4
	add r4, r5, r0
	ldr r0, _0215F484 // =0x000013C4
	add r6, r5, r0
	cmp r4, r6
	beq _0215F448
	ldr r7, _0215F454 // =0x000005C4
_0215F438:
	mov r0, r4
	add r0, #0x38
	add r1, r5, r7
	bl StageSelectMenu__Func_215E104
	add r4, #0xb0
	cmp r4, r6
	bne _0215F438
_0215F448:
	add sp, #0x28
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215F44C: .word StageSelectMenu__Singleton
_0215F450: .word 0x000013E0
_0215F454: .word 0x000005C4
_0215F458: .word 0x000013D0
_0215F45C: .word VRAMSystem__GFXControl
_0215F460: .word 0x00000762
_0215F464: .word 0x000007C6
_0215F468: .word 0x000005C8
_0215F46C: .word 0x000008E8
_0215F470: .word 0x000013D4
_0215F474: .word 0x00000D98
_0215F478: .word 0x00000EC4
_0215F47C: .word 0x0000094C
_0215F480: .word 0x000011EC
_0215F484: .word 0x000013C4
_0215F488: .word 0x000011B4
_0215F48C: .word 0x00000FA4
	thumb_func_end Task__OVL03Unknown215EE60__Main

	thumb_func_start StageSelectMenu__Func_215F490
StageSelectMenu__Func_215F490: // 0x0215F490
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x18
	ldr r0, _0215F678 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r6, r0
	mov r4, #0
	bl StageSelectMenu__Func_215E134
	cmp r0, #0
	beq _0215F4AA
	b _0215F4AA
_0215F4AA:
	ldr r0, _0215F67C // =0x000013CC
	ldr r1, [r6, r0]
	sub r1, r1, #1
	str r1, [r6, r0]
	ldr r1, _0215F67C // =0x000013CC
	ldr r0, [r6, r1]
	cmp r0, #0
	ble _0215F4BC
	b _0215F672
_0215F4BC:
	sub r0, r1, #4
	ldr r0, [r6, r0]
	cmp r0, #1
	beq _0215F4CA
	cmp r0, #2
	beq _0215F522
	b _0215F578
_0215F4CA:
	add r1, #8
	ldrh r1, [r6, r1]
	mov r0, #6
	tst r0, r1
	beq _0215F578
	mov r0, #0x20
	tst r0, r1
	beq _0215F4DE
	mov r0, #5
	b _0215F4E0
_0215F4DE:
	mov r0, #4
_0215F4E0:
	lsl r0, r0, #0x10
	mov r1, #1
	lsr r0, r0, #0x10
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	mov r4, r0
	ldr r0, _0215F680 // =0x000013D4
	ldrh r2, [r6, r0]
	mov r0, #2
	mov r3, r2
	and r3, r0
	beq _0215F508
	mov r0, #4
	mov r1, r2
	tst r1, r0
	bne _0215F508
	add r0, #0xfc
	strh r0, [r4, #8]
	b _0215F578
_0215F508:
	cmp r3, #0
	bne _0215F51A
	mov r0, #4
	mov r1, r2
	tst r1, r0
	beq _0215F51A
	lsl r0, r0, #7
	strh r0, [r4, #8]
	b _0215F578
_0215F51A:
	mov r0, #0xc
	bl FadeSysTrack
	b _0215F578
_0215F522:
	add r1, #8
	ldrh r1, [r6, r1]
	mov r0, #0x18
	tst r0, r1
	beq _0215F578
	mov r0, #0x40
	tst r0, r1
	beq _0215F536
	mov r0, #5
	b _0215F538
_0215F536:
	mov r0, #4
_0215F538:
	lsl r0, r0, #0x10
	mov r1, #1
	lsr r0, r0, #0x10
	lsl r1, r1, #0xc
	bl CreateDrawFadeTask
	mov r4, r0
	ldr r0, _0215F680 // =0x000013D4
	ldrh r2, [r6, r0]
	mov r0, #8
	mov r3, r2
	and r3, r0
	beq _0215F560
	mov r0, #0x10
	mov r1, r2
	tst r1, r0
	bne _0215F560
	add r0, #0xf0
	strh r0, [r4, #8]
	b _0215F578
_0215F560:
	cmp r3, #0
	bne _0215F572
	mov r0, #0x10
	mov r1, r2
	tst r1, r0
	beq _0215F572
	lsl r0, r0, #5
	strh r0, [r4, #8]
	b _0215F578
_0215F572:
	mov r0, #0xc
	bl FadeSysTrack
_0215F578:
	cmp r4, #0
	beq _0215F586
	ldr r0, _0215F684 // =StageSelectMenu__Func_215F6A8
	bl SetCurrentTaskMainEvent
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}
_0215F586:
	mov r1, #0x28
	str r1, [sp]
	mov r2, #9
	str r2, [sp, #4]
	str r1, [sp, #8]
	mov r1, r2
	sub r1, #0x22
	str r1, [sp, #0xc]
	ldr r1, _0215F688 // =0x00003042
	ldr r0, _0215F68C // =0x000005C8
	str r1, [sp, #0x10]
	mov r1, #0
	str r1, [sp, #0x14]
	add r0, r6, r0
	ldr r1, _0215F690 // =0xFFFFF000
	add r0, #8
	add r2, #0xf7
	mov r3, #0xc
	bl StageSelectMover__Create
	mov r0, #0x20
	str r0, [sp]
	mov r2, #4
	str r2, [sp, #4]
	str r0, [sp, #8]
	mov r0, r2
	sub r0, #0x22
	str r0, [sp, #0xc]
	ldr r0, _0215F688 // =0x00003042
	ldr r1, _0215F690 // =0xFFFFF000
	str r0, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	ldr r0, _0215F694 // =0x00000634
	add r2, #0xfc
	add r0, r6, r0
	mov r3, #0xc
	bl StageSelectMover__Create
	ldr r0, _0215F698 // =0x00000FDC
	ldr r7, _0215F688 // =0x00003042
	add r5, r6, r0
	mov r4, #1
	add r5, #0xb0
_0215F5DE:
	cmp r4, #1
	ldr r1, _0215F690 // =0xFFFFF000
	bne _0215F608
	mov r0, #8
	str r0, [sp]
	str r0, [sp, #4]
	sub r0, #0x20
	str r0, [sp, #8]
	mov r0, #8
	str r0, [sp, #0xc]
	mov r2, #1
	str r7, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	mov r0, r5
	add r0, #8
	lsl r2, r2, #8
	mov r3, #4
	bl StageSelectMover__Create
	b _0215F62E
_0215F608:
	mov r0, #0xf8
	str r0, [sp]
	mov r0, #8
	str r0, [sp, #4]
	mov r0, #0x46
	lsl r0, r0, #2
	str r0, [sp, #8]
	mov r0, #8
	str r0, [sp, #0xc]
	mov r2, #1
	str r7, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	mov r0, r5
	add r0, #8
	lsl r2, r2, #8
	mov r3, #4
	bl StageSelectMover__Create
_0215F62E:
	add r4, r4, #1
	add r5, #0xb0
	cmp r4, #2
	ble _0215F5DE
	mov r0, #0x10
	str r0, [sp]
	mov r2, #0xb0
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r0, _0215F688 // =0x00003042
	ldr r1, _0215F690 // =0xFFFFF000
	str r0, [sp, #0x10]
	ldr r0, _0215F69C // =0x00000FE4
	mov r3, #0
	add r0, r6, r0
	add r2, #0x50
	str r3, [sp, #0x14]
	bl StageSelectMover__Create
	ldr r0, _0215F6A0 // =0x000013D8
	mov r1, #0
	str r1, [r6, r0]
	sub r0, r0, #4
	ldrh r1, [r6, r0]
	mov r0, #0x80
	tst r0, r1
	beq _0215F66C
	add r0, r6, #4
	bl TimeAttackRankList__Func_216FA44
_0215F66C:
	ldr r0, _0215F6A4 // =StageSelectMenu__Func_215F6F8
	bl SetCurrentTaskMainEvent
_0215F672:
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0215F678: .word StageSelectMenu__Singleton
_0215F67C: .word 0x000013CC
_0215F680: .word 0x000013D4
_0215F684: .word StageSelectMenu__Func_215F6A8
_0215F688: .word 0x00003042
_0215F68C: .word 0x000005C8
_0215F690: .word 0xFFFFF000
_0215F694: .word 0x00000634
_0215F698: .word 0x00000FDC
_0215F69C: .word 0x00000FE4
_0215F6A0: .word 0x000013D8
_0215F6A4: .word StageSelectMenu__Func_215F6F8
	thumb_func_end StageSelectMenu__Func_215F490

	thumb_func_start StageSelectMenu__Func_215F6A8
StageSelectMenu__Func_215F6A8: // 0x0215F6A8
	push {r4, lr}
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	beq _0215F6EC
	ldr r0, _0215F6F0 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _0215F6F4 // =0x000013C8
	ldr r1, [r4, #0]
	ldr r2, [r4, r0]
	add r1, #0x94
	str r2, [r1]
	ldr r1, [r4, r0]
	cmp r1, #1
	bne _0215F6E4
	add r0, #0x18
	ldr r0, [r4, r0]
	bl StageSelectMenu__Func_215E2A0
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	cmp r0, #2
	bne _0215F6E4
	ldr r0, [r4, #0]
	mov r1, #3
	add r0, #0x94
	str r1, [r0]
_0215F6E4:
	bl DestroyDrawFadeTask
	bl DestroyCurrentTask
_0215F6EC:
	pop {r4, pc}
	nop
_0215F6F0: .word StageSelectMenu__Singleton
_0215F6F4: .word 0x000013C8
	thumb_func_end StageSelectMenu__Func_215F6A8

	thumb_func_start StageSelectMenu__Func_215F6F8
StageSelectMenu__Func_215F6F8: // 0x0215F6F8
	push {r4, lr}
	ldr r0, _0215F72C // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl StageSelectMenu__Func_215E134
	cmp r0, #0
	beq _0215F70E
	b _0215F70E
_0215F70E:
	ldr r0, _0215F730 // =0x000013D8
	ldr r1, [r4, r0]
	add r1, r1, #1
	str r1, [r4, r0]
	ldr r0, _0215F730 // =0x000013D8
	ldr r1, [r4, r0]
	cmp r1, #0x1c
	blt _0215F728
	mov r1, #0
	str r1, [r4, r0]
	ldr r0, _0215F734 // =StageSelectMenu__Func_215F738
	bl SetCurrentTaskMainEvent
_0215F728:
	pop {r4, pc}
	nop
_0215F72C: .word StageSelectMenu__Singleton
_0215F730: .word 0x000013D8
_0215F734: .word StageSelectMenu__Func_215F738
	thumb_func_end StageSelectMenu__Func_215F6F8

	thumb_func_start StageSelectMenu__Func_215F738
StageSelectMenu__Func_215F738: // 0x0215F738
	push {r4, lr}
	ldr r0, _0215F7C4 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl StageSelectMenu__Func_215E134
	cmp r0, #0
	beq _0215F74E
	b _0215F74E
_0215F74E:
	ldr r0, _0215F7C8 // =0x000013D8
	ldr r1, [r4, r0]
	add r1, r1, #1
	str r1, [r4, r0]
	ldr r0, _0215F7C8 // =0x000013D8
	ldr r1, [r4, r0]
	cmp r1, #0x10
	ble _0215F7A4
	sub r0, #8
	ldr r0, [r4, r0]
	cmp r0, #1
	ldr r0, _0215F7CC // =0xFFFFE0FF
	beq _0215F778
	mov r2, #1
	lsl r2, r2, #0x1a
	ldr r1, [r2, #0]
	and r1, r0
	lsr r0, r2, #0xf
	orr r0, r1
	str r0, [r2]
	b _0215F784
_0215F778:
	ldr r2, _0215F7D0 // =0x04001000
	ldr r1, [r2, #0]
	and r1, r0
	lsr r0, r2, #0xf
	orr r0, r1
	str r0, [r2]
_0215F784:
	ldr r0, _0215F7D4 // =0x000013D4
	mov r1, #0x80
	ldrh r2, [r4, r0]
	tst r1, r2
	bne _0215F79E
	sub r0, #0xc
	ldr r1, [r4, r0]
	ldr r0, [r4, #0]
	add r0, #0x94
	str r1, [r0]
	bl DestroyCurrentTask
	b _0215F7A4
_0215F79E:
	ldr r0, _0215F7D8 // =StageSelectMenu__Func_215F7E4
	bl SetCurrentTaskMainEvent
_0215F7A4:
	ldr r2, _0215F7C8 // =0x000013D8
	mov r0, #0
	ldr r2, [r4, r2]
	mov r1, #0xc0
	lsl r3, r2, #0xc
	asr r2, r3, #3
	lsr r2, r2, #0x1c
	add r2, r3, r2
	lsl r2, r2, #0xc
	ldr r3, _0215F7DC // =0xFFFFF000
	asr r2, r2, #0x10
	bl Task__Unknown204BE48__LerpValue
	ldr r1, _0215F7E0 // =0x000005C6
	strh r0, [r4, r1]
	pop {r4, pc}
	.align 2, 0
_0215F7C4: .word StageSelectMenu__Singleton
_0215F7C8: .word 0x000013D8
_0215F7CC: .word 0xFFFFE0FF
_0215F7D0: .word 0x04001000
_0215F7D4: .word 0x000013D4
_0215F7D8: .word StageSelectMenu__Func_215F7E4
_0215F7DC: .word 0xFFFFF000
_0215F7E0: .word 0x000005C6
	thumb_func_end StageSelectMenu__Func_215F738

	thumb_func_start StageSelectMenu__Func_215F7E4
StageSelectMenu__Func_215F7E4: // 0x0215F7E4
	push {r4, lr}
	ldr r0, _0215F80C // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #4
	bl TimeAttackRankList__Func_216FABC
	cmp r0, #0
	beq _0215F808
	ldr r0, _0215F810 // =0x000013C8
	ldr r1, [r4, r0]
	ldr r0, [r4, #0]
	add r0, #0x94
	str r1, [r0]
	bl DestroyCurrentTask
_0215F808:
	pop {r4, pc}
	nop
_0215F80C: .word StageSelectMenu__Singleton
_0215F810: .word 0x000013C8
	thumb_func_end StageSelectMenu__Func_215F7E4

	thumb_func_start Task__OVL03Unknown215DCCC__Main
Task__OVL03Unknown215DCCC__Main: // 0x0215F814
	push {r4, r5, r6, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, _0215F8A0 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215F82A
	bl DestroyCurrentTask
	pop {r4, r5, r6, pc}
_0215F82A:
	bl GetTaskWork_
	ldr r1, _0215F8A4 // =0x000013E0
	ldr r0, [r0, r1]
	bl StageSelectMenu__Func_215DDB4
	ldr r1, [r4, #0]
	cmp r1, r0
	beq _0215F842
	ldr r0, _0215F8A8 // =Task__Unknown215DCCC__Main_215F8B8
	bl SetCurrentTaskMainEvent
_0215F842:
	mov r0, #2
	ldr r1, [r4, #4]
	lsl r0, r0, #0xa
	add r2, r1, r0
	lsl r1, r0, #5
	str r2, [r4, #4]
	cmp r2, r1
	ble _0215F856
	lsl r0, r0, #5
	str r0, [r4, #4]
_0215F856:
	ldr r0, [r4, #4]
	ldr r2, _0215F8AC // =VRAMSystem__GFXControl
	asr r3, r0, #0xc
	ldr r0, [r4, #8]
	mov r5, #0x1f
	lsl r0, r0, #2
	ldr r1, [r2, r0]
	ldrh r0, [r1, #0x22]
	bic r0, r5
	lsl r5, r3, #0x10
	lsr r6, r5, #0x10
	mov r5, #0x1f
	and r5, r6
	orr r0, r5
	strh r0, [r1, #0x22]
	ldr r0, [r4, #8]
	lsl r0, r0, #2
	ldr r1, [r2, r0]
	ldr r0, _0215F8B0 // =0xFFFFE0FF
	ldrh r2, [r1, #0x22]
	and r0, r2
	mov r2, #0x10
	sub r3, r2, r3
	lsl r3, r3, #0x10
	lsr r3, r3, #0x10
	lsl r3, r3, #0x1b
	lsr r3, r3, #0x13
	orr r0, r3
	strh r0, [r1, #0x22]
	ldr r1, [r4, #4]
	lsl r0, r2, #0xc
	cmp r1, r0
	bne _0215F89E
	ldr r0, _0215F8B4 // =Task__Unknown215DCCC__Main_215F9E4
	bl SetCurrentTaskMainEvent
_0215F89E:
	pop {r4, r5, r6, pc}
	.align 2, 0
_0215F8A0: .word StageSelectMenu__Singleton
_0215F8A4: .word 0x000013E0
_0215F8A8: .word Task__Unknown215DCCC__Main_215F8B8
_0215F8AC: .word VRAMSystem__GFXControl
_0215F8B0: .word 0xFFFFE0FF
_0215F8B4: .word Task__Unknown215DCCC__Main_215F9E4
	thumb_func_end Task__OVL03Unknown215DCCC__Main

	thumb_func_start Task__Unknown215DCCC__Main_215F8B8
Task__Unknown215DCCC__Main_215F8B8: // 0x0215F8B8
	push {r3, r4, r5, r6, r7, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, _0215F9C0 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215F8CE
	bl DestroyCurrentTask
	pop {r3, r4, r5, r6, r7, pc}
_0215F8CE:
	bl GetTaskWork_
	mov r5, r0
	ldr r0, _0215F9C4 // =0x000013E0
	ldr r0, [r5, r0]
	bl StageSelectMenu__Func_215DDB4
	mov r6, r0
	ldr r0, [r4, #0]
	cmp r0, r6
	bne _0215F8EA
	ldr r0, _0215F9C8 // =Task__OVL03Unknown215DCCC__Main
	bl SetCurrentTaskMainEvent
_0215F8EA:
	mov r0, #2
	ldr r1, [r4, #4]
	lsl r0, r0, #0xc
	sub r0, r1, r0
	str r0, [r4, #4]
	bpl _0215F8FA
	mov r0, #0
	str r0, [r4, #4]
_0215F8FA:
	ldr r0, [r4, #4]
	asr r3, r0, #0xc
	ldr r0, [r4, #8]
	lsl r1, r0, #2
	ldr r0, _0215F9CC // =VRAMSystem__GFXControl
	ldr r7, [r0, r1]
	mov r0, #0x1f
	ldrh r2, [r7, #0x22]
	bic r2, r0
	lsl r0, r3, #0x10
	lsr r1, r0, #0x10
	mov r0, #0x1f
	and r0, r1
	orr r0, r2
	strh r0, [r7, #0x22]
	ldr r0, [r4, #8]
	lsl r1, r0, #2
	ldr r0, _0215F9CC // =VRAMSystem__GFXControl
	ldr r1, [r0, r1]
	ldr r0, _0215F9D0 // =0xFFFFE0FF
	ldrh r2, [r1, #0x22]
	and r0, r2
	mov r2, #0x10
	sub r2, r2, r3
	lsl r2, r2, #0x10
	lsr r2, r2, #0x10
	lsl r2, r2, #0x1b
	lsr r2, r2, #0x13
	orr r0, r2
	strh r0, [r1, #0x22]
	ldr r0, [r4, #4]
	cmp r0, #0
	bne _0215F9BE
	ldr r1, _0215F9D4 // =0x0217DB9F
	lsl r2, r6, #1
	mov r0, #0x69
	lsl r0, r0, #4
	ldrb r1, [r1, r2]
	add r0, r5, r0
	str r6, [r4]
	bl AnimatorSprite__SetAnimation
	ldr r0, _0215F9D8 // =0x000013D4
	ldrh r1, [r5, r0]
	mov r0, #0x80
	tst r0, r1
	bne _0215F9B8
	mov r1, r6
	mov r0, #0x82
	add r1, #0x60
	lsl r0, r0, #4
	lsl r1, r1, #0x10
	add r0, r5, r0
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	cmp r6, #0xa
	blo _0215F972
	cmp r6, #0xd
	bne _0215F97E
_0215F972:
	ldr r0, _0215F9DC // =0x00000884
	mov r1, #0x5f
	add r0, r5, r0
	bl AnimatorSprite__SetAnimation
	b _0215F988
_0215F97E:
	ldr r0, _0215F9DC // =0x00000884
	mov r1, #0x60
	add r0, r5, r0
	bl AnimatorSprite__SetAnimation
_0215F988:
	cmp r6, #9
	ldr r2, _0215F9E0 // =0x0000085C
	bne _0215F9A4
	ldr r0, [r5, r2]
	mov r1, #1
	orr r0, r1
	str r0, [r5, r2]
	mov r0, r2
	add r0, #0x64
	ldr r0, [r5, r0]
	add r2, #0x64
	orr r0, r1
	str r0, [r5, r2]
	b _0215F9B8
_0215F9A4:
	ldr r0, [r5, r2]
	mov r1, #1
	bic r0, r1
	str r0, [r5, r2]
	mov r0, r2
	add r0, #0x64
	ldr r0, [r5, r0]
	add r2, #0x64
	bic r0, r1
	str r0, [r5, r2]
_0215F9B8:
	ldr r0, _0215F9C8 // =Task__OVL03Unknown215DCCC__Main
	bl SetCurrentTaskMainEvent
_0215F9BE:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215F9C0: .word StageSelectMenu__Singleton
_0215F9C4: .word 0x000013E0
_0215F9C8: .word Task__OVL03Unknown215DCCC__Main
_0215F9CC: .word VRAMSystem__GFXControl
_0215F9D0: .word 0xFFFFE0FF
_0215F9D4: .word 0x0217DB9F
_0215F9D8: .word 0x000013D4
_0215F9DC: .word 0x00000884
_0215F9E0: .word 0x0000085C
	thumb_func_end Task__Unknown215DCCC__Main_215F8B8

	thumb_func_start Task__Unknown215DCCC__Main_215F9E4
Task__Unknown215DCCC__Main_215F9E4: // 0x0215F9E4
	push {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	ldr r0, _0215FA28 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215F9FA
	bl DestroyCurrentTask
	pop {r3, r4, r5, pc}
_0215F9FA:
	bl GetTaskWork_
	mov r4, r0
	ldr r0, _0215FA2C // =0x000013E0
	ldr r0, [r4, r0]
	bl StageSelectMenu__Func_215DDB4
	mov r1, r0
	ldr r0, [r5, #0]
	cmp r0, r1
	beq _0215FA24
	lsl r2, r1, #1
	ldr r1, _0215FA30 // =0x0217DB9E
	ldr r0, _0215FA34 // =0x000005C8
	ldrb r1, [r1, r2]
	add r0, r4, r0
	bl AnimatorSprite__SetAnimation
	ldr r0, _0215FA38 // =Task__Unknown215DCCC__Main_215F8B8
	bl SetCurrentTaskMainEvent
_0215FA24:
	pop {r3, r4, r5, pc}
	nop
_0215FA28: .word StageSelectMenu__Singleton
_0215FA2C: .word 0x000013E0
_0215FA30: .word 0x0217DB9E
_0215FA34: .word 0x000005C8
_0215FA38: .word Task__Unknown215DCCC__Main_215F8B8
	thumb_func_end Task__Unknown215DCCC__Main_215F9E4

	thumb_func_start StageSelectMover__Main
StageSelectMover__Main: // 0x0215FA3C
	push {r3, r4, lr}
	sub sp, #0xc
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, _0215FAC0 // =StageSelectMenu__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0215FA56
	bl DestroyCurrentTask
	add sp, #0xc
	pop {r3, r4, pc}
_0215FA56:
	mov r0, #0x1a
	ldrsh r3, [r4, r0]
	mov r0, #1
	lsl r0, r0, #0xc
	cmp r3, r0
	blt _0215FA7A
	ldr r0, [r4, #0x10]
	asr r1, r0, #0xc
	ldr r0, [r4, #0]
	strh r1, [r0]
	ldr r0, [r4, #0x14]
	asr r1, r0, #0xc
	ldr r0, [r4, #0]
	strh r1, [r0, #2]
	bl DestroyCurrentTask
	add sp, #0xc
	pop {r3, r4, pc}
_0215FA7A:
	mov r0, #0x18
	ldrsh r0, [r4, r0]
	mov r1, r4
	mov r2, r4
	str r0, [sp]
	add r0, sp, #4
	add r1, #8
	add r2, #0x10
	bl Task__Unknown204BE48__LerpVec2
	ldr r0, [sp, #4]
	asr r1, r0, #0xc
	ldr r0, [r4, #0]
	strh r1, [r0]
	ldr r0, [sp, #8]
	asr r1, r0, #0xc
	ldr r0, [r4, #0]
	strh r1, [r0, #2]
	ldrh r0, [r4, #4]
	cmp r0, #0
	beq _0215FAAA
	sub r0, r0, #1
	strh r0, [r4, #4]
	b _0215FAB6
_0215FAAA:
	mov r0, #0x1a
	ldrsh r1, [r4, r0]
	mov r0, #0x1c
	ldrsh r0, [r4, r0]
	add r0, r1, r0
	strh r0, [r4, #0x1a]
_0215FAB6:
	bl StageSelectMenu__Func_215E134
	add sp, #0xc
	pop {r3, r4, pc}
	nop
_0215FAC0: .word StageSelectMenu__Singleton
	thumb_func_end StageSelectMover__Main

	thumb_func_start StageSelectMenu__Func_215FAC4
StageSelectMenu__Func_215FAC4: // 0x0215FAC4
	push {r3, lr}
	mov r2, r1
	sub r2, #8
	cmp r2, #1
	bhi _0215FADE
	ldr r1, _0215FB00 // =0x000011B4
	mov r2, #0x24
	add r0, r0, r1
	mov r1, #0x22
	mov r3, #0x23
	bl StageSelectMenu__ConfigureButton
	pop {r3, pc}
_0215FADE:
	cmp r1, #9
	ldr r1, _0215FB00 // =0x000011B4
	bls _0215FAF2
	add r0, r0, r1
	mov r1, #0x31
	mov r2, #0x33
	mov r3, #0x32
	bl StageSelectMenu__ConfigureButton
	pop {r3, pc}
_0215FAF2:
	add r0, r0, r1
	mov r1, #0x1c
	mov r2, #0x1e
	mov r3, #0x1d
	bl StageSelectMenu__ConfigureButton
	pop {r3, pc}
	.align 2, 0
_0215FB00: .word 0x000011B4
	thumb_func_end StageSelectMenu__Func_215FAC4

	.data
	
aBbDmasBb: // 0x0217E970
	.asciz "/bb/dmas.bb"
	.align 4
	
aBbNlBb_1: // 0x0217E97C
	.asciz "/bb/nl.bb"
	.align 4
	
aFntFontIplFnt_ovl03: // 0x0217E988
	.asciz "/fnt/font_ipl.fnt"
	.align 4