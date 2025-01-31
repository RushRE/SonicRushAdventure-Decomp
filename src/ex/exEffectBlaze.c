#include <ex/effects/exBlazeFireball.h>
#include <ex/system/exSystem.h>
#include <game/audio/audioSystem.h>
#include <game/file/binaryBundle.h>

// Resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// VARIABLES
// --------------------

struct TEMP_STATIC_VARS
{
    s16 exExEffectBlzFireTaMeTask__ActiveInstanceCount;
    s16 exEffectBlzFireTask__ActiveInstanceCount;
    s16 exEffectBlzFireShotTask__ActiveInstanceCount;

    void *exEffectBlzFireTask__FileTable;
    void *exEffectBlzFireTask__TaskSingleton;
    void *exEffectBlzFireShotTask__unk_21764F8;
    void *exEffectBlzFireShotTask__unk_21764FC;
    void *exEffectBlzFireShotTask__unk_2176500;
    void *exExEffectBlzFireTaMeTask__TaskSingleton;
    void *exEffectBlzFireShotTask__dword_2176508;
    void *exExEffectBlzFireTaMeTask__dword_217650C;
    void *exExEffectBlzFireTaMeTask__unk_2176510;
    void *exExEffectBlzFireTaMeTask__unk_2176514;
    void *exExEffectBlzFireTaMeTask__unk_2176518;
    void *exExEffectBlzFireTaMeTask__unk_217651C;
    void *exEffectBlzFireShotTask__dword_2176520;
    void *exEffectBlzFireShotTask__TaskSingleton;
    void *exExEffectBlzFireTaMeTask__FileTable[2];
    void *exEffectBlzFireShotTask__AnimTable[4];
    void *exEffectBlzFireShotTask__FileTable[4];
};

NOT_DECOMPILED s16 exExEffectBlzFireTaMeTask__ActiveInstanceCount;
NOT_DECOMPILED s16 exEffectBlzFireTask__ActiveInstanceCount;
NOT_DECOMPILED s16 exEffectBlzFireShotTask__ActiveInstanceCount;

NOT_DECOMPILED void *exEffectBlzFireTask__FileTable;
NOT_DECOMPILED void *exEffectBlzFireTask__TaskSingleton;
NOT_DECOMPILED void *exEffectBlzFireShotTask__unk_21764F8;
NOT_DECOMPILED void *exEffectBlzFireShotTask__unk_21764FC;
NOT_DECOMPILED void *exEffectBlzFireShotTask__unk_2176500;
NOT_DECOMPILED void *exExEffectBlzFireTaMeTask__TaskSingleton;
NOT_DECOMPILED void *exEffectBlzFireShotTask__dword_2176508;
NOT_DECOMPILED void *exExEffectBlzFireTaMeTask__dword_217650C;
NOT_DECOMPILED void *exExEffectBlzFireTaMeTask__unk_2176510;
NOT_DECOMPILED void *exExEffectBlzFireTaMeTask__unk_2176514;
NOT_DECOMPILED void *exExEffectBlzFireTaMeTask__unk_2176518;
NOT_DECOMPILED void *exExEffectBlzFireTaMeTask__unk_217651C;
NOT_DECOMPILED void *exEffectBlzFireShotTask__dword_2176520;
NOT_DECOMPILED void *exEffectBlzFireShotTask__TaskSingleton;
NOT_DECOMPILED void *exExEffectBlzFireTaMeTask__FileTable[2];
NOT_DECOMPILED void *exEffectBlzFireShotTask__AnimTable[4];
NOT_DECOMPILED void *exEffectBlzFireShotTask__FileTable[4];


NOT_DECOMPILED float _021744C0[];

