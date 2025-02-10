#include <hub/cviMap.hpp>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <hub/hubConfig.h>
#include <hub/hubAudio.h>
#include <game/graphics/paletteAnimation.h>
#include <game/file/fsRequest.h>

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void _ZN10HubControl16GetFileFrom_ViBGEt(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215B168Ev(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215B250Ev(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215B3B4Ev(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215B03CEv(void);
NOT_DECOMPILED void _ZN10HubControl17GetFileFrom_ViActEt(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215B6C4El(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215B498El(void);

NOT_DECOMPILED void _ZdlPv(void);
NOT_DECOMPILED void _ZnwmPv(void);

NOT_DECOMPILED void Unknown2051334__Func_2051534(void);

}

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED Task *ViMap__TaskSingleton;
NOT_DECOMPILED Task *ViMapPaletteAnimation__Singleton;

NOT_DECOMPILED void *aBpaViMapBpa;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC void ViMap__Create(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, #0x1040
	mov r2, #0
	ldr r0, =ViMap__Main
	ldr r1, =ViMap__Destructor
	mov r3, r2
	str r4, [sp]
	mov r4, #0x10
	str r4, [sp, #4]
	bl ViMap__CreateInternal
	ldr r1, =ViMap__TaskSingleton
	str r0, [r1]
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x338
	add r1, r4, #0x700
	mov r2, #0
	strh r2, [r1, #0xc0]
	strh r2, [r1, #0xc2]
	strh r2, [r1, #0xc4]
	strh r2, [r1, #0xc6]
	strh r2, [r1, #0xc8]
	strh r2, [r1, #0xca]
	strh r2, [r1, #0xcc]
	add r0, r0, #0xc00
	strh r2, [r1, #0xce]
	bl TalkHelpers__Func_2152F98
	mov r0, r4
	bl ViMap__Func_215C9B4
	mov r0, r4
	bl ViMap__Func_215CA1C
	mov r0, r4
	bl ViMap__Func_215CA60
	mov r0, r4
	bl ViMap__Func_215CA84
	mov r0, r4
	bl ViMap__Func_215D7B4
	mov r0, r4
	bl ViMap__Func_215D9E8
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__CreateInternal(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldrh lr, [sp, #0x18]
	ldrb ip, [sp, #0x1c]
	ldr r4, =0x00000FB4
	str lr, [sp]
	str ip, [sp, #4]
	str r4, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	bl GetTaskWork_
	mov r1, r0
	mov r0, r4
	bl _ZnwmPv
	movs r4, r0
	beq _0215BAE0
	bl _ZN10CViMapBackC1Ev
	add r0, r4, #0x5d0
	bl _ZN10CViMapIconC1Ev
_0215BAE0:
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215BAF0(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =ViMap__TaskSingleton
	ldr r0, [r0, #0]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetTaskWork_
	ldr r0, =ViMap__TaskSingleton
	ldr r0, [r0, #0]
	bl DestroyTask
	ldr r0, =ViMap__TaskSingleton
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215BB28(s32 a1)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =ViMap__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	cmp r4, #0
	beq _0215BB58
	cmp r4, #1
	beq _0215BB6C
	cmp r4, #2
	beq _0215BB80
	ldmia sp!, {r4, pc}
_0215BB58:
	ldr r0, =ViMap__TaskSingleton
	ldr r1, =ViMap__Func_215CC94
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}
_0215BB6C:
	ldr r0, =ViMap__TaskSingleton
	ldr r1, =ViMap__Main
	ldr r0, [r0, #0]
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}
_0215BB80:
	ldr r1, =ViMap__TaskSingleton
	mov r2, #6
	str r2, [r0, #0x7d8]
	ldr r0, [r1, #0]
	ldr r1, =ViMap__Func_215CDE0
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215BBAC(u16 x, u16 y)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, =ViMap__TaskSingleton
	mov r5, r0
	ldr r0, [r2, #0]
	mov r4, r1
	bl GetTaskWork_
	add r0, r0, #0x700
	strh r5, [r0, #0xc0]
	strh r4, [r0, #0xc2]
	strh r5, [r0, #0xc4]
	strh r4, [r0, #0xc6]
	strh r5, [r0, #0xc8]
	strh r4, [r0, #0xca]
	mov r1, #0
	strh r1, [r0, #0xcc]
	strh r1, [r0, #0xce]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215BBF4(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r3, =ViMap__TaskSingleton
	mov r6, r0
	ldr r0, [r3, #0]
	mov r5, r1
	mov r4, r2
	bl GetTaskWork_
	add r0, r0, #0x700
	strh r6, [r0, #0xc8]
	strh r5, [r0, #0xca]
	ldrh r2, [r0, #0xc0]
	mov r1, #0
	strh r2, [r0, #0xc4]
	ldrh r2, [r0, #0xc2]
	strh r2, [r0, #0xc6]
	strh r4, [r0, #0xcc]
	strh r1, [r0, #0xce]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215BC40(u16 *x, u16 *y)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, =ViMap__TaskSingleton
	mov r5, r0
	ldr r0, [r2, #0]
	mov r4, r1
	bl GetTaskWork_
	cmp r5, #0
	addne r1, r0, #0x700
	ldrneh r1, [r1, #0xc0]
	strneh r1, [r5]
	cmp r4, #0
	addne r0, r0, #0x700
	ldrneh r0, [r0, #0xc2]
	strneh r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC s32 ViMap__Func_215BC80(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =ViMap__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r0, r0, #0x5d0
	bl ViMapIcon__Func_21634F4
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC s32 ViMap__Func_215BCA0(s32 a1)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, =ViMap__TaskSingleton
	mov r5, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r4, r0
	cmp r5, #0
	beq _0215BCD4
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_2163688
	cmp r0, #0
	movne r0, #9
	ldmneia sp!, {r3, r4, r5, pc}
_0215BCD4:
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_21633F8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215BCE4(u32 a1, s32 a2)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	ldr r2, =ViMap__TaskSingleton
	mov r6, r0
	ldr r0, [r2, #0]
	mov r5, r1
	bl GetTaskWork_
	mov r4, r0
	cmp r5, #0
	mov r1, r6
	add r0, r4, #0x5d0
	beq _0215BD70
	bl ViMapIcon__Func_21633C4
	add r2, sp, #0
	add r3, sp, #2
	mov r1, r6
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_2163370
	ldrh r1, [sp]
	ldrh r0, [sp, #2]
	add r2, sp, #0
	add r1, r1, #8
	add r0, r0, #8
	strh r1, [sp]
	strh r0, [sp, #2]
	ldrh r0, [sp]
	ldrh r1, [sp, #2]
	add r3, sp, #2
	bl ViMap__Func_215D27C
	ldrh r0, [sp]
	ldrh r1, [sp, #2]
	mov r2, #0x20
	bl ViMap__Func_215BBF4
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_0215BD70:
	bl ViMapIcon__Func_21633A4
	add r2, sp, #0
	add r3, sp, #2
	mov r1, r6
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_2163370
	ldrh r1, [sp]
	ldrh r0, [sp, #2]
	add r2, sp, #0
	add r1, r1, #8
	add r0, r0, #8
	strh r1, [sp]
	strh r0, [sp, #2]
	ldrh r0, [sp]
	ldrh r1, [sp, #2]
	add r3, sp, #2
	bl ViMap__Func_215D27C
	ldrh r0, [sp]
	ldrh r1, [sp, #2]
	bl ViMap__Func_215BBAC
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC s32 ViMap__Func_215BDCC(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r0, #1
	bl ViMap__Func_215BCA0
	mov r4, r0
	cmp r4, #8
	movge r0, #9
	ldmgeia sp!, {r4, pc}
	bl ViMap__Func_215BC80
	cmp r4, r0
	moveq r0, r4
	ldmeqia sp!, {r4, pc}
	ldr r0, =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	moveq r4, #9
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215BE14(s32 a1)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0xc
	ldr r1, =ViMap__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r8, r0
	str r4, [r8, #0x7dc]
	mov r0, #0x17
	str r0, [r8, #0x7e0]
	mov r0, #9
	str r0, [r8, #0x7e4]
	ldr r0, [r8, #0x7dc]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__GetDockMapConfig
	ldr r0, [r0, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_2152960
	ldrh r1, [r0, #0x3c]
	add r0, r8, #0x700
	mov r9, #0
	add r10, r8, #0x810
	strh r1, [r0, #0xe8]
	mov r7, #4
	mov r6, r9
	mov r5, #0xf
	mov r4, #1
_0215BE88:
	mov r1, r9, lsl #0x10
	mov r0, r10
	mov r1, r1, lsr #0x10
	bl AnimatorSprite__SetAnimation
	str r7, [r10, #0x48]
	str r6, [r10, #0x4c]
	strh r5, [r10, #0x50]
	strb r6, [r10, #0x56]
	add r9, r9, #1
	strb r4, [r10, #0x57]
	cmp r9, #9
	add r10, r10, #0x64
	blt _0215BE88
	add r0, r8, #0x394
	mov r1, r6
	add r0, r0, #0x800
	bl AnimatorSprite__SetAnimation
	add r1, r8, #0x3f8
	add r0, r8, #0xb00
	mov r2, #0xc
	strh r2, [r0, #0xe4]
	mov r4, #0
	strb r4, [r8, #0xbea]
	add r3, r1, #0x800
	strb r4, [r8, #0xbeb]
	mov r2, #0xd
	mov r1, r4
	mov r0, #1
_0215BEF8:
	strh r2, [r3, #0x50]
	strb r1, [r3, #0x56]
	add r4, r4, #1
	strb r0, [r3, #0x57]
	cmp r4, #8
	add r3, r3, #0x64
	blt _0215BEF8
	add r2, sp, #0xa
	add r3, sp, #8
	mov r0, #0x20
	mov r1, #0x28
	bl ViMap__Func_215D27C
	ldrh r0, [sp, #0xa]
	ldrh r1, [sp, #8]
	bl ViMap__Func_215BBAC
	ldrh r1, [sp, #0xa]
	add r0, r8, #0x700
	mov r2, #1
	rsb r1, r1, #0x20
	strh r1, [r0, #0xd0]
	ldrh r3, [sp, #8]
	mov r1, #0
	rsb r3, r3, #0x28
	strh r3, [r0, #0xd2]
	str r2, [r8, #0x7d8]
	strh r1, [r0, #0xea]
	bl _ZN10HubControl12Func_215B03CEv
	mov r0, #3
	bl _ZN10HubControl16GetFileFrom_ViBGEt
	add r2, r8, #0x338
	mov r1, r0
	add r0, r2, #0xc00
	mov r2, #2
	str r2, [sp]
	mov r2, #0
	mov r3, #1
	str r2, [sp, #4]
	bl TalkHelpersUnknown__Init
	ldr r2, =0x04001000
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #4
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215BFC4(s32 a1)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r1, =ViMap__TaskSingleton
	mov r5, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #6
	str r0, [r4, #0x7dc]
	mov r0, r5, lsl #0x10
	str r5, [r4, #0x7e0]
	mov r1, #9
	mov r0, r0, lsr #0x10
	str r1, [r4, #0x7e4]
	bl HubConfig__Func_2152A60
	cmp r0, #0
	ldreq r1, =0x0000FFFF
	beq _0215C01C
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_2152A20
	ldrh r1, [r0, #0]
_0215C01C:
	add r0, r4, #0x700
	strh r1, [r0, #0xe8]
	add r2, sp, #0xa
	add r3, sp, #8
	mov r0, #0x20
	mov r1, #0x28
	bl ViMap__Func_215D27C
	ldrh r0, [sp, #0xa]
	ldrh r1, [sp, #8]
	bl ViMap__Func_215BBAC
	ldrh r1, [sp, #0xa]
	add r0, r4, #0x700
	mov r2, #1
	rsb r1, r1, #0x20
	strh r1, [r0, #0xd0]
	ldrh r3, [sp, #8]
	mov r1, #0
	rsb r3, r3, #0x28
	strh r3, [r0, #0xd2]
	str r2, [r4, #0x7d8]
	strh r1, [r0, #0xea]
	bl _ZN10HubControl12Func_215B03CEv
	mov r0, #3
	bl _ZN10HubControl16GetFileFrom_ViBGEt
	add r2, r4, #0x338
	mov r1, r0
	add r0, r2, #0xc00
	mov r2, #2
	str r2, [sp]
	mov r2, #0
	mov r3, #1
	str r2, [sp, #4]
	bl TalkHelpersUnknown__Init
	ldr r2, =0x04001000
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #4
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215C0D8(s32 a1)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0xc
	ldr r1, =ViMap__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r8, r0
	mov r1, #6
	str r1, [r8, #0x7dc]
	mov r1, #0x17
	mov r0, r4, lsl #0x10
	str r1, [r8, #0x7e0]
	str r4, [r8, #0x7e4]
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_21529A8
	ldr r0, [r0, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_2152960
	ldrh r1, [r0, #0x3c]
	add r0, r8, #0x700
	mov r9, #0
	add r10, r8, #0x810
	strh r1, [r0, #0xe8]
	mov r7, #4
	mov r6, r9
	mov r5, #0xf
	mov r4, #1
_0215C148:
	mov r1, r9, lsl #0x10
	mov r0, r10
	mov r1, r1, lsr #0x10
	bl AnimatorSprite__SetAnimation
	str r7, [r10, #0x48]
	str r6, [r10, #0x4c]
	strh r5, [r10, #0x50]
	strb r6, [r10, #0x56]
	add r9, r9, #1
	strb r4, [r10, #0x57]
	cmp r9, #9
	add r10, r10, #0x64
	blt _0215C148
	add r0, r8, #0x394
	mov r1, r6
	add r0, r0, #0x800
	bl AnimatorSprite__SetAnimation
	add r1, r8, #0x3f8
	add r0, r8, #0xb00
	mov r2, #0xc
	strh r2, [r0, #0xe4]
	mov r4, #0
	strb r4, [r8, #0xbea]
	add r3, r1, #0x800
	strb r4, [r8, #0xbeb]
	mov r2, #0xd
	mov r1, r4
	mov r0, #1
_0215C1B8:
	strh r2, [r3, #0x50]
	strb r1, [r3, #0x56]
	add r4, r4, #1
	strb r0, [r3, #0x57]
	cmp r4, #8
	add r3, r3, #0x64
	blt _0215C1B8
	add r2, sp, #0xa
	add r3, sp, #8
	mov r0, #0x20
	mov r1, #0x28
	bl ViMap__Func_215D27C
	ldrh r0, [sp, #0xa]
	ldrh r1, [sp, #8]
	bl ViMap__Func_215BBAC
	ldrh r1, [sp, #0xa]
	add r0, r8, #0x700
	mov r2, #1
	rsb r1, r1, #0x20
	strh r1, [r0, #0xd0]
	ldrh r3, [sp, #8]
	mov r1, #0
	rsb r3, r3, #0x28
	strh r3, [r0, #0xd2]
	str r2, [r8, #0x7d8]
	strh r1, [r0, #0xea]
	bl _ZN10HubControl12Func_215B03CEv
	mov r0, #3
	bl _ZN10HubControl16GetFileFrom_ViBGEt
	add r2, r8, #0x338
	mov r1, r0
	add r0, r2, #0xc00
	mov r2, #2
	str r2, [sp]
	mov r2, #0
	mov r3, #1
	str r2, [sp, #4]
	bl TalkHelpersUnknown__Init
	ldr r2, =0x04001000
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #4
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215C284(s32 a1)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r1, =ViMap__TaskSingleton
	mov r5, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x20
	mov r1, #0x28
	add r2, sp, #6
	add r3, sp, #4
	strh r0, [sp, #0xa]
	strh r1, [sp, #8]
	bl ViMap__Func_215D27C
	ldrh r0, [sp, #0xa]
	ldrh r1, [sp, #8]
	add r2, sp, #6
	add r3, sp, #4
	bl ViMap__Func_215D27C
	add r0, r4, #0x700
	ldrh r0, [r0, #0xe8]
	ldr r1, =0x0000FFFF
	cmp r0, r1
	beq _0215C32C
	bl HubConfig__Func_2152A30
	ldrh r1, [r0, #0]
	add r2, sp, #0xa
	add r3, sp, #8
	mov r0, r4
	bl ViMapBack__Func_2161864
	ldrh r1, [sp, #0xa]
	ldrh r0, [sp, #8]
	add r2, sp, #2
	add r1, r1, #0x18
	add r0, r0, #0x10
	strh r1, [sp, #0xa]
	strh r0, [sp, #8]
	ldrh r0, [sp, #0xa]
	ldrh r1, [sp, #8]
	add r3, sp, #0
	bl ViMap__Func_215D27C
	b _0215C378
_0215C32C:
	ldr r0, [r4, #0x7e0]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_2152A20
	ldrh r0, [r0, #0]
	add r1, sp, #0xa
	add r2, sp, #8
	bl ViMapBack__Func_2162798
	ldrh r1, [sp, #0xa]
	ldrh r0, [sp, #8]
	add r2, sp, #2
	add r1, r1, #0x18
	add r0, r0, #0x10
	strh r1, [sp, #0xa]
	strh r0, [sp, #8]
	ldrh r0, [sp, #0xa]
	ldrh r1, [sp, #8]
	add r3, sp, #0
	bl ViMap__Func_215D27C
_0215C378:
	cmp r5, #0
	ldreqh r5, [sp, #6]
	ldreqh r6, [sp, #4]
	beq _0215C3D0
	cmp r5, #0x1000
	ldreqh r5, [sp, #2]
	ldreqh r6, [sp]
	beq _0215C3D0
	ldrh r3, [sp, #6]
	ldrh r2, [sp, #2]
	ldrh r1, [sp, #4]
	ldrh r0, [sp]
	sub r2, r2, r3
	mul r2, r5, r2
	sub r0, r0, r1
	mul r0, r5, r0
	add r2, r3, r2, asr #12
	add r1, r1, r0, asr #12
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r5, r0, lsr #0x10
	mov r6, r1, lsr #0x10
_0215C3D0:
	mov r0, r5
	mov r1, r6
	bl ViMap__Func_215BBAC
	ldrh r1, [sp, #0xa]
	add r0, r4, #0x700
	sub r1, r1, r5
	strh r1, [r0, #0xd0]
	ldrh r1, [sp, #8]
	sub r1, r1, r6
	strh r1, [r0, #0xd2]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215C408(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	ldr r0, =ViMap__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x7dc]
	cmp r0, #5
	bge _0215C438
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__GetDockMapConfig
	b _0215C448
_0215C438:
	ldr r0, [r4, #0x7e4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_21529A8
_0215C448:
	add r1, r4, #0x700
	mov r2, #0
	strh r2, [r1, #0xea]
	strh r2, [r1, #0xec]
	ldrh r1, [r0, #0x14]
	mov r0, #0x10000
	bl FX_DivS32
	add r1, r4, #0x700
	strh r0, [r1, #0xee]
	add r1, r4, #0x7f0
	mov r0, #0x100
	mov r2, #0x20
	bl MIi_CpuClear32
	mov r0, #2
	str r0, [r4, #0x7d8]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL ViMap__Func_215C48C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =ViMap__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, [r0, #0x7dc]
	add r0, r0, #0x700
	cmp r1, #5
	movlt r2, #0x100
	ldrh r1, [r0, #0xea]
	movge r2, #0xa0
	add r0, r2, #0x62
	cmp r1, r0
	movhs r0, #1
	movlo r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215C4CC(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =ViMap__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #3
	str r1, [r0, #0x7d8]
	add r0, r0, #0x700
	mov r1, #0
	strh r1, [r0, #0xea]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL ViMap__Func_215C4F8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =ViMap__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r0, r0, #0x700
	ldrh r0, [r0, #0xea]
	cmp r0, #0x50
	movhs r0, #1
	movlo r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215C524(s32 a1)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, =ViMap__TaskSingleton
	mov r5, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r4, r0
	bl ViMap__Func_215D374
	mov r0, r5
	bl HubConfig__Func_2152A30
	ldrh r1, [r0, #0]
	mov r0, r4
	bl ViMapBack__Func_21619B0
	mov r0, r5
	bl HubConfig__Func_2152A30
	ldrh r1, [r0, #0]
	mov r0, r4
	bl ViMapBack__Func_2161ADC
	ldr r1, =0x0620C040
	mov r0, r4
	mov r2, #0
	bl ViMapBack__Func_2161F3C
	mov r0, r4
	bl ViMapBack__Func_2161DC8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215C58C(u16 a1)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, =ViMap__TaskSingleton
	mov r6, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r5, r0
	mov r0, r6
	bl HubConfig__Func_2152A20
	mov r4, r0
	mov r0, r6
	bl HubConfig__Func_2152A60
	cmp r0, #0
	beq _0215C620
	mov r0, r5
	bl ViMap__Func_215D374
	ldrh r0, [r4, #0]
	bl HubConfig__Func_2152A30
	ldrh r1, [r0, #0]
	mov r0, r5
	bl ViMapBack__Func_21619B0
	ldrh r0, [r4, #0]
	bl HubConfig__Func_2152A30
	ldrh r1, [r0, #0]
	mov r0, r5
	bl ViMapBack__Func_2161ADC
	ldr r1, =0x0620C040
	mov r0, r5
	mov r2, #0
	bl ViMapBack__Func_2161F3C
	mov r0, r5
	bl ViMapBack__Func_2161DC8
	cmp r6, #1
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r5
	mov r1, #2
	bl ViMapBack__Func_21620FC
	ldmia sp!, {r4, r5, r6, pc}
_0215C620:
	ldrh r1, [r4, #0]
	mov r0, r5
	bl ViMapBack__Func_21620FC
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215C638(s32 a1)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, =ViMap__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r5, r0
	add r0, r5, #0x338
	add r0, r0, #0xc00
	bl TalkHelpers__Func_2153064
	bl _ZN10HubControl12Func_215B168Ev
	mov r2, #0
	mov r1, #0x400
_0215C668:
	add r0, r5, r2, lsl #2
	add r0, r0, #0xf00
	strh r1, [r0, #0x18]
	add r2, r2, #1
	strh r1, [r0, #0x1a]
	cmp r2, #8
	blt _0215C668
	mov r0, r5
	mov r1, r4
	bl ViMap__Func_215D7D8
	mov r0, #4
	str r0, [r5, #0x7d8]
	add r0, r5, #0x700
	mov r1, #0
	strh r1, [r0, #0xea]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215C6AC(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r0, =ViMap__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x338
	add r0, r0, #0xc00
	bl TalkHelpers__Func_2153064
	bl _ZN10HubControl12Func_215B168Ev
	mov r2, #0
	mov r1, #0x400
_0215C6D8:
	add r0, r4, r2, lsl #2
	add r0, r0, #0xf00
	strh r1, [r0, #0x18]
	add r2, r2, #1
	strh r1, [r0, #0x1a]
	cmp r2, #8
	blt _0215C6D8
	ldr r0, [r4, #0x7e0]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_2152A60
	cmp r0, #0
	beq _0215C744
	ldr r0, [r4, #0x7e0]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_2152A20
	ldrh r5, [r0, #0]
	mov r0, r4
	mov r1, r5
	bl ViMap__Func_215D7D8
	cmp r5, #1
	bne _0215C750
	mov r0, r4
	mov r1, #2
	bl ViMapBack__Func_21620FC
	b _0215C750
_0215C744:
	bl _ZN10HubControl12Func_215B250Ev
	mov r0, r4
	bl ViMap__Func_215D9EC
_0215C750:
	mov r0, #4
	str r0, [r4, #0x7d8]
	add r0, r4, #0x700
	mov r1, #0
	strh r1, [r0, #0xea]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215C76C(s32 a1)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, =ViMap__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r5, r0
	add r0, r5, #0x338
	add r0, r0, #0xc00
	bl TalkHelpers__Func_2153064
	bl _ZN10HubControl12Func_215B168Ev
	mov r2, #0
	mov r1, #0x400
_0215C79C:
	add r0, r5, r2, lsl #2
	add r0, r0, #0xf00
	strh r1, [r0, #0x18]
	add r2, r2, #1
	strh r1, [r0, #0x1a]
	cmp r2, #8
	blt _0215C79C
	mov r0, r5
	mov r1, r4
	bl ViMap__Func_215D7D8
	mov r0, #4
	str r0, [r5, #0x7d8]
	add r0, r5, #0x700
	mov r1, #0
	strh r1, [r0, #0xea]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215C7E0(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	ldr r0, =ViMap__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r4, r0
	bl ViMap__Func_215D9C4
	add r0, r4, #0x338
	mov r1, #6
	str r1, [r4, #0x7d8]
	add r1, r4, #0x700
	mov r2, #0
	add r0, r0, #0xc00
	strh r2, [r1, #0xea]
	bl TalkHelpers__Func_2153064
	mov r0, r4
	bl ViMap__Func_215DA68
	bl _ZN10HubControl12Func_215B3B4Ev
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215C82C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =ViMap__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	add r0, r0, #0x5d0
	bl ViMapIcon__Func_21636A0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215C84C(s32 a1)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =ViMap__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	mov r2, r4
	add r0, r0, #0x5d0
	mov r1, #1
	bl ViMapIcon__Func_2163340
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215C878(s16 x, s16 y)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, =ViMap__TaskSingleton
	mov r5, r0
	ldr r0, [r2, #0]
	mov r4, r1
	bl GetTaskWork_
	mov r1, r5
	mov r2, r4
	add r0, r0, #0x5d0
	bl ViMapIcon__Func_21636AC
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapPaletteAnimation__Create(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	bl ViMap__Func_215C960
	ldr r0, =0x00001041
	mov r2, #0
	str r0, [sp]
	mov r4, #0x10
	str r4, [sp, #4]
	mov r4, #0x64
	ldr r0, =ViMapPaletteAnimation__Main
	ldr r1, =ViMapPaletteAnimation__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, =ViMap__TaskSingleton
	str r0, [r1, #4]
	bl GetTaskWork_
	mov r7, r0
	ldr r0, =aBpaViMapBpa
	mov r1, #0
	bl FSRequestFileSync
	mov r8, #0
	mov r9, r7
	str r0, [r7, #0x60]
	mov r6, #3
	mov r5, r8
	mov r4, #2
_0215C914:
	str r6, [sp]
	str r5, [sp, #4]
	mov r2, r8, lsl #0x10
	ldr r1, [r7, #0x60]
	mov r0, r9
	mov r3, r4
	mov r2, r2, lsr #0x10
	bl InitPaletteAnimator
	add r8, r8, #1
	cmp r8, #3
	add r9, r9, #0x20
	blt _0215C914
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215C960(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =ViMap__TaskSingleton
	ldr r0, [r0, #4]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl DestroyTask
	ldr r0, =ViMap__TaskSingleton
	mov r1, #0
	str r1, [r0, #4]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC AnimatorSprite *ViMap__Func_215C98C(u16 id)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =ViMap__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	add r1, r0, #0x810
	mov r0, #0x64
	mla r0, r4, r0, r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215C9B4(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ViMapBack__LoadAssets
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl ViMapBack__Func_2161F08
	ldr r1, =0x0620A000
	mov r0, r4
	mov r2, #1
	bl ViMapBack__Func_2162010
	mov r0, r4
	bl ViMapBack__Func_2161924
	mov r0, r4
	bl ViMap__Func_215D374
	mov r0, r4
	bl ViMapBack__Func_2161A40
	mov r0, r4
	ldr r1, =0x0620C040
	mov r2, #0
	bl ViMapBack__Func_2161F3C
	mov r0, r4
	bl ViMapBack__Func_2161DC8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215CA1C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x5d0
	mov r1, #1
	bl ViMapIcon__Func_2163058
	add r0, r4, #0x5d0
	mov r1, #0
	bl ViMapIcon__Func_21633A4
	add r0, r4, #0x5d0
	mov r1, #0
	mov r2, #1
	bl ViMapIcon__Func_2163340
	mov r1, #1
	mov r2, r1
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_2163340
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215CA60(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ViMap__Func_215D214
	add r0, r4, #0x700
	ldrsh r1, [r0, #0xc0]
	ldrsh r2, [r0, #0xc2]
	mov r0, r4
	bl ViMapBack__Func_2162648
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215CA84(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x20
	str r0, [sp, #0x1c]
	mov r0, #8
	bl _ZN10HubControl17GetFileFrom_ViActEt
	mov r7, r0
	ldr r0, [sp, #0x1c]
	mov r8, #0
	add r9, r0, #0x810
	mov r6, #1
	mov r5, r8
	mov r4, #4
	mov r11, #0x1e00
_0215CAB8:
	mov r1, r8, lsl #0x10
	mov r0, r7
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	cmp r8, #0
	moveq r10, #0
	mov r0, #1
	movne r10, #0x10
	bl VRAMSystem__AllocSpriteVram
	str r6, [sp]
	str r5, [sp, #4]
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	str r11, [sp, #0x10]
	str r5, [sp, #0x14]
	mov r3, r10
	mov r0, r9
	mov r1, r7
	mov r2, r5
	str r5, [sp, #0x18]
	bl AnimatorSprite__Init
	add r8, r8, #1
	add r9, r9, #0x64
	cmp r8, #9
	blt _0215CAB8
	mov r0, #9
	bl _ZN10HubControl17GetFileFrom_ViActEt
	mov r1, #0
	mov r4, r0
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r1, #1
	str r1, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x1c]
	ldr r3, =0x05000600
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	add r0, r0, #0x394
	str r2, [sp, #0x14]
	mov r1, r4
	add r0, r0, #0x800
	mov r3, r2
	str r2, [sp, #0x18]
	bl AnimatorSprite__Init
	mov r0, #4
	bl _ZN10HubControl17GetFileFrom_ViActEt
	mov r7, r0
	bl Sprite__GetSpriteSize3
	mov r9, r0
	ldr r0, [sp, #0x1c]
	mov r8, #0
	add r0, r0, #0x3f8
	ldr r11, =0x05000600
	add r6, r0, #0x800
	mov r5, #1
	mov r4, r8
_0215CBB0:
	cmp r8, #0
	moveq r10, #0
	mov r0, #1
	mov r1, r9
	movne r10, #0x10
	bl VRAMSystem__AllocSpriteVram
	str r5, [sp]
	str r4, [sp, #4]
	str r0, [sp, #8]
	str r4, [sp, #0xc]
	str r11, [sp, #0x10]
	str r4, [sp, #0x14]
	orr r3, r10, #4
	mov r0, r6
	mov r1, r7
	mov r2, r4
	str r4, [sp, #0x18]
	bl AnimatorSprite__Init
	add r8, r8, #1
	add r6, r6, #0x64
	cmp r8, #8
	blt _0215CBB0
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215CC14(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	add r0, r4, #0x338
	add r0, r0, #0xc00
	bl TalkHelpers__Func_2153064
	mov r0, r4
	bl ViMap__Func_215D9C4
	add r0, r4, #0x3f8
	add r6, r0, #0x800
	mov r5, #0
_0215CC3C:
	mov r0, r6
	bl AnimatorSprite__Release
	add r5, r5, #1
	cmp r5, #8
	add r6, r6, #0x64
	blt _0215CC3C
	add r0, r4, #0x394
	add r0, r0, #0x800
	bl AnimatorSprite__Release
	add r5, r4, #0x810
	mov r6, #0
_0215CC68:
	mov r0, r5
	bl AnimatorSprite__Release
	add r6, r6, #1
	cmp r6, #9
	add r5, r5, #0x64
	blt _0215CC68
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_2163294
	mov r0, r4
	bl ViMapBack__Func_2161680
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215CC94(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x700
	ldrh r0, [r0, #0xcc]
	mov r5, #9
	cmp r0, #0
	bne _0215CCD4
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_21634F4
	mov r5, r0
	cmp r5, #8
	blt _0215CCD4
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_21635DC
	mov r5, r0
_0215CCD4:
	cmp r5, #8
	bge _0215CD50
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_21633F8
	cmp r5, r0
	beq _0215CD50
	mov r1, r5
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_21633C4
	add r2, sp, #0
	add r3, sp, #2
	mov r1, r5
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_2163370
	ldrh r1, [sp]
	ldrh r0, [sp, #2]
	add r2, sp, #0
	add r1, r1, #8
	add r0, r0, #8
	strh r1, [sp]
	strh r0, [sp, #2]
	ldrh r0, [sp]
	ldrh r1, [sp, #2]
	add r3, sp, #2
	bl ViMap__Func_215D27C
	ldrh r0, [sp]
	ldrh r1, [sp, #2]
	mov r2, #0x20
	bl ViMap__Func_215BBF4
	mov r0, #3
	bl PlayHubSfx
_0215CD50:
	mov r0, r4
	bl ViMap__Func_215D2B4
	mov r0, r4
	bl ViMapBack__Func_2162110
	mov r0, r4
	mov r1, #0
	bl ViMapBack__Func_2162158
	add r0, r4, #0x700
	ldrh r1, [r0, #0xc0]
	ldrh r2, [r0, #0xc2]
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_2163364
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_2163400
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_2163440
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Main(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl ViMap__Func_215D2B4
	mov r0, r4
	bl ViMapBack__Func_2162110
	mov r0, r4
	mov r1, #0
	bl ViMapBack__Func_2162158
	add r0, r4, #0x700
	ldrh r1, [r0, #0xc0]
	ldrh r2, [r0, #0xc2]
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_2163364
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_2163400
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_2163440
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215CDE0(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	mov r0, #0
	str r0, [sp, #8]
	bl GetCurrentTaskWork_
	mov r6, r0
	ldr r0, [r6, #0x7dc]
	cmp r0, #5
	bge _0215CE18
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__GetDockMapConfig
	mov r7, r0
	b _0215CE38
_0215CE18:
	ldr r0, [r6, #0x7e4]
	cmp r0, #8
	movge r7, #0
	bge _0215CE38
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_21529A8
	mov r7, r0
_0215CE38:
	ldr r0, [r6, #0x7d8]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _0215D0BC
_0215CE48: // jump table
	b _0215D0BC // case 0
	b _0215CE5C // case 1
	b _0215CE9C // case 2
	b _0215CF68 // case 3
	b _0215D000 // case 4
_0215CE5C:
	add r0, r6, #0x700
	ldrh r1, [r0, #0xea]
	cmp r1, #0x80
	movhs r1, #0x1000
	movhs r2, #8
	bhs _0215CE90
	mov r0, r1, lsl #0xc
	mov r0, r0, asr #7
	rsb r0, r0, #0x2000
	mov r2, r1, lsl #0xc
	mov r0, r0, lsl #0x10
	mov r1, r0, asr #0x10
	mov r2, r2, lsr #0x10
_0215CE90:
	mov r0, r6
	bl ViMap__Func_215D44C
	b _0215D0BC
_0215CE9C:
	ldr r0, [r6, #0x7dc]
	ldrh r1, [r7, #0x14]
	cmp r0, #5
	bge _0215CEB8
	mov r0, #0x100
	bl FX_DivS32
	b _0215CEC0
_0215CEB8:
	mov r0, #0xa0
	bl FX_DivS32
_0215CEC0:
	ldrh r1, [r7, #0x14]
	mov r9, r0
	add r0, r6, #0x700
	ldrh r8, [r0, #0xea]
	cmp r1, #0
	mov r10, #0
	ble _0215CF3C
	mov r11, #0x2000
	mov r4, #0x30
	mov r5, #0x100
_0215CEE8:
	cmp r8, #0
	addlt r0, r6, r10, lsl #2
	strlt r5, [r0, #0x7f0]
	blt _0215CF28
	cmp r8, #0x62
	addge r0, r6, r10, lsl #2
	strge r4, [r0, #0x7f0]
	bge _0215CF28
	mov r0, #0x100
	mov r1, #0x30
	mov r2, #0x62
	mov r3, r8
	str r11, [sp]
	bl Unknown2051334__Func_2051534
	add r1, r6, r10, lsl #2
	str r0, [r1, #0x7f0]
_0215CF28:
	ldrh r0, [r7, #0x14]
	sub r8, r8, r9
	add r10, r10, #1
	cmp r10, r0
	blt _0215CEE8
_0215CF3C:
	add r3, r6, #0x700
	ldrh r2, [r3, #0xec]
	mov r0, r6
	mov r1, #0x1000
	sub r4, r2, #0x200
	mov r2, #8
	strh r4, [r3, #0xec]
	bl ViMap__Func_215D44C
	mov r0, r6
	bl ViMap__Func_215D4B4
	b _0215D0BC
_0215CF68:
	add r0, r6, #0x700
	ldrh r2, [r0, #0xec]
	mov r1, #0x80
	sub r2, r2, #0x200
	strh r2, [r0, #0xec]
	ldrh r0, [r0, #0xea]
	add r0, r0, r0, lsl #1
	mov r0, r0, lsl #0xa
	bl FX_DivS32
	add r2, r6, #0x700
	ldrh r4, [r2, #0xec]
	mov r3, #0x30
	mov r1, #0x80
	sub r0, r4, r0
	strh r0, [r2, #0xec]
	ldrh r2, [r2, #0xea]
	mul r0, r2, r3
	bl FX_DivS32
	rsb r1, r0, #0x30
	cmp r1, #0x10
	ldrh r0, [r7, #0x14]
	movlt r1, #0x10
	mov r2, #0
	cmp r0, #0
	ble _0215CFE4
_0215CFCC:
	add r0, r6, r2, lsl #2
	str r1, [r0, #0x7f0]
	ldrh r0, [r7, #0x14]
	add r2, r2, #1
	cmp r2, r0
	blt _0215CFCC
_0215CFE4:
	mov r0, r6
	mov r1, #0x1000
	mov r2, #8
	bl ViMap__Func_215D44C
	mov r0, r6
	bl ViMap__Func_215D4B4
	b _0215D0BC
_0215D000:
	add r0, r6, #0x700
	ldrh r0, [r0, #0xea]
	tst r0, #7
	bne _0215D018
	mov r0, r6
	bl ViMap__Func_215D604
_0215D018:
	mov r0, r6
	bl ViMap__Func_215D734
	add r0, r6, #0x700
	ldrh r0, [r0, #0xea]
	and r0, r0, #0x3f
	cmp r0, #0x20
	rsbge r0, r0, #0x3f
	mov r1, r0, asr #1
	orr r0, r1, r1, lsl #5
	orr r0, r0, r1, lsl #10
	ldr r1, [r6, #0x7dc]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r1, #5
	str r0, [sp, #0xc]
	ldrge r0, [r6, #0x7e4]
	cmpge r0, #8
	blt _0215D078
	ldr r0, [r6, #0x7e0]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_2152A60
	cmp r0, #0
	beq _0215D088
_0215D078:
	ldr r1, [sp, #0xc]
	mov r0, r6
	bl ViMap__Func_215D930
	b _0215D0BC
_0215D088:
	mov r0, #1
	str r0, [sp]
	str r0, [sp, #4]
	ldr r0, [r6, #0x7e0]
	add r3, r6, #0xd2
	mov r1, r0, lsl #0x10
	mov r0, r6
	mov r1, r1, lsr #0x10
	add r2, r6, #0x7d0
	add r3, r3, #0x700
	bl ViMapBack__Func_2162508
	mov r0, #1
	str r0, [sp, #8]
_0215D0BC:
	add r1, r6, #0x700
	ldrh r2, [r1, #0xea]
	mov r0, r6
	add r2, r2, #1
	strh r2, [r1, #0xea]
	bl ViMap__Func_215D2B4
	mov r0, r6
	bl ViMapBack__Func_2162110
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _0215D0F4
	ldr r1, [sp, #0xc]
	mov r0, r6
	bl ViMap__Func_215DA38
_0215D0F4:
	ldr r0, [r6, #0x7e0]
	cmp r0, #0x13
	mov r0, r6
	bne _0215D114
	mov r1, #1
	bl ViMapBack__Func_2162158
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0215D114:
	mov r1, #0
	bl ViMapBack__Func_2162158
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Destructor(Task *task)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	bl ViMap__Func_215CC14
	mov r0, r4
	bl ViMap__Func_215D150
	ldr r0, =ViMap__TaskSingleton
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215D150(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x10]
	cmp r4, #0
	beq _0215D17C
	add r0, r4, #0x5d0
	bl _ZN10CViMapIconD1Ev
	mov r0, r4
	bl _ZN10CViMapBackD0Ev
	mov r0, r4
	bl _ZdlPv
_0215D17C:
	mov r0, #0
	str r0, [r5, #0x10]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapPaletteAnimation__Main(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	mov r4, #0
_0215D198:
	mov r0, r5
	bl AnimatePalette
	mov r0, r5
	bl DrawAnimatedPalette
	add r4, r4, #1
	cmp r4, #3
	add r5, r5, #0x20
	blt _0215D198
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMapPaletteAnimation__Destructor(Task *task)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	bl GetTaskWork_
	mov r5, r0
	mov r6, r5
	mov r4, #0
_0215D1D0:
	mov r0, r6
	bl ReleasePaletteAnimator
	add r4, r4, #1
	cmp r4, #3
	add r6, r6, #0x20
	blt _0215D1D0
	ldr r0, [r5, #0x60]
	cmp r0, #0
	beq _0215D200
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r5, #0x60]
_0215D200:
	ldr r0, =ViMap__TaskSingleton
	mov r1, #0
	str r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215D214(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_21633F8
	mov r1, r0
	add r2, sp, #0
	add r3, sp, #2
	add r0, r4, #0x5d0
	bl ViMapIcon__Func_2163370
	ldrh r1, [sp]
	ldrh r0, [sp, #2]
	add r2, sp, #0
	add r1, r1, #8
	add r0, r0, #8
	strh r1, [sp]
	strh r0, [sp, #2]
	ldrh r0, [sp]
	ldrh r1, [sp, #2]
	add r3, sp, #2
	bl ViMap__Func_215D27C
	ldrh r0, [sp]
	ldrh r1, [sp, #2]
	bl ViMap__Func_215BBAC
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215D27C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	subs r0, r0, #0x80
	sub r1, r1, #0x60
	movmi r0, #0
	cmp r1, #0x10
	movlt r1, #0x10
	cmp r0, #0x40
	movgt r0, #0x40
	cmp r1, #0x40
	movgt r1, #0x40
	cmp r2, #0
	strneh r0, [r2]
	cmp r3, #0
	strneh r1, [r3]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215D2B4(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	add r0, r4, #0x700
	ldrh r1, [r0, #0xcc]
	cmp r1, #0
	beq _0215D35C
	ldrh r3, [r0, #0xce]
	cmp r3, r1
	blo _0215D308
	ldrh r2, [r0, #0xc8]
	mov r1, #0
	strh r2, [r0, #0xc0]
	ldrh r2, [r0, #0xca]
	strh r2, [r0, #0xc2]
	ldrh r2, [r0, #0xc8]
	strh r2, [r0, #0xc4]
	ldrh r2, [r0, #0xca]
	strh r2, [r0, #0xc6]
	strh r1, [r0, #0xcc]
	strh r1, [r0, #0xce]
	b _0215D35C
_0215D308:
	ldrh r5, [r0, #0xc4]
	ldrh r0, [r0, #0xc8]
	sub r2, r0, r5
	mul r0, r2, r3
	bl FX_DivS32
	add r1, r5, r0
	add r0, r4, #0x700
	strh r1, [r0, #0xc0]
	ldrh r5, [r0, #0xc6]
	ldrh r3, [r0, #0xca]
	ldrh r2, [r0, #0xce]
	ldrh r1, [r0, #0xcc]
	sub r3, r3, r5
	mul r0, r3, r2
	bl FX_DivS32
	add r1, r5, r0
	add r0, r4, #0x700
	strh r1, [r0, #0xc2]
	ldrh r1, [r0, #0xce]
	add r1, r1, #1
	strh r1, [r0, #0xce]
_0215D35C:
	add r0, r4, #0x700
	ldrsh r1, [r0, #0xc0]
	ldrsh r2, [r0, #0xc2]
	mov r0, r4
	bl ViMapBack__Func_2162648
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215D374(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r1, #0
	bl ViMapBack__Func_21619B0
	mov r0, r4
	mov r1, #1
	bl ViMapBack__Func_21619B0
	mov r5, #0
_0215D394:
	mov r0, r5
	bl _ZN10HubControl12Func_215B498El
	cmp r0, #0
	beq _0215D3D4
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__GetDockMapConfig
	ldr r0, [r0, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_2152960
	ldrh r0, [r0, #0x3c]
	bl HubConfig__Func_2152A30
	ldrh r1, [r0, #0]
	mov r0, r4
	bl ViMapBack__Func_21619B0
_0215D3D4:
	add r5, r5, #1
	cmp r5, #5
	blt _0215D394
	mov r6, #0
_0215D3E4:
	mov r0, r6
	bl _ZN10HubControl12Func_215B6C4El
	cmp r0, #0
	beq _0215D43C
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_2152A20
	mov r1, r6, lsl #0x10
	mov r5, r0
	mov r0, r1, lsr #0x10
	bl HubConfig__Func_2152A60
	cmp r0, #0
	beq _0215D430
	ldrh r0, [r5, #0]
	bl HubConfig__Func_2152A30
	ldrh r1, [r0, #0]
	mov r0, r4
	bl ViMapBack__Func_21619B0
	b _0215D43C
_0215D430:
	ldrh r1, [r5, #0]
	mov r0, r4
	bl ViMapBack__Func_21620FC
_0215D43C:
	add r6, r6, #1
	cmp r6, #0x16
	blt _0215D3E4
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215D44C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	add r3, r4, #0x700
	mov r6, r1
	mov r5, r2
	add r0, r4, #0x338
	ldrsh r1, [r3, #0xd0]
	ldrsh r2, [r3, #0xd2]
	add r0, r0, #0xc00
	bl TalkHelpers__Func_215332C
	add r0, r4, #0x338
	mov r1, r6
	add r0, r0, #0xc00
	bl TalkHelpers__Func_2153338
	mov r0, r5, lsl #0xc
	mov r1, #0x10
	bl FX_DivS32
	add r1, r4, #0x338
	mov r2, r0, lsl #0x10
	add r0, r1, #0xc00
	mov r1, r2, asr #0x10
	bl TalkHelpers__Func_2153350
	add r0, r4, #0x338
	add r0, r0, #0xc00
	bl TalkHelpers__Func_21530A8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215D4B4(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r10, r0
	ldr r0, [r10, #0x7dc]
	cmp r0, #5
	bge _0215D4D8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__GetDockMapConfig
	b _0215D4E8
_0215D4D8:
	ldr r0, [r10, #0x7e4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl HubConfig__Func_21529A8
_0215D4E8:
	mov r5, #0
	mov r9, r0
	add r6, r10, #0x810
	mov r4, r5
_0215D4F8:
	mov r0, r6
	mov r1, r4
	mov r2, r4
	bl AnimatorSprite__ProcessAnimation
	add r5, r5, #1
	cmp r5, #9
	add r6, r6, #0x64
	blt _0215D4F8
	add r0, r10, #0x394
	mov r1, #0
	mov r2, r1
	add r0, r0, #0x800
	bl AnimatorSprite__ProcessAnimation
	add r5, r10, #0x700
	ldrh r0, [r9, #0x14]
	ldrh r7, [r5, #0xec]
	mov r8, #0
	cmp r0, #0
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r11, r10, #0x394
	add r6, r10, #0x810
	mvn r4, #0x1f
_0215D550:
	mov r0, r7, asr #4
	mov r1, r0, lsl #1
	ldr r0, =FX_SinCosTable_
	mov r2, r1, lsl #1
	add r0, r0, r1, lsl #1
	add r3, r10, r8, lsl #2
	ldrsh r1, [r0, #2]
	ldr r0, [r3, #0x7f0]
	ldr r3, =FX_SinCosTable_
	ldrsh ip, [r3, r2]
	mul r2, r0, r1
	mul r1, r0, ip
	add r3, r9, r8, lsl #1
	ldrh r0, [r5, #0xd0]
	ldrh r3, [r3, #0x18]
	ldrh ip, [r5, #0xd2]
	add r2, r0, r2, asr #12
	cmp r3, #9
	movlo r0, #0x64
	mlalo r0, r3, r0, r6
	addhs r0, r11, #0x800
	add r1, ip, r1, asr #12
	cmp r2, r4
	ble _0215D5DC
	cmp r2, #0x120
	bge _0215D5DC
	cmp r1, r4
	ble _0215D5DC
	cmp r1, #0xe0
	bge _0215D5DC
	sub r2, r2, #0x10
	strh r2, [r0, #8]
	sub r1, r1, #0x10
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
_0215D5DC:
	ldrh r0, [r5, #0xee]
	ldrh r1, [r9, #0x14]
	add r8, r8, #1
	add r0, r7, r0
	mov r0, r0, lsl #0x10
	cmp r8, r1
	mov r7, r0, lsr #0x10
	blt _0215D550
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215D604(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r0
	mov r5, #0
_0215D610:
	add r0, r6, r5, lsl #2
	add r0, r0, #0xf00
	ldrsh r0, [r0, #0x18]
	cmp r0, #0x400
	bne _0215D718
	ldr r3, =_mt_math_rand
	add r0, r6, #0x3f8
	ldr r4, [r3, #0]
	ldr r1, =0x00196225
	ldr r2, =0x3C6EF35F
	add r7, r0, #0x800
	mla r2, r4, r1, r2
	mov r0, #0x64
	mov r1, r2, lsr #0x10
	mla r4, r5, r0, r7
	mov r1, r1, lsl #0x10
	mov r0, r1, lsr #0x10
	mov r1, #0xa
	str r2, [r3]
	bl FX_ModS32
	mov r1, r0, lsl #0x10
	mov r0, r4
	mov r1, r1, lsr #0x10
	bl AnimatorSprite__SetAnimation
	ldr r8, =_mt_math_rand
	add r0, r6, r5, lsl #2
	ldr r1, [r8, #0]
	ldr r2, =0x00196225
	ldr r3, =0x3C6EF35F
	add r7, r0, #0xf00
	mla r0, r1, r2, r3
	mov r1, r0, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0x3f
	str r0, [r8]
	sub r0, r1, #0x20
	strh r0, [r7, #0x18]
	ldr r1, [r8, #0]
	add ip, r6, #0x318
	mla r2, r1, r2, r3
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0x1f
	str r2, [r8]
	sub r1, r1, #0x2f
	strh r1, [r7, #0x1a]
	add r1, r6, #0x700
	add lr, r6, #0x1a
	mov r0, r5, lsl #2
	add r8, ip, #0xc00
	ldrsh r5, [r8, r0]
	ldrh r2, [r1, #0xd0]
	add r3, lr, #0xf00
	add r2, r5, r2
	strh r2, [r8, r0]
	ldrsh r2, [r3, r0]
	ldrh r1, [r1, #0xd2]
	add r1, r2, r1
	strh r1, [r3, r0]
	ldrsh r0, [r7, #0x18]
	strh r0, [r4, #8]
	ldrsh r0, [r7, #0x1a]
	strh r0, [r4, #0xa]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0215D718:
	add r5, r5, #1
	cmp r5, #8
	blt _0215D610
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215D734(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r0
	add r0, r6, #0x3f8
	mov r4, #0
	add r5, r0, #0x800
	mov r7, r4
	mov r8, #0x400
_0215D750:
	add r0, r6, r4, lsl #2
	add r0, r0, #0xf00
	ldrsh r1, [r0, #0x18]
	cmp r1, #0x400
	beq _0215D7A0
	ldrsh r1, [r0, #0x1a]
	ldrsh r2, [r5, #0xa]
	add r1, r1, #0x40
	cmp r2, r1
	strgeh r8, [r0, #0x18]
	strgeh r8, [r0, #0x1a]
	bge _0215D7A0
	add r3, r2, #1
	mov r0, r5
	mov r1, r7
	mov r2, r7
	strh r3, [r5, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r5
	bl AnimatorSprite__DrawFrame
_0215D7A0:
	add r4, r4, #1
	cmp r4, #8
	add r5, r5, #0x64
	blt _0215D750
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215D7B4(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	add r1, r0, #0xf00
	mov r2, #0
	add r0, r0, #0x36c
	strh r2, [r1, #0x68]
	ldr ip, =Unknown2056FDC__Init
	add r0, r0, #0xc00
	strh r2, [r1, #0x6a]
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215D7D8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x18
	mov r5, r0
	mov r4, r1
	bl ViMap__Func_215D9C4
	mov r0, r5
	bl ViMap__Func_215D374
	mov r0, r4
	bl HubConfig__Func_2152A30
	ldrh r1, [r0, #0]
	mov r0, r5
	bl ViMapBack__Func_21619B0
	mov r0, r4
	bl HubConfig__Func_2152A30
	ldrh r1, [r0, #0]
	mov r0, r5
	bl ViMapBack__Func_2161BE4
	mov r0, r4
	bl HubConfig__Func_2152A30
	add r2, sp, #0x12
	str r2, [sp]
	add r1, sp, #0x10
	str r1, [sp, #4]
	ldrh r1, [r0, #0]
	mov r0, r5
	add r2, sp, #0x16
	add r3, sp, #0x14
	bl ViMapBack__Func_21617E4
	ldrh r1, [sp, #0x16]
	add r0, r5, #0xf00
	mov r1, r1, lsl #3
	strh r1, [r0, #0x68]
	ldrh r1, [sp, #0x14]
	mov r1, r1, lsl #3
	strh r1, [r0, #0x6a]
	ldrh r0, [sp, #0x12]
	ldrh r1, [sp, #0x10]
	mov r0, r0, lsl #6
	mul r0, r1, r0
	bl _AllocTailHEAP_USER
	mov r4, r0
	ldrh r2, [sp, #0x12]
	mov r0, r5
	mov r1, r4
	str r2, [sp]
	ldrh ip, [sp, #0x10]
	mov r2, #0
	mov r3, r2
	str ip, [sp, #4]
	bl ViMapBack__Func_2161E30
	mov r0, r5
	bl ViMapBack__Func_2161DC8
	mov r0, r5
	bl ViMapBack__Func_2161E20
	ldrh r1, [sp, #0x12]
	add r3, r5, #0x36c
	mov ip, #0x100
	str r1, [sp]
	ldrh lr, [sp, #0x10]
	mov r1, #1
	mov r2, r1
	str lr, [sp, #4]
	str r0, [sp, #8]
	add r0, r3, #0xc00
	mov r3, r4
	str ip, [sp, #0xc]
	bl Unknown2056FDC__Func_2057004
	add r1, r5, #0xf00
	ldrh r3, [r1, #0x6c]
	add r0, r5, #0x36c
	mov r2, #0xf
	orr r3, r3, #0xc
	strh r3, [r1, #0x6c]
	strh r2, [r1, #0xa0]
	mov r1, #2
	strb r1, [r5, #0xfa6]
	mov r1, #0x1f
	strb r1, [r5, #0xfa7]
	mov r1, #0
	add r0, r0, #0xc00
	str r1, [r5, #0xfa8]
	bl Unknown2056FDC__Func_2057484
	mov r0, r4
	bl _FreeHEAP_USER
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215D930(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r1
	add r1, sp, #2
	add r2, sp, #0
	mov r4, r0
	bl ViMapBack__Func_2162774
	mov r0, #1
	str r0, [r4, #0xfa8]
	add r0, r4, #0xf00
	ldrh r2, [r0, #0xa4]
	ldr r1, [r4, #0xf94]
	mov r0, r5
	mov r2, r2, lsl #1
	bl MIi_CpuClear16
	add r0, r4, #0x36c
	add r0, r0, #0xc00
	mov r1, #0
	mov r2, #1
	bl Unknown2056FDC__Func_2057460
	add r1, r4, #0xf00
	add r0, r4, #0x36c
	ldrh r3, [r1, #0x68]
	ldrsh r2, [sp, #2]
	add r0, r0, #0xc00
	sub r2, r3, r2
	add r2, r2, #0x18
	strh r2, [r1, #0x70]
	ldrh r3, [r1, #0x6a]
	ldrsh r2, [sp]
	sub r2, r3, r2
	add r2, r2, #0x10
	strh r2, [r1, #0x72]
	bl Unknown2056FDC__Func_2057484
	add r0, r4, #0x36c
	add r0, r0, #0xc00
	bl Unknown2056FDC__Func_2057614
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215D9C4(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	add r1, r0, #0xf00
	mov r2, #0
	add r0, r0, #0x36c
	strh r2, [r1, #0x68]
	ldr ip, =Unknown2056FDC__Release
	add r0, r0, #0xc00
	strh r2, [r1, #0x6a]
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215D9E8(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215D9EC(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	add r0, r0, #0x35c
	mov r1, #0
	add r0, r0, #0xc00
	mov r2, #1
	mov r3, #2
	str r1, [sp]
	bl TalkHelpersUnknown2__Func_215354C
	ldr r2, =0x04001000
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #4
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215DA38(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x35c
	add r0, r0, #0xc00
	bl TalkHelpersUnknown2__Func_2153614
	ldr r1, [r4, #0x7e0]
	mov r0, r4
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, #1
	bl ViMapBack__Func_216233C
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViMap__Func_215DA68(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	bx lr

// clang-format on
#endif
}
