	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start CPPHelpers__InitSystem
CPPHelpers__InitSystem: // 0x02085D08
	stmdb sp!, {r3, lr}
	bl CPPHelpers__Func_2085D2C
	bl CPPHelpers__Func_2085EE4
	bl CPPHelpers__Func_2085E3C
	bl CPPHelpers__Func_2085D30
	bl CPPHelpers__Func_2085D28
	bl CPPHelpers__Func_2085EE0
	ldmia sp!, {r3, pc}
	arm_func_end CPPHelpers__InitSystem

	arm_func_start CPPHelpers__Func_2085D28
CPPHelpers__Func_2085D28: // 0x02085D28
	bx lr
	arm_func_end CPPHelpers__Func_2085D28

	arm_func_start CPPHelpers__Func_2085D2C
CPPHelpers__Func_2085D2C: // 0x02085D2C
	bx lr
	arm_func_end CPPHelpers__Func_2085D2C

	arm_func_start CPPHelpers__Func_2085D30
CPPHelpers__Func_2085D30: // 0x02085D30
	bx lr
	arm_func_end CPPHelpers__Func_2085D30

	arm_func_start CPPHelpers__AllocMain1
CPPHelpers__AllocMain1: // 0x02085D34
	ldr ip, _02085D3C // =_AllocHeadHEAP_SYSTEM
	bx ip
	.align 2, 0
_02085D3C: .word _AllocHeadHEAP_SYSTEM
	arm_func_end CPPHelpers__AllocMain1

	arm_func_start CPPHelpers__Alloc
CPPHelpers__Alloc: // 0x02085D40
	mov r0, r1
	bx lr
	arm_func_end CPPHelpers__Alloc

	arm_func_start CPPHelpers__Free