NOT_DECOMPILED void *aExtraExBb_8;
NOT_DECOMPILED void *aExeffectblzfir;
NOT_DECOMPILED void *aExexeffectblzf;
NOT_DECOMPILED void *aExeffectblzfir_0;

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void _f_ftoi(void);
NOT_DECOMPILED void _fdiv(void);
NOT_DECOMPILED void _f_sub(void);
NOT_DECOMPILED void _fadd(void);
NOT_DECOMPILED void _f_mul(void);
NOT_DECOMPILED void _fgr(void);

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC void exEffectBlzFireTask__LoadFireAssets(EX_ACTION_BAC3D_WORK *work, u16 anim)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r4, r1
	bl exDrawReqTask__InitSprite3D
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldrsh r0, [r0, #2]
	cmp r0, #0
	bne _02165B18
	mov r0, #0
	bl LoadExSystemFile
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	str r0, [r1, #8]
_02165B18:
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r1, #1
	ldr r0, [r0, #8]
	bl Sprite__GetTextureSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocTexture
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r6, r0
	ldr r0, [r1, #8]
	mov r1, #1
	bl Sprite__GetPaletteSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #4
	stmia sp, {r1, r6}
	str r0, [sp, #8]
	ldr r2, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r3, r4
	ldr r2, [r2, #8]
	add r0, r5, #0x20
	mov r1, #0
	bl AnimatorSprite3D__Init
	ldr r1, [r5, #0x114]
	mov r0, #2
	orr r1, r1, #0x800
	str r1, [r5, #0x114]
	strb r0, [r5]
	ldrb r1, [r5, #4]
	mov r0, #0x46000
	mov r2, #4
	orr r1, r1, #4
	strb r1, [r5, #4]
	str r0, [r5, #0x134]
	ldrb r3, [r5, #0x150]
	ldr r1, =0x00007FF8
	add r0, r5, #0x100
	bic r3, r3, #3
	strb r3, [r5, #0x150]
	str r2, [r5, #0x138]
	str r2, [r5, #0x13c]
	strh r1, [r0, #0x28]
	str r2, [r5, #0xc]
	str r2, [r5, #0x10]
	str r2, [r5, #0x14]
	add r0, r5, #0x12c
	str r0, [r5, #0x18]
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldrsh r1, [r0, #2]
	add r1, r1, #1
	strh r1, [r0, #2]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBlzFireTask__ReleaseFireAssets(EX_ACTION_BAC3D_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	add r0, r0, #0x20
	bl AnimatorSprite3D__Release
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldrsh r1, [r0, #2]
	sub r1, r1, #1
	strh r1, [r0, #2]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exExEffectBlzFireTaMeTask__LoadFireTaMeAssets(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r4, r0
	str r4, [r1, #0x34]
	ldr r0, [r1, #0x2c]
	cmp r0, #0
	ldrne r0, [r1, #0x28]
	cmpne r0, #0
	beq _02165C80
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldr r1, [r1, #0x2c]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldr r1, [r1, #0x28]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldr r1, [r1, #0x2c]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
_02165C80:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _02165D04
	mov r1, #0x11
	ldr r0, =aExtraExBb_8
	sub r2, r1, #0x12
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r0, r0, lsr #8
	str r0, [r1, #0x2c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r0, r5
	str r1, [r2, #0x24]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x33
	bl LoadExSystemFile
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	str r0, [r1, #0x40]
	mov r0, #0x34
	bl LoadExSystemFile
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	str r0, [r1, #0x44]
	ldr r0, [r1, #0x24]
	bl Asset3DSetup__Create
_02165D04:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	str r2, [sp]
	ldr r1, [r0, #0x24]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r1, #0
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	str r1, [sp]
	ldr r2, [r0, #0x40]
	mov r3, r1
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	mov r3, #0
	ldr r2, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	str r3, [sp]
	ldr r2, [r2, #0x44]
	add r0, r4, #0x20
	mov r1, #4
	bl AnimatorMDL__SetAnimation
	add r0, r4, #0x300
	mov r3, #0
	strh r3, [r0, #0x48]
	ldr r0, [r4, #0x104]
	mov r2, #1
	str r0, [r4, #0x344]
_02165D7C:
	mov r0, r2, lsl r3
	tst r0, #0x11
	beq _02165D9C
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02165D9C:
	add r3, r3, #1
	cmp r3, #5
	blo _02165D7C
	mov r0, #0x46000
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r2, =0x0000BFF4
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r3, #0
	strb r3, [r4]
	ldrb r2, [r4, #5]
	add r0, r4, #0x350
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	bic r2, r2, #1
	orr r2, r2, #1
	strb r2, [r4, #5]
	str r3, [r4, #0xc]
	str r3, [r4, #0x10]
	str r3, [r4, #0x14]
	str r0, [r4, #0x18]
	ldrb r2, [r4, #0x38c]
	mov r0, #1
	bic r2, r2, #3
	orr r2, r2, #1
	strb r2, [r4, #0x38c]
	ldrsh r2, [r1, #0]
	add r2, r2, #1
	strh r2, [r1]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exExEffectBlzFireTaMeTask__ReleaseFireTaMeAssets(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r4, r0
	ldrsh r0, [r1, #0]
	cmp r0, #1
	bgt _02165EA8
	ldr r0, [r1, #0x24]
	cmp r0, #0
	beq _02165E60
	bl NNS_G3dResDefaultRelease
_02165E60:
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldr r0, [r0, #0x40]
	cmp r0, #0
	beq _02165E74
	bl NNS_G3dResDefaultRelease
_02165E74:
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldr r0, [r0, #0x44]
	cmp r0, #0
	beq _02165E88
	bl NNS_G3dResDefaultRelease
_02165E88:
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldr r0, [r0, #0x24]
	cmp r0, #0
	beq _02165E9C
	bl _FreeHEAP_USER
_02165E9C:
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x24]
_02165EA8:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBlzFireTask__LoadFireShotAssets(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r4, r0
	str r4, [r1, #0x14]
	ldr r0, [r1, #0x38]
	cmp r0, #0
	ldrne r0, [r1, #0x10]
	cmpne r0, #0
	beq _02165F44
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldr r1, [r1, #0x38]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldr r1, [r1, #0x10]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldr r1, [r1, #0x38]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02165F44:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldrsh r0, [r0, #4]
	cmp r0, #0
	bne _02166008
	mov r1, #0x12
	ldr r0, =aExtraExBb_8
	sub r2, r1, #0x13
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r0, r0, lsr #8
	str r0, [r1, #0x38]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r0, r5
	str r1, [r2, #0x20]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x38
	bl LoadExSystemFile
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r2, #4
	str r0, [r1, #0x58]
	mov r0, #0x35
	str r2, [r1, #0x48]
	bl LoadExSystemFile
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r2, #0
	str r0, [r1, #0x5c]
	mov r0, #0x36
	str r2, [r1, #0x4c]
	bl LoadExSystemFile
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r2, #1
	str r0, [r1, #0x60]
	mov r0, #0x37
	str r2, [r1, #0x50]
	bl LoadExSystemFile
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r2, #2
	str r0, [r1, #0x64]
	str r2, [r1, #0x54]
	ldr r0, [r1, #0x20]
	bl Asset3DSetup__Create
_02166008:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	str r2, [sp]
	ldr r1, [r0, #0x20]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, =exEffectBlzFireShotTask__AnimTable
	ldr r5, =exEffectBlzFireShotTask__FileTable
	mov r7, r8
_02166040:
	str r7, [sp]
	ldr r1, [r6, r8, lsl #2]
	ldr r2, [r5, r8, lsl #2]
	mov r3, r7
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #3
	blo _02166040
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldr r0, [r0, #0x20]
	bl NNS_G3dGetTex
	str r0, [sp]
	ldr r2, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	add r0, r4, #0x20
	ldr r1, [r2, #0x54]
	ldr r2, [r2, #0x64]
	mov r3, #0
	bl AnimatorMDL__SetAnimation
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	add r0, r4, #0x300
	ldr r2, [r1, #0x4c]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x4c]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_021660BC:
	mov r0, r2, lsl r3
	tst r0, #0x17
	beq _021660DC
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_021660DC:
	add r3, r3, #1
	cmp r3, #5
	blo _021660BC
	mov r0, #0x3c000
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r2, =0x0000BFF4
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r3, #0
	strb r3, [r4]
	ldrb r2, [r4, #5]
	add r0, r4, #0x350
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	bic r2, r2, #1
	orr r2, r2, #1
	strb r2, [r4, #5]
	str r3, [r4, #0xc]
	str r3, [r4, #0x10]
	str r3, [r4, #0x14]
	str r0, [r4, #0x18]
	ldrb r2, [r4, #0x38c]
	mov r0, #1
	bic r2, r2, #3
	orr r2, r2, #1
	strb r2, [r4, #0x38c]
	ldrsh r2, [r1, #4]
	add r2, r2, #1
	strh r2, [r1, #4]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBlzFireTask__ReleaseFireShotAssets(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r4, r0
	ldrsh r0, [r1, #4]
	cmp r0, #1
	bgt _0216621C
	ldr r0, [r1, #0x20]
	cmp r0, #0
	beq _021661AC
	bl NNS_G3dResDefaultRelease
_021661AC:
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldr r0, [r0, #0x58]
	cmp r0, #0
	beq _021661C0
	bl NNS_G3dResDefaultRelease
_021661C0:
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldr r0, [r0, #0x5c]
	cmp r0, #0
	beq _021661D4
	bl NNS_G3dResDefaultRelease
_021661D4:
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldr r0, [r0, #0x60]
	cmp r0, #0
	beq _021661E8
	bl NNS_G3dResDefaultRelease
_021661E8:
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldr r0, [r0, #0x64]
	cmp r0, #0
	beq _021661FC
	bl NNS_G3dResDefaultRelease
_021661FC:
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldr r0, [r0, #0x20]
	cmp r0, #0
	beq _02166210
	bl _FreeHEAP_USER
_02166210:
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x20]
_0216621C:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	ldrsh r1, [r0, #4]
	sub r1, r1, #1
	strh r1, [r0, #4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBlzFireTask__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r2, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r1, #9
	str r0, [r2, #0xc]
	add r0, r4, #0x10
	bl exEffectBlzFireTask__LoadFireAssets
	add r0, r4, #0x160
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x160
	bl exDrawReqTask__Func_2164218
	mov r0, #0
	str r0, [r4]
	bl GetExTaskCurrent
	ldr r1, =exEffectBlzFireTask__Main_Active
	str r1, [r0]
	bl exEffectBlzFireTask__Main_Active
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBlzFireTask__Func8(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBlzFireTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0x10
	bl exEffectBlzFireTask__ReleaseFireAssets
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0xc]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBlzFireTask__Main_Active(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, [r0, #0x2b0]
	ldrh r0, [r0, #0x1c]
	cmp r0, #9
	bne _02166304
	bl exEffectBlzFireTask__HandleMovement
	ldmia sp!, {r3, pc}
_02166304:
	cmp r0, #6
	cmpne r0, #7
	cmpne r0, #8
	beq _02166324
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
_02166324:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBlzFireTask__HandleMovement(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _02166658
	ldr r0, [r4, #0x2b0]
	ldrsh r0, [r0, #8]
	cmp r0, #6
	bge _02166454
	ldr r0, =_021744C0
	mov r1, #0
	ldr r0, [r0, #0]
	bl _fgr
	ldr r0, =0x45800000
	bls _02166398
	ldr r1, =_021744C0
	ldr r1, [r1, #0]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021663AC
_02166398:
	ldr r1, =_021744C0
	ldr r1, [r1, #0]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021663AC:
	bl _f_ftoi
	ldr r1, =_021744C0
	str r0, [r4]
	ldr r0, [r1, #0xc]
	mov r1, #0
	bl _fgr
	ldr r0, =0x45800000
	bls _021663E8
	ldr r1, =_021744C0
	ldr r1, [r1, #0xc]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021663FC
_021663E8:
	ldr r1, =_021744C0
	ldr r1, [r1, #0xc]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021663FC:
	bl _f_ftoi
	ldr r1, =_021744C0
	str r0, [r4, #0x1c]
	ldr r0, [r1, #0x10]
	mov r1, #0
	bl _fgr
	ldr r0, =0x45800000
	bls _02166438
	ldr r1, =_021744C0
	ldr r1, [r1, #0x10]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _0216644C
_02166438:
	ldr r1, =_021744C0
	ldr r1, [r1, #0x10]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_0216644C:
	bl _f_ftoi
	str r0, [r4, #0x20]
_02166454:
	ldr r0, [r4, #0x2b0]
	ldrsh r0, [r0, #8]
	cmp r0, #6
	blt _02166554
	ldr r0, =_021744C0
	mov r1, #0
	ldr r0, [r0, #0x18]
	bl _fgr
	ldr r0, =0x45800000
	bls _02166498
	ldr r1, =_021744C0
	ldr r1, [r1, #0x18]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021664AC
_02166498:
	ldr r1, =_021744C0
	ldr r1, [r1, #0x18]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021664AC:
	bl _f_ftoi
	ldr r1, =_021744C0
	str r0, [r4]
	ldr r0, [r1, #0x24]
	mov r1, #0
	bl _fgr
	ldr r0, =0x45800000
	bls _021664E8
	ldr r1, =_021744C0
	ldr r1, [r1, #0x24]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021664FC
_021664E8:
	ldr r1, =_021744C0
	ldr r1, [r1, #0x24]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021664FC:
	bl _f_ftoi
	ldr r1, =_021744C0
	str r0, [r4, #0x1c]
	ldr r0, [r1, #0x28]
	mov r1, #0
	bl _fgr
	ldr r0, =0x45800000
	bls _02166538
	ldr r1, =_021744C0
	ldr r1, [r1, #0x28]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _0216654C
_02166538:
	ldr r1, =_021744C0
	ldr r1, [r1, #0x28]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_0216654C:
	bl _f_ftoi
	str r0, [r4, #0x20]
_02166554:
	ldr r0, [r4, #0x2b0]
	ldrsh r0, [r0, #8]
	cmp r0, #0xf
	blt _02166968
	ldr r0, =_021744C0
	mov r1, #0
	ldr r0, [r0, #0x30]
	bl _fgr
	ldr r0, =0x45800000
	bls _02166598
	ldr r1, =_021744C0
	ldr r1, [r1, #0x30]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021665AC
_02166598:
	ldr r1, =_021744C0
	ldr r1, [r1, #0x30]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021665AC:
	bl _f_ftoi
	ldr r1, =_021744C0
	str r0, [r4]
	ldr r0, [r1, #0x3c]
	mov r1, #0
	bl _fgr
	ldr r0, =0x45800000
	bls _021665E8
	ldr r1, =_021744C0
	ldr r1, [r1, #0x3c]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021665FC
_021665E8:
	ldr r1, =_021744C0
	ldr r1, [r1, #0x3c]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021665FC:
	bl _f_ftoi
	ldr r1, =_021744C0
	str r0, [r4, #0x1c]
	ldr r0, [r1, #0x40]
	mov r1, #0
	bl _fgr
	ldr r0, =0x45800000
	bls _02166638
	ldr r1, =_021744C0
	ldr r1, [r1, #0x40]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _0216664C
_02166638:
	ldr r1, =_021744C0
	ldr r1, [r1, #0x40]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_0216664C:
	bl _f_ftoi
	str r0, [r4, #0x20]
	b _02166968
_02166658:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _02166968
	ldr r0, [r4, #0x2b0]
	ldrsh r0, [r0, #8]
	cmp r0, #7
	bge _02166768
	ldr r0, =_021744C0
	mov r1, #0
	ldr r0, [r0, #0]
	bl _fgr
	ldr r0, =0x45800000
	bls _021666AC
	ldr r1, =_021744C0
	ldr r1, [r1, #0]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021666C0
_021666AC:
	ldr r1, =_021744C0
	ldr r1, [r1, #0]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021666C0:
	bl _f_ftoi
	ldr r1, =_021744C0
	str r0, [r4]
	ldr r0, [r1, #0xc]
	mov r1, #0
	bl _fgr
	ldr r0, =0x45800000
	bls _021666FC
	ldr r1, =_021744C0
	ldr r1, [r1, #0xc]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02166710
_021666FC:
	ldr r1, =_021744C0
	ldr r1, [r1, #0xc]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02166710:
	bl _f_ftoi
	ldr r1, =_021744C0
	str r0, [r4, #0x1c]
	ldr r0, [r1, #0x10]
	mov r1, #0
	bl _fgr
	ldr r0, =0x45800000
	bls _0216674C
	ldr r1, =_021744C0
	ldr r1, [r1, #0x10]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02166760
_0216674C:
	ldr r1, =_021744C0
	ldr r1, [r1, #0x10]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02166760:
	bl _f_ftoi
	str r0, [r4, #0x20]
_02166768:
	ldr r0, [r4, #0x2b0]
	ldrsh r0, [r0, #8]
	cmp r0, #7
	blt _02166868
	ldr r0, =_021744C0
	mov r1, #0
	ldr r0, [r0, #0x18]
	bl _fgr
	ldr r0, =0x45800000
	bls _021667AC
	ldr r1, =_021744C0
	ldr r1, [r1, #0x18]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021667C0
_021667AC:
	ldr r1, =_021744C0
	ldr r1, [r1, #0x18]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021667C0:
	bl _f_ftoi
	ldr r1, =_021744C0
	str r0, [r4]
	ldr r0, [r1, #0x24]
	mov r1, #0
	bl _fgr
	ldr r0, =0x45800000
	bls _021667FC
	ldr r1, =_021744C0
	ldr r1, [r1, #0x24]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02166810
_021667FC:
	ldr r1, =_021744C0
	ldr r1, [r1, #0x24]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02166810:
	bl _f_ftoi
	ldr r1, =_021744C0
	str r0, [r4, #0x1c]
	ldr r0, [r1, #0x28]
	mov r1, #0
	bl _fgr
	ldr r0, =0x45800000
	bls _0216684C
	ldr r1, =_021744C0
	ldr r1, [r1, #0x28]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02166860
_0216684C:
	ldr r1, =_021744C0
	ldr r1, [r1, #0x28]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02166860:
	bl _f_ftoi
	str r0, [r4, #0x20]
_02166868:
	ldr r0, [r4, #0x2b0]
	ldrsh r0, [r0, #8]
	cmp r0, #0x10
	blt _02166968
	ldr r0, =_021744C0
	mov r1, #0
	ldr r0, [r0, #0x30]
	bl _fgr
	ldr r0, =0x45800000
	bls _021668AC
	ldr r1, =_021744C0
	ldr r1, [r1, #0x30]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021668C0
_021668AC:
	ldr r1, =_021744C0
	ldr r1, [r1, #0x30]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021668C0:
	bl _f_ftoi
	ldr r1, =_021744C0
	str r0, [r4]
	ldr r0, [r1, #0x3c]
	mov r1, #0
	bl _fgr
	ldr r0, =0x45800000
	bls _021668FC
	ldr r1, =_021744C0
	ldr r1, [r1, #0x3c]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02166910
_021668FC:
	ldr r1, =_021744C0
	ldr r1, [r1, #0x3c]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02166910:
	bl _f_ftoi
	ldr r1, =_021744C0
	str r0, [r4, #0x1c]
	ldr r0, [r1, #0x40]
	mov r1, #0
	bl _fgr
	ldr r0, =0x45800000
	bls _0216694C
	ldr r1, =_021744C0
	ldr r1, [r1, #0x40]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02166960
_0216694C:
	ldr r1, =_021744C0
	ldr r1, [r1, #0x40]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02166960:
	bl _f_ftoi
	str r0, [r4, #0x20]
_02166968:
	ldr r0, [r4, #0x2b0]
	mov r2, #0
	ldrsh r1, [r0, #8]
	mov r0, #0x2000
	strh r1, [r4, #0x18]
	ldr r1, [r4, #0x2b0]
	strh r2, [r1, #8]
	ldr r1, [r4, #0x2b0]
	ldr r1, [r1, #0x350]
	str r1, [r4, #0x13c]
	ldr r1, [r4, #0x2b0]
	ldr r1, [r1, #0x354]
	add r1, r1, #0xa000
	str r1, [r4, #0x140]
	ldr r1, [r4, #0]
	str r1, [r4, #0x148]
	ldr r1, [r4, #0]
	str r1, [r4, #0x14c]
	str r0, [r4, #8]
	bl GetExTaskCurrent
	ldr r1, =exEffectBlzFireTask__Main_21669D4
	str r1, [r0]
	bl exEffectBlzFireTask__Main_21669D4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBlzFireTask__Main_21669D4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x10
	bl exDrawReqTask__Sprite3D__Animate
	ldr r1, [r4, #0x140]
	ldr r0, [r4, #8]
	add r0, r1, r0
	str r0, [r4, #0x140]
	ldrb r0, [r4, #0x16]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _02166A3C
	mov r4, #0x24
	sub r1, r4, #0x25
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	add sp, sp, #8
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02166A3C:
	ldr r1, [r4, #0x13c]
	cmp r1, #0x5a000
	bge _02166A64
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _02166A64
	ldr r0, [r4, #0x140]
	cmp r0, #0x96000
	blt _02166A78
_02166A64:
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	add sp, sp, #8
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02166A78:
	add r0, r4, #0x10
	add r1, r4, #0x160
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x10
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL exEffectBlzFireTask__Create(EX_ACTION_NN_WORK *parent)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x2b8
	mov r6, r0
	ldr r0, =aExeffectblzfir
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =exEffectBlzFireTask__Main
	ldr r1, =exEffectBlzFireTask__Destructor
	mov r2, #0x2000
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x2b8
	bl MI_CpuFill8
	str r6, [r4, #0x2b0]
	bl GetCurrentTask
	str r0, [r4, #0x2b4]
	mov r0, r5
	bl GetExTask
	ldr r1, =exEffectBlzFireTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exExEffectBlzFireTaMeTask__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	str r0, [r1, #0x1c]
	add r0, r4, #8
	bl exExEffectBlzFireTaMeTask__LoadFireTaMeAssets
	add r0, r4, #0x394
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x394
	bl exDrawReqTask__Func_2164218
	mov r0, #0x1000
	str r0, [r4]
	bl AllocSndHandle
	str r0, [r4, #4]
	mov r0, #0
	str r0, [sp]
	mov r1, #0x20
	str r1, [sp, #4]
	ldr r0, [r4, #4]
	sub r1, r1, #0x21
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, =exExEffectBlzFireTaMeTask__Main_Active
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exExEffectBlzFireTaMeTask__Func8(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exExEffectBlzFireTaMeTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #4]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	ldr r0, [r4, #4]
	bl FreeSndHandle
	add r0, r4, #8
	bl exExEffectBlzFireTaMeTask__ReleaseFireTaMeAssets
	ldr r0, =exExEffectBlzFireTaMeTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x1c]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exExEffectBlzFireTaMeTask__Main_Active(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #8
	bl exDrawReqTask__Model__Animate
	ldr r0, [r4, #0x4e4]
	ldrh r0, [r0, #0x1c]
	add r0, r0, #0xfa
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _02166D90
	ldr r0, =_021744C0
	mov r1, #0
	ldr r0, [r0, #0x78]
	bl _fgr
	ldr r0, =0x45800000
	bls _02166C84
	ldr r1, =_021744C0
	ldr r1, [r1, #0x78]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02166C98
_02166C84:
	ldr r1, =_021744C0
	ldr r1, [r1, #0x78]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02166C98:
	bl _f_ftoi
	ldr r1, [r4, #0]
	cmp r1, r0
	blt _02166CFC
	ldr r0, =_021744C0
	mov r1, #0
	ldr r0, [r0, #0x78]
	bl _fgr
	ldr r0, =0x45800000
	bls _02166CDC
	ldr r1, =_021744C0
	ldr r1, [r1, #0x78]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02166CF0
_02166CDC:
	ldr r1, =_021744C0
	ldr r1, [r1, #0x78]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02166CF0:
	bl _f_ftoi
	str r0, [r4]
	b _02166D90
_02166CFC:
	ldr r1, =_021744C0
	ldr r0, [r1, #0x78]
	ldr r1, [r1, #0x48]
	bl _f_sub
	ldr r1, =0x42F00000
	bl _fdiv
	mov r1, #0
	bl _fgr
	bls _02166D54
	ldr r1, =_021744C0
	ldr r0, [r1, #0x78]
	ldr r1, [r1, #0x48]
	bl _f_sub
	ldr r1, =0x42F00000
	bl _fdiv
	mov r1, r0
	ldr r0, =0x45800000
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02166D80
_02166D54:
	ldr r1, =_021744C0
	ldr r0, [r1, #0x78]
	ldr r1, [r1, #0x48]
	bl _f_sub
	ldr r1, =0x42F00000
	bl _fdiv
	mov r1, r0
	ldr r0, =0x45800000
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02166D80:
	bl _f_ftoi
	ldr r1, [r4, #0]
	add r0, r1, r0
	str r0, [r4]
_02166D90:
	ldr r0, [r4, #0x4e4]
	ldr r0, [r0, #0x350]
	str r0, [r4, #0x358]
	ldr r0, [r4, #0x4e4]
	ldr r0, [r0, #0x354]
	str r0, [r4, #0x35c]
	ldr r0, [r4, #0x4e4]
	ldr r0, [r0, #0x358]
	str r0, [r4, #0x360]
	ldr r0, [r4, #0]
	str r0, [r4, #0x370]
	ldr r0, [r4, #0]
	str r0, [r4, #0x374]
	ldr r0, [r4, #0]
	str r0, [r4, #0x378]
	ldr r0, [r4, #0x4e4]
	ldrh r0, [r0, #0x1c]
	cmp r0, #6
	cmpne r0, #7
	cmpne r0, #8
	beq _02166DF4
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02166DF4:
	add r0, r4, #8
	add r1, r4, #0x394
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL exExEffectBlzFireTaMeTask__Create(EX_ACTION_NN_WORK *parent)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, =0x000004EC
	str r4, [sp]
	mov r6, r0
	ldr r0, =aExexeffectblzf
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =exExEffectBlzFireTaMeTask__Main
	ldr r1, =exExEffectBlzFireTaMeTask__Destructor
	mov r2, #0x2000
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, =0x000004EC
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	str r6, [r4, #0x4e4]
	bl GetCurrentTask
	str r0, [r4, #0x4e8]
	mov r0, r5
	bl GetExTask
	ldr r1, =exExEffectBlzFireTaMeTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBlzFireShotTask__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, =0x021764E8
	str r0, [r1, #0x3c]
	add r0, r4, #4
	bl exEffectBlzFireTask__LoadFireShotAssets
	add r0, r4, #0x390
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, =exEffectBlzFireShotTask__Main_Charge
	str r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBlzFireShotTask__Func8(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBlzFireShotTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #4
	bl exEffectBlzFireTask__ReleaseFireShotAssets
	ldr r0, =0x021764E8
	mov r1, #0
	str r1, [r0, #0x3c]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBlzFireShotTask__Main_Charge(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
	ldr r1, [r4, #0x4e0]
	add r0, r4, #4
	ldr r1, [r1, #0x350]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x354]
	add r1, r1, #0x5000
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x358]
	str r1, [r4, #0x35c]
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02166FA4
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02166FA4:
	add r0, r4, #4
	add r1, r4, #0x390
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC BOOL exEffectBlzFireShotTask__Create(EX_ACTION_NN_WORK *parent)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, =0x000004E8
	str r4, [sp]
	mov r6, r0
	ldr r0, =aExeffectblzfir_0
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =exEffectBlzFireShotTask__Main
	ldr r1, =exEffectBlzFireShotTask__Destructor
	mov r2, #0x2000
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, =0x000004E8
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	str r6, [r4, #0x4e0]
	bl GetCurrentTask
	str r0, [r4, #0x4e4]
	mov r0, r5
	bl GetExTask
	ldr r1, =exEffectBlzFireShotTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}