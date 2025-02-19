	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public MainMenuBackgroundControl
MainMenuBackgroundControl: // 0x0217EFC0
	.space 0x04 // Task*

	.text

	arm_func_start MainMenu__SetBackground
MainMenu__SetBackground: // 0x02156648
	stmdb sp!, {r3, r4, r5, lr}
	ldr r3, _021566B0 // =MainMenuBackgroundControl
	mov r4, r0
	ldr ip, _021566B4 // =ovl03_0217D1F8
	mov lr, r2, lsl #1
	rsb r0, r1, #1
	str r4, [r3]
	mov r5, #0
	str r5, [r4]
	add r3, r4, r1, lsl #1
	ldrh ip, [ip, lr]
	str r5, [r4, #0xa8]
	ldr r1, _021566B8 // =0x0000FFFF
	strh ip, [r3, #4]
	add r0, r4, r0, lsl #1
	strh r1, [r0, #4]
	str r5, [r4, #8]
	ldr r0, _021566BC // =MainMenu__CommonBGs
	str r5, [r4, #0xc]
	ldr r0, [r0, r2, lsl #2]
	mov r1, r5
	bl FSRequestFileSync
	str r0, [r4, #0xa4]
	mov r0, r4
	bl MainMenu__Func_2156824
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021566B0: .word MainMenuBackgroundControl
_021566B4: .word ovl03_0217D1F8
_021566B8: .word 0x0000FFFF
_021566BC: .word MainMenu__CommonBGs
	arm_func_end MainMenu__SetBackground

	arm_func_start MainMenu__LoadMenuBG
MainMenu__LoadMenuBG: // 0x021566C0
	stmdb sp!, {r4, lr}
	ldr ip, _0215670C // =MainMenuBackgroundControl
	mov r4, r0
	str r4, [ip]
	mov ip, #0
	str ip, [r4]
	str ip, [r4, #0xa8]
	strh r1, [r4, #4]
	strh r2, [r4, #6]
	str ip, [r4, #8]
	ldr r0, _02156710 // =MainMenu__CommonBGs
	str ip, [r4, #0xc]
	ldr r0, [r0, r3, lsl #2]
	mov r1, ip
	bl FSRequestFileSync
	str r0, [r4, #0xa4]
	mov r0, r4
	bl MainMenu__Func_2156824
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215670C: .word MainMenuBackgroundControl
_02156710: .word MainMenu__CommonBGs
	arm_func_end MainMenu__LoadMenuBG

	arm_func_start MainMenu__Func_2156714
MainMenu__Func_2156714: // 0x02156714
	mov r1, #0
	str r1, [r0]
	str r1, [r0, #8]
	str r1, [r0, #0xc]
	bx lr
	arm_func_end MainMenu__Func_2156714

	arm_func_start MainMenu__HandleBackgroundControl
MainMenu__HandleBackgroundControl: // 0x02156728
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	ldr r0, [r4, #0]
	tst r0, #1
	bne _02156778
	orr r0, r0, #1
	ldr r5, _0215678C // =0x0000FFFF
	str r0, [r4]
	add r7, r4, #0x10
	mov r6, #0
_02156750:
	add r0, r4, r6, lsl #1
	ldrh r0, [r0, #4]
	cmp r0, r5
	beq _02156768
	mov r0, r7
	bl DrawBackground
_02156768:
	add r6, r6, #1
	cmp r6, #2
	add r7, r7, #0x48
	blt _02156750
_02156778:
	ldr r0, [r4, #0xa8]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	bl MainMenu__VBlankCallback_2156A08
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0215678C: .word 0x0000FFFF
	arm_func_end MainMenu__HandleBackgroundControl

	arm_func_start MainMenu__Func_2156790
MainMenu__Func_2156790: // 0x02156790
	stmdb sp!, {r3, lr}
	str r1, [r0, #0xa8]
	cmp r1, #0
	beq _021567AC
	ldr r0, _021567B8 // =MainMenu__VBlankCallback_2156A08
	bl RenderCore_SetVBlankCallback
	ldmia sp!, {r3, pc}
_021567AC:
	mov r0, #0
	bl RenderCore_SetVBlankCallback
	ldmia sp!, {r3, pc}
	.align 2, 0
_021567B8: .word MainMenu__VBlankCallback_2156A08
	arm_func_end MainMenu__Func_2156790

	arm_func_start MainMenu__Func_21567BC
MainMenu__Func_21567BC: // 0x021567BC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xa8]
	cmp r0, #0
	beq _021567E0
	mov r0, #0
	bl RenderCore_SetVBlankCallback
	mov r0, #0
	str r0, [r4, #0xa8]
_021567E0:
	ldr r0, [r4, #0xa0]
	cmp r0, #0
	beq _021567F8
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0xa0]
_021567F8:
	ldr r0, [r4, #0xa4]
	cmp r0, #0
	beq _02156810
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0xa4]
_02156810:
	ldr r0, _02156820 // =MainMenuBackgroundControl
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156820: .word MainMenuBackgroundControl
	arm_func_end MainMenu__Func_21567BC

	arm_func_start MainMenu__Func_2156824
MainMenu__Func_2156824: // 0x02156824
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r10, r0
	mov r8, #0
	ldr r4, _021568C4 // =0x0000FFFF
	add r9, r10, #0x10
	mov r6, #0x28
	mov r5, #0x20
	mov r7, r8
	mov r11, #0x48
_0215684C:
	add r0, r10, r8, lsl #1
	ldrh r0, [r0, #4]
	cmp r0, r4
	bne _02156870
	mov r0, r7
	mov r1, r9
	mov r2, r11
	bl MIi_CpuClear16
	b _02156890
_02156870:
	and r0, r0, #0xff
	stmia sp, {r0, r6}
	str r5, [sp, #8]
	ldr r1, [r10, #0xa4]
	mov r0, r9
	mov r2, #4
	mov r3, r8
	bl InitBackground
_02156890:
	add r8, r8, #1
	cmp r8, #2
	add r9, r9, #0x48
	blt _0215684C
	mov r0, #0xa00
	bl _AllocHeadHEAP_USER
	str r0, [r10, #0xa0]
	ldr r0, [r10, #0xa4]
	bl GetBackgroundMappings
	ldr r1, [r10, #0xa0]
	bl RenderCore_CPUCopyCompressed
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021568C4: .word 0x0000FFFF
	arm_func_end MainMenu__Func_2156824

	arm_func_start MainMenu__Func_21568C8
MainMenu__Func_21568C8: // 0x021568C8
	ldr r2, _021568E8 // =0x000001FF
	ldr ip, _021568EC // =0x0400101C
	mov r3, r2, lsl #0x10
	and r2, r0, r2
	and r0, r3, r1, lsl #16
	orr r0, r2, r0
	str r0, [ip]
	bx lr
	.align 2, 0
_021568E8: .word 0x000001FF
_021568EC: .word 0x0400101C
	arm_func_end MainMenu__Func_21568C8

	arm_func_start MainMenu__Func_21568F0
MainMenu__Func_21568F0: // 0x021568F0
	ldr r2, _02156910 // =0x000001FF
	ldr ip, _02156914 // =0x04001018
	mov r3, r2, lsl #0x10
	and r2, r0, r2
	and r0, r3, r1, lsl #16
	orr r0, r2, r0
	str r0, [ip]
	bx lr
	.align 2, 0
_02156910: .word 0x000001FF
_02156914: .word 0x04001018
	arm_func_end MainMenu__Func_21568F0

	arm_func_start MainMenu__Func_2156918
MainMenu__Func_2156918: // 0x02156918
	ldr r2, _02156938 // =0x000001FF
	ldr ip, _0215693C // =0x04001014
	mov r3, r2, lsl #0x10
	and r2, r0, r2
	and r0, r3, r1, lsl #16
	orr r0, r2, r0
	str r0, [ip]
	bx lr
	.align 2, 0
_02156938: .word 0x000001FF
_0215693C: .word 0x04001014
	arm_func_end MainMenu__Func_2156918

	arm_func_start MainMenu__Func_2156940
MainMenu__Func_2156940: // 0x02156940
	ldr r2, _02156960 // =0x000001FF
	ldr ip, _02156964 // =0x04001010
	mov r3, r2, lsl #0x10
	and r2, r0, r2
	and r0, r3, r1, lsl #16
	orr r0, r2, r0
	str r0, [ip]
	bx lr
	.align 2, 0
_02156960: .word 0x000001FF
_02156964: .word 0x04001010
	arm_func_end MainMenu__Func_2156940

	arm_func_start MainMenu__Func_2156968
MainMenu__Func_2156968: // 0x02156968
	ldr r2, _02156988 // =0x000001FF
	ldr ip, _0215698C // =0x0400001C
	mov r3, r2, lsl #0x10
	and r2, r0, r2
	and r0, r3, r1, lsl #16
	orr r0, r2, r0
	str r0, [ip]
	bx lr
	.align 2, 0
_02156988: .word 0x000001FF
_0215698C: .word 0x0400001C
	arm_func_end MainMenu__Func_2156968

	arm_func_start MainMenu__Func_2156990
MainMenu__Func_2156990: // 0x02156990
	ldr r2, _021569B0 // =0x000001FF
	ldr ip, _021569B4 // =0x04000018
	mov r3, r2, lsl #0x10
	and r2, r0, r2
	and r0, r3, r1, lsl #16
	orr r0, r2, r0
	str r0, [ip]
	bx lr
	.align 2, 0
_021569B0: .word 0x000001FF
_021569B4: .word 0x04000018
	arm_func_end MainMenu__Func_2156990

	arm_func_start MainMenu__Func_21569B8
MainMenu__Func_21569B8: // 0x021569B8
	ldr r2, _021569D8 // =0x000001FF
	ldr ip, _021569DC // =0x04000014
	mov r3, r2, lsl #0x10
	and r2, r0, r2
	and r0, r3, r1, lsl #16
	orr r0, r2, r0
	str r0, [ip]
	bx lr
	.align 2, 0
_021569D8: .word 0x000001FF
_021569DC: .word 0x04000014
	arm_func_end MainMenu__Func_21569B8

	arm_func_start MainMenu__Func_21569E0
MainMenu__Func_21569E0: // 0x021569E0
	ldr r2, _02156A00 // =0x000001FF
	ldr ip, _02156A04 // =0x04000010
	mov r3, r2, lsl #0x10
	and r2, r0, r2
	and r0, r3, r1, lsl #16
	orr r0, r2, r0
	str r0, [ip]
	bx lr
	.align 2, 0
_02156A00: .word 0x000001FF
_02156A04: .word 0x04000010
	arm_func_end MainMenu__Func_21569E0

	arm_func_start MainMenu__VBlankCallback_2156A08
MainMenu__VBlankCallback_2156A08: // 0x02156A08
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x40
	ldr r4, _02156B80 // =0x0217D1FC
	add r5, sp, #0x20
	ldmia r4!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r4, {r0, r1, r2, r3}
	ldr r4, _02156B84 // =MainMenuBackgroundControl
	stmia r5, {r0, r1, r2, r3}
	ldr r7, [r4, #0]
	mov r6, #0
	ldr r0, [r7, #8]
	add r0, r0, #0x800
	str r0, [r7, #8]
	ldr r0, [r7, #0xc]
	add r0, r0, #0x800
	str r0, [r7, #0xc]
_02156A4C:
	add r0, r7, r6, lsl #1
	ldrh r8, [r0, #4]
	cmp r8, #4
	bhs _02156B6C
	ldr r1, [r7, #8]
	ldr r2, _02156B88 // =VRAMSystem__GFXControl
	mov r1, r1, lsl #4
	ldr r5, [r7, #0xc]
	ldr r3, [r2, r6, lsl #2]
	mov r4, r1, lsr #0x10
	mov r1, r8, lsl #2
	strh r4, [r3, r1]
	ldrh r2, [r0, #4]
	mov r1, r5, lsl #4
	mov r1, r1, lsr #0x10
	add r2, r3, r2, lsl #2
	strh r1, [r2, #2]
	ldr r2, [r7, #0xa8]
	cmp r2, #0
	beq _02156AB4
	ldrh r3, [r0, #4]
	add r2, sp, #0x20
	add r2, r2, r6, lsl #4
	ldr r2, [r2, r3, lsl #2]
	mov r0, r4
	blx r2
_02156AB4:
	mov r4, r4, asr #3
	cmp r6, #0
	moveq r10, #1
	mov r0, r4
	mov r1, #0x28
	movne r10, #0xd
	bl FX_ModS32
	mov r0, r0, lsl #0x10
	and r9, r4, #0x3f
	mov r8, r0, lsr #0x10
	mov r4, #0x29
	mov r11, #0x20
_02156AE4:
	rsb r0, r9, #0x40
	mov r0, r0, lsl #0x10
	add r1, r8, r0, lsr #16
	cmp r1, #0x28
	mov r5, r0, lsr #0x10
	rsbgt r0, r8, #0x28
	movgt r0, r0, lsl #0x10
	movgt r5, r0, lsr #0x10
	mov r0, #0
	stmia sp, {r0, r10}
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	str r9, [sp, #0x10]
	cmp r4, r5
	movls r5, r4
	str r0, [sp, #0x14]
	str r5, [sp, #0x18]
	str r11, [sp, #0x1c]
	ldr r0, [r7, #0xa0]
	mov r1, r8
	mov r2, #0
	mov r3, #0x28
	bl Mappings__LoadUnknown
	mov r1, #0x28
	add r0, r8, r5
	bl FX_ModS32
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	sub r0, r4, r5
	mov r0, r0, lsl #0x10
	movs r4, r0, lsr #0x10
	add r0, r9, r5
	and r9, r0, #0x3f
	bne _02156AE4
_02156B6C:
	add r6, r6, #1
	cmp r6, #2
	blt _02156A4C
	add sp, sp, #0x40
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02156B80: .word 0x0217D1FC
_02156B84: .word MainMenuBackgroundControl
_02156B88: .word VRAMSystem__GFXControl
	arm_func_end MainMenu__VBlankCallback_2156A08

	.data
	
MainMenu__CommonBGs: // 0x0217E5B0
	.word aBgDmcmnMenuBas	// "/bg/dmcmn_menu_base_p8.bbg"
	.word aBgDmcmnDmtaBas	// "/bg/dmcmn_dmta_base_p8.bbg"

aBgDmcmnMenuBas: // 0x0217E5B8
	.asciz "/bg/dmcmn_menu_base_p8.bbg"
	.align 4
	
aBgDmcmnDmtaBas: // 0x0217E5D4
	.asciz "/bg/dmcmn_dmta_base_p8.bbg"
	.align 4