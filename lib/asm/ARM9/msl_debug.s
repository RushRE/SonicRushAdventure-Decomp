	.include "asm/macros.inc"
	.include "global.inc"

    .text
    
// CUSTOM_SECTION_START: Debug
// adding in some extra funcs not found in the retail release here so the game compiles with debug on!

	arm_func_start __clear
__clear:
	cmp r0, #0
	mov r3, r0
	cmpne r1, #0
	bxeq lr
	mov r2, #0
__clear__loc_14:
	strb r2, [r3], #1
	subs r1, r1, #1
	bne __clear__loc_14
	bx lr
	.align 2, 0
	arm_func_end __clear
	
// CUSTOM_SECTION_END: Debug