	.include "asm/macros.inc"
	.include "global.inc"

.public VSLobbyMenu__sVars

	.text

	thumb_func_start VSState__AllocAssets
VSState__AllocAssets: // 0x02162C58
	push {r3, lr}
	ldr r0, _02162C70 // =0x0000062C
	bl _AllocHeadHEAP_SYSTEM
	mov r1, r0
	ldr r0, _02162C74 // =VSLobbyMenu__sVars
	ldr r2, _02162C70 // =0x0000062C
	str r1, [r0]
	mov r0, #0
	bl MIi_CpuClear16
	pop {r3, pc}
	.align 2, 0
_02162C70: .word 0x0000062C
_02162C74: .word VSLobbyMenu__sVars
	thumb_func_end VSState__AllocAssets

	thumb_func_start VSState__LoadAssets
VSState__LoadAssets: // 0x02162C78
	push {r4, lr}
	sub sp, #0x10
	ldr r4, _02162D08 // =VSLobbyMenu__sVars
	ldr r4, [r4, #0]
	str r0, [r4, #4]
	str r1, [r4, #8]
	strb r2, [r4, #0xc]
	strb r3, [r4, #0xd]
	mov r0, #1
	ldr r1, [r4, #4]
	lsl r0, r0, #0x1e
	tst r0, r1
	beq _02162CA2
	mov r3, #0
	ldr r0, _02162D0C // =aNarcDmvsUinfoN
	sub r1, r3, #1
	sub r2, r3, #2
	str r3, [sp]
	bl ArchiveFile__Load
	b _02162CB0
_02162CA2:
	mov r3, #0
	sub r1, r3, #1
	ldr r0, _02162D0C // =aNarcDmvsUinfoN
	mov r2, r1
	str r3, [sp]
	bl ArchiveFile__Load
_02162CB0:
	str r0, [r4, #0x14]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _02162CDC
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02162CC8: // jump table
	.hword _02162CD4 - _02162CC8 - 2 // case 0
	.hword _02162CD4 - _02162CC8 - 2 // case 1
	.hword _02162CD4 - _02162CC8 - 2 // case 2
	.hword _02162CD4 - _02162CC8 - 2 // case 3
	.hword _02162CD4 - _02162CC8 - 2 // case 4
	.hword _02162CD4 - _02162CC8 - 2 // case 5
_02162CD4:
	bl RenderCore_GetLanguagePtr
	ldrb r1, [r0, #0]
	b _02162CDE
_02162CDC:
	mov r1, #1
_02162CDE:
	ldr r0, _02162D10 // =aDmwlStateBac
	lsl r1, r1, #2
	str r0, [sp]
	mov r0, r4
	add r0, #0x20
	str r0, [sp, #4]
	ldr r0, _02162D14 // =0x0217EBEC
	ldr r2, _02162D18 // =aDmcmnTerMtBac
	ldr r0, [r0, r1]
	mov r1, r4
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	ldr r0, [r4, #0x14]
	add r4, #0x1c
	add r1, #0x18
	mov r3, r4
	bl StageClear__LoadFiles
	add sp, #0x10
	pop {r4, pc}
	.align 2, 0
_02162D08: .word VSLobbyMenu__sVars
_02162D0C: .word aNarcDmvsUinfoN
_02162D10: .word aDmwlStateBac
_02162D14: .word 0x0217EBEC
_02162D18: .word aDmcmnTerMtBac
	thumb_func_end VSState__LoadAssets

	thumb_func_start VSState__ReleaseAssets
VSState__ReleaseAssets: // 0x02162D1C
	push {r4, lr}
	ldr r0, _02162D74 // =VSLobbyMenu__sVars
	ldr r4, [r0, #0]
	mov r0, r4
	bl VSState__Func_2163A88
	cmp r0, #0
	beq _02162D48
	mov r0, #0x5f
	lsl r0, r0, #4
	add r0, r4, r0
	bl Unknown2056570__Func_2056670
	mov r0, #0x62
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	bl _FreeHEAP_SYSTEM
	mov r0, #0x62
	mov r1, #0
	lsl r0, r0, #4
	str r1, [r4, r0]
_02162D48:
	mov r0, #1
	ldr r1, [r4, #4]
	lsl r0, r0, #0x1e
	tst r0, r1
	ldr r0, [r4, #0x14]
	beq _02162D5A
	bl _FreeHEAP_SYSTEM
	b _02162D5E
_02162D5A:
	bl _FreeHEAP_USER
_02162D5E:
	mov r0, #0
	str r0, [r4, #0x14]
	ldr r0, _02162D74 // =VSLobbyMenu__sVars
	ldr r0, [r0, #0]
	bl _FreeHEAP_SYSTEM
	ldr r0, _02162D74 // =VSLobbyMenu__sVars
	mov r1, #0
	str r1, [r0]
	pop {r4, pc}
	nop
_02162D74: .word VSLobbyMenu__sVars
	thumb_func_end VSState__ReleaseAssets

	thumb_func_start VSState__InitSprites
VSState__InitSprites: // 0x02162D78
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x38
	ldr r1, _021630D8 // =VSLobbyMenu__sVars
	ldr r4, [r1, #0]
	mov r1, #1
	ldr r2, [r4, #4]
	lsl r1, r1, #0x1e
	and r1, r2
	orr r0, r1
	str r0, [r4, #4]
	mov r0, #1
	mov r6, r4
	str r0, [r4]
	add r6, #0x14
	mov r5, r4
	ldr r0, [r6, #4]
	ldr r1, [r4, #8]
	mov r2, #0
	add r5, #0x24
	bl SpriteUnknown__Func_204C3CC
	ldr r1, [r4, #8]
	mov r2, #0
	str r1, [sp]
	str r0, [sp, #4]
	str r2, [sp, #8]
	ldrb r0, [r4, #0xc]
	mov r3, #2
	lsl r3, r3, #0xa
	str r0, [sp, #0xc]
	ldrb r0, [r4, #0xd]
	add r0, r0, #1
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	str r0, [sp, #0x10]
	ldr r1, [r6, #4]
	mov r0, r5
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r6, r4
	ldr r1, [r5, #0x3c]
	mov r0, #8
	orr r0, r1
	str r0, [r5, #0x3c]
	mov r5, r4
	add r5, #0x14
	ldr r0, [r5, #4]
	ldr r1, [r4, #8]
	mov r2, #6
	add r6, #0x88
	bl SpriteUnknown__Func_204C3CC
	ldr r1, [r4, #8]
	mov r3, #2
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #0
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	ldrb r0, [r4, #0xd]
	mov r2, #6
	lsl r3, r3, #0xa
	str r0, [sp, #0x10]
	ldr r1, [r5, #4]
	mov r0, r6
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r6, #0x3c]
	mov r0, #8
	orr r0, r1
	str r0, [r6, #0x3c]
	ldr r0, [r5, #4]
	ldr r1, [r4, #8]
	mov r2, #1
	mov r3, #2
	bl SpriteUnknown__Func_204C7A4
	mov r6, r4
	str r0, [sp, #0x24]
	mov r7, #0
	add r6, #0xec
_02162E2E:
	ldr r0, [r4, #8]
	mov r2, #1
	str r0, [sp]
	ldr r0, [sp, #0x24]
	lsl r3, r2, #0xb
	str r0, [sp, #4]
	lsl r0, r7, #0x18
	lsr r0, r0, #0x18
	str r0, [sp, #8]
	ldrb r0, [r4, #0xc]
	str r0, [sp, #0xc]
	ldrb r0, [r4, #0xd]
	add r0, r0, #3
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	str r0, [sp, #0x10]
	ldr r1, [r5, #4]
	add r0, r6, #4
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	add r0, r6, #4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r6, #0x40]
	mov r0, #8
	orr r0, r1
	str r0, [r6, #0x40]
	mov r0, #0xa
	lsl r0, r0, #6
	add r7, r7, #1
	add r6, r6, r0
	cmp r7, #2
	blo _02162E2E
	ldr r0, [r5, #8]
	ldr r1, [r4, #8]
	mov r2, #4
	mov r3, #0xc
	bl SpriteUnknown__Func_204C7A4
	str r0, [sp, #0x28]
	ldr r0, _021630DC // =0x000005EC
	mov r6, r4
	add r6, #0xec
	add r0, r4, r0
	cmp r6, r0
	beq _02162EC4
	ldr r0, _021630DC // =0x000005EC
	add r7, r4, r0
_02162E92:
	ldr r0, [r4, #8]
	mov r2, #4
	str r0, [sp]
	ldr r0, [sp, #0x28]
	lsl r3, r2, #9
	str r0, [sp, #4]
	mov r0, #2
	str r0, [sp, #8]
	ldrb r0, [r4, #0xc]
	str r0, [sp, #0xc]
	ldrb r0, [r4, #0xd]
	add r0, r0, #2
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	str r0, [sp, #0x10]
	mov r0, r6
	ldr r1, [r5, #8]
	add r0, #0x68
	bl SpriteUnknown__Func_204C90C
	mov r0, #0xa
	lsl r0, r0, #6
	add r6, r6, r0
	cmp r6, r7
	bne _02162E92
_02162EC4:
	ldr r0, [r5, #8]
	ldr r1, [r4, #8]
	mov r2, #2
	mov r3, #3
	bl SpriteUnknown__Func_204C7A4
	str r0, [sp, #0x2c]
	ldr r0, _021630DC // =0x000005EC
	mov r6, r4
	add r6, #0xec
	add r0, r4, r0
	cmp r6, r0
	beq _02162F14
	ldr r0, _021630DC // =0x000005EC
	add r7, r4, r0
_02162EE2:
	ldr r0, [r4, #8]
	mov r2, #2
	str r0, [sp]
	ldr r0, [sp, #0x2c]
	lsl r3, r2, #0xa
	str r0, [sp, #4]
	mov r0, #2
	str r0, [sp, #8]
	ldrb r0, [r4, #0xc]
	str r0, [sp, #0xc]
	ldrb r0, [r4, #0xd]
	add r0, r0, #2
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	str r0, [sp, #0x10]
	mov r0, r6
	ldr r1, [r5, #8]
	add r0, #0xcc
	bl SpriteUnknown__Func_204C90C
	mov r0, #0xa
	lsl r0, r0, #6
	add r6, r6, r0
	cmp r6, r7
	bne _02162EE2
_02162F14:
	ldr r0, [r5, #0xc]
	ldr r1, [r4, #8]
	bl SpriteUnknown__GetSpriteSize
	str r0, [sp, #0x30]
	ldr r0, _021630DC // =0x000005EC
	mov r6, r4
	add r6, #0xec
	add r0, r4, r0
	cmp r6, r0
	beq _02162F64
	ldr r0, _021630DC // =0x000005EC
	add r7, r4, r0
_02162F2E:
	ldr r0, [r4, #8]
	mov r3, #2
	str r0, [sp]
	ldr r0, [sp, #0x30]
	mov r2, #0
	str r0, [sp, #4]
	mov r0, #2
	str r0, [sp, #8]
	ldrb r0, [r4, #0xc]
	lsl r3, r3, #0xa
	str r0, [sp, #0xc]
	ldrb r0, [r4, #0xd]
	add r0, r0, #2
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	str r0, [sp, #0x10]
	mov r0, #0x13
	lsl r0, r0, #4
	ldr r1, [r5, #0xc]
	add r0, r6, r0
	bl SpriteUnknown__Func_204C90C
	mov r0, #0xa
	lsl r0, r0, #6
	add r6, r6, r0
	cmp r6, r7
	bne _02162F2E
_02162F64:
	ldr r1, [r4, #4]
	mov r0, #1
	tst r0, r1
	bne _02162FF0
	mov r0, #0xa
	lsl r0, r0, #6
	add r6, r4, r0
	ldr r0, [r5, #8]
	ldr r1, [r4, #8]
	mov r2, #0x24
	bl SpriteUnknown__Func_204C3CC
	ldr r1, [r4, #8]
	mov r3, #2
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #3
	str r0, [sp, #8]
	ldrb r0, [r4, #0xc]
	mov r2, #0x24
	lsl r3, r3, #0xa
	str r0, [sp, #0xc]
	ldrb r0, [r4, #0xd]
	str r0, [sp, #0x10]
	ldr r1, [r5, #8]
	mov r0, r6
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r6, #0x3c]
	mov r0, #8
	orr r0, r1
	str r0, [r6, #0x3c]
	mov r0, #5
	lsl r0, r0, #8
	add r6, r4, r0
	ldr r0, [r5, #8]
	ldr r1, [r4, #8]
	mov r2, #0x25
	bl SpriteUnknown__Func_204C3CC
	ldr r1, [r4, #8]
	mov r3, #2
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #3
	str r0, [sp, #8]
	ldrb r0, [r4, #0xc]
	mov r2, #0x25
	lsl r3, r3, #0xa
	str r0, [sp, #0xc]
	ldrb r0, [r4, #0xd]
	str r0, [sp, #0x10]
	ldr r1, [r5, #8]
	mov r0, r6
	bl SpriteUnknown__Func_204C90C
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r6, #0x3c]
	mov r0, #8
	orr r0, r1
	str r0, [r6, #0x3c]
_02162FF0:
	ldr r0, [r5, #8]
	ldr r1, [r4, #8]
	mov r2, #0
	mov r3, #1
	bl SpriteUnknown__Func_204C7A4
	str r0, [sp, #0x34]
	ldr r0, _021630DC // =0x000005EC
	mov r6, r4
	add r6, #0xec
	add r0, r4, r0
	cmp r6, r0
	beq _02163042
	ldr r0, _021630DC // =0x000005EC
	add r7, r4, r0
_0216300E:
	ldr r0, [r4, #8]
	ldr r3, _021630E0 // =0x00000804
	str r0, [sp]
	ldr r0, [sp, #0x34]
	mov r2, #0
	str r0, [sp, #4]
	mov r0, #2
	str r0, [sp, #8]
	ldrb r0, [r4, #0xc]
	str r0, [sp, #0xc]
	ldrb r0, [r4, #0xd]
	add r0, r0, #2
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	str r0, [sp, #0x10]
	mov r0, #0x7e
	lsl r0, r0, #2
	ldr r1, [r5, #8]
	add r0, r6, r0
	bl SpriteUnknown__Func_204C90C
	mov r0, #0xa
	lsl r0, r0, #6
	add r6, r6, r0
	cmp r6, r7
	bne _0216300E
_02163042:
	mov r0, r4
	mov r3, #0x18
	add r0, #0xec
	strh r3, [r0]
	mov r0, r4
	mov r1, #0x3c
	add r0, #0xee
	strh r1, [r0]
	mov r0, #0xdb
	lsl r0, r0, #2
	strh r3, [r4, r0]
	mov r2, #0x6e
	add r0, r0, #2
	strh r2, [r4, r0]
	ldr r0, [r4, #4]
	mov r1, #2
	tst r0, r1
	bne _021630D4
	mov r0, r4
	add r2, #0xaa
	add r0, #0xec
	strh r2, [r0]
	mov r0, #0
	str r0, [sp]
	mov r6, #0x10
	ldr r5, _021630E4 // =Task__Unknown204BE48__LerpValue
	str r6, [sp, #4]
	str r5, [sp, #8]
	lsl r5, r6, #8
	str r5, [sp, #0xc]
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	str r0, [sp, #0x1c]
	str r0, [sp, #0x20]
	mov r0, r4
	add r0, #0xec
	bl Task__Unknown204BE48__Create
	mov r2, #0x46
	mov r0, #0xdb
	lsl r2, r2, #2
	lsl r0, r0, #2
	strh r2, [r4, r0]
	mov r1, #8
	str r1, [sp]
	mov r3, r6
	str r3, [sp, #4]
	ldr r1, _021630E4 // =Task__Unknown204BE48__LerpValue
	add r0, r4, r0
	str r1, [sp, #8]
	mov r1, r5
	str r1, [sp, #0xc]
	ldr r1, _021630E8 // =VSState__Func_2163A9C
	mov r3, #0x18
	str r1, [sp, #0x10]
	str r4, [sp, #0x14]
	mov r1, #0
	str r1, [sp, #0x18]
	str r1, [sp, #0x1c]
	str r1, [sp, #0x20]
	mov r1, #2
	bl Task__Unknown204BE48__Create
	ldr r2, _021630EC // =0x00000624
	ldr r3, [r4, r2]
	cmp r3, #0
	beq _021630D4
	add r2, r2, #4
	ldr r2, [r4, r2]
	mov r0, #0
	mov r1, r4
	blx r3
_021630D4:
	add sp, #0x38
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021630D8: .word VSLobbyMenu__sVars
_021630DC: .word 0x000005EC
_021630E0: .word 0x00000804
_021630E4: .word Task__Unknown204BE48__LerpValue
_021630E8: .word VSState__Func_2163A9C
_021630EC: .word 0x00000624
	thumb_func_end VSState__InitSprites

	thumb_func_start VSState__Func_21630F0
VSState__Func_21630F0: // 0x021630F0
	push {r4, r5, lr}
	sub sp, #0x24
	ldr r1, _02163228 // =VSLobbyMenu__sVars
	ldr r4, [r1, #0]
	mov r1, #1
	ldr r2, [r4, #4]
	lsl r1, r1, #0x1e
	and r1, r2
	orr r0, r1
	str r0, [r4, #4]
	mov r0, r4
	bl VSState__NotLoaded
	cmp r0, #0
	beq _02163110
	b _02163222
_02163110:
	ldr r1, _0216322C // =0x000005EC
	mov r0, r4
	add r0, #0xec
	add r1, r4, r1
	cmp r0, r1
	beq _02163132
	ldr r1, _0216322C // =0x000005EC
	mov r5, #0
	add r3, r4, r1
	mov r1, #0x27
	lsl r1, r1, #4
	mov r2, r1
	add r2, #0x10
_0216312A:
	str r5, [r0, r1]
	add r0, r0, r2
	cmp r0, r3
	bne _0216312A
_02163132:
	ldr r1, [r4, #4]
	mov r0, #4
	tst r0, r1
	bne _0216321C
	mov r0, r4
	mov r2, #0x18
	add r0, #0xec
	strh r2, [r0]
	mov r1, #0
	str r1, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	ldr r0, _02163230 // =Task__Unknown204BE48__LerpValue
	mov r3, #0x46
	str r0, [sp, #8]
	ldr r0, _02163234 // =0xFFFFF000
	lsl r3, r3, #2
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	str r1, [sp, #0x18]
	str r1, [sp, #0x1c]
	mov r0, r4
	str r1, [sp, #0x20]
	add r0, #0xec
	mov r1, #2
	bl Task__Unknown204BE48__Create
	mov r3, #0x46
	mov r0, #0xdb
	lsl r3, r3, #2
	lsl r0, r0, #2
	strh r3, [r4, r0]
	mov r1, #8
	str r1, [sp]
	mov r1, #0x10
	str r1, [sp, #4]
	ldr r1, _02163230 // =Task__Unknown204BE48__LerpValue
	add r0, r4, r0
	str r1, [sp, #8]
	ldr r1, _02163234 // =0xFFFFF000
	mov r2, #0x18
	str r1, [sp, #0xc]
	ldr r1, _02163238 // =VSState__Func_2163B2C
	str r1, [sp, #0x10]
	str r4, [sp, #0x14]
	mov r1, #0
	str r1, [sp, #0x18]
	str r1, [sp, #0x1c]
	str r1, [sp, #0x20]
	mov r1, #2
	bl Task__Unknown204BE48__Create
	ldr r2, _0216323C // =0x00000624
	ldr r3, [r4, r2]
	cmp r3, #0
	beq _021631AE
	add r2, r2, #4
	ldr r2, [r4, r2]
	mov r0, #2
	mov r1, r4
	blx r3
_021631AE:
	mov r0, r4
	bl VSState__Func_2163A88
	cmp r0, #0
	beq _02163222
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _021631C6
	cmp r0, #1
	beq _021631F2
	add sp, #0x24
	pop {r4, r5, pc}
_021631C6:
	mov r1, #1
	lsl r1, r1, #0x1a
	ldr r2, [r1, #0]
	mov r0, #0x1f
	lsl r0, r0, #8
	and r0, r2
	lsr r2, r0, #8
	ldr r3, [r1, #0]
	ldr r0, _02163240 // =0xFFFFE0FF
	mov r5, #1
	and r0, r3
	mov r3, #6
	lsl r3, r3, #8
	ldrh r3, [r4, r3]
	mov r4, r5
	add sp, #0x24
	lsl r4, r3
	bic r2, r4
	lsl r2, r2, #8
	orr r0, r2
	str r0, [r1]
	pop {r4, r5, pc}
_021631F2:
	ldr r1, _02163244 // =0x04001000
	mov r0, #0x1f
	ldr r2, [r1, #0]
	lsl r0, r0, #8
	and r0, r2
	lsr r2, r0, #8
	ldr r3, [r1, #0]
	ldr r0, _02163240 // =0xFFFFE0FF
	mov r5, #1
	and r0, r3
	mov r3, #6
	lsl r3, r3, #8
	ldrh r3, [r4, r3]
	mov r4, r5
	add sp, #0x24
	lsl r4, r3
	bic r2, r4
	lsl r2, r2, #8
	orr r0, r2
	str r0, [r1]
	pop {r4, r5, pc}
_0216321C:
	mov r0, r4
	bl VSState__ReleaseAnimators
_02163222:
	add sp, #0x24
	pop {r4, r5, pc}
	nop
_02163228: .word VSLobbyMenu__sVars
_0216322C: .word 0x000005EC
_02163230: .word Task__Unknown204BE48__LerpValue
_02163234: .word 0xFFFFF000
_02163238: .word VSState__Func_2163B2C
_0216323C: .word 0x00000624
_02163240: .word 0xFFFFE0FF
_02163244: .word 0x04001000
	thumb_func_end VSState__Func_21630F0

	thumb_func_start VSState__NotLoaded
VSState__NotLoaded: // 0x02163248
	ldr r0, _0216325C // =VSLobbyMenu__sVars
	ldr r0, [r0, #0]
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02163256
	mov r0, #1
	bx lr
_02163256:
	mov r0, #0
	bx lr
	nop
_0216325C: .word VSLobbyMenu__sVars
	thumb_func_end VSState__NotLoaded

	thumb_func_start VSState__ProcessAnimations
VSState__ProcessAnimations: // 0x02163260
	push {r3, r4, r5, r6, r7, lr}
	ldr r0, _02163390 // =VSLobbyMenu__sVars
	ldr r5, [r0, #0]
	bl VSState__NotLoaded
	cmp r0, #0
	beq _02163270
	b _0216338E
_02163270:
	ldr r0, _02163394 // =0x000005EC
	mov r4, r5
	add r4, #0xec
	add r6, r5, r0
	cmp r4, r6
	bne _0216327E
	b _0216338E
_0216327E:
	mov r0, r5
	mov r7, r5
	str r0, [sp]
	add r0, #0x88
	add r7, #0x24
	str r0, [sp]
_0216328A:
	mov r1, #0
	mov r0, r7
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0
	ldr r0, [sp]
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r5, #4]
	mov r0, #1
	tst r0, r1
	bne _021632B4
	mov r0, #0x65
	lsl r0, r0, #2
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
_021632B4:
	mov r0, #0x27
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	cmp r0, #0xc
	bhi _0216332A
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_021632CA: // jump table
	.hword _021632E4 - _021632CA - 2 // case 0
	.hword _0216332A - _021632CA - 2 // case 1
	.hword _0216332A - _021632CA - 2 // case 2
	.hword _0216332A - _021632CA - 2 // case 3
	.hword _0216332A - _021632CA - 2 // case 4
	.hword _0216332A - _021632CA - 2 // case 5
	.hword _0216332A - _021632CA - 2 // case 6
	.hword _02163310 - _021632CA - 2 // case 7
	.hword _02163310 - _021632CA - 2 // case 8
	.hword _02163310 - _021632CA - 2 // case 9
	.hword _02163310 - _021632CA - 2 // case 10
	.hword _0216332A - _021632CA - 2 // case 11
	.hword _02163310 - _021632CA - 2 // case 12
_021632E4:
	mov r0, #0x9f
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	cmp r0, #0
	ble _02163382
	mov r0, #0x9f
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	mov r0, #2
	lsl r0, r0, #0xa
	sub r1, r1, r0
	mov r0, #0x9f
	lsl r0, r0, #2
	str r1, [r4, r0]
	ldr r0, [r4, r0]
	cmp r0, #0
	bge _02163382
	mov r0, #0x9f
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r4, r0]
	b _02163382
_02163310:
	mov r0, r4
	mov r1, #0
	add r0, #0xcc
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	mov r1, #0
	add r0, #0x68
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	b _02163338
_0216332A:
	mov r0, #0x13
	lsl r0, r0, #4
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
_02163338:
	mov r1, #0
	add r0, r4, #4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x7e
	lsl r0, r0, #2
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x9f
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	mov r0, #0xe
	lsl r0, r0, #0xc
	cmp r1, r0
	bge _02163382
	mov r0, #0x9f
	lsl r0, r0, #2
	ldr r1, [r4, r0]
	mov r0, #2
	lsl r0, r0, #0xa
	add r1, r1, r0
	mov r0, #0x9f
	lsl r0, r0, #2
	str r1, [r4, r0]
	ldr r1, [r4, r0]
	mov r0, #0xe
	lsl r0, r0, #0xc
	cmp r1, r0
	ble _02163382
	mov r1, r0
	mov r0, #0x9f
	lsl r0, r0, #2
	str r1, [r4, r0]
_02163382:
	mov r0, #0xa
	lsl r0, r0, #6
	add r4, r4, r0
	cmp r4, r6
	beq _0216338E
	b _0216328A
_0216338E:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02163390: .word VSLobbyMenu__sVars
_02163394: .word 0x000005EC
	thumb_func_end VSState__ProcessAnimations

	thumb_func_start VSState__Draw
VSState__Draw: // 0x02163398
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #8
	ldr r0, _021634F0 // =VSLobbyMenu__sVars
	ldr r0, [r0, #0]
	str r0, [sp]
	bl VSState__NotLoaded
	cmp r0, #0
	beq _021633AC
	b _021634EA
_021633AC:
	ldr r4, [sp]
	ldr r1, _021634F4 // =0x000005EC
	ldr r0, [sp]
	add r4, #0xec
	add r0, r0, r1
	str r0, [sp, #4]
	cmp r4, r0
	bne _021633BE
	b _021634EA
_021633BE:
	ldr r7, [sp]
	ldr r6, [sp]
	add r7, #0x88
	add r6, #0x24
_021633C6:
	mov r0, #0
	ldrsh r0, [r4, r0]
	strh r0, [r6, #8]
	mov r0, #2
	ldrsh r0, [r4, r0]
	strh r0, [r6, #0xa]
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	mov r0, #0x9d
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _021633F4
	mov r0, #0
	ldrsh r0, [r4, r0]
	strh r0, [r7, #8]
	mov r0, #2
	ldrsh r0, [r4, r0]
	strh r0, [r7, #0xa]
	mov r0, r7
	bl AnimatorSprite__DrawFrame
_021633F4:
	ldr r0, [sp]
	ldr r1, [r0, #4]
	mov r0, #1
	tst r0, r1
	bne _02163418
	mov r1, #8
	ldrsh r1, [r6, r1]
	mov r0, #0x65
	lsl r0, r0, #2
	add r0, r4, r0
	add r1, #8
	strh r1, [r0, #8]
	mov r1, #0xa
	ldrsh r1, [r6, r1]
	add r1, #8
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
_02163418:
	mov r0, #0x27
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	cmp r0, #0
	bne _0216342C
	mov r0, #0x9f
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	cmp r0, #0
	ble _021634DC
_0216342C:
	mov r0, #0
	ldrsh r0, [r4, r0]
	mov r1, #0x9f
	add r5, r4, #4
	add r0, #0xc0
	strh r0, [r5, #8]
	mov r0, #2
	lsl r1, r1, #2
	ldr r1, [r4, r1]
	ldrsh r0, [r4, r0]
	asr r1, r1, #0xc
	add r0, r0, r1
	add r0, #0x1a
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	mov r0, #0x27
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	cmp r0, #0xc
	bhi _021634AC
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02163464: // jump table
	.hword _021634DC - _02163464 - 2 // case 0
	.hword _021634AC - _02163464 - 2 // case 1
	.hword _021634AC - _02163464 - 2 // case 2
	.hword _021634AC - _02163464 - 2 // case 3
	.hword _021634AC - _02163464 - 2 // case 4
	.hword _021634AC - _02163464 - 2 // case 5
	.hword _021634AC - _02163464 - 2 // case 6
	.hword _0216347E - _02163464 - 2 // case 7
	.hword _0216347E - _02163464 - 2 // case 8
	.hword _0216347E - _02163464 - 2 // case 9
	.hword _0216347E - _02163464 - 2 // case 10
	.hword _021634AC - _02163464 - 2 // case 11
	.hword _0216347E - _02163464 - 2 // case 12
_0216347E:
	mov r1, #8
	ldrsh r1, [r5, r1]
	mov r0, r4
	add r0, #0xcc
	sub r1, #8
	strh r1, [r0, #8]
	mov r1, #0xa
	ldrsh r1, [r5, r1]
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r1, #8
	ldrsh r1, [r5, r1]
	mov r0, r4
	add r0, #0x68
	sub r1, #0x2a
	strh r1, [r0, #8]
	mov r1, #0xa
	ldrsh r1, [r5, r1]
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	b _021634C6
_021634AC:
	mov r1, #8
	ldrsh r1, [r5, r1]
	mov r0, #0x13
	lsl r0, r0, #4
	add r0, r4, r0
	sub r1, #0xb2
	strh r1, [r0, #8]
	mov r1, #0xa
	ldrsh r1, [r5, r1]
	sub r1, #8
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
_021634C6:
	mov r1, #8
	mov r0, #0x7e
	lsl r0, r0, #2
	ldrsh r1, [r5, r1]
	add r0, r4, r0
	strh r1, [r0, #8]
	mov r1, #0xa
	ldrsh r1, [r5, r1]
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
_021634DC:
	mov r0, #0xa
	lsl r0, r0, #6
	add r4, r4, r0
	ldr r0, [sp, #4]
	cmp r4, r0
	beq _021634EA
	b _021633C6
_021634EA:
	add sp, #8
	pop {r3, r4, r5, r6, r7, pc}
	nop
_021634F0: .word VSLobbyMenu__sVars
_021634F4: .word 0x000005EC
	thumb_func_end VSState__Draw

	thumb_func_start VSState__SetCallback
VSState__SetCallback: // 0x021634F8
	ldr r2, _02163508 // =VSLobbyMenu__sVars
	ldr r3, [r2, #0]
	ldr r2, _0216350C // =0x00000624
	str r0, [r3, r2]
	add r0, r2, #4
	str r1, [r3, r0]
	bx lr
	nop
_02163508: .word VSLobbyMenu__sVars
_0216350C: .word 0x00000624
	thumb_func_end VSState__SetCallback

	thumb_func_start VSState__Func_2163510
VSState__Func_2163510: // 0x02163510
	push {r4, r5, r6, r7, lr}
	sub sp, #0x1c
	mov r6, r1
	ldr r1, _021635D4 // =VSLobbyMenu__sVars
	mov r5, r2
	ldr r4, [r1, #0]
	ldr r1, _021635D8 // =0x000005EC
	mov r7, r3
	str r0, [r4, r1]
	add r1, #0x34
	ldr r0, [r4, r1]
	cmp r0, #0
	beq _0216352E
	bl _FreeHEAP_SYSTEM
_0216352E:
	mov r0, #0x21
	lsl r0, r0, #8
	bl _AllocHeadHEAP_SYSTEM
	mov r1, #0x62
	lsl r1, r1, #4
	str r0, [r4, r1]
	mov r2, #0x21
	ldr r1, [r4, r1]
	mov r0, #0
	lsl r2, r2, #8
	bl MIi_CpuClearFast
	ldr r0, [r4, #8]
	mov r1, r6
	bl BackgroundUnknown__Func_204CA00
	mov r0, #4
	str r0, [sp]
	mov r0, #8
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	mov r0, #0xb
	str r0, [sp, #0xc]
	mov r0, #0x62
	lsl r0, r0, #4
	ldr r1, [r4, r0]
	sub r0, #0x30
	str r1, [sp, #0x10]
	mov r3, #0
	str r3, [sp, #0x14]
	lsl r1, r7, #5
	str r1, [sp, #0x18]
	ldr r1, [r4, #8]
	add r0, r4, r0
	mov r2, r6
	bl Unknown2056570__Init
	mov r0, #0x5f
	lsl r0, r0, #4
	add r0, r4, r0
	mov r1, r5
	bl Unknown2056570__Func_2056688
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _02163594
	cmp r0, #1
	beq _021635A6
	b _021635B6
_02163594:
	ldr r3, _021635DC // =0x05000002
	lsl r5, r5, #5
	ldr r0, _021635E0 // =0x02110460
	mov r1, #4
	mov r2, #0
	add r3, r5, r3
	bl QueueUncompressedPalette
	b _021635B6
_021635A6:
	ldr r3, _021635E4 // =0x05000402
	lsl r5, r5, #5
	ldr r0, _021635E0 // =0x02110460
	mov r1, #4
	mov r2, #0
	add r3, r5, r3
	bl QueueUncompressedPalette
_021635B6:
	ldr r1, [r4, #8]
	ldr r2, _021635E8 // =VRAMSystem__GFXControl
	lsl r1, r1, #2
	ldr r1, [r2, r1]
	lsl r0, r6, #2
	mov r3, #0
	strh r3, [r1, r0]
	ldr r1, [r4, #8]
	lsl r1, r1, #2
	ldr r2, [r2, r1]
	ldrh r1, [r2, r0]
	add r0, r2, r0
	strh r1, [r0, #2]
	add sp, #0x1c
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_021635D4: .word VSLobbyMenu__sVars
_021635D8: .word 0x000005EC
_021635DC: .word 0x05000002
_021635E0: .word 0x02110460
_021635E4: .word 0x05000402
_021635E8: .word VRAMSystem__GFXControl
	thumb_func_end VSState__Func_2163510

	thumb_func_start VSState__SetPlayerInfo_
VSState__SetPlayerInfo_: // 0x021635EC
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x38
	str r1, [sp, #0x20]
	ldr r1, _021636F8 // =VSLobbyMenu__sVars
	str r2, [sp, #0x24]
	ldr r5, [r1, #0]
	mov r1, #0xa
	mov r2, r5
	lsl r1, r1, #6
	add r2, #0xec
	mul r1, r0
	add r6, r2, r1
	ldr r2, [r5, #4]
	mov r1, #1
	mov r7, r2
	and r7, r1
	cmp r0, #1
	beq _02163622
	mov r0, #0x18
	mov r4, #4
	str r0, [sp, #0x30]
	cmp r7, #0
	beq _02163632
	mov r0, #0xb8
	str r0, [sp, #0x2c]
	str r4, [sp, #0x28]
	b _02163632
_02163622:
	mov r0, #0x18
	mov r4, #0x36
	str r0, [sp, #0x30]
	cmp r7, #0
	beq _02163632
	mov r0, #0xb8
	str r0, [sp, #0x2c]
	str r4, [sp, #0x28]
_02163632:
	asr r0, r4, #2
	lsr r0, r0, #0x1d
	add r0, r4, r0
	asr r0, r0, #3
	str r0, [sp, #0x34]
	ldr r0, _021636FC // =0x000005EC
	ldr r0, [r5, r0]
	bl FontFile__GetPixelHeight
	add r1, r0, #7
	asr r0, r1, #2
	lsr r0, r0, #0x1d
	add r0, r1, r0
	asr r1, r0, #3
	ldr r0, [sp, #0x34]
	ldr r2, [sp, #0x34]
	add r0, r0, r1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp]
	mov r0, #0x5f
	lsl r0, r0, #4
	lsl r2, r2, #0x10
	add r0, r5, r0
	mov r1, #0
	lsr r2, r2, #0x10
	mov r3, #0x17
	bl Unknown2056570__Func_20568B0
	ldr r0, [sp, #0x20]
	cmp r0, #0
	beq _021636EA
	mov r1, #0x97
	lsl r1, r1, #2
	add r1, r6, r1
	mov r2, #0x12
	bl MIi_CpuCopy16
	mov r0, #0x9b
	lsl r0, r0, #2
	mov r1, #0
	strh r1, [r6, r0]
	mov r2, r0
	ldr r1, [sp, #0x24]
	add r2, #0xc
	str r1, [r6, r2]
	ldr r1, [sp, #0x30]
	sub r0, #0x10
	str r1, [sp]
	str r4, [sp, #4]
	mov r1, #0
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	str r1, [sp, #0x10]
	str r1, [sp, #0x14]
	ldr r1, _02163700 // =0x0217EC94
	ldr r3, _021636FC // =0x000005EC
	str r1, [sp, #0x18]
	add r0, r6, r0
	str r0, [sp, #0x1c]
	ldr r0, [r5, r3]
	mov r1, #0
	add r3, r3, #4
	mov r2, r1
	add r3, r5, r3
	bl FontFile__Func_20530D8
	cmp r7, #0
	beq _021636EA
	ldr r0, [sp, #0x2c]
	mov r2, #0
	str r0, [sp]
	ldr r0, [sp, #0x28]
	ldr r3, _021636FC // =0x000005EC
	str r0, [sp, #4]
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	mov r0, #9
	str r0, [sp, #0x10]
	ldr r0, _02163704 // =0x0217EC9C
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, #0x9e
	lsl r0, r0, #2
	ldr r0, [r6, r0]
	mov r1, #8
	str r0, [sp, #0x1c]
	ldr r0, [r5, r3]
	add r3, r3, #4
	add r3, r5, r3
	bl FontFile__Func_20530D8
_021636EA:
	mov r0, #0x5f
	lsl r0, r0, #4
	add r0, r5, r0
	bl Unknown2056570__Func_2056B8C
	add sp, #0x38
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021636F8: .word VSLobbyMenu__sVars
_021636FC: .word 0x000005EC
_02163700: .word 0x0217EC94
_02163704: .word 0x0217EC9C
	thumb_func_end VSState__SetPlayerInfo_

	thumb_func_start VSState__SetPlayerInfoEx
VSState__SetPlayerInfoEx: // 0x02163708
	push {r4, r5, r6, lr}
	sub sp, #0x18
	mov r5, r0
	mov r4, r2
	mov r6, r3
	cmp r1, #0
	beq _02163738
	cmp r4, #0
	beq _02163738
	mov r0, r1
	add r1, sp, #0
	lsl r2, r4, #1
	bl MIi_CpuCopy16
	mov r2, #0
	lsl r0, r4, #1
	add r1, sp, #0
	strh r2, [r1, r0]
	mov r0, r5
	mov r2, r6
	bl VSState__SetPlayerInfo_
	add sp, #0x18
	pop {r4, r5, r6, pc}
_02163738:
	mov r0, r5
	mov r1, #0
	mov r2, r6
	bl VSState__SetPlayerInfo_
	add sp, #0x18
	pop {r4, r5, r6, pc}
	.align 2, 0
	thumb_func_end VSState__SetPlayerInfoEx

	thumb_func_start VSState__SetPlayerInfo
VSState__SetPlayerInfo: // 0x02163748
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _02163764 // =saveGame
	mov r4, r1
	bl SaveGame__GetPlayerNameLength
	lsl r0, r0, #0x10
	lsr r2, r0, #0x10
	ldr r1, _02163764 // =saveGame
	mov r0, r5
	mov r3, r4
	bl VSState__SetPlayerInfoEx
	pop {r3, r4, r5, pc}
	.align 2, 0
_02163764: .word saveGame
	thumb_func_end VSState__SetPlayerInfo

	thumb_func_start VSState__Func_2163768
VSState__Func_2163768: // 0x02163768
	push {r3, r4}
	ldr r2, _02163780 // =VSLobbyMenu__sVars
	mov r3, r0
	ldr r4, [r2, #0]
	mov r2, #0xa
	lsl r2, r2, #6
	mul r3, r2
	add r0, r4, r3
	add r2, #0xe0
	str r1, [r0, r2]
	pop {r3, r4}
	bx lr
	.align 2, 0
_02163780: .word VSLobbyMenu__sVars
	thumb_func_end VSState__Func_2163768

	thumb_func_start VSState__Func_2163784
VSState__Func_2163784: // 0x02163784
	push {r4, r5, r6, lr}
	mov r5, r1
	ldr r1, _021639F0 // =VSLobbyMenu__sVars
	mov r6, r2
	ldr r3, [r1, #0]
	mov r1, #0xa
	lsl r1, r1, #6
	mov r2, r0
	mov r0, r1
	add r3, #0xec
	mul r2, r1
	add r4, r3, r2
	sub r0, #0x10
	ldr r0, [r4, r0]
	cmp r0, r5
	bne _021637A6
	b _021639EE
_021637A6:
	sub r1, #0x10
	str r5, [r4, r1]
	cmp r5, #0
	beq _021637C4
	cmp r5, #1
	bne _021637BC
	add r0, r4, #4
	mov r1, #2
	bl AnimatorSprite__SetAnimation
	b _021637C4
_021637BC:
	add r0, r4, #4
	mov r1, #1
	bl AnimatorSprite__SetAnimation
_021637C4:
	cmp r5, #0xc
	bls _021637CA
	b _021639EE
_021637CA:
	add r0, r5, r5
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_021637D6: // jump table
	.hword _021637F0 - _021637D6 - 2 // case 0
	.hword _0216381A - _021637D6 - 2 // case 1
	.hword _02163840 - _021637D6 - 2 // case 2
	.hword _0216385A - _021637D6 - 2 // case 3
	.hword _02163874 - _021637D6 - 2 // case 4
	.hword _0216388E - _021637D6 - 2 // case 5
	.hword _021638A8 - _021637D6 - 2 // case 6
	.hword _02163928 - _021637D6 - 2 // case 7
	.hword _0216394E - _021637D6 - 2 // case 8
	.hword _021638C2 - _021637D6 - 2 // case 9
	.hword _021638E8 - _021637D6 - 2 // case 10
	.hword _0216390E - _021637D6 - 2 // case 11
	.hword _02163974 - _021637D6 - 2 // case 12
_021637F0:
	mov r0, r4
	add r0, #0xa4
	ldr r0, [r0, #0]
	mov r1, #1
	mov r2, r0
	mov r0, r4
	orr r2, r1
	add r0, #0xa4
	str r2, [r0]
	mov r2, #0x42
	lsl r2, r2, #2
	ldr r0, [r4, r2]
	orr r0, r1
	str r0, [r4, r2]
	mov r0, r2
	add r0, #0x64
	ldr r0, [r4, r0]
	add r2, #0x64
	orr r0, r1
	str r0, [r4, r2]
	pop {r4, r5, r6, pc}
_0216381A:
	mov r0, #0x13
	lsl r0, r0, #4
	add r0, r4, r0
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	mov r0, #0x7e
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	mov r0, #0x7e
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0xd
	bl AnimatorSprite__SetAnimation
	b _0216399A
_02163840:
	mov r0, #0x13
	lsl r0, r0, #4
	add r0, r4, r0
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	mov r0, #0x7e
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	b _0216399A
_0216385A:
	mov r0, #0x13
	lsl r0, r0, #4
	add r0, r4, r0
	mov r1, #2
	bl AnimatorSprite__SetAnimation
	mov r0, #0x7e
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	b _0216399A
_02163874:
	mov r0, #0x13
	lsl r0, r0, #4
	add r0, r4, r0
	mov r1, #3
	bl AnimatorSprite__SetAnimation
	mov r0, #0x7e
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	b _0216399A
_0216388E:
	mov r0, #0x13
	lsl r0, r0, #4
	add r0, r4, r0
	mov r1, #5
	bl AnimatorSprite__SetAnimation
	mov r0, #0x7e
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	b _0216399A
_021638A8:
	mov r0, #0x13
	lsl r0, r0, #4
	add r0, r4, r0
	mov r1, #4
	bl AnimatorSprite__SetAnimation
	mov r0, #0x7e
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	b _0216399A
_021638C2:
	mov r0, r4
	add r0, #0xcc
	mov r1, #2
	bl AnimatorSprite__SetAnimation
	add r1, r6, #4
	mov r0, r4
	lsl r1, r1, #0x10
	add r0, #0x68
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	mov r0, #0x7e
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	b _021639C6
_021638E8:
	mov r0, r4
	add r0, #0xcc
	mov r1, #3
	bl AnimatorSprite__SetAnimation
	add r1, r6, #4
	mov r0, r4
	lsl r1, r1, #0x10
	add r0, #0x68
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	mov r0, #0x7e
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	b _021639C6
_0216390E:
	mov r0, #0x13
	lsl r0, r0, #4
	add r0, r4, r0
	mov r1, #6
	bl AnimatorSprite__SetAnimation
	mov r0, #0x7e
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	b _0216399A
_02163928:
	mov r0, r4
	add r0, #0xcc
	mov r1, #0xe
	bl AnimatorSprite__SetAnimation
	add r1, r6, #4
	mov r0, r4
	lsl r1, r1, #0x10
	add r0, #0x68
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	mov r0, #0x7e
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	b _021639C6
_0216394E:
	add r6, #0x10
	mov r0, r4
	lsl r1, r6, #0x10
	add r0, #0xcc
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	mov r0, r4
	add r0, #0x68
	mov r1, #0xf
	bl AnimatorSprite__SetAnimation
	mov r0, #0x7e
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	b _021639C6
_02163974:
	add r6, #0x19
	mov r0, r4
	lsl r1, r6, #0x10
	add r0, #0xcc
	lsr r1, r1, #0x10
	bl AnimatorSprite__SetAnimation
	mov r0, r4
	add r0, #0x68
	mov r1, #0xf
	bl AnimatorSprite__SetAnimation
	mov r0, #0x7e
	lsl r0, r0, #2
	add r0, r4, r0
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	b _021639C6
_0216399A:
	mov r0, r4
	add r0, #0xa4
	ldr r0, [r0, #0]
	mov r1, #1
	mov r2, r0
	mov r0, r4
	orr r2, r1
	add r0, #0xa4
	str r2, [r0]
	mov r2, #0x42
	lsl r2, r2, #2
	ldr r0, [r4, r2]
	orr r0, r1
	str r0, [r4, r2]
	mov r0, r2
	add r0, #0x64
	ldr r1, [r4, r0]
	mov r0, #1
	bic r1, r0
	add r2, #0x64
	str r1, [r4, r2]
	pop {r4, r5, r6, pc}
_021639C6:
	mov r0, r4
	add r0, #0xa4
	ldr r2, [r0, #0]
	mov r1, #1
	mov r0, r4
	bic r2, r1
	add r0, #0xa4
	str r2, [r0]
	mov r2, #0x42
	lsl r2, r2, #2
	ldr r0, [r4, r2]
	bic r0, r1
	str r0, [r4, r2]
	mov r0, r2
	add r0, #0x64
	ldr r1, [r4, r0]
	mov r0, #1
	orr r0, r1
	add r2, #0x64
	str r0, [r4, r2]
_021639EE:
	pop {r4, r5, r6, pc}
	.align 2, 0
_021639F0: .word VSLobbyMenu__sVars
	thumb_func_end VSState__Func_2163784

	thumb_func_start VSState__GetFlags
VSState__GetFlags: // 0x021639F4
	push {r4, lr}
	ldr r0, _02163A0C // =VSLobbyMenu__sVars
	ldr r4, [r0, #0]
	bl VSState__NotLoaded
	cmp r0, #0
	beq _02163A06
	mov r0, #0
	pop {r4, pc}
_02163A06:
	ldr r0, [r4, #4]
	pop {r4, pc}
	nop
_02163A0C: .word VSLobbyMenu__sVars
	thumb_func_end VSState__GetFlags

	thumb_func_start VSState__ReleaseAnimators
VSState__ReleaseAnimators: // 0x02163A10
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	bl VSState__NotLoaded
	cmp r0, #0
	bne _02163A82
	mov r0, r5
	add r0, #0x24
	bl AnimatorSprite__Release
	mov r0, r5
	add r0, #0x88
	bl AnimatorSprite__Release
	ldr r0, _02163A84 // =0x000005EC
	mov r4, r5
	add r4, #0xec
	add r6, r5, r0
	cmp r4, r6
	beq _02163A7E
	mov r7, #1
_02163A3A:
	add r0, r4, #4
	bl AnimatorSprite__Release
	mov r0, r4
	add r0, #0x68
	bl AnimatorSprite__Release
	mov r0, r4
	add r0, #0xcc
	bl AnimatorSprite__Release
	mov r0, #0x13
	lsl r0, r0, #4
	add r0, r4, r0
	bl AnimatorSprite__Release
	ldr r0, [r5, #4]
	tst r0, r7
	bne _02163A6A
	mov r0, #0x65
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorSprite__Release
_02163A6A:
	mov r0, #0x7e
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorSprite__Release
	mov r0, #0xa
	lsl r0, r0, #6
	add r4, r4, r0
	cmp r4, r6
	bne _02163A3A
_02163A7E:
	mov r0, #0
	str r0, [r5]
_02163A82:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02163A84: .word 0x000005EC
	thumb_func_end VSState__ReleaseAnimators

	thumb_func_start VSState__Func_2163A88
VSState__Func_2163A88: // 0x02163A88
	mov r1, #0x62
	lsl r1, r1, #4
	ldr r0, [r0, r1]
	cmp r0, #0
	beq _02163A96
	mov r0, #1
	bx lr
_02163A96:
	mov r0, #0
	bx lr
	.align 2, 0
	thumb_func_end VSState__Func_2163A88

	thumb_func_start VSState__Func_2163A9C
VSState__Func_2163A9C: // 0x02163A9C
	push {r3, r4, r5, lr}
	mov r4, r2
	cmp r0, #5
	bne _02163B1C
	ldr r2, _02163B20 // =0x00000624
	ldr r3, [r4, r2]
	cmp r3, #0
	beq _02163AB6
	add r2, r2, #4
	ldr r2, [r4, r2]
	mov r0, #1
	mov r1, r4
	blx r3
_02163AB6:
	mov r0, r4
	bl VSState__Func_2163A88
	cmp r0, #0
	beq _02163B1C
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _02163ACC
	cmp r0, #1
	beq _02163AF6
	pop {r3, r4, r5, pc}
_02163ACC:
	mov r1, #1
	lsl r1, r1, #0x1a
	ldr r2, [r1, #0]
	mov r0, #0x1f
	lsl r0, r0, #8
	and r0, r2
	lsr r2, r0, #8
	ldr r3, [r1, #0]
	ldr r0, _02163B24 // =0xFFFFE0FF
	mov r5, #1
	and r0, r3
	mov r3, #6
	lsl r3, r3, #8
	ldrh r3, [r4, r3]
	mov r4, r5
	lsl r4, r3
	orr r2, r4
	lsl r2, r2, #8
	orr r0, r2
	str r0, [r1]
	pop {r3, r4, r5, pc}
_02163AF6:
	ldr r1, _02163B28 // =0x04001000
	mov r0, #0x1f
	ldr r2, [r1, #0]
	lsl r0, r0, #8
	and r0, r2
	lsr r2, r0, #8
	ldr r3, [r1, #0]
	ldr r0, _02163B24 // =0xFFFFE0FF
	mov r5, #1
	and r0, r3
	mov r3, #6
	lsl r3, r3, #8
	ldrh r3, [r4, r3]
	mov r4, r5
	lsl r4, r3
	orr r2, r4
	lsl r2, r2, #8
	orr r0, r2
	str r0, [r1]
_02163B1C:
	pop {r3, r4, r5, pc}
	nop
_02163B20: .word 0x00000624
_02163B24: .word 0xFFFFE0FF
_02163B28: .word 0x04001000
	thumb_func_end VSState__Func_2163A9C

	thumb_func_start VSState__Func_2163B2C
VSState__Func_2163B2C: // 0x02163B2C
	push {r4, lr}
	mov r4, r2
	cmp r0, #5
	bne _02163B4C
	ldr r2, _02163B50 // =0x00000624
	ldr r3, [r4, r2]
	cmp r3, #0
	beq _02163B46
	add r2, r2, #4
	ldr r2, [r4, r2]
	mov r0, #3
	mov r1, r4
	blx r3
_02163B46:
	mov r0, r4
	bl VSState__ReleaseAnimators
_02163B4C:
	pop {r4, pc}
	nop
_02163B50: .word 0x00000624
	thumb_func_end VSState__Func_2163B2C

	.data
	
aNarcDmvsUinfoN: // 0x0217EC58
	.asciz "/narc/dmvs_uinfo.narc"
	.align 4
	
aDmcmnTerMtBac: // 0x0217EC70
	.asciz "/dmcmn_ter_mt.bac"
	.align 4
	
aDmwlStateBac: // 0x0217EC84
	.asciz "/dmwl_state.bac"
	.align 4
	
_0217EC94:
	.byte 0x25, 0x00, 0x73, 0x00, 0x00, 0x00, 0x00, 0x00, 0x25, 0x00, 0x64, 0x00
	.byte 0x00, 0x00, 0x00, 0x00
