	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__VRAM_PALETTE_OBJ

	.text

	arm_func_start SeaMapSkyBabylonIcon__Create
SeaMapSkyBabylonIcon__Create: // 0x02049A3C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x1c
	mov r7, r0
	mov r6, r1
	bl SeaMapManager__GetWork
	ldr r1, _02049BBC // =0x00000111
	mov r5, r0
	mov r2, #0
	str r1, [sp]
	mov r4, #1
	str r4, [sp, #4]
	mov r4, #0xe0
	ldr r0, _02049BC0 // =SeaMapSkyBabylonIcon__Main
	ldr r1, _02049BC4 // =SeaMapSkyBabylonIcon__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r8, r0
	bl SeaMapEventManager__GetWork
	str r8, [r0, #0x25c]
	mov r0, r8
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0xe0
	bl MIi_CpuClear16
	bl SaveGame__GetUnknownProgress2
	cmp r0, #4
	ldrge r0, _02049BC8 // =SeaMapSkyBabylonIcon__Func_2049D54
	mov r1, r8
	ldrlt r0, _02049BCC // =SeaMapSkyBabylonIcon__Func_2049C70
	mov r2, r7
	str r0, [r4, #0xdc]
	mov r0, r4
	mov r3, r6
	bl SeaMapEventManager__InitMapObject
	ldrh r1, [r7, #0]
	ldr r0, [r5, #0x15c]
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	ldr r0, [r5, #0x158]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0x158]
	mov r3, #0
	stmia sp, {r1, r3}
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr r2, [r5, #0x158]
	ldr r0, _02049BD0 // =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, #0xd
	ldr r2, [r0, r2, lsl #2]
	add r0, r4, #0x10
	str r2, [sp, #0x10]
	str r3, [sp, #0x14]
	str r1, [sp, #0x18]
	ldrh r2, [r7, #0]
	ldr r1, [r5, #0x15c]
	ldr r3, _02049BD4 // =0x00000804
	bl AnimatorSprite__Init
	ldrsh r0, [r6, #2]
	mov r1, #0x84
	strh r0, [r4, #0x18]
	ldrsh r0, [r6, #4]
	strh r0, [r4, #0x1a]
	ldrh r0, [r7, #2]
	strh r0, [r4, #0x60]
	ldr r0, [r5, #0x15c]
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	ldr r0, [r5, #0x158]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [r5, #0x158]
	mov r3, #0
	stmia sp, {r1, r3}
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr r2, [r5, #0x158]
	ldr r0, _02049BD0 // =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, #0xf
	ldr r2, [r0, r2, lsl #2]
	add r0, r4, #0x74
	str r2, [sp, #0x10]
	str r3, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r1, [r5, #0x15c]
	mov r2, #0x84
	mov r3, #0x800
	bl AnimatorSprite__Init
	mov r0, #9
	strh r0, [r4, #0xc4]
	mov r0, r4
	bl SeaMapEventManager__SetObjectAsActive
	mov r0, r4
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02049BBC: .word 0x00000111
_02049BC0: .word SeaMapSkyBabylonIcon__Main
_02049BC4: .word SeaMapSkyBabylonIcon__Destructor
_02049BC8: .word SeaMapSkyBabylonIcon__Func_2049D54
_02049BCC: .word SeaMapSkyBabylonIcon__Func_2049C70
_02049BD0: .word VRAMSystem__VRAM_PALETTE_OBJ
_02049BD4: .word 0x00000804
	arm_func_end SeaMapSkyBabylonIcon__Create

	arm_func_start SeaMapSkyBabylonIcon__Main
SeaMapSkyBabylonIcon__Main: // 0x02049BD8
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #4]
	add r0, r4, #0xc
	add r1, r1, #4
	bl SeaMapEventManager__ObjectInBounds
	cmp r0, #0
	bne _02049C04
	bl DestroyCurrentTask
	ldmia sp!, {r4, pc}
_02049C04:
	ldrh r1, [r4, #0xd8]
	mov r0, r4
	add r1, r1, #0xb6
	strh r1, [r4, #0xd8]
	ldr r1, [r4, #0xdc]
	blx r1
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapSkyBabylonIcon__Main

	arm_func_start SeaMapSkyBabylonIcon__Destructor
SeaMapSkyBabylonIcon__Destructor: // 0x02049C20
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x10
	bl AnimatorSprite__Release
	add r0, r4, #0x74
	bl AnimatorSprite__Release
	mov r0, r4
	bl SeaMapEventManager__SetObjectAsInactive
	mov r0, r4
	bl SeaMapEventManager__DestroyObject
	ldr r0, _02049C6C // =0x0213419C
	ldr r0, [r0, #0]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl SeaMapEventManager__GetWork
	mov r1, #0
	str r1, [r0, #0x25c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02049C6C: .word 0x0213419C
	arm_func_end SeaMapSkyBabylonIcon__Destructor

	arm_func_start SeaMapSkyBabylonIcon__Func_2049C70
SeaMapSkyBabylonIcon__Func_2049C70: // 0x02049C70
	bx lr
	arm_func_end SeaMapSkyBabylonIcon__Func_2049C70

	arm_func_start SeaMapSkyBabylonIcon__Func_2049C74
SeaMapSkyBabylonIcon__Func_2049C74: // 0x02049C74
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x10
	mov r1, #0x83
	bl AnimatorSprite__SetAnimation
	ldr r0, [r4, #0x4c]
	ldr r1, _02049CA8 // =SeaMapSkyBabylonIcon__Func_2049CAC
	bic r0, r0, #4
	str r0, [r4, #0x4c]
	mov r0, r4
	str r1, [r4, #0xdc]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02049CA8: .word SeaMapSkyBabylonIcon__Func_2049CAC
	arm_func_end SeaMapSkyBabylonIcon__Func_2049C74

	arm_func_start SeaMapSkyBabylonIcon__Func_2049CAC
SeaMapSkyBabylonIcon__Func_2049CAC: // 0x02049CAC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldrh r2, [r4, #0xd8]
	ldrsh r0, [r4, #0xc]
	ldr r1, _02049D4C // =FX_SinCosTable_
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r2, [r1, r2]
	strh r0, [sp]
	ldrsh r1, [r4, #0xe]
	add r0, r2, r2, lsl #1
	mov r0, r0, lsl #4
	add r2, r1, r0, asr #16
	add r0, sp, #0
	add r1, r4, #0x18
	strh r2, [sp, #2]
	bl SeaMapEventManager__Func_20474FC
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x10
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x10
	bl AnimatorSprite__DrawFrame
	ldrsh r0, [r4, #0x18]
	mov r1, #0
	mov r2, r1
	strh r0, [r4, #0x7c]
	ldrsh r3, [r4, #0x1a]
	add r0, r4, #0x74
	strh r3, [r4, #0x7e]
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x74
	bl AnimatorSprite__DrawFrame
	ldr r0, [r4, #0x4c]
	tst r0, #0x40000000
	ldrne r0, _02049D50 // =SeaMapSkyBabylonIcon__Func_2049D54
	strne r0, [r4, #0xdc]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02049D4C: .word FX_SinCosTable_
_02049D50: .word SeaMapSkyBabylonIcon__Func_2049D54
	arm_func_end SeaMapSkyBabylonIcon__Func_2049CAC

	arm_func_start SeaMapSkyBabylonIcon__Func_2049D54
SeaMapSkyBabylonIcon__Func_2049D54: // 0x02049D54
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x10
	mov r1, #0x82
	bl AnimatorSprite__SetAnimation
	ldr r0, [r4, #0x4c]
	ldr r1, _02049D88 // =SeaMapSkyBabylonIcon__Func_2049D8C
	orr r0, r0, #4
	str r0, [r4, #0x4c]
	mov r0, r4
	str r1, [r4, #0xdc]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02049D88: .word SeaMapSkyBabylonIcon__Func_2049D8C
	arm_func_end SeaMapSkyBabylonIcon__Func_2049D54

	arm_func_start SeaMapSkyBabylonIcon__Func_2049D8C
SeaMapSkyBabylonIcon__Func_2049D8C: // 0x02049D8C
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldrh r2, [r4, #0xd8]
	ldrsh r0, [r4, #0xc]
	ldr r1, _02049E68 // =FX_SinCosTable_
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r2, [r1, r2]
	strh r0, [sp]
	ldrsh r1, [r4, #0xe]
	add r0, r2, r2, lsl #1
	mov r0, r0, lsl #4
	add r2, r1, r0, asr #16
	add r0, sp, #0
	add r1, r4, #0x18
	strh r2, [sp, #2]
	bl SeaMapEventManager__Func_20474FC
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x10
	bl AnimatorSprite__ProcessAnimation
	ldrsh r0, [r4, #0x18]
	mov r1, #0
	mov r2, r1
	strh r0, [r4, #0x7c]
	ldrsh r3, [r4, #0x1a]
	add r0, r4, #0x74
	strh r3, [r4, #0x7e]
	bl AnimatorSprite__ProcessAnimation
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02049E24
	add r0, r4, #0x10
	bl AnimatorSprite__DrawFrame
	add r0, r4, #0x74
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, r4, r5, pc}
_02049E24:
	bl SeaMapManager__GetZoomOutScale
	mov r5, r0
	bl SeaMapManager__GetZoomOutScale
	mov r2, r0
	mov r1, r5
	add r0, r4, #0x10
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
	bl SeaMapManager__GetZoomOutScale
	mov r5, r0
	bl SeaMapManager__GetZoomOutScale
	mov r1, r5
	mov r2, r0
	add r0, r4, #0x74
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02049E68: .word FX_SinCosTable_
	arm_func_end SeaMapSkyBabylonIcon__Func_2049D8C