	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start ovl09_2168EA4
ovl09_2168EA4: // 0x02168EA4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x1c
	mov r5, r0
	ldrh r7, [r5]
	ldrh r4, [r5, #2]
	bl ovl09_2161768
	mov r0, #0
	strh r7, [r5]
	bl ovl09_21733D4
	mov r1, r7
	mov r6, r0
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov lr, #0
	str lr, [sp]
	str lr, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02168F60 // =VRAMSystem__VRAM_PALETTE_OBJ
	str lr, [sp, #0xc]
	ldr ip, [r0]
	mov r3, #1
	str ip, [sp, #0x10]
	str r3, [sp, #0x14]
	ldr r3, _02168F64 // =0x00000804
	mov r1, r6
	mov r2, r7
	add r0, r5, #4
	str lr, [sp, #0x18]
	bl AnimatorSprite__Init
	strh r4, [r5, #2]
	strh r4, [r5, #0x54]
	mov r0, #0x80
	strh r0, [r5, #0x68]
	mov r0, #0x60
	strh r0, [r5, #0x6a]
	mov r0, #0
	strh r0, [r5, #0x74]
	mov r0, #0x1000
	str r0, [r5, #0x6c]
	str r0, [r5, #0x70]
	ldr r0, [r5, #0x40]
	orr r0, r0, #0x200
	str r0, [r5, #0x40]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02168F60: .word VRAMSystem__VRAM_PALETTE_OBJ
_02168F64: .word 0x00000804
	arm_func_end ovl09_2168EA4

	arm_func_start ovl09_2168F68
ovl09_2168F68: // 0x02168F68
	ldr ip, _02168F74 // =AnimatorSprite__Release
	add r0, r0, #4
	bx ip
	.align 2, 0
_02168F74: .word AnimatorSprite__Release
	arm_func_end ovl09_2168F68