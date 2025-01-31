#include <ex/effects/exBarrier.h>
#include <ex/effects/exBarrierHitEffect.h>
#include <ex/player/exPlayer.h>
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
    s16 exEffectBarrierHitTask__ActiveInstanceCount;
    s16 exEffectBarrierTask__ActiveInstanceCount;
    s16 exExEffectSonicBarrierTaMeTask__ActiveInstanceCount;

    void *exExEffectSonicBarrierTaMeTask__dword_217648C;
    void *exEffectBarrierTask__unk_2176490;
    void *exEffectBarrierTask__unk_2176494;
    void *exEffectBarrierHitTask__unk_2176498;
    void *exExEffectSonicBarrierTaMeTask__dword_217649C;
    void *exEffectBarrierHitTask__dword_21764A0;
    void *exExEffectSonicBarrierTaMeTask__unk_21764A4;
    void *exEffectBarrierHitTask__TaskSingleton;
    void *exEffectBarrierTask__TaskSingleton;
    void *exExEffectSonicBarrierTaMeTask__unk_21764B0;
    void *exEffectBarrierTask__dword_21764B4;
    void *exExEffectSonicBarrierTaMeTask__TaskSingleton;
    void *exEffectBarrierHitTask__unk_21764BC;
    void *exEffectBarrierHitTask__unk_21764C0;
    void *exEffectBarrierHitTask__unk_21764C4;
    void *exExEffectSonicBarrierTaMeTask__FileTable[2];
    void *exEffectBarrierHitTask__AnimTable[3];
    void *exEffectBarrierHitTask__FileTable[3];
};

NOT_DECOMPILED s16 exEffectBarrierHitTask__ActiveInstanceCount;
NOT_DECOMPILED s16 exEffectBarrierTask__ActiveInstanceCount;
NOT_DECOMPILED s16 exExEffectSonicBarrierTaMeTask__ActiveInstanceCount;

NOT_DECOMPILED void *exExEffectSonicBarrierTaMeTask__dword_217648C;
NOT_DECOMPILED void *exEffectBarrierTask__unk_2176490;
NOT_DECOMPILED void *exEffectBarrierTask__unk_2176494;
NOT_DECOMPILED void *exEffectBarrierHitTask__unk_2176498;
NOT_DECOMPILED void *exExEffectSonicBarrierTaMeTask__dword_217649C;
NOT_DECOMPILED void *exEffectBarrierHitTask__dword_21764A0;
NOT_DECOMPILED void *exExEffectSonicBarrierTaMeTask__unk_21764A4;
NOT_DECOMPILED void *exEffectBarrierHitTask__TaskSingleton;
NOT_DECOMPILED void *exEffectBarrierTask__TaskSingleton;
NOT_DECOMPILED void *exExEffectSonicBarrierTaMeTask__unk_21764B0;
NOT_DECOMPILED void *exEffectBarrierTask__dword_21764B4;
NOT_DECOMPILED void *exExEffectSonicBarrierTaMeTask__TaskSingleton;
NOT_DECOMPILED void *exEffectBarrierHitTask__unk_21764BC;
NOT_DECOMPILED void *exEffectBarrierHitTask__unk_21764C0;
NOT_DECOMPILED void *exEffectBarrierHitTask__unk_21764C4;
NOT_DECOMPILED void *exExEffectSonicBarrierTaMeTask__FileTable[2];
NOT_DECOMPILED void *exEffectBarrierHitTask__AnimTable[3];
NOT_DECOMPILED void *exEffectBarrierHitTask__FileTable[3];

NOT_DECOMPILED float _0217441C[];

NOT_DECOMPILED void *aExtraExBb_7;
NOT_DECOMPILED void *aExeffectbarrie;
NOT_DECOMPILED void *aExeffectbarrie_0;
NOT_DECOMPILED void *aExexeffectsoni;

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

