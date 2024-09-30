	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start MultibootManager__Func_2063C40
MultibootManager__Func_2063C40: // 0x02063C40
	ldr r0, _02063C5C // =gameState
	mov r1, #0
	str r1, [r0, #0xa8]
	str r1, [r0, #0xac]
	strh r1, [r0, #0xb6]
	str r1, [r0, #0xc8]
	bx lr
	.align 2, 0
_02063C5C: .word gameState
	arm_func_end MultibootManager__Func_2063C40

	arm_func_start MultibootManager__Func_2063C60
MultibootManager__Func_2063C60: // 0x02063C60
	stmdb sp!, {r4, lr}
	ldr r1, _02063CE0 // =gameState
	cmp r0, #0x11
	str r0, [r1, #0xc4]
	blt _02063C9C
	mov r2, #0
	sub r0, r0, #7
	mov r3, #1
	str r3, [r1, #0xa4]
	strh r0, [r1, #0xb4]
	str r2, [r1, #0x70]
	str r2, [r1, #0x74]
	str r2, [r1, #0x78]
	str r2, [r1, #0xa0]
	ldmia sp!, {r4, pc}
_02063C9C:
	ldr lr, _02063CE4 // =sailMissionList
	mov r4, r0, lsl #2
	ldr ip, _02063CE8 // =0x0211162D
	ldr r3, _02063CEC // =0x0211162E
	mov r0, #0
	ldr r2, _02063CF0 // =0x0211162F
	ldrsb lr, [lr, r4]
	ldrsb ip, [ip, r4]
	ldrsb r3, [r3, r4]
	ldrsb r2, [r2, r4]
	str lr, [r1, #0x70]
	str ip, [r1, #0x74]
	str r3, [r1, #0x78]
	str r2, [r1, #0xa0]
	str r0, [r1, #0xa4]
	strh r0, [r1, #0xb4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02063CE0: .word gameState
_02063CE4: .word sailMissionList
_02063CE8: .word 0x0211162D
_02063CEC: .word 0x0211162E
_02063CF0: .word 0x0211162F
	arm_func_end MultibootManager__Func_2063C60

	arm_func_start MultibootManager__Func_2063CF4
MultibootManager__Func_2063CF4: // 0x02063CF4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	ldr r6, _02063E2C // =_0211160C
	add r4, sp, #0
	mov r10, r0
	mov r9, r1
	mov r5, r4
	ldmia r6!, {r0, r1, r2, r3}
	mov r8, #0
	stmia r4!, {r0, r1, r2, r3}
	ldmia r6, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	ldr r4, _02063E30 // =0x000036A0
	mov r7, r8
	str r8, [r10]
	mov r11, r8
_02063D34:
	cmp r8, #6
	ldr r6, [r5, r8, lsl #2]
	bne _02063D68
	mov r0, #0
	umull r2, r1, r9, r4
	mla r1, r9, r0, r1
	mov r0, r9, asr #0x1f
	mla r1, r0, r4, r1
	mov r0, #0x800
	adds r2, r2, r0
	adc r0, r1, r11
	mov r9, r2, lsr #0xc
	orr r9, r9, r0, lsl #20
_02063D68:
	cmp r9, r6
	blo _02063D90
	mov r0, r9
	mov r1, r6
	bl FX_DivS32
	mul r1, r0, r6
	ldr r2, [r10, #0]
	sub r9, r9, r1
	orr r0, r2, r0, lsl r7
	str r0, [r10]
_02063D90:
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, asr #0x10
	cmp r8, #7
	add r7, r7, #4
	blt _02063D34
	ldr r1, [r10, #0]
	mov r0, r8, lsl #2
	orr r1, r1, r9, lsl r0
	mov r0, r0, lsl #0x10
	mov r8, r0, asr #0x10
	cmp r8, r8, asr #1
	mov r3, r8
	addlt sp, sp, #0x20
	str r1, [r10]
	mov r2, r8, asr #1
	ldmltia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, #0xf
_02063DD8:
	ldr r9, [r10, #0]
	sub r1, r3, r8
	and r4, r9, r0, lsl r8
	and r6, r9, r0, lsl r1
	mov r7, r0, lsl r8
	mov r5, r4, lsr r8
	orr r4, r7, r0, lsl r1
	mov r6, r6, lsr r1
	mov r1, r5, lsl r1
	mvn r4, r4
	and r7, r9, r4
	orr r1, r1, r6, lsl r8
	sub r4, r8, #4
	mov r4, r4, lsl #0x10
	orr r1, r7, r1
	str r1, [r10]
	cmp r2, r4, asr #16
	mov r8, r4, asr #0x10
	ble _02063DD8
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02063E2C: .word _0211160C
_02063E30: .word 0x000036A0
	arm_func_end MultibootManager__Func_2063CF4

    .rodata

.public _0211160C
_0211160C: // 0x0211160C
    .word 1080000, 108000, 18000, 1800, 300, 30, 10, 1

.public sailMissionList
sailMissionList: // 0x0211162C
    .byte 1, 1, 1, 0    // MissionEntryUnknown
    .byte 1, 1, 0, 0    // MissionEntryUnknown
    .byte 1, 2, 0, 1    // MissionEntryUnknown
    .byte 1, 3, 0, 2    // MissionEntryUnknown
    .byte 1, 4, 0, 3    // MissionEntryUnknown
    .byte 6, 0, 2, 0    // MissionEntryUnknown
    .byte 6, 0, 2, 1    // MissionEntryUnknown
    .byte 6, 0, 2, 2    // MissionEntryUnknown
    .byte 6, 0, 2, 3    // MissionEntryUnknown
    .byte 2, 0x33, 2, 0 // MissionEntryUnknown
    .byte 2, 0x34, 2, 0 // MissionEntryUnknown
    .byte 3, 0x3D, 2, 1 // MissionEntryUnknown
    .byte 3, 0x3E, 2, 1 // MissionEntryUnknown
    .byte 3, 0x47, 2, 2 // MissionEntryUnknown
    .byte 3, 0x48, 2, 2 // MissionEntryUnknown
    .byte 3, 0x51, 2, 3 // MissionEntryUnknown
    .byte 3, 0x52, 2, 3 // MissionEntryUnknown
