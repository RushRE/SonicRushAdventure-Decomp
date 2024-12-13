	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__VRAM_PALETTE_OBJ

	.text

	arm_func_start SeaMapCoralCaveIcon__Create
SeaMapCoralCaveIcon__Create: // 0x02049764
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x1c
	mov r7, r0
	mov r6, r1
	bl SeaMapManager__GetWork
	ldr r1, _02049880 // =0x00000111
	mov r5, r0
	mov r2, #0
	str r1, [sp]
	mov r4, #1
	str r4, [sp, #4]
	mov r4, #0x78
	ldr r0, _02049884 // =SeaMapCoralCaveIcon__Main
	ldr r1, _02049888 // =SeaMapCoralCaveIcon__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r8, r0
	bl SeaMapEventManager__GetWork
	str r8, [r0, #0x258]
	mov r0, r8
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x78
	bl MIi_CpuClear16
	bl SaveGame__GetGameProgress
	cmp r0, #0xe
	ldrge r0, _0204988C // =SeaMapCoralCaveIcon__State_20499A0
	mov r1, r8
	ldrlt r0, _02049890 // =SeaMapCoralCaveIcon__State_2049920
	mov r2, r7
	str r0, [r4, #0x74]
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
	ldr r0, _02049894 // =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, #0xd
	ldr r2, [r0, r2, lsl #2]
	add r0, r4, #0x10
	str r2, [sp, #0x10]
	str r3, [sp, #0x14]
	str r1, [sp, #0x18]
	ldrh r2, [r7, #0]
	ldr r1, [r5, #0x15c]
	ldr r3, _02049898 // =0x00000804
	bl AnimatorSprite__Init
	ldrsh r1, [r6, #2]
	mov r0, r4
	strh r1, [r4, #0x18]
	ldrsh r1, [r6, #4]
	strh r1, [r4, #0x1a]
	ldrh r1, [r7, #2]
	strh r1, [r4, #0x60]
	bl SeaMapEventManager__SetObjectAsActive
	mov r0, r4
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02049880: .word 0x00000111
_02049884: .word SeaMapCoralCaveIcon__Main
_02049888: .word SeaMapCoralCaveIcon__Destructor
_0204988C: .word SeaMapCoralCaveIcon__State_20499A0
_02049890: .word SeaMapCoralCaveIcon__State_2049920
_02049894: .word VRAMSystem__VRAM_PALETTE_OBJ
_02049898: .word 0x00000804
	arm_func_end SeaMapCoralCaveIcon__Create

	arm_func_start SeaMapCoralCaveIcon__Main
SeaMapCoralCaveIcon__Main: // 0x0204989C
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #4]
	add r0, r4, #0xc
	add r1, r1, #4
	bl SeaMapEventManager__ObjectInBounds
	cmp r0, #0
	bne _020498C8
	bl DestroyCurrentTask
	ldmia sp!, {r4, pc}
_020498C8:
	ldr r1, [r4, #0x74]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapCoralCaveIcon__Main

	arm_func_start SeaMapCoralCaveIcon__Destructor
SeaMapCoralCaveIcon__Destructor: // 0x020498D8
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x10
	bl AnimatorSprite__Release
	mov r0, r4
	bl SeaMapEventManager__SetObjectAsInactive
	mov r0, r4
	bl SeaMapEventManager__DestroyObject
	ldr r0, _0204991C // =SeaMapEventManager__Singleton
	ldr r0, [r0, #0]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl SeaMapEventManager__GetWork
	mov r1, #0
	str r1, [r0, #0x258]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0204991C: .word SeaMapEventManager__Singleton
	arm_func_end SeaMapCoralCaveIcon__Destructor

	arm_func_start SeaMapCoralCaveIcon__State_2049920
SeaMapCoralCaveIcon__State_2049920: // 0x02049920
	bx lr
	arm_func_end SeaMapCoralCaveIcon__State_2049920

	arm_func_start SeaMapCoralCaveIcon__State_2049924
SeaMapCoralCaveIcon__State_2049924: // 0x02049924
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x10
	mov r1, #0x81
	bl AnimatorSprite__SetAnimation
	ldr r0, [r4, #0x4c]
	ldr r1, _02049958 // =SeaMapCoralCaveIcon__State_204995C
	bic r0, r0, #4
	str r0, [r4, #0x4c]
	mov r0, r4
	str r1, [r4, #0x74]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02049958: .word SeaMapCoralCaveIcon__State_204995C
	arm_func_end SeaMapCoralCaveIcon__State_2049924

	arm_func_start SeaMapCoralCaveIcon__State_204995C
SeaMapCoralCaveIcon__State_204995C: // 0x0204995C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xc
	add r1, r4, #0x18
	bl SeaMapEventManager__Func_20474FC
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x10
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x10
	bl AnimatorSprite__DrawFrame
	ldr r0, [r4, #0x4c]
	tst r0, #0x40000000
	ldrne r0, _0204999C // =SeaMapCoralCaveIcon__State_20499A0
	strne r0, [r4, #0x74]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0204999C: .word SeaMapCoralCaveIcon__State_20499A0
	arm_func_end SeaMapCoralCaveIcon__State_204995C

	arm_func_start SeaMapCoralCaveIcon__State_20499A0
SeaMapCoralCaveIcon__State_20499A0: // 0x020499A0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x10
	mov r1, #0x80
	bl AnimatorSprite__SetAnimation
	ldr r0, [r4, #0x4c]
	ldr r1, _020499D4 // =SeaMapCoralCaveIcon__State_20499D8
	orr r0, r0, #4
	str r0, [r4, #0x4c]
	mov r0, r4
	str r1, [r4, #0x74]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_020499D4: .word SeaMapCoralCaveIcon__State_20499D8
	arm_func_end SeaMapCoralCaveIcon__State_20499A0

	arm_func_start SeaMapCoralCaveIcon__State_20499D8
SeaMapCoralCaveIcon__State_20499D8: // 0x020499D8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0xc
	add r1, r5, #0x18
	bl SeaMapEventManager__Func_20474FC
	mov r1, #0
	mov r2, r1
	add r0, r5, #0x10
	bl AnimatorSprite__ProcessAnimation
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _02049A18
	add r0, r5, #0x10
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, r4, r5, pc}
_02049A18:
	bl SeaMapManager__GetZoomOutScale
	mov r4, r0
	bl SeaMapManager__GetZoomOutScale
	mov r2, r0
	mov r1, r4
	add r0, r5, #0x10
	mov r3, #0
	bl AnimatorSprite__DrawFrameRotoZoom
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapCoralCaveIcon__State_20499D8