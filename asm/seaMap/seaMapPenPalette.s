	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__VRAM_PALETTE_OBJ
.public VRAMSystem__VRAM_PALETTE_BG

	.text

	arm_func_start SeaMapPenPalette__Create
SeaMapPenPalette__Create: // 0x020432BC
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r1, _0204338C // =0x0000FFFF
	ldr r4, _02043390 // =0x00000ADC
	mov r2, #0
	str r1, [sp]
	mov r6, r0
	ldr r0, _02043394 // =SeaMapPenPalette__Main
	ldr r1, _02043398 // =SeaMapPenPalette__Destructor
	stmib sp, {r2, r4}
	mov r3, r2
	bl TaskCreate_
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r6, #4]
	ldr r2, _0204339C // =0x0000080C
	str r0, [r4]
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear16
	ldr r2, [r6, #4]
	ldr r0, _020433A0 // =VRAMSystem__VRAM_PALETTE_BG
	add r1, r4, #8
	ldr r0, [r0, r2, lsl #2]
	mov r2, #0x200
	bl MIi_CpuCopy16
	ldr r2, [r6, #4]
	ldr r0, _020433A4 // =VRAMSystem__VRAM_PALETTE_OBJ
	add r1, r4, #0x208
	ldr r0, [r0, r2, lsl #2]
	mov r2, #0x200
	bl MIi_CpuCopy16
	add r3, r6, #0x700
	ldrh r1, [r3, #0xa0]
	add r6, r4, #0x200
	add r0, r4, #8
	strh r1, [r6, #6]
	ldrh ip, [r3, #0xa0]
	add r1, r0, #0x400
	mov r2, #0x200
	strh ip, [r6, #0xa4]
	ldrh r3, [r3, #0xa2]
	strh r3, [r6, #0xa6]
	bl MIi_CpuCopy16
	add r0, r4, #0x208
	add r1, r0, #0x400
	mov r2, #0x200
	bl MIi_CpuCopy16
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0204338C: .word 0x0000FFFF
_02043390: .word 0x00000ADC
_02043394: .word SeaMapPenPalette__Main
_02043398: .word SeaMapPenPalette__Destructor
_0204339C: .word 0x0000080C
_020433A0: .word VRAMSystem__VRAM_PALETTE_BG
_020433A4: .word VRAMSystem__VRAM_PALETTE_OBJ
	arm_func_end SeaMapPenPalette__Create

	arm_func_start SeaMapPenPalette__Func_20433A8
SeaMapPenPalette__Func_20433A8: // 0x020433A8
	ldr ip, _020433B0 // =DestroyTask
	bx ip
	.align 2, 0
_020433B0: .word DestroyTask
	arm_func_end SeaMapPenPalette__Func_20433A8

	arm_func_start SeaMapPenPalette__Func_20433B4
SeaMapPenPalette__Func_20433B4: // 0x020433B4
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	ldr r0, [r0, #4]
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapPenPalette__Func_20433B4

	arm_func_start SeaMapPenPalette__Func_20433C4
SeaMapPenPalette__Func_20433C4: // 0x020433C4
	stmdb sp!, {r4, lr}
	mov r4, r1
	bl GetTaskWork_
	ldr r1, [r0, #4]
	cmp r1, r4
	ldmeqia sp!, {r4, pc}
	add r1, r0, #0x800
	mov r2, #0
	strh r2, [r1, #8]
	str r4, [r0, #4]
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapPenPalette__Func_20433C4

	arm_func_start SeaMapPenPalette__Main
SeaMapPenPalette__Main: // 0x020433F0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	bl GetCurrentTaskWork_
	ldr r1, _02043530 // =0x0000080C
	mov r4, r0
	bl DC_StoreRange
	add r0, r4, #8
	ldr r2, [r4]
	ldr r1, _02043534 // =VRAMSystem__VRAM_PALETTE_BG
	add r0, r0, #0x400
	ldr r1, [r1, r2, lsl #2]
	mov r2, #0x200
	bl RenderCore_DMACopy
	add r0, r4, #0x208
	ldr r2, [r4]
	ldr r1, _02043538 // =VRAMSystem__VRAM_PALETTE_OBJ
	add r0, r0, #0x400
	ldr r1, [r1, r2, lsl #2]
	mov r2, #0x1e0
	bl RenderCore_DMACopy
	ldr r0, [r4, #4]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, pc}
	cmp r0, #1
	beq _02043468
	cmp r0, #2
	beq _020434CC
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
_02043468:
	add r1, r4, #8
	add r0, r1, #0x400
	add r1, r1, #0x400
	mov r2, #0x100
	mov r3, #1
	bl Palette__UnknownFunc10
	add r1, r4, #0x208
	add r0, r1, #0x400
	add r1, r1, #0x400
	mov r2, #0xf0
	mov r3, #1
	bl Palette__UnknownFunc10
	add r0, r4, #0x800
	ldrh r1, [r0, #8]
	add r1, r1, #1
	strh r1, [r0, #8]
	ldrh r1, [r0, #8]
	cmp r1, #8
	addlo sp, sp, #4
	ldmloia sp!, {r3, r4, pc}
	mov r1, #0
	strh r1, [r0, #8]
	add sp, sp, #4
	str r1, [r4, #4]
	ldmia sp!, {r3, r4, pc}
_020434CC:
	add r1, r4, #8
	add r0, r1, #0x400
	mov ip, #1
	mov r2, r0
	mov r3, #0x100
	str ip, [sp]
	bl Palette__UnknownFunc11
	add r1, r4, #0x208
	add r0, r1, #0x400
	mov ip, #1
	mov r2, r0
	mov r3, #0xf0
	str ip, [sp]
	bl Palette__UnknownFunc11
	add r0, r4, #0x800
	ldrh r1, [r0, #8]
	add r1, r1, #1
	strh r1, [r0, #8]
	ldrh r1, [r0, #8]
	cmp r1, #8
	movhi r1, #0
	strhih r1, [r0, #8]
	strhi r1, [r4, #4]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02043530: .word 0x0000080C
_02043534: .word VRAMSystem__VRAM_PALETTE_BG
_02043538: .word VRAMSystem__VRAM_PALETTE_OBJ
	arm_func_end SeaMapPenPalette__Main

	arm_func_start SeaMapPenPalette__Destructor
SeaMapPenPalette__Destructor: // 0x0204353C
	ldr ip, _02043544 // =GetTaskWork_
	bx ip
	.align 2, 0
_02043544: .word GetTaskWork_
	arm_func_end SeaMapPenPalette__Destructor