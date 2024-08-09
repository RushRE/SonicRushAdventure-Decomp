	.include "asm/macros.inc"
	.include "global.inc"

	.bss

mdlUnknownList: // 0x02134048
	.space 0x10 * 16

mdlUnknownCount: // 0x02134148
	.space 0x02
	.align 4

	.text

	arm_func_start BossHelpers__Unknown2038AEC__Init
BossHelpers__Unknown2038AEC__Init: // 0x02038AEC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r1, r6
	mov r0, #0
	mov r2, #0x14
	bl MIi_CpuClear16
	str r5, [r6]
	str r5, [r6, #4]
	str r4, [r6, #0xc]
	ldrh r0, [r5]
	strh r0, [r6, #0x10]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end BossHelpers__Unknown2038AEC__Init

	arm_func_start BossHelpers__Unknown2038AEC__Func_2038B24
BossHelpers__Unknown2038AEC__Func_2038B24: // 0x02038B24
	bx lr
	arm_func_end BossHelpers__Unknown2038AEC__Func_2038B24

	arm_func_start BossHelpers__Unknown2038AEC__Func_2038B28
BossHelpers__Unknown2038AEC__Func_2038B28: // 0x02038B28
	ldrh r2, [r0, #0x10]
	ldr r1, _02038B78 // =0x0000FFFF
	cmp r2, r1
	moveq r0, #2
	bxeq lr
	cmp r2, #0
	subne r1, r2, #1
	strneh r1, [r0, #0x10]
	movne r0, #0
	bxne lr
	ldr r1, [r0, #4]
	str r1, [r0, #8]
	ldr r2, [r0, #4]
	ldr r1, [r0, #0xc]
	add r1, r2, r1
	str r1, [r0, #4]
	ldrh r1, [r1]
	strh r1, [r0, #0x10]
	mov r0, #1
	bx lr
	.align 2, 0
_02038B78: .word 0x0000FFFF
	arm_func_end BossHelpers__Unknown2038AEC__Func_2038B28

	arm_func_start BossHelpers__Unknown2038AEC__Func_2038B7C
BossHelpers__Unknown2038AEC__Func_2038B7C: // 0x02038B7C
	ldr r0, [r0, #8]
	bx lr
	arm_func_end BossHelpers__Unknown2038AEC__Func_2038B7C

	arm_func_start BossHelpers__Palette__Func_2038B84
BossHelpers__Palette__Func_2038B84: // 0x02038B84
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r2
	bl SetPaletteAnimation
	ldrh r0, [r5]
	cmp r4, #0
	orrne r0, r0, #2
	biceq r0, r0, #2
	strh r0, [r5]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BossHelpers__Palette__Func_2038B84

	arm_func_start BossHelpers__Palette__Func_2038BAC
BossHelpers__Palette__Func_2038BAC: // 0x02038BAC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	movs r7, r1
	mov r8, r0
	mov r6, r2
	mov r5, r3
	mov r4, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
_02038BC8:
	mov r1, r6
	mov r2, r5
	add r0, r8, r4, lsl #5
	bl BossHelpers__Palette__Func_2038B84
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	cmp r7, r0, lsr #16
	mov r4, r0, lsr #0x10
	bhi _02038BC8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end BossHelpers__Palette__Func_2038BAC

	arm_func_start BossHelpers__Animation__Func_2038BF0
BossHelpers__Animation__Func_2038BF0: // 0x02038BF0
	stmdb sp!, {r3, r4, r5, lr}
	ldr ip, [sp, #0x10]
	mov r5, r0
	mov r4, r1
	str ip, [sp]
	bl AnimatorMDL__SetAnimation
	ldr r0, [sp, #0x14]
	add r2, r5, #0x10c
	cmp r0, #0
	moveq r1, r4, lsl #1
	ldreqh r0, [r2, r1]
	biceq r0, r0, #2
	beq _02038C30
	mov r1, r4, lsl #1
	ldrh r0, [r2, r1]
	orr r0, r0, #2
_02038C30:
	strh r0, [r2, r1]
	add r0, r5, r4, lsl #2
	mov r1, #0x1000
	str r1, [r0, #0x11c]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BossHelpers__Animation__Func_2038BF0

	arm_func_start BossHelpers__Animation__Func_2038C44
BossHelpers__Animation__Func_2038C44: // 0x02038C44
	add r0, r0, r1, lsl #1
	add r0, r0, #0x100
	ldrh r0, [r0, #0xc]
	and r0, r0, #0x8000
	bx lr
	arm_func_end BossHelpers__Animation__Func_2038C44

	arm_func_start BossHelpers__Animation__Func_2038C58
BossHelpers__Animation__Func_2038C58: // 0x02038C58
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #0x15c]
	cmp r0, #0
	beq _02038C78
	bl ObjDataRelease
	mov r0, #0
	str r0, [r6, #0x15c]
_02038C78:
	mov r5, #0
	mov r4, r5
_02038C80:
	add r0, r6, r5, lsl #2
	ldr r0, [r0, #0x160]
	cmp r0, #0
	beq _02038C9C
	bl ObjDataRelease
	add r0, r6, r5, lsl #2
	str r4, [r0, #0x160]
_02038C9C:
	add r5, r5, #1
	cmp r5, #5
	blt _02038C80
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end BossHelpers__Animation__Func_2038C58

	arm_func_start BossHelpers__Arena__WrapBounds
BossHelpers__Arena__WrapBounds: // 0x02038CAC
	sub r3, r2, r1
	b _02038CC8
_02038CB4:
	cmp r1, r0
	addgt r0, r0, r3
	bgt _02038CC8
	cmp r2, r0
	suble r0, r0, r3
_02038CC8:
	cmp r1, r0
	bgt _02038CB4
	cmp r0, r2
	bge _02038CB4
	bx lr
	arm_func_end BossHelpers__Arena__WrapBounds

	arm_func_start BossHelpers__Arena__Func_2038CDC
BossHelpers__Arena__Func_2038CDC: // 0x02038CDC
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	mov r6, r1
	mov r4, r2
	mov r5, r3
	bl BossHelpers__Arena__WrapBounds
	sub r0, r7, r6
	sub r1, r4, r6
	bl FX_Div
	mov r0, r0, lsl #0x14
	mov r4, r0, lsr #0x10
	ldr r2, [sp, #0x18]
	ldr r3, [sp, #0x1c]
	mov r0, r4
	mov r1, r5
	bl BossHelpers__Arena__Func_2038D24
	mov r0, r4
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end BossHelpers__Arena__Func_2038CDC

	arm_func_start BossHelpers__Arena__Func_2038D24
BossHelpers__Arena__Func_2038D24: // 0x02038D24
	stmdb sp!, {r4, lr}
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r4, r0, lsl #1
	add r0, r4, #1
	ldr lr, _02038D84 // =FX_SinCosTable_
	mov ip, r4, lsl #1
	mov r0, r0, lsl #1
	ldrsh ip, [lr, ip]
	ldrsh r0, [lr, r0]
	smull ip, lr, r1, ip
	adds r4, ip, #0x800
	smull ip, r0, r1, r0
	adc lr, lr, #0
	adds r1, ip, #0x800
	mov r4, r4, lsr #0xc
	orr r4, r4, lr, lsl #20
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	str r4, [r2]
	orr r1, r1, r0, lsl #20
	str r1, [r3]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02038D84: .word FX_SinCosTable_
	arm_func_end BossHelpers__Arena__Func_2038D24

	arm_func_start BossHelpers__Arena__Func_2038D88
BossHelpers__Arena__Func_2038D88: // 0x02038D88
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	mov r4, r1
	ldr r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	mov r6, r2
	bl BossHelpers__Arena__ATan2
	sub r1, r6, r4
	mov r0, r0, asr #4
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r4, r1
	str r0, [r5]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end BossHelpers__Arena__Func_2038D88

	arm_func_start BossHelpers__Arena__Func_2038DCC
BossHelpers__Arena__Func_2038DCC: // 0x02038DCC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r1
	mov r4, r2
	bl BossHelpers__Arena__WrapBounds
	sub r0, r0, r5
	sub r1, r4, r5
	bl FX_Div
	mov r0, r0, lsl #0x14
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BossHelpers__Arena__Func_2038DCC

	arm_func_start BossHelpers__Arena__ATan2
BossHelpers__Arena__ATan2: // 0x02038DF4
	ldr ip, _02038DFC // =FX_Atan2Idx
	bx ip
	.align 2, 0
_02038DFC: .word FX_Atan2Idx
	arm_func_end BossHelpers__Arena__ATan2

	arm_func_start BossHelpers__Arena__Func_2038E00
BossHelpers__Arena__Func_2038E00: // 0x02038E00
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r6, r0
	mov r7, r2
	mov r4, r3
	mov r5, r1
	ldr r0, [r6, #0x44]
	mov r1, r7
	mov r2, r4
	bl BossHelpers__Arena__WrapBounds
	str r0, [r6, #0x44]
	add r0, r5, #0x48
	str r0, [sp]
	add r0, r5, #0x50
	str r0, [sp, #4]
	ldr r0, [r6, #0x44]
	ldr r3, [sp, #0x20]
	mov r1, r7
	mov r2, r4
	bl BossHelpers__Arena__Func_2038CDC
	ldr r1, [r6, #0x48]
	mov r4, r0
	rsb r0, r1, #0
	str r0, [r5, #0x4c]
	ldr r0, [r6, #0x20]
	ldr r2, _02038EB8 // =FX_SinCosTable_
	tst r0, #1
	movne r0, #0xc000
	moveq r0, #0x4000
	add r0, r0, r4
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r5, #0x24
	blx MTX_RotY33_
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02038EB8: .word FX_SinCosTable_
	arm_func_end BossHelpers__Arena__Func_2038E00

	arm_func_start BossHelpers__Arena__Func_2038EBC
BossHelpers__Arena__Func_2038EBC: // 0x02038EBC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r2
	str r3, [sp]
	mov r4, r0
	mov r2, r1
	mov r3, r5
	add r1, r4, #0x168
	bl BossHelpers__Arena__Func_2038E00
	ldr r1, [r4, #0x5d8]
	mov ip, r0
	tst r1, #0x200
	beq _02038F3C
	add r0, r4, #0x180
	add r3, r4, #0x2fc
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r5, r4, #0x18c
	add lr, r4, #0x308
	ldmia r5!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	ldmia r5!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	ldr r1, [r5]
	add r0, r4, #0x1b0
	str r1, [lr]
	add r3, r4, #0x32c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r4, #0x1bc
	add r3, r4, #0x338
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
_02038F3C:
	mov r0, ip
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BossHelpers__Arena__Func_2038EBC

	arm_func_start BossHelpers__Model__InitSystem
BossHelpers__Model__InitSystem: // 0x02038F44
	ldr r0, _02038F54 // =mdlUnknownCount
	mov r1, #0
	strh r1, [r0]
	bx lr
	.align 2, 0
_02038F54: .word mdlUnknownCount
	arm_func_end BossHelpers__Model__InitSystem

	arm_func_start BossHelpers__Model__Init
BossHelpers__Model__Init: // 0x02038F58
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	ldr ip, _02038FA0 // =mdlUnknownCount
	ldr r6, _02038FA4 // =mdlUnknownList
	ldrh r7, [ip]
	mov r5, r0
	mov r4, r2
	add r2, r7, #1
	strh r2, [ip]
	mov sb, r3
	add r8, r6, r7, lsl #4
	bl BossHelpers__Model__FindJointByName
	str r5, [r6, r7, lsl #4]
	strh r0, [r8, #4]
	strh r4, [r8, #6]
	ldr r0, [sp, #0x20]
	str sb, [r8, #8]
	str r0, [r8, #0xc]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_02038FA0: .word mdlUnknownCount
_02038FA4: .word mdlUnknownList
	arm_func_end BossHelpers__Model__Init

	arm_func_start BossHelpers__Model__SetMatrixMode
BossHelpers__Model__SetMatrixMode: // 0x02038FA8
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r1
	mov r5, r0
	mov r3, #2
	add r1, sp, #4
	mov r0, #0x10
	mov r2, #1
	str r3, [sp, #4]
	bl NNS_G3dGeBufferOP_N
	add r1, sp, #0
	mov r0, #0x14
	mov r2, #1
	str r5, [sp]
	bl NNS_G3dGeBufferOP_N
	mov r0, r4
	mov r1, #0
	bl NNS_G3dGetCurrentMtx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BossHelpers__Model__SetMatrixMode

	arm_func_start BossHelpers__Model__RenderCallback
BossHelpers__Model__RenderCallback: // 0x02038FF8
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	ldr r1, _020390A4 // =mdlUnknownCount
	ldr r2, [r0, #4]
	ldrh r5, [r1]
	ldr lr, [r2, #4]
	ldr r3, _020390A8 // =mdlUnknownList
	cmp r5, #0
	mov ip, #0
	bls _02039064
	mvn r2, #0
_02039024:
	ldr r1, [r3, ip, lsl #4]
	add r4, r3, ip, lsl #4
	cmp r1, lr
	bne _02039050
	ldr r1, [r0, #8]
	tst r1, #0x10
	ldrneb r6, [r0, #0xae]
	ldrh r1, [r4, #4]
	moveq r6, r2
	cmp r1, r6
	beq _02039064
_02039050:
	add r1, ip, #1
	mov r1, r1, lsl #0x10
	cmp r5, r1, lsr #16
	mov ip, r1, lsr #0x10
	bhi _02039024
_02039064:
	cmp ip, r5
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r2, [r4, #8]
	cmp r2, #0
	beq _02039084
	ldr r1, [r4, #0xc]
	blx r2
_02039084:
	ldrh r3, [r4, #6]
	add r1, sp, #0
	mov r0, #0x13
	mov r2, #1
	str r3, [sp]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_020390A4: .word mdlUnknownCount
_020390A8: .word mdlUnknownList
	arm_func_end BossHelpers__Model__RenderCallback

	arm_func_start BossHelpers__Collision__Func_20390AC
BossHelpers__Collision__Func_20390AC: // 0x020390AC
	stmdb sp!, {r3, lr}
	mov ip, r0
	ldr r0, [ip, #0x1c]
	cmp r0, #0
	beq _020390F8
	ldr r0, [r0, #0x44]
	sub r0, r1, r0
	mov r0, r0, asr #0xc
	str r0, [ip, #0xc]
	ldr r0, [ip, #0x1c]
	ldr r0, [r0, #0x48]
	sub r0, r2, r0
	mov r0, r0, asr #0xc
	str r0, [ip, #0x10]
	ldr r0, [ip, #0x1c]
	ldr r0, [r0, #0x4c]
	sub r0, r3, r0
	mov r0, r0, asr #0xc
	b _0203910C
_020390F8:
	mov r0, r1, asr #0xc
	str r0, [ip, #0xc]
	mov r0, r2, asr #0xc
	str r0, [ip, #0x10]
	mov r0, r3, asr #0xc
_0203910C:
	str r0, [ip, #0x14]
	ldr r0, [ip, #0x1c]
	mov r1, ip
	bl StageTask__HandleCollider
	ldmia sp!, {r3, pc}
	arm_func_end BossHelpers__Collision__Func_20390AC

	arm_func_start BossHelpers__Collision__Func_2039120
BossHelpers__Collision__Func_2039120: // 0x02039120
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r2
	mov r4, r1
	mov r2, r3
	mov r1, r6
	mov r3, #0
	mov r7, r0
	bl BossHelpers__Collision__Func_20390AC
	mov r5, r4
	ldmia r7!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r7!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldr lr, [sp, #0x18]
	ldr ip, [sp, #0x1c]
	add r0, lr, ip
	cmp r6, r0, asr #1
	ldmia r7!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r7, {r0, r1, r2, r3}
	stmia r5, {r0, r1, r2, r3}
	ldr r1, [r4, #0xc]
	sublt r0, ip, lr
	addlt r0, r1, r0, asr #12
	subge r0, ip, lr
	subge r0, r1, r0, asr #12
	str r0, [r4, #0xc]
	ldr r0, [r4, #0x1c]
	mov r1, r4
	bl StageTask__HandleCollider
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end BossHelpers__Collision__Func_2039120

	arm_func_start BossHelpers__Collision__Func_203919C
BossHelpers__Collision__Func_203919C: // 0x0203919C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x10
	mov r4, r2
	ldr r2, [r4]
	mov r7, r3
	str r2, [sp]
	ldr ip, [r4, #8]
	mov r6, r0
	mov r5, r1
	ldr r2, [sp, #0x28]
	ldr r3, [sp, #0x2c]
	add r0, sp, #0xc
	mov r1, r7
	str ip, [sp, #4]
	bl BossHelpers__Arena__Func_2038D88
	ldr r1, [sp, #0x28]
	str r7, [sp]
	str r1, [sp, #4]
	ldr r0, [sp, #0x2c]
	mov r1, r5
	str r0, [sp, #8]
	ldr r3, [r4, #4]
	ldr r2, [sp, #0xc]
	mov r0, r6
	rsb r3, r3, #0
	bl BossHelpers__Collision__Func_2039120
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end BossHelpers__Collision__Func_203919C

	arm_func_start BossHelpers__Player__IsDead
BossHelpers__Player__IsDead: // 0x0203920C
	add r0, r0, #0x500
	ldrsh r0, [r0, #0xd4]
	cmp r0, #0x10
	cmpne r0, #0x11
	bne _02039228
	mov r0, #0
	bx lr
_02039228:
	mov r0, #1
	bx lr
	arm_func_end BossHelpers__Player__IsDead

	arm_func_start BossHelpers__Player__LockControl
BossHelpers__Player__LockControl: // 0x02039230
	ldr r2, [r0, #0x5d8]
	add r1, r0, #0x700
	orr r2, r2, #0x200000
	str r2, [r0, #0x5d8]
	mov r0, #0
	strh r0, [r1, #0x20]
	strh r0, [r1, #0x22]
	strh r0, [r1, #0x24]
	bx lr
	arm_func_end BossHelpers__Player__LockControl

	arm_func_start BossHelpers__Player__UnlockControl
BossHelpers__Player__UnlockControl: // 0x02039254
	ldr r1, [r0, #0x5d8]
	bic r1, r1, #0x200000
	str r1, [r0, #0x5d8]
	bx lr
	arm_func_end BossHelpers__Player__UnlockControl

	arm_func_start BossHelpers__Math__Func_2039264
BossHelpers__Math__Func_2039264: // 0x02039264
	cmp r0, r1
	bxeq lr
	sub r3, r1, r0
	mov r3, r3, lsl #0x10
	mov r3, r3, asr #0x10
	cmp r3, #0
	ble _0203929C
	cmp r2, r3
	movge r0, r1
	bxge lr
	add r0, r0, r2
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bx lr
_0203929C:
	rsb r3, r3, #0
	cmp r2, r3
	movge r0, r1
	bxge lr
	sub r0, r0, r2
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bx lr
	arm_func_end BossHelpers__Math__Func_2039264

	arm_func_start BossHelpers__Math__Func_20392BC
BossHelpers__Math__Func_20392BC: // 0x020392BC
	stmdb sp!, {r3, lr}
	subs r1, r1, r0
	rsbmi ip, r1, #0
	ldr r0, [sp, #0x10]
	movpl ip, r1
	ldr lr, [sp, #8]
	cmp ip, r0
	bge _0203930C
	cmp r2, #0
	bge _020392F8
	rsb r0, r2, #0
	cmp lr, r0
	addlt r2, r2, lr
	movge r2, #0
	b _02039340
_020392F8:
	ble _02039340
	cmp lr, r2
	sublt r2, r2, lr
	movge r2, #0
	b _02039340
_0203930C:
	cmp r2, #0
	blt _02039320
	cmp r1, #0
	addgt r2, r2, r3
	bgt _02039340
_02039320:
	cmp r2, #0
	bgt _02039334
	cmp r1, #0
	sublt r2, r2, r3
	blt _02039340
_02039334:
	cmp r2, #0
	subgt r2, r2, lr
	addle r2, r2, lr
_02039340:
	ldr r1, [sp, #0xc]
	rsb r0, r1, #0
	cmp r2, r0
	ldmltia sp!, {r3, pc}
	cmp r2, r1
	movle r1, r2
	mov r0, r1
	ldmia sp!, {r3, pc}
	arm_func_end BossHelpers__Math__Func_20392BC

	arm_func_start BossHelpers__Math__Func_2039360
BossHelpers__Math__Func_2039360: // 0x02039360
	stmdb sp!, {r3, lr}
	mov ip, r0, lsl #0x10
	mov r0, r1, lsl #0x10
	mov r1, ip, asr #0x10
	rsb r0, r1, r0, asr #16
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	sub r0, r1, #0x8000
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov ip, r0, lsr #0x10
	ldrh r0, [sp, #0x10]
	movlo ip, r1
	ldr lr, [sp, #8]
	cmp ip, r0
	bhs _020393E8
	cmp r2, #0
	bge _020393C8
	rsb r0, r2, #0
	cmp lr, r0
	movge r2, #0
	bge _02039460
	add r0, r2, lr
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	b _02039460
_020393C8:
	ble _02039460
	cmp lr, r2
	movge r2, #0
	bge _02039460
	sub r0, r2, lr
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	b _02039460
_020393E8:
	cmp r2, #0
	blt _02039408
	cmp r1, #0x8000
	bhs _02039408
	add r0, r2, r3
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	b _02039460
_02039408:
	cmp r2, #0
	bgt _02039428
	cmp r1, #0x8000
	bls _02039428
	sub r0, r2, r3
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	b _02039460
_02039428:
	cmp r2, #0
	ble _02039448
	cmp r1, #0x8000
	bls _02039448
	sub r0, r2, lr
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	b _02039460
_02039448:
	cmp r2, #0
	bge _02039460
	cmp r1, #0x8000
	addlo r0, r2, lr
	movlo r0, r0, lsl #0x10
	movlo r2, r0, asr #0x10
_02039460:
	ldrh r0, [sp, #0xc]
	rsb r1, r0, #0
	cmp r2, r1
	blt _0203947C
	cmp r2, r0
	movle r0, r2
	mov r1, r0
_0203947C:
	mov r0, r1, lsl #0x10
	mov r0, r0, asr #0x10
	ldmia sp!, {r3, pc}
	arm_func_end BossHelpers__Math__Func_2039360

	arm_func_start BossHelpers__Blend__Func_2039488
BossHelpers__Blend__Func_2039488: // 0x02039488
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl Camera3D__GetWork
	mov r1, #0x5c
	mla r1, r4, r1, r0
	mov r2, #0
	bic r0, r2, #1
	orr r0, r0, #1
	strh r0, [r1, #0x20]
	ldrh r0, [r1, #0x20]
	orr r0, r0, #0x200
	strh r0, [r1, #0x20]
	ldrh r0, [r1, #0x20]
	orr r0, r0, #0x400
	strh r0, [r1, #0x20]
	ldrh r0, [r1, #0x20]
	orr r0, r0, #0x800
	strh r0, [r1, #0x20]
	ldrh r0, [r1, #0x20]
	orr r0, r0, #0x1000
	strh r0, [r1, #0x20]
	ldmia sp!, {r4, pc}
	arm_func_end BossHelpers__Blend__Func_2039488

	arm_func_start BossHelpers__Light__Init
BossHelpers__Light__Init: // 0x020394E0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r1, r6
	mov r0, #0
	mov r2, #0x32
	bl MIi_CpuClear16
	mov r5, r6
	mov r4, #0
_02039500:
	bl GetStageDrawState
	mov r1, r5
	mov r2, r4
	bl GetDrawStateLight
	mov r0, r4, lsl #3
	add r2, r6, r4, lsl #3
	add r4, r4, #1
	ldrh r1, [r6, r0]
	ldrh r0, [r2, #2]
	cmp r4, #3
	add r5, r5, #8
	strh r1, [r2, #0x18]
	strh r0, [r2, #0x1a]
	ldrh r1, [r2, #4]
	ldrh r0, [r2, #6]
	strh r1, [r2, #0x1c]
	strh r0, [r2, #0x1e]
	blt _02039500
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end BossHelpers__Light__Init

	arm_func_start BossHelpers__Light__Func_203954C
BossHelpers__Light__Func_203954C: // 0x0203954C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r0
	ldrsh r0, [r4, #0x30]
	cmp r0, #0
	ble _020395A0
	mov r8, r4
	add r7, r4, #0x1e
	mov r6, #0
	mov r5, #1
_02039570:
	ldrsh r3, [r4, #0x30]
	mov r1, r7
	mov r2, r5
	add r0, r8, #6
	and r3, r3, #0xff
	bl Palette__UnknownFunc9
	add r6, r6, #1
	cmp r6, #3
	add r7, r7, #8
	add r8, r8, #8
	blt _02039570
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020395A0:
	bge _020395E8
	mov r7, r4
	add r6, r4, #0x1e
	mov r8, #0
	mov r5, #1
_020395B4:
	ldrsh r0, [r4, #0x30]
	mov r1, r6
	mov r2, r5
	rsb r3, r0, #0
	add r0, r7, #6
	and r3, r3, #0xff
	bl Palette__UnknownFunc10
	add r8, r8, #1
	cmp r8, #3
	add r6, r6, #8
	add r7, r7, #8
	blt _020395B4
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020395E8:
	mov r3, #0
_020395EC:
	mov r0, r3, lsl #3
	add r2, r4, r3, lsl #3
	ldrh r1, [r4, r0]
	ldrh r0, [r2, #2]
	add r3, r3, #1
	cmp r3, #3
	strh r1, [r2, #0x18]
	strh r0, [r2, #0x1a]
	ldrh r1, [r2, #4]
	ldrh r0, [r2, #6]
	strh r1, [r2, #0x1c]
	strh r0, [r2, #0x1e]
	blt _020395EC
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end BossHelpers__Light__Func_203954C

	arm_func_start BossHelpers__Light__SetLights1
BossHelpers__Light__SetLights1: // 0x02039624
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, #0
_02039630:
	mov r0, r4
	mov r1, r5
	bl Camera3D__SetLight
	add r4, r4, #1
	cmp r4, #3
	add r5, r5, #8
	blt _02039630
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BossHelpers__Light__SetLights1

	arm_func_start BossHelpers__Light__SetLights2
BossHelpers__Light__SetLights2: // 0x02039650
	stmdb sp!, {r3, r4, r5, lr}
	add r5, r0, #0x18
	mov r4, #0
_0203965C:
	mov r0, r4
	mov r1, r5
	bl Camera3D__SetLight
	add r4, r4, #1
	cmp r4, #3
	add r5, r5, #8
	blt _0203965C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BossHelpers__Light__SetLights2

	arm_func_start BossHelpers__Model__FindJointByName
BossHelpers__Model__FindJointByName: // 0x0203967C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r5, r0
	mov r4, r1
	add r0, sp, #0
	mov r1, #0
	mov r2, #0x10
	bl MI_CpuFill8
	add r0, sp, #0
	mov r1, r4
	bl STD_CopyString
	add r1, sp, #0
	add r0, r5, #0x40
	bl NNS_G3dGetResDictIdxByName
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BossHelpers__Model__FindJointByName