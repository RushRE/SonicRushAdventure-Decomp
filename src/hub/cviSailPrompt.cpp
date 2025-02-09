#include <hub/cviSailPrompt.hpp>
#include <hub/hubControl.hpp>
#include <hub/hubAudio.h>
#include <hub/cviDockNpcTalk.hpp>
#include <game/save/saveGame.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/file/fileUnknown.h>

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void _ZN10HubControl12Func_215A888Ev(void);
NOT_DECOMPILED void _ZN10HubControl17GetFileFrom_ViMsgEv(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215A96CEv(void);
NOT_DECOMPILED void _ZN10HubControl10GetField54Ev(void);
NOT_DECOMPILED void _ZN10HubControl17GetFileFrom_ViActEt(void);
NOT_DECOMPILED void _ZN14CViDockNpcTalk12SetSelectionEl(void);
NOT_DECOMPILED void _ZN14CViDockNpcTalk13SetTalkActionEm(void);
NOT_DECOMPILED void _ZN17CViEvtCmnAnnounce11SetSequenceEtt(void);
NOT_DECOMPILED void _ZN17CViEvtCmnAnnounceC1Ev(void);
NOT_DECOMPILED void _ZdlPv(void);

}

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC void ViSailPrompt__Create(s32 param)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr ip, =ViSailPrompt__CreateInternal
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__CreateInternal(s32 param)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r1, =0x00001010
	mov r5, r0
	mov r2, #0
	str r1, [sp]
	mov r4, #0x10
	ldr r0, =ViSailPrompt__Main
	ldr r1, =ViSailPrompt__Destructor
	mov r3, r2
	str r4, [sp, #4]
	mov r4, #0x1f4
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r1, =0x0000FFFF
	str r5, [r4]
	strh r1, [r4, #8]
	bl ViSailPrompt__InitDisplay
	mov r0, r4
	bl ViSailPrompt__InitGraphics
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__InitDisplay(CViSailPrompt *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl _ZN10HubControl12Func_215A888Ev
	mov r0, r4
	bl ViSailPrompt__Func_216968C
	mov r0, r4
	bl ViSailPrompt__Func_21696AC
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__InitGraphics(CViSailPrompt *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0
	bl ViSailPrompt__Func_21695E4
	mov r0, #0
	bl ViSailPrompt__Func_2169638
	add r0, r4, #0xd4
	bl FontWindowAnimator__Init
	add r0, r4, #0x10
	bl FontAnimator__Init
	add r0, r4, #0x138
	bl FontWindowMWControl__Init
	mov r0, #0
	add r1, r4, #0x18c
	mov r2, #0x64
	bl MIi_CpuClear16
	bl _ZN10HubControl17GetFileFrom_ViMsgEv
	str r0, [r4, #0x1f0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__Release(CViSailPrompt *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ViSailPrompt__ReleaseGraphics
	mov r0, r4
	bl ViSailPrompt__ResetDisplay
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__ResetDisplay(CViSailPrompt *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr ip, =_ZN10HubControl12Func_215A96CEv
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__ReleaseGraphics(CViSailPrompt *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x18c
	bl AnimatorSprite__Release
	add r0, r4, #0x138
	bl FontWindowMWControl__Release
	add r0, r4, #0x10
	bl FontAnimator__Release
	add r0, r4, #0xd4
	bl FontWindowAnimator__Release
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__Main(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x28
	bl GetCurrentTaskWork_
	mov r4, r0
	bl ViSailPrompt__CheckTrainingDisabled
	cmp r0, #0
	movne r5, #6
	moveq r5, #8
	bl _ZN10HubControl10GetField54Ev
	mov lr, #2
	str lr, [sp]
	mov r1, #4
	str r1, [sp, #4]
	mov r2, #0
	mov r1, r0
	mov r3, r5, lsl #0x10
	str r2, [sp, #8]
	mov r0, #0x18
	str r0, [sp, #0xc]
	mov r0, r3, lsr #0x10
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	str lr, [sp, #0x18]
	mov r0, #3
	str r0, [sp, #0x1c]
	mov ip, #0x3c0
	str ip, [sp, #0x20]
	add ip, ip, #0x3f
	mov r3, r2
	add r0, r4, #0xd4
	str ip, [sp, #0x24]
	bl FontWindowAnimator__Load1
	add r0, r4, #0xd4
	bl FontWindowAnimator__SetWindowClosed
	mov r3, #0
	add r0, r4, #0xd4
	mov r1, #1
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0xd4
	bl FontWindowAnimator__StartAnimating
	add r0, r4, #0xd4
	bl FontWindowAnimator__Draw
	ldr r0, =ViSailPrompt__Main_2168E40
	bl SetCurrentTaskMainEvent
	mov r0, #4
	bl PlayHubSfx
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__Main_2168E40(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x1c
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r0, #1
	bl ViSailPrompt__Func_21695E4
	add r0, r4, #0xd4
	bl FontWindowAnimator__Draw
	add r0, r4, #0xd4
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r4, #0xd4
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r3, r4, pc}
	add r0, r4, #0xd4
	bl FontWindowAnimator__SetWindowOpen
	bl _ZN10HubControl10GetField54Ev
	mov r2, #1
	mov r1, r0
	str r2, [sp]
	mov r0, #0x16
	str r0, [sp, #4]
	mov r0, #6
	str r0, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	mov r0, #3
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	mov ip, #0x80
	add r0, r4, #0x10
	mov r3, #5
	str ip, [sp, #0x18]
	bl FontAnimator__LoadFont1
	add r0, r4, #0x10
	bl FontAnimator__LoadPaletteFunc
	add r0, r4, #0x10
	bl FontAnimator__LoadMappingsFunc
	ldr r0, [r4, #0x1f0]
	mov r1, #0
	bl FileUnknown__GetAOUFile
	mov r1, r0
	add r0, r4, #0x10
	bl FontAnimator__LoadMPCFile
	bl ViSailPrompt__CheckTrainingDisabled
	cmp r0, #0
	add r0, r4, #0x10
	beq _02168F10
	mov r1, #1
	bl FontAnimator__SetMsgSequence
	b _02168F18
_02168F10:
	mov r1, #0
	bl FontAnimator__SetMsgSequence
_02168F18:
	add r0, r4, #0x10
	mov r1, #1
	mov r2, #0
	bl FontAnimator__InitStartPos
	add r0, r4, #0x10
	bl FontAnimator__ClearPixels
	add r0, r4, #0x10
	bl FontAnimator__Draw
	ldr r0, =ViSailPrompt__Main_2168F4C
	bl SetCurrentTaskMainEvent
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__Main_2168F4C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r0, #1
	bl ViSailPrompt__Func_2169638
	add r0, r4, #0x10
	mov r1, #1
	bl FontAnimator__LoadCharacters
	add r0, r4, #0xd4
	bl FontWindowAnimator__Draw
	add r0, r4, #0x10
	bl FontAnimator__Draw
	add r0, r4, #0x10
	bl FontAnimator__IsEndOfLine
	cmp r0, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, pc}
	bl _ZN10HubControl10GetField54Ev
	mov r1, #0xb0
	str r1, [sp]
	mov r2, #0x10
	mov r1, r0
	str r2, [sp, #4]
	mov r2, #0
	str r2, [sp, #8]
	mov r3, #1
	str r3, [sp, #0xc]
	str r2, [sp, #0x10]
	mov r5, #0xc
	add r0, r4, #0x138
	str r5, [sp, #0x14]
	bl FontWindowMWControl__Load
	mov r0, #0xb
	bl _ZN10HubControl17GetFileFrom_ViActEt
	mov r1, #0
	mov r5, r0
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, r5
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r3, =0x05000200
	add r0, r4, #0x18c
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r3, #4
	bl AnimatorSprite__Init
	mov r1, #0xd
	add r0, r4, #0x100
	strh r1, [r0, #0xdc]
	add r0, r4, #0x18c
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	bl ViSailPrompt__CheckTrainingDisabled
	cmp r0, #0
	bne _02169064
	ldr r0, [r4, #0]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ViSailPrompt__Func_21696F0
	cmp r0, #0
	bne _02169070
_02169064:
	mov r0, #0
	strh r0, [r4, #4]
	b _02169098
_02169070:
	ldr r0, [r4, #0]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ViSailPrompt__Func_2169754
	bl SaveGame__Func_205BF78
	cmp r0, #0
	movne r0, #0
	strneh r0, [r4, #4]
	moveq r0, #1
	streqh r0, [r4, #4]
_02169098:
	add r0, r4, #0x10
	mov r1, #0
	bl FontAnimator__GetDialogLineCount
	strh r0, [r4, #6]
	ldr r1, =0x0000FFFF
	ldr r0, =ViSailPrompt__Main_21690CC
	strh r1, [r4, #8]
	bl SetCurrentTaskMainEvent
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__Main_21690CC(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r6, =0x0000FFFF
	bl GetCurrentTaskWork_
	ldr r1, =padInput
	mov r4, r0
	ldrh r0, [r1, #8]
	mov r5, #0
	tst r0, #0x40
	beq _02169118
	ldrh r0, [r4, #4]
	ldr r1, =0x0000FFFF
	cmp r0, #0
	ldreqh r0, [r4, #6]
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	mov r0, #3
	strh r1, [r4, #8]
	bl PlayHubSfx
_02169118:
	ldr r0, =padInput
	ldrh r0, [r0, #8]
	tst r0, #0x80
	beq _0216915C
	ldrh r0, [r4, #6]
	ldrh r1, [r4, #4]
	sub r0, r0, #1
	cmp r1, r0
	movge r6, #0
	bge _0216914C
	add r0, r1, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
_0216914C:
	ldr r1, =0x0000FFFF
	mov r0, #3
	strh r1, [r4, #8]
	bl PlayHubSfx
_0216915C:
	ldr r0, =0x0000FFFF
	cmp r6, r0
	bne _021691BC
	mov r0, r4
	mov r1, #1
	bl ViSailPrompt__Func_21694F0
	ldr r1, =0x0000FFFF
	mov r6, r0
	cmp r6, r1
	strneh r6, [r4, #8]
	bne _021691BC
	ldrh r7, [r4, #8]
	cmp r7, r1
	beq _021691BC
	mov r0, r4
	mov r1, #0
	bl ViSailPrompt__Func_21694F0
	cmp r7, r0
	ldreqh r0, [r4, #4]
	cmpeq r7, r0
	bne _021691BC
	mov r5, #1
	mov r0, r5
	bl PlayHubSfx
_021691BC:
	ldrh r0, [r4, #6]
	cmp r6, r0
	bhs _021691EC
	ldrh r0, [r4, #4]
	cmp r6, r0
	beq _021691EC
	add r0, r4, #0x138
	strh r6, [r4, #4]
	bl FontWindowMWControl__ValidatePaletteAnim
	add r0, r4, #0x18c
	mov r1, #0
	bl AnimatorSprite__SetAnimation
_021691EC:
	ldr r0, =padInput
	ldrh r0, [r0, #4]
	tst r0, #1
	beq _02169208
	mov r5, #1
	mov r0, r5
	bl PlayHubSfx
_02169208:
	cmp r5, #0
	bne _02169284
	ldr r0, =padInput
	ldrh r0, [r0, #4]
	tst r0, #2
	beq _02169284
	bl ViSailPrompt__CheckTrainingDisabled
	cmp r0, #0
	ldrh r0, [r4, #4]
	beq _0216925C
	cmp r0, #1
	beq _0216924C
	mov r1, #1
	mov r0, #3
	strh r1, [r4, #4]
	bl PlayHubSfx
	b _02169284
_0216924C:
	mov r0, #2
	mov r5, #1
	bl PlayHubSfx
	b _02169284
_0216925C:
	cmp r0, #2
	beq _02169278
	mov r1, #2
	mov r0, #3
	strh r1, [r4, #4]
	bl PlayHubSfx
	b _02169284
_02169278:
	mov r0, #2
	mov r5, #1
	bl PlayHubSfx
_02169284:
	ldrh r2, [r4, #4]
	add r0, r4, #0x138
	mov r1, #0x28
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #0x13
	mov r2, r2, asr #0x10
	bl FontWindowMWControl__SetPosition
	add r0, r4, #0x138
	bl FontWindowMWControl__Draw
	add r3, r4, #0x100
	mov r0, #0x28
	strh r0, [r3, #0x94]
	ldrh r0, [r4, #4]
	mov r1, #0
	mov r2, r1
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #3
	add r6, r0, #8
	add r0, r4, #0x18c
	strh r6, [r3, #0x96]
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0xd4
	bl FontWindowAnimator__Draw
	add r0, r4, #0x10
	bl FontAnimator__Draw
	add r0, r4, #0x138
	bl FontWindowMWControl__CallWindowFunc2
	cmp r5, #0
	bne _02169308
	add r0, r4, #0x18c
	bl AnimatorSprite__DrawFrame
_02169308:
	cmp r5, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r2, #0
	add r0, r4, #0x138
	mov r1, #1
	str r2, [r4, #0xc]
	bl FontWindowMWControl__SetPaletteAnim
	ldr r0, =ViSailPrompt__Main_216933C
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__Main_216933C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x138
	bl FontWindowMWControl__Draw
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x18c
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0xd4
	bl FontWindowAnimator__Draw
	add r0, r4, #0x10
	bl FontAnimator__Draw
	add r0, r4, #0x138
	bl FontWindowMWControl__CallWindowFunc2
	ldr r0, [r4, #0xc]
	add r0, r0, #1
	cmp r0, #0x10
	addlo sp, sp, #4
	str r0, [r4, #0xc]
	ldmloia sp!, {r3, r4, pc}
	mov r0, #0
	bl ViSailPrompt__Func_2169638
	mov r3, #0
	add r0, r4, #0xd4
	mov r1, #4
	mov r2, #8
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r4, #0xd4
	bl FontWindowAnimator__StartAnimating
	ldr r0, =ViSailPrompt__Main_21693D0
	bl SetCurrentTaskMainEvent
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__Main_21693D0(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r0, #1
	bl ViSailPrompt__Func_21695E4
	add r0, r4, #0xd4
	bl FontWindowAnimator__Draw
	add r0, r4, #0xd4
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r4, #0xd4
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	bl ViSailPrompt__Func_21695E4
	add r0, r4, #0xd4
	bl FontWindowAnimator__SetWindowClosed
	ldr r0, =ViSailPrompt__Main_2169424
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__Main_2169424(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0xd4
	bl FontWindowAnimator__SetWindowOpen
	bl ViSailPrompt__CheckTrainingDisabled
	cmp r0, #0
	ldrh r0, [r4, #4]
	beq _02169478
	cmp r0, #0
	bne _02169464
	mov r0, #1
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	ldr r0, [r4, #0]
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	b _021694D8
_02169464:
	mov r0, #0
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	mov r0, #0
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	b _021694D8
_02169478:
	cmp r0, #0
	beq _0216948C
	cmp r0, #1
	beq _021694A0
	b _021694C8
_0216948C:
	mov r0, #1
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	ldr r0, [r4, #0]
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	b _021694D8
_021694A0:
	mov r0, #2
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	ldr r0, [r4, #0]
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	ldr r0, [r4, #0]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ViSailPrompt__Func_2169754
	bl SaveGame__Func_205BF5C
	b _021694D8
_021694C8:
	mov r0, #0
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	mov r0, #0
	bl _ZN14CViDockNpcTalk12SetSelectionEl
_021694D8:
	bl DestroyCurrentTask
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__Destructor(Task *task)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	bl ViSailPrompt__Release
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC s32 ViSailPrompt__Func_21694F0(CViSailPrompt *work, BOOL usePull)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	cmp r1, #0
	beq _02169540
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02169520
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	movne r0, #1
	bne _02169524
_02169520:
	mov r0, #0
_02169524:
	cmp r0, #0
	ldreq r0, =0x0000FFFF
	ldmeqia sp!, {r4, pc}
	ldr r0, =touchInput
	ldrh r1, [r0, #0x1c]
	ldrh ip, [r0, #0x1e]
	b _0216957C
_02169540:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02169560
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #8
	movne r0, #1
	bne _02169564
_02169560:
	mov r0, #0
_02169564:
	cmp r0, #0
	ldreq r0, =0x0000FFFF
	ldmeqia sp!, {r4, pc}
	ldr r0, =touchInput
	ldrh r1, [r0, #0x20]
	ldrh ip, [r0, #0x22]
_0216957C:
	ldrh r4, [r4, #6]
	mov r2, #0
	cmp r4, #0
	ble _021695D4
	sub r0, r1, #0x28
	mov r0, r0, lsl #0x10
	mov r3, #1
	mov r1, r0, lsr #0x10
_0216959C:
	cmp r1, #0xb0
	mov r0, r3, lsl #0x13
	bhs _021695C4
	sub r0, ip, r0, lsr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #0x10
	movlo r0, r2, lsl #0x10
	movlo r0, r0, lsr #0x10
	ldmloia sp!, {r4, pc}
_021695C4:
	add r2, r2, #1
	cmp r2, r4
	add r3, r3, #2
	blt _0216959C
_021695D4:
	ldr r0, =0x0000FFFF
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__Func_21695E4(BOOL enabled)
{
#ifdef NON_MATCHING

#else
// clang-format off
	cmp r0, #0
	mov r2, #0x4000000
	beq _02169614
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #4
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
_02169614:
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	bic r0, r3, #4
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__Func_2169638(BOOL enabled)
{
#ifdef NON_MATCHING

#else
// clang-format off
	cmp r0, #0
	mov r2, #0x4000000
	beq _02169668
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #8
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
_02169668:
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	bic r0, r3, #8
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__Func_216968C(CViSailPrompt *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr ip, =MIi_CpuClear32
	ldr r0, =0x03FF03FF
	ldr r1, =0x06000800
	mov r2, #0x800
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void ViSailPrompt__Func_21696AC(CViSailPrompt *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, =0x06007FE0
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	mov r0, #0
	mov r1, #0x6000000
	mov r2, #0x600
	bl MIi_CpuClearFast
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL ViSailPrompt__CheckTrainingDisabled()
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl SaveGame__GetGameProgress
	cmp r0, #3
	movlt r0, #1
	movge r0, #0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL ViSailPrompt__Func_21696F0(s32 a1)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SaveGame__GetGameProgress
	cmp r4, #5
	addls pc, pc, r4, lsl #2
	b _0216974C
_02169708: // jump table
	b _0216974C // case 0
	b _0216974C // case 1
	b _0216974C // case 2
	b _02169720 // case 3
	b _02169730 // case 4
	b _02169740 // case 5
_02169720:
	cmp r0, #0xb
	bge _0216974C
	mov r0, #1
	ldmia sp!, {r4, pc}
_02169730:
	cmp r0, #0x18
	bge _0216974C
	mov r0, #1
	ldmia sp!, {r4, pc}
_02169740:
	cmp r0, #0x1c
	movlt r0, #1
	ldmltia sp!, {r4, pc}
_0216974C:
	mov r0, #0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC s32 ViSailPrompt__Func_2169754(s32 a1)
{
#ifdef NON_MATCHING

#else
// clang-format off
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02169798
_02169760: // jump table
	b _02169798 // case 0
	b _02169798 // case 1
	b _02169778 // case 2
	b _02169780 // case 3
	b _02169788 // case 4
	b _02169790 // case 5
_02169778:
	mov r0, #0
	bx lr
_02169780:
	mov r0, #1
	bx lr
_02169788:
	mov r0, #2
	bx lr
_02169790:
	mov r0, #3
	bx lr
_02169798:
	mov r0, #0
	bx lr

// clang-format on
#endif
}