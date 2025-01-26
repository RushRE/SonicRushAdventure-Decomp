#include <ex/core/exTutorialMessage.h>
#include <ex/core/exHUD.h>
#include <ex/system/exSystem.h>

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED u16 exMsgTutorial__02175D98[2][6];
NOT_DECOMPILED u16 exMsgTutorial__02175DB0[2][6];

NOT_DECOMPILED void *aExmsgtutorialt;

// --------------------
// FUNCTIONS
// --------------------

// ExTutorialMessage
NONMATCH_FUNC void exMsgTutorialTask__GetLanguage(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0216C598
_0216C550: // jump table
	b _0216C568 // case 0
	b _0216C570 // case 1
	b _0216C578 // case 2
	b _0216C580 // case 3
	b _0216C588 // case 4
	b _0216C590 // case 5
_0216C568:
	mov r0, #0
	b _0216C59C
_0216C570:
	mov r0, #1
	b _0216C59C
_0216C578:
	mov r0, #2
	b _0216C59C
_0216C580:
	mov r0, #3
	b _0216C59C
_0216C588:
	mov r0, #4
	b _0216C59C
_0216C590:
	mov r0, #5
	b _0216C59C
_0216C598:
	mov r0, #1
_0216C59C:
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTutorialTask__Main(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bl GetExTaskWorkCurrent_
	mov r7, r0
	bl GetCurrentTask
	ldr r1, =0x021775B8
	str r0, [r1, #4]
	bl exMsgTutorialTask__GetLanguage
	strh r0, [r7, #4]
	bl exPlayerAdminTask__GetUnknown2
	str r0, [r7, #0x1a0]
	add r0, r7, #0x12
	ldr r11, =exMsgTutorial__02175D98
	mov r8, #0
	add r6, r7, #0x90
	add r5, r7, #0x110
	add r4, r0, #0x100
_0216C5E8:
	mov r0, #0xc
	mla r1, r8, r0, r11
	mov r0, #0x88
	mul r9, r8, r0
	ldrh r2, [r7, #4]
	add r10, r7, r9
	add r0, r6, r9
	mov r2, r2, lsl #1
	ldrh r1, [r2, r1]
	strh r1, [r10, #0x90]
	mov r1, #3
	strh r1, [r10, #0x92]
	bl SetupExHUDSprite
	ldr r1, =0x0000E002
	add r0, r5, r9
	bl exDrawReqTask__SetConfigPriority
	mov r0, #0
	strh r0, [r10, #0xf8]
	strh r0, [r10, #0xfa]
	ldrb r1, [r4, r9]
	add r0, r6, r9
	orr r1, r1, #0x20
	strb r1, [r4, r9]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	add r0, r5, r9
	bl exDrawReqTask__Func_21641F0
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #2
	blo _0216C5E8
	mov r0, #0x4c
	strh r0, [r7, #8]
	mov r1, #3
	add r0, r7, #8
	strh r1, [r7, #0xa]
	bl SetupExHUDSprite
	ldr r1, =0x0000E001
	add r0, r7, #0x88
	bl exDrawReqTask__SetConfigPriority
	mov r0, #0
	strh r0, [r7, #0x70]
	strh r0, [r7, #0x72]
	ldrb r1, [r7, #0x8a]
	add r0, r7, #8
	orr r1, r1, #0x20
	strb r1, [r7, #0x8a]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	add r0, r7, #0x88
	bl exDrawReqTask__Func_21641F0
	mov r0, #5
	str r0, [r7, #0x80]
	mov r0, #0x80
	strh r0, [r7]
	bl GetExTaskCurrent
	ldr r1, =exMsgTutorialTask__Main_Active
	str r1, [r0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTutorialTask__Func8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExSystemFlag_2178650
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTutorialTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x90
	bl ReleaseExHUDSprite
	add r0, r4, #0x118
	bl ReleaseExHUDSprite
	add r0, r4, #8
	bl ReleaseExHUDSprite
	ldr r0, =0x021775B8
	mov r1, #0
	str r1, [r0, #4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTutorialTask__Main_Active(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	bl GetExTaskWorkCurrent_
	mov r8, r0
	ldr r0, [r8, #0x1a0]
	mov r4, #0
	ldrb r0, [r0, #0x6a]
	add r1, r8, #0x90
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	movne r4, #1
	mov r0, #0x88
	mla r0, r4, r0, r1
	bl exDrawReqTask__Sprite2D__Animate
	add r0, r8, #8
	bl exDrawReqTask__Sprite2D__Animate
	ldrh r1, [r8, #4]
	ldr r2, =exMsgTutorial__02175DB0
	mov r0, #0xc
	mla r0, r4, r0, r2
	mov r1, r1, lsl #1
	ldrh r9, [r1, r0]
	ldrsh r1, [r8, #0]
	add r5, r8, #0x110
	sub r0, r9, #0x80
	rsb r0, r0, #0
	cmp r1, r0
	movle r0, #0x80
	subgt r0, r1, #1
	strh r0, [r8]
	mov r0, #0x88
	mul r7, r4, r0
	add r4, r8, #0x90
	ldrsh r1, [r8, #0]
	add r6, r8, #0xf8
	add r0, r4, r7
	strh r1, [r6, r7]
	add r1, r5, r7
	bl exDrawReqTask__AddRequest
	ldrsh r2, [r6, r7]
	add r0, r4, r7
	add r1, r5, r7
	sub r2, r2, r9
	strh r2, [r6, r7]
	bl exDrawReqTask__AddRequest
	ldrsh r2, [r6, r7]
	add r0, r4, r7
	add r1, r5, r7
	add r2, r2, r9
	strh r2, [r6, r7]
	ldrsh r2, [r6, r7]
	add r2, r2, r9
	strh r2, [r6, r7]
	bl exDrawReqTask__AddRequest
	ldrsh r2, [r6, r7]
	add r0, r8, #8
	add r1, r8, #0x88
	sub r2, r2, r9
	strh r2, [r6, r7]
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTutorialTask__Create(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x1a4
	ldr r0, =aExmsgtutorialt
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =exMsgTutorialTask__Main
	ldr r1, =exMsgTutorialTask__Destructor
	mov r2, #0x1800
	mov r3, #3
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r1, #0
	mov r2, #0x1a4
	bl MI_CpuFill8
	mov r0, r4
	bl GetExTask
	ldr r1, =exMsgTutorialTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exMsgTutorialTask__Destroy(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =0x021775B8
	ldr r0, [r0, #4]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}
