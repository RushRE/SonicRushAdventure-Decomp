	.include "asm/macros.inc"
	.include "global.inc"

	.text

	thumb_func_start TimeAttackRecordsMenu__LoadAssets
TimeAttackRecordsMenu__LoadAssets: // 0x02178980
	push {r4, lr}
	mov r4, r0
	mov r1, #0
	ldr r0, _021789A4 // =0x0000FFFF
	str r1, [r4]
	strh r0, [r4, #4]
	ldr r0, _021789A8 // =aNarcDmMenuTaRa
	bl ArchiveFileUnknown__LoadFile
	str r0, [r4, #8]
	mov r1, #0
	ldr r0, _021789AC // =aBbDmasBb_0
	mov r2, r1
	bl ReadFileFromBundle
	str r0, [r4, #0xc]
	pop {r4, pc}
	nop
_021789A4: .word 0x0000FFFF
_021789A8: .word aNarcDmMenuTaRa
_021789AC: .word aBbDmasBb_0
	thumb_func_end TimeAttackRecordsMenu__LoadAssets

	thumb_func_start TimeAttackRecordsMenu__ReleaseAssets
TimeAttackRecordsMenu__ReleaseAssets: // 0x021789B0
	push {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _021789C2
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0xc]
_021789C2:
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _021789D0
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #8]
_021789D0:
	pop {r4, pc}
	.align 2, 0
	thumb_func_end TimeAttackRecordsMenu__ReleaseAssets

	thumb_func_start TimeAttackRecordsMenu__Create
TimeAttackRecordsMenu__Create: // 0x021789D4
	push {r4, r5, lr}
	sub sp, #0xc
	mov r5, r0
	ldr r0, _02178A14 // =0x0000FFFF
	mov r2, #0
	strh r0, [r5, #4]
	mov r0, #3
	lsl r0, r0, #0xc
	str r0, [sp]
	ldr r0, _02178A18 // =0x00000B5C
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02178A1C // =TimeAttackRecordsMenu__Main
	ldr r1, _02178A20 // =TimeAttackRecordsMenu__Destructor
	mov r3, r2
	bl TaskCreate_
	str r0, [r5]
	bl GetTaskWork_
	mov r4, r0
	str r5, [r4]
	bl TimeAttackRecordsMenu__Init
	mov r0, #0
	str r0, [r4, #4]
	ldr r1, _02178A24 // =TimeAttackRecordsMenu__State_21793C0
	ldr r0, _02178A28 // =0x00000B58
	str r1, [r4, r0]
	add sp, #0xc
	pop {r4, r5, pc}
	nop
_02178A14: .word 0x0000FFFF
_02178A18: .word 0x00000B5C
_02178A1C: .word TimeAttackRecordsMenu__Main
_02178A20: .word TimeAttackRecordsMenu__Destructor
_02178A24: .word TimeAttackRecordsMenu__State_21793C0
_02178A28: .word 0x00000B58
	thumb_func_end TimeAttackRecordsMenu__Create

	thumb_func_start TimeAttackRecordsMenu__Func_2178A2C
TimeAttackRecordsMenu__Func_2178A2C: // 0x02178A2C
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02178A36
	mov r0, #1
	bx lr
_02178A36:
	mov r0, #0
	bx lr
	.align 2, 0
	thumb_func_end TimeAttackRecordsMenu__Func_2178A2C

	thumb_func_start TimeAttackRecordsMenu__Func_2178A3C
TimeAttackRecordsMenu__Func_2178A3C: // 0x02178A3C
	ldrh r0, [r0, #4]
	bx lr
	thumb_func_end TimeAttackRecordsMenu__Func_2178A3C

	thumb_func_start TimeAttackRecordsMenu__Init
TimeAttackRecordsMenu__Init: // 0x02178A40
	push {r4, lr}
	mov r4, r0
	bl TimeAttackRecordsMenu__InitStageUnknown
	mov r0, r4
	mov r2, #0
	add r0, #0x66
	strh r2, [r0]
	mov r0, r4
	ldr r1, _02178A88 // =0x0000FFFF
	add r0, #0x68
	strh r1, [r0]
	mov r0, r4
	add r0, #0x6a
	strh r1, [r0]
	mov r0, r4
	add r0, #0x6c
	strh r2, [r0]
	mov r0, r4
	bl TimeAttackRecordsMenu__SetupDisplay
	mov r0, r4
	bl TimeAttackRecordsMenu__InitSprites
	mov r0, r4
	bl TimeAttackRecordsMenu__Func_2178DE4
	mov r0, r4
	bl TimeAttackRecordsMenu__InitBackgrounds
	mov r0, r4
	mov r1, #0
	bl TimeAttackRecordsMenu__Func_217985C
	pop {r4, pc}
	nop
_02178A88: .word 0x0000FFFF
	thumb_func_end TimeAttackRecordsMenu__Init

	thumb_func_start TimeAttackRecordsMenu__SetupDisplay
TimeAttackRecordsMenu__SetupDisplay: // 0x02178A8C
	push {r3, lr}
	mov r2, #1
	lsl r2, r2, #0x1a
	ldr r1, [r2, #0]
	ldr r0, _02178BAC // =0xFFFFE0FF
	mov r3, r1
	mov r1, #6
	and r3, r0
	lsl r1, r1, #0xa
	orr r3, r1
	str r3, [r2]
	ldr r3, _02178BB0 // =0x04001000
	ldr r2, [r3, #0]
	and r0, r2
	orr r0, r1
	mov r1, #0
	str r0, [r3]
	mov r0, #1
	mov r2, r1
	bl GX_SetGraphicsMode
	ldr r2, _02178BB4 // =0x0400000A
	mov r1, #0x43
	ldrh r0, [r2, #0]
	mov r3, r0
	ldr r0, _02178BB8 // =0x00004A0C
	and r3, r1
	orr r0, r3
	strh r0, [r2]
	ldrh r0, [r2, #2]
	and r1, r0
	ldr r0, _02178BBC // =0x00004808
	orr r0, r1
	strh r0, [r2, #2]
	ldr r1, _02178BC0 // =0x06004000
	mov r0, #0
	lsr r2, r2, #0xe
	bl MIi_CpuClearFast
	mov r2, #1
	ldr r1, _02178BC4 // =0x06005000
	mov r0, #0
	lsl r2, r2, #0xc
	bl MIi_CpuClearFast
	ldr r1, _02178BC8 // =0x06008000
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	ldr r1, _02178BCC // =0x0600C000
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	ldr r1, _02178BD0 // =renderCoreGFXControlA
	mov r0, #0
	mov r2, #0xc
	bl MIi_CpuClear16
	ldr r0, _02178BD4 // =0x04000008
	mov r2, #3
	ldrh r1, [r0, #0]
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
	orr r1, r3
	strh r1, [r0, #6]
	mov r0, #0
	bl GXS_SetGraphicsMode
	ldr r2, _02178BD8 // =0x0400100A
	mov r0, #0x43
	ldrh r1, [r2, #0]
	mov r3, r1
	ldr r1, _02178BB8 // =0x00004A0C
	and r3, r0
	orr r1, r3
	strh r1, [r2]
	ldrh r1, [r2, #2]
	and r1, r0
	ldr r0, _02178BBC // =0x00004808
	orr r0, r1
	strh r0, [r2, #2]
	ldr r1, _02178BDC // =0x06204000
	mov r0, #0
	lsr r2, r2, #0xe
	bl MIi_CpuClearFast
	mov r2, #1
	ldr r1, _02178BE0 // =0x06205000
	mov r0, #0
	lsl r2, r2, #0xc
	bl MIi_CpuClearFast
	ldr r1, _02178BE4 // =0x06208000
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	ldr r1, _02178BE8 // =0x0620C000
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	ldr r1, _02178BEC // =renderCoreGFXControlB
	mov r0, #0
	mov r2, #0xc
	bl MIi_CpuClear16
	ldr r0, _02178BF0 // =0x04001008
	mov r2, #3
	ldrh r1, [r0, #0]
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
	orr r1, r3
	strh r1, [r0, #6]
	pop {r3, pc}
	nop
_02178BAC: .word 0xFFFFE0FF
_02178BB0: .word 0x04001000
_02178BB4: .word 0x0400000A
_02178BB8: .word 0x00004A0C
_02178BBC: .word 0x00004808
_02178BC0: .word 0x06004000
_02178BC4: .word 0x06005000
_02178BC8: .word 0x06008000
_02178BCC: .word 0x0600C000
_02178BD0: .word renderCoreGFXControlA
_02178BD4: .word 0x04000008
_02178BD8: .word 0x0400100A
_02178BDC: .word 0x06204000
_02178BE0: .word 0x06205000
_02178BE4: .word 0x06208000
_02178BE8: .word 0x0620C000
_02178BEC: .word renderCoreGFXControlB
_02178BF0: .word 0x04001008
	thumb_func_end TimeAttackRecordsMenu__SetupDisplay

	thumb_func_start TimeAttackRecordsMenu__InitSprites
TimeAttackRecordsMenu__InitSprites: // 0x02178BF4
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x40
	str r0, [sp, #0x1c]
	ldr r0, [r0, #0]
	mov r1, #0
	ldr r0, [r0, #8]
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x34]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _02178C30
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_02178C1C: // jump table
	.hword _02178C28 - _02178C1C - 2 // case 0
	.hword _02178C28 - _02178C1C - 2 // case 1
	.hword _02178C28 - _02178C1C - 2 // case 2
	.hword _02178C28 - _02178C1C - 2 // case 3
	.hword _02178C28 - _02178C1C - 2 // case 4
	.hword _02178C28 - _02178C1C - 2 // case 5
_02178C28:
	bl RenderCore_GetLanguagePtr
	ldrb r1, [r0, #0]
	b _02178C32
_02178C30:
	mov r1, #1
_02178C32:
	ldr r0, [sp, #0x1c]
	add r1, r1, #1
	ldr r0, [r0, #0]
	lsl r1, r1, #0x10
	ldr r0, [r0, #8]
	lsr r1, r1, #0x10
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x38]
	ldr r0, [sp, #0x1c]
	ldr r4, [sp, #0x1c]
	ldr r0, [r0, #0]
	ldr r5, _02178DBC // =ovl03_0217E244
	ldr r0, [r0, #0xc]
	mov r7, #0
	str r0, [sp, #0x3c]
	add r4, #0x74
_02178C54:
	cmp r7, #0xb
	bge _02178C60
	ldr r0, _02178DC0 // =0x05000200
	mov r6, #0
	str r0, [sp, #0x20]
	b _02178C66
_02178C60:
	ldr r0, _02178DC4 // =0x05000600
	mov r6, #1
	str r0, [sp, #0x20]
_02178C66:
	ldrb r0, [r5, #0]
	lsl r1, r0, #2
	add r0, sp, #0x34
	ldr r0, [r0, r1]
	ldrb r1, [r5, #1]
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, r6
	bl VRAMSystem__AllocSpriteVram
	str r6, [sp]
	mov r1, #0
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x20]
	mov r3, #0
	str r0, [sp, #0x10]
	mov r0, #2
	str r0, [sp, #0x14]
	mov r0, r1
	str r0, [sp, #0x18]
	ldrb r1, [r5, #0]
	mov r0, r4
	lsl r2, r1, #2
	add r1, sp, #0x34
	ldr r1, [r1, r2]
	ldrb r2, [r5, #1]
	bl AnimatorSprite__Init
	mov r0, r4
	ldrb r1, [r5, #2]
	add r0, #0x50
	add r7, r7, #1
	strh r1, [r0]
	add r4, #0x64
	add r5, r5, #3
	cmp r7, #0x11
	blt _02178C54
	ldr r2, _02178DC8 // =0x00000738
	ldr r0, [sp, #0x1c]
	mov r3, #0
	mov r1, r2
	str r3, [r0, r2]
	add r1, #0x74
	add r2, #0xb0
	str r3, [r0, r1]
	add r0, r0, r2
	bl TouchField__Init
	ldr r2, _02178DCC // =0x000007F4
	ldr r0, [sp, #0x1c]
	mov r1, #0
	str r1, [r0, r2]
	add r3, sp, #0x24
	strh r1, [r3]
	mov r0, #0x54
	strh r0, [r3, #2]
	ldrsh r0, [r3, r1]
	sub r2, #0xb8
	add r0, #0x18
	strh r0, [r3, #4]
	mov r0, #2
	ldrsh r0, [r3, r0]
	add r0, #0x18
	strh r0, [r3, #6]
	ldr r0, [sp, #0x1c]
	str r1, [sp]
	add r0, r0, r2
	ldr r2, _02178DD0 // =TouchField__PointInRect
	add r3, sp, #0x24
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	ldr r2, _02178DD4 // =0x000007E8
	ldr r0, [sp, #0x1c]
	ldr r1, [sp, #0x1c]
	add r0, r0, r2
	sub r2, #0xac
	add r1, r1, r2
	ldr r2, _02178DD8 // =0x0000FFFF
	bl TouchField__AddArea
	mov r2, #0x75
	ldr r0, [sp, #0x1c]
	lsl r2, r2, #4
	ldr r1, [r0, r2]
	mov r0, #0x40
	orr r1, r0
	ldr r0, [sp, #0x1c]
	add r3, sp, #0x24
	str r1, [r0, r2]
	mov r0, #0xe8
	strh r0, [r3]
	mov r0, #0x54
	mov r1, #0
	strh r0, [r3, #2]
	ldrsh r0, [r3, r1]
	add r2, #0x24
	add r0, #0x18
	strh r0, [r3, #4]
	mov r0, #2
	ldrsh r0, [r3, r0]
	add r0, #0x18
	strh r0, [r3, #6]
	ldr r0, [sp, #0x1c]
	str r1, [sp]
	add r0, r0, r2
	ldr r2, _02178DD0 // =TouchField__PointInRect
	add r3, sp, #0x24
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	ldr r2, _02178DD4 // =0x000007E8
	ldr r0, [sp, #0x1c]
	ldr r1, [sp, #0x1c]
	add r0, r0, r2
	sub r2, #0x74
	add r1, r1, r2
	ldr r2, _02178DD8 // =0x0000FFFF
	bl TouchField__AddArea
	ldr r2, _02178DDC // =0x00000788
	ldr r0, [sp, #0x1c]
	mov r1, #0x40
	ldr r0, [r0, r2]
	mov r3, r0
	ldr r0, [sp, #0x1c]
	orr r3, r1
	str r3, [r0, r2]
	add r3, sp, #0x24
	strh r1, [r3]
	mov r0, #0xa8
	mov r1, #0
	strh r0, [r3, #2]
	ldrsh r0, [r3, r1]
	add r2, #0x28
	add r0, #0xba
	strh r0, [r3, #4]
	mov r0, #2
	ldrsh r0, [r3, r0]
	add r0, #0x14
	strh r0, [r3, #6]
	ldr r0, [sp, #0x1c]
	str r1, [sp]
	add r0, r0, r2
	ldr r2, _02178DD0 // =TouchField__PointInRect
	add r3, sp, #0x24
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	ldr r2, _02178DD4 // =0x000007E8
	ldr r0, [sp, #0x1c]
	ldr r1, [sp, #0x1c]
	add r0, r0, r2
	sub r2, #0x38
	add r1, r1, r2
	ldr r2, _02178DD8 // =0x0000FFFF
	bl TouchField__AddArea
	ldr r1, _02178DE0 // =0x000007C4
	ldr r0, [sp, #0x1c]
	ldr r2, [r0, r1]
	mov r0, #0x40
	orr r2, r0
	ldr r0, [sp, #0x1c]
	str r2, [r0, r1]
	add sp, #0x40
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02178DBC: .word ovl03_0217E244
_02178DC0: .word 0x05000200
_02178DC4: .word 0x05000600
_02178DC8: .word 0x00000738
_02178DCC: .word 0x000007F4
_02178DD0: .word TouchField__PointInRect
_02178DD4: .word 0x000007E8
_02178DD8: .word 0x0000FFFF
_02178DDC: .word 0x00000788
_02178DE0: .word 0x000007C4
	thumb_func_end TimeAttackRecordsMenu__InitSprites

	thumb_func_start TimeAttackRecordsMenu__Func_2178DE4
TimeAttackRecordsMenu__Func_2178DE4: // 0x02178DE4
	push {r4, r5, r6, r7, lr}
	sub sp, #0x54
	mov r4, r0
	mov r0, #2
	lsl r0, r0, #0xa
	bl _AllocHeadHEAP_USER
	ldr r1, _02178F8C // =0x00000B44
	str r0, [r4, r1]
	mov r0, #2
	lsl r0, r0, #0xa
	bl _AllocHeadHEAP_USER
	ldr r1, _02178F90 // =0x00000B48
	str r0, [r4, r1]
	mov r0, #2
	lsl r0, r0, #0xa
	bl _AllocHeadHEAP_USER
	ldr r1, _02178F94 // =0x00000B4C
	str r0, [r4, r1]
	mov r0, #2
	lsl r0, r0, #0xa
	bl _AllocHeadHEAP_USER
	mov r1, #0xb5
	lsl r1, r1, #4
	str r0, [r4, r1]
	mov r0, #2
	lsl r0, r0, #0xa
	bl _AllocHeadHEAP_USER
	ldr r1, _02178F98 // =0x00000B54
	mov r2, #6
	str r0, [r4, r1]
	sub r1, #0x10
	ldr r1, [r4, r1]
	mov r0, #0
	lsl r2, r2, #8
	bl MIi_CpuClear32
	ldr r0, [r4, #0]
	mov r1, #8
	ldr r0, [r0, #8]
	bl FileUnknown__GetAOUFile
	mov r5, r0
	mov r0, #2
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, sp, #0xc
	mov r1, r5
	mov r2, #4
	mov r3, #0
	bl InitBackground
	add r0, sp, #0xc
	bl DrawBackground
	mov r0, r5
	bl GetBackgroundMappings
	ldr r1, _02178F90 // =0x00000B48
	ldr r1, [r4, r1]
	bl RenderCore_CPUCopyCompressed
	ldr r1, _02178F90 // =0x00000B48
	mov r2, #6
	ldr r0, [r4, r1]
	add r1, r1, #4
	ldr r1, [r4, r1]
	lsl r2, r2, #8
	bl MIi_CpuCopyFast
	ldr r0, _02178F94 // =0x00000B4C
	mov r7, #1
	lsl r7, r7, #0xe
	ldr r2, [r4, r0]
	ldr r5, _02178F9C // =0xFFFF0FFF
	mov r1, #0
	lsr r6, r7, #1
_02178E8C:
	ldrh r0, [r2, #0]
	lsl r3, r0, #4
	lsr r3, r3, #0x10
	cmp r3, #1
	bne _02178E9E
	and r0, r5
	orr r0, r6
	strh r0, [r2]
	b _02178EAA
_02178E9E:
	cmp r3, #3
	bne _02178EAA
	ldr r3, _02178F9C // =0xFFFF0FFF
	and r0, r3
	orr r0, r7
	strh r0, [r2]
_02178EAA:
	mov r0, #3
	add r1, r1, #1
	lsl r0, r0, #8
	add r2, r2, #2
	cmp r1, r0
	blt _02178E8C
	ldr r0, [r4, #0]
	mov r1, #7
	ldr r0, [r0, #8]
	bl FileUnknown__GetAOUFile
	mov r5, r0
	mov r0, #2
	str r0, [sp]
	mov r0, #0x20
	str r0, [sp, #4]
	mov r0, #0x18
	str r0, [sp, #8]
	add r0, sp, #0xc
	mov r1, r5
	mov r2, #4
	mov r3, #1
	bl InitBackground
	add r0, sp, #0xc
	bl DrawBackground
	mov r0, r5
	bl GetBackgroundMappings
	mov r1, #0xb5
	lsl r1, r1, #4
	ldr r1, [r4, r1]
	bl RenderCore_CPUCopyCompressed
	mov r1, #0xb5
	lsl r1, r1, #4
	ldr r0, [r4, r1]
	add r1, r1, #4
	mov r2, #6
	ldr r1, [r4, r1]
	lsl r2, r2, #8
	bl MIi_CpuCopyFast
	ldr r0, _02178F98 // =0x00000B54
	mov r1, #2
	ldr r5, [r4, r0]
	mov r7, #3
	ldr r0, _02178F9C // =0xFFFF0FFF
	mov r6, #0
	lsl r1, r1, #0xc
	lsl r7, r7, #8
_02178F12:
	ldrh r3, [r5, #0]
	asr r2, r3, #0xc
	cmp r2, #1
	bne _02178F22
	mov r2, r3
	and r2, r0
	orr r2, r1
	strh r2, [r5]
_02178F22:
	add r6, r6, #1
	add r5, r5, #2
	cmp r6, r7
	blt _02178F12
	ldr r0, _02178F8C // =0x00000B44
	mov r1, #6
	ldr r0, [r4, r0]
	lsl r1, r1, #8
	bl DC_StoreRange
	ldr r0, _02178F90 // =0x00000B48
	mov r1, #6
	ldr r0, [r4, r0]
	lsl r1, r1, #8
	bl DC_StoreRange
	ldr r0, _02178F94 // =0x00000B4C
	mov r1, #6
	ldr r0, [r4, r0]
	lsl r1, r1, #8
	bl DC_StoreRange
	mov r0, #0xb5
	lsl r0, r0, #4
	mov r1, #6
	ldr r0, [r4, r0]
	lsl r1, r1, #8
	bl DC_StoreRange
	ldr r0, _02178F98 // =0x00000B54
	mov r1, #6
	ldr r0, [r4, r0]
	lsl r1, r1, #8
	bl DC_StoreRange
	ldr r0, [r4, #0]
	mov r1, #0xd
	ldr r0, [r0, #8]
	bl FileUnknown__GetAOUFile
	mov r2, #0
	mov r1, r0
	mov r0, #5
	str r2, [sp]
	lsl r0, r0, #0x18
	str r0, [sp, #4]
	ldr r0, _02178FA0 // =0x00000718
	mov r3, r2
	add r0, r4, r0
	bl InitPaletteAnimator
	add sp, #0x54
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02178F8C: .word 0x00000B44
_02178F90: .word 0x00000B48
_02178F94: .word 0x00000B4C
_02178F98: .word 0x00000B54
_02178F9C: .word 0xFFFF0FFF
_02178FA0: .word 0x00000718
	thumb_func_end TimeAttackRecordsMenu__Func_2178DE4

	thumb_func_start TimeAttackRecordsMenu__InitBackgrounds
TimeAttackRecordsMenu__InitBackgrounds: // 0x02178FA4
	push {r4, r5, r6, r7, lr}
	sub sp, #0x44
	str r0, [sp, #0x1c]
	bl TimeAttackMenu__Func_216C5E4
	bl FontWindow__GetFont
	mov r2, #2
	ldr r1, [sp, #0x1c]
	lsl r2, r2, #0xa
	str r0, [r1, r2]
	mov r0, #0
	mov r6, r1
	str r0, [sp, #0x3c]
	add r1, r2, #4
	mov r0, r6
	mov r4, #0x20
	add r5, r0, r1
	mov r7, #0xf
_02178FCA:
	mov r0, #0x15
	lsl r0, r0, #6
	bl _AllocHeadHEAP_USER
	ldr r1, _021791DC // =0x00000B04
	mov r2, #1
	str r0, [r6, r1]
	lsl r0, r7, #0x10
	lsr r0, r0, #0x10
	str r0, [sp]
	mov r0, #0xe
	str r0, [sp, #4]
	str r0, [sp, #8]
	mov r0, #3
	str r0, [sp, #0xc]
	mov r0, r1
	ldr r0, [r6, r0]
	mov r1, #0
	str r0, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	mov r0, r5
	mov r3, r1
	str r4, [sp, #0x18]
	bl Unknown2056570__Init
	mov r0, r5
	mov r1, #0xb
	bl Unknown2056570__Func_2056688
	mov r0, r5
	bl Unknown2056570__Func_205683C
	mov r0, r5
	bl Unknown2056570__Func_2056B8C
	mov r0, #0x15
	lsl r0, r0, #6
	add r4, r4, r0
	ldr r0, [sp, #0x3c]
	add r6, r6, #4
	add r0, r0, #1
	add r5, #0x30
	add r7, #0x20
	str r0, [sp, #0x3c]
	cmp r0, #2
	blt _02178FCA
	ldr r6, [sp, #0x1c]
	mov r0, #0
	str r0, [sp, #0x20]
	ldr r1, _021791E0 // =0x00000864
	mov r0, r6
	add r5, r0, r1
	mov r7, #0x15
_02179036:
	mov r0, #0x2a
	lsl r0, r0, #4
	bl _AllocHeadHEAP_USER
	ldr r1, _021791E4 // =0x00000B0C
	mov r2, #1
	str r0, [r6, r1]
	lsl r0, r7, #0x10
	lsr r0, r0, #0x10
	str r0, [sp]
	mov r0, #0x11
	str r0, [sp, #4]
	mov r0, #7
	str r0, [sp, #8]
	mov r0, #3
	str r0, [sp, #0xc]
	mov r0, r1
	ldr r0, [r6, r0]
	mov r1, #0
	str r0, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	mov r0, r5
	mov r3, r1
	str r4, [sp, #0x18]
	bl Unknown2056570__Init
	mov r0, r5
	mov r1, #0xa
	bl Unknown2056570__Func_2056688
	mov r0, r5
	bl Unknown2056570__Func_205683C
	mov r0, r5
	bl Unknown2056570__Func_2056B8C
	mov r0, #0x2a
	lsl r0, r0, #4
	add r4, r4, r0
	ldr r0, [sp, #0x20]
	add r6, r6, #4
	add r0, r0, #1
	add r5, #0x30
	add r7, #0x20
	str r0, [sp, #0x20]
	cmp r0, #2
	blt _02179036
	ldr r6, [sp, #0x1c]
	mov r0, #0
	str r0, [sp, #0x24]
	ldr r1, _021791E8 // =0x000008C4
	mov r0, r6
	add r5, r0, r1
	mov r7, #0x12
_021790A4:
	mov r0, #0xb
	lsl r0, r0, #6
	bl _AllocHeadHEAP_USER
	ldr r1, _021791EC // =0x00000B14
	mov r2, #1
	str r0, [r6, r1]
	lsl r0, r7, #0x10
	lsr r0, r0, #0x10
	str r0, [sp]
	mov r0, #0x15
	str r0, [sp, #4]
	mov r0, #0xb
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, r1
	ldr r0, [r6, r0]
	mov r1, #0
	str r0, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	mov r0, r5
	mov r3, r1
	str r4, [sp, #0x18]
	bl Unknown2056570__Init
	mov r0, r5
	mov r1, #0xa
	bl Unknown2056570__Func_2056688
	mov r0, r5
	bl Unknown2056570__Func_205683C
	mov r0, r5
	bl Unknown2056570__Func_2056B8C
	mov r0, #0xb
	lsl r0, r0, #6
	add r4, r4, r0
	ldr r0, [sp, #0x24]
	add r6, r6, #4
	add r0, r0, #1
	add r5, #0x30
	add r7, #0x20
	str r0, [sp, #0x24]
	cmp r0, #2
	blt _021790A4
	mov r0, #0
	str r0, [sp, #0x28]
	ldr r0, [sp, #0x1c]
	ldr r1, _021791F0 // =0x00000924
	str r0, [sp, #0x34]
	add r0, r0, r1
	str r0, [sp, #0x30]
	mov r0, #0xb
	mov r7, #0x20
	str r0, [sp, #0x2c]
_02179118:
	mov r0, #0
	str r0, [sp, #0x38]
	ldr r0, [sp, #0x2c]
	ldr r4, [sp, #0x34]
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	ldr r5, [sp, #0x30]
	mov r6, #6
	str r0, [sp, #0x40]
_0217912A:
	mov r0, #0xa
	lsl r0, r0, #6
	bl _AllocHeadHEAP_USER
	ldr r1, _021791F4 // =0x00000B1C
	mov r3, #0
	str r0, [r4, r1]
	ldr r0, [sp, #0x40]
	str r0, [sp]
	lsl r0, r6, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #4]
	mov r0, #0xa
	str r0, [sp, #8]
	mov r0, #2
	str r0, [sp, #0xc]
	mov r0, r1
	ldr r0, [r4, r0]
	mov r1, #1
	str r0, [sp, #0x10]
	mov r0, #0
	str r0, [sp, #0x14]
	mov r0, r5
	mov r2, r1
	str r7, [sp, #0x18]
	bl Unknown2056570__Init
	mov r0, r5
	mov r1, #0xb
	bl Unknown2056570__Func_2056688
	mov r0, r5
	bl Unknown2056570__Func_205683C
	mov r0, r5
	bl Unknown2056570__Func_2056B8C
	mov r0, #0xa
	lsl r0, r0, #6
	add r7, r7, r0
	ldr r0, [sp, #0x38]
	add r4, r4, #4
	add r0, r0, #1
	add r5, #0x30
	add r6, r6, #2
	str r0, [sp, #0x38]
	cmp r0, #5
	blt _0217912A
	ldr r0, [sp, #0x34]
	add r0, #0x14
	str r0, [sp, #0x34]
	ldr r0, [sp, #0x30]
	add r0, #0xf0
	str r0, [sp, #0x30]
	ldr r0, [sp, #0x2c]
	add r0, #0x20
	str r0, [sp, #0x2c]
	ldr r0, [sp, #0x28]
	add r0, r0, #1
	str r0, [sp, #0x28]
	cmp r0, #2
	blt _02179118
	ldr r0, [sp, #0x1c]
	mov r1, #0xb
	ldr r0, [r0, #0]
	ldr r0, [r0, #8]
	bl FileUnknown__GetAOUFile
	bl GetBackgroundPalette
	ldr r2, _021791F8 // =0x05000140
	mov r1, #0
	bl QueueCompressedPalette
	ldr r0, _021791FC // =FontAnimator__Palettes+0x00000008
	ldr r3, _02179200 // =0x05000162
	mov r1, #4
	mov r2, #0
	bl QueueUncompressedPalette
	ldr r0, _021791FC // =FontAnimator__Palettes+0x00000008
	ldr r3, _02179204 // =0x05000562
	mov r1, #4
	mov r2, #0
	bl QueueUncompressedPalette
	add sp, #0x44
	pop {r4, r5, r6, r7, pc}
	nop
_021791DC: .word 0x00000B04
_021791E0: .word 0x00000864
_021791E4: .word 0x00000B0C
_021791E8: .word 0x000008C4
_021791EC: .word 0x00000B14
_021791F0: .word 0x00000924
_021791F4: .word 0x00000B1C
_021791F8: .word 0x05000140
_021791FC: .word FontAnimator__Palettes+0x00000008
_02179200: .word 0x05000162
_02179204: .word 0x05000562
	thumb_func_end TimeAttackRecordsMenu__InitBackgrounds

	thumb_func_start TimeAttackRecordsMenu__Func_2179208
TimeAttackRecordsMenu__Func_2179208: // 0x02179208
	push {r4, lr}
	mov r4, r0
	bl TimeAttackRecordsMenu__Func_21792A4
	mov r0, r4
	bl TimeAttackRecordsMenu__Func_2179258
	mov r0, r4
	bl TimeAttackRecordsMenu__Func_217922C
	mov r0, r4
	bl TimeAttackRecordsMenu__Func_2179228
	bl TimeAttackMenu__Func_216C688
	pop {r4, pc}
	thumb_func_end TimeAttackRecordsMenu__Func_2179208

	thumb_func_start TimeAttackRecordsMenu__Func_2179228
TimeAttackRecordsMenu__Func_2179228: // 0x02179228
	bx lr
	.align 2, 0
	thumb_func_end TimeAttackRecordsMenu__Func_2179228

	thumb_func_start TimeAttackRecordsMenu__Func_217922C
TimeAttackRecordsMenu__Func_217922C: // 0x0217922C
	push {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r6
	mov r4, #0
	add r5, #0x74
_02179236:
	mov r0, r5
	bl AnimatorSprite__Release
	add r4, r4, #1
	add r5, #0x64
	cmp r4, #0x11
	blt _02179236
	add r6, #0x74
	ldr r2, _02179254 // =0x000006A4
	mov r0, #0
	mov r1, r6
	bl MIi_CpuClear16
	pop {r4, r5, r6, pc}
	nop
_02179254: .word 0x000006A4
	thumb_func_end TimeAttackRecordsMenu__Func_217922C

	thumb_func_start TimeAttackRecordsMenu__Func_2179258
TimeAttackRecordsMenu__Func_2179258: // 0x02179258
	push {r4, lr}
	mov r4, r0
	ldr r0, _02179290 // =0x00000718
	add r0, r4, r0
	bl ReleasePaletteAnimator
	ldr r0, _02179294 // =0x00000B54
	ldr r0, [r4, r0]
	bl _FreeHEAP_USER
	mov r0, #0xb5
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	bl _FreeHEAP_USER
	ldr r0, _02179298 // =0x00000B4C
	ldr r0, [r4, r0]
	bl _FreeHEAP_USER
	ldr r0, _0217929C // =0x00000B48
	ldr r0, [r4, r0]
	bl _FreeHEAP_USER
	ldr r0, _021792A0 // =0x00000B44
	ldr r0, [r4, r0]
	bl _FreeHEAP_USER
	pop {r4, pc}
	.align 2, 0
_02179290: .word 0x00000718
_02179294: .word 0x00000B54
_02179298: .word 0x00000B4C
_0217929C: .word 0x00000B48
_021792A0: .word 0x00000B44
	thumb_func_end TimeAttackRecordsMenu__Func_2179258

	thumb_func_start TimeAttackRecordsMenu__Func_21792A4
TimeAttackRecordsMenu__Func_21792A4: // 0x021792A4
	push {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	mov r0, #0
	str r0, [sp]
	ldr r0, _02179348 // =0x00000A14
	mov r5, r7
	add r6, r7, r0
	sub r0, #0xf0
	add r4, r7, r0
_021792B6:
	mov r0, r6
	bl Unknown2056570__Func_2056670
	mov r0, r4
	bl Unknown2056570__Func_2056670
	mov r0, #0xb3
	lsl r0, r0, #4
	ldr r0, [r5, r0]
	bl _FreeHEAP_USER
	ldr r0, _0217934C // =0x00000B1C
	ldr r0, [r5, r0]
	bl _FreeHEAP_USER
	ldr r0, [sp]
	add r6, #0x30
	add r0, r0, #1
	add r4, #0x30
	add r5, r5, #4
	str r0, [sp]
	cmp r0, #5
	blt _021792B6
	ldr r0, _02179350 // =0x000008F4
	add r0, r7, r0
	bl Unknown2056570__Func_2056670
	ldr r0, _02179354 // =0x000008C4
	add r0, r7, r0
	bl Unknown2056570__Func_2056670
	ldr r0, _02179358 // =0x00000B18
	ldr r0, [r7, r0]
	bl _FreeHEAP_USER
	ldr r0, _0217935C // =0x00000B14
	ldr r0, [r7, r0]
	bl _FreeHEAP_USER
	ldr r0, _02179360 // =0x00000894
	add r0, r7, r0
	bl Unknown2056570__Func_2056670
	ldr r0, _02179364 // =0x00000864
	add r0, r7, r0
	bl Unknown2056570__Func_2056670
	mov r0, #0xb1
	lsl r0, r0, #4
	ldr r0, [r7, r0]
	bl _FreeHEAP_USER
	ldr r0, _02179368 // =0x00000B0C
	ldr r0, [r7, r0]
	bl _FreeHEAP_USER
	ldr r0, _0217936C // =0x00000834
	add r0, r7, r0
	bl Unknown2056570__Func_2056670
	ldr r0, _02179370 // =0x00000804
	add r0, r7, r0
	bl Unknown2056570__Func_2056670
	ldr r0, _02179374 // =0x00000B08
	ldr r0, [r7, r0]
	bl _FreeHEAP_USER
	ldr r0, _02179378 // =0x00000B04
	ldr r0, [r7, r0]
	bl _FreeHEAP_USER
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02179348: .word 0x00000A14
_0217934C: .word 0x00000B1C
_02179350: .word 0x000008F4
_02179354: .word 0x000008C4
_02179358: .word 0x00000B18
_0217935C: .word 0x00000B14
_02179360: .word 0x00000894
_02179364: .word 0x00000864
_02179368: .word 0x00000B0C
_0217936C: .word 0x00000834
_02179370: .word 0x00000804
_02179374: .word 0x00000B08
_02179378: .word 0x00000B04
	thumb_func_end TimeAttackRecordsMenu__Func_21792A4

	thumb_func_start TimeAttackRecordsMenu__Main
TimeAttackRecordsMenu__Main: // 0x0217937C
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, _021793A4 // =0x00000B58
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _0217939E
	ldr r0, _021793A8 // =0x000007E8
	add r0, r4, r0
	bl TouchField__Process
	ldr r1, _021793A4 // =0x00000B58
	mov r0, r4
	ldr r1, [r4, r1]
	blx r1
	pop {r4, pc}
_0217939E:
	bl DestroyCurrentTask
	pop {r4, pc}
	.align 2, 0
_021793A4: .word 0x00000B58
_021793A8: .word 0x000007E8
	thumb_func_end TimeAttackRecordsMenu__Main

	thumb_func_start TimeAttackRecordsMenu__Destructor
TimeAttackRecordsMenu__Destructor: // 0x021793AC
	push {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl TimeAttackRecordsMenu__Func_2179208
	ldr r0, [r4, #0]
	mov r1, #0
	str r1, [r0]
	pop {r4, pc}
	thumb_func_end TimeAttackRecordsMenu__Destructor

	thumb_func_start TimeAttackRecordsMenu__State_21793C0
TimeAttackRecordsMenu__State_21793C0: // 0x021793C0
	push {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	ldr r1, [r4, #4]
	cmp r1, #0
	bne _021793D0
	mov r0, #1
	str r0, [r4, #4]
	pop {r3, r4, r5, r6, r7, pc}
_021793D0:
	mov r2, #1
	lsl r2, r2, #0x1a
	mov r7, #0x1f
	ldr r1, [r2, #0]
	lsl r7, r7, #8
	and r1, r7
	lsr r6, r1, #8
	mov r5, #6
	orr r6, r5
	ldr r1, [r2, #0]
	ldr r3, _02179418 // =0xFFFFE0FF
	lsl r6, r6, #8
	and r1, r3
	orr r1, r6
	str r1, [r2]
	ldr r2, _0217941C // =0x04001000
	ldr r1, [r2, #0]
	and r1, r7
	lsr r6, r1, #8
	ldr r1, [r2, #0]
	and r1, r3
	mov r3, r6
	orr r3, r5
	lsl r3, r3, #8
	orr r1, r3
	str r1, [r2]
	mov r1, #1
	bl TimeAttackRecordsMenu__Func_2179988
	mov r0, #0
	str r0, [r4, #4]
	ldr r1, _02179420 // =TimeAttackRecordsMenu__State_21797D8
	ldr r0, _02179424 // =0x00000B58
	str r1, [r4, r0]
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02179418: .word 0xFFFFE0FF
_0217941C: .word 0x04001000
_02179420: .word TimeAttackRecordsMenu__State_21797D8
_02179424: .word 0x00000B58
	thumb_func_end TimeAttackRecordsMenu__State_21793C0

	thumb_func_start TimeAttackRecordsMenu__State_2179428
TimeAttackRecordsMenu__State_2179428: // 0x02179428
	push {r4, r5, r6, r7, lr}
	sub sp, #0x3c
	mov r1, #0
	mov r5, r0
	str r1, [sp, #0x2c]
	str r1, [sp, #0x24]
	str r1, [sp, #0x20]
	mov r1, r5
	add r1, #0x66
	ldrh r1, [r1, #0]
	lsl r1, r1, #1
	add r1, r5, r1
	add r1, #0x68
	ldrh r1, [r1, #0]
	str r1, [sp, #0x1c]
	lsl r1, r1, #1
	add r1, r5, r1
	ldrh r7, [r1, #0xa]
	ldrh r1, [r5, #8]
	cmp r1, #1
	bls _0217948E
	ldr r1, _02179734 // =padInput
	ldrh r2, [r1, #0]
	mov r1, #0x20
	tst r1, r2
	bne _02179464
	bl TimeAttackRecordsMenu__Func_217A604
	cmp r0, #0
	beq _0217948E
_02179464:
	ldr r0, [sp, #0x1c]
	cmp r0, #0
	beq _02179474
	sub r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x1c]
	b _0217947E
_02179474:
	ldrh r0, [r5, #8]
	sub r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x1c]
_0217947E:
	mov r0, #1
	str r0, [sp, #0x2c]
	mov r0, #0
	str r0, [sp, #0x28]
	mov r0, #0xb
	bl PlaySysSfx
	b _021795F8
_0217948E:
	ldrh r0, [r5, #8]
	cmp r0, #1
	bls _021794CE
	ldr r0, _02179734 // =padInput
	ldrh r1, [r0, #0]
	mov r0, #0x10
	tst r0, r1
	bne _021794A8
	mov r0, r5
	bl TimeAttackRecordsMenu__Func_217A628
	cmp r0, #0
	beq _021794CE
_021794A8:
	ldrh r0, [r5, #8]
	sub r1, r0, #1
	ldr r0, [sp, #0x1c]
	cmp r0, r1
	bge _021794BC
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x1c]
	b _021794C0
_021794BC:
	mov r0, #0
	str r0, [sp, #0x1c]
_021794C0:
	mov r0, #1
	str r0, [sp, #0x2c]
	str r0, [sp, #0x28]
	mov r0, #0xb
	bl PlaySysSfx
	b _021795F8
_021794CE:
	ldr r0, _02179734 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #2
	tst r0, r1
	bne _021794E0
	bl TimeAttackRecordsMenu__Func_217A800
	cmp r0, #0
	beq _021794EC
_021794E0:
	mov r0, #1
	str r0, [sp, #0x24]
	mov r0, #2
	bl PlaySysSfx
	b _021795F8
_021794EC:
	mov r0, r5
	add r0, #0x6c
	ldrh r0, [r0, #0]
	cmp r0, #0
	bne _02179560
	bl TimeAttackRecordsMenu__CheckProgressUnknown
	cmp r0, #0
	beq _02179560
	ldr r0, _02179734 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #1
	lsl r0, r0, #8
	tst r0, r1
	bne _02179512
	bl TimeAttackRecordsMenu__Func_217A7A0
	cmp r0, #0
	beq _02179560
_02179512:
	mov r0, r5
	mov r1, #1
	add r0, #0x6c
	strh r1, [r0]
	mov r1, r5
	mov r2, r5
	add r1, #0x66
	add r2, #0x6c
	ldrh r1, [r1, #0]
	ldrh r2, [r2, #0]
	mov r0, r5
	bl TimeAttackRecordsMenu__Func_217A538
	mov r6, #0
	add r4, sp, #0x30
_02179530:
	mov r2, r5
	add r2, #0x6c
	ldrh r2, [r2, #0]
	lsl r1, r6, #0x10
	mov r0, r7
	lsr r1, r1, #0x10
	bl TimeAttackRecordsMenu__GetRecordUnknown
	strh r0, [r4]
	add r6, r6, #1
	add r4, r4, #2
	cmp r6, #5
	blt _02179530
	mov r2, r5
	add r2, #0x66
	ldrh r2, [r2, #0]
	mov r0, r5
	add r1, sp, #0x30
	bl TimeAttackRecordsMenu__Func_217A25C
	mov r0, #3
	bl PlaySysSfx
	b _021795F8
_02179560:
	mov r0, r5
	add r0, #0x6c
	ldrh r0, [r0, #0]
	cmp r0, #1
	bne _021795D4
	bl TimeAttackRecordsMenu__CheckProgressUnknown
	cmp r0, #0
	beq _021795D4
	ldr r0, _02179734 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #2
	lsl r0, r0, #8
	tst r0, r1
	bne _02179586
	bl TimeAttackRecordsMenu__Func_217A760
	cmp r0, #0
	beq _021795D4
_02179586:
	mov r0, r5
	mov r1, #0
	add r0, #0x6c
	strh r1, [r0]
	mov r1, r5
	mov r2, r5
	add r1, #0x66
	add r2, #0x6c
	ldrh r1, [r1, #0]
	ldrh r2, [r2, #0]
	mov r0, r5
	bl TimeAttackRecordsMenu__Func_217A538
	mov r4, #0
	add r6, sp, #0x30
_021795A4:
	mov r2, r5
	add r2, #0x6c
	ldrh r2, [r2, #0]
	lsl r1, r4, #0x10
	mov r0, r7
	lsr r1, r1, #0x10
	bl TimeAttackRecordsMenu__GetRecordUnknown
	strh r0, [r6]
	add r4, r4, #1
	add r6, r6, #2
	cmp r4, #5
	blt _021795A4
	mov r2, r5
	add r2, #0x66
	ldrh r2, [r2, #0]
	mov r0, r5
	add r1, sp, #0x30
	bl TimeAttackRecordsMenu__Func_217A25C
	mov r0, #3
	bl PlaySysSfx
	b _021795F8
_021795D4:
	ldr r0, _02179738 // =0x000007AC
	ldr r0, [r5, r0]
	cmp r0, #0
	beq _021795F8
	ldr r0, _02179734 // =padInput
	ldrh r1, [r0, #4]
	mov r0, #8
	tst r0, r1
	bne _021795F0
	mov r0, r5
	bl TimeAttackRecordsMenu__Func_217A6E8
	cmp r0, #0
	beq _021795F8
_021795F0:
	mov r0, #1
	str r0, [sp, #0x20]
	bl PlaySysSfx
_021795F8:
	mov r1, #1
	mov r0, r5
	lsl r1, r1, #0xc
	bl TimeAttackRecordsMenu__Func_217999C
	mov r0, r5
	bl TimeAttackRecordsMenu__Func_217A70C
	mov r0, r5
	bl TimeAttackRecordsMenu__Func_217A64C
	ldr r0, [sp, #0x2c]
	cmp r0, #0
	beq _02179648
	ldr r1, [sp, #0x1c]
	mov r0, r5
	bl TimeAttackRecordsMenu__Func_217985C
	ldr r1, [sp, #0x28]
	mov r0, r5
	bl TimeAttackRecordsMenu__Func_2179988
	mov r0, #0
	bl TimeAttackRecordsMenu__Func_217A7E0
	mov r0, r5
	mov r1, #0
	bl TimeAttackRecordsMenu__Func_217A584
	mov r0, r5
	mov r1, #0
	bl TimeAttackRecordsMenu__Func_217A6A0
	mov r0, #0
	str r0, [r5, #4]
	ldr r1, _0217973C // =TimeAttackRecordsMenu__State_21797D8
	ldr r0, _02179740 // =0x00000B58
	add sp, #0x3c
	str r1, [r5, r0]
	pop {r4, r5, r6, r7, pc}
_02179648:
	ldr r0, [sp, #0x24]
	cmp r0, #0
	beq _02179682
	ldr r1, _02179744 // =0x0000FFFF
	mov r0, r5
	bl TimeAttackRecordsMenu__Func_217985C
	mov r0, r5
	mov r1, #1
	bl TimeAttackRecordsMenu__Func_2179988
	mov r0, #0
	bl TimeAttackRecordsMenu__Func_217A7E0
	mov r0, r5
	mov r1, #0
	bl TimeAttackRecordsMenu__Func_217A584
	mov r0, r5
	mov r1, #0
	bl TimeAttackRecordsMenu__Func_217A6A0
	mov r0, #0
	str r0, [r5, #4]
	ldr r1, _0217973C // =TimeAttackRecordsMenu__State_21797D8
	ldr r0, _02179740 // =0x00000B58
	add sp, #0x3c
	str r1, [r5, r0]
	pop {r4, r5, r6, r7, pc}
_02179682:
	ldr r0, [sp, #0x20]
	cmp r0, #0
	beq _021796DA
	mov r0, #0
	bl TimeAttackRecordsMenu__Func_217A7E0
	mov r0, r5
	mov r1, #0
	bl TimeAttackRecordsMenu__Func_217A584
	mov r0, r5
	mov r1, #0
	bl TimeAttackRecordsMenu__Func_217A6A0
	bl TimeAttackMenu__Func_216C670
	mov r6, r0
	bl TimeAttackMenu__Func_216C5E4
	mov r4, r0
	bl TimeAttackMenu__Func_216C5FC
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r4, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, #9
	str r0, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r1, #2
	mov r0, r6
	mov r2, #1
	mov r3, #8
	str r1, [sp, #0x18]
	bl SaveSpriteButton__Func_20651D4
	mov r0, #0
	str r0, [r5, #4]
	ldr r1, _02179748 // =TimeAttackRecordsMenu__State_217974C
	ldr r0, _02179740 // =0x00000B58
	add sp, #0x3c
	str r1, [r5, r0]
	pop {r4, r5, r6, r7, pc}
_021796DA:
	mov r0, #1
	bl TimeAttackRecordsMenu__Func_217A7E0
	ldrh r0, [r5, #8]
	cmp r0, #1
	bls _021796F0
	mov r0, r5
	mov r1, #1
	bl TimeAttackRecordsMenu__Func_217A584
	b _021796F8
_021796F0:
	mov r0, r5
	mov r1, #0
	bl TimeAttackRecordsMenu__Func_217A584
_021796F8:
	mov r0, r5
	add r0, #0x66
	ldrh r0, [r0, #0]
	lsl r0, r0, #1
	add r0, r5, r0
	add r0, #0x68
	ldrh r1, [r0, #0]
	ldrh r0, [r5, #8]
	cmp r1, r0
	bhs _02179726
	lsl r0, r1, #1
	add r0, r5, r0
	ldrh r0, [r0, #0xa]
	bl TimeAttackRecordsMenu__Func_217A91C
	cmp r0, #0
	beq _02179726
	mov r0, r5
	mov r1, #1
	bl TimeAttackRecordsMenu__Func_217A6A0
	add sp, #0x3c
	pop {r4, r5, r6, r7, pc}
_02179726:
	mov r0, r5
	mov r1, #0
	bl TimeAttackRecordsMenu__Func_217A6A0
	add sp, #0x3c
	pop {r4, r5, r6, r7, pc}
	nop
_02179734: .word padInput
_02179738: .word 0x000007AC
_0217973C: .word TimeAttackRecordsMenu__State_21797D8
_02179740: .word 0x00000B58
_02179744: .word 0x0000FFFF
_02179748: .word TimeAttackRecordsMenu__State_217974C
	thumb_func_end TimeAttackRecordsMenu__State_2179428

	thumb_func_start TimeAttackRecordsMenu__State_217974C
TimeAttackRecordsMenu__State_217974C: // 0x0217974C
	push {r4, lr}
	mov r4, r0
	bl TimeAttackMenu__Func_216C670
	bl SaveSpriteButton__RunState2
	mov r1, #1
	mov r0, r4
	lsl r1, r1, #0xc
	bl TimeAttackRecordsMenu__Func_217999C
	bl TimeAttackMenu__Func_216C670
	bl SaveSpriteButton__CheckInvalidState2
	cmp r0, #0
	beq _021797C4
	bl TimeAttackMenu__Func_216C670
	bl SaveSpriteButton__Func_2065498
	cmp r0, #0
	bne _021797BA
	mov r0, r4
	add r0, #0x66
	ldrh r0, [r0, #0]
	lsl r0, r0, #1
	add r0, r4, r0
	add r0, #0x68
	ldrh r0, [r0, #0]
	lsl r0, r0, #1
	add r0, r4, r0
	ldrh r1, [r0, #0xa]
	ldr r0, [r4, #0]
	strh r1, [r0, #4]
	ldr r0, [r4, #0]
	ldrh r0, [r0, #4]
	bl TimeAttackRecordsMenu__Func_217A96C
	ldr r1, [r4, #0]
	strh r0, [r1, #4]
	ldr r1, _021797C8 // =0x0000FFFF
	mov r0, r4
	bl TimeAttackRecordsMenu__Func_217985C
	mov r0, r4
	mov r1, #1
	bl TimeAttackRecordsMenu__Func_2179988
	mov r0, #0
	str r0, [r4, #4]
	ldr r1, _021797CC // =TimeAttackRecordsMenu__State_21797D8
	ldr r0, _021797D0 // =0x00000B58
	str r1, [r4, r0]
	pop {r4, pc}
_021797BA:
	mov r0, #0
	str r0, [r4, #4]
	ldr r1, _021797D4 // =TimeAttackRecordsMenu__State_2179428
	ldr r0, _021797D0 // =0x00000B58
	str r1, [r4, r0]
_021797C4:
	pop {r4, pc}
	nop
_021797C8: .word 0x0000FFFF
_021797CC: .word TimeAttackRecordsMenu__State_21797D8
_021797D0: .word 0x00000B58
_021797D4: .word TimeAttackRecordsMenu__State_2179428
	thumb_func_end TimeAttackRecordsMenu__State_217974C

	thumb_func_start TimeAttackRecordsMenu__State_21797D8
TimeAttackRecordsMenu__State_21797D8: // 0x021797D8
	push {r3, r4, lr}
	sub sp, #4
	mov r4, r0
	ldr r3, [r4, #4]
	cmp r3, #4
	bhs _021797F6
	mov r0, #2
	lsl r0, r0, #0xa
	str r0, [sp]
	ldr r1, _0217984C // =0x00000333
	mov r0, #0
	mov r2, #4
	bl Unknown2051334__Func_2051534
	b _0217980A
_021797F6:
	mov r0, #6
	lsl r0, r0, #0xa
	str r0, [sp]
	mov r1, #1
	ldr r0, _0217984C // =0x00000333
	lsl r1, r1, #0xc
	mov r2, #0x14
	sub r3, r3, #4
	bl Unknown2051334__Func_2051534
_0217980A:
	lsl r0, r0, #0x10
	asr r1, r0, #0x10
	mov r0, r4
	bl TimeAttackRecordsMenu__Func_217999C
	ldr r0, [r4, #4]
	add r0, r0, #1
	str r0, [r4, #4]
	cmp r0, #0x18
	blo _02179846
	mov r0, r4
	add r0, #0x66
	ldrh r0, [r0, #0]
	lsl r0, r0, #1
	add r0, r4, r0
	add r0, #0x68
	ldrh r1, [r0, #0]
	ldr r0, _02179850 // =0x0000FFFF
	cmp r1, r0
	bne _0217983C
	ldr r0, _02179854 // =0x00000B58
	mov r1, #0
	add sp, #4
	str r1, [r4, r0]
	pop {r3, r4, pc}
_0217983C:
	mov r0, #0
	str r0, [r4, #4]
	ldr r1, _02179858 // =TimeAttackRecordsMenu__State_2179428
	ldr r0, _02179854 // =0x00000B58
	str r1, [r4, r0]
_02179846:
	add sp, #4
	pop {r3, r4, pc}
	nop
_0217984C: .word 0x00000333
_02179850: .word 0x0000FFFF
_02179854: .word 0x00000B58
_02179858: .word TimeAttackRecordsMenu__State_2179428
	thumb_func_end TimeAttackRecordsMenu__State_21797D8

	thumb_func_start TimeAttackRecordsMenu__Func_217985C
TimeAttackRecordsMenu__Func_217985C: // 0x0217985C
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x10
	mov r7, r0
	add r0, #0x66
	ldrh r2, [r0, #0]
	mov r0, #1
	sub r0, r0, r2
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp]
	lsl r0, r0, #1
	add r0, r7, r0
	add r0, #0x68
	strh r1, [r0]
	ldrh r0, [r7, #8]
	cmp r1, r0
	bhs _02179886
	lsl r0, r1, #1
	add r0, r7, r0
	ldrh r6, [r0, #0xa]
	b _02179888
_02179886:
	ldr r6, _02179984 // =0x0000FFFF
_02179888:
	ldr r3, _02179984 // =0x0000FFFF
	cmp r6, r3
	beq _021798B0
	mov r0, r6
	bl TimeAttackRecordsMenu__GetLastUsedCharacter
	mov r3, r0
	ldr r1, [sp]
	mov r0, r7
	mov r2, r6
	bl TimeAttackRecordsMenu__Func_217A3C4
	mov r2, r7
	add r2, #0x6c
	ldrh r2, [r2, #0]
	ldr r1, [sp]
	mov r0, r7
	bl TimeAttackRecordsMenu__Func_217A4B0
	b _021798C4
_021798B0:
	ldr r1, [sp]
	mov r0, r7
	mov r2, r6
	bl TimeAttackRecordsMenu__Func_217A3C4
	ldr r1, [sp]
	ldr r2, _02179984 // =0x0000FFFF
	mov r0, r7
	bl TimeAttackRecordsMenu__Func_217A4B0
_021798C4:
	ldr r0, _02179984 // =0x0000FFFF
	cmp r6, r0
	beq _021798E2
	mov r0, r6
	add r1, sp, #4
	bl TimeAttackRecordsMenu__GetSaveNameLength
	add r2, sp, #4
	mov r1, r0
	ldrh r2, [r2, #0]
	ldr r3, [sp]
	mov r0, r7
	bl TimeAttackRecordsMenu__Func_2179D30
	b _021798EA
_021798E2:
	ldr r1, [sp]
	mov r0, r7
	bl TimeAttackRecordsMenu__Func_2179DD4
_021798EA:
	ldr r0, _02179984 // =0x0000FFFF
	cmp r6, r0
	beq _02179902
	mov r0, r6
	bl TimeAttackRecordsMenu__GetTimeAttackRecord
	mov r1, r0
	ldr r2, [sp]
	mov r0, r7
	bl TimeAttackRecordsMenu__Func_2179DF4
	b _0217990A
_02179902:
	ldr r1, [sp]
	mov r0, r7
	bl TimeAttackRecordsMenu__Func_2179EF4
_0217990A:
	ldr r0, _02179984 // =0x0000FFFF
	cmp r6, r0
	beq _0217993A
	mov r0, r6
	bl TimeAttackRecordsMenu__GetTimeAttackRecord
	ldr r1, _02179984 // =0x0000FFFF
	cmp r0, r1
	bne _02179924
	mov r3, #0
	mvn r3, r3
	mov r2, r3
	b _0217992E
_02179924:
	mov r0, r6
	bl TimeAttackRecordsMenu__GetTimeFromRecord
	mov r3, r0
	mov r2, r1
_0217992E:
	mov r1, r3
	ldr r3, [sp]
	mov r0, r7
	bl TimeAttackRecordsMenu__Func_2179F14
	b _02179942
_0217993A:
	ldr r1, [sp]
	mov r0, r7
	bl TimeAttackRecordsMenu__Func_217A23C
_02179942:
	ldr r0, _02179984 // =0x0000FFFF
	cmp r6, r0
	beq _02179978
	add r5, sp, #4
	mov r4, #0
	add r5, #2
_0217994E:
	mov r2, r7
	add r2, #0x6c
	ldrh r2, [r2, #0]
	lsl r1, r4, #0x10
	mov r0, r6
	lsr r1, r1, #0x10
	bl TimeAttackRecordsMenu__GetRecordUnknown
	strh r0, [r5]
	add r4, r4, #1
	add r5, r5, #2
	cmp r4, #5
	blt _0217994E
	add r1, sp, #4
	ldr r2, [sp]
	mov r0, r7
	add r1, #2
	bl TimeAttackRecordsMenu__Func_217A25C
	add sp, #0x10
	pop {r3, r4, r5, r6, r7, pc}
_02179978:
	ldr r1, [sp]
	mov r0, r7
	bl TimeAttackRecordsMenu__Func_217A39C
	add sp, #0x10
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02179984: .word 0x0000FFFF
	thumb_func_end TimeAttackRecordsMenu__Func_217985C

	thumb_func_start TimeAttackRecordsMenu__Func_2179988
TimeAttackRecordsMenu__Func_2179988: // 0x02179988
	mov r2, r0
	add r2, #0x66
	ldrh r3, [r2, #0]
	mov r2, #1
	sub r3, r2, r3
	mov r2, r0
	add r2, #0x66
	strh r3, [r2]
	str r1, [r0, #0x70]
	bx lr
	thumb_func_end TimeAttackRecordsMenu__Func_2179988

	thumb_func_start TimeAttackRecordsMenu__Func_217999C
TimeAttackRecordsMenu__Func_217999C: // 0x0217999C
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x20
	mov r5, r0
	lsl r0, r1, #8
	mov r1, r5
	add r1, #0x66
	ldrh r1, [r1, #0]
	asr r0, r0, #0xc
	cmp r1, #0
	bne _021799B6
	mov r1, #1
	lsl r1, r1, #8
	add r0, r0, r1
_021799B6:
	ldr r1, [r5, #0x70]
	cmp r1, #0
	bne _021799BE
	neg r0, r0
_021799BE:
	ldr r1, _02179C20 // =0x000001FF
	ldr r4, _02179C24 // =renderCoreGFXControlB
	and r0, r1
	strh r0, [r4, #4]
	ldrh r6, [r4, #4]
	ldr r3, _02179C28 // =renderCoreGFXControlA
	strh r6, [r3, #4]
	strh r6, [r4, #8]
	strh r6, [r3, #8]
	mov r6, #0
	strh r6, [r4, #6]
	ldrh r6, [r4, #6]
	strh r6, [r3, #6]
	strh r6, [r3, #0xa]
	add r3, r1, #1
	sub r3, r3, r0
	mov r0, r1
	sub r0, #0xff
	strh r6, [r4, #0xa]
	cmp r3, r0
	bge _021799F2
	sub r1, #0xff
	sub r0, r3, r1
	str r3, [sp, #0x18]
	str r0, [sp, #0x1c]
	b _02179A00
_021799F2:
	add r0, r1, #1
	sub r0, r0, r3
	neg r0, r0
	sub r1, #0xff
	str r0, [sp, #0x18]
	add r0, r0, r1
	str r0, [sp, #0x1c]
_02179A00:
	mov r0, r5
	add r0, #0x68
	ldrh r0, [r0, #0]
	cmp r0, #0x2e
	blo _02179A10
	mov r0, #1
	lsl r0, r0, #8
	str r0, [sp, #0x18]
_02179A10:
	mov r0, r5
	add r0, #0x6a
	ldrh r0, [r0, #0]
	cmp r0, #0x2e
	blo _02179A20
	mov r0, #1
	lsl r0, r0, #8
	str r0, [sp, #0x1c]
_02179A20:
	mov r0, r5
	add r0, #0x68
	ldrh r1, [r0, #0]
	cmp r1, #0x2e
	bhs _02179A38
	mov r0, r5
	add r0, #0x6a
	ldrh r0, [r0, #0]
	cmp r0, #0x2e
	bhs _02179A38
	mov r2, #0
	b _02179A4C
_02179A38:
	cmp r1, #0x2e
	bhs _02179A40
	ldr r2, [sp, #0x18]
	b _02179A4C
_02179A40:
	mov r0, r5
	add r0, #0x6a
	ldrh r0, [r0, #0]
	cmp r0, #0x2e
	bhs _02179A4C
	ldr r2, [sp, #0x1c]
_02179A4C:
	cmp r2, #0
	bge _02179A52
	neg r2, r2
_02179A52:
	cmp r2, #0x40
	bge _02179A6A
	mov r1, #8
	mov r0, #0x81
	sub r2, r1, r2
	lsl r0, r0, #2
	lsl r2, r2, #0x10
	add r0, r5, r0
	asr r2, r2, #0x10
	mov r3, #0
	bl TimeAttackRecordsMenu__Func_2179C3C
_02179A6A:
	mov r0, #0x18
	str r0, [sp]
	mov r0, #0x30
	str r0, [sp, #4]
	ldr r0, [sp, #0x18]
	mov r2, #0x4f
	str r0, [sp, #8]
	ldr r0, [sp, #0x1c]
	lsl r2, r2, #2
	add r1, r5, r2
	add r2, #0x64
	str r0, [sp, #0xc]
	ldr r3, _02179C2C // =ovl03_0217E2A8
	mov r0, r5
	add r2, r5, r2
	bl TimeAttackRecordsMenu__Func_2179CC0
	mov r0, #4
	str r0, [sp]
	mov r0, #0x1c
	str r0, [sp, #4]
	ldr r0, [sp, #0x18]
	mov r1, r5
	str r0, [sp, #8]
	ldr r0, [sp, #0x1c]
	mov r2, r5
	str r0, [sp, #0xc]
	ldr r3, _02179C30 // =ovl03_0217E2D8
	mov r0, r5
	add r1, #0x74
	add r2, #0xd8
	bl TimeAttackRecordsMenu__Func_2179CC0
	mov r0, #0xba
	str r0, [sp]
	mov r0, #0x30
	str r0, [sp, #4]
	ldr r0, [sp, #0x18]
	mov r2, #0x9a
	str r0, [sp, #8]
	ldr r0, [sp, #0x1c]
	lsl r2, r2, #2
	add r1, r5, r2
	add r2, #0x64
	str r0, [sp, #0xc]
	ldr r3, _02179C34 // =ovl03_0217E308
	mov r0, r5
	add r2, r5, r2
	bl TimeAttackRecordsMenu__Func_2179CC0
	ldr r0, [sp, #0x18]
	mov r1, #0
	str r0, [sp]
	ldr r0, [sp, #0x1c]
	mov r2, #0x68
	str r0, [sp, #4]
	mov r0, #0xe5
	lsl r0, r0, #2
	add r0, r5, r0
	mov r3, #0x60
	bl TimeAttackRecordsMenu__Func_2179C5C
	mov r0, r5
	str r0, [sp, #0x10]
	add r0, #0x74
	mov r7, #0
	mov r6, r5
	add r4, sp, #0x18
	str r0, [sp, #0x10]
_02179AF4:
	mov r0, r6
	add r0, #0x68
	ldrh r1, [r0, #0]
	ldrh r0, [r5, #8]
	cmp r1, r0
	bhs _02179B22
	lsl r0, r1, #1
	add r0, r5, r0
	ldrh r0, [r0, #0xa]
	bl TimeAttackRecordsMenu__GetLastUsedCharacter
	cmp r0, #2
	bhs _02179B22
	add r0, #9
	mov r1, #0x64
	mul r1, r0
	ldr r0, [sp, #0x10]
	ldr r3, [r4, #0]
	add r0, r0, r1
	mov r1, #0x80
	mov r2, #0x8a
	bl TimeAttackRecordsMenu__Func_2179C3C
_02179B22:
	add r7, r7, #1
	add r6, r6, #2
	add r4, r4, #4
	cmp r7, #2
	blt _02179AF4
	ldr r0, [sp, #0x18]
	mov r1, #0
	str r0, [sp]
	ldr r0, [sp, #0x1c]
	mov r2, #0x18
	str r0, [sp, #4]
	mov r0, #0x33
	lsl r0, r0, #4
	add r0, r5, r0
	mov r3, #0xaf
	bl TimeAttackRecordsMenu__Func_2179C5C
	mov r0, r5
	str r0, [sp, #0x14]
	add r0, #0x74
	mov r7, #0
	mov r6, r5
	add r4, sp, #0x18
	str r0, [sp, #0x14]
_02179B52:
	mov r0, r6
	add r0, #0x68
	ldrh r0, [r0, #0]
	cmp r0, #0x2e
	bhs _02179B78
	mov r0, r5
	add r0, #0x6c
	ldrh r1, [r0, #0]
	mov r0, #0x64
	ldr r3, [r4, #0]
	add r1, #0xb
	mov r2, r1
	mul r2, r0
	ldr r0, [sp, #0x14]
	mov r1, #0x18
	add r0, r0, r2
	mov r2, #8
	bl TimeAttackRecordsMenu__Func_2179C3C
_02179B78:
	add r7, r7, #1
	add r6, r6, #2
	add r4, r4, #4
	cmp r7, #2
	blt _02179B52
	bl TimeAttackRecordsMenu__CheckProgressUnknown
	cmp r0, #0
	beq _02179C1A
	ldr r0, _02179C38 // =0x00000588
	add r6, r5, r0
	add r0, #0x64
	add r4, r5, r0
	add r5, #0x6c
	ldrh r0, [r5, #0]
	cmp r0, #0
	ldrh r0, [r6, #0xc]
	bne _02179BC8
	cmp r0, #0x13
	beq _02179BA8
	mov r0, r6
	mov r1, #0x13
	bl AnimatorSprite__SetAnimation
_02179BA8:
	ldrh r0, [r4, #0xc]
	cmp r0, #0x14
	beq _02179BB6
	mov r0, r4
	mov r1, #0x14
	bl AnimatorSprite__SetAnimation
_02179BB6:
	mov r0, r6
	mov r1, #2
	add r0, #0x56
	strb r1, [r0]
	mov r0, r4
	mov r1, #3
	add r0, #0x56
	strb r1, [r0]
	b _02179BF2
_02179BC8:
	cmp r0, #0x12
	beq _02179BD4
	mov r0, r6
	mov r1, #0x12
	bl AnimatorSprite__SetAnimation
_02179BD4:
	ldrh r0, [r4, #0xc]
	cmp r0, #0x15
	beq _02179BE2
	mov r0, r4
	mov r1, #0x15
	bl AnimatorSprite__SetAnimation
_02179BE2:
	mov r0, r6
	mov r1, #3
	add r0, #0x56
	strb r1, [r0]
	mov r0, r4
	mov r1, #2
	add r0, #0x56
	strb r1, [r0]
_02179BF2:
	ldr r0, [sp, #0x18]
	mov r1, #0
	str r0, [sp]
	ldr r0, [sp, #0x1c]
	mov r2, #0x50
	str r0, [sp, #4]
	mov r0, r6
	mov r3, #0x88
	bl TimeAttackRecordsMenu__Func_2179C5C
	ldr r0, [sp, #0x18]
	mov r1, #0
	str r0, [sp]
	ldr r0, [sp, #0x1c]
	mov r2, #0xa0
	str r0, [sp, #4]
	mov r0, r4
	mov r3, #0x88
	bl TimeAttackRecordsMenu__Func_2179C5C
_02179C1A:
	add sp, #0x20
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02179C20: .word 0x000001FF
_02179C24: .word renderCoreGFXControlB
_02179C28: .word renderCoreGFXControlA
_02179C2C: .word ovl03_0217E2A8
_02179C30: .word ovl03_0217E2D8
_02179C34: .word ovl03_0217E308
_02179C38: .word 0x00000588
	thumb_func_end TimeAttackRecordsMenu__Func_217999C

	thumb_func_start TimeAttackRecordsMenu__Func_2179C3C
TimeAttackRecordsMenu__Func_2179C3C: // 0x02179C3C
	push {r3, r4, r5, r6, r7, lr}
	mov r4, r1
	mov r1, #0
	mov r6, r2
	mov r7, r3
	mov r2, r1
	mov r5, r0
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, r7
	strh r0, [r5, #8]
	mov r0, r5
	strh r6, [r5, #0xa]
	bl AnimatorSprite__DrawFrame
	pop {r3, r4, r5, r6, r7, pc}
	thumb_func_end TimeAttackRecordsMenu__Func_2179C3C

	thumb_func_start TimeAttackRecordsMenu__Func_2179C5C
TimeAttackRecordsMenu__Func_2179C5C: // 0x02179C5C
	push {r3, r4, r5, r6, r7, lr}
	mov r4, r1
	mov r1, #0
	mov r6, r2
	mov r2, r1
	mov r5, r0
	mov r7, r3
	bl AnimatorSprite__ProcessAnimation
	cmp r4, #0
	beq _02179C7E
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	b _02179C80
_02179C7E:
	mov r4, r5
_02179C80:
	mov r0, #1
	ldr r1, [sp, #0x18]
	lsl r0, r0, #8
	cmp r1, r0
	bge _02179C9E
	mov r0, #0xff
	mvn r0, r0
	cmp r1, r0
	ble _02179C9E
	add r0, r6, r1
	strh r0, [r5, #8]
	mov r0, r5
	strh r7, [r5, #0xa]
	bl AnimatorSprite__DrawFrame
_02179C9E:
	mov r0, #1
	ldr r1, [sp, #0x1c]
	lsl r0, r0, #8
	cmp r1, r0
	bge _02179CBC
	mov r0, #0xff
	mvn r0, r0
	cmp r1, r0
	ble _02179CBC
	add r0, r6, r1
	strh r0, [r4, #8]
	mov r0, r4
	strh r7, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
_02179CBC:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
	thumb_func_end TimeAttackRecordsMenu__Func_2179C5C

	thumb_func_start TimeAttackRecordsMenu__Func_2179CC0
TimeAttackRecordsMenu__Func_2179CC0: // 0x02179CC0
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	add r0, #0x68
	mov r4, r1
	ldrh r1, [r0, #0]
	ldrh r0, [r5, #8]
	mov r6, r2
	mov r7, r3
	cmp r1, r0
	bhs _02179CFA
	lsl r0, r1, #1
	add r0, r5, r0
	ldrh r0, [r0, #0xa]
	ldrb r1, [r7, r0]
	ldrh r0, [r4, #0xc]
	cmp r0, r1
	beq _02179CE8
	mov r0, r4
	bl AnimatorSprite__SetAnimation
_02179CE8:
	add r2, sp, #8
	mov r1, #0x10
	mov r3, #0x14
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r3]
	ldr r3, [sp, #0x20]
	mov r0, r4
	bl TimeAttackRecordsMenu__Func_2179C3C
_02179CFA:
	mov r0, r5
	add r0, #0x6a
	ldrh r1, [r0, #0]
	ldrh r0, [r5, #8]
	cmp r1, r0
	bhs _02179D2C
	lsl r0, r1, #1
	add r0, r5, r0
	ldrh r0, [r0, #0xa]
	ldrb r1, [r7, r0]
	ldrh r0, [r6, #0xc]
	cmp r0, r1
	beq _02179D1A
	mov r0, r6
	bl AnimatorSprite__SetAnimation
_02179D1A:
	add r3, sp, #8
	mov r1, #0x10
	mov r2, #0x14
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	ldr r3, [sp, #0x24]
	mov r0, r6
	bl TimeAttackRecordsMenu__Func_2179C3C
_02179D2C:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
	thumb_func_end TimeAttackRecordsMenu__Func_2179CC0

	thumb_func_start TimeAttackRecordsMenu__Func_2179D30
TimeAttackRecordsMenu__Func_2179D30: // 0x02179D30
	push {r4, r5, r6, r7, lr}
	sub sp, #0x3c
	mov r6, r2
	mov r2, #2
	lsl r2, r2, #0xa
	mov r5, r1
	ldr r1, [r0, r2]
	str r1, [sp, #0x20]
	add r1, r2, #4
	add r0, r0, r1
	str r0, [sp, #0x24]
	mov r0, #0x30
	mul r0, r3
	ldr r1, [sp, #0x24]
	str r0, [sp, #0x28]
	add r0, r1, r0
	bl Unknown2056570__Func_205683C
	ldr r1, [sp, #0x24]
	ldr r0, [sp, #0x28]
	add r0, r1, r0
	bl Unknown2056570__Func_2056834
	str r0, [sp, #0x1c]
	cmp r5, #0
	bne _02179D78
	mov r0, #0x2d
	bl GetFontCharacterFromUTF
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	add r1, sp, #0x2c
	mov r2, #0x10
	bl MIi_CpuClear16
	b _02179D92
_02179D78:
	mov r7, #0
	cmp r6, #0
	ble _02179D92
	add r4, sp, #0x2c
_02179D80:
	ldrh r0, [r5, #0]
	bl GetFontCharacterFromUTF
	strh r0, [r4]
	add r7, r7, #1
	add r5, r5, #2
	add r4, r4, #2
	cmp r7, r6
	blt _02179D80
_02179D92:
	mov r0, #4
	mov r5, #0
	cmp r6, #0
	ble _02179DC6
	add r4, sp, #0x2c
	mov r7, r5
_02179D9E:
	mov r1, #0xe
	str r1, [sp]
	mov r1, #3
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, #4
	str r0, [sp, #0xc]
	str r7, [sp, #0x10]
	str r7, [sp, #0x14]
	str r7, [sp, #0x18]
	ldrh r1, [r4, #0]
	ldr r0, [sp, #0x20]
	ldr r3, [sp, #0x1c]
	mov r2, r7
	bl FontFile__Func_2052B7C
	add r5, r5, #1
	add r4, r4, #2
	cmp r5, r6
	blt _02179D9E
_02179DC6:
	ldr r1, [sp, #0x24]
	ldr r0, [sp, #0x28]
	add r0, r1, r0
	bl Unknown2056570__Func_2056B8C
	add sp, #0x3c
	pop {r4, r5, r6, r7, pc}
	thumb_func_end TimeAttackRecordsMenu__Func_2179D30

	thumb_func_start TimeAttackRecordsMenu__Func_2179DD4
TimeAttackRecordsMenu__Func_2179DD4: // 0x02179DD4
	push {r3, r4, r5, lr}
	ldr r2, _02179DF0 // =0x00000804
	mov r5, r1
	add r4, r0, r2
	mov r0, #0x30
	mul r5, r0
	add r0, r4, r5
	bl Unknown2056570__Func_205683C
	add r0, r4, r5
	bl Unknown2056570__Func_2056B8C
	pop {r3, r4, r5, pc}
	nop
_02179DF0: .word 0x00000804
	thumb_func_end TimeAttackRecordsMenu__Func_2179DD4

	thumb_func_start TimeAttackRecordsMenu__Func_2179DF4
TimeAttackRecordsMenu__Func_2179DF4: // 0x02179DF4
	push {r4, r5, r6, r7, lr}
	sub sp, #0x3c
	mov r5, r0
	ldr r0, [r5, #0]
	mov r4, r1
	ldr r0, [r0, #8]
	mov r1, #0xb
	mov r6, r2
	bl FileUnknown__GetAOUFile
	bl GetBackgroundPixels
	str r0, [sp, #0x1c]
	ldr r0, _02179EEC // =0x00000864
	add r0, r5, r0
	str r0, [sp, #0x20]
	mov r0, #0x30
	mul r0, r6
	ldr r1, [sp, #0x20]
	str r0, [sp, #0x24]
	add r0, r1, r0
	bl Unknown2056570__Func_205683C
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x24]
	add r0, r1, r0
	bl Unknown2056570__Func_2056834
	mov r7, r0
	ldr r0, _02179EF0 // =0x0000FFFF
	cmp r4, r0
	bne _02179E4C
	mov r2, #0xc
	add r0, sp, #0x28
	strh r2, [r0, #6]
	mov r1, #0xa
	strh r1, [r0, #8]
	strh r2, [r0, #0xa]
	strh r2, [r0, #0xc]
	mov r1, #0xb
	strh r1, [r0, #0xe]
	strh r2, [r0, #0x10]
	strh r2, [r0, #0x12]
	b _02179E9E
_02179E4C:
	add r2, sp, #0x28
	mov r0, r4
	add r1, sp, #0x2c
	add r2, #2
	add r3, sp, #0x28
	bl AkUtilFrameToTime
	add r0, sp, #0x28
	ldrh r1, [r0, #4]
	strh r1, [r0, #6]
	mov r1, #0xa
	strh r1, [r0, #8]
	ldrh r0, [r0, #2]
	bl _s32_div_f
	add r2, sp, #0x28
	strh r0, [r2, #0xa]
	ldrh r0, [r2, #0xa]
	ldrh r4, [r2, #2]
	mov r1, #0xa
	mov r3, r0
	mul r3, r1
	sub r0, r4, r3
	strh r0, [r2, #2]
	ldrh r0, [r2, #2]
	strh r0, [r2, #0xc]
	mov r0, #0xb
	strh r0, [r2, #0xe]
	ldrh r0, [r2, #0]
	bl _s32_div_f
	add r1, sp, #0x28
	strh r0, [r1, #0x10]
	ldrh r2, [r1, #0x10]
	mov r0, #0xa
	ldrh r3, [r1, #0]
	mul r0, r2
	sub r0, r3, r0
	strh r0, [r1]
	ldrh r0, [r1, #0]
	strh r0, [r1, #0x12]
_02179E9E:
	mov r4, #0
	add r5, sp, #0x2c
	mov r6, r4
	add r5, #2
_02179EA6:
	mov r0, #8
	str r0, [sp]
	mov r0, #0xe
	str r0, [sp, #4]
	str r7, [sp, #8]
	mov r0, #7
	str r0, [sp, #0xc]
	str r4, [sp, #0x10]
	mov r0, #5
	str r0, [sp, #0x14]
	mov r0, #0
	str r0, [sp, #0x18]
	ldrh r2, [r5, #0]
	ldr r0, [sp, #0x1c]
	mov r1, #0xd
	lsl r2, r2, #0x13
	add r0, r0, #4
	lsr r2, r2, #0x10
	mov r3, #0
	bl BackgroundUnknown__CopyPixels
	add r4, #8
	lsl r0, r4, #0x10
	add r6, r6, #1
	lsr r4, r0, #0x10
	add r5, r5, #2
	cmp r6, #7
	blt _02179EA6
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x24]
	add r0, r1, r0
	bl Unknown2056570__Func_2056B8C
	add sp, #0x3c
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_02179EEC: .word 0x00000864
_02179EF0: .word 0x0000FFFF
	thumb_func_end TimeAttackRecordsMenu__Func_2179DF4

	thumb_func_start TimeAttackRecordsMenu__Func_2179EF4
TimeAttackRecordsMenu__Func_2179EF4: // 0x02179EF4
	push {r3, r4, r5, lr}
	ldr r2, _02179F10 // =0x00000864
	mov r5, r1
	add r4, r0, r2
	mov r0, #0x30
	mul r5, r0
	add r0, r4, r5
	bl Unknown2056570__Func_205683C
	add r0, r4, r5
	bl Unknown2056570__Func_2056B8C
	pop {r3, r4, r5, pc}
	nop
_02179F10: .word 0x00000864
	thumb_func_end TimeAttackRecordsMenu__Func_2179EF4

	thumb_func_start TimeAttackRecordsMenu__Func_2179F14
TimeAttackRecordsMenu__Func_2179F14: // 0x02179F14
	push {r4, r5, r6, r7, lr}
	sub sp, #0x4c
	mov r4, r0
	ldr r0, [r4, #0]
	str r1, [sp]
	ldr r0, [r0, #8]
	mov r1, #0xc
	str r2, [sp, #4]
	mov r5, r3
	bl FileUnknown__GetAOUFile
	bl GetBackgroundPixels
	mov r7, r0
	ldr r0, _0217A20C // =0x000008C4
	add r0, r4, r0
	str r0, [sp, #0xc]
	mov r0, #0x30
	mul r0, r5
	ldr r1, [sp, #0xc]
	str r0, [sp, #0x10]
	add r0, r1, r0
	bl Unknown2056570__Func_205683C
	ldr r1, [sp, #0xc]
	ldr r0, [sp, #0x10]
	add r0, r1, r0
	bl Unknown2056570__Func_2056834
	str r0, [sp, #8]
	ldr r0, [sp]
	mov r1, #0
	mov r2, #0
	sub r0, r0, r1
	ldr r0, [sp, #4]
	sbc r0, r2
	blt _0217A042
	ldr r2, [sp]
	ldr r3, [sp, #4]
	add r0, sp, #0x2c
	add r1, sp, #0x20
	bl RTC_ConvertSecondToDateTime
	mov r1, #0xfa
	ldr r0, [sp, #0x2c]
	lsl r1, r1, #2
	bl _u32_div_f
	add r1, sp, #0x14
	strb r0, [r1, #8]
	mov r0, #0xfa
	ldrb r1, [r1, #8]
	lsl r0, r0, #2
	ldr r2, [sp, #0x2c]
	mul r0, r1
	sub r0, r2, r0
	mov r1, #0x64
	str r0, [sp, #0x2c]
	bl _u32_div_f
	add r1, sp, #0x14
	strb r0, [r1, #9]
	ldrb r1, [r1, #9]
	mov r0, #0x64
	ldr r2, [sp, #0x2c]
	mul r0, r1
	sub r0, r2, r0
	mov r1, #0xa
	str r0, [sp, #0x2c]
	bl _u32_div_f
	add r2, sp, #0x14
	strb r0, [r2, #0xa]
	ldrb r0, [r2, #0xa]
	ldr r4, [sp, #0x2c]
	mov r1, #0xa
	mov r3, r0
	mul r3, r1
	sub r3, r4, r3
	str r3, [sp, #0x2c]
	strb r3, [r2, #0xb]
	ldrb r0, [r2, #0xb]
	sub r0, r3, r0
	str r0, [sp, #0x2c]
	ldr r0, [sp, #0x30]
	bl _u32_div_f
	add r2, sp, #0x14
	strb r0, [r2, #6]
	ldrb r0, [r2, #6]
	ldr r4, [sp, #0x30]
	mov r1, #0xa
	mov r3, r0
	mul r3, r1
	sub r3, r4, r3
	str r3, [sp, #0x30]
	strb r3, [r2, #7]
	ldrb r0, [r2, #7]
	sub r0, r3, r0
	str r0, [sp, #0x30]
	ldr r0, [sp, #0x34]
	bl _u32_div_f
	add r2, sp, #0x14
	strb r0, [r2, #4]
	ldrb r0, [r2, #4]
	ldr r4, [sp, #0x34]
	mov r1, #0xa
	mov r3, r0
	mul r3, r1
	sub r3, r4, r3
	str r3, [sp, #0x34]
	strb r3, [r2, #5]
	ldrb r0, [r2, #5]
	sub r0, r3, r0
	str r0, [sp, #0x34]
	ldr r0, [sp, #0x20]
	bl _u32_div_f
	add r2, sp, #0x14
	strb r0, [r2, #2]
	ldrb r0, [r2, #2]
	ldr r4, [sp, #0x20]
	mov r1, #0xa
	mov r3, r0
	mul r3, r1
	sub r3, r4, r3
	str r3, [sp, #0x20]
	strb r3, [r2, #3]
	ldrb r0, [r2, #3]
	sub r0, r3, r0
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x24]
	bl _u32_div_f
	add r1, sp, #0x14
	strb r0, [r1]
	ldrb r2, [r1, #0]
	mov r0, #0xa
	ldr r3, [sp, #0x24]
	mul r0, r2
	sub r2, r3, r0
	str r2, [sp, #0x24]
	strb r2, [r1, #1]
	ldrb r0, [r1, #1]
	sub r0, r2, r0
	str r0, [sp, #0x24]
	ldrb r0, [r1, #8]
	add r0, r0, #2
	strb r0, [r1, #8]
	b _0217A078
_0217A042:
	add r0, sp, #0x1c
	mov r1, #0xa
	mov r2, #4
	bl MI_CpuFill8
	add r0, sp, #0x18
	add r0, #2
	mov r1, #0xa
	mov r2, #2
	bl MI_CpuFill8
	add r0, sp, #0x18
	mov r1, #0xa
	mov r2, #2
	bl MI_CpuFill8
	add r0, sp, #0x14
	add r0, #2
	mov r1, #0xa
	mov r2, #2
	bl MI_CpuFill8
	add r0, sp, #0x14
	mov r1, #0xa
	mov r2, #2
	bl MI_CpuFill8
_0217A078:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _0217A0A2
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0217A08E: // jump table
	.hword _0217A09A - _0217A08E - 2 // case 0
	.hword _0217A09A - _0217A08E - 2 // case 1
	.hword _0217A09A - _0217A08E - 2 // case 2
	.hword _0217A09A - _0217A08E - 2 // case 3
	.hword _0217A09A - _0217A08E - 2 // case 4
	.hword _0217A09A - _0217A08E - 2 // case 5
_0217A09A:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _0217A0A4
_0217A0A2:
	mov r0, #1
_0217A0A4:
	cmp r0, #0
	bne _0217A0FE
	add r0, sp, #0x1c
	add r1, sp, #0x3c
	mov r2, #4
	bl MI_CpuCopy8
	mov r1, #0xb
	add r0, sp, #0x3c
	strb r1, [r0, #4]
	add r0, sp, #0x18
	add r1, sp, #0x40
	add r0, #2
	add r1, #1
	mov r2, #2
	bl MI_CpuCopy8
	mov r1, #0xb
	add r0, sp, #0x3c
	strb r1, [r0, #7]
	add r0, sp, #0x18
	add r1, sp, #0x44
	mov r2, #2
	bl MI_CpuCopy8
	mov r1, #0xff
	add r0, sp, #0x3c
	strb r1, [r0, #0xa]
	add r0, sp, #0x14
	add r1, sp, #0x44
	add r0, #2
	add r1, #3
	mov r2, #2
	bl MI_CpuCopy8
	mov r1, #0xc
	add r0, sp, #0x3c
	strb r1, [r0, #0xd]
	add r1, sp, #0x48
	add r0, sp, #0x14
	add r1, #2
	mov r2, #2
	bl MI_CpuCopy8
	b _0217A1D8
_0217A0FE:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	bhi _0217A128
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0217A114: // jump table
	.hword _0217A120 - _0217A114 - 2 // case 0
	.hword _0217A120 - _0217A114 - 2 // case 1
	.hword _0217A120 - _0217A114 - 2 // case 2
	.hword _0217A120 - _0217A114 - 2 // case 3
	.hword _0217A120 - _0217A114 - 2 // case 4
	.hword _0217A120 - _0217A114 - 2 // case 5
_0217A120:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _0217A12A
_0217A128:
	mov r0, #1
_0217A12A:
	cmp r0, #1
	add r0, sp, #0x18
	add r1, sp, #0x3c
	bne _0217A186
	add r0, #2
	mov r2, #2
	bl MI_CpuCopy8
	mov r1, #0xb
	add r0, sp, #0x3c
	strb r1, [r0, #2]
	add r1, sp, #0x3c
	add r0, sp, #0x18
	add r1, #3
	mov r2, #2
	bl MI_CpuCopy8
	mov r1, #0xb
	add r0, sp, #0x3c
	strb r1, [r0, #5]
	add r1, sp, #0x40
	add r0, sp, #0x1c
	add r1, #2
	mov r2, #4
	bl MI_CpuCopy8
	mov r1, #0xff
	add r0, sp, #0x3c
	strb r1, [r0, #0xa]
	add r0, sp, #0x14
	add r1, sp, #0x44
	add r0, #2
	add r1, #3
	mov r2, #2
	bl MI_CpuCopy8
	mov r1, #0xc
	add r0, sp, #0x3c
	strb r1, [r0, #0xd]
	add r1, sp, #0x48
	add r0, sp, #0x14
	add r1, #2
	mov r2, #2
	bl MI_CpuCopy8
	b _0217A1D8
_0217A186:
	mov r2, #2
	bl MI_CpuCopy8
	mov r1, #0xb
	add r0, sp, #0x3c
	strb r1, [r0, #2]
	add r0, sp, #0x18
	add r1, sp, #0x3c
	add r0, #2
	add r1, #3
	mov r2, #2
	bl MI_CpuCopy8
	mov r1, #0xb
	add r0, sp, #0x3c
	strb r1, [r0, #5]
	add r1, sp, #0x40
	add r0, sp, #0x1c
	add r1, #2
	mov r2, #4
	bl MI_CpuCopy8
	mov r1, #0xff
	add r0, sp, #0x3c
	strb r1, [r0, #0xa]
	add r0, sp, #0x14
	add r1, sp, #0x44
	add r0, #2
	add r1, #3
	mov r2, #2
	bl MI_CpuCopy8
	mov r1, #0xc
	add r0, sp, #0x3c
	strb r1, [r0, #0xd]
	add r1, sp, #0x48
	add r0, sp, #0x14
	add r1, #2
	mov r2, #2
	bl MI_CpuCopy8
_0217A1D8:
	mov r4, #0
	mov r6, r4
	add r5, sp, #0x3c
_0217A1DE:
	ldrb r1, [r5, #0]
	cmp r1, #0xff
	beq _0217A1EE
	ldr r2, [sp, #8]
	add r0, r7, #4
	mov r3, r4
	bl TimeAttackRecordsMenu__Func_217A210
_0217A1EE:
	add r0, r4, #5
	lsl r0, r0, #0x10
	add r6, r6, #1
	lsr r4, r0, #0x10
	add r5, r5, #1
	cmp r6, #0x10
	blt _0217A1DE
	ldr r1, [sp, #0xc]
	ldr r0, [sp, #0x10]
	add r0, r1, r0
	bl Unknown2056570__Func_2056B8C
	add sp, #0x4c
	pop {r4, r5, r6, r7, pc}
	nop
_0217A20C: .word 0x000008C4
	thumb_func_end TimeAttackRecordsMenu__Func_2179F14

	thumb_func_start TimeAttackRecordsMenu__Func_217A210
TimeAttackRecordsMenu__Func_217A210: // 0x0217A210
	push {r3, r4, lr}
	sub sp, #0x1c
	mov r4, r1
	mov r1, #6
	str r1, [sp]
	mov r1, #8
	str r1, [sp, #4]
	str r2, [sp, #8]
	mov r1, #0xb
	str r1, [sp, #0xc]
	str r3, [sp, #0x10]
	mov r1, #7
	lsl r2, r4, #0x13
	str r1, [sp, #0x14]
	mov r3, #0
	mov r1, #0xd
	lsr r2, r2, #0x10
	str r3, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
	add sp, #0x1c
	pop {r3, r4, pc}
	thumb_func_end TimeAttackRecordsMenu__Func_217A210

	thumb_func_start TimeAttackRecordsMenu__Func_217A23C
TimeAttackRecordsMenu__Func_217A23C: // 0x0217A23C
	push {r3, r4, r5, lr}
	ldr r2, _0217A258 // =0x000008C4
	mov r5, r1
	add r4, r0, r2
	mov r0, #0x30
	mul r5, r0
	add r0, r4, r5
	bl Unknown2056570__Func_205683C
	add r0, r4, r5
	bl Unknown2056570__Func_2056B8C
	pop {r3, r4, r5, pc}
	nop
_0217A258: .word 0x000008C4
	thumb_func_end TimeAttackRecordsMenu__Func_217A23C

	thumb_func_start TimeAttackRecordsMenu__Func_217A25C
TimeAttackRecordsMenu__Func_217A25C: // 0x0217A25C
	push {r4, r5, r6, r7, lr}
	sub sp, #0x44
	mov r4, r0
	mov r0, #2
	lsl r0, r0, #0xa
	ldr r7, [r4, r0]
	mov r0, #0x30
	str r1, [sp, #0x1c]
	mov r5, r2
	bl GetFontCharacterFromUTF
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x28]
	mov r0, #0x2d
	bl GetFontCharacterFromUTF
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x24]
	mov r0, #0x27
	bl GetFontCharacterFromUTF
	add r1, sp, #0x30
	strh r0, [r1, #8]
	mov r0, #0x22
	bl GetFontCharacterFromUTF
	add r1, sp, #0x30
	strh r0, [r1, #0xe]
	mov r0, #0
	str r0, [sp, #0x2c]
	ldr r0, _0217A394 // =0x00000924
	add r1, r4, r0
	mov r0, #0xf0
	mul r0, r5
	add r0, r1, r0
	str r0, [sp, #0x20]
_0217A2A8:
	ldr r0, [sp, #0x20]
	bl Unknown2056570__Func_205683C
	ldr r0, [sp, #0x20]
	bl Unknown2056570__Func_2056834
	mov r6, r0
	ldr r0, [sp, #0x1c]
	ldr r1, _0217A398 // =0x0000FFFF
	ldrh r0, [r0, #0]
	cmp r0, r1
	beq _0217A332
	add r2, sp, #0x30
	add r1, sp, #0x34
	add r2, #2
	add r3, sp, #0x30
	bl AkUtilFrameToTime
	add r0, sp, #0x30
	ldrh r1, [r0, #4]
	strh r1, [r0, #6]
	ldrh r0, [r0, #2]
	mov r1, #0xa
	bl _s32_div_f
	add r2, sp, #0x30
	strh r0, [r2, #0xa]
	ldrh r0, [r2, #0xa]
	ldrh r4, [r2, #2]
	mov r1, #0xa
	mov r3, r0
	mul r3, r1
	sub r0, r4, r3
	strh r0, [r2, #2]
	ldrh r0, [r2, #2]
	strh r0, [r2, #0xc]
	ldrh r0, [r2, #0]
	bl _s32_div_f
	add r1, sp, #0x30
	strh r0, [r1, #0x10]
	ldrh r0, [r1, #0x10]
	mov r2, #0xa
	ldrh r3, [r1, #0]
	mul r2, r0
	sub r2, r3, r2
	strh r2, [r1]
	ldrh r2, [r1, #0]
	strh r2, [r1, #0x12]
	ldrh r3, [r1, #6]
	ldr r2, [sp, #0x28]
	add r2, r3, r2
	strh r2, [r1, #6]
	ldrh r3, [r1, #0xa]
	ldr r2, [sp, #0x28]
	add r2, r3, r2
	strh r2, [r1, #0xa]
	ldrh r3, [r1, #0xc]
	ldr r2, [sp, #0x28]
	add r2, r3, r2
	strh r2, [r1, #0xc]
	ldr r2, [sp, #0x28]
	add r0, r0, r2
	strh r0, [r1, #0x10]
	ldrh r2, [r1, #0x12]
	ldr r0, [sp, #0x28]
	add r0, r2, r0
	strh r0, [r1, #0x12]
	b _0217A342
_0217A332:
	ldr r0, [sp, #0x24]
	add r1, sp, #0x30
	strh r0, [r1, #0x12]
	ldrh r0, [r1, #0x12]
	strh r0, [r1, #0x10]
	strh r0, [r1, #0xc]
	strh r0, [r1, #0xa]
	strh r0, [r1, #6]
_0217A342:
	add r5, sp, #0x34
	mov r0, #0x10
	mov r4, #0
	add r5, #2
_0217A34A:
	mov r1, #0xa
	str r1, [sp]
	mov r1, #2
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r0, #0
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	ldrh r1, [r5, #0]
	mov r0, r7
	mov r2, #0
	mov r3, r6
	bl FontFile__Func_2052B7C
	add r4, r4, #1
	add r5, r5, #2
	cmp r4, #7
	blt _0217A34A
	ldr r0, [sp, #0x20]
	bl Unknown2056570__Func_2056B8C
	ldr r0, [sp, #0x20]
	add r0, #0x30
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x1c]
	add r0, r0, #2
	str r0, [sp, #0x1c]
	ldr r0, [sp, #0x2c]
	add r0, r0, #1
	str r0, [sp, #0x2c]
	cmp r0, #5
	blt _0217A2A8
	add sp, #0x44
	pop {r4, r5, r6, r7, pc}
	nop
_0217A394: .word 0x00000924
_0217A398: .word 0x0000FFFF
	thumb_func_end TimeAttackRecordsMenu__Func_217A25C

	thumb_func_start TimeAttackRecordsMenu__Func_217A39C
TimeAttackRecordsMenu__Func_217A39C: // 0x0217A39C
	push {r3, r4, r5, lr}
	ldr r2, _0217A3C0 // =0x00000924
	mov r4, #0
	add r2, r0, r2
	mov r0, #0xf0
	mul r0, r1
	add r5, r2, r0
_0217A3AA:
	mov r0, r5
	bl Unknown2056570__Func_205683C
	mov r0, r5
	bl Unknown2056570__Func_2056B8C
	add r4, r4, #1
	add r5, #0x30
	cmp r4, #5
	blt _0217A3AA
	pop {r3, r4, r5, pc}
	.align 2, 0
_0217A3C0: .word 0x00000924
	thumb_func_end TimeAttackRecordsMenu__Func_217A39C

	thumb_func_start TimeAttackRecordsMenu__Func_217A3C4
TimeAttackRecordsMenu__Func_217A3C4: // 0x0217A3C4
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x20
	mov r7, r3
	mov r5, r0
	mov r4, r1
	mov r6, r2
	cmp r7, #2
	blo _0217A3D6
	mov r7, #2
_0217A3D6:
	cmp r6, #0x2e
	blo _0217A410
	cmp r4, #0
	bne _0217A3E2
	mov r2, #0
	b _0217A3E4
_0217A3E2:
	mov r2, #0x20
_0217A3E4:
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	str r1, [sp, #8]
	mov r0, #8
	str r0, [sp, #0xc]
	lsl r0, r2, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r3, #0x20
	str r3, [sp, #0x18]
	mov r0, #0x18
	str r0, [sp, #0x1c]
	ldr r0, _0217A4A0 // =0x00000B44
	mov r2, r1
	ldr r0, [r5, r0]
	bl Mappings__LoadUnknown
	add sp, #0x20
	pop {r3, r4, r5, r6, r7, pc}
_0217A410:
	cmp r4, #0
	bne _0217A418
	mov r3, #0
	b _0217A41A
_0217A418:
	mov r3, #0x20
_0217A41A:
	ldr r0, _0217A4A4 // =0x00000718
	mov r2, #5
	lsl r2, r2, #0x18
	add r0, r5, r0
	mov r1, #0
	add r2, r3, r2
	bl SetPaletteAnimationTarget
	ldr r1, _0217A4A8 // =ovl03_0217E278
	ldr r0, _0217A4A4 // =0x00000718
	ldrb r1, [r1, r6]
	add r0, r5, r0
	bl SetPaletteAnimation
	ldr r0, _0217A4A4 // =0x00000718
	add r0, r5, r0
	bl AnimatePalette
	ldr r0, _0217A4A4 // =0x00000718
	add r0, r5, r0
	bl DrawAnimatedPalette
	ldr r0, _0217A4A4 // =0x00000718
	add r7, #0xa
	lsl r1, r7, #0x10
	add r0, r5, r0
	lsr r1, r1, #0x10
	bl SetPaletteAnimation
	ldr r0, _0217A4A4 // =0x00000718
	add r0, r5, r0
	bl AnimatePalette
	ldr r0, _0217A4A4 // =0x00000718
	add r0, r5, r0
	bl DrawAnimatedPalette
	cmp r4, #0
	bne _0217A46C
	mov r2, #0
	b _0217A46E
_0217A46C:
	mov r2, #0x20
_0217A46E:
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	str r1, [sp, #8]
	mov r0, #8
	str r0, [sp, #0xc]
	lsl r0, r2, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r3, #0x20
	str r3, [sp, #0x18]
	mov r0, #0x18
	str r0, [sp, #0x1c]
	lsl r0, r4, #2
	add r2, r5, r0
	ldr r0, _0217A4AC // =0x00000B48
	ldr r0, [r2, r0]
	mov r2, r1
	bl Mappings__LoadUnknown
	add sp, #0x20
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0217A4A0: .word 0x00000B44
_0217A4A4: .word 0x00000718
_0217A4A8: .word ovl03_0217E278
_0217A4AC: .word 0x00000B48
	thumb_func_end TimeAttackRecordsMenu__Func_217A3C4

	thumb_func_start TimeAttackRecordsMenu__Func_217A4B0
TimeAttackRecordsMenu__Func_217A4B0: // 0x0217A4B0
	push {r3, r4, r5, lr}
	sub sp, #0x20
	mov r5, r0
	mov r4, r1
	cmp r2, #2
	blo _0217A4F2
	cmp r4, #0
	bne _0217A4C4
	mov r2, #0
	b _0217A4C6
_0217A4C4:
	mov r2, #0x20
_0217A4C6:
	mov r1, #0
	str r1, [sp]
	mov r0, #0xd
	str r0, [sp, #4]
	str r1, [sp, #8]
	mov r0, #8
	str r0, [sp, #0xc]
	lsl r0, r2, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r3, #0x20
	str r3, [sp, #0x18]
	mov r0, #0x18
	str r0, [sp, #0x1c]
	ldr r0, _0217A534 // =0x00000B44
	mov r2, r1
	ldr r0, [r5, r0]
	bl Mappings__LoadUnknown
	add sp, #0x20
	pop {r3, r4, r5, pc}
_0217A4F2:
	bl TimeAttackRecordsMenu__Func_217A538
	cmp r4, #0
	bne _0217A4FE
	mov r2, #0
	b _0217A500
_0217A4FE:
	mov r2, #0x20
_0217A500:
	mov r1, #0
	str r1, [sp]
	mov r0, #0xd
	str r0, [sp, #4]
	str r1, [sp, #8]
	mov r0, #8
	str r0, [sp, #0xc]
	lsl r0, r2, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r3, #0x20
	str r3, [sp, #0x18]
	mov r0, #0x18
	str r0, [sp, #0x1c]
	lsl r0, r4, #2
	add r2, r5, r0
	mov r0, #0xb5
	lsl r0, r0, #4
	ldr r0, [r2, r0]
	mov r2, r1
	bl Mappings__LoadUnknown
	add sp, #0x20
	pop {r3, r4, r5, pc}
	nop
_0217A534: .word 0x00000B44
	thumb_func_end TimeAttackRecordsMenu__Func_217A4B0

	thumb_func_start TimeAttackRecordsMenu__Func_217A538
TimeAttackRecordsMenu__Func_217A538: // 0x0217A538
	push {r3, r4, r5, lr}
	mov r4, r2
	mov r5, r0
	cmp r4, #2
	blo _0217A544
	mov r4, #0
_0217A544:
	cmp r1, #0
	bne _0217A54C
	mov r3, #0
	b _0217A54E
_0217A54C:
	mov r3, #0x20
_0217A54E:
	ldr r0, _0217A57C // =0x00000718
	ldr r2, _0217A580 // =0x05000400
	add r0, r5, r0
	mov r1, #0
	add r2, r3, r2
	bl SetPaletteAnimationTarget
	ldr r0, _0217A57C // =0x00000718
	add r4, #0xd
	lsl r1, r4, #0x10
	add r0, r5, r0
	lsr r1, r1, #0x10
	bl SetPaletteAnimation
	ldr r0, _0217A57C // =0x00000718
	add r0, r5, r0
	bl AnimatePalette
	ldr r0, _0217A57C // =0x00000718
	add r0, r5, r0
	bl DrawAnimatedPalette
	pop {r3, r4, r5, pc}
	.align 2, 0
_0217A57C: .word 0x00000718
_0217A580: .word 0x05000400
	thumb_func_end TimeAttackRecordsMenu__Func_217A538

	thumb_func_start TimeAttackRecordsMenu__Func_217A584
TimeAttackRecordsMenu__Func_217A584: // 0x0217A584
	push {r4, lr}
	mov r4, r0
	ldr r0, _0217A5FC // =0x00000738
	ldr r2, [r4, r0]
	cmp r2, r1
	beq _0217A5FA
	str r1, [r4, r0]
	cmp r1, #0
	beq _0217A5D2
	mov r1, r0
	add r1, #0x18
	ldr r3, [r4, r1]
	mov r2, #0x40
	mov r1, r0
	bic r3, r2
	add r1, #0x18
	str r3, [r4, r1]
	mov r1, r0
	add r1, #0x50
	ldr r3, [r4, r1]
	mov r1, r0
	add r0, r0, #4
	bic r3, r2
	add r1, #0x50
	add r0, r4, r0
	str r3, [r4, r1]
	bl TouchField__ResetArea
	ldr r0, _0217A600 // =0x00000774
	add r0, r4, r0
	bl TouchField__ResetArea
	mov r0, #0x65
	lsl r0, r0, #4
	add r0, r4, r0
	mov r1, #0x25
	bl AnimatorSprite__SetAnimation
	pop {r4, pc}
_0217A5D2:
	add r0, r0, #4
	add r0, r4, r0
	bl TouchField__ResetArea
	ldr r0, _0217A600 // =0x00000774
	add r0, r4, r0
	bl TouchField__ResetArea
	mov r2, #0x75
	lsl r2, r2, #4
	ldr r0, [r4, r2]
	mov r1, #0x40
	orr r0, r1
	str r0, [r4, r2]
	mov r0, r2
	add r0, #0x38
	ldr r0, [r4, r0]
	add r2, #0x38
	orr r0, r1
	str r0, [r4, r2]
_0217A5FA:
	pop {r4, pc}
	.align 2, 0
_0217A5FC: .word 0x00000738
_0217A600: .word 0x00000774
	thumb_func_end TimeAttackRecordsMenu__Func_217A584

	thumb_func_start TimeAttackRecordsMenu__Func_217A604
TimeAttackRecordsMenu__Func_217A604: // 0x0217A604
	ldr r1, _0217A624 // =0x00000738
	ldr r2, [r0, r1]
	cmp r2, #0
	bne _0217A610
	mov r0, #0
	bx lr
_0217A610:
	add r1, #0x18
	ldr r1, [r0, r1]
	mov r0, #1
	lsl r0, r0, #0x16
	tst r0, r1
	beq _0217A620
	mov r0, #1
	bx lr
_0217A620:
	mov r0, #0
	bx lr
	.align 2, 0
_0217A624: .word 0x00000738
	thumb_func_end TimeAttackRecordsMenu__Func_217A604

	thumb_func_start TimeAttackRecordsMenu__Func_217A628
TimeAttackRecordsMenu__Func_217A628: // 0x0217A628
	ldr r1, _0217A648 // =0x00000738
	ldr r2, [r0, r1]
	cmp r2, #0
	bne _0217A634
	mov r0, #0
	bx lr
_0217A634:
	add r1, #0x50
	ldr r1, [r0, r1]
	mov r0, #1
	lsl r0, r0, #0x16
	tst r0, r1
	beq _0217A644
	mov r0, #1
	bx lr
_0217A644:
	mov r0, #0
	bx lr
	.align 2, 0
_0217A648: .word 0x00000738
	thumb_func_end TimeAttackRecordsMenu__Func_217A628

	thumb_func_start TimeAttackRecordsMenu__Func_217A64C
TimeAttackRecordsMenu__Func_217A64C: // 0x0217A64C
	push {r4, lr}
	ldr r1, _0217A69C // =0x00000738
	ldr r2, [r0, r1]
	cmp r2, #0
	beq _0217A698
	sub r1, #0xe8
	add r4, r0, r1
	ldr r1, [r4, #0x3c]
	mov r0, #4
	orr r0, r1
	mov r1, #0
	str r0, [r4, #0x3c]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r4, #0x3c]
	mov r0, #0x80
	bic r1, r0
	str r1, [r4, #0x3c]
	mov r0, #0x10
	strh r0, [r4, #8]
	mov r0, #0x60
	strh r0, [r4, #0xa]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	ldr r1, [r4, #0x3c]
	mov r0, #0x80
	orr r0, r1
	str r0, [r4, #0x3c]
	mov r0, #0xf0
	strh r0, [r4, #8]
	mov r0, #0x60
	strh r0, [r4, #0xa]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
_0217A698:
	pop {r4, pc}
	nop
_0217A69C: .word 0x00000738
	thumb_func_end TimeAttackRecordsMenu__Func_217A64C

	thumb_func_start TimeAttackRecordsMenu__Func_217A6A0
TimeAttackRecordsMenu__Func_217A6A0: // 0x0217A6A0
	push {r4, lr}
	ldr r2, _0217A6E0 // =0x000007AC
	mov r4, r0
	ldr r0, [r4, r2]
	cmp r0, r1
	beq _0217A6DE
	str r1, [r4, r2]
	cmp r1, #0
	beq _0217A6CC
	mov r0, r2
	add r0, #0x18
	ldr r1, [r4, r0]
	mov r0, #0x40
	bic r1, r0
	mov r0, r2
	add r0, #0x18
	str r1, [r4, r0]
	add r0, r2, #4
	add r0, r4, r0
	bl TouchField__ResetArea
	pop {r4, pc}
_0217A6CC:
	add r0, r2, #4
	add r0, r4, r0
	bl TouchField__ResetArea
	ldr r1, _0217A6E4 // =0x000007C4
	mov r0, #0x40
	ldr r2, [r4, r1]
	orr r0, r2
	str r0, [r4, r1]
_0217A6DE:
	pop {r4, pc}
	.align 2, 0
_0217A6E0: .word 0x000007AC
_0217A6E4: .word 0x000007C4
	thumb_func_end TimeAttackRecordsMenu__Func_217A6A0

	thumb_func_start TimeAttackRecordsMenu__Func_217A6E8
TimeAttackRecordsMenu__Func_217A6E8: // 0x0217A6E8
	ldr r1, _0217A708 // =0x000007AC
	ldr r2, [r0, r1]
	cmp r2, #0
	bne _0217A6F4
	mov r0, #0
	bx lr
_0217A6F4:
	add r1, #0x18
	ldr r1, [r0, r1]
	mov r0, #1
	lsl r0, r0, #0x12
	tst r0, r1
	beq _0217A704
	mov r0, #1
	bx lr
_0217A704:
	mov r0, #0
	bx lr
	.align 2, 0
_0217A708: .word 0x000007AC
	thumb_func_end TimeAttackRecordsMenu__Func_217A6E8

	thumb_func_start TimeAttackRecordsMenu__Func_217A70C
TimeAttackRecordsMenu__Func_217A70C: // 0x0217A70C
	push {r4, lr}
	ldr r2, _0217A75C // =0x000007AC
	ldr r1, [r0, r2]
	cmp r1, #0
	beq _0217A75A
	mov r1, r2
	sub r1, #0xf8
	add r4, r0, r1
	mov r1, r2
	add r1, #0x18
	ldr r1, [r0, r1]
	add r2, #0x54
	mov r0, r1
	tst r0, r2
	bne _0217A734
	mov r0, #0x10
	tst r0, r1
	beq _0217A734
	mov r1, #0x17
	b _0217A736
_0217A734:
	mov r1, #0x16
_0217A736:
	ldrh r0, [r4, #0xc]
	cmp r0, r1
	beq _0217A742
	mov r0, r4
	bl AnimatorSprite__SetAnimation
_0217A742:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x40
	strh r0, [r4, #8]
	mov r0, #0xa8
	strh r0, [r4, #0xa]
	mov r0, r4
	bl AnimatorSprite__DrawFrame
_0217A75A:
	pop {r4, pc}
	.align 2, 0
_0217A75C: .word 0x000007AC
	thumb_func_end TimeAttackRecordsMenu__Func_217A70C

	thumb_func_start TimeAttackRecordsMenu__Func_217A760
TimeAttackRecordsMenu__Func_217A760: // 0x0217A760
	push {r3, lr}
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0217A778
	ldr r0, _0217A79C // =touchInput
	ldrh r1, [r0, #0x12]
	mov r0, #4
	tst r0, r1
	beq _0217A778
	mov r0, #1
	b _0217A77A
_0217A778:
	mov r0, #0
_0217A77A:
	cmp r0, #0
	bne _0217A782
	mov r0, #0
	pop {r3, pc}
_0217A782:
	ldr r0, _0217A79C // =touchInput
	ldrh r1, [r0, #0x1e]
	ldrh r0, [r0, #0x1c]
	sub r0, #0x50
	cmp r0, #0x50
	bhs _0217A798
	sub r1, #0x88
	cmp r1, #0x18
	bhs _0217A798
	mov r0, #1
	pop {r3, pc}
_0217A798:
	mov r0, #0
	pop {r3, pc}
	.align 2, 0
_0217A79C: .word touchInput
	thumb_func_end TimeAttackRecordsMenu__Func_217A760

	thumb_func_start TimeAttackRecordsMenu__Func_217A7A0
TimeAttackRecordsMenu__Func_217A7A0: // 0x0217A7A0
	push {r3, lr}
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0217A7B8
	ldr r0, _0217A7DC // =touchInput
	ldrh r1, [r0, #0x12]
	mov r0, #4
	tst r0, r1
	beq _0217A7B8
	mov r0, #1
	b _0217A7BA
_0217A7B8:
	mov r0, #0
_0217A7BA:
	cmp r0, #0
	bne _0217A7C2
	mov r0, #0
	pop {r3, pc}
_0217A7C2:
	ldr r0, _0217A7DC // =touchInput
	ldrh r1, [r0, #0x1e]
	ldrh r0, [r0, #0x1c]
	sub r0, #0xa0
	cmp r0, #0x50
	bhs _0217A7D8
	sub r1, #0x88
	cmp r1, #0x18
	bhs _0217A7D8
	mov r0, #1
	pop {r3, pc}
_0217A7D8:
	mov r0, #0
	pop {r3, pc}
	.align 2, 0
_0217A7DC: .word touchInput
	thumb_func_end TimeAttackRecordsMenu__Func_217A7A0

	thumb_func_start TimeAttackRecordsMenu__Func_217A7E0
TimeAttackRecordsMenu__Func_217A7E0: // 0x0217A7E0
	push {r3, lr}
	cmp r0, #0
	beq _0217A7F0
	ldr r0, _0217A7FC // =TimeAttackRecordsMenu__Func_217A818
	mov r1, #0
	bl TimeAttackMenu__Func_216C610
	pop {r3, pc}
_0217A7F0:
	mov r0, #0
	mov r1, r0
	bl TimeAttackMenu__Func_216C610
	pop {r3, pc}
	nop
_0217A7FC: .word TimeAttackRecordsMenu__Func_217A818
	thumb_func_end TimeAttackRecordsMenu__Func_217A7E0

	thumb_func_start TimeAttackRecordsMenu__Func_217A800
TimeAttackRecordsMenu__Func_217A800: // 0x0217A800
	push {r3, lr}
	bl TimeAttackMenu__Func_216C640
	mov r1, #1
	lsl r1, r1, #0x12
	tst r0, r1
	beq _0217A812
	mov r0, #1
	pop {r3, pc}
_0217A812:
	mov r0, #0
	pop {r3, pc}
	.align 2, 0
	thumb_func_end TimeAttackRecordsMenu__Func_217A800

	thumb_func_start TimeAttackRecordsMenu__Func_217A818
TimeAttackRecordsMenu__Func_217A818: // 0x0217A818
	bx lr
	.align 2, 0
	thumb_func_end TimeAttackRecordsMenu__Func_217A818

	thumb_func_start TimeAttackRecordsMenu__InitStageUnknown
TimeAttackRecordsMenu__InitStageUnknown: // 0x0217A81C
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	mov r4, #0
	mov r6, r5
	strh r4, [r5, #8]
	mov r7, r4
	add r6, #8
_0217A82A:
	cmp r4, #0x16
	beq _0217A85A
	cmp r4, #0x27
	blt _0217A83A
	cmp r4, #0x2a
	bgt _0217A83A
	mov r0, r7
	b _0217A848
_0217A83A:
	mov r0, r4
	bl MenuHelpers__GetStageIDForTimeAttackRecordsMenu
	mov r1, #0
	mov r2, #1
	bl MenuHelpers__CheckProgress
_0217A848:
	cmp r0, #0
	beq _0217A85A
	ldrh r0, [r5, #8]
	lsl r0, r0, #1
	add r0, r5, r0
	strh r4, [r0, #0xa]
	ldrh r0, [r6, #0]
	add r0, r0, #1
	strh r0, [r6]
_0217A85A:
	add r4, r4, #1
	cmp r4, #0x2e
	blt _0217A82A
	ldrh r0, [r5, #8]
	cmp r0, #0
	bne _0217A86E
	mov r0, #0
	strh r0, [r5, #0xa]
	mov r0, #1
_0217A86C:
	strh r0, [r5, #8]
_0217A86E:
	pop {r3, r4, r5, r6, r7, pc}
	thumb_func_end TimeAttackRecordsMenu__InitStageUnknown

	thumb_func_start TimeAttackRecordsMenu__GetLastUsedCharacter
TimeAttackRecordsMenu__GetLastUsedCharacter: // 0x0217A870
	ldr r3, _0217A874 // =SaveGame__Block4__GetLastUsedCharacter
	bx r3
	.align 2, 0
_0217A874: .word SaveGame__Block4__GetLastUsedCharacter
	thumb_func_end TimeAttackRecordsMenu__GetLastUsedCharacter

	thumb_func_start TimeAttackRecordsMenu__GetSaveNameLength
TimeAttackRecordsMenu__GetSaveNameLength: // 0x0217A878
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _0217A89C // =saveGame
	mov r4, r1
	bl SaveGame__GetPlayerNameLength
	strh r0, [r4]
	mov r0, r5
	bl TimeAttackRecordsMenu__GetTimeAttackRecord
	ldr r1, _0217A8A0 // =0x0000FFFF
	cmp r0, r1
	bne _0217A896
	mov r0, #0
	pop {r3, r4, r5, pc}
_0217A896:
	ldr r0, _0217A89C // =saveGame
	pop {r3, r4, r5, pc}
	nop
_0217A89C: .word saveGame
_0217A8A0: .word 0x0000FFFF
	thumb_func_end TimeAttackRecordsMenu__GetSaveNameLength

	thumb_func_start TimeAttackRecordsMenu__GetTimeAttackRecord
TimeAttackRecordsMenu__GetTimeAttackRecord: // 0x0217A8A4
	push {r4, lr}
	mov r4, r0
	lsl r0, r4, #0x10
	lsr r0, r0, #0x10
	bl TimeAttackRecordsMenu__GetLastUsedCharacter
	mov r1, r0
	cmp r1, #2
	blo _0217A8BA
	ldr r0, _0217A8CC // =0x0000FFFF
	pop {r4, pc}
_0217A8BA:
	lsl r1, r1, #0x18
	ldr r0, _0217A8D0 // =saveGame+0x00000898
	lsr r1, r1, #0x18
	mov r2, r4
	mov r3, #1
	bl SaveGame__GetTimeAttackRecord
	pop {r4, pc}
	nop
_0217A8CC: .word 0x0000FFFF
_0217A8D0: .word saveGame+0x00000898
	thumb_func_end TimeAttackRecordsMenu__GetTimeAttackRecord

	thumb_func_start TimeAttackRecordsMenu__GetTimeFromRecord
TimeAttackRecordsMenu__GetTimeFromRecord: // 0x0217A8D4
	ldr r3, _0217A8D8 // =SaveGame__GetTimeFromTimeAttackRecord
	bx r3
	.align 2, 0
_0217A8D8: .word SaveGame__GetTimeFromTimeAttackRecord
	thumb_func_end TimeAttackRecordsMenu__GetTimeFromRecord

	thumb_func_start TimeAttackRecordsMenu__GetRecordUnknown
TimeAttackRecordsMenu__GetRecordUnknown: // 0x0217A8DC
	cmp r2, #0
	bne _0217A8E8
	mov r2, #0xa
	mul r2, r0
	ldr r0, _0217A8FC // =saveGame+0x00000898
	b _0217A8EE
_0217A8E8:
	mov r2, #0xa
	mul r2, r0
	ldr r0, _0217A900 // =saveGame+0x00000A64
_0217A8EE:
	lsl r1, r1, #1
	add r0, r0, r2
	ldrh r0, [r1, r0]
	cmp r0, #0
	bne _0217A8FA
	ldr r0, _0217A904 // =0x0000FFFF
_0217A8FA:
	bx lr
	.align 2, 0
_0217A8FC: .word saveGame+0x00000898
_0217A900: .word saveGame+0x00000A64
_0217A904: .word 0x0000FFFF
	thumb_func_end TimeAttackRecordsMenu__GetRecordUnknown

	thumb_func_start TimeAttackRecordsMenu__CheckProgressUnknown
TimeAttackRecordsMenu__CheckProgressUnknown: // 0x0217A908
	push {r3, lr}
	bl SaveGame__GetSystemGameProgress
	cmp r0, #0x10
	blt _0217A916
	mov r0, #1
	pop {r3, pc}
_0217A916:
	mov r0, #0
	pop {r3, pc}
	.align 2, 0
	thumb_func_end TimeAttackRecordsMenu__CheckProgressUnknown

	thumb_func_start TimeAttackRecordsMenu__Func_217A91C
TimeAttackRecordsMenu__Func_217A91C: // 0x0217A91C
	push {r3, lr}
	cmp r0, #0x13
	bhi _0217A964
	add r1, r0, r0
	add r1, pc
	ldrh r1, [r1, #6]
	lsl r1, r1, #0x10
	asr r1, r1, #0x10
	add pc, r1
_0217A92E: // jump table
	.hword _0217A956 - _0217A92E - 2 // case 0
	.hword _0217A956 - _0217A92E - 2 // case 1
	.hword _0217A964 - _0217A92E - 2 // case 2
	.hword _0217A956 - _0217A92E - 2 // case 3
	.hword _0217A956 - _0217A92E - 2 // case 4
	.hword _0217A964 - _0217A92E - 2 // case 5
	.hword _0217A956 - _0217A92E - 2 // case 6
	.hword _0217A956 - _0217A92E - 2 // case 7
	.hword _0217A964 - _0217A92E - 2 // case 8
	.hword _0217A956 - _0217A92E - 2 // case 9
	.hword _0217A956 - _0217A92E - 2 // case 10
	.hword _0217A964 - _0217A92E - 2 // case 11
	.hword _0217A956 - _0217A92E - 2 // case 12
	.hword _0217A956 - _0217A92E - 2 // case 13
	.hword _0217A964 - _0217A92E - 2 // case 14
	.hword _0217A956 - _0217A92E - 2 // case 15
	.hword _0217A956 - _0217A92E - 2 // case 16
	.hword _0217A964 - _0217A92E - 2 // case 17
	.hword _0217A956 - _0217A92E - 2 // case 18
	.hword _0217A956 - _0217A92E - 2 // case 19
_0217A956:
	bl TimeAttackRecordsMenu__GetTimeAttackRecord
	ldr r1, _0217A968 // =0x0000FFFF
	cmp r0, r1
	beq _0217A964
	mov r0, #1
	pop {r3, pc}
_0217A964:
	mov r0, #0
	pop {r3, pc}
	.align 2, 0
_0217A968: .word 0x0000FFFF
	thumb_func_end TimeAttackRecordsMenu__Func_217A91C

	thumb_func_start TimeAttackRecordsMenu__Func_217A96C
TimeAttackRecordsMenu__Func_217A96C: // 0x0217A96C
	cmp r0, #0x13
	bhi _0217A9DC
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0217A97C: // jump table
	.hword _0217A9A4 - _0217A97C - 2 // case 0
	.hword _0217A9A8 - _0217A97C - 2 // case 1
	.hword _0217A9DC - _0217A97C - 2 // case 2
	.hword _0217A9AC - _0217A97C - 2 // case 3
	.hword _0217A9B0 - _0217A97C - 2 // case 4
	.hword _0217A9DC - _0217A97C - 2 // case 5
	.hword _0217A9B4 - _0217A97C - 2 // case 6
	.hword _0217A9B8 - _0217A97C - 2 // case 7
	.hword _0217A9DC - _0217A97C - 2 // case 8
	.hword _0217A9BC - _0217A97C - 2 // case 9
	.hword _0217A9C0 - _0217A97C - 2 // case 10
	.hword _0217A9DC - _0217A97C - 2 // case 11
	.hword _0217A9C4 - _0217A97C - 2 // case 12
	.hword _0217A9C8 - _0217A97C - 2 // case 13
	.hword _0217A9DC - _0217A97C - 2 // case 14
	.hword _0217A9CC - _0217A97C - 2 // case 15
	.hword _0217A9D0 - _0217A97C - 2 // case 16
	.hword _0217A9DC - _0217A97C - 2 // case 17
	.hword _0217A9D4 - _0217A97C - 2 // case 18
	.hword _0217A9D8 - _0217A97C - 2 // case 19
_0217A9A4:
	mov r0, #0
	bx lr
_0217A9A8:
	mov r0, #1
	bx lr
_0217A9AC:
	mov r0, #2
	bx lr
_0217A9B0:
	mov r0, #3
	bx lr
_0217A9B4:
	mov r0, #4
	bx lr
_0217A9B8:
	mov r0, #5
	bx lr
_0217A9BC:
	mov r0, #6
	bx lr
_0217A9C0:
	mov r0, #7
	bx lr
_0217A9C4:
	mov r0, #8
	bx lr
_0217A9C8:
	mov r0, #9
	bx lr
_0217A9CC:
	mov r0, #0xa
	bx lr
_0217A9D0:
	mov r0, #0xb
	bx lr
_0217A9D4:
	mov r0, #0xc
	bx lr
_0217A9D8:
	mov r0, #0xd
	bx lr
_0217A9DC:
	mov r0, #0
	bx lr
	thumb_func_end TimeAttackRecordsMenu__Func_217A96C

	.data
	
aNarcDmMenuTaRa: // 0x0217EF14
	.asciz "narc/dm_menu_ta_rank_lz7.narc"
	.align 4
	
aBbDmasBb_0: // 0x0217EF34
	.asciz "bb/dmas.bb"
	.align 4