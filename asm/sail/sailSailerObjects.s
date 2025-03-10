	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailSailerBird__Create
SailSailerBird__Create: // 0x02179678
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r6, r0
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #0x5c
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _021797E4 // =aSbBirdNsbmd_1
	mov r0, r5
	mov r3, r1
	bl ObjAction3dNNModelLoad
	mov r0, r5
	bl SailObject__InitCommon
	mov r0, r5
	mov r1, r6
	bl SailObject__InitFromMapObject
	ldr r1, [r5, #0x48]
	mov r0, #0x1000
	sub r1, r1, #0x6000
	str r1, [r5, #0x48]
	ldr r1, [r4, #0x174]
	sub r1, r1, #0x6000
	str r1, [r4, #0x174]
	str r0, [r4, #0x120]
	str r0, [r4, #0x11c]
	mov r0, #0xc8
	str r0, [r4, #0x118]
	ldr r1, [r6, #0x28]
	mov r0, r5
	str r1, [r4, #0x138]
	ldr r2, [r5, #0x24]
	add r1, r4, #0x28
	orr r2, r2, #2
	orr r2, r2, #0x40000
	str r2, [r5, #0x24]
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r5
	mov r2, #0x1d00
	mov r3, r1
	bl SailObject__Func_21658D0
	mov r0, #0x1c000
	str r0, [r4, #0x98]
	mov r0, #0x600
	str r0, [r5, #0x38]
	str r0, [r5, #0x3c]
	str r0, [r5, #0x40]
	mov r0, r5
	bl StageTask__InitSeqPlayer
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x3c]
	cmp r0, #0
	bne _02179788
	mov r0, r5
	bl SailSailerBoat__Func_217C430
	b _021797D8
_02179788:
	ldrh r0, [r6, #0x30]
	sub r0, r0, #0x12
	cmp r0, #6
	addls pc, pc, r0, lsl #2
	b _021797D8
_0217979C: // jump table
	b _021797B8 // case 0
	b _021797B8 // case 1
	b _021797C4 // case 2
	b _021797D8 // case 3
	b _021797D8 // case 4
	b _021797D8 // case 5
	b _021797D0 // case 6
_021797B8:
	mov r0, r5
	bl SailSailerBoat__Func_217E3F0
	b _021797D8
_021797C4:
	mov r0, r5
	bl SailSailerBoat__Func_217C944
	b _021797D8
_021797D0:
	mov r0, r5
	bl SailSailerBoat__Func_217E614
_021797D8:
	mov r0, r5
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021797E4: .word aSbBirdNsbmd_1
	arm_func_end SailSailerBird__Create

	arm_func_start SailSailerBoat03__Create
SailSailerBoat03__Create: // 0x021797E8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x57
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _02179984 // =aSbSBoat03Nsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #0x20000000
	str r1, [r4, #0x24]
	bl SailObject__InitCommon
	mov r0, r4
	mov r1, r6
	bl SailObject__InitFromMapObject
	mov r0, #0xf000
	str r0, [r5, #0x120]
	str r0, [r5, #0x11c]
	mov r0, #0x258
	str r0, [r5, #0x118]
	ldr r0, [r6, #0x28]
	mov r1, #0
	str r0, [r5, #0x13c]
	ldr r2, [r4, #0x24]
	mov r0, #0xb00
	orr r2, r2, #3
	orr r2, r2, #0x40000
	str r2, [r4, #0x24]
	str r0, [sp, #0xc]
	str r1, [sp, #8]
	str r1, [sp, #0x10]
	mov r0, r4
	add r1, sp, #8
	bl SailObject__Func_2165AF4
	mov r0, r4
	add r1, r5, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r0, r4
	mov r1, #0
	bl SailObject__Func_21658A4
	mov r1, #0
	mov r0, r4
	mov r2, #0x1e00
	mov r3, r1
	bl SailObject__Func_21658D0
	mov r0, #0xb00
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	mov r0, r4
	bl StageTask__InitSeqPlayer
	ldrh r0, [r6, #0x30]
	cmp r0, #6
	bgt _02179928
	cmp r0, #0
	addge pc, pc, r0, lsl #2
	b _02179978
_0217990C: // jump table
	b _02179978 // case 0
	b _02179978 // case 1
	b _02179978 // case 2
	b _02179934 // case 3
	b _02179940 // case 4
	b _02179934 // case 5
	b _02179940 // case 6
_02179928:
	cmp r0, #0x1b
	beq _0217994C
	b _02179978
_02179934:
	mov r0, r4
	bl SailSailerBoat__SetupObject1
	b _02179978
_02179940:
	mov r0, r4
	bl SailSailerBoat__SetupObject2
	b _02179978
_0217994C:
	mov r0, #0x28000
	str r0, [r5, #0x120]
	str r0, [r5, #0x11c]
	ldr r0, [r5, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #1
	mov r0, r4
	beq _02179974
	bl SailSailerBoat__SetupObject1
	b _02179978
_02179974:
	bl SailSailerBoat__SetupObject2
_02179978:
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02179984: .word aSbSBoat03Nsbmd_0
	arm_func_end SailSailerBoat03__Create

	arm_func_start SailSailerBoat02__Create
SailSailerBoat02__Create: // 0x02179988
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x56
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _02179B68 // =aSbSBoat02Nsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #0x20000000
	orr r1, r1, #0x4000
	str r1, [r4, #0x24]
	bl SailObject__InitCommon
	mov r0, r4
	mov r1, r6
	bl SailObject__InitFromMapObject
	ldr r1, [r5, #0x174]
	mov r0, r4
	add r1, r1, #0x3400
	str r1, [r5, #0x174]
	ldr r2, [r4, #0x24]
	mov r1, #5
	orr r2, r2, #0x8000
	str r2, [r4, #0x24]
	bl SailObject__SetLightColors
	mov r0, #0xf000
	str r0, [r5, #0x120]
	str r0, [r5, #0x11c]
	mov r0, #0x320
	str r0, [r5, #0x118]
	ldr r0, [r6, #0x28]
	mov r1, #0
	str r0, [r5, #0x13c]
	ldr r2, [r4, #0x24]
	mov r0, #0xb00
	orr r2, r2, #3
	orr r2, r2, #0x40000
	str r2, [r4, #0x24]
	str r0, [sp, #0xc]
	str r1, [sp, #8]
	str r1, [sp, #0x10]
	mov r0, r4
	add r1, sp, #8
	bl SailObject__Func_2165AF4
	mov r0, r4
	add r1, r5, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r0, r4
	mov r1, #0
	bl SailObject__Func_21658A4
	mov r1, #0
	mov r0, r4
	mov r3, r1
	mov r2, #0x1e00
	bl SailObject__Func_21658D0
	ldr r0, [r4, #0x24]
	mov r1, #0xb00
	orr r0, r0, #0x20
	str r0, [r4, #0x24]
	str r1, [r4, #0x38]
	str r1, [r4, #0x3c]
	mov r0, r4
	str r1, [r4, #0x40]
	bl StageTask__InitSeqPlayer
	ldrh r0, [r6, #0x30]
	cmp r0, #0xa
	bgt _02179B0C
	cmp r0, #0
	addge pc, pc, r0, lsl #2
	b _02179B5C
_02179AE0: // jump table
	b _02179B5C // case 0
	b _02179B5C // case 1
	b _02179B5C // case 2
	b _02179B5C // case 3
	b _02179B5C // case 4
	b _02179B5C // case 5
	b _02179B5C // case 6
	b _02179B18 // case 7
	b _02179B24 // case 8
	b _02179B18 // case 9
	b _02179B24 // case 10
_02179B0C:
	cmp r0, #0x1c
	beq _02179B30
	b _02179B5C
_02179B18:
	mov r0, r4
	bl SailSailerBoat__SetupObject1
	b _02179B5C
_02179B24:
	mov r0, r4
	bl SailSailerBoat__SetupObject2
	b _02179B5C
_02179B30:
	mov r0, #0x28000
	str r0, [r5, #0x120]
	str r0, [r5, #0x11c]
	ldr r0, [r5, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #1
	mov r0, r4
	beq _02179B58
	bl SailSailerBoat__SetupObject1
	b _02179B5C
_02179B58:
	bl SailSailerBoat__SetupObject2
_02179B5C:
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02179B68: .word aSbSBoat02Nsbmd_0
	arm_func_end SailSailerBoat02__Create

	arm_func_start SailSailerBigBob01__Create
SailSailerBigBob01__Create: // 0x02179B6C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r6, r0
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #0x58
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _02179CB0 // =aSbBigbob01Nsbm_0
	mov r0, r5
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #0x20000000
	str r1, [r5, #0x24]
	bl SailObject__InitCommon
	mov r0, r5
	mov r1, r6
	bl SailObject__InitFromMapObject
	ldr r1, [r5, #0x48]
	mov r0, #0x8000
	sub r1, r1, #0x2700
	str r1, [r5, #0x48]
	ldr r1, [r4, #0x174]
	mov r2, #0
	sub r1, r1, #0x2700
	str r1, [r4, #0x174]
	str r0, [r4, #0x120]
	str r0, [r4, #0x11c]
	mov r0, #0x12c
	str r0, [r4, #0x118]
	ldr r1, [r6, #0x28]
	mov r0, r5
	str r1, [r4, #0x138]
	ldr r3, [r5, #0x24]
	add r1, r4, #0x28
	orr r3, r3, #2
	orr r3, r3, #0x40000
	str r3, [r5, #0x24]
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r5
	mov r2, #0x2800
	mov r3, r1
	bl SailObject__Func_21658D0
	mov r0, r5
	mov r1, #0
	bl StageTask__GetCollider
	mov r1, #0
	strh r1, [r0, #0x2c]
	mov r0, r5
	bl StageTask__InitSeqPlayer
	ldrh r0, [r6, #0x30]
	cmp r0, #0xb
	beq _02179C84
	cmp r0, #0xc
	beq _02179C90
	cmp r0, #0x1a
	beq _02179C9C
_02179C84:
	mov r0, r5
	bl SailSailerBoat__Func_217C430
	b _02179CA4
_02179C90:
	mov r0, r5
	bl SailSailerBoat__Func_217C720
	b _02179CA4
_02179C9C:
	mov r0, r5
	bl SailSailerBoat__Func_217CBBC
_02179CA4:
	mov r0, r5
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02179CB0: .word aSbBigbob01Nsbm_0
	arm_func_end SailSailerBigBob01__Create

	arm_func_start SailSailerBigBob02__Create
SailSailerBigBob02__Create: // 0x02179CB4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r6, r0
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #0x59
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _02179DC4 // =aSbBigbob02Nsbm_0
	mov r0, r5
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #0x20000000
	str r1, [r5, #0x24]
	bl SailObject__InitCommon
	mov r0, r5
	mov r1, r6
	bl SailObject__InitFromMapObject
	ldr r1, [r5, #0x48]
	mov r0, #0x8000
	sub r1, r1, #0x6000
	str r1, [r5, #0x48]
	ldr r1, [r4, #0x174]
	mov r2, #0
	sub r1, r1, #0x6000
	str r1, [r4, #0x174]
	str r0, [r4, #0x120]
	str r0, [r4, #0x11c]
	mov r0, #0x190
	str r0, [r4, #0x118]
	ldr r1, [r6, #0x28]
	mov r0, r5
	str r1, [r4, #0x138]
	ldr r3, [r5, #0x24]
	add r1, r4, #0x28
	orr r3, r3, #2
	orr r3, r3, #0x40000
	str r3, [r5, #0x24]
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r5
	mov r2, #0x2800
	mov r3, r1
	bl SailObject__Func_21658D0
	mov r0, r5
	mov r1, #0
	bl StageTask__GetCollider
	mov r1, #0
	strh r1, [r0, #0x2c]
	mov r0, r5
	bl StageTask__InitSeqPlayer
	mov r0, r5
	bl SailSailerBoat__Func_217C430
	mov r0, r5
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02179DC4: .word aSbBigbob02Nsbm_0
	arm_func_end SailSailerBigBob02__Create

	arm_func_start SailSailerCruiser__Create
SailSailerCruiser__Create: // 0x02179DC8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r6, r0
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #0x5a
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _02179F8C // =aSbCruiserNsbmd_0
	mov r0, r5
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #0x20000000
	str r1, [r5, #0x24]
	bl SailObject__InitCommon
	mov r0, r5
	mov r1, r6
	bl SailObject__InitFromMapObject
	ldr r1, _02179F90 // =0x0044C000
	ldr r0, _02179F94 // =0x00001388
	str r1, [r4, #0x120]
	str r1, [r4, #0x11c]
	str r0, [r4, #0x118]
	ldr r0, [r6, #0x28]
	mov r1, #0
	str r0, [r4, #0x138]
	ldr r2, [r5, #0x24]
	mov r0, #0x1a00
	orr r2, r2, #6
	orr r2, r2, #0x40000
	str r2, [r5, #0x24]
	str r0, [sp, #0xc]
	str r1, [sp, #8]
	str r1, [sp, #0x10]
	mov r0, r5
	add r1, sp, #8
	bl SailObject__Func_2165AF4
	mov r0, r5
	add r1, r4, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r0, r5
	add r1, r4, #0xa0
	mov r2, #3
	bl SailObject__SetupHitbox
	mov r0, r5
	mov r1, #0
	bl SailObject__Func_21658A4
	mov r0, r5
	mov r1, #3
	bl SailObject__Func_21658A4
	ldrh r1, [r4, #0x9c]
	add r0, r4, #0x100
	add r3, sp, #8
	orr r1, r1, #0x20
	strh r1, [r4, #0x9c]
	ldrh r1, [r0, #0x14]
	mov r2, #0x4c00
	orr r1, r1, #0x20
	strh r1, [r0, #0x14]
	mov r1, #0
	sub r4, r1, #0x4800
	mov r0, r5
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	str r4, [sp, #0x10]
	bl SailObject__Func_21658D0
	mov r4, #0
	mov r2, #0x1000
	mov r1, #0x6200
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	add r3, sp, #8
	mov r0, r5
	str r4, [sp, #8]
	mov r1, #3
	mov r2, #0x6800
	bl SailObject__Func_21658D0
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #1
	orr r1, r1, #0x1000000
	str r1, [r5, #0x24]
	bl StageTask__InitSeqPlayer
	ldrh r0, [r6, #0x30]
	sub r0, r0, #0xe
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02179F80
_02179F5C: // jump table
	b _02179F6C // case 0
	b _02179F78 // case 1
	b _02179F6C // case 2
	b _02179F78 // case 3
_02179F6C:
	mov r0, r5
	bl SailSailerBoat__Func_217CC18
	b _02179F80
_02179F78:
	mov r0, r5
	bl SailSailerBoat__Func_217CDB0
_02179F80:
	mov r0, r5
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02179F8C: .word aSbCruiserNsbmd_0
_02179F90: .word 0x0044C000
_02179F94: .word 0x00001388
	arm_func_end SailSailerCruiser__Create

	arm_func_start SailSailerBoat01__Create
SailSailerBoat01__Create: // 0x02179F98
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x55
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _0217A0CC // =aSbSBoat01Nsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #0x20000000
	str r1, [r4, #0x24]
	bl SailObject__InitCommon
	mov r0, r4
	mov r1, r6
	bl SailObject__InitFromMapObject
	mov r0, #0x1f4000
	str r0, [r5, #0x120]
	str r0, [r5, #0x11c]
	mov r0, #0x7d0
	str r0, [r5, #0x118]
	ldr r0, [r4, #0x24]
	add r1, sp, #8
	orr r0, r0, #1
	str r0, [r4, #0x24]
	ldr r0, [r6, #0x28]
	mov r3, #0
	str r0, [r5, #0x13c]
	cmp r0, #0
	moveq r0, #0xc8
	streq r0, [r5, #0x13c]
	ldr r0, [r4, #0x24]
	orr r0, r0, #6
	orr r2, r0, #0x40000
	str r2, [r4, #0x24]
	mov r2, #0x1600
	mov r0, r4
	str r3, [sp, #8]
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	bl SailObject__Func_2165AF4
	mov r0, r4
	add r1, r5, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r0, r4
	mov r1, #0
	bl SailObject__Func_21658A4
	mov r1, #0
	mov r0, r4
	mov r2, #0x3c00
	mov r3, r1
	bl SailObject__Func_21658D0
	ldrh r1, [r5, #0x9c]
	mov r0, r4
	orr r1, r1, #0x20
	strh r1, [r5, #0x9c]
	bl StageTask__InitSeqPlayer
	mov r0, r4
	bl SailSailerBoat__SetupObject1
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0217A0CC: .word aSbSBoat01Nsbmd_0
	arm_func_end SailSailerBoat01__Create

	arm_func_start SailSailerBoat02_2__Create
SailSailerBoat02_2__Create: // 0x0217A0D0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r6, r0
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x56
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _0217A23C // =aSbSBoat02Nsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #0x20000000
	orr r1, r1, #0x4000
	str r1, [r4, #0x24]
	bl SailObject__InitCommon
	mov r0, r4
	mov r1, r6
	bl SailObject__InitFromMapObject
	ldr r1, [r5, #0x174]
	mov r0, r4
	add r1, r1, #0x3400
	str r1, [r5, #0x174]
	ldr r2, [r4, #0x24]
	mov r1, #5
	orr r2, r2, #0x8000
	str r2, [r4, #0x24]
	bl SailObject__SetLightColors
	mov r0, #0x1a4000
	str r0, [r5, #0x120]
	str r0, [r5, #0x11c]
	ldr r0, _0217A240 // =0x000009C4
	add r1, sp, #8
	str r0, [r5, #0x118]
	ldr r0, [r4, #0x24]
	mov r3, #0
	orr r0, r0, #1
	str r0, [r4, #0x24]
	ldr r0, [r6, #0x28]
	str r0, [r5, #0x13c]
	cmp r0, #0
	moveq r0, #0xc8
	streq r0, [r5, #0x13c]
	ldr r0, [r4, #0x24]
	orr r2, r0, #6
	orr r0, r2, #0x40000
	orr r2, r0, #2
	str r2, [r4, #0x24]
	mov r2, #0x1600
	mov r0, r4
	str r3, [sp, #8]
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	bl SailObject__Func_2165AF4
	mov r0, r4
	add r1, r5, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r0, r4
	mov r1, #0
	bl SailObject__Func_21658A4
	mov r1, #0
	mov r0, r4
	mov r2, #0x3c00
	mov r3, r1
	bl SailObject__Func_21658D0
	ldrh r1, [r5, #0x9c]
	mov r0, r4
	orr r1, r1, #0x20
	strh r1, [r5, #0x9c]
	ldr r1, [r4, #0x24]
	orr r1, r1, #0x20
	str r1, [r4, #0x24]
	bl StageTask__InitSeqPlayer
	mov r0, r4
	bl SailSailerBoat__SetupObject1
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0217A23C: .word aSbSBoat02Nsbmd_0
_0217A240: .word 0x000009C4
	arm_func_end SailSailerBoat02_2__Create

	arm_func_start SailSailerCruiser02__Create
SailSailerCruiser02__Create: // 0x0217A244
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r6, r0
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #0x5d
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	str r7, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _0217A3D4 // =aSbCruiser02Nsb_0
	mov r0, r5
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #0x20000000
	str r1, [r5, #0x24]
	bl SailObject__InitCommon
	mov r0, r5
	mov r1, r6
	bl SailObject__InitFromMapObject
	mov r0, #0x690000
	str r0, [r4, #0x120]
	str r0, [r4, #0x11c]
	ldr r0, _0217A3D8 // =0x00001388
	mov r1, #0x1a00
	str r0, [r4, #0x118]
	ldr r0, [r6, #0x28]
	mov r2, #0
	str r0, [r4, #0x138]
	ldr r3, [r5, #0x24]
	mov r0, r5
	orr r3, r3, #6
	orr r3, r3, #0x1040000
	str r3, [r5, #0x24]
	str r1, [sp, #0xc]
	add r1, sp, #8
	str r2, [sp, #8]
	str r2, [sp, #0x10]
	bl SailObject__Func_2165AF4
	mov r0, r5
	add r1, r4, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r0, r5
	add r1, r4, #0xa0
	mov r2, #3
	bl SailObject__SetupHitbox
	mov r0, r5
	mov r1, #0
	bl SailObject__Func_21658A4
	mov r0, r5
	mov r1, #3
	bl SailObject__Func_21658A4
	ldrh r0, [r4, #0x9c]
	mov r1, #0
	add r3, sp, #8
	orr r0, r0, #0x20
	strh r0, [r4, #0x9c]
	add r0, r4, #0x100
	ldrh r2, [r0, #0x14]
	sub r4, r1, #0x4800
	orr r2, r2, #0x20
	strh r2, [r0, #0x14]
	mov r0, r5
	mov r2, #0x4c00
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	str r4, [sp, #0x10]
	bl SailObject__Func_21658D0
	mov r4, #0
	mov r2, #0x1000
	mov r1, #0x6200
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	add r3, sp, #8
	mov r0, r5
	str r4, [sp, #8]
	mov r1, #3
	mov r2, #0x6800
	bl SailObject__Func_21658D0
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #1
	str r1, [r5, #0x24]
	bl StageTask__InitSeqPlayer
	mov r0, r5
	bl SailSailerBoat__Func_217CDB0
	mov r0, r5
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0217A3D4: .word aSbCruiser02Nsb_0
_0217A3D8: .word 0x00001388
	arm_func_end SailSailerCruiser02__Create

	arm_func_start SailShell3__Create
SailShell3__Create: // 0x0217A3DC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r8, r1
	mov r7, r2
	mov r6, r3
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #0x32
	bl GetObjectFileWork
	mov r9, r0
	bl SailManager__GetArchive
	mov r1, #0
	stmia sp, {r1, r9}
	str r0, [sp, #8]
	ldr r2, _0217A610 // =aSbShellBac_2
	mov r0, r5
	mov r3, r1
	bl ObjObjectAction3dBACLoad
	mov r0, #0x40
	bl GetObjectFileWork
	mov r1, #0
	mov r3, r0
	mov r0, r5
	mov r2, r1
	bl ObjObjectActionAllocTexture
	ldr r1, [r5, #0x134]
	mov r2, #0x1c
	ldr r0, [r1, #0xcc]
	mov r3, #7
	orr r0, r0, #0x18
	str r0, [r1, #0xcc]
	ldr r1, [r5, #0x134]
	mov r0, r5
	strb r2, [r1, #0xa]
	ldr r2, [r5, #0x134]
	mov r1, #1
	strb r3, [r2, #0xb]
	bl StageTask__SetAnimation
	mov r0, r5
	bl SailObject__InitCommon
	add ip, r5, #0x44
	ldmia r8, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	mov r3, #0x64
	str r3, [r4, #0x118]
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #3
	orr r1, r1, #0x800000
	str r1, [r5, #0x24]
	add r1, r4, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r5
	mov r2, #0x1600
	mov r3, r1
	bl SailObject__Func_21658D0
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r2, r0, lsl #1
	add r0, r2, #1
	ldr r1, _0217A614 // =FX_SinCosTable_
	mov r2, r2, lsl #1
	mov r0, r0, lsl #1
	ldrsh r2, [r1, r2]
	ldrsh r1, [r1, r0]
	mov r8, #0x24000
	smull r0, r3, r7, r2
	adds r6, r0, #0x800
	str r8, [r4, #0x98]
	ldr r2, [r5, #0x1c]
	ldrh r0, [sp, #0x28]
	orr r8, r2, #0x80
	smull r2, r1, r7, r1
	adc r3, r3, #0
	adds r2, r2, #0x800
	mov r4, r6, lsr #0xc
	str r8, [r5, #0x1c]
	mov r6, #0x60
	str r6, [r5, #0xd8]
	mov r6, #0x2000
	str r6, [r5, #0xdc]
	orr r4, r4, r3, lsl #20
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	str r4, [r5, #0x98]
	orr r2, r2, r1, lsl #20
	str r2, [r5, #0xa0]
	mov r1, #0
	str r1, [r5, #0x9c]
	ldr r1, [r5, #0xd8]
	mov r0, r0, asr #1
	mul r0, r1, r0
	rsb r0, r0, #0
	ldr r3, _0217A618 // =_mt_math_rand
	str r0, [r5, #0x9c]
	ldr r4, [r3, #0]
	ldr r0, _0217A61C // =0x00196225
	ldr r1, _0217A620 // =0x3C6EF35F
	ldr r2, _0217A624 // =0x000003FF
	mla r0, r4, r0, r1
	str r0, [r3]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	ldr r1, [r5, #0x9c]
	and r0, r2, r0, lsr #16
	add r1, r1, r0
	mov r0, r5
	str r1, [r5, #0x9c]
	bl StageTask__InitSeqPlayer
	ldr r0, [r5, #0x138]
	add r2, r5, #0x44
	mov r1, #0x2a
	bl SailAudio__PlaySpatialSequence
	mov r0, r5
	bl SailShell3__SetupObject
	ldr r2, [r5, #0x38]
	mov r0, #0xa00
	umull r4, r3, r2, r0
	mov r1, #0
	adds r4, r4, #0x800
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r4, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r5, #0x38]
	str r1, [r5, #0x3c]
	mov r0, r5
	str r1, [r5, #0x40]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0217A610: .word aSbShellBac_2
_0217A614: .word FX_SinCosTable_
_0217A618: .word _mt_math_rand
_0217A61C: .word 0x00196225
_0217A620: .word 0x3C6EF35F
_0217A624: .word 0x000003FF
	arm_func_end SailShell3__Create

	arm_func_start SailBomber3__Create
SailBomber3__Create: // 0x0217A628
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r6, r1
	bl SailManager__GetWork
	ldr r0, [r0, #0x24]
	tst r0, #0x200
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #0x24
	bl GetObjectFileWork
	mov r7, r0
	bl SailManager__GetArchive
	ldr r3, _0217A760 // =0x0000FFFF
	ldr r2, _0217A764 // =aSbBomberBac_1
	stmia sp, {r3, r7}
	str r0, [sp, #8]
	mov r1, #0
	mov r0, r5
	bl ObjObjectAction3dBACLoad
	ldr r0, [r5, #0x134]
	mov r1, #0x1c
	strb r1, [r0, #0xa]
	ldr r1, [r5, #0x134]
	mov r2, #7
	mov r0, r5
	strb r2, [r1, #0xb]
	bl SailObject__InitCommon
	add ip, r5, #0x44
	ldmia r6, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	mov r3, #0x64
	str r3, [r4, #0x118]
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #3
	orr r1, r1, #0x800000
	str r1, [r5, #0x24]
	add r1, r4, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r5
	mov r2, #0x2000
	mov r3, r1
	bl SailObject__Func_21658D0
	mov r0, #0x14000
	str r0, [r4, #0x98]
	ldr r1, [r5, #0x1c]
	mov r0, #0x60
	orr r1, r1, #0x80
	str r1, [r5, #0x1c]
	str r0, [r5, #0xd8]
	mov r0, #0x2000
	str r0, [r5, #0xdc]
	mov r0, r5
	bl StageTask__InitSeqPlayer
	ldr r0, [r5, #0x138]
	mov r1, #0x2a
	add r2, r5, #0x44
	bl SailAudio__PlaySpatialSequence
	ldr r0, [r5, #0x138]
	mov r1, #0x2c
	add r2, r5, #0x44
	bl SailAudio__PlaySpatialSequence
	mov r0, r5
	bl SailShell3__SetupObject
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0217A760: .word 0x0000FFFF
_0217A764: .word aSbBomberBac_1
	arm_func_end SailBomber3__Create

	arm_func_start SailTorpedo__Create
SailTorpedo__Create: // 0x0217A768
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r8, r1
	mov r7, r2
	mov r6, r3
	bl SailManager__GetWork
	ldr r0, [r0, #0x24]
	tst r0, #0x200
	addne sp, sp, #8
	movne r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	bl CreateStageTask_
	mov r5, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r5
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r4, r0
	mov r0, #0x23
	bl GetObjectFileWork
	mov r9, r0
	bl SailManager__GetArchive
	str r9, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _0217A8E4 // =aSbTorpedoNsbmd_0
	mov r0, r5
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #0x20000000
	str r1, [r5, #0x24]
	bl SailObject__InitCommon
	add ip, r5, #0x44
	ldmia r8, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	mov r3, #0x64
	str r3, [r4, #0x118]
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #8
	orr r1, r1, #0x800000
	str r1, [r5, #0x24]
	add r1, r4, #0x28
	mov r2, #0
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r5
	mov r2, #0x1800
	mov r3, r1
	bl SailObject__Func_21658D0
	mov r0, #0x10000
	str r0, [r4, #0x98]
	ldr r1, [r5, #0x1c]
	mov r0, #0x60
	orr r1, r1, #0x80
	str r1, [r5, #0x1c]
	str r0, [r5, #0xd8]
	mov r0, #0x2000
	str r0, [r5, #0xdc]
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	mov r1, r0, lsl #1
	ldr r2, _0217A8E8 // =FX_SinCosTable_
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r0, [r2, r0]
	smull r2, r1, r6, r1
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	smull r1, r0, r6, r0
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r2, [r5, #0x98]
	mov r0, r6, lsl #0x10
	str r1, [r5, #0xa0]
	mov r0, r0, lsr #0x10
	str r0, [r5, #0x28]
	mov r0, r5
	strh r7, [r5, #0x32]
	bl StageTask__InitSeqPlayer
	mov r0, r5
	bl SailTorpedo__SetupObject
	mov r0, r5
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0217A8E4: .word aSbTorpedoNsbmd_0
_0217A8E8: .word FX_SinCosTable_
	arm_func_end SailTorpedo__Create

	arm_func_start SailTorpedo2__Create
SailTorpedo2__Create: // 0x0217A8EC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r10, r1
	mov r9, r2
	mov r8, r3
	bl SailManager__GetWork
	bl SailManager__GetWork
	ldr r0, [r0, #0x24]
	tst r0, #0x200
	addne sp, sp, #8
	movne r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x23
	bl GetObjectFileWork
	mov r11, r0
	bl SailManager__GetArchive
	str r11, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _0217AADC // =aSbTorpedoNsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #0x20000000
	str r1, [r4, #0x24]
	bl SailObject__InitCommon
	add ip, r4, #0x44
	ldmia r10, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	mov r11, #0x64
	str r11, [r5, #0x118]
	ldr r0, [r4, #0x24]
	add r3, r5, #0x10
	orr r0, r0, #2
	orr r0, r0, #0x800000
	str r0, [r4, #0x24]
	str r8, [r4, #0x28]
	ldmia r9, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r5, #0x10]
	str r0, [r5, #0x148]
	ldr r0, [r5, #0x14]
	str r0, [r5, #0x14c]
	ldr r0, [r5, #0x18]
	str r0, [r5, #0x150]
	ldr r0, [r4, #0x44]
	str r0, [r5, #0x13c]
	ldr r0, [r4, #0x48]
	str r0, [r5, #0x140]
	ldr r0, [r4, #0x4c]
	str r0, [r5, #0x144]
	bl SailManager__GetShipType
	cmp r0, #0
	beq _0217AA14
	cmp r0, #1
	beq _0217AA2C
	cmp r0, #2
	bne _0217AA40
	ldr r1, [r4, #0x24]
	mov r0, #0x3000
	orr r1, r1, #1
	str r1, [r4, #0x24]
	str r0, [r5, #0x120]
	str r0, [r5, #0x11c]
_0217AA14:
	ldr r0, [r4, #0x18]
	mov r6, #0xa00
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	mov r7, #0x700
	b _0217AA40
_0217AA2C:
	ldr r0, [r4, #0x24]
	mov r6, #0x1400
	orr r0, r0, #1
	str r0, [r4, #0x24]
	mov r7, #0x1c00
_0217AA40:
	ldr r1, [r4, #0x38]
	mov r0, r4
	smull r3, r2, r1, r6
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r1, lsl #20
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	add r1, r5, #0x28
	mov r2, #0
	str r3, [r4, #0x40]
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r4
	mov r2, r7
	mov r3, r1
	bl SailObject__Func_21658D0
	mov r0, #0x18000
	str r0, [r5, #0x98]
	bl SailManager__GetShipType
	cmp r0, #2
	bne _0217AAB0
	mov r0, #0x30000
	str r0, [r5, #0x98]
	ldr r0, [r4, #0x144]
	mov r1, #0xb
	strh r1, [r0, #0x2e]
_0217AAB0:
	mov r0, r4
	bl StageTask__InitSeqPlayer
	ldr r0, [r4, #0x138]
	add r2, r4, #0x44
	mov r1, #0x2d
	bl SailAudio__PlaySpatialSequence
	mov r0, r4
	bl SailTorpedo2__SetupObject
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0217AADC: .word aSbTorpedoNsbmd_0
	arm_func_end SailTorpedo2__Create

	arm_func_start SailMissile__Create
SailMissile__Create: // 0x0217AAE0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x38
	mov r9, r0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	bl SailManager__GetWork
	bl SailManager__GetWork
	ldr r0, [r0, #0x24]
	tst r0, #0x200
	addne sp, sp, #0x38
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x6a
	bl GetObjectFileWork
	mov r10, r0
	bl SailManager__GetArchive
	str r10, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _0217ACC8 // =aSbMissileNsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #0x20000000
	str r1, [r4, #0x24]
	bl SailObject__InitCommon
	add lr, r4, #0x44
	ldmia r8, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	mov ip, #0
	str ip, [sp, #8]
	str ip, [sp, #0xc]
	str r7, [sp, #0x10]
	str r7, [r5, #0x138]
	ldrh r1, [r9, #0x32]
	ldr r3, _0217ACCC // =FX_SinCosTable_
	add r0, sp, #0x14
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, sp, #8
	add r1, sp, #0x14
	mov r2, r0
	bl MTX_MultVec33
	add r1, r4, #0x44
	add r0, sp, #8
	mov r2, r1
	bl VEC_Add
	mov r0, r4
	mov r1, r9
	mov r2, #0x200
	bl StageTask__SetParent
	ldr r0, [r9, #0x124]
	ldr r0, [r0, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #1
	beq _0217AC14
	add r0, r5, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #4
	strh r1, [r0, #0x2c]
_0217AC14:
	ldr r1, [r4, #0x24]
	mov r0, #0x64
	orr r1, r1, #0x100000
	str r1, [r4, #0x24]
	str r6, [r4, #0x28]
	str r0, [r5, #0x118]
	ldr r0, [r4, #0x24]
	mov r2, #0
	orr r0, r0, #3
	orr r0, r0, #0x800000
	str r0, [r4, #0x24]
	ldr r1, [r4, #0x38]
	mov r0, #0x1400
	umull r6, r3, r1, r0
	mla r3, r1, r2, r3
	mov r1, r1, asr #0x1f
	mla r3, r1, r0, r3
	adds r6, r6, #0x800
	adc r0, r3, #0
	mov r3, r6, lsr #0xc
	orr r3, r3, r0, lsl #20
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	mov r0, r4
	add r1, r5, #0x28
	str r3, [r4, #0x40]
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r4
	mov r3, r1
	mov r2, #0x1c00
	bl SailObject__Func_21658D0
	mov r1, #0x20000
	mov r0, r4
	str r1, [r5, #0x98]
	bl StageTask__InitSeqPlayer
	ldr r0, [r4, #0x138]
	mov r1, #0x2b
	add r2, r4, #0x44
	bl SailAudio__PlaySpatialSequence
	mov r0, r4
	bl SailMissile__SetupObject
	mov r0, r4
	add sp, sp, #0x38
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0217ACC8: .word aSbMissileNsbmd_0
_0217ACCC: .word FX_SinCosTable_
	arm_func_end SailMissile__Create

	arm_func_start SailTorpedo3__Create
SailTorpedo3__Create: // 0x0217ACD0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r7, r0
	mov r6, r1
	bl SailManager__GetWork
	bl SailManager__GetWork
	ldr r0, [r0, #0x24]
	tst r0, #0x200
	addne sp, sp, #8
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	bl CreateStageTask_
	mov r4, r0
	mov r1, #1
	bl StageTask__SetType
	mov r0, r4
	mov r1, #0x1a0
	bl StageTask__AllocateWorker
	mov r5, r0
	mov r0, #0x23
	bl GetObjectFileWork
	mov r8, r0
	bl SailManager__GetArchive
	str r8, [sp]
	mov r1, #0
	str r0, [sp, #4]
	ldr r2, _0217AE44 // =aSbTorpedoNsbmd_0
	mov r0, r4
	mov r3, r1
	bl ObjAction3dNNModelLoad
	ldr r1, [r4, #0x24]
	mov r0, r4
	orr r1, r1, #0x20000000
	str r1, [r4, #0x24]
	bl SailObject__InitCommon
	add lr, r4, #0x44
	ldmia r6, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	mov ip, #0x5000
	str ip, [r5, #0x120]
	mov r3, #0x1f4
	str ip, [r5, #0x11c]
	str r3, [r5, #0x118]
	ldr r0, [r4, #0x24]
	orr r0, r0, #2
	orr r0, r0, #0x20000
	orr r0, r0, #1
	orr r0, r0, #0xa00000
	str r0, [r4, #0x24]
	ldr r0, [r7, #0x124]
	ldr r0, [r0, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #1
	beq _0217ADB8
	add r0, r5, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #4
	strh r1, [r0, #0x2c]
_0217ADB8:
	ldr r1, [r4, #0x38]
	mov r0, #0x3b00
	umull r6, r3, r1, r0
	mov r2, #0
	mla r3, r1, r2, r3
	mov r1, r1, asr #0x1f
	adds r6, r6, #0x800
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r3, r6, lsr #0xc
	orr r3, r3, r0, lsl #20
	str r3, [r4, #0x38]
	str r3, [r4, #0x3c]
	mov r0, r4
	add r1, r5, #0x28
	str r3, [r4, #0x40]
	bl SailObject__SetupHitbox
	mov r1, #0
	mov r0, r4
	mov r3, r1
	mov r2, #0x2d00
	bl SailObject__Func_21658D0
	mov r1, #0x64000
	mov r0, r4
	str r1, [r5, #0x98]
	bl StageTask__InitSeqPlayer
	ldr r0, [r4, #0x138]
	mov r1, #0x2b
	add r2, r4, #0x44
	bl SailAudio__PlaySpatialSequence
	mov r0, r4
	bl SailTorpedo3__SetupObject
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0217AE44: .word aSbTorpedoNsbmd_0
	arm_func_end SailTorpedo3__Create

	arm_func_start SailSailerBoat__Func_217AE48
SailSailerBoat__Func_217AE48: // 0x0217AE48
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	mov r1, #0
	str r1, [r5, #0x9c]
	bl SailObject__Func_2166D18
	ldr r1, [r5, #0x9c]
	mov r0, #0
	str r1, [r4, #0x180]
	str r0, [r5, #0x9c]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSailerBoat__Func_217AE48

	arm_func_start SailSailerBoat__SetupObject1
SailSailerBoat__SetupObject1: // 0x0217AE74
	ldr r3, [r0, #0x124]
	ldr r2, _0217AE90 // =SailSailerBoat__State_217AE94
	mov r1, #0x600
	str r2, [r0, #0xf4]
	rsb r1, r1, #0
	str r1, [r3, #0x184]
	bx lr
	.align 2, 0
_0217AE90: .word SailSailerBoat__State_217AE94
	arm_func_end SailSailerBoat__SetupObject1

	arm_func_start SailSailerBoat__State_217AE94
SailSailerBoat__State_217AE94: // 0x0217AE94
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r5, [r0, #0x98]
	mov r0, r6
	bl SailSailerBoat__Func_217AE48
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
_0217AEBC:
	mov r0, r6
	add r1, r1, #0x8000
	strh r1, [r6, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r6
	bl SailObject__Func_2166A2C
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6c]
	ldr r2, [r5, #0xc0]
	mov r0, #0x28
	mla r0, r1, r0, r2
	ldrsh r0, [r0, #0xa]
	mvn r1, #0
	cmp r0, #0
	rsblt r0, r0, #0
	mov r2, r0, asr #2
	mov r0, r1, lsl #0x10
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r2, r2, asr #0x1f
	mla r3, r2, r0, r3
	ldr r1, [r4, #0x164]
	adds ip, ip, #0x800
	ldrh r0, [r1, #0x30]
	adc r1, r3, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	cmp r0, #0x1b
	add r3, r2, #0x14000
	ldrhs r1, [r4, #0x13c]
	ldr r2, [r4, #0x178]
	addhs r3, r3, r1, lsl #13
	ldr r1, [r5, #0x44]
	sub r1, r2, r1
	cmp r1, r3
	addge sp, sp, #4
	ldmgeia sp!, {r3, r4, r5, r6, pc}
	cmp r0, #0x1b
	blo _0217AF68
	mov r0, r6
	bl SailSailerBoat__Func_217B540
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217AF68:
	ldr r0, [r4, #0x13c]
	cmp r0, #0
	bne _0217B004
	ldr r0, [r6, #0x24]
	tst r0, #0x8000
	beq _0217AF90
	mov r0, r6
	bl SailSailerBoat__Func_217B760
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217AF90:
	ldr r5, _0217B014 // =0x00007FFF
	mov r1, #0
	mov r0, r6
	sub r2, r1, #0x2000
	mov r3, #0x4000
	str r5, [sp]
	bl SailSailerBoat__Func_217E788
	mov r0, #0x4000
	str r0, [r6, #4]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #6
	addls pc, pc, r0, lsl #2
	b _0217B00C
_0217AFC8: // jump table
	b _0217B00C // case 0
	b _0217B00C // case 1
	b _0217B00C // case 2
	b _0217AFE4 // case 3
	b _0217AFF4 // case 4
	b _0217AFF4 // case 5
	b _0217AFE4 // case 6
_0217AFE4:
	mov r0, r6
	bl SailSailerBoat__Func_217B3B8
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217AFF4:
	mov r0, r6
	bl SailSailerBoat__Func_217B018
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217B004:
	mov r0, r6
	bl SailSailerBoat__Func_217B960
_0217B00C:
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0217B014: .word 0x00007FFF
	arm_func_end SailSailerBoat__State_217AE94

	arm_func_start SailSailerBoat__Func_217B018
SailSailerBoat__Func_217B018: // 0x0217B018
	ldr r2, _0217B02C // =SailSailerBoat__State_217B030
	mov r1, #0
	str r2, [r0, #0xf4]
	str r1, [r0, #0x28]
	bx lr
	.align 2, 0
_0217B02C: .word SailSailerBoat__State_217B030
	arm_func_end SailSailerBoat__Func_217B018

	arm_func_start SailSailerBoat__State_217B030
SailSailerBoat__State_217B030: // 0x0217B030
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #7
	blo _0217B148
	cmp r0, #0xa
	bhi _0217B148
	ldr r0, [r5, #0x28]
	cmp r0, #0x2a
	blo _0217B130
	bne _0217B078
	ldr r0, [r5, #0x138]
	add r2, r5, #0x44
	mov r1, #0x2e
	bl SailAudio__PlaySpatialSequence
_0217B078:
	ldr r0, [r4, #0x174]
	cmp r0, #0x3400
	blt _0217B0B4
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #0x20
	orr r2, r1, #0x8000
	mov r1, #5
	str r2, [r5, #0x24]
	bl SailObject__SetLightColors
	mov r0, #0
	str r0, [r4, #0x180]
	mov r0, #0x3400
	str r0, [r4, #0x174]
	b _0217B118
_0217B0B4:
	ldr r0, [r4, #0x180]
	mov r1, #0x30
	mov r2, #0x300
	bl ObjSpdUpSet
	str r0, [r4, #0x180]
	ldr r0, [r5, #0x28]
	tst r0, #0xf
	bne _0217B118
	mov r0, r5
	bl EffectSailWaterSplash2__Create
	ldr r2, [r0, #0x24]
	mov r1, #0x800
	orr r2, r2, #1
	str r2, [r0, #0x24]
	ldr r3, [r0, #0x38]
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #0xb
	adds ip, r1, r3, lsl #11
	orr r2, r2, r3, lsr #21
	adc r1, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x38]
	str r2, [r0, #0x3c]
	str r2, [r0, #0x40]
_0217B118:
	ldr r0, [r4, #0x184]
	mov r1, #0x50
	mov r2, #0x600
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
	b _0217B138
_0217B130:
	mov r0, r5
	bl SailSailerBoat__Func_217AE48
_0217B138:
	ldr r0, [r5, #0x28]
	add r0, r0, #1
	str r0, [r5, #0x28]
	b _0217B164
_0217B148:
	mov r0, r5
	bl SailSailerBoat__Func_217AE48
	ldr r0, [r4, #0x184]
	mov r1, #0x50
	mov r2, #0x600
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
_0217B164:
	ldr r0, [r4, #0x17c]
	mov r1, #0x40
	bl ObjSpdDownSet
	str r0, [r4, #0x17c]
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r5
	add r1, r1, #0x8000
	strh r1, [r5, #0x32]
	ldrh r2, [r5, #0x32]
	ldr r1, [r4, #0x17c]
	sub r1, r2, r1, lsl #2
	strh r1, [r5, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSailerBoat__State_217B030

	arm_func_start SailSailerBoat__SetupObject2
SailSailerBoat__SetupObject2: // 0x0217B1A8
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, [r0, #0x124]
	ldr r2, _0217B218 // =SailSailerBoat__State_217B220
	mov r1, #0x600
	str r2, [r0, #0xf4]
	str r1, [r4, #0x184]
	bl SailManager__GetWork
	ldr r3, [r0, #0x98]
	mov r0, #0x28
	ldr r1, [r3, #0x44]
	sub r2, r1, #0x18000
	mov r1, r2, asr #0x13
	str r2, [r4, #0x178]
	mul r5, r1, r0
	ldr r6, [r3, #0xc0]
	add r0, r6, r5
	bl SailVoyageManager__GetSegmentSize
	ldr r3, [r4, #0x178]
	ldr r2, _0217B21C // =0x0007FFFF
	mov r1, r0
	and r0, r3, r2
	bl FX_Div
	mov r1, r0
	add r0, r6, r5
	bl SailVoyageManager__GetAngleForSegmentPos
	add r1, r4, #0x100
	strh r0, [r1, #0x6e]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0217B218: .word SailSailerBoat__State_217B220
_0217B21C: .word 0x0007FFFF
	arm_func_end SailSailerBoat__SetupObject2

	arm_func_start SailSailerBoat__State_217B220
SailSailerBoat__State_217B220: // 0x0217B220
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r5, [r0, #0x98]
	mov r0, r6
	bl SailSailerBoat__Func_217AE48
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r6
	add r1, r1, #0x8000
	strh r1, [r6, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r6
	bl SailObject__Func_2166A2C
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6c]
	ldr r2, [r5, #0xc0]
	mov r0, #0x28
	mla r0, r1, r0, r2
	ldrsh r0, [r0, #0xa]
	mvn r1, #0
	cmp r0, #0
	rsblt r0, r0, #0
	mov r2, r0, asr #2
	mov r0, r1, lsl #0x10
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r2, r2, asr #0x1f
	mla r3, r2, r0, r3
	ldr r1, [r4, #0x164]
	adds ip, ip, #0x800
	ldrh r0, [r1, #0x30]
	adc r1, r3, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	cmp r0, #0x1b
	add r3, r2, #0x14000
	ldrhs r1, [r4, #0x13c]
	ldr r2, [r4, #0x178]
	subhs r3, r3, r1, lsl #13
	ldr r1, [r5, #0x44]
	sub r1, r2, r1
	cmp r1, r3
	addle sp, sp, #4
	ldmleia sp!, {r3, r4, r5, r6, pc}
	cmp r0, #0x1b
	blo _0217B2F4
	mov r0, r6
	bl SailSailerBoat__Func_217B540
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217B2F4:
	ldr r0, [r4, #0x13c]
	cmp r0, #0
	bne _0217B3A4
	ldr r0, [r6, #0x24]
	tst r0, #0x8000
	beq _0217B31C
	mov r0, r6
	bl SailSailerBoat__Func_217B760
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217B31C:
	ldr r5, _0217B3B4 // =0x00007FFF
	mov r1, #0
	mov r0, r6
	sub r2, r1, #0x2000
	mov r3, #0x4000
	str r5, [sp]
	bl SailSailerBoat__Func_217E788
	mov r0, #0x4000
	str r0, [r6, #4]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #6
	bgt _0217B378
	cmp r0, #0
	addge pc, pc, r0, lsl #2
	b _0217B3AC
_0217B35C: // jump table
	b _0217B3AC // case 0
	b _0217B3AC // case 1
	b _0217B3AC // case 2
	b _0217B384 // case 3
	b _0217B394 // case 4
	b _0217B394 // case 5
	b _0217B384 // case 6
_0217B378:
	cmp r0, #0x15
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, r5, r6, pc}
_0217B384:
	mov r0, r6
	bl SailSailerBoat__Func_217B3B8
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217B394:
	mov r0, r6
	bl SailSailerBoat__Func_217B018
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217B3A4:
	mov r0, r6
	bl SailSailerBoat__Func_217B960
_0217B3AC:
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0217B3B4: .word 0x00007FFF
	arm_func_end SailSailerBoat__State_217B220

	arm_func_start SailSailerBoat__Func_217B3B8
SailSailerBoat__Func_217B3B8: // 0x0217B3B8
	ldr r1, _0217B3C4 // =SailSailerBoat__State_217B3C8
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_0217B3C4: .word SailSailerBoat__State_217B3C8
	arm_func_end SailSailerBoat__Func_217B3B8

	arm_func_start SailSailerBoat__State_217B3C8
SailSailerBoat__State_217B3C8: // 0x0217B3C8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #7
	blo _0217B4E0
	cmp r0, #0xa
	bhi _0217B4E0
	ldr r0, [r5, #0x28]
	cmp r0, #0x2a
	blo _0217B4C8
	bne _0217B410
	ldr r0, [r5, #0x138]
	add r2, r5, #0x44
	mov r1, #0x2e
	bl SailAudio__PlaySpatialSequence
_0217B410:
	ldr r0, [r4, #0x174]
	cmp r0, #0x3400
	blt _0217B44C
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r1, r1, #0x20
	orr r2, r1, #0x8000
	mov r1, #5
	str r2, [r5, #0x24]
	bl SailObject__SetLightColors
	mov r0, #0
	str r0, [r4, #0x180]
	mov r0, #0x3400
	str r0, [r4, #0x174]
	b _0217B4B0
_0217B44C:
	ldr r0, [r4, #0x180]
	mov r1, #0x30
	mov r2, #0x300
	bl ObjSpdUpSet
	str r0, [r4, #0x180]
	ldr r0, [r5, #0x28]
	tst r0, #0xf
	bne _0217B4B0
	mov r0, r5
	bl EffectSailWaterSplash2__Create
	ldr r2, [r0, #0x24]
	mov r1, #0x800
	orr r2, r2, #1
	str r2, [r0, #0x24]
	ldr r3, [r0, #0x38]
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #0xb
	adds ip, r1, r3, lsl #11
	orr r2, r2, r3, lsr #21
	adc r1, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x38]
	str r2, [r0, #0x3c]
	str r2, [r0, #0x40]
_0217B4B0:
	ldr r0, [r4, #0x184]
	mvn r1, #0x7f
	mov r2, #0x600
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
	b _0217B4D0
_0217B4C8:
	mov r0, r5
	bl SailSailerBoat__Func_217AE48
_0217B4D0:
	ldr r0, [r5, #0x28]
	add r0, r0, #1
	str r0, [r5, #0x28]
	b _0217B4FC
_0217B4E0:
	mov r0, r5
	bl SailSailerBoat__Func_217AE48
	ldr r0, [r4, #0x184]
	mvn r1, #0x7f
	mov r2, #0x600
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
_0217B4FC:
	ldr r0, [r4, #0x17c]
	mov r1, #0x40
	bl ObjSpdDownSet
	str r0, [r4, #0x17c]
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r5
	add r1, r1, #0x8000
	strh r1, [r5, #0x32]
	ldrh r2, [r5, #0x32]
	ldr r1, [r4, #0x17c]
	sub r1, r2, r1, lsl #2
	strh r1, [r5, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSailerBoat__State_217B3C8

	arm_func_start SailSailerBoat__Func_217B540
SailSailerBoat__Func_217B540: // 0x0217B540
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r1, [r5, #0x24]
	ldr r4, [r5, #0x124]
	tst r1, #0x8000
	beq _0217B560
	bl SailSailerBoat__Func_217B760
	ldmia sp!, {r3, r4, r5, pc}
_0217B560:
	ldr r2, _0217B59C // =SailSailerBoat__State_217B5A0
	add r1, r4, #0xa0
	str r2, [r5, #0xf4]
	mov r3, #0
	mov r2, #1
	str r3, [r5, #0x28]
	bl SailObject__SetupHitbox
	mov r0, r5
	mov r1, #1
	mov r2, #0x1e00
	mov r3, #0
	bl SailObject__Func_21658D0
	mov r0, #0x40000
	str r0, [r4, #0x110]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217B59C: .word SailSailerBoat__State_217B5A0
	arm_func_end SailSailerBoat__Func_217B540

	arm_func_start SailSailerBoat__State_217B5A0
SailSailerBoat__State_217B5A0: // 0x0217B5A0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r0, [r4, #0x170]
	cmp r0, #0
	bge _0217B5DC
	ldr r1, [r5, #0x28]
	mov r0, #0x4000
	sub r1, r1, #0x200
	rsb r0, r0, #0
	str r1, [r5, #0x28]
	cmp r1, r0
	strlo r0, [r5, #0x28]
	b _0217B5F4
_0217B5DC:
	ldr r0, [r5, #0x28]
	add r0, r0, #0x200
	str r0, [r5, #0x28]
	cmp r0, #0x4000
	movhi r0, #0x4000
	strhi r0, [r5, #0x28]
_0217B5F4:
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r5
	add r1, r1, #0x8000
	strh r1, [r5, #0x32]
	ldrh r2, [r5, #0x32]
	ldr r1, [r5, #0x28]
	add r1, r2, r1
	strh r1, [r5, #0x32]
	bl SailObject__ApplyRotation
	ldr r0, [r5, #0x28]
	mov r1, #0x600
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r2, r0, asr #4
	ldr r0, _0217B75C // =FX_SinCosTable_
	mov r2, r2, lsl #2
	ldrsh r3, [r0, r2]
	rsb r1, r1, #0
	mvn r2, #0
	umull lr, ip, r3, r1
	mla ip, r3, r2, ip
	mov r2, r3, asr #0x1f
	mla ip, r2, r1, ip
	adds lr, lr, #0x800
	adc r1, ip, #0
	mov r2, lr, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x17c]
	ldr r1, [r5, #0x28]
	mov r2, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #1
	ldrsh r1, [r0, r1]
	mov r0, #0x600
	umull ip, r3, r1, r0
	mla r3, r1, r2, r3
	mov r1, r1, asr #0x1f
	mla r3, r1, r0, r3
	adds ip, ip, #0x800
	adc r0, r3, #0
	mov r1, ip, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x184]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #1
	ldrne r0, [r4, #0x184]
	rsbne r0, r0, #0
	strne r0, [r4, #0x184]
	mov r0, r5
	bl SailSailerBoat__Func_217AE48
	ldr r0, [r4, #0x184]
	mvn r1, #0x7f
	bl ObjSpdDownSet
	str r0, [r4, #0x184]
	mov r0, r5
	bl SailObject__Func_2166A2C
	mov r0, r5
	mov r1, #1
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r5, #0x44
	bl EffectSailBomb__Create
	ldr r3, [r0, #0x38]
	mov r1, #0x800
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #0xd
	adds r4, r1, r3, lsl #13
	orr r2, r2, r3, lsr #19
	adc r1, r2, #0
	mov r2, r4, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x38]
	str r2, [r0, #0x3c]
	str r2, [r0, #0x40]
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217B75C: .word FX_SinCosTable_
	arm_func_end SailSailerBoat__State_217B5A0

	arm_func_start SailSailerBoat__Func_217B760
SailSailerBoat__Func_217B760: // 0x0217B760
	stmdb sp!, {r4, lr}
	ldr r1, _0217B7A4 // =SailSailerBoat__State_217B7A8
	mov r4, r0
	str r1, [r4, #0xf4]
	mov r1, #0
	str r1, [r4, #0x2c]
	str r1, [r4, #0x28]
	ldr r2, [r4, #0x24]
	bic r2, r2, #0x20
	bic r2, r2, #0x8000
	str r2, [r4, #0x24]
	bl SailObject__SetLightColors
	ldr r0, [r4, #0x138]
	add r2, r4, #0x44
	mov r1, #0x2e
	bl SailAudio__PlaySpatialSequence
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217B7A4: .word SailSailerBoat__State_217B7A8
	arm_func_end SailSailerBoat__Func_217B760

	arm_func_start SailSailerBoat__State_217B7A8
SailSailerBoat__State_217B7A8: // 0x0217B7A8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #0x1b
	beq _0217B7D8
	ldr r0, [r4, #0x184]
	mov r1, #0x50
	bl ObjSpdDownSet
	str r0, [r4, #0x184]
_0217B7D8:
	ldr r0, [r4, #0x180]
	mvn r1, #0x7f
	mov r2, #0x600
	bl ObjSpdUpSet
	str r0, [r4, #0x180]
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r5
	add r1, r1, #0x8000
	strh r1, [r5, #0x32]
	bl SailObject__ApplyRotation
	ldr r0, [r4, #0x174]
	cmp r0, #0
	blt _0217B81C
	ldr r0, [r5, #0x2c]
	cmp r0, #0
	beq _0217B8F4
_0217B81C:
	ldr r0, [r5, #0x2c]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r4, #0x174]
	streq r0, [r4, #0x180]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #0x1b
	mov r0, r5
	blo _0217B854
	bl SailObject__Func_2166A2C
	mov r0, r5
	bl SailSailerBoat__Func_217B540
	ldmia sp!, {r3, r4, r5, pc}
_0217B854:
	bl SailSailerBoat__Func_217AE48
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r5, #0x28]
	cmp r0, #0x2a
	bls _0217B94C
	ldr ip, _0217B95C // =0x00007FFF
	mov r1, #0
	mov r0, r5
	sub r2, r1, #0x2000
	mov r3, #0x4000
	str ip, [sp]
	bl SailSailerBoat__Func_217E788
	mov r0, #0x4000
	str r0, [r5, #4]
	mov r0, #0
	str r0, [r5, #0x2c]
	str r0, [r5, #0x28]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	b _0217B8F0
_0217B8B0: // jump table
	b _0217B8F0 // case 0
	b _0217B8F0 // case 1
	b _0217B8F0 // case 2
	b _0217B8F0 // case 3
	b _0217B8F0 // case 4
	b _0217B8F0 // case 5
	b _0217B8F0 // case 6
	b _0217B8DC // case 7
	b _0217B8E8 // case 8
	b _0217B8E8 // case 9
	b _0217B8DC // case 10
_0217B8DC:
	mov r0, r5
	bl SailSailerBoat__Func_217B3B8
	ldmia sp!, {r3, r4, r5, pc}
_0217B8E8:
	mov r0, r5
	bl SailSailerBoat__Func_217B018
_0217B8F0:
	ldmia sp!, {r3, r4, r5, pc}
_0217B8F4:
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r5, #0x28]
	tst r0, #7
	bne _0217B94C
	mov r0, r5
	bl EffectSailWaterSplash2__Create
	ldr r2, [r0, #0x24]
	mov r1, #0x800
	orr r2, r2, #1
	str r2, [r0, #0x24]
	ldr r4, [r0, #0x38]
	mov r2, r4, asr #0x1f
	mov r2, r2, lsl #0xb
	adds r3, r1, r4, lsl #11
	orr r2, r2, r4, lsr #21
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x38]
	str r4, [r0, #0x3c]
	str r2, [r0, #0x40]
_0217B94C:
	ldr r0, [r5, #0x28]
	add r0, r0, #1
	str r0, [r5, #0x28]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217B95C: .word 0x00007FFF
	arm_func_end SailSailerBoat__State_217B7A8

	arm_func_start SailSailerBoat__Func_217B960
SailSailerBoat__Func_217B960: // 0x0217B960
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, [r0, #0x124]
	ldr r2, _0217BA44 // =SailSailerBoat__State_217BA54
	add r3, r1, #0x100
	str r2, [r0, #0xf4]
	ldrh r2, [r3, #0x2c]
	ldr r4, _0217BA48 // =_mt_math_rand
	ldr ip, _0217BA4C // =0x00196225
	bic r2, r2, #0xf
	strh r2, [r3, #0x2c]
	ldr r2, [r4, #0]
	ldr lr, _0217BA50 // =0x3C6EF35F
	mla r5, r2, ip, lr
	mov r2, r5, lsr #0x10
	mov r2, r2, lsl #0x10
	str r5, [r4]
	mov r2, r2, lsr #0x10
	and r2, r2, #0xf
	ldrh r5, [r3, #0x2c]
	mov r2, r2, lsl #0x10
	orr r2, r5, r2, lsr #16
	strh r2, [r3, #0x2c]
	ldr r2, [r4, #0]
	mla r3, r2, ip, lr
	mov r2, r3, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	and r2, r2, #0x1f
	str r3, [r4]
	rsb r2, r2, #0x30
	str r2, [r0, #0x28]
	ldr r0, [r4, #0]
	ldr r3, _0217BA48 // =_mt_math_rand
	mla r2, r0, ip, lr
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #3
	movne r0, #0x1000
	str r2, [r4]
	moveq r0, #0x1c00
	str r0, [r1, #0x144]
	ldr r0, _0217BA4C // =0x00196225
	ldr r4, [r3, #0]
	ldr r2, _0217BA50 // =0x3C6EF35F
	mla r2, r4, r0, r2
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add r0, r0, #0x40
	str r2, [r3]
	and r0, r0, #0x1f
	str r0, [r1, #0x128]
	ldr r0, [r1, #0x148]
	add r0, r0, #1
	str r0, [r1, #0x148]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217BA44: .word SailSailerBoat__State_217BA54
_0217BA48: .word _mt_math_rand
_0217BA4C: .word 0x00196225
_0217BA50: .word 0x3C6EF35F
	arm_func_end SailSailerBoat__Func_217B960

	arm_func_start SailSailerBoat__State_217BA54
SailSailerBoat__State_217BA54: // 0x0217BA54
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r0, _0217BE2C // =SailSailerBoat__State_217BA54
	str r0, [r6, #0xf4]
	ldr r0, [r6, #0x28]
	cmp r0, #0
	beq _0217BBE8
	ldr ip, [r4, #0x144]
	mvn r2, #0
	sub r5, r2, #0x7f
	umull r1, r3, ip, r5
	mov r0, ip, asr #0x1f
	mov r11, #0x500
	mla r3, ip, r2, r3
	mov r10, #0x2c0
	mov r9, r0, lsl #7
	mov r8, r0, lsl #6
	add r2, r4, #0x100
	adds r1, r1, #0x800
	mla r3, r0, r5, r3
	mov lr, #0
	adc r3, r3, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r3, lsl #20
	ldrh r7, [r2, #0x2c]
	mov r5, #0x800
	orr r9, r9, ip, lsr #25
	orr r8, r8, ip, lsr #26
	umull r2, r3, ip, r11
	adds r2, r2, #0x800
	mov r2, r2, lsr #0xc
	mla r3, ip, lr, r3
	mla r3, r0, r11, r3
	adc r3, r3, #0
	orr r2, r2, r3, lsl #20
	adds r3, r5, ip, lsl #7
	adc r9, r9, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r9, lsl #20
	adds r5, r5, ip, lsl #6
	adc r8, r8, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r8, lsl #20
	umull r9, r8, ip, r10
	mla r8, ip, lr, r8
	mla r8, r0, r10, r8
	adds r9, r9, #0x800
	adc r0, r8, #0
	mov r8, r9, lsr #0xc
	orr r8, r8, r0, lsl #20
	tst r7, #1
	beq _0217BB3C
	ldr r0, [r4, #0x184]
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
	b _0217BB84
_0217BB3C:
	tst r7, #2
	ldr r0, [r4, #0x184]
	beq _0217BB58
	mov r1, r3
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
	b _0217BB84
_0217BB58:
	cmp r0, #0x500
	ble _0217BB70
	mov r1, #0x80
	bl ObjSpdDownSet
	str r0, [r4, #0x184]
	b _0217BB84
_0217BB70:
	bge _0217BB84
	mov r2, r11
	mov r1, #0x80
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
_0217BB84:
	add r0, r4, #0x100
	ldrh r0, [r0, #0x2c]
	tst r0, #4
	beq _0217BBAC
	ldr r0, [r4, #0x17c]
	mov r1, r5
	mov r2, r8
	bl ObjSpdUpSet
	str r0, [r4, #0x17c]
	b _0217BBD8
_0217BBAC:
	tst r0, #8
	ldr r0, [r4, #0x17c]
	beq _0217BBCC
	mov r2, r8
	rsb r1, r5, #0
	bl ObjSpdUpSet
	str r0, [r4, #0x17c]
	b _0217BBD8
_0217BBCC:
	mov r1, #0x40
	bl ObjSpdDownSet
	str r0, [r4, #0x17c]
_0217BBD8:
	ldr r0, [r6, #0x28]
	sub r0, r0, #1
	str r0, [r6, #0x28]
	b _0217BC08
_0217BBE8:
	ldr r0, [r4, #0x17c]
	mov r1, #0x40
	bl ObjSpdDownSet
	str r0, [r4, #0x17c]
	ldr r0, [r4, #0x184]
	mov r1, #0x80
	bl ObjSpdDownSet
	str r0, [r4, #0x184]
_0217BC08:
	ldr r0, [r6, #0x24]
	tst r0, #0x4000
	beq _0217BC2C
	tst r0, #0x20
	beq _0217BC34
	add r0, r4, #0x100
	ldrh r0, [r0, #0x2c]
	tst r0, #0x10
	bne _0217BC34
_0217BC2C:
	mov r0, r6
	bl SailSailerBoat__Func_217AE48
_0217BC34:
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r6
	add r1, r1, #0x8000
	strh r1, [r6, #0x32]
	ldrh r2, [r6, #0x32]
	ldr r1, [r4, #0x17c]
	sub r1, r2, r1, lsl #2
	strh r1, [r6, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r6
	bl SailObject__Func_2166A2C
	mov r0, r6
	bl SailSailerBoat__Func_217FE54
	ldr r0, [r4, #0x13c]
	sub r0, r0, #1
	str r0, [r4, #0x13c]
	cmp r0, #0
	bgt _0217BCE0
	mov r0, #0
	str r0, [r6, #0x2c]
	str r0, [r6, #0x28]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #9
	addls pc, pc, r0, lsl #2
	b _0217BCC8
_0217BCA0: // jump table
	b _0217BCC8 // case 0
	b _0217BCC8 // case 1
	b _0217BCC8 // case 2
	b _0217BCC8 // case 3
	b _0217BCD4 // case 4
	b _0217BCD4 // case 5
	b _0217BCC8 // case 6
	b _0217BCC8 // case 7
	b _0217BCD4 // case 8
	b _0217BCD4 // case 9
_0217BCC8:
	mov r0, r6
	bl SailSailerBoat__Func_217B3B8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0217BCD4:
	mov r0, r6
	bl SailSailerBoat__Func_217B018
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0217BCE0:
	ldr r0, [r6, #0x24]
	tst r0, #0x4000
	beq _0217BDCC
	tst r0, #0x20
	bne _0217BDCC
	ldr r0, [r6, #0x2c]
	add r0, r0, #1
	str r0, [r6, #0x2c]
	ldr r0, [r4, #0x140]
	cmp r0, #0
	beq _0217BD2C
	subs r0, r0, #1
	str r0, [r4, #0x140]
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r6, #0x138]
	add r2, r6, #0x44
	mov r1, #0x2e
	bl SailAudio__PlaySpatialSequence
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0217BD2C:
	ldr r0, [r4, #0x180]
	mov r1, #0x30
	mov r2, #0x300
	bl ObjSpdUpSet
	str r0, [r4, #0x180]
	ldr r0, [r6, #0x2c]
	tst r0, #0xf
	bne _0217BD90
	mov r0, r6
	bl EffectSailWaterSplash2__Create
	ldr r2, [r0, #0x24]
	mov r1, #0x800
	orr r2, r2, #1
	str r2, [r0, #0x24]
	ldr r3, [r0, #0x38]
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #0xb
	adds r5, r1, r3, lsl #11
	orr r2, r2, r3, lsr #21
	adc r1, r2, #0
	mov r2, r5, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x38]
	str r2, [r0, #0x3c]
	str r2, [r0, #0x40]
_0217BD90:
	ldr r0, [r4, #0x174]
	cmp r0, #0x3400
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [r6, #0x24]
	mov r0, r6
	orr r1, r1, #0x20
	orr r2, r1, #0x8000
	mov r1, #5
	str r2, [r6, #0x24]
	bl SailObject__SetLightColors
	mov r0, #0
	str r0, [r4, #0x180]
	mov r0, #0x3400
	str r0, [r4, #0x174]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0217BDCC:
	ldr r0, [r4, #0x128]
	subs r0, r0, #1
	str r0, [r4, #0x128]
	ldmplia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r2, _0217BE30 // =_mt_math_rand
	ldr r0, _0217BE34 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _0217BE38 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #3
	beq _0217BE20
	ldr r0, [r4, #0x148]
	cmp r0, #6
	bge _0217BE20
	mov r0, r6
	bl SailSailerBoat__Func_217B960
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0217BE20:
	mov r0, r6
	bl SailSailerBoat__Func_217BE3C
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0217BE2C: .word SailSailerBoat__State_217BA54
_0217BE30: .word _mt_math_rand
_0217BE34: .word 0x00196225
_0217BE38: .word 0x3C6EF35F
	arm_func_end SailSailerBoat__State_217BA54

	arm_func_start SailSailerBoat__Func_217BE3C
SailSailerBoat__Func_217BE3C: // 0x0217BE3C
	stmdb sp!, {r4, lr}
	ldr r4, [r0, #0x124]
	ldr r2, _0217BFC0 // =0x3C6EF35F
	ldr r1, [r4, #0x164]
	ldrh r1, [r1, #0x30]
	cmp r1, #0x16
	ldr r1, _0217BFC4 // =0x00196225
	beq _0217BE88
	ldr r3, _0217BFC8 // =_mt_math_rand
	ldr ip, _0217BFCC // =_0218C41C
	ldr lr, [r3]
	mla r2, lr, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #7
	str r2, [r3]
	ldrb r1, [ip, r1]
	b _0217BEB0
_0217BE88:
	ldr r3, _0217BFC8 // =_mt_math_rand
	ldr ip, _0217BFD0 // =_0218C414
	ldr lr, [r3]
	mla r2, lr, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #7
	ldrb r1, [ip, r1]
	str r2, [r3]
_0217BEB0:
	str r1, [r4, #0x138]
	add r2, r4, #0x100
	ldrh lr, [r2, #0x2c]
	cmp r1, #0
	ldr ip, _0217BFD4 // =SailSailerBoat__State_217BFD8
	bic lr, lr, #0x20
	strh lr, [r2, #0x2c]
	mov r3, #0
	str ip, [r0, #0xf4]
	str r3, [r4, #0x128]
	cmpne r1, #3
	strh r3, [r2, #0x2c]
	cmpne r1, #6
	moveq r2, #8
	streq r2, [r0, #0x28]
	movne r2, #0x18
	strne r2, [r0, #0x28]
	ldr r2, [r0, #0x28]
	cmp r1, #8
	add r2, r2, #0xc
	str r2, [r4, #0x128]
	addls pc, pc, r1, lsl #2
	b _0217BF64
_0217BF0C: // jump table
	b _0217BF64 // case 0
	b _0217BF30 // case 1
	b _0217BF4C // case 2
	b _0217BF64 // case 3
	b _0217BF30 // case 4
	b _0217BF4C // case 5
	b _0217BF64 // case 6
	b _0217BF30 // case 7
	b _0217BF4C // case 8
_0217BF30:
	ldr r2, [r0, #0x28]
	add r2, r2, #8
	str r2, [r0, #0x28]
	ldr r2, [r4, #0x128]
	add r2, r2, #0xc
	str r2, [r4, #0x128]
	b _0217BF64
_0217BF4C:
	ldr r2, [r0, #0x28]
	add r2, r2, #0xe
	str r2, [r0, #0x28]
	ldr r2, [r4, #0x128]
	add r2, r2, #0x14
	str r2, [r4, #0x128]
_0217BF64:
	cmp r1, #6
	blt _0217BF74
	cmp r1, #8
	ble _0217BFB4
_0217BF74:
	ldr r1, [r0, #0x24]
	add r2, r4, #0x100
	tst r1, #0x8000
	movne r1, #0
	strne r1, [r0, #0x2c]
	ldr r1, [r0, #0x24]
	bic r1, r1, #0x20
	str r1, [r0, #0x24]
	ldrh r3, [r2, #0x2c]
	mov r1, #0
	orr r3, r3, #0x10
	strh r3, [r2, #0x2c]
	ldr r2, [r0, #0x24]
	bic r2, r2, #0x8000
	str r2, [r0, #0x24]
	bl SailObject__SetLightColors
_0217BFB4:
	mov r0, #0
	str r0, [r4, #0x148]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217BFC0: .word 0x3C6EF35F
_0217BFC4: .word 0x00196225
_0217BFC8: .word _mt_math_rand
_0217BFCC: .word _0218C41C
_0217BFD0: .word _0218C414
_0217BFD4: .word SailSailerBoat__State_217BFD8
	arm_func_end SailSailerBoat__Func_217BE3C

	arm_func_start SailSailerBoat__State_217BFD8
SailSailerBoat__State_217BFD8: // 0x0217BFD8
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r4, [r5, #0x124]
	mov r1, #0x40
	ldr r0, [r4, #0x17c]
	bl ObjSpdDownSet
	str r0, [r4, #0x17c]
	ldr r0, [r4, #0x184]
	mov r1, #0x80
	bl ObjSpdDownSet
	str r0, [r4, #0x184]
	ldr r0, [r5, #0x24]
	tst r0, #0x4000
	beq _0217C02C
	tst r0, #0x20
	beq _0217C034
	add r0, r4, #0x100
	ldrh r0, [r0, #0x2c]
	tst r0, #0x10
	bne _0217C034
_0217C02C:
	mov r0, r5
	bl SailSailerBoat__Func_217AE48
_0217C034:
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r5
	add r1, r1, #0x8000
	strh r1, [r5, #0x32]
	ldrh r2, [r5, #0x32]
	ldr r1, [r4, #0x17c]
	sub r1, r2, r1, lsl #2
	strh r1, [r5, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r5
	bl SailObject__Func_2166A2C
	mov r0, r5
	bl SailSailerBoat__Func_217FE54
	ldr r0, [r5, #0x24]
	tst r0, #0x4000
	beq _0217C150
	add r0, r4, #0x100
	ldrh r0, [r0, #0x2c]
	tst r0, #0x10
	beq _0217C150
	ldr r0, [r5, #0x2c]
	cmp r0, #0
	bne _0217C0A4
	ldr r0, [r5, #0x138]
	add r2, r5, #0x44
	mov r1, #0x2e
	bl SailAudio__PlaySpatialSequence
_0217C0A4:
	ldr r0, [r5, #0x2c]
	mvn r1, #0x7f
	add r0, r0, #1
	str r0, [r5, #0x2c]
	ldr r0, [r4, #0x180]
	mov r2, #0x600
	bl ObjSpdUpSet
	str r0, [r4, #0x180]
	ldr r0, [r5, #0x2c]
	tst r0, #7
	bne _0217C114
	mov r0, r5
	bl EffectSailWaterSplash2__Create
	ldr r2, [r0, #0x24]
	mov r1, #0x800
	orr r2, r2, #1
	str r2, [r0, #0x24]
	ldr r5, [r0, #0x38]
	mov r2, r5, asr #0x1f
	mov r2, r2, lsl #0xb
	adds r3, r1, r5, lsl #11
	orr r2, r2, r5, lsr #21
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x38]
	str r5, [r0, #0x3c]
	str r2, [r0, #0x40]
_0217C114:
	ldr r0, [r4, #0x174]
	cmp r0, #0
	addge sp, sp, #4
	ldmgeia sp!, {r3, r4, r5, r6, pc}
	mov r0, #0
	str r0, [r4, #0x174]
	str r0, [r4, #0x180]
	add r0, r4, #0x100
	ldrh r2, [r0, #0x2c]
	mov r1, #0x14
	add sp, sp, #4
	bic r2, r2, #0x10
	strh r2, [r0, #0x2c]
	str r1, [r4, #0x140]
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217C150:
	ldr r0, [r5, #0x28]
	cmp r0, #0
	beq _0217C2AC
	sub r0, r0, #1
	str r0, [r5, #0x28]
	add r0, r4, #0x100
	ldrh r0, [r0, #0x2c]
	tst r0, #0x20
	ldreq r0, [r5, #4]
	cmpeq r0, #0
	moveq r0, #0x4000
	streq r0, [r5, #4]
	ldr r0, [r5, #0x28]
	cmp r0, #0
	bne _0217C2AC
	add r0, r4, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #0x20
	strh r1, [r0, #0x2c]
	ldr r0, [r4, #0x138]
	cmp r0, #8
	addls pc, pc, r0, lsl #2
	b _0217C2AC
_0217C1AC: // jump table
	b _0217C1E0 // case 0
	b _0217C1D0 // case 1
	b _0217C1D0 // case 2
	b _0217C218 // case 3
	b _0217C208 // case 4
	b _0217C208 // case 5
	b _0217C248 // case 6
	b _0217C238 // case 7
	b _0217C238 // case 8
_0217C1D0:
	sub r0, r0, #1
	str r0, [r4, #0x138]
	mov r0, #0xa
	str r0, [r5, #0x28]
_0217C1E0:
	ldr r6, _0217C34C // =0x00007FFF
	mov r1, #0
	mov r0, r5
	sub r2, r1, #0x2000
	mov r3, #0x4000
	str r6, [sp]
	bl SailSailerBoat__Func_217E788
	mov r0, #0x4000
	str r0, [r5, #4]
	b _0217C2AC
_0217C208:
	sub r0, r0, #1
	str r0, [r4, #0x138]
	mov r0, #0xa
	str r0, [r5, #0x28]
_0217C218:
	mov r1, #0
	mov r0, r5
	mov r3, r1
	sub r2, r1, #0x2000
	bl SpawnSailTorpedo2
	mov r0, #0x4000
	str r0, [r5, #4]
	b _0217C2AC
_0217C238:
	sub r0, r0, #1
	str r0, [r4, #0x138]
	mov r0, #0x18
	str r0, [r5, #0x28]
_0217C248:
	ldr r0, [r5, #0x44]
	ldr r1, [r5, #0x4c]
	rsb r0, r0, #0
	rsb r1, r1, #0
	bl FX_Atan2Idx
	ldr ip, _0217C350 // =_mt_math_rand
	ldr r1, _0217C354 // =0x00196225
	ldr r6, [ip]
	ldr r2, _0217C358 // =0x3C6EF35F
	ldr r3, _0217C35C // =0x00001FFE
	mla lr, r6, r1, r2
	mov r1, lr, lsr #0x10
	mov r1, r1, lsl #0x10
	and r1, r3, r1, lsr #16
	rsb r1, r1, r3, lsr #1
	add r0, r0, r1
	mov r1, r0, lsl #0x10
	mov r0, r5
	mov r2, r1, lsr #0x10
	add r1, r5, #0x44
	mov r3, #0xa00
	str lr, [ip]
	bl SailTorpedo__Create
	mov r0, #0x4000
	str r0, [r5, #4]
_0217C2AC:
	ldr r0, [r4, #0x13c]
	sub r0, r0, #1
	str r0, [r4, #0x13c]
	cmp r0, #0
	bgt _0217C328
	mov r0, #0
	str r0, [r5, #0x2c]
	str r0, [r5, #0x28]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #9
	addls pc, pc, r0, lsl #2
	b _0217C308
_0217C2E0: // jump table
	b _0217C308 // case 0
	b _0217C308 // case 1
	b _0217C308 // case 2
	b _0217C308 // case 3
	b _0217C318 // case 4
	b _0217C318 // case 5
	b _0217C308 // case 6
	b _0217C308 // case 7
	b _0217C318 // case 8
	b _0217C318 // case 9
_0217C308:
	mov r0, r5
	bl SailSailerBoat__Func_217B3B8
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217C318:
	mov r0, r5
	bl SailSailerBoat__Func_217B018
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217C328:
	ldr r0, [r4, #0x128]
	subs r0, r0, #1
	addpl sp, sp, #4
	str r0, [r4, #0x128]
	ldmplia sp!, {r3, r4, r5, r6, pc}
	mov r0, r5
	bl SailSailerBoat__Func_217B960
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0217C34C: .word 0x00007FFF
_0217C350: .word _mt_math_rand
_0217C354: .word 0x00196225
_0217C358: .word 0x3C6EF35F
_0217C35C: .word 0x00001FFE
	arm_func_end SailSailerBoat__State_217BFD8

	arm_func_start SailSailerBoat__Func_217C360
SailSailerBoat__Func_217C360: // 0x0217C360
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r4, [r0, #0x124]
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl SailManager__GetWork
	ldr r0, [r0, #0x98]
	ldr r1, [r4, #0x178]
	ldr r3, [r0, #0xc0]
	mov r2, r1, asr #0x13
	mov r1, #0x28
	mla r1, r2, r1, r3
	ldrsh r1, [r1, #0xa]
	ldr r3, [r0, #0x44]
	cmp r1, #0
	rsblt r1, r1, #0
	mov r1, r1, asr #2
	smull r2, r1, r6, r1
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	sub r1, r7, r2
	add r6, r3, r1
	str r6, [r4, #0x178]
	ldr r1, [r4, #0x138]
	mov r1, r1, lsl #0xc
	smull r3, r2, r1, r5
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	sub r3, r6, r2
	str r3, [r4, #0x178]
	mov r2, r3, asr #0x13
	mov r1, #0x28
	mul r5, r2, r1
	ldr r6, [r0, #0xc0]
	add r0, r6, r5
	bl SailVoyageManager__GetSegmentSize
	ldr r3, [r4, #0x178]
	ldr r2, _0217C42C // =0x0007FFFF
	mov r1, r0
	and r0, r3, r2
	bl FX_Div
	mov r1, r0
	add r0, r6, r5
	bl SailVoyageManager__GetAngleForSegmentPos
	add r1, r4, #0x100
	strh r0, [r1, #0x6e]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0217C42C: .word 0x0007FFFF
	arm_func_end SailSailerBoat__Func_217C360

	arm_func_start SailSailerBoat__Func_217C430
SailSailerBoat__Func_217C430: // 0x0217C430
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r1, [r4, #0x20]
	ldr r0, _0217C464 // =SailSailerBoat__State_217C468
	orr r1, r1, #0x20
	orr r1, r1, #0x1000
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x18]
	orr r1, r1, #2
	str r1, [r4, #0x18]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217C464: .word SailSailerBoat__State_217C468
	arm_func_end SailSailerBoat__Func_217C430

	arm_func_start SailSailerBoat__State_217C468
SailSailerBoat__State_217C468: // 0x0217C468
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r0, [r0, #0x98]
	ldr r1, [r4, #0x178]
	ldr r0, [r0, #0x44]
	subs r0, r1, r0
	ldmplia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x18]
	bic r0, r0, #2
	str r0, [r5, #0x18]
	ldr r0, [r5, #0x20]
	bic r0, r0, #0x1000
	str r0, [r5, #0x20]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	sub r0, r0, #0xb
	cmp r0, #9
	addls pc, pc, r0, lsl #2
	b _0217C4E4
_0217C4BC: // jump table
	b _0217C4E4 // case 0
	b _0217C4E4 // case 1
	b _0217C4F0 // case 2
	b _0217C4E4 // case 3
	b _0217C4E4 // case 4
	b _0217C4E4 // case 5
	b _0217C4E4 // case 6
	b _0217C4FC // case 7
	b _0217C4FC // case 8
	b _0217C4F0 // case 9
_0217C4E4:
	mov r0, r5
	bl SailSailerBoat__Func_217C508
	ldmia sp!, {r3, r4, r5, pc}
_0217C4F0:
	mov r0, r5
	bl SailSailerBoat__Func_217C944
	ldmia sp!, {r3, r4, r5, pc}
_0217C4FC:
	mov r0, r5
	bl SailSailerBoat__Func_217E3F0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSailerBoat__State_217C468

	arm_func_start SailSailerBoat__Func_217C508
SailSailerBoat__Func_217C508: // 0x0217C508
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r2, _0217C5C8 // =SailSailerBoat__State_217C5CC
	mov r1, #0x10000
	str r2, [r5, #0xf4]
	ldr r3, [r5, #0x24]
	mov r2, #0x8000
	orr ip, r3, #1
	mov r3, #0x400
	str ip, [r5, #0x24]
	bl SailSailerBoat__Func_217C360
	add r0, r4, #0x100
	ldrh r0, [r0, #0x6e]
	strh r0, [r5, #0x32]
	ldr r0, [r4, #0x170]
	ldrh r1, [r5, #0x32]
	cmp r0, #0
	mov r0, #0x1a00
	addlt r1, r1, #0x4000
	subge r1, r1, #0x4000
	rsbge r0, r0, #0
	strh r1, [r5, #0x32]
	str r0, [r4, #0x17c]
	mov r0, #0
	str r0, [r5, #0x28]
	str r0, [r4, #0x138]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x3c]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r0, #0]
	mov r1, #0
	subs r0, r0, #0x80
	rsbmi r0, r0, #0
	sub r2, r0, #0x48
	mov r0, #0x900
	umull r5, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r2, r5, #0x800
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x10
	str r0, [r4, #0x13c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217C5C8: .word SailSailerBoat__State_217C5CC
	arm_func_end SailSailerBoat__Func_217C508

	arm_func_start SailSailerBoat__State_217C5CC
SailSailerBoat__State_217C5CC: // 0x0217C5CC
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r1, [r5, #0x20]
	ldr r2, [r0, #0x98]
	bic r0, r1, #0x20
	str r0, [r5, #0x20]
	ldrsh r1, [r2, #0x38]
	cmp r1, #0
	ldrneh r0, [r5, #0x32]
	addne r0, r0, r1
	strneh r0, [r5, #0x32]
	ldr r0, [r5, #0x28]
	add r1, r0, #1
	str r1, [r5, #0x28]
	ldr r0, [r4, #0x13c]
	cmp r1, r0
	bls _0217C6E0
	ldr r0, [r4, #0x180]
	mvn r1, #0xff
	mov r2, #0x2800
	bl ObjSpdUpSet
	str r0, [r4, #0x180]
	ldr r0, [r4, #0x13c]
	ldr r1, [r5, #0x28]
	add r0, r0, #0x14
	cmp r1, r0
	bne _0217C6E8
	mov r0, r5
	add r1, r5, #0x44
	bl SailBomber3__Create
	cmp r0, #0
	beq _0217C6D0
	ldrh r1, [r5, #0x32]
	ldr ip, _0217C71C // =FX_SinCosTable_
	mov r2, #0
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #1
	ldrsh r3, [ip, r1]
	mov r1, #0xd00
	umull r6, lr, r3, r1
	mla lr, r3, r2, lr
	mov r3, r3, asr #0x1f
	adds r6, r6, #0x800
	mla lr, r3, r1, lr
	adc r3, lr, #0
	mov r6, r6, lsr #0xc
	orr r6, r6, r3, lsl #20
	str r6, [r0, #0xa0]
	ldrh r3, [r5, #0x32]
	mov r3, r3, asr #4
	mov r3, r3, lsl #2
	ldrsh r3, [ip, r3]
	umull lr, ip, r3, r1
	adds lr, lr, #0x800
	mla ip, r3, r2, ip
	mov r2, r3, asr #0x1f
	mla ip, r2, r1, ip
	adc r1, ip, #0
	mov r2, lr, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x98]
_0217C6D0:
	mov r0, #0x4000
	str r0, [r5, #4]
	str r0, [r5, #8]
	b _0217C6E8
_0217C6E0:
	mov r0, #0
	str r0, [r4, #0x180]
_0217C6E8:
	mov r0, r5
	bl SailObject__ApplyRotation
	mov r0, r5
	bl SailObject__Func_2166A2C
	mov r0, #0x10000
	ldr r1, [r4, #0x174]
	rsb r0, r0, #0
	cmp r1, r0
	ldmgeia sp!, {r4, r5, r6, pc}
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0217C71C: .word FX_SinCosTable_
	arm_func_end SailSailerBoat__State_217C5CC

	arm_func_start SailSailerBoat__Func_217C720
SailSailerBoat__Func_217C720: // 0x0217C720
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r1, _0217C7B0 // =SailSailerBoat__State_217C7B4
	str r1, [r5, #0xf4]
	ldr r1, [r5, #0x24]
	orr r1, r1, #1
	str r1, [r5, #0x24]
	bl SailObject__Func_2166728
	ldr r3, [r4, #0x10]
	ldr r0, [r5, #0x44]
	ldr r2, [r4, #0x18]
	ldr r1, [r5, #0x4c]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	strh r0, [r5, #0x32]
	mov r0, #0
	str r0, [r5, #0x2c]
	str r0, [r5, #0x28]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x3c]
	ldr r0, [r0, #0]
	subs r3, r0, #0x80
	rsbmi r3, r3, #0
	mov r0, r3, asr #0x1f
	mov r1, r0, lsl #9
	mov r0, #0x800
	adds r2, r0, r3, lsl #9
	orr r1, r1, r3, lsr #23
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x18
	str r0, [r4, #0x13c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217C7B0: .word SailSailerBoat__State_217C7B4
	arm_func_end SailSailerBoat__Func_217C720

	arm_func_start SailSailerBoat__State_217C7B4
SailSailerBoat__State_217C7B4: // 0x0217C7B4
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x24
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r5, [r0, #0x98]
	ldrsh r0, [r5, #0x38]
	cmp r0, #0
	beq _0217C830
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _0217C940 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0
	bl MTX_RotY33_
	add r0, r6, #0x44
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
	ldrh r1, [r6, #0x32]
	ldrsh r0, [r5, #0x38]
	add r0, r1, r0
	strh r0, [r6, #0x32]
_0217C830:
	ldr r0, [r6, #0x28]
	add r1, r0, #1
	str r1, [r6, #0x28]
	ldr r0, [r4, #0x13c]
	cmp r1, r0
	bls _0217C8AC
	ldr r0, [r6, #0x9c]
	mvn r1, #0xff
	mov r2, #0x2800
	bl ObjSpdUpSet
	str r0, [r6, #0x9c]
	ldr r0, [r4, #0x13c]
	ldr r1, [r6, #0x28]
	add r0, r0, #0x14
	cmp r1, r0
	bne _0217C8B4
	mov r0, r6
	add r1, r6, #0x44
	bl SailBomber3__Create
	cmp r0, #0
	beq _0217C89C
	ldr r1, [r6, #0x98]
	mov r1, r1, asr #1
	str r1, [r0, #0x98]
	ldr r1, [r6, #0xa0]
	mov r1, r1, asr #1
	str r1, [r0, #0xa0]
_0217C89C:
	mov r0, #0x4000
	str r0, [r6, #4]
	str r0, [r6, #8]
	b _0217C8B4
_0217C8AC:
	mov r0, #0
	str r0, [r6, #0x9c]
_0217C8B4:
	mov r0, r6
	bl SailObject__ApplyRotation
	ldrh r0, [r6, #0x32]
	ldr r3, _0217C940 // =FX_SinCosTable_
	mov r1, #0
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrsh r2, [r3, r0]
	mov r0, #0x1a00
	umull r5, r4, r2, r0
	mla r4, r2, r1, r4
	mov r2, r2, asr #0x1f
	adds r5, r5, #0x800
	mla r4, r2, r0, r4
	adc r2, r4, #0
	mov r4, r5, lsr #0xc
	orr r4, r4, r2, lsl #20
	str r4, [r6, #0xa0]
	ldrh r2, [r6, #0x32]
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r2, [r3, r2]
	umull r4, r3, r2, r0
	adds r4, r4, #0x800
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r4, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r6, #0x98]
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0217C940: .word FX_SinCosTable_
	arm_func_end SailSailerBoat__State_217C7B4

	arm_func_start SailSailerBoat__Func_217C944
SailSailerBoat__Func_217C944: // 0x0217C944
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r1, _0217C9E8 // =SailSailerBoat__State_217C9EC
	mov ip, #0
	str r1, [r5, #0xf4]
	ldr r2, [r5, #0x20]
	mov r1, #0x28000
	bic r2, r2, #0x1000
	str r2, [r5, #0x20]
	ldr r3, [r5, #0x18]
	mov r2, #0x8000
	bic r3, r3, #2
	str r3, [r5, #0x18]
	ldr lr, [r5, #0x24]
	mov r3, #0xc80
	orr lr, lr, #1
	str lr, [r5, #0x24]
	str ip, [r5, #0x2c]
	bl SailSailerBoat__Func_217C360
	ldr r0, [r4, #0x138]
	cmp r0, #0x20
	movgt r0, #1
	movle r0, #0
	str r0, [r4, #0x138]
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, #0x8000
	strh r1, [r5, #0x32]
	str r0, [r5, #0x28]
	ldr r0, [r4, #0x138]
	cmp r0, #0
	beq _0217C9DC
	ldrh r1, [r5, #0x32]
	mov r0, #0
	add r1, r1, #0x8000
	strh r1, [r5, #0x32]
	str r0, [r5, #0x28]
_0217C9DC:
	mov r0, #0x800
	str r0, [r4, #0x180]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217C9E8: .word SailSailerBoat__State_217C9EC
	arm_func_end SailSailerBoat__Func_217C944

	arm_func_start SailSailerBoat__State_217C9EC
SailSailerBoat__State_217C9EC: // 0x0217C9EC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r1, [r5, #0x20]
	ldr r2, [r0, #0x98]
	bic r0, r1, #0x20
	str r0, [r5, #0x20]
	ldrsh r1, [r2, #0x38]
	cmp r1, #0
	ldrneh r0, [r5, #0x32]
	addne r0, r0, r1
	strneh r0, [r5, #0x32]
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #0x3c
	blt _0217CA44
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
	b _0217CA80
_0217CA44:
	ldr r0, [r4, #0x138]
	cmp r0, #0
	ldrh r0, [r5, #0x32]
	beq _0217CA6C
	sub r0, r0, #0x260
	strh r0, [r5, #0x32]
	ldr r0, [r5, #0x28]
	add r0, r0, #0x260
	str r0, [r5, #0x28]
	b _0217CA80
_0217CA6C:
	add r0, r0, #0x260
	strh r0, [r5, #0x32]
	ldr r0, [r5, #0x28]
	sub r0, r0, #0x260
	str r0, [r5, #0x28]
_0217CA80:
	ldr r0, [r5, #0x2c]
	cmp r0, #0x10
	ldr r0, [r4, #0x180]
	bgt _0217CAA0
	mov r1, #0x100
	bl ObjSpdDownSet
	str r0, [r4, #0x180]
	b _0217CABC
_0217CAA0:
	mvn r1, #0x7f
	mov r2, #0x2000
	bl ObjSpdUpSet
	str r0, [r4, #0x180]
	ldrh r0, [r5, #0x30]
	sub r0, r0, #0xc0
	strh r0, [r5, #0x30]
_0217CABC:
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #0x14
	beq _0217CB08
	ldr r0, [r5, #0x2c]
	cmp r0, #0x10
	bne _0217CB08
	ldr r0, [r5, #0x44]
	ldr r1, [r5, #0x4c]
	rsb r0, r0, #0
	rsb r1, r1, #0
	bl FX_Atan2Idx
	mov r2, r0
	mov r0, r5
	add r1, r5, #0x44
	mov r3, #0xa00
	bl SailTorpedo__Create
	mov r0, #0x4000
	str r0, [r5, #4]
_0217CB08:
	mov r0, r5
	bl SailObject__ApplyRotation
	ldr r0, [r5, #0x28]
	ldr r1, _0217CBB8 // =FX_SinCosTable_
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrsh r0, [r1, r0]
	mov r3, #0x1a00
	mov ip, #0
	umull lr, r2, r0, r3
	mla r2, r0, ip, r2
	mov r0, r0, asr #0x1f
	adds lr, lr, #0x800
	mla r2, r0, r3, r2
	adc r0, r2, #0
	mov r2, lr, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [r4, #0x184]
	ldr r2, [r5, #0x28]
	mov r0, r5
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r1, [r1, r2]
	umull r5, r2, r1, r3
	adds r5, r5, #0x800
	mla r2, r1, ip, r2
	mov r1, r1, asr #0x1f
	mla r2, r1, r3, r2
	adc r1, r2, #0
	mov r2, r5, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x17c]
	bl SailObject__Func_2166A2C
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217CBB8: .word FX_SinCosTable_
	arm_func_end SailSailerBoat__State_217C9EC

	arm_func_start SailSailerBoat__Func_217CBBC
SailSailerBoat__Func_217CBBC: // 0x0217CBBC
	ldr r1, _0217CBD4 // =SailSailerBoat__State_217CBD8
	str r1, [r0, #0xf4]
	ldr r1, [r0, #0x24]
	bic r1, r1, #1
	str r1, [r0, #0x24]
	bx lr
	.align 2, 0
_0217CBD4: .word SailSailerBoat__State_217CBD8
	arm_func_end SailSailerBoat__Func_217CBBC

	arm_func_start SailSailerBoat__State_217CBD8
SailSailerBoat__State_217CBD8: // 0x0217CBD8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	mov r0, r4
	bl SailObject__Func_2166D18
	mov r0, r4
	bl SailObject__Func_2166A2C
	ldr r0, [r4, #0x44]
	ldr r1, [r4, #0x4c]
	rsb r0, r0, #0
	rsb r1, r1, #0
	bl FX_Atan2Idx
	strh r0, [r4, #0x32]
	mov r0, r4
	bl SailObject__ApplyRotation
	ldmia sp!, {r4, pc}
	arm_func_end SailSailerBoat__State_217CBD8

	arm_func_start SailSailerBoat__Func_217CC18
SailSailerBoat__Func_217CC18: // 0x0217CC18
	ldr r3, [r0, #0x124]
	ldr r2, _0217CC34 // =SailSailerBoat__State_217CC38
	mov r1, #0x400
	str r2, [r0, #0xf4]
	rsb r1, r1, #0
	str r1, [r3, #0x184]
	bx lr
	.align 2, 0
_0217CC34: .word SailSailerBoat__State_217CC38
	arm_func_end SailSailerBoat__Func_217CC18

	arm_func_start SailSailerBoat__State_217CC38
SailSailerBoat__State_217CC38: // 0x0217CC38
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r5, [r0, #0x98]
	mov r0, r6
	bl SailSailerBoat__Func_217AE48
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r6
	add r1, r1, #0x8000
	strh r1, [r6, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r6
	bl SailObject__Func_2166A2C
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6c]
	ldr r2, [r5, #0xc0]
	mov r0, #0x28
	mla r0, r1, r0, r2
	ldrsh r0, [r0, #0xa]
	mvn r1, #0
	cmp r0, #0
	rsblt r0, r0, #0
	mov r2, r0, asr #2
	mov r0, r1, lsl #0x10
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r2, ip, #0x800
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	ldr r3, [r4, #0x178]
	ldr r2, [r5, #0x44]
	add r0, r1, #0x14000
	sub r1, r3, r2
	cmp r1, r0
	ldmgeia sp!, {r4, r5, r6, pc}
	ldr r0, [r4, #0x138]
	cmp r0, #0
	bne _0217CD24
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	sub r0, r0, #0xe
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r4, r5, r6, pc}
_0217CCFC: // jump table
	b _0217CD0C // case 0
	b _0217CD18 // case 1
	b _0217CD18 // case 2
	b _0217CD0C // case 3
_0217CD0C:
	mov r0, r6
	bl SailSailerBoat__Func_217CF44
	ldmia sp!, {r4, r5, r6, pc}
_0217CD18:
	mov r0, r6
	bl SailSailerBoat__Func_217CD30
	ldmia sp!, {r4, r5, r6, pc}
_0217CD24:
	mov r0, r6
	bl SailSailerBoat__Func_217CFEC
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SailSailerBoat__State_217CC38

	arm_func_start SailSailerBoat__Func_217CD30
SailSailerBoat__Func_217CD30: // 0x0217CD30
	ldr r1, _0217CD3C // =SailSailerBoat__State_217CD40
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_0217CD3C: .word SailSailerBoat__State_217CD40
	arm_func_end SailSailerBoat__Func_217CD30

	arm_func_start SailSailerBoat__State_217CD40
SailSailerBoat__State_217CD40: // 0x0217CD40
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r5, [r4, #0x124]
	bl SailManager__GetWork
	mov r0, r4
	bl SailSailerBoat__Func_217AE48
	ldr r0, [r5, #0x17c]
	mov r1, #0x18
	bl ObjSpdDownSet
	str r0, [r5, #0x17c]
	ldr r0, [r5, #0x184]
	mov r1, #0x20
	mov r2, #0x600
	bl ObjSpdUpSet
	str r0, [r5, #0x184]
	add r0, r5, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r4
	add r1, r1, #0x8000
	strh r1, [r4, #0x32]
	ldr r1, [r5, #0x17c]
	ldrh r2, [r4, #0x32]
	sub r1, r2, r1, lsl #2
	strh r1, [r4, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r4
	bl SailObject__Func_2166A2C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSailerBoat__State_217CD40

	arm_func_start SailSailerBoat__Func_217CDB0
SailSailerBoat__Func_217CDB0: // 0x0217CDB0
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, [r0, #0x124]
	ldr r2, _0217CE34 // =SailSailerBoat__State_217CE3C
	mov r1, #0x600
	str r2, [r0, #0xf4]
	str r1, [r4, #0x184]
	bl SailManager__GetWork
	ldr r3, [r0, #0x98]
	mov r0, #0x28
	ldr r1, [r3, #0x44]
	sub r2, r1, #0x18000
	mov r1, r2, asr #0x13
	str r2, [r4, #0x178]
	mul r5, r1, r0
	ldr r6, [r3, #0xc0]
	add r0, r6, r5
	bl SailVoyageManager__GetSegmentSize
	ldr r3, [r4, #0x178]
	ldr r2, _0217CE38 // =0x0007FFFF
	mov r1, r0
	and r0, r3, r2
	bl FX_Div
	mov r1, r0
	add r0, r6, r5
	bl SailVoyageManager__GetAngleForSegmentPos
	add r1, r4, #0x100
	strh r0, [r1, #0x6e]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #0x17
	moveq r0, #0xa00
	streq r0, [r4, #0x184]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0217CE34: .word SailSailerBoat__State_217CE3C
_0217CE38: .word 0x0007FFFF
	arm_func_end SailSailerBoat__Func_217CDB0

	arm_func_start SailSailerBoat__State_217CE3C
SailSailerBoat__State_217CE3C: // 0x0217CE3C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r5, [r0, #0x98]
	mov r0, r6
	bl SailSailerBoat__Func_217AE48
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r6
	add r1, r1, #0x8000
	strh r1, [r6, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r6
	bl SailObject__Func_2166A2C
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6c]
	ldr r2, [r5, #0xc0]
	mov r0, #0x28
	mla r0, r1, r0, r2
	ldrsh r0, [r0, #0xa]
	mvn r1, #0
	cmp r0, #0
	rsblt r0, r0, #0
	mov r2, r0, asr #2
	mov r0, r1, lsl #0x10
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r2, ip, #0x800
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	ldr r3, [r4, #0x178]
	ldr r2, [r5, #0x44]
	add r0, r1, #0x14000
	sub r1, r3, r2
	cmp r1, r0
	ldmleia sp!, {r4, r5, r6, pc}
	ldr r0, [r4, #0x138]
	cmp r0, #0
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	bne _0217CF28
	arm_func_end SailSailerBoat__State_217CE3C

	arm_func_start SailSailerBoat__Func_217CEF0
SailSailerBoat__Func_217CEF0: // 0x0217CEF0
	sub r0, r0, #0xe
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r4, r5, r6, pc}
_0217CF00: // jump table
	b _0217CF10 // case 0
	b _0217CF1C // case 1
	b _0217CF1C // case 2
	b _0217CF10 // case 3
_0217CF10:
	mov r0, r6
	bl SailSailerBoat__Func_217CF44
	ldmia sp!, {r4, r5, r6, pc}
_0217CF1C:
	mov r0, r6
	bl SailSailerBoat__Func_217CD30
	ldmia sp!, {r4, r5, r6, pc}
_0217CF28:
	cmp r0, #0x17
	mov r0, r6
	bne _0217CF3C
	bl SailSailerBoat__Func_217D6DC
	ldmia sp!, {r4, r5, r6, pc}
_0217CF3C:
	bl SailSailerBoat__Func_217CFEC
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SailSailerBoat__Func_217CEF0

	arm_func_start SailSailerBoat__Func_217CF44
SailSailerBoat__Func_217CF44: // 0x0217CF44
	ldr r1, _0217CF50 // =SailSailerBoat__State_217CF54
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_0217CF50: .word SailSailerBoat__State_217CF54
	arm_func_end SailSailerBoat__Func_217CF44

	arm_func_start SailSailerBoat__State_217CF54
SailSailerBoat__State_217CF54: // 0x0217CF54
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	mov r0, r5
	bl SailSailerBoat__Func_217AE48
	ldr r0, [r4, #0x17c]
	mov r1, #0x18
	bl ObjSpdDownSet
	str r0, [r4, #0x17c]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #0x17
	bne _0217CFA4
	mov r1, #0x138
	ldr r0, [r4, #0x184]
	rsb r1, r1, #0
	mov r2, #0xa00
	bl ObjSpdUpSet
	b _0217CFB4
_0217CFA4:
	ldr r0, [r4, #0x184]
	mvn r1, #0x1f
	mov r2, #0x600
	bl ObjSpdUpSet
_0217CFB4:
	str r0, [r4, #0x184]
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r5
	add r1, r1, #0x8000
	strh r1, [r5, #0x32]
	ldrh r2, [r5, #0x32]
	ldr r1, [r4, #0x17c]
	sub r1, r2, r1, lsl #2
	strh r1, [r5, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSailerBoat__State_217CF54

	arm_func_start SailSailerBoat__Func_217CFEC
SailSailerBoat__Func_217CFEC: // 0x0217CFEC
	ldr r2, [r0, #0x124]
	ldr r1, _0217D024 // =SailSailerBoat__State_217D028
	str r1, [r0, #0xf4]
	ldr r1, [r2, #0x170]
	cmp r1, #0
	add r1, r2, #0x100
	ldrgth r2, [r1, #0x2c]
	orrgt r2, r2, #2
	ldrleh r2, [r1, #0x2c]
	orrle r2, r2, #1
	strh r2, [r1, #0x2c]
	mov r1, #0x64
	str r1, [r0, #0x28]
	bx lr
	.align 2, 0
_0217D024: .word SailSailerBoat__State_217D028
	arm_func_end SailSailerBoat__Func_217CFEC

	arm_func_start SailSailerBoat__State_217D028
SailSailerBoat__State_217D028: // 0x0217D028
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x28]
	ldr r4, [r5, #0x124]
	cmp r0, #0
	beq _0217D0F8
	add r0, r4, #0x100
	ldrh r0, [r0, #0x2c]
	tst r0, #1
	beq _0217D068
	ldr r0, [r4, #0x184]
	mov r1, #0x18
	mov r2, #0x300
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
	b _0217D094
_0217D068:
	tst r0, #2
	ldr r0, [r4, #0x184]
	beq _0217D088
	mvn r1, #0x17
	mov r2, #0x300
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
	b _0217D094
_0217D088:
	mov r1, #0x18
	bl ObjSpdDownSet
	str r0, [r4, #0x184]
_0217D094:
	add r0, r4, #0x100
	ldrh r0, [r0, #0x2c]
	tst r0, #4
	beq _0217D0BC
	ldr r0, [r4, #0x17c]
	mov r1, #0x18
	mov r2, #0x300
	bl ObjSpdUpSet
	str r0, [r4, #0x17c]
	b _0217D0E8
_0217D0BC:
	tst r0, #8
	ldr r0, [r4, #0x17c]
	beq _0217D0DC
	mvn r1, #0x17
	mov r2, #0x300
	bl ObjSpdUpSet
	str r0, [r4, #0x17c]
	b _0217D0E8
_0217D0DC:
	mov r1, #0x18
	bl ObjSpdDownSet
	str r0, [r4, #0x17c]
_0217D0E8:
	ldr r0, [r5, #0x28]
	sub r0, r0, #1
	str r0, [r5, #0x28]
	b _0217D118
_0217D0F8:
	ldr r0, [r4, #0x17c]
	mov r1, #0x18
	bl ObjSpdDownSet
	str r0, [r4, #0x17c]
	ldr r0, [r4, #0x184]
	mov r1, #0x18
	bl ObjSpdDownSet
	str r0, [r4, #0x184]
_0217D118:
	mov r0, r5
	bl SailSailerBoat__Func_217AE48
	add r0, r4, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r5
	add r1, r1, #0x8000
	strh r1, [r5, #0x32]
	ldrh r2, [r5, #0x32]
	ldr r1, [r4, #0x17c]
	sub r1, r2, r1, lsl #2
	strh r1, [r5, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r5
	bl SailObject__Func_2166A2C
	mov r0, r5
	bl SailSailerBoat__Func_217FE54
	mov r0, r5
	bl SailSailerBoat__Func_217D1B4
	ldr r0, [r4, #0x138]
	sub r0, r0, #1
	str r0, [r4, #0x138]
	cmp r0, #0
	ldmgtia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	sub r0, r0, #0xe
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r3, r4, r5, pc}
_0217D18C: // jump table
	b _0217D19C // case 0
	b _0217D1A8 // case 1
	b _0217D1A8 // case 2
	b _0217D19C // case 3
_0217D19C:
	mov r0, r5
	bl SailSailerBoat__Func_217CF44
	ldmia sp!, {r3, r4, r5, pc}
_0217D1A8:
	mov r0, r5
	bl SailSailerBoat__Func_217CD30
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSailerBoat__State_217D028

	arm_func_start SailSailerBoat__Func_217D1B4
SailSailerBoat__Func_217D1B4: // 0x0217D1B4
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x34
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r0, [r4, #0x128]
	cmp r0, #0
	bne _0217D3EC
	ldr r3, _0217D6C4 // =_mt_math_rand
	ldr r0, [r4, #0x148]
	ldr r6, [r3, #0]
	ldr r1, _0217D6C8 // =0x00196225
	ldr r2, _0217D6CC // =0x3C6EF35F
	mov r0, r0, lsl #0x10
	mla r2, r6, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0xf
	str r2, [r3]
	str r1, [r4, #0x148]
	cmp r1, #0xc
	mov r2, r0, lsr #0x10
	subge r0, r1, #0xc
	strge r0, [r4, #0x148]
	ldr r0, [r4, #0x148]
	cmp r0, r2
	addeq r0, r2, #1
	streq r0, [r5, #0x28]
	cmpeq r2, #0xc
	moveq r0, #0
	streq r0, [r5, #0x28]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #1
	beq _0217D2B0
	ldr r0, [r4, #0x148]
	cmp r0, #0xb
	addls pc, pc, r0, lsl #2
	b _0217D2B0
_0217D254: // jump table
	b _0217D2B0 // case 0
	b _0217D2B0 // case 1
	b _0217D2B0 // case 2
	b _0217D284 // case 3
	b _0217D2B0 // case 4
	b _0217D2B0 // case 5
	b _0217D2B0 // case 6
	b _0217D290 // case 7
	b _0217D2B0 // case 8
	b _0217D2B0 // case 9
	b _0217D29C // case 10
	b _0217D2A8 // case 11
_0217D284:
	mov r0, #0
	str r0, [r4, #0x148]
	b _0217D2B0
_0217D290:
	mov r0, #4
	str r0, [r4, #0x148]
	b _0217D2B0
_0217D29C:
	mov r0, #7
	str r0, [r4, #0x148]
	b _0217D2B0
_0217D2A8:
	mov r0, #8
	str r0, [r4, #0x148]
_0217D2B0:
	ldr r2, [r4, #0x148]
	ldr r1, _0217D6D0 // =_0218C428
	add r0, r4, #0x100
	ldrb r2, [r1, r2]
	ldr r3, _0217D6C4 // =_mt_math_rand
	ldr r1, _0217D6C8 // =0x00196225
	str r2, [r4, #0x14c]
	ldrh r6, [r0, #0x2c]
	ldr r2, _0217D6CC // =0x3C6EF35F
	bic r6, r6, #0x20
	strh r6, [r0, #0x2c]
	ldr r0, [r3, #0]
	mla r1, r0, r1, r2
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	str r1, [r3]
	add r0, r0, #0x20
	str r0, [r4, #0x128]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #1
	ldrne r0, [r4, #0x128]
	addne r0, r0, #0x32
	strne r0, [r4, #0x128]
	ldr r1, [r4, #0x11c]
	ldr r0, [r4, #0x120]
	cmp r1, r0, asr #1
	ldrlt r0, [r4, #0x128]
	sublt r0, r0, r0, asr #2
	strlt r0, [r4, #0x128]
	ldr r1, [r4, #0x128]
	ldr r0, [r4, #0x14c]
	add r0, r1, r0
	str r0, [r4, #0x128]
	ldr r0, [r5, #0x28]
	cmp r0, #0
	bne _0217D3EC
	ldr ip, _0217D6C4 // =_mt_math_rand
	ldr r2, _0217D6C8 // =0x00196225
	ldr r0, [ip]
	ldr r3, _0217D6CC // =0x3C6EF35F
	mla r1, r0, r2, r3
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [ip]
	tst r0, #3
	bne _0217D3EC
	add r1, r4, #0x100
	ldrh r0, [r1, #0x2c]
	mov lr, #1
	bic r0, r0, #0xf
	strh r0, [r1, #0x2c]
	ldr r0, [ip]
	mla r6, r0, r2, r3
	mov r0, r6, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r6, [ip]
	and r0, r0, #3
	mov r0, lr, lsl r0
	ldrh lr, [r1, #0x2c]
	mov r0, r0, lsl #0x10
	orr r0, lr, r0, lsr #16
	strh r0, [r1, #0x2c]
	ldr r0, [ip]
	mla r1, r0, r2, r3
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	str r1, [ip]
	add r0, r0, #0x40
	str r0, [r5, #0x28]
	ldr r0, [r4, #0x128]
	add r0, r0, #8
	str r0, [r4, #0x128]
_0217D3EC:
	ldr r0, [r4, #0x128]
	sub r0, r0, #1
	str r0, [r4, #0x128]
	ldr r0, [r4, #0x14c]
	cmp r0, #0
	addeq sp, sp, #0x34
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	sub r0, r0, #1
	str r0, [r4, #0x14c]
	ldr r1, [r4, #0x164]
	mov r0, #0
	ldr r1, [r1, #0x34]
	tst r1, #2
	addne sp, sp, #0x34
	ldmneia sp!, {r3, r4, r5, r6, pc}
	add r1, r4, #0x100
	ldrh r1, [r1, #0x2c]
	tst r1, #0x20
	ldreq r1, [r5, #4]
	cmpeq r1, #0
	moveq r1, #0x4000
	streq r1, [r5, #4]
	ldr r1, [r4, #0x148]
	cmp r1, #0xb
	addls pc, pc, r1, lsl #2
	b _0217D6BC
_0217D454: // jump table
	b _0217D4A8 // case 0
	b _0217D49C // case 1
	b _0217D490 // case 2
	b _0217D484 // case 3
	b _0217D524 // case 4
	b _0217D518 // case 5
	b _0217D50C // case 6
	b _0217D500 // case 7
	b _0217D598 // case 8
	b _0217D58C // case 9
	b _0217D580 // case 10
	b _0217D574 // case 11
_0217D484:
	ldr r1, [r4, #0x14c]
	cmp r1, #0x16
	moveq r0, #1
_0217D490:
	ldr r1, [r4, #0x14c]
	cmp r1, #0x10
	moveq r0, #1
_0217D49C:
	ldr r1, [r4, #0x14c]
	cmp r1, #0xa
	moveq r0, #1
_0217D4A8:
	ldr r1, [r4, #0x14c]
	cmp r1, #4
	bne _0217D4C8
	add r1, r4, #0x100
	ldrh r2, [r1, #0x2c]
	mov r0, #1
	orr r2, r2, #0x20
	strh r2, [r1, #0x2c]
_0217D4C8:
	cmp r0, #0
	addeq sp, sp, #0x34
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	mov r1, #0
	sub r2, r1, #0x4000
	ldr r4, _0217D6D4 // =0x00007FFF
	mov r0, r5
	mov r3, r2
	str r4, [sp]
	bl SailSailerBoat__Func_217E788
	mov r0, #0x4000
	add sp, sp, #0x34
	str r0, [r5, #4]
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217D500:
	ldr r1, [r4, #0x14c]
	cmp r1, #0x14
	moveq r0, #1
_0217D50C:
	ldr r1, [r4, #0x14c]
	cmp r1, #0x10
	moveq r0, #1
_0217D518:
	ldr r1, [r4, #0x14c]
	cmp r1, #0xc
	moveq r0, #1
_0217D524:
	ldr r1, [r4, #0x14c]
	cmp r1, #4
	bne _0217D544
	add r1, r4, #0x100
	ldrh r2, [r1, #0x2c]
	mov r0, #1
	orr r2, r2, #0x20
	strh r2, [r1, #0x2c]
_0217D544:
	cmp r0, #0
	addeq sp, sp, #0x34
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	mov r1, #0
	mov r0, r5
	mov r3, r1
	sub r2, r1, #0x4000
	bl SpawnSailTorpedo2
	mov r0, #0x4000
	add sp, sp, #0x34
	str r0, [r5, #4]
	ldmia sp!, {r3, r4, r5, r6, pc}
_0217D574:
	ldr r1, [r4, #0x14c]
	cmp r1, #0x32
	moveq r0, #1
_0217D580:
	ldr r1, [r4, #0x14c]
	cmp r1, #0x22
	moveq r0, #1
_0217D58C:
	ldr r1, [r4, #0x14c]
	cmp r1, #0x12
	moveq r0, #1
_0217D598:
	ldr r1, [r4, #0x14c]
	cmp r1, #2
	bne _0217D5B8
	add r1, r4, #0x100
	ldrh r2, [r1, #0x2c]
	mov r0, #1
	orr r2, r2, #0x20
	strh r2, [r1, #0x2c]
_0217D5B8:
	cmp r0, #0
	addeq sp, sp, #0x34
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r0, [r5, #0x44]
	ldr r1, [r5, #0x4c]
	rsb r0, r0, #0
	rsb r1, r1, #0
	bl FX_Atan2Idx
	add r2, r4, #0x100
	mov r1, r0
	ldrh r0, [r2, #0x6e]
	bl ObjRoopDiff16
	cmp r0, #0
	ldr r0, [r4, #0x14c]
	mov r1, #0x1000
	mov r0, r0, lsl #9
	bge _0217D618
	rsb r2, r0, #0x2000
	rsb r1, r1, #0
	mov r0, #0
	str r1, [sp, #0x28]
	str r0, [sp, #0x2c]
	str r2, [sp, #0x30]
	b _0217D62C
_0217D618:
	rsb r2, r0, #0x2000
	mov r0, #0
	str r1, [sp, #0x28]
	str r0, [sp, #0x2c]
	str r2, [sp, #0x30]
_0217D62C:
	ldrh r1, [r5, #0x32]
	ldr r3, _0217D6D8 // =FX_SinCosTable_
	add r0, sp, #4
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, sp, #0x28
	add r1, sp, #4
	mov r2, r0
	bl MTX_MultVec33
	add r0, sp, #0x28
	add r1, r5, #0x44
	mov r2, r0
	bl VEC_Add
	ldr r0, [sp, #0x28]
	ldr r1, [sp, #0x30]
	rsb r0, r0, #0
	rsb r1, r1, #0
	bl FX_Atan2Idx
	ldr r2, [r4, #0x14c]
	add r1, sp, #0x28
	mov r2, r2, lsl #5
	rsb r2, r2, #0x200
	add r0, r0, r2
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r5
	mov r3, #0x1000
	bl SailTorpedo__Create
	mov r0, #0x4000
	str r0, [r5, #4]
_0217D6BC:
	add sp, sp, #0x34
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0217D6C4: .word _mt_math_rand
_0217D6C8: .word 0x00196225
_0217D6CC: .word 0x3C6EF35F
_0217D6D0: .word _0218C428
_0217D6D4: .word 0x00007FFF
_0217D6D8: .word FX_SinCosTable_
	arm_func_end SailSailerBoat__Func_217D1B4

	arm_func_start SailSailerBoat__Func_217D6DC
SailSailerBoat__Func_217D6DC: // 0x0217D6DC
	ldr r3, [r0, #0x124]
	ldr r2, _0217D70C // =SailSailerBoat__State_217D710
	mov r1, #0
	str r2, [r0, #0xf4]
	str r1, [r0, #0x28]
	mov r0, #0xd60
	str r0, [r3, #0x140]
	add r0, r3, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #1
	strh r1, [r0, #0x2c]
	bx lr
	.align 2, 0
_0217D70C: .word SailSailerBoat__State_217D710
	arm_func_end SailSailerBoat__Func_217D6DC

	arm_func_start SailSailerBoat__State_217D710
SailSailerBoat__State_217D710: // 0x0217D710
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r0
	ldr r5, [r4, #0x124]
	mov r2, #0xd60
	ldr r1, [r5, #0x11c]
	ldr r0, [r5, #0x120]
	cmp r1, r0, asr #1
	ldr r0, [r5, #0x14c]
	addlt r2, r2, #0x340
	cmp r0, #0
	ldr r0, [r5, #0x140]
	movne r2, r2, asr #1
	cmp r0, #0
	rsblt r1, r0, #0
	movge r1, r0
	cmp r1, r2
	ble _0217D764
	mov r1, #0x138
	bl ObjSpdDownSet
	str r0, [r5, #0x140]
	b _0217D7A8
_0217D764:
	add r1, r5, #0x100
	ldrh r1, [r1, #0x2c]
	tst r1, #1
	beq _0217D784
	mov r1, #0x138
	bl ObjSpdUpSet
	str r0, [r5, #0x140]
	b _0217D7A8
_0217D784:
	tst r1, #2
	mov r1, #0x138
	beq _0217D7A0
	rsb r1, r1, #0
	bl ObjSpdUpSet
	str r0, [r5, #0x140]
	b _0217D7A8
_0217D7A0:
	bl ObjSpdDownSet
	str r0, [r5, #0x140]
_0217D7A8:
	bl SailManager__GetWork
	ldr r2, [r0, #0x98]
	add r0, r5, #0x100
	ldrh r1, [r0, #0x2c]
	ldr r3, [r5, #0x170]
	ldr r7, [r5, #0x178]
	ldr r0, [r2, #0x44]
	cmp r3, #0
	rsblt r3, r3, #0
	ands r2, r1, #1
	sub r0, r7, r0
	beq _0217D81C
	sub r6, r3, #0x18000
	mov r7, r6, asr #5
	mov r6, #0x5000
	umull r8, lr, r7, r6
	mov ip, #0
	mla lr, r7, ip, lr
	mov r7, r7, asr #0x1f
	adds r8, r8, #0x800
	mla lr, r7, r6, lr
	adc r6, lr, #0
	mov r7, r8, lsr #0xc
	orr r7, r7, r6, lsl #20
	mov r6, r7, asr #1
	add r7, r7, #0xa800
	add r6, r6, #0x4000
	add r6, r7, r6
	sub r6, r6, r0
_0217D81C:
	ands r1, r1, #2
	beq _0217D870
	sub r3, r3, #0x18000
	mov ip, r3, asr #5
	mov r3, #0x5000
	umull r7, lr, ip, r3
	mov r6, #0
	mla lr, ip, r6, lr
	mov r6, ip, asr #0x1f
	adds r7, r7, #0x800
	mla lr, r6, r3, lr
	mov r3, #0x800
	adc r6, lr, #0
	mov r7, r7, lsr #0xc
	orr r7, r7, r6, lsl #20
	sub r3, r3, #0xb000
	mov r6, r7, asr #1
	sub ip, r3, r7
	add r3, r6, #0x4000
	add r3, ip, r3
	sub r6, r0, r3
_0217D870:
	cmp r6, #0x5000
	bge _0217D8C0
	cmp r2, #0
	beq _0217D8A0
	add r0, r5, #0x100
	ldrh r1, [r0, #0x2c]
	bic r1, r1, #1
	strh r1, [r0, #0x2c]
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
	b _0217D930
_0217D8A0:
	cmp r1, #0
	beq _0217D930
	add r0, r5, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #1
	bic r1, r1, #2
	strh r1, [r0, #0x2c]
	b _0217D930
_0217D8C0:
	ldr r2, _0217DB74 // =_mt_math_rand
	ldr r0, _0217DB78 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _0217DB7C // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #0x7f
	bne _0217D930
	add r0, r5, #0x100
	ldrh r1, [r0, #0x2c]
	tst r1, #1
	beq _0217D914
	bic r1, r1, #1
	strh r1, [r0, #0x2c]
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
	b _0217D930
_0217D914:
	tst r1, #2
	beq _0217D930
	orr r1, r1, #1
	strh r1, [r0, #0x2c]
	ldrh r1, [r0, #0x2c]
	bic r1, r1, #2
	strh r1, [r0, #0x2c]
_0217D930:
	add r3, r5, #0x100
	ldrh r0, [r3, #0x2c]
	tst r0, #0xc
	beq _0217D96C
	ldr r0, [r4, #0x28]
	add r0, r0, #0x200
	str r0, [r4, #0x28]
	cmp r0, #0x8000
	bls _0217D9D0
	mov r0, #0
	str r0, [r4, #0x28]
	ldrh r0, [r3, #0x2c]
	bic r0, r0, #0xc
	strh r0, [r3, #0x2c]
	b _0217D9D0
_0217D96C:
	ldr r0, [r4, #0x2c]
	tst r0, #0x3f
	bne _0217D9D0
	ldr r6, _0217DB74 // =_mt_math_rand
	ldr r0, _0217DB78 // =0x00196225
	ldr r2, [r6, #0]
	ldr r1, _0217DB7C // =0x3C6EF35F
	mla ip, r2, r0, r1
	mov r2, ip, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	str ip, [r6]
	tst r2, #1
	bne _0217D9D0
	mla r1, ip, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r6]
	tst r0, #1
	ldrh r0, [r3, #0x2c]
	orrne r0, r0, #4
	strneh r0, [r3, #0x2c]
	orreq r0, r0, #8
	streqh r0, [r3, #0x2c]
_0217D9D0:
	add r0, r5, #0x100
	ldrh r0, [r0, #0x2c]
	tst r0, #4
	beq _0217DA08
	ldr r0, [r4, #0x28]
	ldr r1, _0217DB80 // =FX_SinCosTable_
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r0, [r1, r0]
	str r0, [r5, #0x13c]
_0217DA08:
	add r0, r5, #0x100
	ldrh r0, [r0, #0x2c]
	tst r0, #8
	beq _0217DA44
	ldr r0, [r4, #0x28]
	ldr r1, _0217DB80 // =FX_SinCosTable_
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r0, [r1, r0]
	rsb r0, r0, #0
	str r0, [r5, #0x13c]
_0217DA44:
	ldr r0, [r5, #0x13c]
	ldr r1, _0217DB80 // =FX_SinCosTable_
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrsh r2, [r1, r0]
	ldr r3, [r5, #0x140]
	mov r0, r4
	smull r6, r2, r3, r2
	adds r3, r6, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [r5, #0x184]
	ldr r2, [r5, #0x13c]
	ldr r3, [r5, #0x140]
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r1, [r1, r2]
	smull r2, r1, r3, r1
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r5, #0x17c]
	bl SailSailerBoat__Func_217AE48
	add r0, r5, #0x100
	ldrh r1, [r0, #0x6e]
	mov r0, r4
	add r1, r1, #0x8000
	strh r1, [r4, #0x32]
	ldrh r2, [r4, #0x32]
	ldr r1, [r5, #0x13c]
	sub r1, r2, r1
	strh r1, [r4, #0x32]
	bl SailObject__ApplyRotation
	mov r0, r4
	bl SailObject__Func_2166A2C
	ldr r0, [r5, #0x170]
	cmp r0, #0
	rsblt r1, r0, #0
	movge r1, r0
	cmp r1, #0x2a000
	bge _0217DB2C
	cmp r0, #0
	mov r0, #0x2a000
	rsblt r0, r0, #0
	strlt r0, [r5, #0x170]
	strge r0, [r5, #0x170]
_0217DB2C:
	cmp r1, #0x51000
	ble _0217DB4C
	ldr r0, [r5, #0x170]
	cmp r0, #0
	mov r0, #0x51000
	rsblt r0, r0, #0
	strlt r0, [r5, #0x170]
	strge r0, [r5, #0x170]
_0217DB4C:
	mov r0, r4
	bl SailSailerBoat__Func_217DB84
	ldr r0, [r5, #0x138]
	sub r0, r0, #1
	str r0, [r5, #0x138]
	cmp r0, #0
	ldmgtia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r4
	bl SailSailerBoat__Func_217CF44
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0217DB74: .word _mt_math_rand
_0217DB78: .word 0x00196225
_0217DB7C: .word 0x3C6EF35F
_0217DB80: .word FX_SinCosTable_
	arm_func_end SailSailerBoat__State_217D710

	arm_func_start SailSailerBoat__Func_217DB84
SailSailerBoat__Func_217DB84: // 0x0217DB84
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r7, r0
	ldr r4, [r7, #0x124]
	bl SailManager__GetWork
	ldr r0, [r4, #0x128]
	cmp r0, #0
	bne _0217DCFC
	ldr r3, _0217E3DC // =_mt_math_rand
	ldr r0, [r4, #0x148]
	ldr r5, [r3, #0]
	ldr r1, _0217E3E0 // =0x00196225
	ldr r2, _0217E3E4 // =0x3C6EF35F
	mov r0, r0, lsl #0x10
	mla r2, r5, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0xf
	str r2, [r3]
	str r1, [r4, #0x148]
	cmp r1, #0xe
	mov r2, r0, lsr #0x10
	subge r0, r1, #0xe
	strge r0, [r4, #0x148]
	ldr r0, [r4, #0x148]
	cmp r0, r2
	addeq r0, r2, #1
	streq r0, [r7, #0x28]
	cmpeq r2, #0xe
	moveq r0, #0
	streq r0, [r7, #0x28]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #1
	beq _0217DC84
	ldr r0, [r4, #0x148]
	cmp r0, #0xc
	addls pc, pc, r0, lsl #2
	b _0217DC84
_0217DC24: // jump table
	b _0217DC84 // case 0
	b _0217DC84 // case 1
	b _0217DC84 // case 2
	b _0217DC58 // case 3
	b _0217DC84 // case 4
	b _0217DC84 // case 5
	b _0217DC84 // case 6
	b _0217DC84 // case 7
	b _0217DC84 // case 8
	b _0217DC64 // case 9
	b _0217DC70 // case 10
	b _0217DC84 // case 11
	b _0217DC7C // case 12
_0217DC58:
	mov r0, #0
	str r0, [r4, #0x148]
	b _0217DC84
_0217DC64:
	mov r0, #6
	str r0, [r4, #0x148]
	b _0217DC84
_0217DC70:
	mov r0, #7
	str r0, [r4, #0x148]
	b _0217DC84
_0217DC7C:
	mov r0, #0xb
	str r0, [r4, #0x148]
_0217DC84:
	ldr r2, [r4, #0x148]
	ldr r1, _0217E3E8 // =_0218C434
	add r0, r4, #0x100
	ldrb r2, [r1, r2]
	ldr r3, _0217E3DC // =_mt_math_rand
	ldr r1, _0217E3E0 // =0x00196225
	str r2, [r4, #0x14c]
	ldrh r5, [r0, #0x2c]
	ldr r2, _0217E3E4 // =0x3C6EF35F
	bic r5, r5, #0x20
	strh r5, [r0, #0x2c]
	ldr r0, [r3, #0]
	mla r1, r0, r1, r2
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0x1f
	str r1, [r3]
	add r0, r0, #0x2c
	str r0, [r4, #0x128]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #1
	ldrne r0, [r4, #0x128]
	addne r0, r0, #0x40
	strne r0, [r4, #0x128]
	ldr r1, [r4, #0x128]
	ldr r0, [r4, #0x14c]
	add r0, r1, r0
	str r0, [r4, #0x128]
_0217DCFC:
	ldr r0, [r4, #0x128]
	sub r0, r0, #1
	str r0, [r4, #0x128]
	ldr r0, [r4, #0x14c]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	sub r0, r0, #1
	str r0, [r4, #0x14c]
	add r0, r4, #0x100
	ldrh r1, [r0, #0x2c]
	mov r0, #0
	tst r1, #0x20
	ldreq r1, [r7, #4]
	cmpeq r1, #0
	moveq r1, #0x4000
	streq r1, [r7, #4]
	ldr r1, [r4, #0x148]
	cmp r1, #0xc
	addls pc, pc, r1, lsl #2
	b _0217E3D4
_0217DD50: // jump table
	b _0217DE74 // case 0
	b _0217DE68 // case 1
	b _0217DE5C // case 2
	b _0217DE50 // case 3
	b _0217DD84 // case 4
	b _0217DDDC // case 5
	b _0217DECC // case 6
	b _0217DFB4 // case 7
	b _0217E098 // case 8
	b _0217E210 // case 9
	b _0217E210 // case 10
	b _0217E340 // case 11
	b _0217E384 // case 12
_0217DD84:
	ldr r0, [r4, #0x14c]
	cmp r0, #6
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r1, #0
	sub r2, r1, #0x4000
	mov r4, #0x4a0
	mov r0, r7
	mov r3, r2
	str r4, [sp]
	bl SailSailerBoat__Func_217E788
	mov r1, #0
	sub r2, r1, #0x4000
	rsb r4, r4, #0
	mov r0, r7
	mov r3, r2
	str r4, [sp]
	bl SailSailerBoat__Func_217E788
	mov r0, #0x8000
	add sp, sp, #8
	str r0, [r7, #4]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0217DDDC:
	ldr r0, [r4, #0x14c]
	cmp r0, #6
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r1, #0
	sub r2, r1, #0x4000
	mov r4, #0x380
	mov r0, r7
	mov r3, r2
	str r4, [sp]
	bl SailSailerBoat__Func_217E788
	mov r1, #0
	sub r2, r1, #0x4000
	mov r0, r7
	mov r3, r2
	str r1, [sp]
	bl SailSailerBoat__Func_217E788
	mov r1, #0
	mov r3, r4
	rsb r3, r3, #0
	sub r2, r1, #0x4000
	str r3, [sp]
	mov r0, r7
	mov r3, r2
	bl SailSailerBoat__Func_217E788
	mov r0, #0x8000
	add sp, sp, #8
	str r0, [r7, #4]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0217DE50:
	ldr r1, [r4, #0x14c]
	cmp r1, #0x16
	moveq r0, #1
_0217DE5C:
	ldr r1, [r4, #0x14c]
	cmp r1, #0x10
	moveq r0, #1
_0217DE68:
	ldr r1, [r4, #0x14c]
	cmp r1, #0xa
	moveq r0, #1
_0217DE74:
	ldr r1, [r4, #0x14c]
	cmp r1, #4
	bne _0217DE94
	add r1, r4, #0x100
	ldrh r2, [r1, #0x2c]
	mov r0, #1
	orr r2, r2, #0x20
	strh r2, [r1, #0x2c]
_0217DE94:
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r1, #0
	sub r2, r1, #0x4000
	ldr r4, _0217E3EC // =0x00007FFF
	mov r0, r7
	mov r3, r2
	str r4, [sp]
	bl SailSailerBoat__Func_217E788
	mov r0, #0x8000
	add sp, sp, #8
	str r0, [r7, #4]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0217DECC:
	ldr r0, [r4, #0x14c]
	cmp r0, #0x1c
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r2, _0217E3DC // =_mt_math_rand
	ldr r0, _0217E3E0 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _0217E3E4 // =0x3C6EF35F
	mov r5, #0xf
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	mov r1, #0
	beq _0217DF54
	mov r2, #0x2000
	str r2, [sp]
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	str r5, [sp, #4]
	bl SpawnSailMissile
	mov r1, #0
	mov r0, #0x2000
	rsb r0, r0, #0
	str r0, [sp]
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	str r1, [sp, #4]
	bl SpawnSailMissile
	b _0217DF94
_0217DF54:
	mov r0, #0x2000
	str r0, [sp]
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	str r1, [sp, #4]
	bl SpawnSailMissile
	mov r2, #0x2000
	mov r1, #0
	rsb r2, r2, #0
	str r2, [sp]
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	str r5, [sp, #4]
	bl SpawnSailMissile
_0217DF94:
	mov r0, #0x8000
	str r0, [r7, #4]
	add r0, r4, #0x100
	ldrh r1, [r0, #0x2c]
	add sp, sp, #8
	orr r1, r1, #0x20
	strh r1, [r0, #0x2c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0217DFB4:
	ldr r0, [r4, #0x14c]
	cmp r0, #0x1c
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r2, _0217E3DC // =_mt_math_rand
	ldr r0, _0217E3E0 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _0217E3E4 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	mov r1, #0
	beq _0217E038
	mov r0, #0x3000
	str r0, [sp]
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	str r1, [sp, #4]
	bl SpawnSailMissile
	mov r1, #0
	mov r0, #0x3000
	rsb r0, r0, #0
	str r0, [sp]
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	str r1, [sp, #4]
	bl SpawnSailMissile
	b _0217E078
_0217E038:
	mov r0, #0x5000
	str r0, [sp]
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	str r1, [sp, #4]
	bl SpawnSailMissile
	mov r1, #0
	mov r0, #0x5000
	rsb r0, r0, #0
	str r0, [sp]
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	str r1, [sp, #4]
	bl SpawnSailMissile
_0217E078:
	mov r0, #0x8000
	str r0, [r7, #4]
	add r0, r4, #0x100
	ldrh r1, [r0, #0x2c]
	add sp, sp, #8
	orr r1, r1, #0x20
	strh r1, [r0, #0x2c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0217E098:
	ldr r0, [r4, #0x14c]
	cmp r0, #0x3a
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r2, _0217E3DC // =_mt_math_rand
	ldr r0, _0217E3E0 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _0217E3E4 // =0x3C6EF35F
	mov r5, #0x1e
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	str r1, [r2]
	mov r0, r0, lsr #0x10
	tst r0, #1
	mov r1, #0
	mov r2, #0x6000
	mov r0, r7
	beq _0217E16C
	str r2, [sp]
	mov r3, r1
	sub r2, r1, #0x4000
	str r5, [sp, #4]
	bl SpawnSailMissile
	mov r1, #0
	mov r0, #0x3000
	str r0, [sp]
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	str r1, [sp, #4]
	bl SpawnSailMissile
	mov r2, #0x3000
	rsb r2, r2, #0
	mov r1, #0
	str r2, [sp]
	mov r2, #0xf
	str r2, [sp, #4]
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	bl SpawnSailMissile
	mov r1, #0
	mov r0, #0x6000
	rsb r0, r0, #0
	str r0, [sp]
	mov r0, #0x2d
	str r0, [sp, #4]
	mov r0, r7
	sub r2, r1, #0x4000
	mov r3, r1
	bl SpawnSailMissile
	b _0217E1F0
_0217E16C:
	str r2, [sp]
	mov r3, r1
	sub r2, r1, #0x4000
	str r5, [sp, #4]
	bl SpawnSailMissile
	mov r1, #0
	mov r2, #0x3000
	str r2, [sp]
	mov r5, #0xf
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	str r5, [sp, #4]
	bl SpawnSailMissile
	mov r1, #0
	mov r0, #0x3000
	rsb r0, r0, #0
	str r0, [sp]
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	str r1, [sp, #4]
	bl SpawnSailMissile
	mov r1, #0
	mov r0, #0x6000
	rsb r0, r0, #0
	str r0, [sp]
	mov r0, #0x2d
	str r0, [sp, #4]
	mov r0, r7
	sub r2, r1, #0x4000
	mov r3, r1
	bl SpawnSailMissile
_0217E1F0:
	mov r0, #0x8000
	str r0, [r7, #4]
	add r0, r4, #0x100
	ldrh r1, [r0, #0x2c]
	add sp, sp, #8
	orr r1, r1, #0x20
	strh r1, [r0, #0x2c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0217E210:
	mov r5, #0
	ldr r0, [r4, #0x14c]
	mov r6, r5
	cmp r1, #0xa
	moveq r5, #0x10
	movne r6, #0x10
	cmp r0, #0x64
	bne _0217E27C
	mov r1, #0
	mov r0, #0x4000
	str r0, [sp]
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	str r5, [sp, #4]
	bl SpawnSailMissile
	mov r1, #0
	mov r0, #0x2000
	rsb r0, r0, #0
	str r0, [sp]
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	str r6, [sp, #4]
	bl SpawnSailMissile
	mov r0, #0x8000
	str r0, [r7, #4]
_0217E27C:
	ldr r0, [r4, #0x14c]
	cmp r0, #0x50
	bne _0217E2CC
	mov r1, #0
	mov r0, #0x6000
	str r0, [sp]
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	str r5, [sp, #4]
	bl SpawnSailMissile
	mov r2, #0x4000
	mov r1, #0
	rsb r2, r2, #0
	mov r0, r7
	mov r3, r1
	stmia sp, {r2, r6}
	bl SpawnSailMissile
	mov r0, #0x8000
	str r0, [r7, #4]
_0217E2CC:
	ldr r0, [r4, #0x14c]
	cmp r0, #0x3c
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, #0x6000
	mov r1, #0
	rsb r0, r0, #0
	str r0, [sp]
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	str r5, [sp, #4]
	bl SpawnSailMissile
	mov r1, #0
	mov r0, #0x2000
	str r0, [sp]
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	str r6, [sp, #4]
	bl SpawnSailMissile
	mov r0, #0x8000
	str r0, [r7, #4]
	add r0, r4, #0x100
	ldrh r1, [r0, #0x2c]
	add sp, sp, #8
	orr r1, r1, #0x20
	strh r1, [r0, #0x2c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0217E340:
	ldr r0, [r4, #0x14c]
	cmp r0, #0x64
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r1, #0
	mov r0, r7
	mov r3, r1
	sub r2, r1, #0x4000
	bl SpawnSailTorpedo3
	mov r0, #0x8000
	str r0, [r7, #4]
	add r0, r4, #0x100
	ldrh r1, [r0, #0x2c]
	add sp, sp, #8
	orr r1, r1, #0x20
	strh r1, [r0, #0x2c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0217E384:
	ldr r0, [r4, #0x14c]
	cmp r0, #0x64
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r1, #0
	mov r0, r7
	sub r2, r1, #0x4000
	mov r3, #0x4000
	bl SpawnSailTorpedo3
	mov r1, #0
	sub r2, r1, #0x4000
	mov r0, r7
	mov r3, r2
	bl SpawnSailTorpedo3
	mov r0, #0x8000
	str r0, [r7, #4]
	add r0, r4, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #0x20
	strh r1, [r0, #0x2c]
_0217E3D4:
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0217E3DC: .word _mt_math_rand
_0217E3E0: .word 0x00196225
_0217E3E4: .word 0x3C6EF35F
_0217E3E8: .word _0218C434
_0217E3EC: .word 0x00007FFF
	arm_func_end SailSailerBoat__Func_217DB84

	arm_func_start SailSailerBoat__Func_217E3F0
SailSailerBoat__Func_217E3F0: // 0x0217E3F0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	ldr r1, _0217E494 // =SailSailerBoat__State_217E498
	mov ip, #0
	str r1, [r5, #0xf4]
	ldr r2, [r5, #0x20]
	mov r1, #0x10000
	bic r2, r2, #0x1000
	orr r2, r2, #0x20
	str r2, [r5, #0x20]
	ldr r3, [r5, #0x18]
	mov r2, #0x8000
	bic r3, r3, #2
	str r3, [r5, #0x18]
	ldr lr, [r5, #0x24]
	mov r3, #0x400
	orr lr, lr, #1
	str lr, [r5, #0x24]
	str ip, [r5, #0x2c]
	bl SailSailerBoat__Func_217C360
	ldr r0, [r4, #0x138]
	cmp r0, #0x20
	movge r0, #1
	movlt r0, #0
	str r0, [r4, #0x138]
	add r0, r4, #0x100
	ldrh r0, [r0, #0x6e]
	strh r0, [r5, #0x32]
	ldr r0, [r4, #0x170]
	cmp r0, #0
	ldrh r0, [r5, #0x32]
	addlt r0, r0, #0x4000
	subge r0, r0, #0x4000
	strh r0, [r5, #0x32]
	ldr r0, [r4, #0x170]
	cmp r0, #0
	mov r0, #0x1000
	rsbge r0, r0, #0
	str r0, [r4, #0x17c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217E494: .word SailSailerBoat__State_217E498
	arm_func_end SailSailerBoat__Func_217E3F0

	arm_func_start SailSailerBoat__State_217E498
SailSailerBoat__State_217E498: // 0x0217E498
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x20]
	ldr r4, [r5, #0x124]
	bic r0, r0, #0x20
	str r0, [r5, #0x20]
	add r0, r4, #0x100
	ldrh r0, [r0, #0x6e]
	strh r0, [r5, #0x32]
	ldr r0, [r4, #0x170]
	cmp r0, #0
	ldrh r0, [r5, #0x32]
	addlt r0, r0, #0x4000
	subge r0, r0, #0x4000
	strh r0, [r5, #0x32]
	ldr r0, [r4, #0x164]
	ldrh r0, [r0, #0x30]
	cmp r0, #0x13
	bne _0217E590
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #0x26
	ble _0217E530
	ldr r0, [r4, #0x184]
	mov r1, #0x80
	bl ObjSpdDownSet
	str r0, [r4, #0x184]
	mov r1, #0
	str r1, [sp]
	ldr r0, [r5, #0x28]
	mov r2, #2
	mov r3, #0x100
	bl ObjShiftSet
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [r5, #0x28]
	b _0217E590
_0217E530:
	cmp r0, #0x14
	ble _0217E590
	mov r0, #0
	str r0, [sp]
	ldr r0, [r5, #0x28]
	mov r1, #0x1000
	mov r2, #1
	mov r3, #0x200
	bl ObjShiftSet
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [r5, #0x28]
	ldr r0, [r4, #0x138]
	mov r2, #0x2000
	cmp r0, #0
	ldr r0, [r4, #0x184]
	beq _0217E584
	mov r1, #0x80
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
	b _0217E590
_0217E584:
	mvn r1, #0x7f
	bl ObjSpdUpSet
	str r0, [r4, #0x184]
_0217E590:
	ldr r0, [r4, #0x138]
	cmp r0, #0
	ldr r0, [r5, #0x28]
	rsbne r0, r0, #0
	strh r0, [r5, #0x34]
	mov r0, r5
	bl SailObject__ApplyRotation
	mov r0, r5
	bl SailObject__Func_2166A2C
	mov r0, r5
	mov r1, #0
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r5, #0x44
	bl EffectSailBomb__Create
	ldr r3, [r0, #0x38]
	mov r1, #0x800
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #0xb
	adds r4, r1, r3, lsl #11
	orr r2, r2, r3, lsr #21
	adc r1, r2, #0
	mov r2, r4, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x38]
	str r2, [r0, #0x3c]
	str r2, [r0, #0x40]
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSailerBoat__State_217E498

	arm_func_start SailSailerBoat__Func_217E614
SailSailerBoat__Func_217E614: // 0x0217E614
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r1, [r0, #0x98]
	ldr r0, _0217E67C // =SailSailerBoat__State_217E680
	str r0, [r5, #0xf4]
	ldr r0, [r5, #0x24]
	orr r0, r0, #1
	str r0, [r5, #0x24]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #1
	mov r0, #0xe00
	rsbeq r0, r0, #0
	streq r0, [r4, #0x184]
	moveq r0, #0
	streq r0, [r5, #0x2c]
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r1, [r1, #0x44]
	sub r1, r1, #0x18000
	str r1, [r4, #0x178]
	str r0, [r4, #0x184]
	mov r0, #0x1e
	str r0, [r5, #0x2c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217E67C: .word SailSailerBoat__State_217E680
	arm_func_end SailSailerBoat__Func_217E614

	arm_func_start SailSailerBoat__State_217E680
SailSailerBoat__State_217E680: // 0x0217E680
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x20]
	ldr r4, [r5, #0x124]
	bic r0, r0, #0x20
	str r0, [r5, #0x20]
	add r0, r4, #0x100
	ldrh r0, [r0, #0x6e]
	strh r0, [r5, #0x32]
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #1
	ldrneh r0, [r5, #0x32]
	addne r0, r0, #0x8000
	strneh r0, [r5, #0x32]
	ldr r0, [r5, #0x2c]
	cmp r0, #0x34
	ble _0217E754
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #2
	beq _0217E6EC
	ldr r0, [r4, #0x17c]
	mvn r1, #0x47
	mov r2, #0xa00
	bl ObjSpdUpSet
	str r0, [r4, #0x17c]
_0217E6EC:
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #4
	beq _0217E710
	ldr r0, [r4, #0x17c]
	mov r1, #0x48
	mov r2, #0xa00
	bl ObjSpdUpSet
	str r0, [r4, #0x17c]
_0217E710:
	ldr r0, [r4, #0x164]
	ldr r0, [r0, #0x34]
	tst r0, #8
	beq _0217E734
	ldr r0, [r4, #0x180]
	mvn r1, #0x2f
	mov r2, #0x400
	bl ObjSpdUpSet
	str r0, [r4, #0x180]
_0217E734:
	ldr r0, [r4, #0x17c]
	rsb r0, r0, #0
	mov r0, r0, lsl #1
	strh r0, [r5, #0x34]
	ldr r0, [r4, #0x180]
	rsb r0, r0, #0
	mov r0, r0, lsl #1
	strh r0, [r5, #0x30]
_0217E754:
	ldr r0, [r5, #0x2c]
	cmp r0, #0x60
	ldrgt r0, [r5, #0x18]
	orrgt r0, r0, #4
	strgt r0, [r5, #0x18]
	mov r0, r5
	bl SailObject__ApplyRotation
	mov r0, r5
	bl SailObject__Func_2166A2C
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSailerBoat__State_217E680

	arm_func_start SailSailerBoat__Func_217E788
SailSailerBoat__Func_217E788: // 0x0217E788
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x34
	add ip, sp, #0x28
	mov r5, #0
	mov r4, r0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	str r5, [ip]
	str r5, [ip, #4]
	str r5, [ip, #8]
	bl SailManager__GetWork
	mov r5, r0
	ldr r0, [r5, #0x24]
	tst r0, #0x200
	addne sp, sp, #0x34
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, pc}
	str r8, [sp, #0x28]
	str r7, [sp, #0x2c]
	str r6, [sp, #0x30]
	ldr r0, [r4, #0x44]
	ldr r1, [r4, #0x4c]
	rsb r0, r0, #0
	rsb r1, r1, #0
	bl FX_Atan2Idx
	tst r0, #0x8000
	ldreq r0, [sp, #0x28]
	ldr r3, _0217EA88 // =FX_SinCosTable_
	rsbeq r0, r0, #0
	streq r0, [sp, #0x28]
	ldrh r1, [r4, #0x32]
	add r0, sp, #4
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r6, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r6]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, sp, #0x28
	add r1, sp, #4
	mov r2, r0
	bl MTX_MultVec33
	add r0, sp, #0x28
	add r1, r4, #0x44
	mov r2, r0
	bl VEC_Add
	ldr r1, [r4, #0x44]
	ldr r2, [r4, #0x4c]
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r2, #0
	rsblt r2, r2, #0
	cmp r1, r2
	ldr r3, _0217EA8C // =0x00000F5E
	ldr r6, _0217EA90 // =0x0000065D
	mov r7, #0
	ble _0217E8B0
	umull r0, lr, r1, r3
	mla lr, r1, r7, lr
	umull ip, r8, r2, r6
	mov r1, r1, asr #0x1f
	mla lr, r1, r3, lr
	adds r0, r0, #0x800
	adc r3, lr, #0
	adds r1, ip, #0x800
	mov ip, r0, lsr #0xc
	mla r8, r2, r7, r8
	mov r0, r2, asr #0x1f
	mla r8, r0, r6, r8
	adc r0, r8, #0
	mov r1, r1, lsr #0xc
	b _0217E8E8
_0217E8B0:
	umull r0, lr, r2, r3
	mla lr, r2, r7, lr
	umull ip, r8, r1, r6
	mov r2, r2, asr #0x1f
	mla lr, r2, r3, lr
	adds r0, r0, #0x800
	adc r3, lr, #0
	adds r2, ip, #0x800
	mov ip, r0, lsr #0xc
	mla r8, r1, r7, r8
	mov r0, r1, asr #0x1f
	mla r8, r0, r6, r8
	adc r0, r8, #0
	mov r1, r2, lsr #0xc
_0217E8E8:
	orr r1, r1, r0, lsl #20
	orr ip, ip, r3, lsl #20
	add r6, ip, r1
	ldr r0, [sp, #0x28]
	ldr r1, [sp, #0x30]
	rsb r0, r0, #0
	rsb r1, r1, #0
	bl FX_Atan2Idx
	ldrsh r2, [sp, #0x50]
	ldr r1, _0217EA94 // =0x00007FFF
	cmp r2, r1
	addne r0, r0, r2
	movne r0, r0, lsl #0x10
	bne _0217E954
	ldr r7, _0217EA98 // =_mt_math_rand
	ldr r1, _0217EA9C // =0x00196225
	ldr r8, [r7, #0]
	ldr r2, _0217EAA0 // =0x3C6EF35F
	ldr r3, _0217EAA4 // =0x00000FFE
	mla r1, r8, r1, r2
	mov r2, r1, lsr #0x10
	mov r2, r2, lsl #0x10
	and r2, r3, r2, lsr #16
	rsb r2, r2, r3, lsr #1
	add r0, r0, r2
	mov r0, r0, lsl #0x10
	str r1, [r7]
_0217E954:
	mov r3, r0, lsr #0x10
	mov r7, #0x40
	add r1, sp, #0x28
	mov r0, r4
	mov r2, r6, asr #6
	str r7, [sp]
	bl SailShell3__Create
	add r0, sp, #0x28
	bl EffectSailSmoke__Create
	mov r1, #0x400
	rsb r1, r1, #0
	str r1, [r0, #0x9c]
	mov r1, #0x20
	str r1, [r0, #0xa8]
	ldrh r1, [r4, #0x32]
	ldr r2, _0217EA88 // =FX_SinCosTable_
	mov r6, #0x800
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #1
	ldrsh r7, [r2, r1]
	ldr r1, _0217EAA8 // =0x0000739C
	mov r3, r7, asr #0x1f
	mov r3, r3, lsl #0xa
	adds r8, r6, r7, lsl #10
	orr r3, r3, r7, lsr #22
	adc r3, r3, #0
	mov r7, r8, lsr #0xc
	orr r7, r7, r3, lsl #20
	str r7, [r0, #0x98]
	ldrh r3, [r4, #0x32]
	rsb r3, r3, #0
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, asr #4
	mov r3, r3, lsl #2
	ldrsh r3, [r2, r3]
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #0xa
	adds r4, r6, r3, lsl #10
	orr r2, r2, r3, lsr #22
	adc r2, r2, #0
	mov r3, r4, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [r0, #0xa0]
	ldr r2, [r0, #0x98]
	rsb r2, r2, #0
	mov r2, r2, asr #4
	str r2, [r0, #0xa4]
	ldr r2, [r0, #0xa0]
	rsb r2, r2, #0
	mov r2, r2, asr #4
	str r2, [r0, #0xac]
	ldr r3, [r0, #0xa4]
	ldr r2, [r5, #0x34]
	sub r2, r3, r2, asr #8
	str r2, [r0, #0xa4]
	ldr r3, [r0, #0xac]
	ldr r2, [r5, #0x3c]
	sub r2, r3, r2, asr #8
	str r2, [r0, #0xac]
	bl SailObject__SetSpriteColor
	ldr r1, [sp, #0x2c]
	add r0, sp, #0x28
	sub r1, r1, #0x3000
	str r1, [sp, #0x2c]
	bl EffectSailFlash__Create
	add sp, sp, #0x34
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0217EA88: .word FX_SinCosTable_
_0217EA8C: .word 0x00000F5E
_0217EA90: .word 0x0000065D
_0217EA94: .word 0x00007FFF
_0217EA98: .word _mt_math_rand
_0217EA9C: .word 0x00196225
_0217EAA0: .word 0x3C6EF35F
_0217EAA4: .word 0x00000FFE
_0217EAA8: .word 0x0000739C
	arm_func_end SailSailerBoat__Func_217E788

	arm_func_start SailShell3__SetupObject
SailShell3__SetupObject: // 0x0217EAAC
	ldr r1, _0217EAB8 // =SailShell3__State_217EABC
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_0217EAB8: .word SailShell3__State_217EABC
	arm_func_end SailShell3__SetupObject

	arm_func_start SailShell3__State_217EABC
SailShell3__State_217EABC: // 0x0217EABC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x9c]
	cmp r0, #0
	ldrgt r0, [r4, #0x48]
	cmpgt r0, #0
	ble _0217EB2C
	ldr r0, [r4, #0x138]
	add r2, r4, #0x44
	mov r1, #0x1c
	bl SailAudio__PlaySpatialSequence
	add r0, r4, #0x44
	bl EffectSailWater08__Create
	ldr r3, [r0, #0x38]
	mov r1, #0x800
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #0xd
	adds ip, r1, r3, lsl #13
	orr r2, r2, r3, lsr #19
	adc r1, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x38]
	str r2, [r0, #0x3c]
	str r2, [r0, #0x40]
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
_0217EB2C:
	mov r0, r4
	mov r1, #0
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x44
	bl EffectSailBomb__Create
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	arm_func_end SailShell3__State_217EABC

	arm_func_start SailTorpedo__SetupObject
SailTorpedo__SetupObject: // 0x0217EB5C
	ldr r2, [r0, #0x24]
	ldr r1, _0217EB74 // =SailTorpedo__State_217EB78
	orr r2, r2, #1
	str r2, [r0, #0x24]
	str r1, [r0, #0xf4]
	bx lr
	.align 2, 0
_0217EB74: .word SailTorpedo__State_217EB78
	arm_func_end SailTorpedo__SetupObject

	arm_func_start SailTorpedo__State_217EB78
SailTorpedo__State_217EB78: // 0x0217EB78
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x24
	mov r5, r0
	bl SailManager__GetWork
	ldr r4, [r0, #0x98]
	ldrsh r0, [r4, #0x38]
	cmp r0, #0
	beq _0217EC00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, _0217ECD4 // =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, sp, #0
	bl MTX_RotY33_
	add r0, r5, #0x44
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
	add r0, r5, #0x98
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
	ldrh r1, [r5, #0x32]
	ldrsh r0, [r4, #0x38]
	add r0, r1, r0
	strh r0, [r5, #0x32]
_0217EC00:
	ldr r0, [r5, #0x1c]
	tst r0, #0x80
	beq _0217EC6C
	ldr r0, [r5, #0x9c]
	cmp r0, #0
	ldrgt r0, [r5, #0x48]
	cmpgt r0, #0
	ble _0217EC88
	ldr r0, [r5, #0x138]
	add r2, r5, #0x44
	mov r1, #0x2d
	bl SailAudio__PlaySpatialSequence
	add r0, r5, #0x44
	bl EffectSailWater06__Create
	ldr r1, [r5, #0x1c]
	mov r0, #0
	bic r1, r1, #0x80
	str r1, [r5, #0x1c]
	str r0, [r5, #0x9c]
	str r0, [r5, #0x48]
	ldr r1, [r5, #0x24]
	mov r0, r5
	orr r2, r1, #0x8000
	mov r1, #5
	str r2, [r5, #0x24]
	bl SailObject__SetLightColors
	b _0217EC88
_0217EC6C:
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	tst r0, #3
	bne _0217EC88
	add r0, r5, #0x44
	bl EffectSailWater06__Create
_0217EC88:
	mov r0, r5
	mov r1, #0
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	beq _0217ECC4
	ldr r0, [r5, #0x138]
	add r2, r5, #0x44
	mov r1, #0x25
	bl SailAudio__PlaySpatialSequence
	add r0, r5, #0x44
	bl EffectSailWater05__Create
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
_0217ECC4:
	mov r0, r5
	bl SailObject__ApplyRotation
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0217ECD4: .word FX_SinCosTable_
	arm_func_end SailTorpedo__State_217EB78

	arm_func_start SpawnSailTorpedo2
SpawnSailTorpedo2: // 0x0217ECD8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x3c
	add r5, sp, #0x30
	mov r4, #0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	str r4, [r5]
	str r4, [r5, #4]
	str r4, [r5, #8]
	mov r4, r0
	bl SailManager__GetWork
	str r8, [sp, #0x30]
	str r7, [sp, #0x34]
	str r6, [sp, #0x38]
	ldr r0, [r4, #0x44]
	ldr r1, [r4, #0x4c]
	rsb r0, r0, #0
	rsb r1, r1, #0
	bl FX_Atan2Idx
	tst r0, #0x8000
	ldreq r0, [sp, #0x30]
	ldr r3, _0217EE4C // =FX_SinCosTable_
	rsbeq r0, r0, #0
	streq r0, [sp, #0x30]
	ldrh r1, [r4, #0x32]
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov r5, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r5]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, sp, #0x30
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
	add r0, sp, #0x30
	add r1, r4, #0x44
	mov r2, r0
	bl VEC_Add
	ldr r3, _0217EE50 // =_mt_math_rand
	ldr r1, _0217EE54 // =0x00196225
	ldr ip, [r3]
	ldr r2, _0217EE58 // =0x3C6EF35F
	add r0, sp, #0x30
	mla lr, ip, r1, r2
	mla r1, lr, r1, r2
	str r1, [r3]
	mov r2, lr, lsr #0x10
	ldr ip, [sp, #0x34]
	mov r1, r1, lsr #0x10
	add lr, ip, #0x1000
	add r5, sp, #0x24
	mov r3, r2, lsl #0x10
	mov ip, r1, lsl #0x10
	ldmia r0, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	ldr r0, _0217EE5C // =0x00001FFE
	str lr, [sp, #0x34]
	and r1, r0, r3, lsr #16
	and r2, r0, ip, lsr #16
	rsb r1, r1, r0, lsr #1
	ldr r3, [sp, #0x30]
	rsb r0, r2, r0, lsr #1
	add r3, r3, r1
	ldr r2, [sp, #0x38]
	ldr r1, [sp, #0x24]
	add r0, r2, r0
	cmp r3, r1
	str r0, [sp, #0x38]
	str r3, [sp, #0x30]
	addeq r0, r3, #1
	streq r0, [sp, #0x30]
	ldr r1, [sp, #0x38]
	ldr r0, [sp, #0x2c]
	add r2, sp, #0x24
	cmp r1, r0
	addeq r0, r1, #1
	streq r0, [sp, #0x38]
	add r1, sp, #0x30
	mov r0, r4
	mov r3, #0x2000
	bl SailTorpedo2__Create
	ldr r1, [sp, #0x34]
	add r0, sp, #0x30
	sub r1, r1, #0x1000
	str r1, [sp, #0x34]
	bl EffectSailFlash__Create
	add sp, sp, #0x3c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0217EE4C: .word FX_SinCosTable_
_0217EE50: .word _mt_math_rand
_0217EE54: .word 0x00196225
_0217EE58: .word 0x3C6EF35F
_0217EE5C: .word 0x00001FFE
	arm_func_end SpawnSailTorpedo2

	arm_func_start SailTorpedo2__SetupObject
SailTorpedo2__SetupObject: // 0x0217EE60
	ldr r2, [r0, #0x124]
	ldr r1, _0217EE7C // =SailTorpedo2__State_217EE80
	str r1, [r0, #0xf4]
	ldr r0, [r0, #0x28]
	mov r0, r0, lsr #4
	str r0, [r2, #0x138]
	bx lr
	.align 2, 0
_0217EE7C: .word SailTorpedo2__State_217EE80
	arm_func_end SailTorpedo2__SetupObject

	arm_func_start SailTorpedo2__State_217EE80
SailTorpedo2__State_217EE80: // 0x0217EE80
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r9, r0
	ldr r4, [r9, #0x124]
	bl SailManager__GetWork
	ldr r11, [r9, #0x12c]
	bl SailManager__GetWork
	mov r10, r0
	bl SailManager__GetShipType
	cmp r0, #0
	beq _0217EEC0
	cmp r0, #1
	beq _0217F150
	cmp r0, #2
	beq _0217F024
	b _0217F170
_0217EEC0:
	add r0, r4, #0x100
	ldrh r1, [r0, #0x2c]
	bic r1, r1, #1
	strh r1, [r0, #0x2c]
	ldr r0, [r4, #0x15c]
	ldr r2, [r0, #0x4c]
	ldr r1, [r0, #0x48]
	ldr r0, [r0, #0x44]
	str r0, [sp]
	str r1, [sp, #4]
	str r2, [sp, #8]
	bl SailVoyageManager__GetVoyageVelocity
	mov r1, r0
	add r0, sp, #0
	mov r2, r0
	bl VEC_Add
	ldrh r1, [r10, #0x10]
	ldr r5, [r4, #0x15c]
	ldr r3, [r9, #0x4c]
	mov r2, r1, asr #1
	rsb r2, r2, #4
	ldr r6, [r5, #0x4c]
	mov r2, r2, lsl #0x10
	ldr r10, [r5, #0x44]
	mov r0, r1, lsl #5
	sub r3, r6, r3
	ldr r8, [r9, #0x44]
	mov r7, r2, asr #0x10
	subs r2, r10, r8
	rsbmi r2, r2, #0
	cmp r3, #0
	rsblt r3, r3, #0
	add r5, r0, #0x140
	add r6, r0, #0x80
	mov r8, #0x60
	cmp r2, r3
	ldr r0, _0217F3D8 // =0x00000F5E
	mov ip, #0
	ble _0217EFA8
	umull r0, lr, r2, r0
	mla lr, r2, ip, lr
	mov r10, r2, asr #0x1f
	ldr r2, _0217F3D8 // =0x00000F5E
	adds r0, r0, #0x800
	mla lr, r10, r2, lr
	mov r0, r0, lsr #0xc
	adc r2, lr, #0
	orr r0, r0, r2, lsl #20
	ldr r2, _0217F3DC // =0x0000065D
	mov r10, r3, asr #0x1f
	umull lr, ip, r3, r2
	mov r2, #0
	mla ip, r3, r2, ip
	ldr r2, _0217F3DC // =0x0000065D
	adds r3, lr, #0x800
	mla ip, r10, r2, ip
	adc r2, ip, #0
	b _0217EFF0
_0217EFA8:
	umull r0, lr, r3, r0
	mla lr, r3, ip, lr
	mov r10, r3, asr #0x1f
	ldr r3, _0217F3D8 // =0x00000F5E
	adds r0, r0, #0x800
	mla lr, r10, r3, lr
	mov r0, r0, lsr #0xc
	adc r3, lr, #0
	orr r0, r0, r3, lsl #20
	ldr r3, _0217F3DC // =0x0000065D
	mov ip, r2, asr #0x1f
	umull r10, lr, r2, r3
	mov r3, #0
	mla lr, r2, r3, lr
	ldr r2, _0217F3DC // =0x0000065D
	adds r3, r10, #0x800
	mla lr, ip, r2, lr
	adc r2, lr, #0
_0217EFF0:
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, r0, r3
	mov r0, #0x600
	mul r0, r1, r0
	rsb r0, r0, #0x6800
	cmp r0, r2
	ble _0217F170
	add r0, r4, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
	b _0217F170
_0217F024:
	add r0, r4, #0x100
	ldrh r1, [r0, #0x2c]
	mov r5, #0x80
	mov r6, r5
	bic r1, r1, #1
	strh r1, [r0, #0x2c]
	ldr r0, [r4, #0x15c]
	mov r8, #0xb4
	ldr r2, [r0, #0x4c]
	ldr r1, [r0, #0x48]
	ldr r0, [r0, #0x44]
	mov r7, #0xa
	str r1, [sp, #4]
	str r2, [sp, #8]
	str r0, [sp]
	ldr r0, [r4, #0x15c]
	ldr r1, [r9, #0x4c]
	ldr r3, [r0, #0x4c]
	ldr r2, [r0, #0x44]
	ldr r0, [r9, #0x44]
	sub r1, r3, r1
	subs r2, r2, r0
	rsbmi r2, r2, #0
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r2, r1
	ldr lr, _0217F3DC // =0x0000065D
	ldr r0, _0217F3D8 // =0x00000F5E
	ble _0217F0E8
	mov r3, #0
	umull r0, ip, r2, r0
	mla ip, r2, r3, ip
	mov r10, r2, asr #0x1f
	ldr r2, _0217F3D8 // =0x00000F5E
	adds r0, r0, #0x800
	mla ip, r10, r2, ip
	adc r2, ip, #0
	umull ip, r10, r1, lr
	mov r0, r0, lsr #0xc
	orr r0, r0, r2, lsl #20
	mla r10, r1, r3, r10
	mov r2, r1, asr #0x1f
	mla r10, r2, lr, r10
	adds r2, ip, #0x800
	adc r1, r10, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r0, r0, r2
	b _0217F134
_0217F0E8:
	umull r3, r10, r1, r0
	mov r0, #0
	adds r3, r3, #0x800
	mov ip, r3, lsr #0xc
	mla r10, r1, r0, r10
	mov r3, r1, asr #0x1f
	ldr r1, _0217F3D8 // =0x00000F5E
	mla r10, r3, r1, r10
	adc r1, r10, #0
	umull r10, r3, r2, lr
	orr ip, ip, r1, lsl #20
	mla r3, r2, r0, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, lr, r3
	adds r1, r10, #0x800
	adc r0, r3, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, ip, r1
_0217F134:
	cmp r0, #0x6000
	bge _0217F170
	add r0, r4, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
	b _0217F170
_0217F150:
	mov r8, #0
	sub r0, r8, #0x4000
	str r8, [sp]
	str r0, [sp, #4]
	str r8, [sp, #8]
	mov r6, #0x80
	mov r5, #0x18
	mov r7, #0x10
_0217F170:
	add r0, r4, #0x100
	ldrh r0, [r0, #0x2c]
	tst r0, #2
	bne _0217F1FC
	ldr r1, [r9, #0x2c]
	ldr r0, [sp]
	mov r2, r1, lsl #0x10
	ldr r1, [r4, #0x148]
	mov r2, r2, lsr #0x10
	bl ObjAlphaSet
	str r0, [r4, #0x10]
	ldr r1, [r9, #0x2c]
	ldr r0, [sp, #4]
	mov r2, r1, lsl #0x10
	ldr r1, [r4, #0x14c]
	mov r2, r2, lsr #0x10
	bl ObjAlphaSet
	str r0, [r4, #0x14]
	ldr r1, [r9, #0x2c]
	ldr r0, [sp, #8]
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	ldr r1, [r4, #0x150]
	bl ObjAlphaSet
	str r0, [r4, #0x18]
	ldr r3, [r4, #0x144]
	ldr r2, [r4, #0x140]
	ldr r1, [r4, #0x13c]
	mov r0, r9
	str r1, [sp]
	str r2, [sp, #4]
	add r1, sp, #0
	add r2, r4, #0x10
	str r3, [sp, #8]
	bl SailObject__Func_216688C
_0217F1FC:
	ldr r0, [r4, #0x128]
	add r0, r0, #1
	str r0, [r4, #0x128]
	cmp r0, r7
	ble _0217F224
	ldr r0, [r9, #0x2c]
	mov r1, r5
	mov r2, #0x1000
	bl ObjSpdUpSet
	str r0, [r9, #0x2c]
_0217F224:
	cmp r8, #0
	beq _0217F24C
	ldr r0, [r4, #0x128]
	cmp r0, r8
	bne _0217F24C
	add r0, r9, #0x44
	bl EffectSailBomb__Create
	ldr r0, [r9, #0x18]
	orr r0, r0, #4
	str r0, [r9, #0x18]
_0217F24C:
	ldr r0, [r4, #0x138]
	ldr r2, [r9, #0x28]
	mov r1, r6
	bl ObjSpdUpSet
	str r0, [r4, #0x138]
	mov r1, #0
	str r1, [r9, #0x98]
	str r1, [r9, #0x9c]
	str r0, [r9, #0xa0]
	add r0, r9, #0x98
	add r1, r11, #0x24
	mov r2, r0
	bl MTX_MultVec33
	ldr r1, [r9, #0x9c]
	add r0, r4, #0x100
	rsb r1, r1, #0
	str r1, [r9, #0x9c]
	ldrh r0, [r0, #0x2c]
	tst r0, #1
	bne _0217F3B0
	bl SailManager__GetShipType
	cmp r0, #1
	bne _0217F2D8
	ldr r1, [r4, #0x148]
	ldr r0, [r9, #0x98]
	add r0, r1, r0
	str r0, [r4, #0x148]
	ldr r1, [r4, #0x14c]
	ldr r0, [r9, #0x9c]
	add r0, r1, r0
	str r0, [r4, #0x14c]
	ldr r1, [r4, #0x150]
	ldr r0, [r9, #0xa0]
	add r0, r1, r0
	str r0, [r4, #0x150]
_0217F2D8:
	ldr r1, [r4, #0x13c]
	ldr r0, [r9, #0x98]
	add r0, r1, r0
	str r0, [r4, #0x13c]
	ldr r1, [r4, #0x140]
	ldr r0, [r9, #0x9c]
	add r0, r1, r0
	str r0, [r4, #0x140]
	ldr r1, [r4, #0x144]
	ldr r0, [r9, #0xa0]
	add r0, r1, r0
	str r0, [r4, #0x144]
	ldr r0, [r9, #0x24]
	tst r0, #1
	bne _0217F378
	bl SailVoyageManager__GetVoyageVelocity
	ldr r2, [r4, #0x148]
	ldr r1, [r0, #0]
	sub r1, r2, r1
	str r1, [r4, #0x148]
	ldr r2, [r4, #0x14c]
	ldr r1, [r0, #4]
	sub r1, r2, r1
	str r1, [r4, #0x14c]
	ldr r2, [r4, #0x150]
	ldr r1, [r0, #8]
	sub r1, r2, r1
	str r1, [r4, #0x150]
	ldr r2, [r4, #0x13c]
	ldr r1, [r0, #0]
	sub r1, r2, r1
	str r1, [r4, #0x13c]
	ldr r2, [r4, #0x140]
	ldr r1, [r0, #4]
	sub r1, r2, r1
	str r1, [r4, #0x140]
	ldr r1, [r4, #0x144]
	ldr r0, [r0, #8]
	sub r0, r1, r0
	str r0, [r4, #0x144]
_0217F378:
	ldr r0, [r4, #0x13c]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x8000
	bge _0217F3B0
	ldr r0, [r4, #0x144]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x8000
	bge _0217F3B0
	add r0, r4, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #1
	strh r1, [r0, #0x2c]
_0217F3B0:
	mov r0, r9
	mov r1, #0
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	ldrne r0, [r9, #0x18]
	orrne r0, r0, #4
	strne r0, [r9, #0x18]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0217F3D8: .word 0x00000F5E
_0217F3DC: .word 0x0000065D
	arm_func_end SailTorpedo2__State_217EE80

	arm_func_start SpawnSailMissile
SpawnSailMissile: // 0x0217F3E0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x30
	add ip, sp, #0x24
	mov r4, #0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	str r4, [ip]
	str r4, [ip, #4]
	str r4, [ip, #8]
	mov r4, r0
	bl SailManager__GetWork
	str r7, [sp, #0x24]
	str r6, [sp, #0x28]
	str r5, [sp, #0x2c]
	ldr r0, [r4, #0x44]
	ldr r1, [r4, #0x4c]
	rsb r0, r0, #0
	rsb r1, r1, #0
	bl FX_Atan2Idx
	tst r0, #0x8000
	ldreq r0, [sp, #0x24]
	ldr r3, _0217F4BC // =FX_SinCosTable_
	rsbeq r0, r0, #0
	streq r0, [sp, #0x24]
	ldrh r1, [r4, #0x32]
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, sp, #0x24
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
	add r0, sp, #0x24
	add r1, r4, #0x44
	mov r2, r0
	bl VEC_Add
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x48]
	sub r1, r1, #0x2000
	str r1, [sp, #0x28]
	ldr r3, [sp, #0x4c]
	mov r0, r4
	add r1, sp, #0x24
	bl SailMissile__Create
	add r0, sp, #0x24
	bl EffectSailFlash__Create
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0217F4BC: .word FX_SinCosTable_
	arm_func_end SpawnSailMissile

	arm_func_start SailMissile__SetupObject
SailMissile__SetupObject: // 0x0217F4C0
	ldr r2, _0217F4E8 // =SailMissile__State_217F4F0
	mov r1, #0
	str r2, [r0, #0xf4]
	str r1, [r0, #0x2c]
	sub r1, r1, #0x1200
	str r1, [r0, #0x9c]
	mov r1, #0xc000
	ldr ip, _0217F4EC // =SailObject__ApplyRotation
	strh r1, [r0, #0x30]
	bx ip
	.align 2, 0
_0217F4E8: .word SailMissile__State_217F4F0
_0217F4EC: .word SailObject__ApplyRotation
	arm_func_end SailMissile__SetupObject

	arm_func_start SailMissile__State_217F4F0
SailMissile__State_217F4F0: // 0x0217F4F0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0xa
	movgt r0, #0
	bgt _0217F524
	mov r1, #0x200
	ldr r0, [r4, #0x9c]
	rsb r1, r1, #0
	mov r2, #0x2000
	bl ObjSpdUpSet
_0217F524:
	str r0, [r4, #0x9c]
	ldr r0, [r4, #0x28]
	ldr r1, [r4, #0x2c]
	add r0, r0, #0x28
	cmp r1, r0
	bls _0217F544
	mov r0, r4
	bl SailMissile__Func_217F568
_0217F544:
	mov r0, r4
	mov r1, #0
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x100
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl SailMissile__Func_217F720
	ldmia sp!, {r4, pc}
	arm_func_end SailMissile__State_217F4F0

	arm_func_start SailMissile__Func_217F568
SailMissile__Func_217F568: // 0x0217F568
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x30
	mov r6, r0
	ldr r4, [r6, #0x124]
	bl SailManager__GetWork
	ldr r5, [r0, #0x98]
	ldr r1, _0217F694 // =SailMissile__State_217F6AC
	mov r0, #0
	str r1, [r6, #0xf4]
	str r0, [r6, #0x2c]
	mov r0, #0x500
	str r0, [r6, #0x9c]
	add r0, r4, #0x100
	ldrh r0, [r0, #0x2c]
	mov r1, #0x4000
	tst r0, #4
	movne r0, #0x380
	strne r0, [r6, #0x9c]
	mov r0, r6
	strh r1, [r6, #0x30]
	bl SailObject__ApplyRotation
	mov r1, #0
	str r1, [r6, #0x44]
	sub r0, r1, #0x18000
	str r0, [r6, #0x48]
	ldr r7, _0217F698 // =_mt_math_rand
	str r1, [r6, #0x4c]
	ldr r0, [r7, #0]
	ldr r3, _0217F69C // =0x00196225
	ldr ip, _0217F6A0 // =0x3C6EF35F
	ldr lr, _0217F6A4 // =0x000007FE
	mla r2, r0, r3, ip
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	str r2, [r7]
	and r0, lr, r0, lsr #16
	ldr r2, [r6, #0x44]
	rsb r0, r0, lr, lsr #1
	add r0, r2, r0
	str r0, [r6, #0x44]
	ldr r0, [r7, #0]
	ldr r2, _0217F6A8 // =FX_SinCosTable_
	mla r3, r0, r3, ip
	mov r0, r3, lsr #0x10
	mov r0, r0, lsl #0x10
	str r3, [r7]
	and r0, lr, r0, lsr #16
	ldr r3, [r6, #0x4c]
	rsb r0, r0, lr, lsr #1
	add r0, r3, r0
	str r0, [r6, #0x4c]
	ldr r3, [r4, #0x138]
	add r0, sp, #0xc
	str r3, [sp, #8]
	str r1, [sp]
	str r1, [sp, #4]
	ldrh r1, [r5, #0x34]
	mov r1, r1, asr #4
	mov r3, r1, lsl #1
	add r1, r3, #1
	mov r4, r3, lsl #1
	mov r3, r1, lsl #1
	ldrsh r1, [r2, r4]
	ldrsh r2, [r2, r3]
	bl MTX_RotY33_
	add r0, sp, #0
	add r1, sp, #0xc
	mov r2, r0
	bl MTX_MultVec33
	add r1, r6, #0x44
	add r0, sp, #0
	mov r2, r1
	bl VEC_Add
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0217F694: .word SailMissile__State_217F6AC
_0217F698: .word _mt_math_rand
_0217F69C: .word 0x00196225
_0217F6A0: .word 0x3C6EF35F
_0217F6A4: .word 0x000007FE
_0217F6A8: .word FX_SinCosTable_
	arm_func_end SailMissile__Func_217F568

	arm_func_start SailMissile__State_217F6AC
SailMissile__State_217F6AC: // 0x0217F6AC
	stmdb sp!, {r4, lr}
	mov r1, #0
	mov r4, r0
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x100
	beq _0217F6D4
	mov r0, r4
	bl SailMissile__Func_217F720
	ldmia sp!, {r4, pc}
_0217F6D4:
	tst r0, #0x200
	beq _0217F700
	ldr r0, [r4, #0x138]
	add r2, r4, #0x44
	mov r1, #0x28
	bl SailAudio__PlaySpatialSequence
	add r0, r4, #0x44
	bl EffectSailBomb__Create
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
_0217F700:
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0x50
	ldrgt r0, [r4, #0x18]
	orrgt r0, r0, #4
	strgt r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	arm_func_end SailMissile__State_217F6AC

	arm_func_start SailMissile__Func_217F720
SailMissile__Func_217F720: // 0x0217F720
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x124]
	bl SailManager__GetWork
	ldr r1, [r4, #0x15c]
	ldr r3, [r0, #0x98]
	ldr r2, [r1, #0x124]
	ldr r1, _0217F7D4 // =SailMissile__State_217F7D8
	mov r0, #0x4000
	str r1, [r5, #0xf4]
	str r0, [r5, #4]
	str r0, [r5, #8]
	mov r1, #0
	str r1, [r5, #0x2c]
	str r1, [r5, #0x28]
	str r1, [r5, #0x9c]
	strh r1, [r5, #0x30]
	add r0, r2, #0x100
	ldrh ip, [r3, #0x34]
	ldrsh r3, [r0, #0xca]
	mov r0, r5
	mov r2, #0x2800
	sub r3, ip, r3
	strh r3, [r5, #0x32]
	str r2, [r4, #0x13c]
	bl StageTask__GetCollider
	mov r1, #1
	orr r1, r1, #0x200
	strh r1, [r0, #0x34]
	mov r1, #0
	str r1, [r0, #0x24]
	mov r1, #0xa
	strh r1, [r0, #0x2c]
	mov r1, #0x64
	strh r1, [r0, #0x2e]
	ldr r1, [r4, #0x98]
	mov r1, r1, lsl #1
	str r1, [r4, #0x98]
	ldr r1, [r0, #0x18]
	bic r1, r1, #0x100
	str r1, [r0, #0x18]
	ldrh r0, [r4, #0x9c]
	orr r0, r0, #0x1000
	strh r0, [r4, #0x9c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0217F7D4: .word SailMissile__State_217F7D8
	arm_func_end SailMissile__Func_217F720

	arm_func_start SailMissile__State_217F7D8
SailMissile__State_217F7D8: // 0x0217F7D8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r8, r0
	ldr r6, [r8, #0x11c]
	ldr r5, [r8, #0x124]
	cmp r6, #0
	bne _0217F854
	mov r7, #0
	mov r4, #2
_0217F7FC:
	mov r0, r4
	mov r1, r7
	bl ObjRect__RegistGet
	cmp r0, #0
	beq _0217F854
	ldr r1, [r0, #0x18]
	tst r1, #0x800
	bne _0217F844
	ldr r2, [r0, #0x1c]
	cmp r2, #0
	beq _0217F844
	ldrh r1, [r2, #0]
	cmp r1, #1
	bne _0217F844
	ldr r1, [r2, #0x18]
	tst r1, #4
	streq r2, [r8, #0x11c]
	ldreq r6, [r0, #0x1c]
_0217F844:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, asr #0x10
	b _0217F7FC
_0217F854:
	cmp r6, #0
	beq _0217F908
	ldr r0, [r8, #0x28]
	cmp r0, #8
	bls _0217F908
	add r1, sp, #0
	mov r0, r6
	bl SailObject__Func_2165A9C
	ldr r1, [sp, #4]
	add r0, sp, #0
	rsb r1, r1, #0
	str r1, [sp, #4]
	mov r2, r0
	add r1, r6, #0x44
	bl VEC_Add
	ldr r0, [r8, #0x28]
	cmp r0, #0xc
	bls _0217F8CC
	ldr r3, [sp]
	ldr r0, [r8, #0x44]
	ldr r2, [sp, #8]
	ldr r1, [r8, #0x4c]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r1, r0
	ldrh r0, [r8, #0x32]
	mov r2, #0xc0
	bl ObjRoopMove16
	strh r0, [r8, #0x32]
_0217F8CC:
	ldr r1, [r8, #0x48]
	ldr r0, [sp, #4]
	mov r2, #0x420
	cmp r1, r0
	ldr r0, [r8, #0x9c]
	ble _0217F8F0
	mvn r1, #0x3f
	bl ObjSpdUpSet
	b _0217F8F8
_0217F8F0:
	mov r1, #0x40
	bl ObjSpdUpSet
_0217F8F8:
	str r0, [r8, #0x9c]
	ldr r0, [r8, #0x9c]
	mov r0, r0, lsl #2
	strh r0, [r8, #0x30]
_0217F908:
	ldr r0, [r5, #0x13c]
	cmp r0, #0xe00
	ble _0217F920
	mov r1, #0x280
	bl ObjSpdDownSet
	str r0, [r5, #0x13c]
_0217F920:
	ldrh r0, [r8, #0x32]
	ldr r3, _0217F9EC // =FX_SinCosTable_
	ldr r2, [r5, #0x13c]
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r1, [r3, r0]
	mov r0, r8
	smull r4, r1, r2, r1
	adds r2, r4, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r8, #0x98]
	ldrh r1, [r8, #0x32]
	ldr r2, [r5, #0x13c]
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #1
	ldrsh r1, [r3, r1]
	smull r3, r1, r2, r1
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r8, #0xa0]
	bl SailObject__ApplyRotation
	ldr r1, [r8, #0x28]
	mov r0, r8
	add r1, r1, #1
	str r1, [r8, #0x28]
	mov r1, #0
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	bne _0217F9C0
	ldr r0, [r8, #0x28]
	cmp r0, #0x60
	addls sp, sp, #0xc
	ldmlsia sp!, {r3, r4, r5, r6, r7, r8, pc}
_0217F9C0:
	ldr r0, [r8, #0x138]
	add r2, r8, #0x44
	mov r1, #0x28
	bl SailAudio__PlaySpatialSequence
	add r0, r8, #0x44
	bl EffectSailBomb__Create
	ldr r0, [r8, #0x18]
	orr r0, r0, #4
	str r0, [r8, #0x18]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0217F9EC: .word FX_SinCosTable_
	arm_func_end SailMissile__State_217F7D8

	arm_func_start SpawnSailTorpedo3
SpawnSailTorpedo3: // 0x0217F9F0
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x30
	add ip, sp, #0x24
	mov r4, #0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	str r4, [ip]
	str r4, [ip, #4]
	str r4, [ip, #8]
	mov r4, r0
	bl SailManager__GetWork
	str r7, [sp, #0x24]
	str r6, [sp, #0x28]
	str r5, [sp, #0x2c]
	ldr r0, [r4, #0x44]
	ldr r1, [r4, #0x4c]
	rsb r0, r0, #0
	rsb r1, r1, #0
	bl FX_Atan2Idx
	tst r0, #0x8000
	ldreq r0, [sp, #0x24]
	ldr r3, _0217FAC4 // =FX_SinCosTable_
	rsbeq r0, r0, #0
	streq r0, [sp, #0x24]
	ldrh r1, [r4, #0x32]
	add r0, sp, #0
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	add r0, sp, #0x24
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec33
	add r0, sp, #0x24
	add r1, r4, #0x44
	mov r2, r0
	bl VEC_Add
	ldr r0, [sp, #0x28]
	add r1, sp, #0x24
	sub r2, r0, #0x2000
	mov r0, r4
	str r2, [sp, #0x28]
	bl SailTorpedo3__Create
	add r0, sp, #0x24
	bl EffectSailFlash__Create
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0217FAC4: .word FX_SinCosTable_
	arm_func_end SpawnSailTorpedo3

	arm_func_start SailTorpedo3__SetupObject
SailTorpedo3__SetupObject: // 0x0217FAC8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	ldr r2, [r4, #0x124]
	ldr r1, _0217FD00 // =SailTorpedo3__State_217FD10
	mov r0, #0x1400
	str r1, [r4, #0xf4]
	str r0, [r4, #0x2c]
	add r0, r2, #0x100
	ldrh r0, [r0, #0x2c]
	ldr r1, [r4, #0x4c]
	ldr r2, _0217FD04 // =0x00000F5E
	tst r0, #4
	ldr r0, [r4, #0x44]
	beq _0217FBB4
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r0, r1
	ldr r3, _0217FD08 // =0x0000065D
	mov ip, #0
	ble _0217FB60
	umull lr, r7, r0, r2
	mla r7, r0, ip, r7
	umull r6, r5, r1, r3
	mov r0, r0, asr #0x1f
	mla r7, r0, r2, r7
	adds lr, lr, #0x800
	adc r7, r7, #0
	adds r2, r6, #0x800
	mov r6, lr, lsr #0xc
	mla r5, r1, ip, r5
	mov r0, r1, asr #0x1f
	mla r5, r0, r3, r5
	adc r0, r5, #0
	mov r1, r2, lsr #0xc
	orr r6, r6, r7, lsl #20
	b _0217FB9C
_0217FB60:
	umull lr, r7, r1, r2
	mla r7, r1, ip, r7
	umull r6, r5, r0, r3
	mla r5, r0, ip, r5
	mov r1, r1, asr #0x1f
	mov r0, r0, asr #0x1f
	mla r7, r1, r2, r7
	adds lr, lr, #0x800
	adc r2, r7, #0
	adds r1, r6, #0x800
	mla r5, r0, r3, r5
	mov r6, lr, lsr #0xc
	adc r0, r5, #0
	mov r1, r1, lsr #0xc
	orr r6, r6, r2, lsl #20
_0217FB9C:
	orr r1, r1, r0, lsl #20
	add r0, r6, r1
	mov r1, #0xa0000
	bl FX_Div
	str r0, [r4, #0x2c]
	b _0217FC6C
_0217FBB4:
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r0, r1
	ldr r3, _0217FD08 // =0x0000065D
	mov ip, #0
	ble _0217FC1C
	umull lr, r7, r0, r2
	mla r7, r0, ip, r7
	umull r6, r5, r1, r3
	mov r0, r0, asr #0x1f
	mla r7, r0, r2, r7
	adds lr, lr, #0x800
	adc r7, r7, #0
	adds r2, r6, #0x800
	mov r6, lr, lsr #0xc
	mla r5, r1, ip, r5
	mov r0, r1, asr #0x1f
	mla r5, r0, r3, r5
	adc r0, r5, #0
	mov r1, r2, lsr #0xc
	orr r6, r6, r7, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r6, r1
	b _0217FC60
_0217FC1C:
	umull r7, r6, r1, r2
	mla r6, r1, ip, r6
	umull r5, lr, r0, r3
	mla lr, r0, ip, lr
	mov r1, r1, asr #0x1f
	mov r0, r0, asr #0x1f
	mla r6, r1, r2, r6
	adds r7, r7, #0x800
	adc r2, r6, #0
	adds r1, r5, #0x800
	mla lr, r0, r3, lr
	mov r5, r7, lsr #0xc
	adc r0, lr, #0
	mov r1, r1, lsr #0xc
	orr r5, r5, r2, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r5, r1
_0217FC60:
	mov r1, #0x78000
	bl FX_Div
	str r0, [r4, #0x2c]
_0217FC6C:
	mov r0, #0
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x44]
	ldr r1, [r4, #0x4c]
	rsb r0, r0, #0
	rsb r1, r1, #0
	bl FX_Atan2Idx
	strh r0, [r4, #0x32]
	ldrh r0, [r4, #0x32]
	ldr r3, _0217FD0C // =FX_SinCosTable_
	ldr r2, [r4, #0x2c]
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r1, [r3, r0]
	mov r0, #0x800
	sub r0, r0, #0xb00
	smull ip, r1, r2, r1
	adds r2, ip, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x98]
	ldrh r1, [r4, #0x32]
	ldr r2, [r4, #0x2c]
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #1
	ldrsh r1, [r3, r1]
	smull r3, r1, r2, r1
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0xa0]
	str r0, [r4, #0x9c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0217FD00: .word SailTorpedo3__State_217FD10
_0217FD04: .word 0x00000F5E
_0217FD08: .word 0x0000065D
_0217FD0C: .word FX_SinCosTable_
	arm_func_end SailTorpedo3__SetupObject

	arm_func_start SailTorpedo3__State_217FD10
SailTorpedo3__State_217FD10: // 0x0217FD10
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x124]
	mov r2, #0x500
	add r0, r0, #0x100
	ldrh r0, [r0, #0x2c]
	tst r0, #4
	ldr r0, [r4, #0x9c]
	beq _0217FD40
	mov r1, #9
	bl ObjSpdUpSet
	b _0217FD48
_0217FD40:
	mov r1, #0xc
	bl ObjSpdUpSet
_0217FD48:
	str r0, [r4, #0x9c]
	ldrh r0, [r4, #0x32]
	ldr r3, _0217FE50 // =FX_SinCosTable_
	ldr r2, [r4, #0x2c]
	mov r0, r0, asr #4
	mov r0, r0, lsl #2
	ldrsh r1, [r3, r0]
	mov r0, r4
	smull ip, r1, r2, r1
	adds r2, ip, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0x98]
	ldrh r1, [r4, #0x32]
	ldr r2, [r4, #0x2c]
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #1
	ldrsh r1, [r3, r1]
	smull r3, r1, r2, r1
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0xa0]
	ldr r1, [r4, #0x9c]
	mov r1, r1, lsl #2
	strh r1, [r4, #0x30]
	bl SailObject__ApplyRotation
	mov r0, r4
	mov r1, #0
	bl StageTask__GetCollider
	ldr r0, [r0, #0x18]
	tst r0, #0x200
	beq _0217FE34
	ldr r0, [r4, #0x138]
	add r2, r4, #0x44
	mov r1, #0x29
	bl SailAudio__PlaySpatialSequence
	add r0, r4, #0x44
	bl EffectSailBomb__Create
	ldr r3, [r0, #0x38]
	mov r1, #0x800
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #0xd
	adds ip, r1, r3, lsl #13
	orr r2, r2, r3, lsr #19
	adc r1, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x38]
	str r2, [r0, #0x3c]
	str r2, [r0, #0x40]
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
_0217FE34:
	ldr r0, [r4, #0x28]
	cmp r0, #0x28
	ldmlsia sp!, {r4, pc}
	ldr r0, [r4, #0x18]
	orr r0, r0, #4
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217FE50: .word FX_SinCosTable_
	arm_func_end SailTorpedo3__State_217FD10

	arm_func_start SailSailerBoat__Func_217FE54
SailSailerBoat__Func_217FE54: // 0x0217FE54
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r0, #0x124]
	bl SailManager__GetWork
	ldr r2, [r4, #0x170]
	ldr r1, [r0, #0x98]
	cmp r2, #0
	rsblt r5, r2, #0
	movge r5, r2
	cmp r5, #0x18000
	bge _0217FEB0
	add r0, r4, #0x100
	cmp r2, #0
	mov r2, #0x18000
	ldrh r3, [r0, #0x2c]
	bge _0217FEA4
	bic r3, r3, #4
	rsb r2, r2, #0
	strh r3, [r0, #0x2c]
	str r2, [r4, #0x170]
	b _0217FEB0
_0217FEA4:
	bic r3, r3, #8
	strh r3, [r0, #0x2c]
	str r2, [r4, #0x170]
_0217FEB0:
	cmp r5, #0x51000
	ble _0217FEF0
	ldr r0, [r4, #0x170]
	mov r2, #0x51000
	cmp r0, #0
	add r0, r4, #0x100
	ldrh r3, [r0, #0x2c]
	bge _0217FEE4
	bic r3, r3, #8
	rsb r2, r2, #0
	strh r3, [r0, #0x2c]
	str r2, [r4, #0x170]
	b _0217FEF0
_0217FEE4:
	bic r3, r3, #4
	strh r3, [r0, #0x2c]
	str r2, [r4, #0x170]
_0217FEF0:
	ldr r0, [r4, #0x170]
	mov r2, #0
	cmp r0, #0
	rsblt r0, r0, #0
	sub r0, r0, #0x18000
	mov r3, r0, asr #5
	mov r0, #0x5000
	umull lr, ip, r3, r0
	mla ip, r3, r2, ip
	mov r2, r3, asr #0x1f
	mla ip, r2, r0, ip
	adds r3, lr, #0x800
	adc r0, ip, #0
	mov lr, r3, lsr #0xc
	orr lr, lr, r0, lsl #20
	mov r2, #0xa800
	sub r0, r2, #0x15000
	sub r2, r0, lr
	add r3, lr, #0xa800
	ldr r0, [r4, #0x184]
	ldr r5, [r4, #0x178]
	ldr ip, [r1, #0x44]
	add r3, r3, #0x4000
	sub r5, r5, ip
	add r2, r2, #0x4000
	cmp r0, #0
	add ip, r3, lr, asr #1
	add r0, r2, lr, asr #1
	cmpgt r5, ip
	ble _0217FF84
	add r2, r4, #0x100
	ldrh r3, [r2, #0x2c]
	bic r3, r3, #2
	strh r3, [r2, #0x2c]
	ldr r2, [r1, #0x44]
	add r2, ip, r2
	str r2, [r4, #0x178]
_0217FF84:
	ldr r2, [r4, #0x184]
	cmp r2, #0
	cmplt r5, r0
	ldmgeia sp!, {r3, r4, r5, pc}
	add r2, r4, #0x100
	ldrh r3, [r2, #0x2c]
	bic r3, r3, #1
	strh r3, [r2, #0x2c]
	ldr r1, [r1, #0x44]
	add r0, r0, r1
	str r0, [r4, #0x178]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailSailerBoat__Func_217FE54

	.rodata

_0218C414: // 0x0218C414
    .byte 0, 0, 0, 0, 1, 6, 6, 7

_0218C41C: // 0x0218C41C
    .byte 0, 1, 1, 0, 0, 0, 3, 3, 4, 0, 0, 0

_0218C428: // 0x0218C428
    .byte 0xA, 0x10, 0x16, 0x20, 0x10, 0x16, 0x1C, 0x28, 0xA, 0x1A, 0x2A, 0x40

_0218C434: // 0x0218C434
    .byte 0xC, 0x1A, 0x20, 0x38, 0x1E, 0x24, 0x30, 0x30, 0x56, 0x78, 0x78, 0x8C, 0xB4, 0xC, 0, 0

	.data

aSbBirdNsbmd_1: // 0x0218D57C
	.asciz "sb_bird.nsbmd"
    .align 4

aSbSBoat03Nsbmd_0: // 0x0218D58C
	.asciz "sb_s_boat03.nsbmd"
    .align 4

aSbSBoat02Nsbmd_0: // 0x0218D5A0
	.asciz "sb_s_boat02.nsbmd"
    .align 4

aSbBigbob01Nsbm_0: // 0x0218D5B4
	.asciz "sb_bigbob01.nsbmd"
    .align 4

aSbBigbob02Nsbm_0: // 0x0218D5C8
	.asciz "sb_bigbob02.nsbmd"
    .align 4

aSbCruiserNsbmd_0: // 0x0218D5DC
	.asciz "sb_cruiser.nsbmd"
    .align 4

aSbSBoat01Nsbmd_0: // 0x0218D5F0
	.asciz "sb_s_boat01.nsbmd"
    .align 4

aSbCruiser02Nsb_0: // 0x0218D604
	.asciz "sb_cruiser02.nsbmd"
    .align 4

aSbShellBac_2: // 0x0218D618
	.asciz "sb_shell.bac"
    .align 4

aSbBomberBac_1: // 0x0218D628
	.asciz "sb_bomber.bac"
    .align 4

aSbTorpedoNsbmd_0: // 0x0218D638
	.asciz "sb_torpedo.nsbmd"
    .align 4

aSbMissileNsbmd_0: // 0x0218D64C
	.asciz "sb_missile.nsbmd"
    .align 4