NONMATCH_FUNC void exEffectBarrierHitTask__Func_2164950(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, =0x02176484
	mov r4, r0
	str r4, [r1, #0x14]
	ldr r0, [r1, #0x3c]
	cmp r0, #0
	ldrne r0, [r1, #0x38]
	cmpne r0, #0
	beq _021649CC
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, =0x02176484
	ldr r1, [r1, #0x3c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, =0x02176484
	ldr r1, [r1, #0x38]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, =0x02176484
	ldr r1, [r1, #0x3c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_021649CC:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, =0x02176484
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _02164A78
	mov r1, #0xa
	ldr r0, =aExtraExBb_7
	sub r2, r1, #0xb
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, =0x02176484
	mov r0, r0, lsr #8
	str r0, [r1, #0x3c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, =0x02176484
	mov r0, r5
	str r1, [r2, #0x1c]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x20
	bl LoadExSystemFile
	ldr r1, =0x02176484
	mov r2, #0
	str r0, [r1, #0x58]
	mov r0, #0x21
	str r2, [r1, #0x4c]
	bl LoadExSystemFile
	ldr r1, =0x02176484
	mov r2, #1
	str r0, [r1, #0x5c]
	mov r0, #0x22
	str r2, [r1, #0x50]
	bl LoadExSystemFile
	ldr r1, =0x02176484
	mov r2, #4
	str r0, [r1, #0x60]
	str r2, [r1, #0x54]
	ldr r0, [r1, #0x1c]
	bl Asset3DSetup__Create
_02164A78:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, =0x02176484
	str r2, [sp]
	ldr r1, [r0, #0x1c]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, =0x021764D0
	ldr r5, =0x021764DC
	mov r7, r8
_02164AB0:
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
	blo _02164AB0
	ldr r1, =0x02176484
	add r0, r4, #0x300
	ldr r2, [r1, #0x50]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x50]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_02164B04:
	mov r0, r2, lsl r3
	tst r0, #0x13
	beq _02164B24
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02164B24:
	add r3, r3, #1
	cmp r3, #5
	blo _02164B04
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
	ldr r1, =0x02176484
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
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBarrierHitTask__Destroy_2164BCC(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =0x02176484
	mov r4, r0
	ldrsh r0, [r1, #0]
	cmp r0, #1
	bgt _02164C50
	ldr r0, [r1, #0x1c]
	cmp r0, #0
	beq _02164BF4
	bl NNS_G3dResDefaultRelease
_02164BF4:
	ldr r0, =0x02176484
	ldr r0, [r0, #0x58]
	cmp r0, #0
	beq _02164C08
	bl NNS_G3dResDefaultRelease
_02164C08:
	ldr r0, =0x02176484
	ldr r0, [r0, #0x5c]
	cmp r0, #0
	beq _02164C1C
	bl NNS_G3dResDefaultRelease
_02164C1C:
	ldr r0, =0x02176484
	ldr r0, [r0, #0x60]
	cmp r0, #0
	beq _02164C30
	bl NNS_G3dResDefaultRelease
_02164C30:
	ldr r0, =0x02176484
	ldr r0, [r0, #0x1c]
	cmp r0, #0
	beq _02164C44
	bl _FreeHEAP_USER
_02164C44:
	ldr r0, =0x02176484
	mov r1, #0
	str r1, [r0, #0x1c]
_02164C50:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, =0x02176484
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBarrierHitTask__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, =0x02176484
	str r0, [r1, #0x24]
	add r0, r4, #0x10
	bl exEffectBarrierHitTask__Func_2164950
	add r0, r4, #0x39c
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x39c
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, =exEffectBarrierHitTask__Main_2164D08
	str r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBarrierHitTask__Func8(void)
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

NONMATCH_FUNC void exEffectBarrierHitTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0x10
	bl exEffectBarrierHitTask__Destroy_2164BCC
	ldr r0, =0x02176484
	mov r1, #0
	str r1, [r0, #0x24]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBarrierHitTask__Main_2164D08(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x10
	bl exDrawReqTask__Model__Animate
	ldr r1, [r4, #4]
	add r0, r4, #0x10
	str r1, [r4, #0x360]
	ldr r1, [r4, #8]
	str r1, [r4, #0x364]
	ldr r1, [r4, #0xc]
	str r1, [r4, #0x368]
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02164D54
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02164D54:
	add r0, r4, #0x10
	add r1, r4, #0x39c
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBarrierHitTask__Create(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	movs r4, r0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r5, #0
	ldr r1, =0x000004EC
	str r5, [sp]
	str r1, [sp, #4]
	ldr r0, =aExeffectbarrie
	ldr r1, =exEffectBarrierHitTask__Destructor
	str r0, [sp, #8]
	ldr r0, =exEffectBarrierHitTask__Main
	mov r2, #0x2000
	mov r3, #5
	str r5, [sp, #0xc]
	bl ExTaskCreate_
	mov r6, r0
	bl GetExTaskWork_
	mov r1, r5
	ldr r2, =0x000004EC
	mov r5, r0
	bl MI_CpuFill8
	ldr r1, [r4, #0]
	mov r0, r6
	str r1, [r5, #4]
	ldr r1, [r4, #4]
	str r1, [r5, #8]
	ldr r1, [r4, #8]
	str r1, [r5, #0xc]
	bl GetExTask
	ldr r1, =exEffectBarrierHitTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBarrierTask__Func_2164E1C(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r0
	bl exDrawReqTask__InitSprite3D
	ldr r0, =exEffectBarrierHitTask__ActiveInstanceCount
	ldrsh r0, [r0, #2]
	cmp r0, #0
	bne _02164E4C
	mov r0, #0
	bl LoadExSystemFile
	ldr r1, =exEffectBarrierHitTask__ActiveInstanceCount
	str r0, [r1, #0x30]
_02164E4C:
	ldr r0, =exEffectBarrierHitTask__ActiveInstanceCount
	mov r1, #1
	ldr r0, [r0, #0x30]
	bl Sprite__GetTextureSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocTexture
	ldr r1, =exEffectBarrierHitTask__ActiveInstanceCount
	mov r5, r0
	ldr r0, [r1, #0x30]
	mov r1, #1
	bl Sprite__GetPaletteSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #4
	stmia sp, {r1, r5}
	str r0, [sp, #8]
	ldr r2, =exEffectBarrierHitTask__ActiveInstanceCount
	mov r1, #0
	ldr r2, [r2, #0x30]
	add r0, r4, #0x20
	mov r3, r1
	bl AnimatorSprite3D__Init
	ldr r1, [r4, #0x114]
	mov r0, #2
	orr r1, r1, #0x800
	str r1, [r4, #0x114]
	strb r0, [r4]
	ldrb r2, [r4, #3]
	mov r1, #0x46000
	mov r0, #0x500
	orr r2, r2, #0x80
	strb r2, [r4, #3]
	str r1, [r4, #0x134]
	str r0, [r4, #0x138]
	str r0, [r4, #0x13c]
	mov r0, #0x1000
	str r0, [r4, #0x140]
	ldrb r2, [r4, #0x150]
	mov r1, #0x6400
	add r0, r4, #0x12c
	bic r2, r2, #3
	orr r2, r2, #1
	strb r2, [r4, #0x150]
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	str r1, [r4, #0x14]
	str r0, [r4, #0x18]
	ldr r0, =exEffectBarrierHitTask__ActiveInstanceCount
	ldrsh r1, [r0, #2]
	add r1, r1, #1
	strh r1, [r0, #2]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBarrierTask__Func_2164F24(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr ip, =AnimatorSprite__SetAnimation
	strh r1, [r0, #0x1c]
	add r0, r0, #0xb0
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBarrierTask__Destroy_2164F38(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	add r0, r0, #0x20
	bl AnimatorSprite3D__Release
	ldr r0, =exEffectBarrierHitTask__ActiveInstanceCount
	ldrsh r1, [r0, #2]
	sub r1, r1, #1
	strh r1, [r0, #2]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBarrierTask__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, =exEffectBarrierHitTask__ActiveInstanceCount
	str r0, [r1, #0x28]
	add r0, r4, #8
	bl exEffectBarrierTask__Func_2164E1C
	add r0, r4, #0x158
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x158
	bl exDrawReqTask__Func_21641F0
	ldrsh r0, [r4, #0]
	strh r0, [r4, #0x10]
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _02164FD4
	ldr r0, [r4, #0x2a8]
	ldrsh r0, [r0, #8]
	cmp r0, #0x12
	bne _02165008
	mov r0, #0x780
	str r0, [r4, #0x140]
	str r0, [r4, #0x144]
	mov r0, #0x9600
	str r0, [r4, #0x14]
	str r0, [r4, #0x18]
	b _02165008
_02164FD4:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	ldreq r0, [r4, #0x2a8]
	ldreqsh r0, [r0, #8]
	cmpeq r0, #0x15
	bne _02165008
	mov r0, #0x780
	str r0, [r4, #0x140]
	str r0, [r4, #0x144]
	mov r0, #0x9600
	str r0, [r4, #0x14]
	str r0, [r4, #0x18]
_02165008:
	mov r0, #0
	strh r0, [r4, #2]
	bl GetExTaskCurrent
	ldr r1, =exEffectBarrierTask__Main_2165074
	str r1, [r0]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBarrierTask__Func8(void)
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

NONMATCH_FUNC void exEffectBarrierTask__Destructor(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #8
	bl exEffectBarrierTask__Destroy_2164F38
	ldr r0, =exEffectBarrierHitTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x28]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBarrierTask__Main_2165074(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #8
	mov r1, #1
	bl exEffectBarrierTask__Func_2164F24
	add r0, r4, #0x158
	bl exDrawReqTask__Func_21641F0
	ldr r0, =exEffectBarrierHitTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0xc]
	ldr r0, [r4, #0x2a8]
	ldr r0, [r0, #0x350]
	str r0, [r4, #0x134]
	ldr r0, [r4, #0x2a8]
	ldr r0, [r0, #0x354]
	str r0, [r4, #0x138]
	bl GetExTaskCurrent
	ldr r1, =exEffectBarrierTask__Main_21650D4
	str r1, [r0]
	bl exEffectBarrierTask__Main_21650D4
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBarrierTask__Main_21650D4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #8
	bl exDrawReqTask__Sprite3D__Animate
	ldrb r0, [r4, #0xe]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _02165108
	add r0, r4, #0x134
	bl exEffectBarrierHitTask__Create
	bl exEffectBarrierTask__Func_2165150
	ldmia sp!, {r4, pc}
_02165108:
	add r0, r4, #8
	bl exDrawReqTask__Sprite3D__IsAnimFinished
	cmp r0, #0
	beq _02165128
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02165128:
	add r0, r4, #8
	add r1, r4, #0x158
	bl exDrawReqTask__AddRequest
	add r0, r4, #8
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBarrierTask__Func_2165150(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _02165218
	ldr r0, [r4, #0x2a8]
	ldrsh r0, [r0, #8]
	cmp r0, #0x12
	bne _021651F8
	mov r0, #0x680
	str r0, [r4, #0x140]
	str r0, [r4, #0x144]
	mov r0, #0x8200
	str r0, [r4, #0x14]
	str r0, [r4, #0x18]
	bl GetExTaskCurrent
	mov r1, #5
	strh r1, [r0, #0x1c]
	ldr r0, [r4, #0x2ac]
	bl GetExTask
	mov r1, #5
	strh r1, [r0, #0x1c]
	ldr r3, [r4, #0x2a8]
	mov ip, #0x10
	ldrb r2, [r3, #0x38c]
	sub r1, ip, #0x11
	mov r0, #0
	bic r2, r2, #0xf0
	orr r2, r2, #0x50
	strb r2, [r3, #0x38c]
	ldrb lr, [r4, #0x158]
	mov r2, r1
	mov r3, r1
	bic lr, lr, #0xf0
	orr lr, lr, #0x50
	strb lr, [r4, #0x158]
	stmia sp, {r0, ip}
	bl PlaySfxEx
	b _021652CC
_021651F8:
	mov ip, #0xf
	sub r1, ip, #0x10
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	b _021652CC
_02165218:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _021652CC
	ldr r0, [r4, #0x2a8]
	ldrsh r0, [r0, #8]
	cmp r0, #0x15
	bne _021652B0
	mov r0, #0x680
	str r0, [r4, #0x140]
	str r0, [r4, #0x144]
	mov r0, #0x8200
	str r0, [r4, #0x14]
	str r0, [r4, #0x18]
	bl GetExTaskCurrent
	mov r1, #5
	strh r1, [r0, #0x1c]
	ldr r0, [r4, #0x2ac]
	bl GetExTask
	mov r1, #5
	strh r1, [r0, #0x1c]
	ldr r3, [r4, #0x2a8]
	mov ip, #0x10
	ldrb r2, [r3, #0x38c]
	sub r1, ip, #0x11
	mov r0, #0
	bic r2, r2, #0xf0
	orr r2, r2, #0x50
	strb r2, [r3, #0x38c]
	ldrb lr, [r4, #0x158]
	mov r2, r1
	mov r3, r1
	bic lr, lr, #0xf0
	orr lr, lr, #0x50
	strb lr, [r4, #0x158]
	stmia sp, {r0, ip}
	bl PlaySfxEx
	b _021652CC
_021652B0:
	mov ip, #0xf
	sub r1, ip, #0x10
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
_021652CC:
	add r0, r4, #8
	mov r1, #2
	bl exEffectBarrierTask__Func_2164F24
	add r0, r4, #0x158
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, =exEffectBarrierTask__Main_21652FC
	str r1, [r0]
	bl exEffectBarrierTask__Main_21652FC
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBarrierTask__Main_21652FC(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #8
	bl exDrawReqTask__Sprite3D__Animate
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _02165344
	ldr r1, [r4, #0x2a8]
	ldrsh r0, [r1, #8]
	cmp r0, #0x12
	bne _02165370
	add r0, r1, #0x38c
	bl exDrawReqTask__Func_21642BC
	add r0, r4, #0x158
	bl exDrawReqTask__Func_21642BC
	b _02165370
_02165344:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	ldreq r1, [r4, #0x2a8]
	ldreqsh r0, [r1, #8]
	cmpeq r0, #0x15
	bne _02165370
	add r0, r1, #0x38c
	bl exDrawReqTask__Func_21642BC
	add r0, r4, #0x158
	bl exDrawReqTask__Func_21642BC
_02165370:
	add r0, r4, #8
	bl exDrawReqTask__Sprite3D__IsAnimFinished
	cmp r0, #0
	beq _021653AC
	ldr r1, [r4, #0x2a8]
	ldrb r0, [r1, #0x38c]
	bic r0, r0, #0xf0
	strb r0, [r1, #0x38c]
	ldrb r0, [r4, #0x158]
	bic r0, r0, #0xf0
	strb r0, [r4, #0x158]
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021653AC:
	add r0, r4, #8
	add r1, r4, #0x158
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBarrierTask__DelayCallback(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #0x2a8]
	add r0, r0, #0x38c
	bl exDrawReqTask__Func_21642BC
	add r0, r4, #0x158
	bl exDrawReqTask__Func_21642BC
	add r0, r4, #8
	add r1, r4, #0x158
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exEffectBarrierTask__Create(EX_ACTION_NN_WORK *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	ldr r1, =exEffectBarrierHitTask__ActiveInstanceCount
	mov r5, r0
	ldr r0, [r1, #0xc]
	cmp r0, #0
	addne sp, sp, #0x10
	ldmneia sp!, {r4, r5, r6, pc}
	mov r4, #0
	str r4, [sp]
	mov r1, #0x2b0
	ldr r0, =aExeffectbarrie_0
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =exEffectBarrierTask__Main
	ldr r1, =exEffectBarrierTask__Destructor
	mov r2, #0x2000
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	ldr r1, =exEffectBarrierHitTask__ActiveInstanceCount
	mov r2, #1
	mov r4, r0
	str r2, [r1, #0xc]
	bl GetExTaskWork_
	mov r6, r0
	mov r1, #0
	mov r2, #0x2b0
	bl MI_CpuFill8
	str r5, [r6, #0x2a8]
	bl GetCurrentTask
	str r0, [r6, #0x2ac]
	ldr r1, [r6, #0x2a8]
	mov r0, r4
	ldrsh r1, [r1, #8]
	strh r1, [r6]
	bl GetExTask
	ldr r1, =exEffectBarrierTask__Func8
	str r1, [r0, #8]
	mov r0, r4
	bl GetExTask
	ldr r1, =exEffectBarrierTask__DelayCallback
	str r1, [r0, #0x10]
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exExEffectSonicBarrierTaMeTask__Func_21654D4(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, =0x02176484
	mov r4, r0
	str r4, [r1, #0x2c]
	ldr r0, [r1, #8]
	cmp r0, #0
	ldrne r0, [r1, #0x20]
	cmpne r0, #0
	beq _02165540
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, =0x02176484
	ldr r1, [r1, #8]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, =0x02176484
	ldr r1, [r1, #0x20]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, =0x02176484
	ldr r1, [r1, #8]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
_02165540:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, =0x02176484
	ldrsh r0, [r0, #4]
	cmp r0, #0
	bne _021655C4
	mov r1, #0x1e
	ldr r0, =aExtraExBb_7
	sub r2, r1, #0x1f
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, =0x02176484
	mov r0, r0, lsr #8
	str r0, [r1, #8]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, =0x02176484
	mov r0, r5
	str r1, [r2, #0x18]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x4f
	bl LoadExSystemFile
	ldr r1, =0x02176484
	str r0, [r1, #0x44]
	mov r0, #0x50
	bl LoadExSystemFile
	ldr r1, =0x02176484
	str r0, [r1, #0x48]
	ldr r0, [r1, #0x18]
	bl Asset3DSetup__Create
_021655C4:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, =0x02176484
	str r2, [sp]
	ldr r1, [r0, #0x18]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r1, #0
	ldr r0, =0x02176484
	str r1, [sp]
	ldr r2, [r0, #0x44]
	mov r3, r1
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	mov r3, #0
	ldr r2, =0x02176484
	str r3, [sp]
	ldr r2, [r2, #0x48]
	add r0, r4, #0x20
	mov r1, #4
	bl AnimatorMDL__SetAnimation
	add r0, r4, #0x300
	mov r3, #0
	strh r3, [r0, #0x48]
	ldr r0, [r4, #0x104]
	mov r2, #1
	str r0, [r4, #0x344]
_0216563C:
	mov r0, r2, lsl r3
	tst r0, #0x11
	beq _0216565C
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0216565C:
	add r3, r3, #1
	cmp r3, #5
	blo _0216563C
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
	ldr r1, =0x02176484
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
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exExEffectSonicBarrierTaMeTask__Destroy_21656F8(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, =0x02176484
	mov r4, r0
	ldrsh r0, [r1, #4]
	cmp r0, #1
	bgt _02165768
	ldr r0, [r1, #0x18]
	cmp r0, #0
	beq _02165720
	bl NNS_G3dResDefaultRelease
_02165720:
	ldr r0, =0x02176484
	ldr r0, [r0, #0x44]
	cmp r0, #0
	beq _02165734
	bl NNS_G3dResDefaultRelease
_02165734:
	ldr r0, =0x02176484
	ldr r0, [r0, #0x48]
	cmp r0, #0
	beq _02165748
	bl NNS_G3dResDefaultRelease
_02165748:
	ldr r0, =0x02176484
	ldr r0, [r0, #0x18]
	cmp r0, #0
	beq _0216575C
	bl _FreeHEAP_USER
_0216575C:
	ldr r0, =0x02176484
	mov r1, #0
	str r1, [r0, #0x18]
_02165768:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, =0x02176484
	ldrsh r1, [r0, #4]
	sub r1, r1, #1
	strh r1, [r0, #4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exExEffectSonicBarrierTaMeTask__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, =0x02176484
	str r0, [r1, #0x34]
	add r0, r4, #8
	bl exExEffectSonicBarrierTaMeTask__Func_21654D4
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
	ldr r1, =exExEffectSonicBarrierTaMeTask__Main_2165874
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exExEffectSonicBarrierTaMeTask__Func8(void)
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

NONMATCH_FUNC void exExEffectSonicBarrierTaMeTask__Destructor(void)
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
	bl exExEffectSonicBarrierTaMeTask__Destroy_21656F8
	ldr r0, =0x02176484
	mov r1, #0
	str r1, [r0, #0x34]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exExEffectSonicBarrierTaMeTask__Main_2165874(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #8
	bl exDrawReqTask__Model__Animate
	bl GetExPlayerWorker
	ldrsh r0, [r0, #0x44]
	cmp r0, #0
	beq _021659DC
	ldr r0, =_0217441C
	mov r1, #0
	ldr r0, [r0, #0x30]
	bl _fgr
	ldr r0, =0x45800000
	bls _021658CC
	ldr r1, =_0217441C
	ldr r1, [r1, #0x30]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021658E0
_021658CC:
	ldr r1, =_0217441C
	ldr r1, [r1, #0x30]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021658E0:
	bl _f_ftoi
	ldr r1, [r4, #0]
	cmp r1, r0
	blt _02165944
	ldr r0, =_0217441C
	mov r1, #0
	ldr r0, [r0, #0x30]
	bl _fgr
	ldr r0, =0x45800000
	bls _02165924
	ldr r1, =_0217441C
	ldr r1, [r1, #0x30]
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02165938
_02165924:
	ldr r1, =_0217441C
	ldr r1, [r1, #0x30]
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02165938:
	bl _f_ftoi
	str r0, [r4]
	b _021659EC
_02165944:
	ldr r1, =_0217441C
	ldr r0, [r1, #0x30]
	ldr r1, [r1, #0]
	bl _f_sub
	ldr r1, =0x42F00000
	bl _fdiv
	mov r1, #0
	bl _fgr
	bls _0216599C
	ldr r1, =_0217441C
	ldr r0, [r1, #0x30]
	ldr r1, [r1, #0]
	bl _f_sub
	ldr r1, =0x42F00000
	bl _fdiv
	mov r1, r0
	ldr r0, =0x45800000
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021659C8
_0216599C:
	ldr r1, =_0217441C
	ldr r0, [r1, #0x30]
	ldr r1, [r1, #0]
	bl _f_sub
	ldr r1, =0x42F00000
	bl _fdiv
	mov r1, r0
	ldr r0, =0x45800000
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021659C8:
	bl _f_ftoi
	ldr r1, [r4, #0]
	add r0, r1, r0
	str r0, [r4]
	b _021659EC
_021659DC:
	bl GetExTaskCurrent
	ldr r1, =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021659EC:
	ldr r1, [r4, #0x4e4]
	add r0, r4, #8
	ldr r2, [r1, #0x350]
	add r1, r4, #0x394
	str r2, [r4, #0x358]
	ldr r2, [r4, #0x4e4]
	ldr r2, [r2, #0x354]
	str r2, [r4, #0x35c]
	ldr r2, [r4, #0x4e4]
	ldr r2, [r2, #0x358]
	str r2, [r4, #0x360]
	ldr r2, [r4, #0]
	str r2, [r4, #0x370]
	ldr r2, [r4, #0]
	str r2, [r4, #0x374]
	ldr r2, [r4, #0]
	str r2, [r4, #0x378]
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void exExEffectSonicBarrierTaMeTask__Create(EX_ACTION_NN_WORK *work)
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
	ldr r0, =aExexeffectsoni
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, =exExEffectSonicBarrierTaMeTask__Main
	ldr r1, =exExEffectSonicBarrierTaMeTask__Destructor
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
	ldr r1, =exExEffectSonicBarrierTaMeTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}