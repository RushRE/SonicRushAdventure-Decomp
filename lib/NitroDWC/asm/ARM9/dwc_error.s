	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWCi_SetError
DWCi_SetError: // 0x0208EC9C
	ldr r3, _0208ECB8 // =0x021439E0
	ldr r2, [r3, #0]
	cmp r2, #9
	ldrne r2, _0208ECBC // =0x021439E4
	strne r0, [r3]
	strne r1, [r2]
	bx lr
	.align 2, 0
_0208ECB8: .word 0x021439E0
_0208ECBC: .word 0x021439E4
	arm_func_end DWCi_SetError

	arm_func_start DWCi_IsError
DWCi_IsError: // 0x0208ECC0
	ldr r0, _0208ECD8 // =0x021439E0
	ldr r0, [r0, #0]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_0208ECD8: .word 0x021439E0
	arm_func_end DWCi_IsError

	arm_func_start DWC_ClearError
DWC_ClearError: // 0x0208ECDC
	ldr r1, _0208ECFC // =0x021439E0
	ldr r0, [r1, #0]
	cmp r0, #9
	movne r2, #0
	ldrne r0, _0208ED00 // =0x021439E4
	strne r2, [r1]
	strne r2, [r0]
	bx lr
	.align 2, 0
_0208ECFC: .word 0x021439E0
_0208ED00: .word 0x021439E4
	arm_func_end DWC_ClearError

	arm_func_start DWC_GetLastErrorEx
DWC_GetLastErrorEx: // 0x0208ED04
	cmp r0, #0
	ldrne r2, _0208EDEC // =0x021439E4
	ldrne r2, [r2, #0]
	strne r2, [r0]
	cmp r1, #0
	beq _0208EDE0
	ldr r0, _0208EDF0 // =0x021439E0
	ldr r0, [r0, #0]
	cmp r0, #0x11
	addls pc, pc, r0, lsl #2
	b _0208EDD8
_0208ED30: // jump table
	b _0208EDD8 // case 0
	b _0208EDA8 // case 1
	b _0208ED78 // case 2
	b _0208ED78 // case 3
	b _0208ED78 // case 4
	b _0208ED78 // case 5
	b _0208ED84 // case 6
	b _0208ED90 // case 7
	b _0208ED78 // case 8
	b _0208EDA8 // case 9
	b _0208ED9C // case 10
	b _0208ED9C // case 11
	b _0208ED9C // case 12
	b _0208ED9C // case 13
	b _0208EDB4 // case 14
	b _0208EDC0 // case 15
	b _0208EDCC // case 16
	b _0208EDC0 // case 17
_0208ED78:
	mov r0, #6
	str r0, [r1]
	b _0208EDE0
_0208ED84:
	mov r0, #3
	str r0, [r1]
	b _0208EDE0
_0208ED90:
	mov r0, #4
	str r0, [r1]
	b _0208EDE0
_0208ED9C:
	mov r0, #1
	str r0, [r1]
	b _0208EDE0
_0208EDA8:
	mov r0, #7
	str r0, [r1]
	b _0208EDE0
_0208EDB4:
	mov r0, #5
	str r0, [r1]
	b _0208EDE0
_0208EDC0:
	mov r0, #6
	str r0, [r1]
	b _0208EDE0
_0208EDCC:
	mov r0, #2
	str r0, [r1]
	b _0208EDE0
_0208EDD8:
	mov r0, #0
	str r0, [r1]
_0208EDE0:
	ldr r0, _0208EDF0 // =0x021439E0
	ldr r0, [r0, #0]
	bx lr
	.align 2, 0
_0208EDEC: .word 0x021439E4
_0208EDF0: .word 0x021439E0
	arm_func_end DWC_GetLastErrorEx

	arm_func_start DWC_GetLastError
DWC_GetLastError: // 0x0208EDF4
	cmp r0, #0
	ldrne r1, _0208EE10 // =0x021439E4
	ldrne r1, [r1, #0]
	strne r1, [r0]
	ldr r0, _0208EE14 // =0x021439E0
	ldr r0, [r0, #0]
	bx lr
	.align 2, 0
_0208EE10: .word 0x021439E4
_0208EE14: .word 0x021439E0
	arm_func_end DWC_GetLastError
