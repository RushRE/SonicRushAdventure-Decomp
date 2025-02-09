#include <hub/cviTalkPurchase.hpp>
#include <hub/cviSailPrompt.hpp>
#include <hub/hubControl.hpp>
#include <hub/hubAudio.h>
#include <hub/cviDockNpcTalk.hpp>
#include <game/save/saveGame.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/file/fileUnknown.h>
#include <game/text/fontAnimator.h>

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void _ZN10HubControl12Func_215B4E0Ev(void);
NOT_DECOMPILED void _ZN10HubControl17GetFileFrom_ViMsgEv(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215A96CEv(void);
NOT_DECOMPILED void _ZN10HubControl10GetField54Ev(void);
NOT_DECOMPILED void _ZN11NpcPurchase15ProcessGraphicsEv(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalk7SetPageEt(void);
NOT_DECOMPILED void _ZN11NpcPurchase11CloseWindowEv(void);
NOT_DECOMPILED void _ZN11NpcPurchase8IsActiveEv(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalkD1Ev(void);
NOT_DECOMPILED void _ZN11NpcPurchase7ReleaseEv(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215AB84Ev(void);
NOT_DECOMPILED void _ZN11NpcPurchase4LoadEtttttt(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215AAB4Ev(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalkC1Ev(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215A888Ev(void);
NOT_DECOMPILED void _ZN10HubControl17GetFileFrom_ViActEt(void);
NOT_DECOMPILED void _ZN11NpcPurchase4InitEv(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalk7ReleaseEv(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalk11SetCallbackEPFvmP13FontAnimator_PvES2_(void);
NOT_DECOMPILED void _ZN11NpcPurchase7IsReadyEv(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalk10IsFinishedEv(void);
NOT_DECOMPILED void _ZN11NpcPurchase7ProcessEv(void);
NOT_DECOMPILED void _ZN14CViDockNpcTalk12SetSelectionEl(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalk4InitEPvtt(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalk13ProcessDialogEv(void);
NOT_DECOMPILED void _ZN14CViDockNpcTalk13SetTalkActionEm(void);
NOT_DECOMPILED void _ZN10HubControl21GetFileFrom_ViMsgCtrlEv(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalk9GetActionEv(void);
NOT_DECOMPILED void _ZdlPv(void);
NOT_DECOMPILED void _ZnwmPv(void);
}

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED void *ovl05_02173190;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC void ViTalkPurchase__Create(s32 param)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r4, =0x00001010
	mov r5, r0
	mov r2, #0
	ldr r0, =ViTalkPurchase__Main
	ldr r1, =ViTalkPurchase__Destructor
	mov r3, r2
	str r4, [sp]
	mov r4, #0x10
	str r4, [sp, #4]
	bl ViTalkPurchase__CreateInternal
	bl GetTaskWork_
	mov r4, r0
	mov r0, #6
	str r0, [r4]
	mov r0, #4
	str r0, [r4, #4]
	mov r0, #9
	str r0, [r4, #8]
	mov r6, #0
	str r6, [r4, #0xc]
	cmp r5, #0
	bne _02169834
	bl _ZN10HubControl12Func_215B4E0Ev
	str r0, [r4]
	cmp r0, #5
	bge _0216981C
	bl ViTalkPurchase__CanPurchaseShipBuild
	str r0, [r4, #0x10]
	b _021698D0
_0216981C:
	bl SaveGame__GetGameProgress
	cmp r0, #0x10
	bne _021698D0
	bl ViTalkPurchase__CanPurchaseUnknown
	str r0, [r4, #0x10]
	b _021698D0
_02169834:
	cmp r5, #1
	bne _02169884
_0216983C:
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__Func_205D520
	cmp r0, #0
	beq _02169868
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SaveGame__GetBoughtInfo
	cmp r0, #0
	streq r6, [r4, #4]
	beq _02169874
_02169868:
	add r6, r6, #1
	cmp r6, #3
	blt _0216983C
_02169874:
	ldr r0, [r4, #4]
	bl ViTalkPurchase__CanPurchaseInfo
	str r0, [r4, #0x10]
	b _021698D0
_02169884:
	cmp r5, #2
	bne _021698B8
	add r0, sp, #0xa
	add r1, sp, #8
	bl SaveGame__GetNextShipUpgrade
	ldrh r1, [sp, #8]
	ldrh r0, [sp, #0xa]
	sub r1, r1, #1
	add r0, r1, r0, lsl #1
	str r0, [r4, #8]
	bl ViTalkPurchase__CanPurchaseShipUpgrade
	str r0, [r4, #0x10]
	b _021698D0
_021698B8:
	cmp r5, #3
	bne _021698D0
	mov r0, #1
	str r0, [r4, #0xc]
	bl SaveGame__CheckRingsForPurchase
	str r0, [r4, #0x10]
_021698D0:
	mov r0, r4
	bl ViTalkPurchase__InitDisplay
	add r0, r4, #0x130
	add r0, r0, #0x1000
	mov r1, #0x400
	bl InitThreadWorker
	add r0, r4, #0x130
	ldr r1, =ViTalkPurchase__ThreadFunc
	mov r2, r4
	add r0, r0, #0x1000
	mov r3, #0x14
	bl CreateThreadWorker
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkPurchase__CreateInternal(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	ldrh r4, [sp, #0x18]
	ldrb lr, [sp, #0x1c]
	ldr ip, =0x000011FC
	stmia sp, {r4, lr}
	str ip, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	bl GetTaskWork_
	mov r1, r0
	ldr r0, =0x000011FC
	bl _ZnwmPv
	cmp r0, #0
	beq _0216995C
	add r0, r0, #0x14
	bl _ZN13CViEvtCmnTalkC1Ev
_0216995C:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

void ViTalkPurchase__MakeTutorialPurchase(void)
{
    ViTalkPurchase__MakePurchase(HubConfig__GetShipBuildCost(SHIP_JET));
}

void ViTalkPurchase__ThreadFunc(void *arg)
{
    CViTalkPurchase *work = (CViTalkPurchase *)arg;

    ViTalkPurchase__InitSprites(work);
    ViTalkPurchase__InitNpcPurchase(work);
}

void ViTalkPurchase__InitDisplay(CViTalkPurchase *work)
{
    HubControl::Func_215A888();
    HubControl::Func_215AAB4();
}

NONMATCH_FUNC void ViTalkPurchase__InitSprites(CViTalkPurchase *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	mov r0, #7
	bl _ZN10HubControl17GetFileFrom_ViActEt
	mov r5, r0
	bl Sprite__GetSpriteSize1
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
	add r0, r4, #0xcc
	str r3, [sp, #0x10]
	add r0, r0, #0x400
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r3, r2
	bl AnimatorSprite__Init
	mov r1, #0x10
	add r0, r4, #0x400
	strh r1, [r0, #0xd4]
	mov r1, #0x20
	strh r1, [r0, #0xd6]
	mov r1, #8
	add r0, r4, #0x500
	strh r1, [r0, #0x1c]
	mov r0, #9
	bl _ZN10HubControl17GetFileFrom_ViActEt
	mov r5, r0
	bl Sprite__GetSpriteSize1
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
	add r0, r4, #0x530
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r3, r2
	bl AnimatorSprite__Init
	mov r1, #0x10
	add r0, r4, #0x500
	strh r1, [r0, #0x38]
	mov r1, #0x20
	strh r1, [r0, #0x3a]
	mov r1, #8
	strh r1, [r0, #0x80]
	mov r0, #3
	bl _ZN10HubControl17GetFileFrom_ViActEt
	mov r5, r0
	mov r1, #1
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r0, [sp, #8]
	add r0, r4, #0x194
	ldr r1, =0x05000200
	str r3, [sp, #0xc]
	str r1, [sp, #0x10]
	mov r1, r5
	str r3, [sp, #0x14]
	mov r2, #1
	add r0, r0, #0x400
	str r2, [sp, #0x18]
	bl AnimatorSprite__Init
	add r0, r4, #0x500
	mov r1, #8
	strh r1, [r0, #0x9c]
	mov r1, #0x18
	strh r1, [r0, #0x9e]
	mov r2, #9
	ldr r1, =0x0000FFFF
	strh r2, [r0, #0xe4]
	strh r1, [r0, #0xf8]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkPurchase__InitNpcPurchase(CViTalkPurchase *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	add r0, r4, #0x1fc
	add r0, r0, #0x400
	bl _ZN11NpcPurchase4InitEv
	mov r1, #3
	add r0, r4, #0x1fc
	mov r2, #0x3c0
	str r1, [sp]
	mov r1, #0xc
	str r1, [sp, #4]
	mov ip, #0xf
	add r0, r0, #0x400
	add r3, r2, #0x3f
	mov r1, #2
	str ip, [sp, #8]
	bl _ZN11NpcPurchase4LoadEtttttt
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

void ViTalkPurchase__Release(CViTalkPurchase *work)
{
    JoinThreadWorker(&work->threadWorker);
    ReleaseThreadWorker(&work->threadWorker);

    ViTalkPurchase__ReleaseNpcPurchase(work);
    ViTalkPurchase__ReleaseSprites(work);

    work->evtCmnTalk.Release();

    ViTalkPurchase__ResetDisplay(work);
}

void ViTalkPurchase__ResetDisplay(CViTalkPurchase *work)
{
    HubControl::Func_215A96C();
    HubControl::Func_215AB84();
}

void ViTalkPurchase__ReleaseSprites(CViTalkPurchase *work)
{
    AnimatorSprite__Release(&work->aniCostBackground);
    AnimatorSprite__Release(&work->aniRing);
    AnimatorSprite__Release(&work->aniMaterial);

    work->costType = -1;
}

void ViTalkPurchase__ReleaseNpcPurchase(CViTalkPurchase *work)
{
    work->npcPurchase.Release();
}

NONMATCH_FUNC void ViTalkPurchase__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x130
	add r0, r0, #0x1000
	bl IsThreadWorkerFinished
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #4]
	cmp r0, #3
	bge _02169C4C
	bl HubConfig__Func_2152B38
	mov r5, r0
	b _02169C9C
_02169C4C:
	ldr r0, [r4, #0]
	cmp r0, #5
	bge _02169C64
	bl HubConfig__Func_2152B1C
	mov r5, r0
	b _02169C9C
_02169C64:
	ldr r0, [r4, #8]
	cmp r0, #8
	bge _02169C7C
	bl HubConfig__Func_2152B48
	mov r5, r0
	b _02169C9C
_02169C7C:
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _02169C94
	bl HubConfig__Func_2152B58
	mov r5, r0
	b _02169C9C
_02169C94:
	bl HubConfig__Func_2152B2C
	mov r5, r0
_02169C9C:
	bl _ZN10HubControl21GetFileFrom_ViMsgCtrlEv
	ldrh r1, [r5, #0]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldrh r2, [r5, #2]
	ldr r3, =0x0000FFFF
	add r0, r4, #0x14
	bl _ZN13CViEvtCmnTalk4InitEPvtt
	ldr r1, =ViTalkPurchase__TalkCallback
	mov r2, r4
	add r0, r4, #0x14
	bl _ZN13CViEvtCmnTalk11SetCallbackEPFvmP13FontAnimator_PvES2_
	add r0, r4, #0x1fc
	add r0, r0, #0x400
	bl _ZN11NpcPurchase15ProcessGraphicsEv
	ldr r0, =ViTalkPurchase__Main_2169CF0
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkPurchase__Main_2169CF0(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x1fc
	add r0, r0, #0x400
	bl _ZN11NpcPurchase7ProcessEv
	add r0, r4, #0x1fc
	add r0, r0, #0x400
	bl _ZN11NpcPurchase7IsReadyEv
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x10]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	mov r1, r0, lsl #0x10
	add r0, r4, #0x14
	mov r1, r1, lsr #0x10
	bl _ZN13CViEvtCmnTalk7SetPageEt
	ldr r0, =ViTalkPurchase__Main_2169D4C
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkPurchase__Main_2169D4C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x14
	bl _ZN13CViEvtCmnTalk13ProcessDialogEv
	add r0, r4, #0x1fc
	add r0, r0, #0x400
	bl _ZN11NpcPurchase7ProcessEv
	add r0, r4, #0x500
	ldrh r1, [r0, #0xf8]
	ldr r0, =0x0000FFFF
	cmp r1, r0
	beq _02169DE0
	cmp r1, #9
	mov r1, #0
	bne _02169DA4
	mov r2, r1
	add r0, r4, #0x530
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x530
	bl AnimatorSprite__DrawFrame
	b _02169DC0
_02169DA4:
	add r0, r4, #0xcc
	mov r2, r1
	add r0, r0, #0x400
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0xcc
	add r0, r0, #0x400
	bl AnimatorSprite__DrawFrame
_02169DC0:
	add r0, r4, #0x194
	mov r1, #0
	mov r2, r1
	add r0, r0, #0x400
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0x194
	add r0, r0, #0x400
	bl AnimatorSprite__DrawFrame
_02169DE0:
	add r0, r4, #0x14
	bl _ZN13CViEvtCmnTalk10IsFinishedEv
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x1fc
	add r0, r0, #0x400
	bl _ZN11NpcPurchase11CloseWindowEv
	ldr r0, =ViTalkPurchase__Main_2169E10
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkPurchase__Main_2169E10(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x1fc
	add r0, r0, #0x400
	bl _ZN11NpcPurchase7ProcessEv
	add r0, r4, #0x1fc
	add r0, r0, #0x400
	bl _ZN11NpcPurchase8IsActiveEv
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, =ViTalkPurchase__Main_2169E4C
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkPurchase__Main_2169E4C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x14
	bl _ZN13CViEvtCmnTalk9GetActionEv
	cmp r0, #2
	beq _02169E7C
	cmp r0, #0x14
	beq _02169F1C
	cmp r0, #0x16
	beq _02169F58
	b _02169F88
_02169E7C:
	ldr r0, [r4, #4]
	cmp r0, #3
	bge _02169EB0
	bl HubConfig__GetInfoPurchaseCost
	bl ViTalkPurchase__MakePurchase
	mov r0, #6
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	ldr r1, [r4, #4]
	ldr r0, =ovl05_02173190
	mov r1, r1, lsl #1
	ldrh r0, [r0, r1]
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	b _02169F98
_02169EB0:
	ldr r0, [r4, #0]
	cmp r0, #5
	bge _02169ED8
	bl HubConfig__GetShipBuildCost
	bl ViTalkPurchase__MakePurchase
	mov r0, #4
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	ldr r0, [r4, #0]
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	b _02169F98
_02169ED8:
	ldr r0, [r4, #8]
	cmp r0, #8
	bge _02169F00
	bl HubConfig__GetShipUpgradeCost
	bl ViTalkPurchase__MakePurchase
	mov r0, #0x1d
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	ldr r0, [r4, #8]
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	b _02169F98
_02169F00:
	bl HubConfig__GetUnknownPurchaseCost
	bl ViTalkPurchase__MakePurchase
	mov r0, #6
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	mov r0, #7
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	b _02169F98
_02169F1C:
	ldr r0, [r4, #8]
	cmp r0, #8
	bge _02169F44
	bl HubConfig__GetShipUpgradeCost
	bl ViTalkPurchase__MakePurchase
	mov r0, #0x1d
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	ldr r0, [r4, #8]
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	b _02169F98
_02169F44:
	mov r0, #0
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	mov r0, #0
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	b _02169F98
_02169F58:
	mov r0, #0
	bl SaveGame__GetProgressFlags_0x100000
	cmp r0, #0
	bne _02169F74
	mov r0, #0
	bl SaveGame__SetProgressFlags_0x100000
	bl SaveGame__UseRingsForPurchase
_02169F74:
	mov r0, #0
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	mov r0, #0
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	b _02169F98
_02169F88:
	mov r0, #0
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	mov r0, #0
	bl _ZN14CViDockNpcTalk12SetSelectionEl
_02169F98:
	bl DestroyCurrentTask
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void ViTalkPurchase__Destructor(Task *task)
{
    CViTalkPurchase *work = TaskGetWork(task, CViTalkPurchase);

    ViTalkPurchase__Release(work);

    HubTaskDestroy<CViTalkPurchase>(task);
}

NONMATCH_FUNC void ViTalkPurchase__TalkCallback(CViTalkPurchase *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r1
	cmp r0, #0xa
	blo _0216A050
	cmp r0, #0x13
	bhi _0216A050
	sub r1, r0, #0xa
	add r0, r2, #0x500
	strh r1, [r0, #0xf8]
	ldrh r1, [r0, #0xf8]
	cmp r1, #9
	bne _0216A030
	add r0, r2, #0x530
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	b _0216A03C
_0216A030:
	add r0, r2, #0xcc
	add r0, r0, #0x400
	bl AnimatorSprite__SetAnimation
_0216A03C:
	mov r0, r4
	mov r1, #0
	mov r2, #0x30
	bl FontAnimator__InitStartPos
	ldmia sp!, {r4, pc}
_0216A050:
	cmp r0, #0x14
	ldmneia sp!, {r4, pc}
	ldr ip, =0x0000FFFF
	add r3, r2, #0x500
	mov r1, #0
	mov r0, r4
	mov r2, r1
	strh ip, [r3, #0xf8]
	bl FontAnimator__InitStartPos
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

BOOL ViTalkPurchase__CanPurchaseShipBuild(s32 id)
{
    return ViTalkPurchase__CanMakePurchase(HubConfig__GetShipBuildCost(id));
}

BOOL ViTalkPurchase__CanPurchaseUnknown(s32 id)
{
    return ViTalkPurchase__CanMakePurchase(HubConfig__GetUnknownPurchaseCost(id));
}

BOOL ViTalkPurchase__CanPurchaseInfo(s32 id)
{
    return ViTalkPurchase__CanMakePurchase(HubConfig__GetInfoPurchaseCost(id));
}

BOOL ViTalkPurchase__CanPurchaseShipUpgrade(s32 id)
{
    return ViTalkPurchase__CanMakePurchase(HubConfig__GetShipUpgradeCost(id));
}

u32 ViTalkPurchase__GetMaterialCount(u16 type)
{
    if (type < SAVE_MATERIAL_COUNT)
        return SaveGame__GetMaterialCount(&saveGame.stage, type);
    else
        return 0;
}

BOOL ViTalkPurchase__GetRingCount()
{
    return saveGame.stage.ringCount;
}

NONMATCH_FUNC BOOL ViTalkPurchase__CanMakePurchase(PurchaseCostConfig *config)
{
#ifdef NON_MATCHING
    if (config->ringCost > ViTalkPurchase__GetRingCount())
        return FALSE;

    for (s32 t = 0; t < SAVE_MATERIAL_COUNT; t++)
    {
        if (config->materialCost[t] > ViTalkPurchase__GetMaterialCount(t))
            return FALSE;
    }

    return TRUE;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl ViTalkPurchase__GetRingCount
	ldr r1, [r5, #0]
	cmp r1, r0
	movhi r0, #0
	ldmhiia sp!, {r3, r4, r5, pc}
	mov r4, #0
_0216A110:
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	bl ViTalkPurchase__GetMaterialCount
	add r1, r5, r4
	ldrb r1, [r1, #4]
	cmp r1, r0
	movgt r0, #0
	ldmgtia sp!, {r3, r4, r5, pc}
	add r4, r4, #1
	cmp r4, #9
	blt _0216A110
	mov r0, #1
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void ViTalkPurchase__MakePurchase(PurchaseCostConfig *config)
{
    if (config->ringCost != 0)
        saveGame.stage.ringCount -= config->ringCost;

    for (s32 t = 0; t < SAVE_MATERIAL_COUNT; t++)
    {
        if (config->materialCost[t] != 0)
            SaveGame__UseMaterial(&saveGame.stage, t, config->materialCost[t]);
    }
}