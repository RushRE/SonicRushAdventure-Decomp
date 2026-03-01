#include <stage/boss/boss3.h>
#include <stage/boss/bossPlayerHelpers.h>
#include <stage/core/hud.h>
#include <stage/core/titleCard.h>
#include <stage/core/bgmManager.h>
#include <stage/core/ringManager.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/stage/bossArena.h>
#include <game/audio/spatialAudio.h>
#include <game/stage/mapFarSys.h>
#include <game/graphics/screenShake.h>
#include <game/graphics/drawFadeTask.h>
#include <game/graphics/background.h>
#include <game/object/objectManager.h>
#include <game/math/unknown2066510.h>
#include <game/graphics/drawState.h>

// resources
#include <resources/narc/z3boss_act_lz7.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED Task *Boss3Stage__TaskSingleton;
NOT_DECOMPILED void *Boss3__PlayerDrawFunc;
NOT_DECOMPILED u8 Boss3__Unused217AF90[0x20];

NOT_DECOMPILED void *_02179D9C;
NOT_DECOMPILED void *_02179DA0;
NOT_DECOMPILED void *_02179DA4;
NOT_DECOMPILED void *_02179DAA;
NOT_DECOMPILED void *_02179DB0;
NOT_DECOMPILED void *_02179DB6;
NOT_DECOMPILED void *_02179DBC;
NOT_DECOMPILED void *_02179DC4;
NOT_DECOMPILED void *_02179DCC;
NOT_DECOMPILED void *_02179DD4;
NOT_DECOMPILED void *_02179DDC;
NOT_DECOMPILED void *_02179DE4;
NOT_DECOMPILED void *_02179DEC;
NOT_DECOMPILED void *_02179DF4;
NOT_DECOMPILED void *_02179E00;
NOT_DECOMPILED void *_02179E0C;
NOT_DECOMPILED void *_02179E1C;
NOT_DECOMPILED void *_02179E2C;
NOT_DECOMPILED void *_02179E3C;
NOT_DECOMPILED void *_02179E4C;
NOT_DECOMPILED void *_02179E5C;
NOT_DECOMPILED void *_02179E74;

NOT_DECOMPILED void *_0217A82C;
NOT_DECOMPILED void *_0217A830;
NOT_DECOMPILED void *_0217A838;
NOT_DECOMPILED void *_0217A840;
NOT_DECOMPILED void *_0217A848;
NOT_DECOMPILED void *_0217A850;
NOT_DECOMPILED void *_0217A858;
NOT_DECOMPILED void *_0217A868;
NOT_DECOMPILED void *_0217A880;
NOT_DECOMPILED void *_0217A898;
NOT_DECOMPILED void *_0217A8B8;
NOT_DECOMPILED void *_0217A8E8;
NOT_DECOMPILED VecFx32 _0217A928[6];
NOT_DECOMPILED void *_0217A970;
NOT_DECOMPILED void *_0217AA18;

NOT_DECOMPILED const char *aStage00;
NOT_DECOMPILED const char *aExc_3;
NOT_DECOMPILED const char *aBody_0;
NOT_DECOMPILED const char *aMouth;
NOT_DECOMPILED const char *aArmHit;

// --------------------
// FUNCTION DECLS
// --------------------

