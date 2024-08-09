	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__VRAM_PALETTE_OBJ

	.text

	arm_func_start SeaMapStylusIcon__Create
SeaMapStylusIcon__Create: // 0x020490F8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x1c
	mov r7, r0
	mov r6, r1
	bl SeaMapManager__GetWork
	ldr r1, _020491EC // =0x00000111
	mov r5, r0
	mov r2, #0
	str r1, [sp]
	mov r4, #1
	str r4, [sp, #4]
	mov r4, #0x90
	ldr r0, _020491F0 // =SeaMapStylusIcon__Main
	ldr r1, _020491F4 // =SeaMapStylusIcon__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r8, r0
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x90
	bl MIi_CpuClear16
	mov r1, r8
	mov r2, r7
	mov r3, r6
	mov r0, r4
	bl SeaMapEventManager__InitMapObject
	ldr r1, _020491F8 // =SeaMapStylusIcon__Func_20492D4
	mov r0, #0x22
	str r1, [r4, #0x10]
	strh r0, [r4, #0x88]
	bl SeaMapStylusIcon__Func_2049204
	mov r1, r0
	ldr r0, [r5, #0x158]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0x158]
	mov r3, #0
	stmia sp, {r1, r3}
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr r2, [r5, #0x158]
	ldr r0, _020491FC // =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, #1
	ldr r2, [r0, r2, lsl #2]
	add r0, r4, #0x14
	str r2, [sp, #0x10]
	str r3, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r1, [r5, #0x15c]
	ldr r3, _02049200 // =0x00000804
	mov r2, #0x7d
	bl AnimatorSprite__Init
	mov r0, #0xe
	strh r0, [r4, #0x64]
	mov r0, r4
	bl SeaMapEventManager__SetObjectAsActive
	mov r0, r4
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020491EC: .word 0x00000111
_020491F0: .word SeaMapStylusIcon__Main
_020491F4: .word SeaMapStylusIcon__Destructor
_020491F8: .word SeaMapStylusIcon__Func_20492D4
_020491FC: .word VRAMSystem__VRAM_PALETTE_OBJ
_02049200: .word 0x00000804
	arm_func_end SeaMapStylusIcon__Create

	arm_func_start SeaMapStylusIcon__Func_2049204
SeaMapStylusIcon__Func_2049204: // 0x02049204
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	ldr r0, _0204926C // =0x0210FF80
	ldrh r2, [r0]
	ldrh r1, [r0, #2]
	ldrh r0, [r0, #4]
	strh r2, [sp]
	strh r1, [sp, #2]
	strh r0, [sp, #4]
	bl SeaMapManager__GetWork
	mov r6, #0
	ldr r5, [r0, #0x15c]
	mov r7, r6
	add r4, sp, #0
_0204923C:
	mov r0, r7, lsl #1
	ldrh r1, [r4, r0]
	mov r0, r5
	bl Sprite__GetSpriteSize1FromAnim
	cmp r6, r0
	add r7, r7, #1
	movlo r6, r0
	cmp r7, #3
	blo _0204923C
	mov r0, r6
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0204926C: .word 0x0210FF80
	arm_func_end SeaMapStylusIcon__Func_2049204

	arm_func_start SeaMapStylusIcon__Main
SeaMapStylusIcon__Main: // 0x02049270
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x10]
	blx r1
	add r0, r4, #0xc
	add r1, r4, #0x1c
	bl SeaMapEventManager__Func_20474FC
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x14
	bl SeaMapEventManager__Func_20471B8
	add r0, r4, #0x14
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapStylusIcon__Main

	arm_func_start SeaMapStylusIcon__Destructor
SeaMapStylusIcon__Destructor: // 0x020492AC
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x14
	bl AnimatorSprite__Release
	mov r0, r4
	bl SeaMapEventManager__SetObjectAsInactive
	mov r0, r4
	bl SeaMapEventManager__DestroyObject
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapStylusIcon__Destructor

	arm_func_start SeaMapStylusIcon__Func_20492D4
SeaMapStylusIcon__Func_20492D4: // 0x020492D4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x78]
	add r0, r4, #0x14
	mov r1, r1, asr #0xc
	strh r1, [r4, #0xc]
	ldr r2, [r4, #0x7c]
	mov r1, #0x7d
	mov r2, r2, asr #0xc
	strh r2, [r4, #0xe]
	bl AnimatorSprite__SetAnimation
	ldr r0, [r4, #0x50]
	mov r1, #0
	bic r0, r0, #4
	mov r2, r1
	str r0, [r4, #0x50]
	add r0, r4, #0x14
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [r4, #0x50]
	mov r1, #0
	orr r0, r0, #2
	str r0, [r4, #0x50]
	ldr r0, _0204933C // =SeaMapStylusIcon__Func_2049340
	strh r1, [r4, #0x8c]
	str r0, [r4, #0x10]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0204933C: .word SeaMapStylusIcon__Func_2049340
	arm_func_end SeaMapStylusIcon__Func_20492D4

	arm_func_start SeaMapStylusIcon__Func_2049340
SeaMapStylusIcon__Func_2049340: // 0x02049340
	ldrh r2, [r0, #0x8c]
	add r1, r2, #1
	strh r1, [r0, #0x8c]
	cmp r2, #0x3c
	ldrhi r1, _0204935C // =SeaMapStylusIcon__Func_2049360
	strhi r1, [r0, #0x10]
	bx lr
	.align 2, 0
_0204935C: .word SeaMapStylusIcon__Func_2049360
	arm_func_end SeaMapStylusIcon__Func_2049340

	arm_func_start SeaMapStylusIcon__Func_2049360
SeaMapStylusIcon__Func_2049360: // 0x02049360
	ldr r1, [r0, #0x50]
	mov r2, #0
	bic r1, r1, #2
	str r1, [r0, #0x50]
	ldr r1, _02049380 // =SeaMapStylusIcon__Func_2049384
	strh r2, [r0, #0x8c]
	str r1, [r0, #0x10]
	bx lr
	.align 2, 0
_02049380: .word SeaMapStylusIcon__Func_2049384
	arm_func_end SeaMapStylusIcon__Func_2049360

	arm_func_start SeaMapStylusIcon__Func_2049384
SeaMapStylusIcon__Func_2049384: // 0x02049384
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x50]
	tst r0, #0x40000000
	beq _020493BC
	ldrh r0, [r4, #0x20]
	cmp r0, #0x7d
	bne _020493BC
	add r0, r4, #0x14
	mov r1, #0x7e
	bl AnimatorSprite__SetAnimation
	ldr r0, [r4, #0x50]
	orr r0, r0, #4
	str r0, [r4, #0x50]
_020493BC:
	ldrh r1, [r4, #0x8c]
	add r0, r1, #1
	strh r0, [r4, #0x8c]
	cmp r1, #0x3c
	ldmlsia sp!, {r4, pc}
	ldrh r0, [r4, #0x20]
	cmp r0, #0x7d
	ldrne r0, _020493E4 // =SeaMapStylusIcon__Func_20493E8
	strne r0, [r4, #0x10]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020493E4: .word SeaMapStylusIcon__Func_20493E8
	arm_func_end SeaMapStylusIcon__Func_2049384

	arm_func_start SeaMapStylusIcon__Func_20493E8
SeaMapStylusIcon__Func_20493E8: // 0x020493E8
	mov r2, #0
	ldr r1, _020493FC // =SeaMapStylusIcon__Func_2049400
	strh r2, [r0, #0x8a]
	str r1, [r0, #0x10]
	bx lr
	.align 2, 0
_020493FC: .word SeaMapStylusIcon__Func_2049400
	arm_func_end SeaMapStylusIcon__Func_20493E8

	arm_func_start SeaMapStylusIcon__Func_2049400
SeaMapStylusIcon__Func_2049400: // 0x02049400
	stmdb sp!, {r3, lr}
	ldrsh r3, [r0, #0x8a]
	ldrsh r2, [r0, #0x88]
	mov r1, #0
	add r2, r3, r2
	strh r2, [r0, #0x8a]
	ldrsh r2, [r0, #0x8a]
	cmp r2, #0x1000
	movgt r1, #0x1000
	strgth r1, [r0, #0x8a]
	ldr lr, [r0, #0x78]
	ldr r3, [r0, #0x80]
	ldrsh r2, [r0, #0x8a]
	sub r3, r3, lr
	movgt r1, #1
	smull ip, r2, r3, r2
	adds r3, ip, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, lr, r3
	mov r2, r2, asr #0xc
	strh r2, [r0, #0xc]
	ldr lr, [r0, #0x7c]
	ldr r3, [r0, #0x84]
	ldrsh r2, [r0, #0x8a]
	sub r3, r3, lr
	smull ip, r2, r3, r2
	adds r3, ip, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, lr, r3
	mov r2, r2, asr #0xc
	cmp r1, #0
	ldrne r1, _0204949C // =SeaMapStylusIcon__Func_20494A0
	strh r2, [r0, #0xe]
	strne r1, [r0, #0x10]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0204949C: .word SeaMapStylusIcon__Func_20494A0
	arm_func_end SeaMapStylusIcon__Func_2049400

	arm_func_start SeaMapStylusIcon__Func_20494A0
SeaMapStylusIcon__Func_20494A0: // 0x020494A0
	mov r2, #0
	ldr r1, _020494B4 // =SeaMapStylusIcon__Func_20494B8
	strh r2, [r0, #0x8c]
	str r1, [r0, #0x10]
	bx lr
	.align 2, 0
_020494B4: .word SeaMapStylusIcon__Func_20494B8
	arm_func_end SeaMapStylusIcon__Func_20494A0

	arm_func_start SeaMapStylusIcon__Func_20494B8
SeaMapStylusIcon__Func_20494B8: // 0x020494B8
	ldrh r2, [r0, #0x8c]
	add r1, r2, #1
	strh r1, [r0, #0x8c]
	cmp r2, #0x3c
	ldrhi r1, _020494D4 // =SeaMapStylusIcon__Func_20494D8
	strhi r1, [r0, #0x10]
	bx lr
	.align 2, 0
_020494D4: .word SeaMapStylusIcon__Func_20494D8
	arm_func_end SeaMapStylusIcon__Func_20494B8

	arm_func_start SeaMapStylusIcon__Func_20494D8
SeaMapStylusIcon__Func_20494D8: // 0x020494D8
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x14
	mov r1, #0x7f
	bl AnimatorSprite__SetAnimation
	ldr r0, [r4, #0x50]
	mov r1, #0
	bic r0, r0, #4
	str r0, [r4, #0x50]
	ldr r0, _0204950C // =SeaMapStylusIcon__Func_2049510
	strh r1, [r4, #0x8c]
	str r0, [r4, #0x10]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0204950C: .word SeaMapStylusIcon__Func_2049510
	arm_func_end SeaMapStylusIcon__Func_20494D8

	arm_func_start SeaMapStylusIcon__Func_2049510
SeaMapStylusIcon__Func_2049510: // 0x02049510
	ldrh r2, [r0, #0x8c]
	add r1, r2, #1
	strh r1, [r0, #0x8c]
	cmp r2, #0x3c
	bxls lr
	ldr r1, [r0, #0x50]
	tst r1, #0x40000000
	ldrne r1, _02049538 // =SeaMapStylusIcon__Func_20492D4
	strne r1, [r0, #0x10]
	bx lr
	.align 2, 0
_02049538: .word SeaMapStylusIcon__Func_20492D4
	arm_func_end SeaMapStylusIcon__Func_2049510