CPPHelpers__Free: // 0x02085D48
	stmdb sp!, {r3, lr}
	ldr r1, _02085E1C // =heapSystem_StartAddr
	ldr r1, [r1, #0]
	cmp r0, r1
	blo _02085D70
	ldr r1, _02085E20 // =heapSystem_EndAddr
	ldr r1, [r1, #0]
	cmp r0, r1
	movlo r1, #0
	blo _02085DE0
_02085D70:
	ldr r1, _02085E24 // =heapUser_StartAddr
	ldr r1, [r1, #0]
	cmp r0, r1
	blo _02085D94
	ldr r1, _02085E28 // =heapUser_EndAddr
	ldr r1, [r1, #0]
	cmp r0, r1
	movlo r1, #1
	blo _02085DE0
_02085D94:
	ldr r1, _02085E2C // =heapDTCM_StartAddr
	ldr r1, [r1, #0]
	cmp r0, r1
	blo _02085DB8
	ldr r1, _02085E30 // =heapDTCM_EndAddr
	ldr r1, [r1, #0]
	cmp r0, r1
	movlo r1, #3
	blo _02085DE0
_02085DB8:
	ldr r1, _02085E34 // =heapITCM_StartAddr
	ldr r1, [r1, #0]
	cmp r0, r1
	blo _02085DDC
	ldr r1, _02085E38 // =heapITCM_EndAddr
	ldr r1, [r1, #0]
	cmp r0, r1
	movlo r1, #2
	blo _02085DE0
_02085DDC:
	mov r1, #0
_02085DE0:
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	ldmia sp!, {r3, pc}
_02085DEC: // jump table
	b _02085DFC // case 0
	b _02085E04 // case 1
	b _02085E14 // case 2
	b _02085E0C // case 3
_02085DFC:
	bl _FreeHEAP_SYSTEM
	ldmia sp!, {r3, pc}
_02085E04:
	bl _FreeHEAP_USER
	ldmia sp!, {r3, pc}
_02085E0C:
	bl _FreeHEAP_DTCM
	ldmia sp!, {r3, pc}
_02085E14:
	bl _FreeHEAP_ITCM
	ldmia sp!, {r3, pc}
	.align 2, 0
_02085E1C: .word heapSystem_StartAddr
_02085E20: .word heapSystem_EndAddr
_02085E24: .word heapUser_StartAddr
_02085E28: .word heapUser_EndAddr
_02085E2C: .word heapDTCM_StartAddr
_02085E30: .word heapDTCM_EndAddr
_02085E34: .word heapITCM_StartAddr
_02085E38: .word heapITCM_EndAddr
	arm_func_end CPPHelpers__Free

	arm_func_start CPPHelpers__Func_2085E3C
CPPHelpers__Func_2085E3C: // 0x02085E3C
	bx lr
	arm_func_end CPPHelpers__Func_2085E3C

	arm_func_start CPPHelpers__Func_2085E40
CPPHelpers__Func_2085E40: // 0x02085E40
	bx lr
	arm_func_end CPPHelpers__Func_2085E40

	arm_func_start CPPHelpers__MtxRotY33
CPPHelpers__MtxRotY33: // 0x02085E44
	stmdb sp!, {r4, r5, r6, lr}
	ldr r5, [r2, #0]
	ldr r4, [r1, #0]
	mov r6, r0
	bl CPPHelpers__Func_2085E6C
	mov r1, r4
	mov r2, r5
	bl MTX_RotY33_
	mov r0, r6
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end CPPHelpers__MtxRotY33

	arm_func_start CPPHelpers__Func_2085E6C
CPPHelpers__Func_2085E6C: // 0x02085E6C
	bx lr
	arm_func_end CPPHelpers__Func_2085E6C

	arm_func_start CPPHelpers__Func_2085E70
CPPHelpers__Func_2085E70: // 0x02085E70
	bx lr
	arm_func_end CPPHelpers__Func_2085E70

	arm_func_start CPPHelpers__Func_2085E74
CPPHelpers__Func_2085E74: // 0x02085E74
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mov r6, r0
	bl CPPHelpers__Func_2085F98
	mov r4, r0
	mov r0, r5
	bl CPPHelpers__Func_2085E70
	mov r1, r0
	mov r0, r4
	bl CPPHelpers__VEC_MultiplyMtx33
	mov r0, r6
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end CPPHelpers__Func_2085E74

	arm_func_start CPPHelpers__MtxCopy33To43
CPPHelpers__MtxCopy33To43: // 0x02085EA4
	ldr ip, _02085EAC // =MTX_Copy33To43_
	bx ip
	.align 2, 0
_02085EAC: .word MTX_Copy33To43_
	arm_func_end CPPHelpers__MtxCopy33To43

	arm_func_start CPPHelpers__VEC_MultiplyMtx33
CPPHelpers__VEC_MultiplyMtx33: // 0x02085EB0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x30
	mov r4, r0
	mov r0, r1
	add r1, sp, #0
	bl CPPHelpers__MtxCopy33To43
	add r1, sp, #0
	mov r0, r4
	mov r2, r4
	bl MTX_MultVec43
	add sp, sp, #0x30
	ldmia sp!, {r4, pc}
	arm_func_end CPPHelpers__VEC_MultiplyMtx33

	arm_func_start CPPHelpers__Func_2085EE0
CPPHelpers__Func_2085EE0: // 0x02085EE0
	bx lr
	arm_func_end CPPHelpers__Func_2085EE0

	arm_func_start CPPHelpers__Func_2085EE4
CPPHelpers__Func_2085EE4: // 0x02085EE4
	bx lr
	arm_func_end CPPHelpers__Func_2085EE4

	arm_func_start CPPHelpers__Func_2085EE8
CPPHelpers__Func_2085EE8: // 0x02085EE8
	bx lr
	arm_func_end CPPHelpers__Func_2085EE8

	arm_func_start CPPHelpers__Func_2085EEC
CPPHelpers__Func_2085EEC: // 0x02085EEC
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r1
	mov r7, r0
	mov r5, r2
	mov r4, r3
	bl CPPHelpers__Func_2085FA0
	str r6, [r0]
	str r5, [r0, #4]
	str r4, [r0, #8]
	mov r0, r7
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end CPPHelpers__Func_2085EEC

	arm_func_start CPPHelpers__Func_2085F18
CPPHelpers__Func_2085F18: // 0x02085F18
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldmia r1, {r4, r5, r6}
	mov r7, r0
	bl CPPHelpers__Func_2085FA0
	stmia r0, {r4, r5, r6}
	mov r0, r7
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end CPPHelpers__Func_2085F18

	arm_func_start CPPHelpers__Func_2085F34
CPPHelpers__Func_2085F34: // 0x02085F34
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldmia r1, {r4, r5, r6}
	mov r7, r0
	bl CPPHelpers__Func_2085FA0
	stmia r0, {r4, r5, r6}
	mov r0, r7
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end CPPHelpers__Func_2085F34

	arm_func_start CPPHelpers__VEC_Normalize
CPPHelpers__VEC_Normalize: // 0x02085F50
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl CPPHelpers__Func_2085FA0
	mov r4, r0
	mov r0, r5
	bl CPPHelpers__Func_2085FA0
	mov r1, r0
	mov r0, r4
	bl VEC_Normalize
	mov r0, r5
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end CPPHelpers__VEC_Normalize

	arm_func_start CPPHelpers__VEC_Magnitude
CPPHelpers__VEC_Magnitude: // 0x02085F7C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, r1
	bl CPPHelpers__Func_2085FA4
	bl VEC_Mag
	str r0, [r4]
	ldmia sp!, {r4, pc}
	arm_func_end CPPHelpers__VEC_Magnitude

	arm_func_start CPPHelpers__Func_2085F98
CPPHelpers__Func_2085F98: // 0x02085F98
	bx lr
	arm_func_end CPPHelpers__Func_2085F98

	arm_func_start CPPHelpers__Func_2085F9C
CPPHelpers__Func_2085F9C: // 0x02085F9C
	bx lr
	arm_func_end CPPHelpers__Func_2085F9C

	arm_func_start CPPHelpers__Func_2085FA0
CPPHelpers__Func_2085FA0: // 0x02085FA0
	bx lr
	arm_func_end CPPHelpers__Func_2085FA0

	arm_func_start CPPHelpers__Func_2085FA4
CPPHelpers__Func_2085FA4: // 0x02085FA4
	bx lr
	arm_func_end CPPHelpers__Func_2085FA4

	arm_func_start CPPHelpers__Func_2085FA8
CPPHelpers__Func_2085FA8: // 0x02085FA8
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mov r6, r0
	bl CPPHelpers__Func_2085F98
	mov r4, r0
	mov r0, r5
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	mov r0, r4
	bl CPPHelpers__VEC_Copy
	mov r0, r6
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end CPPHelpers__Func_2085FA8

	arm_func_start CPPHelpers__VEC_Copy_Alt
CPPHelpers__VEC_Copy_Alt: // 0x02085FD8
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r1
	mov r5, r0
	bl CPPHelpers__Func_2085F98
	mov r1, r4
	bl CPPHelpers__VEC_Copy
	mov r0, r5
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end CPPHelpers__VEC_Copy_Alt

	arm_func_start CPPHelpers__VEC_Add_Alt
CPPHelpers__VEC_Add_Alt: // 0x02085FF8
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mov r6, r0
	bl CPPHelpers__Func_2085F98
	mov r4, r0
	mov r0, r5
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	mov r0, r4
	bl CPPHelpers__VEC_Add
	mov r0, r6
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end CPPHelpers__VEC_Add_Alt

	arm_func_start CPPHelpers__VEC_Multiply_Alt
CPPHelpers__VEC_Multiply_Alt: // 0x02086028
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r1
	mov r5, r0
	bl CPPHelpers__Func_2085F98
	mov r1, r4
	bl CPPHelpers__VEC_Multiply
	mov r0, r5
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end CPPHelpers__VEC_Multiply_Alt

	arm_func_start CPPHelpers__VEC_Add_Alt2
CPPHelpers__VEC_Add_Alt2: // 0x02086048
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r2
	bl CPPHelpers__Func_2085F18
	mov r0, r5
	bl CPPHelpers__Func_2085F98
	mov r1, r4
	bl CPPHelpers__VEC_Add
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end CPPHelpers__VEC_Add_Alt2

	arm_func_start CPPHelpers__VEC_Subtract_Alt
CPPHelpers__VEC_Subtract_Alt: // 0x0208606C
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	mov r5, r2
	bl CPPHelpers__Func_2085F18
	mov r0, r4
	bl CPPHelpers__Func_2085F98
	mov r4, r0
	mov r0, r5
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	mov r0, r4
	bl CPPHelpers__VEC_Subtract
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end CPPHelpers__VEC_Subtract_Alt

	arm_func_start CPPHelpers__VEC_Copy
CPPHelpers__VEC_Copy: // 0x020860A0
	ldmia r1, {r1, r2, r3}
	stmia r0, {r1, r2, r3}
	bx lr
	arm_func_end CPPHelpers__VEC_Copy

	arm_func_start CPPHelpers__VEC_Add
CPPHelpers__VEC_Add: // 0x020860AC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r2, r4
	bl VEC_Add
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end CPPHelpers__VEC_Add

	arm_func_start CPPHelpers__VEC_Subtract
CPPHelpers__VEC_Subtract: // 0x020860C4
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r2, r4
	bl VEC_Subtract
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end CPPHelpers__VEC_Subtract

	arm_func_start CPPHelpers__VEC_Multiply
CPPHelpers__VEC_Multiply: // 0x020860DC
	ldr r2, [r0, #0]
	smull ip, r3, r2, r1
	adds ip, ip, #0x800
	adc r2, r3, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [r0]
	ldr r2, [r0, #4]
	smull ip, r3, r2, r1
	adds ip, ip, #0x800
	adc r2, r3, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [r0, #4]
	ldr r2, [r0, #8]
	smull r3, r1, r2, r1
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #8]
	bx lr
	arm_func_end CPPHelpers__VEC_Multiply