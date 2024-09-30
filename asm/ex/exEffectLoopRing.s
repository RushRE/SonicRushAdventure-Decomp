	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start ovl09_2168070
ovl09_2168070: // 0x02168070
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ovl09_21636BC
	ldr r0, _02168104 // =0x021765A4
	add r1, r4, #0x20
	mov r2, #0x104
	bl MI_CpuCopy8
	mov r0, #7
	strh r0, [r4, #0x1c]
	mov r0, #4
	strb r0, [r4]
	ldrb r2, [r4, #4]
	mov r1, #0x3c000
	mov r0, #0x600
	orr r2, r2, #8
	strb r2, [r4, #4]
	str r1, [r4, #0x134]
	str r0, [r4, #0x138]
	str r0, [r4, #0x13c]
	mov r0, #0x1000
	str r0, [r4, #0x140]
	ldrb r2, [r4, #0x150]
	mov r1, #0x4000
	mov r0, #0
	bic r2, r2, #3
	strb r2, [r4, #0x150]
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	str r0, [r4, #0x14]
	add r0, r4, #0x12c
	ldr r1, _02168108 // =0x02176590
	str r0, [r4, #0x18]
	ldrsh r2, [r1, #0]
	mov r0, #1
	add r2, r2, #1
	strh r2, [r1]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02168104: .word 0x021765A4
_02168108: .word 0x02176590
	arm_func_end ovl09_2168070

	arm_func_start ovl09_216810C
ovl09_216810C: // 0x0216810C
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r6, r0
	strh r1, [r6, #0x1c]
	ldr r0, _0216818C // =0x02176590
	mov r1, #1
	ldr r0, [r0, #0x10]
	bl Sprite__GetTextureSizeFromAnim
	ldr r1, _0216818C // =0x02176590
	mov r4, r0
	ldr r0, [r1, #0x10]
	mov r1, #1
	bl Sprite__GetPaletteSizeFromAnim
	mov r5, r0
	mov r0, r4
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r4, r0
	mov r0, r5
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #4
	stmia sp, {r1, r4}
	str r0, [sp, #8]
	ldr r2, _0216818C // =0x02176590
	ldrh r3, [r6, #0x1c]
	ldr r2, [r2, #0x10]
	add r0, r6, #0x20
	mov r1, #0
	bl AnimatorSprite3D__Init
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0216818C: .word 0x02176590
	arm_func_end ovl09_216810C

	arm_func_start ovl09_2168190
ovl09_2168190: // 0x02168190
	stmdb sp!, {r3, lr}
	ldrh r1, [r0, #0x1c]
	cmp r1, #8
	bne _021681A8
	add r0, r0, #0x20
	bl AnimatorSprite3D__Release
_021681A8:
	ldr r0, _021681BC // =0x02176590
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021681BC: .word 0x02176590
	arm_func_end ovl09_2168190

	arm_func_start exEffectLoopRingTask__Main
exEffectLoopRingTask__Main: // 0x021681C0
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	bl GetExTaskWorkCurrent_
	mov r6, #0
	mov r0, r6
	bl ovl09_21733D4
	ldr r1, _02168298 // =0x02176590
	str r0, [r1, #0x10]
	bl VRAMSystem__GetPaletteUnknown
	add r6, r0, #0
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _02168298 // =0x02176590
	add r6, r6, r0
	ldr r0, [r1, #0x10]
	mov r1, #1
	bl Sprite__GetTextureSizeFromAnim
	ldr r1, _02168298 // =0x02176590
	mov r4, r0
	ldr r0, [r1, #0x10]
	mov r1, #1
	bl Sprite__GetPaletteSizeFromAnim
	mov r5, r0
	add r0, r4, r5
	cmp r6, r0
	addlo sp, sp, #0xc
	ldmloia sp!, {r3, r4, r5, r6, pc}
	mov r0, r4
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r4, r0
	mov r0, r5
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #4
	stmia sp, {r1, r4}
	str r0, [sp, #8]
	ldr r1, _02168298 // =0x02176590
	ldr r0, _0216829C // =0x021765A4
	ldr r2, [r1, #0x10]
	mov r1, #0
	mov r3, #7
	bl AnimatorSprite3D__Init
	mov r1, #0
	ldr r0, _0216829C // =0x021765A4
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	bl GetCurrentTask
	ldr r1, _02168298 // =0x02176590
	str r0, [r1, #4]
	bl GetExTaskCurrent
	ldr r1, _021682A0 // =ovl09_21682F4
	str r1, [r0]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02168298: .word 0x02176590
_0216829C: .word 0x021765A4
_021682A0: .word ovl09_21682F4
	arm_func_end exEffectLoopRingTask__Main

	arm_func_start exEffectLoopRingTask__Func8
exEffectLoopRingTask__Func8: // 0x021682A4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl ovl09_2172AE0
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _021682C8 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021682C8: .word ExTask_State_Destroy
	arm_func_end exEffectLoopRingTask__Func8

	arm_func_start exEffectLoopRingTask__Destructor
exEffectLoopRingTask__Destructor: // 0x021682CC
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, _021682EC // =0x021765A4
	bl AnimatorSprite3D__Release
	ldr r0, _021682F0 // =0x02176590
	mov r1, #0
	str r1, [r0, #4]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021682EC: .word 0x021765A4
_021682F0: .word 0x02176590
	arm_func_end exEffectLoopRingTask__Destructor

	arm_func_start ovl09_21682F4
ovl09_21682F4: // 0x021682F4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, _0216832C // =0x02176590
	ldrsh r0, [r0, #0]
	cmp r0, #0
	beq _0216831C
	mov r1, #0
	ldr r0, _02168330 // =0x021765A4
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
_0216831C:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216832C: .word 0x02176590
_02168330: .word 0x021765A4
	arm_func_end ovl09_21682F4

	arm_func_start exEffectLoopRingTask__Create
exEffectLoopRingTask__Create: // 0x02168334
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x2a0
	ldr r0, _0216839C // =aExeffectloopri
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _021683A0 // =exEffectLoopRingTask__Main
	ldr r1, _021683A4 // =exEffectLoopRingTask__Destructor
	mov r2, #0x1800
	mov r3, #3
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r1, #0
	mov r2, #0x2a0
	bl MI_CpuFill8
	mov r0, r4
	bl GetExTask
	ldr r1, _021683A8 // =exEffectLoopRingTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216839C: .word aExeffectloopri
_021683A0: .word exEffectLoopRingTask__Main
_021683A4: .word exEffectLoopRingTask__Destructor
_021683A8: .word exEffectLoopRingTask__Func8
	arm_func_end exEffectLoopRingTask__Create