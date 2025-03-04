	.include "asm/macros.inc"
	.include "global.inc"

	.public shipShiftUnknown

	.text
    
	arm_func_start SailCamera__Create
SailCamera__Create: // 0x0215F1C4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x2c
	mov r0, #0x3800
	mov r1, #0
	str r0, [sp]
	mov r4, #3
	str r4, [sp, #4]
	mov r4, #0x40
	ldr r0, _0215F4E4 // =SailCamera__Main
	mov r2, r1
	mov r3, r1
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x40
	bl MIi_CpuClear16
	mov r0, #1
	mov r1, #0x3f00
	bl BossArena__Create
	mov r0, #0
	bl BossArena__GetCamera
	mov r1, #0
	mov r5, r0
	bl BossArena__SetCameraType
	mov r0, #0
	add r1, sp, #0xc
	mov r2, #0x20
	bl MIi_CpuClear16
	mov r0, #0xc00
	strh r0, [sp, #0xc]
	mov r0, #0x1000
	str r0, [sp, #0x10]
	str r0, [sp, #0x1c]
	mov r0, #0x190000
	str r0, [sp, #0x14]
	ldr r0, _0215F4E8 // =0x00001555
	str r0, [sp, #0x18]
	bl SailManager__GetShipType
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0215F458
_0215F274: // jump table
	b _0215F284 // case 0
	b _0215F3B4 // case 1
	b _0215F31C // case 2
	b _0215F40C // case 3
_0215F284:
	mov r3, #0
	str r3, [r4, #0x30]
	mov r0, #0x1800
	str r0, [r4, #0x34]
	str r3, [r4, #0x38]
	ldr r1, [r4, #0x30]
	ldr r2, [r4, #0x34]
	mov r0, r5
	bl BossArena__SetTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	mov r1, #0x1000
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, #0
	str r0, [r4, #0x24]
	mov r0, #0x3000
	str r0, [r4, #0x28]
	mov r3, #0x8000
	str r3, [r4, #0x2c]
	ldr r1, [r4, #0x24]
	ldr r2, [r4, #0x28]
	mov r0, r5
	bl BossArena__SetTracker0TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	mov r0, r5
	mov r1, #0x1000
	mov r2, #0
	bl BossArena__SetTracker0Speed
	mov r0, #0x8000
	str r0, [r4, #0x18]
	ldr r1, _0215F4EC // =SailCamera__State_JetHover
	mov r0, #0xc00
	str r1, [r4, #0x3c]
	strh r0, [sp, #0xc]
	b _0215F458
_0215F31C:
	mov r3, #0
	str r3, [r4, #0x30]
	mov r0, #0x1800
	str r0, [r4, #0x34]
	str r3, [r4, #0x38]
	ldr r1, [r4, #0x30]
	ldr r2, [r4, #0x34]
	mov r0, r5
	bl BossArena__SetTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	mov r1, #0x1000
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, #0
	str r0, [r4, #0x24]
	mov r0, #0x3600
	str r0, [r4, #0x28]
	mov r3, #0x8000
	str r3, [r4, #0x2c]
	ldr r1, [r4, #0x24]
	ldr r2, [r4, #0x28]
	mov r0, r5
	bl BossArena__SetTracker0TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	mov r0, r5
	mov r1, #0x1000
	mov r2, #0
	bl BossArena__SetTracker0Speed
	mov r0, #0x8000
	str r0, [r4, #0x18]
	ldr r1, _0215F4EC // =SailCamera__State_JetHover
	mov r0, #0xc00
	str r1, [r4, #0x3c]
	strh r0, [sp, #0xc]
	b _0215F458
_0215F3B4:
	mov r3, #0
	str r3, [r4, #0x30]
	mov r2, #0xa500
	str r2, [r4, #0x34]
	str r3, [r4, #0x38]
	str r3, [r4, #0x24]
	mov r0, #0x13000
	str r0, [r4, #0x28]
	mov r1, #0x30000
	str r1, [r4, #0x2c]
	str r3, [r4, #0x30]
	str r2, [r4, #0x34]
	str r3, [r4, #0x38]
	str r3, [r4, #0x24]
	str r0, [r4, #0x28]
	str r1, [r4, #0x2c]
	ldr r0, _0215F4F0 // =SailCamera__State_Boat
	str r1, [r4, #0x18]
	str r0, [r4, #0x3c]
	mov r0, #0xa00
	strh r0, [sp, #0xc]
	b _0215F458
_0215F40C:
	mov r3, #0
	str r3, [r4, #0x30]
	mov r2, #0x18000
	str r2, [r4, #0x34]
	str r3, [r4, #0x38]
	str r3, [r4, #0x24]
	mov r1, #0x1b000
	str r1, [r4, #0x28]
	mov r0, #0x10000
	str r0, [r4, #0x2c]
	str r3, [r4, #0x30]
	str r2, [r4, #0x34]
	str r3, [r4, #0x38]
	str r3, [r4, #0x24]
	str r1, [r4, #0x28]
	str r0, [r4, #0x2c]
	str r0, [r4, #0x18]
	mov r0, #0xa00
	strh r0, [sp, #0xc]
_0215F458:
	ldr r1, [r4, #0x30]
	ldr r2, [r4, #0x34]
	ldr r3, [r4, #0x38]
	mov r0, r5
	bl BossArena__SetTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	mov r1, #0x1000
	mov r2, #0
	bl BossArena__SetTracker1Speed
	ldr r1, [r4, #0x24]
	ldr r2, [r4, #0x28]
	ldr r3, [r4, #0x2c]
	mov r0, r5
	bl BossArena__SetTracker0TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	mov r0, r5
	mov r1, #0x1000
	mov r2, #0
	bl BossArena__SetTracker0Speed
	mov r0, r5
	add r1, sp, #0xc
	bl BossArena__SetCameraConfig
	ldr r1, [r4, #0x18]
	mov r0, #0
	str r1, [r4, #0x1c]
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	ldr r1, _0215F4F4 // =g_obj
	str r0, [r1, #0x3c]
	mov r0, r4
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0215F4E4: .word SailCamera__Main
_0215F4E8: .word 0x00001555
_0215F4EC: .word SailCamera__State_JetHover
_0215F4F0: .word SailCamera__State_Boat
_0215F4F4: .word g_obj
	arm_func_end SailCamera__Create

	arm_func_start SailCamera__Main
SailCamera__Main: // 0x0215F4F8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x1c
	bl SailManager__GetWork
	mov r5, r0
	bl GetCurrentTaskWork_
	mov r7, r0
	mov r0, #0
	bl BossArena__GetCamera
	mov r8, r0
	bl BossArena__GetCameraConfig2
	mov r6, r0
	bl SailManager__GetShipType
	ldr r1, _0215F728 // =g_obj
	mov r4, r0, lsl #0x10
	str r6, [r1, #0x3c]
	mov r0, r8
	add r1, sp, #0x10
	add r2, sp, #0x14
	add r3, sp, #0x18
	bl BossArena__GetTracker1TargetPos
	mov r0, r8
	add r1, sp, #4
	add r2, sp, #8
	add r3, sp, #0xc
	bl BossArena__GetTracker0TargetPos
	ldr r0, [r5, #0x24]
	tst r0, #1
	bne _0215F5D4
	mov r3, #0
	str r3, [sp]
	ldr r0, [r7, #0x18]
	ldr r1, [r7, #0x1c]
	mov r2, #3
	bl ObjShiftSet
	str r0, [r7, #0x18]
	mov r3, #0
	str r3, [sp]
	ldmia r7, {r0, r1}
	mov r2, #4
	bl ObjShiftSet
	str r0, [r7]
	mov r3, #0
	str r3, [sp]
	ldr r0, [r7, #0x10]
	ldr r1, [r7, #0x14]
	mov r2, #4
	bl ObjShiftSet
	str r0, [r7, #0x10]
	mov r3, #0
	str r3, [sp]
	ldr r0, [r7, #8]
	ldr r1, [r7, #0xc]
	mov r2, #4
	bl ObjShiftSet
	str r0, [r7, #8]
_0215F5D4:
	bl SailVoyageManager__GetVoyageAngle
	mov r6, r0
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	cmp r0, #0
	beq _0215F604
	ldr r0, [r0, #0x124]
	add r0, r0, #0x100
	ldrsh r0, [r0, #0xca]
	add r0, r6, r0
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
_0215F604:
	ldr r1, [r7, #0x30]
	mov r0, r6, lsl #0x10
	str r1, [sp, #0x10]
	ldr r3, [r7, #0x34]
	ldr r2, [r7, #0]
	ldr r6, [r7, #8]
	add r2, r3, r2
	add r2, r6, r2
	str r2, [sp, #0x14]
	ldr r3, [r7, #0x38]
	mov r0, r0, lsr #0x10
	str r3, [sp, #0x18]
	mov r0, r0, asr #4
	ldr r9, [r7, #0x28]
	ldr r6, [r7, #0]
	mov ip, r0, lsl #1
	add r0, r9, r6
	ldr r10, [r7, #0x10]
	mov r6, ip, lsl #1
	add r0, r10, r0
	str r0, [sp, #8]
	ldr r0, _0215F72C // =FX_SinCosTable_
	ldr r10, [r7, #0x18]
	ldr r9, [r7, #0x20]
	ldrsh lr, [r0, r6]
	add r6, ip, #1
	add r9, r10, r9
	smull ip, r10, r9, lr
	adds ip, ip, #0x800
	adc r9, r10, #0
	mov r10, ip, lsr #0xc
	orr r10, r10, r9, lsl #20
	str r10, [sp, #4]
	mov r6, r6, lsl #1
	ldrsh r6, [r0, r6]
	ldr lr, [r7, #0x18]
	ldr ip, [r7, #0x20]
	mov r0, r8
	add ip, lr, ip
	smull lr, r6, ip, r6
	adds ip, lr, #0x800
	adc r6, r6, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r6, lsl #20
	str ip, [sp, #0xc]
	bl BossArena__SetTracker1TargetPos
	ldr r1, [sp, #4]
	ldr r2, [sp, #8]
	ldr r3, [sp, #0xc]
	mov r0, r8
	bl BossArena__SetTracker0TargetPos
	ldr r0, _0215F730 // =shipShiftUnknown
	ldrb r6, [r0, r4, lsr #16]
	bl GetScreenShakeOffsetX
	mov r4, r0
	bl GetScreenShakeOffsetY
	mov r2, r0, asr r6
	mov r1, r4, asr r6
	mov r0, r8
	mov r3, #0
	bl BossArena__SetNextPos
	ldr r0, [r5, #0x24]
	tst r0, #1
	addne sp, sp, #0x1c
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r1, [r7, #0x3c]
	cmp r1, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, r7
	blx r1
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0215F728: .word g_obj
_0215F72C: .word FX_SinCosTable_
_0215F730: .word shipShiftUnknown
	arm_func_end SailCamera__Main

	arm_func_start SailCamera__State_JetHover
SailCamera__State_JetHover: // 0x0215F734
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r2, [r0, #0x70]
	cmp r2, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r2, #0x1c]
	tst r0, #0x10
	beq _0215F818
	ldr r1, [r2, #0x9c]
	mvn r0, #0x7f
	cmp r1, r0
	bge _0215F7A0
	mov r0, #0x1000
	str r0, [r4, #4]
	ldr r2, [r2, #0x48]
	sub r0, r0, #0x3800
	cmp r2, r0
	bge _0215F790
	ldr r1, [r4, #4]
	add r0, r2, #0x2800
	sub r0, r1, r0
	str r0, [r4, #4]
_0215F790:
	mov r0, #0xb00
	rsb r0, r0, #0
	str r0, [r4, #0x14]
	b _0215F80C
_0215F7A0:
	cmp r1, #0x80
	bge _0215F7DC
	mov r0, #0x1800
	str r0, [r4, #4]
	ldr r2, [r2, #0x48]
	sub r0, r0, #0x4000
	cmp r2, r0
	bge _0215F7D0
	ldr r1, [r4, #4]
	add r0, r2, #0x2800
	sub r0, r1, r0
	str r0, [r4, #4]
_0215F7D0:
	mov r0, #0
	str r0, [r4, #0x14]
	b _0215F80C
_0215F7DC:
	mov r0, #0
	str r0, [r4, #4]
	ldr r2, [r2, #0x48]
	sub r0, r0, #0x2800
	cmp r2, r0
	bge _0215F804
	ldr r1, [r4, #4]
	add r0, r2, #0x2800
	sub r0, r1, r0
	str r0, [r4, #4]
_0215F804:
	mov r0, #0x2000
	str r0, [r4, #0x14]
_0215F80C:
	mov r0, #0x8000
	str r0, [r4, #0x1c]
	ldmia sp!, {r4, pc}
_0215F818:
	ldr r0, [r2, #0x24]
	tst r0, #1
	beq _0215F844
	mov r0, #0x400
	rsb r0, r0, #0
	str r0, [r4, #4]
	mov r0, #0x7000
	str r0, [r4, #0x1c]
	mov r0, #0
	str r0, [r4, #0x14]
	ldmia sp!, {r4, pc}
_0215F844:
	mov r0, #0
	str r0, [r4, #0x14]
	str r0, [r4, #4]
	mov r0, #0x8000
	str r0, [r4, #0x1c]
	ldmia sp!, {r4, pc}
	arm_func_end SailCamera__State_JetHover

	arm_func_start SailCamera__State_Boat
SailCamera__State_Boat: // 0x0215F85C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r0, #0x124]
	mov r2, #0
	add r1, r0, #0x100
	ldrsh lr, [r1, #0xca]
	mov r1, #0x7000
	cmp lr, #0
	rsblt lr, lr, #0
	umull ip, r3, lr, r1
	mla r3, lr, r2, r3
	mov r2, lr, asr #0x1f
	mla r3, r2, r1, r3
	adds ip, ip, #0x800
	adc r1, r3, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	rsb r1, r2, #0x30000
	str r1, [r4, #0x1c]
	add r1, r0, #0x100
	ldrsh lr, [r1, #0xca]
	mov r1, #0x300
	rsb r1, r1, #0
	cmp lr, #0
	rsblt lr, lr, #0
	umull ip, r3, lr, r1
	mvn r2, #0
	mla r3, lr, r2, r3
	mov r2, lr, asr #0x1f
	mla r3, r2, r1, r3
	adds ip, ip, #0x800
	adc r1, r3, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	rsb r1, r2, #0
	str r1, [r4, #0x14]
	add r0, r0, #0x100
	ldrsh ip, [r0, #0xca]
	mov r0, #0xd00
	rsb r0, r0, #0
	cmp ip, #0
	rsblt ip, ip, #0
	umull r3, r2, ip, r0
	mvn r1, #0
	mla r2, ip, r1, r2
	mov r1, ip, asr #0x1f
	mla r2, r1, r0, r2
	adds r3, r3, #0x800
	adc r0, r2, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	rsb r0, r1, #0
	str r0, [r4, #0xc]
	ldmia sp!, {r4, pc}
	arm_func_end SailCamera__State_Boat