// --------------------
// INLINE FUNCTIONS
// --------------------

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC Boss3Stage *Boss3Stage__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xe4
	mov r3, #0x1500
	mov r4, r0
	mov r11, r1
	mov r10, r2
	mov r2, #0
	str r3, [sp]
	mov r0, #2
	ldr r5, =0x00000F54
	str r0, [sp, #4]
	ldr r0, =StageTask_Main
	ldr r1, =Boss3Stage__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	ldr r1, =Boss3Stage__TaskSingleton
	str r0, [r1]
	bl GetTaskWork_
	mov r5, r0
	mov r0, #0
	mov r1, r5
	ldr r2, =0x00000F54
	bl MIi_CpuClear16
	mov r1, r4
	mov r0, r5
	mov r2, r11
	mov r3, r10
	bl GameObject__InitFromObject
	ldr r1, =Boss3Stage__State_2162F18
	ldr r0, =Boss3Stage__Draw
	str r1, [r5, #0xf4]
	str r0, [r5, #0xfc]
	ldr r0, [r5, #0x18]
	mov r1, #0x400
	orr r0, r0, #0x12
	str r0, [r5, #0x18]
	ldr r2, [r5, #0x1c]
	add r0, r5, #0x300
	orr r2, r2, #0xa300
	str r2, [r5, #0x1c]
	strh r1, [r0, #0xb8]
	str r10, [r5, #0x3c4]
	str r10, [r5, #0x3cc]
	str r10, [r5, #0x3d4]
	sub r0, r10, #0x19c000
	str r0, [r5, #0x3d8]
	ldr r1, =Boss3Stage__State_21631E0
	mov r0, #1
	str r1, [r5, #0x3b4]
	str r0, [r5, #0x414]
	add r0, r5, #0x24
	add r0, r0, #0x400
	bl BossHelpers__InitLights
	add r0, r5, #0x364
	bl Boss3Stage__LoadAssets
	mov r0, r5
	add r1, r5, #0x56
	add r1, r1, #0x400
	bl Boss3Stage__LoadWaterLights
	bl BossHelpers__Model__InitSystem
	add r4, r5, #0x108
	add r0, r4, #0x400
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	str r2, [sp]
	add r0, r4, #0x400
	ldr r1, =bossAssetFiles
	mov r3, r2
	ldr r1, [r1, #8]
	bl AnimatorMDL__SetResource
	mov r1, #0
	str r1, [r4, #0x448]
	rsb r0, r10, #0
	str r0, [r4, #0x44c]
	str r1, [r4, #0x450]
	ldr r0, =0x000034CC
	str r0, [r4, #0x418]
	str r0, [r4, #0x41c]
	str r0, [r4, #0x420]
	add r0, r5, #0x24c
	add r6, r0, #0x400
	mov r0, r6
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, =bossAssetFiles
	str r2, [sp]
	ldr r1, [r0, #0x10]
	mov r0, r6
	mov r3, r2
	bl AnimatorMDL__SetResource
	add r0, r5, #0x550
	add r4, r6, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	add r0, r5, #0x520
	add r3, r6, #0x18
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r4, r5, #0x790
	mov r0, r4
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r1, =bossAssetFiles
	str r2, [sp]
	ldr r1, [r1, #0x18]
	mov r0, r4
	mov r3, r2
	bl AnimatorMDL__SetResource
	add r1, r5, #0x550
	add r7, r4, #0x48
	add r0, r5, #0xd4
	add r3, r4, #0x18
	add r4, r0, #0x800
	ldmia r1, {r0, r1, r2}
	stmia r7, {r0, r1, r2}
	add r6, r5, #0x520
	ldmia r6, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r4
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r1, =bossAssetFiles
	str r2, [sp]
	ldr r1, [r1, #0x20]
	mov r0, r4
	mov r3, r2
	bl AnimatorMDL__SetResource
	mov r3, #0
	str r3, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r2, [r5, #0x36c]
	mov r0, r4
	mov r1, #3
	bl BossHelpers__SetAnimation
	add r0, r5, #0x550
	add r8, r4, #0x48
	ldmia r0, {r0, r1, r2}
	add r6, r4, #0x18
	stmia r8, {r0, r1, r2}
	add r7, r5, #0x520
	ldmia r7, {r0, r1, r2}
	stmia r6, {r0, r1, r2}
	mov r4, #1
	mov r1, #0
	stmia sp, {r1, r4}
	ldr r2, [r5, #0x368]
	mov r3, #2
	add r0, r5, #0x790
	bl BossHelpers__SetAnimation
	add r4, r5, #0x108
	mov r0, #4
	strb r0, [r4, #0x40a]
	mov r6, #3
	ldr r1, =BossHelpers__Model__RenderCallback
	add r0, r4, #0x490
	mov r2, #0
	mov r3, #6
	str r6, [sp]
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0x494]
	ldr r1, =aStage00
	mov r2, #0x1e
	bl BossHelpers__Model__Init
	ldr r1, =gameArchiveStage
	add r0, sp, #0x7c
	ldr r2, [r1, #0]
	ldr r1, =aExc_3
	bl NNS_FndMountArchive
	add r0, sp, #0x7c
	mov r1, #0x31
	bl NNS_FndGetArchiveFileByIndex
	add r1, r5, #0x218
	mov r6, r0
	add r8, r1, #0x800
	mov r7, #0
	mov r9, r5
_02160D4C:
	mov r0, r6
	bl Sprite__GetTextureSize
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r4, r0
	mov r0, r6
	bl Sprite__GetPaletteSize
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #0
	stmia sp, {r1, r4}
	str r0, [sp, #8]
	mov r0, r8
	mov r2, r6
	mov r3, #1
	bl AnimatorSprite3D__Init
	mov r0, #0x1c
	strb r0, [r9, #0xa22]
	mov r0, #7
	strb r0, [r9, #0xa23]
	ldr r0, [r9, #0xae4]
	mov r1, r7, lsl #1
	orr r0, r0, #4
	str r0, [r9, #0xae4]
	ldr r0, =_02179DF4
	add r8, r8, #0x104
	ldrh r1, [r0, r1]
	ldr r0, =0x00001A66
	str r0, [r9, #0xa30]
	str r0, [r9, #0xa34]
	str r0, [r9, #0xa38]
	add r0, r5, r7, lsl #2
	add r7, r7, #1
	str r1, [r0, #0xf40]
	add r9, r9, #0x104
	cmp r7, #5
	blt _02160D4C
	add r0, sp, #0x7c
	bl NNS_FndUnmountArchive
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	ldr r0, =0x0000012E
	mov r1, r11
	mov r2, r10
	str r3, [sp, #0x10]
	bl GameObject__SpawnObject
	str r0, [r5, #0x374]
	mov r6, #0
	ldr r7, =0x0000012F
	str r5, [r0, #0xa3c]
	mov r4, r6
_02160E2C:
	str r4, [sp]
	str r4, [sp, #4]
	str r4, [sp, #8]
	mov r0, r7
	mov r1, r11
	mov r2, r10
	mov r3, r4
	str r4, [sp, #0xc]
	and r8, r6, #0xff
	str r8, [sp, #0x10]
	bl GameObject__SpawnObject
	add r1, r5, r6, lsl #2
	add r6, r6, #1
	str r0, [r1, #0x398]
	str r5, [r0, #0x374]
	cmp r6, #4
	blt _02160E2C
	ldr r1, =gameArchiveStage
	add r0, sp, #0x14
	ldr r2, [r1, #0]
	ldr r1, =aExc_3
	bl NNS_FndMountArchive
	add r0, sp, #0x14
	mov r1, #0x19
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultSetup
	add r0, sp, #0x14
	mov r1, #0x1c
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultSetup
	add r0, sp, #0x14
	mov r1, #0x20
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultSetup
	add r0, sp, #0x14
	bl NNS_FndUnmountArchive
	mov r0, r5
	bl StageTask__InitSeqPlayer
	bl DisableSpatialVolume
	mov r0, r5
	add sp, sp, #0xe4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC Boss3 *Boss3__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x7c
	mov r5, #0x1500
	mov r7, r0
	mov r6, r2
	mov r2, #0
	str r5, [sp]
	mov r4, #2
	ldr r0, =StageTask_Main
	ldr r1, =Boss3__Destructor
	mov r3, r2
	str r4, [sp, #4]
	sub r4, r5, #0x368
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r8, r0
	ldr r2, =0x00001198
	mov r1, r8
	mov r0, #0
	bl MIi_CpuClear16
	mov r1, r7
	mov r3, r6
	mov r0, r8
	mov r2, #0
	bl GameObject__InitFromObject
	ldr r1, =Boss3__State_2163604
	ldr r0, =Boss3__Draw
	str r1, [r8, #0xf4]
	str r0, [r8, #0xfc]
	ldr r1, [r8, #0x18]
	add r0, r8, #0x22c
	orr r1, r1, #0x10
	str r1, [r8, #0x18]
	add r0, r0, #0x800
	ldr r1, [r8, #0x1c]
	orr r1, r1, #0x8300
	str r1, [r8, #0x1c]
	bl Boss3Stage__LoadAssets
	add r4, r8, #0x1cc
	add r0, r4, #0xc00
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	str r2, [sp]
	add r0, r4, #0xc00
	ldr r1, =bossAssetFiles
	mov r3, r2
	ldr r1, [r1, #0]
	bl AnimatorMDL__SetResource
	ldr r1, =0x000034CC
	mov r0, #4
	str r1, [r4, #0xc18]
	str r1, [r4, #0xc1c]
	str r1, [r4, #0xc20]
	strb r0, [r4, #0xc0a]
	mov r0, #3
	str r0, [sp]
	add r0, r4, #0xc90
	ldr r1, =BossHelpers__Model__RenderCallback
	mov r2, #0
	mov r3, #6
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0xc94]
	ldr r1, =aBody_0
	mov r2, #0x1d
	bl BossHelpers__Model__Init
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0xc94]
	ldr r1, =aMouth
	mov r2, #0x1c
	bl BossHelpers__Model__Init
	ldr r0, =_02179D9C
	mov r9, #0
	ldrh r2, [r0, #0x50]
	ldrh r1, [r0, #0x52]
	ldr r6, =0x000034CC
	strh r2, [sp, #0xc]
	strh r1, [sp, #0xe]
	ldrh r1, [r0, #0x54]
	ldrh r0, [r0, #0x56]
	add r7, sp, #0xc
	add r10, r8, #0xf10
	strh r1, [sp, #0x10]
	strh r0, [sp, #0x12]
	mov r5, #4
	mov r11, #3
	mov r4, r9
_02161084:
	mov r0, r10
	mov r1, #0
	bl AnimatorMDL__Init
	mov r0, #0
	str r0, [sp]
	ldr r1, =bossAssetFiles
	mov r0, r10
	ldr r1, [r1, #0]
	mov r2, #3
	mov r3, #0
	bl AnimatorMDL__SetResource
	mov r0, #0
	str r0, [r10, #0x48]
	str r0, [r10, #0x4c]
	str r0, [r10, #0x50]
	str r6, [r10, #0x18]
	str r6, [r10, #0x1c]
	str r6, [r10, #0x20]
	strb r5, [r10, #0xa]
	ldr r1, =BossHelpers__Model__RenderCallback
	str r11, [sp]
	add r0, r10, #0x90
	mov r2, #0
	mov r3, #6
	bl NNS_G3dRenderObjSetCallBack
	str r4, [sp]
	add r2, r7, r9, lsl #2
	ldrh r2, [r2, #2]
	ldr r0, [r10, #0x94]
	ldr r1, =aArmHit
	mov r3, r4
	bl BossHelpers__Model__Init
	add r9, r9, #1
	add r10, r10, #0x144
	cmp r9, #2
	blt _02161084
	ldr r1, =gameArchiveStage
	add r0, sp, #0x14
	ldr r2, [r1, #0]
	ldr r1, =aExc_3
	bl NNS_FndMountArchive
	add r0, r8, #0x3cc
	ldr r6, =_0217A8E8
	ldr r4, =bossAssetFiles
	add r10, r0, #0x800
	mov r9, #0
	add r11, sp, #0x14
	mov r5, #5
_02161144:
	mov r0, r11
	add r1, r9, #9
	bl NNS_FndGetArchiveFileByIndex
	mov r7, r0
	ldr r0, [r4, #0]
	bl NNS_G3dGetTex
	ldr r1, [r6, r9, lsl #2]
	bl Asset3DSetup_GetPaletteFromName
	str r5, [sp]
	mov r2, #0
	str r0, [sp, #4]
	mov r1, r7
	mov r0, r10
	mov r3, r2
	bl InitPaletteAnimator
	add r9, r9, #1
	add r10, r10, #0x20
	cmp r9, #0x10
	blt _02161144
	mov r0, r8
	mov r1, #2
	bl Boss3__SetPaletteAnim
	add r0, sp, #0x14
	bl NNS_FndUnmountArchive
	mov r0, r8
	bl StageTask__InitSeqPlayer
	mov r0, r8
	mov r1, #0
	bl Boss3__Action_DecideNextAction
	mov r0, r8
	add sp, sp, #0x7c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC GameObjectTask *Boss3SplatInk__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x74
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, =0x00000698
	ldr r0, =StageTask_Main
	ldr r1, =Boss3SplatInk__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, =0x00000698
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r1, r7
	mov r2, r6
	mov r3, r5
	mov r0, r4
	bl GameObject__InitFromObject
	ldr r1, =Boss3SplatInk__State_2167380
	ldr r0, =Boss3SplatInk__Draw
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r1, =Boss3SplatInk__Collide
	add r0, r4, #0x364
	str r1, [r4, #0x108]
	ldr r1, [r4, #0x18]
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x8200
	str r1, [r4, #0x1c]
	bl Boss3Stage__LoadAssets
	ldr r3, =_0217A82C
	add r0, r4, #0x258
	ldrsh r1, [r3, #0x22]
	str r1, [sp]
	ldrsh r1, [r3, #0x1c]
	ldrsh r2, [r3, #0x1e]
	ldrsh r3, [r3, #0x20]
	bl ObjRect__SetBox2D
	ldr r1, =Boss3SplatInk__OnHit
	str r4, [r4, #0x274]
	str r1, [r4, #0x278]
	ldr r2, [r4, #0x270]
	ldr r1, =aExc_3
	bic r2, r2, #4
	str r2, [r4, #0x270]
	ldr r2, =gameArchiveStage
	add r0, sp, #0xc
	ldr r2, [r2, #0]
	bl NNS_FndMountArchive
	add r0, r4, #0x410
	mov r1, #0
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #0x19
	bl NNS_FndGetArchiveFileByIndex
	mov r2, #0
	mov r1, r0
	add r0, r4, #0x410
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	str r1, [r4, #0x458]
	str r1, [r4, #0x45c]
	ldr r2, =0x000034CC
	str r1, [r4, #0x460]
	str r2, [r4, #0x428]
	add r5, r4, #0x154
	str r2, [r4, #0x42c]
	add r0, r5, #0x400
	str r2, [r4, #0x430]
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #0x19
	bl NNS_FndGetArchiveFileByIndex
	mov r1, r0
	mov r3, #0
	add r0, r5, #0x400
	mov r2, #1
	str r3, [sp]
	bl AnimatorMDL__SetResource
	mov r0, #0
	str r0, [r5, #0x448]
	str r0, [r5, #0x44c]
	str r0, [r5, #0x450]
	ldr r1, =0x000034CC
	add r0, sp, #0xc
	str r1, [r5, #0x418]
	str r1, [r5, #0x41c]
	str r1, [r5, #0x420]
	bl NNS_FndUnmountArchive
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	mov r1, #0
	bl Boss3SplatInk__Action_DecideNextAction
	mov r0, r4
	add sp, sp, #0x74
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC GameObjectTask *Boss3DimInk__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x74
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, =0x0000079C
	ldr r0, =StageTask_Main
	ldr r1, =Boss3DimInk__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, =0x0000079C
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r1, r7
	mov r2, r6
	mov r3, r5
	mov r0, r4
	bl GameObject__InitFromObject
	ldr r1, =Boss3DimInk__State_2167810
	ldr r0, =Boss3DimInk__Draw
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r1, [r4, #0x18]
	add r0, r4, #0x364
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x8300
	str r1, [r4, #0x1c]
	bl Boss3Stage__LoadAssets
	ldr r2, =gameArchiveStage
	ldr r1, =aExc_3
	ldr r2, [r2, #0]
	add r0, sp, #0xc
	bl NNS_FndMountArchive
	add r0, r4, #0x3d0
	mov r1, #0
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #0x1c
	bl NNS_FndGetArchiveFileByIndex
	mov r2, #0
	mov r1, r0
	add r0, r4, #0x3d0
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	str r1, [r4, #0x418]
	str r1, [r4, #0x41c]
	ldr r2, =0x000C5FD0
	str r1, [r4, #0x420]
	ldr r0, =0x000E6FC8
	str r2, [r4, #0x3e8]
	str r0, [r4, #0x3ec]
	ldr r0, =0x001ACF98
	add r6, r4, #0x114
	str r0, [r4, #0x3f0]
	add r0, r6, #0x400
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #0x1c
	bl NNS_FndGetArchiveFileByIndex
	mov r1, r0
	mov r3, #0
	add r0, r6, #0x400
	mov r2, #1
	str r3, [sp]
	bl AnimatorMDL__SetResource
	mov r1, #0
	str r1, [r6, #0x448]
	str r1, [r6, #0x44c]
	add r5, r4, #0x258
	ldr r2, =0x000034CC
	str r1, [r6, #0x450]
	str r2, [r6, #0x418]
	str r2, [r6, #0x41c]
	add r0, r5, #0x400
	str r2, [r6, #0x420]
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #0x1c
	bl NNS_FndGetArchiveFileByIndex
	mov r1, r0
	mov r3, #0
	add r0, r5, #0x400
	mov r2, #2
	str r3, [sp]
	bl AnimatorMDL__SetResource
	mov r0, #0
	str r0, [r5, #0x448]
	str r0, [r5, #0x44c]
	str r0, [r5, #0x450]
	ldr r1, =0x000034CC
	add r0, sp, #0xc
	str r1, [r5, #0x418]
	str r1, [r5, #0x41c]
	str r1, [r5, #0x420]
	bl NNS_FndUnmountArchive
	ldr r1, [r4, #0x20]
	ldr r0, =Boss3DimInk__StateInk_2167C44
	orr r1, r1, #0x20
	str r1, [r4, #0x20]
	str r0, [r4, #0x378]
	mov r0, r4
	add sp, sp, #0x74
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC GameObjectTask *Boss3InkSmoke__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x74
	mov r0, #0x1a00
	str r0, [sp]
	mov r4, #4
	mov r2, #0
	str r4, [sp, #4]
	add r4, r4, #0x6b0
	ldr r0, =StageTask_Main
	ldr r1, =Boss3InkSmoke__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r6, r0
	ldr r2, =0x000006B4
	mov r1, r6
	mov r0, #0
	bl MIi_CpuClear16
	ldr r1, =Boss3InkSmoke__State_2167F80
	ldr r0, =Boss3InkSmoke__Draw
	str r1, [r6, #0xf4]
	str r0, [r6, #0xfc]
	ldr r0, [r6, #0x18]
	ldr r1, =gameArchiveStage
	orr r0, r0, #0x10
	str r0, [r6, #0x18]
	ldr r2, [r6, #0x1c]
	add r0, sp, #0xc
	orr r2, r2, #0x1300
	str r2, [r6, #0x1c]
	ldr r2, [r1, #0]
	ldr r1, =aExc_3
	bl NNS_FndMountArchive
	add r0, sp, #0xc
	mov r1, #0x1f
	bl NNS_FndGetArchiveFileByIndex
	mov r8, #0
	ldr r11, =_02179DAA
	mov r7, r0
	mov r10, r6
	add r9, r6, #0x3a8
	mov r4, r8
_02161690:
	mov r0, r7
	bl Sprite__GetTextureSize
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r5, r0
	mov r0, r7
	bl Sprite__GetPaletteSize
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r3, r8, lsl #1
	stmia sp, {r4, r5}
	str r0, [sp, #8]
	ldrh r3, [r11, r3]
	mov r0, r9
	mov r1, r4
	mov r2, r7
	bl AnimatorSprite3D__Init
	mov r0, #0x1c
	strb r0, [r10, #0x3b2]
	mov r0, #7
	strb r0, [r10, #0x3b3]
	ldr r1, [r10, #0x474]
	mov r0, r9
	orr r1, r1, #4
	str r1, [r10, #0x474]
	ldr r1, =0x000034CC
	str r1, [r10, #0x3c0]
	str r1, [r10, #0x3c4]
	str r1, [r10, #0x3c8]
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	add r8, r8, #1
	add r9, r9, #0x104
	add r10, r10, #0x104
	cmp r8, #3
	blt _02161690
	add r0, sp, #0xc
	bl NNS_FndUnmountArchive
	ldr r1, =Boss3InkSmoke__StateSmoke_21681A8
	mov r0, r6
	str r1, [r6, #0x378]
	add sp, sp, #0x74
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC GameObjectTask *Boss3ScreenSplatInk__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x74
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, =0x000004EC
	ldr r0, =StageTask_Main
	ldr r1, =Boss3ScreenSplatInk__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, =0x000004EC
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r1, r7
	mov r2, r6
	mov r3, r5
	mov r0, r4
	bl GameObject__InitFromObject
	ldr r1, =Boss3ScreenSplatInk__State_2168260
	ldr r0, =Boss3ScreenSplatInk__Draw
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r1, [r4, #0x18]
	add r0, r4, #0x364
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x8300
	str r1, [r4, #0x1c]
	bl Boss3Stage__LoadAssets
	ldr r2, =gameArchiveStage
	ldr r1, =aExc_3
	ldr r2, [r2, #0]
	add r0, sp, #0xc
	bl NNS_FndMountArchive
	add r0, r4, #0x3a8
	mov r1, #0
	bl AnimatorMDL__Init
	add r0, sp, #0xc
	mov r1, #0x20
	bl NNS_FndGetArchiveFileByIndex
	mov r2, #0
	mov r1, r0
	add r0, r4, #0x3a8
	mov r3, r2
	str r2, [sp]
	bl AnimatorMDL__SetResource
	mov r0, #0
	str r0, [r4, #0x3f0]
	str r0, [r4, #0x3f4]
	str r0, [r4, #0x3f8]
	ldr r1, =0x000034CC
	add r0, sp, #0xc
	str r1, [r4, #0x3c0]
	str r1, [r4, #0x3c4]
	str r1, [r4, #0x3c8]
	bl NNS_FndUnmountArchive
	mov r0, r4
	add sp, sp, #0x74
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC GameObjectTask *Boss3Arm__Create(MapObject *mapObject, fx32 x, fx32 y, s32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r4, #0x1500
	mov r8, r0
	mov r7, r1
	mov r6, r2
	str r4, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x610
	ldr r0, =StageTask_Main
	ldr r1, =Boss3Arm__Destructor
	mov r2, #0
	mov r5, r3
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x610
	bl MIi_CpuClear16
	mov r1, r8
	mov r2, r7
	mov r3, r6
	mov r0, r4
	bl GameObject__InitFromObject
	ldr r1, =Boss3Arm__State_2168520
	ldr r0, =Boss3Arm__Draw
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
	ldr r1, =Boss3Arm__Collide
	add r0, r4, #0x364
	str r1, [r4, #0x108]
	ldr r1, [r4, #0x18]
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x8300
	str r1, [r4, #0x1c]
	str r5, [r4, #0x380]
	bl Boss3Stage__LoadAssets
	mov r1, #0
	add r0, r4, #0x218
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r3, =_0217A82C
	add r0, r4, #0x218
	ldrsh r1, [r3, #0x42]
	str r1, [sp]
	ldrsh r1, [r3, #0x3c]
	ldrsh r2, [r3, #0x3e]
	ldrsh r3, [r3, #0x40]
	bl ObjRect__SetBox2D
	str r4, [r4, #0x234]
	ldr r0, [r4, #0x380]
	cmp r0, #0
	ldreq r0, =Boss3Arm__OnDefend_Regular
	ldrne r0, =Boss3Arm__OnDefend_Weakpoint
	str r0, [r4, #0x23c]
	ldr r1, [r4, #0x230]
	add r0, r4, #0x258
	orr r1, r1, #0x400
	bic r3, r1, #4
	mov r1, #2
	mov r2, #0x40
	str r3, [r4, #0x230]
	bl ObjRect__SetAttackStat
	add r0, r4, #0x258
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r3, =_0217A82C
	add r0, r4, #0x258
	ldrsh r1, [r3, #0x4a]
	str r1, [sp]
	ldrsh r1, [r3, #0x44]
	ldrsh r2, [r3, #0x46]
	ldrsh r3, [r3, #0x48]
	bl ObjRect__SetBox2D
	str r4, [r4, #0x274]
	ldr r1, [r4, #0x270]
	add r0, r4, #0x298
	bic r1, r1, #4
	str r1, [r4, #0x270]
	mov r1, #2
	mov r2, #0
	bl ObjRect__SetAttackStat
	mov r1, #0
	add r0, r4, #0x298
	mov r2, r1
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x2b0]
	ldr r0, =Boss3Arm__OnDefend_2168D6C
	orr r1, r1, #0xc0
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x2bc]
	ldr r3, =_0217A82C
	add r0, r4, #0x298
	ldrsh r1, [r3, #0x52]
	str r1, [sp]
	ldrsh r1, [r3, #0x4c]
	ldrsh r2, [r3, #0x4e]
	ldrsh r3, [r3, #0x50]
	bl ObjRect__SetBox2D
	str r4, [r4, #0x2b4]
	ldr r0, [r4, #0x2b0]
	add r6, r4, #0xcc
	bic r0, r0, #4
	str r0, [r4, #0x2b0]
	add r0, r6, #0x400
	mov r1, #0
	bl AnimatorMDL__Init
	cmp r5, #0
	bne _02161AA4
	mov r3, #0
	ldr r0, =bossAssetFiles
	str r3, [sp]
	ldr r1, [r0, #0]
	add r0, r6, #0x400
	mov r2, #1
	bl AnimatorMDL__SetResource
	b _02161AC8
_02161AA4:
	cmp r5, #1
	blo _02161AC8
	mov r3, #0
	ldr r0, =bossAssetFiles
	str r3, [sp]
	ldr r1, [r0, #0]
	add r0, r6, #0x400
	mov r2, #2
	bl AnimatorMDL__SetResource
_02161AC8:
	mov r2, #0
	str r2, [r6, #0x448]
	str r2, [r6, #0x44c]
	ldr r0, =0x000034CC
	str r2, [r6, #0x450]
	str r0, [r6, #0x418]
	str r0, [r6, #0x41c]
	str r0, [r6, #0x420]
	mov r0, #4
	ldr r1, =BossHelpers__Model__RenderCallback
	strb r0, [r6, #0x40a]
	mov r7, #3
	add r0, r6, #0x490
	mov r3, #6
	str r7, [sp]
	bl NNS_G3dRenderObjSetCallBack
	cmp r5, #0
	bne _02161B2C
	mov r3, #0
	str r3, [sp]
	ldr r0, [r6, #0x494]
	ldr r1, =aArmHit
	mov r2, #0x1d
	bl BossHelpers__Model__Init
	b _02161B4C
_02161B2C:
	cmp r5, #1
	bne _02161B4C
	mov r3, #0
	str r3, [sp]
	ldr r0, [r6, #0x494]
	ldr r1, =aArmHit
	mov r2, #0x1d
	bl BossHelpers__Model__Init
_02161B4C:
	mov r1, #0x78000
	mov r0, r4
	str r1, [r4, #0x46c]
	mov r1, #0x32000
	str r1, [r4, #0x470]
	bl StageTask__InitSeqPlayer
	mov r0, r4
	mov r1, #0
	bl Boss3Arm__Func_2168F84
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__SetInkSplatFlag(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =Boss3Stage__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	mov r1, #1
	str r1, [r0, #0x40c]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__LoadAssets(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x68
	mov r4, r0
	bl MapFarSys__GetAsset
	str r0, [r4]
	ldr r1, =gameArchiveStage
	add r0, sp, #0
	ldr r2, [r1, #0]
	ldr r1, =aExc_3
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #7
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #4]
	add r0, sp, #0
	mov r1, #8
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #8]
	add r0, sp, #0
	mov r1, #0x30
	bl NNS_FndGetArchiveFileByIndex
	str r0, [r4, #0xc]
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	add sp, sp, #0x68
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__ProcessSpatialAudio(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r2, =gPlayer
	mov r5, r1
	add r4, sp, #0
	mov r3, #0
	ldr r2, [r2, #0]
	str r3, [r4]
	str r3, [r4, #4]
	str r3, [r4, #8]
	mov r4, r0
	ldr r0, [r2, #0x44]
	ldr r2, =0x006BAA99
	mov r1, #0x40000
	bl BossHelpers__Arena__GetAngle
	sub r0, r5, r0
	mov r0, r0, lsl #0x10
	mov r5, r0, asr #0x10
	mov r0, r5, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0x8000
	blo _02161CFC
	bl GetSpatialAudioDropoffRate
	sub r1, r5, #0x8000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r1, asr #4
	ldr r1, =FX_SinCosTable_
	mov r2, r2, lsl #2
	ldrsh r3, [r1, r2]
	ldr r2, =gPlayer
	add r1, sp, #0
	smull ip, r3, r0, r3
	adds ip, ip, #0x800
	ldr lr, [r2]
	adc r0, r3, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r0, lsl #20
	ldr r3, [lr, #0x44]
	mov r0, r4
	sub r2, r3, r2
	str r2, [sp]
	bl ProcessSpatialSfx
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
_02161CFC:
	bl GetSpatialAudioDropoffRate
	mov r1, r6, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r1, asr #4
	ldr r1, =FX_SinCosTable_
	mov r2, r2, lsl #2
	ldrsh r3, [r1, r2]
	ldr r2, =gPlayer
	add r1, sp, #0
	smull ip, r3, r0, r3
	adds ip, ip, #0x800
	ldr lr, [r2]
	adc r0, r3, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r0, lsl #20
	ldr r3, [lr, #0x44]
	mov r0, r4
	add r2, r3, r2
	str r2, [sp]
	bl ProcessSpatialSfx
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__DrawPlayer(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	ldr r1, =Boss3Stage__TaskSingleton
	mov r4, r0
	ldr r0, [r1, #0]
	bl GetTaskWork_
	ldr r1, [r4, #0x20]
	mov r5, r0
	tst r1, #0x20
	ldmneia sp!, {r3, r4, r5, pc}
	bl Boss3Stage__Func_2162918
	ldr r0, [r5, #0x40c]
	cmp r0, #0
	beq _02161DC0
	ldr r0, =gPlayer
	ldr r1, [r5, #0x3cc]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x48]
	cmp r0, r1
	ble _02161DBC
	bl SwapBuffer3D_GetPrimaryScreen
	cmp r0, #0
	beq _02161DC0
_02161DBC:
	bl Boss3Stage__Func_2162990
_02161DC0:
	ldr r2, =0x006BAA99
	ldr r3, =0x00107FC0
	mov r0, r4
	mov r1, #0x40000
	bl BossHelpers__Arena__GetPlayerDrawMtx
	mov r4, r0
	bl Boss3Stage__Func_2161E28
	add r0, r5, #0x24
	add r0, r0, #0x400
	bl BossHelpers__ApplyModifiedLights
	ldr r0, [r5, #0x41c]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, r4
	bl BossArena__SetAngleTarget
	mov r0, #2
	bl BossArena__GetCamera
	mov r1, r4
	bl BossArena__SetAngleTarget
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2161E28(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =Boss3Stage__TaskSingleton
	ldr r0, [r0, #4]
	blx r0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Action_PlayerRebound(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x1c]
	tst r1, #0x10
	ldmeqia sp!, {r4, pc}
	bl Player__Action_DestroyAttackRecoil
	add r0, r4, #0x500
	mov r1, #0x18
	strh r1, [r0, #0xfa]
	ldr r0, [r4, #0xbc]
	cmp r0, #0
	mov r0, #0x2000
	rsblt r0, r0, #0
	str r0, [r4, #0x98]
	mov r0, #0
	str r0, [r4, #0xc8]
	mov r0, #0x4000
	rsb r0, r0, #0
	str r0, [r4, #0x9c]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2161E90(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x1c]
	tst r1, #0x10
	ldmeqia sp!, {r4, pc}
	bl Player__Action_DestroyAttackRecoil
	add r0, r4, #0x500
	mov r1, #0x18
	strh r1, [r0, #0xfa]
	ldr r0, [r4, #0xbc]
	cmp r0, #0
	mov r0, #0x2000
	rsblt r0, r0, #0
	str r0, [r4, #0x98]
	mov r0, #0
	str r0, [r4, #0xc8]
	mov r0, #0x5800
	rsb r0, r0, #0
	str r0, [r4, #0x9c]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2161EE0(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x1c]
	tst r1, #0x10
	ldmeqia sp!, {r4, pc}
	bl Player__Action_DestroyAttackRecoil
	add r0, r4, #0x500
	mov r1, #0x18
	strh r1, [r0, #0xfa]
	ldr r0, [r4, #0xbc]
	cmp r0, #0
	ble _02161F24
	mov r0, #0x2000
	str r0, [r4, #0x98]
	mov r0, #0
	str r0, [r4, #0xc8]
	b _02161F5C
_02161F24:
	bne _02161F48
	ldr r0, [r4, #0x20]
	tst r0, #1
	mov r0, #0x2000
	rsbne r0, r0, #0
	str r0, [r4, #0x98]
	mov r0, #0
	str r0, [r4, #0xc8]
	b _02161F5C
_02161F48:
	mov r0, #0x2000
	rsb r0, r0, #0
	str r0, [r4, #0x98]
	mov r0, #0
	str r0, [r4, #0xc8]
_02161F5C:
	mov r0, #0x5000
	rsb r0, r0, #0
	str r0, [r4, #0x9c]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__PlayHitSfx(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r2, #0
	mov r1, #0x8c
	str r2, [sp]
	mov r4, r0
	str r1, [sp, #4]
	sub r1, r1, #0x8d
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x374]
	ldr r1, =0x0000FFFF
	ldr r2, [r0, #0x3c0]
	ldr r0, [r0, #0x138]
	mov r2, r2, lsl #6
	bl NNS_SndPlayerSetTrackPitch
	ldr r1, [r4, #0x374]
	ldr r0, [r1, #0x3c0]
	add r0, r0, #1
	str r0, [r1, #0x3c0]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2161FD4(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, =gPlayer
	ldr r1, [r1, #0]
	ldr r1, [r1, #0x1c]
	tst r1, #1
	ldmeqia sp!, {r3, pc}
	bl Boss3Stage__Func_2161FF8
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2161FF8(Boss3Stage *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r1, #0
	str r1, [r0, #0x3c0]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__CreateHitFX(Boss3Stage *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =BossFX__CreateHitA
	ldmia r0, {r1, r2, r3}
	mov r0, #0
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162018(Boss3Stage *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =BossFX__CreateHitB
	ldmia r0, {r1, r2, r3}
	mov r0, #0
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_216202C(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r0, #1
	bl BossArena__GetCamera
	mov r5, r0
	bl GetScreenShakeOffsetX
	mov r4, r0
	bl GetScreenShakeOffsetY
	mov r1, r4
	mov r2, r0
	mov r0, r5
	mov r3, #0
	bl BossArena__SetNextPos
	mov r0, #2
	bl BossArena__GetCamera
	mov r5, r0
	bl GetScreenShakeOffsetX
	mov r4, r0
	bl GetScreenShakeOffsetY
	mov r1, r4
	mov r2, r0
	mov r0, r5
	mov r3, #0
	bl BossArena__SetNextPos
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_216208C(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r1, =_02179E00
	add r3, sp, #0
	mov r4, r0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #4
	bl BossArena__SetType
	mov r0, #1
	bl BossArena__GetCamera
	add r1, sp, #0
	mov r5, r0
	bl BossArena__SetUpVector
	mov r0, r5
	mov r1, #1
	bl BossArena__SetCameraType
	ldr r1, =gPlayer
	mov r0, r5
	ldr r1, [r1, #0]
	mov r2, #0
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	ldr r2, [r4, #0x3cc]
	mov r1, #0
	mov r0, r5
	mov r3, r1
	rsb r2, r2, #0x64000
	bl BossArena__SetTracker1TargetPos
	mov r0, r5
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r5
	mov r1, #1
	bl BossArena__SetTracker1UseObj3D
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	mov r1, #0xe6000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r5
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r5
	bl BossArena__ApplyAmplitudeXZTarget
	mov r0, r5
	mov r1, #0x5000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r5
	mov r1, #0x100
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r5
	bl BossArena__ApplyAmplitudeYTarget
	ldr r0, =gPlayer
	ldr r2, =0x006BAA99
	ldr r0, [r0, #0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__GetAngle
	mov r1, r0
	mov r0, r5
	bl BossArena__SetAngleTarget
	mov r0, r5
	bl BossArena__ApplyAngleTarget
	bl BossArena__DoProcess
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	mov r0, #2
	bl BossArena__GetCamera
	add r1, sp, #0
	mov r5, r0
	bl BossArena__SetUpVector
	mov r0, r5
	mov r1, #1
	bl BossArena__SetCameraType
	ldr r1, =gPlayer
	mov r0, r5
	ldr r1, [r1, #0]
	mov r2, #0
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	mov r1, #0
	ldr r4, [r4, #0x3cc]
	ldr r2, =0xFFE3E000
	mov r0, r5
	mov r3, r1
	sub r2, r2, r4
	bl BossArena__SetTracker1TargetPos
	mov r0, r5
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r5
	mov r1, #1
	bl BossArena__SetTracker1UseObj3D
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	mov r1, #0xe6000
	bl BossArena__SetAmplitudeXZTarget
	mov r0, r5
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r5
	bl BossArena__ApplyAmplitudeXZTarget
	mov r0, r5
	mov r1, #0x64000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r5
	mov r1, #0x100
	bl BossArena__SetAmplitudeYSpeed
	mov r0, r5
	bl BossArena__ApplyAmplitudeYTarget
	ldr r0, =gPlayer
	mov r1, #0x40000
	ldr r0, [r0, #0]
	ldr r2, =0x006BAA99
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__GetAngle
	mov r1, r0
	mov r0, r5
	bl BossArena__SetAngleTarget
	mov r0, r5
	bl BossArena__ApplyAngleTarget
	bl BossArena__DoProcess
	mov r0, r5
	bl BossArena__UpdateTracker1TargetPos
	mov r0, r5
	bl BossArena__UpdateTracker0TargetPos
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_21622B4(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #0xe6000
	mov r4, r0
	bl BossArena__SetAmplitudeXZTarget
	ldr r2, [r5, #0x3cc]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	rsb r2, r2, #0x64000
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x5000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x80
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #0xe6000
	bl BossArena__SetAmplitudeXZTarget
	ldr ip, [r5, #0x3cc]
	mov r0, r4
	mov r1, #0
	ldr r2, =0xFFE3E000
	mov r3, r1
	sub r2, r2, ip
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x64000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x80
	mov r2, #0
	bl BossArena__SetTracker1Speed
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162370(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #0xe6000
	mov r4, r0
	bl BossArena__SetAmplitudeXZTarget
	ldr r2, [r5, #0x3cc]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	rsb r2, r2, #0x64000
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x5000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #0xe6000
	bl BossArena__SetAmplitudeXZTarget
	ldr ip, [r5, #0x3cc]
	mov r0, r4
	mov r1, #0
	ldr r2, =0xFFE3E000
	mov r3, r1
	sub r2, r2, ip
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x64000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_216242C(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	ldr r1, =0x00136000
	mov r4, r0
	bl BossArena__SetAmplitudeXZTarget
	ldr r2, [r5, #0x3cc]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	rsb r2, r2, #0x64000
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x5000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	ldr r1, =0x00136000
	bl BossArena__SetAmplitudeXZTarget
	ldr ip, [r5, #0x3cc]
	mov r0, r4
	mov r1, #0
	ldr r2, =0xFFE3E000
	mov r3, r1
	sub r2, r2, ip
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x64000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_21624EC(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	ldr r1, =0x00136000
	mov r4, r0
	bl BossArena__SetAmplitudeXZTarget
	mov r1, #0
	ldr r3, [r5, #0x3cc]
	sub r2, r1, #0x64000
	mov r0, r4
	sub r2, r2, r3
	mov r3, r1
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0xc8000
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x80
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeYSpeed
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	ldr r1, =0x00136000
	bl BossArena__SetAmplitudeXZTarget
	ldr r3, [r5, #0x3cc]
	mov r0, r4
	mov r1, #0
	sub r2, r1, #0x1f4000
	sub r2, r2, r3
	mov r3, r1
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0xc8000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x80
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeYSpeed
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_21625C8(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #0xe6000
	mov r4, r0
	bl BossArena__SetAmplitudeXZTarget
	ldr r2, [r5, #0x3cc]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	rsb r2, r2, #0x1f4000
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0xc8000
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x80
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #0xe6000
	bl BossArena__SetAmplitudeXZTarget
	ldr r1, [r5, #0x3c4]
	mov r0, r4
	rsb r2, r1, #0x64000
	mov r1, #0
	mov r3, r1
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x5000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x80
	mov r2, #0
	bl BossArena__SetTracker1Speed
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162680(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #0xe6000
	mov r4, r0
	bl BossArena__SetAmplitudeXZTarget
	ldr r2, [r5, #0x3cc]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	rsb r2, r2, #0x1f4000
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0xc8000
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #0xe6000
	bl BossArena__SetAmplitudeXZTarget
	ldr r1, [r5, #0x3c4]
	mov r0, r4
	rsb r2, r1, #0x64000
	mov r1, #0
	mov r3, r1
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x5000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x400
	mov r2, #0
	bl BossArena__SetTracker1Speed
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162738(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #1
	bl BossArena__GetCamera
	mov r1, #0xe6000
	mov r4, r0
	bl BossArena__SetAmplitudeXZTarget
	ldr r2, [r5, #0x3cc]
	mov r1, #0
	mov r0, r4
	mov r3, r1
	rsb r2, r2, #0x1f4000
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0xc8000
	rsb r1, r1, #0
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x200
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x80
	mov r2, #0
	bl BossArena__SetTracker1Speed
	mov r0, #2
	bl BossArena__GetCamera
	mov r4, r0
	mov r1, #0xe6000
	bl BossArena__SetAmplitudeXZTarget
	ldr r1, [r5, #0x3c4]
	mov r0, r4
	rsb r2, r1, #0x64000
	mov r1, #0
	mov r3, r1
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x5000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0x80
	bl BossArena__SetAmplitudeXZSpeed
	mov r0, r4
	mov r1, #0x80
	mov r2, #0
	bl BossArena__SetTracker1Speed
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_21627F0(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r0, #2
	bl BossArena__GetCamera
	ldr r1, [r5, #0x398]
	add r3, sp, #0
	add r1, r1, #0x4c0
	mov r4, r0
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r1, #0
	mov r3, #1
	str r3, [r5, #0x41c]
	mov r0, r4
	mov r2, r1
	mov r3, r1
	bl BossArena__SetTracker1TargetWork
	ldr r1, [sp]
	ldr r2, [sp, #4]
	ldr r3, [sp, #8]
	mov r0, r4
	bl BossArena__SetTracker1TargetPos
	mov r0, r4
	mov r1, #0x32000
	bl BossArena__SetAmplitudeYTarget
	mov r0, r4
	mov r1, #0xb4000
	bl BossArena__SetAmplitudeXZTarget
	ldr r1, [r5, #0x398]
	mov r0, r4
	add r1, r1, #0x400
	ldrh r1, [r1, #0x44]
	sub r1, r1, #0x2000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl BossArena__SetAngleTarget
	mov r1, #0xcc
	mov r0, r4
	mov r2, r1
	bl BossArena__SetTracker1Speed
	mov r1, #0xcc
	mov r0, r4
	mov r2, r1
	bl BossArena__SetTracker0Speed
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__LoadWaterLights(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	mov r0, #0
	mov r2, #0x32
	mov r6, r1
	bl MIi_CpuClear16
	mov r5, r6
	mov r4, #0
_021628CC:
	ldr r0, [r7, #0x370]
	mov r1, r5
	mov r2, r4
	bl GetDrawStateLight
	mov r0, r4, lsl #3
	add r2, r6, r4, lsl #3
	ldrh r1, [r6, r0]
	ldrh r0, [r2, #2]
	add r4, r4, #1
	cmp r4, #3
	strh r1, [r2, #0x18]
	strh r0, [r2, #0x1a]
	ldrh r1, [r2, #4]
	ldrh r0, [r2, #6]
	add r5, r5, #8
	strh r1, [r2, #0x1c]
	strh r0, [r2, #0x1e]
	blt _021628CC
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162918(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r0, #1
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	mov r5, r0
	mov r0, #2
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	mov r6, r0
	bl SwapBuffer3D_GetPrimaryScreen
	cmp r0, #0
	beq _02162960
	ldr r1, [r5, #0x24]
	ldr r0, [r4, #0x3cc]
	rsb r1, r1, #0
	cmp r1, r0
	bge _02162980
_02162960:
	bl SwapBuffer3D_GetPrimaryScreen
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #0x24]
	ldr r0, [r4, #0x3cc]
	rsb r1, r1, #0
	cmp r1, r0
	ldmltia sp!, {r4, r5, r6, pc}
_02162980:
	add r0, r4, #0x56
	add r0, r0, #0x400
	bl BossHelpers__RevertModifiedLights
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162990(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r7, #0
	mov r4, #0x1000
	rsb r4, r4, #0
	add r6, sp, #0
	mov r5, r7
_021629AC:
	mov r0, r7
	mov r1, r6
	strh r5, [sp]
	strh r4, [sp, #2]
	strh r5, [sp, #4]
	strh r5, [sp, #6]
	bl SwapBuffer3D_SetLight
	add r7, r7, #1
	cmp r7, #3
	blt _021629AC
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__GetPhase(Boss3Stage *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =gameState
	ldr r2, [r1, #0x14]
	cmp r2, #3
	ldreq r1, [r1, #0x70]
	cmpeq r1, #0xf
	moveq r0, #3
	bxeq lr
	add r0, r0, #0x300
	ldrsh r3, [r0, #0xb8]
	ldr r2, =_02179DB0
	mov r0, #0
_02162A08:
	mov r1, r0, lsl #1
	ldrh r1, [r2, r1]
	cmp r1, r3
	bxlt lr
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #3
	blo _02162A08
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__GetDamageMultiplier(Boss3Stage *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r0, =gameState
	ldr r1, =_02179DCC
	ldr r0, [r0, #0x18]
	ldr r0, [r1, r0, lsl #2]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__GetBaseDamage(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl Boss3Stage__GetPhase
	ldr r1, =_02179DC4
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__GetHitDamage(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl Boss3Stage__GetDamageMultiplier
	mov r4, r0
	mov r0, r5
	bl Boss3Stage__GetBaseDamage
	mul r0, r4, r0
	mov r0, r0, lsl #4
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162A98(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl Boss3Stage__GetPhase
	ldr r1, =_02179E1C
	ldr r0, [r1, r0, lsl #2]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162AB0(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl Boss3Stage__GetPhase
	ldr r1, =_02179DE4
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162ACC(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl Boss3Stage__GetPhase
	ldr r1, =_02179DBC
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162AE8(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl Boss3Stage__GetPhase
	ldr r1, =_02179DDC
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162B04(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl Boss3Stage__GetPhase
	ldr r1, =_02179DD4
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162B20(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, =_mt_math_rand
	mov r3, #0
	ldr r5, [r4, #0]
	ldr ip, =0x00196225
	ldr lr, =0x3C6EF35F
	mov r2, r3
	mla lr, r5, ip, lr
	mov ip, lr, lsr #0x10
	mov ip, ip, lsl #0x10
	str lr, [r4]
	cmp r1, #0
	mov r5, ip, lsr #0x10
	bls _02162B8C
_02162B58:
	mov r4, r2, lsl #1
	ldrh r4, [r0, r4]
	add r3, r3, r4
	mov r3, r3, lsl #0x10
	cmp r5, r3, lsr #16
	mov r3, r3, lsr #0x10
	movls r0, r2
	ldmlsia sp!, {r3, r4, r5, pc}
	add r2, r2, #1
	mov r2, r2, lsl #0x10
	cmp r1, r2, lsr #16
	mov r2, r2, lsr #0x10
	bhi _02162B58
_02162B8C:
	sub r0, r2, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162BA8(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl Boss3Stage__GetPhase
	ldr r2, =_02179E5C
	mov r1, #6
	mla r0, r1, r0, r2
	mov r1, #3
	bl Boss3Stage__Func_2162B20
	and r0, r0, #0xff
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162BD0(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl Boss3Stage__GetPhase
	ldr r2, =_02179E4C
	mov r1, #2
	add r0, r2, r0, lsl #2
	bl Boss3Stage__Func_2162B20
	and r0, r0, #0xff
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162BF4(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r5, =_02179DB6
	mov r6, r0
	mov r4, #3
_02162C04:
	mov r0, r5
	mov r1, r4
	bl Boss3Stage__Func_2162B20
	and r0, r0, #0xff
	cmp r0, #2
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #0x374]
	ldr r1, [r1, #0xaec]
	cmp r1, #0
	bne _02162C04
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162C34(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r11, r0
	add r1, r11, #0xaf0
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	ldrb r0, [r11, #0xadc]
	cmp r0, #2
	bne _02162CAC
	ldr r2, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r4, [r2, #0]
	ldr r1, =0x3C6EF35F
	ldr r3, =_02179E3C
	mla r1, r4, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #1
	mov r0, r0, lsl #0x10
	movs r0, r0, lsr #0x10
	str r1, [r2]
	ldr r0, [r3, r0, lsl #2]
	moveq r1, #1
	str r0, [r11, #0xaf0]
	ldr r0, =_02179E3C
	movne r1, #0
	ldr r0, [r0, r1, lsl #2]
	str r0, [r11, #0xaf4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02162CAC:
	cmp r0, #4
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, =_02179D9C
	mov r8, #0
	ldrb r2, [r0, #0]
	ldrb r1, [r0, #1]
	strb r2, [sp]
	strb r1, [sp, #1]
	ldrb r1, [r0, #2]
	ldrb r0, [r0, #3]
	strb r1, [sp, #2]
	strb r0, [sp, #3]
_02162CDC:
	ldr r6, =_mt_math_rand
	ldr r4, =0x00196225
	ldr r5, =0x3C6EF35F
	add r10, sp, #1
	mov r7, #1
	add r9, sp, #0
_02162CF4:
	ldr r0, [r6, #0]
	mov r1, r7
	mla r2, r0, r4, r5
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r2, [r6]
	bl FX_ModS32
	cmp r0, #0
	ldr r0, [r6, #0]
	mov r1, r7
	bge _02162D44
	mla r2, r0, r4, r5
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r2, [r6]
	bl FX_ModS32
	rsb r0, r0, #0
	b _02162D5C
_02162D44:
	mla r2, r0, r4, r5
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r2, [r6]
	bl FX_ModS32
_02162D5C:
	mov r0, r0, lsl #0x10
	ldrb r2, [r9, r0, lsr #16]
	ldrb r1, [r10, #0]
	add r7, r7, #1
	cmp r7, #4
	eor r1, r2, r1
	strb r1, [r9, r0, lsr #16]
	ldrb r2, [r10, #0]
	and r1, r1, #0xff
	eor r1, r2, r1
	strb r1, [r10], #1
	ldrb r2, [r9, r0, lsr #16]
	and r1, r1, #0xff
	eor r1, r2, r1
	strb r1, [r9, r0, lsr #16]
	blt _02162CF4
	add r8, r8, #1
	cmp r8, #5
	blt _02162CDC
	ldr r2, =_02179E3C
	mov r3, #0
_02162DB0:
	ldrb r1, [r9], #1
	add r0, r11, r3, lsl #2
	add r3, r3, #1
	ldr r1, [r2, r1, lsl #2]
	cmp r3, #4
	str r1, [r0, #0xaf0]
	blt _02162DB0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162DE4(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =_02179DA4
	mov r1, #3
	bl Boss3Stage__Func_2162B20
	and r0, r0, #0xff
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162E00(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl Boss3Stage__GetPhase
	ldr r2, =_02179E0C
	mov r1, #2
	add r0, r2, r0, lsl #2
	bl Boss3Stage__Func_2162B20
	ands r0, r0, #0xff
	moveq r4, #2
	beq _02162E2C
	cmp r0, #1
	moveq r4, #4
_02162E2C:
	mov r0, r4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162E38(Boss3Stage *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r3, =_mt_math_rand
	ldr r1, =0x00196225
	ldr ip, [r3]
	ldr r2, =0x3C6EF35F
	mla r2, ip, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #1
	mov r1, r1, lsl #0x10
	str r2, [r3]
	movs r1, r1, lsr #0x10
	ldr r1, [r0, #0xa3c]
	movne r3, #1
	ldrne r2, [r1, #0x398]
	movne r1, #0
	strne r3, [r2, #0x478]
	ldrne r0, [r0, #0xa3c]
	ldrne r0, [r0, #0x39c]
	strne r1, [r0, #0x478]
	bxne lr
	ldr r2, [r1, #0x398]
	mov r3, #0
	mov r1, #1
	str r3, [r2, #0x478]
	ldr r0, [r0, #0xa3c]
	ldr r0, [r0, #0x39c]
	str r1, [r0, #0x478]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162EB8(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x374]
	add r0, r0, #0xa00
	ldrh r1, [r0, #0xf2]
	cmp r1, #2
	movhs r1, #0
	strhsh r1, [r0, #0xf2]
	mov r0, r4
	bl Boss3Stage__GetPhase
	ldr r1, [r4, #0x374]
	ldr r2, =_02179E2C
	add r1, r1, #0xa00
	ldrh r3, [r1, #0xf2]
	add r0, r2, r0, lsl #2
	mov r2, r3, lsl #1
	ldrh r2, [r2, r0]
	add r0, r3, #1
	strh r0, [r1, #0xf2]
	and r0, r2, #0xff
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2162F10(Boss3Stage *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r0, #2
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__State_2162F18(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl Boss3Stage__Func_2161FD4
	ldr r0, [r4, #0x420]
	cmp r0, #0
	bne _02162F38
	mov r0, r4
	bl Boss3Stage__Func_216202C
_02162F38:
	add r0, r4, #0x24
	add r0, r0, #0x400
	bl BossHelpers__ProcessLights
	ldr r1, [r4, #0x3b4]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Destructor(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x68
	mov r4, r0
	bl GetTaskWork_
	mov r5, r0
	add r0, r5, #0x108
	add r7, r0, #0x400
	mov r6, #0
_02162F74:
	mov r0, r7
	bl AnimatorMDL__Release
	add r6, r6, #1
	cmp r6, #4
	add r7, r7, #0x144
	blt _02162F74
	bl EnableSpatialVolume
	ldr r1, =gameArchiveStage
	add r0, sp, #0
	ldr r2, [r1, #0]
	ldr r1, =aExc_3
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, #0x19
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultRelease
	add r0, sp, #0
	mov r1, #0x1c
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultRelease
	add r0, sp, #0
	mov r1, #0x20
	bl NNS_FndGetArchiveFileByIndex
	bl NNS_G3dResDefaultRelease
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	add r0, r5, #0x218
	add r5, r0, #0x800
	mov r6, #0
_02162FE8:
	mov r0, r5
	bl AnimatorSprite3D__Release
	add r6, r6, #1
	cmp r6, #5
	add r5, r5, #0x104
	blt _02162FE8
	ldr r1, =renderCoreSwapBuffer
	mov r2, #0
	mov r0, r4
	str r2, [r1, #4]
	bl GameObject__Destructor
	add sp, sp, #0x68
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Draw(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bl GetCurrentTaskWork_
	mov r7, r0
	ldr r0, [r7, #0x20]
	tst r0, #0x20
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r0, r7, #0x24
	add r0, r0, #0x400
	bl BossHelpers__RevertModifiedLights
	mov r0, r7
	bl Boss3Stage__Func_2162918
	ldr r2, [r7, #0x3c4]
	add r0, r7, #0x108
	mov r1, #0
	str r1, [r0, #0x448]
	rsb r2, r2, #0
	str r2, [r0, #0x44c]
	str r1, [r0, #0x450]
	add r0, r0, #0x400
	bl AnimatorMDL__Draw
	ldr r2, [r7, #0x3cc]
	add r0, r7, #0x24c
	mov r1, #0
	str r1, [r0, #0x448]
	rsb r2, r2, #0
	str r2, [r0, #0x44c]
	str r1, [r0, #0x450]
	add r0, r0, #0x400
	bl AnimatorMDL__Draw
	ldr r0, [r7, #0x3cc]
	mov r1, #0
	str r1, [r7, #0x7d8]
	rsb r0, r0, #0
	str r0, [r7, #0x7dc]
	add r0, r7, #0x790
	str r1, [r7, #0x7e0]
	bl AnimatorMDL__ProcessAnimation
	add r0, r7, #0x790
	bl AnimatorMDL__Draw
	ldr r0, [r7, #0x3cc]
	add r4, r7, #0xd4
	mov r1, #0
	str r1, [r4, #0x848]
	rsb r0, r0, #0
	str r0, [r4, #0x84c]
	add r0, r4, #0x800
	str r1, [r4, #0x850]
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #0x800
	bl AnimatorMDL__Draw
	mov r0, #1
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	ldr r0, [r7, #0x3cc]
	ldr r1, [r7, #0x3c4]
	add r0, r0, #0x32000
	cmp r1, r0
	ble _021631C0
	mov r8, #0
	add r0, r7, #0x218
	ldr r10, =_02179E74
	add r9, r0, #0x800
	mov r6, r8
	mov r5, r8
	mov r4, #0x78
_0216312C:
	add r1, r7, r8, lsl #2
	ldr r0, [r1, #0xf40]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r1, #0xf40]
	bne _021631AC
	ldr r2, [r7, #0x3c4]
	ldr r1, [r1, #0xf2c]
	ldmia r10, {r0, r3}
	sub r2, r3, r2
	str r0, [r9, #0x48]
	add r0, r2, r1
	str r0, [r9, #0x4c]
	ldr r3, [r10, #8]
	mov r0, r9
	mov r1, r6
	mov r2, r6
	str r3, [r9, #0x50]
	bl AnimatorSprite3D__ProcessAnimation
	ldr r0, [r9, #0xcc]
	tst r0, #0x40000000
	beq _02163194
	add r0, r7, r8, lsl #2
	str r5, [r0, #0xf2c]
	str r4, [r0, #0xf40]
	b _021631AC
_02163194:
	add r2, r7, r8, lsl #2
	ldr r1, [r2, #0xf2c]
	mov r0, r9
	add r1, r1, #0x2000
	str r1, [r2, #0xf2c]
	bl AnimatorSprite3D__Draw
_021631AC:
	add r8, r8, #1
	cmp r8, #5
	add r9, r9, #0x104
	add r10, r10, #0xc
	blt _0216312C
_021631C0:
	add r0, r7, #0x24
	add r0, r0, #0x400
	bl BossHelpers__ApplyModifiedLights
	add r1, r7, #0x3dc
	mov r0, #0x1e
	bl BossHelpers__Model__SetMatrixMode
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__State_21631E0(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl Boss3Stage__Func_216208C
	ldr r2, =0x0400000A
	mov r0, #2
	ldrh r1, [r2, #0]
	and r1, r1, #0x43
	orr r1, r1, #4
	orr r1, r1, #0x6000
	strh r1, [r2]
	bl BossArena__SetBackgroundType
	bl BossArena__GetField4A8
	ldr r2, [r5, #0x364]
	mov r1, #1
	str r2, [r0, #4]
	strb r1, [r0, #0x14]
	mov r1, #0
	strh r1, [r0, #0x2c]
	strh r1, [r0, #0x2e]
	ldr r0, [r5, #0x364]
	bl GetBackgroundPixels
	ldr r2, =VRAMSystem__VRAM_BG
	mov r1, #0
	ldr r2, [r2, #0]
	add r2, r2, #0x4000
	bl LoadCompressedPixels
	ldr r0, [r5, #0x364]
	bl GetBackgroundPalette
	ldr r2, =VRAMSystem__VRAM_PALETTE_BG
	mov r1, #0
	ldr r2, [r2, #0]
	bl LoadCompressedPalette
	mov r0, #0
	sub r1, r0, #0x104
	bl BossArena__SetBoundsX
	mov r2, #0x4000000
	ldr r1, [r2, #0]
	ldr r0, [r2, #0]
	and r1, r1, #0x1f00
	mov r3, r1, lsr #8
	bic r1, r0, #0x1f00
	orr r0, r3, #2
	orr r0, r1, r0, lsl #8
	str r0, [r2]
	bl CreateSwapBuffer3D
	bl GetSwapBuffer3DWork
	mov r4, r0
	bl GetSwapBuffer3DWork
	mov r1, #0
	strh r1, [r4, #0x20]
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	bic r1, r1, #1
	orr r1, r1, #1
	strh r1, [r4, #0x20]
	ldrh r1, [r4, #0x20]
	ldrh r2, [r0, #0x7c]
	mov r1, r1, lsl #0x1f
	mov r1, r1, lsr #0x1f
	bic r2, r2, #1
	and r1, r1, #1
	orr r1, r2, r1
	strh r1, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	orr r1, r1, #0x200
	strh r1, [r4, #0x20]
	ldrh r2, [r4, #0x20]
	ldrh r3, [r0, #0x7c]
	ldr r1, =gPlayer
	mov r2, r2, lsl #0x16
	mov r2, r2, lsr #0x1f
	bic r3, r3, #0x200
	mov r2, r2, lsl #0x1f
	orr r2, r3, r2, lsr #22
	strh r2, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	orr r2, r2, #0x400
	strh r2, [r4, #0x20]
	ldrh r2, [r4, #0x20]
	ldrh r3, [r0, #0x7c]
	mov r2, r2, lsl #0x15
	mov r2, r2, lsr #0x1f
	bic r3, r3, #0x400
	mov r2, r2, lsl #0x1f
	orr r2, r3, r2, lsr #21
	strh r2, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	orr r2, r2, #0x800
	strh r2, [r4, #0x20]
	ldrh r2, [r4, #0x20]
	ldrh r3, [r0, #0x7c]
	mov r2, r2, lsl #0x14
	mov r2, r2, lsr #0x1f
	bic r3, r3, #0x800
	mov r2, r2, lsl #0x1f
	orr r2, r3, r2, lsr #20
	strh r2, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	orr r2, r2, #0x1000
	strh r2, [r4, #0x20]
	ldrh r2, [r4, #0x20]
	ldrh r3, [r0, #0x7c]
	mov r2, r2, lsl #0x13
	mov r2, r2, lsr #0x1f
	bic r3, r3, #0x1000
	mov r2, r2, lsl #0x1f
	orr r2, r3, r2, lsr #19
	strh r2, [r0, #0x7c]
	ldr r0, [r1, #0]
	bl BossPlayerHelpers_Action_SetBoss3DefendEvent
	ldr r2, =gPlayer
	ldr r1, =Boss3Stage__TaskSingleton
	ldr ip, [r2]
	ldr r3, =Boss3__DrawPlayer
	ldr r4, [ip, #0xfc]
	add r0, r5, #0x300
	str r4, [r1, #4]
	str r3, [ip, #0xfc]
	ldr r2, [r2, #0]
	ldr r1, [r2, #0x20]
	orr r1, r1, #0x2000
	str r1, [r2, #0x20]
	ldrsh r0, [r0, #0xb8]
	bl UpdateBossHealthHUD
	mov r0, #0
	bl SetHUDActiveScreen
	ldr r0, =Boss3Stage__StateStage_2163400
	str r0, [r5, #0x3b4]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__StateStage_2163400(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl Boss3Stage__Func_216208C
	ldr r0, =Boss3Stage__StateStage_216341C
	str r0, [r4, #0x3b4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__StateStage_216341C(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x374]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl TitleCard__GetProgress
	cmp r0, #5
	ldmneia sp!, {r4, pc}
	mov r1, #0
	ldr r0, =Boss3Stage__StateStage_2163454
	str r1, [r4, #0x414]
	str r0, [r4, #0x3b4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void Boss3Stage__StateStage_2163454(Boss3Stage *work)
{
    // Do nothing
}

NONMATCH_FUNC void Boss3Stage__Func_2163458(Boss3Stage *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r0, r0, #0x300
	ldrsh r3, [r0, #0xba]
	ldr r2, =_02179DA0
	mov r0, #0
_02163468:
	mov r1, r0, lsl #1
	ldrh r1, [r2, r1]
	cmp r1, r3
	bxgt lr
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #2
	blo _02163468
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2163494(Boss3Stage *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r2
	mov r6, r0
	cmp r1, r5
	add r4, r1, r5
	bge _02163548
	ldr r1, [r6, #0x3c4]
	ldr r0, [r6, #0x3cc]
	sub r1, r1, #0x14000
	cmp r0, r1
	ble _021634F4
	ldr r0, [r6, #0x3d0]
	cmp r0, r1
	bge _021634F4
	mov r1, #0
	mov r0, #0xa7
	str r1, [sp]
	sub r1, r0, #0xa8
	str r0, [sp, #4]
	ldr r0, [r6, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_021634F4:
	ldr r0, [r6, #0x3cc]
	cmp r0, r4, asr #1
	ldr r0, [r6, #0x3c8]
	blt _0216353C
	sub r0, r0, #0x400
	str r0, [r6, #0x3c8]
	cmp r0, #0
	ble _02163520
	ldr r0, [r6, #0x3cc]
	cmp r0, r5
	blt _021635E0
_02163520:
	mov r0, #0
	str r0, [r6, #0x3c8]
	str r5, [r6, #0x3d0]
	add sp, sp, #8
	str r5, [r6, #0x3cc]
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_0216353C:
	add r0, r0, #0x400
	str r0, [r6, #0x3c8]
	b _021635E0
_02163548:
	cmp r1, r5
	blt _021635E0
	ldr r1, [r6, #0x3c4]
	ldr r0, [r6, #0x3cc]
	sub r1, r1, #0x14000
	cmp r0, r1
	bge _02163594
	ldr r0, [r6, #0x3d0]
	cmp r0, r1
	ble _02163594
	mov r1, #0
	mov r0, #0xa8
	str r1, [sp]
	sub r1, r0, #0xa9
	str r0, [sp, #4]
	ldr r0, [r6, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02163594:
	ldr r0, [r6, #0x3cc]
	cmp r0, r4, asr #1
	ldr r0, [r6, #0x3c8]
	bgt _021635D8
	adds r0, r0, #0x400
	str r0, [r6, #0x3c8]
	bpl _021635BC
	ldr r0, [r6, #0x3cc]
	cmp r0, r5
	bgt _021635E0
_021635BC:
	mov r0, #0
	str r0, [r6, #0x3c8]
	str r5, [r6, #0x3d0]
	add sp, sp, #8
	str r5, [r6, #0x3cc]
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_021635D8:
	sub r0, r0, #0x400
	str r0, [r6, #0x3c8]
_021635E0:
	ldr r1, [r6, #0x3cc]
	mov r0, #0
	str r1, [r6, #0x3d0]
	ldr r2, [r6, #0x3cc]
	ldr r1, [r6, #0x3c8]
	add r1, r2, r1
	str r1, [r6, #0x3cc]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__State_2163604(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x30
	mov r10, r0
	add r8, r10, #0x3a8
	mov r5, #0
	mov r6, r10
	mov r7, r5
	mov r9, r8
	add r4, r10, #0xb30
	add r11, r10, #0xa00
_0216362C:
	add r3, r6, #0x3a8
	ldmia r4, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r6, #0x3b0]
	add r0, sp, #0
	add r1, r1, #0x4a000
	add r1, r1, #0x100000
	str r1, [r6, #0x3b0]
	ldr r1, [r10, #0xa3c]
	ldr r1, [r1, #0x3c4]
	add r1, r1, #0xff0
	add r1, r1, #0x41000
	str r1, [r6, #0x3ac]
	ldrh r1, [r11, #0xd6]
	add r1, r1, #0x2000
	sub r1, r1, r7
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	ldr r1, =FX_SinCosTable_
	mov r3, r2, lsl #1
	ldrsh r1, [r1, r3]
	ldr r3, =FX_SinCosTable_
	add r2, r3, r2, lsl #1
	ldrsh r2, [r2, #2]
	bl MTX_RotY43_
	mov r0, r9
	add r1, sp, #0
	mov r2, r8
	bl MTX_MultVec43
	add r5, r5, #1
	add r6, r6, #0x364
	add r7, r7, #0x4000
	add r8, r8, #0x364
	add r9, r9, #0x364
	cmp r5, #2
	blt _0216362C
	ldr r1, [r10, #0xa3c]
	ldr r0, [r1, #0x410]
	cmp r0, #0
	beq _02163720
	ldr r0, [r10, #0xa4c]
	cmp r0, #0
	cmpne r0, #7
	bne _02163720
	mov r0, r10
	mov r1, #0xe
	bl Boss3__Action_DecideNextAction
	ldr r0, [r10, #0xa3c]
	mov r1, #0
	str r1, [r0, #0x410]
	ldr r0, [r10, #0xa3c]
	add r0, r0, #0x300
	strh r1, [r0, #0xba]
	ldr r0, [r10, #0xa3c]
	add r0, r0, #0x300
	strh r1, [r0, #0xbe]
	b _021637B8
_02163720:
	add r0, r1, #0x300
	ldrsh r0, [r0, #0xba]
	cmp r0, #9
	blt _0216375C
	ldr r0, [r10, #0xa4c]
	cmp r0, #0
	bne _0216375C
	mov r0, r10
	mov r1, #0xb
	bl Boss3__Action_2163E28
	ldr r0, [r10, #0xa3c]
	mov r1, #0
	add r0, r0, #0x300
	strh r1, [r0, #0xba]
	b _021637B8
_0216375C:
	add r0, r1, #0x300
	ldrsh r0, [r0, #0xbe]
	cmp r0, #7
	blt _02163798
	ldr r0, [r10, #0xa4c]
	cmp r0, #7
	bne _02163798
	mov r0, r10
	mov r1, #0xc
	bl Boss3__Action_2163E28
	ldr r0, [r10, #0xa3c]
	mov r1, #0
	add r0, r0, #0x300
	strh r1, [r0, #0xbe]
	b _021637B8
_02163798:
	ldr r1, [r10, #0xa40]
	mov r0, r10
	blx r1
	ldr r1, [r10, #0xa44]
	cmp r1, #0
	beq _021637B8
	mov r0, r10
	blx r1
_021637B8:
	ldr r1, [r10, #0xa48]
	cmp r1, #0
	beq _021637CC
	mov r0, r10
	blx r1
_021637CC:
	ldr r0, [r10, #0xae8]
	cmp r0, #0
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r10
	bl Boss3__Func_2163B44
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__Destructor(Task *task)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x1cc
	add r0, r0, #0xc00
	bl AnimatorMDL__Release
	add r5, r4, #0xf10
	mov r4, #0
_02163814:
	mov r0, r5
	bl AnimatorMDL__Release
	add r4, r4, #1
	cmp r4, #2
	add r5, r5, #0x144
	blt _02163814
	mov r0, r6
	bl GameObject__Destructor
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__Draw(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bl GetCurrentTaskWork_
	mov r5, r0
	ldr r0, [r5, #0x20]
	tst r0, #0x20
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r5, #0xa3c]
	bl Boss3Stage__Func_2162918
	add r0, r5, #0x214
	add r1, r5, #0x44
	add r3, r0, #0xc00
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r5, #0x48]
	add r0, r5, #0xa00
	rsb r1, r1, #0
	str r1, [r5, #0xe18]
	ldrh r1, [r0, #0xd4]
	add r0, r5, #0x1cc
	add r4, r0, #0xc00
	mov r0, r1, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r2, =FX_SinCosTable_
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r4, #0x24
	bl MTX_RotY33_
	mov r0, r4
	bl AnimatorMDL__ProcessAnimation
	mov r0, r4
	bl AnimatorMDL__Draw
	add r0, r5, #0x30c
	add r1, r0, #0x800
	mov r0, #0x1d
	bl BossHelpers__Model__SetMatrixMode
	add r1, r5, #0x33c
	mov r0, #0x1c
	add r1, r1, #0x800
	bl BossHelpers__Model__SetMatrixMode
	mov r6, #0
	ldr r11, =FX_SinCosTable_
	mov r7, r5
	mov r8, r5
	add r9, r5, #0xf10
	mov r10, r6
	add r4, r5, #0xa00
_021638FC:
	ldr r0, [r7, #0x384]
	tst r0, #0x20
	bne _02163974
	add r0, r8, #0x358
	add r1, r7, #0x3a8
	add r3, r0, #0xc00
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r7, #0x3ac]
	add r0, r9, #0x24
	rsb r1, r1, #0
	str r1, [r8, #0xf5c]
	ldrh r1, [r4, #0xd6]
	add r1, r1, #0x2000
	sub r1, r1, r10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	ldrsh r1, [r11, r1]
	add r2, r11, r2, lsl #1
	ldrsh r2, [r2, #2]
	bl MTX_RotY33_
	mov r0, r9
	bl AnimatorMDL__ProcessAnimation
	mov r0, r9
	bl AnimatorMDL__Draw
_02163974:
	add r6, r6, #1
	cmp r6, #2
	add r7, r7, #0x364
	add r8, r8, #0x144
	add r9, r9, #0x144
	add r10, r10, #0x4000
	blt _021638FC
	add r0, r5, #0x36c
	add r1, r0, #0x800
	mov r0, #0x1a
	bl BossHelpers__Model__SetMatrixMode
	add r0, r5, #0x39c
	add r1, r0, #0x800
	mov r0, #0x18
	bl BossHelpers__Model__SetMatrixMode
	add r0, r5, #0x3cc
	add r6, r0, #0x800
	mov r4, #0
_021639BC:
	mov r0, r6
	bl AnimatePalette
	mov r0, r6
	bl DrawAnimatedPalette
	add r4, r4, #1
	cmp r4, #0x10
	add r6, r6, #0x20
	blt _021639BC
	ldr r0, [r5, #0xa3c]
	add r0, r0, #0x24
	add r0, r0, #0x400
	bl BossHelpers__ApplyModifiedLights
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__Action_Hit(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__GetHitDamage
	ldr r1, [r4, #0xa3c]
	add r1, r1, #0x300
	ldrsh r2, [r1, #0xb8]
	sub r0, r2, r0
	strh r0, [r1, #0xb8]
	ldr r0, [r4, #0xa50]
	cmp r0, #1
	bne _02163A3C
	ldr r0, [r4, #0xa3c]
	add r0, r0, #0x300
	ldrsh r1, [r0, #0xbe]
	add r1, r1, #1
	strh r1, [r0, #0xbe]
_02163A3C:
	ldr r0, [r4, #0xa3c]
	add r0, r0, #0x300
	ldrsh r1, [r0, #0xb8]
	cmp r1, #0
	ldrgt r0, =Boss3__State3_216602C
	bgt _02163A94
	mov r1, #1
	strh r1, [r0, #0xb8]
	mov r1, #0
	mov r0, #0xce
	str r1, [sp]
	sub r1, r0, #0xcf
	str r0, [sp, #4]
	ldr r0, [r4, #0xa3c]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	ldr r1, [r4, #0xa3c]
	mov r2, #1
	ldr r0, =Boss3__State3_216602C
	str r2, [r1, #0x410]
_02163A94:
	str r0, [r4, #0xa44]
	ldr r0, [r4, #0xa3c]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0xb8]
	bl UpdateBossHealthHUD
	ldr r1, [r4, #0xa3c]
	add r0, r1, #0x300
	ldrsh r0, [r0, #0xb8]
	cmp r0, #0x200
	addge sp, sp, #8
	ldmgeia sp!, {r4, pc}
	ldr r0, [r1, #0x418]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	mov r0, #1
	bl ChangeBossBGMVariant
	ldr r0, [r4, #0xa3c]
	mov r1, #1
	str r1, [r0, #0x418]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__Func_2163AF0(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xa50]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	cmp r1, #0
	addeq r0, r0, #0x300
	ldreqsh r1, [r0, #0xba]
	addeq r1, r1, #1
	beq _02163B28
	add r0, r0, #0x300
	ldrsh r1, [r0, #0xba]
	add r1, r1, #4
_02163B28:
	strh r1, [r0, #0xba]
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2163458
	mov r1, r0
	mov r0, r4
	bl Boss3__Func_2163F00
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__Func_2163B44(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, =gPlayer
	mov r4, r0
	ldr r0, [r1, #0]
	bl BossHelpers__Player__IsAlive
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, =gPlayer
	ldr r2, =0x006BAA99
	ldr r0, [r0, #0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__GetAngle
	add r1, r4, #0xa00
	mov r0, r0, lsl #0x10
	ldrsh r2, [r1, #0xd6]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	rsb r0, r2, r0, asr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr r1, =0x00001C72
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r1, r0, lsr #0x10
	cmplt r1, #0x8000
	bge _02163BFC
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r4, #0xf10
	mov r3, #0x29
	bl BossHelpers__SetAnimation
	ldr r0, =gPlayer
	mov r3, #0xa000
	rsb r3, r3, #0
	ldr r2, [r0, #0]
	add r1, r3, #0x8000
	str r3, [r2, #0xb0]
	ldr r0, [r0, #0]
	mov r2, #0x1000
	bl BossPlayerHelpers_Action_Boss3ArmKnockback
	b _02163C50
_02163BFC:
	ldr r0, =0x0000E38E
	cmp r1, r0
	bge _02163C50
	cmp r1, #0x8000
	ble _02163C50
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x54
	ldr r2, [r4, #0xa30]
	add r0, r0, #0x1000
	mov r3, #0x29
	bl BossHelpers__SetAnimation
	ldr r0, =gPlayer
	mov r3, #0xa000
	ldr r2, [r0, #0]
	mov r1, #0x2000
	str r3, [r2, #0xb0]
	ldr r0, [r0, #0]
	mov r2, #0x1000
	bl BossPlayerHelpers_Action_Boss3ArmKnockback
_02163C50:
	add r0, r4, #0x1000
	ldrh r0, [r0, #0x1c]
	tst r0, #0x8000
	beq _02163C7C
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r4, #0xf10
	mov r3, #0x27
	bl BossHelpers__SetAnimation
_02163C7C:
	add r0, r4, #0x1100
	ldrh r0, [r0, #0x60]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x54
	ldr r2, [r4, #0xa30]
	add r0, r0, #0x1000
	mov r3, #0x27
	bl BossHelpers__SetAnimation
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__Func_2163CC8(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2162BD0
	cmp r0, #1
	bne _02163CF4
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	bic r1, r1, #0x10
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_02163CF4:
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	orr r1, r1, #0x10
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__Action_DecideNextAction(Boss3 *work, s32 action)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	str r1, [r0, #0xa4c]
	cmp r1, #0xe
	addls pc, pc, r1, lsl #2
	b _02163DEC
_02163D24: // jump table
	b _02163D60 // case 0
	b _02163D6C // case 1
	b _02163D78 // case 2
	b _02163D84 // case 3
	b _02163D90 // case 4
	b _02163D9C // case 5
	b _02163DA8 // case 6
	b _02163DB4 // case 7
	b _02163DC0 // case 8
	b _02163DCC // case 9
	b _02163DD8 // case 10
	b _02163DEC // case 11
	b _02163DEC // case 12
	b _02163DEC // case 13
	b _02163DE4 // case 14
_02163D60:
	ldr r1, =Boss3__StateBoss_2163F24
	str r1, [r0, #0xa40]
	b _02163DEC
_02163D6C:
	ldr r1, =Boss3__StateBoss_2164100
	str r1, [r0, #0xa40]
	b _02163DEC
_02163D78:
	ldr r1, =Boss3__StateBoss_21644E4
	str r1, [r0, #0xa40]
	b _02163DEC
_02163D84:
	ldr r1, =Boss3__StateBoss_21646BC
	str r1, [r0, #0xa40]
	b _02163DEC
_02163D90:
	ldr r1, =Boss3__StateBoss_2164728
	str r1, [r0, #0xa40]
	b _02163DEC
_02163D9C:
	ldr r1, =Boss3__StateBoss_21649D8
	str r1, [r0, #0xa40]
	b _02163DEC
_02163DA8:
	ldr r1, =Boss3__StateBoss_2164B80
	str r1, [r0, #0xa40]
	b _02163DEC
_02163DB4:
	ldr r1, =Boss3__StateBoss_2165084
	str r1, [r0, #0xa40]
	b _02163DEC
_02163DC0:
	ldr r1, =Boss3__StateBoss_21651EC
	str r1, [r0, #0xa40]
	b _02163DEC
_02163DCC:
	ldr r1, =Boss3__StateBoss_21655B0
	str r1, [r0, #0xa40]
	b _02163DEC
_02163DD8:
	ldr r1, =Boss3__StateBoss_21658B8
	str r1, [r0, #0xa40]
	b _02163DEC
_02163DE4:
	ldr r1, =Boss3__StateBoss_2166460
	str r1, [r0, #0xa40]
_02163DEC:
	ldr r1, [r0, #0xa40]
	blx r1
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__Action_2163E28(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	str r1, [r0, #0xa4c]
	cmp r1, #0xb
	beq _02163E48
	cmp r1, #0xc
	ldreq r1, =Boss3__State_2165DD8
	streq r1, [r0, #0xa40]
	b _02163E50
_02163E48:
	ldr r1, =Boss3__State_2165B2C
	str r1, [r0, #0xa40]
_02163E50:
	ldr r1, [r0, #0xa40]
	blx r1
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__Func_2163E64(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, =gPlayer
	mov r4, r1
	ldr r1, [r2, #0]
	mov r5, r0
	ldr r0, [r1, #0x44]
	ldr r2, =0x006BAA99
	mov r1, #0x40000
	bl BossHelpers__Arena__GetAngle
	add r2, r5, #0xa00
	mov r1, r0
	ldrh r0, [r2, #0xd4]
	mov r2, r4
	bl BossHelpers__Math__Func_2039264
	add r1, r5, #0xa00
	strh r0, [r1, #0xd4]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__SetPaletteAnim(Boss3 *work, s32 anim)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	cmp r1, #6
	mov r3, #0
	addls pc, pc, r1, lsl #2
	ldmia sp!, {r3, pc}
_02163EC4: // jump table
	b _02163EE0 // case 0
	b _02163EE0 // case 1
	b _02163EE0 // case 2
	b _02163EE4 // case 3
	b _02163EE0 // case 4
	b _02163EE4 // case 5
	b _02163EE0 // case 6
_02163EE0:
	mov r3, #1
_02163EE4:
	add r0, r0, #0x3cc
	mov r1, r1, lsl #0x10
	add r0, r0, #0x800
	mov r2, r1, lsr #0x10
	mov r1, #0x10
	bl BossHelpers__SetPaletteAnimations
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__Func_2163F00(Boss3 *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r2, [r0, #0xa3c]
	add r2, r2, #0x300
	ldrh r3, [r2, #0xbc]
	cmp r3, r1
	ldrne r3, =Boss3__State4_21661C8
	strneh r1, [r2, #0xbc]
	strne r3, [r0, #0xa48]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2163F24(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	mov r4, r0
	add r0, r4, #0x1cc
	str r1, [sp]
	mov r2, #1
	str r2, [sp, #4]
	ldr r2, [r4, #0xa30]
	mov r3, r1
	add r0, r0, #0xc00
	bl BossHelpers__SetAnimation
	mov r1, #0
	str r1, [sp]
	mov r3, #1
	str r3, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r4, #0xf10
	bl BossHelpers__SetAnimation
	mov r1, #0
	add r0, r4, #0x54
	str r1, [sp]
	mov r3, #1
	str r3, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r0, #0x1000
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x384]
	add r0, r4, #0xa00
	orr r1, r1, #0x20
	str r1, [r4, #0x384]
	ldr r2, [r4, #0x6e8]
	mov r1, #0x78
	orr r2, r2, #0x20
	str r2, [r4, #0x6e8]
	strh r1, [r0, #0xe6]
	ldrh r0, [r0, #0xda]
	tst r0, #0x10
	ldrne r0, =Boss3__StateBoss_21640A4
	ldreq r0, =Boss3__StateBoss_2163FD8
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2163FD8(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	ldr r0, [r4, #0xa3c]
	ldr r0, [r0, #0x414]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	tst r1, #2
	ldreqh r0, [r0, #0xe6]
	cmpeq r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2162BA8
	cmp r0, #0
	bne _02164054
	mov r0, r4
	mov r1, #1
	bl Boss3__Action_DecideNextAction
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	orr r1, r1, #2
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_02164054:
	cmp r0, #1
	bne _0216407C
	mov r0, r4
	mov r1, #2
	bl Boss3__Action_DecideNextAction
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	orr r1, r1, #2
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_0216407C:
	cmp r0, #2
	ldmneia sp!, {r4, pc}
	mov r0, r4
	mov r1, #4
	bl Boss3__Action_DecideNextAction
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	orr r1, r1, #2
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21640A4(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	tst r1, #2
	ldreqh r0, [r0, #0xe6]
	cmpeq r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	mov r1, #6
	bl Boss3__Action_DecideNextAction
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	orr r1, r1, #2
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164100(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, =Boss3__StateBoss_2164204
	mov r4, r0
	str r1, [r4, #0xa40]
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2162E00
	strb r0, [r4, #0xadc]
	mov r0, #0
	strb r0, [r4, #0xadd]
	ldrb r0, [r4, #0xadc]
	cmp r0, #2
	bne _02164180
	add r1, r4, #0xa00
	ldrh r2, [r1, #0xda]
	mov r0, r4
	orr r2, r2, #8
	strh r2, [r1, #0xda]
	bl Boss3Stage__Func_2162C34
	mov r6, #0
	mov r0, #1
	strb r6, [r4, #0xb0a]
	str r0, [r4, #0xae0]
	mov r5, r0
_0216415C:
	ldr r0, [r4, #0xa3c]
	mov r1, r5
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x398]
	bl Boss3Arm__Func_2168F84
	add r6, r6, #1
	cmp r6, #2
	blt _0216415C
	b _021641CC
_02164180:
	cmp r0, #4
	bne _021641CC
	add r1, r4, #0xa00
	ldrh r2, [r1, #0xda]
	mov r0, r4
	bic r2, r2, #8
	strh r2, [r1, #0xda]
	bl Boss3Stage__Func_2162C34
	bl Boss3Stage__Func_2162DE4
	strb r0, [r4, #0xb0a]
	ldrb r1, [r4, #0xadd]
	ldr r2, =_0217A8B8
	and r0, r0, #0xff
	add r0, r2, r0, lsl #4
	ldr r0, [r0, r1, lsl #2]
	mov r1, #1
	str r0, [r4, #0xae0]
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2169164
_021641CC:
	add r0, r4, #0xa00
	ldrh r3, [r0, #0xda]
	mov r2, #0
	mov r1, #0x78
	bic r3, r3, #4
	strh r3, [r0, #0xda]
	str r2, [r4, #0xb00]
	strh r1, [r0, #0xe6]
	add r0, r4, #0xb00
	mov r1, #0x8c
	strh r1, [r0, #8]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164204(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	bne _02164360
	ldrh r1, [r0, #0xda]
	tst r1, #4
	bne _02164360
	ldrb r0, [r4, #0xadc]
	ldrb r2, [r4, #0xadd]
	cmp r2, r0
	bhs _02164360
	bhs _02164274
	tst r1, #8
	beq _02164260
	ldr r0, =_0217A8B8+0x20
	add r1, r2, #2
	ldr r0, [r0, r1, lsl #2]
	str r0, [r4, #0xae0]
	b _02164274
_02164260:
	ldrb r1, [r4, #0xb0a]
	ldr r0, =_0217A8B8
	add r0, r0, r1, lsl #4
	ldr r0, [r0, r2, lsl #2]
	str r0, [r4, #0xae0]
_02164274:
	ldr r0, [r4, #0xb00]
	cmp r0, #0
	ldrne r0, [r4, #0xb04]
	cmpne r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0xb04]
	ldr r0, [r4, #0xb00]
	cmp r0, #0
	beq _02164360
	add r1, r4, #0xb00
	ldrh r0, [r1, #8]
	cmp r0, #0
	ldreq r0, [r4, #0xb04]
	cmpeq r0, #0
	bne _02164360
	add r0, r4, #0xa00
	ldrh ip, [r0, #0xda]
	mov r3, #0xa
	mov r2, #0x1e
	orr ip, ip, #4
	strh ip, [r0, #0xda]
	strh r3, [r0, #0xe6]
	strh r2, [r1, #8]
	ldrb r0, [r4, #0xadd]
	ldr r1, [r4, #0xa3c]
	cmp r0, #0
	ldr r0, [r4, #0xae0]
	bne _02164324
	add r0, r1, r0, lsl #2
	ldr r0, [r0, #0x398]
	bl Boss3Arm__Func_21697D0
	cmp r0, #0
	bne _0216430C
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	bic r1, r1, #4
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_0216430C:
	mov r0, #0
	str r0, [r4, #0xb00]
	ldrb r0, [r4, #0xadd]
	add r0, r0, #1
	strb r0, [r4, #0xadd]
	b _02164360
_02164324:
	add r0, r1, r0, lsl #2
	ldr r0, [r0, #0x398]
	bl Boss3Arm__Func_21697D0
	cmp r0, #0
	bne _0216434C
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	bic r1, r1, #4
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_0216434C:
	mov r0, #0
	str r0, [r4, #0xb00]
	ldrb r0, [r4, #0xadd]
	add r0, r0, #1
	strb r0, [r4, #0xadd]
_02164360:
	ldrb r1, [r4, #0xadd]
	ldrb r0, [r4, #0xadc]
	cmp r1, r0
	bne _02164388
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xda]
	tst r0, #4
	ldreq r0, =Boss3__StateBoss_21643CC
	streq r0, [r4, #0xa40]
	ldmeqia sp!, {r4, pc}
_02164388:
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	tst r1, #4
	ldmneia sp!, {r4, pc}
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xb00
	ldrh r1, [r0, #8]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #8]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21643CC(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xae0]
	cmp r0, #0
	ldr r0, [r4, #0xa3c]
	bne _021643F8
	bl Boss3Stage__Func_2162AB0
	add r1, r0, r0, lsl #1
	add r0, r4, #0xa00
	strh r1, [r0, #0xe6]
	b _02164404
_021643F8:
	bl Boss3Stage__Func_2162AB0
	add r1, r4, #0xa00
	strh r0, [r1, #0xe6]
_02164404:
	ldr r0, =Boss3__StateBoss_2164414
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164414(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, =Boss3Arm__StateArm_216997C
	mov r3, #0
_02164450:
	ldr r1, [r4, #0xa3c]
	add r1, r1, r3, lsl #2
	ldr r2, [r1, #0x398]
	add r3, r3, #1
	ldr r1, [r2, #0x37c]
	cmp r1, #2
	streq r0, [r2, #0x378]
	cmp r3, #4
	blt _02164450
	ldr r0, =Boss3__StateBoss_2164488
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164488(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0xa3c]
	mov r1, #0
_02164498:
	add r0, r2, r1, lsl #2
	ldr r0, [r0, #0x398]
	ldr r0, [r0, #0x37c]
	sub r0, r0, #1
	cmp r0, #3
	ldmlsia sp!, {r4, pc}
	add r1, r1, #1
	cmp r1, #4
	blt _02164498
	add r1, r4, #0xa00
	ldrh r2, [r1, #0xda]
	mov r0, r4
	bic r2, r2, #2
	strh r2, [r1, #0xda]
	bl Boss3__Func_2163CC8
	mov r0, r4
	mov r1, #0
	bl Boss3__Action_DecideNextAction
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21644E4(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0xa00
	mov r2, #0x3fc
	ldr r1, =Boss3__StateBoss_2164580
	strh r2, [r0, #0xe6]
	ldr r5, =_0217A82C
	str r1, [r4, #0xa40]
	mov r6, #0
_0216450C:
	ldrsh r0, [r5, #0xa]
	str r0, [sp]
	ldr r0, [r4, #0xa3c]
	ldrsh r1, [r5, #4]
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x398]
	ldrsh r2, [r5, #6]
	ldrsh r3, [r5, #8]
	add r0, r0, #0x258
	bl ObjRect__SetBox2D
	add r6, r6, #1
	cmp r6, #4
	blt _0216450C
	mov r1, #0
	mov r0, #0xa1
	str r1, [sp]
	sub r1, r0, #0xa2
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0xa3c]
	mov r1, #5
	bl Boss3Stage__Func_2169164
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164580(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r1, =Boss3Arm__StateArm_2169DCC
	mov r2, #0
_021645BC:
	ldr r0, [r4, #0xa3c]
	add r0, r0, r2, lsl #2
	ldr r0, [r0, #0x398]
	add r2, r2, #1
	str r1, [r0, #0x378]
	cmp r2, #4
	blt _021645BC
	ldr r0, =Boss3__StateBoss_21645EC
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21645EC(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r2, [r4, #0xa3c]
	mov r1, #0xf0
	add r5, r2, #0x398
	bl Boss3__Func_2163E64
	mov r2, #0
_0216460C:
	ldr r0, [r5, r2, lsl #2]
	ldr r1, [r0, #0x37c]
	cmp r1, #0
	beq _02164638
	cmp r1, #6
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, r5, r6, pc}
	mov r1, #0
	bl Boss3Arm__Func_2168F84
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
_02164638:
	add r2, r2, #1
	cmp r2, #4
	blt _0216460C
	ldr r5, =_0217A82C
	mov r6, #0
_0216464C:
	ldrsh r0, [r5, #0x4a]
	str r0, [sp]
	ldr r0, [r4, #0xa3c]
	ldrsh r1, [r5, #0x44]
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x398]
	ldrsh r2, [r5, #0x46]
	ldrsh r3, [r5, #0x48]
	add r0, r0, #0x258
	bl ObjRect__SetBox2D
	add r6, r6, #1
	cmp r6, #4
	blt _0216464C
	ldr r0, [r4, #0x138]
	mov r1, #0x1e
	bl NNS_SndPlayerStopSeq
	mov r0, r4
	bl Boss3__Func_2163CC8
	mov r0, r4
	mov r1, #0
	bl Boss3__Action_DecideNextAction
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	bic r1, r1, #2
	strh r1, [r0, #0xda]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21646BC(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xa3c]
	mov r1, #7
	bl Boss3Stage__Func_2169164
	add r0, r4, #0xa00
	mov r1, #0xb4
	strh r1, [r0, #0xf0]
	ldr r0, [r4, #0x138]
	mov r1, #0x1e
	bl NNS_SndPlayerStopSeq
	ldr r0, =Boss3__StateBoss_21646F8
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21646F8(Boss3 *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0xa00
	ldrh r2, [r1, #0xf0]
	cmp r2, #0
	subne r2, r2, #1
	strneh r2, [r1, #0xf0]
	add r1, r0, #0xa00
	ldrh r1, [r1, #0xf0]
	cmp r1, #0
	ldreq r1, =Boss3__StateBoss_21645EC
	streq r1, [r0, #0xa40]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164728(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, =Boss3__StateBoss_21648B0
	mov r4, r0
	str r1, [r4, #0xa40]
	bl Boss3Stage__Func_2162E38
	mov r6, #0
_02164744:
	ldr r0, [r4, #0xa3c]
	add r0, r0, r6, lsl #2
	ldr r1, [r0, #0x398]
	ldr r0, [r1, #0x478]
	add r7, r1, #0x218
	cmp r0, #1
	bne _021647A0
	ldr r8, =_0217A880
	mov r5, #0
_02164768:
	add r3, r8, r5, lsl #3
	ldrsh r1, [r3, #6]
	mov r2, r5, lsl #3
	mov r0, r7
	str r1, [sp]
	ldrsh r1, [r8, r2]
	ldrsh r2, [r3, #2]
	ldrsh r3, [r3, #4]
	bl ObjRect__SetBox2D
	add r5, r5, #1
	cmp r5, #3
	add r7, r7, #0x40
	blt _02164768
	b _021647F4
_021647A0:
	ldr r5, =_0217A880
	mov r8, #0
_021647A8:
	add r2, r5, r8, lsl #3
	ldrsh r1, [r2, #6]
	mov ip, r8, lsl #3
	mov r0, r7
	str r1, [sp]
	ldrsh r3, [r2, #4]
	ldrsh r1, [r5, ip]
	ldrsh r2, [r2, #2]
	rsb ip, r3, #0
	rsb r3, r1, #0
	mov r1, ip, lsl #0x10
	mov r3, r3, lsl #0x10
	mov r1, r1, asr #0x10
	mov r3, r3, asr #0x10
	bl ObjRect__SetBox2D
	add r8, r8, #1
	cmp r8, #3
	add r7, r7, #0x40
	blt _021647A8
_021647F4:
	add r6, r6, #1
	cmp r6, #2
	blt _02164744
	ldr r0, [r4, #0xa3c]
	mov r1, #2
	add r0, r0, #0x88
	add r5, r0, #0x400
	mov r0, r5
	mov r2, #0x40
	bl ObjRect__SetAttackStat
	mov r0, r5
	mov r1, #0
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
	ldr r3, =_0217A82C
	mov r0, r5
	ldrsh r1, [r3, #0x1a]
	str r1, [sp]
	ldrsh r1, [r3, #0x14]
	ldrsh r2, [r3, #0x16]
	ldrsh r3, [r3, #0x18]
	bl ObjRect__SetBox2D
	ldr r1, =0x00000102
	ldr r0, =gPlayer
	strh r1, [r5, #0x34]
	ldr r0, [r0, #0]
	mov r6, #0
	str r0, [r5, #0x1c]
	ldr r0, [r5, #0x18]
	bic r0, r0, #4
	str r0, [r5, #0x18]
	mov r5, #8
_02164874:
	ldr r0, [r4, #0xa3c]
	mov r1, r5
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x398]
	bl Boss3Arm__Func_2168F84
	add r6, r6, #1
	cmp r6, #2
	blt _02164874
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21648B0(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r9, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	ldr r3, [r9, #0xa3c]
	ldr r0, [r3, #0x4a0]
	tst r0, #4
	beq _02164910
	mov r0, #0x40000
	ldr r1, =0x006BAA99
	str r0, [sp]
	ldr r0, =0x00107FC0
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r1, =gPlayer
	add r0, r3, #0x88
	ldr r2, [r1, #0]
	add r1, r3, #0xc8
	ldr r2, [r2, #0x44]
	ldr r3, [r3, #0x3c4]
	add r0, r0, #0x400
	add r1, r1, #0x400
	bl BossHelpers__Collision__InitArenaCollider
_02164910:
	ldr r2, [r9, #0xa3c]
	mov r1, #0
_02164918:
	add r0, r2, r1, lsl #2
	ldr r0, [r0, #0x398]
	ldr r0, [r0, #0x37c]
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, pc}
	add r1, r1, #1
	cmp r1, #2
	blt _02164918
	mov r8, #0
	ldr r4, =_0217A868
	mov r5, r8
_02164948:
	ldr r0, [r9, #0xa3c]
	mov r6, r5
	add r0, r0, r8, lsl #2
	ldr r0, [r0, #0x398]
	add r7, r0, #0x218
_0216495C:
	add r3, r4, r6, lsl #3
	ldrsh r1, [r3, #6]
	mov r2, r6, lsl #3
	mov r0, r7
	str r1, [sp]
	ldrsh r1, [r4, r2]
	ldrsh r2, [r3, #2]
	ldrsh r3, [r3, #4]
	bl ObjRect__SetBox2D
	add r6, r6, #1
	cmp r6, #3
	add r7, r7, #0x40
	blt _0216495C
	add r8, r8, #1
	cmp r8, #2
	blt _02164948
	add r1, r9, #0xa00
	ldrh r2, [r1, #0xda]
	mov r0, r9
	bic r2, r2, #2
	strh r2, [r1, #0xda]
	bl Boss3__Func_2163CC8
	mov r0, r9
	mov r1, #0
	bl Boss3__Action_DecideNextAction
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21649D8(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, #0
	mov r4, #0xa
_021649E8:
	ldr r0, [r6, #0xa3c]
	mov r1, r4
	add r0, r0, r5, lsl #2
	ldr r0, [r0, #0x398]
	bl Boss3Arm__Func_2168F84
	add r5, r5, #1
	cmp r5, #2
	blt _021649E8
	ldr r0, =Boss3__StateBoss_21648B0
	str r0, [r6, #0xa40]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__Func_2164A18(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r5, r0
	ldr r4, [r5, #0xa3c]
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	mov r2, r1
	mov r3, r1
	str r1, [sp, #0x10]
	mov r0, #0x130
	bl GameObject__SpawnObject
	ldrb r2, [r5, #0xadc]
	add r1, r5, #0xb60
	ldr ip, =_0217A898
	sub r2, r2, #1
	add r2, r4, r2, lsl #2
	str r0, [r2, #0x378]
	ldrb r0, [r5, #0xadc]
	add r6, r5, #0xa00
	ldr r3, =FX_SinCosTable_
	sub r0, r0, #1
	add r0, r4, r0, lsl #2
	ldr lr, [r0, #0x378]
	ldr r7, =0x00107FC0
	str r4, [lr, #0x374]
	add r4, lr, #0x44
	ldmia r1, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	ldr r0, [lr, #0x48]
	mov r1, #0
	rsb r0, r0, #0
	str r0, [lr, #0x48]
	ldrb r4, [r5, #0xae4]
	ldrb r2, [r5, #0xadc]
	ldrh r0, [r6, #0xf0]
	sub r5, r4, #1
	sub r2, r2, #1
	mov r4, r2, lsl #1
	add r2, ip, r5, lsl #3
	ldrh r5, [r4, r2]
	ldr r2, [lr, #0x44]
	ldr r4, =0xFFFFF334
	add r0, r0, r5
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r6, r0, lsl #1
	mov r0, r6, lsl #1
	ldrsh r5, [r3, r0]
	add r0, r6, #1
	mov r0, r0, lsl #1
	umull ip, r6, r5, r7
	ldrsh r0, [r3, r0]
	adds ip, ip, #0x800
	mla r6, r5, r1, r6
	mov r3, r5, asr #0x1f
	mla r6, r3, r7, r6
	adc r3, r6, #0
	mov r5, ip, lsr #0xc
	orr r5, r5, r3, lsl #20
	sub r5, r5, r2
	umull r3, r2, r0, r7
	mov r5, r5, asr #5
	str r5, [lr, #0x98]
	str r4, [lr, #0x9c]
	adds r3, r3, #0x800
	mla r2, r0, r1, r2
	mov r0, r0, asr #0x1f
	mla r2, r0, r7, r2
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	ldr r0, [lr, #0x4c]
	orr r2, r2, r1, lsl #20
	sub r0, r2, r0
	mov r0, r0, asr #5
	str r0, [lr, #0xa0]
	ldr r0, [lr, #0x1c]
	orr r0, r0, #0x80
	str r0, [lr, #0x1c]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164B80(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2162EB8
	strb r0, [r4, #0xae4]
	mov r1, #0
	strb r1, [r4, #0xadc]
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x22
	bl BossHelpers__SetAnimation
	add r0, r4, #0xa00
	mov r2, #0
	ldr r1, =Boss3__StateBoss_2164BDC
	strh r2, [r0, #0xf0]
	str r1, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164BDC(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	ldmeqia sp!, {r4, pc}
	ldr r0, =gPlayer
	ldr r2, =0x006BAA99
	ldr r0, [r0, #0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__GetAngle
	add r1, r4, #0xa00
	ldr r2, =Boss3__StateBoss_2164C34
	strh r0, [r1, #0xf0]
	str r2, [r4, #0xa40]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164C34(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0xa00
	mov r1, #5
	strh r1, [r0, #0xe6]
	mov r1, #0
	add r0, r4, #0x1cc
	str r1, [sp]
	mov r2, #1
	str r2, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x23
	bl BossHelpers__SetAnimation
	ldr r0, =Boss3__StateBoss_2164C84
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164C84(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf00
	bl Boss3__Func_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldreq r0, =Boss3__StateBoss_2164CC4
	streq r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164CC4(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0xf00
	mov r4, r0
	bl Boss3__Func_2163E64
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x24
	bl BossHelpers__SetAnimation
	ldr r0, =Boss3__StateBoss_2164D0C
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164D0C(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r1, #0xf00
	bl Boss3__Func_2163E64
	ldr r0, [r4, #0xeb0]
	ldr r0, [r0, #0]
	cmp r0, #0x1000
	bne _02164D88
	ldrb r0, [r4, #0xae4]
	mov r5, #0
	cmp r0, #0
	ble _02164D64
_02164D40:
	ldrb r1, [r4, #0xadc]
	mov r0, r4
	add r1, r1, #1
	strb r1, [r4, #0xadc]
	bl Boss3__Func_2164A18
	ldrb r0, [r4, #0xae4]
	add r5, r5, #1
	cmp r5, r0
	blt _02164D40
_02164D64:
	mov r1, #0
	mov r0, #0xa4
	str r1, [sp]
	sub r1, r0, #0xa5
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02164D88:
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	ldrne r0, =Boss3__StateBoss_2164DA8
	strne r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164DA8(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x25
	bl BossHelpers__SetAnimation
	ldr r0, =Boss3__StateBoss_2164DE8
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164DE8(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	mov r3, r1
	add r0, r0, #0xc00
	bl BossHelpers__SetAnimation
	ldr r0, =Boss3__StateBoss_2164E40
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164E40(Boss3 *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0xa00
	mov r3, #0
	ldr r2, =Boss3__StateBoss_2164E5C
	strh r3, [r1, #0xe6]
	str r2, [r0, #0xa40]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164E5C(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldrb r1, [r4, #0xae4]
	ldrb r5, [r4, #0xadc]
	ldr ip, =_0217A898
	ldr r2, [r4, #0xa3c]
	sub r3, r1, r5
	sub lr, r1, #1
	sub r1, r5, #1
	add r1, r2, r1, lsl #2
	add r2, ip, lr, lsl #3
	mov r3, r3, lsl #1
	ldrh ip, [r0, #0xf0]
	ldrh r2, [r3, r2]
	ldr r1, [r1, #0x398]
	add r0, r1, #0x400
	add r2, ip, r2
	strh r2, [r0, #0x44]
	ldrb r0, [r4, #0xadc]
	ldr r2, [r4, #0xa3c]
	mov r1, #0xb
	sub r0, r0, #1
	add r0, r2, r0, lsl #2
	ldr r0, [r0, #0x398]
	bl Boss3Arm__Func_2168F84
	ldrb r0, [r4, #0xadc]
	cmp r0, #0
	subne r0, r0, #1
	strneb r0, [r4, #0xadc]
	ldrb r0, [r4, #0xadc]
	cmp r0, #0
	ldreq r0, =Boss3__StateBoss_2164F24
	movne r1, #0
	streq r0, [r4, #0xa40]
	addne r0, r4, #0xa00
	strneh r1, [r0, #0xe6]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164F24(Boss3 *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0xa00
	mov r3, #0x8c
	ldr r2, =Boss3__StateBoss_2164F40
	strh r3, [r1, #0xe6]
	str r2, [r0, #0xa40]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2164F40(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	ldrb r0, [r4, #0xadc]
	subs r1, r0, #1
	bmi _02164F84
	ldr r2, [r4, #0xa3c]
_02164F60:
	add r0, r2, r1, lsl #2
	ldr r0, [r0, #0x398]
	ldr r0, [r0, #0x37c]
	cmp r0, #0xc
	cmpne r0, #0
	cmpne r0, #0xd
	ldmneia sp!, {r4, r5, r6, pc}
	subs r1, r1, #1
	bpl _02164F60
_02164F84:
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, =Boss3Arm__StateArm_216ADBC
	mov r3, #0
_02164FB0:
	ldr r1, [r4, #0xa3c]
	add r1, r1, r3, lsl #2
	ldr r2, [r1, #0x398]
	add r3, r3, #1
	ldr r1, [r2, #0x37c]
	cmp r1, #0xc
	streq r0, [r2, #0x378]
	cmp r3, #4
	blt _02164FB0
	ldrb r0, [r4, #0xae4]
	mov r6, #0
	cmp r0, #0
	ble _0216500C
	mov r5, #3
_02164FE8:
	ldr r0, [r4, #0xa3c]
	mov r1, r5
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x378]
	bl Boss3SplatInk__Action_DecideNextAction
	ldrb r0, [r4, #0xae4]
	add r6, r6, #1
	cmp r6, r0
	blt _02164FE8
_0216500C:
	ldr r0, =Boss3__StateBoss_2165020
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2165020(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r1, #0xf0
	mov r4, r0
	bl Boss3__Func_2163E64
	ldr r2, [r4, #0xa3c]
	mov r1, #0
_02165038:
	add r0, r2, r1, lsl #2
	ldr r0, [r0, #0x398]
	ldr r0, [r0, #0x37c]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	add r1, r1, #1
	cmp r1, #4
	blt _02165038
	add r2, r4, #0xa00
	ldrh r3, [r2, #0xda]
	mov r0, r4
	mov r1, #0
	bic r3, r3, #2
	strh r3, [r2, #0xda]
	ldrh r3, [r2, #0xda]
	bic r3, r3, #0x10
	strh r3, [r2, #0xda]
	bl Boss3__Action_DecideNextAction
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2165084(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	mov r3, r1
	add r0, r0, #0xc00
	bl BossHelpers__SetAnimation
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r4, #0xf10
	mov r3, #0x27
	bl BossHelpers__SetAnimation
	mov r1, #0
	add r0, r4, #0x54
	str r1, [sp]
	mov r2, #1
	str r2, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r0, #0x1000
	mov r3, #0x27
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x384]
	add r0, r4, #0xa00
	bic r1, r1, #0x20
	str r1, [r4, #0x384]
	ldr r1, [r4, #0x6e8]
	mov r2, #0x78
	bic r1, r1, #0x20
	str r1, [r4, #0x6e8]
	ldr r1, =Boss3__StateBoss_2165130
	strh r2, [r0, #0xe6]
	str r1, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2165130(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	tst r1, #2
	ldreqh r0, [r0, #0xe6]
	cmpeq r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2162BF4
	cmp r0, #0
	bne _0216519C
	mov r0, r4
	mov r1, #8
	bl Boss3__Action_DecideNextAction
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	orr r1, r1, #2
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_0216519C:
	cmp r0, #1
	bne _021651C4
	mov r0, r4
	mov r1, #9
	bl Boss3__Action_DecideNextAction
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	orr r1, r1, #2
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_021651C4:
	cmp r0, #2
	ldmneia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0xa
	bl Boss3__Action_DecideNextAction
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	orr r1, r1, #2
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21651EC(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, =Boss3__StateBoss_21652E4
	mov r4, r0
	str r1, [r4, #0xa40]
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2162F10
	strb r0, [r4, #0xadc]
	mov r0, #0
	strb r0, [r4, #0xadd]
	ldrb r0, [r4, #0xadc]
	cmp r0, #2
	bne _0216526C
	add r1, r4, #0xa00
	ldrh r2, [r1, #0xda]
	mov r0, r4
	orr r2, r2, #8
	strh r2, [r1, #0xda]
	bl Boss3Stage__Func_2162C34
	mov r6, #0
	mov r0, #1
	strb r6, [r4, #0xb0a]
	str r0, [r4, #0xae0]
	mov r5, r0
_02165248:
	ldr r0, [r4, #0xa3c]
	mov r1, r5
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x398]
	bl Boss3Arm__Func_2168F84
	add r6, r6, #1
	cmp r6, #2
	blt _02165248
	b _021652B8
_0216526C:
	cmp r0, #4
	bne _021652B8
	add r1, r4, #0xa00
	ldrh r2, [r1, #0xda]
	mov r0, r4
	bic r2, r2, #8
	strh r2, [r1, #0xda]
	bl Boss3Stage__Func_2162C34
	bl Boss3Stage__Func_2162DE4
	strb r0, [r4, #0xb0a]
	ldrb r1, [r4, #0xadd]
	ldr r2, =_0217A8B8
	and r0, r0, #0xff
	add r0, r2, r0, lsl #4
	ldr r0, [r0, r1, lsl #2]
	mov r1, #1
	str r0, [r4, #0xae0]
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2169164
_021652B8:
	add r0, r4, #0xa00
	ldrh r3, [r0, #0xda]
	mov r2, #0
	mov r1, #0x8c
	bic r3, r3, #4
	strh r3, [r0, #0xda]
	str r2, [r4, #0xb00]
	strh r1, [r0, #0xe6]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21652E4(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	bne _02165420
	ldrh r1, [r0, #0xda]
	tst r1, #4
	bne _02165420
	ldrb r0, [r4, #0xadc]
	ldrb r2, [r4, #0xadd]
	cmp r2, r0
	bhs _02165420
	bhs _02165354
	tst r1, #8
	beq _02165340
	ldr r0, =_0217A8B8+0x20
	add r1, r2, #2
	ldr r0, [r0, r1, lsl #2]
	str r0, [r4, #0xae0]
	b _02165354
_02165340:
	ldrb r1, [r4, #0xb0a]
	ldr r0, =_0217A8B8
	add r0, r0, r1, lsl #4
	ldr r0, [r0, r2, lsl #2]
	str r0, [r4, #0xae0]
_02165354:
	ldr r0, [r4, #0xb00]
	cmp r0, #0
	beq _02165420
	add r1, r4, #0xb00
	ldrh r0, [r1, #8]
	cmp r0, #0
	bne _02165420
	add r0, r4, #0xa00
	ldrh ip, [r0, #0xda]
	mov r3, #0xa
	mov r2, #0x1e
	orr ip, ip, #4
	strh ip, [r0, #0xda]
	strh r3, [r0, #0xe6]
	strh r2, [r1, #8]
	ldrb r0, [r4, #0xadd]
	ldr r1, [r4, #0xa3c]
	cmp r0, #0
	ldr r0, [r4, #0xae0]
	bne _021653E4
	add r0, r1, r0, lsl #2
	ldr r0, [r0, #0x398]
	bl Boss3Arm__Func_21697D0
	cmp r0, #0
	bne _021653CC
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	bic r1, r1, #4
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_021653CC:
	mov r0, #0
	str r0, [r4, #0xb00]
	ldrb r0, [r4, #0xadd]
	add r0, r0, #1
	strb r0, [r4, #0xadd]
	b _02165420
_021653E4:
	add r0, r1, r0, lsl #2
	ldr r0, [r0, #0x398]
	bl Boss3Arm__Func_21697D0
	cmp r0, #0
	bne _0216540C
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	bic r1, r1, #4
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}
_0216540C:
	mov r0, #0
	str r0, [r4, #0xb00]
	ldrb r0, [r4, #0xadd]
	add r0, r0, #1
	strb r0, [r4, #0xadd]
_02165420:
	ldrb r1, [r4, #0xadd]
	ldrb r0, [r4, #0xadc]
	cmp r1, r0
	bne _02165448
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xda]
	tst r0, #4
	ldreq r0, =Boss3__StateBoss_216548C
	streq r0, [r4, #0xa40]
	ldmeqia sp!, {r4, pc}
_02165448:
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	tst r1, #4
	ldmneia sp!, {r4, pc}
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xb00
	ldrh r1, [r0, #8]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #8]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_216548C(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xae0]
	cmp r0, #0
	ldr r0, [r4, #0xa3c]
	bne _021654B8
	bl Boss3Stage__Func_2162AB0
	add r1, r0, r0, lsl #1
	add r0, r4, #0xa00
	strh r1, [r0, #0xe6]
	b _021654C4
_021654B8:
	bl Boss3Stage__Func_2162AB0
	add r1, r4, #0xa00
	strh r0, [r1, #0xe6]
_021654C4:
	ldr r0, =Boss3__StateBoss_21654D4
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21654D4(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, =Boss3Arm__StateArm_216997C
	mov r3, #0
_02165510:
	ldr r1, [r4, #0xa3c]
	add r1, r1, r3, lsl #2
	ldr r2, [r1, #0x398]
	add r3, r3, #1
	ldr r1, [r2, #0x37c]
	cmp r1, #2
	streq r0, [r2, #0x378]
	cmp r3, #4
	blt _02165510
	ldr r0, =Boss3__StateBoss_2165548
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2165548(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0xa3c]
	mov r1, #0
_02165558:
	add r0, r2, r1, lsl #2
	ldr r0, [r0, #0x398]
	ldr r0, [r0, #0x37c]
	cmp r0, #0x10
	ldmeqia sp!, {r4, pc}
	sub r0, r0, #2
	cmp r0, #2
	ldmlsia sp!, {r4, pc}
	add r1, r1, #1
	cmp r1, #4
	blt _02165558
	add r0, r4, #0xa00
	ldrh r2, [r0, #0xda]
	mov r1, #0xf
	bic r2, r2, #2
	strh r2, [r0, #0xda]
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2169164
	mov r0, r4
	mov r1, #7
	bl Boss3__Action_DecideNextAction
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21655B0(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r1, =gPlayer
	mov r4, r0
	ldr r0, [r1, #0]
	ldr r2, =0x006BAA99
	ldr r0, [r0, #0x44]
	mov r1, #0x40000
	bl BossHelpers__Arena__GetAngle
	add r1, r4, #0xa00
	mov r0, r0, lsl #0x10
	ldrh r1, [r1, #0xd6]
	mov r2, r0, lsr #0x10
	ldr r5, =_0217A82C
	add r0, r1, #0x2000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r2, lsl #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, asr #0x10
	rsb r0, r1, r0, asr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #0x2000
	movls r0, #0
	movhi r0, #1
	str r0, [r4, #0xaf0]
	mov r6, #0
_02165628:
	ldrsh r0, [r5, #0xa]
	str r0, [sp]
	ldr r0, [r4, #0xa3c]
	ldrsh r1, [r5, #4]
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x398]
	ldrsh r2, [r5, #6]
	ldrsh r3, [r5, #8]
	add r0, r0, #0x258
	bl ObjRect__SetBox2D
	add r6, r6, #1
	cmp r6, #4
	blt _02165628
	mov r0, #1
	str r0, [r4, #0xaf4]
	add r0, r4, #0xa00
	mov r1, #0x3c
	strh r1, [r0, #0xe6]
	mov r0, #3
	mov r2, #0xa1
	str r0, [r4, #0xae0]
	mov r0, #0
	sub r1, r2, #0xa2
	stmia sp, {r0, r2}
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, =Boss3__StateBoss_216572C
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21656B8(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0xaf4]
	ldr r0, [r4, #0xaf0]
	mov r2, #3
	cmp r0, #0
	strne r1, [r4, #0xaf0]
	moveq r0, #1
	streq r0, [r4, #0xaf0]
	add r0, r4, #0xa00
	mov r1, #0x3c
	strh r1, [r0, #0xe6]
	str r2, [r4, #0xae0]
	mov r2, #0
	mov r0, #0xa1
	str r2, [sp]
	sub r1, r0, #0xa2
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, =Boss3__StateBoss_216572C
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_216572C(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r2, [r4, #0xa3c]
	ldr r0, [r4, #0xae0]
	mov r1, #0x11
	add r0, r2, r0, lsl #2
	ldr r0, [r0, #0x398]
	bl Boss3Arm__Func_2168F84
	add r0, r4, #0xa00
	mov r1, #0x3c
	strh r1, [r0, #0xe6]
	ldr r0, [r4, #0xae0]
	cmp r0, #0
	ldreq r0, =Boss3__StateBoss_21657A4
	streq r0, [r4, #0xa40]
	subne r0, r0, #1
	strne r0, [r4, #0xae0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21657A4(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r2, [r4, #0xa3c]
	mov r1, #0xf0
	add r5, r2, #0x398
	bl Boss3__Func_2163E64
	mov r1, #0
_021657C4:
	ldr r0, [r5, r1, lsl #2]
	ldr r0, [r0, #0x37c]
	cmp r0, #0xf
	addne sp, sp, #4
	ldmneia sp!, {r3, r4, r5, r6, pc}
	add r1, r1, #1
	cmp r1, #4
	blt _021657C4
	ldr r0, [r4, #0x138]
	mov r1, #0x1e
	bl NNS_SndPlayerStopSeq
	ldr r0, [r4, #0xaf4]
	cmp r0, #0
	ldrne r0, =Boss3__StateBoss_21656B8
	addne sp, sp, #4
	strne r0, [r4, #0xa40]
	ldmneia sp!, {r3, r4, r5, r6, pc}
	ldr r5, =_0217A82C
	mov r6, #0
_02165810:
	ldrsh r0, [r5, #0x4a]
	str r0, [sp]
	ldr r0, [r4, #0xa3c]
	ldrsh r1, [r5, #0x44]
	add r0, r0, r6, lsl #2
	ldr r0, [r0, #0x398]
	ldrsh r2, [r5, #0x46]
	ldrsh r3, [r5, #0x48]
	add r0, r0, #0x258
	bl ObjRect__SetBox2D
	add r6, r6, #1
	cmp r6, #4
	blt _02165810
	mov r0, r4
	mov r1, #7
	bl Boss3__Action_DecideNextAction
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	bic r1, r1, #2
	strh r1, [r0, #0xda]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__CreateInk(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	ldr r4, [r0, #0xa3c]
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, =0x00000131
	mov r2, r1
	mov r3, r1
	str r1, [sp, #0x10]
	bl GameObject__SpawnObject
	str r0, [r4, #0x388]
	str r4, [r0, #0x374]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21658B8(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x22
	bl BossHelpers__SetAnimation
	mov r1, #1
	ldr r0, =Boss3__StateBoss_2165900
	str r1, [r4, #0xaec]
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2165900(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	ldrne r0, =Boss3__StateBoss_216592C
	strne r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_216592C(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0xa00
	mov r1, #5
	strh r1, [r0, #0xe6]
	mov r1, #0
	add r0, r4, #0x1cc
	str r1, [sp]
	mov r2, #1
	str r2, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x23
	bl BossHelpers__SetAnimation
	ldr r0, =Boss3__StateBoss_216597C
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_216597C(Boss3 *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0xa00
	ldrh r2, [r1, #0xe6]
	cmp r2, #0
	subne r2, r2, #1
	strneh r2, [r1, #0xe6]
	add r1, r0, #0xa00
	ldrh r1, [r1, #0xe6]
	cmp r1, #0
	ldreq r1, =Boss3__StateBoss_21659AC
	streq r1, [r0, #0xa40]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21659AC(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x24
	bl BossHelpers__SetAnimation
	ldr r0, =Boss3__StateBoss_21659EC
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21659EC(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0xeb0]
	ldr r1, [r1, #0]
	cmp r1, #0x1000
	bne _02165A30
	bl Boss3__CreateInk
	mov r2, #0
	mov r0, #0xa4
	sub r1, r0, #0xa5
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02165A30:
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	ldrne r0, =Boss3__StateBoss_2165A50
	strne r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2165A50(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x25
	bl BossHelpers__SetAnimation
	ldr r0, =Boss3__StateBoss_2165A90
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2165A90(Boss3 *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0xe00
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldrne r1, =Boss3__StateBoss_2165AAC
	strne r1, [r0, #0xa40]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2165AAC(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	mov r3, r1
	add r0, r0, #0xc00
	bl BossHelpers__SetAnimation
	ldr r0, =Boss3__StateBoss_2165AF0
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2165AF0(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0xa3c]
	ldr r1, [r1, #0x388]
	add r1, r1, #0x300
	ldrh r1, [r1, #0xc8]
	cmp r1, #2
	ldmneia sp!, {r4, pc}
	mov r1, #7
	bl Boss3__Action_DecideNextAction
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xda]
	bic r1, r1, #2
	strh r1, [r0, #0xda]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__State_2165B2C(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r4, #0xf10
	mov r3, #0x26
	bl BossHelpers__SetAnimation
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x54
	ldr r2, [r4, #0xa30]
	add r0, r0, #0x1000
	mov r3, #0x26
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x384]
	ldr r0, =gPlayer
	bic r1, r1, #0x20
	str r1, [r4, #0x384]
	ldr r1, [r4, #0x6e8]
	ldr r2, =0x006BAA99
	bic r1, r1, #0x20
	str r1, [r4, #0x6e8]
	ldr r0, [r0, #0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__GetAngle
	add r1, r4, #0xa00
	strh r0, [r1, #0xd6]
	mov r0, #0
	strh r0, [r1, #0xd8]
	ldr r0, [r4, #0xa3c]
	mov r1, #0x13
	bl Boss3Stage__Func_2169164
	mov r0, #0
	str r0, [sp]
	mov r0, #0x9f
	str r0, [sp, #4]
	sub r1, r0, #0xa0
	ldr r0, [r4, #0xa3c]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	mov r0, #1
	bl SetHUDActiveScreen
	ldr r0, =Boss3__State_2165C0C
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__State_2165C0C(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_216242C
	ldr r0, =gPlayer
	ldr r2, =0x006BAA99
	ldr r0, [r0, #0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__GetAngle
	mov r1, #0x16
	str r1, [sp]
	add r1, r1, #0x20c
	str r1, [sp, #4]
	str r1, [sp, #8]
	add r2, r4, #0xa00
	mov r1, r0
	ldrh r0, [r2, #0xd6]
	ldrsh r2, [r2, #0xd8]
	mov r3, #0xb
	bl BossHelpers__Math__Func_2039360
	add r1, r4, #0xa00
	strh r0, [r1, #0xd8]
	ldrh r2, [r1, #0xd6]
	ldrsh r0, [r1, #0xd8]
	add r0, r2, r0
	strh r0, [r1, #0xd6]
	ldr r0, [r4, #0xff4]
	ldr r0, [r0, #0]
	cmp r0, #0x33000
	bne _02165CB8
	mov r0, #0
	mov r1, #0xa0
	stmia sp, {r0, r1}
	sub r1, r1, #0xa1
	ldr r0, [r4, #0xa3c]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
_02165CB8:
	add r0, r4, #0x1000
	ldrh r0, [r0, #0x1c]
	tst r0, #0x8000
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, pc}
	mov r1, #1
	ldr r0, =Boss3__State_2165CF0
	str r1, [r4, #0xae8]
	str r0, [r4, #0xa40]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__State_2165CF0(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r1, #0xf0
	ldr r4, [r5, #0xa3c]
	bl Boss3__Func_2163E64
	ldr r0, [r5, #0xa3c]
	bl Boss3Stage__Func_21624EC
	ldr r1, [r4, #0x3d4]
	ldr r2, [r4, #0x3d8]
	mov r0, r4
	bl Boss3Stage__Func_2163494
	cmp r0, #0
	ldrne r0, =Boss3__BossState_2165D30
	strne r0, [r5, #0xa40]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__BossState_2165D30(Boss3 *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0xa00
	mov r3, #0x78
	ldr r2, =Boss3__BossState_2165D4C
	strh r3, [r1, #0xe6]
	str r2, [r0, #0xa40]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__BossState_2165D4C(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_21625C8
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2162680
	ldr r1, [r4, #0xa3c]
	ldr r0, [r1, #0x40c]
	cmp r0, #0
	movne r0, #0
	strne r0, [r1, #0x40c]
	mov r0, r4
	mov r1, #7
	bl Boss3__Action_DecideNextAction
	ldr r0, [r4, #0xa3c]
	mov r1, #0xf
	bl Boss3Stage__Func_2169164
	add r0, r4, #0xa00
	ldrh r2, [r0, #0xda]
	mov r1, #1
	bic r2, r2, #2
	strh r2, [r0, #0xda]
	str r1, [r4, #0xa50]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__State_2165DD8(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xa3c]
	ldr r1, [r0, #0x388]
	cmp r1, #0
	ldrne r0, =Boss3DimInk__StateInk_2167EE4
	strne r0, [r1, #0x378]
	ldr r0, [r4, #0xa3c]
	mov r1, #0
	bl Boss3Stage__Func_2169164
	mov r0, #0
	bl SetHUDActiveScreen
	ldr r0, =Boss3__BossState_2165E1C
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__BossState_2165E1C(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r1, #0xf0
	ldr r4, [r5, #0xa3c]
	bl Boss3__Func_2163E64
	ldr r0, [r5, #0xa3c]
	bl Boss3Stage__Func_21624EC
	ldr r1, [r4, #0x3d8]
	ldr r2, [r4, #0x3d4]
	mov r0, r4
	bl Boss3Stage__Func_2163494
	cmp r0, #0
	ldrne r0, =Boss3__BossState_2165E5C
	strne r0, [r5, #0xa40]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__BossState_2165E5C(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r4, #0xf10
	mov r3, #0x28
	bl BossHelpers__SetAnimation
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x54
	ldr r2, [r4, #0xa30]
	add r0, r0, #0x1000
	mov r3, #0x28
	bl BossHelpers__SetAnimation
	mov r1, #0
	ldr r0, =Boss3__BossState_2165EC0
	str r1, [r4, #0xae8]
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__BossState_2165EC0(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_216242C
	ldr r0, =gPlayer
	ldr r2, =0x006BAA99
	ldr r0, [r0, #0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__GetAngle
	mov r1, #0x16
	str r1, [sp]
	add r1, r1, #0x20c
	str r1, [sp, #4]
	str r1, [sp, #8]
	add r2, r4, #0xa00
	mov r1, r0
	ldrh r0, [r2, #0xd6]
	ldrsh r2, [r2, #0xd8]
	mov r3, #0xb
	bl BossHelpers__Math__Func_2039360
	add r1, r4, #0xa00
	strh r0, [r1, #0xd8]
	ldrh r3, [r1, #0xd6]
	ldrsh r2, [r1, #0xd8]
	add r0, r4, #0x1000
	add r2, r3, r2
	strh r2, [r1, #0xd6]
	ldrh r0, [r0, #0x1c]
	tst r0, #0x8000
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x384]
	mov r1, #0
	orr r0, r0, #0x20
	str r0, [r4, #0x384]
	ldr r0, [r4, #0x6e8]
	orr r0, r0, #0x20
	str r0, [r4, #0x6e8]
	ldr r0, [r4, #0xa3c]
	add r0, r0, #0x300
	strh r1, [r0, #0xba]
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2163458
	mov r1, r0
	mov r0, r4
	bl Boss3__Func_2163F00
	ldr r1, =Boss3__BossState_2165FB0
	add r0, r4, #0xa00
	str r1, [r4, #0xa40]
	mov r1, #0x78
	strh r1, [r0, #0xe6]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__BossState_2165FB0(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_21622B4
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2162370
	mov r0, r4
	mov r1, #0
	bl Boss3__Action_DecideNextAction
	ldr r0, [r4, #0xa3c]
	mov r1, #0
	bl Boss3Stage__Func_2169164
	add r0, r4, #0xa00
	ldrh r2, [r0, #0xda]
	mov r1, #0
	bic r2, r2, #2
	strh r2, [r0, #0xda]
	str r1, [r4, #0xa50]
	str r1, [r4, #0xaec]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__State3_216602C(Boss3 *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =Boss3__State3_216603C
	str r1, [r0, #0xa44]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__State3_216603C(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x1f
	bl BossHelpers__SetAnimation
	mov r0, r4
	mov r1, #1
	bl Boss3__SetPaletteAnim
	ldr r0, =Boss3__State3_2166088
	str r0, [r4, #0xa44]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__State3_2166088(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0xeb0]
	ldr r1, [r1, #0]
	mov r1, r1, asr #0xc
	tst r1, #4
	beq _021660B8
	ldr r1, [r4, #0xa3c]
	add r1, r1, #0x300
	ldrh r1, [r1, #0xbc]
	bl Boss3__Action_2166184
	b _021660C0
_021660B8:
	mov r1, #1
	bl Boss3__SetPaletteAnim
_021660C0:
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	ldrne r0, =Boss3__State3_21660DC
	strne r0, [r4, #0xa44]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__State3_21660DC(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x20
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0xa3c]
	mov r0, r4
	add r1, r1, #0x300
	ldrh r1, [r1, #0xbc]
	bl Boss3__Action_2166184
	ldr r0, =Boss3__State3_2166130
	str r0, [r4, #0xa44]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__State3_2166130(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	mov r3, r1
	add r0, r0, #0xc00
	bl BossHelpers__SetAnimation
	mov r0, #0
	str r0, [r4, #0xa44]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__Action_2166184(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	cmp r1, #0
	beq _021661A4
	cmp r1, #1
	beq _021661B0
	cmp r1, #2
	beq _021661BC
	ldmia sp!, {r3, pc}
_021661A4:
	mov r1, #2
	bl Boss3__SetPaletteAnim
	ldmia sp!, {r3, pc}
_021661B0:
	mov r1, #4
	bl Boss3__SetPaletteAnim
	ldmia sp!, {r3, pc}
_021661BC:
	mov r1, #6
	bl Boss3__SetPaletteAnim
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__State4_21661C8(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0xa3c]
	add r1, r1, #0x300
	ldrh r1, [r1, #0xbc]
	cmp r1, #0
	beq _021661FC
	cmp r1, #1
	beq _02166208
	cmp r1, #2
	beq _02166214
	b _0216625C
_021661FC:
	mov r1, #3
	bl Boss3__SetPaletteAnim
	b _0216625C
_02166208:
	mov r1, #3
	bl Boss3__SetPaletteAnim
	b _0216625C
_02166214:
	mov r1, #5
	bl Boss3__SetPaletteAnim
	mov r2, #0
	mov r0, #0xa6
	sub r1, r0, #0xa7
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0xa3c]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	ldr r3, [r4, #0x4c]
	rsb r2, r0, #0
	mov r0, #0
	bl BossFX__CreateKrackenAngry
_0216625C:
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x1f
	bl BossHelpers__SetAnimation
	ldr r0, =Boss3__State4_2166290
	str r0, [r4, #0xa48]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__State4_2166290(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	add r1, r6, #0xb00
	ldrh r1, [r1, #0xec]
	mov r4, #0
	mov r5, r4
	tst r1, #0x8000
	beq _021662C8
	ldr r1, [r6, #0xa3c]
	add r1, r1, #0x300
	ldrh r1, [r1, #0xbc]
	bl Boss3__Action_2166184
	mov r4, #1
_021662C8:
	add r0, r6, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	beq _02166300
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r6, #0x1cc
	ldr r2, [r6, #0xa30]
	mov r3, r1
	add r0, r0, #0xc00
	bl BossHelpers__SetAnimation
	mov r5, #1
_02166300:
	cmp r4, #0
	cmpne r5, #0
	movne r0, #0
	strne r0, [r6, #0xa48]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__Action_2166318(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	mov r6, r0
	ldr r5, [r6, #0xa3c]
	mov r0, #2
	bl BossArena__GetCamera
	bl BossArena__GetCameraConfig2
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	mov r4, r0
	mov r2, r1
	mov r3, r1
	str r1, [sp, #0x10]
	mov r0, #0x130
	bl GameObject__SpawnObject
	add ip, r4, #0x20
	mov r4, r0
	str r0, [r5, #0x390]
	add r1, r6, #0xb60
	str r5, [r4, #0x374]
	add lr, r4, #0x44
	ldmia r1, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	ldr r1, [r4, #0x48]
	add r0, r4, #4
	rsb r1, r1, #0
	str r1, [r4, #0x48]
	add r3, r0, #0x400
	ldmia ip, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r3
	ldr r3, [r4, #0x408]
	mov r1, lr
	rsb r3, r3, #0
	add r2, sp, #0x14
	str r3, [r4, #0x408]
	bl VEC_Subtract
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x18]
	mov r1, r1, asr #4
	str r1, [sp, #0x14]
	ldr r1, [sp, #0x1c]
	mov r0, r0, asr #4
	mov r1, r1, asr #4
	str r0, [sp, #0x18]
	add r0, sp, #0x14
	str r1, [sp, #0x1c]
	add r3, r4, #0x98
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x1c]
	bic r0, r0, #0x80
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x18]
	orr r0, r0, #2
	str r0, [r4, #0x18]
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__Action_216640C(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	ldr r4, [r0, #0xa3c]
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	ldr r0, =0x00000133
	mov r2, r1
	mov r3, r1
	str r1, [sp, #0x10]
	bl GameObject__SpawnObject
	str r0, [r4, #0x394]
	ldr r1, =Boss3ScreenSplatInk__StateInk_21683F0
	str r4, [r0, #0x374]
	str r1, [r0, #0x378]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166460(Boss3 *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, [r0, #0xa50]
	cmp r1, #0
	ldreq r1, =Boss3__StateBoss_216648C
	streq r1, [r0, #0xa40]
	bxeq lr
	cmp r1, #1
	ldreq r1, =Boss3__StateBoss_216653C
	streq r1, [r0, #0xa40]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_216648C(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =Boss3__StateBoss_21664DC
	mov r4, r0
	str r1, [r4, #0xa40]
	ldr r0, [r4, #0xa3c]
	mov r1, #0
	add r0, r0, #0x300
	strh r1, [r0, #0xba]
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2163458
	mov r1, r0
	mov r0, r4
	bl Boss3__Func_2163F00
	add r1, r4, #0xa00
	mov r2, #0x78
	mov r0, #1
	strh r2, [r1, #0xe6]
	bl SetHUDActiveScreen
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21664DC(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_21625C8
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2162680
	ldr r0, =Boss3__StateBoss_216678C
	mov r1, #0
	str r0, [r4, #0xa40]
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2169164
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_216653C(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xa3c]
	ldr r1, [r0, #0x388]
	cmp r1, #0
	beq _02166570
	ldr r0, =Boss3DimInk__StateInk_2167EE4
	str r0, [r1, #0x378]
	ldr r0, [r4, #0xa3c]
	ldr r1, [r0, #0x388]
	ldr r0, [r1, #0x20]
	orr r0, r0, #0x20
	str r0, [r1, #0x20]
_02166570:
	mov r0, #1
	bl SetHUDActiveScreen
	ldr r0, =Boss3__StateBoss_216658C
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_216658C(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r1, #0xf0
	ldr r4, [r5, #0xa3c]
	bl Boss3__Func_2163E64
	ldr r0, [r5, #0xa3c]
	bl Boss3Stage__Func_2162738
	ldr r1, [r4, #0x3d8]
	ldr r2, [r4, #0x3d4]
	mov r0, r4
	bl Boss3Stage__Func_2163494
	cmp r0, #0
	ldrne r0, =Boss3__StateBoss_21665CC
	strne r0, [r5, #0xa40]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21665CC(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r4, #0xf10
	mov r3, #0x28
	bl BossHelpers__SetAnimation
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0x54
	ldr r2, [r4, #0xa30]
	add r0, r0, #0x1000
	mov r3, #0x28
	bl BossHelpers__SetAnimation
	mov r1, #0
	ldr r0, =Boss3__StateBoss_2166630
	str r1, [r4, #0xae8]
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166630(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2162738
	ldr r0, =gPlayer
	ldr r2, =0x006BAA99
	ldr r0, [r0, #0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__GetAngle
	mov r1, #0x16
	str r1, [sp]
	add r1, r1, #0x20c
	str r1, [sp, #4]
	str r1, [sp, #8]
	add r2, r4, #0xa00
	mov r1, r0
	ldrh r0, [r2, #0xd6]
	ldrsh r2, [r2, #0xd8]
	mov r3, #0xb
	bl BossHelpers__Math__Func_2039360
	add r1, r4, #0xa00
	strh r0, [r1, #0xd8]
	ldrh r3, [r1, #0xd6]
	ldrsh r2, [r1, #0xd8]
	add r0, r4, #0x1000
	add r2, r3, r2
	strh r2, [r1, #0xd6]
	ldrh r0, [r0, #0x1c]
	tst r0, #0x8000
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x384]
	mov r1, #0
	orr r0, r0, #0x20
	str r0, [r4, #0x384]
	ldr r0, [r4, #0x6e8]
	orr r0, r0, #0x20
	str r0, [r4, #0x6e8]
	ldr r0, [r4, #0xa3c]
	add r0, r0, #0x300
	strh r1, [r0, #0xba]
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2163458
	mov r1, r0
	mov r0, r4
	bl Boss3__Func_2163F00
	ldr r1, =Boss3__StateBoss_2166720
	add r0, r4, #0xa00
	str r1, [r4, #0xa40]
	mov r1, #0x78
	strh r1, [r0, #0xe6]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166720(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2162738
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2162680
	ldr r0, =Boss3__StateBoss_216678C
	mov r1, #0
	str r0, [r4, #0xa40]
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2169164
	mov r0, #0
	str r0, [r4, #0xa50]
	str r0, [r4, #0xaec]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_216678C(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x22
	bl BossHelpers__SetAnimation
	ldr r0, =Boss3__StateBoss_21667CC
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21667CC(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	ldrne r0, =Boss3__StateBoss_21667F8
	strne r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21667F8(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0xa00
	mov r1, #5
	strh r1, [r0, #0xe6]
	mov r1, #0
	add r0, r4, #0x1cc
	str r1, [sp]
	mov r2, #1
	str r2, [sp, #4]
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x23
	bl BossHelpers__SetAnimation
	ldr r0, =Boss3__StateBoss_2166848
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166848(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldreq r0, =Boss3__StateBoss_2166888
	streq r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166888(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x24
	bl BossHelpers__SetAnimation
	ldr r0, =Boss3__StateBoss_21668C8
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21668C8(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	ldr r0, [r4, #0xeb0]
	ldr r0, [r0, #0]
	cmp r0, #0x1000
	bne _02166918
	mov r0, r4
	bl Boss3__Action_2166318
	mov r2, #0
	mov r0, #0xa4
	sub r1, r0, #0xa5
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_02166918:
	ldr r0, [r4, #0xa3c]
	ldr r2, [r0, #0x390]
	cmp r2, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r1, [r2, #0x48]
	ldr r0, [r2, #0x408]
	cmp r1, r0
	addgt sp, sp, #8
	ldmgtia sp!, {r4, pc}
	ldr r1, [r2, #0x18]
	mov r0, r4
	orr r1, r1, #8
	str r1, [r2, #0x18]
	ldr r1, [r4, #0xa3c]
	mov r2, #0
	str r2, [r1, #0x390]
	bl Boss3__Action_216640C
	mov r2, #0
	mov r0, #0xa5
	sub r1, r0, #0xa6
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, =Boss3__StateBoss_2166998
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166998(Boss3 *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0xe00
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldrne r1, =Boss3__StateBoss_21669B4
	strne r1, [r0, #0xa40]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21669B4(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	add r0, r0, #0xc00
	mov r3, #0x25
	bl BossHelpers__SetAnimation
	ldr r0, =Boss3__StateBoss_21669F4
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21669F4(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	add r0, r4, #0xe00
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r4, #0x1cc
	ldr r2, [r4, #0xa30]
	mov r3, r1
	add r0, r0, #0xc00
	bl BossHelpers__SetAnimation
	ldr r0, =Boss3__StateBoss_2166A54
	str r0, [r4, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166A54(Boss3 *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0xa00
	mov r3, #0
	ldr r2, =Boss3__StateBoss_2166A70
	strh r3, [r1, #0xe6]
	str r2, [r0, #0xa40]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166A70(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	add r0, r6, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r6, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r2, =_mt_math_rand
	mov r4, #0
	ldr r3, [r2, #0]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	mov r5, r4
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #3
	str r1, [r2]
	mov r7, r0, lsl #0x1e
	mov r8, #0x15
_02166ADC:
	ldr r1, [r6, #0xa3c]
	mov r0, r5, lsl #0x10
	add r1, r1, r4, lsl #2
	ldr r1, [r1, #0x398]
	mov r0, r0, lsr #0x10
	add r2, r0, r7, lsr #16
	add r0, r1, #0x400
	strh r2, [r0, #0x44]
	ldr r0, [r6, #0xa3c]
	mov r1, r8
	bl Boss3Stage__Func_2169164
	add r4, r4, #1
	cmp r4, #4
	add r5, r5, #0x4000
	blt _02166ADC
	ldr r0, =Boss3__StateBoss_2166B34
	str r0, [r6, #0xa40]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166B34(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r1, #0xf0
	mov r4, r0
	bl Boss3__Func_2163E64
	ldr r2, [r4, #0xa3c]
	mov r1, #0
_02166B4C:
	add r0, r2, r1, lsl #2
	ldr r0, [r0, #0x398]
	ldr r0, [r0, #0x37c]
	cmp r0, #0x16
	cmpne r0, #0
	cmpne r0, #0xf
	ldmneia sp!, {r4, pc}
	add r1, r1, #1
	cmp r1, #4
	blt _02166B4C
	add r0, r4, #0xa00
	mov r2, #0x258
	ldr r1, =Boss3__StateBoss_2166B90
	strh r2, [r0, #0xe6]
	str r1, [r4, #0xa40]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166B90(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0xf0
	bl Boss3__Func_2163E64
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, =Boss3__StateBoss_2166BF4
	ldr r2, =Boss3ScreenSplatInk__StateInk_21684EC
	str r0, [r4, #0xa40]
	ldr r0, [r4, #0xa3c]
	mov r1, #0
	ldr r0, [r0, #0x394]
	str r2, [r0, #0x378]
	ldr r0, [r4, #0xa3c]
	str r1, [r0, #0x394]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166BF4(Boss3 *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =Boss3Arm__StateArm_216B5B4
	mov ip, #0
_02166BFC:
	ldr r2, [r0, #0xa3c]
	add r2, r2, ip, lsl #2
	ldr r3, [r2, #0x398]
	add ip, ip, #1
	ldr r2, [r3, #0x37c]
	cmp r2, #0x16
	streq r1, [r3, #0x378]
	cmp ip, #4
	blt _02166BFC
	ldr r1, =Boss3__StateBoss_2166C34
	str r1, [r0, #0xa40]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166C34(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r1, #0xf0
	mov r4, r0
	bl Boss3__Func_2163E64
	ldr r2, [r4, #0xa3c]
	mov r1, #0
_02166C4C:
	add r0, r2, r1, lsl #2
	ldr r0, [r0, #0x398]
	ldr r0, [r0, #0x37c]
	cmp r0, #0
	cmpne r0, #0xf
	ldmneia sp!, {r4, pc}
	add r1, r1, #1
	cmp r1, #4
	blt _02166C4C
	add r0, r4, #0xa00
	ldrh r2, [r0, #0xda]
	ldr r1, =Boss3__StateBoss_2166C9C
	bic r2, r2, #2
	strh r2, [r0, #0xda]
	ldrh r2, [r0, #0xda]
	bic r2, r2, #0x10
	strh r2, [r0, #0xda]
	str r1, [r4, #0xa40]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166C9C(Boss3 *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r2, =Boss3__StateBoss_2166CC4
	ldr ip, =SetHUDActiveScreen
	str r2, [r0, #0xa40]
	add r1, r0, #0xa00
	mov r2, #0x78
	mov r0, #0
	strh r2, [r1, #0xe6]
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166CC4(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_21622B4
	add r0, r4, #0xa00
	ldrh r1, [r0, #0xe6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xe6]
	add r0, r4, #0xa00
	ldrh r0, [r0, #0xe6]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2162370
	ldr r0, [r4, #0xa3c]
	mov r1, #0
	add r0, r0, #0x300
	strh r1, [r0, #0xba]
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_2163458
	mov r1, r0
	mov r0, r4
	bl Boss3__Func_2163F00
	ldr r0, [r4, #0xa3c]
	mov r1, #0xcc
	add r0, r0, #0x300
	strh r1, [r0, #0xb8]
	ldr r0, [r4, #0xa3c]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0xb8]
	bl UpdateBossHealthHUD
	mov r0, r4
	mov r1, #0
	bl Boss3__Action_DecideNextAction
	ldr r0, [r4, #0xa3c]
	mov r1, #0
	bl Boss3Stage__Func_2169164
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166D60(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	add r4, r5, #0xaf0
	mov r1, r4
	mov r0, #0
	mov r2, #0xa
	bl MIi_CpuClear16
	mov r0, #0
_02166D84:
	ldr r1, [r5, #0xa3c]
	add r1, r1, r0, lsl #2
	ldr r2, [r1, #0x398]
	ldr r1, [r2, #0x39c]
	bic r1, r1, #4
	str r1, [r2, #0x39c]
	ldr r1, [r5, #0xa3c]
	add r1, r1, r0, lsl #2
	ldr r2, [r1, #0x398]
	ldr r1, [r2, #0x3dc]
	bic r1, r1, #4
	str r1, [r2, #0x3dc]
	ldr r1, [r5, #0xa3c]
	add r1, r1, r0, lsl #2
	ldr r2, [r1, #0x398]
	add r0, r0, #1
	ldr r1, [r2, #0x41c]
	cmp r0, #4
	bic r1, r1, #4
	str r1, [r2, #0x41c]
	blt _02166D84
	ldr r0, =playerGameStatus
	ldr r1, [r0, #0]
	bic r1, r1, #1
	str r1, [r0]
	bl StopStageBGM
	ldr r0, =gPlayer
	ldr r0, [r0, #0]
	bl Player__Action_Blank
	ldr r0, =gPlayer
	mov r1, #0x12
	ldr r0, [r0, #0]
	bl Player__ChangeAction
	mov r2, #0
	ldr r1, =gPlayer
	ldr r0, [r1, #0]
	add r0, r0, #0x600
	strh r2, [r0, #0x82]
	ldr r0, [r1, #0]
	bl BossHelpers__Player__LockControl
	mov r0, #0
	str r0, [r5, #0xee4]
	bl EnableObjectManagerFlag2
	ldr r0, [r5, #0x18]
	ldr r1, =gPlayer
	orr r0, r0, #0x20
	str r0, [r5, #0x18]
	ldr r3, [r5, #0xa3c]
	mov r0, #0
	ldr r2, [r3, #0x18]
	orr r2, r2, #0x20
	str r2, [r3, #0x18]
	ldr r2, [r5, #0xa3c]
	ldr r3, [r2, #0x394]
	ldr r2, [r3, #0x18]
	orr r2, r2, #0x20
	str r2, [r3, #0x18]
	ldr r3, [r1, #0]
	ldr r1, [r3, #0x1b0]
	ldr r2, [r3, #0x1b4]
	ldr r3, [r3, #0x1b8]
	bl BossFX__CreateKrackenExplode2
	mov r0, #0
	str r0, [sp]
	mov r1, #0xce
	str r1, [sp, #4]
	sub r1, r1, #0xcf
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r3, =Boss3ScreenSplatInk__StateInk_21684EC
	ldr r0, [r5, #0xa3c]
	mov r2, #0
	ldr r1, [r0, #0x394]
	ldr r0, =Boss3__StateBoss_2166EDC
	str r3, [r1, #0x378]
	ldr r1, [r5, #0xa3c]
	str r2, [r1, #0x394]
	strh r2, [r4, #8]
	str r0, [r5, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166EDC(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0xaf0
	ldrh r0, [r1, #8]
	add r0, r0, #1
	strh r0, [r1, #8]
	ldrh r0, [r1, #8]
	cmp r0, #0x5a
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xa3c]
	bl Boss3Stage__Func_21627F0
	ldr r0, =Boss3__StateBoss_2166F18
	str r0, [r4, #0xa40]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166F18(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetSwapBuffer3DWork
	mov r4, r0
	add r1, r4, #0x20
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	ldrh r1, [r4, #0x20]
	add r0, r5, #0xa00
	mov r2, #0
	bic r1, r1, #0xc0
	orr r1, r1, #0xc0
	strh r1, [r4, #0x20]
	ldrh r3, [r4, #0x20]
	ldr r1, =Boss3__StateBoss_2166F80
	bic r3, r3, #1
	orr r3, r3, #1
	strh r3, [r4, #0x20]
	ldrh r3, [r4, #0x20]
	orr r3, r3, #0x1e
	strh r3, [r4, #0x20]
	strh r2, [r0, #0xf8]
	str r1, [r5, #0xa40]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2166F80(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r10, r0
	ldr r4, [r10, #0xa3c]
	add r8, r10, #0xaf0
	bl GetSwapBuffer3DWork
	add r1, r4, #0x400
	ldrsh r3, [r1, #0x54]
	mvn r2, #0xf
	cmp r3, r2
	beq _02166FD8
	ldrh r2, [r8, #2]
	add r2, r2, #1
	strh r2, [r8, #2]
	ldrh r2, [r8, #2]
	cmp r2, #1
	bls _02166FD8
	mov r2, #0
	strh r2, [r8, #2]
	ldrsh r2, [r1, #0x54]
	sub r2, r2, #1
	strh r2, [r1, #0x54]
_02166FD8:
	ldrh r1, [r0, #0x24]
	cmp r1, #0x10
	bhs _02167010
	ldrh r1, [r8, #0]
	add r1, r1, #1
	strh r1, [r8]
	ldrh r1, [r8, #0]
	cmp r1, #2
	bls _02167010
	mov r1, #0
	strh r1, [r8]
	ldrh r1, [r0, #0x24]
	add r1, r1, #1
	strh r1, [r0, #0x24]
_02167010:
	mov r9, #0
	ldr r7, =BossArena__explosionFXSpawnTime
	mov r11, r9
	mov r6, r9
	mov r5, #0xcd
	mvn r4, #0
_02167028:
	ldrh r1, [r8, #8]
	ldr r0, [r7, r9, lsl #2]
	cmp r1, r0
	bne _02167090
	ldr r1, [r10, #0xa3c]
	mov r0, r11
	ldr r3, [r1, #0x398]
	ldr r1, [r3, #0x4c0]
	ldr r2, [r3, #0x4c4]
	ldr r3, [r3, #0x4c8]
	bl BossFX__CreateKrackenExplode0
	str r6, [sp]
	str r5, [sp, #4]
	ldr r0, [r10, #0xa3c]
	mov r1, r4
	ldr r0, [r0, #0x138]
	mov r2, r4
	mov r3, r4
	bl PlaySfxEx
	add r0, r4, #0x204
	mov r1, #0x2000
	bl CreateDrawFadeTask
	mov r0, #0x3000
	mov r1, r0
	mov r2, #0x600
	bl ShakeScreenCycle
_02167090:
	add r9, r9, #1
	cmp r9, #3
	blt _02167028
	ldrh r1, [r8, #8]
	add r0, r1, #1
	strh r0, [r8, #8]
	cmp r1, #0xd2
	ldrhi r0, =Boss3__StateBoss_21670C4
	strhi r0, [r10, #0xa40]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_21670C4(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0xa3c]
	mov r0, #0
	ldr r3, [r1, #0x398]
	ldr r1, [r3, #0x4c0]
	ldr r2, [r3, #0x4c4]
	ldr r3, [r3, #0x4c8]
	bl BossFX__CreateKrackenExplode1
	mov r2, #0x2000
	str r2, [r0, #0x38]
	str r2, [r0, #0x3c]
	str r2, [r0, #0x40]
	ldr r1, =0x00000555
	mov r2, #0xe3
	str r1, [r0, #0x280]
	mov r0, #0xa000
	mov r1, #0x3000
	bl ShakeScreenCycle
	mov r2, #0
	mov r0, #0x8d
	str r2, [sp]
	sub r1, r0, #0x8e
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r1, =Boss3__StateBoss_2167164
	add r0, r4, #0xa00
	mov r2, #0
	strh r2, [r0, #0xf8]
	mov r0, r4
	str r1, [r4, #0xa40]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3__StateBoss_2167164(Boss3 *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	mov r7, r0
	ldr r0, [r7, #0xa3c]
	add r4, r7, #0xaf0
	str r0, [sp, #4]
	bl GetSwapBuffer3DWork
	ldrh r1, [r4, #4]
	mov r5, r0
	mov r6, #0
	add r0, r1, #1
	strh r0, [r4, #4]
	ldrh r0, [r4, #4]
	str r6, [sp]
	cmp r0, #3
	bls _021672B8
	ldr r1, =_mt_math_rand
	ldr r2, =0x3C6EF35F
	ldr r3, [r1, #0]
	ldr r1, =0x00196225
	mov r11, #0xc8000
	mla r8, r3, r1, r2
	mla r3, r8, r1, r2
	mla r10, r3, r1, r2
	mov r2, r8, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r1, r3, lsr #0x10
	mov r9, r1, lsl #0x10
	mov r2, r2, asr #4
	umull r8, r3, r2, r11
	mov r1, r10, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov ip, r1, asr #4
	adds r8, r8, #0x800
	mov r9, r9, lsr #0x10
	mov lr, r9, asr #4
	mla r3, r2, r6, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r11, r3
	adc r1, r3, r6
	mov r8, r8, lsr #0xc
	orr r8, r8, r1, lsl #20
	mov r1, ip, asr #0x1f
	add r0, r7, #0xb60
	str r1, [sp, #8]
	ldmia r0, {r0, r1, r2}
	ldr r9, =_mt_math_rand
	mov r3, lr, asr #0x1f
	str r10, [r9]
	add r9, sp, #0xc
	stmia r9, {r0, r1, r2}
	umull r10, r9, lr, r11
	mla r9, lr, r6, r9
	mla r9, r3, r11, r9
	adds r10, r10, #0x800
	adc r3, r9, r6
	mov r9, r10, lsr #0xc
	orr r9, r9, r3, lsl #20
	sub r3, r9, #0x64000
	ldr r2, [sp, #0x14]
	ldr r9, [sp, #8]
	add r3, r2, r3
	mov r2, #0x96000
	umull r11, r10, ip, r2
	mla r10, ip, r6, r10
	mla r10, r9, r2, r10
	adds r9, r11, #0x800
	ldr r0, [sp, #0xc]
	sub r8, r8, #0x64000
	add r1, r0, r8
	adc r2, r10, r6
	mov r9, r9, lsr #0xc
	orr r9, r9, r2, lsl #20
	ldr r8, [sp, #0x10]
	add r2, r9, #0x1e000
	add r2, r8, r2
	mov r0, r6
	str r1, [sp, #0xc]
	str r3, [sp, #0x14]
	str r2, [sp, #0x10]
	bl BossFX__CreateBomb2
	mov r0, r6
	strh r0, [r4, #4]
_021672B8:
	ldr r0, [sp, #4]
	add r0, r0, #0x400
	ldrsh r1, [r0, #0x54]
	cmp r1, #0
	addne r1, r1, #1
	strneh r1, [r0, #0x54]
	ldrsh r0, [r5, #0x58]
	moveq r6, #1
	cmp r0, #0x10
	bge _02167328
	ldrh r0, [r4, #8]
	cmp r0, #0xb4
	bls _02167330
	ldrh r0, [r4, #6]
	add r0, r0, #1
	strh r0, [r4, #6]
	ldrh r0, [r4, #6]
	cmp r0, #3
	bls _02167330
	ldrsh r1, [r5, #0x58]
	mov r0, #0
	add r1, r1, #1
	strh r1, [r5, #0x58]
	ldrsh r1, [r5, #0xb4]
	add r1, r1, #1
	strh r1, [r5, #0xb4]
	strh r0, [r4, #6]
	b _02167330
_02167328:
	mov r0, #1
	str r0, [sp]
_02167330:
	ldrh r0, [r4, #8]
	cmp r6, #0
	add r0, r0, #1
	strh r0, [r4, #8]
	ldrne r0, [sp]
	cmpne r0, #0
	ldrne r0, =Boss3_BossState_ShowResultsScreen
	strne r0, [r7, #0xa40]
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void Boss3_BossState_ShowResultsScreen(Boss3 *work)
{
    playerGameStatus.flags |= PLAYERGAMESTATUS_FLAG_CAN_CHANGE_EVENT;
}

void Boss3SplatInk__State_2167380(Boss3SplatInk *work)
{
    work->stateInk(work);
}

void Boss3SplatInk__Destructor(Task *task)
{
    Boss3SplatInk *work = TaskGetWork(task, Boss3SplatInk);

    AnimatorMDL__Release(&work->animatormdl410);
    AnimatorMDL__Release(&work->animatormdl554);

    GameObject__Destructor(task);
}

void Boss3SplatInk__Draw(void)
{
    Boss3SplatInk *work = TaskGetWorkCurrent(Boss3SplatInk);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        AnimatorMDL *aniMDL;
        if (work->action == 2 || work->action == 3)
        {
            aniMDL = &work->animatormdl554;
        }
        else
        {
            VecFx32 right;
            right.x = FLOAT_TO_FX32(1.0);
            right.y = FLOAT_TO_FX32(0.0);
            right.z = FLOAT_TO_FX32(0.0);

            aniMDL = &work->animatormdl410;

            VecFx32 dir;
            VEC_Normalize(&work->gameWork.objWork.velocity, &dir);
            fx32 x = dir.x;
            dir.y  = -dir.y;

            s32 angle = FX_Atan2Idx(FX_Sqrt(MultiplyFX(dir.y, dir.y) + MultiplyFX(dir.z, dir.z)), x);

            VecFx32 cross;
            VEC_CrossProduct(&right, &dir, &cross);
            VEC_Normalize(&cross, &cross);
            MTX_RotAxis33(aniMDL->work.rotation.nnMtx, &cross, SinFX(angle), CosFX(angle));
        }

        aniMDL->work.translation   = work->gameWork.objWork.position;
        aniMDL->work.translation.y = -aniMDL->work.translation.y;
        AnimatorMDL__ProcessAnimation(aniMDL);
        AnimatorMDL__Draw(aniMDL);
    }
}

void Boss3SplatInk__Collide(void)
{
    Boss3SplatInk *work = TaskGetWorkCurrent(Boss3SplatInk);

    if ((work->gameWork.objWork.flag & (STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_DESTROYED)) != 0)
        return;

    if ((work->gameWork.objWork.flag & (STAGE_TASK_FLAG_NO_OBJ_COLLISION)) != 0)
        return;

    for (s32 i = 0; i < 2; i++)
    {
        OBS_RECT_WORK *colliderSrc = &work->gameWork.colliders[i];
        OBS_RECT_WORK *colliderDst = &work->worldColliders[i];

        VecFx32 translation = work->gameWork.objWork.position;
        translation.y       = -translation.y;

        if ((colliderSrc->flag & OBS_RECT_WORK_FLAG_ENABLED) == 0)
            continue;

        BossHelpers__Collision__HandleArenaCollider(colliderSrc, colliderDst, &translation, BOSS3_STAGE_START, BOSS3_STAGE_END, BOSS3_STAGE_RADIUS);
    }
}

void Boss3SplatInk__OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    // Do nothing
}

void Boss3SplatInk__Action_DecideNextAction(Boss3SplatInk *work, s32 action)
{
    work->action = action;

    switch (action)
    {
        case 0:
            work->stateInk = Boss3SplatInk__StateInk_216760C;
            break;

        case 1:
            work->stateInk = Boss3SplatInk__StateInk_216768C;
            break;

        case 2:
            work->stateInk = Boss3SplatInk__StateInk_2167764;
            break;

        case 3:
            work->stateInk = Boss3SplatInk__StateInk_2167784;
            break;
    }

    work->stateInk(work);
}

NONMATCH_FUNC void Boss3SplatInk__StateInk_216760C(Boss3SplatInk *work)
{
    // Should match when 'aExc_3' is decompiled
#ifdef NON_MATCHING
    work->stateInk = Boss3SplatInk__StateInk_216767C;

    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);
    BossHelpers__SetAnimation(&work->animatormdl410, B3D_ANIM_JOINT_ANIM, NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z3BOSS_ACT_LZ7_FILE_BSEF3_INK_NSBCA), 0, NULL, TRUE);
    NNS_FndUnmountArchive(&arc);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x70
	ldr r1, =Boss3SplatInk__StateInk_216767C
	mov r4, r0
	str r1, [r4, #0x378]
	ldr r0, =gameArchiveStage
	ldr r1, =aExc_3
	ldr r2, [r0, #0]
	add r0, sp, #8
	bl NNS_FndMountArchive
	add r0, sp, #8
	mov r1, #0x1a
	bl NNS_FndGetArchiveFileByIndex
	mov r1, #0
	mov r2, r0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	mov r3, r1
	add r0, r4, #0x410
	bl BossHelpers__SetAnimation
	add r0, sp, #8
	bl NNS_FndUnmountArchive
	add sp, sp, #0x70
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void Boss3SplatInk__StateInk_216767C(Boss3SplatInk *work)
{
    Boss3SplatInk__Action_DecideNextAction(work, 1);
}

void Boss3SplatInk__StateInk_216768C(Boss3SplatInk *work)
{
    work->stateInk = Boss3SplatInk__StateInk_216769C;
}

void Boss3SplatInk__StateInk_216769C(Boss3SplatInk *work)
{
    VecFx32 translation;
    translation   = work->animatormdl410.work.translation;
    translation.y = FLOAT_TO_FX32(0.0);

    if (MATH_ABS(VEC_Mag(&translation)) >= FLOAT_TO_FX32(211.1875))
        work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_ENABLED;

    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY) == 0)
        return;

    work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.velocity.y = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.velocity.z = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.position.y = work->stage->dword3C4 - FLOAT_TO_FX32(1.0);
    PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SUMI_GROUND);
    Boss3SplatInk__Action_DecideNextAction(work, 2);
}

void Boss3SplatInk__StateInk_2167764(Boss3SplatInk *work)
{
    work->gameWork.colliders[1].flag &= ~OBS_RECT_WORK_FLAG_ENABLED;
    work->stateInk = Boss3SplatInk__StateInk_2167780;
}

void Boss3SplatInk__StateInk_2167780(Boss3SplatInk *work)
{
    // Do nothing
}

NONMATCH_FUNC void Boss3SplatInk__StateInk_2167784(Boss3SplatInk *work)
{
    // Should match when 'aExc_3' is decompiled
#ifdef NON_MATCHING
    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);
    BossHelpers__SetAnimation(&work->animatormdl554, B3D_ANIM_MAT_ANIM, NNS_FndGetArchiveFileByIndex(&archivePtr, ARCHIVE_Z3BOSS_ACT_LZ7_FILE_BSEF3_INK_NSBMA), 0, NULL, FALSE);
    NNS_FndUnmountArchive(&arc);

    work->stateInk = Boss3SplatInk__StateInk_21677F4;
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x70
	ldr r1, =gameArchiveStage
	mov r4, r0
	ldr r2, [r1, #0]
	ldr r1, =aExc_3
	add r0, sp, #8
	bl NNS_FndMountArchive
	add r0, sp, #8
	mov r1, #0x1b
	bl NNS_FndGetArchiveFileByIndex
	mov r3, #0
	str r3, [sp]
	add r1, r4, #0x154
	mov r2, r0
	add r0, r1, #0x400
	mov r1, #1
	str r3, [sp, #4]
	bl BossHelpers__SetAnimation
	add r0, sp, #8
	bl NNS_FndUnmountArchive
	ldr r0, =Boss3SplatInk__StateInk_21677F4
	str r0, [r4, #0x378]
	add sp, sp, #0x70
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void Boss3SplatInk__StateInk_21677F4(Boss3SplatInk *work)
{
    if ((work->animatormdl554.animFlags[B3D_ANIM_MAT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
        work->gameWork.objWork.flag |= OBS_RECT_WORK_FLAG_ENABLED;
}

void Boss3DimInk__State_2167810(Boss3DimInk *work)
{
    if (work->field_3C8 == 2)
    {
        FXMatrix43 mtx;

        work->gameWork.objWork.position.x = FLOAT_TO_FX32(0.0);
        work->gameWork.objWork.position.y = gPlayer->objWork.position.y;
        work->gameWork.objWork.position.z = FLOAT_TO_FX32(527.96875);
        MTX_RotY43(mtx.nnMtx, SinFX(work->angle), CosFX(work->angle));
        work->rotation1 = mtx.mtx33;

        MTX_MultVec43(&work->gameWork.objWork.position, mtx.nnMtx, &work->gameWork.objWork.position);
    }
    else
    {
        VecFx32 dir;
        dir.x = SinFX((s32)(u16)(work->stage->boss->field_AD4 + FLOAT_DEG_TO_IDX(90.0)));
        dir.y = FLOAT_TO_FX32(0.0);
        dir.z = CosFX((s32)(u16)(work->stage->boss->field_AD4 + FLOAT_DEG_TO_IDX(90.0)));
        VEC_Normalize(&dir, &dir);

        MTX_RotAxis33(work->rotation2.nnMtx, &dir, SinFX(FLOAT_DEG_TO_IDX(45.0)), CosFX(FLOAT_DEG_TO_IDX(45.0)));
    }

    work->stateInk(work);
}

void Boss3DimInk__Destructor(Task *task)
{
    Boss3DimInk *work = TaskGetWork(task, Boss3DimInk);

    AnimatorMDL__Release(&work->aniModel1);
    AnimatorMDL__Release(&work->aniModel2);
    AnimatorMDL__Release(&work->aniModel3);

    GameObject__Destructor(task);
}

void Boss3DimInk__Draw(void)
{
    Boss3DimInk *work = TaskGetWorkCurrent(Boss3DimInk);

    Boss3 *boss = work->stage->boss;

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        AnimatorMDL *aniMDL;

        switch (work->field_3C8)
        {
            case 0:
                work->aniModel2.work.rotation = work->rotation2;
                Unknown2066510__NormalizeScale(&work->aniModel2.work.rotation, &work->aniModel2.work.rotation);
                aniMDL = &work->aniModel2;

                aniMDL->work.translation = boss->field_B3C.row[3];
                break;

            case 1:
                work->aniModel3.work.rotation = work->rotation2;
                Unknown2066510__NormalizeScale(&work->aniModel3.work.rotation, &work->aniModel3.work.rotation);
                aniMDL = &work->aniModel3;

                aniMDL->work.translation = boss->field_B3C.row[3];
                break;

            case 2:
                work->aniModel1.work.rotation = work->rotation1;

                aniMDL                     = &work->aniModel1;
                aniMDL->work.translation   = work->gameWork.objWork.position;
                aniMDL->work.translation.y = -aniMDL->work.translation.y;
                break;
        }

        if (SwapBuffer3D_GetPrimaryScreen() != SWAPBUFFER3D_PRIMARY_BOTTOM)
            NNS_G3dMdlSetMdlDepthTestCondAll(aniMDL->renderObj.resMdl, TRUE);
        else
            NNS_G3dMdlSetMdlDepthTestCondAll(aniMDL->renderObj.resMdl, FALSE);
        AnimatorMDL__ProcessAnimation(aniMDL);
        AnimatorMDL__Draw(aniMDL);
    }
}

void Boss3DimInk__Action_2167B08(Boss3DimInk *work)
{
    work->gameWork.objWork.position.y = gPlayer->objWork.position.y;
    work->angle                       = BossHelpers__Arena__GetAngle(gPlayer->objWork.position.x, BOSS3_STAGE_START, BOSS3_STAGE_END);
}

void Boss3DimInk__Action_2167B48(Boss3DimInk *work, u16 angle)
{
    Boss3Stage *stage = work->stage;

    Boss3InkSmoke *smoke = SpawnStageObject(MAPOBJECT_306, 0, 0, Boss3InkSmoke);
    stage->smoke         = smoke;
    smoke->stage         = stage;

    VEC_Set(&smoke->gameWork.objWork.position, FLOAT_TO_FX32(0.0), stage->boss->gameWork.objWork.position.y, FLOAT_TO_FX32(0.0));

    smoke->angle     = angle;
    smoke->field_3A2 = -46;
}

void Boss3DimInk__Action_2167BBC(s32 a1)
{
    SwapBuffer3D *swapBuffer = GetSwapBuffer3DWork();

    MI_CpuClear16(&swapBuffer->gfxControl[GRAPHICS_ENGINE_B].blendManager, sizeof(swapBuffer->gfxControl[GRAPHICS_ENGINE_B].blendManager));

    swapBuffer->gfxControl[GRAPHICS_ENGINE_B].blendManager.blendControl.plane1_BG0 = TRUE;
    swapBuffer->gfxControl[GRAPHICS_ENGINE_B].blendManager.blendControl.effect     = BLENDTYPE_FADEOUT;
    swapBuffer->gfxControl[GRAPHICS_ENGINE_B].blendManager.coefficient.value5      = MATH_ABS(FX32_TO_WHOLE(MultiplyFX(a1, FLOAT_TO_FX32(16.0))));
}

NONMATCH_FUNC void Boss3DimInk__StateInk_2167C44(Boss3DimInk *work)
{
    // Should match when 'aExc_3' is decompiled
#ifdef NON_MATCHING
    work->field_3CC = FLOAT_TO_FX32(0.0);
    work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
    work->field_3C8 = 0;

    NNSFndArchive arc;
    NNS_FndMountArchive(&arc, "exc", gameArchiveStage);
    BossHelpers__SetAnimation(&work->aniModel2, B3D_ANIM_JOINT_ANIM, NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z3BOSS_ACT_LZ7_FILE_BSEF3_BLD_NSBCA), 0, NULL, FALSE);
    BossHelpers__SetAnimation(&work->aniModel2, B3D_ANIM_TEX_ANIM, NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z3BOSS_ACT_LZ7_FILE_BSEF3_BLD_NSBTA), 0, NULL, FALSE);
    NNS_FndUnmountArchive(&arc);

    work->stateInk = Boss3DimInk__StateInk_2167CFC;
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x70
	mov r4, r0
	mov r2, #0
	str r2, [r4, #0x3cc]
	ldr r1, [r4, #0x20]
	add r0, r4, #0x300
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	strh r2, [r0, #0xc8]
	ldr r1, =gameArchiveStage
	add r0, sp, #8
	ldr r2, [r1, #0]
	ldr r1, =aExc_3
	bl NNS_FndMountArchive
	add r0, sp, #8
	mov r1, #0x1d
	bl NNS_FndGetArchiveFileByIndex
	mov r1, #0
	str r1, [sp]
	add ip, r4, #0x114
	mov r2, r0
	mov r3, r1
	add r0, ip, #0x400
	str r1, [sp, #4]
	bl BossHelpers__SetAnimation
	add r0, sp, #8
	mov r1, #0x1e
	bl NNS_FndGetArchiveFileByIndex
	mov r2, r0
	mov r3, #0
	add r0, r4, #0x114
	str r3, [sp]
	add r0, r0, #0x400
	mov r1, #3
	str r3, [sp, #4]
	bl BossHelpers__SetAnimation
	add r0, sp, #8
	bl NNS_FndUnmountArchive
	ldr r0, =Boss3DimInk__StateInk_2167CFC
	str r0, [r4, #0x378]
	add sp, sp, #0x70
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void Boss3DimInk__StateInk_2167CFC(Boss3DimInk *work)
{
    if ((work->aniModel2.animFlags[B3D_ANIM_JOINT_ANIM] & ANIMATORMDL_FLAG_FINISHED) != 0)
        work->stateInk = Boss3DimInk__StateInk_2167D18;
}

NONMATCH_FUNC void Boss3DimInk__StateInk_2167D18(Boss3DimInk *work)
{
    // Should match when 'aExc_3' is decompiled
#ifdef NON_MATCHING
    work->field_3C8 = 1;

    NNSFndArchive arc;
    NNS_FndMountArchive(&archivePtr, "exc", gameArchiveStage);
    BossHelpers__SetAnimation(&work->aniModel3, B3D_ANIM_JOINT_ANIM, NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z3BOSS_ACT_LZ7_FILE_BSEF3_BLD_NSBCA), 1, NULL, TRUE);
    BossHelpers__SetAnimation(&work->aniModel3, B3D_ANIM_TEX_ANIM, NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_Z3BOSS_ACT_LZ7_FILE_BSEF3_BLD_NSBTA), 1, NULL, TRUE);
    NNS_FndUnmountArchive(&archivePtr);

    work->field_3CA = 120;
    Boss3DimInk__Action_2167B48(work, work->stage->boss->playerPos);

    work->stateInk = Boss3DimInk__StateInk_2167DE8;
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x70
	mov r4, r0
	ldr r1, =gameArchiveStage
	add r0, r4, #0x300
	mov r2, #1
	strh r2, [r0, #0xc8]
	ldr r2, [r1, #0]
	ldr r1, =aExc_3
	add r0, sp, #8
	bl NNS_FndMountArchive
	add r0, sp, #8
	mov r1, #0x1d
	bl NNS_FndGetArchiveFileByIndex
	mov r1, #0
	add ip, r4, #0x258
	mov r2, r0
	str r1, [sp]
	mov r3, #1
	add r0, ip, #0x400
	str r3, [sp, #4]
	bl BossHelpers__SetAnimation
	add r0, sp, #8
	mov r1, #0x1e
	bl NNS_FndGetArchiveFileByIndex
	mov r2, r0
	mov r0, #0
	str r0, [sp]
	add r0, r4, #0x258
	mov r3, #1
	add r0, r0, #0x400
	mov r1, #3
	str r3, [sp, #4]
	bl BossHelpers__SetAnimation
	add r0, sp, #8
	bl NNS_FndUnmountArchive
	mov r1, #0x78
	add r0, r4, #0x300
	strh r1, [r0, #0xca]
	ldr r1, [r4, #0x374]
	mov r0, r4
	ldr r1, [r1, #0x374]
	add r1, r1, #0xa00
	ldrh r1, [r1, #0xd6]
	bl Boss3DimInk__Action_2167B48
	ldr r0, =Boss3DimInk__StateInk_2167DE8
	str r0, [r4, #0x378]
	add sp, sp, #0x70
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void Boss3DimInk__StateInk_2167DE8(Boss3DimInk *work)
{
    if (work->field_3CA != 0)
        work->field_3CA--;
    else
        work->stateInk = Boss3DimInk__StateInk_2167E0C;
}

void Boss3DimInk__StateInk_2167E0C(Boss3DimInk *work)
{
    work->stateInk = Boss3DimInk__StateInk_2167E1C;
}

void Boss3DimInk__StateInk_2167E1C(Boss3DimInk *work)
{
    Boss3DimInk__Action_2167B08(work);

    if (work->field_3CC < FLOAT_TO_FX32(1.0))
    {
        work->field_3CC += FLOAT_TO_FX32(1.0 / 32.0);
    }
    else
    {
        work->field_3C8                = 2;
        work->stage->smoke->stateSmoke = Boss3InkSmoke__StateSmoke_216821C;
        work->stateInk                 = Boss3DimInk__StateInk_2167E74;
    }

    Boss3DimInk__Action_2167BBC(work->field_3CC);
}

void Boss3DimInk__StateInk_2167E74(Boss3DimInk *work)
{
    work->field_3CA = 1000;
    work->stateInk  = Boss3DimInk__StateInk_2167E90;
}

void Boss3DimInk__StateInk_2167E90(Boss3DimInk *work)
{
    Boss3DimInk__Action_2167B08(work);

    if (work->field_3CC > FLOAT_TO_FX32(0.5))
        work->field_3CC -= FLOAT_TO_FX32(0.015625);

    Boss3DimInk__Action_2167BBC(work->field_3CC);

    if (work->field_3CA != 0)
        work->field_3CA--;

    if (work->field_3CA == 0)
        work->stateInk = Boss3DimInk__StateInk_2167EE4;
}

void Boss3DimInk__StateInk_2167EE4(Boss3DimInk *work)
{
    work->field_3CA = 120;

    if (work->stage->smoke)
        work->stage->smoke->stateSmoke = Boss3InkSmoke__StateSmoke_216821C;

    work->stateInk = Boss3DimInk__StateInk_2167F18;
}

void Boss3DimInk__StateInk_2167F18(Boss3DimInk *work)
{
    Boss3DimInk__Action_2167B08(work);

    if (work->field_3CC > FLOAT_TO_FX32(0.0))
        work->field_3CC -= FLOAT_TO_FX32(0.0078125);
    else
        work->field_3CC = FLOAT_TO_FX32(0.0);

    Boss3DimInk__Action_2167BBC(work->field_3CC);

    if (work->field_3CA != 0)
        work->field_3CA--;

    if (work->field_3CA == 0)
    {
        DestroyStageTask(&work->gameWork.objWork);
        work->stage->dimInk = NULL;
    }
}

void Boss3InkSmoke__State_2167F80(Boss3InkSmoke *work)
{
    MTX_RotY33(work->mtx.nnMtx, SinFX(work->angle), CosFX(work->angle));

    if (work->stateSmoke)
        work->stateSmoke(work);
}

void Boss3InkSmoke__Destructor(Task *task)
{
    Boss3InkSmoke *work = TaskGetWork(task, Boss3InkSmoke);

    work->stage->smoke = NULL;

    for (s32 i = 0; i < 3; i++)
    {
        AnimatorSprite3D__Release(&work->aniSprite[i]);
    }

    StageTask_Destructor(task);
}

void Boss3InkSmoke__Draw(void)
{
    Boss3InkSmoke *work = TaskGetWorkCurrent(Boss3InkSmoke);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        AnimatorSprite3D *aniSprite;
        s32 i;
        VecFx32 offset1;
        VecFx32 offset2;
        FXMatrix33 mtx;

        for (i = 0; i < 6; i++)
        {
            offset1 = _0217A928[i];

            aniSprite = &work->aniSprite[i % 3];

            aniSprite->work.translation   = work->gameWork.objWork.position;
            aniSprite->work.translation.y = -aniSprite->work.translation.y;

            VEC_Add(&aniSprite->work.translation, &offset1, &aniSprite->work.translation);
            MTX_MultVec33(&aniSprite->work.translation, work->mtx.nnMtx, &aniSprite->work.translation);
            aniSprite->polygonAttr.alpha = FX32_TO_WHOLE(work->field_3A4);
            AnimatorSprite3D__Draw(aniSprite);
        }

        for (i = 0; i < 6; i++)
        {
            offset2 = _0217A928[i];

            aniSprite = &work->aniSprite[i % 3];

            aniSprite->work.translation   = work->gameWork.objWork.position;
            aniSprite->work.translation.y = -aniSprite->work.translation.y;
            aniSprite->work.translation.y += FLOAT_TO_FX32(60.0);

            VEC_Add(&aniSprite->work.translation, &offset2, &aniSprite->work.translation);
            MTX_Transpose33(work->mtx.nnMtx, mtx.nnMtx);
            MTX_MultVec33(&aniSprite->work.translation, mtx.nnMtx, &aniSprite->work.translation);
            aniSprite->polygonAttr.alpha = FX32_TO_WHOLE(work->field_3A4);
            AnimatorSprite3D__Draw(aniSprite);
        }
    }
}

void Boss3InkSmoke__StateSmoke_21681A8(Boss3InkSmoke *work)
{
    for (s32 i = 0; i < 3; i++)
    {
        work->aniSprite[i].polygonAttr.alpha = GX_COLOR_FROM_888(0x8);
    }
    work->field_3A4 = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0x8));

    work->stateSmoke = Boss3InkSmoke__StateSmoke_21681EC;
}

void Boss3InkSmoke__StateSmoke_21681EC(Boss3InkSmoke *work)
{
    work->angle += work->field_3A2;

    work->field_3A4 += FLOAT_TO_FX32(0.25); // RGBA8888 -> 0x2
    if (work->field_3A4 > FX32_FROM_WHOLE(GX_COLOR_FROM_888(0xFF)))
        work->field_3A4 = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0xFF));
}

void Boss3InkSmoke__StateSmoke_216821C(Boss3InkSmoke *work)
{
    work->stateSmoke = Boss3InkSmoke__StateSmoke_216822C;
}

void Boss3InkSmoke__StateSmoke_216822C(Boss3InkSmoke *work)
{
    work->field_3A4 -= FX32_FROM_WHOLE(GX_COLOR_FROM_888(0x8));

    if (work->field_3A4 <= 0)
    {
        work->field_3A4 = FX32_FROM_WHOLE(GX_COLOR_FROM_888(0x0));
        DestroyStageTask(&work->gameWork.objWork);
        work->stage->smoke = NULL;
    }
}

void Boss3ScreenSplatInk__State_2168260(Boss3ScreenSplatInk *work)
{
    FXMatrix43 mtx;

    Camera3D *config = BossArena__GetCameraConfig2(BossArena__GetCamera(2));

    work->stage->field_420 = TRUE;
    Unknown2066510__LookAt(&config->view.camPos, &config->view.camTarget, &config->view.camUp, &mtx);

    work->gameWork.objWork.position   = mtx.translation;
    work->gameWork.objWork.position.y = -work->gameWork.objWork.position.y;

    work->mtxRotation = mtx.mtx33;

    if (work->stateInk)
        work->stateInk(work);
}

void Boss3ScreenSplatInk__Destructor(Task *task)
{
    Boss3ScreenSplatInk *work = TaskGetWork(task, Boss3ScreenSplatInk);

    work->stage->field_420 = FALSE;
    AnimatorMDL__Release(&work->aniInk);

    GameObject__Destructor(task);
}

void Boss3ScreenSplatInk__Draw(void)
{
    Boss3ScreenSplatInk *work = TaskGetWorkCurrent(Boss3ScreenSplatInk);

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0)
    {
        work->aniInk.work.rotation = work->mtxRotation;

        work->aniInk.work.translation   = work->gameWork.objWork.position;
        work->aniInk.work.translation.y = -work->aniInk.work.translation.y;

        if (work->alpha > 0)
            NNS_G3dGlbPolygonAttr(GX_LIGHTID_0, GX_POLYGONMODE_SHADOW, GX_CULL_NONE, 0, work->alpha, GX_POLYGON_ATTR_MISC_NONE);
        else
            NNS_G3dGlbPolygonAttr(GX_LIGHTID_0, GX_POLYGONMODE_SHADOW, GX_CULL_NONE, 0, GX_COLOR_FROM_888(0x8), GX_POLYGON_ATTR_MISC_NONE);

        NNS_G3dMdlUseGlbAlpha(work->aniInk.renderObj.resMdl);
        AnimatorMDL__ProcessAnimation(&work->aniInk);
        AnimatorMDL__Draw(&work->aniInk);
    }
}

void Boss3ScreenSplatInk__StateInk_21683F0(Boss3ScreenSplatInk *work)
{
    work->alpha       = GX_COLOR_FROM_888(0xFF);
    work->scrubAmount = FLOAT_TO_FX32(0.0);
    work->stateInk    = Boss3ScreenSplatInk__StateInk_2168414;
}

void Boss3ScreenSplatInk__StateInk_2168414(Boss3ScreenSplatInk *work)
{
    fx32 curScrubAmount;

    if (IsTouchInputEnabled() && TouchInput__IsTouchOn(&touchInput))
    {
        u16 deltaX = MATH_ABS(touchInput.prev.x - touchInput.on.x);
        u16 deltaY = MATH_ABS(touchInput.prev.y - touchInput.on.y);

        curScrubAmount = FX_Sqrt(FX32_FROM_WHOLE(MT_SQUARED(deltaX) + MT_SQUARED(deltaY)));
        if (curScrubAmount > 0)
            work->scrubAmount += curScrubAmount;
    }

    if (work->scrubAmount >= FLOAT_TO_FX32(256.0) && work->alpha != 0)
    {
        work->alpha -= GX_COLOR_FROM_888(0x10);
        if (work->alpha < 0)
            work->alpha = 0;

        work->scrubAmount -= FLOAT_TO_FX32(256.0);
    }

    if (work->alpha == 0)
        DestroyStageTask(&work->gameWork.objWork);
}

void Boss3ScreenSplatInk__StateInk_21684EC(Boss3ScreenSplatInk *work)
{
    work->stateInk = Boss3ScreenSplatInk__StateInk_21684FC;
}

void Boss3ScreenSplatInk__StateInk_21684FC(Boss3ScreenSplatInk *work)
{
    if (work->alpha != 0)
        work->alpha--;
    else
        DestroyStageTask(&work->gameWork.objWork);
}

NONMATCH_FUNC void Boss3Arm__State_2168520(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x30
	mov r5, r0
	ldr r1, [r5, #0x374]
	mov r0, #0
	ldr r4, [r1, #0x374]
	add r1, r5, #0x400
	str r0, [r5, #0x44]
	ldr r0, [r5, #0x470]
	ldr r3, =FX_SinCosTable_
	str r0, [r5, #0x48]
	ldr r2, [r5, #0x46c]
	add r0, sp, #0
	str r2, [r5, #0x4c]
	ldrh r1, [r1, #0x44]
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotY43_
	add r0, r5, #0x48
	add lr, sp, #0
	add ip, r0, #0x400
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldr r1, [lr]
	add r0, r5, #0x44
	str r1, [ip]
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec43
	ldr r2, [r5, #0x44]
	ldr r1, [r4, #0xb30]
	mov r0, r5
	add r1, r2, r1
	str r1, [r5, #0x44]
	ldr r1, [r5, #0x374]
	ldr r2, [r5, #0x48]
	ldr r1, [r1, #0x3c4]
	add r1, r2, r1
	str r1, [r5, #0x48]
	ldr r1, [r4, #0xb38]
	ldr r2, [r5, #0x4c]
	add r1, r2, r1
	str r1, [r5, #0x4c]
	ldr r1, [r5, #0x378]
	blx r1
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Destructor(Task *task)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	add r0, r0, #0xcc
	add r0, r0, #0x400
	bl AnimatorMDL__Release
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Draw(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	ldmneia sp!, {r3, r4, r5, pc}
	add r0, r4, #0x48
	add ip, r0, #0x400
	add r5, r4, #0x4f0
	ldmia ip!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia ip!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldr r1, [ip]
	add r0, r4, #0x114
	str r1, [r5]
	add r1, r4, #0x44
	add r3, r0, #0x400
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x518]
	rsb r0, r0, #0
	str r0, [r4, #0x518]
	ldr r0, [r4, #0x374]
	bl Boss3Stage__Func_2162918
	add r5, r4, #0xcc
	add r0, r5, #0x400
	bl AnimatorMDL__ProcessAnimation
	bl SwapBuffer3D_GetPrimaryScreen
	cmp r0, #0
	bne _021686CC
	ldr r0, [r4, #0x374]
	ldr r1, [r0, #0x374]
	ldr r0, [r1, #0xa50]
	cmp r0, #0
	bne _021686CC
	ldr r0, [r1, #0xa4c]
	cmp r0, #0xe
	beq _021686CC
	ldr r0, [r5, #0x494]
	mov r1, #1
	bl NNS_G3dMdlSetMdlDepthTestCondAll
	b _021686D8
_021686CC:
	ldr r0, [r5, #0x494]
	mov r1, #0
	bl NNS_G3dMdlSetMdlDepthTestCondAll
_021686D8:
	add r0, r5, #0x400
	bl AnimatorMDL__Draw
	ldr r0, [r4, #0x374]
	add r0, r0, #0x24
	add r0, r0, #0x400
	bl BossHelpers__ApplyModifiedLights
	add r0, r4, #0x9c
	add r1, r0, #0x400
	mov r0, #0x1d
	bl BossHelpers__Model__SetMatrixMode
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Collide(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	bl GetCurrentTaskWork_
	mov r7, r0
	ldr r0, [r7, #0x18]
	tst r0, #0xc
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	tst r0, #2
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r7, #0x400
	ldrh r1, [r0, #0x76]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x76]
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r6, =0x006BAA99
	ldr r5, =0x00107FC0
	ldr r4, =gPlayer
	add r9, r7, #0x218
	add r10, r7, #0x384
	mov r8, #0
	mov r11, #0x40000
_02168768:
	ldr r0, [r9, #0x18]
	tst r0, #4
	beq _021687C0
	ldr r0, [r4, #0]
	add r0, r0, #0x500
	ldrsh r0, [r0, #0xd4]
	sub r0, r0, #0xe
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _021687A4
	cmp r8, #0
	beq _021687C0
_021687A4:
	str r6, [sp]
	mov r0, r9
	mov r1, r10
	mov r3, r11
	add r2, r7, #0x4c0
	str r5, [sp, #4]
	bl BossHelpers__Collision__HandleArenaCollider
_021687C0:
	add r8, r8, #1
	cmp r8, #3
	add r9, r9, #0x40
	add r10, r10, #0x40
	blt _02168768
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__OnDefend_Regular(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	ldr r0, [r0, #0x374]
	bl Boss3__Action_Hit
	ldr r0, [r4, #0x374]
	mov r1, #0
	ldr r0, [r0, #0x374]
	bl Boss3__Func_2163AF0
	mov r0, r4
	mov r1, #3
	bl Boss3Arm__Func_2168F84
	add r0, r5, #0x1b0
	bl Boss3Stage__CreateHitFX
	mov r0, r4
	bl Boss3Arm__PlayHitSfx
	mov r0, r5
	bl Boss3Stage__Action_PlayerRebound
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_2168850(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	ldr r0, [r0, #0x374]
	bl Boss3__Action_Hit
	ldr r0, [r4, #0x374]
	mov r1, #0
	ldr r0, [r0, #0x374]
	bl Boss3__Func_2163AF0
	ldr r0, [r4, #0x374]
	mov r1, #3
	ldr r0, [r0, #0x374]
	bl Boss3__Action_DecideNextAction
	add r0, r5, #0x1b0
	bl Boss3Stage__CreateHitFX
	mov r0, r4
	bl Boss3Arm__PlayHitSfx
	mov r0, r5
	bl Boss3Stage__Func_2161E90
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_21688BC(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	ldr r0, [r0, #0x374]
	bl Boss3__Action_Hit
	ldr r0, [r4, #0x374]
	mov r1, #0
	ldr r0, [r0, #0x374]
	bl Boss3__Func_2163AF0
	mov r0, r4
	mov r1, #9
	bl Boss3Arm__Func_2168F84
	add r0, r5, #0x1b0
	bl Boss3Stage__CreateHitFX
	mov r0, r4
	bl Boss3Arm__PlayHitSfx
	mov r0, r5
	bl Boss3Stage__Action_PlayerRebound
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_2168924(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	ldr r0, [r0, #0x374]
	bl Boss3__Action_Hit
	ldr r0, [r4, #0x374]
	mov r1, #0
	ldr r0, [r0, #0x374]
	bl Boss3__Func_2163AF0
	mov r0, r4
	mov r1, #0xd
	bl Boss3Arm__Func_2168F84
	add r0, r5, #0x1b0
	bl Boss3Stage__CreateHitFX
	mov r0, r4
	bl Boss3Arm__PlayHitSfx
	mov r0, r5
	bl Boss3Stage__Action_PlayerRebound
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_216898C(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	mov r1, #0
	ldr r0, [r0, #0x374]
	str r1, [r0, #0xaf4]
	ldr r0, [r4, #0x374]
	ldr r0, [r0, #0x374]
	bl Boss3__Action_Hit
	ldr r0, [r4, #0x374]
	mov r1, #0
	ldr r0, [r0, #0x374]
	bl Boss3__Func_2163AF0
	mov r0, r4
	mov r1, #0x12
	bl Boss3Arm__Func_2168F84
	add r0, r5, #0x1b0
	bl Boss3Stage__CreateHitFX
	mov r0, r4
	bl Boss3Arm__PlayHitSfx
	mov r0, r5
	bl Boss3Stage__Func_2161EE0
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_2168A04(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	mov r1, #0
	add r0, r0, #0x300
	strh r1, [r0, #0xb8]
	ldr r0, [r4, #0x374]
	add r0, r0, #0x300
	ldrsh r0, [r0, #0xb8]
	bl UpdateBossHealthHUD
	ldr r0, [r4, #0x374]
	ldr r2, =Boss3__StateBoss_2166D60
	ldr r1, [r0, #0x374]
	mov r0, r5
	str r2, [r1, #0xa40]
	bl Boss3Stage__Action_PlayerRebound
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_2168A68(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	ldr r0, [r0, #0x374]
	bl Boss3__Action_Hit
	ldr r0, [r4, #0x374]
	mov r1, #0
	ldr r0, [r0, #0x374]
	bl Boss3__Func_2163AF0
	add r0, r5, #0x1b0
	bl Boss3Stage__CreateHitFX
	mov r0, r4
	bl Boss3Arm__PlayHitSfx
	mov r0, r5
	bl Boss3Stage__Action_PlayerRebound
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__OnDefend_Weakpoint(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5, #0]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	mov r1, #1
	ldr r0, [r0, #0x374]
	bl Boss3__Func_2163AF0
	mov r0, r4
	mov r1, #4
	bl Boss3Arm__Func_2168F84
	add r0, r5, #0x1b0
	bl Boss3Stage__Func_2162018
	mov r0, #0
	str r0, [sp]
	mov r0, #0xcf
	str r0, [sp, #4]
	sub r1, r0, #0xd0
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	mov r0, r5
	bl Boss3Stage__Action_PlayerRebound
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_2168B4C(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5, #0]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	mov r1, #1
	ldr r0, [r0, #0x374]
	bl Boss3__Func_2163AF0
	ldr r1, =Boss3Arm__StateArm_2169F14
	add r0, r5, #0x1b0
	str r1, [r4, #0x378]
	bl Boss3Stage__Func_2162018
	mov r2, #0
	mov r0, #0xcf
	sub r1, r0, #0xd0
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	mov r0, r5
	bl Boss3Stage__Func_2161E90
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_2168BD4(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5, #0]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	mov r1, #1
	ldr r0, [r0, #0x374]
	bl Boss3__Func_2163AF0
	ldr r0, [r4, #0x374]
	mov r1, #5
	ldr r0, [r0, #0x374]
	bl Boss3__Action_DecideNextAction
	add r0, r5, #0x1b0
	bl Boss3Stage__Func_2162018
	mov r0, #0
	str r0, [sp]
	mov r0, #0xcf
	str r0, [sp, #4]
	sub r1, r0, #0xd0
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	mov r0, r5
	bl Boss3Stage__Action_PlayerRebound
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_2168C60(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5, #0]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	mov r1, #1
	ldr r0, [r0, #0x374]
	bl Boss3__Func_2163AF0
	mov r0, r4
	mov r1, #0xe
	bl Boss3Arm__Func_2168F84
	add r0, r5, #0x1b0
	bl Boss3Stage__Func_2162018
	mov r0, #0
	str r0, [sp]
	mov r0, #0xcf
	str r0, [sp, #4]
	sub r1, r0, #0xd0
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	mov r0, r5
	bl Boss3Stage__Action_PlayerRebound
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_2168CE8(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r5, [r0, #0x1c]
	ldr r4, [r1, #0x1c]
	ldrh r0, [r5, #0]
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x374]
	mov r1, #1
	ldr r0, [r0, #0x374]
	bl Boss3__Func_2163AF0
	mov r0, r4
	bl Boss3Arm__Action_216B2C8
	add r0, r5, #0x1b0
	bl Boss3Stage__Func_2162018
	mov r0, #0
	str r0, [sp]
	mov r0, #0xcf
	str r0, [sp, #4]
	sub r1, r0, #0xd0
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	mov r0, r5
	bl Boss3Stage__Func_2161EE0
	add r0, r4, #0x400
	mov r1, #4
	strh r1, [r0, #0x76]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__OnDefend_2168D6C(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, [r0, #0x1c]
	ldrh r3, [r2, #0]
	cmp r3, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r3, [r2, #0x1c]
	ldr r4, [r1, #0xc]
	tst r3, #0x8000
	ldr r3, [r1, #0x1c]
	ldr ip, [r2, #0x44]
	ldr lr, [r3, #0x44]
	ldr r3, [r0, #0xc]
	ldrne r5, [r2, #0x98]
	add r4, lr, r4, lsl #12
	add ip, ip, r3, lsl #12
	ldreq r5, [r2, #0xc8]
	cmp r4, ip
	bge _02168DF4
	cmp r5, #0
	ldmgtia sp!, {r3, r4, r5, pc}
	ldrsh r3, [r1, #6]
	ldrsh r1, [r0, #0]
	mov r0, #0
	add r3, r4, r3, lsl #12
	sub r1, r3, r1, lsl #12
	sub r1, r1, ip
	str r1, [r2, #0xb0]
	ldr r1, [r2, #0x1c]
	orr r1, r1, #4
	str r1, [r2, #0x1c]
	str r0, [r2, #0x98]
	str r0, [r2, #0xa0]
	str r0, [r2, #0xc8]
	ldmia sp!, {r3, r4, r5, pc}
_02168DF4:
	cmp r5, #0
	ldmltia sp!, {r3, r4, r5, pc}
	ldrsh r3, [r1, #0]
	ldrsh r1, [r0, #6]
	mov r0, #0
	add r3, r4, r3, lsl #12
	sub r1, r3, r1, lsl #12
	sub r1, r1, ip
	str r1, [r2, #0xb0]
	ldr r1, [r2, #0x1c]
	orr r1, r1, #4
	str r1, [r2, #0x1c]
	str r0, [r2, #0x98]
	str r0, [r2, #0xa0]
	str r0, [r2, #0xc8]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_2168E34(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r2, [r0, #0x1c]
	ldrh r3, [r2, #0]
	cmp r3, #1
	ldmneia sp!, {r4, pc}
	ldr r3, [r1, #0x1c]
	ldr r4, [r1, #0xc]
	ldr lr, [r3, #0x44]
	ldr ip, [r2, #0x44]
	ldr r3, [r0, #0xc]
	add r4, lr, r4, lsl #12
	add ip, ip, r3, lsl #12
	cmp r4, ip
	bge _02168EA4
	ldrsh r3, [r1, #6]
	ldrsh r1, [r0, #0]
	mov r0, #0
	add r3, r4, r3, lsl #12
	sub r1, r3, r1, lsl #12
	sub r1, r1, ip
	str r1, [r2, #0xb0]
	ldr r1, [r2, #0x1c]
	orr r1, r1, #4
	str r1, [r2, #0x1c]
	str r0, [r2, #0x98]
	str r0, [r2, #0xa0]
	str r0, [r2, #0xc8]
	ldmia sp!, {r4, pc}
_02168EA4:
	ldrsh r3, [r1, #0]
	ldrsh r1, [r0, #6]
	mov r0, #0
	add r3, r4, r3, lsl #12
	sub r1, r3, r1, lsl #12
	sub r1, r1, ip
	str r1, [r2, #0xb0]
	ldr r1, [r2, #0x1c]
	orr r1, r1, #4
	str r1, [r2, #0x1c]
	str r0, [r2, #0x98]
	str r0, [r2, #0xa0]
	str r0, [r2, #0xc8]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_2168EDC(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr ip, [r0, #0x1c]
	ldr lr, [r1, #0x1c]
	ldrh r0, [ip]
	cmp r0, #1
	ldmneia sp!, {r3, pc}
	ldr r1, [r1, #0xc]
	ldr r0, [lr, #0x44]
	ldr r3, [lr, #0x4c4]
	ldr r2, [ip, #0x44]
	add r0, r0, r1, lsl #12
	sub r0, r2, r0
	str r0, [lr, #0x48c]
	ldr r0, [ip, #0x48]
	rsb r1, r3, #0
	sub r0, r0, r1
	str r0, [lr, #0x490]
	mov r0, #1
	str r0, [lr, #0x488]
	str ip, [lr, #0x480]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_2168F30(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r2, #0xc
	mul ip, r1, r2
	ldr r3, =_0217A858
	mov lr, #0
_02168F44:
	ldr r1, [r0, #0x380]
	ldr r1, [r3, r1, lsl #2]
	add r1, ip, r1
	ldr r2, [r1, lr, lsl #2]
	cmp r2, #0
	addne r1, r0, lr, lsl #6
	strne r2, [r1, #0x23c]
	add r2, r0, lr, lsl #6
	ldr r1, [r2, #0x230]
	add lr, lr, #1
	bic r1, r1, #0x300
	str r1, [r2, #0x230]
	cmp lr, #3
	blt _02168F44
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_2168F84(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	str r1, [r0, #0x37c]
	cmp r1, #0x16
	addls pc, pc, r1, lsl #2
	b _02169104
_02168F98: // jump table
	b _02168FF4 // case 0
	b _02169000 // case 1
	b _0216900C // case 2
	b _02169018 // case 3
	b _02169024 // case 4
	b _02169030 // case 5
	b _0216903C // case 6
	b _02169048 // case 7
	b _02169054 // case 8
	b _02169060 // case 9
	b _0216906C // case 10
	b _02169078 // case 11
	b _02169084 // case 12
	b _02169090 // case 13
	b _0216909C // case 14
	b _021690A8 // case 15
	b _021690B4 // case 16
	b _021690C0 // case 17
	b _021690CC // case 18
	b _021690D8 // case 19
	b _021690E4 // case 20
	b _021690F0 // case 21
	b _021690FC // case 22
_02168FF4:
	ldr r1, =Boss3Arm__StateArm_2169194
	str r1, [r0, #0x378]
	b _02169104
_02169000:
	ldr r1, =Boss3Arm__StateArm_216937C
	str r1, [r0, #0x378]
	b _02169104
_0216900C:
	ldr r1, =Boss3Arm__StateArm_2169900
	str r1, [r0, #0x378]
	b _02169104
_02169018:
	ldr r1, =Boss3Arm__StateArm_2169B3C
	str r1, [r0, #0x378]
	b _02169104
_02169024:
	ldr r1, =Boss3Arm__StateArm_2169A5C
	str r1, [r0, #0x378]
	b _02169104
_02169030:
	ldr r1, =Boss3Arm__StateArm_2169C18
	str r1, [r0, #0x378]
	b _02169104
_0216903C:
	ldr r1, =Boss3Arm__StateArm_2169FE4
	str r1, [r0, #0x378]
	b _02169104
_02169048:
	ldr r1, =Boss3Arm__StateArm_216A178
	str r1, [r0, #0x378]
	b _02169104
_02169054:
	ldr r1, =Boss3Arm__StateArm_216A210
	str r1, [r0, #0x378]
	b _02169104
_02169060:
	ldr r1, =Boss3Arm__StateArm_216AAE0
	str r1, [r0, #0x378]
	b _02169104
_0216906C:
	ldr r1, =Boss3Arm__StateArm_216A9C8
	str r1, [r0, #0x378]
	b _02169104
_02169078:
	ldr r1, =Boss3Arm__StateArm_216ABD0
	str r1, [r0, #0x378]
	b _02169104
_02169084:
	ldr r1, =Boss3Arm__StateArm_216AD50
	str r1, [r0, #0x378]
	b _02169104
_02169090:
	ldr r1, =Boss3Arm__StateArm_216AF54
	str r1, [r0, #0x378]
	b _02169104
_0216909C:
	ldr r1, =Boss3Arm__StateArm_216AE88
	str r1, [r0, #0x378]
	b _02169104
_021690A8:
	ldr r1, =Boss3Arm__StateArm_2169194
	str r1, [r0, #0x378]
	b _02169104
_021690B4:
	ldr r1, =Boss3Arm__StateArm_216937C
	str r1, [r0, #0x378]
	b _02169104
_021690C0:
	ldr r1, =Boss3Arm__StateArm_216B054
	str r1, [r0, #0x378]
	b _02169104
_021690CC:
	ldr r1, =Boss3Arm__StateArm_216B34C
	str r1, [r0, #0x378]
	b _02169104
_021690D8:
	ldr r1, =Boss3Arm__StateArm_216B3F0
	str r1, [r0, #0x378]
	b _02169104
_021690E4:
	ldr r1, =Boss3Arm__StateArm_216B410
	str r1, [r0, #0x378]
	b _02169104
_021690F0:
	ldr r1, =Boss3Arm__StateArm_216B430
	str r1, [r0, #0x378]
	b _02169104
_021690FC:
	ldr r1, =Boss3Arm__StateArm_216B548
	str r1, [r0, #0x378]
_02169104:
	ldr r1, [r0, #0x378]
	blx r1
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Stage__Func_2169164(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, #0
_02169174:
	add r0, r6, r4, lsl #2
	ldr r0, [r0, #0x398]
	mov r1, r5
	bl Boss3Arm__Func_2168F84
	add r4, r4, #1
	cmp r4, #4
	blt _02169174
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169194(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r3, #1
	mov r4, r0
	str r3, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	bl BossHelpers__SetAnimation
	ldr r0, [r4, #0x20]
	mov r2, #0x78000
	orr r0, r0, #0x20
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x230]
	mov r1, #0x32000
	bic r0, r0, #4
	str r0, [r4, #0x230]
	ldr r3, [r4, #0x270]
	ldr r0, =Boss3Arm__StateArm_2169214
	bic r3, r3, #4
	str r3, [r4, #0x270]
	ldr r3, [r4, #0x2b0]
	bic r3, r3, #4
	str r3, [r4, #0x2b0]
	str r2, [r4, #0x46c]
	str r1, [r4, #0x470]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void Boss3Arm__StateArm_2169214(Boss3Arm *work)
{
    // Do nothing
}

NONMATCH_FUNC void Boss3Arm__Func_2169218(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r2, [r0, #0x374]
	mov ip, r1, lsl #0x10
	ldr r0, [r0, #0x380]
	ldr r1, =0x00000AAA
	mov r4, #0
_02169230:
	add r3, r2, r4, lsl #2
	ldr lr, [r3, #0x398]
	ldr r3, [lr, #0x380]
	cmp r0, r3
	beq _02169278
	ldr r3, [lr, #0x37c]
	sub r3, r3, #2
	cmp r3, #2
	bhi _02169278
	add r3, lr, #0x400
	ldrsh r3, [r3, #0x44]
	sub r3, r3, ip, asr #16
	mov r3, r3, lsl #0x10
	movs r3, r3, asr #0x10
	rsbmi r3, r3, #0
	cmp r3, r1
	movlt r0, #0
	ldmltia sp!, {r4, pc}
_02169278:
	add r4, r4, #1
	cmp r4, #4
	blt _02169230
	mov r0, #1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_2169290(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #4
	mov r9, #0x8000
	mov r10, r0
	rsb r9, r9, #0
	mov r4, r1, lsl #0x10
	mov r7, #0
_021692AC:
	ldr r0, [r10, #0x374]
	ldr r1, [r10, #0x380]
	add r0, r0, r7, lsl #2
	ldr r2, [r0, #0x398]
	ldr r0, [r2, #0x380]
	cmp r1, r0
	beq _0216935C
	ldr r0, [r2, #0x37c]
	sub r0, r0, #2
	cmp r0, #2
	bhi _0216935C
	add r0, r2, #0x400
	ldrsh r0, [r0, #0x44]
	mov r8, #0
	add r5, sp, #0
	add r1, r0, #0xb60
	sub r0, r0, #0xb60
	strh r1, [sp]
	strh r0, [sp, #2]
_021692F8:
	mov r0, r8, lsl #1
	ldrh r1, [r5, r0]
	mov r0, r10
	mov r2, r1, lsl #0x10
	mov r2, r2, asr #0x10
	sub r2, r2, r4, asr #16
	mov r2, r2, lsl #0x10
	mov r6, r2, asr #0x10
	bl Boss3Arm__Func_2169218
	cmp r0, #0
	beq _02169350
	cmp r9, #0
	rsblt r2, r9, #0
	movge r2, r9
	cmp r6, #0
	rsblt r0, r6, #0
	movge r0, r6
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r2, lsl #0x10
	cmp r1, r0, lsr #16
	movlo r9, r6
_02169350:
	add r8, r8, #1
	cmp r8, #2
	blt _021692F8
_0216935C:
	add r7, r7, #1
	cmp r7, #4
	blt _021692AC
	cmp r9, #0x8000
	moveq r9, #0
	mov r0, r9
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216937C(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #3
	bl BossHelpers__SetAnimation
	ldr r0, [r4, #0x20]
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	ldr r2, [r4, #0x374]
	ldr r0, [r2, #0x374]
	ldr r0, [r0, #0xa50]
	cmp r0, #0
	bne _021693FC
	mov r1, #0
	mov r0, #0x9f
	str r1, [sp]
	sub r1, r0, #0xa0
	str r0, [sp, #4]
	ldr r0, [r2, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl Boss3Stage__ProcessSpatialAudio
_021693FC:
	mov r0, r4
	mov r1, #1
	bl Boss3Arm__Func_2168F30
	ldr r0, =gPlayer
	ldr r2, =0x006BAA99
	ldr r0, [r0, #0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__GetAngle
	add r1, r4, #0x400
	strh r0, [r1, #0x44]
	ldr r2, [r4, #0x374]
	ldr r0, [r4, #0x380]
	ldr r2, [r2, #0x374]
	ldrh r3, [r1, #0x44]
	add r0, r2, r0, lsl #2
	ldr r0, [r0, #0xaf0]
	mov r2, #0
	add r0, r3, r0
	strh r0, [r1, #0x44]
	str r2, [r4, #0x478]
	strh r2, [r1, #0x7c]
	strh r2, [r1, #0x7e]
	ldr r0, =Boss3Arm__StateArm_2169478
	strh r2, [r1, #0x80]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169478(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldrne r1, =Boss3Arm__StateArm_2169494
	strne r1, [r0, #0x378]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169494(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #4
	bl BossHelpers__SetAnimation
	ldr r0, =Boss3Arm__StateArm_21694D8
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_21694D8(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =Boss3Arm__StateArm_21694E8
	str r1, [r0, #0x378]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_21694E8(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #4
	bl BossHelpers__SetAnimation
	add r0, r4, #0x400
	mov r1, #0
	strh r1, [r0, #0x46]
	mov r2, #0x78
	ldr r1, =Boss3Arm__StateArm_2169540
	strh r2, [r0, #0x80]
	str r1, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169540(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r6, r0
	ldr r2, [r6, #0x374]
	ldr r0, [r6, #0x380]
	ldr r1, [r2, #0x374]
	ldr r1, [r1, #0xae0]
	cmp r1, r0
	bne _02169668
	ldr r0, =gPlayer
	ldr r2, =0x006BAA99
	ldr r0, [r0, #0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__GetAngle
	ldr r1, =gPlayer
	mov r4, r0
	ldr r1, [r1, #0]
	ldr r0, [r1, #0x1c]
	tst r0, #0x8000
	ldrne r5, [r1, #0x98]
	ldr r0, [r6, #0x374]
	ldreq r5, [r1, #0xc8]
	bl Boss3Stage__Func_2162A98
	smull r1, r0, r5, r0
	adds r1, r1, #0x800
	mov r2, r1, lsr #0xc
	adc r0, r0, #0
	orr r2, r2, r0, lsl #20
	ldr r0, =0x0038E000
	mov r1, #0
	umull r5, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r5, r5, #0x800
	adc r0, r3, #0
	mov r1, r5, lsr #0xc
	orr r1, r1, r0, lsl #20
	mov r1, r1, lsl #4
	mov r0, r4, lsl #0x10
	mov r1, r1, asr #0x10
	add r4, r1, r0, asr #16
	mov r1, r4, lsl #0x10
	mov r0, r6
	mov r1, r1, lsr #0x10
	bl Boss3Arm__Func_2169218
	cmp r0, #0
	movne r5, #0
	bne _0216961C
	mov r1, r4, lsl #0x10
	mov r0, r6
	mov r1, r1, lsr #0x10
	bl Boss3Arm__Func_2169290
	mov r5, r0
_0216961C:
	add r0, r6, #0x400
	ldrh r0, [r0, #0x80]
	cmp r0, #0
	bne _02169644
	mov r1, r4, lsl #0x10
	mov r0, r6
	mov r1, r1, lsr #0x10
	bl Boss3Arm__Func_2169218
	cmp r0, #0
	bne _021696AC
_02169644:
	add r0, r6, #0x400
	ldrh r1, [r0, #0x80]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x80]
	add r1, r5, r4
	add r0, r6, #0x400
	strh r1, [r0, #0x7e]
	b _021696AC
_02169668:
	add r0, r2, r1, lsl #2
	ldr r0, [r0, #0x398]
	add r1, r6, #0x400
	add r0, r0, #0x400
	ldrh r4, [r0, #0x7e]
	strh r4, [r1, #0x7e]
	ldr r0, [r6, #0x374]
	ldr r2, [r6, #0x380]
	ldr r3, [r0, #0x374]
	ldr r0, [r3, #0xae0]
	add r2, r3, r2, lsl #2
	add r0, r3, r0, lsl #2
	ldr r2, [r2, #0xaf0]
	ldr r0, [r0, #0xaf0]
	sub r0, r2, r0
	add r0, r4, r0
	strh r0, [r1, #0x7e]
_021696AC:
	add r0, r6, #0x400
	ldrsh r1, [r0, #0x44]
	ldrsh r0, [r0, #0x7e]
	subs r4, r1, r0
	rsbmi r0, r4, #0
	movpl r0, r4
	cmp r0, #0xb6
	movgt r0, #1
	strgt r0, [r6, #0x478]
	ldr r1, [r6, #0x374]
	ldr r0, [r6, #0x380]
	ldr r2, [r1, #0x374]
	ldr r1, [r2, #0xae0]
	cmp r1, r0
	bne _02169720
	cmp r4, #0
	rsblt r0, r4, #0
	movge r0, r4
	cmp r0, #0x16c
	bgt _02169720
	ldr r0, [r2, #0xb00]
	cmp r0, #0
	bne _02169720
	mov r0, #0
	str r0, [r2, #0xb04]
	ldr r0, [r6, #0x374]
	mov r1, #1
	ldr r0, [r0, #0x374]
	str r1, [r0, #0xb00]
_02169720:
	ldr r0, [r6, #0x478]
	cmp r0, #0
	beq _02169740
	add r0, r6, #0x400
	ldrh r1, [r0, #0x7c]
	cmp r1, #0
	addeq r1, r1, #1
	streqh r1, [r0, #0x7c]
_02169740:
	add r2, r6, #0x400
	ldrh r0, [r2, #0x7c]
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	mov r0, #0x22
	str r0, [sp]
	mov r0, #0x280
	str r0, [sp, #4]
	mov r0, #0
	str r0, [sp, #8]
	ldrh r0, [r2, #0x44]
	ldrh r1, [r2, #0x7e]
	ldrsh r2, [r2, #0x46]
	mov r3, #5
	bl BossHelpers__Math__Func_2039360
	add r1, r6, #0x400
	strh r0, [r1, #0x46]
	cmp r4, #0
	rsblt r4, r4, #0
	cmp r4, #0xb6
	ldrh r2, [r1, #0x44]
	ldrsh r0, [r1, #0x46]
	addge sp, sp, #0xc
	add r0, r2, r0
	strh r0, [r1, #0x44]
	ldmgeia sp!, {r3, r4, r5, r6, pc}
	mov r1, #0
	str r1, [r6, #0x478]
	add r0, r6, #0x400
	strh r1, [r0, #0x7c]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_21697D0(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x400
	ldrh r1, [r1, #0x44]
	bl Boss3Arm__Func_2169218
	cmp r0, #0
	ldrne r1, =Boss3Arm__StateArm_2169800
	moveq r0, #0
	movne r0, #1
	strne r1, [r4, #0x378]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169800(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #5
	bl BossHelpers__SetAnimation
	ldr r0, [r4, #0x374]
	ldr r0, [r0, #0x374]
	ldr r0, [r0, #0xa50]
	cmp r0, #1
	moveq r0, #0x800
	movne r0, #0x1000
	str r0, [r4, #0x5e8]
	ldr r1, [r4, #0x270]
	ldr r0, =Boss3Arm__StateArm_2169868
	orr r1, r1, #4
	str r1, [r4, #0x270]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169868(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x46c]
	cmp r0, #0xaa000
	addlt r0, r0, #0x5000
	strlt r0, [r4, #0x46c]
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x374]
	mov r3, #0xa0
	ldr r0, [r0, #0x374]
	sub r1, r3, #0xa1
	add r0, r0, #0xa00
	ldrh lr, [r0, #0xda]
	mov ip, #0
	mov r2, r1
	bic lr, lr, #4
	strh lr, [r0, #0xda]
	str ip, [sp]
	str r3, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl Boss3Stage__ProcessSpatialAudio
	mov r0, r4
	mov r1, #2
	bl Boss3Arm__Func_2168F84
	mov r0, #0x1000
	str r0, [r4, #0x5e8]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169900(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r2, [r0, #0x230]
	ldr r1, =Boss3Arm__StateArm_2169934
	orr r2, r2, #4
	str r2, [r0, #0x230]
	ldr r2, [r0, #0x270]
	bic r2, r2, #4
	str r2, [r0, #0x270]
	ldr r2, [r0, #0x2b0]
	orr r2, r2, #4
	str r2, [r0, #0x2b0]
	str r1, [r0, #0x378]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169934(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #6
	bl BossHelpers__SetAnimation
	ldr r0, =Boss3Arm__StateArm_2169978
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void Boss3Arm__StateArm_2169978(Boss3Arm *work)
{
    // Do nothing
}

NONMATCH_FUNC void Boss3Arm__StateArm_216997C(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #7
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_21699E0
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_21699E0(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r1, r4, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	bl Boss3Arm__Func_2168F84
	ldr r2, [r4, #0x374]
	ldr r0, [r2, #0x374]
	ldr r0, [r0, #0xa50]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	mov r1, #0
	mov r0, #0xa3
	str r1, [sp]
	sub r1, r0, #0xa4
	str r0, [sp, #4]
	ldr r0, [r2, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl Boss3Stage__ProcessSpatialAudio
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169A5C(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #8
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_2169AC0
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169AC0(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r2, [r4, #0x374]
	ldr r0, [r2, #0x374]
	ldr r0, [r0, #0xa50]
	cmp r0, #0
	bne _02169B28
	mov r1, #0
	mov r0, #0xa3
	str r1, [sp]
	sub r1, r0, #0xa4
	str r0, [sp, #4]
	ldr r0, [r2, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl Boss3Stage__ProcessSpatialAudio
_02169B28:
	mov r0, r4
	mov r1, #0
	bl Boss3Arm__Func_2168F84
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169B3C(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r2, r4, #0x500
	ldrh r3, [r2, #0xd8]
	mov r1, #2
	orr r3, r3, #1
	strh r3, [r2, #0xd8]
	ldr r2, [r4, #0x230]
	orr r2, r2, #4
	str r2, [r4, #0x230]
	ldr r2, [r4, #0x270]
	bic r2, r2, #4
	str r2, [r4, #0x270]
	ldr r2, [r4, #0x2b0]
	orr r2, r2, #4
	str r2, [r4, #0x2b0]
	bl Boss3Arm__Func_2168F30
	add r0, r4, #0x400
	mov r2, #0xb4
	ldr r1, =Boss3Arm__StateArm_2169B9C
	strh r2, [r0, #0x74]
	str r1, [r4, #0x378]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169B9C(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x400
	ldrh r1, [r0, #0x74]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x74]
	add r0, r4, #0x400
	ldrh r0, [r0, #0x74]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	mov r1, #4
	bl Boss3Arm__Func_2168F84
	mov r0, r4
	mov r1, #1
	bl Boss3Arm__Func_2168F30
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_2169BE4(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r0, r0, #0x400
	ldrh r2, [r0, #0x44]
	ldrh r1, [r0, #0x78]
	add r1, r2, r1
	strh r1, [r0, #0x44]
	ldrh r1, [r0, #0x78]
	add r1, r1, #5
	strh r1, [r0, #0x78]
	ldrh r2, [r0, #0x7a]
	ldrh r1, [r0, #0x78]
	cmp r1, r2
	strhih r2, [r0, #0x78]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169C18(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #9
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, r4
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	ldr r2, [r4, #0x230]
	mov r1, #3
	bic r2, r2, #4
	str r2, [r4, #0x230]
	ldr r2, [r4, #0x270]
	bic r2, r2, #4
	str r2, [r4, #0x270]
	ldr r2, [r4, #0x2b0]
	orr r2, r2, #4
	str r2, [r4, #0x2b0]
	bl Boss3Arm__Func_2168F30
	ldr r0, =gPlayer
	ldr r2, =0x006BAA99
	ldr r0, [r0, #0]
	mov r1, #0x40000
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__GetAngle
	add r1, r4, #0x400
	strh r0, [r1, #0x44]
	ldrh r3, [r1, #0x44]
	ldr r2, [r4, #0x380]
	ldr r0, =_0217A838
	mov r2, r2, lsl #1
	ldrh r2, [r0, r2]
	mov r0, #0
	add r2, r3, r2
	strh r2, [r1, #0x44]
	strh r0, [r1, #0x78]
	strh r0, [r1, #0x7c]
	ldr r0, [r4, #0x374]
	bl Boss3Stage__Func_2162ACC
	add r1, r4, #0x400
	strh r0, [r1, #0x7a]
	mov r0, #0
	str r0, [sp]
	mov r0, #0x9f
	str r0, [sp, #4]
	sub r1, r0, #0xa0
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x400
	ldrh r1, [r1, #0x44]
	bl Boss3Stage__ProcessSpatialAudio
	ldr r0, =Boss3Arm__StateArm_2169D30
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169D30(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldrne r1, =Boss3Arm__StateArm_2169D4C
	strne r1, [r0, #0x378]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169D4C(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xa
	bl BossHelpers__SetAnimation
	add r0, r4, #0x400
	mov r1, #0
	strh r1, [r0, #0x78]
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_2169DC0
	orr r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	orr r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169DC0(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =Boss3Arm__Func_2169BE4
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169DCC(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =Boss3Arm__StateArm_2169DDC
	str r1, [r0, #0x378]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169DDC(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0x400
	ldrh r3, [r1, #0x44]
	ldrh r2, [r1, #0x78]
	add r2, r3, r2
	strh r2, [r1, #0x44]
	ldrsh r2, [r1, #0x78]
	sub r2, r2, #5
	mov r2, r2, lsl #0x10
	movs r2, r2, asr #0x10
	ldrmi r1, =Boss3Arm__StateArm_2169E14
	strmi r1, [r0, #0x378]
	strplh r2, [r1, #0x78]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169E14(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xb
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_2169E78
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	orr r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169E78(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	bne _02169EA4
	ldr r0, [r4, #0x20]
	tst r0, #0x20
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
_02169EA4:
	ldr r1, [r4, #0x230]
	mov r0, #0xa3
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r2, [r4, #0x270]
	sub r1, r0, #0xa4
	bic r2, r2, #4
	str r2, [r4, #0x270]
	ldr r3, [r4, #0x2b0]
	mov r2, #0
	bic r3, r3, #4
	str r3, [r4, #0x2b0]
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl Boss3Stage__ProcessSpatialAudio
	mov r0, r4
	mov r1, #0
	bl Boss3Arm__Func_2168F84
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169F14(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xc
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_2169F78
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169F78(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl Boss3Arm__Func_2169BE4
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	mov r1, #0xa3
	stmia sp, {r0, r1}
	sub r1, r1, #0xa4
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl Boss3Stage__ProcessSpatialAudio
	mov r0, r4
	mov r1, #6
	bl Boss3Arm__Func_2168F84
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_2169FE4(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl Boss3Arm__Func_2169BE4
	mov r1, #0
	add r0, r4, #0xcc
	str r1, [sp]
	mov r3, #1
	str r3, [sp, #4]
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x20]
	add r0, r4, #0x400
	orr r1, r1, #0x20
	str r1, [r4, #0x20]
	mov r2, #0x7f
	ldr r1, =Boss3Arm__StateArm_216A040
	strh r2, [r0, #0x7c]
	str r1, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A040(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl Boss3Arm__Func_2169BE4
	add r0, r4, #0x400
	ldrh r1, [r0, #0x7c]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x7c]
	add r0, r4, #0x400
	ldrh r0, [r0, #0x7c]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x374]
	ldr r0, [r0, #0x374]
	ldr r0, [r0, #0xa4c]
	cmp r0, #3
	mov r0, r4
	bne _0216A094
	mov r1, #0
	bl Boss3Arm__Func_2168F84
	ldmia sp!, {r4, pc}
_0216A094:
	bl Boss3Arm__Action_216A09C
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Action_216A09C(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r2, #5
	ldr r1, =Boss3Arm__StateArm_216A0B4
	str r2, [r0, #0x37c]
	str r1, [r0, #0x378]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A0B4(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl Boss3Arm__Func_2169BE4
	ldr r0, [r4, #0x20]
	mov r1, #0
	bic r0, r0, #0x20
	str r0, [r4, #0x20]
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #9
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_216A128
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	orr r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A128(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl Boss3Arm__Func_2169BE4
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	ldmeqia sp!, {r4, pc}
	ldr r0, =Boss3Arm__StateArm_2169DC0
	str r0, [r4, #0x378]
	ldr r0, [r4, #0x230]
	orr r0, r0, #4
	str r0, [r4, #0x230]
	ldr r0, [r4, #0x270]
	orr r0, r0, #4
	str r0, [r4, #0x270]
	ldr r0, [r4, #0x2b0]
	bic r0, r0, #4
	str r0, [r4, #0x2b0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A178(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r2, r4, #0x500
	ldrh r3, [r2, #0xd8]
	mov r1, #4
	orr r3, r3, #1
	strh r3, [r2, #0xd8]
	ldr r2, [r4, #0x230]
	orr r2, r2, #4
	str r2, [r4, #0x230]
	ldr r2, [r4, #0x270]
	bic r2, r2, #4
	str r2, [r4, #0x270]
	ldr r2, [r4, #0x2b0]
	orr r2, r2, #4
	str r2, [r4, #0x2b0]
	bl Boss3Arm__Func_2168F30
	ldr r0, =Boss3Arm__StateArm_216A1CC
	str r0, [r4, #0x378]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A1CC(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x374]
	ldr r1, [r1, #0x374]
	add r1, r1, #0xa00
	ldrh r1, [r1, #0xf0]
	cmp r1, #0
	ldmneia sp!, {r3, pc}
	ldr r1, =Boss3Arm__StateArm_2169E14
	add r2, r0, #0x500
	str r1, [r0, #0x378]
	ldrh r3, [r2, #0xd8]
	mov r1, #0
	bic r3, r3, #1
	strh r3, [r2, #0xd8]
	bl Boss3Arm__Func_2168F30
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A210(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x478]
	cmp r0, #0
	bne _0216A24C
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xd
	bl BossHelpers__SetAnimation
	b _0216A274
_0216A24C:
	cmp r0, #1
	bne _0216A274
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x14
	bl BossHelpers__SetAnimation
_0216A274:
	ldr r1, [r4, #0x20]
	mov r0, r4
	bic r1, r1, #0x20
	str r1, [r4, #0x20]
	mov r1, #5
	bl Boss3Arm__Func_2168F30
	ldr r1, [r4, #0x230]
	ldr r0, =gPlayer
	orr r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	ldr r2, =0x006BAA99
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r3, [r4, #0x2b0]
	mov r1, #0x40000
	orr r3, r3, #4
	str r3, [r4, #0x2b0]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x44]
	bl BossHelpers__Arena__GetAngle
	add r1, r4, #0x400
	strh r0, [r1, #0x7c]
	ldrh ip, [r1, #0x7c]
	ldr r0, =_0217A82C
	mov r2, #0
	strh ip, [r1, #0x44]
	ldr r3, [r4, #0x478]
	mov r3, r3, lsl #1
	ldrh r3, [r0, r3]
	mov r0, #0x37000
	add r3, ip, r3
	strh r3, [r1, #0x44]
	str r0, [r4, #0x470]
	str r2, [r4, #0x480]
	strh r2, [r1, #0x84]
	str r2, [r4, #0x488]
	str r2, [r4, #0x494]
	str r2, [r4, #0x490]
	str r2, [r4, #0x48c]
	mov r0, #0x9f
	str r2, [sp]
	sub r1, r0, #0xa0
	str r0, [sp, #4]
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl Boss3Stage__ProcessSpatialAudio
	ldr r0, =Boss3Arm__StateArm_216A368
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A368(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	bxeq lr
	ldr r2, =Boss3Arm__StateArm_216A394
	add r1, r0, #0x400
	str r2, [r0, #0x378]
	mov r0, #0x3c
	strh r0, [r1, #0x98]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A394(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0x400
	ldrh r2, [r1, #0x98]
	cmp r2, #0
	subne r2, r2, #1
	strneh r2, [r1, #0x98]
	add r1, r0, #0x400
	ldrh r1, [r1, #0x98]
	cmp r1, #0
	ldreq r1, =Boss3Arm__StateArm_216A3C4
	streq r1, [r0, #0x378]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A3C4(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x478]
	cmp r0, #0
	bne _0216A404
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xe
	bl BossHelpers__SetAnimation
	b _0216A430
_0216A404:
	cmp r0, #1
	bne _0216A430
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x15
	bl BossHelpers__SetAnimation
_0216A430:
	ldr r0, [r4, #0x374]
	bl Boss3Stage__Func_2162AE8
	add r1, r4, #0x400
	strh r0, [r1, #0x84]
	mov r0, r4
	mov r1, #6
	bl Boss3Arm__Func_2168F30
	ldr r0, =Boss3Arm__StateArm_216A460
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A460(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r2, [r0, #0x478]
	cmp r2, #0
	bne _0216A4D0
	add r2, r0, #0x400
	ldrh r3, [r2, #0x44]
	ldrh r1, [r2, #0x84]
	sub r1, r3, r1
	strh r1, [r2, #0x44]
	ldr ip, [r0, #0x374]
	ldr r3, [ip, #0x398]
	ldr r1, [r3, #0x478]
	cmp r1, #1
	bne _0216A4B0
	add r1, r3, #0x400
	ldrh r1, [r1, #0x44]
	ldrh r2, [r2, #0x44]
	sub r2, r2, r1
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
	b _0216A538
_0216A4B0:
	ldr r1, [ip, #0x39c]
	ldrh r2, [r2, #0x44]
	add r1, r1, #0x400
	ldrh r1, [r1, #0x44]
	sub r2, r2, r1
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
	b _0216A538
_0216A4D0:
	cmp r2, #1
	bne _0216A538
	add r2, r0, #0x400
	ldrh r3, [r2, #0x44]
	ldrh r1, [r2, #0x84]
	add r1, r3, r1
	strh r1, [r2, #0x44]
	ldr ip, [r0, #0x374]
	ldr r3, [ip, #0x398]
	ldr r1, [r3, #0x478]
	cmp r1, #0
	bne _0216A51C
	add r1, r3, #0x400
	ldrh r1, [r1, #0x44]
	ldrh r2, [r2, #0x44]
	sub r2, r1, r2
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
	b _0216A538
_0216A51C:
	ldr r1, [ip, #0x39c]
	ldrh r2, [r2, #0x44]
	add r1, r1, #0x400
	ldrh r1, [r1, #0x44]
	sub r2, r1, r2
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
_0216A538:
	mov r2, r3, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r2, asr #4
	ldr r2, =FX_SinCosTable_
	mov r3, r3, lsl #2
	ldrsh r2, [r2, r3]
	cmp r2, #0
	bxgt lr
	add r2, r0, #0x400
	ldr r3, =Boss3Arm__StateArm_216A574
	strh r1, [r2, #0x44]
	str r3, [r0, #0x378]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A574(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x478]
	cmp r0, #0
	bne _0216A5B0
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xf
	bl BossHelpers__SetAnimation
	b _0216A5D8
_0216A5B0:
	cmp r0, #1
	bne _0216A5D8
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x16
	bl BossHelpers__SetAnimation
_0216A5D8:
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_216A610
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	orr r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A610(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldrne r1, =Boss3Arm__StateArm_216A62C
	strne r1, [r0, #0x378]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A62C(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x478]
	cmp r0, #0
	bne _0216A66C
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x10
	bl BossHelpers__SetAnimation
	b _0216A698
_0216A66C:
	cmp r0, #1
	bne _0216A698
	mov r1, #0
	str r1, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x17
	bl BossHelpers__SetAnimation
_0216A698:
	ldr r0, [r4, #0x380]
	cmp r0, #1
	bne _0216A6E4
	mov r0, r4
	mov r1, #7
	bl Boss3Arm__Func_2168F30
	mov r2, #0
	mov r0, #0xa2
	sub r1, r0, #0xa3
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl Boss3Stage__ProcessSpatialAudio
_0216A6E4:
	ldr r0, =Boss3Arm__StateArm_216A6F8
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A6F8(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, [r0, #0x380]
	cmp r1, #1
	ldreq r1, [r0, #0x488]
	cmpeq r1, #0
	ldrne r1, =Boss3Arm__StateArm_216A734
	strne r1, [r0, #0x378]
	bxne lr
	ldr r1, =Boss3Arm__StateArm_216A9C8
	str r1, [r0, #0x378]
	ldr r0, [r0, #0x374]
	ldr r0, [r0, #0x398]
	str r1, [r0, #0x378]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A734(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x478]
	cmp r0, #0
	bne _0216A770
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x11
	bl BossHelpers__SetAnimation
	b _0216A798
_0216A770:
	cmp r0, #1
	bne _0216A798
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x18
	bl BossHelpers__SetAnimation
_0216A798:
	ldr r0, =Boss3Arm__StateArm_216A7AC
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A7AC(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r0
	ldr r0, [r4, #0x488]
	cmp r0, #0
	beq _0216A81C
	ldr r1, [r4, #0x44]
	ldr r2, =0x006BAA99
	str r1, [sp]
	ldr r1, [r4, #0x4c]
	ldr r3, =0x00107FC0
	str r1, [sp, #4]
	add r0, sp, #8
	mov r1, #0x40000
	bl BossHelpers__Arena__GetPosition
	ldr r1, [r4, #0x4c4]
	ldr r0, [r4, #0x480]
	rsb r5, r1, #0
	bl BossHelpers__Player__IsAlive
	cmp r0, #0
	beq _0216A81C
	ldr r1, [sp, #8]
	ldr r0, [r4, #0x480]
	str r1, [r0, #0x44]
	ldr r1, [r4, #0x490]
	ldr r0, [r4, #0x480]
	add r1, r5, r1
	str r1, [r0, #0x48]
_0216A81C:
	ldr r0, [r4, #0x5b0]
	ldr r0, [r0, #0]
	cmp r0, #0x2d000
	bne _0216A888
	ldr r0, [r4, #0x488]
	cmp r0, #0
	beq _0216A870
	ldr r1, [r4, #0x374]
	ldr r0, [r1, #0x4a0]
	orr r0, r0, #4
	str r0, [r1, #0x4a0]
	ldr r0, [r4, #0x480]
	bl BossHelpers__Player__IsAlive
	cmp r0, #0
	beq _0216A870
	ldr r0, [r4, #0x480]
	mov r1, #0xa000
	str r1, [r0, #0xb4]
	ldr r0, [r4, #0x480]
	mov r1, #0x32000
	str r1, [r0, #0x9c]
_0216A870:
	mov r0, r4
	mov r1, #5
	bl Boss3Arm__Func_2168F30
	mov r0, #0
	str r0, [r4, #0x488]
	str r0, [r4, #0x480]
_0216A888:
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	ldrne r0, =Boss3Arm__StateArm_216A8B0
	strne r0, [r4, #0x378]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A8B0(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x478]
	cmp r0, #0
	bne _0216A8EC
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x12
	bl BossHelpers__SetAnimation
	b _0216A914
_0216A8EC:
	cmp r0, #1
	bne _0216A914
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x19
	bl BossHelpers__SetAnimation
_0216A914:
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_216A94C
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A94C(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	mov r1, #0xa3
	stmia sp, {r0, r1}
	sub r1, r1, #0xa4
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl Boss3Stage__ProcessSpatialAudio
	mov r0, r4
	mov r1, #0
	bl Boss3Arm__Func_2168F84
	mov r0, r4
	mov r1, #0
	bl Boss3Arm__Func_2168F30
	mov r0, #0x32000
	str r0, [r4, #0x470]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216A9C8(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x478]
	cmp r0, #0
	bne _0216AA04
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x13
	bl BossHelpers__SetAnimation
	b _0216AA2C
_0216AA04:
	cmp r0, #1
	bne _0216AA2C
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0x1a
	bl BossHelpers__SetAnimation
_0216AA2C:
	mov r0, r4
	mov r1, #0
	bl Boss3Arm__Func_2168F30
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_216AA70
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216AA70(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	mov r1, #0xa3
	stmia sp, {r0, r1}
	sub r1, r1, #0xa4
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl Boss3Stage__ProcessSpatialAudio
	mov r2, #0x32000
	mov r0, r4
	mov r1, #0
	str r2, [r4, #0x470]
	bl Boss3Arm__Func_2168F84
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216AAE0(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r2, r4, #0x500
	ldrh r3, [r2, #0xd8]
	mov r1, #8
	orr r3, r3, #1
	strh r3, [r2, #0xd8]
	ldr r2, [r4, #0x230]
	orr r2, r2, #4
	str r2, [r4, #0x230]
	ldr r2, [r4, #0x270]
	bic r2, r2, #4
	str r2, [r4, #0x270]
	ldr r2, [r4, #0x2b0]
	orr r2, r2, #4
	str r2, [r4, #0x2b0]
	bl Boss3Arm__Func_2168F30
	ldr r0, =Boss3Arm__StateArm_216AB34
	str r0, [r4, #0x378]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216AB34(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, [r0, #0x374]
	ldr r2, [r0, #0x478]
	ldr r1, [r1, #0x39c]
	cmp r2, #0
	add r1, r1, #0x400
	ldrh r1, [r1, #0x44]
	bne _0216AB68
	add r2, r0, #0x400
	ldrh r2, [r2, #0x44]
	sub r2, r2, r1
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
	b _0216AB84
_0216AB68:
	cmp r2, #1
	bne _0216AB84
	add r2, r0, #0x400
	ldrh r2, [r2, #0x44]
	sub r2, r1, r2
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
_0216AB84:
	mov r2, r3, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r2, asr #4
	ldr r2, =FX_SinCosTable_
	mov r3, r3, lsl #2
	ldrsh r2, [r2, r3]
	cmp r2, #0
	bxgt lr
	add r2, r0, #0x400
	ldr r3, =Boss3Arm__StateArm_216A574
	strh r1, [r2, #0x44]
	str r3, [r0, #0x378]
	add r0, r0, #0x500
	ldrh r1, [r0, #0xd8]
	bic r1, r1, #1
	strh r1, [r0, #0xd8]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216ABD0(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #3
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, r4
	bic r2, r1, #0x20
	mov r1, #9
	str r2, [r4, #0x20]
	bl Boss3Arm__Func_2168F30
	mov r2, #0
	mov r0, #0x9f
	sub r1, r0, #0xa0
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl Boss3Stage__ProcessSpatialAudio
	ldr r0, =Boss3Arm__StateArm_216AC5C
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216AC5C(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldrne r1, =Boss3Arm__StateArm_216AC78
	strne r1, [r0, #0x378]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216AC78(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #5
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_216ACDC
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	orr r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216ACDC(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	mov r0, #0xa0
	str r1, [sp]
	sub r1, r0, #0xa1
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl Boss3Stage__ProcessSpatialAudio
	ldr r2, [r4, #0x374]
	mov r3, #0
	mov r0, r4
	mov r1, #0xc
	str r3, [r2, #0x40c]
	bl Boss3Arm__Func_2168F84
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216AD50(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #6
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_216ADB8
	orr r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	orr r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void Boss3Arm__StateArm_216ADB8(Boss3Arm *work)
{
    // Do nothing
}

NONMATCH_FUNC void Boss3Arm__StateArm_216ADBC(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #7
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_216AE20
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216AE20(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	mov r1, #0xa3
	stmia sp, {r0, r1}
	sub r1, r1, #0xa4
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl Boss3Stage__ProcessSpatialAudio
	mov r0, r4
	mov r1, #0
	bl Boss3Arm__Func_2168F84
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216AE88(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #8
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_216AEEC
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216AEEC(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	mov r1, #0xa3
	stmia sp, {r0, r1}
	sub r1, r1, #0xa4
	ldr r0, [r4, #0x374]
	mov r2, r1
	ldr r0, [r0, #0x138]
	mov r3, r1
	bl PlaySfxEx
	add r0, r4, #0x400
	ldrh r1, [r0, #0x44]
	ldr r0, [r4, #0x138]
	bl Boss3Stage__ProcessSpatialAudio
	mov r0, r4
	mov r1, #0
	bl Boss3Arm__Func_2168F84
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216AF54(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r2, r4, #0x500
	ldrh r3, [r2, #0xd8]
	mov r1, #0xa
	orr r3, r3, #1
	strh r3, [r2, #0xd8]
	ldr r2, [r4, #0x230]
	orr r2, r2, #4
	str r2, [r4, #0x230]
	ldr r2, [r4, #0x270]
	bic r2, r2, #4
	str r2, [r4, #0x270]
	ldr r2, [r4, #0x2b0]
	orr r2, r2, #4
	str r2, [r4, #0x2b0]
	bl Boss3Arm__Func_2168F30
	add r0, r4, #0x400
	mov r2, #0xb4
	ldr r1, =Boss3Arm__StateArm_216AFB4
	strh r2, [r0, #0x74]
	str r1, [r4, #0x378]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216AFB4(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x400
	ldrh r1, [r0, #0x74]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x74]
	add r0, r4, #0x400
	ldrh r0, [r0, #0x74]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0xe
	bl Boss3Arm__Func_2168F84
	mov r0, r4
	mov r1, #9
	bl Boss3Arm__Func_2168F30
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Func_216AFFC(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, [r0, #0x374]
	ldr r1, [r1, #0x374]
	ldr r1, [r1, #0xaf0]
	cmp r1, #0
	add r1, r0, #0x400
	ldreqsh r3, [r1, #0x44]
	ldreqsh r2, [r1, #0x78]
	subeq r2, r3, r2
	beq _0216B02C
	ldrsh r3, [r1, #0x44]
	ldrsh r2, [r1, #0x78]
	add r2, r3, r2
_0216B02C:
	add r0, r0, #0x400
	strh r2, [r1, #0x44]
	ldrh r1, [r0, #0x78]
	add r1, r1, #5
	strh r1, [r0, #0x78]
	ldrh r2, [r0, #0x7a]
	ldrh r1, [r0, #0x78]
	cmp r1, r2
	strhih r2, [r0, #0x78]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B054(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r1, [r5, #0x374]
	add r0, r5, #0xcc
	ldr r4, [r1, #0x374]
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldr r2, [r5, #0x368]
	add r0, r0, #0x400
	mov r3, #9
	bl BossHelpers__SetAnimation
	ldr r1, [r5, #0x20]
	mov r0, r5
	bic r1, r1, #0x20
	str r1, [r5, #0x20]
	ldr r2, [r5, #0x230]
	mov r1, #0xb
	bic r2, r2, #4
	str r2, [r5, #0x230]
	ldr r2, [r5, #0x270]
	orr r2, r2, #4
	str r2, [r5, #0x270]
	ldr r2, [r5, #0x2b0]
	bic r2, r2, #4
	str r2, [r5, #0x2b0]
	bl Boss3Arm__Func_2168F30
	ldr r0, [r4, #0xaf0]
	cmp r0, #0
	add r0, r4, #0xa00
	beq _0216B0E8
	ldrsh r2, [r0, #0xd6]
	ldr r0, =0xFFFFE71C
	add r1, r5, #0x400
	add r0, r2, r0
	b _0216B0F8
_0216B0E8:
	ldrsh r0, [r0, #0xd6]
	add r1, r5, #0x400
	add r0, r0, #0xe4
	add r0, r0, #0x1800
_0216B0F8:
	strh r0, [r1, #0x44]
	ldrh r0, [r1, #0x44]
	strh r0, [r1, #0x7c]
	add r0, r5, #0x400
	mov r1, #0
	strh r1, [r0, #0x78]
	ldr r0, [r5, #0x374]
	bl Boss3Stage__Func_2162B04
	add r1, r5, #0x400
	ldr r2, =Boss3Arm__StateArm_216B138
	strh r0, [r1, #0x7a]
	str r2, [r5, #0x378]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B138(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldrne r1, =Boss3Arm__StateArm_216B154
	strne r1, [r0, #0x378]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B154(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xa
	bl BossHelpers__SetAnimation
	add r0, r4, #0x400
	mov r1, #0
	strh r1, [r0, #0x78]
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_216B1C8
	orr r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	orr r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B1C8(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x374]
	ldr r1, [r1, #0x374]
	ldr r1, [r1, #0xaf0]
	cmp r1, #0
	add r1, r0, #0x400
	ldrnesh r2, [r1, #0x44]
	ldrnesh r1, [r1, #0x7c]
	ldreqsh r2, [r1, #0x7c]
	ldreqsh r1, [r1, #0x44]
	sub r1, r2, r1
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	ldr r1, =0x000031C8
	cmp r2, r1
	ldrhs r1, =Boss3Arm__StateArm_216B220
	strhs r1, [r0, #0x378]
	ldmhsia sp!, {r3, pc}
	bl Boss3Arm__Func_216AFFC
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B220(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xb
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_216B284
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	orr r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B284(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldmeqia sp!, {r3, pc}
	ldr r2, [r0, #0x230]
	mov r1, #0xf
	bic r2, r2, #4
	str r2, [r0, #0x230]
	ldr r2, [r0, #0x270]
	bic r2, r2, #4
	str r2, [r0, #0x270]
	ldr r2, [r0, #0x2b0]
	bic r2, r2, #4
	str r2, [r0, #0x2b0]
	bl Boss3Arm__Func_2168F84
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__Action_216B2C8(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #0xc
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_216B32C
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B32C(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldmeqia sp!, {r3, pc}
	mov r1, #0xf
	bl Boss3Arm__Func_2168F84
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B34C(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r2, r4, #0x500
	ldrh r3, [r2, #0xd8]
	mov r1, #0xc
	orr r3, r3, #1
	strh r3, [r2, #0xd8]
	ldr r2, [r4, #0x230]
	orr r2, r2, #4
	str r2, [r4, #0x230]
	ldr r2, [r4, #0x270]
	bic r2, r2, #4
	str r2, [r4, #0x270]
	ldr r2, [r4, #0x2b0]
	orr r2, r2, #4
	str r2, [r4, #0x2b0]
	bl Boss3Arm__Func_2168F30
	add r0, r4, #0x400
	mov r2, #0xb4
	ldr r1, =Boss3Arm__StateArm_216B3AC
	strh r2, [r0, #0x74]
	str r1, [r4, #0x378]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B3AC(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x400
	ldrh r1, [r0, #0x74]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x74]
	add r0, r4, #0x400
	ldrh r0, [r0, #0x74]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl Boss3Arm__Action_216B2C8
	mov r0, r4
	mov r1, #0
	bl Boss3Arm__Func_2168F30
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B3F0(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =Boss3Arm__StateArm_216B400
	str r1, [r0, #0x378]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B400(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =Boss3Arm__Func_2168F84
	mov r1, #0
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B410(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, =Boss3Arm__StateArm_216B420
	str r1, [r0, #0x378]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B420(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =Boss3Arm__Func_2168F84
	mov r1, #0
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B430(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #3
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, r4
	bic r2, r1, #0x20
	mov r1, #0xd
	str r2, [r4, #0x20]
	bl Boss3Arm__Func_2168F30
	ldr r0, =Boss3Arm__StateArm_216B488
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B488(Boss3Arm *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldrne r1, =Boss3Arm__StateArm_216B4A4
	strne r1, [r0, #0x378]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B4A4(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #5
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x270]
	ldr r0, =Boss3Arm__StateArm_216B4F0
	orr r1, r1, #4
	str r1, [r4, #0x270]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B4F0(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x500
	ldrh r0, [r0, #0xd8]
	tst r0, #0x8000
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	mov r0, #0xa0
	str r1, [sp]
	sub r1, r0, #0xa1
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, r4
	mov r1, #0x16
	bl Boss3Arm__Func_2168F84
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B548(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r2, #1
	mov r4, r0
	str r2, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #6
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_216B5B0
	orr r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	orr r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void Boss3Arm__StateArm_216B5B0(Boss3Arm *work)
{
    // Do nothing
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B5B4(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #0
	str r1, [sp]
	mov r4, r0
	str r1, [sp, #4]
	add r0, r4, #0xcc
	ldr r2, [r4, #0x368]
	add r0, r0, #0x400
	mov r3, #7
	bl BossHelpers__SetAnimation
	ldr r1, [r4, #0x230]
	ldr r0, =Boss3Arm__StateArm_216B618
	bic r1, r1, #4
	str r1, [r4, #0x230]
	ldr r1, [r4, #0x270]
	bic r1, r1, #4
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x2b0]
	bic r1, r1, #4
	str r1, [r4, #0x2b0]
	str r0, [r4, #0x378]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Boss3Arm__StateArm_216B618(Boss3Arm *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	add r1, r0, #0x500
	ldrh r1, [r1, #0xd8]
	tst r1, #0x8000
	ldmeqia sp!, {r3, pc}
	mov r1, #0
	bl Boss3Arm__Func_2168F84
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}