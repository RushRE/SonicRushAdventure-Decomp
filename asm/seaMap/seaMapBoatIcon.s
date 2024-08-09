	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__VRAM_PALETTE_OBJ

	.text

	arm_func_start SeaMapBoatIcon__Create
SeaMapBoatIcon__Create: // 0x02048F40
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x28
	mov r7, r0
	mov r6, r1
	bl SeaMapManager__GetWork
	ldr r1, _02049098 // =0x00000111
	mov r5, r0
	mov r2, #0
	str r1, [sp]
	mov r4, #1
	str r4, [sp, #4]
	mov r4, #0x74
	ldr r0, _0204909C // =SeaMapBoatIcon__Main
	ldr r1, _020490A0 // =SeaMapBoatIcon__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r8, r0
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x74
	bl MIi_CpuClear16
	mov r1, r8
	mov r0, r4
	mov r2, r7
	mov r3, r6
	bl SeaMapEventManager__InitMapObject
	ldr r0, _020490A4 // =0x0210FF80
	ldrh r1, [r0, #0x1a]
	ldrh r3, [r0, #0x16]
	ldrh r2, [r0, #0x18]
	strh r1, [sp, #0x20]
	ldrh r1, [r0, #0x1c]
	ldrh r0, [r0, #0x1e]
	strh r3, [sp, #0x1c]
	strh r2, [sp, #0x1e]
	strh r1, [sp, #0x22]
	strh r0, [sp, #0x24]
	bl SeaMapManager__GetWork
	ldr r1, [r0, #0x194]
	add r0, sp, #0x1c
	cmp r1, #4
	ldrgesh r1, [r6, #0x10]
	mov r1, r1, lsl #1
	ldrh r8, [r0, r1]
	ldr r0, [r5, #0x15c]
	mov r1, r8
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	ldr r0, [r5, #0x158]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0x158]
	mov ip, #0
	str r1, [sp]
	str ip, [sp, #4]
	str r0, [sp, #8]
	str ip, [sp, #0xc]
	ldr r3, [r5, #0x158]
	ldr r0, _020490A8 // =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, #7
	ldr r3, [r0, r3, lsl #2]
	mov r2, r8
	str r3, [sp, #0x10]
	str ip, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r1, [r5, #0x15c]
	add r0, r4, #0x10
	mov r3, #0x800
	bl AnimatorSprite__Init
	ldrsh r2, [r6, #2]
	mov r1, #0
	add r0, r4, #0x10
	strh r2, [r4, #0x18]
	ldrsh r3, [r6, #4]
	mov r2, r1
	strh r3, [r4, #0x1a]
	ldrh r3, [r7, #2]
	strh r3, [r4, #0x60]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl SeaMapEventManager__SetObjectAsActive
	mov r0, r4
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02049098: .word 0x00000111
_0204909C: .word SeaMapBoatIcon__Main
_020490A0: .word SeaMapBoatIcon__Destructor
_020490A4: .word 0x0210FF80
_020490A8: .word VRAMSystem__VRAM_PALETTE_OBJ
	arm_func_end SeaMapBoatIcon__Create

	arm_func_start SeaMapBoatIcon__Main
SeaMapBoatIcon__Main: // 0x020490AC
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0xc
	add r1, r4, #0x18
	bl SeaMapEventManager__Func_20474FC
	add r0, r4, #0x10
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapBoatIcon__Main

	arm_func_start SeaMapBoatIcon__Destructor
SeaMapBoatIcon__Destructor: // 0x020490D0
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x10
	bl AnimatorSprite__Release
	mov r0, r4
	bl SeaMapEventManager__SetObjectAsInactive
	mov r0, r4
	bl SeaMapEventManager__DestroyObject
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapBoatIcon__Destructor