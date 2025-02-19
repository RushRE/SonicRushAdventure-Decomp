#include <menu/menuHelpers.h>

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void *ovl03_0217E3AC;
NOT_DECOMPILED void *ovl03_0217E3C8;
NOT_DECOMPILED void *ovl03_0217E41E;
NOT_DECOMPILED void *MenuHelpers__ProgressCheck_Zone;
NOT_DECOMPILED void *MenuHelpers__ProgressCheck_Ex;
NOT_DECOMPILED void *MenuHelpers__ProgressCheck_Zone_Alt;
NOT_DECOMPILED void *MenuHelpers__ProgressCheck_Ex_Alt;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC u16 MenuHelpers__GetStageID(s32 id)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr r1, =ovl03_0217E3C8
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC u16 MenuHelpers__GetProgressFromStageID(s32 id)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr r1, =ovl03_0217E41E
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC u16 MenuHelpers__Func_217CEA8(s32 id)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr r1, =ovl03_0217E3AC
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC s32 MenuHelpers__Func_217CEBC(s32 id)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr r2, =ovl03_0217E3AC
	mov r3, #0
_0217CEC4:
	mov r1, r3, lsl #1
	ldrh r1, [r2, r1]
	cmp r0, r1
	moveq r0, r3
	bxeq lr
	add r3, r3, #1
	cmp r3, #0xe
	blt _0217CEC4
	mov r0, #0xe
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC BOOL MenuHelpers__CheckProgress(s32 progress, BOOL useAltProgressCheck, BOOL useSystemProgress)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r3, r0
	cmp r2, #0
	ldrne r0, =saveGame+0x00000010
	mov r6, r1
	ldreq r0, =saveGame+0x00000028
	cmp r3, #0x18
	ldrb r4, [r0, #4]
	ldrb r5, [r0, #5]
	ldrb r1, [r0, #6]
	bgt _0217CFC4
	cmp r6, #0
	ldrne r2, =MenuHelpers__ProgressCheck_Zone_Alt
	ldreq r2, =MenuHelpers__ProgressCheck_Zone
	add r2, r2, r3, lsl #2
	ldrb lr, [r2]
	cmp r4, lr
	ldrhsb ip, [r2, #1]
	cmphs r5, ip
	ldrhsb r3, [r2, #2]
	cmphs r1, r3
	blo _0217D048
	ldrb r2, [r2, #3]
	cmp r2, #3
	addls pc, pc, r2, lsl #2
	b _0217D048
_0217CF58: // jump table
	b _0217CF68 // case 0
	b _0217CF70 // case 1
	b _0217CF8C // case 2
	b _0217CFA8 // case 3
_0217CF68:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_0217CF70:
	cmp r4, lr
	bhi _0217CF84
	ldr r0, [r0, #0]
	tst r0, #0x100
	beq _0217D048
_0217CF84:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_0217CF8C:
	cmp r5, ip
	bhi _0217CFA0
	ldr r0, [r0, #0]
	tst r0, #0x200
	beq _0217D048
_0217CFA0:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_0217CFA8:
	cmp r1, r3
	bhi _0217CFBC
	ldr r0, [r0, #0]
	tst r0, #0x400
	beq _0217D048
_0217CFBC:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_0217CFC4:
	cmp r3, #0x26
	bgt _0217D004
	sub r1, r3, #0x19
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl SaveGame__GetIslandProgress
	cmp r6, #0
	beq _0217CFF4
	cmp r0, #2
	blt _0217D048
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_0217CFF4:
	cmp r0, #1
	blt _0217D048
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_0217D004:
	cmp r3, #0x2a
	movle r0, #1
	ldmleia sp!, {r4, r5, r6, pc}
	cmp r3, #0x2d
	movle r0, #1
	ldmleia sp!, {r4, r5, r6, pc}
	cmp r6, #0
	ldrne r2, =MenuHelpers__ProgressCheck_Ex_Alt
	ldreq r2, =MenuHelpers__ProgressCheck_Ex
	ldrb r0, [r2, #0]
	cmp r4, r0
	ldrhsb r0, [r2, #1]
	cmphs r5, r0
	ldrhsb r0, [r2, #2]
	cmphs r1, r0
	movhs r0, #1
	ldmhsia sp!, {r4, r5, r6, pc}
_0217D048:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}