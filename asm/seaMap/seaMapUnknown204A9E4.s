	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
.public SeaMapUnknown204A9E4__sVars
SeaMapUnknown204A9E4__sVars: // 0x021341A0
    .space 0x10
	
.public SeaMapUnknown204A9E4__objectList
SeaMapUnknown204A9E4__objectList: // 0x021341B0
    .space 0x01 * 512

.public SeaMapUnknown204A9E4__objectListUnknown
SeaMapUnknown204A9E4__objectListUnknown: // 0x021343B0
    .space 0x01 * 128

	.text

	arm_func_start SeaMapUnknown204A9E4__Func_204A9E4
SeaMapUnknown204A9E4__Func_204A9E4: // 0x0204A9E4
	stmdb sp!, {r3, lr}
	bl SeaMapUnknown204A9E4__InitList
	ldr r0, _0204A9FC // =SeaMapUnknown204A9E4__sVars
	mov r1, #1
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0204A9FC: .word SeaMapUnknown204A9E4__sVars
	arm_func_end SeaMapUnknown204A9E4__Func_204A9E4

	arm_func_start SeaMapUnknown204A9E4__Func_204AA00
SeaMapUnknown204A9E4__Func_204AA00: // 0x0204AA00
	stmdb sp!, {r3, lr}
	mov r1, #0
	mov r2, r1
	mov r0, #8
	bl SeaMapUnknown204A9E4__RunCallbacks
	bl SeaMapUnknown204A9E4__InitList
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapUnknown204A9E4__Func_204AA00

	arm_func_start SeaMapUnknown204A9E4__AddObject
SeaMapUnknown204A9E4__AddObject: // 0x0204AA1C
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, _0204AA60 // =SeaMapUnknown204A9E4__sVars
	mov r4, r0
	ldrh r2, [r2, #0xc]
	ldr r3, _0204AA64 // =SeaMapUnknown204A9E4__objectListUnknown
	ldr r0, _0204AA68 // =SeaMapUnknown204A9E4__sVars+0x00000004
	rsb ip, r2, #0x1f
	ldr r5, [r3, ip, lsl #2]
	mov r6, r1
	mov r2, #0
	mov r1, r5
	str r2, [r3, ip, lsl #2]
	bl NNS_FndAppendListObject
	str r4, [r5, #8]
	mov r0, r5
	str r6, [r5, #0xc]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0204AA60: .word SeaMapUnknown204A9E4__sVars
_0204AA64: .word SeaMapUnknown204A9E4__objectListUnknown
_0204AA68: .word SeaMapUnknown204A9E4__sVars+0x00000004
	arm_func_end SeaMapUnknown204A9E4__AddObject

	arm_func_start SeaMapUnknown204A9E4__RemoveObject
SeaMapUnknown204A9E4__RemoveObject: // 0x0204AA6C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _0204AAA8 // =SeaMapUnknown204A9E4__sVars+0x00000004
	mov r1, r4
	bl NNS_FndRemoveListObject
	ldr r0, _0204AAAC // =SeaMapUnknown204A9E4__sVars
	ldr r3, _0204AAB0 // =SeaMapUnknown204A9E4__objectListUnknown
	ldrh r2, [r0, #0xc]
	mov r1, r4
	mov r0, #0
	rsb ip, r2, #0x1f
	mov r2, #0x10
	str r4, [r3, ip, lsl #2]
	bl MIi_CpuClear16
	ldmia sp!, {r4, pc}
	.align 2, 0
_0204AAA8: .word SeaMapUnknown204A9E4__sVars+0x00000004
_0204AAAC: .word SeaMapUnknown204A9E4__sVars
_0204AAB0: .word SeaMapUnknown204A9E4__objectListUnknown
	arm_func_end SeaMapUnknown204A9E4__RemoveObject

	arm_func_start SeaMapUnknown204A9E4__RunCallbacks
SeaMapUnknown204A9E4__RunCallbacks: // 0x0204AAB4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r3, _0204AB08 // =SeaMapUnknown204A9E4__sVars
	ldr r4, _0204AB0C // =SeaMapUnknown204A9E4__sVars+0x00000004
	ldr r5, [r3, #4]
	mov r8, r0
	mov r7, r1
	mov r6, r2
	cmp r5, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
_0204AAD8:
	ldr r1, [r5, #0xc]
	ldr ip, [r5, #8]
	mov r0, r8
	mov r2, r7
	mov r3, r6
	blx ip
	mov r0, r4
	mov r1, r5
	bl NNS_FndGetNextListObject
	movs r5, r0
	bne _0204AAD8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0204AB08: .word SeaMapUnknown204A9E4__sVars
_0204AB0C: .word SeaMapUnknown204A9E4__sVars+0x00000004
	arm_func_end SeaMapUnknown204A9E4__RunCallbacks

	arm_func_start SeaMapUnknown204A9E4__InitList
SeaMapUnknown204A9E4__InitList: // 0x0204AB10
	stmdb sp!, {r3, lr}
	ldr r0, _0204AB58 // =SeaMapUnknown204A9E4__sVars+0x00000004
	mov r1, #0
	bl NNS_FndInitList
	ldr r3, _0204AB5C // =SeaMapUnknown204A9E4__objectList
	ldr r1, _0204AB58 // =SeaMapUnknown204A9E4__sVars+0x00000004
	mov r2, #0
_0204AB2C:
	add r0, r1, r2, lsl #2
	add r2, r2, #1
	str r3, [r0, #0x20c]
	cmp r2, #0x20
	add r3, r3, #0x10
	blt _0204AB2C
	ldr r1, _0204AB5C // =SeaMapUnknown204A9E4__objectList
	mov r0, #0
	mov r2, #0x200
	bl MIi_CpuClear16
	ldmia sp!, {r3, pc}
	.align 2, 0
_0204AB58: .word SeaMapUnknown204A9E4__sVars+0x00000004
_0204AB5C: .word SeaMapUnknown204A9E4__objectList
	arm_func_end SeaMapUnknown204A9E4__InitList