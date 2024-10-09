	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start TimeAttackLeaderboardsMenu__LoadAssets
TimeAttackLeaderboardsMenu__LoadAssets: // 0x021755D0
	mov r3, #0
	ldr r2, _021755FC // =0x0000FFFF
	str r3, [r0]
	strh r2, [r0, #4]
	strh r2, [r0, #6]
	ldr r2, [r1, #8]
	str r2, [r0, #8]
	ldr r2, [r1, #0xc]
	str r2, [r0, #0xc]
	str r1, [r0, #0x10]
	bx lr
	.align 2, 0
_021755FC: .word 0x0000FFFF
	arm_func_end TimeAttackLeaderboardsMenu__LoadAssets

	arm_func_start TimeAttackLeaderboardsMenu__ReleaseAssets
TimeAttackLeaderboardsMenu__ReleaseAssets: // 0x02175600
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x10]
	cmp r0, #0
	bne _02175634
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _02175624
	bl _FreeHEAP_USER
_02175624:
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _02175634
	bl _FreeHEAP_USER
_02175634:
	mov r0, #0
	str r0, [r4, #0xc]
	str r0, [r4, #8]
	str r0, [r4, #0x10]
	ldmia sp!, {r4, pc}
	arm_func_end TimeAttackLeaderboardsMenu__ReleaseAssets

	arm_func_start TimeAttackLeaderboardsMenu__Func_2175648
TimeAttackLeaderboardsMenu__Func_2175648: // 0x02175648
	stmdb sp!, {r4, lr}
	mov r4, r0
	cmp r1, #0xe
	ldrge r0, _02175674 // =0x0000FFFF
	strgeh r0, [r4, #6]
	ldmgeia sp!, {r4, pc}
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	bl TimeAttackLeaderboardsMenu__Func_21788C4
	strh r0, [r4, #6]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02175674: .word 0x0000FFFF
	arm_func_end TimeAttackLeaderboardsMenu__Func_2175648

	arm_func_start TimeAttackLeaderboardsMenu__Create
TimeAttackLeaderboardsMenu__Create: // 0x02175678
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r2, _02175708 // =0x0000FFFF
	mov r6, r0
	strh r2, [r6, #4]
	mov r0, #0x3000
	mov r2, #0
	str r0, [sp]
	ldr r4, _0217570C // =0x00000D64
	mov r5, r1
	ldr r0, _02175710 // =TimeAttackLeaderboardsMenu__Main
	ldr r1, _02175714 // =TimeAttackLeaderboardsMenu__Destructor
	stmib sp, {r2, r4}
	mov r3, r2
	bl TaskCreate_
	str r0, [r6]
	bl GetTaskWork_
	mov r4, r0
	tst r5, #1
	movne r0, #1
	str r6, [r4]
	moveq r0, #0
	str r0, [r4, #8]
	mov r1, #0
	mov r0, r4
	str r1, [r4, #0xc]
	bl TimeAttackLeaderboardsMenu__Init
	ldr r0, [r4, #0]
	ldr r2, _02175708 // =0x0000FFFF
	mov r1, #0
	strh r2, [r0, #6]
	ldr r0, _02175718 // =TimeAttackLeaderboardsMenu__State_2176478
	str r1, [r4, #4]
	str r0, [r4, #0xd60]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02175708: .word 0x0000FFFF
_0217570C: .word 0x00000D64
_02175710: .word TimeAttackLeaderboardsMenu__Main
_02175714: .word TimeAttackLeaderboardsMenu__Destructor
_02175718: .word TimeAttackLeaderboardsMenu__State_2176478
	arm_func_end TimeAttackLeaderboardsMenu__Create

	arm_func_start TimeAttackLeaderboardsMenu__IsActive
TimeAttackLeaderboardsMenu__IsActive: // 0x0217571C
	ldr r0, [r0, #0]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end TimeAttackLeaderboardsMenu__IsActive

	arm_func_start TimeAttackLeaderboardsMenu__Func_2175730
TimeAttackLeaderboardsMenu__Func_2175730: // 0x02175730
	ldrh r0, [r0, #4]
	bx lr
	arm_func_end TimeAttackLeaderboardsMenu__Func_2175730

	arm_func_start TimeAttackLeaderboardsMenu__Init
TimeAttackLeaderboardsMenu__Init: // 0x02175738
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl TimeAttackLeaderboardsMenu__Func_21783AC
	mov r0, #0
	ldr r1, _02175788 // =0x0000FFFF
	strh r0, [r4, #0x6e]
	strh r1, [r4, #0x70]
	mov r0, r4
	strh r1, [r4, #0x72]
	bl TimeAttackLeaderboardsMenu__SetupDisplay
	mov r0, r4
	bl TimeAttackLeaderboardsMenu__InitSprites
	mov r0, r4
	bl TimeAttackLeaderboardsMenu__Func_2175BFC
	mov r0, r4
	bl TimeAttackLeaderboardsMenu__Func_2175DE4
	mov r0, r4
	mov r1, #0
	bl TimeAttackLeaderboardsMenu__Func_2176964
	ldmia sp!, {r4, pc}
	.align 2, 0
_02175788: .word 0x0000FFFF
	arm_func_end TimeAttackLeaderboardsMenu__Init

	arm_func_start TimeAttackLeaderboardsMenu__SetupDisplay
TimeAttackLeaderboardsMenu__SetupDisplay: // 0x0217578C
	stmdb sp!, {r3, lr}
	mov r2, #0x4000000
	ldr r0, [r2, #0]
	mov r1, #0
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1800
	str r0, [r2]
	add r3, r2, #0x1000
	ldr r0, [r3, #0]
	mov r2, r1
	bic r0, r0, #0x1f00
	orr ip, r0, #0x1800
	mov r0, #1
	str ip, [r3]
	bl GX_SetGraphicsMode
	ldr lr, _02175954 // =0x0400000A
	ldr r0, _02175958 // =0x00004A0C
	ldrh r2, [lr]
	sub r3, r0, #0x204
	ldr r1, _0217595C // =0x06004000
	and r0, r2, #0x43
	orr r0, r0, #0x20c
	orr r0, r0, #0x4800
	strh r0, [lr]
	ldrh ip, [lr, #2]
	mov r0, #0
	mov r2, #0x1000
	and ip, ip, #0x43
	orr r3, ip, r3
	strh r3, [lr, #2]
	bl MIi_CpuClearFast
	ldr r1, _02175960 // =0x06005000
	mov r0, #0
	mov r2, #0x1000
	bl MIi_CpuClearFast
	ldr r1, _02175964 // =0x06008000
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	ldr r1, _02175968 // =0x0600C000
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	mov r0, #0
	ldr r1, _0217596C // =renderCoreGFXControlA
	mov r2, #0xc
	bl MIi_CpuClear16
	ldr r2, _02175970 // =0x04000008
	mov r0, #0
	ldrh r1, [r2, #0]
	bic r1, r1, #3
	strh r1, [r2]
	ldrh r1, [r2, #2]
	bic r1, r1, #3
	orr r1, r1, #1
	strh r1, [r2, #2]
	ldrh r1, [r2, #4]
	bic r1, r1, #3
	orr r1, r1, #2
	strh r1, [r2, #4]
	ldrh r1, [r2, #6]
	bic r1, r1, #3
	orr r1, r1, #3
	strh r1, [r2, #6]
	bl GXS_SetGraphicsMode
	ldr ip, _02175974 // =0x0400100A
	ldr r0, _02175958 // =0x00004A0C
	ldrh r1, [ip]
	and r1, r1, #0x43
	orr r1, r1, #0x20c
	orr r1, r1, #0x4800
	strh r1, [ip]
	ldrh r2, [ip, #2]
	sub r0, r0, #0x204
	ldr r1, _02175978 // =0x06204000
	and r2, r2, #0x43
	orr r3, r2, r0
	mov r0, #0
	mov r2, #0x1000
	strh r3, [ip, #2]
	bl MIi_CpuClearFast
	ldr r1, _0217597C // =0x06205000
	mov r0, #0
	mov r2, #0x1000
	bl MIi_CpuClearFast
	ldr r1, _02175980 // =0x06208000
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	ldr r1, _02175984 // =0x0620C000
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	ldr r1, _02175988 // =renderCoreGFXControlB
	mov r0, #0
	mov r2, #0xc
	bl MIi_CpuClear16
	ldr r1, _0217598C // =0x04001008
	ldrh r0, [r1, #0]
	bic r0, r0, #3
	strh r0, [r1]
	ldrh r0, [r1, #2]
	bic r0, r0, #3
	orr r0, r0, #1
	strh r0, [r1, #2]
	ldrh r0, [r1, #4]
	bic r0, r0, #3
	orr r0, r0, #2
	strh r0, [r1, #4]
	ldrh r0, [r1, #6]
	bic r0, r0, #3
	orr r0, r0, #3
	strh r0, [r1, #6]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02175954: .word 0x0400000A
_02175958: .word 0x00004A0C
_0217595C: .word 0x06004000
_02175960: .word 0x06005000
_02175964: .word 0x06008000
_02175968: .word 0x0600C000
_0217596C: .word renderCoreGFXControlA
_02175970: .word 0x04000008
_02175974: .word 0x0400100A
_02175978: .word 0x06204000
_0217597C: .word 0x06205000
_02175980: .word 0x06208000
_02175984: .word 0x0620C000
_02175988: .word renderCoreGFXControlB
_0217598C: .word 0x04001008
	arm_func_end TimeAttackLeaderboardsMenu__SetupDisplay

	arm_func_start TimeAttackLeaderboardsMenu__InitSprites
TimeAttackLeaderboardsMenu__InitSprites: // 0x02175990
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x38
	mov r4, r0
	ldr r0, [r4, #0]
	mov r1, #0
	ldr r0, [r0, #8]
	bl FileUnknown__GetAOUFile
	str r0, [sp, #0x2c]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _021759E8
_021759C4: // jump table
	b _021759DC // case 0
	b _021759DC // case 1
	b _021759DC // case 2
	b _021759DC // case 3
	b _021759DC // case 4
	b _021759DC // case 5
_021759DC:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _021759EC
_021759E8:
	mov r0, #1
_021759EC:
	ldr r2, [r4, #0]
	add r0, r0, #1
	mov r1, r0, lsl #0x10
	ldr r0, [r2, #8]
	mov r1, r1, lsr #0x10
	bl FileUnknown__GetAOUFile
	ldr r1, [r4, #0]
	str r0, [sp, #0x30]
	ldr r1, [r1, #0xc]
	ldr r0, _02175BEC // =0x05000600
	mov r8, #0
	ldr r10, _02175BF0 // =0x0217E1D4
	str r1, [sp, #0x34]
	add r9, r4, #0x78
	sub r11, r0, #0x400
	mov r5, r8
_02175A2C:
	ldrb r2, [r10, #0]
	cmp r8, #0xb
	add r0, sp, #0x2c
	movlt r6, #0
	movlt r7, r11
	ldrb r1, [r10, #1]
	ldr r0, [r0, r2, lsl #2]
	movge r6, #1
	ldrge r7, _02175BEC // =0x05000600
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, r6
	bl VRAMSystem__AllocSpriteVram
	str r6, [sp]
	str r5, [sp, #4]
	str r0, [sp, #8]
	str r5, [sp, #0xc]
	str r7, [sp, #0x10]
	mov r0, #2
	str r0, [sp, #0x14]
	str r5, [sp, #0x18]
	ldrb r6, [r10, #0]
	add r1, sp, #0x2c
	ldrb r2, [r10, #1]
	ldr r1, [r1, r6, lsl #2]
	mov r0, r9
	mov r3, r5
	bl AnimatorSprite__Init
	ldrb r0, [r10, #2]
	add r8, r8, #1
	add r10, r10, #4
	strh r0, [r9, #0x50]
	cmp r8, #0x12
	add r9, r9, #0x64
	blt _02175A2C
	mov r1, #0
	str r1, [r4, #0x7a0]
	add r0, r4, #0x850
	str r1, [r4, #0x7a4]
	bl TouchField__Init
	mov r1, #0
	mov r5, #0x54
	str r1, [r4, #0x85c]
	add r3, r1, #0x18
	add r2, r5, #0x18
	add r0, r4, #0x3a8
	strh r3, [sp, #0x20]
	strh r2, [sp, #0x22]
	strh r1, [sp, #0x1c]
	strh r5, [sp, #0x1e]
	str r1, [sp]
	ldr r2, _02175BF4 // =TouchField__PointInRect
	add r3, sp, #0x1c
	add r0, r0, #0x400
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	add r1, r4, #0x3a8
	ldr r2, _02175BF8 // =0x0000FFFF
	add r0, r4, #0x850
	add r1, r1, #0x400
	bl TouchField__AddArea
	ldr r1, [r4, #0x7bc]
	mov r0, #0xe8
	orr r1, r1, #0x40
	str r1, [r4, #0x7bc]
	strh r0, [sp, #0x1c]
	add r0, r0, #0x18
	strh r0, [sp, #0x20]
	mov r0, r5
	strh r0, [sp, #0x1e]
	add r0, r0, #0x18
	strh r0, [sp, #0x22]
	mov r1, #0
	str r1, [sp]
	ldr r2, _02175BF4 // =TouchField__PointInRect
	add r0, r4, #0x7e0
	add r3, sp, #0x1c
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	ldr r2, _02175BF8 // =0x0000FFFF
	add r0, r4, #0x850
	add r1, r4, #0x7e0
	bl TouchField__AddArea
	ldr r1, [r4, #0x7f4]
	mov r0, #0x40
	orr r1, r1, #0x40
	str r1, [r4, #0x7f4]
	strh r0, [sp, #0x1c]
	add r0, r0, #0xba
	strh r0, [sp, #0x20]
	mov r0, #0xa8
	strh r0, [sp, #0x1e]
	add r0, r0, #0x14
	strh r0, [sp, #0x22]
	mov r1, #0
	add r0, r4, #0x18
	str r1, [sp]
	ldr r2, _02175BF4 // =TouchField__PointInRect
	add r0, r0, #0x800
	add r3, sp, #0x1c
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	add r1, r4, #0x18
	ldr r2, _02175BF8 // =0x0000FFFF
	add r0, r4, #0x850
	add r1, r1, #0x800
	bl TouchField__AddArea
	ldr r0, [r4, #0x82c]
	orr r0, r0, #0x40
	str r0, [r4, #0x82c]
	add sp, sp, #0x38
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02175BEC: .word 0x05000600
_02175BF0: .word 0x0217E1D4
_02175BF4: .word TouchField__PointInRect
_02175BF8: .word 0x0000FFFF
	arm_func_end TimeAttackLeaderboardsMenu__InitSprites

	arm_func_start TimeAttackLeaderboardsMenu__Func_2175BFC
TimeAttackLeaderboardsMenu__Func_2175BFC: // 0x02175BFC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x54
	mov r4, r0
	mov r0, #0x800
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0xd4c]
	mov r0, #0x800
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0xd50]
	mov r0, #0x800
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0xd54]
	mov r0, #0x800
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0xd58]
	mov r0, #0x800
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0xd5c]
	ldr r1, [r4, #0xd4c]
	mov r0, #0
	mov r2, #0x600
	bl MIi_CpuClear32
	ldr r0, [r4, #0]
	mov r1, #0xa
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
	ldr r1, [r4, #0xd50]
	bl RenderCore_CPUCopyCompressed
	ldr r0, [r4, #0xd50]
	ldr r1, [r4, #0xd54]
	mov r2, #0x600
	bl MIi_CpuCopyFast
	ldr r3, [r4, #0xd54]
	mov r5, #0
_02175CC4:
	mov r2, r5, lsl #1
	ldrh r1, [r3, r2]
	mov r0, r1, lsl #4
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bne _02175CEC
	bic r0, r1, #0xf000
	orr r0, r0, #0x2000
	strh r0, [r3, r2]
	b _02175CFC
_02175CEC:
	cmp r0, #3
	biceq r0, r1, #0xf000
	orreq r0, r0, #0x4000
	streqh r0, [r3, r2]
_02175CFC:
	add r5, r5, #1
	cmp r5, #0x300
	blt _02175CC4
	ldr r0, [r4, #0]
	mov r1, #9
	ldr r0, [r0, #8]
	bl FileUnknown__GetAOUFile
	mov r5, r0
	mov r0, #2
	str r0, [sp]
	mov r2, #0x20
	str r2, [sp, #4]
	mov ip, #0x18
	add r0, sp, #0xc
	mov r1, r5
	mov r2, #4
	mov r3, #1
	str ip, [sp, #8]
	bl InitBackground
	add r0, sp, #0xc
	bl DrawBackground
	mov r0, r5
	bl GetBackgroundMappings
	ldr r1, [r4, #0xd58]
	bl RenderCore_CPUCopyCompressed
	ldr r0, [r4, #0xd58]
	ldr r1, [r4, #0xd5c]
	mov r2, #0x600
	bl MIi_CpuCopyFast
	ldr r0, [r4, #0xd4c]
	mov r1, #0x600
	bl DC_StoreRange
	ldr r0, [r4, #0xd50]
	mov r1, #0x600
	bl DC_StoreRange
	ldr r0, [r4, #0xd54]
	mov r1, #0x600
	bl DC_StoreRange
	ldr r0, [r4, #0xd58]
	mov r1, #0x600
	bl DC_StoreRange
	ldr r0, [r4, #0xd5c]
	mov r1, #0x600
	bl DC_StoreRange
	ldr r0, [r4, #0]
	mov r1, #0xd
	ldr r0, [r0, #8]
	bl FileUnknown__GetAOUFile
	mov r2, #0
	mov r1, r0
	str r2, [sp]
	mov r3, #0x5000000
	str r3, [sp, #4]
	add r0, r4, #0x780
	mov r3, r2
	bl InitPaletteAnimator
	add sp, sp, #0x54
	ldmia sp!, {r4, r5, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_2175BFC

	arm_func_start TimeAttackLeaderboardsMenu__Func_2175DE4
TimeAttackLeaderboardsMenu__Func_2175DE4: // 0x02175DE4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	mov r10, r0
	bl TimeAttackMenu__Func_216C5E4
	bl FontWindow__GetFont
	str r0, [r10, #0x868]
	mov r3, #0
	str r3, [sp]
	mov r3, #1
	str r3, [sp, #4]
	mov r3, #0xb
	str r3, [sp, #8]
	mov r3, #0x20
	str r3, [sp, #0xc]
	mov r3, #0xf
	str r3, [sp, #0x10]
	mov r3, #0xc
	add r1, r10, #0x9c
	add r2, r10, #0xec
	add r0, r10, #0x6c
	str r3, [sp, #0x14]
	mov r3, #0xe
	str r3, [sp, #0x18]
	mov r4, #2
	add r0, r0, #0x800
	add r1, r1, #0x800
	add r2, r2, #0xc00
	add r3, r10, #0xcf0
	str r4, [sp, #0x1c]
	bl TimeAttackLeaderboardsMenu__Func_217610C
	mov r1, #0
	str r1, [sp]
	mov r1, #1
	str r1, [sp, #4]
	mov r1, #0xa
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, #0x15
	str r0, [sp, #0x10]
	mov r0, #0xf
	str r0, [sp, #0x14]
	mov r0, #7
	str r0, [sp, #0x18]
	mov r0, r4
	add r1, r10, #0xfc
	str r0, [sp, #0x1c]
	add r0, r10, #0xcc
	add r2, r10, #0xf4
	add r3, r10, #0xf8
	add r1, r1, #0x800
	add r0, r0, #0x800
	add r2, r2, #0xc00
	add r3, r3, #0xc00
	bl TimeAttackLeaderboardsMenu__Func_217610C
	mov r1, #0
	str r1, [sp]
	mov r1, #1
	str r1, [sp, #4]
	mov r1, #0xa
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, #0x15
	str r0, [sp, #0x10]
	mov r0, #0x12
	str r0, [sp, #0x14]
	mov r0, #7
	str r0, [sp, #0x18]
	mov r0, r4
	str r0, [sp, #0x1c]
	add r0, r10, #0x12c
	add r1, r10, #0x15c
	add r2, r10, #0xfc
	add r0, r0, #0x800
	add r1, r1, #0x800
	add r2, r2, #0xc00
	add r3, r10, #0xd00
	bl TimeAttackLeaderboardsMenu__Func_217610C
	mov r1, #0
	str r1, [sp]
	mov r1, #1
	str r1, [sp, #4]
	mov r1, #0xa
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, #0x12
	str r0, [sp, #0x10]
	mov r0, #0x15
	str r0, [sp, #0x14]
	mov r0, #0xb
	str r0, [sp, #0x18]
	mov r0, r4
	str r0, [sp, #0x1c]
	add r0, r10, #0x18c
	add r1, r10, #0x1bc
	add r2, r10, #0x104
	add r3, r10, #0x108
	add r0, r0, #0x800
	add r1, r1, #0x800
	add r2, r2, #0xc00
	add r3, r3, #0xc00
	bl TimeAttackLeaderboardsMenu__Func_217610C
	add r0, r10, #0x118
	add r1, r10, #0x10c
	add r2, r10, #0x27c
	add r3, r10, #0x1ec
	add r6, r0, #0xc00
	add r7, r1, #0xc00
	add r8, r2, #0x800
	add r9, r3, #0x800
	mov r0, #0x20
	mov r5, #3
	mov r4, #0
	mov r11, #1
_02175FA8:
	str r11, [sp]
	str r11, [sp, #4]
	mov r1, #0xb
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, r5, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, #8
	str r0, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r0, #0x15
	str r0, [sp, #0x18]
	mov r1, #2
	str r1, [sp, #0x1c]
	mov r0, r9
	mov r1, r8
	mov r2, r7
	mov r3, r6
	bl TimeAttackLeaderboardsMenu__Func_217610C
	add r4, r4, #1
	add r5, r5, #2
	add r6, r6, #4
	add r7, r7, #4
	add r8, r8, #0x30
	add r9, r9, #0x30
	cmp r4, #3
	blt _02175FA8
	add r1, r10, #0x138
	add r2, r10, #0x124
	add r3, r10, #0x3fc
	add r7, r10, #0x30c
	add r4, r1, #0xc00
	add r5, r2, #0xc00
	add r6, r3, #0x800
	add r7, r7, #0x800
	mov r8, #0xb
	mov r9, #0
	mov r11, #1
_02176040:
	str r11, [sp]
	str r11, [sp, #4]
	mov r1, #0xb
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	mov r0, r8, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, #8
	str r0, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r0, #0x15
	str r0, [sp, #0x18]
	mov r1, #2
	str r1, [sp, #0x1c]
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl TimeAttackLeaderboardsMenu__Func_217610C
	add r9, r9, #1
	add r8, r8, #2
	add r4, r4, #4
	add r5, r5, #4
	add r6, r6, #0x30
	add r7, r7, #0x30
	cmp r9, #5
	blt _02176040
	ldr r0, [r10, #0]
	mov r1, #0xb
	ldr r0, [r0, #8]
	bl FileUnknown__GetAOUFile
	bl GetBackgroundPalette
	ldr r2, _021760FC // =0x05000140
	mov r1, #0
	bl QueueCompressedPalette
	ldr r0, _02176100 // =FontAnimator__Palettes+0x00000008
	ldr r3, _02176104 // =0x05000162
	mov r1, #4
	mov r2, #0
	bl QueueUncompressedPalette
	ldr r0, _02176100 // =FontAnimator__Palettes+0x00000008
	mov r1, #4
	mov r2, #0
	ldr r3, _02176108 // =0x05000562
	bl QueueUncompressedPalette
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021760FC: .word 0x05000140
_02176100: .word FontAnimator__Palettes+0x00000008
_02176104: .word 0x05000162
_02176108: .word 0x05000562
	arm_func_end TimeAttackLeaderboardsMenu__Func_2175DE4

	arm_func_start TimeAttackLeaderboardsMenu__Func_217610C
TimeAttackLeaderboardsMenu__Func_217610C: // 0x0217610C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x1c
	ldrh r4, [sp, #0x58]
	ldrh r5, [sp, #0x5c]
	mov r10, r0
	mov r0, r4, lsl #5
	mul r4, r5, r0
	mov r8, r2
	mov r0, r4
	mov r9, r1
	mov r7, r3
	ldr r6, [sp, #0x4c]
	bl _AllocHeadHEAP_USER
	str r0, [r8]
	mov r0, r4
	bl _AllocHeadHEAP_USER
	str r0, [r7]
	ldrh r5, [sp, #0x50]
	ldrh r1, [sp, #0x54]
	ldrh r0, [sp, #0x58]
	str r5, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldrh r1, [sp, #0x5c]
	mov r3, #0
	mov r0, r10
	str r1, [sp, #0xc]
	ldr r2, [r8, #0]
	ldr r1, [sp, #0x40]
	str r2, [sp, #0x10]
	str r3, [sp, #0x14]
	ldrh r2, [sp, #0x44]
	str r6, [sp, #0x18]
	bl Unknown2056570__Init
	ldrh r1, [sp, #0x48]
	mov r0, r10
	bl Unknown2056570__Func_2056688
	mov r0, r10
	bl Unknown2056570__Func_205683C
	mov r0, r10
	bl Unknown2056570__Func_2056B8C
	add r0, r5, #0x20
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldrh r2, [sp, #0x54]
	ldrh r1, [sp, #0x58]
	ldrh r0, [sp, #0x5c]
	str r2, [sp, #4]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	ldr r0, [r7, #0]
	ldrh r2, [sp, #0x44]
	str r0, [sp, #0x10]
	mov r3, #0
	ldr r1, [sp, #0x40]
	add r6, r6, r4
	str r3, [sp, #0x14]
	mov r0, r9
	str r6, [sp, #0x18]
	bl Unknown2056570__Init
	ldrh r1, [sp, #0x48]
	mov r0, r9
	bl Unknown2056570__Func_2056688
	mov r0, r9
	bl Unknown2056570__Func_205683C
	mov r0, r9
	bl Unknown2056570__Func_2056B8C
	add r0, r6, r4
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_217610C

	arm_func_start TimeAttackLeaderboardsMenu__Func_2176228
TimeAttackLeaderboardsMenu__Func_2176228: // 0x02176228
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl TimeAttackLeaderboardsMenu__Func_21762D4
	mov r0, r4
	bl TimeAttackLeaderboardsMenu__Func_2176298
	mov r0, r4
	bl TimeAttackLeaderboardsMenu__Func_2176258
	mov r0, r4
	bl TimeAttackLeaderboardsMenu__Func_2176254
	bl TimeAttackMenu__Func_216C688
	ldmia sp!, {r4, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_2176228

	arm_func_start TimeAttackLeaderboardsMenu__Func_2176254
TimeAttackLeaderboardsMenu__Func_2176254: // 0x02176254
	bx lr
	arm_func_end TimeAttackLeaderboardsMenu__Func_2176254

	arm_func_start TimeAttackLeaderboardsMenu__Func_2176258
TimeAttackLeaderboardsMenu__Func_2176258: // 0x02176258
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	add r5, r6, #0x78
	mov r4, #0
_02176268:
	mov r0, r5
	bl AnimatorSprite__Release
	add r4, r4, #1
	cmp r4, #0x12
	add r5, r5, #0x64
	blt _02176268
	ldr r2, _02176294 // =0x00000708
	add r1, r6, #0x78
	mov r0, #0
	bl MIi_CpuClear16
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02176294: .word 0x00000708
	arm_func_end TimeAttackLeaderboardsMenu__Func_2176258

	arm_func_start TimeAttackLeaderboardsMenu__Func_2176298
TimeAttackLeaderboardsMenu__Func_2176298: // 0x02176298
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x780
	bl ReleasePaletteAnimator
	ldr r0, [r4, #0xd5c]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xd58]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xd54]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xd50]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xd4c]
	bl _FreeHEAP_USER
	ldmia sp!, {r4, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_2176298

	arm_func_start TimeAttackLeaderboardsMenu__Func_21762D4
TimeAttackLeaderboardsMenu__Func_21762D4: // 0x021762D4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	add r0, r4, #0x3fc
	add r1, r4, #0x30c
	add r6, r0, #0x800
	add r7, r1, #0x800
	mov r5, #0
_021762F0:
	mov r0, r6
	bl Unknown2056570__Func_2056670
	mov r0, r7
	bl Unknown2056570__Func_2056670
	add r0, r4, r5, lsl #2
	ldr r0, [r0, #0xd38]
	bl _FreeHEAP_USER
	add r0, r4, r5, lsl #2
	ldr r0, [r0, #0xd24]
	bl _FreeHEAP_USER
	add r5, r5, #1
	cmp r5, #5
	add r6, r6, #0x30
	add r7, r7, #0x30
	blt _021762F0
	add r0, r4, #0x27c
	add r1, r4, #0x1ec
	add r5, r0, #0x800
	add r6, r1, #0x800
	mov r7, #0
_02176340:
	mov r0, r5
	bl Unknown2056570__Func_2056670
	mov r0, r6
	bl Unknown2056570__Func_2056670
	add r0, r4, r7, lsl #2
	ldr r0, [r0, #0xd18]
	bl _FreeHEAP_USER
	add r0, r4, r7, lsl #2
	ldr r0, [r0, #0xd0c]
	bl _FreeHEAP_USER
	add r7, r7, #1
	cmp r7, #3
	add r5, r5, #0x30
	add r6, r6, #0x30
	blt _02176340
	add r0, r4, #0x1bc
	add r0, r0, #0x800
	bl Unknown2056570__Func_2056670
	add r0, r4, #0x18c
	add r0, r0, #0x800
	bl Unknown2056570__Func_2056670
	ldr r0, [r4, #0xd08]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xd04]
	bl _FreeHEAP_USER
	add r0, r4, #0x15c
	add r0, r0, #0x800
	bl Unknown2056570__Func_2056670
	add r0, r4, #0x12c
	add r0, r0, #0x800
	bl Unknown2056570__Func_2056670
	ldr r0, [r4, #0xd00]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xcfc]
	bl _FreeHEAP_USER
	add r0, r4, #0xfc
	add r0, r0, #0x800
	bl Unknown2056570__Func_2056670
	add r0, r4, #0xcc
	add r0, r0, #0x800
	bl Unknown2056570__Func_2056670
	ldr r0, [r4, #0xcf8]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xcf4]
	bl _FreeHEAP_USER
	add r0, r4, #0x9c
	add r0, r0, #0x800
	bl Unknown2056570__Func_2056670
	add r0, r4, #0x6c
	add r0, r0, #0x800
	bl Unknown2056570__Func_2056670
	ldr r0, [r4, #0xcf0]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0xcec]
	bl _FreeHEAP_USER
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_21762D4

	arm_func_start TimeAttackLeaderboardsMenu__Main
TimeAttackLeaderboardsMenu__Main: // 0x02176420
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0xd60]
	cmp r0, #0
	beq _02176450
	add r0, r4, #0x850
	bl TouchField__Process
	ldr r1, [r4, #0xd60]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
_02176450:
	bl DestroyCurrentTask
	ldmia sp!, {r4, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Main

	arm_func_start TimeAttackLeaderboardsMenu__Destructor
TimeAttackLeaderboardsMenu__Destructor: // 0x02176458
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl TimeAttackLeaderboardsMenu__Func_2176228
	ldr r0, [r4, #0]
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r4, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Destructor

	arm_func_start TimeAttackLeaderboardsMenu__State_2176478
TimeAttackLeaderboardsMenu__State_2176478: // 0x02176478
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #4]
	cmp r1, #0
	moveq r0, #1
	streq r0, [r4, #4]
	ldmeqia sp!, {r4, pc}
	mov r3, #0x4000000
	ldr r2, [r3, #0]
	ldr r1, [r3, #0]
	and r2, r2, #0x1f00
	mov ip, r2, lsr #8
	bic r2, r1, #0x1f00
	orr r1, ip, #6
	orr r1, r2, r1, lsl #8
	str r1, [r3]
	add r3, r3, #0x1000
	ldr r2, [r3, #0]
	ldr r1, [r3, #0]
	and r2, r2, #0x1f00
	mov ip, r2, lsr #8
	bic r2, r1, #0x1f00
	orr r1, ip, #6
	orr r2, r2, r1, lsl #8
	mov r1, #1
	str r2, [r3]
	bl TimeAttackLeaderboardsMenu__Func_2176B90
	mov r1, #0
	ldr r0, _021764F8 // =TimeAttackLeaderboardsMenu__State_21768A4
	str r1, [r4, #4]
	str r0, [r4, #0xd60]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021764F8: .word TimeAttackLeaderboardsMenu__State_21768A4
	arm_func_end TimeAttackLeaderboardsMenu__State_2176478

	arm_func_start TimeAttackLeaderboardsMenu__State_21764FC
TimeAttackLeaderboardsMenu__State_21764FC: // 0x021764FC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x1c
	mov r9, r0
	ldrh r2, [r9, #0x6e]
	ldrh r1, [r9, #0x10]
	mov r4, #0
	add r2, r9, r2, lsl #1
	mov r6, r4
	mov r7, r4
	cmp r1, #1
	ldrh r8, [r2, #0x70]
	bls _02176574
	ldr r1, _021767DC // =padInput
	ldrh r1, [r1, #0]
	tst r1, #0x20
	bne _02176548
	bl TimeAttackLeaderboardsMenu__Func_21781A8
	cmp r0, #0
	beq _02176574
_02176548:
	cmp r8, #0
	subne r0, r8, #1
	ldreqh r0, [r9, #0x10]
	mov r4, #1
	mov r5, #0
	subeq r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	mov r0, #0xb
	bl PlaySysSfx
	b _02176638
_02176574:
	ldrh r0, [r9, #0x10]
	cmp r0, #1
	bls _021765D4
	ldr r0, _021767DC // =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x10
	bne _021765A0
	mov r0, r9
	bl TimeAttackLeaderboardsMenu__Func_21781CC
	cmp r0, #0
	beq _021765D4
_021765A0:
	ldrh r0, [r9, #0x10]
	sub r0, r0, #1
	cmp r8, r0
	movge r8, #0
	bge _021765C0
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
_021765C0:
	mov r4, #1
	mov r0, #0xb
	mov r5, r4
	bl PlaySysSfx
	b _02176638
_021765D4:
	ldr r0, _021767DC // =padInput
	ldrh r0, [r0, #4]
	tst r0, #2
	bne _021765F0
	bl TimeAttackLeaderboardsMenu__Func_2178390
	cmp r0, #0
	beq _02176600
_021765F0:
	mov r0, #2
	mov r6, #1
	bl PlaySysSfx
	b _02176638
_02176600:
	ldr r0, [r9, #8]
	cmp r0, #0
	bne _0217661C
	ldr r0, _021767DC // =padInput
	ldrh r0, [r0, #4]
	tst r0, #8
	bne _0217662C
_0217661C:
	mov r0, r9
	bl TimeAttackLeaderboardsMenu__Func_21782C8
	cmp r0, #0
	beq _02176638
_0217662C:
	mov r7, #1
	mov r0, r7
	bl PlaySysSfx
_02176638:
	mov r0, r9
	mov r1, #0x1000
	bl TimeAttackLeaderboardsMenu__Draw
	mov r0, r9
	bl TimeAttackLeaderboardsMenu__Func_21782EC
	mov r0, r9
	bl TimeAttackLeaderboardsMenu__Func_21781F0
	cmp r4, #0
	beq _021766AC
	mov r0, r9
	mov r1, r8
	bl TimeAttackLeaderboardsMenu__Func_2176964
	mov r0, r9
	mov r1, r5
	bl TimeAttackLeaderboardsMenu__Func_2176B90
	mov r0, #0
	bl TimeAttackLeaderboardsMenu__Func_2178360
	mov r0, r9
	mov r1, #0
	bl TimeAttackLeaderboardsMenu__Func_2178118
	mov r0, r9
	mov r1, #0
	bl TimeAttackLeaderboardsMenu__Func_2178270
	mov r1, #0
	ldr r0, _021767E0 // =TimeAttackLeaderboardsMenu__State_21768A4
	str r1, [r9, #4]
	add sp, sp, #0x1c
	str r0, [r9, #0xd60]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_021766AC:
	cmp r6, #0
	beq _02176704
	ldr r1, _021767E4 // =0x0000FFFF
	mov r0, r9
	bl TimeAttackLeaderboardsMenu__Func_2176964
	mov r0, r9
	mov r1, #1
	bl TimeAttackLeaderboardsMenu__Func_2176B90
	mov r0, #0
	bl TimeAttackLeaderboardsMenu__Func_2178360
	mov r0, r9
	mov r1, #0
	bl TimeAttackLeaderboardsMenu__Func_2178118
	mov r0, r9
	mov r1, #0
	bl TimeAttackLeaderboardsMenu__Func_2178270
	mov r1, #0
	ldr r0, _021767E0 // =TimeAttackLeaderboardsMenu__State_21768A4
	str r1, [r9, #4]
	add sp, sp, #0x1c
	str r0, [r9, #0xd60]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_02176704:
	cmp r7, #0
	beq _0217678C
	mov r0, #0
	bl TimeAttackLeaderboardsMenu__Func_2178360
	mov r0, r9
	mov r1, #0
	bl TimeAttackLeaderboardsMenu__Func_2178118
	mov r0, r9
	mov r1, #0
	bl TimeAttackLeaderboardsMenu__Func_2178270
	bl TimeAttackMenu__Func_216C670
	mov r5, r0
	bl TimeAttackMenu__Func_216C5E4
	mov r4, r0
	bl TimeAttackMenu__Func_216C5FC
	mov r2, #0
	str r2, [sp]
	stmib sp, {r2, r4}
	str r0, [sp, #0xc]
	mov r1, #0xa
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r1, #2
	mov r0, r5
	mov r2, #1
	mov r3, #8
	str r1, [sp, #0x18]
	bl SaveSpriteButton__Func_20651D4
	mov r0, #0
	str r0, [r9, #4]
	ldr r0, _021767E8 // =TimeAttackLeaderboardsMenu__State_21767EC
	add sp, sp, #0x1c
	str r0, [r9, #0xd60]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_0217678C:
	mov r0, #1
	bl TimeAttackLeaderboardsMenu__Func_2178360
	ldrh r0, [r9, #0x10]
	cmp r0, #1
	mov r0, r9
	bls _021767B0
	mov r1, #1
	bl TimeAttackLeaderboardsMenu__Func_2178118
	b _021767B8
_021767B0:
	mov r1, #0
	bl TimeAttackLeaderboardsMenu__Func_2178118
_021767B8:
	ldr r0, [r9, #8]
	cmp r0, #0
	addne sp, sp, #0x1c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, pc}
	mov r0, r9
	mov r1, #1
	bl TimeAttackLeaderboardsMenu__Func_2178270
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_021767DC: .word padInput
_021767E0: .word TimeAttackLeaderboardsMenu__State_21768A4
_021767E4: .word 0x0000FFFF
_021767E8: .word TimeAttackLeaderboardsMenu__State_21767EC
	arm_func_end TimeAttackLeaderboardsMenu__State_21764FC

	arm_func_start TimeAttackLeaderboardsMenu__State_21767EC
TimeAttackLeaderboardsMenu__State_21767EC: // 0x021767EC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl TimeAttackMenu__Func_216C670
	bl SaveSpriteButton__RunState2
	mov r0, r4
	mov r1, #0x1000
	bl TimeAttackLeaderboardsMenu__Draw
	bl TimeAttackMenu__Func_216C670
	bl SaveSpriteButton__CheckInvalidState2
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl TimeAttackMenu__Func_216C670
	bl SaveSpriteButton__Func_2065498
	cmp r0, #0
	bne _02176884
	ldrh r1, [r4, #0x6e]
	ldr r0, [r4, #0]
	add r1, r4, r1, lsl #1
	ldrh r1, [r1, #0x70]
	add r1, r4, r1, lsl #1
	ldrh r1, [r1, #0x12]
	strh r1, [r0, #4]
	ldr r0, [r4, #0]
	ldrh r0, [r0, #4]
	bl TimeAttackLeaderboardsMenu__Func_21787F0
	ldr r2, [r4, #0]
	ldr r1, _02176898 // =0x0000FFFF
	strh r0, [r2, #4]
	mov r0, r4
	bl TimeAttackLeaderboardsMenu__Func_2176964
	mov r0, r4
	mov r1, #1
	bl TimeAttackLeaderboardsMenu__Func_2176B90
	mov r1, #0
	ldr r0, _0217689C // =TimeAttackLeaderboardsMenu__State_21768A4
	str r1, [r4, #4]
	str r0, [r4, #0xd60]
	ldmia sp!, {r4, pc}
_02176884:
	mov r1, #0
	ldr r0, _021768A0 // =TimeAttackLeaderboardsMenu__State_21764FC
	str r1, [r4, #4]
	str r0, [r4, #0xd60]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02176898: .word 0x0000FFFF
_0217689C: .word TimeAttackLeaderboardsMenu__State_21768A4
_021768A0: .word TimeAttackLeaderboardsMenu__State_21764FC
	arm_func_end TimeAttackLeaderboardsMenu__State_21767EC

	arm_func_start TimeAttackLeaderboardsMenu__State_21768A4
TimeAttackLeaderboardsMenu__State_21768A4: // 0x021768A4
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r3, [r4, #4]
	cmp r3, #4
	bhs _021768D8
	ldr r1, _02176958 // =0x00000333
	mov ip, #0x800
	mov r0, #0
	mov r2, #4
	str ip, [sp]
	bl Unknown2051334__Func_2051534
	b _021768F4
_021768D8:
	ldr r0, _02176958 // =0x00000333
	mov ip, #0x1800
	sub r3, r3, #4
	mov r1, #0x1000
	mov r2, #0x14
	str ip, [sp]
	bl Unknown2051334__Func_2051534
_021768F4:
	mov r0, r0, lsl #0x10
	mov r1, r0, asr #0x10
	mov r0, r4
	bl TimeAttackLeaderboardsMenu__Draw
	ldr r0, [r4, #4]
	add r0, r0, #1
	cmp r0, #0x18
	addlo sp, sp, #4
	str r0, [r4, #4]
	ldmloia sp!, {r3, r4, pc}
	ldrh r1, [r4, #0x6e]
	ldr r0, _0217695C // =0x0000FFFF
	add r1, r4, r1, lsl #1
	ldrh r1, [r1, #0x70]
	cmp r1, r0
	moveq r0, #0
	addeq sp, sp, #4
	streq r0, [r4, #0xd60]
	ldmeqia sp!, {r3, r4, pc}
	mov r1, #0
	ldr r0, _02176960 // =TimeAttackLeaderboardsMenu__State_21764FC
	str r1, [r4, #4]
	str r0, [r4, #0xd60]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02176958: .word 0x00000333
_0217695C: .word 0x0000FFFF
_02176960: .word TimeAttackLeaderboardsMenu__State_21764FC
	arm_func_end TimeAttackLeaderboardsMenu__State_21768A4

	arm_func_start TimeAttackLeaderboardsMenu__Func_2176964
TimeAttackLeaderboardsMenu__Func_2176964: // 0x02176964
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r6, r0
	ldrh r0, [r6, #0x6e]
	ldr r3, _02176B8C // =0x0000FFFF
	rsb r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	add r0, r6, r4, lsl #1
	strh r1, [r0, #0x70]
	ldrh r0, [r6, #0x10]
	cmp r1, r0
	addlo r0, r6, r1, lsl #1
	ldrloh r5, [r0, #0x12]
	ldrhs r5, _02176B8C // =0x0000FFFF
	cmp r5, r3
	beq _021769D8
	mov r0, r5
	bl TimeAttackLeaderboardsMenu__Func_21784E0
	mov r3, r0
	mov r0, r6
	mov r1, r4
	mov r2, r5
	bl TimeAttackLeaderboardsMenu__Func_2177F04
	mov r0, r6
	mov r1, r4
	mov r2, #1
	bl TimeAttackLeaderboardsMenu__Func_217804C
	b _021769F8
_021769D8:
	mov r0, r6
	mov r1, r4
	mov r2, r5
	bl TimeAttackLeaderboardsMenu__Func_2177F04
	mov r0, r6
	mov r1, r4
	mov r2, #0
	bl TimeAttackLeaderboardsMenu__Func_217804C
_021769F8:
	ldr r0, _02176B8C // =0x0000FFFF
	cmp r5, r0
	beq _02176B30
	add r1, sp, #8
	mov r0, r5
	bl TimeAttackLeaderboardsMenu__Func_21784EC
	mov r2, r0
	ldrh r3, [sp, #8]
	mov r0, r6
	mov r1, r4
	bl TimeAttackLeaderboardsMenu__Func_2177214
	mov r0, r5
	bl TimeAttackLeaderboardsMenu__Func_217852C
	strh r0, [sp, #0xa]
	ldrh r2, [sp, #0xa]
	mov r0, r6
	mov r1, r4
	bl TimeAttackLeaderboardsMenu__Func_2177348
	mov r0, r5
	bl TimeAttackLeaderboardsMenu__Func_21787E0
	mov r2, r0
	mov r0, r6
	mov r1, r4
	bl TimeAttackLeaderboardsMenu__Func_2177508
	mov r0, r5
	bl TimeAttackLeaderboardsMenu__Func_2178568
	mov r2, r0
	mov r3, r1
	mov r0, r6
	mov r1, r4
	bl TimeAttackLeaderboardsMenu__Func_2177758
	mov r9, #0
	add r8, sp, #0xa
	add r7, sp, #8
_02176A80:
	mov r1, r9, lsl #0x10
	mov r0, r5
	mov r2, r8
	mov r3, r7
	mov r1, r1, lsr #0x10
	bl TimeAttackLeaderboardsMenu__Func_2178578
	ldrh r2, [sp, #8]
	mov r1, r9, lsl #0x10
	mov r3, r0
	str r2, [sp]
	ldrh ip, [sp, #0xa]
	mov r0, r6
	mov r2, r1, lsr #0x10
	str ip, [sp, #4]
	mov r1, r4
	bl TimeAttackLeaderboardsMenu__Func_2177C00
	add r9, r9, #1
	cmp r9, #3
	blt _02176A80
	mov r9, #0
	add r8, sp, #0xa
	add r7, sp, #8
_02176AD8:
	mov r1, r9, lsl #0x10
	mov r0, r5
	mov r2, r8
	mov r3, r7
	mov r1, r1, lsr #0x10
	bl TimeAttackLeaderboardsMenu__Func_217862C
	ldrh r3, [sp, #8]
	add r1, r9, #3
	mov r2, r1, lsl #0x10
	str r3, [sp]
	ldrh r1, [sp, #0xa]
	mov r3, r0
	mov r0, r6
	str r1, [sp, #4]
	mov r1, r4
	mov r2, r2, lsr #0x10
	bl TimeAttackLeaderboardsMenu__Func_2177C00
	add r9, r9, #1
	cmp r9, #5
	blt _02176AD8
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_02176B30:
	mov r0, r6
	mov r1, r4
	bl TimeAttackLeaderboardsMenu__Func_2177320
	mov r0, r6
	mov r1, r4
	bl TimeAttackLeaderboardsMenu__Func_21774E0
	mov r0, r6
	mov r1, r4
	bl TimeAttackLeaderboardsMenu__Func_2177730
	mov r0, r6
	mov r1, r4
	bl TimeAttackLeaderboardsMenu__Func_2177BD8
	mov r5, #0
_02176B64:
	mov r2, r5, lsl #0x10
	mov r0, r6
	mov r1, r4
	mov r2, r2, lsr #0x10
	bl TimeAttackLeaderboardsMenu__Func_2177E9C
	add r5, r5, #1
	cmp r5, #8
	blt _02176B64
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02176B8C: .word 0x0000FFFF
	arm_func_end TimeAttackLeaderboardsMenu__Func_2176964

	arm_func_start TimeAttackLeaderboardsMenu__Func_2176B90
TimeAttackLeaderboardsMenu__Func_2176B90: // 0x02176B90
	ldrh r2, [r0, #0x6e]
	rsb r2, r2, #1
	strh r2, [r0, #0x6e]
	str r1, [r0, #0x74]
	bx lr
	arm_func_end TimeAttackLeaderboardsMenu__Func_2176B90

	arm_func_start TimeAttackLeaderboardsMenu__Draw
TimeAttackLeaderboardsMenu__Draw: // 0x02176BA4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	mov r10, r0
	ldrh r3, [r10, #0x10]
	ldrh r2, [r10, #0x70]
	cmp r2, r3
	ldrhs r2, _02177070 // =0x0000FFFF
	strhsh r2, [sp, #0x18]
	bhs _02176BD4
	add r2, r10, r2, lsl #1
	ldrh r2, [r2, #0x12]
	strh r2, [sp, #0x18]
_02176BD4:
	ldrh r2, [r10, #0x72]
	cmp r2, r3
	ldrhs r2, _02177070 // =0x0000FFFF
	strhsh r2, [sp, #0x1a]
	bhs _02176BF4
	add r2, r10, r2, lsl #1
	ldrh r2, [r2, #0x12]
	strh r2, [sp, #0x1a]
_02176BF4:
	ldrh r2, [r10, #0x6e]
	mov r1, r1, lsl #8
	mov r3, r1, asr #0xc
	cmp r2, #0
	ldr r1, [r10, #0x74]
	addeq r3, r3, #0x100
	cmp r1, #0
	ldr r1, _02177074 // =0x000001FF
	rsbeq r3, r3, #0
	and r3, r3, r1
	ldr r2, _02177078 // =renderCoreGFXControlB
	ldr r1, _0217707C // =renderCoreGFXControlA
	strh r3, [r2, #4]
	ldrh r5, [r2, #4]
	rsb r3, r3, #0x200
	mov r4, #0
	strh r5, [r1, #4]
	strh r5, [r2, #8]
	strh r5, [r1, #8]
	strh r4, [r2, #6]
	strh r4, [r1, #6]
	strh r4, [r2, #0xa]
	strh r4, [r1, #0xa]
	cmp r3, #0x100
	bge _02176C68
	sub r1, r3, #0x100
	str r3, [sp, #0x10]
	str r1, [sp, #0x14]
	b _02176C7C
_02176C68:
	rsb r1, r3, #0x200
	rsb r2, r1, #0
	add r1, r2, #0x100
	str r2, [sp, #0x10]
	str r1, [sp, #0x14]
_02176C7C:
	ldrh r2, [r10, #0x70]
	ldrh r3, [r10, #0x72]
	cmp r2, #0x2e
	movhs r1, #0x100
	strhs r1, [sp, #0x10]
	cmp r3, #0x2e
	movhs r1, #0x100
	strhs r1, [sp, #0x14]
	cmp r2, #0x2e
	cmplo r3, #0x2e
	movlo r0, #0
	blo _02176CC0
	cmp r2, #0x2e
	ldrlo r0, [sp, #0x10]
	blo _02176CC0
	cmp r3, #0x2e
	ldrlo r0, [sp, #0x14]
_02176CC0:
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x40
	bge _02176CEC
	rsb r0, r0, #8
	mov r1, r0, lsl #0x10
	add r0, r10, #0x208
	mov r2, r1, asr #0x10
	mov r1, #8
	mov r3, #0
	bl TimeAttackLeaderboardsMenu__Func_217708C
_02176CEC:
	mov r0, #0x18
	str r0, [sp]
	mov r1, #0x30
	str r1, [sp, #4]
	ldr r0, [sp, #0x10]
	ldr r9, [sp, #0x14]
	str r0, [sp, #8]
	ldr r3, _02177080 // =0x0217E2A8
	mov r0, r10
	add r1, r10, #0x140
	add r2, r10, #0x1a4
	str r9, [sp, #0xc]
	bl TimeAttackLeaderboardsMenu__Func_2177174
	mov r0, #4
	str r0, [sp]
	mov r1, #0x1c
	str r1, [sp, #4]
	ldr r0, [sp, #0x10]
	ldr r3, _02177084 // =0x0217E2D8
	str r0, [sp, #8]
	mov r0, r10
	add r1, r10, #0x78
	add r2, r10, #0xdc
	str r9, [sp, #0xc]
	bl TimeAttackLeaderboardsMenu__Func_2177174
	mov r0, #0xba
	str r0, [sp]
	mov r1, #0x30
	str r1, [sp, #4]
	ldr r0, [sp, #0x10]
	ldr r3, _02177088 // =0x0217E308
	str r0, [sp, #8]
	mov r0, r10
	add r1, r10, #0x2d0
	add r2, r10, #0x334
	str r9, [sp, #0xc]
	bl TimeAttackLeaderboardsMenu__Func_2177174
	mov r8, #0
	add r7, r10, #0x78
	mov r6, #0x80
	mov r11, #0x76
	add r5, sp, #0x10
	mov r4, #0x64
_02176D98:
	add r0, r10, r8, lsl #1
	ldrh r1, [r0, #0x70]
	ldrh r0, [r10, #0x10]
	cmp r1, r0
	bhs _02176DD8
	add r0, r10, r1, lsl #1
	ldrh r0, [r0, #0x12]
	bl TimeAttackLeaderboardsMenu__Func_21784E0
	cmp r0, #2
	bhs _02176DD8
	add r1, r0, #9
	mla r0, r1, r4, r7
	ldr r3, [r5, r8, lsl #2]
	mov r1, r6
	mov r2, r11
	bl TimeAttackLeaderboardsMenu__Func_217708C
_02176DD8:
	add r8, r8, #1
	cmp r8, #2
	blt _02176D98
	mov r4, #0
	mov r7, #0x80
	mov r6, #0x94
	add r5, sp, #0x10
_02176DF4:
	add r0, r10, r4, lsl #1
	ldrh r1, [r0, #0x70]
	ldrh r0, [r10, #0x10]
	cmp r1, r0
	bhs _02176E1C
	ldr r3, [r5, r4, lsl #2]
	mov r1, r7
	mov r2, r6
	add r0, r10, #0x26c
	bl TimeAttackLeaderboardsMenu__Func_217708C
_02176E1C:
	add r4, r4, #1
	cmp r4, #2
	blt _02176DF4
	ldr r1, [sp, #0x10]
	add r0, r10, #0x398
	str r1, [sp]
	mov r1, #0
	mov r2, #0x18
	mov r3, #0xaf
	str r9, [sp, #4]
	bl TimeAttackLeaderboardsMenu__Func_21770DC
	ldr r1, [sp, #0x10]
	add r0, r10, #0x254
	str r1, [sp]
	add r0, r0, #0x400
	mov r1, #0
	mov r2, #0x18
	mov r3, #8
	str r9, [sp, #4]
	bl TimeAttackLeaderboardsMenu__Func_21770DC
	ldr r1, [sp, #0x10]
	add r0, r10, #0x2b8
	str r1, [sp]
	add r0, r0, #0x400
	mov r1, #0
	mov r2, #0x18
	mov r3, #0x48
	str r9, [sp, #4]
	bl TimeAttackLeaderboardsMenu__Func_21770DC
	add r1, r10, #0x5f0
	add r0, r10, #0x18c
	str r1, [sp, #0x20]
	mov r1, #0
	add r0, r0, #0x400
	mov r2, r1
	str r0, [sp, #0x1c]
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0
	ldr r0, [sp, #0x20]
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r11, #0
	add r6, sp, #0x1c
	mov r5, #0x30
_02176ECC:
	mov r1, r11, lsl #1
	add r0, sp, #0x18
	ldrh r9, [r0, r1]
	ldr r0, _02177070 // =0x0000FFFF
	cmp r9, r0
	beq _02176F34
	add r0, sp, #0x10
	ldr r4, [r0, r11, lsl #2]
	mov r7, #0
	mov r8, #0x19
_02176EF4:
	mov r0, r7, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r9
	bl TimeAttackLeaderboardsMenu__Func_21786E0
	cmp r0, #2
	bhs _02176F24
	ldr r0, [r6, r0, lsl #2]
	mov r1, r5
	mov r2, r8, lsl #0x10
	mov r2, r2, asr #0x10
	mov r3, r4
	bl TimeAttackLeaderboardsMenu__Func_21770C4
_02176F24:
	add r7, r7, #1
	cmp r7, #3
	add r8, r8, #0x10
	blt _02176EF4
_02176F34:
	add r11, r11, #1
	cmp r11, #2
	blt _02176ECC
	add r0, r10, #0x18c
	add r3, r10, #0x5f0
	mov r1, #0
	add r0, r0, #0x400
	mov r2, r1
	str r3, [sp, #0x20]
	str r0, [sp, #0x1c]
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0
	ldr r0, [sp, #0x20]
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r11, #0
	add r6, sp, #0x1c
	mov r5, #0x30
_02176F7C:
	mov r1, r11, lsl #1
	add r0, sp, #0x18
	ldrh r8, [r0, r1]
	ldr r0, _02177070 // =0x0000FFFF
	cmp r8, r0
	beq _02176FE4
	add r0, sp, #0x10
	ldr r4, [r0, r11, lsl #2]
	mov r9, #0
	mov r7, #0x59
_02176FA4:
	mov r0, r9, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r8
	bl TimeAttackLeaderboardsMenu__Func_2178718
	cmp r0, #2
	bhs _02176FD4
	ldr r0, [r6, r0, lsl #2]
	mov r1, r5
	mov r2, r7, lsl #0x10
	mov r2, r2, asr #0x10
	mov r3, r4
	bl TimeAttackLeaderboardsMenu__Func_21770C4
_02176FD4:
	add r9, r9, #1
	cmp r9, #5
	add r7, r7, #0x10
	blt _02176FA4
_02176FE4:
	add r11, r11, #1
	cmp r11, #2
	blt _02176F7C
	add r8, r10, #0x31c
	mov r1, #0
	mov r3, #1
	mov r2, r1
	add r0, r8, #0x400
	strb r3, [r8, #0x457]
	bl AnimatorSprite__ProcessAnimation
	ldr r7, _02177070 // =0x0000FFFF
	mov r6, #0
	mov r4, #0x18
	add r9, sp, #0x10
	add r5, sp, #0x18
_02177020:
	mov r0, r6, lsl #1
	ldrh r0, [r5, r0]
	cmp r0, r7
	beq _0217705C
	bl TimeAttackLeaderboardsMenu__Func_2178750
	cmp r0, #5
	bhs _0217705C
	mov r0, r0, lsl #4
	add r0, r0, #0x58
	mov r2, r0, lsl #0x10
	ldr r3, [r9, r6, lsl #2]
	mov r1, r4
	add r0, r8, #0x400
	mov r2, r2, asr #0x10
	bl TimeAttackLeaderboardsMenu__Func_21770C4
_0217705C:
	add r6, r6, #1
	cmp r6, #2
	blt _02177020
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02177070: .word 0x0000FFFF
_02177074: .word 0x000001FF
_02177078: .word renderCoreGFXControlB
_0217707C: .word renderCoreGFXControlA
_02177080: .word 0x0217E2A8
_02177084: .word 0x0217E2D8
_02177088: .word 0x0217E308
	arm_func_end TimeAttackLeaderboardsMenu__Draw

	arm_func_start TimeAttackLeaderboardsMenu__Func_217708C
TimeAttackLeaderboardsMenu__Func_217708C: // 0x0217708C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r1
	mov r1, #0
	mov r5, r2
	mov r7, r0
	mov r4, r3
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl TimeAttackLeaderboardsMenu__Func_21770C4
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_217708C

	arm_func_start TimeAttackLeaderboardsMenu__Func_21770C4
TimeAttackLeaderboardsMenu__Func_21770C4: // 0x021770C4
	add r1, r1, r3
	strh r1, [r0, #8]
	ldr ip, _021770D8 // =AnimatorSprite__DrawFrame
	strh r2, [r0, #0xa]
	bx ip
	.align 2, 0
_021770D8: .word AnimatorSprite__DrawFrame
	arm_func_end TimeAttackLeaderboardsMenu__Func_21770C4

	arm_func_start TimeAttackLeaderboardsMenu__Func_21770DC
TimeAttackLeaderboardsMenu__Func_21770DC: // 0x021770DC
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r1
	mov r1, #0
	mov r5, r2
	mov r2, r1
	mov r7, r0
	mov r4, r3
	bl AnimatorSprite__ProcessAnimation
	cmp r6, #0
	moveq r6, r7
	beq _02177118
	mov r1, #0
	mov r0, r6
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
_02177118:
	ldr r1, [sp, #0x18]
	cmp r1, #0x100
	bge _02177144
	mvn r0, #0xff
	cmp r1, r0
	ble _02177144
	add r0, r5, r1
	strh r0, [r7, #8]
	mov r0, r7
	strh r4, [r7, #0xa]
	bl AnimatorSprite__DrawFrame
_02177144:
	ldr r1, [sp, #0x1c]
	cmp r1, #0x100
	ldmgeia sp!, {r3, r4, r5, r6, r7, pc}
	mvn r0, #0xff
	cmp r1, r0
	ldmleia sp!, {r3, r4, r5, r6, r7, pc}
	add r0, r5, r1
	strh r0, [r6, #8]
	mov r0, r6
	strh r4, [r6, #0xa]
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_21770DC

	arm_func_start TimeAttackLeaderboardsMenu__Func_2177174
TimeAttackLeaderboardsMenu__Func_2177174: // 0x02177174
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldrh ip, [r7, #0x70]
	ldrh r0, [r7, #0x10]
	mov r6, r1
	mov r5, r2
	mov r4, r3
	cmp ip, r0
	bhs _021771CC
	add r0, r7, ip, lsl #1
	ldrh r1, [r0, #0x12]
	ldrh r0, [r6, #0xc]
	ldrb r1, [r4, r1]
	cmp r0, r1
	beq _021771B8
	mov r0, r6
	bl AnimatorSprite__SetAnimation
_021771B8:
	ldrsh r1, [sp, #0x18]
	ldrsh r2, [sp, #0x1c]
	ldr r3, [sp, #0x20]
	mov r0, r6
	bl TimeAttackLeaderboardsMenu__Func_217708C
_021771CC:
	ldrh r1, [r7, #0x72]
	ldrh r0, [r7, #0x10]
	cmp r1, r0
	ldmhsia sp!, {r3, r4, r5, r6, r7, pc}
	add r0, r7, r1, lsl #1
	ldrh r1, [r0, #0x12]
	ldrh r0, [r5, #0xc]
	ldrb r1, [r4, r1]
	cmp r0, r1
	beq _021771FC
	mov r0, r5
	bl AnimatorSprite__SetAnimation
_021771FC:
	ldrsh r1, [sp, #0x18]
	ldrsh r2, [sp, #0x1c]
	ldr r3, [sp, #0x24]
	mov r0, r5
	bl TimeAttackLeaderboardsMenu__Func_217708C
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_2177174

	arm_func_start TimeAttackLeaderboardsMenu__Func_2177214
TimeAttackLeaderboardsMenu__Func_2177214: // 0x02177214
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x30
	mov r4, #0x30
	mul r4, r1, r4
	add r1, r0, #0x6c
	ldr r7, [r0, #0x868]
	add r6, r1, #0x800
	mov r0, r4
	add r0, r6, r0
	str r4, [sp, #0x1c]
	mov r5, r2
	mov r10, r3
	bl Unknown2056570__Func_205683C
	mov r0, r4
	add r0, r6, r0
	bl Unknown2056570__Func_2056834
	mov r8, r0
	cmp r5, #0
	bne _02177280
	mov r0, #0x2d
	bl GetFontCharacterFromUTF
	mov r0, r0, lsl #0x10
	add r1, sp, #0x20
	mov r0, r0, lsr #0x10
	mov r2, #0x10
	bl MIi_CpuClear16
	b _021772B0
_02177280:
	cmp r10, #0
	mov r4, #0
	ble _021772B0
	add r9, sp, #0x20
_02177290:
	mov r0, r4, lsl #1
	ldrh r0, [r5, r0]
	bl GetFontCharacterFromUTF
	mov r1, r4, lsl #1
	add r4, r4, #1
	strh r0, [r9, r1]
	cmp r4, r10
	blt _02177290
_021772B0:
	cmp r10, #0
	mov r0, #4
	mov r9, #0
	ble _0217730C
	mov r5, #0xe
	mov r11, #2
	mov r4, r9
_021772CC:
	stmia sp, {r5, r11}
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	str r4, [sp, #0x10]
	str r4, [sp, #0x14]
	str r4, [sp, #0x18]
	mov r1, r9, lsl #1
	add r0, sp, #0x20
	ldrh r1, [r0, r1]
	mov r0, r7
	mov r2, r4
	mov r3, r8
	bl FontFile__Func_2052B7C
	add r9, r9, #1
	cmp r9, r10
	blt _021772CC
_0217730C:
	ldr r0, [sp, #0x1c]
	add r0, r6, r0
	bl Unknown2056570__Func_2056B8C
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_2177214

	arm_func_start TimeAttackLeaderboardsMenu__Func_2177320
TimeAttackLeaderboardsMenu__Func_2177320: // 0x02177320
	stmdb sp!, {r3, r4, r5, lr}
	mov r2, #0x30
	mul r4, r1, r2
	add r0, r0, #0x6c
	add r5, r0, #0x800
	add r0, r5, r4
	bl Unknown2056570__Func_205683C
	add r0, r5, r4
	bl Unknown2056570__Func_2056B8C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_2177320

	arm_func_start TimeAttackLeaderboardsMenu__Func_2177348
TimeAttackLeaderboardsMenu__Func_2177348: // 0x02177348
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x30
	mov r5, r0
	ldr r0, [r5, #0]
	mov r6, r1
	ldr r0, [r0, #8]
	mov r1, #0xb
	mov r4, r2
	bl FileUnknown__GetAOUFile
	bl GetBackgroundPixels
	mov r2, #0x30
	add r1, r5, #0xcc
	mul r5, r6, r2
	add r6, r1, #0x800
	mov r7, r0
	add r0, r6, r5
	bl Unknown2056570__Func_205683C
	add r0, r6, r5
	bl Unknown2056570__Func_2056834
	ldr r1, _021774D8 // =0x0000FFFF
	mov r8, r0
	cmp r4, r1
	bne _021773D0
	mov r2, #0xc
	mov r1, #0xa
	mov r0, #0xb
	strh r2, [sp, #0x22]
	strh r1, [sp, #0x24]
	strh r2, [sp, #0x26]
	strh r2, [sp, #0x28]
	strh r0, [sp, #0x2a]
	strh r2, [sp, #0x2c]
	strh r2, [sp, #0x2e]
	b _02177458
_021773D0:
	add r1, sp, #0x20
	add r2, sp, #0x1e
	add r3, sp, #0x1c
	mov r0, r4
	bl AkUtilFrameToTime
	ldrh r3, [sp, #0x1e]
	ldr r0, _021774DC // =0x66666667
	mov r4, #0xa
	smull r9, r10, r0, r3
	mov r2, r3, lsr #0x1f
	add r10, r2, r10, asr #2
	strh r10, [sp, #0x26]
	ldrh r10, [sp, #0x26]
	ldrh r1, [sp, #0x1c]
	strh r4, [sp, #0x24]
	mul r11, r10, r4
	sub r3, r3, r11
	ldrh r9, [sp, #0x20]
	strh r3, [sp, #0x1e]
	ldrh r3, [sp, #0x1e]
	mov r2, #0xb
	mov r10, r1, lsr #0x1f
	smull r11, ip, r0, r1
	add ip, r10, ip, asr #2
	strh ip, [sp, #0x2c]
	ldrh r0, [sp, #0x2c]
	strh r9, [sp, #0x22]
	strh r3, [sp, #0x28]
	mul r4, r0, r4
	sub r0, r1, r4
	strh r0, [sp, #0x1c]
	ldrh r0, [sp, #0x1c]
	strh r2, [sp, #0x2a]
	strh r0, [sp, #0x2e]
_02177458:
	mov r9, #0
	mov r10, r9
	mov r4, #8
	mov r11, #0xe
_02177468:
	mov r1, r10, lsl #1
	add r0, sp, #0x22
	ldrh r0, [r0, r1]
	stmia sp, {r4, r11}
	mov r0, r0, lsl #0x13
	mov r2, r0, lsr #0x10
	str r8, [sp, #8]
	mov r0, #7
	str r0, [sp, #0xc]
	str r9, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0
	str r0, [sp, #0x18]
	add r0, r7, #4
	mov r1, #0xd
	mov r3, #0
	bl BackgroundUnknown__CopyPixels
	add r0, r9, #8
	mov r0, r0, lsl #0x10
	add r10, r10, #1
	mov r9, r0, lsr #0x10
	cmp r10, #7
	blt _02177468
	add r0, r6, r5
	bl Unknown2056570__Func_2056B8C
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021774D8: .word 0x0000FFFF
_021774DC: .word 0x66666667
	arm_func_end TimeAttackLeaderboardsMenu__Func_2177348

	arm_func_start TimeAttackLeaderboardsMenu__Func_21774E0
TimeAttackLeaderboardsMenu__Func_21774E0: // 0x021774E0
	stmdb sp!, {r3, r4, r5, lr}
	mov r2, #0x30
	mul r4, r1, r2
	add r0, r0, #0xcc
	add r5, r0, #0x800
	add r0, r5, r4
	bl Unknown2056570__Func_205683C
	add r0, r5, r4
	bl Unknown2056570__Func_2056B8C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_21774E0

	arm_func_start TimeAttackLeaderboardsMenu__Func_2177508
TimeAttackLeaderboardsMenu__Func_2177508: // 0x02177508
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2c
	mov r5, r0
	ldr r0, [r5, #0]
	mov r6, r1
	ldr r3, _02177704 // =0x0098967F
	mov r4, r2
	cmp r4, r3
	ldr r0, [r0, #8]
	mov r1, #0xb
	movhi r4, r3
	bl FileUnknown__GetAOUFile
	bl GetBackgroundPixels
	mov r2, #0x30
	add r1, r5, #0x12c
	mul r5, r6, r2
	add r6, r1, #0x800
	mov r7, r0
	add r0, r6, r5
	bl Unknown2056570__Func_205683C
	add r0, r6, r5
	bl Unknown2056570__Func_2056834
	mov r8, r0
	cmp r4, #0
	beq _0217763C
	ldr r0, _02177708 // =0x431BDE83
	ldr r1, _0217770C // =0x000F4240
	umull r0, r2, r4, r0
	mov r2, r2, lsr #0x12
	strh r2, [sp, #0x1c]
	ldrh r0, [sp, #0x1c]
	ldr r2, _02177710 // =0x4F8B588F
	ldr r3, _02177714 // =0x000186A0
	mul r1, r0, r1
	sub r0, r4, r1
	umull r1, r2, r0, r2
	sub r1, r0, r2
	add r2, r2, r1, lsr #1
	mov r2, r2, lsr #0x10
	strh r2, [sp, #0x1e]
	ldrh r4, [sp, #0x1e]
	ldr r1, _02177718 // =0xD1B71759
	ldr r2, _0217771C // =0x00002710
	mul r3, r4, r3
	sub r4, r0, r3
	umull r0, r1, r4, r1
	mov r1, r1, lsr #0xd
	strh r1, [sp, #0x20]
	ldrh r3, [sp, #0x20]
	ldr r0, _02177720 // =0x10624DD3
	mov r1, #0x3e8
	mul r2, r3, r2
	sub r4, r4, r2
	umull r0, r2, r4, r0
	mov r2, r2, lsr #6
	strh r2, [sp, #0x22]
	ldrh r3, [sp, #0x22]
	ldr r0, _02177724 // =0x51EB851F
	mov r2, #0x64
	mul r1, r3, r1
	sub r4, r4, r1
	umull r0, r1, r4, r0
	mov r1, r1, lsr #5
	strh r1, [sp, #0x24]
	ldrh r3, [sp, #0x24]
	ldr r0, _02177728 // =0xCCCCCCCD
	mov r1, #0xa
	mul r2, r3, r2
	sub r3, r4, r2
	umull r0, r2, r3, r0
	mov r2, r2, lsr #3
	strh r2, [sp, #0x26]
	ldrh r0, [sp, #0x26]
	mul r1, r0, r1
	sub r0, r3, r1
	strh r0, [sp, #0x28]
	b _0217764C
_0217763C:
	add r1, sp, #0x1c
	mov r0, #0xc
	mov r2, #0xe
	bl MIi_CpuClear16
_0217764C:
	ldr r0, _0217772C // =0x0000FFFF
	mov r4, #0
	add r2, sp, #0x1c
_02177658:
	mov r3, r4, lsl #1
	ldrh r1, [r2, r3]
	cmp r1, #0
	bne _02177678
	add r4, r4, #1
	strh r0, [r2, r3]
	cmp r4, #6
	blt _02177658
_02177678:
	mov r9, #0
	mov r10, r9
	mov r11, #8
	add r4, sp, #0x1c
_02177688:
	mov r0, r10, lsl #1
	ldrh r1, [r4, r0]
	ldr r0, _0217772C // =0x0000FFFF
	cmp r1, r0
	beq _021776DC
	mov r0, r1, lsl #0x13
	mov r2, r0, lsr #0x10
	str r11, [sp]
	mov r0, #0xe
	stmib sp, {r0, r8}
	mov r0, #7
	str r0, [sp, #0xc]
	str r9, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r0, #0
	str r0, [sp, #0x18]
	add r0, r7, #4
	mov r1, #0xd
	mov r3, #0
	bl BackgroundUnknown__CopyPixels
_021776DC:
	add r0, r9, #8
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	add r10, r10, #1
	cmp r10, #7
	blt _02177688
	add r0, r6, r5
	bl Unknown2056570__Func_2056B8C
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02177704: .word 0x0098967F
_02177708: .word 0x431BDE83
_0217770C: .word 0x000F4240
_02177710: .word 0x4F8B588F
_02177714: .word 0x000186A0
_02177718: .word 0xD1B71759
_0217771C: .word 0x00002710
_02177720: .word 0x10624DD3
_02177724: .word 0x51EB851F
_02177728: .word 0xCCCCCCCD
_0217772C: .word 0x0000FFFF
	arm_func_end TimeAttackLeaderboardsMenu__Func_2177508

	arm_func_start TimeAttackLeaderboardsMenu__Func_2177730
TimeAttackLeaderboardsMenu__Func_2177730: // 0x02177730
	stmdb sp!, {r3, r4, r5, lr}
	mov r2, #0x30
	mul r4, r1, r2
	add r0, r0, #0x12c
	add r5, r0, #0x800
	add r0, r5, r4
	bl Unknown2056570__Func_205683C
	add r0, r5, r4
	bl Unknown2056570__Func_2056B8C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_2177730

	arm_func_start TimeAttackLeaderboardsMenu__Func_2177758
TimeAttackLeaderboardsMenu__Func_2177758: // 0x02177758
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x38
	mov r4, r0
	ldr r0, [r4, #0]
	mov r5, r1
	ldr r0, [r0, #8]
	mov r1, #0xc
	mov r9, r2
	mov r8, r3
	bl FileUnknown__GetAOUFile
	bl GetBackgroundPixels
	mov r2, #0x30
	add r1, r4, #0x18c
	mul r4, r5, r2
	add r5, r1, #0x800
	mov r6, r0
	add r0, r5, r4
	bl Unknown2056570__Func_205683C
	add r0, r5, r4
	bl Unknown2056570__Func_2056834
	subs r1, r9, #0
	mov r7, r0
	sbcs r1, r8, #0
	blt _02177900
	add r0, sp, #0x18
	add r1, sp, #0xc
	mov r2, r9
	mov r3, r8
	bl RTC_ConvertSecondToDateTime
	ldr r8, [sp, #0x18]
	ldr r0, _02177B7C // =0x10624DD3
	mov r2, #0x3e8
	umull r0, r3, r8, r0
	mov r3, r3, lsr #6
	and r1, r3, #0xff
	smulbb r0, r1, r2
	ldr r2, _02177B80 // =0x51EB851F
	sub r0, r8, r0
	umull r8, r2, r0, r2
	mov r2, r2, lsr #5
	and r9, r2, #0xff
	mov r8, #0x64
	smulbb r9, r9, r8
	ldr r10, _02177B84 // =0xCCCCCCCD
	sub r0, r0, r9
	strb r2, [sp, #9]
	umull r9, r2, r0, r10
	mov r2, r2, lsr #3
	strb r2, [sp, #0xa]
	and r9, r2, #0xff
	mov r2, #0xa
	smulbb r9, r9, r2
	sub r9, r0, r9
	and r0, r9, #0xff
	sub r0, r9, r0
	ldr r8, [sp, #0x1c]
	strb r9, [sp, #0xb]
	str r0, [sp, #0x18]
	umull r9, r0, r8, r10
	mov r0, r0, lsr #3
	strb r0, [sp, #6]
	and r0, r0, #0xff
	smulbb r0, r0, r2
	sub r8, r8, r0
	and r0, r8, #0xff
	sub r0, r8, r0
	strb r3, [sp, #8]
	ldr lr, [sp, #0x20]
	strb r8, [sp, #7]
	str r0, [sp, #0x1c]
	umull r0, r8, lr, r10
	mov r8, r8, lsr #3
	and r0, r8, #0xff
	smulbb r0, r0, r2
	strb r8, [sp, #4]
	sub r8, lr, r0
	and r0, r8, #0xff
	sub r0, r8, r0
	ldr ip, [sp, #0xc]
	strb r8, [sp, #5]
	str r0, [sp, #0x20]
	umull r8, r0, ip, r10
	ldr r3, [sp, #0x10]
	mov r0, r0, lsr #3
	umull r8, r9, r3, r10
	strb r0, [sp, #2]
	and r0, r0, #0xff
	smulbb r0, r0, r2
	sub r8, ip, r0
	and r0, r8, #0xff
	sub r0, r8, r0
	mov r9, r9, lsr #3
	str r0, [sp, #0xc]
	and r0, r9, #0xff
	smulbb r0, r0, r2
	sub r2, r3, r0
	and r0, r2, #0xff
	str r2, [sp, #0x10]
	strb r2, [sp, #1]
	sub r2, r2, r0
	add r0, r1, #2
	strb r8, [sp, #3]
	strb r9, [sp]
	str r2, [sp, #0x10]
	strb r0, [sp, #8]
	b _02177950
_02177900:
	add r0, sp, #8
	mov r1, #0xa
	mov r2, #4
	bl MI_CpuFill8
	add r0, sp, #6
	mov r1, #0xa
	mov r2, #2
	bl MI_CpuFill8
	add r0, sp, #4
	mov r1, #0xa
	mov r2, #2
	bl MI_CpuFill8
	add r0, sp, #2
	mov r1, #0xa
	mov r2, #2
	bl MI_CpuFill8
	add r0, sp, #0
	mov r1, #0xa
	mov r2, #2
	bl MI_CpuFill8
_02177950:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02177988
_02177964: // jump table
	b _0217797C // case 0
	b _0217797C // case 1
	b _0217797C // case 2
	b _0217797C // case 3
	b _0217797C // case 4
	b _0217797C // case 5
_0217797C:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _0217798C
_02177988:
	mov r0, #1
_0217798C:
	cmp r0, #0
	bne _02177A08
	add r0, sp, #8
	add r1, sp, #0x28
	mov r2, #4
	bl MI_CpuCopy8
	mov r3, #0xb
	add r0, sp, #6
	add r1, sp, #0x2d
	mov r2, #2
	strb r3, [sp, #0x2c]
	bl MI_CpuCopy8
	mov r3, #0xb
	add r0, sp, #4
	add r1, sp, #0x30
	mov r2, #2
	strb r3, [sp, #0x2f]
	bl MI_CpuCopy8
	mov r0, #0xff
	strb r0, [sp, #0x32]
	add r0, sp, #2
	add r1, sp, #0x33
	mov r2, #2
	bl MI_CpuCopy8
	mov r0, #0xc
	strb r0, [sp, #0x35]
	add r0, sp, #0
	add r1, sp, #0x36
	mov r2, #2
	bl MI_CpuCopy8
	b _02177B28
_02177A08:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02177A40
_02177A1C: // jump table
	b _02177A34 // case 0
	b _02177A34 // case 1
	b _02177A34 // case 2
	b _02177A34 // case 3
	b _02177A34 // case 4
	b _02177A34 // case 5
_02177A34:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	b _02177A44
_02177A40:
	mov r0, #1
_02177A44:
	cmp r0, #1
	add r1, sp, #0x28
	mov r2, #2
	bne _02177AC0
	add r0, sp, #6
	bl MI_CpuCopy8
	mov r3, #0xb
	add r0, sp, #4
	add r1, sp, #0x2b
	mov r2, #2
	strb r3, [sp, #0x2a]
	bl MI_CpuCopy8
	mov r3, #0xb
	add r0, sp, #8
	add r1, sp, #0x2e
	mov r2, #4
	strb r3, [sp, #0x2d]
	bl MI_CpuCopy8
	mov r0, #0xff
	strb r0, [sp, #0x32]
	add r0, sp, #2
	add r1, sp, #0x33
	mov r2, #2
	bl MI_CpuCopy8
	mov r0, #0xc
	strb r0, [sp, #0x35]
	add r0, sp, #0
	add r1, sp, #0x36
	mov r2, #2
	bl MI_CpuCopy8
	b _02177B28
_02177AC0:
	add r0, sp, #4
	bl MI_CpuCopy8
	mov r3, #0xb
	add r0, sp, #6
	add r1, sp, #0x2b
	mov r2, #2
	strb r3, [sp, #0x2a]
	bl MI_CpuCopy8
	mov r3, #0xb
	add r0, sp, #8
	add r1, sp, #0x2e
	mov r2, #4
	strb r3, [sp, #0x2d]
	bl MI_CpuCopy8
	mov r0, #0xff
	strb r0, [sp, #0x32]
	add r0, sp, #2
	add r1, sp, #0x33
	mov r2, #2
	bl MI_CpuCopy8
	mov r0, #0xc
	strb r0, [sp, #0x35]
	add r0, sp, #0
	add r1, sp, #0x36
	mov r2, #2
	bl MI_CpuCopy8
_02177B28:
	mov r10, #0
	add r9, sp, #0x28
	mov r8, r10
_02177B34:
	ldrb r1, [r9, #0]
	cmp r1, #0xff
	beq _02177B50
	mov r2, r7
	mov r3, r10
	add r0, r6, #4
	bl TimeAttackLeaderboardsMenu__Func_2177B88
_02177B50:
	add r0, r10, #5
	mov r0, r0, lsl #0x10
	add r8, r8, #1
	cmp r8, #0x10
	mov r10, r0, lsr #0x10
	add r9, r9, #1
	blt _02177B34
	add r0, r5, r4
	bl Unknown2056570__Func_2056B8C
	add sp, sp, #0x38
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02177B7C: .word 0x10624DD3
_02177B80: .word 0x51EB851F
_02177B84: .word 0xCCCCCCCD
	arm_func_end TimeAttackLeaderboardsMenu__Func_2177758

	arm_func_start TimeAttackLeaderboardsMenu__Func_2177B88
TimeAttackLeaderboardsMenu__Func_2177B88: // 0x02177B88
	stmdb sp!, {lr}
	sub sp, sp, #0x1c
	mov ip, #6
	str ip, [sp]
	mov ip, #8
	str ip, [sp, #4]
	str r2, [sp, #8]
	mov r2, #0xb
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	mov r2, #7
	mov r1, r1, lsl #0x13
	str r2, [sp, #0x14]
	mov r3, #0
	mov r2, r1, lsr #0x10
	mov r1, #0xd
	str r3, [sp, #0x18]
	bl BackgroundUnknown__CopyPixels
	add sp, sp, #0x1c
	ldmia sp!, {pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_2177B88

	arm_func_start TimeAttackLeaderboardsMenu__Func_2177BD8
TimeAttackLeaderboardsMenu__Func_2177BD8: // 0x02177BD8
	stmdb sp!, {r3, r4, r5, lr}
	mov r2, #0x30
	mul r4, r1, r2
	add r0, r0, #0x18c
	add r5, r0, #0x800
	add r0, r5, r4
	bl Unknown2056570__Func_205683C
	add r0, r5, r4
	bl Unknown2056570__Func_2056B8C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_2177BD8

	arm_func_start TimeAttackLeaderboardsMenu__Func_2177C00
TimeAttackLeaderboardsMenu__Func_2177C00: // 0x02177C00
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x38
	mov r10, r3
	cmp r2, #3
	ldr r7, [r0, #0x868]
	bhs _02177C38
	add r0, r0, #0x1ec
	add r3, r0, #0x800
	mov r0, #0x90
	mla r3, r1, r0, r3
	mov r0, #0x30
	mla r0, r2, r0, r3
	str r0, [sp, #0x1c]
	b _02177C58
_02177C38:
	add r0, r0, #0x30c
	add r3, r0, #0x800
	mov r0, #0xf0
	mla r3, r1, r0, r3
	sub r1, r2, #3
	mov r0, #0x30
	mla r0, r1, r0, r3
	str r0, [sp, #0x1c]
_02177C58:
	ldr r0, [sp, #0x1c]
	bl Unknown2056570__Func_205683C
	ldr r0, [sp, #0x1c]
	bl Unknown2056570__Func_2056834
	mov r9, r0
	mov r0, #0x30
	bl GetFontCharacterFromUTF
	mov r4, r0, lsl #0x10
	mov r0, #0x2d
	bl GetFontCharacterFromUTF
	mov r1, r0, lsl #0x10
	ldrh r0, [sp, #0x64]
	ldr r2, _02177E94 // =0x0000FFFF
	mov r1, r1, lsr #0x10
	cmp r0, r2
	beq _02177D30
	add r1, sp, #0x24
	add r2, sp, #0x22
	add r3, sp, #0x20
	bl AkUtilFrameToTime
	ldrh r6, [sp, #0x22]
	ldr r3, _02177E98 // =0x66666667
	ldrh r8, [sp, #0x24]
	smull r2, r5, r3, r6
	mov r1, r6, lsr #0x1f
	add r5, r1, r5, asr #2
	strh r5, [sp, #0x2a]
	ldrh r2, [sp, #0x2a]
	mov r5, #0xa
	ldrh r0, [sp, #0x20]
	mul r1, r2, r5
	add r11, r8, r4, lsr #16
	add r8, r2, r4, lsr #16
	sub r1, r6, r1
	strh r1, [sp, #0x22]
	ldrh r1, [sp, #0x22]
	smull r2, ip, r3, r0
	add r6, r1, r4, lsr #16
	mov r1, r0, lsr #0x1f
	add ip, r1, ip, asr #2
	strh ip, [sp, #0x30]
	ldrh r1, [sp, #0x30]
	strh r11, [sp, #0x26]
	strh r8, [sp, #0x2a]
	mul r2, r1, r5
	sub r0, r0, r2
	strh r0, [sp, #0x20]
	ldrh r0, [sp, #0x20]
	add r1, r1, r4, lsr #16
	strh r6, [sp, #0x2c]
	add r0, r0, r4, lsr #16
	strh r1, [sp, #0x30]
	strh r0, [sp, #0x32]
	b _02177D44
_02177D30:
	strh r1, [sp, #0x26]
	strh r1, [sp, #0x2a]
	strh r1, [sp, #0x2c]
	strh r1, [sp, #0x30]
	strh r1, [sp, #0x32]
_02177D44:
	mov r0, #0x27
	bl GetFontCharacterFromUTF
	strh r0, [sp, #0x28]
	mov r0, #0x22
	bl GetFontCharacterFromUTF
	mov r8, #0
	strh r0, [sp, #0x2e]
	mov r0, #4
	mov r6, #0x15
	mov r5, #2
	mov r4, r8
	add r11, sp, #0x26
_02177D74:
	str r6, [sp]
	str r5, [sp, #4]
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	str r4, [sp, #0x10]
	str r4, [sp, #0x14]
	str r4, [sp, #0x18]
	mov r0, r8, lsl #1
	ldrh r1, [r11, r0]
	mov r0, r7
	mov r2, r4
	mov r3, r9
	bl FontFile__Func_2052B7C
	add r8, r8, #1
	cmp r8, #7
	blt _02177D74
	ldrh r1, [sp, #0x64]
	ldr r0, _02177E94 // =0x0000FFFF
	cmp r1, r0
	bne _02177DEC
	mov r0, #0x2d
	bl GetFontCharacterFromUTF
	mov r0, r0, lsl #0x10
	add r1, sp, #0x26
	mov r0, r0, lsr #0x10
	mov r2, #0x10
	bl MIi_CpuClear16
	mov r0, #8
	strh r0, [sp, #0x60]
	b _02177E20
_02177DEC:
	ldrh r4, [sp, #0x60]
	mov r5, #0
	cmp r4, #0
	ble _02177E20
	add r6, sp, #0x26
_02177E00:
	mov r0, r5, lsl #1
	ldrh r0, [r10, r0]
	bl GetFontCharacterFromUTF
	mov r1, r5, lsl #1
	add r5, r5, #1
	strh r0, [r6, r1]
	cmp r5, r4
	blt _02177E00
_02177E20:
	ldrh r8, [sp, #0x60]
	mov r0, #0x3c
	mov r10, #0
	cmp r8, #0
	ble _02177E84
	mov r6, #0x15
	mov r5, #2
	mov r4, r10
	add r11, sp, #0x26
_02177E44:
	str r6, [sp]
	str r5, [sp, #4]
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	str r4, [sp, #0x10]
	str r4, [sp, #0x14]
	str r4, [sp, #0x18]
	mov r0, r10, lsl #1
	ldrh r1, [r11, r0]
	mov r0, r7
	mov r2, r4
	mov r3, r9
	bl FontFile__Func_2052B7C
	add r10, r10, #1
	cmp r10, r8
	blt _02177E44
_02177E84:
	ldr r0, [sp, #0x1c]
	bl Unknown2056570__Func_2056B8C
	add sp, sp, #0x38
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02177E94: .word 0x0000FFFF
_02177E98: .word 0x66666667
	arm_func_end TimeAttackLeaderboardsMenu__Func_2177C00

	arm_func_start TimeAttackLeaderboardsMenu__Func_2177E9C
TimeAttackLeaderboardsMenu__Func_2177E9C: // 0x02177E9C
	stmdb sp!, {r3, r4, r5, lr}
	cmp r2, #3
	bhs _02177ED4
	add r0, r0, #0x1ec
	add r4, r0, #0x800
	mov r0, #0x90
	mov r3, #0x30
	mla r5, r1, r0, r4
	mul r4, r2, r3
	add r0, r5, r4
	bl Unknown2056570__Func_205683C
	add r0, r5, r4
	bl Unknown2056570__Func_2056B8C
	ldmia sp!, {r3, r4, r5, pc}
_02177ED4:
	add r0, r0, #0x30c
	add r4, r0, #0x800
	mov r0, #0xf0
	sub r3, r2, #3
	mov r2, #0x30
	mla r5, r1, r0, r4
	mul r4, r3, r2
	add r0, r5, r4
	bl Unknown2056570__Func_205683C
	add r0, r5, r4
	bl Unknown2056570__Func_2056B8C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_2177E9C

	arm_func_start TimeAttackLeaderboardsMenu__Func_2177F04
TimeAttackLeaderboardsMenu__Func_2177F04: // 0x02177F04
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x20
	mov r6, r3
	cmp r6, #2
	mov r7, r2
	movhs r6, #2
	mov r5, r0
	mov r4, r1
	cmp r7, #0x2e
	blo _02177F88
	mov r1, #0
	cmp r4, #0
	moveq r2, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	movne r2, #0x20
	mov r0, r2, lsl #0x10
	str r1, [sp, #8]
	mov r2, #8
	str r2, [sp, #0xc]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r3, #0x20
	str r3, [sp, #0x18]
	mov r0, #0x18
	str r0, [sp, #0x1c]
	ldr r0, [r5, #0xd4c]
	mov r2, r1
	bl Mappings__LoadUnknown
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02177F88:
	cmp r4, #0
	moveq r1, #0
	movne r1, #0x20
	add r2, r1, #0x5000000
	add r0, r5, #0x780
	mov r1, #0
	bl SetPaletteAnimationTarget
	ldr r1, _02178048 // =0x0217E278
	add r0, r5, #0x780
	ldrb r1, [r1, r7]
	bl SetPaletteAnimation
	add r0, r5, #0x780
	bl AnimatePalette
	add r0, r5, #0x780
	bl DrawAnimatedPalette
	add r0, r6, #0xa
	mov r1, r0, lsl #0x10
	add r0, r5, #0x780
	mov r1, r1, lsr #0x10
	bl SetPaletteAnimation
	add r0, r5, #0x780
	bl AnimatePalette
	add r0, r5, #0x780
	bl DrawAnimatedPalette
	mov r1, #0
	cmp r4, #0
	moveq r2, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	movne r2, #0x20
	mov r0, r2, lsl #0x10
	str r1, [sp, #8]
	mov r2, #8
	str r2, [sp, #0xc]
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r3, #0x20
	str r3, [sp, #0x18]
	mov r0, #0x18
	str r0, [sp, #0x1c]
	add r0, r5, r4, lsl #2
	ldr r0, [r0, #0xd50]
	mov r2, r1
	bl Mappings__LoadUnknown
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02178048: .word 0x0217E278
	arm_func_end TimeAttackLeaderboardsMenu__Func_2177F04

	arm_func_start TimeAttackLeaderboardsMenu__Func_217804C
TimeAttackLeaderboardsMenu__Func_217804C: // 0x0217804C
	stmdb sp!, {r3, lr}
	sub sp, sp, #0x20
	cmp r2, #0
	beq _021780BC
	mov r2, #0
	cmp r1, #0
	moveq ip, #0
	str r2, [sp]
	mov r3, #0xd
	str r3, [sp, #4]
	movne ip, #0x20
	mov r3, ip, lsl #0x10
	add r0, r0, r1, lsl #2
	str r2, [sp, #8]
	mov ip, #8
	str ip, [sp, #0xc]
	mov r3, r3, lsr #0x10
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	mov r3, #0x20
	str r3, [sp, #0x18]
	mov r1, #0x18
	str r1, [sp, #0x1c]
	ldr r0, [r0, #0xd58]
	mov r1, r2
	bl Mappings__LoadUnknown
	add sp, sp, #0x20
	ldmia sp!, {r3, pc}
_021780BC:
	cmp r1, #0
	mov r1, #0
	moveq r3, #0
	str r1, [sp]
	mov r2, #0xd
	str r2, [sp, #4]
	movne r3, #0x20
	mov r2, r3, lsl #0x10
	str r1, [sp, #8]
	mov r3, #8
	str r3, [sp, #0xc]
	mov r2, r2, lsr #0x10
	str r2, [sp, #0x10]
	str r1, [sp, #0x14]
	mov r3, #0x20
	str r3, [sp, #0x18]
	mov r2, #0x18
	str r2, [sp, #0x1c]
	ldr r0, [r0, #0xd4c]
	mov r2, r1
	bl Mappings__LoadUnknown
	add sp, sp, #0x20
	ldmia sp!, {r3, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_217804C

	arm_func_start TimeAttackLeaderboardsMenu__Func_2178118
TimeAttackLeaderboardsMenu__Func_2178118: // 0x02178118
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x7a0]
	cmp r0, r1
	ldmeqia sp!, {r4, pc}
	str r1, [r4, #0x7a0]
	cmp r1, #0
	beq _02178178
	ldr r1, [r4, #0x7bc]
	add r0, r4, #0x3a8
	bic r1, r1, #0x40
	str r1, [r4, #0x7bc]
	ldr r1, [r4, #0x7f4]
	add r0, r0, #0x400
	bic r1, r1, #0x40
	str r1, [r4, #0x7f4]
	bl TouchField__ResetArea
	add r0, r4, #0x7e0
	bl TouchField__ResetArea
	add r0, r4, #0xc4
	add r0, r0, #0x400
	mov r1, #0x25
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, pc}
_02178178:
	add r0, r4, #0x3a8
	add r0, r0, #0x400
	bl TouchField__ResetArea
	add r0, r4, #0x7e0
	bl TouchField__ResetArea
	ldr r0, [r4, #0x7bc]
	orr r0, r0, #0x40
	str r0, [r4, #0x7bc]
	ldr r0, [r4, #0x7f4]
	orr r0, r0, #0x40
	str r0, [r4, #0x7f4]
	ldmia sp!, {r4, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_2178118

	arm_func_start TimeAttackLeaderboardsMenu__Func_21781A8
TimeAttackLeaderboardsMenu__Func_21781A8: // 0x021781A8
	ldr r1, [r0, #0x7a0]
	cmp r1, #0
	moveq r0, #0
	bxeq lr
	ldr r0, [r0, #0x7bc]
	tst r0, #0x400000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end TimeAttackLeaderboardsMenu__Func_21781A8

	arm_func_start TimeAttackLeaderboardsMenu__Func_21781CC
TimeAttackLeaderboardsMenu__Func_21781CC: // 0x021781CC
	ldr r1, [r0, #0x7a0]
	cmp r1, #0
	moveq r0, #0
	bxeq lr
	ldr r0, [r0, #0x7f4]
	tst r0, #0x400000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end TimeAttackLeaderboardsMenu__Func_21781CC

	arm_func_start TimeAttackLeaderboardsMenu__Func_21781F0
TimeAttackLeaderboardsMenu__Func_21781F0: // 0x021781F0
	stmdb sp!, {r4, lr}
	ldr r1, [r0, #0x7a0]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	add r0, r0, #0xc4
	add r4, r0, #0x400
	ldr r0, [r4, #0x3c]
	mov r1, #0
	orr r3, r0, #4
	mov r0, r4
	mov r2, r1
	str r3, [r4, #0x3c]
	bl AnimatorSprite__ProcessAnimation
	ldr r1, [r4, #0x3c]
	mov r0, #0x10
	bic r1, r1, #0x80
	str r1, [r4, #0x3c]
	strh r0, [r4, #8]
	mov r1, #0x60
	mov r0, r4
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
	ldr r0, [r4, #0x3c]
	mov r1, #0xf0
	orr r0, r0, #0x80
	str r0, [r4, #0x3c]
	mov r0, r4
	strh r1, [r4, #8]
	mov r1, #0x60
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_21781F0

	arm_func_start TimeAttackLeaderboardsMenu__Func_2178270
TimeAttackLeaderboardsMenu__Func_2178270: // 0x02178270
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x7a4]
	cmp r0, r1
	ldmeqia sp!, {r4, pc}
	str r1, [r4, #0x7a4]
	cmp r1, #0
	beq _021782AC
	ldr r1, [r4, #0x82c]
	add r0, r4, #0x18
	bic r1, r1, #0x40
	add r0, r0, #0x800
	str r1, [r4, #0x82c]
	bl TouchField__ResetArea
	ldmia sp!, {r4, pc}
_021782AC:
	add r0, r4, #0x18
	add r0, r0, #0x800
	bl TouchField__ResetArea
	ldr r0, [r4, #0x82c]
	orr r0, r0, #0x40
	str r0, [r4, #0x82c]
	ldmia sp!, {r4, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_2178270

	arm_func_start TimeAttackLeaderboardsMenu__Func_21782C8
TimeAttackLeaderboardsMenu__Func_21782C8: // 0x021782C8
	ldr r1, [r0, #0x7a4]
	cmp r1, #0
	moveq r0, #0
	bxeq lr
	ldr r0, [r0, #0x82c]
	tst r0, #0x40000
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end TimeAttackLeaderboardsMenu__Func_21782C8

	arm_func_start TimeAttackLeaderboardsMenu__Func_21782EC
TimeAttackLeaderboardsMenu__Func_21782EC: // 0x021782EC
	stmdb sp!, {r4, lr}
	ldr r1, [r0, #0x7a4]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r0, #0x82c]
	add r0, r0, #0x128
	tst r1, #0x800
	add r4, r0, #0x400
	bne _0217831C
	tst r1, #0x10
	movne r1, #0x1d
	bne _02178320
_0217831C:
	mov r1, #0x1c
_02178320:
	ldrh r0, [r4, #0xc]
	cmp r0, r1
	beq _02178334
	mov r0, r4
	bl AnimatorSprite__SetAnimation
_02178334:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0x40
	mov r0, r4
	strh r1, [r4, #8]
	mov r1, #0xa8
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_21782EC

	arm_func_start TimeAttackLeaderboardsMenu__Func_2178360
TimeAttackLeaderboardsMenu__Func_2178360: // 0x02178360
	stmdb sp!, {r3, lr}
	cmp r0, #0
	beq _0217837C
	ldr r0, _0217838C // =TimeAttackLeaderboardsMenu__Func_21783A8
	mov r1, #0
	bl TimeAttackMenu__Func_216C610
	ldmia sp!, {r3, pc}
_0217837C:
	mov r0, #0
	mov r1, r0
	bl TimeAttackMenu__Func_216C610
	ldmia sp!, {r3, pc}
	.align 2, 0
_0217838C: .word TimeAttackLeaderboardsMenu__Func_21783A8
	arm_func_end TimeAttackLeaderboardsMenu__Func_2178360

	arm_func_start TimeAttackLeaderboardsMenu__Func_2178390
TimeAttackLeaderboardsMenu__Func_2178390: // 0x02178390
	stmdb sp!, {r3, lr}
	bl TimeAttackMenu__Func_216C640
	tst r0, #0x40000
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_2178390

	arm_func_start TimeAttackLeaderboardsMenu__Func_21783A8
TimeAttackLeaderboardsMenu__Func_21783A8: // 0x021783A8
	bx lr
	arm_func_end TimeAttackLeaderboardsMenu__Func_21783A8

	arm_func_start TimeAttackLeaderboardsMenu__Func_21783AC
TimeAttackLeaderboardsMenu__Func_21783AC: // 0x021783AC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	ldr r0, [r8, #8]
	cmp r0, #0
	mov r0, #1
	beq _021783D8
	strh r0, [r8, #0x10]
	ldr r0, [r8, #0]
	ldrh r0, [r0, #6]
	strh r0, [r8, #0x12]
	b _021784C0
_021783D8:
	mov r6, #0
	strh r6, [r8, #0x12]
	strh r0, [r8, #0x14]
	mov r0, #3
	strh r0, [r8, #0x16]
	mov r0, #4
	strh r0, [r8, #0x18]
	mov r0, #6
	strh r0, [r8, #0x1a]
	mov r0, #7
	strh r0, [r8, #0x1c]
	mov r0, #9
	strh r0, [r8, #0x1e]
	mov r0, #0xa
	strh r0, [r8, #0x20]
	mov r0, #0xc
	strh r0, [r8, #0x22]
	mov r0, #0xd
	strh r0, [r8, #0x24]
	mov r0, #0xf
	strh r0, [r8, #0x26]
	mov r0, #0x10
	strh r0, [r8, #0x28]
	mov r0, #0x12
	strh r0, [r8, #0x2a]
	mov r0, #0x13
	strh r0, [r8, #0x2c]
	strh r6, [r8, #0x10]
	mov r7, #0xe
	mov r5, r6
	mov r4, #1
_02178454:
	add r0, r8, r6, lsl #1
	ldrh r0, [r0, #0x12]
	bl TimeAttackLeaderboardsMenu__Func_21787F0
	bl MenuHelpers__Func_217CEA8
	mov r1, r5
	mov r2, r4
	bl MenuHelpers__CheckProgress
	cmp r0, #0
	bne _021784A8
	add r2, r6, #1
	cmp r2, r7
	bge _0217849C
_02178484:
	add r1, r8, r2, lsl #1
	ldrh r0, [r1, #0x12]
	add r2, r2, #1
	cmp r2, r7
	strh r0, [r1, #0x10]
	blt _02178484
_0217849C:
	sub r7, r7, #1
	sub r6, r6, #1
	b _021784B4
_021784A8:
	ldrh r0, [r8, #0x10]
	add r0, r0, #1
	strh r0, [r8, #0x10]
_021784B4:
	add r6, r6, #1
	cmp r7, r6
	bgt _02178454
_021784C0:
	ldrh r0, [r8, #0x10]
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #0
	strh r0, [r8, #0x12]
	mov r0, #1
	strh r0, [r8, #0x10]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_21783AC

	arm_func_start TimeAttackLeaderboardsMenu__Func_21784E0
TimeAttackLeaderboardsMenu__Func_21784E0: // 0x021784E0
	ldr ip, _021784E8 // =SaveGame__Block4__GetLastUsedCharacter
	bx ip
	.align 2, 0
_021784E8: .word SaveGame__Block4__GetLastUsedCharacter
	arm_func_end TimeAttackLeaderboardsMenu__Func_21784E0

	arm_func_start TimeAttackLeaderboardsMenu__Func_21784EC
TimeAttackLeaderboardsMenu__Func_21784EC: // 0x021784EC
	stmdb sp!, {r3, r4, r5, lr}
	movs r4, r1
	mov r5, r0
	beq _02178508
	ldr r0, _02178524 // =saveGame
	bl SaveGame__GetPlayerNameLength
	strh r0, [r4]
_02178508:
	mov r0, r5
	bl TimeAttackLeaderboardsMenu__Func_217852C
	ldr r1, _02178528 // =0x0000FFFF
	cmp r0, r1
	moveq r0, #0
	ldrne r0, _02178524 // =saveGame
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02178524: .word saveGame
_02178528: .word 0x0000FFFF
	arm_func_end TimeAttackLeaderboardsMenu__Func_21784EC

	arm_func_start TimeAttackLeaderboardsMenu__Func_217852C
TimeAttackLeaderboardsMenu__Func_217852C: // 0x0217852C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl TimeAttackLeaderboardsMenu__Func_21784E0
	mov r1, r0
	cmp r1, #2
	ldrhs r0, _02178560 // =0x0000FFFF
	ldmhsia sp!, {r4, pc}
	ldr r0, _02178564 // =saveGame+0x00000898
	mov r2, r4
	and r1, r1, #0xff
	mov r3, #1
	bl SaveGame__GetTimeAttackRecord
	ldmia sp!, {r4, pc}
	.align 2, 0
_02178560: .word 0x0000FFFF
_02178564: .word saveGame+0x00000898
	arm_func_end TimeAttackLeaderboardsMenu__Func_217852C

	arm_func_start TimeAttackLeaderboardsMenu__Func_2178568
TimeAttackLeaderboardsMenu__Func_2178568: // 0x02178568
	stmdb sp!, {r3, lr}
	bl TimeAttackLeaderboardsMenu__Func_21787F0
	bl SaveGame__GetLeaderboardLastUpdatedTime
	ldmia sp!, {r3, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_2178568

	arm_func_start TimeAttackLeaderboardsMenu__Func_2178578
TimeAttackLeaderboardsMenu__Func_2178578: // 0x02178578
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r9, r1
	mov r8, r2
	mov r7, r3
	bl TimeAttackLeaderboardsMenu__Func_21787F0
	mov r1, r9
	mov r4, r0
	bl SaveGame__GetLeaderboardsTime_Top
	movs r6, r0
	mov r0, r4
	mov r1, r9
	ldreq r6, _02178624 // =0x0000FFFF
	bl SaveGame__GetLeaderboardsEntry_Top
	ldr r1, _02178624 // =0x0000FFFF
	mov r5, r0
	cmp r6, r1
	beq _021785FC
	ldrh r0, [r5, #0]
	cmp r0, #0
	bne _021785FC
	cmp r7, #0
	ldr r5, _02178628 // =saveGame
	beq _02178614
	mov r1, #0
_021785D8:
	mov r0, r1, lsl #1
	ldrh r0, [r5, r0]
	cmp r0, #0
	beq _021785F4
	add r1, r1, #1
	cmp r1, #8
	blt _021785D8
_021785F4:
	strh r1, [r7]
	b _02178614
_021785FC:
	cmp r7, #0
	beq _02178614
	mov r0, r4
	mov r1, r9
	bl SaveGame__GetLeaderboardsNameLen_Top
	strh r0, [r7]
_02178614:
	cmp r8, #0
	strneh r6, [r8]
	mov r0, r5
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02178624: .word 0x0000FFFF
_02178628: .word saveGame
	arm_func_end TimeAttackLeaderboardsMenu__Func_2178578

	arm_func_start TimeAttackLeaderboardsMenu__Func_217862C
TimeAttackLeaderboardsMenu__Func_217862C: // 0x0217862C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r9, r1
	mov r8, r2
	mov r7, r3
	bl TimeAttackLeaderboardsMenu__Func_21787F0
	mov r1, r9
	mov r4, r0
	bl SaveGame__GetLeaderboardsTime_Near
	movs r6, r0
	mov r0, r4
	mov r1, r9
	ldreq r6, _021786D8 // =0x0000FFFF
	bl SaveGame__GetLeaderboardsEntry_Near
	ldr r1, _021786D8 // =0x0000FFFF
	mov r5, r0
	cmp r6, r1
	beq _021786B0
	ldrh r0, [r5, #0]
	cmp r0, #0
	bne _021786B0
	cmp r7, #0
	ldr r5, _021786DC // =saveGame
	beq _021786C8
	mov r1, #0
_0217868C:
	mov r0, r1, lsl #1
	ldrh r0, [r5, r0]
	cmp r0, #0
	beq _021786A8
	add r1, r1, #1
	cmp r1, #8
	blt _0217868C
_021786A8:
	strh r1, [r7]
	b _021786C8
_021786B0:
	cmp r7, #0
	beq _021786C8
	mov r0, r4
	mov r1, r9
	bl SaveGame__GetLeaderboardsNameLen_Near
	strh r0, [r7]
_021786C8:
	cmp r8, #0
	strneh r6, [r8]
	mov r0, r5
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_021786D8: .word 0x0000FFFF
_021786DC: .word saveGame
	arm_func_end TimeAttackLeaderboardsMenu__Func_217862C

	arm_func_start TimeAttackLeaderboardsMenu__Func_21786E0
TimeAttackLeaderboardsMenu__Func_21786E0: // 0x021786E0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r1
	bl TimeAttackLeaderboardsMenu__Func_21787F0
	mov r1, r5
	mov r4, r0
	bl SaveGame__GetLeaderboardsTime_Top
	cmp r0, #0
	ldreq r0, _02178714 // =0x0000FFFF
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	mov r1, r5
	bl SaveGame__GetLeaderboardRankFlag_Top
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02178714: .word 0x0000FFFF
	arm_func_end TimeAttackLeaderboardsMenu__Func_21786E0

	arm_func_start TimeAttackLeaderboardsMenu__Func_2178718
TimeAttackLeaderboardsMenu__Func_2178718: // 0x02178718
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r1
	bl TimeAttackLeaderboardsMenu__Func_21787F0
	mov r1, r5
	mov r4, r0
	bl SaveGame__GetLeaderboardsTime_Near
	cmp r0, #0
	ldreq r0, _0217874C // =0x0000FFFF
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	mov r1, r5
	bl SaveGame__GetLeaderboardRankFlag_Near
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217874C: .word 0x0000FFFF
	arm_func_end TimeAttackLeaderboardsMenu__Func_2178718

	arm_func_start TimeAttackLeaderboardsMenu__Func_2178750
TimeAttackLeaderboardsMenu__Func_2178750: // 0x02178750
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r9, r0
	bl TimeAttackLeaderboardsMenu__Func_21787F0
	mov r7, r0
	mov r0, r9
	bl TimeAttackLeaderboardsMenu__Func_21784E0
	cmp r0, #2
	ldrhs r0, _021787DC // =0x0000FFFF
	ldmhsia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r8, #0
	ldr r4, _021787DC // =0x0000FFFF
	add r6, sp, #0
	mov r5, r8
_02178784:
	mov r1, r8, lsl #0x10
	mov r0, r9
	mov r2, r6
	mov r3, r5
	mov r1, r1, lsr #0x10
	bl TimeAttackLeaderboardsMenu__Func_217862C
	ldrh r0, [sp]
	cmp r0, r4
	beq _021787C8
	mov r1, r8, lsl #0x10
	mov r0, r7
	mov r1, r1, lsr #0x10
	bl SaveGame__GetLeaderboardsNameLen_Near
	cmp r0, #0
	moveq r0, r8, lsl #0x10
	moveq r0, r0, lsr #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_021787C8:
	add r8, r8, #1
	cmp r8, #5
	blt _02178784
	ldr r0, _021787DC // =0x0000FFFF
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_021787DC: .word 0x0000FFFF
	arm_func_end TimeAttackLeaderboardsMenu__Func_2178750

	arm_func_start TimeAttackLeaderboardsMenu__Func_21787E0
TimeAttackLeaderboardsMenu__Func_21787E0: // 0x021787E0
	stmdb sp!, {r3, lr}
	bl TimeAttackLeaderboardsMenu__Func_21787F0
	bl SaveGame__GetLeaderboardRankOrder
	ldmia sp!, {r3, pc}
	arm_func_end TimeAttackLeaderboardsMenu__Func_21787E0

	arm_func_start TimeAttackLeaderboardsMenu__Func_21787F0
TimeAttackLeaderboardsMenu__Func_21787F0: // 0x021787F0
	cmp r0, #0x13
	addls pc, pc, r0, lsl #2
	b _021788BC
_021787FC: // jump table
	b _0217884C // case 0
	b _02178854 // case 1
	b _021788BC // case 2
	b _0217885C // case 3
	b _02178864 // case 4
	b _021788BC // case 5
	b _0217886C // case 6
	b _02178874 // case 7
	b _021788BC // case 8
	b _0217887C // case 9
	b _02178884 // case 10
	b _021788BC // case 11
	b _0217888C // case 12
	b _02178894 // case 13
	b _021788BC // case 14
	b _0217889C // case 15
	b _021788A4 // case 16
	b _021788BC // case 17
	b _021788AC // case 18
	b _021788B4 // case 19
_0217884C:
	mov r0, #0
	bx lr
_02178854:
	mov r0, #1
	bx lr
_0217885C:
	mov r0, #2
	bx lr
_02178864:
	mov r0, #3
	bx lr
_0217886C:
	mov r0, #4
	bx lr
_02178874:
	mov r0, #5
	bx lr
_0217887C:
	mov r0, #6
	bx lr
_02178884:
	mov r0, #7
	bx lr
_0217888C:
	mov r0, #8
	bx lr
_02178894:
	mov r0, #9
	bx lr
_0217889C:
	mov r0, #0xa
	bx lr
_021788A4:
	mov r0, #0xb
	bx lr
_021788AC:
	mov r0, #0xc
	bx lr
_021788B4:
	mov r0, #0xd
	bx lr
_021788BC:
	mov r0, #0
	bx lr
	arm_func_end TimeAttackLeaderboardsMenu__Func_21787F0

	arm_func_start TimeAttackLeaderboardsMenu__Func_21788C4
TimeAttackLeaderboardsMenu__Func_21788C4: // 0x021788C4
	cmp r0, #0xd
	addls pc, pc, r0, lsl #2
	b _02178978
_021788D0: // jump table
	b _02178908 // case 0
	b _02178910 // case 1
	b _02178918 // case 2
	b _02178920 // case 3
	b _02178928 // case 4
	b _02178930 // case 5
	b _02178938 // case 6
	b _02178940 // case 7
	b _02178948 // case 8
	b _02178950 // case 9
	b _02178958 // case 10
	b _02178960 // case 11
	b _02178968 // case 12
	b _02178970 // case 13
_02178908:
	mov r0, #0
	bx lr
_02178910:
	mov r0, #1
	bx lr
_02178918:
	mov r0, #3
	bx lr
_02178920:
	mov r0, #4
	bx lr
_02178928:
	mov r0, #6
	bx lr
_02178930:
	mov r0, #7
	bx lr
_02178938:
	mov r0, #9
	bx lr
_02178940:
	mov r0, #0xa
	bx lr
_02178948:
	mov r0, #0xc
	bx lr
_02178950:
	mov r0, #0xd
	bx lr
_02178958:
	mov r0, #0xf
	bx lr
_02178960:
	mov r0, #0x10
	bx lr
_02178968:
	mov r0, #0x12
	bx lr
_02178970:
	mov r0, #0x13
	bx lr
_02178978:
	mov r0, #0
	bx lr
	arm_func_end TimeAttackLeaderboardsMenu__Func_21788C4

