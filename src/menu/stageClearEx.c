#include <menu/stageClearEx.h>
#include <game/system/sysEvent.h>
#include <game/audio/audioSystem.h>
#include <game/audio/sysSound.h>
#include <game/graphics/screenShake.h>
#include <game/graphics/drawState.h>
#include <game/graphics/spriteUnknown.h>
#include <game/input/padInput.h>
#include <game/save/saveGame.h>
#include <game/stage/gameSystem.h>
#include <game/file/archiveFile.h>
#include <game/util/unknown204BE48.h>

#include <nitro/code16.h>

// --------------------
// VARIABLES
// --------------------

static Task *StageClearEx__Singleton;

NOT_DECOMPILED void *_02161514;
NOT_DECOMPILED void *_0216151C;
NOT_DECOMPILED void *_02161524;
NOT_DECOMPILED void *_02161548;

NOT_DECOMPILED void *aNarcPldm6700Lz;
NOT_DECOMPILED void *aNarcCldmExLz7N;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void _ull_mul(void);
NOT_DECOMPILED void _u32_div_f(void);

NONMATCH_FUNC void StageClearEx__Create(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {lr}
	sub sp, #0xc
	mov r0, #1
	str r0, [sp]
	mov r2, #0
	ldr r0, =0x00001178
	str r2, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =StageClearEx__Main_Core
	ldr r1, =StageClearEx__Destructor
	mov r3, r2
	bl TaskCreate_
	ldr r1, =StageClearEx__Singleton
	str r0, [r1]
	bl GetTaskWork_
	bl StageClearEx__Init
	add sp, #0xc
	pop {pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__Destructor(Task *task){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r0, =StageClearEx__Singleton
	mov r1, #0
	str r1, [r0]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__SetState(StageClearEx *work, void (*state)(StageClearEx *work)){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r2, #0
	str r2, [r0, #0xc]
	str r1, [r0, #8]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__CreateAnimationManager(StageClearEx *parent){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, lr}
	sub sp, #0xc
	mov r4, r0
	mov r1, #0
	mov r0, #0x61
	str r0, [sp]
	ldr r0, =0x00001178
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =StageClearEx__Main_AnimationManager
	mov r2, r1
	mov r3, r1
	bl TaskCreate_
	str r0, [r4]
	add sp, #0xc
	pop {r3, r4, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__CreateDrawManager(StageClearEx *parent){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, lr}
	sub sp, #0xc
	mov r4, r0
	mov r1, #0
	mov r0, #0x81
	str r0, [sp]
	ldr r0, =0x00001178
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =StageClearEx__Main_DrawManager
	mov r2, r1
	mov r3, r1
	bl TaskCreate_
	str r0, [r4, #4]
	add sp, #0xc
	pop {r3, r4, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__Init(StageClearEx *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r2, =0x00001178
	mov r0, #0
	mov r1, r5
	bl MIi_CpuClear32
	mov r2, #1
	lsl r2, r2, #0x1a
	ldr r1, [r2, #0]
	ldr r0, =0xFFFFE0FF
	and r1, r0
	str r1, [r2, #0]
	ldr r2, =0x04001000
	ldr r1, [r2, #0]
	and r0, r1
	str r0, [r2, #0]
	mov r0, #1
	mov r1, #0
	mov r2, r0
	bl GX_SetGraphicsMode
	mov r0, #0
	bl GXS_SetGraphicsMode
	bl VRAMSystem__Reset
	mov r0, #3
	bl VRAMSystem__SetupTextureBank
	mov r0, #0x40
	bl VRAMSystem__SetupTexturePalBank
	mov r0, #0x20
	bl VRAMSystem__SetupBGBank
	mov r0, #1
	lsl r0, r0, #0xa
	str r0, [sp]
	ldr r1, =0x00100010
	mov r0, #0x10
	mov r2, #0x40
	mov r3, #0
	bl VRAMSystem__SetupOBJBank
	mov r4, r5
	add r4, #0x14
	mov r0, r4
	bl StageClearEx__LoadArchives
	bl ReleaseAudioSystem
	mov r0, #0xf
	bl LoadSysSound
	mov r0, r5
	add r0, #0x1c
	mov r1, r4
	bl StageClearEx__InitGraphics3D
	ldr r0, =0x00000958
	mov r1, r4
	add r0, r5, r0
	bl StageClearEx__InitGraphics2D
	mov r0, #1
	str r0, [r5, #0x10]
	mov r0, r5
	bl StageClearEx__CreateAnimationManager
	ldr r1, =StageClearEx__State_21548C0
	mov r0, r5
	bl StageClearEx__SetState
	pop {r3, r4, r5, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__Destroy(StageClearEx *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0]
	cmp r0, #0
	beq _02153E22
	bl DestroyTask
_02153E22:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _02153E2C
	bl DestroyTask
_02153E2C:
	mov r0, #0
	str r0, [r4, #0x10]
	bl Camera3D__Destroy
	ldr r0, =0x00000958
	add r0, r4, r0
	bl StageClearEx__ReleaseGraphics2D
	mov r0, r4
	add r0, #0x1c
	bl StageClearEx__ReleaseGraphics3D
	bl ReleaseSysSound
	add r4, #0x14
	mov r0, r4
	bl StageClearEx__ReleaseAssets
	bl DestroyCurrentTask
	pop {r4, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__LoadArchives(StageClearExAssets *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, lr}
	sub sp, #4
	mov r2, #0
	mov r4, r0
	ldr r0, =aNarcPldm6700Lz
	str r2, [sp]
	sub r1, r2, #1
	mov r3, #1
	bl ArchiveFile__Load
	str r0, [r4]
	mov r2, #0
	ldr r0, =aNarcCldmExLz7N
	sub r1, r2, #1
	mov r3, #1
	str r2, [sp]
	bl ArchiveFile__Load
	str r0, [r4, #4]
	add sp, #4
	pop {r3, r4, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__ReleaseAssets(StageClearEx *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, lr}
	mov r4, r0
	ldr r0, [r4, #4]
	bl _FreeHEAP_USER
	ldr r0, [r4, #0]
	bl _FreeHEAP_USER
	pop {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__InitGraphics3D(StageClearExGraphics3D *work, StageClearExAssets *assets){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x20
	mov r5, r0
	mov r0, #1
	str r0, [sp]
	mov r0, r5
	add r0, #8
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	add r0, sp, #0x1c
	str r0, [sp, #0xc]
	mov r0, #0xb
	str r0, [sp, #0x10]
	mov r2, #0
	str r2, [sp, #0x14]
	ldr r0, [r1, #0]
	mov r1, r5
	add r3, r5, #4
	bl StageClearEx__LoadAssets
	ldr r0, [sp, #0x1c]
	ldr r1, =0x001FFFFF
	bl LoadDrawState
	ldr r0, =0x000008E8
	add r4, r5, r0
	ldr r0, [sp, #0x1c]
	mov r1, r4
	bl GetDrawStateCameraView
	ldr r0, [sp, #0x1c]
	mov r1, r4
	bl GetDrawStateCameraProjection
	ldr r4, [r4, #0x10]
	mov r2, #0x41
	asr r1, r4, #0x1f
	mov r0, r4
	lsl r2, r2, #2
	mov r3, #0
	bl _ull_mul
	mov r2, #2
	mov r3, #0
	lsl r2, r2, #0xa
	add r2, r0, r2
	adc r1, r3
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	ldr r0, =0x00000938
	add r1, r4, r1
	str r1, [r5, r0]
	ldr r0, [r5, #8]
	ldr r6, [r5, #0]
	str r0, [sp, #0x18]
	mov r0, r6
	ldr r7, [r5, #4]
	bl NNS_G3dResDefaultSetup
	mov r4, r5
	add r4, #0xc
	mov r0, r4
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #0
	mov r0, r4
	mov r1, r6
	mov r2, #1
	str r3, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	mov r0, r4
	mov r2, r7
	mov r3, #0x26
	str r1, [sp]
	bl AnimatorMDL__SetAnimation
	mov r1, #0x43
	lsl r1, r1, #2
	ldrh r2, [r4, r1]
	mov r0, #2
	orr r0, r2
	strh r0, [r4, r1]
	add r1, #0x44
	add r4, r5, r1
	mov r0, r4
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #0
	mov r0, r4
	mov r1, r6
	mov r2, #2
	str r3, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	mov r0, r4
	mov r2, r7
	mov r3, #0x27
	str r1, [sp]
	bl AnimatorMDL__SetAnimation
	mov r1, #0x43
	lsl r1, r1, #2
	ldrh r2, [r4, r1]
	mov r0, #2
	orr r0, r2
	strh r0, [r4, r1]
	mov r0, #0xa5
	lsl r0, r0, #2
	add r4, r5, r0
	mov r0, r4
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #0
	mov r0, r4
	mov r1, r6
	mov r2, #0x10
	str r3, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	mov r0, r4
	mov r2, r7
	mov r3, #0x29
	str r1, [sp]
	bl AnimatorMDL__SetAnimation
	mov r1, #0x43
	lsl r1, r1, #2
	ldrh r2, [r4, r1]
	mov r0, #2
	orr r0, r2
	strh r0, [r4, r1]
	mov r0, #0xf6
	lsl r0, r0, #2
	add r4, r5, r0
	mov r0, r4
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #0
	mov r0, r4
	mov r1, r6
	mov r2, #7
	str r3, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	mov r0, r4
	mov r2, r7
	mov r3, #0x28
	str r1, [sp]
	bl AnimatorMDL__SetAnimation
	mov r1, #0x43
	lsl r1, r1, #2
	ldrh r2, [r4, r1]
	mov r0, #2
	orr r0, r2
	strh r0, [r4, r1]
	ldr r0, =0x0000051C
	mov r1, #0
	add r4, r5, r0
	mov r0, r4
	bl AnimatorMDL__Init
	mov r2, #0
	mov r0, r4
	mov r1, r6
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	mov r0, r4
	mov r2, r7
	mov r3, #0x25
	str r1, [sp]
	bl AnimatorMDL__SetAnimation
	mov r0, #0
	str r0, [sp]
	ldr r2, [sp, #0x18]
	mov r0, r4
	mov r1, #3
	mov r3, #0xc
	bl AnimatorMDL__SetAnimation
	mov r0, #0x43
	lsl r0, r0, #2
	ldrh r1, [r4, r0]
	mov r2, #2
	orr r1, r2
	strh r1, [r4, r0]
	add r1, r0, #6
	ldrh r1, [r4, r1]
	add r0, r0, #6
	orr r1, r2
	strh r1, [r4, r0]
	mov r4, #0x66
	lsl r4, r4, #4
	add r0, r5, r4
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #0
	add r0, r5, r4
	mov r1, r6
	mov r2, #6
	str r3, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	add r0, r5, r4
	mov r2, r7
	mov r3, #0x2a
	str r1, [sp]
	bl AnimatorMDL__SetAnimation
	ldr r4, =0x000007A4
	mov r1, #0
	add r0, r5, r4
	bl AnimatorMDL__Init
	mov r3, #0
	add r0, r5, r4
	mov r1, r6
	mov r2, #0x11
	str r3, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	add r0, r5, r4
	mov r2, r7
	mov r3, #0x2b
	str r1, [sp]
	bl AnimatorMDL__SetAnimation
	add sp, #0x20
	pop {r3, r4, r5, r6, r7, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__LoadAssets(void *archive, ...){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r0, r1, r2, r3}
	push {r3, lr}
	add r2, sp, #8
	mov r1, #3
	bic r2, r1
	ldr r0, [sp, #8]
	add r1, r2, #4
	bl ArchiveFile__LoadFiles
	pop {r3}
	pop {r3}
	add sp, #0x10
	bx r3

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__ReleaseGraphics3D(StageClearExGraphics3D *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, lr}
	mov r4, r0
	add r0, #0xc
	bl AnimatorMDL__Release
	mov r0, #0x15
	lsl r0, r0, #4
	add r0, r4, r0
	bl AnimatorMDL__Release
	mov r0, #0xa5
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorMDL__Release
	mov r0, #0xf6
	lsl r0, r0, #2
	add r0, r4, r0
	bl AnimatorMDL__Release
	ldr r0, =0x0000051C
	add r0, r4, r0
	bl AnimatorMDL__Release
	mov r0, #0x66
	lsl r0, r0, #4
	add r0, r4, r0
	bl AnimatorMDL__Release
	ldr r0, =0x000007A4
	add r0, r4, r0
	bl AnimatorMDL__Release
	ldr r0, [r4, #0]
	bl NNS_G3dResDefaultRelease
	pop {r4, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__InitGraphics2D(StageClearExGraphics2D *work, StageClearExAssets *assets)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x18
	mov r5, r0
	ldr r0, =playerGameStatus
	mov r4, r1
	ldr r0, [r0, #0x1c]
	bl StageClearEx__CalcRingBonus
	ldr r1, =0x00000808
	str r0, [r5, r1]
	ldr r0, =playerGameStatus
	ldr r0, [r0, #0xc]
	bl StageClearEx__CalcTimeBonus
	ldr r1, =0x0000080C
	str r0, [r5, r1]
	sub r0, r1, #4
	ldr r2, [r5, r0]
	ldr r0, [r5, r1]
	add r2, r2, r0
	add r0, r1, #4
	str r2, [r5, r0]
	mov r2, #0
	ldr r0, [r4, #4]
	add r1, sp, #0x14
	mov r3, r2
	bl StageClearEx__LoadAssets
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0xa
	ldr r4, =0x00000528
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xe
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	add r0, r5, r4
	mov r2, #0xa
	bl SpriteUnknown__Func_204C90C
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0xb
	add r4, #0x64
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xe
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	add r0, r5, r4
	mov r2, #0xb
	bl SpriteUnknown__Func_204C90C
	mov r4, #0x3f
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0x17
	lsl r4, r4, #4
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xa
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	add r0, r5, r4
	mov r2, #0x17
	bl SpriteUnknown__Func_204C90C
	ldr r4, =0x0000051C
	mov r0, #0x9f
	add r1, r5, r4
	mvn r0, r0
	strh r0, [r1]
	mov r0, #0x84
	strh r0, [r1, #2]
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0x19
	sub r4, #0xc8
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xa
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	add r0, r5, r4
	mov r2, #0x19
	bl SpriteUnknown__Func_204C90C
	mov r0, #0x52
	lsl r0, r0, #4
	add r1, r5, r0
	mov r0, #0x9f
	mvn r0, r0
	strh r0, [r1]
	mov r0, #0x98
	strh r0, [r1, #2]
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0x1b
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xa
	str r0, [sp, #0x10]
	ldr r0, =0x000004B8
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	add r0, r5, r0
	mov r2, #0x1b
	bl SpriteUnknown__Func_204C90C
	ldr r0, =0x00000524
	mov r6, r5
	add r1, r5, r0
	mov r0, #0x9f
	mvn r0, r0
	strh r0, [r1]
	mov r0, #0xac
	strh r0, [r1, #2]
	ldr r0, =0x0000081C
	mov r1, #1
	str r1, [r5, r0]
	mov r4, #0
	add r6, #8
_02154252:
	lsl r0, r4, #0x10
	lsr r7, r0, #0x10
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, r7
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #5
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	mov r0, #0xc
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	mov r0, r6
	mov r2, r7
	bl SpriteUnknown__Func_204C90C
	add r4, r4, #1
	add r6, #0x64
	cmp r4, #0xa
	blo _02154252
	ldr r0, [sp, #0x14]
	mov r4, #0x5f
	mov r1, #0
	mov r2, #0xc
	lsl r4, r4, #4
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #6
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	add r0, r5, r4
	mov r2, #0xc
	bl SpriteUnknown__Func_204C90C
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0x21
	add r4, #0x64
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #4
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	add r0, r5, r4
	mov r2, #0x21
	bl SpriteUnknown__Func_204C90C
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0x20
	ldr r4, =0x000006B8
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #4
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	add r0, r5, r4
	mov r2, #0x20
	bl SpriteUnknown__Func_204C90C
	mov r2, r4
	add r2, #0x68
	mov r1, #0
	ldr r3, =0xFFFEA000
	str r1, [r5, r2]
	add r0, r2, #4
	str r3, [r5, r0]
	add r2, #0xc
	add r4, r5, r2
	ldr r0, [sp, #0x14]
	mov r2, #0xd
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #2
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xc
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000805
	mov r0, r4
	mov r2, #0xd
	bl SpriteUnknown__Func_204C90C
	mov r0, #0xc0
	strh r0, [r4, #8]
	mov r0, #0x60
	strh r0, [r4, #0xa]
	mov r0, #0x81
	lsl r0, r0, #4
	ldr r1, [r5, r0]
	ldr r0, =0x0000C350
	cmp r1, r0
	blo _0215434C
	mov r4, #0x1c
	b _02154362
_0215434C:
	ldr r0, =0x00009C40
	cmp r1, r0
	blo _02154356
	mov r4, #0x1d
	b _02154362
_02154356:
	lsr r0, r0, #1
	cmp r1, r0
	blo _02154360
	mov r4, #0x1e
	b _02154362
_02154360:
	mov r4, #0x1f
_02154362:
	mov r0, #0x79
	lsl r0, r0, #4
	add r6, r5, r0
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, r4
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #3
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xa
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000A05
	mov r0, r6
	mov r2, r4
	bl SpriteUnknown__Func_204C90C
	mov r0, #0xc0
	strh r0, [r6, #8]
	mov r0, #0x60
	strh r0, [r6, #0xa]
	bl AllocSndHandle
	mov r1, #0x81
	str r0, [r5, #4]
	lsl r1, r1, #4
	sub r4, #0x1c
	ldr r1, [r5, r1]
	mov r0, #0x16
	mov r2, r4
	bl SaveGame__UpdateStageRecord
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__ReleaseGraphics2D(StageClearExGraphics2D *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #4]
	bl FreeSndHandle
	mov r0, #0x79
	lsl r0, r0, #4
	add r0, r6, r0
	bl AnimatorSprite__Release
	ldr r0, =0x0000072C
	add r0, r6, r0
	bl AnimatorSprite__Release
	ldr r0, =0x000006B8
	add r0, r6, r0
	bl AnimatorSprite__Release
	ldr r0, =0x00000654
	add r0, r6, r0
	bl AnimatorSprite__Release
	mov r0, #0x5f
	lsl r0, r0, #4
	add r0, r6, r0
	bl AnimatorSprite__Release
	mov r0, #0x3f
	mov r5, r6
	lsl r0, r0, #4
	add r5, #8
	add r4, r6, r0
	cmp r5, r4
	beq _0215443C
_02154430:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _02154430
_0215443C:
	mov r0, #0x3f
	lsl r0, r0, #4
	add r5, r6, r0
	ldr r0, =0x0000051C
	add r4, r6, r0
	cmp r5, r4
	beq _02154456
_0215444A:
	mov r0, r5
	bl AnimatorSprite__Release
	add r5, #0x64
	cmp r5, r4
	bne _0215444A
_02154456:
	ldr r0, =0x0000058C
	add r0, r6, r0
	bl AnimatorSprite__Release
	ldr r0, =0x00000528
	add r0, r6, r0
	bl AnimatorSprite__Release
	pop {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__HandleAnimations(StageClearEx *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	mov r2, r0
	ldr r1, =0x00000958
	add r2, #0x1c
	add r4, r0, r1
	mov r5, r2
	sub r1, #0x70
	add r5, #0xc
	add r6, r2, r1
	cmp r5, r6
	beq _021544A6
	mov r7, #0x51
	lsl r7, r7, #2
_0215449A:
	mov r0, r5
	bl AnimatorMDL__ProcessAnimation
	add r5, r5, r7
	cmp r5, r6
	bne _0215449A
_021544A6:
	ldr r0, =0x000006B8
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, =0x00000654
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x5f
	lsl r0, r0, #4
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r1, #0x72
	lsl r1, r1, #4
	mov r0, r1
	add r0, #8
	ldr r2, [r4, r1]
	ldr r0, [r4, r0]
	add r0, r2, r0
	str r0, [r4, r1]
	mov r0, #1
	ldr r2, [r4, r1]
	lsl r0, r0, #0x14
	cmp r2, r0
	blt _021544F0
	sub r0, r2, r0
	str r0, [r4, r1]
	mov r2, #1
	sub r0, r1, #4
	str r2, [r4, r0]
_021544F0:
	mov r0, #0x3f
	mov r5, r4
	lsl r0, r0, #4
	add r5, #8
	add r6, r4, r0
	cmp r5, r6
	beq _02154510
	mov r7, #0
_02154500:
	mov r0, r5
	mov r1, r7
	mov r2, r7
	bl AnimatorSprite__ProcessAnimation
	add r5, #0x64
	cmp r5, r6
	bne _02154500
_02154510:
	mov r0, #0x3f
	lsl r0, r0, #4
	add r5, r4, r0
	ldr r0, =0x0000051C
	add r6, r4, r0
	cmp r5, r6
	beq _02154530
	mov r7, #0
_02154520:
	mov r0, r5
	mov r1, r7
	mov r2, r7
	bl AnimatorSprite__ProcessAnimation
	add r5, #0x64
	cmp r5, r6
	bne _02154520
_02154530:
	ldr r0, =0x0000058C
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, =0x00000528
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, #0x79
	lsl r0, r0, #4
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	ldr r0, =0x0000072C
	mov r1, #0
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	pop {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__HandleDrawing(StageClearEx *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r7, r0
	mov r4, r7
	ldr r0, =0x000008E8
	add r4, #0x1c
	add r5, r4, r0
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldr r0, =0x00000938
	beq _021545A8
	ldr r1, [r4, r0]
	sub r0, #0x50
	neg r1, r1
	add r0, r4, r0
	str r1, [r5, #0x18]
	bl Camera3D__LoadState
	b _021545B4
_021545A8:
	ldr r1, [r4, r0]
	sub r0, #0x50
	add r0, r4, r0
	str r1, [r5, #0x18]
	bl Camera3D__LoadState
_021545B4:
	ldr r0, =0x000008E8
	mov r5, r4
	add r5, #0xc
	add r4, r4, r0
	cmp r5, r4
	beq _021545D0
	mov r6, #0x51
	lsl r6, r6, #2
_021545C4:
	mov r0, r5
	bl AnimatorMDL__Draw
	add r5, r5, r6
	cmp r5, r4
	bne _021545C4
_021545D0:
	ldr r0, =0x00000958
	add r4, r7, r0
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _021545DE
	b _0215477E
_021545DE:
	mov r0, #0x5f
	lsl r0, r0, #4
	add r5, r4, r0
	mov r0, #0x72
	lsl r0, r0, #4
	ldr r1, [r4, r0]
	add r0, r0, #4
	asr r1, r1, #0xc
	strh r1, [r5, #8]
	ldr r0, [r4, r0]
	asr r0, r0, #0xc
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	ldr r0, =0x000006B8
	ldr r1, [r5, #8]
	add r6, r4, r0
	str r1, [r6, #8]
	add r0, #0x64
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _02154612
	mov r0, r6
	bl AnimatorSprite__DrawFrame
_02154612:
	mov r0, #8
	ldrsh r1, [r5, r0]
	add r0, #0xf8
	sub r0, r1, r0
	strh r0, [r5, #8]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	mov r0, #8
	ldrsh r1, [r6, r0]
	add r0, #0xf8
	sub r0, r1, r0
	strh r0, [r6, #8]
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	ldr r1, =0x0000051C
	mov r0, r1
	add r0, #0xc
	add r5, r4, r0
	ldrsh r0, [r4, r1]
	add r6, r4, r1
	add r0, #8
	strh r0, [r5, #8]
	mov r0, #2
	ldrsh r0, [r6, r0]
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	ldr r1, =0x0000051C
	mov r0, #0x3f
	lsl r0, r0, #4
	ldrsh r1, [r4, r1]
	add r0, r4, r0
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r6, r1]
	sub r1, #8
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, #6
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	ldr r0, =0x00000808
	ldr r1, =0x0000051C
	ldr r0, [r4, r0]
	mov r2, #2
	str r0, [sp, #8]
	ldrsh r1, [r4, r1]
	ldrsh r2, [r6, r2]
	mov r0, r4
	add r1, #0x58
	sub r2, r2, #2
	lsl r1, r1, #0x10
	lsl r2, r2, #0x10
	add r0, #8
	asr r1, r1, #0x10
	asr r2, r2, #0x10
	mov r3, #8
	bl StageClearEx__DrawNumber
	mov r0, #0x52
	lsl r0, r0, #4
	add r6, r4, r0
	ldrsh r0, [r4, r0]
	add r0, #8
	strh r0, [r5, #8]
	mov r0, #2
	ldrsh r0, [r6, r0]
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	ldr r1, =0x00000454
	add r0, r4, r1
	add r1, #0xcc
	ldrsh r1, [r4, r1]
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r6, r1]
	sub r1, #0x30
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, #6
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	ldr r0, =0x0000080C
	mov r1, #0x52
	ldr r0, [r4, r0]
	lsl r1, r1, #4
	str r0, [sp, #8]
	mov r2, #2
	ldrsh r1, [r4, r1]
	ldrsh r2, [r6, r2]
	mov r0, r4
	add r1, #0x58
	sub r2, r2, #2
	lsl r1, r1, #0x10
	lsl r2, r2, #0x10
	add r0, #8
	asr r1, r1, #0x10
	asr r2, r2, #0x10
	mov r3, #8
	bl StageClearEx__DrawNumber
	ldr r0, =0x00000818
	mov r5, #1
	ldrh r2, [r4, r0]
	mov r1, #0
	cmp r2, #0
	bls _02154704
	mov r0, #0xa
_021546FC:
	add r1, r1, #1
	mul r5, r0
	cmp r1, r2
	blo _021546FC
_02154704:
	mov r0, #0x81
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	mov r1, r5
	bl _u32_div_f
	ldr r0, =0x00000814
	mov r6, r1
	ldr r0, [r4, r0]
	mov r1, r5
	bl _u32_div_f
	mul r0, r5
	ldr r1, =0x00000524
	add r6, r6, r0
	mov r0, r1
	add r5, r4, r1
	ldrsh r1, [r4, r1]
	add r0, #0x68
	add r0, r4, r0
	add r1, #8
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r5, r1]
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	ldr r1, =0x000004B8
	add r0, r4, r1
	add r1, #0x6c
	ldrsh r1, [r4, r1]
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r5, r1]
	sub r1, #0x58
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, #6
	str r0, [sp]
	ldr r0, =0x0000081C
	ldr r1, =0x00000524
	ldr r0, [r4, r0]
	mov r2, #2
	str r0, [sp, #4]
	str r6, [sp, #8]
	ldrsh r1, [r4, r1]
	ldrsh r2, [r5, r2]
	mov r0, r4
	add r1, #0x58
	sub r2, r2, #2
	lsl r1, r1, #0x10
	lsl r2, r2, #0x10
	add r0, #8
	asr r1, r1, #0x10
	asr r2, r2, #0x10
	mov r3, #8
	bl StageClearEx__DrawNumber
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
_0215477E:
	mov r0, #0x5f
	lsl r0, r0, #4
	add r5, r4, r0
	mov r0, #0x72
	lsl r0, r0, #4
	ldr r1, [r4, r0]
	add r0, r0, #4
	asr r2, r1, #0xc
	mov r1, #1
	lsl r1, r1, #8
	sub r1, r1, r2
	strh r1, [r5, #8]
	ldr r0, [r4, r0]
	asr r1, r0, #0xc
	mov r0, #0xc0
	sub r0, r0, r1
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	ldr r0, =0x00000654
	add r6, r4, r0
	ldr r0, [r5, #8]
	str r0, [r6, #8]
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	mov r0, #8
	ldrsh r1, [r5, r0]
	add r0, #0xf8
	sub r0, r1, r0
	strh r0, [r5, #8]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	ldr r0, =0x0000071C
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _021547DC
	mov r0, #8
	ldrsh r1, [r6, r0]
	add r0, #0xf8
	sub r0, r1, r0
	strh r0, [r6, #8]
	mov r0, r6
	bl AnimatorSprite__DrawFrame
_021547DC:
	ldr r1, =0x000007F4
	mov r0, #1
	ldr r2, [r4, r1]
	lsl r0, r0, #0xc
	cmp r2, r0
	beq _02154804
	sub r1, #0xc8
	add r0, r4, r1
	bl AnimatorSprite__DrawFrame
	ldr r0, =0x000007F4
	mov r3, #0
	ldr r1, [r4, r0]
	sub r0, #0x64
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__DrawFrameRotoZoom
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
_02154804:
	mov r0, r1
	sub r0, #0xc8
	add r5, r4, r0
	mov r0, #8
	ldrsh r2, [r5, r0]
	add r0, r1, #4
	ldrsh r0, [r4, r0]
	add r0, r2, r0
	strh r0, [r5, #8]
	mov r0, #0xa
	ldrsh r2, [r5, r0]
	add r0, r1, #6
	ldrsh r0, [r4, r0]
	add r0, r2, r0
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	ldr r1, =0x000007F8
	mov r0, #8
	ldrsh r3, [r5, r0]
	ldrsh r2, [r4, r1]
	add r6, r1, #2
	sub r2, r3, r2
	strh r2, [r5, #8]
	mov r2, #0xa
	ldrsh r3, [r5, r2]
	ldrsh r6, [r4, r6]
	sub r3, r3, r6
	strh r3, [r5, #0xa]
	mov r3, r1
	sub r3, #0x68
	add r5, r4, r3
	ldrsh r3, [r5, r0]
	ldrsh r0, [r4, r1]
	sub r0, r3, r0
	strh r0, [r5, #8]
	add r0, r1, #2
	ldrsh r2, [r5, r2]
	ldrsh r0, [r4, r0]
	sub r0, r2, r0
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	mov r0, #8
	ldrsh r2, [r5, r0]
	ldr r0, =0x000007F8
	ldrsh r1, [r4, r0]
	add r0, r0, #2
	add r1, r2, r1
	strh r1, [r5, #8]
	mov r1, #0xa
	ldrsh r1, [r5, r1]
	ldrsh r0, [r4, r0]
	add r0, r1, r0
	strh r0, [r5, #0xa]
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__State_21548C0(StageClearEx *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, lr}
	mov r4, r0
	bl Camera3D__Create
	bl Camera3D__GetWork
	ldr r1, =0x0213D300
	mov r2, #0x18
	ldrsh r3, [r1, r2]
	mov r1, r0
	add r1, #0x58
	strh r3, [r1]
	ldr r1, =0x0213D2A4
	add r0, #0xb4
	ldrsh r1, [r1, r2]
	strh r1, [r0]
	mov r0, r4
	bl StageClearEx__CreateDrawManager
	ldr r0, =0x04000008
	mov r2, #3
	ldrh r1, [r0, #0]
	bic r1, r2
	strh r1, [r0]
	ldrh r3, [r0, #2]
	mov r1, #1
	bic r3, r2
	orr r1, r3
	strh r1, [r0, #2]
	ldrh r3, [r0, #4]
	mov r1, #2
	bic r3, r2
	orr r1, r3
	strh r1, [r0, #4]
	ldrh r3, [r0, #6]
	mov r1, #3
	bic r3, r2
	orr r1, r3
	strh r1, [r0, #6]
	sub r0, #8
	ldr r2, [r0, #0]
	ldr r1, =0xFFFFE0FF
	and r2, r1
	mov r1, #0x11
	lsl r1, r1, #8
	orr r1, r2
	str r1, [r0]
	ldr r1, =StageClearEx__State_FadeIn
	mov r0, r4
	bl StageClearEx__SetState
	pop {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__State_FadeIn(StageClearEx *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	bl Camera3D__GetWork
	mov r4, r0
	ldr r0, =0x0213D300
	mov r5, #0x18
	ldrsh r0, [r0, r5]
	cmp r0, #0
	ble _02154954
	mov r5, #0x10
	b _0215495C
_02154954:
	bge _0215495A
	sub r5, #0x28
	b _0215495C
_0215495A:
	mov r5, #0x10
_0215495C:
	mov r0, #0xb8
	beq _02154980
	mov r7, r4
	add r7, #0xb8
_02154964:
	ldr r2, [r6, #0xc]
	mov r1, #0
	lsl r2, r2, #0x16
	mov r0, r5
	asr r2, r2, #0x10
	mov r3, r1
	bl Task__Unknown204BE48__LerpValue
	mov r1, r4
	add r1, #0x58
	add r4, #0x5c
	strh r0, [r1]
	cmp r4, r7
	bne _02154964
_02154980:
	ldr r0, [r6, #0xc]
	cmp r0, #0x40
	bne _0215498E
	ldr r1, =StageClearEx__State_2154998
	mov r0, r6
	bl StageClearEx__SetState
_0215498E:
	pop {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__State_2154998(StageClearEx *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xc]
	cmp r0, #0xb4
	bls _021549B2
	mov r0, #0xd
	mov r1, #1
	bl PlaySysTrack
	ldr r1, =StageClearEx__State_21549B8
	mov r0, r4
	bl StageClearEx__SetState
_021549B2:
	pop {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__State_21549B8(StageClearEx *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, lr}
	sub sp, #0x24
	mov r4, r0
	ldr r0, =0x00000958
	mov r2, #6
	ldr r1, =0x00000728
	add r0, r4, r0
	lsl r2, r2, #0xa
	str r2, [r0, r1]
	mov r3, #0
	str r3, [sp]
	mov r2, #0x10
	str r2, [sp, #4]
	ldr r2, =Task__Unknown204BE48__LerpValue
	sub r1, r1, #4
	str r2, [sp, #8]
	str r3, [sp, #0xc]
	str r3, [sp, #0x10]
	str r3, [sp, #0x14]
	add r0, r0, r1
	str r3, [sp, #0x18]
	mov r2, #0x62
	str r2, [sp, #0x1c]
	str r3, [sp, #0x20]
	mov r3, #0x16
	ldr r2, =0xFFFEA000
	mov r1, #4
	lsl r3, r3, #0xc
	bl Task__Unknown204BE48__Create
	ldr r1, =StageClearEx__State_2154A14
	mov r0, r4
	bl StageClearEx__SetState
	add sp, #0x24
	pop {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__State_2154A14(StageClearEx *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, lr}
	ldr r1, [r0, #0xc]
	cmp r1, #0x78
	bls _02154A22
	ldr r1, =StageClearEx__State_2154A28
	bl StageClearEx__SetState
_02154A22:
	pop {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__State_2154A28(StageClearEx *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0x24
	mov r5, r0
	ldr r0, =0x00000958
	mov r3, #0
	add r4, r5, r0
	ldr r0, =0x00000818
	ldr r6, =_mt_math_rand
	strh r3, [r4, r0]
	ldr r1, [r6, #0]
	ldr r0, =0x00196225
	ldr r7, =0x3C6EF35F
	mul r0, r1
	add r1, r0, r7
	ldr r2, =0x00196225
	lsr r0, r1, #0x10
	mul r2, r1
	add r1, r2, r7
	str r1, [r6, #0]
	lsr r1, r1, #0x10
	lsl r0, r0, #0x10
	lsl r1, r1, #0x10
	lsr r2, r1, #0xc
	lsr r0, r0, #0x10
	mov r1, #0xf
	and r0, r1
	mov r1, r2
	orr r1, r0
	ldr r0, =0x00000818
	sub r0, r0, #4
	str r1, [r4, r0]
	mov r1, #2
	mov r2, r1
	str r3, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	ldr r0, =Task__Unknown204BE48__LerpValue
	sub r2, #0xa2
	str r0, [sp, #8]
	ldr r0, =0xFFFFF000
	str r0, [sp, #0xc]
	ldr r0, =StageClearEx__LerpCB_ScoreBonus
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, #0x62
	str r0, [sp, #0x1c]
	ldr r0, =0x0000051C
	str r3, [sp, #0x20]
	add r0, r4, r0
	bl Task__Unknown204BE48__Create
	mov r0, #0x10
	str r0, [sp]
	str r0, [sp, #4]
	ldr r0, =Task__Unknown204BE48__LerpValue
	mov r1, #2
	str r0, [sp, #8]
	ldr r0, =0xFFFFF000
	mov r2, r1
	str r0, [sp, #0xc]
	ldr r0, =StageClearEx__LerpCB_ScoreBonus
	mov r3, #0
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, #0x62
	str r0, [sp, #0x1c]
	mov r0, #0x52
	lsl r0, r0, #4
	add r0, r4, r0
	sub r2, #0xa2
	str r3, [sp, #0x20]
	bl Task__Unknown204BE48__Create
	mov r0, #0x20
	str r0, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	ldr r0, =Task__Unknown204BE48__LerpValue
	mov r1, #2
	str r0, [sp, #8]
	ldr r0, =0xFFFFF000
	mov r2, r1
	str r0, [sp, #0xc]
	ldr r0, =StageClearEx__LerpCB_ScoreTotal
	mov r3, #0
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, #0x62
	str r0, [sp, #0x1c]
	ldr r0, =0x00000524
	sub r2, #0xa2
	add r0, r4, r0
	str r3, [sp, #0x20]
	bl Task__Unknown204BE48__Create
	ldr r1, =StageClearEx__State_2154B28
	mov r0, r5
	bl StageClearEx__SetState
	add sp, #0x24
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__State_2154B28(StageClearEx *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, =0x00000958
	ldr r1, [r5, #0xc]
	add r4, r5, r0
	mov r0, #1
	tst r0, r1
	beq _02154B46
	bl Task__Unknown204BE48__Rand
	ldr r1, =0x000F4240
	bl _u32_div_f
	ldr r0, =0x00000814
	str r1, [r4, r0]
_02154B46:
	ldr r0, [r5, #0xc]
	cmp r0, #0x5a
	bls _02154B54
	ldr r1, =StageClearEx__State_2154B68
	mov r0, r5
	bl StageClearEx__SetState
_02154B54:
	pop {r3, r4, r5, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__State_2154B68(StageClearEx *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, lr}
	sub sp, #8
	mov r5, r0
	ldr r0, =0x00000958
	ldr r1, [r5, #0xc]
	add r4, r5, r0
	mov r0, #1
	tst r0, r1
	beq _02154B88
	bl Task__Unknown204BE48__Rand
	ldr r1, =0x000F4240
	bl _u32_div_f
	ldr r0, =0x00000814
	str r1, [r4, r0]
_02154B88:
	ldr r0, [r5, #0xc]
	lsr r1, r0, #4
	ldr r0, =0x00000818
	strh r1, [r4, r0]
	ldrh r0, [r4, r0]
	cmp r0, #6
	blo _02154BC0
	mov r0, #6
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #4]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	ldr r0, =0x0000081C
	mov r1, #0
	str r1, [r4, r0]
	ldr r1, =StageClearEx__State_2154BDC
	mov r0, r5
	bl StageClearEx__SetState
_02154BC0:
	add sp, #8
	pop {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__State_2154BDC(StageClearEx *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, lr}
	ldr r1, [r0, #0xc]
	cmp r1, #0x20
	bls _02154BF6
	mov r2, #0x43
	lsl r2, r2, #6
	ldr r3, [r0, r2]
	mov r1, #1
	bic r3, r1
	ldr r1, =StageClearEx__State_2154BFC
	str r3, [r0, r2]
	bl StageClearEx__SetState
_02154BF6:
	pop {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__State_2154BFC(StageClearEx *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, lr}
	ldr r1, [r0, #0xc]
	cmp r1, #0x1e
	bls _02154C20
	ldr r1, =0x00000958
	ldr r2, =0x000007CC
	add r4, r0, r1
	ldr r3, [r4, r2]
	mov r1, #1
	bic r3, r1
	mov r1, #6
	str r3, [r4, r2]
	lsl r1, r1, #0xa
	add r2, #0x28
	str r1, [r4, r2]
	ldr r1, =StageClearEx__State_2154C30
	bl StageClearEx__SetState
_02154C20:
	pop {r4, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__State_2154C30(StageClearEx *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, lr}
	sub sp, #8
	mov r5, r0
	ldr r0, =0x00000958
	ldr r2, [r5, #0xc]
	add r4, r5, r0
	mov r0, #6
	mov r1, #1
	lsl r2, r2, #0x17
	ldr r3, =0xFFFFD000
	lsl r0, r0, #0xa
	lsl r1, r1, #0xc
	asr r2, r2, #0x10
	bl Task__Unknown204BE48__LerpValue
	ldr r1, =0x000007F4
	str r0, [r4, r1]
	ldr r0, [r5, #0xc]
	cmp r0, #0x20
	bls _02154C80
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [r4, r1]
	mov r0, #6
	str r0, [sp]
	mov r0, #3
	str r0, [sp, #4]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, #6
	bl ShakeScreen
	ldr r1, =StageClearEx__State_2154C94
	mov r0, r5
	bl StageClearEx__SetState
_02154C80:
	add sp, #8
	pop {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__State_2154C94(StageClearEx *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, =0x00000958
	add r4, r5, r0
	bl GetScreenShakeOffsetX
	asr r1, r0, #0xc
	ldr r0, =0x000007F8
	strh r1, [r4, r0]
	bl GetScreenShakeOffsetY
	asr r1, r0, #0xc
	ldr r0, =0x000007FA
	strh r1, [r4, r0]
	mov r0, #0x11
	bl ShakeScreen
	cmp r0, #0
	bne _02154CC2
	ldr r1, =StageClearEx__State_2154CD4
	mov r0, r5
	bl StageClearEx__SetState
_02154CC2:
	pop {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__State_2154CD4(StageClearEx *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, lr}
	ldr r1, [r0, #0xc]
	cmp r1, #0x10
	bls _02154CE2
	ldr r1, =StageClearEx__State_2154CE8
	bl StageClearEx__SetState
_02154CE2:
	pop {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__State_2154CE8(StageClearEx *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, lr}
	ldr r1, =padInput
	ldrh r2, [r1, #4]
	ldr r1, =0x00000C0B
	tst r1, r2
	beq _02154CFC
	ldr r1, =StageClearEx__State_FadeOut
	bl StageClearEx__SetState
	pop {r3, pc}
_02154CFC:
	ldr r1, [r0, #0xc]
	cmp r1, #0x78
	bls _02154D08
	ldr r1, =StageClearEx__State_FadeOut
	bl StageClearEx__SetState
_02154D08:
	pop {r3, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__State_FadeOut(StageClearEx *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	bl Camera3D__GetWork
	mov r4, r0
	mov r0, #0xb8
	beq _02154D4A
	mov r6, r4
	mov r7, #0
	add r6, #0xb8
_02154D2C:
	ldr r2, [r5, #0xc]
	mov r1, #0xf
	lsl r2, r2, #0x17
	mov r0, r7
	mvn r1, r1
	asr r2, r2, #0x10
	mov r3, r7
	bl Task__Unknown204BE48__LerpValue
	mov r1, r4
	add r1, #0x58
	add r4, #0x5c
	strh r0, [r1]
	cmp r4, r6
	bne _02154D2C
_02154D4A:
	ldr r0, [r5, #0xc]
	cmp r0, #0x20
	bne _02154D66
	mov r0, #9
	bl SaveGame__Func_205B9F0
	mov r0, #0
	bl RequestSysEventChange
	bl NextSysEvent
	mov r0, r5
	bl StageClearEx__Destroy
_02154D66:
	pop {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__DrawNumber(AnimatorSprite *aniNumbers, s16 x, s16 y, s32 spacing, u16 digitCount, BOOL showAll, s32 value)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	str r0, [sp]
	ldr r0, [sp, #0x24]
	str r2, [sp, #4]
	str r0, [sp, #0x24]
	str r3, [sp, #8]
	add r0, sp, #0x10
	ldrh r7, [r0, #0x10]
	ldr r0, [sp, #8]
	mov r5, r1
	mov r1, r0
	mul r1, r7
	add r0, r5, r1
	lsl r0, r0, #0x10
	ldr r4, [sp, #0x28]
	asr r5, r0, #0x10
	mov r6, #0
	cmp r7, #0
	bls _02154DCE
_02154D90:
	mov r0, r4
	mov r1, #0xa
	bl _u32_div_f
	mov r2, r1
	ldr r1, [sp, #8]
	mov r0, #0x64
	mul r2, r0
	ldr r0, [sp]
	sub r1, r5, r1
	lsl r1, r1, #0x10
	add r0, r0, r2
	asr r5, r1, #0x10
	strh r5, [r0, #8]
	ldr r1, [sp, #4]
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, r4
	mov r1, #0xa
	bl _u32_div_f
	mov r4, r0
	ldr r0, [sp, #0x24]
	cmp r0, #0
	bne _02154DC8
	cmp r4, #0
	beq _02154DCE
_02154DC8:
	add r6, r6, #1
	cmp r6, r7
	blo _02154D90
_02154DCE:
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC u32 StageClearEx__CalcTimeBonus(u32 time){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, r5}
	ldr r5, =_02161514
	mov r4, #0
	mov r1, #0x3c
_02154DDC:
	ldrb r2, [r5, #0]
	mov r3, r2
	mul r3, r1
	cmp r3, r0
	bhi _02154DF0
	ldr r0, =_02161524
	lsl r1, r4, #2
	ldr r0, [r0, r1]
	pop {r4, r5}
	bx lr
_02154DF0:
	add r4, r4, #1
	add r5, r5, #1
	cmp r4, #8
	blo _02154DDC
	ldr r0, =0x0000AFC8
	pop {r4, r5}
	bx lr
	nop

// clang-format on
#endif
}

NONMATCH_FUNC u32 StageClearEx__CalcRingBonus(u32 rings){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r3, =_0216151C
	mov r2, #0
_02154E10:
	ldrb r1, [r3, #0]
	cmp r0, r1
	bhs _02154E1E
	ldr r0, =_02161548
	lsl r1, r2, #2
	ldr r0, [r0, r1]
	bx lr
_02154E1E:
	add r2, r2, #1
	add r3, r3, #1
	cmp r2, #8
	blo _02154E10
	ldr r0, =0x00001388
	bx lr
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__LerpCB_ScoreBonus(s32 a1, void *a2, StageClearEx *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, lr}
	sub sp, #8
	cmp r0, #4
	bne _02154E52
	mov r0, #6
	str r0, [sp]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	str r0, [sp, #4]
	bl PlaySfxEx
_02154E52:
	add sp, #8
	pop {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__LerpCB_ScoreTotal(s32 a1, void *a2, StageClearEx *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r4, lr}
	sub sp, #8
	mov r4, r2
	cmp r0, #4
	bne _02154E8A
	mov r0, #6
	str r0, [sp]
	mov r0, #0
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	str r0, [sp, #4]
	bl PlaySfxEx
	mov r0, #6
	str r0, [sp]
	mov r1, #1
	str r1, [sp, #4]
	sub r1, r1, #2
	ldr r0, =0x0000095C
	mov r2, r1
	ldr r0, [r4, r0]
	mov r3, r1
	bl PlaySfxEx
_02154E8A:
	add sp, #8
	pop {r4, pc}
	nop

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__Main_Core(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0xc]
	add r1, r1, #1
	str r1, [r0, #0xc]
	ldr r1, [r0, #8]
	cmp r1, #0
	beq _02154EA8
	blx r1
_02154EA8:
	pop {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__Main_AnimationManager(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, lr}
	ldr r0, =StageClearEx__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	bl StageClearEx__HandleAnimations
	pop {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void StageClearEx__Main_DrawManager(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	push {r3, lr}
	ldr r0, =StageClearEx__Singleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	bl StageClearEx__HandleDrawing
	pop {r3, pc}

// clang-format on
#endif
}

#include <nitro/codereset.h>