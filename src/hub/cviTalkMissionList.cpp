#include <hub/cviTalkMissionList.hpp>
#include <hub/hubControl.hpp>
#include <hub/hubAudio.h>
#include <hub/dockHelpers.h>
#include <hub/missionHelpers.h>
#include <hub/cviDockNpcTalk.hpp>
#include <game/save/saveGame.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/file/fileUnknown.h>
#include <game/graphics/unknown2056570.h>
#include <game/text/mpc.h>

// --------------------
// TEMP
// --------------------

extern "C"
{

NOT_DECOMPILED void _ZN10HubControl12Func_215A888Ev(void);
NOT_DECOMPILED void _ZN10HubControl17GetFileFrom_ViMsgEv(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215A96CEv(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalkC1Ev(void);
NOT_DECOMPILED void _ZN10HubControl17GetFileFrom_ViActEt(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215AB84Ev(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalk7SetPageEt(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalk9GetActionEv(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalk7ReleaseEv(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalkD1Ev(void);
NOT_DECOMPILED void _ZN10HubControl16GetFileFrom_ViBGEt(void);
NOT_DECOMPILED void _ZN10HubControl12Func_215A9D8Ev(void);
NOT_DECOMPILED void _ZN10HubControl20GetFileFrom_ViActLocEt(void);
NOT_DECOMPILED void _ZN10HubControl17GetTKDMNameSpriteEv(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalk4InitEPvtt(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalk10IsFinishedEv(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalk12GetSelectionEv(void);
NOT_DECOMPILED void _ZN14CViDockNpcTalk12SetSelectionEl(void);
NOT_DECOMPILED void _ZN14CViDockNpcTalk13SetTalkActionEm(void);
NOT_DECOMPILED void _ZN13CViEvtCmnTalk13ProcessDialogEv(void);
NOT_DECOMPILED void _ZN10HubControl21GetFileFrom_ViMsgCtrlEv(void);
NOT_DECOMPILED void _ZN10HubControl10GetField54Ev(void);
NOT_DECOMPILED void _ZdlPv(void);
NOT_DECOMPILED void _ZnwmPv(void);

}

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED void *ovl05_021731A5;
NOT_DECOMPILED void *ovl05_02173198;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC void ViTalkMissionList__Create(s32 param)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r4, =0x00001010
	mov r2, #0
	ldr r0, =ViTalkMissionList__Main
	ldr r1, =ViTalkMissionList__Destructor
	mov r3, r2
	str r4, [sp]
	mov r4, #0x10
	str r4, [sp, #4]
	bl ViTalkMissionList__CreateInternal
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x118
	add r0, r0, #0xc00
	mov r1, #0x800
	bl InitThreadWorker
	add r0, r4, #0x118
	ldr r1, =ViTalkMissionList__ThreadFunc
	add r0, r0, #0xc00
	mov r2, r4
	mov r3, #0x14
	bl CreateThreadWorker
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__CreateInternal(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	ldrh r4, [sp, #0x18]
	ldrb lr, [sp, #0x1c]
	ldr ip, =0x00000DE4
	stmia sp, {r4, lr}
	str ip, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	bl GetTaskWork_
	mov r1, r0
	ldr r0, =0x00000DE4
	bl _ZnwmPv
	cmp r0, #0
	beq _0216A258
	bl _ZN13CViEvtCmnTalkC1Ev
_0216A258:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__ThreadFunc(void *arg)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl _ZN10HubControl17GetFileFrom_ViMsgEv
	mov r1, #0xf
	bl FileUnknown__GetAOUFile
	str r0, [r4, #0x4b8]
	bl MPC__GetSequenceCount
	mov r1, #3
	bl FX_DivS32
	add r1, r4, #0x400
	strh r0, [r1, #0xbc]
	ldrh r3, [r1, #0xbc]
	mov r2, #0
	mov r0, r4
	sub r3, r3, #1
	strh r3, [r1, #0xbc]
	strh r2, [r1, #0xbe]
	str r2, [r4, #0x4c0]
	str r2, [r4, #0x4c4]
	bl ViTalkMissionList__InitDisplay
	mov r0, r4
	bl ViTalkMissionList__InitSprites
	mov r0, r4
	bl ViTalkMissionList__InitList
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__InitDisplay(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl _ZN10HubControl12Func_215A888Ev
	bl _ZN10HubControl12Func_215A9D8Ev
	mov r0, #0
	mov r1, r0
	bl ViTalkMissionList__InitWindow
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__InitSprites(CViTalkMissionList *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x24
	mov r7, r0
	mvn r0, #0
	str r0, [r7, #0x4d0]
	str r0, [r7, #0x4d4]
	str r0, [r7, #0x4d8]
	mov r1, #0
	add r0, r7, #0x4e0
	str r1, [r7, #0x4dc]
	bl FontWindowAnimator__Init
	bl _ZN10HubControl10GetField54Ev
	mov r3, #2
	mov r1, r0
	str r3, [sp]
	mov r0, #3
	stmib sp, {r0, r3}
	mov r0, #0x1a
	str r0, [sp, #0xc]
	mov r0, #0x15
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	mov r2, #0
	str r0, [sp, #0x18]
	mov r0, #0xf
	str r0, [sp, #0x1c]
	mov r3, r2
	add r0, r7, #0x4e0
	str r2, [sp, #0x20]
	bl FontWindowAnimator__Load2
	add r0, r7, #0x144
	add r0, r0, #0x400
	bl FontAnimator__Init
	bl _ZN10HubControl10GetField54Ev
	mov r3, #5
	mov r1, r0
	str r3, [sp]
	mov r0, #0x16
	str r0, [sp, #4]
	mov r0, #0xc
	str r0, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	mov r0, #3
	str r0, [sp, #0x10]
	mov r2, #0
	str r2, [sp, #0x14]
	mov r0, #0x80
	str r0, [sp, #0x18]
	add r0, r7, #0x144
	add r0, r0, #0x400
	bl FontAnimator__LoadFont1
	add r0, r0, #0x80
	mov r4, r0, lsl #0x10
	add r0, r7, #0x144
	ldr r1, [r7, #0x4b8]
	add r0, r0, #0x400
	bl FontAnimator__LoadMPCFile
	mov r0, #0x60
	bl _AllocHeadHEAP_USER
	str r0, [r7, #0x638]
	mov r0, #5
	str r0, [sp]
	mov r2, #3
	str r2, [sp, #4]
	str r2, [sp, #8]
	mov r1, #1
	str r1, [sp, #0xc]
	ldr r0, [r7, #0x638]
	mov r3, #0
	str r0, [sp, #0x10]
	add r0, r7, #0x208
	mov r4, r4, lsr #0xb
	str r3, [sp, #0x14]
	add r0, r0, #0x400
	str r4, [sp, #0x18]
	bl Unknown2056570__Init
	add r0, r7, #0x208
	add r0, r0, #0x400
	mov r1, #1
	bl Unknown2056570__Func_2056688
	add r0, r7, #0x208
	add r0, r0, #0x400
	bl Unknown2056570__Func_205683C
	mov r0, #5
	bl _ZN10HubControl16GetFileFrom_ViBGEt
	bl GetBackgroundPalette
	add r0, r0, #4
	ldr r1, =0x05000420
	mov r2, #0x20
	bl MIi_CpuCopy16
	mov r0, #1
	bl _ZN10HubControl17GetFileFrom_ViActEt
	mov r6, r0
	mov r0, #0
	bl _ZN10HubControl20GetFileFrom_ViActLocEt
	mov r8, r0
	mov r0, #0xd
	bl _ZN10HubControl17GetFileFrom_ViActEt
	mov r5, r0
	bl _ZN10HubControl17GetTKDMNameSpriteEv
	mov r4, r0
	mov r0, r8
	mov r1, #4
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r1, r8
	mov ip, #1
	str ip, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr r2, =0x05000600
	mov r0, #6
	str r2, [sp, #0x10]
	str ip, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r7, #0x23c
	add r0, r0, #0x400
	mov r2, #4
	bl AnimatorSprite__Init
	mov r1, #0xc
	add r0, r7, #0x600
	strh r1, [r0, #0x8c]
	mov r0, r6
	mov r1, #4
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r2, #1
	str r2, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr r1, =0x05000600
	mov r0, #8
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r7, #0x6a0
	mov r1, r6
	mov r2, #4
	bl AnimatorSprite__Init
	mov r0, r6
	add r2, r7, #0x600
	mov r3, #0xd
	mov r1, #5
	strh r3, [r2, #0xf0]
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov ip, #1
	str ip, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r2, =0x05000600
	str r3, [sp, #0xc]
	str r2, [sp, #0x10]
	mov r0, #8
	str ip, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r7, #0x304
	mov r1, r6
	add r0, r0, #0x400
	mov r2, #5
	bl AnimatorSprite__Init
	mov r1, #0xd
	add r0, r7, #0x700
	strh r1, [r0, #0x54]
	mov r0, r4
	bl Sprite__GetSpriteSize3
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r1, r4
	mov r4, #1
	str r4, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r3, =0x05000600
	str r2, [sp, #0xc]
	str r3, [sp, #0x10]
	mov r0, #6
	str r4, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r7, #0x368
	add r0, r0, #0x400
	mov r3, r2
	bl AnimatorSprite__Init
	mov r1, #0xe
	add r0, r7, #0x700
	strh r1, [r0, #0xb8]
	mov r0, r5
	bl Sprite__GetSpriteSize3
	mov r1, r0
	mov r0, r4
	bl VRAMSystem__AllocSpriteVram
	mov r3, r4
	str r3, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r1, =0x05000600
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	str r3, [sp, #0x14]
	mov r0, #6
	str r0, [sp, #0x18]
	add r0, r7, #0x3cc
	add r0, r0, #0x400
	mov r1, r5
	mov r3, r2
	bl AnimatorSprite__Init
	mov r0, r5
	add r2, r7, #0x800
	mov r3, #0xf
	mov r1, #0
	strh r3, [r2, #0x1c]
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, r4
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0
	str r4, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =0x05000600
	str r2, [sp, #0xc]
	str r0, [sp, #0x10]
	str r4, [sp, #0x14]
	mov r4, #7
	mov r1, r5
	mov r3, r2
	add r0, r7, #0x830
	str r4, [sp, #0x18]
	bl AnimatorSprite__Init
	add r0, r7, #0x800
	mov r1, #1
	strh r1, [r0, #0x80]
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__InitList(CViTalkMissionList *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2c
	mov r11, r0
	add r0, r11, #0x400
	ldrh r0, [r0, #0xbc]
	mov r0, r0, lsl #2
	bl _AllocHeadHEAP_SYSTEM
	str r0, [r11, #0xd14]
	add r4, r11, #0x400
	ldrh r0, [r4, #0xbc]
	mov r6, #0
	cmp r0, #0
	ble _0216A7A4
	mov r8, r6
	mov r9, r6
_0216A714:
	mov r0, r6, lsl #0x10
	ldr r5, [r11, #0xd14]
	mov r0, r0, lsr #0x10
	add r7, r5, r8
	bl MissionHelpers__GetMissionFromSelection_REAL
	mov r1, #0
	strh r1, [r5, r8]
	mov r10, r0
	bl MissionHelpers__IsMissionUnlocked
	cmp r0, #0
	ldreqh r0, [r4, #0xbc]
	addeq r0, r0, r0, lsl #1
	streqh r0, [r7, #2]
	beq _0216A75C
	ldrh r0, [r7, #0]
	orr r0, r0, #1
	strh r0, [r7]
	strh r9, [r7, #2]
_0216A75C:
	mov r0, r10
	bl MissionHelpers__GetMissionAttempted
	cmp r0, #1
	ldreqh r0, [r7, #0]
	orreq r0, r0, #2
	streqh r0, [r7]
	mov r0, r10
	bl MissionHelpers__IsMissionComplete
	cmp r0, #1
	ldreqh r0, [r7, #0]
	add r6, r6, #1
	add r8, r8, #4
	orreq r0, r0, #4
	streqh r0, [r7]
	ldrh r0, [r4, #0xbc]
	add r9, r9, #3
	cmp r6, r0
	blt _0216A714
_0216A7A4:
	bl _ZN10HubControl10GetField54Ev
	str r0, [sp]
	ldr r0, [r11, #0x4b8]
	add r1, r11, #0x400
	str r0, [sp, #4]
	ldr r2, [r11, #0xd14]
	mov r0, #0
	str r2, [sp, #8]
	ldrh r2, [r1, #0xbc]
	mov r1, #3
	strh r2, [sp, #0xc]
	strh r0, [sp, #0xe]
	strh r1, [sp, #0x22]
	bl _ZN10HubControl20GetFileFrom_ViActLocEt
	str r0, [sp, #0x10]
	mov r0, #3
	bl _ZN10HubControl17GetFileFrom_ViActEt
	str r0, [sp, #0x14]
	mov r0, #5
	bl _ZN10HubControl17GetFileFrom_ViActEt
	str r0, [sp, #0x18]
	mov r0, #0xb
	bl _ZN10HubControl17GetFileFrom_ViActEt
	mov r1, #0
	mov r2, #5
	strh r1, [sp, #0x24]
	mov r3, #4
	strh r2, [sp, #0x20]
	mov r2, #2
	add r1, r11, #0x94
	str r0, [sp, #0x1c]
	add r0, r1, #0x800
	strh r3, [sp, #0x26]
	strh r2, [sp, #0x28]
	bl NpcUnknown__Func_216EDCC
	add r0, r11, #0x94
	add r1, sp, #0
	add r0, r0, #0x800
	bl NpcUnknown__Func_216EDF8
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__Release(CViTalkMissionList *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ViTalkMissionList__Func_216B418
	add r0, r4, #0x118
	add r0, r0, #0xc00
	bl ReleaseThreadWorker
	mov r0, r4
	bl ViTalkMissionList__ReleaseList
	mov r0, r4
	bl ViTalkMissionList__ReleaseGraphics
	mov r0, r4
	bl ViTalkMissionList__ResetDisplay
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__ResetDisplay(CViTalkMissionList *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	bl _ZN10HubControl12Func_215A96CEv
	bl _ZN10HubControl12Func_215AB84Ev
	mov r0, #0
	mov r1, r0
	bl ViTalkMissionList__InitWindow
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__ReleaseGraphics(CViTalkMissionList *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x830
	bl AnimatorSprite__Release
	add r0, r4, #0x3cc
	add r0, r0, #0x400
	bl AnimatorSprite__Release
	add r0, r4, #0x368
	add r0, r0, #0x400
	bl AnimatorSprite__Release
	add r0, r4, #0x304
	add r0, r0, #0x400
	bl AnimatorSprite__Release
	add r0, r4, #0x6a0
	bl AnimatorSprite__Release
	add r0, r4, #0x23c
	add r0, r0, #0x400
	bl AnimatorSprite__Release
	add r0, r4, #0x208
	add r0, r0, #0x400
	bl Unknown2056570__Func_2056670
	ldr r0, [r4, #0x638]
	bl _FreeHEAP_USER
	add r0, r4, #0x144
	add r0, r0, #0x400
	bl FontAnimator__Release
	add r0, r4, #0x4e0
	bl FontWindowAnimator__Release
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__ReleaseList(CViTalkMissionList *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x94
	add r0, r0, #0x800
	bl NpcUnknown__Func_216EE98
	ldr r0, [r4, #0xd14]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_SYSTEM
	mov r0, #0
	str r0, [r4, #0xd14]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__Main(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x118
	add r0, r0, #0xc00
	bl IsThreadWorkerFinished
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _ZN10HubControl21GetFileFrom_ViMsgCtrlEv
	mov r1, #0xc
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldr r3, =0x0000FFFF
	mov r0, r4
	mov r2, #0
	bl _ZN13CViEvtCmnTalk4InitEPvtt
	mov r0, r4
	mov r1, #0
	bl _ZN13CViEvtCmnTalk7SetPageEt
	ldr r0, =ViTalkMissionList__Main_216A99C
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__Main_216A99C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl _ZN13CViEvtCmnTalk13ProcessDialogEv
	mov r0, r4
	bl _ZN13CViEvtCmnTalk10IsFinishedEv
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl _ZN13CViEvtCmnTalk7ReleaseEv
	mov r0, #0
	bl ViTalkMissionList__Func_216B4C4
	mov r0, #0
	bl ViTalkMissionList__Func_216B518
	mov r0, #0
	bl ViTalkMissionList__Func_216B570
	mov r0, #0
	bl ViTalkMissionList__Func_216B5C4
	add r0, r4, #0x94
	add r0, r0, #0x800
	mov r1, #0
	mov r2, #1
	bl NpcUnknown__Func_216EEC0
	mov r0, r4
	add r1, r4, #0x400
	ldrh r1, [r1, #0xbe]
	bl ViTalkMissionList__DrawBackground
	add r0, r4, #0x4e0
	bl FontWindowAnimator__Func_20599B4
	add r0, r4, #0x144
	add r0, r0, #0x400
	bl FontAnimator__LoadMappingsFunc
	add r0, r4, #0x144
	add r0, r0, #0x400
	bl FontAnimator__LoadPaletteFunc
	ldr r0, =ViTalkMissionList__Main_216AA38
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__Main_216AA38(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x94
	add r0, r0, #0x800
	bl NpcUnknown__Func_216EF50
	add r0, r4, #0x94
	add r0, r0, #0x800
	bl NpcUnknown__Func_216EF70
	add r1, r4, #0x400
	strh r0, [r1, #0xbe]
	ldrh r1, [r1, #0xbe]
	mov r0, r4
	bl ViTalkMissionList__DrawBackground
	mov r0, r4
	bl ViTalkMissionList__Draw
	add r0, r4, #0x94
	add r0, r0, #0x800
	bl NpcUnknown__Func_216EF80
	cmp r0, #0
	beq _0216AAE8
	mov r0, #1
	bl ViDock__Func_215E4BC
	add r0, r4, #0x94
	add r0, r0, #0x800
	bl NpcUnknown__Func_216EFDC
	ldr r1, =0x0000FFFF
	cmp r0, r1
	bne _0216AABC
	mov r0, r4
	sub r1, r1, #0x10000
	bl ViTalkMissionList__DrawBackground
	b _0216AADC
_0216AABC:
	add r0, r4, #0x94
	add r0, r0, #0x800
	bl NpcUnknown__Func_216EFDC
	cmp r0, #0x63
	bne _0216AADC
	mov r0, r4
	mvn r1, #0
	bl ViTalkMissionList__DrawBackground
_0216AADC:
	ldr r0, =ViTalkMissionList__Main_216AB10
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
_0216AAE8:
	add r0, r4, #0x94
	add r0, r0, #0x800
	bl NpcUnknown__Func_216EF78
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	bl ViDock__Func_215E4BC
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__Main_216AB10(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x94
	add r0, r0, #0x800
	bl NpcUnknown__Func_216EF50
	mov r0, r4
	bl ViTalkMissionList__Draw
	add r0, r4, #0x94
	add r0, r0, #0x800
	bl NpcUnknown__Func_216EFC0
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x94
	add r0, r0, #0x800
	bl NpcUnknown__Func_216EF88
	cmp r0, #0
	beq _0216AC20
	add r0, r4, #0x94
	add r0, r0, #0x800
	bl NpcUnknown__Func_216EFDC
	cmp r0, #0x63
	bne _0216ABE8
	mov r0, r4
	bl ViTalkMissionList__ReleaseThread
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, #0x63
	bl MissionHelpers__IsMissionBeaten
	cmp r0, #0
	beq _0216ABB0
	bl _ZN10HubControl21GetFileFrom_ViMsgCtrlEv
	mov r1, #1
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldr r3, =0x0000FFFF
	mov r0, r4
	mov r2, #0x19
	bl _ZN13CViEvtCmnTalk4InitEPvtt
	b _0216ABD0
_0216ABB0:
	bl _ZN10HubControl21GetFileFrom_ViMsgCtrlEv
	mov r1, #1
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldr r3, =0x0000FFFF
	mov r0, r4
	mov r2, #0x18
	bl _ZN13CViEvtCmnTalk4InitEPvtt
_0216ABD0:
	mov r0, r4
	mov r1, #0
	bl _ZN13CViEvtCmnTalk7SetPageEt
	ldr r0, =ViTalkMissionList__Main_216AD1C
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
_0216ABE8:
	bl _ZN10HubControl21GetFileFrom_ViMsgCtrlEv
	mov r1, #0xc
	bl FileUnknown__GetAOUFile
	mov r2, #1
	mov r1, r0
	mov r0, r4
	rsb r3, r2, #0x10000
	bl _ZN13CViEvtCmnTalk4InitEPvtt
	mov r0, r4
	mov r1, #0
	bl _ZN13CViEvtCmnTalk7SetPageEt
	ldr r0, =ViTalkMissionList__Main_216AC78
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
_0216AC20:
	mov r0, r4
	bl ViTalkMissionList__ReleaseThread
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _ZN10HubControl21GetFileFrom_ViMsgCtrlEv
	mov r1, #0xc
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldr r3, =0x0000FFFF
	mov r0, r4
	mov r2, #2
	bl _ZN13CViEvtCmnTalk4InitEPvtt
	mov r0, r4
	mov r1, #0
	bl _ZN13CViEvtCmnTalk7SetPageEt
	ldr r0, =ViTalkMissionList__Main_216AD94
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__Main_216AC78(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	bl ViTalkMissionList__Draw
	mov r0, r5
	bl _ZN13CViEvtCmnTalk13ProcessDialogEv
	mov r0, r5
	bl _ZN13CViEvtCmnTalk10IsFinishedEv
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl _ZN13CViEvtCmnTalk12GetSelectionEv
	mov r4, r0
	mov r0, r5
	bl _ZN13CViEvtCmnTalk7ReleaseEv
	cmp r4, #0
	beq _0216ACD0
	cmp r4, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	cmp r4, #2
	beq _0216ACF0
	ldmia sp!, {r3, r4, r5, pc}
_0216ACD0:
	mov r2, #1
	mov r0, r5
	sub r1, r2, #2
	str r2, [r5, #0x4c0]
	bl ViTalkMissionList__DrawBackground
	ldr r0, =ViTalkMissionList__Func_216AE2C
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, r4, r5, pc}
_0216ACF0:
	add r0, r5, #0x400
	ldrh r1, [r0, #0xbe]
	add r0, r5, #0x94
	add r0, r0, #0x800
	mov r2, #1
	bl NpcUnknown__Func_216EEC0
	ldr r0, =ViTalkMissionList__Main_216AA38
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__Main_216AD1C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl _ZN13CViEvtCmnTalk13ProcessDialogEv
	mov r0, r4
	bl _ZN13CViEvtCmnTalk10IsFinishedEv
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl _ZN13CViEvtCmnTalk9GetActionEv
	cmp r0, #0x10
	bne _0216AD5C
	mov r0, #1
	str r0, [r4, #0x4c4]
	bl DestroyCurrentTask
	ldmia sp!, {r4, pc}
_0216AD5C:
	add r0, r4, #0x400
	ldrh r1, [r0, #0xbe]
	add r0, r4, #0x94
	add r0, r0, #0x800
	mov r2, #1
	bl NpcUnknown__Func_216EEC0
	add r0, r4, #0x400
	ldrh r1, [r0, #0xbe]
	mov r0, r4
	bl ViTalkMissionList__DrawBackground
	ldr r0, =ViTalkMissionList__Main_216AA38
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__Main_216AD94(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	bl _ZN13CViEvtCmnTalk13ProcessDialogEv
	mov r0, r5
	bl _ZN13CViEvtCmnTalk10IsFinishedEv
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl _ZN13CViEvtCmnTalk12GetSelectionEv
	mov r4, r0
	mov r0, r5
	bl _ZN13CViEvtCmnTalk7ReleaseEv
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	cmp r4, #1
	beq _0216ADE4
	cmp r4, #2
	beq _0216ADF4
	ldmia sp!, {r3, r4, r5, pc}
_0216ADE4:
	mov r0, #0
	str r0, [r5, #0x4c0]
	bl DestroyCurrentTask
	ldmia sp!, {r3, r4, r5, pc}
_0216ADF4:
	add r0, r5, #0x400
	ldrh r1, [r0, #0xbe]
	add r0, r5, #0x94
	add r0, r0, #0x800
	mov r2, #1
	bl NpcUnknown__Func_216EEC0
	add r0, r5, #0x400
	ldrh r1, [r0, #0xbe]
	mov r0, r5
	bl ViTalkMissionList__DrawBackground
	ldr r0, =ViTalkMissionList__Main_216AA38
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__Func_216AE2C(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl ViTalkMissionList__Draw
	mov r0, r4
	bl ViTalkMissionList__ReleaseThread
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl DestroyCurrentTask
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__Destructor(Task *task)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x4c4]
	cmp r0, #0
	beq _0216AE9C
	mov r0, #0x63
	bl MissionHelpers__GetMissionAttempted
	cmp r0, #0
	beq _0216AE88
	mov r0, #0x63
	bl MissionHelpers__ResetMissionAttempted
_0216AE88:
	mov r0, #0xb
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	mov r0, #0x63
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	b _0216AEF0
_0216AE9C:
	ldr r0, [r4, #0x4c0]
	cmp r0, #0
	beq _0216AEE0
	add r0, r4, #0x400
	ldrh r0, [r0, #0xbe]
	bl MissionHelpers__GetMissionFromSelection_REAL
	mov r5, r0
	bl MissionHelpers__GetMissionAttempted
	cmp r0, #0
	beq _0216AECC
	mov r0, r5
	bl MissionHelpers__ResetMissionAttempted
_0216AECC:
	mov r0, #9
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	mov r0, r5
	bl _ZN14CViDockNpcTalk12SetSelectionEl
	b _0216AEF0
_0216AEE0:
	mov r0, #0
	bl _ZN14CViDockNpcTalk13SetTalkActionEm
	mov r0, #0
	bl _ZN14CViDockNpcTalk12SetSelectionEl
_0216AEF0:
	mov r0, r4
	bl ViTalkMissionList__Release
	mov r0, r6
	bl ViTalkMissionList__Func_216AF04
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__Func_216AF04(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x10]
	cmp r4, #0
	beq _0216AF28
	mov r0, r4
	bl _ZN13CViEvtCmnTalkD1Ev
	mov r0, r4
	bl _ZdlPv
_0216AF28:
	mov r0, #0
	str r0, [r5, #0x10]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__DrawBackground(CViTalkMissionList *work, s32 a2)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #4
	mov r9, r0
	ldr r0, [r9, #0x4d0]
	mov r8, r1
	cmp r0, r8
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	mvn r0, #0
	cmp r8, r0
	bne _0216AF70
	add r0, r9, #0x208
	add r0, r0, #0x400
	bl Unknown2056570__Func_205683C
	b _0216B008
_0216AF70:
	mov r0, #5
	bl _ZN10HubControl16GetFileFrom_ViBGEt
	bl GetBackgroundPixels
	add r4, r8, #1
	cmp r4, #0x64
	movge r4, #0x64
	add r7, r0, #4
	mov r0, r4
	mov r1, #0xa
	bl FX_ModS32
	mov r6, r0
	mov r0, r4
	mov r1, #0xa
	bl FX_DivS32
	mov r4, r0
	mov r1, #0xa
	bl FX_ModS32
	mov r5, r0
	mov r0, r4
	mov r1, #0xa
	bl FX_DivS32
	mov r4, r0
	add r0, r9, #0x208
	add r0, r0, #0x400
	bl Unknown2056570__Func_2056834
	mov r10, r0
	add r0, r7, r4, lsl #5
	mov r1, r10
	mov r2, #0x20
	bl MIi_CpuCopyFast
	add r0, r7, r5, lsl #5
	add r1, r10, #0x20
	mov r2, #0x20
	bl MIi_CpuCopyFast
	add r0, r7, r6, lsl #5
	add r1, r10, #0x40
	mov r2, #0x20
	bl MIi_CpuCopyFast
_0216B008:
	add r0, r9, #0x208
	add r0, r0, #0x400
	bl Unknown2056570__Func_2056B8C
	mvn r0, #0
	cmp r8, r0
	ldr r1, [r9, #0x4d0]
	bne _0216B058
	cmp r1, r0
	beq _0216B088
	mov r3, #0
	add r0, r9, #0x4e0
	mov r1, #4
	mov r2, #0xc
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r9, #0x4e0
	bl FontWindowAnimator__StartAnimating
	mov r0, #1
	str r0, [r9, #0x4dc]
	b _0216B088
_0216B058:
	cmp r1, r0
	bne _0216B088
	mov r3, #0
	add r0, r9, #0x4e0
	mov r1, #1
	mov r2, #0xc
	str r3, [sp]
	bl FontWindowAnimator__InitAnimation
	add r0, r9, #0x4e0
	bl FontWindowAnimator__StartAnimating
	mov r0, #1
	str r0, [r9, #0x4dc]
_0216B088:
	str r8, [r9, #0x4d0]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__Draw(CViTalkMissionList *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x1c
	ldr r3, =ovl05_02173198
	add ip, sp, #0xd
	mov r5, r0
	mov r2, #6
_0216B0AC:
	ldrb r1, [r3, #0]
	ldrb r0, [r3, #1]
	add r3, r3, #2
	strb r1, [ip]
	strb r0, [ip, #1]
	add ip, ip, #2
	subs r2, r2, #1
	bne _0216B0AC
	ldrb r0, [r3, #0]
	ldr r4, =ovl05_021731A5
	add r3, sp, #0
	strb r0, [ip]
	mov r2, #6
_0216B0E0:
	ldrb r1, [r4, #0]
	ldrb r0, [r4, #1]
	add r4, r4, #2
	strb r1, [r3]
	strb r0, [r3, #1]
	add r3, r3, #2
	subs r2, r2, #1
	bne _0216B0E0
	ldrb r1, [r4, #0]
	mvn r0, #0
	strb r1, [r3]
	ldr r1, [r5, #0x4d8]
	cmp r1, r0
	beq _0216B150
	add r0, r5, #0x118
	add r0, r0, #0xc00
	bl IsThreadWorkerFinished
	cmp r0, #0
	beq _0216B150
	ldr r1, [r5, #0x4d8]
	add r0, r5, #0x400
	str r1, [r5, #0x4d4]
	ldrh r0, [r0, #0xbc]
	cmp r1, r0
	mvnhi r0, #0
	strhi r0, [r5, #0x4d4]
	mvn r0, #0
	str r0, [r5, #0x4d8]
_0216B150:
	ldr r2, [r5, #0x4d0]
	ldr r0, [r5, #0x4d4]
	cmp r2, r0
	bne _0216B1A0
	add r0, r5, #0x144
	add r0, r0, #0x400
	bl FontAnimator__Draw
	ldr r0, [r5, #0x4dc]
	cmp r0, #0
	bne _0216B188
	ldr r1, [r5, #0x4d0]
	mvn r0, #0
	cmp r1, r0
	bne _0216B194
_0216B188:
	mov r0, #0
	bl ViTalkMissionList__Func_216B5C4
	b _0216B1E4
_0216B194:
	mov r0, #1
	bl ViTalkMissionList__Func_216B5C4
	b _0216B1E4
_0216B1A0:
	ldr r1, [r5, #0x4d8]
	mvn r0, #0
	cmp r1, r0
	bne _0216B1E4
	cmp r2, r0
	strne r2, [r5, #0x4d8]
	bne _0216B1CC
	add r0, r5, #0x400
	ldrh r0, [r0, #0xbc]
	add r0, r0, #1
	str r0, [r5, #0x4d8]
_0216B1CC:
	add r0, r5, #0x118
	ldr r1, =ViTalkMissionList__Func_216B448
	mov r2, r5
	add r0, r0, #0xc00
	mov r3, #0x14
	bl CreateThreadWorker
_0216B1E4:
	ldr r0, [r5, #0x4dc]
	cmp r0, #0
	bne _0216B35C
	ldr r1, [r5, #0x4d4]
	mvn r0, #0
	cmp r1, r0
	beq _0216B35C
	mov r1, #0
	mov r2, r1
	add r0, r5, #0x6a0
	bl AnimatorSprite__ProcessAnimation
	add r0, r5, #0x6a0
	bl AnimatorSprite__DrawFrame
	add r0, r5, #0x304
	mov r1, #0
	mov r2, r1
	add r0, r0, #0x400
	bl AnimatorSprite__ProcessAnimation
	add r0, r5, #0x304
	add r0, r0, #0x400
	bl AnimatorSprite__DrawFrame
	ldr r2, [r5, #0x4d4]
	ldr r1, [r5, #0xd14]
	mov r0, r2, lsl #2
	ldrh r0, [r1, r0]
	tst r0, #1
	beq _0216B35C
	mov r0, r2, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MissionHelpers__GetUnknown2172B10
	add r1, r5, #0x368
	add r6, r1, #0x400
	mov r4, r0
	add r1, sp, #0xd
	ldrb r1, [r1, r4]
	ldrh r0, [r6, #0xc]
	cmp r0, r1
	beq _0216B284
	mov r0, r6
	bl AnimatorSprite__SetAnimation
_0216B284:
	mov r3, #0x84
	mov r1, #0
	strh r3, [r6, #8]
	mov r3, #0xa0
	mov r0, r6
	mov r2, r1
	strh r3, [r6, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	add r0, r5, #0x3cc
	add r1, sp, #0
	add r6, r0, #0x400
	ldrb r1, [r1, r4]
	ldrh r0, [r6, #0xc]
	cmp r0, r1
	beq _0216B2D0
	mov r0, r6
	bl AnimatorSprite__SetAnimation
_0216B2D0:
	mov r3, #0xbe
	mov r1, #0
	mov r0, r6
	mov r2, r1
	strh r3, [r6, #8]
	mov r3, #0x8a
	strh r3, [r6, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	add r4, r5, #0x830
	mov r3, #0xbe
	mov r1, #0
	mov r0, r4
	mov r2, r1
	strh r3, [r4, #8]
	mov r3, #0x8a
	strh r3, [r4, #0xa]
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	ldr r0, [r5, #0x4d4]
	ldr r1, [r5, #0xd14]
	mov r0, r0, lsl #2
	ldrh r0, [r1, r0]
	tst r0, #4
	beq _0216B35C
	add r0, r5, #0x23c
	mov r1, #0
	mov r2, r1
	add r0, r0, #0x400
	bl AnimatorSprite__ProcessAnimation
	add r0, r5, #0x23c
	add r0, r0, #0x400
	bl AnimatorSprite__DrawFrame
_0216B35C:
	ldr r0, [r5, #0x4dc]
	cmp r0, #0
	beq _0216B390
	add r0, r5, #0x4e0
	bl FontWindowAnimator__ProcessWindowAnim
	add r0, r5, #0x4e0
	bl FontWindowAnimator__IsFinishedAnimating
	cmp r0, #0
	beq _0216B390
	add r0, r5, #0x4e0
	bl FontWindowAnimator__SetWindowOpen
	mov r0, #0
	str r0, [r5, #0x4dc]
_0216B390:
	ldr r0, [r5, #0x4dc]
	cmp r0, #0
	bne _0216B3B8
	ldr r1, [r5, #0x4d0]
	mvn r0, #0
	cmp r1, r0
	ldrne r1, [r5, #0x4d4]
	cmpne r1, r0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r3, r4, r5, r6, pc}
_0216B3B8:
	add r0, r5, #0x4e0
	bl FontWindowAnimator__Draw
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL ViTalkMissionList__ReleaseThread(CViTalkMissionList *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x4d0]
	mvn r0, #0
	cmp r1, r0
	bne _0216B410
	add r0, r4, #0x118
	add r0, r0, #0xc00
	bl IsThreadWorkerFinished
	cmp r0, #0
	beq _0216B410
	ldr r0, [r4, #0x4dc]
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
_0216B410:
	mov r0, #0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__Func_216B418(CViTalkMissionList *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x4d8]
	mvn r0, #0
	cmp r1, r0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x118
	add r0, r0, #0xc00
	bl JoinThreadWorker
	mvn r0, #0
	str r0, [r4, #0x4d8]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__Func_216B448(CViTalkMissionList *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x400
	ldrh r3, [r0, #0xbc]
	ldr r2, [r4, #0x4d8]
	cmp r2, r3
	bhi _0216B4B4
	ldr r1, [r4, #0xd14]
	mov r0, r2, lsl #2
	ldrh r0, [r1, r0]
	tst r0, #1
	addne r0, r2, r2, lsl #1
	addeq r0, r3, r3, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add r1, r0, #1
	add r0, r4, #0x144
	mov r1, r1, lsl #0x10
	add r0, r0, #0x400
	mov r1, r1, lsr #0x10
	bl FontAnimator__SetMsgSequence
	add r0, r4, #0x144
	add r0, r0, #0x400
	mov r1, #0
	bl FontAnimator__LoadCharacters
	ldmia sp!, {r4, pc}
_0216B4B4:
	add r0, r4, #0x144
	add r0, r0, #0x400
	bl FontAnimator__ClearPixels
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__Func_216B4C4(BOOL enabled)
{
#ifdef NON_MATCHING

#else
// clang-format off
	cmp r0, #0
	mov r2, #0x4000000
	beq _0216B4F4
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #4
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
_0216B4F4:
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

NONMATCH_FUNC void ViTalkMissionList__Func_216B518(BOOL enabled)
{
#ifdef NON_MATCHING

#else
// clang-format off
	cmp r0, #0
	ldr r2, =0x04001000
	beq _0216B548
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #4
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
_0216B548:
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

NONMATCH_FUNC void ViTalkMissionList__Func_216B570(BOOL enabled)
{
#ifdef NON_MATCHING

#else
// clang-format off
	cmp r0, #0
	mov r2, #0x4000000
	beq _0216B5A0
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #0xa
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
_0216B5A0:
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	bic r0, r3, #0xa
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void ViTalkMissionList__Func_216B5C4(BOOL enabled)
{
#ifdef NON_MATCHING

#else
// clang-format off
	cmp r0, #0
	ldr r2, =0x04001000
	beq _0216B5F4
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #8
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bx lr
_0216B5F4:
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

NONMATCH_FUNC void ViTalkMissionList__InitWindow(CViTalkMissionList *work, s32 y)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	cmp r1, #0
	moveq r0, #0
	cmp r0, #0
	ldreq r0, =renderCoreGFXControlB
	moveq r1, #0
	streq r1, [r0, #0x1c]
	ldmeqia sp!, {r3, pc}
	ldr r0, =renderCoreGFXControlB
	mov r2, #0xff
	strb r2, [r0, #0x10]
	mov r2, #0
	strb r2, [r0, #0x11]
	strb r1, [r0, #0x14]
	strb r2, [r0, #0x15]
	ldrb r2, [r0, #0x18]
	mov r1, #1
	bic r2, r2, #1
	orr lr, r2, #1
	and r2, lr, #0xff
	orr r3, r2, #2
	bic ip, r3, #4
	and r2, ip, #0xff
	bic r3, r2, #8
	strb lr, [r0, #0x18]
	and r2, r3, #0xff
	strb ip, [r0, #0x18]
	orr r2, r2, #0x10
	strb r2, [r0, #0x18]
	ldrb r2, [r0, #0x1a]
	bic r2, r2, #1
	orr ip, r2, #1
	and r2, ip, #0xff
	orr r2, r2, #0x1e
	strb r2, [r0, #0x1a]
	str r1, [r0, #0x1c]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}