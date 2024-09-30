	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__VRAM_PALETTE_OBJ

	.text

	arm_func_start SeaMapSparkles__Create
SeaMapSparkles__Create: // 0x02049E6C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x80
	mov r5, r0
	mov r4, r1
	bl SeaMapManager__GetWork
	ldr r1, _0204A024 // =0x00000111
	mov r7, r0
	str r1, [sp]
	mov r0, #1
	mov r2, #0
	str r0, [sp, #4]
	ldr r6, _0204A028 // =0x00001DB4
	ldr r0, _0204A02C // =SeaMapSparkles__Main
	ldr r1, _0204A030 // =SeaMapSparkles__Destructor
	mov r3, r2
	str r6, [sp, #8]
	bl TaskCreate_
	mov r8, r0
	bl GetTaskWork_
	mov r6, r0
	ldr r2, _0204A028 // =0x00001DB4
	mov r0, #0
	mov r1, r6
	bl MIi_CpuClear16
	mov r1, r8
	mov r2, r5
	mov r0, r6
	mov r3, r4
	bl SeaMapEventManager__InitMapObject
	ldr r0, [r7, #0x158]
	str r0, [r6, #0x10]
	ldrh r0, [r4, #0]
	cmp r0, #0xc
	add r0, r6, #0x1000
	bne _02049F20
	mov r1, #0x3800
	str r1, [r0, #0xda4]
	add r0, r6, #0x1d00
	mov r1, #0x14
	strh r1, [r0, #0xa8]
	mov r1, #4
	strh r1, [r0, #0xae]
	mov r1, #0xf
	strh r1, [r0, #0xaa]
	b _02049F40
_02049F20:
	mov r1, #0x2800
	str r1, [r0, #0xda4]
	add r0, r6, #0x1d00
	mov r2, #0xf
	strh r2, [r0, #0xa8]
	mov r1, #4
	strh r1, [r0, #0xae]
	strh r2, [r0, #0xaa]
_02049F40:
	mov r1, #0x4b
	strh r1, [r0, #0xac]
	mov r0, r4
	bl SeaMapEventManager__GetObjectType
	cmp r0, #0xc
	add r4, r6, #0x1d00
	ldreq r10, _0204A034 // =0x0210FF8E
	ldrh r0, [r4, #0xae]
	ldrne r10, _0204A038 // =0x0210FF86
	mov r8, #0
	cmp r0, #0
	ble _0204A010
	mov r5, r8
	add r11, sp, #0x1c
_02049F78:
	mov r0, r8, lsl #1
	ldrh r9, [r10, r0]
	ldr r0, [r7, #0x15c]
	mov r1, r9
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	ldr r0, [r6, #0x10]
	bl VRAMSystem__AllocSpriteVram
	add r1, r6, r8, lsl #2
	add r1, r1, #0x1000
	str r0, [r1, #0x914]
	ldr r3, [r6, #0x10]
	mov r2, r9
	stmia sp, {r3, r5}
	ldr r1, [r1, #0x914]
	mov r0, r11
	str r1, [sp, #8]
	str r5, [sp, #0xc]
	ldr r9, [r6, #0x10]
	ldr r1, _0204A03C // =VRAMSystem__VRAM_PALETTE_OBJ
	mov r3, r5
	ldr r1, [r1, r9, lsl #2]
	str r1, [sp, #0x10]
	str r5, [sp, #0x14]
	mov r1, #8
	str r1, [sp, #0x18]
	ldr r1, [r7, #0x15c]
	bl AnimatorSprite__Init
	mov r0, #5
	mov r1, #0
	strh r0, [sp, #0x6c]
	mov r0, r11
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldrh r0, [r4, #0xae]
	add r8, r8, #1
	cmp r8, r0
	blt _02049F78
_0204A010:
	mov r0, r6
	bl SeaMapEventManager__SetObjectAsActive
	mov r0, r6
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0204A024: .word 0x00000111
_0204A028: .word 0x00001DB4
_0204A02C: .word SeaMapSparkles__Main
_0204A030: .word SeaMapSparkles__Destructor
_0204A034: .word 0x0210FF8E
_0204A038: .word 0x0210FF86
_0204A03C: .word VRAMSystem__VRAM_PALETTE_OBJ
	arm_func_end SeaMapSparkles__Create

	arm_func_start SeaMapSparkles__Main
SeaMapSparkles__Main: // 0x0204A040
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x34
	bl GetCurrentTaskWork_
	mov r4, r0
	bl RenderCore_GetTargetVBlankCount
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	movs r0, r0, lsr #0x10
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x1c]
	beq _0204A380
_0204A074:
	add r6, r4, #0x1d00
	ldrh r0, [r6, #0xb0]
	add r0, r0, #1
	strh r0, [r6, #0xb0]
	ldrh r1, [r6, #0xb0]
	ldrh r0, [r6, #0xac]
	cmp r1, r0
	blo _0204A0A0
	bl DestroyCurrentTask
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0204A0A0:
	ldrh r0, [r6, #0xaa]
	cmp r1, r0
	bhs _0204A360
	ldrh r1, [r6, #0xb2]
	sub r0, r1, #1
	strh r0, [r6, #0xb2]
	cmp r1, #0
	bne _0204A360
	mov r0, #0
	str r0, [sp, #0x24]
	add r0, r4, #0x14
	str r0, [sp, #0x28]
	add r0, r4, #0x1000
	ldr r11, _0204A4E4 // =_mt_math_rand
	str r0, [sp, #0x2c]
_0204A0DC:
	bl SeaMapManager__GetWork
	str r0, [sp, #0x20]
	mov r5, #0
_0204A0E8:
	add r0, r4, r5, lsl #1
	add r0, r0, #0x1c00
	ldrh r0, [r0, #0xa4]
	cmp r0, #0
	beq _0204A108
	add r5, r5, #1
	cmp r5, #0x40
	blt _0204A0E8
_0204A108:
	ldr r2, [r11, #0]
	ldr r1, _0204A4E8 // =0x00196225
	ldr r0, _0204A4EC // =0x3C6EF35F
	mla r0, r2, r1, r0
	str r0, [r11]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	ldrh r1, [r6, #0xae]
	mov r0, r0, lsr #0x10
	bl FX_ModS32
	add r2, r4, r5, lsl #1
	add r1, r2, #0x1d00
	strh r0, [r1, #0x24]
	ldr r7, [r11, #0]
	ldr r1, _0204A4E8 // =0x00196225
	ldr r0, _0204A4EC // =0x3C6EF35F
	add r3, r4, r5, lsl #3
	mla r1, r7, r1, r0
	add r0, r3, #0x1000
	mov r3, r1, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, lsl #0x1c
	mov r3, r3, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r9, r3, lsr #0x10
	ldr r7, _0204A4E8 // =0x00196225
	ldr r3, _0204A4EC // =0x3C6EF35F
	add r2, r2, #0x1c00
	mla r3, r1, r7, r3
	mov r1, r3, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0xf
	add r1, r1, #8
	mov r8, r1, lsl #0xc
	mov r1, r9, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	str r3, [r11]
	mov r10, r1, lsl #1
	ldr r1, [r4, #8]
	mov r3, r10, lsl #1
	ldrsh r7, [r1, #2]
	ldr r1, _0204A4F0 // =FX_SinCosTable_
	add r1, r1, r10, lsl #1
	ldrsh r10, [r1, #2]
	add r1, r4, r5, lsl #2
	add r1, r1, #0x1000
	smull lr, ip, r10, r8
	adds lr, lr, #0x800
	adc r10, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r10, lsl #20
	add r7, ip, r7, lsl #12
	str r7, [r0, #0x924]
	ldr r7, _0204A4F0 // =FX_SinCosTable_
	ldrsh r3, [r7, r3]
	ldr r7, [r4, #8]
	smull r10, r8, r3, r8
	ldrsh r3, [r7, #4]
	adds r10, r10, #0x800
	adc r7, r8, #0
	mov r8, r10, lsr #0xc
	orr r8, r8, r7, lsl #20
	add r3, r8, r3, lsl #12
	str r3, [r0, #0x928]
	ldr r0, [sp, #0x2c]
	ldr r0, [r0, #0xda4]
	str r0, [r1, #0xb24]
	strh r9, [r2, #0x24]
	ldrh r0, [r6, #0xa8]
	strh r0, [r2, #0xa4]
	ldrh r0, [r6, #0xb0]
	ldrh r1, [r6, #0xaa]
	mov r0, r0, lsl #0xc
	mov r1, r1, lsl #0xc
	bl FX_Div
	cmp r0, #0x1000
	movgt r0, #0x1000
	mov r2, r0, asr #0x1f
	mov r7, r2, lsl #0xb
	add r1, r4, r5, lsl #2
	mov r2, #0x800
	add r3, r1, #0x1000
	orr r7, r7, r0, lsr #21
	adds r8, r2, r0, lsl #11
	adc r2, r7, #0
	mov r7, r8, lsr #0xc
	ldr r1, [r3, #0xb24]
	orr r7, r7, r2, lsl #20
	sub r1, r1, r7
	str r1, [r3, #0xb24]
	add r1, r4, r5, lsl #1
	add r2, r1, #0x1c00
	mov r1, #0xa
	mul r1, r0, r1
	ldrh r3, [r2, #0xa4]
	add r0, r3, r1, asr #12
	strh r0, [r2, #0xa4]
	ldr r0, [sp, #0x28]
	mov r1, #0x64
	mla r7, r5, r1, r0
	ldr r0, [r4, #8]
	bl SeaMapEventManager__GetObjectType
	cmp r0, #0xc
	add r0, r4, r5, lsl #1
	add r0, r0, #0x1d00
	bne _0204A2CC
	ldrh r3, [r0, #0x24]
	ldr r0, _0204A4F4 // =0x0210FF8E
	mov r1, r3, lsl #1
	b _0204A2D8
_0204A2CC:
	ldrh r3, [r0, #0x24]
	ldr r0, _0204A4F8 // =0x0210FF86
	mov r1, r3, lsl #1
_0204A2D8:
	ldrh r2, [r0, r1]
	ldr r1, [r4, #0x10]
	add r0, r4, r3, lsl #2
	add r3, r0, #0x1000
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	ldr r1, [r3, #0x914]
	mov r0, r7
	str r1, [sp, #8]
	mov r1, #0
	str r1, [sp, #0xc]
	ldr r5, [r4, #0x10]
	ldr r1, _0204A4FC // =VRAMSystem__VRAM_PALETTE_OBJ
	mov r3, #0x1c
	ldr r1, [r1, r5, lsl #2]
	str r1, [sp, #0x10]
	mov r1, #0
	str r1, [sp, #0x14]
	mov r1, #8
	str r1, [sp, #0x18]
	ldr r1, [sp, #0x20]
	ldr r1, [r1, #0x15c]
	bl AnimatorSprite__Init
	mov r0, #5
	strh r0, [r7, #0x50]
	ldr r0, [sp, #0x24]
	add r0, r0, #1
	str r0, [sp, #0x24]
	cmp r0, #2
	blt _0204A0DC
	add r0, r4, #0x1d00
	mov r1, #0
	strh r1, [r0, #0xb2]
_0204A360:
	ldr r0, [sp, #0x1c]
	sub r0, r0, #1
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #0x1c]
	cmp r0, #0
	mov r0, r1, lsr #0x10
	str r0, [sp, #0x1c]
	bne _0204A074
_0204A380:
	ldr r6, _0204A500 // =0x00000199
	add r7, r4, #0x14
	mov r8, #0
	add r5, r6, #0xcd
_0204A390:
	add r0, r4, r8, lsl #1
	add r0, r0, #0x1c00
	ldrh r1, [r0, #0xa4]
	cmp r1, #0
	beq _0204A468
	sub r2, r1, #1
	add r1, r4, r8, lsl #2
	strh r2, [r0, #0xa4]
	add r0, r1, #0x1000
	ldr r1, [r0, #0xb24]
	sub r1, r1, r5
	str r1, [r0, #0xb24]
	cmp r1, r6
	strlt r6, [r0, #0xb24]
	add r0, r4, r8, lsl #1
	add r2, r0, #0x1c00
	ldrh r1, [r2, #0x24]
	add r0, r4, r8, lsl #2
	add r3, r0, #0x1000
	ldr r0, _0204A4F0 // =FX_SinCosTable_
	mov r1, r1, asr #4
	add r0, r0, r1, lsl #2
	ldrsh r10, [r0, #2]
	ldr r11, [r3, #0xb24]
	add r0, r4, r8, lsl #3
	smull ip, r11, r10, r11
	adds r10, ip, #0x800
	add r9, r0, #0x1000
	ldr r1, [r9, #0x924]
	adc r11, r11, #0
	mov r10, r10, lsr #0xc
	orr r10, r10, r11, lsl #20
	add r1, r1, r10
	str r1, [r9, #0x924]
	ldrh r1, [r2, #0x24]
	ldr r11, [r3, #0xb24]
	mov ip, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #2
	ldr r1, _0204A4F0 // =FX_SinCosTable_
	ldr r3, [r9, #0x928]
	ldrsh r10, [r1, r2]
	mov r1, ip
	mov r2, ip
	smull ip, r11, r10, r11
	adds r10, ip, #0x800
	mov ip, r2
	adc r11, r11, ip
	mov r10, r10, lsr #0xc
	orr r10, r10, r11, lsl #20
	add r3, r3, r10
	mov r0, r7
	str r3, [r9, #0x928]
	bl SeaMapEventManager__Func_20471B8
_0204A468:
	add r8, r8, #1
	cmp r8, #0x40
	add r7, r7, #0x64
	blt _0204A390
	add r5, r4, #0x14
	mov r6, #0
	add r7, sp, #0x30
_0204A484:
	add r0, r4, r6, lsl #1
	add r0, r0, #0x1c00
	ldrh r0, [r0, #0xa4]
	cmp r0, #0
	beq _0204A4CC
	add r0, r4, r6, lsl #3
	add r1, r0, #0x1000
	ldr r2, [r1, #0x924]
	mov r0, r7
	mov r2, r2, asr #0xc
	strh r2, [sp, #0x30]
	ldr r2, [r1, #0x928]
	add r1, r5, #8
	mov r2, r2, asr #0xc
	strh r2, [sp, #0x32]
	bl SeaMapEventManager__Func_20474FC
	mov r0, r5
	bl AnimatorSprite__DrawFrame
_0204A4CC:
	add r6, r6, #1
	cmp r6, #0x40
	add r5, r5, #0x64
	blt _0204A484
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0204A4E4: .word _mt_math_rand
_0204A4E8: .word 0x00196225
_0204A4EC: .word 0x3C6EF35F
_0204A4F0: .word FX_SinCosTable_
_0204A4F4: .word 0x0210FF8E
_0204A4F8: .word 0x0210FF86
_0204A4FC: .word VRAMSystem__VRAM_PALETTE_OBJ
_0204A500: .word 0x00000199
	arm_func_end SeaMapSparkles__Main

	arm_func_start SeaMapSparkles__Destructor
SeaMapSparkles__Destructor: // 0x0204A504
	stmdb sp!, {r4, r5, r6, lr}
	bl GetTaskWork_
	mov r5, r0
	add r4, r5, #0x1d00
	ldrh r0, [r4, #0xae]
	mov r6, #0
	cmp r0, #0
	ble _0204A548
_0204A524:
	add r0, r5, r6, lsl #2
	add r1, r0, #0x1000
	ldr r0, [r5, #0x10]
	ldr r1, [r1, #0x914]
	bl VRAMSystem__FreeSpriteVram
	ldrh r0, [r4, #0xae]
	add r6, r6, #1
	cmp r6, r0
	blt _0204A524
_0204A548:
	mov r0, r5
	bl SeaMapEventManager__SetObjectAsInactive
	mov r0, r5
	bl SeaMapEventManager__DestroyObject
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SeaMapSparkles__Destructor