	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public FriendCodeMenu__sVars
FriendCodeMenu__sVars: // 0x0217EFE4
	.space 0x04 // Task*

	.text

	thumb_func_start FriendCodeMenu__LoadAssets
FriendCodeMenu__LoadAssets: // 0x02164F38
	push {r3, lr}
	mov r0, #0xc5
	lsl r0, r0, #4
	bl _AllocHeadHEAP_SYSTEM
	mov r1, r0
	ldr r0, _02164F94 // =FriendCodeMenu__sVars
	mov r2, #0xc5
	str r1, [r0]
	mov r0, #0
	lsl r2, r2, #4
	bl MIi_CpuClear32
	ldr r0, _02164F94 // =FriendCodeMenu__sVars
	mov r1, #0
	ldr r2, [r0, #0]
	str r1, [r2, #4]
	ldr r2, [r0, #0]
	mov r0, #0x2e
	lsl r0, r0, #6
	add r0, r2, r0
	bl InitThreadWorker
	ldr r0, _02164F94 // =FriendCodeMenu__sVars
	ldr r1, [r0, #0]
	ldr r0, _02164F98 // =0x00000A4C
	add r0, r1, r0
	bl FontAnimator__Init
	ldr r0, _02164F94 // =FriendCodeMenu__sVars
	ldr r1, [r0, #0]
	mov r0, #0xb1
	lsl r0, r0, #4
	add r0, r1, r0
	bl FontWindowAnimator__Init
	ldr r0, _02164F9C // =_0217ED0C
	mov r1, #0
	ldr r0, [r0, #0]
	bl BundleFileUnknown__LoadFile
	ldr r1, _02164F94 // =FriendCodeMenu__sVars
	ldr r2, [r1, #0]
	ldr r1, _02164FA0 // =0x00000B78
	str r0, [r2, r1]
	pop {r3, pc}
	.align 2, 0
_02164F94: .word FriendCodeMenu__sVars
_02164F98: .word 0x00000A4C
_02164F9C: .word _0217ED0C
_02164FA0: .word 0x00000B78
	thumb_func_end FriendCodeMenu__LoadAssets

	thumb_func_start FriendCodeMenu__Create
FriendCodeMenu__Create: // 0x02164FA4
	push {r4, r5, lr}
	sub sp, #0xc
	ldr r3, _0216502C // =FriendCodeMenu__sVars
	mov r5, #1
	ldr r4, [r3, #0]
	str r5, [r4, #4]
	ldr r4, [r3, #0]
	str r0, [r4]
	ldr r4, [r3, #0]
	ldr r0, _02165030 // =0x00000B74
	str r2, [r4, r0]
	ldr r2, [r3, #0]
	mov r0, #0
	str r0, [r2, #0x18]
	ldr r2, [r3, #0]
	mov r4, #0xb
	str r0, [r2, #0x1c]
	ldr r2, [r3, #0]
	str r0, [r2, #0x20]
	ldr r2, [r3, #0]
	str r0, [r2, #0x24]
	ldr r2, [r3, #0]
	str r0, [r2, #0x2c]
	ldr r2, [r3, #0]
	str r4, [r2, #0x30]
	ldr r2, [r3, #0]
	str r0, [r2, #0x34]
	mov r2, #4
	ldr r0, [r3, #0]
	cmp r1, #0
	str r2, [r0, #0x38]
	beq _02164FF2
	mov r0, r1
	ldr r1, [r3, #0]
	mov r2, #0xc
	add r1, #8
	bl MI_CpuCopy8
	b _02164FFE
_02164FF2:
	ldr r0, [r3, #0]
	mov r1, #0x20
	add r0, #8
	mov r2, #0xc
	bl MI_CpuFill8
_02164FFE:
	ldr r0, _0216502C // =FriendCodeMenu__sVars
	ldr r0, [r0, #0]
	bl FriendCodeMenu__SetupDisplay
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	ldr r0, _02165034 // =FriendCodeMenu__Main
	ldr r1, _02165038 // =FriendCodeMenu__Destructor
	mov r3, r2
	str r2, [sp, #8]
	bl TaskCreate_
	ldr r2, _0216502C // =FriendCodeMenu__sVars
	ldr r1, _0216503C // =0x00000B7C
	ldr r3, [r2, #0]
	str r0, [r3, r1]
	ldr r0, [r2, #0]
	bl FriendCodeMenu__Func_21650D0
	add sp, #0xc
	pop {r4, r5, pc}
	nop
_0216502C: .word FriendCodeMenu__sVars
_02165030: .word 0x00000B74
_02165034: .word FriendCodeMenu__Main
_02165038: .word FriendCodeMenu__Destructor
_0216503C: .word 0x00000B7C
	thumb_func_end FriendCodeMenu__Create

	thumb_func_start FriendCodeMenu__Func_2165040
FriendCodeMenu__Func_2165040: // 0x02165040
	ldr r0, _02165048 // =FriendCodeMenu__sVars
	ldr r0, [r0, #0]
	ldr r0, [r0, #4]
	bx lr
	.align 2, 0
_02165048: .word FriendCodeMenu__sVars
	thumb_func_end FriendCodeMenu__Func_2165040

	thumb_func_start FriendCodeMenu__Func_216504C
FriendCodeMenu__Func_216504C: // 0x0216504C
	push {r3, r4}
	ldr r2, _02165064 // =FriendCodeMenu__sVars
	mov r4, #0
	ldr r3, [r2, #0]
	str r4, [r3, #0x20]
	ldr r3, [r2, #0]
	str r0, [r3, #0x24]
	ldr r0, [r2, #0]
	str r1, [r0, #0x28]
	pop {r3, r4}
	bx lr
	nop
_02165064: .word FriendCodeMenu__sVars
	thumb_func_end FriendCodeMenu__Func_216504C

	thumb_func_start FriendCodeMenu__Func_2165068
FriendCodeMenu__Func_2165068: // 0x02165068
	ldr r0, _0216507C // =FriendCodeMenu__sVars
	ldr r0, [r0, #0]
	ldr r0, [r0, #4]
	cmp r0, #0
	bne _02165076
	mov r0, #1
	bx lr
_02165076:
	mov r0, #0
	bx lr
	nop
_0216507C: .word FriendCodeMenu__sVars
	thumb_func_end FriendCodeMenu__Func_2165068

	thumb_func_start FriendCodeMenu__GetFriendKey
FriendCodeMenu__GetFriendKey: // 0x02165080
	ldr r0, _02165088 // =FriendCodeMenu__sVars
	ldr r0, [r0, #0]
	add r0, #8
	bx lr
	.align 2, 0
_02165088: .word FriendCodeMenu__sVars
	thumb_func_end FriendCodeMenu__GetFriendKey

	thumb_func_start FriendCodeMenu__Func_216508C
FriendCodeMenu__Func_216508C: // 0x0216508C
	push {r3, lr}
	ldr r0, _021650C8 // =FriendCodeMenu__sVars
	ldr r1, [r0, #0]
	ldr r0, _021650CC // =0x00000B78
	ldr r0, [r1, r0]
	cmp r0, #0
	beq _021650A8
	bl _FreeHEAP_USER
	ldr r0, _021650C8 // =FriendCodeMenu__sVars
	mov r2, #0
	ldr r1, [r0, #0]
	ldr r0, _021650CC // =0x00000B78
	str r2, [r1, r0]
_021650A8:
	ldr r0, _021650C8 // =FriendCodeMenu__sVars
	ldr r1, [r0, #0]
	mov r0, #0x2e
	lsl r0, r0, #6
	add r0, r1, r0
	bl ReleaseThreadWorker
	ldr r0, _021650C8 // =FriendCodeMenu__sVars
	ldr r0, [r0, #0]
	bl _FreeHEAP_SYSTEM
	ldr r0, _021650C8 // =FriendCodeMenu__sVars
	mov r1, #0
	str r1, [r0]
	pop {r3, pc}
	nop
_021650C8: .word FriendCodeMenu__sVars
_021650CC: .word 0x00000B78
	thumb_func_end FriendCodeMenu__Func_216508C

	thumb_func_start FriendCodeMenu__Func_21650D0
FriendCodeMenu__Func_21650D0: // 0x021650D0
	push {r4, lr}
	mov r1, #6
	mov r2, #1
	mov r4, r0
	mov r0, #0
	lsl r1, r1, #0x18
	lsl r2, r2, #0x10
	bl MIi_CpuClearFast
	mov r1, #0x62
	mov r2, #1
	mov r0, #0
	lsl r1, r1, #0x14
	lsl r2, r2, #0x10
	bl MIi_CpuClearFast
	mov r2, #0xb
	mov r0, #8
_021650F4:
	add r1, r4, r2
	ldrsb r1, [r1, r0]
	cmp r1, #0x20
	bne _02165100
	sub r2, r2, #1
	bpl _021650F4
_02165100:
	add r0, r2, #1
	str r0, [r4, #0x14]
	mov r0, #0
	str r0, [r4, #0x30]
	mov r0, #4
	str r0, [r4, #0x38]
	mov r0, r4
	bl FriendCodeMenu__Func_216526C
	mov r0, r4
	bl FriendCodeMenu__Func_2165450
	mov r0, r4
	bl FriendCodeMenu__Func_2165484
	mov r0, r4
	bl FriendCodeMenu__Func_216551C
	mov r0, r4
	bl FriendCodeMenu__Func_21655F4
	mov r0, r4
	bl FriendCodeMenu__Func_216571C
	pop {r4, pc}
	.align 2, 0
	thumb_func_end FriendCodeMenu__Func_21650D0

	thumb_func_start FriendCodeMenu__SetupDisplay
FriendCodeMenu__SetupDisplay: // 0x02165134
	push {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	mov r1, #0xf
	mov r2, #1
	ldr r0, _02165244 // =renderCoreGFXControlA+0x00000040
	mvn r1, r1
	strh r1, [r0, #0x18]
	ldr r0, _02165248 // =renderCoreGFXControlB+0x00000040
	lsl r2, r2, #0x1a
	strh r1, [r0, #0x18]
	ldr r1, [r2, #0]
	ldr r0, _0216524C // =0xFFFFE0FF
	and r1, r0
	str r1, [r2]
	ldr r2, _02165250 // =0x04001000
	ldr r1, [r2, #0]
	and r0, r1
	str r0, [r2]
	ldr r1, _02165254 // =renderCurrentDisplay
	mov r0, #1
	str r0, [r1]
	mov r1, #0
	mov r2, r1
	bl GX_SetGraphicsMode
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r2, _02165258 // =0x04000008
	mov r5, #0x81
	ldrh r1, [r2, #0]
	mov r0, #0x43
	mov r3, #4
	and r1, r0
	orr r1, r3
	strh r1, [r2]
	ldrh r1, [r2, #2]
	lsl r5, r5, #2
	and r1, r0
	orr r1, r5
	strh r1, [r2, #2]
	ldrh r1, [r2, #6]
	mov r6, r1
	ldr r1, _0216525C // =0x0000060C
	and r6, r0
	orr r6, r1
	strh r6, [r2, #6]
	ldr r2, _02165260 // =0x04001008
	ldrh r6, [r2, #0]
	and r6, r0
	orr r3, r6
	strh r3, [r2]
	ldrh r3, [r2, #2]
	and r3, r0
	orr r3, r5
	strh r3, [r2, #2]
	ldrh r3, [r2, #4]
	mov r6, r3
	and r6, r0
	lsl r3, r5, #1
	orr r3, r6
	strh r3, [r2, #4]
	ldrh r3, [r2, #6]
	and r0, r3
	orr r0, r1
	strh r0, [r2, #6]
	ldr r1, _02165264 // =renderCoreGFXControlA
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	ldr r1, _02165268 // =renderCoreGFXControlB
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	ldr r6, _02165258 // =0x04000008
	mov r2, #3
	ldrh r0, [r6, #0]
	mov r3, #1
	bic r0, r2
	strh r0, [r6]
	ldrh r0, [r6, #2]
	bic r0, r2
	orr r0, r3
	strh r0, [r6, #2]
	ldrh r1, [r6, #4]
	mov r0, #2
	mov r7, #3
	bic r1, r2
	orr r0, r1
	strh r0, [r6, #4]
	ldrh r0, [r6, #6]
	ldr r1, _0216524C // =0xFFFFE0FF
	bic r0, r2
	orr r0, r7
	strh r0, [r6, #6]
	sub r6, #8
	ldr r0, [r6, #0]
	mov r5, r0
	mov r0, #0xb
	and r5, r1
	lsl r0, r0, #8
	orr r0, r5
	str r0, [r6]
	ldr r0, _02165260 // =0x04001008
	ldrh r5, [r0, #0]
	bic r5, r2
	strh r5, [r0]
	ldrh r5, [r0, #2]
	bic r5, r2
	orr r3, r5
	strh r3, [r0, #2]
	ldrh r5, [r0, #4]
	mov r3, #2
	bic r5, r2
	orr r3, r5
	strh r3, [r0, #4]
	ldrh r3, [r0, #6]
	bic r3, r2
	mov r2, r3
	orr r2, r7
	strh r2, [r0, #6]
	sub r0, #8
	ldr r2, [r0, #0]
	and r2, r1
	mov r1, #7
	lsl r1, r1, #0xa
	orr r1, r2
	str r1, [r0]
	mov r0, r4
	mov r1, #0
	bl FriendCodeMenu__SetupBlending
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02165244: .word renderCoreGFXControlA+0x00000040
_02165248: .word renderCoreGFXControlB+0x00000040
_0216524C: .word 0xFFFFE0FF
_02165250: .word 0x04001000
_02165254: .word renderCurrentDisplay
_02165258: .word 0x04000008
_0216525C: .word 0x0000060C
_02165260: .word 0x04001008
_02165264: .word renderCoreGFXControlA
_02165268: .word renderCoreGFXControlB
	thumb_func_end FriendCodeMenu__SetupDisplay

	thumb_func_start FriendCodeMenu__Func_216526C
FriendCodeMenu__Func_216526C: // 0x0216526C
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x30
	ldr r1, _02165414 // =0x00000B78
	str r0, [sp, #0x18]
	ldr r0, [r0, r1]
	mov r1, #0
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x28]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _021652A8
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02165294: // jump table
	.hword _021652A0 - _02165294 - 2 // case 0
	.hword _021652A0 - _02165294 - 2 // case 1
	.hword _021652A0 - _02165294 - 2 // case 2
	.hword _021652A0 - _02165294 - 2 // case 3
	.hword _021652A0 - _02165294 - 2 // case 4
	.hword _021652A0 - _02165294 - 2 // case 5
_021652A0:
	bl RenderCore_GetLanguagePtr
	ldrb r2, [r0, #0]
	b _021652AA
_021652A8:
	mov r2, #1
_021652AA:
	ldr r1, _02165414 // =0x00000B78
	ldr r0, [sp, #0x18]
	ldr r0, [r0, r1]
	add r1, r2, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x24]
	ldr r0, _02165418 // =0x04001000
	ldr r1, _0216541C // =0x00300010
	ldr r0, [r0, #0]
	mov r2, r0
	ldr r0, _02165420 // =0x00100010
	and r2, r1
	cmp r2, r0
	bgt _021652D4
	bge _021652E8
	cmp r2, #0x10
	beq _021652E4
	b _021652F2
_021652D4:
	ldr r0, _02165424 // =0x00200010
	cmp r2, r0
	bgt _021652DE
	beq _021652EC
	b _021652F2
_021652DE:
	cmp r2, r1
	beq _021652F0
	b _021652F2
_021652E4:
	ldr r7, _02165428 // =Sprite__GetSpriteSize1FromAnim
	b _021652F2
_021652E8:
	ldr r7, _0216542C // =Sprite__GetSpriteSize2FromAnim
	b _021652F2
_021652EC:
	ldr r7, _02165430 // =Sprite__GetSpriteSize3FromAnim
	b _021652F2
_021652F0:
	ldr r7, _02165434 // =Sprite__GetSpriteSize4FromAnim
_021652F2:
	ldr r6, [sp, #0x18]
	mov r0, #0
	ldr r4, _02165438 // =ovl03_0217DFBC
	str r0, [sp, #0x20]
	add r6, #0x3c
	mov r5, #0x23
_021652FE:
	mov r0, #1
	str r0, [sp]
	lsl r0, r5, #0x10
	str r7, [sp, #4]
	lsr r0, r0, #0x10
	str r0, [sp, #8]
	ldrh r0, [r4, #0]
	ldr r1, [sp, #0x28]
	mov r2, #1
	str r0, [sp, #0xc]
	mov r0, #2
	str r0, [sp, #0x10]
	mov r0, #8
	str r0, [sp, #0x14]
	mov r0, r6
	mov r3, #0
	bl FriendCodeMenu__InitAnimator
	ldr r0, [sp, #0x20]
	add r6, #0x64
	add r0, r0, #1
	add r4, r4, #2
	add r5, r5, #2
	str r0, [sp, #0x20]
	cmp r0, #0xa
	blt _021652FE
	mov r0, #0
	str r0, [sp]
	str r7, [sp, #4]
	mov r0, #0x37
	str r0, [sp, #8]
	mov r0, #3
	str r0, [sp, #0xc]
	mov r0, #2
	str r0, [sp, #0x10]
	mov r0, #4
	str r0, [sp, #0x14]
	mov r2, #1
	ldr r1, _0216543C // =0x00000424
	ldr r0, [sp, #0x18]
	mov r3, r2
	add r0, r0, r1
	ldr r1, [sp, #0x28]
	bl FriendCodeMenu__InitAnimator
	mov r3, #0
	str r3, [sp]
	str r7, [sp, #4]
	mov r0, #0x22
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, #3
	str r0, [sp, #0x10]
	mov r0, #8
	str r0, [sp, #0x14]
	ldr r1, _02165440 // =0x00000488
	ldr r0, [sp, #0x18]
	mov r2, #1
	add r0, r0, r1
	ldr r1, [sp, #0x28]
	bl FriendCodeMenu__InitAnimator
	mov r0, #0
	str r0, [sp]
	mov r2, #1
	str r7, [sp, #4]
	mov r0, #0x1e
	str r0, [sp, #8]
	mov r0, #3
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #4
	str r0, [sp, #0x14]
	ldr r1, _02165444 // =0x000004EC
	ldr r0, [sp, #0x18]
	mov r3, r2
	add r0, r0, r1
	ldr r1, [sp, #0x28]
	bl FriendCodeMenu__InitAnimator
	mov r4, #0
	ldr r0, [sp, #0x18]
	ldr r6, _02165438 // =ovl03_0217DFBC
	str r0, [sp, #0x2c]
	add r0, #0x3c
	str r4, [sp, #0x1c]
	mov r5, r4
	str r0, [sp, #0x2c]
_021653B0:
	mov r0, #0
	str r0, [sp]
	lsl r0, r5, #0x10
	str r7, [sp, #4]
	lsr r0, r0, #0x10
	str r0, [sp, #8]
	ldrh r0, [r6, #0x1a]
	mov r2, #1
	mov r3, #0
	str r0, [sp, #0xc]
	mov r0, #2
	str r0, [sp, #0x10]
	mov r0, #8
	str r0, [sp, #0x14]
	ldr r0, _02165448 // =0x00000514
	add r1, r4, r0
	ldr r0, [sp, #0x2c]
	add r0, r0, r1
	ldr r1, [sp, #0x24]
	bl FriendCodeMenu__InitAnimator
	ldr r0, [sp, #0x1c]
	add r4, #0x64
	add r0, r0, #1
	add r6, r6, #2
	add r5, r5, #3
	str r0, [sp, #0x1c]
	cmp r0, #3
	blt _021653B0
	mov r0, #0
	str r0, [sp]
	str r7, [sp, #4]
	mov r0, #0x38
	str r0, [sp, #8]
	mov r0, #3
	str r0, [sp, #0xc]
	mov r0, #2
	str r0, [sp, #0x10]
	mov r0, #4
	str r0, [sp, #0x14]
	mov r2, #1
	ldr r1, _0216544C // =0x0000067C
	ldr r0, [sp, #0x18]
	mov r3, r2
	add r0, r0, r1
	ldr r1, [sp, #0x28]
	bl FriendCodeMenu__InitAnimator
	add sp, #0x30
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02165414: .word 0x00000B78
_02165418: .word 0x04001000
_0216541C: .word 0x00300010
_02165420: .word 0x00100010
_02165424: .word 0x00200010
_02165428: .word Sprite__GetSpriteSize1FromAnim
_0216542C: .word Sprite__GetSpriteSize2FromAnim
_02165430: .word Sprite__GetSpriteSize3FromAnim
_02165434: .word Sprite__GetSpriteSize4FromAnim
_02165438: .word ovl03_0217DFBC
_0216543C: .word 0x00000424
_02165440: .word 0x00000488
_02165444: .word 0x000004EC
_02165448: .word 0x00000514
_0216544C: .word 0x0000067C
	thumb_func_end FriendCodeMenu__Func_216526C

	thumb_func_start FriendCodeMenu__Func_2165450
FriendCodeMenu__Func_2165450: // 0x02165450
	push {r3, r4, lr}
	sub sp, #0xc
	mov r4, r0
	ldr r0, _02165480 // =0x00000B78
	mov r1, #7
	ldr r0, [r4, r0]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	mov r0, #3
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	mov r0, #0x6e
	lsl r0, r0, #4
	add r0, r4, r0
	mov r2, #0
	mov r3, #1
	bl InitBackground
	add sp, #0xc
	pop {r3, r4, pc}
	.align 2, 0
_02165480: .word 0x00000B78
	thumb_func_end FriendCodeMenu__Func_2165450

	thumb_func_start FriendCodeMenu__Func_2165484
FriendCodeMenu__Func_2165484: // 0x02165484
	push {r4, r5, r6, r7, lr}
	sub sp, #0x1c
	mov r5, r0
	mov r0, #0x1e
	lsl r0, r0, #6
	bl _AllocHeadHEAP_USER
	ldr r1, _0216550C // =0x00000A48
	mov r2, #0x1e
	str r0, [r5, r1]
	ldr r1, [r5, r1]
	mov r0, #0
	lsl r2, r2, #6
	bl MIi_CpuClear32
	mov r0, #0xa
	str r0, [sp]
	mov r1, #1
	str r1, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	mov r0, #5
	str r0, [sp, #0xc]
	ldr r0, _0216550C // =0x00000A48
	mov r3, #0
	ldr r2, [r5, r0]
	sub r0, #0x30
	str r2, [sp, #0x10]
	str r3, [sp, #0x14]
	mov r2, #0x20
	str r2, [sp, #0x18]
	add r0, r5, r0
	mov r2, #2
	bl Unknown2056570__Init
	ldr r0, _02165510 // =0x00000A18
	mov r1, #2
	add r0, r5, r0
	bl Unknown2056570__Func_2056688
	ldr r0, _02165514 // =FontAnimator__Palettes+0x00000008
	ldr r1, _02165518 // =0x05000442
	mov r2, #8
	bl MIi_CpuCopy16
	mov r6, #0
	mov r4, r6
	mov r7, #8
_021654E4:
	add r0, r5, r4
	ldrsb r0, [r0, r7]
	cmp r0, #0x20
	beq _02165500
	bl FriendCodeMenu__Func_2166778
	mov r2, r0
	mov r0, r5
	mov r1, r6
	bl FriendCodeMenu__Func_21660F8
	add r0, r6, #1
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
_02165500:
	add r4, r4, #1
	cmp r4, #0xc
	blt _021654E4
	add sp, #0x1c
	pop {r4, r5, r6, r7, pc}
	nop
_0216550C: .word 0x00000A48
_02165510: .word 0x00000A18
_02165514: .word FontAnimator__Palettes+0x00000008
_02165518: .word 0x05000442
	thumb_func_end FriendCodeMenu__Func_2165484

	thumb_func_start FriendCodeMenu__Func_216551C
FriendCodeMenu__Func_216551C: // 0x0216551C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x1c
	mov r7, r0
	mov r0, #0xa
	lsl r0, r0, #8
	add r0, r7, r0
	bl TouchField__Init
	ldr r0, _021655E0 // =0x00000A0C
	mov r4, #0
	str r4, [r7, r0]
	add r0, r0, #4
	strb r4, [r7, r0]
	add r6, sp, #8
	strh r4, [r6, #4]
	strh r4, [r6, #6]
	mov r0, #0x18
	strh r0, [r6, #8]
	strh r0, [r6, #0xa]
	mov r0, #0x34
	strh r0, [r6]
	mov r0, #0x54
	strh r0, [r6, #2]
	ldr r0, _021655E4 // =0x00000728
	add r5, r7, r0
_0216554E:
	cmp r4, #5
	bne _0216555E
	mov r0, #2
	ldrsh r0, [r6, r0]
	add r0, #0x20
	strh r0, [r6, #2]
	mov r0, #0x34
	strh r0, [r6]
_0216555E:
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	ldr r2, _021655E8 // =TouchField__PointInRect
	mov r0, r5
	add r1, sp, #8
	add r3, sp, #0xc
	bl TouchField__InitAreaShape
	mov r0, #0xa
	lsl r0, r0, #8
	ldr r2, _021655EC // =0x0000FFFF
	add r0, r7, r0
	mov r1, r5
	bl TouchField__AddArea
	mov r0, #0
	ldrsh r0, [r6, r0]
	add r4, r4, #1
	add r5, #0x38
	add r0, #0x20
	strh r0, [r6]
	cmp r4, #0xa
	blt _0216554E
	mov r5, #0
	add r6, sp, #8
	strh r5, [r6, #4]
	mov r0, #4
	strh r0, [r6, #6]
	mov r0, #0x44
	strh r0, [r6, #8]
	mov r0, #0x18
	strh r0, [r6, #0xa]
	mov r0, #0x14
	strh r0, [r6]
	mov r0, #0xa0
	strh r0, [r6, #2]
	ldr r0, _021655F0 // =0x00000958
	add r4, r7, r0
_021655AC:
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	ldr r2, _021655E8 // =TouchField__PointInRect
	mov r0, r4
	add r1, sp, #8
	add r3, sp, #0xc
	bl TouchField__InitAreaShape
	mov r0, #0xa
	lsl r0, r0, #8
	ldr r2, _021655EC // =0x0000FFFF
	add r0, r7, r0
	mov r1, r4
	bl TouchField__AddArea
	mov r0, #0
	ldrsh r0, [r6, r0]
	add r5, r5, #1
	add r4, #0x38
	add r0, #0x48
	strh r0, [r6]
	cmp r5, #3
	blt _021655AC
	add sp, #0x1c
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_021655E0: .word 0x00000A0C
_021655E4: .word 0x00000728
_021655E8: .word TouchField__PointInRect
_021655EC: .word 0x0000FFFF
_021655F0: .word 0x00000958
	thumb_func_end FriendCodeMenu__Func_216551C

	thumb_func_start FriendCodeMenu__Func_21655F4
FriendCodeMenu__Func_21655F4: // 0x021655F4
	push {r4, lr}
	sub sp, #0x28
	mov r4, r0
	mov r0, #2
	str r0, [sp]
	mov r2, #1
	str r2, [sp, #4]
	mov r1, #8
	str r1, [sp, #8]
	mov r0, #0x1e
	str r0, [sp, #0xc]
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	str r2, [sp, #0x1c]
	mov r1, #0xb1
	str r2, [sp, #0x20]
	mov r2, #0
	lsl r1, r1, #4
	add r0, r4, r1
	str r2, [sp, #0x24]
	add r1, #0x64
	ldr r1, [r4, r1]
	mov r3, r2
	bl FontWindowAnimator__Load1
	mov r0, #9
	str r0, [sp]
	mov r0, #0x1c
	str r0, [sp, #4]
	mov r0, #6
	str r0, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	mov r2, #0
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r0, #0x20
	str r0, [sp, #0x18]
	ldr r1, _02165698 // =0x00000B74
	ldr r0, _0216569C // =0x00000A4C
	ldr r1, [r4, r1]
	add r0, r4, r0
	mov r3, #2
	bl FontAnimator__LoadFont1
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _0216567A
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02165666: // jump table
	.hword _02165672 - _02165666 - 2 // case 0
	.hword _02165672 - _02165666 - 2 // case 1
	.hword _02165672 - _02165666 - 2 // case 2
	.hword _02165672 - _02165666 - 2 // case 3
	.hword _02165672 - _02165666 - 2 // case 4
	.hword _02165672 - _02165666 - 2 // case 5
_02165672:
	bl RenderCore_GetLanguagePtr
	ldrb r1, [r0, #0]
	b _0216567C
_0216567A:
	mov r1, #1
_0216567C:
	ldr r0, _021656A0 // =0x00000B78
	add r1, #0x10
	lsl r1, r1, #0x10
	ldr r0, [r4, r0]
	lsr r1, r1, #0x10
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldr r0, _0216569C // =0x00000A4C
	add r0, r4, r0
	bl FontAnimator__LoadMPCFile
	add sp, #0x28
	pop {r4, pc}
	.align 2, 0
_02165698: .word 0x00000B74
_0216569C: .word 0x00000A4C
_021656A0: .word 0x00000B78
	thumb_func_end FriendCodeMenu__Func_21655F4

	thumb_func_start FriendCodeMenu__InitAnimator
FriendCodeMenu__InitAnimator: // 0x021656A4
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x20
	mov r6, r0
	str r1, [sp, #0x1c]
	mov r5, r2
	mov r4, #0
	cmp r3, #0
	beq _021656B8
	mov r0, #4
	orr r4, r0
_021656B8:
	ldr r0, [sp, #0x38]
	cmp r0, #0
	beq _021656C4
	mov r0, #2
	lsl r0, r0, #8
	orr r4, r0
_021656C4:
	cmp r5, #0
	bne _021656CC
	ldr r7, _02165714 // =0x05000200
	b _021656CE
_021656CC:
	ldr r7, _02165718 // =0x05000600
_021656CE:
	add r1, sp, #0x28
	ldrh r1, [r1, #0x18]
	ldr r0, [sp, #0x1c]
	ldr r2, [sp, #0x3c]
	blx r2
	mov r1, r0
	mov r0, r5
	bl VRAMSystem__AllocSpriteVram
	str r5, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	add r0, sp, #0x48
	ldrb r0, [r0, #0]
	str r7, [sp, #0x10]
	add r2, sp, #0x28
	str r0, [sp, #0x14]
	add r0, sp, #0x4c
	ldrb r0, [r0, #0]
	ldr r1, [sp, #0x1c]
	mov r3, r4
	str r0, [sp, #0x18]
	ldrh r2, [r2, #0x18]
	mov r0, r6
	bl AnimatorSprite__Init
	add r0, sp, #0x28
	ldrh r0, [r0, #0x1c]
	add r6, #0x50
	strh r0, [r6]
	add sp, #0x20
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02165714: .word 0x05000200
_02165718: .word 0x05000600
	thumb_func_end FriendCodeMenu__InitAnimator

	thumb_func_start FriendCodeMenu__Func_216571C
FriendCodeMenu__Func_216571C: // 0x0216571C
	push {r3, r4, r5, lr}
	sub sp, #0x198
	mov r4, r0
	ldr r0, _0216585C // =0x00000B78
	mov r1, #8
	ldr r0, [r4, r0]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	mov r0, #3
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, sp, #0x150
	mov r2, #0x38
	mov r3, #0
	bl InitBackground
	add r0, sp, #0x150
	bl DrawBackground
	add r0, sp, #0xec
	bl FontWindowAnimator__Init
	mov r0, #2
	str r0, [sp]
	mov r0, #3
	str r0, [sp, #4]
	mov r0, #7
	str r0, [sp, #8]
	mov r0, #0x1a
	str r0, [sp, #0xc]
	mov r0, #8
	str r0, [sp, #0x10]
	mov r3, #0
	str r3, [sp, #0x14]
	mov r0, #1
	str r0, [sp, #0x18]
	str r0, [sp, #0x1c]
	str r0, [sp, #0x20]
	ldr r1, _02165860 // =0x00000B74
	str r3, [sp, #0x24]
	ldr r1, [r4, r1]
	add r0, sp, #0xec
	mov r2, #0x38
	bl FontWindowAnimator__Load1
	add r0, sp, #0xec
	bl FontWindowAnimator__Func_20599C4
	add r0, sp, #0xec
	bl FontWindowAnimator__Draw
	add r0, sp, #0xec
	bl FontWindowAnimator__Release
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _021657BA
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_021657A6: // jump table
	.hword _021657B2 - _021657A6 - 2 // case 0
	.hword _021657B2 - _021657A6 - 2 // case 1
	.hword _021657B2 - _021657A6 - 2 // case 2
	.hword _021657B2 - _021657A6 - 2 // case 3
	.hword _021657B2 - _021657A6 - 2 // case 4
	.hword _021657B2 - _021657A6 - 2 // case 5
_021657B2:
	bl RenderCore_GetLanguagePtr
	ldrb r1, [r0, #0]
	b _021657BC
_021657BA:
	mov r1, #1
_021657BC:
	ldr r0, _0216585C // =0x00000B78
	add r1, #0x10
	lsl r1, r1, #0x10
	ldr r0, [r4, r0]
	lsr r1, r1, #0x10
	bl FileUnknown__GetAOUFile
	mov r5, r0
	add r0, sp, #0x28
	bl FontAnimator__Init
	mov r0, #8
	str r0, [sp]
	mov r0, #0x18
	str r0, [sp, #4]
	mov r1, #6
	str r1, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	add r1, #0xfa
	str r1, [sp, #0x18]
	ldr r1, _02165860 // =0x00000B74
	add r0, sp, #0x28
	ldr r1, [r4, r1]
	mov r2, #0x38
	mov r3, #4
	bl FontAnimator__LoadFont1
	add r0, sp, #0x28
	bl FontAnimator__LoadMappingsFunc
	add r0, sp, #0x28
	bl FontAnimator__LoadPaletteFunc
	add r0, sp, #0x28
	mov r1, r5
	bl FontAnimator__LoadMPCFile
	add r0, sp, #0x28
	mov r1, #3
	bl FontAnimator__SetMsgSequence
	add r0, sp, #0x28
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
	add r0, sp, #0x28
	mov r1, #0
	bl FontAnimator__GetDialogLineCount
	cmp r0, #1
	beq _02165830
	cmp r0, #2
	beq _0216583A
	b _02165842
_02165830:
	add r0, sp, #0x28
	mov r1, #0x10
	bl FontAnimator__AdvanceLine
	b _02165842
_0216583A:
	add r0, sp, #0x28
	mov r1, #8
	bl FontAnimator__AdvanceLine
_02165842:
	add r0, sp, #0x28
	mov r1, #0
	bl FontAnimator__LoadCharacters
	add r0, sp, #0x28
	bl FontAnimator__Draw
	add r0, sp, #0x28
	bl FontAnimator__Release
	add sp, #0x198
	pop {r3, r4, r5, pc}
	nop
_0216585C: .word 0x00000B78
_02165860: .word 0x00000B74
	thumb_func_end FriendCodeMenu__Func_216571C

	thumb_func_start FriendCodeMenu__Func_2165864
FriendCodeMenu__Func_2165864: // 0x02165864
	push {r4, lr}
	mov r4, r0
	bl FriendCodeMenu__Func_2165954
	mov r0, r4
	bl FriendCodeMenu__Func_216592C
	mov r0, r4
	bl FriendCodeMenu__Func_2165904
	mov r0, r4
	bl FriendCodeMenu__Func_2165900
	mov r0, r4
	bl FriendCodeMenu__Func_2165898
	mov r0, r4
	bl FriendCodeMenu__Func_216588C
	pop {r4, pc}
	thumb_func_end FriendCodeMenu__Func_2165864

	thumb_func_start FriendCodeMenu__Func_216588C
FriendCodeMenu__Func_216588C: // 0x0216588C
	ldr r3, _02165894 // =FriendCodeMenu__SetupBlending
	mov r1, #0
	bx r3
	nop
_02165894: .word FriendCodeMenu__SetupBlending
	thumb_func_end FriendCodeMenu__Func_216588C

	thumb_func_start FriendCodeMenu__Func_2165898
FriendCodeMenu__Func_2165898: // 0x02165898
	push {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r0, _021658EC // =0x0000067C
	add r0, r7, r0
	bl AnimatorSprite__Release
	mov r6, r7
	mov r4, #2
	mov r5, #0xc8
	add r6, #0x3c
_021658AC:
	ldr r0, _021658F0 // =0x00000514
	add r0, r5, r0
	add r0, r6, r0
	bl AnimatorSprite__Release
	sub r5, #0x64
	sub r4, r4, #1
	bpl _021658AC
	ldr r0, _021658F4 // =0x000004EC
	add r0, r7, r0
	bl AnimatorSprite__Release
	ldr r0, _021658F8 // =0x00000488
	add r0, r7, r0
	bl AnimatorSprite__Release
	ldr r0, _021658FC // =0x00000424
	add r0, r7, r0
	bl AnimatorSprite__Release
	mov r0, #0xe1
	add r7, #0x3c
	lsl r0, r0, #2
	mov r4, #9
	add r5, r7, r0
_021658DE:
	mov r0, r5
	bl AnimatorSprite__Release
	sub r5, #0x64
	sub r4, r4, #1
	bpl _021658DE
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021658EC: .word 0x0000067C
_021658F0: .word 0x00000514
_021658F4: .word 0x000004EC
_021658F8: .word 0x00000488
_021658FC: .word 0x00000424
	thumb_func_end FriendCodeMenu__Func_2165898

	thumb_func_start FriendCodeMenu__Func_2165900
FriendCodeMenu__Func_2165900: // 0x02165900
	bx lr
	.align 2, 0
	thumb_func_end FriendCodeMenu__Func_2165900

	thumb_func_start FriendCodeMenu__Func_2165904
FriendCodeMenu__Func_2165904: // 0x02165904
	push {r4, lr}
	mov r4, r0
	ldr r0, _02165924 // =0x00000A18
	add r0, r4, r0
	bl Unknown2056570__Func_2056670
	ldr r0, _02165928 // =0x00000A48
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _02165922
	bl _FreeHEAP_USER
	ldr r0, _02165928 // =0x00000A48
	mov r1, #0
	str r1, [r4, r0]
_02165922:
	pop {r4, pc}
	.align 2, 0
_02165924: .word 0x00000A18
_02165928: .word 0x00000A48
	thumb_func_end FriendCodeMenu__Func_2165904

	thumb_func_start FriendCodeMenu__Func_216592C
FriendCodeMenu__Func_216592C: // 0x0216592C
	push {r4, lr}
	ldr r1, _0216594C // =0x00000728
	mov r4, r0
	mov r2, #0x23
	mov r0, #0
	add r1, r4, r1
	lsl r2, r2, #4
	bl MIi_CpuClear16
	ldr r1, _02165950 // =0x00000958
	mov r0, #0
	add r1, r4, r1
	mov r2, #0xa8
	bl MIi_CpuClear16
	pop {r4, pc}
	.align 2, 0
_0216594C: .word 0x00000728
_02165950: .word 0x00000958
	thumb_func_end FriendCodeMenu__Func_216592C

	thumb_func_start FriendCodeMenu__Func_2165954
FriendCodeMenu__Func_2165954: // 0x02165954
	push {r4, lr}
	mov r4, r0
	ldr r0, _0216596C // =0x00000A4C
	add r0, r4, r0
	bl FontAnimator__Release
	mov r0, #0xb1
	lsl r0, r0, #4
	add r0, r4, r0
	bl FontWindowAnimator__Release
	pop {r4, pc}
	.align 2, 0
_0216596C: .word 0x00000A4C
	thumb_func_end FriendCodeMenu__Func_2165954

	thumb_func_start FriendCodeMenu__Main
FriendCodeMenu__Main: // 0x02165970
	push {r3, lr}
	ldr r0, _021659C0 // =FriendCodeMenu__sVars
	ldr r1, [r0, #0]
	mov r0, #0x6e
	lsl r0, r0, #4
	add r0, r1, r0
	bl DrawBackground
	ldr r0, _021659C0 // =FriendCodeMenu__sVars
	ldr r1, [r0, #0]
	mov r0, #0xb1
	lsl r0, r0, #4
	add r0, r1, r0
	bl FontWindowAnimator__Func_20599B4
	ldr r0, _021659C0 // =FriendCodeMenu__sVars
	ldr r1, [r0, #0]
	ldr r0, _021659C4 // =0x00000A4C
	add r0, r1, r0
	bl FontAnimator__LoadMappingsFunc
	ldr r0, _021659C0 // =FriendCodeMenu__sVars
	ldr r1, [r0, #0]
	ldr r0, _021659C4 // =0x00000A4C
	add r0, r1, r0
	bl FontAnimator__LoadPaletteFunc
	ldr r1, _021659C0 // =FriendCodeMenu__sVars
	ldr r3, _021659C8 // =FriendCodeMenu__State_2165A20
	ldr r2, [r1, #0]
	ldr r0, _021659CC // =0x00000C4C
	str r3, [r2, r0]
	ldr r0, [r1, #0]
	mov r2, #0
	str r2, [r0, #0x2c]
	ldr r0, _021659D0 // =FriendCodeMenu__Main_21659D4
	bl SetCurrentTaskMainEvent
	pop {r3, pc}
	nop
_021659C0: .word FriendCodeMenu__sVars
_021659C4: .word 0x00000A4C
_021659C8: .word FriendCodeMenu__State_2165A20
_021659CC: .word 0x00000C4C
_021659D0: .word FriendCodeMenu__Main_21659D4
	thumb_func_end FriendCodeMenu__Main

	thumb_func_start FriendCodeMenu__Main_21659D4
FriendCodeMenu__Main_21659D4: // 0x021659D4
	push {r3, lr}
	ldr r0, _02165A08 // =FriendCodeMenu__sVars
	ldr r1, [r0, #0]
	ldr r0, _02165A0C // =0x00000C4C
	ldr r0, [r1, r0]
	cmp r0, #0
	beq _021659F8
	mov r0, #0xa
	lsl r0, r0, #8
	add r0, r1, r0
	bl TouchField__Process
	ldr r0, _02165A08 // =FriendCodeMenu__sVars
	ldr r1, _02165A0C // =0x00000C4C
	ldr r0, [r0, #0]
	ldr r1, [r0, r1]
	blx r1
	pop {r3, pc}
_021659F8:
	bl DestroyCurrentTask
	ldr r0, _02165A08 // =FriendCodeMenu__sVars
	mov r1, #0
	ldr r0, [r0, #0]
	str r1, [r0, #4]
	pop {r3, pc}
	nop
_02165A08: .word FriendCodeMenu__sVars
_02165A0C: .word 0x00000C4C
	thumb_func_end FriendCodeMenu__Main_21659D4

	thumb_func_start FriendCodeMenu__Destructor
FriendCodeMenu__Destructor: // 0x02165A10
	ldr r0, _02165A18 // =FriendCodeMenu__sVars
	ldr r3, _02165A1C // =FriendCodeMenu__Func_2165864
	ldr r0, [r0, #0]
	bx r3
	.align 2, 0
_02165A18: .word FriendCodeMenu__sVars
_02165A1C: .word FriendCodeMenu__Func_2165864
	thumb_func_end FriendCodeMenu__Destructor

	thumb_func_start FriendCodeMenu__State_2165A20
FriendCodeMenu__State_2165A20: // 0x02165A20
	push {r4, lr}
	ldr r1, _02165A70 // =renderCoreGFXControlA+0x00000040
	mov r4, r0
	mov r0, #0x18
	ldrsh r0, [r1, r0]
	cmp r0, #0
	bge _02165A34
	add r0, r0, #1
	strh r0, [r1, #0x18]
	b _02165A3A
_02165A34:
	ble _02165A3A
	sub r0, r0, #1
	strh r0, [r1, #0x18]
_02165A3A:
	ldr r1, _02165A70 // =renderCoreGFXControlA+0x00000040
	mov r0, #0x18
	ldrsh r1, [r1, r0]
	ldr r0, _02165A74 // =renderCoreGFXControlB+0x00000040
	strh r1, [r0, #0x18]
	ldr r1, [r4, #0x2c]
	mov r0, r4
	bl FriendCodeMenu__Func_2166408
	cmp r0, #0
	beq _02165A68
	ldr r0, _02165A78 // =VRAMSystem__GFXControl
	ldr r1, [r0, #4]
	mov r0, #0x58
	ldrsh r0, [r1, r0]
	cmp r0, #0
	bne _02165A68
	mov r0, #1
	str r0, [r4, #0x1c]
	ldr r1, _02165A7C // =FriendCodeMenu__State_2165A84
	ldr r0, _02165A80 // =0x00000C4C
	str r1, [r4, r0]
	pop {r4, pc}
_02165A68:
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	pop {r4, pc}
	.align 2, 0
_02165A70: .word renderCoreGFXControlA+0x00000040
_02165A74: .word renderCoreGFXControlB+0x00000040
_02165A78: .word VRAMSystem__GFXControl
_02165A7C: .word FriendCodeMenu__State_2165A84
_02165A80: .word 0x00000C4C
	thumb_func_end FriendCodeMenu__State_2165A20

	thumb_func_start FriendCodeMenu__State_2165A84
FriendCodeMenu__State_2165A84: // 0x02165A84
	push {r4, r5, r6, r7, lr}
	sub sp, #0x2c
	mov r1, #0
	mov r5, r0
	str r1, [sp, #4]
	str r1, [sp]
	bl FriendCodeMenu__Func_2166738
	str r0, [sp, #8]
	mov r0, #0
	add r1, sp, #0xc
	mov r2, #0x1e
	bl MIi_CpuClear16
	ldr r0, [r5, #0x14]
	cmp r0, #0
	bne _02165AB0
	mov r1, #1
	add r0, sp, #0xc
	strh r1, [r0, #0x1a]
	ldrh r1, [r0, #0x1a]
	strh r1, [r0, #0x18]
_02165AB0:
	ldr r0, [r5, #0x14]
	cmp r0, #0xc
	bge _02165ABC
	mov r1, #1
	add r0, sp, #0xc
	strh r1, [r0, #0x1c]
_02165ABC:
	ldr r1, [r5, #0x30]
	ldr r0, [r5, #0x38]
	cmp r1, #0xa
	bge _02165ADA
	cmp r1, #5
	bge _02165AD0
	lsl r0, r1, #0x10
	lsr r4, r0, #0x10
	mov r6, #0
	b _02165AE0
_02165AD0:
	sub r0, r1, #5
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	mov r6, #1
	b _02165AE0
_02165ADA:
	lsl r0, r0, #0x11
	lsr r4, r0, #0x10
	mov r6, #2
_02165AE0:
	ldr r0, _02165DA4 // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x20
	tst r0, r1
	beq _02165B1E
	mov r0, #0xa
	add r1, sp, #0xc
	mul r0, r6
	add r2, r1, r0
	mov r7, #2
	mov r0, #1
	mov r1, #4
_02165AF8:
	cmp r4, #0
	bne _02165B00
	mov r4, r1
	b _02165B10
_02165B00:
	cmp r6, #2
	bhs _02165B08
	mov r3, r0
	b _02165B0A
_02165B08:
	mov r3, r7
_02165B0A:
	sub r3, r4, r3
	lsl r3, r3, #0x10
	lsr r4, r3, #0x10
_02165B10:
	lsl r3, r4, #1
	ldrh r3, [r2, r3]
	cmp r3, #0
	bne _02165AF8
	mov r0, #2
	bl PlaySysMenuNavSfx
_02165B1E:
	ldr r0, _02165DA4 // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x10
	tst r0, r1
	beq _02165B5C
	mov r0, #0xa
	add r1, sp, #0xc
	mul r0, r6
	add r2, r1, r0
	mov r7, #2
	mov r0, #1
	mov r1, #0
_02165B36:
	cmp r4, #4
	bne _02165B3E
	mov r4, r1
	b _02165B4E
_02165B3E:
	cmp r6, #2
	bhs _02165B46
	mov r3, r0
	b _02165B48
_02165B46:
	mov r3, r7
_02165B48:
	add r3, r4, r3
	lsl r3, r3, #0x10
	lsr r4, r3, #0x10
_02165B4E:
	lsl r3, r4, #1
	ldrh r3, [r2, r3]
	cmp r3, #0
	bne _02165B36
	mov r0, #2
	bl PlaySysMenuNavSfx
_02165B5C:
	ldr r0, _02165DA4 // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x40
	tst r0, r1
	beq _02165BA0
	cmp r6, #0
	bne _02165B94
	lsl r1, r4, #1
	add r0, sp, #0x20
	ldrh r0, [r0, r1]
	mov r6, #2
	cmp r0, #0
	beq _02165B9A
	mov r1, #4
	add r0, sp, #0xc
_02165B7A:
	cmp r4, #0
	bne _02165B82
	mov r4, r1
	b _02165B88
_02165B82:
	sub r2, r4, #1
	lsl r2, r2, #0x10
	lsr r4, r2, #0x10
_02165B88:
	lsl r2, r4, #1
	add r2, r0, r2
	ldrh r2, [r2, #0x14]
	cmp r2, #0
	bne _02165B7A
	b _02165B9A
_02165B94:
	sub r0, r6, #1
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
_02165B9A:
	mov r0, #2
	bl PlaySysMenuNavSfx
_02165BA0:
	ldr r0, _02165DA4 // =padInput
	ldrh r1, [r0, #8]
	mov r0, #0x80
	tst r0, r1
	beq _02165BEC
	cmp r6, #1
	bne _02165BD8
	lsl r1, r4, #1
	add r0, sp, #0x20
	ldrh r0, [r0, r1]
	mov r6, #2
	cmp r0, #0
	beq _02165BE6
	mov r1, #4
	add r0, sp, #0xc
_02165BBE:
	cmp r4, #0
	bne _02165BC6
	mov r4, r1
	b _02165BCC
_02165BC6:
	sub r2, r4, #1
	lsl r2, r2, #0x10
	lsr r4, r2, #0x10
_02165BCC:
	lsl r2, r4, #1
	add r2, r0, r2
	ldrh r2, [r2, #0x14]
	cmp r2, #0
	bne _02165BBE
	b _02165BE6
_02165BD8:
	cmp r6, #2
	bne _02165BE0
	mov r6, #0
	b _02165BE6
_02165BE0:
	add r0, r6, #1
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
_02165BE6:
	mov r0, #2
	bl PlaySysMenuNavSfx
_02165BEC:
	cmp r6, #2
	bhs _02165BFE
	cmp r6, #0
	bne _02165BF8
	mov r6, r4
	b _02165BFA
_02165BF8:
	add r6, r4, #5
_02165BFA:
	mov r4, #4
	b _02165C02
_02165BFE:
	mov r6, #0xb
	lsr r4, r4, #1
_02165C02:
	mov r0, r5
	bl FriendCodeMenu__Func_21666D0
	mov r7, r0
	cmp r7, #0xa
	bge _02165C12
	mov r6, r7
	mov r4, #4
_02165C12:
	mov r0, r5
	bl FriendCodeMenu__Func_2166704
	cmp r0, #2
	bne _02165C24
	ldr r1, [r5, #0x14]
	cmp r1, #0xc
	bge _02165C24
	mov r0, #4
_02165C24:
	cmp r0, #1
	bne _02165C30
	ldr r1, [r5, #0x14]
	cmp r1, #0
	bne _02165C30
	mov r0, #4
_02165C30:
	cmp r0, #3
	bge _02165C38
	mov r4, r0
	mov r6, #0xb
_02165C38:
	ldr r0, [r5, #0x30]
	cmp r0, r6
	beq _02165C4E
	ldr r0, _02165DA8 // =0x00000424
	mov r1, #0x37
	add r0, r5, r0
	str r6, [r5, #0x30]
	bl AnimatorSprite__SetAnimation
	mov r0, #0
	str r0, [r5, #0x34]
_02165C4E:
	ldr r0, [r5, #0x38]
	cmp r0, r4
	beq _02165C60
	ldr r0, _02165DAC // =0x0000067C
	mov r1, #0x38
	add r0, r5, r0
	str r4, [r5, #0x38]
	bl AnimatorSprite__SetAnimation
_02165C60:
	cmp r7, #0xa
	bge _02165C84
	mov r0, r7
	bl FriendCodeMenu__Func_216676C
	mov r1, r0
	mov r0, r5
	bl FriendCodeMenu__Func_2166084
	ldr r0, _02165DA8 // =0x00000424
	mov r1, #0x37
	add r0, r5, r0
	bl AnimatorSprite__SetAnimation
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _02165D52
_02165C84:
	ldr r0, [r5, #0x30]
	cmp r0, #0xa
	bge _02165CA8
	ldr r1, _02165DA4 // =padInput
	ldrh r2, [r1, #8]
	mov r1, #1
	tst r1, r2
	beq _02165CA8
	bl FriendCodeMenu__Func_216676C
	mov r1, r0
	mov r0, r5
	bl FriendCodeMenu__Func_2166084
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _02165D52
_02165CA8:
	ldr r1, [r5, #0x14]
	cmp r1, #0
	ble _02165CF8
	ldr r0, _02165DA4 // =padInput
	mov r2, #2
	ldrh r0, [r0, #8]
	tst r2, r0
	bne _02165CCA
	ldr r2, [sp, #8]
	cmp r2, #1
	beq _02165CCA
	ldr r2, [r5, #0x38]
	cmp r2, #1
	bne _02165CF8
	mov r2, #1
	tst r0, r2
	beq _02165CF8
_02165CCA:
	mov r0, r5
	bl FriendCodeMenu__Func_21660C4
	ldr r0, [r5, #0x14]
	cmp r0, #0xc
	bge _02165CE0
	ldr r0, [r5, #0x38]
	cmp r0, #2
	bne _02165CE0
	mov r0, #1
	str r0, [r5, #0x38]
_02165CE0:
	ldr r0, [r5, #0x14]
	cmp r0, #0
	bne _02165CF0
	ldr r0, [r5, #0x38]
	cmp r0, #1
	bne _02165CF0
	mov r0, #0
	str r0, [r5, #0x38]
_02165CF0:
	mov r0, #1
	bl PlaySysMenuNavSfx
	b _02165D52
_02165CF8:
	ldr r0, _02165DA4 // =padInput
	mov r2, #8
	ldrh r0, [r0, #4]
	tst r2, r0
	beq _02165D16
	cmp r1, #0xc
	bne _02165D52
	mov r0, #0xb
	str r0, [r5, #0x30]
	mov r0, #2
	str r0, [r5, #0x38]
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _02165D52
_02165D16:
	cmp r1, #0xc
	bne _02165D38
	ldr r1, [r5, #0x38]
	cmp r1, #2
	bne _02165D26
	mov r1, #1
	tst r1, r0
	bne _02165D2C
_02165D26:
	ldr r1, [sp, #8]
	cmp r1, #2
	bne _02165D38
_02165D2C:
	mov r0, #1
	str r0, [sp, #4]
	mov r0, #0
	bl PlaySysMenuNavSfx
	b _02165D52
_02165D38:
	ldr r1, [r5, #0x38]
	cmp r1, #0
	bne _02165D44
	mov r1, #1
	tst r0, r1
	bne _02165D4A
_02165D44:
	ldr r0, [sp, #8]
	cmp r0, #0
	bne _02165D52
_02165D4A:
	mov r0, #1
	str r0, [sp]
	bl PlaySysMenuNavSfx
_02165D52:
	mov r0, r5
	bl FriendCodeMenu__Func_21661B0
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _02165D8C
	ldr r1, [r5, #0]
	mov r0, #2
	tst r1, r0
	beq _02165D78
	mov r0, #0
	str r0, [r5, #0x1c]
	mov r0, #1
	str r0, [r5, #0x18]
	ldr r1, _02165DB0 // =FriendCodeMenu__State_216602C
	ldr r0, _02165DB4 // =0x00000C4C
	add sp, #0x2c
	str r1, [r5, r0]
	pop {r4, r5, r6, r7, pc}
_02165D78:
	str r0, [r5, #4]
	mov r0, #1
	str r0, [r5, #0x20]
	mov r0, #0
	str r0, [r5, #0x1c]
	ldr r1, _02165DB8 // =FriendCodeMenu__State_2165DBC
	ldr r0, _02165DB4 // =0x00000C4C
	add sp, #0x2c
	str r1, [r5, r0]
	pop {r4, r5, r6, r7, pc}
_02165D8C:
	ldr r0, [sp]
	cmp r0, #0
	beq _02165D9E
	mov r0, #0
	str r0, [r5, #0x1c]
	str r0, [r5, #0x18]
	ldr r1, _02165DB0 // =FriendCodeMenu__State_216602C
	ldr r0, _02165DB4 // =0x00000C4C
	str r1, [r5, r0]
_02165D9E:
	add sp, #0x2c
	pop {r4, r5, r6, r7, pc}
	nop
_02165DA4: .word padInput
_02165DA8: .word 0x00000424
_02165DAC: .word 0x0000067C
_02165DB0: .word FriendCodeMenu__State_216602C
_02165DB4: .word 0x00000C4C
_02165DB8: .word FriendCodeMenu__State_2165DBC
	thumb_func_end FriendCodeMenu__State_2165A84

	thumb_func_start FriendCodeMenu__State_2165DBC
FriendCodeMenu__State_2165DBC: // 0x02165DBC
	push {r3, r4, lr}
	sub sp, #4
	mov r4, r0
	bl FriendCodeMenu__Func_21661B0
	ldr r0, [r4, #0x20]
	cmp r0, #0
	bne _02165E18
	ldr r0, [r4, #0x24]
	cmp r0, #0
	beq _02165DEA
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _02165DEA
	mov r0, #3
	str r0, [r4, #4]
	mov r0, #1
	str r0, [r4, #0x18]
	ldr r1, _02165E1C // =FriendCodeMenu__State_216602C
	ldr r0, _02165E20 // =0x00000C4C
	add sp, #4
	str r1, [r4, r0]
	pop {r3, r4, pc}
_02165DEA:
	mov r0, #0xb1
	lsl r0, r0, #4
	mov r3, #0
	add r0, r4, r0
	mov r1, #1
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	mov r0, #0xb1
	lsl r0, r0, #4
	add r0, r4, r0
	bl FontWindowAnimator__StartAnimating
	mov r0, r4
	mov r1, #1
	bl FriendCodeMenu__SetupBlending
	mov r0, #1
	str r0, [r4, #4]
	ldr r1, _02165E24 // =FriendCodeMenu__State_2165E28
	ldr r0, _02165E20 // =0x00000C4C
	str r1, [r4, r0]
_02165E18:
	add sp, #4
	pop {r3, r4, pc}
	.align 2, 0
_02165E1C: .word FriendCodeMenu__State_216602C
_02165E20: .word 0x00000C4C
_02165E24: .word FriendCodeMenu__State_2165E28
	thumb_func_end FriendCodeMenu__State_2165DBC

	thumb_func_start FriendCodeMenu__State_2165E28
FriendCodeMenu__State_2165E28: // 0x02165E28
	push {r4, lr}
	mov r4, r0
	ldr r0, _02165EE0 // =0x04001000
	mov r1, #0x1f
	ldr r2, [r0, #0]
	lsl r1, r1, #8
	and r1, r2
	lsr r3, r1, #8
	ldr r2, [r0, #0]
	ldr r1, _02165EE4 // =0xFFFFE0FF
	and r2, r1
	mov r1, #2
	orr r1, r3
	lsl r1, r1, #8
	orr r1, r2
	str r1, [r0]
	mov r0, #0xb1
	lsl r0, r0, #4
	add r0, r4, r0
	bl FontWindowAnimator__ProcessWindowAnim
	mov r0, #0xb1
	lsl r0, r0, #4
	add r0, r4, r0
	bl FontWindowAnimator__Draw
	mov r0, r4
	bl FriendCodeMenu__Func_21661B0
	mov r0, #0xb1
	lsl r0, r0, #4
	add r0, r4, r0
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	beq _02165EDE
	mov r0, #0xb1
	lsl r0, r0, #4
	add r0, r4, r0
	bl FontWindowAnimator__SetWindowOpen
	ldr r0, [r4, #0x24]
	cmp r0, #0
	ldr r0, _02165EE8 // =0x00000A4C
	bne _02165E8C
	add r0, r4, r0
	mov r1, #0
	bl FontAnimator__SetMsgSequence
	b _02165E94
_02165E8C:
	add r0, r4, r0
	mov r1, #2
	bl FontAnimator__SetMsgSequence
_02165E94:
	ldr r0, _02165EE8 // =0x00000A4C
	mov r1, #1
	add r0, r4, r0
	mov r2, #0
	bl FontAnimator__InitStartPos
	ldr r0, _02165EE8 // =0x00000A4C
	mov r1, #0
	add r0, r4, r0
	bl FontAnimator__GetDialogLineCount
	mov r1, r0
	lsl r2, r1, #4
	mov r1, #0x30
	ldr r0, _02165EE8 // =0x00000A4C
	sub r1, r1, r2
	lsl r1, r1, #0xf
	add r0, r4, r0
	asr r1, r1, #0x10
	bl FontAnimator__AdvanceLine
	ldr r0, _02165EE8 // =0x00000A4C
	add r0, r4, r0
	bl FontAnimator__ClearPixels
	ldr r0, _02165EE8 // =0x00000A4C
	mov r1, #0
	add r0, r4, r0
	bl FontAnimator__LoadCharacters
	ldr r0, _02165EE8 // =0x00000A4C
	add r0, r4, r0
	bl FontAnimator__Draw
	ldr r1, _02165EEC // =FriendCodeMenu__State_2165EF4
	ldr r0, _02165EF0 // =0x00000C4C
	str r1, [r4, r0]
_02165EDE:
	pop {r4, pc}
	.align 2, 0
_02165EE0: .word 0x04001000
_02165EE4: .word 0xFFFFE0FF
_02165EE8: .word 0x00000A4C
_02165EEC: .word FriendCodeMenu__State_2165EF4
_02165EF0: .word 0x00000C4C
	thumb_func_end FriendCodeMenu__State_2165E28

	thumb_func_start FriendCodeMenu__State_2165EF4
FriendCodeMenu__State_2165EF4: // 0x02165EF4
	push {r3, r4, lr}
	sub sp, #4
	mov r4, r0
	ldr r0, _02165F98 // =0x04001000
	mov r1, #0x1f
	ldr r2, [r0, #0]
	lsl r1, r1, #8
	and r1, r2
	lsr r3, r1, #8
	ldr r2, [r0, #0]
	ldr r1, _02165F9C // =0xFFFFE0FF
	and r2, r1
	mov r1, #1
	orr r1, r3
	lsl r1, r1, #8
	orr r1, r2
	str r1, [r0]
	ldr r0, _02165FA0 // =0x00000A4C
	mov r1, #0
	add r0, r4, r0
	bl FontAnimator__LoadCharacters
	ldr r0, _02165FA0 // =0x00000A4C
	add r0, r4, r0
	bl FontAnimator__Draw
	mov r0, r4
	bl FriendCodeMenu__Func_21661B0
	ldr r0, _02165FA0 // =0x00000A4C
	add r0, r4, r0
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	beq _02165F92
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02165F4C
	ldr r0, _02165FA4 // =touchInput
	ldrh r1, [r0, #0x12]
	mov r0, #4
	tst r0, r1
	bne _02165F54
_02165F4C:
	ldr r0, _02165FA8 // =padInput
	ldrh r0, [r0, #4]
	cmp r0, #0
	beq _02165F92
_02165F54:
	ldr r0, _02165F98 // =0x04001000
	mov r1, #0x1f
	ldr r2, [r0, #0]
	lsl r1, r1, #8
	and r1, r2
	lsr r3, r1, #8
	ldr r2, [r0, #0]
	ldr r1, _02165F9C // =0xFFFFE0FF
	and r2, r1
	mov r1, #1
	bic r3, r1
	lsl r1, r3, #8
	orr r1, r2
	str r1, [r0]
	mov r0, #0xb1
	lsl r0, r0, #4
	mov r3, #0
	add r0, r4, r0
	mov r1, #4
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	mov r0, #0xb1
	lsl r0, r0, #4
	add r0, r4, r0
	bl FontWindowAnimator__StartAnimating
	ldr r1, _02165FAC // =FriendCodeMenu__State_2165FB4
	ldr r0, _02165FB0 // =0x00000C4C
	str r1, [r4, r0]
_02165F92:
	add sp, #4
	pop {r3, r4, pc}
	nop
_02165F98: .word 0x04001000
_02165F9C: .word 0xFFFFE0FF
_02165FA0: .word 0x00000A4C
_02165FA4: .word touchInput
_02165FA8: .word padInput
_02165FAC: .word FriendCodeMenu__State_2165FB4
_02165FB0: .word 0x00000C4C
	thumb_func_end FriendCodeMenu__State_2165EF4

	thumb_func_start FriendCodeMenu__State_2165FB4
FriendCodeMenu__State_2165FB4: // 0x02165FB4
	push {r4, lr}
	mov r4, r0
	mov r0, #0xb1
	lsl r0, r0, #4
	add r0, r4, r0
	bl FontWindowAnimator__ProcessWindowAnim
	mov r0, #0xb1
	lsl r0, r0, #4
	add r0, r4, r0
	bl FontWindowAnimator__Draw
	mov r0, r4
	bl FriendCodeMenu__Func_21661B0
	mov r0, #0xb1
	lsl r0, r0, #4
	add r0, r4, r0
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	beq _02166018
	ldr r0, _0216601C // =0x04001000
	mov r1, #0x1f
	ldr r2, [r0, #0]
	lsl r1, r1, #8
	and r1, r2
	lsr r3, r1, #8
	ldr r2, [r0, #0]
	ldr r1, _02166020 // =0xFFFFE0FF
	and r2, r1
	mov r1, #2
	bic r3, r1
	lsl r1, r3, #8
	orr r1, r2
	str r1, [r0]
	mov r0, #0xb1
	lsl r0, r0, #4
	add r0, r4, r0
	bl FontWindowAnimator__SetWindowOpen
	mov r0, r4
	mov r1, #0
	bl FriendCodeMenu__SetupBlending
	mov r0, #1
	str r0, [r4, #0x1c]
	ldr r1, _02166024 // =FriendCodeMenu__State_2165A84
	ldr r0, _02166028 // =0x00000C4C
	str r1, [r4, r0]
_02166018:
	pop {r4, pc}
	nop
_0216601C: .word 0x04001000
_02166020: .word 0xFFFFE0FF
_02166024: .word FriendCodeMenu__State_2165A84
_02166028: .word 0x00000C4C
	thumb_func_end FriendCodeMenu__State_2165FB4

	thumb_func_start FriendCodeMenu__State_216602C
FriendCodeMenu__State_216602C: // 0x0216602C
	push {r4, lr}
	ldr r2, [r0, #0]
	mov r1, #1
	tst r2, r1
	beq _02166048
	ldr r3, _02166078 // =renderCoreGFXControlA+0x00000040
	mov r2, #0x18
	ldrsh r2, [r3, r2]
	cmp r2, #0x10
	bge _0216605A
	add r1, r2, #1
	strh r1, [r3, #0x18]
	mov r1, #0
	b _0216605A
_02166048:
	ldr r3, _02166078 // =renderCoreGFXControlA+0x00000040
	mov r2, #0x18
	ldrsh r4, [r3, r2]
	sub r2, #0x28
	cmp r4, r2
	ble _0216605A
	sub r1, r4, #1
	strh r1, [r3, #0x18]
	mov r1, #0
_0216605A:
	ldr r3, _02166078 // =renderCoreGFXControlA+0x00000040
	mov r2, #0x18
	ldrsh r3, [r3, r2]
	ldr r2, _0216607C // =renderCoreGFXControlB+0x00000040
	cmp r1, #0
	strh r3, [r2, #0x18]
	beq _02166070
	ldr r1, _02166080 // =0x00000C4C
	mov r2, #0
	str r2, [r0, r1]
	pop {r4, pc}
_02166070:
	bl FriendCodeMenu__Func_21661B0
	pop {r4, pc}
	nop
_02166078: .word renderCoreGFXControlA+0x00000040
_0216607C: .word renderCoreGFXControlB+0x00000040
_02166080: .word 0x00000C4C
	thumb_func_end FriendCodeMenu__State_216602C

	thumb_func_start FriendCodeMenu__Func_2166084
FriendCodeMenu__Func_2166084: // 0x02166084
	push {r3, r4, r5, lr}
	mov r4, r1
	mov r5, r0
	mov r0, r4
	bl FriendCodeMenu__Func_2166778
	mov r2, r0
	ldr r0, [r5, #0x14]
	cmp r0, #0xc
	bge _0216609E
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	b _021660A0
_0216609E:
	mov r1, #0xb
_021660A0:
	add r0, r5, r1
	strb r4, [r0, #8]
	add r0, r1, #1
	str r0, [r5, #0x14]
	mov r0, r5
	bl FriendCodeMenu__Func_21660F8
	ldr r0, _021660C0 // =0x000004EC
	mov r1, #0x1e
	add r0, r5, r0
	bl AnimatorSprite__SetAnimation
	mov r0, #0x10
	str r0, [r5, #0x34]
	pop {r3, r4, r5, pc}
	nop
_021660C0: .word 0x000004EC
	thumb_func_end FriendCodeMenu__Func_2166084

	thumb_func_start FriendCodeMenu__Func_21660C4
FriendCodeMenu__Func_21660C4: // 0x021660C4
	push {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x14]
	cmp r1, #0
	beq _021660F0
	sub r1, r1, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	mov r3, #0x20
	add r2, r4, r1
	strb r3, [r2, #8]
	ldr r2, [r4, #0x14]
	sub r2, r2, #1
	str r2, [r4, #0x14]
	mov r2, #0
	bl FriendCodeMenu__Func_21660F8
	ldr r0, _021660F4 // =0x000004EC
	mov r1, #0x1e
	add r0, r4, r0
	bl AnimatorSprite__SetAnimation
_021660F0:
	pop {r4, pc}
	nop
_021660F4: .word 0x000004EC
	thumb_func_end FriendCodeMenu__Func_21660C4

	thumb_func_start FriendCodeMenu__Func_21660F8
FriendCodeMenu__Func_21660F8: // 0x021660F8
	push {r4, r5, r6, r7, lr}
	sub sp, #0x24
	mov r4, r1
	mov r5, r0
	str r2, [sp, #0x1c]
	cmp r4, #6
	bhs _0216610E
	lsl r0, r4, #0x14
	lsr r7, r0, #0x10
	mov r6, #6
	b _0216611A
_0216610E:
	sub r0, r4, #6
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	lsl r0, r4, #0x14
	lsr r7, r0, #0x10
	mov r6, #0x16
_0216611A:
	ldr r0, _021661A4 // =0x00000B74
	ldr r0, [r5, r0]
	bl FontWindow__GetFont
	ldr r1, [sp, #0x1c]
	str r0, [sp, #0x20]
	bl FontFile__GetCharXAdvance
	ldr r0, [sp, #0x20]
	mov r1, #0
	bl FontFile__GetPixels
	mov r1, #0x10
	str r1, [sp]
	str r1, [sp, #4]
	ldr r1, _021661A8 // =0x00000A48
	mov r2, #0
	ldr r1, [r5, r1]
	mov r3, r2
	str r1, [sp, #8]
	mov r1, #0xc
	str r1, [sp, #0xc]
	str r7, [sp, #0x10]
	str r6, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r1, #2
	bl BackgroundUnknown__CopyPixels
	ldr r0, [sp, #0x1c]
	cmp r0, #0
	beq _02166182
	mov r0, #0xc
	str r0, [sp]
	mov r0, #5
	str r0, [sp, #4]
	lsl r0, r7, #0x10
	asr r0, r0, #0x10
	str r0, [sp, #8]
	lsl r0, r6, #0x10
	asr r0, r0, #0x10
	str r0, [sp, #0xc]
	mov r2, #0
	str r2, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r0, #1
	str r0, [sp, #0x18]
	ldr r3, _021661A8 // =0x00000A48
	ldr r0, [sp, #0x20]
	ldr r1, [sp, #0x1c]
	ldr r3, [r5, r3]
	bl FontFile__Func_2052B7C
_02166182:
	add r3, r4, #1
	mov r0, #4
	lsl r3, r3, #1
	str r0, [sp]
	ldr r0, _021661AC // =0x00000A18
	sub r3, r3, #1
	lsl r1, r4, #0x11
	lsl r3, r3, #0x10
	add r0, r5, r0
	lsr r1, r1, #0x10
	mov r2, #0
	lsr r3, r3, #0x10
	bl Unknown2056570__Func_2056958
	add sp, #0x24
	pop {r4, r5, r6, r7, pc}
	nop
_021661A4: .word 0x00000B74
_021661A8: .word 0x00000A48
_021661AC: .word 0x00000A18
	thumb_func_end FriendCodeMenu__Func_21660F8

	thumb_func_start FriendCodeMenu__Func_21661B0
FriendCodeMenu__Func_21661B0: // 0x021661B0
	push {r4, lr}
	mov r4, r0
	bl FriendCodeMenu__Func_2166398
	mov r0, r4
	bl FriendCodeMenu__Func_21661C8
	mov r0, r4
	bl FriendCodeMenu__Func_216628C
	pop {r4, pc}
	.align 2, 0
	thumb_func_end FriendCodeMenu__Func_21661B0

	thumb_func_start FriendCodeMenu__Func_21661C8
FriendCodeMenu__Func_21661C8: // 0x021661C8
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #8]
	mov r0, #0x23
	str r0, [sp, #4]
	ldr r0, [sp]
	ldr r5, [sp]
	str r0, [sp, #0x10]
	add r0, #0x34
	str r0, [sp, #0x10]
	ldr r1, _02166288 // =0x00000424
	ldr r0, [sp]
	mov r4, #0x34
	add r0, r0, r1
	mov r6, #0x54
	add r5, #0x3c
	str r0, [sp, #0xc]
_021661EE:
	ldr r0, [sp, #8]
	cmp r0, #5
	bne _021661FC
	add r6, #0x20
	lsl r0, r6, #0x10
	asr r6, r0, #0x10
	mov r4, #0x34
_021661FC:
	ldr r0, [sp, #4]
	lsl r0, r0, #0x10
	lsr r7, r0, #0x10
	ldr r0, [sp]
	ldr r0, [r0, #0x1c]
	cmp r0, #0
	beq _02166240
	ldr r0, [sp]
	ldr r1, [r0, #0x30]
	ldr r0, [sp, #8]
	cmp r1, r0
	bne _02166240
	ldr r0, [sp, #0xc]
	mov r1, #0
	strh r4, [r0, #8]
	mov r2, r1
	strh r6, [r0, #0xa]
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp, #0xc]
	bl AnimatorSprite__DrawFrame
	ldr r0, [sp]
	ldr r0, [r0, #0x34]
	cmp r0, #0
	beq _02166240
	add r0, r7, #1
	lsl r0, r0, #0x10
	lsr r7, r0, #0x10
	ldr r0, [sp, #0x10]
	ldr r0, [r0, #0]
	sub r1, r0, #1
	ldr r0, [sp, #0x10]
	str r1, [r0]
_02166240:
	ldrh r0, [r5, #0xc]
	cmp r7, r0
	beq _0216624E
	mov r0, r5
	mov r1, r7
	bl AnimatorSprite__SetAnimation
_0216624E:
	mov r0, r4
	add r0, #0xc
	strh r0, [r5, #8]
	mov r0, r6
	add r0, #0xc
	mov r1, #0
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	add r4, #0x20
	lsl r0, r4, #0x10
	asr r4, r0, #0x10
	ldr r0, [sp, #4]
	add r5, #0x64
	add r0, r0, #2
	str r0, [sp, #4]
	ldr r0, [sp, #8]
	add r0, r0, #1
	str r0, [sp, #8]
	cmp r0, #0xa
	blt _021661EE
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	nop
_02166288: .word 0x00000424
	thumb_func_end FriendCodeMenu__Func_21661C8

	thumb_func_start FriendCodeMenu__Func_216628C
FriendCodeMenu__Func_216628C: // 0x0216628C
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x20
	mov r7, r0
	ldr r0, [r7, #0x1c]
	cmp r0, #0
	bne _021662A4
	mov r0, #2
	add r1, sp, #0x18
	mov r2, #6
	bl MIi_CpuClear16
	b _021662CA
_021662A4:
	mov r2, #0
	add r0, sp, #0x18
	strh r2, [r0]
	ldr r1, [r7, #0x14]
	cmp r1, #0
	ble _021662B4
	strh r2, [r0, #2]
	b _021662B8
_021662B4:
	mov r1, #2
	strh r1, [r0, #2]
_021662B8:
	ldr r0, [r7, #0x14]
	cmp r0, #0xc
	add r0, sp, #0x18
	blt _021662C6
	mov r1, #0
	strh r1, [r0, #4]
	b _021662CA
_021662C6:
	mov r1, #2
	strh r1, [r0, #4]
_021662CA:
	mov r0, #0
	str r0, [sp, #0x10]
	str r0, [sp, #0xc]
	str r0, [sp, #4]
	ldr r0, _0216638C // =0x0000067C
	mov r6, #0x14
	add r0, r7, r0
	str r0, [sp]
	mov r0, r7
	str r0, [sp, #0x14]
	add r0, #0x3c
	str r7, [sp, #8]
	add r5, sp, #0x18
	str r0, [sp, #0x14]
_021662E6:
	ldr r1, [sp, #0xc]
	ldr r0, _02166390 // =0x00000514
	add r1, r1, r0
	ldr r0, [sp, #0x14]
	add r4, r0, r1
	ldr r1, [sp, #8]
	ldr r0, _02166394 // =0x0000096C
	ldr r0, [r1, r0]
	mov r1, #0xa0
	strh r6, [r4, #8]
	strh r1, [r4, #0xa]
	ldrh r1, [r5, #0]
	cmp r1, #2
	beq _0216631A
	mov r1, #2
	lsl r1, r1, #0xa
	tst r1, r0
	bne _02166316
	mov r1, #0x10
	tst r0, r1
	beq _02166316
	mov r0, #1
	strh r0, [r5]
	b _0216631A
_02166316:
	mov r0, #0
	strh r0, [r5]
_0216631A:
	ldrh r1, [r5, #0]
	ldr r0, [sp, #4]
	add r0, r1, r0
	strh r0, [r5]
	ldrh r1, [r5, #0]
	ldrh r0, [r4, #0xc]
	cmp r0, r1
	beq _02166330
	mov r0, r4
	bl AnimatorSprite__SetAnimation
_02166330:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	ldr r0, [r7, #0x1c]
	cmp r0, #0
	beq _02166364
	ldr r1, [r7, #0x38]
	ldr r0, [sp, #0x10]
	cmp r0, r1
	bne _02166364
	ldr r0, [sp]
	mov r1, #0xa0
	strh r6, [r0, #8]
	strh r1, [r0, #0xa]
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [sp]
	bl AnimatorSprite__DrawFrame
_02166364:
	add r6, #0x48
	lsl r0, r6, #0x10
	asr r6, r0, #0x10
	ldr r0, [sp, #0xc]
	add r5, r5, #2
	add r0, #0x64
	str r0, [sp, #0xc]
	ldr r0, [sp, #8]
	add r0, #0x38
	str r0, [sp, #8]
	ldr r0, [sp, #4]
	add r0, r0, #3
	str r0, [sp, #4]
	ldr r0, [sp, #0x10]
	add r0, r0, #1
	str r0, [sp, #0x10]
	cmp r0, #3
	blt _021662E6
	add sp, #0x20
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216638C: .word 0x0000067C
_02166390: .word 0x00000514
_02166394: .word 0x0000096C
	thumb_func_end FriendCodeMenu__Func_216628C

	thumb_func_start FriendCodeMenu__Func_2166398
FriendCodeMenu__Func_2166398: // 0x02166398
	push {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, _021663FC // =0x00000A18
	add r0, r4, r0
	bl Unknown2056570__Func_2056A58
	ldr r0, _021663FC // =0x00000A18
	add r0, r4, r0
	bl Unknown2056570__Func_2056A94
	ldr r5, _02166400 // =0x00000488
	mov r1, #0
	add r0, r4, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, r5
	bl AnimatorSprite__DrawFrame
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	beq _021663FA
	ldr r1, [r4, #0x14]
	cmp r1, #0xc
	blt _021663CC
	mov r1, #0xb
_021663CC:
	ldr r0, _02166404 // =0x000004EC
	add r4, r4, r0
	cmp r1, #6
	bge _021663DE
	lsl r0, r1, #4
	add r0, #0x50
	strh r0, [r4, #8]
	mov r0, #0xe
	b _021663E8
_021663DE:
	sub r0, r1, #6
	lsl r0, r0, #4
	add r0, #0x50
	strh r0, [r4, #8]
	mov r0, #0x1e
_021663E8:
	mov r1, #0
	strh r0, [r4, #0xa]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
_021663FA:
	pop {r3, r4, r5, pc}
	.align 2, 0
_021663FC: .word 0x00000A18
_02166400: .word 0x00000488
_02166404: .word 0x000004EC
	thumb_func_end FriendCodeMenu__Func_2166398

	thumb_func_start FriendCodeMenu__Func_2166408
FriendCodeMenu__Func_2166408: // 0x02166408
	push {r4, r5, r6, lr}
	mov r5, r0
	mov r6, r1
	mov r4, #1
	bl FriendCodeMenu__Func_2166398
	mov r0, r5
	mov r1, r6
	bl FriendCodeMenu__Func_2166434
	cmp r0, #0
	bne _02166422
	mov r4, #0
_02166422:
	mov r0, r5
	mov r1, r6
	bl FriendCodeMenu__Func_21664F0
	cmp r0, #0
	bne _02166430
	mov r4, #0
_02166430:
	mov r0, r4
	pop {r4, r5, r6, pc}
	thumb_func_end FriendCodeMenu__Func_2166408

	thumb_func_start FriendCodeMenu__Func_2166434
FriendCodeMenu__Func_2166434: // 0x02166434
	push {r4, r5, r6, r7, lr}
	sub sp, #0x24
	mov r5, r0
	mov r0, #1
	str r1, [sp]
	ldr r3, _021664EC // =ovl03_0217DFA8
	str r0, [sp, #0xc]
	add r2, sp, #0x10
	mov r1, #0xa
_02166446:
	ldrh r0, [r3, #0]
	add r3, r3, #2
	strh r0, [r2]
	add r2, r2, #2
	sub r1, r1, #1
	bne _02166446
	mov r0, #0
	str r0, [sp, #8]
	mov r0, #0x23
	mov r6, #0x34
	mov r7, #0x54
	add r4, sp, #0x10
	add r5, #0x3c
	str r0, [sp, #4]
_02166462:
	ldr r0, [sp, #8]
	cmp r0, #5
	bne _02166470
	add r7, #0x20
	lsl r0, r7, #0x10
	asr r7, r0, #0x10
	mov r6, #0x34
_02166470:
	ldrh r1, [r4, #0]
	ldr r0, [sp]
	cmp r1, r0
	bhi _021664C8
	ldr r0, [sp, #4]
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	ldrh r0, [r5, #0xc]
	cmp r1, r0
	beq _0216648A
	mov r0, r5
	bl AnimatorSprite__SetAnimation
_0216648A:
	mov r0, r6
	add r0, #0xc
	strh r0, [r5, #8]
	mov r0, r7
	add r0, #0xc
	mov r1, #0
	strh r0, [r5, #0xa]
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldrh r1, [r4, #0]
	ldr r0, [sp]
	sub r0, r0, r1
	cmp r0, #0x14
	blo _021664B2
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	b _021664CC
_021664B2:
	bl FriendCodeMenu__Func_2166590
	mov r1, r0
	mov r0, r5
	mov r2, r1
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
	mov r0, #0
	str r0, [sp, #0xc]
	b _021664CC
_021664C8:
	mov r0, #0
	str r0, [sp, #0xc]
_021664CC:
	add r6, #0x20
	lsl r0, r6, #0x10
	asr r6, r0, #0x10
	ldr r0, [sp, #4]
	add r4, r4, #2
	add r0, r0, #2
	str r0, [sp, #4]
	ldr r0, [sp, #8]
	add r5, #0x64
	add r0, r0, #1
	str r0, [sp, #8]
	cmp r0, #0xa
	blt _02166462
	ldr r0, [sp, #0xc]
	add sp, #0x24
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_021664EC: .word ovl03_0217DFA8
	thumb_func_end FriendCodeMenu__Func_2166434

	thumb_func_start FriendCodeMenu__Func_21664F0
FriendCodeMenu__Func_21664F0: // 0x021664F0
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	str r0, [sp, #4]
	mov r0, #0
	str r0, [sp, #0x10]
	str r0, [sp, #0xc]
	ldr r0, [sp, #4]
	mov r5, #0x14
	add r0, #0x3c
	str r1, [sp, #8]
	mov r6, r5
	mov r7, #2
	str r0, [sp, #4]
_0216650A:
	ldr r0, [sp, #8]
	cmp r5, r0
	bhi _02166560
	ldr r1, [sp, #0xc]
	ldr r0, _0216658C // =0x00000514
	add r1, r1, r0
	ldr r0, [sp, #4]
	add r4, r0, r1
	ldr r0, [sp, #8]
	sub r3, r0, r5
	cmp r3, #8
	blo _02166526
	mov r0, #0xa0
	b _0216653C
_02166526:
	mov r0, #2
	lsl r0, r0, #0xc
	str r0, [sp]
	mov r0, #0x40
	mov r1, #0
	mov r2, #8
	bl Unknown2051334__Func_2051534
	add r0, #0xa0
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
_0216653C:
	strh r6, [r4, #8]
	strh r0, [r4, #0xa]
	lsl r0, r7, #0x10
	lsr r1, r0, #0x10
	ldrh r0, [r4, #0xc]
	cmp r0, r1
	beq _02166550
	mov r0, r4
	bl AnimatorSprite__SetAnimation
_02166550:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
_02166560:
	add r6, #0x48
	lsl r0, r6, #0x10
	asr r6, r0, #0x10
	ldr r0, [sp, #0xc]
	add r5, r5, #4
	add r0, #0x64
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x10]
	add r7, r7, #3
	add r0, r0, #1
	str r0, [sp, #0x10]
	cmp r0, #3
	blt _0216650A
	ldr r0, [sp, #8]
	cmp r0, #0x28
	blo _02166586
	add sp, #0x14
	mov r0, #1
	pop {r4, r5, r6, r7, pc}
_02166586:
	mov r0, #0
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_0216658C: .word 0x00000514
	thumb_func_end FriendCodeMenu__Func_21664F0

	thumb_func_start FriendCodeMenu__Func_2166590
FriendCodeMenu__Func_2166590: // 0x02166590
	push {r3, lr}
	mov r3, r0
	cmp r3, #0x14
	blo _0216659E
	mov r0, #1
	lsl r0, r0, #0xc
	pop {r3, pc}
_0216659E:
	cmp r3, #0xc
	bhs _021665B2
	mov r1, #6
	mov r0, #0
	lsl r1, r1, #0xa
	mov r2, #0xc
	str r0, [sp]
	bl Unknown2051334__Func_2051534
	pop {r3, pc}
_021665B2:
	mov r1, #2
	lsl r1, r1, #0xc
	mov r0, #6
	str r1, [sp]
	lsl r0, r0, #0xa
	lsr r1, r1, #1
	mov r2, #8
	sub r3, #0xc
	bl Unknown2051334__Func_2051534
	pop {r3, pc}
	thumb_func_end FriendCodeMenu__Func_2166590

	thumb_func_start FriendCodeMenu__SetupBlending
FriendCodeMenu__SetupBlending: // 0x021665C8
	push {r3, r4, r5, r6, r7, lr}
	ldr r0, _021666B8 // =VRAMSystem__GFXControl
	ldr r2, [r0, #0]
	ldr r4, [r0, #4]
	add r2, #0x20
	add r4, #0x20
	cmp r1, #0
	beq _021666A0
	ldrh r1, [r2, #0]
	mov r3, #1
	mov r0, #1
	bic r1, r3
	orr r0, r1
	strh r0, [r2]
	ldrh r1, [r2, #0]
	mov r0, #2
	mov r5, #8
	orr r0, r1
	strh r0, [r2]
	ldrh r1, [r2, #0]
	mov r0, #4
	ldr r6, _021666BC // =0xFFFFFBFF
	orr r0, r1
	strh r0, [r2]
	ldrh r0, [r2, #0]
	orr r0, r5
	strh r0, [r2]
	ldrh r1, [r2, #0]
	mov r0, #0x10
	orr r0, r1
	strh r0, [r2]
	ldrh r1, [r2, #0]
	ldr r0, _021666C0 // =0xFFFFFEFF
	and r0, r1
	strh r0, [r2]
	ldrh r1, [r2, #0]
	ldr r0, _021666C4 // =0xFFFFFDFF
	and r0, r1
	strh r0, [r2]
	ldrh r0, [r2, #0]
	and r0, r6
	strh r0, [r2]
	ldrh r1, [r2, #0]
	ldr r0, _021666C8 // =0xFFFFF7FF
	and r0, r1
	strh r0, [r2]
	ldrh r1, [r2, #0]
	ldr r0, _021666CC // =0xFFFFEFFF
	and r0, r1
	strh r0, [r2]
	ldrh r7, [r2, #0]
	mov r0, #0xc0
	mov r1, #0xc0
	bic r7, r0
	orr r1, r7
	strh r1, [r2]
	ldrh r7, [r2, #4]
	mov r1, #0x1f
	bic r7, r1
	orr r7, r5
	strh r7, [r2, #4]
	ldrh r2, [r4, #0]
	bic r2, r3
	strh r2, [r4]
	ldrh r3, [r4, #0]
	mov r2, #2
	bic r3, r2
	strh r3, [r4]
	ldrh r3, [r4, #0]
	mov r2, #4
	orr r2, r3
	strh r2, [r4]
	ldrh r2, [r4, #0]
	orr r2, r5
	strh r2, [r4]
	ldrh r3, [r4, #0]
	mov r2, #0x10
	orr r2, r3
	strh r2, [r4]
	ldrh r3, [r4, #0]
	asr r2, r6, #2
	and r2, r3
	strh r2, [r4]
	ldrh r3, [r4, #0]
	asr r2, r6, #1
	and r2, r3
	strh r2, [r4]
	ldrh r2, [r4, #0]
	and r2, r6
	strh r2, [r4]
	ldrh r3, [r4, #0]
	ldr r2, _021666C8 // =0xFFFFF7FF
	and r2, r3
	strh r2, [r4]
	ldrh r3, [r4, #0]
	ldr r2, _021666CC // =0xFFFFEFFF
	and r2, r3
	strh r2, [r4]
	ldrh r2, [r4, #0]
	bic r2, r0
	mov r0, #0xc0
	orr r0, r2
	strh r0, [r4]
	ldrh r0, [r4, #4]
	bic r0, r1
	orr r0, r5
	strh r0, [r4, #4]
	pop {r3, r4, r5, r6, r7, pc}
_021666A0:
	mov r1, r2
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	mov r0, #0
	mov r1, r4
	mov r2, #6
	bl MIi_CpuClear16
	pop {r3, r4, r5, r6, r7, pc}
	nop
_021666B8: .word VRAMSystem__GFXControl
_021666BC: .word 0xFFFFFBFF
_021666C0: .word 0xFFFFFEFF
_021666C4: .word 0xFFFFFDFF
_021666C8: .word 0xFFFFF7FF
_021666CC: .word 0xFFFFEFFF
	thumb_func_end FriendCodeMenu__SetupBlending

	thumb_func_start FriendCodeMenu__Func_21666D0
FriendCodeMenu__Func_21666D0: // 0x021666D0
	push {r3, r4, r5, r6}
	ldr r2, _02166700 // =0x0000073C
	mov r1, #1
	mov r3, r2
	mov r6, #0
	lsl r1, r1, #0x10
	add r3, #0xc4
_021666DE:
	ldr r5, [r0, r2]
	mov r4, r5
	tst r4, r3
	bne _021666F2
	mov r4, r5
	tst r4, r1
	beq _021666F2
	mov r0, r6
	pop {r3, r4, r5, r6}
	bx lr
_021666F2:
	add r6, r6, #1
	add r0, #0x38
	cmp r6, #0xa
	blt _021666DE
	mov r0, #0xb
	pop {r3, r4, r5, r6}
	bx lr
	.align 2, 0
_02166700: .word 0x0000073C
	thumb_func_end FriendCodeMenu__Func_21666D0

	thumb_func_start FriendCodeMenu__Func_2166704
FriendCodeMenu__Func_2166704: // 0x02166704
	push {r3, r4, r5, r6}
	mov r1, #1
	lsl r1, r1, #0x10
	ldr r2, _02166734 // =0x0000096C
	mov r6, #0
	lsr r3, r1, #5
_02166710:
	ldr r5, [r0, r2]
	mov r4, r5
	tst r4, r3
	bne _02166724
	mov r4, r5
	tst r4, r1
	beq _02166724
	mov r0, r6
	pop {r3, r4, r5, r6}
	bx lr
_02166724:
	add r6, r6, #1
	add r0, #0x38
	cmp r6, #3
	blt _02166710
	mov r0, #4
	pop {r3, r4, r5, r6}
	bx lr
	nop
_02166734: .word 0x0000096C
	thumb_func_end FriendCodeMenu__Func_2166704

	thumb_func_start FriendCodeMenu__Func_2166738
FriendCodeMenu__Func_2166738: // 0x02166738
	push {r3, r4, r5, r6}
	mov r1, #1
	lsl r1, r1, #0x12
	ldr r2, _02166768 // =0x0000096C
	mov r6, #0
	lsr r3, r1, #7
_02166744:
	ldr r5, [r0, r2]
	mov r4, r5
	tst r4, r3
	bne _02166758
	mov r4, r5
	tst r4, r1
	beq _02166758
	mov r0, r6
	pop {r3, r4, r5, r6}
	bx lr
_02166758:
	add r6, r6, #1
	add r0, #0x38
	cmp r6, #3
	blt _02166744
	mov r0, #4
	pop {r3, r4, r5, r6}
	bx lr
	nop
_02166768: .word 0x0000096C
	thumb_func_end FriendCodeMenu__Func_2166738

	thumb_func_start FriendCodeMenu__Func_216676C
FriendCodeMenu__Func_216676C: // 0x0216676C
	ldr r1, _02166774 // =a1234567890
	ldrsb r0, [r1, r0]
	bx lr
	nop
_02166774: .word a1234567890
	thumb_func_end FriendCodeMenu__Func_216676C

	thumb_func_start FriendCodeMenu__Func_2166778
FriendCodeMenu__Func_2166778: // 0x02166778
	push {r3, lr}
	bl FriendCodeMenu__Func_216678C
	lsl r1, r0, #1
	ldr r0, _02166788 // =ovl03_0217DF94
	ldrh r0, [r0, r1]
	pop {r3, pc}
	nop
_02166788: .word ovl03_0217DF94
	thumb_func_end FriendCodeMenu__Func_2166778

	thumb_func_start FriendCodeMenu__Func_216678C
FriendCodeMenu__Func_216678C: // 0x0216678C
	push {r3, r4}
	mov r3, #0
	ldr r4, _021667B0 // =a1234567890
	mov r1, r3
_02166794:
	ldrsb r2, [r4, r1]
	cmp r2, r0
	bne _021667A0
	mov r0, r3
	pop {r3, r4}
	bx lr
_021667A0:
	add r3, r3, #1
	add r4, r4, #1
	cmp r3, #0xa
	blt _02166794
	mov r0, #0
	pop {r3, r4}
	bx lr
	nop
_021667B0: .word a1234567890
	thumb_func_end FriendCodeMenu__Func_216678C

	.data
	
_0217ED0C: // 0x0217ED0C
	.word aNarcDmniLz7Nar_ovl03
	.align 4
	
aNarcDmniLz7Nar_ovl03: // 0x0217ED10
	.asciz "narc/dmni_lz7.narc"
	.align 4
